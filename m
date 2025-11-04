Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F955CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 02:49:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2F524042E;
	Tue,  4 Nov 2025 03:49:40 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 2C90B402E7
 for <dev@dpdk.org>; Tue,  4 Nov 2025 03:49:39 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B92FC1C2B;
 Mon,  3 Nov 2025 18:49:30 -0800 (PST)
Received: from ampere-altra-2-2.usa.arm.com (unknown [10.118.91.160])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 804023F694;
 Mon,  3 Nov 2025 18:49:38 -0800 (PST)
From: Doug Foster <doug.foster@arm.com>
To: dev@dpdk.org,
	Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Cc: nd@arm.com, Doug Foster <doug.foster@arm.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [PATCH 2/2] app/test-pipeline: add ring size options
Date: Tue,  4 Nov 2025 02:49:19 +0000
Message-Id: <20251104024919.3329372-3-doug.foster@arm.com>
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

Add command-line options to configure the size of the RX and TX rings.
The ring sizes should provide enough capacity to accommodate the number
of new entries that accumulate during the time it takes for existing
entries to be dequeued from the rings. This depends on CPU processing
rate, which varies across platforms, so configurable options are
provided. Use of these options is optional, and the default size
remains 128 for both the TX and RX rings. When setting the size, the
value must be a power of two, as required by the ring library.

Signed-off-by: Doug Foster <doug.foster@arm.com>
Reviewed-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
---
 app/test-pipeline/config.c                 | 48 ++++++++++++++++++++--
 app/test-pipeline/init.c                   |  4 --
 app/test-pipeline/main.h                   |  8 +++-
 doc/guides/sample_app_ug/test_pipeline.rst | 12 +++++-
 4 files changed, 62 insertions(+), 10 deletions(-)

diff --git a/app/test-pipeline/config.c b/app/test-pipeline/config.c
index 0d280cf898..ef0438c06c 100644
--- a/app/test-pipeline/config.c
+++ b/app/test-pipeline/config.c
@@ -43,7 +43,7 @@
 
 static const char usage[] =
 "Usage:\n"
-"  dpdk-test-pipeline [EAL options] -- -p PORTMASK --TABLE_TYPE\n"
+"  dpdk-test-pipeline [EAL options] -- -p PORTMASK --PIPELINE_ARGS\n"
 "\n"
 "EAL requirements:\n"
 "  -l/--lcores must specify exactly 3 lcores (RX core, pipeline core , TX core)\n"
@@ -61,7 +61,10 @@ static const char usage[] =
 "  --hash-cuckoo-8  | --hash-cuckoo-16  | --hash-cuckoo-32  |\n"
 "  --hash-cuckoo-48 | --hash-cuckoo-64  | --hash-cuckoo-80  |\n"
 "  --hash-cuckoo-96 | --hash-cuckoo-112 | --hash-cuckoo-128\n"
-"  -h/--help    print help statement and exit\n";
+"  -h/--help    print help statement and exit\n"
+"  --rx-ring-size=N    Optional, size of RX ring (power-of-two)\n"
+"  --tx-ring-size=N    Optional, size of TX ring (power-of-two)\n";
+
 
 void
 app_print_usage(void)
@@ -104,6 +107,25 @@ app_parse_port_mask(const char *arg)
 	return 0;
 }
 
