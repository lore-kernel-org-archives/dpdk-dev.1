Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1859FF8875
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 10:31:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 273B2402A0;
	Thu, 30 Apr 2026 12:31:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 76D834021F
 for <dev@dpdk.org>; Thu, 30 Apr 2026 12:31:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777545106; x=1809081106;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=8D+js2oQq0wZMVPfKUURL3h0BPWUht8eWV6g7X5VM4s=;
 b=Zu+JVQO/iedQm052t782l6IrqqeGNvGtv0j4oNQzpoWCjcvWRW8eGEct
 iKhmk42OHel+NliKRIv2nDsGHrncTYqzWyHaeHj2eZzQsKQJZ5TbaOtUA
 kBAY347daWqCQXaSUxOtF9sT9+zk3+qVPQUEX8d3Bmtr7UO+EPLNL39Zd
 G1ONEsRLAUEIrYHBd3B0Ny+SY6QiRXIfUdqsHmoLG7HNYRWVvQSVz3pW/
 juW8s4WdWOc76nozR1le/U+h7biuRMSR/pZfJWLfV6L2LChF06tdMT2np
 0S0h8RifOFNmekB8u52bgV61lDGcNuOrvhcMr2SMjPOjIzsbEa5N2fdIH w==;
X-CSE-ConnectionGUID: bA6tgAEmRmiI9LgvYu2nMg==
X-CSE-MsgGUID: jSzlBcrtSgaGK/cN7jFM3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="82097483"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="82097483"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 03:31:44 -0700
X-CSE-ConnectionGUID: fmoOoWWtSUmQ+0I466twRQ==
X-CSE-MsgGUID: BT6sQ032RhW9Xz+OI+PmzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="234584355"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa009.jf.intel.com with ESMTP; 30 Apr 2026 03:31:44 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v1 1/4] net/ixgbe: implement flow dump
Date: Thu, 30 Apr 2026 11:31:38 +0100
Message-ID: <8885d9b4e9d1290b5340b9eb3da06d7acb2973c2.1777545092.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
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
 drivers/net/intel/ixgbe/ixgbe_flow.c | 127 +++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 01cd4f9bde..30e9ad9010 100644
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
@@ -3581,9 +3583,134 @@ ixgbe_flow_flush(struct rte_eth_dev *dev,
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
+	return RTE_PTR_ADD(flow->rule, sizeof(struct ixgbe_filter_ele_base));
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
+ixgbe_flow_dev_dump(struct rte_eth_dev *dev,
+		    struct rte_flow *flow,
+		    FILE *file,
+		    struct rte_flow_error *error)
+{
+	struct ixgbe_adapter *ad = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
+	struct ixgbe_filter_ele_base *flow_mem_base;
+	bool found = false;
+
+	TAILQ_FOREACH(flow_mem_base, &ad->flow_list, entries) {
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

