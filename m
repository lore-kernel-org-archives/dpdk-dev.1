Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7902CA5FF0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 16:40:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9155940E78;
	Mon,  5 Oct 2026 18:38:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 0566A40E3B
 for <dev@dpdk.org>; Mon,  5 Oct 2026 18:38:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791218334; x=1822754334;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=XTghkPcoHfQ+5YqM2pKATSNps7ij7kws8SwTIUQLDuk=;
 b=Mj28GjZ1Fbf2ojbyMcmjGcA+VkmX1R2+9Y17A0otDzbCJimf6h59zhbj
 d4Qu++Es+kVN7dFrfSftMx7pzVAx4t31DosaOiSrnx+YoIzUskpFOhu2x
 As1sSEUw4Kf28apd2ccYtg5/V3wPh0cvq9+1ZfwHewntAGG5tFpYkBylj
 7EYYy54JhbN8Xw22S1mptQQAjkAXIWo6v/Qa7xoGIZP62yzW2xWsIIG8q
 vsKcp2ZSkp3RxVou9pmjegYJDlDRyTl/NoQU7YzzF6h0gqeW/96wIK7MQ
 SBx/SIaeMvQT93DRLHclmUfamTy5X4ihLIPVkXso34sZInVghu1DosiNf A==;
X-CSE-ConnectionGUID: I+mBBvcXQbKwkqljEGandA==
X-CSE-MsgGUID: HBslmWGdSUeB8YMmOk0wHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="90665328"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="90665328"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 09:38:53 -0700
X-CSE-ConnectionGUID: fxc1UJFOS9uuAZuBEEYJ3g==
X-CSE-MsgGUID: +LM9hu4NSaCp97w7dCliag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="945766"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa011.fm.intel.com with ESMTP; 05 Oct 2026 09:38:52 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v4 14/24] net/ixgbe: reimplement FDIR parser
Date: Mon,  5 Oct 2026 17:38:09 +0100
Message-ID: <916088f767a715dc1928df748de391735c75a308.1791218156.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1791218154.git.anatoly.burakov@intel.com>
 <cover.1791218154.git.anatoly.burakov@intel.com>
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

Use the new flow graph API and the common parsing framework to implement
flow parser for flow director.

The FDIR flow tracking is moved inside the new engine, and the FDIR code is
refactored to not mix software tracking with HW writes, remove redundant
state and configuration stages, and structure the state storage better.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c        |  118 +-
 drivers/net/intel/ixgbe/ixgbe_ethdev.h        |  102 +-
 drivers/net/intel/ixgbe/ixgbe_fdir.c          |  606 ++----
 drivers/net/intel/ixgbe/ixgbe_flow.c          | 1595 +---------------
 drivers/net/intel/ixgbe/ixgbe_flow.h          |    2 +
 drivers/net/intel/ixgbe/ixgbe_flow_fdir.c     | 1626 +++++++++++++++++
 .../net/intel/ixgbe/ixgbe_rxtx_vec_common.c   |    4 +-
 drivers/net/intel/ixgbe/meson.build           |    1 +
 8 files changed, 1923 insertions(+), 2131 deletions(-)
 create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow_fdir.c

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index db5e36adcc9..3228d1c5be3 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -147,8 +147,6 @@ static const char * const ixgbevf_valid_arguments[] = {
 
 static int eth_ixgbe_dev_init(struct rte_eth_dev *eth_dev, void *init_params);
 static int eth_ixgbe_dev_uninit(struct rte_eth_dev *eth_dev);
-static int ixgbe_fdir_filter_init(struct rte_eth_dev *eth_dev);
-static int ixgbe_fdir_filter_uninit(struct rte_eth_dev *eth_dev);
 static int ixgbe_l2_tn_filter_init(struct rte_eth_dev *eth_dev);
 static int ixgbe_dev_configure(struct rte_eth_dev *dev);
 static int ixgbe_dev_start(struct rte_eth_dev *dev);
@@ -1008,7 +1006,7 @@ ixgbe_parse_devargs(struct ixgbe_adapter *adapter,
 				       &pballoc) != 0)
 			ret = -EINVAL;
 		else
-			adapter->fdir_conf.pballoc = pballoc;
+			adapter->fdir_hw_config.pballoc = pballoc;
 	}
 
 	rte_kvargs_free(kvlist);
@@ -1261,11 +1259,6 @@ eth_ixgbe_dev_init(struct rte_eth_dev *eth_dev, void *init_params __rte_unused)
 	memset(filter_info, 0,
 	       sizeof(struct ixgbe_filter_info));
 
-	/* initialize flow director filter list & hash */
-	ret = ixgbe_fdir_filter_init(eth_dev);
-	if (ret)
-		goto err_fdir_filter_init;
-
 	/* initialize l2 tunnel filter list & hash */
 	ret = ixgbe_l2_tn_filter_init(eth_dev);
 	if (ret)
@@ -1289,8 +1282,6 @@ eth_ixgbe_dev_init(struct rte_eth_dev *eth_dev, void *init_params __rte_unused)
 	return 0;
 
 err_l2_tn_filter_init:
-	ixgbe_fdir_filter_uninit(eth_dev);
-err_fdir_filter_init:
 	ixgbe_disable_intr(hw);
 	rte_intr_disable(intr_handle);
 	rte_intr_callback_unregister(intr_handle,
@@ -1320,31 +1311,25 @@ eth_ixgbe_dev_uninit(struct rte_eth_dev *eth_dev)
 	return 0;
 }
 
-static int ixgbe_fdir_filter_uninit(struct rte_eth_dev *eth_dev)
+void
+ixgbe_fdir_state_detach(struct ixgbe_fdir_state *state)
 {
-	struct ixgbe_hw_fdir_info *fdir_info =
-		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(eth_dev->data->dev_private);
-	struct ixgbe_fdir_filter *fdir_filter;
+	if (!ci_usage_count_release(&state->engine_use_count))
+		return;
 
-	rte_free(fdir_info->hash_map);
-	rte_hash_free(fdir_info->hash_handle);
+	rte_hash_free(state->hash_handle);
 
-	while ((fdir_filter = TAILQ_FIRST(&fdir_info->fdir_list))) {
-		TAILQ_REMOVE(&fdir_info->fdir_list,
-			     fdir_filter,
-			     entries);
-		rte_free(fdir_filter);
-	}
-
-	return 0;
+	/* erase mask state as well */
+	*state = (struct ixgbe_fdir_state){0};
 }
 
-static int ixgbe_fdir_filter_init(struct rte_eth_dev *eth_dev)
+struct ixgbe_fdir_state *
+ixgbe_fdir_state_attach(struct rte_eth_dev_data *dev_data)
 {
-	struct ixgbe_hw_fdir_info *fdir_info =
-		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(eth_dev->data->dev_private);
+	struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev_data->dev_private);
+	struct ixgbe_fdir_state *state = &adapter->fdir_state;
 	char fdir_hash_name[RTE_HASH_NAMESIZE];
-	struct rte_hash_parameters fdir_hash_params = {
+	struct rte_hash_parameters hash_params = {
 		.name = fdir_hash_name,
 		.entries = IXGBE_MAX_FDIR_FILTER_NUM,
 		.key_len = sizeof(union ixgbe_atr_input),
@@ -1353,31 +1338,28 @@ static int ixgbe_fdir_filter_init(struct rte_eth_dev *eth_dev)
 		.socket_id = rte_socket_id(),
 	};
 
-	TAILQ_INIT(&fdir_info->fdir_list);
-	snprintf(fdir_hash_name, RTE_HASH_NAMESIZE,
-		 "fdir_%s", eth_dev->device->name);
-	fdir_info->hash_handle = rte_hash_create(&fdir_hash_params);
-	if (!fdir_info->hash_handle) {
-		PMD_INIT_LOG(ERR, "Failed to create fdir hash table!");
-		return -EINVAL;
-	}
-	fdir_info->hash_map = rte_zmalloc("ixgbe",
-					  sizeof(struct ixgbe_fdir_filter *) *
-					  IXGBE_MAX_FDIR_FILTER_NUM,
-					  0);
-	if (!fdir_info->hash_map) {
-		PMD_INIT_LOG(ERR,
-			     "Failed to allocate memory for fdir hash map!");
-		rte_hash_free(fdir_info->hash_handle);
-		return -ENOMEM;
-	}
-	fdir_info->n_flows = 0;
-	fdir_info->mask_added = FALSE;
+	snprintf(fdir_hash_name, RTE_HASH_NAMESIZE, "ixgbe_fdir_hash_%s",
+			dev_data->name);
+
+	if (ci_usage_count_claim(&state->engine_use_count)) {
+		struct rte_hash *hash_handle;
+
+		hash_handle = rte_hash_create(&hash_params);
 
-	/* drop queue is always fixed */
-	IXGBE_DEV_FDIR_CONF(eth_dev)->drop_queue = IXGBE_FDIR_DROP_QUEUE;
+		if (hash_handle == NULL) {
+			PMD_INIT_LOG(ERR, "Failed to create fdir hash table!");
+			ci_usage_count_release(&state->engine_use_count);
+			return NULL;
+		}
+
+		state->hash_handle = hash_handle;
+		state->config.mode = RTE_FDIR_MODE_NONE;
+
+		/* set up default values for the mask */
+		ixgbe_fdir_mask_set_default(&state->mask_conf.mask);
+	}
 
-	return 0;
+	return state;
 }
 
 static int ixgbe_l2_tn_filter_init(struct rte_eth_dev *eth_dev)
