Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC855CD8CA8
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 06:30:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE5FC40289;
	Tue, 16 Jun 2026 08:30:42 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id BB09A40285
 for <dev@dpdk.org>; Tue, 16 Jun 2026 08:30:41 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G65xFb1992650; Mon, 15 Jun 2026 23:30:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=j
 Wy5kApMFdK8YWYX7AZDjEnm5ZgCuZumg+DXEw6AmR0=; b=iEAVj+0oPDShKuNQW
 2t2Igf3358fqx9ahstvkVC/10UCnP1vhcTGfEqzI3/xNoENRjme9+InvZadcX7PP
 fCgWrPXnDm5YNuA0UYYAh6fjl54bXFjjvQ40KnKkAXjA9gBpi3r/Fa3WXBAIKSU2
 LAxbfO2Q25nzgTJowxhqcUhCFjWDaugr76+FMByj7PTQIpbKha437+o/MKx8DyBs
 kdGmrLrl2z/XoiO/7pWsQRHTvMY1xRgownALvEVbFYNuDxIHyK7dQPUj/LHmpPgY
 J5v2r2LQFezmiFryrKmwIRyen7f88XgksL2AP6FH3VLCWuzXebyZ3u+uv22Apw7y
 Olx9A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4etu38hdmj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2026 23:30:32 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 15 Jun 2026 23:30:31 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 15 Jun 2026 23:30:31 -0700
Received: from cavium-System-Product-Name.. (unknown [10.28.37.22])
 by maili.marvell.com (Postfix) with ESMTP id 0B1243F709B;
 Mon, 15 Jun 2026 23:30:27 -0700 (PDT)
From: <kirankumark@marvell.com>
To: <rjarry@redhat.com>
CC: <cfontain@redhat.com>, <david.marchand@redhat.com>, <dev@dpdk.org>,
 <jerinj@marvell.com>, <kirankumark@marvell.com>,
 <konstantin.ananyev@huawei.com>, <maxime@leroys.fr>,
 <ndabilpuram@marvell.com>, <vladimir.medvedkin@intel.com>,
 <yanzhirun_163@163.com>
Subject: [PATCH dpdk v2 2/2] graph: replace circular buffer with
 priority-based bitmap
Date: Tue, 16 Jun 2026 12:00:26 +0530
Message-ID: <20260616063026.2007191-1-kirankumark@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260519213822.735891-3-rjarry@redhat.com>
References: <20260519213822.735891-3-rjarry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: BLC5TQskzVZXtSDTY32dDTgZf_aMl0eB
X-Proofpoint-ORIG-GUID: BLC5TQskzVZXtSDTY32dDTgZf_aMl0eB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDA2MiBTYWx0ZWRfX7TMFQ1eKGpMW
 suiqVHTfieTG9K60eZytNVX2aYvGMhpdFUCxhUnbpSErvJsh9M1h7KjYff0XfTNv92HCVDDGku2
 z+u9Id7B9nTnW5XTcKj3COp6MbyYC40=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDA2MiBTYWx0ZWRfXyu31/YWn+mvR
 ScRCFXQB4MAFSyKD2yBE4ti98MUzcFT1Ra39GZo7/p2j9IA8v3+QD+9f8GrZTaRikBpG3gMYCcC
 4hrdDTx5tykSjpe5rr7N7CcuMP4xs9boPonTIORwgkavvnBpJi7Up3gOZ0fYJdsrfliaWXiNuCO
 uhHjmYRvPnTox/qd+9IimvLi9m4TDSUdDI+oKxI+3HKw8As7awctc13xXjnVrqJV2f5jY2EbpAH
 wDbXZVd2CJ5iZ5KWIs+wM208LFOzU6nkAh3kZBTKQ63bQjL/yJpK5cNl4mFdRl3CgvRxCzjyy6w
 92N19W86XhHqWljTWF0W6tROuRnsEVyHkhw2AUeYlKufzjyLjkHv+sWPBYQ7hfkeCI55bD0+3UY
 bJOieMBJ1FnibD8D0j+P7iqAzdXL1zyPoCp9P4ijgbCgNKQWO1Mx7nTwHBRGLrhminp85qVUPGG
 EfkfU5tY7ELdPUYIoCw==
X-Authority-Analysis: v=2.4 cv=SeXHsPRu c=1 sm=1 tr=0 ts=6a30ed88 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=ELgZ-yp8V7MKu1yRJRUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_02,2026-06-15_04,2025-10-01_01
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

