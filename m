Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE107606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=S//qO2b3
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C3EB4067C;
	Tue, 27 Oct 2026 10:50:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTPS id 6D658400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 10:50:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793094639; x=1824630639;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=AawmF5J6u6jx4O9ecTQjU0NMAzEOvd02+c7ob3KxAZY=;
 b=S//qO2b3MbN7E0S3+70PhB0DKefRzysHS5x6JbTN+0UQXeadvNoi5Bha
 yuXo8xS2bDg22qOYRT4x6fMoi0DViT3/aYTtkgnzrMAeLkoPjDkDCvFzJ
 3sQ8bZRRxFT2ANE0Lo/ZW6t6Oiggg8Qku3yZgyY+9Zdovj8XtvY6/Ph0Q
 UGyb+zmMe0CD+2ICiZIfvuW+mIsnVUSLzVOmoQfs5AL9pM56Uke8QpT9m
 QHLJ22qdUyg5FIww81vpfzkgOdBvuPIMQZNaygcsuQ4hSF7To2RbrmbdD
 j0LUWYrZGNjukqGjvV5cwz8gkOF8d30WAX3be8Uf3/HvBGMFxKw+uULR+ A==;
X-CSE-ConnectionGUID: WhZHyYWERE2AhGQUuwud2A==
X-CSE-MsgGUID: a7/JqXwbQHaYnExLN43EGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1674918"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1674918"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 02:50:35 -0700
X-CSE-ConnectionGUID: OiGwhjFESbeWAX730uIUCQ==
X-CSE-MsgGUID: uQ3OGQyBSnWk4SOVkbPmvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="6250896"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa012.fm.intel.com with ESMTP; 27 Oct 2026 02:50:23 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v4 5/6] test/ethdev: add flow conversion tests
Date: Tue, 27 Oct 2026 09:50:12 +0000
Message-ID: <0172901b5acdf5960a95b28646b11f723670b0d1.1793094529.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <5698ccb3daeebd1d50346d5a3bd8471468056463.1793094528.git.anatoly.burakov@intel.com>
References: 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a unit test for rte_flow_conv(), which so far had no coverage.
Cover the item and action name lookups, the item default mask lookup,
pattern and action list conversion with deep copied specification
data, and check that every public item and action type has an entry
in the conversion descriptor tables.

Note that this test is fragile in the sense that because item type list
does not provide a "max" value, each time a new item is added, the max item
value must be updated.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 app/test/meson.build             |   1 +
 app/test/test_ethdev_flow_conv.c | 420 +++++++++++++++++++++++++++++++
 2 files changed, 421 insertions(+)
 create mode 100644 app/test/test_ethdev_flow_conv.c

