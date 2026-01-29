Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6B1D6100C
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 11:42:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C78040651;
	Thu, 29 Jan 2026 12:42:19 +0100 (CET)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id AC6B140608
 for <dev@dpdk.org>; Thu, 29 Jan 2026 12:42:15 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4806bf39419so12439735e9.1
 for <dev@dpdk.org>; Thu, 29 Jan 2026 03:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1769686935; x=1770291735; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LpmAOePh/Q7QC8MISaiV+nN71hrzIa2i3qMy3se7ols=;
 b=aFhbo7YYpulsrWR6o4W2eElpsxmfKbAqLUywFuP7rNBiF87NihDpnVIWpQjRJgcPD/
 XaUHYkctzaN2qf7EO/glXgugM784cAevDjeW+5i8XptY8Zpyf/idatBfsJj6wAlU4dmV
 Jw2qYixhhX8GYUOPz9xaGTQxOceM9Z1NClRV8bFgeAiPB2BAnbyJkwvobtHqNoKfQ8VI
 7j+v3n9dlRZlaNAmq/hEBgN2TTDy+ly5pbSN7Q93qqj6MY/RsdD1p8eiD6QAaLt5uIoh
 GTD9sDKSCXalaNOV0MXcucCcAucHBtKBv+L7Y8QIX211ztKMasMxJTGNecXG3DEdjR66
 VxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769686935; x=1770291735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LpmAOePh/Q7QC8MISaiV+nN71hrzIa2i3qMy3se7ols=;
 b=s0llxw8s7JtrFOzONkzaw0A3xtsfx08Pk0DYC0Pr0282cVAhQZ5Xjx6Mq9EGLgz2qX
 fXD4ciBiY27y2V5gkMUYBiXRtkCUOZ3CG2FsBw3365Kc3wERM2lQwVmTDKBhyQAeXRfJ
 Hoi0x/pGS6fxI+bQuLo/AWF6xAQ9Ym0oJfIFMWLHeJfjAjjY3EymUl2mhnbZTKEEbc97
 WIXLNxySmbTKodbBvXUhWB4jYA8BNlRPzsj/jAJBZaN0rausgWbVmjqqoIZW6KuJkmWA
 6ke29XLMBhFUPHJZE7ChjUGM/jX8gjpSJ7ZLlg6GgHsqlwgDtEI6hLvowK0ZfDklg8qA
 gVMw==
X-Gm-Message-State: AOJu0Yy/dUFemDnZx7oeA84tYXtY8nZ/Bss4PFcmXo+x/WXC//yya6SE
 Yw7c5eVuq+c1oOadaEFcs6DwxPcG5/6G17LKLufODASXn9z0K6KmDlaPuaYHRDiAIipO4xSLI7j
 WHqt9
X-Gm-Gg: AZuq6aLS1B2NRIGHvn8f/V8cf1kJFtQSqWoPp++IJVCcqn3qkwBaujrbsK2ih35/aUy
 2ytZCm8T6vaWn5H5o/FWcE1XKRgJASvBg13/PLarOGu8EPi3yeWc+wJEXpBxTT7561Q8RwBuz7B
 /hob3X/8ZMxEQs6UGTymyfRoJ1Z8giy8efQ+WQRnkufIr743Z4yH12Xx0vMr7AHtQi0GANVNy4p
 u4BCX0vnO1/gR+QEjWR69vUn3xOwW/6qZlX9ffZ9MjvJl/fsNXZZpuy0ttaYxri98AtAmDqXGuB
 zwG5cM7cB9M+H90NMYsMFTkdmWey0ouJOjcnMg0XG7FCxdhCgHJTQm0awxN2saV4PO8OZ0ZMHST
 /sjUPKe+JcWmYCJi89C0/iCt2I3ndkynBjGROlVGKzrerkD3zObxjqGNuInsy+qkHio1mAzYuxL
 sWPc5k5qSVPTysUnNH6ssrasQ2Ov0+btvZ86zWeyZDHhKuYg==
X-Received: by 2002:a05:600c:1d1d:b0:477:9e0c:f59 with SMTP id
 5b1f17b1804b1-48082891d58mr38462315e9.2.1769686934789; 
 Thu, 29 Jan 2026 03:42:14 -0800 (PST)
