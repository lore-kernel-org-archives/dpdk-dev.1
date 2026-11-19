Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C9A606A339
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hQ3wEF+r
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8EA7D40151;
	Thu, 19 Nov 2026 17:39:54 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTPS id C19A9400D7
 for <dev@dpdk.org>; Thu, 19 Nov 2026 17:39:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795106393; x=1826642393;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=tTCbdhtvYvBKVHVpt1IK/5zeT9EiShco+1x5RkhaaQQ=;
 b=hQ3wEF+r8wmG3wKmJtCBkt7Pi0iHAAM8Na+QQFZDa3MxnkEz4b5utbU0
 7w4SnANvzD9OdYq4qSAR4Skj4EDauoV9ahtUimfv6RqaPOyiyKdv2Ixyr
 qCubWR4qXxfR6YiGtRbGX+hSVVLx+gO9alxDI8RmFmW/GVzd0AOyGXLD9
 840CETAL5z3mnLwy1zjIxvSOBdRIOAvz7L6pS6Gbctt8nPYim1/p/fikF
 fUDrjC7uSVQ2B7rVyQKgLyzdlHOa8eu6Wv1JKEQ2HWKG1U3zQ6u9mHqhA
 MMGQ725GMGuxWpax86IAB5juzNK/yZDsXqT25onORHp11/oJ3pnLyFbus A==;
X-CSE-ConnectionGUID: Ti0bYAa1TluFid9IXUBn6w==
X-CSE-MsgGUID: axz+KvhVT2y1jZVOWCveEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4044260"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="4044260"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 08:39:51 -0800
X-CSE-ConnectionGUID: TsLxhJIsSdeYwFv4XW1RFA==
X-CSE-MsgGUID: K+C023DAQFq674hdNezi9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; d="scan'208";a="10772517"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa009.jf.intel.com with ESMTP; 19 Nov 2026 08:39:50 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH 27.03] net/ice: enable DDP loading from FreeBSD kernel module
Date: Thu, 19 Nov 2026 16:39:45 +0000
Message-ID: <20261119163945.3180334-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On FreeBSD, the DDP package can be contained inside a kernel module
called "ice_ddp.ko", rather than as a .pkg file in /lib/firmware as on
linux. Add support for loading from the kmod as a final fallback option
for BSD systems only.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/nics/ice.rst              |   4 +
 drivers/net/intel/ice/ice_ddp_kmod.c | 264 +++++++++++++++++++++++++++
 drivers/net/intel/ice/ice_ethdev.c   |  14 +-
 drivers/net/intel/ice/ice_ethdev.h   |   3 +
 drivers/net/intel/ice/meson.build    |   1 +
 5 files changed, 282 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/intel/ice/ice_ddp_kmod.c

diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index faebfdcb63..a4acf9a957 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -97,6 +97,10 @@ During initialization, the driver searches in the following paths in order:
 ``CUSTOMIZED_PATH``, ``/lib/firmware/updates/intel/ice/ddp`` and ``/lib/firmware/intel/ice/ddp``.
 The device-specific DDP package has a higher loading priority than default DDP package, ``ice.pkg``.
 
+On FreeBSD, if no package file is found in the above paths,
+the driver uses the package embedded in the ``ice_ddp.ko`` kernel module,
+which is the package used by the FreeBSD kernel ice driver.
+
 .. note::
 
    Windows support: DDP packages are not supported on Windows.
