Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B884BCC6B34
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 14:32:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C34FB402DF;
	Thu, 15 Oct 2026 16:32:21 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id A3D3E4027C
 for <dev@dpdk.org>; Thu, 15 Oct 2026 16:32:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792074740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UezQ6u+z13G04TdpK/NcYBkzIrlGaS0CA74qcsWWP0Q=;
 b=bFNZvvPcsLsPVAXj+dANiyPUWz2BYDmhBKdPnNj3eh3IMgmqYcktcJeF4jeV11p/azy+a8
 yccAAiV56HKggPEoBJBjVYPpVOCTjBuUWMWRdeVAHB9e3VLPOb5bHpnQYO0o3YUA+98s4+
 ZLYNSWzOikYU16PuKoN0O1joeYnWIyI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-WxL2u-_sNSq15OaASQ6QXA-1; Thu,
 15 Oct 2026 14:32:15 +0000
X-MC-Unique: WxL2u-_sNSq15OaASQ6QXA-1
X-Mimecast-MFC-AGG-ID: WxL2u-_sNSq15OaASQ6QXA_1792074734
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B79621955F40; Thu, 15 Oct 2026 14:32:13 +0000 (UTC)
Received: from ringo.home (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E735D1955F1C; Thu, 15 Oct 2026 14:32:10 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org
Cc: Christophe Fontaine <cfontain@redhat.com>,
 David Marchand <david.marchand@redhat.com>,
 Jerin Jacob <jerinj@marvell.com>,
 Kiran Kumar Kokkilagadda <kirankumark@marvell.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Maxime Leroy <maxime@leroys.fr>,
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: [PATCH dpdk/26.11 v4 0/2] graph: topological bitmap scheduling
Date: Thu, 15 Oct 2026 16:31:24 +0200
Message-ID: <20261015143122.3197430-5-rjarry@redhat.com>
In-Reply-To: <20260717090326.1860634-1-rjarry@redhat.com>
References: <20260717090326.1860634-1-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jMlJm03-oEuLs45fU0c3S1LoTLKiO6XvYe18ej1Sdfc_1792074734
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

Replace the FIFO circular buffer in rte_graph with a bitmap and a
topologically-sorted schedule table. The old circular buffer appended
nodes in enqueue order, effectively a partial DFS driven by per-node
process functions. This caused convergence nodes to be visited before
all upstream branches had run, resulting in redundant visits with
smaller batches.

Nodes are now sorted by (topo_order, node_id) using BFS depth from
source nodes, ensuring upstream nodes are always visited before
downstream ones. The diamond perf test shows a ~10% throughput
improvement (converge visited once at 256 objs/call instead of twice
at 128).

Changes v3 -> v4:
 - fixed check_includes error after RTE_PTR_ADD() changes
 - s/__rte_always_inline/inline/ to fix checkpatch warnings
 - removed entry from deprecation notice
 - added release notes entries

Changes v2 -> v3:
 - dropped explicit priority field (int16_t) from rte_node_register
   and struct node; topological ordering from BFS is sufficient
 - removed hiprio worker node type from diamond test; topo_order
   alone provides correct ordering without user intervention
 - updated documentation and SVG diagram accordingly

Changes v1 -> v2:
 - split diamond perf test into separate preparatory patch
 - added topological depth (topo_order) as secondary sort key to
   preserve upstream-before-downstream ordering, preventing a
   regression in the reverse tree test
 - restored idx == 0 guard on bitmap set in the enqueue path to
   avoid a ~15% throughput regression caused by touching the pending
   bitmap cache line on every enqueue call
 - added performance numbers measured before and after

Cc: Christophe Fontaine <cfontain@redhat.com>
Cc: David Marchand <david.marchand@redhat.com>
Cc: Jerin Jacob <jerinj@marvell.com>
Cc: Kiran Kumar Kokkilagadda <kirankumark@marvell.com>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: Maxime Leroy <maxime@leroys.fr>
Cc: Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>
Cc: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: Zhirun Yan <yanzhirun_163@163.com>

Robin Jarry (2):
  graph: add diamond topology performance test
  graph: replace circular buffer with topological bitmap

 app/test/test_graph_perf.c                    |  130 +-
 doc/guides/prog_guide/graph_lib.rst           |   29 +-
 .../prog_guide/img/graph_mem_layout.svg       | 1823 +++++++----------
 doc/guides/rel_notes/deprecation.rst          |    8 -
 doc/guides/rel_notes/release_26_11.rst        |   11 +
 lib/graph/graph.c                             |   27 +-
 lib/graph/graph_debug.c                       |   12 +-
 lib/graph/graph_ops.c                         |   46 +
 lib/graph/graph_populate.c                    |  107 +-
 lib/graph/graph_private.h                     |   41 +-
 lib/graph/rte_graph_model_mcore_dispatch.h    |   34 +-
 lib/graph/rte_graph_model_rtc.h               |   63 +-
 lib/graph/rte_graph_worker.h                  |    2 +-
 lib/graph/rte_graph_worker_common.h           |   80 +-
 14 files changed, 1170 insertions(+), 1243 deletions(-)

-- 
2.56.0

