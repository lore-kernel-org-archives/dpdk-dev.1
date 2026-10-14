Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E45CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 18:40:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFB0340C35;
	Wed, 14 Oct 2026 20:39:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id ADC0A40A79
 for <dev@dpdk.org>; Wed, 14 Oct 2026 20:39:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792003179; x=1823539179;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Jo37Z9FQVplJZMc8tkPYYfi7VvqQeDIEoGYmEghIXSI=;
 b=neLEnF2cDxfgjezUw7jR7QguIPRE8zz4wrOIvkN/KsTV40gxrBoEKP4r
 bJY9uF/tt3eXlklOhiI5OSnxggwAxri/NIx1QYfaSFPoaU9Np4bEhtnVB
 cIfyMD9qQfMT9kDMc9C+XhKbu6y1xWLnsq7u/e48s4WZMbljBDHLNp9LH
 3dtwCH0WBaautd4Q9tQco/pfr18eH/5l6WkpZRRr8yV4LgJLgdkqDEJMJ
 0KqwWbLzHJVNmy30/Cyf1Y/pp6/GtLzgPZ7nCS7ov9oh4Z0BIl03LE9gj
 Sc5XiDWwpsiGWyisMxaCu2iU0yRjYwRtopKTTiRYluc+oipkUN+EFfxGF w==;
X-CSE-ConnectionGUID: L7dJ6KiwSpO6OOEpNltKdQ==
X-CSE-MsgGUID: kKJWAsKRR2qGwnSuMsMl6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="753384"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="753384"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 11:39:36 -0700
X-CSE-ConnectionGUID: p2DCojYcS3+X/3wLx3HTMw==
X-CSE-MsgGUID: eZc6JWSrQPWpL5prSj3UiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1419913"
Received: from silpixa00401176.ir.intel.com ([10.20.224.212])
 by orviesa009.jf.intel.com with ESMTP; 14 Oct 2026 11:39:35 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com, mb@smartsharesystems.com, maxime@leroys.fr,
 konstantin.ananyev@huawei.com
Subject: [RFC PATCH v2 7/7] fib: add hash based VRF support for DIR24-8
Date: Wed, 14 Oct 2026 18:39:21 +0000
Message-ID: <20261014183921.495158-8-vladimir.medvedkin@intel.com>
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

Add multi-VRF support to the DIR24_8 algorithm without replicating its
16M entry tbl24 per VRF: all the VRFs share a single DIR24_8 table which
maps an address to the identifier of the longest prefix present in any
VRF. A hash table keyed by (VRF, prefix ID) then resolves the nexthop
of the VRF, a miss returning the per-VRF default.

The dataplane keeps an internal RIB of the prefixes of all the VRFs
holding the prefix IDs and the VRF records, while the RIB of every VRF
returned by rte_fib_vrf_get_rib() mirrors the routes of that VRF as
for the other algorithms.

The VRF specific bookkeeping is kept generic (fib_vrf.[ch]) and driven
by a small set of address family specific operations (RIB traversal and
LPM table update) so that the IPv6 TRIE algorithm can reuse it.

Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 app/test-fib/main.c                    |   28 +-
 app/test/test_fib.c                    |  352 +++++--
 app/test/test_fib_perf.c               |   47 +-
 doc/guides/prog_guide/fib_lib.rst      |   25 +-
 doc/guides/rel_notes/release_26_11.rst |    3 +-
 lib/fib/dir24_8_vrf.c                  |  290 ++++++
 lib/fib/dir24_8_vrf.h                  |   60 ++
 lib/fib/fib_vrf.c                      | 1256 ++++++++++++++++++++++++
 lib/fib/fib_vrf.h                      |  277 ++++++
 lib/fib/fib_vrf_avx512.c               |  142 +++
 lib/fib/meson.build                    |   22 +-
 lib/fib/rte_fib.c                      |   81 +-
 lib/fib/rte_fib.h                      |   18 +-
 13 files changed, 2485 insertions(+), 116 deletions(-)
 create mode 100644 lib/fib/dir24_8_vrf.c
 create mode 100644 lib/fib/dir24_8_vrf.h
 create mode 100644 lib/fib/fib_vrf.c
 create mode 100644 lib/fib/fib_vrf.h
 create mode 100644 lib/fib/fib_vrf_avx512.c

diff --git a/app/test-fib/main.c b/app/test-fib/main.c
index 96efe0d618..3de2c062a2 100644
--- a/app/test-fib/main.c
+++ b/app/test-fib/main.c
@@ -820,12 +820,12 @@ print_usage(void)
 		"\t\ttrie - TRIE based FIB\n"
 		"defaults are: dir for ipv4 and trie for ipv6\n"
 		"[-e <entry size (valid only for dir and trie fib types): "
-		"1/2/4/8 (default 4)>]\n"
+		"1/2/4/8 (default 4), only 8 for dir in VRF mode>]\n"
 		"[-g <number of tbl8's for dir24_8, dir8_16_8 or trie FIBs>]\n"
 		"[-V <number of VRFs (2 to 65535)>]\n"
 		"[--vrfconf <\",\" separated \"<vrf> <n>%%\" list: every listed "
 		"VRF gets a random n%% of the VRF 0 routes>]\n"
-		"\tVRF mode (valid for the dir8_16_8 FIB) is "
+		"\tVRF mode (valid for dir and dir8_16_8 FIBs) is "
 		"enabled by -V, by --vrfconf or by a routes or lookup file with "
 		"a leading VRF field (\"<vrf> <prefix>/<depth> <nexthop>\", "
 		"\"<vrf> <address>\"), the other files put everything in VRF 0\n"
@@ -945,10 +945,20 @@ setup_vrfs(uint16_t max_file_vrf)
 	if (config.nb_vrfs == 0)
 		return;
 	if ((config.flags & IPV6_FLAG) ||
-			(config.flags & FIB_TYPE_MASK) != FIB_V4_DIR_8_16_8_TYPE)
-		rte_exit(-EINVAL, "VRFs are only supported by the dir8_16_8 FIB "
-			"type\n");
+			(config.flags & FIB_TYPE_MASK) == FIB_RIB_TYPE)
+		rte_exit(-EINVAL, "VRFs are only supported by the dir and "
+			"dir8_16_8 FIB types\n");
 	config.flags |= VRF_FLAG;
+
+	/* The hash based VRF DIR24_8 FIB only supports 8 byte next hops. */
+	if (!(config.flags & IPV6_FLAG) &&
+			(config.flags & FIB_TYPE_MASK) == FIB_V4_DIR_TYPE) {
+		if ((config.flags & ENT_SZ_FLAG) && config.ent_sz != 8)
+			rte_exit(-EINVAL, "-e %u is not valid in VRF mode for "
+				"the dir FIB type, only 8 byte next hops are "
+				"supported\n", config.ent_sz);
+		config.ent_sz = 8;
+	}
 }
 
 static void
