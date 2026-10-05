Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33079CA5FF0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 16:41:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98F1D40EE3;
	Mon,  5 Oct 2026 18:39:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 75C1940E40
 for <dev@dpdk.org>; Mon,  5 Oct 2026 18:38:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791218338; x=1822754338;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=ADEBqbrRSN2tuYKH6gD96tIFOeuiloq9D7U8EH0lMuM=;
 b=BGBLLCueSEVE4JD8FS0QSvFGIJ9mQ/TIUaVXE556o/47H3Fhy08FMx1u
 yOoZaqWkp+ZhbzJURjn572I+2kFCfAlycNOb7vhZqv2i0o/7TR3y/5pEV
 VyHrlg/gc4ZY35TOyzoxcNB6XyMwBdOgyp9mcVuqp8TzUj+JomRJqqy2M
 9riOYagSf8rLY47xXx9iSM5JfjH0xRLqwh6yii4drYyAIhmtd303bX5Fo
 fx3MO7Hzi5m98Q5zPD15Ye33OmtaQRpbkZlzS9H8Jwhm4gUh6Jn+D+uy4
 fya3a/NCt72wYHkH8DCR6AgZ5C1ixAppKFqYgCzQb63cmpiqWMMj1OJN3 Q==;
X-CSE-ConnectionGUID: rzfBPgQUSRm9RseNkpOWwA==
X-CSE-MsgGUID: zr1EOLsHTM6ZmBEMISLsEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="90665345"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="90665345"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 09:38:58 -0700
X-CSE-ConnectionGUID: 8XHSQa03TrSYWjP/eC4fEg==
X-CSE-MsgGUID: rY/RypEZSYqDYAacl1628g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="945791"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa011.fm.intel.com with ESMTP; 05 Oct 2026 09:38:57 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 18/24] net/i40e: add support for common flow parsing
Date: Mon,  5 Oct 2026 17:38:13 +0100
Message-ID: <5c2fa0953ac0637c809729fd83341e6efa4d91f4.1791218156.git.anatoly.burakov@intel.com>
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
migration of flow engines.

Currently, i40e explicitly clears KEEP_FLOW capability flag, meaning that
it advertises that all flows are flushed on dev stop. However, in
practice i40e actually restores all flows on dev start, so while we will
not (yet) advertise the KEEP_FLOW capability flag, we will also not flush
the flows on dev stop with the new engines, and instead replay them.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.c | 21 +++++++++++
 drivers/net/intel/i40e/i40e_ethdev.h |  5 +++
 drivers/net/intel/i40e/i40e_flow.c   | 53 +++++++++++++++++++++++++++-
 drivers/net/intel/i40e/i40e_flow.h   | 12 +++++++
 4 files changed, 90 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/intel/i40e/i40e_flow.h

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index 41d5586403b..92aa0e39554 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -42,6 +42,9 @@
 #include "i40e_regs.h"
 #include "rte_pmd_i40e.h"
 #include "i40e_hash.h"
+#include "i40e_flow.h"
+
+#include "../common/flow_engine.h"
 
 #define ETH_I40E_FLOATING_VEB_ARG	"enable_floating_veb"
 #define ETH_I40E_FLOATING_VEB_LIST_ARG	"floating_veb_list"
@@ -1838,6 +1841,12 @@ eth_i40e_dev_init(struct rte_eth_dev *dev, void *init_params __rte_unused)
 	if (ret < 0)
 		goto err_init_fdir_filter_list;
 
+	/* initialize flow engine configuration */
+	ret = ci_flow_engine_conf_init(&pf->flow_engine_conf,
+			&i40e_flow_engine_list, dev->data);
+	if (ret < 0)
+		goto err_flow_engine_conf_init;
+
 	/* initialize queue region configuration */
 	i40e_init_queue_region_conf(dev);
 
@@ -1846,6 +1855,12 @@ eth_i40e_dev_init(struct rte_eth_dev *dev, void *init_params __rte_unused)
 
 	return 0;
 
+err_flow_engine_conf_init:
+	rte_free(pf->fdir.fdir_flow_pool.bitmap);
+	rte_free(pf->fdir.fdir_flow_pool.pool);
+	rte_free(pf->fdir.fdir_filter_array);
+	rte_free(pf->fdir.hash_map);
+	rte_hash_free(pf->fdir.hash_table);
 err_init_fdir_filter_list:
 	rte_hash_free(pf->tunnel.hash_table);
 	rte_free(pf->tunnel.hash_map);
@@ -2613,6 +2628,8 @@ i40e_dev_start(struct rte_eth_dev *dev)
 	/* Set the max frame size to HW*/
 	i40e_aq_set_mac_config(hw, max_frame_size, TRUE, false, 0, NULL);
 
