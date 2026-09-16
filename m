Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8B4C88E5C
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 12:18:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B0BE42EB2;
	Wed, 16 Sep 2026 14:18:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 7A09C402B0
 for <dev@dpdk.org>; Wed, 16 Sep 2026 14:18:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789561116; x=1821097116;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=FW0bTEqrR6X2aHw2o+gjLoDmBWygLGzZTOsLED8hohg=;
 b=JZo40HKDrvLGxY3j4elzZVdP38bA7YBRzwfxdxmTM5b82liWGuMLq+fv
 fRQwj9CbgQPZOlaQd05fmoxNTsqM4/uVDr/URuOUdW+qp0ikKxO/DKI9W
 i1MQp2GjExyYG0BcFQx8SK6V2NRdkwUrJ9lvFzYSlm7cxjdS3HkC6PJ3h
 2y9B583MEYqXwXAFW0XkxiqQ/Edxg0HSbYQ7xn4uzcUDVZArUrGeoqucF
 IbAXLNwmusPAAjhPoa2oYOYKOBtLfYJC7ps42pmUKGV1fHOlEKqc8RNDP
 3n06YNA945mPP154VdBSS1FpD+GIvD1cF1TwivkZEyTZfeFFuznXzzNey Q==;
X-CSE-ConnectionGUID: UynY+A/aSfi3MnVfccwKcw==
X-CSE-MsgGUID: +wdlwrm6Suyj2kUybowMrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="112702929"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="112702929"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 05:18:35 -0700
X-CSE-ConnectionGUID: sYnfv0RTRjK/uaAdZr1/gA==
X-CSE-MsgGUID: QxYNgL/oQg660MnmP1odEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="272850220"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa008.jf.intel.com with ESMTP; 16 Sep 2026 05:18:34 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v3 01/19] ethdev: add flow graph API
Date: Wed, 16 Sep 2026 13:18:07 +0100
Message-ID: <b1982ff795e9db6f7fa34992573f7bad0294f77a.1789560944.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1789560943.git.anatoly.burakov@intel.com>
 <cover.1789560943.git.anatoly.burakov@intel.com>
References: 
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
 doc/guides/prog_guide/ethdev/flow_graph.rst | 749 ++++++++++++++++++++
 doc/guides/prog_guide/ethdev/index.rst      |   1 +
 doc/guides/rel_notes/release_26_11.rst      |   5 +
 lib/ethdev/flow_graph.h                     | 507 +++++++++++++
 lib/ethdev/meson.build                      |   1 +
 5 files changed, 1263 insertions(+)
 create mode 100644 doc/guides/prog_guide/ethdev/flow_graph.rst
 create mode 100644 lib/ethdev/flow_graph.h

