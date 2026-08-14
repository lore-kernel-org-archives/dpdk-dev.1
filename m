Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E29EC5CFC1
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 12:38:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C5894013F;
	Fri, 14 Aug 2026 14:38:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 17533400D5
 for <dev@dpdk.org>; Fri, 14 Aug 2026 14:38:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786711084; x=1818247084;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=g+rFeP9Fr+qGGqL98kT4crfP8m5Ku7JbHpttREO13Kc=;
 b=WzfHikvFUogcw68e3Krmo8YyRjwErlhJAmXcOqza3t1G2ATBU91xLd4n
 pvlHsqPusazUQ778GpqlWcGQx/pxXj0/YPd7pEQlG4xg2EshfKw3EamBo
 GjJCxWFPOVtuAHoRQRvGeYz2hDJKZGJuwGLV8gSQtCStEtpn2lySEMtw6
 l28pfasWAH1eJqyMosXWVbX56nc2HmqmO5S3fw1jQ1VCfYa2rc3m96XNR
 hx5IouhtL2zyP9qLA+ihSIFHgw7rP4+WzAoodC0EEe5t9qqvQBWuoAFle
 JRIheovgzEyqg6YJNHaKOObekQUhZaWLlJqzDUA7urdXSyG9klrGyX3mz w==;
X-CSE-ConnectionGUID: CrIOt2SsRni0TQlxokrLhQ==
X-CSE-MsgGUID: SVQP/7FJQMm1tACz8cdc+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="104670484"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="104670484"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 05:38:03 -0700
X-CSE-ConnectionGUID: 9Wo0/ky3TYCFIhGpQt3PPg==
X-CSE-MsgGUID: Y9OcDTUFSaeMZo+n15kPQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="262459001"
Received: from silpixa00401921.ir.intel.com ([10.20.224.96])
 by orviesa006.jf.intel.com with ESMTP; 14 Aug 2026 05:38:02 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 1/2] net/iavf: remove Tx LLDP dynfield method
Date: Fri, 14 Aug 2026 12:37:52 +0000
Message-ID: <20260814123753.2041645-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810140354.1869708-1-ciara.loftus@intel.com>
References: <20260810140354.1869708-1-ciara.loftus@intel.com>
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

Prior to this commit two methods existed for triggering LLDP packet
transmission in the driver: the dynamic mbuf field method and the mbuf
packet-type method. This commit removes the dynamic mbuf field method. The
dynfield method required applications to tag every LLDP packet manually,
whereas the packet-type method gives the driver the opportunity to tag LLDP
packets automatically on the Rx path, leaving no work to be done by the
application to explicitly flag a packet as LLDP before transmission.

The per-queue LLDP state is reduced from the tri-state 'lldp_mode' to a
single 'lldp_enabled' boolean. The testpmd command 'set tx lldp on'
whose purpose was to enable the dynfield lldp method is removed. The
ptype lldp method is enabled via the enable_ptype_lldp devarg (as has
always been the case since support was introduced):

	-a 0000:xx:xx.x,enable_ptype_lldp=1

The deprecation notice for the dynfield is removed and the driver
documentation is updated.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
* Added warning if dynfield is registered
---
 doc/guides/nics/intel_vf.rst                  | 29 +--------
 doc/guides/rel_notes/deprecation.rst          |  4 --
 doc/guides/rel_notes/release_26_11.rst        |  5 ++
 drivers/net/intel/common/tx.h                 |  2 +-
 drivers/net/intel/iavf/iavf_ethdev.c          | 30 ++-------
 drivers/net/intel/iavf/iavf_rxtx.c            | 15 ++---
 drivers/net/intel/iavf/iavf_rxtx.h            | 17 +-----
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   | 22 +++----
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 22 +++----
 drivers/net/intel/iavf/iavf_testpmd.c         | 61 -------------------
 10 files changed, 47 insertions(+), 160 deletions(-)

