Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0114FC369CB
	for <dpdk-dev@archiver.kernel.org>; Sat, 19 Apr 2025 07:11:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B61340648;
	Sat, 19 Apr 2025 09:11:20 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 28A7C402BB
 for <dev@dpdk.org>; Sat, 19 Apr 2025 09:11:18 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53J6Spww016560;
 Sat, 19 Apr 2025 00:11:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=+
 u3GmX1gNTWFLelZLl/FdfY2cDiUc1UbBnO5DOyEEJ0=; b=YjFzofPoC0VLmeHIH
 GS9FkB3gy3tpO2rv6xIf/krqhmnV6YY+R+cFhmPdejnc9vrsW6n5PbBytkfl28MK
 zTaAeFExDRliuvIjZuG+oAOhQilG8eMEw8UB21/5esgGjXvq7KJ6ulhJUmy4Lpxf
 p/GXbyiQbKBa3jzohplfzXN/TmK4I5pSROtfAr7jrtXK9l050u7i6BYA7GkC8Qs+
 GkjnRrz+/UGgiFR8ILo/0cEqF/R06/xxY0JzIvuujz2nDjxofOI4C8XCtBK9Pr8H
 0dYR4JGgtDvuJ382d4EZWZWbVitCQGJ4cy1TuTah59yLNrfyGagYSFKmpmpQc99H
 qGe8g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4620fdr0sa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 19 Apr 2025 00:11:13 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 19 Apr 2025 00:11:11 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 19 Apr 2025 00:11:11 -0700
Received: from cavium-PowerEdge-R640.. (unknown [10.28.36.207])
 by maili.marvell.com (Postfix) with ESMTP id 65D163F71C0;
 Sat, 19 Apr 2025 00:10:58 -0700 (PDT)
From: Nitin Saxena <nsaxena@marvell.com>
To: Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>, Zhirun Yan
 <yanzhirun_163@163.com>, Robin Jarry <rjarry@redhat.com>,
 Christophe Fontaine <cfontain@redhat.com>
CC: <dev@dpdk.org>, Nitin Saxena <nsaxena16@gmail.com>
Subject: [PATCH v7 2/5] graph: add feature arc abstraction
Date: Sat, 19 Apr 2025 12:40:42 +0530
Message-ID: <20250419071047.1334983-3-nsaxena@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250419071047.1334983-1-nsaxena@marvell.com>
References: <20250103060612.2671836-1-nsaxena@marvell.com>
 <20250419071047.1334983-1-nsaxena@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: uClhHzm-iPknTtkx86WAETLBwqW9duP7
X-Proofpoint-ORIG-GUID: uClhHzm-iPknTtkx86WAETLBwqW9duP7
X-Authority-Analysis: v=2.4 cv=ecA9f6EH c=1 sm=1 tr=0 ts=68034c91 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=qiwjn65jJcnhhqyWME8A:9
 a=Rpjtz0iWhbleRk9l:21 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-19_02,2025-04-17_01,2024-11-22_01
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

Feature arc abstraction allows rte_graph based applications to
- Allow control plane to runtime enable/disable feature nodes.
  Fast path APIs helps to steer packets across enabled feature nodes
- Feature enable/disable based on indexes. Index can be interface index,
  route index, etc
- More than one feature nodes can be added to an arc and also provide
  mechanism to control features sequencing order in fast path.
- Does not require stopping of workers for control plane updates. RCU
  mechanism also provided
- Once DPDK inbuilt nodes adopts feature arc abstraction, out-of-tree
  nodes can also be hooked (with no custom changes in in-built nodes)

Signed-off-by: Nitin Saxena <nsaxena@marvell.com>
---
 doc/api/doxy-api-index.md                |    2 +
 doc/guides/rel_notes/release_25_07.rst   |   10 +
 lib/graph/graph_feature_arc.c            | 2050 ++++++++++++++++++++++
 lib/graph/graph_private.h                |    4 +
 lib/graph/meson.build                    |    4 +-
 lib/graph/rte_graph_feature_arc.h        |  628 +++++++
 lib/graph/rte_graph_feature_arc_worker.h |  607 +++++++
 7 files changed, 3304 insertions(+), 1 deletion(-)
 create mode 100644 lib/graph/graph_feature_arc.c
 create mode 100644 lib/graph/rte_graph_feature_arc.h
 create mode 100644 lib/graph/rte_graph_feature_arc_worker.h

diff --git a/doc/api/doxy-api-index.md b/doc/api/doxy-api-index.md
index 5c425a2cb9..6d8b531344 100644
--- a/doc/api/doxy-api-index.md
+++ b/doc/api/doxy-api-index.md
@@ -214,6 +214,8 @@ The public API headers are grouped by topics:
     [table_wm](@ref rte_swx_table_wm.h)
   * [graph](@ref rte_graph.h):
     [graph_worker](@ref rte_graph_worker.h)
+    [graph_feature_arc](@ref rte_graph_feature_arc.h)
+    [graph_feature_arc_worker](@ref rte_graph_feature_arc_worker.h)
   * graph_nodes:
     [eth_node](@ref rte_node_eth_api.h),
     [ip4_node](@ref rte_node_ip4_api.h),
diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
index 093b85d206..7f11c91b7a 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -55,6 +55,16 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================

+* **Added feature arc abstraction in graph library.**
+
+  Feature arc abstraction helps ``rte_graph`` based applications to steer
+  packets across different node path(s) based on the features (or protocols)
+  enabled on interfaces. Different feature node paths can be enabled/disabled
+  at runtime on some or on all interfaces. This abstraction also help
+  applications to hook ``out-of-tree nodes`` in DPDK in-built node paths in a
+  generic manner.
+
+  * Added ``ip4_output`` feature arc processing in ``ip4_rewrite`` node.

 Removed Items
 -------------
