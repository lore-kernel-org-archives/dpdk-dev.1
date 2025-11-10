Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E39CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 16:24:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F2D07402B2;
	Mon, 10 Nov 2025 17:24:07 +0100 (CET)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mails.dpdk.org (Postfix) with ESMTP id 2D9E540280
 for <dev@dpdk.org>; Mon, 10 Nov 2025 17:24:06 +0100 (CET)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-7a59ec9bef4so3545949b3a.2
 for <dev@dpdk.org>; Mon, 10 Nov 2025 08:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762791844; x=1763396644; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ug7t0U3i3vWLoKrkf+0DLtQFn79nepjSfJmMaM3NGnI=;
 b=CacuvoE84l1crSkYefnivuqIaw/cisQZzudSc241BUzw3SWvKySP+kKZ1LqeL5qNbk
 tbMiwmIP16lBJsb+MuYUbFu57owCml8J1Q55bWAfQ8hJRwbo24uN80b+wraUNeHuKini
 91rtPcJ/2SEML5rYQoLKpYE8LxYPqkavMSbCHnp9ASXSkitWTziK1yZ5JPxj/NEPz0PH
 n8mLUr/9C2yG/4uS9/LfCiJuxuOqa2mxLWGojJxy66MBOv33U/FBxWrpqENm/GILC+1w
 O78ZBn5CCl65SEYWExFyyaIevoPcsp7NRvjuoC0wKgUUTw3SJREijV9bqzTfZwa4KTY4
 sHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762791844; x=1763396644;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ug7t0U3i3vWLoKrkf+0DLtQFn79nepjSfJmMaM3NGnI=;
 b=ZAYG+rRRuSuSC2gR1rPoY8TZsC9iH3xCmqge1ewlrGcoHQ5a09uRHiBdEG1tq9P/EK
 8j8i+iWo/u6aLZpcfJewQyxsUWalfhumAYKo3D8N6Q3dqiciRqMGHJiPbp9jT3LWobk2
 UUU3+87P/v0cyxjQE8o0S6cjDt8OMScjVJP0tcyhBVzFOA4VBwifD7nSv8GVh8EiUGEo
 +tU6RwMxhbGdI19r5Q22OMUrsx/Cn89wEsRRWl5pBQTHCVHcwc1NylyV8iD+/XdI0nPp
 2MKQ1jBRrOk4bqm0fFkJMUZ8AgmcK5/elC4nay5oYxP73gUQd0Oww35ekesHXGDS4/qk
 6HAA==
X-Gm-Message-State: AOJu0Yyb+fdbaLPtov5iUwWOdIw2HUfCVNpN3b/xsRmrWgBlAIVGwiiG
 Y34z0Lx7SGWb21DeKjPmluDsPqET6glVdWhP/DhhyX+8dBdG/omnUFPq4assUA==
X-Gm-Gg: ASbGncs9pk+Q+UkYDWrEKHt+7EtuHfMQqGfC9Vb/B3kmC7brvW9d+B6P2DJxFK0+HAY
 zene4knz5HXOkXk8h43hjvL9mErQEsTCRWkPgLzaCKnKJDx2ZrGyOsiMmRVhXpCba1ZAIJQkUH1
 qALVFi/3keo6CjugF8NTsiiXykmNTF9wDjFKYa1+HgOw7de6LuoM7RHqb0x+udRDOnjnhLBEX3v
 38aoHHqZkW77lcW73XCtknx4CcZ3pvng+/Rj6MnNlC1i1g0zd79KyfH6YgZyVLsRTmqMagHrTk+
 MkVuBmTYsoT7ZZ9u1MlZtqL3OuJL4BZMtxcwHYA5ACoQtAsa+CbXxgHiiOmf6gidPjduyrlV8BX
 /3EaMIxzv+qNrL2angPAHofvKyQgIa3312zQuljuCwgcM87vywQXPnghKDHA2C/S5lntA2UTtfs
 BaN7zPHTBjYXxo5OWHfj8pUJPAd5ccBDF/I0E2rQ==