This will break the ABI. Please check and fix.


>  	rte_node_process_t process; /**< Node process function. */
>  	rte_node_init_t init;       /**< Node init function. */
>  	rte_node_fini_t fini;       /**< Node fini function. */
> diff --git a/lib/graph/rte_graph_model_mcore_dispatch.h b/lib/graph/rte_graph_model_mcore_dispatch.h
> index f9ff3daa88ec..50a473564b56 100644
> --- a/lib/graph/rte_graph_model_mcore_dispatch.h
> +++ b/lib/graph/rte_graph_model_mcore_dispatch.h
> @@ -77,9 +77,13 @@ int rte_graph_model_mcore_dispatch_node_lcore_affinity_set(const char *name,
>  							   unsigned int lcore_id);
>
>  /**
> - * Perform graph walk on the circular buffer and invoke the process function
> + * Perform graph walk on the pending bitmap and invoke the process function
>   * of the nodes and collect the stats.
>   *
> + * Nodes are visited in scheduling order (lowest priority value first).
> + * Source nodes are seeded into the pending bitmap at the start of each walk.
> + * Nodes with different lcore affinity are dispatched to their target lcore.
> + *
>   * @param graph
>   *   Graph pointer returned from rte_graph_lookup function.
>   *
> @@ -88,20 +92,28 @@ int rte_graph_model_mcore_dispatch_node_lcore_affinity_set(const char *name,
>  static inline void
>  rte_graph_walk_mcore_dispatch(struct rte_graph *graph)
>  {
> -	const rte_graph_off_t *cir_start = graph->cir_start;
> -	const rte_node_t mask = graph->cir_mask;
> -	uint32_t head = graph->head;
> +	const uint16_t nwords = graph->nb_sched_words;
>  	struct rte_node *node;
> +	uint16_t word, bit;
>
>  	if (graph->dispatch.wq != NULL)
>  		__rte_graph_mcore_dispatch_sched_wq_process(graph);
>
> -	while (likely(head != graph->tail)) {
> -		node = (struct rte_node *)RTE_PTR_ADD(graph, cir_start[(int32_t)head++]);
> +	/* Seed pending bitmap with source nodes bound to this lcore */
> +	for (word = 0; word < nwords; word++)
> +		graph->pending[word] |= graph->src_pending[word];
>
> -		/* skip the src nodes which not bind with current worker */
> -		if ((int32_t)head < 1 && node->dispatch.lcore_id != graph->dispatch.lcore_id)
> -			continue;
> +	for (;;) {
> +		/* find first word with any pending bit */
> +		for (word = 0; word < nwords; word++)
> +			if (graph->pending[word])
> +				break;
> +		if (word == nwords)
> +			break; /* no more pending nodes */
> +
> +		bit = rte_ctz64(graph->pending[word]);
> +		graph->pending[word] &= ~(1ULL << bit);
> +		node = __rte_graph_pending_node(graph, word, bit);
>
>  		/* Schedule the node until all task/objs are done */
>  		if (node->dispatch.lcore_id != RTE_MAX_LCORE &&
> @@ -111,11 +123,7 @@ rte_graph_walk_mcore_dispatch(struct rte_graph *graph)
>  			continue;
>
>  		__rte_node_process(graph, node);
> -
> -		head = likely((int32_t)head > 0) ? head & mask : head;
>  	}
> -
> -	graph->tail = 0;
>  }
>
>  #ifdef __cplusplus
> diff --git a/lib/graph/rte_graph_model_rtc.h b/lib/graph/rte_graph_model_rtc.h
> index 4b6236e301e3..38feb3e1ca88 100644
> --- a/lib/graph/rte_graph_model_rtc.h
> +++ b/lib/graph/rte_graph_model_rtc.h
> @@ -6,9 +6,12 @@
>  #include "rte_graph_worker_common.h"
>
>  /**
> - * Perform graph walk on the circular buffer and invoke the process function
> + * Perform graph walk on the pending bitmap and invoke the process function
>   * of the nodes and collect the stats.
>   *
> + * Nodes are visited in scheduling order (lowest priority value first).
> + * Source nodes are seeded into the pending bitmap at the start of each walk.
> + *
>   * @param graph
>   *   Graph pointer returned from rte_graph_lookup function.
>   *
> @@ -17,30 +20,52 @@
>  static inline void
>  rte_graph_walk_rtc(struct rte_graph *graph)
>  {
> -	const rte_graph_off_t *cir_start = graph->cir_start;
> -	const rte_node_t mask = graph->cir_mask;
> -	uint32_t head = graph->head;
> +	const uint16_t nwords = graph->nb_sched_words;
>  	struct rte_node *node;
> +	uint16_t word, bit;
>
>  	/*
> -	 * Walk on the source node(s) ((cir_start - head) -> cir_start) and then
> -	 * on the pending streams (cir_start -> (cir_start + mask) -> cir_start)
> -	 * in a circular buffer fashion.
> +	 * Nodes are assigned a bit position (sched_idx) sorted by (priority,
> +	 * node_id) at graph creation time. Source nodes are forced to INT16_MIN
> +	 * priority so they always come first.
>  	 *
> -	 *	+-----+ <= cir_start - head [number of source nodes]
> -	 *	|     |
> -	 *	| ... | <= source nodes
> -	 *	|     |
> -	 *	+-----+ <= cir_start [head = 0] [tail = 0]
> -	 *	|     |
> -	 *	| ... | <= pending streams
> -	 *	|     |
> -	 *	+-----+ <= cir_start + mask
> +	 * sched_table[] maps bit positions to node offsets:
> +	 *
> +	 *   pending[]         sched_table[]
> +	 *   +----------+      +------------------+
> +	 *   | word 0   | ---> | src_node_0       | bit 0 (prio=INT16_MIN)
> +	 *   | 1100...1 |      | src_node_1       | bit 1 (prio=INT16_MIN)
> +	 *   |          |      | mpls_input       | bit 2 (prio=-10)
> +	 *   |          |      | ipv4_input       | bit 3 (prio=0)
> +	 *   |          |      | ...              |
> +	 *   +----------+      +------------------+
> +	 *   | word 1   | ---> | ip4_rewrite      | bit 64 (prio=10)
> +	 *   | ...      |      | ...              |
> +	 *   +----------+      +------------------+
> +	 *
> +	 * Walk: for each word, find lowest set bit (rte_ctz64), process that
> +	 * node, clear the bit, re-read the word (processing may have set new
> +	 * bits), repeat.
> +	 *
> +	 * After each node is processed, restart scanning from word 0 since
> +	 * processing may set bits in any word, including earlier ones.
>  	 */
> -	while (likely(head != graph->tail)) {
> -		node = (struct rte_node *)RTE_PTR_ADD(graph, cir_start[(int32_t)head++]);
> +
> +	/* Seed pending bitmap with source nodes */
> +	for (word = 0; word < nwords; word++)
> +		graph->pending[word] |= graph->src_pending[word];
> +
> +	for (;;) {
> +		/* find first word with any pending bit */
> +		for (word = 0; word < nwords; word++)
> +			if (graph->pending[word])
> +				break;
> +		if (word == nwords)
> +			break; /* no more pending nodes */
> +
> +		bit = rte_ctz64(graph->pending[word]);
> +		graph->pending[word] &= ~(1ULL << bit);
> +		node = __rte_graph_pending_node(graph, word, bit);
>  		__rte_node_process(graph, node);
> -		head = likely((int32_t)head > 0) ? head & mask : head;
>  	}
> -	graph->tail = 0;
>  }
> diff --git a/lib/graph/rte_graph_worker.h b/lib/graph/rte_graph_worker.h
> index b0f952a82cc9..e513d7a655d9 100644
> --- a/lib/graph/rte_graph_worker.h
> +++ b/lib/graph/rte_graph_worker.h
> @@ -14,7 +14,7 @@ extern "C" {
>  #endif
>
>  /**
> - * Perform graph walk on the circular buffer and invoke the process function
> + * Perform graph walk on the pending bitmap and invoke the process function
>   * of the nodes and collect the stats.
>   *
>   * @param graph
> diff --git a/lib/graph/rte_graph_worker_common.h b/lib/graph/rte_graph_worker_common.h
> index 4ab53a533e4c..0e60486043d8 100644
> --- a/lib/graph/rte_graph_worker_common.h
> +++ b/lib/graph/rte_graph_worker_common.h
> @@ -49,15 +49,14 @@ SLIST_HEAD(rte_graph_rq_head, rte_graph);
>   */
>  struct __rte_cache_aligned rte_graph {
>  	/* Fast path area. */
> -	uint32_t tail;		     /**< Tail of circular buffer. */
> -	uint32_t head;		     /**< Head of circular buffer. */
> -	uint32_t cir_mask;	     /**< Circular buffer wrap around mask. */
>  	rte_node_t nb_nodes;	     /**< Number of nodes in the graph. */
> -	rte_graph_off_t *cir_start;  /**< Pointer to circular buffer. */
>  	rte_graph_off_t nodes_start; /**< Offset at which node memory starts. */
> +	rte_graph_off_t *sched_table; /**< Node offset indexed by sched_idx. */
> +	uint64_t *pending;	     /**< Bitmap of pending nodes. */
> +	uint64_t *src_pending;	     /**< Bitmap of source nodes (constant). */
> +	uint16_t nb_sched_words;     /**< Number of uint64_t words in pending bitmaps. */
>  	uint8_t model;		     /**< graph model */
> -	uint8_t reserved1;	     /**< Reserved for future use. */
> -	uint16_t reserved2;	     /**< Reserved for future use. */
> +	/* 26 bytes padding */
>  	union {
>  		/* Fast schedule area for mcore dispatch model */
>  		struct {
> @@ -98,6 +97,7 @@ struct __rte_cache_aligned rte_node {
>  	rte_node_t id;		/**< Node identifier. */
>  	rte_node_t parent_id;	/**< Parent Node identifier. */
>  	rte_edge_t nb_edges;	/**< Number of edges from this node. */
> +	uint16_t sched_idx;	/**< Bit position in pending bitmap. */
>  	uint32_t realloc_count;	/**< Number of times realloced. */
>
>  	char parent[RTE_NODE_NAMESIZE];	/**< Parent node name. */
> @@ -132,7 +132,7 @@ struct __rte_cache_aligned rte_node {
>  		}; /**< Node Context. */
>  		uint16_t size;		/**< Total number of objects available. */
>  		uint16_t idx;		/**< Number of objects used. */
> -		rte_graph_off_t off;	/**< Offset of node in the graph reel. */
> +		rte_graph_off_t off;	/**< Offset of node in the graph memory. */
>  		uint64_t total_cycles;	/**< Cycles spent in this node. */
>  		uint64_t total_calls;	/**< Calls done to this node. */
>  		uint64_t total_objs;	/**< Objects processed by this node. */
> @@ -187,12 +187,12 @@ void __rte_node_stream_alloc_size(struct rte_graph *graph,
>  /**
>   * @internal
>   *
> - * Enqueue a given node to the tail of the graph reel.
> + * Process a node's pending objects and collect stats.
>   *
>   * @param graph
>   *   Pointer Graph object.
>   * @param node
> - *   Pointer to node object to be enqueued.
> + *   Pointer to node object to be processed.
>   */
>  static __rte_always_inline void
>  __rte_node_process(struct rte_graph *graph, struct rte_node *node)
> @@ -220,21 +220,42 @@ __rte_node_process(struct rte_graph *graph, struct rte_node *node)
>  /**
>   * @internal
>   *
> - * Enqueue a given node to the tail of the graph reel.
> + * Get a pointer to a node from the scheduling table.
>   *
>   * @param graph
>   *   Pointer Graph object.
> + * @param word
> + *   Offset in the pending bitmap.
> + * @param bit
> + *   Bit number.
> + *
> + * @return
> + *   Pointer to the node.
> + */
> +static __rte_always_inline struct rte_node *
> +__rte_graph_pending_node(struct rte_graph *graph, uint16_t word, uint16_t bit)
> +{
> +	const uint16_t index = (word * sizeof(*graph->pending) * CHAR_BIT) + bit;
> +	const rte_graph_off_t node_offset = graph->sched_table[index];
> +	return RTE_PTR_ADD(graph, node_offset);
> +}
> +
> +/**
> + * @internal
> + *
> + * Mark a node as pending in the graph scheduling bitmap.
> + *
> + * @param bitmap
> + *   Either graph->pending or graph->src_pending.
>   * @param node
> - *   Pointer to node object to be enqueued.
> + *   Pointer to node object to be marked pending.
>   */
>  static __rte_always_inline void
> -__rte_node_enqueue_tail_update(struct rte_graph *graph, struct rte_node *node)
> +__rte_node_pending_set(uint64_t *bitmap, struct rte_node *node)
>  {
> -	uint32_t tail;
> -
> -	tail = graph->tail;
> -	graph->cir_start[tail++] = node->off;
> -	graph->tail = tail & graph->cir_mask;
> +	const uint16_t word = node->sched_idx / (sizeof(*bitmap) * CHAR_BIT);
> +	const uint16_t bit = node->sched_idx % (sizeof(*bitmap) * CHAR_BIT);
> +	bitmap[word] |= 1ULL << bit;
>  }
>
>  /**
> @@ -242,8 +263,8 @@ __rte_node_enqueue_tail_update(struct rte_graph *graph, struct rte_node *node)
>   *
>   * Enqueue sequence prologue function.
>   *
> - * Updates the node to tail of graph reel and resizes the number of objects
> - * available in the stream as needed.
> + * Marks the node as pending in the scheduling bitmap and resizes the number
> + * of objects available in the stream as needed.
>   *
>   * @param graph
>   *   Pointer to the graph object.
> @@ -259,9 +280,8 @@ __rte_node_enqueue_prologue(struct rte_graph *graph, struct rte_node *node,
>  			    const uint16_t idx, const uint16_t space)
>  {
>
> -	/* Add to the pending stream list if the node is new */
>  	if (idx == 0)
> -		__rte_node_enqueue_tail_update(graph, node);
> +		__rte_node_pending_set(graph->pending, node);
>
>  	if (unlikely(node->size < (idx + space)))
>  		__rte_node_stream_alloc_size(graph, node, node->size + space);
> @@ -293,7 +313,7 @@ __rte_node_next_node_get(struct rte_node *node, rte_edge_t next)
>
>  /**
>   * Enqueue the objs to next node for further processing and set
> - * the next node to pending state in the circular buffer.
> + * the next node to pending state in the scheduling bitmap.
>   *
>   * @param graph
>   *   Graph pointer returned from rte_graph_lookup().
> @@ -321,7 +341,7 @@ rte_node_enqueue(struct rte_graph *graph, struct rte_node *node,
>
>  /**
>   * Enqueue only one obj to next node for further processing and
> - * set the next node to pending state in the circular buffer.
> + * set the next node to pending state in the scheduling bitmap.
>   *
>   * @param graph
>   *   Graph pointer returned from rte_graph_lookup().
> @@ -347,7 +367,7 @@ rte_node_enqueue_x1(struct rte_graph *graph, struct rte_node *node,
>
>  /**
>   * Enqueue only two objs to next node for further processing and
> - * set the next node to pending state in the circular buffer.
> + * set the next node to pending state in the scheduling bitmap.
>   * Same as rte_node_enqueue_x1 but enqueue two objs.
>   *
>   * @param graph
> @@ -377,7 +397,7 @@ rte_node_enqueue_x2(struct rte_graph *graph, struct rte_node *node,
>
>  /**
>   * Enqueue only four objs to next node for further processing and
> - * set the next node to pending state in the circular buffer.
> + * set the next node to pending state in the scheduling bitmap.
>   * Same as rte_node_enqueue_x1 but enqueue four objs.
>   *
>   * @param graph
> @@ -414,7 +434,7 @@ rte_node_enqueue_x4(struct rte_graph *graph, struct rte_node *node,
>
>  /**
>   * Enqueue objs to multiple next nodes for further processing and
> - * set the next nodes to pending state in the circular buffer.
> + * set the next nodes to pending state in the scheduling bitmap.
>   * objs[i] will be enqueued to nexts[i].
>   *
>   * @param graph
> @@ -472,7 +492,7 @@ rte_node_next_stream_get(struct rte_graph *graph, struct rte_node *node,
>  }
>
>  /**
> - * Put the next stream to pending state in the circular buffer
> + * Put the next stream to pending state in the scheduling bitmap
>   * for further processing. Should be invoked after rte_node_next_stream_get().
>   *
>   * @param graph
> @@ -496,8 +516,7 @@ rte_node_next_stream_put(struct rte_graph *graph, struct rte_node *node,
>
>  	node = __rte_node_next_node_get(node, next);
>  	if (node->idx == 0)
> -		__rte_node_enqueue_tail_update(graph, node);
> -
> +		__rte_node_pending_set(graph->pending, node);
>  	node->idx += idx;
>  }
>
> @@ -530,7 +549,7 @@ rte_node_next_stream_move(struct rte_graph *graph, struct rte_node *src,
>  		src->objs = dobjs;
>  		src->size = dsz;
>  		dst->idx = src->idx;
> -		__rte_node_enqueue_tail_update(graph, dst);
> +		__rte_node_pending_set(graph->pending, dst);
>  	} else { /* Move the objects from src node to dst node */
>  		rte_node_enqueue(graph, src, next, src->objs, src->idx);
>  	}
> --
> 2.54.0
>
