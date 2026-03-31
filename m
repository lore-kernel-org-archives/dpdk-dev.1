Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4591061B2B
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 03:10:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64CFB40285;
	Tue, 31 Mar 2026 05:10:12 +0200 (CEST)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id 5F8F04025E
 for <dev@dpdk.org>; Tue, 31 Mar 2026 05:10:11 +0200 (CEST)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-35d8e548a05so3248541a91.1
 for <dev@dpdk.org>; Mon, 30 Mar 2026 20:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774926610;
 x=1775531410; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Ct9FKYHiiFKvthLuJ9fxl/9tO85tQgWBSu9SOJvO/w=;
 b=gdJOMhtGYeFkq5oFRa/8tKeHVtDiypCV/Amo2Bwlsvx7EBFa2NxShVBuWlWiIwmuXc
 N6Nuwp3SOiCuGBLUcoXjd7irbhO5/Jo2DOTRZVxT4oFOYgJcd/JI8P//z42U4KpTpg4r
 Se+5b4R6rrFNFoqaCX9WA6XKqCmEnEqXhe8DYaCXvh+rXXnarPkCOL/1cfB3mWv/PBTu
 PaJ8re5tjvF5yKsFACBaYfUc2VUw638uIGJg/pLAmV2JXYB5PdniJOaCxferJxh/5yMc
 fxf7apIq/d1RwQhkI4ddTEwKsv53Dq4GIVMLkYc20tDTa7dlh3sKb9ClP9J6GT2Zy3Ge
 3MOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774926610; x=1775531410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0Ct9FKYHiiFKvthLuJ9fxl/9tO85tQgWBSu9SOJvO/w=;
 b=CUpXPIvshOiEWQnyXOtOArNjsS6V5iAQGnG+qBen8JJTZBkl2lE5tdcyaplY9DkVnp
 0PO8oc6ExBZSeUX6JwzdXAtQz0m3RY245krQb0RZy9uHchYoyNcNXJHGpsO2lxb6EaAt
 F+h2JY1/hheosvzmWM2MFDnn8IvcuKZ8tR6zlm4MqhICmDE2XrUd8ekk7cJX+G35GSu8
 qSFYitT/p6AHZsDNYEVGq0UklbrN8RVGT4bORDwaRmisy45pcaYbNW+9bqlkiSYo/Duv
 2R0N+emFq1b/c22kXTFgTPh4F9hHMFoSEn0pnb+6zdOGIut6dT8tjkL3ZbPfJ+usXsES
 2baA==
X-Gm-Message-State: AOJu0YyluCCopAT8Uc1nlQo3MpbC6hoRMr51iv5RnekQpAaYD5zh/QgH
 7lq6lKNwAeLqjmTqjaHUD3voCXxI+qENQDRAMDi3mg5XrYzvLlrbI36h8G7sQ7xpM+u3y2c/tJJ
 ib7eP
X-Gm-Gg: ATEYQzyHjpvPUXyR1kuWtsetfSHbnmAX9TAi7Swn/fHAk90sQZpdqJGEzOFu7d8R3b/
 5Ad4VJqHmpwBtuRa75DmO84QRrftVq516h2YdGYJa8TRNl6HuEwqCqT7/Gj+QlX+2mx32KOwAUu
 0ouQNXJ8mFVN2efcSXa/ZXhUOUiBx/pQTRebu4ZKGkCZiXQTpiB99H+s8BK2VjcDM1dyyEFZddR
 hPy63sHhuWB5JoFR3CLYUv+zoeTJpk98+I9XCS+KEgCyOAu7NurWsr4TDbuczn7LtjWX8mgH5ma
 MwA5utwXiaI2JfTZoCsX7mPFG5aoxBz3bCHRcyKIWd26cXnhygPARH+IqdqNVFfGln+AbGNekj1
 Ubx+sP0k3KlfttChG1KtXksO42fZCkxI1UcHIzGUKkJYb4rCpmRNBK25D4hi1Js+Ch+V5PAHMVr
 9O3B0tQEk9DQ2J9wcZd/b7UbAWu3W+0zFc2FM=
X-Received: by 2002:a17:902:f60f:b0:2b2:5c31:24bf with SMTP id
 d9443c01a7336-2b25c3148admr29177615ad.19.1774926610221; 
 Mon, 30 Mar 2026 20:10:10 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2427663acsm93680785ad.46.2026.03.30.20.10.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 20:10:10 -0700 (PDT)
