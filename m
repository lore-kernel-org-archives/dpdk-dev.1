Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2DBF45A0A
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Apr 2026 20:16:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79F434066B;
	Fri, 10 Apr 2026 22:16:11 +0200 (CEST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id C5C9140654
 for <dev@dpdk.org>; Fri, 10 Apr 2026 22:16:08 +0200 (CEST)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-488d2079582so21591455e9.2
 for <dev@dpdk.org>; Fri, 10 Apr 2026 13:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1775852168; x=1776456968; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bCQeLMn96eq+tE1onSsVRrT6F1Wv0IVZ6rCB1WS+ZEc=;
 b=yOSDk1N73ajwwoKzu+3R/lVyaX9cxndneEvmCuiLobGI0gru7KNrlgGE/N5L1nkJhv
 8UgKhU7eBPxT3w6sc91EGoJU0ivFVhPGMkGmbdT0BMt45Kb43dAdgNndpcIiVvNUpaI1
 Hy2kuWG4uTxP4NSAFhFf/5gZNtWBG9Ecb3fFVrRdjn7H5VlsTbJ9RSiREUX6Kdz6vT7s
 SYQVArhLPTYvnwFepyudNuGj1v4kmyyW5CDSlMgzR/naJ0BnZm6XYtx5F4XMAgL3945j
 l2j1H6f8lUuU5VyXtt4quDivvfpvQoSRlI7FMo5p+0yI6lHed2SFTTuYXE7NyJzRodqN
 eWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775852168; x=1776456968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bCQeLMn96eq+tE1onSsVRrT6F1Wv0IVZ6rCB1WS+ZEc=;
 b=BYk1YcdIvTzOPWtkQ0ZrFbA9NZBSUeqWpJ5zTMUHzyH3GjerVUKALzK9IMbUfaYhO/
 zecpYq49n5JsZ3Udje9MvWpMh312ObDRbm8BJT5vfN1gNK/ZQ2LFQQXEf+LmRtmEsnnS
 EP4Z5k/0aLwPeeiThkRFQDrEHNIeiltKPqoKQ31o0/6fp6Mgn/hyKsdcxAjT+Q4umQBA
 IEkssM5sLAhDAPLOt2BS3vtg1VRcCxFbPTjs812mTX1Fjl4OsaXQVK6Iy6s8Hy1Q/+kV
 sre0hKjuA/Yw5Wlb8n67gH9XrTpYa1tHzTCZTJ+Xx3Li4uP9EUfr4l4MczNsAbrkbXu0
 +D6w==
X-Gm-Message-State: AOJu0YyhGIXtGcxbtmIVISK9/tQNKZnaxuB7o6spYknbidq5VsaUSMW0
 2d/YDv6zpWYURL9rBb02xoNWi3dLbiPE4rDs066SDbtPSsdrBv96KjP2Lv+JUH3lFKQ=
X-Gm-Gg: AeBDieuUL4zL2ih1pQJzaAcbbrKTfTZK2kAdnM2J2wUP/3Ne16R/zbSKsQxfPZesZhe
 L/Bmoo19Z8J2XupHO1/jCuJvNaBIX8twsBAWRotEQF0o8mOh02CI/YuYfz6if/IVQ2v6b7lMl9E
 obvIbNKOVoWANcDpUIZLb3U8UrSjkQFgBu5q1XVNSlG4qPEVHvsgS+CM5T6yP/ix4ZbxEb41jWS
 6SYZ1TmVGIJ3fjJP5L71JR3cJUIxi6cz1VIL0XyenflnJm5vqyRvBw9qYdcdQBhuwF1C6kVzh1I
 SGE4Z7iB0ZPhJaQE2CHIMdG4vf0oq4WKinmh9vJ4Dr+kHvr0aREGB/CoUH5FSkRTwvXW+sYKvNu
 0g4O9xG11XQ6RuxPF1Ntp1InzTGuTt3x7jLhWHAgZK2u1dvixtvDSa+4rXbUaubP5Fgi5LTpjci
 zY0MXkFS5HFN944il8G4SoF52+qMexjZyUuDh/8hgiJ0AJn14XuyEIktanyEY5zBQ=
X-Received: by 2002:a05:600c:3f0d:b0:485:40fd:8390 with SMTP id
 5b1f17b1804b1-488d68769f9mr53664775e9.26.1775852167750; 
 Fri, 10 Apr 2026 13:16:07 -0700 (PDT)
Received: from dpdk-test6.liberouter.org (rt-tmc-kou.liberouter.org.
 [195.113.172.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d684406bsm26044405e9.24.2026.04.10.13.16.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 13:16:07 -0700 (PDT)
From: Lukas Sismis <sismis@dyna-nic.com>
To: orika@nvidia.com
Cc: dev@dpdk.org, stephen@networkplumber.org, thomas@monjalon.net,
 Lukas Sismis <sismis@dyna-nic.com>
Subject: [PATCH v11 6/6] test: add flow parser functional tests
Date: Fri, 10 Apr 2026 22:15:44 +0200
Message-ID: <396777ba10f689eac04526afbc5896e48309bfb6.1775850858.git.sismis@dyna-nic.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1775850858.git.sismis@dyna-nic.com>
References: <cover.1775850858.git.sismis@dyna-nic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Unit tests covering:

- Simple API: parse_attr_str, parse_pattern_str,
  parse_actions_str, parse_flow_rule
- Cmdline API: rte_flow_parser_parse with flow create,
  validate, indirect_action, meter, modify_field, queue,
  and port_id commands
- Setter APIs: raw_encap/decap set + get round-trip,
  boundary checks for out-of-range indices
- Config registration: pointer identity verification
- Cmdline integration: dynamic token population

Simple API tests work without config registration.

Signed-off-by: Lukas Sismis <sismis@dyna-nic.com>
---
 MAINTAINERS                        |   1 +
 app/test/meson.build               |   2 +
 app/test/test_flow_parser.c        | 791 +++++++++++++++++++++++++++++
 app/test/test_flow_parser_simple.c | 445 ++++++++++++++++
 4 files changed, 1239 insertions(+)
 create mode 100644 app/test/test_flow_parser.c
 create mode 100644 app/test/test_flow_parser_simple.c

diff --git a/MAINTAINERS b/MAINTAINERS
index fdd841c835..42e3f7674b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -450,6 +450,7 @@ F: app/test-pmd/flow_parser*
 F: lib/ethdev/rte_flow*
 F: doc/guides/sample_app_ug/flow_parsing.rst
 F: examples/flow_parsing/
+F: app/test/test_flow_parser*
 
 Traffic Management API
 M: Cristian Dumitrescu <cristian.dumitrescu@intel.com>
diff --git a/app/test/meson.build b/app/test/meson.build
index 7d458f9c07..242527516d 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -88,6 +88,8 @@ source_file_deps = {
     'test_fib6_perf.c': ['fib'],
     'test_fib_perf.c': ['net', 'fib'],
     'test_flow_classify.c': ['net', 'acl', 'table', 'ethdev', 'flow_classify'],
+    'test_flow_parser.c': ['ethdev', 'cmdline'],
+    'test_flow_parser_simple.c': ['ethdev'],
     'test_func_reentrancy.c': ['hash', 'lpm'],
     'test_graph.c': ['graph'],
     'test_graph_feature_arc.c': ['graph'],
diff --git a/app/test/test_flow_parser.c b/app/test/test_flow_parser.c
new file mode 100644
index 0000000000..9eb1e7803e
--- /dev/null
+++ b/app/test/test_flow_parser.c
@@ -0,0 +1,791 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 DynaNIC Semiconductors, Ltd.
+ */
+
+#include <stdint.h>
+#include <inttypes.h>
+#include <string.h>
+#include <errno.h>
+
+#include <rte_byteorder.h>
+#include <rte_flow.h>
+#include <rte_flow_parser_cmdline.h>
+
+#include "test.h"
+
+static struct rte_flow_parser_vxlan_encap_conf test_vxlan_conf;
+static struct rte_flow_parser_nvgre_encap_conf test_nvgre_conf;
+static struct rte_flow_parser_l2_encap_conf test_l2_encap_conf;
+static struct rte_flow_parser_l2_decap_conf test_l2_decap_conf;
+static struct rte_flow_parser_mplsogre_encap_conf test_mplsogre_encap_conf;
+static struct rte_flow_parser_mplsogre_decap_conf test_mplsogre_decap_conf;
+static struct rte_flow_parser_mplsoudp_encap_conf test_mplsoudp_encap_conf;
+static struct rte_flow_parser_mplsoudp_decap_conf test_mplsoudp_decap_conf;
+static struct rte_flow_action_conntrack test_conntrack;
+
+static struct rte_flow_parser_raw_encap_data test_raw_encap[RAW_ENCAP_CONFS_MAX_NUM];
+static struct rte_flow_parser_raw_decap_data test_raw_decap[RAW_ENCAP_CONFS_MAX_NUM];
+static struct rte_flow_parser_ipv6_ext_push_data test_ipv6_push[IPV6_EXT_PUSH_CONFS_MAX_NUM];
+static struct rte_flow_parser_ipv6_ext_remove_data test_ipv6_remove[IPV6_EXT_PUSH_CONFS_MAX_NUM];
+static struct rte_flow_parser_sample_slot test_sample[RAW_SAMPLE_CONFS_MAX_NUM];
+
+static void test_dispatch_cb(const struct rte_flow_parser_output *in __rte_unused);
+static cmdline_parse_inst_t test_flow_inst;
+
+static void
+test_register_config(void)
+{
+	memset(&test_raw_encap, 0, sizeof(test_raw_encap));
+	memset(&test_raw_decap, 0, sizeof(test_raw_decap));
+	memset(&test_ipv6_push, 0, sizeof(test_ipv6_push));
+	memset(&test_ipv6_remove, 0, sizeof(test_ipv6_remove));
+	memset(&test_sample, 0, sizeof(test_sample));
+	memset(&test_conntrack, 0, sizeof(test_conntrack));
+	memset(&test_l2_encap_conf, 0, sizeof(test_l2_encap_conf));
+	memset(&test_l2_decap_conf, 0, sizeof(test_l2_decap_conf));
+	memset(&test_mplsogre_encap_conf, 0, sizeof(test_mplsogre_encap_conf));
+	memset(&test_mplsogre_decap_conf, 0, sizeof(test_mplsogre_decap_conf));
+	memset(&test_mplsoudp_encap_conf, 0, sizeof(test_mplsoudp_encap_conf));
+	memset(&test_mplsoudp_decap_conf, 0, sizeof(test_mplsoudp_decap_conf));
+
+	test_vxlan_conf = (struct rte_flow_parser_vxlan_encap_conf){
+		.select_ipv4 = 1,
+		.udp_dst = RTE_BE16(RTE_VXLAN_DEFAULT_PORT),
+		.ipv4_src = RTE_IPV4(127, 0, 0, 1),
+		.ipv4_dst = RTE_IPV4(255, 255, 255, 255),
+		.ip_ttl = 255,
+		.eth_dst = { .addr_bytes = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff } },
+	};
+	test_nvgre_conf = (struct rte_flow_parser_nvgre_encap_conf){
+		.select_ipv4 = 1,
+		.ipv4_src = RTE_IPV4(127, 0, 0, 1),
+		.ipv4_dst = RTE_IPV4(255, 255, 255, 255),
+		.eth_dst = { .addr_bytes = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff } },
+	};
+
+	struct rte_flow_parser_config cfg = {
+		.vxlan_encap = &test_vxlan_conf,
+		.nvgre_encap = &test_nvgre_conf,
+		.l2_encap = &test_l2_encap_conf,
+		.l2_decap = &test_l2_decap_conf,
+		.mplsogre_encap = &test_mplsogre_encap_conf,
+		.mplsogre_decap = &test_mplsogre_decap_conf,
+		.mplsoudp_encap = &test_mplsoudp_encap_conf,
+		.mplsoudp_decap = &test_mplsoudp_decap_conf,
+		.conntrack = &test_conntrack,
+		.raw_encap = { test_raw_encap, RAW_ENCAP_CONFS_MAX_NUM },
+		.raw_decap = { test_raw_decap, RAW_ENCAP_CONFS_MAX_NUM },
+		.ipv6_ext_push = { test_ipv6_push, IPV6_EXT_PUSH_CONFS_MAX_NUM },
+		.ipv6_ext_remove = { test_ipv6_remove, IPV6_EXT_PUSH_CONFS_MAX_NUM },
+		.sample = { test_sample, RAW_SAMPLE_CONFS_MAX_NUM },
+		.cmd_flow = &test_flow_inst,
+		.dispatch = test_dispatch_cb,
+	};
+	rte_flow_parser_config_register(&cfg);
+}
+
+static int
+flow_parser_setup(void)
+{
+	return 0;
+}
+
+static int
+flow_parser_case_setup(void)
+{
+	test_register_config();
+	return 0;
+}
+
+static void
+flow_parser_teardown(void)
+{
+	test_register_config();
+}
+
+/* Cmdline API tests */
+
+static int
+test_flow_parser_cmdline_command_mapping(void)
+{
+	static const char *create_cmd =
+		"flow create 0 ingress pattern eth / end "
+		"actions drop / end";
+	static const char *list_cmd = "flow list 0";
+	static const char *destroy_cmd = "flow destroy 0 rule 1";
+	static const char *flush_cmd = "flow flush 0";
+	static const char *validate_cmd =
+		"flow validate 0 ingress pattern eth / end actions drop / end";
+	uint8_t outbuf[4096];
+	struct rte_flow_parser_output *out = (void *)outbuf;
+	int ret;
+
+	ret = rte_flow_parser_parse(create_cmd, out, sizeof(outbuf));
+	TEST_ASSERT_SUCCESS(ret, "flow create parse failed: %s",
+		strerror(-ret));
+	TEST_ASSERT_EQUAL(out->command, RTE_FLOW_PARSER_CMD_CREATE,
+		"expected CREATE command, got %d", out->command);
+	TEST_ASSERT_EQUAL(out->port, 0, "expected port 0, got %u", out->port);
+	TEST_ASSERT_EQUAL(out->args.vc.pattern_n, 2,
+		"expected 2 pattern items, got %u", out->args.vc.pattern_n);
+	TEST_ASSERT_EQUAL(out->args.vc.pattern[0].type, RTE_FLOW_ITEM_TYPE_ETH,
+		"expected ETH pattern, got %d", out->args.vc.pattern[0].type);
+	TEST_ASSERT_EQUAL(out->args.vc.pattern[1].type, RTE_FLOW_ITEM_TYPE_END,
+		"expected END pattern, got %d", out->args.vc.pattern[1].type);
+	TEST_ASSERT_EQUAL(out->args.vc.actions_n, 2,
+		"expected 2 action items, got %u", out->args.vc.actions_n);
+	TEST_ASSERT_EQUAL(out->args.vc.actions[0].type,
+		RTE_FLOW_ACTION_TYPE_DROP,
+		"expected DROP action, got %d", out->args.vc.actions[0].type);
+	TEST_ASSERT_EQUAL(out->args.vc.actions[1].type,
+		RTE_FLOW_ACTION_TYPE_END,
+		"expected END action, got %d", out->args.vc.actions[1].type);
+	TEST_ASSERT(out->args.vc.attr.ingress == 1 &&
+		out->args.vc.attr.egress == 0,
+		"expected ingress=1 egress=0");
+
+	ret = rte_flow_parser_parse(list_cmd, out, sizeof(outbuf));
+	TEST_ASSERT_SUCCESS(ret, "flow list parse failed: %s", strerror(-ret));
+	TEST_ASSERT_EQUAL(out->command, RTE_FLOW_PARSER_CMD_LIST,
+		"expected LIST command, got %d", out->command);
+	TEST_ASSERT_EQUAL(out->port, 0, "expected port 0, got %u", out->port);
+
+	ret = rte_flow_parser_parse(destroy_cmd, out, sizeof(outbuf));
+	TEST_ASSERT_SUCCESS(ret, "flow destroy parse failed: %s",
+		strerror(-ret));
+	TEST_ASSERT_EQUAL(out->command, RTE_FLOW_PARSER_CMD_DESTROY,
+		"expected DESTROY command, got %d", out->command);
+
+	ret = rte_flow_parser_parse(flush_cmd, out, sizeof(outbuf));
+	TEST_ASSERT_SUCCESS(ret, "flow flush parse failed: %s", strerror(-ret));
+	TEST_ASSERT_EQUAL(out->command, RTE_FLOW_PARSER_CMD_FLUSH,
+		"expected FLUSH command, got %d", out->command);
+
+	ret = rte_flow_parser_parse(validate_cmd, out, sizeof(outbuf));
+	TEST_ASSERT_SUCCESS(ret, "flow validate parse failed: %s",
+		strerror(-ret));
+	TEST_ASSERT_EQUAL(out->command, RTE_FLOW_PARSER_CMD_VALIDATE,
+		"expected VALIDATE command, got %d", out->command);
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_flow_parser_cmdline_indirect_action(void)
+{
+	static const char *flow_indirect_sample =
+		"flow indirect_action 0 create transfer list "
+		"actions sample ratio 1 index 1 / jump group 2 / end";
+	uint8_t outbuf[8192];
+	struct rte_flow_parser_output *out = (void *)outbuf;
+	const struct rte_flow_action *actions;
+	const struct rte_flow_action_sample *sample_conf;
+	const struct rte_flow_action_ethdev *repr;
+	uint32_t actions_n;
+	int ret;
+
+	/* Pre-configure sample actions via the setter API. */
+	ret = rte_flow_parser_parse_actions_str(
+		"port_representor port_id 0xffff / end",
+		&actions, &actions_n);
+	TEST_ASSERT_SUCCESS(ret, "parse sample actions failed: %s",
+		strerror(-ret));
+
+	ret = rte_flow_parser_sample_actions_set(1, actions, actions_n);
+	TEST_ASSERT_SUCCESS(ret, "sample_actions_set failed: %s",
+		strerror(-ret));
+
+	/* Parse an indirect_action that references sample index 1. */
+	ret = rte_flow_parser_parse(flow_indirect_sample, out, sizeof(outbuf));
+	TEST_ASSERT_SUCCESS(ret, "indirect sample parse failed: %s",
+		strerror(-ret));
+	TEST_ASSERT(out->command == RTE_FLOW_PARSER_CMD_INDIRECT_ACTION_LIST_CREATE ||
+		out->command == RTE_FLOW_PARSER_CMD_INDIRECT_ACTION_CREATE ||
+		out->command == RTE_FLOW_PARSER_CMD_QUEUE_INDIRECT_ACTION_LIST_CREATE ||
+		out->command == RTE_FLOW_PARSER_CMD_QUEUE_INDIRECT_ACTION_CREATE,
+		"expected indirect action create command, got %d", out->command);
+	TEST_ASSERT(out->args.vc.actions_n >= 3,
+		"expected sample + jump + end actions for indirect action");
+	TEST_ASSERT_EQUAL(out->args.vc.actions[0].type,
+		RTE_FLOW_ACTION_TYPE_SAMPLE, "indirect actions[0] not SAMPLE");
+	sample_conf = out->args.vc.actions[0].conf;
+	TEST_ASSERT_NOT_NULL(sample_conf, "indirect sample conf missing");
+	TEST_ASSERT_NOT_NULL(sample_conf->actions,
+		"indirect sample actions missing");
+	TEST_ASSERT_EQUAL(sample_conf->actions[0].type,
+		RTE_FLOW_ACTION_TYPE_PORT_REPRESENTOR,
+		"indirect sample action[0] type mismatch: %d",
+		sample_conf->actions[0].type);
+	repr = sample_conf->actions[0].conf;
+	TEST_ASSERT_NOT_NULL(repr, "indirect sample port conf missing");
+	TEST_ASSERT_EQUAL(repr->port_id, 0xffff,
+		"indirect sample port representor id mismatch");
+	TEST_ASSERT_EQUAL(sample_conf->actions[1].type,
+		RTE_FLOW_ACTION_TYPE_END,
+		"indirect sample actions should end");
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_flow_parser_cmdline_meter(void)
+{
+	/* meter itself needs to be created beforehand; here we just test parsing */
+	static const char *flow_meter =
+		"flow create 0 ingress group 1 pattern eth / end "
+		"actions meter mtr_id 101 / end";
+	uint8_t outbuf[8192];
+	struct rte_flow_parser_output *out = (void *)outbuf;
+	const struct rte_flow_action_meter *meter_conf;
+	int ret;
+
+	ret = rte_flow_parser_parse(flow_meter, out, sizeof(outbuf));
+	TEST_ASSERT_SUCCESS(ret, "flow meter parse failed: %s", strerror(-ret));
+	TEST_ASSERT_EQUAL(out->command, RTE_FLOW_PARSER_CMD_CREATE,
+		"expected CREATE command, got %d", out->command);
+	TEST_ASSERT_EQUAL(out->port, 0, "expected port 0, got %u", out->port);
+	TEST_ASSERT(out->args.vc.attr.ingress == 1 &&
+		out->args.vc.attr.egress == 0,
+		"expected ingress=1 egress=0");
+	TEST_ASSERT_EQUAL(out->args.vc.attr.group, 1,
+		"expected group 1, got %u", out->args.vc.attr.group);
+	TEST_ASSERT_EQUAL(out->args.vc.pattern_n, 2,
+		"expected 2 pattern items, got %u", out->args.vc.pattern_n);
+	TEST_ASSERT_EQUAL(out->args.vc.pattern[0].type, RTE_FLOW_ITEM_TYPE_ETH,
+		"expected ETH pattern, got %d", out->args.vc.pattern[0].type);
+	TEST_ASSERT_EQUAL(out->args.vc.pattern[1].type, RTE_FLOW_ITEM_TYPE_END,
+		"expected END pattern, got %d", out->args.vc.pattern[1].type);
+	TEST_ASSERT_EQUAL(out->args.vc.actions_n, 2,
+		"expected 2 action items, got %u", out->args.vc.actions_n);
+	TEST_ASSERT_EQUAL(out->args.vc.actions[0].type,
+		RTE_FLOW_ACTION_TYPE_METER, "actions[0] not METER");
+	meter_conf = out->args.vc.actions[0].conf;
+	TEST_ASSERT_NOT_NULL(meter_conf, "meter action configuration missing");
+	TEST_ASSERT_EQUAL(meter_conf->mtr_id, 101,
+		"expected mtr_id 101, got %u", meter_conf->mtr_id);
+	TEST_ASSERT_EQUAL(out->args.vc.actions[1].type,
+		RTE_FLOW_ACTION_TYPE_END, "actions[1] not END");
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_flow_parser_cmdline_queue_set_meta(void)
+{
+	static const char *flow_queue_meta =
+		"flow create 0 ingress pattern eth / ipv4 / tcp dst is 80 / end "
+		"actions queue index 0 / set_meta data 0x1234 / end";
+	uint8_t outbuf[8192];
+	struct rte_flow_parser_output *out = (void *)outbuf;
+	const struct rte_flow_item_tcp *tcp_spec;
+	const struct rte_flow_action_queue *queue_conf;
+	const struct rte_flow_action_set_meta *set_meta_conf;
+	int ret;
+
+	ret = rte_flow_parser_parse(flow_queue_meta, out, sizeof(outbuf));
+	TEST_ASSERT_SUCCESS(ret, "flow queue set_meta parse failed: %s",
+		strerror(-ret));
+	TEST_ASSERT_EQUAL(out->command, RTE_FLOW_PARSER_CMD_CREATE,
+		"expected CREATE command, got %d", out->command);
+	TEST_ASSERT_EQUAL(out->port, 0, "expected port 0, got %u", out->port);
+	TEST_ASSERT(out->args.vc.attr.ingress == 1 &&
+		out->args.vc.attr.egress == 0,
+		"expected ingress=1 egress=0");
+	TEST_ASSERT_EQUAL(out->args.vc.pattern_n, 4,
+		"expected 4 pattern items, got %u", out->args.vc.pattern_n);
+	TEST_ASSERT_EQUAL(out->args.vc.pattern[0].type, RTE_FLOW_ITEM_TYPE_ETH,
+		"pattern[0] expected ETH, got %d", out->args.vc.pattern[0].type);
+	TEST_ASSERT_EQUAL(out->args.vc.pattern[1].type, RTE_FLOW_ITEM_TYPE_IPV4,
+		"pattern[1] expected IPV4, got %d", out->args.vc.pattern[1].type);
+	TEST_ASSERT_EQUAL(out->args.vc.pattern[2].type, RTE_FLOW_ITEM_TYPE_TCP,
+		"pattern[2] expected TCP, got %d", out->args.vc.pattern[2].type);
+	tcp_spec = out->args.vc.pattern[2].spec;
+	TEST_ASSERT_NOT_NULL(tcp_spec, "tcp spec missing");
+	TEST_ASSERT_EQUAL(tcp_spec->hdr.dst_port, rte_cpu_to_be_16(80),
+		"tcp dst port mismatch");
+	TEST_ASSERT_EQUAL(out->args.vc.pattern[3].type, RTE_FLOW_ITEM_TYPE_END,
+		"pattern[3] expected END, got %d", out->args.vc.pattern[3].type);
+
+	TEST_ASSERT_EQUAL(out->args.vc.actions_n, 3,
+		"expected 3 action items, got %u", out->args.vc.actions_n);
+	TEST_ASSERT_EQUAL(out->args.vc.actions[0].type,
+		RTE_FLOW_ACTION_TYPE_QUEUE, "actions[0] not QUEUE");
+	queue_conf = out->args.vc.actions[0].conf;
+	TEST_ASSERT_NOT_NULL(queue_conf, "queue action configuration missing");
+	TEST_ASSERT_EQUAL(queue_conf->index, 0,
+		"queue index expected 0, got %u", queue_conf->index);
+	TEST_ASSERT_EQUAL(out->args.vc.actions[1].type,
+		RTE_FLOW_ACTION_TYPE_SET_META, "actions[1] not SET_META");
+	set_meta_conf = out->args.vc.actions[1].conf;
+	TEST_ASSERT_NOT_NULL(set_meta_conf,
+		"set_meta action configuration missing");
+	TEST_ASSERT_EQUAL(set_meta_conf->data, 0x1234,
+		"set_meta data expected 0x1234, got %#x",
+		set_meta_conf->data);
+	TEST_ASSERT_EQUAL(out->args.vc.actions[2].type,
+		RTE_FLOW_ACTION_TYPE_END, "actions[2] not END");
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_flow_parser_cmdline_modify_field_count(void)
+{
+	static const char *flow_modify_field =
+		"flow validate 1 egress pattern "
+		"tx_queue tx_queue_value is 0 / meta data is 0x1234 / end "
+		"actions modify_field op set dst_type ipv4_src src_type value "
+		"src_value 0x0a000001 width 32 / count / end";
+	uint8_t outbuf[8192];
+	struct rte_flow_parser_output *out = (void *)outbuf;
+	const struct rte_flow_item_tx_queue *tx_queue_spec;
+	const struct rte_flow_item_meta *meta_spec;
+	const struct rte_flow_action_modify_field *modify_conf;
+	const struct rte_flow_action_count *count_conf;
+	const uint8_t expected_src_value[16] = { 0x0a, 0x00, 0x00, 0x01 };
+	int ret;
+
+	ret = rte_flow_parser_parse(flow_modify_field, out, sizeof(outbuf));
+	TEST_ASSERT_SUCCESS(ret, "flow modify_field parse failed: %s",
+		strerror(-ret));
+	TEST_ASSERT_EQUAL(out->command, RTE_FLOW_PARSER_CMD_VALIDATE,
+		"expected VALIDATE command, got %d", out->command);
+	TEST_ASSERT_EQUAL(out->port, 1, "expected port 1, got %u", out->port);
+	TEST_ASSERT(out->args.vc.attr.ingress == 0 &&
+		out->args.vc.attr.egress == 1,
+		"expected ingress=0 egress=1");
+	TEST_ASSERT_EQUAL(out->args.vc.pattern_n, 3,
+		"expected 3 pattern items, got %u", out->args.vc.pattern_n);
+	TEST_ASSERT_EQUAL(out->args.vc.pattern[0].type,
+		RTE_FLOW_ITEM_TYPE_TX_QUEUE,
+		"pattern[0] expected TX_QUEUE, got %d",
+		out->args.vc.pattern[0].type);
+	tx_queue_spec = out->args.vc.pattern[0].spec;
+	TEST_ASSERT_NOT_NULL(tx_queue_spec, "tx_queue spec missing");
+	TEST_ASSERT_EQUAL(tx_queue_spec->tx_queue, 0,
+		"tx_queue value expected 0, got %u",
+		tx_queue_spec->tx_queue);
+	TEST_ASSERT_EQUAL(out->args.vc.pattern[1].type,
+		RTE_FLOW_ITEM_TYPE_META,
+		"pattern[1] expected META, got %d",
+		out->args.vc.pattern[1].type);
+	meta_spec = out->args.vc.pattern[1].spec;
+	TEST_ASSERT_NOT_NULL(meta_spec, "meta spec missing");
+	TEST_ASSERT_EQUAL(meta_spec->data, 0x1234,
+		"meta data expected 0x1234, got %#x",
+		meta_spec->data);
+	TEST_ASSERT_EQUAL(out->args.vc.pattern[2].type, RTE_FLOW_ITEM_TYPE_END,
+		"pattern[2] expected END, got %d", out->args.vc.pattern[2].type);
+
+	TEST_ASSERT_EQUAL(out->args.vc.actions_n, 3,
+		"expected 3 action items, got %u", out->args.vc.actions_n);
+	TEST_ASSERT_EQUAL(out->args.vc.actions[0].type,
+		RTE_FLOW_ACTION_TYPE_MODIFY_FIELD, "actions[0] not MODIFY_FIELD");
+	modify_conf = out->args.vc.actions[0].conf;
+	TEST_ASSERT_NOT_NULL(modify_conf,
+		"modify_field action configuration missing");
+	TEST_ASSERT_EQUAL(modify_conf->operation, RTE_FLOW_MODIFY_SET,
+		"modify_field operation expected SET, got %d",
+		modify_conf->operation);
+	TEST_ASSERT_EQUAL(modify_conf->dst.field, RTE_FLOW_FIELD_IPV4_SRC,
+		"modify_field dst field expected IPV4_SRC, got %d",
+		modify_conf->dst.field);
+	TEST_ASSERT_EQUAL(modify_conf->src.field, RTE_FLOW_FIELD_VALUE,
+		"modify_field src field expected VALUE, got %d",
+		modify_conf->src.field);
+	TEST_ASSERT_EQUAL(modify_conf->width, 32,
+		"modify_field width expected 32, got %u",
+		modify_conf->width);
+	TEST_ASSERT_BUFFERS_ARE_EQUAL(modify_conf->src.value,
+		expected_src_value, sizeof(expected_src_value),
+		"modify_field src value mismatch");
+	TEST_ASSERT_EQUAL(out->args.vc.actions[1].type,
+		RTE_FLOW_ACTION_TYPE_COUNT, "actions[1] not COUNT");
+	count_conf = out->args.vc.actions[1].conf;
+	TEST_ASSERT_NOT_NULL(count_conf, "count action configuration missing");
+	TEST_ASSERT_EQUAL(count_conf->id, 0,
+		"count id expected 0, got %u", count_conf->id);
+	TEST_ASSERT_EQUAL(out->args.vc.actions[2].type,
+		RTE_FLOW_ACTION_TYPE_END, "actions[2] not END");
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_flow_parser_cmdline_raw_decap_rss(void)
+{
+	char flow_raw_decap_rss[160];
+	const uint16_t raw_decap_index = 0;
+	uint8_t outbuf[8192];
+	struct rte_flow_parser_output *out = (void *)outbuf;
+	const struct rte_flow_item *items;
+	uint32_t items_n;
+	const struct rte_flow_action_raw_decap *raw_decap_action;
+	const struct rte_flow_action_rss *rss_conf;
+	const struct rte_flow_action_raw_decap *decap_conf;
+	const struct rte_vxlan_hdr *vxlan_hdr;
+	uint32_t vni;
+	int len;
+	int ret;
+
+	/* Use the setter API: parse pattern, then set raw decap config. */
+	ret = rte_flow_parser_parse_pattern_str(
+		"vxlan vni is 33 / end", &items, &items_n);
+	TEST_ASSERT_SUCCESS(ret, "pattern parse failed: %s", strerror(-ret));
+
+	ret = rte_flow_parser_raw_decap_conf_set(raw_decap_index,
+		items, items_n);
+	TEST_ASSERT_SUCCESS(ret, "raw_decap_conf_set failed: %s",
+		strerror(-ret));
+
+	/* Verify the stored config via getter. */
+	decap_conf = rte_flow_parser_raw_decap_conf(raw_decap_index);
+	TEST_ASSERT_NOT_NULL(decap_conf, "raw_decap config missing");
+	TEST_ASSERT(decap_conf->size >= sizeof(struct rte_vxlan_hdr),
+		"raw_decap config size too small: %zu", decap_conf->size);
+	vxlan_hdr = (const struct rte_vxlan_hdr *)decap_conf->data;
+	vni = ((uint32_t)vxlan_hdr->vni[0] << 16) |
+	      ((uint32_t)vxlan_hdr->vni[1] << 8) |
+	      (uint32_t)vxlan_hdr->vni[2];
+	TEST_ASSERT_EQUAL(vni, 33,
+		"raw_decap vxlan vni expected 33, got %u", vni);
+
+	/* Parse a flow rule that uses the stored raw_decap config. */
+	len = snprintf(flow_raw_decap_rss, sizeof(flow_raw_decap_rss),
+		"flow create 0 ingress pattern eth / ipv4 / end "
+		"actions raw_decap index %u / rss / end",
+		raw_decap_index);
+	TEST_ASSERT(len > 0 && len < (int)sizeof(flow_raw_decap_rss),
+		"flow raw_decap rss command truncated");
+
+	ret = rte_flow_parser_parse(flow_raw_decap_rss, out, sizeof(outbuf));
+	TEST_ASSERT_SUCCESS(ret, "flow raw_decap rss parse failed: %s",
+		strerror(-ret));
+	TEST_ASSERT_EQUAL(out->command, RTE_FLOW_PARSER_CMD_CREATE,
+		"expected CREATE command, got %d", out->command);
+	TEST_ASSERT_EQUAL(out->port, 0, "expected port 0, got %u", out->port);
+	TEST_ASSERT(out->args.vc.attr.ingress == 1 &&
+		out->args.vc.attr.egress == 0,
+		"expected ingress=1 egress=0");
+
+	TEST_ASSERT_EQUAL(out->args.vc.pattern_n, 3,
+		"expected 3 pattern items, got %u", out->args.vc.pattern_n);
+	TEST_ASSERT_EQUAL(out->args.vc.pattern[0].type, RTE_FLOW_ITEM_TYPE_ETH,
+		"pattern[0] expected ETH, got %d", out->args.vc.pattern[0].type);
+	TEST_ASSERT_EQUAL(out->args.vc.pattern[1].type, RTE_FLOW_ITEM_TYPE_IPV4,
+		"pattern[1] expected IPV4, got %d", out->args.vc.pattern[1].type);
+	TEST_ASSERT_EQUAL(out->args.vc.pattern[2].type, RTE_FLOW_ITEM_TYPE_END,
+		"pattern[2] expected END, got %d", out->args.vc.pattern[2].type);
+
+	TEST_ASSERT_EQUAL(out->args.vc.actions_n, 3,
+		"expected 3 action items, got %u", out->args.vc.actions_n);
+	TEST_ASSERT_EQUAL(out->args.vc.actions[0].type,
+		RTE_FLOW_ACTION_TYPE_RAW_DECAP, "actions[0] not RAW_DECAP");
+	raw_decap_action = out->args.vc.actions[0].conf;
+	TEST_ASSERT_NOT_NULL(raw_decap_action,
+		"raw_decap action configuration missing");
+	TEST_ASSERT_NOT_NULL(raw_decap_action->data,
+		"raw_decap action data missing");
+	TEST_ASSERT(raw_decap_action->size >= sizeof(struct rte_vxlan_hdr),
+		"raw_decap action size too small: %zu",
+		raw_decap_action->size);
+	TEST_ASSERT_EQUAL(out->args.vc.actions[1].type,
+		RTE_FLOW_ACTION_TYPE_RSS, "actions[1] not RSS");
+	rss_conf = out->args.vc.actions[1].conf;
+	TEST_ASSERT_NOT_NULL(rss_conf, "rss action configuration missing");
+	TEST_ASSERT_EQUAL(out->args.vc.actions[2].type,
+		RTE_FLOW_ACTION_TYPE_END, "actions[2] not END");
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_flow_parser_cmdline_invalid_args(void)
+{
+	uint8_t outbuf[sizeof(struct rte_flow_parser_output)];
+	int ret;
+
+	/* Test NULL command string */
+	ret = rte_flow_parser_parse(NULL, (void *)outbuf, sizeof(outbuf));
+	TEST_ASSERT_EQUAL(ret, -EINVAL, "NULL cmd should return -EINVAL");
+
+	/* Test NULL output buffer */
+	ret = rte_flow_parser_parse("flow list 0", NULL, sizeof(outbuf));
+	TEST_ASSERT_EQUAL(ret, -EINVAL, "NULL output should return -EINVAL");
+
+	/* Test output buffer too small */
+	ret = rte_flow_parser_parse("flow list 0", (void *)outbuf,
+		sizeof(struct rte_flow_parser_output) - 1);
+	TEST_ASSERT_EQUAL(ret, -ENOBUFS, "short output buffer not rejected");
+
+	/* Test zero-length output buffer */
+	ret = rte_flow_parser_parse("flow list 0", (void *)outbuf, 0);
+	TEST_ASSERT_EQUAL(ret, -ENOBUFS, "zero-length output buffer not rejected");
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_flow_parser_cmdline_invalid_syntax(void)
+{
+	static const char *invalid_cmd = "flow invalid 0";
+	static const char *wrong_cmd =
+		"flow create 0 rule 7"; /* destroy syntax in create */
+	static const char *actions_before_pattern =
+		"flow create 0 ingress actions drop / end pattern eth / end";
+	static const char *missing_actions_keyword =
+		"flow create 0 ingress pattern eth / end drop / end";
+	static const char *missing_pattern_keyword =
+		"flow create 0 ingress actions drop / end";
+	static const char *missing_action_separator =
+		"flow create 0 ingress pattern eth / end actions drop end";
+	static const char *missing_pattern_end =
+		"flow create 0 ingress pattern eth / ipv4 actions drop / end";
+	static const char *missing_port_id =
+		"flow create ingress pattern eth / end actions drop / end";
+	static const char *extra_trailing_token =
+		"flow create 0 ingress pattern eth / end actions drop / end junk";
+	static const char *empty_command = "";
+	static const char *whitespace_only = "   ";
+	uint8_t outbuf[4096];
+	struct rte_flow_parser_output *out = (void *)outbuf;
+	int ret;
+
+	ret = rte_flow_parser_parse(invalid_cmd, out, sizeof(outbuf));
+	TEST_ASSERT(ret < 0, "unexpected status for invalid cmd: %d", ret);
+
+	ret = rte_flow_parser_parse(wrong_cmd, out, sizeof(outbuf));
+	TEST_ASSERT(ret < 0,
+		"expected failure for wrong command usage: %d", ret);
+
+	ret = rte_flow_parser_parse(actions_before_pattern, out, sizeof(outbuf));
+	TEST_ASSERT(ret < 0,
+		"expected failure for actions before pattern: %d", ret);
+
+	ret = rte_flow_parser_parse(missing_actions_keyword, out, sizeof(outbuf));
+	TEST_ASSERT(ret < 0,
+		"expected failure for missing actions keyword: %d", ret);
+
+	ret = rte_flow_parser_parse(missing_pattern_keyword, out, sizeof(outbuf));
+	TEST_ASSERT(ret < 0,
+		"expected failure for missing pattern keyword: %d", ret);
+
+	ret = rte_flow_parser_parse(missing_action_separator, out, sizeof(outbuf));
+	TEST_ASSERT(ret < 0,
+		"expected failure for missing action separator: %d", ret);
+
+	ret = rte_flow_parser_parse(missing_pattern_end, out, sizeof(outbuf));
+	TEST_ASSERT(ret < 0,
+		"expected failure for missing pattern end: %d", ret);
+
+	ret = rte_flow_parser_parse(missing_port_id, out, sizeof(outbuf));
+	TEST_ASSERT(ret < 0,
+		"expected failure for missing port id: %d", ret);
+
+	ret = rte_flow_parser_parse(extra_trailing_token, out, sizeof(outbuf));
+	TEST_ASSERT(ret < 0,
+		"expected failure for extra trailing token: %d", ret);
+
+	ret = rte_flow_parser_parse(empty_command, out, sizeof(outbuf));
+	TEST_ASSERT(ret < 0,
+		"expected failure for empty command: %d", ret);
+
+	ret = rte_flow_parser_parse(whitespace_only, out, sizeof(outbuf));
+	TEST_ASSERT(ret < 0,
+		"expected failure for whitespace-only command: %d", ret);
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_flow_parser_cmdline_port_id(void)
+{
+	uint8_t outbuf[4096];
+	struct rte_flow_parser_output *out = (void *)outbuf;
+	int ret;
+
+	/* Test various port IDs */
+	ret = rte_flow_parser_parse("flow list 0", out, sizeof(outbuf));
+	TEST_ASSERT_SUCCESS(ret, "port 0 parse failed");
+	TEST_ASSERT_EQUAL(out->port, 0, "expected port 0, got %u", out->port);
+
+	ret = rte_flow_parser_parse("flow list 1", out, sizeof(outbuf));
+	TEST_ASSERT_SUCCESS(ret, "port 1 parse failed");
+	TEST_ASSERT_EQUAL(out->port, 1, "expected port 1, got %u", out->port);
+
+	ret = rte_flow_parser_parse("flow list 255", out, sizeof(outbuf));
+	TEST_ASSERT_SUCCESS(ret, "port 255 parse failed");
+	TEST_ASSERT_EQUAL(out->port, 255, "expected port 255, got %u", out->port);
+
+	return TEST_SUCCESS;
+}
+
+/* Cmdline integration tests */
+
+static void
+test_dispatch_cb(const struct rte_flow_parser_output *in __rte_unused)
+{
+}
+
+static cmdline_parse_inst_t test_flow_inst = {
+	.f = rte_flow_parser_cmd_flow_cb,
+	.data = NULL,
+	.help_str = NULL,
+	.tokens = { NULL },
+};
+
+static int
+test_flow_parser_cmdline_register(void)
+{
+	cmdline_parse_token_hdr_t *tok = NULL;
+
+	rte_flow_parser_cmd_flow_cb(&tok, NULL, &test_flow_inst.tokens[0]);
+	TEST_ASSERT_NOT_NULL(tok, "first dynamic token should not be NULL");
+
+	return TEST_SUCCESS;
+}
+
+/* Encap/decap setter tests */
+
+static int
+test_flow_parser_raw_encap_setter(void)
+{
+	const struct rte_flow_item *items;
+	uint32_t items_n;
+	const struct rte_flow_action_raw_encap *conf;
+	int ret;
+
+	ret = rte_flow_parser_parse_pattern_str(
+		"eth / ipv4 / udp / vxlan / end", &items, &items_n);
+	TEST_ASSERT_SUCCESS(ret, "pattern parse failed: %s", strerror(-ret));
+
+	ret = rte_flow_parser_raw_encap_conf_set(0, items, items_n);
+	TEST_ASSERT_SUCCESS(ret, "raw_encap_conf_set failed: %s",
+		strerror(-ret));
+
+	conf = rte_flow_parser_raw_encap_conf(0);
+	TEST_ASSERT_NOT_NULL(conf, "raw_encap config missing after set");
+	TEST_ASSERT_NOT_NULL(conf->data, "raw_encap data missing");
+	TEST_ASSERT(conf->size > 0, "raw_encap size is 0");
+	TEST_ASSERT(conf->size >= 50,
+		"raw_encap size too small for eth/ipv4/udp/vxlan: %zu",
+		conf->size);
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_flow_parser_raw_decap_setter(void)
+{
+	const struct rte_flow_item *items;
+	uint32_t items_n;
+	const struct rte_flow_action_raw_decap *conf;
+	int ret;
+
+	ret = rte_flow_parser_parse_pattern_str(
+		"eth / end", &items, &items_n);
+	TEST_ASSERT_SUCCESS(ret, "pattern parse failed: %s", strerror(-ret));
+
+	ret = rte_flow_parser_raw_decap_conf_set(0, items, items_n);
+	TEST_ASSERT_SUCCESS(ret, "raw_decap_conf_set failed: %s",
+		strerror(-ret));
+
+	conf = rte_flow_parser_raw_decap_conf(0);
+	TEST_ASSERT_NOT_NULL(conf, "raw_decap config missing after set");
+	TEST_ASSERT_NOT_NULL(conf->data, "raw_decap data missing");
+	TEST_ASSERT(conf->size >= 14,
+		"raw_decap size too small for eth: %zu", conf->size);
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_flow_parser_raw_setter_boundary(void)
+{
+	const struct rte_flow_item *items;
+	uint32_t items_n;
+	int ret;
+
+	ret = rte_flow_parser_parse_pattern_str(
+		"eth / end", &items, &items_n);
+	TEST_ASSERT_SUCCESS(ret, "pattern parse failed");
+
+	ret = rte_flow_parser_raw_encap_conf_set(RAW_ENCAP_CONFS_MAX_NUM,
+		items, items_n);
+	TEST_ASSERT(ret < 0, "out-of-range index should fail");
+
+	ret = rte_flow_parser_raw_decap_conf_set(RAW_ENCAP_CONFS_MAX_NUM,
+		items, items_n);
+	TEST_ASSERT(ret < 0, "out-of-range index should fail");
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_flow_parser_config_register_identity(void)
+{
+	struct rte_flow_parser_vxlan_encap_conf local_vxlan = { 0 };
+	struct rte_flow_parser_config cfg = { .vxlan_encap = &local_vxlan };
+
+	TEST_ASSERT_SUCCESS(rte_flow_parser_config_register(&cfg),
+		"config_register failed");
+
+	/* Write through registered config, verify it's the same object */
+	local_vxlan.select_ipv4 = 1;
+	local_vxlan.vni[0] = 0xAA;
+	TEST_ASSERT_EQUAL(cfg.vxlan_encap->vni[0], 0xAA,
+		"registered config not the same object");
+
+	/* Restore test config */
+	test_register_config();
+	return TEST_SUCCESS;
+}
+
+static struct unit_test_suite flow_parser_tests = {
+	.suite_name = "flow parser autotest",
+	.setup = flow_parser_setup,
+	.teardown = NULL,
+	.unit_test_cases = {
+		/* Cmdline API tests (rte_flow_parser_cmdline.h) */
+		TEST_CASE_ST(flow_parser_case_setup, flow_parser_teardown,
+			test_flow_parser_cmdline_command_mapping),
+		TEST_CASE_ST(flow_parser_case_setup, flow_parser_teardown,
+			test_flow_parser_cmdline_invalid_args),
+		TEST_CASE_ST(flow_parser_case_setup, flow_parser_teardown,
+			test_flow_parser_cmdline_invalid_syntax),
+		TEST_CASE_ST(flow_parser_case_setup, flow_parser_teardown,
+			test_flow_parser_cmdline_port_id),
+		TEST_CASE_ST(flow_parser_case_setup, flow_parser_teardown,
+			test_flow_parser_cmdline_indirect_action),
+		TEST_CASE_ST(flow_parser_case_setup, flow_parser_teardown,
+			test_flow_parser_cmdline_meter),
+		TEST_CASE_ST(flow_parser_case_setup, flow_parser_teardown,
+			test_flow_parser_cmdline_queue_set_meta),
+		TEST_CASE_ST(flow_parser_case_setup, flow_parser_teardown,
+			test_flow_parser_cmdline_modify_field_count),
+		TEST_CASE_ST(flow_parser_case_setup, flow_parser_teardown,
+			test_flow_parser_cmdline_raw_decap_rss),
+		/* Cmdline integration tests */
+		TEST_CASE_ST(flow_parser_case_setup, flow_parser_teardown,
+			test_flow_parser_cmdline_register),
+		/* Setter tests */
+		TEST_CASE_ST(flow_parser_case_setup, flow_parser_teardown,
+			test_flow_parser_raw_encap_setter),
+		TEST_CASE_ST(flow_parser_case_setup, flow_parser_teardown,
+			test_flow_parser_raw_decap_setter),
+		TEST_CASE_ST(flow_parser_case_setup, flow_parser_teardown,
+			test_flow_parser_raw_setter_boundary),
+		/* Config registration test */
+		TEST_CASE_ST(flow_parser_case_setup, flow_parser_teardown,
+			test_flow_parser_config_register_identity),
+		TEST_CASES_END()
+	}
+};
+
+static int
+test_flow_parser(void)
+{
+	return unit_test_suite_runner(&flow_parser_tests);
+}
+
+REGISTER_FAST_TEST(flow_parser_autotest, NOHUGE_OK, ASAN_OK, test_flow_parser);
diff --git a/app/test/test_flow_parser_simple.c b/app/test/test_flow_parser_simple.c
new file mode 100644
index 0000000000..a8767b19f7
--- /dev/null
+++ b/app/test/test_flow_parser_simple.c
@@ -0,0 +1,445 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 DynaNIC Semiconductors, Ltd.
+ */
+
+/*
+ * Tests for the simple flow parser API (rte_flow_parser.h).
+ * These tests do NOT require config registration — the simple API
+ * is self-contained and works without rte_flow_parser_cmdline.h.
+ */
+
+#include <stdint.h>
+#include <string.h>
+#include <errno.h>
+
+#include <rte_byteorder.h>
+#include <rte_flow.h>
+#include <rte_flow_parser.h>
+
+#include "test.h"
+
+static int
+test_flow_parser_public_attr_parsing(void)
+{
+	struct rte_flow_attr attr;
+	int ret;
+
+	/* Test basic ingress attribute */
+	memset(&attr, 0, sizeof(attr));
+	ret = rte_flow_parser_parse_attr_str("ingress", &attr);
+	TEST_ASSERT_SUCCESS(ret, "ingress attr parse failed: %s",
+		strerror(-ret));
+	TEST_ASSERT(attr.ingress == 1 && attr.egress == 0,
+		"attr flags mismatch ingress=%u egress=%u",
+		attr.ingress, attr.egress);
+
+	/* Test egress attribute */
+	memset(&attr, 0, sizeof(attr));
+	ret = rte_flow_parser_parse_attr_str("egress", &attr);
+	TEST_ASSERT_SUCCESS(ret, "egress attr parse failed: %s",
+		strerror(-ret));
+	TEST_ASSERT(attr.ingress == 0 && attr.egress == 1,
+		"attr flags mismatch ingress=%u egress=%u",
+		attr.ingress, attr.egress);
+
+	/* Test transfer attribute */
+	memset(&attr, 0, sizeof(attr));
+	ret = rte_flow_parser_parse_attr_str("transfer", &attr);
+	TEST_ASSERT_SUCCESS(ret, "transfer attr parse failed: %s",
+		strerror(-ret));
+	TEST_ASSERT(attr.transfer == 1, "transfer flag not set");
+
+	/* Test combined attributes with group and priority */
+	memset(&attr, 0, sizeof(attr));
+	ret = rte_flow_parser_parse_attr_str("ingress group 1 priority 5", &attr);
+	TEST_ASSERT_SUCCESS(ret, "combined attr parse failed: %s",
+		strerror(-ret));
+	TEST_ASSERT_EQUAL(attr.group, 1, "attr group mismatch: %u", attr.group);
+	TEST_ASSERT_EQUAL(attr.priority, 5,
+		"attr priority mismatch: %u", attr.priority);
+	TEST_ASSERT(attr.ingress == 1 && attr.egress == 0,
+		"attr flags mismatch ingress=%u egress=%u",
+		attr.ingress, attr.egress);
+
+	/* Test multiple direction attributes (last one wins) */
+	memset(&attr, 0, sizeof(attr));
+	ret = rte_flow_parser_parse_attr_str("ingress egress", &attr);
+	TEST_ASSERT_SUCCESS(ret, "multi-direction attr parse failed: %s",
+		strerror(-ret));
+	TEST_ASSERT(attr.ingress == 1 && attr.egress == 1,
+		"both ingress and egress should be set");
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_flow_parser_public_pattern_parsing(void)
+{
+	const struct rte_flow_item *pattern = NULL;
+	uint32_t pattern_n = 0;
+	int ret;
+
+	ret = rte_flow_parser_parse_pattern_str("eth / end",
+						&pattern, &pattern_n);
+	TEST_ASSERT_SUCCESS(ret, "simple pattern parse failed: %s",
+		strerror(-ret));
+	TEST_ASSERT_EQUAL(pattern_n, 2, "expected 2 pattern items, got %u",
+		pattern_n);
+	TEST_ASSERT_EQUAL(pattern[0].type, RTE_FLOW_ITEM_TYPE_ETH,
+		"pattern[0] expected ETH, got %d", pattern[0].type);
+	TEST_ASSERT_EQUAL(pattern[1].type, RTE_FLOW_ITEM_TYPE_END,
+		"pattern[1] expected END, got %d", pattern[1].type);
+
+	ret = rte_flow_parser_parse_pattern_str("eth / ipv4 / end",
+						&pattern, &pattern_n);
+	TEST_ASSERT_SUCCESS(ret, "eth/ipv4 pattern parse failed: %s",
+		strerror(-ret));
+	TEST_ASSERT_EQUAL(pattern_n, 3, "expected 3 pattern items, got %u",
+		pattern_n);
+	TEST_ASSERT_EQUAL(pattern[0].type, RTE_FLOW_ITEM_TYPE_ETH,
+		"pattern[0] expected ETH, got %d", pattern[0].type);
+	TEST_ASSERT_EQUAL(pattern[1].type, RTE_FLOW_ITEM_TYPE_IPV4,
+		"pattern[1] expected IPV4, got %d", pattern[1].type);
+	TEST_ASSERT_EQUAL(pattern[2].type, RTE_FLOW_ITEM_TYPE_END,
+		"pattern[2] expected END, got %d", pattern[2].type);
+
+	ret = rte_flow_parser_parse_pattern_str("eth / ipv4 / tcp / end",
+						&pattern, &pattern_n);
+	TEST_ASSERT_SUCCESS(ret, "complex pattern parse failed: %s",
+		strerror(-ret));
+	TEST_ASSERT_EQUAL(pattern_n, 4, "expected 4 pattern items, got %u",
+		pattern_n);
+	TEST_ASSERT(pattern[0].type == RTE_FLOW_ITEM_TYPE_ETH &&
+		pattern[1].type == RTE_FLOW_ITEM_TYPE_IPV4 &&
+		pattern[2].type == RTE_FLOW_ITEM_TYPE_TCP &&
+		pattern[3].type == RTE_FLOW_ITEM_TYPE_END,
+		"complex pattern type mismatch");
+
+	ret = rte_flow_parser_parse_pattern_str("eth / ipv6 / udp / end",
+						&pattern, &pattern_n);
+	TEST_ASSERT_SUCCESS(ret, "ipv6/udp pattern parse failed: %s",
+		strerror(-ret));
+	TEST_ASSERT_EQUAL(pattern_n, 4, "expected 4 pattern items, got %u",
+		pattern_n);
+	TEST_ASSERT_EQUAL(pattern[1].type, RTE_FLOW_ITEM_TYPE_IPV6,
+		"pattern[1] expected IPV6, got %d", pattern[1].type);
+	TEST_ASSERT_EQUAL(pattern[2].type, RTE_FLOW_ITEM_TYPE_UDP,
+		"pattern[2] expected UDP, got %d", pattern[2].type);
+
+	ret = rte_flow_parser_parse_pattern_str("eth / vlan / ipv4 / end",
+						&pattern, &pattern_n);
+	TEST_ASSERT_SUCCESS(ret, "vlan pattern parse failed: %s",
+		strerror(-ret));
+	TEST_ASSERT_EQUAL(pattern_n, 4, "expected 4 pattern items, got %u",
+		pattern_n);
+	TEST_ASSERT_EQUAL(pattern[1].type, RTE_FLOW_ITEM_TYPE_VLAN,
+		"pattern[1] expected VLAN, got %d", pattern[1].type);
+
+	/* Pattern without trailing "/ end" should succeed (auto-appended). */
+	ret = rte_flow_parser_parse_pattern_str("eth / ipv4", &pattern, &pattern_n);
+	TEST_ASSERT_SUCCESS(ret, "pattern without end should auto-complete: %s",
+		strerror(-ret));
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_flow_parser_public_actions_parsing(void)
+{
+	const struct rte_flow_action *actions = NULL;
+	const struct rte_flow_action_queue *queue_conf;
+	const struct rte_flow_action_mark *mark_conf;
+	uint32_t actions_n = 0;
+	int ret;
+
+	ret = rte_flow_parser_parse_actions_str("drop / end",
+						&actions, &actions_n);
+	TEST_ASSERT_SUCCESS(ret, "drop action parse failed: %s",
+		strerror(-ret));
+	TEST_ASSERT_EQUAL(actions_n, 2, "expected 2 action items, got %u",
+		actions_n);
+	TEST_ASSERT_EQUAL(actions[0].type, RTE_FLOW_ACTION_TYPE_DROP,
+		"actions[0] expected DROP, got %d", actions[0].type);
+	TEST_ASSERT_EQUAL(actions[1].type, RTE_FLOW_ACTION_TYPE_END,
+		"actions[1] expected END, got %d", actions[1].type);
+
+	ret = rte_flow_parser_parse_actions_str("queue index 3 / end",
+						&actions, &actions_n);
+	TEST_ASSERT_SUCCESS(ret, "queue action parse failed: %s",
+		strerror(-ret));
+	TEST_ASSERT_EQUAL(actions_n, 2, "expected 2 action items, got %u",
+		actions_n);
+	TEST_ASSERT_EQUAL(actions[0].type, RTE_FLOW_ACTION_TYPE_QUEUE,
+		"actions[0] expected QUEUE, got %d", actions[0].type);
+	queue_conf = actions[0].conf;
+	TEST_ASSERT_NOT_NULL(queue_conf, "queue action configuration missing");
+	TEST_ASSERT_EQUAL(queue_conf->index, 3,
+		"queue index expected 3, got %u", queue_conf->index);
+
+	ret = rte_flow_parser_parse_actions_str("mark id 42 / drop / end",
+						&actions, &actions_n);
+	TEST_ASSERT_SUCCESS(ret, "multi-action parse failed: %s",
+		strerror(-ret));
+	TEST_ASSERT_EQUAL(actions_n, 3, "expected 3 action items, got %u",
+		actions_n);
+	TEST_ASSERT_EQUAL(actions[0].type, RTE_FLOW_ACTION_TYPE_MARK,
+		"actions[0] expected MARK, got %d", actions[0].type);
+	mark_conf = actions[0].conf;
+	TEST_ASSERT_NOT_NULL(mark_conf, "mark action configuration missing");
+	TEST_ASSERT_EQUAL(mark_conf->id, 42,
+		"mark id expected 42, got %u", mark_conf->id);
+	TEST_ASSERT_EQUAL(actions[1].type, RTE_FLOW_ACTION_TYPE_DROP,
+		"actions[1] expected DROP, got %d", actions[1].type);
+	TEST_ASSERT_EQUAL(actions[2].type, RTE_FLOW_ACTION_TYPE_END,
+		"actions[2] expected END, got %d", actions[2].type);
+
+	ret = rte_flow_parser_parse_actions_str("rss / end",
+						&actions, &actions_n);
+	TEST_ASSERT_SUCCESS(ret, "rss action parse failed: %s",
+		strerror(-ret));
+	TEST_ASSERT_EQUAL(actions[0].type, RTE_FLOW_ACTION_TYPE_RSS,
+		"actions[0] expected RSS, got %d", actions[0].type);
+
+	ret = rte_flow_parser_parse_actions_str("count / end",
+						&actions, &actions_n);
+	TEST_ASSERT_SUCCESS(ret, "count action parse failed: %s",
+		strerror(-ret));
+	TEST_ASSERT_EQUAL(actions[0].type, RTE_FLOW_ACTION_TYPE_COUNT,
+		"actions[0] expected COUNT, got %d", actions[0].type);
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_flow_parser_public_invalid_args(void)
+{
+	const struct rte_flow_item *pattern = NULL;
+	const struct rte_flow_action *actions = NULL;
+	struct rte_flow_attr attr;
+	uint32_t count = 0;
+	int ret;
+
+	/* Test NULL attribute string */
+	ret = rte_flow_parser_parse_attr_str(NULL, &attr);
+	TEST_ASSERT_EQUAL(ret, -EINVAL, "NULL attr string should fail");
+
+	/* Test NULL attribute output */
+	ret = rte_flow_parser_parse_attr_str("ingress", NULL);
+	TEST_ASSERT_EQUAL(ret, -EINVAL, "NULL attr output should fail");
+
+	/* Test NULL pattern string */
+	ret = rte_flow_parser_parse_pattern_str(NULL, &pattern, &count);
+	TEST_ASSERT_EQUAL(ret, -EINVAL, "NULL pattern string should fail");
+
+	/* Test NULL pattern output */
+	ret = rte_flow_parser_parse_pattern_str("eth / end", NULL, &count);
+	TEST_ASSERT_EQUAL(ret, -EINVAL, "NULL pattern out should fail");
+
+	/* Test NULL pattern count */
+	ret = rte_flow_parser_parse_pattern_str("eth / end", &pattern, NULL);
+	TEST_ASSERT_EQUAL(ret, -EINVAL, "NULL pattern count should fail");
+
+	/* Test NULL actions string */
+	ret = rte_flow_parser_parse_actions_str(NULL, &actions, &count);
+	TEST_ASSERT_EQUAL(ret, -EINVAL, "NULL actions string should fail");
+
+	/* Test NULL actions output */
+	ret = rte_flow_parser_parse_actions_str("drop / end", NULL, &count);
+	TEST_ASSERT_EQUAL(ret, -EINVAL, "NULL actions out should fail");
+
+	/* Test NULL actions count */
+	ret = rte_flow_parser_parse_actions_str("drop / end", &actions, NULL);
+	TEST_ASSERT_EQUAL(ret, -EINVAL, "NULL actions count should fail");
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_flow_parser_public_invalid_syntax(void)
+{
+	const struct rte_flow_item *pattern = NULL;
+	const struct rte_flow_action *actions = NULL;
+	struct rte_flow_attr attr;
+	uint32_t count = 0;
+	int ret;
+
+	/* Invalid attribute syntax */
+	ret = rte_flow_parser_parse_attr_str("ingress group", &attr);
+	TEST_ASSERT(ret < 0, "expected attr failure for missing group id: %d",
+		ret);
+
+	ret = rte_flow_parser_parse_attr_str("priority foo", &attr);
+	TEST_ASSERT(ret < 0, "expected attr failure for invalid priority: %d",
+		ret);
+
+	ret = rte_flow_parser_parse_attr_str("ingress bogus 1", &attr);
+	TEST_ASSERT(ret < 0, "expected attr failure for unknown token: %d",
+		ret);
+
+	ret = rte_flow_parser_parse_pattern_str("eth / unknown / end",
+		&pattern, &count);
+	TEST_ASSERT(ret < 0, "expected pattern failure for unknown item: %d",
+		ret);
+
+	ret = rte_flow_parser_parse_pattern_str("", &pattern, &count);
+	TEST_ASSERT(ret < 0, "expected pattern failure for empty string: %d",
+		ret);
+
+	/* Invalid actions syntax */
+	ret = rte_flow_parser_parse_actions_str("queue index / end",
+		&actions, &count);
+	TEST_ASSERT(ret < 0, "expected actions failure for missing index: %d",
+		ret);
+
+	ret = rte_flow_parser_parse_actions_str("mark id / end",
+		&actions, &count);
+	TEST_ASSERT(ret < 0, "expected actions failure for missing id: %d",
+		ret);
+
+	ret = rte_flow_parser_parse_actions_str("bogus / end",
+		&actions, &count);
+	TEST_ASSERT(ret < 0, "expected actions failure for unknown action: %d",
+		ret);
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_flow_parser_public_parse_flow_rule(void)
+{
+	struct rte_flow_attr attr;
+	const struct rte_flow_item *pattern = NULL;
+	uint32_t pattern_n = 0;
+	const struct rte_flow_action *actions = NULL;
+	uint32_t actions_n = 0;
+	int ret;
+
+	/* Basic ingress drop rule */
+	ret = rte_flow_parser_parse_flow_rule(
+		"ingress pattern eth / ipv4 / end actions drop / end",
+		&attr, &pattern, &pattern_n, &actions, &actions_n);
+	TEST_ASSERT_SUCCESS(ret, "parse_flow_rule failed: %d", ret);
+	TEST_ASSERT(attr.ingress == 1, "expected ingress");
+	TEST_ASSERT(attr.egress == 0, "expected no egress");
+	TEST_ASSERT(pattern_n >= 3, "expected >= 3 pattern items, got %u",
+		pattern_n);
+	TEST_ASSERT_EQUAL(pattern[0].type, RTE_FLOW_ITEM_TYPE_ETH,
+		"pattern[0] expected ETH");
+	TEST_ASSERT_EQUAL(pattern[1].type, RTE_FLOW_ITEM_TYPE_IPV4,
+		"pattern[1] expected IPV4");
+	TEST_ASSERT_EQUAL(pattern[pattern_n - 1].type, RTE_FLOW_ITEM_TYPE_END,
+		"last pattern item expected END");
+	TEST_ASSERT(actions_n >= 2, "expected >= 2 actions, got %u", actions_n);
+	TEST_ASSERT_EQUAL(actions[0].type, RTE_FLOW_ACTION_TYPE_DROP,
+		"actions[0] expected DROP");
+	TEST_ASSERT_EQUAL(actions[actions_n - 1].type,
+		RTE_FLOW_ACTION_TYPE_END, "last action expected END");
+
+	/* NULL argument checks */
+	ret = rte_flow_parser_parse_flow_rule(NULL,
+		&attr, &pattern, &pattern_n, &actions, &actions_n);
+	TEST_ASSERT(ret < 0, "NULL src should fail");
+	ret = rte_flow_parser_parse_flow_rule(
+		"ingress pattern eth / end actions drop / end",
+		NULL, &pattern, &pattern_n, &actions, &actions_n);
+	TEST_ASSERT(ret < 0, "NULL attr should fail");
+
+	/* NULL pattern output */
+	ret = rte_flow_parser_parse_flow_rule(
+		"ingress pattern eth / end actions drop / end",
+		&attr, NULL, &pattern_n, &actions, &actions_n);
+	TEST_ASSERT(ret < 0, "NULL pattern should fail");
+
+	/* NULL pattern count */
+	ret = rte_flow_parser_parse_flow_rule(
+		"ingress pattern eth / end actions drop / end",
+		&attr, &pattern, NULL, &actions, &actions_n);
+	TEST_ASSERT(ret < 0, "NULL pattern_n should fail");
+
+	/* NULL actions output */
+	ret = rte_flow_parser_parse_flow_rule(
+		"ingress pattern eth / end actions drop / end",
+		&attr, &pattern, &pattern_n, NULL, &actions_n);
+	TEST_ASSERT(ret < 0, "NULL actions should fail");
+
+	/* NULL actions count */
+	ret = rte_flow_parser_parse_flow_rule(
+		"ingress pattern eth / end actions drop / end",
+		&attr, &pattern, &pattern_n, &actions, NULL);
+	TEST_ASSERT(ret < 0, "NULL actions_n should fail");
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_flow_parser_no_registration(void)
+{
+	const struct rte_flow_action *actions = NULL;
+	uint32_t actions_n = 0;
+	int ret;
+
+	/*
+	 * Actions that depend on registered config (vxlan_encap, nvgre_encap,
+	 * l2_encap, etc.) must not crash when no config is registered.
+	 * The simple API never calls config_register, so the registry is
+	 * empty. The parser should either parse successfully with NULL conf
+	 * or fail gracefully.
+	 */
+	ret = rte_flow_parser_parse_actions_str("vxlan_encap / end",
+						&actions, &actions_n);
+	TEST_ASSERT(ret < 0,
+		"vxlan_encap without registration should fail, got %d", ret);
+
+	ret = rte_flow_parser_parse_actions_str("nvgre_encap / end",
+						&actions, &actions_n);
+	TEST_ASSERT(ret < 0,
+		"nvgre_encap without registration should fail, got %d", ret);
+
+	ret = rte_flow_parser_parse_actions_str("l2_encap / end",
+						&actions, &actions_n);
+	TEST_ASSERT(ret < 0,
+		"l2_encap without registration should fail, got %d", ret);
+
+	ret = rte_flow_parser_parse_actions_str("l2_decap / end",
+						&actions, &actions_n);
+	TEST_ASSERT(ret < 0,
+		"l2_decap without registration should fail, got %d", ret);
+
+	/* Non-config-dependent actions should still work */
+	ret = rte_flow_parser_parse_actions_str("drop / end",
+						&actions, &actions_n);
+	TEST_ASSERT_SUCCESS(ret,
+		"drop should work without registration: %s", strerror(-ret));
+	TEST_ASSERT_EQUAL(actions[0].type, RTE_FLOW_ACTION_TYPE_DROP,
+		"expected DROP action");
+
+	ret = rte_flow_parser_parse_actions_str("queue index 0 / end",
+						&actions, &actions_n);
+	TEST_ASSERT_SUCCESS(ret,
+		"queue should work without registration: %s", strerror(-ret));
+
+	return TEST_SUCCESS;
+}
+
+static struct unit_test_suite flow_parser_simple_tests = {
+	.suite_name = "flow parser simple API autotest",
+	.unit_test_cases = {
+		TEST_CASE(test_flow_parser_public_attr_parsing),
+		TEST_CASE(test_flow_parser_public_pattern_parsing),
+		TEST_CASE(test_flow_parser_public_actions_parsing),
+		TEST_CASE(test_flow_parser_public_invalid_args),
+		TEST_CASE(test_flow_parser_public_invalid_syntax),
+		TEST_CASE(test_flow_parser_public_parse_flow_rule),
+		TEST_CASE(test_flow_parser_no_registration),
+		TEST_CASES_END()
+	}
+};
+
+static int
+test_flow_parser_simple(void)
+{
+	return unit_test_suite_runner(&flow_parser_simple_tests);
+}
+
+REGISTER_FAST_TEST(flow_parser_simple_autotest, NOHUGE_OK, ASAN_OK,
+		   test_flow_parser_simple);
-- 
2.43.7

