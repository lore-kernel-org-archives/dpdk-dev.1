Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A0FD37E33
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 13:22:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A961402E0;
	Wed, 14 Jan 2026 14:22:55 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 756E7400D6
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:22:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768396973; x=1799932973;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lGVMqDGphkjFoxPoCHcV/+UPno4GGmbbT9NiyEPeD50=;
 b=TjVvkS6dkvmLDgnCVh4/3vWHM5MJcBh6oQoXNjOcTD4tZofwykuU5WQr
 s5Vf+ICL81CZ8FZufhDBoQ6xNCrbK32dP4rwWPOd4zxBoROr7DwM7Nopc
 ElZdd1SKeHN9ol4tbjqhL95QVsgCAMPz6nTIcBPM/y/3zF7Jk8i7IhlYh
 2xg9oMoFcEZea7WjpBRiuv0zJjOaGhruxeo/EeRKDGT5rVrrfHrXlYOxM
 8nhJ1GlSbHco0YHMmcxtABlncJqkAP2vTAeel4Kl3KqadYaDM4CNYNBDE
 JXU1ww5YDo90m4SMyep0qq99BH6w6o+Gu9ZRY9/TPVrIH1StHItLej9Pe A==;
X-CSE-ConnectionGUID: VFcJBHmNQBadL6vRM6gzXA==
X-CSE-MsgGUID: 4s3tNDeUSr+wF2h0pZ6XDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69778636"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="69778636"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2026 05:22:46 -0800
X-CSE-ConnectionGUID: EHx4Uea+RqaNrvDaIIr0XA==
X-CSE-MsgGUID: QTXgeIzHR+KnnkbL66cS5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="235391094"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa002.jf.intel.com with ESMTP; 14 Jan 2026 05:22:45 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2] net/iavf: support pre and post reset callbacks
Date: Wed, 14 Jan 2026 13:21:59 +0000
Message-ID: <20260114132159.644359-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113151757.567234-1-ciara.loftus@intel.com>
References: <20260113151757.567234-1-ciara.loftus@intel.com>
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

The user may want to perform some actions before and/or after a VF
reset, for example storing settings that may be lost during the reset
and restoring them after the reset. To facilitate this, introduce two
new functions which allow the user to register either a pre or post
reset callback, which will be executed before or after the VF has been
reset. To unregister the callback, simply use the register functions
with a NULL callback and argument.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
v2:
* Changed the function parameters of each cb
* Created separate register functions for each type of cb
* Use typedefs for the callbacks
* Fixed some style issues
* Permit NULL cb args when registering, application may just want to be
notified of the event and not require further processing.
---
 doc/guides/rel_notes/release_26_03.rst |  4 ++
 drivers/net/intel/iavf/iavf.h          |  8 +++
 drivers/net/intel/iavf/iavf_ethdev.c   | 80 ++++++++++++++++++++++++++
 drivers/net/intel/iavf/rte_pmd_iavf.h  | 42 ++++++++++++++
 4 files changed, 134 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 15dabee7a1..770f9933ee 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -55,6 +55,10 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Updated Intel iavf driver.**
+
+  * Added support for pre and post VF reset callbacks.
+
 
 Removed Items
 -------------
diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index d78582e05c..50ca14e41c 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -100,6 +100,10 @@ struct iavf_adapter;
 struct ci_rx_queue;
 struct ci_tx_queue;
 
+/** Callback function pointer for pre VF reset event */
+typedef void (*iavf_pre_reset_cb_t)(uint16_t port_id, void *arg);
+/** Callback function pointer for post VF reset event */
+typedef void (*iavf_post_reset_cb_t)(uint16_t port_id, int reset_state, void *arg);
 
 struct iavf_ipsec_crypto_stats {
 	uint64_t icount;
@@ -257,6 +261,10 @@ struct iavf_info {
 
 	struct iavf_vsi vsi;
 	bool vf_reset;	/* true for VF reset pending, false for no VF reset */
+	iavf_pre_reset_cb_t pre_reset_cb; /* Pre reset callback function ptr */
+	iavf_post_reset_cb_t post_reset_cb; /* Post reset callback function ptr */
+	void *pre_reset_cb_arg; /* Pre reset callback argument */
+	void *post_reset_cb_arg; /* Post reset callback argument */
 	uint64_t flags;
 
 	uint8_t *rss_lut;
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 15e49fe248..83e3486572 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -3120,6 +3120,10 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset)
 	vf->in_reset_recovery = true;
 	iavf_set_no_poll(adapter, false);
 
+	/* Call the pre reset callback */
+	if (vf->pre_reset_cb != NULL)
+		vf->pre_reset_cb(dev->data->port_id, vf->pre_reset_cb_arg);
+
 	ret = iavf_dev_reset(dev);
 	if (ret)
 		goto error;
@@ -3144,6 +3148,10 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset)
 error:
 	PMD_DRV_LOG(DEBUG, "RESET recover with error code=%dn", ret);
 exit:
+	/* Call the post reset callback */
+	if (vf->post_reset_cb != NULL)
+		vf->post_reset_cb(dev->data->port_id, ret, vf->post_reset_cb_arg);
+
 	vf->in_reset_recovery = false;
 	iavf_set_no_poll(adapter, false);
 
