Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95264C3600B
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Mar 2025 16:11:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15D8E40B8D;
	Mon, 31 Mar 2025 18:10:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 8C16840B9A
 for <dev@dpdk.org>; Mon, 31 Mar 2025 18:10:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743437452; x=1774973452;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AnI+wpJ7YbhpdafFKc3njuN/5SeSoLtDq2JAMfL/aV0=;
 b=RfYlqzAMerL9AhrVj9i2SzxyaImSycL2O+8nF6WAZF6qy8+aGS2sEJtZ
 G5ynU1zjfQ5UQboN0YPUYRRAROoWBSZtyk7sig/RDJuksEO0XERftALBo
 mWb+MphXAjeqcCgDn9Qtszl2/f2+Ok6pQinytsPGuFJ3Urfo5vc8K9LX0
 UVUSO7YfkcaOT+/p54KT8usfW93syIpV/2IfrbY8uW8Ty+H5ESl2NRtkZ
 h645TjqCSIdz4nxnQA3yg2ykkgJeXmlKwQpRBVsB2OFkOCs6GSPKp3dib
 7Gejk6yQRx6CaOfMYr2ZBzFyatYsjaDXrmF5NRqYShx4sFPx2kss7URIo A==;
X-CSE-ConnectionGUID: lhlPigEOSk+biYRobygHbg==
X-CSE-MsgGUID: ZSnRo8qURc+Ue39KaKPS9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="62125741"
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; d="scan'208";a="62125741"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2025 09:10:51 -0700
X-CSE-ConnectionGUID: c/njZ0HoTWOWbMPt41XI5g==
X-CSE-MsgGUID: qWqTOTm4RAmmxa8kx5L3XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; d="scan'208";a="131132788"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by orviesa004.jf.intel.com with ESMTP; 31 Mar 2025 09:10:50 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH 09/10] net/txgbe: use common base code build handling
Date: Mon, 31 Mar 2025 17:09:59 +0100
Message-ID: <20250331161000.9886-11-bruce.richardson@intel.com>
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

