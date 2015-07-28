# Write a header
define write-header
	@echo "#"      >> $(2)
	@echo "#" $(1) >> $(2)
	@echo "#"      >> $(2)
endef
