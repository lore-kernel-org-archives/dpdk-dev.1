Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB90CD4F5B
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 16:09:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A4C94067C;
	Tue, 19 May 2026 18:08:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 727D140665
 for <dev@dpdk.org>; Tue, 19 May 2026 18:08:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779206922; x=1810742922;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=76sI3o2vFkfMHQ5JYur3Oo9oV3lZsfNsgOSB7PcT6dk=;
 b=clmm9rHwvtvohesyJIqPqQ32wsUUX9LUJ7jFrKizrxbJHZkgsm7Chh2K
 YlvkeYhDJFa9Ea0x9FV2dakQImTbllrfod38CIepx8msZmYfDhdKGqREE
 Bve3sRnV+V5Fgz3KDBeg2j3X0B2ib9MsZp0VUvY8ig8g446ciGr48X3dL
 HCM80kdqW4C6ijpBrjjMoSMYr6zCznW7MywGjO7Nq5Jbh84HjaZUzOx1a
 r8GcnBZ6J9Glz1pAZV76XNxtnKx4ovH793lthNtkdr2ZLBuGgwaNwaTKf
 pT/H/N7hYovXT7pjLjW2vyr5Dlwe2Bb7vHc+5eeF4Nw9GZQq596JWRaDW g==;
X-CSE-ConnectionGUID: 5adTkbt6Ss+HXUs/kzkC5Q==
X-CSE-MsgGUID: Y7ccTxmyR4WKMrFu4sLpqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80070061"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="80070061"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 09:08:41 -0700
X-CSE-ConnectionGUID: rx0wNDEiTgiNHVxCDrlxxw==
X-CSE-MsgGUID: Pvk+WyTeS5Ocl9mKctT+rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="244784786"
Received: from silpixa00401874.ir.intel.com (HELO
 silpixa00401874.ger.corp.intel.com) ([10.20.224.247])
 by orviesa005.jf.intel.com with ESMTP; 19 May 2026 09:08:40 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 5/8] net/e1000: replace use of DPDK-specific memcpy
 function
Date: Tue, 19 May 2026 16:06:02 +0000
Message-ID: <20260519160823.1004973-6-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260519160823.1004973-1-bruce.richardson@intel.com>
References: <20260519160823.1004973-1-bruce.richardson@intel.com>
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

The driver use of memcpy is for control path work, for example, flow
configuration and so is fine using the standard libc memcpy function in
place of the DPDK-specific rte_memcpy version.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/e1000/em_rxtx.c  | 1 -
 drivers/net/intel/e1000/igb_flow.c | 8 ++++----
 drivers/net/intel/e1000/igb_pf.c   | 5 ++---
 drivers/net/intel/e1000/igb_rxtx.c | 1 -
 4 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/net/intel/e1000/em_rxtx.c b/drivers/net/intel/e1000/em_rxtx.c
index 54971fe285..5879013a1d 100644
--- a/drivers/net/intel/e1000/em_rxtx.c
+++ b/drivers/net/intel/e1000/em_rxtx.c
@@ -20,7 +20,6 @@
 #include <rte_pci.h>
 #include <bus_pci_driver.h>
 #include <rte_memory.h>
-#include <rte_memcpy.h>
 #include <rte_memzone.h>
 #include <rte_launch.h>
 #include <rte_eal.h>
diff --git a/drivers/net/intel/e1000/igb_flow.c b/drivers/net/intel/e1000/igb_flow.c
index ea9b290e1c..ca76bf5ae4 100644
--- a/drivers/net/intel/e1000/igb_flow.c
+++ b/drivers/net/intel/e1000/igb_flow.c
@@ -1484,7 +1484,7 @@ igb_flow_create(struct rte_eth_dev *dev,
 				goto out;
 			}
 
