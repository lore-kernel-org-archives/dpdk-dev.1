Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A440C5B552
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 10:13:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7AB13427DF;
	Wed,  4 Jun 2025 12:13:21 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 94D18427D5
 for <dev@dpdk.org>; Wed,  4 Jun 2025 12:13:20 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553KRVCr020675;
 Wed, 4 Jun 2025 03:13:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=o
 4PzpTCxVXHsdCZeh345olKG99DJHiCVbO4HmW7AS5g=; b=bR8vOMF2WIi/qkzYy
 wjURuXKcx2lTXqxQ7Q8/7sXOffiUlw9F9RgVjV58hC4Xqj13HT4EZhC/Mh+Ud6dm
 /87diX8BNpjxUqJWAOTEVVRXDNSjRBjWpYbglieTf9xo6PSFntIVQ9wjUZv4ZiQY
 bJPsyHQQsHanxzkgkitqmKBoOhqI4SCw3jfCBWjr9fx+f5h3a+rW3ot/gKkVpbAw
 l0p7m9DHPOgYQffESu0OLtiQTs8EFQnt5tNBZAriylXbu86ezzEFP8DflJeKwMKc
 x0sxS//j7jimfgp2DLSClfQxUGKyvndbenUQ5WCVtf3NBufBEjQESkuGZobLhGmx
 nvoiA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47283r9dtf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 03:13:15 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Jun 2025 03:13:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Jun 2025 03:13:13 -0700
Received: from cavium-PowerEdge-R640.. (unknown [10.28.36.207])
 by maili.marvell.com (Postfix) with ESMTP id 00FBB3F7080;
 Wed,  4 Jun 2025 03:13:10 -0700 (PDT)
From: Nitin Saxena <nsaxena@marvell.com>
To: Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>, Zhirun Yan
 <yanzhirun_163@163.com>, Robin Jarry <rjarry@redhat.com>,
 Christophe Fontaine <cfontain@redhat.com>
CC: <dev@dpdk.org>, Nitin Saxena <nsaxena16@gmail.com>
Subject: [PATCH v10 3/7] graph: add feature arc init APIs
Date: Wed, 4 Jun 2025 15:42:30 +0530
Message-ID: <20250604101259.4181992-4-nsaxena@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604101259.4181992-1-nsaxena@marvell.com>
References: <20250103060612.2671836-1-nsaxena@marvell.com>
 <20250604101259.4181992-1-nsaxena@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: kDhvFce2iMxYwORedGeU2-4QResnhttg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDA3NiBTYWx0ZWRfX81MiW6jxD17W
 /Le47uI61ea7VbcVT2DfA3AKhhVevmK9qXhhe7pdnJKDS9ATU/f7gSEYJQUijIck4ykBDLtzf3I
 r/AaZ5FW11K/MlEHW5fyqWJcLWaCn1X7jPeWZUk4IHDaSJohB3qr/Emhq/Ytz8FeIblATlqnAcB
 E1/0ZSmCxx62c18K/NadKCpM7dxL8AvuPzrQjeO/megUh7+vaHPQl51DJOXKniEHGHZNBgCYI1V
 2tcK7Q2XINp5EctST5UYkz+78bB72+Y7V9OHLC9ouisIOAugcFOKVSE/GPYaQxDqGS2Dl6/5ios
 7nvvuJbkNW/AcMLk7vMaTxh6ElklOtdRaxwLhNnV3ZqlIo8RdqfaQzsChUCF+LC1aS2JxD35nga
 p8mw9nwJzllyHuhl75DrxUM8Z9refKznCv8kmrc5L92/CNalnf7x3JX5OtiCk7WYYzEslgUr
X-Authority-Analysis: v=2.4 cv=E7HNpbdl c=1 sm=1 tr=0 ts=68401c3b cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=8Z5W2_9EhVJH0GEj8sQA:9
 a=CSGGGR-vdv1nGKxz:21 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: kDhvFce2iMxYwORedGeU2-4QResnhttg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_02,2025-06-03_02,2025-03-28_01
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

This patch adds feature arc init()/create()/destroy() APIs. It also add
APIs for adding feature node to an arc.

Signed-off-by: Nitin Saxena <nsaxena@marvell.com>
---
 doc/api/doxy-api-index.md                |    1 +
 doc/guides/prog_guide/graph_lib.rst      |   23 +-
 lib/graph/graph_feature_arc.c            | 1329 +++++++++++++++++++++-
 lib/graph/graph_private.h                |    4 +
 lib/graph/meson.build                    |    2 +-
 lib/graph/rte_graph_feature_arc.h        |  248 +++-
 lib/graph/rte_graph_feature_arc_worker.h |  303 +++++
 7 files changed, 1902 insertions(+), 8 deletions(-)
 create mode 100644 lib/graph/rte_graph_feature_arc_worker.h

