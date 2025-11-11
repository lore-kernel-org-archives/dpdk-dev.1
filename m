Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3476BCCFA18
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 09:13:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A44D40657;
	Tue, 11 Nov 2025 10:13:16 +0100 (CET)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com
 [113.46.200.221])
 by mails.dpdk.org (Postfix) with ESMTP id D212D402EF
 for <dev@dpdk.org>; Tue, 11 Nov 2025 10:13:12 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=XxzwDsoq/X4sN+piUwVoQ62j+uXT98S49maMAAK1OkY=;
 b=aYb81KkGhGxZEo6XHGr/fpXLoW5tfyEySwycIfhAZC9Lik872y2u26l9Tlge4PPFN6gv5XRZq
 3jxYGDNdQGjfRIOqKnHhS/M3K1BuAERipoyzOz5o1wo6VSR3OINqW8638iHcQ1UDMXNHMl1T6Tm
 m4YlWkUpiFu4RQBCnlL4cX0=
Received: from mail.maildlp.com (unknown [172.19.163.48])
 by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4d5LPc0XXqzRhQj;
 Tue, 11 Nov 2025 17:11:32 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 734AE18007F;
 Tue, 11 Nov 2025 17:13:10 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 11 Nov 2025 17:13:09 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>, <liuyonglong@huawei.com>,
 <yangxingui@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH v7 2/2] app/testpmd: support multi-cores process one TC
Date: Tue, 11 Nov 2025 17:13:03 +0800
Message-ID: <20251111091303.39491-3-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251111091303.39491-1-fengchengwen@huawei.com>
References: <20251104040916.25864-1-fengchengwen@huawei.com>
 <20251111091303.39491-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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

Currently, one TC can be processed by only one core, when there are a
large number of small packets, this core becomes a bottleneck.

This commit supports multi-cores process one TC, the command:

  set dcb fwd_tc_cores (tc_cores)

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test-pmd/cmdline.c                      | 48 ++++++++++++
 app/test-pmd/config.c                       | 85 ++++++++++++++++-----
 app/test-pmd/testpmd.c                      |  9 +++
 app/test-pmd/testpmd.h                      |  1 +
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  8 ++
 5 files changed, 134 insertions(+), 17 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index cbd6020bc6..97dbc008af 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -6280,6 +6280,53 @@ static cmdline_parse_inst_t cmd_set_dcb_fwd_tc = {
 	},
 };
 
+/* *** set dcb forward cores per TC *** */
+struct cmd_set_dcb_fwd_tc_cores_result {
+	cmdline_fixed_string_t set;
+	cmdline_fixed_string_t dcb;
+	cmdline_fixed_string_t fwd_tc_cores;
+	uint8_t                tc_cores;
+};
+
+static void cmd_set_dcb_fwd_tc_cores_parsed(void *parsed_result,
+					    __rte_unused struct cmdline *cl,
+					    __rte_unused void *data)
+{
+	struct cmd_set_dcb_fwd_tc_cores_result *res = parsed_result;
+	if (res->tc_cores == 0) {
+		fprintf(stderr, "Cores per-TC should not be zero!\n");
+		return;
+	}
+	dcb_fwd_tc_cores = res->tc_cores;
+	printf("Set cores-per-TC: %u\n", dcb_fwd_tc_cores);
+}
+
+static cmdline_parse_token_string_t cmd_set_dcb_fwd_tc_cores_set =
+	TOKEN_STRING_INITIALIZER(struct cmd_set_dcb_fwd_tc_cores_result,
+			set, "set");
+static cmdline_parse_token_string_t cmd_set_dcb_fwd_tc_cores_dcb =
+	TOKEN_STRING_INITIALIZER(struct cmd_set_dcb_fwd_tc_cores_result,
+			dcb, "dcb");
+static cmdline_parse_token_string_t cmd_set_dcb_fwd_tc_cores_fwdtccores =
+	TOKEN_STRING_INITIALIZER(struct cmd_set_dcb_fwd_tc_cores_result,
+			fwd_tc_cores, "fwd_tc_cores");
+static cmdline_parse_token_num_t cmd_set_dcb_fwd_tc_cores_tccores =
+	TOKEN_NUM_INITIALIZER(struct cmd_set_dcb_fwd_tc_cores_result,
+			tc_cores, RTE_UINT8);
+
+static cmdline_parse_inst_t cmd_set_dcb_fwd_tc_cores = {
+	.f = cmd_set_dcb_fwd_tc_cores_parsed,
+	.data = NULL,
+	.help_str = "config DCB forwarding cores per-TC, 1-means one core process all queues of a TC.",
+	.tokens = {
+		(void *)&cmd_set_dcb_fwd_tc_cores_set,
+		(void *)&cmd_set_dcb_fwd_tc_cores_dcb,
+		(void *)&cmd_set_dcb_fwd_tc_cores_fwdtccores,
+		(void *)&cmd_set_dcb_fwd_tc_cores_tccores,
+		NULL,
+	},
+};
+
 /* *** SET BURST TX DELAY TIME RETRY NUMBER *** */
 struct cmd_set_burst_tx_retry_result {
 	cmdline_fixed_string_t set;
@@ -14060,6 +14107,7 @@ static cmdline_parse_ctx_t builtin_ctx[] = {
 	&cmd_set_fwd_mode,
 	&cmd_set_fwd_retry_mode,
 	&cmd_set_dcb_fwd_tc,
+	&cmd_set_dcb_fwd_tc_cores,
 	&cmd_set_burst_tx_retry,
 	&cmd_set_promisc_mode_one,
 	&cmd_set_promisc_mode_all,
diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index 88c1e99c5e..6ea506254b 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -5112,6 +5112,36 @@ rss_fwd_config_setup(void)
 	}
 }
 
