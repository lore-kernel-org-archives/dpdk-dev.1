Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E45E606A682
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Nov 2026 18:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lr2Va57Z
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24B1640B8F;
	Tue, 24 Nov 2026 19:03:49 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by mails.dpdk.org (Postfix) with ESMTPS id 785A840B8F
 for <dev@dpdk.org>; Tue, 24 Nov 2026 19:03:48 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so33040455e9.0
 for <dev@dpdk.org>; Tue, 24 Nov 2026 10:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795543428; x=1796148228; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+X0LfJwzDCFF5xEh4m8lR7deI7A0TlF9XffVquDlEG8=;
 b=lr2Va57ZxJmTdDUmdcmj0tIFh2zrFb+CeWUr2prCYI6S+9VuVMGj/tOEAHPesRSdSZ
 o4g6pf1WKlsV8+x6JjCuxaq6ahk7G55+SZZ3JTKnKnRNT4W4mpoWDGoGX8yA/bcI4ZZK
 zgqfgeggnNNNxjQOW8wLwg6FOyNmBGU8xnAQDNbjZ5wiFCE7/FYKxYchq/XWU8Vl2ud7
 HcfvFCfFYM/X/zFtFj33rDf9HmW+2Aojn14+VdMHIlcAOilOBoyEanRInaNe48L4SE1f
 o7ttftkRZoxrk1rZxnNPSgni3QhZUKcYnF/iZFrJP8RjW8JI4i6SoqyuSu7Yp13Je9nt
 0ujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795543428; x=1796148228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+X0LfJwzDCFF5xEh4m8lR7deI7A0TlF9XffVquDlEG8=;
 b=WaIaf9dH4b5druHd6b9OyA9NqO5SZQK4QDN31NGWY5gkFi/M3YgkMdWsxUP9s1qVU5
 BHtdV3tC7Djcxjn1nXpDrby6/Ivsml1G90QllGh5UJdUhLln8BavIDn2uslUOji/zCrC
 npIePm3vX2psfjZjMMBmJrHyEttZtG7qvUd/IDU4vZSWAa8pYH94NWClcS/L21On6A31
 9tCPfNiyLuX2xVu0q97OI5UHU17iTWArpyDlJj3PURKMbSQOj51IqwD8ju52S1wcDXSi
 nwi6ZQsZ9WKT7unWEoE00Y3A7F0bOkP+JRtL2iXEXf5ZJ2BnoTxCgEYoFSnMJnQxAz/C
 7ILQ==
X-Gm-Message-State: APuU4Z8oSLClq8rVKet1JpUNvBwV1m1ig8Dlua8otraRTIsMK7j60YU6
 VJHkhCugQ4HRk+jy805q45XS75uvCtE0iohbHWm6pTK0m6PTf3XczO2e
X-Gm-Gg: AZFdTZeec5ipAGYyZ851esSx4T6mpbO4xLhEHMiNj8/r/ekZyyPE+RWJG/0w8Sl9EC3
 cWmMZogATONEWWQrKsyA/Ef2iS8pJiMcWSVR1f9naK3rpw0iFXHMZ675TptzeRVaDEtMKCOYr3i
 qqZ+BfORNLcTZ80q8hYDQzGP2IDvCKKoHSPyAUcb5gkOW5EB0EMLKiwVPEdkKZMejFfB15t82IC
 NOjLBSguoi/eh1BH6Cjlob92NmI4QGVkvtNoU66PqUGdrvj9ge4XEm9H8OVJTENBGV46aX3ZQGy
 2w5F6lTdJHTzYdhorsrGiwNV5PrpUA6BgypGSenT6xTBY8iiVdwmQ06HP6RPxCWA0LgHhlZqDQk
 UQ7ms/NRaGm4Edkg+REMcFbXfp7ICnVkMCYl5BiTur9kYSDRQE41Qul7K6CqMdK+4YB/Aw7HAWB
 VzKpaH23diqigf6RTZm4zUx6jPd1PM4HD/k7Uw8SeGVvJSpPNvBLfoan81tIgBigy7Mw/OPyNeY
 3SsjdF2DVDVnhST89b3UxoAZHPqEn+AvZSzYHHkmKYQU8FRlYhYjv0OgwPekDQejN+bu++mSme3
 97CfZBwLQ81RmGXDLs6cEJsASl/XNn5c37IWJep3YL13W+n3mfP4O7e10JZu
