Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D53BC5DF97
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 17:39:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFE0C40268;
	Wed, 26 Aug 2026 19:39:16 +0200 (CEST)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by mails.dpdk.org (Postfix) with ESMTP id E6A2740268
 for <dev@dpdk.org>; Wed, 26 Aug 2026 19:39:14 +0200 (CEST)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-9309d4ea213so97457685a.1
 for <dev@dpdk.org>; Wed, 26 Aug 2026 10:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787765954; x=1788370754; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ajECc/JPVvbTKraIzDjglDv+0FZsvzPu/SNjVMVFEk0=;
 b=A3e4KSKQqKR8Mk2EWHO2LBr363fmmA6RLTquqD9aSy5i0BK7qhLDOFkDv5GKVSouS+
 g1wkZPoHmYMBDHtgU/14NYhN6XW8xgKizPA6mpStYQNNSSETdcKKXtgCCIBro62GR+Fx
 a/SNj+r1xHAveCmUCmBAlanhxL2NBF2xVQvlZvzTXmHSeVzW+TfVJgPmSRJERXkPHNTQ
 +dc9KJPxE+N06ozv4FxI2LTZoSr0X71FlzPTzRlyKFZFJDoXgQYariCZpVauwZFWr5Z1
 cW66ZolwDEh5IdxYsRf1Wl9W+G9py0RERhyhxFUoc0AgIgCD3vDzQeHLS3f+C11Uz7Ki
 xa1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787765954; x=1788370754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ajECc/JPVvbTKraIzDjglDv+0FZsvzPu/SNjVMVFEk0=;
 b=opgdSJmfQMPikqw1yoJKv8FWsMEEC/x/1D5MWTWC3NhVWkfac+9kFhQ6qBgSY/S9Tc
 Aiw2alqRIAH/KaiIpfBZixIQNMM6t9AC8wJBJD5dRbhDMKpgkRzXc9lOBOunXygc4+xU
 fjzqgKg2krCzntlVSvPGUzCFKEHJMFv+4OxLgZGfRQ0r4JIvfkJiI14x3SPazFBbex6f
 SY88lMscZU5WDABds+5rr3xZZxqblhgwc6Tjd8KuunSSZqwhFzOCQXN2Xi00h5AYRivO
 1/kBSdnhuJ+KE21hawwSyrbcS5KyKZXjFqOZFFYNDvSwgUdD9V2Jvw6ZdcereznykLpw
 N3bg==
X-Gm-Message-State: AFuF++mXDmbN0L155dOMNfkjjm864pP3c/gHWX7hKddrZG8XFSFfTofj
 MC9xEib90K6EXPWk3yLGQJShHDFJNTBeUwQuYj6tghdcqqIj9YDr2r4XcAp7aUZt
X-Gm-Gg: AR+sD102G0Ay47zXo26OObNRFvcX1dEHdJE5b+Qq1RFy/dzTxSsOi8RFq8+tG32xgnO
 qFRieA0nAuGRxjtjVg3FwPBU9FKSko78bcRvTkuGU2aVlB3flf9XXmFgi6Hun3TDIs4K78y8l2y
 yYLB2vytOvWeWMp9Gd6gZowjBAsY4MS7iimM5ryDI8he8iufjn8j9sQFjNRV10kFD3BRirt5IKD
 irQPfV7hWL236jOY/CixP4zsNeOe/UU4xTii3wFeuMP+T+KiwTZIbvOeHhdgLftqDI5w/2j06Zr
 AUbkPUM5U+Ghb+7SmSDLz4iougvHUZs/fY1ks7kMRk4VYVuJ6Z49qsYy2jNEx7/z3klg0bOW5xV
 1pWXvrsObEOXifMNZ8QAkhpnhxec9mBSLfyfVEF0yl8hJ3SZTCKJpky2PmT4kWWnBqItpjPi9XF
 bWnQmdhOIsTl+CPQ500M95nSYoYUUK9D8ugRxrEQluWu91gUxiscmLaVL0xpYsaw==
X-Received: by 2002:a05:620a:3720:b0:934:946d:599d with SMTP id
 af79cd13be357-93780443607mr794995585a.33.1787765954092; 
 Wed, 26 Aug 2026 10:39:14 -0700 (PDT)
Received: from wpc.example.org ([67.221.51.185])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9377e616605sm263115585a.29.2026.08.26.10.39.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 10:39:13 -0700 (PDT)
From: William Bland <blandwwa@gmail.com>
To: 
Cc: dev@dpdk.org,
	William Bland <blandwwa@gmail.com>
