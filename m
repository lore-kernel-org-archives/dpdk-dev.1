Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FB9CC6B1D
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 12:43:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8A5D40682;
	Wed, 14 Oct 2026 14:43:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id BDB3440144;
 Wed, 14 Oct 2026 14:43:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791981807; x=1823517807;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=E8S0OJwjfyYV682n255hD36pxmtvY1bYjPs9Gqd83LI=;
 b=WuL487gb2tYo2kqyY8IxI7g9bWHWRdOqPkwcxi57JWKDTAo1Su03gGJy
 MuLIO/GBPtwfbKAp2gjrZo9cVJFhDcKYWhL1bVyVTDApoJyt5F1CUXbyq
 VqwAnXBe1hKKyKLCFv0zbxPn0g+3bG4gWAPk3ky8mq7W5Udkm+4nH1cWY
 xyafa6tS8JVSYxrXvcOrR2sVMLDynh4hFoRVHXorUoW0SDycNV+K61SqX
 0bn6FPdoAwHePHuZ0J675fY4p1Vtwd88f8G6f60bhrYF5RYh4rQFuVNNY
 fW60COx5AhaYDR+xwzHnrPODmApqBVC84suzssYXQVBMg3SbJyGgWX6Mn w==;
X-CSE-ConnectionGUID: Ubmlso0AQfWulam1ZLkDiw==
X-CSE-MsgGUID: PWUss/01RRClP7o3NCGFYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="625466"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="625466"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 05:41:26 -0700
X-CSE-ConnectionGUID: /PBCTcGeTt6dvdcoFuUlBw==
X-CSE-MsgGUID: cVkpKcIWT660VVxv1sqHaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1342553"
Received: from pae-31.iind.intel.com ([10.49.105.72])
 by orviesa008.jf.intel.com with ESMTP; 14 Oct 2026 05:41:26 -0700
From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
To: dev@dpdk.org
Cc: Gaetan Rivet <grive@u256.net>, stable@dpdk.org,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Subject: [PATCH 3/5] net/failsafe: fix MAC address pool size and replay
Date: Wed, 14 Oct 2026 19:42:55 +0000
Message-Id: <20261014194257.123356-4-sandeep.penigalapati@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261014194257.123356-1-sandeep.penigalapati@intel.com>
References: <20261014194257.123356-1-sandeep.penigalapati@intel.com>
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

Two issues affect fail-safe MAC address handling:

- fs_mac_addr_add() grew the pool but set nb_mac_addr to the index of
  the new entry instead of the entry count (index + 1). The pool size
  was off by one and the last added address was dropped when the
  configuration was replayed to a sub-device.

- fs_eth_dev_conf_apply() replayed every slot of the MAC address array
  to a (re)plugged sub-device, including slots left zeroed by a
  previous remove, which made rte_eth_dev_mac_addr_add() fail on the
  all-zero address.

Set nb_mac_addr to index + 1 and skip zeroed slots when replaying the
MAC addresses.

Fixes: a46f8d584eb8 ("net/failsafe: add fail-safe PMD")
Fixes: ebea83f899d8 ("net/failsafe: add plug-in support")
Cc: stable@dpdk.org
Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
---
 drivers/net/failsafe/failsafe_ether.c | 3 +++
 drivers/net/failsafe/failsafe_ops.c   | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/failsafe/failsafe_ether.c b/drivers/net/failsafe/failsafe_ether.c
index 4eaa337f55..ea12e2722f 100644
--- a/drivers/net/failsafe/failsafe_ether.c
+++ b/drivers/net/failsafe/failsafe_ether.c
@@ -177,6 +177,9 @@ fs_eth_dev_conf_apply(struct rte_eth_dev *dev,
 		struct rte_ether_addr *ea;
 
 		ea = &dev->data->mac_addrs[i];
+		/* Removed addresses leave a zeroed slot. */
+		if (rte_is_zero_ether_addr(ea))
+			continue;
 		ret = rte_eth_dev_mac_addr_add(PORT_ID(sdev), ea,
 				PRIV(dev)->mac_addr_pool[i]);
 		if (ret) {
diff --git a/drivers/net/failsafe/failsafe_ops.c b/drivers/net/failsafe/failsafe_ops.c
index 79aa57cb35..56c7c884a1 100644
--- a/drivers/net/failsafe/failsafe_ops.c
+++ b/drivers/net/failsafe/failsafe_ops.c
@@ -1460,7 +1460,7 @@ fs_mac_addr_add(struct rte_eth_dev *dev,
 	}
 	if (index >= PRIV(dev)->nb_mac_addr) {
 		DEBUG("Growing mac_addrs array");
-		PRIV(dev)->nb_mac_addr = index;
+		PRIV(dev)->nb_mac_addr = index + 1;
 	}
 	PRIV(dev)->mac_addr_pool[index] = vmdq;
 	fs_unlock(dev, 0);
-- 
2.34.1