diff --git a/doc/guides/nics/intel_vf.rst b/doc/guides/nics/intel_vf.rst
index 8f8ce32cac..e635c1fac2 100644
--- a/doc/guides/nics/intel_vf.rst
+++ b/doc/guides/nics/intel_vf.rst
@@ -682,38 +682,13 @@ Diagnostic Utilities
 Tx LLDP Testing
 ~~~~~~~~~~~~~~~
 
-There are two methods to trigger LLDP packet transmission from the VF.
-
-The first (and recommended) method is to set the ``packet_type`` of the mbuf
-to ``RTE_PTYPE_L2_ETHER_LLDP``.
+To trigger LLDP packet transmission from the VF, set the ``packet_type``
+of the mbuf to ``RTE_PTYPE_L2_ETHER_LLDP``.
 This, in conjunction with enabling the ``enable_ptype_lldp`` devarg
 will cause such packets to be transmitted::
 
     -a 0000:xx:xx.x,enable_ptype_lldp=1
 
-An alternative method is to register an mbuf dynfield ``IAVF_TX_LLDP_DYNFIELD``
-before ``dev_start``.
-This dynfield needs to be set to 1 when preparing an LLDP packet intended for transmission.
-
-.. note::
-
-   The dynamic mbuf field method is deprecated and will be removed in a future release.
-   Users should migrate to the ``enable_ptype_lldp`` devarg and mbuf LLDP ptype method
-   described above.
-
-For ``dpdk-testpmd`` application, the dynamic mbuf field is registered
-when the following command is issued:
-
-Usage::
-
-    testpmd> set tx lldp on
-
-One must then stop and restart the port for it to take effect.
-These requirements only apply for the dynamic mbuf field method;
-no special steps are needed for the ``enable_ptype_lldp`` devarg method.
-If both methods are enabled, the ptype based method will take precedence
-over the dynamic mbuf field method.
-
 
 Limitations or Knowing issues
 -----------------------------
diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 6ad7698c6b..a3cf544982 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -167,10 +167,6 @@ Deprecation Notices
   ``drivers/bus/vmbus/rte_bus_vmbus.h`` will become internal to DPDK.
   Those API functions are used internally by DPDK core and netvsc PMD.
 
-* net/iavf: The dynamic mbuf field used to detect LLDP packets on the
-  transmit path in the iavf PMD will be removed in a future release.
-  After removal, only packet type-based detection will be supported.
-
 * net/iavf: The ``auto_reconfig`` devarg is deprecated
   and will be removed in a future release.
   It allows disabling the automatic restoration of device settings
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c8cc86295d..8dc82c016d 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -77,6 +77,11 @@ Removed Items
     ``rte_rib6_is_equal``
   * table: ``RTE_LPM_IPV6_ADDR_SIZE``
 
+* net/iavf: Removed the dynamic mbuf field method for detecting LLDP packets
+  on the transmit path, along with the ``set tx lldp on`` testpmd command.
+  The only remaining method for detecting LLDP packets is by using the mbuf
+  packet type in conjunction with the ``enable_ptype_lldp`` devarg.
+
 
 API Changes
 -----------
diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index 5fe71aed12..55757d34d7 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -197,7 +197,7 @@ struct ci_tx_queue {
 			uint8_t vlan_flag;
 			uint8_t tc;
 			bool use_ctx;  /* with ctx info, each pkt needs two descriptors */
-			uint8_t lldp_mode; /* ptype or dynfield */
+			bool lldp_enabled;
 		};
 		struct { /* ixgbe specific values */
 			const struct ixgbe_txq_ops *ops;
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index d601ec3b6a..5d9d889a08 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -48,7 +48,6 @@
 #define IAVF_ENABLE_PTYPE_LLDP_ARG "enable_ptype_lldp"
 uint64_t iavf_timestamp_dynflag;
 int iavf_timestamp_dynfield_offset = -1;
-int rte_pmd_iavf_tx_lldp_dynfield_offset = -1;
 
 static const char * const iavf_valid_args[] = {
 	IAVF_PROTO_XTR_ARG,
@@ -1026,28 +1025,16 @@ iavf_dev_start(struct rte_eth_dev *dev)
 		}
 	}
 
