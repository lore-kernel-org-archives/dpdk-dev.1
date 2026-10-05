Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BB2CA5FFC
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 16:39:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 064FB40DF8;
	Mon,  5 Oct 2026 18:38:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id EEB5D40DD1
 for <dev@dpdk.org>; Mon,  5 Oct 2026 18:38:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791218321; x=1822754321;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=bqJaRP136of/APYsq7LdkfIQc6PwrBfJTGZyesyxn7k=;
 b=OxcXQm01EoJgKxgQNs3u1Cy9JhSChppNYpMQXKEYhdxbhtvwbpal2qil
 YqwinG75hPDWhbpm64GgQTJfxLThzJneOV014x3954VTdtCRCjlqaTxyI
 OoU3DKUt3GV47yGAfdNLMqTJf65tOVOWsiYZR4Z9JYODnQCDZrXYeZ/aF
 N+U3q4gUw4b+40nIQx+1SPmvdAX4ClDvN2m3UYJEBQlbLtP1L8mh4jomV
 cGsD8Q4kCVvRTfS50Q78ZwEmI+szogL5e9DIafW2Fek4qYoZNZ5caZmKC
 IVzlN7Th4AjQCBTxDVt/eOhiYypi4/gpgjHDCUVZsN8w+18G6i7fg24AX A==;
X-CSE-ConnectionGUID: T3yuRLPERYC9Luy9ve4zOA==
X-CSE-MsgGUID: aQ1yJXeHQ26bLyNOl5tyFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="90665282"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="90665282"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 09:38:40 -0700
X-CSE-ConnectionGUID: IheQxZjtRle3wkW6COIVzA==
X-CSE-MsgGUID: b7bWBdqiQMeqfIfAgol13Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="945704"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa011.fm.intel.com with ESMTP; 05 Oct 2026 09:38:40 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v4 05/24] net/ixgbe: add support for common flow parsing
Date: Mon,  5 Oct 2026 17:38:00 +0100
Message-ID: <2be1294c8a0a3d6c5d5a638d6b57f3bfcd0d2f88.1791218155.git.anatoly.burakov@intel.com>
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

Implement support for common flow parsing infrastructure in preparation for
migration of flow engines. The following features are enabled:

- Conf init on dev_init
- Conf uninit on dev_close
- Flow cleanup on dev_close
- Flow replay on dev_start

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c | 22 ++++++++++-
 drivers/net/intel/ixgbe/ixgbe_ethdev.h |  5 +++
 drivers/net/intel/ixgbe/ixgbe_flow.c   | 54 +++++++++++++++++++++++++-
 drivers/net/intel/ixgbe/ixgbe_flow.h   | 12 ++++++
 4 files changed, 90 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow.h

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 1745070e595..14e4bb7c1d3 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -47,6 +47,7 @@
 #include "base/ixgbe_phy.h"
 #include "ixgbe_osdep.h"
 #include "ixgbe_regs.h"
+#include "ixgbe_flow.h"
 
 /*
  * High threshold controlling when to start sending XOFF frames. Must be at
@@ -1279,6 +1280,12 @@ eth_ixgbe_dev_init(struct rte_eth_dev *eth_dev, void *init_params __rte_unused)
 	if (ret)
 		goto err_l2_tn_filter_init;
 
+	/* initialize flow engine configuration */
+	ret = ci_flow_engine_conf_init(&ad->flow_engine_conf,
+			&ixgbe_flow_engine_list, eth_dev->data);
+	if (ret)
+		goto err_flow_engine_conf_init;
+
 	/* initialize flow filter lists */
 	ixgbe_filterlist_init(eth_dev);
 
@@ -1290,6 +1297,8 @@ eth_ixgbe_dev_init(struct rte_eth_dev *eth_dev, void *init_params __rte_unused)
 
 	return 0;
 
+err_flow_engine_conf_init:
+	ixgbe_l2_tn_filter_uninit(eth_dev);
 err_l2_tn_filter_init:
 	ixgbe_fdir_filter_uninit(eth_dev);
 err_fdir_filter_init:
@@ -2856,6 +2865,9 @@ ixgbe_dev_start(struct rte_eth_dev *dev)
 	if (macsec_setting->offload_en)
 		ixgbe_dev_macsec_register_enable(dev, macsec_setting);
 
+	/* re-install kept flows to hardware */
+	ci_flow_replay(&adapter->flow_engine_conf);
+
 	return 0;
 
 error:
@@ -3035,8 +3047,8 @@ ixgbe_dev_set_link_down(struct rte_eth_dev *dev)
 static int
 ixgbe_dev_close(struct rte_eth_dev *dev)
 {
-	struct ixgbe_hw *hw =
-		IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct ixgbe_adapter *ad = dev->data->dev_private;
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(ad);
 	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	int retries = 0;
@@ -3103,6 +3115,12 @@ ixgbe_dev_close(struct rte_eth_dev *dev)
 	rte_free(dev->security_ctx);
 	dev->security_ctx = NULL;
 
+	/* drop all flows */
+	ci_flow_cleanup(&ad->flow_engine_conf);
+
+	/* reset flow engines */
+	ci_flow_engine_conf_reset(&ad->flow_engine_conf);
+
 	return ret;
 }
 
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index 2e9d166e295..04b449fb70d 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -22,6 +22,8 @@
 #include <bus_pci_driver.h>
 #include <rte_tm_driver.h>
 
+#include "../common/flow_engine.h"
+
 /* need update link, bit flag */
 #define IXGBE_FLAG_NEED_LINK_UPDATE (uint32_t)(1 << 0)
 #define IXGBE_FLAG_MAILBOX          (uint32_t)(1 << 1)
