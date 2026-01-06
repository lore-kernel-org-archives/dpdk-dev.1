Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5504ACE9D7D
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Jan 2026 16:37:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9403A4069F;
	Tue,  6 Jan 2026 17:37:15 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 366AF4069F
 for <dev@dpdk.org>; Tue,  6 Jan 2026 17:37:14 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-47775fb6cb4so6981905e9.0
 for <dev@dpdk.org>; Tue, 06 Jan 2026 08:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767717434;
 x=1768322234; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WPQEmXIeCr9P5lS6nKn9wIR5cQdyJ9s6J9uyq7ItUVg=;
 b=Cl+fYPF4buXzo/Ae/IwkTXAAw7u61gLkeOelLK4OwWdFifcxgFhBknQ4GRiYzTQqJI
 WkMQb/Q53Q5CvLvWtRKNX5ejaZyjo2nCl/dm9AJ8q8A3bTkmyABpWU6sOtvtjT2ZsDJh
 5AFAKhE86jiK+65XQSuQayLiDDPSYbjeAzF6YCnkXqqpOuJt9jLRnO/IMOyxYGKA0Nls
 +uLyimjv29/cNUUwKe0ySuQ9wH3xJKRklk14KkzU0QWG9gBlqjrnuADkrUNFl5iwU5sY
 Pk440cbKSivTreoxh8z+lBKJD7VwhQsoGQy2QaXbh3OgxYdu3OU0SpzzePTDnjn+OOIE
 DnOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767717434; x=1768322234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WPQEmXIeCr9P5lS6nKn9wIR5cQdyJ9s6J9uyq7ItUVg=;
 b=p3+Xi6jW2D+97OeMFWF6IiEMOnwxYFhN33dYpW2j56ZNfDQR3uWY9dfMx6+M7JagHO
 SVA2eNBbvcoIL+9THjNKasCm4wSKp1PQEWFokGU/qdW/u/Cl3sMuk/3N40IpfN1DE3mo
 seP1+KYtnJ4F1kaDj2o4Barxe3q0ZO9taa4PPX8ArmFbZ61mFNPjHpSxPGWMXUzlorFg
 vTZtCbdPJEBDWZ/gO3Q/zwbtDiqhqAV7ClnW+zQWfxo7wX0HkNT/9MG9QBW0NuSz6ZDn
 qoXxS5TCUX6QlRIDy9Ey7lYeFdDZsk7wLT8I2z2ezJ7F0mU2iPe5f2DolXMJ6twfaLEu
 RYDg==
X-Gm-Message-State: AOJu0YzjeQb5O7ud4sTck3iSg3bOa9hNVl4mCLV8u6xBFkghm/uSvefU
 2ZDJgoND9tb0zmHcjMG0r1OfPs9x0TOT+DwOR/4mBc1/VXn6gF7sE6gwDbYOGB80G0BR3nqOWTy
 YgQd3b74=
X-Gm-Gg: AY/fxX6VVjRyyAa2JzWJzPGCQ63LX5JZAPiPZO5Jdn5YuvZWavx0UqdIq9CNF7cs1WU
 YAHr2GLcUNjLzE+aKdw/ObifM22E+/2itEyrUypwUX9XEMJdjcQ5CAmDp+BEP5h7Ee4RYJ04Yyy
 ABNZurj+csnbgAWvyawLrc5pBJeOHj48PmuYuu+8MPW43PhzTmxA0H08fMZhOFeqJGUJw7gI/wg
 w7KiUj8efXPdqfclO88vFyKAq3Vb3Q7AFmo2j5yiuy2f9fWGoNP9ShBi1hW2jbqbZsLvvTqFIYJ
 DBB6iuliV261uol01s9oH3mdSaSgn/dei41ByX2Ctvr8E9ZWlpNAVH63AOQKCb8IEmejqfRPZ9P
 m8aacRXWmHifNelyvlggByf9ki7C+s2I+FYknklKZfO+zmOk471fpU79sAGI+oMj+5P6/yCmJM4
 J5HgLi1e/DT8y3wATVt00mpqHa5e/fv4O9WmCODT1sYC1ZTlrAMQYn
