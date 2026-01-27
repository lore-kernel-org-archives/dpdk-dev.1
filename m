Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD15ED2FED2
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 18:48:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E796427AA;
	Tue, 27 Jan 2026 19:47:55 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id B08DC42797
 for <dev@dpdk.org>; Tue, 27 Jan 2026 19:47:51 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-47d59da3d81so963695e9.0
 for <dev@dpdk.org>; Tue, 27 Jan 2026 10:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1769539671; x=1770144471; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vMR5dqt+GfpaC0ncKdi6rGuOi8kDefY3Pt1U7JTv1Zg=;
 b=jqEkEhZjDomY3eat9f2sr6RPLgAx66/+PnGCgSLJ2XQCLACn1TGwylOFgyGS3483e4
 ABRZKYo658dYKXrBRLWmD2snQFFbmswZnXQX85OVwKqcK9p6hC5GcplKqkD+pQFdsgkh
 neV9C3lCZDpkoEXWx8QfK08WOQXcmxL2EuKXPOSGxbwbFIlVxlVzwewQw6WUG3trb+f8
 LfhlJiVdxu/txjM9OXvPW5gxWBimEl1AA4EmUrEQylanaOtBveyjY3MLV7YmoBKmfncs
 QyNYZb8rkuCcT1Eg0G/eI4PIAIFJ+fC0ihU7a+pJMTkuU9W1tne9syHsFp3Rb4hpF7Mo
 wN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769539671; x=1770144471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vMR5dqt+GfpaC0ncKdi6rGuOi8kDefY3Pt1U7JTv1Zg=;
 b=eti5Kt7MNh01DSv5GnEBIqhwgDIc0F/RFBcFNJOIif5yAI7O5VyT3igZmbVrOlU8eH
 ZUxleN6FWs3SprCwYiBtfGg5PGLVL5VA5Y/F72p2SzpqRWlig1wUE82w2dyvp+FGU2ru
 NKh6TJ9LMYoK45d+kirkF54PXD8q+XHbd4W9qN6mtPqKeHfuSpnhl6KTPN22ubYXF1xV
 J+aR0fynvwuhH8ma1JDsdmQ7Unni7Dgyrs/z2ZwBeRMbNvnLx50JGgqj9egJawrpFcBW
 TLWgBtZG1GZ51Drr/3FlruJEYATA15a7zw5Y6ePmXMuZrvfVUszqhdXMtASw8IQBKREw
 mBXA==
X-Gm-Message-State: AOJu0Yzp0//CGR6OaHYSFQzlFMnC99+77U5mrapPJM7GGZH0VTjnVhg5
 AgDzz9wLSYpQpf0rR2vBPPnMMO92/PHEpJw4la2eD6D6mAgvI0T+qbdLk1U3ZbAIZYi+HXYRRYh
 4Ql/Q
X-Gm-Gg: AZuq6aKsg5wo/nBCp0ZwCyW8fJ3MaxaFI0+rVxRswhvkM2kqYpemzh2yOUTCvc1b8uj
 rpCt0sjT0u46zqQuwJBiwRX0GDRab7GCZLMs7UTNgTVrrKY0tlIvp8GD9stfrDnB0J5BlqxA3pU
 H6oJi1INNNYVJ09gAp8n9eEgffRYmj5UnxqxtP2CMousVfnKHxuZ9YCdh54rx3UIGTO1yUpiClp
 eSq+m3JfUJMXRM1w33wIjSkQjBcEZolf5fY/tbh8BBjskYAEstItTocoJNYgdxHZjrdYe1f4uiH
 RFO5bQH+vq4wxKQnsXgYOt6KKh8D11DFD1vEEXsYqbDoC6Z6E1FKw5PDL53R3YCkhpdkR5Qki48
 h6hgYQtQmu38pwVJ7TXE6qS4effB/93kdrtl3Z+T7WoIubaBjjMfZI1AxMMv1CZYrmC+TsYUPLi
 6FoLQkXHMrJ7kKgkDW4r3dlYAQDn2GrFS+6WZSxXeJK2c1wQ==
X-Received: by 2002:a05:600c:21ce:b0:477:9a61:fd06 with SMTP id
 5b1f17b1804b1-48069e33806mr24499345e9.8.1769539671008; 
 Tue, 27 Jan 2026 10:47:51 -0800 (PST)
Received: from claret.liberouter.org (rt-tmc-kou.liberouter.org.
 [195.113.172.126]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e131ce70sm716958f8f.27.2026.01.27.10.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 10:47:50 -0800 (PST)
From: Lukas Sismis <sismis@dyna-nic.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org,
	Lukas Sismis <sismis@dyna-nic.com>
Subject: [PATCH v5 5/6] examples/flow_parsing: add flow parser demo
Date: Tue, 27 Jan 2026 19:47:36 +0100
Message-ID: <20260127184738.200476-6-sismis@dyna-nic.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260127184738.200476-1-sismis@dyna-nic.com>
References: <20260127184738.200476-1-sismis@dyna-nic.com>
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
 examples/flow_parsing/main.c      | 291 ++++++++++++++++++++++++++++++
 examples/flow_parsing/meson.build |  11 ++
 examples/meson.build              |   1 +
 4 files changed, 304 insertions(+)
 create mode 100644 examples/flow_parsing/main.c
 create mode 100644 examples/flow_parsing/meson.build

diff --git a/MAINTAINERS b/MAINTAINERS
index 5f477ab662..36e9f3af2c 100644
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
index 0000000000..4afa578e37
--- /dev/null
+++ b/examples/flow_parsing/main.c
@@ -0,0 +1,291 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 DynaNIC
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
+#include <arpa/inet.h>
+
+#include <rte_common.h>
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
+				char src[INET_ADDRSTRLEN], dst[INET_ADDRSTRLEN];
+				inet_ntop(AF_INET, &ipv4->hdr.src_addr, src, sizeof(src));
+				inet_ntop(AF_INET, &ipv4->hdr.dst_addr, dst, sizeof(dst));
+				printf(" src=%s dst=%s\n", src, dst);
+			} else {
+				printf(" (any)\n");
+			}
+			break;
+		case RTE_FLOW_ITEM_TYPE_TCP:
+			printf("    [%u] TCP", i);
+			if (item->spec) {
+				const struct rte_flow_item_tcp *tcp = item->spec;
+				printf(" sport=%u dport=%u\n",
+				       ntohs(tcp->hdr.src_port),
+				       ntohs(tcp->hdr.dst_port));
+			} else {
+				printf(" (any)\n");
+			}
+			break;
+		case RTE_FLOW_ITEM_TYPE_UDP:
+			printf("    [%u] UDP", i);
+			if (item->spec) {
+				const struct rte_flow_item_udp *udp = item->spec;
+				printf(" sport=%u dport=%u\n",
+				       ntohs(udp->hdr.src_port),
+				       ntohs(udp->hdr.dst_port));
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
index 0000000000..3cc59fcae0
--- /dev/null
+++ b/examples/flow_parsing/meson.build
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 DynaNIC
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

