Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD7EFC72C4
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Mar 2026 15:42:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 125FA4065D;
	Sun, 22 Mar 2026 16:42:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 5EDFC402CC
 for <dev@dpdk.org>; Sun, 22 Mar 2026 16:42:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774194144; x=1805730144;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JNsNcxW0XSL1Iv+eJPbip35+Cv2vV8FTG0XnI26AdGk=;
 b=in2/GXpIfw3Qvx7qYO5WE/H0ecNgzfuO2pYNrxUMLIq98CDQhd1jgT6N
 93diMv4D3O5JEZUyHtklDYlkNKM2iwf9T/UkgDYJK27sQok65fchZMNv9
 jnb7tdMmfvmj7KMBRQ42XyR7HW1OfpMj1Bvn7lfCN9eQ5r346Ea0ySF54
 fBk4A8R72le4LxNhNKQintLP4ixvma4bsLBNV5pmRcllywhAMYmsvCdik
 /xSTltp3y+31BfC6d4tY4Tkg0C/71fl68Eg8HENFrdr7uDKIK/m7r114n
 b76CQhUmBw8MN/O5RLeVqhG8VC0xxJ54I6gUvuUcQn976EEFFT5/9DcBM w==;
X-CSE-ConnectionGUID: NKtQlNvxQw66I/uDuB97vQ==
X-CSE-MsgGUID: ZSavXXdUSae7aFxJZLqeIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="97832221"
X-IronPort-AV: E=Sophos;i="6.23,135,1770624000"; d="scan'208";a="97832221"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2026 08:42:23 -0700
X-CSE-ConnectionGUID: i0joITcuS5iIzrJRV1kB8g==
X-CSE-MsgGUID: 2mDzpqUjQtSQVs81Giv2QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,135,1770624000"; d="scan'208";a="221020822"
Received: from silpixa00401176.ir.intel.com ([10.20.224.212])
 by fmviesa008.fm.intel.com with ESMTP; 22 Mar 2026 08:42:22 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com, nsaxena16@gmail.com, mb@smartsharesystems.com,
 adwivedi@marvell.com, jerinjacobk@gmail.com
Subject: [RFC PATCH 2/4] fib: add VRF functional and unit tests
Date: Sun, 22 Mar 2026 15:42:13 +0000
Message-ID: <20260322154215.3686528-3-vladimir.medvedkin@intel.com>
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

Add test coverage for the multi-VRF IPv4 FIB API.

The app/test-fib functional harness exercises VRF-aware routes
with nexthop encoding, bulk VRF lookup, and nexthop validation
across multiple VRFs (enabled with the -V option).

The app/test unit tests cover VRF table creation, per-VRF
route add and delete, lookup correctness, inter-VRF isolation,
and all supported nexthop sizes.

Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 app/test-fib/main.c | 167 +++++++++++++++++++++++--
 app/test/test_fib.c | 298 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 454 insertions(+), 11 deletions(-)

diff --git a/app/test-fib/main.c b/app/test-fib/main.c
index dd1a6d7297..5593fdd47e 100644
--- a/app/test-fib/main.c
+++ b/app/test-fib/main.c
@@ -82,6 +82,7 @@ static struct {
 	uint32_t	nb_routes_per_depth[128 + 1];
 	uint32_t	flags;
 	uint32_t	tbl8;
+	uint32_t	nb_vrfs;
 	uint8_t		ent_sz;
 	uint8_t		rnd_lookup_ips_ratio;
 	uint8_t		print_fract;
@@ -95,6 +96,7 @@ static struct {
 	.nb_routes_per_depth = {0},
 	.flags = FIB_V4_DIR_TYPE,
 	.tbl8 = DEFAULT_LPM_TBL8,
+	.nb_vrfs = 1,
 	.ent_sz = 4,
 	.rnd_lookup_ips_ratio = 0,
 	.print_fract = 10,
@@ -136,6 +138,45 @@ get_max_nh(uint8_t nh_sz)
 			(1ULL << 21) - 1);
 }
 
