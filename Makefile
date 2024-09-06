CONTAINER := shim-review
LOG_FILE := build.log
OUTPUT_DIR := /output
SHIM_IMAGE := shimx64.efi

DOCKER_ARGS := -t $(CONTAINER) --progress=plain --build-arg OUTPUT_DIR=$(OUTPUT_DIR) --no-cache

.PHONY: build
build: Dockerfile
	@docker build $(DOCKER_ARGS) . 2>&1 | tee $(LOG_FILE) ; \
	id=$$(docker create $(CONTAINER)); \
	docker cp $$id:$(OUTPUT_DIR)/$(SHIM_IMAGE) . ; \
	docker rm $$id

.PHONY: clean
clean:
	@-docker rmi $(CONTAINER) --force
	@-rm $(LOG_FILE)
	@-rm $(SHIM_IMAGE)