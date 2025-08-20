FROM debian:trixie-slim

ARG SHIM_VERSION="16.1"
ARG SHIM_SHA256_CHECKSUM="46319cd228d8f2c06c744241c0f342412329a7c630436fce7f82cf6936b1d603"
ARG SHIM_REVIEW_TAG="zeetim-shim-x64-2025-08-20"
ARG SHIM_BUILD_OPTIONS="DISABLE_FALLBACK=1 DISABLE_MOK=1 POST_PROCESS_PE_FLAGS=-n MOK_POLICY=MOK_POLICY_REQUIRE_NX"
ENV SHIM_IMAGE="shimx64.efi"
ENV BUILD_DIR="/build"
ENV SHIM_REVIEW="https://github.com/zeetim/shim-review.git"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y
RUN apt install tar bzip2 wget gcc make binutils quilt git -y

RUN mkdir -p ${BUILD_DIR}
WORKDIR ${BUILD_DIR}

RUN wget https://github.com/rhboot/shim/releases/download/${SHIM_VERSION}/shim-${SHIM_VERSION}.tar.bz2
RUN echo "${SHIM_SHA256_CHECKSUM}  shim-${SHIM_VERSION}.tar.bz2" | sha256sum -c -
RUN tar xf shim-${SHIM_VERSION}.tar.bz2

RUN git clone ${SHIM_REVIEW} --branch ${SHIM_REVIEW_TAG} shim-review

WORKDIR ${BUILD_DIR}/shim-${SHIM_VERSION}

RUN echo shim.zeetim,1,Zeetim,shim,${SHIM_VERSION},mail:contact@zeetim.com >> data/sbat.csv

RUN QUILT_PATCHES=../shim-review/shim-patches quilt push -a

RUN make VENDOR_CERT_FILE=../shim-review/zeetim-uefi-ca.cer ${SHIM_BUILD_OPTIONS}

RUN cp shimx64.efi ${BUILD_DIR}/${SHIM_IMAGE}
WORKDIR ${BUILD_DIR}

RUN objcopy --only-section .sbat -O binary ${SHIM_IMAGE} /dev/stdout
RUN objdump -x ${SHIM_IMAGE} | grep -E 'SectionAlignment|DllCharacteristics'
RUN sha256sum ${SHIM_IMAGE}
