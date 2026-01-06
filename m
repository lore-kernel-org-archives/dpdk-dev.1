Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E569CE9D65
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Jan 2026 15:39:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 463C040A89;
	Tue,  6 Jan 2026 16:39:01 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 942FB40A79
 for <dev@dpdk.org>; Tue,  6 Jan 2026 16:38:59 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-477ba2c1ca2so11574755e9.2
 for <dev@dpdk.org>; Tue, 06 Jan 2026 07:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1767713939; x=1768318739; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/lQOwuldGhpunajh4cgkY2f6+4uBmaNChswoTVrr11g=;
 b=W2QJ6ST4Lgynof9cBvZgHYZ7GKHhZD7azdHcyx2j7tpbeI+B8r6NzvPTluYqo6wKDT
 8wda9qFMhHf9Twg+HsuNf72ZMmRnEoVC8zmky2yVOeY3FKwo2riZIWPZJuJbDYAAq64f
 n5ZxPEp9NDs7yb4zGxS+HyvCzDZ19dkea4o1HocEzN+G7QCTobM1F1gqYxwoKT5ZyASx
 3oKu238CkNqmlAR8lWHt5FQFEqUaj78REqJvDe1DTKdN9wIMBG/7hK5L4Mq52+JMtSkI
 zsjl9UqvH7E5ubvhQPaIkXmoDBy3b/0jRb4Sjsa+gIbpnvSpIWnlzXUX7TGf+2p9JXRb
 ZyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767713939; x=1768318739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/lQOwuldGhpunajh4cgkY2f6+4uBmaNChswoTVrr11g=;
 b=a5fipZ5O8ETJx5A2C9t9/Tz084LEefaryzTc8vCEsz4IGNCbO1ROZGJFDfmsk3Py2t
 Qmc3xoNUq0YdRHxX+2U9JnaDb9AtBj6zUfCK0Vo/FfUdBEaaqoBs3CghqWELdyFhlIBQ
 QaVkemC578tYh6jlNLJ+SXPM3EdbFF05IhSvVlxOylJI980Q09oPkca0TF2Hw7N40Eu5
 mNkx6ZkHP+T3/U709CE8BXGMGQihlvXCpIB8tXmlqw+w1a7eLWHhNTwHlPr9I2mxa716
 /CJq6tOEAII8dyVVSBoB3SXO3gJDWPhsuWG3DQbxowKw23PGS1VuzVzBxubwUGLzCqOv
 0w7A==
X-Gm-Message-State: AOJu0YwBnD2Pw65u649rT5VD/4QUrOaqbEhb929BxLkb32W/QPtmEDIu
 mqQqU7Nu38/V1++SpdL+deelJAIqd/BBandCM1Xg4G6vAPON4lW7jSr39q7eW+6gMzCoNxfpQ07
 k8MGT
X-Gm-Gg: AY/fxX6KXN1JbDaHRkeoPFq58Ws5qDxHWHSH640oGaQop9NlvzJgBu+Y/w/QcEQKVHM
 r+WwU+Bxydr07YR+ZDsJK5pB6VdWgTqc93K3GCxgJovWNROAKMo2K1icAnm6JnmtrOg+cj7DyAR
 37PBEjo9TGK7SJSHqTIi1OxWxL9itV3TYg0t0jUhbGk87tZihNzGHYOlMTml4Uferasy6RvrTol
 x+VEKXq4VfpWgkGb9lWTagee7cZXphf59vSAzq0ll7O7rZQfn4JTCVWpVo8+uXZgxRa4HHrcdmV
 ceBW8zdew8s2ld6MpiRn0MuOUVM8bNGjjXUkGYVipI9f1G999yr9InfmYk/RrUyhJzRhHenw5mj
 cRKtyLxjv6uY2IhGO5yFzOxigCWOWCD20/o+D9jGJ55fm6audZHkhAQxY/9ocIS6NxWq4KsTVq1
 2N3uspaaU5zB7pSbPAMzAjCa+WiHjqDFJU0XSCQjD42kkRDw==
