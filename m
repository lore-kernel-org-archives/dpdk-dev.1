Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE701D3B7EA
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Dec 2025 08:50:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC95C4067D;
	Tue,  9 Dec 2025 09:50:51 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8A83A40674
 for <dev@dpdk.org>; Tue,  9 Dec 2025 09:50:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765270249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H+MqkVVDbhjwI94oZxoRasuPDWh1eK5OgSXUOmPJtp8=;
 b=fxibVLbm4EyumjxMdJYTd8pHoTtfS38Ze3OmTcSWlQrNOHOCjb+RO/3JIG2jrZWrZGBTWb
 A8Lm68Vr6s3vjrwTmjWlGESJqzDbRr4UWidjde5oLrhTyBFinjUMJ72H0djRdRfZ0oIvIR
 rSCuwa3S3Z2TGCcQKQX5gsu8z2ag+5s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-SZGBhxQJPeiJ3UcAtcEq7Q-1; Tue,
 09 Dec 2025 03:50:44 -0500
X-MC-Unique: SZGBhxQJPeiJ3UcAtcEq7Q-1
X-Mimecast-MFC-AGG-ID: SZGBhxQJPeiJ3UcAtcEq7Q_1765270243
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3229B1800669; Tue,  9 Dec 2025 08:50:43 +0000 (UTC)
Received: from ringo.home (unknown [10.45.225.153])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4DCB21800451; Tue,  9 Dec 2025 08:50:41 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org, Jerin Jacob <jerinj@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: [PATCH dpdk 2/2] graph: allow enabling/disabling node visit cycles
 collection
Date: Tue,  9 Dec 2025 09:50:31 +0100
Message-ID: <20251209085028.115203-6-rjarry@redhat.com>
In-Reply-To: <20251209085028.115203-4-rjarry@redhat.com>
References: <20251209085028.115203-4-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cJ3KhnwWUWzLrCX5XImGDl8NZNCbwh8LXSXuvJv3HaQ_1765270243
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Add a new rte_graph_cycle_stats_enable() function to control whether
rte_rdtsc() is called twice for each node visit in order to collect the
number of cycles spent in each node process callback.

The default value remains the same as before and is fixed by the compile
time value RTE_LIBRTE_GRAPH_STATS.

Signed-off-by: Robin Jarry <rjarry@redhat.com>
---
 lib/graph/graph_populate.c          |  1 +
 lib/graph/rte_graph_worker_common.h | 18 ++++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/lib/graph/graph_populate.c b/lib/graph/graph_populate.c
index 026daecb2122..e51e3b39e24a 100644
--- a/lib/graph/graph_populate.c
+++ b/lib/graph/graph_populate.c
@@ -64,6 +64,7 @@ graph_header_popluate(struct graph *_graph)
 	graph->nb_nodes = _graph->node_count;
 	graph->cir_start = RTE_PTR_ADD(graph, _graph->cir_start);
 	graph->nodes_start = _graph->nodes_start;
+	graph->cycles_stats = rte_graph_has_stats_feature();
 	graph->socket = _graph->socket;
 	graph->id = _graph->id;
 	memcpy(graph->name, _graph->name, RTE_GRAPH_NAMESIZE);
diff --git a/lib/graph/rte_graph_worker_common.h b/lib/graph/rte_graph_worker_common.h
index c87a6796a96e..4161fc4b02e7 100644
--- a/lib/graph/rte_graph_worker_common.h
+++ b/lib/graph/rte_graph_worker_common.h
@@ -56,7 +56,7 @@ struct __rte_cache_aligned rte_graph {
 	rte_graph_off_t *cir_start;  /**< Pointer to circular buffer. */
 	rte_graph_off_t nodes_start; /**< Offset at which node memory starts. */
 	uint8_t model;		     /**< graph model */
-	uint8_t reserved1;	     /**< Reserved for future use. */
+	uint8_t cycles_stats;	     /**< Reserved for future use. */
 	uint16_t reserved2;	     /**< Reserved for future use. */
 	union {
 		/* Fast schedule area for mcore dispatch model */
@@ -205,7 +205,7 @@ __rte_node_process(struct rte_graph *graph, struct rte_node *node)
 	objs = node->objs;
 	rte_prefetch0(objs);
 
-	if (rte_graph_has_stats_feature()) {
+	if (graph->cycles_stats) {
 		start = rte_rdtsc();
 		rc = node->process(graph, node, objs, node->idx);
 		node->total_cycles += rte_rdtsc() - start;
@@ -560,6 +560,20 @@ rte_graph_model_is_valid(uint8_t model);
  */
 int rte_graph_worker_model_set(uint8_t model);
 
+/**
+ * Enable/disable collecting of TSC cycles for each node visit. The default
+ * value for all new or cloned graphs is equal to rte_graph_has_stats_feature()
+ * which is set to the RTE_LIBRTE_GRAPH_STATS compile time constant.
+ *
+ * @param enabled
+ *   Set to 1 to enable, 0 to disable.
+ */
+static inline void
+rte_graph_cycle_stats_enable(struct rte_graph *graph, uint8_t enabled)
+{
+	graph->cycles_stats = enabled;
+}
+
 /**
  * Get the graph worker model
  *
-- 
2.52.0

