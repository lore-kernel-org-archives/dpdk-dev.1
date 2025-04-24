Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A829FC369AB
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Apr 2025 06:18:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4D7D402F1;
	Thu, 24 Apr 2025 08:18:00 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id C2977402ED
 for <dev@dpdk.org>; Thu, 24 Apr 2025 08:17:57 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.194])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZjlzG6GThzvWvP;
 Thu, 24 Apr 2025 14:13:46 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 6AA691402CD;
 Thu, 24 Apr 2025 14:17:56 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 24 Apr 2025 14:17:55 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <aman.deep.singh@intel.com>
CC: <dev@dpdk.org>
Subject: [PATCH v3 2/4] app/testpmd: support config prio-tc map in DCB command
Date: Thu, 24 Apr 2025 14:17:47 +0800
Message-ID: <20250424061749.44683-3-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250424061749.44683-1-fengchengwen@huawei.com>
References: <20250225091929.25072-1-fengchengwen@huawei.com>
 <20250424061749.44683-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

Currently, the "port config 0 dcb ..." command config the prio-tc map
by remainder operation, which means the prio-tc = prio % nb_tcs.

This commit introduces an optional parameter "prio-tc" which is the same
as kernel dcb ets tool. The new command:

  port config 0 dcb vt off 4 pfc off prio-tc 0:1 1:2 2:3 ...

If this parameter is not specified, the prio-tc map is configured by
default.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test-pmd/cmdline.c                      | 119 ++++++++++++++++++--
 app/test-pmd/testpmd.c                      |  21 ++--
 app/test-pmd/testpmd.h                      |   4 +-
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |   3 +-
 4 files changed, 125 insertions(+), 22 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 44fae89821..d2e745d501 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -3447,19 +3447,111 @@ struct cmd_config_dcb {
 	cmdline_fixed_string_t vt_en;
 	uint8_t num_tcs;
 	cmdline_fixed_string_t pfc;
-	cmdline_fixed_string_t pfc_en;
+	cmdline_multi_string_t token_str;
 };
 
