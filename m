Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5776BC3DA7A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 18:39:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 33A5C406BB;
	Wed, 14 Oct 2026 20:39:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id D43C94065A
 for <dev@dpdk.org>; Wed, 14 Oct 2026 20:39:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792003177; x=1823539177;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pFKbL93Slpl4473QZ3xtIBkiPr32gv2pvVPEzBvkI5s=;
 b=J4T6UtQr9/X7nUOdan7W0hoq97T+s6c9mV5CoWWii9Vy6ZoQTBBmCC8H
 rOinVpwtRCoT+5kdsUdb794PdZr6SN6KW9VQGO/VQ7TOQ1m1H0/ieZbMv
 JZKebwPCRXphL48GqFaKvbha+9AgpBQ9nAQCGtcl4ajGYU8Esd3225GMJ
 Fq9yHk4j1qG0clWJJh3iLkDjwkKcqrAWZBpB7u3v/4+rsFFsVs09jPgab
 qYClGu5xShQFUdzTpK43RLpZ2R05QV3HxPuIM+qHeQDlV0j99rjj4XYYM
 CvkxEMDUQ1WbpNOLnwQsjHliOphrf/iea0bdtLIo7G9wSQrymFyfMajzY Q==;
X-CSE-ConnectionGUID: k799jBvuToWE+CRiOcOAdQ==
X-CSE-MsgGUID: FjxAsiomQJedV/34x/E0MA==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="753365"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="753365"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 11:39:31 -0700
X-CSE-ConnectionGUID: 4KwHTiZQQ9a/tBLoP7pi0Q==
X-CSE-MsgGUID: 4I1icy3VQuG2hvvWRyUx+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1419870"
Received: from silpixa00401176.ir.intel.com ([10.20.224.212])
 by orviesa009.jf.intel.com with ESMTP; 14 Oct 2026 11:39:30 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com, mb@smartsharesystems.com, maxime@leroys.fr,
 konstantin.ananyev@huawei.com
Subject: [RFC PATCH v2 4/7] fib: add DIR8-16-8 algorithm
Date: Wed, 14 Oct 2026 18:39:18 +0000
Message-ID: <20261014183921.495158-5-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014183921.495158-1-vladimir.medvedkin@intel.com>
References: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
 <20261014183921.495158-1-vladimir.medvedkin@intel.com>
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

Add an IPv4 dataplane algorithm splitting the address in three strides
of 8, 16 and 8 bits: a 256 entry root table resolves the first stride,
then 65536 entry groups (tbl16) and 256 entry groups (tbl8) allocated
from pools sized on FIB creation resolve the next ones. A lookup needs
one to three memory accesses.

Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 app/test-fib/main.c                    |  86 +++-
 app/test/test_fib.c                    | 101 +++-
 app/test/test_fib_perf.c               |  65 ++-
 doc/guides/prog_guide/fib_lib.rst      |  26 ++
 doc/guides/rel_notes/release_26_11.rst |   5 +
 lib/fib/dir8_16_8.c                    | 614 +++++++++++++++++++++++++
 lib/fib/dir8_16_8.h                    | 143 ++++++
 lib/fib/dir8_16_8_avx512.c             | 142 ++++++
 lib/fib/dir8_16_8_avx512.h             |  16 +
 lib/fib/meson.build                    |   4 +-
 lib/fib/rte_fib.c                      |  24 +-
 lib/fib/rte_fib.h                      |  17 +-
 12 files changed, 1204 insertions(+), 39 deletions(-)
 create mode 100644 lib/fib/dir8_16_8.c
 create mode 100644 lib/fib/dir8_16_8.h
 create mode 100644 lib/fib/dir8_16_8_avx512.c
 create mode 100644 lib/fib/dir8_16_8_avx512.h

diff --git a/app/test-fib/main.c b/app/test-fib/main.c
index 0bc8dd2aa4..be1ba20277 100644
--- a/app/test-fib/main.c
+++ b/app/test-fib/main.c
@@ -39,6 +39,8 @@
 #define	DEF_LOOKUP_IPS_NUM	0x100000
 #define BURST_SZ		64
 #define DEFAULT_LPM_TBL8	100000U
+/* One second level (16 bit stride) group per /8 covers the whole space. */
+#define DIR8_16_8_MAX_TBL16	256U
 
 #define CMP_FLAG		(1 << 0)
 #define CMP_ALL_FLAG		(1 << 1)
@@ -46,9 +48,12 @@
 #define FIB_RIB_TYPE		(1 << 3)
 #define FIB_V4_DIR_TYPE		(1 << 4)
 #define FIB_V6_TRIE_TYPE	(1 << 4)
-#define FIB_TYPE_MASK		(FIB_RIB_TYPE|FIB_V4_DIR_TYPE|FIB_V6_TRIE_TYPE)
+#define FIB_V4_DIR_8_16_8_TYPE	(1 << 5)
+#define FIB_TYPE_MASK		(FIB_RIB_TYPE|FIB_V4_DIR_TYPE|FIB_V6_TRIE_TYPE| \
+				FIB_V4_DIR_8_16_8_TYPE)
 #define SHUFFLE_FLAG		(1 << 7)
 #define DRY_RUN_FLAG		(1 << 8)
+#define ENT_SZ_FLAG		(1 << 9)
 
 static char *distrib_string;
 static char line[LINE_MAX];
@@ -147,6 +152,8 @@ get_fib_type(void)
 	} else {
 		if ((config.flags & FIB_TYPE_MASK) == FIB_V4_DIR_TYPE)
 			return RTE_FIB_DIR24_8;
+		if ((config.flags & FIB_TYPE_MASK) == FIB_V4_DIR_8_16_8_TYPE)
+			return RTE_FIB_DIR8_16_8;
 		if ((config.flags & FIB_TYPE_MASK) == FIB_RIB_TYPE)
 			return RTE_FIB_DUMMY;
 	}
@@ -619,18 +626,20 @@ print_usage(void)
 		"[-b <fib algorithm>]\n\tavailable options for ipv4\n"
 		"\t\trib - RIB based FIB\n"
 		"\t\tdir - DIR24_8 based FIB\n"
+		"\t\tdir8_16_8 - DIR8_16_8 based FIB (8 byte next hop)\n"
 		"\tavailable options for ipv6:\n"
 		"\t\trib - RIB based FIB\n"
 		"\t\ttrie - TRIE based FIB\n"
 		"defaults are: dir for ipv4 and trie for ipv6\n"
 		"[-e <entry size (valid only for dir and trie fib types): "
 		"1/2/4/8 (default 4)>]\n"
-		"[-g <number of tbl8's for dir24_8 or trie FIBs>]\n"
+		"[-g <number of tbl8's for dir24_8, dir8_16_8 or trie FIBs>]\n"
 		"[-w <path to the file to dump routing table>]\n"
 		"[-u <path to the file to dump ip's for lookup>]\n"
 		"[-v <type of lookup function:"
 		"\ts1, s2, s3 (3 types of scalar), v (vector) -"
 		" for DIR24_8 based FIB\n"
+		"\ts, v - for DIR8_16_8 based FIB\n"
 		"\ts, v - for TRIE based ipv6 FIB>]\n",
 		config.prgname);
 }
@@ -665,6 +674,22 @@ check_config(void)
 		printf("-e 1 is valid only for ipv4\n");
 		return -1;
 	}
+
+	if ((config.flags & FIB_V4_DIR_8_16_8_TYPE) &&
+			(config.flags & IPV6_FLAG)) {
+		printf("dir8_16_8 fib type is only valid for ipv4\n");
+		return -1;
+	}
+	/* The dir8_16_8 fib type only supports 8 byte next hops. */
+	if ((config.flags & FIB_TYPE_MASK) == FIB_V4_DIR_8_16_8_TYPE) {
+		if ((config.flags & ENT_SZ_FLAG) && config.ent_sz != 8) {
+			printf("-e %u is not valid for the dir8_16_8 fib type, "
+				"only 8 byte next hops are supported\n",
+				config.ent_sz);
+			return -1;
+		}
+		config.ent_sz = 8;
+	}
 	return 0;
 }
 
@@ -744,6 +769,9 @@ parse_opts(int argc, char **argv)
 			} else if (strcmp(optarg, "dir") == 0) {
 				config.flags &= ~FIB_TYPE_MASK;
 				config.flags |= FIB_V4_DIR_TYPE;
+			} else if (strcmp(optarg, "dir8_16_8") == 0) {
+				config.flags &= ~FIB_TYPE_MASK;
+				config.flags |= FIB_V4_DIR_8_16_8_TYPE;
 			} else if (strcmp(optarg, "trie") == 0) {
 				config.flags &= ~FIB_TYPE_MASK;
 				config.flags |= FIB_V6_TRIE_TYPE;
@@ -757,6 +785,7 @@ parse_opts(int argc, char **argv)
 				print_usage();
 				rte_exit(-EINVAL, "Invalid option -e\n");
 			}