-	/* Check Tx LLDP dynfield */
-	rte_pmd_iavf_tx_lldp_dynfield_offset =
-		rte_mbuf_dynfield_lookup(IAVF_TX_LLDP_DYNFIELD, NULL);
-	if (rte_pmd_iavf_tx_lldp_dynfield_offset > 0) {
+	/* Warn if an application still registers the removed LLDP Tx dynfield. */
+	if (rte_mbuf_dynfield_lookup("intel_pmd_dynfield_tx_lldp", NULL) >= 0)
 		PMD_DRV_LOG(WARNING,
-			"Using a dynamic mbuf field to identify LLDP packets is deprecated. "
-			"Set the 'enable_ptype_lldp' driver option and mbuf LLDP ptypes instead.");
-		if (adapter->devargs.enable_ptype_lldp)
-			PMD_DRV_LOG(WARNING,
-				"Both ptype and dynfield LLDP enabled; ptype takes precedence.");
-	}
+			"Tx LLDP dynamic mbuf field is no longer supported. "
+			"Use enable_ptype_lldp devarg and packet type instead.");
 
 	for (uint16_t i = 0; i < dev->data->nb_tx_queues; i++) {
 		struct ci_tx_queue *txq = dev->data->tx_queues[i];
-		if (txq) {
-			if (adapter->devargs.enable_ptype_lldp)
-				txq->lldp_mode = IAVF_LLDP_PTYPE;
-			else if (rte_pmd_iavf_tx_lldp_dynfield_offset > 0)
-				txq->lldp_mode = IAVF_LLDP_DYNFIELD;
-			else
-				txq->lldp_mode = IAVF_LLDP_DISABLED;
-		}
+		if (txq)
+			txq->lldp_enabled = adapter->devargs.enable_ptype_lldp;
 	}
 
 	if (iavf_init_queues(dev) != 0) {
@@ -3018,11 +3005,6 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
 	 */
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
 		iavf_set_rx_function(eth_dev);
-		/* LLDP may have been enabled by the primary process. Store the offset before
-		 * setting the TX function because it may be used in the selection function.
-		 */
-		rte_pmd_iavf_tx_lldp_dynfield_offset =
-			rte_mbuf_dynfield_lookup(IAVF_TX_LLDP_DYNFIELD, NULL);
 		iavf_set_tx_function(eth_dev);
 		return 0;
 	}
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 4f2ffe6188..c15486fa28 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -2325,7 +2325,7 @@ iavf_recv_pkts_bulk_alloc(void *rx_queue,
 
 /* Check if the context descriptor is needed for TX offloading */
 static inline uint16_t
-iavf_calc_context_desc(const struct rte_mbuf *mb, uint8_t vlan_flag, uint8_t lldp_mode)
+iavf_calc_context_desc(const struct rte_mbuf *mb, uint8_t vlan_flag, bool lldp_enabled)
 {
 	uint64_t flags = mb->ol_flags;
 	if (flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG |
@@ -2336,7 +2336,7 @@ iavf_calc_context_desc(const struct rte_mbuf *mb, uint8_t vlan_flag, uint8_t lld
 	    vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2)
 		return 1;
 
-	if (IAVF_CHECK_TX_LLDP(mb, lldp_mode))
+	if (IAVF_CHECK_TX_LLDP(mb, lldp_enabled))
 		return 1;
 
 	return 0;
@@ -2524,7 +2524,8 @@ iavf_get_context_desc(uint64_t ol_flags, const struct rte_mbuf *mbuf,
 		      const struct ci_tx_queue *txq,
 		      uint64_t *qw0, uint64_t *qw1)
 {
-	uint8_t iavf_vlan_flag, lldp_mode;
+	uint8_t iavf_vlan_flag;
+	bool lldp_enabled;
 	uint16_t cd_l2tag2 = 0;
 	uint64_t cd_type_cmd = IAVF_TX_DESC_DTYPE_CONTEXT;
 	uint64_t cd_tunneling_params = 0;
@@ -2532,10 +2533,10 @@ iavf_get_context_desc(uint64_t ol_flags, const struct rte_mbuf *mbuf,
 
 	/* Use IAVF-specific flags from txq */
 	iavf_vlan_flag = txq->vlan_flag;
-	lldp_mode = txq->lldp_mode;
+	lldp_enabled = txq->lldp_enabled;
 
 	/* Check if context descriptor is needed using existing IAVF logic */
-	if (!iavf_calc_context_desc(mbuf, iavf_vlan_flag, lldp_mode))
+	if (!iavf_calc_context_desc(mbuf, iavf_vlan_flag, lldp_enabled))
 		return 0;
 
 	/* Get IPsec metadata if needed */
@@ -2567,7 +2568,7 @@ iavf_get_context_desc(uint64_t ol_flags, const struct rte_mbuf *mbuf,
 	}
 
 	/* LLDP switching field */
-	if (IAVF_CHECK_TX_LLDP(mbuf, lldp_mode))
+	if (IAVF_CHECK_TX_LLDP(mbuf, lldp_enabled))
 		cd_type_cmd |= IAVF_TX_CTX_DESC_SWTCH_UPLINK << IAVF_TXD_CTX_QW1_CMD_SHIFT;
 
 	/* Tunneling field */
@@ -3927,7 +3928,7 @@ iavf_set_tx_function(struct rte_eth_dev *dev)
 	if (iavf_tx_vec_dev_check(dev) != -1)
 		req_features.simd_width = iavf_get_max_simd_bitwidth();
 
-	if (adapter->devargs.enable_ptype_lldp || rte_pmd_iavf_tx_lldp_dynfield_offset > 0)
+	if (adapter->devargs.enable_ptype_lldp)
 		req_features.ctx_desc = true;
 
 	for (i = 0; i < dev->data->nb_tx_queues; i++) {
diff --git a/drivers/net/intel/iavf/iavf_rxtx.h b/drivers/net/intel/iavf/iavf_rxtx.h
index 22ea415f44..6ad7182ef7 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.h
+++ b/drivers/net/intel/iavf/iavf_rxtx.h
@@ -155,23 +155,12 @@
 #define IAVF_TX_OFFLOAD_NOTSUP_MASK \
 		(RTE_MBUF_F_TX_OFFLOAD_MASK ^ IAVF_TX_OFFLOAD_MASK)
 
-#define IAVF_TX_LLDP_DYNFIELD "intel_pmd_dynfield_tx_lldp"
-
-/* LLDP Tx modes */
-#define IAVF_LLDP_DISABLED 0
-#define IAVF_LLDP_PTYPE    1
-#define IAVF_LLDP_DYNFIELD 2
-
-#define IAVF_CHECK_TX_LLDP(m, lldp_mode) \
-	((lldp_mode) && \
-	((((lldp_mode) == IAVF_LLDP_PTYPE) && \
-	((m)->packet_type & RTE_PTYPE_L2_MASK) == RTE_PTYPE_L2_ETHER_LLDP) || \
-	(((lldp_mode) == IAVF_LLDP_DYNFIELD) && \
-	*RTE_MBUF_DYNFIELD((m), rte_pmd_iavf_tx_lldp_dynfield_offset, uint8_t *))))
+#define IAVF_CHECK_TX_LLDP(m, ptype_lldp_enabled) \
+	((ptype_lldp_enabled) && \
+	((m)->packet_type & RTE_PTYPE_L2_MASK) == RTE_PTYPE_L2_ETHER_LLDP)
 
 extern uint64_t iavf_timestamp_dynflag;
 extern int iavf_timestamp_dynfield_offset;
-extern int rte_pmd_iavf_tx_lldp_dynfield_offset;
 
 typedef void (*iavf_rxd_to_pkt_fields_t)(struct ci_rx_queue *rxq,
 				struct rte_mbuf *mb,
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
index 9341d8412f..715805c65a 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
@@ -1903,7 +1903,7 @@ iavf_fill_ctx_desc_tunneling_field(volatile uint64_t *qw0,
 
 static __rte_always_inline void
 ctx_vtx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
-		uint64_t flags, bool offload, uint8_t vlan_flag, uint8_t lldp_mode)
+		uint64_t flags, bool offload, uint8_t vlan_flag, bool ptype_lldp_enabled)
 {
 	uint64_t high_ctx_qw = IAVF_TX_DESC_DTYPE_CONTEXT;
 	uint64_t low_ctx_qw = 0;
@@ -1924,7 +1924,7 @@ ctx_vtx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
 		}
 #endif
 	}
-	if (IAVF_CHECK_TX_LLDP(pkt, lldp_mode))
+	if (IAVF_CHECK_TX_LLDP(pkt, ptype_lldp_enabled))
 		high_ctx_qw |= IAVF_TX_CTX_DESC_SWTCH_UPLINK << IAVF_TXD_CTX_QW1_CMD_SHIFT;
 	uint64_t high_data_qw = (IAVF_TX_DESC_DTYPE_DATA |
 				((uint64_t)flags  << IAVF_TXD_QW1_CMD_SHIFT) |
@@ -1941,14 +1941,14 @@ ctx_vtx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
 static __rte_always_inline void
 ctx_vtx(volatile struct ci_tx_desc *txdp,
 		struct rte_mbuf **pkt, uint16_t nb_pkts, uint64_t flags,
-		bool offload, uint8_t vlan_flag, uint8_t lldp_mode)
+		bool offload, uint8_t vlan_flag, bool ptype_lldp_enabled)
 {
 	uint64_t hi_data_qw_tmpl = (IAVF_TX_DESC_DTYPE_DATA |
 					((uint64_t)flags  << IAVF_TXD_QW1_CMD_SHIFT));
 
 	/* if unaligned on 32-bit boundary, do one to align */
 	if (((uintptr_t)txdp & 0x1F) != 0 && nb_pkts != 0) {
-		ctx_vtx1(txdp, *pkt, flags, offload, vlan_flag, lldp_mode);
+		ctx_vtx1(txdp, *pkt, flags, offload, vlan_flag, ptype_lldp_enabled);
 		nb_pkts--; txdp++; pkt++;
 	}
 
@@ -1985,7 +1985,7 @@ ctx_vtx(volatile struct ci_tx_desc *txdp,
 			}
 		}
 #endif
-		if (IAVF_CHECK_TX_LLDP(pkt[1], lldp_mode))
+		if (IAVF_CHECK_TX_LLDP(pkt[1], ptype_lldp_enabled))
 			hi_ctx_qw1 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK << IAVF_TXD_CTX_QW1_CMD_SHIFT;
 
 #ifdef IAVF_TX_VLAN_QINQ_OFFLOAD
@@ -2006,7 +2006,7 @@ ctx_vtx(volatile struct ci_tx_desc *txdp,
 			}
 		}
 #endif
-		if (IAVF_CHECK_TX_LLDP(pkt[0], lldp_mode))
+		if (IAVF_CHECK_TX_LLDP(pkt[0], ptype_lldp_enabled))
 			hi_ctx_qw0 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK << IAVF_TXD_CTX_QW1_CMD_SHIFT;
 
 		if (offload) {
@@ -2029,7 +2029,7 @@ ctx_vtx(volatile struct ci_tx_desc *txdp,
 	}
 
 	if (nb_pkts)
-		ctx_vtx1(txdp, *pkt, flags, offload, vlan_flag, lldp_mode);
+		ctx_vtx1(txdp, *pkt, flags, offload, vlan_flag, ptype_lldp_enabled);
 }
 
 static __rte_always_inline uint16_t
@@ -2043,7 +2043,7 @@ iavf_xmit_fixed_burst_vec_avx2_ctx(void *tx_queue, struct rte_mbuf **tx_pkts,
 	/* bit2 is reserved and must be set to 1 according to Spec */
 	uint64_t flags = IAVF_TX_DESC_CMD_EOP | IAVF_TX_DESC_CMD_ICRC;
 	uint64_t rs = IAVF_TX_DESC_CMD_RS | flags;
-	uint8_t lldp_mode = txq->lldp_mode;
+	bool lldp_enabled = txq->lldp_enabled;
 
 	if (txq->nb_tx_free < txq->tx_free_thresh)
 		ci_tx_free_bufs_vec(txq, iavf_tx_desc_done, true);
@@ -2066,10 +2066,10 @@ iavf_xmit_fixed_burst_vec_avx2_ctx(void *tx_queue, struct rte_mbuf **tx_pkts,
 		nb_mbuf = n >> 1;
 		ci_tx_backlog_entry_vec(txep, tx_pkts, nb_mbuf);
 
-		ctx_vtx(txdp, tx_pkts, nb_mbuf - 1, flags, offload, txq->vlan_flag, lldp_mode);
+		ctx_vtx(txdp, tx_pkts, nb_mbuf - 1, flags, offload, txq->vlan_flag, lldp_enabled);
 		tx_pkts += (nb_mbuf - 1);
 		txdp += (n - 2);
-		ctx_vtx1(txdp, *tx_pkts++, rs, offload, txq->vlan_flag, lldp_mode);
+		ctx_vtx1(txdp, *tx_pkts++, rs, offload, txq->vlan_flag, lldp_enabled);
 
 		nb_commit = (uint16_t)(nb_commit - n);
 
@@ -2083,7 +2083,7 @@ iavf_xmit_fixed_burst_vec_avx2_ctx(void *tx_queue, struct rte_mbuf **tx_pkts,
 	nb_mbuf = nb_commit >> 1;
 	ci_tx_backlog_entry_vec(txep, tx_pkts, nb_mbuf);
 
-	ctx_vtx(txdp, tx_pkts, nb_mbuf, flags, offload, txq->vlan_flag, lldp_mode);
+	ctx_vtx(txdp, tx_pkts, nb_mbuf, flags, offload, txq->vlan_flag, lldp_enabled);
 	tx_id = (uint16_t)(tx_id + nb_commit);
 
 	if (tx_id > txq->tx_next_rs) {
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
index 83ba635062..dfbbea80f7 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
@@ -2047,7 +2047,7 @@ iavf_fill_ctx_desc_tunnelling_field(volatile uint64_t *qw0,
 
 static __rte_always_inline void
 ctx_vtx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
-		uint64_t flags, bool offload, uint8_t vlan_flag, uint8_t lldp_mode)
+		uint64_t flags, bool offload, uint8_t vlan_flag, bool lldp_enabled)
 {
 	uint64_t high_ctx_qw = IAVF_TX_DESC_DTYPE_CONTEXT;
 	uint64_t low_ctx_qw = 0;
@@ -2068,7 +2068,7 @@ ctx_vtx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
 		}
 #endif
 	}
-	if (IAVF_CHECK_TX_LLDP(pkt, lldp_mode))
+	if (IAVF_CHECK_TX_LLDP(pkt, lldp_enabled))
 		high_ctx_qw |= IAVF_TX_CTX_DESC_SWTCH_UPLINK
 			<< IAVF_TXD_CTX_QW1_CMD_SHIFT;
 	uint64_t high_data_qw = (CI_TX_DESC_DTYPE_DATA |
@@ -2086,13 +2086,13 @@ ctx_vtx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
 static __rte_always_inline void
 ctx_vtx(volatile struct ci_tx_desc *txdp,
 		struct rte_mbuf **pkt, uint16_t nb_pkts,  uint64_t flags,
-		bool offload, uint8_t vlan_flag, uint8_t lldp_mode)
+		bool offload, uint8_t vlan_flag, bool lldp_enabled)
 {
 	uint64_t hi_data_qw_tmpl = (CI_TX_DESC_DTYPE_DATA | (flags << CI_TXD_QW1_CMD_S));
 
 	/* if unaligned on 32-bit boundary, do one to align */
 	if (((uintptr_t)txdp & 0x1F) != 0 && nb_pkts != 0) {
-		ctx_vtx1(txdp, *pkt, flags, offload, vlan_flag, lldp_mode);
+		ctx_vtx1(txdp, *pkt, flags, offload, vlan_flag, lldp_enabled);
 		nb_pkts--; txdp++; pkt++;
 	}
 
@@ -2125,7 +2125,7 @@ ctx_vtx(volatile struct ci_tx_desc *txdp,
 			}
 		}
 #endif
-		if (IAVF_CHECK_TX_LLDP(pkt[1], lldp_mode))
+		if (IAVF_CHECK_TX_LLDP(pkt[1], lldp_enabled))
 			hi_ctx_qw1 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK
 				<< CI_TXD_QW1_CMD_S;
 
@@ -2145,7 +2145,7 @@ ctx_vtx(volatile struct ci_tx_desc *txdp,
 			}
 		}
 #endif
-		if (IAVF_CHECK_TX_LLDP(pkt[0], lldp_mode))
+		if (IAVF_CHECK_TX_LLDP(pkt[0], lldp_enabled))
 			hi_ctx_qw0 |= IAVF_TX_CTX_DESC_SWTCH_UPLINK << CI_TXD_QW1_CMD_S;
 
 		if (offload) {
@@ -2165,7 +2165,7 @@ ctx_vtx(volatile struct ci_tx_desc *txdp,
 	}
 
 	if (nb_pkts)
-		ctx_vtx1(txdp, *pkt, flags, offload, vlan_flag, lldp_mode);
+		ctx_vtx1(txdp, *pkt, flags, offload, vlan_flag, lldp_enabled);
 }
 
 static __rte_always_inline uint16_t
@@ -2246,7 +2246,7 @@ iavf_xmit_fixed_burst_vec_avx512_ctx(void *tx_queue, struct rte_mbuf **tx_pkts,
 	/* bit2 is reserved and must be set to 1 according to Spec */
 	uint64_t flags = CI_TX_DESC_CMD_EOP | CI_TX_DESC_CMD_ICRC;
 	uint64_t rs = CI_TX_DESC_CMD_RS | flags;
-	uint8_t lldp_mode = txq->lldp_mode;
+	bool lldp_enabled = txq->lldp_enabled;
 
 	if (txq->nb_tx_free < txq->tx_free_thresh)
 		ci_tx_free_bufs_vec(txq, iavf_tx_desc_done, true);
@@ -2269,10 +2269,10 @@ iavf_xmit_fixed_burst_vec_avx512_ctx(void *tx_queue, struct rte_mbuf **tx_pkts,
 		nb_mbuf = n >> 1;
 		tx_backlog_entry_avx512(txep, tx_pkts, nb_mbuf);
 
-		ctx_vtx(txdp, tx_pkts, nb_mbuf - 1, flags, offload, txq->vlan_flag, lldp_mode);
+		ctx_vtx(txdp, tx_pkts, nb_mbuf - 1, flags, offload, txq->vlan_flag, lldp_enabled);
 		tx_pkts += (nb_mbuf - 1);
 		txdp += (n - 2);
-		ctx_vtx1(txdp, *tx_pkts++, rs, offload, txq->vlan_flag, lldp_mode);
+		ctx_vtx1(txdp, *tx_pkts++, rs, offload, txq->vlan_flag, lldp_enabled);
 
 		nb_commit = (uint16_t)(nb_commit - n);
 
@@ -2286,7 +2286,7 @@ iavf_xmit_fixed_burst_vec_avx512_ctx(void *tx_queue, struct rte_mbuf **tx_pkts,
 	nb_mbuf = nb_commit >> 1;
 	tx_backlog_entry_avx512(txep, tx_pkts, nb_mbuf);
 
-	ctx_vtx(txdp, tx_pkts, nb_mbuf, flags, offload, txq->vlan_flag, lldp_mode);
+	ctx_vtx(txdp, tx_pkts, nb_mbuf, flags, offload, txq->vlan_flag, lldp_enabled);
 	tx_id = (uint16_t)(tx_id + nb_commit);
 
 	if (tx_id > txq->tx_next_rs) {
diff --git a/drivers/net/intel/iavf/iavf_testpmd.c b/drivers/net/intel/iavf/iavf_testpmd.c
index 4731d0b61b..f3b932da04 100644
--- a/drivers/net/intel/iavf/iavf_testpmd.c
+++ b/drivers/net/intel/iavf/iavf_testpmd.c
@@ -2,7 +2,6 @@
  * Copyright(c) 2010-2016 Intel Corporation.
  */
 
-#include <stdalign.h>
 #include <stdlib.h>
 
 #include <rte_pmd_iavf.h>
@@ -14,61 +13,6 @@
 #include "testpmd.h"
 #include "iavf_rxtx.h"
 
-struct cmd_enable_tx_lldp_result {
-	cmdline_fixed_string_t set;
-	cmdline_fixed_string_t tx;
-	cmdline_fixed_string_t lldp;
-	cmdline_fixed_string_t what;
-};
-
-static cmdline_parse_token_string_t cmd_enable_tx_lldp_set =
-	TOKEN_STRING_INITIALIZER(struct cmd_enable_tx_lldp_result,
-		set, "set");
-static cmdline_parse_token_string_t cmd_enable_tx_lldp_tx =
-	TOKEN_STRING_INITIALIZER(struct cmd_enable_tx_lldp_result,
-		tx, "tx");
-static cmdline_parse_token_string_t cmd_enable_tx_lldp_lldp =
-	TOKEN_STRING_INITIALIZER(struct cmd_enable_tx_lldp_result,
-		lldp, "lldp");
-static cmdline_parse_token_string_t cmd_enable_tx_lldp_what =
-	TOKEN_STRING_INITIALIZER(struct cmd_enable_tx_lldp_result,
-		what, "on#off");
-
-static void
-cmd_enable_tx_lldp_parsed(void *parsed_result,
-	__rte_unused struct cmdline *cl, __rte_unused void *data)
-{
-	struct cmd_enable_tx_lldp_result *res = parsed_result;
-	const struct rte_mbuf_dynfield iavf_tx_lldp_dynfield = {
-		.name = IAVF_TX_LLDP_DYNFIELD,
-		.size = sizeof(uint8_t),
-		.align = alignof(uint8_t),
-		.flags = 0
-	};
-	int offset;
-
-	if (strncmp(res->what, "on", 2) == 0) {
-		offset = rte_mbuf_dynfield_register(&iavf_tx_lldp_dynfield);
-		printf("rte_pmd_iavf_tx_lldp_dynfield_offset: %d", offset);
-		if (offset < 0)
-			fprintf(stderr,
-				"rte mbuf dynfield register failed, offset: %d", offset);
-	}
-}
-
-static cmdline_parse_inst_t cmd_enable_tx_lldp = {
-	.f = cmd_enable_tx_lldp_parsed,
-	.data = NULL,
-	.help_str = "set iavf tx lldp on|off",
-	.tokens = {
-		(void *)&cmd_enable_tx_lldp_set,
-		(void *)&cmd_enable_tx_lldp_tx,
-		(void *)&cmd_enable_tx_lldp_lldp,
-		(void *)&cmd_enable_tx_lldp_what,
-		NULL,
-	},
-};
-
 struct cmd_reinit_result {
 	cmdline_fixed_string_t port;
 	cmdline_fixed_string_t reinit;
@@ -117,11 +61,6 @@ static cmdline_parse_inst_t cmd_reinit = {
 
 static struct testpmd_driver_commands iavf_cmds = {
 	.commands = {
-	{
-		&cmd_enable_tx_lldp,
-		"set tx lldp (on|off)\n"
-		"    Set iavf Tx lldp packet(currently only supported on)\n\n",
-	},
 	{
 		&cmd_reinit,
 		"port reinit (port_id)\n"
-- 
2.43.0