+static int
+dcb_fwd_check_cores_per_tc(void)
+{
+	struct rte_eth_dcb_info dcb_info = {0};
+	uint32_t port, tc, vmdq_idx;
+
+	if (dcb_fwd_tc_cores == 1)
+		return 0;
+
+	for (port = 0; port < nb_fwd_ports; port++) {
+		(void)rte_eth_dev_get_dcb_info(fwd_ports_ids[port], &dcb_info);
+		for (tc = 0; tc < dcb_info.nb_tcs; tc++) {
+			for (vmdq_idx = 0; vmdq_idx < RTE_ETH_MAX_VMDQ_POOL; vmdq_idx++) {
+				if (dcb_info.tc_queue.tc_rxq[vmdq_idx][tc].nb_queue == 0)
+					break;
+				/* make sure nb_rx_queue can be divisible. */
+				if (dcb_info.tc_queue.tc_rxq[vmdq_idx][tc].nb_queue %
+					dcb_fwd_tc_cores)
+					return -1;
+				/* make sure nb_tx_queue can be divisible. */
+				if (dcb_info.tc_queue.tc_txq[vmdq_idx][tc].nb_queue %
+					dcb_fwd_tc_cores)
+					return -1;
+			}
+		}
+	}
+
+	return 0;
+}
+
 static uint16_t
 get_fwd_port_total_tc_num(void)
 {
@@ -5164,14 +5194,17 @@ dcb_fwd_tc_update_dcb_info(struct rte_eth_dcb_info *org_dcb_info)
 }
 
 /**
- * For the DCB forwarding test, each core is assigned on each traffic class.
+ * For the DCB forwarding test, each core is assigned on each traffic class
+ * defaultly:
+ *   Each core is assigned a multi-stream, each stream being composed of
+ *   a RX queue to poll on a RX port for input messages, associated with
+ *   a TX queue of a TX port where to send forwarded packets. All RX and
+ *   TX queues are mapping to the same traffic class.
+ *   If VMDQ and DCB co-exist, each traffic class on different POOLs share
+ *   the same core.
  *
- * Each core is assigned a multi-stream, each stream being composed of
- * a RX queue to poll on a RX port for input messages, associated with
- * a TX queue of a TX port where to send forwarded packets. All RX and
- * TX queues are mapping to the same traffic class.
- * If VMDQ and DCB co-exist, each traffic class on different POOLs share
- * the same core
+ * If user set cores-per-TC to other value (e.g. 2), then there will multiple
+ * cores to process one TC.
  */
 static void
 dcb_fwd_config_setup(void)
@@ -5179,9 +5212,10 @@ dcb_fwd_config_setup(void)
 	struct rte_eth_dcb_info rxp_dcb_info, txp_dcb_info;
 	portid_t txp, rxp = 0;
 	queueid_t txq, rxq = 0;
-	lcoreid_t  lc_id;
+	lcoreid_t  lc_id, target_lcores;
 	uint16_t nb_rx_queue, nb_tx_queue;
 	uint16_t i, j, k, sm_id = 0;
+	uint16_t sub_core_idx = 0;
 	uint16_t total_tc_num;
 	struct rte_port *port;
 	uint8_t tc = 0;
@@ -5212,6 +5246,13 @@ dcb_fwd_config_setup(void)
 		}
 	}
 
+	ret = dcb_fwd_check_cores_per_tc();
+	if (ret != 0) {
+		fprintf(stderr, "Error: check forwarding cores-per-TC failed!\n");
+		cur_fwd_config.nb_fwd_lcores = 0;
+		return;
+	}
+
 	total_tc_num = get_fwd_port_total_tc_num();
 	if (total_tc_num == 0) {
 		fprintf(stderr, "Error: total forwarding TC num is zero!\n");
@@ -5219,12 +5260,17 @@ dcb_fwd_config_setup(void)
 		return;
 	}
 