+			config.flags |= ENT_SZ_FLAG;
 			break;
 		case 'g':
 			errno = 0;
@@ -817,6 +846,35 @@ print_depth_err(void)
 		"-d 0:0 option or remove /0 prefix from routes file\n");
 }
 
+static int
+select_lookup_fn_v4(struct rte_fib *fib, enum rte_fib_type type)
+{
+	enum rte_fib_lookup_type lookup_type;
+
+	if (type == RTE_FIB_DIR8_16_8) {
+		if (config.lookup_fn == 1)
+			lookup_type = RTE_FIB_LOOKUP_DIR8_16_8_SCALAR;
+		else if (config.lookup_fn == 2)
+			lookup_type = RTE_FIB_LOOKUP_DIR8_16_8_VECTOR_AVX512;
+		else
+			return -EINVAL;
+	} else if (type == RTE_FIB_DIR24_8) {
+		if (config.lookup_fn == 1)
+			lookup_type = RTE_FIB_LOOKUP_DIR24_8_SCALAR_MACRO;
+		else if (config.lookup_fn == 2)
+			lookup_type = RTE_FIB_LOOKUP_DIR24_8_VECTOR_AVX512;
+		else if (config.lookup_fn == 3)
+			lookup_type = RTE_FIB_LOOKUP_DIR24_8_SCALAR_INLINE;
+		else if (config.lookup_fn == 4)
+			lookup_type = RTE_FIB_LOOKUP_DIR24_8_SCALAR_UNI;
+		else
+			return -EINVAL;
+	} else {
+		return -EINVAL;
+	}
+	return rte_fib_select_lookup(fib, lookup_type);
+}
+
 static int
 run_v4(void)
 {
@@ -853,6 +911,15 @@ run_v4(void)
 		conf.dir24_8.nh_sz = rte_ctz32(config.ent_sz);
 		conf.dir24_8.num_tbl8 = RTE_MIN(config.tbl8,
 			get_max_nh(conf.dir24_8.nh_sz));
+	} else if (conf.type == RTE_FIB_DIR8_16_8) {
+		/*
+		 * DIR8_16_8 only supports 8 byte next hops. The first stride
+		 * (8 bits) needs at most one second level group per /8, so 256
+		 * groups always suffice. The third level (last 8 bits) groups
+		 * are sized like the DIR24_8 tbl8s.
+		 */
+		conf.dir8_16_8.num_tbl16 = DIR8_16_8_MAX_TBL16;
+		conf.dir8_16_8.num_tbl8 = config.tbl8;
 	}
 
 	fib = rte_fib_create("test", -1, &conf);
@@ -862,20 +929,7 @@ run_v4(void)
 	}
 
 	if (config.lookup_fn != 0) {
-		if (config.lookup_fn == 1)
-			ret = rte_fib_select_lookup(fib,
-				RTE_FIB_LOOKUP_DIR24_8_SCALAR_MACRO);
-		else if (config.lookup_fn == 2)
-			ret = rte_fib_select_lookup(fib,
-				RTE_FIB_LOOKUP_DIR24_8_VECTOR_AVX512);
-		else if (config.lookup_fn == 3)
-			ret = rte_fib_select_lookup(fib,
-				RTE_FIB_LOOKUP_DIR24_8_SCALAR_INLINE);
-		else if (config.lookup_fn == 4)
-			ret = rte_fib_select_lookup(fib,
-				RTE_FIB_LOOKUP_DIR24_8_SCALAR_UNI);
-		else
-			ret = -EINVAL;
+		ret = select_lookup_fn_v4(fib, conf.type);
 		if (ret != 0) {
 			printf("Can not init lookup function\n");
 			return ret;
diff --git a/app/test/test_fib.c b/app/test/test_fib.c
index bd73399d56..bb8021c818 100644
--- a/app/test/test_fib.c
+++ b/app/test/test_fib.c
@@ -6,9 +6,12 @@
 #include <stdio.h>
 #include <stdint.h>
 #include <stdlib.h>
+#include <string.h>
+#include <inttypes.h>
 
 #include <rte_ip.h>
 #include <rte_log.h>
+#include <rte_byteorder.h>
 #include <rte_fib.h>
 #include <rte_malloc.h>
 
@@ -65,7 +68,7 @@ test_create_invalid(void)
 		"Call succeeded with invalid parameters\n");
 	config.max_routes = MAX_ROUTES;
 
-	config.type = RTE_FIB_DIR24_8 + 1;
+	config.type = RTE_FIB_DIR8_16_8 + 1;
 	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib == NULL,
 		"Call succeeded with invalid parameters\n");
@@ -84,6 +87,19 @@ test_create_invalid(void)
 	RTE_TEST_ASSERT(fib == NULL,
 		"Call succeeded with invalid parameters\n");
 
+	config.type = RTE_FIB_DIR8_16_8;
+	config.dir8_16_8.num_tbl16 = MAX_TBL8;
+	config.dir8_16_8.num_tbl8 = 0;
+	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib == NULL,
+		"Call succeeded with invalid parameters\n");
+
+	config.dir8_16_8.num_tbl16 = 0;
+	config.dir8_16_8.num_tbl8 = MAX_TBL8;
+	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib == NULL,
+		"Call succeeded with invalid parameters\n");
+
 	return TEST_SUCCESS;
 }
 
@@ -376,6 +392,23 @@ test_lookup(void)
 		"Check_fib fails for DIR24_8_8B type\n");
 	rte_fib_free(fib);
 
+	config.type = RTE_FIB_DIR8_16_8;
+	config.dir8_16_8.num_tbl16 = 16;
+	config.dir8_16_8.num_tbl8 = MAX_TBL8;
+	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
+	ret = check_fib(fib);
+	RTE_TEST_ASSERT(ret == TEST_SUCCESS,
+		"Check_fib fails for DIR8_16_8 type\n");
+	/* The vector lookup is only available with a 512 bit SIMD width. */
+	if (rte_fib_select_lookup(fib,
+			RTE_FIB_LOOKUP_DIR8_16_8_VECTOR_AVX512) == 0) {
+		ret = check_fib(fib);
+		RTE_TEST_ASSERT(ret == TEST_SUCCESS,
+			"Check_fib fails for DIR8_16_8 type, AVX512 lookup\n");
+	}
+	rte_fib_free(fib);
+
 	return TEST_SUCCESS;
 }
 
@@ -588,6 +621,71 @@ test_fib_rcu_sync_rw(void)
 	return status == 0 ? TEST_SUCCESS : TEST_FAILED;
 }
 
