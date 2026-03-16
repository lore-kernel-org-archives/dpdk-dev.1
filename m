Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DC5F53D7F
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 17:28:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2DEF4066C;
	Mon, 16 Mar 2026 18:28:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id BB7CA4065E
 for <dev@dpdk.org>; Mon, 16 Mar 2026 18:28:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773682084; x=1805218084;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Hy7EPlDknXD9vvaPZwZckyufSuzIcnbwQxtsWarHMUk=;
 b=PglCHi2tTDYvYcIVMkOSaR+cPIn6GfggWU9vf7JmU3hVH2a5G9jeyNN4
 08Qp4wDFZVcB6KhchXSUm2VGSRKA8voBrlYdpAb+foJm1xzZdnxAbEj8z
 cJVnDa5COjRwYGTxylmCcc/1Sqfii2vj0TIj88glIkSVTQIT02XX7IfJo
 +GcLSDuT1ApvWXCpqOQKezAOs69cI8Z/GuQY9xSXpsAXSh6Ldq5q37JjA
 IwVebq0Prw38GXeoq8xuGoYw8D9YhkAq8MZXelOjbAqRY14oJWRDsVcuR
 +689Ili3voHr1qthva89RePt/mrAEIZCp5emv53vt1CZzgE5e1vyncUtz w==;
X-CSE-ConnectionGUID: zj+7TN5FTZW07uTV/2FlSw==
X-CSE-MsgGUID: oQlKgydUQ+e1V+nLCcQLvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="86059616"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="86059616"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 10:28:03 -0700
X-CSE-ConnectionGUID: GnZNDHfWRkuurBAHOu2n0Q==
X-CSE-MsgGUID: +Qxq3x7RQUuu2p4u/Yy+sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="221228200"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 16 Mar 2026 10:28:02 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [RFC PATCH v1 04/21] net/ixgbe: add support for common flow parsing
Date: Mon, 16 Mar 2026 17:27:32 +0000
Message-ID: <7198acfd9db8a0e6b0fbcd3b32475dec2306a9a9.1773681364.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1773681363.git.anatoly.burakov@intel.com>
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
 drivers/net/intel/ixgbe/ixgbe_ethdev.c | 12 ++++++--
 drivers/net/intel/ixgbe/ixgbe_ethdev.h |  5 +++
 drivers/net/intel/ixgbe/ixgbe_flow.c   | 42 +++++++++++++++++++++++++-
 drivers/net/intel/ixgbe/ixgbe_flow.h   | 12 ++++++++
 4 files changed, 68 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow.h

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 57d929cf2c..b4435acd20 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -46,6 +46,7 @@
 #include "base/ixgbe_phy.h"
 #include "base/ixgbe_osdep.h"
 #include "ixgbe_regs.h"
+#include "ixgbe_flow.h"
 
 /*
  * High threshold controlling when to start sending XOFF frames. Must be at
@@ -1342,6 +1343,10 @@ eth_ixgbe_dev_init(struct rte_eth_dev *eth_dev, void *init_params __rte_unused)
 	/* initialize Traffic Manager configuration */
 	ixgbe_tm_conf_init(eth_dev);
 
+	/* initialize flow engine configuration */
+	ci_flow_engine_conf_init(&ad->flow_engine_conf,
+			&ixgbe_flow_engine_list, eth_dev);
+
 	return 0;
 
 err_l2_tn_filter_init:
