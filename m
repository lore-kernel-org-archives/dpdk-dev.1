Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D458FC36010
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 15:26:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64E0540E0C;
	Mon,  7 Apr 2025 17:25:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 1E50840C35
 for <dev@dpdk.org>; Mon,  7 Apr 2025 17:25:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744039524; x=1775575524;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AnI+wpJ7YbhpdafFKc3njuN/5SeSoLtDq2JAMfL/aV0=;
 b=aupCtpAGFcQpdLp8sIMfB6u2T7Qoe2Yt4IYJ+gGy+cnCGx3NGUaz5h7Q
 mh3shkKgNCjCmvNxho859TI28URy/nY/J+t9aZ7RdCnjFsi0Y+QfZr7pn
 RDTS9f21K+NTV0J5fXGQADfv8lxPf5i8D77K/eW/eGzwM0b0QyYpPI2mQ
 Tuo4JI9Agz9jlmqxO+EVHeTrNItBd7TxaJV3maJkaNF/OZKZibxiscC2x
 NMMJvcjNOtnyYprREdF8E8tMbyMEZcXTb2C2h9qGU40Df9vWNh6IRRh+h
 ZLlcYNny/dxC0vdidHV29QyE6OVkQceGAgWU5/MMoGpO3iODg9y7qMx7P A==;
X-CSE-ConnectionGUID: wBGXavLjSmmpgGi5ES0Xqw==
X-CSE-MsgGUID: FaWw7/tMRhmGFLLmO9OhpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="70809376"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="70809376"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 08:25:24 -0700
X-CSE-ConnectionGUID: ZwxP/cDZTLW/w3sSWxMRTQ==
X-CSE-MsgGUID: kbw25LubQlCcqNJc8q+PzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="132125591"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by fmviesa003.fm.intel.com with ESMTP; 07 Apr 2025 08:25:23 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 09/10] net/txgbe: use common base code build handling
Date: Mon,  7 Apr 2025 16:25:08 +0100
Message-ID: <20250407152509.2203243-10-bruce.richardson@intel.com>
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
 drivers/net/txgbe/base/meson.build | 18 ++----------------
 drivers/net/txgbe/meson.build      |  3 ---
 2 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/net/txgbe/base/meson.build b/drivers/net/txgbe/base/meson.build
index 4cf90a394a..0bb0782c92 100644
--- a/drivers/net/txgbe/base/meson.build
+++ b/drivers/net/txgbe/base/meson.build
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2015-2020 Beijing WangXun Technology Co., Ltd.
 
-sources = [
+base_sources = files(
         'txgbe_dcb_hw.c',
         'txgbe_dcb.c',
         'txgbe_eeprom.c',
@@ -10,18 +10,4 @@ sources = [
         'txgbe_mng.c',
         'txgbe_phy.c',
         'txgbe_vf.c',
-]
-
-error_cflags = []
-
-c_args = cflags
-foreach flag: error_cflags
-    if cc.has_argument(flag)
-        c_args += flag
-    endif
-endforeach
-
-base_lib = static_library('txgbe_base', sources,
-    dependencies: [static_rte_eal, static_rte_net, static_rte_bus_pci],
-    c_args: c_args)
-base_objs = base_lib.extract_all_objects(recursive: true)
+)
diff --git a/drivers/net/txgbe/meson.build b/drivers/net/txgbe/meson.build
index d9ca3743e2..4dbbf597bb 100644
--- a/drivers/net/txgbe/meson.build
+++ b/drivers/net/txgbe/meson.build
@@ -8,7 +8,6 @@ if is_windows
 endif
 
 subdir('base')
-objs = [base_objs]
 
 sources = files(
         'txgbe_ethdev.c',
@@ -32,6 +31,4 @@ elif arch_subdir == 'arm'
     sources += files('txgbe_rxtx_vec_neon.c')
 endif
 
-includes += include_directories('base')
-
 install_headers('rte_pmd_txgbe.h')
-- 
2.45.2