@@ -2174,9 +2156,27 @@ ixgbe_check_mq_mode(struct rte_eth_dev *dev)
 {
 	struct rte_eth_conf *dev_conf = &dev->data->dev_conf;
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	uint16_t nb_rx_q = dev->data->nb_rx_queues;
 	uint16_t nb_tx_q = dev->data->nb_tx_queues;
 
+	/* DCB-family modes reprogram RXPBSIZE and clash with FDIR's own use of it */
+	switch (dev_conf->rxmode.mq_mode) {
+	case RTE_ETH_MQ_RX_VMDQ_DCB:
+	case RTE_ETH_MQ_RX_DCB:
+	case RTE_ETH_MQ_RX_DCB_RSS:
+	case RTE_ETH_MQ_RX_VMDQ_DCB_RSS:
+		if (adapter->fdir_state.config.mode != RTE_FDIR_MODE_NONE) {
+			PMD_INIT_LOG(ERR, "Cannot use DCB mq_mode %d while "
+					"flow director rules are active.",
+					dev_conf->rxmode.mq_mode);
+			return -EINVAL;
+		}
+		break;
+	default:
+		break;
+	}
+
 	if (RTE_ETH_DEV_SRIOV(dev).active != 0) {
 		/* check multi-queue mode */
 		switch (dev_conf->rxmode.mq_mode) {
@@ -2497,7 +2497,6 @@ ixgbe_dev_start(struct rte_eth_dev *dev)
 	struct ixgbe_adapter *adapter =
 		IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
-	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
 	struct ixgbe_vf_info *vfinfo =
 		*IXGBE_DEV_PRIVATE_TO_P_VFDATA(dev->data->dev_private);
 	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
@@ -2602,14 +2601,6 @@ ixgbe_dev_start(struct rte_eth_dev *dev)
 	/* Configure DCB hw */
 	ixgbe_configure_dcb(dev);
 
-	if (fdir_conf->mode != RTE_FDIR_MODE_NONE) {
-		struct ixgbe_hw_fdir_info *info =
-			IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter);
-		err = ixgbe_fdir_configure(dev, fdir_conf, &info->mask);
-		if (err)
-			goto error;
-	}
-
 	/* Restore vf rate limit */
 	if (vfinfo != NULL) {
 		for (vf = 0; vf < pci_dev->max_vfs; vf++)
@@ -2878,6 +2869,9 @@ ixgbe_dev_stop(struct rte_eth_dev *dev)
 	/* reset hierarchy commit */
 	tm_conf->committed = false;
 
+	/* the reset above wiped the flow director setup, kept flows are replayed on start */
+	ixgbe_fdir_hw_invalidate(dev);
+
 	adapter->rss_reta_updated = 0;
 
 	hw->adapter_stopped = true;
@@ -3022,9 +3016,6 @@ ixgbe_dev_close(struct rte_eth_dev *dev)
 	/* uninitialize PF if max_vfs not zero */
 	ixgbe_pf_host_uninit(dev);
 
-	/* remove all the fdir filters & hash */
-	ixgbe_fdir_filter_uninit(dev);
-
 	/* clear all the filters list */
 	ixgbe_filterlist_flush(dev);
 
@@ -7847,7 +7838,6 @@ ixgbe_rss_filter_restore(struct rte_eth_dev *dev)
 static int
 ixgbe_filter_restore(struct rte_eth_dev *dev)
 {
-	ixgbe_fdir_filter_restore(dev);
 	ixgbe_rss_filter_restore(dev);
 
 	return 0;
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index 798623e0068..06edca96698 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -23,6 +23,7 @@
 #include <rte_tm_driver.h>
 
 #include "../common/flow_engine.h"
+#include "../common/flow_util.h"
 
 /* need update link, bit flag */
 #define IXGBE_FLAG_NEED_LINK_UPDATE (uint32_t)(1 << 0)
@@ -51,6 +52,7 @@
 #define IXGBE_VMDQ_DCB_NB_QUEUES     IXGBE_MAX_RX_QUEUE_NUM
 #define IXGBE_DCB_NB_QUEUES          IXGBE_MAX_RX_QUEUE_NUM
 #define IXGBE_NONE_MODE_TX_NB_QUEUES 64
+#define IXGBE_MAX_FLX_SOURCE_OFF 62
 
 #ifndef NBBY
 #define NBBY	8	/* number of bits in a byte */
@@ -161,17 +163,6 @@ struct ixgbe_hw_fdir_mask {
 	uint8_t  tunnel_type_mask;
 };
 
-struct ixgbe_fdir_filter {
-	TAILQ_ENTRY(ixgbe_fdir_filter) entries;
-	union ixgbe_atr_input ixgbe_fdir; /* key of fdir filter*/
-	uint32_t fdirflags; /* drop or forward */
-	uint32_t fdirhash; /* hash value for fdir */
-	uint8_t queue; /* assigned rx queue */
-};
-
-/* list of fdir filters */
-TAILQ_HEAD(ixgbe_fdir_filter_list, ixgbe_fdir_filter);
-
 struct ixgbe_fdir_rule {
 	struct ixgbe_hw_fdir_mask mask;
 	union ixgbe_atr_input ixgbe_fdir; /* key of fdir filter*/
@@ -184,23 +175,38 @@ struct ixgbe_fdir_rule {
 	uint8_t flex_bytes_offset;
 };
 
-struct ixgbe_hw_fdir_info {
-	struct ixgbe_hw_fdir_mask mask;
-	uint8_t     flex_bytes_offset;
-	uint16_t    collision;
-	uint16_t    free;
-	uint16_t    maxhash;
-	uint8_t     maxlen;
+struct ixgbe_fdir_stats {
 	uint64_t    add;
 	uint64_t    remove;
 	uint64_t    f_add;
 	uint64_t    f_remove;
-	struct ixgbe_fdir_filter_list fdir_list; /* filter list*/
-	/* store the pointers of the filters, index is the hash value. */
-	struct ixgbe_fdir_filter **hash_map;
-	struct rte_hash *hash_handle; /* cuckoo hash handler */
-	uint32_t n_flows;
-	bool mask_added; /* If already got mask from consistent filter */
+};
+
+struct ixgbe_fdir_hw_config {
+	enum rte_eth_fdir_pballoc_type pballoc;
+	enum rte_fdir_status_mode status;
+};
+
+/* track global fdir mode configuration and rule counts */
+struct ixgbe_fdir_config_state {
+	ci_usage_count_t rule_count;
+	enum rte_fdir_mode mode;
+	bool hw_configured;
+};
+
+/* track fdir mask and flex state */
+struct ixgbe_fdir_mask_state {
+	struct ixgbe_hw_fdir_mask mask;
+	uint8_t flex_bytes_offset;
+	bool mask_configured;
+};
+
+/* track overall fdir state */
+struct ixgbe_fdir_state {
+	ci_usage_count_t engine_use_count;
+	struct rte_hash *hash_handle;
+	struct ixgbe_fdir_config_state config;
+	struct ixgbe_fdir_mask_state mask_conf;
 };
 
 struct ixgbe_rte_flow_rss_conf {
@@ -432,8 +438,9 @@ struct ixgbe_adapter {
 	struct ixgbe_hw_stats       stats;
 	struct ixgbe_macsec_stats   macsec_stats;
 	struct ixgbe_macsec_setting	macsec_setting;
-	struct rte_eth_fdir_conf    fdir_conf;
-	struct ixgbe_hw_fdir_info   fdir;
+	struct ixgbe_fdir_hw_config fdir_hw_config;
+	struct ixgbe_fdir_stats     fdir_stats;
+	struct ixgbe_fdir_state     fdir_state;
 	struct ixgbe_interrupt      intr;
 	struct ixgbe_vfta           shadow_vfta;
 	struct ixgbe_hwstrip		hwstrip;
@@ -484,14 +491,11 @@ int ixgbe_vf_representor_uninit(struct rte_eth_dev *ethdev);
 uint16_t ixgbe_vf_representor_rx_burst(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts);
 uint16_t ixgbe_vf_representor_tx_burst(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts);
 
-#define IXGBE_DEV_FDIR_CONF(dev) \
-	(&((struct ixgbe_adapter *)(dev)->data->dev_private)->fdir_conf)
-
 #define IXGBE_DEV_PRIVATE_TO_ADAPTER(adapter) \
 	((struct ixgbe_adapter *)adapter)
 
-#define IXGBE_DEV_PRIVATE_TO_FDIR_CONF(adapter) \
-	(&(adapter)->fdir_conf)
+#define IXGBE_DEV_PRIVATE_TO_FDIR_HW_CONFIG(adapter) \
+	(&(adapter)->fdir_hw_config)
 
 #define IXGBE_DEV_PRIVATE_TO_HW(adapter)\
 	(&((struct ixgbe_adapter *)adapter)->hw)
@@ -508,8 +512,8 @@ uint16_t ixgbe_vf_representor_tx_burst(void *tx_queue, struct rte_mbuf **tx_pkts
 #define IXGBE_DEV_PRIVATE_TO_INTR(adapter) \
 	(&((struct ixgbe_adapter *)adapter)->intr)
 
-#define IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter) \
-	(&((struct ixgbe_adapter *)adapter)->fdir)
+#define IXGBE_DEV_PRIVATE_TO_FDIR_STATS(adapter) \
+	(&((struct ixgbe_adapter *)adapter)->fdir_stats)
 
 #define IXGBE_DEV_PRIVATE_TO_VFTA(adapter) \
 	(&((struct ixgbe_adapter *)adapter)->shadow_vfta)
@@ -668,18 +672,27 @@ void ixgbe_filterlist_flush(struct rte_eth_dev *dev);
 /*
  * Flow director function prototypes
  */
-int ixgbe_fdir_configure(struct rte_eth_dev *dev,
-			 const struct rte_eth_fdir_conf *fdir_conf,
-			 const struct ixgbe_hw_fdir_mask *fdir_mask);
-int ixgbe_fdir_set_input_mask(struct ixgbe_adapter *adapter,
-			      const struct ixgbe_hw_fdir_mask *mask,
-			      enum rte_fdir_mode mode);
-int ixgbe_fdir_set_flexbytes_offset(struct ixgbe_adapter *adapter,
-				    uint16_t offset);
+int ixgbe_fdir_hw_configure(struct rte_eth_dev_data *dev_data,
+		const struct ixgbe_fdir_hw_config *config,
+		enum rte_fdir_mode mode);
+int ixgbe_fdir_mask_program(struct ixgbe_adapter *adapter,
+		const struct ixgbe_hw_fdir_mask *mask,
+		uint8_t flex_bytes_offset,
+		enum rte_fdir_mode mode);
+struct ixgbe_fdir_state *ixgbe_fdir_state_attach(struct rte_eth_dev_data *dev_data);
+void ixgbe_fdir_state_detach(struct ixgbe_fdir_state *state);
+void ixgbe_fdir_hw_invalidate(struct rte_eth_dev *dev);
+void ixgbe_fdir_mask_set_default(struct ixgbe_hw_fdir_mask *mask);
+bool ixgbe_fdir_mode_is_perfect(enum rte_fdir_mode mode);
+uint32_t ixgbe_fdir_compute_hash(struct ixgbe_adapter *adapter,
+				 struct ixgbe_fdir_rule *rule);
 int ixgbe_fdir_filter_program(struct ixgbe_adapter *adapter,
-		struct rte_eth_fdir_conf *fdir_conf,
 		struct ixgbe_fdir_rule *rule,
-		bool del, bool update);
+		uint8_t queue,
+		uint32_t fdircmd_flags,
+		uint32_t fdirhash);
+int ixgbe_fdir_filter_clear(struct ixgbe_adapter *adapter, uint32_t fdirhash);
+int ixgbe_fdir_hw_disable(struct ixgbe_adapter *adapter);
 void ixgbe_fdir_info_get(struct rte_eth_dev *dev,
 			 struct rte_eth_fdir_info *fdir_info);
 void ixgbe_fdir_stats_get(struct rte_eth_dev *dev,
@@ -710,9 +723,6 @@ int ixgbe_pf_host_configure(struct rte_eth_dev *eth_dev);
 
 uint32_t ixgbe_convert_vm_rx_mask_to_val(uint16_t rx_mask, uint32_t orig_val);
 
-void ixgbe_fdir_filter_restore(struct rte_eth_dev *dev);
-int ixgbe_clear_all_fdir_filter(struct rte_eth_dev *dev);
-
 extern const struct rte_flow_ops ixgbe_flow_ops;
 
 int ixgbe_disable_sec_tx_path_generic(struct ixgbe_hw *hw);
diff --git a/drivers/net/intel/ixgbe/ixgbe_fdir.c b/drivers/net/intel/ixgbe/ixgbe_fdir.c
index 0159c5b3b71..74715188579 100644
--- a/drivers/net/intel/ixgbe/ixgbe_fdir.c
+++ b/drivers/net/intel/ixgbe/ixgbe_fdir.c
@@ -6,6 +6,7 @@
 #include <stdint.h>
 #include <stdarg.h>
 #include <errno.h>
+#include <string.h>
 #include <sys/queue.h>
 
 #include <rte_interrupts.h>
@@ -36,7 +37,6 @@
 #define SIG_BUCKET_256KB_HASH_MASK      0x7FFF  /* 15 bits */
 #define IXGBE_DEFAULT_FLEXBYTES_OFFSET  12 /* default flexbytes offset in bytes */
 #define IXGBE_FDIR_MAX_FLEX_LEN         2 /* len in bytes of flexbytes */
-#define IXGBE_MAX_FLX_SOURCE_OFF        62
 #define IXGBE_FDIRCTRL_FLEX_MASK        (0x1F << IXGBE_FDIRCTRL_FLEX_SHIFT)
 #define IXGBE_FDIRCMD_CMD_INTERVAL_US   10
 
@@ -78,6 +78,8 @@
 
 #define IXGBE_FDIRIP6M_INNER_MAC_SHIFT 4
 
+#define FDIRENTRIES_NUM_SHIFT 10
+
 static int fdir_erase_filter_82599(struct ixgbe_hw *hw, uint32_t fdirhash);
 static int fdir_set_input_mask_82599(struct ixgbe_adapter *adapter,
 		const struct ixgbe_hw_fdir_mask *mask,
@@ -85,8 +87,6 @@ static int fdir_set_input_mask_82599(struct ixgbe_adapter *adapter,
 static int fdir_set_input_mask_x550(struct ixgbe_adapter *adapter,
 		const struct ixgbe_hw_fdir_mask *mask,
 		enum rte_fdir_mode mode);
-static int ixgbe_set_fdir_flex_conf(struct ixgbe_adapter *adapter,
-		const struct rte_eth_fdir_flex_conf *conf, uint32_t *fdirctrl);
 static int fdir_enable_82599(struct ixgbe_hw *hw, uint32_t fdirctrl);
 static uint32_t ixgbe_atr_compute_hash_82599(union ixgbe_atr_input *atr_input,
 				 uint32_t key);
@@ -101,7 +101,40 @@ static int fdir_write_perfect_filter_82599(struct ixgbe_hw *hw,
 static int fdir_add_signature_filter_82599(struct ixgbe_hw *hw,
 		union ixgbe_atr_input *input, u8 queue, uint32_t fdircmd,
 		uint32_t fdirhash);
-static int ixgbe_fdir_flush(struct rte_eth_dev *dev);
+
+static uint32_t
+ixgbe_fdir_pballoc_to_fdirctrl(enum rte_eth_fdir_pballoc_type pballoc)
+{
+	switch (pballoc) {
+	case RTE_ETH_FDIR_PBALLOC_64K:
+		return IXGBE_FDIRCTRL_PBALLOC_64K;
+	case RTE_ETH_FDIR_PBALLOC_128K:
+		return IXGBE_FDIRCTRL_PBALLOC_128K;
+	case RTE_ETH_FDIR_PBALLOC_256K:
+		return IXGBE_FDIRCTRL_PBALLOC_256K;
+	default:
+		return 0;
+	}
+}
+
+static uint32_t
+ixgbe_fdir_pballoc_to_bytes(enum rte_eth_fdir_pballoc_type pballoc)
+{
+	uint32_t pballoc_val = ixgbe_fdir_pballoc_to_fdirctrl(pballoc);
+
+	return pballoc_val == 0 ? 0 : 1U << (PBALLOC_SIZE_SHIFT + pballoc_val);
+}
+
+static uint32_t
+ixgbe_fdir_max_entries(enum rte_eth_fdir_pballoc_type pballoc)
+{
+	uint32_t pballoc_val = ixgbe_fdir_pballoc_to_fdirctrl(pballoc);
+
+	if (pballoc_val == 0)
+		return 0;
+
+	return 1 << (FDIRENTRIES_NUM_SHIFT + pballoc_val);
+}
 
 /**
  * This function is based on ixgbe_fdir_enable_82599() in base/ixgbe_82599.c.
@@ -164,28 +197,20 @@ fdir_enable_82599(struct ixgbe_hw *hw, uint32_t fdirctrl)
  * flexbytes matching field, and drop queue (only for perfect matching mode).
  */
 static inline int
-configure_fdir_flags(const struct rte_eth_fdir_conf *conf, uint32_t *fdirctrl)
+configure_fdir_flags(const struct ixgbe_fdir_hw_config *conf,
+		enum rte_fdir_mode mode, uint32_t *fdirctrl)
 {
+	uint32_t pballoc;
+
 	*fdirctrl = 0;
 
-	switch (conf->pballoc) {
-	case RTE_ETH_FDIR_PBALLOC_64K:
-		/* 8k - 1 signature filters */
-		*fdirctrl |= IXGBE_FDIRCTRL_PBALLOC_64K;
-		break;
-	case RTE_ETH_FDIR_PBALLOC_128K:
-		/* 16k - 1 signature filters */
-		*fdirctrl |= IXGBE_FDIRCTRL_PBALLOC_128K;
-		break;
-	case RTE_ETH_FDIR_PBALLOC_256K:
-		/* 32k - 1 signature filters */
-		*fdirctrl |= IXGBE_FDIRCTRL_PBALLOC_256K;
-		break;
-	default:
+	pballoc = ixgbe_fdir_pballoc_to_fdirctrl(conf->pballoc);
+	if (pballoc == 0) {
 		/* bad value */
 		PMD_INIT_LOG(ERR, "Invalid fdir_conf->pballoc value");
 		return -EINVAL;
-	};
+	}
+	*fdirctrl |= pballoc;
 
 	/* status flags: write hash & swindex in the rx descriptor */
 	switch (conf->status) {
@@ -209,14 +234,14 @@ configure_fdir_flags(const struct rte_eth_fdir_conf *conf, uint32_t *fdirctrl)
 	*fdirctrl |= (IXGBE_DEFAULT_FLEXBYTES_OFFSET / sizeof(uint16_t)) <<
 		     IXGBE_FDIRCTRL_FLEX_SHIFT;
 
-	if (conf->mode >= RTE_FDIR_MODE_PERFECT &&
-	    conf->mode <= RTE_FDIR_MODE_PERFECT_TUNNEL) {
+	if (mode >= RTE_FDIR_MODE_PERFECT &&
+	    mode <= RTE_FDIR_MODE_PERFECT_TUNNEL) {
 		*fdirctrl |= IXGBE_FDIRCTRL_PERFECT_MATCH;
-		*fdirctrl |= (conf->drop_queue << IXGBE_FDIRCTRL_DROP_Q_SHIFT);
-		if (conf->mode == RTE_FDIR_MODE_PERFECT_MAC_VLAN)
+		*fdirctrl |= (IXGBE_FDIR_DROP_QUEUE << IXGBE_FDIRCTRL_DROP_Q_SHIFT);
+		if (mode == RTE_FDIR_MODE_PERFECT_MAC_VLAN)
 			*fdirctrl |= (IXGBE_FDIRCTRL_FILTERMODE_MACVLAN
 					<< IXGBE_FDIRCTRL_FILTERMODE_SHIFT);
-		else if (conf->mode == RTE_FDIR_MODE_PERFECT_TUNNEL)
+		else if (mode == RTE_FDIR_MODE_PERFECT_TUNNEL)
 			*fdirctrl |= (IXGBE_FDIRCTRL_FILTERMODE_CLOUD
 					<< IXGBE_FDIRCTRL_FILTERMODE_SHIFT);
 	}
@@ -257,10 +282,7 @@ fdir_set_input_mask_82599(struct ixgbe_adapter *adapter,
 		enum rte_fdir_mode mode)
 {
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
-	/*
-	 * mask VM pool and DIPv6 since there are currently not supported
-	 * mask FLEX byte, it will be set in flex_conf
-	 */
+	/* Mask VM pool and destination IPv6 since they are not supported. */
 	uint32_t fdirm = IXGBE_FDIRM_POOL | IXGBE_FDIRM_DIPv6;
 	uint32_t fdirtcpm;  /* TCP source and destination port masks. */
 	uint32_t fdiripv6m; /* IPv6 source and destination masks. */
@@ -340,11 +362,8 @@ fdir_set_input_mask_x550(struct ixgbe_adapter *adapter,
 		enum rte_fdir_mode mode)
 {
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
-	/* mask VM pool and DIPv6 since there are currently not supported
-	 * mask FLEX byte, it will be set in flex_conf
-	 */
-	uint32_t fdirm = IXGBE_FDIRM_POOL | IXGBE_FDIRM_DIPv6 |
-			 IXGBE_FDIRM_FLEX;
+	/* Mask VM pool and destination IPv6 since they are not supported. */
+	uint32_t fdirm = IXGBE_FDIRM_POOL | IXGBE_FDIRM_DIPv6;
 	uint32_t fdiripv6m;
 	uint16_t mac_mask;
 
@@ -357,6 +376,10 @@ fdir_set_input_mask_x550(struct ixgbe_adapter *adapter,
 	/* some bits must be set for mac vlan or tunnel mode */
 	fdirm |= IXGBE_FDIRM_L4P | IXGBE_FDIRM_L3P;
 
+	/* flex byte mask */
+	if (mask->flex_bytes_mask == 0)
+		fdirm |= IXGBE_FDIRM_FLEX;
+
 	if (mask->vlan_tci_mask == rte_cpu_to_be_16(0x0FFF))
 		/* mask VLAN Priority */
 		fdirm |= IXGBE_FDIRM_VLANP;
@@ -425,8 +448,8 @@ fdir_set_input_mask_x550(struct ixgbe_adapter *adapter,
 	return IXGBE_SUCCESS;
 }
 
-int
-ixgbe_fdir_set_input_mask(struct ixgbe_adapter *adapter,
+static int
+fdir_set_input_mask(struct ixgbe_adapter *adapter,
 		const struct ixgbe_hw_fdir_mask *mask,
 		enum rte_fdir_mode mode)
 {
@@ -441,8 +464,8 @@ ixgbe_fdir_set_input_mask(struct ixgbe_adapter *adapter,
 	return -ENOTSUP;
 }
 
-int
-ixgbe_fdir_set_flexbytes_offset(struct ixgbe_adapter *adapter, uint16_t offset)
+static int
+fdir_set_flexbytes_offset(struct ixgbe_adapter *adapter, uint16_t offset)
 {
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
 	uint32_t fdirctrl;
@@ -487,88 +510,36 @@ ixgbe_fdir_set_flexbytes_offset(struct ixgbe_adapter *adapter, uint16_t offset)
 	return 0;
 }
 
-/*
- * ixgbe_check_fdir_flex_conf -check if the flex payload and mask configuration
- * arguments are valid
- */
-static int
-ixgbe_set_fdir_flex_conf(struct ixgbe_adapter *adapter,
-		const struct rte_eth_fdir_flex_conf *conf, uint32_t *fdirctrl)
+int
+ixgbe_fdir_mask_program(struct ixgbe_adapter *adapter,
+		const struct ixgbe_hw_fdir_mask *mask,
+		uint8_t flex_bytes_offset,
+		enum rte_fdir_mode mode)
 {
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
-	struct ixgbe_hw_fdir_info *info =
-			IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter);
-	const struct rte_eth_flex_payload_cfg *flex_cfg;
-	const struct rte_eth_fdir_flex_mask *flex_mask;
-	uint32_t fdirm;
-	uint16_t flexbytes = 0;
-	uint16_t i;
+	int ret;
 
-	fdirm = IXGBE_READ_REG(hw, IXGBE_FDIRM);
-
-	if (conf == NULL) {
-		PMD_DRV_LOG(ERR, "NULL pointer.");
-		return -EINVAL;
-	}
-
-	for (i = 0; i < conf->nb_payloads; i++) {
-		flex_cfg = &conf->flex_set[i];
-		if (flex_cfg->type != RTE_ETH_RAW_PAYLOAD) {
-			PMD_DRV_LOG(ERR, "unsupported payload type.");
-			return -EINVAL;
-		}
-		if (((flex_cfg->src_offset[0] & 0x1) == 0) &&
-		    (flex_cfg->src_offset[1] == flex_cfg->src_offset[0] + 1) &&
-		    (flex_cfg->src_offset[0] <= IXGBE_MAX_FLX_SOURCE_OFF)) {
-			*fdirctrl &= ~IXGBE_FDIRCTRL_FLEX_MASK;
-			*fdirctrl |=
-				(flex_cfg->src_offset[0] / sizeof(uint16_t)) <<
-					IXGBE_FDIRCTRL_FLEX_SHIFT;
-		} else {
-			PMD_DRV_LOG(ERR, "invalid flexbytes arguments.");
-			return -EINVAL;
-		}
+	if (mask->flex_bytes_mask != 0) {
+		ret = fdir_set_flexbytes_offset(adapter, flex_bytes_offset);
+		if (ret != 0)
+			return ret;
 	}
 
-	for (i = 0; i < conf->nb_flexmasks; i++) {
-		flex_mask = &conf->flex_mask[i];
-		if (flex_mask->flow_type != RTE_ETH_FLOW_UNKNOWN) {
-			PMD_DRV_LOG(ERR, "flexmask should be set globally.");
-			return -EINVAL;
-		}
-		flexbytes = (uint16_t)(((flex_mask->mask[0] << 8) & 0xFF00) |
-					((flex_mask->mask[1]) & 0xFF));
-		if (flexbytes == UINT16_MAX)
-			fdirm &= ~IXGBE_FDIRM_FLEX;
-		else if (flexbytes != 0) {
-			/* IXGBE_FDIRM_FLEX is set by default when set mask */
-			PMD_DRV_LOG(ERR, " invalid flexbytes mask arguments.");
-			return -EINVAL;
-		}
-	}
-	IXGBE_WRITE_REG(hw, IXGBE_FDIRM, fdirm);
-	info->mask.flex_bytes_mask = flexbytes ? UINT16_MAX : 0;
-	info->flex_bytes_offset = (uint8_t)((*fdirctrl &
-					    IXGBE_FDIRCTRL_FLEX_MASK) >>
-					    IXGBE_FDIRCTRL_FLEX_SHIFT);
-	return 0;
+	return fdir_set_input_mask(adapter, mask, mode);
 }
-
 int
-ixgbe_fdir_configure(struct rte_eth_dev *dev,
-		const struct rte_eth_fdir_conf *fdir_conf,
-		const struct ixgbe_hw_fdir_mask *fdir_mask)
+ixgbe_fdir_hw_configure(struct rte_eth_dev_data *dev_data,
+		const struct ixgbe_fdir_hw_config *fdir_conf,
+		enum rte_fdir_mode mode)
 {
-	struct ixgbe_adapter *adapter = dev->data->dev_private;
+	struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev_data->dev_private);
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
 	int err;
-	uint32_t fdirctrl, pbsize;
+	uint32_t fdirctrl, fdir_size, rx_buffer_size;
 	int i;
-	enum rte_fdir_mode mode = fdir_conf->mode;
 
 	PMD_INIT_FUNC_TRACE();
 
-	switch (dev->data->dev_conf.rxmode.mq_mode) {
+	switch (dev_data->dev_conf.rxmode.mq_mode) {
 	case RTE_ETH_MQ_RX_VMDQ_DCB:
 	case RTE_ETH_MQ_RX_DCB:
 	case RTE_ETH_MQ_RX_DCB_RSS:
@@ -578,35 +549,22 @@ ixgbe_fdir_configure(struct rte_eth_dev *dev,
 		break;
 	}
 
-	if (hw->mac.type != ixgbe_mac_82599EB &&
-		hw->mac.type != ixgbe_mac_X540 &&
-		hw->mac.type != ixgbe_mac_X550 &&
-		hw->mac.type != ixgbe_mac_X550EM_x &&
-		hw->mac.type != ixgbe_mac_X550EM_a &&
-		hw->mac.type != ixgbe_mac_E610)
-		return -ENOSYS;
-
-	/* x550 and E610 supports mac-vlan and tunnel mode but other NICs not */
-	if (hw->mac.type != ixgbe_mac_X550 &&
-	    hw->mac.type != ixgbe_mac_X550EM_x &&
-	    hw->mac.type != ixgbe_mac_X550EM_a &&
-	    hw->mac.type != ixgbe_mac_E610 &&
-	    mode != RTE_FDIR_MODE_SIGNATURE &&
-	    mode != RTE_FDIR_MODE_PERFECT)
-		return -ENOSYS;
-
-	err = configure_fdir_flags(fdir_conf, &fdirctrl);
+	err = configure_fdir_flags(fdir_conf, mode, &fdirctrl);
 	if (err)
 		return err;
 
 	/*
-	 * Before enabling Flow Director, the Rx Packet Buffer size
-	 * must be reduced.  The new value is the current size minus
-	 * flow director memory usage size.
+	 * Before enabling Flow Director, the Rx Packet Buffer size must be
+	 * reduced. The new value is the default size minus flow director
+	 * memory usage size.
 	 */
-	pbsize = (1 << (PBALLOC_SIZE_SHIFT + (fdirctrl & FDIRCTRL_PBALLOC_MASK)));
-	IXGBE_WRITE_REG(hw, IXGBE_RXPBSIZE(0),
-	    (IXGBE_READ_REG(hw, IXGBE_RXPBSIZE(0)) - pbsize));
+
+	/* default is in KiB so shift the value to get bytes */
+	rx_buffer_size = (uint32_t)hw->mac.rx_pb_size << IXGBE_RXPBSIZE_SHIFT;
+
+	fdir_size = ixgbe_fdir_pballoc_to_bytes(fdir_conf->pballoc);
+	rx_buffer_size -= fdir_size;
+	IXGBE_WRITE_REG(hw, IXGBE_RXPBSIZE(0), rx_buffer_size);
 
 	/*
 	 * The defaults in the HW for RX PB 1-7 are not zero and so should be
@@ -617,18 +575,6 @@ ixgbe_fdir_configure(struct rte_eth_dev *dev,
 	for (i = 1; i < 8; i++)
 		IXGBE_WRITE_REG(hw, IXGBE_RXPBSIZE(i), 0);
 
-	err = ixgbe_fdir_set_input_mask(adapter, fdir_mask, mode);
-	if (err < 0) {
-		PMD_INIT_LOG(ERR, " Error on setting FD mask");
-		return err;
-	}
-	err = ixgbe_set_fdir_flex_conf(adapter, &fdir_conf->flex_conf,
-				       &fdirctrl);
-	if (err < 0) {
-		PMD_INIT_LOG(ERR, " Error on setting FD flexible arguments.");
-		return err;
-	}
-
 	err = fdir_enable_82599(hw, fdirctrl);
 	if (err < 0) {
 		PMD_INIT_LOG(ERR, " Error on enabling FD.");
@@ -985,219 +931,97 @@ fdir_erase_filter_82599(struct ixgbe_hw *hw, uint32_t fdirhash)
 
 }
 
-static inline struct ixgbe_fdir_filter *
-ixgbe_fdir_filter_lookup(struct ixgbe_hw_fdir_info *fdir_info,
-			 union ixgbe_atr_input *key)
+void
+ixgbe_fdir_mask_set_default(struct ixgbe_hw_fdir_mask *mask)
 {
-	int ret;
-
-	ret = rte_hash_lookup(fdir_info->hash_handle, (const void *)key);
-	if (ret < 0)
-		return NULL;
-
-	return fdir_info->hash_map[ret];
+	/*
+	 * Default mask value 0xFF means ignore all fields.
+	 */
+	memset(mask, 0xFF, sizeof(*mask));
+	mask->vlan_tci_mask = 0;
+	mask->flex_bytes_mask = 0;
+	mask->dst_port_mask = 0;
+	mask->src_port_mask = 0;
+	mask->l4_proto_match = 0;
 }
 
-static inline int
-ixgbe_insert_fdir_filter(struct ixgbe_hw_fdir_info *fdir_info,
-			 struct ixgbe_fdir_filter *fdir_filter)
+/* hardware loses its flow director setup across a stop/start cycle */
+void
+ixgbe_fdir_hw_invalidate(struct rte_eth_dev *dev)
 {
-	int ret;
-
-	ret = rte_hash_add_key(fdir_info->hash_handle,
-			       &fdir_filter->ixgbe_fdir);
-
-	if (ret < 0) {
-		PMD_DRV_LOG(ERR,
-			    "Failed to insert fdir filter to hash table %d!",
-			    ret);
-		return ret;
-	}
-
-	fdir_info->hash_map[ret] = fdir_filter;
+	struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
+	struct ixgbe_fdir_state *state = &adapter->fdir_state;
 
-	TAILQ_INSERT_TAIL(&fdir_info->fdir_list, fdir_filter, entries);
-
-	return 0;
+	state->config.hw_configured = false;
+	state->mask_conf.mask_configured = false;
 }
 
-static inline int
-ixgbe_remove_fdir_filter(struct ixgbe_hw_fdir_info *fdir_info,
-			 union ixgbe_atr_input *key)
+bool
+ixgbe_fdir_mode_is_perfect(enum rte_fdir_mode mode)
 {
-	int ret;
-	struct ixgbe_fdir_filter *fdir_filter;
-
-	ret = rte_hash_del_key(fdir_info->hash_handle, key);
+	return mode >= RTE_FDIR_MODE_PERFECT && mode <= RTE_FDIR_MODE_PERFECT_TUNNEL;
+}
 
-	if (ret < 0) {
-		PMD_DRV_LOG(ERR, "No such fdir filter to delete %d!", ret);
-		return ret;
-	}
+uint32_t
+ixgbe_fdir_compute_hash(struct ixgbe_adapter *adapter, struct ixgbe_fdir_rule *rule)
+{
+	const struct ixgbe_fdir_hw_config *fdir_conf =
+			IXGBE_DEV_PRIVATE_TO_FDIR_HW_CONFIG(adapter);
+	uint32_t fdirhash;
 
-	fdir_filter = fdir_info->hash_map[ret];
-	fdir_info->hash_map[ret] = NULL;
+	if (!ixgbe_fdir_mode_is_perfect(rule->mode))
+		return atr_compute_sig_hash_82599(&rule->ixgbe_fdir, fdir_conf->pballoc);
 
-	TAILQ_REMOVE(&fdir_info->fdir_list, fdir_filter, entries);
-	rte_free(fdir_filter);
+	fdirhash = atr_compute_perfect_hash_82599(&rule->ixgbe_fdir, fdir_conf->pballoc);
+	fdirhash |= rule->soft_id << IXGBE_FDIRHASH_SIG_SW_INDEX_SHIFT;
 
-	return 0;
+	return fdirhash;
 }
 
 int
 ixgbe_fdir_filter_program(struct ixgbe_adapter *adapter,
-		struct rte_eth_fdir_conf *fdir_conf,
 		struct ixgbe_fdir_rule *rule,
-		bool del,
-		bool update)
+		uint8_t queue,
+		uint32_t fdircmd_flags,
+		uint32_t fdirhash)
 {
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
-	uint32_t fdircmd_flags;
-	uint32_t fdirhash;
-	uint8_t queue;
-	bool is_perfect = FALSE;
 	int err;
-	struct ixgbe_hw_fdir_info *info =
-		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter);
-	enum rte_fdir_mode fdir_mode = fdir_conf->mode;
-	struct ixgbe_fdir_filter *node;
-	bool add_node = FALSE;
 
-	if (fdir_mode == RTE_FDIR_MODE_NONE ||
-	    fdir_mode != rule->mode)
-		return -ENOTSUP;
-
-	/*
-	 * Sanity check for x550 and E610.
-	 * When adding a new filter with flow type set to IPv4,
-	 * the flow director mask should be configed before,
-	 * and the L4 protocol and ports are masked.
-	 */
-	if ((!del) &&
-	    (hw->mac.type == ixgbe_mac_X550 ||
-	     hw->mac.type == ixgbe_mac_X550EM_x ||
-	     hw->mac.type == ixgbe_mac_X550EM_a ||
-	     hw->mac.type == ixgbe_mac_E610) &&
-	    (rule->ixgbe_fdir.formatted.flow_type ==
-	     IXGBE_ATR_FLOW_TYPE_IPV4 ||
-	     rule->ixgbe_fdir.formatted.flow_type ==
-	     IXGBE_ATR_FLOW_TYPE_IPV6) &&
-	    (info->mask.src_port_mask != 0 ||
-	     info->mask.dst_port_mask != 0) &&
-	    (rule->mode != RTE_FDIR_MODE_PERFECT_MAC_VLAN &&
-	     rule->mode != RTE_FDIR_MODE_PERFECT_TUNNEL)) {
-		PMD_DRV_LOG(ERR, "By this device,"
-			    " IPv4 is not supported without"
-			    " L4 protocol and ports masked!");
-		return -ENOTSUP;
-	}
-
-	if (fdir_mode >= RTE_FDIR_MODE_PERFECT &&
-	    fdir_mode <= RTE_FDIR_MODE_PERFECT_TUNNEL)
-		is_perfect = TRUE;
-
-	if (is_perfect) {
-		if (rule->ixgbe_fdir.formatted.flow_type &
-		    IXGBE_ATR_L4TYPE_IPV6_MASK) {
-			PMD_DRV_LOG(ERR, "IPv6 is not supported in"
-				    " perfect mode!");
-			return -ENOTSUP;
-		}
-		fdirhash = atr_compute_perfect_hash_82599(&rule->ixgbe_fdir,
-				fdir_conf->pballoc);
-		fdirhash |= rule->soft_id <<
-			IXGBE_FDIRHASH_SIG_SW_INDEX_SHIFT;
-	} else
-		fdirhash = atr_compute_sig_hash_82599(&rule->ixgbe_fdir,
-				fdir_conf->pballoc);
-
-	if (del) {
-		err = ixgbe_remove_fdir_filter(info, &rule->ixgbe_fdir);
-		if (err < 0)
-			return err;
-
-		err = fdir_erase_filter_82599(hw, fdirhash);
-		if (err < 0)
-			PMD_DRV_LOG(ERR, "Fail to delete FDIR filter!");
-		else
-			PMD_DRV_LOG(DEBUG, "Success to delete FDIR filter!");
-		return err;
-	}
-	/* add or update an fdir filter*/
-	fdircmd_flags = (update) ? IXGBE_FDIRCMD_FILTER_UPDATE : 0;
-	if (rule->fdirflags & IXGBE_FDIRCMD_DROP) {
-		if (is_perfect) {
-			queue = fdir_conf->drop_queue;
-			fdircmd_flags |= IXGBE_FDIRCMD_DROP;
-		} else {
-			PMD_DRV_LOG(ERR, "Drop option is not supported in"
-				    " signature mode.");
-			return -EINVAL;
-		}
-	} else if (rule->queue < IXGBE_MAX_RX_QUEUE_NUM)
-		queue = (uint8_t)rule->queue;
+	if (ixgbe_fdir_mode_is_perfect(rule->mode))
+		err = fdir_write_perfect_filter_82599(hw, &rule->ixgbe_fdir, queue,
+				fdircmd_flags, fdirhash, rule->mode);
 	else
-		return -EINVAL;
+		err = fdir_add_signature_filter_82599(hw, &rule->ixgbe_fdir, queue,
+				fdircmd_flags, fdirhash);
 
-	node = ixgbe_fdir_filter_lookup(info, &rule->ixgbe_fdir);
-	if (node) {
-		if (update) {
-			node->fdirflags = fdircmd_flags;
-			node->fdirhash = fdirhash;
-			node->queue = queue;
-		} else {
-			PMD_DRV_LOG(ERR, "Conflict with existing fdir filter!");
-			return -EINVAL;
-		}
-	} else {
-		add_node = TRUE;
-		node = rte_zmalloc("ixgbe_fdir",
-				   sizeof(struct ixgbe_fdir_filter),
-				   0);
-		if (!node)
-			return -ENOMEM;
-		memcpy(&node->ixgbe_fdir,
-				 &rule->ixgbe_fdir,
-				 sizeof(union ixgbe_atr_input));
-		node->fdirflags = fdircmd_flags;
-		node->fdirhash = fdirhash;
-		node->queue = queue;
-
-		err = ixgbe_insert_fdir_filter(info, node);
-		if (err < 0) {
-			rte_free(node);
-			return err;
-		}
-	}
-
-	if (is_perfect) {
-		err = fdir_write_perfect_filter_82599(hw, &rule->ixgbe_fdir,
-						      queue, fdircmd_flags,
-						      fdirhash, fdir_mode);
-	} else {
-		err = fdir_add_signature_filter_82599(hw, &rule->ixgbe_fdir,
-						      queue, fdircmd_flags,
-						      fdirhash);
-	}
-	if (err < 0) {
+	if (err < 0)
 		PMD_DRV_LOG(ERR, "Fail to add FDIR filter!");
 
-		if (add_node)
-			(void)ixgbe_remove_fdir_filter(info, &rule->ixgbe_fdir);
-	} else {
-		PMD_DRV_LOG(DEBUG, "Success to add FDIR filter");
-	}
+	return err;
+}
+
+int
+ixgbe_fdir_filter_clear(struct ixgbe_adapter *adapter, uint32_t fdirhash)
+{
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
+	int err;
+
+	err = fdir_erase_filter_82599(hw, fdirhash);
+	if (err < 0)
+		PMD_DRV_LOG(ERR, "Fail to delete FDIR filter!");
 
 	return err;
 }
 
-static int
-ixgbe_fdir_flush(struct rte_eth_dev *dev)
+int
+ixgbe_fdir_hw_disable(struct ixgbe_adapter *adapter)
 {
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct ixgbe_hw_fdir_info *info =
-			IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
+	struct ixgbe_fdir_stats *info = IXGBE_DEV_PRIVATE_TO_FDIR_STATS(adapter);
+	uint32_t rx_buffer_size;
 	int ret;
+	int i;
 
 	ret = ixgbe_reinit_fdir_tables_82599(hw);
 	if (ret < 0) {
@@ -1210,27 +1034,33 @@ ixgbe_fdir_flush(struct rte_eth_dev *dev)
 	info->add = 0;
 	info->remove = 0;
 
-	return ret;
+	/* erase fdir control state */
+	IXGBE_WRITE_REG(hw, IXGBE_FDIRCTRL, 0);
+	IXGBE_WRITE_FLUSH(hw);
+
+	/* give the space reserved for FDIR filters back to the Rx buffer */
+	rx_buffer_size = (uint32_t)hw->mac.rx_pb_size << IXGBE_RXPBSIZE_SHIFT;
+	IXGBE_WRITE_REG(hw, IXGBE_RXPBSIZE(0), rx_buffer_size);
+	for (i = 1; i < 8; i++)
+		IXGBE_WRITE_REG(hw, IXGBE_RXPBSIZE(i), 0);
+	IXGBE_WRITE_FLUSH(hw);
+
+	return 0;
 }
 
-#define FDIRENTRIES_NUM_SHIFT 10
 void
 ixgbe_fdir_info_get(struct rte_eth_dev *dev, struct rte_eth_fdir_info *fdir_info)
 {
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
-	struct ixgbe_hw_fdir_info *info =
-			IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
-	uint32_t fdirctrl, max_num;
-	uint8_t offset;
-
-	fdirctrl = IXGBE_READ_REG(hw, IXGBE_FDIRCTRL);
-	offset = ((fdirctrl & IXGBE_FDIRCTRL_FLEX_MASK) >>
-			IXGBE_FDIRCTRL_FLEX_SHIFT) * sizeof(uint16_t);
+	struct ixgbe_adapter *adapter = dev->data->dev_private;
+	const struct ixgbe_fdir_hw_config *hw_config =
+			IXGBE_DEV_PRIVATE_TO_FDIR_HW_CONFIG(adapter);
+	const struct ixgbe_fdir_config_state *fdir_conf = &adapter->fdir_state.config;
+	const struct ixgbe_fdir_mask_state *info = &adapter->fdir_state.mask_conf;
+	uint32_t max_num;
+	uint8_t offset = info->flex_bytes_offset;
 
 	fdir_info->mode = fdir_conf->mode;
-	max_num = (1 << (FDIRENTRIES_NUM_SHIFT +
-			(fdirctrl & FDIRCTRL_PBALLOC_MASK)));
+	max_num = ixgbe_fdir_max_entries(hw_config->pballoc);
 	if (fdir_info->mode >= RTE_FDIR_MODE_PERFECT &&
 	    fdir_info->mode <= RTE_FDIR_MODE_PERFECT_TUNNEL)
 		fdir_info->guarant_spc = max_num;
@@ -1278,23 +1108,24 @@ void
 ixgbe_fdir_stats_get(struct rte_eth_dev *dev, struct rte_eth_fdir_stats *fdir_stats)
 {
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
-	struct ixgbe_hw_fdir_info *info =
-		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
+	struct ixgbe_adapter *adapter = dev->data->dev_private;
+	const struct ixgbe_fdir_hw_config *hw_config =
+			IXGBE_DEV_PRIVATE_TO_FDIR_HW_CONFIG(adapter);
+	struct ixgbe_fdir_stats *info = IXGBE_DEV_PRIVATE_TO_FDIR_STATS(adapter);
 	uint32_t reg, max_num;
-	enum rte_fdir_mode fdir_mode = fdir_conf->mode;
+	enum rte_fdir_mode fdir_mode = adapter->fdir_state.config.mode;
 
 	/* Get the information from registers */
 	reg = IXGBE_READ_REG(hw, IXGBE_FDIRFREE);
-	info->collision = (uint16_t)((reg & IXGBE_FDIRFREE_COLL_MASK) >>
+	fdir_stats->collision = (uint16_t)((reg & IXGBE_FDIRFREE_COLL_MASK) >>
 				     IXGBE_FDIRFREE_COLL_SHIFT);
-	info->free = (uint16_t)((reg & IXGBE_FDIRFREE_FREE_MASK) >>
+	fdir_stats->free = (uint16_t)((reg & IXGBE_FDIRFREE_FREE_MASK) >>
 				IXGBE_FDIRFREE_FREE_SHIFT);
 
 	reg = IXGBE_READ_REG(hw, IXGBE_FDIRLEN);
-	info->maxhash = (uint16_t)((reg & IXGBE_FDIRLEN_MAXHASH_MASK) >>
+	fdir_stats->maxhash = (uint16_t)((reg & IXGBE_FDIRLEN_MAXHASH_MASK) >>
 				   IXGBE_FDIRLEN_MAXHASH_SHIFT);
-	info->maxlen  = (uint8_t)((reg & IXGBE_FDIRLEN_MAXLEN_MASK) >>
+	fdir_stats->maxlen  = (uint8_t)((reg & IXGBE_FDIRLEN_MAXLEN_MASK) >>
 				  IXGBE_FDIRLEN_MAXLEN_SHIFT);
 
 	reg = IXGBE_READ_REG(hw, IXGBE_FDIRUSTAT);
@@ -1310,18 +1141,12 @@ ixgbe_fdir_stats_get(struct rte_eth_dev *dev, struct rte_eth_fdir_stats *fdir_st
 		IXGBE_FDIRFSTAT_FADD_SHIFT;
 
 	/*  Copy the new information in the fdir parameter */
-	fdir_stats->collision = info->collision;
-	fdir_stats->free = info->free;
-	fdir_stats->maxhash = info->maxhash;
-	fdir_stats->maxlen = info->maxlen;
 	fdir_stats->remove = info->remove;
 	fdir_stats->add = info->add;
 	fdir_stats->f_remove = info->f_remove;
 	fdir_stats->f_add = info->f_add;
 
-	reg = IXGBE_READ_REG(hw, IXGBE_FDIRCTRL);
-	max_num = (1 << (FDIRENTRIES_NUM_SHIFT +
-			 (reg & FDIRCTRL_PBALLOC_MASK)));
+	max_num = ixgbe_fdir_max_entries(hw_config->pballoc);
 	if (fdir_mode >= RTE_FDIR_MODE_PERFECT &&
 	    fdir_mode <= RTE_FDIR_MODE_PERFECT_TUNNEL)
 		fdir_stats->guarant_cnt = max_num - fdir_stats->free;
@@ -1329,76 +1154,3 @@ ixgbe_fdir_stats_get(struct rte_eth_dev *dev, struct rte_eth_fdir_stats *fdir_st
 		fdir_stats->guarant_cnt = max_num * 4 - fdir_stats->free;
 
 }
-
-/* restore flow director filter */
-void
-ixgbe_fdir_filter_restore(struct rte_eth_dev *dev)
-{
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
-	struct ixgbe_hw_fdir_info *fdir_info =
-		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
-	struct ixgbe_fdir_filter *node;
-	bool is_perfect = FALSE;
-	enum rte_fdir_mode fdir_mode = fdir_conf->mode;
-
-	if (fdir_mode >= RTE_FDIR_MODE_PERFECT &&
-	    fdir_mode <= RTE_FDIR_MODE_PERFECT_TUNNEL)
-		is_perfect = TRUE;
-
-	if (is_perfect) {
-		TAILQ_FOREACH(node, &fdir_info->fdir_list, entries) {
-			(void)fdir_write_perfect_filter_82599(hw,
-							      &node->ixgbe_fdir,
-							      node->queue,
-							      node->fdirflags,
-							      node->fdirhash,
-							      fdir_mode);
-		}
-	} else {
-		TAILQ_FOREACH(node, &fdir_info->fdir_list, entries) {
-			(void)fdir_add_signature_filter_82599(hw,
-							      &node->ixgbe_fdir,
-							      node->queue,
-							      node->fdirflags,
-							      node->fdirhash);
-		}
-	}
-}
-
-/* remove all the flow director filters */
-int
-ixgbe_clear_all_fdir_filter(struct rte_eth_dev *dev)
-{
-	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
-	struct ixgbe_hw_fdir_info *fdir_info =
-		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
-	struct ixgbe_fdir_filter *fdir_filter;
-	bool had_flows;
-	int ret = 0;
-
-	had_flows = (fdir_info->n_flows != 0);
-
-	/* flush flow director */
-	rte_hash_reset(fdir_info->hash_handle);
-	memset(fdir_info->hash_map, 0,
-	       sizeof(struct ixgbe_fdir_filter *) * IXGBE_MAX_FDIR_FILTER_NUM);
-	while ((fdir_filter = TAILQ_FIRST(&fdir_info->fdir_list))) {
-		TAILQ_REMOVE(&fdir_info->fdir_list,
-			     fdir_filter,
-			     entries);
-		rte_free(fdir_filter);
-	}
-	fdir_info->n_flows = 0;
-
-	/* reset internal FDIR state */
-	fdir_info->mask = (struct ixgbe_hw_fdir_mask){0};
-	fdir_info->flex_bytes_offset = 0;
-	fdir_info->mask_added = FALSE;
-	fdir_conf->mode = RTE_FDIR_MODE_NONE;
-
-	if (had_flows)
-		ret = ixgbe_fdir_flush(dev);
-
-	return ret;
-}
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 475f024df9e..98d0af6535c 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -50,17 +50,10 @@
 #include "../common/flow_engine.h"
 #include "ixgbe_flow.h"
 
-#define IXGBE_MAX_FLX_SOURCE_OFF 62
-
 struct ixgbe_filter_ele_base {
 	TAILQ_ENTRY(ixgbe_filter_ele_base) entries;
 };
 
-/* fdir filter list structure */
-struct ixgbe_fdir_rule_ele {
-	struct ixgbe_filter_ele_base base;
-	struct ixgbe_fdir_rule filter_info;
-};
 /* rss filter list structure */
 struct ixgbe_rss_conf_ele {
 	struct ixgbe_filter_ele_base base;
@@ -79,28 +72,10 @@ const struct ci_flow_engine_list ixgbe_flow_engine_list = {
 		&ixgbe_l2_tunnel_flow_engine,
 		&ixgbe_ntuple_flow_engine,
 		&ixgbe_security_flow_engine,
+		&ixgbe_fdir_flow_engine,
+		&ixgbe_fdir_tunnel_flow_engine,
 	},
 };
-
-/**
- * Endless loop will never happen with below assumption
- * 1. there is at least one no-void item(END)
- * 2. cur is before END.
- */
-static inline
-const struct rte_flow_item *next_no_void_pattern(
-		const struct rte_flow_item pattern[],
-		const struct rte_flow_item *cur)
-{
-	const struct rte_flow_item *next =
-		cur ? cur + 1 : &pattern[0];
-	while (1) {
-		if (next->type != RTE_FLOW_ITEM_TYPE_VOID)
-			return next;
-		next++;
-	}
-}
-
 /*
  * All ixgbe engines mostly check the same stuff, so use a common check.
  */
@@ -156,1495 +131,6 @@ ixgbe_flow_actions_check(const struct ci_flow_actions *actions,
  * normally the packets should use network order.
  */
 
-/* search next no void pattern and skip fuzzy */
-static inline
-const struct rte_flow_item *next_no_fuzzy_pattern(
-		const struct rte_flow_item pattern[],
-		const struct rte_flow_item *cur)
-{
-	const struct rte_flow_item *next =
-		next_no_void_pattern(pattern, cur);
-	while (1) {
-		if (next->type != RTE_FLOW_ITEM_TYPE_FUZZY)
-			return next;
-		next = next_no_void_pattern(pattern, next);
-	}
-}
-
-static inline uint8_t signature_match(const struct rte_flow_item pattern[])
-{
-	const struct rte_flow_item_fuzzy *spec, *last, *mask;
-	const struct rte_flow_item *item;
-	uint32_t sh, lh, mh;
-	int i = 0;
-
-	while (1) {
-		item = pattern + i;
-		if (item->type == RTE_FLOW_ITEM_TYPE_END)
-			break;
-
-		if (item->type == RTE_FLOW_ITEM_TYPE_FUZZY) {
-			spec = item->spec;
-			last = item->last;
-			mask = item->mask;
-
-			if (!spec || !mask)
-				return 0;
-
-			sh = spec->thresh;
-
-			if (!last)
-				lh = sh;
-			else
-				lh = last->thresh;
-
-			mh = mask->thresh;
-			sh = sh & mh;
-			lh = lh & mh;
-
-			if (!sh || sh > lh)
-				return 0;
-
-			return 1;
-		}
-
-		i++;
-	}
-
-	return 0;
-}
-
-/**
- * Parse the rule to see if it is a IP or MAC VLAN flow director rule.
- * And get the flow director filter info BTW.
- * UDP/TCP/SCTP PATTERN:
- * The first not void item can be ETH or IPV4 or IPV6
- * The second not void item must be IPV4 or IPV6 if the first one is ETH.
- * The next not void item could be UDP or TCP or SCTP (optional)
- * The next not void item could be RAW (for flexbyte, optional)
- * The next not void item must be END.
- * A Fuzzy Match pattern can appear at any place before END.
- * Fuzzy Match is optional for IPV4 but is required for IPV6
- * MAC VLAN PATTERN:
- * The first not void item must be ETH.
- * The second not void item must be MAC VLAN.
- * The next not void item must be END.
- * ACTION:
- * The first not void action should be QUEUE or DROP.
- * The second not void optional action should be MARK,
- * mark_id is a uint32_t number.
- * The next not void action should be END.
- * UDP/TCP/SCTP pattern example:
- * ITEM		Spec			Mask
- * ETH		NULL			NULL
- * IPV4		src_addr 192.168.1.20	0xFFFFFFFF
- *		dst_addr 192.167.3.50	0xFFFFFFFF
- * UDP/TCP/SCTP	src_port	80	0xFFFF
- *		dst_port	80	0xFFFF
- * FLEX	relative	0	0x1
- *		search		0	0x1
- *		reserved	0	0
- *		offset		12	0xFFFFFFFF
- *		limit		0	0xFFFF
- *		length		2	0xFFFF
- *		pattern[0]	0x86	0xFF
- *		pattern[1]	0xDD	0xFF
- * END
- * MAC VLAN pattern example:
- * ITEM		Spec			Mask
- * ETH		dst_addr
-		{0xAC, 0x7B, 0xA1,	{0xFF, 0xFF, 0xFF,
-		0x2C, 0x6D, 0x36}	0xFF, 0xFF, 0xFF}
- * MAC VLAN	tci	0x2016		0xEFFF
- * END
- * Other members in mask and spec should set to 0x00.
- * Item->last should be NULL.
- */
-static int
-ixgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev,
-			       const struct rte_flow_item pattern[],
-			       const struct ci_flow_actions *parsed_actions,
-			       struct ixgbe_fdir_rule *rule,
-			       struct rte_flow_error *error)
-{
-	const struct rte_flow_item *item;
-	const struct rte_flow_item_eth *eth_spec;
-	const struct rte_flow_item_eth *eth_mask;
-	const struct rte_flow_item_ipv4 *ipv4_spec;
-	const struct rte_flow_item_ipv4 *ipv4_mask;
-	const struct rte_flow_item_ipv6 *ipv6_spec;
-	const struct rte_flow_item_ipv6 *ipv6_mask;
-	const struct rte_flow_item_tcp *tcp_spec;
-	const struct rte_flow_item_tcp *tcp_mask;
-	const struct rte_flow_item_udp *udp_spec;
-	const struct rte_flow_item_udp *udp_mask;
-	const struct rte_flow_item_sctp *sctp_spec;
-	const struct rte_flow_item_sctp *sctp_mask;
-	const struct rte_flow_item_vlan *vlan_spec;
-	const struct rte_flow_item_vlan *vlan_mask;
-	const struct rte_flow_item_raw *raw_mask;
-	const struct rte_flow_item_raw *raw_spec;
-	const struct rte_flow_action *fwd_action, *aux_action;
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	uint8_t j;
-
-	fwd_action = parsed_actions->actions[0];
-	/* can be NULL */
-	aux_action = parsed_actions->actions[1];
-
-	/**
-	 * Some fields may not be provided. Set spec to 0 and mask to default
-	 * value. So, we need not do anything for the not provided fields later.
-	 */
-	memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-	memset(&rule->mask, 0xFF, sizeof(struct ixgbe_hw_fdir_mask));
-	rule->mask.vlan_tci_mask = 0;
-	rule->mask.flex_bytes_mask = 0;
-	rule->mask.l4_proto_match = 0;
-	rule->mask.dst_port_mask = 0;
-	rule->mask.src_port_mask = 0;
-
-	/* check if this is a signature match */
-	if (signature_match(pattern))
-		rule->mode = RTE_FDIR_MODE_SIGNATURE;
-	else
-		rule->mode = RTE_FDIR_MODE_PERFECT;
-
-	/* set up action */
-	if (fwd_action->type == RTE_FLOW_ACTION_TYPE_QUEUE) {
-		const struct rte_flow_action_queue *q_act = fwd_action->conf;
-		rule->queue = q_act->index;
-	} else {
-		/* signature mode does not support drop action. */
-		if (rule->mode == RTE_FDIR_MODE_SIGNATURE) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ACTION, fwd_action,
-				"Signature mode does not support drop action.");
-			return -rte_errno;
-		}
-		rule->fdirflags = IXGBE_FDIRCMD_DROP;
-	}
-
-	/* set up mark action */
-	if (aux_action != NULL && aux_action->type == RTE_FLOW_ACTION_TYPE_MARK) {
-		const struct rte_flow_action_mark *m_act = aux_action->conf;
-		rule->soft_id = m_act->id;
-	}
-
-	/**
-	 * The first not void item should be
-	 * MAC or IPv4 or TCP or UDP or SCTP.
-	 */
-	item = next_no_fuzzy_pattern(pattern, NULL);
-	if (item->type != RTE_FLOW_ITEM_TYPE_ETH &&
-	    item->type != RTE_FLOW_ITEM_TYPE_IPV4 &&
-	    item->type != RTE_FLOW_ITEM_TYPE_IPV6 &&
-	    item->type != RTE_FLOW_ITEM_TYPE_TCP &&
-	    item->type != RTE_FLOW_ITEM_TYPE_UDP &&
-	    item->type != RTE_FLOW_ITEM_TYPE_SCTP) {
-		memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			item, "Not supported by fdir filter");
-		return -rte_errno;
-	}
-
-	/*Not supported last point for range*/
-	if (item->last) {
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-			item, "Not supported last point for range");
-		return -rte_errno;
-	}
-
-	/* Get the MAC info. */
-	if (item->type == RTE_FLOW_ITEM_TYPE_ETH) {
-		/**
-		 * Only support vlan and dst MAC address,
-		 * others should be masked.
-		 */
-		if (item->spec && !item->mask) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-
-		if (item->spec) {
-			rule->b_spec = TRUE;
-			eth_spec = item->spec;
-
-			/* Get the dst MAC. */
-			for (j = 0; j < RTE_ETHER_ADDR_LEN; j++) {
-				rule->ixgbe_fdir.formatted.inner_mac[j] =
-					eth_spec->hdr.dst_addr.addr_bytes[j];
-			}
-		}
-
-
-		if (item->mask) {
-
-			rule->b_mask = TRUE;
-			eth_mask = item->mask;
-
-			/* Ether type should be masked. */
-			if (eth_mask->hdr.ether_type ||
-			    rule->mode == RTE_FDIR_MODE_SIGNATURE) {
-				memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-				rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ITEM,
-					item, "Not supported by fdir filter");
-				return -rte_errno;
-			}
-
-			/* If ethernet has meaning, it means MAC VLAN mode. */
-			rule->mode = RTE_FDIR_MODE_PERFECT_MAC_VLAN;
-
-			/**
-			 * src MAC address must be masked,
-			 * and don't support dst MAC address mask.
-			 */
-			for (j = 0; j < RTE_ETHER_ADDR_LEN; j++) {
-				if (eth_mask->hdr.src_addr.addr_bytes[j] ||
-					eth_mask->hdr.dst_addr.addr_bytes[j] != 0xFF) {
-					memset(rule, 0,
-					sizeof(struct ixgbe_fdir_rule));
-					rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ITEM,
-					item, "Not supported by fdir filter");
-					return -rte_errno;
-				}
-			}
-
-			/* When no VLAN, considered as full mask. */
-			rule->mask.vlan_tci_mask = rte_cpu_to_be_16(0xEFFF);
-		}
-		/*** If both spec and mask are item,
-		 * it means don't care about ETH.
-		 * Do nothing.
-		 */
-
-		/**
-		 * Check if the next not void item is vlan or ipv4.
-		 * IPv6 is not supported.
-		 */
-		item = next_no_fuzzy_pattern(pattern, item);
-		if (rule->mode == RTE_FDIR_MODE_PERFECT_MAC_VLAN) {
-			if (item->type != RTE_FLOW_ITEM_TYPE_VLAN) {
-				memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-				rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ITEM,
-					item, "Not supported by fdir filter");
-				return -rte_errno;
-			}
-		} else {
-			if (item->type != RTE_FLOW_ITEM_TYPE_IPV4 &&
-					item->type != RTE_FLOW_ITEM_TYPE_VLAN) {
-				memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-				rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ITEM,
-					item, "Not supported by fdir filter");
-				return -rte_errno;
-			}
-		}
-	}
-
-	if (item->type == RTE_FLOW_ITEM_TYPE_VLAN) {
-		if (!(item->spec && item->mask)) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-
-		/*Not supported last point for range*/
-		if (item->last) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				item, "Not supported last point for range");
-			return -rte_errno;
-		}
-
-		vlan_spec = item->spec;
-		vlan_mask = item->mask;
-
-		rule->ixgbe_fdir.formatted.vlan_id = vlan_spec->hdr.vlan_tci;
-
-		rule->mask.vlan_tci_mask = vlan_mask->hdr.vlan_tci;
-		rule->mask.vlan_tci_mask &= rte_cpu_to_be_16(0xEFFF);
-		/* More than one tags are not supported. */
-
-		/* Next not void item must be END */
-		item = next_no_fuzzy_pattern(pattern, item);
-		if (item->type != RTE_FLOW_ITEM_TYPE_END) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-	}
-
-	/* Get the IPV4 info. */
-	if (item->type == RTE_FLOW_ITEM_TYPE_IPV4) {
-		/**
-		 * Set the flow type even if there's no content
-		 * as we must have a flow type.
-		 */
-		rule->ixgbe_fdir.formatted.flow_type =
-			IXGBE_ATR_FLOW_TYPE_IPV4;
-		/*Not supported last point for range*/
-		if (item->last) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				item, "Not supported last point for range");
-			return -rte_errno;
-		}
-		/**
-		 * Only care about src & dst addresses,
-		 * others should be masked.
-		 */
-		if (!item->mask) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-		rule->b_mask = TRUE;
-		ipv4_mask = item->mask;
-		if (ipv4_mask->hdr.version_ihl ||
-		    ipv4_mask->hdr.type_of_service ||
-		    ipv4_mask->hdr.total_length ||
-		    ipv4_mask->hdr.packet_id ||
-		    ipv4_mask->hdr.fragment_offset ||
-		    ipv4_mask->hdr.time_to_live ||
-		    ipv4_mask->hdr.next_proto_id ||
-		    ipv4_mask->hdr.hdr_checksum) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-		rule->mask.dst_ipv4_mask = ipv4_mask->hdr.dst_addr;
-		rule->mask.src_ipv4_mask = ipv4_mask->hdr.src_addr;
-
-		if (item->spec) {
-			rule->b_spec = TRUE;
-			ipv4_spec = item->spec;
-			rule->ixgbe_fdir.formatted.dst_ip[0] =
-				ipv4_spec->hdr.dst_addr;
-			rule->ixgbe_fdir.formatted.src_ip[0] =
-				ipv4_spec->hdr.src_addr;
-		}
-
-		/**
-		 * Check if the next not void item is
-		 * TCP or UDP or SCTP or END.
-		 */
-		item = next_no_fuzzy_pattern(pattern, item);
-		if (item->type != RTE_FLOW_ITEM_TYPE_TCP &&
-		    item->type != RTE_FLOW_ITEM_TYPE_UDP &&
-		    item->type != RTE_FLOW_ITEM_TYPE_SCTP &&
-		    item->type != RTE_FLOW_ITEM_TYPE_END &&
-		    item->type != RTE_FLOW_ITEM_TYPE_RAW) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-	}
-
-	/* Get the IPV6 info. */
-	if (item->type == RTE_FLOW_ITEM_TYPE_IPV6) {
-		/**
-		 * Set the flow type even if there's no content
-		 * as we must have a flow type.
-		 */
-		rule->ixgbe_fdir.formatted.flow_type =
-			IXGBE_ATR_FLOW_TYPE_IPV6;
-
-		/**
-		 * 1. must signature match
-		 * 2. not support last
-		 * 3. mask must not null
-		 */
-		if (rule->mode != RTE_FDIR_MODE_SIGNATURE ||
-		    item->last ||
-		    !item->mask) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				item, "Not supported last point for range");
-			return -rte_errno;
-		}
-
-		rule->b_mask = TRUE;
-		ipv6_mask = item->mask;
-		if (ipv6_mask->hdr.vtc_flow ||
-		    ipv6_mask->hdr.payload_len ||
-		    ipv6_mask->hdr.proto ||
-		    ipv6_mask->hdr.hop_limits) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-
-		/* check src addr mask */
-		for (j = 0; j < 16; j++) {
-			if (ipv6_mask->hdr.src_addr.a[j] == 0) {
-				rule->mask.src_ipv6_mask &= ~(1 << j);
-			} else if (ipv6_mask->hdr.src_addr.a[j] != UINT8_MAX) {
-				memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-				rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ITEM,
-					item, "Not supported by fdir filter");
-				return -rte_errno;
-			}
-		}
-
-		/* check dst addr mask */
-		for (j = 0; j < 16; j++) {
-			if (ipv6_mask->hdr.dst_addr.a[j] == 0) {
-				rule->mask.dst_ipv6_mask &= ~(1 << j);
-			} else if (ipv6_mask->hdr.dst_addr.a[j] != UINT8_MAX) {
-				memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-				rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ITEM,
-					item, "Not supported by fdir filter");
-				return -rte_errno;
-			}
-		}
-
-		if (item->spec) {
-			rule->b_spec = TRUE;
-			ipv6_spec = item->spec;
-			memcpy(rule->ixgbe_fdir.formatted.src_ip,
-				   &ipv6_spec->hdr.src_addr, 16);
-			memcpy(rule->ixgbe_fdir.formatted.dst_ip,
-				   &ipv6_spec->hdr.dst_addr, 16);
-		}
-
-		/**
-		 * Check if the next not void item is
-		 * TCP or UDP or SCTP or END.
-		 */
-		item = next_no_fuzzy_pattern(pattern, item);
-		if (item->type != RTE_FLOW_ITEM_TYPE_TCP &&
-		    item->type != RTE_FLOW_ITEM_TYPE_UDP &&
-		    item->type != RTE_FLOW_ITEM_TYPE_SCTP &&
-		    item->type != RTE_FLOW_ITEM_TYPE_END &&
-		    item->type != RTE_FLOW_ITEM_TYPE_RAW) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-	}
-
-	/* Get the TCP info. */
-	if (item->type == RTE_FLOW_ITEM_TYPE_TCP) {
-		/**
-		 * Set the flow type even if there's no content
-		 * as we must have a flow type.
-		 */
-		rule->ixgbe_fdir.formatted.flow_type |=
-			IXGBE_ATR_L4TYPE_TCP;
-		/*Not supported last point for range*/
-		if (item->last) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				item, "Not supported last point for range");
-			return -rte_errno;
-		}
-		tcp_mask = item->mask;
-		if (tcp_mask != NULL) {
-			/**
-			 * Only care about src & dst ports,
-			 * others should be masked.
-			 */
-			rule->b_mask = TRUE;
-			if (tcp_mask->hdr.sent_seq ||
-			    tcp_mask->hdr.recv_ack ||
-			    tcp_mask->hdr.data_off ||
-			    tcp_mask->hdr.tcp_flags ||
-			    tcp_mask->hdr.rx_win ||
-			    tcp_mask->hdr.cksum ||
-			    tcp_mask->hdr.tcp_urp) {
-				memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-				rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ITEM,
-					item, "Not supported by fdir filter");
-				return -rte_errno;
-			}
-			rule->mask.src_port_mask = tcp_mask->hdr.src_port;
-			rule->mask.dst_port_mask = tcp_mask->hdr.dst_port;
-
-			if (item->spec) {
-				rule->b_spec = TRUE;
-				tcp_spec = item->spec;
-				rule->ixgbe_fdir.formatted.src_port =
-					tcp_spec->hdr.src_port;
-				rule->ixgbe_fdir.formatted.dst_port =
-					tcp_spec->hdr.dst_port;
-			}
-		} else if (item->spec != NULL) {
-			/* No port mask means protocol-only match; spec is invalid. */
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-
-		item = next_no_fuzzy_pattern(pattern, item);
-		if (item->type != RTE_FLOW_ITEM_TYPE_RAW &&
-		    item->type != RTE_FLOW_ITEM_TYPE_END) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-
-	}
-
-	/* Get the UDP info */
-	if (item->type == RTE_FLOW_ITEM_TYPE_UDP) {
-		/**
-		 * Set the flow type even if there's no content
-		 * as we must have a flow type.
-		 */
-		rule->ixgbe_fdir.formatted.flow_type |=
-			IXGBE_ATR_L4TYPE_UDP;
-		/*Not supported last point for range*/
-		if (item->last) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				item, "Not supported last point for range");
-			return -rte_errno;
-		}
-		udp_mask = item->mask;
-		if (udp_mask != NULL) {
-			/**
-			 * Only care about src & dst ports,
-			 * others should be masked.
-			 */
-			rule->b_mask = TRUE;
-			if (udp_mask->hdr.dgram_len ||
-			    udp_mask->hdr.dgram_cksum) {
-				memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-				rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ITEM,
-					item, "Not supported by fdir filter");
-				return -rte_errno;
-			}
-			rule->mask.src_port_mask = udp_mask->hdr.src_port;
-			rule->mask.dst_port_mask = udp_mask->hdr.dst_port;
-
-			if (item->spec) {
-				rule->b_spec = TRUE;
-				udp_spec = item->spec;
-				rule->ixgbe_fdir.formatted.src_port =
-					udp_spec->hdr.src_port;
-				rule->ixgbe_fdir.formatted.dst_port =
-					udp_spec->hdr.dst_port;
-			}
-		} else if (item->spec != NULL) {
-			/* No port mask means protocol-only match; spec is invalid. */
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-
-		item = next_no_fuzzy_pattern(pattern, item);
-		if (item->type != RTE_FLOW_ITEM_TYPE_RAW &&
-		    item->type != RTE_FLOW_ITEM_TYPE_END) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-
-	}
-
-	/* Get the SCTP info */
-	if (item->type == RTE_FLOW_ITEM_TYPE_SCTP) {
-		/**
-		 * Set the flow type even if there's no content
-		 * as we must have a flow type.
-		 */
-		rule->ixgbe_fdir.formatted.flow_type |=
-			IXGBE_ATR_L4TYPE_SCTP;
-		/*Not supported last point for range*/
-		if (item->last) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				item, "Not supported last point for range");
-			return -rte_errno;
-		}
-
-		sctp_mask = item->mask;
-		if (sctp_mask != NULL) {
-			/* only some mac types support sctp port masking */
-			if (hw->mac.type == ixgbe_mac_X550 ||
-			    hw->mac.type == ixgbe_mac_X550EM_x ||
-			    hw->mac.type == ixgbe_mac_X550EM_a ||
-			    hw->mac.type == ixgbe_mac_E610) {
-				/**
-				 * Only care about src & dst ports,
-				 * others should be masked.
-				 */
-				rule->b_mask = TRUE;
-				if (sctp_mask->hdr.tag ||
-				    sctp_mask->hdr.cksum) {
-					memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-					rte_flow_error_set(error, EINVAL,
-						RTE_FLOW_ERROR_TYPE_ITEM,
-						item, "Not supported by fdir filter");
-					return -rte_errno;
-				}
-				rule->mask.src_port_mask = sctp_mask->hdr.src_port;
-				rule->mask.dst_port_mask = sctp_mask->hdr.dst_port;
-
-				if (item->spec) {
-					rule->b_spec = TRUE;
-					sctp_spec = item->spec;
-					rule->ixgbe_fdir.formatted.src_port =
-						sctp_spec->hdr.src_port;
-					rule->ixgbe_fdir.formatted.dst_port =
-						sctp_spec->hdr.dst_port;
-				}
-			/* others even sctp port masking is not supported */
-			} else if (sctp_mask->hdr.src_port ||
-				   sctp_mask->hdr.dst_port ||
-				   sctp_mask->hdr.tag ||
-				   sctp_mask->hdr.cksum) {
-				memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-				rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ITEM,
-					item, "Not supported by fdir filter");
-				return -rte_errno;
-			}
-		} else if (item->spec != NULL) {
-			/* No port mask means protocol-only match; spec is invalid. */
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-
-		item = next_no_fuzzy_pattern(pattern, item);
-		if (item->type != RTE_FLOW_ITEM_TYPE_RAW &&
-			item->type != RTE_FLOW_ITEM_TYPE_END) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-	}
-
-	/* Get the flex byte info */
-	if (item->type == RTE_FLOW_ITEM_TYPE_RAW) {
-		/* Not supported last point for range*/
-		if (item->last) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				item, "Not supported last point for range");
-			return -rte_errno;
-		}
-		/* mask should not be null */
-		if (!item->mask || !item->spec) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-
-		raw_mask = item->mask;
-
-		/* check mask */
-		if (raw_mask->relative != 0x1 ||
-		    raw_mask->search != 0x1 ||
-		    raw_mask->reserved != 0x0 ||
-		    (uint32_t)raw_mask->offset != 0xffffffff ||
-		    raw_mask->limit != 0xffff ||
-		    raw_mask->length != 0xffff) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-
-		raw_spec = item->spec;
-
-		/* check spec */
-		if (raw_spec->relative != 0 ||
-		    raw_spec->search != 0 ||
-		    raw_spec->reserved != 0 ||
-		    raw_spec->offset > IXGBE_MAX_FLX_SOURCE_OFF ||
-		    raw_spec->offset % 2 ||
-		    raw_spec->limit != 0 ||
-		    raw_spec->length != 2 ||
-		    /* pattern can't be 0xffff */
-		    (raw_spec->pattern[0] == 0xff &&
-		     raw_spec->pattern[1] == 0xff)) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-
-		/* check pattern mask */
-		if (raw_mask->pattern[0] != 0xff ||
-		    raw_mask->pattern[1] != 0xff) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-
-		rule->mask.flex_bytes_mask = 0xffff;
-		rule->ixgbe_fdir.formatted.flex_bytes =
-			(((uint16_t)raw_spec->pattern[1]) << 8) |
-			raw_spec->pattern[0];
-		rule->flex_bytes_offset = raw_spec->offset;
-	}
-
-	if (item->type != RTE_FLOW_ITEM_TYPE_END) {
-		/* check if the next not void item is END */
-		item = next_no_fuzzy_pattern(pattern, item);
-		if (item->type != RTE_FLOW_ITEM_TYPE_END) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-	}
-
-	/* L4 protocol matching is enabled when parser selected an L4 type. */
-	rule->mask.l4_proto_match =
-		(rule->ixgbe_fdir.formatted.flow_type & IXGBE_ATR_L4TYPE_MASK) != 0;
-
-	return 0;
-}
-
-#define NVGRE_PROTOCOL 0x6558
-
-/**
- * Parse the rule to see if it is a VxLAN or NVGRE flow director rule.
- * And get the flow director filter info BTW.
- * VxLAN PATTERN:
- * The first not void item must be ETH.
- * The second not void item must be IPV4/ IPV6.
- * The third not void item must be NVGRE.
- * The next not void item must be END.
- * NVGRE PATTERN:
- * The first not void item must be ETH.
- * The second not void item must be IPV4/ IPV6.
- * The third not void item must be NVGRE.
- * The next not void item must be END.
- * ACTION:
- * The first not void action should be QUEUE or DROP.
- * The second not void optional action should be MARK,
- * mark_id is a uint32_t number.
- * The next not void action should be END.
- * VxLAN pattern example:
- * ITEM		Spec			Mask
- * ETH		NULL			NULL
- * IPV4/IPV6	NULL			NULL
- * UDP		NULL			NULL
- * VxLAN	vni{0x00, 0x32, 0x54}	{0xFF, 0xFF, 0xFF}
- * MAC VLAN	tci	0x2016		0xEFFF
- * END
- * NEGRV pattern example:
- * ITEM		Spec			Mask
- * ETH		NULL			NULL
- * IPV4/IPV6	NULL			NULL
- * NVGRE	protocol	0x6558	0xFFFF
- *		tni{0x00, 0x32, 0x54}	{0xFF, 0xFF, 0xFF}
- * MAC VLAN	tci	0x2016		0xEFFF
- * END
- * other members in mask and spec should set to 0x00.
- * item->last should be NULL.
- */
-static int
-ixgbe_parse_fdir_filter_tunnel(const struct rte_flow_item pattern[],
-			       const struct ci_flow_actions *parsed_actions,
-			       struct ixgbe_fdir_rule *rule,
-			       struct rte_flow_error *error)
-{
-	const struct rte_flow_item *item;
-	const struct rte_flow_item_vxlan *vxlan_spec;
-	const struct rte_flow_item_vxlan *vxlan_mask;
-	const struct rte_flow_item_nvgre *nvgre_spec;
-	const struct rte_flow_item_nvgre *nvgre_mask;
-	const struct rte_flow_item_eth *eth_spec;
-	const struct rte_flow_item_eth *eth_mask;
-	const struct rte_flow_item_vlan *vlan_spec;
-	const struct rte_flow_item_vlan *vlan_mask;
-	const struct rte_flow_action *fwd_action, *aux_action;
-	uint32_t j;
-
-	fwd_action = parsed_actions->actions[0];
-	/* can be NULL */
-	aux_action = parsed_actions->actions[1];
-
-	/**
-	 * Some fields may not be provided. Set spec to 0 and mask to default
-	 * value. So, we need not do anything for the not provided fields later.
-	 */
-	memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-	memset(&rule->mask, 0xFF, sizeof(struct ixgbe_hw_fdir_mask));
-	rule->mask.vlan_tci_mask = 0;
-
-	/* set up queue/drop action */
-	if (fwd_action->type == RTE_FLOW_ACTION_TYPE_QUEUE) {
-		const struct rte_flow_action_queue *q_act = fwd_action->conf;
-		rule->queue = q_act->index;
-	} else {
-		rule->fdirflags = IXGBE_FDIRCMD_DROP;
-	}
-
-	/* set up mark action */
-	if (aux_action != NULL && aux_action->type == RTE_FLOW_ACTION_TYPE_MARK) {
-		const struct rte_flow_action_mark *mark = aux_action->conf;
-		rule->soft_id = mark->id;
-	}
-
-	/**
-	 * The first not void item should be
-	 * MAC or IPv4 or IPv6 or UDP or VxLAN.
-	 */
-	item = next_no_void_pattern(pattern, NULL);
-	if (item->type != RTE_FLOW_ITEM_TYPE_ETH &&
-	    item->type != RTE_FLOW_ITEM_TYPE_IPV4 &&
-	    item->type != RTE_FLOW_ITEM_TYPE_IPV6 &&
-	    item->type != RTE_FLOW_ITEM_TYPE_UDP &&
-	    item->type != RTE_FLOW_ITEM_TYPE_VXLAN &&
-	    item->type != RTE_FLOW_ITEM_TYPE_NVGRE) {
-		memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			item, "Not supported by fdir filter");
-		return -rte_errno;
-	}
-
-	rule->mode = RTE_FDIR_MODE_PERFECT_TUNNEL;
-
-	/* Skip MAC. */
-	if (item->type == RTE_FLOW_ITEM_TYPE_ETH) {
-		/* Only used to describe the protocol stack. */
-		if (item->spec || item->mask) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-		/* Not supported last point for range*/
-		if (item->last) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				item, "Not supported last point for range");
-			return -rte_errno;
-		}
-
-		/* Check if the next not void item is IPv4 or IPv6. */
-		item = next_no_void_pattern(pattern, item);
-		if (item->type != RTE_FLOW_ITEM_TYPE_IPV4 &&
-		    item->type != RTE_FLOW_ITEM_TYPE_IPV6) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-	}
-
-	/* Skip IP. */
-	if (item->type == RTE_FLOW_ITEM_TYPE_IPV4 ||
-	    item->type == RTE_FLOW_ITEM_TYPE_IPV6) {
-		/* Only used to describe the protocol stack. */
-		if (item->spec || item->mask) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-		/*Not supported last point for range*/
-		if (item->last) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				item, "Not supported last point for range");
-			return -rte_errno;
-		}
-
-		/* Check if the next not void item is UDP or NVGRE. */
-		item = next_no_void_pattern(pattern, item);
-		if (item->type != RTE_FLOW_ITEM_TYPE_UDP &&
-		    item->type != RTE_FLOW_ITEM_TYPE_NVGRE) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-	}
-
-	/* Skip UDP. */
-	if (item->type == RTE_FLOW_ITEM_TYPE_UDP) {
-		/* Only used to describe the protocol stack. */
-		if (item->spec || item->mask) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-		/*Not supported last point for range*/
-		if (item->last) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				item, "Not supported last point for range");
-			return -rte_errno;
-		}
-
-		/* Check if the next not void item is VxLAN. */
-		item = next_no_void_pattern(pattern, item);
-		if (item->type != RTE_FLOW_ITEM_TYPE_VXLAN) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-	}
-
-	/* Get the VxLAN info */
-	if (item->type == RTE_FLOW_ITEM_TYPE_VXLAN) {
-		rule->ixgbe_fdir.formatted.tunnel_type =
-				IXGBE_FDIR_VXLAN_TUNNEL_TYPE;
-
-		/* Only care about VNI, others should be masked. */
-		if (!item->mask) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-		/*Not supported last point for range*/
-		if (item->last) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				item, "Not supported last point for range");
-			return -rte_errno;
-		}
-		rule->b_mask = TRUE;
-
-		/* Tunnel type is always meaningful. */
-		rule->mask.tunnel_type_mask = 1;
-
-		vxlan_mask = item->mask;
-		if (vxlan_mask->hdr.flags) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-		/* VNI must be totally masked or not. */
-		if ((vxlan_mask->hdr.vni[0] || vxlan_mask->hdr.vni[1] ||
-			vxlan_mask->hdr.vni[2]) &&
-			((vxlan_mask->hdr.vni[0] != 0xFF) ||
-			(vxlan_mask->hdr.vni[1] != 0xFF) ||
-				(vxlan_mask->hdr.vni[2] != 0xFF))) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-
-		memcpy(&rule->mask.tunnel_id_mask, vxlan_mask->hdr.vni,
-			RTE_DIM(vxlan_mask->hdr.vni));
-
-		if (item->spec) {
-			rule->b_spec = TRUE;
-			vxlan_spec = item->spec;
-			memcpy(((uint8_t *)
-				&rule->ixgbe_fdir.formatted.tni_vni),
-				vxlan_spec->hdr.vni, RTE_DIM(vxlan_spec->hdr.vni));
-		}
-	}
-
-	/* Get the NVGRE info */
-	if (item->type == RTE_FLOW_ITEM_TYPE_NVGRE) {
-		rule->ixgbe_fdir.formatted.tunnel_type =
-				IXGBE_FDIR_NVGRE_TUNNEL_TYPE;
-
-		/**
-		 * Only care about flags0, flags1, protocol and TNI,
-		 * others should be masked.
-		 */
-		if (!item->mask) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-		/*Not supported last point for range*/
-		if (item->last) {
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				item, "Not supported last point for range");
-			return -rte_errno;
-		}
-		rule->b_mask = TRUE;
-
-		/* Tunnel type is always meaningful. */
-		rule->mask.tunnel_type_mask = 1;
-
-		nvgre_mask = item->mask;
-		if (nvgre_mask->flow_id) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-		if (nvgre_mask->protocol &&
-		    nvgre_mask->protocol != 0xFFFF) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-		if (nvgre_mask->c_k_s_rsvd0_ver &&
-		    nvgre_mask->c_k_s_rsvd0_ver !=
-			rte_cpu_to_be_16(0xFFFF)) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-		/* TNI must be totally masked or not. */
-		if (nvgre_mask->tni[0] &&
-		    ((nvgre_mask->tni[0] != 0xFF) ||
-		    (nvgre_mask->tni[1] != 0xFF) ||
-		    (nvgre_mask->tni[2] != 0xFF))) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-		/* tni is a 24-bits bit field */
-		memcpy(&rule->mask.tunnel_id_mask, nvgre_mask->tni,
-			RTE_DIM(nvgre_mask->tni));
-		rule->mask.tunnel_id_mask <<= 8;
-
-		if (item->spec) {
-			rule->b_spec = TRUE;
-			nvgre_spec = item->spec;
-			if (nvgre_spec->c_k_s_rsvd0_ver !=
-			    rte_cpu_to_be_16(0x2000) &&
-				nvgre_mask->c_k_s_rsvd0_ver) {
-				memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-				rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ITEM,
-					item, "Not supported by fdir filter");
-				return -rte_errno;
-			}
-			if (nvgre_mask->protocol &&
-			    nvgre_spec->protocol !=
-			    rte_cpu_to_be_16(NVGRE_PROTOCOL)) {
-				memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-				rte_flow_error_set(error, EINVAL,
-					RTE_FLOW_ERROR_TYPE_ITEM,
-					item, "Not supported by fdir filter");
-				return -rte_errno;
-			}
-			/* tni is a 24-bits bit field */
-			memcpy(&rule->ixgbe_fdir.formatted.tni_vni,
-			nvgre_spec->tni, RTE_DIM(nvgre_spec->tni));
-		}
-	}
-
-	/* check if the next not void item is MAC */
-	item = next_no_void_pattern(pattern, item);
-	if (item->type != RTE_FLOW_ITEM_TYPE_ETH) {
-		memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			item, "Not supported by fdir filter");
-		return -rte_errno;
-	}
-
-	/**
-	 * Only support vlan and dst MAC address,
-	 * others should be masked.
-	 */
-
-	if (!item->mask) {
-		memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			item, "Not supported by fdir filter");
-		return -rte_errno;
-	}
-	/*Not supported last point for range*/
-	if (item->last) {
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-			item, "Not supported last point for range");
-		return -rte_errno;
-	}
-	rule->b_mask = TRUE;
-	eth_mask = item->mask;
-
-	/* Ether type should be masked. */
-	if (eth_mask->hdr.ether_type) {
-		memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			item, "Not supported by fdir filter");
-		return -rte_errno;
-	}
-
-	/* src MAC address should be masked. */
-	for (j = 0; j < RTE_ETHER_ADDR_LEN; j++) {
-		if (eth_mask->hdr.src_addr.addr_bytes[j]) {
-			memset(rule, 0,
-			       sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-	}
-	rule->mask.mac_addr_byte_mask = 0;
-	for (j = 0; j < RTE_ETHER_ADDR_LEN; j++) {
-		/* It's a per byte mask. */
-		if (eth_mask->hdr.dst_addr.addr_bytes[j] == 0xFF) {
-			rule->mask.mac_addr_byte_mask |= 0x1 << j;
-		} else if (eth_mask->hdr.dst_addr.addr_bytes[j]) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-	}
-
-	/* When no vlan, considered as full mask. */
-	rule->mask.vlan_tci_mask = rte_cpu_to_be_16(0xEFFF);
-
-	if (item->spec) {
-		rule->b_spec = TRUE;
-		eth_spec = item->spec;
-
-		/* Get the dst MAC. */
-		for (j = 0; j < RTE_ETHER_ADDR_LEN; j++) {
-			rule->ixgbe_fdir.formatted.inner_mac[j] =
-				eth_spec->hdr.dst_addr.addr_bytes[j];
-		}
-	}
-
-	/**
-	 * Check if the next not void item is vlan or ipv4.
-	 * IPv6 is not supported.
-	 */
-	item = next_no_void_pattern(pattern, item);
-	if ((item->type != RTE_FLOW_ITEM_TYPE_VLAN) &&
-		(item->type != RTE_FLOW_ITEM_TYPE_IPV4)) {
-		memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			item, "Not supported by fdir filter");
-		return -rte_errno;
-	}
-	/*Not supported last point for range*/
-	if (item->last) {
-		rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-			item, "Not supported last point for range");
-		return -rte_errno;
-	}
-
-	if (item->type == RTE_FLOW_ITEM_TYPE_VLAN) {
-		if (!(item->spec && item->mask)) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-
-		vlan_spec = item->spec;
-		vlan_mask = item->mask;
-
-		rule->ixgbe_fdir.formatted.vlan_id = vlan_spec->hdr.vlan_tci;
-
-		rule->mask.vlan_tci_mask = vlan_mask->hdr.vlan_tci;
-		rule->mask.vlan_tci_mask &= rte_cpu_to_be_16(0xEFFF);
-		/* More than one tags are not supported. */
-
-		/* check if the next not void item is END */
-		item = next_no_void_pattern(pattern, item);
-
-		if (item->type != RTE_FLOW_ITEM_TYPE_END) {
-			memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM,
-				item, "Not supported by fdir filter");
-			return -rte_errno;
-		}
-	}
-
-	/**
-	 * If the tags is 0, it means don't care about the VLAN.
-	 * Do nothing.
-	 */
-
-	return 0;
-}
-
-/*
- * Check flow director actions
- */
-static int
-ixgbe_fdir_actions_check(const struct ci_flow_actions *parsed_actions,
-	const struct ci_flow_actions_check_param *param __rte_unused,
-	struct rte_flow_error *error)
-{
-	const enum rte_flow_action_type fwd_actions[] = {
-		RTE_FLOW_ACTION_TYPE_QUEUE,
-		RTE_FLOW_ACTION_TYPE_DROP,
-		RTE_FLOW_ACTION_TYPE_END
-	};
-	const struct rte_flow_action *action;
-
-	/* do the generic checks first */
-	int ret = ixgbe_flow_actions_check(parsed_actions, param, error);
-	if (ret)
-		return ret;
-
-	/* first action must be a forwarding action */
-	action = parsed_actions->actions[0];
-	if (!ci_flow_action_type_in_list(action->type, fwd_actions)) {
-		return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
-					  action, "First action must be QUEUE or DROP");
-	}
-
-	/* second action, if specified, must not be a forwarding action */
-	action = parsed_actions->actions[1];
-	if (action != NULL && ci_flow_action_type_in_list(action->type, fwd_actions)) {
-		return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
-					  action, "Conflicting actions");
-	}
-	return 0;
-}
-
-static int
-ixgbe_parse_fdir_filter(struct rte_eth_dev *dev,
-		const struct rte_flow_attr *attr,
-		const struct rte_flow_item pattern[],
-		const struct rte_flow_action actions[],
-		struct ixgbe_fdir_rule *rule,
-		struct rte_flow_error *error)
-{
-	int ret;
-	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
-	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_PRIVATE_TO_FDIR_CONF(adapter);
-	struct ci_flow_actions parsed_actions;
-	struct ci_flow_actions_check_param ap_param = {
-		.allowed_types = (const enum rte_flow_action_type[]){
-			/* queue/mark/drop allowed here */
-			RTE_FLOW_ACTION_TYPE_QUEUE,
-			RTE_FLOW_ACTION_TYPE_DROP,
-			RTE_FLOW_ACTION_TYPE_MARK,
-			RTE_FLOW_ACTION_TYPE_END
-		},
-		.driver_ctx = dev->data,
-		.check = ixgbe_fdir_actions_check
-	};
-
-	if (hw->mac.type != ixgbe_mac_82599EB &&
-			hw->mac.type != ixgbe_mac_X540 &&
-			hw->mac.type != ixgbe_mac_X550 &&
-			hw->mac.type != ixgbe_mac_X550EM_x &&
-			hw->mac.type != ixgbe_mac_X550EM_a &&
-			hw->mac.type != ixgbe_mac_E610)
-		return -ENOTSUP;
-
-	/* validate attributes */
-	ret = ci_flow_check_attr(attr, NULL, error);
-	if (ret)
-		return ret;
-
-	/* parse requested actions */
-	ret = ci_flow_check_actions(actions, &ap_param, &parsed_actions, error);
-	if (ret)
-		return ret;
-
-	fdir_conf->drop_queue = IXGBE_FDIR_DROP_QUEUE;
-
-	ret = ixgbe_parse_fdir_filter_normal(dev, pattern, &parsed_actions, rule, error);
-	if (!ret)
-		return 0;
-
-	return ixgbe_parse_fdir_filter_tunnel(pattern, &parsed_actions,
-		rule, error);
-}
-
-static int
-ixgbe_fdir_process_rule(struct ixgbe_adapter *adapter,
-		struct ixgbe_hw_fdir_info *fdir_info,
-		struct ixgbe_fdir_rule *fdir_rule,
-		bool *first_mask,
-		struct rte_flow_error *error)
-{
-	bool flex_byte_offset_changed;
-	int ret;
-
-	/* rule must have a spec to be valid */
-	if (!fdir_rule->b_spec)
-		return rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-			NULL, "No filter spec");
-
-	/* if rule doesn't have a mask, nothing to be done */
-	if (!fdir_rule->b_mask)
-		return 0;
-
-	/* if we already have a mask, check if it's compatible */
-	if (fdir_info->mask_added) {
-		ret = memcmp(&fdir_info->mask, &fdir_rule->mask,
-				sizeof(struct ixgbe_hw_fdir_mask));
-		if (ret)
-			return rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				NULL, "Mask mismatch");
-
-		if (fdir_rule->mask.flex_bytes_mask &&
-		    fdir_info->flex_bytes_offset !=
-		    fdir_rule->flex_bytes_offset)
-			return rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				NULL, "Flex bytes offset mismatch");
-
-		/* success */
-		return 0;
-	}
-
-	/* we don't have a mask yet, so set it up based on this rule */
-	flex_byte_offset_changed =
-			fdir_info->flex_bytes_offset !=
-			fdir_rule->flex_bytes_offset;
-
-	if (fdir_rule->mask.flex_bytes_mask != 0 && flex_byte_offset_changed) {
-		ret = ixgbe_fdir_set_flexbytes_offset(adapter,
-				fdir_rule->flex_bytes_offset);
-		if (ret)
-			return rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				NULL,
-				"Failed to set flex bytes offset");
-	}
-
-	ret = ixgbe_fdir_set_input_mask(adapter, &fdir_rule->mask,
-			fdir_rule->mode);
-	if (ret)
-		return rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-			NULL, "Failed to set fdir mask");
-
-	/* let the caller know that we've installed a mask */
-	*first_mask = true;
-
-	return 0;
-}
-
-static int
-ixgbe_fdir_flow_program(struct rte_eth_dev *dev,
-		struct ixgbe_adapter *adapter,
-		struct ixgbe_fdir_rule *fdir_rule,
-		bool *first_mask,
-		struct rte_flow_error *error)
-{
-	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
-	struct rte_eth_fdir_conf local_fdir_conf = *fdir_conf;
-	struct ixgbe_hw_fdir_info *fdir_info =
-			IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter);
-	int ret;
-
-	if (fdir_rule->queue >= dev->data->nb_rx_queues) {
-		return rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_ACTION,
-			NULL, "queue id > max number of queues");
-	}
-
-	local_fdir_conf.mode = fdir_rule->mode;
-
-	/* Configure FDIR mode if this is the first filter */
-	if (fdir_conf->mode == RTE_FDIR_MODE_NONE) {
-		ret = ixgbe_fdir_configure(dev, &local_fdir_conf, &fdir_rule->mask);
-		if (ret == -ENOTSUP)
-			return rte_flow_error_set(error, ENOTSUP,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
-				"Flow Director is not supported with DCB");
-		if (ret) {
-			return rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				NULL, "Failed to configure fdir mode");
-		}
-	} else if (fdir_conf->mode != fdir_rule->mode) {
-		return rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-			NULL, "Conflict with existing fdir mode");
-	}
-
-	/* Process and validate rule spec and mask */
-	ret = ixgbe_fdir_process_rule(adapter, fdir_info, fdir_rule,
-		first_mask, error);
-	if (ret)
-		return ret;
-
-	/* Program the filter */
-	ret = ixgbe_fdir_filter_program(adapter, &local_fdir_conf,
-			fdir_rule, FALSE, FALSE);
-	if (ret)
-		return rte_flow_error_set(error, EINVAL,
-			RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-			NULL, "Failed to add fdir filter");
-
-	return 0;
-}
-
 /* Flow actions check specific to RSS filter */
 static int
 ixgbe_flow_actions_check_rss(const struct ci_flow_actions *parsed_actions,
@@ -1788,14 +274,9 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 		  struct rte_flow_error *error)
 {
 	int ret;
-	struct ixgbe_adapter *adapter =
-		IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
-	struct ixgbe_fdir_rule fdir_rule;
-	struct ixgbe_hw_fdir_info *fdir_info =
-		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter);
+	struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct ixgbe_rte_flow_rss_conf rss_conf;
 	struct rte_flow *flow = NULL;