+static int
+parse_dcb_token_prio_tc(char *param_str[], int param_num,
+			uint8_t prio_tc[RTE_ETH_DCB_NUM_USER_PRIORITIES],
+			uint8_t *prio_tc_en)
+{
+	unsigned long prio, tc;
+	int prio_tc_maps = 0;
+	char *param, *end;
+	int i;
+
+	for (i = 0; i < param_num; i++) {
+		param = param_str[i];
+		prio = strtoul(param, &end, 10);
+		if (prio >= RTE_ETH_DCB_NUM_USER_PRIORITIES) {
+			fprintf(stderr, "Bad Argument: invalid PRIO %lu\n", prio);
+			return -1;
+		}
+		if ((*end != ':') || (strlen(end + 1) == 0)) {
+			fprintf(stderr, "Bad Argument: invalid PRIO:TC format %s\n", param);
+			return -1;
+		}
+		tc = strtoul(end + 1, &end, 10);
+		if (tc >= RTE_ETH_8_TCS) {
+			fprintf(stderr, "Bad Argument: invalid TC %lu\n", tc);
+			return -1;
+		}
+		if (*end != '\0') {
+			fprintf(stderr, "Bad Argument: invalid PRIO:TC format %s\n", param);
+			return -1;
+		}
+		prio_tc[prio] = tc;
+		prio_tc_maps++;
+	} while (0);
+
+	if (prio_tc_maps == 0) {
+		fprintf(stderr, "Bad Argument: no PRIO:TC provided\n");
+		return -1;
+	}
+	*prio_tc_en = 1;
+
+	return 0;
+}
+
+static int
+parse_dcb_token_value(char *token_str,
+		      uint8_t *pfc_en,
+		      uint8_t prio_tc[RTE_ETH_DCB_NUM_USER_PRIORITIES],
+		      uint8_t *prio_tc_en)
+{
+#define MAX_TOKEN_NUM	128
+	char *split_str[MAX_TOKEN_NUM];
+	int split_num = 0;
+	char *token;
+
+	/* split multiple token to split str. */
+	do {
+		token = strtok_r(token_str, " \f\n\r\t\v", &token_str);
+		if (token == NULL)
+			break;
+		if (split_num >= MAX_TOKEN_NUM) {
+			fprintf(stderr, "Bad Argument: too much argument\n");
+			return -1;
+		}
+		split_str[split_num++] = token;
+	} while (1);
+
+	/* parse fixed parameter "pfc-en" first. */
+	token = split_str[0];
+	if (strcmp(token, "on") == 0)
+		*pfc_en = 1;
+	else if (strcmp(token, "off") == 0)
+		*pfc_en = 0;
+	else {
+		fprintf(stderr, "Bad Argument: pfc-en must be on or off\n");
+		return -EINVAL;
+	}
+
+	if (split_num == 1)
+		return 0;
+
+	/* start parse optional parameter. */
+	token = split_str[1];
+	if (strcmp(token, "prio-tc") != 0) {
+		fprintf(stderr, "Bad Argument: unknown token %s\n", token);
+		return -1;
+	}
+
+	return parse_dcb_token_prio_tc(&split_str[2], split_num - 2, prio_tc, prio_tc_en);
+}
+
 static void
 cmd_config_dcb_parsed(void *parsed_result,
                         __rte_unused struct cmdline *cl,
                         __rte_unused void *data)
 {
+	uint8_t prio_tc[RTE_ETH_DCB_NUM_USER_PRIORITIES] = {0};
 	struct cmd_config_dcb *res = parsed_result;
 	struct rte_eth_dcb_info dcb_info;
 	portid_t port_id = res->port_id;
+	uint8_t prio_tc_en = 0;
 	struct rte_port *port;
-	uint8_t pfc_en;
+	uint8_t pfc_en = 0;
 	int ret;
 
 	if (port_id_is_invalid(port_id, ENABLED_WARN))
@@ -3491,20 +3583,19 @@ cmd_config_dcb_parsed(void *parsed_result,
 		return;
 	}
 
-	if (!strncmp(res->pfc_en, "on", 2))
-		pfc_en = 1;
-	else
-		pfc_en = 0;
+	ret = parse_dcb_token_value(res->token_str, &pfc_en, prio_tc, &prio_tc_en);
+	if (ret != 0)
+		return;
 
 	/* DCB in VT mode */
 	if (!strncmp(res->vt_en, "on", 2))
 		ret = init_port_dcb_config(port_id, DCB_VT_ENABLED,
 				(enum rte_eth_nb_tcs)res->num_tcs,
-				pfc_en);
+				pfc_en, prio_tc, prio_tc_en);
 	else
 		ret = init_port_dcb_config(port_id, DCB_ENABLED,
 				(enum rte_eth_nb_tcs)res->num_tcs,
-				pfc_en);
+				pfc_en, prio_tc, prio_tc_en);
 	if (ret != 0) {
 		fprintf(stderr, "Cannot initialize network ports.\n");
 		return;
@@ -3531,13 +3622,17 @@ static cmdline_parse_token_num_t cmd_config_dcb_num_tcs =
 	TOKEN_NUM_INITIALIZER(struct cmd_config_dcb, num_tcs, RTE_UINT8);
 static cmdline_parse_token_string_t cmd_config_dcb_pfc =
         TOKEN_STRING_INITIALIZER(struct cmd_config_dcb, pfc, "pfc");
-static cmdline_parse_token_string_t cmd_config_dcb_pfc_en =
-        TOKEN_STRING_INITIALIZER(struct cmd_config_dcb, pfc_en, "on#off");
+static cmdline_parse_token_string_t cmd_config_dcb_token_str =
+	TOKEN_STRING_INITIALIZER(struct cmd_config_dcb, token_str, TOKEN_STRING_MULTI);
 
 static cmdline_parse_inst_t cmd_config_dcb = {
 	.f = cmd_config_dcb_parsed,
 	.data = NULL,
-	.help_str = "port config <port-id> dcb vt on|off <num_tcs> pfc on|off",
+	.help_str = "port config <port-id> dcb vt on|off <num_tcs> pfc on|off prio-tc PRIO-MAP\n"
+		    "where PRIO-MAP: [ PRIO-MAP ] PRIO-MAPPING\n"
+		    "	   PRIO-MAPPING := PRIO:TC\n"
+		    "	   PRIO: { 0 .. 7 }\n"
+		    "	   TC: { 0 .. 7 }",
 	.tokens = {
 		(void *)&cmd_config_dcb_port,
 		(void *)&cmd_config_dcb_config,
@@ -3547,7 +3642,7 @@ static cmdline_parse_inst_t cmd_config_dcb = {
 		(void *)&cmd_config_dcb_vt_en,
 		(void *)&cmd_config_dcb_num_tcs,
 		(void *)&cmd_config_dcb_pfc,
-		(void *)&cmd_config_dcb_pfc_en,
+		(void *)&cmd_config_dcb_token_str,
                 NULL,
         },
 };
diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index b5f0c02261..7124626356 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -4130,9 +4130,10 @@ const uint16_t vlan_tags[] = {
 
 static void
 get_eth_dcb_conf(struct rte_eth_conf *eth_conf, enum dcb_mode_enable dcb_mode,
-		 enum rte_eth_nb_tcs num_tcs, uint8_t pfc_en)
+		 enum rte_eth_nb_tcs num_tcs, uint8_t pfc_en,
+		 uint8_t prio_tc[RTE_ETH_DCB_NUM_USER_PRIORITIES], uint8_t prio_tc_en)
 {
-	uint8_t i;
+	uint8_t dcb_tc_val, i;
 
 	/*
 	 * Builds up the correct configuration for dcb+vt based on the vlan tags array
@@ -4159,8 +4160,9 @@ get_eth_dcb_conf(struct rte_eth_conf *eth_conf, enum dcb_mode_enable dcb_mode,
 				RTE_BIT64(i % vmdq_rx_conf->nb_queue_pools);
 		}
 		for (i = 0; i < RTE_ETH_DCB_NUM_USER_PRIORITIES; i++) {
-			vmdq_rx_conf->dcb_tc[i] = i % num_tcs;
-			vmdq_tx_conf->dcb_tc[i] = i % num_tcs;
+			dcb_tc_val = prio_tc_en ? prio_tc[i] : i % num_tcs;
+			vmdq_rx_conf->dcb_tc[i] = dcb_tc_val;
+			vmdq_tx_conf->dcb_tc[i] = dcb_tc_val;
 		}
 
 		/* set DCB mode of RX and TX of multiple queues */
@@ -4178,8 +4180,9 @@ get_eth_dcb_conf(struct rte_eth_conf *eth_conf, enum dcb_mode_enable dcb_mode,
 		tx_conf->nb_tcs = num_tcs;
 
 		for (i = 0; i < RTE_ETH_DCB_NUM_USER_PRIORITIES; i++) {
-			rx_conf->dcb_tc[i] = i % num_tcs;
-			tx_conf->dcb_tc[i] = i % num_tcs;
+			dcb_tc_val = prio_tc_en ? prio_tc[i] : i % num_tcs;
+			rx_conf->dcb_tc[i] = dcb_tc_val;
+			tx_conf->dcb_tc[i] = dcb_tc_val;
 		}
 
 		eth_conf->rxmode.mq_mode =
@@ -4199,7 +4202,9 @@ int
 init_port_dcb_config(portid_t pid,
 		     enum dcb_mode_enable dcb_mode,
 		     enum rte_eth_nb_tcs num_tcs,
-		     uint8_t pfc_en)
+		     uint8_t pfc_en,
+		     uint8_t prio_tc[RTE_ETH_DCB_NUM_USER_PRIORITIES],
+		     uint8_t prio_tc_en)
 {
 	struct rte_eth_conf port_conf;
 	struct rte_port *rte_port;
@@ -4216,7 +4221,7 @@ init_port_dcb_config(portid_t pid,
 	memcpy(&port_conf, &rte_port->dev_conf, sizeof(struct rte_eth_conf));
 
 	/* set configuration of DCB in vt mode and DCB in non-vt mode */
-	get_eth_dcb_conf(&port_conf, dcb_mode, num_tcs, pfc_en);
+	get_eth_dcb_conf(&port_conf, dcb_mode, num_tcs, pfc_en, prio_tc, prio_tc_en);
 
 	port_conf.rxmode.offloads |= RTE_ETH_RX_OFFLOAD_VLAN_FILTER;
 	/* remove RSS HASH offload for DCB in vt mode */
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index 05ccdec8d2..29ba7bae8d 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -1151,7 +1151,9 @@ uint8_t port_is_bonding_member(portid_t member_pid);
 
 int init_port_dcb_config(portid_t pid, enum dcb_mode_enable dcb_mode,
 		     enum rte_eth_nb_tcs num_tcs,
-		     uint8_t pfc_en);
+		     uint8_t pfc_en,
+		     uint8_t prio_tc[RTE_ETH_DCB_NUM_USER_PRIORITIES],
+		     uint8_t prio_tc_en);
 int start_port(portid_t pid);
 void stop_port(portid_t pid);
 void close_port(portid_t pid);
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index 38bc00705f..3cbc377271 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -2165,9 +2165,10 @@ port config - DCB
 
 Set the DCB mode for an individual port::
 
-   testpmd> port config (port_id) dcb vt (on|off) (traffic_class) pfc (on|off)
+   testpmd> port config (port_id) dcb vt (on|off) (traffic_class) pfc (on|off) prio-tc (prio-tc)
 
 The traffic class could be 2~8.
+The prio-tc field here is optional, if not specified then the prio-tc use default configuration.
 
 port config - Burst
 ~~~~~~~~~~~~~~~~~~~
-- 
2.17.1

