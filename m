Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E776F53D7F
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 17:29:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 36F7B40A75;
	Mon, 16 Mar 2026 18:28:17 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 2708540A7A
 for <dev@dpdk.org>; Mon, 16 Mar 2026 18:28:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773682095; x=1805218095;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=VpjCJUFrxMqDEncyY3aAGq2oBTM1jNcDdAZz5bYRjUQ=;
 b=PYjFzqsjveqD3jM9wstG8+vilFix1U7WFfTOm7Fx51ypM3C8B1avKUnC
 IzdqeAxfNpJZj7j1uakOzSRmypNY142zd9HTO2HpuRo6QRl4gx9ndFBZ7
 KZaWeuGbdZ0CQTb3kSMl6mthyhOkf5dEoEwh6PV7ZxNGW+ABUyQQtqY+W
 DPMSh0/KoU+MQ1ePuKvhhqO1u5S6bo3dh34ZHWDG+o97tgPbjrEoANvxU
 lkNNAQeFNHlaRif07z7lcOYHoE6ENfkA9HrypjrwWb65duCWArDvbaJw6
 gMwpTTGyNcnPCMpgzoCxamRyLd0Gl9LM36u+CZJk5ku0+Jazj+BduOGin w==;
X-CSE-ConnectionGUID: 0Rmdqv1KRvmXa1ziN6kUfQ==
X-CSE-MsgGUID: Fu8iQDvLSdy/bDseYI7vkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="86059645"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="86059645"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 10:28:14 -0700
X-CSE-ConnectionGUID: 5uXc7+HOTraPjDUYDZ8FPA==
X-CSE-MsgGUID: AC54rXH0SxWCasVL2pH9ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="221228251"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 16 Mar 2026 10:28:12 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH v1 12/21] net/i40e: add support for common flow parsing
Date: Mon, 16 Mar 2026 17:27:40 +0000
Message-ID: <6d46bcd145da00e390b6350fc4d7316209ea7d2c.1773681365.git.anatoly.burakov@intel.com>
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
 drivers/net/intel/i40e/i40e_ethdev.c |  8 ++++++
 drivers/net/intel/i40e/i40e_ethdev.h |  5 ++++
 drivers/net/intel/i40e/i40e_flow.c   | 38 +++++++++++++++++++++++++++-
 drivers/net/intel/i40e/i40e_flow.h   | 12 +++++++++
 4 files changed, 62 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/intel/i40e/i40e_flow.h

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index af736f59be..b71a4fb0d1 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -43,6 +43,9 @@
 #include "i40e_regs.h"
 #include "rte_pmd_i40e.h"
 #include "i40e_hash.h"
+#include "i40e_flow.h"
+
+#include "../common/flow_engine.h"
 
 #define ETH_I40E_FLOATING_VEB_ARG	"enable_floating_veb"
 #define ETH_I40E_FLOATING_VEB_LIST_ARG	"floating_veb_list"
@@ -1845,6 +1848,9 @@ eth_i40e_dev_init(struct rte_eth_dev *dev, void *init_params __rte_unused)
 	/* reset all stats of the device, including pf and main vsi */
 	i40e_dev_stats_reset(dev);
 
+	/* initialize flow engine configuration */
+	ci_flow_engine_conf_init(&pf->flow_engine_conf, &i40e_flow_engine_list, dev);
+
 	return 0;
 
 err_init_fdir_filter_list:
@@ -2773,6 +2779,8 @@ i40e_dev_close(struct rte_eth_dev *dev)
 			rte_free(p_flow);
 	}
 
+	ci_flow_engine_conf_reset(&pf->flow_engine_conf, &i40e_flow_engine_list);
+
 	/* release the fdir static allocated memory */
 	i40e_fdir_memory_cleanup(pf);
 
diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index 91ad0f8d0e..109ee7f278 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.h
+++ b/drivers/net/intel/i40e/i40e_ethdev.h
@@ -21,6 +21,8 @@
 #include "base/i40e_type.h"
 #include "base/virtchnl.h"
 
+#include "../common/flow_engine.h"
+
 #define I40E_AQ_LEN               32
 #define I40E_AQ_BUF_SZ            4096
 /* Number of queues per TC should be one of 1, 2, 4, 8, 16, 32, 64 */