Date: Mon, 30 Mar 2026 20:10:01 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org, Jerin Jacob <jerinj@marvell.com>
Subject: Re: [RFC PATCH dpdk 0/3] graph: deferred enqueue API for simplified
 node processing
Message-ID: <20260330201001.1c0aaaf5@phoenix.local>
In-Reply-To: <20260205092630.100488-6-rjarry@redhat.com>
References: <20260205092630.100488-6-rjarry@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu,  5 Feb 2026 10:26:32 +0100
Robin Jarry <rjarry@redhat.com> wrote:

> This series introduces a deferred enqueue API for the graph library that
> simplifies node development while maintaining performance.
> 
> The current node implementations use a manual speculation pattern where
> each node pre-allocates destination buffer slots, tracks which packets
> diverge from the speculated edge, and handles fixups at the end. This
> results in complex boilerplate code with multiple local variables
> (to_next, from, held, last_spec), memcpy calls, and stream get/put
> operations repeated across every node.
> 
> The new rte_node_enqueue_deferred() API handles this automatically:
> - Tracks runs of consecutive packets going to the same edge
> - Flushes runs in bulk when the edge changes
> - Uses rte_node_next_stream_move() (pointer swap) when all packets
>   go to the same destination
> - Preserves last_edge across invocations for cross-batch speculation
> 
> The deferred state is stored in the node's fast-path cache line 1,
> alongside xstat_off, keeping frequently accessed data together.
> 
> Performance was measured with l3fwd forwarding between two ports of an
> Intel E810-XXV 2x25G NIC (1 RX queue per port). Two graph worker threads
> ran on hyper threads of the same physical core on an Intel Xeon Silver
> 4316 CPU @ 2.30GHz.
> 
> Results:
> - Baseline (manual speculation): 37.0 Mpps
> - Deferred API:                  36.2 Mpps (-2.2%)
> 
> The slight overhead comes from per-packet edge comparisons. However,
> this is offset by:
> - 826 fewer lines of code across 13 node implementations
> - Reduced instruction cache pressure from simpler code paths
> - Elimination of per-node speculation boilerplate
> - Easier development of new nodes
> 
> Robin Jarry (3):
>   graph: optimize rte_node_enqueue_next to batch by edge
>   graph: add deferred enqueue API for batch processing
>   node: use deferred enqueue API in process functions
> 
>  app/graph/ip4_output_hook.c         |  35 +-------
>  lib/graph/graph_populate.c          |   1 +
>  lib/graph/rte_graph_worker_common.h |  90 ++++++++++++++++++-
>  lib/node/interface_tx_feature.c     | 105 +++-------------------
>  lib/node/ip4_local.c                |  36 +-------
>  lib/node/ip4_lookup.c               |  37 +-------
>  lib/node/ip4_lookup_fib.c           |  36 +-------
>  lib/node/ip4_lookup_neon.h          | 100 ++-------------------
>  lib/node/ip4_lookup_sse.h           | 100 ++-------------------
>  lib/node/ip4_rewrite.c              | 120 +++----------------------
>  lib/node/ip6_lookup.c               |  95 ++------------------
>  lib/node/ip6_lookup_fib.c           |  34 +-------
>  lib/node/ip6_rewrite.c              | 118 +++----------------------
>  lib/node/pkt_cls.c                  | 130 +++-------------------------
>  lib/node/udp4_input.c               |  42 +--------
>  15 files changed, 170 insertions(+), 909 deletions(-)
> 

AI review comments:

Review: [RFC PATCH dpdk 1/3] graph: optimize rte_node_enqueue_next to batch by edge
        [RFC PATCH dpdk 2/3] graph: add deferred enqueue API for batch processing
        [RFC PATCH dpdk 3/3] node: use deferred enqueue API in process functions

This is a well-motivated series. The deferred enqueue API is a clean
abstraction that replaces the repetitive speculation boilerplate in
every node process function. The code reduction in patch 3 speaks
for itself -- roughly 900 lines of hand-rolled speculation logic
replaced with single-line rte_node_enqueue_deferred() calls.

Patch 1/3 - rte_node_enqueue_next batching

Error: Out-of-bounds read when nb_objs is 0.

  rte_edge_t last = nexts[0];

reads nexts[0] unconditionally. If nb_objs == 0, this is an
out-of-bounds access. The old code handled this correctly because
the loop `for (i = 0; i < nb_objs; i++)` would simply not execute.
Add a guard:

  if (nb_objs == 0)
      return;

