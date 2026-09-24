Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405C8C98318
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 16:14:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4763643036;
	Thu, 24 Sep 2026 18:13:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 797B140144
 for <dev@dpdk.org>; Thu, 24 Sep 2026 18:13:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790266435; x=1821802435;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Id/aZ2kr4w8HR9bIgL5LRKWZadPqsVBXp9ETWvuYUF4=;
 b=EZfj7MkjYE8c2h3py335UBUAILydoLuBZ3WqYOBUaJRdvZexQ6BQRkzB
 FfFvgd/fYAThcNm31fHv8eW9h0MnkEorjw9Pb7sVYDiuIRrAuzgyjWrMG
 VpvgGqlr/srvJoyEdFPTv9q1l5ZQhxXl/VepuK9thrUgLIIv2/1YhdMhU
 VsPt/fGPw0ZuLbX4oaGIyAPvKvNIZSyZ6Hs688YFslB8Su7YQ6S0gg7wI
 W/87PuyZFXaAt4NGXEppJQdkDr1EkeedSph4LAUp/w2IECRb3mf7RZwDb
 YDiH4TMY6EJu4mHzvi+ufJsjFFCJbevlks8zhFMladY9J6Su6ZEKDKQSj g==;
X-CSE-ConnectionGUID: gK/HE7kQSQ6f0AKLMySJnw==
X-CSE-MsgGUID: 9oUB7o7+TLeZxI2zf7Xo7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90000631"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="90000631"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 09:13:54 -0700
X-CSE-ConnectionGUID: NARDBfOeSL2hyY+CM8rIHg==
X-CSE-MsgGUID: cyoPoDIwSGG2WGwKTzuN+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="277829995"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 24 Sep 2026 09:13:54 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v18 07/29] eal: move kernel module check function into VFIO
Date: Thu, 24 Sep 2026 17:13:14 +0100
Message-ID: <8051152224a10e2f93e99fee3ffa8d2b3f688c6e.1790266166.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1790266165.git.anatoly.burakov@intel.com>
 <cover.1790266165.git.anatoly.burakov@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

EAL provides a "check if a kernel module is loaded" function, but the only
consumer of that function is VFIO. Move it and make it internal to VFIO.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/common/eal_private.h | 14 ------------
 lib/eal/linux/eal.c          | 35 ------------------------------
 lib/eal/linux/eal_vfio.c     | 41 ++++++++++++++++++++++++++++++++++--
 3 files changed, 39 insertions(+), 51 deletions(-)

diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index 6340bab8be0..8507791ec26 100644
--- a/lib/eal/common/eal_private.h
+++ b/lib/eal/common/eal_private.h
@@ -206,20 +206,6 @@ int rte_eal_alarm_init(void);
  */
 void rte_eal_alarm_cleanup(void);
 
-/**
- * Function is to check if the kernel module(like, vfio, vfio_iommu_type1,
- * etc.) loaded.
- *
- * @param module_name
- *	The module's name which need to be checked
- *
- * @return
- *	-1 means some error happens(NULL pointer or open failure)
- *	0  means the module not loaded
- *	1  means the module loaded
- */
-int rte_eal_check_module(const char *module_name);
-
 /**
  * Memory reservation flags.
  */
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index 5577bab24a2..1d0894e7eab 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -17,9 +17,7 @@
 #include <fnmatch.h>
 #include <stddef.h>
 #include <errno.h>
-#include <limits.h>
 #include <sys/mman.h>
-#include <sys/stat.h>
 #if defined(RTE_ARCH_X86)
 #include <sys/io.h>
 #endif
@@ -1028,36 +1026,3 @@ rte_eal_vfio_get_vf_token(rte_uuid_t vf_token)
 	rte_uuid_copy(vf_token, cfg->vfio_vf_token);
 }
 
-int
-rte_eal_check_module(const char *module_name)
-{
-	char sysfs_mod_name[PATH_MAX];
-	struct stat st;
-	int n;
-
-	if (NULL == module_name)
-		return -1;
-
-	/* Check if there is sysfs mounted */
-	if (stat("/sys/module", &st) != 0) {
-		EAL_LOG(DEBUG, "sysfs is not mounted! error %i (%s)",
-			errno, strerror(errno));
-		return -1;
-	}
-
-	/* A module might be built-in, therefore try sysfs */
-	n = snprintf(sysfs_mod_name, PATH_MAX, "/sys/module/%s", module_name);
-	if (n < 0 || n > PATH_MAX) {
-		EAL_LOG(DEBUG, "Could not format module path");
-		return -1;
-	}
-
-	if (stat(sysfs_mod_name, &st) != 0) {
-		EAL_LOG(DEBUG, "Module %s not found! error %i (%s)",
-		        sysfs_mod_name, errno, strerror(errno));
-		return 0;
-	}
-
-	/* Module has been found */
-	return 1;
-}
diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index 8959a161530..ce247362662 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -4,9 +4,12 @@
 
 #include <uapi/linux/vfio.h>
 
+#include <errno.h>
 #include <inttypes.h>
+#include <limits.h>
 #include <string.h>
 #include <fcntl.h>
+#include <sys/stat.h>
 #include <unistd.h>
 #include <sys/ioctl.h>
 #include <dirent.h>
@@ -60,6 +63,40 @@ static struct vfio_config *default_vfio_cfg = &vfio_cfgs[0];
 /* whether VFIO is enabled (usable) in this process */
 static bool vfio_enabled;
 
+static int
+vfio_check_module(const char *module_name)
+{
+	char sysfs_mod_name[PATH_MAX];
+	struct stat st;
+	int n;
+
+	if (NULL == module_name)
+		return -1;
+
+	/* Check if there is sysfs mounted */
+	if (stat("/sys/module", &st) != 0) {
+		EAL_LOG(DEBUG, "sysfs is not mounted! error %i (%s)",
+			errno, strerror(errno));
+		return -1;
+	}
+
+	/* A module might be built-in, therefore try sysfs */
+	n = snprintf(sysfs_mod_name, PATH_MAX, "/sys/module/%s", module_name);
+	if (n < 0 || n > PATH_MAX) {
+		EAL_LOG(DEBUG, "Could not format module path");
+		return -1;
+	}
+
+	if (stat(sysfs_mod_name, &st) != 0) {
+		EAL_LOG(DEBUG, "Module %s not found! error %i (%s)",
+		        sysfs_mod_name, errno, strerror(errno));
+		return 0;
+	}
+
+	/* Module has been found */
+	return 1;
+}
+
 static int vfio_type1_dma_map(int);
 static int vfio_type1_dma_mem_map(int, uint64_t, uint64_t, uint64_t, int);
 static int vfio_spapr_dma_map(int);
@@ -1152,7 +1189,7 @@ rte_vfio_enable(const char *modname)
 	EAL_LOG(DEBUG, "Probing VFIO support...");
 
 	/* check if vfio module is loaded */
-	vfio_available = rte_eal_check_module(modname);
+	vfio_available = vfio_check_module(modname);
 
 	/* return error directly */
 	if (vfio_available == -1) {
@@ -1204,7 +1241,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_is_enabled)
 int
 rte_vfio_is_enabled(const char *modname)
 {
-	const int mod_available = rte_eal_check_module(modname) > 0;
+	const int mod_available = vfio_check_module(modname) > 0;
 	return vfio_enabled && mod_available;
 }
 
-- 
2.52.0

