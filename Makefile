SHELL = /bin/bash
CONTAINER := shim-review
LOG_FILE := build.log
SHIM_IMAGE := shimx64.efi
VENDOR_CERT:= zeetim-uefi-ca.cer
SHIM_VERSION := 16.0
SHIM_BUILD_OPTIONS:= "DISABLE_FALLBACK=1 DISABLE_MOK=1 POST_PROCESS_PE_FLAGS=-n MOK_POLICY=MOK_POLICY_REQUIRE_NX"

DOCKER_ARGS := -t $(CONTAINER) \
	--build-arg VENDOR_CERT=$(VENDOR_CERT) \
	--build-arg SHIM_VERSION=$(SHIM_VERSION) \
	--build-arg SHIM_BUILD_OPTIONS=$(SHIM_BUILD_OPTIONS) \
	--build-arg SHIM_IMAGE=$(SHIM_IMAGE)

DOCKER_OPTIONS := --progress=plain --no-cache

.PHONY: build
build: Dockerfile
	@docker build $(DOCKER_ARGS) $(DOCKER_OPTIONS) . 2>&1 | tee $(LOG_FILE); \
	if [ $${PIPESTATUS[0]} -ne 0 ]; then \
		echo "Docker build failed!"; \
		exit 1; \
	fi; \
	id=$$(docker create $(CONTAINER)); \
	docker cp $$id:/$(SHIM_IMAGE) .; \
	docker rm $$id

.PHONY: clean
clean:
	@-docker rmi $(CONTAINER) --force
	@-rm $(LOG_FILE)
	@-rm $(SHIM_IMAGE)