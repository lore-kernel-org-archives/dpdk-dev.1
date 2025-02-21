Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D350C021B3
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Feb 2025 16:04:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF89D402CC;
	Fri, 21 Feb 2025 17:04:17 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id F18C6402BB
 for <dev@dpdk.org>; Fri, 21 Feb 2025 17:04:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740153855; x=1771689855;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=KdjIaPgT/KbhZ9rpI8T3F6/3c4Xp8OFHkE/UEtgJ7a0=;
 b=PQx96+MF5/F2w0tIzvaKK6BI0XH+rqD/hLNJbz9bEXCsMigOH+KqQ19x
 LKCzsk6PVAGE3AKp2UZBNgYO+41xGH97029GVXe+z3FnfMb07SsVK8o3P
 51t+dNwK4Y4iMJPQBjC5lmU+Pfye1qvgCbbiGgNw5VnaTEyumhn97Pyqn
 UOCUCSM8+BsPKN/z3/E1XtFfTArwd3GxN39NtVeuLcUdYrZ9hB4RrTVUZ
 v4huLSMMqHjCRcRGPeBoKQrmc2BE7q6YMiEbqcffLL4Gr1ia8qMPp3Xrc
 rXBqug0/Tnx98C471V5vPdKZsXxhrjwyqsmzwGI2M4ii+84wxGS1/HWOG A==;
X-CSE-ConnectionGUID: mPt0IbuUTDiWbGK9buzDEg==
X-CSE-MsgGUID: eVDIUAHEQo+tRbUkP7zbyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="43807864"
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; d="scan'208";a="43807864"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Feb 2025 08:04:14 -0800
X-CSE-ConnectionGUID: BCmU4s0kSMyUKEMFTjFVsw==
X-CSE-MsgGUID: kUaMV+8fRXuWD5w4XYkP7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; d="scan'208";a="115416079"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.22])
 by fmviesa007.fm.intel.com with ESMTP; 21 Feb 2025 08:04:12 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>
Subject: [PATCH] net/ice: fix incorrect mbuf cleanup function
Date: Fri, 21 Feb 2025 16:04:02 +0000
Message-ID: <20250221160402.855510-1-bruce.richardson@intel.com>
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

The mbuf cleanup function is not being called correctly on close of the
driver, due to the vector_tx flag not being set correctly on each Tx
queue. Normally, this causes no visible problems, because the default is
to have the vector flag unset, which means that, if vector Tx path is
chosen, we only free every second mbuf in the descriptor vector ring - a
subtle memory leak.

The reverse case - where we initially configure a port to use a vector
driver, and then later reconfigure it for scalar - causes a segfault on
close, as the vector cleanup is used on a scalar SW ring, and that
vector path treats the extra metadata in the SW ring as mbufs to be
freed.

This is due to an inconsistency across drivers on port start: in e.g.
the i40e driver, the Rx and Tx functions are chosen before the
individual queues are started, while in ice driver the order is
reversed.  Because the Tx function selection is done after the queues
are initialized, the initialized queues use an old value of the overall
flag indicating if a vector Tx path is being used.

Fix the issue by moving the Rx and Tx path selection before queue start.

Fixes: 552979dfb1c9 ("net/intel: create common Tx queue mbuf cleanup")

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 0e092702cc..3cdfa16f77 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -3961,6 +3961,9 @@ ice_dev_start(struct rte_eth_dev *dev)
 	ice_declare_bitmap(pmask, ICE_PROMISC_MAX);
 	ice_zero_bitmap(pmask, ICE_PROMISC_MAX);
 
+	ice_set_rx_function(dev);
+	ice_set_tx_function(dev);
+
 	/* program Tx queues' context in hardware */
 	for (nb_txq = 0; nb_txq < data->nb_tx_queues; nb_txq++) {
 		ret = ice_tx_queue_start(dev, nb_txq);
@@ -3989,9 +3992,6 @@ ice_dev_start(struct rte_eth_dev *dev)
 		}
 	}
 
-	ice_set_rx_function(dev);
-	ice_set_tx_function(dev);
-
 	mask = RTE_ETH_VLAN_STRIP_MASK | RTE_ETH_VLAN_FILTER_MASK |
 			RTE_ETH_VLAN_EXTEND_MASK;
 	if (ice_is_dvm_ena(hw))
-- 
2.43.0

