Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87181D2F32E
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 15:20:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71EB84067B;
	Tue, 13 Jan 2026 16:18:34 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 21D114065A
 for <dev@dpdk.org>; Tue, 13 Jan 2026 16:18:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768317513; x=1799853513;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=fnEpzRro4rhHuSi0ThteTQ9/YC2JGj4KGkT/VNy+S64=;
 b=P2wBMYsjQpacd01nK78C2lBNKgoeEyrJPMLEom/zIiPwrF9NK2ko2NSk
 8ePRHD0tHbjjofqDtGseEp79UHqPTfZDKLOk7Urdd7gm7e1KCEMy+wVls
 yQvSxR8jMULMjCLqAAUYGSZ7QEYeL8KLjJue/UoaLXV5DqWIEH5Ee7TE8
 n1czZBK0UNfPFbGnZ9iD5qp8fm4JCgkGzZily9NlJ2QvOChm28D1rGllw
 +Lp87rzhdso2r40R97uiwNhVse8AX6irSOCl0AHM6sTj7fgauesk5wMTM
 LipQ012V7jIwnhjydl53NDLUY/f6NQGSMemFeWJvlqlNmreRPgdAi0nNP Q==;
X-CSE-ConnectionGUID: whUR2/+0Toy1P+euCwaUmA==
X-CSE-MsgGUID: fS4loYeORhOcC58EFE0P9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="72185066"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="72185066"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2026 07:18:32 -0800
X-CSE-ConnectionGUID: 4CBkLMw9TzCBB2CwaIXO3Q==
X-CSE-MsgGUID: C1atkGjkR9yoNkO+0R+tYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="204298833"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa006.fm.intel.com with ESMTP; 13 Jan 2026 07:18:31 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH] net/iavf: support pre and post reset callbacks
Date: Tue, 13 Jan 2026 15:17:57 +0000
Message-ID: <20260113151757.567234-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
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
and restoring them after the reset. To facilitate this, introduce a
new function which allows the user to register either a pre or post
reset callback, which will be executed before or after the VF has been
reset. To unregister the callback, simply use the same function with a
null callback as argument.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 doc/guides/rel_notes/release_26_03.rst |  4 ++
 drivers/net/intel/iavf/iavf.h          | 15 +++++++
 drivers/net/intel/iavf/iavf_ethdev.c   | 62 ++++++++++++++++++++++++++
 drivers/net/intel/iavf/rte_pmd_iavf.h  | 24 ++++++++++
 4 files changed, 105 insertions(+)

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
index d78582e05c..5482472549 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -224,6 +224,17 @@ struct iavf_qtc_map {
 	uint16_t queue_count;
 };
 
+enum iavf_reset_cb_type {
+	IAVF_RESET_CB_TYPE_PRE,
+	IAVF_RESET_CB_TYPE_POST,
+};
+
+struct iavf_reset_cb_arg {
+	uint16_t port_id;
+	int reset_status;
+	void *user_state;
+};
+
 /* Structure to store private data specific for VF instance. */
 struct iavf_info {
 	uint16_t num_queue_pairs;
@@ -257,6 +268,10 @@ struct iavf_info {
 
 	struct iavf_vsi vsi;
 	bool vf_reset;	/* true for VF reset pending, false for no VF reset */
+	void (*pre_reset_cb)(struct iavf_reset_cb_arg *arg); /* Pre reset callback function ptr */
+	void (*post_reset_cb)(struct iavf_reset_cb_arg *arg); /* Post reset callback function ptr */
+	struct iavf_reset_cb_arg *pre_reset_cb_arg; /* Pre reset function argument */
+	struct iavf_reset_cb_arg *post_reset_cb_arg; /* Post reset function argument */
 	uint64_t flags;
 
 	uint8_t *rss_lut;
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 15e49fe248..553f38a286 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -3120,6 +3120,10 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset)
 	vf->in_reset_recovery = true;
 	iavf_set_no_poll(adapter, false);
 
+	/* Call the pre reset callback */
+	if (vf->pre_reset_cb)
+		(*vf->pre_reset_cb)(vf->pre_reset_cb_arg);
+
 	ret = iavf_dev_reset(dev);
 	if (ret)
 		goto error;
@@ -3144,6 +3148,13 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset)
 error:
 	PMD_DRV_LOG(DEBUG, "RESET recover with error code=%dn", ret);
 exit:
