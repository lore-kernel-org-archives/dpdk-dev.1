Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9E7FC72CB
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Mar 2026 15:42:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F01840667;
	Sun, 22 Mar 2026 16:42:29 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 4412040656
 for <dev@dpdk.org>; Sun, 22 Mar 2026 16:42:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774194147; x=1805730147;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aBXbEpTl7EaxjO2zOeRvEl0xMa2u6UrXerOZRQy8L98=;
 b=eUdXcyk5xjVZUG7kl1tk1mC0kM/Pk9zQ1fPHnbdgQBHMrgsw/M4NFCm7
 LKmPrFtBEwg83gZQlgFnPFuPyl945S1VnFjPyVGJx94uNkZUejnYizxpg
 tegrUyFAOB//PaRXHt5zaEPtAc9W+cKRanYjzgldG6olq1rvWGwvzi+1x
 DVTltnWhDpgryG/r6YSMrYr3EN5Foagkq7mJln4Bn+vR3QRdeU++0+q11
 bLVGMSWNDf38oFtqWJCr2cYuk2sAau5ySF3mgqtVDkpO8ZHUPlAiw3vJe
 bYiRvpR8L4QcvZXd/lny9bF0O1vm9weLzKa/GwcaOD04ulwIz1daJDoQE Q==;
X-CSE-ConnectionGUID: rhbabfpmSYaa7LAx12xUag==
X-CSE-MsgGUID: lAUxSit4R/uYlYVNAFO3qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="97832231"
X-IronPort-AV: E=Sophos;i="6.23,135,1770624000"; d="scan'208";a="97832231"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2026 08:42:26 -0700
X-CSE-ConnectionGUID: dh7GDhAQRHS4gv0eFNlVdw==
X-CSE-MsgGUID: 5G9tETrJRP+18c4kkD+sjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,135,1770624000"; d="scan'208";a="221020830"
Received: from silpixa00401176.ir.intel.com ([10.20.224.212])
 by fmviesa008.fm.intel.com with ESMTP; 22 Mar 2026 08:42:24 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com, nsaxena16@gmail.com, mb@smartsharesystems.com,
 adwivedi@marvell.com, jerinjacobk@gmail.com
Subject: [RFC PATCH 4/4] fib6: add VRF functional and unit tests
Date: Sun, 22 Mar 2026 15:42:15 +0000
Message-ID: <20260322154215.3686528-5-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
References: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
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

Add test coverage for the multi-VRF IPv6 FIB API.

Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 app/test-fib/main.c  |  92 +++++++++++--
 app/test/test_fib6.c | 319 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 395 insertions(+), 16 deletions(-)

diff --git a/app/test-fib/main.c b/app/test-fib/main.c
index 5593fdd47e..0feac72b87 100644
--- a/app/test-fib/main.c
+++ b/app/test-fib/main.c
@@ -717,7 +717,7 @@ check_config(void)
 	 * get_vrf_bits(nb_vrfs) must be strictly less than
 	 * the total nexthop width.
 	 */
