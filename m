Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC83AC61DD3
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 10:26:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 792314069F;
	Mon, 31 Aug 2026 12:26:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 177D440A6E;
 Mon, 31 Aug 2026 12:26:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788171997; x=1819707997;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MInox9DR8cSXN1pBrJ4y9t9G/kdgYlG99h/2Cr66dF8=;
 b=hyNuu4elE+63TS86w5X9pIFTFU5QWvi4hRQ626SU2Qwn/7J9u3JQa2Ex
 lzSdGgXnBfVS4b0SdUlyIkBKEBHe6ZBwOwRhx9tW6kWo9ygRXxlPi2OfI
 gnhLUl1BQYJuF3tT1/27Rwln14dfg4LG3Y1V+IcavAlSq3uXF4IFrZqTt
 lasxwTSKibLJDxmwNvZby+RSQQ+bnUZSAFE78KerrVPrN5FYf54VQ/J+U
 T6LUROGM5NXwQmCYhoSkFiKqOJKAvvRYDT6D2wOYKnMAk0lj6OVMRQS91
 cxhtIjrHN8RoCmxlDJZ/7CSxlYMZrJ9650FfzqMIYYE/5I9cODPROo3hn Q==;
X-CSE-ConnectionGUID: PdnqO2Z0ScmhabaRGOXbNA==
X-CSE-MsgGUID: OhiZJjhWQuOErbrhbsLH/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88452423"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="88452423"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 03:26:37 -0700
X-CSE-ConnectionGUID: 753to0plStO1L12xKn5EKA==
X-CSE-MsgGUID: TCDVdDAuRgG5c7KnGC/lRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="267424166"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 31 Aug 2026 03:26:35 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>
Subject: [PATCH 5/7] net/intel: fix VLAN and QinQ tag position logic
Date: Mon, 31 Aug 2026 11:26:18 +0100
Message-ID: <20260831102621.495759-6-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831102621.495759-1-bruce.richardson@intel.com>
References: <20260831102621.495759-1-bruce.richardson@intel.com>
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

The position of a single vlan tag on a Tx packet (data desc or ctx desc)
is independent across drivers from that of where the outer QinQ tag gets
put. Therefore, these should be passed as separate values to the common
scalar Tx function. For i40e, ice and idpf, the single tag can be put in
the data descriptor, and for QinQ, the context descriptor contains the
outer tag. For iavf, the tag positions depend on the capabilities
reported by the PF to the VF, but the position for the single vlan tag
and the outer QinQ tags are the same.

Fixes: 6ea6d67bebfe ("net/intel: support configurable VLAN insertion on Tx")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx_scalar.h      | 16 +++++++++++-----
 drivers/net/intel/i40e/i40e_rxtx.c        |  6 ++++--
 drivers/net/intel/iavf/iavf_rxtx.c        |  7 ++++---
 drivers/net/intel/ice/ice_rxtx.c          |  5 +++--
 drivers/net/intel/idpf/idpf_common_rxtx.c |  3 ++-
 5 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/net/intel/common/tx_scalar.h b/drivers/net/intel/common/tx_scalar.h
index 4df279e729..7368d3abc9 100644
--- a/drivers/net/intel/common/tx_scalar.h
+++ b/drivers/net/intel/common/tx_scalar.h
@@ -372,7 +372,8 @@ static inline uint16_t
 ci_xmit_pkts(struct ci_tx_queue *txq,
 	     struct rte_mbuf **tx_pkts,
 	     uint16_t nb_pkts,
-	     enum ci_l2tag_pos l2tag_pos,
+	     enum ci_l2tag_pos single_vlan_pos,
+	     enum ci_l2tag_pos qinq_outer_pos,
 	     ci_get_ctx_desc_fn get_ctx_desc,
 	     const struct ci_ipsec_ops *ipsec_ops,
 	     const struct ci_timestamp_queue_fns *ts_fns)
@@ -480,13 +481,18 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 		}

 		/* Descriptor based VLAN/QinQ insertion */
-		/* for single vlan offload, only insert in data desc when CI_TAG_IN_DATA_DESC is set
-		 * for qinq offload, we always put inner tag in L2Tag1
+		/* for single vlan offload, only insert in data desc when single_vlan_pos is
+		 * CI_TAG_IN_DATA_DESC; for qinq offload, L2Tag1 always carries a tag, either
+		 * the outer (qinq_outer_pos == CI_TAG_IN_DATA_DESC) or otherwise the inner
 		 */
