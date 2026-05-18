Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1998CD4F50
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 13:27:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCCAF4064F;
	Mon, 18 May 2026 15:27:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8144F402B8
 for <dev@dpdk.org>; Mon, 18 May 2026 15:27:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779110860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FIeKl1KjuTgLqoFmTErp2CMnPx1e6Oi0mTrtUH/fWZA=;
 b=cfrb5lP+aq+qI8rosiIHk6pALDge45yYr3Iym3taQOYMaKAIK0N7wNch+17heU2L5SLvhc
 i10zjcczTtZo8ZU9YoJAI4ezCCWM1pY0+s9fAiHHaZMQF+TPGfpesPwh/cJT52YTG6snQa
 XfvNb05JLbuJQKOZD0P13+0Z3IEM/hY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226-hCqHPpebNaqxBwV83Z2p3g-1; Mon,
 18 May 2026 09:27:38 -0400
X-MC-Unique: hCqHPpebNaqxBwV83Z2p3g-1
X-Mimecast-MFC-AGG-ID: hCqHPpebNaqxBwV83Z2p3g_1779110857
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 901761956046
 for <dev@dpdk.org>; Mon, 18 May 2026 13:27:37 +0000 (UTC)
Received: from ringo.home (unknown [10.44.34.65])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9E55C19560A2; Mon, 18 May 2026 13:27:36 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org
Subject: [PATCH dpdk v5 3/5] net: add unit tests for rte_net_get_ptype
Date: Mon, 18 May 2026 15:27:17 +0200
Message-ID: <20260518132712.70913-11-rjarry@redhat.com>
In-Reply-To: <20260518132712.70913-8-rjarry@redhat.com>
References: <20260422102814.645299-2-rjarry@redhat.com>
 <20260518132712.70913-8-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6M1t3YSfHzHaUttgnHdN5PsaFLlXeM4OMNctCAzwBBc_1779110857
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

There is no test coverage for rte_net_get_ptype. Add a test suite that
exercises plain Ethernet, single VLAN, QinQ, double VLAN, IPv4 with
options, IPv6, TCP and UDP combinations.

Signed-off-by: Robin Jarry <rjarry@redhat.com>
---
 app/test/meson.build      |   1 +
 app/test/test_net_ptype.c | 231 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 232 insertions(+)
 create mode 100644 app/test/test_net_ptype.c

