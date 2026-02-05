Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C24E9129A
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 09:27:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE26340E3F;
	Thu,  5 Feb 2026 10:27:27 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id C37984026D
 for <dev@dpdk.org>; Thu,  5 Feb 2026 10:27:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770283646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=46oRRSKrtz3LrX+WVLFu3HQZP7CAjvWXZd8gQstbg6Y=;
 b=SrqUj9XTBBmIgawBsuw787SPEq+U2vqGaRoCKv/8my+sPRNN83BbsuowUQTBC5lTAFV//W
 lm4VCYi6JoU6KmmWeIsAHyqEOS++eRnHHaDvgjGhAB0vNuqPGv6dIlL3Hu8wCAriNGEH7D
 PnFha1IBghRnb+RZbIxcDS5H6wwVAWc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-2qxksZdUNO-X24VF_Mwb-w-1; Thu,
 05 Feb 2026 04:27:20 -0500
X-MC-Unique: 2qxksZdUNO-X24VF_Mwb-w-1
X-Mimecast-MFC-AGG-ID: 2qxksZdUNO-X24VF_Mwb-w_1770283639
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A79FC1955E7E; Thu,  5 Feb 2026 09:27:18 +0000 (UTC)
Received: from ringo.home (unknown [10.44.33.219])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 314A5300DDA1; Thu,  5 Feb 2026 09:27:14 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org, Sunil Kumar Kori <skori@marvell.com>,
 Rakesh Kudurumalla <rkudurumalla@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: Jerin Jacob <jerinj@marvell.com>
Subject: [RFC PATCH dpdk 3/3] node: use deferred enqueue API in process
 functions
Date: Thu,  5 Feb 2026 10:26:36 +0100
Message-ID: <20260205092630.100488-10-rjarry@redhat.com>
In-Reply-To: <20260205092630.100488-6-rjarry@redhat.com>
References: <20260205092630.100488-6-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EBEUBbCpQxOc4BZ3ziHD2T7VDXzlK3LJ8FTnrpBq7tM_1770283639
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

Convert all node process functions to use rte_node_enqueue_deferred()
instead of the manual speculation pattern with rte_node_enqueue_x1().

The deferred enqueue API automatically batches consecutive packets going
to the same edge and flushes them efficiently. When all packets go to
the same destination (the common case), it uses rte_node_next_stream_move()
which swaps pointers rather than copying.

This significantly simplifies the node process functions by removing
the speculation tracking logic (to_next, from, held, last_spec variables,
memcpy calls, and stream get/put operations).

The deferred state is stored in the node fast-path cache line, keeping
it close to other frequently accessed node data. The last_edge value
is preserved across invocations, providing cross-batch speculation for
free.

Performance testing with l3fwd on two E810 NICs shows throughput within
2-3% of the baseline while significantly reducing code complexity. The
slight overhead comes from per-packet edge comparisons, but this is
offset by reduced instruction cache pressure and simpler code paths.

Also remove unused speculation-related macros and fields from node
context structures:
- IP4_REWRITE_NODE_LAST_NEXT and next_index field
- IP6_REWRITE_NODE_LAST_NEXT and next_index field
- IF_TX_FEATURE_LAST_NEXT_INDEX and last_index field
- UDP4_INPUT_NODE_NEXT_INDEX and next_index field

Signed-off-by: Robin Jarry <rjarry@redhat.com>
---
 app/graph/ip4_output_hook.c     |  35 +--------
 lib/node/interface_tx_feature.c | 105 +++-----------------------
 lib/node/ip4_local.c            |  36 +--------
 lib/node/ip4_lookup.c           |  37 +--------
 lib/node/ip4_lookup_fib.c       |  36 +--------
 lib/node/ip4_lookup_neon.h      | 100 +++---------------------
 lib/node/ip4_lookup_sse.h       | 100 +++---------------------
 lib/node/ip4_rewrite.c          | 120 +++--------------------------
 lib/node/ip6_lookup.c           |  95 +++--------------------
 lib/node/ip6_lookup_fib.c       |  34 +--------
 lib/node/ip6_rewrite.c          | 118 +++--------------------------
 lib/node/pkt_cls.c              | 130 +++-----------------------------
 lib/node/udp4_input.c           |  42 +----------
 13 files changed, 81 insertions(+), 907 deletions(-)

diff --git a/app/graph/ip4_output_hook.c b/app/graph/ip4_output_hook.c
index 8757f294cb41..df048aacd22e 100644
--- a/app/graph/ip4_output_hook.c
+++ b/app/graph/ip4_output_hook.c
@@ -51,50 +51,19 @@ __app_graph_ip4_output_hook_node_process(struct rte_graph *graph, struct rte_nod
 	struct rte_graph_feature_arc *arc =
 		rte_graph_feature_arc_get(OUTPUT_HOOK_FEATURE_ARC(node->ctx));
 	struct rte_graph_feature_arc_mbuf_dynfields *mbfields = NULL;
-	uint16_t next = OUTPUT_HOOK_PKT_DROP;
-	void **to_next, **from;
-	uint16_t last_spec = 0;
-	rte_edge_t next_index;
 	struct rte_mbuf *mbuf;
-	uint16_t held = 0;
+	rte_edge_t next;
 	int i;
 
-	/* Speculative next */
-	next_index = OUTPUT_HOOK_LAST_NEXT_INDEX(node->ctx);
-
-	from = objs;
-	to_next = rte_node_next_stream_get(graph, node, next_index, nb_objs);
 	for (i = 0; i < nb_objs; i++) {
-
 		mbuf = (struct rte_mbuf *)objs[i];
 
 		/* Send mbuf to next enabled feature */
 		mbfields = rte_graph_feature_arc_mbuf_dynfields_get(mbuf, arc->mbuf_dyn_offset);
 		rte_graph_feature_data_next_feature_get(arc, &mbfields->feature_data, &next);
 
-		if (unlikely(next_index != next)) {
-			/* Copy things successfully speculated till now */
-			rte_memcpy(to_next, from, last_spec * sizeof(from[0]));
-			from += last_spec;
-			to_next += last_spec;
-			held += last_spec;
-			last_spec = 0;
-
-			rte_node_enqueue_x1(graph, node, next, from[0]);
-			from += 1;
-		} else {
-			last_spec += 1;
-		}
+		rte_node_enqueue_deferred(graph, node, next, i);
 	}
-	/* !!! Home run !!! */
-	if (likely(last_spec == nb_objs)) {
-		rte_node_next_stream_move(graph, node, next_index);
-		return nb_objs;
-	}
-	held += last_spec;
-	rte_memcpy(to_next, from, last_spec * sizeof(from[0]));
-	rte_node_next_stream_put(graph, node, next_index, held);
-	OUTPUT_HOOK_LAST_NEXT_INDEX(node->ctx) = next;
 
 	return nb_objs;
 }
diff --git a/lib/node/interface_tx_feature.c b/lib/node/interface_tx_feature.c
index c8809d5f913a..8b226cc1e27f 100644
--- a/lib/node/interface_tx_feature.c
+++ b/lib/node/interface_tx_feature.c
@@ -14,8 +14,6 @@
 #include "node_private.h"
 #include "interface_tx_feature_priv.h"
 
-#define IF_TX_FEATURE_LAST_NEXT_INDEX(ctx) \
-	(((struct if_tx_feature_node_ctx *)ctx)->last_index)
 /*
  * @internal array for mapping port to next node index
  */
@@ -23,10 +21,6 @@ struct if_tx_feature_node_main  {
 	uint16_t next_index[RTE_MAX_ETHPORTS];
 };
 
-struct if_tx_feature_node_ctx {
-	uint16_t last_index;
-};
-
 static struct if_tx_feature_node_main *if_tx_feature_nm;
 
 int
@@ -48,9 +42,7 @@ static int
 if_tx_feature_node_init(const struct rte_graph *graph, struct rte_node *node)
 {
 	RTE_SET_USED(graph);
-
-	/* pkt_drop */
-	IF_TX_FEATURE_LAST_NEXT_INDEX(node->ctx) = 0;
+	RTE_SET_USED(node);
 
 	return 0;
 }
