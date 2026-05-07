Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBA8CD3427
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 09:51:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E5D464066B;
	Thu,  7 May 2026 11:50:53 +0200 (CEST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id 41F2D4065E
 for <dev@dpdk.org>; Thu,  7 May 2026 11:50:52 +0200 (CEST)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so7857385e9.2
 for <dev@dpdk.org>; Thu, 07 May 2026 02:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778147452; x=1778752252; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ljawef+pOQJm2kKUZk21NBvEZpa0AHaVlbp2VUbBOqM=;
 b=fV6XTE3mvJKGXBsIarXXxUvtDuwAUdt6vZZkrbccuCDaNMtLw+cdJs6719qng/fY2U
 VF5KHQeFPnuV8FR9xgiXCIJOtqn7NKeuySGMuO5Ztcl7Tcs/9fdIClPLrqR624I4UlZR
 9N2KjVE3s9IAt2znNRY2FwWcUol5TK8ynz7dalwEeAA3y2i7g56Ut3Uoixnc3jlsyZGz
 zzqYpSJEev1oCwQMNqNt/ywp+2NR6kkTxnHH/AI3z0820Okga3Siyv47iSwfyD4recdg
 u1nYYHzaf4SUpGZnDphPyBYeS8FMeG3IrEo2P2INUGUuoBoteR6P2tzUUiDOs7ApQ8g5
 lHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778147452; x=1778752252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ljawef+pOQJm2kKUZk21NBvEZpa0AHaVlbp2VUbBOqM=;
 b=j3QJg9TT7UcurL+SZG2EHr6Em7+B4+coRWGrpJ2rDU4udJEgZ6nv/HS+u1v3I19Ddb
 dV1yz6m/+LY7ytZLBQt+Yk3/qdSivsQ50329vW20or1osslyEX0iITtjwIJF/u4B6PVf
 pVejjiFe5ad+msdtNPDra4vOh+F2VWZtPg7W3VPcFCPXmLv5bpyMJwUUuiqzxMXlIZZK
 MvBPxHSRsT9SbVUwcwuCZFhKF6nf0zfBkUJkuETZV6zEjK3VBGw/AtdZl5/RppwoCBPX
 y4OXKxw3aC3qx7Hs5v7SfwC/DqfEsqt1Kvj8trpM3HKZagpd3v6i+OPrCn6RXvwkmZBJ
 JbIg==
X-Gm-Message-State: AOJu0YwH29Nlpt3L5rklIGZaHFmOuvIuGf2YbUs1yyGJOaVTkNuMrhVj
 9NeZxAMe8igt6Cg5gWMRYjndSqObuarnB8e0I+PrDTs/banaktm//bmB
X-Gm-Gg: AeBDietVcO3zPGtqYOi95jAIRQJUeCIOWj4TSrLyuvr3VDZ0JPEGs8HFiKGgllcRiMB
 p3To/RKFrzb/Qfa5h3GVJU5JhryATLS6XisMib8frkDoelLPxVpvHKRQP4N0iCTw5NR0jfW9bpe
 ojsA8cF5Tdz67GX1taWoD5hdirYpbogIon8CiZJ1EKpMh5TvVX6n5be12BYTHJm0ke4PtYU8JP/
 DIPkSK2a2v22sPC05REz/MWmB8bN5aMEdRZSGK2IMg1y3N+fAufBgJ3BnR12w4bV8Lz6uX2PzSt
 Lc9SudsqbUMPa0dBSpST144oFeijdL5r4yhKczugpCh+Nr/FvVu8tywJS0nngAnaTndma8qerxO
 vuDONIkYbK3CHlr7tBvH5NbfAhzMxjijVNgPWbx6ZTjB2Bsby/19+Th6FL3gcn35CRZdJLFHarh
 uTvLzIOq1pk2O0kiE0H5Wieu45yjirX8OUroDFabGHoL1YdhU/zmqvbOOAh2ORlhoUA9Grr8TM3
 A==
X-Received: by 2002:a05:600c:1d18:b0:48a:5574:3a5b with SMTP id
 5b1f17b1804b1-48e51f45c84mr117965245e9.27.1778147451368; 
 Thu, 07 May 2026 02:50:51 -0700 (PDT)
Received: from freepad.iliad.local (free-mobile.vlq16.iliad.fr. [213.36.7.11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538b26a3sm207209465e9.9.2026.05.07.02.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:50:50 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org,
	Maxime Leroy <maxime@leroys.fr>
Subject: [RFC 2/3] test/fib6: add reproducer for tbl8 reservation drift
Date: Thu,  7 May 2026 11:50:42 +0200
Message-ID: <309bfce729c90a9d78afe0ed8cd6ce7e2d62598e.1778146229.git.maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1778146229.git.maxime@leroys.fr>
References: <cover.1778146229.git.maxime@leroys.fr>
MIME-Version: 1.0
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

Regression test for the rsvd_tbl8s drift bug fixed in
"fib6: fix tbl8 reservation drift in trie".

The test installs a /28 parent and three /48 children, deletes the
/28 parent while children are alive, then deletes each /48 child.
One asymmetric cycle wraps rsvd_tbl8s past zero (net -2 per cycle).

The probe is a /28 ADD (depth_diff=1) so UINT32_MAX-1 + 1 exceeds
the pool size without further uint32_t overflow.

Without the fix, the final ADD /28 fails with -ENOSPC.
With the fix, it succeeds.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 app/test/test_fib6.c | 83 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/app/test/test_fib6.c b/app/test/test_fib6.c
index fffb590dbf..85a6c0abc3 100644
--- a/app/test/test_fib6.c
+++ b/app/test/test_fib6.c
@@ -25,6 +25,7 @@ static int32_t test_get_invalid(void);
 static int32_t test_lookup(void);
 static int32_t test_invalid_rcu(void);
 static int32_t test_fib_rcu_sync_rw(void);
+static int32_t test_drift(void);
 
 #define MAX_ROUTES	(1 << 16)
 /** Maximum number of tbl8 for 2-byte entries */
@@ -599,6 +600,87 @@ test_fib_rcu_sync_rw(void)
 	return status == 0 ? TEST_SUCCESS : TEST_FAILED;
 }
 
+/*
+ * Reproducer for the rsvd_tbl8s drift bug. depth_diff used to maintain
+ * rsvd_tbl8s is computed from the current RIB state, so it is not
+ * invariant between the ADD of a prefix and its later DEL when a
+ * covering parent prefix is removed in between.
+ *
+ * Layout: one /28 parent (fcde::/28) and three /48 siblings under it
+ * (fcde:0:6000::/48, fcde:1:6000::/48, fcde:2:6000::/48). The second
+ * hextet's high 12 bits are zero, so the three /48 IPs all fall inside
+ * the /28.
+ *
+ * One asymmetric sequence is enough to wrap the counter:
+ *   ADD /28                                  rsvd_tbl8s += 1
+ *   ADD /48 child_0,1,2 (with /28 parent)    rsvd_tbl8s += 2 each (+6)
+ *   DEL /28 (sibling /48 found)              rsvd_tbl8s -= 0
+ *   DEL /48 child_0,1,2 (no parent left)     rsvd_tbl8s -= 3 each (-9)
+ *
+ * Net: -2. Starting from 0, rsvd_tbl8s wraps to UINT32_MAX-1. The
+ * next ADD of a prefix longer than /24 then unconditionally fails the
+ * pre-check (rsvd_tbl8s + depth_diff > number_tbl8s), even though the
+ * pool is empty.
+ */
+static int32_t
+test_drift(void)
+{
+	struct rte_fib6_conf config = { 0 };
+	struct rte_fib6 *fib;
+	struct rte_ipv6_addr parent =
+		RTE_IPV6(0xfcde, 0, 0, 0, 0, 0, 0, 0);
+	struct rte_ipv6_addr child[3] = {
+		RTE_IPV6(0xfcde, 0, 0x6000, 0, 0, 0, 0, 0),
+		RTE_IPV6(0xfcde, 1, 0x6000, 0, 0, 0, 0, 0),
+		RTE_IPV6(0xfcde, 2, 0x6000, 0, 0, 0, 0, 0),
+	};
+	unsigned int c;
+	int ret;
+
+	config.max_routes = 1024;
+	config.rib_ext_sz = 0;
+	config.default_nh = 0;
+	config.type = RTE_FIB6_TRIE;
+	config.trie.nh_sz = RTE_FIB6_TRIE_2B;
+	config.trie.num_tbl8 = 256;
+
+	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
+
+	ret = rte_fib6_add(fib, &parent, 28, 0xa);
+	RTE_TEST_ASSERT(ret == 0, "ADD /28 failed (ret=%d)\n", ret);
+
+	for (c = 0; c < 3; c++) {
+		ret = rte_fib6_add(fib, &child[c], 48, 0xb + c);
+		RTE_TEST_ASSERT(ret == 0,
+			"ADD /48 child %u failed (ret=%d)\n", c, ret);
+	}
+
+	ret = rte_fib6_delete(fib, &parent, 28);
+	RTE_TEST_ASSERT(ret == 0, "DEL /28 failed (ret=%d)\n", ret);
+
+	for (c = 0; c < 3; c++) {
+		ret = rte_fib6_delete(fib, &child[c], 48);
+		RTE_TEST_ASSERT(ret == 0,
+			"DEL /48 child %u failed (ret=%d)\n", c, ret);
+	}
+
+	/*
+	 * Pre-fix: -ENOSPC because rsvd_tbl8s wrapped to UINT32_MAX-1.
+	 * Post-fix: succeeds; the pre-check uses tbl8_pool_pos which
+	 * accurately reflects the (empty) pool.
+	 */
+	ret = rte_fib6_add(fib, &parent, 28, 0xe);
+	RTE_TEST_ASSERT(ret == 0,
+		"Fresh ADD /28 spuriously failed (ret=%d)\n", ret);
+
+	ret = rte_fib6_delete(fib, &parent, 28);
+	RTE_TEST_ASSERT(ret == 0, "Final DEL /28 failed (ret=%d)\n", ret);
+
+	rte_fib6_free(fib);
+	return TEST_SUCCESS;
+}
+
 static struct unit_test_suite fib6_fast_tests = {
 	.suite_name = "fib6 autotest",
 	.setup = NULL,
@@ -611,6 +693,7 @@ static struct unit_test_suite fib6_fast_tests = {
 	TEST_CASE(test_lookup),
 	TEST_CASE(test_invalid_rcu),
 	TEST_CASE(test_fib_rcu_sync_rw),
+	TEST_CASE(test_drift),
 	TEST_CASES_END()
 	}
 };
-- 
2.43.0