X-Google-Smtp-Source: AGHT+IE/PPFaBisO9P+LVMyLQXcc9D9jpX/mpYt4se23NQxIhMgDeLtSOdAafT8rSHVb4zwIJh/Ruw==
X-Received: by 2002:a05:6a20:431f:b0:34e:a1b2:a35f with SMTP id
 adf61e73a8af0-353a42743f4mr11918041637.53.1762791844379; 
 Mon, 10 Nov 2025 08:24:04 -0800 (PST)
Received: from Param-Desktop.localdomain ([106.51.218.236])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7b0cc866319sm12261161b3a.54.2025.11.10.08.24.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 08:24:03 -0800 (PST)
From: Kumara Parameshwaran <kumaraparamesh92@gmail.com>
To: dev@dpdk.org
Cc: Kumara Parameshwaran <kumaraparamesh92@gmail.com>
Subject: [PATCH] gro : improve GRO performance based on hash table
Date: Mon, 10 Nov 2025 21:53:56 +0530
Message-Id: <20251110162356.173438-1-kumaraparamesh92@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Use cuckoo hash library in GRO for flow flookup

Signed-off-by: Kumara Parameshwaran <kumaraparamesh92@gmail.com>
---

Sample implementation to use Hash library for GRO

 app/test/meson.build |   1 +
 app/test/test_gro.c  | 138 +++++++++++++++++++++++++++++++++++++++++++
 lib/gro/gro_tcp4.c   |  61 +++++++++++--------
 lib/gro/gro_tcp4.h   |   2 +
 lib/gro/meson.build  |   2 +-
 5 files changed, 180 insertions(+), 24 deletions(-)
 create mode 100644 app/test/test_gro.c

