Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32E0C3ABC3
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 May 2025 06:45:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7ACA14026C;
	Fri,  9 May 2025 08:45:05 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 71D554026B
 for <dev@dpdk.org>; Fri,  9 May 2025 08:45:03 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5492iIDG030900;
 Thu, 8 May 2025 23:45:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=a
 p9Xcnz/RRPQjGRrJlk+1aAVp7YIXSUuKroZ0p4uxD0=; b=Ki3mW6F7344LUQLy1
 SU3OE5+c3uE0vJPLGPcIW6hzQ13BKRVQn9Ft8BBlRQGeuPJnPe3DmRirX1cfcmpQ
 py4UdwLbUKw68JFAau2THqmomnlPMSle/PW7KWNGtskBawycxAUEnnXEil4ZkVzq
 +SGsq4U20RaPQ4V612UnVpLy6s5fTL13U2VRW0FNkqEZwsAqEX3a2W7cm3I/z78Y
 e3W4HSVnpYsB8ga0FiR6lCwyDhzQ1sAY7pFkbLTFW4IYV4/A2K5//Bsccv5DazXu
 cGaZdQxPRlPQikByDCIx62prrGkDcLpKV+g4nU4Dwd/IJNzeNVfqe2ScPEGQmy7K
 gZBrQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46h96c0cec-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 23:45:02 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 8 May 2025 23:44:55 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 8 May 2025 23:44:55 -0700
Received: from localhost.localdomain (unknown [10.28.36.185])
 by maili.marvell.com (Postfix) with ESMTP id 820603F7050;
 Thu,  8 May 2025 23:44:52 -0700 (PDT)
From: Ankur Dwivedi <adwivedi@marvell.com>
To: <dev@dpdk.org>
CC: <jerinj@marvell.com>, <vladimir.medvedkin@intel.com>,
 <ndabilpuram@marvell.com>, <pbhagavatula@marvell.com>,
 <skori@marvell.com>, <rkudurumalla@marvell.com>, <nsaxena@marvell.com>,
 Ankur Dwivedi <adwivedi@marvell.com>
Subject: [PATCH v2 00/13] add lookup fib nodes in graph library
Date: Fri, 9 May 2025 12:14:35 +0530
Message-ID: <20250509064448.724019-1-adwivedi@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250415121052.1497155-1-adwivedi@marvell.com>
References: <20250415121052.1497155-1-adwivedi@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDA2MyBTYWx0ZWRfX8QKxSgap99aI
 +ZnkoMlZkK5eKzksts6e6uImhqnWbdIKIJZD+jxViVJQr1+uPnqkVfL4a95FjKAUV+qinXymY3Y
 NC6Ham7Gq/gMSw7SkgeWYaZ+XayXrrFHHPYSKG/UuG7whmnSW3sB2xmymdlDYBEGlCS+r5GYT9V
 ZI8w+P+3aZd9HV6abl5n7dBA/8kG558319mNspy1ew7LSkjg3+Esqz1KMGvC3XQ4Q8QvhoE7us2
 NEavfso7P4Jrrakt7b7co2AqB2vd4O4AX3qgOk7IDFKuulWOwG/qBFqgbtBwWVkGVpubsD/nUo3
 h9FW5rLV1ZoMev06NjBZYJmkLiztUXlAHuwPGXWBMx2awol/RiagnsPk+HFdGNj10LXpcS+gQEP
 lNBsbpqwQa74zVJ+P2L0XI25B3xy3Dvdx+YCHjIg481yP69vHi5WlmMZ7QJiJjpu6aSclAur
X-Proofpoint-GUID: _cViL6wGGTizE7p68zV5RMAS20PAg1mp
X-Proofpoint-ORIG-GUID: _cViL6wGGTizE7p68zV5RMAS20PAg1mp
X-Authority-Analysis: v=2.4 cv=dpXbC0g4 c=1 sm=1 tr=0 ts=681da46e cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=4tAOc5THTaw21q7mBqQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_02,2025-05-08_04,2025-02-21_01
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

v2:
- Fixed build failure in DPDK CI.
- Changed the prefetch code in process functions. Also removed the
  prefetch of mbuf obj as it was not improving performance.
- Added code to control fib configuration from dpdk-graph application.
- Added the packet classification next nodes id in public header file,
  so that they can be used by library and application.
- Changed the macro FIB_DEFAULT_NH to point to pkt drop node.

Ankur Dwivedi (13):
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

 app/graph/commands.list         |   2 +
 app/graph/ip4_route.c           |  34 +++-
 app/graph/ip6_route.c           |  33 +++-
 app/graph/l3fwd.c               |  70 +++++++
 app/graph/module_api.h          |  13 ++
 doc/guides/tools/graph.rst      |  24 ++-
 lib/fib/rte_fib.c               |   3 -
 lib/fib/rte_fib.h               |   3 +
 lib/fib/rte_fib6.c              |  11 +-
 lib/fib/rte_fib6.h              |   3 +
 lib/node/ip4_lookup_fib.c       | 332 ++++++++++++++++++++++++++++++++
 lib/node/ip6_lookup_fib.c       | 322 +++++++++++++++++++++++++++++++
 lib/node/meson.build            |   5 +-
 lib/node/pkt_cls.c              |  35 ++--
 lib/node/pkt_cls_priv.h         |   7 -
 lib/node/rte_node_ip4_api.h     |  34 ++++
 lib/node/rte_node_ip6_api.h     |  34 ++++
 lib/node/rte_node_pkt_cls_api.h |  39 ++++
 18 files changed, 954 insertions(+), 50 deletions(-)
 create mode 100644 lib/node/ip4_lookup_fib.c
 create mode 100644 lib/node/ip6_lookup_fib.c
 create mode 100644 lib/node/rte_node_pkt_cls_api.h

-- 
2.25.1

