# Write a header
define write-header
	@echo "#"      >> $(2)
	@echo "#" $(1) >> $(2)
	@echo "#"      >> $(2)
endef

# Add number of threads as J flag
define set-build-options
	$(call write-header,$(0),$(1))
	@$(eval J = `cat /proc/cpuinfo | grep processor | wc -l`)
	@echo "ENV J ${J}" >> ${1}
	@echo "" >> ${1}
endef
