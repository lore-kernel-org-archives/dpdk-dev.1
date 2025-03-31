Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916C1C3600B
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Mar 2025 16:10:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 658E040A75;
	Mon, 31 Mar 2025 18:10:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id AC74C40A6F
 for <dev@dpdk.org>; Mon, 31 Mar 2025 18:10:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743437424; x=1774973424;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9HKcU75a4ACqJabGvWLvCZ65mk9k+riDx2Ori6Oj81c=;
 b=lFlXdOLkZwugchTkLdzqk+oq70xcNb/ri7A8jdsX2Z4MtQyvWOP3ZopQ
 VA+DfoGqnt5MMLsZCjYdMiENKW7rnH5bbFLxvhvlE0L2ul+Ghoc36tgfk
 Dei1x1cLMFRuivpZzwUVkR6YqT67rs5pFdhJQ3kuj4wDSY3DWliiT1v0T
 sd+PNbWjq5giHJybILu+lpmrIqXgxNec34llhTGqvWx5+3fywY5BERXZn
 3MR+C4olwDZFJlHQpCorPToyp4kHg6KLtv8M+5NtV4NNWbmw7s9q8M7g0
 BdQbXrqxGtUZ52DaBJ5BIncvyWzOJjV3FslFPoOVfEn9+nCKdPLlFlFEa g==;
X-CSE-ConnectionGUID: dqQaIt1dSLKw5buFqJHHxA==
X-CSE-MsgGUID: taG/xsmKRJaU6lh9rwB27Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="62125659"
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; d="scan'208";a="62125659"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2025 09:10:23 -0700
X-CSE-ConnectionGUID: SrSFxVlnQ7Whn4woRngpOA==
X-CSE-MsgGUID: kYJk+5oPQEqogvAdrnz8Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; d="scan'208";a="131132643"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by orviesa004.jf.intel.com with ESMTP; 31 Mar 2025 09:10:22 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Ziyang Xuan <xuanziyang2@huawei.com>,
 Xiaoyun Wang <cloud.wangxiaoyun@huawei.com>
Subject: [PATCH 03/10] net/hinic: use common base code build handling
Date: Mon, 31 Mar 2025 17:09:52 +0100
Message-ID: <20250331161000.9886-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250331161000.9886-1-bruce.richardson@intel.com>
References: <20250331161000.9886-1-bruce.richardson@intel.com>
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

Use the base code build handling logic in the drivers/meson.build file,
rather than re-implementing it in the driver itself.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

---
Minor note: while working on this driver, I noticed that the
dependencies of it, and the overall C flags, not the base code C flags,
are set in the "base/meson.build" file. Most drivers in DPDK have those
set in the top-level driver file, and only to have the base-code
specific changes in the base directory.
---
 drivers/net/hinic/base/meson.build | 16 +++++-----------
 drivers/net/hinic/meson.build      |  1 -
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/net/hinic/base/meson.build b/drivers/net/hinic/base/meson.build
index 3aa53df881..9028acdf4d 100644
--- a/drivers/net/hinic/base/meson.build
+++ b/drivers/net/hinic/base/meson.build
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2017 Huawei Technologies Co., Ltd
 
-sources = [
+base_sources = files(
         'hinic_pmd_api_cmd.c',
         'hinic_pmd_cfg.c',
         'hinic_pmd_cmdq.c',
@@ -13,7 +13,7 @@ sources = [
         'hinic_pmd_nicio.c',
         'hinic_pmd_wq.c',
         'hinic_pmd_mbox.c',
-]
+)
 
 extra_flags = []
 # The driver runs only on arch64 machine, remove 32bit warnings
@@ -22,16 +22,10 @@ if not dpdk_conf.get('RTE_ARCH_64')
 endif
 
 foreach flag: extra_flags
-        if cc.has_argument(flag)
-                cflags += flag
-        endif
+    if cc.has_argument(flag)
+        cflags += flag
+    endif
 endforeach
 
 deps += ['hash']
 
-c_args = cflags
-
-base_lib = static_library('hinic_base', sources,
-    dependencies: [static_rte_eal, static_rte_ethdev, static_rte_bus_pci, static_rte_hash],
-    c_args: c_args)
-base_objs = base_lib.extract_all_objects(recursive: true)
diff --git a/drivers/net/hinic/meson.build b/drivers/net/hinic/meson.build
index 8242e0052e..36cc9431a6 100644
--- a/drivers/net/hinic/meson.build
+++ b/drivers/net/hinic/meson.build
@@ -8,7 +8,6 @@ if is_windows
 endif
 
 subdir('base')
-objs = [base_objs]
 
 sources = files(
         'hinic_pmd_ethdev.c',
-- 
2.45.2

