Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C222606A31D
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 14:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o4evFL7F
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7AB840696;
	Tue, 27 Oct 2026 15:54:36 +0100 (CET)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43])
 by mails.dpdk.org (Postfix) with ESMTPS id 0BFB240687
 for <dev@dpdk.org>; Tue, 27 Oct 2026 15:54:34 +0100 (CET)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-917aca1aee5so43221276d6.2
 for <dev@dpdk.org>; Tue, 27 Oct 2026 07:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793112873; x=1793717673; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+cFQRloaoQTQ2krSXRqx7NG9YM7d9AqGl2TD3fo4/6k=;
 b=o4evFL7Fx0XPHNr41cy+q8g4N0mUP5DiOqMVpIn0VHwU/Y+j9pywB9forVzWMyfBgi
 8JsvF2ITJcmqcCa3/Qoejof6n4YktfTUg0UrSFT9UoGyMXEno6xnPYp4KgTgl2SvKxEE
 nb+5r7DPEvAENe0YI+vcDBmiIjqUADKmkZnWCnBat85i764W6caL3UGIZm+uJBoE/Bao
 HF2tPH9wr9Zac+/CzHA+PauFSIh9bx9pWnS6AFeY/iluM6o8ZMxiTVEjdWHiXAOXhE/M
 F9x2bBRqJpVS4+GF1QNFgnETf30B38XK8oiQqPDLVnG0uNNOcfyv5nMLjEQgy8uLsxeL
 Usmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793112873; x=1793717673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+cFQRloaoQTQ2krSXRqx7NG9YM7d9AqGl2TD3fo4/6k=;
 b=b2enXfZzDdtvoZIaP0lWdsWwL+QJlOzZ7JhEIizCPUPRF2TqV/TTm1vPMPLNapKQIS
 Q+NmWWa6V+hKVsBydR/sXVUlxp9zo+7UTJJyJ8M/GCOTikb0+1dNtjNAroLCfr5uiOEP
 tFGR0+z27aoUxH0clBPxNPsqSxaELdLTF0ZqQy2Z2IHkEkxWwRTiFzJ08YV9o56Kj5JO
 Aks+DJMNHM9yaiJq9gU59RX2a0v4PtJezYGwFbNfTAJ2TJ0gwUltjXvP3k1qZnmvpLMD
 V8N6QvbDJ1cysI1ma7d74Kbwax7+cv/ofuKTvYcfPHca5/ZqOaO0OanbiuEts3IsB6Qm
 wapQ==
X-Gm-Message-State: AFq9FYJNWrqk2OCMfo1iu37xSHaTmnwd43HKy/WuqfeZB8oOw/DNpcVl
 q5LbHFwMS2OmTnF9hioYwn28SyNPfx+snmzfRUBwi6ZkilQTcQ/aQkLgiQ6B+Q==
X-Gm-Gg: AYBFou2tZB6Z8FVBjR9pOBSqeWU59wGATIaJkrHEgxtG0W/qZHia/Fn0IpBrcQ5a36l
 SShz4Xp+auyClZZqK2aMzx4cLabkcvdix/t+XigERABa7C9M/SWOSNGEVHsB1KIpdliapIunSG+
 7MRxk4hKbkbvM8TWmg69MU+uz2lwmtvoC4hLwfLe1KNIMkXFajR3CCnBYUXmit2z8DQBJoOAZE8
 J88FD5xumEpfPg6YJ+7Pf53rLnIIaaQcGRQd4uk79COGTPx/g6gFM4bFwdUlKvqFj66S/DmzBrR
 y0ru1zHrHO+w7lKtfs8ai478+GtbrWjE/N0t8IflD95lG8zX5TTpquWVReX+0xs9SLktpcjf1N0
 NywTDT7juXlUKipQKLk94BGcPZ49wci0I61CFenTjUINqtiFbEk7DrHY1L6ITaUDvD6/71MZHX/
 K+y/n52Y7HmEx4nfMZrMzLvgOY7w8daA+bIt/E9eWbwcoTvgWzsKM4VQQwtRshWq2njhWCmVdks
 ErkX3xACI0O3p4jZUYWZ2YNcLQSs/RXV5v6pRNR7LylCXONEOKUMEEZErmnnVgRkrCZUH4ULREw
 1sayS2k3Z6jvrXVfaI3udXTQNHPrwBTqvYA/bBQte+1YFnjx4nB6Rt7CDLcxZL8XiyIPVrj5bff
 Xp7GwXsZ0JdNKSP1nVYWE4ZL1vDfIXL3+n20Q0e/Ttc0ofqfP0mZZPouR/7F32CTerlYBReC3Po
 wO
