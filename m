Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96B3C5CFDB
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 07:47:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8FBC44026A;
	Thu, 13 Aug 2026 09:47:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 0F9804014F
 for <dev@dpdk.org>; Thu, 13 Aug 2026 09:47:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786607242; x=1818143242;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ovmFlb5jM7G6mB7IYlwuIyEPomKK/iwoxpue6G0V83k=;
 b=IKTEYmhlcRjM9JqN7xWmaMgpKFXThP99t75WbLqdg03cMn6+fMEtIgAX
 B3heHsZWsPoEpRwilLxwlLHvCsyV6rV+carrWavoy/X4FCAW0BwZziuVc
 0meHDMGhulejdRBdwrUsAppSs8E9u2BTVAeIbU10uqsAGLzTHqUPOt04o
 h80QA8TzHxwPbZ7yPd/Mvq2ZM9lT3Va22+lweX8SGbybf6OJUn9TCJUXf
 W+UuXxqACGk0dUjo4Grb4B3RptbC792BA7jEejPBQukn+FNzDANO0c/Xh
 eDH5EPacutZcqwYxFMJ99s6+pCx2l0jyKdYviTLFgHti2fFpHhHSAEDjk A==;
X-CSE-ConnectionGUID: wWNvJC6hRcOHRm/65liPuA==
X-CSE-MsgGUID: yYZxczafSYa5wDT+aLxttQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="86293781"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; d="scan'208";a="86293781"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 00:47:21 -0700
X-CSE-ConnectionGUID: 7ItO5WQZTYuRSVc0kuCoSw==
X-CSE-MsgGUID: QOZKbtUeTRGfa9PMTCY7Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; d="scan'208";a="264447383"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by orviesa009.jf.intel.com with ESMTP; 13 Aug 2026 00:47:18 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, mb@smartsharesystems.com,
 vladimir.medvedkin@intel.com, Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH v2] fib, rib: fix name prefixes
Date: Thu, 13 Aug 2026 07:46:26 +0000
Message-Id: <20260813074626.1134195-1-anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812110258.1128632-1-anurag.mandal@intel.com>
References: <20260812110258.1128632-1-anurag.mandal@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The RIB library named the mempool holding its nodes "MP_<name>".
That prefix is the one the mempool library itself prepends to
the backing memzone, so the memzone ended up named
"MP_MP_<name>" which is improper.

The FIB library passed its own name unchanged to the underlying
RIB and did not add a prefix to the RIB name.

This patch makes name each object after its owner.
The node mempool of a RIB is now "RIB_<name>" or "RIB6_<name>",
and the RIB owned by a FIB is now "FIB_<name>" or "FIB6_<name>".

A mempool name is limited to RTE_MEMPOOL_NAMESIZE, which is much
shorter than RTE_RIB_NAMESIZE.
The name was passed down silently and an oversized one surfaced
as an opaque rte_mempool_create() failure, so check the derived
name up front and return ENAMETOOLONG instead.
As the prefixes above are added on top of the name, the new
maximum length of a name is limited to the following:
RIB : 21 characters
RIB6: 20 characters
FIB : 17 characters
FIB6: 15 characters
Hence, shortening  the names used by the graph nodes, the l3fwd
example and the unit tests accordingly.

Bugzilla ID: 1981 1982
Fixes: 5a5793a5ffa2 ("rib: add RIB library")
Fixes: f7e861e21c46 ("rib: support IPv6")
Fixes: 39e927248416 ("fib: add FIB library")
Fixes: 40d41a8a7b34 ("fib: support IPv6")

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
---
V2: Addressed Morten Brørup's review comments

 app/test/test_fib.c                    | 34 ++++++++++-----------
 app/test/test_fib6.c                   | 42 +++++++++++++-------------
 doc/guides/rel_notes/release_26_11.rst | 14 +++++++++
 examples/l3fwd/l3fwd_fib.c             |  4 +--
 lib/fib/rte_fib.c                      | 16 ++++++++--
 lib/fib/rte_fib6.c                     | 16 ++++++++--
 lib/node/ip4_lookup_fib.c              |  4 +--
 lib/node/ip6_lookup_fib.c              |  4 +--
 lib/rib/rte_rib.c                      | 14 +++++++--
 lib/rib/rte_rib6.c                     | 14 +++++++--
 10 files changed, 108 insertions(+), 54 deletions(-)

