Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C08AF9B5E2
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Apr 2026 08:35:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5973240272;
	Wed, 22 Apr 2026 10:35:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id E2A4440144;
 Wed, 22 Apr 2026 10:35:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776846936; x=1808382936;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=A4WzwGrpuT77BoqMEYZLVHRUw3V+xNOq13hmjnv53Ww=;
 b=f8TRLdiDiD0JbLMwVIgho/Exur2Q5rdGvVeLLyTAMwPa3xRAFbSeldoC
 3hlS7wdQEg7Xxo7VObnNJ8nhIJ4Dhguutfjmke4crNkFtX2Tn1Bda9sHJ
 LRLcTxXxT88Cq5aG2JHnMF/1bPbbey7UKSw0bzJnkYVJh6sfTyuMWTQbf
 qde/mMQSd3s0/lcR2B2mZ8DiewqTDKUcFqEHvdO4NWrqQ2u4oKvLGJ9y9
 Zj3RpBEGWHtV2WVp8WGiOSkzodqyoDaImSpht/gfGtR1oMgzBh9FX+Fcr
 +bvSxO/oBeMiJZmFpBtc0SxXlCSWfQ0XaTOZOa9atqvYdA58UjUgvr8HC w==;
X-CSE-ConnectionGUID: HP6tzgnQScC6CektQXNynA==
X-CSE-MsgGUID: Q58daHxDTYqhERdrXKtPBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="77671634"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; d="scan'208";a="77671634"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 01:35:35 -0700
X-CSE-ConnectionGUID: RhnCelY/TuG9Ja/GrAczjw==
X-CSE-MsgGUID: Zujcj0VcR/6cc47wraLiZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; d="scan'208";a="229622522"
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by fmviesa008.fm.intel.com with ESMTP; 22 Apr 2026 01:35:32 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: stable@dpdk.org
Subject: [PATCH v3] net/idpf: fix multi-segment mbuf leak in split Tx
Date: Wed, 22 Apr 2026 13:56:42 +0530
Message-ID: <20260422082642.882407-1-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312110133.629246-1-shaiq.wani@intel.com>
References: <20260312110133.629246-1-shaiq.wani@intel.com>
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

RS completion only frees the EOP entry's mbuf, leaking preceding
segments of multi-segment packets. Add a first_id field to the Tx
entry struct, record the first sw_id at the EOP entry during submit,
and walk forward from first to EOP to free all segments on completion.

Fixes: 8c6098afa075 ("common/idpf: add Rx/Tx data path")
Cc: stable@dpdk.org

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
v3:
* fix commit title prefix: net/intel/idpf -> net/idpf

v2:
* drop the enqueue-side mbuf free raised in review, since a non-NULL
  software ring entry indicates an unreclaimed slot

 drivers/net/intel/common/tx.h             |  1 +
 drivers/net/intel/idpf/idpf_common_rxtx.c | 23 ++++++++++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index 283bd58d5d..53e61c0b62 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -121,6 +121,7 @@ struct ci_tx_queue;
 struct ci_tx_entry {
 	struct rte_mbuf *mbuf; /* mbuf associated with TX desc, if any. */
 	uint16_t next_id; /* Index of next descriptor in ring. */
+	uint16_t first_id; /* Split-queue: first sw_id of packet at EOP entry. */
 };
 
 /**
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index f73716e57c..c56ba86f1e 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -825,11 +825,23 @@ idpf_split_tx_free(struct ci_tx_queue *cq)
 		txq->last_desc_cleaned = q_head;
 		break;
 	case IDPF_TXD_COMPLT_RS:
-		/* q_head indicates sw_id when ctype is 2 */
+		/* Walk from first segment to EOP, freeing each segment. */
 		txe = &txq->sw_ring[q_head];
 		if (txe->mbuf != NULL) {
-			rte_pktmbuf_free_seg(txe->mbuf);
-			txe->mbuf = NULL;
+			uint16_t first = txe->first_id;
+			uint16_t idx = first;
+			uint16_t end = (q_head + 1 == txq->sw_nb_desc) ?
+					0 : q_head + 1;
+
+			do {
+				txe = &txq->sw_ring[idx];
+				if (txe->mbuf != NULL) {
+					rte_pktmbuf_free_seg(txe->mbuf);
+					txe->mbuf = NULL;
+				}
+				idx = (idx + 1 == txq->sw_nb_desc) ?
+					0 : idx + 1;
+			} while (idx != end);
 		}
 		break;
 	default:
@@ -979,6 +991,8 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 				tx_id = 0;
 		}
 
+		uint16_t first_sw_id = sw_id;
+
 		do {
 			txd = &txr[tx_id];
 			txn = &sw_ring[txe->next_id];
@@ -1002,6 +1016,9 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 		/* fill the last descriptor with End of Packet (EOP) bit */
 		txd->qw1.cmd_dtype |= IDPF_TXD_FLEX_FLOW_CMD_EOP;
 
+		/* Record first sw_id at EOP so completion can walk forward. */
+		sw_ring[txd->qw1.compl_tag].first_id = first_sw_id;
+
 		txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_used);
 		txq->rs_compl_count += nb_used;
 
-- 
2.43.0

