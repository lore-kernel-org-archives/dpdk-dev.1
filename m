Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9837ECCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 09:48:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 733F4406BA;
	Wed,  5 Nov 2025 10:48:01 +0100 (CET)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com
 [113.46.200.221])
 by mails.dpdk.org (Postfix) with ESMTP id CFB2540685
 for <dev@dpdk.org>; Wed,  5 Nov 2025 10:47:56 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=YbLlupLPGfvL1UFWHldvfIOHGLZRlgREjJKlL/x23d4=;
 b=6Or/2GtxH//9bvyf+elwmyTtJuahExF7IpbBWFrYYy/KM90zEiESpADQydNjSPrPLRT9JzfzW
 +lhgcBWjXT092/GFFTSWmD/OC3va6349dLSch7/FVNn55Zr9CjdCQ9S93rwxLtiSl81IccuksDf
 D5pBkFoHl8yZ0XB4foms2Uo=
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4d1gSY02NrzRhS8;
 Wed,  5 Nov 2025 17:46:21 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id B78CF1400CD;
 Wed,  5 Nov 2025 17:47:55 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Nov 2025 17:47:55 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>, <liuyonglong@huawei.com>,
 <yangxingui@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH v2 3/3] app/testpmd: support pause/resume specify lcore
Date: Wed, 5 Nov 2025 17:47:48 +0800
Message-ID: <20251105094748.3269-4-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251105094748.3269-1-fengchengwen@huawei.com>
References: <20251104040916.25864-1-fengchengwen@huawei.com>
 <20251105094748.3269-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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

This commit supports pause/resume specify lcore, the command:

  pause  fwd_core (lcore_id)
  resume fwd_core (lcore_id)

The background of this command:
1. Only some TCs are expected to generate traffic when the DCB function
   is tested based on txonly forwarding.
2. Because each lcore will process all the traffic of one TC, therefore,
   we could pause the lcores which process unexpected TCs by this
   command.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test-pmd/cmdline.c                      | 126 ++++++++++++++++++++
 app/test-pmd/testpmd.c                      |   5 +
 app/test-pmd/testpmd.h                      |   2 +-
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  14 +++
 4 files changed, 146 insertions(+), 1 deletion(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 22afbdbad3..dacc1921bd 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -150,6 +150,12 @@ static void cmd_help_long_parsed(void *parsed_result,
 			"    Stop packet forwarding, and display accumulated"
 			" statistics.\n\n"
 
+			"pause fwd_core (lcore_id)\n"
+			"    Pause specify lcore's forwarding.\n\n"
+
+			"resume fwd_core (lcore_id)\n"
+			"    Resume specify lcore's forwarding.\n\n"
+
 			"quit\n"
 			"    Quit to prompt.\n\n"
 		);
@@ -3975,6 +3981,124 @@ static cmdline_parse_inst_t cmd_stop = {
 	},
 };
 