-	struct ixgbe_fdir_rule_ele *fdir_rule_ptr;
 	struct ixgbe_rss_conf_ele *rss_filter_ptr;
 	struct ixgbe_flow_mem *ixgbe_flow_mem_ptr;
 
@@ -1822,43 +303,6 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 	TAILQ_INSERT_TAIL(&adapter->flow_list,
 				&ixgbe_flow_mem_ptr->base, entries);
 
-	memset(&fdir_rule, 0, sizeof(struct ixgbe_fdir_rule));
-	ret = ixgbe_parse_fdir_filter(dev, attr, pattern,
-				actions, &fdir_rule, error);
-	if (!ret) {
-		struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
-		bool first_mask = false;
-
-		fdir_rule_ptr = rte_zmalloc("ixgbe_fdir_filter",
-				sizeof(struct ixgbe_fdir_rule_ele), 0);
-		if (!fdir_rule_ptr) {
-			PMD_DRV_LOG(ERR, "failed to allocate memory");
-			ret = -ENOMEM;
-			goto out;
-		}
-
-		ret = ixgbe_fdir_flow_program(dev, adapter, &fdir_rule,
-			&first_mask, error);
-		if (ret) {
-			rte_free(fdir_rule_ptr);
-			goto out;
-		}
-
-		/* update global state */
-		if (first_mask) {
-			fdir_info->mask_added = TRUE;
-			fdir_info->mask = fdir_rule.mask;
-			fdir_info->flex_bytes_offset = fdir_rule.flex_bytes_offset;
-		}
-		fdir_info->n_flows++;
-		fdir_conf->mode = fdir_rule.mode;
-
-		fdir_rule_ptr->filter_info = fdir_rule;
-		flow->rule = fdir_rule_ptr;
-		flow->filter_type = RTE_ETH_FILTER_FDIR;
-		return flow;
-	}
-
 	memset(&rss_conf, 0, sizeof(struct ixgbe_rte_flow_rss_conf));
 	ret = ixgbe_parse_rss_filter(dev, attr,
 					actions, &rss_conf, error);
