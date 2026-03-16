Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F54F53D80
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 17:28:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A95940647;
	Mon, 16 Mar 2026 18:28:02 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 3D3264025E
 for <dev@dpdk.org>; Mon, 16 Mar 2026 18:28:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773682080; x=1805218080;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=jwvYuuvoZOb/8M+YOO9jCjQ5ReuA5wFsXoUI8N5w3t0=;
 b=PZwwTuh/zHOZUFM4DTwsvc8VNrcYG6xubLpnXPjQT2SMpgAP1m4Gh8ZG
 FwI64b4Ccl7/AUypKZ8edcJMeXTH5mA1tQG83Lsl7WyGKN91be073gwCv
 mKfW/b6vDOwy1H1ZzANSroy0qDygcsiPSYzQ0pSVwAc887t5cPDkniXN2
 OT3viBjdD8NQmPMmJqCqel7DRkkNyDDqgwfnx3I2jIU+nPZWCCqiYd1nB
 YuqDOJCr22vSwKSTyUZl3y8sKCZvRKaLVG7Jf1haBx0xubvuRETuJ9MaQ
 HWJ/uwDs3143bTJCJCzZW1Z0MuoEkX/UaLn2dOmzqEymgRNP5PQEuwazp w==;
X-CSE-ConnectionGUID: 6m7P5haYROK3YjrSt0fmpg==
X-CSE-MsgGUID: mIs7e92sTyKxXYQvBjEXaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="86059605"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="86059605"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 10:27:59 -0700
X-CSE-ConnectionGUID: c5DYvBgRSq+tPx9Q7yiUNQ==
X-CSE-MsgGUID: tX8v8Z4VTP2VjoC0KfONfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="221228133"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 16 Mar 2026 10:27:58 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Ori Kam <orika@nvidia.com>
Subject: [RFC PATCH v1 01/21] ethdev: add flow graph API
Date: Mon, 16 Mar 2026 17:27:29 +0000
Message-ID: <07d2b375e71e883bed0ac7e2f167a8e01c3a00fc.1773681364.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1773681363.git.anatoly.burakov@intel.com>
References: 
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

This commit adds a flow graph parsing API. This is a helper API intended to
help ethdev drivers implement rte_flow parsers, as common usages map to
graph traversal problem very well.

Features provided by the API:
- Flow graph, edge, and node definitions
- Graph traversal logic
- Declarative validation against common flow item types
- Per-node validation and state processing callbacks

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
Depends-on: series-37663 ("Add common flow attr/action parsing infrastructure to Intel PMD's")
Depends-on: series-37585 ("Reduce reliance on global response buffer in IAVF")

 lib/ethdev/meson.build      |   1 +
 lib/ethdev/rte_flow_graph.h | 414 ++++++++++++++++++++++++++++++++++++
 2 files changed, 415 insertions(+)
 create mode 100644 lib/ethdev/rte_flow_graph.h

diff --git a/lib/ethdev/meson.build b/lib/ethdev/meson.build
index 8ba6c708a2..686b64e3c2 100644
--- a/lib/ethdev/meson.build
+++ b/lib/ethdev/meson.build
@@ -40,6 +40,7 @@ driver_sdk_headers += files(
         'ethdev_pci.h',
         'ethdev_vdev.h',
         'rte_flow_driver.h',
+        'rte_flow_graph.h',
         'rte_mtr_driver.h',
         'rte_tm_driver.h',
 )
