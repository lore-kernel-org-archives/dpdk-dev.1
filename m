Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324D4C44524
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 12:43:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A973400EF;
	Wed, 21 Jan 2026 13:43:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 25EC1400D7
 for <dev@dpdk.org>; Wed, 21 Jan 2026 13:42:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768999378; x=1800535378;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EmQhUU/UWnbf0E2Hd7VZOb5x+8VknFsxF2WTgKAr6t8=;
 b=Xh+oTQVB1nhPHrCmtQjS2XBbPCD+HzrWpmT2M73wQdwij4uSeM22cJWy
 0YdQEvOPBNg3gFQOfnLndG4NL5qirJLx8hoIod8TKlBCCijRtKfZQznXM
 8CaJAnBUSFWQ6Js932L3AQ44nm8qqSld5fw2Hsflq3gRDopev1smJeFIg
 tonl4tjrhrxoftsnFh5zvi2z5SBpmJDZ2/ET1ULFeNHTHLftgn0rExUvY
 iU9DwbQlcDv1nPnSOUxhGCVoe/nWFnq7W2WZgdroaUcFaM28E6Y3sAYn5
 jmZQ9xW6283Tyj/t9LDIcEUtMZejfSxAZiiQbt49tL3YZjH2mZma/up5K g==;
X-CSE-ConnectionGUID: xXs8ejttQ6qL/M71cGOIFA==
X-CSE-MsgGUID: 0WVzfCymSrGCJGqTxLtX7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="80942527"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; d="scan'208";a="80942527"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2026 04:42:57 -0800
X-CSE-ConnectionGUID: pRvRxmP4SVie2f1T6dL/cg==
X-CSE-MsgGUID: eL4JVzRsTLm6pZHCGFu2rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; d="scan'208";a="206866179"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa009.fm.intel.com with ESMTP; 21 Jan 2026 04:42:56 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v3] net/iavf: support pre and post reset callbacks
Date: Wed, 21 Jan 2026 12:42:50 +0000
Message-ID: <20260121124250.1999260-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260114132159.644359-1-ciara.loftus@intel.com>
References: <20260114132159.644359-1-ciara.loftus@intel.com>
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
v3:
* Fix build issue by removing iavf.h include in rte_pmd_iavf.h
---
 doc/guides/rel_notes/release_26_03.rst |  4 ++
 drivers/net/intel/iavf/iavf.h          |  5 ++
 drivers/net/intel/iavf/iavf_ethdev.c   | 80 ++++++++++++++++++++++++++
 drivers/net/intel/iavf/rte_pmd_iavf.h  | 45 +++++++++++++++
 4 files changed, 134 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index a50f6ee231..09d9cc3813 100644
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
index cbd7f036f3..39949acc11 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -15,6 +15,7 @@
 #include <iavf_type.h>
 
 #include "iavf_log.h"
+#include "rte_pmd_iavf.h"
 
 #define IAVF_AQ_LEN               32
 #define IAVF_AQ_BUF_SZ            4096
@@ -257,6 +258,10 @@ struct iavf_info {
 
 	struct iavf_vsi vsi;
 	bool vf_reset;	/* true for VF reset pending, false for no VF reset */
+	iavf_pre_reset_cb_t pre_reset_cb; /* Pre reset callback function ptr */
+	iavf_post_reset_cb_t post_reset_cb; /* Post reset callback function ptr */
+	void *pre_reset_cb_arg; /* Pre reset callback argument */
+	void *post_reset_cb_arg; /* Post reset callback argument */
 	uint64_t flags;
 
 	uint8_t *rss_lut;
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index ad48386343..802e095174 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -3132,6 +3132,10 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset)
 	vf->in_reset_recovery = true;
 	iavf_set_no_poll(adapter, false);
 
+	/* Call the pre reset callback */
+	if (vf->pre_reset_cb != NULL)
+		vf->pre_reset_cb(dev->data->port_id, vf->pre_reset_cb_arg);
+
 	ret = iavf_dev_reset(dev);
 	if (ret)
 		goto error;
@@ -3156,6 +3160,10 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset)
 error:
 	PMD_DRV_LOG(DEBUG, "RESET recover with error code=%dn", ret);
 exit:
+	/* Call the post reset callback */
+	if (vf->post_reset_cb != NULL)
+		vf->post_reset_cb(dev->data->port_id, ret, vf->post_reset_cb_arg);
+
 	vf->in_reset_recovery = false;
 	iavf_set_no_poll(adapter, false);
 
@@ -3195,6 +3203,78 @@ rte_pmd_iavf_reinit(uint16_t port)
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
index dea1bd2789..df4e947e85 100644
--- a/drivers/net/intel/iavf/rte_pmd_iavf.h
+++ b/drivers/net/intel/iavf/rte_pmd_iavf.h
@@ -24,6 +24,11 @@
 extern "C" {
 #endif
 
+/** Callback function pointer for pre VF reset event */
+typedef void (*iavf_pre_reset_cb_t)(uint16_t port_id, void *arg);
+/** Callback function pointer for post VF reset event */
+typedef void (*iavf_post_reset_cb_t)(uint16_t port_id, int reset_state, void *arg);
+
 /**
  * The supported network flexible descriptor's extraction metadata format.
  */
@@ -109,6 +114,46 @@ extern uint64_t rte_pmd_ifd_dynflag_proto_xtr_ipsec_crypto_said_mask;
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