diff --git a/app/test/meson.build b/app/test/meson.build
index 8df8d3edd1..03bbe2be1f 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -211,6 +211,7 @@ source_file_deps = {
     'test_trace_register.c': [],
     'test_vdev.c': ['kvargs', 'bus_vdev'],
     'test_version.c': [],
+    'test_gro.c':['net', 'gro'],
 }
 
 source_file_ext_deps = {
diff --git a/app/test/test_gro.c b/app/test/test_gro.c
new file mode 100644
index 0000000000..c07b8ef8d3
--- /dev/null
+++ b/app/test/test_gro.c
@@ -0,0 +1,138 @@
+#include "test.h"
+
+#include <rte_net.h>
+#include <rte_gro.h>
+
+#define NUM_MBUFS 128
+#define BURST 32
+
+/*
+ * Sample TCP/IPv4 packets from Iperf run
+ * Each packet is 132 bytes long and TCP segment is 66 bytes long
+ */
+unsigned char pkts[][132] = {
+{0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc, 0x7c, 0xed, 0x8d, 0xc0, 0xc1, 0xf5, 0x8, 0x0, 0x45, 0x0, 0x0, 0x76, 0xa4, 0xfb, 0x40, 0x0, 0x40, 0x6, 0x81, 0x7c, 0xa, 0x1, 0x0, 0x4, 0xa, 0x1, 0x0, 0x5, 0xcc, 0x8a, 0x14, 0x51, 0xfd, 0x69, 0x8c, 0x75, 0x19, 0x86, 0xdd, 0x46, 0x80, 0x10, 0x2, 0x0, 0x14, 0x73, 0x0, 0x0, 0x1, 0x1, 0x8, 0xa, 0x3c, 0x2, 0xd1, 0xa5, 0x36, 0xb6, 0x9e, 0xda, 0x7d, 0xe9, 0x63, 0xf1, 0x67, 0xeb, 0xc4, 0x93, 0xcf, 0x74, 0xcd, 0xab, 0x93, 0x86, 0xe8, 0xb0, 0x1c, 0x92, 0xc8, 0x82, 0xef, 0x72, 0x34, 0xe7, 0x86, 0x6d, 0xd2, 0x96, 0x8, 0x70, 0xae, 0xda, 0x60, 0xe4, 0x25, 0x39, 0xd2, 0x73, 0xe7, 0xef, 0xf5, 0xf6, 0x7f, 0xbf, 0x7f, 0x5, 0x5a, 0x40, 0x6, 0x65, 0x13, 0x8f, 0xa4, 0x7, 0x73, 0x41, 0xcb, 0x56, 0x3, 0x15, 0x85, 0x99, 0x8c, 0xa9, 0xc8, 0x14},
+{0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc, 0x7c, 0xed, 0x8d, 0xc0, 0xc1, 0xf5, 0x8, 0x0, 0x45, 0x0, 0x0, 0x76, 0xa4, 0xfc, 0x40, 0x0, 0x40, 0x6, 0x81, 0x7b, 0xa, 0x1, 0x0, 0x4, 0xa, 0x1, 0x0, 0x5, 0xcc, 0x8a, 0x14, 0x51, 0xfd, 0x69, 0x8c, 0xb7, 0x19, 0x86, 0xdd, 0x46, 0x80, 0x10, 0x2, 0x0, 0x14, 0x73, 0x0, 0x0, 0x1, 0x1, 0x8, 0xa, 0x3c, 0x2, 0xd1, 0xa5, 0x36, 0xb6, 0x9e, 0xda, 0x2a, 0x6a, 0x4e, 0xf9, 0x94, 0x6, 0xaf, 0x2f, 0xeb, 0xfb, 0xef, 0xa4, 0xaa, 0xe8, 0xd6, 0xc0, 0x34, 0xab, 0x8b, 0xfc, 0x14, 0xb9, 0x89, 0xcb, 0xb6, 0x15, 0x58, 0xe5, 0x2a, 0x72, 0xcd, 0x1c, 0x71, 0x3, 0xf4, 0xf9, 0x32, 0x7e, 0x58, 0xec, 0xe6, 0x52, 0x5a, 0x88, 0x8c, 0x24, 0x53, 0xd7, 0x39, 0x80, 0xb6, 0x66, 0x9b, 0xe5, 0x45, 0xbe, 0x9, 0xf8, 0xac, 0xef, 0xc2, 0x51, 0x31, 0x87, 0x9c, 0x56},
+{0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc, 0x7c, 0xed, 0x8d, 0xc0, 0xc1, 0xf5, 0x8, 0x0, 0x45, 0x0, 0x0, 0x76, 0xa4, 0xfd, 0x40, 0x0, 0x40, 0x6, 0x81, 0x7a, 0xa, 0x1, 0x0, 0x4, 0xa, 0x1, 0x0, 0x5, 0xcc, 0x8a, 0x14, 0x51, 0xfd, 0x69, 0x8c, 0xf9, 0x19, 0x86, 0xdd, 0x46, 0x80, 0x10, 0x2, 0x0, 0x14, 0x73, 0x0, 0x0, 0x1, 0x1, 0x8, 0xa, 0x3c, 0x2, 0xd1, 0xa5, 0x36, 0xb6, 0x9e, 0xda, 0x68, 0x93, 0xec, 0x8a, 0x35, 0xba, 0xe8, 0x24, 0x9e, 0x78, 0x6c, 0xb8, 0x65, 0xe1, 0x23, 0xc1, 0x48, 0x5, 0xca, 0xea, 0x6b, 0x5, 0xe7, 0x71, 0x1a, 0x97, 0x5a, 0x23, 0xd2, 0x81, 0xc9, 0x9a, 0xad, 0x1e, 0x77, 0xb1, 0x9c, 0x43, 0xf, 0xbf, 0x6c, 0xb6, 0x36, 0x46, 0x99, 0xcc, 0x4, 0xf4, 0xc2, 0x87, 0x41, 0xec, 0xc6, 0xc5, 0xd9, 0x48, 0xcf, 0x9b, 0xec, 0xb7, 0x2f, 0x91, 0x5f, 0x83, 0x9f, 0xd},
+{0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc, 0x7c, 0xed, 0x8d, 0xc0, 0xc1, 0xf5, 0x8, 0x0, 0x45, 0x0, 0x0, 0x76, 0xa4, 0xfe, 0x40, 0x0, 0x40, 0x6, 0x81, 0x79, 0xa, 0x1, 0x0, 0x4, 0xa, 0x1, 0x0, 0x5, 0xcc, 0x8a, 0x14, 0x51, 0xfd, 0x69, 0x8d, 0x3b, 0x19, 0x86, 0xdd, 0x46, 0x80, 0x10, 0x2, 0x0, 0x14, 0x73, 0x0, 0x0, 0x1, 0x1, 0x8, 0xa, 0x3c, 0x2, 0xd1, 0xa5, 0x36, 0xb6, 0x9e, 0xda, 0xdd, 0x72, 0x54, 0xdc, 0x5, 0x51, 0xb6, 0x4b, 0xdd, 0x10, 0xfb, 0x1c, 0xe8, 0x5d, 0x84, 0x75, 0xd7, 0x20, 0xd3, 0xc, 0xbd, 0xba, 0x77, 0x1a, 0x14, 0x41, 0x15, 0xd0, 0x34, 0x64, 0x8d, 0x6, 0x32, 0x8f, 0x83, 0x3e, 0xd6, 0xf, 0xaa, 0xe1, 0x7e, 0xdc, 0xbe, 0x33, 0x43, 0xc6, 0x38, 0xcf, 0x9b, 0x6f, 0xf2, 0x1e, 0x50, 0x6f, 0xf3, 0x3b, 0x8f, 0xbf, 0x18, 0x60, 0xd5, 0x43, 0xac, 0xd2, 0xbb, 0x49},
+{0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc, 0x7c, 0xed, 0x8d, 0xc0, 0xc1, 0xf5, 0x8, 0x0, 0x45, 0x0, 0x0, 0x76, 0xa4, 0xff, 0x40, 0x0, 0x40, 0x6, 0x81, 0x78, 0xa, 0x1, 0x0, 0x4, 0xa, 0x1, 0x0, 0x5, 0xcc, 0x8a, 0x14, 0x51, 0xfd, 0x69, 0x8d, 0x7d, 0x19, 0x86, 0xdd, 0x46, 0x80, 0x18, 0x2, 0x0, 0x14, 0x73, 0x0, 0x0, 0x1, 0x1, 0x8, 0xa, 0x3c, 0x2, 0xd1, 0xa5, 0x36, 0xb6, 0x9e, 0xda, 0x5a, 0x95, 0x20, 0xf2, 0x20, 0x9b, 0xd, 0xc1, 0x9, 0xe5, 0x3, 0x68, 0x52, 0x14, 0x2c, 0x7c, 0x98, 0x44, 0x63, 0x6c, 0xc6, 0xe6, 0xba, 0x8a, 0x0, 0x10, 0x66, 0x45, 0xb1, 0xfd, 0x7b, 0x77, 0xf1, 0xf9, 0x95, 0xcd, 0x7f, 0x61, 0x12, 0xeb, 0xa5, 0x23, 0xa0, 0x2, 0xe5, 0x31, 0xd8, 0x1f, 0x36, 0x55, 0x59, 0x46, 0xce, 0x9f, 0xd2, 0x74, 0x6b, 0xf9, 0x63, 0xbe, 0xa1, 0xed, 0xc5, 0x59, 0x22, 0x8c}
+};
+
+void *gro_tcp4_ctx;
+static struct rte_mempool *pkt_pool;
+
+static int test_gro_tcp4_setup(void)
+{
+	pkt_pool = rte_pktmbuf_pool_create("GRO_MBUF_POOL",
+			NUM_MBUFS, BURST, 0,
+			RTE_MBUF_DEFAULT_BUF_SIZE,
+			SOCKET_ID_ANY);
+	if (pkt_pool == NULL) {
+		printf("%s: Error creating pkt mempool\n", __func__);
+		goto failed;
+	}
+
+	gro_tcp4_ctx = rte_gro_ctx_create(&(struct rte_gro_param) {
+					.max_flow_num = 1024,
+					.max_item_per_flow = 32,
+					.gro_types = RTE_GRO_TCP_IPV4,
+			});
+	if (gro_tcp4_ctx == NULL)
+		goto failed;
+
+	return TEST_SUCCESS;
+
+failed:
+	if (pkt_pool)
+		rte_mempool_free(pkt_pool);
+	if (gro_tcp4_ctx)
+		rte_gro_ctx_destroy(gro_tcp4_ctx);
+
+	pkt_pool = NULL;
+	gro_tcp4_ctx = NULL;
+
+	return TEST_FAILED;
+}
+
+static void test_gro_tcp4_teardown(void)
+{
+	if (pkt_pool)
+		rte_mempool_free(pkt_pool);
+	if (gro_tcp4_ctx)
+		rte_gro_ctx_destroy(gro_tcp4_ctx);
+	pkt_pool = NULL;
+	gro_tcp4_ctx = NULL;
+}
+
+static int testsuite_setup(void)
+{
+	return TEST_SUCCESS;
+}
+
+static void testsuite_teardown(void)
+{
+}
+
+static int32_t
+test_gro_tcp4(void)
+{
+	struct rte_mbuf *pkts_mb[5];
+	struct rte_mbuf *gro_pkts[5];
+	int nb_pkts;
+	int nb_gro_pkts;
+	struct rte_net_hdr_lens hdr_lens = {0};
+
+	for (int i = 0; i < 5; i++) {
+		pkts_mb[i] = rte_pktmbuf_alloc(pkt_pool);
+		if (pkts_mb[i] == NULL)
+			goto failed;
+		rte_memcpy(rte_pktmbuf_mtod(pkts_mb[i], void *), pkts[i], 132);
+		pkts_mb[i]->data_len = 132;
+		pkts_mb[i]->pkt_len = 132;
+		pkts_mb[i]->packet_type = rte_net_get_ptype(pkts_mb[i], &hdr_lens,
+										RTE_PTYPE_ALL_MASK);
+		pkts_mb[i]->l2_len = hdr_lens.l2_len;
+		pkts_mb[i]->l3_len = hdr_lens.l3_len;
+		pkts_mb[i]->l4_len = hdr_lens.l4_len;
+	}
+
+	/* GRO reassemble */
+	nb_pkts = rte_gro_reassemble(&pkts_mb[0], 5, gro_tcp4_ctx);
+	TEST_ASSERT(nb_pkts == 0, "Not expected packets after GRO");
+	TEST_ASSERT(rte_gro_get_pkt_count(gro_tcp4_ctx) == 1, "GRO pkt count mismatch");
+
+	/* GRO timeout flush */
+	nb_gro_pkts = rte_gro_timeout_flush(gro_tcp4_ctx, 0, RTE_GRO_TCP_IPV4, gro_pkts, 5);
+	TEST_ASSERT(nb_gro_pkts == 1, "GRO timeout flush pkt count mismatch");
+	TEST_ASSERT(rte_gro_get_pkt_count(gro_tcp4_ctx) == 0, "GRO pkt count after flush mismatch");
+	TEST_ASSERT(gro_pkts[0]->pkt_len == 396, "GRO merged pkt len mismatch");
+
+	return TEST_SUCCESS;
+
+failed:
+	return TEST_FAILED;
+}
+
+static struct unit_test_suite gro_testsuite  = {
+	.suite_name = "GRO Unit Test Suite",
+	.setup = testsuite_setup,
+	.teardown = testsuite_teardown,
+	.unit_test_cases = {
+		TEST_CASE_ST(test_gro_tcp4_setup, test_gro_tcp4_teardown,
+			     test_gro_tcp4),
+
+		TEST_CASES_END() /**< NULL terminate unit test array */
+	}
+};
+
+static int
+test_gro(void)
+{
+	rte_log_set_global_level(RTE_LOG_DEBUG);
+	rte_log_set_level(RTE_LOGTYPE_EAL, RTE_LOG_DEBUG);
+
+	return unit_test_suite_runner(&gro_testsuite);
+}
+
+
+REGISTER_FAST_TEST(gro_autotest, false, true, test_gro);
diff --git a/lib/gro/gro_tcp4.c b/lib/gro/gro_tcp4.c
index 855cc7a71d..96c889334a 100644
--- a/lib/gro/gro_tcp4.c
+++ b/lib/gro/gro_tcp4.c
@@ -5,6 +5,8 @@
 #include <rte_malloc.h>
 #include <rte_mbuf.h>
 #include <rte_ethdev.h>
+#include <rte_hash.h>
+#include <rte_jhash.h>
 
 #include "gro_tcp4.h"
 #include "gro_tcp_internal.h"
@@ -57,6 +59,15 @@ gro_tcp4_tbl_create(uint16_t socket_id,
 		tbl->flows[i].start_index = INVALID_ARRAY_INDEX;
 	tbl->max_flow_num = entries_num;
 
+	/* Create Hash table for faster lookup of the flows */
+	tbl->flow_hash = rte_hash_create(&(struct rte_hash_parameters){
+		.name = "gro_tcp4_flow_hash",
+		.entries = tbl->max_flow_num,
+		.key_len = sizeof(struct tcp4_flow_key),
+		.hash_func = rte_jhash,
+		.hash_func_init_val = 0
+	});
+
 	return tbl;
 }
 
@@ -69,6 +80,8 @@ gro_tcp4_tbl_destroy(void *tbl)
 		rte_free(tcp_tbl->items);
 		rte_free(tcp_tbl->flows);
 	}
