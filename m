Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8003C7115A
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Jun 2025 15:45:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6D444025E;
	Thu, 19 Jun 2025 17:45:08 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id C5865400D7
 for <dev@dpdk.org>; Thu, 19 Jun 2025 17:45:06 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55J8StFx014575;
 Thu, 19 Jun 2025 08:45:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=Y
 lF/8B3fbEad3a7v5xgrglVdYgYZz8T+8kIr0XPSWRQ=; b=SzZviRV8GWFFEeIhA
 kVHff/tdSjrm7OI9rKjFi2lVu59kyKeNNHaoocGYHE0mTgBEWCr4WrUpJO+yB/Nd
 TngRd0F1QYMyYleYjYGMd9DfyQVN2pVmFF5cWPbhJyycDXk6SEaCejZjb8d9DHoT
 0ZmDaytfLsxZAYa1tn5vXg38B8uSmqqkp+NxH9Hga7gaSF28h6tZ0mp922EAbNAD
 E/X5alK0aZ9w0H9KtVyLEIKJJkOSWBE0Yp5iuZgssxm2Xt9FoJHxarIBFVPvCPfK
 5tVGk3D/MmpvNjMMJhC1/t4zrjEdXk2+qjzmYDkkqGTx4tHBuI0KHLwJ8E0Vp/8C
 BPpXw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47cf2u8v9w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Jun 2025 08:45:05 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 19 Jun 2025 08:45:05 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 19 Jun 2025 08:45:04 -0700
Received: from cavium-PowerEdge-R640.. (unknown [10.28.36.207])
 by maili.marvell.com (Postfix) with ESMTP id 6AF053F7080;
 Thu, 19 Jun 2025 08:45:02 -0700 (PDT)
From: Nitin Saxena <nsaxena@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Pavan Nikhilesh
 <pbhagavatula@marvell.com>, Robin Jarry <rjarry@redhat.com>, "Christophe
 Fontaine" <cfontain@redhat.com>
CC: <dev@dpdk.org>, Jerin Jacob <jerinj@marvell.com>, Nitin Saxena
 <nsaxena16@gmail.com>
Subject: [PATCH v7 0/2] node: add mbuf dynamic field for nodes
Date: Thu, 19 Jun 2025 21:14:48 +0530
Message-ID: <20250619154501.3869031-1-nsaxena@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250401042053.3518757-1-nsaxena@marvell.com>
References: <20250401042053.3518757-1-nsaxena@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDEzMCBTYWx0ZWRfXxtUh0r1asdTg
 A3+bAoL7b2u3BZMYtrT+9uI3lvIF+IuZKgPvF7z20zrNCDJNz01AR2tX59r2lvg1gEwPcHnpwp2
 kcGAKPV0X6ZO1T3pEY8pxf6iuTSBryZllZq9aKjJ2hSlUerSNfljZd8qATDnKsk8D1RWlw22YCr
 08jO8qJ5mmBBgpNXjExzv2/zFSwWqkxbdNhMB9jNjd/389HeZqZde82mr/hbnzmfKFNW8/YrolX
 9EeBh446Ib66nOA9o+rxMN/0HCjE95qtaSIfXoDSl8SMWPrHOgwPlfSSeH51EtLtD8BQOBAQrbq
 fjUzL83Er+u6iuVQyovBlAtsNzAHloJs8ceqEKRpAcmiaO/CbFORNonqtPOJwZBv3UQjE6PQjzZ
 5exfjK4rpu7eqKKLVVvslQu4MTiIDNGnfjvusIgM64OqiI9k1F8pC4lMypJHi04SaT6Nei0K
X-Proofpoint-GUID: J4UTTa3kZ9EiE8H9g2APpqin2PrxHOnh
X-Proofpoint-ORIG-GUID: J4UTTa3kZ9EiE8H9g2APpqin2PrxHOnh
X-Authority-Analysis: v=2.4 cv=dsXbC0g4 c=1 sm=1 tr=0 ts=68543081 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6IFa9wvqVegA:10 a=W6WRBxtj2BSr6DOQD-gA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_06,2025-06-18_03,2025-03-28_01
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

Overloadable fields are those which can be used by two adjacent nodes.
Same overloadable fields can be repurposed by other two adjacent nodes.

This patch series also updates ip4/ip6 lookup/rewrite nodes to use
overlaodable mbuf dynamic fields.

Changes in v7:
- Rebase on latest main with changes rte_ip4_lookup_fib nodes as well
- Verified ip4 output arc functionality with both "ip4_lookup" and
  "ip4_lookup_fib" nodes

Changes in v6:
- Incorporate comments from Pavan

Changes in v5
- Rebase on latest main with version.map changes
- Bring back memzone based node mbuf dynfield for secondary
  process [Pavan]

Changes in v4
- Fix github CI

Changes in v3:
- Fix CI build error

Changes in v2:
- removed usage of memzone for saving mbuf dynfield [Stephen]
- fixed checkpatch issues
- redefine RTE_NODE_MBUF_OVERLOADABLE_FIELDS_SIZE to 8 byte which are
  currently in use. Size can increase later based on the usage


Nitin Saxena (2):
  node: add global node mbuf dynfield
  node: use node mbuf dynfield in ip4 nodes

 doc/api/doxy-api-index.md              |   2 +
 doc/guides/rel_notes/release_25_07.rst |   6 +
 lib/node/ip4_lookup.c                  |  14 +--
 lib/node/ip4_lookup_fib.c              |  17 ++-
 lib/node/ip4_rewrite.c                 |  32 ++---
 lib/node/ip6_lookup.c                  |  15 +--
 lib/node/ip6_lookup_fib.c              |  17 ++-
 lib/node/ip6_rewrite.c                 |  14 +--
 lib/node/meson.build                   |   2 +
 lib/node/node_mbuf_dynfield.c          |  59 ++++++++++
 lib/node/node_private.h                |  40 +------
 lib/node/rte_node_mbuf_dynfield.h      | 155 +++++++++++++++++++++++++
 12 files changed, 274 insertions(+), 99 deletions(-)
 create mode 100644 lib/node/node_mbuf_dynfield.c
 create mode 100644 lib/node/rte_node_mbuf_dynfield.h

--
2.43.0