-	cur_fwd_config.nb_fwd_lcores = (lcoreid_t) nb_fwd_lcores;
+	target_lcores = (lcoreid_t)total_tc_num * (lcoreid_t)dcb_fwd_tc_cores;
+	if (nb_fwd_lcores < target_lcores) {
+		fprintf(stderr, "Error: the number of forwarding cores is insufficient!\n");
+		cur_fwd_config.nb_fwd_lcores = 0;
+		return;
+	}
+
+	cur_fwd_config.nb_fwd_lcores = target_lcores;
 	cur_fwd_config.nb_fwd_ports = nb_fwd_ports;
 	cur_fwd_config.nb_fwd_streams =
 		(streamid_t) (nb_rxq * cur_fwd_config.nb_fwd_ports);
-	if (cur_fwd_config.nb_fwd_lcores > total_tc_num)
-		cur_fwd_config.nb_fwd_lcores = total_tc_num;
 
 	/* reinitialize forwarding streams */
 	init_fwd_streams();
@@ -5247,10 +5293,12 @@ dcb_fwd_config_setup(void)
 				break;
 			k = fwd_lcores[lc_id]->stream_nb +
 				fwd_lcores[lc_id]->stream_idx;
-			rxq = rxp_dcb_info.tc_queue.tc_rxq[i][tc].base;
-			txq = txp_dcb_info.tc_queue.tc_txq[i][tc].base;
-			nb_rx_queue = rxp_dcb_info.tc_queue.tc_rxq[i][tc].nb_queue;
-			nb_tx_queue = txp_dcb_info.tc_queue.tc_txq[i][tc].nb_queue;
+			nb_rx_queue = rxp_dcb_info.tc_queue.tc_rxq[i][tc].nb_queue /
+						dcb_fwd_tc_cores;
+			nb_tx_queue = txp_dcb_info.tc_queue.tc_txq[i][tc].nb_queue /
+						dcb_fwd_tc_cores;
+			rxq = rxp_dcb_info.tc_queue.tc_rxq[i][tc].base + nb_rx_queue * sub_core_idx;
+			txq = txp_dcb_info.tc_queue.tc_txq[i][tc].base + nb_tx_queue * sub_core_idx;
 			for (j = 0; j < nb_rx_queue; j++) {
 				struct fwd_stream *fs;
 
@@ -5262,11 +5310,14 @@ dcb_fwd_config_setup(void)
 				fs->peer_addr = fs->tx_port;
 				fs->retry_enabled = retry_enabled;
 			}
-			fwd_lcores[lc_id]->stream_nb +=
-				rxp_dcb_info.tc_queue.tc_rxq[i][tc].nb_queue;
+			sub_core_idx++;
+			fwd_lcores[lc_id]->stream_nb += nb_rx_queue;
 		}
 		sm_id = (streamid_t) (sm_id + fwd_lcores[lc_id]->stream_nb);
+		if (sub_core_idx < dcb_fwd_tc_cores)
+			continue;
 
+		sub_core_idx = 0;
 		tc++;
 		if (tc < rxp_dcb_info.nb_tcs)
 			continue;
diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index 04a4727b88..1fe41d852a 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -216,6 +216,15 @@ struct fwd_engine * fwd_engines[] = {
  * If bit-n in tc-mask is 1, then TC-n's forwarding is enabled, and vice versa.
  */
 uint8_t dcb_fwd_tc_mask = DEFAULT_DCB_FWD_TC_MASK;
+/*
+ * Poll cores per TC when DCB forwarding.
+ * E.g. 1 indicates that one core process all queues of a TC.
+ *      2 indicates that two cores process all queues of a TC. If there
+ *        is a TC with 8 queues, then [0, 3] belong to first core, and
+ *        [4, 7] belong to second core.
+ *      ...
+ */
+uint8_t dcb_fwd_tc_cores = 1;
 
 struct rte_mempool *mempools[RTE_MAX_NUMA_NODES * MAX_SEGS_BUFFER_SPLIT];
 uint16_t mempool_flags;
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index 1ada0de450..492b5757f1 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -486,6 +486,7 @@ extern cmdline_parse_inst_t cmd_set_flex_spec_pattern;
 
 #define DEFAULT_DCB_FWD_TC_MASK	0xFF
 extern uint8_t dcb_fwd_tc_mask;
+extern uint8_t dcb_fwd_tc_cores;
 
 extern uint16_t mempool_flags;
 
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index 628f17fed7..209e88d531 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -1885,6 +1885,14 @@ forwarding is enabled, and vice versa::
 
    testpmd> set dcb fwd_tc (tc_mask)
 
+set dcb fwd_tc_cores
+~~~~~~~~~~~~~~~~~~~~
+
+Config DCB forwarding cores per-TC, 1-means one core process all queues of a TC,
+2-means two cores process all queues of a TC, and so on::
+
+   testpmd> set dcb fwd_tc_cores (tc_cores)
+
 Port Functions
 --------------
 
-- 
2.17.1