@@ -59,21 +51,15 @@ static uint16_t
 if_tx_feature_node_process(struct rte_graph *graph, struct rte_node *node,
 			   void **objs, uint16_t nb_objs)
 {
-	uint16_t held = 0, next0 = 0, next1 = 0, next2 = 0, next3 = 0;
 	struct rte_mbuf *mbuf0, *mbuf1, *mbuf2, *mbuf3, **pkts;
-	uint16_t last_spec = 0, fix_spec = 0;
-	void **to_next, **from;
-	rte_edge_t next_index;
+	rte_edge_t next0, next1, next2, next3;
 	uint16_t n_left_from;
+	int i;
 
-	/* Speculative next */
-	next_index = IF_TX_FEATURE_LAST_NEXT_INDEX(node->ctx);
-
-	from = objs;
 	n_left_from = nb_objs;
 	pkts = (struct rte_mbuf **)objs;
 
-	to_next = rte_node_next_stream_get(graph, node, next_index, nb_objs);
+	i = 0;
 	while (n_left_from > 4) {
 		if (likely(n_left_from > 7)) {
 			/* Prefetch next mbuf */
@@ -95,57 +81,11 @@ if_tx_feature_node_process(struct rte_graph *graph, struct rte_node *node,
 		next2 = if_tx_feature_nm->next_index[mbuf2->port];
 		next3 = if_tx_feature_nm->next_index[mbuf3->port];
 
-		fix_spec = (next_index ^ next0) | (next_index ^ next1) |
-			(next_index ^ next2) | (next_index ^ next3);
-
-		if (unlikely(fix_spec)) {
-			/* Copy things successfully speculated till now */
-			rte_memcpy(to_next, from,
-				   last_spec * sizeof(from[0]));
-			from += last_spec;
-			to_next += last_spec;
-			held += last_spec;
-			last_spec = 0;
-
-			if (next0 == next_index) {
-				to_next[0] = from[0];
-				to_next++;
-				held++;
-			} else {
-				rte_node_enqueue_x1(graph, node,
-						    next0, from[0]);
-			}
-
-			if (next1 == next_index) {
-				to_next[0] = from[1];
-				to_next++;
-				held++;
-			} else {
-				rte_node_enqueue_x1(graph, node,
-						    next1, from[1]);
-			}
-
-			if (next2 == next_index) {
-				to_next[0] = from[2];
-				to_next++;
-				held++;
-			} else {
-				rte_node_enqueue_x1(graph, node,
-						    next2, from[2]);
-			}
-
-			if (next3 == next_index) {
-				to_next[0] = from[3];
-				to_next++;
-				held++;
-			} else {
-				rte_node_enqueue_x1(graph, node,
-						    next3, from[3]);
-			}
-			from += 4;
-		} else {
-			last_spec += 4;
-		}
+		rte_node_enqueue_deferred(graph, node, next0, i);
+		rte_node_enqueue_deferred(graph, node, next1, i + 1);
+		rte_node_enqueue_deferred(graph, node, next2, i + 2);
+		rte_node_enqueue_deferred(graph, node, next3, i + 3);
+		i += 4;
 	}
 
 	while (n_left_from > 0) {
@@ -155,34 +95,11 @@ if_tx_feature_node_process(struct rte_graph *graph, struct rte_node *node,
 		n_left_from -= 1;
 
 		next0 = if_tx_feature_nm->next_index[mbuf0->port];
-		if (unlikely(next0 != next_index)) {
-			/* Copy things successfully speculated till now */
-			rte_memcpy(to_next, from,
-				   last_spec * sizeof(from[0]));
-			from += last_spec;
-			to_next += last_spec;
-			held += last_spec;
-			last_spec = 0;
 
-			rte_node_enqueue_x1(graph, node,
-					    next0, from[0]);
-			from += 1;
-		} else {
-			last_spec += 1;
-		}
+		rte_node_enqueue_deferred(graph, node, next0, i);
+		i += 1;
 	}
 
-	/* !!! Home run !!! */
-	if (likely(last_spec == nb_objs)) {
-		rte_node_next_stream_move(graph, node, next_index);
-		return nb_objs;
-	}
-	held += last_spec;
-	rte_memcpy(to_next, from, last_spec * sizeof(from[0]));
-	rte_node_next_stream_put(graph, node, next_index, held);
-
-	IF_TX_FEATURE_LAST_NEXT_INDEX(node->ctx) = next0;
-
 	return nb_objs;
 }
 
diff --git a/lib/node/ip4_local.c b/lib/node/ip4_local.c
index 288f9399ff34..c15af6efbf3e 100644
--- a/lib/node/ip4_local.c
+++ b/lib/node/ip4_local.c
@@ -24,51 +24,21 @@ static uint16_t
 ip4_local_node_process_scalar(struct rte_graph *graph, struct rte_node *node,
 			      void **objs, uint16_t nb_objs)
 {
-	void **to_next, **from;
-	uint16_t last_spec = 0;
-	rte_edge_t next_index;
 	struct rte_mbuf *mbuf;
-	uint16_t held = 0;
+	rte_edge_t next;
 	uint32_t l4;
 	int i;
 
-	/* Speculative next */
-	next_index = RTE_NODE_IP4_LOCAL_NEXT_UDP4_INPUT;
-
-	from = objs;
-	to_next = rte_node_next_stream_get(graph, node, next_index, nb_objs);
 	for (i = 0; i < nb_objs; i++) {
-		uint16_t next;
-
 		mbuf = (struct rte_mbuf *)objs[i];
 		l4 = mbuf->packet_type & RTE_PTYPE_L4_MASK;
 
 		next = (l4 == RTE_PTYPE_L4_UDP)
-				? next_index
+				? RTE_NODE_IP4_LOCAL_NEXT_UDP4_INPUT
 				: RTE_NODE_IP4_LOCAL_NEXT_PKT_DROP;
 
-		if (unlikely(next_index != next)) {
-			/* Copy things successfully speculated till now */
-			rte_memcpy(to_next, from, last_spec * sizeof(from[0]));
-			from += last_spec;
-			to_next += last_spec;
-			held += last_spec;
-			last_spec = 0;
-
-			rte_node_enqueue_x1(graph, node, next, from[0]);
-			from += 1;
-		} else {
-			last_spec += 1;
-		}
+		rte_node_enqueue_deferred(graph, node, next, i);
 	}
-	/* !!! Home run !!! */
-	if (likely(last_spec == nb_objs)) {
-		rte_node_next_stream_move(graph, node, next_index);
-		return nb_objs;
-	}
-	held += last_spec;
-	rte_memcpy(to_next, from, last_spec * sizeof(from[0]));
-	rte_node_next_stream_put(graph, node, next_index, held);
 
 	return nb_objs;
 }
diff --git a/lib/node/ip4_lookup.c b/lib/node/ip4_lookup.c
index f6db3219f06b..196a7f3079eb 100644
--- a/lib/node/ip4_lookup.c
+++ b/lib/node/ip4_lookup.c
@@ -53,25 +53,16 @@ ip4_lookup_node_process_scalar(struct rte_graph *graph, struct rte_node *node,
 	struct rte_lpm *lpm = IP4_LOOKUP_NODE_LPM(node->ctx);
 	const int dyn = IP4_LOOKUP_NODE_PRIV1_OFF(node->ctx);
 	struct rte_ipv4_hdr *ipv4_hdr;
-	void **to_next, **from;
-	uint16_t last_spec = 0;
 	struct rte_mbuf *mbuf;
-	rte_edge_t next_index;
-	uint16_t held = 0;
 	uint32_t drop_nh;
 	int i, rc;
 
-	/* Speculative next */
-	next_index = RTE_NODE_IP4_LOOKUP_NEXT_REWRITE;
 	/* Drop node */
 	drop_nh = ((uint32_t)RTE_NODE_IP4_LOOKUP_NEXT_PKT_DROP) << 16;
-	from = objs;
 
-	/* Get stream for the speculated next node */
-	to_next = rte_node_next_stream_get(graph, node, next_index, nb_objs);
 	for (i = 0; i < nb_objs; i++) {
 		uint32_t next_hop;
-		uint16_t next;
+		rte_edge_t next;
 
 		mbuf = (struct rte_mbuf *)objs[i];
 
@@ -88,33 +79,11 @@ ip4_lookup_node_process_scalar(struct rte_graph *graph, struct rte_node *node,
 		NODE_INCREMENT_XSTAT_ID(node, 0, rc != 0, 1);
 
 		node_mbuf_priv1(mbuf, dyn)->nh = (uint16_t)next_hop;
-		next_hop = next_hop >> 16;
-		next = (uint16_t)next_hop;
+		next = (uint16_t)(next_hop >> 16);
 
-		if (unlikely(next_index != next)) {
-			/* Copy things successfully speculated till now */
-			rte_memcpy(to_next, from, last_spec * sizeof(from[0]));
-			from += last_spec;
-			to_next += last_spec;
-			held += last_spec;
-			last_spec = 0;
-
-			rte_node_enqueue_x1(graph, node, next, from[0]);
-			from += 1;
-		} else {
-			last_spec += 1;
-		}
+		rte_node_enqueue_deferred(graph, node, next, i);
 	}
 
-	/* !!! Home run !!! */
-	if (likely(last_spec == nb_objs)) {
-		rte_node_next_stream_move(graph, node, next_index);
-		return nb_objs;
-	}
-	held += last_spec;
-	rte_memcpy(to_next, from, last_spec * sizeof(from[0]));
-	rte_node_next_stream_put(graph, node, next_index, held);
-
 	return nb_objs;
 }
 
diff --git a/lib/node/ip4_lookup_fib.c b/lib/node/ip4_lookup_fib.c
index 0857d889fca6..9c66a021f7b9 100644
--- a/lib/node/ip4_lookup_fib.c
+++ b/lib/node/ip4_lookup_fib.c
@@ -51,24 +51,13 @@ ip4_lookup_fib_node_process(struct rte_graph *graph, struct rte_node *node, void
 	uint32_t ip[RTE_GRAPH_BURST_SIZE];
 	struct rte_ipv4_hdr *ipv4_hdr;
 	uint16_t lookup_err = 0;
-	void **to_next, **from;
-	uint16_t last_spec = 0;
-	rte_edge_t next_index;
 	uint16_t n_left_from;
-	uint16_t held = 0;
-	uint16_t next;
+	rte_edge_t next;
 	int i;
 
-	/* Speculative next */
-	next_index = RTE_NODE_IP4_LOOKUP_NEXT_REWRITE;
-
 	pkts = (struct rte_mbuf **)objs;
-	from = objs;
 	n_left_from = nb_objs;
 
-	/* Get stream for the speculated next node */
-	to_next = rte_node_next_stream_get(graph, node, next_index, nb_objs);
-
 	for (i = 0; i < 4 && i < n_left_from; i++)
 		rte_prefetch0(rte_pktmbuf_mtod_offset(pkts[i], void *,
 					sizeof(struct rte_ether_hdr)));
@@ -161,34 +150,13 @@ ip4_lookup_fib_node_process(struct rte_graph *graph, struct rte_node *node, void
 		node_mbuf_priv1(mbuf0, dyn)->nh = (uint16_t)next_hop[i];
 		next = (uint16_t)(next_hop[i] >> 16);
 
-		if (unlikely(next_index ^ next)) {
-			/* Copy things successfully speculated till now */
-			rte_memcpy(to_next, from, last_spec * sizeof(from[0]));
-			from += last_spec;
-			to_next += last_spec;
-			held += last_spec;
-			last_spec = 0;
-
-			rte_node_enqueue_x1(graph, node, next, from[0]);
-			from += 1;
-		} else {
-			last_spec += 1;
-		}
-
 		if (unlikely(next_hop[i] == FIB_DEFAULT_NH))
 			lookup_err += 1;
-	}
 
-	/* !!! Home run !!! */
-	if (likely(last_spec == nb_objs)) {
-		rte_node_next_stream_move(graph, node, next_index);
-		return nb_objs;
+		rte_node_enqueue_deferred(graph, node, next, i);
 	}
 
 	NODE_INCREMENT_XSTAT_ID(node, 0, lookup_err != 0, lookup_err);
-	held += last_spec;
-	rte_memcpy(to_next, from, last_spec * sizeof(from[0]));
-	rte_node_next_stream_put(graph, node, next_index, held);
 
 	return nb_objs;
 }
diff --git a/lib/node/ip4_lookup_neon.h b/lib/node/ip4_lookup_neon.h
index 1bc4ad655461..45831deb8c06 100644
--- a/lib/node/ip4_lookup_neon.h
+++ b/lib/node/ip4_lookup_neon.h
@@ -14,11 +14,7 @@ ip4_lookup_node_process_vec(struct rte_graph *graph, struct rte_node *node,
 	struct rte_lpm *lpm = IP4_LOOKUP_NODE_LPM(node->ctx);
 	const int dyn = IP4_LOOKUP_NODE_PRIV1_OFF(node->ctx);
 	struct rte_ipv4_hdr *ipv4_hdr;
-	void **to_next, **from;
-	uint16_t last_spec = 0;
-	rte_edge_t next_index;
 	uint16_t n_left_from;
-	uint16_t held = 0;
 	uint32_t drop_nh;
 	rte_xmm_t result;
 	rte_xmm_t priv01;
@@ -26,13 +22,10 @@ ip4_lookup_node_process_vec(struct rte_graph *graph, struct rte_node *node,
 	int32x4_t dip;
 	int rc, i;
 
-	/* Speculative next */
-	next_index = RTE_NODE_IP4_LOOKUP_NEXT_REWRITE;
 	/* Drop node */
 	drop_nh = ((uint32_t)RTE_NODE_IP4_LOOKUP_NEXT_PKT_DROP) << 16;
 
 	pkts = (struct rte_mbuf **)objs;
-	from = objs;
 	n_left_from = nb_objs;
 
 	for (i = OBJS_PER_CLINE; i < RTE_GRAPH_BURST_SIZE; i += OBJS_PER_CLINE)
@@ -43,8 +36,7 @@ ip4_lookup_node_process_vec(struct rte_graph *graph, struct rte_node *node,
 						sizeof(struct rte_ether_hdr)));
 
 	dip = vdupq_n_s32(0);
-	/* Get stream for the speculated next node */
-	to_next = rte_node_next_stream_get(graph, node, next_index, nb_objs);
+	i = 0;
 	while (n_left_from >= 4) {
 #if RTE_GRAPH_BURST_SIZE > 64
 		/* Prefetch next-next mbufs */
@@ -126,64 +118,11 @@ ip4_lookup_node_process_vec(struct rte_graph *graph, struct rte_node *node,
 		node_mbuf_priv1(mbuf2, dyn)->u = priv23.u64[0];
 		node_mbuf_priv1(mbuf3, dyn)->u = priv23.u64[1];
 
-		/* Enqueue four to next node */
-		rte_edge_t fix_spec = ((next_index == result.u16[1]) &&
-				       (result.u16[1] == result.u16[3]) &&
-				       (result.u16[3] == result.u16[5]) &&
-				       (result.u16[5] == result.u16[7]));
-
-		if (unlikely(fix_spec == 0)) {
-			/* Copy things successfully speculated till now */
-			rte_memcpy(to_next, from, last_spec * sizeof(from[0]));
-			from += last_spec;
-			to_next += last_spec;
-			held += last_spec;
-			last_spec = 0;
-
-			/* Next0 */
-			if (next_index == result.u16[1]) {
-				to_next[0] = from[0];
-				to_next++;
-				held++;
-			} else {
-				rte_node_enqueue_x1(graph, node, result.u16[1],
-						    from[0]);
-			}
-
-			/* Next1 */
-			if (next_index == result.u16[3]) {
-				to_next[0] = from[1];
-				to_next++;
-				held++;
-			} else {
-				rte_node_enqueue_x1(graph, node, result.u16[3],
-						    from[1]);
-			}
-
-			/* Next2 */
-			if (next_index == result.u16[5]) {
-				to_next[0] = from[2];
-				to_next++;
-				held++;
-			} else {
-				rte_node_enqueue_x1(graph, node, result.u16[5],
-						    from[2]);
-			}
-
-			/* Next3 */
-			if (next_index == result.u16[7]) {
-				to_next[0] = from[3];
-				to_next++;
-				held++;
-			} else {
-				rte_node_enqueue_x1(graph, node, result.u16[7],
-						    from[3]);
-			}
-
-			from += 4;
-		} else {
-			last_spec += 4;
-		}
+		rte_node_enqueue_deferred(graph, node, result.u16[1], i);
+		rte_node_enqueue_deferred(graph, node, result.u16[3], i + 1);
+		rte_node_enqueue_deferred(graph, node, result.u16[5], i + 2);
+		rte_node_enqueue_deferred(graph, node, result.u16[7], i + 3);
+		i += 4;
 	}
 
 	while (n_left_from > 0) {
@@ -208,33 +147,12 @@ ip4_lookup_node_process_vec(struct rte_graph *graph, struct rte_node *node,
 
 		NODE_INCREMENT_XSTAT_ID(node, 0, rc != 0, 1);
 		node_mbuf_priv1(mbuf0, dyn)->nh = (uint16_t)next_hop;
-		next_hop = next_hop >> 16;
-		next0 = (uint16_t)next_hop;
+		next0 = (uint16_t)(next_hop >> 16);
 
-		if (unlikely(next_index ^ next0)) {
-			/* Copy things successfully speculated till now */
-			rte_memcpy(to_next, from, last_spec * sizeof(from[0]));
-			from += last_spec;
-			to_next += last_spec;
-			held += last_spec;
-			last_spec = 0;
-
-			rte_node_enqueue_x1(graph, node, next0, from[0]);
-			from += 1;
-		} else {
-			last_spec += 1;
-		}
+		rte_node_enqueue_deferred(graph, node, next0, i);
+		i += 1;
 	}
 
-	/* !!! Home run !!! */
-	if (likely(last_spec == nb_objs)) {
-		rte_node_next_stream_move(graph, node, next_index);
-		return nb_objs;
-	}
-	held += last_spec;
-	rte_memcpy(to_next, from, last_spec * sizeof(from[0]));
-	rte_node_next_stream_put(graph, node, next_index, held);
-
 	return nb_objs;
 }
 
diff --git a/lib/node/ip4_lookup_sse.h b/lib/node/ip4_lookup_sse.h
index fb5f9c9b9901..de52439ae257 100644
--- a/lib/node/ip4_lookup_sse.h
+++ b/lib/node/ip4_lookup_sse.h
@@ -13,25 +13,19 @@ ip4_lookup_node_process_vec(struct rte_graph *graph, struct rte_node *node,
 	struct rte_mbuf *mbuf0, *mbuf1, *mbuf2, *mbuf3, **pkts;
 	struct rte_lpm *lpm = IP4_LOOKUP_NODE_LPM(node->ctx);
 	const int dyn = IP4_LOOKUP_NODE_PRIV1_OFF(node->ctx);
-	rte_edge_t next0, next1, next2, next3, next_index;
+	rte_edge_t next0, next1, next2, next3;
 	struct rte_ipv4_hdr *ipv4_hdr;
 	uint32_t ip0, ip1, ip2, ip3;
-	void **to_next, **from;
-	uint16_t last_spec = 0;
 	uint16_t n_left_from;
-	uint16_t held = 0;
 	uint32_t drop_nh;
 	rte_xmm_t dst;
 	__m128i dip; /* SSE register */
 	int rc, i;
 
-	/* Speculative next */
-	next_index = RTE_NODE_IP4_LOOKUP_NEXT_REWRITE;
 	/* Drop node */
 	drop_nh = ((uint32_t)RTE_NODE_IP4_LOOKUP_NEXT_PKT_DROP) << 16;
 
 	pkts = (struct rte_mbuf **)objs;
-	from = objs;
 	n_left_from = nb_objs;
 
 	if (n_left_from >= 4) {
@@ -40,8 +34,7 @@ ip4_lookup_node_process_vec(struct rte_graph *graph, struct rte_node *node,
 						sizeof(struct rte_ether_hdr)));
 	}
 
-	/* Get stream for the speculated next node */
-	to_next = rte_node_next_stream_get(graph, node, next_index, nb_objs);
+	i = 0;
 	while (n_left_from >= 4) {
 		/* Prefetch next-next mbufs */
 		if (likely(n_left_from > 11)) {
@@ -133,64 +126,11 @@ ip4_lookup_node_process_vec(struct rte_graph *graph, struct rte_node *node,
 		node_mbuf_priv1(mbuf3, dyn)->nh = dst.u32[3] & 0xFFFF;
 		next3 = (dst.u32[3] >> 16);
 
-		/* Enqueue four to next node */
-		rte_edge_t fix_spec =
-			(next_index ^ next0) | (next_index ^ next1) |
-			(next_index ^ next2) | (next_index ^ next3);
-
-		if (unlikely(fix_spec)) {
-			/* Copy things successfully speculated till now */
-			rte_memcpy(to_next, from, last_spec * sizeof(from[0]));
-			from += last_spec;
-			to_next += last_spec;
-			held += last_spec;
-			last_spec = 0;
-
-			/* Next0 */
-			if (next_index == next0) {
-				to_next[0] = from[0];
-				to_next++;
-				held++;
-			} else {
-				rte_node_enqueue_x1(graph, node, next0,
-						    from[0]);
-			}
-
-			/* Next1 */
-			if (next_index == next1) {
-				to_next[0] = from[1];
-				to_next++;
-				held++;
-			} else {
-				rte_node_enqueue_x1(graph, node, next1,
-						    from[1]);
-			}
-
-			/* Next2 */
-			if (next_index == next2) {
-				to_next[0] = from[2];
-				to_next++;
-				held++;
-			} else {
-				rte_node_enqueue_x1(graph, node, next2,
-						    from[2]);
-			}
-
-			/* Next3 */
-			if (next_index == next3) {
-				to_next[0] = from[3];
-				to_next++;
-				held++;
-			} else {
-				rte_node_enqueue_x1(graph, node, next3,
-						    from[3]);
-			}
-
-			from += 4;
-
-		} else {
-			last_spec += 4;
-		}
+		rte_node_enqueue_deferred(graph, node, next0, i);
+		rte_node_enqueue_deferred(graph, node, next1, i + 1);
+		rte_node_enqueue_deferred(graph, node, next2, i + 2);
+		rte_node_enqueue_deferred(graph, node, next3, i + 3);
+		i += 4;
 	}
 
 	while (n_left_from > 0) {
@@ -216,32 +156,10 @@ ip4_lookup_node_process_vec(struct rte_graph *graph, struct rte_node *node,
 		node_mbuf_priv1(mbuf0, dyn)->nh = next_hop & 0xFFFF;
 		next0 = (next_hop >> 16);
 
-		if (unlikely(next_index ^ next0)) {
-			/* Copy things successfully speculated till now */
-			rte_memcpy(to_next, from, last_spec * sizeof(from[0]));
-			from += last_spec;
-			to_next += last_spec;
-			held += last_spec;
-			last_spec = 0;
-
-			rte_node_enqueue_x1(graph, node, next0, from[0]);
-			from += 1;
-		} else {
-			last_spec += 1;
-		}
+		rte_node_enqueue_deferred(graph, node, next0, i);
+		i += 1;
 	}
 
-	/* !!! Home run !!! */
-	if (likely(last_spec == nb_objs)) {
-		rte_node_next_stream_move(graph, node, next_index);
-		return nb_objs;
-	}
-
-	held += last_spec;
-	/* Copy things successfully speculated till now */
-	rte_memcpy(to_next, from, last_spec * sizeof(from[0]));
-	rte_node_next_stream_put(graph, node, next_index, held);
-
 	return nb_objs;
 }
 
diff --git a/lib/node/ip4_rewrite.c b/lib/node/ip4_rewrite.c
index 37bc3a511fc7..2fa5ada3efba 100644
--- a/lib/node/ip4_rewrite.c
+++ b/lib/node/ip4_rewrite.c
@@ -26,8 +26,6 @@ struct ip4_rewrite_node_ctx {
 	int mbuf_priv1_off;
 	/* Dynamic offset to feature arc field */
 	int arc_dyn_off;
-	/* Cached next index */
-	uint16_t next_index;
 	/* tx interface of last mbuf */
 	uint16_t last_tx_if;
 	/* Cached feature arc handle */
@@ -37,9 +35,6 @@ struct ip4_rewrite_node_ctx {
 static struct ip4_rewrite_node_main *ip4_rewrite_nm;
 static int port_to_next_index_diff = -1;
 
-#define IP4_REWRITE_NODE_LAST_NEXT(ctx) \
-	(((struct ip4_rewrite_node_ctx *)ctx)->next_index)
-
 #define IP4_REWRITE_NODE_PRIV1_OFF(ctx) \
 	(((struct ip4_rewrite_node_ctx *)ctx)->mbuf_priv1_off)
 
@@ -190,22 +185,18 @@ __ip4_rewrite_node_process(struct rte_graph *graph, struct rte_node *node,
 	rte_graph_feature_data_t feature_data = RTE_GRAPH_FEATURE_DATA_INVALID;
 	struct rte_mbuf *mbuf0, *mbuf1, *mbuf2, *mbuf3, **pkts;
 	struct ip4_rewrite_nh_header *nh = ip4_rewrite_nm->nh;
-	uint16_t next0, next1, next2, next3, next_index;
 	struct rte_ipv4_hdr *ip0, *ip1, *ip2, *ip3;
-	uint16_t n_left_from, held = 0, last_spec = 0;
+	rte_edge_t next0, next1, next2, next3;
 	uint16_t last_tx_if, last_next_index;
 	void *d0, *d1, *d2, *d3;
-	void **to_next, **from;
+	uint16_t n_left_from;
 	rte_xmm_t priv01;
 	rte_xmm_t priv23;
 	int i;
 
-	/* Speculative next as last next */
-	next_index = IP4_REWRITE_NODE_LAST_NEXT(node->ctx);
 	rte_prefetch0(nh);
 
 	pkts = (struct rte_mbuf **)objs;
-	from = objs;
 	n_left_from = nb_objs;
 
 	for (i = 0; i < 4 && i < n_left_from; i++)
@@ -233,8 +224,7 @@ __ip4_rewrite_node_process(struct rte_graph *graph, struct rte_node *node,
 		last_next_index = UINT16_MAX;
 	}
 
-	/* Get stream for the speculated next node */
-	to_next = rte_node_next_stream_get(graph, node, next_index, nb_objs);
+	i = 0;
 	/* Update Ethernet header of pkts */
 	while (n_left_from >= 4) {
 		if (likely(n_left_from > 7)) {
@@ -319,76 +309,11 @@ __ip4_rewrite_node_process(struct rte_graph *graph, struct rte_node *node,
 						    &next0, &next1, &next2, &next3,
 						    &last_next_index, &feature_data, feat_dyn);
 
-		/* Enqueue four to next node */
-		rte_edge_t fix_spec =
-			((next_index == next0) && (next0 == next1) &&
-			 (next1 == next2) && (next2 == next3));
-
-		if (unlikely(fix_spec == 0)) {
-			/* Copy things successfully speculated till now */
-			rte_memcpy(to_next, from, last_spec * sizeof(from[0]));
-			from += last_spec;
-			to_next += last_spec;
-			held += last_spec;
-			last_spec = 0;
-
-			/* next0 */
-			if (next_index == next0) {
-				to_next[0] = from[0];
-				to_next++;
-				held++;
-			} else {
-				rte_node_enqueue_x1(graph, node, next0,
-						    from[0]);
-			}
-
-			/* next1 */
-			if (next_index == next1) {
-				to_next[0] = from[1];
-				to_next++;
-				held++;
-			} else {
-				rte_node_enqueue_x1(graph, node, next1,
-						    from[1]);
-			}
-
-			/* next2 */
-			if (next_index == next2) {
-				to_next[0] = from[2];
-				to_next++;
-				held++;
-			} else {
-				rte_node_enqueue_x1(graph, node, next2,
-						    from[2]);
-			}
-
-			/* next3 */
-			if (next_index == next3) {
-				to_next[0] = from[3];
-				to_next++;
-				held++;
-			} else {
-				rte_node_enqueue_x1(graph, node, next3,
-						    from[3]);
-			}
-
-			from += 4;
-
-			/* Change speculation if last two are same */
-			if ((next_index != next3) && (next2 == next3)) {
-				/* Put the current speculated node */
-				rte_node_next_stream_put(graph, node,
-							 next_index, held);
-				held = 0;
-
-				/* Get next speculated stream */
-				next_index = next3;
-				to_next = rte_node_next_stream_get(
-					graph, node, next_index, nb_objs);
-			}
-		} else {
-			last_spec += 4;
-		}
+		rte_node_enqueue_deferred(graph, node, next0, i);
+		rte_node_enqueue_deferred(graph, node, next1, i + 1);
+		rte_node_enqueue_deferred(graph, node, next2, i + 2);
+		rte_node_enqueue_deferred(graph, node, next3, i + 3);
+		i += 4;
 	}
 
 	while (n_left_from > 0) {
@@ -417,33 +342,10 @@ __ip4_rewrite_node_process(struct rte_graph *graph, struct rte_node *node,
 						    mbuf0, &next0, &last_next_index,
 						    &feature_data, feat_dyn);
 
-		if (unlikely(next_index ^ next0)) {
-			/* Copy things successfully speculated till now */
-			rte_memcpy(to_next, from, last_spec * sizeof(from[0]));
-			from += last_spec;
-			to_next += last_spec;
-			held += last_spec;
-			last_spec = 0;
-
-			rte_node_enqueue_x1(graph, node, next0, from[0]);
-			from += 1;
-		} else {
-			last_spec += 1;
-		}
+		rte_node_enqueue_deferred(graph, node, next0, i);
+		i += 1;
 	}
 
-	/* !!! Home run !!! */
-	if (likely(last_spec == nb_objs)) {
-		rte_node_next_stream_move(graph, node, next_index);
-		return nb_objs;
-	}
-
-	held += last_spec;
-	rte_memcpy(to_next, from, last_spec * sizeof(from[0]));
-	rte_node_next_stream_put(graph, node, next_index, held);
-	/* Save the last next used */
-	IP4_REWRITE_NODE_LAST_NEXT(node->ctx) = next_index;
-
 	if (check_enabled_features)
 		IP4_REWRITE_NODE_LAST_TX_IF(node->ctx) = last_tx_if;
 
@@ -515,8 +417,6 @@ ip4_rewrite_node_init(const struct rte_graph *graph, struct rte_node *node)
 			IP4_REWRITE_NODE_FEAT_OFF(node->ctx) =
 				rte_graph_feature_arc_get(feature_arc)->mbuf_dyn_offset;
 
-		/* By default, set cached next node to pkt_drop */
-		IP4_REWRITE_NODE_LAST_NEXT(node->ctx) = 0;
 		IP4_REWRITE_NODE_LAST_TX_IF(node->ctx) = 0;
 
 		init_once = true;
diff --git a/lib/node/ip6_lookup.c b/lib/node/ip6_lookup.c
index 83c0500c76ef..af286aef87a5 100644
--- a/lib/node/ip6_lookup.c
+++ b/lib/node/ip6_lookup.c
@@ -48,21 +48,14 @@ ip6_lookup_node_process_scalar(struct rte_graph *graph, struct rte_node *node,
 	struct rte_lpm6 *lpm6 = IP6_LOOKUP_NODE_LPM(node->ctx);
 	const int dyn = IP6_LOOKUP_NODE_PRIV1_OFF(node->ctx);
 	struct rte_ipv6_hdr *ipv6_hdr;
-	void **to_next, **from;
-	uint16_t last_spec = 0;
-	rte_edge_t next_index;
 	uint16_t n_left_from;
-	uint16_t held = 0;
 	uint32_t drop_nh;
 	int i, rc;
 
-	/* Speculative next */
-	next_index = RTE_NODE_IP6_LOOKUP_NEXT_REWRITE;
 	/* Drop node */
 	drop_nh = ((uint32_t)RTE_NODE_IP6_LOOKUP_NEXT_PKT_DROP) << 16;
 
 	pkts = (struct rte_mbuf **)objs;
-	from = objs;
 	n_left_from = nb_objs;
 
 	for (i = OBJS_PER_CLINE; i < RTE_GRAPH_BURST_SIZE; i += OBJS_PER_CLINE)
@@ -72,8 +65,7 @@ ip6_lookup_node_process_scalar(struct rte_graph *graph, struct rte_node *node,
 		rte_prefetch0(rte_pktmbuf_mtod_offset(pkts[i], void *,
 						sizeof(struct rte_ether_hdr)));
 
-	/* Get stream for the speculated next node */
-	to_next = rte_node_next_stream_get(graph, node, next_index, nb_objs);
+	i = 0;
 	while (n_left_from >= 4) {
 		struct rte_ipv6_addr ip_batch[4];
 		int32_t next_hop[4];
@@ -154,59 +146,11 @@ ip6_lookup_node_process_scalar(struct rte_graph *graph, struct rte_node *node,
 		node_mbuf_priv1(mbuf3, dyn)->nh = (uint16_t)next_hop[3];
 		next[3] = (uint16_t)(next_hop[3] >> 16);
 
-		rte_edge_t fix_spec = ((next_index == next[0]) &&
-					(next_index == next[1]) &&
-					(next_index == next[2]) &&
-					(next_index == next[3]));
-
-		if (unlikely(fix_spec == 0)) {
-			/* Copy things successfully speculated till now */
-			rte_memcpy(to_next, from, last_spec * sizeof(from[0]));
-			from += last_spec;
-			to_next += last_spec;
-			held += last_spec;
-			last_spec = 0;
-
-			/* Next0 */
-			if (next_index == next[0]) {
-				to_next[0] = from[0];
-				to_next++;
-				held++;
-			} else {
-				rte_node_enqueue_x1(graph, node, next[0], from[0]);
-			}
-
-			/* Next1 */
-			if (next_index == next[1]) {
-				to_next[0] = from[1];
-				to_next++;
-				held++;
-			} else {
-				rte_node_enqueue_x1(graph, node, next[1], from[1]);
-			}
-
-			/* Next2 */
-			if (next_index == next[2]) {
-				to_next[0] = from[2];
-				to_next++;
-				held++;
-			} else {
-				rte_node_enqueue_x1(graph, node, next[2], from[2]);
-			}
-
-			/* Next3 */
-			if (next_index == next[3]) {
-				to_next[0] = from[3];
-				to_next++;
-				held++;
-			} else {
-				rte_node_enqueue_x1(graph, node, next[3], from[3]);
-			}
-
-			from += 4;
-		} else {
-			last_spec += 4;
-		}
+		rte_node_enqueue_deferred(graph, node, next[0], i);
+		rte_node_enqueue_deferred(graph, node, next[1], i + 1);
+		rte_node_enqueue_deferred(graph, node, next[2], i + 2);
+		rte_node_enqueue_deferred(graph, node, next[3], i + 3);
+		i += 4;
 	}
 
 	while (n_left_from > 0) {
@@ -228,33 +172,12 @@ ip6_lookup_node_process_scalar(struct rte_graph *graph, struct rte_node *node,
 		next_hop = (rc == 0) ? next_hop : drop_nh;
 
 		node_mbuf_priv1(mbuf0, dyn)->nh = (uint16_t)next_hop;
-		next_hop = next_hop >> 16;
-		next0 = (uint16_t)next_hop;
+		next0 = (uint16_t)(next_hop >> 16);
 
-		if (unlikely(next_index ^ next0)) {
-			/* Copy things successfully speculated till now */
-			rte_memcpy(to_next, from, last_spec * sizeof(from[0]));
-			from += last_spec;
-			to_next += last_spec;
-			held += last_spec;
-			last_spec = 0;
-
-			rte_node_enqueue_x1(graph, node, next0, from[0]);
-			from += 1;
-		} else {
-			last_spec += 1;
-		}
+		rte_node_enqueue_deferred(graph, node, next0, i);
+		i += 1;
 	}
 
-	/* !!! Home run !!! */
-	if (likely(last_spec == nb_objs)) {
-		rte_node_next_stream_move(graph, node, next_index);
-		return nb_objs;
-	}
-	held += last_spec;
-	rte_memcpy(to_next, from, last_spec * sizeof(from[0]));
-	rte_node_next_stream_put(graph, node, next_index, held);
-
 	return nb_objs;
 }
 
diff --git a/lib/node/ip6_lookup_fib.c b/lib/node/ip6_lookup_fib.c
index 40c5c753dfac..f4e5cfc04e8f 100644
--- a/lib/node/ip6_lookup_fib.c
+++ b/lib/node/ip6_lookup_fib.c
@@ -51,24 +51,13 @@ ip6_lookup_fib_node_process(struct rte_graph *graph, struct rte_node *node, void
 	uint64_t next_hop[RTE_GRAPH_BURST_SIZE];
 	struct rte_ipv6_hdr *ipv6_hdr;
 	uint16_t lookup_err = 0;
-	void **to_next, **from;
-	uint16_t last_spec = 0;
-	rte_edge_t next_index;
 	uint16_t n_left_from;
-	uint16_t held = 0;
 	uint16_t next;
 	int i;
 
-	/* Speculative next */
-	next_index = RTE_NODE_IP6_LOOKUP_NEXT_REWRITE;
-
 	pkts = (struct rte_mbuf **)objs;
-	from = objs;
 	n_left_from = nb_objs;
 
-	/* Get stream for the speculated next node */
-	to_next = rte_node_next_stream_get(graph, node, next_index, nb_objs);
-
 	for (i = 0; i < 4 && i < n_left_from; i++)
 		rte_prefetch0(rte_pktmbuf_mtod_offset(pkts[i], void *,
 					sizeof(struct rte_ether_hdr)));
@@ -155,34 +144,13 @@ ip6_lookup_fib_node_process(struct rte_graph *graph, struct rte_node *node, void
 		node_mbuf_priv1(mbuf0, dyn)->nh = (uint16_t)next_hop[i];
 		next = (uint16_t)(next_hop[i] >> 16);
 
-		if (unlikely(next_index ^ next)) {
-			/* Copy things successfully speculated till now */
-			rte_memcpy(to_next, from, last_spec * sizeof(from[0]));
-			from += last_spec;
-			to_next += last_spec;
-			held += last_spec;
-			last_spec = 0;
-
-			rte_node_enqueue_x1(graph, node, next, from[0]);
-			from += 1;
-		} else {
-			last_spec += 1;
-		}
-
 		if (unlikely(next_hop[i] == FIB6_DEFAULT_NH))
 			lookup_err += 1;
-	}
 
-	/* !!! Home run !!! */
-	if (likely(last_spec == nb_objs)) {
-		rte_node_next_stream_move(graph, node, next_index);
-		return nb_objs;
+		rte_node_enqueue_deferred(graph, node, next, i);
 	}
 
 	NODE_INCREMENT_XSTAT_ID(node, 0, lookup_err != 0, lookup_err);
-	held += last_spec;
-	rte_memcpy(to_next, from, last_spec * sizeof(from[0]));
-	rte_node_next_stream_put(graph, node, next_index, held);
 
 	return nb_objs;
 }
diff --git a/lib/node/ip6_rewrite.c b/lib/node/ip6_rewrite.c
index d5488e7fa3f0..ab1368b8dac2 100644
--- a/lib/node/ip6_rewrite.c
+++ b/lib/node/ip6_rewrite.c
@@ -19,15 +19,10 @@
 struct ip6_rewrite_node_ctx {
 	/* Dynamic offset to mbuf priv1 */
 	int mbuf_priv1_off;
-	/* Cached next index */
-	uint16_t next_index;
 };
 
 static struct ip6_rewrite_node_main *ip6_rewrite_nm;
 
-#define IP6_REWRITE_NODE_LAST_NEXT(ctx) \
-	(((struct ip6_rewrite_node_ctx *)ctx)->next_index)
-
 #define IP6_REWRITE_NODE_PRIV1_OFF(ctx) \
 	(((struct ip6_rewrite_node_ctx *)ctx)->mbuf_priv1_off)
 
@@ -38,28 +33,23 @@ ip6_rewrite_node_process(struct rte_graph *graph, struct rte_node *node,
 	struct rte_mbuf *mbuf0, *mbuf1, *mbuf2, *mbuf3, **pkts;
 	struct ip6_rewrite_nh_header *nh = ip6_rewrite_nm->nh;
 	const int dyn = IP6_REWRITE_NODE_PRIV1_OFF(node->ctx);
-	uint16_t next0, next1, next2, next3, next_index;
-	uint16_t n_left_from, held = 0, last_spec = 0;
 	struct rte_ipv6_hdr *ip0, *ip1, *ip2, *ip3;
+	rte_edge_t next0, next1, next2, next3;
 	void *d0, *d1, *d2, *d3;
-	void **to_next, **from;
+	uint16_t n_left_from;
 	rte_xmm_t priv01;
 	rte_xmm_t priv23;
 	int i;
 
-	/* Speculative next as last next */
-	next_index = IP6_REWRITE_NODE_LAST_NEXT(node->ctx);
 	rte_prefetch0(nh);
 
 	pkts = (struct rte_mbuf **)objs;
-	from = objs;
 	n_left_from = nb_objs;
 
 	for (i = 0; i < 4 && i < n_left_from; i++)
 		rte_prefetch0(pkts[i]);
 
-	/* Get stream for the speculated next node */
-	to_next = rte_node_next_stream_get(graph, node, next_index, nb_objs);
+	i = 0;
 	/* Update Ethernet header of pkts */
 	while (n_left_from >= 4) {
 		if (likely(n_left_from > 7)) {
@@ -123,76 +113,11 @@ ip6_rewrite_node_process(struct rte_graph *graph, struct rte_node *node,
 					      sizeof(struct rte_ether_hdr));
 		ip3->hop_limits = priv23.u16[5] - 1;
 
-		/* Enqueue four packets to next node */
-		rte_edge_t fix_spec =
-			((next_index == next0) && (next0 == next1) &&
-			 (next1 == next2) && (next2 == next3));
-
-		if (unlikely(fix_spec == 0)) {
-			/* Copy things successfully speculated till now */
-			rte_memcpy(to_next, from, last_spec * sizeof(from[0]));
-			from += last_spec;
-			to_next += last_spec;
-			held += last_spec;
-			last_spec = 0;
-
-			/* next0 */
-			if (next_index == next0) {
-				to_next[0] = from[0];
-				to_next++;
-				held++;
-			} else {
-				rte_node_enqueue_x1(graph, node, next0,
-						    from[0]);
-			}
-
-			/* next1 */
-			if (next_index == next1) {
-				to_next[0] = from[1];
-				to_next++;
-				held++;
-			} else {
-				rte_node_enqueue_x1(graph, node, next1,
-						    from[1]);
-			}
-
-			/* next2 */
-			if (next_index == next2) {
-				to_next[0] = from[2];
-				to_next++;
-				held++;
-			} else {
-				rte_node_enqueue_x1(graph, node, next2,
-						    from[2]);
-			}
-
-			/* next3 */
-			if (next_index == next3) {
-				to_next[0] = from[3];
-				to_next++;
-				held++;
-			} else {
-				rte_node_enqueue_x1(graph, node, next3,
-						    from[3]);
-			}
-
-			from += 4;
-
-			/* Change speculation if last two are same */
-			if ((next_index != next3) && (next2 == next3)) {
-				/* Put the current speculated node */
-				rte_node_next_stream_put(graph, node,
-							 next_index, held);
-				held = 0;
-
-				/* Get next speculated stream */
-				next_index = next3;
-				to_next = rte_node_next_stream_get(
-					graph, node, next_index, nb_objs);
-			}
-		} else {
-			last_spec += 4;
-		}
+		rte_node_enqueue_deferred(graph, node, next0, i);
+		rte_node_enqueue_deferred(graph, node, next1, i + 1);
+		rte_node_enqueue_deferred(graph, node, next2, i + 2);
+		rte_node_enqueue_deferred(graph, node, next3, i + 3);
+		i += 4;
 	}
 
 	while (n_left_from > 0) {
@@ -210,33 +135,10 @@ ip6_rewrite_node_process(struct rte_graph *graph, struct rte_node *node,
 					      sizeof(struct rte_ether_hdr));
 		ip0->hop_limits = node_mbuf_priv1(mbuf0, dyn)->ttl - 1;
 
-		if (unlikely(next_index ^ next0)) {
-			/* Copy things successfully speculated till now */
-			rte_memcpy(to_next, from, last_spec * sizeof(from[0]));
-			from += last_spec;
-			to_next += last_spec;
-			held += last_spec;
-			last_spec = 0;
-
-			rte_node_enqueue_x1(graph, node, next0, from[0]);
-			from += 1;
-		} else {
-			last_spec += 1;
-		}
+		rte_node_enqueue_deferred(graph, node, next0, i);
+		i += 1;
 	}
 
-	/* !!! Home run !!! */
-	if (likely(last_spec == nb_objs)) {
-		rte_node_next_stream_move(graph, node, next_index);
-		return nb_objs;
-	}
-
-	held += last_spec;
-	rte_memcpy(to_next, from, last_spec * sizeof(from[0]));
-	rte_node_next_stream_put(graph, node, next_index, held);
-	/* Save the last next used */
-	IP6_REWRITE_NODE_LAST_NEXT(node->ctx) = next_index;
-
 	return nb_objs;
 }
 
diff --git a/lib/node/pkt_cls.c b/lib/node/pkt_cls.c
index ca323ea5732f..b05356596f45 100644
--- a/lib/node/pkt_cls.c
+++ b/lib/node/pkt_cls.c
@@ -47,15 +47,11 @@ pkt_cls_node_process(struct rte_graph *graph, struct rte_node *node,
 		     void **objs, uint16_t nb_objs)
 {
 	struct rte_mbuf *mbuf0, *mbuf1, *mbuf2, *mbuf3, **pkts;
-	uint8_t l0, l1, l2, l3, last_type;
-	uint16_t next_index, n_left_from;
-	uint16_t held = 0, last_spec = 0;
-	struct pkt_cls_node_ctx *ctx;
-	void **to_next, **from;
+	uint8_t l0, l1, l2, l3;
+	uint16_t n_left_from;
 	uint32_t i;
 
 	pkts = (struct rte_mbuf **)objs;
-	from = objs;
 	n_left_from = nb_objs;
 
 	for (i = OBJS_PER_CLINE; i < RTE_GRAPH_BURST_SIZE; i += OBJS_PER_CLINE)
@@ -66,13 +62,7 @@ pkt_cls_node_process(struct rte_graph *graph, struct rte_node *node,
 		rte_prefetch0(pkts[i]);
 #endif
 
-	ctx = (struct pkt_cls_node_ctx *)node->ctx;
-	last_type = ctx->l2l3_type;
-	next_index = p_nxt[last_type];
-
-	/* Get stream for the speculated next node */
-	to_next = rte_node_next_stream_get(graph, node,
-					   next_index, nb_objs);
+	i = 0;
 	while (n_left_from >= 4) {
 #if RTE_GRAPH_BURST_SIZE > 64
 		if (likely(n_left_from > 7)) {
@@ -99,86 +89,11 @@ pkt_cls_node_process(struct rte_graph *graph, struct rte_node *node,
 		l3 = mbuf3->packet_type &
 			(RTE_PTYPE_L2_MASK | RTE_PTYPE_L3_MASK);
 
-		/* Check if they are destined to same
-		 * next node based on l2l3 packet type.
-		 */
-		uint8_t fix_spec = (last_type ^ l0) | (last_type ^ l1) |
-			(last_type ^ l2) | (last_type ^ l3);
-
-		if (unlikely(fix_spec)) {
-			/* Copy things successfully speculated till now */
-			rte_memcpy(to_next, from,
-				   last_spec * sizeof(from[0]));
-			from += last_spec;
-			to_next += last_spec;
-			held += last_spec;
-			last_spec = 0;
-
-			/* l0 */
-			if (p_nxt[l0] == next_index) {
-				to_next[0] = from[0];
-				to_next++;
-				held++;
-			} else {
-				rte_node_enqueue_x1(graph, node,
-						    p_nxt[l0], from[0]);
-			}
-
-			/* l1 */
-			if (p_nxt[l1] == next_index) {
-				to_next[0] = from[1];
-				to_next++;
-				held++;
-			} else {
-				rte_node_enqueue_x1(graph, node,
-						    p_nxt[l1], from[1]);
-			}
-
-			/* l2 */
-			if (p_nxt[l2] == next_index) {
-				to_next[0] = from[2];
-				to_next++;
-				held++;
-			} else {
-				rte_node_enqueue_x1(graph, node,
-						    p_nxt[l2], from[2]);
-			}
-
-			/* l3 */
-			if (p_nxt[l3] == next_index) {
-				to_next[0] = from[3];
-				to_next++;
-				held++;
-			} else {
-				rte_node_enqueue_x1(graph, node,
-						    p_nxt[l3], from[3]);
-			}
-
-			/* Update speculated ptype */
-			if ((last_type != l3) && (l2 == l3) &&
-			    (next_index != p_nxt[l3])) {
-				/* Put the current stream for
-				 * speculated ltype.
-				 */
-				rte_node_next_stream_put(graph, node,
-							 next_index, held);
-
-				held = 0;
-
-				/* Get next stream for new ltype */
-				next_index = p_nxt[l3];
-				last_type = l3;
-				to_next = rte_node_next_stream_get(graph, node,
-								   next_index,
-								   nb_objs);
-			} else if (next_index == p_nxt[l3]) {
-				last_type = l3;
-			}
-
-			from += 4;
-		} else {
-			last_spec += 4;
-		}
+		rte_node_enqueue_deferred(graph, node, p_nxt[l0], i);
+		rte_node_enqueue_deferred(graph, node, p_nxt[l1], i + 1);
+		rte_node_enqueue_deferred(graph, node, p_nxt[l2], i + 2);
+		rte_node_enqueue_deferred(graph, node, p_nxt[l3], i + 3);
+		i += 4;
 	}
 
 	while (n_left_from > 0) {
@@ -189,36 +104,11 @@ pkt_cls_node_process(struct rte_graph *graph, struct rte_node *node,
 
 		l0 = mbuf0->packet_type &
 			(RTE_PTYPE_L2_MASK | RTE_PTYPE_L3_MASK);
-		if (unlikely((l0 != last_type) &&
-			     (p_nxt[l0] != next_index))) {
-			/* Copy things successfully speculated till now */
-			rte_memcpy(to_next, from,
-				   last_spec * sizeof(from[0]));
-			from += last_spec;
-			to_next += last_spec;
-			held += last_spec;
-			last_spec = 0;
 
-			rte_node_enqueue_x1(graph, node,
-					    p_nxt[l0], from[0]);
-			from += 1;
-		} else {
-			last_spec += 1;
-		}
+		rte_node_enqueue_deferred(graph, node, p_nxt[l0], i);
+		i += 1;
 	}
 
-	/* !!! Home run !!! */
-	if (likely(last_spec == nb_objs)) {
-		rte_node_next_stream_move(graph, node, next_index);
-		return nb_objs;
-	}
-
-	held += last_spec;
-	/* Copy things successfully speculated till now */
-	rte_memcpy(to_next, from, last_spec * sizeof(from[0]));
-	rte_node_next_stream_put(graph, node, next_index, held);
-
-	ctx->l2l3_type = last_type;
 	return nb_objs;
 }
 
diff --git a/lib/node/udp4_input.c b/lib/node/udp4_input.c
index 5a74e28c8586..496e619e3e24 100644
--- a/lib/node/udp4_input.c
+++ b/lib/node/udp4_input.c
@@ -26,10 +26,6 @@
 #define UDP4_INPUT_NODE_HASH(ctx) \
 	(((struct udp4_input_node_ctx *)ctx)->hash)
 
-#define UDP4_INPUT_NODE_NEXT_INDEX(ctx) \
-	(((struct udp4_input_node_ctx *)ctx)->next_index)
-
-
 /* UDP4 input  global data struct */
 struct udp4_input_node_main {
 	struct rte_hash *hash_tbl[RTE_MAX_NUMA_NODES];
@@ -40,8 +36,6 @@ static struct udp4_input_node_main udp4_input_nm;
 struct udp4_input_node_ctx {
 	/* Socket's Hash table */
 	struct rte_hash *hash;
-	/* Cached next index */
-	uint16_t next_index;
 };
 
 struct flow_key {
@@ -155,21 +149,11 @@ udp4_input_node_process_scalar(struct rte_graph *graph, struct rte_node *node,
 			       void **objs, uint16_t nb_objs)
 {
 	struct rte_hash *hash_tbl_handle = UDP4_INPUT_NODE_HASH(node->ctx);
-	rte_edge_t next_index, udplookup_node;
 	struct rte_udp_hdr *pkt_udp_hdr;
-	uint16_t last_spec = 0;
-	void **to_next, **from;
+	rte_edge_t udplookup_node, next;
 	struct rte_mbuf *mbuf;
-	uint16_t held = 0;
-	uint16_t next = 0;
 	int i, rc;
 
-	/* Speculative next */
-	next_index = UDP4_INPUT_NODE_NEXT_INDEX(node->ctx);
-
-	from = objs;
-
-	to_next = rte_node_next_stream_get(graph, node, next_index, nb_objs);
 	for (i = 0; i < nb_objs; i++) {
 		struct flow_key key_port;
 
@@ -185,30 +169,8 @@ udp4_input_node_process_scalar(struct rte_graph *graph, struct rte_node *node,
 		next = (rc < 0) ? RTE_NODE_UDP4_INPUT_NEXT_PKT_DROP
 				    : udplookup_node;
 
-		if (unlikely(next_index != next)) {
-			/* Copy things successfully speculated till now */
-			rte_memcpy(to_next, from, last_spec * sizeof(from[0]));
-			from += last_spec;
-			to_next += last_spec;
-			held += last_spec;
-			last_spec = 0;
-
-			rte_node_enqueue_x1(graph, node, next, from[0]);
-			from += 1;
-		} else {
-			last_spec += 1;
-		}
+		rte_node_enqueue_deferred(graph, node, next, i);
 	}
-	/* !!! Home run !!! */
-	if (likely(last_spec == nb_objs)) {
-		rte_node_next_stream_move(graph, node, next_index);
-		return nb_objs;
-	}
-	held += last_spec;
-	rte_memcpy(to_next, from, last_spec * sizeof(from[0]));
-	rte_node_next_stream_put(graph, node, next_index, held);
-	/* Save the last next used */
-	UDP4_INPUT_NODE_NEXT_INDEX(node->ctx) = next;
 
 	return nb_objs;
 }
-- 
2.52.0