diff --git a/lib/ethdev/rte_flow_graph.h b/lib/ethdev/rte_flow_graph.h
new file mode 100644
index 0000000000..07c370b45a
--- /dev/null
+++ b/lib/ethdev/rte_flow_graph.h
@@ -0,0 +1,414 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Intel Corporation
+ */
+
+#ifndef _RTE_FLOW_GRAPH_H_
+#define _RTE_FLOW_GRAPH_H_
+
+/**
+ * @file
+ * RTE Flow Graph Parser (Internal Driver API)
+ *
+ * This file provides a graph-based flow pattern parser for PMD drivers.
+ * It defines structures and functions to validate and process rte_flow
+ * patterns using a directed graph representation.
+ *
+ * @warning
+ * This is an internal API for PMD drivers only. Applications must not use it.
+ */
+
+#include <rte_flow.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#define RTE_FLOW_NODE_FIRST (0)
+/* Edge array termination sentinel (not a valid node index). */
+#define RTE_FLOW_NODE_EDGE_END ((size_t)~0U)
+
+/**
+ * For a lot of nodes, there are multiple common patterns of validation behavior. This enum allows
+ * marking nodes as implementing one of these common behaviors without need for expressing that in
+ * validation code. Can be ORed together to express support for multiple node types. These checks
+ * are not combined (any one of them being satisfied is sufficient).
+ */
+enum rte_flow_graph_node_expect
+{
+	RTE_FLOW_NODE_EXPECT_NONE = 0,             /**< No special constraints. */
+	RTE_FLOW_NODE_EXPECT_EMPTY = (1 << 0),     /**< spec, mask, last must be NULL. */
+	RTE_FLOW_NODE_EXPECT_SPEC = (1 << 1),      /**< spec is required, mask and last must be NULL. */
+	RTE_FLOW_NODE_EXPECT_MASK = (1 << 2),      /**< mask is required, spec and last must be NULL. */
+	RTE_FLOW_NODE_EXPECT_SPEC_MASK = (1 << 3), /**< spec and mask required, last must be NULL. */
+	RTE_FLOW_NODE_EXPECT_RANGE = (1 << 4),     /**< spec, mask, and last are required. */
+	RTE_FLOW_NODE_EXPECT_NOT_RANGE = (1 << 5), /**< last must be NULL. */
+};
+
+/**
+ * Node validation callback.
+ *
+ * Called when the graph traversal reaches this node. Validates the
+ * rte_flow_item (spec, mask, last) against driver-specific constraints.
+ *
+ * Drivers are suggested to perform all checks in this callback.
+ *
+ * @param ctx
+ *   Opaque driver context for accumulating parsed state.
+ * @param item
+ *   Pointer to the rte_flow_item being validated.
+ * @param error
+ *   Pointer to rte_flow_error structure for reporting failures.
+ * @return
+ *   0 on success, negative errno on failure.
+ */
+typedef int (*rte_flow_node_validate_fn)(
+	const void *ctx,
+	const struct rte_flow_item *item,
+	struct rte_flow_error *error);
+
+/**
+ * Node processing callback.
+ *
+ * Called after validation succeeds. Extracts fields from the rte_flow_item
+ * and stores them in driver-specific state for later hardware programming.
+ *
+ * Drivers are suggested to implement "happy path" in this callback.
+ *
+ * @param ctx
+ *   Opaque driver context for accumulating parsed state.
+ * @param item
+ *   Pointer to the rte_flow_item to process.
+ * @param error
+ *   Pointer to rte_flow_error structure for reporting failures.
+ * @return
+ *   0 on success, negative errno on failure.
+ */
+typedef int (*rte_flow_node_process_fn)(
+	void *ctx,
+	const struct rte_flow_item *item,
+	struct rte_flow_error *error);
+
+/**
+ * Graph node definition.
+ *
+ * When all members are NULL, it is assumed that the node is not used.
+ */
+struct rte_flow_graph_node {
+	const char *name;                    /**< Node name. */
+	const enum rte_flow_item_type type;  /**< Corresponding rte_flow_item_type. */
+	const enum rte_flow_graph_node_expect constraints; /**< Common validation constraints (ORed). */
+	rte_flow_node_validate_fn validate;  /**< Validation callback (NULL if unsupported). */
+	rte_flow_node_process_fn process;    /**< Processing callback (NULL if no extraction needed). */
+};
+
+/**
+ * Graph edge definition.
+ *
+ * Describes allowed transitions from one node to others. The 'next' array
+ * lists all valid successor node types and is terminated by RTE_FLOW_EDGE_END.
+ * Drivers define edges to express their supported protocol sequences.
+ */
+struct rte_flow_graph_edge {
+	const size_t *next;  /**< Array of valid successor nodes, terminated by RTE_FLOW_EDGE_END. */
+};
+
+/**
+ * Flow graph to be implemented by drivers.
+ */
+struct rte_flow_graph {
+	struct rte_flow_graph_node *nodes;
+	struct rte_flow_graph_edge *edges;
+	const enum rte_flow_item_type *ignore_nodes; /**< Additional node types to ignore, terminated by RTE_FLOW_ITEM_TYPE_END. */
+};
+
+static inline bool
+__flow_graph_node_check_constraint(enum rte_flow_graph_node_expect c,
+		bool has_spec, bool has_mask, bool has_last)
+{
+	bool empty = !has_spec && !has_mask && !has_last;
+
+	if ((c & RTE_FLOW_NODE_EXPECT_EMPTY) && empty)
+		return true;
+	if ((c & RTE_FLOW_NODE_EXPECT_NOT_RANGE) && !has_last)
+		return true;
+	if ((c & RTE_FLOW_NODE_EXPECT_SPEC) && has_spec && !has_mask && !has_last)
+		return true;
+	if ((c & RTE_FLOW_NODE_EXPECT_MASK) && has_mask && !has_spec && !has_last)
+		return true;
+	if ((c & RTE_FLOW_NODE_EXPECT_SPEC_MASK) && has_spec && has_mask && !has_last)
+		return true;
+	if ((c & RTE_FLOW_NODE_EXPECT_RANGE) && has_mask && has_spec && has_last)
+		return true;
+
+	return false;
+}
+
+static inline bool
+__flow_graph_node_is_expected(const struct rte_flow_graph_node *node,
+		const struct rte_flow_item *item, struct rte_flow_error *error)
+{
+	enum rte_flow_graph_node_expect c = node->constraints;
+
+	if (c == RTE_FLOW_NODE_EXPECT_NONE)
+		return true;
+
+	bool has_spec = (item->spec != NULL);
+	bool has_mask = (item->mask != NULL);
+	bool has_last = (item->last != NULL);
+
+	if (__flow_graph_node_check_constraint(c, has_spec, has_mask, has_last))
+		return true;
+
+	/*
+	 * In the interest of everyone debugging flow parsing code, we should provide the user with
+	 * meaningful messages about exactly what failed, as no one likes non-descript "node
+	 * constraints not met" errors with no clear indication of where this is even coming from.
+	 * What follows is us building said meaningful error messages. It's a bit ugly, but it is
+	 * for the greater good.
+	 */
+	const char *msg;
+
+	/* for empty items, we know exactly what went wrong */
+	if (c == RTE_FLOW_NODE_EXPECT_EMPTY) {
+		if (has_spec)
+			msg = "Unexpected spec in flow item";
+		else if (has_mask)
+			msg = "Unexpected mask in flow item";
+		else /* has_last */
+			msg = "Unexpected last in flow item";
+	} else {
+		/*
+		 * for non-empty constraints, we need to figure out the one thing user is missing
+		 * (or has extra) that would've satisfied the constraints.
+		 * We do that by flipping each presence bit in turn and seeing whether that single
+		 * change would have satisfied the node constraints.
+		 */
+
+		/* check spec first */
+		if (!has_spec && __flow_graph_node_check_constraint(c, true, has_mask, has_last)) {
+			msg = "Missing spec in flow item";
+		} else if (has_spec && __flow_graph_node_check_constraint(c, false, has_mask, has_last)) {
+			msg = "Unexpected spec in flow item";
+		}
+		/* check mask next */
+		else if (!has_mask && __flow_graph_node_check_constraint(c, has_spec, true, has_last)) {
+			msg = "Missing mask in flow item";
+		} else if (has_mask && __flow_graph_node_check_constraint(c, has_spec, false, has_last)) {
+			msg = "Unexpected mask in flow item";
+		}
+		/* finally, check range */
+		else if (!has_last && __flow_graph_node_check_constraint(c, has_spec, has_mask, true)) {
+			msg = "Missing last in flow item";
+		} else if (has_last && __flow_graph_node_check_constraint(c, has_spec, has_mask, false)) {
+			msg = "Unexpected last in flow item";
+		/* multiple things are wrong with the constraint, so just output a generic error */
+		} else {
+			msg = "Flow item does not meet node constraints";
+		}
+	}
+
+	rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM, item, msg);
+
+	return false;
+}
+
+/**
+ * @internal
+ * Check if a graph node is null/unused.
+ *
+ * Valid graph nodes must at least define a name.
+ */
+__rte_internal
+static inline bool
+__flow_graph_node_is_null(const struct rte_flow_graph_node *node)
+{
+	return node->name == NULL && node->type == RTE_FLOW_ITEM_TYPE_END &&
+			node->process == NULL && node->validate == NULL;
+}
+
+/**
+ * @internal
+ * Check if a flow item type should be ignored by the graph.
+ *
+ * Checks if the item type is in the graph's ignore list.
+ */
+__rte_internal
+static inline bool
+__flow_graph_node_is_ignored(const struct rte_flow_graph *graph,
+			  enum rte_flow_item_type fi_type)
+{
+	const enum rte_flow_item_type *ignored;
+
+	/* Always skip VOID items */
+	if (fi_type == RTE_FLOW_ITEM_TYPE_VOID)
+		return true;
+
+	if (graph->ignore_nodes == NULL)
+		return false;
+
+	for (ignored = graph->ignore_nodes; *ignored != RTE_FLOW_ITEM_TYPE_END; ignored++) {
+		if (*ignored == fi_type)
+			return true;
+	}
+
+	return false;
+}
+
+/**
+ * @internal
+ * Get the index of a node within a graph.
+ */
+__rte_internal
+static inline size_t
+__flow_graph_get_node_index(const struct rte_flow_graph *graph, const struct rte_flow_graph_node *node)
+{
+	return (size_t)(node - graph->nodes);
+}
+
+/**
+ * @internal
+ * Find the next node in the graph matching the given item type.
+ */
+__rte_internal
+static inline const struct rte_flow_graph_node *
+__flow_graph_find_next_node(const struct rte_flow_graph *graph,
+		      const struct rte_flow_graph_node *cur_node,
+		      enum rte_flow_item_type next_type)
+{
+	const size_t *next_nodes;
+	size_t cur_idx, edge_idx;
+
+	cur_idx = __flow_graph_get_node_index(graph, cur_node);
+	next_nodes = graph->edges[cur_idx].next;
+	if (next_nodes == NULL)
+		return NULL;
+
+	for (edge_idx = 0; next_nodes[edge_idx] != RTE_FLOW_NODE_EDGE_END; edge_idx++) {
+		const struct rte_flow_graph_node *tmp =
+				&graph->nodes[next_nodes[edge_idx]];
+		if (__flow_graph_node_is_null(tmp))
+			continue;
+		if (tmp->type == next_type)
+			return tmp;
+	}
+
+	return NULL;
+}
+
+/**
+ * @internal
+ * Visit (validate and extract) a node's item.
+ */
+__rte_internal
+static inline int
+__flow_graph_visit_node(const struct rte_flow_graph_node *node, void *ctx,
+		const struct rte_flow_item *item, struct rte_flow_error *error)
+{
+	int ret;
+
+	/* if we expect a certain type of node, check for it */
+	if (!__flow_graph_node_is_expected(node, item, error))
+		/* error already set */
+		return -1;
+
+	/* Does this node fit driver's criteria? */
+	if (node->validate != NULL) {
+		ret = node->validate(ctx, item, error);
+		if (ret != 0)
+			return ret;
+	}
+
+	/* Extract data from this item */
+	if (node->process != NULL) {
+		ret = node->process(ctx, item, error);
+		if (ret != 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * @internal
+ * Parse and validate a flow pattern using the flow graph.
+ *
+ * Traverses the pattern items and validates them against the driver's graph
+ * structure. For each item, checks that the transition from the current node
+ * is allowed, then invokes validation and processing callbacks.
+ *
+ * @param graph
+ *   Pointer to the driver's flow graph definition with nodes and edges.
+ * @param pattern
+ *   Array of rte_flow_item structures to parse, terminated by RTE_FLOW_ITEM_TYPE_END.
+ * @param error
+ *   Pointer to rte_flow_error structure for reporting failures.
+ * @param ctx
+ *   Opaque driver context for accumulating parsed state.
+ * @return
+ *   0 on success, negative errno on failure (error is set).
+ */
+__rte_internal
+static inline int
+rte_flow_graph_parse(const struct rte_flow_graph *graph, const struct rte_flow_item *pattern,
+		struct rte_flow_error *error, void *ctx)
+{
+	const struct rte_flow_graph_node *cur_node;
+	const struct rte_flow_item *item;
+	int ret;
+
+	if (graph == NULL || graph->nodes == NULL || graph->edges == NULL) {
+		return rte_flow_error_set(error, ENOTSUP,
+				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				"Flow graph is not defined");
+	}
+	if (pattern == NULL) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, NULL,
+				"Flow pattern is NULL");
+	}
+
+	/* process start node */
+	cur_node = &graph->nodes[RTE_FLOW_NODE_FIRST];
+	ret = __flow_graph_visit_node(cur_node, ctx, NULL, error);
+	if (ret != 0)
+		return ret;
+
+	/* Traverse pattern items */
+	for (item = pattern; item->type != RTE_FLOW_ITEM_TYPE_END; item++) {
+
+		/* Skip items in the graph's ignore list */
+		if (__flow_graph_node_is_ignored(graph, item->type))
+			continue;
+
+		/* Find the next graph node for this item type */
+		cur_node = __flow_graph_find_next_node(graph, cur_node, item->type);
+		if (cur_node == NULL) {
+			return rte_flow_error_set(error, ENOTSUP,
+					RTE_FLOW_ERROR_TYPE_ITEM,
+					item, "Pattern item not supported");
+		}
+		/* Validate and process the current item at this node */
+		ret = __flow_graph_visit_node(cur_node, ctx, item, error);
+		if (ret != 0)
+			return ret;
+	}
+
+	/* Pattern items have ended but we still need to process the end */
+	cur_node = __flow_graph_find_next_node(graph, cur_node, RTE_FLOW_ITEM_TYPE_END);
+	if (cur_node == NULL) {
+		return rte_flow_error_set(error, ENOTSUP,
+				RTE_FLOW_ERROR_TYPE_ITEM,
+				item, "Pattern item not supported");
+	}
+	ret = __flow_graph_visit_node(cur_node, ctx, item, error);
+	if (ret != 0)
+		return ret;
+
+	return 0;
+}
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* _RTE_FLOW_GRAPH_H_ */
-- 
2.47.3

