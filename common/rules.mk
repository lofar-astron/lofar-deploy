# Set default shell
SHELL=/bin/bash

# Rule to create a Dockerfile
dockerfile:
	$(call docker-file,${BASE})

# Rule to build a container
build:
	$(call docker-file,${BASE})
	$(call docker-build)

# Rule to create a Dockerfile with tests
test:
	$(call docker-test-file,${BASE})

# Rule to build and test a container
build-test:
	$(call docker-test-file,${BASE})
	$(call docker-build)

# Rule to create a deploy script
script:
	$(call deploy-file)
