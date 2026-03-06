Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFD7F513F4
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 06:04:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B0A5402D3;
	Fri,  6 Mar 2026 07:04:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id BFF3540278
 for <dev@dpdk.org>; Fri,  6 Mar 2026 07:04:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772777062; x=1804313062;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=vgFg/uKEerUsepjQLn58KMH/X0pQR0fRjp+OqT9S6RM=;
 b=OxTHC9QK2+tm/CgYNsmKGANE66CHGoAtdHdXx5eMSBQT1tP9sktNkTzP
 IQZBlBGwe6UtPWsNydViLFTrXyeHPIzh/Kn7QN64f0zIVN+Ce5WrH+6ov
 2e7EIKt8atI7Ef2W28RciTdhEPRTwkUB9ZoVDp/kKMyT4uXvbnP4Wzzyr
 TX84E9vU9gxE/OmNPn2L2GuidFCuAvNpLsmQUUeHh+t1W9mBKxwS4u0ZQ
 OUsbj72YJwaYO4fcP85UVTgGFd/pBM+obscq2wbOkNTqyI7rZHaWgRhG8
 x528vHxxDywiUwJEhfuTmv40kF5GpDgRaeD4LkmlD5A2vcrk4Kuend3r6 w==;
X-CSE-ConnectionGUID: sJUTHbmjRTKB7cA778ha9w==
X-CSE-MsgGUID: mzZ7nsMSRymqjF7Afv5cmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="73848344"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="73848344"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 22:04:14 -0800
X-CSE-ConnectionGUID: 1o/uvDURTk6dWeUdp/x8gg==
X-CSE-MsgGUID: 19ISuYmcSByOPTSAvMI7TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="256817790"
Received: from icx009.iind.intel.com ([10.190.212.240])
 by orviesa001.jf.intel.com with ESMTP; 05 Mar 2026 22:04:12 -0800
From: Mounika Kalamandala <mounikax.kalamandala@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: shaiq.wani@intel.com, Mounika Kalamandala <mounikax.kalamandala@intel.com>
Subject: [PATCH] eal: clean runtime directory files on exit
Date: Fri,  6 Mar 2026 06:08:22 +0000
Message-ID: <20260306060822.328329-1-mounikax.kalamandala@intel.com>
X-Mailer: git-send-email 2.43.0
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

Add cleanup of EAL runtime directory artifacts during rte_eal_cleanup().
This removes runtime files created during initialization and ensures
that no stale files remain under /var/run/dpdk/<file-prefix> after the
application terminates.

Update the documentation in multi_proc_support.rst to describe the
secondary process lifetime requirement when the primary process exits.

Signed-off-by: Mounika Kalamandala <mounikax.kalamandala@intel.com>
---
 doc/guides/prog_guide/multi_proc_support.rst | 11 ++++++++++-
 lib/eal/linux/eal.c                          |  4 ++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/doc/guides/prog_guide/multi_proc_support.rst b/doc/guides/prog_guide/multi_proc_support.rst
index a73918a5da..2297f3d79f 100644
--- a/doc/guides/prog_guide/multi_proc_support.rst
+++ b/doc/guides/prog_guide/multi_proc_support.rst
@@ -1,5 +1,5 @@
 ..  SPDX-License-Identifier: BSD-3-Clause
-    Copyright(c) 2010-2014 Intel Corporation.
+    Copyright(c) 2010-2026 Intel Corporation.
 
 Multi-process Support
 =====================
@@ -30,6 +30,15 @@ after a primary process has already configured the hugepage shared memory for th
     Secondary processes which requires access to physical devices in Primary process, must
     be passed with the same allow and block options.
 
+    When the primary process exits, all secondary processes must be terminated,
+    and then restarted after the primary process is re-run to ensure
+    proper re-initialization of shared resources.
+    If secondary processes continue running after the primary process
+    exits, they may experience reduced functionality. In particular,
+    inter-process communication, new memory allocations, and other
+    shared infrastructure will no longer be available, which may lead
+    to unexpected errors.
+
 To support these two process types, and other multi-process setups described later,
 two additional command-line parameters are available to the EAL:
 
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index d848de03d8..18acaf6b9e 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -989,6 +989,10 @@ rte_eal_cleanup(void)
 	/* after this point, any DPDK pointers will become dangling */
 	rte_eal_memory_detach();
 	rte_eal_malloc_heap_cleanup();
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY &&
+			!internal_conf->no_shconf &&
+			eal_clean_runtime_dir() < 0)
+		EAL_LOG(WARNING, "Cannot clean runtime directory on exit");
 	eal_cleanup_config(internal_conf);
 	eal_lcore_var_cleanup();
 	rte_eal_log_cleanup();
-- 
2.43.0

