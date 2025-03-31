Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72732C36010
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Mar 2025 16:10:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC26140A84;
	Mon, 31 Mar 2025 18:10:43 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 2460B406A2
 for <dev@dpdk.org>; Mon, 31 Mar 2025 18:10:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743437442; x=1774973442;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CP3gXYsJhuruklW7LTEPwDgPNFPaXNkzNaRNCxlSBOg=;
 b=mSR+FvMRH7CJXmxQRqetGMnV8zmCg7GyOo8jIFSQOldmVRmGOpTvRUdd
 ujby1zumfh8uPKTOjY1VXBv7avdCUndrpxJs7e5JF2lTDG5j14RvM6zP/
 zk5Gl68eu6gSJX9LknrSop3ve7PqikZIS78v5IFL01bnthHXshhOGcXdf
 Z/Sn60i2nbZxHhch2kpMnZQy2M0lApgUkY/6IJO9a18okyoxdD3gxmEVz
 VgWhSFGnOo9H3uVlIFPv8UxzKgPZe7f6W3O4/drPfck7SfQdJ/FFiQC7n
 FcESmP9xxLt5lg8T2QXOiDe400zf8fWLjtQxLDYpUG255NTQR1jYRHBm9 g==;
X-CSE-ConnectionGUID: 3bUVKtYNQi6RS0xuVGh0nw==
X-CSE-MsgGUID: YgL04T/RRSeVxb20XUz3yA==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="62125716"
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; d="scan'208";a="62125716"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2025 09:10:42 -0700
X-CSE-ConnectionGUID: BQCMD9l/R8+S2crwtv9gfA==
X-CSE-MsgGUID: uZGHgcEGRVi77TDm9cywtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; d="scan'208";a="131132763"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by orviesa004.jf.intel.com with ESMTP; 31 Mar 2025 09:10:41 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH 05/10] net/ngbe: use common base code build handling
Date: Mon, 31 Mar 2025 17:09:55 +0100
Message-ID: <20250331161000.9886-7-bruce.richardson@intel.com>
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

