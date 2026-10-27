Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D951606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 14:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EsEAKX6p
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C34440687;
	Tue, 27 Oct 2026 15:54:36 +0100 (CET)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by mails.dpdk.org (Postfix) with ESMTPS id 5446C4064E
 for <dev@dpdk.org>; Tue, 27 Oct 2026 15:54:32 +0100 (CET)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-93f3c8958d5so422864485a.2
 for <dev@dpdk.org>; Tue, 27 Oct 2026 07:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793112871; x=1793717671; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KmHQ95gWpzl09Ua9uHJ+4K5X0KHSEmA1drux7O2iHTk=;
 b=EsEAKX6pAgSQO1pYWEcgFYKcN/FsQzobl7tPjluAc+i/ty1EqS0ZQOs3I9sO+7Y2Sl
 wZC14MeATskWJBezRVSSHURx5yB/MRiUI8Du+qKylTYA3uLQboLxHybEeVRn0IYa4sEe
 XqwCpB7hsf3Y5fLqU/S0f1vyRP1FIEVHGDjZ5XKIaFV/RsbPRqyVHKgUMmxmMPUTl4wn
 6lXdrvKZ8bB9XM079zRQKpLOWQeg86G1e/TGIKQvXW7g4rHCcgc7MPXzLkViBga2oluU
 B+PFETdQrrG1cCTNmQXcdzE8lno5NwB4BwWVEqIiZC4EeByKc2djgJlS+dQMlB/cBofU
 4Pcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793112871; x=1793717671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KmHQ95gWpzl09Ua9uHJ+4K5X0KHSEmA1drux7O2iHTk=;
 b=P6Dy62znk94QwqQDU/LA5OrO2b1zrskDvqE5SWZbfxEroZD6jHyiGZUKnuauC6EIEH
 BzDohqSKGfjs1WR9pyQV+l3X6GXTZoU9QRlGUS8yQUeX+hu0v7itvgVC6EEA3NAokE0Y
 9nTj55tnuuM8+h8bYfsg2Sx2KMjCsppMhq/okDPofn9v/KtYeWKRo1DOSM9eR2HcEQhW
 aiDeZXppXrYm6vcZrR2rvCLJefH7GH9qM+oDX/2H5yPoc9niz+4ZqI5Q6pFTaEfXFy1t
 /7PMF992+WLB+pnOI59Dpugqwg05sboZ50OPut5I7wGK+B376Ssf79EFarcyYaD+aeFm
 ZzHQ==
X-Gm-Message-State: AFq9FYIw2r1hGvYpYB5DhxQVJtaXTynHyNAyskFu02LzthhFWONtizIV
 /s3EmZs10AgvwBQAXv62MiJ3BQvDTroF/A3j2FqtMvswe1vaSZiwuwdrVknQUw==
X-Gm-Gg: AYBFou047X0u5HaJ3Sx2rTPlz+tiPEWDNGE3SsdPH9ClmS8Wz83d9cMPZa/Fq46B9eC
 Zo04O1Y1JaX/mTq4xSB3dpECiUp52WRSDZUNby3AX8nODSgTEUe1+urkjSxkt8eOU0hjOzT4MX7
 6NkAQmxzz6gbjeBm4xO2eSxVPRheXERnRgfOc36r3N+qiGBXqW1kjP3dVCyJDdvnnnGRGOqkaCU
 +I5tNvE6Ls9ijWT0z1KcvwXF3ZILvWt2yXaoq84gmvdfy3lQvQQESAw01CSfFkH6INk9NcmWWGf
 Ts0GtvwCNJhWcUPjeNrkrI4n8GFGIC29AFghUpN85ikfg2a0paDK0vgr9MOGKrnCyu5aQnZMvAD
 Kf81U1feVi+Q4kQCWg+f/6TZ/mU+RHO02U3wkVoYqmpC7e/8Bc09P9R/dN8Ov7GE53xDXJwpIrA
 AGYwsX9DoQbC7MGxtCT82YnKaNuZnISh2iEPInoTuVozfKeW0ypBc9zEJ6rcRgFKdVPnvSw2Rf5
 Fnaahdv6a2n+/cG1DFMWS0vho3JcgKS3lkprp3DGV+iHh2L2+Bg5QqcQgfxFS8kNTNIKbm43zW1
 AuiT3xsMB6QCjgtr2sqYsWfGqapoEtlz+7Du9ELQjmVoTVY9f09d+szsS7Ydww1uVrRFWoCJYST
 cz+mgn/XIyyjqutN+bldwPx1bJ6A=
