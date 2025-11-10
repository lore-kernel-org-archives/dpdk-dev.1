Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C1BCCF9E3
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 07:36:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 681E2402E1;
	Mon, 10 Nov 2025 08:36:21 +0100 (CET)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com
 [113.46.200.221])
 by mails.dpdk.org (Postfix) with ESMTP id B73E6400D5
 for <dev@dpdk.org>; Mon, 10 Nov 2025 08:36:18 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=++OLnVBj/T0sSs+hg3lF3uVrkh5+vCZgpK/QcD7XobY=;
 b=1knmP48WkEwIIMD/xkkP6TBC6a5K2QL5AJQXmtsU8eOSiwwnf1khSSFwqVVjbh58xQGbFgpHw
 H9HEYFhKwKNrJhAiUie71DRCrh3PsWz4HM/57+V3JlA85jozk/+3vX5o9DHJemcvmAQbaz2/FHi
 m1reQq4SPKOGS1fi6vM0OTg=
Received: from mail.maildlp.com (unknown [172.19.163.252])
 by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4d4hJH02qNzRhTn;
 Mon, 10 Nov 2025 15:34:39 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id B83C3180B67;
 Mon, 10 Nov 2025 15:36:16 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 10 Nov 2025 15:36:16 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>, <liuyonglong@huawei.com>,
 <yangxingui@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH v5 1/2] app/testpmd: support specify TCs when DCB forward
Date: Mon, 10 Nov 2025 15:36:09 +0800
Message-ID: <20251110073610.14020-2-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251110073610.14020-1-fengchengwen@huawei.com>
References: <20251104040916.25864-1-fengchengwen@huawei.com>
 <20251110073610.14020-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

This commit supports specify TCs when DCB forwarding, the command:

  set dcb fwd_tc (tc_mask)

The background of this command: only some TCs are expected to generate
traffic when the DCB function is tested based on txonly forwarding, we
could use this command to specify TCs to be used.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test-pmd/cmdline.c                      | 57 +++++++++++++++++++++
 app/test-pmd/config.c                       | 50 +++++++++++++++++-
 app/test-pmd/testpmd.c                      |  6 +++
 app/test-pmd/testpmd.h                      |  3 ++
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  8 +++
 5 files changed, 122 insertions(+), 2 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 22afbdbad3..cbd6020bc6 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -511,6 +511,9 @@ static void cmd_help_long_parsed(void *parsed_result,
 			"set fwd (%s)\n"
 			"    Set packet forwarding mode.\n\n"
 
+			"set dcb fwd_tc (tc_mask)\n"
+			"    Set dcb forwarding on specify TCs, if bit-n in tc-mask is 1, then TC-n's forwarding is enabled\n\n"
+
 			"mac_addr add (port_id) (XX:XX:XX:XX:XX:XX)\n"
 			"    Add a MAC address on port_id.\n\n"
 
@@ -6224,6 +6227,59 @@ static void cmd_set_fwd_retry_mode_init(void)
 	token_struct->string_data.str = token;
 }
 
