# freeze version
FROM debian:bookworm

ARG VENDOR_CERT="zeetim-uefi-ca.der"
ENV SHIM_VERSION=16.0
ENV BUILD_DIR="/build"
ENV PATCHES_DIR="shim-patches"
ENV DEBIAN_FRONTEND=noninteractive
ARG OUTPUT_DIR=${BUILD_DIR}/output

RUN apt update -y
RUN apt install tar bzip2 efitools wget gcc make binutils quilt -y

RUN mkdir -p ${BUILD_DIR}
WORKDIR ${BUILD_DIR}

RUN wget https://github.com/rhboot/shim/releases/download/${SHIM_VERSION}/shim-${SHIM_VERSION}.tar.bz2
RUN tar xf shim-${SHIM_VERSION}.tar.bz2

WORKDIR ${BUILD_DIR}/shim-${SHIM_VERSION}

ADD ${VENDOR_CERT} .
COPY ${PATCHES_DIR}/ patches/

RUN echo shim.zeetim,1,Zeetim,shim,${SHIM_VERSION},mail:contact@zeetim.com >> data/sbat.csv
RUN cat data/sbat.csv

RUN quilt push -a

RUN make VENDOR_CERT_FILE=${VENDOR_CERT} DISABLE_FALLBACK=1 DISABLE_MOK=1 POST_PROCESS_PE_FLAGS=-n MOK_POLICY=MOK_POLICY_REQUIRE_NX

RUN mkdir -p ${OUTPUT_DIR}
RUN cp shimx64.efi ${OUTPUT_DIR}/shimx64.efi
WORKDIR ${OUTPUT_DIR}

RUN objcopy --only-section .sbat -O binary shimx64.efi /dev/stdout
RUN objdump -x shimx64.efi | grep -E 'SectionAlignment|DllCharacteristics'
RUN sha256sum shimx64.efi