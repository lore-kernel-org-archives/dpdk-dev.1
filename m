Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D16C3601E
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 15:25:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A3AD40DCB;
	Mon,  7 Apr 2025 17:25:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 8686D40B95
 for <dev@dpdk.org>; Mon,  7 Apr 2025 17:25:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744039521; x=1775575521;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CP3gXYsJhuruklW7LTEPwDgPNFPaXNkzNaRNCxlSBOg=;
 b=Npy1Yt9gHYfUHGbLvVElMHSfRCP9d9qDsRIloZEPRAYFbNAsIMtl4XGv
 fu0xCDyCrhyFMw9bYuWOAyj7mAUqpOKia1KJbAPBvLY15Vz13MCPK9LP+
 VujbDD+Mr3ssgY5qZbClHAlkXo+VyCtyaI+HmmqO9LQ4vnkYQqFM46F7u
 mVcgwLHd9KrqqR/HxBlwT+2pYkYQPTRyYWtZvdEiEgrZ3XWD2AkKLXvhd
 fLfiN8iwrFJ1RGba00pzUgBU44UJmYZeYwa3xAEEoJ8GairhCru6TupWh
 OK1m4zvLwbsmOjvavrU+RuL+rk99/OMU9J/9l8KH9gMa/TWO7L727RgeG w==;
X-CSE-ConnectionGUID: BX/1AL8qRAOi3robrq2f1w==
X-CSE-MsgGUID: WvGlIY8fSQGq08QyRHC0nw==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="70809369"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="70809369"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 08:25:20 -0700
X-CSE-ConnectionGUID: YgGD0kILRQOCjHj9In01Ag==
X-CSE-MsgGUID: RorIeoQHRWCK4L/f3yT7VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="132125579"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by fmviesa003.fm.intel.com with ESMTP; 07 Apr 2025 08:25:19 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 05/10] net/ngbe: use common base code build handling
Date: Mon,  7 Apr 2025 16:25:04 +0100
Message-ID: <20250407152509.2203243-6-bruce.richardson@intel.com>
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
 drivers/net/ngbe/base/meson.build | 12 ++----------
 drivers/net/ngbe/meson.build      |  3 ---
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ngbe/base/meson.build b/drivers/net/ngbe/base/meson.build
index 86e78d4024..6932f648af 100644
--- a/drivers/net/ngbe/base/meson.build
+++ b/drivers/net/ngbe/base/meson.build
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2018-2021 Beijing WangXun Technology Co., Ltd.
 
-sources = [
+base_sources = files(
         'ngbe_eeprom.c',
         'ngbe_hw.c',
         'ngbe_mbx.c',
@@ -11,14 +11,6 @@ sources = [
         'ngbe_phy_mvl.c',
         'ngbe_phy_yt.c',
         'ngbe_vf.c',
-]
-
-error_cflags = []
+)
 
 cflags += no_wvla_cflag
-c_args = cflags
-
-base_lib = static_library('ngbe_base', sources,
-    dependencies: [static_rte_eal, static_rte_ethdev, static_rte_bus_pci],
-    c_args: c_args)
-base_objs = base_lib.extract_all_objects(recursive: true)
diff --git a/drivers/net/ngbe/meson.build b/drivers/net/ngbe/meson.build
index f4f8f7ee79..319eb23c35 100644
--- a/drivers/net/ngbe/meson.build
+++ b/drivers/net/ngbe/meson.build
@@ -8,7 +8,6 @@ if is_windows
 endif
 
 subdir('base')
-objs = [base_objs]
 
 sources = files(
         'ngbe_ethdev.c',
@@ -25,5 +24,3 @@ if arch_subdir == 'x86'
 elif arch_subdir == 'arm'
     sources += files('ngbe_rxtx_vec_neon.c')
 endif
-
-includes += include_directories('base')
-- 
2.45.2

