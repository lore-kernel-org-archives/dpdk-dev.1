Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FD7606A331
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Nov 2026 18:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XVakatKw
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D78D7406BC;
	Tue, 24 Nov 2026 19:03:46 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by mails.dpdk.org (Postfix) with ESMTPS id 2CE0740A67
 for <dev@dpdk.org>; Tue, 24 Nov 2026 19:03:46 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4bb5b8ef642so43137065e9.1
 for <dev@dpdk.org>; Tue, 24 Nov 2026 10:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795543426; x=1796148226; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rwPKXp1iLfefkQshvMSJZbQm8HuepkTe4IEujxJgxl8=;
 b=XVakatKwqwQVJPZTompnN6VyJcsebpJqg0hXVT1tI8ukqklO3imDQPmSRoTtGeH0dT
 mVjFMfkaniH/r9fCbwhb0Cho2uxvmMNGpj0oJW5oChklQMiq4NSyQOgy9eKHgEe8nKMb
 0UHVF1wYqdzKLOkAVmpFq/j5SfFuBL3c7BM+rBu6qd90AEMA3diNZFuOZrIF80Ueu/XI
 Z8BJHqVI9k4gTPNL8RpgLWVZDjXZRx8r2sQQWYlcv1ZGxDrDFrWk60e/FbDy4VL5JjTH
 X5J58uXsFfKU9QoaTx8g/oiCxxDugTwmekR1ecBQqzmyAPbWV7pvNe0WAikTReINxKsp
 RAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795543426; x=1796148226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rwPKXp1iLfefkQshvMSJZbQm8HuepkTe4IEujxJgxl8=;
 b=NvULai8AS2KBrVP4F9cxG2JP4xgNPUDOxrJ/8WW02itXJhMVMjmVDwn9NUGKZ0v1lk
 qYBM0NjdwyVVAJzybZaTdl3Cy8MQn0O8jz9iS5xytrWu3UN+9Az39ap1P0kyiE+Tfp5v
 v+Ib72T0mVtkY9Nu/2kB26GHLJ1Wkxdfz34qR4j0bOkfrHgB5hx49waMAuQb+GyOHRTr
 ifv00Kx3x21ySU/rSbBiEZvpCiJt80WqwRCjqmgPSGE35Od70dwF9/TpFylHJgzkFfxp
 Q4twwqx4z2CzC00ldAh2jG2Qb6OcHt47ZI1FNRPBC1HK1kDokP7DqgUO0rjFf4L4tPpu
 ewMQ==
X-Gm-Message-State: APuU4Z/AjuUJQMwfSTV6+I+ZK5k4IoDVDDFYIGfbc+t0LOuy91Q89kq4
 1wasSQhFSArKuoGQ47k+y+jKVt1PML8IqMXRpLexk/eAiBjfqi+pHcvbS2xwww==
X-Gm-Gg: AZFdTZdvC6bDgqIDnr9yvkr1/YVCYgt3zJO7j/9TS+YEvDIVDCqTVcsILF338Yp0tIy
 9n2dCsdw2m8PlfvLnDQHBOUC4MPgl3JyXMF60bAyme3ZGPUxlEtr8myBWSG0M6jwHQhgFez2dhT
 M44wiXmtkkvErQQp8D/lrDriZXBjOFjdXKVgeAiGMWqIaEWUuuU4KXFYpF2d26Oqrmdam+M8vto
 eAYME48WSlGZDngTfJUL32iQsHYGzP6kILTHv0jeFyOV9JQM7gEq3PLEi1zsj8nkztkOp65f0VQ
 94zu+z6PywWwfaUHP1tIaNJ7LB6D51yjZBD0kEIxr2Oa6Ee0Vq9sX9NNgpm8wmj/Bc2TxnvdRyA
 HzWWKhpCOTywkhyNoGZql3dMMl5d3ThDiKcNYMh6WGbBm2iV0agMdToS+T8Q4IdzfWI7onBoqlO
 HD7RR7uifUzBvzYZ4EQ9mzVVnqZzHAaLSYeLAf6bub3MywWMR7ue2ndmcxDCiCYQmC9/baPUasH
 WBA3q+MYv8I5V3NdQy46HBKLPN4SGaNPNwtdhOO1e+z75WuU9fKnSVKoxO8Soj9PQAcXn/PRErk
 +nTwocnls8HeF2pp4z0AkjZkEq8OuWCEGrRWnaPxmEtl3kFVoeoA7dwRX6Bw
