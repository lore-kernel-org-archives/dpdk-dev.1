Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15811CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 04:09:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0751740658;
	Tue,  4 Nov 2025 05:09:30 +0100 (CET)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com
 [113.46.200.227])
 by mails.dpdk.org (Postfix) with ESMTP id ADB8540299
 for <dev@dpdk.org>; Tue,  4 Nov 2025 05:09:25 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=9fkS6wbW+lHryc7Ji9C2/Vnm+EIsyYWAGPCDAHeOtX8=;
 b=hq6nyuOH7awLIV6hS/MUnMrO7DQB5gJZlFHu8coBN1n9rHLNk6jQoS/RH+xV0MyLxCyAWesnk
 dv13v1m6DaQFVnbqbvx0757A2WBySrwE/IAYrK46gFC1hHLoSxi1ICXop2K9sW15h1BMa97hpQp
 YmUcxb9wAhh4YuDHNYwNi9U=
Received: from mail.maildlp.com (unknown [172.19.162.112])
 by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d0w0N0GlCznTbl;
 Tue,  4 Nov 2025 12:07:48 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 273971401E9;
 Tue,  4 Nov 2025 12:09:24 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Nov 2025 12:09:23 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>, <liuyonglong@huawei.com>,
 <yangxingui@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH 3/3] app/testpmd: support stop specify lcore
Date: Tue, 4 Nov 2025 12:09:16 +0800
Message-ID: <20251104040916.25864-4-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251104040916.25864-1-fengchengwen@huawei.com>
References: <20251104040916.25864-1-fengchengwen@huawei.com>
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

This commit supports stop specify lcore, the command:

  stop fwd_core (lcore_id)

The background of this command:
1. Only some TCs are expected to generate traffic when the DCB function
   is tested based on txonly forwarding.
2. Because each lcore will process all the traffic of one TC, therefore,
   we could stop the lcores which process unexpected TCs by this
   command.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test-pmd/cmdline.c                      | 63 +++++++++++++++++++++
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  7 +++
 2 files changed, 70 insertions(+)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 22afbdbad3..e03f6e6181 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -150,6 +150,9 @@ static void cmd_help_long_parsed(void *parsed_result,
 			"    Stop packet forwarding, and display accumulated"
 			" statistics.\n\n"
 
+			"stop fwd_core (lcore_id)\n"
+			"    Stop specify lcore's forwarding.\n\n"
+
 			"quit\n"
 			"    Quit to prompt.\n\n"
 		);
@@ -3975,6 +3978,65 @@ static cmdline_parse_inst_t cmd_stop = {
 	},
 };
 
+/* *** stop specify forward core *** */
+struct cmd_stop_fwd_core_result {
+	cmdline_fixed_string_t stop;
+	cmdline_fixed_string_t fwd_core;
+	uint32_t lcore_id;
+};
+
+static void
+cmd_stop_fwd_core_parsed(void *parsed_result,
+			 __rte_unused struct cmdline *cl,
+			 __rte_unused void *data)
+{
+	struct cmd_stop_fwd_core_result *res = parsed_result;
+	struct fwd_lcore *fc = lcore_to_fwd_lcore(res->lcore_id);
+
+	if (test_done) {
+		fprintf(stderr, "Packet forwarding not started\n");
+		return;
+	}
+
+	if (fc == NULL) {
+		fprintf(stderr, "core: %u not in the forward corelist.\n", res->lcore_id);
+		return;
+	}
+
+	if (fc->stopped) {
+		fprintf(stderr, "core: %u already stopped!\n", res->lcore_id);
+		return;
+	}
+
+	printf("Telling core: %u to stop...", res->lcore_id);
+	fc->stopped = 1;
+	printf("\nWaiting for core: %u to finish...\n", res->lcore_id);
+	rte_eal_wait_lcore(res->lcore_id);
+	printf("Done.\n");
+}
+
+static cmdline_parse_token_string_t cmd_stop_fwd_core_stop =
+	TOKEN_STRING_INITIALIZER(struct cmd_stop_fwd_core_result,
+			stop, "stop");
+static cmdline_parse_token_string_t cmd_stop_fwd_core_fwd_core =
+	TOKEN_STRING_INITIALIZER(struct cmd_stop_fwd_core_result,
+			fwd_core, "fwd_core");
+static cmdline_parse_token_num_t cmd_stop_fwd_core_lcore_id =
+	TOKEN_NUM_INITIALIZER(struct cmd_stop_fwd_core_result,
+			lcore_id, RTE_UINT32);
+
+static cmdline_parse_inst_t cmd_stop_fwd_core = {
+	.f = cmd_stop_fwd_core_parsed,
+	.data = NULL,
+	.help_str = "stop fwd_core <lcore_id>: stop specify lcore's forwarding.",
+	.tokens = {
+		(void *)&cmd_stop_fwd_core_stop,
+		(void *)&cmd_stop_fwd_core_fwd_core,
+		(void *)&cmd_stop_fwd_core_lcore_id,
+		NULL,
+	},
+};
+
 static unsigned int
 get_ptype(char *value)
 {
@@ -14051,6 +14113,7 @@ static cmdline_parse_ctx_t builtin_ctx[] = {
 	&cmd_config_dcb,
 	&cmd_read_rxd_txd,
 	&cmd_stop,
+	&cmd_stop_fwd_core,
 	&cmd_mac_addr,
 	&cmd_set_fwd_eth_peer,
 	&cmd_set_xstats_hide_zero,
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index e423abd40e..0a362d06b8 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -143,6 +143,13 @@ Stop packet forwarding, and display accumulated statistics::
 
    testpmd> stop
 
+stop fwd_core
+~~~~~~~~~~~~~
+
+Stop specify lcore's forwarding::
+
+   testpmd> stop fwd_core (lcore_id)
+
 quit
 ~~~~
 
-- 
2.17.1

