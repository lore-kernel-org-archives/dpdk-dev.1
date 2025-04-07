Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B2DC36010
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 15:25:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9DCDE40B9F;
	Mon,  7 Apr 2025 17:25:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 9509740A8A
 for <dev@dpdk.org>; Mon,  7 Apr 2025 17:25:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744039519; x=1775575519;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UtR/O3cfW27Xv/SYx6dMZLN8/EzVSnEkFnY/AWm01Pk=;
 b=ZvoxYtcKwfuM3dkJL0I93+q9VZhHnBCVB3EyvoaIkAyyHEgoNDkZ43C+
 GfycPcZlNY5LJG0VdcKtaahVr6lzgOwZJ2+RA5itlJqtkHdBho/8CWkRI
 ilJhixshUB7KQNXUelxU1V6zNc6xxee+walVMyZ+hRfG5IT6AN+Gog9CK
 iKFJyfOw3L3EohAm3sXTeUQ1s1Hm2iumBg9tzJTcdM409G1LyLhXUacwj
 yNxlZolvVYXuIhHocr5F7zFF2kOsnRwJSDzsB06QPTbCcA2rsm2nWTyb1
 r0XGLHlFgipwrWE3EpaAUXatPBC0F2xq6g0UZM9p6Od2ymqmozSa8+/vS Q==;
X-CSE-ConnectionGUID: aJSj3Ax3SNSfwbxZxykW0w==
X-CSE-MsgGUID: lKfNy9jnRRix41V+4YBBQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="70809366"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="70809366"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 08:25:18 -0700
X-CSE-ConnectionGUID: 9v2SFT+pT2ep1J9QIUmYug==
X-CSE-MsgGUID: 7SGoBM8/TZKLsKeff0aNyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="132125573"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by fmviesa003.fm.intel.com with ESMTP; 07 Apr 2025 08:25:17 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 03/10] net/hinic: use common base code build handling
Date: Mon,  7 Apr 2025 16:25:02 +0100
Message-ID: <20250407152509.2203243-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250407152509.2203243-1-bruce.richardson@intel.com>
References: <20250331161000.9886-1-bruce.richardson@intel.com>
 <20250407152509.2203243-1-bruce.richardson@intel.com>
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

