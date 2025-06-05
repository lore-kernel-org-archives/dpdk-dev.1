Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06741C5B543
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Jun 2025 17:34:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE94440678;
	Thu,  5 Jun 2025 19:33:39 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 7685A4066C
 for <dev@dpdk.org>; Thu,  5 Jun 2025 19:33:38 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555H0UMl024592;
 Thu, 5 Jun 2025 10:33:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=T
 ixN8sYtVZPkELop9v+CG8LyHpouMasBlyQDUzfiZ7M=; b=J7nxCDXedQpUaGcTL
 MbEEYgxx8APCY/MUdLXfZY5o1uPFacfqDyAmr5I+lcp78lafPwEVipfqxfiv1CZz
 W7aY8zOivIwur4A3rBOOH8sO3bvMrRZb4CTv3TxU58wncVwLHdMumShSgHOAKqDx
 0LdExQLqDiTI765rF54T1mqKxF1jKGQmkGUisw/btflE4GPLJOP2EUkbxsqx+pam
 SHMXHapVqy7yoaBNtJe67wqc7kc4/j0XXUjDHjKkuXKI+7VdA2w2+SvWiW84/Fa8
 r8+5qyOC/iyuyGVbAjlPKS66WiMH4kGSndedPNSFIZnLb0KKo030o1TfgBxVN2vM
 fnK2Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 473f8s82d5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Jun 2025 10:33:33 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 5 Jun 2025 10:33:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 5 Jun 2025 10:33:32 -0700
Received: from cavium-PowerEdge-R640.. (unknown [10.28.36.207])
 by maili.marvell.com (Postfix) with ESMTP id CA65B3F7044;
 Thu,  5 Jun 2025 10:33:29 -0700 (PDT)
From: Nitin Saxena <nsaxena@marvell.com>
To: Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>, Zhirun Yan
 <yanzhirun_163@163.com>, Robin Jarry <rjarry@redhat.com>,
 Christophe Fontaine <cfontain@redhat.com>
CC: <dev@dpdk.org>, Nitin Saxena <nsaxena16@gmail.com>
Subject: [PATCH v12 4/7] graph: add feature enable/disable APIs
Date: Thu, 5 Jun 2025 23:03:09 +0530
Message-ID: <20250605173315.1447003-5-nsaxena@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250605173315.1447003-1-nsaxena@marvell.com>
References: <20250103060612.2671836-1-nsaxena@marvell.com>
 <20250605173315.1447003-1-nsaxena@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: utwbn1QKd40aSsbBB2N8BGg47pYm2RRS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDE1NSBTYWx0ZWRfXwN5tRaiyKwPA
 ilbef1goi4gVm094hT+qJS6gL1hqeAkZXKIdygmvfIOBnubc+Nqw/iNQC5B8z0fFnjczajko2hd
 0qPLear1h1l+diGiR+Wbx2PBgRw9ejDQf9eIWpK/hJGWplPvsq+796T4sZJOc2uVfhfhzSqPkZN
 DB7j231dkNc7+38PkDBoZUm3hF2zV0llSFamTfa8aQxN7MvT2TZuXH42stOyEqViAbRyYL+NSpM
 lvFssBCN/dbXNx5RlYJDUmQ9E1uURQ/zu5xNAAZu5cPg9FooKZxzM/lmNu9KcPQFm8bDC1BHTDF
 r0f08myH5OO7DBKdDYg8161TChPBx3z5a3Phe9yrw/8TKjUm7yBWm8CgVzAW9Le91KsF9bP4Hu4
 K1IF3tLbbkbWlz5reuE4o1rTlawj54WyPbLuBrzWIHlM79EzYCG45zV4BRRvKXJeSvdn42rL
X-Authority-Analysis: v=2.4 cv=RKizH5i+ c=1 sm=1 tr=0 ts=6841d4ed cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=mHh_cJpxoZaGhndkmA8A:9
 a=tByuJ_mFzhY6-DtF:21 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: utwbn1QKd40aSsbBB2N8BGg47pYm2RRS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_04,2025-06-05_01,2025-03-28_01
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

This patch also adds feature arc fast path APIs as well along with
documentation

Signed-off-by: Nitin Saxena <nsaxena@marvell.com>
---
 doc/guides/prog_guide/graph_lib.rst      | 180 ++++++
 lib/graph/graph_feature_arc.c            | 717 ++++++++++++++++++++++-
 lib/graph/meson.build                    |   2 +-
 lib/graph/rte_graph_feature_arc.h        | 152 ++++-
 lib/graph/rte_graph_feature_arc_worker.h | 321 +++++++++-
 5 files changed, 1353 insertions(+), 19 deletions(-)