Patch 2/3 - deferred enqueue API

Error: Flush in __rte_node_process fires for nodes that do not use
the deferred API, corrupting their data.

__rte_node_process now unconditionally checks:

  if (node->deferred_last_edge != RTE_EDGE_ID_INVALID)
      __rte_node_enqueue_deferred_flush(graph, node);

deferred_last_edge is initialized to RTE_EDGE_ID_INVALID at graph
populate time, but it is preserved across invocations ("Keep
deferred_last_edge from previous invocation for speculation"). Once
a deferred-API node sets it to a valid value, it will never be
reset to RTE_EDGE_ID_INVALID.

This means any node that uses the old manual speculation pattern
(rte_node_next_stream_move / stream_get / stream_put directly)
will have the flush fire after its process function returns,
because deferred_last_edge may be stale from a prior incarnation
or from the node's first call. The flush would then attempt
rte_node_next_stream_move based on the stale deferred_last_edge
and the current node->idx (which may still be non-zero because
stream_move does not zero src->idx).

Even though patch 3 converts all in-tree nodes, this is a public
API change in __rte_node_process that affects all node
implementations including third-party and out-of-tree nodes that
are compiled against the DPDK headers. Any node process function
that does not use rte_node_enqueue_deferred() will be silently
broken.

The fix is to ensure the flush only fires when the deferred API
was actually used during this invocation. For example, reset
deferred_last_edge to RTE_EDGE_ID_INVALID at the start of
__rte_node_process (instead of preserving it), or add a flag
that is set when rte_node_enqueue_deferred() is first called:

  /* Option A: reset each invocation (loses cross-batch
   * speculation but is safe) */
  node->deferred_last_edge = RTE_EDGE_ID_INVALID;

  /* Option B: add a "deferred_active" flag set by
   * rte_node_enqueue_deferred, cleared by flush */

Note that option A sacrifices the cross-batch speculation benefit
described in the commit message. Option B preserves speculation
but adds a branch and a byte to the cache line. The right choice
depends on how much the cross-batch speculation matters in
practice -- given the 2-3% overhead already mentioned, the
safety of option A may be preferable.

Warning: deferred_run_start and deferred_last_edge add 4 bytes to
cache line 1 of struct rte_node.

The commit says "stored in the node fast-path cache line 1,
keeping it close to other frequently accessed node data." Since
this is an ABI change to a public struct, it should be noted in
the release notes. Verify that the addition does not push other
hot fields out of the cache line or cross a cache line boundary.
The current cache line 1 only had xstat_off before this change,
so there is room, but this should be explicitly confirmed.

Warning: __rte_node_enqueue_deferred_flush uses node->idx after
the process function has potentially manipulated it.

The flush reads node->idx as "count" to determine how many
objects to flush. This relies on the invariant that the process
function did NOT modify node->idx. With the deferred API this
is true (the process function just calls
rte_node_enqueue_deferred which doesn't touch node->idx), but
this implicit contract is fragile and undocumented. If any
process function uses a mix of deferred and non-deferred enqueue
APIs, node->idx may not reflect the original object count. Add a
comment or assertion documenting this invariant.

Warning: the new API should be marked __rte_experimental.

rte_node_enqueue_deferred() is a new public inline function in an
installed header. Per DPDK policy, new APIs must be marked
__rte_experimental.

Patch 3/3 - node conversions

Warning: pkt_cls_node_process loses its cross-invocation l2l3_type
speculation state.

The old code saved the last packet type in ctx->l2l3_type and
used it as the speculative next index on the following invocation.
The new code removes the pkt_cls_node_ctx struct entirely and
relies on deferred_last_edge for speculation. This works because
deferred_last_edge maps to the next node edge, which is what the
old code was ultimately speculating on. However, the old code
speculated on the *packet type* (l2l3_type) which was then
mapped to the edge -- this two-level speculation could be more
precise if different packet types map to the same edge. In
practice, this is likely fine since the deferred API speculates
on the edge directly, which is what matters for performance.
This is noted for completeness.

Info: The conversions are mechanical and consistent across all
13 files. Each follows the same pattern: remove from/to_next/
held/last_spec/next_index variables, remove stream_get/put/
memcpy/enqueue_x1 logic, replace with
rte_node_enqueue_deferred(graph, node, next, i). The manual
`i` index tracking is correct in all cases -- the x4 loops
increment i by 4, the x1 tail loops by 1, matching the pkts
pointer increment in n_left_from.

Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
