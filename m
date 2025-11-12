Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56C0CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 15:11:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F09F24066A;
	Wed, 12 Nov 2025 16:11:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 8B2ED402AF
 for <dev@dpdk.org>; Wed, 12 Nov 2025 16:11:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762960300; x=1794496300;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=4SPr0TTmsipGLSt+dFjJ0Gbu7ODvc/P/3IMtJGTr8jM=;
 b=BYABDwaQ9+Nom2lpT65TS0IHG7hKwDN9UBkI2USivDzSjwFZQvx2CUWS
 PdijDaUPhTEcL9NDQ6UuSIySXpPcgd0Gzn966FYj29HWRanUZcWreeQMH
 F6XbAmI6wZmfEjk02cAqnOsZZ66mg+6vqU2qBkFZnUheGHv/i5y0PXtK7
 OajhIO5r8t+lXXASu2bPohuQtuR5aeCffKR9qLmvhIUMrMs6cRjjgTiQr
 Ok7SCaKbaW8dGLDHe664p9fRx4bgZ95jMWE/xKRAqfID/ONrHKWDKkdGA
 L94PpMWieKOqI0L+aD/kzTpznO0RbXH1ga73Q46NA1f3X5jJ8VGqApPX/ Q==;
X-CSE-ConnectionGUID: XuSJoEzQQo+IZBkl3Gt9ew==
X-CSE-MsgGUID: CUWanS7GS5+po50Np6Scmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="90496091"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; d="scan'208";a="90496091"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 07:11:38 -0800
X-CSE-ConnectionGUID: i601OqcEQmW5MJ/zNFRnBg==
X-CSE-MsgGUID: jxVZvFoUR5KUT3x1Ngjx3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; d="scan'208";a="189223952"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa007.jf.intel.com with ESMTP; 12 Nov 2025 07:11:38 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH] net/intel: ensure correct Rx path is selected
Date: Wed, 12 Nov 2025 15:11:23 +0000
Message-Id: <20251112151123.3757688-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
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

The common rx path selection logic iterates through an array of
candidate paths and selects the best fit for the requested features.
Currently, in the event that two potential candidates are identified,
the one with the fewer offloads (and thus less complex path) is
selected. However this is not correct, because if the path with more
offloads has a greater SIMD width, that should be chosen. This commit
reworks the logic so that the number of offloads is only taken into
consideration when choosing between two paths with the same SIMD width.

Since the paths arrays are ordered from lowest SIMD width to highest,
and vector paths tend to have fewer offloads enabled than scalar paths,
"new" candidate paths with greater SIMDs widths tended to have fewer or
equal offloads than the "current" candidate paths and thus were
correctly accepted as the best candidate. For this reason the incorrect
logic did not cause any incorrect path selections in practise.

Fixes: 9d99641d80a0 ("net/intel: introduce infrastructure for Rx path selection")

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/common/rx.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
index 5012e4fced..9fa3cdc64d 100644
--- a/drivers/net/intel/common/rx.h
+++ b/drivers/net/intel/common/rx.h
@@ -300,8 +300,11 @@ ci_rx_path_select(struct ci_rx_path_features req_features,
 			/* Do not select paths with lower SIMD width than the current path. */
 			if (path_features->simd_width < current_features->simd_width)
 				continue;
-			/* Do not select paths with more offloads enabled than the current path. */
-			if (rte_popcount32(path_features->rx_offloads) >
+			/* Do not select paths with more offloads enabled than the current path if
+			 * the SIMD widths are the same.
+			 */
+			if (path_features->simd_width == current_features->simd_width &&
+					rte_popcount32(path_features->rx_offloads) >
 					rte_popcount32(current_features->rx_offloads))
 				continue;
 			/* Do not select paths without bulk alloc support if requested and the
-- 
2.34.1

