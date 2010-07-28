require toolchain.inc

PR_append = ".1"

# gcc and glibc versions should be locked down by distro
CT_CC_VERSION			 = "4.3.4"
CT_LIBC_VERSION			 = "2.9"

# the rest should be set here
CT_KERNEL_VERSION		?= "2.6.31.13"
CT_LIBC_GLIBC_MIN_KERNEL	?= "2.6.31.13"
CT_BINUTILS_VERSION		?= "2.19.1"
CT_GDB_VERSION			?= "7.1"
CT_GMP_VERSION			?= "4.3.1"
CT_MPFR_VERSION			?= "2.4.2"
CT_PPL_VERSION			?= "0.10.2"
CT_CLOOG_VERSION		?= "0.15.9"
CT_MPC_VERSION			?= "0.8.1"

BBCLASSEXTEND="cross sdk-cross canadian-cross"