X-Received: by 2002:a05:620a:29d6:b0:93f:2bca:2cd8 with SMTP id
 af79cd13be357-940ef96bb96mr1516785285a.57.1793112872883; 
 Tue, 27 Oct 2026 07:54:32 -0700 (PDT)
Received: from bos-lhvwah.bos01.corp.akamai.com
 (g2001-4878-8037-0700-526b-8dff-fef6-cfbf.deploy.static.akamaitechnologies.com.
 [2001:4878:8037:700:526b:8dff:fef6:cfbf])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-940f0789b18sm996910385a.29.2026.10.27.07.54.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 07:54:31 -0700 (PDT)
From: Robert Sanford <rsanford2@gmail.com>
To: dev@dpdk.org
Cc: vladimir.medvedkin@intel.com,
	Robert Sanford <rsanford@akamai.com>
Subject: [PATCH v2 5/5] test/fib6: reproduce table overwrite on address
 wraparound
Date: Tue, 27 Oct 2026 10:54:05 -0400
Message-Id: <20261027145405.3454251-6-rsanford2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027145405.3454251-1-rsanford2@gmail.com>
References: <20261027001423.3028072-1-rsanford2@gmail.com>
 <20261027145405.3454251-1-rsanford2@gmail.com>
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Robert Sanford <rsanford@akamai.com>

Add a test for the case where the more-specific routes under a
modified prefix cover its range up to the top of the address space.
It checks two cases:

  - delete ::/0 while ::/1 and 8000::/1 are installed, and check that
    both /1 routes still resolve.

  - add ffff:...:ff00/120 over ffff:...:ff00/121 and
    ffff:...:ff80/121, and check that an unrelated route, an unrouted
    address and both /121 routes are unchanged.

Without the fix, the first lookup returns the default next hop and
the second case returns the /120's next hop for every address.

Signed-off-by: Robert Sanford <rsanford@akamai.com>
---
 app/test/test_fib6.c | 103 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/app/test/test_fib6.c b/app/test/test_fib6.c
index ad68645428..c44b136760 100644
--- a/app/test/test_fib6.c
+++ b/app/test/test_fib6.c
@@ -23,6 +23,7 @@ static int32_t test_free_null(void);
 static int32_t test_add_del_invalid(void);
 static int32_t test_get_invalid(void);
 static int32_t test_lookup(void);
+static int32_t test_wraparound(void);
 static int32_t test_invalid_rcu(void);
 static int32_t test_fib_rcu_sync_rw(void);
 static int32_t test_drift(void);
@@ -395,6 +396,107 @@ test_lookup(void)
 	return TEST_SUCCESS;
 }
 