Received: from claret.liberouter.org (rt-tmc-kou.liberouter.org.
 [195.113.172.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce4c515sm123071315e9.11.2026.01.29.03.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 03:42:14 -0800 (PST)
From: Lukas Sismis <sismis@dyna-nic.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org,
	Lukas Sismis <sismis@dyna-nic.com>
Subject: [PATCH v8 5/6] examples/flow_parsing: add flow parser demo
Date: Thu, 29 Jan 2026 12:42:01 +0100
Message-ID: <20260129114202.61185-6-sismis@dyna-nic.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260129114202.61185-1-sismis@dyna-nic.com>
References: <20260129114202.61185-1-sismis@dyna-nic.com>
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

Add example application demonstrating the flow parser library API.

The example shows how to use the primary external functions for
parsing parts of rte_flow rules.

Configure with: meson configure -Dexamples=flow_parsing

Signed-off-by: Lukas Sismis <sismis@dyna-nic.com>
---
 MAINTAINERS                       |   1 +
 examples/flow_parsing/main.c      | 292 ++++++++++++++++++++++++++++++
 examples/flow_parsing/meson.build |  11 ++
 examples/meson.build              |   1 +
 4 files changed, 305 insertions(+)
 create mode 100644 examples/flow_parsing/main.c
 create mode 100644 examples/flow_parsing/meson.build

diff --git a/MAINTAINERS b/MAINTAINERS
index d668dcc8e4..899c767691 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -449,6 +449,7 @@ F: doc/guides/prog_guide/ethdev/flow_offload.rst
 F: doc/guides/prog_guide/flow_parser_lib.rst
 F: lib/ethdev/rte_flow*
 F: lib/flow_parser/
+F: examples/flow_parsing/
 
 Traffic Management API
 M: Cristian Dumitrescu <cristian.dumitrescu@intel.com>
diff --git a/examples/flow_parsing/main.c b/examples/flow_parsing/main.c
new file mode 100644
index 0000000000..a672e21ce8
--- /dev/null
+++ b/examples/flow_parsing/main.c
@@ -0,0 +1,292 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 DynaNIC Semiconductors, Ltd.
+ */
+
+/*
+ * Flow Parsing Example
+ * ====================
+ * This example demonstrates how to use the flow_parser library to parse
+ * flow rule strings into rte_flow C structures. The library provides ONE WAY
+ * to create rte_flow structures - by parsing testpmd-style command strings.
+ *
+ * Alternative approaches:
+ *   - Construct rte_flow_attr, rte_flow_item[], and rte_flow_action[]
+ *     directly in C code and call rte_flow_create()/rte_flow_validate().
+ *
+ * This string-based approach is useful when:
+ *   - Accepting flow rules from user input or configuration files
+ *   - Reusing the familiar testpmd flow command syntax
+ *   - Rapid prototyping without manually constructing C structures
+ *
+ * Key functions demonstrated:
+ *   - rte_flow_parser_parse_attr_str() - Parse flow attributes (ingress/egress/priority)
+ *   - rte_flow_parser_parse_pattern_str() - Parse match patterns (eth/ipv4/tcp/etc)
+ *   - rte_flow_parser_parse_actions_str() - Parse actions (drop/queue/mark/etc)
+ *
+ * NOTE: The parse functions return pointers to internal static buffers.
+ * Each subsequent parse call overwrites the previous result.
+ */
+
+#include <stdio.h>
+#include <stdint.h>
+#include <string.h>
+
+#include <rte_common.h>
+#include <rte_byteorder.h>
+#include <rte_ether.h>
+#include <rte_flow.h>
+#include <rte_flow_parser.h>
+
+/* Helper to print flow attributes */
+static void
+print_attr(const struct rte_flow_attr *attr)
+{
+	printf("  Attributes:\n");
+	printf("    group=%u priority=%u\n", attr->group, attr->priority);
+	printf("    ingress=%u egress=%u transfer=%u\n",
+	       attr->ingress, attr->egress, attr->transfer);
+}
+
+/* Helper to print a MAC address */
+static void
+print_mac(const char *label, const struct rte_ether_addr *mac)
+{
+	char buf[RTE_ETHER_ADDR_FMT_SIZE];
+
+	rte_ether_format_addr(buf, sizeof(buf), mac);
+	printf("    %s: %s\n", label, buf);
+}
+
+/* Helper to print pattern items */
+static void
+print_pattern(const struct rte_flow_item *pattern, uint32_t pattern_n)
+{
+	uint32_t i;
+
+	printf("  Pattern (%u items):\n", pattern_n);
+	for (i = 0; i < pattern_n; i++) {
+		const struct rte_flow_item *item = &pattern[i];
+
+		switch (item->type) {
+		case RTE_FLOW_ITEM_TYPE_END:
+			printf("    [%u] END\n", i);
+			break;
+		case RTE_FLOW_ITEM_TYPE_ETH:
+			printf("    [%u] ETH", i);
+			if (item->spec) {
+				const struct rte_flow_item_eth *eth = item->spec;
+				printf("\n");
+				print_mac("dst", &eth->hdr.dst_addr);
+				print_mac("src", &eth->hdr.src_addr);
+			} else {
+				printf(" (any)\n");
+			}
+			break;
+		case RTE_FLOW_ITEM_TYPE_IPV4:
+			printf("    [%u] IPV4", i);
+			if (item->spec) {
+				const struct rte_flow_item_ipv4 *ipv4 = item->spec;
+				const uint8_t *s = (const uint8_t *)&ipv4->hdr.src_addr;
+				const uint8_t *d = (const uint8_t *)&ipv4->hdr.dst_addr;
+				printf(" src=%u.%u.%u.%u dst=%u.%u.%u.%u\n",
+				       s[0], s[1], s[2], s[3],
+				       d[0], d[1], d[2], d[3]);
+			} else {
+				printf(" (any)\n");
+			}
+			break;
+		case RTE_FLOW_ITEM_TYPE_TCP:
+			printf("    [%u] TCP", i);
+			if (item->spec) {
+				const struct rte_flow_item_tcp *tcp = item->spec;
+				printf(" sport=%u dport=%u\n",
+				       rte_be_to_cpu_16(tcp->hdr.src_port),
+				       rte_be_to_cpu_16(tcp->hdr.dst_port));
+			} else {
+				printf(" (any)\n");
+			}
+			break;
+		case RTE_FLOW_ITEM_TYPE_UDP:
+			printf("    [%u] UDP", i);
+			if (item->spec) {
+				const struct rte_flow_item_udp *udp = item->spec;
+				printf(" sport=%u dport=%u\n",
+				       rte_be_to_cpu_16(udp->hdr.src_port),
+				       rte_be_to_cpu_16(udp->hdr.dst_port));
+			} else {
+				printf(" (any)\n");
+			}
+			break;
+		default:
+			printf("    [%u] type=%d\n", i, item->type);
+			break;
+		}
+	}
+}
+
+/* Helper to print actions */
+static void
+print_actions(const struct rte_flow_action *actions, uint32_t actions_n)
+{
+	uint32_t i;
+
+	printf("  Actions (%u items):\n", actions_n);
+	for (i = 0; i < actions_n; i++) {
+		const struct rte_flow_action *action = &actions[i];
+
+		switch (action->type) {
+		case RTE_FLOW_ACTION_TYPE_END:
+			printf("    [%u] END\n", i);
+			break;
+		case RTE_FLOW_ACTION_TYPE_DROP:
+			printf("    [%u] DROP\n", i);
+			break;
+		case RTE_FLOW_ACTION_TYPE_QUEUE:
+			if (action->conf) {
+				const struct rte_flow_action_queue *q = action->conf;
+				printf("    [%u] QUEUE index=%u\n", i, q->index);
+			}
+			break;
+		case RTE_FLOW_ACTION_TYPE_MARK:
+			if (action->conf) {
+				const struct rte_flow_action_mark *m = action->conf;
+				printf("    [%u] MARK id=%u\n", i, m->id);
+			}
+			break;
+		case RTE_FLOW_ACTION_TYPE_COUNT:
+			printf("    [%u] COUNT\n", i);
+			break;
+		case RTE_FLOW_ACTION_TYPE_PORT_ID:
+			if (action->conf) {
+				const struct rte_flow_action_port_id *p = action->conf;
+				printf("    [%u] PORT_ID id=%u\n", i, p->id);
+			}
+			break;
+		default:
+			printf("    [%u] type=%d\n", i, action->type);
+			break;
+		}
+	}
+}
+
+/*
+ * Demonstrate parsing flow attributes
+ */
+static void
+demo_parse_attr(void)
+{
+	static const char * const attr_strings[] = {
+		"ingress",
+		"egress",
+		"ingress priority 5",
+		"ingress group 1 priority 10",
+		"transfer",
+	};
+	struct rte_flow_attr attr;
+	unsigned int i;
+	int ret;
+
+	printf("\n=== Parsing Flow Attributes ===\n");
+	printf("Use rte_flow_parser_parse_attr_str() to parse attribute strings.\n\n");
+
+	for (i = 0; i < RTE_DIM(attr_strings); i++) {
+		printf("Input: \"%s\"\n", attr_strings[i]);
+		memset(&attr, 0, sizeof(attr));
+		ret = rte_flow_parser_parse_attr_str(attr_strings[i], &attr);
+		if (ret == 0)
+			print_attr(&attr);
+		else
+			printf("  ERROR: %d (%s)\n", ret, strerror(-ret));
+		printf("\n");
+	}
+}
+
+/*
+ * Demonstrate parsing flow patterns
+ */
+static void
+demo_parse_pattern(void)
+{
+	static const char * const pattern_strings[] = {
+		"eth / end",
+		"eth dst is 90:61:ae:fd:41:43 / end",
+		"eth / ipv4 src is 192.168.1.1 / end",
+		"eth / ipv4 / tcp dst is 80 / end",
+		"eth / ipv4 src is 10.0.0.1 dst is 10.0.0.2 / udp src is 1234 dst is 5678 / end",
+	};
+	const struct rte_flow_item *pattern;
+	uint32_t pattern_n;
+	unsigned int i;
+	int ret;
+
+	printf("\n=== Parsing Flow Patterns ===\n");
+	printf("Use rte_flow_parser_parse_pattern_str() to parse pattern strings.\n\n");
+
+	for (i = 0; i < RTE_DIM(pattern_strings); i++) {
+		printf("Input: \"%s\"\n", pattern_strings[i]);
+		ret = rte_flow_parser_parse_pattern_str(pattern_strings[i],
+							&pattern, &pattern_n);
+		if (ret == 0)
+			print_pattern(pattern, pattern_n);
+		else
+			printf("  ERROR: %d (%s)\n", ret, strerror(-ret));
+		printf("\n");
+	}
+}
+
+/*
+ * Demonstrate parsing flow actions
+ */
+static void
+demo_parse_actions(void)
+{
+	static const char * const action_strings[] = {
+		"drop / end",
+		"queue index 3 / end",
+		"mark id 42 / end",
+		"count / queue index 1 / end",
+		"mark id 100 / count / queue index 5 / end",
+	};
+	const struct rte_flow_action *actions;
+	uint32_t actions_n;
+	unsigned int i;
+	int ret;
+
+	printf("\n=== Parsing Flow Actions ===\n");
+	printf("Use rte_flow_parser_parse_actions_str() to parse action strings.\n\n");
+
+	for (i = 0; i < RTE_DIM(action_strings); i++) {
+		printf("Input: \"%s\"\n", action_strings[i]);
+		ret = rte_flow_parser_parse_actions_str(action_strings[i],
+							&actions, &actions_n);
+		if (ret == 0)
+			print_actions(actions, actions_n);
+		else
+			printf("  ERROR: %d (%s)\n", ret, strerror(-ret));
+		printf("\n");
+	}
+}
+
+int
+main(void)
+{
+	int ret;
+
+	printf("Flow Parser Library Example\n");
+	printf("===========================\n");
+
+	/* Initialize the flow parser */
+	ret = rte_flow_parser_init(NULL);
+	if (ret != 0) {
+		fprintf(stderr, "Failed to initialize flow parser: %d\n", ret);
+		return 1;
+	}
+
+	/* Run demonstrations */
+	demo_parse_attr();
+	demo_parse_pattern();
+	demo_parse_actions();
+
+	printf("\n=== Example Complete ===\n");
+	return 0;
+}
diff --git a/examples/flow_parsing/meson.build b/examples/flow_parsing/meson.build
new file mode 100644
index 0000000000..a4f4c5910c
--- /dev/null
+++ b/examples/flow_parsing/meson.build
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 DynaNIC Semiconductors, Ltd.
+
+# meson file, for building this example as part of a main DPDK build.
+#
+# To build this example as a standalone application with an already-installed
+# DPDK instance, use 'make'
+
+allow_experimental_apis = true
+deps += 'flow_parser'
+sources = files('main.c')
diff --git a/examples/meson.build b/examples/meson.build
index 25d9c88457..22f45e8c81 100644
--- a/examples/meson.build
+++ b/examples/meson.build
@@ -17,6 +17,7 @@ all_examples = [
         'eventdev_pipeline',
         'fips_validation',
         'flow_filtering',
+        'flow_parsing',
         'helloworld',
         'ip_fragmentation',
         'ip_pipeline',
-- 
2.43.7

