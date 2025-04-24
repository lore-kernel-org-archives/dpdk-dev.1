Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D45C369AB
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Apr 2025 06:18:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8272F4064C;
	Thu, 24 Apr 2025 08:18:03 +0200 (CEST)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mails.dpdk.org (Postfix) with ESMTP id 134A6402F0
 for <dev@dpdk.org>; Thu, 24 Apr 2025 08:18:00 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.44])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Zjm031Sxtz2CdLb;
 Thu, 24 Apr 2025 14:14:27 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id EC8A4140146;
 Thu, 24 Apr 2025 14:17:56 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 24 Apr 2025 14:17:56 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <aman.deep.singh@intel.com>
CC: <dev@dpdk.org>
Subject: [PATCH v3 4/4] app/testpmd: support disable DCB command
Date: Thu, 24 Apr 2025 14:17:49 +0800
Message-ID: <20250424061749.44683-5-fengchengwen@huawei.com>
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

After the "port config 0 dcb ..." command is invoked, no command is
available to disable DCB.

This commit introduces disable DCB when num_tcs is 1, so user could
disable the DCB by command:
  port config 0 dcb vt off 1 pfc off

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test-pmd/cmdline.c                      |  4 +-
 app/test-pmd/testpmd.c                      | 58 ++++++++++++++-------
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  2 +-
 3 files changed, 43 insertions(+), 21 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 198354c3c0..7b4e27eddf 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -3625,9 +3625,9 @@ cmd_config_dcb_parsed(void *parsed_result,
 		return;
 	}
 
-	if (res->num_tcs <= 1 || res->num_tcs > RTE_ETH_8_TCS) {
+	if (res->num_tcs < 1 || res->num_tcs > RTE_ETH_8_TCS) {
 		fprintf(stderr,
-			"The invalid number of traffic class, only 2~8 allowed.\n");
+			"The invalid number of traffic class, only 1~8 allowed.\n");
 		return;
 	}
 
diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index 3b6b879659..e4f6f5ee09 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -4198,6 +4198,22 @@ get_eth_dcb_conf(struct rte_eth_conf *eth_conf, enum dcb_mode_enable dcb_mode,
 		eth_conf->dcb_capability_en = RTE_ETH_DCB_PG_SUPPORT;
 }
 