-	if ((config.nb_vrfs > 1) && !(config.flags & IPV6_FLAG)) {
+	if (config.nb_vrfs > 1) {
 		uint8_t nh_sz = rte_ctz32(config.ent_sz);
 		uint8_t vrf_bits = get_vrf_bits(config.nb_vrfs);
 		/* - 2 to leave at least 1 bit for nexthop and 1 bit for ext_ent flag */
@@ -1165,6 +1165,7 @@ run_v6(void)
 {
 	uint64_t start, acc;
 	uint64_t def_nh = 0;
+	uint8_t nh_sz = rte_ctz32(config.ent_sz);
 	struct rte_fib6 *fib;
 	struct rte_fib6_conf conf = {0};
 	struct rt_rule_6 *rt;
@@ -1175,6 +1176,7 @@ run_v6(void)
 	struct rte_ipv6_addr *tbl6;
 	uint64_t fib_nh[BURST_SZ];
 	int32_t lpm_nh[BURST_SZ];
+	uint16_t *vrf_ids = NULL;
 
 	rt = (struct rt_rule_6 *)config.rt;
 	tbl6 = config.lookup_tbl;
@@ -1189,16 +1191,38 @@ run_v6(void)
 		return ret;
 	}
 
+	/* Allocate VRF IDs array for lookups if using multiple VRFs */
+	if (config.nb_vrfs > 1) {
+		vrf_ids = rte_malloc(NULL, sizeof(uint16_t) * config.nb_lookup_ips, 0);
+		if (vrf_ids == NULL) {
+			printf("Can not alloc VRF IDs array\n");
+			return -ENOMEM;
+		}
+		/* Generate random VRF IDs for each lookup */
+		for (i = 0; i < config.nb_lookup_ips; i++)
+			vrf_ids[i] = rte_rand() % config.nb_vrfs;
+	}
+
 	conf.type = get_fib_type();
 	conf.default_nh = def_nh;
 	conf.max_routes = config.nb_routes * 2;
 	conf.rib_ext_sz = 0;
+	conf.max_vrfs = config.nb_vrfs;
+	conf.vrf_default_nh = NULL;
 	if (conf.type == RTE_FIB6_TRIE) {
 		conf.trie.nh_sz = rte_ctz32(config.ent_sz);
 		conf.trie.num_tbl8 = RTE_MIN(config.tbl8,
 			get_max_nh(conf.trie.nh_sz));
 	}
 
+	conf.vrf_default_nh = rte_malloc(NULL, conf.max_vrfs * sizeof(uint64_t), 0);
+	if (conf.vrf_default_nh == NULL) {
+		printf("Can not alloc VRF default nexthops array\n");
+		return -ENOMEM;
+	}
+	for (i = 0; i < conf.max_vrfs; i++)
+		conf.vrf_default_nh[i] = encode_vrf_nh(i, def_nh, nh_sz);
+
 	fib = rte_fib6_create("test", -1, &conf);
 	if (fib == NULL) {
 		printf("Can not alloc FIB, err %d\n", rte_errno);
@@ -1223,12 +1247,28 @@ run_v6(void)
 	for (k = config.print_fract, i = 0; k > 0; k--) {
 		start = rte_rdtsc_precise();
 		for (j = 0; j < (config.nb_routes - i) / k; j++) {
-			ret = rte_fib6_add(fib, &rt[i + j].addr,
-				rt[i + j].depth, rt[i + j].nh);
-			if (unlikely(ret != 0)) {
-				printf("Can not add a route to FIB, err %d\n",
-					ret);
-				return -ret;
+			uint32_t idx = i + j;
+			if (config.nb_vrfs > 1) {
+				uint16_t vrf_id;
+				for (vrf_id = 0; vrf_id < config.nb_vrfs; vrf_id++) {
+					uint64_t nh = encode_vrf_nh(vrf_id, rt[idx].nh,
+						nh_sz);
+					ret = rte_fib6_vrf_add(fib, vrf_id, &rt[idx].addr,
+						rt[idx].depth, nh);
+					if (unlikely(ret != 0)) {
+						printf("Can not add a route to FIB, err %d\n",
+							ret);
+						return -ret;
+					}
+				}
+			} else {
+				ret = rte_fib6_add(fib, &rt[idx].addr,
+					rt[idx].depth, rt[idx].nh);
+				if (unlikely(ret != 0)) {
+					printf("Can not add a route to FIB, err %d\n",
+						ret);
+					return -ret;
+				}
 			}
 		}
 		printf("AVG FIB add %"PRIu64"\n",
@@ -1268,15 +1308,33 @@ run_v6(void)
 	acc = 0;
 	for (i = 0; i < config.nb_lookup_ips; i += BURST_SZ) {
 		start = rte_rdtsc_precise();
-		ret = rte_fib6_lookup_bulk(fib, &tbl6[i],
-			fib_nh, BURST_SZ);
+		if (config.nb_vrfs > 1)
+			ret = rte_fib6_vrf_lookup_bulk(fib, vrf_ids + i,
+				&tbl6[i], fib_nh, BURST_SZ);
+		else
+			ret = rte_fib6_lookup_bulk(fib, &tbl6[i],
+				fib_nh, BURST_SZ);
 		acc += rte_rdtsc_precise() - start;
 		if (ret != 0) {
 			printf("FIB lookup fails, err %d\n", ret);
 			return -ret;
 		}
+		/* Validate VRF IDs in returned nexthops */
+		if (config.nb_vrfs > 1) {
+			for (j = 0; j < BURST_SZ; j++) {
+				uint16_t returned_vrf = decode_vrf_nh(fib_nh[j],
+					nh_sz);
+				if (returned_vrf != vrf_ids[i + j]) {
+					printf("VRF validation failed: expected VRF %u, got %u\n",
+						vrf_ids[i + j], returned_vrf);
+					return -1;
+				}
+			}
+		}
 	}
 	printf("AVG FIB lookup %.1f\n", (double)acc / (double)i);
+	if (config.nb_vrfs > 1)
+		printf("VRF validation passed\n");
 
 	if (config.flags & CMP_FLAG) {
 		acc = 0;
@@ -1314,8 +1372,17 @@ run_v6(void)
 
 	for (k = config.print_fract, i = 0; k > 0; k--) {
 		start = rte_rdtsc_precise();
-		for (j = 0; j < (config.nb_routes - i) / k; j++)
-			rte_fib6_delete(fib, &rt[i + j].addr, rt[i + j].depth);
+		for (j = 0; j < (config.nb_routes - i) / k; j++) {
+			uint32_t idx = i + j;
+			if (config.nb_vrfs > 1) {
+				uint16_t vrf_id;
+				for (vrf_id = 0; vrf_id < config.nb_vrfs; vrf_id++)
+					rte_fib6_vrf_delete(fib, vrf_id, &rt[idx].addr,
+						rt[idx].depth);
+			} else {
+				rte_fib6_delete(fib, &rt[idx].addr, rt[idx].depth);
+			}
+		}
 
 		printf("AVG FIB delete %"PRIu64"\n",
 			(rte_rdtsc_precise() - start) / j);
@@ -1334,6 +1401,9 @@ run_v6(void)
 			i += j;
 		}
 	}
+
+	if (vrf_ids != NULL)
+		rte_free(vrf_ids);
 	return 0;
 }
 
diff --git a/app/test/test_fib6.c b/app/test/test_fib6.c
index fffb590dbf..1143a338e6 100644
--- a/app/test/test_fib6.c
+++ b/app/test/test_fib6.c
@@ -6,6 +6,7 @@
 #include <stdio.h>
 #include <stdint.h>
 #include <stdlib.h>
+#include <inttypes.h>
 
 #include <rte_memory.h>
 #include <rte_log.h>
@@ -25,6 +26,11 @@ static int32_t test_get_invalid(void);
 static int32_t test_lookup(void);
 static int32_t test_invalid_rcu(void);
 static int32_t test_fib_rcu_sync_rw(void);
+static int32_t test_create_vrf(void);
+static int32_t test_vrf_add_del(void);
+static int32_t test_vrf_lookup(void);
+static int32_t test_vrf_isolation(void);
+static int32_t test_vrf_all_nh_sizes(void);
 
 #define MAX_ROUTES	(1 << 16)
 /** Maximum number of tbl8 for 2-byte entries */
@@ -38,7 +44,7 @@ int32_t
 test_create_invalid(void)
 {
 	struct rte_fib6 *fib = NULL;
-	struct rte_fib6_conf config;
+	struct rte_fib6_conf config = { 0 };
 
 	config.max_routes = MAX_ROUTES;
 	config.rib_ext_sz = 0;
@@ -97,7 +103,7 @@ int32_t
 test_multiple_create(void)
 {
 	struct rte_fib6 *fib = NULL;
-	struct rte_fib6_conf config;
+	struct rte_fib6_conf config = { 0 };
 	int32_t i;
 
 	config.rib_ext_sz = 0;
@@ -124,7 +130,7 @@ int32_t
 test_free_null(void)
 {
 	struct rte_fib6 *fib = NULL;
-	struct rte_fib6_conf config;
+	struct rte_fib6_conf config = { 0 };
 
 	config.max_routes = MAX_ROUTES;
 	config.rib_ext_sz = 0;
@@ -148,7 +154,7 @@ int32_t
 test_add_del_invalid(void)
 {
 	struct rte_fib6 *fib = NULL;
-	struct rte_fib6_conf config;
+	struct rte_fib6_conf config = { 0 };
 	uint64_t nh = 100;
 	struct rte_ipv6_addr ip = RTE_IPV6_ADDR_UNSPEC;
 	int ret;
@@ -342,7 +348,7 @@ int32_t
 test_lookup(void)
 {
 	struct rte_fib6 *fib = NULL;
-	struct rte_fib6_conf config;
+	struct rte_fib6_conf config = { 0 };
 	uint64_t def_nh = 100;
 	int ret;
 
@@ -599,6 +605,304 @@ test_fib_rcu_sync_rw(void)
 	return status == 0 ? TEST_SUCCESS : TEST_FAILED;
 }
 
+/*
+ * Test VRF creation and basic operations
+ */
+static int32_t
+test_create_vrf(void)
+{
+	struct rte_fib6 *fib = NULL;
+	struct rte_fib6_conf config = { 0 };
+	uint64_t def_nh = 100;
+	uint64_t vrf_def_nh[4] = {100, 200, 300, 400};
+
+	config.max_routes = MAX_ROUTES;
+	config.rib_ext_sz = 0;
+	config.default_nh = def_nh;
+	config.type = RTE_FIB6_TRIE;
+	config.trie.nh_sz = RTE_FIB6_TRIE_4B;
+	config.trie.num_tbl8 = MAX_TBL8;
+
+	/* Test single VRF (backward compat) */
+	config.max_vrfs = 0;
+	config.vrf_default_nh = NULL;
+	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB with max_vrfs=0\n");
+	rte_fib6_free(fib);
+
+	/* Test single VRF explicitly */
+	config.max_vrfs = 1;
+	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB with max_vrfs=1\n");
+	rte_fib6_free(fib);
+
+	/* Test multi-VRF with per-VRF defaults */
+	config.max_vrfs = 4;
+	config.vrf_default_nh = vrf_def_nh;
+	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB with max_vrfs=4\n");
+	rte_fib6_free(fib);
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * Test VRF route add/delete operations
+ */
+static int32_t
+test_vrf_add_del(void)
+{
+	struct rte_fib6 *fib = NULL;
+	struct rte_fib6_conf config = { 0 };
+	uint64_t def_nh = 100;
+	uint64_t vrf_def_nh[4] = {100, 200, 300, 400};
+	struct rte_ipv6_addr ip = RTE_IPV6(0x2001, 0, 0, 0, 0, 0, 0, 0);
+	uint8_t depth = 64;
+	uint64_t nh = 1000;
+	int ret;
+
+	config.max_routes = MAX_ROUTES;
+	config.rib_ext_sz = 0;
+	config.default_nh = def_nh;
+	config.type = RTE_FIB6_TRIE;
+	config.trie.nh_sz = RTE_FIB6_TRIE_4B;
+	config.trie.num_tbl8 = MAX_TBL8;
+	config.max_vrfs = 4;
+	config.vrf_default_nh = vrf_def_nh;
+
+	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
+
+	/* Add route to VRF 0 */
+	ret = rte_fib6_vrf_add(fib, 0, &ip, depth, nh);
+	RTE_TEST_ASSERT(ret == 0, "Failed to add route to VRF 0\n");
+
+	/* Add route to VRF 1 with different nexthop */
+	ret = rte_fib6_vrf_add(fib, 1, &ip, depth, nh + 1);
+	RTE_TEST_ASSERT(ret == 0, "Failed to add route to VRF 1\n");
+
+	/* Add route to VRF 2 */
+	ret = rte_fib6_vrf_add(fib, 2, &ip, depth, nh + 2);
+	RTE_TEST_ASSERT(ret == 0, "Failed to add route to VRF 2\n");
+
+	/* Test invalid VRF ID */
+	ret = rte_fib6_vrf_add(fib, 10, &ip, depth, nh);
+	RTE_TEST_ASSERT(ret != 0, "Should fail with invalid VRF ID\n");
+
+	/* Delete route from VRF 1 */
+	ret = rte_fib6_vrf_delete(fib, 1, &ip, depth);
+	RTE_TEST_ASSERT(ret == 0, "Failed to delete route from VRF 1\n");
+
+	/* Delete non-existent route - implementation may return error */
+	ret = rte_fib6_vrf_delete(fib, 3, &ip, depth);
+	(void)ret;  /* Accept any return value */
+
+	rte_fib6_free(fib);
+	return TEST_SUCCESS;
+}
+
+/*
+ * Test VRF lookup functionality
+ */
+static int32_t
+test_vrf_lookup(void)
+{
+	struct rte_fib6 *fib = NULL;
+	struct rte_fib6_conf config = { 0 };
+	uint64_t def_nh = 100;
+	uint64_t vrf_def_nh[4] = {1000, 2000, 3000, 4000};
+	struct rte_ipv6_addr ip_base = RTE_IPV6(0x2001, 0, 0, 0, 0, 0, 0, 0);
+	uint16_t vrf_ids[4];
+	struct rte_ipv6_addr ips[4];
+	uint64_t next_hops[4];
+	int ret;
+	uint32_t i;
+
+	config.max_routes = MAX_ROUTES;
+	config.rib_ext_sz = 0;
+	config.default_nh = def_nh;
+	config.type = RTE_FIB6_TRIE;
+	config.trie.nh_sz = RTE_FIB6_TRIE_4B;
+	config.trie.num_tbl8 = MAX_TBL8;
+	config.max_vrfs = 4;
+	config.vrf_default_nh = vrf_def_nh;
+
+	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
+
+	/* Add routes to different VRFs with VRF-specific nexthops */
+	for (i = 0; i < 4; i++) {
+		struct rte_ipv6_addr ip = ip_base;
+		ip.a[1] = (uint8_t)i;
+		ret = rte_fib6_vrf_add(fib, i, &ip, 64, 100 + i);
+		RTE_TEST_ASSERT(ret == 0, "Failed to add route to VRF %u\n", i);
+	}
+
+	/* Prepare lookup: each IP should match its VRF-specific route */
+	for (i = 0; i < 4; i++) {
+		vrf_ids[i] = i;
+		ips[i] = ip_base;
+		ips[i].a[1] = (uint8_t)i;
+		ips[i].a[15] = 0x34; /* within /64 */
+	}
+
+	/* Lookup should return VRF-specific nexthops */
+	ret = rte_fib6_vrf_lookup_bulk(fib, vrf_ids, ips, next_hops, 4);
+	RTE_TEST_ASSERT(ret == 0, "VRF lookup failed\n");
+
+	for (i = 0; i < 4; i++) {
+		RTE_TEST_ASSERT(next_hops[i] == 100 + i,
+			"Wrong nexthop for VRF %u: expected %"PRIu64", got %"PRIu64"\n",
+			i, (uint64_t)(100 + i), next_hops[i]);
+	}
+
+	/* Test default nexthops for unmatched IPs */
+	{
+		struct rte_ipv6_addr ip_unmatch = RTE_IPV6(0x3001, 0, 0, 0, 0, 0, 0, 1);
+		for (i = 0; i < 4; i++) {
+			vrf_ids[i] = i;
+			ips[i] = ip_unmatch;
+		}
+	}
+
+	ret = rte_fib6_vrf_lookup_bulk(fib, vrf_ids, ips, next_hops, 4);
+	RTE_TEST_ASSERT(ret == 0, "VRF lookup failed\n");
+
+	for (i = 0; i < 4; i++) {
+		RTE_TEST_ASSERT(next_hops[i] == vrf_def_nh[i],
+			"Wrong default nexthop for VRF %u: expected %"PRIu64", got %"PRIu64"\n",
+			i, vrf_def_nh[i], next_hops[i]);
+	}
+
+	rte_fib6_free(fib);
+	return TEST_SUCCESS;
+}
+
+/*
+ * Test VRF isolation - routes in one VRF shouldn't affect others
+ */
+static int32_t
+test_vrf_isolation(void)
+{
+	struct rte_fib6 *fib = NULL;
+	struct rte_fib6_conf config = { 0 };
+	uint64_t vrf_def_nh[3] = {100, 200, 300};
+	struct rte_ipv6_addr ip = RTE_IPV6(0x2001, 0, 0, 0, 0, 0, 0, 0);
+	uint16_t vrf_ids[3] = {0, 1, 2};
+	struct rte_ipv6_addr ips[3];
+	uint64_t next_hops[3];
+	int ret;
+	uint32_t i;
+
+	config.max_routes = MAX_ROUTES;
+	config.rib_ext_sz = 0;
+	config.default_nh = 0;
+	config.type = RTE_FIB6_TRIE;
+	config.trie.nh_sz = RTE_FIB6_TRIE_4B;
+	config.trie.num_tbl8 = MAX_TBL8;
+	config.max_vrfs = 3;
+	config.vrf_default_nh = vrf_def_nh;
+
+	fib = rte_fib6_create("test_vrf6_isol", SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
+
+	/* Add route only to VRF 1 */
+	ret = rte_fib6_vrf_add(fib, 1, &ip, 64, 777);
+	RTE_TEST_ASSERT(ret == 0, "Failed to add route to VRF 1\n");
+
+	/* Lookup same IP in all three VRFs */
+	for (i = 0; i < 3; i++) {
+		ips[i] = ip;
+		ips[i].a[15] = 0x22; /* within /64 */
+	}
+
+	ret = rte_fib6_vrf_lookup_bulk(fib, vrf_ids, ips, next_hops, 3);
+	RTE_TEST_ASSERT(ret == 0, "VRF lookup failed\n");
+
+	/* VRF 0 should get default */
+	RTE_TEST_ASSERT(next_hops[0] == vrf_def_nh[0],
+		"VRF 0 should return default nexthop\n");
+
+	/* VRF 1 should get the route */
+	RTE_TEST_ASSERT(next_hops[1] == 777,
+		"VRF 1 should return route nexthop 777, got %"PRIu64"\n", next_hops[1]);
+
+	/* VRF 2 should get default */
+	RTE_TEST_ASSERT(next_hops[2] == vrf_def_nh[2],
+		"VRF 2 should return default nexthop\n");
+
+	rte_fib6_free(fib);
+	return TEST_SUCCESS;
+}
+
+/*
+ * Test multi-VRF with all nexthop sizes
+ */
+static int32_t
+test_vrf_all_nh_sizes(void)
+{
+	struct rte_fib6 *fib = NULL;
+	struct rte_fib6_conf config = { 0 };
+	uint64_t vrf_def_nh[2] = {10, 20};
+	struct rte_ipv6_addr ip = RTE_IPV6(0x2001, 0, 0, 0, 0, 0, 0, 0);
+	uint16_t vrf_ids[2] = {0, 1};
+	struct rte_ipv6_addr ips[2];
+	uint64_t next_hops[2];
+	int ret;
+	enum rte_fib_trie_nh_sz nh_sizes[] = {
+		RTE_FIB6_TRIE_2B,
+		RTE_FIB6_TRIE_4B,
+		RTE_FIB6_TRIE_8B
+	};
+	uint64_t max_nhs[] = {32767, 2147483647ULL, 9223372036854775807ULL};
+	int i;
+
+	config.max_routes = MAX_ROUTES;
+	config.rib_ext_sz = 0;
+	config.default_nh = 0;
+	config.type = RTE_FIB6_TRIE;
+	config.trie.num_tbl8 = MAX_TBL8 - 1;
+	config.max_vrfs = 2;
+	config.vrf_default_nh = vrf_def_nh;
+
+	for (i = 0; i < (int)RTE_DIM(nh_sizes); i++) {
+		char name[32];
+		config.trie.nh_sz = nh_sizes[i];
+		snprintf(name, sizeof(name), "vrf6_nh%d", i);
+
+		fib = rte_fib6_create(name, SOCKET_ID_ANY, &config);
+		RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
+
+		/* Add routes with max nexthop for this size */
+		ret = rte_fib6_vrf_add(fib, 0, &ip, 64, max_nhs[i]);
+		RTE_TEST_ASSERT(ret == 0,
+			"Failed to add route to VRF 0 with nh_sz=%d\n", nh_sizes[i]);
+
+		ret = rte_fib6_vrf_add(fib, 1, &ip, 64, max_nhs[i] - 1);
+		RTE_TEST_ASSERT(ret == 0,
+			"Failed to add route to VRF 1 with nh_sz=%d\n", nh_sizes[i]);
+
+		/* Lookup */
+		ips[0] = ip;
+		ips[1] = ip;
+		ips[0].a[15] = 0x11;
+		ips[1].a[15] = 0x22;
+
+		ret = rte_fib6_vrf_lookup_bulk(fib, vrf_ids, ips, next_hops, 2);
+		RTE_TEST_ASSERT(ret == 0, "VRF lookup failed with nh_sz=%d\n", nh_sizes[i]);
+
+		RTE_TEST_ASSERT(next_hops[0] == max_nhs[i],
+			"Wrong nexthop for VRF 0 with nh_sz=%d\n", nh_sizes[i]);
+		RTE_TEST_ASSERT(next_hops[1] == max_nhs[i] - 1,
+			"Wrong nexthop for VRF 1 with nh_sz=%d\n", nh_sizes[i]);
+
+		rte_fib6_free(fib);
+		fib = NULL;
+	}
+
+	return TEST_SUCCESS;
+}
+
 static struct unit_test_suite fib6_fast_tests = {
 	.suite_name = "fib6 autotest",
 	.setup = NULL,
@@ -611,6 +915,11 @@ static struct unit_test_suite fib6_fast_tests = {
 	TEST_CASE(test_lookup),
 	TEST_CASE(test_invalid_rcu),
 	TEST_CASE(test_fib_rcu_sync_rw),
+	TEST_CASE(test_create_vrf),
+	TEST_CASE(test_vrf_add_del),
+	TEST_CASE(test_vrf_lookup),
+	TEST_CASE(test_vrf_isolation),
+	TEST_CASE(test_vrf_all_nh_sizes),
 	TEST_CASES_END()
 	}
 };
-- 
2.43.0

