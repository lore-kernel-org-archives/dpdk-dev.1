Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6CE606A339
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Nov 2026 18:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YN/fJtMi
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2695140A72;
	Tue, 24 Nov 2026 19:03:44 +0100 (CET)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by mails.dpdk.org (Postfix) with ESMTPS id 55C064067A
 for <dev@dpdk.org>; Tue, 24 Nov 2026 19:03:42 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4bb70074ab2so52594365e9.0
 for <dev@dpdk.org>; Tue, 24 Nov 2026 10:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795543422; x=1796148222; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+KYfctzgFZl4tesama/IikG+iK5p6yp/i8x69pE0RRw=;
 b=YN/fJtMiVHA3of4o6QQRKhEYVKAUkLveCfHDeFopE3UbWLM7qMFmjWV+D25OWQlo9U
 u787aBAFfeQAWOJuQ8k5MVDrVCCI69hXrfJ4wZeApwvvR/DVAiKmbxDMIe6G7H6r1sHk
 afLveVXEiMq3/da8rVexr1rW/hLHy6tM7+6tfEb5fAwK6iH+aJ05O5VhY15cRhOzWYPS
 2bRIjbW7ej501yD969Txfi5hbxhetMs35Iu5PN1M0yDJJJeqAAHtfqUpV8JO+M8IJgli
 eGwr27nr2ILWlU64nZV9EkjWnWImzF5pBKQOU9V0YSyjyqed6RBwFjz4NjqRaVy5JUA1
 TYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795543422; x=1796148222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+KYfctzgFZl4tesama/IikG+iK5p6yp/i8x69pE0RRw=;
 b=vw5NqQ1NxEIo5LW9ITd2HLm8B5HvaVHebexHibi5qOoUmML6uyDQuDZFhMmTuVH50Q
 +9efPW4op/2+6XFgLpfHkhUV5CPsFtGz5g6EtovSMNJ/HZO701cQqRakXlTvM4jHS+aR
 pWAv/SYF/lCzI9mEII/PXAtGKDbKkbGktmMTkoUWbE5ivZPsAUwZQqTvAuS28jMRlwlK
 rbmlp5TPTllj53URfGLanNA9UsZCFctabA9zGlG1q7V0DUkAKXTXxohI03yjEFZ/VlAv
 o+6iC42G8z8uPQuedbt9Ll1qVGkLEhsB7AKqgvQNYfpb94FMjGsAvJT72uqYp34Lc+ad
 xQDw==
X-Gm-Message-State: APuU4Z8bHGTdpzSePrY0ONSr4YB74YIapWNzTQ23DS6ezTAGnp188/Af
 VdfHERpisupZ5gwgfPctRZ9TalVl0NrIbCYIi+ok/u7jkszNeW6fwtKD
X-Gm-Gg: AZFdTZdZkYfbBoc9yDCNiYcqhFdOmGMEo4OScW5xyN83Hiw2qO6sIpt5aAxuOh+WbU/
 AuNIwowpFXbOxP7bYVYBWfj/hwLbHU8AXZ2zD7yBwKjIcleg3bUKtruCWC53yBYhYKNxTq0N9pu
 b9CZOJ4YiEtQ6wr6TobwRLdD0H+6bz+juL168HPhl0fR6cqWkhLRxE+6026yd8zfGKkoe3vyEGB
 leIp6I4GRCe07wbhRUQMlLrefyax7H3sPuRLCzApDUWYb+JPQpumy9ZGdZ7glfeYRDscok21jTh
 0JBMGeJd5bJNApFQL1NDpCGEezmhSM1n7ClOprGLHCxx4JM++aNEmrmdIEKQpETR+SBSX79m3n+
 3vcrysk+Gs1Qfdfupyzjkzi707lHLKNZCQAFs2JpqGQLRxMCssluLxNhSJwv7vWXEj7kmxA4hba
 sxyG5HhY82Noxk+P0BuRQOd46erXclFw+4CD9u00g3EfxT2Nn9/a08B8QoUVxAqfmRYCVjOpYn+
 X/UwqlsXMcZ+vlpCLCZt69iSTRvvhnVS/WDIyzUiG5pqXNcM9ZgmaL1UEG0TSNow2mF5F6crGWf
 varMcMHzbnEUeg622E01p0zPbjSaQETygmSJfEGDVopy/HrE4abGfkS0oZ6k