+/* Get number of bits needed to encode VRF IDs */
+static __rte_always_inline __rte_pure uint8_t
+get_vrf_bits(uint32_t nb_vrfs)
+{
+	uint8_t bits = 0;
+	uint32_t vrfs = nb_vrfs > 1 ? nb_vrfs : 2;  /* At least 1 bit */
+
+	/* Round up to next power of 2 */
+	vrfs--;
+	while (vrfs > 0) {
+		bits++;
+		vrfs >>= 1;
+	}
+	return bits;
+}
+
+/* Encode VRF ID into nexthop (high bits) */
+static __rte_always_inline uint64_t
+encode_vrf_nh(uint16_t vrf_id, uint64_t nh, uint8_t nh_sz)
+{
+	uint8_t vrf_bits = get_vrf_bits(config.nb_vrfs);
+	/* +1 to account for ext bit in nexthop */
+	uint8_t vrf_shift = bits_in_nh(nh_sz) - (vrf_bits + 1);
+	uint64_t nh_mask = (1ULL << vrf_shift) - 1;
+
+	return (nh & nh_mask) | ((uint64_t)vrf_id << vrf_shift);
+}
+
+/* Decode VRF ID from nexthop (high bits) */
+static __rte_always_inline uint16_t
+decode_vrf_nh(uint64_t nh, uint8_t nh_sz)
+{
+	uint8_t vrf_bits = get_vrf_bits(config.nb_vrfs);
+	/* +1 to account for ext bit in nexthop */
+	uint8_t vrf_shift = bits_in_nh(nh_sz) - (vrf_bits + 1);
+
+	return (uint16_t)(nh >> vrf_shift);
+}
+
 static int
 get_fib_type(void)
 {
@@ -629,7 +670,8 @@ print_usage(void)
 		"[-v <type of lookup function:"
 		"\ts1, s2, s3 (3 types of scalar), v (vector) -"
 		" for DIR24_8 based FIB\n"
-		"\ts, v - for TRIE based ipv6 FIB>]\n",
+		"\ts, v - for TRIE based ipv6 FIB>]\n"
+		"[-V <number of VRFs (default 1)>]\n",
 		config.prgname);
 }
 
@@ -652,6 +694,11 @@ check_config(void)
 		return -1;
 	}
 
+	if ((config.flags & CMP_FLAG) && (config.nb_vrfs > 1)) {
+		printf("-c option can not be used with -V > 1\n");
+		return -1;
+	}
+
 	if (!((config.ent_sz == 1) || (config.ent_sz == 2) ||
 			(config.ent_sz == 4) || (config.ent_sz == 8))) {
 		printf("wrong -e option %d, can be 1 or 2 or 4 or 8\n",
@@ -663,6 +710,24 @@ check_config(void)
 		printf("-e 1 is valid only for ipv4\n");
 		return -1;
 	}
+
+	/*
+	 * For multi-VRF mode, VRF IDs are packed into the high bits of the
+	 * nexthop for validation. Ensure there are enough bits:
+	 * get_vrf_bits(nb_vrfs) must be strictly less than
+	 * the total nexthop width.
+	 */
+	if ((config.nb_vrfs > 1) && !(config.flags & IPV6_FLAG)) {
+		uint8_t nh_sz = rte_ctz32(config.ent_sz);
+		uint8_t vrf_bits = get_vrf_bits(config.nb_vrfs);
+		/* - 2 to leave at least 1 bit for nexthop and 1 bit for ext_ent flag */
+		if (vrf_bits >= bits_in_nh(nh_sz) - 2) {
+			printf("%u VRFs cannot be encoded in a %u-byte nexthop; "
+				"use a wider -e entry size\n",
+				config.nb_vrfs, config.ent_sz);
+			return -1;
+		}
+	}
 	return 0;
 }
 
