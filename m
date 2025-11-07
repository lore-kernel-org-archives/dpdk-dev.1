Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F73CCFA05
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 15:52:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55C3E40DDE;
	Fri,  7 Nov 2025 16:51:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 4B5D840DD8;
 Fri,  7 Nov 2025 16:51:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762530677; x=1794066677;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nAGvS1GKjbarzaUp45o4sVHDjMLhW5EJNVVQEtpkx00=;
 b=I+q1I0wnhAQ8YvoDwXooeVrhRUp2wkmYGHvNnUTTHjkGbl/l3UGfbQNt
 p/UmJ9PddnBfdIKV0gX2GNIn/PnrrtqqnktPSXRKzy7eZKX91M6mrzKG3
 vktM00SMCAk4rIt52CygEI30ttIpYhRbbH0ZFXjp59yYTHliF3r6NfRU8
 VWd8KC5RwwY6cUgxuhvm7FwD2BTVkyZ1fA2xUeA/uF31bmRajrx6XyYGa
 pCCng8JJkUmPPAnodmRT5gnRaBtzpuIFGQ6eBFles/megE/dG8mbqPJ8Y
 Yo35d5+iE3/50MyElUhaWg8h996AFNj5asx8kw2llMz7Mcq/wAhzM1Fwp w==;
X-CSE-ConnectionGUID: aspApGd6TxWvHov+m7+hdQ==
X-CSE-MsgGUID: kXRjDV5pQm2VmMb0A/TBFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="90151848"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="90151848"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2025 07:51:17 -0800
X-CSE-ConnectionGUID: P7FAdFUuSyql+4ZXYdXsiA==
X-CSE-MsgGUID: Gve9I5W6RoupWEFh0X2YMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="187321692"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 07 Nov 2025 07:51:16 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Ivan Ilchenko <ivan.ilchenko@oktetlabs.ru>,
 Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [RFC PATCH v2 14/33] net/e1000: fix build with shadow warnings enabled
Date: Fri,  7 Nov 2025 15:50:10 +0000
Message-ID: <20251107155034.436809-15-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251107155034.436809-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251107155034.436809-1-bruce.richardson@intel.com>
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
2.48.1

