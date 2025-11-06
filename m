Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEE7CCFA03
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 14:11:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0825640DD8;
	Thu,  6 Nov 2025 15:10:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 2053940B98;
 Thu,  6 Nov 2025 15:10:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762438218; x=1793974218;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nAGvS1GKjbarzaUp45o4sVHDjMLhW5EJNVVQEtpkx00=;
 b=JvDlJF1b3csAG1ZmHb7dof7PtPtr3z5/GaaYVCyfae2dKj/9IHU1krTd
 rP5NVr//sdgNcAFNBZpWIik+zJK0tq3O6xBXGg5kQGGQDMmKlZ8CLPSMh
 Ub4DwUfimljhC3ROUhsnEUc9QXYE1yLWcXPvbj8PpjBhfIOvbcWlNZVf9
 KHwtJk2urXAHDp7Wr6lfnqaMgfoXG3JI/LuAA5AWjfFjUb5nm0ND5fMxq
 JRsbyWO3owQqBilNzqplWP9T2BjuDFZZKSbyTBA+JvLaNq8REelhfzsFC
 7v7XR1YWKviqqzZFIKfMygq5gXxJJbuJ3TxPS2riZ1qagk9CDcJbIh4p0 w==;
X-CSE-ConnectionGUID: hC58OXLmRWGSVzK4AslTNA==
X-CSE-MsgGUID: XXqIEbKdS5qr6jQnN/vqQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="67185332"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="67185332"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 06:10:17 -0800
X-CSE-ConnectionGUID: 1aNBrXrsTx2prR5YYGm+sA==
X-CSE-MsgGUID: 8v5w7pt+Rh6j6MEGPRetBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="187054766"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 06 Nov 2025 06:10:16 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [RFC PATCH 14/19] net/e1000: fix build with shadow warnings enabled
Date: Thu,  6 Nov 2025 14:09:43 +0000
Message-ID: <20251106140948.2894678-15-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251106140948.2894678-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
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

