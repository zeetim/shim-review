# freeze version
FROM debian:bookworm

ARG VENDOR_CERT
ARG SHIM_VERSION
ARG SHIM_BUILD_OPTIONS
ARG SHIM_IMAGE="shimx64.efi"
ENV BUILD_DIR="/build"
ENV PATCHES_DIR="shim-patches"
ENV DEBIAN_FRONTEND=noninteractive
ENV REQUIRED_ARGS="VENDOR_CERT SHIM_VERSION"

# Validate that all required arguments are set
RUN for arg in $REQUIRED_ARGS; do \
    eval "value=\$$arg"; \
    if [ -z "$value" ]; then \
        echo "Error: $arg build argument is required but not set."; \
        exit 1; \
    fi; \
done

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

RUN quilt push -a

RUN make VENDOR_CERT_FILE=${VENDOR_CERT} ${SHIM_BUILD_OPTIONS}

RUN cp shimx64.efi /${SHIM_IMAGE}
WORKDIR /

RUN objcopy --only-section .sbat -O binary ${SHIM_IMAGE} /dev/stdout
RUN objdump -x ${SHIM_IMAGE} | grep -E 'SectionAlignment|DllCharacteristics'
RUN sha256sum ${SHIM_IMAGE}