+/* *** set dcb forward TCs *** */
+struct cmd_set_dcb_fwd_tc_result {
+	cmdline_fixed_string_t set;
+	cmdline_fixed_string_t dcb;
+	cmdline_fixed_string_t fwd_tc;
+	uint8_t                tc_mask;
+};
+
+static void cmd_set_dcb_fwd_tc_parsed(void *parsed_result,
+				      __rte_unused struct cmdline *cl,
+				      __rte_unused void *data)
+{
+	struct cmd_set_dcb_fwd_tc_result *res = parsed_result;
+	int i;
+	if (res->tc_mask == 0) {
+		fprintf(stderr, "TC mask should not be zero!\n");
+		return;
+	}
+	printf("Enabled DCB forwarding TC list:");
+	dcb_fwd_tc_mask = res->tc_mask;
+	for (i = 0; i < RTE_ETH_8_TCS; i++) {
+		if (dcb_fwd_tc_mask & (1u << i))
+			printf(" %d", i);
+	}
+	printf("\n");
+}
+
+static cmdline_parse_token_string_t cmd_set_dcb_fwd_tc_set =
+	TOKEN_STRING_INITIALIZER(struct cmd_set_dcb_fwd_tc_result,
+			set, "set");
+static cmdline_parse_token_string_t cmd_set_dcb_fwd_tc_dcb =
+	TOKEN_STRING_INITIALIZER(struct cmd_set_dcb_fwd_tc_result,
+			dcb, "dcb");
+static cmdline_parse_token_string_t cmd_set_dcb_fwd_tc_fwdtc =
+	TOKEN_STRING_INITIALIZER(struct cmd_set_dcb_fwd_tc_result,
+			fwd_tc, "fwd_tc");
+static cmdline_parse_token_num_t cmd_set_dcb_fwd_tc_tcmask =
+	TOKEN_NUM_INITIALIZER(struct cmd_set_dcb_fwd_tc_result,
+			tc_mask, RTE_UINT8);
+
+static cmdline_parse_inst_t cmd_set_dcb_fwd_tc = {
+	.f = cmd_set_dcb_fwd_tc_parsed,
+	.data = NULL,
+	.help_str = "config DCB forwarding on specify TCs, if bit-n in tc-mask is 1, then TC-n's forwarding is enabled, and vice versa.",
+	.tokens = {
+		(void *)&cmd_set_dcb_fwd_tc_set,
+		(void *)&cmd_set_dcb_fwd_tc_dcb,
+		(void *)&cmd_set_dcb_fwd_tc_fwdtc,
+		(void *)&cmd_set_dcb_fwd_tc_tcmask,
+		NULL,
+	},
+};
+
 /* *** SET BURST TX DELAY TIME RETRY NUMBER *** */
 struct cmd_set_burst_tx_retry_result {
 	cmdline_fixed_string_t set;
@@ -14003,6 +14059,7 @@ static cmdline_parse_ctx_t builtin_ctx[] = {
 	&cmd_set_fwd_mask,
 	&cmd_set_fwd_mode,
 	&cmd_set_fwd_retry_mode,
+	&cmd_set_dcb_fwd_tc,
 	&cmd_set_burst_tx_retry,
 	&cmd_set_promisc_mode_one,
 	&cmd_set_promisc_mode_all,
diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index 8557371488..88c1e99c5e 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -5121,12 +5121,48 @@ get_fwd_port_total_tc_num(void)
 
 	for (i = 0; i < nb_fwd_ports; i++) {
 		(void)rte_eth_dev_get_dcb_info(fwd_ports_ids[i], &dcb_info);
-		total_tc_num += dcb_info.nb_tcs;
+		total_tc_num += rte_popcount32(dcb_fwd_tc_mask & ((1u << dcb_info.nb_tcs) - 1));
 	}
 
 	return total_tc_num;
 }
 
+static void
+dcb_fwd_tc_update_dcb_info(struct rte_eth_dcb_info *org_dcb_info)
+{
+	struct rte_eth_dcb_info dcb_info = {0};
+	uint32_t i, vmdq_idx;
+	uint32_t tc = 0;
+
+	if (dcb_fwd_tc_mask == DEFAULT_DCB_FWD_TC_MASK)
+		return;
+
+	/*
+	 * Use compress scheme to update dcb-info.
+	 * E.g. If org_dcb_info->nb_tcs is 4 and dcb_fwd_tc_mask is 0x8, it
+	 *      means only enable TC3, then the new dcb-info's nb_tcs is set to
+	 *      1, and also move corresponding tc_rxq and tc_txq info to new
+	 *      index.
+	 */
+	for (i = 0; i < org_dcb_info->nb_tcs; i++) {
+		if (!(dcb_fwd_tc_mask & (1u << i)))
+			continue;
+		for (vmdq_idx = 0; vmdq_idx < RTE_ETH_MAX_VMDQ_POOL; vmdq_idx++) {
+			dcb_info.tc_queue.tc_rxq[vmdq_idx][tc].base =
+				org_dcb_info->tc_queue.tc_rxq[vmdq_idx][i].base;
+			dcb_info.tc_queue.tc_rxq[vmdq_idx][tc].nb_queue =
+				org_dcb_info->tc_queue.tc_rxq[vmdq_idx][i].nb_queue;
+			dcb_info.tc_queue.tc_txq[vmdq_idx][tc].base =
+				org_dcb_info->tc_queue.tc_txq[vmdq_idx][i].base;
+			dcb_info.tc_queue.tc_txq[vmdq_idx][tc].nb_queue =
+				org_dcb_info->tc_queue.tc_txq[vmdq_idx][i].nb_queue;
+		}
+		tc++;
+	}
+	dcb_info.nb_tcs = tc;
+	*org_dcb_info = dcb_info;
+}
+
 /**
  * For the DCB forwarding test, each core is assigned on each traffic class.
  *
@@ -5176,11 +5212,17 @@ dcb_fwd_config_setup(void)
 		}
 	}
 
+	total_tc_num = get_fwd_port_total_tc_num();
+	if (total_tc_num == 0) {
+		fprintf(stderr, "Error: total forwarding TC num is zero!\n");
+		cur_fwd_config.nb_fwd_lcores = 0;
+		return;
+	}
+
 	cur_fwd_config.nb_fwd_lcores = (lcoreid_t) nb_fwd_lcores;
 	cur_fwd_config.nb_fwd_ports = nb_fwd_ports;
 	cur_fwd_config.nb_fwd_streams =
 		(streamid_t) (nb_rxq * cur_fwd_config.nb_fwd_ports);
-	total_tc_num = get_fwd_port_total_tc_num();
 	if (cur_fwd_config.nb_fwd_lcores > total_tc_num)
 		cur_fwd_config.nb_fwd_lcores = total_tc_num;
 
@@ -5190,7 +5232,9 @@ dcb_fwd_config_setup(void)
 	txp = fwd_topology_tx_port_get(rxp);
 	/* get the dcb info on the first RX and TX ports */
 	(void)rte_eth_dev_get_dcb_info(fwd_ports_ids[rxp], &rxp_dcb_info);
+	dcb_fwd_tc_update_dcb_info(&rxp_dcb_info);
 	(void)rte_eth_dev_get_dcb_info(fwd_ports_ids[txp], &txp_dcb_info);
+	dcb_fwd_tc_update_dcb_info(&txp_dcb_info);
 
 	for (lc_id = 0; lc_id < cur_fwd_config.nb_fwd_lcores; lc_id++) {
 		fwd_lcores[lc_id]->stream_nb = 0;
@@ -5238,7 +5282,9 @@ dcb_fwd_config_setup(void)
 		txp = fwd_topology_tx_port_get(rxp);
 		/* get the dcb information on next RX and TX ports */
 		rte_eth_dev_get_dcb_info(fwd_ports_ids[rxp], &rxp_dcb_info);
+		dcb_fwd_tc_update_dcb_info(&rxp_dcb_info);
 		rte_eth_dev_get_dcb_info(fwd_ports_ids[txp], &txp_dcb_info);
+		dcb_fwd_tc_update_dcb_info(&txp_dcb_info);
 	}
 }
 
diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index 2360da3a48..9d0ce5660c 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -211,6 +211,12 @@ struct fwd_engine * fwd_engines[] = {
 	NULL,
 };
 
+/*
+ * Bitmask for control DCB forwarding for TCs.
+ * If bit-n in tc-mask is 1, then TC-n's forwarding is enabled, and vice versa.
+ */
+uint8_t dcb_fwd_tc_mask = DEFAULT_DCB_FWD_TC_MASK;
+
 struct rte_mempool *mempools[RTE_MAX_NUMA_NODES * MAX_SEGS_BUFFER_SPLIT];
 uint16_t mempool_flags;
 
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index fa46865c67..1ada0de450 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -484,6 +484,9 @@ extern cmdline_parse_inst_t cmd_show_set_raw_all;
 extern cmdline_parse_inst_t cmd_set_flex_is_pattern;
 extern cmdline_parse_inst_t cmd_set_flex_spec_pattern;
 
+#define DEFAULT_DCB_FWD_TC_MASK	0xFF
+extern uint8_t dcb_fwd_tc_mask;
+
 extern uint16_t mempool_flags;
 
 /**
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index e423abd40e..628f17fed7 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -1877,6 +1877,14 @@ Set a controllable LED associated with a certain port on or off::
 
    testpmd> set port (port_id) led (on|off)
 
+set dcb fwd_tc
+~~~~~~~~~~~~~~
+
+Config DCB forwarding on specify TCs, if bit-n in tc-mask is 1, then TC-n's
+forwarding is enabled, and vice versa::
+
+   testpmd> set dcb fwd_tc (tc_mask)
+
 Port Functions
 --------------
 
-- 
2.17.1

