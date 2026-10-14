Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57889CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:20:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7862C40B9F;
	Wed, 14 Oct 2026 17:19:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 4ABC340DF5
 for <dev@dpdk.org>; Wed, 14 Oct 2026 17:19:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791991175; x=1823527175;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=MCkfRwSb84ojMcYCR1GVHQoqgCzbAnVLeSuVFRFXTE8=;
 b=HYwGieApauV2e14tnY6X+MHvM750ZH4G0hjGsvH6LuqrWXt2HxNIftXm
 w9aoYMutXxJiYYaU+PxVCJ5a89RriWmYo5G0orFkrPYNvXhzFoIl+ZF88
 zUfwxM9jpCsBX0QXUBm4dcYjE6GrWGUXoFM8McBxk688CtgwtJuveedTE
 aixlyQdoJeJ6J5eJZ8JrfqrvjdTNHptWFSg1blSLmILGM64uGXo07x+P4
 gjW8O1c/iYUjbLHRSaOgrXoxSAo/2UjlmgtTcQM6yQUF1OUEni5vavluR
 FBUK/n8e66muXiYLTTh/0tBsqdTHCzFP4iAZrmh0bUkpSSozQ2MIsSOZg g==;
X-CSE-ConnectionGUID: gSFGbyU8QxyZA4WkMNJgBg==
X-CSE-MsgGUID: hymwPStSQluD1/BzwGOqLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="646328"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="646328"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 08:19:11 -0700
X-CSE-ConnectionGUID: L1EFZCqBReyXoXwVkR/RxQ==
X-CSE-MsgGUID: OgGLlD7FR828SxGeyoByDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="3294670"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa011.fm.intel.com with ESMTP; 14 Oct 2026 08:19:09 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 7/7] net/iavf: do not store ethdev pointer
Date: Wed, 14 Oct 2026 16:18:50 +0100
Message-ID: <fc462b7b8008c04743d730a9fddb3b3b58024fd9.1791991100.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1791991100.git.anatoly.burakov@intel.com>
References: 
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

We should not be storing rte_eth_dev pointers in shared memory, because
rte_eth_dev pointers are process local. To address that, remove the pointer
from iavf_info, replace it with `rte_eth_devices`-based lookup, and rework
the call paths to either use that lookup, or not require ethdev pointer
in the first place.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf.h              |  9 ++++++--
 drivers/net/intel/iavf/iavf_ethdev.c       | 13 ++++++------
 drivers/net/intel/iavf/iavf_ipsec_crypto.c | 24 +++++++++++-----------
 drivers/net/intel/iavf/iavf_ipsec_crypto.h |  4 ++--
 drivers/net/intel/iavf/iavf_vchnl.c        |  7 ++++---
 5 files changed, 31 insertions(+), 26 deletions(-)

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
index 6cf12ec34f1..76c51e7c25b 100644
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
@@ -365,11 +366,11 @@ iavf_dev_watchdog(void *cb_arg)
 	if (adapter->devargs.watchdog_period) {
 		/* re-alarm watchdog */
 		rc = rte_eal_alarm_set(adapter->devargs.watchdog_period,
-					&iavf_dev_watchdog, cb_arg);
+					&iavf_dev_watchdog, dev);
 
 		if (rc)
 			PMD_DRV_LOG(ERR, "Failed \"%s\" to reset device watchdog alarm",
-				adapter->vf.eth_dev->data->name);
+				dev->data->name);
 	}
 }
 
@@ -2674,8 +2675,6 @@ iavf_init_vf(struct rte_eth_dev *dev)
 	struct iavf_hw *hw = IAVF_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(dev->data->dev_private);
 
-	vf->eth_dev = dev;
-
 	err = iavf_parse_devargs(dev);
 	if (err) {
 		PMD_INIT_LOG(ERR, "Failed to parse devargs");
diff --git a/drivers/net/intel/iavf/iavf_ipsec_crypto.c b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
index cd13e14ae74..8056c889cb1 100644
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
 
@@ -1972,7 +1972,7 @@ iavf_ipsec_flow_parse(struct iavf_adapter *ad,
 		const struct rte_security_session *session = parsed_actions.actions[0]->conf;
 		uint32_t type = (uint64_t)(item->meta);
 
-		fi = iavf_ipsec_flow_item_parse(ad->vf.eth_dev, pattern, session, type);
+		fi = iavf_ipsec_flow_item_parse(ad, pattern, session, type);
 	}
 	rte_free(item);
 
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

