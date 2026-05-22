Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B35CD5BB0
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 14:59:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A9F640670;
	Fri, 22 May 2026 16:59:08 +0200 (CEST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id AE9BE40670
 for <dev@dpdk.org>; Fri, 22 May 2026 16:59:05 +0200 (CEST)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4904127c32cso7846485e9.2
 for <dev@dpdk.org>; Fri, 22 May 2026 07:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779461945; x=1780066745; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x22wYiqvFa3SfBeBg/z4Ub1I2XL9X/6OTwNdgFFsIPk=;
 b=csYjW04Vfgld+9R1A/57msszNZxtFcarFa6/Uan5vOE9olG3+KxJMiJbfBD3Ck43t2
 YR4VWNUvO5zjiXYG07fmlcLUrOCYc2CIRv+6LHiZr64Xcfe/dpBgshgKSu02nNeRX4Ij
 CcTu3PfrvetikLI9R7ely1M1o/OWlybcm/HPKGFxUaK36udFwhSWejLKm8RF0RJjrVA2
 wAX9JJG/d+V1GPT5hK1CjFan8MLomP6W5EeBVns/55N5yL5ttaxNlHo/H4DreGpJ0GDm
 hNgcyU0sLx1AwFrUZ1o/Lcztc0iGEe1JSPLgySXmJB8lYqSH1K17O+WU46frtnuzhf60
 PxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779461945; x=1780066745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x22wYiqvFa3SfBeBg/z4Ub1I2XL9X/6OTwNdgFFsIPk=;
 b=hvEwiUjAXShnGnD6BGW+l4MN2oi7g3pLEM3yGLrWRsJUbWgPXcB/RtsNTe1SxYCD0X
 MwJdNXFnHxu6UytOMhUhAtP6xAY1ugfkgjQaZnD5tBcK+riCzKKj2HnwhUng5GXDkjnK
 es3AnoNa4f76Q31UfiidLlarsaX8XxbpdBY4zEq3PcCWCnSD1wWkwgoIR73dXHiClpJX
 hJMQGEvtlMAcx3TPkz4Sb9EqPhYPo0xqwIGSYkkErfVc4IvbfwQQtjmHIGQD9DQppnK8
 UQtdyfxAtej80cnxZUHQHga3ZaLxOkRVmlQmAxBAsgeErjoL6QR4sGmfXUTCuYYrOvOi
 NN4A==
X-Gm-Message-State: AOJu0Yw2GICU3yK7JbMYXxZsZEscJDt194MO0dbb4SUVTkNdNkahL4h2
 f7d48SlYvrP6WK/dV35hunRKNguMbZa4IdFoY/qP2ijusRSC4ORkedW/
X-Gm-Gg: Acq92OFiCIdg6eQptEtEuweBiPP385ypLWyVhdK0OXzOb94R2DqBeeAeGIMpRvDx7zY
 L61b1p4ouT6UR/HNxyxvtdqnXlQo5WpPEMmgWZNSZHnzeFuoxjZarN5hGsOXEn4YayuuyKsMwCU
 grf/ZmICbW1zkDLfvp+uYo+/GoYWMKGKSjI+Tbnjwdb6OcYrUglHoY0SSVxAaJ1WlQB1AR122K+
 LZ8041Fe5xf+c1DgNCPHmXR2F637zyViUfaWxwV3+tLVr/oYEkwKOv3xITtB9aT2btHD3zBSrtd
 /h304mQExBKzSHPwieLQLF00LwM6ilSKCyI3dMc8WvyhvGdKszNk3vxyaus5blRTFKNkoH0PNKz
 DlqLOYh5GT7sj+MYurgTiozLfwDmGCiVgt/En1CxXmd4B2Q99bdGStVzs2OUW0CQK4BNtcnjOJa
 LTo4jZbVPmN61cOI1VRAIoqAwYdbX+vNIW4Dq4bn+ZLxC/xplUbfo//se1siYa0ohDQQ==
X-Received: by 2002:a05:600c:8709:b0:48e:635a:18d7 with SMTP id
 5b1f17b1804b1-49042267bd9mr54996575e9.0.1779461945181; 
 Fri, 22 May 2026 07:59:05 -0700 (PDT)
Received: from localhost.localdomain (free-mobile.vlq16.iliad.fr.
 [213.36.7.11]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6c9f6ffsm4669542f8f.1.2026.05.22.07.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 07:59:04 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org,
	stable@dpdk.org,
	Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v1 2/5] test/fib6: add reproducer for tbl8 reservation drift
Date: Fri, 22 May 2026 16:58:51 +0200
Message-ID: <20260522145855.1748406-3-maxime@leroys.fr>
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

test_drift covers the asymmetric ADD parent / ADD children / DEL
parent / DEL children sequence that wraps rsvd_tbl8s past zero in a
single iteration. After the wrap the next /25+ ADD is rejected with
-ENOSPC even though the tbl8 pool is empty. With the preceding fix
in place the final ADD succeeds.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 app/test/test_fib6.c | 74 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/app/test/test_fib6.c b/app/test/test_fib6.c
index fffb590dbf..c4283f3f2d 100644
--- a/app/test/test_fib6.c
+++ b/app/test/test_fib6.c
@@ -25,6 +25,7 @@ static int32_t test_get_invalid(void);
 static int32_t test_lookup(void);
 static int32_t test_invalid_rcu(void);
 static int32_t test_fib_rcu_sync_rw(void);
+static int32_t test_drift(void);
 
 #define MAX_ROUTES	(1 << 16)
 /** Maximum number of tbl8 for 2-byte entries */
@@ -599,6 +600,78 @@ test_fib_rcu_sync_rw(void)
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
+	/* Pre-fix: -ENOSPC. Post-fix: succeeds. */
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
@@ -611,6 +684,7 @@ static struct unit_test_suite fib6_fast_tests = {
 	TEST_CASE(test_lookup),
 	TEST_CASE(test_invalid_rcu),
 	TEST_CASE(test_fib_rcu_sync_rw),
+	TEST_CASE(test_drift),
 	TEST_CASES_END()
 	}
 };
-- 
2.43.0

