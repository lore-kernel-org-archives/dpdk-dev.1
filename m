Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275D1C36008
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Apr 2025 04:21:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE1E6402E1;
	Tue,  1 Apr 2025 06:21:00 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 3BD4D402B1
 for <dev@dpdk.org>; Tue,  1 Apr 2025 06:20:59 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5310a78d005677;
 Mon, 31 Mar 2025 21:20:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=XKJ/pZajKR/d50FGx46xmJy
 k+3zM0jp6URqZM5B4iMY=; b=NN6WeCfZQ+78MB2iNZOWX9dSFmNxtbVKSOD1ddz
 W17wygo/vaSaYofpkHHtHt3mZcvfJS9uVoKO4pTTgK99CWFey+Z/BO/XFNzeGAA+
 jE+J1xE9zblJzTMUKPSLPp1zQNn6a9W46/jLGANskVe3S3kAETxvUtLNYteNHNLH
 jLTzRatsJ1Z6EzjZyxf65h7/aOgFDkWAgtGKCNdyudRipVnhZRDAtpouXCtdDDFH
 FxpCNjCyk8XA2tHt2vxxOMpz+TCNzdvDptPkQbUejsELpKjzvpadfJDP8rjXwpR+
 JSWtPfRciqEKFqOMYmp4v2n4QuBE2gQLj7aaNbeYV0b3kHg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 45r5r28bae-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Mar 2025 21:20:57 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 31 Mar 2025 21:20:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 31 Mar 2025 21:20:57 -0700
Received: from cavium-PowerEdge-R640.. (unknown [10.28.36.207])
 by maili.marvell.com (Postfix) with ESMTP id 13BFC3F708E;
 Mon, 31 Mar 2025 21:20:54 -0700 (PDT)
From: Nitin Saxena <nsaxena@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Pavan Nikhilesh
 <pbhagavatula@marvell.com>, Robin Jarry <rjarry@redhat.com>, "Christophe
 Fontaine" <cfontain@redhat.com>
CC: <dev@dpdk.org>, Jerin Jacob <jerinj@marvell.com>, Nitin Saxena
 <nsaxena16@gmail.com>
Subject: [PATCH 0/2] node: add mbuf dynamic field for nodes
Date: Tue, 1 Apr 2025 09:50:45 +0530
Message-ID: <20250401042053.3518757-1-nsaxena@marvell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: VjStB2tWpgs-xehhWYhz4BJl9t4m-jto
X-Authority-Analysis: v=2.4 cv=Nb/m13D4 c=1 sm=1 tr=0 ts=67eb69aa cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Vs1iUdzkB0EA:10 a=TweJ2ePoobnb0kZxSkcA:9
X-Proofpoint-GUID: VjStB2tWpgs-xehhWYhz4BJl9t4m-jto
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_01,2025-03-27_02,2024-11-22_01
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

Currently each rte_node registers separate mbuf dynamic fields for their
own purpose. This leads to wastage of mbuf space as once mbuf get passed
a particular node, the registered dynamic field(by that node) is no
longer used.

This patch series adds a global/common mbuf dynamic field which is
reusable by all the nodes(including out-of-tree nodes). This helps to
repurpose same mbuf dynamic field for other nodes. It contains two types
of fields: (a) persistent (b) overloadable.

While persistent fields are those which does not often changes during a
graph walk such as rx/tx interface, buffer flags etc. Currently there
are no persistent fields added but they can be added later

Overloadable fields are those which can be overloaded by two adjacent
nodes. Overloadable fields can be repurposed by other two adjacent nodes.

This patch series also updates ip4/ip6 lookup/rewrite nodes to use
overlaodable mbuf dynamic fields.

Nitin Saxena (2):
  node: add global node mbuf dynfield
  node: use node mbuf dynfield in ip4 nodes

 doc/api/doxy-api-index.md              |   3 +-
 doc/guides/rel_notes/release_25_07.rst |   6 ++
 lib/node/ip4_lookup.c                  |  14 +--
 lib/node/ip4_rewrite.c                 |  15 ++-
 lib/node/ip6_lookup.c                  |  15 ++-
 lib/node/ip6_rewrite.c                 |  14 +--
 lib/node/meson.build                   |   2 +
 lib/node/node_mbuf_dynfield.c          |  56 ++++++++++
 lib/node/node_private.h                |  40 +------
 lib/node/rte_node_mbuf_dynfield.h      | 139 +++++++++++++++++++++++++
 lib/node/version.map                   |   3 +
 11 files changed, 233 insertions(+), 74 deletions(-)
 create mode 100644 lib/node/node_mbuf_dynfield.c
 create mode 100644 lib/node/rte_node_mbuf_dynfield.h

--
2.43.0