Subject: [PATCH v2 3/4] net: add VLAN insert function with a TPID argument
Date: Wed, 26 Aug 2026 13:38:40 -0400
Message-ID: <20260826173842.1298754-3-blandwwa@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826173842.1298754-1-blandwwa@gmail.com>
References: <20260826173842.1298754-1-blandwwa@gmail.com>
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

rte_vlan_insert() hardcodes EtherType 0x8100 (802.1Q). This is wrong
when reinserting a stripped tag whose original TPID was 0x88a8 (802.1ad
QinQ).

Add rte_vlan_insert_tpid() which takes an explicit tpid parameter, and
rewrite rte_vlan_insert() as a wrapper that passes RTE_ETHER_TYPE_VLAN.

Signed-off-by: William Bland <blandwwa@gmail.com>
---
 app/test/meson.build                   |   2 +-
 app/test/test_net_ether.c              | 149 +++++++++++++++++++++++--
 doc/guides/rel_notes/release_26_11.rst |   7 ++
 lib/net/rte_ether.h                    |  61 +++++++---
 4 files changed, 193 insertions(+), 26 deletions(-)

diff --git a/app/test/meson.build b/app/test/meson.build
index 51abeeb732..e927d4306a 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -134,7 +134,7 @@ source_file_deps = {
     'test_meter.c': ['meter'],
     'test_metrics.c': ['metrics'],
     'test_mp_secondary.c': ['hash'],
-    'test_net_ether.c': ['net'],
+    'test_net_ether.c': ['net', 'mbuf'],
     'test_net_ip6.c': ['net'],
     'test_pcapng.c': ['net_null', 'net', 'ethdev', 'pcapng', 'bus_vdev'],
     'test_pdcp.c': ['eventdev', 'pdcp', 'net', 'timer', 'security'],
diff --git a/app/test/test_net_ether.c b/app/test/test_net_ether.c
index ec11224171..a1ead2eba8 100644
--- a/app/test/test_net_ether.c
+++ b/app/test/test_net_ether.c
@@ -3,6 +3,8 @@
  */
 
 #include <rte_ether.h>
+#include <rte_mbuf.h>
+#include <rte_mempool.h>
 
 #include <rte_test.h>
 #include "test.h"
@@ -14,6 +16,8 @@ static const struct rte_ether_addr bcast_ea = {
 	.addr_bytes = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff },
 };
 
+static struct rte_mempool *net_ether_test_pool;
+
 static int
 test_ether_addr(void)
 {
@@ -144,22 +148,147 @@ test_invalid_addr(void)
 	return 0;
 }
 
+/*
+ * Build a minimal Ethernet frame in an mbuf: Ethernet header with the given
+ * ether_type followed by payload_len bytes of padding.
+ */
+static struct rte_mbuf *
+alloc_frame(struct rte_mempool *mp, uint16_t ether_type, uint16_t payload_len)
+{
+	struct rte_ether_hdr *eh;
+	struct rte_mbuf *m;
+
+	m = rte_pktmbuf_alloc(mp);
+	if (m == NULL)
+		return NULL;
+
+	eh = (struct rte_ether_hdr *)rte_pktmbuf_append(m,
+			sizeof(*eh) + payload_len);
+	if (eh == NULL) {
+		rte_pktmbuf_free(m);
+		return NULL;
+	}
+
+	memset(eh->dst_addr.addr_bytes, 0xff, RTE_ETHER_ADDR_LEN);
+	memset(eh->src_addr.addr_bytes, 0x00, RTE_ETHER_ADDR_LEN);
+	eh->ether_type = rte_cpu_to_be_16(ether_type);
+
+	return m;
+}
+
 static int