X-Received: by 2002:a05:600c:1546:b0:4a1:fc98:1cb1 with SMTP id
 5b1f17b1804b1-4bb887c2cb0mr348327535e9.2.1795543425650; 
 Tue, 24 Nov 2026 10:03:45 -0800 (PST)
Received: from freepad.home ([2a01:e0a:1248:bd70:ee15:c1ae:fed0:c345])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4b8e564e39asm883884f8f.57.2026.11.24.10.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 10:03:45 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: vladimir.medvedkin@intel.com
Cc: dev@dpdk.org,
	rjarry@redhat.com,
	Maxime Leroy <maxime@leroys.fr>
Subject: [RFC v2 12/13] test/fib: cover tbl8 pool sharing
Date: Tue, 24 Nov 2026 19:02:48 +0100
Message-ID: <20261124180249.1099506-13-maxime@leroys.fr>
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

Attach two FIBs to a fixed tbl8 pool of two groups. A group reserved
by a route of one FIB, not installed yet because it has the next hop
of its parent, can not be taken by the other FIB and is there when
the next hop of the parent changes. Freeing a FIB that still holds
routes returns its group to the pool.

Attach two FIBs with an RCU defer queue each to a fixed pool of one
group. A group released by one FIB waits in its defer queue; once the
readers are quiescent, the other FIB must get it without any update
of the first one.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 app/test/test_fib.c | 165 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 165 insertions(+)

diff --git a/app/test/test_fib.c b/app/test/test_fib.c
index 228201af8a..eaa046fe3d 100644
--- a/app/test/test_fib.c
+++ b/app/test/test_fib.c
@@ -27,6 +27,8 @@ static int32_t test_invalid_rcu(void);
 static int32_t test_fib_rcu_sync_rw(void);
 static int32_t test_tbl8_pool_grow(void);
 static int32_t test_tbl8_pool_grow_late(void);
+static int32_t test_tbl8_pool_shared(void);
+static int32_t test_tbl8_pool_shared_dq(void);
 
 #define MAX_ROUTES	(1 << 16)
 #define MAX_TBL8	(1 << 15)
@@ -862,6 +864,167 @@ test_tbl8_pool_grow_late(void)
 	return TEST_SUCCESS;
 }
 
