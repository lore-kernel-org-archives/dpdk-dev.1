Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442F6CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 05:47:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6817C402DB;
	Mon, 27 Oct 2025 06:47:34 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id A7C384003C;
 Mon, 27 Oct 2025 06:47:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761544053; x=1793080053;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jspwtivLpsmo01ETuty8gYWTvBcbAYj9fmnFMTnH8cc=;
 b=a+IusxmgLy+1EsVLql3/nzSHXQ+goSo7bZwBE70SOVjnaXEizM7GAGwR
 RAJVz6Xh3oLuzav4ilVg6hPIxkXDBBvDnCuhy472IVBCKh+xfVA+ibkJR
 CrbJPcq7bOVJ5z3EEtzd1aUn45hNzPj7RsZtPmxu+oDp5iLeKBo03RfdQ
 ESQrOrJl3UOVIpwG/CSGENagp4C4O8NnW2Wr0jXCMmLwJOgNWmfC26ZpJ
 bO0hoLOsG1KkP63bRJ4JHr/Ckas7QULkIgW1fdk9uEQ4EwubgWMSuwIsf
 Oox8nmVXdMJdP97IyWR9lN3luKCGPssZK1S9VE170TwnKq8MlMRcOT9d7 Q==;
X-CSE-ConnectionGUID: +NlG1E3QRWCVY5zsf4bAgQ==
X-CSE-MsgGUID: M1d/+DKkSWCLbVvU0hVAmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66232928"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="66232928"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2025 22:47:32 -0700
X-CSE-ConnectionGUID: o2hU1S76Tamw2MsInoIjTg==
X-CSE-MsgGUID: nFbB8NKNS+SeW5tyIlP9HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="189265781"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by orviesa004.jf.intel.com with ESMTP; 26 Oct 2025 22:47:31 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: rajesh3.kumar@intel.com, aman.deep.singh@intel.com,
 manoj.kumar.subbarao@intel.com, stable@dpdk.org
Subject: [PATCH v1 1/3] net/ice: restrict testpmd to scalar path for TxPP
Date: Mon, 27 Oct 2025 14:27:59 -0400
Message-ID: <20251027182801.191295-2-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251027182801.191295-1-soumyadeep.hore@intel.com>
References: <20251027182801.191295-1-soumyadeep.hore@intel.com>
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

ICE PMD supports TxPP feature only in scalar path. Hence restricted
testpmd to scalar path when the feature is enabled.

Fixes: 0b6ff09a1f19 ("net/intel: support Tx packet pacing for E830")
Cc: stable@dpdk.org

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
 drivers/net/intel/ice/ice_rxtx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index fd0b3a7532..33d82cd46d 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -4103,8 +4103,11 @@ ice_set_tx_function(struct rte_eth_dev *dev)
 	struct ci_tx_queue *txq;
 	int i;
 	int tx_check_ret = -1;
+	uint64_t offloads;
 
-	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+	offloads = dev->data->dev_conf.txmode.offloads;
+	if ((offloads & RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP) == 0 &&
+		rte_eal_process_type() == RTE_PROC_PRIMARY) {
 		ad->tx_simd_width = RTE_VECT_SIMD_DISABLED;
 		tx_check_ret = ice_tx_vec_dev_check(dev);
 		ad->tx_simd_width = ice_get_max_simd_bitwidth();
-- 
2.47.1

