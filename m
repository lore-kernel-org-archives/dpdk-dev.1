Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62388C5CFC1
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 12:38:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A894402EF;
	Fri, 14 Aug 2026 14:38:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id F0469400D5
 for <dev@dpdk.org>; Fri, 14 Aug 2026 14:38:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786711085; x=1818247085;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HAXVep0WLzNQsVNfFuAYmqAbPUJ7gsoJDG7R519PScA=;
 b=mb6/FK8RZU8RiEsE+BLitNvF4+iemrIn9i6fg8smq5MCDIJNXZaKwqic
 kuN//vZdAbOzDXidGdM/zV5V3eNOu5zNW41+Qd/t8U9HDN1UiWAO/q7VQ
 1zHGyrMcWBB4LBno0ETnwwSC2XumbTC3H3vnqscmItY2k8hw9bY37SRBX
 cMd612wxV1B5gEB2HxM/5Hdeax5p1esYh5OIc1BiNXhUy+266BiDsExcC
 DcrKn+/dEnL2Cmiu/HTR8QEbUx/GPgspTz4a1l9KkQNVTnl74Rf2WrwJy
 48JLcBiEaBR8ADLb5jOFcH4N4MTEag+lqqqrRzcmYrvyNcG98OPwBMAEF g==;
X-CSE-ConnectionGUID: HD28AF7YSfu2SlkxJEyznA==
X-CSE-MsgGUID: 1U4tZB2pTrGikLBE84QNyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="104670486"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="104670486"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 05:38:04 -0700
X-CSE-ConnectionGUID: v4TKBO3SQNKqzk5P2HPQsw==
X-CSE-MsgGUID: 8LeWXnbyQQe10MLTTLdStw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="262459005"
Received: from silpixa00401921.ir.intel.com ([10.20.224.96])
 by orviesa006.jf.intel.com with ESMTP; 14 Aug 2026 05:38:03 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 2/2] net/iavf: rename LLDP Tx devarg
Date: Fri, 14 Aug 2026 12:37:53 +0000
Message-ID: <20260814123753.2041645-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814123753.2041645-1-ciara.loftus@intel.com>
References: <20260810140354.1869708-1-ciara.loftus@intel.com>
 <20260814123753.2041645-1-ciara.loftus@intel.com>
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

Rename the devarg to 'enable_lldp'. The old 'enable_ptype_lldp' name is
rejected with an error directing the user to the new name. This is
considered safe because the old devarg name only featured in one
release.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
* Hard fail instead of warning when old devarg is used
---
 doc/guides/nics/intel_vf.rst           |  9 +++++++--
 doc/guides/rel_notes/release_26_11.rst |  7 ++++++-
 drivers/net/intel/iavf/iavf.h          |  2 +-
 drivers/net/intel/iavf/iavf_ethdev.c   | 17 +++++++++++++----
 drivers/net/intel/iavf/iavf_rxtx.c     |  2 +-
 5 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/doc/guides/nics/intel_vf.rst b/doc/guides/nics/intel_vf.rst
index e635c1fac2..a075167d5f 100644
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
+   The ``enable_lldp`` devarg was previously named ``enable_ptype_lldp``.
+   The old name is no longer accepted.
 
 
 Limitations or Knowing issues
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 8dc82c016d..438610b468 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -55,6 +55,11 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Updated Intel iavf driver.**
+
+  * Renamed the ``enable_ptype_lldp`` devarg to ``enable_lldp``.
+    The old name is no longer accepted.
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
index 5d9d889a08..ad30930492 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -45,6 +45,7 @@
 #define IAVF_ENABLE_AUTO_RECONFIG_ARG "auto_reconfig"
 #define IAVF_NO_POLL_ON_LINK_DOWN_ARG "no-poll-on-link-down"
 #define IAVF_MBUF_CHECK_ARG       "mbuf_check"
+#define IAVF_ENABLE_LLDP_ARG       "enable_lldp"
 #define IAVF_ENABLE_PTYPE_LLDP_ARG "enable_ptype_lldp"
 uint64_t iavf_timestamp_dynflag;
 int iavf_timestamp_dynfield_offset = -1;
@@ -57,6 +58,7 @@ static const char * const iavf_valid_args[] = {
 	IAVF_ENABLE_AUTO_RECONFIG_ARG,
 	IAVF_NO_POLL_ON_LINK_DOWN_ARG,
 	IAVF_MBUF_CHECK_ARG,
+	IAVF_ENABLE_LLDP_ARG,
 	IAVF_ENABLE_PTYPE_LLDP_ARG,
 	NULL
 };
@@ -1029,12 +1031,12 @@ iavf_dev_start(struct rte_eth_dev *dev)
 	if (rte_mbuf_dynfield_lookup("intel_pmd_dynfield_tx_lldp", NULL) >= 0)
 		PMD_DRV_LOG(WARNING,
 			"Tx LLDP dynamic mbuf field is no longer supported. "
-			"Use enable_ptype_lldp devarg and packet type instead.");
+			"Use enable_lldp devarg and packet type instead.");
 
 	for (uint16_t i = 0; i < dev->data->nb_tx_queues; i++) {
 		struct ci_tx_queue *txq = dev->data->tx_queues[i];
 		if (txq)
-			txq->lldp_enabled = adapter->devargs.enable_ptype_lldp;
+			txq->lldp_enabled = adapter->devargs.enable_lldp;
 	}
 
 	if (iavf_init_queues(dev) != 0) {
@@ -2523,8 +2525,15 @@ static int iavf_parse_devargs(struct rte_eth_dev *dev)
 	if (ret)
 		goto bail;
 
-	ret = rte_kvargs_process(kvlist, IAVF_ENABLE_PTYPE_LLDP_ARG,
-				 &parse_bool, &ad->devargs.enable_ptype_lldp);
+	if (rte_kvargs_count(kvlist, IAVF_ENABLE_PTYPE_LLDP_ARG) > 0) {
+		PMD_INIT_LOG(ERR, "devarg '%s' has been renamed to '%s'",
+			IAVF_ENABLE_PTYPE_LLDP_ARG, IAVF_ENABLE_LLDP_ARG);
+		ret = -EINVAL;
+		goto bail;
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