diff --git a/doc/api/doxy-api-index.md b/doc/api/doxy-api-index.md
index a7bdbf892c..6d8b531344 100644
--- a/doc/api/doxy-api-index.md
+++ b/doc/api/doxy-api-index.md
@@ -215,6 +215,7 @@ The public API headers are grouped by topics:
   * [graph](@ref rte_graph.h):
     [graph_worker](@ref rte_graph_worker.h)
     [graph_feature_arc](@ref rte_graph_feature_arc.h)
+    [graph_feature_arc_worker](@ref rte_graph_feature_arc_worker.h)
   * graph_nodes:
     [eth_node](@ref rte_node_eth_api.h),
     [ip4_node](@ref rte_node_ip4_api.h),
diff --git a/doc/guides/prog_guide/graph_lib.rst b/doc/guides/prog_guide/graph_lib.rst
index 191c8e8a0b..c9ac9e7ae0 100644
--- a/doc/guides/prog_guide/graph_lib.rst
+++ b/doc/guides/prog_guide/graph_lib.rst
@@ -815,7 +815,7 @@ added to existing arc as follows:
             ...
             ...
             ...
-        .override_index_cb = Feature-3_override_index_cb(),
+        .override_index_cb = Feature-2_override_index_cb(),
         .runs_after = "Feature-1",
         .runs_before = "Custom-Feature",
     };
@@ -848,3 +848,24 @@ this callback. In case of multiple features, largest value returned by any
 feature would be selected for creating feature arc.

 .. _Feature_Arc_Initialization:
+
+Initializing Feature arc
+^^^^^^^^^^^^^^^^^^^^^^^^
+Following code shows how to initialize feature arc sub-system.
+``rte_graph_feature_arc_init()`` API is used to initialize a feature arc
+sub-system. If not called, feature arc has no impact on application.
+
+.. code-block:: c
+
+    struct rte_graph_param *graph_param = app_get_graph_param();
+
+    /* Initialize feature arc before graph create */
+    rte_graph_feature_arc_init(0);
+
+    rte_graph_create(graph_param);
+
+.. note::
+
+   ``rte_graph_feature_arc_init()`` API should be called before
+   ``rte_graph_create()``. If not called, feature arc is a ``NOP`` to
+   application.
diff --git a/lib/graph/graph_feature_arc.c b/lib/graph/graph_feature_arc.c
index 6135b262d5..b28f0ec321 100644
--- a/lib/graph/graph_feature_arc.c
+++ b/lib/graph/graph_feature_arc.c
@@ -2,10 +2,57 @@
  * Copyright(C) 2025 Marvell International Ltd.
  */

-#include <rte_graph_feature_arc.h>
+#include <rte_graph_feature_arc_worker.h>
+#include <rte_malloc.h>
+#include <rte_string_fns.h>
 #include <eal_export.h>
 #include "graph_private.h"

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
 /* global feature arc list */
 static STAILQ_HEAD(, rte_graph_feature_arc_register) feature_arc_list =
 					STAILQ_HEAD_INITIALIZER(feature_arc_list);
@@ -14,6 +61,1251 @@ static STAILQ_HEAD(, rte_graph_feature_arc_register) feature_arc_list =
 static STAILQ_HEAD(, rte_graph_feature_register) feature_list =
 					STAILQ_HEAD_INITIALIZER(feature_list);

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
+	rte_graph_feature_data_t *f = NULL;
+	uint16_t index;
+
+	arc->runtime_enabled_features = 0;
+
+	for (index = 0; index < arc->max_indexes; index++) {
+		f = graph_first_feature_data_ptr_get(arc, index);
+		*f = RTE_GRAPH_FEATURE_DATA_INVALID;
+	}
+
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
+			  reg->arc_name, (uint64_t)sz);
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
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_destroy, 25.07);
+int
+rte_graph_feature_arc_destroy(rte_graph_feature_arc_t _arc)
+{
+	struct rte_graph_feature_arc *arc = rte_graph_feature_arc_get(_arc);
+	rte_graph_feature_arc_main_t *dm = __rte_graph_feature_arc_main;
+	struct rte_graph_feature_node_list *node_info = NULL;
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
+				node_info->notifier_cb(arc->feature_arc_name,
+						       node_info->feature_name,
+						       node_info->feature_node_id,
+						       iter, false /* disable */,
+						       UINT16_MAX /* invalid cookie */);
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
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_graph_feature_arc_register, 25.07);
 void __rte_graph_feature_arc_register(struct rte_graph_feature_arc_register *reg,
 				      const char *caller_name, int lineno)
@@ -28,9 +1320,40 @@ RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_graph_feature_register, 25.07);
 void __rte_graph_feature_register(struct rte_graph_feature_register *reg,
 				  const char *caller_name, int lineno)
 {
-	RTE_SET_USED(caller_name);
-	RTE_SET_USED(lineno);
+	if (feature_registration_validate(reg, caller_name, lineno, 0, 0, true) < 0)
+		return;

 	/* Add to the feature_list*/
 	STAILQ_INSERT_TAIL(&feature_list, reg, next_feature);
 }
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
index 1b2f493037..6a6d570290 100644
--- a/lib/graph/meson.build
+++ b/lib/graph/meson.build
@@ -20,7 +20,7 @@ sources = files(
         'graph_feature_arc.c',
 )
 headers = files('rte_graph.h', 'rte_graph_worker.h')