diff --git a/doc/guides/prog_guide/ethdev/flow_graph.rst b/doc/guides/prog_guide/ethdev/flow_graph.rst
new file mode 100644
index 00000000000..cc6b06ccb4a
--- /dev/null
+++ b/doc/guides/prog_guide/ethdev/flow_graph.rst
@@ -0,0 +1,749 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+    Copyright(c) 2026 Intel Corporation
+
+Flow Graph Parser
+=================
+
+Introduction
+------------
+
+The flow graph parser is a helper library for PMD drivers that implements ``rte_flow`` pattern matching.
+It lets a driver declare the protocol sequences it supports as a directed graph of nodes and edges.
+It then validates and extracts fields from an ``rte_flow_item`` pattern in a single traversal.
+
+The library is defined in ``flow_graph.h`` and is header-only.
+
+Scope and Limitations
+~~~~~~~~~~~~~~~~~~~~~
+
+Because the parser is graph-based, it is well suited for matching *protocol stacks*.
+These are sequences of protocol headers such as ``ETH / IPv4 / TCP``.
+Any pattern that can be expressed as "from protocol A, transitions to protocol B or C are allowed" fits naturally into the graph model.
+
+The library is **not** designed to cover every ``rte_flow`` item type.
+Items that do not represent a position in a protocol stack do not have a natural place in a protocol graph.
+This includes conntrack state, meter color, and other metadata items.
+Such items are best handled outside the graph, either before or after the graph parse call.
+
+Defining a Graph
+----------------
+
+A graph consists of three parts:
+
+1. An **enum** that assigns a numeric index to every node.
+2. A **node array** (``struct flow_graph_node[]``) indexed by that enum.
+3. An **edge array** (``struct flow_graph_edge[]``) also indexed by that enum, describing allowed transitions.
+
+These parts are bundled together in a ``struct flow_graph``.
+
+The running example used throughout this guide models the following protocol graph::
+
+   START -> ETH -> [VLAN] -> (IPv4 | IPv6) -> [(TCP | UDP | SCTP)] -> END
+
+Brackets ``[...]`` denote optional items.
+Parentheses ``(...)`` denote a required choice between alternatives.
+The key ideas are:
+
+* ``ETH`` is required after ``START``.
+* After ``ETH``, an optional ``VLAN`` may appear, but the pattern must then see an IP layer.
+* After an IP layer, an optional transport layer may appear; it may be TCP, UDP, or SCTP, after which the pattern reaches ``END``.
+
+Node Enum
+~~~~~~~~~
+
+Every node needs a stable index.
+The first node **must** be at index ``FLOW_GRAPH_NODE_FIRST`` (which is 0).
+This is the *start node*.
+It is used only as a traversal anchor and must not carry callbacks.
+
+.. code-block:: c
+
+   enum example_node_id {
+       EXAMPLE_NODE_START = FLOW_GRAPH_NODE_FIRST,
+       EXAMPLE_NODE_ETH,
+       EXAMPLE_NODE_VLAN,
+       EXAMPLE_NODE_IPV4,
+       EXAMPLE_NODE_IPV6,
+       EXAMPLE_NODE_TCP,
+       EXAMPLE_NODE_UDP,
+       EXAMPLE_NODE_SCTP,
+       EXAMPLE_NODE_END,
+       /* keep last */
+       EXAMPLE_NODE_MAX,
+   };
+
+Node Definitions
+~~~~~~~~~~~~~~~~
+
+Each node maps to one ``rte_flow_item_type``.
+It can also carry a *validate* callback, a *process* callback, and a set of *constraints*.
+The the ``END`` node can also have callbacks to perform end-of-match processing.
+
+A minimal skeleton (callbacks and constraints are added in later sections):
+
+.. code-block:: c
+
+   const struct flow_graph example_graph = {
+       .nodes = (struct flow_graph_node[]){
+           [EXAMPLE_NODE_START] = {
+               .name = "START",
+               /* Start node: no type, no callbacks */
+           },
+           [EXAMPLE_NODE_ETH] = {
+               .name  = "ETH",
+               .type  = RTE_FLOW_ITEM_TYPE_ETH,
+           },
+           [EXAMPLE_NODE_VLAN] = {
+               .name  = "VLAN",
+               .type  = RTE_FLOW_ITEM_TYPE_VLAN,
+           },
+           [EXAMPLE_NODE_IPV4] = {
+               .name  = "IPV4",
+               .type  = RTE_FLOW_ITEM_TYPE_IPV4,
+           },
+           [EXAMPLE_NODE_IPV6] = {
+               .name  = "IPV6",
+               .type  = RTE_FLOW_ITEM_TYPE_IPV6,
+           },
+           [EXAMPLE_NODE_TCP] = {
+               .name  = "TCP",
+               .type  = RTE_FLOW_ITEM_TYPE_TCP,
+           },
+           [EXAMPLE_NODE_UDP] = {
+               .name  = "UDP",
+               .type  = RTE_FLOW_ITEM_TYPE_UDP,
+           },
+           [EXAMPLE_NODE_SCTP] = {
+               .name  = "SCTP",
+               .type  = RTE_FLOW_ITEM_TYPE_SCTP,
+           },
+           [EXAMPLE_NODE_END] = {
+               .name  = "END",
+               .type  = RTE_FLOW_ITEM_TYPE_END,
+           },
+       },
+   };
+
+Edge Definitions
+~~~~~~~~~~~~~~~~
+
+Edges express which nodes may follow the current one.
+Every edge list is terminated by the ``FLOW_GRAPH_NODE_EDGE_END`` sentinel.
+All non-``END`` nodes **must** have an edge list.
+The ``END`` node itself does not need one.
+
+.. code-block:: c
+
+   const struct flow_graph example_graph = {
+       .nodes = (struct flow_graph_node[]){
+           /* ... same nodes as above ... */
+       },
+       .edges = (struct flow_graph_edge[]){
+           [EXAMPLE_NODE_START] = {
+               .next = (size_t[]){
+                   EXAMPLE_NODE_ETH,
+                   FLOW_GRAPH_NODE_EDGE_END,
+               },
+           },
+           [EXAMPLE_NODE_ETH] = {
+               .next = (size_t[]){
+                   EXAMPLE_NODE_VLAN,
+                   EXAMPLE_NODE_IPV4,
+                   EXAMPLE_NODE_IPV6,
+                   FLOW_GRAPH_NODE_EDGE_END,
+               },
+           },
+           [EXAMPLE_NODE_VLAN] = {
+               .next = (size_t[]){
+                   EXAMPLE_NODE_IPV4,
+                   EXAMPLE_NODE_IPV6,
+                   FLOW_GRAPH_NODE_EDGE_END,
+               },
+           },
+           [EXAMPLE_NODE_IPV4] = {
+               .next = (size_t[]){
+                   EXAMPLE_NODE_TCP,
+                   EXAMPLE_NODE_UDP,
+                   EXAMPLE_NODE_SCTP,
+                   EXAMPLE_NODE_END,
+                   FLOW_GRAPH_NODE_EDGE_END,
+               },
+           },
+           [EXAMPLE_NODE_IPV6] = {
+               .next = (size_t[]){
+                   EXAMPLE_NODE_TCP,
+                   EXAMPLE_NODE_UDP,
+                   EXAMPLE_NODE_SCTP,
+                   EXAMPLE_NODE_END,
+                   FLOW_GRAPH_NODE_EDGE_END,
+               },
+           },
+           [EXAMPLE_NODE_TCP] = {
+               .next = (size_t[]){
+                   EXAMPLE_NODE_END,
+                   FLOW_GRAPH_NODE_EDGE_END,
+               },
+           },
+           [EXAMPLE_NODE_UDP] = {
+               .next = (size_t[]){
+                   EXAMPLE_NODE_END,
+                   FLOW_GRAPH_NODE_EDGE_END,
+               },
+           },
+           [EXAMPLE_NODE_SCTP] = {
+               .next = (size_t[]){
+                   EXAMPLE_NODE_END,
+                   FLOW_GRAPH_NODE_EDGE_END,
+               },
+           },
+       },
+   };
+
+Reading the edges back:
+
+* From ``START``, the parser can only reach ``ETH``, which makes ``ETH`` required.
+* From ``ETH``, the parser can reach ``VLAN``, ``IPV4``, or ``IPV6``, which makes ``VLAN`` optional.
+* From ``IPV4`` or ``IPV6``, the parser can reach ``TCP``, ``UDP``, ``SCTP``, or ``END``, which makes the transport layer optional.
+
+Assembling the Graph
+~~~~~~~~~~~~~~~~~~~~
+
+With nodes and edges defined inline, assembling the graph is just a matter of
+combining the two arrays into a single compound literal:
+
+.. code-block:: c
+
+   const struct flow_graph example_graph = {
+       .nodes = (struct flow_graph_node[]){
+           [EXAMPLE_NODE_START] = {
+               .name = "START"
+           },
+           [EXAMPLE_NODE_ETH]   = {
+               .name = "ETH",
+               .type = RTE_FLOW_ITEM_TYPE_ETH
+           },
+           /* ... remaining nodes ... */
+           [EXAMPLE_NODE_END]   = {
+               .name = "END",
+               .type = RTE_FLOW_ITEM_TYPE_END
+           },
+       },
+       .edges = (struct flow_graph_edge[]){
+           [EXAMPLE_NODE_START] = {
+               .next = (size_t[]){
+                   EXAMPLE_NODE_ETH,
+                   FLOW_GRAPH_NODE_EDGE_END
+               }
+           },
+           /* ... remaining edges ... */
+       },
+   };
+
+Callbacks
+---------
+
+The graph calls up to two callbacks on every visited node: *validate* and *process*.
+
+Both callbacks share the same return convention.
+On success they must return ``0``.
+On failure they must call ``rte_flow_error_set`` to record a descriptive error and return its result.
+
+Validate Callback
+~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
+   typedef int (*flow_graph_node_validate_fn)(
+       const void *ctx,
+       const struct rte_flow_item *item,
+       struct rte_flow_error *error);
+
+This callback receives a **read-only** context pointer.
+The canonical intent is that it should check whether the item's spec, mask, and last values are acceptable for the driver.
+On failure it returns the result of ``rte_flow_error_set`` (see the return convention above).
+
+It is recommended to use this callback for **all checks that can reject a rule**.
+This includes unsupported mask bits, conflicting field combinations, hardware limitations, and other applicable criteria.
+
+Process Callback
+~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
+   typedef int (*flow_graph_node_process_fn)(
+       void *ctx,
+       const struct rte_flow_item *item,
+       struct rte_flow_error *error);
+
+This callback receives a **mutable** context pointer.
+The canonical expectation is that it should extract the fields needed for hardware programming.
+It should then store extracted data in the driver's context structure.
+On the rare failure path it returns the result of ``rte_flow_error_set`` (see the return convention above).
+
+It is recommended to use this callback for the **happy path**.
+For example, it can copy addresses, ports, and protocol IDs into the driver context so they can be programmed later.
+
+Defining a Context Structure
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The opaque ``ctx`` pointer passed to every callback is driver-defined.
+A typical context accumulates the parsed protocol fields:
+
+.. code-block:: c
+
+   struct example_parsed_flow {
+       /* L2 */
+       struct rte_ether_addr dst_mac;
+       bool has_vlan;
+       uint16_t vlan_tci;
+
+       /* L3 */
+       bool is_ipv6;
+       rte_be32_t ipv4_src;
+       rte_be32_t ipv4_dst;
+       uint8_t ipv6_src[16];
+       uint8_t ipv6_dst[16];
+
+       /* L4 */
+       enum rte_flow_item_type l4_proto;
+       rte_be16_t src_port;
+       rte_be16_t dst_port;
+   };
+
+These fields are meant to reflect the structure used by the driver to programming hardware with.
+
+Callback Example
+~~~~~~~~~~~~~~~~
+
+Below is a validate/process pair for the IPv4 node.
+The validate callback rejects unsupported mask bits.
+The process callback copies addresses into the context:
+
+.. code-block:: c
+
+   static int
+   example_validate_ipv4(const void *ctx __rte_unused,
+                         const struct rte_flow_item *item,
+                         struct rte_flow_error *error)
+   {
+       const struct rte_flow_item_ipv4 *mask = item->mask;
+
+       if (mask->hdr.version_ihl ||
+           mask->hdr.type_of_service ||
+           mask->hdr.total_length ||
+           mask->hdr.packet_id ||
+           mask->hdr.fragment_offset ||
+           mask->hdr.time_to_live ||
+           mask->hdr.next_proto_id ||
+           mask->hdr.hdr_checksum) {
+           return rte_flow_error_set(error, EINVAL,
+                   RTE_FLOW_ERROR_TYPE_ITEM, item,
+                   "Only src/dst addresses supported");
+       }
+       return 0;
+   }
+
+   static int
+   example_process_ipv4(void *ctx,
+                        const struct rte_flow_item *item,
+                        struct rte_flow_error *error __rte_unused)
+   {
+       struct example_parsed_flow *parsed = ctx;
+       const struct rte_flow_item_ipv4 *spec = item->spec;
+
+       parsed->is_ipv6 = false;
+       if (spec != NULL) {
+           parsed->ipv4_src = spec->hdr.src_addr;
+           parsed->ipv4_dst = spec->hdr.dst_addr;
+       }
+       return 0;
+   }
+
+Add the callbacks to the node definition:
+
+.. code-block:: c
+
+   [EXAMPLE_NODE_IPV4] = {
+       .name      = "IPV4",
+       .type      = RTE_FLOW_ITEM_TYPE_IPV4,
+       .validate  = example_validate_ipv4,
+       .process   = example_process_ipv4,
+   },
+
+Node Constraints
+----------------
+
+Many nodes share common requirements about which combination of ``spec``, ``mask``, and ``last`` pointers an item must carry.
+Instead of checking these in every validate callback, they can be declared via the ``constraints`` field.
+The field uses ``flow_graph_node_expect`` flags.
+
+Available constraint flags (may be ORed together):
+
+``FLOW_GRAPH_NODE_EXPECT_EMPTY``
+   The item must have ``spec == NULL``, ``mask == NULL``, and
+   ``last == NULL``.
+
+``FLOW_GRAPH_NODE_EXPECT_SPEC``
+   ``spec`` is required; ``mask`` and ``last`` must be NULL.
+
+``FLOW_GRAPH_NODE_EXPECT_MASK``
+   ``mask`` is required; ``spec`` and ``last`` must be NULL.
+
+``FLOW_GRAPH_NODE_EXPECT_SPEC_MASK``
+   Both ``spec`` and ``mask`` are required; ``last`` must be NULL.
+
+``FLOW_GRAPH_NODE_EXPECT_RANGE``
+   All three (``spec``, ``mask``, ``last``) are required.
+
+``FLOW_GRAPH_NODE_EXPECT_NOT_RANGE``
+   ``last`` must be NULL (``spec`` and ``mask`` are unconstrained).
+
+Multiple flags can be ORed together.
+The item is accepted if **any one** of the flagged constraints is satisfied.
+The purpose is to express the difference between "must" (i.e. accept ONLY this), and "may" (i.e. accept this OR that).
+
+For example, an IPv4 node that accepts either a mask-only item or a spec+mask item:
+
+.. code-block:: c
+
+   [EXAMPLE_NODE_IPV4] = {
+       .name        = "IPV4",
+       .type        = RTE_FLOW_ITEM_TYPE_IPV4,
+       .validate    = example_validate_ipv4,
+       .process     = example_process_ipv4,
+       .constraints = FLOW_GRAPH_NODE_EXPECT_MASK |
+                      FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+   },
+
+An Ethernet node that may appear empty (no spec/mask) or with spec+mask:
+
+.. code-block:: c
+
+   [EXAMPLE_NODE_ETH] = {
+       .name        = "ETH",
+       .type        = RTE_FLOW_ITEM_TYPE_ETH,
+       .validate    = example_validate_eth,
+       .process     = example_process_eth,
+       .constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY |
+                      FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+   },
+
+Constraints are checked **before** the validate callback is invoked.
+
+Ignoring Item Types
+~~~~~~~~~~~~~~~~~~~
+
+The ``ignore_nodes`` field on ``struct flow_graph`` is an optional complement to node constraints.
+When the pattern may contain item types that are irrelevant to the driver, list them in ``ignore_nodes``.
+For example, metadata items like ``RTE_FLOW_ITEM_TYPE_MARK`` do not represent a protocol header.
+The parser skips ignored items silently without advancing the current graph position:
+
+.. code-block:: c
+
+   const struct flow_graph example_graph = {
+       /* ... nodes and edges ... */
+       .ignore_nodes = (enum rte_flow_item_type[]){
+           RTE_FLOW_ITEM_TYPE_MARK,
+           RTE_FLOW_ITEM_TYPE_END,
+       },
+   };
+
+``RTE_FLOW_ITEM_TYPE_VOID`` is always ignored regardless of this list.
+Omit ``ignore_nodes`` entirely when no additional item types need to be skipped.
+
+Calling the Parser
+------------------
+
+``flow_graph_parse`` walks the pattern against the graph:
+
+.. code-block:: c
+
+   int
+   flow_graph_parse(const struct flow_graph *graph,
+                        const struct rte_flow_item *pattern,
+                        struct rte_flow_error *error,
+                        void *ctx);
+
+A typical call site looks like this:
+
+.. code-block:: c
+
+   struct example_parsed_flow parsed;
+   int ret;
+
+   memset(&parsed, 0, sizeof(parsed));
+
+   ret = flow_graph_parse(&example_graph, pattern, error, &parsed);
+   if (ret != 0)
+       return ret;
+
+   /* 'parsed' now contains the extracted protocol fields */
+
+The function returns success or failure, with ``error`` populated.
+
+Error conditions:
+
+* **Graph is NULL** — for example, when the graph pointer itself is not provided.
+* **Pattern is NULL**.
+* **Unsupported transition** — when an item type has no matching edge from the current node.
+    This is the primary way the graph rejects unsupported protocol sequences.
+* **Constraint failure** — when the spec, mask, and last combination does not satisfy the node's declared constraints.
+* **Validate callback failure** — when driver-specific validation rejects the item.
+* **Process callback failure** — when driver-specific extraction path fails.
+
+.. warning::
+
+    Malformed graph tables (for example invalid node indices, missing sentinels,
+    or otherwise inconsistent driver-defined graph structures) are considered to be a driver implementation bug.
+    Graphs are trusted by default: driver-owned graph structures are expected to be valid and are not fully validated.
+
+The traversal processes items in order, skipping ignored types.
+After the last non-``END`` item, the parser looks for an ``END`` node reachable from the current position.
+It then visits that node and runs its callbacks, if any.
+This means drivers can attach a process callback to the ``END`` node for post-traversal finalization.
+
+Putting It All Together
+-----------------------
+
+The complete graph definition with callbacks and constraints:
+
+.. code-block:: c
+
+   const struct flow_graph example_graph = {
+       .nodes = (struct flow_graph_node[]){
+           [EXAMPLE_NODE_START] = {
+               .name = "START",
+           },
+           [EXAMPLE_NODE_ETH] = {
+               .name        = "ETH",
+               .type        = RTE_FLOW_ITEM_TYPE_ETH,
+               .validate    = example_validate_eth,
+               .process     = example_process_eth,
+               .constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY
+                            | FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+           },
+           [EXAMPLE_NODE_VLAN] = {
+               .name        = "VLAN",
+               .type        = RTE_FLOW_ITEM_TYPE_VLAN,
+               .process     = example_process_vlan,
+               .constraints = FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+           },
+           [EXAMPLE_NODE_IPV4] = {
+               .name        = "IPV4",
+               .type        = RTE_FLOW_ITEM_TYPE_IPV4,
+               .validate    = example_validate_ipv4,
+               .process     = example_process_ipv4,
+               .constraints = FLOW_GRAPH_NODE_EXPECT_MASK
+                            | FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+           },
+           [EXAMPLE_NODE_IPV6] = {
+               .name        = "IPV6",
+               .type        = RTE_FLOW_ITEM_TYPE_IPV6,
+               .validate    = example_validate_ipv6,
+               .process     = example_process_ipv6,
+               .constraints = FLOW_GRAPH_NODE_EXPECT_MASK
+                            | FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+           },
+           [EXAMPLE_NODE_TCP] = {
+               .name        = "TCP",
+               .type        = RTE_FLOW_ITEM_TYPE_TCP,
+               .validate    = example_validate_tcp,
+               .process     = example_process_tcp,
+               .constraints = FLOW_GRAPH_NODE_EXPECT_MASK
+                            | FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+           },
+           [EXAMPLE_NODE_UDP] = {
+               .name        = "UDP",
+               .type        = RTE_FLOW_ITEM_TYPE_UDP,
+               .validate    = example_validate_udp,
+               .process     = example_process_udp,
+               .constraints = FLOW_GRAPH_NODE_EXPECT_MASK
+                            | FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+           },
+           [EXAMPLE_NODE_SCTP] = {
+               .name        = "SCTP",
+               .type        = RTE_FLOW_ITEM_TYPE_SCTP,
+               .process     = example_process_sctp,
+               .constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY
+                            | FLOW_GRAPH_NODE_EXPECT_MASK
+                            | FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
+           },
+           [EXAMPLE_NODE_END] = {
+               .name = "END",
+               .type = RTE_FLOW_ITEM_TYPE_END,
+           },
+       },
+       .edges = (struct flow_graph_edge[]){
+           [EXAMPLE_NODE_START] = {
+               .next = (size_t[]){
+                   EXAMPLE_NODE_ETH,
+                   FLOW_GRAPH_NODE_EDGE_END,
+               },
+           },
+           [EXAMPLE_NODE_ETH] = {
+               .next = (size_t[]){
+                   EXAMPLE_NODE_VLAN,
+                   EXAMPLE_NODE_IPV4,
+                   EXAMPLE_NODE_IPV6,
+                   FLOW_GRAPH_NODE_EDGE_END,
+               },
+           },
+           [EXAMPLE_NODE_VLAN] = {
+               .next = (size_t[]){
+                   EXAMPLE_NODE_IPV4,
+                   EXAMPLE_NODE_IPV6,
+                   FLOW_GRAPH_NODE_EDGE_END,
+               },
+           },
+           [EXAMPLE_NODE_IPV4] = {
+               .next = (size_t[]){
+                   EXAMPLE_NODE_TCP,
+                   EXAMPLE_NODE_UDP,
+                   EXAMPLE_NODE_SCTP,
+                   EXAMPLE_NODE_END,
+                   FLOW_GRAPH_NODE_EDGE_END,
+               },
+           },
+           [EXAMPLE_NODE_IPV6] = {
+               .next = (size_t[]){
+                   EXAMPLE_NODE_TCP,
+                   EXAMPLE_NODE_UDP,
+                   EXAMPLE_NODE_SCTP,
+                   EXAMPLE_NODE_END,
+                   FLOW_GRAPH_NODE_EDGE_END,
+               },
+           },
+           [EXAMPLE_NODE_TCP] = {
+               .next = (size_t[]){
+                   EXAMPLE_NODE_END,
+                   FLOW_GRAPH_NODE_EDGE_END,
+               },
+           },
+           [EXAMPLE_NODE_UDP] = {
+               .next = (size_t[]){
+                   EXAMPLE_NODE_END,
+                   FLOW_GRAPH_NODE_EDGE_END,
+               },
+           },
+           [EXAMPLE_NODE_SCTP] = {
+               .next = (size_t[]){
+                   EXAMPLE_NODE_END,
+                   FLOW_GRAPH_NODE_EDGE_END,
+               },
+           },
+       },
+   };
+
+
+Tunnel Graphs and Repeated Item Types
+-------------------------------------
+
+Tunneled patterns often repeat the same ``rte_flow_item_type`` in outer and inner headers.
+A simple representative example is a TCP-IPv4 over GTP-U pattern::
+
+   ETH -> IPV4 -> UDP -> GTPU -> IPV4 -> TCP
+
+The graph library supports this naturally.
+Multiple nodes may use the same ``type`` value, as long as they are distinct nodes in the graph and reached through different edges.
+
+For tunnel parsing, the recommended style is to model repeated protocol types as separate inner/outer nodes, for example ``OUTER_IPV4`` and ``INNER_IPV4``.
+This makes the graph intent explicit, keeps callback logic clear, and avoids unexpected graph paths due to loops.
+
+.. code-block:: c
+
+   enum tunnel_node_id {
+       TUNNEL_NODE_START = FLOW_GRAPH_NODE_FIRST,
+       TUNNEL_NODE_ETH,
+       TUNNEL_NODE_OUTER_IPV4,
+       TUNNEL_NODE_TCP,
+       TUNNEL_NODE_UDP,
+       TUNNEL_NODE_GTPU,
+       TUNNEL_NODE_INNER_IPV4,
+       TUNNEL_NODE_END,
+       TUNNEL_NODE_MAX,
+   };
+
+   const struct flow_graph tunnel_graph = {
+       .nodes = (struct flow_graph_node[]){
+           /* Minimal topology example: callbacks and constraints are omitted. */
+           [TUNNEL_NODE_START] = { .name = "START" },
+           [TUNNEL_NODE_ETH] = {
+               .name = "ETH",
+               .type = RTE_FLOW_ITEM_TYPE_ETH,
+           },
+           [TUNNEL_NODE_OUTER_IPV4] = {
+               .name = "OUTER_IPV4",
+               .type = RTE_FLOW_ITEM_TYPE_IPV4,
+           },
+           [TUNNEL_NODE_UDP] = {
+               .name = "UDP",
+               .type = RTE_FLOW_ITEM_TYPE_UDP,
+           },
+           [TUNNEL_NODE_GTPU] = {
+               .name = "GTPU",
+               .type = RTE_FLOW_ITEM_TYPE_GTPU,
+           },
+           [TUNNEL_NODE_INNER_IPV4] = {
+               .name = "INNER_IPV4",
+               .type = RTE_FLOW_ITEM_TYPE_IPV4,
+           },
+           [TUNNEL_NODE_TCP] = {
+               .name = "TCP",
+               .type = RTE_FLOW_ITEM_TYPE_TCP,
+           },
+           [TUNNEL_NODE_END] = {
+               .name = "END",
+               .type = RTE_FLOW_ITEM_TYPE_END,
+           },
+       },
+       .edges = (struct flow_graph_edge[]){
+           [TUNNEL_NODE_START] = {
+               .next = (size_t[]){
+                   TUNNEL_NODE_ETH,
+                   FLOW_GRAPH_NODE_EDGE_END,
+               },
+           },
+           [TUNNEL_NODE_ETH] = {
+               .next = (size_t[]){
+                   TUNNEL_NODE_OUTER_IPV4,
+                   FLOW_GRAPH_NODE_EDGE_END,
+               },
+           },
+           [TUNNEL_NODE_OUTER_IPV4] = {
+               .next = (size_t[]){
+                   TUNNEL_NODE_UDP,
+                   FLOW_GRAPH_NODE_EDGE_END,
+               },
+           },
+           [TUNNEL_NODE_UDP] = {
+               .next = (size_t[]){
+                   TUNNEL_NODE_GTPU,
+                   FLOW_GRAPH_NODE_EDGE_END,
+               },
+           },
+           [TUNNEL_NODE_GTPU] = {
+               .next = (size_t[]){
+                   TUNNEL_NODE_INNER_IPV4,
+                   FLOW_GRAPH_NODE_EDGE_END,
+               },
+           },
+           [TUNNEL_NODE_INNER_IPV4] = {
+               .next = (size_t[]){
+                   TUNNEL_NODE_TCP,
+                   FLOW_GRAPH_NODE_EDGE_END,
+               },
+           },
+           [TUNNEL_NODE_TCP] = {
+               .next = (size_t[]){
+                   TUNNEL_NODE_END,
+                   FLOW_GRAPH_NODE_EDGE_END,
+               },
+           },
+       },
+   };
+
+In other words, traversal follows graph edges (node-to-node), while node matching is done against each candidate node's ``rte_flow_item_type``.
+That combination allows repeated protocol layers to be represented cleanly with separate nodes for different parsing contexts.
+
+Although arbitrary loops are possible in the graph, tunnel protocol graphs are usually easier to reason about when repeated item types are split into explicit inner/outer nodes.
+It is not recommended to create loops in the graph, as these loops will be unbounded.
diff --git a/doc/guides/prog_guide/ethdev/index.rst b/doc/guides/prog_guide/ethdev/index.rst
index 392ced0a2ef..b41fd045bb3 100644
--- a/doc/guides/prog_guide/ethdev/index.rst
+++ b/doc/guides/prog_guide/ethdev/index.rst
@@ -10,6 +10,7 @@ Ethernet Device Library
     ethdev
     switch_representation
     flow_offload