+/* *** pause specify forward core *** */
+struct cmd_pause_fwd_core_result {
+	cmdline_fixed_string_t pause;
+	cmdline_fixed_string_t fwd_core;
+	uint32_t lcore_id;
+};
+
+static void
+cmd_pause_fwd_core_parsed(void *parsed_result,
+			  __rte_unused struct cmdline *cl,
+			  __rte_unused void *data)
+{
+	struct cmd_pause_fwd_core_result *res = parsed_result;
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
+	if (fc->stopped == 2) {
+		fprintf(stderr, "core: %u already paused!\n", res->lcore_id);
+		return;
+	}
+
+	printf("Telling core: %u to pause...", res->lcore_id);
+	fc->stopped = 2;
+	printf("\nWaiting for core: %u to finish...\n", res->lcore_id);
+	rte_delay_ms(10);
+	printf("Done.\n");
+}
+
+static cmdline_parse_token_string_t cmd_pause_fwd_core_pause =
+	TOKEN_STRING_INITIALIZER(struct cmd_pause_fwd_core_result,
+			pause, "pause");
+static cmdline_parse_token_string_t cmd_pause_fwd_core_fwd_core =
+	TOKEN_STRING_INITIALIZER(struct cmd_pause_fwd_core_result,
+			fwd_core, "fwd_core");
+static cmdline_parse_token_num_t cmd_pause_fwd_core_lcore_id =
+	TOKEN_NUM_INITIALIZER(struct cmd_pause_fwd_core_result,
+			lcore_id, RTE_UINT32);
+
+static cmdline_parse_inst_t cmd_pause_fwd_core = {
+	.f = cmd_pause_fwd_core_parsed,
+	.data = NULL,
+	.help_str = "pause fwd_core <lcore_id>: pause specify lcore's forwarding.",
+	.tokens = {
+		(void *)&cmd_pause_fwd_core_pause,
+		(void *)&cmd_pause_fwd_core_fwd_core,
+		(void *)&cmd_pause_fwd_core_lcore_id,
+		NULL,
+	},
+};
+
+/* *** resume specify forward core *** */
+struct cmd_resume_fwd_core_result {
+	cmdline_fixed_string_t resume;
+	cmdline_fixed_string_t fwd_core;
+	uint32_t lcore_id;
+};
+
+static void
+cmd_resume_fwd_core_parsed(void *parsed_result,
+			   __rte_unused struct cmdline *cl,
+			   __rte_unused void *data)
+{
+	struct cmd_resume_fwd_core_result *res = parsed_result;
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
+	if (fc->stopped != 2) {
+		fprintf(stderr, "core: %u not in pause state!\n", res->lcore_id);
+		return;
+	}
+
+	printf("Telling core: %u to resume...", res->lcore_id);
+	fc->stopped = 0;
+	printf("\nWaiting for core: %u to resume...\n", res->lcore_id);
+	rte_delay_ms(10);
+	printf("Done.\n");
+}
+
+static cmdline_parse_token_string_t cmd_resume_fwd_core_resume =
+	TOKEN_STRING_INITIALIZER(struct cmd_resume_fwd_core_result,
+			resume, "resume");
+static cmdline_parse_token_string_t cmd_resume_fwd_core_fwd_core =
+	TOKEN_STRING_INITIALIZER(struct cmd_resume_fwd_core_result,
+			fwd_core, "fwd_core");
+static cmdline_parse_token_num_t cmd_resume_fwd_core_lcore_id =
+	TOKEN_NUM_INITIALIZER(struct cmd_resume_fwd_core_result,
+			lcore_id, RTE_UINT32);
+
+static cmdline_parse_inst_t cmd_resume_fwd_core = {
+	.f = cmd_resume_fwd_core_parsed,
+	.data = NULL,
+	.help_str = "resume fwd_core <lcore_id>: resume specify lcore's forwarding.",
+	.tokens = {
+		(void *)&cmd_resume_fwd_core_resume,
+		(void *)&cmd_resume_fwd_core_fwd_core,
+		(void *)&cmd_resume_fwd_core_lcore_id,
+		NULL,
+	},
+};
+
 static unsigned int
 get_ptype(char *value)
 {
@@ -14051,6 +14175,8 @@ static cmdline_parse_ctx_t builtin_ctx[] = {
 	&cmd_config_dcb,
 	&cmd_read_rxd_txd,
 	&cmd_stop,
+	&cmd_pause_fwd_core,
+	&cmd_resume_fwd_core,
 	&cmd_mac_addr,
 	&cmd_set_fwd_eth_peer,
 	&cmd_set_xstats_hide_zero,
diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index 2360da3a48..05549be1c5 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -2247,6 +2247,7 @@ run_pkt_fwd_on_lcore(struct fwd_lcore *fc, packet_fwd_t pkt_fwd)
 #endif
 	fsm = &fwd_streams[fc->stream_idx];
 	nb_fs = fc->stream_nb;
+_resume:
 	prev_tsc = rte_rdtsc();
 	do {
 		for (sm_id = 0; sm_id < nb_fs; sm_id++) {
@@ -2287,6 +2288,10 @@ run_pkt_fwd_on_lcore(struct fwd_lcore *fc, packet_fwd_t pkt_fwd)
 			prev_tsc = tsc;
 		}
 	} while (! fc->stopped);
+	while (fc->stopped == 2)
+		rte_pause();
+	if (fc->stopped == 0)
+		goto _resume;
 }
 
 static int
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index fa46865c67..c3c4373af7 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -399,7 +399,7 @@ struct fwd_lcore {
 	streamid_t stream_idx;   /**< index of 1st stream in "fwd_streams" */
 	streamid_t stream_nb;    /**< number of streams in "fwd_streams" */
 	lcoreid_t  cpuid_idx;    /**< index of logical core in CPU id table */
-	volatile char stopped;   /**< stop forwarding when set */
+	volatile char stopped;   /**< stop forwarding when set to 1, pause when set to 2 */
 	uint64_t total_cycles;   /**< used with --record-core-cycles */
 };
 
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index e423abd40e..be125ff35c 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -143,6 +143,20 @@ Stop packet forwarding, and display accumulated statistics::
 
    testpmd> stop
 
+pause fwd_core
+~~~~~~~~~~~~~~
+
+Pause specify lcore's forwarding::
+
+   testpmd> pause fwd_core (lcore_id)
+
+resume fwd_core
+~~~~~~~~~~~~~~~
+
+Resume specify lcore's forwarding::
+
+   testpmd> resume fwd_core (lcore_id)
+
 quit
 ~~~~
 
-- 
2.17.1

