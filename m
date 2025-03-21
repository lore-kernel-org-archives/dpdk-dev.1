Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B847C36005
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Mar 2025 17:12:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8DD640276;
	Fri, 21 Mar 2025 18:12:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 0D1AE40156;
 Fri, 21 Mar 2025 18:12:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742577141; x=1774113141;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=80DkGGlzbB5pgIm8TvjR1OOMr2rLycelPjc0xtr+psI=;
 b=N3EeFETy6vRhyaHkLgGAjLo87e3C+bct8S3va35VNdb9DFU1UtAC3Zj3
 xjRcaFi6xFM/1efUYmW9j2+5wEK9pFXv68T1EbFhfQtICXqjMMwgGF3de
 7RpqnfHTWNGyzQRGyID91uFpyw6SsgWHXWYb0I0YYJQ7/V0aozpIOgx5a
 /Zp2um2d14zxEGwjf+eZJhk3s+4t6ifVugtCSHf7BBZK4U0YJr/9r9drX
 hPLyHgbnxVetRoueez6wa+pUZ8KQOJVVqxZhrCKK1qtSBpO8sj2DmhjV8
 xM/W7JSho36FCRuIYLfNhpFo29BQO7KEfO0ASomBw1rOJz16vVDhGxLJl w==;
X-CSE-ConnectionGUID: zaDiUCtfSQqPtcZIj3fcoA==
X-CSE-MsgGUID: 3Z4tizP4Rj+dUVR7wJJ/TQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="66313566"
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; d="scan'208";a="66313566"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2025 10:12:20 -0700
X-CSE-ConnectionGUID: +YnL1RdQShiJTXKDUADVng==
X-CSE-MsgGUID: QeeXPM/jSGG/+vJS1erTEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; d="scan'208";a="154460591"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by fmviesa001.fm.intel.com with ESMTP; 21 Mar 2025 10:12:18 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH] net/ixgbe: fix missing checks for E610 VFs
Date: Fri, 21 Mar 2025 17:12:11 +0000
Message-ID: <20250321171211.386594-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
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

A number of places in the ixgbe code check for a virtual function, but
these checks were missing the identifier for the E610 VF. Add them into
the conditionals.

Fixes: f678f3dea8fd ("net/ixgbe: fix missing VF PCI ID")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_rxtx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index 3b7a6a6f0e..0c8a9ec763 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -2767,6 +2767,7 @@ ixgbe_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	 * Modification to set VFTDT for virtual function if vf is detected
 	 */
 	if (hw->mac.type == ixgbe_mac_82599_vf ||
+	    hw->mac.type == ixgbe_mac_E610_vf ||
 	    hw->mac.type == ixgbe_mac_X540_vf ||
 	    hw->mac.type == ixgbe_mac_X550_vf ||
 	    hw->mac.type == ixgbe_mac_X550EM_x_vf ||
@@ -2987,6 +2988,7 @@ ixgbe_is_vf(struct rte_eth_dev *dev)
 	case ixgbe_mac_X550_vf:
 	case ixgbe_mac_X550EM_x_vf:
 	case ixgbe_mac_X550EM_a_vf:
+	case ixgbe_mac_E610_vf:
 		return 1;
 	default:
 		return 0;
@@ -3153,6 +3155,7 @@ ixgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	 * Modified to setup VFRDT for Virtual Function
 	 */
 	if (hw->mac.type == ixgbe_mac_82599_vf ||
+	    hw->mac.type == ixgbe_mac_E610_vf ||
 	    hw->mac.type == ixgbe_mac_X540_vf ||
 	    hw->mac.type == ixgbe_mac_X550_vf ||
 	    hw->mac.type == ixgbe_mac_X550EM_x_vf ||
@@ -5835,6 +5838,7 @@ ixgbevf_dev_rx_init(struct rte_eth_dev *dev)
 	case ixgbe_mac_X550_vf:
 	case ixgbe_mac_X550EM_x_vf:
 	case ixgbe_mac_X550EM_a_vf:
+	case ixgbe_mac_E610_vf:
 		switch (dev->data->dev_conf.rxmode.mq_mode) {
 		case RTE_ETH_MQ_RX_RSS:
 		case RTE_ETH_MQ_RX_DCB_RSS:
-- 
2.45.2

