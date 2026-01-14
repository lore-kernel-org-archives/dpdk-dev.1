Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9541D37E56
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 15:46:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DEA6D40DF8;
	Wed, 14 Jan 2026 16:45:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 69FD440B90;
 Wed, 14 Jan 2026 16:45:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768405523; x=1799941523;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iRS57UNEh43FaoQ5aSQ4n0/lV8TxABEibrvAbCC1QHY=;
 b=HDFSI/2HIWWHPU7ZiSVrYRIE/Qag8J5c1UKXQne4CqnKc4jsGLZQ84NB
 H+gfTLDJ1RXVtCeIjEi5GYp+kM1FTiOyGnWu0BHRrsGaI+RerMzFGyQLs
 cOSd5lw7OhjZunK2gleR9H8SrwTfAunlEmgU0MHHHudOUikdgvbady5ns
 QqTtzYAO6S1nw/xB+HfA9fjmiVuPTKQ0tOj6zzAdCXn7nrvWPHBKN1wO/
 w7DkHGEo02KugtVHhz8vf0OUmAppztiAklYbdpvDypoeBRbNjV9ILdNFX
 VfaytfNvtjxJz2skP9xVd8ksZFe35n7KxSQfXuquGHUW/pZaR29BD5v5/ Q==;
X-CSE-ConnectionGUID: heBfaO13TuOlH8ch3+zzuQ==
X-CSE-MsgGUID: D5HU+N4iRNSRr01Hd8kpew==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69870862"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="69870862"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2026 07:45:23 -0800
X-CSE-ConnectionGUID: MD4tvI3NR3Gy20/Wv8VY2Q==
X-CSE-MsgGUID: PJsWw8EQSuSFkO6jq/cPGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="203925008"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 14 Jan 2026 07:45:20 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Ivan Ilchenko <ivan.ilchenko@oktetlabs.ru>,
 Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v4 13/31] net/e1000: fix build with shadow warnings enabled
Date: Wed, 14 Jan 2026 15:44:27 +0000
Message-ID: <20260114154450.2969716-14-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114154450.2969716-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20260114154450.2969716-1-bruce.richardson@intel.com>
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

