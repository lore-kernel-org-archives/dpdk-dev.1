Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178CDCDB46F
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 14:51:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28748402AD;
	Tue, 23 Jun 2026 16:51:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id EA06740150;
 Tue, 23 Jun 2026 16:50:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782226259; x=1813762259;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=FnMYmVfov29yelhhmjfypfX5v2CUlzq5Pxi9+x9qKk8=;
 b=g2PhGc0yBL9HxF1y+UEK32SYHBShLzpbTKN8H4B4lc2L8RzSD7+Ij0UP
 9zxB1Rlo1B+Gc7bgAKIyIwQs+epOmyfZlxjKfYlCgcJe+w3B7Tulpg30w
 X6JNThdrv8O8FEWn+ya+JGDOxxhWoBBcz0pnqMQmPhC0t9wopk7DmgYrP
 NddhwIGXEHqJOYecvO7jjqvc2FzcfrQ1e7LFgJhvkz3OMUvq84IvEiDbN
 T6Ye8IzcwQi9AhSKZEQcBqkDbOC+CYumJDIt8eyNaw5bjM1mIOPviwARx
 /cYOIcgb3KINnnBZcNTrNINhWDDcHeF6nMjxP/yMJ8QFs/SX7GZo7BFm5 g==;
X-CSE-ConnectionGUID: bOhKR7y1SLWhBo/PmFQeRA==
X-CSE-MsgGUID: nNqiXLKpQrSfBmt77yjmyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="85526446"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="85526446"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 07:50:57 -0700
X-CSE-ConnectionGUID: UNdY+N+oSaekEjen6xVTqQ==
X-CSE-MsgGUID: y/BJq/dbRxuzUKpbSNg93A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="248650580"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 23 Jun 2026 07:50:52 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Kai Ji <kai.ji@intel.com>, Cheng Jiang <honest.jiang@foxmail.com>,
 Chengwen Feng <fengchengwen@huawei.com>, Jerin Jacob <jerinj@marvell.com>,
 Ori Kam <orika@nvidia.com>, Aman Singh <aman.deep.singh@intel.com>,
 Michal Kobylinski <michalx.kobylinski@intel.com>,
 Piotr Azarewicz <piotr.azarewicz@intel.com>,
 Marcin Kerlin <marcinx.kerlin@intel.com>,
 Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>,
 Declan Doherty <declan.doherty@intel.com>,
 Aleksander Gajewski <aleksanderx.gajewski@intel.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>,
 Guduri Prathyusha <gprathyusha@caviumnetworks.com>,
 Harry van Haaren <harry.van.haaren@intel.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Jiayu Hu <hujiayu.hu@foxmail.com>, Yuan Wang <yuanx.wang@intel.com>,
 Anoob Joseph <anoobj@marvell.com>, Xiaoyu Min <jackmin@nvidia.com>,
 Xueming Li <xuemingl@nvidia.com>, Yuval Avnery <yuvalav@nvidia.com>
Subject: [PATCH] app: remove use of strncpy
Date: Tue, 23 Jun 2026 15:50:27 +0100
Message-ID: <20260623145028.711712-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Use of strncpy is not recommended, so replace it with strlcpy or memcpy
as appropriate.

Fixes: f8be1786b1b8 ("app/crypto-perf: introduce performance test application")
Fixes: 8ecd4048ba5d ("app/crypto-perf: fix string not null terminated")
Fixes: 0add6c27cd7c ("app/testeventdev: define the test options")
Fixes: 623dc9364dc6 ("app/dma-perf: introduce DMA performance test")
Fixes: 1e8a4e97b057 ("app/testpmd: add flow dump command")
Fixes: de06137cb295 ("app/regex: add RegEx test application")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test-crypto-perf/cperf_options_parsing.c | 5 ++---
 app/test-dma-perf/main.c                     | 2 +-
 app/test-eventdev/evt_options.c              | 2 +-
 app/test-pmd/cmdline_flow.c                  | 2 +-
 app/test-regex/main.c                        | 9 ++-------
 5 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/app/test-crypto-perf/cperf_options_parsing.c b/app/test-crypto-perf/cperf_options_parsing.c
index 14e731586b..0951293adb 100644
--- a/app/test-crypto-perf/cperf_options_parsing.c
+++ b/app/test-crypto-perf/cperf_options_parsing.c
@@ -481,8 +481,7 @@ parse_device_type(struct cperf_options *opts, const char *arg)
 	if (strlen(arg) > (sizeof(opts->device_type) - 1))
 		return -1;
 
