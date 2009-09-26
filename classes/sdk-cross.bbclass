# Cross packages are built indirectly via dependency, no need for them
# to be a direct target of 'world'
EXCLUDE_FROM_WORLD = "1"

# No default packages
PACKAGES = ""

# Set host=build
HOST_ARCH		= "${BUILD_ARCH}"
HOST_CPU		= "${BUILD_CPU}"
HOST_VENDOR		= "${BUILD_VENDOR}"
HOST_OS			= "${BUILD_OS}"
HOST_CC_ARCH		= "${BUILD_CC_ARCH}"
HOST_EXEEXT		= "${BUILD_EXEEXT}"
HOST_PREFIX		= "${BUILD_PREFIX}"

# and target=sdk to get architecture triplet build/build/sdk
TARGET_ARCH		= "${SDK_ARCH}"
TARGET_CPU		= "${SDK_CPU}"
TARGET_VENDOR		= "${SDK_VENDOR}"
TARGET_OS		= "${SDK_OS}"
TARGET_CC_ARCH		= "${SDK_CC_ARCH}"
TARGET_EXEEXT		= "${SDK_EXEEXT}"
TARGET_PREFIX		= "${SDK_PREFIX}"

# Use build compiler/linker flags
CPPFLAGS		= "${BUILD_CPPFLAGS}"
CFLAGS			= "${BUILD_CFLAGS}"
CXXFLAGS		= "${BUILD_CFLAGS}"
LDFLAGS			= "${BUILD_LDFLAGS}"

# Build and install to STAGING_DIR/TARGET_ARCH
base_prefix	= "${STAGING_DIR}/${SDK_ARCH}${layout_base_prefix}"
prefix		= "${STAGING_DIR}/${SDK_ARCH}${layout_prefix}"
exec_prefix	= "${STAGING_DIR}/${SDK_ARCH}${layout_exec_prefix}"
base_bindir	= "${STAGING_DIR}/${SDK_ARCH}${layout_base_bindir}"
base_sbindir	= "${STAGING_DIR}/${SDK_ARCH}${layout_base_sbindir}"
base_libdir	= "${STAGING_DIR}/${SDK_ARCH}${layout_base_libdir}"
sysconfdir	= "${STAGING_DIR}/${SDK_ARCH}${layout_sysconfdir}"
localstatedir	= "${STAGING_DIR}/${SDK_ARCH}${layout_localstatedir}"
servicedir	= "${STAGING_DIR}/${SDK_ARCH}${layout_servicedir}"
sharedstatedir	= "${STAGING_DIR}/${SDK_ARCH}${layout_sharedstatedir}"
datadir		= "${STAGING_DIR}/${SDK_ARCH}${layout_datadir}"
infodir		= "${STAGING_DIR}/${SDK_ARCH}${layout_infodir}"
mandir		= "${STAGING_DIR}/${SDK_ARCH}${layout_mandir}"
docdir		= "${STAGING_DIR}/${SDK_ARCH}${layout_docdir}"
bindir		= "${STAGING_DIR}/${SDK_ARCH}${layout_bindir}"
sbindir		= "${STAGING_DIR}/${SDK_ARCH}${layout_sbindir}"
libdir		= "${STAGING_DIR}/${SDK_ARCH}${layout_libdir}"
libexecdir	= "${STAGING_DIR}/${SDK_ARCH}${layout_libexecdir}"
includedir	= "${STAGING_DIR}/${SDK_ARCH}${layout_includedir}"

#do_stage () {
#	oe_runmake install
#}

do_install () {
	:
}
