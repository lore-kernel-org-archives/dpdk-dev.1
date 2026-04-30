Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21024CCFA13
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 11:00:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67B694028C;
	Thu, 30 Apr 2026 13:00:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id A9B2E4021F
 for <dev@dpdk.org>; Thu, 30 Apr 2026 13:00:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777546851; x=1809082851;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=4n0A/HWN5Ni2YQmjMdMd+T+0JyHbSsYWaxA3O1GumxA=;
 b=TL14R9poERJvf1xQIfDLI/rSDcVRbIysjsj+Juzw9IfkwRYCN4HR6NSG
 xOnz6xVCuadfTwBoSlId71k+kW5NH7e1qXKFG2mQ04rT79giOgx/p6rEB
 40I3ZgDLVYuvtEx2cXMQWw/ka1LIpv9HgfcgReyzrzpzzUFHtVI+WYgWE
 jUngJPkTLWgVnuasTAmDMDzY2jWKJ14x2/YHIQe6a5x1/d+DMxJi6dyVE
 MHOyDqlCRKpVuUnt6kiSYrnj+jcEEqzx2CyRo5Z40t+93Vtrs+gATAqYE
 m0tjjEvfKkkcmCz29JZ+cJmjnGP6Hy8TU9rs7zxoK+gltqN7Ikb1VjQLU g==;