@@ -342,6 +344,7 @@ struct ixgbe_l2_tn_info {
 };
 
 struct rte_flow {
+	struct ci_flow flow;
 	enum rte_filter_type filter_type;
 	/* security flows are not rte_filter_type */
 	bool is_security;
@@ -487,6 +490,8 @@ struct ixgbe_adapter {
 	struct rte_timecounter      tx_tstamp_tc;
  	struct ixgbe_tm_conf        tm_conf;
 
+	struct ci_flow_engine_conf flow_engine_conf;
+
 	/* For RSS reta table update */
 	uint8_t rss_reta_updated;
 
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index ff56d7b2790..dffc7ccdc80 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -47,7 +47,8 @@
 #include "rte_pmd_ixgbe.h"
 
 #include "../common/flow_check.h"
-
+#include "../common/flow_engine.h"
+#include "ixgbe_flow.h"
 
 #define IXGBE_MIN_N_TUPLE_PRIO 1
 #define IXGBE_MAX_N_TUPLE_PRIO 7
@@ -93,6 +94,8 @@ struct ixgbe_flow_mem {
 	struct rte_flow *flow;
 };
 
+const struct ci_flow_engine_list ixgbe_flow_engine_list = {0};
+
 /**
  * Endless loop will never happen with below assumption
  * 1. there is at least one no-void item(END)
@@ -2832,6 +2835,13 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 	struct ixgbe_rss_conf_ele *rss_filter_ptr;
 	struct ixgbe_flow_mem *ixgbe_flow_mem_ptr;
 
+	/* try the new flow engine first */
+	flow = ci_flow_create(&adapter->flow_engine_conf, attr, pattern, actions, error);
+	if (flow != NULL)
+		return flow;
+
+	/* fall back to legacy flow engines */
+
 	flow = rte_zmalloc("ixgbe_rte_flow", sizeof(struct rte_flow), 0);
 	if (!flow) {
 		PMD_DRV_LOG(ERR, "failed to allocate memory");
@@ -3031,6 +3041,7 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
 		const struct rte_flow_action actions[],
 		struct rte_flow_error *error)
 {
+	struct ixgbe_adapter *ad = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct rte_eth_ntuple_filter ntuple_filter;
 	struct rte_eth_ethertype_filter ethertype_filter;
 	struct rte_eth_syn_filter syn_filter;
@@ -3039,6 +3050,13 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
 	struct ixgbe_rte_flow_rss_conf rss_conf;
 	int ret;
 
+	/* try the new flow engine first */
+	ret = ci_flow_validate(&ad->flow_engine_conf, attr, pattern, actions, error);
+	if (ret == 0)
+		return ret;
+
+	/* fall back to legacy engines */
+
 	/**
 	 *  Special case for flow action type RTE_FLOW_ACTION_TYPE_SECURITY
 	 */
@@ -3110,6 +3128,13 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
 	struct ixgbe_rss_conf_ele *rss_filter_ptr;
 
+	/* try the new flow engine first */
+	ret = ci_flow_destroy(&adapter->flow_engine_conf, flow, error);
+	if (ret == 0)
+		return 0;
+
+	/* fall back to legacy engines */
+
 	/* Validate ownership before touching HW/SW state. */
 	TAILQ_FOREACH(flow_mem_base, &adapter->flow_list, entries) {
 		struct ixgbe_flow_mem *ixgbe_flow_mem_ptr =
@@ -3213,8 +3238,16 @@ static int
 ixgbe_flow_flush(struct rte_eth_dev *dev,
 		struct rte_flow_error *error)
 {
+	struct ixgbe_adapter *ad = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	int ret = 0;
 
+	/* flush all flows from the new flow engine */
+	ret = ci_flow_flush(&ad->flow_engine_conf, error);
+	if (ret) {
+		PMD_DRV_LOG(ERR, "Failed to flush flow");
+		return ret;
+	}
+
 	ixgbe_clear_all_ntuple_filter(dev);
 	ixgbe_clear_all_ethertype_filter(dev);
 	ixgbe_clear_syn_filter(dev);
@@ -3334,6 +3367,25 @@ ixgbe_flow_dev_dump(struct rte_eth_dev *dev,
 	struct ixgbe_adapter *ad = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct ixgbe_filter_ele_base *flow_mem_base;
 	bool found = false;
+	int ret;
+
+	/* try the new flow engine first */
+	ret = ci_flow_dump(&ad->flow_engine_conf, flow, file, error);
+
+	/*
+	 * There are multiple possible situations here:
+	 *
+	 * - User requested to dump all flows
+	 * - User requested to dump a specific flow
+	 *
+	 * For the first case, we keep going because legacy engines might still
+	 * have flows we want to dump.
+	 *
+	 * For the second case, we only stop if the flow we were asked to dump
+	 * was found in the new engines, otherwise we keep looking.
+	 */
+	if (flow != NULL && ret == 0)
+		return 0;
 
 	TAILQ_FOREACH(flow_mem_base, &ad->flow_list, entries) {
 		struct ixgbe_flow_mem *ixgbe_flow_mem_ptr =
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.h b/drivers/net/intel/ixgbe/ixgbe_flow.h
new file mode 100644
index 00000000000..5e68c9886c1
--- /dev/null
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+#ifndef _IXGBE_FLOW_H_
+#define _IXGBE_FLOW_H_
+
+#include "../common/flow_engine.h"
+
+extern const struct ci_flow_engine_list ixgbe_flow_engine_list;
+
+#endif /*  _IXGBE_FLOW_H_ */
-- 
2.52.0

