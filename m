Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFC7CD5BAB
	for <dpdk-dev@archiver.kernel.org>; Sun, 24 May 2026 09:35:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D7DF40B8C;
	Sun, 24 May 2026 11:33:28 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 09699402CC
 for <dev@dpdk.org>; Sun, 24 May 2026 11:33:11 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowABXd97QxRJq+04kEg--.9115S21;
 Sun, 24 May 2026 17:33:09 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v1 19/23] net/sxe2: add testpmd commands for private features
Date: Sun, 24 May 2026 17:32:55 +0800
Message-ID: <20260524093259.397506-20-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260524093259.397506-1-liujie5@linkdatatechnology.com>
References: <20260524093259.397506-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABXd97QxRJq+04kEg--.9115S21
X-Coremail-Antispam: 1UD129KBjvAXoWDXw15JFW5XF4rZF4DCFyxGrg_yoWxJw45Wo
 WxGr45WrnxXr17Ww4kXr1xKFWrX3yDW34qyr4S9F4DuwnrJa45KwsrGa4YvF9F9F4rtFn8
 Wa4fZws3tw4Iyan8n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUYM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
 Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
 84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r
 4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8
 Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
 x0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8
 JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xxMx
 AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
 Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwI
 xGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8
 Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0x
 vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUB89_UUUUU=
X-Originating-IP: [118.112.177.181]
X-CM-SenderInfo: xolxyxrhv6zxpqngt3pdwhux5qro0w31of0z/
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

From: Jie Liu <liujie5@linkdatatechnology.com>

Introduce private testpmd commands and implementation files to enable
debugging and testing of sxe2-specific hardware features (such as
packet scheduling reset, UDP tunnel configuration, and IPsec ingress/
egress offloads) directly within the testpmd application.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/meson.build        |   5 +-
 drivers/net/sxe2/sxe2_ethdev.c      |  26 +
 drivers/net/sxe2/sxe2_ethdev.h      |   2 +
 drivers/net/sxe2/sxe2_testpmd.c     | 733 +++++++++++++++++++++
 drivers/net/sxe2/sxe2_testpmd_lib.c | 969 ++++++++++++++++++++++++++++
 drivers/net/sxe2/sxe2_testpmd_lib.h | 142 ++++
 drivers/net/sxe2/sxe2_tm.c          |  18 +
 drivers/net/sxe2/sxe2_tm.h          |   2 +
 8 files changed, 1895 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/sxe2/sxe2_testpmd.c
 create mode 100644 drivers/net/sxe2/sxe2_testpmd_lib.c
 create mode 100644 drivers/net/sxe2/sxe2_testpmd_lib.h

diff --git a/drivers/net/sxe2/meson.build b/drivers/net/sxe2/meson.build
index 5a02b1c3d3..00a331c208 100644
--- a/drivers/net/sxe2/meson.build
+++ b/drivers/net/sxe2/meson.build
@@ -9,9 +9,10 @@ endif
 
 cflags += ['-g']
 
-deps += ['common_sxe2', 'hash','cryptodev','security']
+deps += ['common_sxe2', 'hash', 'cryptodev', 'security', 'cmdline']
 
 includes += include_directories('../../common/sxe2')
+testpmd_sources = files('sxe2_testpmd.c')
 
 if arch_subdir == 'x86'
         sources += files('sxe2_txrx_vec_sse.c')
@@ -79,7 +80,7 @@ sources += files(
         'sxe2_flow_parse_engine.c',
         'sxe2_dump.c',
         'sxe2_txrx_check_mbuf.c',
-
+        'sxe2_testpmd_lib.c',
 )
 
 allow_internal_get_api = true
diff --git a/drivers/net/sxe2/sxe2_ethdev.c b/drivers/net/sxe2/sxe2_ethdev.c
index 73a92d99f8..0b19e17c2e 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -1661,6 +1661,32 @@ static int32_t sxe2_sched_uinit(struct rte_eth_dev *dev)
 	return ret;
 }
 
