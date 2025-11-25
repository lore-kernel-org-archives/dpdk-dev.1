Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D7FCFD376
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Nov 2025 03:42:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B75B640A6C;
	Tue, 25 Nov 2025 04:42:08 +0100 (CET)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com
 [113.46.200.217])
 by mails.dpdk.org (Postfix) with ESMTP id 096084067B
 for <dev@dpdk.org>; Tue, 25 Nov 2025 04:42:06 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=TxdGR1yFLgZmE1wIjG1KiyfeCZdIjegEyPCXOBFEH6g=;
 b=Y5S1VqNf9Z17YiD1rPEUieVQoTNFUR8XoH59/E8zCBmYZMDsv6FHJ8lrnyq57IHbjo2vVMgV4
 YtrES3PEZqMYP6AjL6JJkmo99w9qWAaPBnOcGLzfRXy9THpkiMTUpkiLKZncph6dtDlGzT/0hpg
 0P6e3TZT8OE1rztrsblsw0w=
Received: from mail.maildlp.com (unknown [172.19.88.105])
 by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dFpNR1z1gzcZxk;
 Tue, 25 Nov 2025 11:39:51 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 130891402C1;
 Tue, 25 Nov 2025 11:42:04 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 25 Nov 2025 11:42:03 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: [PATCH 2/2] app/testpmd: support show DCB config
Date: Tue, 25 Nov 2025 11:41:58 +0800
Message-ID: <20251125034158.55192-3-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251125034158.55192-1-fengchengwen@huawei.com>
References: <20251125034158.55192-1-fengchengwen@huawei.com>
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

Add command 'show config dcbfwd' which show DCB configuration.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test-pmd/cmdline.c                      | 22 ++++++++++++++++++---
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  4 +++-
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index e701cd7ec4..d90c97a161 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -195,7 +195,7 @@ static void cmd_help_long_parsed(void *parsed_result,
 			"show (rxq|txq) info (port_id) (queue_id)\n"
 			"    Display information for configured RX/TX queue.\n\n"
 
-			"show config (rxtx|cores|fwd|rxoffs|rxpkts|rxhdrs|txpkts)\n"
+			"show config (rxtx|cores|fwd|dcbfwd|rxoffs|rxpkts|rxhdrs|txpkts|txtimes)\n"
 			"    Display the given configuration.\n\n"
 
 			"read rxd (port_id) (queue_id) (rxd_id)\n"
@@ -7364,6 +7364,20 @@ struct cmd_showcfg_result {
 	cmdline_fixed_string_t what;
 };
 
+static void show_dcb_fwd_config(void)
+{
+	uint8_t i;
+
+	printf("DCB forwarding config:\n");
+	printf("  Enabled TC list:");
+	for (i = 0; i < RTE_ETH_8_TCS; i++) {
+		if (dcb_fwd_tc_mask & (1u << i))
+			printf(" %d", i);
+	}
+	printf("\n");
+	printf("  Cores-per-TC: %u\n", dcb_fwd_tc_cores);
+}
+
 static void cmd_showcfg_parsed(void *parsed_result,
 			       __rte_unused struct cmdline *cl,
 			       __rte_unused void *data)
@@ -7375,6 +7389,8 @@ static void cmd_showcfg_parsed(void *parsed_result,
 		fwd_lcores_config_display();
 	else if (!strcmp(res->what, "fwd"))
 		pkt_fwd_config_display(&cur_fwd_config);
+	else if (!strcmp(res->what, "dcbfwd"))
+		show_dcb_fwd_config();
 	else if (!strcmp(res->what, "rxoffs"))
 		show_rx_pkt_offsets();
 	else if (!strcmp(res->what, "rxpkts"))
@@ -7393,12 +7409,12 @@ static cmdline_parse_token_string_t cmd_showcfg_port =
 	TOKEN_STRING_INITIALIZER(struct cmd_showcfg_result, cfg, "config");
 static cmdline_parse_token_string_t cmd_showcfg_what =
 	TOKEN_STRING_INITIALIZER(struct cmd_showcfg_result, what,
-				 "rxtx#cores#fwd#rxoffs#rxpkts#rxhdrs#txpkts#txtimes");
+				 "rxtx#cores#fwd#dcbfwd#rxoffs#rxpkts#rxhdrs#txpkts#txtimes");
 
 static cmdline_parse_inst_t cmd_showcfg = {
 	.f = cmd_showcfg_parsed,
 	.data = NULL,
-	.help_str = "show config rxtx|cores|fwd|rxoffs|rxpkts|rxhdrs|txpkts|txtimes",
+	.help_str = "show config rxtx|cores|fwd|dcbfwd|rxoffs|rxpkts|rxhdrs|txpkts|txtimes",
 	.tokens = {
 		(void *)&cmd_showcfg_show,
 		(void *)&cmd_showcfg_port,
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index 62bb167d56..d20c603cef 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -297,7 +297,7 @@ show config
 Displays the configuration of the application.
 The configuration comes from the command-line, the runtime or the application defaults::
 
-   testpmd> show config (rxtx|cores|fwd|rxoffs|rxpkts|rxhdrs|txpkts|txtimes)
+   testpmd> show config (rxtx|cores|fwd|dcbfwd|rxoffs|rxpkts|rxhdrs|txpkts|txtimes)
 
 The available information categories are:
 
@@ -307,6 +307,8 @@ The available information categories are:
 
 * ``fwd``: Packet forwarding configuration.
 
+* ``dcbfwd``: DCB forwarding configuration.
+
 * ``rxoffs``: Packet offsets for RX split.
 
 * ``rxpkts``: Packets to RX length-based split configuration.
-- 
2.17.1

