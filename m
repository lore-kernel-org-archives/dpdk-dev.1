Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26112E81BD7
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 15:21:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4966840657;
	Mon,  9 Feb 2026 16:21:06 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 116744028F
 for <dev@dpdk.org>; Mon,  9 Feb 2026 16:21:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770650464; x=1802186464;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ae1fzeGu38o70c62k6VZ6WCVQzppXoFkGYOapCkyhX8=;
 b=LUxlFXA2sL3o69pt62Live1spBVM8YKfrUiruZA5b52y8De/NDwLC61i
 g4sPqS+ky2UccJ798c3Z4R/By88zjxNvfJwq+BmCxQOlKSUK3yycUBS7m
 J2aEB9fdgdmtakA5sFG3X//aUSZScHeDDR03w+XtJQssutUvgAdF4l+Am
 kO22HNRQiy1ZrseYihAh2lvetTmQW7iE4vZ9+EnxjsA2F98zFHnH5U4pQ
 8rnt7Z72gdiNbVxEIG1ZuDxnRkV1202gvylQ8jBvSBW64bSQ5olleGmNA
 mhUSl2jlDBu+kWX/Zng8JbZ8OpzqwCtxssTch6seddv2yQQH5SSltRwyr g==;
X-CSE-ConnectionGUID: 1+cXOnkrTaq7GMI14fL1Xw==
X-CSE-MsgGUID: PQhRZhXtRzicsPV/aqsrkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71749095"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="71749095"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 07:21:04 -0800
X-CSE-ConnectionGUID: LJPso3jbQgC1OH4hJ+2wRA==
X-CSE-MsgGUID: GFB/7cqrTTi5Hu6LvbJTEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="211676126"
Received: from silpixa00401921.ir.intel.com ([10.20.224.96])
 by orviesa007.jf.intel.com with ESMTP; 09 Feb 2026 07:21:03 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 1/2] net/iavf: use mbuf packet type instead of dynfield for
 LLDP
Date: Mon,  9 Feb 2026 15:20:48 +0000
Message-ID: <20260209152049.1640121-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260209152049.1640121-1-ciara.loftus@intel.com>
References: <20260209152049.1640121-1-ciara.loftus@intel.com>
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

Instead of using a dynamic mbuf field to flag a packet as LLDP, instead
utilise the mbuf packet type field as the identifier instead. If the
type is RTE_PTYPE_L2_ETHER_LLDP the packet is identified as LLDP. This
approach is preferable because the use of dynamic mbuf fields should be
reserved for features that are not easily implemented using the existing
mbuf infrastructure. No negative performance impacts were observed with
the new approach.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 doc/guides/nics/intel_vf.rst           | 16 +++++++++-------
 doc/guides/rel_notes/release_26_03.rst |  1 +
 drivers/net/intel/iavf/iavf_ethdev.c   | 13 ++++++++-----
 drivers/net/intel/iavf/iavf_rxtx.c     |  3 +--
 drivers/net/intel/iavf/iavf_rxtx.h     |  8 +++-----
 drivers/net/intel/iavf/iavf_testpmd.c  | 20 +++++---------------
 drivers/net/intel/iavf/rte_pmd_iavf.h  | 10 ++++++++++
 7 files changed, 37 insertions(+), 34 deletions(-)

diff --git a/doc/guides/nics/intel_vf.rst b/doc/guides/nics/intel_vf.rst
index bc600e4b58..197918b2e8 100644
--- a/doc/guides/nics/intel_vf.rst
+++ b/doc/guides/nics/intel_vf.rst
@@ -668,19 +668,21 @@ Inline IPsec Support
 Diagnostic Utilities
 --------------------
 
-Register mbuf dynfield to test Tx LLDP
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Enable Tx LLDP
+~~~~~~~~~~~~~~
 
-Register an mbuf dynfield ``IAVF_TX_LLDP_DYNFIELD`` on ``dev_start``
-to indicate the need to send LLDP packet.
-This dynfield needs to be set to 1 when preparing packet.
-
-For ``dpdk-testpmd`` application, it needs to stop and restart Tx port to take effect.
+In order for the iavf PMD to transmit LLDP packets, two conditions must be met:
+1. mbufs carrying LLDP packets must have their ptype set to RTE_PTYPE_L2_ETHER_LLDP
+2. LLDP needs to be explicitly enabled eg. via ``dpdk-testpmd``:
 
 Usage::
 
     testpmd> set tx lldp on
 
+Note: the feature should be enabled before the device is started, so that a transmit
+path that is capable of transmitting LLDP packets is selected ie. one that supports
+context descriptors.
+
 
 Limitations or Knowing issues
 -----------------------------
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index a0f89b5ea2..c58c5cebd0 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -62,6 +62,7 @@ New Features
 * **Updated Intel iavf driver.**
 
   * Added support for pre and post VF reset callbacks.
+  * Changed LLDP packet detection from dynamic mbuf field to mbuf packet_type.
 
 
 Removed Items
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 802e095174..ae5fd86171 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -45,7 +45,7 @@
 #define IAVF_MBUF_CHECK_ARG       "mbuf_check"
 uint64_t iavf_timestamp_dynflag;
 int iavf_timestamp_dynfield_offset = -1;