diff --git a/drivers/net/intel/ice/ice_ddp_kmod.c b/drivers/net/intel/ice/ice_ddp_kmod.c
new file mode 100644
index 0000000000..33640252ac
--- /dev/null
+++ b/drivers/net/intel/ice/ice_ddp_kmod.c
@@ -0,0 +1,264 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+#include <stddef.h>
+
+#include "ice_ethdev.h"
+
+#ifndef RTE_EXEC_ENV_FREEBSD
+
+/* fallback for Linux and Windows, where DDP can't be read from the kernel module */
+int
+ice_ddp_read_kmod(void **buf, size_t *bufsz)
+{
+	*buf = NULL;
+	*bufsz = 0;
+	return -1;
+}
+
+#else /* RTE_EXEC_ENV_FREEBSD */
+
+#include <elf.h>
+#include <fcntl.h>
+#include <stdalign.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/param.h>
+#include <sys/linker.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <sys/sysctl.h>
+
+#include <rte_byteorder.h>
+#include <rte_common.h>
+
+/* symbols generated by the FreeBSD build for firmware images listed in FIRMWS */
+#define ICE_KMOD_FW_SYM_PREFIX "_binary_"
+#define ICE_KMOD_FW_SYM_START "_start"
+#define ICE_KMOD_FW_SYM_END "_end"
+
+#if RTE_BYTE_ORDER == RTE_LITTLE_ENDIAN
+#define ICE_KMOD_ELFDATA ELFDATA2LSB
+#else
+#define ICE_KMOD_ELFDATA ELFDATA2MSB
+#endif
+
+/* Find the module file, preferring the one the kernel loaded so both use the same package. */
+static int
+ice_kmod_find_path(const char *kmod, char *path, size_t len)
+{
+	const int fileid = kldfind(kmod);
+
+	if (fileid >= 0) {
+		struct kld_file_stat stat = { .version = sizeof(stat) };
+
+		if (kldstat(fileid, &stat) == 0 && strlcpy(path, stat.pathname, len) < len)
+			return 0;
+	}
+
+	/* not loaded, so search the kernel module path */
+	char module_path[MAXPATHLEN];
+	size_t module_path_len = sizeof(module_path);
+
+	if (sysctlbyname("kern.module_path", module_path, &module_path_len, NULL, 0) != 0)
+		return -1;
+	module_path[sizeof(module_path) - 1] = '\0';
+
+	char *saveptr;
+
+	for (const char *dir = strtok_r(module_path, ";", &saveptr); dir != NULL;
+			dir = strtok_r(NULL, ";", &saveptr)) {
+		const int n = snprintf(path, len, "%s/%s.ko", dir, kmod);
+
+		if (n > 0 && (size_t)n < len && access(path, R_OK) == 0)
+			return 0;
+	}
+	return -1;
+}
+
+/* Get a section header by index, checking its data lies within the file. */
+static const Elf64_Shdr *
+ice_kmod_get_sect_hdr(const uint8_t *img, size_t img_len, const Elf64_Ehdr *eh, unsigned int idx)
+{
+	if (idx == SHN_UNDEF || idx >= SHN_LORESERVE || idx >= eh->e_shnum)
+		return NULL;
+
+	const Elf64_Shdr *sh = (const Elf64_Shdr *)(img + eh->e_shoff) + idx;
+
+	if (sh->sh_type != SHT_NOBITS &&
+			(sh->sh_offset > img_len || sh->sh_size > img_len - sh->sh_offset))
+		return NULL;
+	return sh;
+}
+
+/* Get the file offset of a symbol's data, checking it lies within its section. */
+static int
+ice_kmod_sym_offset(const uint8_t *img, size_t img_len, const Elf64_Ehdr *eh,
+		const Elf64_Sym *sym, const Elf64_Shdr **sec, uint64_t *off)
+{
+	*sec = ice_kmod_get_shdr(img, img_len, eh, sym->st_shndx);
+	if (*sec == NULL || (*sec)->sh_type == SHT_NOBITS)
+		return -1;
+
+	/* symbol values are section relative in relocatable objects, addresses otherwise */
+	const uint64_t base = eh->e_type == ET_REL ? 0 : (*sec)->sh_addr;
+
+	if (sym->st_value < base || sym->st_value - base > (*sec)->sh_size)
+		return -1;
+	*off = (*sec)->sh_offset + (sym->st_value - base);
+	return 0;
+}
+
+/* Copy out the single firmware image embedded in a kernel module file. */
+static int
+ice_kmod_extract_fw(const uint8_t *img, size_t img_len, void **buf, size_t *bufsz)
+{
+	const Elf64_Ehdr *eh = (const Elf64_Ehdr *)img;
+
+	/* check for a native 64-bit ELF file with section headers inside the file */
+	if (img_len < sizeof(*eh) || memcmp(eh->e_ident, ELFMAG, SELFMAG) != 0 ||
+			eh->e_ident[EI_CLASS] != ELFCLASS64 ||
+			eh->e_ident[EI_DATA] != ICE_KMOD_ELFDATA ||
+			eh->e_shentsize != sizeof(Elf64_Shdr) ||
+			eh->e_shoff % alignof(Elf64_Shdr) != 0 ||
+			eh->e_shoff > img_len ||
+			eh->e_shnum > (img_len - eh->e_shoff) / sizeof(Elf64_Shdr))
+		return -1;
+
+	/* find the symbol table and its string table */
+	const Elf64_Shdr *symtab = NULL;
+
+	for (unsigned int i = 1; i < eh->e_shnum; i++) {
+		const Elf64_Shdr *sh = (const Elf64_Shdr *)(img + eh->e_shoff) + i;
+
+		if (sh->sh_type == SHT_SYMTAB) {
+			symtab = ice_kmod_get_shdr(img, img_len, eh, i);
+			break;
+		}
+	}
+	if (symtab == NULL || symtab->sh_entsize != sizeof(Elf64_Sym) ||
+			symtab->sh_offset % alignof(Elf64_Sym) != 0)
+		return -1;
+
+	const Elf64_Shdr *strtab = ice_kmod_get_shdr(img, img_len, eh, symtab->sh_link);
+
+	if (strtab == NULL || strtab->sh_type != SHT_STRTAB)
+		return -1;
+
+	const Elf64_Sym *syms = (const Elf64_Sym *)(img + symtab->sh_offset);
+	const size_t nb_syms = symtab->sh_size / sizeof(Elf64_Sym);
+	const char *strs = (const char *)(img + strtab->sh_offset);
+	const size_t prefix_len = strlen(ICE_KMOD_FW_SYM_PREFIX);
+	const size_t start_len = strlen(ICE_KMOD_FW_SYM_START);
+	const size_t end_len = strlen(ICE_KMOD_FW_SYM_END);
+	const Elf64_Sym *start = NULL;
+	const Elf64_Sym *end = NULL;
+	const char *start_name = NULL;
+	size_t fw_name_len = 0;
+
+	/* find the image start symbol, which must be unique */
+	for (size_t i = 0; i < nb_syms; i++) {
+		if (syms[i].st_name >= strtab->sh_size)
+			continue;
+
+		const char *name = strs + syms[i].st_name;
+		const size_t max_len = strtab->sh_size - syms[i].st_name;
+		const size_t len = strnlen(name, max_len);
+
+		if (len == max_len || len <= prefix_len + start_len ||
+				strncmp(name, ICE_KMOD_FW_SYM_PREFIX, prefix_len) != 0 ||
+				strcmp(name + len - start_len, ICE_KMOD_FW_SYM_START) != 0)
+			continue;
+		if (start != NULL) {
+			PMD_INIT_LOG(ERR, "Multiple firmware images in kernel module, cannot choose one");
+			return -1;
+		}
+		start = &syms[i];
+		start_name = name;
+		fw_name_len = len - start_len;
+	}
+	if (start == NULL)
+		return -1;
+
+	/* find the matching image end symbol */
+	for (size_t i = 0; i < nb_syms; i++) {
+		if (syms[i].st_name >= strtab->sh_size)
+			continue;
+
+		const char *name = strs + syms[i].st_name;
+
+		if (strnlen(name, strtab->sh_size - syms[i].st_name) == fw_name_len + end_len &&
+				strncmp(name, start_name, fw_name_len) == 0 &&
+				strcmp(name + fw_name_len, ICE_KMOD_FW_SYM_END) == 0) {
+			end = &syms[i];
+			break;
+		}
+	}
+	if (end == NULL)
+		return -1;
+
+	/* the image is the data between the two symbols, in the same section */
+	const Elf64_Shdr *start_sec, *end_sec;
+	uint64_t start_off, end_off;
+
+	if (ice_kmod_sym_offset(img, img_len, eh, start, &start_sec, &start_off) < 0 ||
+			ice_kmod_sym_offset(img, img_len, eh, end, &end_sec, &end_off) < 0 ||
+			start_sec != end_sec || end_off <= start_off)
+		return -1;
+
+	/* copy the image, as the caller unmaps the file */
+	*bufsz = end_off - start_off;
+	*buf = malloc(*bufsz);
+	if (*buf == NULL) {
+		*bufsz = 0;
+		return -1;
+	}
+	memcpy(*buf, img + start_off, *bufsz);
+	return 0;
+}
+
+/* Read the DDP package from the ice_ddp kernel module into a malloc'd buffer. */
+int
+ice_ddp_read_kmod(void **buf, size_t *bufsz)
+{
+	char path[MAXPATHLEN];
+	struct stat st;
+	void *img;
+	int ret = -1;
+
+	*buf = NULL;
+	*bufsz = 0;
+
+	if (ice_kmod_find_path(ICE_PKG_KMOD_NAME, path, sizeof(path)) < 0) {
+		PMD_INIT_LOG(DEBUG, "Cannot find kernel module " ICE_PKG_KMOD_NAME);
+		return -1;
+	}
+
+	const int fd = open(path, O_RDONLY);
+
+	if (fd < 0) {
+		PMD_INIT_LOG(DEBUG, "Cannot open kernel module %s", path);
+		return -1;
+	}
+	if (fstat(fd, &st) < 0 || st.st_size <= 0)
+		goto out;
+
+	img = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (img == MAP_FAILED)
+		goto out;
+
+	ret = ice_kmod_extract_fw(img, st.st_size, buf, bufsz);
+	if (ret < 0)
+		PMD_INIT_LOG(DEBUG, "Cannot extract DDP package from kernel module %s", path);
+	else
+		PMD_INIT_LOG(DEBUG, "Read DDP package from kernel module %s", path);
+	munmap(img, st.st_size);
+out:
+	close(fd);
+	return ret;
+}
+
+#endif /* RTE_EXEC_ENV_FREEBSD */
diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 457c955b2e..0824d83b8a 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -2132,10 +2132,16 @@ int ice_load_pkg(struct ice_adapter *adapter, bool use_dsn, uint64_t dsn)
 		goto load_fw;
 
 	strlcpy(pkg_file, ICE_PKG_FILE_DEFAULT, ICE_MAX_PKG_FILENAME_SIZE);
