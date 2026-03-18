Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C5DFCD0C1
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Mar 2026 06:41:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A31C402F0;
	Wed, 18 Mar 2026 07:41:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 4AA274026F;
 Wed, 18 Mar 2026 07:41:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773816103; x=1805352103;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DfqTefaBDEBsJN99giLGCy/Vb8cChJBg3fXiANGA7Sc=;
 b=Via0my2Bc2nVUeeLVr/F7gSVEqm0eud470sX3U+usios3MEtiwQ9orew
 xbOXGVr2e+32UxL9PYDwbYzvmJuNHmu0FCDphaSAl4MUNcAIwdKTfXb72
 wvq0mHWwP29C/aipSM6Bz2pf78VOBax/0Xgahz/2cApM7v33B1XtEZcUE
 3gxsOy2ZMLn1HU8tOzIj8TtmqMM7AqQ/qAqSUPBg2Vi/k8jmN5C/Mscu5
 hsE9qzbeAAChmFvwhGs44fKH1z47+R4lzwW7pW1+vVB09e/XV+CWMDB1c
 bgdu+huJNWXY1SYm//E8z4JCJSzE0EkmRz4r511woqYMdS432DC2kxPS9 w==;
X-CSE-ConnectionGUID: XeLm65KeRd6YmqLMTCl4eQ==
X-CSE-MsgGUID: aq5/l5JNQ2SYJkToTgFj7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="97471217"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="97471217"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 23:41:41 -0700
X-CSE-ConnectionGUID: m8vFSKd4TvWXyMtTRajGQA==
X-CSE-MsgGUID: tCgRclhYTQ2QGjXbpM0ScA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="227199134"
Received: from unknown (HELO srv13..) ([10.190.213.143])
 by fmviesa005.fm.intel.com with ESMTP; 17 Mar 2026 23:41:38 -0700
From: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
To: dev@dpdk.org, bruce.richardson@intel.com, aman.deep.singh@intel.com,
 fengchengwen@huawei.com
Cc: shaiq.wani@intel.com,
 Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>, stable@dpdk.org
Subject: [PATCH v4] app/testpmd: fix DCB forwarding TC mismatch handling
Date: Wed, 18 Mar 2026 06:17:19 +0000
Message-ID: <20260318061720.1885589-1-chaitanyababux.talluri@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311083751.1107404-1-chaitanyababux.talluri@intel.com>
References: <20260311083751.1107404-1-chaitanyababux.talluri@intel.com>
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

Fix DCB forwarding issues when RX and TX ports are configured with
different numbers of traffic classes (TCs).

When ports have asymmetric TC configurations (e.g. 4 TCs on RX and 8 TCs
on TX), the forwarding logic iterates based only on the RX port TC count.
This can lead to accessing invalid TX TC entries and incorrect queue
mapping, potentially causing multiple threads to operate on the same
queues.

Additionally, the existing VMDq pool guard in dcb_fwd_config_setup()
only checks RX queue counts and does not consider the case where the TX
port has no queues for a given pool/TC combination.

Fix this by:
1. Introducing an effective TC count using RTE_MIN() of RX and TX TC
   values, ensuring forwarding only operates on valid TCs supported by
   both ports.
2. Updating the loop condition to use the effective TC count instead of
   only the RX TC count.
3. Extending validation in dcb_fwd_check_cores_per_tc() to ensure both RX
   and TX queue counts are divisible by dcb_fwd_tc_cores, preventing
   invalid configurations.

This ensures correct queue mapping and avoids issues when switching
between different DCB configurations across ports.

Fixes: 945e9be0a803 ("app/testpmd: support multi-cores process one TC")
Cc: stable@dpdk.org

Signed-off-by: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---

v4:
* Removed runtime update of dcb_fwd_tc_mask as per review comments.
* Used effective TC count (RTE_MIN of RX/TX) to handle asymmetric configs.
* Moved queue validation to dcb_fwd_check_cores_per_tc().

v3: Removed old email address.

v2:
* Used res->num_tcs to derive dcb_fwd_tc_mask.
* Removed redundant rte_eth_dev_get_dcb_info().
---
 app/test-pmd/config.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index f9f3c542a6..4caa1b1237 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -5286,7 +5286,8 @@ dcb_fwd_check_cores_per_tc(void)
 		(void)rte_eth_dev_get_dcb_info(fwd_ports_ids[port], &dcb_info);
 		for (tc = 0; tc < dcb_info.nb_tcs; tc++) {
 			for (vmdq_idx = 0; vmdq_idx < RTE_ETH_MAX_VMDQ_POOL; vmdq_idx++) {
-				if (dcb_info.tc_queue.tc_rxq[vmdq_idx][tc].nb_queue == 0)
+				if (dcb_info.tc_queue.tc_rxq[vmdq_idx][tc].nb_queue == 0 ||
+				    dcb_info.tc_queue.tc_txq[vmdq_idx][tc].nb_queue == 0)
 					break;
 				/* make sure nb_rx_queue can be divisible. */
 				if (dcb_info.tc_queue.tc_rxq[vmdq_idx][tc].nb_queue %
@@ -5377,6 +5378,7 @@ dcb_fwd_config_setup(void)
 	uint16_t nb_rx_queue, nb_tx_queue;
 	uint16_t i, j, k, sm_id = 0;
 	uint16_t sub_core_idx = 0;
+	uint8_t effective_nb_tcs;
 	uint16_t total_tc_num;
 	struct rte_port *port;
 	uint8_t tc = 0;
@@ -5442,6 +5444,7 @@ dcb_fwd_config_setup(void)
 	dcb_fwd_tc_update_dcb_info(&rxp_dcb_info);
 	(void)rte_eth_dev_get_dcb_info(fwd_ports_ids[txp], &txp_dcb_info);
 	dcb_fwd_tc_update_dcb_info(&txp_dcb_info);
+	effective_nb_tcs = RTE_MIN(rxp_dcb_info.nb_tcs, txp_dcb_info.nb_tcs);
 
 	for (lc_id = 0; lc_id < cur_fwd_config.nb_fwd_lcores; lc_id++) {
 		fwd_lcores[lc_id]->stream_nb = 0;
@@ -5450,7 +5453,8 @@ dcb_fwd_config_setup(void)
 			/* if the nb_queue is zero, means this tc is
 			 * not enabled on the POOL
 			 */
-			if (rxp_dcb_info.tc_queue.tc_rxq[i][tc].nb_queue == 0)
+			if (rxp_dcb_info.tc_queue.tc_rxq[i][tc].nb_queue == 0 ||
+			    txp_dcb_info.tc_queue.tc_txq[i][tc].nb_queue == 0)
 				break;
 			k = fwd_lcores[lc_id]->stream_nb +
 				fwd_lcores[lc_id]->stream_idx;
@@ -5480,7 +5484,7 @@ dcb_fwd_config_setup(void)
 
 		sub_core_idx = 0;
 		tc++;
-		if (tc < rxp_dcb_info.nb_tcs)
+		if (tc < effective_nb_tcs)
 			continue;
 		/* Restart from TC 0 on next RX port */
 		tc = 0;
@@ -5497,6 +5501,8 @@ dcb_fwd_config_setup(void)
 		dcb_fwd_tc_update_dcb_info(&rxp_dcb_info);
 		rte_eth_dev_get_dcb_info(fwd_ports_ids[txp], &txp_dcb_info);
 		dcb_fwd_tc_update_dcb_info(&txp_dcb_info);
+
+		effective_nb_tcs = RTE_MIN(rxp_dcb_info.nb_tcs, txp_dcb_info.nb_tcs);
 	}
 }
 
-- 
2.43.0

