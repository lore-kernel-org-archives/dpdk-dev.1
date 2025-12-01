Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16D3D116F1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 11:46:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E282409FA;
	Mon,  1 Dec 2025 12:45:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 39E6940666;
 Mon,  1 Dec 2025 12:45:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764589518; x=1796125518;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iRS57UNEh43FaoQ5aSQ4n0/lV8TxABEibrvAbCC1QHY=;
 b=hdK3E9y3JNyVi0UEpo9po3LPVpOmurSmDM8oieRrwxyERgEldjogd2js
 hhByuWaPOVyDqmT05rM7tBjymcSATyOLbKL5amwKXhWYXlbZq/rdWmZGG
 h1DIM0fsKVgMmMgBcZip6X+qqHYSpa3h+Actb6bFHM2GAJ095TMjeKLp8
 IQMXQ2nUUOrv8CQOzz79Qj8jsmCQfRGYftW08IM0n7DuOQ7yNqNBNvXJS
 b2YzvlWfOdvP8ehL85GoQ+fY677krRsqMpvdsE3iu14+RVscDB7k7biDH
 188VEQYJCOsq48eUHdoE2fI3OXD8ziKCamNcIgj1HI6MaurDdKeuHBV0X w==;
X-CSE-ConnectionGUID: OpOYdwd1TLKR76t2yngE3Q==
X-CSE-MsgGUID: CC3gpyA4SP6VTI8TjNBEOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="77991733"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; d="scan'208";a="77991733"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2025 03:45:17 -0800
X-CSE-ConnectionGUID: GOVTdYvqTHqjF+igasJJ2g==
X-CSE-MsgGUID: ZHZ2MJyATj+PVG/wUZvMng==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 01 Dec 2025 03:45:16 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 13/31] net/e1000: fix build with shadow warnings enabled
Date: Mon,  1 Dec 2025 11:44:30 +0000
Message-ID: <20251201114448.1441377-14-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251201114448.1441377-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251201114448.1441377-1-bruce.richardson@intel.com>
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

Variable "ret" was shadowed within the close function, so rename outer
variable to "retval" to clear the warnings.

Fixes: 62024eb82756 ("ethdev: change stop operation callback to return int")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/e1000/igc_ethdev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/e1000/igc_ethdev.c b/drivers/net/intel/e1000/igc_ethdev.c
index b9c91d2446..47a91fe38e 100644
--- a/drivers/net/intel/e1000/igc_ethdev.c
+++ b/drivers/net/intel/e1000/igc_ethdev.c
@@ -1313,14 +1313,14 @@ eth_igc_close(struct rte_eth_dev *dev)
 	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct igc_adapter *adapter = IGC_DEV_PRIVATE(dev);
 	int retry = 0;
-	int ret = 0;
+	int retval = 0;
 
 	PMD_INIT_FUNC_TRACE();
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
 		return 0;
 
 	if (!adapter->stopped)
-		ret = eth_igc_stop(dev);
+		retval = eth_igc_stop(dev);
 
 	igc_flow_flush(dev, NULL);
 	igc_clear_all_filter(dev);
@@ -1343,7 +1343,7 @@ eth_igc_close(struct rte_eth_dev *dev)
 	/* Reset any pending lock */
 	igc_reset_swfw_lock(hw);
 
-	return ret;
+	return retval;
 }
 
 static void
-- 
2.51.0