diff --git a/app/test/test_fib.c b/app/test/test_fib.c
index bd73399d56..3f5bbb3061 100644
--- a/app/test/test_fib.c
+++ b/app/test/test_fib.c
@@ -49,24 +49,24 @@ test_create_invalid(void)
 		"Call succeeded with invalid parameters\n");
 
 	/* rte_fib_create: config == NULL */
-	fib = rte_fib_create(__func__, SOCKET_ID_ANY, NULL);
+	fib = rte_fib_create("test_create_inv", SOCKET_ID_ANY, NULL);
 	RTE_TEST_ASSERT(fib == NULL,
 		"Call succeeded with invalid parameters\n");
 
 	/* socket_id < -1 is invalid */
-	fib = rte_fib_create(__func__, -2, &config);
+	fib = rte_fib_create("test_create_inv", -2, &config);
 	RTE_TEST_ASSERT(fib == NULL,
 		"Call succeeded with invalid parameters\n");
 
 	/* rte_fib_create: max_routes = 0 */
 	config.max_routes = 0;
-	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib_create("test_create_inv", SOCKET_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib == NULL,
 		"Call succeeded with invalid parameters\n");
 	config.max_routes = MAX_ROUTES;
 
 	config.type = RTE_FIB_DIR24_8 + 1;
-	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib_create("test_create_inv", SOCKET_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib == NULL,
 		"Call succeeded with invalid parameters\n");
 
@@ -74,13 +74,13 @@ test_create_invalid(void)
 	config.dir24_8.num_tbl8 = MAX_TBL8;
 
 	config.dir24_8.nh_sz = RTE_FIB_DIR24_8_8B + 1;
-	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib_create("test_create_inv", SOCKET_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib == NULL,
 		"Call succeeded with invalid parameters\n");
 	config.dir24_8.nh_sz = RTE_FIB_DIR24_8_8B;
 
 	config.dir24_8.num_tbl8 = 0;
-	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib_create("test_create_inv", SOCKET_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib == NULL,
 		"Call succeeded with invalid parameters\n");
 
@@ -104,7 +104,7 @@ test_multiple_create(void)
 
 	for (i = 0; i < 100; i++) {
 		config.max_routes = MAX_ROUTES - i;
-		fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+		fib = rte_fib_create("test_mult_create", SOCKET_ID_ANY, &config);
 		RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 		rte_fib_free(fib);
 	}
@@ -129,7 +129,7 @@ test_free_null(void)
 	config.default_nh = 0;
 	config.type = RTE_FIB_DUMMY;
 
-	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib_create("test_free_null", SOCKET_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 
 	rte_fib_free(fib);
@@ -167,7 +167,7 @@ test_add_del_invalid(void)
 		"Call succeeded with invalid parameters\n");
 
 	/*Create valid fib to use in rest of test. */
