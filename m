Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925F0606A339
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Nov 2026 18:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0KedEPCK
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F394540A7F;
	Tue, 24 Nov 2026 19:03:44 +0100 (CET)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by mails.dpdk.org (Postfix) with ESMTPS id 2E9ED40A73
 for <dev@dpdk.org>; Tue, 24 Nov 2026 19:03:44 +0100 (CET)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-4a42b34e930so4234372f8f.2
 for <dev@dpdk.org>; Tue, 24 Nov 2026 10:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795543424; x=1796148224; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HTefq109jhfxOfXK8LW5HFfkalBv5U6idOhCYSboBJU=;
 b=0KedEPCKk6Dx+7kw3qMmQe0yd6AkQYuq+cSgjGqduogdFQ7fzLdGEsHCwdGrYKczQ3
 enOcB2qJeJDWEKRU0pb0Gc+A8MwZv9BFSKLoN6TRmPSia8x1LHaTB+fVE1aEKJsHc86c
 6jsDSRKue8VpMtUekSOInxlDTQPUFRYVzlsVkElWc0z4pERuSvoIdzUD0xteqfKlpprr
 weLN1JYcWjwkvVpN8iF5s7OhdjQnw/z02E7+Ie7Y1X9vBvfcHjo6G0RS2iKEoPukGI+f
 RS3bkCyfkfYtcrdpU2kcY3L3kWUgdYMZkLlghYbE913VCL7/sV62B7RmyOwlZO6RANKI
 Yq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795543424; x=1796148224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HTefq109jhfxOfXK8LW5HFfkalBv5U6idOhCYSboBJU=;
 b=byEsTozzrifV9SZVnzwv5yXZ/r3jaBni7cplHbN3MWwCkt7OjFWSiTnhE9vubGIbZh
 jAATu0f1Q62X/8zRy/0VAtkU65dnrHVlvr5L4ePSKKDiGanC1a8HnCQkKftcrJ1JGSzs
 aRGNdVaM4WRYgby8/7G5renXw25L+s2ycW7mvmuR9VnwwAvsyFfl8vGuvD6JyCq67X/l
 xPUa2cvI73ychY0j1fSOAy09lgl1vPwCnO86dztbDjKkFoLAbZk1Ur7xcG2VQIaAA77s
 cUFVBrJSAvInxNyvvTGtglzZUyLhRcWtEGAIlh7hsdXFesIZgpvMAvhRDXb2gIma/L6w
 A4YQ==
X-Gm-Message-State: APuU4Z9Q1t73dzCRJv1LsnFAti7mlrqALIxgERrghbEPySE7QgyTMlFY
 AO42tjRL/7qKKY0pZRSmD6a7/kMAofmMOuusiWMMwcUYow3k3HWsDQZB
X-Gm-Gg: AZFdTZd/Finaj7eOL9shfrHo7M0Xj4bkRuvuCBmCZPlnsu4Dy+VbbtLZAdRkz9IKx/A
 YRuGJRGD6wrFh1mvUpPklzFZglvQT/RmzgByuySzAvaXWQt9wH7Zj7Pbi6lF1o/dvnR5qqGiuSj
 2fpZkXnsl9COxmmnJP/gmUtgRQO055kHMBCRTgjg5WMExYnHwLaXMIEul+OkxiK31LTns7vebAh
 L4A8uJrkVSQ+X0Ic9GH13LWAFeXq5lucV/FUP/VsOLASUGX9kgrqfigLdEnrf5+jh8bb8tqmY+z
 0MxfRBm7AtE4DP9MNzBnBx7Mgr4wwdeW1JtHOJ/JkQACpIWfJrCw/8h92NGqJDeqIENVE4Gjpds
 ECIJmjAO2kj6083jjqm8gOFIQp4KEUpO1LDFvrs+2L4BtyErgc6FHw/W85di5hf2titLyrNnb5m
 Pb1Yd9149PjGFkraFAR16D7o03aaajIpBWFagaPPkt0zP7zsLYs9Iy4DJmvq6MkA8/1Kg2tybFo
 En2ebflchj0kGJK/3EE/9MnG9ski54Y1DBgSbkO8cRURM0ff0lUqQw8JgV1apa5S8DZX7A8fOM7
 rAoTgXZqTN4tMvix0wvaq3RQEdbUf/IQjj8JSHCukHQ8CqS4hUVLi5RHjmV2
X-Received: by 2002:a05:600c:4e02:b0:4a4:4d57:8462 with SMTP id
 5b1f17b1804b1-4bb88812b1cmr317678545e9.24.1795543423687; 
 Tue, 24 Nov 2026 10:03:43 -0800 (PST)
Received: from freepad.home ([2a01:e0a:1248:bd70:ee15:c1ae:fed0:c345])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884a15absm405694795e9.9.2026.11.24.10.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 10:03:43 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: vladimir.medvedkin@intel.com
Cc: dev@dpdk.org,
	rjarry@redhat.com,
	Maxime Leroy <maxime@leroys.fr>