X-Received: by 2002:a05:600c:4e87:b0:4a3:59c9:a758 with SMTP id
 5b1f17b1804b1-4bb88922c81mr316834935e9.32.1795543421695; 
 Tue, 24 Nov 2026 10:03:41 -0800 (PST)
Received: from freepad.home ([2a01:e0a:1248:bd70:ee15:c1ae:fed0:c345])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb9067846esm287424035e9.4.2026.11.24.10.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 10:03:41 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: vladimir.medvedkin@intel.com
Cc: dev@dpdk.org,
	rjarry@redhat.com,
	Maxime Leroy <maxime@leroys.fr>
Subject: [RFC v2 10/13] test/fib: cover tbl8 pool growth
Date: Tue, 24 Nov 2026 19:02:46 +0100
Message-ID: <20261124180249.1099506-11-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124180249.1099506-1-maxime@leroys.fr>
References: <20260331214117.142495-1-maxime@leroys.fr>
 <20261124180249.1099506-1-maxime@leroys.fr>
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add routes longer than /24, each in its own /24, to a resizable tbl8
pool created with one group. Half of them end on a /24 boundary, where
the install needs two free groups. The pool has to grow along the way
and every lookup is checked.

A second case covers a tbl8 that is needed late: a prefix longer than
/24 with the next hop of its parent gets no tbl8, until a sibling is
added or the next hop of the parent changes. The pool is full at that
time and has to grow.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 app/test/test_fib.c | 183 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/app/test/test_fib.c b/app/test/test_fib.c
index 62c0ce1e70..228201af8a 100644
--- a/app/test/test_fib.c
+++ b/app/test/test_fib.c
@@ -25,6 +25,8 @@ static int32_t test_lookup(void);
 static int32_t test_wraparound(void);
 static int32_t test_invalid_rcu(void);
 static int32_t test_fib_rcu_sync_rw(void);
+static int32_t test_tbl8_pool_grow(void);
+static int32_t test_tbl8_pool_grow_late(void);
 
 #define MAX_ROUTES	(1 << 16)
 #define MAX_TBL8	(1 << 15)
@@ -681,6 +683,185 @@ test_fib_rcu_sync_rw(void)
 	return status == 0 ? TEST_SUCCESS : TEST_FAILED;
 }
 
