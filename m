Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063F7CD5BB0
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 14:59:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3E4B4068E;
	Fri, 22 May 2026 16:59:10 +0200 (CEST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id CB58740674
 for <dev@dpdk.org>; Fri, 22 May 2026 16:59:08 +0200 (CEST)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-44a044cb827so5572559f8f.0
 for <dev@dpdk.org>; Fri, 22 May 2026 07:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779461948; x=1780066748; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EKVBZFil5ZhOzgKOmalNyXZnEUAQkbzqihirZz/2DcI=;
 b=sD0Pig9JoDm2s6/31hE8Ltqu7K/o5JQY9NqIaL9vbNDOd6NqPfLFGv0Rc4lE8YZ5Kp
 WXCC59gKOysTGoEolwArX/W2ASYzkd9JWSgQvMXetJr97kfShx+B+WEgiR3GIvGC+JTy
 JoCDaoabQNajq6aagAfODbjnVKgYf/qjlcMR1Jv8+q+KpgdPnj6pF6vWMAeLwBONfpOG
 u2OqearmKNQgy7dv2sNYNGsLYimWmJQ5xcWOBeZJ0mG2Xr4TylWycYv5Lhc938tKxLDW
 HhUI4/lZctKczCjr9iSYENKkIinIyswmmfnoL1/nBLnL3tKZj7NEiddMbp/UwPwBR66w
 S6IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779461948; x=1780066748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EKVBZFil5ZhOzgKOmalNyXZnEUAQkbzqihirZz/2DcI=;
 b=jlKPsjcEphnJl1jIb1P1kwH4zOtqL9KZrV5iY+T31oWlbViw/ZVmQ8Khy+x89USFb7
 HGgrppgx1wn+C1MqrffEgQJNJl9g8yKijUwBrNyE+z7H+jK/sP+F/exL6H9m4y9VE908
 5H/2vWIFh2pYVZ3vO9S82DQk5qjJIIvCPkogIlQn2nvZZM27FwuhtdMIvC7C5M1lIILm
 xFPihqrcWmO9ybqSPNTksfv7w7JZCw4d5CpxGtIiXC1EUF64w7fMTDQVVKeEpymjnSIA
 /eYzyJCs9Bwej4r9MlHRoXEPCPKtOtTrBEToIqbz6IgFtbFfV2hfEChOsTPCSr9dk0rm
 FB9w==
X-Gm-Message-State: AOJu0YzpnT8wippLwGFmk7e8kpL8i3kjhf9HzxXRsVyhNEXqD/05sYCS
 0Or4YDRKB/eeNkp0lfAY14+JwlVJ6hIwfRUwH8xQyjsjDXZXeB0TjMFw+PtzIaT8
X-Gm-Gg: Acq92OGQrnwm9rW7nirRMtysjj+wiggA6VnMeHCdW4ETgBgbKfg/A432gueSXxbcvjs
 lPJATxQPRjXdvEsM9djWkKyussIhMxbQKFMjzB0Yhe1ORLcRXmrGvEDe6xiDKZ/3YxP/Eqr96lW
 bDXD1vhqYRGM2NxHnWmY0gOVesXWysWJGvS1TQafo+w3B8iZEFNQ6GZ5igo8i6DyvOOQ1X/5lBZ
 gIBLM+WXMRjH2z447r0b4xJM4umKfvbmjXIkrayG/+9JYNm3e/3jwW/PxCfaDbTL1ZoCb5lYVyZ
 QhGh+KxKypg0edYkSt5T/UBEGCGWgEQNQTyM7Hvc6hswNRB+n6Cm2yoz6mKaq8LVaHMi8VVNeUF
 IgF3/2TZk60l1rGAJ0c3SjEJ3rxQWqgPZaQky6PIbnOOMjQJCOCkBiSihtoI/Q/DuHk/EwGomzd
 p1WEKC6PtBQm60RCnt1CbafECn9UqlTRwqBPzeSV+7CdvsXT3gW7OLcqVYW/DUI8/+0g==
X-Received: by 2002:a05:600c:4ecc:b0:485:4388:3492 with SMTP id
 5b1f17b1804b1-490424b25abmr54758435e9.11.1779461948000; 
 Fri, 22 May 2026 07:59:08 -0700 (PDT)
Received: from localhost.localdomain (free-mobile.vlq16.iliad.fr.
 [213.36.7.11]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49049ab1d82sm3114875e9.0.2026.05.22.07.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 07:59:06 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org,
	stable@dpdk.org,
	Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v1 3/5] test/fib6: extended drift test cases
Date: Fri, 22 May 2026 16:58:52 +0200
Message-ID: <20260522145855.1748406-4-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522145855.1748406-1-maxime@leroys.fr>
References: <cover.1778146229.git.maxime@leroys.fr>
 <20260522145855.1748406-1-maxime@leroys.fr>
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

Four additional test cases exercise scenarios touched by the
multi-level supernet counting:

  - test_drift_compression: parent + compressed child, DEL parent
    forces decompression, re-ADD ancestor re-compresses.

  - test_drift_multilevel: /28 + /48 + /96 chain with mixed
    compressed and non-compressed links, then DEL of the middle
    prefix.

  - test_drift_stress: pseudo-random ADD/DEL sequence checking that
    no operation returns -ENOSPC under a leaked rsvd_tbl8s.

  - test_drift_tight_pool: pool sized to exactly the legitimate
    envelope, re-ADD after decompression must succeed.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 app/test/test_fib6.c | 269 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 265 insertions(+), 4 deletions(-)

diff --git a/app/test/test_fib6.c b/app/test/test_fib6.c
index c4283f3f2d..ad68645428 100644
--- a/app/test/test_fib6.c
+++ b/app/test/test_fib6.c
@@ -26,6 +26,10 @@ static int32_t test_lookup(void);
 static int32_t test_invalid_rcu(void);
 static int32_t test_fib_rcu_sync_rw(void);
 static int32_t test_drift(void);
+static int32_t test_drift_compression(void);
+static int32_t test_drift_multilevel(void);
+static int32_t test_drift_stress(void);
+static int32_t test_drift_tight_pool(void);
 
 #define MAX_ROUTES	(1 << 16)
 /** Maximum number of tbl8 for 2-byte entries */
@@ -601,10 +605,9 @@ test_fib_rcu_sync_rw(void)
 }
 
 /*
- * Reproducer for the rsvd_tbl8s drift bug. depth_diff used to maintain
- * rsvd_tbl8s is computed from the current RIB state, so it is not
- * invariant between the ADD of a prefix and its later DEL when a
- * covering parent prefix is removed in between.
+ * Reproducer for the rsvd_tbl8s drift bug. The tbl8 reservation
+ * accounting must remain balanced even when a covering parent prefix
+ * is removed between an ADD and its later matching DEL.
  *
  * Layout: one /28 parent (fcde::/28) and three /48 siblings under it
  * (fcde:0:6000::/48, fcde:1:6000::/48, fcde:2:6000::/48). The second
@@ -672,6 +675,260 @@ test_drift(void)
 	return TEST_SUCCESS;
 }
 
+/*
+ * Exercise compression (same nh as parent), forced decompression on
+ * DEL parent, then re-compression after re-adding the same ancestor.
+ * The tbl8 reservation accounting must remain balanced even though
+ * the child is physically decompressed/recompressed in the dataplane.
+ *
+ * Layout: parent fcde::/28 and child fcde:0:6000::/48, both nh=1.
+ *
+ *   ADD /28 (no ancestor)                    rsvd_tbl8s += 1
+ *   ADD /48 (compressed under /28)           rsvd_tbl8s += 2
+ *   DEL /28 (decompresses /48)               rsvd unchanged (/48 keeps)
+ *   re-ADD /28 (re-compresses /48)           rsvd unchanged
+ *   DEL /48                                  rsvd_tbl8s -= 2
+ *   DEL /28                                  rsvd_tbl8s -= 1
+ */
+static int32_t
+test_drift_compression(void)
+{
+	struct rte_fib6_conf config = { 0 };
+	struct rte_fib6 *fib;
+	struct rte_ipv6_addr parent = RTE_IPV6(0xfcde, 0, 0, 0, 0, 0, 0, 0);
+	struct rte_ipv6_addr child = RTE_IPV6(0xfcde, 0, 0x6000, 0, 0, 0, 0, 0);
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
+	/* Compressed: child shares the parent's nh, modify_dp is skipped */
+	ret = rte_fib6_add(fib, &parent, 28, 1);
+	RTE_TEST_ASSERT(ret == 0, "ADD /28 failed\n");
+	ret = rte_fib6_add(fib, &child, 48, 1);
+	RTE_TEST_ASSERT(ret == 0, "ADD /48 (compressed) failed\n");
+
+	/* DEL parent forces decompression: child must be materialized */
+	ret = rte_fib6_delete(fib, &parent, 28);
+	RTE_TEST_ASSERT(ret == 0, "DEL /28 (decompression) failed\n");
+
+	/* Re-add parent with same nh: child becomes compressed again */
+	ret = rte_fib6_add(fib, &parent, 28, 1);
+	RTE_TEST_ASSERT(ret == 0, "Re-ADD /28 failed\n");
+
+	ret = rte_fib6_delete(fib, &child, 48);
+	RTE_TEST_ASSERT(ret == 0, "DEL /48 failed\n");
+	ret = rte_fib6_delete(fib, &parent, 28);
+	RTE_TEST_ASSERT(ret == 0, "DEL /28 final failed\n");
+
+	rte_fib6_free(fib);
+	return TEST_SUCCESS;
+}
+
+/*
+ * Three-level nesting with compressed and non-compressed paths, then
+ * DEL of the middle prefix. The byte-boundary supernet accounting
+ * must remain balanced through the chain.
+ *
+ * Layout: grand fcde::/28 nh=1, mid fcde:0:6000::/48 nh=1 (compressed
+ * under grand), leaf fcde:0:6000::4000::/96 nh=2 (not compressed).
+ *
+ *   ADD /28 (no ancestor)                    rsvd_tbl8s += 1
+ *   ADD /48 (compressed under /28)           rsvd_tbl8s += 2
+ *   ADD /96 (not compressed under /48)       rsvd_tbl8s += 6
+ *   DEL /48 (leaf /96 still covers 32, 40)   rsvd_tbl8s -= 0
+ *   DEL /28 (only level 24 was solely /28's) rsvd_tbl8s -= 0
+ *   DEL /96 (last route gone, all freed)     rsvd_tbl8s -= 9
+ *
+ * Boundaries get refunded only on the DEL that makes them empty;
+ * intermediate DELs that leave a covering descendant are refund-free.
+ */
+static int32_t
+test_drift_multilevel(void)
+{
+	struct rte_fib6_conf config = { 0 };
+	struct rte_fib6 *fib;
+	struct rte_ipv6_addr grand = RTE_IPV6(0xfcde, 0, 0, 0, 0, 0, 0, 0);
+	struct rte_ipv6_addr mid =   RTE_IPV6(0xfcde, 0, 0x6000, 0, 0, 0, 0, 0);
+	struct rte_ipv6_addr leaf =  RTE_IPV6(0xfcde, 0, 0x6000, 0, 0, 0x4000, 0, 0);
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
+	ret = rte_fib6_add(fib, &grand, 28, 1);
+	RTE_TEST_ASSERT(ret == 0, "ADD /28 failed\n");
+	ret = rte_fib6_add(fib, &mid, 48, 1);  /* compressed under /28 */
+	RTE_TEST_ASSERT(ret == 0, "ADD /48 failed\n");
+	ret = rte_fib6_add(fib, &leaf, 96, 2); /* non-compressed under /48 */
+	RTE_TEST_ASSERT(ret == 0, "ADD /96 failed\n");
+
+	/* DEL the middle prefix: byte-boundary accounting must stay
+	 * coherent so the subsequent operations succeed.
+	 */
+	ret = rte_fib6_delete(fib, &mid, 48);
+	RTE_TEST_ASSERT(ret == 0, "DEL /48 failed\n");
+
+	ret = rte_fib6_delete(fib, &grand, 28);
+	RTE_TEST_ASSERT(ret == 0, "DEL /28 failed\n");
+	ret = rte_fib6_delete(fib, &leaf, 96);
+	RTE_TEST_ASSERT(ret == 0, "DEL /96 failed\n");
+
+	rte_fib6_free(fib);
+	return TEST_SUCCESS;
+}
+
+/*
+ * Pseudo-random ADD/DEL sequence over 8 prefixes with varying depths
+ * and next-hops. A hand-rolled LCG (not rte_rand) makes the sequence
+ * reproducible across runs and DPDK versions. After all prefixes are
+ * removed, a final ADD/DEL pair must succeed - it would fail under a
+ * leaked rsvd_tbl8s.
+ *
+ * depths[1] and depths[6] both use /36 on purpose: ips[1] and ips[6]
+ * are distinct prefixes, so this exercises two parallel /36 ADD/DEL
+ * paths that share byte boundaries 24 and 32.
+ */
+static int32_t
+test_drift_stress(void)
+{
+	uint8_t depths[8] = { 28, 36, 40, 48, 64, 80, 36, 128 };
+	struct rte_fib6_conf config = { 0 };
+	struct rte_ipv6_addr ips[8] = {
+		RTE_IPV6(0xfcde, 0, 0, 0, 0, 0, 0, 0),
+		RTE_IPV6(0xfcde, 0x1, 0, 0, 0, 0, 0, 0),
+		RTE_IPV6(0xfcde, 0x2, 0, 0, 0, 0, 0, 0),
+		RTE_IPV6(0xfcde, 0x2, 0x4000, 0, 0, 0, 0, 0),
+		RTE_IPV6(0xfcde, 0x2, 0x4000, 0x1000, 0, 0, 0, 0),
+		RTE_IPV6(0xfcde, 0x2, 0x4000, 0x1000, 0x1, 0, 0, 0),
+		RTE_IPV6(0xfcde, 0x3, 0, 0, 0, 0, 0, 0),
+		RTE_IPV6(0xfcde, 0x3, 0, 0, 0, 0, 0, 0x1),
+	};
+	uint8_t live[8] = { 0 };
+	struct rte_fib6 *fib;
+	uint32_t seed = 0x4242;
+	unsigned int i, idx;
+	int ret;
+
+	config.max_routes = 64;
+	config.rib_ext_sz = 0;
+	config.default_nh = 0;
+	config.type = RTE_FIB6_TRIE;
+	config.trie.nh_sz = RTE_FIB6_TRIE_2B;
+	config.trie.num_tbl8 = 256;
+
+	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
+
+	for (i = 0; i < 2000; i++) {
+		seed = seed * 1103515245u + 12345u;
+		idx = (seed >> 8) & 7;
+		if (live[idx]) {
+			ret = rte_fib6_delete(fib, &ips[idx], depths[idx]);
+			RTE_TEST_ASSERT(ret == 0,
+				"DEL idx %u (depth /%u) failed (ret=%d)\n",
+				idx, depths[idx], ret);
+			live[idx] = 0;
+		} else {
+			uint64_t nh = ((seed >> 16) & 0xff) + 1;
+			ret = rte_fib6_add(fib, &ips[idx], depths[idx], nh);
+			RTE_TEST_ASSERT(ret == 0,
+				"ADD idx %u (depth /%u nh=%" PRIu64 ") failed (ret=%d)\n",
+				idx, depths[idx], nh, ret);
+			live[idx] = 1;
+		}
+	}
+
+	/* Drain everything */
+	for (i = 0; i < RTE_DIM(live); i++) {
+		if (live[i]) {
+			ret = rte_fib6_delete(fib, &ips[i], depths[i]);
+			RTE_TEST_ASSERT(ret == 0,
+				"final drain DEL idx %u failed (ret=%d)\n",
+				i, ret);
+		}
+	}
+
+	/* If rsvd_tbl8s had leaked, this fresh ADD would fail */
+	ret = rte_fib6_add(fib, &ips[0], depths[0], 0xff);
+	RTE_TEST_ASSERT(ret == 0,
+		"post-drain ADD failed (rsvd leaked?) (ret=%d)\n", ret);
+	ret = rte_fib6_delete(fib, &ips[0], depths[0]);
+	RTE_TEST_ASSERT(ret == 0, "post-drain DEL failed\n");
+
+	rte_fib6_free(fib);
+	return TEST_SUCCESS;
+}
+
+/* Tight-pool re-compression scenario. Pool sized to exactly the
+ * highest legitimate envelope: an ADD that becomes a closer ancestor
+ * of an existing descendant must succeed because the byte-boundary
+ * supernet accounting reports the same envelope post-operation.
+ *
+ *   num_tbl8 = 3
+ *   ADD /28 nh=1            rsvd = 1
+ *   ADD /48 nh=1 (compr.)   rsvd = 3 (/48 reserves 2 new boundaries)
+ *   DEL /28                 rsvd unchanged (/48 still holds them)
+ *   RE-ADD /28 nh=1         rsvd unchanged (already reserved)
+ *                           (pre-fix: pre-check rejects)
+ */
+static int32_t
+test_drift_tight_pool(void)
+{
+	struct rte_fib6_conf config = { 0 };
+	struct rte_fib6 *fib;
+	struct rte_ipv6_addr parent = RTE_IPV6(0xfcde, 0, 0, 0, 0, 0, 0, 0);
+	struct rte_ipv6_addr child = RTE_IPV6(0xfcde, 0, 0x6000, 0, 0, 0, 0, 0);
+	int ret;
+
+	config.max_routes = 16;
+	config.rib_ext_sz = 0;
+	config.default_nh = 0;
+	config.type = RTE_FIB6_TRIE;
+	config.trie.nh_sz = RTE_FIB6_TRIE_2B;
+	config.trie.num_tbl8 = 3;
+
+	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
+
+	ret = rte_fib6_add(fib, &parent, 28, 1);
+	RTE_TEST_ASSERT(ret == 0, "ADD /28 failed (ret=%d)\n", ret);
+	ret = rte_fib6_add(fib, &child, 48, 1);
+	RTE_TEST_ASSERT(ret == 0, "ADD /48 failed (ret=%d)\n", ret);
+	ret = rte_fib6_delete(fib, &parent, 28);
+	RTE_TEST_ASSERT(ret == 0, "DEL /28 failed (ret=%d)\n", ret);
+
+	/* Re-add /28: byte boundary 24 is already occupied by the /48,
+	 * so the re-added /28 introduces no new reservation. The
+	 * envelope stays at 3 and still fits the pool of 3.
+	 */
+	ret = rte_fib6_add(fib, &parent, 28, 1);
+	RTE_TEST_ASSERT(ret == 0,
+		"Re-ADD /28 spuriously failed (ret=%d)\n", ret);
+
+	ret = rte_fib6_delete(fib, &child, 48);
+	RTE_TEST_ASSERT(ret == 0, "DEL /48 failed (ret=%d)\n", ret);
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
@@ -685,6 +942,10 @@ static struct unit_test_suite fib6_fast_tests = {
 	TEST_CASE(test_invalid_rcu),
 	TEST_CASE(test_fib_rcu_sync_rw),
 	TEST_CASE(test_drift),
+	TEST_CASE(test_drift_compression),
+	TEST_CASE(test_drift_multilevel),
+	TEST_CASE(test_drift_stress),
+	TEST_CASE(test_drift_tight_pool),
 	TEST_CASES_END()
 	}
 };
-- 
2.43.0