diff --git a/app/test/meson.build b/app/test/meson.build
index 7d458f9c079a..9f4afb040a46 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -135,6 +135,7 @@ source_file_deps = {
     'test_mp_secondary.c': ['hash'],
     'test_net_ether.c': ['net'],
     'test_net_ip6.c': ['net'],
+    'test_net_ptype.c': ['net'],
     'test_pcapng.c': ['net_null', 'net', 'ethdev', 'pcapng', 'bus_vdev'],
     'test_pdcp.c': ['eventdev', 'pdcp', 'net', 'timer', 'security'],
     'test_pdump.c': ['pdump'] + sample_packet_forward_deps,
diff --git a/app/test/test_net_ptype.c b/app/test/test_net_ptype.c
new file mode 100644
index 000000000000..bfe85da13543
--- /dev/null
+++ b/app/test/test_net_ptype.c
@@ -0,0 +1,231 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2026 Red Hat, Inc.
+ */
+
+#include <stdint.h>
+#include <string.h>
+
+#include <rte_mbuf.h>
+#include <rte_net.h>
+
+#include <rte_test.h>
+#include "test.h"
+
+#define MEMPOOL_CACHE_SIZE 0
+#define MBUF_DATA_SIZE 256
+#define NB_MBUF 128
+
+/* Ether()/IP()/UDP()/Raw('x') */
+static const uint8_t pkt_ether_ipv4_udp[] = {
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x45, 0x00,
+	0x00, 0x1d, 0x00, 0x01, 0x00, 0x00, 0x40, 0x11,
+	0x7c, 0xcd, 0x7f, 0x00, 0x00, 0x01, 0x7f, 0x00,
+	0x00, 0x01, 0x00, 0x35, 0x00, 0x35, 0x00, 0x09,
+	0x89, 0x6f, 0x78,
+};
+
+/* Ether()/IP()/TCP() */
+static const uint8_t pkt_ether_ipv4_tcp[] = {
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x45, 0x00,
+	0x00, 0x28, 0x00, 0x01, 0x00, 0x00, 0x40, 0x06,
+	0x7c, 0xcd, 0x7f, 0x00, 0x00, 0x01, 0x7f, 0x00,
+	0x00, 0x01, 0x00, 0x14, 0x00, 0x50, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x50, 0x02,
+	0x20, 0x00, 0x91, 0x7c, 0x00, 0x00,
+};
+
+/* Ether()/IPv6()/UDP()/Raw('x') */
+static const uint8_t pkt_ether_ipv6_udp[] = {
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x86, 0xdd, 0x60, 0x00,
+	0x00, 0x00, 0x00, 0x09, 0x11, 0x40, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x35,
+	0x00, 0x35, 0x00, 0x09, 0x87, 0x70, 0x78,
+};
+
+/* Ether()/IPv6()/TCP() */
+static const uint8_t pkt_ether_ipv6_tcp[] = {
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x86, 0xdd, 0x60, 0x00,
+	0x00, 0x00, 0x00, 0x14, 0x06, 0x40, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x14,
+	0x00, 0x50, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x50, 0x02, 0x20, 0x00, 0x8f, 0x7d,
+	0x00, 0x00,
+};
+
+/* Ether()/IP(options='\x00')/UDP()/Raw('x') -- ihl=6 */
+static const uint8_t pkt_ether_ipv4_opts_udp[] = {
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x46, 0x00,
+	0x00, 0x21, 0x00, 0x01, 0x00, 0x00, 0x40, 0x11,
+	0x7b, 0xc9, 0x7f, 0x00, 0x00, 0x01, 0x7f, 0x00,
+	0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x35,
+	0x00, 0x35, 0x00, 0x09, 0x89, 0x6f, 0x78,
+};
+
+/* Ether()/Dot1Q(vlan=42)/IP()/UDP()/Raw('x') */
+static const uint8_t pkt_vlan_ipv4_udp[] = {
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x81, 0x00, 0x00, 0x2a,
+	0x08, 0x00, 0x45, 0x00, 0x00, 0x1d, 0x00, 0x01,
+	0x00, 0x00, 0x40, 0x11, 0x7c, 0xcd, 0x7f, 0x00,
+	0x00, 0x01, 0x7f, 0x00, 0x00, 0x01, 0x00, 0x35,
+	0x00, 0x35, 0x00, 0x09, 0x89, 0x6f, 0x78,
+};
+
+/* Ether()/Dot1Q(vlan=42)/IPv6()/TCP() */
+static const uint8_t pkt_vlan_ipv6_tcp[] = {
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x81, 0x00, 0x00, 0x2a,
+	0x86, 0xdd, 0x60, 0x00, 0x00, 0x00, 0x00, 0x14,
+	0x06, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x01, 0x00, 0x14, 0x00, 0x50, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x50, 0x02,
+	0x20, 0x00, 0x8f, 0x7d, 0x00, 0x00,
+};
+
+/* Ether()/Dot1AD(vlan=42)/Dot1Q(vlan=43)/IP()/UDP()/Raw('x') */
+static const uint8_t pkt_qinq_ipv4_udp[] = {
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x88, 0xa8, 0x00, 0x2a,
+	0x81, 0x00, 0x00, 0x2b, 0x08, 0x00, 0x45, 0x00,
+	0x00, 0x1d, 0x00, 0x01, 0x00, 0x00, 0x40, 0x11,
+	0x7c, 0xcd, 0x7f, 0x00, 0x00, 0x01, 0x7f, 0x00,
+	0x00, 0x01, 0x00, 0x35, 0x00, 0x35, 0x00, 0x09,
+	0x89, 0x6f, 0x78,
+};
+
+/* Ether()/Dot1Q(vlan=42)/Dot1Q(vlan=43)/IP()/UDP()/Raw('x') */
+static const uint8_t pkt_vlan_vlan_ipv4_udp[] = {
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x81, 0x00, 0x00, 0x2a,
+	0x81, 0x00, 0x00, 0x2b, 0x08, 0x00, 0x45, 0x00,
+	0x00, 0x1d, 0x00, 0x01, 0x00, 0x00, 0x40, 0x11,
+	0x7c, 0xcd, 0x7f, 0x00, 0x00, 0x01, 0x7f, 0x00,
+	0x00, 0x01, 0x00, 0x35, 0x00, 0x35, 0x00, 0x09,
+	0x89, 0x6f, 0x78,
+};
+
+/* Ether()/Dot1AD(vlan=42)/Dot1Q(vlan=43)/IPv6()/TCP() */
+static const uint8_t pkt_qinq_ipv6_tcp[] = {
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x88, 0xa8, 0x00, 0x2a,
+	0x81, 0x00, 0x00, 0x2b, 0x86, 0xdd, 0x60, 0x00,
+	0x00, 0x00, 0x00, 0x14, 0x06, 0x40, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x14,
+	0x00, 0x50, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x50, 0x02, 0x20, 0x00, 0x8f, 0x7d,
+	0x00, 0x00,
+};
+
+static int
+test_get_ptype(struct rte_mempool *pool, const char *name,
+	       const uint8_t *pktdata, size_t len, uint32_t expected_ptype,
+	       uint8_t expected_l2_len, uint16_t expected_l3_len,
+	       uint8_t expected_l4_len)
+{
+	struct rte_net_hdr_lens hdr_lens;
+	struct rte_mbuf *m;
+	uint32_t ptype;
+	char *data;
+
+	RTE_LOG(INFO, EAL, "%s: %s\n", __func__, name);
+
+	m = rte_pktmbuf_alloc(pool);
+	RTE_TEST_ASSERT_NOT_NULL(m, "cannot allocate mbuf");
+
+	data = rte_pktmbuf_append(m, len);
+	if (data == NULL) {
+		rte_pktmbuf_free(m);
+		RTE_TEST_ASSERT_NOT_NULL(data, "cannot append data");
+	}
+
+	memcpy(data, pktdata, len);
+
+	memset(&hdr_lens, 0, sizeof(hdr_lens));
+	ptype = rte_net_get_ptype(m, &hdr_lens, RTE_PTYPE_ALL_MASK);
+
+	rte_pktmbuf_free(m);
+
+	RTE_TEST_ASSERT_EQUAL(ptype, expected_ptype,
+		"unexpected ptype: got 0x%x, expected 0x%x",
+		ptype, expected_ptype);
+	RTE_TEST_ASSERT_EQUAL(hdr_lens.l2_len, expected_l2_len,
+		"unexpected l2_len: got %u, expected %u",
+		hdr_lens.l2_len, expected_l2_len);
+	RTE_TEST_ASSERT_EQUAL(hdr_lens.l3_len, expected_l3_len,
+		"unexpected l3_len: got %u, expected %u",
+		hdr_lens.l3_len, expected_l3_len);
+	RTE_TEST_ASSERT_EQUAL(hdr_lens.l4_len, expected_l4_len,
+		"unexpected l4_len: got %u, expected %u",
+		hdr_lens.l4_len, expected_l4_len);
+
+	return 0;
+}
+
+#define test_case(pool, pkt, expected_ptype, l2, l3, l4) \
+	test_get_ptype(pool, #pkt, pkt, sizeof(pkt), expected_ptype, l2, l3, l4)
+
+static int
+test_net_ptype(void)
+{
+	struct rte_mempool *pool;
+	int ret = 0;
+
+	pool = rte_pktmbuf_pool_create("test_ptype_mbuf_pool",
+			NB_MBUF, MEMPOOL_CACHE_SIZE, 0, MBUF_DATA_SIZE,
+			SOCKET_ID_ANY);
+	RTE_TEST_ASSERT_NOT_NULL(pool, "cannot allocate mbuf pool");
+
+	ret |= test_case(pool, pkt_ether_ipv4_udp,
+			 RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV4 | RTE_PTYPE_L4_UDP,
+			 14, 20, 8);
+	ret |= test_case(pool, pkt_ether_ipv4_tcp,
+			 RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV4 | RTE_PTYPE_L4_TCP,
+			 14, 20, 20);
+	ret |= test_case(pool, pkt_ether_ipv6_udp,
+			 RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV6 | RTE_PTYPE_L4_UDP,
+			 14, 40, 8);
+	ret |= test_case(pool, pkt_ether_ipv6_tcp,
+			 RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV6 | RTE_PTYPE_L4_TCP,
+			 14, 40, 20);
+	ret |= test_case(pool, pkt_ether_ipv4_opts_udp,
+			 RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV4_EXT | RTE_PTYPE_L4_UDP,
+			 14, 24, 8);
+	ret |= test_case(pool, pkt_vlan_ipv4_udp,
+			 RTE_PTYPE_L2_ETHER_VLAN | RTE_PTYPE_L3_IPV4 | RTE_PTYPE_L4_UDP,
+			 18, 20, 8);
+	ret |= test_case(pool, pkt_vlan_ipv6_tcp,
+			 RTE_PTYPE_L2_ETHER_VLAN | RTE_PTYPE_L3_IPV6 | RTE_PTYPE_L4_TCP,
+			 18, 40, 20);
+	ret |= test_case(pool, pkt_qinq_ipv4_udp,
+			 RTE_PTYPE_L2_ETHER_QINQ | RTE_PTYPE_L3_IPV4 | RTE_PTYPE_L4_UDP,
+			 22, 20, 8);
+	ret |= test_case(pool, pkt_vlan_vlan_ipv4_udp,
+			 RTE_PTYPE_L2_ETHER_VLAN | RTE_PTYPE_L3_IPV4 | RTE_PTYPE_L4_UDP,
+			 22, 20, 8);
+	ret |= test_case(pool, pkt_qinq_ipv6_tcp,
+			 RTE_PTYPE_L2_ETHER_QINQ | RTE_PTYPE_L3_IPV6 | RTE_PTYPE_L4_TCP,
+			 22, 40, 20);
+
+	rte_mempool_free(pool);
+
+	return ret;
+}
+
+REGISTER_FAST_TEST(net_ptype_autotest, NOHUGE_OK, ASAN_OK, test_net_ptype);
-- 
2.54.0