-	strncpy(opts->device_type, arg, sizeof(opts->device_type) - 1);
-	*(opts->device_type + sizeof(opts->device_type) - 1) = '\0';
+	strlcpy(opts->device_type, arg, sizeof(opts->device_type));
 
 	return 0;
 }
@@ -1125,7 +1124,7 @@ cperf_options_default(struct cperf_options *opts)
 	opts->segment_sz = 0;
 
 	opts->imix_distribution_count = 0;
-	strncpy(opts->device_type, "crypto_aesni_mb",
+	strlcpy(opts->device_type, "crypto_aesni_mb",
 			sizeof(opts->device_type));
 	opts->nb_qps = 1;
 
diff --git a/app/test-dma-perf/main.c b/app/test-dma-perf/main.c
index 4249dcfd3d..13bf07a764 100644
--- a/app/test-dma-perf/main.c
+++ b/app/test-dma-perf/main.c
@@ -220,7 +220,7 @@ parse_entry(const char *value, struct test_configure_entry *entry)
 	int args_nr = -1;
 	int ret;
 
-	strncpy(input, value, 254);
+	strlcpy(input, value, sizeof(input));
 	if (*input == '\0')
 		goto out;
 
diff --git a/app/test-eventdev/evt_options.c b/app/test-eventdev/evt_options.c
index 0e70c971eb..1da0aba386 100644
--- a/app/test-eventdev/evt_options.c
+++ b/app/test-eventdev/evt_options.c
@@ -23,7 +23,7 @@ evt_options_default(struct evt_options *opt)
 	memset(opt, 0, sizeof(*opt));
 	opt->verbose_level = 1; /* Enable minimal prints */
 	opt->dev_id = 0;
-	strncpy(opt->test_name, "order_queue", EVT_TEST_NAME_MAX_LEN);
+	strlcpy(opt->test_name, "order_queue", sizeof(opt->test_name));
 	opt->nb_flows = 1024;
 	opt->socket_id = SOCKET_ID_ANY;
 	opt->pool_sz = 16 * 1024;
diff --git a/app/test-pmd/cmdline_flow.c b/app/test-pmd/cmdline_flow.c
index 67f200f2e3..465396d2e5 100644
--- a/app/test-pmd/cmdline_flow.c
+++ b/app/test-pmd/cmdline_flow.c
@@ -11910,7 +11910,7 @@ parse_string0(struct context *ctx, const struct token *token __rte_unused,
 	if (!ctx->object)
 		return len;
 	buf = (uint8_t *)ctx->object + arg_data->offset;
-	strncpy(buf, str, len);
+	memcpy(buf, str, len);
 	if (ctx->objmask)
 		memset((uint8_t *)ctx->objmask + arg_data->offset, 0xff, len);
 	return len;
diff --git a/app/test-regex/main.c b/app/test-regex/main.c
index acb834a8b4..81719f2e04 100644
--- a/app/test-regex/main.c
+++ b/app/test-regex/main.c
@@ -103,7 +103,6 @@ args_parse(int argc, char **argv, char *rules_file, char *data_file,
 	char **argvopt;
 	int opt;
 	int opt_idx;
-	size_t len;
 	static struct option lgopts[] = {
 		{ "help",  0, 0, ARG_HELP},
 		/* Rules database file to load. */
@@ -133,20 +132,16 @@ args_parse(int argc, char **argv, char *rules_file, char *data_file,
 				lgopts, &opt_idx)) != EOF) {
 		switch (opt) {
 		case ARG_RULES_FILE_NAME:
-			len = strnlen(optarg, MAX_FILE_NAME - 1);
-			if (len == MAX_FILE_NAME)
+			if (strlcpy(rules_file, optarg, MAX_FILE_NAME) >= MAX_FILE_NAME)
 				rte_exit(EXIT_FAILURE,
 					 "Rule file name to long max %d\n",
 					 MAX_FILE_NAME - 1);
-			strncpy(rules_file, optarg, MAX_FILE_NAME - 1);
 			break;
 		case ARG_DATA_FILE_NAME:
-			len = strnlen(optarg, MAX_FILE_NAME - 1);
-			if (len == MAX_FILE_NAME)
+			if (strlcpy(data_file, optarg, MAX_FILE_NAME) >= MAX_FILE_NAME)
 				rte_exit(EXIT_FAILURE,
 					 "Data file name to long max %d\n",
 					 MAX_FILE_NAME - 1);
-			strncpy(data_file, optarg, MAX_FILE_NAME - 1);
 			break;
 		case ARG_NUM_OF_JOBS:
 			*nb_jobs = atoi(optarg);
-- 
2.53.0

