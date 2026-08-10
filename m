Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF03C5AE49
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Aug 2026 14:04:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7A7B40E37;
	Mon, 10 Aug 2026 16:04:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id BB17040144
 for <dev@dpdk.org>; Mon, 10 Aug 2026 16:04:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786370660; x=1817906660;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jgCvLis60uTOydgdvNsy7BFTf+i3RauvExSX/sibCXE=;
 b=jEwHO2H980YfREODWg1GygWppOsJOB1Kzu4w32FnnyM5H86qB319ySd6
 jYe2SmiKcKA6znUxX/cZI2P1hNy/FSNp3wp7ALlfAm0NEh5AITe9X1chW
 Rk1MgrSqA5xOCdX6Vn8jkm3QsyqmazqLwoxizm79ILQIpgoYNUfxv3/xV
 D95OORLBfBBGmeScbRI8c3H+FSvdP2voFCyQsffOU1t7ajfy//d/cU06/
 xFKScJU86CRsGVkgsblGqpfu0K4nckmn7QDRp3HJBWz1fMNmATCffEx6f
 +0E/FxWFdlhjObdapdUZetr5PLfHwEPjH5D71o/9mk4ItBXmDc69MKtGs A==;
X-CSE-ConnectionGUID: wBLtWwM9SQuMaQV3X7BlSw==
X-CSE-MsgGUID: h4VurrTrQZmuHtw60lQKmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="98036483"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; d="scan'208";a="98036483"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2026 07:04:13 -0700
X-CSE-ConnectionGUID: BqosAXyeRiKg5c+TN5XfNQ==
X-CSE-MsgGUID: uDT52TOBRDyCG6HtzIW31g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; d="scan'208";a="261301009"
Received: from silpixa00401921.ir.intel.com ([10.20.224.96])
 by orviesa006.jf.intel.com with ESMTP; 10 Aug 2026 07:04:12 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 2/2] net/iavf: rename LLDP Tx devarg
Date: Mon, 10 Aug 2026 14:03:54 +0000
Message-ID: <20260810140354.1869708-2-ciara.loftus@intel.com>
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

Now that the dynamic mbuf field method has been removed, packet type is
the only mechanism used to detect LLDP packets on the transmit path.
Using the word 'ptype' in the 'enable_ptype_lldp' devarg is therefore
unnecessary and an implementation detail that no longer needs to be
exposed to users.

Add an 'enable_lldp' devarg but keep 'enable_ptype_lldp' as a deprecated
alias that maps to the same setting and emits a warning when used. If
both are supplied, 'enable_lldp' takes precedence. The
'enable_ptype_lldp' devarg will be removed in a future release.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 doc/guides/nics/intel_vf.rst           |  9 +++++++--
 doc/guides/rel_notes/deprecation.rst   |  3 +++
 doc/guides/rel_notes/release_26_11.rst |  7 ++++++-
 drivers/net/intel/iavf/iavf.h          |  2 +-
 drivers/net/intel/iavf/iavf_ethdev.c   | 20 +++++++++++++++++---
 drivers/net/intel/iavf/iavf_rxtx.c     |  2 +-
 6 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/doc/guides/nics/intel_vf.rst b/doc/guides/nics/intel_vf.rst
index e635c1fac2..cb3a5a7079 100644
--- a/doc/guides/nics/intel_vf.rst
+++ b/doc/guides/nics/intel_vf.rst
@@ -684,10 +684,15 @@ Tx LLDP Testing
 
 To trigger LLDP packet transmission from the VF, set the ``packet_type``
 of the mbuf to ``RTE_PTYPE_L2_ETHER_LLDP``.
-This, in conjunction with enabling the ``enable_ptype_lldp`` devarg
+This, in conjunction with enabling the ``enable_lldp`` devarg
 will cause such packets to be transmitted::
 
-    -a 0000:xx:xx.x,enable_ptype_lldp=1
+    -a 0000:xx:xx.x,enable_lldp=1
+
+.. note::
+
+   The ``enable_ptype_lldp`` devarg is a deprecated alias for ``enable_lldp``
+   and will be removed in a future release.
 
 
 Limitations or Knowing issues
diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index a3cf544982..6e2d067adb 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -173,3 +173,6 @@ Deprecation Notices
   after a VF reset, but this is of questionable value
   since most applications expect their settings to be preserved
   transparently across a reset.
