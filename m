Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A45DECD6D3
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 18:15:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D200340E1B;
	Wed, 11 Feb 2026 19:13:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id DCDF240DD3
 for <dev@dpdk.org>; Wed, 11 Feb 2026 19:13:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770833628; x=1802369628;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SKZplRgMTBantslwaToNJKp5lQvwjxUCcWv9fUF53pw=;
 b=ZFj1TKq6/+bO3uUJ7VAEeo9CTMIdzDrs1lk/YpzMLj9w9FDijLOyTzlV
 QOhMWkMbHnaEj+UJAsht3TguZZ9yKxVt4RIVox8MV365ua0UblitmoU4Q
 g/Qur3qrSYMM6xmpjrGCs+dQpwKCMf/3yJP7ZCyBvMCMpFHc16fMybnQz
 p3UYw6GDFnd2+fEsr925MmzeOghkgv1VySEHF+jTkw3Z/D/Vnkwoa+ZWl
 D1jUhGiPdWnUA9qJLDWK3BiKQZX57j9yGdrkclzt74CEEAg4S2r3e4f7U
 drt6CFwicI9bvOQGLwed1XJtJJrhwPu0k7JYrsoIA1xRK1dSmvRV4ruiR Q==;
X-CSE-ConnectionGUID: wppVYi8hTvmzPFO3OX4aOw==
X-CSE-MsgGUID: 7/oKJikqT5ecpQQ58eUDCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75834682"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="75834682"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 10:13:47 -0800
X-CSE-ConnectionGUID: g/JSb44USgSk6nd1jUx6Hg==
X-CSE-MsgGUID: SLvors4AQaifXi7qhXUK6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="249986345"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 11 Feb 2026 10:13:47 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v5 15/35] net/intel: support configurable VLAN tag insertion
 on Tx
Date: Wed, 11 Feb 2026 18:12:44 +0000
Message-ID: <20260211181309.2838042-16-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211181309.2838042-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260211181309.2838042-1-bruce.richardson@intel.com>
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

Make the VLAN tag insertion logic configurable in the common code, as to
where inner/outer tags get placed.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx.h        | 17 +++++++++++++++++
 drivers/net/intel/common/tx_scalar.h |  9 +++++++--
 drivers/net/intel/i40e/i40e_rxtx.c   |  6 +++---
 drivers/net/intel/ice/ice_rxtx.c     |  5 +++--
 4 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index 23deabc5d1..5da6c7c15d 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -45,6 +45,23 @@
 #define CI_TX_CTX_DESC_TSYN             0x02
 #define CI_TX_CTX_DESC_IL2TAG2          0x04
 
+/**
+ * L2TAG1 Field Source Selection
+ * Specifies which mbuf VLAN field to use for the L2TAG1 field in data descriptors.
+ * Context descriptor VLAN handling (L2TAG2) is managed by driver-specific callbacks.
+ */
+enum ci_tx_l2tag1_field {
+	/** For VLAN (not QinQ), use L2Tag1 field in data desc */
+	CI_VLAN_IN_L2TAG1,
+
+	/** For VLAN (not QinQ), use L2Tag2 field in ctx desc.
+	 * NOTE: When set, drivers must set the VLAN tag in the context
+	 * descriptor callback function, rather than relying on the
+	 * common Tx code to insert it.
+	 */
+	CI_VLAN_IN_L2TAG2,
+};
+
 /* Common TX Descriptor Length Field Shifts */
 #define CI_TX_DESC_LEN_MACLEN_S         0  /* 7 BITS */
 #define CI_TX_DESC_LEN_IPLEN_S          7  /* 7 BITS */
diff --git a/drivers/net/intel/common/tx_scalar.h b/drivers/net/intel/common/tx_scalar.h
index cd0abe4179..db002aad21 100644
--- a/drivers/net/intel/common/tx_scalar.h
+++ b/drivers/net/intel/common/tx_scalar.h
@@ -170,6 +170,7 @@ static inline uint16_t
 ci_xmit_pkts(struct ci_tx_queue *txq,
 	     struct rte_mbuf **tx_pkts,
 	     uint16_t nb_pkts,
+	     enum ci_tx_l2tag1_field l2tag1_field,
 	     ci_get_ctx_desc_fn get_ctx_desc,
 	     const struct ci_ipsec_ops *ipsec_ops,
 	     const struct ci_timestamp_queue_fns *ts_fns)
@@ -271,8 +272,12 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
 			}
 		}
 
-		/* Descriptor based VLAN insertion */
-		if (ol_flags & (RTE_MBUF_F_TX_VLAN | RTE_MBUF_F_TX_QINQ)) {
+		/* Descriptor based VLAN/QinQ insertion */
+		/* for single vlan offload, only insert in data desc with VLAN_IN_L2TAG1 is set
+		 * for qinq offload, we always put inner tag in L2Tag1
+		 */
+		if (((ol_flags & RTE_MBUF_F_TX_VLAN) && l2tag1_field == CI_VLAN_IN_L2TAG1) ||
+				(ol_flags & RTE_MBUF_F_TX_QINQ)) {
 			td_cmd |= CI_TX_DESC_CMD_IL2TAG1;
 			td_tag = tx_pkt->vlan_tci;
 		}
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index 4e362e737e..35c1b53c1e 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -1004,8 +1004,7 @@ get_context_desc(uint64_t ol_flags, const struct rte_mbuf *tx_pkt,
 	/* TX context descriptor based double VLAN insert */
 	if (ol_flags & RTE_MBUF_F_TX_QINQ) {
 		cd_l2tag2 = tx_pkt->vlan_tci_outer;
-		cd_type_cmd_tso_mss |=
-				((uint64_t)I40E_TX_CTX_DESC_IL2TAG2 << I40E_TXD_CTX_QW1_CMD_SHIFT);
+		cd_type_cmd_tso_mss |= (I40E_TX_CTX_DESC_IL2TAG2 << I40E_TXD_CTX_QW1_CMD_SHIFT);
 	}
 
 	*qw0 = rte_cpu_to_le_32(cd_tunneling_params) |
@@ -1019,7 +1018,8 @@ uint16_t
 i40e_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 {
 	/* i40e does not support IPsec or timestamp queues, so pass NULL for both */
-	return ci_xmit_pkts(tx_queue, tx_pkts, nb_pkts, get_context_desc, NULL, NULL);
+	return ci_xmit_pkts(tx_queue, tx_pkts, nb_pkts, CI_VLAN_IN_L2TAG1,
+			get_context_desc, NULL, NULL);
 }
 
 static __rte_always_inline int
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 9643dd3817..111cb5e37f 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -3105,9 +3105,10 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
 
 	if (txq->tsq != NULL && txq->tsq->ts_flag > 0)
-		return ci_xmit_pkts(txq, tx_pkts, nb_pkts, get_context_desc, NULL, &ts_fns);
+		return ci_xmit_pkts(txq, tx_pkts, nb_pkts, CI_VLAN_IN_L2TAG1,
+				get_context_desc, NULL, &ts_fns);
 
-	return ci_xmit_pkts(txq, tx_pkts, nb_pkts, get_context_desc, NULL, NULL);
+	return ci_xmit_pkts(txq, tx_pkts, nb_pkts, CI_VLAN_IN_L2TAG1, get_context_desc, NULL, NULL);
 }
 
 static __rte_always_inline int
-- 
2.51.0