-test_net_ether(void)
+test_vlan_insert_8021q(void)
 {
-	if (test_ether_addr())
-		return -1;
+	struct rte_ether_hdr *eh;
+	struct rte_vlan_hdr *vh;
+	struct rte_mbuf *m;
+	int ret;
 
-	if (test_format_addr())
-		return -1;
+	m = alloc_frame(net_ether_test_pool, RTE_ETHER_TYPE_IPV4, 46);
+	TEST_ASSERT_NOT_NULL(m, "Failed to allocate mbuf");
 
-	if (test_unformat_addr())
-		return -1;
+	m->vlan_tci = 100;
+	m->ol_flags |= RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED;
 
-	if (test_invalid_addr())
-		return -1;
+	ret = rte_vlan_insert(&m);
+	TEST_ASSERT_SUCCESS(ret, "rte_vlan_insert failed");
 
-	return 0;
+	eh = rte_pktmbuf_mtod(m, struct rte_ether_hdr *);
+	TEST_ASSERT_EQUAL(rte_be_to_cpu_16(eh->ether_type), RTE_ETHER_TYPE_VLAN,
+		"Expected 802.1Q TPID 0x%04x, got 0x%04x",
+		RTE_ETHER_TYPE_VLAN, rte_be_to_cpu_16(eh->ether_type));
+
+	vh = (struct rte_vlan_hdr *)(eh + 1);
+	TEST_ASSERT_EQUAL(rte_be_to_cpu_16(vh->vlan_tci), 100,
+		"Expected VID 100, got %u", rte_be_to_cpu_16(vh->vlan_tci));
+
+	rte_pktmbuf_free(m);
+	return TEST_SUCCESS;
+}
+
+static int
+test_vlan_insert_tpid(void)
+{
+	struct rte_ether_hdr *eh;
+	struct rte_vlan_hdr *vh;
+	struct rte_mbuf *m;
+	int ret;
+
+	m = alloc_frame(net_ether_test_pool, RTE_ETHER_TYPE_VLAN, sizeof(*vh) + 46);
+	TEST_ASSERT_NOT_NULL(m, "Failed to allocate mbuf");
+
+	vh = (struct rte_vlan_hdr *)(rte_pktmbuf_mtod(m, struct rte_ether_hdr *) + 1);
+	vh->vlan_tci = rte_cpu_to_be_16(200);
+	vh->eth_proto = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4);
+
+	m->vlan_tci = 50;
+	m->ol_flags |= RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED;
+
+	ret = rte_vlan_insert_tpid(&m, RTE_ETHER_TYPE_QINQ);
+	TEST_ASSERT_SUCCESS(ret, "rte_vlan_insert_tpid failed");
+
+	eh = rte_pktmbuf_mtod(m, struct rte_ether_hdr *);
+
+	TEST_ASSERT_EQUAL(rte_be_to_cpu_16(eh->ether_type), RTE_ETHER_TYPE_QINQ,
+		"Outer TPID: expected 0x%04x (802.1ad) got 0x%04x",
+		RTE_ETHER_TYPE_QINQ, rte_be_to_cpu_16(eh->ether_type));
+
+	vh = (struct rte_vlan_hdr *)(eh + 1);
+	TEST_ASSERT_EQUAL(rte_be_to_cpu_16(vh->vlan_tci), 50,
+		"Outer VID: expected 50, got %u",
+		rte_be_to_cpu_16(vh->vlan_tci));
+	TEST_ASSERT_EQUAL(rte_be_to_cpu_16(vh->eth_proto), RTE_ETHER_TYPE_VLAN,
+		"Outer eth_proto: expected 0x%04x (802.1Q), got 0x%04x",
+		RTE_ETHER_TYPE_VLAN, rte_be_to_cpu_16(vh->eth_proto));
+
+	vh = vh + 1;
+	TEST_ASSERT_EQUAL(rte_be_to_cpu_16(vh->vlan_tci), 200,
+		"Inner VID: expected 200, got %u",
+		rte_be_to_cpu_16(vh->vlan_tci));
+	TEST_ASSERT_EQUAL(rte_be_to_cpu_16(vh->eth_proto), RTE_ETHER_TYPE_IPV4,
+		"Inner eth_proto: expected 0x%04x (IPv4), got 0x%04x",
+		RTE_ETHER_TYPE_IPV4, rte_be_to_cpu_16(vh->eth_proto));
+
+	rte_pktmbuf_free(m);
+	return TEST_SUCCESS;
+}
+
+static int
+net_ether_testsuite_setup(void)
+{
+	net_ether_test_pool = rte_pktmbuf_pool_create("net_ether_test_pool", 64, 0, 0,
+			RTE_MBUF_DEFAULT_BUF_SIZE, SOCKET_ID_ANY);
+	TEST_ASSERT_NOT_NULL(net_ether_test_pool, "Failed to create mempool");
+
+	return TEST_SUCCESS;
+}
+
+static void
+net_ether_testsuite_teardown(void)
+{
+	rte_mempool_free(net_ether_test_pool);
+	net_ether_test_pool = NULL;
+}
+
+static struct unit_test_suite net_ether_testsuite = {
+	.suite_name = "net_ether autotest",
+	.setup = net_ether_testsuite_setup,
+	.teardown = net_ether_testsuite_teardown,
+	.unit_test_cases = {
+		TEST_CASE(test_ether_addr),
+		TEST_CASE(test_format_addr),
+		TEST_CASE(test_unformat_addr),
+		TEST_CASE(test_invalid_addr),
+		TEST_CASE(test_vlan_insert_8021q),
+		TEST_CASE(test_vlan_insert_tpid),
+		TEST_CASES_END()
+	}
+};
+
+static int
+test_net_ether(void)
+{
+	return unit_test_suite_runner(&net_ether_testsuite);
 }
 
 REGISTER_FAST_TEST(net_ether_autotest, NOHUGE_OK, ASAN_OK, test_net_ether);
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c8cc86295d..a7481b51ff 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -55,6 +55,13 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Added TPID support to VLAN tag insertion.**
+
+  Added ``rte_vlan_insert_tpid()`` to the net library, allowing the Tag
+  Protocol Identifier (TPID) of an inserted VLAN tag to be specified
+  explicitly, so that 802.1ad (QinQ) outer tags can be reinserted with
+  the correct EtherType.
+
 
 Removed Items
 -------------
