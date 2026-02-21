
##############################################################
#
# LDD
#
##############################################################

# Reference assignment 7 git contents
LDD_VERSION = '80601165fe2e9bb0b8bc46332eaffe1d5e37bb46'
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
LDD_SITE = 'git@github.com:cu-ecen-aeld/assignment-7-AuFries.git'
LDD_SITE_METHOD = git
LDD_GIT_SUBMODULES = YES

define LDD_BUILD_CMDS
	$(MAKE) $(LINUX_MAKE_FLAGS) -C $(LINUX_DIR) M=$(@D)/misc-modules modules
	$(MAKE) $(LINUX_MAKE_FLAGS) -C $(LINUX_DIR) M=$(@D)/scull modules
endef

define LDD_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/extra

	$(INSTALL) -m 0644 $(@D)/misc-modules/hello.ko  $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/extra/
	$(INSTALL) -m 0644 $(@D)/misc-modules/faulty.ko $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/extra/
	$(INSTALL) -m 0644 $(@D)/scull/scull.ko         $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/extra/

	# Load/unload scripts
	$(INSTALL) -d $(TARGET_DIR)/usr/bin/ldd
	$(INSTALL) -m 0755 $(@D)/misc-modules/module_load   $(TARGET_DIR)/usr/bin/ldd/
	$(INSTALL) -m 0755 $(@D)/misc-modules/module_unload $(TARGET_DIR)/usr/bin/ldd/
	$(INSTALL) -m 0755 $(@D)/scull/scull_load          $(TARGET_DIR)/usr/bin/ldd/
	$(INSTALL) -m 0755 $(@D)/scull/scull_unload        $(TARGET_DIR)/usr/bin/ldd/

	# Init script
	$(INSTALL) -m 0755 $(@D)/assignment7/lddmodules-start-stop.sh $(TARGET_DIR)/etc/init.d/S98lddmodules
endef

$(eval $(generic-package))
