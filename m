Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C629C369AB
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Apr 2025 12:11:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50022402A1;
	Tue, 15 Apr 2025 14:11:11 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 4ADF340289
 for <dev@dpdk.org>; Tue, 15 Apr 2025 14:11:10 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F72q6P031484;
 Tue, 15 Apr 2025 05:11:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=1Q56JZ2Na+jHQxlwwixjZwE
 lbV6zNpg5X2ZoGL3bES8=; b=atqjYMbtsmRUC2xGsAewMzIhy10y/hPAFK0Pip8
 oqxrOAGy2epfaLi/8INb526Wj81UmeGOO7sXJOOLrbdZkL8Un2JdoAbxX4tdmN4y
 Wfjq/gVHjzby6rwneo+Y/a/cikV01fPYzI68qWYFZHIQGLlDvThpqrpa7oh95s9Z
 8SgATPx48+ItFj/UMnxd0Er5B1EvcRd+2GxUK67NmqcK/z8+/2JpOSoAKc4FUIey
 0pra2WS6NxHqrGmHZeyHjJAV5/gyrbzpwxT9SHAD6gbjmNbe/uEycmEMjEEEMfYd
 9O2aNKXSWEarjkkUL9ITEkBSSgucjcIubNwed9cL7aifCvw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 460cebn0a8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Apr 2025 05:11:09 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 15 Apr 2025 05:11:08 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 15 Apr 2025 05:11:08 -0700
Received: from localhost.localdomain (unknown [10.28.36.185])
 by maili.marvell.com (Postfix) with ESMTP id 5B66B67398;
 Tue, 15 Apr 2025 05:11:05 -0700 (PDT)
From: Ankur Dwivedi <adwivedi@marvell.com>
To: <dev@dpdk.org>
CC: <jerinj@marvell.com>, <vladimir.medvedkin@intel.com>,
 <ndabilpuram@marvell.com>, <pbhagavatula@marvell.com>,
 <skori@marvell.com>, <rkudurumalla@marvell.com>,
 Ankur Dwivedi <adwivedi@marvell.com>
Subject: [PATCH v1 00/12] add lookup fib nodes in graph library
Date: Tue, 15 Apr 2025 17:40:40 +0530
Message-ID: <20250415121052.1497155-1-adwivedi@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: T-abdqYma1dAbZvcWy_2Mw_QQf0TlX9_
X-Authority-Analysis: v=2.4 cv=UJfdHDfy c=1 sm=1 tr=0 ts=67fe4cdd cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=XR8D0OoHHMoA:10 a=i4bR1e3tFpyGIuxOOCsA:9
X-Proofpoint-GUID: T-abdqYma1dAbZvcWy_2Mw_QQf0TlX9_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_05,2025-04-10_01,2024-11-22_01
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

This patch series adds two inbuilt nodes ip4_lookup_fib and
ip6_lookup_fib in graph library. These nodes uses the existing
Forwarding Information Base (FIB) library to create FIB, to do
route addition and route lookup.

Two new commands (for ipv4 and ipv6) for providing the lookup mode
is added in the dpdk-graph application. fib or lpm can be given as
lookup mode. If these new lookup mode commands are not given, the
dpdk-graph uses lpm (Longest Prefix Match) or lpm6 by default.
If fib is given as lookup mode then the ip4_lookup_fib or ip6_lookup_fib
nodes are used by the application.


Ankur Dwivedi (12):
  fib: move macro to header file
  node: add IP4 lookup FIB node
  node: add IP4 FIB route add
  node: add process callback for IP4 FIB
  node: add next node in packet classification
  app/graph: add IP4 lookup mode command
  fib: move macro to header file
  node: add IP6 lookup FIB node
  node: add IP6 FIB route add
  node: add process callback for IP6 FIB
  node: add next node in packet classification
  app/graph: add IP6 lookup mode command

 app/graph/commands.list     |   2 +
 app/graph/ip4_route.c       |  34 +++-
 app/graph/ip6_route.c       |  33 +++-
 app/graph/l3fwd.c           |  24 +++
 app/graph/module_api.h      |  13 ++
 doc/guides/tools/graph.rst  |  24 ++-
 lib/fib/rte_fib.c           |   3 -
 lib/fib/rte_fib.h           |   3 +
 lib/fib/rte_fib6.c          |  11 +-
 lib/fib/rte_fib6.h          |   3 +
 lib/node/ip4_lookup_fib.c   | 327 ++++++++++++++++++++++++++++++++++++
 lib/node/ip6_lookup_fib.c   | 316 ++++++++++++++++++++++++++++++++++
 lib/node/meson.build        |   4 +-
 lib/node/pkt_cls.c          |   2 +
 lib/node/pkt_cls_priv.h     |   2 +
 lib/node/rte_node_ip4_api.h |  19 +++
 lib/node/rte_node_ip6_api.h |  19 +++
 17 files changed, 812 insertions(+), 27 deletions(-)
 create mode 100644 lib/node/ip4_lookup_fib.c
 create mode 100644 lib/node/ip6_lookup_fib.c

-- 
2.25.1