+	/* Update the reset status */
+	if (vf->post_reset_cb_arg)
+		vf->post_reset_cb_arg->reset_status = ret;
+	/* Call the post reset callback */
+	if (vf->post_reset_cb)
+		(*vf->post_reset_cb)(vf->post_reset_cb_arg);
+
 	vf->in_reset_recovery = false;
 	iavf_set_no_poll(adapter, false);
 
@@ -3183,6 +3194,57 @@ rte_pmd_iavf_reinit(uint16_t port)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_iavf_reset_cb_register, 26.03)
+int
+rte_pmd_iavf_reset_cb_register(uint16_t port,
+				   enum iavf_reset_cb_type cb_type,
+				   void (*reset_cb)(struct iavf_reset_cb_arg *arg),
+				   struct iavf_reset_cb_arg *reset_arg)
+{
+	struct rte_eth_dev *dev;
+	struct iavf_info *vf;
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port, -ENODEV);
+
+	dev = &rte_eth_devices[port];
+
+	if (!is_iavf_supported(dev)) {
+		PMD_DRV_LOG(ERR, "Cannot register callback, port %u is not an IAVF device.", port);
+		return -ENOTSUP;
+	}
+
+	if (reset_cb != NULL && reset_arg == NULL) {
+		PMD_DRV_LOG(ERR, "Cannot register callback on port %u, arg is NULL.", port);
+		return -EINVAL;
+	}
+
+	if (reset_arg != NULL)
+		reset_arg->port_id = port;
+
+	vf = IAVF_DEV_PRIVATE_TO_VF(dev->data->dev_private);
+
+	if (vf->in_reset_recovery) {
+		PMD_DRV_LOG(ERR, "Cannot modify reset callback on port %u, VF is resetting.", port);
+		return -EBUSY;
+	}
+
+	switch (cb_type) {
+	case IAVF_RESET_CB_TYPE_PRE:
+		vf->pre_reset_cb = reset_cb;
+		vf->pre_reset_cb_arg = reset_arg;
+		break;
+	case IAVF_RESET_CB_TYPE_POST:
+		vf->post_reset_cb = reset_cb;
+		vf->post_reset_cb_arg = reset_arg;
+		break;
+	default:
+		PMD_DRV_LOG(ERR, "Invalid reset callback type: %d", cb_type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 void
 iavf_set_no_poll(struct iavf_adapter *adapter, bool link_change)
 {
diff --git a/drivers/net/intel/iavf/rte_pmd_iavf.h b/drivers/net/intel/iavf/rte_pmd_iavf.h
index dea1bd2789..365f8a3e6a 100644
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
@@ -109,6 +111,28 @@ extern uint64_t rte_pmd_ifd_dynflag_proto_xtr_ipsec_crypto_said_mask;
 __rte_experimental
 int rte_pmd_iavf_reinit(uint16_t port);
 
+/**
+ * Register or unregister a pre or post reset event callback
+ *
+ * @param port
+ *   The port identifier of the Ethernet device.
+ * @param cb_type
+ *   The callback type, pre-reset (0) or post-reset (1).
+ * @param reset_cb
+ *   The callback function that will be invoked by the driver.
+ *   Pass NULL to unregister an existing callback.
+ * @param reset_arg
+ *   The argument passed to the callback function.
+ *   Can be NULL when unregistering (reset_cb is NULL).
+ * @return
+ *   0 if successful, otherwise if a failure occurs.
+ */
+__rte_experimental
+int rte_pmd_iavf_reset_cb_register(uint16_t port,
+	enum iavf_reset_cb_type cb_type,
+	void (*reset_cb)(struct iavf_reset_cb_arg *arg),
+	struct iavf_reset_cb_arg *reset_arg);
+
 /**
  * The mbuf dynamic field pointer for flexible descriptor's extraction metadata.
  */
-- 
2.43.0

