Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96284CD98E2
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 08:24:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6576840B95;
	Wed, 17 Jun 2026 10:24:16 +0200 (CEST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id A152140A75
 for <dev@dpdk.org>; Wed, 17 Jun 2026 10:24:14 +0200 (CEST)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-491b390f9e9so46370715e9.0
 for <dev@dpdk.org>; Wed, 17 Jun 2026 01:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781684654; x=1782289454; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x22wYiqvFa3SfBeBg/z4Ub1I2XL9X/6OTwNdgFFsIPk=;
 b=BePG8wggr+fL/kTrRjQudcbC+zWW6BQRv/qgGXmlbP7m9dz866SF55RNDjEr7IJTSH
 SvgMkUHXLRFZEHSpzcyLA+/OwnGsm7D6mYEY1ZSJnE7v8o56aSuyEB2A7abpJjcjb1Kp
 Sw/V5XU+4bEtZgFy6YNQVTHOuWj1KNIobA03cSKJuxUbrtXemukDd+GN2R/GDsD7Cj9Z
 ARBCq98GUszRQ7ZeBdrFZJJyTiKe+0OFr62X8NY6QG3pmodHbBVJ2+Y1BX/3mvNDSqtM
 8AJAP9azF8Jg5uITmNgmt3XpfZvRxKS4qZrgh6ffUrqp2d7oT7c93DeOerrpHQONn9SO
 63ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781684654; x=1782289454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x22wYiqvFa3SfBeBg/z4Ub1I2XL9X/6OTwNdgFFsIPk=;
 b=gNFUeWvg4Aue0LjeyseQ+eD/cZtfobcGUldqEte5I7ye9Qi5XMiE7wC4/GGMIgA3iW
 C5CA8UFit6JjIOmNOhYtFDDDlRoTtKYQhwpI4gFq0FXOyOL5rIHT+QhHNj8LjnsoUvqJ
 tvQ51y1y7dUhW5AoFT8iH/aAI6nRBeoDwWsYStrBZQUsI/QPFShx8us2z6sZ1lVk2S/H
 RaqDV4kd9gockB9f6fpYr0K/AdPvQltSlUq9h9QA95vAsISC8XX8lv1FsDaNW23lcU5a
 CWAo14BH//c9Xj1VVc6fSpM9+ZgYcLBmeTjuIvMt7IeZ4WzlKsmaMBkPh7xzKgDQHE9N
 JOug==
X-Gm-Message-State: AOJu0YxUi+MorvhPB7cbTzGdW3YxMknfFfY4YGminoUT6dRDHjEJz2to
 D+yGC+MLQu898KUwSNU6+lB4SUcv3Kt4ycQwpAGjCnnMfEm+ihHRxBXv
X-Gm-Gg: Acq92OG6Tj5Q4lAPbZqlJllIFj1KhuZLKjnZw13BHdMOvEBWbySeJVX1nHe2duAceKr
 lnBBqbX1e51rRKsjKX6ltNjKLtVBqtH2Wte82rib1ZYLMp3gVChseYIm77LxmjsIAPYnVYCC/g4
 RRYxPQ1kEnQnf8AGnkiXZIqkzUTqC7D6yscVC1dcWjqqot0ovvkGodBGCstJcqhTfB8keubyGSa
 5srZ2vlEftb0TEVCYxoxL9v+zIwPXkdV1F1vJzmplKXncWo7OPYMCueMeDoidZWawqplqeGuQDa
 rzdFLdWlcHedJvl+ZYBxLAp7Lra0lcDeT19aD5T79lHP2GHOcmwXlyKqK9g0Xs8zcAnNgZi4/y1
 EJ1oIQfsjLtFnYpP/yiD7hdn7krwA64kSOS0EM5qLVJSTaLtOfBV2hQKAdYXnxLNFvwQlu2dP1a
 3IjnYTuhvetF960Zqm7/oyhnJnFezAaHSPBaoNXZJaVGiH
X-Received: by 2002:a05:600c:a148:b0:492:329c:3d39 with SMTP id
 5b1f17b1804b1-492333ca336mr34755615e9.20.1781684654119; 
 Wed, 17 Jun 2026 01:24:14 -0700 (PDT)
Received: from localhost.localdomain (free-mobile.vlq16.iliad.fr.
 [213.36.7.11]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa97227sm148007435e9.13.2026.06.17.01.24.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 01:24:13 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org,
	Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v2 2/3] test/fib6: add reproducer for tbl8 reservation drift
Date: Wed, 17 Jun 2026 10:23:59 +0200
Message-ID: <20260617082400.142129-3-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260617082400.142129-1-maxime@leroys.fr>
References: <20260522145855.1748406-1-maxime@leroys.fr>
 <20260617082400.142129-1-maxime@leroys.fr>
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