Subject: [RFC v2 11/13] test/fib6: cover tbl8 pool growth
Date: Tue, 24 Nov 2026 19:02:47 +0100
Message-ID: <20261124180249.1099506-12-maxime@leroys.fr>
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

Add /48 routes, three tbl8 groups each, to a resizable tbl8 pool
created with one group. The pool has to grow while the trie installs
them and every lookup is checked.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 app/test/test_fib6.c | 85 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/app/test/test_fib6.c b/app/test/test_fib6.c
index b2364760a2..fca1230bec 100644
--- a/app/test/test_fib6.c
+++ b/app/test/test_fib6.c
@@ -34,6 +34,7 @@ static int32_t test_drift_tight_pool(void);
 static int32_t test_tbl8_install_peak(void);
 static int32_t test_tbl8_install_peak_dq(void);
 static int32_t test_tbl8_dq_modify(void);
+static int32_t test_tbl8_pool_grow(void);
 
 #define MAX_ROUTES	(1 << 16)
 /** Maximum number of tbl8 for 2-byte entries */
@@ -1274,6 +1275,89 @@ test_tbl8_dq_modify(void)
 	return TEST_SUCCESS;
 }
 
+/*
+ * A resizable pool created with a single tbl8 group has to grow while
+ * prefixes needing several groups each are added. Every route must then
+ * resolve to its own next hop.
+ */
+static int32_t
+test_tbl8_pool_grow(void)
+{
+	struct rte_fib_tbl8_pool_conf pool_conf = {
+		.num_tbl8 = 1,
+		.max_tbl8 = 256,
+		.nh_sz = RTE_FIB6_TRIE_2B,
+		.socket_id = SOCKET_ID_ANY,
+	};
+	struct rte_fib_tbl8_pool_rcu_config rcu_cfg = { 0 };
+	struct rte_fib6_conf config = { 0 };
+	const unsigned int n_routes = 40;
+	struct rte_fib_tbl8_pool *pool;
+	struct rte_rcu_qsbr *qsv;
+	struct rte_ipv6_addr ip;
+	struct rte_fib6 *fib;
+	uint32_t total, used;
+	unsigned int i;
+	uint64_t nh;
+	size_t sz;
+	int ret;
+
+	config.max_routes = 1024;
+	config.default_nh = 0;
+	config.type = RTE_FIB6_TRIE;
+	config.trie.nh_sz = RTE_FIB6_TRIE_2B;
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
+	config.trie.tbl8_pool = pool;
+	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
+
+	for (i = 0; i < n_routes; i++) {
+		memset(&ip, 0, sizeof(ip));
+		ip.a[0] = 0x20;
+		ip.a[1] = 0x01;
+		ip.a[2] = i;
+		ret = rte_fib6_add(fib, &ip, 48, 0x100 + i);
+		RTE_TEST_ASSERT(ret == 0, "ADD /48 #%u failed (ret=%d)\n",
+			i, ret);
+	}
+
+	for (i = 0; i < n_routes; i++) {
+		memset(&ip, 0, sizeof(ip));
+		ip.a[0] = 0x20;
+		ip.a[1] = 0x01;
+		ip.a[2] = i;
+		ip.a[6] = 0x55;
+		rte_fib6_lookup_bulk(fib, &ip, &nh, 1);
+		RTE_TEST_ASSERT(nh == (uint64_t)(0x100 + i),
+			"lookup #%u got nh %" PRIu64 ", want %u\n",
+			i, nh, 0x100 + i);
+	}
+
+	ret = rte_fib_tbl8_pool_get_stats(pool, &used, &total, NULL);
+	RTE_TEST_ASSERT(ret == 0, "get_stats failed (ret=%d)\n", ret);
+	RTE_TEST_ASSERT(used == 3 * n_routes,
+		"expected %u tbl8 groups in use, got %u\n", 3 * n_routes, used);
+	RTE_TEST_ASSERT(total >= used && total > pool_conf.num_tbl8,
+		"pool did not grow, total=%u\n", total);
+
+	rte_fib6_free(fib);
+	rte_fib_tbl8_pool_free(pool);
+	rte_free(qsv);
+	return TEST_SUCCESS;
+}
+
 static struct unit_test_suite fib6_fast_tests = {
 	.suite_name = "fib6 autotest",
 	.setup = NULL,
@@ -1295,6 +1379,7 @@ static struct unit_test_suite fib6_fast_tests = {
 	TEST_CASE(test_tbl8_install_peak),
 	TEST_CASE(test_tbl8_install_peak_dq),
 	TEST_CASE(test_tbl8_dq_modify),
+	TEST_CASE(test_tbl8_pool_grow),
 	TEST_CASES_END()
 	}
 };
-- 
2.43.0

