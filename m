Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C267CD4F5B
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 21:38:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11171402B5;
	Tue, 19 May 2026 23:38:35 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id EC106402AA
 for <dev@dpdk.org>; Tue, 19 May 2026 23:38:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779226713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8lP+E4KpwvCW0IvViFl7zEhmIfFL8eYKenCc/RqrcZI=;
 b=KQR8G+z4xyvpedbapKovQK8Ukv3u31uAw89Jd68vwagVSYtTSuzLlpaCBCVQRSLEleR5CU
 8E4bc4pbD8CdxClSvNgwmzRq8TvTfy8eZj5sBOrEUQP1vdyzNyOiAcbbUf4dUgY1FIG8yY
 j0bwiJTdLC00FdSksnlb/EKRADo7hfo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-0HnZbejJO3iXMuE1NUzIGA-1; Tue,
 19 May 2026 17:38:32 -0400
X-MC-Unique: 0HnZbejJO3iXMuE1NUzIGA-1
X-Mimecast-MFC-AGG-ID: 0HnZbejJO3iXMuE1NUzIGA_1779226709
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 358151956095; Tue, 19 May 2026 21:38:29 +0000 (UTC)
Received: from ringo.redhat.com (unknown [10.44.48.86])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 114B01684; Tue, 19 May 2026 21:38:24 +0000 (UTC)
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
Subject: [PATCH dpdk v2 0/2] graph: priority-based bitmap scheduling
Date: Tue, 19 May 2026 23:38:20 +0200
Message-ID: <20260519213822.735891-1-rjarry@redhat.com>
In-Reply-To: <20260519101232.541102-2-rjarry@redhat.com>
References: <20260519101232.541102-2-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PQupBolnDofdvOPhIekmnqpBhZ9HisCY5pv1H3rCBPg_1779226709
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
priority-sorted schedule table. Nodes with lower priority values are
visited first during the graph walk. Source nodes are forced to
INT16_MIN. Topological depth from BFS ensures upstream-before-downstream
ordering when all priorities are equal.

In fan-out-then-converge topologies, setting a higher priority (lower
value) on branch nodes avoids redundant visits to the converge node.
The diamond perf test shows a ~10% throughput improvement (converge
visited once at 256 objs/call instead of twice at 128).

Changes v1 -> v2:
 - added diamond perf test into separate preparatory patch
 - added topological depth (topo_order) as secondary sort key to preserve
   FIFO-like upstream-before-downstream ordering for default priorities,
   preventing a regression in the reverse tree test
 - restored idx == 0 guard on bitmap set in the enqueue path to avoid a
   ~15% throughput regression caused by touching the pending bitmap
   cache line on every enqueue call
 - use hiprio worker nodes in diamond test to demonstrate the actual
   priority-based scheduling benefit
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
  graph: replace circular buffer with priority-based bitmap

 app/test/test_graph_perf.c                    |  140 +-
 doc/guides/prog_guide/graph_lib.rst           |   37 +-
 .../prog_guide/img/graph_mem_layout.svg       | 1823 +++++++----------
 lib/graph/graph.c                             |   27 +-
 lib/graph/graph_debug.c                       |   12 +-
 lib/graph/graph_ops.c                         |   46 +
 lib/graph/graph_populate.c                    |  119 +-
 lib/graph/graph_private.h                     |   42 +-
 lib/graph/node.c                              |    2 +
 lib/graph/rte_graph.h                         |    1 +
 lib/graph/rte_graph_model_mcore_dispatch.h    |   34 +-
 lib/graph/rte_graph_model_rtc.h               |   65 +-
 lib/graph/rte_graph_worker.h                  |    2 +-
 lib/graph/rte_graph_worker_common.h           |   79 +-
 14 files changed, 1194 insertions(+), 1235 deletions(-)

-- 
2.54.0