+/*
+ * Reproducer for the address wraparound bug in modify_dp(). When the
+ * more-specific routes under a modified prefix cover its range up to
+ * ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff, and the last of them starts
+ * exactly at the current left edge, the left edge wraps to :: and the
+ * entire table must not be overwritten.
+ *
+ *   Case A: ADD ::/0, ::/1 and 8000::/1, then DEL ::/0. Both /1
+ *           routes must still resolve.
+ *   Case B: ADD 2001:db8::/32, ffff:...:ff00/121 and
+ *           ffff:...:ff80/121, then ADD their covering
+ *           ffff:...:ff00/120. No lookup result may change.
+ */
+static int32_t
+test_wraparound(void)
+{
+	struct rte_fib6_conf config = { 0 };
+	struct rte_fib6 *fib;
+	const struct rte_ipv6_addr zero = RTE_IPV6(0, 0, 0, 0, 0, 0, 0, 0);
+	const struct rte_ipv6_addr high = RTE_IPV6(0x8000, 0, 0, 0, 0, 0, 0, 0);
+	const struct rte_ipv6_addr net = RTE_IPV6(0x2001, 0xdb8, 0, 0, 0, 0, 0, 0);
+	const struct rte_ipv6_addr top00 = RTE_IPV6(0xffff, 0xffff, 0xffff,
+		0xffff, 0xffff, 0xffff, 0xffff, 0xff00);
+	const struct rte_ipv6_addr top80 = RTE_IPV6(0xffff, 0xffff, 0xffff,
+		0xffff, 0xffff, 0xffff, 0xffff, 0xff80);
+	uint64_t def_nh = 100;
+	struct rte_ipv6_addr ip[4];
+	uint64_t nh[4];
+	int ret;
+
+	config.max_routes = 1024;
+	config.rib_ext_sz = 0;
+	config.default_nh = def_nh;
+	config.type = RTE_FIB6_TRIE;
+	config.trie.nh_sz = RTE_FIB6_TRIE_4B;
+	config.trie.num_tbl8 = 256;
+
+	/* Case A */
+	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
+
+	ret = rte_fib6_add(fib, &zero, 0, 1);
+	RTE_TEST_ASSERT(ret == 0, "ADD ::/0 failed (ret=%d)\n", ret);
+	ret = rte_fib6_add(fib, &zero, 1, 2);
+	RTE_TEST_ASSERT(ret == 0, "ADD ::/1 failed (ret=%d)\n", ret);
+	ret = rte_fib6_add(fib, &high, 1, 3);
+	RTE_TEST_ASSERT(ret == 0, "ADD 8000::/1 failed (ret=%d)\n", ret);
+
+	ret = rte_fib6_delete(fib, &zero, 0);
+	RTE_TEST_ASSERT(ret == 0, "DEL ::/0 failed (ret=%d)\n", ret);
+
+	ip[0] = (struct rte_ipv6_addr)RTE_IPV6(0, 0, 0, 0, 0, 0, 0, 1);
+	ip[1] = (struct rte_ipv6_addr)RTE_IPV6(0xffff, 0, 0, 0, 0, 0, 0, 1);
+	ret = rte_fib6_lookup_bulk(fib, ip, nh, 2);
+	RTE_TEST_ASSERT(ret == 0, "Lookup failed (ret=%d)\n", ret);
+	RTE_TEST_ASSERT(nh[0] == 2,
+		"::1: got nh %" PRIu64 ", want 2\n", nh[0]);
+	RTE_TEST_ASSERT(nh[1] == 3,
+		"ffff::1: got nh %" PRIu64 ", want 3\n", nh[1]);
+
+	rte_fib6_free(fib);
+
+	/* Case B */
+	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
+
+	ret = rte_fib6_add(fib, &net, 32, 10);
+	RTE_TEST_ASSERT(ret == 0, "ADD 2001:db8::/32 failed (ret=%d)\n", ret);
+	ret = rte_fib6_add(fib, &top00, 121, 5);
+	RTE_TEST_ASSERT(ret == 0,
+		"ADD ffff:...:ff00/121 failed (ret=%d)\n", ret);
+	ret = rte_fib6_add(fib, &top80, 121, 6);
+	RTE_TEST_ASSERT(ret == 0,
+		"ADD ffff:...:ff80/121 failed (ret=%d)\n", ret);
+
+	ret = rte_fib6_add(fib, &top00, 120, 7);
+	RTE_TEST_ASSERT(ret == 0,
+		"ADD ffff:...:ff00/120 failed (ret=%d)\n", ret);
+
+	ip[0] = (struct rte_ipv6_addr)RTE_IPV6(0x2001, 0xdb8, 0, 0, 0, 0, 0, 1);
+	ip[1] = (struct rte_ipv6_addr)RTE_IPV6(0, 0, 0, 0, 0, 0, 0, 1);
+	ip[2] = top00;
+	ip[2].a[15] = 0x01;
+	ip[3] = top80;
+	ip[3].a[15] = 0x81;
+	ret = rte_fib6_lookup_bulk(fib, ip, nh, 4);
+	RTE_TEST_ASSERT(ret == 0, "Lookup failed (ret=%d)\n", ret);
+	RTE_TEST_ASSERT(nh[0] == 10,
+		"2001:db8::1: got nh %" PRIu64 ", want 10\n", nh[0]);
+	RTE_TEST_ASSERT(nh[1] == def_nh,
+		"::1: got nh %" PRIu64 ", want %" PRIu64 "\n",
+		nh[1], def_nh);
+	RTE_TEST_ASSERT(nh[2] == 5,
+		"ffff:...:ff01: got nh %" PRIu64 ", want 5\n", nh[2]);
+	RTE_TEST_ASSERT(nh[3] == 6,
+		"ffff:...:ff81: got nh %" PRIu64 ", want 6\n", nh[3]);
+
+	rte_fib6_free(fib);
+	return TEST_SUCCESS;
+}
+
 /*
  * rte_fib6_rcu_qsbr_add positive and negative tests.
  *  - Add RCU QSBR variable to FIB
@@ -939,6 +1041,7 @@ static struct unit_test_suite fib6_fast_tests = {
 	TEST_CASE(test_add_del_invalid),
 	TEST_CASE(test_get_invalid),
 	TEST_CASE(test_lookup),
+	TEST_CASE(test_wraparound),
 	TEST_CASE(test_invalid_rcu),
 	TEST_CASE(test_fib_rcu_sync_rw),
 	TEST_CASE(test_drift),
-- 
2.34.1

