Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC98BCD37AC
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 May 2026 09:18:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B0B540669;
	Mon, 11 May 2026 11:18:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 0EE47402BC
 for <dev@dpdk.org>; Mon, 11 May 2026 11:17:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778491078; x=1810027078;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SWWmka+SllgmElZ1fxEXJAIYYNYjs1YgMQrQI7NVC3I=;
 b=h/KrpqesJOr0wMM50trbGrtW0VLorC2C1WYga4O/16egkuJVugS1ibOT
 t0KAS1U+IvKK/+jip4OPYpprSWi/IFsGSZ7t+S91OCsk3Np4yAIPvaKIc
 Aavlo667q7Ne4d+xDcXXe3AP+OWBysiA91fK0F+5TQYnsxniL6DtnDtfU
 r5HVv38rFWJHdTzuQXHJNX4F5dhnYKfVTtAThuBeFD9oTfsbnjkVz3OUt
 SVlquH9n77L+3rxyjT9E3rfzIycTIQ3fpe3c/6WBr4snYqg7IakZAZq/R
 ZgEmhHAsVWhXKrIPdBoPR7vgb5Z4hz03Fyi+BpJBihWrFTyJIZDUcIukr A==;
X-CSE-ConnectionGUID: jRVFcX6SQq2uhovIoHSH0Q==
X-CSE-MsgGUID: DK9jfWguTKaY1dlaqAqfIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="96937086"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; d="scan'208";a="96937086"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2026 02:17:58 -0700
X-CSE-ConnectionGUID: 2s5lv6++T7i1IYsZylEKmw==
X-CSE-MsgGUID: H28wK+ZIS4eS5f8dhYeldA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; d="scan'208";a="234739700"
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by fmviesa008.fm.intel.com with ESMTP; 11 May 2026 02:17:57 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@intel.com
Subject: [PATCH 6/6] net/idpf: fix split queue AVX2 Tx burst and completion
Date: Mon, 11 May 2026 14:39:35 +0530
Message-ID: <20260511090935.2288837-7-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511090935.2288837-1-shaiq.wani@intel.com>
References: <20260511090935.2288837-1-shaiq.wani@intel.com>
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

Clamp burst size to tx_rs_thresh to prevent crossing completion
boundaries.  Update tx_next_rs on ring wrap and after each burst
so that completion tracking in idpf_splitq_scan_cq_ring works
correctly.  Fix sw_ring pointer to use base-plus-offset.

Fixes: 57560a92167a ("net/idpf: add AVX2 Tx path for split queue config")
Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 24 ++++++++++++++-----
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
index 7c547b5f09..b6c4fdf20e 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
@@ -884,17 +884,21 @@ idpf_splitq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
 	struct idpf_flex_tx_sched_desc *txdp;
 	struct ci_tx_entry_vec *txep;
-	uint16_t n, nb_commit;
+	uint16_t n, nb_commit, tx_id;
 	uint64_t cmd_dtype = IDPF_TXD_FLEX_FLOW_CMD_EOP;
-	uint16_t tx_id = txq->tx_tail;
 
-	nb_commit = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts);
-	nb_pkts = nb_commit;
+	/* cross rs_thresh boundary is not allowed */
+	nb_pkts = RTE_MIN(nb_pkts, txq->tx_rs_thresh);
+
+	nb_pkts = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts);
+	nb_commit = nb_pkts;
 	if (unlikely(nb_pkts == 0))
 		return 0;
 
-	txdp = (struct idpf_flex_tx_sched_desc *)&txq->desc_ring[tx_id];
-	txep = &txq->sw_ring_vec[tx_id];
+	tx_id = txq->tx_tail;
+	txdp = &txq->desc_ring[tx_id];
+	txep = (void *)txq->sw_ring;
+	txep += tx_id;
 
 	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_pkts);
 
@@ -909,10 +913,14 @@ idpf_splitq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 		idpf_splitq_vtx1_avx2(txdp, *tx_pkts++, cmd_dtype);
 
 		nb_commit = (uint16_t)(nb_commit - n);
+
 		tx_id = 0;
+		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
 
+		/* avoid reach the end of ring */
 		txdp = &txq->desc_ring[tx_id];
 		txep = (void *)txq->sw_ring;
+		txep += tx_id;
 	}
 
 	ci_tx_backlog_entry_vec(txep, tx_pkts, nb_commit);
@@ -920,6 +928,10 @@ idpf_splitq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 	idpf_splitq_vtx_avx2(txdp, tx_pkts, nb_commit, cmd_dtype);
 
 	tx_id = (uint16_t)(tx_id + nb_commit);
+	if (tx_id > txq->tx_next_rs)
+		txq->tx_next_rs =
+			(uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
+
 	txq->tx_tail = tx_id;
 
 	IDPF_PCI_REG_WRITE(txq->qtx_tail, txq->tx_tail);
-- 
2.34.1