+
+* net/iavf: The ``enable_ptype_lldp`` devarg is deprecated and will be
+  removed in a future release. Use the ``enable_lldp`` devarg instead.
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 8dc82c016d..f110c4dffa 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -55,6 +55,11 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Updated Intel iavf driver.**
+
+  * Added the ``enable_lldp`` devarg to enable LLDP packet transmission.
+    The ``enable_ptype_lldp`` devarg is retained as a deprecated alias.
+
 
 Removed Items
 -------------
@@ -80,7 +85,7 @@ Removed Items
 * net/iavf: Removed the dynamic mbuf field method for detecting LLDP packets
   on the transmit path, along with the ``set tx lldp on`` testpmd command.
   The only remaining method for detecting LLDP packets is by using the mbuf
-  packet type in conjunction with the ``enable_ptype_lldp`` devarg.
+  packet type in conjunction with the ``enable_lldp`` devarg.
 
 
 API Changes
diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 293adaf6c9..dc33ba5a4b 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -326,7 +326,7 @@ struct iavf_devargs {
 	int auto_reconfig;
 	int no_poll_on_link_down;
 	uint64_t mbuf_check;
-	int enable_ptype_lldp;
+	int enable_lldp;
 };
 
 struct iavf_security_ctx;
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index fddbd06bbc..244f4052aa 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -45,6 +45,8 @@
 #define IAVF_ENABLE_AUTO_RECONFIG_ARG "auto_reconfig"
 #define IAVF_NO_POLL_ON_LINK_DOWN_ARG "no-poll-on-link-down"
 #define IAVF_MBUF_CHECK_ARG       "mbuf_check"
+#define IAVF_ENABLE_LLDP_ARG       "enable_lldp"
+/* Deprecated alias for IAVF_ENABLE_LLDP_ARG. */
 #define IAVF_ENABLE_PTYPE_LLDP_ARG "enable_ptype_lldp"
 uint64_t iavf_timestamp_dynflag;
 int iavf_timestamp_dynfield_offset = -1;
@@ -57,6 +59,7 @@ static const char * const iavf_valid_args[] = {
 	IAVF_ENABLE_AUTO_RECONFIG_ARG,
 	IAVF_NO_POLL_ON_LINK_DOWN_ARG,
 	IAVF_MBUF_CHECK_ARG,
+	IAVF_ENABLE_LLDP_ARG,
 	IAVF_ENABLE_PTYPE_LLDP_ARG,
 	NULL
 };
@@ -1028,7 +1031,7 @@ iavf_dev_start(struct rte_eth_dev *dev)
 	for (uint16_t i = 0; i < dev->data->nb_tx_queues; i++) {
 		struct ci_tx_queue *txq = dev->data->tx_queues[i];
 		if (txq)
-			txq->lldp_enabled = adapter->devargs.enable_ptype_lldp;
+			txq->lldp_enabled = adapter->devargs.enable_lldp;
 	}
 
 	if (iavf_init_queues(dev) != 0) {
@@ -2517,8 +2520,19 @@ static int iavf_parse_devargs(struct rte_eth_dev *dev)
 	if (ret)
 		goto bail;
 
-	ret = rte_kvargs_process(kvlist, IAVF_ENABLE_PTYPE_LLDP_ARG,
-				 &parse_bool, &ad->devargs.enable_ptype_lldp);
+	/* Deprecated alias: same behaviour as enable_lldp. */
+	if (rte_kvargs_count(kvlist, IAVF_ENABLE_PTYPE_LLDP_ARG) > 0) {
+		PMD_INIT_LOG(WARNING,
+			"devarg '%s' is deprecated, use '%s' instead",
+			IAVF_ENABLE_PTYPE_LLDP_ARG, IAVF_ENABLE_LLDP_ARG);
+		ret = rte_kvargs_process(kvlist, IAVF_ENABLE_PTYPE_LLDP_ARG,
+					 &parse_bool, &ad->devargs.enable_lldp);
+		if (ret)
+			goto bail;
+	}
+
+	ret = rte_kvargs_process(kvlist, IAVF_ENABLE_LLDP_ARG,
+				 &parse_bool, &ad->devargs.enable_lldp);
 	if (ret)
 		goto bail;
 
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index c15486fa28..e2c8686ab0 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -3928,7 +3928,7 @@ iavf_set_tx_function(struct rte_eth_dev *dev)
 	if (iavf_tx_vec_dev_check(dev) != -1)
 		req_features.simd_width = iavf_get_max_simd_bitwidth();
 
-	if (adapter->devargs.enable_ptype_lldp)
+	if (adapter->devargs.enable_lldp)
 		req_features.ctx_desc = true;
 
 	for (i = 0; i < dev->data->nb_tx_queues; i++) {
-- 
2.43.0

