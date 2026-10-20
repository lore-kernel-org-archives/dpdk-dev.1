Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E832606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 13:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gtxcpv68
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 134FA4068E;
	Tue, 20 Oct 2026 15:22:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id B1A1840608
 for <dev@dpdk.org>; Tue, 20 Oct 2026 15:22:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792502521; x=1824038521;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ogcFnzbj6BMwGq/SAH/eqrRV5u4yU8ES7SCtof25hmE=;
 b=gtxcpv68I3LCB42RjJbji9eu68BKcjN61s4WPwDXP821chMc1PrOgfON
 5fuxhzlTFq2aFp83LgiImaX8BOhgECKnAgKQHC8ygMSSXeW9aUTh9Nypd
 KvLcTbD6iQYuF/6RoNctR0pSbFlnZ841nkkwpM9aagVWKoI24vl5WJjK0
 7/e0+tquBnAgQaBKKTAapq/O3kRHQK7adzTtDBwEDhq88IuhmD4WgBWao
 yhzdb1Yp86KUDtfvPsDuWMV1SI6F1+oZ3rfcMzC4nUdECE18jW8z0GFBR
 dncHiy5kdGWw0YrWTcpXRSnnX1I0lDoc6XNbMaKpo8mraUKsRtJWEyXHw g==;
X-CSE-ConnectionGUID: DpXDoRSySjeKeD3ar+Blqg==
X-CSE-MsgGUID: vrN2acnnSq6IS9f6Ml2CTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1092345"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1092345"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 06:22:01 -0700
X-CSE-ConnectionGUID: ASANUT7tTlusssa3i/13ww==
X-CSE-MsgGUID: Vd/HOh3dTNOJn5ZQeJYMpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="4561258"
Received: from silpixa00401176.ir.intel.com ([10.20.224.212])
 by fmviesa012.fm.intel.com with ESMTP; 20 Oct 2026 06:21:59 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: maxime@leroys.fr
Subject: [PATCH 3/3] test/fib6: reproduce tbl8 leak on failed trie insert
Date: Tue, 20 Oct 2026 13:21:55 +0000
Message-ID: <20261020132155.980174-3-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020132155.980174-1-vladimir.medvedkin@intel.com>
References: <20261020132155.980174-1-vladimir.medvedkin@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Maxime Leroy <maxime@leroys.fr>

Reproducer for bugs in the IPv6 trie (lib/fib/trie.c): an update whose
install runs out of tbl8 mid-way leaks the groups already taken, so a
later add that should fit is wrongly refused.

test_tbl8_install_peak covers a pool of one group: a /33 (needs two) is
refused and a /32 (needs one) fits. A /24 and a /16 still fit the full
pool while a /25 is refused, and once the /32 is deleted the /25 fits.

test_tbl8_install_peak_dq covers QSBR defer mode, where a freed group is
still physically out while rsvd_tbl8s has dropped: after add+delete of
a /25 the /40 (needs two) must be refused without leaking, so a second
/25 still fits.

test_tbl8_dq_modify covers next hop change and delete in QSBR defer mode:
while the groups of a /32 and a /33 are deferred, changing or deleting
their covering /24 must be refused without touching the dataplane,
and the delete succeeds once the groups are reclaimed.

The tests fail on current main and pass once the trie no longer takes
temporary tbl8s for byte-aligned prefixes and accounts for the tbl8s
waiting in the defer queue.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 app/test/test_fib6.c | 246 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 246 insertions(+)

diff --git a/app/test/test_fib6.c b/app/test/test_fib6.c
index ad68645428..cc120a01f7 100644
--- a/app/test/test_fib6.c
+++ b/app/test/test_fib6.c
@@ -30,6 +30,9 @@ static int32_t test_drift_compression(void);
 static int32_t test_drift_multilevel(void);
 static int32_t test_drift_stress(void);
 static int32_t test_drift_tight_pool(void);
+static int32_t test_tbl8_install_peak(void);
+static int32_t test_tbl8_install_peak_dq(void);
+static int32_t test_tbl8_dq_modify(void);
 
 #define MAX_ROUTES	(1 << 16)
 /** Maximum number of tbl8 for 2-byte entries */
@@ -929,6 +932,246 @@ test_drift_tight_pool(void)
 	return TEST_SUCCESS;
 }
 
