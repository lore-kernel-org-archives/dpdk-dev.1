Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0F7CCFA13
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 10:31:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1ABDD4021F;
	Thu, 30 Apr 2026 12:31:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 0EFCC4021F
 for <dev@dpdk.org>; Thu, 30 Apr 2026 12:31:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777545106; x=1809081106;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=RlXxpTGqUPP22rNzppmUjMl/C93rERKe30h85C0Xzmw=;
 b=Bf2cwwrSy7p/RF2GI2+pfxYW0JOIAvoiJVTyg/DrADpMaEJJU+1r84tu
 hNW43BZV4LABhkIcT7sTg0pHQc7wum/pJEIiFe4nR8HB7WvPit+anJlYT
 O84IvcA8DpLuzSiTdmDkp/r2JpBLsb0JTdsOb5FCw1s6tkKKP9MP/KUjt
 jHyK5pz/I0sLdPWyB6EMc4IbkV4vhogk67nQ2AU+1zD9MbMsjbEsBSftr
 5HULArwkc9g/WzqkcrTDZNdDUA7it1By26VAInq/RZLMtQ7evQ93CvZ4N
 rQSLvhVBfXof81hUJh2IjM69dwvJ+SKYDqtpJAao4+o6PscDyUrSb2D2l Q==;
X-CSE-ConnectionGUID: kWwVUCiZS0SSYI85gYx1gQ==
X-CSE-MsgGUID: Xtg3Rwo0Sw6Fz3YwG4TJZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="82097486"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="82097486"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 03:31:46 -0700
X-CSE-ConnectionGUID: OHUtUUljQ26h1FWCQFe6AQ==
X-CSE-MsgGUID: 1rN7OUGETQiRFs+28biKeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="234584365"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa009.jf.intel.com with ESMTP; 30 Apr 2026 03:31:45 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v1 2/4] net/i40e: implement flow dump
Date: Thu, 30 Apr 2026 11:31:39 +0100
Message-ID: <aa14a96ebf6be825b582ba5e8d40b371ac49df9a.1777545092.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <8885d9b4e9d1290b5340b9eb3da06d7acb2973c2.1777545092.git.anatoly.burakov@intel.com>
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

