Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A80F43689
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Apr 2026 10:08:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E67940650;
	Fri, 17 Apr 2026 12:08:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 3AA47402A3
 for <dev@dpdk.org>; Fri, 17 Apr 2026 12:08:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776420495; x=1807956495;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/NAtRtVg6UguK5NxF/hq5l6XJzhS5SaVsHs9kfzMTjQ=;
 b=FHEHOa46jBD8G5NiekL23o85APTBJq9NBlQauHV+JFbs055Ha8t2jF4d
 E0FnhD2Pg6vR8aF+0L48bPKK2r4W7L+5jWkHWOQuatvseULBbKIQHZ/De
 6mzyumiwg+tyfDUZDqTbIey0aI0TNP4hcBBX8pmpnq4X8BYX3hNWwzKsU
 n/xy1ZsqxR0gWWW44UkQ2mJygsbIv02N5PNzohS/WVSRg+FN/fPpQbKdW
 GRddHzW/03w5cL1dd4pL7bgPqnb7ZptxPs3w+sZsKbZcaQFnKCZz+WmyN
 2niX2KGoFSef9ozSfg1SFc1E9dgWxW9wd3Bq08jjZoDR4bSsryUKQ/rgf g==;
X-CSE-ConnectionGUID: an5wALSkRfG0pfWfUgQaTA==
X-CSE-MsgGUID: FAmcyccNT5i62qzp1UhJxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="88887888"
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; d="scan'208";a="88887888"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2026 03:08:15 -0700
X-CSE-ConnectionGUID: A7jkPQJ9RUCDdiSIInEVGQ==
X-CSE-MsgGUID: Mz6fifISTiWJILWT45lC5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; d="scan'208";a="234987817"
Received: from silpixa00401921.ir.intel.com ([10.20.224.96])
 by orviesa003.jf.intel.com with ESMTP; 17 Apr 2026 03:08:14 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v3 1/3] net/iavf: support LLDP Tx via mbuf ptype or dynfield
Date: Fri, 17 Apr 2026 10:08:02 +0000
Message-ID: <20260417100804.1143121-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417100804.1143121-1-ciara.loftus@intel.com>
References: <20260306115214.467033-1-ciara.loftus@intel.com>
 <20260417100804.1143121-1-ciara.loftus@intel.com>
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
v3:
* Enable ptype LLDP via new devarg
---
 doc/guides/nics/intel_vf.rst           | 21 ++++++++++++++++-----
 doc/guides/rel_notes/release_26_07.rst |  5 +++++
 drivers/net/intel/iavf/iavf.h          |  1 +
 drivers/net/intel/iavf/iavf_ethdev.c   | 15 +++++++++++++++
 drivers/net/intel/iavf/iavf_rxtx.c     |  2 +-
 drivers/net/intel/iavf/iavf_rxtx.h     |  9 +++++----
 6 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/doc/guides/nics/intel_vf.rst b/doc/guides/nics/intel_vf.rst
index 5fa2ddc9ea..4b65fa50cc 100644
--- a/doc/guides/nics/intel_vf.rst
+++ b/doc/guides/nics/intel_vf.rst
@@ -675,12 +675,14 @@ Inline IPsec Support
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
+
+The first method is to register an mbuf dynfield ``IAVF_TX_LLDP_DYNFIELD`` before
+``dev_start``. This dynfield needs to be set to 1 when preparing an LLDP packet
+intended for transmission.
 
 For ``dpdk-testpmd`` application, it needs to stop and restart Tx port to take effect.
 
@@ -688,6 +690,15 @@ Usage::
 
     testpmd> set tx lldp on
 
+An alternative method for transmitting LLDP packets is to set the ``packet_type`` of
+the mbuf to ``RTE_PTYPE_L2_ETHER_LLDP``. This, in conjunction with enabling the
+``enable_ptype_lldp`` devarg will cause such packets to be transmitted::
+
+    -a 0000:xx:xx.x,enable_ptype_lldp=1
+
+When ``enable_ptype_lldp`` is not set (default), ptype-based LLDP detection is
+disabled, but LLDP transmission via the dynamic mbuf field remains available.
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
index 3126d9b644..77e8c6b54b 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -44,9 +44,11 @@
 #define IAVF_ENABLE_AUTO_RECONFIG_ARG "auto_reconfig"
 #define IAVF_NO_POLL_ON_LINK_DOWN_ARG "no-poll-on-link-down"
 #define IAVF_MBUF_CHECK_ARG       "mbuf_check"
