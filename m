Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC94C369AB
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Apr 2025 07:22:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9DE974042F;
	Mon, 21 Apr 2025 09:22:37 +0200 (CEST)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mails.dpdk.org (Postfix) with ESMTP id 3C8B6402DA
 for <dev@dpdk.org>; Mon, 21 Apr 2025 09:22:33 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.162.112])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Zgxdj4RHBz2TS6G;
 Mon, 21 Apr 2025 15:22:17 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 6E2F71400DD;
 Mon, 21 Apr 2025 15:22:31 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 21 Apr 2025 15:22:30 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <aman.deep.singh@intel.com>
CC: <dev@dpdk.org>
Subject: [PATCH v2 3/4] app/testpmd: support don't adjust queue num in DCB
 command
Date: Mon, 21 Apr 2025 15:22:28 +0800
Message-ID: <20250421072229.33200-4-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250421072229.33200-1-fengchengwen@huawei.com>
References: <20250225091929.25072-1-fengchengwen@huawei.com>
 <20250421072229.33200-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

In some test scenarios, users want to test DCB by specifying the number
of Rx/Tx queues. But the "port config 0 dcb ..." command will auto
adjust Rx/Tx queue number.

This patch introduces an optional parameter "keep-qnum" which make sure
the "port config 0 dcb ..." command don't adjust Rx/Tx queue number.
The new command:

  port config 0 dcb vt off 4 pfc off keep-qnum

If this parameter is not specified, the Rx/Tx queue number was adjusted
by default.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test-pmd/cmdline.c                      | 83 ++++++++++++++++++---
 app/test-pmd/testpmd.c                      | 42 ++++++-----
 app/test-pmd/testpmd.h                      |  3 +-
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  3 +-
 4 files changed, 98 insertions(+), 33 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index e0e8f1c5f1..b96ebaae34 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -3493,14 +3493,47 @@ parse_dcb_token_prio_tc(char *param_str[], int param_num,
 	return 0;
 }
 
