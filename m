Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED52ECE9D64
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Jan 2026 15:39:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A88640A81;
	Tue,  6 Jan 2026 16:39:00 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 3F81940A73
 for <dev@dpdk.org>; Tue,  6 Jan 2026 16:38:59 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-477bf34f5f5so10127525e9.0
 for <dev@dpdk.org>; Tue, 06 Jan 2026 07:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1767713938; x=1768318738; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4w1sLrGXVlzDYmNtlOcb7jiVhx/5m0zecqzMLtrzfoU=;
 b=ZaHtMV3qZM9Wk40b1WIugbs9iz6zBS9e/0GqztOEzrQy9+rezbSmT4d85I4Cx+AleC
 cejJEbd4uRHqgmhQ7nzzO7+oqX2QbQDl9ldnIRp6CFlxDxsG5ugsNp+mVZfYk/fnm02q
 rHtyuypJwAhSxUXMkZgmDgW6byHLYWeNjti65eDPEM86e9X3dHrNS1A+aAAMvkrcBzf9
 D+knT6ZXOWVfmu7h7HQcT5oPDUY+RqXmCvshMZIg8cIm213xn5hCzYail9JSElM6Oefb
 VWWTXPKX4aCR42ve4PvVTmwTY6dLiaFIW7UWSpLFPDe2+ikP0OdcXXOQB/ycU0Cgi3Ll
 /qAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767713938; x=1768318738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4w1sLrGXVlzDYmNtlOcb7jiVhx/5m0zecqzMLtrzfoU=;
 b=cRELrOg9ipyEZTJCQutYVysmDZR2u5R7WjpoDJxvleKMQ5kELawl/KkPcPHBKZarqf
 5C0Q7Otzhu+daO1jn5Em/71ck7SZsQJeVJtMllw7zqAmNNC+YWVHpbFURUZTd3WxVrNY
 LujpeRCAfu4DapoSeXvd4luNRDObjS53a47ALhnDK3X8Jwv0yuKS/uegzkmugyBxzpkN
 jikgru7RBnEE0G4V4K2hF/d0/wtjoXS64beMY57gSWRaCBwI0wQtH8MMbNgI2fm/MnZr
 gcaSeFB3AISvWP+K27qxAbxThoYVJpJLhcSOzWwbpop6l2jGxWu+xL0Lw/bXYK7tgeyG
 Nhrg==
X-Gm-Message-State: AOJu0Yy3Sx4ojxcEPNj9RxhfS/IoJkhv0qw8Wq/lZB3cyWQBeLNXb8cc
 8puPffjMDXQIKTtPt4fjJfgmpCAgEIDFsAoXrvR6jLzhAUL/2IAgqDOfUie/fNSLPjVeR2wmroS
 HA+fu
X-Gm-Gg: AY/fxX4Mj5+tGuhyyczJKyAJJbAr2ZQ05dXYUCYOyLCWmc+23jZSDBc2P4Y6NLJBnAU
 HBf6S65j7u8EpigkZRU61qh4bGPc0U1gzEGFC2CgZ/tqtujUASTeYYC3pcE+mDL3Hl1961aw3Y1
 4M+5hQtziwWZdJLsPRzlABPdumAI81OWfX+e5uop0sgYkk5vWgq2HKBPZYqu706pwt+pEx+OZrY
 VH9mcXYtTBmoSMzsEVcagFOKQfv0DESPGrbyGcuKHNMK6BBBCqdWIpJg+6pE7/SEYqneCsfCLKZ
 BZZQXMrtviw0pw9vIXALgxWUZ2TUbpb2SCYZllsnyCeFtisSKpMpa9UP9z8owxdCkEo7OC92WWP
 I5RuOLoMLUBolGqQftvQP3hsSleCjgt7BAccloP2m+xBpoCI4mwn6uRh9EiAIj66Llm2YboFINd
 5UX8Fv44yHqJe9AAjv9AobI806/99Y/anShPDZLjtmyUIsESd8Agdi2MJ4
X-Google-Smtp-Source: AGHT+IGn+DaZoiBFyfLe6HbyBSpNfy1Q1AHFiUSJguWiQ451j101jpBCaXDnCbFNItqaxARiSjUbFw==
X-Received: by 2002:a05:600c:46ce:b0:477:7bca:8b34 with SMTP id
 5b1f17b1804b1-47d7f0644c1mr39817665e9.6.1767713938286; 
 Tue, 06 Jan 2026 07:38:58 -0800 (PST)