-			rte_memcpy(&ntuple_filter_ptr->filter_info,
+			memcpy(&ntuple_filter_ptr->filter_info,
 				&ntuple_filter,
 				sizeof(struct rte_eth_ntuple_filter));
 			TAILQ_INSERT_TAIL(&igb_filter_ntuple_list,
@@ -1511,7 +1511,7 @@ igb_flow_create(struct rte_eth_dev *dev,
 				goto out;
 			}
 
-			rte_memcpy(&ethertype_filter_ptr->filter_info,
+			memcpy(&ethertype_filter_ptr->filter_info,
 				&ethertype_filter,
 				sizeof(struct rte_eth_ethertype_filter));
 			TAILQ_INSERT_TAIL(&igb_filter_ethertype_list,
@@ -1536,7 +1536,7 @@ igb_flow_create(struct rte_eth_dev *dev,
 				goto out;
 			}
 
-			rte_memcpy(&syn_filter_ptr->filter_info,
+			memcpy(&syn_filter_ptr->filter_info,
 				&syn_filter,
 				sizeof(struct rte_eth_syn_filter));
 			TAILQ_INSERT_TAIL(&igb_filter_syn_list,
@@ -1562,7 +1562,7 @@ igb_flow_create(struct rte_eth_dev *dev,
 				goto out;
 			}
 
-			rte_memcpy(&flex_filter_ptr->filter_info,
+			memcpy(&flex_filter_ptr->filter_info,
 				&flex_filter,
 				sizeof(struct igb_flex_filter));
 			TAILQ_INSERT_TAIL(&igb_filter_flex_list,
diff --git a/drivers/net/intel/e1000/igb_pf.c b/drivers/net/intel/e1000/igb_pf.c
index c7588ea57e..a3327e0bf0 100644
--- a/drivers/net/intel/e1000/igb_pf.c
+++ b/drivers/net/intel/e1000/igb_pf.c
@@ -17,7 +17,6 @@
 #include <rte_eal.h>
 #include <rte_ether.h>
 #include <ethdev_driver.h>
-#include <rte_memcpy.h>
 #include <rte_malloc.h>
 #include <rte_random.h>
 
@@ -290,7 +289,7 @@ igb_vf_reset(struct rte_eth_dev *dev, uint16_t vf, uint32_t *msgbuf)
 
 	/* reply to reset with ack and vf mac address */
 	msgbuf[0] = E1000_VF_RESET | E1000_VT_MSGTYPE_ACK;
-	rte_memcpy(new_mac, vf_mac, RTE_ETHER_ADDR_LEN);
+	memcpy(new_mac, vf_mac, RTE_ETHER_ADDR_LEN);
 	e1000_write_mbx(hw, msgbuf, 3, vf);
 
 	return 0;
@@ -308,7 +307,7 @@ igb_vf_set_mac_addr(struct rte_eth_dev *dev, uint32_t vf, uint32_t *msgbuf)
 
 	if (rte_is_unicast_ether_addr((struct rte_ether_addr *)new_mac)) {
 		if (!rte_is_zero_ether_addr((struct rte_ether_addr *)new_mac))
-			rte_memcpy(vfinfo[vf].vf_mac_addresses, new_mac,
+			memcpy(vfinfo[vf].vf_mac_addresses, new_mac,
 				sizeof(vfinfo[vf].vf_mac_addresses));
 		hw->mac.ops.rar_set(hw, new_mac, rar_entry);
 		rah = E1000_READ_REG(hw, E1000_RAH(rar_entry));
diff --git a/drivers/net/intel/e1000/igb_rxtx.c b/drivers/net/intel/e1000/igb_rxtx.c
index 14b2858817..4fda5d57a0 100644
--- a/drivers/net/intel/e1000/igb_rxtx.c
+++ b/drivers/net/intel/e1000/igb_rxtx.c
@@ -19,7 +19,6 @@
 #include <rte_debug.h>
 #include <rte_pci.h>
 #include <rte_memory.h>
-#include <rte_memcpy.h>
 #include <rte_memzone.h>
 #include <rte_launch.h>
 #include <rte_eal.h>
-- 
2.51.0