+static int
+app_parse_ring_size(const char *ring_size_arg, uint32_t *size)
+{
+	char *end = NULL;
+	unsigned long value;
+
+	value = strtoul(ring_size_arg, &end, 10);
+
+	/* Check for conversion of invalid string */
+	if (!(*ring_size_arg != '\0' && *end == '\0'))
+		return -1;
+
+	if (!rte_is_power_of_2(value) || value > UINT32_MAX)
+		return -1;
+
+	*size = value;
+	return 0;
+}
+
 struct {
 	const char *name;
 	uint32_t value;
@@ -142,6 +164,7 @@ app_parse_args(int argc, char **argv)
 	int opt, ret;
 	char **argvopt;
 	int option_index;
+	uint32_t rx_ring_size, tx_ring_size;
 	char *prgname = argv[0];
 	static struct option lgopts[] = {
 		{"none", 0, 0, e_APP_PIPELINES},
@@ -171,6 +194,8 @@ app_parse_args(int argc, char **argv)
 		{"hash-cuckoo-112", 0, 0, e_APP_PIPELINES},
 		{"hash-cuckoo-128", 0, 0, e_APP_PIPELINES},
 		{"help", 0, 0, e_APP_HELP},
+		{"rx-ring-size", 1, 0, e_APP_RX_RING_SIZE},
+		{"tx-ring-size", 1, 0, e_APP_TX_RING_SIZE},
 		{NULL, 0, 0, 0}
 	};
 	uint32_t lcores[3], n_lcores, lcore_id, pipeline_type_provided;
@@ -205,6 +230,9 @@ app_parse_args(int argc, char **argv)
 	app.pipeline_type = e_APP_PIPELINE_HASH_KEY16_LRU;
 	pipeline_type_provided = 0;
 
+	app.ring_rx_size = APP_RING_SIZE_DEFAULT;
+	app.ring_tx_size = APP_RING_SIZE_DEFAULT;
+
 	while ((opt = getopt_long(argc, argvopt, "p:h",
 			lgopts, &option_index)) != EOF) {
 		switch (opt) {
@@ -214,7 +242,7 @@ app_parse_args(int argc, char **argv)
 
 			break;
 
-		case e_APP_PIPELINES: /* long options */
+		case e_APP_PIPELINES:
 			if (!pipeline_type_provided) {
 				uint32_t i;
 
@@ -233,6 +261,20 @@ app_parse_args(int argc, char **argv)
 
 			return -1;
 
+		case e_APP_RX_RING_SIZE:
+			if (app_parse_ring_size(optarg, &rx_ring_size) < 0)
+				return -1;
+
+			app.ring_rx_size = rx_ring_size;
+			break;
+
+		case e_APP_TX_RING_SIZE:
+			if (app_parse_ring_size(optarg, &tx_ring_size) < 0)
+				return -1;
+
+			app.ring_tx_size = tx_ring_size;
+			break;
+
 		case e_APP_HELP:
 		case 'h':
 		default:
diff --git a/app/test-pipeline/init.c b/app/test-pipeline/init.c
index 558f0e428d..f596337751 100644
--- a/app/test-pipeline/init.c
+++ b/app/test-pipeline/init.c
@@ -48,10 +48,6 @@ struct app_params app = {
 	.port_rx_ring_size = 128,
 	.port_tx_ring_size = 512,
 
-	/* Rings */
-	.ring_rx_size = 128,
-	.ring_tx_size = 128,
-
 	/* Buffer pool */
 	.pool_buffer_size = 2048 + RTE_PKTMBUF_HEADROOM,
 	.pool_size = 32 * 1024,
diff --git a/app/test-pipeline/main.h b/app/test-pipeline/main.h
index 1f93dc3964..6f9ef6e2e2 100644
--- a/app/test-pipeline/main.h
+++ b/app/test-pipeline/main.h
@@ -18,6 +18,8 @@ struct app_mbuf_array {
 #define APP_MAX_PORTS 4
 #endif
 
+#define APP_RING_SIZE_DEFAULT 128
+
 struct __rte_cache_aligned app_params {
 	/* CPU cores */
 	uint32_t core_rx;
@@ -67,7 +69,7 @@ void app_print_usage(void);
 void app_init(void);
 int app_lcore_main_loop(void *arg);
 
-/* Pipeline and help*/
+/* Pipelines, help, ring size */
 enum {
 	e_APP_PIPELINE_NONE = 0,
 	e_APP_PIPELINE_STUB,
@@ -100,7 +102,9 @@ enum {
 	e_APP_PIPELINE_HASH_CUCKOO_KEY112,
 	e_APP_PIPELINE_HASH_CUCKOO_KEY128,
 	e_APP_PIPELINES,
-	e_APP_HELP
+	e_APP_HELP,
+	e_APP_RX_RING_SIZE,
+	e_APP_TX_RING_SIZE
 };
 
 void app_main_loop_rx(void);
diff --git a/doc/guides/sample_app_ug/test_pipeline.rst b/doc/guides/sample_app_ug/test_pipeline.rst
index 818be93cd6..46a5ecc780 100644
--- a/doc/guides/sample_app_ug/test_pipeline.rst
+++ b/doc/guides/sample_app_ug/test_pipeline.rst
@@ -45,13 +45,23 @@ The application execution command line is:
 
 .. code-block:: console
 
-    ./dpdk-test-pipeline [EAL options] -- -p PORTMASK --TABLE_TYPE
+    ./dpdk-test-pipeline [EAL options] -- -p PORTMASK --PIPELINE_ARGS
 
 The ``-l/--lcores`` EAL CPU corelist option has to contain exactly 3 CPU cores.
 The first CPU core in the core mask is assigned for core A, the second for core B and the third for core C.
 
 The PORTMASK parameter must contain 2 or 4 ports.
 
+PIPELINE_ARGS represents TABLE_TYPE and pipeline options, such as ``--rx-ring-size`` and ``--tx-ring-size``, described below.
+The ``--rx-ring-size`` and ``--tx-ring-size`` options control the sizes of the rings used between cores.
+Both values **must be powers of two**. If not used, the default size is 128.
+
+* ``--rx-ring-size=N``
+  Optional, sets size of the RX ring between **Core A (RX)** and **Core B (Pipeline)**.
+
+* ``--tx-ring-size=N``
+  Optional, sets size of the TX ring between **Core B (Pipeline)** and **Core C (TX)**.
+
 Table Types and Behavior
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.34.1

