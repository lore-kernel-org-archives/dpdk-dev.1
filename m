Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787B610987B5
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Mar 2026 17:01:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A0B63402BB;
	Fri, 20 Mar 2026 18:01:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id EFCB7402B2
 for <dev@dpdk.org>; Fri, 20 Mar 2026 18:01:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774026067; x=1805562067;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=b4kld2nfCmKRVDnwLS4o1u5P4K1R4s5XovWq0YWsqEo=;
 b=Qyjq9c+XLDh8sZ0/D+6hGOo9wAV2AwFc3HiZhD1VTIucyEw90ejR/Eop
 GwkO+XYXRYHUcVvgX6kAewVHzVK/Qt3yJyGdZlgbdAzlMW/x90SpoL5Oh
 q5IlavmFqs5rCL6i/lElKaoFcxHJq0u/6B71qsFNa+LJMgnntDTNWhdF6
 sUDCnsO3w17SbINrPRYu/tAaR5yPQk0NHMqZxlfzczY9Plj2UIp2/yepq
 xi0QNU+Mv2FCW75q7Xut3qQaTULa0h3yVqg9UE6zwGBVfWVvgHUIj4Y9G
 fF/x25je+BJceuY6XVb/HJH42SpPH+Pe7mu3TKD8ZPfTsphSMsjuM9H4a g==;
X-CSE-ConnectionGUID: iqgnDeB4RLOjoqLIJ2YH3A==
X-CSE-MsgGUID: CwyUjygJQ4mIlewuhyjDOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="62675853"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="62675853"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2026 10:00:45 -0700
X-CSE-ConnectionGUID: IYaFlJ7tSa2ZG4LnHmkoaQ==
X-CSE-MsgGUID: 90g63jQoQJKoKNYhOnR8rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="228278210"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa005.jf.intel.com with ESMTP; 20 Mar 2026 10:00:44 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] freebsd/contigmem: support mem sizes in MB
Date: Fri, 20 Mar 2026 17:00:38 +0000
Message-ID: <20260320170038.338674-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
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

Rather than having to specify memory sizes for contigmem driver in
bytes, which leads to very large, awkward numbers if dealing with GB of
memory, add an alternative buffer_size_MB configuration option to allow
specifying the memory size in megabytes. The existing "buffer_size"
option is kept for backward compatibility.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
NOTE: the building from ports doc section has not been updated here, as
the DPDK port in the ports collection does not yet support the new
option.
---
 doc/guides/freebsd_gsg/build_dpdk.rst | 16 ++++++++++------
 doc/guides/nics/cxgbe.rst             |  2 +-
 kernel/freebsd/contigmem/contigmem.c  | 19 +++++++++++++++++--
 lib/eal/freebsd/eal_hugepage_info.c   |  7 ++++++-
 4 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/doc/guides/freebsd_gsg/build_dpdk.rst b/doc/guides/freebsd_gsg/build_dpdk.rst
index 45bb4fc478..2512d78e49 100644
--- a/doc/guides/freebsd_gsg/build_dpdk.rst
+++ b/doc/guides/freebsd_gsg/build_dpdk.rst
@@ -84,11 +84,15 @@ contiguous blocks to be reserved by the module can be set at runtime prior to
 module loading using::
 
     kenv hw.contigmem.num_buffers=n
-    kenv hw.contigmem.buffer_size=m
+    kenv hw.contigmem.buffer_size_MB=m
 
-Where n is the number of blocks and m is the size in bytes of each area of contiguous memory.
-A default of two buffers of size 1073741824 bytes (1 Gigabyte) each
-is set during module load if they are not specified in the environment.
+Where n is the number of blocks and m is the size in megabytes of each area of contiguous memory.
+A default of one buffer of size 512 MB is set during module load if they are not specified in the environment.
+
+.. note::
+
+   For backward compatibility, the buffer size may also be specified in bytes using ``hw.contigmem.buffer_size``.
+   The two parameters are mutually exclusive and cannot be set simultaneously.
 
 Buffers are excluded from core dump by default.
 Mapped buffers can be included in core dump using the following tunable::
@@ -108,7 +112,7 @@ following in ``/boot/loader.conf``:
 .. code-block:: shell
 
     hw.contigmem.num_buffers=n
-    hw.contigmem.buffer_size=m
+    hw.contigmem.buffer_size_MB=m
     hw.contigmem.coredump_enable=1
 
 The variables can be inspected using the following command::
@@ -127,7 +131,7 @@ up time.  This can be achieved by placing lines similar to the following into
 .. code-block:: shell
 
     hw.contigmem.num_buffers=1
-    hw.contigmem.buffer_size=1073741824
+    hw.contigmem.buffer_size_MB=1024
     hw.contigmem.coredump_enable=1
     contigmem_load="YES"
 
diff --git a/doc/guides/nics/cxgbe.rst b/doc/guides/nics/cxgbe.rst
index 86deb779ca..9cb411b729 100644
--- a/doc/guides/nics/cxgbe.rst
+++ b/doc/guides/nics/cxgbe.rst
@@ -670,7 +670,7 @@ devices managed by librte_net_cxgbe in FreeBSD operating system.
 
       # reserve 2 x 1G blocks of contiguous memory using contigmem driver
       hw.contigmem.num_buffers=2
