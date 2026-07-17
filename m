Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9C5C44515
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 09:04:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7BE7840A7F;
	Fri, 17 Jul 2026 11:04:48 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4D95B4028A
 for <dev@dpdk.org>; Fri, 17 Jul 2026 11:04:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784279085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0Lj1S69pDpfvAMgcGm9Gas7ragM7bPQkcjs9AJ0eNac=;
 b=aQvVeGI4UOWJ+Nk0G6d9bXMe/bVPwozgnuSNnVVwCCs6MOManqaDR3/EXfduZTLaDpm5sF
 vMsCW7Jhe3Q65Zsbv+tnKZXYdyevoXLL4n1TX8GLCogkiiZUj7huRD1Vz1k2sjpzSbxkQw
 GMs9qOSDZc+x6sY1kafYLrlLsgEBOSw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-vVrEJV8XMdGTpVEwhyeXIA-1; Fri,
 17 Jul 2026 05:04:42 -0400
X-MC-Unique: vVrEJV8XMdGTpVEwhyeXIA-1
X-Mimecast-MFC-AGG-ID: vVrEJV8XMdGTpVEwhyeXIA_1784279080
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AFA551954B37; Fri, 17 Jul 2026 09:04:40 +0000 (UTC)
Received: from ringo.redhat.com (unknown [10.44.33.106])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 23CFC180036E; Fri, 17 Jul 2026 09:04:36 +0000 (UTC)
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
Subject: [PATCH dpdk/26.11 v3 0/2] graph: topological bitmap scheduling
Date: Fri, 17 Jul 2026 11:03:24 +0200
Message-ID: <20260717090326.1860634-1-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: L7fV_e-Zo9_e4h48k5st3m2Q5aeL6VvowTDBhzvk45Q_1784279080
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
 lib/graph/graph.c                             |   27 +-
 lib/graph/graph_debug.c                       |   12 +-
 lib/graph/graph_ops.c                         |   46 +
 lib/graph/graph_populate.c                    |  107 +-
 lib/graph/graph_private.h                     |   41 +-
 lib/graph/rte_graph_model_mcore_dispatch.h    |   34 +-
 lib/graph/rte_graph_model_rtc.h               |   63 +-
 lib/graph/rte_graph_worker.h                  |    2 +-
 lib/graph/rte_graph_worker_common.h           |   78 +-
 12 files changed, 1158 insertions(+), 1234 deletions(-)

-- 
2.55.0