-		if (((ol_flags & RTE_MBUF_F_TX_VLAN) && l2tag_pos == CI_TAG_IN_DATA_DESC) ||
+		if (((ol_flags & RTE_MBUF_F_TX_VLAN) && single_vlan_pos == CI_TAG_IN_DATA_DESC) ||
 				(ol_flags & RTE_MBUF_F_TX_QINQ)) {
 			td_cmd |= CI_TX_DESC_CMD_IL2TAG1;
-			td_tag = tx_pkt->vlan_tci;
+			if ((ol_flags & RTE_MBUF_F_TX_QINQ) &&
+					qinq_outer_pos == CI_TAG_IN_DATA_DESC)
+				td_tag = tx_pkt->vlan_tci_outer;
+			else
+				td_tag = tx_pkt->vlan_tci;
 		}

 		/* Enable checksum offloading */
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index ef7041cebd..e2fffdb70a 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -1006,8 +1006,10 @@ get_context_desc(uint64_t ol_flags, const struct rte_mbuf *tx_pkt,
 uint16_t
 i40e_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 {
-	/* i40e does not support IPsec or timestamp queues, so pass NULL for both */
-	return ci_xmit_pkts(tx_queue, tx_pkts, nb_pkts, CI_TAG_IN_DATA_DESC,
+	/* i40e does not support IPsec or timestamp queues, so pass NULL for both.
+	 * QinQ always places the outer tag in the ctx desc, inner in the data desc.
+	 */
+	return ci_xmit_pkts(tx_queue, tx_pkts, nb_pkts, CI_TAG_IN_DATA_DESC, CI_TAG_IN_CTX_DESC,
 			get_context_desc, NULL, NULL);
 }

diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 1354e2d6d6..80c9912ccc 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -2596,6 +2596,9 @@ uint16_t
 iavf_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 {
 	struct ci_tx_queue *txq = tx_queue;
+	/* vlan_flag gives both the single-VLAN and the QinQ outer tag position */
+	enum ci_l2tag_pos vlan_pos = (txq->vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1) ?
+			CI_TAG_IN_DATA_DESC : CI_TAG_IN_CTX_DESC;

 	const struct ci_ipsec_ops ipsec_ops = {
 		.get_ipsec_desc = iavf_get_ipsec_desc,
@@ -2603,9 +2606,7 @@ iavf_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	};

 	/* IAVF does not support timestamp queues, so pass NULL for ts_fns */
-	return ci_xmit_pkts(txq, tx_pkts, nb_pkts,
-			    (txq->vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1) ?
-				CI_TAG_IN_DATA_DESC : CI_TAG_IN_CTX_DESC,
+	return ci_xmit_pkts(txq, tx_pkts, nb_pkts, vlan_pos, vlan_pos,
 			    iavf_get_context_desc, &ipsec_ops, NULL);
 }

diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 22d1d5d602..3569ffcf82 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -3125,10 +3125,11 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;

 	if (txq->tsq != NULL && txq->tsq->ts_flag > 0)
-		return ci_xmit_pkts(txq, tx_pkts, nb_pkts, CI_TAG_IN_DATA_DESC,
+		return ci_xmit_pkts(txq, tx_pkts, nb_pkts, CI_TAG_IN_DATA_DESC, CI_TAG_IN_CTX_DESC,
 				get_context_desc, NULL, &ts_fns);

-	return ci_xmit_pkts(txq, tx_pkts, nb_pkts, CI_TAG_IN_DATA_DESC,
+	/* QinQ always places the outer tag in the ctx desc, inner in the data desc. */
+	return ci_xmit_pkts(txq, tx_pkts, nb_pkts, CI_TAG_IN_DATA_DESC, CI_TAG_IN_CTX_DESC,
 			get_context_desc, NULL, NULL);
 }

diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index 128ebb6a88..649b5d1f99 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -1415,7 +1415,8 @@ uint16_t
 idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 			  uint16_t nb_pkts)
 {
-	return ci_xmit_pkts(tx_queue, tx_pkts, nb_pkts, CI_TAG_IN_DATA_DESC,
+	/* QinQ always places the outer tag in the ctx desc, inner in the data desc. */
+	return ci_xmit_pkts(tx_queue, tx_pkts, nb_pkts, CI_TAG_IN_DATA_DESC, CI_TAG_IN_CTX_DESC,
 			idpf_get_context_desc, NULL, NULL);
 }

--
2.53.0