-headers += files('rte_graph_feature_arc.h')
+headers += files('rte_graph_feature_arc.h', 'rte_graph_feature_arc_worker.h')
 indirect_headers += files(
         'rte_graph_model_mcore_dispatch.h',
         'rte_graph_model_rtc.h',
diff --git a/lib/graph/rte_graph_feature_arc.h b/lib/graph/rte_graph_feature_arc.h
index 56d8f2f34c..f25f77df3c 100644
--- a/lib/graph/rte_graph_feature_arc.h
+++ b/lib/graph/rte_graph_feature_arc.h
@@ -87,16 +87,70 @@ extern "C" {
  *
  * A feature arc in a graph is represented via *start_node* and *end_node*.
  * Feature nodes are added between start_node and end_node. Packets enter
- * feature arc traversal via start_node while they exits from end_node. Packets
- * steering from start_node to feature nodes are controlled in control plane
- * via rte_graph_feature_enable()/rte_graph_feature_disable().
+ * feature arc traversal via start_node while they exits from end_node.
  *
  * This library facilitates rte graph based applications to implement stack
  * functionalities described above by providing "edge" to the next enabled
  * feature node in fast path
  *
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
+ * - Feature arc can be destroyed via rte_graph_feature_arc_destroy()
+ *
+ * If a given feature likes to control number of indexes (which is higher than
+ * RTE_GRAPH_FEATURE_ARC_REGISTER::max_indexes) it can do so by using
+ * RTE_GRAPH_FEATURE_REGISTER():override_index_cb(). As part of
+ * rte_graph_feature_arc_init(), all feature's override_index_cb(), if set, are
+ * called and with maximum value returned by any of the feature is used for
+ * rte_graph_feature_arc_create()
+ *
+ * Constraints
+ * -----------
+ *  - rte_graph_feature_arc_init(), rte_graph_feature_create() and
+ *  rte_graph_feature_add() must be called before rte_graph_create().
+ *  - Not more than 63 features can be added to a feature arc. There is no
+ *  limit to number of feature arcs i.e. number of
+ *  RTE_GRAPH_FEATURE_ARC_REGISTER()
+ *  - There is also no limit for number of indexes (RTE_GRAPH_FEATURE_ARC_REGISTER():
+ *  max_indexes). There is also a provision for each
+ *  RTE_GRAPH_FEATURE_REGISTER() to override number of indexes via
+ *  override_index_cb()
+ *  - A feature node cannot be part of more than one arc due to
+ *  performance reason.
+ *
+ * Optional Usage
+ * --------------
+ * Feature arc is added as an optional functionality to the graph library hence
+ * an application may choose not to use it by skipping explicit call to
+ * rte_graph_feature_arc_init(). In that case feature arc would be a no-op for
+ * application.
  */

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
 /** feature notifier callback called when feature is enabled/disabled */
 typedef void (*rte_graph_feature_change_notifier_cb_t)(const char *arc_name,
 						       const char *feature_name,
@@ -230,6 +284,194 @@ struct rte_graph_feature_arc_register {
 	{                                                                               \
 		__rte_graph_feature_arc_register(&reg, __func__, __LINE__);             \
 	}
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

 /**
  * @internal
diff --git a/lib/graph/rte_graph_feature_arc_worker.h b/lib/graph/rte_graph_feature_arc_worker.h
new file mode 100644
index 0000000000..b2fc539402
--- /dev/null
+++ b/lib/graph/rte_graph_feature_arc_worker.h
@@ -0,0 +1,303 @@
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
+	/** finfo_index in list. same as rte_graph_feature_t */
+	uint32_t finfo_index;
+
+	/** Back pointer to feature arc */
+	void *feature_arc;
+
+	/** rte_edge_t to this feature node from feature_arc->start_node */
+	rte_edge_t edge_to_this_feature;
+
+	/** rte_edge_t from this feature node to last feature node */
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
+	/** arc start process function */
+	rte_node_process_t arc_start_process;
+
+	/** total arc_size allocated */
+	size_t arc_size;
+
+	/** slow path: feature data array maintained per [feature, index] */
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
+	/**
+	 * mbuf dynamic offset saved for faster access
+	 * See rte_graph_feature_arc_mbuf_dynfields_get() for more details
+	 */
+	int mbuf_dyn_offset;
+
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
+	/** arc_mbuf_dyn_offset for saving feature arc specific
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
+ */
+struct rte_graph_feature_data {
+	/** edge from this feature node to next enabled feature node */
+	RTE_ATOMIC(rte_edge_t) next_edge;
+
+	/**
+	 * app_cookie
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
+#ifdef __cplusplus
+}
+#endif
+#endif
--
2.43.0