@@ -1168,6 +1178,7 @@ static int
 select_lookup_fn_v4(struct rte_fib *fib, enum rte_fib_type type)
 {
 	enum rte_fib_lookup_type lookup_type;
+	bool vrf = vrf_enabled();
 
 	if (type == RTE_FIB_DIR8_16_8) {
 		if (config.lookup_fn == 1)
@@ -1176,6 +1187,13 @@ select_lookup_fn_v4(struct rte_fib *fib, enum rte_fib_type type)
 			lookup_type = RTE_FIB_LOOKUP_DIR8_16_8_VECTOR_AVX512;
 		else
 			return -EINVAL;
+	} else if (type == RTE_FIB_DIR24_8 && vrf) {
+		if (config.lookup_fn == 1)
+			lookup_type = RTE_FIB_LOOKUP_DIR24_8_VRF_SCALAR;
+		else if (config.lookup_fn == 2)
+			lookup_type = RTE_FIB_LOOKUP_DIR24_8_VRF_VECTOR_AVX512;
+		else
+			return -EINVAL;
 	} else if (type == RTE_FIB_DIR24_8) {
 		if (config.lookup_fn == 1)
 			lookup_type = RTE_FIB_LOOKUP_DIR24_8_SCALAR_MACRO;
diff --git a/app/test/test_fib.c b/app/test/test_fib.c
index ce5e48264a..ffdbbadb0a 100644
--- a/app/test/test_fib.c
+++ b/app/test/test_fib.c
@@ -5,6 +5,7 @@
 
 #include <stdio.h>
 #include <stdint.h>
+#include <stdbool.h>
 #include <stdlib.h>
 #include <string.h>
 #include <inttypes.h>
@@ -13,6 +14,7 @@
 #include <rte_ip.h>
 #include <rte_log.h>
 #include <rte_byteorder.h>
+#include <rte_rib.h>
 #include <rte_fib.h>
 #include <rte_malloc.h>
 
@@ -635,23 +637,35 @@ test_fib_rcu_sync_rw(void)
 #define DEF_NH		77
 
 static struct rte_fib *
-vrf_fib_create(const char *name, uint64_t *vrf_default_nh)
+vrf_fib_create_type(const char *name, uint64_t *vrf_default_nh,
+	enum rte_fib_type type)
 {
 	struct rte_fib_conf cfg = {0};
 	char fib_name[24];
 
-	cfg.type = RTE_FIB_DIR8_16_8;
+	cfg.type = type;
 	cfg.max_routes = 1000;
 	cfg.default_nh = DEF_NH;
 	cfg.max_vrfs = TEST_MAX_VRFS;
 	cfg.vrf_default_nh = vrf_default_nh;
-	cfg.dir8_16_8.num_tbl16 = TEST_NUM_TBL16;
-	cfg.dir8_16_8.num_tbl8 = TEST_NUM_TBL8;
+	if (type == RTE_FIB_DIR24_8) {
+		cfg.dir24_8.nh_sz = RTE_FIB_DIR24_8_8B;
+		cfg.dir24_8.num_tbl8 = TEST_NUM_TBL8;
+	} else {
+		cfg.dir8_16_8.num_tbl16 = TEST_NUM_TBL16;
+		cfg.dir8_16_8.num_tbl8 = TEST_NUM_TBL8;
+	}
 
 	snprintf(fib_name, sizeof(fib_name), "%.20s", name);
 	return rte_fib_create(fib_name, SOCKET_ID_ANY, &cfg);
 }
 
+static struct rte_fib *
+vrf_fib_create(const char *name, uint64_t *vrf_default_nh)
+{
+	return vrf_fib_create_type(name, vrf_default_nh, RTE_FIB_DIR8_16_8);
+}
+
 static uint64_t
 vrf_lookup1(struct rte_fib *fib, uint16_t vrf, uint32_t ip)
 {
@@ -676,10 +690,16 @@ test_vrf_create_invalid(void)
 	cfg.max_vrfs = TEST_MAX_VRFS;
 
 	cfg.type = RTE_FIB_DIR24_8;
-	cfg.dir24_8.nh_sz = RTE_FIB_DIR24_8_4B;
+	cfg.dir24_8.nh_sz = RTE_FIB_DIR24_8_8B;
 	cfg.dir24_8.num_tbl8 = 128;
 	fib = rte_fib_create(name, SOCKET_ID_ANY, &cfg);
-	RTE_TEST_ASSERT(fib == NULL, "DIR24_8 must reject max_vrfs >= 2\n");
+	RTE_TEST_ASSERT(fib != NULL, "DIR24_8 must support max_vrfs >= 2\n");
+	rte_fib_free(fib);
+
+	cfg.dir24_8.nh_sz = RTE_FIB_DIR24_8_4B;
+	fib = rte_fib_create(name, SOCKET_ID_ANY, &cfg);
+	RTE_TEST_ASSERT(fib == NULL,
+		"DIR24_8 with max_vrfs >= 2 must reject nh_sz != 8B\n");
 
 	cfg.type = RTE_FIB_DUMMY;
 	fib = rte_fib_create(name, SOCKET_ID_ANY, &cfg);
@@ -1093,6 +1113,109 @@ test_vrf_rcu_sync_rw(void)
 	return status == 0 ? TEST_SUCCESS : TEST_FAILED;
 }
 
+/*
+ * VRF behaviour on the hash-based DIR24_8 dataplane (a shared prefix trie
+ * with per-(vrf, prefix) nexthops in a hash table). Mirrors the DIR8_16_8 VRF
+ * checks: per-VRF isolation, longest-prefix match, defaults and deletes.
+ */
+static int32_t
+test_vrf_dir24_8(void)
+{
+	struct rte_fib *fib;
+	struct rte_rib_node *node;
+	uint32_t default_vrf_ip;
+	uint16_t v;
+	uint64_t default_vrf_nh, nh;
+
+	fib = vrf_fib_create_type(__func__, NULL, RTE_FIB_DIR24_8);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create DIR24_8 VRF FIB\n");
+
+	for (v = 0; v < TEST_MAX_VRFS; v++) {
+		RTE_TEST_ASSERT(rte_fib_vrf_add(fib, v, RTE_IPV4(10, 0, 0, 0),
+			8, 100 + v) == 0, "add /8 vrf %u\n", v);
+		RTE_TEST_ASSERT(rte_fib_vrf_add(fib, v, RTE_IPV4(192, 168, 0, 0),
+			16, 200 + v) == 0, "add /16 vrf %u\n", v);
+		RTE_TEST_ASSERT(rte_fib_vrf_add(fib, v, RTE_IPV4(10, 1, 1, 0),
+			24, 300 + v) == 0, "add /24 vrf %u\n", v);
+	}
+
+	/* Every VRF has its own RIB mirroring its routes. */
+	for (v = 0; v < TEST_MAX_VRFS; v++) {
+		struct rte_rib *rib = rte_fib_vrf_get_rib(fib, v);
+
+		RTE_TEST_ASSERT(rib != NULL &&
+			(v == 0 || rib != rte_fib_get_rib(fib)),
+			"vrf %u must have its own RIB\n", v);
+		node = rte_rib_lookup_exact(rib, RTE_IPV4(10, 1, 1, 0), 24);
+		RTE_TEST_ASSERT(node != NULL, "vrf %u /24 missing from RIB\n", v);
+		rte_rib_get_nh(node, &nh);
+		RTE_TEST_ASSERT(nh == (uint64_t)(300 + v),
+			"vrf %u RIB /24 nexthop got %"PRIu64"\n", v, nh);
+	}
+
+	default_vrf_ip = RTE_IPV4(10, 2, 3, 4);
+	RTE_TEST_ASSERT(rte_fib_lookup_bulk(fib, &default_vrf_ip, &default_vrf_nh, 1) == 0,
+		"default VRF DIR24_8 lookup failed\n");
+	RTE_TEST_ASSERT(default_vrf_nh == 100,
+		"default VRF DIR24_8 lookup must use VRF 0 nexthop, got %"PRIu64"\n",
+		default_vrf_nh);
+
+	for (v = 0; v < TEST_MAX_VRFS; v++) {
+		nh = vrf_lookup1(fib, v, RTE_IPV4(10, 2, 3, 4));
+		RTE_TEST_ASSERT(nh == (uint64_t)(100 + v),
+			"vrf %u /8 lookup got %"PRIu64"\n", v, nh);
+		nh = vrf_lookup1(fib, v, RTE_IPV4(192, 168, 5, 5));
+		RTE_TEST_ASSERT(nh == (uint64_t)(200 + v),
+			"vrf %u /16 lookup got %"PRIu64"\n", v, nh);
+		nh = vrf_lookup1(fib, v, RTE_IPV4(10, 1, 1, 7));
+		RTE_TEST_ASSERT(nh == (uint64_t)(300 + v),
+			"vrf %u /24 lookup got %"PRIu64"\n", v, nh);
+		nh = vrf_lookup1(fib, v, RTE_IPV4(8, 8, 8, 8));
+		RTE_TEST_ASSERT(nh == DEF_NH,
+			"vrf %u default lookup got %"PRIu64"\n", v, nh);
+	}
+
+	/* Delete the /24 from VRF 1 only; its covering /8 then matches. */
+	RTE_TEST_ASSERT(rte_fib_vrf_delete(fib, 1, RTE_IPV4(10, 1, 1, 0),
+		24) == 0, "del /24 vrf 1\n");
+	nh = vrf_lookup1(fib, 1, RTE_IPV4(10, 1, 1, 7));
+	RTE_TEST_ASSERT(nh == 101, "vrf 1 /24 after delete got %"PRIu64"\n",
+		nh);
+	RTE_TEST_ASSERT(rte_rib_lookup_exact(rte_fib_vrf_get_rib(fib, 1),
+		RTE_IPV4(10, 1, 1, 0), 24) == NULL,
+		"vrf 1 /24 still in its RIB after delete\n");
+	RTE_TEST_ASSERT(rte_rib_lookup_exact(rte_fib_vrf_get_rib(fib, 0),
+		RTE_IPV4(10, 1, 1, 0), 24) != NULL,
+		"vrf 0 /24 vanished from its RIB\n");
+	/* Other VRFs keep their own /24. */
+	for (v = 0; v < TEST_MAX_VRFS; v++) {
+		if (v == 1)
+			continue;
+		nh = vrf_lookup1(fib, v, RTE_IPV4(10, 1, 1, 7));
+		RTE_TEST_ASSERT(nh == (uint64_t)(300 + v),
+			"vrf %u /24 unexpectedly changed to %"PRIu64"\n",
+			v, nh);
+	}
+
+	/* A route owned by a single VRF exercises the full-removal path. */
+	RTE_TEST_ASSERT(rte_fib_vrf_add(fib, 3, RTE_IPV4(172, 16, 0, 0), 16,
+		999) == 0, "add single-owner /16 vrf 3\n");
+	nh = vrf_lookup1(fib, 3, RTE_IPV4(172, 16, 5, 5));
+	RTE_TEST_ASSERT(nh == 999, "vrf 3 single-owner /16 got %"PRIu64"\n",
+		nh);
+	nh = vrf_lookup1(fib, 0, RTE_IPV4(172, 16, 5, 5));
+	RTE_TEST_ASSERT(nh == DEF_NH, "vrf 0 must miss 172.16/16 got %"PRIu64
+		"\n", nh);
+	RTE_TEST_ASSERT(rte_fib_vrf_delete(fib, 3, RTE_IPV4(172, 16, 0, 0),
+		16) == 0, "del single-owner /16 vrf 3\n");
+	nh = vrf_lookup1(fib, 3, RTE_IPV4(172, 16, 5, 5));
+	RTE_TEST_ASSERT(nh == DEF_NH,
+		"vrf 3 after single-owner delete got %"PRIu64"\n", nh);
+
+	rte_fib_free(fib);
+	return TEST_SUCCESS;
+}
+
 /*
  * Network order lookups with every lookup implementation of DIR8_16_8, in
  * single and multi VRF FIBs, with a burst of two vector groups and a leftover.
@@ -1190,21 +1313,28 @@ test_lookup_network_order(void)
 /*
  * VRF cross-validation.
  *
- * Build one VRF-capable DIR8_16_8 FIB with N VRFs and N independent reference
- * DIR8_16_8 FIBs. The same large route table is added to each VRF and its
- * matching reference, using a per-VRF distinct unique next hop. Each VRF lookup
- * must match its reference exactly, which proves both per-VRF correctness and
- * isolation (no VRF bleeds into another), with every available lookup
- * implementation.
+ * Build one VRF-capable FIB with N VRFs and N independent single-VRF reference
+ * DIR24_8 FIBs. The large route table is added to every VRF and its reference
+ * with a per-VRF unique nexthop, then routes are deleted, updated and re-added
+ * in a pseudo-random pattern. After every phase, mixed per-IP VRF lookups must
+ * match the references exactly, which proves per-VRF correctness and isolation
+ * for all the add/delete code paths and every available lookup implementation.
  */
+
+static inline uint64_t
+vrf_validate_nh(uint32_t i, uint16_t v, uint32_t gen)
+{
+	return (uint64_t)i + 1 + (uint64_t)v * ((uint64_t)MAX_RULE_NUM + 1) +
+		((uint64_t)gen << 40);
+}
+
 static int
 vrf_validate_lookups_type(struct rte_fib *dut, struct rte_fib **ref,
-	enum rte_fib_lookup_type type)
+	const char *phase, enum rte_fib_lookup_type type)
 {
 	uint64_t mism = 0, total = 0;
 	unsigned int i, j;
 
-	/* Compare mixed per-IP VRF lookups against the matching references. */
 	for (i = 0; i < ITERATIONS; i++) {
 		static uint32_t ip_batch[BATCH_SIZE];
 		static uint16_t vrf_batch[BATCH_SIZE];
@@ -1212,7 +1342,17 @@ vrf_validate_lookups_type(struct rte_fib *dut, struct rte_fib **ref,
 		uint64_t nh_ref[BULK_SIZE];
 
 		for (j = 0; j < BATCH_SIZE; j++) {
-			ip_batch[j] = rte_rand();
+			/* Half random, half inside a known prefix. */
+			if (j & 1) {
+				const struct route_rule *r =
+					&large_route_table[rte_rand() %
+					NUM_ROUTE_ENTRIES];
+
+				ip_batch[j] = r->ip | (rte_rand() &
+					(uint32_t)((1ULL << (32 - r->depth)) - 1));
+			} else {
+				ip_batch[j] = rte_rand();
+			}
 			vrf_batch[j] = rte_rand() % TEST_MAX_VRFS;
 		}
 
@@ -1221,17 +1361,16 @@ vrf_validate_lookups_type(struct rte_fib *dut, struct rte_fib **ref,
 
 			rte_fib_vrf_lookup_bulk(dut, &vrf_batch[j],
 				&ip_batch[j], nh_dut, BULK_SIZE);
-			/* Reference: each IP resolved in its own VRF's FIB. */
 			for (k = 0; k < BULK_SIZE; k++)
 				rte_fib_lookup_bulk(ref[vrf_batch[j + k]],
 					&ip_batch[j + k], &nh_ref[k], 1);
 			for (k = 0; k < BULK_SIZE; k++) {
 				total++;
 				if (nh_dut[k] != nh_ref[k]) {
-					if (mism < 20)
-						printf("Mismatch vrf=%u "
+					if (mism < 10)
+						printf("%s: mismatch vrf=%u "
 						"ip=0x%08x dut=%" PRIu64
-						" ref=%" PRIu64 "\n",
+						" ref=%" PRIu64 "\n", phase,
 						vrf_batch[j + k],
 						ip_batch[j + k],
 						nh_dut[k], nh_ref[k]);
@@ -1241,35 +1380,84 @@ vrf_validate_lookups_type(struct rte_fib *dut, struct rte_fib **ref,
 		}
 	}
 
-	printf("Lookup type %u: validated %" PRIu64 " lookups across %u VRFs, "
-		"%" PRIu64 " mismatches\n", type, total, TEST_MAX_VRFS, mism);
+	printf("%s: lookup type %u: validated %" PRIu64 " lookups across %u "
+		"VRFs, %" PRIu64 " mismatches\n", phase, type, total,
+		TEST_MAX_VRFS, mism);
 	return (mism != 0) ? -1 : 0;
 }
 
 /* Validate the lookups with every lookup implementation of the algorithm. */
 static int
-vrf_validate_lookups(struct rte_fib *dut, struct rte_fib **ref)
+vrf_validate_lookups(struct rte_fib *dut, struct rte_fib **ref,
+	const char *phase)
 {
 	const enum rte_fib_lookup_type types[] = {
 		RTE_FIB_LOOKUP_DIR8_16_8_SCALAR,
 		RTE_FIB_LOOKUP_DIR8_16_8_VECTOR_AVX512,
+		RTE_FIB_LOOKUP_DIR24_8_VRF_SCALAR,
+		RTE_FIB_LOOKUP_DIR24_8_VRF_VECTOR_AVX512,
 	};
 	unsigned int t;
 	int ret;
 
 	for (t = 0; t < RTE_DIM(types); t++) {
-		/* The vector lookup needs a 512 bit SIMD width. */
+		/* Other algorithm, or vector lookup without 512 bit SIMD. */
 		if (rte_fib_select_lookup(dut, types[t]) != 0)
 			continue;
-		ret = vrf_validate_lookups_type(dut, ref, types[t]);
+		ret = vrf_validate_lookups_type(dut, ref, phase, types[t]);
 		if (ret != 0)
 			return ret;
 	}
 	return 0;
 }
 
+/*
+ * Apply one operation to every (route, VRF) pair, or to a random half of them
+ * if not all, checking that dut and ref agree on the return status.
+ */
 static int
-test_fib_vrf_validate_dir8_16_8(void)
+vrf_validate_apply(struct rte_fib *dut, struct rte_fib **ref, bool all,
+	bool del, uint32_t gen, const char *phase)
+{
+	unsigned int i;
+	uint16_t v;
+
+	for (i = 0; i < NUM_ROUTE_ENTRIES; i++) {
+		for (v = 0; v < TEST_MAX_VRFS; v++) {
+			int r_dut, r_ref;
+
+			if (!all && (rte_rand() & 1) == 0)
+				continue;
+			if (del) {
+				r_dut = rte_fib_vrf_delete(dut, v,
+					large_route_table[i].ip,
+					large_route_table[i].depth);
+				r_ref = rte_fib_delete(ref[v],
+					large_route_table[i].ip,
+					large_route_table[i].depth);
+			} else {
+				uint64_t nh = vrf_validate_nh(i, v, gen);
+
+				r_dut = rte_fib_vrf_add(dut, v,
+					large_route_table[i].ip,
+					large_route_table[i].depth, nh);
+				r_ref = rte_fib_add(ref[v],
+					large_route_table[i].ip,
+					large_route_table[i].depth, nh);
+			}
+			if (r_dut != r_ref) {
+				printf("%s: status mismatch i=%u vrf=%u "
+					"dut=%d ref=%d\n", phase, i, v, r_dut,
+					r_ref);
+				return -1;
+			}
+		}
+	}
+	return 0;
+}
+
+static int
+vrf_validate(enum rte_fib_type type)
 {
 	struct rte_fib *dut = NULL;
 	struct rte_fib *ref[TEST_MAX_VRFS] = { NULL };
@@ -1282,24 +1470,31 @@ test_fib_vrf_validate_dir8_16_8(void)
 
 	generate_large_route_rule_table();
 
-	printf("No. routes = %u, VRFs = %u\n",
-		(unsigned int) NUM_ROUTE_ENTRIES, TEST_MAX_VRFS);
+	printf("No. routes = %u, VRFs = %u, algorithm = %s\n",
+		(unsigned int) NUM_ROUTE_ENTRIES, TEST_MAX_VRFS,
+		(type == RTE_FIB_DIR24_8) ? "DIR24_8" : "DIR8_16_8");
 
 	cfg.max_routes = 2000000;
 	cfg.default_nh = 0;
-	cfg.type = RTE_FIB_DIR8_16_8;
+	cfg.type = type;
 	cfg.max_vrfs = TEST_MAX_VRFS;
-	cfg.dir8_16_8.num_tbl16 = 256 * TEST_MAX_VRFS;
-	cfg.dir8_16_8.num_tbl8 = 1 << 18;
+	if (type == RTE_FIB_DIR24_8) {
+		cfg.dir24_8.nh_sz = RTE_FIB_DIR24_8_8B;
+		cfg.dir24_8.num_tbl8 = 1 << 16;
+	} else {
+		cfg.dir8_16_8.num_tbl16 = 256 * TEST_MAX_VRFS;
+		cfg.dir8_16_8.num_tbl8 = 1 << 18;
+	}
+	/* The references use 8 byte nexthops so results are comparable. */
+	cfg_ref.max_routes = 2000000;
+	cfg_ref.default_nh = 0;
+	cfg_ref.type = RTE_FIB_DIR24_8;
+	cfg_ref.dir24_8.nh_sz = RTE_FIB_DIR24_8_8B;
+	cfg_ref.dir24_8.num_tbl8 = 1 << 16;
 
 	dut = rte_fib_create("vrf_validate_dut", SOCKET_ID_ANY, &cfg);
 	RTE_TEST_ASSERT(dut != NULL, "Failed to create VRF FIB\n");
 
-	cfg_ref.max_routes = 2000000;
-	cfg_ref.default_nh = 0;
-	cfg_ref.type = RTE_FIB_DIR8_16_8;
-	cfg_ref.dir8_16_8.num_tbl16 = 256;
-	cfg_ref.dir8_16_8.num_tbl8 = 1 << 16;
 	for (v = 0; v < TEST_MAX_VRFS; v++) {
 		snprintf(name, sizeof(name), "vrf_validate_ref%u", v);
 		ref[v] = rte_fib_create(name, SOCKET_ID_ANY, &cfg_ref);
@@ -1310,35 +1505,74 @@ test_fib_vrf_validate_dir8_16_8(void)
 		}
 	}
 
-	/* Add the same routes to each VRF and its reference, per-VRF unique nh. */
-	for (i = 0; i < NUM_ROUTE_ENTRIES; i++) {
-		for (v = 0; v < TEST_MAX_VRFS; v++) {
-			uint64_t nh = (uint64_t)i + 1 +
-				(uint64_t)v * ((uint64_t)MAX_RULE_NUM + 1);
-			int r_dut = rte_fib_vrf_add(dut, v,
-				large_route_table[i].ip,
-				large_route_table[i].depth, nh);
-			int r_ref = rte_fib_add(ref[v],
-				large_route_table[i].ip,
-				large_route_table[i].depth, nh);
-			if (r_dut != r_ref) {
-				printf("Add status mismatch i=%u vrf=%u "
-					"dut=%d ref=%d\n", i, v, r_dut, r_ref);
-				ret = -1;
-				goto out;
-			}
-		}
-	}
-
-	ret = vrf_validate_lookups(dut, ref);
+	/* 1: everything present in every VRF. */
+	ret = vrf_validate_apply(dut, ref, true, false, 0, "add all");
+	if (ret != 0)
+		goto out;
+	ret = vrf_validate_lookups(dut, ref, "add all");
+	if (ret != 0)
+		goto out;
+
+	/* 2: delete about half of the (route, VRF) pairs. */
+	ret = vrf_validate_apply(dut, ref, false, true, 0, "delete");
+	if (ret != 0)
+		goto out;
+	ret = vrf_validate_lookups(dut, ref, "delete");
+	if (ret != 0)
+		goto out;
+
+	/*
+	 * 3: add about half of the (route, VRF) pairs with new nexthops, which
+	 * updates the remaining routes and re-adds the deleted ones.
+	 */
+	ret = vrf_validate_apply(dut, ref, false, false, 1, "update");
+	if (ret != 0)
+		goto out;
+	ret = vrf_validate_lookups(dut, ref, "update");
+	if (ret != 0)
+		goto out;
+
+	/* 4: put everything back with fresh nexthops. */
+	ret = vrf_validate_apply(dut, ref, true, false, 2, "re-add");
+	if (ret != 0)
+		goto out;
+	ret = vrf_validate_lookups(dut, ref, "re-add");
+	if (ret != 0)
+		goto out;
+
+	/* 5: delete everything, only default nexthops must remain. */
+	ret = vrf_validate_apply(dut, ref, true, true, 0, "delete all");
+	if (ret != 0)
+		goto out;
+	ret = vrf_validate_lookups(dut, ref, "delete all");
+	if (ret != 0)
+		goto out;
+
+	/* 6: once more from scratch, reusing the retired prefix IDs. */
+	ret = vrf_validate_apply(dut, ref, true, false, 3, "add again");
+	if (ret != 0)
+		goto out;
+	ret = vrf_validate_lookups(dut, ref, "add again");
 out:
 	rte_fib_free(dut);
-	for (v = 0; v < TEST_MAX_VRFS; v++)
-		rte_fib_free(ref[v]);
+	for (i = 0; i < TEST_MAX_VRFS; i++)
+		rte_fib_free(ref[i]);
 
 	return ret;
 }
 
+static int
+test_fib_vrf_validate_dir8_16_8(void)
+{
+	return vrf_validate(RTE_FIB_DIR8_16_8);
+}
+
+static int
+test_fib_vrf_validate_dir24_8(void)
+{
+	return vrf_validate(RTE_FIB_DIR24_8);
+}
+
 static struct unit_test_suite fib_fast_tests = {
 	.suite_name = "fib autotest",
 	.setup = NULL,
@@ -1362,6 +1596,7 @@ static struct unit_test_suite fib_fast_tests = {
 	TEST_CASE(test_vrf_get_rib),
 	TEST_CASE(test_vrf_rcu),
 	TEST_CASE(test_vrf_rcu_sync_rw),
+	TEST_CASE(test_vrf_dir24_8),
 	TEST_CASES_END()
 	}
 };
@@ -1373,6 +1608,7 @@ static struct unit_test_suite fib_slow_tests = {
 	.unit_test_cases = {
 	TEST_CASE(test_multiple_create),
 	TEST_CASE(test_fib_vrf_validate_dir8_16_8),
+	TEST_CASE(test_fib_vrf_validate_dir24_8),
 	TEST_CASES_END()
 	}
 };
diff --git a/app/test/test_fib_perf.c b/app/test/test_fib_perf.c
index ff8240aabf..e8d44566bb 100644
--- a/app/test/test_fib_perf.c
+++ b/app/test/test_fib_perf.c
@@ -175,30 +175,21 @@ test_fib_perf_dir8_16_8(void)
 #define VRF_PERF_NB_VRFS	4
 
 static int
-test_fib_perf_vrf_dir8_16_8(void)
+measure_vrf_perf(const char *name, struct rte_fib_conf *config)
 {
 	struct rte_fib *fib = NULL;
-	struct rte_fib_conf config = { 0 };
 	uint64_t begin, total_time;
 	unsigned int i, j;
 	uint16_t v;
 	int status = 0;
 	int64_t count = 0;
 
-	config.max_routes = 2000000;
-	config.rib_ext_sz = 0;
-	config.type = RTE_FIB_DIR8_16_8;
-	config.default_nh = 0;
-	config.max_vrfs = VRF_PERF_NB_VRFS;
-	config.dir8_16_8.num_tbl16 = 256 * VRF_PERF_NB_VRFS;
-	config.dir8_16_8.num_tbl8 = 1 << 18;
-
 	generate_large_route_rule_table();
 
 	printf("No. routes = %u, VRFs = %u\n",
 		(unsigned int) NUM_ROUTE_ENTRIES, VRF_PERF_NB_VRFS);
 
-	fib = rte_fib_create("vrf_perf_d8", SOCKET_ID_ANY, &config);
+	fib = rte_fib_create(name, SOCKET_ID_ANY, config);
 	TEST_FIB_ASSERT(fib != NULL);
 
 	begin = rte_rdtsc();
@@ -254,6 +245,40 @@ test_fib_perf_vrf_dir8_16_8(void)
 	return 0;
 }
 
+static int
+test_fib_perf_vrf_dir8_16_8(void)
+{
+	struct rte_fib_conf config = { 0 };
+
+	config.max_routes = 2000000;
+	config.rib_ext_sz = 0;
+	config.type = RTE_FIB_DIR8_16_8;
+	config.default_nh = 0;
+	config.max_vrfs = VRF_PERF_NB_VRFS;
+	config.dir8_16_8.num_tbl16 = 256 * VRF_PERF_NB_VRFS;
+	config.dir8_16_8.num_tbl8 = 1 << 18;
+
+	/* Keep the name short, the RIB derives memzone names from it. */
+	return measure_vrf_perf("vrf_perf_d8", &config);
+}
+
+static int
+test_fib_perf_vrf_dir24_8(void)
+{
+	struct rte_fib_conf config = { 0 };
+
+	config.max_routes = 2000000;
+	config.rib_ext_sz = 0;
+	config.type = RTE_FIB_DIR24_8;
+	config.default_nh = 0;
+	config.max_vrfs = VRF_PERF_NB_VRFS;
+	config.dir24_8.nh_sz = RTE_FIB_DIR24_8_8B;
+	config.dir24_8.num_tbl8 = 1 << 16;
+
+	return measure_vrf_perf("vrf_perf_d24", &config);
+}
+
 REGISTER_PERF_TEST(fib_perf_autotest, test_fib_perf);
 REGISTER_PERF_TEST(fib_perf_dir8_16_8_autotest, test_fib_perf_dir8_16_8);
 REGISTER_PERF_TEST(fib_perf_vrf_dir8_16_8_autotest, test_fib_perf_vrf_dir8_16_8);
+REGISTER_PERF_TEST(fib_perf_vrf_dir24_8_autotest, test_fib_perf_vrf_dir24_8);
diff --git a/doc/guides/prog_guide/fib_lib.rst b/doc/guides/prog_guide/fib_lib.rst
index 888c1acdfa..64665cfc98 100644
--- a/doc/guides/prog_guide/fib_lib.rst
+++ b/doc/guides/prog_guide/fib_lib.rst
@@ -62,13 +62,28 @@ The VRF aware methods are:
 
 * ``rte_fib_vrf_lookup_bulk()``: Bulk LPM lookup with a VRF ID per IP address.
 
-* ``rte_fib_vrf_get_rib()``: Get the ``rte_rib`` of a given VRF.
+* ``rte_fib_vrf_get_rib()``: Get the ``rte_rib`` holding the routes of a given VRF.
 
 The legacy methods operate on VRF 0.
-Multi-VRF FIBs are supported by the ``RTE_FIB_DIR8_16_8`` algorithm, which keeps
-an independent ``rte_rib`` and an independent root table per VRF, while the lower
-level tables are allocated from pools shared by all the VRFs.
-The VRF ID selects the root table, then the lookup proceeds as for a single VRF.
+Multi-VRF FIBs are supported by the ``RTE_FIB_DIR24_8`` and ``RTE_FIB_DIR8_16_8``
+algorithms.
+Every VRF has its own ``rte_rib`` in both cases,
+but the dataplane tables are organized differently:
+
+Per-VRF root table
+   ``RTE_FIB_DIR8_16_8`` keeps an independent root table
+   per VRF, while the lower level tables are allocated from pools shared by all the VRFs.
+   The VRF ID selects the root table, then the lookup proceeds as for a single VRF.
+
+Shared table and hash resolution
+   ``RTE_FIB_DIR24_8`` keeps a single lookup table
+   holding the prefixes of all the VRFs.
+   The lookup table returns an internal prefix identifier, which is then combined
+   with the VRF ID to find the next hop ID in a hash table.
+   A miss in the hash table returns the VRF default next hop ID.
+   With this scheme the memory of the lookup table does not grow with the number of
+   VRFs, but ``max_routes`` is the number of distinct prefixes across all the VRFs
+   and ``nh_sz`` must select 8 byte next hop IDs.
 
 
 Implementation details
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 5f77116d8c..c42ca0830d 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -216,7 +216,8 @@ New Features
   A FIB can now hold several independent routing tables (VRFs), configured with
   the ``max_vrfs`` and ``vrf_default_nh`` fields of ``rte_fib_conf`` and
   accessed with the ``rte_fib_vrf_*`` functions. ``RTE_FIB_DIR8_16_8`` keeps a
-  root table per VRF.
+  root table per VRF, while ``RTE_FIB_DIR24_8`` shares its lookup table across
+  VRFs and resolves the per-VRF next hops through a hash table.
 
 
 Removed Items
diff --git a/lib/fib/dir24_8_vrf.c b/lib/fib/dir24_8_vrf.c
new file mode 100644
index 0000000000..f2a5850758
--- /dev/null
+++ b/lib/fib/dir24_8_vrf.c
@@ -0,0 +1,290 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+#include <stdbool.h>
+#include <stdint.h>
+#include <string.h>
+
+#include <rte_cpuflags.h>
+#include <rte_debug.h>
+#include <rte_errno.h>
+#include <rte_malloc.h>
+#include <rte_vect.h>
+
+#include <rte_rib.h>
+#include <rte_fib.h>
+
+#include "dir24_8.h"
+#ifdef CC_AVX512_SUPPORT
+#include "dir24_8_avx512.h"
+#endif
+#include "dir24_8_vrf.h"
+#include "fib_log.h"
+#include "fib_vrf.h"
+
+/*
+ * IPv4 glue for the generic VRF code: RIB access and DIR24_8 table updates.
+ */
+
+static void *
+rib_lookup(void *rib, const void *ip)
+{
+	return rte_rib_lookup(rib, *(const uint32_t *)ip);
+}
+
+static void *
+rib_lookup_exact(void *rib, const void *ip, uint8_t depth)
+{
+	return rte_rib_lookup_exact(rib, *(const uint32_t *)ip, depth);
+}
+
+static void *
+rib_lookup_parent(void *node)
+{
+	return rte_rib_lookup_parent(node);
+}
+
+static void *
+rib_get_nxt_cover(void *rib, const void *ip, uint8_t depth, void *last)
+{
+	return rte_rib_get_nxt(rib, *(const uint32_t *)ip, depth, last,
+		RTE_RIB_GET_NXT_COVER);
+}
+
+static void *
+rib_walk(void *rib, void *last)
+{
+	return rte_rib_get_nxt(rib, 0, 0, last, RTE_RIB_GET_NXT_ALL);
+}
+
+static void *
+rib_insert(void *rib, const void *ip, uint8_t depth)
+{
+	return rte_rib_insert(rib, *(const uint32_t *)ip, depth);
+}
+
+static void
+rib_remove(void *rib, const void *ip, uint8_t depth)
+{
+	rte_rib_remove(rib, *(const uint32_t *)ip, depth);
+}
+
+static void
+rib_get_prefix(const void *node, void *ip, uint8_t *depth)
+{
+	rte_rib_get_ip(node, ip);
+	rte_rib_get_depth(node, depth);
+}
+
+static uint64_t
+rib_get_nh(const void *node)
+{
+	uint64_t nh;
+
+	rte_rib_get_nh(node, &nh);
+	return nh;
+}
+
+static void
+rib_set_nh(void *node, uint64_t nh)
+{
+	rte_rib_set_nh(node, nh);
+}
+
+static void *
+rib_get_ext(void *node)
+{
+	return rte_rib_get_ext(node);
+}
+
+static int
+lpm_modify(void *lpm, void *rib, const void *ip, uint8_t depth,
+	uint64_t prefix_id, enum fib_vrf_op op)
+{
+	return dir24_8_modify_dp(lpm, rib, *(const uint32_t *)ip, depth,
+		prefix_id, (op == FIB_VRF_ADD) ? RTE_FIB_ADD : RTE_FIB_DEL);
+}
+
+static const struct fib_vrf_ops dir24_8_vrf_ops = {
+	.rib_lookup = rib_lookup,
+	.rib_lookup_exact = rib_lookup_exact,
+	.rib_lookup_parent = rib_lookup_parent,
+	.rib_get_nxt_cover = rib_get_nxt_cover,
+	.rib_walk = rib_walk,
+	.rib_insert = rib_insert,
+	.rib_remove = rib_remove,
+	.rib_get_prefix = rib_get_prefix,
+	.rib_get_nh = rib_get_nh,
+	.rib_set_nh = rib_set_nh,
+	.rib_get_ext = rib_get_ext,
+	.lpm_modify = lpm_modify,
+};
+
+int
+dir24_8_vrf_modify(struct rte_fib *fib, uint16_t vrf_id, uint32_t ip,
+	uint8_t depth, uint64_t next_hop, int op)
+{
+	struct dir24_8_vrf_tbl *dp;
+	struct rte_rib *vrf_rib;
+
+	if ((fib == NULL) || (depth > RTE_FIB_MAXDEPTH))
+		return -EINVAL;
+
+	dp = rte_fib_get_dp(fib);
+	vrf_rib = rte_fib_vrf_get_rib(fib, vrf_id);
+	RTE_ASSERT((dp != NULL) && (vrf_rib != NULL));
+
+	ip &= rte_rib_depth_to_mask(depth);
+	return fib_vrf_modify(&dp->ht, dp->lpm, dp->rib, vrf_rib, vrf_id, &ip,
+		depth, next_hop, (op == RTE_FIB_ADD) ? FIB_VRF_ADD : FIB_VRF_DEL);
+}
+
+void *
+dir24_8_vrf_create(const char *name, int socket_id,
+	struct rte_fib_conf *fib_conf)
+{
+	struct dir24_8_vrf_tbl *dp;
+	struct rte_fib_conf lpm_conf;
+	struct rte_rib_conf rib_conf;
+	char mem_name[64], dp_name[32];
+	int ret;
+
+	/* The hash table only stores 8 byte nexthops. */
+	if ((name == NULL) || (fib_conf == NULL) ||
+			(fib_conf->max_routes <= 0) ||
+			(fib_conf->dir24_8.nh_sz != RTE_FIB_DIR24_8_8B)) {
+		rte_errno = EINVAL;
+		return NULL;
+	}
+
+	snprintf(mem_name, sizeof(mem_name), "DP_%s", name);
+	dp = rte_zmalloc_socket(mem_name, sizeof(*dp), RTE_CACHE_LINE_SIZE,
+		socket_id);
+	if (dp == NULL) {
+		rte_errno = ENOMEM;
+		return NULL;
+	}
+	/* The RIB and hash table names must be unique. */
+	snprintf(dp_name, sizeof(dp_name), "%p", (void *)dp);
+
+	/*
+	 * The DIR24_8 table stores 4 byte prefix IDs, 0 meaning no route,
+	 * whatever default nexthop the user configured.
+	 */
+	lpm_conf = *fib_conf;
+	lpm_conf.default_nh = 0;
+	lpm_conf.dir24_8.nh_sz = RTE_FIB_DIR24_8_4B;
+	snprintf(mem_name, sizeof(mem_name), "LPM_%s", name);
+	dp->lpm = dir24_8_create(mem_name, socket_id, &lpm_conf);
+	if (dp->lpm == NULL)
+		goto free_dp;
+
+	/* Internal RIB of all the prefixes, with the VRF records. */
+	rib_conf.ext_sz = fib_vrf_rib_ext_sz();
+	rib_conf.max_nodes = fib_conf->max_routes * 2;
+	dp->rib = rte_rib_create(dp_name, socket_id, &rib_conf);
+	if (dp->rib == NULL)
+		goto free_lpm;
+
+	ret = fib_vrf_ht_init(&dp->ht, dp_name, socket_id, &dir24_8_vrf_ops,
+		RTE_MAX(fib_conf->max_vrfs, 1), fib_conf->default_nh,
+		fib_conf->vrf_default_nh, fib_conf->max_routes);
+	if (ret != 0) {
+		rte_errno = -ret;
+		goto free_rib;
+	}
+
+	return dp;
+
+free_rib:
+	rte_rib_free(dp->rib);
+free_lpm:
+	dir24_8_free(dp->lpm);
+free_dp:
+	rte_free(dp);
+	return NULL;
+}
+
+void
+dir24_8_vrf_free(void *p)
+{
+	struct dir24_8_vrf_tbl *dp = p;
+
+	if (dp == NULL)
+		return;
+
+	fib_vrf_ht_free(&dp->ht, dp->rib);
+	rte_rib_free(dp->rib);
+	dir24_8_free(dp->lpm);
+	rte_free(dp);
+}
+
+#ifdef CC_AVX512_SUPPORT
+static void
+dir24_8_vrf_vec_lookup_bulk(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n)
+{
+	struct dir24_8_vrf_tbl *dp = p;
+
+	rte_dir24_8_vec_lookup_bulk_4b(dp->lpm, NULL, ips, next_hops, n);
+	fib_vrf_ht_resolve_avx512(&dp->ht, vrf_ids, next_hops, n);
+}
+
+static void
+dir24_8_vrf_vec_lookup_bulk_be(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n)
+{
+	struct dir24_8_vrf_tbl *dp = p;
+
+	rte_dir24_8_vec_lookup_bulk_4b_be(dp->lpm, NULL, ips, next_hops, n);
+	fib_vrf_ht_resolve_avx512(&dp->ht, vrf_ids, next_hops, n);
+}
+#endif
+
+static rte_fib_lookup_fn_t
+dir24_8_vrf_get_vector_fn(bool be_addr)
+{
+#ifdef CC_AVX512_SUPPORT
+	if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) <= 0 ||
+			rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512DQ) <= 0 ||
+			rte_cpu_get_flag_enabled(RTE_CPUFLAG_VPCLMULQDQ) <= 0 ||
+			rte_vect_get_max_simd_bitwidth() < RTE_VECT_SIMD_512)
+		return NULL;
+
+	if (be_addr && rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512BW) <= 0)
+		return NULL;
+
+	return be_addr ? dir24_8_vrf_vec_lookup_bulk_be :
+		dir24_8_vrf_vec_lookup_bulk;
+#else
+	RTE_SET_USED(be_addr);
+	return NULL;
+#endif
+}
+
+rte_fib_lookup_fn_t
+dir24_8_vrf_get_lookup_fn(void *p, enum rte_fib_lookup_type type,
+	bool be_addr)
+{
+	rte_fib_lookup_fn_t fn;
+
+	if (p == NULL)
+		return NULL;
+
+	switch (type) {
+	case RTE_FIB_LOOKUP_DIR24_8_VRF_SCALAR:
+		return be_addr ? dir24_8_vrf_lookup_bulk_be :
+			dir24_8_vrf_lookup_bulk;
+	case RTE_FIB_LOOKUP_DIR24_8_VRF_VECTOR_AVX512:
+		return dir24_8_vrf_get_vector_fn(be_addr);
+	case RTE_FIB_LOOKUP_DEFAULT:
+		fn = dir24_8_vrf_get_vector_fn(be_addr);
+		if (fn != NULL)
+			return fn;
+		return be_addr ? dir24_8_vrf_lookup_bulk_be :
+			dir24_8_vrf_lookup_bulk;
+	default:
+		return NULL;
+	}
+}
diff --git a/lib/fib/dir24_8_vrf.h b/lib/fib/dir24_8_vrf.h
new file mode 100644
index 0000000000..97ecbef7cc
--- /dev/null
+++ b/lib/fib/dir24_8_vrf.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+#ifndef _DIR24_8_VRF_H_
+#define _DIR24_8_VRF_H_
+
+#include <rte_fib.h>
+
+#include "dir24_8.h"
+#include "fib_vrf.h"
+
+/**
+ * @file
+ * DIR24_8 algorithm with hash based VRF resolution: a single DIR24_8 table
+ * holding 4 byte prefix IDs, resolved to per-VRF nexthops through fib_vrf.
+ */
+
+struct dir24_8_vrf_tbl {
+	struct dir24_8_tbl *lpm;	/**< Shared prefix ID table. */
+	struct rte_rib *rib;		/**< Prefixes of all the VRFs, nh = prefix ID. */
+	struct fib_vrf_ht ht;		/**< (VRF, prefix ID) -> nexthop. */
+};
+
+static inline void
+dir24_8_vrf_lookup_bulk(void *p, const uint16_t *vrf_ids, const uint32_t *ips,
+	uint64_t *next_hops, const unsigned int n)
+{
+	struct dir24_8_vrf_tbl *dp = p;
+
+	dir24_8_lookup_bulk(dp->lpm, ips, next_hops, n, RTE_FIB_DIR24_8_4B);
+	fib_vrf_ht_resolve(&dp->ht, vrf_ids, next_hops, n);
+}
+
+static inline void
+dir24_8_vrf_lookup_bulk_be(void *p, const uint16_t *vrf_ids,
+	const uint32_t *ips, uint64_t *next_hops, const unsigned int n)
+{
+	struct dir24_8_vrf_tbl *dp = p;
+
+	dir24_8_lookup_bulk_4b_be(dp->lpm, NULL, ips, next_hops, n);
+	fib_vrf_ht_resolve(&dp->ht, vrf_ids, next_hops, n);
+}
+
+void *
+dir24_8_vrf_create(const char *name, int socket_id,
+	struct rte_fib_conf *fib_conf);
+
+void
+dir24_8_vrf_free(void *p);
+
+rte_fib_lookup_fn_t
+dir24_8_vrf_get_lookup_fn(void *p, enum rte_fib_lookup_type type,
+	bool be_addr);
+
+int
+dir24_8_vrf_modify(struct rte_fib *fib, uint16_t vrf_id, uint32_t ip,
+	uint8_t depth, uint64_t next_hop, int op);
+
+#endif /* _DIR24_8_VRF_H_ */
diff --git a/lib/fib/fib_vrf.c b/lib/fib/fib_vrf.c
new file mode 100644
index 0000000000..5213e3a64a
--- /dev/null
+++ b/lib/fib/fib_vrf.c
@@ -0,0 +1,1256 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+#include <stdalign.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <string.h>
+
+#include <rte_bitops.h>
+#include <rte_debug.h>
+#include <rte_errno.h>
+#include <rte_hash.h>
+#include <rte_hash_crc.h>
+#include <rte_malloc.h>
+#include <rte_random.h>
+
+#include "fib_log.h"
+#include "fib_vrf.h"
+
+/* VRF records of a RIB node: an inline block extended by chained chunks. */
+#define FIB_VRF_EXT_RECS	5
+#define FIB_VRF_CHUNK_RECS	24
+#define FIB_VRF_NO_VRF		UINT16_MAX
+
+/*
+ * Smallest and largest hash table sizes (in buckets). With at least 2^17
+ * buckets, the records of a prefix in different VRFs never share a bucket.
+ */
+#define FIB_VRF_HT_MIN_LOG2	17
+#define FIB_VRF_HT_MAX_LOG2	24
+
+/* CRC32C polynomial and x^-64 mod P, used to invert the bucket hash. */
+#define FIB_VRF_CRC_POLY	0x1EDC6F41
+#define FIB_VRF_CRC_INV_X64	0xA6733E67
+
+struct fib_vrf_chunk {
+	struct fib_vrf_chunk *next;
+	uint32_t owner_mask;
+	uint16_t vrf[FIB_VRF_CHUNK_RECS];
+	uint64_t nh[FIB_VRF_CHUNK_RECS];
+};
+
+struct fib_vrf_node_ext {
+	struct fib_vrf_chunk *head;
+	uint32_t owner_mask;
+	uint16_t num_recs;	/**< Records are stored contiguously. */
+	uint16_t vrf[FIB_VRF_EXT_RECS];
+	uint64_t nh[FIB_VRF_EXT_RECS];
+};
+
+/* Position of a record inside a node extension. */
+struct fib_vrf_slot {
+	struct fib_vrf_chunk **link;	/**< Link pointing to chunk. */
+	struct fib_vrf_chunk *chunk;	/**< NULL while in the inline block. */
+	unsigned int idx;
+};
+
+static inline uint16_t *
+slot_vrf(struct fib_vrf_node_ext *ext, const struct fib_vrf_slot *s)
+{
+	return (s->chunk != NULL) ? &s->chunk->vrf[s->idx] : &ext->vrf[s->idx];
+}
+
+static inline uint64_t *
+slot_nh(struct fib_vrf_node_ext *ext, const struct fib_vrf_slot *s)
+{
+	return (s->chunk != NULL) ? &s->chunk->nh[s->idx] : &ext->nh[s->idx];
+}
+
+static inline uint32_t *
+slot_mask(struct fib_vrf_node_ext *ext, const struct fib_vrf_slot *s)
+{
+	return (s->chunk != NULL) ? &s->chunk->owner_mask : &ext->owner_mask;
+}
+
+static inline bool
+slot_is_owner(struct fib_vrf_node_ext *ext, const struct fib_vrf_slot *s)
+{
+	return (*slot_mask(ext, s) & RTE_BIT32(s->idx)) != 0;
+}
+
+static inline void
+slot_set_owner(struct fib_vrf_node_ext *ext, const struct fib_vrf_slot *s, bool owner)
+{
+	if (owner)
+		*slot_mask(ext, s) |= RTE_BIT32(s->idx);
+	else
+		*slot_mask(ext, s) &= ~RTE_BIT32(s->idx);
+}
+
+static inline void
+slot_first(struct fib_vrf_slot *s)
+{
+	s->link = NULL;
+	s->chunk = NULL;
+	s->idx = 0;
+}
+
+static inline bool
+slot_next(struct fib_vrf_node_ext *ext, struct fib_vrf_slot *s)
+{
+	unsigned int cap = (s->chunk != NULL) ? FIB_VRF_CHUNK_RECS : FIB_VRF_EXT_RECS;
+
+	if (++s->idx < cap)
+		return true;
+
+	s->link = (s->chunk != NULL) ? &s->chunk->next : &ext->head;
+	s->chunk = *s->link;
+	s->idx = 0;
+
+	return s->chunk != NULL;
+}
+
+static struct fib_vrf_chunk *
+chunk_alloc(void)
+{
+	struct fib_vrf_chunk *chunk;
+	unsigned int i;
+
+	chunk = rte_zmalloc(NULL, sizeof(*chunk), 0);
+	if (chunk == NULL)
+		return NULL;
+
+	for (i = 0; i < FIB_VRF_CHUNK_RECS; i++)
+		chunk->vrf[i] = FIB_VRF_NO_VRF;
+
+	return chunk;
+}
+
+static int
+slot_at(struct fib_vrf_node_ext *ext, unsigned int n, struct fib_vrf_slot *s)
+{
+	unsigned int k;
+
+	slot_first(s);
+	for (k = 0; k < n; k++) {
+		if (slot_next(ext, s))
+			continue;
+
+		*s->link = chunk_alloc();
+		if (*s->link == NULL)
+			return -ENOMEM;
+
+		s->chunk = *s->link;
+	}
+
+	return 0;
+}
+
+static void
+ext_init(struct fib_vrf_node_ext *ext)
+{
+	unsigned int i;
+
+	ext->head = NULL;
+	ext->owner_mask = 0;
+	ext->num_recs = 0;
+	for (i = 0; i < FIB_VRF_EXT_RECS; i++)
+		ext->vrf[i] = FIB_VRF_NO_VRF;
+}
+
+static void
+ext_free_chunks(struct fib_vrf_node_ext *ext)
+{
+	struct fib_vrf_chunk *chunk, *next;
+
+	for (chunk = ext->head; chunk != NULL; chunk = next) {
+		next = chunk->next;
+		rte_free(chunk);
+	}
+	ext->head = NULL;
+}
+
+static int
+ext_reserve(struct fib_vrf_node_ext *ext, unsigned int n)
+{
+	struct fib_vrf_slot s;
+
+	return (n == 0) ? 0 : slot_at(ext, n - 1, &s);
+}
+
+static bool
+ext_find(struct fib_vrf_node_ext *ext, uint16_t vrf, struct fib_vrf_slot *s)
+{
+	unsigned int k;
+
+	slot_first(s);
+	for (k = 0; k < ext->num_recs; k++, slot_next(ext, s)) {
+		if (*slot_vrf(ext, s) == vrf)
+			return true;
+	}
+
+	return false;
+}
+
+static bool
+ext_get_nh(struct fib_vrf_node_ext *ext, uint16_t vrf, uint64_t *nh)
+{
+	struct fib_vrf_slot s;
+
+	if (!ext_find(ext, vrf, &s))
+		return false;
+
+	*nh = *slot_nh(ext, &s);
+
+	return true;
+}
+
+static bool
+ext_is_owner(struct fib_vrf_node_ext *ext, uint16_t vrf)
+{
+	struct fib_vrf_slot s;
+
+	return ext_find(ext, vrf, &s) && slot_is_owner(ext, &s);
+}
+
+static unsigned int
+ext_count_owners(const struct fib_vrf_node_ext *ext)
+{
+	const struct fib_vrf_chunk *chunk;
+	unsigned int n = rte_popcount32(ext->owner_mask);
+
+	for (chunk = ext->head; chunk != NULL; chunk = chunk->next)
+		n += rte_popcount32(chunk->owner_mask);
+
+	return n;
+}
+
+static int
+ext_set(struct fib_vrf_node_ext *ext, uint16_t vrf, uint64_t nh, bool owner)
+{
+	struct fib_vrf_slot s;
+	int ret;
+
+	if (!ext_find(ext, vrf, &s)) {
+		ret = slot_at(ext, ext->num_recs, &s);
+		if (ret != 0)
+			return ret;
+
+		ext->num_recs++;
+	}
+
+	*slot_vrf(ext, &s) = vrf;
+	*slot_nh(ext, &s) = nh;
+	slot_set_owner(ext, &s, owner);
+
+	return 0;
+}
+
+static int
+ext_del(struct fib_vrf_node_ext *ext, uint16_t vrf)
+{
+	struct fib_vrf_slot s, last;
+
+	if (!ext_find(ext, vrf, &s))
+		return -ENOENT;
+
+	/* Records are contiguous: move the last one into the hole. */
+	slot_at(ext, ext->num_recs - 1, &last);
+	*slot_vrf(ext, &s) = *slot_vrf(ext, &last);
+	*slot_nh(ext, &s) = *slot_nh(ext, &last);
+	slot_set_owner(ext, &s, slot_is_owner(ext, &last));
+	*slot_vrf(ext, &last) = FIB_VRF_NO_VRF;
+	*slot_nh(ext, &last) = 0;
+	slot_set_owner(ext, &last, false);
+	ext->num_recs--;
+
+	/* The last chunk became empty. */
+	if (last.chunk != NULL && last.idx == 0) {
+		*last.link = NULL;
+		rte_free(last.chunk);
+	}
+
+	return ext->num_recs;
+}
+
+static inline bool
+bmp_get(const uint64_t *bmp, uint32_t i)
+{
+	return (bmp[i / 64] & RTE_BIT64(i % 64)) != 0;
+}
+
+static inline void
+bmp_set(uint64_t *bmp, uint32_t i)
+{
+	bmp[i / 64] |= RTE_BIT64(i % 64);
+}
+
+static inline void
+bmp_clear(uint64_t *bmp, uint32_t i)
+{
+	bmp[i / 64] &= ~RTE_BIT64(i % 64);
+}
+
+static inline uint64_t
+bucket_key(const struct fib_vrf_bucket *b, unsigned int j)
+{
+	return rte_atomic_load_explicit(&b->key[j], rte_memory_order_relaxed);
+}
+
+static inline void
+bucket_set_key(struct fib_vrf_bucket *b, unsigned int j, uint64_t key)
+{
+	rte_atomic_store_explicit(&b->key[j], key, rte_memory_order_release);
+}
+
+static int
+bucket_find(const struct fib_vrf_bucket *b, uint64_t key)
+{
+	unsigned int j;
+
+	for (j = 0; j < FIB_VRF_HT_ASSOC; j++) {
+		if (bucket_key(b, j) == key)
+			return j;
+	}
+
+	return -1;
+}
+
+static void
+bucket_refresh_full(struct fib_vrf_ht *ht, uint32_t bidx)
+{
+	if (bucket_find(&ht->buckets[bidx], 0) < 0)
+		bmp_set(ht->full_bmp, bidx);
+	else
+		bmp_clear(ht->full_bmp, bidx);
+}
+
+static void *
+pid_map_node(const struct fib_vrf_ht *ht, uint32_t prefix_id)
+{
+	void *node;
+
+	if (rte_hash_lookup_data(ht->pid_map, &prefix_id, &node) < 0)
+		return NULL;
+
+	return node;
+}
+
+static inline struct fib_vrf_node_ext *
+node_ext(const struct fib_vrf_ht *ht, void *node)
+{
+	return ht->ops->rib_get_ext(node);
+}
+
+static inline uint32_t
+node_pid(const struct fib_vrf_ht *ht, const void *node)
+{
+	return (uint32_t)ht->ops->rib_get_nh(node);
+}
+
+/* A bucket is polarized when it holds a record of a prefix referenced by more than one VRF. */
+static void
+bucket_refresh_polarized(struct fib_vrf_ht *ht, uint32_t bidx)
+{
+	const struct fib_vrf_bucket *b = &ht->buckets[bidx];
+	unsigned int j;
+
+	for (j = 0; j < FIB_VRF_HT_ASSOC; j++) {
+		uint64_t key = bucket_key(b, j);
+		void *node;
+
+		if (key == 0)
+			continue;
+
+		node = pid_map_node(ht, (uint32_t)key);
+		if (node != NULL && node_ext(ht, node)->num_recs > 1) {
+			bmp_set(ht->polarized_bmp, bidx);
+			return;
+		}
+	}
+
+	bmp_clear(ht->polarized_bmp, bidx);
+}
+
+static int
+ht_delete(struct fib_vrf_ht *ht, uint16_t vrf, uint32_t prefix_id)
+{
+	uint64_t key = fib_vrf_key(vrf, prefix_id);
+	uint32_t bidx = fib_vrf_bucket_idx(ht, key);
+	struct fib_vrf_bucket *b = &ht->buckets[bidx];
+	int j = bucket_find(b, key);
+
+	if (j < 0)
+		return -ENOENT;
+
+	bucket_set_key(b, j, 0);
+	b->val[j] = 0;
+	bmp_clear(ht->full_bmp, bidx);
+	bucket_refresh_polarized(ht, bidx);
+
+	return 0;
+}
+
+/* Insert a record, or update it if it exists. */
+static int
+ht_upsert(struct fib_vrf_ht *ht, uint16_t vrf, uint32_t prefix_id, uint64_t next_hop)
+{
+	uint64_t key = fib_vrf_key(vrf, prefix_id);
+	uint32_t bidx = fib_vrf_bucket_idx(ht, key);
+	struct fib_vrf_bucket *b = &ht->buckets[bidx];
+	int j;
+
+	j = bucket_find(b, key);
+	if (j >= 0) {
+		b->val[j] = next_hop;
+		return 0;
+	}
+
+	j = bucket_find(b, 0);
+	if (j < 0)
+		return -ENOSPC;
+
+	/* Publish the value before the key. */
+	b->val[j] = next_hop;
+	bucket_set_key(b, j, key);
+	bucket_refresh_full(ht, bidx);
+
+	return 0;
+}
+
+static uint32_t
+invert_bits(uint32_t x)
+{
+	uint32_t y = 0;
+	int i;
+
+	for (i = 0; i < 32; i++) {
+		y = (y << 1) | (x & 1);
+		x >>= 1;
+	}
+
+	return y;
+}
+
+static uint32_t
+gf2_mul(uint32_t a, uint32_t b, uint32_t poly)
+{
+	uint64_t product = 0;
+	uint64_t r_poly = poly | RTE_BIT64(32);
+	int i;
+
+	for (; b != 0; b &= (b - 1))
+		product ^= (uint64_t)a << rte_ctz32(b);
+
+	for (i = 63; i >= 32; i--) {
+		if (product & RTE_BIT64(i))
+			product ^= r_poly << (i - 32);
+	}
+
+	return (uint32_t)product;
+}
+
+static uint32_t
+find_collision(uint16_t vrf, uint32_t desired_crc)
+{
+	uint32_t diff = rte_hash_crc_8byte(fib_vrf_key(vrf, 0), 0) ^ desired_crc;
+
+	return invert_bits(gf2_mul(invert_bits(diff), FIB_VRF_CRC_INV_X64, FIB_VRF_CRC_POLY));
+}
+
+static bool
+pid_is_usable(const struct fib_vrf_ht *ht, uint32_t prefix_id)
+{
+	return prefix_id != 0 && prefix_id <= FIB_VRF_PREFIX_ID_MAX &&
+		rte_hash_lookup(ht->pid_map, &prefix_id) < 0;
+}
+
+static int
+pid_for_bucket(const struct fib_vrf_ht *ht, uint16_t vrf, uint32_t bidx)
+{
+	uint32_t i, prefix_id;
+
+	for (i = 0; i < (1U << (32 - ht->bits)); i++) {
+		prefix_id = find_collision(vrf, bidx | i << ht->bits);
+		if (pid_is_usable(ht, prefix_id))
+			return (int)prefix_id;
+	}
+	return -ENOSPC;
+}
+
+/*
+ * First bucket of [from, to) with a free slot (and no record of a multi-VRF
+ * prefix when unpolarized is set), UINT32_MAX if none.
+ */
+static uint32_t
+first_free_bucket(const struct fib_vrf_ht *ht, uint32_t from, uint32_t to, bool unpolarized)
+{
+	uint32_t i, bidx;
+
+	for (i = from / 64; i * 64 < to; i++) {
+		uint64_t available = ~ht->full_bmp[i];
+
+		if (unpolarized)
+			available &= ~ht->polarized_bmp[i];
+		if (i == from / 64)
+			available &= UINT64_MAX << (from % 64);
+		if (available != 0) {
+			bidx = i * 64 + rte_ctz64(available);
+			return (bidx < to) ? bidx : UINT32_MAX;
+		}
+	}
+
+	return UINT32_MAX;
+}
+
+static inline uint32_t
+vrf_bucket_offset(const struct fib_vrf_ht *ht, uint16_t vrf_diff)
+{
+	return fib_vrf_bucket_idx(ht, fib_vrf_key(vrf_diff, 0));
+}
+
+static inline bool
+vrf_has_room(const struct fib_vrf_ht *ht, uint32_t bidx, uint16_t vrf,
+	uint16_t other_vrf)
+{
+	return !bmp_get(ht->full_bmp, bidx ^ vrf_bucket_offset(ht, vrf ^ other_vrf));
+}
+
+static bool
+records_have_room(const struct fib_vrf_ht *ht, uint16_t vrf, uint32_t bidx,
+	struct fib_vrf_node_ext *ext, uint16_t extra_vrf)
+{
+	struct fib_vrf_slot s;
+	unsigned int k;
+
+	if (extra_vrf != FIB_VRF_NO_VRF && !vrf_has_room(ht, bidx, vrf, extra_vrf))
+		return false;
+
+	if (ext == NULL)
+		return true;
+
+	slot_first(&s);
+	for (k = 0; k < ext->num_recs; k++, slot_next(ext, &s)) {
+		if (!vrf_has_room(ht, bidx, vrf, *slot_vrf(ext, &s)))
+			return false;
+	}
+
+	return true;
+}
+
+/*
+ * Allocate a prefix ID whose record for vrf lands in a bucket with room (an
+ * unpolarized one when requested), and whose records for the VRFs referencing
+ * ext and for extra_vrf fit as well. The buckets are scanned from start,
+ * wrapping around.
+ */
+static int
+pid_alloc(const struct fib_vrf_ht *ht, uint16_t vrf, uint32_t start,
+	bool unpolarized, struct fib_vrf_node_ext *ext, uint16_t extra_vrf)
+{
+	uint32_t bidx, end = ht->mask + 1;
+	unsigned int pass;
+	int ret;
+
+	for (pass = 0; pass < 2; pass++) {
+		for (bidx = first_free_bucket(ht, start, end, unpolarized);
+				bidx != UINT32_MAX;
+				bidx = first_free_bucket(ht, bidx + 1, end, unpolarized)) {
+			if (!records_have_room(ht, vrf, bidx, ext, extra_vrf))
+				continue;
+			ret = pid_for_bucket(ht, vrf, bidx);
+			if (ret >= 0)
+				return ret;
+		}
+		end = start;
+		start = 0;
+	}
+
+	return -ENOSPC;
+}
+
+static void
+node_mark_polarized(struct fib_vrf_ht *ht, void *node)
+{
+	struct fib_vrf_node_ext *ext = node_ext(ht, node);
+	uint32_t prefix_id = node_pid(ht, node);
+	struct fib_vrf_slot s;
+	unsigned int k;
+
+	if (ext->num_recs < 2)
+		return;
+
+	slot_first(&s);
+	for (k = 0; k < ext->num_recs; k++, slot_next(ext, &s))
+		bmp_set(ht->polarized_bmp,
+			fib_vrf_bucket_idx(ht, fib_vrf_key(*slot_vrf(ext, &s), prefix_id)));
+}
+
+static void
+node_refresh_polarized(struct fib_vrf_ht *ht, void *node)
+{
+	struct fib_vrf_node_ext *ext = node_ext(ht, node);
+	uint32_t prefix_id = node_pid(ht, node);
+	struct fib_vrf_slot s;
+	unsigned int k;
+
+	slot_first(&s);
+	for (k = 0; k < ext->num_recs; k++, slot_next(ext, &s))
+		bucket_refresh_polarized(ht, fib_vrf_bucket_idx(ht,
+			fib_vrf_key(*slot_vrf(ext, &s), prefix_id)));
+}
+
+/*
+ * Closest existing prefix strictly covering ip/depth.
+ * Can not just call rib_lookup_exact and rib_get_parent
+ * since target prefix may not present in the RIB.
+ */
+static void *
+nearest_ancestor(const struct fib_vrf_ht *ht, void *rib, const void *ip,
+	uint8_t depth)
+{
+	alignas(uint64_t) uint8_t node_ip[FIB_VRF_IP_MAX_SZ];
+	void *node = ht->ops->rib_lookup(rib, ip);
+	uint8_t node_depth;
+
+	while (node != NULL) {
+		ht->ops->rib_get_prefix(node, node_ip, &node_depth);
+		if (node_depth < depth)
+			break;
+		node = ht->ops->rib_lookup_parent(node);
+	}
+	return node;
+}
+
+/* retrieve nexthop of the nearest ancestor of the node within a given VRF */
+static bool
+ancestor_nexthop(const struct fib_vrf_ht *ht, void *node, uint16_t vrf, uint64_t *nh)
+{
+	void *anc;
+
+	for (anc = ht->ops->rib_lookup_parent(node); anc != NULL;
+			anc = ht->ops->rib_lookup_parent(anc)) {
+		if (ext_get_nh(node_ext(ht, anc), vrf, nh))
+			return true;
+	}
+
+	return false;
+}
+
+static int
+node_move(struct fib_vrf_ht *ht, void *lpm, void *rib, void *node, uint32_t new_pid)
+{
+	struct fib_vrf_node_ext *ext = node_ext(ht, node);
+	alignas(uint64_t) uint8_t ip[FIB_VRF_IP_MAX_SZ];
+	uint32_t old_pid = node_pid(ht, node);
+	struct fib_vrf_slot s;
+	unsigned int k, n;
+	uint8_t depth;
+	int ret;
+
+	slot_first(&s);
+	for (n = 0; n < ext->num_recs; n++, slot_next(ext, &s)) {
+		ret = ht_upsert(ht, *slot_vrf(ext, &s), new_pid, *slot_nh(ext, &s));
+		if (ret != 0)
+			goto drop_records;
+	}
+
+	ret = rte_hash_add_key_data(ht->pid_map, &new_pid, node);
+	if (ret < 0)
+		goto drop_records;
+
+	/* Switch the LPM table to the new ID. */
+	ht->ops->rib_get_prefix(node, ip, &depth);
+	/* make sure all previous ht_upserts are visible before changing LPM part */
+	rte_atomic_thread_fence(rte_memory_order_release);
+	ret = ht->ops->lpm_modify(lpm, rib, ip, depth, new_pid, FIB_VRF_ADD);
+	if (ret != 0) {
+		rte_hash_del_key(ht->pid_map, &new_pid);
+		goto drop_records;
+	}
+
+	/* clean up old records with old prefix_id */
+	slot_first(&s);
+	for (k = 0; k < ext->num_recs; k++, slot_next(ext, &s))
+		ht_delete(ht, *slot_vrf(ext, &s), old_pid);
+
+	rte_hash_del_key(ht->pid_map, &old_pid);
+	node_mark_polarized(ht, node);
+
+	return 0;
+
+drop_records:
+	slot_first(&s);
+	for (k = 0; k < n; k++, slot_next(ext, &s))
+		ht_delete(ht, *slot_vrf(ext, &s), new_pid);
+
+	return ret;
+}
+
+/*
+ * Before a second VRF starts referencing a prefix whose single record sits in a
+ * polarized bucket, try to move that record to an unpolarized bucket by giving
+ * the prefix a new ID. The node is left untouched when no suitable prefix ID is
+ * available.
+ */
+static void
+node_relocate_if_polarized(struct fib_vrf_ht *ht, void *lpm, void *rib, void *node,
+	uint16_t new_vrf)
+{
+	struct fib_vrf_node_ext *ext = node_ext(ht, node);
+	uint16_t owner_vrf;
+	int ret;
+
+	if (ext->num_recs != 1 || ext->vrf[0] == new_vrf)
+		return;
+
+	owner_vrf = ext->vrf[0];
+	if (!bmp_get(ht->polarized_bmp,
+			fib_vrf_bucket_idx(ht, fib_vrf_key(owner_vrf, node_pid(ht, node)))))
+		return;
+
+	ret = pid_alloc(ht, owner_vrf, rte_rand_max(ht->mask + 1), true, NULL, new_vrf);
+	if (ret < 0)
+		return;
+
+	node_move(ht, lpm, rib, node, (uint32_t)ret);
+}
+
+static int
+record_upsert(struct fib_vrf_ht *ht, void *lpm, void *rib, uint16_t vrf,
+	uint32_t prefix_id, uint64_t next_hop)
+{
+	void *victims[FIB_VRF_HT_ASSOC];
+	const struct fib_vrf_bucket *b;
+	unsigned int i, j, n = 0;
+	int ret;
+
+	ret = ht_upsert(ht, vrf, prefix_id, next_hop);
+	if (ret != -ENOSPC)
+		return ret;
+
+	b = &ht->buckets[fib_vrf_bucket_idx(ht, fib_vrf_key(vrf, prefix_id))];
+	for (j = 0; j < FIB_VRF_HT_ASSOC; j++) {
+		uint32_t pid = (uint32_t)bucket_key(b, j);
+		void *node = pid_map_node(ht, pid);
+		uint16_t num_recs;
+
+		if (pid == prefix_id || node == NULL)
+			continue;
+
+		num_recs = node_ext(ht, node)->num_recs;
+
+		for (i = n; i > 0 && node_ext(ht, victims[i - 1])->num_recs > num_recs; i--)
+			victims[i] = victims[i - 1];
+		victims[i] = node;
+		n++;
+	}
+
+	for (i = 0; i < n; i++) {
+		struct fib_vrf_node_ext *ext = node_ext(ht, victims[i]);
+		uint32_t start = (ext->num_recs == 1) ? 0 : rte_rand_max(ht->mask + 1);
+
+		ret = pid_alloc(ht, ext->vrf[0], start, false, ext, FIB_VRF_NO_VRF);
+		if (ret < 0 || node_move(ht, lpm, rib, victims[i], (uint32_t)ret) != 0)
+			continue;
+
+		return ht_upsert(ht, vrf, prefix_id, next_hop);
+	}
+
+	return -ENOSPC;
+}
+
+/* Update the records of vrf in the prefixes covered by ip/depth that do not belong to vrf itself */
+static int
+subtree_set(struct fib_vrf_ht *ht, void *lpm, void *rib, const void *ip,
+	uint8_t depth, uint16_t vrf, uint64_t nh, bool have_nh)
+{
+	alignas(uint64_t) uint8_t child_ip[FIB_VRF_IP_MAX_SZ];
+	uint8_t child_depth;
+	void *child;
+	int ret;
+
+	for (child = ht->ops->rib_get_nxt_cover(rib, ip, depth, NULL);
+			child != NULL;
+			child = ht->ops->rib_get_nxt_cover(rib, ip, depth, child)) {
+		struct fib_vrf_node_ext *ext = node_ext(ht, child);
+
+		/* The subtree resolves through this route of vrf. */
+		if (ext_is_owner(ext, vrf))
+			continue;
+
+		if (have_nh) {
+			node_relocate_if_polarized(ht, lpm, rib, child, vrf);
+			ret = ext_set(ext, vrf, nh, false);
+			if (ret != 0)
+				return ret;
+			ret = record_upsert(ht, lpm, rib, vrf,
+				node_pid(ht, child), nh);
+			if (ret != 0)
+				return ret;
+			node_mark_polarized(ht, child);
+		} else {
+			ret = ext_del(ext, vrf);
+			/* Nothing inherited here, hence nothing below. */
+			if (ret == -ENOENT)
+				continue;
+			ht_delete(ht, vrf, node_pid(ht, child));
+			if (ret == 1)
+				node_refresh_polarized(ht, child);
+		}
+
+		ht->ops->rib_get_prefix(child, child_ip, &child_depth);
+		ret = subtree_set(ht, lpm, rib, child_ip, child_depth, vrf, nh, have_nh);
+		if (ret != 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+/* Retire a prefix whose last owner is gone, with all its records. */
+static int
+remove_node(struct fib_vrf_ht *ht, void *lpm, void *rib, void *node, const void *ip, uint8_t depth)
+{
+	struct fib_vrf_node_ext *ext = node_ext(ht, node);
+	struct fib_vrf_chunk *chunk, *next;
+	uint16_t inline_vrf[FIB_VRF_EXT_RECS];
+	uint32_t prefix_id = node_pid(ht, node);
+	unsigned int i;
+	int ret;
+
+	/* The node is freed by the LPM delete, save what is needed. */
+	memcpy(inline_vrf, ext->vrf, sizeof(inline_vrf));
+	chunk = ext->head;
+
+	ret = ht->ops->lpm_modify(lpm, rib, ip, depth, 0, FIB_VRF_DEL);
+	if (ret != 0)
+		return ret;
+
+	rte_hash_del_key(ht->pid_map, &prefix_id);
+
+	for (i = 0; i < FIB_VRF_EXT_RECS; i++) {
+		if (inline_vrf[i] != FIB_VRF_NO_VRF)
+			ht_delete(ht, inline_vrf[i], prefix_id);
+	}
+	for (; chunk != NULL; chunk = next) {
+		for (i = 0; i < FIB_VRF_CHUNK_RECS; i++) {
+			if (chunk->vrf[i] != FIB_VRF_NO_VRF)
+				ht_delete(ht, chunk->vrf[i], prefix_id);
+		}
+		next = chunk->next;
+		rte_free(chunk);
+	}
+
+	return 0;
+}
+
+/* Drop the records of a prefix ID the LPM table never exposed. */
+static void
+drop_new_records(struct fib_vrf_ht *ht, uint16_t vrf, uint32_t prefix_id,
+	struct fib_vrf_node_ext *inherit, unsigned int n_inherit)
+{
+	struct fib_vrf_slot s;
+	unsigned int k, done = 0;
+
+	ht_delete(ht, vrf, prefix_id);
+	if (inherit == NULL)
+		return;
+
+	slot_first(&s);
+	for (k = 0; k < inherit->num_recs && done < n_inherit; k++, slot_next(inherit, &s)) {
+		if (*slot_vrf(inherit, &s) == vrf)
+			continue;
+
+		ht_delete(ht, *slot_vrf(inherit, &s), prefix_id);
+		done++;
+	}
+}
+
+static int
+route_add_new(struct fib_vrf_ht *ht, void *lpm, void *rib, uint16_t vrf, const void *ip,
+	uint8_t depth, uint64_t next_hop)
+{
+	struct fib_vrf_node_ext *ext, *pext = NULL;
+	struct fib_vrf_slot s;
+	void *parent, *node;
+	uint64_t old_nh = 0;
+	uint32_t prefix_id;
+	unsigned int k, n_inherit = 0;
+	bool have_old = false;
+	int ret;
+
+	/*
+	 * The new prefix inherits every VRF referencing its nearest ancestor:
+	 * those VRFs keep resolving to the ancestor nexthop in its range.
+	 */
+	parent = nearest_ancestor(ht, rib, ip, depth);
+	if (parent != NULL) {
+		pext = node_ext(ht, parent);
+		have_old = ext_get_nh(pext, vrf, &old_nh);
+		n_inherit = pext->num_recs - (have_old ? 1 : 0);
+	}
+
+	/* A multi-VRF prefix goes to an unpolarized bucket if there is one. */
+	ret = -ENOSPC;
+	if (n_inherit > 0)
+		ret = pid_alloc(ht, vrf, 0, true, pext, FIB_VRF_NO_VRF);
+	if (ret < 0)
+		ret = pid_alloc(ht, vrf, 0, false, pext, FIB_VRF_NO_VRF);
+	if (ret < 0)
+		return ret;
+
+	prefix_id = (uint32_t)ret;
+
+	/* Records must resolve before the LPM table returns the ID. */
+	ret = ht_upsert(ht, vrf, prefix_id, next_hop);
+	if (ret != 0)
+		return ret;
+
+	if (pext != NULL) {
+		unsigned int done = 0;
+
+		slot_first(&s);
+		for (k = 0; k < pext->num_recs; k++, slot_next(pext, &s)) {
+			if (*slot_vrf(pext, &s) == vrf)
+				continue;
+			ret = ht_upsert(ht, *slot_vrf(pext, &s), prefix_id,
+				*slot_nh(pext, &s));
+			if (ret != 0) {
+				drop_new_records(ht, vrf, prefix_id, pext, done);
+				return ret;
+			}
+
+			done++;
+		}
+	}
+
+	/* The records must be visible before the LPM table returns the ID. */
+	rte_atomic_thread_fence(rte_memory_order_release);
+	ret = ht->ops->lpm_modify(lpm, rib, ip, depth, prefix_id, FIB_VRF_ADD);
+	if (ret != 0)
+		goto drop_records;
+
+	node = ht->ops->rib_lookup_exact(rib, ip, depth);
+	ext = node_ext(ht, node);
+	ext_init(ext);
+	ret = ext_reserve(ext, 1 + n_inherit);
+	if (ret != 0)
+		goto remove_lpm;
+
+	ext_set(ext, vrf, next_hop, true);
+	if (pext != NULL) {
+		slot_first(&s);
+		for (k = 0; k < pext->num_recs; k++, slot_next(pext, &s)) {
+			if (*slot_vrf(pext, &s) != vrf)
+				ext_set(ext, *slot_vrf(pext, &s), *slot_nh(pext, &s), false);
+		}
+	}
+
+	ret = rte_hash_add_key_data(ht->pid_map, &prefix_id, node);
+	if (ret < 0)
+		goto remove_lpm;
+
+	node_mark_polarized(ht, node);
+
+	/* Sub-prefixes that resolved vrf through the ancestor now use nh. */
+	ret = subtree_set(ht, lpm, rib, ip, depth, vrf, next_hop, true);
+	if (ret != 0) {
+		subtree_set(ht, lpm, rib, ip, depth, vrf, old_nh, have_old);
+		remove_node(ht, lpm, rib, node, ip, depth);
+		return ret;
+	}
+
+	return 0;
+
+remove_lpm:
+	ext_free_chunks(ext);
+	ht->ops->lpm_modify(lpm, rib, ip, depth, 0, FIB_VRF_DEL);
+drop_records:
+	drop_new_records(ht, vrf, prefix_id, pext, n_inherit);
+
+	return ret;
+}
+
+static int
+route_add_existing(struct fib_vrf_ht *ht, void *lpm, void *rib, void *node,
+	uint16_t vrf, const void *ip, uint8_t depth, uint64_t next_hop)
+{
+	struct fib_vrf_node_ext *ext = node_ext(ht, node);
+	uint64_t old_nh = 0;
+	uint32_t prefix_id;
+	bool have_old, was_owner;
+	int ret;
+
+	was_owner = ext_is_owner(ext, vrf);
+	have_old = ext_get_nh(ext, vrf, &old_nh);
+
+	if (!was_owner)
+		node_relocate_if_polarized(ht, lpm, rib, node, vrf);
+
+	prefix_id = node_pid(ht, node);
+
+	ret = ext_set(ext, vrf, next_hop, true);
+	if (ret != 0)
+		return ret;
+
+	ret = record_upsert(ht, lpm, rib, vrf, prefix_id, next_hop);
+	if (ret != 0) {
+		if (have_old)
+			ext_set(ext, vrf, old_nh, was_owner);
+		else
+			ext_del(ext, vrf);
+		return ret;
+	}
+
+	node_mark_polarized(ht, node);
+
+	if (was_owner && old_nh == next_hop)
+		return 0;
+
+	ret = subtree_set(ht, lpm, rib, ip, depth, vrf, next_hop, true);
+	if (ret != 0) {
+		subtree_set(ht, lpm, rib, ip, depth, vrf, old_nh, have_old);
+		/* Making room for the subtree records may have moved the node. */
+		prefix_id = node_pid(ht, node);
+		if (have_old) {
+			ext_set(ext, vrf, old_nh, was_owner);
+			ht_upsert(ht, vrf, prefix_id, old_nh);
+		} else {
+			ext_del(ext, vrf);
+			ht_delete(ht, vrf, prefix_id);
+		}
+
+		return ret;
+	}
+
+	return 0;
+}
+
+static int
+route_del(struct fib_vrf_ht *ht, void *lpm, void *rib, void *node,
+	uint16_t vrf, const void *ip, uint8_t depth)
+{
+	struct fib_vrf_node_ext *ext;
+	uint64_t ls_nh = 0;
+	bool have_less_specific;
+	int ret;
+
+	ext = node_ext(ht, node);
+	if (!ext_is_owner(ext, vrf))
+		return -ENOENT;
+
+	/* find nexthop of the less specific route covering given node for the given VRF */
+	have_less_specific = ancestor_nexthop(ht, node, vrf, &ls_nh);
+
+	if (ext_count_owners(ext) == 1) {
+		ret = remove_node(ht, lpm, rib, node, ip, depth);
+		if (ret != 0)
+			return ret;
+	} else {
+		uint32_t prefix_id = node_pid(ht, node);
+
+		if (have_less_specific) {
+			ext_set(ext, vrf, ls_nh, false);
+			ht_upsert(ht, vrf, prefix_id, ls_nh);
+		} else {
+			ext_del(ext, vrf);
+			ht_delete(ht, vrf, prefix_id);
+		}
+
+		if (ext->num_recs == 1)
+			node_refresh_polarized(ht, node);
+	}
+
+	/* Only updates and deletions are left, they cannot run out of space. */
+	return subtree_set(ht, lpm, rib, ip, depth, vrf, ls_nh, have_less_specific);
+}
+
+/* The default route is the per-VRF nexthop returned on a hash miss. */
+static void
+default_route_modify(struct fib_vrf_ht *ht, uint16_t vrf, uint64_t next_hop, enum fib_vrf_op op)
+{
+	ht->def_nh[vrf] = (op == FIB_VRF_ADD) ? next_hop : ht->conf_def_nh[vrf];
+}
+
+int
+fib_vrf_modify(struct fib_vrf_ht *ht, void *lpm, void *rib, void *vrf_rib, uint16_t vrf,
+	const void *ip, uint8_t depth, uint64_t next_hop, enum fib_vrf_op op)
+{
+	void *node, *vrf_node;
+	int ret = 0;
+	bool inserted = false;
+
+	if (ht == NULL || lpm == NULL || rib == NULL || vrf_rib == NULL ||
+			ip == NULL || vrf >= ht->num_vrfs)
+		return -EINVAL;
+
+	/* The RIB of the VRF mirrors its routes and tells which ones exist. */
+	vrf_node = ht->ops->rib_lookup_exact(vrf_rib, ip, depth);
+	switch (op) {
+	case FIB_VRF_ADD:
+		if (vrf_node == NULL) {
+			vrf_node = ht->ops->rib_insert(vrf_rib, ip, depth);
+			if (vrf_node == NULL)
+				return -rte_errno;
+
+			inserted = true;
+		}
+
+		if (depth == 0) {
+			default_route_modify(ht, vrf, next_hop, op);
+		} else {
+			node = ht->ops->rib_lookup_exact(rib, ip, depth);
+			if (node != NULL)
+				ret = route_add_existing(ht, lpm, rib, node, vrf,
+					ip, depth, next_hop);
+			else
+				ret = route_add_new(ht, lpm, rib, vrf, ip, depth, next_hop);
+		}
+
+		if (ret != 0 && inserted)
+			ht->ops->rib_remove(vrf_rib, ip, depth);
+
+		if (ret == 0)
+			ht->ops->rib_set_nh(vrf_node, next_hop);
+
+		break;
+	case FIB_VRF_DEL:
+		if (vrf_node == NULL)
+			return -ENOENT;
+
+		if (depth == 0)
+			default_route_modify(ht, vrf, next_hop, op);
+		else {
+			node = ht->ops->rib_lookup_exact(rib, ip, depth);
+			if (node == NULL)
+				return -ENOENT;
+
+			ret = route_del(ht, lpm, rib, node, vrf, ip, depth);
+		}
+
+		if (ret == 0)
+			ht->ops->rib_remove(vrf_rib, ip, depth);
+
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+size_t
+fib_vrf_rib_ext_sz(void)
+{
+	return sizeof(struct fib_vrf_node_ext);
+}
+
+static uint64_t *
+bitmap_alloc(const char *name, uint32_t nb_bits, int socket_id)
+{
+	return rte_zmalloc_socket(name, RTE_ALIGN_CEIL(nb_bits, 64) / 8,
+		RTE_CACHE_LINE_SIZE, socket_id);
+}
+
+int
+fib_vrf_ht_init(struct fib_vrf_ht *ht, const char *name, int socket_id,
+	const struct fib_vrf_ops *ops, uint16_t num_vrfs, uint64_t default_nh,
+	const uint64_t *vrf_default_nh, uint32_t max_routes)
+{
+	char mem_name[64];
+	struct rte_hash_parameters hash_params = {
+		.key_len = sizeof(uint32_t),
+		.hash_func = rte_hash_crc,
+		.socket_id = socket_id,
+	};
+	uint64_t nb_records, nb_buckets;
+	uint16_t v;
+
+	if (ht == NULL || name == NULL || ops == NULL || num_vrfs == 0 || max_routes == 0)
+		return -EINVAL;
+
+	memset(ht, 0, sizeof(*ht));
+	ht->ops = ops;
+	ht->num_vrfs = num_vrfs;
+
+	/*
+	 * Worst case every VRF references every prefix: size the table for
+	 * half load with that many records.
+	 */
+	nb_records = (uint64_t)max_routes * num_vrfs * 2;
+	nb_buckets = nb_records / FIB_VRF_HT_ASSOC;
+	nb_buckets = RTE_MAX(nb_buckets, RTE_BIT64(FIB_VRF_HT_MIN_LOG2));
+	nb_buckets = RTE_MIN(nb_buckets, RTE_BIT64(FIB_VRF_HT_MAX_LOG2));
+
+	ht->bits = rte_log2_u64(nb_buckets);
+	if (RTE_BIT64(ht->bits) < nb_buckets)
+		ht->bits++;
+	ht->mask = RTE_BIT32(ht->bits) - 1;
+
+	snprintf(mem_name, sizeof(mem_name), "VRF_HT_%s", name);
+	ht->buckets = rte_zmalloc_socket(mem_name,
+		sizeof(struct fib_vrf_bucket) * RTE_BIT64(ht->bits),
+		RTE_CACHE_LINE_SIZE, socket_id);
+
+	snprintf(mem_name, sizeof(mem_name), "VRF_FULL_%s", name);
+	ht->full_bmp = bitmap_alloc(mem_name, RTE_BIT32(ht->bits), socket_id);
+
+	snprintf(mem_name, sizeof(mem_name), "VRF_POL_%s", name);
+	ht->polarized_bmp = bitmap_alloc(mem_name, RTE_BIT32(ht->bits),
+		socket_id);
+
+	snprintf(mem_name, sizeof(mem_name), "VRF_DEFNH_%s", name);
+	ht->def_nh = rte_zmalloc_socket(mem_name,
+		sizeof(uint64_t) * num_vrfs * 2, RTE_CACHE_LINE_SIZE, socket_id);
+	if (ht->buckets == NULL || ht->full_bmp == NULL ||
+			ht->polarized_bmp == NULL || ht->def_nh == NULL)
+		goto nomem;
+
+	ht->conf_def_nh = ht->def_nh + num_vrfs;
+	for (v = 0; v < num_vrfs; v++) {
+		ht->def_nh[v] = (vrf_default_nh != NULL) ?
+			vrf_default_nh[v] : default_nh;
+		ht->conf_def_nh[v] = ht->def_nh[v];
+	}
+
+	snprintf(mem_name, sizeof(mem_name), "VRF_PID_%s", name);
+	hash_params.name = mem_name;
+	/* x1.5 should be enough */
+	hash_params.entries = RTE_MAX(max_routes + max_routes / 2, 64U);
+	ht->pid_map = rte_hash_create(&hash_params);
+	if (ht->pid_map == NULL)
+		goto nomem;
+
+	return 0;
+
+nomem:
+	fib_vrf_ht_free(ht, NULL);
+
+	return -ENOMEM;
+}
+
+void
+fib_vrf_ht_free(struct fib_vrf_ht *ht, void *rib)
+{
+	void *node;
+
+	if (ht == NULL)
+		return;
+
+	/* Records of prefixes still present, chained outside the RIB nodes. */
+	if (rib != NULL) {
+		for (node = ht->ops->rib_walk(rib, NULL); node != NULL;
+				node = ht->ops->rib_walk(rib, node))
+			ext_free_chunks(node_ext(ht, node));
+	}
+
+	rte_hash_free(ht->pid_map);
+	rte_free(ht->def_nh);
+	rte_free(ht->polarized_bmp);
+	rte_free(ht->full_bmp);
+	rte_free(ht->buckets);
+	memset(ht, 0, sizeof(*ht));
+}
diff --git a/lib/fib/fib_vrf.h b/lib/fib/fib_vrf.h
new file mode 100644
index 0000000000..ea6a2bc09e
--- /dev/null
+++ b/lib/fib/fib_vrf.h
@@ -0,0 +1,277 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+#ifndef _FIB_VRF_H_
+#define _FIB_VRF_H_
+
+/**
+ * @file
+ * Hash based VRF resolution shared by the DIR24_8 (IPv4) and TRIE (IPv6)
+ * dataplanes.
+ *
+ * All VRFs share a single LPM table mapping an address to the prefix ID of the
+ * longest prefix present in any VRF (0 meaning no route at all). A hash table
+ * then maps (VRF, prefix ID) to the nexthop this VRF resolves to for that
+ * prefix, and a miss returns the per-VRF default nexthop.
+ *
+ * The dataplane keeps an internal RIB holding the prefixes of all the VRFs,
+ * with the prefix ID as node nexthop. Every node carries a fib_vrf_node_ext
+ * listing the VRFs that have a route either at the node prefix (owner records)
+ * or at a covering prefix (inherited records), together with the nexthop each
+ * of them resolves to. The invariant maintained by fib_vrf_modify() is: for
+ * every node N and every VRF V having a route covering N, the hash table holds
+ * (V, pid(N)) -> nexthop of the longest such route, and no record exists for
+ * VRFs without a covering route. The per-VRF RIBs exposed to the user are
+ * mirrors of the routes of each VRF and are maintained alongside.
+ *
+ * The address family specific bits (RIB access, LPM table update) are
+ * abstracted through fib_vrf_ops, so the same code drives both dataplanes.
+ */
+
+#include <stdalign.h>
+#include <stdbool.h>
+#include <stdint.h>
+
+#include <rte_branch_prediction.h>
+#include <rte_common.h>
+#include <rte_hash_crc.h>
+#include <rte_prefetch.h>
+#include <rte_stdatomic.h>
+
+/** Number of records per hash bucket. */
+#define FIB_VRF_HT_ASSOC	8
+/** Largest address (in bytes) handled by the generic modify code. */
+#define FIB_VRF_IP_MAX_SZ	16
+/** Prefix IDs are stored in 4 byte LPM entries with one flag bit. */
+#define FIB_VRF_PREFIX_ID_MAX	((1U << 31) - 1)
+
+struct rte_hash;
+
+enum fib_vrf_op {
+	FIB_VRF_ADD,
+	FIB_VRF_DEL,
+};
+
+/**
+ * Address family specific operations. Addresses are passed as opaque pointers
+ * (uint32_t for IPv4, struct rte_ipv6_addr for IPv6). Node handles are opaque
+ * RIB node pointers.
+ */
+struct fib_vrf_ops {
+	/** Longest prefix match in the RIB, NULL if none. */
+	void *(*rib_lookup)(void *rib, const void *ip);
+	/** Exact match in the RIB, NULL if none. */
+	void *(*rib_lookup_exact)(void *rib, const void *ip, uint8_t depth);
+	/** Nearest valid ancestor of a node, NULL if none. */
+	void *(*rib_lookup_parent)(void *node);
+	/**
+	 * Iterate over the prefixes directly covered by ip/depth (the
+	 * RTE_RIB_GET_NXT_COVER semantic), last == NULL starts the walk.
+	 */
+	void *(*rib_get_nxt_cover)(void *rib, const void *ip, uint8_t depth,
+		void *last);
+	/** Iterate over all the prefixes of the RIB, last == NULL starts. */
+	void *(*rib_walk)(void *rib, void *last);
+	/** Insert a prefix in the RIB, NULL on failure with rte_errno set. */
+	void *(*rib_insert)(void *rib, const void *ip, uint8_t depth);
+	/** Remove a prefix from the RIB. */
+	void (*rib_remove)(void *rib, const void *ip, uint8_t depth);
+	/** Copy the node prefix into ip (FIB_VRF_IP_MAX_SZ bytes) and depth. */
+	void (*rib_get_prefix)(const void *node, void *ip, uint8_t *depth);
+	/** Node nexthop, i.e. its prefix ID in the internal RIB. */
+	uint64_t (*rib_get_nh)(const void *node);
+	/** Set the node nexthop. */
+	void (*rib_set_nh)(void *node, uint64_t nh);
+	/** Node user extension area. */
+	void *(*rib_get_ext)(void *node);
+	/**
+	 * Install (op == FIB_VRF_ADD, inserting the RIB node) or remove
+	 * (op == FIB_VRF_DEL, removing the RIB node) ip/depth in the LPM table
+	 * with prefix_id as its value.
+	 */
+	int (*lpm_modify)(void *lpm, void *rib, const void *ip, uint8_t depth,
+		uint64_t prefix_id, enum fib_vrf_op op);
+};
+
+struct __rte_cache_aligned fib_vrf_bucket {
+	RTE_ATOMIC(uint64_t) key[FIB_VRF_HT_ASSOC];
+	uint64_t val[FIB_VRF_HT_ASSOC];
+};
+
+struct fib_vrf_ht {
+	/* Lookup fast path. */
+	struct fib_vrf_bucket *buckets;
+	uint64_t *def_nh;		/**< Per-VRF default nexthop. */
+	uint32_t mask;			/**< Number of buckets - 1. */
+	uint16_t num_vrfs;
+	/* Control path. */
+	uint32_t bits;			/**< log2 of the number of buckets. */
+	uint64_t *full_bmp;		/**< Bit set: bucket has no free slot. */
+	/** Bit set: bucket holds a record of a multi-VRF prefix. */
+	uint64_t *polarized_bmp;
+	uint64_t *conf_def_nh;		/**< Configured default nexthops. */
+	struct rte_hash *pid_map;	/**< prefix ID -> RIB node. */
+	const struct fib_vrf_ops *ops;
+};
+
+static inline uint64_t
+fib_vrf_key(uint16_t vrf, uint32_t prefix_id)
+{
+	return (uint64_t)vrf << 32 | prefix_id;
+}
+
+static inline uint32_t
+fib_vrf_bucket_idx(const struct fib_vrf_ht *ht, uint64_t key)
+{
+	return rte_hash_crc_8byte(key, 0) & ht->mask;
+}
+
+/*
+ * A record is published by writing its value before its key. The acquire
+ * load (a plain load on x86) makes sure that the value read after a key match
+ * is not an older one, as a plain load reordered before the key load could be
+ * on weakly ordered architectures.
+ */
+static inline uint64_t
+fib_vrf_bucket_search(const struct fib_vrf_ht *ht,
+	const struct fib_vrf_bucket *b, uint64_t key, uint16_t vrf)
+{
+	unsigned int j;
+
+	for (j = 0; j < FIB_VRF_HT_ASSOC; j++) {
+		if (rte_atomic_load_explicit(&b->key[j],
+				rte_memory_order_acquire) == key)
+			return b->val[j];
+	}
+	return ht->def_nh[vrf];
+}
+
+/**
+ * Resolve the nexthop of one VRF for the prefix ID returned by the LPM table.
+ */
+static inline uint64_t
+fib_vrf_ht_lookup(const struct fib_vrf_ht *ht, uint16_t vrf,
+	uint32_t prefix_id)
+{
+	uint64_t key;
+
+	if (unlikely(prefix_id == 0))
+		return ht->def_nh[vrf];
+	key = fib_vrf_key(vrf, prefix_id);
+	return fib_vrf_bucket_search(ht, &ht->buckets[fib_vrf_bucket_idx(ht, key)],
+		key, vrf);
+}
+
+#define FIB_VRF_RESOLVE_BURST	32
+
+/* Resolve up to FIB_VRF_RESOLVE_BURST prefix IDs, prefetching their buckets. */
+static inline void
+fib_vrf_ht_resolve_burst(const struct fib_vrf_ht *ht, const uint16_t *vrfs,
+	uint64_t *next_hops, unsigned int n)
+{
+	uint64_t keys[FIB_VRF_RESOLVE_BURST];
+	uint32_t bidx[FIB_VRF_RESOLVE_BURST];
+	unsigned int j;
+
+	for (j = 0; j < n; j++) {
+		keys[j] = fib_vrf_key(vrfs[j], (uint32_t)next_hops[j]);
+		bidx[j] = fib_vrf_bucket_idx(ht, keys[j]);
+		rte_prefetch0(&ht->buckets[bidx[j]]);
+	}
+	for (j = 0; j < n; j++) {
+		if (unlikely((uint32_t)next_hops[j] == 0)) {
+			next_hops[j] = ht->def_nh[vrfs[j]];
+			continue;
+		}
+		next_hops[j] = fib_vrf_bucket_search(ht, &ht->buckets[bidx[j]],
+			keys[j], vrfs[j]);
+	}
+}
+
+/**
+ * Turn the prefix IDs returned by the LPM table into nexthops in place.
+ *
+ * @param ht
+ *   Hash table.
+ * @param vrfs
+ *   Per address VRF, NULL means VRF 0 for every address.
+ * @param next_hops
+ *   Prefix IDs on entry (0 = no route), nexthops on return.
+ * @param n
+ *   Number of addresses.
+ */
+static inline void
+fib_vrf_ht_resolve(const struct fib_vrf_ht *ht, const uint16_t *vrfs,
+	uint64_t *next_hops, unsigned int n)
+{
+	unsigned int i;
+
+	if (unlikely(vrfs == NULL)) {
+		for (i = 0; i < n; i++)
+			next_hops[i] = fib_vrf_ht_lookup(ht, 0,
+				(uint32_t)next_hops[i]);
+		return;
+	}
+
+	for (i = 0; i + FIB_VRF_RESOLVE_BURST <= n; i += FIB_VRF_RESOLVE_BURST)
+		fib_vrf_ht_resolve_burst(ht, vrfs + i, next_hops + i,
+			FIB_VRF_RESOLVE_BURST);
+	if (i < n)
+		fib_vrf_ht_resolve_burst(ht, vrfs + i, next_hops + i, n - i);
+}
+
+#ifdef CC_AVX512_SUPPORT
+/** AVX512 flavour of fib_vrf_ht_resolve(). */
+void
+fib_vrf_ht_resolve_avx512(const struct fib_vrf_ht *ht, const uint16_t *vrfs,
+	uint64_t *next_hops, unsigned int n);
+#endif
+
+/** Size of the node extension of the internal RIB. */
+size_t
+fib_vrf_rib_ext_sz(void);
+
+/**
+ * Initialize a hash table. The LPM table must return prefix IDs allocated by
+ * fib_vrf_modify() and 0 for addresses without any route.
+ *
+ * @param num_vrfs
+ *   Number of VRFs, at least 1.
+ * @param default_nh
+ *   Default nexthop of every VRF, unless vrf_default_nh is set.
+ * @param vrf_default_nh
+ *   Optional per-VRF default nexthops (num_vrfs entries).
+ * @param max_routes
+ *   Maximum number of distinct prefixes (across all VRFs).
+ */
+int
+fib_vrf_ht_init(struct fib_vrf_ht *ht, const char *name, int socket_id,
+	const struct fib_vrf_ops *ops, uint16_t num_vrfs, uint64_t default_nh,
+	const uint64_t *vrf_default_nh, uint32_t max_routes);
+
+/**
+ * Release the hash table resources and the node extensions of the internal
+ * RIB, which must still be intact.
+ */
+void
+fib_vrf_ht_free(struct fib_vrf_ht *ht, void *rib);
+
+/**
+ * Add or delete a route of one VRF. ip must be masked to depth already.
+ *
+ * @param ht
+ *   Hash table.
+ * @param lpm
+ *   LPM table shared by all the VRFs.
+ * @param rib
+ *   Internal RIB holding the prefixes of all the VRFs.
+ * @param vrf_rib
+ *   RIB of the VRF, mirroring its routes.
+ */
+int
+fib_vrf_modify(struct fib_vrf_ht *ht, void *lpm, void *rib, void *vrf_rib,
+	uint16_t vrf, const void *ip, uint8_t depth, uint64_t next_hop,
+	enum fib_vrf_op op);
+
+#endif /* _FIB_VRF_H_ */
diff --git a/lib/fib/fib_vrf_avx512.c b/lib/fib/fib_vrf_avx512.c
new file mode 100644
index 0000000000..4a4d3b604a
--- /dev/null
+++ b/lib/fib/fib_vrf_avx512.c
@@ -0,0 +1,142 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+#include <stdalign.h>
+
+#include <rte_bitops.h>
+#include <rte_vect.h>
+
+#include "fib_vrf.h"
+
+/* log2(sizeof(struct fib_vrf_bucket)) */
+#define BUCKET_SHIFT	7
+
+/* Chunks of 8 lookups hashed, and their buckets prefetched, ahead of search. */
+#define RESOLVE_AHEAD	3
+/* Hashed chunks kept for the search, a power of 2 above RESOLVE_AHEAD. */
+#define RESOLVE_RING	4
+
+/*
+ * Barrett reduction of the bit-reflected CRC32C of a 64-bit key: x^96 / P
+ * without its x^64 term, and P placing the remainder in bits 64-95.
+ */
+#define CRC32C_MU	0xa434f61c6f5389f8ULL
+#define CRC32C_POLY	0x105ec76f0ULL
+
+/* Searched for the prefix ID 0 (no route at all), never matches a key. */
+static const struct fib_vrf_bucket no_route_bucket = {
+	.key = { UINT64_MAX, UINT64_MAX, UINT64_MAX, UINT64_MAX,
+		UINT64_MAX, UINT64_MAX, UINT64_MAX, UINT64_MAX },
+};
+
+/* rte_hash_crc_8byte(key, 0) of 8 keys, in the low 32 bits of each lane. */
+static inline __m512i
+crc32c_x8(__m512i keys)
+{
+	const __m512i mu = _mm512_set1_epi64(CRC32C_MU);
+	const __m512i poly = _mm512_set1_epi64(CRC32C_POLY);
+	__m512i even, odd, quot;
+
+	/* The x^64 term of the constant contributes the key itself. */
+	even = _mm512_clmulepi64_epi128(keys, mu, 0x00);
+	odd = _mm512_clmulepi64_epi128(keys, mu, 0x01);
+	quot = _mm512_xor_si512(keys,
+		_mm512_slli_epi64(_mm512_unpacklo_epi64(even, odd), 1));
+
+	even = _mm512_clmulepi64_epi128(quot, poly, 0x00);
+	odd = _mm512_clmulepi64_epi128(quot, poly, 0x01);
+	return _mm512_unpackhi_epi64(even, odd);
+}
+
+/* Prefetch from registers: reloading the vector just stored stalls. */
+static inline void
+prefetch_x8(__m512i ptrs)
+{
+	__m256i lo = _mm512_castsi512_si256(ptrs);
+	__m256i hi = _mm512_extracti64x4_epi64(ptrs, 1);
+	__m128i p[4] = {
+		_mm256_castsi256_si128(lo), _mm256_extracti128_si256(lo, 1),
+		_mm256_castsi256_si128(hi), _mm256_extracti128_si256(hi, 1),
+	};
+	unsigned int i;
+
+	for (i = 0; i < RTE_DIM(p); i++) {
+		rte_prefetch0((const void *)_mm_cvtsi128_si64(p[i]));
+		rte_prefetch0((const void *)_mm_extract_epi64(p[i], 1));
+	}
+}
+
+/* Hash 8 lookups: store their keys and buckets, and prefetch the buckets. */
+static inline void
+hash_x8(const struct fib_vrf_ht *ht, const uint16_t *vrfs,
+	const uint64_t *next_hops, uint64_t *keys,
+	const struct fib_vrf_bucket **bkt)
+{
+	__m512i nh = _mm512_loadu_si512(next_hops);
+	__m512i vrf = (vrfs != NULL) ? _mm512_cvtepu16_epi64(
+		_mm_loadu_si128((const __m128i *)vrfs)) : _mm512_setzero_si512();
+	__m512i key = _mm512_or_si512(_mm512_slli_epi64(vrf, 32), nh);
+	__m512i ptr = _mm512_add_epi64(_mm512_set1_epi64((uintptr_t)ht->buckets),
+		_mm512_and_si512(_mm512_slli_epi64(crc32c_x8(key), BUCKET_SHIFT),
+			_mm512_set1_epi64((uint64_t)ht->mask << BUCKET_SHIFT)));
+
+	ptr = _mm512_mask_mov_epi64(ptr, _mm512_testn_epi64_mask(nh, nh),
+		_mm512_set1_epi64((uintptr_t)&no_route_bucket));
+	_mm512_store_si512(keys, key);
+	_mm512_store_si512(bkt, ptr);
+	prefetch_x8(ptr);
+}
+
+/* Search 8 hashed lookups in their buckets. */
+static inline void
+search_x8(const struct fib_vrf_ht *ht, const uint16_t *vrfs,
+	const uint64_t *keys, const struct fib_vrf_bucket * const *bkt,
+	uint64_t *next_hops)
+{
+	unsigned int i;
+
+	for (i = 0; i < 8; i++) {
+		const struct fib_vrf_bucket *b = bkt[i];
+		/* The keys are read as plain memory, like the LPM table entries. */
+		__mmask8 match = _mm512_cmpeq_epi64_mask(
+			_mm512_loadu_si512(RTE_CAST_PTR(const void *, b->key)),
+			_mm512_set1_epi64(keys[i]));
+
+		if (unlikely(match == 0))
+			next_hops[i] = ht->def_nh[(vrfs != NULL) ? vrfs[i] : 0];
+		else
+			next_hops[i] = b->val[rte_ctz32(match)];
+	}
+}
+
+void
+fib_vrf_ht_resolve_avx512(const struct fib_vrf_ht *ht, const uint16_t *vrfs,
+	uint64_t *next_hops, unsigned int n)
+{
+	alignas(64) uint64_t keys[RESOLVE_RING][8];
+	alignas(64) const struct fib_vrf_bucket *bkt[RESOLVE_RING][8];
+	unsigned int nb = RTE_ALIGN_FLOOR(n, 8);
+	unsigned int i, s;
+
+	RTE_BUILD_BUG_ON(sizeof(struct fib_vrf_bucket) != RTE_BIT32(BUCKET_SHIFT));
+	RTE_BUILD_BUG_ON(RESOLVE_AHEAD >= RESOLVE_RING);
+
+	for (i = 0; i < nb + RESOLVE_AHEAD * 8; i += 8) {
+		if (i < nb) {
+			s = (i / 8) % RESOLVE_RING;
+			hash_x8(ht, (vrfs != NULL) ? vrfs + i : NULL, next_hops + i,
+				keys[s], bkt[s]);
+		}
+		if (i >= RESOLVE_AHEAD * 8) {
+			unsigned int c = i - RESOLVE_AHEAD * 8;
+
+			s = (c / 8) % RESOLVE_RING;
+			search_x8(ht, (vrfs != NULL) ? vrfs + c : NULL, keys[s],
+				bkt[s], next_hops + c);
+		}
+	}
+	for (i = nb; i < n; i++)
+		next_hops[i] = fib_vrf_ht_lookup(ht, (vrfs != NULL) ? vrfs[i] : 0,
+			(uint32_t)next_hops[i]);
+}
diff --git a/lib/fib/meson.build b/lib/fib/meson.build
index f24f679039..1b8ab4859a 100644
--- a/lib/fib/meson.build
+++ b/lib/fib/meson.build
@@ -2,14 +2,32 @@
 # Copyright(c) 2018 Vladimir Medvedkin <medvedkinv@gmail.com>
 # Copyright(c) 2019 Intel Corporation
 
-sources = files('rte_fib.c', 'rte_fib6.c', 'dir24_8.c', 'dir8_16_8.c', 'trie.c')
+sources = files(
+        'dir24_8.c',
+        'dir24_8_vrf.c',
+        'dir8_16_8.c',
+        'fib_vrf.c',
+        'rte_fib.c',
+        'rte_fib6.c',
+        'trie.c',
+)
 headers = files('rte_fib.h', 'rte_fib6.h')
 deps += ['rib']
 deps += ['rcu']
 deps += ['net']
+deps += ['hash']
 
 if dpdk_conf.has('RTE_ARCH_X86_64')
-    sources_avx512 += files('dir24_8_avx512.c', 'dir8_16_8_avx512.c', 'trie_avx512.c')
+    sources_avx512 += files(
+            'dir24_8_avx512.c',
+            'dir8_16_8_avx512.c',
+            'fib_vrf_avx512.c',
+            'trie_avx512.c',
+    )
+    # the VRF lookups hash the keys with VPCLMULQDQ
+    if cc.has_argument('-mvpclmulqdq')
+        cflags_avx512 += ['-mvpclmulqdq']
+    endif
 elif dpdk_conf.has('RTE_ARCH_RISCV')
     sources += files('dir24_8_rvv.c')
 endif
diff --git a/lib/fib/rte_fib.c b/lib/fib/rte_fib.c
index 795031edcd..ac7f1b133b 100644
--- a/lib/fib/rte_fib.c
+++ b/lib/fib/rte_fib.c
@@ -4,6 +4,7 @@
  */
 
 #include <stdint.h>
+#include <stdbool.h>
 #include <string.h>
 #include <sys/queue.h>
 
@@ -16,8 +17,11 @@
 
 #include <rte_rib.h>
 #include <rte_fib.h>
+#include <rte_vect.h>
+#include <rte_cpuflags.h>
 
 #include "dir24_8.h"
+#include "dir24_8_vrf.h"
 #include "dir8_16_8.h"
 #include "fib_log.h"
 
@@ -50,6 +54,13 @@ struct rte_fib {
 	uint16_t		max_vrfs; /**< Number of VRFs (0/1 = single). */
 };
 
+/* Multi-VRF DIR24_8 shares one RIB and resolves VRFs through a hash table. */
+static inline bool
+fib_is_dir24_8_vrf(const struct rte_fib *fib)
+{
+	return fib->type == RTE_FIB_DIR24_8 && fib->max_vrfs > 1;
+}
+
 static void
 dummy_lookup(void *fib_p, const uint16_t *vrf_ids __rte_unused,
 	const uint32_t *ips, uint64_t *next_hops, const unsigned int n)
@@ -107,12 +118,23 @@ init_dataplane(struct rte_fib *fib, __rte_unused int socket_id,
 		fib->modify = dummy_modify;
 		return 0;
 	case RTE_FIB_DIR24_8:
-		fib->dp = dir24_8_create(dp_name, socket_id, conf);
-		if (fib->dp == NULL)
-			return -rte_errno;
-		fib->lookup = dir24_8_get_lookup_fn(fib->dp,
-			RTE_FIB_LOOKUP_DEFAULT, !!(fib->flags & RTE_FIB_F_LOOKUP_NETWORK_ORDER));
-		fib->modify = dir24_8_modify;
+		if (fib_is_dir24_8_vrf(fib)) {
+			fib->dp = dir24_8_vrf_create(dp_name, socket_id, conf);
+			if (fib->dp == NULL)
+				return -rte_errno;
+			fib->lookup = dir24_8_vrf_get_lookup_fn(fib->dp,
+				RTE_FIB_LOOKUP_DEFAULT,
+				!!(fib->flags & RTE_FIB_F_LOOKUP_NETWORK_ORDER));
+			fib->modify = dir24_8_vrf_modify;
+		} else {
+			fib->dp = dir24_8_create(dp_name, socket_id, conf);
+			if (fib->dp == NULL)
+				return -rte_errno;
+			fib->lookup = dir24_8_get_lookup_fn(fib->dp,
+				RTE_FIB_LOOKUP_DEFAULT,
+				!!(fib->flags & RTE_FIB_F_LOOKUP_NETWORK_ORDER));
+			fib->modify = dir24_8_modify;
+		}
 		return 0;
 	case RTE_FIB_DIR8_16_8:
 		fib->dp = dir8_16_8_create(dp_name, socket_id, conf);
@@ -165,19 +187,14 @@ rte_fib_lookup_bulk(struct rte_fib *fib, uint32_t *ips,
 static void
 free_dataplane(struct rte_fib *fib);
 
-/*
- * Allocate the RIB array and create the FIB's RIBs: ribs[0] is the main RIB
- * (named after the FIB), plus one independent RIB per extra VRF. A single-VRF
- * FIB still keeps a one-element array so ribs[0] is always the main RIB.
- */
 static int
 fib_create_ribs(struct rte_fib *fib, const char *name,
 	const struct rte_rib_conf *rib_conf, int socket_id)
 {
-	uint16_t v, num_vrfs = RTE_MAX(fib->max_vrfs, 1);
+	uint16_t v, num_ribs = RTE_MAX(fib->max_vrfs, 1);
 
 	fib->ribs = rte_zmalloc_socket(NULL,
-		(size_t)num_vrfs * sizeof(struct rte_rib *),
+		(size_t)num_ribs * sizeof(struct rte_rib *),
 		RTE_CACHE_LINE_SIZE, socket_id);
 	if (fib->ribs == NULL)
 		return -ENOMEM;
@@ -186,12 +203,7 @@ fib_create_ribs(struct rte_fib *fib, const char *name,
 	if (fib->ribs[0] == NULL)
 		return -rte_errno;
 
-	for (v = 1; v < num_vrfs; v++) {
-		/*
-		 * Derive a short unique RIB name from the FIB pointer: the
-		 * user name plus a "_vN" suffix could overflow the RIB name
-		 * length limit.
-		 */
+	for (v = 1; v < num_ribs; v++) {
 		char rib_name[RTE_FIB_NAMESIZE];
 
 		snprintf(rib_name, sizeof(rib_name), "%p-v%u", (void *)fib, v);
@@ -199,18 +211,18 @@ fib_create_ribs(struct rte_fib *fib, const char *name,
 		if (fib->ribs[v] == NULL)
 			return -rte_errno;
 	}
+
 	return 0;
 }
 
-/* Free every RIB and the RIB array. */
 static void
 fib_free_ribs(struct rte_fib *fib)
 {
-	uint16_t v, num_vrfs = RTE_MAX(fib->max_vrfs, 1);
+	uint16_t v, num_ribs = RTE_MAX(fib->max_vrfs, 1);
 
 	if (fib->ribs == NULL)
 		return;
-	for (v = 0; v < num_vrfs; v++)
+	for (v = 0; v < num_ribs; v++)
 		rte_rib_free(fib->ribs[v]);
 	rte_free(fib->ribs);
 	fib->ribs = NULL;
@@ -233,7 +245,8 @@ rte_fib_create(const char *name, int socket_id, struct rte_fib_conf *conf)
 			(conf->flags & ~RTE_FIB_ALLOWED_FLAGS) ||
 			(conf->type > RTE_FIB_DIR8_16_8) ||
 			(conf->max_vrfs >= 2 &&
-				conf->type != RTE_FIB_DIR8_16_8)) {
+				conf->type != RTE_FIB_DIR8_16_8 &&
+				conf->type != RTE_FIB_DIR24_8)) {
 		rte_errno = EINVAL;
 		return NULL;
 	}
@@ -243,7 +256,6 @@ rte_fib_create(const char *name, int socket_id, struct rte_fib_conf *conf)
 
 	snprintf(mem_name, sizeof(mem_name), "FIB_%s", name);
 
-	/* allocate tailq entry */
 	te = rte_zmalloc("FIB_TAILQ_ENTRY", sizeof(*te), 0);
 	if (te == NULL) {
 		FIB_LOG(ERR,
@@ -252,7 +264,6 @@ rte_fib_create(const char *name, int socket_id, struct rte_fib_conf *conf)
 		return NULL;
 	}
 
-	/* Allocate memory to store the FIB data structures. */
 	fib = rte_zmalloc_socket(mem_name,
 		sizeof(struct rte_fib),	RTE_CACHE_LINE_SIZE, socket_id);
 	if (fib == NULL) {
@@ -287,7 +298,6 @@ rte_fib_create(const char *name, int socket_id, struct rte_fib_conf *conf)
 
 	rte_mcfg_tailq_write_lock();
 
-	/* guarantee there's no existing */
 	TAILQ_FOREACH(tmp_te, fib_list, next) {
 		if (strncmp(name, ((struct rte_fib *)tmp_te->data)->name,
 				RTE_FIB_NAMESIZE) == 0) {
@@ -305,8 +315,9 @@ rte_fib_create(const char *name, int socket_id, struct rte_fib_conf *conf)
 	return fib;
 
 free_ribs:
-	fib_free_ribs(fib);
+	/* The dataplane may hold references to RIB nodes, free it first. */
 	free_dataplane(fib);
+	fib_free_ribs(fib);
 free_fib:
 	rte_free(fib);
 free_te:
@@ -348,7 +359,10 @@ free_dataplane(struct rte_fib *fib)
 	case RTE_FIB_DUMMY:
 		return;
 	case RTE_FIB_DIR24_8:
-		dir24_8_free(fib->dp);
+		if (fib_is_dir24_8_vrf(fib))
+			dir24_8_vrf_free(fib->dp);
+		else
+			dir24_8_free(fib->dp);
 		return;
 	case RTE_FIB_DIR8_16_8:
 		dir8_16_8_free(fib->dp);
@@ -372,7 +386,6 @@ rte_fib_free(struct rte_fib *fib)
 
 	rte_mcfg_tailq_write_lock();
 
-	/* find our tailq entry */
 	TAILQ_FOREACH(te, fib_list, next) {
 		if (te->data == (void *)fib)
 			break;
@@ -411,8 +424,12 @@ rte_fib_select_lookup(struct rte_fib *fib,
 
 	switch (fib->type) {
 	case RTE_FIB_DIR24_8:
-		fn = dir24_8_get_lookup_fn(fib->dp, type,
-			!!(fib->flags & RTE_FIB_F_LOOKUP_NETWORK_ORDER));
+		if (fib_is_dir24_8_vrf(fib))
+			fn = dir24_8_vrf_get_lookup_fn(fib->dp, type,
+				!!(fib->flags & RTE_FIB_F_LOOKUP_NETWORK_ORDER));
+		else
+			fn = dir24_8_get_lookup_fn(fib->dp, type,
+				!!(fib->flags & RTE_FIB_F_LOOKUP_NETWORK_ORDER));
 		if (fn == NULL)
 			return -EINVAL;
 		fib->lookup = fn;
@@ -438,6 +455,8 @@ rte_fib_rcu_qsbr_add(struct rte_fib *fib, struct rte_fib_rcu_config *cfg)
 
 	switch (fib->type) {
 	case RTE_FIB_DIR24_8:
+		if (fib_is_dir24_8_vrf(fib))
+			return -ENOTSUP;
 		return dir24_8_rcu_qsbr_add(fib->dp, cfg, fib->name);
 	case RTE_FIB_DIR8_16_8:
 		return dir8_16_8_rcu_qsbr_add(fib->dp, cfg, fib->name);
diff --git a/lib/fib/rte_fib.h b/lib/fib/rte_fib.h
index 948bef7600..0094afc269 100644
--- a/lib/fib/rte_fib.h
+++ b/lib/fib/rte_fib.h
@@ -94,8 +94,12 @@ enum rte_fib_lookup_type {
 	/**<
 	 * Scalar implementation for the DIR8_16_8 algorithm
 	 */
-	RTE_FIB_LOOKUP_DIR8_16_8_VECTOR_AVX512
+	RTE_FIB_LOOKUP_DIR8_16_8_VECTOR_AVX512,
 	/**< Vector (AVX512) lookup for the DIR8_16_8 algorithm */
+	RTE_FIB_LOOKUP_DIR24_8_VRF_SCALAR,
+	/**< Scalar lookup for the VRF-capable DIR24_8 algorithm */
+	RTE_FIB_LOOKUP_DIR24_8_VRF_VECTOR_AVX512
+	/**< Vector (AVX512) lookup for the VRF-capable DIR24_8 algorithm */
 };
 
 /** If set, fib lookup is expecting IPv4 address in network byte order */
@@ -124,8 +128,15 @@ struct rte_fib_conf {
 	};
 	unsigned int flags; /**< Optional feature flags from RTE_FIB_F_* */
 	/**
-	 * Number of VRFs to support. 0 or 1 means a single (default) VRF.
-	 * Values >= 2 require RTE_FIB_DIR8_16_8.
+	 * Number of VRFs to support. 0 or 1 means a single VRF.
+	 * Values >= 2 require RTE_FIB_DIR24_8 or RTE_FIB_DIR8_16_8.
+	 *
+	 * RTE_FIB_DIR8_16_8 keeps a root table per VRF.
+	 *
+	 * RTE_FIB_DIR24_8 shares a single DIR24_8 table across VRFs and
+	 * resolves the per-VRF nexthops through a hash table: max_routes is
+	 * then the number of distinct prefixes across all VRFs and
+	 * dir24_8.nh_sz must be RTE_FIB_DIR24_8_8B.
 	 */
 	uint16_t max_vrfs;
 	/**
@@ -239,6 +250,7 @@ rte_fib_delete(struct rte_fib *fib, uint32_t ip, uint8_t depth);
  *   This is an array of eight byte values.
  *   If the lookup for the given IP failed, then corresponding element would
  *   contain default nexthop value configured for a FIB.
+ *   For a multi-VRF FIB, all addresses are looked up in VRF 0.
  * @param n
  *   Number of elements in ips (and next_hops) array to lookup.
  *  @return
-- 
2.43.0