X-Received: by 2002:a05:600c:1549:b0:4bb:6a2d:b440 with SMTP id
 5b1f17b1804b1-4bb887e0699mr321446915e9.2.1795543427779; 
 Tue, 24 Nov 2026 10:03:47 -0800 (PST)
Received: from freepad.home ([2a01:e0a:1248:bd70:ee15:c1ae:fed0:c345])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884865a2sm462190255e9.3.2026.11.24.10.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 10:03:47 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: vladimir.medvedkin@intel.com
Cc: dev@dpdk.org,
	rjarry@redhat.com,
	Maxime Leroy <maxime@leroys.fr>
Subject: [RFC v2 13/13] test/fib6: cover tbl8 pool sharing
Date: Tue, 24 Nov 2026 19:02:49 +0100
Message-ID: <20261124180249.1099506-14-maxime@leroys.fr>
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

Attach two FIBs to a fixed tbl8 pool of four groups. The groups
reserved by a route of one FIB, not installed yet because it has the
next hop of its parent, can not be taken by the other FIB and are
there when the next hop of the parent changes. Freeing a FIB that
still holds a route returns its group to the pool.

Attach two FIBs with an RCU defer queue each to a fixed pool of one
group. A group released by one FIB waits in its defer queue; once the
readers are quiescent, the other FIB must get it without any update
of the first one.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 app/test/test_fib6.c | 182 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 182 insertions(+)

diff --git a/app/test/test_fib6.c b/app/test/test_fib6.c
index fca1230bec..afe628f085 100644
--- a/app/test/test_fib6.c
+++ b/app/test/test_fib6.c
@@ -35,6 +35,8 @@ static int32_t test_tbl8_install_peak(void);
 static int32_t test_tbl8_install_peak_dq(void);
 static int32_t test_tbl8_dq_modify(void);
 static int32_t test_tbl8_pool_grow(void);
+static int32_t test_tbl8_pool_shared(void);
+static int32_t test_tbl8_pool_shared_dq(void);
 
 #define MAX_ROUTES	(1 << 16)
 /** Maximum number of tbl8 for 2-byte entries */
@@ -1358,6 +1360,184 @@ test_tbl8_pool_grow(void)
 	return TEST_SUCCESS;
 }
 
