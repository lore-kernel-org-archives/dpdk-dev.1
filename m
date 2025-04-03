Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FE7C3600C
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Apr 2025 10:17:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4CBC4060C;
	Thu,  3 Apr 2025 12:17:56 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 74C1E4060B
 for <dev@dpdk.org>; Thu,  3 Apr 2025 12:17:55 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5333DBVk003082;
 Thu, 3 Apr 2025 03:17:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=c
 GemYFbgBhLCo80Ohvh5SfK5a3arUkIib07uF1wo558=; b=QHvOHu1lAe7ydUP7J
 6Wi4Lecd4eKlAbtDSJguPPQQC+J4rN07AHsujUBc9YvaNC4v6gsChXAeXaVtRFqs
 BzwlnuwcZYODoY8w379r6yRtEHQTwPXa567WCUdqcrDvVuJEU7dQcKQyi9FgKd0o
 Cz/ONX+abSl2JrMRnVRaDQv03ztdOlW5h8Ej1H6Eimlzpoio7YdulwbUBCqqKKlp
 Fo91w7LNx26/Ef0ZtXI7LnzbAVtToAGhzBboaG3dbUZbTAMxcL+o0RVe15pnZiaq
 ZrpwjU98NnpF7/wDhGKTa7FUzf9MdafUIzxLju3W8C3JqPl4oZKW8JrnC4DInESM
 Hpf/g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45s5h52g1u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Apr 2025 03:17:54 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 3 Apr 2025 03:17:53 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 3 Apr 2025 03:17:53 -0700
Received: from cavium-PowerEdge-R640.. (unknown [10.28.36.207])
 by maili.marvell.com (Postfix) with ESMTP id 05E2A3F705E;
 Thu,  3 Apr 2025 03:17:50 -0700 (PDT)
From: Nitin Saxena <nsaxena@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Pavan Nikhilesh
 <pbhagavatula@marvell.com>, Robin Jarry <rjarry@redhat.com>, "Christophe
 Fontaine" <cfontain@redhat.com>
CC: <dev@dpdk.org>, Jerin Jacob <jerinj@marvell.com>, Nitin Saxena
 <nsaxena16@gmail.com>
Subject: [PATCH v2 0/2] node: add mbuf dynamic field for nodes
Date: Thu, 3 Apr 2025 15:47:42 +0530
Message-ID: <20250403101749.4123697-1-nsaxena@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250401042053.3518757-1-nsaxena@marvell.com>
References: <20250401042053.3518757-1-nsaxena@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Z0B3fwTIKCZaoxeeYDYxDkrnsEoLtI6I
X-Authority-Analysis: v=2.4 cv=FYE3xI+6 c=1 sm=1 tr=0 ts=67ee6052 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=XR8D0OoHHMoA:10 a=lIu-myauPwzLC3bldAoA:9
X-Proofpoint-ORIG-GUID: Z0B3fwTIKCZaoxeeYDYxDkrnsEoLtI6I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_04,2025-04-02_03,2024-11-22_01
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
 lib/node/node_mbuf_dynfield.c          |  46 ++++++++
 lib/node/node_private.h                |  40 +------
 lib/node/rte_node_mbuf_dynfield.h      | 139 +++++++++++++++++++++++++
 lib/node/version.map                   |   3 +
 11 files changed, 223 insertions(+), 74 deletions(-)
 create mode 100644 lib/node/node_mbuf_dynfield.c
 create mode 100644 lib/node/rte_node_mbuf_dynfield.h

--
2.43.0

