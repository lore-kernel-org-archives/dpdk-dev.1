Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B693CD3439
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 00:15:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BA3B40673;
	Thu,  7 May 2026 02:15:13 +0200 (CEST)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id E9F6440649
 for <dev@dpdk.org>; Thu,  7 May 2026 02:15:09 +0200 (CEST)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-2ef8d6ba48bso172877eec.1
 for <dev@dpdk.org>; Wed, 06 May 2026 17:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778112909;
 x=1778717709; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I6+cQ5lJ+0Vr7L6kAQoJYql7M8FnJTN30PAkRwjxuuM=;
 b=gYVEYkIxu838MnVf9D0+OtH/PqGhXg3h1i1bh3cuXXFbwf9Lfn19VwXc/o+JN/wrH1
 yC14W2RpxLPJhDR3tpgi5M3sejpDUsKoA/LV46TxyucEDYNDIU1oMVZ/9+Tiicqc1HCV
 bw0KoMMWfGKMDyQZDb6Y8G+WQd+uhBx1+Guo1ZFWOj7upbPFCsQ1IcnN3//nZKnJKjnP
 Uc6ojWx5DZ0nM9MaKE5sUnmTbC3kDu7ViZBuwQtf3lA50ZrNIYhI9F6KijisY49RK6Pu
 hulBc1GFT1j4+WyduBjHneSTEp2yT2D0JWqRQF/M9wt3e6HtEHio1RStqsQrJLzYYggW
 xBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778112909; x=1778717709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I6+cQ5lJ+0Vr7L6kAQoJYql7M8FnJTN30PAkRwjxuuM=;
 b=WjhWS1ZeZeX706qj9SXv6pQkZ6p9DqsgqoCG67DIWdeRGiX1FiZq6kyn+30F1DbRft
 hb++OyMNex41z8HYx3dmXrN9ZajoVIl5vVKs4wjxky2b6Qv/kvdCVg5HrosOtCKHFVR3
 s7/XQ80dO838AgRR2B4hzyMk0AZjfFm9jSPwMiXxd7c+VQVlkn2C8JBy6Dmocbe9xCS+
 WCt4lJ/2isG5frXsOqN4J0h1OJkCUX0EyOEr3fT6WrpkZ0xIIP+Rb5O8W59QhmCgCNnN
 x5cGHQMPjQ4GHE2SjWqyFJiP1C28JSkLj1pqhBDQBRTHvFkz1FLrCRasTpPQ2+OxoevQ
 Gceg==
X-Gm-Message-State: AOJu0YyHfSo/JTVwRYw9Jb3zDBDP38LwyCfye5/y8+Y5KoIme46U0LsQ
 YY0AnNPFxJnkvgYIVNb+R7+02SZQOGySYPfSZATsUT/PvICFj+TFd0lhNJqijCmOhA+gj4N2yEv
 iJKXu
X-Gm-Gg: AeBDieuW2EoTjOujIsVdeXhfk/aCkgxiBkejsPqW9Fqgxtp+aCkZxm5VzibXDqP/Fd+
 D716pkJqydl/Ak1lMggSJB2YR3YUXRuPTXyVsF4sleR1owaef0YFpsSBnWMk+hzm86YsoN0K0eL
 CNovbHx6HDQJNg2Hv7EilUNje/SDByoAukNpHMPoMRI09dvaDgsrxTOVVGv5w4LhefnGxhpyeB7
 RCr65Hd4Nb8++v4+V75a3iC7fY+VF3hlxRndixGkD2w331rbgXO3bD8qG2XdZm4YRLuUKT+KdJo
 /X7i5zLOy71sm/xl2fm79a1X/9G6Vi9+5yySOK5Mv4kXDvV5IrTrNt+KSWi1zkGRbYVrJuCFhnB
 2X4AhQY+QuMsnF/FLnp4DM/W7y2ostVafajqPmzJCDh6amd5IB/zKm8BKQ8pdjzQmOCXKiScA/6
 cRENbqEGRf4mvaCXk+fZDTcYQ/L/mUcRdjmP9Hzlxqiv8=
X-Received: by 2002:a05:7300:a599:b0:2ee:7b2e:8a3e with SMTP id
 5a478bee46e88-2f6e1e32133mr323230eec.1.1778112908780; 
 Wed, 06 May 2026 17:15:08 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f57057bd00sm5159080eec.30.2026.05.06.17.15.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 17:15:08 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [RFC v2 4/4] test/flow_compile: add unit tests for flow rule compiler
Date: Wed,  6 May 2026 17:06:51 -0700
Message-ID: <20260507001501.608724-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507001501.608724-1-stephen@networkplumber.org>
References: <20260505183917.370281-1-sismis@dyna-nic.com>
 <20260507001501.608724-1-stephen@networkplumber.org>
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