+/*
+ * A resizable pool created with a single tbl8 group has to grow while
+ * routes longer than /24 are added in different /24. Half of them end on
+ * a /24 boundary, which needs two free groups during the install. Every
+ * route must then resolve to its own next hop, and the rest of its /24
+ * to the default one.
+ */
+static int32_t
+test_tbl8_pool_grow(void)
+{
+	struct rte_fib_tbl8_pool_conf pool_conf = {
+		.num_tbl8 = 1,
+		.max_tbl8 = 256,
+		.nh_sz = RTE_FIB_DIR24_8_2B,
+		.socket_id = SOCKET_ID_ANY,
+	};
+	struct rte_fib_tbl8_pool_rcu_config rcu_cfg = { 0 };
+	struct rte_fib_conf config = { 0 };
+	const unsigned int n_routes = 40;
+	struct rte_fib_tbl8_pool *pool;
+	struct rte_rcu_qsbr *qsv;
+	struct rte_fib *fib;
+	uint32_t total, used;
+	uint32_t ip[2];
+	uint64_t nh[2];
+	unsigned int i;
+	size_t sz;
+	int ret;
+
+	config.max_routes = 1024;
+	config.default_nh = 0;
+	config.type = RTE_FIB_DIR24_8;
+	config.dir24_8.nh_sz = RTE_FIB_DIR24_8_2B;
+
+	pool = rte_fib_tbl8_pool_create(__func__, &pool_conf);
+	RTE_TEST_ASSERT(pool != NULL, "Failed to create resizable pool\n");
+
+	sz = rte_rcu_qsbr_get_memsize(RTE_MAX_LCORE);
+	qsv = rte_zmalloc_socket(NULL, sz, RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+	RTE_TEST_ASSERT(qsv != NULL, "Can not allocate memory for RCU\n");
+	ret = rte_rcu_qsbr_init(qsv, RTE_MAX_LCORE);
+	RTE_TEST_ASSERT(ret == 0, "Can not initialize RCU\n");
+	rcu_cfg.v = qsv;
+	ret = rte_fib_tbl8_pool_rcu_qsbr_add(pool, &rcu_cfg);
+	RTE_TEST_ASSERT(ret == 0, "Can not attach RCU to pool (ret=%d)\n", ret);
+
+	config.dir24_8.tbl8_pool = pool;
+	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
+
+	for (i = 0; i < n_routes; i++) {
+		if (i & 1)
+			ret = rte_fib_add(fib, RTE_IPV4(10, 0, i, 128), 25,
+				0x100 + i);
+		else
+			ret = rte_fib_add(fib, RTE_IPV4(10, 0, i, 1), 32,
+				0x100 + i);
+		RTE_TEST_ASSERT(ret == 0, "ADD #%u failed (ret=%d)\n", i, ret);
+	}
+
+	ret = rte_fib_tbl8_pool_get_stats(pool, &used, &total, NULL);
+	RTE_TEST_ASSERT(ret == 0, "get_stats failed (ret=%d)\n", ret);
+	RTE_TEST_ASSERT(used == n_routes,
+		"expected %u tbl8 groups in use, got %u\n", n_routes, used);
+	RTE_TEST_ASSERT(total >= used && total > pool_conf.num_tbl8,
+		"pool did not grow, total=%u\n", total);
+
+	for (i = 0; i < n_routes; i++) {
+		ip[0] = RTE_IPV4(10, 0, i, (i & 1) ? 200 : 1);
+		ip[1] = RTE_IPV4(10, 0, i, 2);
+		rte_fib_lookup_bulk(fib, ip, nh, 2);
+		RTE_TEST_ASSERT(nh[0] == (uint64_t)(0x100 + i),
+			"lookup #%u got nh %" PRIu64 ", want %u\n",
+			i, nh[0], 0x100 + i);
+		RTE_TEST_ASSERT(nh[1] == 0,
+			"neighbour #%u got nh %" PRIu64 ", want 0\n",
+			i, nh[1]);
+	}
+
+	rte_fib_free(fib);
+	rte_fib_tbl8_pool_free(pool);
+	rte_free(qsv);
+	return TEST_SUCCESS;
+}
+
+/*
+ * A prefix longer than /24 with the next hop of its parent gets no tbl8.
+ * Its /24 needs one later, when a sibling is added or when the next hop
+ * of the parent changes. A resizable pool that is full at that time has
+ * to grow, and every route must keep resolving to its own next hop.
+ */
+static int32_t
+test_tbl8_pool_grow_late(void)
+{
+	static const struct {
+		uint32_t ip;
+		uint64_t nh;
+	} exp[] = {
+		{ RTE_IPV4(10, 0, 0, 1), 6 }, { RTE_IPV4(10, 0, 1, 1), 5 },
+		{ RTE_IPV4(10, 0, 1, 2), 8 }, { RTE_IPV4(10, 0, 1, 3), 6 },
+		{ RTE_IPV4(10, 0, 2, 1), 7 }, { RTE_IPV4(10, 0, 3, 1), 5 },
+		{ RTE_IPV4(10, 0, 3, 2), 6 }, { RTE_IPV4(10, 9, 9, 9), 6 },
+	};
+	struct rte_fib_tbl8_pool_conf pool_conf = {
+		.num_tbl8 = 1,
+		.max_tbl8 = 256,
+		.nh_sz = RTE_FIB_DIR24_8_2B,
+		.socket_id = SOCKET_ID_ANY,
+	};
+	struct rte_fib_tbl8_pool_rcu_config rcu_cfg = { 0 };
+	struct rte_fib_conf config = { 0 };
+	struct rte_fib_tbl8_pool *pool;
+	struct rte_rcu_qsbr *qsv;
+	struct rte_fib *fib;
+	uint32_t total, used;
+	unsigned int i;
+	uint32_t ip;
+	uint64_t nh;
+	size_t sz;
+	int ret;
+
+	config.max_routes = 64;
+	config.default_nh = 0;
+	config.type = RTE_FIB_DIR24_8;
+	config.dir24_8.nh_sz = RTE_FIB_DIR24_8_2B;
+
+	pool = rte_fib_tbl8_pool_create("grow_late", &pool_conf);
+	RTE_TEST_ASSERT(pool != NULL, "Failed to create resizable pool\n");
+
+	sz = rte_rcu_qsbr_get_memsize(RTE_MAX_LCORE);
+	qsv = rte_zmalloc_socket(NULL, sz, RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+	RTE_TEST_ASSERT(qsv != NULL, "Can not allocate memory for RCU\n");
+	ret = rte_rcu_qsbr_init(qsv, RTE_MAX_LCORE);
+	RTE_TEST_ASSERT(ret == 0, "Can not initialize RCU\n");
+	rcu_cfg.v = qsv;
+	ret = rte_fib_tbl8_pool_rcu_qsbr_add(pool, &rcu_cfg);
+	RTE_TEST_ASSERT(ret == 0, "Can not attach RCU to pool (ret=%d)\n", ret);
+
+	config.dir24_8.tbl8_pool = pool;
+	fib = rte_fib_create("grow_late", SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
+
+	ret = rte_fib_add(fib, RTE_IPV4(10, 0, 0, 0), 8, 5);
+	ret |= rte_fib_add(fib, RTE_IPV4(10, 0, 1, 1), 32, 5);
+	ret |= rte_fib_add(fib, RTE_IPV4(10, 0, 3, 1), 32, 5);
+	ret |= rte_fib_add(fib, RTE_IPV4(10, 0, 2, 1), 32, 7);
+	RTE_TEST_ASSERT(ret == 0, "Failed to add the initial routes\n");
+
+	ret = rte_fib_tbl8_pool_get_stats(pool, &used, &total, NULL);
+	RTE_TEST_ASSERT(ret == 0, "get_stats failed (ret=%d)\n", ret);
+	RTE_TEST_ASSERT(used == 1 && total == 1,
+		"expected a full pool of one group, got %u/%u\n", used, total);
+
+	ret = rte_fib_add(fib, RTE_IPV4(10, 0, 1, 2), 32, 8);
+	RTE_TEST_ASSERT(ret == 0, "ADD of a sibling failed (ret=%d)\n", ret);
+
+	ret = rte_fib_add(fib, RTE_IPV4(10, 0, 0, 0), 8, 6);
+	RTE_TEST_ASSERT(ret == 0,
+		"next hop update of the parent failed (ret=%d)\n", ret);
+
+	for (i = 0; i < RTE_DIM(exp); i++) {
+		ip = exp[i].ip;
+		rte_fib_lookup_bulk(fib, &ip, &nh, 1);
+		RTE_TEST_ASSERT(nh == exp[i].nh,
+			"lookup #%u got nh %" PRIu64 ", want %" PRIu64 "\n",
+			i, nh, exp[i].nh);
+	}
+
+	ret = rte_fib_tbl8_pool_get_stats(pool, &used, &total, NULL);
+	RTE_TEST_ASSERT(ret == 0, "get_stats failed (ret=%d)\n", ret);
+	RTE_TEST_ASSERT(used == 3 && total >= used,
+		"expected 3 tbl8 groups in use, got %u/%u\n", used, total);
+
+	rte_fib_free(fib);
+	rte_fib_tbl8_pool_free(pool);
+	rte_free(qsv);
+	return TEST_SUCCESS;
+}
+
 static struct unit_test_suite fib_fast_tests = {
 	.suite_name = "fib autotest",
 	.setup = NULL,
@@ -694,6 +875,8 @@ static struct unit_test_suite fib_fast_tests = {
 	TEST_CASE(test_wraparound),
 	TEST_CASE(test_invalid_rcu),
 	TEST_CASE(test_fib_rcu_sync_rw),
+	TEST_CASE(test_tbl8_pool_grow),
+	TEST_CASE(test_tbl8_pool_grow_late),
 	TEST_CASES_END()
 	}
 };
-- 
2.43.0

