Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2793E9129A
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 09:27:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16E754026D;
	Thu,  5 Feb 2026 10:27:03 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 725CE40264
 for <dev@dpdk.org>; Thu,  5 Feb 2026 10:27:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770283620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wHnVuSXjA7eQZfSJM3NeYPqg6VtfI2O9/noPYrwXQu8=;
 b=MZZea+4xONjGD16B55V1JgtLXBsWxLeKaYmafcD6zZkhoeh1mxOSsYokKcfZEq9Q3IQWgU
 uJPKFRyUQOWujeAtP2Qq92CvJQQHptRDWV9ktIRhgDiKhG3jHLNM1G+g5dTjBL0N1RLgKY
 47LskYI/HZf+WA4WWeOCo+XfxGt9rqU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-bckAQe8UM3yiYgTPbtoTfg-1; Thu,
 05 Feb 2026 04:26:59 -0500
X-MC-Unique: bckAQe8UM3yiYgTPbtoTfg-1
X-Mimecast-MFC-AGG-ID: bckAQe8UM3yiYgTPbtoTfg_1770283618
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B89381955F20; Thu,  5 Feb 2026 09:26:58 +0000 (UTC)
Received: from ringo.home (unknown [10.44.33.219])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 70599300DDA1; Thu,  5 Feb 2026 09:26:57 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org
Cc: Jerin Jacob <jerinj@marvell.com>
Subject: [RFC PATCH dpdk 0/3] graph: deferred enqueue API for simplified node
 processing
Date: Thu,  5 Feb 2026 10:26:32 +0100
Message-ID: <20260205092630.100488-6-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 22VveJl8J-QU_aNhKBmkckieqKnwBRpyFV_Hq9WVWyg_1770283618
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

This series introduces a deferred enqueue API for the graph library that
simplifies node development while maintaining performance.

The current node implementations use a manual speculation pattern where
each node pre-allocates destination buffer slots, tracks which packets
diverge from the speculated edge, and handles fixups at the end. This
results in complex boilerplate code with multiple local variables
(to_next, from, held, last_spec), memcpy calls, and stream get/put
operations repeated across every node.

The new rte_node_enqueue_deferred() API handles this automatically:
- Tracks runs of consecutive packets going to the same edge
- Flushes runs in bulk when the edge changes
- Uses rte_node_next_stream_move() (pointer swap) when all packets
  go to the same destination
- Preserves last_edge across invocations for cross-batch speculation

The deferred state is stored in the node's fast-path cache line 1,
alongside xstat_off, keeping frequently accessed data together.

Performance was measured with l3fwd forwarding between two ports of an
Intel E810-XXV 2x25G NIC (1 RX queue per port). Two graph worker threads
ran on hyper threads of the same physical core on an Intel Xeon Silver
4316 CPU @ 2.30GHz.

Results:
- Baseline (manual speculation): 37.0 Mpps
- Deferred API:                  36.2 Mpps (-2.2%)

The slight overhead comes from per-packet edge comparisons. However,
this is offset by:
- 826 fewer lines of code across 13 node implementations
- Reduced instruction cache pressure from simpler code paths
- Elimination of per-node speculation boilerplate
- Easier development of new nodes

Robin Jarry (3):
  graph: optimize rte_node_enqueue_next to batch by edge
  graph: add deferred enqueue API for batch processing
  node: use deferred enqueue API in process functions

 app/graph/ip4_output_hook.c         |  35 +-------
 lib/graph/graph_populate.c          |   1 +
 lib/graph/rte_graph_worker_common.h |  90 ++++++++++++++++++-
 lib/node/interface_tx_feature.c     | 105 +++-------------------
 lib/node/ip4_local.c                |  36 +-------
 lib/node/ip4_lookup.c               |  37 +-------
 lib/node/ip4_lookup_fib.c           |  36 +-------
 lib/node/ip4_lookup_neon.h          | 100 ++-------------------
 lib/node/ip4_lookup_sse.h           | 100 ++-------------------
 lib/node/ip4_rewrite.c              | 120 +++----------------------
 lib/node/ip6_lookup.c               |  95 ++------------------
 lib/node/ip6_lookup_fib.c           |  34 +-------
 lib/node/ip6_rewrite.c              | 118 +++----------------------
 lib/node/pkt_cls.c                  | 130 +++-------------------------
 lib/node/udp4_input.c               |  42 +--------
 15 files changed, 170 insertions(+), 909 deletions(-)

-- 
2.52.0