+	ci_flow_replay(&pf->flow_engine_conf);
+
 	return I40E_SUCCESS;
 
 tx_err:
@@ -2715,6 +2732,10 @@ i40e_dev_close(struct rte_eth_dev *dev)
 
 	ret = i40e_dev_stop(dev);
 
+	/* free the flows and reset flow config */
+	ci_flow_cleanup(&pf->flow_engine_conf);
+	ci_flow_engine_conf_reset(&pf->flow_engine_conf);
+
 	i40e_dev_free_queues(dev);
 
 	/* Disable interrupt */
diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index 1e64a2d2800..16b67268f7f 100644
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
@@ -1182,6 +1185,8 @@ struct i40e_pf {
 	/* The floating enable flag for the specific VF */
 	bool floating_veb_list[I40E_MAX_VF];
 	struct i40e_flow_list flow_list;
+	/* flow engine configuration */
+	struct ci_flow_engine_conf flow_engine_conf;
 	bool mpls_replace_flag;  /* 1 - MPLS filter replace is done */
 	bool gtp_replace_flag;   /* 1 - GTP-C/U filter replace is done */
 	bool qinq_replace_flag;  /* QINQ filter replace is done */
diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index a017d3cd448..7d410b6c33b 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -26,9 +26,12 @@
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
@@ -1268,6 +1271,25 @@ i40e_flow_dev_dump(struct rte_eth_dev *dev,
 	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 	struct rte_flow *p_flow;
 	bool found = false;
+	int ret;
+
+	/* try the new flow engine first */
+	ret = ci_flow_dump(&pf->flow_engine_conf, flow, file, error);
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
+	 * For the second case, we only keep going if the flow we were asked to
+	 * dump was not found in the new engines.
+	 */
+	if (flow != NULL && ret == 0)
+		return 0;
 
 	TAILQ_FOREACH(p_flow, &pf->flow_list, node) {
 		size_t rule_size = 0;
@@ -3892,8 +3914,15 @@ i40e_flow_validate(struct rte_eth_dev *dev,
 		   const struct rte_flow_action actions[],
 		   struct rte_flow_error *error)
 {
+	struct i40e_pf *pf = dev->data->dev_private;
 	/* creates dummy context */
 	struct i40e_filter_ctx filter_ctx = {0};
+	int ret;
+
+	/* try the new engine first */
+	ret = ci_flow_validate(&pf->flow_engine_conf, attr, pattern, actions, error);
+	if (ret == 0)
+		return 0;
 
 	return i40e_flow_check(dev, attr, pattern, actions, &filter_ctx, error);
 }
@@ -3911,6 +3940,11 @@ i40e_flow_create(struct rte_eth_dev *dev,
 	struct i40e_fdir_info *fdir_info = &pf->fdir;
 	int ret;
 
+	/* try the new engine first */
+	flow = ci_flow_create(&pf->flow_engine_conf, attr, pattern, actions, error);
+	if (flow != NULL)
+		return flow;
+
 	ret = i40e_flow_check(dev, attr, pattern, actions, &filter_ctx, error);
 	if (ret < 0)
 		return NULL;
@@ -4017,6 +4051,11 @@ i40e_flow_destroy(struct rte_eth_dev *dev,
 	struct i40e_fdir_info *fdir_info = &pf->fdir;
 	int ret = 0;
 
+	/* try the new engine first */
+	ret = ci_flow_destroy(&pf->flow_engine_conf, flow, error);
+	if (ret == 0)
+		return 0;
+
 	switch (filter_type) {
 	case RTE_ETH_FILTER_ETHERTYPE:
 		ret = i40e_flow_destroy_ethertype_filter(pf,
@@ -4161,6 +4200,11 @@ i40e_flow_flush(struct rte_eth_dev *dev, struct rte_flow_error *error)
 	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 	int ret;
 
+	/* flush the new engine first */
+	ret = ci_flow_flush(&pf->flow_engine_conf, error);
+	if (ret != 0)
+		return ret;
+
 	ret = i40e_flow_flush_fdir_filter(pf);
 	if (ret) {
 		rte_flow_error_set(error, -ret,
@@ -4310,14 +4354,21 @@ i40e_flow_flush_tunnel_filter(struct i40e_pf *pf)
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
+	ret = ci_flow_query(&pf->flow_engine_conf, flow, actions, data, error);
+	if (ret == 0)
+		return 0;
 
 	if (!rss_rule) {
 		rte_flow_error_set(error, EINVAL,
diff --git a/drivers/net/intel/i40e/i40e_flow.h b/drivers/net/intel/i40e/i40e_flow.h
new file mode 100644
index 00000000000..c9588686619
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
2.52.0