+#define IAVF_ENABLE_PTYPE_LLDP_ARG "enable_ptype_lldp"
 uint64_t iavf_timestamp_dynflag;
 int iavf_timestamp_dynfield_offset = -1;
 int rte_pmd_iavf_tx_lldp_dynfield_offset = -1;
+bool iavf_ptype_lldp_enabled;
 
 static const char * const iavf_valid_args[] = {
 	IAVF_PROTO_XTR_ARG,
@@ -56,6 +58,7 @@ static const char * const iavf_valid_args[] = {
 	IAVF_ENABLE_AUTO_RECONFIG_ARG,
 	IAVF_NO_POLL_ON_LINK_DOWN_ARG,
 	IAVF_MBUF_CHECK_ARG,
+	IAVF_ENABLE_PTYPE_LLDP_ARG,
 	NULL
 };
 
@@ -1016,6 +1019,11 @@ iavf_dev_start(struct rte_eth_dev *dev)
 	/* Check Tx LLDP dynfield */
 	rte_pmd_iavf_tx_lldp_dynfield_offset =
 		rte_mbuf_dynfield_lookup(IAVF_TX_LLDP_DYNFIELD, NULL);
+	if (rte_pmd_iavf_tx_lldp_dynfield_offset > 0)
+		PMD_DRV_LOG(WARNING,
+			"The LLDP Tx dynamic mbuf field will be removed in a future release.");
+	iavf_ptype_lldp_enabled = adapter->devargs.enable_ptype_lldp ||
+					rte_pmd_iavf_tx_lldp_dynfield_offset > 0;
 
 	if (iavf_init_queues(dev) != 0) {
 		PMD_DRV_LOG(ERR, "failed to do Queue init");
@@ -2445,6 +2453,11 @@ static int iavf_parse_devargs(struct rte_eth_dev *dev)
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
@@ -2795,6 +2808,8 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
 		 */
 		rte_pmd_iavf_tx_lldp_dynfield_offset =
 			rte_mbuf_dynfield_lookup(IAVF_TX_LLDP_DYNFIELD, NULL);
+		iavf_ptype_lldp_enabled = adapter->devargs.enable_ptype_lldp ||
+						rte_pmd_iavf_tx_lldp_dynfield_offset > 0;
 		iavf_set_tx_function(eth_dev);
 		return 0;
 	}
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 4ff6c18dc4..bb62ab07de 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -3886,7 +3886,7 @@ iavf_set_tx_function(struct rte_eth_dev *dev)
 	if (iavf_tx_vec_dev_check(dev) != -1)
 		req_features.simd_width = iavf_get_max_simd_bitwidth();
 
-	if (rte_pmd_iavf_tx_lldp_dynfield_offset > 0)
+	if (iavf_ptype_lldp_enabled)
 		req_features.ctx_desc = true;
 
 	for (i = 0; i < dev->data->nb_tx_queues; i++) {
diff --git a/drivers/net/intel/iavf/iavf_rxtx.h b/drivers/net/intel/iavf/iavf_rxtx.h
index 80b06518b0..0157c4c37e 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.h
+++ b/drivers/net/intel/iavf/iavf_rxtx.h
@@ -157,14 +157,15 @@
 
 #define IAVF_TX_LLDP_DYNFIELD "intel_pmd_dynfield_tx_lldp"
 #define IAVF_CHECK_TX_LLDP(m) \
-	((rte_pmd_iavf_tx_lldp_dynfield_offset > 0) && \
-	(*RTE_MBUF_DYNFIELD((m), \
-			rte_pmd_iavf_tx_lldp_dynfield_offset, \
-			uint8_t *)))
+	(iavf_ptype_lldp_enabled && \
+	(((m)->packet_type & RTE_PTYPE_L2_MASK) == RTE_PTYPE_L2_ETHER_LLDP || \
+	(rte_pmd_iavf_tx_lldp_dynfield_offset > 0 && \
+	*RTE_MBUF_DYNFIELD((m), rte_pmd_iavf_tx_lldp_dynfield_offset, uint8_t *))))
 
 extern uint64_t iavf_timestamp_dynflag;
 extern int iavf_timestamp_dynfield_offset;
 extern int rte_pmd_iavf_tx_lldp_dynfield_offset;
+extern bool iavf_ptype_lldp_enabled;
 
 typedef void (*iavf_rxd_to_pkt_fields_t)(struct ci_rx_queue *rxq,
 				struct rte_mbuf *mb,
-- 
2.43.0

