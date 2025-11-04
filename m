Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F55CCFA03
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 02:49:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04BE7402E7;
	Tue,  4 Nov 2025 03:49:40 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id DCEAD402D4
 for <dev@dpdk.org>; Tue,  4 Nov 2025 03:49:37 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 644D61CE0;
 Mon,  3 Nov 2025 18:49:29 -0800 (PST)
Received: from ampere-altra-2-2.usa.arm.com (unknown [10.118.91.160])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2CD8D3F694;
 Mon,  3 Nov 2025 18:49:37 -0800 (PST)
From: Doug Foster <doug.foster@arm.com>
To: dev@dpdk.org,
	Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Cc: nd@arm.com, Doug Foster <doug.foster@arm.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [PATCH 1/2] app/test-pipeline: cleanup and add help
Date: Tue,  4 Nov 2025 02:49:18 +0000
Message-Id: <20251104024919.3329372-2-doug.foster@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104024919.3329372-1-doug.foster@arm.com>
References: <20251104024919.3329372-1-doug.foster@arm.com>
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

Add a help option and usage statement that is printed when the help option
is used or when incorrect options are provided. Remove redundant calls to
app_print_usage() within app_parse_args(), since main() already calls
app_print_usage() on parse failure, avoiding multiple messages. Use an
enum for the long-options return value to improve readability.

Signed-off-by: Doug Foster <doug.foster@arm.com>
Reviewed-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
---
 app/test-pipeline/config.c | 89 +++++++++++++++++++++++---------------
 app/test-pipeline/main.h   |  5 ++-
 2 files changed, 57 insertions(+), 37 deletions(-)

diff --git a/app/test-pipeline/config.c b/app/test-pipeline/config.c
index daf838948b..0d280cf898 100644
--- a/app/test-pipeline/config.c
+++ b/app/test-pipeline/config.c
@@ -41,7 +41,27 @@
 
 #include "main.h"
 
-static const char usage[] = "\n";
+static const char usage[] =
+"Usage:\n"
+"  dpdk-test-pipeline [EAL options] -- -p PORTMASK --TABLE_TYPE\n"
+"\n"
+"EAL requirements:\n"
+"  -l/--lcores must specify exactly 3 lcores (RX core, pipeline core , TX core)\n"
+"\n"
+"Application options:\n"
+"  -p PORTMASK           Hex bitmask of ports; must include 2 or 4 ports\n"
+"  --none | --stub |\n"
+"  --hash-8-ext  | --hash-8-lru  |\n"
+"  --hash-16-ext | --hash-16-lru |\n"
+"  --hash-32-ext | --hash-32-lru |\n"
+"  --hash-spec-8-ext  | --hash-spec-8-lru  |\n"
+"  --hash-spec-16-ext | --hash-spec-16-lru |\n"
+"  --hash-spec-32-ext | --hash-spec-32-lru |\n"
+"  --acl | --lpm | --lpm-ipv6 |\n"
+"  --hash-cuckoo-8  | --hash-cuckoo-16  | --hash-cuckoo-32  |\n"
+"  --hash-cuckoo-48 | --hash-cuckoo-64  | --hash-cuckoo-80  |\n"
+"  --hash-cuckoo-96 | --hash-cuckoo-112 | --hash-cuckoo-128\n"
+"  -h/--help    print help statement and exit\n";
 
 void
 app_print_usage(void)
