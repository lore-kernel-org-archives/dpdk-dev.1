Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6349EFB810
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 07:27:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1188402F2;
	Tue, 24 Feb 2026 08:27:03 +0100 (CET)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com
 [113.46.200.219])
 by mails.dpdk.org (Postfix) with ESMTP id 3FB78402DF
 for <dev@dpdk.org>; Tue, 24 Feb 2026 08:27:00 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=bVBOF3KiugMA+yEtSbrNe95h13PZfTHF6jOzTXniEHc=;
 b=vhIgphvFaCddJTCSvt3Xn4PjgyjpU8OemlTrwPxgtWfkWHGkAJLLMB9R58OHavEuzvoSPVYzI
 Re9hRfufl4gGCHwIEuTO4xI0frMRzKKULe/79bZPrYblpZwaQdfVByMxw/LGgSbVyO/eEW0/xH4
 V8RGb7UM3x8JELw0r3cMweI=
Received: from mail.maildlp.com (unknown [172.19.162.223])
 by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4fKq0w01GVz1prKc;
 Tue, 24 Feb 2026 15:22:07 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 8A3C740569;
 Tue, 24 Feb 2026 15:26:56 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 24 Feb 2026 15:26:56 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: [PATCH 2/2] app/testpmd: add show DCB fwd-tc command
Date: Tue, 24 Feb 2026 15:26:47 +0800
Message-ID: <20260224072647.607-3-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260224072647.607-1-fengchengwen@huawei.com>
References: <20260224072647.607-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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

This commit adds "show config dcbfwdtc" command which show DCB
forwarding TC list and cores per-TC.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test-pmd/cmdline.c                      | 20 +++++++++++++++++---
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  4 +++-
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 012a3ad32f..e9a1331071 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -195,7 +195,7 @@ static void cmd_help_long_parsed(void *parsed_result,
 			"show (rxq|txq) info (port_id) (queue_id)\n"
 			"    Display information for configured RX/TX queue.\n\n"
 
-			"show config (rxtx|cores|fwd|rxoffs|rxpkts|rxhdrs|txpkts)\n"
+			"show config (rxtx|cores|fwd|rxoffs|rxpkts|rxhdrs|txpkts|txtimes|dcbfwdtc)\n"
 			"    Display the given configuration.\n\n"
 
 			"read rxd (port_id) (queue_id) (rxd_id)\n"
@@ -6227,6 +6227,18 @@ static void cmd_set_fwd_retry_mode_init(void)
 	token_struct->string_data.str = token;
 }
 
+static void show_dcb_fwd_tc_config(void)
+{
+	int i;
+	printf("DCB forwarding TC list:");
+	for (i = 0; i < RTE_ETH_8_TCS; i++) {
+		if (dcb_fwd_tc_mask & (1u << i))
+			printf(" %d", i);
+	}
+	printf("\n");
+	printf("DCB forwarding cores per-TC: %u\n", dcb_fwd_tc_cores);
+}
+
 /* *** set DCB forward TCs *** */
 struct cmd_set_dcb_fwd_tc_result {
 	cmdline_fixed_string_t set;
@@ -7390,6 +7402,8 @@ static void cmd_showcfg_parsed(void *parsed_result,
 		show_tx_pkt_segments();
 	else if (!strcmp(res->what, "txtimes"))
 		show_tx_pkt_times();
+	else if (!strcmp(res->what, "dcbfwdtc"))
+		show_dcb_fwd_tc_config();
 }
 
 static cmdline_parse_token_string_t cmd_showcfg_show =
@@ -7398,12 +7412,12 @@ static cmdline_parse_token_string_t cmd_showcfg_port =
 	TOKEN_STRING_INITIALIZER(struct cmd_showcfg_result, cfg, "config");
 static cmdline_parse_token_string_t cmd_showcfg_what =
 	TOKEN_STRING_INITIALIZER(struct cmd_showcfg_result, what,
-				 "rxtx#cores#fwd#rxoffs#rxpkts#rxhdrs#txpkts#txtimes");
+				 "rxtx#cores#fwd#rxoffs#rxpkts#rxhdrs#txpkts#txtimes#dcbfwdtc");
 
 static cmdline_parse_inst_t cmd_showcfg = {
 	.f = cmd_showcfg_parsed,
 	.data = NULL,
-	.help_str = "show config rxtx|cores|fwd|rxoffs|rxpkts|rxhdrs|txpkts|txtimes",
+	.help_str = "show config rxtx|cores|fwd|rxoffs|rxpkts|rxhdrs|txpkts|txtimes|dcbfwdtc",
 	.tokens = {
 		(void *)&cmd_showcfg_show,
 		(void *)&cmd_showcfg_port,
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index 62bb167d56..3c078578d8 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -297,7 +297,7 @@ show config
 Displays the configuration of the application.
 The configuration comes from the command-line, the runtime or the application defaults::
 
-   testpmd> show config (rxtx|cores|fwd|rxoffs|rxpkts|rxhdrs|txpkts|txtimes)
+   testpmd> show config (rxtx|cores|fwd|rxoffs|rxpkts|rxhdrs|txpkts|txtimes|dcbfwdtc)
 
 The available information categories are:
 
@@ -317,6 +317,8 @@ The available information categories are:
 
 * ``txtimes``: Burst time pattern for Tx only mode.
 
+* ``dcbfwdtc``: DCB forwarding TC-related configuration.
+
 For example:
 
 .. code-block:: console
-- 
2.17.1

