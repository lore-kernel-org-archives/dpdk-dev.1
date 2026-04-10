Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA28BF45A0E
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Apr 2026 20:16:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A35BC40661;
	Fri, 10 Apr 2026 22:16:10 +0200 (CEST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 8E18A40654
 for <dev@dpdk.org>; Fri, 10 Apr 2026 22:16:04 +0200 (CEST)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-48374014a77so34047055e9.3
 for <dev@dpdk.org>; Fri, 10 Apr 2026 13:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1775852164; x=1776456964; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oGdd9nR/1yaK+48t8q9T1aTevxhJeH9GKc7zIquH5qk=;
 b=x8dxoAmXmA6Dxk4ILeI5YsQVKk/wlXIeLvBb3LKpjqNJdrTnokbTewg54xo0C0ep93
 MVmcGigwRfkNaHSzsQHc5Bd7vVg9OumKpKiUOEjhrotNVjUdAfTaOOubNNLfWvzzrGfQ
 bdKgLzwwnwEsDuvYHu6D105yr5Ryz1Rq+cL71+6O1vcLEug/Pw1mAD0VfS/d0YN5Pkux
 54ZeWi5VznShZa0WEohUrTYYzlHqdaZl3lCEMb6T/hA06rcOjHA8EZ68F0m8OMylVplr
 SKQOq1gmHxqDFd1GdbbAwDs6QmsB4ErGZOeVvtwGdN/rLgvhNIWxP77YRqGStjLj+H4y
 iRiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775852164; x=1776456964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oGdd9nR/1yaK+48t8q9T1aTevxhJeH9GKc7zIquH5qk=;
 b=ol9EQVeHHOg8ra14A3pSCjGfRADKOHE6wKlLpt12qy0ym99z167ykuCxXNeY1UANlg
 yQ4V2HWrbf+jSzre7IbTaRBWIURyhCf2WpQbXROHYP5+s5ui1yLF6dmSxSqSkERWkS6i
 mjUbhhZ1zr03YS7GqGme1bvid96w/r3P8VQly7iyIT5Tk3L/VTjltCjbTlyH/axBnw93
 Ib/B85R8wBhNvPQbQ0Rt04uWAAY4wiChUsHWINKq/1/HIcivwCDUYf5BHvh8mLyNTfZi
 u+DQAiUPwTLlyIYDXCPlaEzTeNozn+6V7+4yVZ+UI9onJ3QwKoAK1KZyeIwobSIBPI/U
 NbOQ==
X-Gm-Message-State: AOJu0YzgTlxjmIBFhvwXvsPybZrhlFZHJuQn+ckoooUMg8G1R1cLWTO8
 5sPWew9D3SXOgMlSjDcPLYtYk6vC/kfYWTDX5xDsYxmtLFqvfTs5x1zWUPiip1PYgTz7r+KYrti
 tqa5G
X-Gm-Gg: AeBDietmti3MYDpYZk4N5qUeRM44wMmf90LAGxk6rxNjo1UKfUymupU4ri4tEuTYPl8
 U1vILYI92L15qJQnpb6Fv/qzU5QXDLb0mkSKqMEoXvR1+3sUc/+RNJckUBKJuiVjw9+lBKyichn
 zU33UUeV4YNhIcQkHQTPaZzSeeVIFFlL0fLrKzy+RrQfRteA2ZCtOE9YlhUXyrrLCFEGdijuobd
 TZhZNsBTUn+pBvwwKsMqFVXEkZHxx2x2mHjnyvowb1g3A1/QPmSSlAWkRidQpaOcmze4FLwBudW
 bCQaHkWdewkizwuHgupJFfeSz5O77YoqnNkOTSaBTr6NkQYhgjq9lAlA2yCnCqv5z0xY2RtW6jn
 i0yRuQdyBXmNsT5ggLb5tvwTK7Wc1FWPS0UmRhAVsGMQCCEmSOBiGrl0omESAzBHZl4+7bhu3th
 xt1S9U2RzCWfvr2A+QzFuGl0Zfql0pkwDzCpC77x+pgE0jlyN63wsGGXtp2maznpY=
X-Received: by 2002:a05:600c:a010:b0:487:300:d9ca with SMTP id
 5b1f17b1804b1-488d68af201mr65526715e9.31.1775852164024; 
 Fri, 10 Apr 2026 13:16:04 -0700 (PDT)
Received: from dpdk-test6.liberouter.org (rt-tmc-kou.liberouter.org.
 [195.113.172.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d684406bsm26044405e9.24.2026.04.10.13.16.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 13:16:03 -0700 (PDT)
From: Lukas Sismis <sismis@dyna-nic.com>
To: orika@nvidia.com
Cc: dev@dpdk.org, stephen@networkplumber.org, thomas@monjalon.net,
 Lukas Sismis <sismis@dyna-nic.com>
Subject: [PATCH v11 5/6] examples/flow_parsing: add flow parser demo
Date: Fri, 10 Apr 2026 22:15:43 +0200
Message-ID: <2f8bb5e8983c0bb827fcd98cbfce90b2ecef45cf.1775850858.git.sismis@dyna-nic.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1775850858.git.sismis@dyna-nic.com>
References: <cover.1775850858.git.sismis@dyna-nic.com>
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

Add a standalone example demonstrating the flow parser API.
Parses attribute, pattern, and action strings into rte_flow
structures and prints the results.

Signed-off-by: Lukas Sismis <sismis@dyna-nic.com>
---
 MAINTAINERS                               |   2 +
 doc/guides/sample_app_ug/flow_parsing.rst |  60 ++++
 doc/guides/sample_app_ug/index.rst        |   1 +
 examples/flow_parsing/main.c              | 409 ++++++++++++++++++++++
 examples/flow_parsing/meson.build         |   8 +
 examples/meson.build                      |   1 +
 6 files changed, 481 insertions(+)
 create mode 100644 doc/guides/sample_app_ug/flow_parsing.rst
 create mode 100644 examples/flow_parsing/main.c
 create mode 100644 examples/flow_parsing/meson.build

diff --git a/MAINTAINERS b/MAINTAINERS
index fdd0555bb4..fdd841c835 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -448,6 +448,8 @@ F: doc/guides/prog_guide/ethdev/flow_offload.rst
 F: doc/guides/prog_guide/flow_parser_lib.rst
 F: app/test-pmd/flow_parser*
 F: lib/ethdev/rte_flow*
+F: doc/guides/sample_app_ug/flow_parsing.rst
+F: examples/flow_parsing/
 
 Traffic Management API
 M: Cristian Dumitrescu <cristian.dumitrescu@intel.com>
diff --git a/doc/guides/sample_app_ug/flow_parsing.rst b/doc/guides/sample_app_ug/flow_parsing.rst
new file mode 100644
index 0000000000..a037951c5e
--- /dev/null
+++ b/doc/guides/sample_app_ug/flow_parsing.rst
@@ -0,0 +1,60 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+    Copyright(c) 2026 DynaNIC Semiconductors, Ltd.
+
+Flow Parsing Sample Application
+================================
+
+Overview
+--------
+
+The flow parsing sample application demonstrates how to use the ethdev flow
+parser library to convert testpmd-style flow rule strings into ``rte_flow`` C
+structures without requiring EAL initialization.
+
+
+Compiling the Application
+-------------------------
+
+To compile the sample application, see :doc:`compiling`.
+
+The application is located in the ``flow_parsing`` sub-directory.
+
+
+Running the Application
+-----------------------
+
+Since this example does not use EAL, it can be run directly:
+
+.. code-block:: console
+
+   ./build/examples/dpdk-flow_parsing
+
+The application prints parsed attributes, patterns, and actions for several
+example flow rule strings.
+
+
+Example Output
+--------------
+
+.. code-block:: none
+
+   === Parsing Flow Attributes ===
+   Input: "ingress"
+     Attributes:
+       group=0 priority=0
+       ingress=1 egress=0 transfer=0
+
+   === Parsing Flow Patterns ===
+   Input: "eth / ipv4 src is 192.168.1.1 / end"
+     Pattern (3 items):
+       [0] ETH (any)
+       [1] IPV4 src=192.168.1.1 dst=0.0.0.0
+       [2] END
+
+   === Parsing Flow Actions ===
+   Input: "mark id 100 / count / queue index 5 / end"
+     Actions (4 items):
+       [0] MARK id=100
+       [1] COUNT
+       [2] QUEUE index=5
+       [3] END
diff --git a/doc/guides/sample_app_ug/index.rst b/doc/guides/sample_app_ug/index.rst
index e895f692f9..eadea67569 100644
--- a/doc/guides/sample_app_ug/index.rst
+++ b/doc/guides/sample_app_ug/index.rst
@@ -16,6 +16,7 @@ Sample Applications User Guides
     skeleton
     rxtx_callbacks
     flow_filtering
+    flow_parsing
     ip_frag
     ipv4_multicast
     ip_reassembly
diff --git a/examples/flow_parsing/main.c b/examples/flow_parsing/main.c
new file mode 100644
index 0000000000..784fc97a50
--- /dev/null
+++ b/examples/flow_parsing/main.c
@@ -0,0 +1,409 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 DynaNIC Semiconductors, Ltd.
+ */
+
+/*
+ * Flow Parsing Example
+ * ====================
+ * This example demonstrates how to use the ethdev flow parser to parse
+ * flow rule strings into rte_flow C structures. The library provides ONE WAY
+ * to create rte_flow structures - by parsing testpmd-style command strings.
+ *
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
+#include <rte_flow_parser_cmdline.h>
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
+
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
+
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
+
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
+
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
+
+				printf("    [%u] QUEUE index=%u\n", i, q->index);
+			} else {
+				printf("    [%u] QUEUE\n", i);
+			}
+			break;
+		case RTE_FLOW_ACTION_TYPE_MARK:
+			if (action->conf) {
+				const struct rte_flow_action_mark *m = action->conf;
+
+				printf("    [%u] MARK id=%u\n", i, m->id);
+			} else {
+				printf("    [%u] MARK\n", i);
+			}
+			break;
+		case RTE_FLOW_ACTION_TYPE_COUNT:
+			printf("    [%u] COUNT\n", i);
+			break;
+		case RTE_FLOW_ACTION_TYPE_PORT_ID:
+			if (action->conf) {
+				const struct rte_flow_action_port_id *p = action->conf;
+
+				printf("    [%u] PORT_ID id=%u\n", i, p->id);
+			} else {
+				printf("    [%u] PORT_ID\n", i);
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
+ * Demonstrate full command parsing
+ */
+static void
+demo_full_command_parse(void)
+{
+	uint8_t buf[4096];
+	struct rte_flow_parser_output *out = (void *)buf;
+	int ret;
+
+	static const char * const commands[] = {
+		"flow create 0 ingress pattern eth / ipv4 / end actions drop / end",
+		"flow validate 0 ingress pattern eth / ipv4 / tcp dst is 80 / end actions queue index 3 / end",
+		"flow list 0",
+		"flow flush 0",
+	};
+
+	printf("\n=== Full Command Parsing ===\n");
+	printf("Use rte_flow_parser_parse() from rte_flow_parser_cmdline.h\n");
+	printf("to parse complete flow CLI commands.\n\n");
+
+	for (unsigned int i = 0; i < RTE_DIM(commands); i++) {
+		printf("Input: \"%s\"\n", commands[i]);
+		memset(buf, 0, sizeof(buf));
+		ret = rte_flow_parser_parse(commands[i], out, sizeof(buf));
+		if (ret == 0) {
+			printf("  command=%d port=%u\n",
+			       out->command, out->port);
+			if (out->command == RTE_FLOW_PARSER_CMD_CREATE ||
+			    out->command == RTE_FLOW_PARSER_CMD_VALIDATE)
+				printf("  pattern_n=%u actions_n=%u\n",
+				       out->args.vc.pattern_n,
+				       out->args.vc.actions_n);
+		} else {
+			printf("  ERROR: %d (%s)\n", ret, strerror(-ret));
+		}
+		printf("\n");
+	}
+}
+
+/*
+ * Demonstrate configuration registration
+ */
+static void
+demo_config_registration(void)
+{
+	static struct rte_flow_parser_vxlan_encap_conf vxlan;
+	static struct rte_flow_parser_raw_encap_data raw_encap[2];
+	const struct rte_flow_item *items;
+	uint32_t items_n;
+	int ret;
+
+	printf("\n=== Configuration Registration ===\n");
+	printf("Applications own config storage and register it\n");
+	printf("with rte_flow_parser_config_register().\n\n");
+
+	memset(raw_encap, 0, sizeof(raw_encap));
+
+	struct rte_flow_parser_config cfg = {
+		.vxlan_encap = &vxlan,
+		.raw_encap = { raw_encap, 2 },
+	};
+	ret = rte_flow_parser_config_register(&cfg);
+	printf("config_register: %s\n\n", ret == 0 ? "OK" : "FAILED");
+
+	/* Write directly to app-owned config */
+	vxlan.select_ipv4 = 1;
+	vxlan.vni[0] = 0x12;
+	vxlan.vni[1] = 0x34;
+	vxlan.vni[2] = 0x56;
+	/*
+	 * Parse a flow rule that references vxlan_encap.
+	 * The parser reads the config we just wrote above.
+	 */
+	uint8_t buf[4096];
+	struct rte_flow_parser_output *out = (void *)buf;
+
+	ret = rte_flow_parser_parse(
+		"flow create 0 transfer pattern eth / end "
+		"actions vxlan_encap / port_id id 1 / end",
+		out, sizeof(buf));
+	if (ret == 0 && out->args.vc.actions_n > 0) {
+		const struct rte_flow_action *act = &out->args.vc.actions[0];
+
+		printf("Parsed vxlan_encap action: type=%d conf=%s\n",
+		       act->type, act->conf ? "present" : "NULL");
+		if (act->conf) {
+			const struct rte_flow_action_vxlan_encap *ve =
+				act->conf;
+			const struct rte_flow_item *item = ve->definition;
+			unsigned int n = 0;
+
+			printf("  Encap tunnel headers:");
+			while (item && item->type != RTE_FLOW_ITEM_TYPE_END) {
+				printf(" 0x%02x", item->type);
+				item++;
+				n++;
+			}
+			printf(" (%u items)\n", n);
+		}
+	} else {
+		printf("vxlan_encap parse: %s\n",
+		       ret == 0 ? "no actions" : strerror(-ret));
+	}
+
+	printf("VXLAN config: ipv4=%u vni=0x%02x%02x%02x\n",
+	       vxlan.select_ipv4,
+	       vxlan.vni[0], vxlan.vni[1], vxlan.vni[2]);
+	printf("\n");
+
+	/* Use setter API for raw encap */
+	ret = rte_flow_parser_parse_pattern_str(
+		"eth / ipv4 / udp / vxlan / end", &items, &items_n);
+	if (ret == 0) {
+		ret = rte_flow_parser_raw_encap_conf_set(0, items, items_n);
+		printf("raw_encap_conf_set: %s\n",
+		       ret == 0 ? "OK" : "FAILED");
+	}
+
+	const struct rte_flow_action_raw_encap *encap =
+		rte_flow_parser_raw_encap_conf(0);
+	if (encap != NULL)
+		printf("raw_encap[0]: %zu bytes serialized\n", encap->size);
+	printf("\n");
+}
+
+int
+main(void)
+{
+	printf("Flow Parser Library Example\n");
+	printf("===========================\n");
+
+	/* Run demonstrations */
+	demo_parse_attr();
+	demo_parse_pattern();
+	demo_parse_actions();
+	demo_config_registration();
+	demo_full_command_parse();
+
+	printf("\n=== Example Complete ===\n");
+	return 0;
+}
diff --git a/examples/flow_parsing/meson.build b/examples/flow_parsing/meson.build
new file mode 100644
index 0000000000..83554409d1
--- /dev/null
+++ b/examples/flow_parsing/meson.build
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 DynaNIC Semiconductors, Ltd.
+
+# meson file, for building this example as part of a main DPDK build.
+
+allow_experimental_apis = true
+deps += 'ethdev'
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