diff --git a/doc/guides/prog_guide/graph_lib.rst b/doc/guides/prog_guide/graph_lib.rst
index 695156aad8..618fdf50ba 100644
--- a/doc/guides/prog_guide/graph_lib.rst
+++ b/doc/guides/prog_guide/graph_lib.rst
@@ -453,6 +453,8 @@ provides application to overload default node path by providing hook
 points(like netfilter) to insert out-of-tree or another protocol nodes in
 packet path.

+.. _Control_Data_Plane_Synchronization:
+
 Control/Data plane synchronization
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 Feature arc does not stop worker cores for any runtime control plane updates.
@@ -683,6 +685,11 @@ which might have allocated during feature enable.
 notifier_cb() is called, at runtime, for every enable/disable of ``[feature,
 index]`` from control thread.

+If RCU is provided to enable/disable APIs, notifier_cb() is called after
+``rte_rcu_qsbr_synchronize()``. Application also needs to call
+``rte_rcu_qsbr_quiescent()`` in worker thread (preferably after every
+``rte_graph_walk()`` iteration)
+
 override_index_cb()
 ....................
 A feature arc is :ref:`registered<Feature_Arc_Registration>` to operate on
@@ -714,6 +721,179 @@ sub-system. If not called, feature arc has no impact on application.
    ``rte_graph_create()``. If not called, feature arc is a ``NOP`` to
    application.