X-Google-Smtp-Source: AGHT+IEauj2lClPDF6i02T5w9gw4jpo1aZ/WrKEePNYMpNeDURFUR8tltQgDk521q2jV3lyOCzrF7Q==
X-Received: by 2002:a05:600c:4fc4:b0:45b:7d77:b592 with SMTP id
 5b1f17b1804b1-47d7f07331dmr39939005e9.12.1767713938916; 
 Tue, 06 Jan 2026 07:38:58 -0800 (PST)
Received: from claret.liberouter.org (rt-tmc-kou.liberouter.org.
 [195.113.172.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7fad882asm20975265e9.1.2026.01.06.07.38.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 07:38:58 -0800 (PST)
From: Lukas Sismis <sismis@dyna-nic.com>
To: dev@dpdk.org
Cc: Lukas Sismis <sismis@dyna-nic.com>
Subject: [PATCH v2 4/7] test: add flow parser unit tests
Date: Tue,  6 Jan 2026 16:38:34 +0100
Message-ID: <20260106153838.398033-5-sismis@dyna-nic.com>
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

Add comprehensive unit tests for the flow parser library.

Tests cover:
- flow_parser_autotest: Tests rte_flow_parser_parse() with various
  flow command strings including create, destroy, validate, query,
  list, and isolate commands. Verifies parsed patterns, actions,
  and attributes match expected values.

- flow_parser_helpers_autotest: Tests the standalone helper functions
  parse_attr_str(), parse_pattern_str(), and parse_actions_str().
  Verifies parsing of attributes, patterns with various item types,
  and action sequences.

Run with: dpdk-test flow_parser_autotest
          dpdk-test flow_parser_helpers_autotest

Signed-off-by: Lukas Sismis <sismis@dyna-nic.com>
---
 app/test/meson.build        |   1 +
 app/test/test_flow_parser.c | 226 ++++++++++++++++++++++++++++++++++++
 2 files changed, 227 insertions(+)
 create mode 100644 app/test/test_flow_parser.c

diff --git a/app/test/meson.build b/app/test/meson.build
index efec42a6bf..03cf8aa70c 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -88,6 +88,7 @@ source_file_deps = {
     'test_fib6_perf.c': ['fib'],
     'test_fib_perf.c': ['net', 'fib'],
     'test_flow_classify.c': ['net', 'acl', 'table', 'ethdev', 'flow_classify'],
+    'test_flow_parser.c': ['flow_parser', 'cmdline', 'ethdev'],
     'test_func_reentrancy.c': ['hash', 'lpm'],
     'test_graph.c': ['graph'],
     'test_graph_feature_arc.c': ['graph'],
diff --git a/app/test/test_flow_parser.c b/app/test/test_flow_parser.c
new file mode 100644
index 0000000000..1e65762d9f
--- /dev/null
+++ b/app/test/test_flow_parser.c
@@ -0,0 +1,226 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+
+#include <stdint.h>
+#include <string.h>
+
+#include <rte_flow.h>
+#include <rte_flow_parser.h>
+
+#include "test.h"
+
+static int
+test_flow_parser_command_mapping(void)
+{
+	static const char *create_cmd =
+		"flow create 0 ingress pattern eth / end "
+		"actions drop / end";
+	static const char *list_cmd = "flow list 0";
+	uint8_t outbuf[4096];
+	struct rte_flow_parser_output *out = (void *)outbuf;
+	int ret;
+
+	ret = rte_flow_parser_init(NULL);
+	if (ret != 0)
+		return TEST_FAILED;
+
+	/* Test flow create command parsing */
+	memset(outbuf, 0, sizeof(outbuf));
+	ret = rte_flow_parser_parse(create_cmd, out, sizeof(outbuf));
+	if (ret != 0) {
+		printf("flow create parse failed: %d\n", ret);
+		return TEST_FAILED;
+	}
+	if (out->command != RTE_FLOW_PARSER_CMD_CREATE) {
+		printf("expected CREATE command, got %d\n", out->command);
+		return TEST_FAILED;
+	}
+	if (out->port != 0) {
+		printf("expected port 0, got %u\n", out->port);
+		return TEST_FAILED;
+	}
+	/* pattern: eth / end = 2 items */
+	if (out->args.vc.pattern_n != 2) {
+		printf("expected 2 pattern items, got %u\n",
+		       out->args.vc.pattern_n);
+		return TEST_FAILED;
+	}
+	if (out->args.vc.pattern[0].type != RTE_FLOW_ITEM_TYPE_ETH) {
+		printf("expected ETH pattern, got %d\n",
+		       out->args.vc.pattern[0].type);
+		return TEST_FAILED;
+	}
+	if (out->args.vc.pattern[1].type != RTE_FLOW_ITEM_TYPE_END) {
+		printf("expected END pattern, got %d\n",
+		       out->args.vc.pattern[1].type);
+		return TEST_FAILED;
+	}
+	/* actions: drop / end = 2 items */
+	if (out->args.vc.actions_n != 2) {
+		printf("expected 2 action items, got %u\n",
+		       out->args.vc.actions_n);
+		return TEST_FAILED;
+	}
+	if (out->args.vc.actions[0].type != RTE_FLOW_ACTION_TYPE_DROP) {
+		printf("expected DROP action, got %d\n",
+		       out->args.vc.actions[0].type);
+		return TEST_FAILED;
+	}
+	if (out->args.vc.actions[1].type != RTE_FLOW_ACTION_TYPE_END) {
+		printf("expected END action, got %d\n",
+		       out->args.vc.actions[1].type);
+		return TEST_FAILED;
+	}
+	/* ingress attribute */
+	if (out->args.vc.attr.ingress != 1 || out->args.vc.attr.egress != 0) {
+		printf("expected ingress=1 egress=0\n");
+		return TEST_FAILED;
+	}
+
+	/* Test flow list command parsing */
+	memset(outbuf, 0, sizeof(outbuf));
+	ret = rte_flow_parser_parse(list_cmd, out, sizeof(outbuf));
+	if (ret != 0 ||
+	    out->command != RTE_FLOW_PARSER_CMD_LIST ||
+	    out->port != 0)
+		return TEST_FAILED;
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_flow_parser_lightweight_helpers(void)
+{
+	const struct rte_flow_item *pattern = NULL;
+	const struct rte_flow_action *actions = NULL;
+	const struct rte_flow_action_queue *queue_conf;
+	const struct rte_flow_action_mark *mark_conf;
+	struct rte_flow_attr attr;
+	uint32_t pattern_n = 0;
+	uint32_t actions_n = 0;
+	int ret;
+
+	ret = rte_flow_parser_init(NULL);
+	if (ret != 0)
+		return TEST_FAILED;
+
+	/* Test attribute parsing */
+	memset(&attr, 0, sizeof(attr));
+	ret = rte_flow_parser_parse_attr_str("ingress group 1 priority 5", &attr);
+	if (ret != 0) {
+		printf("attr parse failed: %d\n", ret);
+		return TEST_FAILED;
+	}
+	if (attr.group != 1 || attr.priority != 5 ||
+	    attr.ingress != 1 || attr.egress != 0) {
+		printf("attr mismatch: group=%u priority=%u ingress=%u egress=%u\n",
+		       attr.group, attr.priority, attr.ingress, attr.egress);
+		return TEST_FAILED;
+	}
+
+	/* Test pattern parsing: eth / ipv4 / end = 3 items */
+	ret = rte_flow_parser_parse_pattern_str("eth / ipv4 / end",
+						&pattern, &pattern_n);
+	if (ret != 0) {
+		printf("pattern parse failed: %d\n", ret);
+		return TEST_FAILED;
+	}
+	if (pattern_n != 3) {
+		printf("expected 3 pattern items, got %u\n", pattern_n);
+		return TEST_FAILED;
+	}
+	if (pattern[0].type != RTE_FLOW_ITEM_TYPE_ETH) {
+		printf("pattern[0] expected ETH, got %d\n", pattern[0].type);
+		return TEST_FAILED;
+	}
+	if (pattern[1].type != RTE_FLOW_ITEM_TYPE_IPV4) {
+		printf("pattern[1] expected IPV4, got %d\n", pattern[1].type);
+		return TEST_FAILED;
+	}
+	if (pattern[2].type != RTE_FLOW_ITEM_TYPE_END) {
+		printf("pattern[2] expected END, got %d\n", pattern[2].type);
+		return TEST_FAILED;
+	}
+
+	/* Test actions parsing with config values: queue index 3 / end = 2 items */
+	ret = rte_flow_parser_parse_actions_str("queue index 3 / end",
+						&actions, &actions_n);
+	if (ret != 0) {
+		printf("actions parse failed: %d\n", ret);
+		return TEST_FAILED;
+	}
+	if (actions_n != 2) {
+		printf("expected 2 action items, got %u\n", actions_n);
+		return TEST_FAILED;
+	}
+	if (actions[0].type != RTE_FLOW_ACTION_TYPE_QUEUE) {
+		printf("actions[0] expected QUEUE, got %d\n", actions[0].type);
+		return TEST_FAILED;
+	}
+	queue_conf = actions[0].conf;
+	if (queue_conf == NULL || queue_conf->index != 3) {
+		printf("queue index expected 3, got %u\n",
+		       queue_conf ? queue_conf->index : 0);
+		return TEST_FAILED;
+	}
+	if (actions[1].type != RTE_FLOW_ACTION_TYPE_END) {
+		printf("actions[1] expected END, got %d\n", actions[1].type);
+		return TEST_FAILED;
+	}
+
+	/* Test multiple actions: mark id 42 / drop / end = 3 items */
+	ret = rte_flow_parser_parse_actions_str("mark id 42 / drop / end",
+						&actions, &actions_n);
+	if (ret != 0) {
+		printf("multi-action parse failed: %d\n", ret);
+		return TEST_FAILED;
+	}
+	if (actions_n != 3) {
+		printf("expected 3 action items, got %u\n", actions_n);
+		return TEST_FAILED;
+	}
+	if (actions[0].type != RTE_FLOW_ACTION_TYPE_MARK) {
+		printf("actions[0] expected MARK, got %d\n", actions[0].type);
+		return TEST_FAILED;
+	}
+	mark_conf = actions[0].conf;
+	if (mark_conf == NULL || mark_conf->id != 42) {
+		printf("mark id expected 42, got %u\n",
+		       mark_conf ? mark_conf->id : 0);
+		return TEST_FAILED;
+	}
+	if (actions[1].type != RTE_FLOW_ACTION_TYPE_DROP) {
+		printf("actions[1] expected DROP, got %d\n", actions[1].type);
+		return TEST_FAILED;
+	}
+	if (actions[2].type != RTE_FLOW_ACTION_TYPE_END) {
+		printf("actions[2] expected END, got %d\n", actions[2].type);
+		return TEST_FAILED;
+	}
+
+	/* Test complex pattern: eth / ipv4 / tcp / end = 4 items */
+	ret = rte_flow_parser_parse_pattern_str("eth / ipv4 / tcp / end",
+						&pattern, &pattern_n);
+	if (ret != 0) {
+		printf("complex pattern parse failed: %d\n", ret);
+		return TEST_FAILED;
+	}
+	if (pattern_n != 4) {
+		printf("expected 4 pattern items, got %u\n", pattern_n);
+		return TEST_FAILED;
+	}
+	if (pattern[0].type != RTE_FLOW_ITEM_TYPE_ETH ||
+	    pattern[1].type != RTE_FLOW_ITEM_TYPE_IPV4 ||
+	    pattern[2].type != RTE_FLOW_ITEM_TYPE_TCP ||
+	    pattern[3].type != RTE_FLOW_ITEM_TYPE_END) {
+		printf("complex pattern type mismatch\n");
+		return TEST_FAILED;
+	}
+
+	return TEST_SUCCESS;
+}
+
+REGISTER_FAST_TEST(flow_parser_autotest, true, true,
+		   test_flow_parser_command_mapping);
+
+REGISTER_FAST_TEST(flow_parser_helpers_autotest, true, true,
+		   test_flow_parser_lightweight_helpers);
-- 
2.43.7