-      hw.contigmem.buffer_size=1073741824
+      hw.contigmem.buffer_size_MB=1024
       # load contigmem module during boot process
       contigmem_load="YES"
 
diff --git a/kernel/freebsd/contigmem/contigmem.c b/kernel/freebsd/contigmem/contigmem.c
index 591e46dded..1cc90ecfe7 100644
--- a/kernel/freebsd/contigmem/contigmem.c
+++ b/kernel/freebsd/contigmem/contigmem.c
@@ -50,7 +50,8 @@ static d_open_t         contigmem_open;
 static d_close_t        contigmem_close;
 
 static int              contigmem_num_buffers = RTE_CONTIGMEM_DEFAULT_NUM_BUFS;
-static int64_t          contigmem_buffer_size = RTE_CONTIGMEM_DEFAULT_BUF_SIZE;
+static int64_t          contigmem_buffer_size = 0; /* 0 = not set; resolved in contigmem_load() */
+static int64_t          contigmem_buffer_size_MB = 0; /* 0 = not set; alternative to buffer_size */
 static bool             contigmem_coredump_enable;
 
 static eventhandler_tag contigmem_eh_tag;
@@ -60,6 +61,7 @@ static int              contigmem_refcnt;
 
 TUNABLE_INT("hw.contigmem.num_buffers", &contigmem_num_buffers);
 TUNABLE_QUAD("hw.contigmem.buffer_size", &contigmem_buffer_size);
+TUNABLE_QUAD("hw.contigmem.buffer_size_MB", &contigmem_buffer_size_MB);
 TUNABLE_BOOL("hw.contigmem.coredump_enable", &contigmem_coredump_enable);
 
 static SYSCTL_NODE(_hw, OID_AUTO, contigmem, CTLFLAG_RD, 0, "contigmem");
@@ -67,7 +69,10 @@ static SYSCTL_NODE(_hw, OID_AUTO, contigmem, CTLFLAG_RD, 0, "contigmem");
 SYSCTL_INT(_hw_contigmem, OID_AUTO, num_buffers, CTLFLAG_RD,
 	&contigmem_num_buffers, 0, "Number of contigmem buffers allocated");
 SYSCTL_QUAD(_hw_contigmem, OID_AUTO, buffer_size, CTLFLAG_RD,
-	&contigmem_buffer_size, 0, "Size of each contiguous buffer");
+	&contigmem_buffer_size, 0, "Size of each contiguous buffer (in bytes)");
+SYSCTL_QUAD(_hw_contigmem, OID_AUTO, buffer_size_MB, CTLFLAG_RD,
+	&contigmem_buffer_size_MB, 0,
+	"Size of each contiguous buffer in MB (alternative to buffer_size)");
 SYSCTL_INT(_hw_contigmem, OID_AUTO, num_references, CTLFLAG_RD,
 	&contigmem_refcnt, 0, "Number of references to contigmem");
 SYSCTL_BOOL(_hw_contigmem, OID_AUTO, coredump_enable, CTLFLAG_RD,
@@ -121,6 +126,16 @@ contigmem_load(void)
 	int  i, error = 0;
 	void *addr;
 
+	if (contigmem_buffer_size != 0 && contigmem_buffer_size_MB != 0) {
+		printf("contigmem: buffer_size and buffer_size_MB cannot both be "
+				"specified\n");
+		return EINVAL;
+	}
+	if (contigmem_buffer_size_MB != 0)
+		contigmem_buffer_size = contigmem_buffer_size_MB * 1024 * 1024;
+	else if (contigmem_buffer_size == 0)
+		contigmem_buffer_size = RTE_CONTIGMEM_DEFAULT_BUF_SIZE;
+
 	if (contigmem_num_buffers > RTE_CONTIGMEM_MAX_NUM_BUFS) {
 		printf("%d buffers requested is greater than %d allowed\n",
 				contigmem_num_buffers, RTE_CONTIGMEM_MAX_NUM_BUFS);
diff --git a/lib/eal/freebsd/eal_hugepage_info.c b/lib/eal/freebsd/eal_hugepage_info.c
index b6772e0701..392c225d5b 100644
--- a/lib/eal/freebsd/eal_hugepage_info.c
+++ b/lib/eal/freebsd/eal_hugepage_info.c
@@ -56,7 +56,7 @@ eal_hugepage_info_init(void)
 {
 	size_t sysctl_size;
 	int num_buffers, fd, error;
-	int64_t buffer_size;
+	int64_t buffer_size = 0;
 	struct internal_config *internal_conf =
 		eal_get_internal_configuration();
 
@@ -80,6 +80,11 @@ eal_hugepage_info_init(void)
 	error = sysctlbyname("hw.contigmem.buffer_size", &buffer_size,
 			&sysctl_size, NULL, 0);
 
+	if (error != 0) {
+		error = sysctlbyname("hw.contigmem.buffer_size_MB", &buffer_size,
+				&sysctl_size, NULL, 0);
+		buffer_size *= 1024 * 1024;  /* convert to bytes, harmless to multiple on error*/
+	}
 	if (error != 0) {
 		EAL_LOG(ERR, "could not read sysctl hw.contigmem.buffer_size");
 		return -1;
-- 
2.51.0