@@ -1906,7 +350,6 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
 		struct rte_flow_error *error)
 {
 	struct ixgbe_adapter *ad = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
-	struct ixgbe_fdir_rule fdir_rule;
 	struct ixgbe_rte_flow_rss_conf rss_conf;
 	int ret;
 
@@ -1917,12 +360,6 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
 
 	/* fall back to legacy engines */
 
-	memset(&fdir_rule, 0, sizeof(struct ixgbe_fdir_rule));
-	ret = ixgbe_parse_fdir_filter(dev, attr, pattern,
-				actions, &fdir_rule, error);
-	if (!ret)
-		return 0;
-
 	memset(&rss_conf, 0, sizeof(struct ixgbe_rte_flow_rss_conf));
 	ret = ixgbe_parse_rss_filter(dev, attr,
 					actions, &rss_conf, error);
@@ -1941,12 +378,7 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 		IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct rte_flow *pmd_flow = flow;
 	enum rte_filter_type filter_type = pmd_flow->filter_type;
-	struct ixgbe_fdir_rule fdir_rule;
-	struct ixgbe_fdir_rule_ele *fdir_rule_ptr;
 	struct ixgbe_filter_ele_base *flow_mem_base;
-	struct ixgbe_hw_fdir_info *fdir_info =
-		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter);
-	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
 	struct ixgbe_rss_conf_ele *rss_filter_ptr;
 
 	/* try the new flow engine first */