+#define TEST_NUM_TBL16	16
+#define TEST_NUM_TBL8	64
+#define DEF_NH		77
+
+/*
+ * Network order lookups with every lookup implementation of DIR8_16_8, with a
+ * burst of two vector groups and a leftover.
+ */
+static int32_t
+test_lookup_network_order(void)
+{
+	const enum rte_fib_lookup_type types[] = {
+		RTE_FIB_LOOKUP_DIR8_16_8_SCALAR,
+		RTE_FIB_LOOKUP_DIR8_16_8_VECTOR_AVX512,
+	};
+	const uint32_t probes[] = {
+		RTE_IPV4(10, 2, 3, 4),	/* /8 */
+		RTE_IPV4(10, 1, 1, 5),	/* /24 */
+		RTE_IPV4(10, 1, 1, 7),	/* /32 */
+		RTE_IPV4(8, 8, 8, 8),	/* miss */
+	};
+	const uint64_t probe_nhs[] = { 100, 300, 400, DEF_NH };
+	struct rte_fib_conf cfg = { 0 };
+	struct rte_fib *fib;
+	uint32_t ips[17];
+	uint64_t nhs[17];
+	unsigned int i, t;
+
+	cfg.type = RTE_FIB_DIR8_16_8;
+	cfg.max_routes = 100;
+	cfg.default_nh = DEF_NH;
+	cfg.flags = RTE_FIB_F_LOOKUP_NETWORK_ORDER;
+	cfg.dir8_16_8.num_tbl16 = TEST_NUM_TBL16;
+	cfg.dir8_16_8.num_tbl8 = TEST_NUM_TBL8;
+
+	fib = rte_fib_create("fib_be", SOCKET_ID_ANY, &cfg);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
+
+	RTE_TEST_ASSERT(rte_fib_add(fib, RTE_IPV4(10, 0, 0, 0), 8, 100) == 0,
+		"add /8\n");
+	RTE_TEST_ASSERT(rte_fib_add(fib, RTE_IPV4(10, 1, 1, 0), 24, 300) == 0,
+		"add /24\n");
+	RTE_TEST_ASSERT(rte_fib_add(fib, RTE_IPV4(10, 1, 1, 7), 32, 400) == 0,
+		"add /32\n");
+	for (i = 0; i < RTE_DIM(ips); i++)
+		ips[i] = rte_cpu_to_be_32(probes[i % RTE_DIM(probes)]);
+
+	for (t = 0; t < RTE_DIM(types); t++) {
+		/* The vector lookup needs a 512 bit SIMD width. */
+		if (rte_fib_select_lookup(fib, types[t]) != 0)
+			continue;
+
+		memset(nhs, 0, sizeof(nhs));
+		RTE_TEST_ASSERT(rte_fib_lookup_bulk(fib, ips, nhs,
+			RTE_DIM(ips)) == 0, "lookup failed\n");
+		for (i = 0; i < RTE_DIM(ips); i++)
+			RTE_TEST_ASSERT(nhs[i] == probe_nhs[i % RTE_DIM(probes)],
+				"lookup type %u: ip %u got %"PRIu64"\n",
+				types[t], i, nhs[i]);
+	}
+	rte_fib_free(fib);
+
+	return TEST_SUCCESS;
+}
+
 static struct unit_test_suite fib_fast_tests = {
 	.suite_name = "fib autotest",
 	.setup = NULL,
@@ -598,6 +696,7 @@ static struct unit_test_suite fib_fast_tests = {
 	TEST_CASE(test_add_del_invalid),
 	TEST_CASE(test_get_invalid),
 	TEST_CASE(test_lookup),
+	TEST_CASE(test_lookup_network_order),
 	TEST_CASE(test_invalid_rcu),
 	TEST_CASE(test_fib_rcu_sync_rw),
 	TEST_CASES_END()
diff --git a/app/test/test_fib_perf.c b/app/test/test_fib_perf.c
index 1b2ad04854..0967644316 100644
--- a/app/test/test_fib_perf.c
+++ b/app/test/test_fib_perf.c
@@ -7,6 +7,7 @@
 #include <stdint.h>
 #include <stdlib.h>
 #include <math.h>
+#include <inttypes.h>
 
 #include <rte_cycles.h>
 #include <rte_random.h>
@@ -317,31 +318,16 @@ print_route_distribution(const struct route_rule *table, uint32_t n)
 }
 
 static int
-test_fib_perf(void)
+measure_fib_perf(const char *name, struct rte_fib_conf *config)
 {
 	struct rte_fib *fib = NULL;
-	struct rte_fib_conf config = { 0 };
-
-	config.max_routes = 2000000;
-	config.rib_ext_sz = 0;
-	config.type = RTE_FIB_DIR24_8;
-	config.default_nh = 0;
-	config.dir24_8.nh_sz = RTE_FIB_DIR24_8_4B;
-	config.dir24_8.num_tbl8 = 65535;
 	uint64_t begin, total_time;
 	unsigned int i, j;
 	uint32_t next_hop_add = 0xAA;
 	int status = 0;
 	int64_t count = 0;
 
-	generate_large_route_rule_table();
-
-	printf("No. routes = %u\n", (unsigned int) NUM_ROUTE_ENTRIES);
-
-	print_route_distribution(large_route_table,
-		(uint32_t) NUM_ROUTE_ENTRIES);
-
-	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib_create(name, SOCKET_ID_ANY, config);
 	TEST_FIB_ASSERT(fib != NULL);
 
 	/* Measure add. */
@@ -407,4 +393,49 @@ test_fib_perf(void)
 	return 0;
 }
 
+static int
+test_fib_perf(void)
+{
+	struct rte_fib_conf config = { 0 };
+
+	config.max_routes = 2000000;
+	config.rib_ext_sz = 0;
+	config.type = RTE_FIB_DIR24_8;
+	config.default_nh = 0;
+	config.dir24_8.nh_sz = RTE_FIB_DIR24_8_4B;
+	config.dir24_8.num_tbl8 = 65535;
+
+	generate_large_route_rule_table();
+
+	printf("No. routes = %u\n", (unsigned int) NUM_ROUTE_ENTRIES);
+
+	print_route_distribution(large_route_table,
+		(uint32_t) NUM_ROUTE_ENTRIES);
+
+	return measure_fib_perf("fib_perf_dir24_8", &config);
+}
+
+static int
+test_fib_perf_dir8_16_8(void)
+{
+	struct rte_fib_conf config = { 0 };
+
+	config.max_routes = 2000000;
+	config.rib_ext_sz = 0;
+	config.type = RTE_FIB_DIR8_16_8;
+	config.default_nh = 0;
+	config.dir8_16_8.num_tbl16 = 256;
+	config.dir8_16_8.num_tbl8 = 1 << 16;
+
+	generate_large_route_rule_table();
+
+	printf("No. routes = %u\n", (unsigned int) NUM_ROUTE_ENTRIES);
+
+	print_route_distribution(large_route_table,
+		(uint32_t) NUM_ROUTE_ENTRIES);
+
+	return measure_fib_perf("fib_perf_dir8_16_8", &config);
+}
+
 REGISTER_PERF_TEST(fib_perf_autotest, test_fib_perf);
+REGISTER_PERF_TEST(fib_perf_dir8_16_8_autotest, test_fib_perf_dir8_16_8);
diff --git a/doc/guides/prog_guide/fib_lib.rst b/doc/guides/prog_guide/fib_lib.rst
index 41ab5764b6..c20759faaf 100644
--- a/doc/guides/prog_guide/fib_lib.rst
+++ b/doc/guides/prog_guide/fib_lib.rst
@@ -127,6 +127,32 @@ An entry in a tbl8 contains the following fields:
 * 1 bit indicating if the lookup should proceed inside the tbl8.
 
 
+DIR-8-16-8
+~~~~~~~~~~
+
+This algorithm is a three level variant of DIR-24-8: the IPv4 address is split
+in strides of 8, 16 and 8 bits. The first level is a 256 entry root table, the
+second level is made of 65536 entry groups (``tbl16``) and the third level of
+256 entry groups (``tbl8``), both allocated from pools sized on FIB creation.
+A lookup needs one to three memory accesses. Only 8 byte next hop IDs are
+supported.
+
+This algorithm will be used if the ``RTE_FIB_DIR8_16_8`` type is configured as the
+dataplane algorithm on FIB creation.
+
+The main FIB configuration struct stores the dataplane parameters inside ``dir8_16_8``
+within the ``rte_fib_conf`` and it consists of:
+
+* ``num_tbl16``: The number of second level groups, at most one per /8 is ever
+  needed.
+
+* ``num_tbl8``: The number of third level groups.
+
+Compared to DIR-24-8, the root table is small (2 KB), which makes it suitable
+when many tables must be kept, at the price of an extra memory access for
+prefixes longer than 8 bits.
+
+
 Use cases
 ---------
 
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 03b4feae0f..04781a2761 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -206,6 +206,11 @@ New Features
   when using ``RTE_UNCORE_PM_ENV_AUTO_DETECT``,
   instead of defaulting only to the Intel uncore driver.
 
+* **Added new FIB dataplane algorithms.**
+
+  * Added the ``RTE_FIB_DIR8_16_8`` IPv4 algorithm, a three level variant of
+    DIR-24-8 with a small root table, with scalar and AVX512 lookup functions.
+
 
 Removed Items
 -------------
diff --git a/lib/fib/dir8_16_8.c b/lib/fib/dir8_16_8.c
new file mode 100644
index 0000000000..7207cd4748
--- /dev/null
+++ b/lib/fib/dir8_16_8.c
@@ -0,0 +1,614 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+#include <stdint.h>
+#include <stdio.h>
+
+#include <rte_debug.h>
+#include <rte_malloc.h>
+#include <rte_errno.h>
+#include <rte_vect.h>
+#include <rte_cpuflags.h>
+
+#include <rte_rib.h>
+#include <rte_fib.h>
+#include "dir8_16_8.h"
+#include "fib_log.h"
+
+#ifdef CC_AVX512_SUPPORT
+#include "dir8_16_8_avx512.h"
+#endif
+
+#define DIR8_16_8_NAMESIZE	64
+
+/*
+ * The IPv4 address is split in three strides handled by three table levels:
+ *   level 0: bits [31..24], 8 bits,  fixed 256 entry root table (dp->tbl0)
+ *   level 1: bits [23..8],  16 bits, dynamically allocated 65536 entry groups
+ *   level 2: bits [7..0],   8 bits,  dynamically allocated 256 entry groups
+ */
+
+struct dir8_16_8_level {
+	uint32_t	num_ent;	/**< Number of entries per group. */
+	uint8_t		shift;		/**< IP bit offset of this level. */
+	uint8_t		mask_bits;	/**< Number of IP bits at this level. */
+};
+
+static const struct dir8_16_8_level dir8_16_8_levels[] = {
+	{ DIR8_16_8_TBL0_NUM_ENT,      24, 8  },
+	{ DIR8_16_8_TBL16_GRP_NUM_ENT,  8, 16 },
+	{ DIR8_16_8_TBL8_GRP_NUM_ENT,   0, 8  },
+};
+
+#define DIR8_16_8_NUM_LEVELS	RTE_DIM(dir8_16_8_levels)
+
+static inline uint32_t
+dir8_16_8_level_idx(uint32_t ip, int level)
+{
+	const struct dir8_16_8_level *l = &dir8_16_8_levels[level];
+
+	return (ip >> l->shift) & ((1U << l->mask_bits) - 1);
+}
+
+struct dir8_16_8_rcu_dq_entry {
+	uint32_t	tbl_idx;
+	uint32_t	level;
+};
+
+static rte_fib_lookup_fn_t
+get_scalar_fn(bool be_addr)
+{
+	return be_addr ? dir8_16_8_lookup_bulk_be : dir8_16_8_lookup_bulk;
+}
+
+static rte_fib_lookup_fn_t
+get_vector_fn(bool be_addr)
+{
+#ifdef CC_AVX512_SUPPORT
+	if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) <= 0 ||
+			rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512DQ) <= 0 ||
+			rte_vect_get_max_simd_bitwidth() < RTE_VECT_SIMD_512)
+		return NULL;
+
+	if (be_addr && rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512BW) <= 0)
+		return NULL;
+
+	return be_addr ? rte_dir8_16_8_vec_lookup_bulk_be :
+		rte_dir8_16_8_vec_lookup_bulk;
+#else
+	RTE_SET_USED(be_addr);
+	return NULL;
+#endif
+}
+
+rte_fib_lookup_fn_t
+dir8_16_8_get_lookup_fn(void *p, enum rte_fib_lookup_type type, bool be_addr)
+{
+	struct dir8_16_8_tbl *dp = p;
+	rte_fib_lookup_fn_t fn;
+
+	if (dp == NULL)
+		return NULL;
+
+	switch (type) {
+	case RTE_FIB_LOOKUP_DIR8_16_8_SCALAR:
+		return get_scalar_fn(be_addr);
+	case RTE_FIB_LOOKUP_DIR8_16_8_VECTOR_AVX512:
+		return get_vector_fn(be_addr);
+	case RTE_FIB_LOOKUP_DEFAULT:
+		fn = get_vector_fn(be_addr);
+		return (fn != NULL) ? fn : get_scalar_fn(be_addr);
+	default:
+		return NULL;
+	}
+}
+
+static inline uint64_t *
+get_tbl_by_level(struct dir8_16_8_tbl *dp, int level)
+{
+	switch (level) {
+	case 1:
+		return dp->tbl16;
+	case 2:
+		return dp->tbl8;
+	default:
+		return dp->tbl0;
+	}
+}
+
+static inline int32_t
+tbl_pool_get(struct dir8_16_8_tbl *dp, int level)
+{
+	uint32_t *pool = (level == 1) ? dp->tbl16_pool : dp->tbl8_pool;
+	uint32_t *pos = (level == 1) ? &dp->tbl16_pool_pos : &dp->tbl8_pool_pos;
+	uint32_t num = (level == 1) ? dp->number_tbl16s : dp->number_tbl8s;
+
+	if (*pos == num)
+		return -ENOSPC;
+
+	return pool[(*pos)++];
+}
+
+static inline void
+tbl_pool_put(struct dir8_16_8_tbl *dp, int level, uint32_t idx)
+{
+	uint32_t *pool = (level == 1) ? dp->tbl16_pool : dp->tbl8_pool;
+	uint32_t *pos = (level == 1) ? &dp->tbl16_pool_pos : &dp->tbl8_pool_pos;
+
+	pool[--(*pos)] = idx;
+}
+
+static inline uint64_t *
+group_ptr(struct dir8_16_8_tbl *dp, int level, uint32_t grp_idx)
+{
+	uint64_t *tbl = get_tbl_by_level(dp, level);
+
+	return &tbl[(uint64_t)grp_idx * dir8_16_8_levels[level].num_ent];
+}
+
+static int
+tbl_group_alloc(struct dir8_16_8_tbl *dp, int level, uint64_t nh)
+{
+	uint32_t i, ent_num = dir8_16_8_levels[level].num_ent;
+	uint64_t *grp;
+	int idx;
+
+	idx = tbl_pool_get(dp, level);
+
+	/* If there are no free groups try to reclaim one. */
+	if (unlikely(idx == -ENOSPC && dp->dq)) {
+		/*
+		 * Deferred queue contains tbl8 mixed with tbl16 groups.
+		 * Reclaim until required group is reclaimed
+		 */
+		unsigned int freed = 0;
+		int ret;
+		do {
+			ret = rte_rcu_qsbr_dq_reclaim(dp->dq, 1, &freed, NULL, NULL);
+			idx = tbl_pool_get(dp, level);
+		} while (idx < 0 && ret == 0 && freed != 0);
+	}
+
+	if (idx < 0)
+		return idx;
+
+	grp = group_ptr(dp, level, idx);
+	for (i = 0; i < ent_num; i++)
+		grp[i] = nh & ~(uint64_t)DIR8_16_8_EXT_ENT;
+
+	if (level == 1)
+		dp->cur_tbl16s++;
+	else
+		dp->cur_tbl8s++;
+
+	return idx;
+}
+
+static void
+tbl_group_cleanup_and_free(struct dir8_16_8_tbl *dp, int level, uint32_t idx)
+{
+	uint64_t *grp = group_ptr(dp, level, idx);
+
+	memset(grp, 0, dir8_16_8_levels[level].num_ent * sizeof(uint64_t));
+	tbl_pool_put(dp, level, idx);
+	if (level == 1)
+		dp->cur_tbl16s--;
+	else
+		dp->cur_tbl8s--;
+}
+
+static void
+__rcu_qsbr_free_resource(void *p, void *data, unsigned int n __rte_unused)
+{
+	struct dir8_16_8_tbl *dp = p;
+	struct dir8_16_8_rcu_dq_entry *e = data;
+
+	tbl_group_cleanup_and_free(dp, e->level, e->tbl_idx);
+}
+
+/*
+ * If every entry of a group holds the same final nexthop, collapse the group:
+ * write that nexthop into the parent entry and free the group.
+ */
+static void
+tbl_group_recycle(struct dir8_16_8_tbl *dp, int level, uint64_t *par_ent,
+	uint32_t grp_idx)
+{
+	struct dir8_16_8_rcu_dq_entry dq_entry;
+	uint64_t *grp = group_ptr(dp, level, grp_idx);
+	uint64_t nh = grp[0];
+	uint32_t i;
+
+	if (dir8_16_8_is_entry_extended(nh))
+		return;
+	for (i = 1; i < dir8_16_8_levels[level].num_ent; i++) {
+		if (nh != grp[i])
+			return;
+	}
+
+	*par_ent = nh & ~DIR8_16_8_EXT_ENT;
+
+	if (dp->v == NULL) {
+		tbl_group_cleanup_and_free(dp, level, grp_idx);
+	} else if (dp->rcu_mode == RTE_FIB_QSBR_MODE_SYNC) {
+		rte_rcu_qsbr_synchronize(dp->v, RTE_QSBR_THRID_INVALID);
+		tbl_group_cleanup_and_free(dp, level, grp_idx);
+	} else { /* RTE_FIB_QSBR_MODE_DQ */
+		dq_entry.tbl_idx = grp_idx;
+		dq_entry.level = level;
+		if (rte_rcu_qsbr_dq_enqueue(dp->dq, &dq_entry))
+			FIB_LOG(ERR, "Failed to push QSBR FIFO");
+	}
+}
+
+/*
+ * Make sure the entry "ent" at "level" points to a child group, allocating a
+ * new group (initialized with the entry's current nexthop) if necessary.
+ * On success returns the child group index, otherwise a negative errno.
+ */
+static int
+tbl_get_child(struct dir8_16_8_tbl *dp, int level, uint64_t *ent)
+{
+	int idx;
+
+	if (dir8_16_8_is_entry_extended(*ent))
+		return *ent >> 1;
+
+	idx = tbl_group_alloc(dp, level + 1, *ent);
+	if (idx < 0)
+		return idx;
+	*ent = ((uint64_t)idx << 1) | DIR8_16_8_EXT_ENT;
+
+	return idx;
+}
+
+static int
+install_to_fib(struct dir8_16_8_tbl *dp, int level, uint64_t base,
+	uint64_t ledge, uint64_t redge, uint64_t next_hop)
+{
+	const struct dir8_16_8_level *l = &dir8_16_8_levels[level];
+	uint64_t *tbl = get_tbl_by_level(dp, level);
+	uint64_t step = 1ULL << l->shift;
+	uint64_t lalign, ralign;
+	uint32_t lidx, ridx, idx;
+	int child, ret;
+
+	if (level == (int)DIR8_16_8_NUM_LEVELS - 1) {
+		/* Leaf level: every entry is a single address, plain fill. */
+		lidx = dir8_16_8_level_idx((uint32_t)ledge, level);
+		ridx = lidx + (uint32_t)(redge - ledge);
+		for (idx = lidx; idx < ridx; idx++)
+			tbl[base + idx] = (next_hop << 1);
+
+		return 0;
+	}
+
+	lalign = RTE_ALIGN_CEIL(ledge, step);
+	ralign = RTE_ALIGN_FLOOR(redge, step);
+
+	/* Left partial sub-range that does not start on a child boundary. */
+	if (ledge < lalign) {
+		uint64_t sub_right_edge = RTE_MIN(lalign, redge);
+
+		lidx = dir8_16_8_level_idx((uint32_t)ledge, level);
+		child = tbl_get_child(dp, level, &tbl[base + lidx]);
+		if (child < 0)
+			return child;
+
+		ret = install_to_fib(dp, level + 1,
+			(uint64_t)child * dir8_16_8_levels[level + 1].num_ent,
+			ledge, sub_right_edge, next_hop);
+		if (ret != 0)
+			return ret;
+
+		tbl_group_recycle(dp, level + 1, &tbl[base + lidx], child);
+		ledge = sub_right_edge;
+	}
+
+	/* Whole child sub-ranges filled directly at this level. */
+	if (ledge < ralign) {
+		lidx = dir8_16_8_level_idx((uint32_t)ledge, level);
+		ridx = lidx + (uint32_t)((ralign - ledge) >> l->shift);
+		for (idx = lidx; idx < ridx; idx++)
+			tbl[base + idx] = (next_hop << 1);
+
+		ledge = ralign;
+	}
+
+	/* Right partial sub-range that does not end on a child boundary. */
+	if (ledge < redge) {
+		lidx = dir8_16_8_level_idx((uint32_t)ledge, level);
+		child = tbl_get_child(dp, level, &tbl[base + lidx]);
+		if (child < 0)
+			return child;
+
+		ret = install_to_fib(dp, level + 1,
+			(uint64_t)child * dir8_16_8_levels[level + 1].num_ent,
+			ledge, redge, next_hop);
+		if (ret != 0)
+			return ret;
+
+		tbl_group_recycle(dp, level + 1, &tbl[base + lidx], child);
+	}
+
+	return 0;
+}
+
+static int
+modify_fib(struct dir8_16_8_tbl *dp, struct rte_rib *rib, uint32_t ip,
+	uint8_t depth, uint64_t next_hop)
+{
+	struct rte_rib_node *tmp = NULL;
+	uint64_t ledge, redge;
+	uint32_t tmp_ip;
+	int ret;
+	uint8_t tmp_depth;
+
+	ledge = ip;
+	do {
+		tmp = rte_rib_get_nxt(rib, ip, depth, tmp,
+			RTE_RIB_GET_NXT_COVER);
+		if (tmp != NULL) {
+			rte_rib_get_depth(tmp, &tmp_depth);
+			if (tmp_depth == depth)
+				continue;
+
+			rte_rib_get_ip(tmp, &tmp_ip);
+			redge = tmp_ip & rte_rib_depth_to_mask(tmp_depth);
+			if (ledge == redge) {
+				ledge = redge + (1ULL << (32 - tmp_depth));
+				continue;
+			}
+
+			ret = install_to_fib(dp, 0, 0, ledge, redge, next_hop);
+			if (ret != 0)
+				return ret;
+
+			ledge = redge + (1ULL << (32 - tmp_depth));
+			/*
+			 * we got to the end of address space
+			 * and wrapped around
+			 */
+			if (ledge >= (1ULL << 32))
+				break;
+		} else {
+			redge = (uint64_t)ip + (1ULL << (32 - depth));
+			if (ledge == redge && ledge != 0)
+				break;
+
+			ret = install_to_fib(dp, 0, 0, ledge, redge, next_hop);
+			if (ret != 0)
+				return ret;
+		}
+	} while (tmp);
+
+	return 0;
+}
+
+int
+dir8_16_8_modify(struct rte_fib *fib, uint32_t ip, uint8_t depth,
+	uint64_t next_hop, int op)
+{
+	struct dir8_16_8_tbl *dp;
+	struct rte_rib *rib;
+	struct rte_rib_node *node;
+	struct rte_rib_node *parent;
+	int ret = 0;
+	uint64_t par_nh, node_nh;
+
+	if ((fib == NULL) || (depth > RTE_FIB_MAXDEPTH))
+		return -EINVAL;
+
+	dp = rte_fib_get_dp(fib);
+	rib = rte_fib_get_rib(fib);
+	RTE_ASSERT((dp != NULL) && (rib != NULL));
+
+	if (next_hop > dir8_16_8_get_max_nh())
+		return -EINVAL;
+
+	ip &= rte_rib_depth_to_mask(depth);
+
+	node = rte_rib_lookup_exact(rib, ip, depth);
+	switch (op) {
+	case RTE_FIB_ADD:
+		if (node != NULL) {
+			rte_rib_get_nh(node, &node_nh);
+			if (node_nh == next_hop)
+				return 0;
+
+			ret = modify_fib(dp, rib, ip, depth, next_hop);
+			if (ret == 0)
+				rte_rib_set_nh(node, next_hop);
+
+			return ret;
+		}
+		node = rte_rib_insert(rib, ip, depth);
+		if (node == NULL)
+			return -rte_errno;
+
+		rte_rib_set_nh(node, next_hop);
+		parent = rte_rib_lookup_parent(node);
+		if (parent != NULL) {
+			rte_rib_get_nh(parent, &par_nh);
+			if (par_nh == next_hop)
+				return 0;
+		}
+		ret = modify_fib(dp, rib, ip, depth, next_hop);
+		if (ret != 0) {
+			rte_rib_remove(rib, ip, depth);
+			return ret;
+		}
+
+		return 0;
+	case RTE_FIB_DEL:
+		if (node == NULL)
+			return -ENOENT;
+
+		parent = rte_rib_lookup_parent(node);
+		if (parent != NULL) {
+			rte_rib_get_nh(parent, &par_nh);
+			rte_rib_get_nh(node, &node_nh);
+			if (par_nh != node_nh)
+				ret = modify_fib(dp, rib, ip, depth, par_nh);
+		} else
+			ret = modify_fib(dp, rib, ip, depth, dp->def_nh);
+		if (ret == 0)
+			rte_rib_remove(rib, ip, depth);
+		return ret;
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+void *
+dir8_16_8_create(const char *name, int socket_id, struct rte_fib_conf *fib_conf)
+{
+	char mem_name[DIR8_16_8_NAMESIZE];
+	struct dir8_16_8_tbl *dp;
+	uint64_t def_nh;
+	uint32_t num_tbl16, num_tbl8;
+	uint32_t i;
+	uint64_t tbl16_sz, tbl8_sz;
+
+	if ((name == NULL) || (fib_conf == NULL) || (fib_conf->dir8_16_8.num_tbl16 == 0) ||
+			(fib_conf->dir8_16_8.num_tbl8 == 0) ||
+			(fib_conf->default_nh > dir8_16_8_get_max_nh())) {
+		rte_errno = EINVAL;
+		return NULL;
+	}
+
+	def_nh = fib_conf->default_nh;
+	num_tbl16 = fib_conf->dir8_16_8.num_tbl16;
+	num_tbl8 = fib_conf->dir8_16_8.num_tbl8;
+
+	dp = rte_zmalloc_socket(name, sizeof(struct dir8_16_8_tbl) +
+		DIR8_16_8_TBL0_NUM_ENT * sizeof(uint64_t), RTE_CACHE_LINE_SIZE, socket_id);
+	if (dp == NULL) {
+		rte_errno = ENOMEM;
+		return NULL;
+	}
+
+	/* Init first level table with the default nexthop. */
+	for (i = 0; i < DIR8_16_8_TBL0_NUM_ENT; i++)
+		dp->tbl0[i] = def_nh << 1;
+
+	snprintf(mem_name, sizeof(mem_name), "TBL16_%p", dp);
+	tbl16_sz = (uint64_t)DIR8_16_8_TBL16_GRP_NUM_ENT * sizeof(uint64_t) * num_tbl16;
+	dp->tbl16 = rte_zmalloc_socket(mem_name, tbl16_sz, RTE_CACHE_LINE_SIZE, socket_id);
+	if (dp->tbl16 == NULL) {
+		rte_errno = ENOMEM;
+		goto free_dp;
+	}
+
+	snprintf(mem_name, sizeof(mem_name), "TBL8_%p", dp);
+	tbl8_sz = (uint64_t)DIR8_16_8_TBL8_GRP_NUM_ENT * sizeof(uint64_t) * num_tbl8;
+	dp->tbl8 = rte_zmalloc_socket(mem_name, tbl8_sz, RTE_CACHE_LINE_SIZE, socket_id);
+	if (dp->tbl8 == NULL) {
+		rte_errno = ENOMEM;
+		goto free_tbl16;
+	}
+
+	snprintf(mem_name, sizeof(mem_name), "TBL16_pool_%p", dp);
+	dp->tbl16_pool = rte_zmalloc_socket(mem_name, sizeof(uint32_t) * num_tbl16,
+		RTE_CACHE_LINE_SIZE, socket_id);
+	if (dp->tbl16_pool == NULL) {
+		rte_errno = ENOMEM;
+		goto free_tbl8;
+	}
+	for (i = 0; i < num_tbl16; i++)
+		dp->tbl16_pool[i] = i;
+
+	snprintf(mem_name, sizeof(mem_name), "TBL8_pool_%p", dp);
+	dp->tbl8_pool = rte_zmalloc_socket(mem_name, sizeof(uint32_t) * num_tbl8,
+		RTE_CACHE_LINE_SIZE, socket_id);
+	if (dp->tbl8_pool == NULL) {
+		rte_errno = ENOMEM;
+		goto free_tbl16_pool;
+	}
+
+	for (i = 0; i < num_tbl8; i++)
+		dp->tbl8_pool[i] = i;
+
+	dp->def_nh = def_nh;
+	dp->number_tbl16s = num_tbl16;
+	dp->number_tbl8s = num_tbl8;
+
+	return dp;
+
+free_tbl16_pool:
+	rte_free(dp->tbl16_pool);
+free_tbl8:
+	rte_free(dp->tbl8);
+free_tbl16:
+	rte_free(dp->tbl16);
+free_dp:
+	rte_free(dp);
+	return NULL;
+}
+
+void
+dir8_16_8_free(void *p)
+{
+	struct dir8_16_8_tbl *dp = (struct dir8_16_8_tbl *)p;
+
+	if (dp == NULL)
+		return;
+
+	rte_rcu_qsbr_dq_delete(dp->dq);
+	rte_free(dp->tbl8_pool);
+	rte_free(dp->tbl16_pool);
+	rte_free(dp->tbl8);
+	rte_free(dp->tbl16);
+	rte_free(dp);
+}
+
+int
+dir8_16_8_rcu_qsbr_add(struct dir8_16_8_tbl *dp, struct rte_fib_rcu_config *cfg,
+	const char *name)
+{
+	struct rte_rcu_qsbr_dq_parameters params = {0};
+	char rcu_dq_name[RTE_RCU_QSBR_DQ_NAMESIZE];
+
+	if (dp == NULL || cfg == NULL)
+		return -EINVAL;
+
+	if (dp->v != NULL)
+		return -EEXIST;
+
+	if (cfg->mode == RTE_FIB_QSBR_MODE_SYNC) {
+		/* No other things to do. */
+	} else if (cfg->mode == RTE_FIB_QSBR_MODE_DQ) {
+		/* Init QSBR defer queue. */
+		snprintf(rcu_dq_name, sizeof(rcu_dq_name),
+				"FIB_RCU_%s", name);
+		params.name = rcu_dq_name;
+		params.size = cfg->dq_size;
+		if (params.size == 0)
+			params.size = RTE_FIB_RCU_DQ_RECLAIM_SZ;
+
+		params.trigger_reclaim_limit = cfg->reclaim_thd;
+		params.max_reclaim_size = cfg->reclaim_max;
+		if (params.max_reclaim_size == 0)
+			params.max_reclaim_size = RTE_FIB_RCU_DQ_RECLAIM_MAX;
+
+		params.esize = sizeof(struct dir8_16_8_rcu_dq_entry);
+		params.free_fn = __rcu_qsbr_free_resource;
+		params.p = dp;
+		params.v = cfg->v;
+		dp->dq = rte_rcu_qsbr_dq_create(&params);
+		if (dp->dq == NULL) {
+			FIB_LOG(ERR, "LPM defer queue creation failed");
+			return -rte_errno;
+		}
+	} else {
+		return -EINVAL;
+	}
+
+	dp->rcu_mode = cfg->mode;
+	dp->v = cfg->v;
+
+	return 0;
+}
diff --git a/lib/fib/dir8_16_8.h b/lib/fib/dir8_16_8.h
new file mode 100644
index 0000000000..31ca5162de
--- /dev/null
+++ b/lib/fib/dir8_16_8.h
@@ -0,0 +1,143 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+#ifndef _DIR8_16_8_H_
+#define _DIR8_16_8_H_
+
+#include <stdalign.h>
+#include <stdbool.h>
+
+#include <rte_byteorder.h>
+#include <rte_prefetch.h>
+#include <rte_branch_prediction.h>
+#include <rte_rcu_qsbr.h>
+
+/**
+ * @file
+ * DIR8_16_8 algorithm
+ *
+ * Three level variant of the DIR24_8 algorithm.
+ * The 32 bit IPv4 address is split in three strides of 8, 16 and 8 bits.
+ * Only a single nexthop size of 8 bytes is supported.
+ */
+
+/** Number of entries in the first level table (top 8 bits). */
+#define DIR8_16_8_TBL0_NUM_ENT		256U
+/** Number of entries in a second level group (middle 16 bits). */
+#define DIR8_16_8_TBL16_GRP_NUM_ENT	(1U << 16)
+/** Number of entries in a third level group (last 8 bits). */
+#define DIR8_16_8_TBL8_GRP_NUM_ENT	256U
+/** Flag set in an entry pointing to the next level table. */
+#define DIR8_16_8_EXT_ENT		1
+
+struct dir8_16_8_tbl {
+	uint32_t	number_tbl16s;	/**< Total number of tbl16 groups. */
+	uint32_t	cur_tbl16s;	/**< Current number of tbl16 groups. */
+	uint32_t	number_tbl8s;	/**< Total number of tbl8 groups. */
+	uint32_t	cur_tbl8s;	/**< Current number of tbl8 groups. */
+	uint64_t	def_nh;		/**< Default next hop. */
+	uint64_t	*tbl16;		/**< Second level table. */
+	uint64_t	*tbl8;		/**< Third level table. */
+	uint32_t	*tbl16_pool;	/**< Stack of free tbl16 group idxes. */
+	uint32_t	*tbl8_pool;	/**< Stack of free tbl8 group idxes. */
+	uint32_t	tbl16_pool_pos;	/**< Allocation pos in tbl16 pool. */
+	uint32_t	tbl8_pool_pos;	/**< Allocation pos in tbl8 pool. */
+	/* RCU config. */
+	enum rte_fib_qsbr_mode rcu_mode;/* Blocking, defer queue. */
+	struct rte_rcu_qsbr *v;		/* RCU QSBR variable. */
+	struct rte_rcu_qsbr_dq *dq;	/* RCU QSBR defer queue. */
+	/* First level table (top 8 bits). */
+	alignas(RTE_CACHE_LINE_SIZE) uint64_t	tbl0[];
+};
+
+static inline uint32_t
+dir8_16_8_get_tbl0_idx(uint32_t ip)
+{
+	return ip >> 24;
+}
+
+static inline size_t
+dir8_16_8_get_tbl16_idx(uint64_t ent, uint32_t ip)
+{
+	return (ent >> 1) * DIR8_16_8_TBL16_GRP_NUM_ENT +
+		((ip >> 8) & 0xffff);
+}
+
+static inline size_t
+dir8_16_8_get_tbl8_idx(uint64_t ent, uint32_t ip)
+{
+	return (ent >> 1) * DIR8_16_8_TBL8_GRP_NUM_ENT + (uint8_t)ip;
+}
+
+static inline uint64_t
+dir8_16_8_get_max_nh(void)
+{
+	return (UINT64_MAX >> 1);
+}
+
+static inline int
+dir8_16_8_is_entry_extended(uint64_t ent)
+{
+	return (ent & DIR8_16_8_EXT_ENT) == DIR8_16_8_EXT_ENT;
+}
+
+static inline void
+dir8_16_8_lookup_bulk(void *p, const uint32_t *ips,
+	uint64_t *next_hops, const unsigned int n)
+{
+	struct dir8_16_8_tbl *dp = (struct dir8_16_8_tbl *)p;
+	uint64_t tmp;
+	uint32_t i;
+
+	for (i = 0; i < n; i++) {
+		tmp = dp->tbl0[dir8_16_8_get_tbl0_idx(ips[i])];
+		/* Prefixes are usually longer than /8. */
+		if (dir8_16_8_is_entry_extended(tmp))
+			tmp = dp->tbl16[dir8_16_8_get_tbl16_idx(tmp, ips[i])];
+		if (unlikely(dir8_16_8_is_entry_extended(tmp)))
+			tmp = dp->tbl8[dir8_16_8_get_tbl8_idx(tmp, ips[i])];
+		next_hops[i] = tmp >> 1;
+	}
+}
+
+#define DIR8_16_8_BSWAP_MAX_LENGTH	64
+
+static inline void
+dir8_16_8_lookup_bulk_be(void *p, const uint32_t *ips,
+	uint64_t *next_hops, const unsigned int n)
+{
+#if RTE_BYTE_ORDER == RTE_BIG_ENDIAN
+	dir8_16_8_lookup_bulk(p, ips, next_hops, n);
+#else
+	uint32_t le_ips[DIR8_16_8_BSWAP_MAX_LENGTH];
+	unsigned int i;
+
+	for (i = 0; i < n; i += DIR8_16_8_BSWAP_MAX_LENGTH) {
+		unsigned int j;
+		for (j = 0; j < DIR8_16_8_BSWAP_MAX_LENGTH && i + j < n; j++)
+			le_ips[j] = rte_be_to_cpu_32(ips[i + j]);
+
+		dir8_16_8_lookup_bulk(p, le_ips, next_hops + i, j);
+	}
+#endif
+}
+
+void *
+dir8_16_8_create(const char *name, int socket_id, struct rte_fib_conf *conf);
+
+void
+dir8_16_8_free(void *p);
+
+rte_fib_lookup_fn_t
+dir8_16_8_get_lookup_fn(void *p, enum rte_fib_lookup_type type, bool be_addr);
+
+int
+dir8_16_8_modify(struct rte_fib *fib, uint32_t ip, uint8_t depth,
+	uint64_t next_hop, int op);
+
+int
+dir8_16_8_rcu_qsbr_add(struct dir8_16_8_tbl *dp, struct rte_fib_rcu_config *cfg,
+	const char *name);
+
+#endif /* _DIR8_16_8_H_ */
diff --git a/lib/fib/dir8_16_8_avx512.c b/lib/fib/dir8_16_8_avx512.c
new file mode 100644
index 0000000000..c147451252
--- /dev/null
+++ b/lib/fib/dir8_16_8_avx512.c
@@ -0,0 +1,142 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+#include <rte_vect.h>
+#include <rte_fib.h>
+
+#include "dir8_16_8.h"
+#include "dir8_16_8_avx512.h"
+
+static inline __m256i
+dir8_16_8_vec_load_ips(const uint32_t *ips, bool be_addr)
+{
+	const __m256i bswap32 = _mm256_set_epi8(
+		12, 13, 14, 15, 8, 9, 10, 11, 4, 5, 6, 7, 0, 1, 2, 3,
+		12, 13, 14, 15, 8, 9, 10, 11, 4, 5, 6, 7, 0, 1, 2, 3
+	);
+	__m256i ip_vec = _mm256_loadu_si256((const void *)ips);
+
+	return be_addr ? _mm256_shuffle_epi8(ip_vec, bswap32) : ip_vec;
+}
+
+static inline __m256i
+dir8_16_8_vec_get_tbl0_idx(__m256i ip_vec)
+{
+	return _mm256_srli_epi32(ip_vec, 24);
+}
+
+/* Second lookup stage input for 8 IPs, filled by the first stage. */
+struct dir8_16_8_vec_stage {
+	/* Address of the entry to read for every IP. */
+	const uint64_t *ent[8];
+	/*
+	 * Copy of the tbl0 entries. A not extended entry is read from here,
+	 * reading it again from tbl0 could see a concurrent update.
+	 */
+	uint64_t tbl0_ent[8];
+};
+
+/*
+ * First lookup stage of 8 IPs: read their tbl0 entries and prefetch the
+ * tbl16 entries the extended ones point to. Scalar loads are used, as on
+ * some CPUs a gather costs much more than the 8 loads it replaces.
+ */
+static inline void
+dir8_16_8_vec_prefetch_x8(const struct dir8_16_8_tbl *dp, const uint32_t *ips, bool be_addr,
+	struct dir8_16_8_vec_stage *st)
+{
+	const __m256i ip_vec = dir8_16_8_vec_load_ips(ips, be_addr);
+	const rte_ymm_t idx0 = { .y = dir8_16_8_vec_get_tbl0_idx(ip_vec) };
+	const rte_ymm_t ip = { .y = ip_vec };
+	const uint64_t *tbl0 = dp->tbl0;
+	const uint64_t *tbl16 = dp->tbl16;
+	uint64_t ent;
+	uint32_t i;
+
+	for (i = 0; i < 8; i++) {
+		ent = tbl0[idx0.u32[i]];
+		st->tbl0_ent[i] = ent;
+		st->ent[i] = &st->tbl0_ent[i];
+		if (dir8_16_8_is_entry_extended(ent)) {
+			st->ent[i] = &tbl16[dir8_16_8_get_tbl16_idx(ent, ip.u32[i])];
+			rte_prefetch0(st->ent[i]);
+		}
+	}
+}
+
+/* Second lookup stage of 8 IPs: read the entries found by the first stage. */
+static inline void
+dir8_16_8_vec_lookup_x8(const struct dir8_16_8_tbl *dp, const struct dir8_16_8_vec_stage *st,
+	const uint32_t *ips, bool be_addr, uint64_t *next_hops)
+{
+	const uint64_t * const *ent = st->ent;
+	const __m512i lsb = _mm512_set1_epi64(1);
+	__m512i ip64, res, idxes;
+	__mmask8 msk_ext;
+
+	res = _mm512_set_epi64(*ent[7], *ent[6], *ent[5], *ent[4],
+			*ent[3], *ent[2], *ent[1], *ent[0]);
+	ip64 = _mm512_cvtepu32_epi64(dir8_16_8_vec_load_ips(ips, be_addr));
+
+	msk_ext = _mm512_test_epi64_mask(res, lsb);
+	if (msk_ext != 0) {
+		idxes = _mm512_slli_epi64(_mm512_srli_epi64(res, 1), 8);
+		idxes = _mm512_add_epi64(idxes, _mm512_and_epi64(ip64, _mm512_set1_epi64(0xff)));
+		res = _mm512_mask_i64gather_epi64(res, msk_ext, idxes, (const void *)dp->tbl8, 8);
+	}
+
+	_mm512_storeu_si512(next_hops, _mm512_srli_epi64(res, 1));
+}
+
+static inline void
+vec_lookup_bulk(void *p, const uint32_t *ips, uint64_t *next_hops, unsigned int n, bool be_addr)
+{
+	const struct dir8_16_8_tbl *dp = p;
+	struct dir8_16_8_vec_stage stage[3];
+	struct dir8_16_8_vec_stage *st0 = &stage[0];
+	struct dir8_16_8_vec_stage *st1 = &stage[1];
+	struct dir8_16_8_vec_stage *st2 = &stage[2];
+	struct dir8_16_8_vec_stage *tmp;
+	unsigned int i = 0;
+
+	if (n >= 16) {
+		dir8_16_8_vec_prefetch_x8(dp, ips, be_addr, st0);
+		dir8_16_8_vec_prefetch_x8(dp, &ips[8], be_addr, st1);
+		for (; i + 24 <= n; i += 8) {
+			dir8_16_8_vec_prefetch_x8(dp, &ips[i + 16], be_addr, st2);
+			dir8_16_8_vec_lookup_x8(dp, st0, &ips[i], be_addr, &next_hops[i]);
+			tmp = st0;
+			st0 = st1;
+			st1 = st2;
+			st2 = tmp;
+		}
+		dir8_16_8_vec_lookup_x8(dp, st0, &ips[i], be_addr, &next_hops[i]);
+		dir8_16_8_vec_lookup_x8(dp, st1, &ips[i + 8], be_addr, &next_hops[i + 8]);
+		i += 16;
+	} else if (n >= 8) {
+		dir8_16_8_vec_prefetch_x8(dp, ips, be_addr, st0);
+		dir8_16_8_vec_lookup_x8(dp, st0, ips, be_addr, next_hops);
+		i = 8;
+	}
+
+	/* Scalar lookup of the last n % 8 IPs. */
+	if (be_addr)
+		dir8_16_8_lookup_bulk_be(p, &ips[i], &next_hops[i], n - i);
+	else
+		dir8_16_8_lookup_bulk(p, &ips[i], &next_hops[i], n - i);
+}
+
+void
+rte_dir8_16_8_vec_lookup_bulk(void *p, const uint32_t *ips,
+	uint64_t *next_hops, const unsigned int n)
+{
+	vec_lookup_bulk(p, ips, next_hops, n, false);
+}
+
+void
+rte_dir8_16_8_vec_lookup_bulk_be(void *p, const uint32_t *ips,
+	uint64_t *next_hops, const unsigned int n)
+{
+	vec_lookup_bulk(p, ips, next_hops, n, true);
+}
diff --git a/lib/fib/dir8_16_8_avx512.h b/lib/fib/dir8_16_8_avx512.h
new file mode 100644
index 0000000000..d468481029
--- /dev/null
+++ b/lib/fib/dir8_16_8_avx512.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+#ifndef _DIR8_16_8_AVX512_H_
+#define _DIR8_16_8_AVX512_H_
+
+void
+rte_dir8_16_8_vec_lookup_bulk(void *p, const uint32_t *ips,
+	uint64_t *next_hops, const unsigned int n);
+
+void
+rte_dir8_16_8_vec_lookup_bulk_be(void *p, const uint32_t *ips,
+	uint64_t *next_hops, const unsigned int n);
+
+#endif /* _DIR8_16_8_AVX512_H_ */
diff --git a/lib/fib/meson.build b/lib/fib/meson.build
index 573fc50ff1..f24f679039 100644
--- a/lib/fib/meson.build
+++ b/lib/fib/meson.build
@@ -2,14 +2,14 @@
 # Copyright(c) 2018 Vladimir Medvedkin <medvedkinv@gmail.com>
 # Copyright(c) 2019 Intel Corporation
 
-sources = files('rte_fib.c', 'rte_fib6.c', 'dir24_8.c', 'trie.c')
+sources = files('rte_fib.c', 'rte_fib6.c', 'dir24_8.c', 'dir8_16_8.c', 'trie.c')
 headers = files('rte_fib.h', 'rte_fib6.h')
 deps += ['rib']
 deps += ['rcu']
 deps += ['net']
 
 if dpdk_conf.has('RTE_ARCH_X86_64')
-    sources_avx512 += files('dir24_8_avx512.c', 'trie_avx512.c')
+    sources_avx512 += files('dir24_8_avx512.c', 'dir8_16_8_avx512.c', 'trie_avx512.c')
 elif dpdk_conf.has('RTE_ARCH_RISCV')
     sources += files('dir24_8_rvv.c')
 endif
diff --git a/lib/fib/rte_fib.c b/lib/fib/rte_fib.c
index 184210f380..fcc28899cb 100644
--- a/lib/fib/rte_fib.c
+++ b/lib/fib/rte_fib.c
@@ -18,6 +18,7 @@
 #include <rte_fib.h>
 
 #include "dir24_8.h"
+#include "dir8_16_8.h"
 #include "fib_log.h"
 
 RTE_LOG_REGISTER_DEFAULT(fib_logtype, INFO);
@@ -112,6 +113,14 @@ init_dataplane(struct rte_fib *fib, __rte_unused int socket_id,
 			RTE_FIB_LOOKUP_DEFAULT, !!(fib->flags & RTE_FIB_F_LOOKUP_NETWORK_ORDER));
 		fib->modify = dir24_8_modify;
 		return 0;
+	case RTE_FIB_DIR8_16_8:
+		fib->dp = dir8_16_8_create(dp_name, socket_id, conf);
+		if (fib->dp == NULL)
+			return -rte_errno;
+		fib->lookup = dir8_16_8_get_lookup_fn(fib->dp,
+			RTE_FIB_LOOKUP_DEFAULT, !!(fib->flags & RTE_FIB_F_LOOKUP_NETWORK_ORDER));
+		fib->modify = dir8_16_8_modify;
+		return 0;
 	default:
 		return -EINVAL;
 	}
@@ -165,7 +174,7 @@ rte_fib_create(const char *name, int socket_id, struct rte_fib_conf *conf)
 	/* Check user arguments. */
 	if ((name == NULL) || (conf == NULL) ||	(conf->max_routes < 0) ||
 			(conf->flags & ~RTE_FIB_ALLOWED_FLAGS) ||
-			(conf->type > RTE_FIB_DIR24_8)) {
+			(conf->type > RTE_FIB_DIR8_16_8)) {
 		rte_errno = EINVAL;
 		return NULL;
 	}
@@ -281,6 +290,10 @@ free_dataplane(struct rte_fib *fib)
 		return;
 	case RTE_FIB_DIR24_8:
 		dir24_8_free(fib->dp);
+		return;
+	case RTE_FIB_DIR8_16_8:
+		dir8_16_8_free(fib->dp);
+		return;
 	default:
 		return;
 	}
