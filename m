Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B13C606A331
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 14:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CD8XGCJr
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F87D40689;
	Wed, 21 Oct 2026 16:26:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 2B53840615
 for <dev@dpdk.org>; Wed, 21 Oct 2026 16:26:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792592773; x=1824128773;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=8LVI6ejCoUhXbQ+x/m6cPA2044+1UOvqI276+OJBbhk=;
 b=CD8XGCJr2MyFIfpZHbQqoq23ZlxUcxxR3XlNPm0a0V/Ll/cCmDg9n60G
 ONFHsddEqcEXj9gNIZpNuDIKY84oiz78RWWvqUTb8Gs2wq1ag3wCtAdGe
 b+vc7hzAO1oJg+l5UFP+6LTJ4B3jEjhJOHn6zaq1qPyHuEhmpttBPoQjC
 sAoXvbnFVyfKNajao6yG53rFpNCLSCar7XIIXP+AoUvxkq0HEDKShRFEa
 N50cAATYiAKTEMhm33MYBMRfTkk7Z9ec/3aLVmTyz2q3lr8B1hioYNPwj
 eq/K9pJheUIKNGG/X4o98JTsB+mmjR74HOY1PpDysEc+PErsZxNjSWAWS Q==;
X-CSE-ConnectionGUID: dFiSP95eSS6tCNMQgmmPcQ==
X-CSE-MsgGUID: NH061BFnS9+1WXR0CWE+OA==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1192897"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1192897"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 07:26:12 -0700
X-CSE-ConnectionGUID: Jeuk5awSRBC4KIzYT54jRA==
X-CSE-MsgGUID: HTx8S/8mTH2udVhrw73E5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3570494"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa010.fm.intel.com with ESMTP; 21 Oct 2026 07:26:11 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v4 02/10] net/iavf: do not store ethdev pointer
Date: Wed, 21 Oct 2026 15:25:42 +0100
Message-ID: <ca5d8bff6bf3b9d8a597b354c2c9e547ffdf7f34.1792592724.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1792592724.git.anatoly.burakov@intel.com>
 <cover.1792592724.git.anatoly.burakov@intel.com>
References: 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

We should not be storing rte_eth_dev pointers in shared memory, because
rte_eth_dev pointers are process local. To address that, remove the pointer
from iavf_info, replace it with `rte_eth_devices`-based lookup, and rework
the call paths to either use that lookup, or not require ethdev pointer
in the first place.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf.h              |  9 ++++++--
 drivers/net/intel/iavf/iavf_ethdev.c       | 11 +++++-----
 drivers/net/intel/iavf/iavf_ipsec_crypto.c | 24 +++++++++++-----------
 drivers/net/intel/iavf/iavf_ipsec_crypto.h |  4 ++--
 drivers/net/intel/iavf/iavf_vchnl.c        |  7 ++++---
 5 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index c40b97444b5..1f277eeee29 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -7,6 +7,7 @@
 
 #include <sys/queue.h>
 
+#include <ethdev_driver.h>
 #include <rte_kvargs.h>
 #include <rte_tm_driver.h>
 
@@ -293,8 +294,6 @@ struct iavf_info {
 	struct iavf_qtc_map *qtc_map;
 	struct iavf_tm_conf tm_conf;
 
-	struct rte_eth_dev *eth_dev;
-
 	RTE_ATOMIC(bool)in_reset_recovery;
 	bool reset_pending;
 	bool pf_reset_in_progress;
@@ -408,6 +407,12 @@ struct iavf_adapter {
 	uint16_t tpid;  /* VLAN tag identifier */
 };
 
+static inline struct rte_eth_dev *
+iavf_get_eth_dev(struct iavf_adapter *adapter)
+{
+	return &rte_eth_devices[adapter->dev_data->port_id];
+}
+
 /* IAVF_DEV_PRIVATE_TO */
 #define IAVF_DEV_PRIVATE_TO_ADAPTER(adapter) \
 	((struct iavf_adapter *)adapter)
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 1ec9e946fc4..b5beaee8604 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -326,6 +326,7 @@ static void
 iavf_dev_watchdog(void *cb_arg)
 {
 	struct iavf_adapter *adapter = cb_arg;
+	struct rte_eth_dev *dev = iavf_get_eth_dev(adapter);
 	struct iavf_hw *hw = IAVF_DEV_PRIVATE_TO_HW(adapter);
 	int vfr_inprogress = 0, rc = 0;
 
@@ -339,7 +340,7 @@ iavf_dev_watchdog(void *cb_arg)
 
 		if (!vfr_inprogress) {
 			PMD_DRV_LOG(INFO, "VF \"%s\" reset has completed",
-				adapter->vf.eth_dev->data->name);
+				dev->data->name);
 			adapter->vf.vf_reset = false;
 			iavf_set_no_poll(adapter, false);
 		}
@@ -350,14 +351,14 @@ iavf_dev_watchdog(void *cb_arg)
 		if (vfr_inprogress) {
 			PMD_DRV_LOG(INFO,
 				"VF \"%s\" reset event detected by watchdog",
-				adapter->vf.eth_dev->data->name);
+				dev->data->name);
 
 			/* enter reset state with VFLR event */
 			adapter->vf.vf_reset = true;
 			iavf_set_no_poll(adapter, false);
 			adapter->vf.link_up = false;
 
-			iavf_dev_event_post(adapter->vf.eth_dev, RTE_ETH_EVENT_INTR_RESET,
+			iavf_dev_event_post(dev, RTE_ETH_EVENT_INTR_RESET,
 				NULL, 0);
 		}
 	}