-	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib_create("test_add_del_inv", SOCKET_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 
 	/* rte_fib_add: depth > RTE_FIB_MAXDEPTH */
@@ -331,7 +331,7 @@ test_lookup(void)
 	config.default_nh = def_nh;
 	config.type = RTE_FIB_DUMMY;
 
-	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib_create("test_lookup", SOCKET_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 	ret = check_fib(fib);
 	RTE_TEST_ASSERT(ret == TEST_SUCCESS,
@@ -342,7 +342,7 @@ test_lookup(void)
 
 	config.dir24_8.nh_sz = RTE_FIB_DIR24_8_1B;
 	config.dir24_8.num_tbl8 = 127;
-	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib_create("test_lookup", SOCKET_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 	ret = check_fib(fib);
 	RTE_TEST_ASSERT(ret == TEST_SUCCESS,
@@ -351,7 +351,7 @@ test_lookup(void)
 
 	config.dir24_8.nh_sz = RTE_FIB_DIR24_8_2B;
 	config.dir24_8.num_tbl8 = MAX_TBL8 - 1;
-	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib_create("test_lookup", SOCKET_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 	ret = check_fib(fib);
 	RTE_TEST_ASSERT(ret == TEST_SUCCESS,
@@ -360,7 +360,7 @@ test_lookup(void)
 
 	config.dir24_8.nh_sz = RTE_FIB_DIR24_8_4B;
 	config.dir24_8.num_tbl8 = MAX_TBL8;
-	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib_create("test_lookup", SOCKET_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 	ret = check_fib(fib);
 	RTE_TEST_ASSERT(ret == TEST_SUCCESS,
@@ -369,7 +369,7 @@ test_lookup(void)
 
 	config.dir24_8.nh_sz = RTE_FIB_DIR24_8_8B;
 	config.dir24_8.num_tbl8 = MAX_TBL8;
-	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib_create("test_lookup", SOCKET_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 	ret = check_fib(fib);
 	RTE_TEST_ASSERT(ret == TEST_SUCCESS,
@@ -401,7 +401,7 @@ test_invalid_rcu(void)
 	config.rib_ext_sz = 0;
 	config.default_nh = def_nh;
 
-	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib_create("test_invalid_rcu", SOCKET_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 
 	/* Create RCU QSBR variable */
@@ -426,7 +426,7 @@ test_invalid_rcu(void)
 	config.type = RTE_FIB_DIR24_8;
 	config.dir24_8.nh_sz = RTE_FIB_DIR24_8_4B;
 	config.dir24_8.num_tbl8 = MAX_TBL8;
-	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib_create("test_invalid_rcu", SOCKET_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 
 	/* Call rte_fib_rcu_qsbr_add without fib or config */
@@ -532,7 +532,7 @@ test_fib_rcu_sync_rw(void)
 	config.dir24_8.nh_sz = RTE_FIB_DIR24_8_4B;
 	config.dir24_8.num_tbl8 = 1;
 
-	g_fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	g_fib = rte_fib_create("test_rcu_sync_rw", SOCKET_ID_ANY, &config);
 	RTE_TEST_ASSERT(g_fib != NULL, "Failed to create FIB\n");
 
 	/* Create RCU QSBR variable */
diff --git a/app/test/test_fib6.c b/app/test/test_fib6.c
index ad68645428..32937a7c99 100644
--- a/app/test/test_fib6.c
+++ b/app/test/test_fib6.c
@@ -56,24 +56,24 @@ test_create_invalid(void)
 		"Call succeeded with invalid parameters\n");
 
 	/* rte_fib6_create: config == NULL */
-	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, NULL);
+	fib = rte_fib6_create("test_create_inv", SOCKET_ID_ANY, NULL);
 	RTE_TEST_ASSERT(fib == NULL,
 		"Call succeeded with invalid parameters\n");
 
 	/* socket_id < -1 is invalid */
-	fib = rte_fib6_create(__func__, -2, &config);
+	fib = rte_fib6_create("test_create_inv", -2, &config);
 	RTE_TEST_ASSERT(fib == NULL,
 		"Call succeeded with invalid parameters\n");
 
 	/* rte_fib6_create: max_routes = 0 */
 	config.max_routes = 0;
-	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib6_create("test_create_inv", SOCKET_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib == NULL,
 		"Call succeeded with invalid parameters\n");
 	config.max_routes = MAX_ROUTES;
 
 	config.type = RTE_FIB6_TRIE + 1;
-	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib6_create("test_create_inv", SOCKET_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib == NULL,
 		"Call succeeded with invalid parameters\n");
 
@@ -81,13 +81,13 @@ test_create_invalid(void)
 	config.trie.num_tbl8 = MAX_TBL8;
 
 	config.trie.nh_sz = RTE_FIB6_TRIE_8B + 1;
-	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib6_create("test_create_inv", SOCKET_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib == NULL,
 		"Call succeeded with invalid parameters\n");
 	config.trie.nh_sz = RTE_FIB6_TRIE_8B;
 
 	config.trie.num_tbl8 = 0;
-	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib6_create("test_create_inv", SOCKET_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib == NULL,
 		"Call succeeded with invalid parameters\n");
 
@@ -111,7 +111,7 @@ test_multiple_create(void)
 
 	for (i = 0; i < 100; i++) {
 		config.max_routes = MAX_ROUTES - i;
-		fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+		fib = rte_fib6_create("test_mult_crt", SOCKET_ID_ANY, &config);
 		RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 		rte_fib6_free(fib);
 	}
@@ -136,7 +136,7 @@ test_free_null(void)
 	config.default_nh = 0;
 	config.type = RTE_FIB6_DUMMY;
 
-	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib6_create("test_free_null", SOCKET_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 
 	rte_fib6_free(fib);
@@ -175,7 +175,7 @@ test_add_del_invalid(void)
 		"Call succeeded with invalid parameters\n");
 
 	/*Create valid fib to use in rest of test. */
-	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib6_create("test_adddel_inv", SOCKET_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 
 	/* rte_fib6_add: depth > RTE_IPV6_MAX_DEPTH */
@@ -356,7 +356,7 @@ test_lookup(void)
 	config.default_nh = def_nh;
 	config.type = RTE_FIB6_DUMMY;
 
-	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib6_create("test_lookup", SOCKET_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 	ret = check_fib(fib);
 	RTE_TEST_ASSERT(ret == TEST_SUCCESS,
@@ -367,7 +367,7 @@ test_lookup(void)
 
 	config.trie.nh_sz = RTE_FIB6_TRIE_2B;
 	config.trie.num_tbl8 = MAX_TBL8 - 1;
-	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib6_create("test_lookup", SOCKET_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 	ret = check_fib(fib);
 	RTE_TEST_ASSERT(ret == TEST_SUCCESS,
@@ -376,7 +376,7 @@ test_lookup(void)
 
 	config.trie.nh_sz = RTE_FIB6_TRIE_4B;
 	config.trie.num_tbl8 = MAX_TBL8;
-	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib6_create("test_lookup", SOCKET_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 	ret = check_fib(fib);
 	RTE_TEST_ASSERT(ret == TEST_SUCCESS,
@@ -385,7 +385,7 @@ test_lookup(void)
 
 	config.trie.nh_sz = RTE_FIB6_TRIE_8B;
 	config.trie.num_tbl8 = MAX_TBL8;
-	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib6_create("test_lookup", SOCKET_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 	ret = check_fib(fib);
 	RTE_TEST_ASSERT(ret == TEST_SUCCESS,
@@ -417,7 +417,7 @@ test_invalid_rcu(void)
 	config.rib_ext_sz = 0;
 	config.default_nh = def_nh;
 
-	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib6_create("test_inval_rcu", SOCKET_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 
 	/* Create RCU QSBR variable */
@@ -442,7 +442,7 @@ test_invalid_rcu(void)
 	config.type = RTE_FIB6_TRIE;
 	config.trie.nh_sz = RTE_FIB6_TRIE_4B;
 	config.trie.num_tbl8 = MAX_TBL8;
-	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib6_create("test_inval_rcu", SOCKET_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 
 	/* Call rte_fib6_rcu_qsbr_add without fib or config */
@@ -548,7 +548,7 @@ test_fib_rcu_sync_rw(void)
 	config.trie.nh_sz = RTE_FIB6_TRIE_4B;
 	config.trie.num_tbl8 = 1;
 
-	g_fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	g_fib = rte_fib6_create("test_rcu_sync", SOCKET_ID_ANY, &config);
 	RTE_TEST_ASSERT(g_fib != NULL, "Failed to create FIB\n");
 
 	/* Create RCU QSBR variable */
@@ -642,7 +642,7 @@ test_drift(void)
 	config.trie.nh_sz = RTE_FIB6_TRIE_2B;
 	config.trie.num_tbl8 = 256;
 
-	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib6_create("test_drift", SOCKET_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 
 	ret = rte_fib6_add(fib, &parent, 28, 0xa);
@@ -706,7 +706,7 @@ test_drift_compression(void)
 	config.trie.nh_sz = RTE_FIB6_TRIE_2B;
 	config.trie.num_tbl8 = 256;
 
-	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib6_create("test_drift_comp", SOCKET_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 
 	/* Compressed: child shares the parent's nh, modify_dp is skipped */
@@ -767,7 +767,7 @@ test_drift_multilevel(void)
 	config.trie.nh_sz = RTE_FIB6_TRIE_2B;
 	config.trie.num_tbl8 = 256;
 
-	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib6_create("test_drift_ml", SOCKET_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 
 	ret = rte_fib6_add(fib, &grand, 28, 1);
@@ -831,7 +831,7 @@ test_drift_stress(void)
 	config.trie.nh_sz = RTE_FIB6_TRIE_2B;
 	config.trie.num_tbl8 = 256;
 
-	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib6_create("test_drift_str", SOCKET_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 
 	for (i = 0; i < 2000; i++) {
@@ -902,7 +902,7 @@ test_drift_tight_pool(void)
 	config.trie.nh_sz = RTE_FIB6_TRIE_2B;
 	config.trie.num_tbl8 = 3;
 
-	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib6_create("test_drift_tp", SOCKET_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 
 	ret = rte_fib6_add(fib, &parent, 28, 1);
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c8cc86295d..67ad23eaa3 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -93,6 +93,20 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* rib: The node mempool created by ``rte_rib_create()`` and ``rte_rib6_create()``
+  is now named ``RIB_<name>`` and ``RIB6_<name>`` instead of ``MP_<name>``.
+
+* fib: The RIB created by ``rte_fib_create()`` and ``rte_fib6_create()``
+  is now named ``FIB_<name>`` and ``FIB6_<name>``.
+
+* rib, fib: The name of a RIB, RIB6, FIB or FIB6 is used to derive the name of
+  its node mempool, which is bounded by ``RTE_MEMPOOL_NAMESIZE``.
+  As the prefixes above are added on top of the name,the new maximum length of
+  a name are the following:
+  RIB  - 21 characters.
+  RIB6 - 20 characters.
+  FIB  - 17 characters.
+  FIB6 - 15 characters.
 
 ABI Changes
 -----------
diff --git a/examples/l3fwd/l3fwd_fib.c b/examples/l3fwd/l3fwd_fib.c
index 4fc6bf90d5..0ff5c2c6de 100644
--- a/examples/l3fwd/l3fwd_fib.c
+++ b/examples/l3fwd/l3fwd_fib.c
@@ -654,7 +654,7 @@ setup_fib(const int socketid)
 	config_ipv4.default_nh = FIB_DEFAULT_HOP;
 	config_ipv4.dir24_8.nh_sz = RTE_FIB_DIR24_8_4B;
 	config_ipv4.dir24_8.num_tbl8 = (1 << 15);
-	snprintf(s, sizeof(s), "IPV4_L3FWD_FIB_%d", socketid);
+	snprintf(s, sizeof(s), "L3FWD_FIB_%d", socketid);
 	ipv4_l3fwd_fib_lookup_struct[socketid] =
 			rte_fib_create(s, socketid, &config_ipv4);
 	if (ipv4_l3fwd_fib_lookup_struct[socketid] == NULL)
@@ -705,7 +705,7 @@ setup_fib(const int socketid)
 	/* >8 End of setup fib. */
 
 	/* Create the fib IPv6 table. */
-	snprintf(s, sizeof(s), "IPV6_L3FWD_FIB_%d", socketid);
+	snprintf(s, sizeof(s), "L3FWD_FIB6_%d", socketid);
 
 	config.type = RTE_FIB6_TRIE;
 	config.max_routes = (1 << 16) - 1;
diff --git a/lib/fib/rte_fib.c b/lib/fib/rte_fib.c
index 184210f380..7a587820ad 100644
--- a/lib/fib/rte_fib.c
+++ b/lib/fib/rte_fib.c
@@ -37,6 +37,9 @@ EAL_REGISTER_TAILQ(rte_fib_tailq)
 #define FIB_RETURN_IF_TRUE(cond, retval)
 #endif
 
+/* Prefix used for the memory objects owned by a FIB. */
+#define FIB_MEM_PREFIX		"FIB_"
+
 struct rte_fib {
 	char			name[RTE_FIB_NAMESIZE];
 	enum rte_fib_type	type;	/**< Type of FIB struct */
@@ -173,14 +176,21 @@ rte_fib_create(const char *name, int socket_id, struct rte_fib_conf *conf)
 	rib_conf.ext_sz = conf->rib_ext_sz;
 	rib_conf.max_nodes = conf->max_routes * 2;
 
-	rib = rte_rib_create(name, socket_id, &rib_conf);
+	/* Add FIB Prefix to its mempool name */
+	ret = snprintf(mem_name, sizeof(mem_name), FIB_MEM_PREFIX "%s", name);
+	if (ret < 0 || ret >= (int)sizeof(mem_name)) {
+		FIB_LOG(ERR, "FIB name %s is too long", name);
+		rte_errno = ENAMETOOLONG;
+		return NULL;
+	}
+
+	rib = rte_rib_create(mem_name, socket_id, &rib_conf);
 	if (rib == NULL) {
 		FIB_LOG(ERR,
-			"Can not allocate RIB %s", name);
+			"Can not allocate RIB for FIB: %s", mem_name);
 		return NULL;
 	}
 
-	snprintf(mem_name, sizeof(mem_name), "FIB_%s", name);
 	fib_list = RTE_TAILQ_CAST(rte_fib_tailq.head, rte_fib_list);
 
 	rte_mcfg_tailq_write_lock();
diff --git a/lib/fib/rte_fib6.c b/lib/fib/rte_fib6.c
index 770becdb61..1a31ab09aa 100644
--- a/lib/fib/rte_fib6.c
+++ b/lib/fib/rte_fib6.c
@@ -37,6 +37,9 @@ EAL_REGISTER_TAILQ(rte_fib6_tailq)
 #define FIB6_RETURN_IF_TRUE(cond, retval)
 #endif
 
+/* Prefix used for the memory objects owned by a FIB6. */
+#define FIB6_MEM_PREFIX		"FIB6_"
+
 struct rte_fib6 {
 	char			name[RTE_FIB6_NAMESIZE];
 	enum rte_fib6_type	type;	/**< Type of FIB struct */
@@ -172,14 +175,21 @@ rte_fib6_create(const char *name, int socket_id, struct rte_fib6_conf *conf)
 	rib_conf.ext_sz = conf->rib_ext_sz;
 	rib_conf.max_nodes = conf->max_routes * 2;
 
-	rib = rte_rib6_create(name, socket_id, &rib_conf);
+	/* Add FIB6 Prefix to its mempool name */
+	ret = snprintf(mem_name, sizeof(mem_name), FIB6_MEM_PREFIX "%s", name);
+	if (ret < 0 || ret >= (int)sizeof(mem_name)) {
+		FIB_LOG(ERR, "FIB6 name %s is too long", name);
+		rte_errno = ENAMETOOLONG;
+		return NULL;
+	}
+
+	rib = rte_rib6_create(mem_name, socket_id, &rib_conf);
 	if (rib == NULL) {
 		FIB_LOG(ERR,
-			"Can not allocate RIB %s", name);
+			"Can not allocate RIB6 for FIB6 %s", mem_name);
 		return NULL;
 	}
 
-	snprintf(mem_name, sizeof(mem_name), "FIB6_%s", name);
 	fib_list = RTE_TAILQ_CAST(rte_fib6_tailq.head, rte_fib6_list);
 
 	rte_mcfg_tailq_write_lock();
diff --git a/lib/node/ip4_lookup_fib.c b/lib/node/ip4_lookup_fib.c
index 0857d889fc..750bf69255 100644
--- a/lib/node/ip4_lookup_fib.c
+++ b/lib/node/ip4_lookup_fib.c
@@ -205,7 +205,7 @@ rte_node_ip4_fib_create(int socket, struct rte_fib_conf *conf)
 		return 0;
 
 	conf->default_nh = FIB_DEFAULT_NH;
-	snprintf(s, sizeof(s), "IPV4_LOOKUP_FIB_%d", socket);
+	snprintf(s, sizeof(s), "IP4_FIB_%d", socket);
 	nm->fib[socket] = rte_fib_create(s, socket, conf);
 	if (nm->fib[socket] == NULL)
 		return -rte_errno;
@@ -266,7 +266,7 @@ setup_fib(int socket)
 	conf.dir24_8.nh_sz = RTE_FIB_DIR24_8_4B;
 	conf.dir24_8.num_tbl8 = FIB_DEFAULT_NUM_TBL8;
 	conf.flags = 0;
-	snprintf(s, sizeof(s), "IPV4_LOOKUP_FIB_%d", socket);
+	snprintf(s, sizeof(s), "IP4_FIB_%d", socket);
 	nm->fib[socket] = rte_fib_create(s, socket, &conf);
 	if (nm->fib[socket] == NULL)
 		return -rte_errno;
diff --git a/lib/node/ip6_lookup_fib.c b/lib/node/ip6_lookup_fib.c
index 40c5c753df..f460838396 100644
--- a/lib/node/ip6_lookup_fib.c
+++ b/lib/node/ip6_lookup_fib.c
@@ -199,7 +199,7 @@ rte_node_ip6_fib_create(int socket, struct rte_fib6_conf *conf)
 		return 0;
 
 	conf->default_nh = FIB6_DEFAULT_NH;
-	snprintf(s, sizeof(s), "IPV6_LOOKUP_FIB_%u", socket);
+	snprintf(s, sizeof(s), "IP6_FIB_%u", socket);
 	nm->fib6[socket] = rte_fib6_create(s, socket, conf);
 	if (nm->fib6[socket] == NULL)
 		return -rte_errno;
@@ -257,7 +257,7 @@ setup_fib6(int socket)
 	conf.rib_ext_sz = 0;
 	conf.trie.nh_sz = RTE_FIB6_TRIE_4B;
 	conf.trie.num_tbl8 = FIB6_DEFAULT_NUM_TBL8;
-	snprintf(s, sizeof(s), "IPV6_LOOKUP_FIB_%u", socket);
+	snprintf(s, sizeof(s), "IP6_FIB_%u", socket);
 	nm->fib6[socket] = rte_fib6_create(s, socket, &conf);
 	if (nm->fib6[socket] == NULL)
 		return -rte_errno;
diff --git a/lib/rib/rte_rib.c b/lib/rib/rte_rib.c
index 046db131ca..55802f0060 100644
--- a/lib/rib/rte_rib.c
+++ b/lib/rib/rte_rib.c
@@ -32,6 +32,8 @@ EAL_REGISTER_TAILQ(rte_rib_tailq)
 #define RIB_MAXDEPTH		32
 /* Maximum length of a RIB name. */
 #define RTE_RIB_NAMESIZE	64
+/* Prefix used for the memory objects owned by a RIB. */
+#define RIB_MEM_PREFIX		"RIB_"
 
 struct rte_rib_node {
 	struct rte_rib_node	*left;
@@ -417,6 +419,7 @@ rte_rib_create(const char *name, int socket_id, const struct rte_rib_conf *conf)
 	struct rte_tailq_entry *te;
 	struct rte_rib_list *rib_list;
 	struct rte_mempool *node_pool;
+	int ret;
 
 	/* Check user arguments. */
 	if (unlikely(name == NULL || conf == NULL || conf->max_nodes <= 0)) {
@@ -424,7 +427,15 @@ rte_rib_create(const char *name, int socket_id, const struct rte_rib_conf *conf)
 		return NULL;
 	}
 
-	snprintf(mem_name, sizeof(mem_name), "MP_%s", name);
+	/* Add RIB Prefix to its node mempool name */
+	ret = snprintf(mem_name, sizeof(mem_name), RIB_MEM_PREFIX "%s", name);
+	if (unlikely(ret < 0 || ret >= (int)RTE_MEMPOOL_NAMESIZE)) {
+		RIB_LOG(ERR, "RIB name %s is too long, limit is %zu characters",
+			name, RTE_MEMPOOL_NAMESIZE - sizeof(RIB_MEM_PREFIX));
+		rte_errno = ENAMETOOLONG;
+		return NULL;
+	}
+
 	node_pool = rte_mempool_create(mem_name, conf->max_nodes,
 		sizeof(struct rte_rib_node) + conf->ext_sz, 0, 0,
 		NULL, NULL, NULL, NULL, socket_id, 0);
@@ -435,7 +446,6 @@ rte_rib_create(const char *name, int socket_id, const struct rte_rib_conf *conf)
 		return NULL;
 	}
 
-	snprintf(mem_name, sizeof(mem_name), "RIB_%s", name);
 	rib_list = RTE_TAILQ_CAST(rte_rib_tailq.head, rte_rib_list);
 
 	rte_mcfg_tailq_write_lock();
diff --git a/lib/rib/rte_rib6.c b/lib/rib/rte_rib6.c
index 918ddbdfd3..7d9a0ba36f 100644
--- a/lib/rib/rte_rib6.c
+++ b/lib/rib/rte_rib6.c
@@ -24,6 +24,8 @@
 #define RTE_RIB_VALID_NODE	1
 /* Maximum length of a RIB6 name. */
 #define RTE_RIB6_NAMESIZE	64
+/* Prefix used for the memory objects owned by a RIB6. */
+#define RIB6_MEM_PREFIX		"RIB6_"
 
 TAILQ_HEAD(rte_rib6_list, rte_tailq_entry);
 static struct rte_tailq_elem rte_rib6_tailq = {
@@ -480,6 +482,7 @@ rte_rib6_create(const char *name, int socket_id,
 	struct rte_tailq_entry *te;
 	struct rte_rib6_list *rib6_list;
 	struct rte_mempool *node_pool;
+	int ret;
 
 	/* Check user arguments. */
 	if (unlikely(name == NULL || conf == NULL || conf->max_nodes <= 0)) {
@@ -487,7 +490,15 @@ rte_rib6_create(const char *name, int socket_id,
 		return NULL;
 	}
 
-	snprintf(mem_name, sizeof(mem_name), "MP_%s", name);
+	/* Add RIB6 Prefix to its node mempool name */
+	ret = snprintf(mem_name, sizeof(mem_name), RIB6_MEM_PREFIX "%s", name);
+	if (unlikely(ret < 0 || ret >= (int)RTE_MEMPOOL_NAMESIZE)) {
+		RIB_LOG(ERR, "RIB6 name %s is too long, limit is %zu characters",
+			name, RTE_MEMPOOL_NAMESIZE - sizeof(RIB6_MEM_PREFIX));
+		rte_errno = ENAMETOOLONG;
+		return NULL;
+	}
+
 	node_pool = rte_mempool_create(mem_name, conf->max_nodes,
 		sizeof(struct rte_rib6_node) + conf->ext_sz, 0, 0,
 		NULL, NULL, NULL, NULL, socket_id, 0);
@@ -498,7 +509,6 @@ rte_rib6_create(const char *name, int socket_id,
 		return NULL;
 	}
 
-	snprintf(mem_name, sizeof(mem_name), "RIB6_%s", name);
 	rib6_list = RTE_TAILQ_CAST(rte_rib6_tailq.head, rte_rib6_list);
 
 	rte_mcfg_tailq_write_lock();
-- 
2.34.1