+Runtime feature enable/disable
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+A feature can be enabled or disabled at runtime from control thread using
+``rte_graph_feature_enable()`` and ``rte_graph_feature_disable()`` APIs
+respectively.
+
+.. code-block:: c
+
+    struct rte_rcu_qsbr *rcu_qsbr = app_get_rcu_qsbr();
+    rte_graph_feature_arc_t _arc;
+    uint16_t app_cookie;
+
+    if (rte_graph_feature_arc_lookup_by_name("Arc1", &_arc) < 0) {
+        RTE_LOG(ERR, GRAPH, "Arc1 not found\n");
+        return -ENOENT;
+    }
+    app_cookie = 100; /* Specific to ['Feature-1`, `port-0`]*/
+
+    /* Enable feature */
+    rte_graph_feature_enable(_arc, 0 /* port-0 */,
+                             "Feature-1" /* Name of the node feature */,
+                             app_cookie, rcu_qsbr);
+
+    /* Disable feature */
+    rte_graph_feature_disable(_arc, 0 /* port-0 */,
+                              "Feature-1" /* Name of the node feature*/,
+                              rcu_qsbr);
+
+.. note::
+
+   RCU argument is optional argument to enable/disable APIs. See
+   :ref:`control/data plane
+   synchronization<Control_Data_Plane_Synchronization>` and
+   :ref:`notifier_cb<Feature_Notifier_Cb>` for more details on when RCU is
+   needed.
+
+Fast path traversal rules
+^^^^^^^^^^^^^^^^^^^^^^^^^
+``Start node``
+**************
+If feature arc is :ref:`initialized<Feature_Arc_Initialization>`,
+``start_node_feature_process_fn()`` will be called by ``rte_graph_walk()``
+instead of node's original ``process()``. This function should allow packets to
+enter arc path whenever any feature is enabled at runtime
+
+.. code-block:: c
+
+    static int nodeA_init(const struct rte_graph *graph, struct rte_node *node)
+    {
+        rte_graph_feature_arc_t _arc;
+
+        if (rte_graph_feature_arc_lookup_by_name("Arc1", &_arc) < 0) {
+            RTE_LOG(ERR, GRAPH, "Arc1 not found\n");
+            return -ENOENT;
+        }
+
+        /* Save arc in node context */
+        node->ctx = _arc;
+        return 0;
+    }
+
+    int nodeA_process_inline(struct rte_graph *graph, struct rte_node *node,
+                             void **objs, uint16_t nb_objs,
+                             struct rte_graph_feature_arc *arc,
+                             const int do_arc_processing)
+    {
+        for(uint16_t i = 0; i < nb_objs; i++) {
+            struct rte_mbuf *mbuf = objs[i];
+            rte_edge_t edge_to_child = 0; /* By default to Node-B */
+
+            if (do_arc_processing) {
+                struct rte_graph_feature_arc_mbuf_dynfields *dyn =
+                    rte_graph_feature_arc_mbuf_dynfields_get(mbuf, arc->mbuf_dyn_offset);
+
+                if (rte_graph_feature_data_first_feature_get(mbuf, mbuf->port,
+                                                             &dyn->feature_data,
+                                                             &edge_to_child) < 0) {
+
+                    /* Some feature is enabled, edge_to_child is overloaded*/
+                }
+            }
+            /* enqueue as usual */
+            rte_node_enqueue_x1(graph, node, mbuf, edge_to_child);
+       }
+    }
+
+    int nodeA_feature_process_fn(struct rte_graph *graph, struct rte_node *node,
+                                 void **objs, uint16_t nb_objs)
+    {
+        struct rte_graph_feature_arc *arc = rte_graph_feature_arc_get(node->ctx);
+
+        if (unlikely(rte_graph_feature_arc_has_any_feature(arc)))
+            return nodeA_process_inline(graph, node, objs, nb_objs, arc, 1 /* do arc processing */);
+        else
+            return nodeA_process_inline(graph, node, objs, nb_objs, NULL, 0 /* skip arc processing */);
+    }
+
+``Feature nodes``
+*****************
+Following code-snippet explains fast path traversal rule for ``Feature-1``
+:ref:`feature node<Feature_Nodes>` shown in :ref:`figure<Figure_Arc_2>`.
+
+.. code-block:: c
+
+    static int Feature1_node_init(const struct rte_graph *graph, struct rte_node *node)
+    {
+        rte_graph_feature_arc_t _arc;
+
+        if (rte_graph_feature_arc_lookup_by_name("Arc1", &_arc) < 0) {
+            RTE_LOG(ERR, GRAPH, "Arc1 not found\n");
+            return -ENOENT;
+        }
+
+        /* Save arc in node context */
+        node->ctx = _arc;
+        return 0;
+    }
+
+    int feature1_process_inline(struct rte_graph *graph, struct rte_node *node,
+                                void **objs, uint16_t nb_objs,
+                                struct rte_graph_feature_arc *arc)
+    {
+        for(uint16_t i = 0; i < nb_objs; i++) {
+            struct rte_mbuf *mbuf = objs[i];
+            rte_edge_t edge_to_child = 0; /* By default to Node-B */
+
+            struct rte_graph_feature_arc_mbuf_dynfields *dyn =
+                    rte_graph_feature_arc_mbuf_dynfields_get(mbuf, arc->mbuf_dyn_offset);
+
+            /* Get feature app cookie for mbuf */
+            uint16_t app_cookie = rte_graph_feature_data_app_cookie_get(mbuf, &dyn->feature_data);
+
+            if (feature_local_lookup(app_cookie) {
+
+                /* Packets is relevant to this feature. Move packet from arc path */
+                edge_to_child = X;
+
+            } else {
+
+                /* Packet not relevant to this feature. Send this packet to
+                 * next enabled feature
+                 */
+                 rte_graph_feature_data_next_feature_get(mbuf, &dyn->feature_data,
+                                                         &edge_to_child);
+            }
+
+            /* enqueue as usual */
+            rte_node_enqueue_x1(graph, node, mbuf, edge_to_child);
+       }
+    }
+
+    int feature1_process_fn(struct rte_graph *graph, struct rte_node *node,
+                           void **objs, uint16_t nb_objs)
+    {
+        struct rte_graph_feature_arc *arc = rte_graph_feature_arc_get(node->ctx);
+
+        return feature1_process_inline(graph, node, objs, nb_objs, arc);
+    }
+
+``End feature node``
+********************
+An end feature node is a feature node through which packets exits feature arc
+path. It should not use any feature arc fast path APIs.
+
+Feature arc destroy
+^^^^^^^^^^^^^^^^^^^
+``rte_graph_feature_arc_destroy()`` can be used to free a arc object.
+
+Feature arc cleanup
+^^^^^^^^^^^^^^^^^^^
+``rte_graph_feature_arc_cleanup()`` can be used to free all resources
+associated with feature arc module.
+
 Inbuilt Nodes
 -------------

diff --git a/lib/graph/graph_feature_arc.c b/lib/graph/graph_feature_arc.c
index 568363c404..c7641ea619 100644
--- a/lib/graph/graph_feature_arc.c
+++ b/lib/graph/graph_feature_arc.c
@@ -17,6 +17,11 @@

 #define NUM_EXTRA_FEATURE_DATA   (2)

+#define graph_uint_cast(f)		((unsigned int)(f))
+
+#define fdata_fix_get(arc, feat, index)	\
+			RTE_GRAPH_FEATURE_TO_FEATURE_DATA(arc, feat, index)
+
 #define feat_dbg graph_dbg

 #define FEAT_COND_ERR(cond, ...)                                           \
@@ -59,6 +64,135 @@ static STAILQ_HEAD(, rte_graph_feature_arc_register) feature_arc_list =
 static STAILQ_HEAD(, rte_graph_feature_register) feature_list =
 					STAILQ_HEAD_INITIALIZER(feature_list);

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
 /* feature registration validate */
 static int
 feature_registration_validate(struct rte_graph_feature_register *feat_entry,
@@ -339,7 +473,10 @@ graph_first_feature_data_ptr_get(struct rte_graph_feature_arc *arc,
 static int
 feature_arc_data_reset(struct rte_graph_feature_arc *arc)
 {
+	rte_graph_feature_data_t first_fdata;
+	struct rte_graph_feature_data *fdata;
 	rte_graph_feature_data_t *f = NULL;
+	rte_graph_feature_t iter;
 	uint16_t index;

 	arc->runtime_enabled_features = 0;
@@ -349,6 +486,15 @@ feature_arc_data_reset(struct rte_graph_feature_arc *arc)
 		*f = RTE_GRAPH_FEATURE_DATA_INVALID;
 	}

+	for (iter = 0; iter < arc->max_features + NUM_EXTRA_FEATURE_DATA; iter++) {
+		first_fdata = fdata_fix_get(arc, iter, 0);
+		for (index = 0; index < arc->max_indexes; index++) {
+			fdata = rte_graph_feature_data_get(arc, first_fdata + index);
+			fdata->next_feature_data = RTE_GRAPH_FEATURE_DATA_INVALID;
+			fdata->app_cookie = UINT16_MAX;
+			fdata->next_edge = RTE_EDGE_ID_INVALID;
+		}
+	}
 	return 0;
 }

@@ -370,7 +516,6 @@ nodeinfo_lkup_by_name(struct rte_graph_feature_arc *arc, const char *feat_name,
 		*slot = UINT32_MAX;

 	STAILQ_FOREACH(finfo, &arc->all_features, next_feature) {
-		RTE_VERIFY(finfo->feature_arc == arc);
 		if (!strncmp(finfo->feature_name, feat_name, strlen(finfo->feature_name))) {
 			if (ffinfo)
 				*ffinfo = finfo;
@@ -398,7 +543,6 @@ nodeinfo_add_lookup(struct rte_graph_feature_arc *arc, const char *feat_node_nam
 		*slot = 0;

 	STAILQ_FOREACH(finfo, &arc->all_features, next_feature) {
-		RTE_VERIFY(finfo->feature_arc == arc);
 		if (!strncmp(finfo->feature_name, feat_node_name, strlen(finfo->feature_name))) {
 			if (ffinfo)
 				*ffinfo = finfo;
@@ -432,7 +576,7 @@ nodeinfo_lkup_by_index(struct rte_graph_feature_arc *arc, uint32_t feature_index
 		/* Check sanity */
 		if (do_sanity_check)
 			if (finfo->finfo_index != index)
-				RTE_VERIFY(0);
+				return -1;
 		if (index == feature_index) {
 			*ppfinfo = finfo;
 			return 0;
@@ -477,6 +621,102 @@ get_existing_edge(const char *arc_name, rte_node_t parent_node,
 	return -1;
 }

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
 /* feature arc sanity */
 static int
 feature_arc_sanity(rte_graph_feature_arc_t _arc)
@@ -586,6 +826,241 @@ feature_arc_main_init(rte_graph_feature_arc_main_t **pfl, uint32_t max_feature_a
 	return 0;
 }

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
+		if (nodeinfo_lkup_by_index(arc, fi, &finfo, 1) < 0) {
+			graph_err("[%s/index:%2u,cookie:%u]: No finfo found for index: %u",
+				  arc->feature_arc_name, index, gfd->app_cookie, fi);
+			return -1;
+		}
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
+			if (nodeinfo_lkup_by_index(arc, prev_fi, &prev_finfo, 1) < 0) {
+				graph_err("[%s/index:%2u,cookie:%u]: No prev_finfo found idx: %u",
+					  arc->feature_arc_name, index, gfd->app_cookie, prev_fi);
+				return -1;
+			}
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
+				graph_err("[%s/index:%2u,cookie:%u]: No edge found from %s to %s",
+					  arc->feature_arc_name, index, gfd->app_cookie,
+					  rte_node_id_to_name(prev_finfo->feature_node_id),
+					  rte_node_id_to_name(finfo->feature_node_id));
+				return -1;
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
 /* feature arc initialization, public API */
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_init, 25.07);
 int
@@ -1128,6 +1603,199 @@ rte_graph_feature_lookup(rte_graph_feature_arc_t _arc, const char *feature_name,
 	return -1;
 }

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
+		return -1;
+
+	gfd = rte_graph_feature_data_get(arc, fdata_reserve(arc, slot, index));
+
+	/* Set current app_cookie */
+	rte_atomic_store_explicit(&gfd->app_cookie, app_cookie, rte_memory_order_relaxed);
+
+	/* Set bitmask in control path bitmask */
+	rte_bit_relaxed_set64(graph_uint_cast(slot), &arc->feature_bit_mask_by_index[index]);
+
+	if (refill_fastpath_data(arc, slot, index, 1 /* enable */) < 0)
+		return -1;
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
+	if (refill_fastpath_data(arc, slot, index, 0 /* disable */) < 0)
+		return -1;
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
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_destroy, 25.07);
 int
 rte_graph_feature_arc_destroy(rte_graph_feature_arc_t _arc)
@@ -1135,6 +1803,8 @@ rte_graph_feature_arc_destroy(rte_graph_feature_arc_t _arc)
 	struct rte_graph_feature_arc *arc = rte_graph_feature_arc_get(_arc);
 	rte_graph_feature_arc_main_t *dm = __rte_graph_feature_arc_main;
 	struct rte_graph_feature_node_list *node_info = NULL;
+	struct rte_graph_feature_data *fdptr = NULL;
+	rte_graph_feature_data_t fdata;
 	int iter;

 	if (!arc) {
@@ -1153,11 +1823,28 @@ rte_graph_feature_arc_destroy(rte_graph_feature_arc_t _arc)
 				    RTE_BIT64(node_info->finfo_index)))
 					continue;

-				node_info->notifier_cb(arc->feature_arc_name,
-						       node_info->feature_name,
-						       node_info->feature_node_id,
-						       iter, false /* disable */,
-						       UINT16_MAX /* invalid cookie */);
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
 			}
 		}
 		rte_free(node_info);
@@ -1237,6 +1924,20 @@ rte_graph_feature_arc_lookup_by_name(const char *arc_name, rte_graph_feature_arc
 	return -1;
 }

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
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_graph_feature_arc_num_features, 25.07);
 uint32_t
 rte_graph_feature_arc_num_features(rte_graph_feature_arc_t _arc)
diff --git a/lib/graph/meson.build b/lib/graph/meson.build
index 6a6d570290..d48d49122d 100644
--- a/lib/graph/meson.build
+++ b/lib/graph/meson.build
@@ -27,4 +27,4 @@ indirect_headers += files(
         'rte_graph_worker_common.h',
 )

-deps += ['eal', 'pcapng', 'mempool', 'ring']
+deps += ['eal', 'pcapng', 'mempool', 'ring', 'rcu']
diff --git a/lib/graph/rte_graph_feature_arc.h b/lib/graph/rte_graph_feature_arc.h
index 49392f2e05..14f24be831 100644
--- a/lib/graph/rte_graph_feature_arc.h
+++ b/lib/graph/rte_graph_feature_arc.h
@@ -18,6 +18,7 @@
 #include <rte_compat.h>
 #include <rte_debug.h>
 #include <rte_graph.h>
+#include <rte_rcu_qsbr.h>

 #ifdef __cplusplus
 extern "C" {
@@ -49,7 +50,7 @@ extern "C" {
  * plane. Protocols enabled on one interface may not be enabled on another
  * interface.
  *
- * When more than one protocols are present at a networking layer (say IPv4,
+ * When more than one protocols are present in a networking layer (say IPv4,
  * IP tables, IPsec etc), it becomes imperative to steer packets (in dataplane)
  * across each protocol processing in a defined sequential order. In ingress
  * direction, stack decides to perform IPsec decryption first before IP
@@ -92,7 +93,9 @@ extern "C" {
  * A feature arc in a graph is represented via *start_node* and
  * *end_feature_node*.  Feature nodes are added between start_node and
  * end_feature_node. Packets enter feature arc path via start_node while they
- * exit from end_feature_node.
+ * exit from end_feature_node. Packets steering from start_node to feature
+ * nodes are controlled in control plane via rte_graph_feature_enable(),
+ * rte_graph_feature_disable().
  *
  * This library facilitates rte graph based applications to implement stack
  * functionalities described above by providing "edge" to the next enabled
@@ -101,7 +104,7 @@ extern "C" {
  * In order to use feature-arc APIs, applications needs to do following in
  * control plane:
  * - Create feature arc object using RTE_GRAPH_FEATURE_ARC_REGISTER()
- * - New feature nodes (In-built/Out-of-tree) can be added to an arc via
+ * - New feature nodes (In-built or out-of-tree) can be added to an arc via
  *   RTE_GRAPH_FEATURE_REGISTER(). RTE_GRAPH_FEATURE_REGISTER() has
  *   rte_graph_feature_register::runs_after and
  *   rte_graph_feature_register::runs_before to specify protocol
@@ -109,6 +112,8 @@ extern "C" {
  * - Before calling rte_graph_create(), rte_graph_feature_arc_init() API must
  *   be called. If rte_graph_feature_arc_init() is not called by application,
  *   feature arc library has no affect.
+ * - Features can be enabled/disabled on any index at runtime via
+ *   rte_graph_feature_enable(), rte_graph_feature_disable().
  * - Feature arc can be destroyed via rte_graph_feature_arc_destroy()
  *
  * If a given feature likes to control number of indexes (which is higher than
@@ -119,10 +124,66 @@ extern "C" {
  * maximum value returned by any of the feature is used for
  * rte_graph_feature_arc_create()
  *
+ * Before enabling a feature, control plane might allocate certain resources
+ * (like VRF table for IP lookup or IPsec SA for inbound policy etc). A
+ * reference of allocated resource can be passed from control plane to
+ * dataplane via *app_cookie* argument in @ref rte_graph_feature_enable(). A
+ * corresponding dataplane API @ref rte_graph_feature_data_app_cookie_get() can
+ * be used to retrieve same cookie in fast path.
+ *
+ * When a feature is disabled, resources allocated during feature enable can be
+ * safely released via registering a callback in
+ * rte_graph_feature_register::notifier_cb(). See fast path synchronization
+ * section below for more details.
+ *
+ * If current feature node is not consuming packet, it might want to send it to
+ * next enabled feature. Depending upon current node is a:
+ * - start_node (via @ref rte_graph_feature_data_first_feature_get())
+ * - feature nodes added between start_node and end_node (via @ref
+ *   rte_graph_feature_data_next_feature_get())
+ * - end_feature_node (must not call any feature arc steering APIs) as from
+ *   this node packet exits feature arc
+ *
+ * Above APIs deals with fast path object: feature_data (struct
+ * rte_graph_feature_data), which is unique for every index per feature with in
+ * a feature arc. It holds three data fields: next node edge, next enabled
+ * feature data and app_cookie.
+ *
+ * rte_mbuf carries [feature_data] into feature arc specific mbuf dynamic
+ * field. See @ref rte_graph_feature_arc_mbuf_dynfields and @ref
+ * rte_graph_feature_arc_mbuf_dynfields_get() for more details.
+ *
+ * Fast path synchronization
+ * -------------------------
+ * Any feature enable/disable in control plane does not require stopping of
+ * worker cores. rte_graph_feature_enable()/rte_graph_feature_disable() APIs
+ * are almost thread-safe avoiding any RCU usage. Only condition when race
+ * condition could occur is when application is trying to enable/disable
+ * feature very fast for [feature, index] combination. In that case,
+ * application should use rte_graph_feature_enable(),
+ * rte_graph_feature_disable() APIs with RCU argument
+ *
+ * RCU synchronization may also be required when application needs to free
+ * resources (using rte_graph_feature_register::notifier_cb()) which it may have
+ * allocated during feature enable. Resources can be freed only when no worker
+ * core is not acting on it.
+ *
+ * If RCU argument to rte_graph_feature_enable(), rte_graph_feature_disable()
+ * is non-NULL, as part of APIs:
+ *  - rte_rcu_qsbr_synchronize() is called to synchronize all worker cores
+ *  - If set, rte_graph_feature_register::notifier_cb() is called in which
+ *  application can safely release resources associated with [feature, index]
+ *
+ * It is application responsibility to pass valid RCU argument to APIs. It is
+ * recommended that application calls rte_rcu_qsbr_quiescent() after every
+ * iteration of rte_graph_walk()
+ *
  * Constraints
  * -----------
  *  - rte_graph_feature_arc_init(), rte_graph_feature_arc_create() and
  *  rte_graph_feature_add() must be called before rte_graph_create().
+ *  - rte_graph_feature_enable(), rte_graph_feature_disable() should be called
+ *  after rte_graph_create()
  *  - Not more than 63 features can be added to a feature arc. There is no
  *  limit to number of feature arcs i.e. number of
  *  RTE_GRAPH_FEATURE_ARC_REGISTER()
@@ -349,7 +410,7 @@ int rte_graph_feature_arc_create(struct rte_graph_feature_arc_register *reg,
  * Get feature arc object with name
  *
  * @param arc_name
- *   Feature arc name provided to successful @ref rte_graph_feature_arc_create
+ *   Feature arc name provided to successful @ref rte_graph_feature_arc_create()
  * @param[out] _arc
  *   Feature arc object returned. Valid only when API returns SUCCESS
  *
@@ -369,6 +430,9 @@ int rte_graph_feature_arc_lookup_by_name(const char *arc_name, rte_graph_feature
  * Pointer to struct rte_graph_feature_register
  *
  * <I> Must be called before rte_graph_create() </I>
+ * <I> rte_graph_feature_add() is not allowed after call to
+ * rte_graph_feature_enable() so all features must be added before they can be
+ * enabled </I>
  * <I> When called by application, then feature_node_id should be appropriately set as
  *     freg->feature_node_id = freg->feature_node->id;
  * </I>
@@ -380,14 +444,71 @@ int rte_graph_feature_arc_lookup_by_name(const char *arc_name, rte_graph_feature
 __rte_experimental
 int rte_graph_feature_add(struct rte_graph_feature_register *feat_reg);

+/**
+ * Enable feature within a feature arc
+ *
+ * Must be called after @b rte_graph_create().
+ *
+ * @param _arc
+ *   Feature arc object returned by @ref rte_graph_feature_arc_create() or @ref
+ *   rte_graph_feature_arc_lookup_by_name()
+ * @param index
+ *   Application specific index. Can be corresponding to interface_id/port_id etc
+ * @param feature_name
+ *   Name of the node which is already added via @ref rte_graph_feature_add()
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
+ *   Feature arc object returned by @ref rte_graph_feature_arc_create() or @ref
+ *   rte_graph_feature_arc_lookup_by_name()
+ * @param index
+ *   Application specific index. Can be corresponding to interface_id/port_id etc
+ * @param feature_name
+ *   Name of the node which is already added via @ref rte_graph_feature_add()
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
 /**
  * Get rte_graph_feature_t object from feature name
  *
  * @param arc
- *   Feature arc object returned by @ref rte_graph_feature_arc_create or @ref
- *   rte_graph_feature_arc_lookup_by_name
+ *   Feature arc object returned by @ref rte_graph_feature_arc_create() or @ref
+ *   rte_graph_feature_arc_lookup_by_name()
  * @param feature_name
- *   Feature name provided to @ref rte_graph_feature_add
+ *   Feature name provided to @ref rte_graph_feature_add()
  * @param[out] feature
  *   Feature object
  *
@@ -403,8 +524,8 @@ int rte_graph_feature_lookup(rte_graph_feature_arc_t arc, const char *feature_na
  * Delete feature_arc object
  *
  * @param _arc
- *   Feature arc object returned by @ref rte_graph_feature_arc_create or @ref
- *   rte_graph_feature_arc_lookup_by_name
+ *   Feature arc object returned by @ref rte_graph_feature_arc_create() or @ref
+ *   rte_graph_feature_arc_lookup_by_name()
  *
  * @return
  *  0: Success
@@ -435,6 +556,19 @@ int rte_graph_feature_arc_cleanup(void);
 __rte_experimental
 uint32_t rte_graph_feature_arc_num_features(rte_graph_feature_arc_t _arc);

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
 /**
  * Slow path API to get feature node name from rte_graph_feature_t object
  *
diff --git a/lib/graph/rte_graph_feature_arc_worker.h b/lib/graph/rte_graph_feature_arc_worker.h
index d086a0c0c1..9719e9255a 100644
--- a/lib/graph/rte_graph_feature_arc_worker.h
+++ b/lib/graph/rte_graph_feature_arc_worker.h
@@ -21,6 +21,7 @@
  *
  * Fast path Graph feature arc API
  */
+
 #ifdef __cplusplus
 extern "C" {
 #endif
@@ -34,6 +35,7 @@ struct rte_graph_feature_node_list {
 	/** Next feature */
 	STAILQ_ENTRY(rte_graph_feature_node_list) next_feature;

+	/** Name of the feature */
 	char feature_name[RTE_GRAPH_FEATURE_ARC_NAMELEN];

 	/** node id representing feature */
@@ -161,6 +163,45 @@ struct __rte_cache_aligned rte_graph_feature_arc {
 	 */
 	int mbuf_dyn_offset;

+	/** Fast path arc data starts */
+	/*
+	 * Arc specific fast path data
+	 * It accommodates:
+	 *
+	 *	1. first enabled feature data for every index (rte_graph_feature_data_t or fdata)
+	 *	+--------------------------------------------------------------+ <- cache_aligned
+	 *	|  0th Index    | 1st Index   |  ... | max_index - 1           |
+	 *	+--------------------------------------------------------------+
+	 *	|  Startfdata0  | Startfdata1 |  ... | Startfdata(max_index-1) |
+	 *	+--------------------------------------------------------------+
+	 *
+	 *	2. struct rte_graph_feature_data per index per feature
+	 *	+----------------------------------------+ ^ <- Start (Reserved, cache aligned)
+	 *	|  struct rte_graph_feature_data[Index0] | |
+	 *	+----------------------------------------+ | feature_size
+	 *	|  struct rte_graph_feature_data[Index1] | |
+	 *	+----------------------------------------+ ^ <- Feature-0 (cache_aligned)
+	 *	|  struct rte_graph_feature_data[Index0] | |
+	 *	+----------------------------------------+ | feature_size
+	 *	|  struct rte_graph_feature_data[Index1] | |
+	 *	+----------------------------------------+ v <- Feature-1 (cache aligned)
+	 *	|  struct rte_graph_feature_data[Index0] | ^
+	 *	+----------------------------------------+ | feature_size
+	 *	|  struct rte_graph_feature_data[Index1] | |
+	 *	+----------------------------------------+ v
+	 *	|         ...            ....            |
+	 *	|         ...            ....            |
+	 *	|         ...            ....            |
+	 *	+----------------------------------------+ v <- Feature Index-1 (cache aligned)
+	 *	|  struct rte_graph_feature_data[Index0] | ^
+	 *	+----------------------------------------+ | feature_size
+	 *	|  struct rte_graph_feature_data[Index1] | |
+	 *	+----------------------------------------+ v <- Extra (Reserved, cache aligned)
+	 *	|  struct rte_graph_feature_data[Index0] | ^
+	 *	+----------------------------------------+ | feature_size
+	 *	|  struct rte_graph_feature_data[Index1] | |
+	 *	+----------------------------------------+ v
+	 */
 	RTE_MARKER8 fp_arc_data;
 };

@@ -195,13 +236,15 @@ typedef struct rte_feature_arc_main {
  *  It holds
  *  - edge to reach to next feature node
  *  - next_feature_data corresponding to next enabled feature
+ *  - app_cookie set by application in rte_graph_feature_enable()
  */
 struct rte_graph_feature_data {
 	/** edge from this feature node to next enabled feature node */
 	RTE_ATOMIC(rte_edge_t) next_edge;

 	/**
-	 * app_cookie
+	 * app_cookie set by application in rte_graph_feature_enable() for
+	 * current feature data
 	 */
 	RTE_ATOMIC(uint16_t) app_cookie;

@@ -218,6 +261,18 @@ struct rte_graph_feature_arc_mbuf_dynfields {
 /** Name of dynamic mbuf field offset registered in rte_graph_feature_arc_init() */
 #define RTE_GRAPH_FEATURE_ARC_DYNFIELD_NAME    "__rte_graph_feature_arc_mbuf_dynfield"

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
 /**
  * @internal macro
  */
@@ -273,6 +328,23 @@ rte_graph_feature_is_valid(rte_graph_feature_t feature)
 	return (feature != RTE_GRAPH_FEATURE_INVALID);
 }

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
 /**
  * Get pointer to feature arc object from rte_graph_feature_arc_t
  *
@@ -299,6 +371,253 @@ rte_graph_feature_arc_get(rte_graph_feature_arc_t arc)
 		NULL : (struct rte_graph_feature_arc *)fa;
 }

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
+	struct rte_graph_feature_data *fdata_obj = ((struct rte_graph_feature_data *)
+						    ((uint8_t *)arc + arc->fp_feature_data_offset +
+						    (fdata << RTE_GRAPH_FEATURE_DATA_SIZE_LOG2)));
+
+
+	return rte_atomic_load_explicit(&fdata_obj->app_cookie, rte_memory_order_relaxed);
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
+	struct rte_graph_feature_data *fdptr = ((struct rte_graph_feature_data *)
+						((uint8_t *)arc + arc->fp_feature_data_offset +
+						((*fdata) << RTE_GRAPH_FEATURE_DATA_SIZE_LOG2)));
+	*fdata = rte_atomic_load_explicit(&fdptr->next_feature_data, rte_memory_order_relaxed);
+	*next_edge = rte_atomic_load_explicit(&fdptr->next_edge, rte_memory_order_relaxed);
+
+
+	return ((*fdata) != RTE_GRAPH_FEATURE_DATA_INVALID);
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
+	if (fdata != RTE_GRAPH_FEATURE_DATA_INVALID)
+		return ((struct rte_graph_feature_data *)
+			((uint8_t *)arc + arc->fp_feature_data_offset +
+			(fdata << RTE_GRAPH_FEATURE_DATA_SIZE_LOG2)));
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
+	if ((*fd) != RTE_GRAPH_FEATURE_DATA_INVALID) {
+		fdata_obj = ((struct rte_graph_feature_data *)
+			     ((uint8_t *)arc + arc->fp_feature_data_offset +
+			     ((*fd) << RTE_GRAPH_FEATURE_DATA_SIZE_LOG2)));
+
+		*edge = rte_atomic_load_explicit(&fdata_obj->next_edge,
+						 rte_memory_order_relaxed);
+
+		*fdata = rte_atomic_load_explicit(&fdata_obj->next_feature_data,
+						  rte_memory_order_relaxed);
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
+	struct rte_graph_feature_data *fdata_obj = ((struct rte_graph_feature_data *)
+						    ((uint8_t *)arc + arc->fp_feature_data_offset +
+						    (fdata << RTE_GRAPH_FEATURE_DATA_SIZE_LOG2)));
+	rte_prefetch0((void *)fdata_obj);
+}
+
 #ifdef __cplusplus
 }
 #endif
--
2.43.0

