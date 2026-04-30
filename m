Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE80FF8875
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 11:01:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABA1340670;
	Thu, 30 Apr 2026 13:00:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 441644021F
 for <dev@dpdk.org>; Thu, 30 Apr 2026 13:00:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777546852; x=1809082852;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=RlXxpTGqUPP22rNzppmUjMl/C93rERKe30h85C0Xzmw=;
 b=nWJli6GAKfkCgRljb6R3qny684IQj9mM4ZaZtE2VXGPCBz9GurHmjde9
 30QsgO3gq+dIDbZijypgdlfoGh2Rt4VgK6tvKUpwt+fijeLIEdzRTwFkf
 ce9gAe7oE9Pq/4kuM9ROYf32mJRZ0KPcAAmR/HqM3KqCifCIbVGBuv1gB
 DV705Jn71K8ESIzdWO/Hs2oz71eWyO5jKSVZ2L6KhX0Wk3SXpI4j1vCIe
 7tFuyCoDsFc5LQGsJGEc46fLY3WlM5p7CWY4zkpMrtZsobev075p50qo+
 G/vfiNDzTSP5RfRtELu42awBaZuk7cYUVhECrXm9DkwyXqHtc/kRPa3IS w==;
X-CSE-ConnectionGUID: h8MSkfSxQVOeaUlMegoLVw==
X-CSE-MsgGUID: BOrkiaADT8+/m7o6wB9OaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="89953112"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="89953112"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 04:00:51 -0700
X-CSE-ConnectionGUID: Xmt08kPpSS+DNUj/Z8/a8w==
X-CSE-MsgGUID: 1XfBulugR/2cU4oUwa8QOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="272671432"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa001.jf.intel.com with ESMTP; 30 Apr 2026 04:00:50 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 2/4] net/i40e: implement flow dump
Date: Thu, 30 Apr 2026 12:00:45 +0100
Message-ID: <0eeac8e3162368f3448f9f300eb5120f4b978a54.1777546834.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cc3919f5b33e633d4fea632ac2126eed2b537175.1777546834.git.anatoly.burakov@intel.com>
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

Implement flow dumping API.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_flow.c | 103 +++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index 967af052ff..cb246da780 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -17,6 +17,7 @@
 #include <rte_log.h>
 #include <rte_malloc.h>
 #include <rte_tailq.h>
+#include <rte_hexdump.h>
 #include <rte_flow_driver.h>
 #include <rte_bitmap.h>
 
@@ -50,6 +51,10 @@ static int i40e_flow_query(struct rte_eth_dev *dev,
 			   struct rte_flow *flow,
 			   const struct rte_flow_action *actions,
 			   void *data, struct rte_flow_error *error);
+static int i40e_flow_dev_dump(struct rte_eth_dev *dev,
+			      struct rte_flow *flow,
+			      FILE *file,
+			      struct rte_flow_error *error);
 static int
 i40e_flow_parse_ethertype_pattern(struct rte_eth_dev *dev,
 				  const struct rte_flow_item *pattern,
@@ -141,6 +146,7 @@ const struct rte_flow_ops i40e_flow_ops = {
 	.destroy = i40e_flow_destroy,
 	.flush = i40e_flow_flush,
 	.query = i40e_flow_query,
+	.dev_dump = i40e_flow_dev_dump,
 };
 
 /* Pattern matched ethertype filter */
@@ -1256,6 +1262,103 @@ i40e_flow_parse_attr(const struct rte_flow_attr *attr,
 	return 0;
 }
 
+#define I40E_FLOW_DUMP_CHUNK_BYTES 32
+
+static const char *
+i40e_flow_rule_name(enum rte_filter_type filter_type)
+{
+	switch (filter_type) {
+	case RTE_ETH_FILTER_ETHERTYPE:
+		return "ethertype";
+	case RTE_ETH_FILTER_FDIR:
+		return "fdir";
+	case RTE_ETH_FILTER_TUNNEL:
+		return "tunnel";
+	case RTE_ETH_FILTER_HASH:
+		return "hash";
+	default:
+		return "unknown";
+	}
+}
+
+static size_t
+i40e_flow_rule_size(enum rte_filter_type filter_type)
+{
+	switch (filter_type) {
+	case RTE_ETH_FILTER_ETHERTYPE:
+		return sizeof(struct i40e_ethertype_filter);
+	case RTE_ETH_FILTER_FDIR:
+		return sizeof(struct i40e_fdir_filter);
+	case RTE_ETH_FILTER_TUNNEL:
+		return sizeof(struct i40e_tunnel_filter);
+	case RTE_ETH_FILTER_HASH:
+		return sizeof(struct i40e_rss_filter);
+	default:
+		return 0;
+	}
+}
+
+static void
+i40e_flow_dump_blob(FILE *file, const char *engine,
+		    const void *data, size_t data_len)
+{
+	const uint8_t *raw = (const uint8_t *)data;
+	const size_t nchunks =
+		(data_len + I40E_FLOW_DUMP_CHUNK_BYTES - 1) /
+		I40E_FLOW_DUMP_CHUNK_BYTES;
+	char title[64];
+	size_t ci;
+
+	fprintf(file, "FLOW DUMP: driver=i40e engine=%s\n", engine);
+	fprintf(file, "FLOW DUMP: DATA size=%zu chunks=%zu chunk_bytes=%d\n",
+		data_len, nchunks, I40E_FLOW_DUMP_CHUNK_BYTES);
+
+	for (ci = 0; ci < nchunks; ci++) {
+		const size_t off = ci * I40E_FLOW_DUMP_CHUNK_BYTES;
+		const size_t clen =
+			RTE_MIN((size_t)I40E_FLOW_DUMP_CHUNK_BYTES, data_len - off);
+
+		snprintf(title, sizeof(title), "FLOW DUMP: chunk %03zu/%03zu",
+			 ci + 1, nchunks);
+		rte_memdump(file, title, raw + off, clen);
+	}
+}
+
+static int
+i40e_flow_dev_dump(struct rte_eth_dev *dev,
+		   struct rte_flow *flow,
+		   FILE *file,
+		   struct rte_flow_error *error)
+{
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+	struct rte_flow *p_flow;
+	bool found = false;
+
+	TAILQ_FOREACH(p_flow, &pf->flow_list, node) {
+		size_t rule_size = 0;
+		const void *rule_data = NULL;
+
+		if (flow != NULL && p_flow != flow)
+			continue;
+
+		found = true;
+		if (p_flow->rule != NULL) {
+			rule_size = i40e_flow_rule_size(p_flow->filter_type);
+			rule_data = p_flow->rule;
+		}
+		i40e_flow_dump_blob(file,
+			i40e_flow_rule_name(p_flow->filter_type),
+			rule_data, rule_size);
+	}
+
+	if (flow != NULL && !found)
+		return rte_flow_error_set(error, ENOENT,
+			RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+			"Flow not found");
+
+	return 0;
+}
+
 static int
 i40e_get_outer_vlan(struct rte_eth_dev *dev, uint16_t *tpid)
 {
-- 
2.47.3