diff --git a/app/test/meson.build b/app/test/meson.build
index 9805cf5bee8..30dd1fcf832 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -77,6 +77,7 @@ source_file_deps = {
     'test_efd_perf.c': ['efd', 'hash'],
     'test_errno.c': [],
     'test_ethdev_api.c': ['ethdev'],
+    'test_ethdev_flow_conv.c': ['ethdev'],
     'test_ethdev_link.c': ['ethdev'],
     'test_ethdev_module_eeprom.c': ['ethdev'],
     'test_event_crypto_adapter.c': ['cryptodev', 'eventdev', 'bus_vdev'],
diff --git a/app/test/test_ethdev_flow_conv.c b/app/test/test_ethdev_flow_conv.c
new file mode 100644
index 00000000000..39a59dd07a1
--- /dev/null
+++ b/app/test/test_ethdev_flow_conv.c
@@ -0,0 +1,420 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+#include <stdalign.h>
+#include <string.h>
+
+#include <rte_common.h>
+#include <rte_errno.h>
+#include <rte_flow.h>
+
+#include "test.h"
+
+/*
+ * Last known item and action types. Every type up to and including these
+ * must have a descriptor entry in the ethdev flow conversion tables.
+ */
+#define LAST_ITEM_TYPE ((int)RTE_FLOW_ITEM_TYPE_COMPARE)
+#define LAST_ACTION_TYPE ((int)RTE_FLOW_ACTION_TYPE_JUMP_TO_TABLE_INDEX)
+
+/* Guaranteed to be out of range of every descriptor table. */
+#define BOGUS_TYPE INT32_MAX
+
+static int
+test_flow_conv_item_name(void)
+{
+	struct rte_flow_error error;
+	const char *name;
+	char buf[8];
+	int ret;
+
+	/* Name copy. */
+	ret = rte_flow_conv(RTE_FLOW_CONV_OP_ITEM_NAME, buf, sizeof(buf),
+			    RTE_CAST_PTR(const void *, RTE_FLOW_ITEM_TYPE_ETH), &error);
+	TEST_ASSERT_EQUAL(ret, (int)strlen("ETH"), "unexpected return %d",
+			  ret);
+	TEST_ASSERT_BUFFERS_ARE_EQUAL(buf, "ETH", strlen("ETH") + 1,
+				      "name mismatch");
+
+	/* Truncated copy reports the full length. */
+	ret = rte_flow_conv(RTE_FLOW_CONV_OP_ITEM_NAME, buf, 3,
+			    RTE_CAST_PTR(const void *, RTE_FLOW_ITEM_TYPE_MACSEC), &error);
+	TEST_ASSERT_EQUAL(ret, (int)strlen("MACSEC"), "unexpected return %d",
+			  ret);
+	TEST_ASSERT_BUFFERS_ARE_EQUAL(buf, "MA", 3, "truncated name mismatch");
+
+	/* Name pointer. */
+	name = NULL;
+	ret = rte_flow_conv(RTE_FLOW_CONV_OP_ITEM_NAME_PTR, &name,
+			    sizeof(name),
+			    RTE_CAST_PTR(const void *, RTE_FLOW_ITEM_TYPE_MACSEC), &error);
+	TEST_ASSERT_EQUAL(ret, (int)sizeof(const char **),
+			  "unexpected return %d", ret);
+	TEST_ASSERT_NOT_NULL(name, "name pointer not set");
+	TEST_ASSERT(strcmp(name, "MACSEC") == 0, "name mismatch: %s", name);
+
+	/* Out of range type. */
+	rte_errno = 0;
+	ret = rte_flow_conv(RTE_FLOW_CONV_OP_ITEM_NAME_PTR, &name,
+			    sizeof(name), RTE_CAST_PTR(const void *, BOGUS_TYPE), &error);
+	TEST_ASSERT_EQUAL(ret, -EINVAL, "unexpected return %d", ret);
+	TEST_ASSERT_EQUAL(rte_errno, EINVAL, "rte_errno %d", rte_errno);
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_flow_conv_action_name(void)
+{
+	struct rte_flow_error error;
+	const char *name;
+	int ret;
+
+	struct {
+		int type;
+		const char *name;
+	} const known[] = {
+		{ RTE_FLOW_ACTION_TYPE_END, "END" },
+		{ RTE_FLOW_ACTION_TYPE_QUEUE, "QUEUE" },
+		{ RTE_FLOW_ACTION_TYPE_SHARED, "SHARED" },
+		{ RTE_FLOW_ACTION_TYPE_METER_COLOR, "METER_COLOR" },
+		{ RTE_FLOW_ACTION_TYPE_SKIP_CMAN, "SKIP_CMAN" },
+		{ RTE_FLOW_ACTION_TYPE_JUMP_TO_TABLE_INDEX,
+		  "JUMP_TO_TABLE_INDEX" },
+	};
+
+	for (unsigned int i = 0; i < RTE_DIM(known); i++) {
+		name = NULL;
+		ret = rte_flow_conv(RTE_FLOW_CONV_OP_ACTION_NAME_PTR, &name,
+				    sizeof(name), RTE_CAST_PTR(const void *, known[i].type),
+				    &error);
+		TEST_ASSERT_EQUAL(ret, (int)sizeof(const char **),
+				  "action type %d: unexpected return %d",
+				  known[i].type, ret);
+		TEST_ASSERT_NOT_NULL(name, "action type %d: name not set",
+				     known[i].type);
+		TEST_ASSERT(strcmp(name, known[i].name) == 0,
+			    "action type %d: name %s, expected %s",
+			    known[i].type, name, known[i].name);
+	}
+
+	rte_errno = 0;
+	ret = rte_flow_conv(RTE_FLOW_CONV_OP_ACTION_NAME_PTR, &name,
+			    sizeof(name), RTE_CAST_PTR(const void *, BOGUS_TYPE), &error);
+	TEST_ASSERT_EQUAL(ret, -EINVAL, "unexpected return %d", ret);
+	TEST_ASSERT_EQUAL(rte_errno, EINVAL, "rte_errno %d", rte_errno);
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_flow_conv_item_default_mask(void)
+{
+	struct rte_flow_error error;
+	const void *mask;
+	int ret;
+
+	mask = NULL;
+	ret = rte_flow_conv(RTE_FLOW_CONV_OP_ITEM_DEFAULT_MASK_PTR, &mask,
+			    sizeof(mask), RTE_CAST_PTR(const void *, RTE_FLOW_ITEM_TYPE_ETH),
+			    &error);
+	TEST_ASSERT_EQUAL(ret, (int)sizeof(const void **),
+			  "unexpected return %d", ret);
+	/*
+	 * Default masks are static const in rte_flow.h, so each translation
+	 * unit has its own copy: compare contents, not addresses.
+	 */
+	TEST_ASSERT_NOT_NULL(mask, "ETH default mask not set");
+	TEST_ASSERT_BUFFERS_ARE_EQUAL(mask, &rte_flow_item_eth_mask,
+				      sizeof(rte_flow_item_eth_mask),
+				      "ETH default mask mismatch");
+
+	/* Known type without a default mask. */
+	mask = &error;
+	ret = rte_flow_conv(RTE_FLOW_CONV_OP_ITEM_DEFAULT_MASK_PTR, &mask,
+			    sizeof(mask), RTE_CAST_PTR(const void *, RTE_FLOW_ITEM_TYPE_END),
+			    &error);
+	TEST_ASSERT_EQUAL(ret, (int)sizeof(const void **),
+			  "unexpected return %d", ret);
+	TEST_ASSERT_NULL(mask, "END must not have a default mask");
+
+	rte_errno = 0;
+	ret = rte_flow_conv(RTE_FLOW_CONV_OP_ITEM_DEFAULT_MASK_PTR, &mask,
+			    sizeof(mask), RTE_CAST_PTR(const void *, BOGUS_TYPE), &error);
+	TEST_ASSERT_EQUAL(ret, -EINVAL, "unexpected return %d", ret);
+	TEST_ASSERT_EQUAL(rte_errno, EINVAL, "rte_errno %d", rte_errno);
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * Every public item and action type must have a descriptor entry.
+ * A missing entry would otherwise make the type unknown to all
+ * conversion operations.
+ */
+static int
+test_flow_conv_tables_complete(void)
+{
+	struct rte_flow_error error;
+	const char *name;
+	int ret;
+
+	for (int type = 0; type <= LAST_ITEM_TYPE; type++) {
+		name = NULL;
+		ret = rte_flow_conv(RTE_FLOW_CONV_OP_ITEM_NAME_PTR, &name,
+				    sizeof(name), RTE_CAST_PTR(const void *, type), &error);
+		TEST_ASSERT_EQUAL(ret, (int)sizeof(const char **),
+				  "item type %d has no descriptor", type);
+		TEST_ASSERT_NOT_NULL(name, "item type %d has no name", type);
+	}
+
+	for (int type = 0; type <= LAST_ACTION_TYPE; type++) {
+		name = NULL;
+		ret = rte_flow_conv(RTE_FLOW_CONV_OP_ACTION_NAME_PTR, &name,
+				    sizeof(name), RTE_CAST_PTR(const void *, type), &error);
+		TEST_ASSERT_EQUAL(ret, (int)sizeof(const char **),
+				  "action type %d has no descriptor", type);
+		TEST_ASSERT_NOT_NULL(name, "action type %d has no name", type);
+	}
+
+	return TEST_SUCCESS;
+}
+
+/* Convert a pattern and check spec/mask are deep copied using the table. */
+static int
+test_flow_conv_pattern(void)
+{
+	struct rte_flow_error error;
+	const struct rte_flow_item_eth eth_spec = {
+		.hdr.ether_type = RTE_BE16(RTE_ETHER_TYPE_IPV4),
+	};
+	const struct rte_flow_item_macsec macsec_spec = {
+		.macsec_hdr.tci_an = RTE_MACSEC_TCI_E | 0x1,
+		.macsec_hdr.short_length = 0x2a,
+		.macsec_hdr.packet_number = RTE_BE32(0x01020304),
+	};
+	const struct rte_flow_item_macsec macsec_mask = {
+		.macsec_hdr.tci_an = UINT8_MAX,
+		.macsec_hdr.short_length = 0x3f,
+		.macsec_hdr.packet_number = RTE_BE32(UINT32_MAX),
+	};
+	const struct rte_flow_item pattern[] = {
+		{
+			.type = RTE_FLOW_ITEM_TYPE_ETH,
+			.spec = &eth_spec,
+			.mask = &rte_flow_item_eth_mask,
+		},
+		{
+			.type = RTE_FLOW_ITEM_TYPE_MACSEC,
+			.spec = &macsec_spec,
+			.mask = &macsec_mask,
+		},
+		{
+			.type = RTE_FLOW_ITEM_TYPE_END,
+		},
+	};
+	alignas(double) uint8_t buf[512];
+	struct rte_flow_item *out = (struct rte_flow_item *)buf;
+	size_t needed;
+	int ret;
+
+	/* Size query. */
+	ret = rte_flow_conv(RTE_FLOW_CONV_OP_PATTERN, NULL, 0, pattern,
+			    &error);
+	TEST_ASSERT(ret > 0, "size query failed: %d (%s)", ret,
+		    error.message);
+	needed = ret;
+	TEST_ASSERT(needed >= RTE_DIM(pattern) * sizeof(*out) +
+		    sizeof(eth_spec) + sizeof(rte_flow_item_eth_mask) +
+		    sizeof(macsec_spec) + sizeof(macsec_mask),
+		    "size %zu too small to hold all items", needed);
+	TEST_ASSERT(needed <= sizeof(buf), "buffer too small: %zu", needed);
+
+	memset(buf, 0xff, sizeof(buf));
+	ret = rte_flow_conv(RTE_FLOW_CONV_OP_PATTERN, out, sizeof(buf),
+			    pattern, &error);
+	TEST_ASSERT_EQUAL(ret, (int)needed, "unexpected return %d", ret);
+
+	for (unsigned int i = 0; i < RTE_DIM(pattern); i++)
+		TEST_ASSERT_EQUAL(out[i].type, pattern[i].type,
+				  "item %u: type mismatch", i);
+
+	TEST_ASSERT_NOT_NULL(out[0].spec, "ETH spec not copied");
+	TEST_ASSERT(out[0].spec != pattern[0].spec, "ETH spec not deep copied");
+	TEST_ASSERT_BUFFERS_ARE_EQUAL(out[0].spec, &eth_spec, sizeof(eth_spec),
+				      "ETH spec mismatch");
+	TEST_ASSERT_NOT_NULL(out[0].mask, "ETH mask not copied");
+	TEST_ASSERT_BUFFERS_ARE_EQUAL(out[0].mask, &rte_flow_item_eth_mask,
+				      sizeof(rte_flow_item_eth_mask),
+				      "ETH mask mismatch");
+	TEST_ASSERT_NULL(out[0].last, "ETH last unexpectedly set");
+
+	TEST_ASSERT_NOT_NULL(out[1].spec, "MACSEC spec not copied");
+	TEST_ASSERT(out[1].spec != pattern[1].spec,
+		    "MACSEC spec not deep copied");
+	TEST_ASSERT_BUFFERS_ARE_EQUAL(out[1].spec, &macsec_spec,
+				      sizeof(macsec_spec),
+				      "MACSEC spec mismatch");
+	TEST_ASSERT_NOT_NULL(out[1].mask, "MACSEC mask not copied");
+	TEST_ASSERT_BUFFERS_ARE_EQUAL(out[1].mask, &macsec_mask,
+				      sizeof(macsec_mask),
+				      "MACSEC mask mismatch");
+
+	TEST_ASSERT_NULL(out[2].spec, "END spec unexpectedly set");
+	TEST_ASSERT_NULL(out[2].mask, "END mask unexpectedly set");
+
+	return TEST_SUCCESS;
+}
+
+/* Convert actions and check configuration is deep copied using the table. */
+static int
+test_flow_conv_actions(void)
+{
+	struct rte_flow_error error;
+	const struct rte_flow_action_meter_color meter_color = {
+		.color = RTE_COLOR_YELLOW,
+	};
+	const struct rte_flow_action_queue queue = {
+		.index = 7,
+	};
+	const struct rte_flow_action actions[] = {
+		{
+			.type = RTE_FLOW_ACTION_TYPE_SKIP_CMAN,
+		},
+		{
+			.type = RTE_FLOW_ACTION_TYPE_METER_COLOR,
+			.conf = &meter_color,
+		},
+		{
+			.type = RTE_FLOW_ACTION_TYPE_QUEUE,
+			.conf = &queue,
+		},
+		{
+			.type = RTE_FLOW_ACTION_TYPE_SHARED,
+			.conf = &queue,
+		},
+		{
+			.type = RTE_FLOW_ACTION_TYPE_END,
+		},
+	};
+	alignas(double) uint8_t buf[512];
+	struct rte_flow_action *out = (struct rte_flow_action *)buf;
+	size_t needed;
+	int ret;
+
+	ret = rte_flow_conv(RTE_FLOW_CONV_OP_ACTIONS, NULL, 0, actions,
+			    &error);
+	TEST_ASSERT(ret > 0, "size query failed: %d (%s)", ret,
+		    error.message);
+	needed = ret;
+	TEST_ASSERT(needed >= RTE_DIM(actions) * sizeof(*out) +
+		    sizeof(meter_color) + sizeof(queue),
+		    "size %zu too small to hold all actions", needed);
+	TEST_ASSERT(needed <= sizeof(buf), "buffer too small: %zu", needed);
+
+	memset(buf, 0xff, sizeof(buf));
+	ret = rte_flow_conv(RTE_FLOW_CONV_OP_ACTIONS, out, sizeof(buf),
+			    actions, &error);
+	TEST_ASSERT_EQUAL(ret, (int)needed, "unexpected return %d", ret);
+
+	for (unsigned int i = 0; i < RTE_DIM(actions); i++)
+		TEST_ASSERT_EQUAL(out[i].type, actions[i].type,
+				  "action %u: type mismatch", i);
+
+	TEST_ASSERT_NULL(out[0].conf, "SKIP_CMAN conf unexpectedly set");
+
+	TEST_ASSERT_NOT_NULL(out[1].conf, "METER_COLOR conf not copied");
+	TEST_ASSERT(out[1].conf != actions[1].conf,
+		    "METER_COLOR conf not deep copied");
+	TEST_ASSERT_BUFFERS_ARE_EQUAL(out[1].conf, &meter_color,
+				      sizeof(meter_color),
+				      "METER_COLOR conf mismatch");
+
+	TEST_ASSERT_NOT_NULL(out[2].conf, "QUEUE conf not copied");
+	TEST_ASSERT_BUFFERS_ARE_EQUAL(out[2].conf, &queue, sizeof(queue),
+				      "QUEUE conf mismatch");
+
+	TEST_ASSERT(out[3].conf == actions[3].conf,
+		    "SHARED handle not preserved");
+	TEST_ASSERT_NULL(out[4].conf, "END conf unexpectedly set");
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_flow_conv_actions_truncated(void)
+{
+	struct rte_flow_error error;
+	const struct rte_flow_action_queue queue = {
+		.index = 7,
+	};
+	const enum rte_flow_action_type types[] = {
+		RTE_FLOW_ACTION_TYPE_INDIRECT,
+		RTE_FLOW_ACTION_TYPE_SHARED,
+	};
+	struct rte_flow_action actions[] = {
+		{
+			.type = RTE_FLOW_ACTION_TYPE_QUEUE,
+			.conf = &queue,
+		},
+		{
+			.type = RTE_FLOW_ACTION_TYPE_INDIRECT,
+			.conf = &queue,
+		},
+		{
+			.type = RTE_FLOW_ACTION_TYPE_END,
+		},
+	};
+	alignas(double) uint8_t buf[256];
+	size_t needed;
+	int ret;
+
+	for (unsigned int type = 0; type < RTE_DIM(types); type++) {
+		actions[1].type = types[type];
+		ret = rte_flow_conv(RTE_FLOW_CONV_OP_ACTIONS, NULL, 0,
+				    actions, &error);
+		TEST_ASSERT(ret > 0, "size query failed: %d", ret);
+		needed = ret;
+		TEST_ASSERT(needed <= sizeof(buf), "buffer too small: %zu", needed);
+
+		for (size_t size = 0; size <= needed; size++) {
+			memset(buf, 0xa5, sizeof(buf));
+			ret = rte_flow_conv(RTE_FLOW_CONV_OP_ACTIONS, buf, size,
+					    actions, &error);
+			TEST_ASSERT_EQUAL(ret, (int)needed,
+					  "unexpected return %d", ret);
+			for (size_t byte = size; byte < sizeof(buf); byte++)
+				TEST_ASSERT_EQUAL(buf[byte], 0xa5,
+						  "action %d: write at byte %zu past size %zu",
+						  types[type], byte, size);
+		}
+	}
+
+	return TEST_SUCCESS;
+}
+
+static struct unit_test_suite flow_conv_testsuite = {
+	.suite_name = "flow conversion",
+	.setup = NULL,
+	.teardown = NULL,
+	.unit_test_cases = {
+		TEST_CASE(test_flow_conv_item_name),
+		TEST_CASE(test_flow_conv_action_name),
+		TEST_CASE(test_flow_conv_item_default_mask),
+		TEST_CASE(test_flow_conv_tables_complete),
+		TEST_CASE(test_flow_conv_pattern),
+		TEST_CASE(test_flow_conv_actions),
+		TEST_CASE(test_flow_conv_actions_truncated),
+		TEST_CASES_END()
+	}
+};
+
+static int
+test_flow_conv(void)
+{
+	return unit_test_suite_runner(&flow_conv_testsuite);
+}
+
+REGISTER_FAST_TEST(ethdev_flow_conv_autotest, NOHUGE_OK, ASAN_OK,
+		   test_flow_conv);
-- 
2.52.0

