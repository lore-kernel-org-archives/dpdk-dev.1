Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA0EC54FB3
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Jun 2025 06:36:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4CDFE40270;
	Mon,  2 Jun 2025 08:36:54 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id A47544026B
 for <dev@dpdk.org>; Mon,  2 Jun 2025 08:36:52 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5521jF5Y013924;
 Sun, 1 Jun 2025 23:36:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=k
 Mc/G21E8/sQ0kH50ArHNO0cheJm9bikQhfcBoJbX1Y=; b=lFEhvYwTVVIgFhVfx
 qqWvbNBFj5yMQe/cDiCaMqZ8sVt7j5/N6rmJpqOZHaVLRIvv0WV00gzEUvRGx0yX
 hiAb+dsYkbz11t0EVGishTQYvhQ23ehoTWX5sw5j7ihJfjHhJ4KBfqbqg5pIx0Wy
 1KGNHbNKtBLc3eu6+X670U/2gwCz1oVoMfyZzZw52If3U57wI+iOLQYQIRhr5V2l
 9lctJ1/YwWILUgyPJeXGfkSDOhmUMs673ynL6jEQmUal3xD3k9Zge57huo5eDqNl
 Q2mf+GDZCUhRNLOjzUaG2NpTWbrz093MZv/tKtL+zk/jU2S/0W+IjvIqcKVscnvS
 7i+2g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 470bpa1t55-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 01 Jun 2025 23:36:51 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 1 Jun 2025 23:36:49 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 1 Jun 2025 23:36:49 -0700
Received: from localhost.localdomain (unknown [10.28.36.185])
 by maili.marvell.com (Postfix) with ESMTP id E64A73F704B;
 Sun,  1 Jun 2025 23:36:46 -0700 (PDT)
From: Ankur Dwivedi <adwivedi@marvell.com>
To: <dev@dpdk.org>
CC: <jerinj@marvell.com>, <vladimir.medvedkin@intel.com>,
 <ndabilpuram@marvell.com>, <pbhagavatula@marvell.com>,
 <skori@marvell.com>, <rkudurumalla@marvell.com>, <nsaxena@marvell.com>,
 Ankur Dwivedi <adwivedi@marvell.com>
Subject: [PATCH v3 00/14] add lookup fib nodes in graph library
Date: Mon, 2 Jun 2025 12:06:25 +0530
Message-ID: <20250602063639.198550-1-adwivedi@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250509064448.724019-1-adwivedi@marvell.com>
References: <20250509064448.724019-1-adwivedi@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=MJNgmNZl c=1 sm=1 tr=0 ts=683d4683 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=4tAOc5THTaw21q7mBqQA:9
X-Proofpoint-ORIG-GUID: 7iclJIcvHNppivJ43YmuCmBcCeahwaQ1
X-Proofpoint-GUID: 7iclJIcvHNppivJ43YmuCmBcCeahwaQ1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDA1NSBTYWx0ZWRfX8/F/1Rcqzd4I
 ueeyK5XSUbhV+BYHhEgoqRNPTSPMJ157aR9AbnTV0nvj445vdUBJtwKqbM7dLIezrKNsNFGgHxI
 GQPCAybxe7YXaWbhl3VUYDJjidxZV7F3wTA+G+cJElRd7FCtk79uz3FCQ0RqOsMlm59FC7w0MJp
 +rNbdYnCdxpHrdX4xA7ZaowaUeprn9n2DAsZXlKfqtrzwYbd6eWRe/i3nD1PZZgeGrw/UQH/boT
 F0alIFLAi5LVbU5GTkfiAhWbyguxGSZtcnCmkGblHFEH9pn3MJKlaU4iYAxq2nBqKRPKE/dWyWz
 30OXtiv7AAS6Su6GtX6U5fHxdDcKyZAnE2gRPpQvePWAhCfLAOv4ud9C4C3URqtLnqA8lI60MNO
 1hbJVGR+oLo8VqdkmtEUTl6no0Ir6VLdPpqv6HRPm+mfaK3F0NeBOjUyIFqft5NyhmJAJ4uJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_02,2025-05-30_01,2025-03-28_01
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

v3:
- Added FIB inbuilt nodes in graph guide.

v2:
- Fixed build failure in DPDK CI.
- Changed the prefetch code in process functions. Also removed the
  prefetch of mbuf obj as it was not improving performance.
- Added code to control fib configuration from dpdk-graph application.
- Added the packet classification next nodes id in public header file,
  so that they can be used by library and application.
- Changed the macro FIB_DEFAULT_NH to point to pkt drop node.

Ankur Dwivedi (14):
  fib: move macro to header file
  node: add IP4 lookup FIB node
  node: add IP4 FIB route add
  node: add process callback for IP4 FIB
  node: move next nodes to public header file
  node: add next node in packet classification
  app/graph: add IP4 lookup mode command
  fib: move macro to header file
  node: add IP6 lookup FIB node
  node: add IP6 FIB route add
  node: add process callback for IP6 FIB
  node: add next node in packet classification
  app/graph: add IP6 lookup mode command
  doc: add FIB nodes in graph guide

 app/graph/commands.list                       |   2 +
 app/graph/ip4_route.c                         |  34 +-
 app/graph/ip6_route.c                         |  33 +-
 app/graph/l3fwd.c                             |  70 ++++
 app/graph/module_api.h                        |  13 +
 doc/guides/prog_guide/graph_lib.rst           |  32 ++
 .../img/graph_inbuilt_node_flow.svg           | 150 ++++----
 doc/guides/tools/graph.rst                    |  24 +-
 lib/fib/rte_fib.c                             |   3 -
 lib/fib/rte_fib.h                             |   3 +
 lib/fib/rte_fib6.c                            |  11 +-
 lib/fib/rte_fib6.h                            |   3 +
 lib/node/ip4_lookup_fib.c                     | 332 ++++++++++++++++++
 lib/node/ip6_lookup_fib.c                     | 322 +++++++++++++++++
 lib/node/meson.build                          |   5 +-
 lib/node/pkt_cls.c                            |  35 +-
 lib/node/pkt_cls_priv.h                       |   7 -
 lib/node/rte_node_ip4_api.h                   |  34 ++
 lib/node/rte_node_ip6_api.h                   |  34 ++
 lib/node/rte_node_pkt_cls_api.h               |  39 ++
 20 files changed, 1062 insertions(+), 124 deletions(-)
 create mode 100644 lib/node/ip4_lookup_fib.c
 create mode 100644 lib/node/ip6_lookup_fib.c
 create mode 100644 lib/node/rte_node_pkt_cls_api.h

-- 
2.25.1