X-Received: by 2002:a05:620a:1a0b:b0:93f:1ca9:f2f6 with SMTP id
 af79cd13be357-940ef974b43mr1480479085a.77.1793112871153; 
 Tue, 27 Oct 2026 07:54:31 -0700 (PDT)
Received: from bos-lhvwah.bos01.corp.akamai.com
 (g2001-4878-8037-0700-526b-8dff-fef6-cfbf.deploy.static.akamaitechnologies.com.
 [2001:4878:8037:700:526b:8dff:fef6:cfbf])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-940f0789b18sm996910385a.29.2026.10.27.07.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 07:54:30 -0700 (PDT)
From: Robert Sanford <rsanford2@gmail.com>
To: dev@dpdk.org
Cc: vladimir.medvedkin@intel.com,
	Robert Sanford <rsanford@akamai.com>
Subject: [PATCH v2 4/5] test/fib: reproduce table overwrite on address
 wraparound
Date: Tue, 27 Oct 2026 10:54:04 -0400
Message-Id: <20261027145405.3454251-5-rsanford2@gmail.com>
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
modified prefix cover its range up to 255.255.255.255. It checks
two cases:

  - delete 0.0.0.0/0 while 0.0.0.0/1 and 128.0.0.0/1 are installed,
    and check that both /1 routes still resolve.

  - add 255.255.255.0/24 over 255.255.255.0/25 and
    255.255.255.128/25, and check that an unrelated route, an
    unrouted address and both /25 routes are unchanged.

Without the fix, the first lookup returns the default next hop and
the second case returns the /24's next hop for every address.

Signed-off-by: Robert Sanford <rsanford@akamai.com>
---
 app/test/test_fib.c | 94 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/app/test/test_fib.c b/app/test/test_fib.c
index bd73399d56..62c0ce1e70 100644
--- a/app/test/test_fib.c
+++ b/app/test/test_fib.c
@@ -22,6 +22,7 @@ static int32_t test_free_null(void);
 static int32_t test_add_del_invalid(void);
 static int32_t test_get_invalid(void);
 static int32_t test_lookup(void);
+static int32_t test_wraparound(void);
 static int32_t test_invalid_rcu(void);
 static int32_t test_fib_rcu_sync_rw(void);
 
@@ -379,6 +380,98 @@ test_lookup(void)
 	return TEST_SUCCESS;
 }
 