+    flow_graph
     traffic_metering_and_policing
     traffic_management
     qos_framework
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 0785f96dd81..37881aea4a2 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -55,6 +55,11 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Added internal ethdev flow graph parser helper API.**
+
+  Added ``flow_graph`` helper definitions in ``flow_graph.h``
+  for PMD drivers to build graph-based flow pattern parsers.
+
 * **Updated Intel iavf driver.**
 
   * Runtime Rx/Tx queue setup is now automatically disabled while a
diff --git a/lib/ethdev/flow_graph.h b/lib/ethdev/flow_graph.h
new file mode 100644
index 00000000000..0472b3b04f8
--- /dev/null
+++ b/lib/ethdev/flow_graph.h
@@ -0,0 +1,507 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Intel Corporation
+ */
+
+#ifndef _FLOW_GRAPH_H_
+#define _FLOW_GRAPH_H_
+
+/**
+ * @file
+ * Flow Graph
+ *
+ * This file provides a graph-based rte_flow pattern parser for drivers.
+ * It defines structures and functions to validate and process rte_flow
+ * patterns using a directed graph representation.
+ *
+ * @warning
+ * This is an internal API for drivers only. Applications must not use it.
+ */
+
+#include <rte_flow.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/*
+ * Logging for flow graph parse errors. This is an internal driver API;
+ * FLOW_GRAPH_LOG requires RTE_COMPONENT_NAME (set by meson for drivers)
+ * and the corresponding driver logtype variable to be registered.
+ */
+#ifdef RTE_COMPONENT_NAME
+extern int RTE_CONCAT(RTE_COMPONENT_NAME, _logtype_driver);
+#define FLOW_GRAPH_LOG(level, fmt, ...) \
+	rte_log(RTE_LOG_##level, RTE_CONCAT(RTE_COMPONENT_NAME, _logtype_driver), \
+		"ETHDEV FLOW GRAPH: %s(): " fmt "\n", __func__, ##__VA_ARGS__)
+#else
+/* Use ETHDEV log level when included outside driver context */
+#define FLOW_GRAPH_LOG(level, fmt, ...) \
+	rte_log(RTE_LOG_##level, \
+			rte_eth_dev_logtype, \
+			"ETHDEV FLOW GRAPH: %s(): " fmt "\n", __func__, ##__VA_ARGS__)
+#endif
+
+#define FLOW_GRAPH_NODE_FIRST (0)
+/* Edge array termination sentinel (not a valid node index). */
+#define FLOW_GRAPH_NODE_EDGE_END SIZE_MAX
+
+static inline const char *
+flow_graph_item_type_to_str(enum rte_flow_item_type type)
+{
+	const char *name;
+	int ret;
+
+	ret = rte_flow_conv(RTE_FLOW_CONV_OP_ITEM_NAME_PTR,
+			&name, sizeof(name), (const void *)(uintptr_t)type, NULL);
+	if (ret < 0)
+		return "UNKNOWN";
+
+	return name;
+}
+
+/**
+ * For a lot of nodes, there are multiple common patterns of validation behavior.
+ * This enum allows marking nodes as implementing one of these common behaviors
+ * without need for expressing that in validation code. Can be ORed together to
+ * express support for multiple node types. These checks are not combined (any
+ * one of them being satisfied is sufficient).
+ */
+enum flow_graph_node_expect {
+	FLOW_GRAPH_NODE_EXPECT_NONE = 0,             /**< No special constraints. */
+	FLOW_GRAPH_NODE_EXPECT_EMPTY = (1 << 0),     /**< spec, mask, last must be NULL. */
+	FLOW_GRAPH_NODE_EXPECT_SPEC = (1 << 1),      /**< spec is required, mask and last must be NULL. */
+	FLOW_GRAPH_NODE_EXPECT_MASK = (1 << 2),      /**< mask is required, spec and last must be NULL. */
+	FLOW_GRAPH_NODE_EXPECT_SPEC_MASK = (1 << 3), /**< spec and mask required, last must be NULL. */
+	FLOW_GRAPH_NODE_EXPECT_RANGE = (1 << 4),     /**< spec, mask, and last are required. */
+	FLOW_GRAPH_NODE_EXPECT_NOT_RANGE = (1 << 5), /**< last must be NULL. */
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
+ *   0 on success, or the value returned by rte_flow_error_set() on failure.
+ *   On failure the callback must report the error with rte_flow_error_set().
+ */
+typedef int (*flow_graph_node_validate_fn)(
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
+ *   0 on success, or the value returned by rte_flow_error_set() on failure.
+ *   On failure the callback must report the error with rte_flow_error_set().
+ */
+typedef int (*flow_graph_node_process_fn)(
+	void *ctx,
+	const struct rte_flow_item *item,
+	struct rte_flow_error *error);
+
+/**
+ * Graph node definition.
+ *
+ * Node validity rules:
+ * - all nodes must define a name,
+ * - all non-END nodes must define an edge list,
+ * - start node must not define validation/processing callbacks.
+ */
+struct flow_graph_node {
+	const char *name;                    /**< Node name. */
+	enum rte_flow_item_type type;        /**< Flow item type to match. */
+	enum flow_graph_node_expect constraints; /**< Common validation constraints (ORed). */
+	flow_graph_node_validate_fn validate;  /**< Validation callback (NULL if unsupported). */
+	flow_graph_node_process_fn process;    /**< Processing callback (NULL if no extraction needed). */
+};
+
+/**
+ * Graph edge definition.
+ *
+ * Describes allowed transitions from one node to others. The 'next' array
+ * lists all valid successor node types and is terminated by FLOW_GRAPH_NODE_EDGE_END.
+ * Drivers define edges to express their supported protocol sequences. Edges
+ * must be unique, as split path following is not supported.
+ */
+struct flow_graph_edge {
+	size_t *next;  /**< Array of valid successor nodes, terminated by FLOW_GRAPH_NODE_EDGE_END. */
+};
+
+/**
+ * Flow graph to be implemented by drivers.
+ *
+ * Graph contents are expected to be well-formed. This library validates
+ * traversal semantics for pattern items, but does not attempt to harden
+ * against arbitrary malformed node/edge table definitions.
+ */
+struct flow_graph {
+	struct flow_graph_node *nodes;
+	struct flow_graph_edge *edges;
+	enum rte_flow_item_type *ignore_nodes; /**< Additional node types to ignore, terminated by RTE_FLOW_ITEM_TYPE_END. */
+};
+
+static inline bool
+_flow_graph_node_check_constraint(enum flow_graph_node_expect c,
+		bool has_spec, bool has_mask, bool has_last)
+{
+	bool empty = !has_spec && !has_mask && !has_last;
+
+	if ((c & FLOW_GRAPH_NODE_EXPECT_EMPTY) && empty)
+		return true;
+	if ((c & FLOW_GRAPH_NODE_EXPECT_NOT_RANGE) && !has_last)
+		return true;
+	if ((c & FLOW_GRAPH_NODE_EXPECT_SPEC) && has_spec && !has_mask && !has_last)
+		return true;
+	if ((c & FLOW_GRAPH_NODE_EXPECT_MASK) && has_mask && !has_spec && !has_last)
+		return true;
+	if ((c & FLOW_GRAPH_NODE_EXPECT_SPEC_MASK) && has_spec && has_mask && !has_last)
+		return true;
+	if ((c & FLOW_GRAPH_NODE_EXPECT_RANGE) && has_mask && has_spec && has_last)
+		return true;
+
+	return false;
+}
+
+static inline bool
+_flow_graph_node_is_expected(const struct flow_graph_node *node,
+		const struct rte_flow_item *item, struct rte_flow_error *error)
+{
+	enum flow_graph_node_expect c = node->constraints;
+
+	if (c == FLOW_GRAPH_NODE_EXPECT_NONE)
+		return true;
+
+	bool has_spec = (item->spec != NULL);
+	bool has_mask = (item->mask != NULL);
+	bool has_last = (item->last != NULL);
+
+	if (_flow_graph_node_check_constraint(c, has_spec, has_mask, has_last))
+		return true;
+
+	/*
+	 * In the interest of everyone debugging flow parsing code, we should
+	 * provide the user with meaningful messages about exactly what failed,
+	 * as no one likes non-descript "node constraints not met" errors with
+	 * no clear indication of where this is even coming from. What follows
+	 * is us building said meaningful error messages. It's a bit ugly, but
+	 * it is for the greater good.
+	 */
+	const char *msg;
+
+	/* for empty items, we know exactly what went wrong */
+	if (c == FLOW_GRAPH_NODE_EXPECT_EMPTY) {
+		if (has_spec)
+			msg = "Unexpected spec in flow item";
+		else if (has_mask)
+			msg = "Unexpected mask in flow item";
+		else /* has_last */
+			msg = "Unexpected last in flow item";
+	} else {
+		/*
+		 * for non-empty constraints, we need to figure out the one
+		 * thing user is missing (or has extra) that would've satisfied
+		 * the constraints. We do that by flipping each presence bit in
+		 * turn and seeing whether that single change would have
+		 * satisfied the node constraints.
+		 */
+
+		/* check spec first */
+		if (!has_spec && _flow_graph_node_check_constraint(c, true, has_mask, has_last)) {
+			msg = "Missing spec in flow item";
+		} else if (has_spec && _flow_graph_node_check_constraint(c, false, has_mask, has_last)) {
+			msg = "Unexpected spec in flow item";
+		}
+		/* check mask next */
+		else if (!has_mask && _flow_graph_node_check_constraint(c, has_spec, true, has_last)) {
+			msg = "Missing mask in flow item";
+		} else if (has_mask && _flow_graph_node_check_constraint(c, has_spec, false, has_last)) {
+			msg = "Unexpected mask in flow item";
+		}
+		/* finally, check range */
+		else if (!has_last && _flow_graph_node_check_constraint(c, has_spec, has_mask, true)) {
+			msg = "Missing last in flow item";
+		} else if (has_last && _flow_graph_node_check_constraint(c, has_spec, has_mask, false)) {
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
+ * Check if a flow item type should be ignored by the graph.
+ *
+ * Checks if the item type is in the graph's ignore list.
+ */
+static inline bool
+_flow_graph_node_is_ignored(const struct flow_graph *graph,
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
+ * Get the index of a node within a graph.
+ */
+static inline size_t
+_flow_graph_get_node_index(const struct flow_graph *graph, const struct flow_graph_node *node)
+{
+	return (size_t)(node - graph->nodes);
+}
+
+/**
+ * Check if a graph node is valid.
+ */
+static inline bool
+_flow_graph_node_is_valid(const struct flow_graph *graph,
+			   const struct flow_graph_node *node,
+			   struct rte_flow_error *error)
+{
+	size_t node_idx;
+
+	if (node == NULL) {
+		rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				"Flow graph node pointer is NULL");
+		return false;
+	}
+
+	if (node->name == NULL) {
+		rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, node,
+				"Flow graph node name is not defined");
+		return false;
+	}
+
+	node_idx = _flow_graph_get_node_index(graph, node);
+
+	/* first node can't have callbacks because there's no item */
+	if (node_idx == FLOW_GRAPH_NODE_FIRST &&
+			(node->validate != NULL || node->process != NULL)) {
+		rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, node,
+				"Flow graph start node callbacks are not allowed");
+		return false;
+	}
+
+	/* all non-END nodes must have edges */
+	if (node->type != RTE_FLOW_ITEM_TYPE_END &&
+			graph->edges[node_idx].next == NULL) {
+		rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, node,
+				"Flow graph edge list is not defined for non-END node");
+		return false;
+	}
+
+	return true;
+}
+
+/**
+ * Find the next node in the graph matching the given item type.
+ */
+static inline const struct flow_graph_node *
+_flow_graph_find_next_node(const struct flow_graph *graph,
+		      const struct flow_graph_node *cur_node,
+		      enum rte_flow_item_type next_type,
+		      struct rte_flow_error *error)
+{
+	const size_t *next_nodes;
+	size_t cur_idx, edge_idx;
+
+	if (!_flow_graph_node_is_valid(graph, cur_node, error))
+		return NULL;
+
+	cur_idx = _flow_graph_get_node_index(graph, cur_node);
+	next_nodes = graph->edges[cur_idx].next;
+
+	for (edge_idx = 0; next_nodes[edge_idx] != FLOW_GRAPH_NODE_EDGE_END; edge_idx++) {
+		const struct flow_graph_node *tmp =
+				&graph->nodes[next_nodes[edge_idx]];
+		/* if node is invalid, graph is broken */
+		if (!_flow_graph_node_is_valid(graph, tmp, error))
+			return NULL;
+		if (tmp->type == next_type)
+			return tmp;
+	}
+
+	return NULL;
+}
+
+/**
+ * Visit (validate and extract) a node's item.
+ */
+static inline int
+_flow_graph_visit_node(const struct flow_graph_node *node, void *ctx,
+		const struct rte_flow_item *item, struct rte_flow_error *error)
+{
+	int ret;
+
+	/* if we expect a certain type of node, check for it */
+	if (item != NULL && !_flow_graph_node_is_expected(node, item, error))
+		return -EINVAL;
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
+static inline int
+flow_graph_parse(const struct flow_graph *graph, const struct rte_flow_item *pattern,
+		struct rte_flow_error *error, void *ctx)
+{
+	const struct flow_graph_node *cur_node;
+	const struct rte_flow_item *item;
+	int ret;
+
+	if (graph == NULL || graph->nodes == NULL || graph->edges == NULL) {
+		FLOW_GRAPH_LOG(DEBUG, "flow graph is not defined");
+		return rte_flow_error_set(error, ENOTSUP,
+				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				"Flow graph is not defined");
+	}
+	if (pattern == NULL) {
+		FLOW_GRAPH_LOG(DEBUG, "flow pattern is NULL");
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, NULL,
+				"Flow pattern is NULL");
+	}
+
+	/* use start node as traversal anchor */
+	cur_node = &graph->nodes[FLOW_GRAPH_NODE_FIRST];
+
+	/* is the node valid? */
+	if (!_flow_graph_node_is_valid(graph, cur_node, error)) {
+		/* error may be NULL */
+		if (error != NULL)
+			FLOW_GRAPH_LOG(DEBUG, "%s", error->message);
+		return -EINVAL;
+	}
+
+	/* Traverse pattern items */
+	for (item = pattern; item->type != RTE_FLOW_ITEM_TYPE_END; item++) {
+
+		/* Skip items in the graph's ignore list */
+		if (_flow_graph_node_is_ignored(graph, item->type)) {
+			FLOW_GRAPH_LOG(DEBUG, "ignored item %s",
+					flow_graph_item_type_to_str(item->type));
+			continue;
+		}
+
+		/* Find the next graph node for this item type */
+		cur_node = _flow_graph_find_next_node(graph, cur_node,
+				item->type, error);
+		if (cur_node == NULL) {
+			FLOW_GRAPH_LOG(DEBUG, "cannot traverse to item %s",
+					flow_graph_item_type_to_str(item->type));
+			return rte_flow_error_set(error, ENOTSUP,
+					RTE_FLOW_ERROR_TYPE_ITEM,
+					item, "Pattern item not supported");
+		}
+		FLOW_GRAPH_LOG(DEBUG, "processing %s", cur_node->name);
+		/* Validate and process the current item at this node */
+		ret = _flow_graph_visit_node(cur_node, ctx, item, error);
+		if (ret != 0) {
+			/* error may be NULL */
+			if (error != NULL)
+				FLOW_GRAPH_LOG(DEBUG, "%s", error->message);
+			return ret;
+		}
+	}
+
+	/* Pattern items have ended but we still need to process the end */
+	cur_node = _flow_graph_find_next_node(graph, cur_node, item->type, error);
+	if (cur_node == NULL) {
+		FLOW_GRAPH_LOG(DEBUG, "cannot traverse to item %s",
+				flow_graph_item_type_to_str(item->type));
+		return rte_flow_error_set(error, ENOTSUP,
+				RTE_FLOW_ERROR_TYPE_ITEM,
+				item, "Pattern item not supported");
+	}
+	ret = _flow_graph_visit_node(cur_node, ctx, item, error);
+	if (ret != 0) {
+		/* error may be NULL */
+		if (error != NULL)
+			FLOW_GRAPH_LOG(DEBUG, "%s", error->message);
+		return ret;
+	}
+
+	return 0;
+}
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* _FLOW_GRAPH_H_ */
diff --git a/lib/ethdev/meson.build b/lib/ethdev/meson.build
index 8ba6c708a24..99ff3c990c1 100644
--- a/lib/ethdev/meson.build
+++ b/lib/ethdev/meson.build
@@ -40,6 +40,7 @@ driver_sdk_headers += files(
         'ethdev_pci.h',
         'ethdev_vdev.h',
         'rte_flow_driver.h',
+        'flow_graph.h',
         'rte_mtr_driver.h',
         'rte_tm_driver.h',
 )
-- 
2.52.0