diff --git a/lib/graph/graph_feature_arc.c b/lib/graph/graph_feature_arc.c
new file mode 100644
index 0000000000..350967b732
--- /dev/null
+++ b/lib/graph/graph_feature_arc.c
@@ -0,0 +1,2050 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2025 Marvell International Ltd.
+ */
+
+#include "graph_private.h"
+#include <rte_graph_feature_arc_worker.h>
+#include <rte_malloc.h>
+#include <rte_string_fns.h>
+#include <eal_export.h>
+
+#define GRAPH_FEATURE_MAX_NUM_PER_ARC  (64)
+
+#define connect_graph_nodes(node1, node2, edge, arc_name) \
+	__connect_graph_nodes(node1, node2, edge, arc_name, __LINE__)
+
+#define FEATURE_ARC_MEMZONE_NAME "__rte_feature_arc_main_mz"
+
+#define NUM_EXTRA_FEATURE_DATA   (2)
+
+#define graph_uint_cast(f)		((unsigned int)f)
+
+#define fdata_fix_get(arc, feat, index)	\
+			RTE_GRAPH_FEATURE_TO_FEATURE_DATA(arc, feat, index)
+
+#define feat_dbg graph_dbg
+
+#define FEAT_COND_ERR(cond, ...)                                           \
+	do {                                                               \
+		if (cond)                                                  \
+			graph_err(__VA_ARGS__);                            \
+	} while (0)
+
+#define FEAT_ERR(fn, ln, ...)                                              \
+		GRAPH_LOG2(ERR, fn, ln, __VA_ARGS__)
+
+#define FEAT_ERR_JMP(_err, fn, ln, ...)                                    \
+	do {                                                               \
+		FEAT_ERR(fn, ln, __VA_ARGS__);                             \
+		rte_errno = _err;                                          \
+	} while (0)
+
+#define COND_ERR_JMP(_err, cond, fn, ln, ...)                              \
+	do {                                                               \
+		if (cond)                                                  \
+			FEAT_ERR(fn, ln, __VA_ARGS__);                     \
+		rte_errno = _err;                                          \
+	} while (0)
+
+
+static struct rte_mbuf_dynfield rte_graph_feature_arc_mbuf_desc = {
+	.name = RTE_GRAPH_FEATURE_ARC_DYNFIELD_NAME,
+	.size = sizeof(struct rte_graph_feature_arc_mbuf_dynfields),
+	.align = alignof(struct rte_graph_feature_arc_mbuf_dynfields),
+};
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_graph_feature_arc_main, 25.07);
+rte_graph_feature_arc_main_t *__rte_graph_feature_arc_main;
+
+/* global feature arc list */
+static STAILQ_HEAD(, rte_graph_feature_arc_register) feature_arc_list =
+					STAILQ_HEAD_INITIALIZER(feature_arc_list);
+
+/* global feature arc list */
+static STAILQ_HEAD(, rte_graph_feature_register) feature_list =
+					STAILQ_HEAD_INITIALIZER(feature_list);
+
+ /*
+  * feature data index is not fixed for given [feature, index], although it can
+  * be, which is calculated as follows (fdata_fix_get())
+  *
+  * fdata = (arc->max_features * feature ) + index;
+  *
+  * But feature data index should not be fixed for any index. i.e
+  * on any index, feature data can be placed. A slow path array is
+  * maintained and within a feature range [start, end] it is checked where
+  * feature_data_index is already placed.
+  *
+  * If is_release == false. feature_data_index is searched in a feature range.
+  * If found, index is returned. If not found, then reserve and return.
+  *
+  * If is_release == true, then feature_data_index is released for further
+  * usage
+  */
+static rte_graph_feature_data_t
+fdata_dyn_reserve_or_rel(struct rte_graph_feature_arc *arc, rte_graph_feature_t f,
+			 uint32_t index, bool is_release,
+			 bool fdata_provided, rte_graph_feature_data_t fd)
+{
+	rte_graph_feature_data_t start, end, fdata;
+	rte_graph_feature_t next_feat;
+
+	if (fdata_provided)
+		fdata = fd;
+	else
+		fdata = fdata_fix_get(arc, f, index);
+
+	next_feat = f + 1;
+	/* Find in a given feature range, feature data is stored or not */
+	for (start = fdata_fix_get(arc, f, 0),
+	     end = fdata_fix_get(arc, next_feat, 0);
+	     start < end;
+	     start++) {
+		if (arc->feature_data_by_index[start] == fdata) {
+			if (is_release)
+				arc->feature_data_by_index[start] = RTE_GRAPH_FEATURE_DATA_INVALID;
+
+			return start;
+		}
+	}
+
+	if (is_release)
+		return RTE_GRAPH_FEATURE_DATA_INVALID;
+
+	/* If not found, then reserve valid one */
+	for (start = fdata_fix_get(arc, f, 0),
+	     end = fdata_fix_get(arc, next_feat, 0);
+	     start < end;
+	     start++) {
+		if (arc->feature_data_by_index[start] == RTE_GRAPH_FEATURE_DATA_INVALID) {
+			arc->feature_data_by_index[start] = fdata;
+			return start;
+		}
+	}
+
+	/* This should not happen */
+	if (!fdata_provided)
+		RTE_VERIFY(0);
+
+	return RTE_GRAPH_FEATURE_DATA_INVALID;
+}
+
+static rte_graph_feature_data_t
+fdata_reserve(struct rte_graph_feature_arc *arc,
+	      rte_graph_feature_t feature,
+	      uint32_t index)
+{
+	return fdata_dyn_reserve_or_rel(arc, feature + 1, index, false, false, 0);
+}
+
+static rte_graph_feature_data_t
+fdata_release(struct rte_graph_feature_arc *arc,
+	      rte_graph_feature_t feature,
+	      uint32_t index)
+{
+	return fdata_dyn_reserve_or_rel(arc, feature + 1, index, true, false, 0);
+}
+
+static rte_graph_feature_data_t
+first_fdata_reserve(struct rte_graph_feature_arc *arc,
+		    uint32_t index)
+{
+	return fdata_dyn_reserve_or_rel(arc, 0, index, false, false, 0);
+}
+
+static rte_graph_feature_data_t
+first_fdata_release(struct rte_graph_feature_arc *arc,
+		    uint32_t index)
+{
+	return fdata_dyn_reserve_or_rel(arc, 0, index, true, false, 0);
+}
+
+static rte_graph_feature_data_t
+extra_fdata_reserve(struct rte_graph_feature_arc *arc,
+		    rte_graph_feature_t feature,
+		    uint32_t index)
+{
+	rte_graph_feature_data_t fdata, fdata2;
+	rte_graph_feature_t f;
+
+	f = arc->num_added_features + NUM_EXTRA_FEATURE_DATA - 1;
+
+	fdata = fdata_dyn_reserve_or_rel(arc, f, index,
+					 false, true, fdata_fix_get(arc, feature + 1, index));
+
+	/* we do not have enough space in as
+	 * extra fdata accommodates indexes for all features
+	 * Needed (feature * index) space but has only (index) number of space.
+	 * So dynamic allocation can fail.  When fail use static allocation
+	 */
+	if (fdata == RTE_GRAPH_FEATURE_DATA_INVALID) {
+		fdata = fdata_fix_get(arc, feature + 1, index);
+		fdata2 = fdata_fix_get(arc, f, index);
+		arc->feature_data_by_index[fdata2] = fdata;
+	}
+	return fdata;
+}
+
+static rte_graph_feature_data_t
+extra_fdata_release(struct rte_graph_feature_arc *arc,
+		    rte_graph_feature_t feature,
+		    uint32_t index)
+{
+	rte_graph_feature_t f;
+
+	f = arc->num_added_features + NUM_EXTRA_FEATURE_DATA - 1;
+	return fdata_dyn_reserve_or_rel(arc, f, index,
+					true, true, fdata_fix_get(arc, feature + 1, index));
+}
+
+/* feature registration validate */
+static int
+feature_registration_validate(struct rte_graph_feature_register *feat_entry,
+			      const char *caller_name, int lineno,
+			      int check_node_reg_id, /* check feature_node->id */
+			      int check_feat_reg_id, /* check feature->feature_node_id */
+			      bool verbose /* print error */)
+{
+	if (!feat_entry) {
+		COND_ERR_JMP(EINVAL, verbose, caller_name, lineno, "NULL feature reg");
+		return -1;
+	}
+
+	if (!feat_entry->feature_name) {
+		COND_ERR_JMP(EINVAL, verbose, caller_name, lineno,
+			     "%p: NULL feature name", feat_entry);
+		return -1;
+	}
+
+	if (!feat_entry->arc_name) {
+		COND_ERR_JMP(EINVAL, verbose, caller_name, lineno,
+			     "feature-\"%s\": No associated arc provided",
+			     feat_entry->feature_name);
+		return -1;
+	}
+
+	if (!feat_entry->feature_process_fn) {
+		COND_ERR_JMP(EINVAL, verbose, caller_name, lineno,
+			     "feature-\"%s\": No process function provided",
+			     feat_entry->feature_name);
+		return -1;
+	}
+
+	if (!feat_entry->feature_node) {
+		COND_ERR_JMP(EINVAL, verbose, caller_name, lineno,
+			     "feature-\"%s\": No feature_node provided",
+			     feat_entry->feature_name);
+		return -1;
+	}
+
+	if (check_node_reg_id && (feat_entry->feature_node->id == RTE_NODE_ID_INVALID)) {
+		COND_ERR_JMP(EINVAL, verbose, caller_name, lineno,
+			     "feature-\"%s\": feature_node with invalid node-id found",
+			     feat_entry->feature_name);
+		return -1;
+	}
+
+	if (check_feat_reg_id && (feat_entry->feature_node_id == RTE_NODE_ID_INVALID)) {
+		COND_ERR_JMP(EINVAL, verbose, caller_name, lineno,
+			     "feature-\"%s\": feature_node_id found invalid",
+			     feat_entry->feature_name);
+		return -1;
+	}
+	if (check_feat_reg_id && feat_entry->feature_node) {
+		if (feat_entry->feature_node_id != feat_entry->feature_node->id) {
+			COND_ERR_JMP(EINVAL, verbose, caller_name, lineno,
+				     "feature-\"%s\": feature_node_id(%u) not corresponding to %s->id(%u)",
+				     feat_entry->feature_name, feat_entry->feature_node_id,
+				     feat_entry->feature_node->name, feat_entry->feature_node->id);
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+/* validate arc registration */
+static int
+arc_registration_validate(struct rte_graph_feature_arc_register *reg,
+			  const char *caller_name, int lineno,
+			  bool verbose)
+{
+
+	if (reg == NULL) {
+		COND_ERR_JMP(EINVAL, verbose, caller_name, lineno,
+			     "arc registration cannot be NULL");
+		return -1;
+	}
+
+	if (!reg->arc_name) {
+		COND_ERR_JMP(EINVAL, verbose, caller_name, lineno,
+			     "feature_arc name cannot be NULL");
+		return -1;
+	}
+
+	if (reg->max_features > GRAPH_FEATURE_MAX_NUM_PER_ARC) {
+		COND_ERR_JMP(EAGAIN, verbose, caller_name, lineno,
+			     "arc-\"%s\", invalid number of features (found: %u, exp: %u)",
+			     reg->arc_name, reg->max_features, GRAPH_FEATURE_MAX_NUM_PER_ARC);
+		return -1;
+	}
+
+	if (!reg->max_indexes) {
+		COND_ERR_JMP(EINVAL, verbose, caller_name, lineno,
+			     "arc-\"%s\": Zero max_indexes found",
+			     reg->arc_name);
+		return -1;
+	}
+
+	if (!reg->start_node) {
+		COND_ERR_JMP(EINVAL, verbose, caller_name, lineno,
+			     "arc-\"%s\": start node cannot be NULL",
+			     reg->arc_name);
+		return -1;
+	}
+
+	if (!reg->start_node_feature_process_fn) {
+		COND_ERR_JMP(EINVAL, verbose, caller_name, lineno,
+			     "arc-\"%s\": start node feature_process_fn() cannot be NULL",
+			     reg->arc_name);
+		return -1;
+	}
+
+	if (!reg->end_feature) {
+		COND_ERR_JMP(EINVAL, verbose, caller_name, lineno,
+			     "arc-\"%s\": end_feature cannot be NULL",
+			     reg->arc_name);
+		return -1;
+	}
+
+	if (feature_registration_validate(reg->end_feature, caller_name, lineno, 1, 0, verbose))
+		return -1;
+
+	if (strncmp(reg->arc_name, reg->end_feature->arc_name,
+		    RTE_GRAPH_FEATURE_ARC_NAMELEN)) {
+		COND_ERR_JMP(EINVAL, verbose, caller_name, lineno,
+			     "arc-\"%s\"/feature-\"%s\": mismatch in arc_name in end_feature",
+			     reg->arc_name, reg->end_feature->feature_name);
+		return -1;
+	}
+
+	return 0;
+}
+
+/* lookup arc registration by name */
+static int arc_registration_num(void)
+{
+	struct rte_graph_feature_arc_register *entry = NULL;
+	int num = 0;
+
+	STAILQ_FOREACH(entry, &feature_arc_list, next_arc)
+		num++;
+
+	return num;
+}
+
+
+/* lookup arc registration by name */
+static int arc_registration_lookup(const char *arc_name,
+				   struct rte_graph_feature_arc_register **arc_entry,
+				   bool verbose /* print error */)
+{
+	struct rte_graph_feature_arc_register *entry = NULL;
+
+	STAILQ_FOREACH(entry, &feature_arc_list, next_arc) {
+		if (arc_registration_validate(entry, __func__, __LINE__, verbose) < 0)
+			continue;
+
+		if (!strncmp(entry->arc_name, arc_name, RTE_GRAPH_FEATURE_ARC_NAMELEN)) {
+			if (arc_entry)
+				*arc_entry = entry;
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+
+/* Number of features registered for an ARC
+ *
+ * i.e number of RTE_GRAPH_FEATURE_REGISTER() for an arc
+ */
+static int
+arc_registered_features_num(const char *arc_name, uint16_t *num_features)
+{
+	struct rte_graph_feature_arc_register *arc_reg = NULL;
+	struct rte_graph_feature_register *feat_entry = NULL;
+	uint16_t num = 0;
+
+	/* Check if arc is registered with end_feature */
+	if (!arc_registration_lookup(arc_name, &arc_reg, false))
+		return -1;
+
+	if (arc_reg->end_feature)
+		num++;
+
+	/* Calculate features other than end_feature added in arc */
+	STAILQ_FOREACH(feat_entry, &feature_list, next_feature) {
+		if (feature_registration_validate(feat_entry, __func__, __LINE__, 1, 0, false) < 0)
+			continue;
+
+		if (!strncmp(feat_entry->arc_name, arc_name, strlen(feat_entry->arc_name)))
+			num++;
+	}
+
+	if (num_features)
+		*num_features = num;
+
+	return 0;
+}
+
+static int
+arc_max_index_get(const char *arc_name, uint16_t *max_indexes)
+{
+	struct rte_graph_feature_arc_register *arc_reg = NULL;
+	struct rte_graph_feature_register *feat_entry = NULL;
+	uint16_t index;
+
+	if (!max_indexes)
+		return -1;
+
+	/* Check if arc is registered with end_feature */
+	if (!arc_registration_lookup(arc_name, &arc_reg, false))
+		return -1;
+
+	index = *max_indexes;
+
+	/* Call features override_index_cb(), if set */
+	STAILQ_FOREACH(feat_entry, &feature_list, next_feature) {
+		if (!feat_entry->override_index_cb)
+			continue;
+
+		if (feature_registration_validate(feat_entry, __func__, __LINE__, 1, 0, false) < 0)
+			continue;
+
+		index = RTE_MAX(index, feat_entry->override_index_cb());
+	}
+
+	*max_indexes = index;
+
+	return 0;
+}
+
+/* calculate arc size to be allocated */
+static int
+feature_arc_reg_calc_size(struct rte_graph_feature_arc_register *reg, size_t *sz,
+			  uint16_t *feat_off, uint16_t *fdata_off, uint32_t *fsz,
+			  uint16_t *num_index)
+{
+	size_t ff_size = 0, fdata_size = 0;
+
+	/* first feature array per index */
+	ff_size = RTE_ALIGN_CEIL(sizeof(rte_graph_feature_data_t) * reg->max_indexes,
+				 RTE_CACHE_LINE_SIZE);
+
+
+	/* fdata size per feature */
+	*fsz = (uint32_t)RTE_ALIGN_CEIL(sizeof(struct rte_graph_feature_data) * reg->max_indexes,
+					RTE_CACHE_LINE_SIZE);
+
+	*num_index = (*fsz)/sizeof(struct rte_graph_feature_data);
+
+	/* Allocate feature_data extra by 2.
+	 * 0th index is used for first feature data from start_node
+	 * Last feature data is used for extra_fdata for end_feature
+	 */
+	fdata_size = (*fsz) * (reg->max_features + NUM_EXTRA_FEATURE_DATA);
+
+	if (sz)
+		*sz = fdata_size + ff_size + sizeof(struct rte_graph_feature_arc);
+	if (feat_off)
+		*feat_off = sizeof(struct rte_graph_feature_arc);
+	if (fdata_off)
+		*fdata_off = ff_size + sizeof(struct rte_graph_feature_arc);
+
+	return 0;
+}
+
+static rte_graph_feature_data_t *
+graph_first_feature_data_ptr_get(struct rte_graph_feature_arc *arc,
+				 uint32_t index)
+{
+	return (rte_graph_feature_data_t *)((uint8_t *)arc + arc->fp_first_feature_offset +
+					    (sizeof(rte_graph_feature_data_t) * index));
+}
+
+static int
+feature_arc_data_reset(struct rte_graph_feature_arc *arc)
+{
+	rte_graph_feature_data_t first_fdata;
+	struct rte_graph_feature_data *fdata;
+	rte_graph_feature_data_t *f = NULL;
+	rte_graph_feature_t iter;
+	uint16_t index;
+
+	arc->runtime_enabled_features = 0;
+
+	for (index = 0; index < arc->max_indexes; index++) {
+		f = graph_first_feature_data_ptr_get(arc, index);
+		*f = RTE_GRAPH_FEATURE_DATA_INVALID;
+	}
+
+	for (iter = 0; iter < arc->max_features + NUM_EXTRA_FEATURE_DATA; iter++) {
+		first_fdata = fdata_fix_get(arc, iter, 0);
+		for (index = 0; index < arc->max_indexes; index++) {
+			fdata = rte_graph_feature_data_get(arc, first_fdata + index);
+			fdata->next_feature_data = RTE_GRAPH_FEATURE_DATA_INVALID;
+			fdata->app_cookie = UINT16_MAX;
+			fdata->next_edge = RTE_EDGE_ID_INVALID;
+		}
+	}
+	return 0;
+}
+
+/*
+ * lookup feature name and get control path node_list as well as feature index
+ * at which it is inserted
+ */
+static int
+nodeinfo_lkup_by_name(struct rte_graph_feature_arc *arc, const char *feat_name,
+		      struct rte_graph_feature_node_list **ffinfo, uint32_t *slot)
+{
+	struct rte_graph_feature_node_list *finfo = NULL;
+	uint32_t fi = 0;
+
+	if (!feat_name)
+		return -1;
+
+	if (slot)
+		*slot = UINT32_MAX;
+
+	STAILQ_FOREACH(finfo, &arc->all_features, next_feature) {
+		RTE_VERIFY(finfo->feature_arc == arc);
+		if (!strncmp(finfo->feature_name, feat_name, strlen(finfo->feature_name))) {
+			if (ffinfo)
+				*ffinfo = finfo;
+			if (slot)
+				*slot = fi;
+			return 0;
+		}
+		fi++;
+	}
+	return -1;
+}
+
+/* Lookup used only during rte_graph_feature_add() */
+static int
+nodeinfo_add_lookup(struct rte_graph_feature_arc *arc, const char *feat_node_name,
+		    struct rte_graph_feature_node_list **ffinfo, uint32_t *slot)
+{
+	struct rte_graph_feature_node_list *finfo = NULL;
+	uint32_t fi = 0;
+
+	if (!feat_node_name)
+		return -1;
+
+	if (slot)
+		*slot = 0;
+
+	STAILQ_FOREACH(finfo, &arc->all_features, next_feature) {
+		RTE_VERIFY(finfo->feature_arc == arc);
+		if (!strncmp(finfo->feature_name, feat_node_name, strlen(finfo->feature_name))) {
+			if (ffinfo)
+				*ffinfo = finfo;
+			if (slot)
+				*slot = fi;
+			return 0;
+		}
+		/* Update slot where new feature can be added */
+		if (slot)
+			*slot = fi;
+		fi++;
+	}
+
+	return -1;
+}
+
+/* Get control path node info from provided input feature_index */
+static int
+nodeinfo_lkup_by_index(struct rte_graph_feature_arc *arc, uint32_t feature_index,
+		       struct rte_graph_feature_node_list **ppfinfo,
+		       const int do_sanity_check)
+{
+	struct rte_graph_feature_node_list *finfo = NULL;
+	uint32_t index = 0;
+
+	if (!ppfinfo)
+		return -1;
+
+	*ppfinfo = NULL;
+	STAILQ_FOREACH(finfo, &arc->all_features, next_feature) {
+		/* Check sanity */
+		if (do_sanity_check)
+			if (finfo->finfo_index != index)
+				RTE_VERIFY(0);
+		if (index == feature_index) {
+			*ppfinfo = finfo;
+			return 0;
+		}
+		index++;
+	}
+	return -1;
+}
+
+/* get existing edge from parent_node -> child_node */
+static int
+get_existing_edge(const char *arc_name, rte_node_t parent_node,
+		  rte_node_t child_node, rte_edge_t *_edge)
+{
+	char **next_edges = NULL;
+	uint32_t i, count = 0;
+
+	RTE_SET_USED(arc_name);
+
+	count = rte_node_edge_get(parent_node, NULL);
+
+	if (!count)
+		return -1;
+
+	next_edges = malloc(count);
+
+	if (!next_edges)
+		return -1;
+
+	count = rte_node_edge_get(parent_node, next_edges);
+	for (i = 0; i < count; i++) {
+		if (strstr(rte_node_id_to_name(child_node), next_edges[i])) {
+			if (_edge)
+				*_edge = (rte_edge_t)i;
+
+			free(next_edges);
+			return 0;
+		}
+	}
+	free(next_edges);
+
+	return -1;
+}
+
+
+/* prepare feature arc after addition of all features */
+static int
+prepare_feature_arc_before_first_enable(struct rte_graph_feature_arc *arc)
+{
+	struct rte_graph_feature_node_list *lfinfo = NULL;
+	struct rte_graph_feature_node_list *finfo = NULL;
+	char name[2 * RTE_GRAPH_FEATURE_ARC_NAMELEN];
+	uint32_t findex = 0, iter;
+	uint16_t num_fdata;
+	rte_edge_t edge;
+	size_t sz = 0;
+
+	STAILQ_FOREACH(lfinfo, &arc->all_features, next_feature) {
+		lfinfo->finfo_index = findex;
+		findex++;
+	}
+	if (!findex) {
+		graph_err("No feature added to arc: %s", arc->feature_arc_name);
+		return -1;
+	}
+	arc->num_added_features = findex;
+	num_fdata = arc->num_added_features + NUM_EXTRA_FEATURE_DATA;
+
+	sz = num_fdata * arc->max_indexes * sizeof(rte_graph_feature_data_t);
+
+	snprintf(name, sizeof(name), "%s-fdata", arc->feature_arc_name);
+
+	arc->feature_data_by_index = rte_malloc(name, sz, 0);
+	if (!arc->feature_data_by_index) {
+		graph_err("fdata/index rte_malloc failed for %s", name);
+		return -1;
+	}
+
+	for (iter = 0; iter < (num_fdata * arc->max_indexes); iter++)
+		arc->feature_data_by_index[iter] = RTE_GRAPH_FEATURE_DATA_INVALID;
+
+	/* Grab finfo corresponding to end_feature */
+	nodeinfo_lkup_by_index(arc, arc->num_added_features - 1, &lfinfo, 0);
+
+	/* lfinfo should be the info corresponding to end_feature
+	 * Add edge from all features to end feature node to have exception path
+	 * in fast path from all feature nodes to end feature node during enable/disable
+	 */
+	if (lfinfo->feature_node_id != arc->end_feature.feature_node_id) {
+		graph_err("end_feature node mismatch [found-%s: exp-%s]",
+			  rte_node_id_to_name(lfinfo->feature_node_id),
+			  rte_node_id_to_name(arc->end_feature.feature_node_id));
+		goto free_fdata_by_index;
+	}
+
+	STAILQ_FOREACH(finfo, &arc->all_features, next_feature) {
+		if (get_existing_edge(arc->feature_arc_name, arc->start_node->id,
+				      finfo->feature_node_id, &edge)) {
+			graph_err("No edge found from %s to %s",
+				  rte_node_id_to_name(arc->start_node->id),
+				  rte_node_id_to_name(finfo->feature_node_id));
+			goto free_fdata_by_index;
+		}
+		finfo->edge_to_this_feature = edge;
+
+		if (finfo == lfinfo)
+			continue;
+
+		if (get_existing_edge(arc->feature_arc_name, finfo->feature_node_id,
+				      lfinfo->feature_node_id, &edge)) {
+			graph_err("No edge found from %s to %s",
+				  rte_node_id_to_name(finfo->feature_node_id),
+				  rte_node_id_to_name(lfinfo->feature_node_id));
+			goto free_fdata_by_index;
+		}
+		finfo->edge_to_last_feature = edge;
+	}
+	/**
+	 * Enable end_feature in control bitmask
+	 * (arc->feature_bit_mask_by_index) but not in fast path bitmask
+	 * arc->fp_feature_enable_bitmask. This is due to:
+	 * 1. Application may not explicitly enabling end_feature node
+	 * 2. However it should be enabled internally so that when a feature is
+	 *    disabled (say on an interface), next_edge of data should be
+	 *    updated to end_feature node hence packet can exit arc.
+	 * 3. We do not want to set bit for end_feature in fast path bitmask as
+	 *    it will void the purpose of fast path APIs
+	 *    rte_graph_feature_arc_is_any_feature_enabled(). Since enabling
+	 *    end_feature would make these APIs to always return "true"
+	 */
+	for (iter = 0; iter < arc->max_indexes; iter++)
+		arc->feature_bit_mask_by_index[iter] |= (1 << lfinfo->finfo_index);
+
+	return 0;
+
+free_fdata_by_index:
+	rte_free(arc->feature_data_by_index);
+	return -1;
+}
+
+/* feature arc sanity */
+static int
+feature_arc_sanity(rte_graph_feature_arc_t _arc)
+{
+	struct rte_graph_feature_arc *arc = rte_graph_feature_arc_get(_arc);
+	rte_graph_feature_arc_main_t *dm = __rte_graph_feature_arc_main;
+	uint16_t iter;
+
+	if (!__rte_graph_feature_arc_main)
+		return -1;
+
+	if (!arc)
+		return -1;
+
+	for (iter = 0; iter < dm->max_feature_arcs; iter++) {
+		if (arc == rte_graph_feature_arc_get(iter)) {
+			if (arc->feature_arc_index != iter)
+				return -1;
+			if (arc->feature_arc_main != dm)
+				return -1;
+
+			return 0;
+		}
+	}
+	return -1;
+}
+
+/* create or retrieve already existing edge from parent_node -> child_node */
+static int
+__connect_graph_nodes(rte_node_t parent_node, rte_node_t child_node,
+		    rte_edge_t *_edge, char *arc_name, int lineno)
+{
+	const char *next_node = NULL;
+	rte_edge_t edge;
+
+	if (!get_existing_edge(arc_name, parent_node, child_node, &edge)) {
+		feat_dbg("\t%s/%d: %s[%u]: \"%s\", edge reused", arc_name, lineno,
+			 rte_node_id_to_name(parent_node), edge, rte_node_id_to_name(child_node));
+
+		if (_edge)
+			*_edge = edge;
+
+		return 0;
+	}
+
+	/* Node to be added */
+	next_node = rte_node_id_to_name(child_node);
+
+	edge = rte_node_edge_update(parent_node, RTE_EDGE_ID_INVALID, &next_node, 1);
+
+	if (edge == RTE_EDGE_ID_INVALID) {
+		graph_err("edge invalid");
+		return -1;
+	}
+	edge = rte_node_edge_count(parent_node) - 1;
+
+	feat_dbg("\t%s/%d: %s[%u]: \"%s\", new edge added", arc_name, lineno,
+		 rte_node_id_to_name(parent_node), edge, rte_node_id_to_name(child_node));
+
+	if (_edge)
+		*_edge = edge;
+
+	return 0;
+}
+
+/* feature arc initialization */
+static int
+feature_arc_main_init(rte_graph_feature_arc_main_t **pfl, uint32_t max_feature_arcs)
+{
+	rte_graph_feature_arc_main_t *pm = NULL;
+	const struct rte_memzone *mz = NULL;
+	uint32_t i;
+	size_t sz;
+
+	if (!pfl) {
+		graph_err("Invalid input");
+		return -1;
+	}
+
+	sz = sizeof(rte_graph_feature_arc_main_t) +
+		(sizeof(pm->feature_arcs[0]) * max_feature_arcs);
+
+	mz = rte_memzone_reserve(FEATURE_ARC_MEMZONE_NAME, sz, SOCKET_ID_ANY, 0);
+	if (!mz) {
+		graph_err("memzone reserve failed for feature arc main");
+		return -1;
+	}
+
+	pm = mz->addr;
+	memset(pm, 0, sz);
+
+	pm->arc_mbuf_dyn_offset = -1;
+	pm->arc_mbuf_dyn_offset = rte_mbuf_dynfield_register(&rte_graph_feature_arc_mbuf_desc);
+
+	if (pm->arc_mbuf_dyn_offset < 0) {
+		graph_err("rte_graph_feature_arc_dynfield_register failed");
+		rte_memzone_free(mz);
+		return -1;
+	}
+	for (i = 0; i < max_feature_arcs; i++)
+		pm->feature_arcs[i] = GRAPH_FEATURE_ARC_PTR_INITIALIZER;
+
+	pm->max_feature_arcs = max_feature_arcs;
+
+	*pfl = pm;
+
+	return 0;
+}
+
+static int
+feature_enable_disable_validate(rte_graph_feature_arc_t _arc, uint32_t index,
+				const char *feature_name,
+				int is_enable_disable, bool emit_logs)
+{
+	struct rte_graph_feature_arc *arc = rte_graph_feature_arc_get(_arc);
+	struct rte_graph_feature_node_list *finfo = NULL;
+	uint32_t slot, last_end_feature;
+
+	if (!arc)
+		return -EINVAL;
+
+	/* validate _arc */
+	if (arc->feature_arc_main != __rte_graph_feature_arc_main) {
+		FEAT_COND_ERR(emit_logs, "invalid feature arc: 0x%x", _arc);
+		return -EINVAL;
+	}
+
+	/* validate index */
+	if (index >= arc->max_indexes) {
+		FEAT_COND_ERR(emit_logs, "%s: Invalid provided index: %u >= %u configured",
+			      arc->feature_arc_name, index, arc->max_indexes);
+		return -1;
+	}
+
+	/* validate feature_name is already added or not  */
+	if (nodeinfo_lkup_by_name(arc, feature_name, &finfo, &slot)) {
+		FEAT_COND_ERR(emit_logs, "%s: No feature %s added",
+			      arc->feature_arc_name, feature_name);
+		return -EINVAL;
+	}
+
+	if (!finfo) {
+		FEAT_COND_ERR(emit_logs, "%s: No feature: %s found to enable/disable",
+			      arc->feature_arc_name, feature_name);
+		return -EINVAL;
+	}
+
+	/* slot should be in valid range */
+	if (slot >= arc->num_added_features) {
+		FEAT_COND_ERR(emit_logs, "%s/%s: Invalid free slot %u(max=%u) for feature",
+			      arc->feature_arc_name, feature_name, slot, arc->num_added_features);
+		return -EINVAL;
+	}
+
+	/* slot should be in range of 0 - 63 */
+	if (slot > (GRAPH_FEATURE_MAX_NUM_PER_ARC - 1)) {
+		FEAT_COND_ERR(emit_logs, "%s/%s: Invalid slot: %u", arc->feature_arc_name,
+			      feature_name, slot);
+		return -EINVAL;
+	}
+
+	last_end_feature = rte_fls_u64(arc->feature_bit_mask_by_index[index]);
+	if (!last_end_feature) {
+		FEAT_COND_ERR(emit_logs, "%s: End feature not enabled", arc->feature_arc_name);
+		return -EINVAL;
+	}
+
+	/* if enabled feature is not end feature node and already enabled */
+	if (is_enable_disable &&
+	    (arc->feature_bit_mask_by_index[index] & RTE_BIT64(slot)) &&
+	    (slot != (last_end_feature - 1))) {
+		FEAT_COND_ERR(emit_logs, "%s: %s already enabled on index: %u",
+			      arc->feature_arc_name, feature_name, index);
+		return -1;
+	}
+
+	if (!is_enable_disable && !arc->runtime_enabled_features) {
+		FEAT_COND_ERR(emit_logs, "%s: No feature enabled to disable",
+			      arc->feature_arc_name);
+		return -1;
+	}
+
+	if (!is_enable_disable && !(arc->feature_bit_mask_by_index[index] & RTE_BIT64(slot))) {
+		FEAT_COND_ERR(emit_logs, "%s: %s not enabled in bitmask for index: %u",
+			      arc->feature_arc_name, feature_name, index);
+		return -1;
+	}
+
+	/* If no feature has been enabled, avoid extra sanity checks */
+	if (!arc->runtime_enabled_features)
+		return 0;
+
+	if (finfo->finfo_index != slot) {
+		FEAT_COND_ERR(emit_logs,
+			      "%s/%s: lookup slot mismatch for finfo idx: %u and lookup slot: %u",
+			      arc->feature_arc_name, feature_name, finfo->finfo_index, slot);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int
+refill_fastpath_data(struct rte_graph_feature_arc *arc, uint32_t feature_bit,
+		     uint16_t index /* array index */, int is_enable_disable)
+{
+	struct rte_graph_feature_data *gfd = NULL, *prev_gfd = NULL, *fdptr = NULL;
+	struct rte_graph_feature_node_list *finfo = NULL, *prev_finfo = NULL;
+	RTE_ATOMIC(rte_graph_feature_data_t) * first_fdata = NULL;
+	uint32_t fi = 0, prev_fi = 0, next_fi = 0, cfi = 0;
+	uint64_t bitmask = 0, prev_bitmask, next_bitmask;
+	rte_graph_feature_data_t *__first_fd = NULL;
+	rte_edge_t edge = RTE_EDGE_ID_INVALID;
+	rte_graph_feature_data_t fdata, _fd;
+	bool update_first_feature = false;
+
+	if (is_enable_disable)
+		bitmask = RTE_BIT64(feature_bit);
+
+	/* set bit from (feature_bit + 1) to 64th bit */
+	next_bitmask = UINT64_MAX << (feature_bit + 1);
+
+	/* set bits from 0 to (feature_bit - 1) */
+	prev_bitmask = ((UINT64_MAX & ~next_bitmask) & ~(RTE_BIT64(feature_bit)));
+
+	next_bitmask &= arc->feature_bit_mask_by_index[index];
+	prev_bitmask &= arc->feature_bit_mask_by_index[index];
+
+	/* Set next bit set in next_bitmask */
+	if (rte_bsf64_safe(next_bitmask, &next_fi))
+		bitmask |= RTE_BIT64(next_fi);
+
+	/* Set prev bit set in prev_bitmask*/
+	prev_fi = rte_fls_u64(prev_bitmask);
+	if (prev_fi)
+		bitmask |= RTE_BIT64(prev_fi - 1);
+
+	/* for each feature set for index, set fast path data */
+	prev_gfd = NULL;
+	while (rte_bsf64_safe(bitmask, &fi)) {
+		_fd = fdata_reserve(arc, fi, index);
+		gfd = rte_graph_feature_data_get(arc, _fd);
+
+		RTE_VERIFY(!nodeinfo_lkup_by_index(arc, fi, &finfo, 1));
+
+		/* Reset next edge to point to last feature node so that packet
+		 * can exit from arc
+		 */
+		rte_atomic_store_explicit(&gfd->next_edge,
+					  finfo->edge_to_last_feature,
+					  rte_memory_order_relaxed);
+
+		/* If previous feature_index was valid in last loop */
+		if (prev_gfd != NULL) {
+			/*
+			 * Get edge of previous feature node connecting
+			 * to this feature node
+			 */
+			RTE_VERIFY(!nodeinfo_lkup_by_index(arc, prev_fi, &prev_finfo, 1));
+
+			if (!get_existing_edge(arc->feature_arc_name,
+					      prev_finfo->feature_node_id,
+					      finfo->feature_node_id, &edge)) {
+				feat_dbg("\t[%s/index:%2u,cookie:%u]: (%u->%u)%s[%u] = %s",
+					 arc->feature_arc_name, index,
+					 gfd->app_cookie, prev_fi, fi,
+					 rte_node_id_to_name(prev_finfo->feature_node_id),
+					 edge, rte_node_id_to_name(finfo->feature_node_id));
+
+				rte_atomic_store_explicit(&prev_gfd->next_edge,
+							  edge,
+							  rte_memory_order_relaxed);
+
+				rte_atomic_store_explicit(&prev_gfd->next_feature_data, _fd,
+							  rte_memory_order_relaxed);
+			} else {
+				/* Should not fail */
+				RTE_VERIFY(0);
+			}
+		}
+		/* On first feature
+		 * 1. Update fdata with next_edge from start_node to feature node
+		 * 2. Update first enabled feature in its index array
+		 */
+		if (rte_bsf64_safe(arc->feature_bit_mask_by_index[index], &cfi)) {
+			update_first_feature = (cfi == fi) ? true : false;
+
+			if (update_first_feature) {
+				feat_dbg("\t[%s/index:%2u,cookie:%u]: (->%u)%s[%u]=%s",
+					 arc->feature_arc_name, index,
+					 gfd->app_cookie, fi,
+					 arc->start_node->name, finfo->edge_to_this_feature,
+					 rte_node_id_to_name(finfo->feature_node_id));
+
+				/* Reserve feature data @0th index for first feature */
+				fdata = first_fdata_reserve(arc, index);
+				fdptr = rte_graph_feature_data_get(arc, fdata);
+
+				/* add next edge into feature data
+				 * First set feature data then first feature memory
+				 */
+				rte_atomic_store_explicit(&fdptr->next_edge,
+							  finfo->edge_to_this_feature,
+							  rte_memory_order_relaxed);
+
+				rte_atomic_store_explicit(&fdptr->next_feature_data,
+							  _fd,
+							  rte_memory_order_relaxed);
+
+				__first_fd = graph_first_feature_data_ptr_get(arc, index);
+				first_fdata = (RTE_ATOMIC(rte_graph_feature_data_t) *)__first_fd;
+
+				/* Save reserved feature data @fp_index */
+				rte_atomic_store_explicit(first_fdata, fdata,
+							  rte_memory_order_relaxed);
+			}
+		}
+		prev_fi = fi;
+		prev_gfd = gfd;
+		/* Clear current feature index */
+		bitmask &= ~RTE_BIT64(fi);
+	}
+	/* If all features are disabled on index, except end feature
+	 * then release 0th index
+	 */
+	if (!is_enable_disable &&
+	    (rte_popcount64(arc->feature_bit_mask_by_index[index]) == 1))
+		first_fdata_release(arc, index);
+
+	return 0;
+}
+
+/* feature arc initialization, public API */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_init, 25.07);
+int
+rte_graph_feature_arc_init(uint16_t num_feature_arcs)
+{
+	struct rte_graph_feature_arc_register *arc_reg = NULL;
+	struct rte_graph_feature_register *feat_reg = NULL;
+	const struct rte_memzone *mz = NULL;
+	int max_feature_arcs;
+	int rc = -1;
+
+	if (!__rte_graph_feature_arc_main) {
+		mz = rte_memzone_lookup(FEATURE_ARC_MEMZONE_NAME);
+		if (mz) {
+			__rte_graph_feature_arc_main = mz->addr;
+			return 0;
+		}
+		max_feature_arcs = num_feature_arcs + arc_registration_num();
+		if (!max_feature_arcs) {
+			graph_err("No feature arcs registered");
+			return -1;
+		}
+		rc = feature_arc_main_init(&__rte_graph_feature_arc_main, max_feature_arcs);
+		if (rc < 0)
+			return rc;
+	}
+
+	STAILQ_FOREACH(arc_reg, &feature_arc_list, next_arc) {
+		if (arc_registration_validate(arc_reg, __func__, __LINE__, true) < 0)
+			continue;
+
+		/* arc lookup validates feature and arc both*/
+		if (!arc_registration_lookup(arc_reg->arc_name, NULL, false))
+			continue;
+
+		/* If feature name not set, use node name as feature */
+		if (!arc_reg->end_feature->feature_name)
+			arc_reg->end_feature->feature_name =
+				rte_node_id_to_name(arc_reg->end_feature->feature_node_id);
+
+		/* Compute number of max_features if not provided */
+		if (!arc_reg->max_features)
+			arc_registered_features_num(arc_reg->arc_name, &arc_reg->max_features);
+
+		rc = arc_max_index_get(arc_reg->arc_name, &arc_reg->max_indexes);
+		if (rc < 0) {
+			graph_err("arc_max_index_get failed for arc: %s",
+				  arc_reg->arc_name);
+			continue;
+		}
+
+		arc_reg->end_feature->feature_node_id = arc_reg->end_feature->feature_node->id;
+
+		rc = rte_graph_feature_arc_create(arc_reg, NULL);
+
+		if (rc < 0)
+			goto arc_cleanup;
+	}
+
+	/* First add those features which has no runs_after and runs_before restriction */
+	STAILQ_FOREACH(feat_reg, &feature_list, next_feature) {
+		/* Skip if arc not registered yet */
+		if (!arc_registration_lookup(feat_reg->arc_name, NULL, false))
+			continue;
+
+		if (feat_reg->runs_after || feat_reg->runs_before)
+			continue;
+
+		if (feature_registration_validate(feat_reg, __func__, __LINE__, 1, 0, false) < 0)
+			continue;
+
+		feat_reg->feature_node_id = feat_reg->feature_node->id;
+
+		rc = rte_graph_feature_add(feat_reg);
+
+		if (rc < 0)
+			goto arc_cleanup;
+	}
+	/* Add those features which has either runs_after or runs_before restrictions */
+	STAILQ_FOREACH(feat_reg, &feature_list, next_feature) {
+		/* Skip if arc not registered yet */
+		if (!arc_registration_lookup(feat_reg->arc_name, NULL, false))
+			continue;
+
+		if (!feat_reg->runs_after && !feat_reg->runs_before)
+			continue;
+
+		if (feat_reg->runs_after && feat_reg->runs_before)
+			continue;
+
+		if (feature_registration_validate(feat_reg, __func__, __LINE__, 1, 0, false) < 0)
+			continue;
+
+		feat_reg->feature_node_id = feat_reg->feature_node->id;
+
+		rc = rte_graph_feature_add(feat_reg);
+
+		if (rc < 0)
+			goto arc_cleanup;
+	}
+	/* Add those features with both runs_after and runs_before restrictions */
+	STAILQ_FOREACH(feat_reg, &feature_list, next_feature) {
+		/* Skip if arc not registered yet */
+		if (!arc_registration_lookup(feat_reg->arc_name, NULL, false))
+			continue;
+
+		if (!feat_reg->runs_after && !feat_reg->runs_before)
+			continue;
+
+		if ((feat_reg->runs_after && !feat_reg->runs_before) ||
+		    (!feat_reg->runs_after && feat_reg->runs_before))
+			continue;
+
+		if (feature_registration_validate(feat_reg, __func__, __LINE__, 1, 0, false) < 0)
+			continue;
+
+		feat_reg->feature_node_id = feat_reg->feature_node->id;
+
+		rc = rte_graph_feature_add(feat_reg);
+
+		if (rc < 0)
+			goto arc_cleanup;
+	}
+
+	return 0;
+
+arc_cleanup:
+	rte_graph_feature_arc_cleanup();
+
+	return rc;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_create, 25.07);
+int
+rte_graph_feature_arc_create(struct rte_graph_feature_arc_register *reg,
+			     rte_graph_feature_arc_t *_arc)
+{
+	rte_graph_feature_arc_main_t *dfm = NULL;
+	struct rte_graph_feature_arc *arc = NULL;
+	uint16_t first_feat_off, fdata_off;
+	const struct rte_memzone *mz = NULL;
+	uint16_t iter, arc_index, num_index;
+	uint32_t feat_sz = 0;
+	size_t sz;
+
+	if (arc_registration_validate(reg, __func__, __LINE__, true) < 0)
+		return -1;
+
+	if (!reg->end_feature ||
+	    (feature_registration_validate(reg->end_feature, __func__, __LINE__, 0, 1, true) < 0))
+		return -1;
+
+	if (!reg->max_features)
+		graph_err("Zero features found for arc \"%s\" create",
+			  reg->arc_name);
+
+	if (!__rte_graph_feature_arc_main) {
+		graph_err("Call to rte_graph_feature_arc_init() API missing");
+		return -1;
+	}
+
+	/* See if arc memory is already created */
+	mz = rte_memzone_lookup(reg->arc_name);
+	if (mz) {
+		graph_err("Feature arc %s already created", reg->arc_name);
+		arc = mz->addr;
+		return -1;
+	}
+
+	dfm = __rte_graph_feature_arc_main;
+
+	/* threshold check */
+	if (dfm->num_feature_arcs > (dfm->max_feature_arcs - 1))
+		SET_ERR_JMP(EAGAIN, arc_create_err,
+			    "%s: max number (%u) of feature arcs reached",
+			    reg->arc_name, dfm->max_feature_arcs);
+
+	/* Find the free slot for feature arc */
+	for (iter = 0; iter < dfm->max_feature_arcs; iter++) {
+		if (dfm->feature_arcs[iter] == GRAPH_FEATURE_ARC_PTR_INITIALIZER)
+			break;
+	}
+	arc_index = iter;
+
+	if (arc_index >= dfm->max_feature_arcs) {
+		graph_err("No free slot found for num_feature_arc");
+		return -1;
+	}
+
+	/* This should not happen */
+	if (dfm->feature_arcs[arc_index] != GRAPH_FEATURE_ARC_PTR_INITIALIZER) {
+		graph_err("Free arc_index: %u is not found free: %p",
+			  arc_index, (void *)dfm->feature_arcs[arc_index]);
+		return -1;
+	}
+
+	/* Calculate size of feature arc */
+	feature_arc_reg_calc_size(reg, &sz, &first_feat_off, &fdata_off, &feat_sz, &num_index);
+
+	mz = rte_memzone_reserve(reg->arc_name, sz, SOCKET_ID_ANY, 0);
+
+	if (!mz) {
+		graph_err("memzone reserve failed for arc: %s of size: %"PRIu64,
+			  reg->arc_name, sz);
+		return -1;
+	}
+
+	arc = mz->addr;
+
+	memset(arc, 0, sz);
+
+	arc->feature_bit_mask_by_index = rte_malloc(reg->arc_name,
+						    sizeof(uint64_t) * num_index, 0);
+
+	if (!arc->feature_bit_mask_by_index) {
+		graph_err("%s: rte_malloc failed for feature_bit_mask_alloc", reg->arc_name);
+		goto mz_free;
+	}
+
+	memset(arc->feature_bit_mask_by_index, 0, sizeof(uint64_t) * num_index);
+
+	/* override process function with start_node */
+	if (node_override_process_func(reg->start_node->id, reg->start_node_feature_process_fn)) {
+		graph_err("node_override_process_func failed for %s", reg->start_node->name);
+		goto feat_bitmask_free;
+	}
+	feat_dbg("arc-%s: node-%s process() overridden with %p",
+		  reg->arc_name, reg->start_node->name,
+		  reg->start_node_feature_process_fn);
+
+	/* Initialize rte_graph port group fixed variables */
+	STAILQ_INIT(&arc->all_features);
+	rte_strscpy(arc->feature_arc_name, reg->arc_name, RTE_GRAPH_FEATURE_ARC_NAMELEN - 1);
+	arc->feature_arc_main = (void *)dfm;
+	arc->start_node = reg->start_node;
+	memcpy(&arc->end_feature, reg->end_feature, sizeof(arc->end_feature));
+	arc->arc_start_process = reg->start_node_feature_process_fn;
+	arc->feature_arc_index = arc_index;
+	arc->arc_size = sz;
+
+	/* reset fast path arc variables */
+	arc->max_features = reg->max_features;
+	arc->max_indexes = num_index;
+	arc->fp_first_feature_offset = first_feat_off;
+	arc->fp_feature_data_offset = fdata_off;
+	arc->feature_size = feat_sz;
+	arc->mbuf_dyn_offset = dfm->arc_mbuf_dyn_offset;
+
+	feature_arc_data_reset(arc);
+
+	dfm->feature_arcs[arc->feature_arc_index] = (uintptr_t)arc;
+	dfm->num_feature_arcs++;
+
+	if (rte_graph_feature_add(reg->end_feature) < 0)
+		goto arc_destroy;
+
+	if (_arc)
+		*_arc = (rte_graph_feature_arc_t)arc_index;
+
+	feat_dbg("Feature arc %s[%p] created with max_features: %u and indexes: %u",
+		 arc->feature_arc_name, (void *)arc, arc->max_features, arc->max_indexes);
+
+	return 0;
+
+arc_destroy:
+	rte_graph_feature_arc_destroy(arc_index);
+feat_bitmask_free:
+	rte_free(arc->feature_bit_mask_by_index);
+mz_free:
+	rte_memzone_free(mz);
+arc_create_err:
+	return -1;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_add, 25.07);
+int
+rte_graph_feature_add(struct rte_graph_feature_register *freg)
+{
+	struct rte_graph_feature_node_list *after_finfo = NULL, *before_finfo = NULL;
+	struct rte_graph_feature_node_list *temp = NULL, *finfo = NULL;
+	char feature_name[3 * RTE_GRAPH_FEATURE_ARC_NAMELEN];
+	const char *runs_after = NULL, *runs_before = NULL;
+	struct rte_graph_feature_arc *arc = NULL;
+	uint32_t slot = UINT32_MAX, add_flag;
+	rte_graph_feature_arc_t _arc;
+	uint32_t num_features = 0;
+	const char *nodename = NULL;
+	rte_edge_t edge = -1;
+	int rc = 0;
+
+	if (feature_registration_validate(freg, __func__, __LINE__, 0, 1, true) < 0)
+		return -1;
+
+	/* arc is valid */
+	if (rte_graph_feature_arc_lookup_by_name(freg->arc_name, &_arc)) {
+		graph_err("%s_add: feature arc %s not found",
+			  freg->feature_name, freg->arc_name);
+		return -1;
+	}
+
+	if (feature_arc_sanity(_arc)) {
+		graph_err("invalid feature arc: 0x%x", _arc);
+		return -1;
+	}
+
+	arc = rte_graph_feature_arc_get(_arc);
+
+	if (arc->runtime_enabled_features) {
+		graph_err("adding features after enabling any one of them is not supported");
+		return -1;
+	}
+
+	/* When application calls rte_graph_feature_add() directly*/
+	if (freg->feature_node_id == RTE_NODE_ID_INVALID) {
+		graph_err("%s/%s: Invalid feature_node_id set for %s",
+			  freg->arc_name, freg->feature_name, __func__);
+		return -1;
+	}
+
+	if ((freg->runs_after != NULL) && (freg->runs_before != NULL) &&
+	    (freg->runs_after == freg->runs_before)) {
+		graph_err("runs_after and runs_before cannot be same '%s:%s]", freg->runs_after,
+			  freg->runs_before);
+		return -1;
+	}
+
+	num_features = rte_graph_feature_arc_num_features(_arc);
+	if (num_features) {
+		nodeinfo_lkup_by_index(arc, num_features - 1, &temp, 0);
+		/* Check if feature is not added after end_feature */
+		if ((freg->runs_after != NULL) &&
+		    (strncmp(freg->runs_after, temp->feature_name,
+			     RTE_GRAPH_FEATURE_ARC_NAMELEN) == 0)) {
+			graph_err("Feature %s cannot be added after end_feature %s",
+				  freg->feature_name, freg->runs_after);
+			return -1;
+		}
+	}
+
+	if (!nodeinfo_add_lookup(arc, freg->feature_name, &finfo, &slot)) {
+		graph_err("%s/%s feature already added", arc->feature_arc_name, freg->feature_name);
+		return -1;
+	}
+
+	if (slot >= arc->max_features) {
+		graph_err("%s: Max features %u added to feature arc",
+			  arc->feature_arc_name, slot);
+		return -1;
+	}
+
+	if (freg->feature_node_id == arc->start_node->id) {
+		graph_err("%s/%s: Feature node and start node are same %u",
+			  freg->arc_name, freg->feature_name, freg->feature_node_id);
+		return -1;
+	}
+
+	nodename = rte_node_id_to_name(freg->feature_node_id);
+
+	feat_dbg("%s: adding feature node: %s at feature index: %u", arc->feature_arc_name,
+		 nodename, slot);
+
+	if (connect_graph_nodes(arc->start_node->id, freg->feature_node_id, &edge,
+				arc->feature_arc_name)) {
+		graph_err("unable to connect %s -> %s", arc->start_node->name, nodename);
+		return -1;
+	}
+
+	snprintf(feature_name, sizeof(feature_name), "%s-%s-finfo",
+		 arc->feature_arc_name, freg->feature_name);
+
+	finfo = rte_malloc(feature_name, sizeof(*finfo), 0);
+	if (!finfo) {
+		graph_err("%s/%s: rte_malloc failed", arc->feature_arc_name, freg->feature_name);
+		return -1;
+	}
+
+	memset(finfo, 0, sizeof(*finfo));
+
+	rte_strscpy(finfo->feature_name, freg->feature_name, RTE_GRAPH_FEATURE_ARC_NAMELEN - 1);
+	finfo->feature_arc = (void *)arc;
+	finfo->feature_node_id = freg->feature_node_id;
+	finfo->feature_node_process_fn = freg->feature_process_fn;
+	finfo->edge_to_this_feature = RTE_EDGE_ID_INVALID;
+	finfo->edge_to_last_feature = RTE_EDGE_ID_INVALID;
+	finfo->notifier_cb = freg->notifier_cb;
+
+	runs_before = freg->runs_before;
+	runs_after = freg->runs_after;
+
+	/*
+	 * if no constraints given and provided feature is not the first feature,
+	 * explicitly set "runs_before" as end_feature.
+	 *
+	 * Handles the case:
+	 * arc_create(f1);
+	 * add(f2, NULL, NULL);
+	 */
+	if (!runs_after && !runs_before && num_features)
+		runs_before = rte_graph_feature_arc_feature_to_name(_arc, num_features - 1);
+
+	/* Check for before and after constraints */
+	if (runs_before) {
+		/* runs_before sanity */
+		if (nodeinfo_lkup_by_name(arc, runs_before, &before_finfo, NULL))
+			SET_ERR_JMP(EINVAL, finfo_free,
+				     "runs_before feature name: %s does not exist", runs_before);
+
+		if (!before_finfo)
+			SET_ERR_JMP(EINVAL, finfo_free,
+				     "runs_before %s does not exist", runs_before);
+
+		/*
+		 * Starting from 0 to runs_before, continue connecting edges
+		 */
+		add_flag = 1;
+		STAILQ_FOREACH(temp, &arc->all_features, next_feature) {
+			if (!add_flag)
+				/* Nodes after seeing "runs_before", finfo connects to temp*/
+				connect_graph_nodes(finfo->feature_node_id, temp->feature_node_id,
+						    NULL, arc->feature_arc_name);
+			/*
+			 * As soon as we see runs_before. stop adding edges
+			 */
+			if (!strncmp(temp->feature_name, runs_before, RTE_GRAPH_NAMESIZE)) {
+				if (!connect_graph_nodes(finfo->feature_node_id,
+							 temp->feature_node_id,
+							 &edge, arc->feature_arc_name))
+					add_flag = 0;
+			}
+
+			if (add_flag)
+				/* Nodes before seeing "run_before" are connected to finfo */
+				connect_graph_nodes(temp->feature_node_id, finfo->feature_node_id,
+						    NULL, arc->feature_arc_name);
+		}
+	}
+
+	if (runs_after) {
+		if (nodeinfo_lkup_by_name(arc, runs_after, &after_finfo, NULL))
+			SET_ERR_JMP(EINVAL, finfo_free,
+				     "Invalid after feature_name %s", runs_after);
+
+		if (!after_finfo)
+			SET_ERR_JMP(EINVAL, finfo_free,
+				     "runs_after %s does not exist", runs_after);
+
+		/* Starting from runs_after to end continue connecting edges */
+		add_flag = 0;
+		STAILQ_FOREACH(temp, &arc->all_features, next_feature) {
+			if (add_flag)
+				/* We have already seen runs_after now */
+				/* Add all features as next node to current feature*/
+				connect_graph_nodes(finfo->feature_node_id, temp->feature_node_id,
+						    NULL, arc->feature_arc_name);
+			else
+				/* Connect initial nodes to newly added node*/
+				connect_graph_nodes(temp->feature_node_id, finfo->feature_node_id,
+						    NULL, arc->feature_arc_name);
+
+			/* as soon as we see runs_after. start adding edges
+			 * from next iteration
+			 */
+			if (!strncmp(temp->feature_name, runs_after, RTE_GRAPH_NAMESIZE))
+				add_flag = 1;
+		}
+
+		/* add feature next to runs_after */
+		STAILQ_INSERT_AFTER(&arc->all_features, after_finfo, finfo, next_feature);
+	} else {
+		if (before_finfo) {
+			/* add finfo before "before_finfo" element in the list */
+			after_finfo = NULL;
+			STAILQ_FOREACH(temp, &arc->all_features, next_feature) {
+				if (before_finfo == temp) {
+					if (after_finfo)
+						STAILQ_INSERT_AFTER(&arc->all_features, after_finfo,
+								    finfo, next_feature);
+					else
+						STAILQ_INSERT_HEAD(&arc->all_features, finfo,
+								   next_feature);
+
+					/* override node process fn */
+					rc = node_override_process_func(finfo->feature_node_id,
+									freg->feature_process_fn);
+
+					if (rc < 0) {
+						graph_err("node_override_process_func failed for %s",
+							  freg->feature_name);
+						goto finfo_free;
+					}
+					return 0;
+				}
+				after_finfo = temp;
+			}
+		} else {
+			/* Very first feature just needs to be added to list */
+			STAILQ_INSERT_TAIL(&arc->all_features, finfo, next_feature);
+		}
+	}
+	/* override node_process_fn */
+	rc = node_override_process_func(finfo->feature_node_id, freg->feature_process_fn);
+	if (rc < 0) {
+		graph_err("node_override_process_func failed for %s", freg->feature_name);
+		goto finfo_free;
+	}
+
+	if (freg->feature_node)
+		feat_dbg("arc-%s: feature %s node %s process() overridden with %p",
+			  freg->arc_name, freg->feature_name, freg->feature_node->name,
+			  freg->feature_process_fn);
+	else
+		feat_dbg("arc-%s: feature %s nodeid %u process() overriding with %p",
+			  freg->arc_name, freg->feature_name,
+			  freg->feature_node_id, freg->feature_process_fn);
+
+	return 0;
+finfo_free:
+	rte_free(finfo);
+
+	return -1;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_lookup, 25.07);
+int
+rte_graph_feature_lookup(rte_graph_feature_arc_t _arc, const char *feature_name,
+			 rte_graph_feature_t *feat)
+{
+	struct rte_graph_feature_arc *arc = rte_graph_feature_arc_get(_arc);
+	struct rte_graph_feature_node_list *finfo = NULL;
+	uint32_t slot;
+
+	if (!arc)
+		return -1;
+
+	if (!nodeinfo_lkup_by_name(arc, feature_name, &finfo, &slot)) {
+		*feat = (rte_graph_feature_t) slot;
+		return 0;
+	}
+
+	return -1;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_enable, 25.07);
+int
+rte_graph_feature_enable(rte_graph_feature_arc_t _arc, uint32_t index,
+			 const char *feature_name, uint16_t app_cookie,
+			 struct rte_rcu_qsbr *qsbr)
+{
+	struct rte_graph_feature_arc *arc = rte_graph_feature_arc_get(_arc);
+	struct rte_graph_feature_node_list *finfo = NULL;
+	struct rte_graph_feature_data *gfd = NULL;
+	uint64_t bitmask;
+	uint32_t slot;
+
+	if (!arc) {
+		graph_err("Invalid feature arc: 0x%x", _arc);
+		return -1;
+	}
+
+	feat_dbg("%s: Enabling feature: %s for index: %u",
+		 arc->feature_arc_name, feature_name, index);
+
+	if ((!arc->runtime_enabled_features &&
+	    (prepare_feature_arc_before_first_enable(arc) < 0)))
+		return -1;
+
+	if (feature_enable_disable_validate(_arc, index, feature_name, 1 /* enable */, true))
+		return -1;
+
+	/** This should not fail as validate() has passed */
+	if (nodeinfo_lkup_by_name(arc, feature_name, &finfo, &slot))
+		RTE_VERIFY(0);
+
+	gfd = rte_graph_feature_data_get(arc, fdata_reserve(arc, slot, index));
+
+	/* Set current app_cookie */
+	rte_atomic_store_explicit(&gfd->app_cookie, app_cookie, rte_memory_order_relaxed);
+
+	/* Set bitmask in control path bitmask */
+	rte_bit_relaxed_set64(graph_uint_cast(slot), &arc->feature_bit_mask_by_index[index]);
+
+	refill_fastpath_data(arc, slot, index, 1 /* enable */);
+
+	/* On very first feature enable instance */
+	if (!finfo->ref_count) {
+		/* If first time feature getting enabled
+		 */
+		bitmask = rte_atomic_load_explicit(&arc->fp_feature_enable_bitmask,
+						   rte_memory_order_relaxed);
+
+		bitmask |= RTE_BIT64(slot);
+
+		rte_atomic_store_explicit(&arc->fp_feature_enable_bitmask,
+					  bitmask, rte_memory_order_relaxed);
+	}
+
+	/* Slow path updates */
+	arc->runtime_enabled_features++;
+
+	/* Increase feature node info reference count */
+	finfo->ref_count++;
+
+	/* Release extra fdata, if reserved before */
+	extra_fdata_release(arc, slot, index);
+
+	if (qsbr)
+		rte_rcu_qsbr_synchronize(qsbr, RTE_QSBR_THRID_INVALID);
+
+	if (finfo->notifier_cb)
+		finfo->notifier_cb(arc->feature_arc_name, finfo->feature_name,
+				   finfo->feature_node_id, index,
+				   true /* enable */, gfd->app_cookie);
+
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_disable, 25.07);
+int
+rte_graph_feature_disable(rte_graph_feature_arc_t _arc, uint32_t index, const char *feature_name,
+			  struct rte_rcu_qsbr *qsbr)
+{
+	struct rte_graph_feature_arc *arc = rte_graph_feature_arc_get(_arc);
+	struct rte_graph_feature_data *gfd = NULL, *extra_gfd = NULL;
+	struct rte_graph_feature_node_list *finfo = NULL;
+	rte_graph_feature_data_t extra_fdata;
+	uint32_t slot, last_end_feature;
+	uint64_t bitmask;
+
+	if (!arc) {
+		graph_err("Invalid feature arc: 0x%x", _arc);
+		return -1;
+	}
+	feat_dbg("%s: Disable feature: %s for index: %u",
+		 arc->feature_arc_name, feature_name, index);
+
+	if (feature_enable_disable_validate(_arc, index, feature_name, 0, true))
+		return -1;
+
+	if (nodeinfo_lkup_by_name(arc, feature_name, &finfo, &slot))
+		return -1;
+
+	last_end_feature = rte_fls_u64(arc->feature_bit_mask_by_index[index]);
+	if (last_end_feature != arc->num_added_features) {
+		graph_err("%s/%s: No end feature enabled",
+			  arc->feature_arc_name, feature_name);
+		return -1;
+	}
+
+	/* If feature is not last feature, unset in control plane bitmask */
+	last_end_feature = arc->num_added_features - 1;
+	if (slot != last_end_feature)
+		rte_bit_relaxed_clear64(graph_uint_cast(slot),
+					&arc->feature_bit_mask_by_index[index]);
+
+	/* we have allocated one extra feature data space. Get extra feature data
+	 * No need to reserve instead use fixed  extra data for an index
+	 */
+	extra_fdata = extra_fdata_reserve(arc, slot, index);
+	extra_gfd = rte_graph_feature_data_get(arc, extra_fdata);
+
+	gfd = rte_graph_feature_data_get(arc, fdata_reserve(arc, slot, index));
+
+	/*
+	 * Packets may have reached to feature node which is getting disabled.
+	 * We want to steer those packets to last feature node so that they can
+	 * exit arc
+	 * - First, reset next_edge of extra feature data to point to last_feature_node
+	 * - Secondly, reset next_feature_data of current feature getting disabled to extra
+	 *   feature data
+	 */
+	rte_atomic_store_explicit(&extra_gfd->next_edge, finfo->edge_to_last_feature,
+				  rte_memory_order_relaxed);
+	rte_atomic_store_explicit(&extra_gfd->next_feature_data, RTE_GRAPH_FEATURE_DATA_INVALID,
+				  rte_memory_order_relaxed);
+	rte_atomic_store_explicit(&gfd->next_feature_data, extra_fdata,
+				  rte_memory_order_relaxed);
+	rte_atomic_store_explicit(&gfd->next_edge, finfo->edge_to_last_feature,
+				  rte_memory_order_relaxed);
+
+	/* Now we can unwire fast path*/
+	refill_fastpath_data(arc, slot, index, 0 /* disable */);
+
+	finfo->ref_count--;
+
+	/* When last feature is disabled */
+	if (!finfo->ref_count) {
+		/* If no feature enabled, reset feature in u64 fast path bitmask */
+		bitmask = rte_atomic_load_explicit(&arc->fp_feature_enable_bitmask,
+						   rte_memory_order_relaxed);
+		bitmask &= ~(RTE_BIT64(slot));
+		rte_atomic_store_explicit(&arc->fp_feature_enable_bitmask, bitmask,
+					  rte_memory_order_relaxed);
+	}
+
+	if (qsbr)
+		rte_rcu_qsbr_synchronize(qsbr, RTE_QSBR_THRID_INVALID);
+
+	/* Call notifier cb with valid app_cookie */
+	if (finfo->notifier_cb)
+		finfo->notifier_cb(arc->feature_arc_name, finfo->feature_name,
+				   finfo->feature_node_id, index,
+				   false /* disable */, gfd->app_cookie);
+
+	/*
+	 * 1. Do not reset gfd for now as feature node might be in execution
+	 *
+	 * 2. We also don't call fdata_release() as that may return same
+	 * feature_data for other index for case like:
+	 *
+	 * feature_enable(arc, index-0, feature_name, cookie1);
+	 * feature_enable(arc, index-1, feature_name, cookie2);
+	 *
+	 * Second call can return same fdata which we avoided releasing here.
+	 * In order to make above case work, application has to mandatory use
+	 * RCU mechanism. For now fdata is not released until arc_destroy
+	 *
+	 * Only exception is
+	 * for(i=0; i< 100; i++) {
+	 *   feature_enable(arc, index-0, feature_name, cookie1);
+	 *   feature_disable(arc, index-0, feature_name, cookie1);
+	 * }
+	 * where RCU should be used but this is not valid use-case from control plane.
+	 * If it is valid use-case then provide RCU argument
+	 */
+
+	/* Reset app_cookie later after calling notifier_cb */
+	rte_atomic_store_explicit(&gfd->app_cookie, UINT16_MAX, rte_memory_order_relaxed);
+
+	arc->runtime_enabled_features--;
+
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_destroy, 25.07);
+int
+rte_graph_feature_arc_destroy(rte_graph_feature_arc_t _arc)
+{
+	struct rte_graph_feature_arc *arc = rte_graph_feature_arc_get(_arc);
+	rte_graph_feature_arc_main_t *dm = __rte_graph_feature_arc_main;
+	struct rte_graph_feature_node_list *node_info = NULL;
+	struct rte_graph_feature_data *fdptr = NULL;
+	rte_graph_feature_data_t fdata;
+	int iter;
+
+	if (!arc) {
+		graph_err("Invalid feature arc: 0x%x", _arc);
+		return -1;
+	}
+
+	while (!STAILQ_EMPTY(&arc->all_features)) {
+		node_info = STAILQ_FIRST(&arc->all_features);
+		STAILQ_REMOVE_HEAD(&arc->all_features, next_feature);
+		/* Notify application */
+		if (node_info->notifier_cb) {
+			for (iter = 0; iter < arc->max_indexes; iter++) {
+				/* If feature is not enabled on this index, skip */
+				if (!(arc->feature_bit_mask_by_index[iter] &
+				    RTE_BIT64(node_info->finfo_index)))
+					continue;
+
+				/* fdata_reserve would return already allocated
+				 * fdata for [finfo_index, iter]
+				 */
+				fdata = fdata_reserve(arc, node_info->finfo_index, iter);
+				if (fdata != RTE_GRAPH_FEATURE_DATA_INVALID) {
+					fdptr = rte_graph_feature_data_get(arc, fdata);
+					node_info->notifier_cb(arc->feature_arc_name,
+							       node_info->feature_name,
+							       node_info->feature_node_id,
+							       iter, false /* disable */,
+							       fdptr->app_cookie);
+				} else {
+					node_info->notifier_cb(arc->feature_arc_name,
+							       node_info->feature_name,
+							       node_info->feature_node_id,
+							       iter, false /* disable */,
+							       UINT16_MAX /* invalid cookie */);
+				}
+				/* fdata_release() is not used yet, use it for sake
+				 * of function unused warnings
+				 */
+				fdata = fdata_release(arc, node_info->finfo_index, iter);
+			}
+		}
+		rte_free(node_info);
+	}
+
+	dm->feature_arcs[arc->feature_arc_index] = GRAPH_FEATURE_ARC_PTR_INITIALIZER;
+
+	rte_free(arc->feature_data_by_index);
+
+	rte_free(arc->feature_bit_mask_by_index);
+
+	rte_memzone_free(rte_memzone_lookup(arc->feature_arc_name));
+
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_cleanup, 25.07);
+int
+rte_graph_feature_arc_cleanup(void)
+{
+	rte_graph_feature_arc_main_t *dm = __rte_graph_feature_arc_main;
+	struct rte_graph_feature_arc *arc = NULL;
+	uint32_t iter;
+
+	if (!__rte_graph_feature_arc_main)
+		return -1;
+
+	for (iter = 0; iter < dm->max_feature_arcs; iter++) {
+		arc = rte_graph_feature_arc_get(iter);
+
+		if (!arc)
+			continue;
+
+		rte_graph_feature_arc_destroy(arc->feature_arc_index);
+	}
+	rte_memzone_free(rte_memzone_lookup(FEATURE_ARC_MEMZONE_NAME));
+	__rte_graph_feature_arc_main = NULL;
+
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_lookup_by_name, 25.07);
+int
+rte_graph_feature_arc_lookup_by_name(const char *arc_name, rte_graph_feature_arc_t *_arc)
+{
+	struct rte_graph_feature_arc *arc = NULL;
+	const struct rte_memzone *mz = NULL;
+	rte_graph_feature_arc_main_t *dm;
+	uint32_t iter;
+
+	if (_arc)
+		*_arc = RTE_GRAPH_FEATURE_ARC_INITIALIZER;
+
+	if (!__rte_graph_feature_arc_main) {
+		mz = rte_memzone_lookup(FEATURE_ARC_MEMZONE_NAME);
+		if (mz)
+			__rte_graph_feature_arc_main = mz->addr;
+		else
+			return -1;
+	}
+
+	dm = __rte_graph_feature_arc_main;
+
+	for (iter = 0; iter < dm->max_feature_arcs; iter++) {
+		arc = rte_graph_feature_arc_get(iter);
+		if (!arc)
+			continue;
+
+		if ((strstr(arc->feature_arc_name, arc_name)) &&
+		    (strlen(arc->feature_arc_name) == strlen(arc_name))) {
+			if (_arc)
+				*_arc = arc->feature_arc_index;
+			return 0;
+		}
+	}
+
+	return -1;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_num_enabled_features, 25.07);
+uint32_t
+rte_graph_feature_arc_num_enabled_features(rte_graph_feature_arc_t _arc)
+{
+	struct rte_graph_feature_arc *arc = rte_graph_feature_arc_get(_arc);
+
+	if (!arc) {
+		graph_err("Invalid feature arc: 0x%x", _arc);
+		return 0;
+	}
+
+	return arc->runtime_enabled_features;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_num_features, 25.07);
+uint32_t
+rte_graph_feature_arc_num_features(rte_graph_feature_arc_t _arc)
+{
+	struct rte_graph_feature_arc *arc = rte_graph_feature_arc_get(_arc);
+	struct rte_graph_feature_node_list *finfo = NULL;
+	uint32_t count = 0;
+
+	if (!arc) {
+		graph_err("Invalid feature arc: 0x%x", _arc);
+		return 0;
+	}
+
+	STAILQ_FOREACH(finfo, &arc->all_features, next_feature)
+		count++;
+
+	return count;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_feature_to_name, 25.07);
+char *
+rte_graph_feature_arc_feature_to_name(rte_graph_feature_arc_t _arc, rte_graph_feature_t feat)
+{
+	struct rte_graph_feature_arc *arc = rte_graph_feature_arc_get(_arc);
+	struct rte_graph_feature_node_list *finfo = NULL;
+	uint32_t slot = feat;
+
+	if (!arc)
+		return NULL;
+
+	if (feat >= rte_graph_feature_arc_num_features(_arc)) {
+		graph_err("%s: feature %u does not exist", arc->feature_arc_name, feat);
+		return NULL;
+	}
+	if (!nodeinfo_lkup_by_index(arc, slot, &finfo, 0/* ignore sanity*/))
+		return finfo->feature_name;
+
+	return NULL;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_feature_to_node, 25.07);
+int
+rte_graph_feature_arc_feature_to_node(rte_graph_feature_arc_t _arc, rte_graph_feature_t feat,
+				      rte_node_t *node)
+{
+	struct rte_graph_feature_arc *arc = rte_graph_feature_arc_get(_arc);
+	struct rte_graph_feature_node_list *finfo = NULL;
+	uint32_t slot = feat;
+
+	if (!arc)
+		return -1;
+
+	if (node)
+		*node = RTE_NODE_ID_INVALID;
+
+	if (feat >= rte_graph_feature_arc_num_features(_arc)) {
+		graph_err("%s: feature %u does not exist", arc->feature_arc_name, feat);
+		return -1;
+	}
+	if (!nodeinfo_lkup_by_index(arc, slot, &finfo, 0/* ignore sanity*/)) {
+		if (node)
+			*node = finfo->feature_node_id;
+		return 0;
+	}
+	return -1;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_graph_feature_arc_register, 25.07);
+void __rte_graph_feature_arc_register(struct rte_graph_feature_arc_register *reg,
+				      const char *caller_name, int lineno)
+{
+	RTE_SET_USED(caller_name);
+	RTE_SET_USED(lineno);
+	/* Do not validate arc registration here but as part of rte_graph_feature_arc_init() */
+	STAILQ_INSERT_TAIL(&feature_arc_list, reg, next_arc);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_graph_feature_register, 25.07);
+void __rte_graph_feature_register(struct rte_graph_feature_register *reg,
+				  const char *caller_name, int lineno)
+{
+	if (feature_registration_validate(reg, caller_name, lineno, 0, 0, true) < 0)
+		return;
+
+	/* Add to the feature_list*/
+	STAILQ_INSERT_TAIL(&feature_list, reg, next_feature);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_names_get, 25.07);
+uint32_t
+rte_graph_feature_arc_names_get(char *arc_names[])
+{
+	rte_graph_feature_arc_main_t *dm = __rte_graph_feature_arc_main;
+	struct rte_graph_feature_arc *arc = NULL;
+	uint32_t count, num_arcs;
+
+	if (!__rte_graph_feature_arc_main)
+		return 0;
+
+	for (count = 0, num_arcs = 0; count < dm->max_feature_arcs; count++)
+		if (dm->feature_arcs[count] != GRAPH_FEATURE_ARC_PTR_INITIALIZER)
+			num_arcs++;
+
+	if (!num_arcs)
+		return 0;
+
+	if (!arc_names)
+		return sizeof(char *) * num_arcs;
+
+	for (count = 0, num_arcs = 0; count < dm->max_feature_arcs; count++) {
+		if (dm->feature_arcs[count] != GRAPH_FEATURE_ARC_PTR_INITIALIZER) {
+			arc = rte_graph_feature_arc_get(count);
+			arc_names[num_arcs] = arc->feature_arc_name;
+			num_arcs++;
+		}
+	}
+	return num_arcs;
+}
diff --git a/lib/graph/graph_private.h b/lib/graph/graph_private.h
index 579546e658..5728933a88 100644
--- a/lib/graph/graph_private.h
+++ b/lib/graph/graph_private.h
@@ -24,6 +24,10 @@ extern int rte_graph_logtype;
 	RTE_LOG_LINE_PREFIX(level, GRAPH,                                      \
 		"%s():%u ", __func__ RTE_LOG_COMMA __LINE__, __VA_ARGS__)

+#define GRAPH_LOG2(level, _fname, _linenum, ...)                               \
+	RTE_LOG_LINE_PREFIX(level, GRAPH,                                      \
+		"%s():%u ", _fname RTE_LOG_COMMA _linenum, __VA_ARGS__)
+
 #define graph_err(...) GRAPH_LOG(ERR, __VA_ARGS__)
 #define graph_warn(...) GRAPH_LOG(WARNING, __VA_ARGS__)
 #define graph_info(...) GRAPH_LOG(INFO, __VA_ARGS__)
diff --git a/lib/graph/meson.build b/lib/graph/meson.build
index 0cb15442ab..5d137d326e 100644
--- a/lib/graph/meson.build
+++ b/lib/graph/meson.build
@@ -15,14 +15,16 @@ sources = files(
         'graph_stats.c',
         'graph_populate.c',
         'graph_pcap.c',
+        'graph_feature_arc.c',
         'rte_graph_worker.c',
         'rte_graph_model_mcore_dispatch.c',
 )
 headers = files('rte_graph.h', 'rte_graph_worker.h')
+headers += files('rte_graph_feature_arc.h', 'rte_graph_feature_arc_worker.h')
 indirect_headers += files(
         'rte_graph_model_mcore_dispatch.h',
         'rte_graph_model_rtc.h',
         'rte_graph_worker_common.h',
 )

-deps += ['eal', 'pcapng', 'mempool', 'ring']
+deps += ['eal', 'pcapng', 'mempool', 'ring', 'rcu']
diff --git a/lib/graph/rte_graph_feature_arc.h b/lib/graph/rte_graph_feature_arc.h
new file mode 100644
index 0000000000..4d50df3174
--- /dev/null
+++ b/lib/graph/rte_graph_feature_arc.h
@@ -0,0 +1,628 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2025 Marvell International Ltd.
+ */
+
+#ifndef _RTE_GRAPH_FEATURE_ARC_H_
+#define _RTE_GRAPH_FEATURE_ARC_H_
+
+#include <assert.h>
+#include <errno.h>
+#include <signal.h>
+#include <stddef.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <rte_common.h>
+#include <rte_compat.h>
+#include <rte_debug.h>
+#include <rte_graph.h>
+#include <rte_rcu_qsbr.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/**
+ * @file
+ *
+ * rte_graph_feature_arc.h
+ *
+ * Define APIs and structures/variables with respect to feature arc
+ *
+ * - Feature arc(s)
+ * - Feature(s)
+ *
+ * In a typical network stack, often a protocol must be first enabled in
+ * control plane before any packet is steered for its processing in the
+ * dataplane. For eg: incoming IPv4 packets are routed only after a valid IPv4
+ * address is assigned to the received interface. In other words, often packets
+ * received on an interface need to be steered to protocol not based on the
+ * packet content but based on whether the protocol is configured on the
+ * interface or not.
+ *
+ * Protocols can be enabled/disabled multiple times at runtime in the control
+ * plane. Protocols enabled on one interface may not be enabled on another
+ * interface.
+ *
+ * When more than one protocols are present at a networking layer (say IPv4,
+ * IPtables, IPsec etc), it becomes imperative to steer packets (in dataplane)
+ * across each protocol processing in a defined sequential order. In ingress
+ * direction, stack decides to perform IPsec decryption first before IP
+ * validation while in egress direction IPsec encryption is performed after IP
+ * forwarding. In the case of IPtables, users can enable rules in any
+ * protocol order i.e. pre-routing or post-routing etc. This implies that
+ * protocols are configured differently at each networking layer and in each
+ * traffic direction.
+ *
+ * A feature arc represents an ordered list of features/protocols nodes at the
+ * given networking layer and in a given direction. It provides a high level
+ * abstraction to enable/disable features on an index at runtime and provide a
+ * mechanism to steer packets across these feature nodes in a generic manner.
+ * Here index corresponds to either interface index, route index, flow index or
+ * classification index etc. as it is deemed suitable to configure protocols at
+ * the networking layer. Some typical examples of protocols which are
+ * configured based on
+ *
+ * - Interface Index (like IPv4 VRF, Port mirroring, Port based IPsec etc)
+ * - Routes Index (like Route based IPsec etc)
+ * - Flow index (like SDN)
+ * - Classification Index (like ACL based protocol steering)
+ *
+ * Feature arc also provides a way to steer packets from in-built DPDK *feature
+ * nodes* to out-of-tree *feature nodes* and vice-versa without any code
+ * changes required in DPDK in-built node's fast path functions. This way it
+ * allows application to override default packet path defined by in-built DPDK
+ * nodes.
+ *
+ * Features enabled on one index may not be enabled on another index hence
+ * packets received on an interface "X" should be treated independently from
+ * packets received on interface "Y".
+ *
+ * A given feature might consume packet (if it's configured to consume) or may
+ * forward it to next enabled feature. For instance, "IPsec input" feature may
+ * consume/drop all packets with "Protect" policy action while all packets with
+ * policy action as "Bypass" may be forwarded to next enabled feature (with in
+ * same feature arc)
+ *
+ * A feature arc in a graph is represented via *start_node* and *end_node*.
+ * Feature nodes are added between start_node and end_node. Packets enter
+ * feature arc traversal via start_node while they exits from end_node. Packets
+ * steering from start_node to feature nodes are controlled in control plane
+ * via rte_graph_feature_enable()/rte_graph_feature_disable().
+ *
+ * This library facilitates rte graph based applications to implement stack
+ * functionaloties described above by providing "edge" to the next enabled
+ * feature node in fast path
+ *
+ * In order to use feature-arc APIs, applications needs to do following in
+ * control plane:
+ * - Create feature arc object using RTE_GRAPH_FEATURE_ARC_REGISTER()
+ * - New feature nodes (In-built/Out-of-tree) can be added to an arc via
+ *   RTE_GRAPH_FEATURE_REGISTER(). RTE_GRAPH_FEATURE_REGISTER() has
+ *   "runs_after" and "runs_before" fields to specify protocol ordering
+ *   constraints.
+ * - Before calling rte_graph_create(), rte_graph_feature_arc_init() API must
+ *   be called. If rte_graph_feature_arc_init() is not called by application,
+ *   feature arc library has no affect.
+ * - Features can be enabled/disabled on any index at runtime via
+ *   rte_graph_feature_enable()/rte_graph_feature_disable()
+ * - Feature arc can be destroyed via rte_graph_feature_arc_destroy()
+ *
+ * If a given feature likes to control number of indexes (which is higher than
+ * RTE_GRAPH_FEATURE_ARC_REGISTER::max_indexes) it can do so by using
+ * RTE_GRAPH_FEATURE_REGISTER():override_index_cb(). As part of
+ * rte_graph_feature_arc_init(), all feature's override_index_cb(), if set, are
+ * called and with maximum value returned by any of the feature is used for
+ * rte_graph_feature_arc_create()
+ *
+ * Before enabling a feature, control plane might allocate certain resources
+ * (like VRF table for IP lookup or IPsec SA for inbound policy etc). A
+ * reference of allocated resource can be passed from control plane to
+ * dataplane via *app_cookie* argument in @ref rte_graph_feature_enable(). A
+ * corresponding dataplane API @ref rte_graph_feature_data_app_cookie_get() can
+ * be used to retrieve same cookie in fast path.
+ *
+ * When a feature is disabled, resources allocated during feature enable can be
+ * safely released via registering a callback in
+ * RTE_GRAPH_FEATURE_REGISTER::notifier_cb(). See fast path synchronization
+ * section below for more details.
+ *
+ * While *app_cookie* can be known corresponding to current feature node via
+ * @ref rte_graph_feature_data_app_cookie_get(), however if current feature
+ * node is not consuming packet it might want to send it to next enabled
+ * feature using, it can do if current feature node is a:
+ * - start_node (via @ref rte_graph_feature_data_first_feature_get())
+ * - feature nodes added between start_node and end_node (via @ref
+ *   rte_graph_feature_data_next_feature_get())
+ * - end node (must not call any feature arc steering APIs) as from this node
+ *   packet exits feature arc
+ *
+ * Above APIs deals with fast path object: feature_data(struct
+ * rte_graph_feature_data), which is unique for every index per feature with in
+ * a feature arc. It holds three data fields: next node edge, next enabled
+ * feature data and app_cookie.
+ *
+ * rte_mbuf carries [feature_data] into feature arc specific mbuf dynamic
+ * field
+ *
+ * Fast path synchronization
+ * -------------------------
+ * Any feature enable/disable in control plane does not require stopping of
+ * worker cores. rte_graph_feature_enable()/rte_graph_feature_disable() APIs
+ * are almost thread-safe avoiding any RCU usage. Only condition when race
+ * condition could occur is when application is trying to enable/disable
+ * feature very fast for [feature, index] combination. In that case,
+ * application should use rte_graph_feature_enable()/disable() APIs with RCU
+ * argument
+ *
+ * RCU synchronization may also be required when application needs to free
+ * resources (using RTE_GRAPH_FEATURE_REGISTER:notifier_cb()) which it may have
+ * allocated during feature enable. Resources can be freed only when no worker
+ * core is not acting on it.
+ *
+ * If RCU argument to rte_graph_feature_enable()/disable() is non-NULL:
+ *  - rte_rcu_qsbr_synchronize(rte_rcu_qsbr *) to synchronize all worker cores
+ *  - Calls RTE_GRAPH_FEATURE_REGISTER()->notifier_cb((), if set, and helps
+ *  application to safely release resources associated with [feature, index]
+ *
+ * It is application responsibility to pass valid RCU argument to APIs
+ *
+ * Constraints
+ * -----------
+ *  - Not more than 63 features can be added to a feature arc. There is no
+ *  limit to number of feature arcs i.e. number of
+ *  RTE_GRAPH_FEATURE_ARC_REGISTER()
+ *  - There is no limit to number of indexes (RTE_GRAPH_FEATURE_ARC_REGISTER():
+ *  max_indexes). Each feature can override number of indexes via override_index_cb()
+ *  - A feature node cannot be part of more than one arc due to
+ *  performance reason.
+ */
+
+/** Length of feature arc name */
+#define RTE_GRAPH_FEATURE_ARC_NAMELEN RTE_NODE_NAMESIZE
+
+/** Initializer values for ARC, Feature, Feature data */
+#define RTE_GRAPH_FEATURE_ARC_INITIALIZER ((rte_graph_feature_arc_t)UINT16_MAX)
+#define RTE_GRAPH_FEATURE_DATA_INVALID ((rte_graph_feature_data_t)UINT32_MAX)
+#define RTE_GRAPH_FEATURE_INVALID  ((rte_graph_feature_t)UINT8_MAX)
+
+/** rte_graph feature arc object */
+typedef uint16_t rte_graph_feature_arc_t;
+
+/** rte_graph feature object */
+typedef uint8_t rte_graph_feature_t;
+
+/** rte_graph feature data object */
+typedef uint32_t rte_graph_feature_data_t;
+
+/** feature notifier callback called when feature is enabled/disabled */
+typedef void (*rte_graph_feature_change_notifier_cb_t)(const char *arc_name,
+						       const char *feature_name,
+						       rte_node_t feature_node_id,
+						       uint32_t index,
+						       bool enable_disable,
+						       uint16_t app_cookie);
+
+/** cb for overriding arc->max_indexes via RTE_GRAPH_FEATURE_REGISTER() */
+typedef uint16_t (*rte_graph_feature_override_index_cb_t)(void);
+
+/**
+ *  Feature registration structure provided to
+ *  RTE_GRAPH_FEATURE_REGISTER()
+ */
+struct rte_graph_feature_register {
+	STAILQ_ENTRY(rte_graph_feature_register) next_feature;
+
+	/** Name of the arc which is registered either via
+	 * RTE_GRAPH_FEATURE_ARC_REGISTER() or via
+	 * rte_graph_feature_arc_create()
+	 */
+	const char *arc_name;
+
+	/* Name of the feature */
+	const char *feature_name;
+
+	/**
+	 * Node id of feature_node.
+	 *
+	 * Setting this field can be skipped if registering feature via
+	 * RTE_GRAPH_FEATURE_REGISTER()
+	 */
+	rte_node_t feature_node_id;
+
+	/**
+	 * Feature node process() function calling feature fast path APIs.
+	 *
+	 * If application calls rte_graph_feature_arc_init(), node->process()
+	 * provided in RTE_NODE_REGISTER() is overwritten by this
+	 * function.
+	 */
+	rte_node_process_t feature_process_fn;
+
+	/*
+	 * Pointer to Feature node registration
+	 *
+	 * Used when features are registered via
+	 * RTE_GRAPH_FEATURE_REGISTER().
+	 */
+	struct rte_node_register *feature_node;
+
+	/** Feature ordering constraints
+	 * runs_after: Name of the feature which must run before "this feature"
+	 * runs_before: Name of the feature which must run after "this feature"
+	 */
+	const char *runs_after;
+	const char *runs_before;
+
+	/*
+	 * Allow each feature registration to override arc->max_indexes
+	 *
+	 * If set, struct rte_graph_feature_arc_register::max_indexes is
+	 * calculated as follows (before calling rte_graph_feature_arc_create())
+	 *
+	 * max_indexes = rte_graph_feature_arc_register:max_indexes
+	 * FOR_EACH_FEATURE_REGISTER(arc, feat) {
+	 *   rte_graph_feature_arc_register:max_indexes = max(feat->override_index_cb(),
+	 *                                                    max_indexes)
+	 */
+	rte_graph_feature_override_index_cb_t override_index_cb;
+
+	/**
+	 * Callback for notifying any change in feature enable/disable state
+	 */
+	rte_graph_feature_change_notifier_cb_t notifier_cb;
+};
+
+/** Feature arc registration structure */
+struct rte_graph_feature_arc_register {
+	STAILQ_ENTRY(rte_graph_feature_arc_register) next_arc;
+
+	/** Name of the feature arc */
+	const char *arc_name;
+
+	/**
+	 * Maximum number of features supported in this feature arc.
+	 *
+	 * This field can be skipped for feature arc registration via
+	 * RTE_GRAPH_FEATURE_ARC_REGISTER().
+	 *
+	 * API internally sets this field by calculating number of
+	 * RTE_GRAPH_FEATURE_REGISTER() for every arc registration via
+	 * RTE_GRAPH_FEATURE_ARC_REGISTER()
+	 */
+	uint16_t max_features;
+
+	/**
+	 * Maximum number of indexes supported in this feature arc
+	 * Memory is allocated based on this field
+	 */
+	uint16_t max_indexes;
+
+	/** Start node of this arc */
+	struct rte_node_register *start_node;
+
+	/**
+	 * Feature arc specific process() function for Start node.
+	 * If application calls rte_graph_feature_arc_init(),
+	 * start_node->process() is replaced by this function
+	 */
+	rte_node_process_t start_node_feature_process_fn;
+
+	/** End feature node registration */
+	struct rte_graph_feature_register *end_feature;
+};
+
+/** constructor to register feature to an arc */
+#define RTE_GRAPH_FEATURE_REGISTER(reg)                                                 \
+	RTE_INIT(__rte_graph_feature_register_##reg)                                    \
+	{                                                                               \
+		__rte_graph_feature_register(&reg, __func__, __LINE__);                 \
+	}
+
+/** constructor to register a feature arc */
+#define RTE_GRAPH_FEATURE_ARC_REGISTER(reg)                                             \
+	RTE_INIT(__rte_graph_feature_arc_register_##reg)                                \
+	{                                                                               \
+		__rte_graph_feature_arc_register(&reg, __func__, __LINE__);             \
+	}
+/**
+ * Initialize feature arc subsystem
+ *
+ * This API
+ * - Initializes feature arc module and alloc associated memory
+ * - creates feature arc for every RTE_GRAPH_FEATURE_ARC_REGISTER()
+ * - Add feature node to a feature arc for every RTE_GRAPH_FEATURE_REGISTER()
+ * - Replaces all RTE_NODE_REGISTER()->process() functions for
+ *   - Every start_node/end_node provided in arc registration
+ *   - Every feature node provided in feature registration
+ *
+ * @param num_feature_arcs
+ *  Number of feature arcs that application wants to create by explicitly using
+ *  "rte_graph_feature_arc_create()" API.
+ *
+ *  Number of RTE_GRAPH_FEATURE_ARC_REGISTER() should be excluded from this
+ *  count as API internally calculates number of
+ *  RTE_GRAPH_FEATURE_ARC_REGISTER().
+ *
+ *  So,
+ *  total number of supported arcs = num_feature_arcs +
+ *                                   NUMBER_OF(RTE_GRAPH_FEATURE_ARC_REGISTER())
+ *
+ *  @return
+ *   0: Success
+ *   <0: Failure
+ *
+ *  rte_graph_feature_arc_init(0) is valid call which will accommodates
+ *  constructor based arc registration
+ */
+__rte_experimental
+int rte_graph_feature_arc_init(uint16_t num_feature_arcs);
+
+/**
+ * Create a feature arc.
+ *
+ * This API can be skipped if RTE_GRAPH_FEATURE_ARC_REGISTER() is used
+ *
+ * @param reg
+ *   Pointer to struct rte_graph_feature_arc_register
+ * @param[out] _arc
+ *  Feature arc object
+ *
+ * @return
+ *  0: Success
+ * <0: Failure
+ */
+__rte_experimental
+int rte_graph_feature_arc_create(struct rte_graph_feature_arc_register *reg,
+				 rte_graph_feature_arc_t *_arc);
+
+/**
+ * Get feature arc object with name
+ *
+ * @param arc_name
+ *   Feature arc name provided to successful @ref rte_graph_feature_arc_create
+ * @param[out] _arc
+ *   Feature arc object returned. Valid only when API returns SUCCESS
+ *
+ * @return
+ *  0: Success
+ * <0: Failure.
+ */
+__rte_experimental
+int rte_graph_feature_arc_lookup_by_name(const char *arc_name, rte_graph_feature_arc_t *_arc);
+
+/**
+ * Add a feature to already created feature arc.
+ *
+ * This API is not required in case RTE_GRAPH_FEATURE_REGISTER() is used
+ *
+ * @param feat_reg
+ * Pointer to struct rte_graph_feature_register
+ *
+ * <I> Must be called before rte_graph_create() </I>
+ * <I> rte_graph_feature_add() is not allowed after call to
+ * rte_graph_feature_enable() so all features must be added before they can be
+ * enabled </I>
+ * <I> When called by application, then feature_node_id should be appropriately set as
+ *     freg->feature_node_id = freg->feature_node->id;
+ * </I>
+ *
+ * @return
+ *  0: Success
+ * <0: Failure
+ */
+__rte_experimental
+int rte_graph_feature_add(struct rte_graph_feature_register *feat_reg);
+
+/**
+ * Enable feature within a feature arc
+ *
+ * Must be called after @b rte_graph_create().
+ *
+ * @param _arc
+ *   Feature arc object returned by @ref rte_graph_feature_arc_create or @ref
+ *   rte_graph_feature_arc_lookup_by_name
+ * @param index
+ *   Application specific index. Can be corresponding to interface_id/port_id etc
+ * @param feature_name
+ *   Name of the node which is already added via @ref rte_graph_feature_add
+ * @param app_cookie
+ *   Application specific data which is retrieved in fast path
+ * @param qsbr
+ *   RCU QSBR object.  After enabling feature, API calls
+ *   rte_rcu_qsbr_synchronize() followed by call to struct
+ *   rte_graph_feature_register::notifier_cb(), if it is set, to notify feature
+ *   caller This object can be passed NULL as well if no RCU synchronization is
+ *   required
+ *
+ * @return
+ *  0: Success
+ * <0: Failure
+ */
+__rte_experimental
+int rte_graph_feature_enable(rte_graph_feature_arc_t _arc, uint32_t index, const
+			     char *feature_name, uint16_t app_cookie,
+			     struct rte_rcu_qsbr *qsbr);
+
+/**
+ * Disable already enabled feature within a feature arc
+ *
+ * Must be called after @b rte_graph_create(). API is *NOT* Thread-safe
+ *
+ * @param _arc
+ *   Feature arc object returned by @ref rte_graph_feature_arc_create or @ref
+ *   rte_graph_feature_arc_lookup_by_name
+ * @param index
+ *   Application specific index. Can be corresponding to interface_id/port_id etc
+ * @param feature_name
+ *   Name of the node which is already added via @ref rte_graph_feature_add
+ * @param qsbr
+ *   RCU QSBR object.  After disabling feature, API calls
+ *   rte_rcu_qsbr_synchronize() followed by call to struct
+ *   RTE_GRAPH_FEATURE_ARC_REGISTER::notifier_cb(), if it is set, to notify feature
+ *   caller. This object can be passed NULL as well if no RCU synchronization is
+ *   required
+ *
+ * @return
+ *  0: Success
+ * <0: Failure
+ */
+__rte_experimental
+int rte_graph_feature_disable(rte_graph_feature_arc_t _arc, uint32_t index,
+			      const char *feature_name, struct rte_rcu_qsbr *qsbr);
+
+/**
+ * Get rte_graph_feature_t object from feature name
+ *
+ * @param arc
+ *   Feature arc object returned by @ref rte_graph_feature_arc_create or @ref
+ *   rte_graph_feature_arc_lookup_by_name
+ * @param feature_name
+ *   Feature name provided to @ref rte_graph_feature_add
+ * @param[out] feature
+ *   Feature object
+ *
+ * @return
+ *  0: Success
+ * <0: Failure
+ */
+__rte_experimental
+int rte_graph_feature_lookup(rte_graph_feature_arc_t arc, const char *feature_name,
+			     rte_graph_feature_t *feature);
+
+/**
+ * Delete feature_arc object
+ *
+ * @param _arc
+ *   Feature arc object returned by @ref rte_graph_feature_arc_create or @ref
+ *   rte_graph_feature_arc_lookup_by_name
+ *
+ * @return
+ *  0: Success
+ * <0: Failure
+ */
+__rte_experimental
+int rte_graph_feature_arc_destroy(rte_graph_feature_arc_t _arc);
+
+/**
+ * Cleanup all feature arcs
+ *
+ * @return
+ *  0: Success
+ * <0: Failure
+ */
+__rte_experimental
+int rte_graph_feature_arc_cleanup(void);
+
+/**
+ * Slow path API to know how many features are added (NOT enabled) within a
+ * feature arc
+ *
+ * @param _arc
+ *  Feature arc object
+ *
+ * @return: Number of added features to arc
+ */
+__rte_experimental
+uint32_t rte_graph_feature_arc_num_features(rte_graph_feature_arc_t _arc);
+
+/**
+ * Slow path API to know how many features are currently enabled within a
+ * feature arc across all indexes. If a single feature is enabled on all interfaces,
+ * this API would return "number_of_interfaces" as count (but not "1")
+ *
+ * @param _arc
+ *  Feature arc object
+ *
+ * @return: Number of enabled features across all indexes
+ */
+__rte_experimental
+uint32_t rte_graph_feature_arc_num_enabled_features(rte_graph_feature_arc_t _arc);
+
+/**
+ * Slow path API to get feature node name from rte_graph_feature_t object
+ *
+ * @param _arc
+ *   Feature arc object
+ * @param feature
+ *   Feature object
+ *
+ * @return: Name of the feature node
+ */
+__rte_experimental
+char *rte_graph_feature_arc_feature_to_name(rte_graph_feature_arc_t _arc,
+					    rte_graph_feature_t feature);
+
+/**
+ * Slow path API to get corresponding rte_node_t from
+ * rte_graph_feature_t
+ *
+ * @param _arc
+ *   Feature arc object
+ * @param feature
+ *   Feature object
+ * @param[out] node
+ *   rte_node_t of feature node, Valid only when API returns SUCCESS
+ *
+ * @return: 0 on success, < 0 on failure
+ */
+__rte_experimental
+int
+rte_graph_feature_arc_feature_to_node(rte_graph_feature_arc_t _arc,
+				      rte_graph_feature_t feature,
+				      rte_node_t *node);
+
+/**
+ * Slow path API to dump valid feature arc names
+ *
+ *  @param[out] arc_names
+ *   Buffer to copy the arc names. The NULL value is allowed in that case,
+ * the function returns the size of the array that needs to be allocated.
+ *
+ * @return
+ *   When next_nodes == NULL, it returns the size of the array else
+ *  number of item copied.
+ */
+__rte_experimental
+uint32_t
+rte_graph_feature_arc_names_get(char *arc_names[]);
+
+/**
+ * @internal
+ *
+ * function declaration for registering arc
+ *
+ * @param reg
+ *      Pointer to struct rte_graph_feature_arc_register
+ *  @param caller_name
+ *      Name of the function which is calling this API
+ *  @param lineno
+ *      Line number of the function which is calling this API
+ */
+__rte_experimental
+void __rte_graph_feature_arc_register(struct rte_graph_feature_arc_register *reg,
+				      const char *caller_name, int lineno);
+
+/**
+ * @internal
+ *
+ * function declaration for registering feature
+ *
+ * @param reg
+ *      Pointer to struct rte_graph_feature_register
+ * @param caller_name
+ *      Name of the function which is calling this API
+ * @param lineno
+ *      Line number of the function which is calling this API
+ */
+__rte_experimental
+void __rte_graph_feature_register(struct rte_graph_feature_register *reg,
+				  const char *caller_name, int lineno);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/lib/graph/rte_graph_feature_arc_worker.h b/lib/graph/rte_graph_feature_arc_worker.h
new file mode 100644
index 0000000000..57aeaff01a
--- /dev/null
+++ b/lib/graph/rte_graph_feature_arc_worker.h
@@ -0,0 +1,607 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2025 Marvell International Ltd.
+ */
+
+#ifndef _RTE_GRAPH_FEATURE_ARC_WORKER_H_
+#define _RTE_GRAPH_FEATURE_ARC_WORKER_H_
+
+#include <stddef.h>
+#include <rte_graph_feature_arc.h>
+#include <rte_bitops.h>
+#include <rte_mbuf.h>
+#include <rte_mbuf_dyn.h>
+
+/**
+ * @file
+ *
+ * rte_graph_feature_arc_worker.h
+ *
+ * Defines fast path structure for feature arc
+ */
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/**
+ * @internal
+ *
+ * Slow path feature node info list
+ */
+struct rte_graph_feature_node_list {
+	/** Next feature */
+	STAILQ_ENTRY(rte_graph_feature_node_list) next_feature;
+
+	char feature_name[RTE_GRAPH_FEATURE_ARC_NAMELEN];
+
+	/** node id representing feature */
+	rte_node_t feature_node_id;
+
+	/** How many indexes/interfaces using this feature */
+	int32_t ref_count;
+
+	/**
+	 * feature arc process function overrides to feature node's original
+	 * process function
+	 */
+	rte_node_process_t feature_node_process_fn;
+
+	/** Callback for freeing application resources when */
+	rte_graph_feature_change_notifier_cb_t notifier_cb;
+
+	/* finfo_index in list. same as rte_graph_feature_t */
+	uint32_t finfo_index;
+
+	/** Back pointer to feature arc */
+	void *feature_arc;
+
+	/** rte_edge_t to this feature node from feature_arc->start_node */
+	rte_edge_t edge_to_this_feature;
+
+	/* rte_edge_t from this feature node to last feature node */
+	rte_edge_t edge_to_last_feature;
+};
+
+/**
+ * rte_graph Feature arc object
+ *
+ * Feature arc object holds control plane and fast path information for all
+ * features and all interface index information for steering packets across
+ * feature nodes
+ *
+ * Within a feature arc, only RTE_GRAPH_FEATURE_MAX_PER_ARC features can be
+ * added. If more features needs to be added, another feature arc can be
+ * created
+ *
+ * In fast path, rte_graph_feature_arc_t can be translated to (struct
+ * rte_graph_feature_arc *) via rte_graph_feature_arc_get(). Later is needed to
+ * add as an input argument to all fast path feature arc APIs
+ */
+struct __rte_cache_aligned rte_graph_feature_arc {
+	/** Slow path variables follows*/
+	RTE_MARKER slow_path_variables;
+
+	/** All feature lists */
+	STAILQ_HEAD(, rte_graph_feature_node_list) all_features;
+
+	/** feature arc name */
+	char feature_arc_name[RTE_GRAPH_FEATURE_ARC_NAMELEN];
+
+	/** control plane counter to track enabled features */
+	uint32_t runtime_enabled_features;
+
+	/** maximum number of features supported by this arc
+	 *  Immutable during fast path
+	 */
+	uint16_t max_features;
+
+	/** index in feature_arc_main */
+	rte_graph_feature_arc_t feature_arc_index;
+
+	/** Back pointer to feature_arc_main */
+	void *feature_arc_main;
+
+	/** Arc's start/end node */
+	struct rte_node_register *start_node;
+	struct rte_graph_feature_register end_feature;
+
+	/* arc start process function */
+	rte_node_process_t arc_start_process;
+
+	/* total arc_size allocated */
+	size_t arc_size;
+
+	/* slow path: feature data array maintained per [feature, index] */
+	rte_graph_feature_data_t *feature_data_by_index;
+
+	/**
+	 * Size of all feature data for each feature
+	 * ALIGN(sizeof(struct rte_graph_feature_data) * arc->max_indexes)
+	 * Not used in fastpath
+	 */
+	uint32_t feature_size;
+
+	/** Slow path bit mask per feature per index */
+	uint64_t *feature_bit_mask_by_index;
+
+	/** Cache aligned fast path variables */
+	alignas(RTE_CACHE_LINE_SIZE) RTE_MARKER fast_path_variables;
+
+	/**
+	 * Quick fast path bitmask indicating if any feature enabled. Each bit
+	 * corresponds to single feature. Helps in optimally process packets for
+	 * the case when features are added but not enabled
+	 */
+	RTE_ATOMIC(uint64_t) fp_feature_enable_bitmask;
+
+	/**
+	 * Number of added features. <= max_features
+	 */
+	uint16_t num_added_features;
+	/** maximum number of index supported by this arc
+	 *  Immutable during fast path
+	 */
+	uint16_t max_indexes;
+
+	/** first feature offset in fast path
+	 * Immutable during fast path
+	 */
+	uint16_t fp_first_feature_offset;
+
+	/** arc + fp_feature_data_arr_offset
+	 * Immutable during fast path
+	 */
+	uint16_t fp_feature_data_offset;
+
+	/*
+	 * mbuf dynamic offset saved for faster access
+	 * See rte_graph_feature_arc_mbuf_dynfields_get() for more details
+	 */
+	int mbuf_dyn_offset;
+
+	/**
+	 * Arc specific fast path data
+	 * It accommodates:
+	 *
+	 * 1. first enabled feature data for every index
+	 * rte_graph_feature_data_t (fdata as shown below)
+	 *
+	 * +--------------------------------------------------------------+ <- cache_aligned
+	 * |  0th Index    | 1st Index   |  ... | max_index - 1           |
+	 * +--------------------------------------------------------------+
+	 * |  Startfdata0  | Startfdata1 |  ... | Startfdata(max_index-1) |
+	 * +--------------------------------------------------------------+
+	 *
+	 * 2. struct rte_graph_feature_data per index per feature
+	 *
+	 * Start (Reserved) ->   +----------------------------------------+ ^ <- cache_aligned
+	 * (feature_enable)      |  struct rte_graph_feature_data[Index0] | |
+	 *                       +----------------------------------------+ | feature_size
+	 *                       |  struct rte_graph_feature_data[Index1] | |
+	 * Feature-0 ->          +----------------------------------------+ ^ <- cache_aligned
+	 *                       |  struct rte_graph_feature_data[Index0] | |
+	 *                       +----------------------------------------+ | feature_size
+	 *                       |  struct rte_graph_feature_data[Index1] | |
+	 * Feature-1 ->          +----------------------------------------+ v <- cache aligned
+	 *                       |  struct rte_graph_feature_data[Index0] | ^
+	 *                       +----------------------------------------+ | feature_size
+	 *                       |  struct rte_graph_feature_data[Index1] | |
+	 *                       +----------------------------------------+ v
+	 *                                 ...            ....
+	 *                                 ...            ....
+	 * Feature(index - 1) -> +----------------------------------------+ v <- cache aligned
+	 *                       |  struct rte_graph_feature_data[Index0] | ^
+	 *                       +----------------------------------------+ | feature_size
+	 *                       |  struct rte_graph_feature_data[Index1] | |
+	 * Extra (Reserved) ->   +----------------------------------------+ v <- cache aligned
+	 * (feature_disable)     |  struct rte_graph_feature_data[Index0] | ^
+	 *                       +----------------------------------------+ | feature_size
+	 *                       |  struct rte_graph_feature_data[Index1] | |
+	 *                       +----------------------------------------+ v
+	 */
+	RTE_MARKER8 fp_arc_data;
+};
+
+/**
+ * Feature arc main object
+ *
+ * Holds all feature arcs created by application
+ */
+typedef struct rte_feature_arc_main {
+	/** number of feature arcs created by application */
+	uint32_t num_feature_arcs;
+
+	/** max features arcs allowed */
+	uint32_t max_feature_arcs;
+
+	/* arc_mbuf_dyn_offset for saving feature arc specific
+	 * mbuf dynfield offset.
+	 *
+	 * See rte_graph_feature_arc_mbuf_dynfields_get() for more details
+	 */
+	int arc_mbuf_dyn_offset;
+
+	/** Pointer to all feature arcs */
+	uintptr_t feature_arcs[];
+} rte_graph_feature_arc_main_t;
+
+/**
+ *  Fast path feature data object
+ *
+ *  Used by fast path inline feature arc APIs
+ *  Corresponding to rte_graph_feature_data_t
+ *  It holds
+ *  - edge to reach to next feature node
+ *  - next_feature_data corresponding to next enabled feature
+ *  - app_cookie set by application in rte_graph_feature_enable()
+ */
+struct rte_graph_feature_data {
+	/** edge from this feature node to next enabled feature node */
+	RTE_ATOMIC(rte_edge_t) next_edge;
+
+	/**
+	 * app_cookie set by application in rte_graph_feature_enable() for
+	 * current feature data
+	 */
+	RTE_ATOMIC(uint16_t) app_cookie;
+
+	/** Next feature data from this feature data */
+	RTE_ATOMIC(rte_graph_feature_data_t) next_feature_data;
+};
+
+/** feature arc specific mbuf dynfield structure. */
+struct rte_graph_feature_arc_mbuf_dynfields {
+	/** each mbuf carries feature data */
+	rte_graph_feature_data_t feature_data;
+};
+
+/** Name of dynamic mbuf field offset registered in rte_graph_feature_arc_init() */
+#define RTE_GRAPH_FEATURE_ARC_DYNFIELD_NAME    "__rte_graph_feature_arc_mbuf_dynfield"
+
+/** log2(sizeof (struct rte_graph_feature_data)) */
+#define RTE_GRAPH_FEATURE_DATA_SIZE_LOG2	3
+
+/** Number of struct rte_graph_feature_data per feature*/
+#define RTE_GRAPH_FEATURE_DATA_NUM_PER_FEATURE(arc)				\
+	(arc->feature_size >> RTE_GRAPH_FEATURE_DATA_SIZE_LOG2)
+
+/** Get rte_graph_feature_data_t from rte_graph_feature_t */
+#define RTE_GRAPH_FEATURE_TO_FEATURE_DATA(arc, feature, index)			\
+		((rte_graph_feature_data_t)					\
+		 ((RTE_GRAPH_FEATURE_DATA_NUM_PER_FEATURE(arc) * (feature)) + (index)))
+
+/**
+ * @internal macro
+ */
+#define GRAPH_FEATURE_ARC_PTR_INITIALIZER  ((uintptr_t)UINTPTR_MAX)
+
+/** extern variables */
+extern rte_graph_feature_arc_main_t *__rte_graph_feature_arc_main;
+
+/**
+ * Get dynfield offset to feature arc specific fields in mbuf
+ *
+ * Feature arc mbuf dynamic field is separate to utilize mbuf->dynfield2
+ * instead of dynfield1
+ *
+ * This arc specific dynamic offset is registered as part of
+ * rte_graph_feature_arc_init() and copied in each arc for fast path access.
+ * This avoids node maintaining dynamic offset for feature arc and if we are
+ * lucky, field would be allocated from mbuf->dynfield2. Otherwise each node
+ * has to maintain at least two dynamic offset in fast path
+ *
+ * @param mbuf
+ *  Pointer to mbuf
+ * @param dyn_offset
+ *  Retrieved from arc->mbuf_dyn_offset
+ *
+ * @return
+ *  NULL: On Failure
+ *  Non-NULL pointer on Success
+ */
+__rte_experimental
+static __rte_always_inline struct rte_graph_feature_arc_mbuf_dynfields *
+rte_graph_feature_arc_mbuf_dynfields_get(struct rte_mbuf *mbuf,
+					 const int dyn_offset)
+{
+	return RTE_MBUF_DYNFIELD(mbuf, dyn_offset,
+				 struct rte_graph_feature_arc_mbuf_dynfields *);
+}
+
+/**
+ * API to know if feature is valid or not
+ *
+ * @param feature
+ *  rte_graph_feature_t
+ *
+ * @return
+ *  1: If feature is valid
+ *  0: If feature is invalid
+ */
+__rte_experimental
+static __rte_always_inline int
+rte_graph_feature_is_valid(rte_graph_feature_t feature)
+{
+	return (feature != RTE_GRAPH_FEATURE_INVALID);
+}
+
+/**
+ * API to know if feature data is valid or not
+ *
+ * @param feature_data
+ *  rte_graph_feature_data_t
+ *
+ * @return
+ *  1: If feature data is valid
+ *  0: If feature data is invalid
+ */
+__rte_experimental
+static __rte_always_inline int
+rte_graph_feature_data_is_valid(rte_graph_feature_data_t feature_data)
+{
+	return (feature_data != RTE_GRAPH_FEATURE_DATA_INVALID);
+}
+
+/**
+ * Get pointer to feature arc object from rte_graph_feature_arc_t
+ *
+ * @param arc
+ *  feature arc
+ *
+ * @return
+ *  NULL: On Failure
+ *  Non-NULL pointer on Success
+ */
+__rte_experimental
+static __rte_always_inline struct rte_graph_feature_arc *
+rte_graph_feature_arc_get(rte_graph_feature_arc_t arc)
+{
+	uintptr_t fa = GRAPH_FEATURE_ARC_PTR_INITIALIZER;
+	rte_graph_feature_arc_main_t *fm = NULL;
+
+	fm = __rte_graph_feature_arc_main;
+
+	if (likely((fm != NULL) && (arc < fm->max_feature_arcs)))
+		fa = fm->feature_arcs[arc];
+
+	return (fa == GRAPH_FEATURE_ARC_PTR_INITIALIZER) ?
+		NULL : (struct rte_graph_feature_arc *)fa;
+}
+
+/**
+ * Get rte_graph_feature_t from feature arc object without any checks
+ *
+ * @param arc
+ *  feature arc
+ * @param fdata
+ *  feature data object
+ *
+ * @return
+ *   Pointer to feature data object
+ */
+__rte_experimental
+static __rte_always_inline struct rte_graph_feature_data*
+__rte_graph_feature_data_get(struct rte_graph_feature_arc *arc,
+			     rte_graph_feature_data_t fdata)
+{
+	return ((struct rte_graph_feature_data *) ((uint8_t *)arc + arc->fp_feature_data_offset +
+						   (fdata << RTE_GRAPH_FEATURE_DATA_SIZE_LOG2)));
+}
+
+/**
+ * Get next edge from feature data pointer, without any check
+ *
+ * @param fdata
+ *  feature data object
+ *
+ * @return
+ *  next edge
+ */
+__rte_experimental
+static __rte_always_inline rte_edge_t
+__rte_graph_feature_data_edge_get(struct rte_graph_feature_data *fdata)
+{
+	return rte_atomic_load_explicit(&fdata->next_edge, rte_memory_order_relaxed);
+}
+
+/**
+ * Get app_cookie from feature data pointer, without any check
+ *
+ * @param fdata
+ *  feature data object
+ *
+ * @return
+ *  app_cookie set by caller in rte_graph_feature_enable() API
+ */
+__rte_experimental
+static __rte_always_inline uint16_t
+__rte_graph_feature_data_app_cookie_get(struct rte_graph_feature_data *fdata)
+{
+	return rte_atomic_load_explicit(&fdata->app_cookie, rte_memory_order_relaxed);
+}
+
+/**
+ * Get next_enabled_feature_data from pointer to feature data, without any check
+ *
+ * @param fdata
+ *  feature data object
+ *
+ * @return
+ *  next enabled feature data from this feature data
+ */
+__rte_experimental
+static __rte_always_inline rte_graph_feature_data_t
+__rte_graph_feature_data_next_feature_get(struct rte_graph_feature_data *fdata)
+{
+	return rte_atomic_load_explicit(&fdata->next_feature_data, rte_memory_order_relaxed);
+}
+
+/**
+ * Get app_cookie from feature data object with checks
+ *
+ * @param arc
+ *  feature arc
+ * @param fdata
+ *  feature data object
+ *
+ * @return
+ *  app_cookie set by caller in rte_graph_feature_enable() API
+ */
+__rte_experimental
+static __rte_always_inline uint16_t
+rte_graph_feature_data_app_cookie_get(struct rte_graph_feature_arc *arc,
+				      rte_graph_feature_data_t fdata)
+{
+	struct rte_graph_feature_data *fdata_obj = __rte_graph_feature_data_get(arc, fdata);
+
+	return __rte_graph_feature_data_app_cookie_get(fdata_obj);
+}
+
+/**
+ * Get next_enabled_feature_data from current feature data object with checks
+ *
+ * @param arc
+ *  feature arc
+ * @param fdata
+ *  Pointer to feature data object
+ * @param[out] next_edge
+ *  next_edge from current feature to next enabled feature
+ *
+ * @return
+ *  1: if next feature enabled on index
+ *  0: if no feature is enabled on index
+ */
+__rte_experimental
+static __rte_always_inline int
+rte_graph_feature_data_next_feature_get(struct rte_graph_feature_arc *arc,
+					rte_graph_feature_data_t *fdata,
+					rte_edge_t *next_edge)
+{
+	struct rte_graph_feature_data *fdata_obj = __rte_graph_feature_data_get(arc, *fdata);
+
+	*fdata = __rte_graph_feature_data_next_feature_get(fdata_obj);
+	*next_edge = __rte_graph_feature_data_edge_get(fdata_obj);
+
+	return rte_graph_feature_data_is_valid(*fdata);
+}
+
+/**
+ * Get struct rte_graph_feature_data from rte_graph_feature_dat_t
+ *
+ * @param arc
+ *   feature arc
+ * @param fdata
+ *  feature data object
+ *
+ * @return
+ *   NULL: On Failure
+ *   Non-NULL pointer on Success
+ */
+__rte_experimental
+static __rte_always_inline struct rte_graph_feature_data*
+rte_graph_feature_data_get(struct rte_graph_feature_arc *arc,
+			   rte_graph_feature_data_t fdata)
+{
+	if (rte_graph_feature_data_is_valid(fdata))
+		return __rte_graph_feature_data_get(arc, fdata);
+	else
+		return NULL;
+}
+
+/**
+ * Get feature data corresponding to first enabled feature on index
+ * @param arc
+ *   feature arc
+ * @param index
+ *   Interface index
+ * @param[out] fdata
+ *  feature data object
+ * @param[out] edge
+ *  rte_edge object
+ *
+ * @return
+ *  1: if any feature enabled on index, return corresponding valid feature data
+ *  0: if no feature is enabled on index
+ */
+__rte_experimental
+static __rte_always_inline int
+rte_graph_feature_data_first_feature_get(struct rte_graph_feature_arc *arc,
+					 uint32_t index,
+					 rte_graph_feature_data_t *fdata,
+					 rte_edge_t *edge)
+{
+	struct rte_graph_feature_data *fdata_obj = NULL;
+	rte_graph_feature_data_t *fd;
+
+	fd = (rte_graph_feature_data_t *)((uint8_t *)arc + arc->fp_first_feature_offset +
+					  (sizeof(rte_graph_feature_data_t) * index));
+
+	if (unlikely(rte_graph_feature_data_is_valid(*fd))) {
+		fdata_obj = __rte_graph_feature_data_get(arc, *fd);
+		*edge = __rte_graph_feature_data_edge_get(fdata_obj);
+		*fdata = __rte_graph_feature_data_next_feature_get(fdata_obj);
+		return 1;
+	}
+
+	return 0;
+}
+
+/**
+ * Fast path API to check if any feature enabled on a feature arc
+ * Typically from arc->start_node process function
+ *
+ * @param arc
+ *   Feature arc object
+ *
+ * @return
+ *  0: If no feature enabled
+ *  Non-Zero: Bitmask of features enabled.
+ *
+ */
+__rte_experimental
+static __rte_always_inline uint64_t
+rte_graph_feature_arc_is_any_feature_enabled(struct rte_graph_feature_arc *arc)
+{
+	if (unlikely(arc == NULL))
+		return 0;
+
+	return (rte_atomic_load_explicit(&arc->fp_feature_enable_bitmask,
+					 rte_memory_order_relaxed));
+}
+
+/**
+ * Prefetch feature arc fast path cache line
+ *
+ * @param arc
+ *   RTE_GRAPH feature arc object
+ */
+__rte_experimental
+static __rte_always_inline void
+rte_graph_feature_arc_prefetch(struct rte_graph_feature_arc *arc)
+{
+	rte_prefetch0((void *)arc->fast_path_variables);
+}
+
+/**
+ * Prefetch feature data related fast path cache line
+ *
+ * @param arc
+ *   RTE_GRAPH feature arc object
+ * @param fdata
+ *   Pointer to feature data object
+ */
+__rte_experimental
+static __rte_always_inline void
+rte_graph_feature_arc_feature_data_prefetch(struct rte_graph_feature_arc *arc,
+					    rte_graph_feature_data_t fdata)
+{
+	if (unlikely(fdata == RTE_GRAPH_FEATURE_DATA_INVALID))
+		return;
+
+	rte_prefetch0((void *)__rte_graph_feature_data_get(arc, fdata));
+}
+
+#ifdef __cplusplus
+}
+#endif
+#endif
--
2.43.0

