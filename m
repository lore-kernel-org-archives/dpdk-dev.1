Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5184606A31D
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 00:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=I23cFhsO
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D714C40431;
	Tue, 27 Oct 2026 01:14:57 +0100 (CET)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49])
 by mails.dpdk.org (Postfix) with ESMTPS id C1ECA4060C
 for <dev@dpdk.org>; Tue, 27 Oct 2026 01:14:55 +0100 (CET)
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-9179bfa9e9cso52642156d6.1
 for <dev@dpdk.org>; Mon, 26 Oct 2026 17:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793060095; x=1793664895; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KmHQ95gWpzl09Ua9uHJ+4K5X0KHSEmA1drux7O2iHTk=;
 b=I23cFhsOHY9C1/shFJW7/PNzZZtQ1kgXJFypI/bsVhVbFgxNeHCBqEdgDMMzGzA/fz
 kUsFcF71EU37U+bNcZBpuFBgL6IKiM+4I8w5TTd/2Cv2aEGSTF6h2XrnLm491xr2h9/n
 EK+gg68lRraQvGuNYp5ClEYihVYiKHIkUfah/OqG5gtOWqzJkC5ajggi3bdcaY8mSkCp
 hepFJbKQlfLQV4HuwgsRAdSOj6SXIIEmkMhbMFp8aSuVc9EnUl1yzF8OzDk9N+bRqf+b
 /c0TuAbDKwdQFo4TLUzqNwWgcTkKNuuxeQ4ArQAgDzT2AHfGRaZgQzykbNmdh3kKig+Q
 1m/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793060095; x=1793664895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KmHQ95gWpzl09Ua9uHJ+4K5X0KHSEmA1drux7O2iHTk=;
 b=ViFsgtbMtkf8Kb92cl7ahn9tS/OzaOnDoqYU+lwF54ZzG7SgQ3HNrT8c6LjSaQTUfM
 ezA27/BlQyYv/OXQ/ZuWkaO1zsNZ5Zd0PuCrZsFgwj2FNs+I6n9jXkwFrVH097bjupG2
 A94/j+XYlbiBxr9i/R2ksHg+lp0xzeMdOrTSi+N1R1PFY+4WreqHii8n5BCbJX5LcPFl
 mzZVjFZIXfxKVvkeGGrwqJdYi+pcsbU4QL7OM1gr5JFGSZGOdKdETGQDp8QjoXZRW43Y
 KZWB7wm+DZlKIrhZZHpZqCpDizwT4WN5nudaqK80Bif2iGmllhM/af9j3IzPOHeXDRYe
 oCHg==
X-Gm-Message-State: AFq9FYLR9BsHbdYv6fS9h0Zb07XjJKxdK+4zZgC1cSVEbQS/aDs+ImEa
 8v/3/CO9ODo4OtfshA6egg2oVWT4R5TgU1OuLwXa9v2w0SSWg8LEuHaTVNkwHg==
X-Gm-Gg: AYBFou0quglyIXkyaGFWnfssZsBcJP8jglhA0P+sPYIkyicqDQxv8wwyDPvTDVA2TtC
 0SJEZp30h3h+lwxNjGw2UD3O95SDQfc4JXJ+ddxGIuyfDTJNZ3WUW/QfANaBXytVy+2XYv8oXbh
 kan3WmIdKD/zKwH+O3uX8FybDBVL3MSnU0ZnGw2Q3hUrWT3YDwfkvILyk/UOgZ5BUayaQqLUHVW
 8mzZVdLOftIKRrL9LHk5uk3XxFVCNGTmhbTR4p0e+xsG54H7SXljQ3/fclajne3K9jLeHvf2fYD
 LiTZ85Oyrsd/UAwchZTz5DjPIhSnbrPXro7LtaQBIP5T1rh3rfJ7BbejsP+FLmqk1yT2CKFhr5J
 em0TchJTp6nqJwl4gELE6LJksCVPoUnYs2t5G3mhlw+1me6ykfCQm4JdT7h/zBBwErCHBosgvDr
 edXY+7Yl2SiTFTbO9PslWM6eOmGzYRVLF1rPCzulV5p4JV1pOLQUVRK2uvVR1bvLLrVmhHcm/Ng
 8j0h+XPDAu7SwwH7db3sHj84jkdhpG/oeIAySLOSdH7ARObhMA9BlVerMNh/tCBd0wd1XwYEKKY
 vJvYEMW1yPRN/GrD1QO24aWmUSjV3M4x0MevRk5YT1dFn6RuUzIXXwz0ksxtXZsRbcohKlwstJM
 oj0I9NISMHwdL1D8TQfuHcFriG9w=
X-Received: by 2002:a05:620a:4398:b0:93e:5e2c:8bf2 with SMTP id
 af79cd13be357-940ef8be9aemr1450885385a.21.1793060094667; 
 Mon, 26 Oct 2026 17:14:54 -0700 (PDT)
Received: from bos-lhvwah.bos01.corp.akamai.com
 (g2001-4878-8037-0700-526b-8dff-fef6-cfbf.deploy.static.akamaitechnologies.com.
 [2001:4878:8037:700:526b:8dff:fef6:cfbf])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c65ef7b0fsm31449136d6.19.2026.10.26.17.14.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 17:14:52 -0700 (PDT)
From: Robert Sanford <rsanford2@gmail.com>
To: dev@dpdk.org
Cc: vladimir.medvedkin@intel.com,
	Robert Sanford <rsanford@akamai.com>
Subject: [PATCH v1 3/4] test/fib: reproduce table overwrite on address
 wraparound
Date: Mon, 26 Oct 2026 20:14:22 -0400
Message-Id: <20261027001423.3028072-4-rsanford2@gmail.com>
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

