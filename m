Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B72C36002
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Apr 2025 13:56:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D73B64065D;
	Wed,  9 Apr 2025 15:56:05 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 9BDF34065A
 for <dev@dpdk.org>; Wed,  9 Apr 2025 15:56:03 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539CTH9S024334;
 Wed, 9 Apr 2025 06:56:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=K
 +ayiYIfHO+QE39IBrDfELR5AeUCxhl5cgTupvvTrdk=; b=OXAvb9muKhTQwVT04
 QOzCVz1WpLuzUYYvpnwckvfWhVA6QRenoB8HAZ6vJJGjpmsRTkv+rpPIcxSFuiqu
 4HmtpIFy5XOjEHHvMixyQFL4c9+vAMHwO/i2skQDt5G+Ie8GPaC3DPeYZdFv7+jE
 5aWH7pxQEQm+9bYk1jATU7HqbRz4RwYxG8ySn9/aWkcykxOQ6THOaIWpqylW3XG3
 w2Gq7cu+Yi1MAp7U9TVBq1ATrZRTrmochrSd41d0w0a2gVyjPtXejr9fEfItYz9B
 Ks0kUv2nc9N/raYmrvmTEunRN2wcHIdomjfN7sG34/jt7rC2zXxMO0jz4NUmA68c
 DCBpw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45un9a01j5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Apr 2025 06:56:01 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 9 Apr 2025 06:56:00 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 9 Apr 2025 06:56:00 -0700
Received: from cavium-PowerEdge-R640.. (unknown [10.28.36.207])
 by maili.marvell.com (Postfix) with ESMTP id 83F215E686F;
 Wed,  9 Apr 2025 06:55:58 -0700 (PDT)
From: Nitin Saxena <nsaxena@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Pavan Nikhilesh
 <pbhagavatula@marvell.com>, Robin Jarry <rjarry@redhat.com>, "Christophe
 Fontaine" <cfontain@redhat.com>
CC: <dev@dpdk.org>, Jerin Jacob <jerinj@marvell.com>, Nitin Saxena
 <nsaxena16@gmail.com>
Subject: [PATCH v5 1/2] node: add global node mbuf dynfield
Date: Wed, 9 Apr 2025 19:25:52 +0530
Message-ID: <20250409135554.2180390-2-nsaxena@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250409135554.2180390-1-nsaxena@marvell.com>
References: <20250401042053.3518757-1-nsaxena@marvell.com>
 <20250409135554.2180390-1-nsaxena@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=I/JlRMgg c=1 sm=1 tr=0 ts=67f67c72 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=cjyRJa4RtCeYkR5tfokA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: BjsQjC4LInXgDMpu0szzlW4ujdiBrF_d
X-Proofpoint-ORIG-GUID: BjsQjC4LInXgDMpu0szzlW4ujdiBrF_d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
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
 lib/node/node_mbuf_dynfield.c          |  57 +++++++++++
 lib/node/rte_node_mbuf_dynfield.h      | 132 +++++++++++++++++++++++++
 5 files changed, 199 insertions(+), 1 deletion(-)
 create mode 100644 lib/node/node_mbuf_dynfield.c
 create mode 100644 lib/node/rte_node_mbuf_dynfield.h

diff --git a/doc/api/doxy-api-index.md b/doc/api/doxy-api-index.md
index 5c425a2cb9..763cfb3f3c 100644
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
index 093b85d206..2dc888e65d 100644
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
index 0000000000..6005e72ed6
--- /dev/null
+++ b/lib/node/node_mbuf_dynfield.c
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2025 Marvell International Ltd.
+ */
+#include <rte_memzone.h>
+#include <rte_node_mbuf_dynfield.h>
+#include <node_private.h>
+#include <eal_export.h>
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
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_mbuf_dynfield_register, 25.07);
+int rte_node_mbuf_dynfield_register(void)
+{
+	struct node_mbuf_dynfield_mz *f = NULL;
+	const struct rte_memzone *mz = NULL;
+	int dyn_offset;
+
+	RTE_BUILD_BUG_ON(sizeof(rte_node_mbuf_dynfield_t) < RTE_NODE_MBUF_DYNFIELD_SIZE);
+	RTE_BUILD_BUG_ON(sizeof(rte_node_mbuf_overload_fields_t) <
+			 RTE_NODE_MBUF_OVERLOADABLE_FIELDS_SIZE);
+
+	mz = rte_memzone_lookup(NODE_MBUF_DYNFIELD_MEMZONE_NAME);
+
+	if (!mz) {
+		mz = rte_memzone_reserve_aligned(NODE_MBUF_DYNFIELD_MEMZONE_NAME,
+						 sizeof(struct node_mbuf_dynfield_mz),
+						 SOCKET_ID_ANY, 0,
+						 RTE_CACHE_LINE_SIZE);
+		if (!mz) {
+			node_err("node_mbuf_dyn", "rte_memzone_reserve_aligned failed");
+			return -1;
+		}
+		dyn_offset = rte_mbuf_dynfield_register(&node_mbuf_dynfield_desc);
+		if (dyn_offset < 0) {
+			node_err("node_mbuf_dyn", "rte_mbuf_dynfield_register failed");
+			return -1;
+		}
+		f = (struct node_mbuf_dynfield_mz *)mz->addr;
+		f->dynfield_offset = dyn_offset;
+
+		node_dbg("node_mbuf_dyn", "memzone: %s of size: %zu at offset : %d",
+			 mz->name, mz->len, f->dynfield_offset);
+	} else {
+		f = (struct node_mbuf_dynfield_mz *)mz->addr;
+	}
+	return f->dynfield_offset;
+}
diff --git a/lib/node/rte_node_mbuf_dynfield.h b/lib/node/rte_node_mbuf_dynfield.h
new file mode 100644
index 0000000000..b5a3d6db3f
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
+ *  Register rte_node specific common mbuf dynamic field region. Can be called
+ *  in rte_node_register()->init() function to save offset in node->ctx
+ *
+ *  In process() function, node->ctx can be passed to
+ *  - rte_node_mbuf_dynfield_get(mbuf, offset)
+ *  - rte_node_mbuf_overload_fields_get(mbuf, offset)
+ *
+ *  Can be called multiple times by any number of nodes in init() function.
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
--
2.43.0