-int rte_pmd_iavf_tx_lldp_dynfield_offset = -1;
+bool iavf_tx_lldp_enabled;
 
 static const char * const iavf_valid_args[] = {
 	IAVF_PROTO_XTR_ARG,
@@ -1024,10 +1024,6 @@ iavf_dev_start(struct rte_eth_dev *dev)
 		}
 	}
 
-	/* Check Tx LLDP dynfield */
-	rte_pmd_iavf_tx_lldp_dynfield_offset =
-		rte_mbuf_dynfield_lookup(IAVF_TX_LLDP_DYNFIELD, NULL);
-
 	if (iavf_init_queues(dev) != 0) {
 		PMD_DRV_LOG(ERR, "failed to do Queue init");
 		return -1;
@@ -3203,6 +3199,13 @@ rte_pmd_iavf_reinit(uint16_t port)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_iavf_enable_tx_lldp, 26.03)
+void
+rte_pmd_iavf_enable_tx_lldp(bool enable)
+{
+	iavf_tx_lldp_enabled = enable;
+}
+
 static int
 iavf_validate_reset_cb(uint16_t port, void *cb, void *cb_arg)
 {
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 4b763627bc..2fdd0f5ffe 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -4243,8 +4243,7 @@ iavf_set_tx_function(struct rte_eth_dev *dev)
 	if (iavf_tx_vec_dev_check(dev) != -1)
 		req_features.simd_width = iavf_get_max_simd_bitwidth();
 
-	if (rte_pmd_iavf_tx_lldp_dynfield_offset > 0)
-		req_features.ctx_desc = true;
+	req_features.ctx_desc = iavf_tx_lldp_enabled;
 
 	for (i = 0; i < dev->data->nb_tx_queues; i++) {
 		txq = dev->data->tx_queues[i];
diff --git a/drivers/net/intel/iavf/iavf_rxtx.h b/drivers/net/intel/iavf/iavf_rxtx.h
index e1f78dcde0..f8d75abe35 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.h
+++ b/drivers/net/intel/iavf/iavf_rxtx.h
@@ -168,14 +168,12 @@
 
 #define IAVF_TX_LLDP_DYNFIELD "intel_pmd_dynfield_tx_lldp"
 #define IAVF_CHECK_TX_LLDP(m) \
-	((rte_pmd_iavf_tx_lldp_dynfield_offset > 0) && \
-	(*RTE_MBUF_DYNFIELD((m), \
-			rte_pmd_iavf_tx_lldp_dynfield_offset, \
-			uint8_t *)))
+	(iavf_tx_lldp_enabled && \
+	((m)->packet_type & RTE_PTYPE_L2_MASK) == RTE_PTYPE_L2_ETHER_LLDP)
 
 extern uint64_t iavf_timestamp_dynflag;
 extern int iavf_timestamp_dynfield_offset;
-extern int rte_pmd_iavf_tx_lldp_dynfield_offset;
+extern bool iavf_tx_lldp_enabled;
 
 typedef void (*iavf_rxd_to_pkt_fields_t)(struct ci_rx_queue *rxq,
 				struct rte_mbuf *mb,
diff --git a/drivers/net/intel/iavf/iavf_testpmd.c b/drivers/net/intel/iavf/iavf_testpmd.c
index 4731d0b61b..44dc568e91 100644
--- a/drivers/net/intel/iavf/iavf_testpmd.c
+++ b/drivers/net/intel/iavf/iavf_testpmd.c
@@ -39,21 +39,11 @@ cmd_enable_tx_lldp_parsed(void *parsed_result,
 	__rte_unused struct cmdline *cl, __rte_unused void *data)
 {
 	struct cmd_enable_tx_lldp_result *res = parsed_result;
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
+	bool enable = strncmp(res->what, "on", 2) == 0;
+
+	rte_pmd_iavf_enable_tx_lldp(enable);
+
+	printf("Tx LLDP %s on iavf driver\n", enable ? "enabled" : "disabled");
 }
 
 static cmdline_parse_inst_t cmd_enable_tx_lldp = {
diff --git a/drivers/net/intel/iavf/rte_pmd_iavf.h b/drivers/net/intel/iavf/rte_pmd_iavf.h
index df4e947e85..2ae83dcbce 100644
--- a/drivers/net/intel/iavf/rte_pmd_iavf.h
+++ b/drivers/net/intel/iavf/rte_pmd_iavf.h
@@ -154,6 +154,16 @@ int rte_pmd_iavf_register_post_reset_cb(uint16_t port,
 					iavf_post_reset_cb_t post_reset_cb,
 					void *post_reset_cb_arg);
 
+/**
+ * Enable or disable Tx LLDP on the iavf driver.
+ *
+ * @param enable
+ *   Set to true to enable Tx LLDP, false to disable.
+ */
+__rte_experimental
+void
+rte_pmd_iavf_enable_tx_lldp(bool enable);
+
 /**
  * The mbuf dynamic field pointer for flexible descriptor's extraction metadata.
  */
-- 
2.43.0

