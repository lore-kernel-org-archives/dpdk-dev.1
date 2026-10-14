Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B1ECC6B1D
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:14:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39B7E40B9F;
	Wed, 14 Oct 2026 17:14:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 0914440A77;
 Wed, 14 Oct 2026 17:14:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791990856; x=1823526856;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=T4QKPvS6omErhGm0QpHmBbvKGeD5ilmBMGbYMV9KpjQ=;
 b=RQWj+1Bk0tHjvhIYHAi3+dk+sQhivZroliXJshnZ106Uy1gq/za1ey9q
 OTfqqbYDrgfJQydnNN8vf8iwPoevkFSGOTP8abChMGFGXiW4zsPNp6x8L
 1kNDe5RflMnlCn4vnWDWtD983wHpGQH+G8hzi4JU9pyJO8HfaW76WgQsJ
 ih3g4RYf9oQx92JYTcS2XoPeWJ0HifoqdV4DY8fCbNhUEUT31zqvCf4hP
 OcCBtc+17CWJMgozCjci9jjO9bnbXXNcsSf2CZMzUBgpZI8MiIZJ4Hjrw
 qsE7FK5PaFJxQBplkUj7d7ZPBsrQ0ZZhqXVVeT8EB/+zbZ7yPTUZCE9cW A==;
X-CSE-ConnectionGUID: 7jU2mVKkSbmXTJyDWFdsrw==
X-CSE-MsgGUID: GlX3DGplReeMnW6EiO5BEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="642337"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="642337"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 08:14:07 -0700
X-CSE-ConnectionGUID: mYUCnS/qTEiaNF3MTjLTMA==
X-CSE-MsgGUID: cHNWz6QeTBmnYJ2LU1JPNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1785418"
Received: from pae-31.iind.intel.com ([10.49.105.72])
 by fmviesa008.fm.intel.com with ESMTP; 14 Oct 2026 08:14:05 -0700
From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
To: dev@dpdk.org
Cc: Gaetan Rivet <grive@u256.net>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Subject: [PATCH v2 3/5] net/failsafe: fix MAC address pool size and replay
Date: Wed, 14 Oct 2026 22:16:02 +0000
Message-Id: <20261014221604.128677-4-sandeep.penigalapati@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261014221604.128677-1-sandeep.penigalapati@intel.com>
References: <20261014194257.123356-1-sandeep.penigalapati@intel.com>
 <20261014221604.128677-1-sandeep.penigalapati@intel.com>
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
index 0b025bd122..f0c12dfaa3 100644
--- a/drivers/net/failsafe/failsafe_ops.c
+++ b/drivers/net/failsafe/failsafe_ops.c
@@ -1462,7 +1462,7 @@ fs_mac_addr_add(struct rte_eth_dev *dev,
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

