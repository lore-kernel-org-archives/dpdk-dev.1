Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DA4F9B5F2
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Apr 2026 09:16:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50AB940651;
	Wed, 22 Apr 2026 11:16:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 13ACD402E0
 for <dev@dpdk.org>; Wed, 22 Apr 2026 11:16:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776849385; x=1808385385;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6nOzu0S8fwRAnTQYqH8yf201SW5ykvN8KYpamgfxouk=;
 b=SdthNuSAnEmKtS6ELRKgLUI5VuHAzUWd1rDz1zDfT3sb5ozY8YRK6Gjy
 sLak1q3VDEeaazpBFSLTuszlMPCqjrOS2GZj1Y0l1mpyQhwdQo7WpMHqc
 BXen145xQeLZoCviOZ6Gc9O+AOqsWu+4fKrDPfKbWDY/8fCUncOatyYq6
 k/ZYdXDDOle5oxzn24DvfKpXRCLQ93C0hCm26itPgly+Uu5p4S/UTyWi2
 hAV5fwSc41j2lyqvSLpzaJQWu7NI7siG+cP1xc9RWWv+kaY/4xmIpebzu
 nv+KhYM8GqnkqBDmW8dzdEIZX16C16h3VDprR3URp/UfP3qMLiHSin4aI A==;
X-CSE-ConnectionGUID: Oqu29ZCvSa2q7G/1CafRXw==
X-CSE-MsgGUID: Zwx+PKiXQfqEIynOxwt4lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="89266808"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; d="scan'208";a="89266808"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 02:16:24 -0700
X-CSE-ConnectionGUID: DlZXAPLxTBek9t5JRQjNSQ==
X-CSE-MsgGUID: 0fFov55+Rg6e06KI3Vu3ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; d="scan'208";a="229631846"
Received: from silpixa00401921.ir.intel.com ([10.20.224.96])
 by fmviesa008.fm.intel.com with ESMTP; 22 Apr 2026 02:16:23 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v5 1/3] net/iavf: support LLDP Tx via mbuf ptype or dynfield
Date: Wed, 22 Apr 2026 09:16:07 +0000
Message-ID: <20260422091609.1797686-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422091609.1797686-1-ciara.loftus@intel.com>
References: <20260417105610.1161242-4-ciara.loftus@intel.com>
 <20260422091609.1797686-1-ciara.loftus@intel.com>
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

Previously, the only way to transmit LLDP packets via the iavf PMD
was to register the IAVF_TX_LLDP_DYNFIELD dynamic mbuf field and set
it to a non-zero value on each LLDP mbuf before Tx.

This patch adds an alternative. If the new devarg `enable_ptype_lldp` is
set to 1, and if the mbuf packet type is set to RTE_PTYPE_L2_ETHER_LLDP
then a Tx path with context descriptor support will be selected and any
packets with the LLDP ptype will be transmitted.

The dynamic mbuf field support is still present however it is intended
that it will be removed in a future release, at which point only the
packet type approach will be supported.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 doc/guides/nics/intel_vf.rst                  | 33 +++++++++++++++----
 doc/guides/rel_notes/release_26_07.rst        |  5 +++
 drivers/net/intel/common/tx.h                 |  1 +
 drivers/net/intel/iavf/iavf.h                 |  1 +
 drivers/net/intel/iavf/iavf_ethdev.c          | 27 +++++++++++++++
 drivers/net/intel/iavf/iavf_rxtx.c            | 15 +++++----
 drivers/net/intel/iavf/iavf_rxtx.h            | 17 +++++++---
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 21 ++++++------
 8 files changed, 92 insertions(+), 28 deletions(-)

diff --git a/doc/guides/nics/intel_vf.rst b/doc/guides/nics/intel_vf.rst
index 5fa2ddc9ea..3845b69408 100644
--- a/doc/guides/nics/intel_vf.rst
+++ b/doc/guides/nics/intel_vf.rst
@@ -675,19 +675,40 @@ Inline IPsec Support
 Diagnostic Utilities
 --------------------
 
-Register mbuf dynfield to test Tx LLDP
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Tx LLDP Testing
+~~~~~~~~~~~~~~~
 
