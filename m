Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDE2C36010
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 07:48:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0016540664;
	Mon,  7 Apr 2025 09:48:10 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id F21AD40156
 for <dev@dpdk.org>; Mon,  7 Apr 2025 09:48:08 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5372o97H010094;
 Mon, 7 Apr 2025 00:48:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=e
 Beu74XwC2251XXpUVDG0ycG8uRgck5YEXnXNSv/ZMI=; b=Nxkll7sfk1HCCcQZA
 C+lCRLZh3Dl+ENhU/UnyiqZJOQn3R8xEWfqRc0/LgoqelKQzg63yZyuW8MBEJSVS
 0UUGWV8ghNGdn82qJBiXhFD+TCfAYbLs4Z39MwhMuLbTIBBM4OwR3VDkIf8zYs8I
 NXIDFPE26Al0H4IqTrasyIryHJ0GpzdM/jHY6Jap54M4rW9EOcL88M0s9hFK1qu6
 kvD1QhgmUIgGQtDLKbvLYwdg/kW79Ei1h6Kz3HdSa3e8zjqaOkUK7M2UwCyxX7GV
 +S+vYY8y7tHi4YluxQJHkw0EFAfCquKRMSVnOwrv/ozk4TiFmB+ME4VqguXk/qCe
 7o6tA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 45u1vp2y7k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Apr 2025 00:48:07 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 7 Apr 2025 00:48:06 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 7 Apr 2025 00:48:06 -0700
Received: from cavium-PowerEdge-R640.. (unknown [10.28.36.207])
 by maili.marvell.com (Postfix) with ESMTP id 9D4985B694E;
 Mon,  7 Apr 2025 00:48:04 -0700 (PDT)
From: Nitin Saxena <nsaxena@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Pavan Nikhilesh
 <pbhagavatula@marvell.com>, Robin Jarry <rjarry@redhat.com>, "Christophe
 Fontaine" <cfontain@redhat.com>
CC: <dev@dpdk.org>, Jerin Jacob <jerinj@marvell.com>, Nitin Saxena
 <nsaxena16@gmail.com>
Subject: [PATCH v4 1/2] node: add global node mbuf dynfield
Date: Mon, 7 Apr 2025 13:17:58 +0530
Message-ID: <20250407074800.1651203-2-nsaxena@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250407074800.1651203-1-nsaxena@marvell.com>
References: <20250401042053.3518757-1-nsaxena@marvell.com>
 <20250407074800.1651203-1-nsaxena@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Sjqwq7w3EemhJ0M0gSfqOMFdj4ccEerd
X-Authority-Analysis: v=2.4 cv=YbC95xRf c=1 sm=1 tr=0 ts=67f38337 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=0qRCHEZYtXZl8o-Yq84A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: Sjqwq7w3EemhJ0M0gSfqOMFdj4ccEerd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_02,2025-04-03_03,2024-11-22_01
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

This patch defines rte_node specific dynamic field structure
(rte_node_mbuf_dynfield_t)

rte_node_mbuf_dynfield_t structure holds two types of fields
- Persistent data fields which are preserved across graph walk.
  Currently size of persistent data fields is zero.
- Overloadable data fields which are used by any two adjacent nodes.
  Same fields can be repurposed by any other adjacent nodes

This dynfield can be also be used by out-of-tree nodes.

Signed-off-by: Nitin Saxena <nsaxena@marvell.com>
---
 doc/api/doxy-api-index.md              |   3 +-
 doc/guides/rel_notes/release_25_07.rst |   6 ++
 lib/node/meson.build                   |   2 +
 lib/node/node_mbuf_dynfield.c          |  44 +++++++++
 lib/node/rte_node_mbuf_dynfield.h      | 132 +++++++++++++++++++++++++
 lib/node/version.map                   |   3 +
 6 files changed, 189 insertions(+), 1 deletion(-)
 create mode 100644 lib/node/node_mbuf_dynfield.c
 create mode 100644 lib/node/rte_node_mbuf_dynfield.h

diff --git a/doc/api/doxy-api-index.md b/doc/api/doxy-api-index.md
index b2fc24b3e4..6b93b3cd97 100644
--- a/doc/api/doxy-api-index.md
+++ b/doc/api/doxy-api-index.md
@@ -219,7 +219,8 @@ The public API headers are grouped by topics:
     [ip4_node](@ref rte_node_ip4_api.h),
     [ip6_node](@ref rte_node_ip6_api.h),
     [udp4_input_node](@ref rte_node_udp4_input_api.h)
-
+  * graph_nodes_mbuf:
+    [node_mbuf_dynfield](@ref rte_node_mbuf_dynfield.h)
 - **basic**:
   [bitops](@ref rte_bitops.h),
   [approx fraction](@ref rte_approx.h),
diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
index cd1025aac0..72d5d88ff3 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -55,6 +55,12 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================

+* **Added rte_node specific global mbuf dynamic field.**
+
+  Instead each node registering mbuf dynamic field for its own purpose, a
+  global structure is added which can be used/overloaded by all nodes
+  (including out-of-tree nodes). This minimizes footprint of node specific mbuf
+  dynamic field.

 Removed Items
 -------------
diff --git a/lib/node/meson.build b/lib/node/meson.build
index 0bed97a96c..152fe41129 100644
--- a/lib/node/meson.build
+++ b/lib/node/meson.build
@@ -8,6 +8,7 @@ if is_windows
 endif

 sources = files(
+        'node_mbuf_dynfield.c',
         'ethdev_ctrl.c',
         'ethdev_rx.c',
         'ethdev_tx.c',
@@ -30,6 +31,7 @@ headers = files(
         'rte_node_ip4_api.h',
         'rte_node_ip6_api.h',
         'rte_node_udp4_input_api.h',
+        'rte_node_mbuf_dynfield.h',
 )

 # Strict-aliasing rules are violated by uint8_t[] to context size casts.
diff --git a/lib/node/node_mbuf_dynfield.c b/lib/node/node_mbuf_dynfield.c
new file mode 100644
index 0000000000..082918ae96
--- /dev/null
+++ b/lib/node/node_mbuf_dynfield.c
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2025 Marvell International Ltd.
+ */
+#include <rte_memzone.h>
+#include <rte_node_mbuf_dynfield.h>
+#include <node_private.h>
+
+#define NODE_MBUF_DYNFIELD_MEMZONE_NAME "__rte_node_mbuf_dynfield"
+
+struct node_mbuf_dynfield_mz {
+	int dynfield_offset;
+};
+
+static const struct rte_mbuf_dynfield node_mbuf_dynfield_desc = {
+	.name = "rte_node_mbuf_dynfield",
+	.size = sizeof(rte_node_mbuf_dynfield_t),
+	.align = alignof(rte_node_mbuf_dynfield_t),
+};
+
+int node_mbuf_dynfield_offset = -1;
+
+int rte_node_mbuf_dynfield_register(void)
+{
+	int dyn_offset;
+
+	RTE_BUILD_BUG_ON(sizeof(rte_node_mbuf_dynfield_t) < RTE_NODE_MBUF_DYNFIELD_SIZE);
+	RTE_BUILD_BUG_ON(sizeof(rte_node_mbuf_overload_fields_t) <
+			 RTE_NODE_MBUF_OVERLOADABLE_FIELDS_SIZE);
+
+	if (node_mbuf_dynfield_offset == -1) {
+		dyn_offset = rte_mbuf_dynfield_register(&node_mbuf_dynfield_desc);
+		if (dyn_offset < 0) {
+			node_err("node_mbuf_dyn", "rte_mbuf_dynfield_register failed");
+			return -1;
+		}
+		node_mbuf_dynfield_offset = dyn_offset;
+
+		node_dbg("node_mbuf_dyn", "node mbuf dynfield size %zu at offset: %d",
+			  sizeof(rte_node_mbuf_dynfield_t), node_mbuf_dynfield_offset);
+	} else {
+		dyn_offset = node_mbuf_dynfield_offset;
+	}
+	return dyn_offset;
+}
diff --git a/lib/node/rte_node_mbuf_dynfield.h b/lib/node/rte_node_mbuf_dynfield.h
new file mode 100644
index 0000000000..4293b3823d
--- /dev/null
+++ b/lib/node/rte_node_mbuf_dynfield.h
@@ -0,0 +1,132 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2025 Marvell International Ltd.
+ */
+
+#ifndef _RTE_GRAPH_MBUF_DYNFIELD_H_
+#define _RTE_GRAPH_MBUF_DYNFIELD_H_
+
+#include <rte_common.h>
+#include <rte_mbuf.h>
+#include <rte_mbuf_dyn.h>
+
+/**
+ * @file: rte_node_mbuf_dynfield.h
+ *
+ * Defines rte_node specific mbuf dynamic field region [rte_node_mbuf_dynfield_t] which
+ * can used by both DPDK in-built and out-of-tree nodes for storing per-mbuf
+ * fields for graph walk
+ */
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/** Size of persistent mbuf fields */
+#define RTE_NODE_MBUF_PERSISTENT_FIELDS_SIZE          (0)
+/** Size of overloadable mbuf fields */
+#define RTE_NODE_MBUF_OVERLOADABLE_FIELDS_SIZE        (8)
+/** Size of node mbuf dynamic field */
+#define RTE_NODE_MBUF_DYNFIELD_SIZE     \
+	(RTE_NODE_MBUF_PERSISTENT_FIELDS_SIZE + RTE_NODE_MBUF_OVERLOADABLE_FIELDS_SIZE)
+/**
+ * Node mbuf overloadable data.
+ *
+ * Out-of-tree nodes can repurpose overloadable fields via
+ * rte_node_mbuf_overload_fields_get(mbuf). Overloadable fields are not
+ * preserved and typically can be used with-in two adjacent nodes in the graph.
+ */
+typedef struct rte_node_mbuf_overload_fields {
+	union {
+		uint8_t data[RTE_NODE_MBUF_OVERLOADABLE_FIELDS_SIZE];
+	};
+} rte_node_mbuf_overload_fields_t;
+
+/**
+ * rte_node specific mbuf dynamic field structure [rte_node_mbuf_dynfield_t]
+ *
+ * It holds two types of fields:
+ * 1. Persistent fields: Fields which are preserved across nodes during graph walk.
+ *    - Eg: rx/tx interface etc
+ * 2. Overloadable fields: Fields which can be repurposed by two adjacent nodes.
+ */
+typedef struct rte_node_mbuf_dynfield {
+	/**
+	 * Persistent mbuf region across nodes in graph walk
+	 *
+	 * These fields are preserved across graph walk and can be accessed by
+	 * rte_node_mbuf_dynfield_get() in fast path.
+	 */
+	union {
+		uint8_t persistent_data[RTE_NODE_MBUF_PERSISTENT_FIELDS_SIZE];
+	};
+
+	/**
+	 * Overloadable mbuf fields across graph walk. Fields which can change
+	 *
+	 * Two adjacent nodes (producer, consumer) can use this memory region for
+	 * sharing per-mbuf specific information. Once mbuf leaves a consumer node,
+	 * this region can be repurposed by another sets of [producer, consumer] node.
+	 *
+	 * In fast path, this region can be accessed by rte_node_mbuf_overload_fields_get()
+	 */
+	rte_node_mbuf_overload_fields_t overloadable_data;
+} rte_node_mbuf_dynfield_t;
+
+/**
+ * For a given mbuf and dynamic offset, return pointer to rte_node_mbuf_dynfield_t *
+ *
+ * @param m
+ *   Mbuf
+ * @param offset
+ *   Dynamic offset returned by @ref rte_node_mbuf_dynfield_register()
+ */
+__rte_experimental
+static __rte_always_inline rte_node_mbuf_dynfield_t *
+rte_node_mbuf_dynfield_get(struct rte_mbuf *m, const int offset)
+{
+	return RTE_MBUF_DYNFIELD(m, offset, struct rte_node_mbuf_dynfield *);
+}
+
+/**
+ * For a given mbuf and dynamic offset, return pointer to overloadable fields
+ * Nodes can typecast returned pointer to reuse for their own purpose
+ *
+ * @param m
+ *   Mbuf
+ * @param offset
+ *   Dynamic offset returned by @ref rte_node_mbuf_dynfield_register()
+ */
+__rte_experimental
+static __rte_always_inline rte_node_mbuf_overload_fields_t *
+rte_node_mbuf_overload_fields_get(struct rte_mbuf *m, const int offset)
+{
+	struct rte_node_mbuf_dynfield *f = NULL;
+
+	f = RTE_MBUF_DYNFIELD(m, offset, struct rte_node_mbuf_dynfield *);
+
+	return &(f->overloadable_data);
+}
+
+/**
+ *  Registers common mbuf dynamic field region. Can be called in
+ *  rte_node_register()->init() function to save offset in node->ctx
+ *
+ *  In process() function, node->ctx can be passed to
+ *  - rte_node_mbuf_dynfield_get(mbuf, offset)
+ *  - rte_node_mbuf_overload_fields_get(mbuf, offset)
+ *
+ *  Can be called multiple times by any number of nodes.
+ *  - Very first call registers dynamic field and returns offset
+ *  - Subsequent calls return same offset
+ *
+ *  @return
+ *   -1 on error
+ *   dynamic field offset on success
+ */
+__rte_experimental
+int rte_node_mbuf_dynfield_register(void);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/lib/node/version.map b/lib/node/version.map
index a402182fbe..bceaaadd0e 100644
--- a/lib/node/version.map
+++ b/lib/node/version.map
@@ -22,4 +22,7 @@ EXPERIMENTAL {

 	# added in 24.03
 	rte_node_ethdev_rx_next_update;
+
+	# added in 25.07
+	rte_node_mbuf_dynfield_register;
 };
--
2.43.0

