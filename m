Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84C9C369BD
	for <dpdk-dev@archiver.kernel.org>; Sat, 19 Apr 2025 10:11:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DE3D40265;
	Sat, 19 Apr 2025 12:11:43 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 3D4DA40156
 for <dev@dpdk.org>; Sat, 19 Apr 2025 12:11:41 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53J9ol8H016176;
 Sat, 19 Apr 2025 03:11:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=A
 oMnEdCMf9ZyeNOHAoMZCkv3gkpokXMm+AdtFxStHmo=; b=JoyMor3tfpMs4LLwn
 qyaiML2pEMJV4/ieqPe75dhCgVlojYbyLVedjDJ2m0FniA7QTK/pHPfU1HZPn1e9
 11KOZs2TufDR6oxEpUwpEb5pu8cJ+gvRDUqXJvKPsnaddUU9cfnMR194FV3K1jWE
 4r4TfvktmADovKO0UOjLwT0SQgOntUi++jwXFZ54zTAdx9BsARDT6zmLpP4w9LlU
 KzpHS47ie9jE7u6vnjihaTJFZqSUtMbIuQQhGQ5Cy6MC593JEUqpCBkpuPt9SGoU
 wS0pLFIZ/zElDjQzxmIjStxkRPFLxz6OnHCIo2EYO7CA0ORR6ZQHQMjTJYTvHWpO
 2mb7g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4629a6783f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 19 Apr 2025 03:11:34 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 19 Apr 2025 03:11:33 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 19 Apr 2025 03:11:33 -0700
Received: from cavium-PowerEdge-R640.. (unknown [10.28.36.207])
 by maili.marvell.com (Postfix) with ESMTP id 7BB025E6891;
 Sat, 19 Apr 2025 03:11:30 -0700 (PDT)
From: Nitin Saxena <nsaxena@marvell.com>
To: Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>, Zhirun Yan
 <yanzhirun_163@163.com>, Robin Jarry <rjarry@redhat.com>,
 Christophe Fontaine <cfontain@redhat.com>
CC: <dev@dpdk.org>, Nitin Saxena <nsaxena16@gmail.com>
Subject: [PATCH v8 0/5] add feature arc in rte_graph
Date: Sat, 19 Apr 2025 15:41:17 +0530
Message-ID: <20250419101124.1410233-1-nsaxena@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250103060612.2671836-1-nsaxena@marvell.com>
References: <20250103060612.2671836-1-nsaxena@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 2ZBJh0VI4xwrJ1lO-5hGDtvd5gmhPhfv
X-Proofpoint-ORIG-GUID: 2ZBJh0VI4xwrJ1lO-5hGDtvd5gmhPhfv
X-Authority-Analysis: v=2.4 cv=ZobtK87G c=1 sm=1 tr=0 ts=680376d6 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=XR8D0OoHHMoA:10 a=NEAV23lmAAAA:8 a=0A_AvAqZAcpRaedzLnUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-19_04,2025-04-17_01,2024-11-22_01
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

Feature arc represents an ordered list of features/protocols at a given
networking layer. It is a high level abstraction to express relationship
between rte_graph nodes, as feature nodes, and allow packets steering
across these nodes in a simplified manner.

Features (or feature nodes) are nodes which handles partial or complete
handling of a protocol in fast path. Like ipv4-rewrite node, which adds
rewrite data to an outgoing IPv4 packet.

However in above example, outgoing interface(say "eth0") may have
outbound IPsec policy enabled, hence packets must be steered from
ipv4-rewrite node to outbound-IPsec-policy node. On the other hand,
packets routed to another interface (say eth1) must ot be sent to
IPsec node, as IPsec feature is disabled on eth1. Feature-arc allows
rte_graph applications to manage such constraints easily

Feature arc abstraction allows rte_graph based application to

1. Runtime enable/disable features on an index (like interface), so that
if a feature is enabled at runtime, only then packets associated with
that interface will steer to corresponding feature node. Control plane
enables/disables features. Features enabled on one interface may not be
enabled on another interface with in a same feature arc.