+/*
+ * Reproducer for the address wraparound bug in modify_fib(). When the
+ * more-specific routes under a modified prefix cover its range up to
+ * 255.255.255.255, and the last of them starts exactly at the current
+ * left edge, the left edge wraps to 0 and the entire table must not
+ * be overwritten.
+ *
+ *   Case A: ADD 0.0.0.0/0, 0.0.0.0/1 and 128.0.0.0/1, then DEL
+ *           0.0.0.0/0. Both /1 routes must still resolve.
+ *   Case B: ADD 10.0.0.0/8, 255.255.255.0/25 and 255.255.255.128/25,
+ *           then ADD their covering 255.255.255.0/24. No lookup result
+ *           may change.
+ */
+static int32_t
+test_wraparound(void)
+{
+	struct rte_fib_conf config = { 0 };
+	struct rte_fib *fib;
+	uint64_t def_nh = 100;
+	uint32_t ip[4];
+	uint64_t nh[4];
+	int ret;
+
+	config.max_routes = 1024;
+	config.rib_ext_sz = 0;
+	config.default_nh = def_nh;
+	config.type = RTE_FIB_DIR24_8;
+	config.dir24_8.nh_sz = RTE_FIB_DIR24_8_4B;
+	config.dir24_8.num_tbl8 = 256;
+
+	/* Case A */
+	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
+
+	ret = rte_fib_add(fib, RTE_IPV4(0, 0, 0, 0), 0, 1);
+	RTE_TEST_ASSERT(ret == 0, "ADD 0.0.0.0/0 failed (ret=%d)\n", ret);
+	ret = rte_fib_add(fib, RTE_IPV4(0, 0, 0, 0), 1, 2);
+	RTE_TEST_ASSERT(ret == 0, "ADD 0.0.0.0/1 failed (ret=%d)\n", ret);
+	ret = rte_fib_add(fib, RTE_IPV4(128, 0, 0, 0), 1, 3);
+	RTE_TEST_ASSERT(ret == 0, "ADD 128.0.0.0/1 failed (ret=%d)\n", ret);
+
+	ret = rte_fib_delete(fib, RTE_IPV4(0, 0, 0, 0), 0);
+	RTE_TEST_ASSERT(ret == 0, "DEL 0.0.0.0/0 failed (ret=%d)\n", ret);
+
+	ip[0] = RTE_IPV4(1, 1, 1, 1);
+	ip[1] = RTE_IPV4(200, 1, 1, 1);
+	ret = rte_fib_lookup_bulk(fib, ip, nh, 2);
+	RTE_TEST_ASSERT(ret == 0, "Lookup failed (ret=%d)\n", ret);
+	RTE_TEST_ASSERT(nh[0] == 2,
+		"1.1.1.1: got nh %" PRIu64 ", want 2\n", nh[0]);
+	RTE_TEST_ASSERT(nh[1] == 3,
+		"200.1.1.1: got nh %" PRIu64 ", want 3\n", nh[1]);
+
+	rte_fib_free(fib);
+
+	/* Case B */
+	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
+
+	ret = rte_fib_add(fib, RTE_IPV4(10, 0, 0, 0), 8, 10);
+	RTE_TEST_ASSERT(ret == 0, "ADD 10.0.0.0/8 failed (ret=%d)\n", ret);
+	ret = rte_fib_add(fib, RTE_IPV4(255, 255, 255, 0), 25, 5);
+	RTE_TEST_ASSERT(ret == 0,
+		"ADD 255.255.255.0/25 failed (ret=%d)\n", ret);
+	ret = rte_fib_add(fib, RTE_IPV4(255, 255, 255, 128), 25, 6);
+	RTE_TEST_ASSERT(ret == 0,
+		"ADD 255.255.255.128/25 failed (ret=%d)\n", ret);
+
+	ret = rte_fib_add(fib, RTE_IPV4(255, 255, 255, 0), 24, 7);
+	RTE_TEST_ASSERT(ret == 0,
+		"ADD 255.255.255.0/24 failed (ret=%d)\n", ret);
+
+	ip[0] = RTE_IPV4(10, 1, 1, 1);
+	ip[1] = RTE_IPV4(1, 2, 3, 4);
+	ip[2] = RTE_IPV4(255, 255, 255, 1);
+	ip[3] = RTE_IPV4(255, 255, 255, 129);
+	ret = rte_fib_lookup_bulk(fib, ip, nh, 4);
+	RTE_TEST_ASSERT(ret == 0, "Lookup failed (ret=%d)\n", ret);
+	RTE_TEST_ASSERT(nh[0] == 10,
+		"10.1.1.1: got nh %" PRIu64 ", want 10\n", nh[0]);
+	RTE_TEST_ASSERT(nh[1] == def_nh,
+		"1.2.3.4: got nh %" PRIu64 ", want %" PRIu64 "\n",
+		nh[1], def_nh);
+	RTE_TEST_ASSERT(nh[2] == 5,
+		"255.255.255.1: got nh %" PRIu64 ", want 5\n", nh[2]);
+	RTE_TEST_ASSERT(nh[3] == 6,
+		"255.255.255.129: got nh %" PRIu64 ", want 6\n", nh[3]);
+
+	rte_fib_free(fib);
+	return TEST_SUCCESS;
+}
+
 /*
  * rte_fib_rcu_qsbr_add positive and negative tests.
  *  - Add RCU QSBR variable to FIB
@@ -598,6 +691,7 @@ static struct unit_test_suite fib_fast_tests = {
 	TEST_CASE(test_add_del_invalid),
 	TEST_CASE(test_get_invalid),
 	TEST_CASE(test_lookup),
+	TEST_CASE(test_wraparound),
 	TEST_CASE(test_invalid_rcu),
 	TEST_CASE(test_fib_rcu_sync_rw),
 	TEST_CASES_END()
-- 
2.34.1

