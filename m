Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C96CC6B34
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 09:17:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1489F40682;
	Thu, 15 Oct 2026 11:17:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 1E58A4026E;
 Thu, 15 Oct 2026 11:17:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792055853; x=1823591853;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Z8zWl6UTuCK1ZeyRiPxBMLN3edTvIFGQzvM2miszrNE=;
 b=fdmboTZfUQ+9YQuM2sjcgunIyLHAOOX1yDteI247TORUPt4qMAxEzfQW
 7uNI3wA/5d1H5Xy48ghGGEUKQHunhRpiBsZJBUPonSlz7F4BjoHc2Ovk4
 gETpDCqGbpDBp1ZgsgEwXAXnYoJgA0rfZCNp55IYlCySP658BVT9JlT1A
 WckOQlS5TNSs6DKvkiJkIQ9n6MAU7xKBAOs1yuEDM85Q8gzmmSKidmlIy
 JCO39i2AWEfXFuwMkf/ogzvVDYAOChI0reEM1V6T4g6wjof657cZx1src
 2EfssiMkyggWyxP934Hl//5syWvHCyFGwnbL5cAJ68eoCNmeu/iyAO8aN w==;
X-CSE-ConnectionGUID: oy3il/Z7RXabIFKlAZyZpw==
X-CSE-MsgGUID: z1eubA9MQXy0rA3byKiDjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="808474"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="808474"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 02:17:32 -0700
X-CSE-ConnectionGUID: rD6B36puSqipbUwUwx3ltw==
X-CSE-MsgGUID: scI4IFomTyWeODSpqZ+RJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="2000361"
Received: from pae-31.iind.intel.com ([10.49.105.72])
 by fmviesa009.fm.intel.com with ESMTP; 15 Oct 2026 02:17:31 -0700
From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
To: dev@dpdk.org
Cc: grive@u256.net, stephen@networkplumber.org, stable@dpdk.org,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Subject: [PATCH v3 3/6] net/failsafe: fix MAC address pool size and replay
Date: Thu, 15 Oct 2026 16:19:24 +0000
Message-Id: <20261015161927.194886-4-sandeep.penigalapati@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261015161927.194886-1-sandeep.penigalapati@intel.com>
References: <20261014221604.128677-1-sandeep.penigalapati@intel.com>
 <20261015161927.194886-1-sandeep.penigalapati@intel.com>
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
index 1702b1a604..21779f9be8 100644
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