-	if (ice_firmware_read(pkg_file, &buf, &bufsz) < 0) {
-		PMD_INIT_LOG(ERR, "Failed to load default DDP package " ICE_PKG_FILE_DEFAULT);
-		return -1;
-	}
+	if (ice_firmware_read(pkg_file, &buf, &bufsz) == 0)
+		goto load_fw;
+
+	/* use the same package as the kernel driver, on OSes providing it as a module */
+	strlcpy(pkg_file, ICE_PKG_KMOD_NAME " kernel module", ICE_MAX_PKG_FILENAME_SIZE);
+	if (ice_ddp_read_kmod(&buf, &bufsz) == 0)
+		goto load_fw;
+
+	PMD_INIT_LOG(ERR, "Failed to load default DDP package " ICE_PKG_FILE_DEFAULT);
+	return -1;
 
 load_fw:
 	PMD_INIT_LOG(DEBUG, "DDP package name: %s", pkg_file);
diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index 7a3d164143..bd6b1991b0 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -53,6 +53,7 @@
 #define ICE_PKG_FILE_SEARCH_PATH_DEFAULT "/lib/firmware/intel/ice/ddp/"
 #define ICE_PKG_FILE_SEARCH_PATH_UPDATES "/lib/firmware/updates/intel/ice/ddp/"
 #define ICE_PKG_FILE_CUSTOMIZED_PATH "/sys/module/firmware_class/parameters/path"
+#define ICE_PKG_KMOD_NAME "ice_ddp"
 #define ICE_MAX_PKG_FILENAME_SIZE   256
 
 #define MAX_ACL_NORMAL_ENTRIES    256
@@ -752,6 +753,8 @@ struct ice_vsi_vlan_pvid_info {
 bool is_ice_supported(struct rte_eth_dev *dev);
 int
 ice_load_pkg(struct ice_adapter *adapter, bool use_dsn, uint64_t dsn);
+int
+ice_ddp_read_kmod(void **buf, size_t *bufsz);
 struct ice_vsi *
 ice_setup_vsi(struct ice_pf *pf, enum ice_vsi_type type);
 int
diff --git a/drivers/net/intel/ice/meson.build b/drivers/net/intel/ice/meson.build
index 00077be30a..d776276612 100644
--- a/drivers/net/intel/ice/meson.build
+++ b/drivers/net/intel/ice/meson.build
@@ -8,6 +8,7 @@ sources = files(
         'ice_dcf_ethdev.c',
         'ice_dcf_parent.c',
         'ice_dcf_sched.c',
+        'ice_ddp_kmod.c',
         'ice_diagnose.c',
         'ice_ethdev.c',
         'ice_fdir_filter.c',
-- 
2.55.0

