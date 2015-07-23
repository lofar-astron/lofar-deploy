# Rule to create a Dockerfile
dockerfile:
	$(call docker-file,${BASE})

# Rule to build a container
build:
	$(call docker-file,${BASE})
	$(call docker-build)