-Register an mbuf dynfield ``IAVF_TX_LLDP_DYNFIELD`` on ``dev_start``
-to indicate the need to send LLDP packet.
-This dynfield needs to be set to 1 when preparing packet.
+There are two methods to trigger LLDP packet transmission from the VF.
 
-For ``dpdk-testpmd`` application, it needs to stop and restart Tx port to take effect.
+The first (and recommended) method is to set the ``packet_type`` of the mbuf to
+``RTE_PTYPE_L2_ETHER_LLDP``. This, in conjunction with enabling the
+``enable_ptype_lldp`` devarg will cause such packets to be transmitted::
+
+    -a 0000:xx:xx.x,enable_ptype_lldp=1
+
+An alternative method is to register an mbuf dynfield ``IAVF_TX_LLDP_DYNFIELD``
+before ``dev_start``. This dynfield needs to be set to 1 when preparing an LLDP
+packet intended for transmission.
+
+.. note::
+
+   The dynamic mbuf field method is deprecated and will be removed in a future
+   release. Users should migrate to the ``enable_ptype_lldp`` devarg and mbuf
+   LLDP ptype method described above.
+
+For ``dpdk-testpmd`` application, the dynamic mbuf field is registered when the
+following command is issued:
 
 Usage::
 
     testpmd> set tx lldp on
 
+One must then stop and restart the port for it to take effect.
+These requirements only apply for the dynamic mbuf field method; no special
+steps are needed for the ``enable_ptype_lldp`` devarg method.
+If both methods are enabled, the ptype based method will take precedence over the
+dynamic mbuf field method.
+
 
 Limitations or Knowing issues
 -----------------------------
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 060b26ff61..e0b27a554a 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -56,6 +56,11 @@ New Features
      =======================================================
 
 
+* **Updated Intel iavf driver.**
+
+  * Added support for transmitting LLDP packets based on mbuf packet type.
+
+
 Removed Items
 -------------
 
diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index c179247e24..8a625ea8aa 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -196,6 +196,7 @@ struct ci_tx_queue {
 			uint8_t vlan_flag;
 			uint8_t tc;
 			bool use_ctx;  /* with ctx info, each pkt needs two descriptors */
+			uint8_t lldp_mode; /* ptype or dynfield */
 		};
 		struct { /* ixgbe specific values */
 			const struct ixgbe_txq_ops *ops;
diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index f8008d0fda..ef503a1b64 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -323,6 +323,7 @@ struct iavf_devargs {
 	int auto_reconfig;
 	int no_poll_on_link_down;
 	uint64_t mbuf_check;
+	int enable_ptype_lldp;
 };
 
 struct iavf_security_ctx;
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 3126d9b644..288d701b7e 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -44,6 +44,7 @@
 #define IAVF_ENABLE_AUTO_RECONFIG_ARG "auto_reconfig"
 #define IAVF_NO_POLL_ON_LINK_DOWN_ARG "no-poll-on-link-down"
 #define IAVF_MBUF_CHECK_ARG       "mbuf_check"
+#define IAVF_ENABLE_PTYPE_LLDP_ARG "enable_ptype_lldp"
 uint64_t iavf_timestamp_dynflag;
 int iavf_timestamp_dynfield_offset = -1;
 int rte_pmd_iavf_tx_lldp_dynfield_offset = -1;
@@ -56,6 +57,7 @@ static const char * const iavf_valid_args[] = {
 	IAVF_ENABLE_AUTO_RECONFIG_ARG,
 	IAVF_NO_POLL_ON_LINK_DOWN_ARG,
 	IAVF_MBUF_CHECK_ARG,
+	IAVF_ENABLE_PTYPE_LLDP_ARG,
 	NULL
 };
 
@@ -1016,6 +1018,26 @@ iavf_dev_start(struct rte_eth_dev *dev)
 	/* Check Tx LLDP dynfield */
 	rte_pmd_iavf_tx_lldp_dynfield_offset =
 		rte_mbuf_dynfield_lookup(IAVF_TX_LLDP_DYNFIELD, NULL);
+	if (rte_pmd_iavf_tx_lldp_dynfield_offset > 0) {
+		PMD_DRV_LOG(WARNING,
+			"Using a dynamic mbuf field to identify LLDP packets is deprecated. "
+			"Set the 'enable_ptype_lldp' driver option and mbuf LLDP ptypes instead.");
+		if (adapter->devargs.enable_ptype_lldp)
+			PMD_DRV_LOG(WARNING,
+				"Both ptype and dynfield LLDP enabled; ptype takes precedence.");
+	}
+
+	for (uint16_t i = 0; i < dev->data->nb_tx_queues; i++) {
+		struct ci_tx_queue *txq = dev->data->tx_queues[i];
+		if (txq) {
+			if (adapter->devargs.enable_ptype_lldp)
+				txq->lldp_mode = IAVF_LLDP_PTYPE;
+			else if (rte_pmd_iavf_tx_lldp_dynfield_offset > 0)
+				txq->lldp_mode = IAVF_LLDP_DYNFIELD;
+			else
+				txq->lldp_mode = IAVF_LLDP_DISABLED;
+		}
+	}
 
 	if (iavf_init_queues(dev) != 0) {
 		PMD_DRV_LOG(ERR, "failed to do Queue init");
@@ -2445,6 +2467,11 @@ static int iavf_parse_devargs(struct rte_eth_dev *dev)
 	if (ret)
 		goto bail;
 
+	ret = rte_kvargs_process(kvlist, IAVF_ENABLE_PTYPE_LLDP_ARG,
+				 &parse_bool, &ad->devargs.enable_ptype_lldp);
+	if (ret)
+		goto bail;
+
 bail:
 	rte_kvargs_free(kvlist);
 	return ret;
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 3d9b49efd0..4828655ea7 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -2343,7 +2343,7 @@ iavf_recv_pkts_bulk_alloc(void *rx_queue,
 
 /* Check if the context descriptor is needed for TX offloading */
 static inline uint16_t
-iavf_calc_context_desc(const struct rte_mbuf *mb, uint8_t vlan_flag)
+iavf_calc_context_desc(const struct rte_mbuf *mb, uint8_t vlan_flag, uint8_t lldp_mode)
 {
 	uint64_t flags = mb->ol_flags;
 	if (flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG |
@@ -2354,7 +2354,7 @@ iavf_calc_context_desc(const struct rte_mbuf *mb, uint8_t vlan_flag)
 	    vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2)
 		return 1;
 
-	if (IAVF_CHECK_TX_LLDP(mb))
+	if (IAVF_CHECK_TX_LLDP(mb, lldp_mode))
 		return 1;
 
 	return 0;
@@ -2542,17 +2542,18 @@ iavf_get_context_desc(uint64_t ol_flags, const struct rte_mbuf *mbuf,
 		      const struct ci_tx_queue *txq,
 		      uint64_t *qw0, uint64_t *qw1)
 {
-	uint8_t iavf_vlan_flag;
+	uint8_t iavf_vlan_flag, lldp_mode;
 	uint16_t cd_l2tag2 = 0;
 	uint64_t cd_type_cmd = IAVF_TX_DESC_DTYPE_CONTEXT;
 	uint64_t cd_tunneling_params = 0;
 	struct iavf_ipsec_crypto_pkt_metadata *ipsec_md = NULL;
 
-	/* Use IAVF-specific vlan_flag from txq */
+	/* Use IAVF-specific flags from txq */
 	iavf_vlan_flag = txq->vlan_flag;
+	lldp_mode = txq->lldp_mode;
 
 	/* Check if context descriptor is needed using existing IAVF logic */
-	if (!iavf_calc_context_desc(mbuf, iavf_vlan_flag))
+	if (!iavf_calc_context_desc(mbuf, iavf_vlan_flag, lldp_mode))
 		return 0;
 
 	/* Get IPsec metadata if needed */
@@ -2584,7 +2585,7 @@ iavf_get_context_desc(uint64_t ol_flags, const struct rte_mbuf *mbuf,
 	}
 
 	/* LLDP switching field */
-	if (IAVF_CHECK_TX_LLDP(mbuf))
+	if (IAVF_CHECK_TX_LLDP(mbuf, lldp_mode))
 		cd_type_cmd |= IAVF_TX_CTX_DESC_SWTCH_UPLINK << IAVF_TXD_CTX_QW1_CMD_SHIFT;
 
 	/* Tunneling field */
@@ -3886,7 +3887,7 @@ iavf_set_tx_function(struct rte_eth_dev *dev)
 	if (iavf_tx_vec_dev_check(dev) != -1)
 		req_features.simd_width = iavf_get_max_simd_bitwidth();
 
-	if (rte_pmd_iavf_tx_lldp_dynfield_offset > 0)
+	if (adapter->devargs.enable_ptype_lldp || rte_pmd_iavf_tx_lldp_dynfield_offset > 0)
 		req_features.ctx_desc = true;
 
 	for (i = 0; i < dev->data->nb_tx_queues; i++) {
diff --git a/drivers/net/intel/iavf/iavf_rxtx.h b/drivers/net/intel/iavf/iavf_rxtx.h
index 80b06518b0..054cffd60c 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.h
+++ b/drivers/net/intel/iavf/iavf_rxtx.h
@@ -156,11 +156,18 @@
 		(RTE_MBUF_F_TX_OFFLOAD_MASK ^ IAVF_TX_OFFLOAD_MASK)
 
 #define IAVF_TX_LLDP_DYNFIELD "intel_pmd_dynfield_tx_lldp"
-#define IAVF_CHECK_TX_LLDP(m) \
-	((rte_pmd_iavf_tx_lldp_dynfield_offset > 0) && \
-	(*RTE_MBUF_DYNFIELD((m), \
-			rte_pmd_iavf_tx_lldp_dynfield_offset, \
-			uint8_t *)))
+
+/* LLDP Tx modes */
+#define IAVF_LLDP_DISABLED 0
+#define IAVF_LLDP_PTYPE    1
+#define IAVF_LLDP_DYNFIELD 2
+
+#define IAVF_CHECK_TX_LLDP(m, lldp_mode) \
+	((lldp_mode) && \
+	((((lldp_mode) == IAVF_LLDP_PTYPE) && \
+	((m)->packet_type & RTE_PTYPE_L2_MASK) == RTE_PTYPE_L2_ETHER_LLDP) || \
+	(((lldp_mode) == IAVF_LLDP_DYNFIELD) && \
+	*RTE_MBUF_DYNFIELD((m), rte_pmd_iavf_tx_lldp_dynfield_offset, uint8_t *))))
 
 extern uint64_t iavf_timestamp_dynflag;
 extern int iavf_timestamp_dynfield_offset;
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
index 4e8bf94fa0..c9422971b7 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
@@ -2059,7 +2059,7 @@ iavf_fill_ctx_desc_tunnelling_field(volatile uint64_t *qw0,
 
 static __rte_always_inline void
 ctx_vtx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
-		uint64_t flags, bool offload, uint8_t vlan_flag)
+		uint64_t flags, bool offload, uint8_t vlan_flag, uint8_t lldp_mode)
 {
 	uint64_t high_ctx_qw = IAVF_TX_DESC_DTYPE_CONTEXT;
 	uint64_t low_ctx_qw = 0;
@@ -2080,7 +2080,7 @@ ctx_vtx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
 		}
 #endif
 	}
-	if (IAVF_CHECK_TX_LLDP(pkt))
+	if (IAVF_CHECK_TX_LLDP(pkt, lldp_mode))
 		high_ctx_qw |= IAVF_TX_CTX_DESC_SWTCH_UPLINK
 			<< IAVF_TXD_CTX_QW1_CMD_SHIFT;
 	uint64_t high_data_qw = (CI_TX_DESC_DTYPE_DATA |
@@ -2098,13 +2098,13 @@ ctx_vtx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
 static __rte_always_inline void
 ctx_vtx(volatile struct ci_tx_desc *txdp,
 		struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags,
-		bool offload, uint8_t vlan_flag)
+		bool offload, uint8_t vlan_flag, uint8_t lldp_mode)
 {
 	uint64_t hi_data_qw_tmpl = (CI_TX_DESC_DTYPE_DATA | (flags << CI_TXD_QW1_CMD_S));
 
 	/* if unaligned on 32-bit boundary, do one to align */
 	if (((uintptr_t)txdp & 0x1F) != 0 && nb_pkts != 0) {
-		ctx_vtx1(txdp, *pkt, flags, offload, vlan_flag);
+		ctx_vtx1(txdp, *pkt, flags, offload, vlan_flag, lldp_mode);
 		nb_pkts--; txdp++; pkt++;
 	}
 
@@ -2137,7 +2137,7 @@ ctx_vtx(volatile struct ci_tx_desc *txdp,
 			}
 		}
 #endif
-		if (IAVF_CHECK_TX_LLDP(pkt[1]))
+		if (IAVF_CHECK_TX_LLDP(pkt[1], lldp_mode))
 			hi_ctx_qw1 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK
 				<< CI_TXD_QW1_CMD_S;
 
@@ -2157,7 +2157,7 @@ ctx_vtx(volatile struct ci_tx_desc *txdp,
 			}
 		}
 #endif
-		if (IAVF_CHECK_TX_LLDP(pkt[0]))
+		if (IAVF_CHECK_TX_LLDP(pkt[0], lldp_mode))
 			hi_ctx_qw0 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK << CI_TXD_QW1_CMD_S;
 
 		if (offload) {
@@ -2177,7 +2177,7 @@ ctx_vtx(volatile struct ci_tx_desc *txdp,
 	}
 
 	if (nb_pkts)
-		ctx_vtx1(txdp, *pkt, flags, offload, vlan_flag);
+		ctx_vtx1(txdp, *pkt, flags, offload, vlan_flag, lldp_mode);
 }
 
 static __rte_always_inline uint16_t
@@ -2258,6 +2258,7 @@ iavf_xmit_fixed_burst_vec_avx512_ctx(void *tx_queue, struct rte_mbuf **tx_pkts,
 	/* bit2 is reserved and must be set to 1 according to Spec */
 	uint64_t flags = CI_TX_DESC_CMD_EOP | CI_TX_DESC_CMD_ICRC;
 	uint64_t rs = CI_TX_DESC_CMD_RS | flags;
+	uint8_t lldp_mode = txq->lldp_mode;
 
 	if (txq->nb_tx_free < txq->tx_free_thresh)
 		ci_tx_free_bufs_vec(txq, iavf_tx_desc_done, true);
@@ -2280,10 +2281,10 @@ iavf_xmit_fixed_burst_vec_avx512_ctx(void *tx_queue, struct rte_mbuf **tx_pkts,
 		nb_mbuf = n >> 1;
 		tx_backlog_entry_avx512(txep, tx_pkts, nb_mbuf);
 
-		ctx_vtx(txdp, tx_pkts, nb_mbuf - 1, flags, offload, txq->vlan_flag);
+		ctx_vtx(txdp, tx_pkts, nb_mbuf - 1, flags, offload, txq->vlan_flag, lldp_mode);
 		tx_pkts += (nb_mbuf - 1);
 		txdp += (n - 2);
-		ctx_vtx1(txdp, *tx_pkts++, rs, offload, txq->vlan_flag);
+		ctx_vtx1(txdp, *tx_pkts++, rs, offload, txq->vlan_flag, lldp_mode);
 
 		nb_commit = (uint16_t)(nb_commit - n);
 
@@ -2297,7 +2298,7 @@ iavf_xmit_fixed_burst_vec_avx512_ctx(void *tx_queue, struct rte_mbuf **tx_pkts,
 	nb_mbuf = nb_commit >> 1;
 	tx_backlog_entry_avx512(txep, tx_pkts, nb_mbuf);
 
-	ctx_vtx(txdp, tx_pkts, nb_mbuf, flags, offload, txq->vlan_flag);
+	ctx_vtx(txdp, tx_pkts, nb_mbuf, flags, offload, txq->vlan_flag, lldp_mode);
 	tx_id = (uint16_t)(tx_id + nb_commit);
 
 	if (tx_id > txq->tx_next_rs) {
-- 
2.43.0