+	RTE_ASSERT(rte_hash_count(tcp_tbl->flow_hash) == 0);
+	rte_hash_free(tcp_tbl->flow_hash);
 	rte_free(tcp_tbl);
 }
 
@@ -91,11 +104,17 @@ insert_new_flow(struct gro_tcp4_tbl *tbl,
 {
 	struct tcp4_flow_key *dst;
 	uint32_t flow_idx;
+	int32_t ret;
 
 	flow_idx = find_an_empty_flow(tbl);
 	if (unlikely(flow_idx == INVALID_ARRAY_INDEX))
 		return INVALID_ARRAY_INDEX;
 
+	ret = rte_hash_add_key_data(tbl->flow_hash, src,
+			(void *)&tbl->flows[flow_idx]);
+	if (ret < 0)
+		return INVALID_ARRAY_INDEX;
+
 	dst = &(tbl->flows[flow_idx].key);
 
 	ASSIGN_COMMON_TCP_KEY((&src->cmn_key), (&dst->cmn_key));
@@ -124,9 +143,8 @@ gro_tcp4_reassemble(struct rte_mbuf *pkt,
 
 	struct tcp4_flow_key key;
 	uint32_t item_idx;
-	uint32_t i, max_flow_num, remaining_flow_num;
-	uint8_t find;
-	uint32_t item_start_idx;
+	int ret;
+	struct gro_tcp4_flow *flow;
 
 	/*
 	 * Don't process the packet whose TCP header length is greater
@@ -173,22 +191,8 @@ gro_tcp4_reassemble(struct rte_mbuf *pkt,
 	is_atomic = (frag_off & RTE_IPV4_HDR_DF_FLAG) == RTE_IPV4_HDR_DF_FLAG;
 	ip_id = is_atomic ? 0 : rte_be_to_cpu_16(ipv4_hdr->packet_id);
 
-	/* Search for a matched flow. */
-	max_flow_num = tbl->max_flow_num;
-	remaining_flow_num = tbl->flow_num;
-	find = 0;
-	for (i = 0; i < max_flow_num && remaining_flow_num; i++) {
-		if (tbl->flows[i].start_index != INVALID_ARRAY_INDEX) {
-			if (is_same_tcp4_flow(tbl->flows[i].key, key)) {
-				find = 1;
-				item_start_idx = tbl->flows[i].start_index;
-				break;
-			}
-			remaining_flow_num--;
-		}
-	}
-
-	if (find == 1) {
+	ret = rte_hash_lookup_data(tbl->flow_hash, &key, (void **)&flow);
+	if (ret >= 0) {
 		/*
 		 * Any packet with additional flags like PSH,FIN should be processed
 		 * and flushed immediately.
@@ -197,9 +201,9 @@ gro_tcp4_reassemble(struct rte_mbuf *pkt,
 		 */
 		if (tcp_hdr->tcp_flags & (RTE_TCP_ACK_FLAG | RTE_TCP_PSH_FLAG | RTE_TCP_FIN_FLAG)) {
 			if (tcp_hdr->tcp_flags != RTE_TCP_ACK_FLAG)
-				tbl->items[item_start_idx].start_time = 0;
+				tbl->items[flow->start_index].start_time = 0;
 			return process_tcp_item(pkt, tcp_hdr, tcp_dl, tbl->items,
-						tbl->flows[i].start_index, &tbl->item_num,
+						flow->start_index, &tbl->item_num,
 						tbl->max_item_num, ip_id, is_atomic, start_time);
 		} else {
 			return -1;
@@ -256,6 +260,8 @@ gro_tcp4_tbl_timeout_flush(struct gro_tcp4_tbl *tbl,
 	uint16_t k = 0;
 	uint32_t i, j;
 	uint32_t max_flow_num = tbl->max_flow_num;
+	struct gro_tcp4_flow *flow;
+	int ret;
 
 	for (i = 0; i < max_flow_num; i++) {
 		if (unlikely(tbl->flow_num == 0))
@@ -273,9 +279,18 @@ gro_tcp4_tbl_timeout_flush(struct gro_tcp4_tbl *tbl,
 				 */
 				j = delete_tcp_item(tbl->items, j,
 							&tbl->item_num, INVALID_ARRAY_INDEX);
-				tbl->flows[i].start_index = j;
-				if (j == INVALID_ARRAY_INDEX)
+				if (j == INVALID_ARRAY_INDEX) {
+					flow = &tbl->flows[i];
+					ret = rte_hash_del_key(tbl->flow_hash, &flow->key);
+					RTE_ASSERT(ret >= 0);
+					if (ret >= 0) {
+						ret = rte_hash_free_key_with_position(
+									tbl->flow_hash, ret);
+						RTE_ASSERT(ret == 0);
+					}
 					tbl->flow_num--;
+				}
+				tbl->flows[i].start_index = j;
 
 				if (unlikely(k == nb_out))
 					return k;
diff --git a/lib/gro/gro_tcp4.h b/lib/gro/gro_tcp4.h
index 245e5da486..babf4f7d01 100644
--- a/lib/gro/gro_tcp4.h
+++ b/lib/gro/gro_tcp4.h
@@ -33,6 +33,8 @@ struct gro_tcp4_tbl {
 	struct gro_tcp_item *items;
 	/* flow array */
 	struct gro_tcp4_flow *flows;
+	/* flow hash table */
+	struct rte_hash *flow_hash;
 	/* current item number */
 	uint32_t item_num;
 	/* current flow num */
diff --git a/lib/gro/meson.build b/lib/gro/meson.build
index dbce05220d..96668dcd94 100644
--- a/lib/gro/meson.build
+++ b/lib/gro/meson.build
@@ -10,4 +10,4 @@ sources = files(
         'gro_vxlan_udp4.c',
 )
 headers = files('rte_gro.h')
-deps += ['ethdev']
+deps += ['ethdev', 'hash']
-- 
2.25.1