@@ -124,32 +144,33 @@ app_parse_args(int argc, char **argv)
 	int option_index;
 	char *prgname = argv[0];
 	static struct option lgopts[] = {
-		{"none", 0, 0, 0},
-		{"stub", 0, 0, 0},
-		{"hash-8-ext", 0, 0, 0},
-		{"hash-8-lru", 0, 0, 0},
-		{"hash-16-ext", 0, 0, 0},
-		{"hash-16-lru", 0, 0, 0},
-		{"hash-32-ext", 0, 0, 0},
-		{"hash-32-lru", 0, 0, 0},
-		{"hash-spec-8-ext", 0, 0, 0},
-		{"hash-spec-8-lru", 0, 0, 0},
-		{"hash-spec-16-ext", 0, 0, 0},
-		{"hash-spec-16-lru", 0, 0, 0},
-		{"hash-spec-32-ext", 0, 0, 0},
-		{"hash-spec-32-lru", 0, 0, 0},
-		{"acl", 0, 0, 0},
-		{"lpm", 0, 0, 0},
-		{"lpm-ipv6", 0, 0, 0},
-		{"hash-cuckoo-8", 0, 0, 0},
-		{"hash-cuckoo-16", 0, 0, 0},
-		{"hash-cuckoo-32", 0, 0, 0},
-		{"hash-cuckoo-48", 0, 0, 0},
-		{"hash-cuckoo-64", 0, 0, 0},
-		{"hash-cuckoo-80", 0, 0, 0},
-		{"hash-cuckoo-96", 0, 0, 0},
-		{"hash-cuckoo-112", 0, 0, 0},
-		{"hash-cuckoo-128", 0, 0, 0},
+		{"none", 0, 0, e_APP_PIPELINES},
+		{"stub", 0, 0, e_APP_PIPELINES},
+		{"hash-8-ext", 0, 0, e_APP_PIPELINES},
+		{"hash-8-lru", 0, 0, e_APP_PIPELINES},
+		{"hash-16-ext", 0, 0, e_APP_PIPELINES},
+		{"hash-16-lru", 0, 0, e_APP_PIPELINES},
+		{"hash-32-ext", 0, 0, e_APP_PIPELINES},
+		{"hash-32-lru", 0, 0, e_APP_PIPELINES},
+		{"hash-spec-8-ext", 0, 0, e_APP_PIPELINES},
+		{"hash-spec-8-lru", 0, 0, e_APP_PIPELINES},
+		{"hash-spec-16-ext", 0, 0, e_APP_PIPELINES},
+		{"hash-spec-16-lru", 0, 0, e_APP_PIPELINES},
+		{"hash-spec-32-ext", 0, 0, e_APP_PIPELINES},
+		{"hash-spec-32-lru", 0, 0, e_APP_PIPELINES},
+		{"acl", 0, 0, e_APP_PIPELINES},
+		{"lpm", 0, 0, e_APP_PIPELINES},
+		{"lpm-ipv6", 0, 0, e_APP_PIPELINES},
+		{"hash-cuckoo-8", 0, 0, e_APP_PIPELINES},
+		{"hash-cuckoo-16", 0, 0, e_APP_PIPELINES},
+		{"hash-cuckoo-32", 0, 0, e_APP_PIPELINES},
+		{"hash-cuckoo-48", 0, 0, e_APP_PIPELINES},
+		{"hash-cuckoo-64", 0, 0, e_APP_PIPELINES},
+		{"hash-cuckoo-80", 0, 0, e_APP_PIPELINES},
+		{"hash-cuckoo-96", 0, 0, e_APP_PIPELINES},
+		{"hash-cuckoo-112", 0, 0, e_APP_PIPELINES},
+		{"hash-cuckoo-128", 0, 0, e_APP_PIPELINES},
+		{"help", 0, 0, e_APP_HELP},
 		{NULL, 0, 0, 0}
 	};
 	uint32_t lcores[3], n_lcores, lcore_id, pipeline_type_provided;
@@ -162,7 +183,6 @@ app_parse_args(int argc, char **argv)
 
 		if (n_lcores >= 3) {
 			RTE_LOG(ERR, USER1, "Number of cores must be 3\n");
-			app_print_usage();
 			return -1;
 		}
 
@@ -172,7 +192,6 @@ app_parse_args(int argc, char **argv)
 
 	if (n_lcores != 3) {
 		RTE_LOG(ERR, USER1, "Number of cores must be 3\n");
-		app_print_usage();
 		return -1;
 	}
 
@@ -186,17 +205,16 @@ app_parse_args(int argc, char **argv)
 	app.pipeline_type = e_APP_PIPELINE_HASH_KEY16_LRU;
 	pipeline_type_provided = 0;
 
-	while ((opt = getopt_long(argc, argvopt, "p:",
+	while ((opt = getopt_long(argc, argvopt, "p:h",
 			lgopts, &option_index)) != EOF) {
 		switch (opt) {
 		case 'p':
-			if (app_parse_port_mask(optarg) < 0) {
-				app_print_usage();
+			if (app_parse_port_mask(optarg) < 0)
 				return -1;
-			}
+
 			break;
 
-		case 0: /* long options */
+		case e_APP_PIPELINES: /* long options */
 			if (!pipeline_type_provided) {
 				uint32_t i;
 
@@ -213,9 +231,10 @@ app_parse_args(int argc, char **argv)
 				break;
 			}
 
-			app_print_usage();
 			return -1;
 
+		case e_APP_HELP:
+		case 'h':
 		default:
 			return -1;
 		}
diff --git a/app/test-pipeline/main.h b/app/test-pipeline/main.h
index ee9c58ac4c..1f93dc3964 100644
--- a/app/test-pipeline/main.h
+++ b/app/test-pipeline/main.h
@@ -67,7 +67,7 @@ void app_print_usage(void);
 void app_init(void);
 int app_lcore_main_loop(void *arg);
 
-/* Pipeline */
+/* Pipeline and help*/
 enum {
 	e_APP_PIPELINE_NONE = 0,
 	e_APP_PIPELINE_STUB,
@@ -99,7 +99,8 @@ enum {
 	e_APP_PIPELINE_HASH_CUCKOO_KEY96,
 	e_APP_PIPELINE_HASH_CUCKOO_KEY112,
 	e_APP_PIPELINE_HASH_CUCKOO_KEY128,
-	e_APP_PIPELINES
+	e_APP_PIPELINES,
+	e_APP_HELP
 };
 
 void app_main_loop_rx(void);
-- 
2.34.1