Received: from claret.liberouter.org (rt-tmc-kou.liberouter.org.
 [195.113.172.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7fad882asm20975265e9.1.2026.01.06.07.38.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 07:38:57 -0800 (PST)
From: Lukas Sismis <sismis@dyna-nic.com>
To: dev@dpdk.org
Cc: Lukas Sismis <sismis@dyna-nic.com>
Subject: [PATCH v2 3/7] examples/flow_parsing: add flow parser demo
Date: Tue,  6 Jan 2026 16:38:33 +0100
Message-ID: <20260106153838.398033-4-sismis@dyna-nic.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260106153838.398033-1-sismis@dyna-nic.com>
References: <20260106153838.398033-1-sismis@dyna-nic.com>
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

The example shows:
- Using parse_attr_str() to parse flow attributes from strings
- Using parse_pattern_str() to parse match patterns
- Using parse_actions_str() to parse flow actions
- Printing parsed results with RTE_FLOW_LOG macros
- Integration without EAL initialization (library is standalone)

Build with: meson configure -Dexamples=flow_parsing

Signed-off-by: Lukas Sismis <sismis@dyna-nic.com>
---
 app/test-pmd/flow_parser.h        |   2 +-
 examples/flow_parsing/main.c      | 345 ++++++++++++++++++++++++++++++
 examples/flow_parsing/meson.build |  11 +
 examples/meson.build              |   1 +
 4 files changed, 358 insertions(+), 1 deletion(-)
 create mode 100644 examples/flow_parsing/main.c
 create mode 100644 examples/flow_parsing/meson.build

diff --git a/app/test-pmd/flow_parser.h b/app/test-pmd/flow_parser.h
index 8b5c99cd8b..2f77bc45e8 100644
--- a/app/test-pmd/flow_parser.h
+++ b/app/test-pmd/flow_parser.h
@@ -5,4 +5,4 @@
 
 #include <rte_flow_parser.h>
 
-#endif /* _TESTPMD_FLOW_PARSER_H_ */
\ No newline at end of file
+#endif /* _TESTPMD_FLOW_PARSER_H_ */
diff --git a/examples/flow_parsing/main.c b/examples/flow_parsing/main.c
new file mode 100644
index 0000000000..9f48e35ed1
--- /dev/null
+++ b/examples/flow_parsing/main.c
@@ -0,0 +1,345 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Dyna-NIC
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
+ */
+
+#include <stdio.h>
+#include <stdint.h>
+#include <string.h>
+#include <arpa/inet.h>
+
+#include <rte_common.h>
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
+print_mac(const char *label, const uint8_t *mac)
+{
+	printf("    %s: %02x:%02x:%02x:%02x:%02x:%02x\n", label,
+	       mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
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
+				print_mac("dst", eth->hdr.dst_addr.addr_bytes);
+				print_mac("src", eth->hdr.src_addr.addr_bytes);
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
+/*
+ * Demonstrate combining parsed components
+ *
+ * NOTE: The parse functions return pointers to internal static buffers.
+ * Each subsequent parse call overwrites the previous result.
+ * Therefore, you must use the returned data before calling another parse function,
+ * or copy the data to your own storage.
+ */
+static void
+demo_combine(void)
+{
+	struct rte_flow_attr attr;
+	const struct rte_flow_item *pattern;
+	const struct rte_flow_action *actions;
+	uint32_t pattern_n, actions_n;
+	int ret;
+
+	printf("\n=== Combining Parsed Components ===\n");
+	printf("Parse attributes, patterns, and actions separately,\n");
+	printf("then use each result before the next parse call.\n\n");
+	printf("NOTE: Returned pointers are only valid until the next parse call!\n\n");
+
+	/* Parse and display attributes */
+	ret = rte_flow_parser_parse_attr_str("ingress priority 1", &attr);
+	if (ret != 0) {
+		printf("Failed to parse attributes: %d\n", ret);
+		return;
+	}
+	printf("Parsed attributes:\n");
+	print_attr(&attr);
+
+	/* Parse and display pattern */
+	ret = rte_flow_parser_parse_pattern_str(
+		"eth / ipv4 src is 192.168.1.0 / tcp dst is 443 / end",
+		&pattern, &pattern_n);
+	if (ret != 0) {
+		printf("Failed to parse pattern: %d\n", ret);
+		return;
+	}
+	printf("\nParsed pattern:\n");
+	print_pattern(pattern, pattern_n);
+
+	/* Parse and display actions */
+	ret = rte_flow_parser_parse_actions_str(
+		"mark id 1 / queue index 2 / end",
+		&actions, &actions_n);
+	if (ret != 0) {
+		printf("Failed to parse actions: %d\n", ret);
+		return;
+	}
+	printf("\nParsed actions:\n");
+	print_actions(actions, actions_n);
+
+	printf("\nIn a real application, copy pattern/actions to your own storage,\n");
+	printf("then call:\n");
+	printf("  rte_flow_validate(port_id, &attr, pattern, actions, &error)\n");
+	printf("  rte_flow_create(port_id, &attr, pattern, actions, &error)\n");
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
+	demo_combine();
+
+	printf("\n=== Example Complete ===\n");
+	return 0;
+}
diff --git a/examples/flow_parsing/meson.build b/examples/flow_parsing/meson.build
new file mode 100644
index 0000000000..deab338bfb
--- /dev/null
+++ b/examples/flow_parsing/meson.build
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2024 Intel Corporation
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