@@ -345,6 +358,13 @@ rte_fib_select_lookup(struct rte_fib *fib,
 			return -EINVAL;
 		fib->lookup = fn;
 		return 0;
+	case RTE_FIB_DIR8_16_8:
+		fn = dir8_16_8_get_lookup_fn(fib->dp, type,
+			!!(fib->flags & RTE_FIB_F_LOOKUP_NETWORK_ORDER));
+		if (fn == NULL)
+			return -EINVAL;
+		fib->lookup = fn;
+		return 0;
 	default:
 		return -EINVAL;
 	}
@@ -360,6 +380,8 @@ rte_fib_rcu_qsbr_add(struct rte_fib *fib, struct rte_fib_rcu_config *cfg)
 	switch (fib->type) {
 	case RTE_FIB_DIR24_8:
 		return dir24_8_rcu_qsbr_add(fib->dp, cfg, fib->name);
+	case RTE_FIB_DIR8_16_8:
+		return dir8_16_8_rcu_qsbr_add(fib->dp, cfg, fib->name);
 	default:
 		return -ENOTSUP;
 	}
diff --git a/lib/fib/rte_fib.h b/lib/fib/rte_fib.h
index b16a653535..68ee6f0652 100644
--- a/lib/fib/rte_fib.h
+++ b/lib/fib/rte_fib.h
@@ -49,7 +49,8 @@ enum rte_fib_qsbr_mode {
 /** Type of FIB struct */
 enum rte_fib_type {
 	RTE_FIB_DUMMY,		/**< RIB tree based FIB */
-	RTE_FIB_DIR24_8		/**< DIR24_8 based FIB */
+	RTE_FIB_DIR24_8,	/**< DIR24_8 based FIB */
+	RTE_FIB_DIR8_16_8	/**< DIR8_16_8 based FIB */
 };
 
 /** Modify FIB function */
@@ -87,8 +88,14 @@ enum rte_fib_lookup_type {
 	/**<
 	 * Unified lookup function for all next hop sizes
 	 */
-	RTE_FIB_LOOKUP_DIR24_8_VECTOR_AVX512
+	RTE_FIB_LOOKUP_DIR24_8_VECTOR_AVX512,
 	/**< Vector implementation using AVX512 */
+	RTE_FIB_LOOKUP_DIR8_16_8_SCALAR,
+	/**<
+	 * Scalar implementation for the DIR8_16_8 algorithm
+	 */
+	RTE_FIB_LOOKUP_DIR8_16_8_VECTOR_AVX512
+	/**< Vector (AVX512) lookup for the DIR8_16_8 algorithm */
 };
 
 /** If set, fib lookup is expecting IPv4 address in network byte order */
@@ -108,6 +115,12 @@ struct rte_fib_conf {
 			enum rte_fib_dir24_8_nh_sz nh_sz;
 			uint32_t	num_tbl8;
 		} dir24_8;
+		struct {
+			/** Number of second level (16 bit stride) groups. */
+			uint32_t	num_tbl16;
+			/** Number of third level (8 bit stride) groups. */
+			uint32_t	num_tbl8;
+		} dir8_16_8;
 	};
 	unsigned int flags; /**< Optional feature flags from RTE_FIB_F_* */
 };
-- 
2.43.0

