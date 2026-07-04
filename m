Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BDAC43458
	for <dpdk-dev@archiver.kernel.org>; Sat,  4 Jul 2026 11:58:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D3EF402D5;
	Sat,  4 Jul 2026 13:58:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id B42BC402D4
 for <dev@dpdk.org>; Sat,  4 Jul 2026 13:58:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783166327; x=1814702327;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=pFwPRNQPIImtIxCaMM42Cj1XbpwHi7cczZNyK2n/BII=;
 b=JPYe+24DH9/kHzDqjfbf3OfhZ9Tfj9JIM4dgmFgCi1+cCnASfGlq7s+u
 69mDuc/8kAbKtpk8nHE1CvCtwm7fb8u39cFjLAA7a0gY+4hwSID5W+DjX
 RKuuZdpdzx3j14JJWVpTP9lV8AJz8IoTcXNT3AOwrvLx3QyPfOnH5fiXJ
 DYb45cGrAxeikIqJTHtV7hZPtJVURCkPfvtHqL8YfK1ltbyQEu4oSEAKC
 knW7WHTGdax0vDNbB9P9fqDbOwkdq9zdkSXVE8oqJIG2JFb8qGxvJhCCh
 yHrlBsr2/4r8ykz78G0/Uo0U7aycISYvu72soEj5kFa+nS7TB0SmvrBfb Q==;
X-CSE-ConnectionGUID: DXx4rNPVTGuM499ZM3RiVg==
X-CSE-MsgGUID: d8vWIyXzQYGcMlrfTtARzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11836"; a="84007058"
X-IronPort-AV: E=Sophos;i="6.25,147,1779174000"; d="scan'208";a="84007058"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2026 04:58:46 -0700
X-CSE-ConnectionGUID: Eml3O2yoTQ2XJvZ8v+w4BQ==
X-CSE-MsgGUID: rlFDwkhnS/64h8tIbggcTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,147,1779174000"; d="scan'208";a="255211473"
Received: from npg-npf-wlpr-srv12.iind.intel.com ([10.190.212.253])
 by fmviesa004.fm.intel.com with ESMTP; 04 Jul 2026 04:58:44 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org, aman.deep.singh@intel.com, manoj.kumar.subbarao@intel.com,
 bruce.richardson@intel.com
Subject: [PATCH] net/ice: gate send on timestamp offload to E830
Date: Sat,  4 Jul 2026 17:28:06 +0530
Message-Id: <20260704115806.372175-1-soumyadeep.hore@intel.com>
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

The SEND_ON_TIMESTAMP TX offload capability was unconditionally
advertised for all ice devices in non-safe mode. However, only E830
hardware supports TxPP (Tx Packet Pacing) via the TXTIME queue
mechanism. E810 and other ice devices correctly reject the offload
at queue setup time (ice_tx_queue_setup checks hw->phy_model), but
advertising the capability misleads applications into thinking the
feature is available.

Gate the SEND_ON_TIMESTAMP capability advertisement on
hw->phy_model == ICE_PHY_E830 so that only devices which actually
support TxPP report the capability.

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 0f2e7aee14..030d53aded 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -4568,8 +4568,10 @@ ice_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 			RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO |
 			RTE_ETH_TX_OFFLOAD_GRE_TNL_TSO |
 			RTE_ETH_TX_OFFLOAD_IPIP_TNL_TSO |
-			RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO |
-			RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP;
+			RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO;
+		if (hw->phy_model == ICE_PHY_E830)
+			dev_info->tx_offload_capa |=
+				RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP;
 		dev_info->flow_type_rss_offloads |= ICE_RSS_OFFLOAD_ALL;
 	}
 
-- 
2.34.1

