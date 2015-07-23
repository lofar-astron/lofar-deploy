# Write a header
define write_header
	@echo "#"      >> ${DOCKERFILE}
	@echo "#" $(1) >> ${DOCKERFILE}
	@echo "#"      >> ${DOCKERFILE}
endef