@@ -3183,6 +3191,78 @@ rte_pmd_iavf_reinit(uint16_t port)
 	return 0;
 }
 
+static int
+iavf_validate_reset_cb(uint16_t port, void *cb, void *cb_arg)
+{
+	struct rte_eth_dev *dev;
+	struct iavf_info *vf;
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port, -ENODEV);
+
+	if (cb == NULL && cb_arg != NULL) {
+		PMD_DRV_LOG(ERR, "Cannot unregister reset cb on port %u, arg must be NULL.", port);
+		return -EINVAL;
+	}
+
+	dev = &rte_eth_devices[port];
+	if (!is_iavf_supported(dev)) {
+		PMD_DRV_LOG(ERR, "Cannot modify reset cb, port %u not an IAVF device.", port);
+		return -ENOTSUP;
+	}
+
+	vf = IAVF_DEV_PRIVATE_TO_VF(dev->data->dev_private);
+	if (vf->in_reset_recovery) {
+		PMD_DRV_LOG(ERR, "Cannot modify reset cb on port %u, VF is resetting.", port);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_iavf_register_pre_reset_cb, 26.03)
+int
+rte_pmd_iavf_register_pre_reset_cb(uint16_t port,
+				   iavf_pre_reset_cb_t pre_reset_cb,
+				   void *pre_reset_cb_arg)
+{
+	struct rte_eth_dev *dev;
+	struct iavf_info *vf;
+	int ret;
+
+	ret = iavf_validate_reset_cb(port, pre_reset_cb, pre_reset_cb_arg);
+	if (ret)
+		return ret;
+
+	dev = &rte_eth_devices[port];
+	vf = IAVF_DEV_PRIVATE_TO_VF(dev->data->dev_private);
+	vf->pre_reset_cb = pre_reset_cb;
+	vf->pre_reset_cb_arg = pre_reset_cb_arg;
+
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_iavf_register_post_reset_cb, 26.03)
+int
+rte_pmd_iavf_register_post_reset_cb(uint16_t port,
+				    iavf_post_reset_cb_t post_reset_cb,
+				    void *post_reset_cb_arg)
+{
+	struct rte_eth_dev *dev;
+	struct iavf_info *vf;
+	int ret;
+
+	ret = iavf_validate_reset_cb(port, post_reset_cb, post_reset_cb_arg);
+	if (ret)
+		return ret;
+
+	dev = &rte_eth_devices[port];
+	vf = IAVF_DEV_PRIVATE_TO_VF(dev->data->dev_private);
+	vf->post_reset_cb = post_reset_cb;
+	vf->post_reset_cb_arg = post_reset_cb_arg;
+
+	return 0;
+}
+
 void
 iavf_set_no_poll(struct iavf_adapter *adapter, bool link_change)
 {
diff --git a/drivers/net/intel/iavf/rte_pmd_iavf.h b/drivers/net/intel/iavf/rte_pmd_iavf.h
index dea1bd2789..d13417eb08 100644
--- a/drivers/net/intel/iavf/rte_pmd_iavf.h
+++ b/drivers/net/intel/iavf/rte_pmd_iavf.h
@@ -20,6 +20,8 @@
 #include <rte_mbuf.h>
 #include <rte_mbuf_dyn.h>
 
+#include "iavf.h"
+
 #ifdef __cplusplus
 extern "C" {
 #endif
@@ -109,6 +111,46 @@ extern uint64_t rte_pmd_ifd_dynflag_proto_xtr_ipsec_crypto_said_mask;
 __rte_experimental
 int rte_pmd_iavf_reinit(uint16_t port);
 
+/**
+ * Register or unregister a pre reset event callback
+ *
+ * @param port
+ *   The port identifier of the Ethernet device.
+ * @param pre_reset_cb
+ *   The callback function that will be invoked by the driver prior to a reset.
+ *   Pass NULL to unregister an existing callback.
+ * @param pre_reset_cb_arg
+ *   The argument passed to the callback function.
+ *   May be NULL when registering the callback if no argument is needed to the callback.
+ *   Must be NULL when unregistering the callback.
+ * @return
+ *   0 if successful, otherwise if a failure occurs.
+ */
+__rte_experimental
+int rte_pmd_iavf_register_pre_reset_cb(uint16_t port,
+					iavf_pre_reset_cb_t pre_reset_cb,
+					void *pre_reset_cb_arg);
+
+/**
+ * Register or unregister a post reset event callback
+ *
+ * @param port
+ *   The port identifier of the Ethernet device.
+ * @param post_reset_cb
+ *   The callback function that will be invoked by the driver after a reset.
+ *   Pass NULL to unregister an existing callback.
+ * @param post_reset_cb_arg
+ *   The argument passed to the callback function.
+ *   May be NULL when registering the callback if no argument is needed to the callback.
+ *   Must be NULL when unregistering the callback.
+ * @return
+ *   0 if successful, otherwise if a failure occurs.
+ */
+__rte_experimental
+int rte_pmd_iavf_register_post_reset_cb(uint16_t port,
+					iavf_post_reset_cb_t post_reset_cb,
+					void *post_reset_cb_arg);
+
 /**
  * The mbuf dynamic field pointer for flexible descriptor's extraction metadata.
  */
-- 
2.43.0