@@ -3080,8 +3085,8 @@ ixgbe_dev_set_link_down(struct rte_eth_dev *dev)
 static int
 ixgbe_dev_close(struct rte_eth_dev *dev)
 {
-	struct ixgbe_hw *hw =
-		IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct ixgbe_adapter *ad = dev->data->dev_private;
+	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(ad);
 	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	int retries = 0;
@@ -3145,6 +3150,9 @@ ixgbe_dev_close(struct rte_eth_dev *dev)
 	rte_free(dev->security_ctx);
 	dev->security_ctx = NULL;
 
+	/* reset rte_flow config */
+	ci_flow_engine_conf_reset(&ad->flow_engine_conf, &ixgbe_flow_engine_list);
+
 	return ret;
 }
 
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index 32d7b98ed1..eaeeb35dea 100644
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
@@ -344,6 +346,7 @@ struct ixgbe_l2_tn_info {
 };
 
 struct rte_flow {
+	struct ci_flow flow;
 	enum rte_filter_type filter_type;
 	/* security flows are not rte_filter_type */
 	bool is_security;
@@ -486,6 +489,8 @@ struct ixgbe_adapter {
 	struct rte_timecounter      tx_tstamp_tc;
  	struct ixgbe_tm_conf        tm_conf;
 
+	struct ci_flow_engine_conf flow_engine_conf;
+
 	/* For RSS reta table update */
 	uint8_t rss_reta_updated;
 
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index d36e276ee0..3f33d28207 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -30,6 +30,7 @@
 #include <rte_hash_crc.h>
 #include <rte_flow.h>
 #include <rte_flow_driver.h>
+#include <rte_tailq.h>
 
 #include "ixgbe_logs.h"
 #include "base/ixgbe_api.h"
@@ -44,7 +45,7 @@
 #include "rte_pmd_ixgbe.h"
 
 #include "../common/flow_check.h"
-
+#include "../common/flow_engine.h"
 
 #define IXGBE_MIN_N_TUPLE_PRIO 1
 #define IXGBE_MAX_N_TUPLE_PRIO 7
@@ -102,6 +103,8 @@ static struct ixgbe_l2_tunnel_filter_list filter_l2_tunnel_list;
 static struct ixgbe_rss_filter_list filter_rss_list;
 static struct ixgbe_flow_mem_list ixgbe_flow_list;
 
+const struct ci_flow_engine_list ixgbe_flow_engine_list = {0};
+
 /**
  * Endless loop will never happen with below assumption
  * 1. there is at least one no-void item(END)
@@ -2789,6 +2792,7 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 		  const struct rte_flow_action actions[],
 		  struct rte_flow_error *error)
 {
+	struct ixgbe_adapter *ad = dev->data->dev_private;
 	int ret;
 	struct rte_eth_ntuple_filter ntuple_filter;
 	struct rte_eth_ethertype_filter ethertype_filter;
@@ -2808,6 +2812,15 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 	struct ixgbe_flow_mem *ixgbe_flow_mem_ptr;
 	uint8_t first_mask = FALSE;
 
+	/* try the new flow engine first */
+	flow = ci_flow_create(&ad->flow_engine_conf, &ixgbe_flow_engine_list,
+		attr, pattern, actions, error);
+	if (flow != NULL) {
+		return flow;
+	}
+
+	/* fall back to legacy flow engines */
+
 	flow = rte_zmalloc("ixgbe_rte_flow", sizeof(struct rte_flow), 0);
 	if (!flow) {
 		PMD_DRV_LOG(ERR, "failed to allocate memory");
@@ -3052,6 +3065,7 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
 		const struct rte_flow_action actions[],
 		struct rte_flow_error *error)
 {
+	struct ixgbe_adapter *ad = dev->data->dev_private;
 	struct rte_eth_ntuple_filter ntuple_filter;
 	struct rte_eth_ethertype_filter ethertype_filter;
 	struct rte_eth_syn_filter syn_filter;
@@ -3060,6 +3074,14 @@ ixgbe_flow_validate(struct rte_eth_dev *dev,
 	struct ixgbe_rte_flow_rss_conf rss_conf;
 	int ret;
 
+	/* try the new flow engine first */
+	ret = ci_flow_validate(&ad->flow_engine_conf, &ixgbe_flow_engine_list,
+		attr, pattern, actions, error);
+	if (ret == 0)
+		return ret;
+
+	/* fall back to legacy engines */
+
 	/**
 	 *  Special case for flow action type RTE_FLOW_ACTION_TYPE_SECURITY
 	 */
@@ -3110,6 +3132,7 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 		struct rte_flow *flow,
 		struct rte_flow_error *error)
 {
+	struct ixgbe_adapter *ad = dev->data->dev_private;
 	int ret;
 	struct rte_flow *pmd_flow = flow;
 	enum rte_filter_type filter_type = pmd_flow->filter_type;
@@ -3128,6 +3151,15 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
 	struct ixgbe_rss_conf_ele *rss_filter_ptr;
 
+	/* try the new flow engine first */
+	ret = ci_flow_destroy(&ad->flow_engine_conf,
+			&ixgbe_flow_engine_list, flow, error);
+	if (ret == 0) {
+		return 0;
+	}
+
+	/* fall back to legacy engines */
+
 	/* Special case for SECURITY flows */
 	if (flow->is_security) {
 		ret = 0;
@@ -3245,8 +3277,16 @@ static int
 ixgbe_flow_flush(struct rte_eth_dev *dev,
 		struct rte_flow_error *error)
 {
+	struct ixgbe_adapter *ad = dev->data->dev_private;
 	int ret = 0;
 
+	/* flush all flows from the new flow engine */
+	ret = ci_flow_flush(&ad->flow_engine_conf, &ixgbe_flow_engine_list, error);
+	if (ret) {
+		PMD_DRV_LOG(ERR, "Failed to flush flow");
+		return ret;
+	}
+
 	ixgbe_clear_all_ntuple_filter(dev);
 	ixgbe_clear_all_ethertype_filter(dev);
 	ixgbe_clear_syn_filter(dev);
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
2.47.3