@@ -672,7 +737,7 @@ parse_opts(int argc, char **argv)
 	int opt;
 	char *endptr;
 
-	while ((opt = getopt(argc, argv, "f:t:n:d:l:r:c6ab:e:g:w:u:sv:")) !=
+	while ((opt = getopt(argc, argv, "f:t:n:d:l:r:c6ab:e:g:w:u:sv:V:")) !=
 			-1) {
 		switch (opt) {
 		case 'f':
@@ -781,6 +846,16 @@ parse_opts(int argc, char **argv)
 			}
 			print_usage();
 			rte_exit(-EINVAL, "Invalid option -v %s\n", optarg);
+		case 'V':
+			errno = 0;
+			config.nb_vrfs = strtoul(optarg, &endptr, 10);
+			/* VRF IDs are uint16_t, max valid VRF is 65535 */
+			if ((errno != 0) || (config.nb_vrfs == 0) ||
+					(config.nb_vrfs > UINT16_MAX)) {
+				print_usage();
+				rte_exit(-EINVAL, "Invalid option -V: must be 1..65535\n");
+			}
+			break;
 		default:
 			print_usage();
 			rte_exit(-EINVAL, "Invalid options\n");
@@ -820,6 +895,7 @@ run_v4(void)
 {
 	uint64_t start, acc;
 	uint64_t def_nh = 0;
+	uint8_t nh_sz = rte_ctz32(config.ent_sz);
 	struct rte_fib *fib;
 	struct rte_fib_conf conf = {0};
 	struct rt_rule_4 *rt;
@@ -830,6 +906,7 @@ run_v4(void)
 	uint32_t *tbl4 = config.lookup_tbl;
 	uint64_t fib_nh[BURST_SZ];
 	uint32_t lpm_nh[BURST_SZ];
+	uint16_t *vrf_ids = NULL;
 
 	rt = (struct rt_rule_4 *)config.rt;
 
@@ -843,16 +920,38 @@ run_v4(void)
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
+	conf.vrf_default_nh = NULL;  /* Use global default for single VRF */
 	if (conf.type == RTE_FIB_DIR24_8) {
 		conf.dir24_8.nh_sz = rte_ctz32(config.ent_sz);
 		conf.dir24_8.num_tbl8 = RTE_MIN(config.tbl8,
 			get_max_nh(conf.dir24_8.nh_sz));
 	}
 
+	conf.vrf_default_nh = rte_malloc(NULL, conf.max_vrfs * sizeof(uint64_t), 0);
+	if (conf.vrf_default_nh == NULL) {
+		printf("Can not alloc VRF default nexthops array\n");
+		return -ENOMEM;
+	}
+	for (i = 0; i < conf.max_vrfs; i++)
+		conf.vrf_default_nh[i] = encode_vrf_nh(i, def_nh, nh_sz);
+
 	fib = rte_fib_create("test", -1, &conf);
 	if (fib == NULL) {
 		printf("Can not alloc FIB, err %d\n", rte_errno);
@@ -883,12 +982,27 @@ run_v4(void)
 	for (k = config.print_fract, i = 0; k > 0; k--) {
 		start = rte_rdtsc_precise();
 		for (j = 0; j < (config.nb_routes - i) / k; j++) {
-			ret = rte_fib_add(fib, rt[i + j].addr, rt[i + j].depth,
-				rt[i + j].nh);
-			if (unlikely(ret != 0)) {
-				printf("Can not add a route to FIB, err %d\n",
-					ret);
-				return -ret;
+			uint32_t idx = i + j;
+			if (config.nb_vrfs > 1) {
+				uint16_t vrf_id;
+				for (vrf_id = 0; vrf_id < config.nb_vrfs; vrf_id++) {
+					uint64_t nh = encode_vrf_nh(vrf_id, rt[idx].nh,	nh_sz);
+					ret = rte_fib_vrf_add(fib, vrf_id, rt[idx].addr,
+						rt[idx].depth, nh);
+					if (unlikely(ret != 0)) {
+						printf("Can not add a route to FIB, err %d\n",
+							ret);
+						return -ret;
+					}
+				}
+			} else {
+				ret = rte_fib_add(fib, rt[idx].addr, rt[idx].depth,
+					rt[idx].nh);
+				if (unlikely(ret != 0)) {
+					printf("Can not add a route to FIB, err %d\n",
+						ret);
+					return -ret;
+				}
 			}
 		}
 		printf("AVG FIB add %"PRIu64"\n",
@@ -928,14 +1042,33 @@ run_v4(void)
 	acc = 0;
 	for (i = 0; i < config.nb_lookup_ips; i += BURST_SZ) {
 		start = rte_rdtsc_precise();
-		ret = rte_fib_lookup_bulk(fib, tbl4 + i, fib_nh, BURST_SZ);
+		if (config.nb_vrfs > 1)
+			ret = rte_fib_vrf_lookup_bulk(fib, vrf_ids + i,
+				tbl4 + i, fib_nh, BURST_SZ);
+		else
+			ret = rte_fib_lookup_bulk(fib, tbl4 + i, fib_nh,
+				BURST_SZ);
 		acc += rte_rdtsc_precise() - start;
 		if (ret != 0) {
 			printf("FIB lookup fails, err %d\n", ret);
 			return -ret;
 		}
+		/* Validate VRF IDs in returned nexthops */
+		if (config.nb_vrfs > 1) {
+			for (j = 0; j < BURST_SZ; j++) {
+				uint16_t returned_vrf = decode_vrf_nh(fib_nh[j], nh_sz);
+				if (returned_vrf != vrf_ids[i + j]) {
+					printf("VRF validation failed: "
+						"expected VRF %u, got %u\n",
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
@@ -970,8 +1103,17 @@ run_v4(void)
 
 	for (k = config.print_fract, i = 0; k > 0; k--) {
 		start = rte_rdtsc_precise();
-		for (j = 0; j < (config.nb_routes - i) / k; j++)
-			rte_fib_delete(fib, rt[i + j].addr, rt[i + j].depth);
+		for (j = 0; j < (config.nb_routes - i) / k; j++) {
+			uint32_t idx = i + j;
+			if (config.nb_vrfs > 1) {
+				uint16_t vrf_id;
+				for (vrf_id = 0; vrf_id < config.nb_vrfs; vrf_id++)
+					rte_fib_vrf_delete(fib, vrf_id, rt[idx].addr,
+						rt[idx].depth);
+			} else {
+				rte_fib_delete(fib, rt[idx].addr, rt[idx].depth);
+			}
+		}
 
 		printf("AVG FIB delete %"PRIu64"\n",
 			(rte_rdtsc_precise() - start) / j);
@@ -991,6 +1133,9 @@ run_v4(void)
 		}
 	}
 
+	if (vrf_ids != NULL)
+		rte_free(vrf_ids);
+
 	return 0;
 }
 
diff --git a/app/test/test_fib.c b/app/test/test_fib.c
index bd73399d56..6a5d9836de 100644
--- a/app/test/test_fib.c
+++ b/app/test/test_fib.c
@@ -24,6 +24,11 @@ static int32_t test_get_invalid(void);
 static int32_t test_lookup(void);
 static int32_t test_invalid_rcu(void);
 static int32_t test_fib_rcu_sync_rw(void);
+static int32_t test_create_vrf(void);
+static int32_t test_vrf_add_del(void);
+static int32_t test_vrf_lookup(void);
+static int32_t test_vrf_isolation(void);
+static int32_t test_vrf_all_nh_sizes(void);
 
 #define MAX_ROUTES	(1 << 16)
 #define MAX_TBL8	(1 << 15)
@@ -588,6 +593,294 @@ test_fib_rcu_sync_rw(void)
 	return status == 0 ? TEST_SUCCESS : TEST_FAILED;
 }
 
+/*
+ * Test VRF creation and basic operations
+ */
+static int32_t
+test_create_vrf(void)
+{
+	struct rte_fib *fib = NULL;
+	struct rte_fib_conf config = { 0 };
+	uint64_t def_nh = 100;
+	uint64_t vrf_def_nh[4] = {100, 200, 300, 400};
+
+	config.max_routes = MAX_ROUTES;
+	config.rib_ext_sz = 0;
+	config.default_nh = def_nh;
+	config.type = RTE_FIB_DIR24_8;
+	config.dir24_8.nh_sz = RTE_FIB_DIR24_8_4B;
+	config.dir24_8.num_tbl8 = MAX_TBL8;
+
+	/* Test single VRF (backward compat) */
+	config.max_vrfs = 0;
+	config.vrf_default_nh = NULL;
+	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB with max_vrfs=0\n");
+	rte_fib_free(fib);
+
+	/* Test single VRF explicitly */
+	config.max_vrfs = 1;
+	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB with max_vrfs=1\n");
+	rte_fib_free(fib);
+
+	/* Test multi-VRF with per-VRF defaults */
+	config.max_vrfs = 4;
+	config.vrf_default_nh = vrf_def_nh;
+	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB with max_vrfs=4\n");
+	rte_fib_free(fib);
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
+	struct rte_fib *fib = NULL;
+	struct rte_fib_conf config = { 0 };
+	uint64_t def_nh = 100;
+	uint64_t vrf_def_nh[4] = {100, 200, 300, 400};
+	uint32_t ip = RTE_IPV4(192, 168, 1, 0);
+	uint8_t depth = 24;
+	uint64_t nh = 1000;
+	int ret;
+
+	config.max_routes = MAX_ROUTES;
+	config.rib_ext_sz = 0;
+	config.default_nh = def_nh;
+	config.type = RTE_FIB_DIR24_8;
+	config.dir24_8.nh_sz = RTE_FIB_DIR24_8_4B;
+	config.dir24_8.num_tbl8 = MAX_TBL8;
+	config.max_vrfs = 4;
+	config.vrf_default_nh = vrf_def_nh;
+
+	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
+
+	/* Add route to VRF 0 */
+	ret = rte_fib_vrf_add(fib, 0, ip, depth, nh);
+	RTE_TEST_ASSERT(ret == 0, "Failed to add route to VRF 0\n");
+
+	/* Add route to VRF 1 with different nexthop */
+	ret = rte_fib_vrf_add(fib, 1, ip, depth, nh + 1);
+	RTE_TEST_ASSERT(ret == 0, "Failed to add route to VRF 1\n");
+
+	/* Add route to VRF 2 */
+	ret = rte_fib_vrf_add(fib, 2, ip, depth, nh + 2);
+	RTE_TEST_ASSERT(ret == 0, "Failed to add route to VRF 2\n");
+
+	/* Test invalid VRF ID */
+	ret = rte_fib_vrf_add(fib, 10, ip, depth, nh);
+	RTE_TEST_ASSERT(ret != 0, "Should fail with invalid VRF ID\n");
+
+	/* Delete route from VRF 1 */
+	ret = rte_fib_vrf_delete(fib, 1, ip, depth);
+	RTE_TEST_ASSERT(ret == 0, "Failed to delete route from VRF 1\n");
+
+	/* Delete non-existent route - implementation may return error */
+	ret = rte_fib_vrf_delete(fib, 3, ip, depth);
+	(void)ret;  /* Accept any return value */
+
+	rte_fib_free(fib);
+	return TEST_SUCCESS;
+}
+
+/*
+ * Test VRF lookup functionality
+ */
+static int32_t
+test_vrf_lookup(void)
+{
+	struct rte_fib *fib = NULL;
+	struct rte_fib_conf config = { 0 };
+	uint64_t def_nh = 100;
+	uint64_t vrf_def_nh[4] = {1000, 2000, 3000, 4000};
+	uint32_t ip_base = RTE_IPV4(10, 0, 0, 0);
+	uint16_t vrf_ids[8];
+	uint32_t ips[8];
+	uint64_t next_hops[8];
+	int ret;
+	uint32_t i;
+
+	config.max_routes = MAX_ROUTES;
+	config.rib_ext_sz = 0;
+	config.default_nh = def_nh;
+	config.type = RTE_FIB_DIR24_8;
+	config.dir24_8.nh_sz = RTE_FIB_DIR24_8_4B;
+	config.dir24_8.num_tbl8 = MAX_TBL8;
+	config.max_vrfs = 4;
+	config.vrf_default_nh = vrf_def_nh;
+
+	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
+
+	/* Add routes to different VRFs with VRF-specific nexthops */
+	for (i = 0; i < 4; i++) {
+		ret = rte_fib_vrf_add(fib, i, ip_base + (i << 16), 16, 100 + i);
+		RTE_TEST_ASSERT(ret == 0, "Failed to add route to VRF %u\n", i);
+	}
+
+	/* Prepare lookup: each IP should match its VRF-specific route */
+	for (i = 0; i < 4; i++) {
+		vrf_ids[i] = i;
+		ips[i] = ip_base + (i << 16) + 0x1234;  /* Within the /16 */
+	}
+
+	/* Lookup should return VRF-specific nexthops */
+	ret = rte_fib_vrf_lookup_bulk(fib, vrf_ids, ips, next_hops, 4);
+	RTE_TEST_ASSERT(ret == 0, "VRF lookup failed\n");
+
+	for (i = 0; i < 4; i++) {
+		RTE_TEST_ASSERT(next_hops[i] == 100 + i,
+			"Wrong nexthop for VRF %u: expected %"PRIu64", got %"PRIu64"\n",
+			i, (uint64_t)(100 + i), next_hops[i]);
+	}
+
+	/* Test default nexthops for unmatched IPs */
+	for (i = 0; i < 4; i++) {
+		vrf_ids[i] = i;
+		ips[i] = RTE_IPV4(192, 168, i, 1);  /* No route for these */
+	}
+
+	ret = rte_fib_vrf_lookup_bulk(fib, vrf_ids, ips, next_hops, 4);
+	RTE_TEST_ASSERT(ret == 0, "VRF lookup failed\n");
+
+	for (i = 0; i < 4; i++) {
+		RTE_TEST_ASSERT(next_hops[i] == vrf_def_nh[i],
+			"Wrong default nexthop for VRF %u: expected %"PRIu64", got %"PRIu64"\n",
+			i, vrf_def_nh[i], next_hops[i]);
+	}
+
+	rte_fib_free(fib);
+	return TEST_SUCCESS;
+}
+
+/*
+ * Test VRF isolation - routes in one VRF shouldn't affect others
+ */
+static int32_t
+test_vrf_isolation(void)
+{
+	struct rte_fib *fib = NULL;
+	struct rte_fib_conf config = { 0 };
+	uint64_t vrf_def_nh[3] = {100, 200, 300};
+	uint32_t ip = RTE_IPV4(10, 10, 10, 0);
+	uint16_t vrf_ids[3] = {0, 1, 2};
+	uint32_t ips[3];
+	uint64_t next_hops[3];
+	int ret;
+	uint32_t i;
+
+	config.max_routes = MAX_ROUTES;
+	config.rib_ext_sz = 0;
+	config.default_nh = 0;
+	config.type = RTE_FIB_DIR24_8;
+	config.dir24_8.nh_sz = RTE_FIB_DIR24_8_4B;
+	config.dir24_8.num_tbl8 = MAX_TBL8;
+	config.max_vrfs = 3;
+	config.vrf_default_nh = vrf_def_nh;
+
+	fib = rte_fib_create("test_vrfisol", SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
+
+	/* Add route only to VRF 1 */
+	ret = rte_fib_vrf_add(fib, 1, ip, 24, 777);
+	RTE_TEST_ASSERT(ret == 0, "Failed to add route to VRF 1\n");
+
+	/* Lookup same IP in all three VRFs */
+	for (i = 0; i < 3; i++)
+		ips[i] = ip + 15;  /* Within /24 */
+
+	ret = rte_fib_vrf_lookup_bulk(fib, vrf_ids, ips, next_hops, 3);
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
+	rte_fib_free(fib);
+	return TEST_SUCCESS;
+}
+
+/*
+ * Test multi-VRF with all nexthop sizes
+ */
+static int32_t
+test_vrf_all_nh_sizes(void)
+{
+	struct rte_fib *fib = NULL;
+	struct rte_fib_conf config = { 0 };
+	uint64_t vrf_def_nh[2] = {10, 20};
+	uint32_t ip = RTE_IPV4(172, 16, 0, 0);
+	uint16_t vrf_ids[2] = {0, 1};
+	uint32_t ips[2];
+	uint64_t next_hops[2];
+	int ret;
+	enum rte_fib_dir24_8_nh_sz nh_sizes[] = {
+		RTE_FIB_DIR24_8_1B,
+		RTE_FIB_DIR24_8_2B,
+		RTE_FIB_DIR24_8_4B,
+		RTE_FIB_DIR24_8_8B
+	};
+	uint64_t max_nhs[] = {127, 32767, 2147483647ULL, 9223372036854775807ULL};
+	int i;
+
+	config.max_routes = MAX_ROUTES;
+	config.rib_ext_sz = 0;
+	config.default_nh = 0;
+	config.type = RTE_FIB_DIR24_8;
+	config.dir24_8.num_tbl8 = 127;
+	config.max_vrfs = 2;
+	config.vrf_default_nh = vrf_def_nh;
+
+	for (i = 0; i < (int)RTE_DIM(nh_sizes); i++) {
+		char name[32];
+		config.dir24_8.nh_sz = nh_sizes[i];
+		snprintf(name, sizeof(name), "vrf_nh%d", i);
+
+		fib = rte_fib_create(name, SOCKET_ID_ANY, &config);
+		RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
+
+		/* Add routes with max nexthop for this size */
+		ret = rte_fib_vrf_add(fib, 0, ip, 16, max_nhs[i]);
+		RTE_TEST_ASSERT(ret == 0,
+			"Failed to add route to VRF 0 with nh_sz=%d\n", nh_sizes[i]);
+
+		ret = rte_fib_vrf_add(fib, 1, ip, 16, max_nhs[i] - 1);
+		RTE_TEST_ASSERT(ret == 0,
+			"Failed to add route to VRF 1 with nh_sz=%d\n", nh_sizes[i]);
+
+		/* Lookup */
+		ips[0] = ip + 0x100;
+		ips[1] = ip + 0x200;
+
+		ret = rte_fib_vrf_lookup_bulk(fib, vrf_ids, ips, next_hops, 2);
+		RTE_TEST_ASSERT(ret == 0, "VRF lookup failed with nh_sz=%d\n", nh_sizes[i]);
+
+		RTE_TEST_ASSERT(next_hops[0] == max_nhs[i],
+			"Wrong nexthop for VRF 0 with nh_sz=%d\n", nh_sizes[i]);
+		RTE_TEST_ASSERT(next_hops[1] == max_nhs[i] - 1,
+			"Wrong nexthop for VRF 1 with nh_sz=%d\n", nh_sizes[i]);
+
+		rte_fib_free(fib);
+		fib = NULL;
+	}
+
+	return TEST_SUCCESS;
+}
+
 static struct unit_test_suite fib_fast_tests = {
 	.suite_name = "fib autotest",
 	.setup = NULL,
@@ -600,6 +893,11 @@ static struct unit_test_suite fib_fast_tests = {
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