Add an autotest for the new rte_flow_compile library.  The tests
exercise the parser end to end without needing a real ethdev port:
each case compiles a textual rule and inspects the resulting
attribute, pattern and action arrays directly.

Coverage spans the common happy paths (simple drop, IPv4/IPv6 match
with queue and count actions, MAC matching, CIDR-style prefix
masks) and a set of error-path cases.  The error tests assert a
substring of the diagnostic rather than the full message so that
wording can evolve without churning the tests.

Registered as flow_compile_autotest in the fast test suite so it
runs under the standard meson test invocation.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 MAINTAINERS                  |   1 +
 app/test/meson.build         |   1 +
 app/test/test_flow_compile.c | 255 +++++++++++++++++++++++++++++++++++
 3 files changed, 257 insertions(+)
 create mode 100644 app/test/test_flow_compile.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4923e126df..d469ac2c19 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -453,6 +453,7 @@ M: Stephen Hemminger <stephen@networkplumber.org>
 T: git://dpdk.org/next/dpdk-next-net
 F: lib/flow_compile/
 F: doc/guides/prog_guide/flow_compile_lib.rst
+F: app/test/test_flow_compile.c
 
 Traffic Management API
 M: Cristian Dumitrescu <cristian.dumitrescu@intel.com>
diff --git a/app/test/meson.build b/app/test/meson.build
index 7d458f9c07..be0d61c6a0 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -88,6 +88,7 @@ source_file_deps = {
     'test_fib6_perf.c': ['fib'],
     'test_fib_perf.c': ['net', 'fib'],
     'test_flow_classify.c': ['net', 'acl', 'table', 'ethdev', 'flow_classify'],
+    'test_flow_compile.c': ['net', 'ethdev', 'flow_compile'],
     'test_func_reentrancy.c': ['hash', 'lpm'],
     'test_graph.c': ['graph'],
     'test_graph_feature_arc.c': ['graph'],
diff --git a/app/test/test_flow_compile.c b/app/test/test_flow_compile.c
new file mode 100644
index 0000000000..d3acc9ae21
--- /dev/null
+++ b/app/test/test_flow_compile.c
@@ -0,0 +1,255 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2026 Stephen Hemminger <stephen@networkplumber.org>
+ */
+
+/*
+ * Unit tests for rte_flow_compile.
+ *
+ * These exercise the parser only -- they don't need a real ethdev
+ * port.  They check both successful parses (asserting the resulting
+ * pattern/action arrays) and parse failures (asserting that the
+ * error buffer contains a recognizable substring).
+ */
+
+#include <stdint.h>
+#include <string.h>
+
+#include <rte_byteorder.h>
+#include <rte_eal.h>
+#include <rte_flow.h>
+
+#include "test.h"
+#include "rte_flow_compile.h"
+
+static int
+test_simple_eth_drop(void)
+{
+	char err[RTE_FLOW_COMPILE_ERRBUF_SIZE];
+	struct rte_flow_compile *fc =
+		rte_flow_compile("ingress pattern eth / end actions drop / end",
+				 err);
+	TEST_ASSERT_NOT_NULL(fc, "compile failed: %s", err);
+
+	TEST_ASSERT_EQUAL(rte_flow_compile_attr(fc)->ingress, 1,
+			  "ingress not set");
+	TEST_ASSERT_EQUAL(rte_flow_compile_attr(fc)->egress, 0,
+			  "egress should not be set");
+
+	unsigned int n;
+	const struct rte_flow_item *p = rte_flow_compile_pattern(fc, &n);
+	TEST_ASSERT_EQUAL(n, 2u, "expected 2 items, got %u", n);
+	TEST_ASSERT_EQUAL(p[0].type, RTE_FLOW_ITEM_TYPE_ETH,
+			  "item 0 type");
+	TEST_ASSERT_NULL(p[0].spec, "eth spec should be NULL");
+	TEST_ASSERT_EQUAL(p[1].type, RTE_FLOW_ITEM_TYPE_END,
+			  "item 1 should be END");
+
+	const struct rte_flow_action *a = rte_flow_compile_actions(fc, &n);
+	TEST_ASSERT_EQUAL(n, 2u, "expected 2 actions, got %u", n);
+	TEST_ASSERT_EQUAL(a[0].type, RTE_FLOW_ACTION_TYPE_DROP,
+			  "action 0 type");
+	TEST_ASSERT_EQUAL(a[1].type, RTE_FLOW_ACTION_TYPE_END,
+			  "action 1 should be END");
+
+	rte_flow_compile_free(fc);
+	return 0;
+}
+
+static int
+test_ipv4_match_queue(void)
+{
+	char err[RTE_FLOW_COMPILE_ERRBUF_SIZE];
+	const char *src =
+		"ingress group 0 priority 1\n"
+		"pattern eth / ipv4 src is 10.0.0.1 dst is 10.0.0.2 /"
+		"   udp dst is 4789 / end\n"
+		"actions queue index 3 / count / end\n";
+
+	struct rte_flow_compile *fc = rte_flow_compile(src, err);
+	TEST_ASSERT_NOT_NULL(fc, "compile failed: %s", err);
+
+	TEST_ASSERT_EQUAL(rte_flow_compile_attr(fc)->priority, 1u,
+			  "priority not set");
+
+	unsigned int n;
+	const struct rte_flow_item *p = rte_flow_compile_pattern(fc, &n);
+	TEST_ASSERT_EQUAL(n, 4u, "expected 4 items");
+	TEST_ASSERT_EQUAL(p[1].type, RTE_FLOW_ITEM_TYPE_IPV4,
+			  "item 1 should be IPV4");
+
+	const struct rte_flow_item_ipv4 *ipv4 = p[1].spec;
+	const struct rte_flow_item_ipv4 *m4   = p[1].mask;
+	TEST_ASSERT_NOT_NULL(ipv4, "ipv4 spec");
+	TEST_ASSERT_NOT_NULL(m4,   "ipv4 mask");
+
+	/* 10.0.0.1 in network order = bytes 0a 00 00 01 */
+	const uint8_t *src_b = (const uint8_t *)&ipv4->hdr.src_addr;
+	const uint8_t *dst_b = (const uint8_t *)&ipv4->hdr.dst_addr;
+	TEST_ASSERT_EQUAL(src_b[0], 0x0a, "src[0]");
+	TEST_ASSERT_EQUAL(src_b[3], 0x01, "src[3]");
+	TEST_ASSERT_EQUAL(dst_b[0], 0x0a, "dst[0]");
+	TEST_ASSERT_EQUAL(dst_b[3], 0x02, "dst[3]");
+
+	const uint8_t *src_m = (const uint8_t *)&m4->hdr.src_addr;
+	for (int i = 0; i < 4; i++)
+		TEST_ASSERT_EQUAL(src_m[i], 0xff, "src mask byte %d", i);
+
+	TEST_ASSERT_EQUAL(p[2].type, RTE_FLOW_ITEM_TYPE_UDP,
+			  "item 2 should be UDP");
+	const struct rte_flow_item_udp *u = p[2].spec;
+	TEST_ASSERT_EQUAL(rte_be_to_cpu_16(u->hdr.dst_port), 4789,
+			  "udp dst port");
+
+	const struct rte_flow_action *a = rte_flow_compile_actions(fc, &n);
+	TEST_ASSERT_EQUAL(n, 3u, "expected 3 actions");
+	TEST_ASSERT_EQUAL(a[0].type, RTE_FLOW_ACTION_TYPE_QUEUE,
+			  "action 0 should be QUEUE");
+	const struct rte_flow_action_queue *q = a[0].conf;
+	TEST_ASSERT_EQUAL(q->index, 3u, "queue index");
+	TEST_ASSERT_EQUAL(a[1].type, RTE_FLOW_ACTION_TYPE_COUNT,
+			  "action 1 should be COUNT");
+
+	rte_flow_compile_free(fc);
+	return 0;
+}
+
+static int
+test_ipv4_prefix(void)
+{
+	char err[RTE_FLOW_COMPILE_ERRBUF_SIZE];
+	struct rte_flow_compile *fc = rte_flow_compile(
+		"pattern eth / ipv4 src spec 192.168.0.0 src prefix 16 / end "
+		"actions drop / end", err);
+	TEST_ASSERT_NOT_NULL(fc, "compile failed: %s", err);
+
+	const struct rte_flow_item *p = rte_flow_compile_pattern(fc, NULL);
+	const struct rte_flow_item_ipv4 *m = p[1].mask;
+	TEST_ASSERT_NOT_NULL(m, "ipv4 mask");
+	TEST_ASSERT_EQUAL(rte_be_to_cpu_32(m->hdr.src_addr), 0xffff0000u,
+			  "/16 prefix mask");
+
+	rte_flow_compile_free(fc);
+	return 0;
+}
+
+static int
+test_mac(void)
+{
+	char err[RTE_FLOW_COMPILE_ERRBUF_SIZE];
+	struct rte_flow_compile *fc = rte_flow_compile(
+		"pattern eth dst is 11:22:33:44:55:66 / end "
+		"actions drop / end", err);
+	TEST_ASSERT_NOT_NULL(fc, "compile failed: %s", err);
+
+	const struct rte_flow_item *p = rte_flow_compile_pattern(fc, NULL);
+	const struct rte_flow_item_eth *e = p[0].spec;
+	TEST_ASSERT_EQUAL(e->hdr.dst_addr.addr_bytes[0], 0x11,
+			  "MAC byte 0");
+	TEST_ASSERT_EQUAL(e->hdr.dst_addr.addr_bytes[5], 0x66,
+			  "MAC byte 5");
+
+	rte_flow_compile_free(fc);
+	return 0;
+}
+
+static int
+test_ipv6(void)
+{
+	char err[RTE_FLOW_COMPILE_ERRBUF_SIZE];
+	struct rte_flow_compile *fc = rte_flow_compile(
+		"pattern eth / ipv6 dst is 2001:db8::1 / end "
+		"actions drop / end", err);
+	TEST_ASSERT_NOT_NULL(fc, "compile failed: %s", err);
+
+	const struct rte_flow_item *p = rte_flow_compile_pattern(fc, NULL);
+	const struct rte_flow_item_ipv6 *v6 = p[1].spec;
+	const uint8_t *b = (const uint8_t *)&v6->hdr.dst_addr;
+	TEST_ASSERT_EQUAL(b[0],  0x20, "ipv6[0]");
+	TEST_ASSERT_EQUAL(b[1],  0x01, "ipv6[1]");
+	TEST_ASSERT_EQUAL(b[2],  0x0d, "ipv6[2]");
+	TEST_ASSERT_EQUAL(b[3],  0xb8, "ipv6[3]");
+	TEST_ASSERT_EQUAL(b[15], 0x01, "ipv6[15]");
+
+	rte_flow_compile_free(fc);
+	return 0;
+}
+
+static int
+expect_error(const char *src, const char *needle)
+{
+	char err[RTE_FLOW_COMPILE_ERRBUF_SIZE];
+	struct rte_flow_compile *fc = rte_flow_compile(src, err);
+
+	TEST_ASSERT_NULL(fc, "expected failure, got success: %s", src);
+	TEST_ASSERT(strstr(err, needle) != NULL,
+		    "error '%s' did not contain '%s'", err, needle);
+	return 0;
+}
+
+static int
+test_errors(void)
+{
+	TEST_ASSERT_SUCCESS(expect_error("",
+					 "expected"), "empty input");
+	TEST_ASSERT_SUCCESS(expect_error(
+				    "pattern bogus / end actions drop / end",
+				    "unknown flow item"), "unknown item");
+	TEST_ASSERT_SUCCESS(expect_error(
+				    "pattern eth bogus is 1 / end actions drop / end",
+				    "unknown field"), "unknown field");
+	TEST_ASSERT_SUCCESS(expect_error(
+				    "pattern eth dst is 1 / end actions drop / end",
+				    "MAC"), "non-MAC value for MAC field");
+	TEST_ASSERT_SUCCESS(expect_error(
+				    "pattern eth / end actions queue bogus 1 / end",
+				    "unknown parameter"), "unknown action parameter");
+	TEST_ASSERT_SUCCESS(expect_error(
+				    "pattern eth / end actions queue index 99999 / end",
+				    "out of range"), "out-of-range action parameter");
+	TEST_ASSERT_SUCCESS(expect_error(
+				    "pattern eth ; / end actions drop / end",
+				    "unexpected"), "unexpected character");
+
+	/* end is mandatory at end of pattern list (regression for grammar fix) */
+	TEST_ASSERT_SUCCESS(expect_error(
+				    "pattern eth / actions drop / end",
+				    "expected"), "missing end on pattern list");
+
+	/* end is mandatory at end of action list (regression for grammar fix) */
+	TEST_ASSERT_SUCCESS(expect_error(
+				    "pattern eth / end actions drop /",
+				    "expected"), "missing end on action list");
+
+	/* pattern list must contain at least one item */
+	TEST_ASSERT_SUCCESS(expect_error(
+				    "pattern end actions drop / end",
+				    "expected"), "empty pattern list");
+
+	/* action list must contain at least one action */
+	TEST_ASSERT_SUCCESS(expect_error(
+				    "pattern eth / end actions end",
+				    "expected"), "empty action list");
+
+	return 0;
+}
+
+static struct unit_test_suite flow_compile_suite = {
+	.suite_name = "flow_compile",
+	.unit_test_cases = {
+		TEST_CASE(test_simple_eth_drop),
+		TEST_CASE(test_ipv4_match_queue),
+		TEST_CASE(test_ipv4_prefix),
+		TEST_CASE(test_mac),
+		TEST_CASE(test_ipv6),
+		TEST_CASE(test_errors),
+		TEST_CASES_END(),
+	},
+};
+
+static int
+test_flow_compile(void)
+{
+	return unit_test_suite_runner(&flow_compile_suite);
+}
+
+REGISTER_FAST_TEST(flow_compile_autotest, NOHUGE_OK, ASAN_OK, test_flow_compile);
-- 
2.53.0

