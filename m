Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840E4CC6B1D
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 12:43:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD94B4060A;
	Wed, 14 Oct 2026 14:43:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 0670A40144;
 Wed, 14 Oct 2026 14:43:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791981806; x=1823517806;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CCbziOdBT8QPOzyl1zqF3gaIKllaJRXB4EYwtaxuqV4=;
 b=BNTxNxAMLMUgKPXg/60VH9xQi2z2qLQlvSgR5c1IeziWjoHZPzCFWRxG
 em7PRvSEwqj12EMoUCPPNjj6aeepBZiEFsQu/AVqrjBqtaRp82MmVSBv0
 ST3LTyeNTRwwxZgQL6Qb1Bq8b5ltVa0E1mZyJH5/ZhvSovL45NKQUiaDO
 CSHREp2syjvmjfhwNvSNEm1rQlAAKWBijkz5ZF6BEUOFDtbRMqgwvAV24
 m4EX6CfefiAhvfXwh7hfII0bvp7cYl2Oq9YifLwPN1fk/OedEzIWisJLo
 dbScGldelIaOjAJsX2UZrVhOLxg7qlpCKvZQXXN5U/XKBFv/LWNyuEPgo A==;
X-CSE-ConnectionGUID: nIVzWVsTTVarcIFbjP+8Sg==
X-CSE-MsgGUID: E+vBdw9dQZuGUa18ULMY/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="625448"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="625448"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 05:41:20 -0700
X-CSE-ConnectionGUID: Lw1E7ECwTOentRsvbOzeAQ==
X-CSE-MsgGUID: MQyQevMnS3i0on8xgEuqSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1342527"
Received: from pae-31.iind.intel.com ([10.49.105.72])
 by orviesa008.jf.intel.com with ESMTP; 14 Oct 2026 05:41:19 -0700
From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
To: dev@dpdk.org
Cc: Gaetan Rivet <grive@u256.net>, stable@dpdk.org,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Subject: [PATCH 1/5] net/failsafe: fix double release of sub-device port
Date: Wed, 14 Oct 2026 19:42:53 +0000
Message-Id: <20261014194257.123356-2-sandeep.penigalapati@intel.com>
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

When a sub-device is removed, fs_dev_remove() detaches the underlying
bus device, and that remove path already releases the ethdev port of
the sub-device. The fail-safe code then called
rte_eth_dev_release_port() a second time on the same port, resulting in
a double release of the port during hot-unplug.

Drop the redundant rte_eth_dev_release_port() call and let the bus
remove path own the release of the port.

Fixes: fac0ae546e5f ("net/failsafe: free port by dedicated function")
Cc: stable@dpdk.org
Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
---
 drivers/net/failsafe/failsafe_ether.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/failsafe/failsafe_ether.c b/drivers/net/failsafe/failsafe_ether.c
index f0fd662c7b..4eaa337f55 100644
--- a/drivers/net/failsafe/failsafe_ether.c
+++ b/drivers/net/failsafe/failsafe_ether.c
@@ -301,8 +301,6 @@ fs_dev_remove(struct sub_device *sdev)
 		if (ret < 0) {
 			ERROR("Bus detach failed for sub_device %u",
 			      SUB_ID(sdev));
-		} else {
-			rte_eth_dev_release_port(ETH(sdev));
 		}
 		sdev->state = DEV_PARSED;
 		/* fallthrough */
-- 
2.34.1