diff --git a/lib/net/rte_ether.h b/lib/net/rte_ether.h
index cb10d8fb06..23c4806cc5 100644
--- a/lib/net/rte_ether.h
+++ b/lib/net/rte_ether.h
@@ -378,20 +378,7 @@ static inline int rte_vlan_strip(struct rte_mbuf *m)
 	return 0;
 }
 
-/**
- * Insert VLAN tag into mbuf.
- *
- * Software version of VLAN unstripping
- *
- * @param m
- *   The packet mbuf.
- * @return
- *   - 0: On success
- *   -EINVAL: overwriting would be unsafe because mbuf is shared or
- *            indirect, or mbuf's first segment is too short
- *   -ENOSPC: not enough headroom in mbuf
- */
-static inline int rte_vlan_insert(struct rte_mbuf **m)
+static inline int __rte_vlan_insert(struct rte_mbuf **m, uint16_t tpid)
 {
 	struct rte_ether_hdr *oh, *nh;
 	struct rte_vlan_hdr *vh;
@@ -411,7 +398,7 @@ static inline int rte_vlan_insert(struct rte_mbuf **m)
 		return -ENOSPC;
 
 	memmove(nh, oh, 2 * RTE_ETHER_ADDR_LEN);
-	nh->ether_type = rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN);
+	nh->ether_type = rte_cpu_to_be_16(tpid);
 
 	vh = (struct rte_vlan_hdr *) (nh + 1);
 	vh->vlan_tci = rte_cpu_to_be_16((*m)->vlan_tci);
@@ -426,6 +413,50 @@ static inline int rte_vlan_insert(struct rte_mbuf **m)
 	return 0;
 }
 
+/**
+ * Insert VLAN tag into mbuf.
+ *
+ * Software version of VLAN unstripping. Always inserts an 802.1Q tag
+ * (TPID 0x8100). Use rte_vlan_insert_tpid() when the original TPID may
+ * differ (e.g. 802.1ad QinQ outer tags).
+ *
+ * @param m
+ *   The packet mbuf.
+ * @return
+ *   - 0: On success
+ *   -EINVAL: overwriting would be unsafe because mbuf is shared or
+ *            indirect, or mbuf's first segment is too short
+ *   -ENOSPC: not enough headroom in mbuf
+ */
+static inline int rte_vlan_insert(struct rte_mbuf **m)
+{
+	return __rte_vlan_insert(m, RTE_ETHER_TYPE_VLAN);
+}
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Insert VLAN tag with the given TPID into mbuf.
+ *
+ * Software version of VLAN unstripping.
+ *
+ * @param m
+ *   The packet mbuf.
+ * @param tpid
+ *   Tag Protocol Identifier to insert (host order).
+ * @return
+ *   - 0: On success
+ *   -EINVAL: overwriting would be unsafe because mbuf is shared or
+ *            indirect, or mbuf's first segment is too short
+ *   -ENOSPC: not enough headroom in mbuf
+ */
+__rte_experimental
+static inline int rte_vlan_insert_tpid(struct rte_mbuf **m, uint16_t tpid)
+{
+	return __rte_vlan_insert(m, tpid);
+}
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.43.0