X-Google-Smtp-Source: AGHT+IGQUnVrnO3VsUZBPKInXIh5rfpkHfPYLxhXIN5eqc0KscvbLxjZM2/hGBIElyLr2SN+OI40yQ==
X-Received: by 2002:a05:600c:4ed3:b0:477:aed0:f401 with SMTP id
 5b1f17b1804b1-47d7f0976a3mr41417575e9.23.1767717433747; 
 Tue, 06 Jan 2026 08:37:13 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0daa84sm5224396f8f.2.2026.01.06.08.37.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 08:37:13 -0800 (PST)
Date: Tue, 6 Jan 2026 08:37:09 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Lukas Sismis <sismis@dyna-nic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 4/5] test: add flow parser unit tests
Message-ID: <20260106083709.3751c70c@phoenix.local>
In-Reply-To: <20260105213025.749383-5-sismis@dyna-nic.com>
References: <20260105213025.749383-1-sismis@dyna-nic.com>
 <20260105213025.749383-5-sismis@dyna-nic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon,  5 Jan 2026 22:30:22 +0100
Lukas Sismis <sismis@dyna-nic.com> wrote:

> Add comprehensive unit tests for the flow parser library.
> 
> Tests cover:
> - flow_parser_autotest: Tests rte_flow_parser_parse() with various
>   flow command strings including create, destroy, validate, query,
>   list, and isolate commands. Verifies parsed patterns, actions,
>   and attributes match expected values.
> 
> - flow_parser_helpers_autotest: Tests the standalone helper functions
>   parse_attr_str(), parse_pattern_str(), and parse_actions_str().
>   Verifies parsing of attributes, patterns with various item types,
>   and action sequences.
> 
> Run with: dpdk-test flow_parser_autotest
>           dpdk-test flow_parser_helpers_autotest
> 
> Signed-off-by: Lukas Sismis <sismis@dyna-nic.com>
> ---
>  app/test/meson.build        |   1 +
>  app/test/test_flow_parser.c | 226 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 227 insertions(+)
>  create mode 100644 app/test/test_flow_parser.c
> 
> diff --git a/app/test/meson.build b/app/test/meson.build
> index efec42a6bf..03cf8aa70c 100644
> --- a/app/test/meson.build
> +++ b/app/test/meson.build
> @@ -88,6 +88,7 @@ source_file_deps = {
>      'test_fib6_perf.c': ['fib'],
>      'test_fib_perf.c': ['net', 'fib'],
>      'test_flow_classify.c': ['net', 'acl', 'table', 'ethdev', 'flow_classify'],
> +    'test_flow_parser.c': ['flow_parser', 'cmdline', 'ethdev'],
>      'test_func_reentrancy.c': ['hash', 'lpm'],
>      'test_graph.c': ['graph'],
>      'test_graph_feature_arc.c': ['graph'],
> diff --git a/app/test/test_flow_parser.c b/app/test/test_flow_parser.c
> new file mode 100644
> index 0000000000..1e65762d9f
> --- /dev/null
> +++ b/app/test/test_flow_parser.c
> @@ -0,0 +1,226 @@
> +/* SPDX-License-Identifier: BSD-3-Clause */
> +
> +#include <stdint.h>
> +#include <string.h>
> +
> +#include <rte_flow.h>
> +#include <rte_flow_parser.h>
> +
> +#include "test.h"
> +
> +static int
> +test_flow_parser_command_mapping(void)
> +{
> +	static const char *create_cmd =
> +		"flow create 0 ingress pattern eth / end "
> +		"actions drop / end";
> +	static const char *list_cmd = "flow list 0";
> +	uint8_t outbuf[4096];
> +	struct rte_flow_parser_output *out = (void *)outbuf;
> +	int ret;
> +
> +	ret = rte_flow_parser_init(NULL);
> +	if (ret != 0)
> +		return TEST_FAILED;
> +
> +	/* Test flow create command parsing */
> +	memset(outbuf, 0, sizeof(outbuf));
> +	ret = rte_flow_parser_parse(create_cmd, out, sizeof(outbuf));
> +	if (ret != 0) {
> +		printf("flow create parse failed: %d\n", ret);
> +		return TEST_FAILED;
> +	}
> +	if (out->command != RTE_FLOW_PARSER_CMD_CREATE) {
> +		printf("expected CREATE command, got %d\n", out->command);
> +		return TEST_FAILED;
> +	}
> +	if (out->port != 0) {
> +		printf("expected port 0, got %u\n", out->port);
> +		return TEST_FAILED;
> +	}
> +	/* pattern: eth / end = 2 items */
> +	if (out->args.vc.pattern_n != 2) {
> +		printf("expected 2 pattern items, got %u\n",
> +		       out->args.vc.pattern_n);
> +		return TEST_FAILED;
> +	}
> +	if (out->args.vc.pattern[0].type != RTE_FLOW_ITEM_TYPE_ETH) {
> +		printf("expected ETH pattern, got %d\n",
> +		       out->args.vc.pattern[0].type);
> +		return TEST_FAILED;
> +	}
> +	if (out->args.vc.pattern[1].type != RTE_FLOW_ITEM_TYPE_END) {
> +		printf("expected END pattern, got %d\n",
> +		       out->args.vc.pattern[1].type);
> +		return TEST_FAILED;
> +	}
> +	/* actions: drop / end = 2 items */
> +	if (out->args.vc.actions_n != 2) {
> +		printf("expected 2 action items, got %u\n",
> +		       out->args.vc.actions_n);
> +		return TEST_FAILED;
> +	}
> +	if (out->args.vc.actions[0].type != RTE_FLOW_ACTION_TYPE_DROP) {
> +		printf("expected DROP action, got %d\n",
> +		       out->args.vc.actions[0].type);
> +		return TEST_FAILED;
> +	}
> +	if (out->args.vc.actions[1].type != RTE_FLOW_ACTION_TYPE_END) {
> +		printf("expected END action, got %d\n",
> +		       out->args.vc.actions[1].type);
> +		return TEST_FAILED;
> +	}
> +	/* ingress attribute */
> +	if (out->args.vc.attr.ingress != 1 || out->args.vc.attr.egress != 0) {
> +		printf("expected ingress=1 egress=0\n");
> +		return TEST_FAILED;
> +	}
> +
> +	/* Test flow list command parsing */
> +	memset(outbuf, 0, sizeof(outbuf));
> +	ret = rte_flow_parser_parse(list_cmd, out, sizeof(outbuf));
> +	if (ret != 0 ||
> +	    out->command != RTE_FLOW_PARSER_CMD_LIST ||
> +	    out->port != 0)
> +		return TEST_FAILED;
> +
> +	return TEST_SUCCESS;
> +}
> +
> +static int
> +test_flow_parser_lightweight_helpers(void)
> +{
> +	const struct rte_flow_item *pattern = NULL;
> +	const struct rte_flow_action *actions = NULL;
> +	const struct rte_flow_action_queue *queue_conf;
> +	const struct rte_flow_action_mark *mark_conf;
> +	struct rte_flow_attr attr;
> +	uint32_t pattern_n = 0;
> +	uint32_t actions_n = 0;
> +	int ret;
> +
> +	ret = rte_flow_parser_init(NULL);
> +	if (ret != 0)
> +		return TEST_FAILED;
> +
> +	/* Test attribute parsing */
> +	memset(&attr, 0, sizeof(attr));
> +	ret = rte_flow_parser_parse_attr_str("ingress group 1 priority 5", &attr);
> +	if (ret != 0) {
> +		printf("attr parse failed: %d\n", ret);
> +		return TEST_FAILED;
> +	}
> +	if (attr.group != 1 || attr.priority != 5 ||
> +	    attr.ingress != 1 || attr.egress != 0) {
> +		printf("attr mismatch: group=%u priority=%u ingress=%u egress=%u\n",
> +		       attr.group, attr.priority, attr.ingress, attr.egress);
> +		return TEST_FAILED;
> +	}
> +
> +	/* Test pattern parsing: eth / ipv4 / end = 3 items */
> +	ret = rte_flow_parser_parse_pattern_str("eth / ipv4 / end",
> +						&pattern, &pattern_n);
> +	if (ret != 0) {
> +		printf("pattern parse failed: %d\n", ret);
> +		return TEST_FAILED;
> +	}
> +	if (pattern_n != 3) {
> +		printf("expected 3 pattern items, got %u\n", pattern_n);
> +		return TEST_FAILED;
> +	}
> +	if (pattern[0].type != RTE_FLOW_ITEM_TYPE_ETH) {
> +		printf("pattern[0] expected ETH, got %d\n", pattern[0].type);
> +		return TEST_FAILED;
> +	}
> +	if (pattern[1].type != RTE_FLOW_ITEM_TYPE_IPV4) {
> +		printf("pattern[1] expected IPV4, got %d\n", pattern[1].type);
> +		return TEST_FAILED;
> +	}
> +	if (pattern[2].type != RTE_FLOW_ITEM_TYPE_END) {
> +		printf("pattern[2] expected END, got %d\n", pattern[2].type);
> +		return TEST_FAILED;
> +	}
> +
> +	/* Test actions parsing with config values: queue index 3 / end = 2 items */
> +	ret = rte_flow_parser_parse_actions_str("queue index 3 / end",
> +						&actions, &actions_n);
> +	if (ret != 0) {
> +		printf("actions parse failed: %d\n", ret);
> +		return TEST_FAILED;
> +	}
> +	if (actions_n != 2) {
> +		printf("expected 2 action items, got %u\n", actions_n);
> +		return TEST_FAILED;
> +	}
> +	if (actions[0].type != RTE_FLOW_ACTION_TYPE_QUEUE) {
> +		printf("actions[0] expected QUEUE, got %d\n", actions[0].type);
> +		return TEST_FAILED;
> +	}
> +	queue_conf = actions[0].conf;
> +	if (queue_conf == NULL || queue_conf->index != 3) {
> +		printf("queue index expected 3, got %u\n",
> +		       queue_conf ? queue_conf->index : 0);
> +		return TEST_FAILED;
> +	}
> +	if (actions[1].type != RTE_FLOW_ACTION_TYPE_END) {
> +		printf("actions[1] expected END, got %d\n", actions[1].type);
> +		return TEST_FAILED;
> +	}
> +
> +	/* Test multiple actions: mark id 42 / drop / end = 3 items */
> +	ret = rte_flow_parser_parse_actions_str("mark id 42 / drop / end",
> +						&actions, &actions_n);
> +	if (ret != 0) {
> +		printf("multi-action parse failed: %d\n", ret);
> +		return TEST_FAILED;
> +	}
> +	if (actions_n != 3) {
> +		printf("expected 3 action items, got %u\n", actions_n);
> +		return TEST_FAILED;
> +	}
> +	if (actions[0].type != RTE_FLOW_ACTION_TYPE_MARK) {
> +		printf("actions[0] expected MARK, got %d\n", actions[0].type);
> +		return TEST_FAILED;
> +	}
> +	mark_conf = actions[0].conf;
> +	if (mark_conf == NULL || mark_conf->id != 42) {
> +		printf("mark id expected 42, got %u\n",
> +		       mark_conf ? mark_conf->id : 0);
> +		return TEST_FAILED;
> +	}
> +	if (actions[1].type != RTE_FLOW_ACTION_TYPE_DROP) {
> +		printf("actions[1] expected DROP, got %d\n", actions[1].type);
> +		return TEST_FAILED;
> +	}
> +	if (actions[2].type != RTE_FLOW_ACTION_TYPE_END) {
> +		printf("actions[2] expected END, got %d\n", actions[2].type);
> +		return TEST_FAILED;
> +	}
> +
> +	/* Test complex pattern: eth / ipv4 / tcp / end = 4 items */
> +	ret = rte_flow_parser_parse_pattern_str("eth / ipv4 / tcp / end",
> +						&pattern, &pattern_n);
> +	if (ret != 0) {
> +		printf("complex pattern parse failed: %d\n", ret);
> +		return TEST_FAILED;
> +	}
> +	if (pattern_n != 4) {
> +		printf("expected 4 pattern items, got %u\n", pattern_n);
> +		return TEST_FAILED;
> +	}
> +	if (pattern[0].type != RTE_FLOW_ITEM_TYPE_ETH ||
> +	    pattern[1].type != RTE_FLOW_ITEM_TYPE_IPV4 ||
> +	    pattern[2].type != RTE_FLOW_ITEM_TYPE_TCP ||
> +	    pattern[3].type != RTE_FLOW_ITEM_TYPE_END) {
> +		printf("complex pattern type mismatch\n");
> +		return TEST_FAILED;
> +	}
> +
> +	return TEST_SUCCESS;
> +}
> +
> +REGISTER_FAST_TEST(flow_parser_autotest, true, true,
> +		   test_flow_parser_command_mapping);
> +
> +REGISTER_FAST_TEST(flow_parser_helpers_autotest, true, true,
> +		   test_flow_parser_lightweight_helpers);

Test looks good.
My preference is for tests to use the macros like TEST_ASSERT() in test.h
since then it makes fixing them easier.

Also if there are multiple tests uses unit test runner instead of one big
test or registering multiple tests.