+#define DCB_TOKEN_PRIO_TC	"prio-tc"
+#define DCB_TOKEN_KEEP_QNUM	"keep-qnum"
+
+static int
+parse_dcb_token_find(char *split_str[], int split_num, int *param_num)
+{
+	int i;
+
+	if (strcmp(split_str[0], DCB_TOKEN_KEEP_QNUM) == 0) {
+		*param_num = 0;
+		return 0;
+	}
+
+	if (strcmp(split_str[0], DCB_TOKEN_PRIO_TC) != 0) {
+		fprintf(stderr, "Bad Argument: unknown token %s\n", split_str[0]);
+		return -EINVAL;
+	}
+
+	for (i = 1; i < split_num; i++) {
+		if ((strcmp(split_str[i], DCB_TOKEN_PRIO_TC) != 0) &&
+		    (strcmp(split_str[i], DCB_TOKEN_KEEP_QNUM) != 0))
+			continue;
+		/* find another optional parameter, then exit. */
+		break;
+	}
+
+	*param_num = i - 1;
+
+	return 0;
+}
+
 static int
 parse_dcb_token_value(char *token_str,
 		      uint8_t *pfc_en,
 		      uint8_t prio_tc[RTE_ETH_DCB_NUM_USER_PRIORITIES],
-		      uint8_t *prio_tc_en)
+		      uint8_t *prio_tc_en,
+		      uint8_t *keep_qnum)
 {
 #define MAX_TOKEN_NUM	128
 	char *split_str[MAX_TOKEN_NUM];
+	int param_num, start, ret;
 	int split_num = 0;
 	char *token;
 
@@ -3531,13 +3564,40 @@ parse_dcb_token_value(char *token_str,
 		return 0;
 
 	/* start parse optional parameter. */
-	token = split_str[1];
-	if (strcmp(token, "prio-tc") != 0) {
-		fprintf(stderr, "Bad Argument: unknown token %s\n", token);
-		return -1;
-	}
+	start = 1;
+	do {
+		param_num = 0;
+		ret = parse_dcb_token_find(&split_str[start], split_num - start, &param_num);
+		if (ret != 0)
+			return ret;
 
-	return parse_dcb_token_prio_tc(&split_str[2], split_num - 2, prio_tc, prio_tc_en);
+		token = split_str[start];
+		if (strcmp(token, DCB_TOKEN_PRIO_TC) == 0) {
+			if (*prio_tc_en == 1) {
+				fprintf(stderr, "Bad Argument: detect multiple %s token\n",
+					DCB_TOKEN_PRIO_TC);
+				return -1;
+			}
+			ret = parse_dcb_token_prio_tc(&split_str[start + 1], param_num, prio_tc,
+						      prio_tc_en);
+			if (ret != 0)
+				return ret;
+		} else {
+			/* this must be keep-qnum. */
+			if (*keep_qnum == 1) {
+				fprintf(stderr, "Bad Argument: detect multiple %s token\n",
+					DCB_TOKEN_KEEP_QNUM);
+				return -1;
+			}
+			*keep_qnum = 1;
+		}
+
+		start += param_num + 1;
+		if (start >= split_num)
+			break;
+	} while (1);
+
+	return 0;
 }
 
 static void
@@ -3550,6 +3610,7 @@ cmd_config_dcb_parsed(void *parsed_result,
 	struct rte_eth_dcb_info dcb_info;
 	portid_t port_id = res->port_id;
 	uint8_t prio_tc_en = 0;
+	uint8_t keep_qnum = 0;
 	struct rte_port *port;
 	uint8_t pfc_en = 0;
 	int ret;
@@ -3583,7 +3644,7 @@ cmd_config_dcb_parsed(void *parsed_result,
 		return;
 	}
 
-	ret = parse_dcb_token_value(res->token_str, &pfc_en, prio_tc, &prio_tc_en);
+	ret = parse_dcb_token_value(res->token_str, &pfc_en, prio_tc, &prio_tc_en, &keep_qnum);
 	if (ret != 0)
 		return;
 
@@ -3591,11 +3652,11 @@ cmd_config_dcb_parsed(void *parsed_result,
 	if (!strncmp(res->vt_en, "on", 2))
 		ret = init_port_dcb_config(port_id, DCB_VT_ENABLED,
 				(enum rte_eth_nb_tcs)res->num_tcs,
-				pfc_en, prio_tc, prio_tc_en);
+				pfc_en, prio_tc, prio_tc_en, keep_qnum);
 	else
 		ret = init_port_dcb_config(port_id, DCB_ENABLED,
 				(enum rte_eth_nb_tcs)res->num_tcs,
-				pfc_en, prio_tc, prio_tc_en);
+				pfc_en, prio_tc, prio_tc_en, keep_qnum);
 	if (ret != 0) {
 		fprintf(stderr, "Cannot initialize network ports.\n");
 		return;
@@ -3628,7 +3689,7 @@ static cmdline_parse_token_string_t cmd_config_dcb_token_str =
 static cmdline_parse_inst_t cmd_config_dcb = {
 	.f = cmd_config_dcb_parsed,
 	.data = NULL,
-	.help_str = "port config <port-id> dcb vt on|off <num_tcs> pfc on|off prio-tc PRIO-MAP\n"
+	.help_str = "port config <port-id> dcb vt on|off <num_tcs> pfc on|off prio-tc PRIO-MAP keep-qnum\n"
 		    "where PRIO-MAP: [ PRIO-MAP ] PRIO-MAPPING\n"
 		    "	   PRIO-MAPPING := PRIO:TC\n"
 		    "	   PRIO: { 0 .. 7 }\n"
diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index 7124626356..3b6b879659 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -4204,7 +4204,8 @@ init_port_dcb_config(portid_t pid,
 		     enum rte_eth_nb_tcs num_tcs,
 		     uint8_t pfc_en,
 		     uint8_t prio_tc[RTE_ETH_DCB_NUM_USER_PRIORITIES],
-		     uint8_t prio_tc_en)
+		     uint8_t prio_tc_en,
+		     uint8_t keep_qnum)
 {
 	struct rte_eth_conf port_conf;
 	struct rte_port *rte_port;
@@ -4252,26 +4253,27 @@ init_port_dcb_config(portid_t pid,
 		return -1;
 	}
 
-	/* Assume the ports in testpmd have the same dcb capability
-	 * and has the same number of rxq and txq in dcb mode
-	 */
-	if (dcb_mode == DCB_VT_ENABLED) {
-		if (rte_port->dev_info.max_vfs > 0) {
-			nb_rxq = rte_port->dev_info.nb_rx_queues;
-			nb_txq = rte_port->dev_info.nb_tx_queues;
-		} else {
-			nb_rxq = rte_port->dev_info.max_rx_queues;
-			nb_txq = rte_port->dev_info.max_tx_queues;
-		}
-	} else {
-		/*if vt is disabled, use all pf queues */
-		if (rte_port->dev_info.vmdq_pool_base == 0) {
-			nb_rxq = rte_port->dev_info.max_rx_queues;
-			nb_txq = rte_port->dev_info.max_tx_queues;
+	if (keep_qnum == 0) {
+		/* Assume the ports in testpmd have the same dcb capability
+		 * and has the same number of rxq and txq in dcb mode
+		 */
+		if (dcb_mode == DCB_VT_ENABLED) {
+			if (rte_port->dev_info.max_vfs > 0) {
+				nb_rxq = rte_port->dev_info.nb_rx_queues;
+				nb_txq = rte_port->dev_info.nb_tx_queues;
+			} else {
+				nb_rxq = rte_port->dev_info.max_rx_queues;
+				nb_txq = rte_port->dev_info.max_tx_queues;
+			}
 		} else {
-			nb_rxq = (queueid_t)num_tcs;
-			nb_txq = (queueid_t)num_tcs;
-
+			/*if vt is disabled, use all pf queues */
+			if (rte_port->dev_info.vmdq_pool_base == 0) {
+				nb_rxq = rte_port->dev_info.max_rx_queues;
+				nb_txq = rte_port->dev_info.max_tx_queues;
+			} else {
+				nb_rxq = (queueid_t)num_tcs;
+				nb_txq = (queueid_t)num_tcs;
+			}
 		}
 	}
 	rx_free_thresh = 64;
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index 29ba7bae8d..e629edaa02 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -1153,7 +1153,8 @@ int init_port_dcb_config(portid_t pid, enum dcb_mode_enable dcb_mode,
 		     enum rte_eth_nb_tcs num_tcs,
 		     uint8_t pfc_en,
 		     uint8_t prio_tc[RTE_ETH_DCB_NUM_USER_PRIORITIES],
-		     uint8_t prio_tc_en);
+		     uint8_t prio_tc_en,
+		     uint8_t keep_qnum);
 int start_port(portid_t pid);
 void stop_port(portid_t pid);
 void close_port(portid_t pid);
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index 3cbc377271..44eed3f49d 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -2165,10 +2165,11 @@ port config - DCB
 
 Set the DCB mode for an individual port::
 
-   testpmd> port config (port_id) dcb vt (on|off) (traffic_class) pfc (on|off) prio-tc (prio-tc)
+   testpmd> port config (port_id) dcb vt (on|off) (traffic_class) pfc (on|off) prio-tc (prio-tc) keep-qnum
 
 The traffic class could be 2~8.
 The prio-tc field here is optional, if not specified then the prio-tc use default configuration.
+The keep-qnum field here is also optional, if specified then don't adjust Rx/Tx queue number.
 
 port config - Burst
 ~~~~~~~~~~~~~~~~~~~
-- 
2.17.1

