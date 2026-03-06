Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280ADF01834
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 13:17:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC905402D3;
	Fri,  6 Mar 2026 14:17:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 0D20540262
 for <dev@dpdk.org>; Fri,  6 Mar 2026 14:17:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772803057; x=1804339057;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=T8mZFhzBZ/sJF8BS7zt/g7prmRAP51GyVel0/EbEHng=;
 b=TXzoxAFcIIwwRM34v1GoHh1Og3xhCDSjocZv/oR5rOZR0aw5La+0KZ81
 dZjyyPl2bfZmdbOGoM8j1r4XIjdcbCPIM8dGpDaNI+xd2FiTquA69ZOQy
 zQirFJ0/z//82OaH9PQj896rsEoZrq5N4hzkBHLiPFBs0MD2A2lF1uH5g
 +R+WoX8XerykBk3iVG1akyCM9EFTH6KMc9jiaIZrpCwDsogJIMjJp3Pzd
 72JSQldebSLJHzS3Y+d6aKMNmRN6hb3oite6U/q0/f6bHu5sN97xLi+hf
 OVCDCZh8vfun0UWYJWqBGIC0DTEnaoRvA+bpiaNsroJWijrYfDX7ViaX9 A==;
X-CSE-ConnectionGUID: OBjrc1l8SpKX5mzHXGi3BA==
X-CSE-MsgGUID: mmzoejWoQ7mWv23s9KdQxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="73983719"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="73983719"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2026 05:17:36 -0800
X-CSE-ConnectionGUID: 412F2NH/Q1exg2TXttlQSw==
X-CSE-MsgGUID: 6rniKY9LRtOOkejPC8slAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="223491190"
Received: from icx005.iind.intel.com (HELO icx005..) ([10.190.212.217])
 by orviesa004.jf.intel.com with ESMTP; 06 Mar 2026 05:17:34 -0800
From: AKSHATHA S <akshathax.s@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: shaiq.wani@intel.com,
	AKSHATHA S <akshathax.s@intel.com>
Subject: [PATCH v2] net/e1000: align link updates in em igb and igc
Date: Fri,  6 Mar 2026 23:36:14 +0000
Message-ID: <20260306233614.11379-1-akshathax.s@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260305165142.89960-1-akshathax.s@intel.com>
References: <20260305165142.89960-1-akshathax.s@intel.com>
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

The em, igb, and igc PMDs currently update the auto-neg status only
during specific link transitions. Updated the auto-neg status regardless
of link transition so that it is consistent with ixgbe, i40e, and iavf
drivers.

Signed-off-by: AKSHATHA S <akshathax.s@intel.com>

v2: Addressed review comments
---
 drivers/net/intel/e1000/em_ethdev.c  | 5 ++---
 drivers/net/intel/e1000/igb_ethdev.c | 5 ++---
 drivers/net/intel/e1000/igc_ethdev.c | 5 ++---
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/net/intel/e1000/em_ethdev.c b/drivers/net/intel/e1000/em_ethdev.c
index ec3924bf6b..9e15e882b9 100644
--- a/drivers/net/intel/e1000/em_ethdev.c
+++ b/drivers/net/intel/e1000/em_ethdev.c
@@ -1240,14 +1240,13 @@ eth_em_link_update(struct rte_eth_dev *dev, int wait_to_complete)
 				RTE_ETH_LINK_HALF_DUPLEX;
 		link.link_speed = speed;
 		link.link_status = RTE_ETH_LINK_UP;
-		link.link_autoneg = !(dev->data->dev_conf.link_speeds &
-				RTE_ETH_LINK_SPEED_FIXED);
 	} else {
 		link.link_speed = RTE_ETH_SPEED_NUM_NONE;
 		link.link_duplex = RTE_ETH_LINK_HALF_DUPLEX;
 		link.link_status = RTE_ETH_LINK_DOWN;
-		link.link_autoneg = RTE_ETH_LINK_FIXED;
 	}
+	link.link_autoneg = !(dev->data->dev_conf.link_speeds &
+			RTE_ETH_LINK_SPEED_FIXED);
 
 	return rte_eth_linkstatus_set(dev, &link);
 }
diff --git a/drivers/net/intel/e1000/igb_ethdev.c b/drivers/net/intel/e1000/igb_ethdev.c
index 1f51ba6406..ef1599ac38 100644
--- a/drivers/net/intel/e1000/igb_ethdev.c
+++ b/drivers/net/intel/e1000/igb_ethdev.c
@@ -2568,14 +2568,13 @@ eth_igb_link_update(struct rte_eth_dev *dev, int wait_to_complete)
 				RTE_ETH_LINK_HALF_DUPLEX;
 		link.link_speed = speed;
 		link.link_status = RTE_ETH_LINK_UP;
-		link.link_autoneg = !(dev->data->dev_conf.link_speeds &
-				RTE_ETH_LINK_SPEED_FIXED);
 	} else if (!link_check) {
 		link.link_speed = 0;
 		link.link_duplex = RTE_ETH_LINK_HALF_DUPLEX;
 		link.link_status = RTE_ETH_LINK_DOWN;
-		link.link_autoneg = RTE_ETH_LINK_FIXED;
 	}
+	link.link_autoneg = !(dev->data->dev_conf.link_speeds &
+			RTE_ETH_LINK_SPEED_FIXED);
 
 	return rte_eth_linkstatus_set(dev, &link);
 }
diff --git a/drivers/net/intel/e1000/igc_ethdev.c b/drivers/net/intel/e1000/igc_ethdev.c
index 2155a67268..727ea36c2b 100644
--- a/drivers/net/intel/e1000/igc_ethdev.c
+++ b/drivers/net/intel/e1000/igc_ethdev.c
@@ -549,8 +549,6 @@ eth_igc_link_update(struct rte_eth_dev *dev, int wait_to_complete)
 				RTE_ETH_LINK_HALF_DUPLEX;
 		link.link_speed = speed;
 		link.link_status = RTE_ETH_LINK_UP;
-		link.link_autoneg = !(dev->data->dev_conf.link_speeds &
-				RTE_ETH_LINK_SPEED_FIXED);
 
 		if (speed == SPEED_2500) {
 			uint32_t tipg = E1000_READ_REG(hw, E1000_TIPG);
@@ -564,8 +562,9 @@ eth_igc_link_update(struct rte_eth_dev *dev, int wait_to_complete)
 		link.link_speed = 0;
 		link.link_duplex = RTE_ETH_LINK_HALF_DUPLEX;
 		link.link_status = RTE_ETH_LINK_DOWN;
-		link.link_autoneg = RTE_ETH_LINK_FIXED;
 	}
+	link.link_autoneg = !(dev->data->dev_conf.link_speeds &
+			RTE_ETH_LINK_SPEED_FIXED);
 
 	return rte_eth_linkstatus_set(dev, &link);
 }
-- 
2.43.0