2. Single feature arc represents a hook point at a network layer in an
given direction. Multiple feature arcs can be added in desginated nodes
to add various hook points in stack. Likt IPv4-output, IPv4-input,
IPv6-output, IPv6-input, ethernet-input, mpls-input, mpls-output etc.

3. Hook custom/out-of-tree nodes to DPDK in-built nodes and allow packet
steering from in-built node to custom node without requiring changes to
in-built fast path function

4. Express features in a particular sequential order so that
packets are steered in an ordered way across nodes in fast path. For
eg: if IPsec and IPv4 features are enabled on an ingress interface,
packets must be sent to IPsec inbound policy node first and then to ipv4
lookup node.

This patch series adds feature arc library in rte_graph and also adds
"ipv4-output" feature arc handling in "ipv4-rewrite" node.

Changes in v8:
- Fix CI iol testing

Changes in v7:
- Rebased to latest main for DPDK-25.07
- Added override_index_cb() in RTE_GRAPH_FEATURE_REGISTER() to allow
  features to take control of "max_index" (passed to
  rte_graph_feature_arc_create())
- Streamlined fast path APIs to make them more simpler
- Added quad_loop in "if_tx_feature" node
- Added functional test cases and fixed bugs
- Based on feedback from Redhat on v6 patches, it was tried to move
  feature arc APIs inside rte_graph library (to reduce node burden) but
  it was adding 4% performance regression for L3fwd usecase. For
  interested users: https://github.com/nsaxena16/dpdk/pull/2

Changes in v6:
- Rebased to latest main for DPDK-25.03
- Added constructor based feature arc/feature registration
- Changed design to handle fast path synchronization via RCU mechanism
  when any feature is enabled or disabled
- Added feature arc specific mbuf dynamic field to carry feature data
  across nodes
- Added feature arc example in app/graph
- Programming guide and functional test cases in future versions

Nitin Saxena (5):
  graph: add API to override node process function
  graph: add feature arc abstraction
  ip4: add ip4 output feature arc
  app/graph: add custom feature nodes for ip4 output arc
  test/graph_feature_arc: add functional tests

 app/graph/commands.list                  |    6 +
 app/graph/feature.c                      |  141 ++
 app/graph/feature.h                      |   13 +
 app/graph/graph.c                        |    4 +
 app/graph/ip4_output_hook.c              |  174 ++
 app/graph/main.c                         |   15 +-
 app/graph/meson.build                    |    2 +
 app/graph/module_api.h                   |    2 +
 app/test/meson.build                     |    1 +
 app/test/test_graph_feature_arc.c        | 1374 +++++++++++++++
 doc/api/doxy-api-index.md                |    2 +
 doc/guides/rel_notes/release_25_07.rst   |   10 +
 lib/graph/graph_feature_arc.c            | 2050 ++++++++++++++++++++++
 lib/graph/graph_private.h                |   15 +
 lib/graph/meson.build                    |    4 +-
 lib/graph/node.c                         |   23 +
 lib/graph/rte_graph_feature_arc.h        |  628 +++++++
 lib/graph/rte_graph_feature_arc_worker.h |  607 +++++++
 lib/node/ethdev_ctrl.c                   |    8 +
 lib/node/interface_tx_feature.c          |  213 +++
 lib/node/interface_tx_feature_priv.h     |   33 +
 lib/node/ip4_rewrite.c                   |  286 ++-
 lib/node/meson.build                     |    1 +
 lib/node/node_private.h                  |    1 +
 lib/node/rte_node_ip4_api.h              |    4 +
 25 files changed, 5608 insertions(+), 9 deletions(-)
 create mode 100644 app/graph/feature.c
 create mode 100644 app/graph/feature.h
 create mode 100644 app/graph/ip4_output_hook.c
 create mode 100644 app/test/test_graph_feature_arc.c
 create mode 100644 lib/graph/graph_feature_arc.c
 create mode 100644 lib/graph/rte_graph_feature_arc.h
 create mode 100644 lib/graph/rte_graph_feature_arc_worker.h
 create mode 100644 lib/node/interface_tx_feature.c
 create mode 100644 lib/node/interface_tx_feature_priv.h

--
2.43.0