+static void
+clear_eth_dcb_conf(portid_t pid, struct rte_eth_conf *eth_conf)
+{
+	uint32_t i;
+
+	eth_conf->rxmode.mq_mode &= ~(RTE_ETH_MQ_RX_DCB | RTE_ETH_MQ_RX_VMDQ_DCB);
+	eth_conf->txmode.mq_mode = RTE_ETH_MQ_TX_NONE;
+	eth_conf->dcb_capability_en = 0;
+	if (dcb_config) {
+		/* Unset VLAN filter configuration if already config DCB. */
+		eth_conf->rxmode.offloads &= ~RTE_ETH_RX_OFFLOAD_VLAN_FILTER;
+		for (i = 0; i < RTE_DIM(vlan_tags); i++)
+			rx_vft_set(pid, vlan_tags[i], 0);
+	}
+}
+
 int
 init_port_dcb_config(portid_t pid,
 		     enum dcb_mode_enable dcb_mode,
@@ -4221,16 +4237,19 @@ init_port_dcb_config(portid_t pid,
 	/* retain the original device configuration. */
 	memcpy(&port_conf, &rte_port->dev_conf, sizeof(struct rte_eth_conf));
 
-	/* set configuration of DCB in vt mode and DCB in non-vt mode */
-	get_eth_dcb_conf(&port_conf, dcb_mode, num_tcs, pfc_en, prio_tc, prio_tc_en);
-
-	port_conf.rxmode.offloads |= RTE_ETH_RX_OFFLOAD_VLAN_FILTER;
-	/* remove RSS HASH offload for DCB in vt mode */
-	if (port_conf.rxmode.mq_mode == RTE_ETH_MQ_RX_VMDQ_DCB) {
-		port_conf.rxmode.offloads &= ~RTE_ETH_RX_OFFLOAD_RSS_HASH;
-		for (i = 0; i < nb_rxq; i++)
-			rte_port->rxq[i].conf.offloads &=
-				~RTE_ETH_RX_OFFLOAD_RSS_HASH;
+	if (num_tcs > 1) {
+		/* set configuration of DCB in vt mode and DCB in non-vt mode */
+		get_eth_dcb_conf(&port_conf, dcb_mode, num_tcs, pfc_en, prio_tc, prio_tc_en);
+		port_conf.rxmode.offloads |= RTE_ETH_RX_OFFLOAD_VLAN_FILTER;
+		/* remove RSS HASH offload for DCB in vt mode */
+		if (port_conf.rxmode.mq_mode == RTE_ETH_MQ_RX_VMDQ_DCB) {
+			port_conf.rxmode.offloads &= ~RTE_ETH_RX_OFFLOAD_RSS_HASH;
+			for (i = 0; i < nb_rxq; i++)
+				rte_port->rxq[i].conf.offloads &=
+					~RTE_ETH_RX_OFFLOAD_RSS_HASH;
+		}
+	} else {
+		clear_eth_dcb_conf(pid, &port_conf);
 	}
 
 	/* re-configure the device . */
@@ -4245,7 +4264,8 @@ init_port_dcb_config(portid_t pid,
 	/* If dev_info.vmdq_pool_base is greater than 0,
 	 * the queue id of vmdq pools is started after pf queues.
 	 */
-	if (dcb_mode == DCB_VT_ENABLED &&
+	if (num_tcs > 1 &&
+	    dcb_mode == DCB_VT_ENABLED &&
 	    rte_port->dev_info.vmdq_pool_base > 0) {
 		fprintf(stderr,
 			"VMDQ_DCB multi-queue mode is nonsensical for port %d.\n",
@@ -4253,7 +4273,7 @@ init_port_dcb_config(portid_t pid,
 		return -1;
 	}
 
-	if (keep_qnum == 0) {
+	if (num_tcs > 1 && keep_qnum == 0) {
 		/* Assume the ports in testpmd have the same dcb capability
 		 * and has the same number of rxq and txq in dcb mode
 		 */
@@ -4281,19 +4301,21 @@ init_port_dcb_config(portid_t pid,
 	memcpy(&rte_port->dev_conf, &port_conf, sizeof(struct rte_eth_conf));
 
 	rxtx_port_config(pid);
-	/* VLAN filter */
-	rte_port->dev_conf.rxmode.offloads |= RTE_ETH_RX_OFFLOAD_VLAN_FILTER;
-	for (i = 0; i < RTE_DIM(vlan_tags); i++)
-		rx_vft_set(pid, vlan_tags[i], 1);
+	if (num_tcs > 1) {
+		/* VLAN filter */
+		rte_port->dev_conf.rxmode.offloads |= RTE_ETH_RX_OFFLOAD_VLAN_FILTER;
+		for (i = 0; i < RTE_DIM(vlan_tags); i++)
+			rx_vft_set(pid, vlan_tags[i], 1);
+	}
 
 	retval = eth_macaddr_get_print_err(pid, &rte_port->eth_addr);
 	if (retval != 0)
 		return retval;
 
-	rte_port->dcb_flag = 1;
+	rte_port->dcb_flag = num_tcs > 1 ? 1 : 0;
 
 	/* Enter DCB configuration status */
-	dcb_config = 1;
+	dcb_config = num_tcs > 1 ? 1 : 0;
 
 	return 0;
 }
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index 44eed3f49d..6ad83ae50d 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -2167,7 +2167,7 @@ Set the DCB mode for an individual port::
 
    testpmd> port config (port_id) dcb vt (on|off) (traffic_class) pfc (on|off) prio-tc (prio-tc) keep-qnum
 
-The traffic class could be 2~8.
+The traffic class could be 1~8, if the value is 1, DCB is disabled.
 The prio-tc field here is optional, if not specified then the prio-tc use default configuration.
 The keep-qnum field here is also optional, if specified then don't adjust Rx/Tx queue number.
 
-- 
2.17.1

