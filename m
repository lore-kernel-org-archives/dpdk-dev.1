Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A5E606A322
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 00:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gFdecvrI
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9906E4067B;
	Tue, 27 Oct 2026 01:14:58 +0100 (CET)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com
 [209.85.160.176])
 by mails.dpdk.org (Postfix) with ESMTPS id 60DE2402E0
 for <dev@dpdk.org>; Tue, 27 Oct 2026 01:14:57 +0100 (CET)
Received: by mail-qt1-f176.google.com with SMTP id
 d75a77b69052e-5367cc15121so50961701cf.0
 for <dev@dpdk.org>; Mon, 26 Oct 2026 17:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793060096; x=1793664896; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+cFQRloaoQTQ2krSXRqx7NG9YM7d9AqGl2TD3fo4/6k=;
 b=gFdecvrIpVzaZO8o0/aDBDbgmm963SBPuPQebNbcf6ALiVGkKRu5gADgvb3niU5mWO
 Lv1KvGTzfw5LLtIFlEOctKWcnftHEtm8Jt6M7bpL8x9O5N4uHMa5lZ5TtXzWbOfKidp8
 7S8bOQb3UHsbSppORTM6L8zDVzfTIn4yCRwccTsTNytuoTrUgWMtzUnkMVlM5CkKFDsy
 F9PEJ7JMaC0V/91msBhAE+arQ7Qu1j+sw/HE9UEyL9bVPVcT8qfuT8Aq9PXTOZPB0H/y
 D2NX8vuh+ImCwfy8N58VmGn6A0suJZnF5BdA58cL+3eMZ3edflQgVsSXPYa1O/8hlfWn
 S6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793060096; x=1793664896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+cFQRloaoQTQ2krSXRqx7NG9YM7d9AqGl2TD3fo4/6k=;
 b=e1aWMueqn1lceGNy8aGmSyeLSrvDhGVdRyi/Nppx92MNFSAqCkr1aTcJaLT58A8FK4
 7P0h3a3IbCen6IXOh0PoLG8bPsDQhebAnZr7gKe4ka1YVb7CYFiAi6rN/6hvOfqLJmgy
 AMW1U7Wmf/N6wxf8daTPUIcyNAg1Vew1EPiOdJ6mDnpAN1aGbrMjbGYhSgBRvTFui+Rr
 v6EbtRjhodQ5ZL06JhBCiKAtQQNgKQ0mtPR1hSYpVTYCyGwMYAlb3hEka9g8enYdG92d
 scxYbPi5MUBN4zNV1D/AM9rvrBpu5jBROF1rDRn0HXUES58r/WncQaj1LyKGA57e88Zg
 InWw==
X-Gm-Message-State: AFq9FYJI7uYGABcH3j5wt8GbFCPuXAaVK8akIXGG4fWDmrGUbl60NSpE
 P44NJUodPeaUw/PDlDBuZtYhxUbDkNIZ22WrTsTNoJPFMnm9kzZV03okDFhBbQ==
X-Gm-Gg: AYBFou08zruHOB79CEq6AZJ28Lurnk7HWQahbJmAuFWmVlsuyknGa1Ff5IBaClD0/49
 vlsZ+LJHaWXJcPlgyWA2ePmajNIznlqvoj0D2iB+DirmDhqnT1IhDLD8kzqHLi4T1k1/XyeIJl+
 ZLdaFHaE7vPR4P2iJ2vgq+mtCrFTJW0gFRSR3nGoKAZjFNqR+lKPel5b1RmQyjq/rjgCPTlHowX
 PV/D2KvdxAmDdfcnEeHkBJ+whiz6x8c7R0/nECamzGUSn9tJcZXhXM2nRehzqTwgYdBHdcUTGKa
 0sBGAzsh8vx847sukxRtLJaq57zHFvS1dcaI632YXEzdgaloySNkrM0mI1l0XO5MFjONRhlXYeB
 Av+j6sTdeLJX3+naGphKD/VA2ombgulElcU0vb5AXxDv28TdKM3JWg47EzptS2xwkw3WexSeYgG
 jHo8nglRngJYh6ClCRHcGkC6mZ2ivprQXQ61msZNAmDhYO5PWnl7U37sC6cfbUaNrR5EQAF9erJ
 u2YWlIeqmO0PT4+zk0IehpWVc1/VaEWRfZ1FYz/sp9g2coXrIxX2LhRZuEV0LGcsDXvIEHjYlEj
 TePW6rCydqLHSfDPrEQkMFC3AWL10/+vOquUnnCpqStfnmcgfXvO3Jntu4F1oibZm4jY88P+XtO
 YONKKFpLMIhuj09GwdLlCAh2Mj2w=
X-Received: by 2002:a05:622a:5c0e:b0:534:c04e:bfa4 with SMTP id
 d75a77b69052e-5383b60dbdamr135150471cf.47.1793060096289; 
 Mon, 26 Oct 2026 17:14:56 -0700 (PDT)
Received: from bos-lhvwah.bos01.corp.akamai.com
 (g2001-4878-8037-0700-526b-8dff-fef6-cfbf.deploy.static.akamaitechnologies.com.
 [2001:4878:8037:700:526b:8dff:fef6:cfbf])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c65ef7b0fsm31449136d6.19.2026.10.26.17.14.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 17:14:54 -0700 (PDT)
From: Robert Sanford <rsanford2@gmail.com>
To: dev@dpdk.org
Cc: vladimir.medvedkin@intel.com,
	Robert Sanford <rsanford@akamai.com>
Subject: [PATCH v1 4/4] test/fib6: reproduce table overwrite on address
 wraparound
Date: Mon, 26 Oct 2026 20:14:23 -0400
Message-Id: <20261027001423.3028072-5-rsanford2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027001423.3028072-1-rsanford2@gmail.com>
References: <20261027001423.3028072-1-rsanford2@gmail.com>
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