+/*
+ * Two FIBs share a fixed pool of two tbl8 groups. The group reserved by
+ * a route of one FIB can not be taken by the other, it is there when its
+ * owner needs it, and it returns to the pool when the FIB is freed.
+ */
+static int32_t
+test_tbl8_pool_shared(void)
+{
+	struct rte_fib_tbl8_pool_conf pool_conf = {
+		.num_tbl8 = 2,
+		.nh_sz = RTE_FIB_DIR24_8_2B,
+		.socket_id = SOCKET_ID_ANY,
+	};
+	struct rte_fib_conf config = { 0 };
+	struct rte_fib_tbl8_pool *pool;
+	struct rte_fib *fib_a, *fib_b;
+	uint32_t used;
+	uint32_t ip;
+	uint64_t nh;
+	int ret;
+
+	config.max_routes = 16;
+	config.default_nh = 0;
+	config.type = RTE_FIB_DIR24_8;
+	config.dir24_8.nh_sz = RTE_FIB_DIR24_8_2B;
+
+	pool = rte_fib_tbl8_pool_create("shared4", &pool_conf);
+	RTE_TEST_ASSERT(pool != NULL, "Failed to create pool\n");
+	config.dir24_8.tbl8_pool = pool;
+	fib_a = rte_fib_create("shared4_a", SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib_a != NULL, "Failed to create FIB A\n");
+	fib_b = rte_fib_create("shared4_b", SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib_b != NULL, "Failed to create FIB B\n");
+
+	/* A reserves a group for a /32 hidden by its /8 */
+	ret = rte_fib_add(fib_a, RTE_IPV4(10, 0, 0, 0), 8, 5);
+	ret |= rte_fib_add(fib_a, RTE_IPV4(10, 0, 1, 1), 32, 5);
+	RTE_TEST_ASSERT(ret == 0, "Failed to add the routes of A\n");
+
+	/* B gets the unreserved group, not a second one */
+	ret = rte_fib_add(fib_b, RTE_IPV4(10, 0, 2, 1), 32, 7);
+	RTE_TEST_ASSERT(ret == 0, "ADD in B failed (ret=%d)\n", ret);
+	ret = rte_fib_add(fib_b, RTE_IPV4(10, 0, 3, 1), 32, 8);
+	RTE_TEST_ASSERT(ret == -ENOSPC,
+		"ADD in B must not take the group reserved by A (ret=%d)\n",
+		ret);
+	rte_fib_tbl8_pool_get_stats(pool, &used, NULL, NULL);
+	RTE_TEST_ASSERT(used == 1, "expected 1 group taken, got %u\n", used);
+
+	/* the /32 of A needs its group once the /8 changes */
+	ret = rte_fib_add(fib_a, RTE_IPV4(10, 0, 0, 0), 8, 6);
+	RTE_TEST_ASSERT(ret == 0,
+		"next hop update in A failed (ret=%d)\n", ret);
+	rte_fib_tbl8_pool_get_stats(pool, &used, NULL, NULL);
+	RTE_TEST_ASSERT(used == 2, "expected 2 groups taken, got %u\n", used);
+	ip = RTE_IPV4(10, 0, 1, 1);
+	rte_fib_lookup_bulk(fib_a, &ip, &nh, 1);
+	RTE_TEST_ASSERT(nh == 5, "/32 of A: got nh %" PRIu64 ", want 5\n", nh);
+	ip = RTE_IPV4(10, 0, 1, 2);
+	rte_fib_lookup_bulk(fib_a, &ip, &nh, 1);
+	RTE_TEST_ASSERT(nh == 6, "/8 of A: got nh %" PRIu64 ", want 6\n", nh);
+
+	/* freeing A, which still holds its routes, returns its group */
+	rte_fib_free(fib_a);
+	rte_fib_tbl8_pool_get_stats(pool, &used, NULL, NULL);
+	RTE_TEST_ASSERT(used == 1, "expected 1 group taken, got %u\n", used);
+	ret = rte_fib_add(fib_b, RTE_IPV4(10, 0, 3, 1), 32, 8);
+	RTE_TEST_ASSERT(ret == 0, "ADD in B failed (ret=%d)\n", ret);
+	ip = RTE_IPV4(10, 0, 2, 1);
+	rte_fib_lookup_bulk(fib_b, &ip, &nh, 1);
+	RTE_TEST_ASSERT(nh == 7, "first /32 of B: got nh %" PRIu64 "\n", nh);
+	ip = RTE_IPV4(10, 0, 3, 1);
+	rte_fib_lookup_bulk(fib_b, &ip, &nh, 1);
+	RTE_TEST_ASSERT(nh == 8, "second /32 of B: got nh %" PRIu64 "\n", nh);
+
+	rte_fib_free(fib_b);
+	rte_fib_tbl8_pool_get_stats(pool, &used, NULL, NULL);
+	RTE_TEST_ASSERT(used == 0, "expected an empty pool, got %u\n", used);
+	rte_fib_tbl8_pool_free(pool);
+	return TEST_SUCCESS;
+}
+
+/*
+ * Two FIBs share a fixed pool of one tbl8 group, with an RCU defer queue
+ * each. A group released by one FIB waits in the defer queue of that FIB.
+ * Once the readers are quiescent, the other FIB must be able to get it.
+ */
+static int32_t
+test_tbl8_pool_shared_dq(void)
+{
+	struct rte_fib_tbl8_pool_conf pool_conf = {
+		.num_tbl8 = 1,
+		.nh_sz = RTE_FIB_DIR24_8_2B,
+		.socket_id = SOCKET_ID_ANY,
+	};
+	struct rte_fib_rcu_config rcu_cfg = { 0 };
+	struct rte_fib_conf config = { 0 };
+	struct rte_fib_tbl8_pool *pool;
+	struct rte_fib *fib_a, *fib_b;
+	struct rte_rcu_qsbr *qsv;
+	uint32_t used;
+	uint32_t ip;
+	uint64_t nh;
+	size_t sz;
+	int ret;
+
+	config.max_routes = 16;
+	config.default_nh = 0;
+	config.type = RTE_FIB_DIR24_8;
+	config.dir24_8.nh_sz = RTE_FIB_DIR24_8_2B;
+
+	pool = rte_fib_tbl8_pool_create("shdq4", &pool_conf);
+	RTE_TEST_ASSERT(pool != NULL, "Failed to create pool\n");
+	config.dir24_8.tbl8_pool = pool;
+	fib_a = rte_fib_create("shdq4_a", SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib_a != NULL, "Failed to create FIB A\n");
+	fib_b = rte_fib_create("shdq4_b", SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib_b != NULL, "Failed to create FIB B\n");
+
+	sz = rte_rcu_qsbr_get_memsize(1);
+	qsv = rte_zmalloc_socket(NULL, sz, RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+	RTE_TEST_ASSERT(qsv != NULL, "Can not allocate memory for RCU\n");
+	ret = rte_rcu_qsbr_init(qsv, 1);
+	RTE_TEST_ASSERT(ret == 0, "Can not initialize RCU\n");
+	rcu_cfg.v = qsv;
+	rcu_cfg.mode = RTE_FIB_QSBR_MODE_DQ;
+	ret = rte_fib_rcu_qsbr_add(fib_a, &rcu_cfg);
+	ret |= rte_fib_rcu_qsbr_add(fib_b, &rcu_cfg);
+	RTE_TEST_ASSERT(ret == 0, "Can not add RCU to the FIBs\n");
+
+	rte_rcu_qsbr_thread_register(qsv, 0);
+	rte_rcu_qsbr_thread_online(qsv, 0);
+
+	/* the group released by B waits for the reader in the queue of B */
+	ret = rte_fib_add(fib_b, RTE_IPV4(10, 0, 1, 1), 32, 7);
+	ret |= rte_fib_delete(fib_b, RTE_IPV4(10, 0, 1, 1), 32);
+	RTE_TEST_ASSERT(ret == 0, "ADD then DEL in B failed\n");
+	rte_fib_tbl8_pool_get_stats(pool, &used, NULL, NULL);
+	RTE_TEST_ASSERT(used == 1, "expected 1 group taken, got %u\n", used);
+
+	/* the reader is quiescent: A gets the group without any help of B */
+	rte_rcu_qsbr_quiescent(qsv, 0);
+	ret = rte_fib_add(fib_a, RTE_IPV4(10, 0, 2, 1), 32, 8);
+	RTE_TEST_ASSERT(ret == 0,
+		"ADD in A can not get the group released by B (ret=%d)\n",
+		ret);
+	ip = RTE_IPV4(10, 0, 2, 1);
+	rte_fib_lookup_bulk(fib_a, &ip, &nh, 1);
+	RTE_TEST_ASSERT(nh == 8, "/32 of A: got nh %" PRIu64 ", want 8\n", nh);
+
+	rte_rcu_qsbr_thread_offline(qsv, 0);
+	rte_rcu_qsbr_thread_unregister(qsv, 0);
+	rte_fib_free(fib_a);
+	rte_fib_free(fib_b);
+	rte_fib_tbl8_pool_get_stats(pool, &used, NULL, NULL);
+	RTE_TEST_ASSERT(used == 0, "expected an empty pool, got %u\n", used);
+	rte_fib_tbl8_pool_free(pool);
+	rte_free(qsv);
+	return TEST_SUCCESS;
+}
+
 static struct unit_test_suite fib_fast_tests = {
 	.suite_name = "fib autotest",
 	.setup = NULL,
@@ -877,6 +1040,8 @@ static struct unit_test_suite fib_fast_tests = {
 	TEST_CASE(test_fib_rcu_sync_rw),
 	TEST_CASE(test_tbl8_pool_grow),
 	TEST_CASE(test_tbl8_pool_grow_late),
+	TEST_CASE(test_tbl8_pool_shared),
+	TEST_CASE(test_tbl8_pool_shared_dq),
 	TEST_CASES_END()
 	}
 };
-- 
2.43.0