@@ -1971,20 +403,6 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 	}
 
 	switch (filter_type) {
-	case RTE_ETH_FILTER_FDIR:
-		fdir_rule_ptr = (struct ixgbe_fdir_rule_ele *)pmd_flow->rule;
-		fdir_rule = fdir_rule_ptr->filter_info;
-		ret = ixgbe_fdir_filter_program(adapter, fdir_conf, &fdir_rule, TRUE, FALSE);
-		if (!ret) {
-			rte_free(fdir_rule_ptr);
-			if (fdir_info->n_flows > 0 && --(fdir_info->n_flows) == 0) {
-				fdir_info->mask_added = false;
-				fdir_info->mask = (struct ixgbe_hw_fdir_mask){0};
-				fdir_info->flex_bytes_offset = 0;
-				fdir_conf->mode = RTE_FDIR_MODE_NONE;
-			}
-		}
-		break;
 	case RTE_ETH_FILTER_HASH:
 		rss_filter_ptr = (struct ixgbe_rss_conf_ele *)
 				pmd_flow->rule;
@@ -2029,13 +447,6 @@ ixgbe_flow_flush(struct rte_eth_dev *dev,
 		return ret;
 	}
 
-	ret = ixgbe_clear_all_fdir_filter(dev);
-	if (ret < 0) {
-		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_HANDLE,
-					NULL, "Failed to flush rule");
-		return ret;
-	}
-
 	ixgbe_clear_rss_filter(dev);
 
 	ixgbe_filterlist_flush(dev);
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.h b/drivers/net/intel/ixgbe/ixgbe_flow.h
index 87cf0282454..256e0478f58 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.h
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.h
@@ -20,5 +20,7 @@ extern const struct ci_flow_engine ixgbe_syn_flow_engine;
 extern const struct ci_flow_engine ixgbe_l2_tunnel_flow_engine;
 extern const struct ci_flow_engine ixgbe_ntuple_flow_engine;
 extern const struct ci_flow_engine ixgbe_security_flow_engine;
