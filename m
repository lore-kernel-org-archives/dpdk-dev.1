Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05371C36010
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 07:48:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01D884065C;
	Mon,  7 Apr 2025 09:48:08 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id A672240150
 for <dev@dpdk.org>; Mon,  7 Apr 2025 09:48:06 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5372o46b020167;
 Mon, 7 Apr 2025 00:48:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=f
 1J7CVaPY2xOKVEr5XGFOPsiSznWmbaB5D7Vs7Z/ImU=; b=S72D9AnJ8+2Jggyvp
 vc2Inqa/EM4wm4GsCKBU0rFcz4ER+7cptesteKppkWVOEP4/2hff7DhbY5zMBxBV
 nQfzTcXEOPaPK5qq3mJnwSX8WCfRqxXv7GzmZkvkt+W4kxo3r6dttmMsWKM7rE/3
 OpZgPg/Yb8ho20StHYyfce5ei725twwL4vwSv7JyYutGXrNMdxcNyZwJ8WCssDpX
 EAzJUyfE978s26Ipc79KEhAJVcpOgBUYm7+Yqu6U9vpr5SxtX5mk1gra2Mhv9kaf
 DMHMUMWQLWKvI22ZBZht5R9bE/5bLr7VtbZ7P3XUCffepWm7mfzKu97IEjZqN2D1
 DBSpA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 45ursc1euh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Apr 2025 00:48:05 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 7 Apr 2025 00:48:04 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 7 Apr 2025 00:48:04 -0700
Received: from cavium-PowerEdge-R640.. (unknown [10.28.36.207])
 by maili.marvell.com (Postfix) with ESMTP id 0354B5B694E;
 Mon,  7 Apr 2025 00:48:01 -0700 (PDT)
From: Nitin Saxena <nsaxena@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Pavan Nikhilesh
 <pbhagavatula@marvell.com>, Robin Jarry <rjarry@redhat.com>, "Christophe
 Fontaine" <cfontain@redhat.com>
CC: <dev@dpdk.org>, Jerin Jacob <jerinj@marvell.com>, Nitin Saxena
 <nsaxena16@gmail.com>
Subject: [PATCH v4 0/2] node: add mbuf dynamic field for nodes
Date: Mon, 7 Apr 2025 13:17:57 +0530
Message-ID: <20250407074800.1651203-1-nsaxena@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250401042053.3518757-1-nsaxena@marvell.com>
References: <20250401042053.3518757-1-nsaxena@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: hjHF_Cvy_DjIADlsUiBhR7ojYEcSrygN
X-Authority-Analysis: v=2.4 cv=M85NKzws c=1 sm=1 tr=0 ts=67f38335 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=XR8D0OoHHMoA:10 a=lIu-myauPwzLC3bldAoA:9
X-Proofpoint-ORIG-GUID: hjHF_Cvy_DjIADlsUiBhR7ojYEcSrygN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_02,2025-04-03_03,2024-11-22_01
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

 doc/api/doxy-api-index.md              |   3 +-
 doc/guides/rel_notes/release_25_07.rst |   6 ++
 lib/node/ip4_lookup.c                  |  14 +--
 lib/node/ip4_rewrite.c                 |  15 ++-
 lib/node/ip6_lookup.c                  |  15 ++-
 lib/node/ip6_rewrite.c                 |  14 +--
 lib/node/meson.build                   |   2 +
 lib/node/node_mbuf_dynfield.c          |  44 ++++++++
 lib/node/node_private.h                |  40 +------
 lib/node/rte_node_mbuf_dynfield.h      | 141 +++++++++++++++++++++++++
 lib/node/version.map                   |   3 +
 11 files changed, 223 insertions(+), 74 deletions(-)
 create mode 100644 lib/node/node_mbuf_dynfield.c
 create mode 100644 lib/node/rte_node_mbuf_dynfield.h

--
2.43.0