+/*
+ * Byte-aligned prefixes must not take a temporary tbl8: a /32 fits a pool of
+ * one, a /24 and a /16 still fit once the pool is full, and the /32 can be
+ * deleted from a full pool, giving its tbl8 back to a following /25.
+ */
+static int32_t
+test_tbl8_install_peak(void)
+{
+	struct rte_ipv6_addr aligned = RTE_IPV6(0x2001, 0x0db8, 0, 0, 0, 0, 0, 0);
+	struct rte_ipv6_addr p24 = RTE_IPV6(0x2002, 0x0100, 0, 0, 0, 0, 0, 0);
+	struct rte_ipv6_addr p16 = RTE_IPV6(0x2003, 0, 0, 0, 0, 0, 0, 0);
+	struct rte_ipv6_addr unaligned = RTE_IPV6(0xfc00, 0, 0, 0, 0, 0, 0, 0);
+	struct rte_fib6_conf config = { 0 };
+	struct rte_fib6 *fib;
+	uint64_t nh;
+	int ret;
+
+	config.max_routes = 16;
+	config.default_nh = 0;
+	config.type = RTE_FIB6_TRIE;
+	config.trie.nh_sz = RTE_FIB6_TRIE_2B;
+	config.trie.num_tbl8 = 1;
+
+	fib = rte_fib6_create("peak", SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
+
+	ret = rte_fib6_add(fib, &aligned, 33, 1);
+	RTE_TEST_ASSERT(ret == -ENOSPC, "/33 needs 2 Tbl8s, can not fit pool of 1 (ret=%d)\n", ret);
+	rte_fib6_lookup_bulk(fib, &aligned, &nh, 1);
+	RTE_TEST_ASSERT(nh == 0, "empty table lookup got nh=%u\n", (unsigned int)nh);
+
+	ret = rte_fib6_add(fib, &aligned, 32, 1);
+	RTE_TEST_ASSERT(ret == 0, "/32 must fit pool of 1 (ret=%d)\n", ret);
+	rte_fib6_lookup_bulk(fib, &aligned, &nh, 1);
+	RTE_TEST_ASSERT(nh == 1, "/32 lookup got nh=%u\n", (unsigned int)nh);
+
+	/* the pool is full, prefixes up to /24 need no tbl8 at all */
+	ret = rte_fib6_add(fib, &p24, 24, 2);
+	RTE_TEST_ASSERT(ret == 0, "/24 must fit full pool (ret=%d)\n", ret);
+	rte_fib6_lookup_bulk(fib, &p24, &nh, 1);
+	RTE_TEST_ASSERT(nh == 2, "/24 lookup got nh=%u\n", (unsigned int)nh);
+	ret = rte_fib6_add(fib, &p16, 16, 3);
+	RTE_TEST_ASSERT(ret == 0, "/16 must fit full pool (ret=%d)\n", ret);
+	rte_fib6_lookup_bulk(fib, &p16, &nh, 1);
+	RTE_TEST_ASSERT(nh == 3, "/16 lookup got nh=%u\n", (unsigned int)nh);
+
+	ret = rte_fib6_add(fib, &unaligned, 25, 4);
+	RTE_TEST_ASSERT(ret == -ENOSPC,
+		"/25 in full pool expected -ENOSPC, got %d\n", ret);
+	rte_fib6_lookup_bulk(fib, &unaligned, &nh, 1);
+	RTE_TEST_ASSERT(nh == 0,
+		"rejected /25 must leave the dataplane clean, got nh=%u\n",
+		(unsigned int)nh);
+
+	ret = rte_fib6_delete(fib, &aligned, 32);
+	RTE_TEST_ASSERT(ret == 0,
+		"/32 delete from full pool failed (ret=%d)\n", ret);
+	rte_fib6_lookup_bulk(fib, &aligned, &nh, 1);
+	RTE_TEST_ASSERT(nh == 0, "deleted /32 lookup got nh=%u\n",
+		(unsigned int)nh);
+
+	ret = rte_fib6_add(fib, &unaligned, 25, 4);
+	RTE_TEST_ASSERT(ret == 0,
+		"/25 must fit pool of 1 after /32 delete (ret=%d)\n", ret);
+	rte_fib6_lookup_bulk(fib, &unaligned, &nh, 1);
+	RTE_TEST_ASSERT(nh == 4, "/25 lookup got nh=%u\n", (unsigned int)nh);
+
+	rte_fib6_free(fib);
+	return TEST_SUCCESS;
+}
+
+/*
+ * In QSBR defer mode a freed group stays out of the pool until reclaimed, so
+ * rsvd_tbl8s underestimates occupancy. A /40 needing two groups must be
+ * refused by physical count without leaking, so a following /25 needing one
+ * group fits.
+ */
+static int32_t
+test_tbl8_install_peak_dq(void)
+{
+	struct rte_ipv6_addr a = RTE_IPV6(0x2001, 0x0db8, 0, 0, 0, 0, 0, 0);
+	struct rte_ipv6_addr b = RTE_IPV6(0xfc00, 0, 0, 0, 0, 0, 0, 0);
+	struct rte_ipv6_addr c = RTE_IPV6(0xfd00, 0, 0, 0, 0, 0, 0, 0);
+	struct rte_fib6_rcu_config rcu_cfg = { 0 };
+	struct rte_fib6_conf config = { 0 };
+	struct rte_rcu_qsbr *v;
+	struct rte_fib6 *fib;
+	uint64_t nh;
+	size_t sz;
+	int ret;
+
+	config.max_routes = 16;
+	config.default_nh = 0;
+	config.type = RTE_FIB6_TRIE;
+	config.trie.nh_sz = RTE_FIB6_TRIE_2B;
+	config.trie.num_tbl8 = 2;
+
+	fib = rte_fib6_create("peak_dq", SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
+
+	sz = rte_rcu_qsbr_get_memsize(1);
+	v = rte_zmalloc_socket(NULL, sz, RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+	RTE_TEST_ASSERT(v != NULL, "Can not allocate RCU\n");
+	ret = rte_rcu_qsbr_init(v, 1);
+	RTE_TEST_ASSERT(ret == 0, "Can not init RCU\n");
+	rcu_cfg.v = v;
+	rcu_cfg.mode = RTE_FIB6_QSBR_MODE_DQ;
+	ret = rte_fib6_rcu_qsbr_add(fib, &rcu_cfg);
+	RTE_TEST_ASSERT(ret == 0, "Can not attach RCU (ret=%d)\n", ret);
+
+	/* an online reader that never reports quiescence blocks reclamation */
+	rte_rcu_qsbr_thread_register(v, 0);
+	rte_rcu_qsbr_thread_online(v, 0);
+
+	ret = rte_fib6_add(fib, &b, 25, 1);
+	RTE_TEST_ASSERT(ret == 0, "/25 add failed (ret=%d)\n", ret);
+	ret = rte_fib6_delete(fib, &b, 25);
+	RTE_TEST_ASSERT(ret == 0, "/25 delete failed (ret=%d)\n", ret);
+	/* the /25 group is now deferred, still physically out of the pool */
+
+	ret = rte_fib6_add(fib, &a, 40, 2);
+	RTE_TEST_ASSERT(ret == -ENOSPC,
+		"/40 must be rejected while a group is deferred, got %d\n",
+		ret);
+	rte_fib6_lookup_bulk(fib, &a, &nh, 1);
+	RTE_TEST_ASSERT(nh == 0,
+		"rejected /40 must leave the dataplane clean, got nh=%u\n",
+		(unsigned int)nh);
+
+	/* a second /25 needs one group: it fits only if the /40 leaked nothing */
+	ret = rte_fib6_add(fib, &c, 25, 3);
+	RTE_TEST_ASSERT(ret == 0,
+		"2nd /25 rejected: /40 leaked a group under defer (ret=%d)\n",
+		ret);
+	rte_fib6_lookup_bulk(fib, &c, &nh, 1);
+	RTE_TEST_ASSERT(nh == 3, "2nd /25 lookup got nh=%u\n", (unsigned int)nh);
+
+	rte_rcu_qsbr_thread_offline(v, 0);
+	rte_rcu_qsbr_thread_unregister(v, 0);
+	rte_fib6_free(fib);
+	rte_free(v);
+	return TEST_SUCCESS;
+}
+
+/*
+ * In QSBR defer mode, changing or deleting a prefix may need tbl8 groups for
+ * its more specifics while the groups they used are still deferred. The
+ * update must be refused before it touches the dataplane, and succeed once
+ * the deferred groups are reclaimed.
+ */
+static int32_t
+test_tbl8_dq_modify(void)
+{
+	struct rte_ipv6_addr p24 = RTE_IPV6(0x2001, 0x0d00, 0, 0, 0, 0, 0, 0);
+	struct rte_ipv6_addr p32 = RTE_IPV6(0x2001, 0x0db8, 0, 0, 0, 0, 0, 0);
+	struct rte_ipv6_addr p33 = RTE_IPV6(0x2001, 0x0dff, 0, 0, 0, 0, 0, 0);
+	struct rte_fib6_rcu_config rcu_cfg = { 0 };
+	struct rte_fib6_conf config = { 0 };
+	struct rte_rcu_qsbr *v;
+	struct rte_fib6 *fib;
+	uint64_t nh;
+	size_t sz;
+	int ret;
+
+	config.max_routes = 16;
+	config.default_nh = 0;
+	config.type = RTE_FIB6_TRIE;
+	config.trie.nh_sz = RTE_FIB6_TRIE_2B;
+	config.trie.num_tbl8 = 3;
+
+	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
+
+	sz = rte_rcu_qsbr_get_memsize(1);
+	v = rte_zmalloc_socket(NULL, sz, RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+	RTE_TEST_ASSERT(v != NULL, "Can not allocate RCU\n");
+	ret = rte_rcu_qsbr_init(v, 1);
+	RTE_TEST_ASSERT(ret == 0, "Can not init RCU\n");
+	rcu_cfg.v = v;
+	rcu_cfg.mode = RTE_FIB6_QSBR_MODE_DQ;
+	ret = rte_fib6_rcu_qsbr_add(fib, &rcu_cfg);
+	RTE_TEST_ASSERT(ret == 0, "Can not attach RCU (ret=%d)\n", ret);
+
+	/* an online reader that never reports quiescence blocks reclamation */
+	rte_rcu_qsbr_thread_register(v, 0);
+	rte_rcu_qsbr_thread_online(v, 0);
+
+	ret = rte_fib6_add(fib, &p24, 24, 3);
+	RTE_TEST_ASSERT(ret == 0, "/24 add failed (ret=%d)\n", ret);
+	ret = rte_fib6_add(fib, &p32, 32, 5);
+	RTE_TEST_ASSERT(ret == 0, "/32 add failed (ret=%d)\n", ret);
+	ret = rte_fib6_add(fib, &p33, 33, 5);
+	RTE_TEST_ASSERT(ret == 0, "/33 add failed (ret=%d)\n", ret);
+
+	/*
+	 * Moving the /32 and /33 to the /24 next hop frees their two groups,
+	 * which stay deferred. One group is left in the pool.
+	 */
+	ret = rte_fib6_add(fib, &p32, 32, 3);
+	RTE_TEST_ASSERT(ret == 0, "/32 next hop change failed (ret=%d)\n", ret);
+	ret = rte_fib6_add(fib, &p33, 33, 3);
+	RTE_TEST_ASSERT(ret == 0, "/33 next hop change failed (ret=%d)\n", ret);
+
+	/* changing or deleting the /24 needs two groups for the /32 and /33 */
+	ret = rte_fib6_add(fib, &p24, 24, 7);
+	RTE_TEST_ASSERT(ret == -ENOSPC,
+		"/24 next hop change expected -ENOSPC, got %d\n", ret);
+	rte_fib6_lookup_bulk(fib, &p24, &nh, 1);
+	RTE_TEST_ASSERT(nh == 3,
+		"rejected /24 change must leave the dataplane intact, got nh=%u\n",
+		(unsigned int)nh);
+
+	ret = rte_fib6_delete(fib, &p24, 24);
+	RTE_TEST_ASSERT(ret == -ENOSPC,
+		"/24 delete expected -ENOSPC, got %d\n", ret);
+	rte_fib6_lookup_bulk(fib, &p24, &nh, 1);
+	RTE_TEST_ASSERT(nh == 3,
+		"rejected /24 delete must leave the dataplane intact, got nh=%u\n",
+		(unsigned int)nh);
+
+	/* the reader reports quiescence, the deferred groups can be reclaimed */
+	rte_rcu_qsbr_quiescent(v, 0);
+
+	ret = rte_fib6_delete(fib, &p24, 24);
+	RTE_TEST_ASSERT(ret == 0, "/24 delete failed (ret=%d)\n", ret);
+	rte_fib6_lookup_bulk(fib, &p24, &nh, 1);
+	RTE_TEST_ASSERT(nh == 0, "deleted /24 lookup got nh=%u\n",
+		(unsigned int)nh);
+	rte_fib6_lookup_bulk(fib, &p32, &nh, 1);
+	RTE_TEST_ASSERT(nh == 3, "/32 lookup got nh=%u\n", (unsigned int)nh);
+	rte_fib6_lookup_bulk(fib, &p33, &nh, 1);
+	RTE_TEST_ASSERT(nh == 3, "/33 lookup got nh=%u\n", (unsigned int)nh);
+
+	rte_rcu_qsbr_thread_offline(v, 0);
+	rte_rcu_qsbr_thread_unregister(v, 0);
+	rte_fib6_free(fib);
+	rte_free(v);
+	return TEST_SUCCESS;
+}
+
 static struct unit_test_suite fib6_fast_tests = {
 	.suite_name = "fib6 autotest",
 	.setup = NULL,
@@ -946,6 +1189,9 @@ static struct unit_test_suite fib6_fast_tests = {
 	TEST_CASE(test_drift_multilevel),
 	TEST_CASE(test_drift_stress),
 	TEST_CASE(test_drift_tight_pool),
+	TEST_CASE(test_tbl8_install_peak),
+	TEST_CASE(test_tbl8_install_peak_dq),
+	TEST_CASE(test_tbl8_dq_modify),
 	TEST_CASES_END()
 	}
 };
-- 
2.43.0

