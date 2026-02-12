Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5F6EB491F
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 12:54:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A4D0406BC;
	Thu, 12 Feb 2026 13:53:56 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 7C8E940693
 for <dev@dpdk.org>; Thu, 12 Feb 2026 13:53:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770900835; x=1802436835;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=V60p5ALu0nUMHw/gJ6RvKI7fvG/sscAu92rOUEsa5Xw=;
 b=hI3Kk9xZ2h+Ku+vBp6sfpJXCsPfV9o018NeWhCphqXhqqPxyieD2XU6p
 OY6CGB/wLFxlI2/yNQjuwkdIaApdsgeXanDpkEM1UpabrPbkaPtcu1tfY
 UKf5N+cJ+9VWdwcRpiYRmbUiri1GqAemWx5mwnDoAQmxXUwIqrCYNWAu8
 GnYRPvZJobukb1qL4jtxibFMGzVitxHl+ZhxEfkArQ9DFT+jCzLhd+c5t
 qN5r2uvXq2s6mIWA48y6DQ5mJ+mI70Lzlq8AZ+HEFaAG5QHz5xp1GXXwo
 wubF0QV5sGKEip3JKDr2wBfaToRRJBOJ1spvLKsMdJdFSxfhTqhPe/3ZZ A==;
X-CSE-ConnectionGUID: oLCpKqdORymWPseKgxqH2Q==
X-CSE-MsgGUID: qpjoXlr+SeWRjjIlPMGJUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="71785493"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="71785493"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 04:53:54 -0800
X-CSE-ConnectionGUID: KXHHjV5KTpeWmZFFnVoBTA==
X-CSE-MsgGUID: Folq5zH/RhCOyXTNXL0dPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="243179170"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 12 Feb 2026 04:53:53 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Abhijit Sinha <abhijit.sinha@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>, Radu Nicolau <radu.nicolau@intel.com>,
 Declan Doherty <declan.doherty@intel.com>
Subject: [PATCH v5 08/12] net/iavf: fix memory leak on egress IPsec flows
Date: Thu, 12 Feb 2026 12:53:31 +0000
Message-ID: <f4ad115193326c9cd2b294f6f31cffa83faff9c0.1770900758.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770900757.git.anatoly.burakov@intel.com>
 <cover.1770900757.git.anatoly.burakov@intel.com>
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

When creating egress IPsec flows, no action need to be done in hardware, as
this is just a software association. However, because we do not write
anything to the rte_flow entry, subsequent destroy call will not destroy
this kind of flow, because it expects a valid engine to be set for every
flow. This results in memory unable to be freed back to the system.

In addition to that, when creating these flows, we do not actually store
the rte_flow pointer anywhere, so even if the user has triggered `uninit`
(which would have freed the flow), this flow isn't in the list so it would
never get freed.

Fix this by marking the flow as egress IPsec flows, adding it to the tailq,
and changing the `destroy` code to take all of that into account.

Fixes: 6bc987ecb860 ("net/iavf: support IPsec inline crypto")
Cc: radu.nicolau@intel.com
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Radu Nicolau <radu.nicolau@intel.com>
Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 drivers/net/intel/iavf/iavf_generic_flow.c | 30 +++++++++++++++++-----
 drivers/net/intel/iavf/iavf_generic_flow.h |  1 +
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_generic_flow.c b/drivers/net/intel/iavf/iavf_generic_flow.c
index 6f6e95fc45..02917f863d 100644
--- a/drivers/net/intel/iavf/iavf_generic_flow.c
+++ b/drivers/net/intel/iavf/iavf_generic_flow.c
@@ -2265,8 +2265,10 @@ iavf_flow_create(struct rte_eth_dev *dev,
 	}
 
 	/* Special case for inline crypto egress flows */
-	if (attr->egress && actions[0].type == RTE_FLOW_ACTION_TYPE_SECURITY)
-		goto free_flow;
+	if (attr->egress && actions[0].type == RTE_FLOW_ACTION_TYPE_SECURITY) {
+		flow->is_ipsec_egress_flow = true;
+		goto tailq_insert;
+	}
 
 	ret = iavf_flow_process_filter(dev, flow, attr, pattern, actions,
 			&engine, iavf_parse_engine_create, error);
@@ -2278,6 +2280,7 @@ iavf_flow_create(struct rte_eth_dev *dev,
 	}
 
 	flow->engine = engine;
+tailq_insert:
 	rte_spinlock_lock(&vf->flow_ops_lock);
 	TAILQ_INSERT_TAIL(&vf->flow_list, flow, node);
 	rte_spinlock_unlock(&vf->flow_ops_lock);
@@ -2293,7 +2296,14 @@ iavf_flow_is_valid(struct rte_flow *flow)
 	struct iavf_flow_engine *engine;
 	void *temp;
 
-	if (flow && flow->engine) {
+	if (flow == NULL)
+		return false;
+
+	/* these flows don't use engines */
+	if (flow->is_ipsec_egress_flow)
+		return true;
+
+	if (flow->engine) {
 		RTE_TAILQ_FOREACH_SAFE(engine, &engine_list, node, temp) {
 			if (engine == flow->engine)
 				return true;
@@ -2311,18 +2321,26 @@ iavf_flow_destroy(struct rte_eth_dev *dev,
 	struct iavf_adapter *ad =
 		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(ad);
+	bool need_destroy;
 	int ret = 0;
 
-	if (!iavf_flow_is_valid(flow) || !flow->engine->destroy) {
+	if (!iavf_flow_is_valid(flow)) {
 		rte_flow_error_set(error, EINVAL,
 				   RTE_FLOW_ERROR_TYPE_HANDLE,
 				   NULL, "Invalid flow destroy");
 		return -rte_errno;
 	}
+	need_destroy = !flow->is_ipsec_egress_flow;
+
+	if (need_destroy && flow->engine->destroy == NULL) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Invalid flow destroy");
+	}
 
 	rte_spinlock_lock(&vf->flow_ops_lock);
-
-	ret = flow->engine->destroy(ad, flow, error);
+	if (need_destroy)
+		ret = flow->engine->destroy(ad, flow, error);
 
 	if (!ret) {
 		TAILQ_REMOVE(&vf->flow_list, flow, node);
diff --git a/drivers/net/intel/iavf/iavf_generic_flow.h b/drivers/net/intel/iavf/iavf_generic_flow.h
index 60d8ab02b4..b11bb4cf2b 100644
--- a/drivers/net/intel/iavf/iavf_generic_flow.h
+++ b/drivers/net/intel/iavf/iavf_generic_flow.h
@@ -517,6 +517,7 @@ TAILQ_HEAD(iavf_engine_list, iavf_flow_engine);
 /* Struct to store flow created. */
 struct rte_flow {
 	TAILQ_ENTRY(rte_flow) node;
+	bool is_ipsec_egress_flow;
 	struct iavf_flow_engine *engine;
 	void *rule;
 };
-- 
2.47.3

