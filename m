Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D134BC5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 14:02:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2441406A2;
	Thu, 20 Aug 2026 16:01:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 4F6E140A6D
 for <dev@dpdk.org>; Thu, 20 Aug 2026 16:01:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787234508; x=1818770508;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=G8jZvjuXpbsRB6I3pxYEuGPwCIhSvFqvnDUCJ3a+J9Y=;
 b=LOrTN2loTve4whEEMqnM4gVstO8bVQ6e9j/x/PcikANaoVIxm5ZBtwoj
 crxWqPn+QbYpQC3r5YdWz+dAyr7cDjXj5f+Y6rTVUKp3twWv5lXbErj9o
 xcgDTOBx/gdfDC1vbYKucgb8jBq3ssxdkiGSzZFbeXrvIPN+itm44x+oq
 SeVfZc9yA1EZPJrdxszvN7tRyYGCGwJTkYM8NjqARGq1SCHXIgx2Bb8In
 bRm6/ShX+C1N0GY2f0PQ0mL8hJstCRzu4FTTctTx6hd3TNiFtxcJHEtny
 wgpoblp8x7bt9ZlK7Vem/xGAnq1i0PoW31tXdIe0PI2njH2Lb2YBMDeon A==;
X-CSE-ConnectionGUID: +uikLqheRRKp6L38ksQ9nw==
X-CSE-MsgGUID: OQgFsUy4R4qeBAeEGPqSWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="75300318"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="75300318"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 07:01:47 -0700
X-CSE-ConnectionGUID: 6L4YK5RaSn2xsXUaNVmgvw==
X-CSE-MsgGUID: XGGYOEK4SieMs/iJACHA9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="264719689"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 20 Aug 2026 07:01:46 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 04/21] net/ixgbe: add support for common flow parsing
Date: Thu, 20 Aug 2026 15:00:49 +0100
Message-ID: <7e3ada0205f0b630e088dc03350be1ee4b767848.1787233987.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1787233986.git.anatoly.burakov@intel.com>
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
migration of flow engines.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c | 15 ++++++-
 drivers/net/intel/ixgbe/ixgbe_ethdev.h |  5 +++
 drivers/net/intel/ixgbe/ixgbe_flow.c   | 55 +++++++++++++++++++++++++-
 drivers/net/intel/ixgbe/ixgbe_flow.h   | 12 ++++++
 4 files changed, 84 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow.h

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index c5010f623c..ebc4fab704 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -46,6 +46,7 @@
 #include "base/ixgbe_phy.h"
 #include "base/ixgbe_osdep.h"
 #include "ixgbe_regs.h"
+#include "ixgbe_flow.h"
 
 /*
  * High threshold controlling when to start sending XOFF frames. Must be at
@@ -1343,6 +1344,10 @@ eth_ixgbe_dev_init(struct rte_eth_dev *eth_dev, void *init_params __rte_unused)
 	/* initialize Traffic Manager configuration */
 	ixgbe_tm_conf_init(eth_dev);
 
+	/* initialize flow engine configuration */
+	ci_flow_engine_conf_init(&ad->flow_engine_conf,
+			&ixgbe_flow_engine_list, eth_dev->data);
+
 	return 0;
 
 err_l2_tn_filter_init:
@@ -3089,8 +3094,8 @@ ixgbe_dev_set_link_down(struct rte_eth_dev *dev)
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
@@ -3100,6 +3105,9 @@ ixgbe_dev_close(struct rte_eth_dev *dev)
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
 		return 0;
 
+	/* uninstall all flows */
+	ci_flow_flush(&ad->flow_engine_conf, NULL);
+
 	ixgbe_pf_reset_hw(hw);
 
 	ret = ixgbe_dev_stop(dev);
@@ -3154,6 +3162,9 @@ ixgbe_dev_close(struct rte_eth_dev *dev)
 	rte_free(dev->security_ctx);
 	dev->security_ctx = NULL;
 
+	/* reset flow engines */
+	ci_flow_engine_conf_reset(&ad->flow_engine_conf);
+
 	return ret;
 }
 
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index 5d3243cb4d..cde0ee8fda 100644
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
@@ -346,6 +348,7 @@ struct ixgbe_l2_tn_info {
 };
 
 struct rte_flow {
+	struct ci_flow flow;
 	enum rte_filter_type filter_type;
 	/* security flows are not rte_filter_type */
 	bool is_security;
@@ -492,6 +495,8 @@ struct ixgbe_adapter {
 	struct rte_timecounter      tx_tstamp_tc;
  	struct ixgbe_tm_conf        tm_conf;
 
+	struct ci_flow_engine_conf flow_engine_conf;
+
 	/* For RSS reta table update */
 	uint8_t rss_reta_updated;
 
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 6868893d46..c5c034144d 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -33,6 +33,7 @@
 #include <rte_flow.h>
 #include <rte_hexdump.h>
 #include <rte_flow_driver.h>
+#include <rte_tailq.h>
 
 #include "ixgbe_logs.h"
 #include "base/ixgbe_api.h"
@@ -47,7 +48,8 @@
 #include "rte_pmd_ixgbe.h"
 
 #include "../common/flow_check.h"
-
+#include "../common/flow_engine.h"
+#include "ixgbe_flow.h"
 
 #define IXGBE_MIN_N_TUPLE_PRIO 1
 #define IXGBE_MAX_N_TUPLE_PRIO 7
@@ -93,6 +95,8 @@ struct ixgbe_flow_mem {
 	struct rte_flow *flow;
 };
 
+const struct ci_flow_engine_list ixgbe_flow_engine_list = {0};
+
 /**
  * Endless loop will never happen with below assumption
  * 1. there is at least one no-void item(END)
@@ -2828,6 +2832,13 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
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
@@ -3021,6 +3032,7 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
 		const struct rte_flow_action actions[],
 		struct rte_flow_error *error)
 {
+	struct ixgbe_adapter *ad = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct rte_eth_ntuple_filter ntuple_filter;
 	struct rte_eth_ethertype_filter ethertype_filter;
 	struct rte_eth_syn_filter syn_filter;
@@ -3029,6 +3041,13 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
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
@@ -3100,6 +3119,13 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
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
@@ -3212,8 +3238,16 @@ static int
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
@@ -3333,6 +3367,25 @@ ixgbe_flow_dev_dump(struct rte_eth_dev *dev,
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
index 0000000000..5e68c9886c
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

