Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E51EA8138
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 15:52:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82594409FA;
	Tue, 10 Feb 2026 16:52:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 6400C40608
 for <dev@dpdk.org>; Tue, 10 Feb 2026 16:52:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770738737; x=1802274737;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=vnR/oka4fqEvKZWchhEkd7eT8bb6WD54jGKKD96fMP8=;
 b=U5Wy3Bk3UQPo9M0v7mYvaCKglBMG3+tK5TQzDd3QQSy8rGIG/8p7Cfm0
 P51f8fDCyDYpjJh2GUg/cFu2FUzj6m+ns6t1boF1drVUEBtnuI9Pp6cS4
 lEtcLQvkVhR67yr7horRvUqo90oTi5ZxtuN4fSM5onP3ABViEtCRtqHd5
 K/n3UaqCAvpH3EeUaaaqlOXbX0H7ZbHtIIFSLOpEVI+LjKdnzRg+VnYVg
 X+hA8aOE5GFen2neI5FeywWujBimV+cNVWHq2Vx4geSlU5YqVXTxiahcX
 uNnCi3ycIXWT1jLCZWk9wxeHDn/Yj5I5VbfAhVWU3WDKYKtWJZ4Fp9YU4 Q==;
X-CSE-ConnectionGUID: FPjhfzkJRMeTCce9NMP/Jw==
X-CSE-MsgGUID: JpIh9+tDTI2a5bKRW1uRTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="71080892"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71080892"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 07:52:16 -0800
X-CSE-ConnectionGUID: WVBHt1lrSR+Cb9NSqs+0SQ==
X-CSE-MsgGUID: B+3i0w2aSbqGfmFQG0Yq9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211285377"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 10 Feb 2026 07:52:15 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Declan Doherty <declan.doherty@intel.com>,
 Radu Nicolau <radu.nicolau@intel.com>,
 Abhijit Sinha <abhijit.sinha@intel.com>
Subject: [PATCH v2 3/7] net/iavf: fix memory leak on egress IPsec flows
Date: Tue, 10 Feb 2026 15:52:05 +0000
Message-ID: <52bb4113825a9c2c897d657b7ad5c967c57ec206.1770738711.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <23738c8f043b1f65742744caa9b725d5474cb059.1770738711.git.anatoly.burakov@intel.com>
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