@@ -369,7 +370,7 @@ iavf_dev_watchdog(void *cb_arg)
 
 		if (rc)
 			PMD_DRV_LOG(ERR, "Failed \"%s\" to reset device watchdog alarm",
-				adapter->vf.eth_dev->data->name);
+				dev->data->name);
 	}
 }
 
@@ -2669,8 +2670,6 @@ iavf_init_vf(struct rte_eth_dev *dev)
 	struct iavf_hw *hw = IAVF_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(dev->data->dev_private);
 
-	vf->eth_dev = dev;
-
 	err = iavf_parse_devargs(dev);
 	if (err) {
 		PMD_INIT_LOG(ERR, "Failed to parse devargs");
diff --git a/drivers/net/intel/iavf/iavf_ipsec_crypto.c b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
index 06b51b5e622..b4813303464 100644
--- a/drivers/net/intel/iavf/iavf_ipsec_crypto.c
+++ b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
@@ -689,11 +689,9 @@ iavf_ipsec_crypto_session_create(void *device,
  * returns: 1 if valid
  */
 uint32_t
-iavf_ipsec_crypto_action_valid(struct rte_eth_dev *ethdev,
+iavf_ipsec_crypto_action_valid(struct iavf_adapter *adapter,
 	const struct rte_security_session *session, uint32_t spi)
 {
-	struct iavf_adapter *adapter =
-		IAVF_DEV_PRIVATE_TO_ADAPTER(ethdev->data->dev_private);
 	const struct iavf_security_session *sess = (const void *)session->driver_priv_data;
 
 	/* verify we have a valid session and that it belong to this adapter */
@@ -1502,24 +1500,25 @@ static struct rte_security_ops iavf_ipsec_crypto_ops = {
 int
 iavf_security_ctx_create(struct iavf_adapter *adapter)
 {
+	struct rte_eth_dev *dev = iavf_get_eth_dev(adapter);
 	struct rte_security_ctx *sctx;
 
 	sctx = rte_malloc("security_ctx", sizeof(struct rte_security_ctx), 0);
 	if (sctx == NULL)
 		return -ENOMEM;
 
-	sctx->device = adapter->vf.eth_dev;
+	sctx->device = dev;
 	sctx->ops = &iavf_ipsec_crypto_ops;
 	sctx->sess_cnt = 0;
 
-	adapter->vf.eth_dev->security_ctx = sctx;
+	dev->security_ctx = sctx;
 
 	if (adapter->security_ctx == NULL) {
 		adapter->security_ctx = rte_malloc("iavf_security_ctx",
 				sizeof(struct iavf_security_ctx), 0);
 		if (adapter->security_ctx == NULL) {
-			rte_free(adapter->vf.eth_dev->security_ctx);
-			adapter->vf.eth_dev->security_ctx = NULL;
+			rte_free(dev->security_ctx);
+			dev->security_ctx = NULL;
 			return -ENOMEM;
 		}
 	}
@@ -1565,7 +1564,8 @@ iavf_security_get_pkt_md_offset(struct iavf_adapter *adapter)
 int
 iavf_security_ctx_destroy(struct iavf_adapter *adapter)
 {
-	struct rte_security_ctx *sctx  = adapter->vf.eth_dev->security_ctx;
+	struct rte_eth_dev *dev = iavf_get_eth_dev(adapter);
+	struct rte_security_ctx *sctx  = dev->security_ctx;
 	struct iavf_security_ctx *iavf_sctx = adapter->security_ctx;
 
 	if (iavf_sctx == NULL)
@@ -1578,7 +1578,7 @@ iavf_security_ctx_destroy(struct iavf_adapter *adapter)
 	rte_free(sctx);
 
 	adapter->security_ctx = NULL;
-	adapter->vf.eth_dev->security_ctx = NULL;
+	dev->security_ctx = NULL;
 
 	return 0;
 }
@@ -1748,7 +1748,7 @@ parse_udp_item(const struct rte_flow_item_udp *item, struct rte_udp_hdr *udp)
 }
 
 static struct iavf_ipsec_flow_item *
-iavf_ipsec_flow_item_parse(struct rte_eth_dev *ethdev,
+iavf_ipsec_flow_item_parse(struct iavf_adapter *adapter,
 		const struct rte_flow_item pattern[],
 		const struct rte_security_session *session,
 		uint32_t type)
@@ -1819,7 +1819,7 @@ iavf_ipsec_flow_item_parse(struct rte_eth_dev *ethdev,
 		goto flow_cleanup;
 	}
 
-	if (!iavf_ipsec_crypto_action_valid(ethdev, session,
+	if (!iavf_ipsec_crypto_action_valid(adapter, session,
 			ipsec_flow->spi))
 		goto flow_cleanup;
 
@@ -1967,7 +1967,7 @@ iavf_ipsec_flow_parse(struct iavf_adapter *ad,
 		const struct rte_security_session *session = parsed_actions.actions[0]->conf;
 		uint32_t type = (uint64_t)(item->meta);
 		struct iavf_ipsec_flow_item *fi =
-				iavf_ipsec_flow_item_parse(ad->vf.eth_dev, pattern, session, type);
+				iavf_ipsec_flow_item_parse(ad, pattern, session, type);
 		if (fi && meta) {
 			*meta = fi;
 			ret = 0;
diff --git a/drivers/net/intel/iavf/iavf_ipsec_crypto.h b/drivers/net/intel/iavf/iavf_ipsec_crypto.h
index 795b75a624d..3d4b1da127a 100644
--- a/drivers/net/intel/iavf/iavf_ipsec_crypto.h
+++ b/drivers/net/intel/iavf/iavf_ipsec_crypto.h
@@ -127,13 +127,13 @@ int iavf_security_get_pkt_md_offset(struct iavf_adapter *adapter);
 /**
  * Destroy security context
  */
-int iavf_security_ctx_destroy(struct iavf_adapter *adapterv);
+int iavf_security_ctx_destroy(struct iavf_adapter *adapter);
 
 /**
  * Verify that the inline IPsec Crypto action is valid for this device
  */
 uint32_t
-iavf_ipsec_crypto_action_valid(struct rte_eth_dev *ethdev,
+iavf_ipsec_crypto_action_valid(struct iavf_adapter *adapter,
 	const struct rte_security_session *session, uint32_t spi);
 
 /**
diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 57488512f43..26dae423a48 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -314,13 +314,14 @@ iavf_read_msg_from_pf(struct iavf_adapter *adapter, uint16_t buf_len,
 		    opcode, vf->cmd_retval);
 
 	if (opcode == VIRTCHNL_OP_EVENT) {
+		struct rte_eth_dev *dev = iavf_get_eth_dev(adapter);
 		struct virtchnl_pf_event *vpe =
 			(struct virtchnl_pf_event *)event.msg_buf;
 
 		result = IAVF_MSG_SYS;
 		switch (vpe->event) {
 		case VIRTCHNL_EVENT_LINK_CHANGE:
-			iavf_handle_link_change_event(vf->eth_dev, vpe);
+			iavf_handle_link_change_event(dev, vpe);
 			break;
 		case VIRTCHNL_EVENT_RESET_IMPENDING:
 			/*
@@ -335,8 +336,8 @@ iavf_read_msg_from_pf(struct iavf_adapter *adapter, uint16_t buf_len,
 				iavf_set_no_poll(adapter, false);
 				iavf_dev_watchdog_enable(adapter);
 				if (adapter->devargs.no_poll_on_link_down)
-					iavf_dev_tx_drain(vf->eth_dev);
-				iavf_dev_event_post(vf->eth_dev,
+					iavf_dev_tx_drain(dev);
+				iavf_dev_event_post(dev,
 					RTE_ETH_EVENT_INTR_RESET,
 					NULL, 0);
 			}
-- 
2.52.0