+extern const struct ci_flow_engine ixgbe_fdir_flow_engine;
+extern const struct ci_flow_engine ixgbe_fdir_tunnel_flow_engine;
 
 #endif /*  _IXGBE_FLOW_H_ */
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow_fdir.c b/drivers/net/intel/ixgbe/ixgbe_flow_fdir.c
new file mode 100644
index 00000000000..a2a6d65fc1a
--- /dev/null
+++ b/drivers/net/intel/ixgbe/ixgbe_flow_fdir.c
@@ -0,0 +1,1626 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+#include <rte_common.h>
+#include <rte_flow.h>
+#include <flow_graph.h>
+#include <rte_ether.h>
+#include <rte_hash.h>
+
+#include "ixgbe_ethdev.h"
+#include "ixgbe_flow.h"
+#include "../common/flow_check.h"
+#include "../common/flow_util.h"
+#include "../common/flow_engine.h"
+
+struct ixgbe_fdir_flow {
+	struct rte_flow flow;
+	struct ixgbe_fdir_rule rule;
+	/* resolved at ctx_to_flow time, written to hardware at install time */
+	uint32_t fdirhash;
+	uint32_t fdircmd_flags;
+	uint8_t queue;
+};
+
+/* both fdir engines get their own priv, all pointing at the same shared state */
+struct ixgbe_fdir_priv {
+	struct ixgbe_fdir_state *state;
+	/* hardware capabilities, resolved once at engine_init */
+	bool supports_sctp_ports;
+	bool supports_mac_vlan_mode;
+};
+
+struct ixgbe_fdir_ctx {
+	struct ci_flow_engine_ctx base;
+	struct ixgbe_fdir_rule rule;
+	bool supports_sctp_ports;
+	bool supports_mac_vlan_mode;
+	const struct rte_flow_action *fwd_action;
+	const struct rte_flow_action *aux_action;
+};
+
+#define IXGBE_FDIR_VLAN_TCI_MASK	rte_cpu_to_be_16(0xEFFF)
+#define NVGRE_FLAGS 0x2000
+#define NVGRE_PROTOCOL 0x6558
+
+/**
+ * FDIR normal graph implementation
+ * Pattern: START -> [ETH] -> (IPv4|IPv6) -> [TCP|UDP|SCTP] -> [RAW] -> END
+ * Pattern: START -> ETH -> VLAN -> END
+ */
+
+enum ixgbe_fdir_normal_node_id {
+	IXGBE_FDIR_NORMAL_NODE_START = FLOW_GRAPH_NODE_FIRST,
+	IXGBE_FDIR_NORMAL_NODE_ETH,
+	IXGBE_FDIR_NORMAL_NODE_VLAN,
+	IXGBE_FDIR_NORMAL_NODE_IPV4,
+	IXGBE_FDIR_NORMAL_NODE_IPV6,
+	IXGBE_FDIR_NORMAL_NODE_TCP,
+	IXGBE_FDIR_NORMAL_NODE_UDP,
+	IXGBE_FDIR_NORMAL_NODE_SCTP,
+	IXGBE_FDIR_NORMAL_NODE_RAW,
+	IXGBE_FDIR_NORMAL_NODE_END,
+	IXGBE_FDIR_NORMAL_NODE_MAX,
+};
+
+static int
+ixgbe_validate_fdir_normal_eth(const void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error)
+{
+	const struct ixgbe_fdir_ctx *fdir_ctx = (const struct ixgbe_fdir_ctx *)ctx;
+	const struct rte_flow_item_eth *eth_mask = ci_flow_item_mask(item);
+
+	if (eth_mask == NULL)
+		return 0;
+
+	/* we cannot have ETH item in signature mode */
+	if (fdir_ctx->rule.mode == RTE_FDIR_MODE_SIGNATURE) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"ETH item not supported in signature mode");
+	}
+	/* ETH item selects mac-vlan mode, only supported on x550/E610 */
+	if (!fdir_ctx->supports_mac_vlan_mode) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"ETH item not supported on this hardware");
+	}
+	/* ethertype isn't supported by FDIR */
+	if (!CI_FIELD_IS_ZERO(&eth_mask->hdr.ether_type)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Ethertype filtering not supported");
+	}
+	/* source address mask must be all zeroes */
+	if (!CI_FIELD_IS_ZERO(&eth_mask->hdr.src_addr)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Source MAC filtering not supported");
+	}
+	/* destination address mask must be all ones */
+	if (!CI_FIELD_IS_MASKED(&eth_mask->hdr.dst_addr)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Destination MAC filtering must be exact match");
+	}
+	return 0;
+}
+
+static int
+ixgbe_process_fdir_normal_eth(void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+	const struct rte_flow_item_eth *eth_spec = item->spec;
+	const struct rte_flow_item_eth *eth_mask = ci_flow_item_mask(item);
+
+	if (eth_mask == NULL)
+		return 0;
+
+	/* copy dst MAC */
+	rule->b_spec = TRUE;
+	memcpy(rule->ixgbe_fdir.formatted.inner_mac, eth_spec->hdr.dst_addr.addr_bytes,
+			RTE_ETHER_ADDR_LEN);
+
+	/* set tunnel type */
+	rule->mode = RTE_FDIR_MODE_PERFECT_MAC_VLAN;
+	/* when no VLAN specified, set full mask */
+	rule->b_mask = TRUE;
+	rule->mask.vlan_tci_mask = IXGBE_FDIR_VLAN_TCI_MASK;
+
+	return 0;
+}
+
+static int
+ixgbe_process_fdir_normal_vlan(void *ctx, const struct rte_flow_item *item,
+		struct rte_flow_error *error __rte_unused)
+{
+	const struct rte_flow_item_vlan *vlan_spec = item->spec;
+	const struct rte_flow_item_vlan *vlan_mask = ci_flow_item_mask(item);
+	struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+
+	rule->ixgbe_fdir.formatted.vlan_id = vlan_spec->hdr.vlan_tci;
+
+	rule->mask.vlan_tci_mask = vlan_mask->hdr.vlan_tci;
+	rule->mask.vlan_tci_mask &= IXGBE_FDIR_VLAN_TCI_MASK;
+
+	return 0;
+}
+
+static int
+ixgbe_validate_fdir_normal_ipv4(const void *ctx,
+			    const struct rte_flow_item *item,
+			    struct rte_flow_error *error)
+{
+	const struct rte_flow_item_ipv4 *ipv4_mask = ci_flow_item_mask(item);
+	const struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	const struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+
+	if (rule->mode == RTE_FDIR_MODE_PERFECT_MAC_VLAN) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"IPv4 not supported with ETH/VLAN items");
+	}
+
+	if (ipv4_mask->hdr.version_ihl ||
+	    ipv4_mask->hdr.type_of_service ||
+	    ipv4_mask->hdr.total_length ||
+	    ipv4_mask->hdr.packet_id ||
+	    ipv4_mask->hdr.fragment_offset ||
+	    ipv4_mask->hdr.time_to_live ||
+	    ipv4_mask->hdr.next_proto_id ||
+	    ipv4_mask->hdr.hdr_checksum) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Only src/dst addresses supported");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_process_fdir_normal_ipv4(void *ctx,
+			   const struct rte_flow_item *item,
+			   struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	const struct rte_flow_item_ipv4 *ipv4_spec = item->spec;
+	const struct rte_flow_item_ipv4 *ipv4_mask = ci_flow_item_mask(item);
+	struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+
+	rule->ixgbe_fdir.formatted.flow_type = IXGBE_ATR_FLOW_TYPE_IPV4;
+
+	rule->b_spec = TRUE;
+	rule->ixgbe_fdir.formatted.dst_ip[0] = ipv4_spec->hdr.dst_addr;
+	rule->ixgbe_fdir.formatted.src_ip[0] = ipv4_spec->hdr.src_addr;
+
+	rule->b_mask = TRUE;
+	rule->mask.dst_ipv4_mask = ipv4_mask->hdr.dst_addr;
+	rule->mask.src_ipv4_mask = ipv4_mask->hdr.src_addr;
+
+	return 0;
+}
+
+static int
+ixgbe_validate_fdir_normal_ipv6(const void *ctx,
+			    const struct rte_flow_item *item,
+			    struct rte_flow_error *error)
+{
+	const struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	const struct rte_flow_item_ipv6 *ipv6_mask = ci_flow_item_mask(item);
+	const struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+
+	if (rule->mode == RTE_FDIR_MODE_PERFECT_MAC_VLAN) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"IPv6 not supported with ETH/VLAN items");
+	}
+
+	if (rule->mode != RTE_FDIR_MODE_SIGNATURE) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"IPv6 only supported in signature mode");
+	}
+
+	if (ipv6_mask->hdr.vtc_flow ||
+	    ipv6_mask->hdr.payload_len ||
+	    ipv6_mask->hdr.proto ||
+	    ipv6_mask->hdr.hop_limits) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Only src/dst addresses supported");
+	}
+
+	if (!CI_FIELD_IS_ZERO_OR_MASKED(&ipv6_mask->hdr.src_addr)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Partial src address masks not supported");
+	}
+	if (!CI_FIELD_IS_ZERO_OR_MASKED(&ipv6_mask->hdr.dst_addr)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Partial dst address masks not supported");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_process_fdir_normal_ipv6(void *ctx,
+			   const struct rte_flow_item *item,
+			   struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	const struct rte_flow_item_ipv6 *ipv6_spec = item->spec;
+	const struct rte_flow_item_ipv6 *ipv6_mask = ci_flow_item_mask(item);
+	struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+	uint8_t j;
+
+	rule->ixgbe_fdir.formatted.flow_type = IXGBE_ATR_FLOW_TYPE_IPV6;
+
+	rule->b_spec = TRUE;
+	memcpy(rule->ixgbe_fdir.formatted.src_ip, &ipv6_spec->hdr.src_addr,
+			sizeof(struct rte_ipv6_addr));
+	memcpy(rule->ixgbe_fdir.formatted.dst_ip, &ipv6_spec->hdr.dst_addr,
+			sizeof(struct rte_ipv6_addr));
+
+	rule->b_mask = TRUE;
+	for (j = 0; j < sizeof(struct rte_ipv6_addr); j++) {
+		if (ipv6_mask->hdr.src_addr.a[j] == 0)
+			rule->mask.src_ipv6_mask &= ~(1 << j);
+		if (ipv6_mask->hdr.dst_addr.a[j] == 0)
+			rule->mask.dst_ipv6_mask &= ~(1 << j);
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_validate_fdir_normal_tcp(const void *ctx,
+			   const struct rte_flow_item *item,
+			   struct rte_flow_error *error)
+{
+	const struct rte_flow_item_tcp *tcp_mask = ci_flow_item_mask(item);
+	const struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	const struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+
+	if (rule->mode == RTE_FDIR_MODE_PERFECT_MAC_VLAN) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"TCP not supported with ETH/VLAN items");
+	}
+
+	if (tcp_mask == NULL)
+		return 0;
+
+	if (tcp_mask->hdr.sent_seq ||
+	    tcp_mask->hdr.recv_ack ||
+	    tcp_mask->hdr.data_off ||
+	    tcp_mask->hdr.tcp_flags ||
+	    tcp_mask->hdr.rx_win ||
+	    tcp_mask->hdr.cksum ||
+	    tcp_mask->hdr.tcp_urp) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Only src/dst ports supported");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_process_fdir_normal_tcp(void *ctx,
+			  const struct rte_flow_item *item,
+			  struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	const struct rte_flow_item_tcp *tcp_spec = item->spec;
+	const struct rte_flow_item_tcp *tcp_mask = ci_flow_item_mask(item);
+	struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+
+	rule->ixgbe_fdir.formatted.flow_type |= IXGBE_ATR_L4TYPE_TCP;
+
+	if (tcp_mask == NULL)
+		return 0;
+
+	rule->b_mask = TRUE;
+	rule->mask.src_port_mask = tcp_mask->hdr.src_port;
+	rule->mask.dst_port_mask = tcp_mask->hdr.dst_port;
+
+	rule->b_spec = TRUE;
+	rule->ixgbe_fdir.formatted.src_port = tcp_spec->hdr.src_port;
+	rule->ixgbe_fdir.formatted.dst_port = tcp_spec->hdr.dst_port;
+
+	return 0;
+}
+
+static int
+ixgbe_validate_fdir_normal_udp(const void *ctx,
+			   const struct rte_flow_item *item,
+			   struct rte_flow_error *error)
+{
+	const struct rte_flow_item_udp *udp_mask = ci_flow_item_mask(item);
+	const struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	const struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+
+	if (rule->mode == RTE_FDIR_MODE_PERFECT_MAC_VLAN) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"UDP not supported with ETH/VLAN items");
+	}
+
+	if (udp_mask == NULL)
+		return 0;
+
+	if (udp_mask->hdr.dgram_len ||
+	    udp_mask->hdr.dgram_cksum) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Only src/dst ports supported");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_process_fdir_normal_udp(void *ctx,
+			  const struct rte_flow_item *item,
+			  struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	const struct rte_flow_item_udp *udp_spec = item->spec;
+	const struct rte_flow_item_udp *udp_mask = ci_flow_item_mask(item);
+	struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+
+	rule->ixgbe_fdir.formatted.flow_type |= IXGBE_ATR_L4TYPE_UDP;
+
+	if (udp_mask == NULL)
+		return 0;
+
+	rule->b_mask = TRUE;
+	rule->mask.src_port_mask = udp_mask->hdr.src_port;
+	rule->mask.dst_port_mask = udp_mask->hdr.dst_port;
+
+	rule->b_spec = TRUE;
+	rule->ixgbe_fdir.formatted.src_port = udp_spec->hdr.src_port;
+	rule->ixgbe_fdir.formatted.dst_port = udp_spec->hdr.dst_port;
+
+	return 0;
+}
+
+static int
+ixgbe_validate_fdir_normal_sctp(const void *ctx,
+			    const struct rte_flow_item *item,
+			    struct rte_flow_error *error)
+{
+	const struct rte_flow_item_sctp *sctp_mask = ci_flow_item_mask(item);
+	const struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	const struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+
+	if (rule->mode == RTE_FDIR_MODE_PERFECT_MAC_VLAN) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"SCTP not supported with ETH/VLAN items");
+	}
+
+	if (sctp_mask == NULL)
+		return 0;
+
+	/* Tag and checksum not supported */
+	if (sctp_mask->hdr.tag ||
+	    sctp_mask->hdr.cksum) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"SCTP tag/cksum not supported");
+	}
+
+	/*
+	 * SCTP mask is not NULL, which means we are potentially looking at
+	 * masking SCTP ports, so check hardware support.
+	 */
+	if (!fdir_ctx->supports_sctp_ports) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"SCTP port filtering not supported by hardware");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_process_fdir_normal_sctp(void *ctx,
+			   const struct rte_flow_item *item,
+			   struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	const struct rte_flow_item_sctp *sctp_spec = item->spec;
+	const struct rte_flow_item_sctp *sctp_mask = ci_flow_item_mask(item);
+	struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+
+	rule->ixgbe_fdir.formatted.flow_type |= IXGBE_ATR_L4TYPE_SCTP;
+
+	if (sctp_mask == NULL)
+		return 0;
+
+	rule->b_mask = TRUE;
+	rule->mask.src_port_mask = sctp_mask->hdr.src_port;
+	rule->mask.dst_port_mask = sctp_mask->hdr.dst_port;
+
+	rule->b_spec = TRUE;
+	rule->ixgbe_fdir.formatted.src_port = sctp_spec->hdr.src_port;
+	rule->ixgbe_fdir.formatted.dst_port = sctp_spec->hdr.dst_port;
+
+	return 0;
+}
+
+static int
+ixgbe_validate_fdir_normal_raw(const void *ctx __rte_unused,
+			   const struct rte_flow_item *item,
+			   struct rte_flow_error *error)
+{
+	const struct rte_flow_item_raw *raw_spec;
+	const struct rte_flow_item_raw *raw_mask;
+
+	raw_spec = item->spec;
+	raw_mask = item->mask;
+
+	if (raw_mask == NULL) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"RAW item requires an explicit mask");
+	}
+
+	if (raw_spec->pattern == NULL) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid RAW spec");
+	}
+
+	if (raw_mask->pattern == NULL) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid RAW mask");
+	}
+
+	if (raw_mask->length != raw_spec->length &&
+			raw_mask->length != 0xffff) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid RAW mask");
+	}
+
+	if (raw_mask->relative != 0x1 ||
+	    raw_mask->search != 0x1 ||
+	    raw_mask->reserved != 0x0 ||
+	    (uint32_t)raw_mask->offset != 0xffffffff ||
+	    raw_mask->limit != 0xffff) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid RAW mask");
+	}
+
+	if (raw_spec->relative != 0 ||
+	    raw_spec->search != 0 ||
+	    raw_spec->reserved != 0 ||
+	    raw_spec->offset > IXGBE_MAX_FLX_SOURCE_OFF ||
+	    raw_spec->offset % 2 ||
+	    raw_spec->limit != 0 ||
+	    raw_spec->length != 2 ||
+	    (raw_spec->pattern[0] == 0xff &&
+	     raw_spec->pattern[1] == 0xff)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Invalid RAW spec");
+	}
+
+	if (raw_mask->pattern[0] != 0xff ||
+	    raw_mask->pattern[1] != 0xff) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"RAW pattern must be fully masked");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_process_fdir_normal_raw(void *ctx,
+			  const struct rte_flow_item *item,
+			  struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	const struct rte_flow_item_raw *raw_spec = item->spec;
+	struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+
+	rule->b_spec = TRUE;
+	rule->ixgbe_fdir.formatted.flex_bytes =
+		(((uint16_t)raw_spec->pattern[1]) << 8) | raw_spec->pattern[0];
+	rule->flex_bytes_offset = raw_spec->offset;
+
+	rule->b_mask = TRUE;
+	rule->mask.flex_bytes_mask = 0xffff;
+
+	return 0;
+}
+
+static int
+ixgbe_process_fdir_normal_end(void *ctx, const struct rte_flow_item *item __rte_unused,
+			  struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+
+	/* check if we need L4 protocol */
+	if (fdir_ctx->rule.ixgbe_fdir.formatted.flow_type & IXGBE_ATR_L4TYPE_MASK)
+		fdir_ctx->rule.mask.l4_proto_match = 1;
+
+	return 0;
+}
+
+static const struct flow_graph ixgbe_fdir_normal_graph = {
+	.ignore_nodes = (enum rte_flow_item_type[]) {
+		RTE_FLOW_ITEM_TYPE_FUZZY,
+		RTE_FLOW_ITEM_TYPE_END,
+	},
+	.nodes = (struct flow_graph_node[]) {
+		[IXGBE_FDIR_NORMAL_NODE_START] = {
+			.name = "START",
+		},
+		[IXGBE_FDIR_NORMAL_NODE_ETH] = {
+			.name = "ETH",
+			.type = RTE_FLOW_ITEM_TYPE_ETH,
+			.validate = ixgbe_validate_fdir_normal_eth,
+			.process = ixgbe_process_fdir_normal_eth,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY |
+			               FLOW_GRAPH_NODE_EXPECT_SPEC,
+		},
+		[IXGBE_FDIR_NORMAL_NODE_VLAN] = {
+			.name = "VLAN",
+			.type = RTE_FLOW_ITEM_TYPE_VLAN,
+			.process = ixgbe_process_fdir_normal_vlan,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_SPEC,
+		},
+		[IXGBE_FDIR_NORMAL_NODE_IPV4] = {
+			.name = "IPV4",
+			.type = RTE_FLOW_ITEM_TYPE_IPV4,
+			.validate = ixgbe_validate_fdir_normal_ipv4,
+			.process = ixgbe_process_fdir_normal_ipv4,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_SPEC,
+		},
+		[IXGBE_FDIR_NORMAL_NODE_IPV6] = {
+			.name = "IPV6",
+			.type = RTE_FLOW_ITEM_TYPE_IPV6,
+			.validate = ixgbe_validate_fdir_normal_ipv6,
+			.process = ixgbe_process_fdir_normal_ipv6,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_SPEC,
+		},
+		[IXGBE_FDIR_NORMAL_NODE_TCP] = {
+			.name = "TCP",
+			.type = RTE_FLOW_ITEM_TYPE_TCP,
+			.validate = ixgbe_validate_fdir_normal_tcp,
+			.process = ixgbe_process_fdir_normal_tcp,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY |
+			               FLOW_GRAPH_NODE_EXPECT_SPEC,
+		},
+		[IXGBE_FDIR_NORMAL_NODE_UDP] = {
+			.name = "UDP",
+			.type = RTE_FLOW_ITEM_TYPE_UDP,
+			.validate = ixgbe_validate_fdir_normal_udp,
+			.process = ixgbe_process_fdir_normal_udp,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY |
+			               FLOW_GRAPH_NODE_EXPECT_SPEC,
+		},
+		[IXGBE_FDIR_NORMAL_NODE_SCTP] = {
+			.name = "SCTP",
+			.type = RTE_FLOW_ITEM_TYPE_SCTP,
+			.validate = ixgbe_validate_fdir_normal_sctp,
+			.process = ixgbe_process_fdir_normal_sctp,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY |
+				       FLOW_GRAPH_NODE_EXPECT_SPEC,
+		},
+		[IXGBE_FDIR_NORMAL_NODE_RAW] = {
+			.name = "RAW",
+			.type = RTE_FLOW_ITEM_TYPE_RAW,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_SPEC,
+			.validate = ixgbe_validate_fdir_normal_raw,
+			.process = ixgbe_process_fdir_normal_raw,
+		},
+		[IXGBE_FDIR_NORMAL_NODE_END] = {
+			.name = "END",
+			.type = RTE_FLOW_ITEM_TYPE_END,
+			.process = ixgbe_process_fdir_normal_end,
+		},
+	},
+	.edges = (struct flow_graph_edge[]) {
+		[IXGBE_FDIR_NORMAL_NODE_START] = {
+			.next = (size_t[]) {
+				IXGBE_FDIR_NORMAL_NODE_ETH,
+				IXGBE_FDIR_NORMAL_NODE_IPV4,
+				IXGBE_FDIR_NORMAL_NODE_IPV6,
+				IXGBE_FDIR_NORMAL_NODE_TCP,
+				IXGBE_FDIR_NORMAL_NODE_UDP,
+				IXGBE_FDIR_NORMAL_NODE_SCTP,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_NORMAL_NODE_ETH] = {
+			.next = (size_t[]) {
+				IXGBE_FDIR_NORMAL_NODE_VLAN,
+				IXGBE_FDIR_NORMAL_NODE_IPV4,
+				IXGBE_FDIR_NORMAL_NODE_IPV6,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_NORMAL_NODE_VLAN] = {
+			.next = (size_t[]) {
+				IXGBE_FDIR_NORMAL_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_NORMAL_NODE_IPV4] = {
+			.next = (size_t[]) {
+				IXGBE_FDIR_NORMAL_NODE_TCP,
+				IXGBE_FDIR_NORMAL_NODE_UDP,
+				IXGBE_FDIR_NORMAL_NODE_SCTP,
+				IXGBE_FDIR_NORMAL_NODE_RAW,
+				IXGBE_FDIR_NORMAL_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_NORMAL_NODE_IPV6] = {
+			.next = (size_t[]) {
+				IXGBE_FDIR_NORMAL_NODE_TCP,
+				IXGBE_FDIR_NORMAL_NODE_UDP,
+				IXGBE_FDIR_NORMAL_NODE_SCTP,
+				IXGBE_FDIR_NORMAL_NODE_RAW,
+				IXGBE_FDIR_NORMAL_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_NORMAL_NODE_TCP] = {
+			.next = (size_t[]) {
+				IXGBE_FDIR_NORMAL_NODE_RAW,
+				IXGBE_FDIR_NORMAL_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_NORMAL_NODE_UDP] = {
+			.next = (size_t[]) {
+				IXGBE_FDIR_NORMAL_NODE_RAW,
+				IXGBE_FDIR_NORMAL_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_NORMAL_NODE_SCTP] = {
+			.next = (size_t[]) {
+				IXGBE_FDIR_NORMAL_NODE_RAW,
+				IXGBE_FDIR_NORMAL_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_NORMAL_NODE_RAW] = {
+			.next = (size_t[]) {
+				IXGBE_FDIR_NORMAL_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+	},
+};
+
+/**
+ * FDIR tunnel graph implementation (VxLAN and NVGRE)
+ * Pattern: START -> [OUTER_ETH] -> (OUTER_IPv4|OUTER_IPv6) -> [UDP] -> (VXLAN|NVGRE) -> INNER_ETH -> [VLAN] -> END
+ * VxLAN:  START -> [OUTER_ETH] -> (OUTER_IPv4|OUTER_IPv6) -> UDP -> VXLAN -> INNER_ETH -> [VLAN] -> END
+ * NVGRE:  START -> [OUTER_ETH] -> (OUTER_IPv4|OUTER_IPv6) -> NVGRE -> INNER_ETH -> [VLAN] -> END
+ */
+
+enum ixgbe_fdir_tunnel_node_id {
+	IXGBE_FDIR_TUNNEL_NODE_START = FLOW_GRAPH_NODE_FIRST,
+	IXGBE_FDIR_TUNNEL_NODE_OUTER_ETH,
+	IXGBE_FDIR_TUNNEL_NODE_OUTER_IPV4,
+	IXGBE_FDIR_TUNNEL_NODE_OUTER_IPV6,
+	IXGBE_FDIR_TUNNEL_NODE_UDP,
+	IXGBE_FDIR_TUNNEL_NODE_VXLAN,
+	IXGBE_FDIR_TUNNEL_NODE_NVGRE,
+	IXGBE_FDIR_TUNNEL_NODE_INNER_ETH,
+	IXGBE_FDIR_TUNNEL_NODE_INNER_IPV4,
+	IXGBE_FDIR_TUNNEL_NODE_VLAN,
+	IXGBE_FDIR_TUNNEL_NODE_END,
+	IXGBE_FDIR_TUNNEL_NODE_MAX,
+};
+
+static int
+ixgbe_validate_fdir_tunnel_vxlan(const void *ctx __rte_unused,
+				 const struct rte_flow_item *item,
+				 struct rte_flow_error *error)
+{
+	const struct rte_flow_item_vxlan *vxlan_mask = ci_flow_item_mask(item);
+
+	if (vxlan_mask->hdr.flags) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"VxLAN flags must be masked");
+	}
+
+	if (!CI_FIELD_IS_ZERO_OR_MASKED(&vxlan_mask->hdr.vni)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Partial VNI mask not supported");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_process_fdir_tunnel_vxlan(void *ctx,
+				const struct rte_flow_item *item,
+				struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	const struct rte_flow_item_vxlan *vxlan_spec = item->spec;
+	const struct rte_flow_item_vxlan *vxlan_mask = ci_flow_item_mask(item);
+	struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+
+	rule->ixgbe_fdir.formatted.tunnel_type = IXGBE_FDIR_VXLAN_TUNNEL_TYPE;
+
+	rule->b_spec = TRUE;
+	memcpy(((uint8_t *)&rule->ixgbe_fdir.formatted.tni_vni), vxlan_spec->hdr.vni,
+			RTE_DIM(vxlan_spec->hdr.vni));
+
+	rule->b_mask = TRUE;
+	rule->mask.tunnel_type_mask = 1;
+	memcpy(&rule->mask.tunnel_id_mask, vxlan_mask->hdr.vni, RTE_DIM(vxlan_mask->hdr.vni));
+
+	return 0;
+}
+
+static int
+ixgbe_validate_fdir_tunnel_nvgre(const void *ctx __rte_unused,
+				 const struct rte_flow_item *item,
+				 struct rte_flow_error *error)
+{
+	const struct rte_flow_item_nvgre *nvgre_spec = item->spec;
+	const struct rte_flow_item_nvgre *nvgre_mask = ci_flow_item_mask(item);
+
+	if (nvgre_mask->flow_id) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"NVGRE flow ID must not be masked");
+	}
+
+	if (!CI_FIELD_IS_ZERO_OR_MASKED(&nvgre_mask->protocol)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"NVGRE protocol must be fully masked or unmasked");
+	}
+
+	if (!CI_FIELD_IS_ZERO_OR_MASKED(&nvgre_mask->c_k_s_rsvd0_ver)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"NVGRE flags must be fully masked or unmasked");
+	}
+
+	if (!CI_FIELD_IS_ZERO_OR_MASKED(&nvgre_mask->tni)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Partial TNI mask not supported");
+	}
+
+	if (nvgre_mask->c_k_s_rsvd0_ver &&
+	    nvgre_spec->c_k_s_rsvd0_ver != rte_cpu_to_be_16(NVGRE_FLAGS)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"NVGRE flags must be 0x2000");
+	}
+	if (nvgre_mask->protocol &&
+	    nvgre_spec->protocol != rte_cpu_to_be_16(NVGRE_PROTOCOL)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"NVGRE protocol must be 0x6558");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_process_fdir_tunnel_nvgre(void *ctx,
+				const struct rte_flow_item *item,
+				struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	const struct rte_flow_item_nvgre *nvgre_spec = item->spec;
+	const struct rte_flow_item_nvgre *nvgre_mask = ci_flow_item_mask(item);
+	struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+
+	rule->ixgbe_fdir.formatted.tunnel_type = IXGBE_FDIR_NVGRE_TUNNEL_TYPE;
+
+	rule->b_spec = TRUE;
+	memcpy(&fdir_ctx->rule.ixgbe_fdir.formatted.tni_vni,
+			nvgre_spec->tni, RTE_DIM(nvgre_spec->tni));
+
+	rule->b_mask = TRUE;
+	rule->mask.tunnel_type_mask = 1;
+	memcpy(&rule->mask.tunnel_id_mask, nvgre_mask->tni, RTE_DIM(nvgre_mask->tni));
+	rule->mask.tunnel_id_mask <<= 8;
+	return 0;
+}
+
+static int
+ixgbe_validate_fdir_tunnel_inner_eth(const void *ctx __rte_unused,
+				     const struct rte_flow_item *item,
+				     struct rte_flow_error *error)
+{
+	const struct rte_flow_item_eth *eth_mask = ci_flow_item_mask(item);
+
+	if (eth_mask->hdr.ether_type != 0) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Ether type mask not supported");
+	}
+
+	/* src addr must not be masked */
+	if (!CI_FIELD_IS_ZERO(&eth_mask->hdr.src_addr)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Masking not supported for src MAC address");
+	}
+
+	/* dst addr must be either fully masked or fully unmasked */
+	if (!CI_FIELD_IS_ZERO_OR_MASKED(&eth_mask->hdr.dst_addr)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"Partial masks not supported for dst MAC address");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_process_fdir_tunnel_inner_eth(void *ctx,
+				    const struct rte_flow_item *item,
+				    struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	const struct rte_flow_item_eth *eth_spec = item->spec;
+	const struct rte_flow_item_eth *eth_mask = ci_flow_item_mask(item);
+	struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+	uint8_t j;
+
+	rule->b_spec = TRUE;
+	memcpy(&rule->ixgbe_fdir.formatted.inner_mac,
+			eth_spec->hdr.dst_addr.addr_bytes,
+			RTE_ETHER_ADDR_LEN);
+
+	rule->b_mask = TRUE;
+	rule->mask.mac_addr_byte_mask = 0;
+	for (j = 0; j < RTE_ETHER_ADDR_LEN; j++) {
+		if (eth_mask->hdr.dst_addr.addr_bytes[j] == 0xFF) {
+			rule->mask.mac_addr_byte_mask |= 0x1 << j;
+		}
+	}
+
+	/* When no vlan, considered as full mask. */
+	rule->mask.vlan_tci_mask = IXGBE_FDIR_VLAN_TCI_MASK;
+
+	return 0;
+}
+
+static int
+ixgbe_process_fdir_tunnel_vlan(void *ctx,
+			       const struct rte_flow_item *item,
+			       struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_fdir_ctx *fdir_ctx = ctx;
+	const struct rte_flow_item_vlan *vlan_spec = item->spec;
+	const struct rte_flow_item_vlan *vlan_mask = ci_flow_item_mask(item);
+	struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+
+	rule->ixgbe_fdir.formatted.vlan_id = vlan_spec->hdr.vlan_tci;
+
+	rule->mask.vlan_tci_mask = vlan_mask->hdr.vlan_tci;
+	rule->mask.vlan_tci_mask &= IXGBE_FDIR_VLAN_TCI_MASK;
+
+	return 0;
+}
+
+static const struct flow_graph ixgbe_fdir_tunnel_graph = {
+	.nodes = (struct flow_graph_node[]) {
+		[IXGBE_FDIR_TUNNEL_NODE_START] = {
+			.name = "START",
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_OUTER_ETH] = {
+			.name = "OUTER_ETH",
+			.type = RTE_FLOW_ITEM_TYPE_ETH,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY,
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_OUTER_IPV4] = {
+			.name = "OUTER_IPV4",
+			.type = RTE_FLOW_ITEM_TYPE_IPV4,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY,
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_OUTER_IPV6] = {
+			.name = "OUTER_IPV6",
+			.type = RTE_FLOW_ITEM_TYPE_IPV6,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY,
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_UDP] = {
+			.name = "UDP",
+			.type = RTE_FLOW_ITEM_TYPE_UDP,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY,
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_VXLAN] = {
+			.name = "VXLAN",
+			.type = RTE_FLOW_ITEM_TYPE_VXLAN,
+			.validate = ixgbe_validate_fdir_tunnel_vxlan,
+			.process = ixgbe_process_fdir_tunnel_vxlan,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_SPEC,
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_NVGRE] = {
+			.name = "NVGRE",
+			.type = RTE_FLOW_ITEM_TYPE_NVGRE,
+			.validate = ixgbe_validate_fdir_tunnel_nvgre,
+			.process = ixgbe_process_fdir_tunnel_nvgre,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_SPEC,
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_INNER_ETH] = {
+			.name = "INNER_ETH",
+			.type = RTE_FLOW_ITEM_TYPE_ETH,
+			.validate = ixgbe_validate_fdir_tunnel_inner_eth,
+			.process = ixgbe_process_fdir_tunnel_inner_eth,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_SPEC,
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_INNER_IPV4] = {
+			.name = "INNER_IPV4",
+			.type = RTE_FLOW_ITEM_TYPE_IPV4,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY,
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_VLAN] = {
+			.name = "VLAN",
+			.type = RTE_FLOW_ITEM_TYPE_VLAN,
+			.process = ixgbe_process_fdir_tunnel_vlan,
+			.constraints = FLOW_GRAPH_NODE_EXPECT_SPEC,
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_END] = {
+			.name = "END",
+			.type = RTE_FLOW_ITEM_TYPE_END,
+		},
+	},
+	.edges = (struct flow_graph_edge[]) {
+		[IXGBE_FDIR_TUNNEL_NODE_START] = {
+			.next = (size_t[]) {
+				IXGBE_FDIR_TUNNEL_NODE_OUTER_ETH,
+				IXGBE_FDIR_TUNNEL_NODE_OUTER_IPV4,
+				IXGBE_FDIR_TUNNEL_NODE_OUTER_IPV6,
+				IXGBE_FDIR_TUNNEL_NODE_UDP,
+				IXGBE_FDIR_TUNNEL_NODE_VXLAN,
+				IXGBE_FDIR_TUNNEL_NODE_NVGRE,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_OUTER_ETH] = {
+			.next = (size_t[]) {
+				IXGBE_FDIR_TUNNEL_NODE_OUTER_IPV4,
+				IXGBE_FDIR_TUNNEL_NODE_OUTER_IPV6,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_OUTER_IPV4] = {
+			.next = (size_t[]) {
+				IXGBE_FDIR_TUNNEL_NODE_UDP,
+				IXGBE_FDIR_TUNNEL_NODE_NVGRE,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_OUTER_IPV6] = {
+			.next = (size_t[]) {
+				IXGBE_FDIR_TUNNEL_NODE_UDP,
+				IXGBE_FDIR_TUNNEL_NODE_NVGRE,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_UDP] = {
+			.next = (size_t[]) {
+				IXGBE_FDIR_TUNNEL_NODE_VXLAN,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_VXLAN] = {
+			.next = (size_t[]) {
+				IXGBE_FDIR_TUNNEL_NODE_INNER_ETH,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_NVGRE] = {
+			.next = (size_t[]) {
+				IXGBE_FDIR_TUNNEL_NODE_INNER_ETH,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_INNER_ETH] = {
+			.next = (size_t[]) {
+				IXGBE_FDIR_TUNNEL_NODE_VLAN,
+				IXGBE_FDIR_TUNNEL_NODE_INNER_IPV4,
+				IXGBE_FDIR_TUNNEL_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+		[IXGBE_FDIR_TUNNEL_NODE_VLAN] = {
+			.next = (size_t[]) {
+				IXGBE_FDIR_TUNNEL_NODE_END,
+				FLOW_GRAPH_NODE_EDGE_END
+			}
+		},
+	},
+};
+
+static inline uint8_t
+signature_match(const struct rte_flow_item *item)
+{
+	const struct rte_flow_item_fuzzy *spec, *last, *mask;
+	uint32_t sh, lh, mh;
+
+	spec = item->spec;
+	last = item->last;
+	mask = item->mask;
+
+	if (spec == NULL || mask == NULL)
+		return 0;
+
+	sh = spec->thresh;
+
+	if (last == NULL)
+		lh = sh;
+	else
+		lh = last->thresh;
+
+	mh = mask->thresh;
+	sh = sh & mh;
+	lh = lh & mh;
+
+	/*
+	 * A fuzzy item selects signature mode only when the masked threshold range
+	 * is non-empty. Otherwise this stays a perfect-match rule.
+	 */
+	if (!sh || sh > lh)
+		return 0;
+
+	return 1;
+}
+
+/* pre-parse pattern to determine if this is a signature or perfect match rule */
+static int
+ixgbe_fdir_pattern_parse(struct ci_flow_engine_ctx *ctx,
+		const struct rte_flow_item pattern[],
+		struct rte_flow_error *error)
+{
+	struct ixgbe_fdir_ctx *fdir_ctx = (struct ixgbe_fdir_ctx *)ctx;
+	const struct rte_flow_item *item;
+	bool found = false;
+
+	fdir_ctx->rule.mode = RTE_FDIR_MODE_PERFECT;
+
+	for (item = pattern; item->type != RTE_FLOW_ITEM_TYPE_END; item++) {
+		if (item->type != RTE_FLOW_ITEM_TYPE_FUZZY)
+			continue;
+
+		if (found) {
+			return rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ITEM, item,
+					"Multiple FUZZY items not supported");
+		}
+		found = true;
+
+		if (signature_match(item))
+			fdir_ctx->rule.mode = RTE_FDIR_MODE_SIGNATURE;
+
+		break;
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_fdir_actions_check(const struct ci_flow_actions *parsed_actions,
+	const struct ci_flow_actions_check_param *param __rte_unused,
+	struct rte_flow_error *error)
+{
+	const enum rte_flow_action_type fwd_actions[] = {
+		RTE_FLOW_ACTION_TYPE_QUEUE,
+		RTE_FLOW_ACTION_TYPE_DROP,
+		RTE_FLOW_ACTION_TYPE_END
+	};
+	const struct rte_flow_action *action;
+
+	/* do the generic checks first */
+	int ret = ixgbe_flow_actions_check(parsed_actions, param, error);
+	if (ret)
+		return ret;
+
+	/* first action must be a forwarding action */
+	action = parsed_actions->actions[0];
+	if (!ci_flow_action_type_in_list(action->type, fwd_actions)) {
+		return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+					  action, "First action must be QUEUE or DROP");
+	}
+	/* second action, if specified, must not be a forwarding action */
+	action = parsed_actions->actions[1];
+	if (action != NULL && ci_flow_action_type_in_list(action->type, fwd_actions)) {
+		return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+					  action, "Conflicting actions");
+	}
+	return 0;
+}
+
+static int
+ixgbe_flow_fdir_ctx_finalize(struct ci_flow_engine_ctx *ctx, struct rte_flow_error *error)
+{
+	struct ixgbe_fdir_ctx *fdir_ctx = (struct ixgbe_fdir_ctx *)ctx;
+
+	/* DROP action should not be used with signature matches */
+	if ((fdir_ctx->rule.mode == RTE_FDIR_MODE_SIGNATURE) &&
+	    (fdir_ctx->fwd_action->type == RTE_FLOW_ACTION_TYPE_DROP)) {
+		return rte_flow_error_set(error, ENOTSUP,
+			RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+			"DROP action not allowed with signature mode");
+	}
+
+	/* rules without spec aren't allowed */
+	if (!fdir_ctx->rule.b_spec) {
+		return rte_flow_error_set(error, EINVAL,
+			RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+			"Rule spec cannot be empty");
+	}
+
+	return 0;
+}
+
+static int
+ixgbe_flow_fdir_ctx_init_common(const struct rte_flow_action *actions,
+		const struct rte_flow_attr *attr,
+		struct ci_flow_engine_ctx *ctx,
+		struct rte_flow_error *error)
+{
+	struct ixgbe_fdir_ctx *fdir_ctx = (struct ixgbe_fdir_ctx *)ctx;
+	struct ci_flow_actions parsed_actions;
+	struct ci_flow_actions_check_param ap_param = {
+		.allowed_types = (const enum rte_flow_action_type[]){
+			/* queue/mark/drop allowed here */
+			RTE_FLOW_ACTION_TYPE_QUEUE,
+			RTE_FLOW_ACTION_TYPE_DROP,
+			RTE_FLOW_ACTION_TYPE_MARK,
+			RTE_FLOW_ACTION_TYPE_END
+		},
+		.driver_ctx = ctx->dev_data,
+		.check = ixgbe_fdir_actions_check
+	};
+	struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+	int ret;
+
+	ixgbe_fdir_mask_set_default(&rule->mask);
+
+	/* validate attributes */
+	ret = ci_flow_check_attr(attr, NULL, error);
+	if (ret)
+		return ret;
+
+	/* parse requested actions */
+	ret = ci_flow_check_actions(actions, &ap_param, &parsed_actions, error);
+	if (ret)
+		return ret;
+
+	fdir_ctx->fwd_action = parsed_actions.actions[0];
+	/* can be NULL */
+	fdir_ctx->aux_action = parsed_actions.actions[1];
+
+	/* set up forward/drop action */
+	if (fdir_ctx->fwd_action->type == RTE_FLOW_ACTION_TYPE_QUEUE) {
+		const struct rte_flow_action_queue *q_act = fdir_ctx->fwd_action->conf;
+		rule->queue = q_act->index;
+	} else {
+		rule->fdirflags = IXGBE_FDIRCMD_DROP;
+	}
+
+	/* set up mark action */
+	if (fdir_ctx->aux_action != NULL && fdir_ctx->aux_action->type == RTE_FLOW_ACTION_TYPE_MARK) {
+		const struct rte_flow_action_mark *m_act = fdir_ctx->aux_action->conf;
+		rule->soft_id = m_act->id;
+	}
+
+	return ret;
+}
+
+static int
+ixgbe_flow_fdir_ctx_init(const struct rte_flow_action *actions,
+		const struct rte_flow_attr *attr,
+		struct ci_flow_engine_ctx *ctx,
+		struct rte_flow_error *error)
+{
+	const struct ixgbe_fdir_priv *fdir_priv = ctx->engine_priv;
+	struct ixgbe_fdir_ctx *fdir_ctx = (struct ixgbe_fdir_ctx *)ctx;
+	int ret;
+
+	/* call into common part first */
+	ret = ixgbe_flow_fdir_ctx_init_common(actions, attr, ctx, error);
+	if (ret)
+		return ret;
+
+	/* hardware capabilities are resolved once at engine_init */
+	fdir_ctx->supports_sctp_ports = fdir_priv->supports_sctp_ports;
+	fdir_ctx->supports_mac_vlan_mode = fdir_priv->supports_mac_vlan_mode;
+
+	return 0;
+}
+
+static int
+ixgbe_flow_fdir_tunnel_ctx_init(const struct rte_flow_action *actions,
+		const struct rte_flow_attr *attr,
+		struct ci_flow_engine_ctx *ctx,
+		struct rte_flow_error *error)
+{
+	struct ixgbe_fdir_ctx *fdir_ctx = (struct ixgbe_fdir_ctx *)ctx;
+	int ret;
+
+	/* call into common part first */
+	ret = ixgbe_flow_fdir_ctx_init_common(actions, attr, ctx, error);
+	if (ret)
+		return ret;
+
+	fdir_ctx->rule.mode = RTE_FDIR_MODE_PERFECT_TUNNEL;
+
+	return 0;
+}
+
+static int
+ixgbe_flow_fdir_ctx_to_flow(const struct ci_flow_engine_ctx *ctx,
+		struct ci_flow *flow,
+		struct rte_flow_error *error __rte_unused)
+{
+	struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(ctx->dev_data->dev_private);
+	const struct ixgbe_fdir_ctx *fdir_ctx = (const struct ixgbe_fdir_ctx *)ctx;
+	struct ixgbe_fdir_flow *fdir_flow = (struct ixgbe_fdir_flow *)flow;
+
+	fdir_flow->rule = fdir_ctx->rule;
+
+	if (fdir_flow->rule.fdirflags & IXGBE_FDIRCMD_DROP) {
+		fdir_flow->fdircmd_flags = IXGBE_FDIRCMD_DROP;
+		fdir_flow->queue = IXGBE_FDIR_DROP_QUEUE;
+	} else {
+		fdir_flow->fdircmd_flags = 0;
+		fdir_flow->queue = fdir_flow->rule.queue;
+	}
+
+	fdir_flow->fdirhash = ixgbe_fdir_compute_hash(adapter, &fdir_flow->rule);
+
+	return 0;
+}
+
+static bool
+ixgbe_fdir_table_contains(const struct rte_hash *hash_handle,
+		const struct ixgbe_fdir_rule *rule)
+{
+	return rte_hash_lookup(hash_handle, &rule->ixgbe_fdir) >= 0;
+}
+
+static int
+ixgbe_fdir_table_add(struct rte_hash *hash_handle,
+		struct ixgbe_fdir_flow *fdir_flow)
+{
+	return rte_hash_add_key(hash_handle, &fdir_flow->rule.ixgbe_fdir);
+}
+
+static int
+ixgbe_fdir_table_del(struct rte_hash *hash_handle,
+		struct ixgbe_fdir_flow *fdir_flow)
+{
+	return rte_hash_del_key(hash_handle, &fdir_flow->rule.ixgbe_fdir);
+}
+
+static bool
+ixgbe_fdir_mask_is_compatible(const struct ixgbe_fdir_mask_state *mask_state,
+		const struct ixgbe_fdir_rule *rule)
+{
+	if (memcmp(&mask_state->mask, &rule->mask, sizeof(mask_state->mask)) != 0)
+		return false;
+
+	/* if flex bytes mask is 0, flex bytes offset is not meaningful */
+	return rule->mask.flex_bytes_mask == 0 ||
+			mask_state->flex_bytes_offset == rule->flex_bytes_offset;
+}
+
+static bool
+ixgbe_fdir_config_is_compatible(const struct ixgbe_fdir_config_state *config,
+		const struct ixgbe_fdir_rule *rule)
+{
+	return config->rule_count == 0 || config->mode == rule->mode;
+}
+
+static void
+ixgbe_fdir_config_claim(struct ixgbe_fdir_state *state,
+		const struct ixgbe_fdir_rule *rule)
+{
+	if (ci_usage_count_claim(&state->config.rule_count)) {
+		state->config.mode = rule->mode;
+		state->mask_conf.mask = rule->mask;
+		/* flex bytes offset may not be meaningful */
+		if (rule->mask.flex_bytes_mask != 0)
+			state->mask_conf.flex_bytes_offset = rule->flex_bytes_offset;
+	}
+}
+
+static void
+ixgbe_fdir_config_release(struct ixgbe_fdir_state *state)
+{
+	if (ci_usage_count_release(&state->config.rule_count)) {
+		state->config.mode = RTE_FDIR_MODE_NONE;
+		state->config.hw_configured = false;
+		/* reset the mask */
+		ixgbe_fdir_mask_set_default(&state->mask_conf.mask);
+		state->mask_conf.flex_bytes_offset = 0;
+		state->mask_conf.mask_configured = false;
+	}
+}
+
+static int
+ixgbe_flow_fdir_flow_register(struct ci_flow *flow, struct rte_flow_error *error)
+{
+	struct ixgbe_fdir_flow *fdir_flow = (struct ixgbe_fdir_flow *)flow;
+	struct ixgbe_fdir_priv *priv = flow->engine_priv;
+	struct ixgbe_fdir_state *state = priv->state;
+	struct ixgbe_fdir_rule *rule = &fdir_flow->rule;
+	int ret;
+
+	if (ixgbe_fdir_table_contains(state->hash_handle, rule)) {
+		return rte_flow_error_set(error, EEXIST,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Conflict with existing flow director filter");
+	}
+	if (!ixgbe_fdir_config_is_compatible(&state->config, rule)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Flow mode is incompatible with existing rules");
+	}
+	if (state->config.rule_count != 0 && rule->mask.flex_bytes_mask != 0) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Flexible bytes can only be configured by the first rule");
+	}
+
+	if (state->config.rule_count != 0 &&
+			!ixgbe_fdir_mask_is_compatible(&state->mask_conf, rule)) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Flow mask is incompatible with existing rules");
+	}
+
+	ret = ixgbe_fdir_table_add(state->hash_handle, fdir_flow);
+	if (ret < 0) {
+		return rte_flow_error_set(error, -ret,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Failed to add flow director filter to table");
+	}
+
+	ixgbe_fdir_config_claim(state, rule);
+
+	return 0;
+}
+
+static int
+ixgbe_flow_fdir_flow_unregister(struct ci_flow *flow, struct rte_flow_error *error)
+{
+	struct ixgbe_fdir_flow *fdir_flow = (struct ixgbe_fdir_flow *)flow;
+	struct ixgbe_fdir_priv *priv = flow->engine_priv;
+	struct ixgbe_fdir_state *state = priv->state;
+	int ret;
+
+	ret = ixgbe_fdir_table_del(state->hash_handle, fdir_flow);
+	if (ret < 0) {
+		return rte_flow_error_set(error, -ret,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Failed to remove flow director filter from table");
+	}
+
+	ixgbe_fdir_config_release(state);
+
+	return 0;
+}
+
+static int
+ixgbe_flow_fdir_flow_install(struct ci_flow *flow,
+		struct rte_flow_error *error)
+{
+	struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(flow->dev_data->dev_private);
+	struct ixgbe_fdir_flow *fdir_flow = (struct ixgbe_fdir_flow *)flow;
+	struct ixgbe_fdir_priv *priv = flow->engine_priv;
+	struct ixgbe_fdir_config_state *config = &priv->state->config;
+	struct ixgbe_fdir_mask_state *mask_conf = &priv->state->mask_conf;
+	int ret;
+
+	if (!config->hw_configured) {
+		ret = ixgbe_fdir_hw_configure(flow->dev_data,
+				&adapter->fdir_hw_config, config->mode);
+		if (ret != 0) {
+			return rte_flow_error_set(error, -ret,
+				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				"Failed to configure flow director");
+		}
+		config->hw_configured = true;
+	}
+
+	if (!mask_conf->mask_configured) {
+		ret = ixgbe_fdir_mask_program(adapter, &mask_conf->mask,
+				mask_conf->flex_bytes_offset, config->mode);
+		if (ret != 0) {
+			ret = rte_flow_error_set(error, -ret,
+				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				"Failed to program flow director mask");
+			goto rollback_mask;
+		}
+		mask_conf->mask_configured = true;
+	}
+
+	ret = ixgbe_fdir_filter_program(adapter, &fdir_flow->rule, fdir_flow->queue,
+			fdir_flow->fdircmd_flags, fdir_flow->fdirhash);
+	if (ret != 0) {
+		ret = rte_flow_error_set(error, -ret,
+			RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+			"Failed to program flow director filter");
+		goto rollback_mask;
+	}
+
+	return 0;
+
+rollback_mask:
+	if (ci_usage_count_is_last(&config->rule_count)) {
+		if (ixgbe_fdir_hw_disable(adapter) == 0)
+			/* reset mask on next init */
+			mask_conf->mask_configured = false;
+		else
+			PMD_DRV_LOG(ERR, "Failed to roll back flow director state");
+	}
+
+	return ret;
+}
+
+static int
+ixgbe_flow_fdir_flow_uninstall(struct ci_flow *flow,
+		struct rte_flow_error *error)
+{
+	struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(flow->dev_data->dev_private);
+	struct ixgbe_fdir_flow *fdir_flow = (struct ixgbe_fdir_flow *)flow;
+	struct ixgbe_fdir_priv *priv = flow->engine_priv;
+	struct ixgbe_fdir_config_state *config = &priv->state->config;
+	int ret;
+
+	ret = ixgbe_fdir_filter_clear(adapter, fdir_flow->fdirhash);
+	if (ret != 0) {
+		return rte_flow_error_set(error, -ret,
+			RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+			"Failed to remove flow director filter");
+	}
+
+	/* is this the last rule? */
+	if (!ci_usage_count_is_last(&config->rule_count))
+		return 0;
+
+	ret = ixgbe_fdir_hw_disable(adapter);
+	if (ret != 0) {
+		return rte_flow_error_set(error, -ret,
+			RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+			"Failed to disable flow director");
+	}
+
+	return 0;
+}
+
+static void
+ixgbe_flow_fdir_engine_uninit(const struct ci_flow_engine *engine __rte_unused,
+		void *priv)
+{
+	struct ixgbe_fdir_priv *fdir_priv = priv;
+
+	ixgbe_fdir_state_detach(fdir_priv->state);
+}
+
+static int
+ixgbe_flow_fdir_state_attach(struct rte_eth_dev_data *dev_data, void *priv)
+{
+	struct ixgbe_fdir_priv *fdir_priv = priv;
+
+	fdir_priv->state = ixgbe_fdir_state_attach(dev_data);
+
+	return fdir_priv->state == NULL ? -ENOMEM : 0;
+}
+
+static int
+ixgbe_flow_fdir_engine_init(const struct ci_flow_engine *engine __rte_unused,
+		struct rte_eth_dev_data *dev_data,
+		void *priv)
+{
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev_data->dev_private);
+	struct ixgbe_fdir_priv *fdir_priv = priv;
+
+	if (hw->mac.type != ixgbe_mac_82599EB &&
+			hw->mac.type != ixgbe_mac_X540 &&
+			hw->mac.type != ixgbe_mac_X550 &&
+			hw->mac.type != ixgbe_mac_X550EM_x &&
+			hw->mac.type != ixgbe_mac_X550EM_a &&
+			hw->mac.type != ixgbe_mac_E610)
+		return -ENOTSUP;
+
+	/* some hardware does not support SCTP matching, or mac-vlan mode */
+	if (hw->mac.type == ixgbe_mac_X550 ||
+			hw->mac.type == ixgbe_mac_X550EM_x ||
+			hw->mac.type == ixgbe_mac_X550EM_a ||
+			hw->mac.type == ixgbe_mac_E610) {
+		fdir_priv->supports_sctp_ports = true;
+		fdir_priv->supports_mac_vlan_mode = true;
+	}
+
+	return ixgbe_flow_fdir_state_attach(dev_data, priv);
+}
+
+static int
+ixgbe_flow_fdir_tunnel_engine_init(const struct ci_flow_engine *engine __rte_unused,
+		struct rte_eth_dev_data *dev_data,
+		void *priv)
+{
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev_data->dev_private);
+	struct ixgbe_fdir_priv *fdir_priv = priv;
+
+	if (hw->mac.type != ixgbe_mac_X550 &&
+			hw->mac.type != ixgbe_mac_X550EM_x &&
+			hw->mac.type != ixgbe_mac_X550EM_a &&
+			hw->mac.type != ixgbe_mac_E610)
+		return -ENOTSUP;
+
+	/* tunnel engine only ever attaches on hardware that supports both */
+	fdir_priv->supports_sctp_ports = true;
+	fdir_priv->supports_mac_vlan_mode = true;
+
+	return ixgbe_flow_fdir_state_attach(dev_data, priv);
+}
+
+static const struct ci_flow_engine_ops ixgbe_fdir_ops = {
+	.engine_init = ixgbe_flow_fdir_engine_init,
+	.engine_uninit = ixgbe_flow_fdir_engine_uninit,
+	.ctx_init = ixgbe_flow_fdir_ctx_init,
+	.pattern_parse = ixgbe_fdir_pattern_parse,
+	.ctx_finalize = ixgbe_flow_fdir_ctx_finalize,
+	.ctx_to_flow = ixgbe_flow_fdir_ctx_to_flow,
+	.flow_register = ixgbe_flow_fdir_flow_register,
+	.flow_unregister = ixgbe_flow_fdir_flow_unregister,
+	.flow_install = ixgbe_flow_fdir_flow_install,
+	.flow_uninstall = ixgbe_flow_fdir_flow_uninstall,
+};
+
+static const struct ci_flow_engine_ops ixgbe_fdir_tunnel_ops = {
+	.engine_init = ixgbe_flow_fdir_tunnel_engine_init,
+	.engine_uninit = ixgbe_flow_fdir_engine_uninit,
+	.ctx_init = ixgbe_flow_fdir_tunnel_ctx_init,
+	.ctx_finalize = ixgbe_flow_fdir_ctx_finalize,
+	.ctx_to_flow = ixgbe_flow_fdir_ctx_to_flow,
+	.flow_register = ixgbe_flow_fdir_flow_register,
+	.flow_unregister = ixgbe_flow_fdir_flow_unregister,
+	.flow_install = ixgbe_flow_fdir_flow_install,
+	.flow_uninstall = ixgbe_flow_fdir_flow_uninstall,
+};
+
+const struct ci_flow_engine ixgbe_fdir_flow_engine = {
+	.name = "ixgbe_fdir",
+	.ctx_size = sizeof(struct ixgbe_fdir_ctx),
+	.flow_size = sizeof(struct ixgbe_fdir_flow),
+	.priv_size = sizeof(struct ixgbe_fdir_priv),
+	.ops = &ixgbe_fdir_ops,
+	.graph = &ixgbe_fdir_normal_graph,
+};
+
+const struct ci_flow_engine ixgbe_fdir_tunnel_flow_engine = {
+	.name = "ixgbe_fdir_tunnel",
+	.ctx_size = sizeof(struct ixgbe_fdir_ctx),
+	.flow_size = sizeof(struct ixgbe_fdir_flow),
+	.priv_size = sizeof(struct ixgbe_fdir_priv),
+	.ops = &ixgbe_fdir_tunnel_ops,
+	.graph = &ixgbe_fdir_tunnel_graph,
+};
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c
index c42b8fc96ba..bf456034168 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx_vec_common.c
@@ -120,10 +120,10 @@ int __rte_cold
 ixgbe_rx_vec_dev_conf_condition_check(struct rte_eth_dev *dev)
 {
 #ifndef RTE_LIBRTE_IEEE1588
-	struct rte_eth_fdir_conf *fconf = IXGBE_DEV_FDIR_CONF(dev);
+	struct ixgbe_adapter *adapter = dev->data->dev_private;
 
 	/* no fdir support */
-	if (fconf->mode != RTE_FDIR_MODE_NONE)
+	if (adapter->fdir_state.config.rule_count != 0)
 		return -1;
 
 	for (uint16_t i = 0; i < dev->data->nb_rx_queues; i++) {
diff --git a/drivers/net/intel/ixgbe/meson.build b/drivers/net/intel/ixgbe/meson.build
index 12ba639b702..2487f6a522f 100644
--- a/drivers/net/intel/ixgbe/meson.build
+++ b/drivers/net/intel/ixgbe/meson.build
@@ -31,6 +31,7 @@ sources += files(
         'ixgbe_flow_l2tun.c',
         'ixgbe_flow_ntuple.c',
         'ixgbe_flow_security.c',
+        'ixgbe_flow_fdir.c',
         'ixgbe_ipsec.c',
         'ixgbe_pf.c',
         'ixgbe_rxtx.c',
-- 
2.52.0