X-CSE-ConnectionGUID: nDUKUkLRTeaeSR7ttwTOvw==
X-CSE-MsgGUID: FwnFmKjiSV+MXfKZRoC+mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="89953111"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="89953111"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 04:00:50 -0700
X-CSE-ConnectionGUID: 3v5e+5GgTmupC64Lyb5ZpQ==
X-CSE-MsgGUID: 2oG0dQtKTvWpSWi/TGXehQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="272671424"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa001.jf.intel.com with ESMTP; 30 Apr 2026 04:00:49 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2 1/4] net/ixgbe: implement flow dump
Date: Thu, 30 Apr 2026 12:00:44 +0100
Message-ID: <cc3919f5b33e633d4fea632ac2126eed2b537175.1777546834.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <8885d9b4e9d1290b5340b9eb3da06d7acb2973c2.1777545092.git.anatoly.burakov@intel.com>
References: <8885d9b4e9d1290b5340b9eb3da06d7acb2973c2.1777545092.git.anatoly.burakov@intel.com>
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
 drivers/net/intel/ixgbe/ixgbe_ethdev.h |   3 +
 drivers/net/intel/ixgbe/ixgbe_flow.c   | 141 +++++++++++++++++++++++++
 2 files changed, 144 insertions(+)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index 32d7b98ed1..3f00896943 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -515,6 +515,9 @@ uint16_t ixgbe_vf_representor_tx_burst(void *tx_queue, struct rte_mbuf **tx_pkts
 #define IXGBE_DEV_FDIR_CONF(dev) \
 	(&((struct ixgbe_adapter *)(dev)->data->dev_private)->fdir_conf)
 
+#define IXGBE_DEV_PRIVATE_TO_ADAPTER(adapter) \
+	((struct ixgbe_adapter *)adapter)
+
 #define IXGBE_DEV_PRIVATE_TO_HW(adapter)\
 	(&((struct ixgbe_adapter *)adapter)->hw)
 
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 01cd4f9bde..e40ece9755 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -6,6 +6,7 @@
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
+#include <stddef.h>
 #include <string.h>
 #include <unistd.h>
 #include <stdarg.h>
@@ -29,6 +30,7 @@
 #include <dev_driver.h>
 #include <rte_hash_crc.h>
 #include <rte_flow.h>
+#include <rte_hexdump.h>
 #include <rte_flow_driver.h>
 
 #include "ixgbe_logs.h"
@@ -3581,9 +3583,148 @@ ixgbe_flow_flush(struct rte_eth_dev *dev,
 	return 0;
 }
 
+#define IXGBE_FLOW_DUMP_CHUNK_BYTES 32
+
+static const char *
+ixgbe_flow_rule_engine_name(const struct rte_flow *flow)
+{
+	if (flow->is_security)
+		return "security";
+
+	switch (flow->filter_type) {
+	case RTE_ETH_FILTER_NTUPLE:
+		return "ntuple";
+	case RTE_ETH_FILTER_ETHERTYPE:
+		return "ethertype";
+	case RTE_ETH_FILTER_SYN:
+		return "syn";
+	case RTE_ETH_FILTER_FDIR:
+		return "fdir";
+	case RTE_ETH_FILTER_L2_TUNNEL:
+		return "l2_tunnel";
+	case RTE_ETH_FILTER_HASH:
+		return "hash";
+	default:
+		return "unknown";
+	}
+}
+
+static size_t
+ixgbe_flow_rule_size(const struct rte_flow *flow)
+{
+	if (flow->is_security)
+		return 0;
+
+	switch (flow->filter_type) {
+	case RTE_ETH_FILTER_NTUPLE:
+		return sizeof(struct rte_eth_ntuple_filter);
+	case RTE_ETH_FILTER_ETHERTYPE:
+		return sizeof(struct rte_eth_ethertype_filter);
+	case RTE_ETH_FILTER_SYN:
+		return sizeof(struct rte_eth_syn_filter);
+	case RTE_ETH_FILTER_FDIR:
+		return sizeof(struct ixgbe_fdir_rule);
+	case RTE_ETH_FILTER_L2_TUNNEL:
+		return sizeof(struct ixgbe_l2_tunnel_conf);
+	case RTE_ETH_FILTER_HASH:
+		return sizeof(struct ixgbe_rte_flow_rss_conf);
+	default:
+		return 0;
+	}
+}
+
+static const void *
+ixgbe_flow_rule_data(const struct rte_flow *flow)
+{
+	if (flow->is_security || flow->rule == NULL)
+		return NULL;
+
+	switch (flow->filter_type) {
+	case RTE_ETH_FILTER_NTUPLE:
+		return RTE_PTR_ADD(flow->rule, sizeof(TAILQ_ENTRY(ixgbe_ntuple_filter_ele)));
+	case RTE_ETH_FILTER_ETHERTYPE:
+		return RTE_PTR_ADD(flow->rule, sizeof(TAILQ_ENTRY(ixgbe_ethertype_filter_ele)));
+	case RTE_ETH_FILTER_SYN:
+		return RTE_PTR_ADD(flow->rule, sizeof(TAILQ_ENTRY(ixgbe_eth_syn_filter_ele)));
+	case RTE_ETH_FILTER_FDIR:
+		return RTE_PTR_ADD(flow->rule, sizeof(TAILQ_ENTRY(ixgbe_fdir_rule_ele)));
+	case RTE_ETH_FILTER_L2_TUNNEL:
+		return RTE_PTR_ADD(flow->rule, sizeof(TAILQ_ENTRY(ixgbe_eth_l2_tunnel_conf_ele)));
+	case RTE_ETH_FILTER_HASH:
+		return RTE_PTR_ADD(flow->rule, sizeof(TAILQ_ENTRY(ixgbe_rss_conf_ele)));
+	default:
+		return NULL;
+	}
+}
+
+static void
+ixgbe_flow_dump_blob(FILE *file, const char *engine,
+		     const void *data, size_t data_len)
+{
+	const uint8_t *raw = (const uint8_t *)data;
+	const size_t nchunks =
+		(data_len + IXGBE_FLOW_DUMP_CHUNK_BYTES - 1) /
+		IXGBE_FLOW_DUMP_CHUNK_BYTES;
+	char title[64];
+	size_t ci;
+
+	fprintf(file, "FLOW DUMP: driver=ixgbe engine=%s\n", engine);
+	fprintf(file, "FLOW DUMP: DATA size=%zu chunks=%zu chunk_bytes=%d\n",
+		data_len, nchunks, IXGBE_FLOW_DUMP_CHUNK_BYTES);
+
+	for (ci = 0; ci < nchunks; ci++) {
+		const size_t off = ci * IXGBE_FLOW_DUMP_CHUNK_BYTES;
+		const size_t clen =
+			RTE_MIN((size_t)IXGBE_FLOW_DUMP_CHUNK_BYTES, data_len - off);
+
+		snprintf(title, sizeof(title), "FLOW DUMP: chunk %03zu/%03zu",
+			 ci + 1, nchunks);
+		rte_memdump(file, title, raw + off, clen);
+	}
+}
+
+static int
+ixgbe_flow_dev_dump(struct rte_eth_dev *dev __rte_unused,
+		    struct rte_flow *flow,
+		    FILE *file,
+		    struct rte_flow_error *error)
+{
+	struct ixgbe_flow_mem *flow_mem_base;
+	bool found = false;
+
+	TAILQ_FOREACH(flow_mem_base, &ixgbe_flow_list, entries) {
+		struct ixgbe_flow_mem *ixgbe_flow_mem_ptr =
+			(struct ixgbe_flow_mem *)flow_mem_base;
+		struct rte_flow *p_flow = ixgbe_flow_mem_ptr->flow;
+		const void *rule_data = NULL;
+		const char *engine_name;
+		size_t rule_size = 0;
+
+		if (flow != NULL && p_flow != flow)
+			continue;
+
+		found = true;
+		if (p_flow->rule != NULL) {
+			rule_data = ixgbe_flow_rule_data(p_flow);
+			rule_size = ixgbe_flow_rule_size(p_flow);
+		}
+		engine_name = ixgbe_flow_rule_engine_name(p_flow);
+		ixgbe_flow_dump_blob(file, engine_name,
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
 const struct rte_flow_ops ixgbe_flow_ops = {
 	.validate = ixgbe_flow_validate,
 	.create = ixgbe_flow_create,
 	.destroy = ixgbe_flow_destroy,
 	.flush = ixgbe_flow_flush,
+	.dev_dump = ixgbe_flow_dev_dump,
 };
-- 
2.47.3