@@ -278,6 +280,7 @@ enum i40e_flxpld_layer_idx {
  * Struct to store flow created.
  */
 struct rte_flow {
+	struct ci_flow base;
 	TAILQ_ENTRY(rte_flow) node;
 	enum rte_filter_type filter_type;
 	void *rule;
@@ -1172,6 +1175,8 @@ struct i40e_pf {
 	/* The floating enable flag for the specific VF */
 	bool floating_veb_list[I40E_MAX_VF];
 	struct i40e_flow_list flow_list;
+	/* flow engine configuration */
+	struct ci_flow_engine_conf flow_engine_conf;
 	bool mpls_replace_flag;  /* 1 - MPLS filter replace is done */
 	bool gtp_replace_flag;   /* 1 - GTP-C/U filter replace is done */
 	bool qinq_replace_flag;  /* QINQ filter replace is done */
diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index ee48ebf4c3..2f9094bcc7 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -25,9 +25,12 @@
 #include "base/i40e_prototype.h"
 #include "i40e_ethdev.h"
 #include "i40e_hash.h"
+#include "i40e_flow.h"
 
 #include "../common/flow_check.h"
 
+const struct ci_flow_engine_list i40e_flow_engine_list = {0};
+
 #define I40E_IPV6_TC_MASK	(0xFF << I40E_FDIR_IPv6_TC_OFFSET)
 #define I40E_IPV6_FRAG_HEADER	44
 #define I40E_TENANT_ARRAY_NUM	3
@@ -3795,8 +3798,16 @@ i40e_flow_validate(struct rte_eth_dev *dev,
 		   const struct rte_flow_action actions[],
 		   struct rte_flow_error *error)
 {
+	struct i40e_pf *pf = dev->data->dev_private;
 	/* creates dummy context */
 	struct i40e_filter_ctx filter_ctx = {0};
+	int ret;
+
+	/* try the new engine first */
+	ret = ci_flow_validate(&pf->flow_engine_conf, &i40e_flow_engine_list,
+			attr, pattern, actions, error);
+	if (ret == 0)
+		return 0;
 
 	return i40e_flow_check(dev, attr, pattern, actions, &filter_ctx, error);
 }
@@ -3814,6 +3825,12 @@ i40e_flow_create(struct rte_eth_dev *dev,
 	struct i40e_fdir_info *fdir_info = &pf->fdir;
 	int ret;
 
+	/* try the new engine first */
+	flow = ci_flow_create(&pf->flow_engine_conf, &i40e_flow_engine_list,
+			attr, pattern, actions, error);
+	if (flow != NULL)
+		return flow;
+
 	ret = i40e_flow_check(dev, attr, pattern, actions, &filter_ctx, error);
 	if (ret < 0)
 		return NULL;
@@ -3920,6 +3937,12 @@ i40e_flow_destroy(struct rte_eth_dev *dev,
 	struct i40e_fdir_info *fdir_info = &pf->fdir;
 	int ret = 0;
 
+	/* try the new engine first */
+	ret = ci_flow_destroy(&pf->flow_engine_conf, &i40e_flow_engine_list,
+			flow, error);
+	if (ret == 0)
+		return 0;
+
 	switch (filter_type) {
 	case RTE_ETH_FILTER_ETHERTYPE:
 		ret = i40e_flow_destroy_ethertype_filter(pf,
@@ -4064,6 +4087,11 @@ i40e_flow_flush(struct rte_eth_dev *dev, struct rte_flow_error *error)
 	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 	int ret;
 
+	/* flush the new engine first */
+	ret = ci_flow_flush(&pf->flow_engine_conf, &i40e_flow_engine_list, error);
+	if (ret != 0)
+		return ret;
+
 	ret = i40e_flow_flush_fdir_filter(pf);
 	if (ret) {
 		rte_flow_error_set(error, -ret,
@@ -4213,14 +4241,22 @@ i40e_flow_flush_tunnel_filter(struct i40e_pf *pf)
 }
 
 static int
-i40e_flow_query(struct rte_eth_dev *dev __rte_unused,
+i40e_flow_query(struct rte_eth_dev *dev,
 		struct rte_flow *flow,
 		const struct rte_flow_action *actions,
 		void *data, struct rte_flow_error *error)
 {
+	struct i40e_pf *pf = dev->data->dev_private;
 	struct i40e_rss_filter *rss_rule = (struct i40e_rss_filter *)flow->rule;
 	enum rte_filter_type filter_type = flow->filter_type;
 	struct rte_flow_action_rss *rss_conf = data;
+	int ret;
+
+	/* try the new engine first */
+	ret = ci_flow_query(&pf->flow_engine_conf, &i40e_flow_engine_list,
+			flow, actions, data, error);
+	if (ret == 0)
+		return 0;
 
 	if (!rss_rule) {
 		rte_flow_error_set(error, EINVAL,
diff --git a/drivers/net/intel/i40e/i40e_flow.h b/drivers/net/intel/i40e/i40e_flow.h
new file mode 100644
index 0000000000..c958868661
--- /dev/null
+++ b/drivers/net/intel/i40e/i40e_flow.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+#ifndef _I40E_FLOW_H_
+#define _I40E_FLOW_H_
+
+#include "../common/flow_engine.h"
+
+extern const struct ci_flow_engine_list i40e_flow_engine_list;
+
+#endif /* _I40E_FLOW_H_ */
-- 
2.47.3