+int32_t sxe2_sched_reset(struct rte_eth_dev *dev)
+{
+	int32_t ret = 0;
+
+	if (dev->data->dev_started) {
+		PMD_LOG_ERR(DRV, "Device failed to Stop.");
+		ret = -EPERM;
+		goto l_end;
+	}
+
+	ret = sxe2_tm_conf_reset(dev);
+	if (ret)
+		goto l_end;
+
+	ret = sxe2_sched_uinit(dev);
+	if (ret)
+		goto l_end;
+
+	ret = sxe2_sched_init(dev);
+	if (ret)
+		goto l_end;
+
+l_end:
+	return ret;
+}
+
 static int32_t sxe2_dev_init(struct rte_eth_dev *dev,
 			     struct sxe2_dev_kvargs_info *kvargs __rte_unused)
 {
diff --git a/drivers/net/sxe2/sxe2_ethdev.h b/drivers/net/sxe2/sxe2_ethdev.h
index e7a8ee0dd5..56b3b3cfe4 100644
--- a/drivers/net/sxe2/sxe2_ethdev.h
+++ b/drivers/net/sxe2/sxe2_ethdev.h
@@ -361,6 +361,8 @@ bool sxe2_ethdev_check(struct rte_eth_dev *dev);
 
 uint32_t sxe2_sched_mode_get(struct sxe2_adapter *adapter);
 
+int32_t sxe2_sched_reset(struct rte_eth_dev *dev);
+
 struct sxe2_pci_map_bar_info *sxe2_dev_get_bar_info(struct sxe2_adapter *adapter,
 						    enum sxe2_pci_map_resource res_type);
 
diff --git a/drivers/net/sxe2/sxe2_testpmd.c b/drivers/net/sxe2/sxe2_testpmd.c
new file mode 100644
index 0000000000..5792058212
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_testpmd.c
@@ -0,0 +1,733 @@
+
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef SXE2_TEST
+#include <cmdline_parse_num.h>
+#include <cmdline_parse_string.h>
+#include <stdlib.h>
+#include <testpmd.h>
+
+#include "sxe2_common_log.h"
+#include "sxe2_testpmd_lib.h"
+
+#define SXE2_SWITCH_BUFF_SIZE (4 * 1024 * 1024)
+
+struct cmd_stats_info_show_result {
+	cmdline_fixed_string_t sxe2;
+	cmdline_fixed_string_t show;
+	cmdline_fixed_string_t stats;
+	portid_t port_id;
+};
+cmdline_parse_token_string_t cmd_stats_info_sxe2 =
+	TOKEN_STRING_INITIALIZER(struct cmd_stats_info_show_result, sxe2, "sxe2");
+cmdline_parse_token_string_t cmd_stats_info_show =
+	TOKEN_STRING_INITIALIZER(struct cmd_stats_info_show_result, show, "show");
+cmdline_parse_token_string_t cmd_stats_info_stats =
+	TOKEN_STRING_INITIALIZER(struct cmd_stats_info_show_result, stats, "stats");
+cmdline_parse_token_num_t cmd_stats_info_port_id =
+	TOKEN_NUM_INITIALIZER(struct cmd_stats_info_show_result, port_id, RTE_UINT16);
+
+struct cmd_flow_rule_result {
+	cmdline_fixed_string_t sxe2;
+	cmdline_fixed_string_t flow;
+	cmdline_fixed_string_t rule;
+	cmdline_fixed_string_t dump;
+	portid_t port_id;
+};
+cmdline_parse_token_string_t cmd_flow_rule_sxe2 =
+	TOKEN_STRING_INITIALIZER(struct cmd_flow_rule_result, sxe2, "sxe2");
+cmdline_parse_token_string_t cmd_flow_rule_flow =
+	TOKEN_STRING_INITIALIZER(struct cmd_flow_rule_result, flow, "flow");
+cmdline_parse_token_string_t cmd_flow_rule_rule =
+	TOKEN_STRING_INITIALIZER(struct cmd_flow_rule_result, rule, "rule");
+cmdline_parse_token_string_t cmd_flow_rule_dmp =
+	TOKEN_STRING_INITIALIZER(struct cmd_flow_rule_result, dump, "dump");
+cmdline_parse_token_num_t cmd_flow_rule_port_id =
+	TOKEN_NUM_INITIALIZER(struct cmd_flow_rule_result, port_id, RTE_UINT16);
+
+struct cmd_udp_tunnel {
+	cmdline_fixed_string_t sxe2;
+	cmdline_fixed_string_t tunnel_type;
+	cmdline_fixed_string_t action;
+	cmdline_fixed_string_t udp_tunnel_port;
+	uint16_t               udp_port;
+	portid_t               port_id;
+};
+
+cmdline_parse_token_string_t cmd_udp_tunnel_sxe2 =
+	TOKEN_STRING_INITIALIZER(struct cmd_udp_tunnel, sxe2, "sxe2");
+cmdline_parse_token_string_t cmd_udp_tunnel_action =
+	TOKEN_STRING_INITIALIZER(struct cmd_udp_tunnel, action, "add#rm#show");
+cmdline_parse_token_string_t cmd_udp_tunnel_udp_tunnel_port =
+	TOKEN_STRING_INITIALIZER(struct cmd_udp_tunnel, udp_tunnel_port, "udp_tunnel_port");
+cmdline_parse_token_string_t cmd_udp_tunnel_tunnel_type =
+	TOKEN_STRING_INITIALIZER(struct cmd_udp_tunnel,
+	tunnel_type, "vxlan#vxlan-gpe#geneve#gtp-c#gtp-u#pfcp#ecpri#mpls#nvgre#l2tp#teredo");
+cmdline_parse_token_num_t cmd_udp_tunnel_udp_port =
+	TOKEN_NUM_INITIALIZER(struct cmd_udp_tunnel, udp_port, RTE_UINT16);
+cmdline_parse_token_num_t cmd_udp_tunnel_port_id  =
+	TOKEN_NUM_INITIALIZER(struct cmd_udp_tunnel, port_id, RTE_UINT16);
+
+struct cmd_sched_result {
+	cmdline_fixed_string_t sxe2;
+	cmdline_fixed_string_t sched;
+	cmdline_fixed_string_t reset;
+	portid_t port_id;
+};
+
+cmdline_parse_token_string_t cmd_sched_sxe2 =
+	 TOKEN_STRING_INITIALIZER(struct cmd_sched_result, sxe2, "sxe2");
+cmdline_parse_token_string_t cmd_sched_sched =
+	 TOKEN_STRING_INITIALIZER(struct cmd_sched_result, sched, "sched");
+cmdline_parse_token_string_t cmd_sched_reset =
+	 TOKEN_STRING_INITIALIZER(struct cmd_sched_result, reset, "reset");
+cmdline_parse_token_num_t cmd_sched_port_id =
+	 TOKEN_NUM_INITIALIZER(struct cmd_sched_result, port_id, RTE_UINT16);
+
+struct cmd_ipsec_result {
+	cmdline_fixed_string_t sxe2;
+	cmdline_fixed_string_t engin;
+	cmdline_fixed_string_t dir;
+	cmdline_fixed_string_t op;
+	portid_t port_id;
+	uint16_t session_id;
+	cmdline_fixed_string_t encrypt_algo;
+	cmdline_fixed_string_t encrypt_key;
+	cmdline_fixed_string_t auth_algo;
+	cmdline_fixed_string_t auth_key;
+	cmdline_fixed_string_t dst_ip;
+	uint16_t sport;
+	uint16_t dport;
+	uint32_t spi;
+};
+cmdline_parse_token_string_t cmd_ipsec_mgt_sxe2 =
+	TOKEN_STRING_INITIALIZER(struct cmd_ipsec_result, sxe2, "sxe2");
+cmdline_parse_token_string_t cmd_ipsec_mgt_module =
+	TOKEN_STRING_INITIALIZER(struct cmd_ipsec_result, engin, "ipsec");
+cmdline_parse_token_string_t cmd_ipsec_mgt_dir =
+	TOKEN_STRING_INITIALIZER(struct cmd_ipsec_result, dir, "egress#ingress");
+cmdline_parse_token_string_t cmd_ipsec_mgt_op =
+	TOKEN_STRING_INITIALIZER(struct cmd_ipsec_result, op, "add#rm#show");
+cmdline_parse_token_num_t cmd_ipsec_mgt_port_id =
+	TOKEN_NUM_INITIALIZER(struct cmd_ipsec_result, port_id, RTE_UINT16);
+cmdline_parse_token_num_t cmd_ipsec_mgt_session_id =
+	TOKEN_NUM_INITIALIZER(struct cmd_ipsec_result, session_id, RTE_UINT16);
+cmdline_parse_token_string_t cmd_ipsec_mgt_encrypt_algo =
+	TOKEN_STRING_INITIALIZER(struct cmd_ipsec_result, encrypt_algo, "aes-cbc#sm4-cbc#null");
+cmdline_parse_token_string_t cmd_ipsec_mgt_encrypt_key =
+	TOKEN_STRING_INITIALIZER(struct cmd_ipsec_result, encrypt_key, NULL);
+cmdline_parse_token_string_t cmd_ipsec_mgt_auth_algo =
+	TOKEN_STRING_INITIALIZER(struct cmd_ipsec_result, auth_algo, "sha-hmac#sm3-hmac#null");
+cmdline_parse_token_string_t cmd_ipsec_mgt_auth_key =
+	TOKEN_STRING_INITIALIZER(struct cmd_ipsec_result, auth_key, NULL);
+cmdline_parse_token_string_t cmd_ipsec_mgt_dst_ip =
+	TOKEN_STRING_INITIALIZER(struct cmd_ipsec_result, dst_ip, NULL);
+cmdline_parse_token_num_t cmd_ipsec_mgt_sport =
+	TOKEN_NUM_INITIALIZER(struct cmd_ipsec_result, sport, RTE_UINT16);
+cmdline_parse_token_num_t cmd_ipsec_mgt_dport =
+	TOKEN_NUM_INITIALIZER(struct cmd_ipsec_result, dport, RTE_UINT16);
+cmdline_parse_token_num_t cmd_ipsec_mgt_spi =
+	TOKEN_NUM_INITIALIZER(struct cmd_ipsec_result, spi, RTE_UINT32);
+
+struct cmd_ipsec_set_result {
+	cmdline_fixed_string_t sxe2;
+	cmdline_fixed_string_t engin;
+	cmdline_fixed_string_t op;
+	cmdline_fixed_string_t type;
+	portid_t port_id;
+	uint16_t conf_value;
+};
+cmdline_parse_token_string_t cmd_ipsec_set_sxe2 =
+	TOKEN_STRING_INITIALIZER(struct cmd_ipsec_set_result, sxe2, "sxe2");
+cmdline_parse_token_string_t cmd_ipsec_set_module =
+	TOKEN_STRING_INITIALIZER(struct cmd_ipsec_set_result, engin, "ipsec");
+cmdline_parse_token_string_t cmd_ipsec_set_op =
+	TOKEN_STRING_INITIALIZER(struct cmd_ipsec_set_result, op, "set#get");
+cmdline_parse_token_string_t cmd_ipsec_set_type =
+	TOKEN_STRING_INITIALIZER(struct cmd_ipsec_set_result, type, "session-id#esp-hdr-offset");
+cmdline_parse_token_num_t cmd_ipsec_set_port_id =
+	TOKEN_NUM_INITIALIZER(struct cmd_ipsec_set_result, port_id, RTE_UINT16);
+cmdline_parse_token_num_t cmd_ipsec_set_value =
+	TOKEN_NUM_INITIALIZER(struct cmd_ipsec_set_result, conf_value, RTE_UINT16);
+
+struct cmd_ipsec_flush_result {
+	cmdline_fixed_string_t sxe2;
+	cmdline_fixed_string_t engin;
+	cmdline_fixed_string_t op;
+	portid_t port_id;
+};
+cmdline_parse_token_string_t cmd_ipsec_flush_sxe2 =
+	TOKEN_STRING_INITIALIZER(struct cmd_ipsec_flush_result, sxe2, "sxe2");
+cmdline_parse_token_string_t cmd_ipsec_flush_module =
+	TOKEN_STRING_INITIALIZER(struct cmd_ipsec_flush_result, engin, "ipsec");
+cmdline_parse_token_string_t cmd_ipsec_flush_op =
+	TOKEN_STRING_INITIALIZER(struct cmd_ipsec_flush_result, op, "flush");
+cmdline_parse_token_num_t cmd_ipsec_flush_port_id =
+	TOKEN_NUM_INITIALIZER(struct cmd_ipsec_flush_result, port_id, RTE_UINT16);
+
+struct cmd_inject_irq {
+	cmdline_fixed_string_t sxe2;
+	cmdline_fixed_string_t inject;
+	cmdline_fixed_string_t irq;
+	portid_t port_id;
+	cmdline_fixed_string_t type;
+};
+cmdline_parse_token_string_t cmd_inject_irq_sxe2 =
+	TOKEN_STRING_INITIALIZER(struct cmd_inject_irq, sxe2, "sxe2");
+cmdline_parse_token_string_t cmd_inject_irq_inject =
+	TOKEN_STRING_INITIALIZER(struct cmd_inject_irq, inject, "inject");
+cmdline_parse_token_string_t cmd_inject_irq_irq =
+	TOKEN_STRING_INITIALIZER(struct cmd_inject_irq, irq, "irq");
+cmdline_parse_token_num_t cmd_inject_irq_port_id =
+	TOKEN_NUM_INITIALIZER(struct cmd_inject_irq, port_id, RTE_UINT16);
+cmdline_parse_token_string_t cmd_inject_irq_type =
+	TOKEN_STRING_INITIALIZER(struct cmd_inject_irq, type, "reset#lsc");
+
+static void cmd_dump_flow_rule_parsed(void *parsed_result,
+				      struct cmdline *cl,
+				      __rte_unused void *data)
+{
+	struct cmd_flow_rule_result *res = parsed_result;
+	int                          ret = -1;
+
+	ret = sxe2_flow_rule_dump(res->port_id, cl);
+	switch (ret) {
+	case 0:
+		break;
+	case -EINVAL:
+		cmdline_printf(cl, "Invalid parameters.\n");
+		break;
+	case -ENODEV:
+		cmdline_printf(cl, "Device doesn't support\n");
+		break;
+	default:
+		cmdline_printf(cl,
+			"Failed to switch rule dump,"
+			" error: (%s)\n",
+			strerror(-ret));
+	}
+}
+
+static void cmd_udp_tunnel_set_parsed(void *parsed_result,
+				      struct cmdline *cl,
+				      __rte_unused void *data)
+{
+	struct cmd_udp_tunnel *res = parsed_result;
+	int32_t ret = -1;
+	uint8_t action;
+	const char *action_str[SXE2_TESTPMD_CMD_UDP_TUNNEL_MAX] = {
+		[SXE2_TESTPMD_CMD_UDP_TUNNEL_ADD] = "add",
+		[SXE2_TESTPMD_CMD_UDP_TUNNEL_DEL] = "rm",
+		[SXE2_TESTPMD_CMD_UDP_TUNNEL_GET] = "show"};
+
+	for (action = 0; action < SXE2_TESTPMD_CMD_UDP_TUNNEL_MAX; action++)
+		if (!strcmp(res->action, action_str[action]))
+			break;
+
+	if (action >= SXE2_TESTPMD_CMD_UDP_TUNNEL_MAX) {
+		cmdline_printf(cl, "Invalid action!\n");
+		return;
+	}
+
+	ret = sxe2_udp_tunnel_operations(res->port_id, cl, action,
+					 res->udp_port,
+					 res->tunnel_type);
+	if (ret)
+		cmdline_printf(cl, "%s udp tunnel port failed, ret = %d\n",
+				action_str[action], ret);
+}
+
+static void cmd_dump_stats_info_parsed(void *parsed_result,
+				       struct cmdline *cl,
+				       __rte_unused void *data)
+{
+	struct cmd_stats_info_show_result *res = parsed_result;
+	int ret = -1;
+
+	ret = sxe2_stats_info_show(res->port_id);
+	switch (ret) {
+	case 0:
+		break;
+	case -EINVAL:
+		cmdline_printf(cl, "Invalid parameters.\n");
+		break;
+	case -ENODEV:
+		cmdline_printf(cl, "Device doesn't support\n");
+		break;
+	default:
+		cmdline_printf(cl,
+			"Failed to show stats info,"
+			" error: (%s)\n", strerror(-ret));
+	}
+}
+
+static uint8_t cmd_ipsec_op_get(char *op)
+{
+	uint8_t i;
+	const char *op_type[SXE2_TESTPMD_CMD_IPSEC_OP_MAX] = {
+		[SXE2_TESTPMD_CMD_IPSEC_OP_ADD] = "add",
+		[SXE2_TESTPMD_CMD_IPSEC_OP_RM] = "rm",
+		[SXE2_TESTPMD_CMD_IPSEC_OP_SHOW] = "show",
+	};
+
+	for (i = 0; i < SXE2_TESTPMD_CMD_IPSEC_OP_MAX; i++) {
+		if (!strcmp(op, op_type[i]))
+			break;
+	}
+
+	return i;
+}
+
+static uint8_t cmd_ipsec_dir_get(char *dir)
+{
+	uint8_t i;
+	const char *dir_type[SXE2_TESTPMD_CMD_IPSEC_DIR_MAX] = {
+		[SXE2_TESTPMD_CMD_IPSEC_DIR_EGRESS] = "egress",
+		[SXE2_TESTPMD_CMD_IPSEC_DIR_INGRESS] = "ingress"
+	};
+
+	for (i = 0; i < SXE2_TESTPMD_CMD_IPSEC_DIR_MAX; i++) {
+		if (!strcmp(dir, dir_type[i]))
+			break;
+	}
+
+	return i;
+}
+
+static int sxe2_hex_to_val(char c)
+{
+	int val = 0;
+
+	if (c >= '0' && c <= '9')
+		val = c - '0';
+	if (c >= 'A' && c <= 'F')
+		val = 10 + c - 'A';
+	if (c >= 'a' && c <= 'f')
+		val = 10 + c - 'a';
+	return val;
+}
+
+static void sxe2_hex_to_bytes(uint8_t *enc_key, char *hex_str, uint8_t len)
+{
+	uint8_t i;
+	int high = 0;
+	int low = 0;
+
+	for (i = 0; i < len; i++) {
+		high = sxe2_hex_to_val(hex_str[2 * i]);
+		low = sxe2_hex_to_val(hex_str[2 * i + 1]);
+		enc_key[i] = (high << 4) | low;
+	}
+}
+
+static int32_t cmd_ipsec_add_param_fill(struct sxe2_ipsec_conf_param *param,
+					struct cmdline *cl,
+					struct cmd_ipsec_result *res)
+{
+	uint8_t i;
+	uint8_t j;
+	int32_t ret = -1;
+	const char *encrypt_algo[SXE2_TESTPMD_CMD_IPSEC_EN_ALGO_MAX] = {
+		[SXE2_TESTPMD_CMD_IPSEC_EN_ALGO_AES_CBC] = "aes-cbc",
+		[SXE2_TESTPMD_CMD_IPSEC_EN_ALGO_SM4_CBC] = "sm4-cbc",
+		[SXE2_TESTPMD_CMD_IPSEC_EN_ALGO_NULL] = "null"
+	};
+
+	const char *auth_algo[SXE2_TESTPMD_CMD_IPSEC_AUTH_ALGO_MAX] = {
+		[SXE2_TESTPMD_CMD_IPSEC_AUTH_ALGO_SHA_HMAC] = "sha-hmac",
+		[SXE2_TESTPMD_CMD_IPSEC_AUTH_ALGO_SM3_HMAC] = "sm3-hmac",
+		[SXE2_TESTPMD_CMD_IPSEC_AUTH_ALGO_NULL] = "null"
+	};
+
+	for (i = 0; i < SXE2_TESTPMD_CMD_IPSEC_EN_ALGO_MAX; i++)
+		if (!strcmp(res->encrypt_algo, encrypt_algo[i]))
+			break;
+
+	if (i >= SXE2_TESTPMD_CMD_IPSEC_EN_ALGO_MAX) {
+		cmdline_printf(cl, "Invalid ipsec encrypt algo: %s!\n", res->encrypt_algo);
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	for (j = 0; j < SXE2_TESTPMD_CMD_IPSEC_AUTH_ALGO_MAX; j++) {
+		if (!strcmp(res->auth_algo, auth_algo[j]))
+			break;
+	}
+
+
+	if (j >= SXE2_TESTPMD_CMD_IPSEC_AUTH_ALGO_MAX) {
+		cmdline_printf(cl, "Invalid ipsec auth algo: %s!\n", res->auth_algo);
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	param->encrypt_algo = i;
+	param->auth_algo = j;
+	if (param->encrypt_algo == SXE2_TESTPMD_CMD_IPSEC_EN_ALGO_SM4_CBC)
+		param->enc_len = 16;
+	else
+		param->enc_len = 32;
+
+	sxe2_hex_to_bytes(param->enc_key, res->encrypt_key, param->enc_len);
+	if (param->auth_algo != SXE2_TESTPMD_CMD_IPSEC_AUTH_ALGO_NULL) {
+		param->auth_len = 32;
+		sxe2_hex_to_bytes(param->auth_key, res->auth_key, param->auth_len);
+	}
+
+	ret = 0;
+
+l_end:
+	return ret;
+}
+
+static int32_t cmd_ipsec_egress_op_parsed(struct sxe2_ipsec_conf_param *param,
+					  struct cmdline *cl,
+					  struct cmd_ipsec_result *res)
+{
+	int32_t ret = -1;
+
+	switch (param->op) {
+	case SXE2_TESTPMD_CMD_IPSEC_OP_ADD:
+		ret = cmd_ipsec_add_param_fill(param, cl, res);
+		if (ret)
+			goto l_end;
+		ret = sxe2_ipsec_egress_create(param, cl);
+		break;
+	case SXE2_TESTPMD_CMD_IPSEC_OP_RM:
+		param->session_id = res->session_id;
+		ret = sxe2_ipsec_egress_destroy(param, cl);
+		break;
+	case SXE2_TESTPMD_CMD_IPSEC_OP_SHOW:
+		ret = sxe2_ipsec_egress_show(param, cl);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+l_end:
+	return ret;
+}
+
+static int32_t cmd_ipsec_ip_addr_parsed(struct sxe2_ipsec_conf_param *param,
+					struct cmdline *cl,
+					struct cmd_ipsec_result *res)
+{
+	int32_t ret = -1;
+	struct in_addr addr4;
+	struct in6_addr addr6;
+
+	if (inet_pton(AF_INET, res->dst_ip, &addr4) == 1) {
+		param->ip_addr.type = RTE_SECURITY_IPSEC_TUNNEL_IPV4;
+		param->ip_addr.dst_ipv4 = addr4.s_addr;
+		ret = 0;
+	} else if (inet_pton(AF_INET6, res->dst_ip, &addr6) == 1) {
+		param->ip_addr.type = RTE_SECURITY_IPSEC_TUNNEL_IPV6;
+		memcpy(&param->ip_addr.dst_ipv6, &addr6, sizeof(param->ip_addr.dst_ipv6));
+		ret = 0;
+	} else {
+		cmdline_printf(cl, "Invalid ip address: %s!\n", res->dst_ip);
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+l_end:
+	return ret;
+}
+
+static int32_t cmd_ipsec_ingress_op_parsed(struct sxe2_ipsec_conf_param *param,
+					   struct cmdline *cl,
+					   struct cmd_ipsec_result *res)
+{
+	int32_t ret = -1;
+
+	switch (param->op) {
+	case SXE2_TESTPMD_CMD_IPSEC_OP_ADD:
+		ret = cmd_ipsec_add_param_fill(param, cl, res);
+		if (ret)
+			goto l_end;
+		param->sport = htons(res->sport);
+		param->dport = htons(res->dport);
+		param->spi = htonl(res->spi);
+		ret = cmd_ipsec_ip_addr_parsed(param, cl, res);
+		if (ret)
+			goto l_end;
+		ret = sxe2_ipsec_ingress_create(param, cl);
+		break;
+	case SXE2_TESTPMD_CMD_IPSEC_OP_RM:
+		param->session_id = res->session_id;
+		ret = sxe2_ipsec_ingress_destroy(param, cl);
+		break;
+	case SXE2_TESTPMD_CMD_IPSEC_OP_SHOW:
+		ret = sxe2_ipsec_ingress_show(param, cl);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+l_end:
+	return ret;
+}
+
+static int32_t cmd_ipsec_dir_parsed(struct sxe2_ipsec_conf_param *param,
+				    struct cmdline *cl,
+				    struct cmd_ipsec_result *res)
+{
+	int32_t ret = -1;
+
+	switch (param->dir) {
+	case SXE2_TESTPMD_CMD_IPSEC_DIR_EGRESS:
+		ret = cmd_ipsec_egress_op_parsed(param, cl, res);
+		break;
+	case SXE2_TESTPMD_CMD_IPSEC_DIR_INGRESS:
+		ret = cmd_ipsec_ingress_op_parsed(param, cl, res);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static void cmd_ipsec_mgt_parsed(void *parsed_result,
+				 struct cmdline *cl,
+				 __rte_unused void *data)
+{
+	struct cmd_ipsec_result *res = parsed_result;
+	struct sxe2_ipsec_conf_param param;
+	int32_t ret = -1;
+	uint8_t dir = 0;
+	uint8_t op = 0;
+
+	dir = cmd_ipsec_dir_get(res->dir);
+	if (dir >= SXE2_TESTPMD_CMD_IPSEC_DIR_MAX) {
+		cmdline_printf(cl, "Invalid ipsec direction: %s!\n", res->dir);
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	op = cmd_ipsec_op_get(res->op);
+	if (op >= SXE2_TESTPMD_CMD_IPSEC_OP_MAX) {
+		cmdline_printf(cl, "Invalid ipsec operation: %s!\n", res->op);
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	memset(&param, 0, sizeof(struct sxe2_ipsec_conf_param));
+	param.dir = dir;
+	param.op = op;
+	param.port_id = res->port_id;
+	ret = cmd_ipsec_dir_parsed(&param, cl, res);
+
+	if (ret)
+		cmdline_printf(cl, "Command execute failed, ret = %d\n", ret);
+
+l_end:
+	return;
+}
+
+static void cmd_ipsec_set_parsed(void *parsed_result,
+				 struct cmdline *cl,
+				 __rte_unused void *data)
+{
+	struct cmd_ipsec_set_result *res = parsed_result;
+	int32_t ret = -1;
+
+	if (!strcmp(res->op, "set"))
+		ret = sxe2_ipsec_conf_set(res->port_id, cl, res->type, res->conf_value);
+	else if (!strcmp(res->op, "get"))
+		ret = sxe2_ipsec_conf_get(res->port_id, cl, res->type);
+	else
+		cmdline_printf(cl, "Invalid op: %s\n", res->op);
+
+	if (ret)
+		cmdline_printf(cl, "Command execute failed, ret = %d\n", ret);
+}
+
+static void cmd_ipsec_flush_parsed(void *parsed_result,
+				   struct cmdline *cl,
+				   __rte_unused void *data)
+{
+	struct cmd_ipsec_flush_result *res = parsed_result;
+	int32_t ret = -1;
+
+	ret = sxe2_ipsec_flush(res->port_id, cl);
+
+	if (ret)
+		cmdline_printf(cl, "Command execute failed, ret = %d\n", ret);
+}
+
+cmdline_parse_inst_t cmd_flow_rule_dump = {
+	.f        = cmd_dump_flow_rule_parsed,
+	.data     = NULL,
+	.help_str = "sxe2 flow rule dump <port_id>",
+	.tokens = {
+		(void *)&cmd_flow_rule_sxe2,
+		(void *)&cmd_flow_rule_flow,
+		(void *)&cmd_flow_rule_rule,
+		(void *)&cmd_flow_rule_dmp,
+		(void *)&cmd_flow_rule_port_id,
+		NULL,
+	},
+};
+
+cmdline_parse_inst_t cmd_udp_tunnel_set = {
+	.f        = cmd_udp_tunnel_set_parsed,
+	.data     = NULL,
+	.help_str = "sxe2 <port_id> udp_tunnel_port add|rm|show "
+			"vxlan|vxlan-gpe|geneve|gtp-c|gtp-u|pfcp|ecpri|mpls|nvgre|l2tp|teredo <udp_port>",
+	.tokens = {
+		(void *)&cmd_udp_tunnel_sxe2,
+		(void *)&cmd_udp_tunnel_port_id,
+		(void *)&cmd_udp_tunnel_udp_tunnel_port,
+		(void *)&cmd_udp_tunnel_action,
+		(void *)&cmd_udp_tunnel_tunnel_type,
+		(void *)&cmd_udp_tunnel_udp_port,
+		NULL,
+	},
+};
+
+cmdline_parse_inst_t cmd_stats_mgt = {
+	.f        = cmd_dump_stats_info_parsed,
+	.data     = NULL,
+	.help_str = "sxe2 show stats <port_id>",
+	.tokens = {
+		(void *)&cmd_stats_info_sxe2,
+		(void *)&cmd_stats_info_show,
+		(void *)&cmd_stats_info_stats,
+		(void *)&cmd_stats_info_port_id,
+		NULL,
+	},
+};
+
+static void cmd_sched_reset_cfg(void *parsed_result,
+				struct cmdline *cl,
+				__rte_unused void *data)
+{
+	struct cmd_sched_result *res = parsed_result;
+	int32_t ret = -1;
+
+	ret = sxe2_testpmd_sched_reset(res->port_id);
+	switch (ret) {
+	case 0:
+		break;
+	case -EINVAL:
+		cmdline_printf(cl, "invalid sched ops\n");
+		break;
+	case -ENOTSUP:
+		cmdline_printf(cl, "function not implemented\n");
+		break;
+	default:
+		cmdline_printf(cl, "programming error: (%s)\n",
+			strerror(-ret));
+	}
+}
+
+cmdline_parse_inst_t cmd_sched_reset_cmd = {
+	.f        = cmd_sched_reset_cfg,
+	.data     = NULL,
+	.help_str = "sxe2 sched reset <port_id>",
+	.tokens = {
+		(void *)&cmd_sched_sxe2,
+		(void *)&cmd_sched_sched,
+		(void *)&cmd_sched_reset,
+		(void *)&cmd_sched_port_id,
+		NULL,
+	},
+};
+
+cmdline_parse_inst_t cmd_ipsec_mgt = {
+	.f = cmd_ipsec_mgt_parsed,
+	.data = NULL,
+	.help_str = "sxe2 ipsec egress|ingress add|rm|show "
+	"<port_id> <session_id> aes-cbc|sm4-cbc|null <encrypt_key> sha-hmac|sm3-hmac|null "
+	"<auth_key> <dst_ip> <sport> <dport> <spi>",
+	.tokens = {
+		(void *)&cmd_ipsec_mgt_sxe2,
+		(void *)&cmd_ipsec_mgt_module,
+		(void *)&cmd_ipsec_mgt_dir,
+		(void *)&cmd_ipsec_mgt_op,
+		(void *)&cmd_ipsec_mgt_port_id,
+		(void *)&cmd_ipsec_mgt_session_id,
+		(void *)&cmd_ipsec_mgt_encrypt_algo,
+		(void *)&cmd_ipsec_mgt_encrypt_key,
+		(void *)&cmd_ipsec_mgt_auth_algo,
+		(void *)&cmd_ipsec_mgt_auth_key,
+		(void *)&cmd_ipsec_mgt_dst_ip,
+		(void *)&cmd_ipsec_mgt_sport,
+		(void *)&cmd_ipsec_mgt_dport,
+		(void *)&cmd_ipsec_mgt_spi,
+		NULL,
+	},
+};
+
+cmdline_parse_inst_t cmd_ipsec_set = {
+	.f = cmd_ipsec_set_parsed,
+	.data = NULL,
+	.help_str = "sxe2 ipsec set|get esp-hdr-offset|session-id <port_id> <value>",
+	.tokens = {
+		(void *)&cmd_ipsec_set_sxe2,
+		(void *)&cmd_ipsec_set_module,
+		(void *)&cmd_ipsec_set_op,
+		(void *)&cmd_ipsec_set_type,
+		(void *)&cmd_ipsec_set_port_id,
+		(void *)&cmd_ipsec_set_value,
+		NULL,
+	},
+};
+
+cmdline_parse_inst_t cmd_ipsec_flush = {
+	.f = cmd_ipsec_flush_parsed,
+	.data = NULL,
+	.help_str = "sxe2 ipsec flush <port_id>.\n",
+	.tokens = {
+		(void *)&cmd_ipsec_flush_sxe2,
+		(void *)&cmd_ipsec_flush_module,
+		(void *)&cmd_ipsec_flush_op,
+		(void *)&cmd_ipsec_flush_port_id,
+		NULL,
+	},
+};
+
+static struct testpmd_driver_commands sxe2_cmds = {
+	.commands = {
+		{
+			&cmd_udp_tunnel_set,
+			"sxe2 udp tunnel port set.\n"
+			"Add or remove a customed udp port for specific tunnel protocol\n\n",
+		},
+			{
+			&cmd_sched_reset_cmd,
+			"sxe2 sched reset <port_id>.\n"
+			"Reset sched node on the port\n\n",
+		},
+		{
+			&cmd_stats_mgt,
+			"sxe2 show stats.\n"
+			"Dump a runtime sxe2 dev stats on a port\n\n",
+		},
+		{
+			&cmd_ipsec_mgt,
+			"sxe2 ipsec <dir> <op> <port_id> <session_id>  <encrypt_algo> <encrypt_key>"
+			"<encrypt_len> <auth_algo> <auth_key> <auth_len> <dst_ip> <sport> <dport> <spi>.\n"
+			"Create/query/remove ipsec security session\n\n",
+		},
+		{
+			&cmd_ipsec_set,
+			"sxe2 ipsec set <port_id> <session_id> <esp_hdr_offset>.\n"
+			"Set enabled tx session id or esp offset.\n\n",
+		},
+		{
+			&cmd_ipsec_flush,
+			"sxe2 ipsec flush <port_id>.\n"
+			"Flush ipsec all configurations\n\n",
+		},
+		{	NULL, NULL},
+	},
+};
+TESTPMD_ADD_DRIVER_COMMANDS(sxe2_cmds)
+#endif
diff --git a/drivers/net/sxe2/sxe2_testpmd_lib.c b/drivers/net/sxe2/sxe2_testpmd_lib.c
new file mode 100644
index 0000000000..ab2530ffe6
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_testpmd_lib.c
@@ -0,0 +1,969 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#include <rte_bus.h>
+#include <eal_export.h>
+
+#include "sxe2_common_log.h"
+#include "sxe2_ethdev.h"
+#include "sxe2_stats.h"
+#include "sxe2_testpmd_lib.h"
+
+struct rte_mempool *g_sess_pool;
+
+bool g_sxe2_ipsec_mgt_init;
+struct sxe2_ipsec_session_mgt g_tx_session[SXE2_IPSEC_PORT_MAX][SXE2_IPSEC_SESSION_MAX];
+struct sxe2_ipsec_session_mgt g_rx_session[SXE2_IPSEC_PORT_MAX][SXE2_IPSEC_SESSION_MAX];
+uint16_t g_tx_sess_id[SXE2_IPSEC_PORT_MAX] = {0};
+uint16_t g_esp_header_offset[SXE2_IPSEC_PORT_MAX] = {0};
+
+static bool sxe2_is_supported(struct rte_eth_dev *dev)
+{
+	return sxe2_ethdev_check(dev);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(sxe2_testpmd_sched_reset, 26.07)
+int32_t
+sxe2_testpmd_sched_reset(uint16_t port_id)
+{
+	struct rte_eth_dev   *dev     = NULL;
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
+
+	dev = &rte_eth_devices[port_id];
+	if (!sxe2_is_supported(dev)) {
+		PMD_LOG_ERR(DRV, "Invalid dev.");
+		return -ENODEV;
+	}
+
+	return sxe2_sched_reset(dev);
+}
+
+extern const char *sxe2_flow_type_name[SXE2_FLOW_TYPE_MAX];
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(sxe2_flow_rule_dump, 26.07)
+int32_t
+sxe2_flow_rule_dump(uint16_t port_id, struct cmdline *cl)
+{
+	struct rte_eth_dev            *dev           = NULL;
+	struct sxe2_adapter           *adapter       = NULL;
+	int32_t                            ret       = -1;
+	struct rte_flow_list_t        *flow_list     = NULL;
+	struct rte_flow               *flow          = NULL;
+	uint32_t                            index         = 0;
+	struct sxe2_flow              *hw_flow       = NULL;
+	uint8_t i = 0;
+
+	const char *sxe2_flow_engine_name[SXE2_FLOW_ENGINE_MAX] = {
+		[SXE2_FLOW_ENGINE_ACL] = "acl",
+		[SXE2_FLOW_ENGINE_RSS] = "rss",
+		[SXE2_FLOW_ENGINE_SWITCH] = "switch",
+		[SXE2_FLOW_ENGINE_FNAV] = "fnav",
+	};
+	const char *sxe2_flow_action_name[SXE2_FLOW_ACTION_MAX] = {
+		[SXE2_FLOW_ACTION_DROP] = "drop",
+		[SXE2_FLOW_ACTION_TC_REDIRECT] = "tc_redirect",
+		[SXE2_FLOW_ACTION_TO_VSI] = "to_vsi",
+		[SXE2_FLOW_ACTION_TO_VSI_LIST] = "to_vsi_list",
+		[SXE2_FLOW_ACTION_PASSTHRU] = "passthru",
+		[SXE2_FLOW_ACTION_QUEUE] = "queue",
+		[SXE2_FLOW_ACTION_Q_REGION] = "q_region",
+		[SXE2_FLOW_ACTION_MARK] = "mark",
+		[SXE2_FLOW_ACTION_COUNT] = "count",
+		[SXE2_FLOW_ACTION_RSS] = "rss",
+	};
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
+	dev = &rte_eth_devices[port_id];
+	if (!sxe2_is_supported(dev)) {
+		PMD_LOG_ERR(DRV, "Invalid dev");
+		ret = -ENODEV;
+		goto l_end;
+	}
+	adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	flow_list = &adapter->flow_ctxt.rte_flow_list;
+	cmdline_printf(cl, "Dump sxe2 flow rule:\n");
+	TAILQ_FOREACH(flow, flow_list, next) {
+		cmdline_printf(cl, "rule index: %d\n", index++);
+		TAILQ_FOREACH(hw_flow, &flow->sxe2_flow_list, next) {
+			cmdline_printf(cl, "\thw flow id: %d\n", hw_flow->flow_id);
+			cmdline_printf(cl, "\t\ttype: %s\n",
+					sxe2_flow_type_name[hw_flow->meta.flow_type]);
+			cmdline_printf(cl, "\t\tprio: %d\n", hw_flow->meta.flow_prio);
+			cmdline_printf(cl, "\t\tsrc vsi: %d,rule vsi: %d\n",
+				hw_flow->meta.flow_src_vsi, hw_flow->meta.flow_rule_vsi);
+			cmdline_printf(cl, "\t\tengine type: %s\n",
+				sxe2_flow_engine_name[hw_flow->engine_type]);
+			cmdline_printf(cl, "\t\taction:");
+			for (i = 0; i < SXE2_FLOW_ACTION_MAX; i++) {
+				if (sxe2_test_bit(i, hw_flow->action.act_types))
+					cmdline_printf(cl, "%s ", sxe2_flow_action_name[i]);
+			}
+			cmdline_printf(cl, "\n");
+		}
+	}
+	cmdline_printf(cl, "Dump sxe2 flow rule end.\n");
+	ret = 0;
+l_end:
+	return ret;
+}
+
+static const char *tunnel_type_list[SXE2_UDP_TUNNEL_MAX] = {
+	[SXE2_UDP_TUNNEL_PROTOCOL_VXLAN] = "vxlan",
+	[SXE2_UDP_TUNNEL_PROTOCOL_VXLAN_GPE] = "vxlan-gpe",
+	[SXE2_UDP_TUNNEL_PROTOCOL_GENEVE] = "geneve",
+	[SXE2_UDP_TUNNEL_PROTOCOL_GTP_C] = "gtp-c",
+	[SXE2_UDP_TUNNEL_PROTOCOL_GTP_U] = "gtp-u",
+	[SXE2_UDP_TUNNEL_PROTOCOL_PFCP] = "pfcp",
+	[SXE2_UDP_TUNNEL_PROTOCOL_ECPRI] = "ecpri",
+	[SXE2_UDP_TUNNEL_PROTOCOL_MPLS] = "mpls",
+	[SXE2_UDP_TUNNEL_PROTOCOL_NVGRE] = "nvgre",
+	[SXE2_UDP_TUNNEL_PROTOCOL_L2TP] = "l2tp",
+	[SXE2_UDP_TUNNEL_PROTOCOL_TEREDO] = "teredo"
+};
+
+static enum sxe2_udp_tunnel_protocol sxe2_udp_tunnel_type_str2proto(const char *tunnel_type)
+{
+	enum sxe2_udp_tunnel_protocol proto;
+
+	for (proto = 0; proto < SXE2_UDP_TUNNEL_MAX; proto++) {
+		if (tunnel_type_list[proto] != NULL &&
+		    strcmp(tunnel_type_list[proto], tunnel_type) == 0) {
+			break;
+		}
+	}
+
+	return proto;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(sxe2_udp_tunnel_operations, 26.07)
+int32_t
+sxe2_udp_tunnel_operations(uint16_t port_id, struct cmdline *cl, uint8_t action,
+			   uint16_t udp_port, const char *tunnel_type)
+{
+	enum sxe2_udp_tunnel_protocol proto = sxe2_udp_tunnel_type_str2proto(tunnel_type);
+	struct rte_eth_dev            *dev = NULL;
+	struct sxe2_adapter           *adapter = NULL;
+	struct sxe2_udp_tunnel_cfg    tunnel_config = { 0 };
+	int32_t ret   = -1;
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
+	dev = &rte_eth_devices[port_id];
+	if (!sxe2_is_supported(dev)) {
+		PMD_LOG_ERR(DRV, "Invalid dev.");
+		ret = -ENODEV;
+		goto l_end;
+	}
+
+	if (proto >= SXE2_UDP_TUNNEL_MAX) {
+		cmdline_printf(cl, "Invalid tunnel type!\n");
+		goto l_end;
+	}
+	adapter = dev->data->dev_private;
+	switch (action) {
+	case SXE2_TESTPMD_CMD_UDP_TUNNEL_ADD:
+		ret = sxe2_udp_tunnel_port_add_common(adapter, proto, udp_port);
+		break;
+	case SXE2_TESTPMD_CMD_UDP_TUNNEL_DEL:
+		ret = sxe2_udp_tunnel_port_del_common(adapter, proto, udp_port);
+		break;
+	case SXE2_TESTPMD_CMD_UDP_TUNNEL_GET:
+		tunnel_config.protocol = proto;
+		ret = sxe2_udp_tunnel_port_get_common(adapter, &tunnel_config);
+		if (!ret) {
+			cmdline_printf(cl, "Dump firmware udp tunnel config: [proto:%s, port:%d,"
+				"enable:%d, src/dst:%d/%d, used:%d]\n",
+				 tunnel_type_list[proto], tunnel_config.fw_port,
+				 tunnel_config.fw_status, tunnel_config.fw_src_en,
+				 tunnel_config.fw_dst_en, tunnel_config.fw_used);
+		}
+		break;
+	default:
+	break;
+	}
+
+l_end:
+	return ret;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(sxe2_stats_info_show, 26.07)
+int32_t
+sxe2_stats_info_show(uint16_t port_id)
+{
+	struct rte_eth_dev *dev = NULL;
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
+
+	dev = &rte_eth_devices[port_id];
+	if (!sxe2_is_supported(dev)) {
+		PMD_LOG_ERR(DRV, "Invalid dev.");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int32_t sxe2_ipsec_init_mempools(void *sec_ctx)
+{
+	uint16_t nb_sess = 8192;
+	uint32_t sess_sz;
+	char s[64];
+	int32_t ret = -1;
+
+	sess_sz = rte_security_session_get_size(sec_ctx);
+	if (g_sess_pool == NULL) {
+		snprintf(s, sizeof(s), "sess_pool");
+		g_sess_pool = rte_mempool_create(s, nb_sess, sess_sz,
+				MEMPOOL_CACHE_SIZE, 0,
+				NULL, NULL, NULL, NULL,
+				SOCKET_ID_ANY, 0);
+		if (g_sess_pool == NULL) {
+			ret = -ENOMEM;
+			PMD_LOG_ERR(DRV, "Failed to malloc session pool memory.");
+			goto l_end;
+		}
+	}
+	ret = 0;
+
+l_end:
+	return ret;
+}
+
+static void sxe2_ipsec_init_session_mgt(void)
+{
+	uint16_t i;
+	uint8_t port_id;
+
+	if (g_sxe2_ipsec_mgt_init)
+		return;
+
+	for (port_id = 0; port_id < SXE2_IPSEC_PORT_MAX; port_id++) {
+		for (i = 0; i < SXE2_IPSEC_SESSION_MAX; i++) {
+			g_tx_session[port_id][i].session = NULL;
+			g_tx_session[port_id][i].encrypt_algo = SXE2_TESTPMD_CMD_IPSEC_EN_ALGO_NULL;
+			g_tx_session[port_id][i].auth_algo = SXE2_TESTPMD_CMD_IPSEC_AUTH_ALGO_NULL;
+			g_tx_session[port_id][i].session_id = i;
+			g_tx_session[port_id][i].status = 0;
+		}
+	}
+
+	for (port_id = 0; port_id < SXE2_IPSEC_PORT_MAX; port_id++) {
+		for (i = 0; i < SXE2_IPSEC_SESSION_MAX; i++) {
+			g_rx_session[port_id][i].session = NULL;
+			g_rx_session[port_id][i].encrypt_algo = SXE2_TESTPMD_CMD_IPSEC_EN_ALGO_NULL;
+			g_rx_session[port_id][i].auth_algo = SXE2_TESTPMD_CMD_IPSEC_AUTH_ALGO_NULL;
+			g_rx_session[port_id][i].session_id = i;
+			g_rx_session[port_id][i].status = 0;
+		}
+	}
+
+	g_sxe2_ipsec_mgt_init = true;
+}
+
+static uint16_t sxe2_ipsec_session_mgt_alloc(enum sxe2_testpmd_ipsec_dir dir, uint16_t port_id)
+{
+	uint16_t i;
+	uint16_t index = 0XFFFF;
+	struct sxe2_ipsec_session_mgt *mgt = NULL;
+
+	if (dir == SXE2_TESTPMD_CMD_IPSEC_DIR_EGRESS)
+		mgt = g_tx_session[port_id];
+	else
+		mgt = g_rx_session[port_id];
+
+	for (i = 0; i < SXE2_IPSEC_SESSION_MAX; i++) {
+		if (mgt[i].status == 0) {
+			index = i;
+			mgt[i].status = 1;
+			break;
+		}
+	}
+
+	return index;
+}
+
+static void sxe2_ipsec_session_mgt_free(enum sxe2_testpmd_ipsec_dir dir,
+					uint16_t index, uint16_t port_id)
+{
+	struct sxe2_ipsec_session_mgt *mgt = NULL;
+
+	if (dir == SXE2_TESTPMD_CMD_IPSEC_DIR_EGRESS)
+		mgt = g_tx_session[port_id];
+	else
+		mgt = g_rx_session[port_id];
+
+	mgt[index].session = NULL;
+	mgt[index].status = 0;
+}
+
+static int32_t sxe2_ipsec_egress_construct(struct cmdline *cl,
+					   struct rte_crypto_sym_xform **xform,
+					   struct sxe2_ipsec_conf_param *param)
+{
+	struct rte_crypto_sym_xform *cur_xform = NULL;
+	struct rte_crypto_sym_xform *next_xform = NULL;
+	int32_t ret = -1;
+
+	cur_xform = rte_zmalloc("current xform",
+				sizeof(struct rte_crypto_sym_xform), 0);
+	if (cur_xform == NULL) {
+		ret = -ENOMEM;
+		cmdline_printf(cl, "Failed to malloc memory!\n");
+		goto l_end;
+	}
+	cur_xform->type = RTE_CRYPTO_SYM_XFORM_CIPHER;
+	cur_xform->cipher.op = RTE_CRYPTO_CIPHER_OP_ENCRYPT;
+	if (param->encrypt_algo == SXE2_TESTPMD_CMD_IPSEC_EN_ALGO_AES_CBC)
+		cur_xform->cipher.algo = SXE2_RTE_CRYPTO_CIPHER_AES_CBC;
+	else
+		cur_xform->cipher.algo = SXE2_RTE_RTE_CRYPTO_CIPHER_SM4_CBC;
+	cur_xform->cipher.key.length = param->enc_len;
+	cur_xform->cipher.key.data = param->enc_key;
+
+	if (param->auth_algo == SXE2_TESTPMD_CMD_IPSEC_AUTH_ALGO_NULL) {
+		ret = 0;
+		goto l_end;
+	}
+
+	next_xform = rte_zmalloc("next xform",
+				sizeof(struct rte_crypto_sym_xform), 0);
+	if (next_xform == NULL) {
+		rte_free(cur_xform);
+		ret = -ENOMEM;
+		cmdline_printf(cl, "Failed to malloc memory!\n");
+		goto l_end;
+	}
+	next_xform->type = RTE_CRYPTO_SYM_XFORM_AUTH;
+	next_xform->auth.op = RTE_CRYPTO_AUTH_OP_GENERATE;
+	if (param->auth_algo == SXE2_TESTPMD_CMD_IPSEC_AUTH_ALGO_SHA_HMAC)
+		next_xform->auth.algo = SXE2_RTE_CRYPTO_AUTH_SHA256_HMAC;
+	else
+		next_xform->auth.algo = SXE2_RTE_CRYPTO_AUTH_SM3_HMAC;
+	next_xform->auth.key.length = param->auth_len;
+	next_xform->auth.key.data = param->auth_key;
+	cur_xform->next = next_xform;
+	ret = 0;
+
+l_end:
+	*xform = cur_xform;
+	return ret;
+}
+
+static int32_t sxe2_ipsec_ingress_construct(struct cmdline *cl,
+					    struct rte_crypto_sym_xform **xform,
+					    struct sxe2_ipsec_conf_param *param)
+{
+	struct rte_crypto_sym_xform *cur_xform = NULL;
+	struct rte_crypto_sym_xform *next_xform = NULL;
+	int32_t ret = -1;
+
+	cur_xform = rte_zmalloc("current xform",
+				sizeof(struct rte_crypto_sym_xform), 0);
+	if (cur_xform == NULL) {
+		ret = -ENOMEM;
+		cmdline_printf(cl, "Failed to malloc memory!\n");
+		goto l_end;
+	}
+
+	if (param->auth_algo == SXE2_TESTPMD_CMD_IPSEC_AUTH_ALGO_NULL) {
+		cur_xform->type = RTE_CRYPTO_SYM_XFORM_CIPHER;
+		cur_xform->cipher.op = RTE_CRYPTO_CIPHER_OP_DECRYPT;
+		if (param->encrypt_algo == SXE2_TESTPMD_CMD_IPSEC_EN_ALGO_AES_CBC)
+			cur_xform->cipher.algo = SXE2_RTE_CRYPTO_CIPHER_AES_CBC;
+		else
+			cur_xform->cipher.algo = SXE2_RTE_RTE_CRYPTO_CIPHER_SM4_CBC;
+		cur_xform->cipher.key.length = param->enc_len;
+		cur_xform->cipher.key.data = param->enc_key;
+		ret = 0;
+		goto l_end;
+	}
+
+	cur_xform->type = RTE_CRYPTO_SYM_XFORM_AUTH;
+	cur_xform->auth.op = RTE_CRYPTO_AUTH_OP_VERIFY;
+	if (param->auth_algo == SXE2_TESTPMD_CMD_IPSEC_AUTH_ALGO_SHA_HMAC)
+		cur_xform->auth.algo = SXE2_RTE_CRYPTO_AUTH_SHA256_HMAC;
+	else
+		cur_xform->auth.algo = SXE2_RTE_CRYPTO_AUTH_SM3_HMAC;
+
+	cur_xform->auth.key.length = param->auth_len;
+	cur_xform->auth.key.data = param->auth_key;
+
+	next_xform = rte_zmalloc("next xform",
+				 sizeof(struct rte_crypto_sym_xform), 0);
+	if (next_xform == NULL) {
+		rte_free(cur_xform);
+		ret = -ENOMEM;
+		cmdline_printf(cl, "Failed to malloc memory!\n");
+		goto l_end;
+	}
+
+	next_xform->type = RTE_CRYPTO_SYM_XFORM_CIPHER;
+	next_xform->cipher.op = RTE_CRYPTO_CIPHER_OP_DECRYPT;
+	if (param->encrypt_algo == SXE2_TESTPMD_CMD_IPSEC_EN_ALGO_AES_CBC)
+		next_xform->cipher.algo = SXE2_RTE_CRYPTO_CIPHER_AES_CBC;
+	else
+		next_xform->cipher.algo = SXE2_RTE_RTE_CRYPTO_CIPHER_SM4_CBC;
+	next_xform->cipher.key.length = param->enc_len;
+	next_xform->cipher.key.data = param->enc_key;
+	cur_xform->next = next_xform;
+	ret = 0;
+
+l_end:
+	*xform = cur_xform;
+	return ret;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(sxe2_ipsec_ingress_create, 26.07)
+int32_t
+sxe2_ipsec_ingress_create(struct sxe2_ipsec_conf_param *param, struct cmdline *cl)
+{
+	struct rte_eth_dev *dev       = NULL;
+	struct rte_security_session_conf conf;
+	struct rte_crypto_sym_xform *encrypt_xform = NULL;
+	void *session = NULL;
+	struct rte_security_ctx *p_ctx = NULL;
+	int32_t ret = -1;
+	uint16_t index;
+	uint8_t i;
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(param->port_id, -ENODEV);
+
+	dev = &rte_eth_devices[param->port_id];
+	if (!sxe2_is_supported(dev)) {
+		PMD_LOG_ERR(DRV, "Invalid dev.");
+		ret = -ENODEV;
+		goto l_end;
+	}
+
+	if (dev->data->dev_started != 0) {
+		cmdline_printf(cl, "port %d must be stopped.\n", dev->data->port_id);
+		ret = 0;
+		goto l_end;
+	}
+
+	p_ctx = rte_eth_dev_get_sec_ctx(param->port_id);
+
+	if (g_sess_pool == NULL) {
+		ret = sxe2_ipsec_init_mempools(p_ctx);
+		if (ret)
+			goto l_end;
+	}
+
+	sxe2_ipsec_init_session_mgt();
+
+	memset(&conf, 0, sizeof(conf));
+	conf.protocol = RTE_SECURITY_PROTOCOL_IPSEC;
+	conf.action_type = RTE_SECURITY_ACTION_TYPE_INLINE_CRYPTO;
+	conf.ipsec.mode = RTE_SECURITY_IPSEC_SA_MODE_TUNNEL;
+	conf.ipsec.proto = RTE_SECURITY_IPSEC_SA_PROTO_ESP;
+	conf.ipsec.direction = RTE_SECURITY_IPSEC_SA_DIR_INGRESS;
+	conf.ipsec.spi = param->spi;
+	conf.ipsec.udp.sport = param->sport;
+	conf.ipsec.udp.dport = param->dport;
+	conf.ipsec.tunnel.type = param->ip_addr.type;
+	if (param->sport || param->dport)
+		conf.ipsec.options.udp_encap = true;
+	if (param->ip_addr.type == RTE_SECURITY_IPSEC_TUNNEL_IPV4)
+		conf.ipsec.tunnel.ipv4.dst_ip.s_addr = param->ip_addr.dst_ipv4;
+	else
+		memcpy(&conf.ipsec.tunnel.ipv6.dst_addr,
+		       &param->ip_addr.dst_ipv6,
+		       sizeof(param->ip_addr.dst_ipv6));
+
+	ret = sxe2_ipsec_ingress_construct(cl, &encrypt_xform, param);
+	if (ret)
+		goto l_end;
+	conf.crypto_xform = encrypt_xform;
+
+	session = rte_security_session_create(p_ctx, &conf, g_sess_pool);
+	if (session == NULL) {
+		ret = -1;
+		goto l_free;
+	}
+
+	index = sxe2_ipsec_session_mgt_alloc(param->dir, param->port_id);
+	if (index == 0XFFFF) {
+		ret = -1;
+		goto l_free;
+	}
+
+	g_rx_session[param->port_id][index].session = session;
+	g_rx_session[param->port_id][index].encrypt_algo = param->encrypt_algo;
+	g_rx_session[param->port_id][index].auth_algo = param->auth_algo;
+	for (i = 0; i < 32; i++) {
+		g_rx_session[param->port_id][index].enc_key[i] = param->enc_key[i];
+		g_rx_session[param->port_id][index].auth_key[i] = param->auth_key[i];
+	}
+	g_rx_session[param->port_id][index].sport = ntohs(param->sport);
+	g_rx_session[param->port_id][index].dport = ntohs(param->dport);
+	g_rx_session[param->port_id][index].spi = ntohl(param->spi);
+	memcpy(&g_rx_session[param->port_id][index].ip_addr,
+	       &param->ip_addr,
+	       sizeof(struct sxe2_ipsec_ip_param));
+
+	ret = 0;
+
+l_free:
+	if (encrypt_xform->next)
+		rte_free(encrypt_xform->next);
+	if (encrypt_xform)
+		rte_free(encrypt_xform);
+
+l_end:
+	return ret;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(sxe2_ipsec_ingress_destroy, 26.07)
+int32_t
+sxe2_ipsec_ingress_destroy(struct sxe2_ipsec_conf_param *param, struct cmdline *cl)
+{
+	struct rte_eth_dev *dev       = NULL;
+	struct rte_security_ctx *p_ctx = NULL;
+	struct rte_security_session *session = NULL;
+	int32_t ret = -1;
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(param->port_id, -ENODEV);
+
+	dev = &rte_eth_devices[param->port_id];
+	if (!sxe2_is_supported(dev)) {
+		cmdline_printf(cl, "Invalid dev.\n");
+		ret = -ENODEV;
+		goto l_end;
+	}
+
+	if (dev->data->dev_started != 0) {
+		cmdline_printf(cl, "port %d must be stopped.\n", dev->data->port_id);
+		ret = 0;
+		goto l_end;
+	}
+
+	if (param->session_id >= SXE2_IPSEC_SESSION_MAX) {
+		PMD_LOG_ERR(DRV, "Invalid session id.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (!g_rx_session[param->port_id][param->session_id].status) {
+		PMD_LOG_ERR(DRV, "Invalid session status.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (g_rx_session[param->port_id][param->session_id].session == NULL) {
+		PMD_LOG_ERR(DRV, "Invalid session data.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	p_ctx = rte_eth_dev_get_sec_ctx(param->port_id);
+
+	session = g_rx_session[param->port_id][param->session_id].session;
+	ret = rte_security_session_destroy(p_ctx, session);
+	if (ret)
+		goto l_end;
+	sxe2_ipsec_session_mgt_free(param->dir, param->session_id, param->port_id);
+
+	ret = 0;
+l_end:
+	return ret;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(sxe2_ipsec_ingress_show, 26.07)
+int32_t
+sxe2_ipsec_ingress_show(struct sxe2_ipsec_conf_param *param, struct cmdline *cl)
+{
+	struct rte_eth_dev *dev       = NULL;
+	int32_t ret = -1;
+	uint16_t i;
+	uint8_t j;
+	char encrypt_key[65];
+	char auth_key[65];
+	const char *encrypt_algo[SXE2_TESTPMD_CMD_IPSEC_EN_ALGO_MAX] = {
+		[SXE2_TESTPMD_CMD_IPSEC_EN_ALGO_AES_CBC] = "aes-cbc",
+		[SXE2_TESTPMD_CMD_IPSEC_EN_ALGO_SM4_CBC] = "sm4-cbc",
+		[SXE2_TESTPMD_CMD_IPSEC_EN_ALGO_NULL] = "null"
+	};
+
+	const char *auth_algo[SXE2_TESTPMD_CMD_IPSEC_AUTH_ALGO_MAX] = {
+		[SXE2_TESTPMD_CMD_IPSEC_AUTH_ALGO_SHA_HMAC] = "sha-hmac",
+		[SXE2_TESTPMD_CMD_IPSEC_AUTH_ALGO_SM3_HMAC] = "sm3-hmac",
+		[SXE2_TESTPMD_CMD_IPSEC_AUTH_ALGO_NULL] = "null"
+	};
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(param->port_id, -ENODEV);
+
+	dev = &rte_eth_devices[param->port_id];
+	if (!sxe2_is_supported(dev)) {
+		PMD_LOG_ERR(DRV, "Invalid dev.");
+		ret = -ENODEV;
+		goto l_end;
+	}
+
+	for (i = 0; i < SXE2_IPSEC_SESSION_MAX; i++) {
+		if (g_rx_session[param->port_id][i].status &&
+		    g_rx_session[param->port_id][i].session) {
+			memset(encrypt_key, '\0', sizeof(encrypt_key));
+			memset(auth_key, '\0', sizeof(auth_key));
+			for (j = 0; j < 32; j++) {
+				sprintf(encrypt_key + 2 * j, "%02x",
+					g_rx_session[param->port_id][i].enc_key[j]);
+			}
+
+			if (g_rx_session[param->port_id][i].auth_algo !=
+			    SXE2_TESTPMD_CMD_IPSEC_AUTH_ALGO_NULL) {
+				for (j = 0; j < 32; j++) {
+					sprintf(auth_key + 2 * j, "%02x",
+						g_rx_session[param->port_id][i].auth_key[j]);
+				}
+			}
+
+			cmdline_printf(cl, "session_id:%u, direction:rx ,"
+				"encrypt_algo:%s, encrypt_key:0x%s,"
+				"auth_algo:%s, auth_key:0x%s, sport:%u, dport:%u, spi:%u\n",
+				i,
+				encrypt_algo[g_rx_session[param->port_id][i].encrypt_algo],
+				encrypt_key,
+				auth_algo[g_rx_session[param->port_id][i].auth_algo],
+				auth_key,
+				g_rx_session[param->port_id][i].sport,
+				g_rx_session[param->port_id][i].dport,
+				g_rx_session[param->port_id][i].spi);
+		}
+	}
+
+	ret = 0;
+
+l_end:
+	return ret;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(sxe2_ipsec_egress_create, 26.07)
+int32_t
+sxe2_ipsec_egress_create(struct sxe2_ipsec_conf_param *param, struct cmdline *cl)
+{
+	struct rte_eth_dev *dev       = NULL;
+	struct rte_security_session_conf conf;
+	struct rte_crypto_sym_xform *encrypt_xform = NULL;
+	void *session = NULL;
+	struct rte_security_ctx *p_ctx = NULL;
+	int32_t ret = -1;
+	uint16_t index;
+	uint8_t i;
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(param->port_id, -ENODEV);
+
+	dev = &rte_eth_devices[param->port_id];
+	if (!sxe2_is_supported(dev)) {
+		PMD_LOG_ERR(DRV, "Invalid dev.");
+		ret = -ENODEV;
+		goto l_end;
+	}
+
+	if (dev->data->dev_started != 0) {
+		cmdline_printf(cl, "port %d must be stopped.\n", dev->data->port_id);
+		ret = 0;
+		goto l_end;
+	}
+
+	p_ctx = rte_eth_dev_get_sec_ctx(param->port_id);
+
+	if (g_sess_pool == NULL) {
+		ret = sxe2_ipsec_init_mempools(p_ctx);
+		if (ret)
+			goto l_end;
+	}
+
+	sxe2_ipsec_init_session_mgt();
+
+	memset(&conf, 0, sizeof(conf));
+	conf.protocol = RTE_SECURITY_PROTOCOL_IPSEC;
+	conf.action_type = RTE_SECURITY_ACTION_TYPE_INLINE_CRYPTO;
+	conf.ipsec.mode = RTE_SECURITY_IPSEC_SA_MODE_TUNNEL;
+	conf.ipsec.proto = RTE_SECURITY_IPSEC_SA_PROTO_ESP;
+	conf.ipsec.direction = RTE_SECURITY_IPSEC_SA_DIR_EGRESS;
+
+	ret = sxe2_ipsec_egress_construct(cl, &encrypt_xform, param);
+	if (ret)
+		goto l_end;
+	conf.crypto_xform = encrypt_xform;
+
+	session = rte_security_session_create(p_ctx, &conf, g_sess_pool);
+	if (session == NULL) {
+		ret = -1;
+		goto l_free;
+	}
+
+	index = sxe2_ipsec_session_mgt_alloc(param->dir, param->port_id);
+	if (index == 0XFFFF) {
+		ret = -1;
+		goto l_free;
+	}
+
+	g_tx_session[param->port_id][index].session = session;
+	g_tx_session[param->port_id][index].encrypt_algo = param->encrypt_algo;
+	g_tx_session[param->port_id][index].auth_algo = param->auth_algo;
+	for (i = 0; i < 32; i++) {
+		g_tx_session[param->port_id][index].enc_key[i] = param->enc_key[i];
+		g_tx_session[param->port_id][index].auth_key[i] = param->auth_key[i];
+	}
+	ret = 0;
+
+l_free:
+	if (encrypt_xform->next)
+		rte_free(encrypt_xform->next);
+	if (encrypt_xform)
+		rte_free(encrypt_xform);
+
+l_end:
+	return ret;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(sxe2_ipsec_egress_destroy, 26.07)
+int32_t
+sxe2_ipsec_egress_destroy(struct sxe2_ipsec_conf_param *param, struct cmdline *cl)
+{
+	struct rte_eth_dev *dev       = NULL;
+	struct rte_security_ctx *p_ctx = NULL;
+	struct rte_security_session *session = NULL;
+	int32_t ret = -1;
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(param->port_id, -ENODEV);
+
+	dev = &rte_eth_devices[param->port_id];
+	if (!sxe2_is_supported(dev)) {
+		PMD_LOG_ERR(DRV, "Invalid dev.");
+		ret = -ENODEV;
+		goto l_end;
+	}
+
+	if (dev->data->dev_started != 0) {
+		cmdline_printf(cl, "port %d must be stopped.\n", dev->data->port_id);
+		ret = 0;
+		goto l_end;
+	}
+
+	if (param->session_id >= SXE2_IPSEC_SESSION_MAX) {
+		PMD_LOG_ERR(DRV, "Invalid session id.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (!g_tx_session[param->port_id][param->session_id].status) {
+		PMD_LOG_ERR(DRV, "Invalid session status.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (g_tx_session[param->port_id][param->session_id].session == NULL) {
+		PMD_LOG_ERR(DRV, "Invalid session data.");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	p_ctx = rte_eth_dev_get_sec_ctx(param->port_id);
+
+	session = g_tx_session[param->port_id][param->session_id].session;
+	ret = rte_security_session_destroy(p_ctx, session);
+	if (ret)
+		goto l_end;
+	sxe2_ipsec_session_mgt_free(param->dir, param->session_id, param->port_id);
+
+	ret = 0;
+
+l_end:
+	return ret;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(sxe2_ipsec_egress_show, 26.07)
+int32_t
+sxe2_ipsec_egress_show(struct sxe2_ipsec_conf_param *param, struct cmdline *cl)
+{
+	struct rte_eth_dev *dev       = NULL;
+	int32_t ret = -1;
+	uint16_t i;
+	uint8_t j;
+	char encrypt_key[65];
+	char auth_key[65];
+	const char *encrypt_algo[SXE2_TESTPMD_CMD_IPSEC_EN_ALGO_MAX] = {
+		[SXE2_TESTPMD_CMD_IPSEC_EN_ALGO_AES_CBC] = "aes-cbc",
+		[SXE2_TESTPMD_CMD_IPSEC_EN_ALGO_SM4_CBC] = "sm4-cbc",
+		[SXE2_TESTPMD_CMD_IPSEC_EN_ALGO_NULL] = "null"
+	};
+
+	const char *auth_algo[SXE2_TESTPMD_CMD_IPSEC_AUTH_ALGO_MAX] = {
+		[SXE2_TESTPMD_CMD_IPSEC_AUTH_ALGO_SHA_HMAC] = "sha-hmac",
+		[SXE2_TESTPMD_CMD_IPSEC_AUTH_ALGO_SM3_HMAC] = "sm3-hmac",
+		[SXE2_TESTPMD_CMD_IPSEC_AUTH_ALGO_NULL] = "null"
+	};
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(param->port_id, -ENODEV);
+
+	dev = &rte_eth_devices[param->port_id];
+	if (!sxe2_is_supported(dev)) {
+		PMD_LOG_ERR(DRV, "Invalid dev.");
+		ret = -ENODEV;
+		goto l_end;
+	}
+
+	for (i = 0; i < SXE2_IPSEC_SESSION_MAX; i++) {
+		if (g_tx_session[param->port_id][i].status &&
+		    g_tx_session[param->port_id][i].session) {
+			memset(encrypt_key, '\0', sizeof(encrypt_key));
+			memset(auth_key, '\0', sizeof(auth_key));
+			for (j = 0; j < 32; j++)
+				sprintf(encrypt_key + 2 * j, "%02x",
+					g_tx_session[param->port_id][i].enc_key[j]);
+			if (g_tx_session[param->port_id][i].auth_algo !=
+			    SXE2_TESTPMD_CMD_IPSEC_AUTH_ALGO_NULL)
+				for (j = 0; j < 32; j++)
+					sprintf(auth_key + 2 * j, "%02x",
+						g_tx_session[param->port_id][i].auth_key[j]);
+
+			cmdline_printf(cl, "id:%u, tx , encrypt_algo:%s,"
+				"encrypt_key:0x%s, auth_algo:%s, auth_key:0x%s.\n",
+				i,
+				encrypt_algo[g_tx_session[param->port_id][i].encrypt_algo],
+				encrypt_key,
+				auth_algo[g_tx_session[param->port_id][i].auth_algo],
+				auth_key);
+		}
+	}
+
+	ret = 0;
+
+l_end:
+	return ret;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(sxe2_ipsec_conf_get, 26.07)
+int32_t
+sxe2_ipsec_conf_get(uint16_t port_id, struct cmdline *cl, char type[])
+{
+	struct rte_eth_dev *dev = NULL;
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
+
+	dev = &rte_eth_devices[port_id];
+	if (!sxe2_is_supported(dev)) {
+		PMD_LOG_ERR(DRV, "Invalid dev.");
+		return -ENODEV;
+	}
+	if (!strcmp(type, "session-id"))
+		cmdline_printf(cl, "session-id: %u\n",
+			g_tx_sess_id[port_id]);
+	else if (!strcmp(type, "esp-hdr-offset"))
+		cmdline_printf(cl, "esp-hdr-offset: %u\n",
+			g_esp_header_offset[port_id]);
+	else
+		cmdline_printf(cl, "Invalid type: %s\n", type);
+
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(sxe2_ipsec_conf_set, 26.07)
+int32_t
+sxe2_ipsec_conf_set(uint16_t port_id, struct cmdline *cl, char type[], uint16_t value)
+{
+	struct rte_eth_dev *dev = NULL;
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
+
+	dev = &rte_eth_devices[port_id];
+	if (!sxe2_is_supported(dev)) {
+		PMD_LOG_ERR(DRV, "Invalid dev.");
+		return -ENODEV;
+	}
+	if (!strcmp(type, "session-id")) {
+		if (value >= 4096 || !g_tx_session[port_id][value].status) {
+			cmdline_printf(cl, "Invalid session-id: %u,"
+				"0 <= value <= 4095 or the session is inactive.\n", value);
+			return -EINVAL;
+		}
+		g_tx_sess_id[port_id] = value;
+		cmdline_printf(cl, "session-id: %u\n", g_tx_sess_id[port_id]);
+	} else if (!strcmp(type, "esp-hdr-offset")) {
+		if (value < 34 || value > 512) {
+			cmdline_printf(cl, "Invalid esp-hdr-offset: %u,"
+				       "34 <= value <= 512.\n", value);
+			return -EINVAL;
+		}
+		g_esp_header_offset[port_id] = value;
+		cmdline_printf(cl, "esp-hdr-offset: %u\n",
+			g_esp_header_offset[port_id]);
+	} else {
+		cmdline_printf(cl, "Invalid type: %s\n", type);
+	}
+
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(sxe2_ipsec_stats_show, 26.07)
+int32_t
+sxe2_ipsec_stats_show(uint16_t port_id)
+{
+	(void)port_id;
+	return 0;
+}
+
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(sxe2_ipsec_flush, 26.07)
+int32_t
+sxe2_ipsec_flush(uint16_t port_id, struct cmdline *cl)
+{
+	struct rte_eth_dev   *dev     = NULL;
+	struct rte_security_ctx *p_ctx = NULL;
+	struct rte_security_session *session = NULL;
+	int32_t ret = -1;
+	uint16_t i;
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
+
+	dev = &rte_eth_devices[port_id];
+	if (!sxe2_is_supported(dev)) {
+		cmdline_printf(cl, "Invalid dev.\n");
+		ret = -ENODEV;
+		goto l_end;
+	}
+
+	if (dev->data->dev_started != 0) {
+		cmdline_printf(cl, "port %d must be stopped.\n", dev->data->port_id);
+		ret = 0;
+		goto l_end;
+	}
+
+	p_ctx = rte_eth_dev_get_sec_ctx(port_id);
+
+	g_esp_header_offset[port_id] = 0;
+	g_tx_sess_id[port_id] = 0;
+
+	for (i = 0; i < SXE2_IPSEC_SESSION_MAX; i++) {
+		session = g_tx_session[port_id][i].session;
+		if (g_tx_session[port_id][i].status && session) {
+			ret = rte_security_session_destroy(p_ctx, session);
+			if (ret)
+				cmdline_printf(cl, "failed to destroy tx session: %d.\n", i);
+			else
+				sxe2_ipsec_session_mgt_free(SXE2_TESTPMD_CMD_IPSEC_DIR_EGRESS,
+							    i, port_id);
+		}
+	}
+
+	for (i = 0; i < SXE2_IPSEC_SESSION_MAX; i++) {
+		session = g_rx_session[port_id][i].session;
+		if (g_rx_session[port_id][i].status && session) {
+			ret = rte_security_session_destroy(p_ctx, session);
+			if (ret)
+				cmdline_printf(cl, "failed to destroy rx session: %d.\n", i);
+			else
+				sxe2_ipsec_session_mgt_free(SXE2_TESTPMD_CMD_IPSEC_DIR_INGRESS,
+							    i, port_id);
+		}
+	}
+
+	g_sxe2_ipsec_mgt_init = false;
+	ret = 0;
+
+l_end:
+	return ret;
+}
diff --git a/drivers/net/sxe2/sxe2_testpmd_lib.h b/drivers/net/sxe2/sxe2_testpmd_lib.h
new file mode 100644
index 0000000000..3d2659ef00
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_testpmd_lib.h
@@ -0,0 +1,142 @@
+
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef __SXE2_TESTPMD_LIB_H__
+#define __SXE2_TESTPMD_LIB_H__
+#include <cmdline.h>
+#include "sxe2_ipsec.h"
+
+#define SXE2_IPSEC_SESSION_MAX (4096)
+#define SXE2_IPSEC_PORT_MAX  RTE_MAX_ETHPORTS
+#define MEMPOOL_CACHE_SIZE (512 / 2)
+
+enum {
+	SXE2_TESTPMD_CMD_UDP_TUNNEL_ADD = 0,
+	SXE2_TESTPMD_CMD_UDP_TUNNEL_DEL = 1,
+	SXE2_TESTPMD_CMD_UDP_TUNNEL_GET = 2,
+	SXE2_TESTPMD_CMD_UDP_TUNNEL_MAX,
+};
+
+enum sxe2_testpmd_ipsec_op {
+	SXE2_TESTPMD_CMD_IPSEC_OP_ADD = 0,
+	SXE2_TESTPMD_CMD_IPSEC_OP_RM = 1,
+	SXE2_TESTPMD_CMD_IPSEC_OP_SHOW = 2,
+	SXE2_TESTPMD_CMD_IPSEC_OP_MAX,
+};
+
+enum sxe2_testpmd_ipsec_dir {
+	SXE2_TESTPMD_CMD_IPSEC_DIR_EGRESS = 0,
+	SXE2_TESTPMD_CMD_IPSEC_DIR_INGRESS = 1,
+	SXE2_TESTPMD_CMD_IPSEC_DIR_MAX,
+};
+
+enum sxe2_testpmd_ipsec_encrypt_algo {
+	SXE2_TESTPMD_CMD_IPSEC_EN_ALGO_AES_CBC = 0,
+	SXE2_TESTPMD_CMD_IPSEC_EN_ALGO_SM4_CBC = 1,
+	SXE2_TESTPMD_CMD_IPSEC_EN_ALGO_NULL = 2,
+	SXE2_TESTPMD_CMD_IPSEC_EN_ALGO_MAX,
+};
+
+enum sxe2_testpmd_ipsec_auth_algo {
+	SXE2_TESTPMD_CMD_IPSEC_AUTH_ALGO_SHA_HMAC = 0,
+	SXE2_TESTPMD_CMD_IPSEC_AUTH_ALGO_SM3_HMAC = 1,
+	SXE2_TESTPMD_CMD_IPSEC_AUTH_ALGO_NULL = 2,
+	SXE2_TESTPMD_CMD_IPSEC_AUTH_ALGO_MAX,
+};
+
+struct sxe2_ipsec_conf_param {
+	enum sxe2_testpmd_ipsec_dir dir;
+	enum sxe2_testpmd_ipsec_op op;
+	enum sxe2_testpmd_ipsec_encrypt_algo encrypt_algo;
+	enum sxe2_testpmd_ipsec_auth_algo auth_algo;
+	struct sxe2_ipsec_ip_param ip_addr;
+	uint32_t spi;
+	uint16_t port_id;
+	uint16_t session_id;
+	uint16_t sport;
+	uint16_t dport;
+	uint8_t enc_key[32];
+	uint8_t enc_len;
+	uint8_t auth_key[32];
+	uint8_t auth_len;
+};
+
+struct sxe2_ipsec_session_mgt {
+	void *session;
+	enum sxe2_testpmd_ipsec_encrypt_algo encrypt_algo;
+	enum sxe2_testpmd_ipsec_auth_algo auth_algo;
+	struct sxe2_ipsec_ip_param ip_addr;
+	uint32_t spi;
+	uint16_t session_id;
+	uint16_t sport;
+	uint16_t dport;
+	uint8_t enc_key[32];
+	uint8_t auth_key[32];
+	uint8_t status;
+};
+
+__rte_experimental
+int32_t
+sxe2_testpmd_sched_reset(uint16_t port_id);
+
+__rte_experimental
+int32_t
+sxe2_flow_rule_dump(uint16_t port_id, struct cmdline *cl);
+
+__rte_experimental
+int32_t
+sxe2_udp_tunnel_operations(uint16_t port_id, struct cmdline *cl, uint8_t action,
+			   uint16_t udp_port, const char *tunnel_type);
+
+__rte_experimental
+int32_t
+sxe2_stats_info_show(uint16_t port_id);
+
+__rte_experimental
+int32_t
+sxe2_ipsec_ingress_create(struct sxe2_ipsec_conf_param *param, struct cmdline *cl);
+
+__rte_experimental
+int32_t
+sxe2_ipsec_ingress_destroy(struct sxe2_ipsec_conf_param *param, struct cmdline *cl);
+
+__rte_experimental
+int32_t
+sxe2_ipsec_ingress_show(struct sxe2_ipsec_conf_param *param, struct cmdline *cl);
+
+__rte_experimental
+int32_t
+sxe2_ipsec_egress_create(struct sxe2_ipsec_conf_param *param, struct cmdline *cl);
+
+__rte_experimental
+int32_t
+sxe2_ipsec_egress_destroy(struct sxe2_ipsec_conf_param *param, struct cmdline *cl);
+
+__rte_experimental
+int32_t
+sxe2_ipsec_egress_show(struct sxe2_ipsec_conf_param *param, struct cmdline *cl);
+
+__rte_experimental
+int32_t
+sxe2_ipsec_conf_get(uint16_t port_id, struct cmdline *cl, char type[]);
+
+__rte_experimental
+int32_t
+sxe2_ipsec_conf_set(uint16_t port_id, struct cmdline *cl, char type[], uint16_t value);
+
+__rte_experimental
+int32_t
+sxe2_ipsec_stats_show(uint16_t port_id);
+
+__rte_experimental
+int32_t
+sxe2_ipsec_flush(uint16_t port_id, struct cmdline *cl);
+
+extern struct sxe2_ipsec_session_mgt g_tx_session[SXE2_IPSEC_PORT_MAX][SXE2_IPSEC_SESSION_MAX];
+extern uint16_t g_tx_sess_id[SXE2_IPSEC_PORT_MAX];
+extern uint16_t g_esp_header_offset[SXE2_IPSEC_PORT_MAX];
+extern struct rte_mempool *g_sess_pool;
+
+#endif /* __SXE2_TESTPMD_LIB_H__ */
diff --git a/drivers/net/sxe2/sxe2_tm.c b/drivers/net/sxe2/sxe2_tm.c
index 4c4f793cd5..5de9b5d3b7 100644
--- a/drivers/net/sxe2/sxe2_tm.c
+++ b/drivers/net/sxe2/sxe2_tm.c
@@ -982,6 +982,24 @@ int32_t sxe2_tm_init(struct rte_eth_dev *dev)
 	return ret;
 }
 
+int32_t sxe2_tm_conf_reset(struct rte_eth_dev *dev)
+{
+	int32_t ret;
+
+	ret = sxe2_tm_uninit(dev);
+	if (ret)
+		goto l_end;
+
+	ret = sxe2_tm_init(dev);
+	if (ret)
+		goto l_end;
+
+	PMD_LOG_DEBUG(DRV, "Tm config reset succeed.");
+
+l_end:
+	return ret;
+}
+
 static int32_t sxe2_tm_chk_all_leaf(struct rte_eth_dev *dev)
 {
 	int32_t ret = 0;
diff --git a/drivers/net/sxe2/sxe2_tm.h b/drivers/net/sxe2/sxe2_tm.h
index c4f8da6a8e..b0bfc2091d 100644
--- a/drivers/net/sxe2/sxe2_tm.h
+++ b/drivers/net/sxe2/sxe2_tm.h
@@ -73,4 +73,6 @@ int32_t sxe2_tm_init(struct rte_eth_dev *dev);
 
 int32_t sxe2_tm_uninit(struct rte_eth_dev *dev);
 
+int32_t sxe2_tm_conf_reset(struct rte_eth_dev *dev);
+
 #endif /* __SXE2_TM_H__ */
-- 
2.47.3