+/*
+ * Two FIBs share a fixed pool of four tbl8 groups. The groups reserved by
+ * the routes of one FIB can not be taken by the other, they are there
+ * when their owner needs them, and they return to the pool when a FIB is
+ * freed.
+ */
+static int32_t
+test_tbl8_pool_shared(void)
+{
+	struct rte_ipv6_addr a32 = RTE_IPV6(0x2001, 0x0db8, 0, 0, 0, 0, 0, 0);
+	struct rte_ipv6_addr a48 = RTE_IPV6(0x2001, 0x0db8, 1, 0, 0, 0, 0, 0);
+	struct rte_ipv6_addr b32 = RTE_IPV6(0x2001, 0x0db9, 0, 0, 0, 0, 0, 0);
+	struct rte_ipv6_addr c32 = RTE_IPV6(0x2001, 0x0e00, 0, 0, 0, 0, 0, 0);
+	struct rte_fib_tbl8_pool_conf pool_conf = {
+		.num_tbl8 = 4,
+		.nh_sz = RTE_FIB6_TRIE_2B,
+		.socket_id = SOCKET_ID_ANY,
+	};
+	struct rte_fib6_conf config = { 0 };
+	struct rte_fib_tbl8_pool *pool;
+	struct rte_fib6 *fib_a, *fib_b;
+	struct rte_ipv6_addr ip;
+	uint32_t used;
+	uint64_t nh;
+	int ret;
+
+	config.max_routes = 16;
+	config.default_nh = 0;
+	config.type = RTE_FIB6_TRIE;
+	config.trie.nh_sz = RTE_FIB6_TRIE_2B;
+
+	pool = rte_fib_tbl8_pool_create("shared6", &pool_conf);
+	RTE_TEST_ASSERT(pool != NULL, "Failed to create pool\n");
+	config.trie.tbl8_pool = pool;
+	fib_a = rte_fib6_create("shared6_a", SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib_a != NULL, "Failed to create FIB A\n");
+	fib_b = rte_fib6_create("shared6_b", SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib_b != NULL, "Failed to create FIB B\n");
+
+	/* A uses one group and reserves two for a /48 hidden by its /32 */
+	ret = rte_fib6_add(fib_a, &a32, 32, 5);
+	ret |= rte_fib6_add(fib_a, &a48, 48, 5);
+	RTE_TEST_ASSERT(ret == 0, "Failed to add the routes of A\n");
+
+	/* B gets the last unreserved group, not a second one */
+	ret = rte_fib6_add(fib_b, &b32, 32, 7);
+	RTE_TEST_ASSERT(ret == 0, "ADD in B failed (ret=%d)\n", ret);
+	ret = rte_fib6_add(fib_b, &c32, 32, 8);
+	RTE_TEST_ASSERT(ret == -ENOSPC,
+		"ADD in B must not take groups reserved by A (ret=%d)\n", ret);
+	rte_fib_tbl8_pool_get_stats(pool, &used, NULL, NULL);
+	RTE_TEST_ASSERT(used == 2, "expected 2 groups taken, got %u\n", used);
+
+	/* the /48 of A needs its two groups once the /32 changes */
+	ret = rte_fib6_add(fib_a, &a32, 32, 6);
+	RTE_TEST_ASSERT(ret == 0,
+		"next hop update in A failed (ret=%d)\n", ret);
+	rte_fib_tbl8_pool_get_stats(pool, &used, NULL, NULL);
+	RTE_TEST_ASSERT(used == 4, "expected 4 groups taken, got %u\n", used);
+	ip = a48;
+	ip.a[15] = 1;
+	rte_fib6_lookup_bulk(fib_a, &ip, &nh, 1);
+	RTE_TEST_ASSERT(nh == 5, "/48 of A: got nh %" PRIu64 ", want 5\n", nh);
+	ip = a32;
+	ip.a[15] = 1;
+	rte_fib6_lookup_bulk(fib_a, &ip, &nh, 1);
+	RTE_TEST_ASSERT(nh == 6, "/32 of A: got nh %" PRIu64 ", want 6\n", nh);
+
+	/* B can use the groups A gives back */
+	ret = rte_fib6_delete(fib_a, &a48, 48);
+	RTE_TEST_ASSERT(ret == 0, "DEL in A failed (ret=%d)\n", ret);
+	ret = rte_fib6_add(fib_b, &c32, 32, 8);
+	RTE_TEST_ASSERT(ret == 0, "ADD in B failed (ret=%d)\n", ret);
+	rte_fib_tbl8_pool_get_stats(pool, &used, NULL, NULL);
+	RTE_TEST_ASSERT(used == 3, "expected 3 groups taken, got %u\n", used);
+
+	/* freeing A, which still holds a route, returns its group */
+	rte_fib6_free(fib_a);
+	rte_fib_tbl8_pool_get_stats(pool, &used, NULL, NULL);
+	RTE_TEST_ASSERT(used == 2, "expected 2 groups taken, got %u\n", used);
+	ip = b32;
+	ip.a[15] = 1;
+	rte_fib6_lookup_bulk(fib_b, &ip, &nh, 1);
+	RTE_TEST_ASSERT(nh == 7, "first /32 of B: got nh %" PRIu64 "\n", nh);
+	ip = c32;
+	ip.a[15] = 1;
+	rte_fib6_lookup_bulk(fib_b, &ip, &nh, 1);
+	RTE_TEST_ASSERT(nh == 8, "second /32 of B: got nh %" PRIu64 "\n", nh);
+
+	rte_fib6_free(fib_b);
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
+	struct rte_ipv6_addr a32 = RTE_IPV6(0x2001, 0x0db8, 0, 0, 0, 0, 0, 0);
+	struct rte_ipv6_addr b32 = RTE_IPV6(0x2001, 0x0db9, 0, 0, 0, 0, 0, 0);
+	struct rte_fib_tbl8_pool_conf pool_conf = {
+		.num_tbl8 = 1,
+		.nh_sz = RTE_FIB6_TRIE_2B,
+		.socket_id = SOCKET_ID_ANY,
+	};
+	struct rte_fib6_rcu_config rcu_cfg = { 0 };
+	struct rte_fib6_conf config = { 0 };
+	struct rte_fib_tbl8_pool *pool;
+	struct rte_fib6 *fib_a, *fib_b;
+	struct rte_rcu_qsbr *qsv;
+	struct rte_ipv6_addr ip;
+	uint32_t used;
+	uint64_t nh;
+	size_t sz;
+	int ret;
+
+	config.max_routes = 16;
+	config.default_nh = 0;
+	config.type = RTE_FIB6_TRIE;
+	config.trie.nh_sz = RTE_FIB6_TRIE_2B;
+
+	pool = rte_fib_tbl8_pool_create("shdq6", &pool_conf);
+	RTE_TEST_ASSERT(pool != NULL, "Failed to create pool\n");
+	config.trie.tbl8_pool = pool;
+	fib_a = rte_fib6_create("shdq6_a", SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib_a != NULL, "Failed to create FIB A\n");
+	fib_b = rte_fib6_create("shdq6_b", SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib_b != NULL, "Failed to create FIB B\n");
+
+	sz = rte_rcu_qsbr_get_memsize(1);
+	qsv = rte_zmalloc_socket(NULL, sz, RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+	RTE_TEST_ASSERT(qsv != NULL, "Can not allocate memory for RCU\n");
+	ret = rte_rcu_qsbr_init(qsv, 1);
+	RTE_TEST_ASSERT(ret == 0, "Can not initialize RCU\n");
+	rcu_cfg.v = qsv;
+	rcu_cfg.mode = RTE_FIB6_QSBR_MODE_DQ;
+	ret = rte_fib6_rcu_qsbr_add(fib_a, &rcu_cfg);
+	ret |= rte_fib6_rcu_qsbr_add(fib_b, &rcu_cfg);
+	RTE_TEST_ASSERT(ret == 0, "Can not add RCU to the FIBs\n");
+
+	rte_rcu_qsbr_thread_register(qsv, 0);
+	rte_rcu_qsbr_thread_online(qsv, 0);
+
+	/* the group released by B waits for the reader in the queue of B */
+	ret = rte_fib6_add(fib_b, &b32, 32, 7);
+	ret |= rte_fib6_delete(fib_b, &b32, 32);
+	RTE_TEST_ASSERT(ret == 0, "ADD then DEL in B failed\n");
+	rte_fib_tbl8_pool_get_stats(pool, &used, NULL, NULL);
+	RTE_TEST_ASSERT(used == 1, "expected 1 group taken, got %u\n", used);
+
+	/* the reader is quiescent: A gets the group without any help of B */
+	rte_rcu_qsbr_quiescent(qsv, 0);
+	ret = rte_fib6_add(fib_a, &a32, 32, 8);
+	RTE_TEST_ASSERT(ret == 0,
+		"ADD in A can not get the group released by B (ret=%d)\n",
+		ret);
+	ip = a32;
+	ip.a[15] = 1;
+	rte_fib6_lookup_bulk(fib_a, &ip, &nh, 1);
+	RTE_TEST_ASSERT(nh == 8, "/32 of A: got nh %" PRIu64 ", want 8\n", nh);
+
+	rte_rcu_qsbr_thread_offline(qsv, 0);
+	rte_rcu_qsbr_thread_unregister(qsv, 0);
+	rte_fib6_free(fib_a);
+	rte_fib6_free(fib_b);
+	rte_fib_tbl8_pool_get_stats(pool, &used, NULL, NULL);
+	RTE_TEST_ASSERT(used == 0, "expected an empty pool, got %u\n", used);
+	rte_fib_tbl8_pool_free(pool);
+	rte_free(qsv);
+	return TEST_SUCCESS;
+}
+
 static struct unit_test_suite fib6_fast_tests = {
 	.suite_name = "fib6 autotest",
 	.setup = NULL,
@@ -1380,6 +1560,8 @@ static struct unit_test_suite fib6_fast_tests = {
 	TEST_CASE(test_tbl8_install_peak_dq),
 	TEST_CASE(test_tbl8_dq_modify),
 	TEST_CASE(test_tbl8_pool_grow),
+	TEST_CASE(test_tbl8_pool_shared),
+	TEST_CASE(test_tbl8_pool_shared_dq),
 	TEST_CASES_END()
 	}
 };
-- 
2.43.0

