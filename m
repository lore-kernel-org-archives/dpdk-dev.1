Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A6BC0219B
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 03:13:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2AAC402D5;
	Fri,  7 Feb 2025 04:13:39 +0100 (CET)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by mails.dpdk.org (Postfix) with ESMTP id 3831B402A7
 for <dev@dpdk.org>; Fri,  7 Feb 2025 04:13:36 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.163.252])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YpzXZ5tXLzrT2M;
 Fri,  7 Feb 2025 11:11:58 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id A70521800DB;
 Fri,  7 Feb 2025 11:13:34 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 7 Feb 2025 11:13:34 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <reshma.pattan@intel.com>, <stephen@networkplumber.org>,
 <lihuisong@huawei.com>, <fengchengwen@huawei.com>, <haijie1@huawei.com>,
 <liuyonglong@huawei.com>
Subject: [PATCH v2] app/procinfo: add xstats parameter to hide zero
Date: Fri, 7 Feb 2025 11:13:33 +0800
Message-ID: <20250207031333.1782995-1-huangdengdui@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250124100032.3497253-1-huangdengdui@huawei.com>
References: <20250124100032.3497253-1-huangdengdui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemo500011.china.huawei.com (7.202.195.194)
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

The number of xstats may be large, after the hide zero parameter to
hide zero only non-zero values can be displayed.

So display xstats with hide zero:
    dpdk-proc-info --proc-type=secondary -- --xstats
and without hide zero:
    dpdk-proc-info --proc-type=secondary -- --xstats=hide_zero

Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/proc-info/main.c           | 20 ++++++++++++++------
 doc/guides/tools/proc_info.rst |  7 ++++---
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/app/proc-info/main.c b/app/proc-info/main.c
index e1272164b1..be67386658 100644
--- a/app/proc-info/main.c
+++ b/app/proc-info/main.c
@@ -61,6 +61,7 @@ static unsigned long enabled_port_mask;
 static uint32_t enable_stats;
 /* Enable xstats. */
 static uint32_t enable_xstats;
+static uint32_t enable_xstats_hide_zero;
 /* Enable collectd format */
 static uint32_t enable_collectd_format;
 /* FD to send collectd format messages to STDOUT */
@@ -162,8 +163,8 @@ proc_info_usage(const char *prgname)
 		"  -m to display DPDK memory zones, segments and TAILQ information\n"
 		"  -p PORTMASK: hexadecimal bitmask of ports to retrieve stats for\n"
 		"  --stats: to display port statistics, enabled by default\n"
-		"  --xstats: to display extended port statistics, disabled by "
-			"default\n"
+		"  --xstats[=hide_zero]: to display extended port statistics, disabled by default, "
+			"support hide zero.\n"
 #ifdef RTE_LIB_METRICS
 		"  --metrics: to display derived metrics of the ports, disabled by "
 			"default\n"
@@ -425,7 +426,7 @@ proc_info_parse_args(int argc, char **argv)
 	static struct option long_option[] = {
 		{"stats", 0, NULL, 0},
 		{"stats-reset", 0, NULL, 0},
-		{"xstats", 0, NULL, 0},
+		{"xstats", optional_argument, NULL, 0},
 #ifdef RTE_LIB_METRICS
 		{"metrics", 0, NULL, 0},
 #endif
@@ -476,12 +477,17 @@ proc_info_parse_args(int argc, char **argv)
 		case 0:
 			/* Print stats */
 			if (!strncmp(long_option[option_index].name, "stats",
-					MAX_LONG_OPT_SZ))
+					MAX_LONG_OPT_SZ)) {
 				enable_stats = 1;
 			/* Print xstats */
-			else if (!strncmp(long_option[option_index].name, "xstats",
-					MAX_LONG_OPT_SZ))
+			} else if (!strncmp(long_option[option_index].name, "xstats",
+					MAX_LONG_OPT_SZ)) {
 				enable_xstats = 1;
+				if (optarg != NULL && !strncmp(optarg, "hide_zero",
+				    MAX_LONG_OPT_SZ))
+					enable_xstats_hide_zero = 1;
+
+			}
 #ifdef RTE_LIB_METRICS
 			else if (!strncmp(long_option[option_index].name,
 					"metrics",
@@ -850,6 +856,8 @@ nic_xstats_display(uint16_t port_id)
 	}
 
 	for (i = 0; i < len; i++) {
+		if (enable_xstats_hide_zero && values[i] == 0)
+			continue;
 		if (enable_collectd_format) {
 			char counter_type[MAX_STRING_LEN];
 			char buf[MAX_STRING_LEN];
diff --git a/doc/guides/tools/proc_info.rst b/doc/guides/tools/proc_info.rst
index bb483afbce..e623d71785 100644
--- a/doc/guides/tools/proc_info.rst
+++ b/doc/guides/tools/proc_info.rst
@@ -17,7 +17,7 @@ The application has a number of command line options:
 
 .. code-block:: console
 
-   ./<build_dir>/app/dpdk-proc-info -- -m | [-p PORTMASK] [--stats | --xstats |
+   ./<build_dir>/app/dpdk-proc-info -- -m | [-p PORTMASK] [--stats | --xstats[=hide_zero] |
    --stats-reset | --xstats-reset] [ --show-port | --show-tm | --show-crypto |
    --show-ring[=name] | --show-mempool[=name] | --iter-mempool=name |
    --show-port-private | --version | --firmware-version | --show-rss-reta |
@@ -34,9 +34,10 @@ Parameters
 The stats parameter controls the printing of generic port statistics. If no
 port mask is specified stats are printed for all DPDK ports.
 
-**--xstats**
+**--xstats[=hide_zero]**
 The xstats parameter controls the printing of extended port statistics. If no
-port mask is specified xstats are printed for all DPDK ports.
+port mask is specified xstats are printed for all DPDK ports. Specifying the
+hide_zero value to display xstats with hide zero.
 
 **--stats-reset**
 The stats-reset parameter controls the resetting of generic port statistics. If
-- 
2.33.0

