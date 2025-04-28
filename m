Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FABC36005
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Apr 2025 10:37:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A988F4021F;
	Mon, 28 Apr 2025 12:37:18 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 5256840156
 for <dev@dpdk.org>; Mon, 28 Apr 2025 12:37:17 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SA2l3p030513;
 Mon, 28 Apr 2025 03:37:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=6
 HMc5beQY/X3udMuuqKb8dO1Z+9VbRN8buD/kzSzR4o=; b=JSEwp4aHFxQnLW/oD
 00JWfJP07HhT+pwF+JbTV8XiHLEyM1DCYLEOU/dd0lti4/X2R85J2rKCcdzFBGUW
 eeZYaa9X/Hp4kbP0/WEihsiKuLyy1UpB67xKN2AQzfaFBli34bYL2BoFXhm9x0z5
 YMsEZ0d/Wc1x/25OJFjNUALssyLgG+TKdljw3jBoqRj4oLbSHs+pvugBeeqniA9B
 N32nSExn/JlsHptQqoI8YWr2Mnt2tASOpDidAi1DPa9ESCQ0RRAuONYprAE4Ccg9
 zul64ZEQc3aWHV/ylv8sggwTLmPK/PcWol1wcHHi8aEPZDFC/ABONVjjRT6+mdcx
 5HnTA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 468y0kk0bk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Apr 2025 03:37:16 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 28 Apr 2025 03:37:15 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 28 Apr 2025 03:37:15 -0700
Received: from cavium-PowerEdge-R640.. (unknown [10.28.36.207])
 by maili.marvell.com (Postfix) with ESMTP id CF20E3F7040;
 Mon, 28 Apr 2025 03:37:12 -0700 (PDT)
From: Nitin Saxena <nsaxena@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Pavan Nikhilesh
 <pbhagavatula@marvell.com>, Robin Jarry <rjarry@redhat.com>, "Christophe
 Fontaine" <cfontain@redhat.com>
CC: <dev@dpdk.org>, Jerin Jacob <jerinj@marvell.com>, Nitin Saxena
 <nsaxena16@gmail.com>
Subject: [PATCH v6 0/2] node: add mbuf dynamic field for nodes
Date: Mon, 28 Apr 2025 16:07:05 +0530
Message-ID: <20250428103711.3317231-1-nsaxena@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250401042053.3518757-1-nsaxena@marvell.com>
References: <20250401042053.3518757-1-nsaxena@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=XYuJzJ55 c=1 sm=1 tr=0 ts=680f5a5c cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=XR8D0OoHHMoA:10 a=lIu-myauPwzLC3bldAoA:9
X-Proofpoint-ORIG-GUID: WAK_r4swZpW80e5PMVtyYrP5Mw01x1uW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDA4NyBTYWx0ZWRfX8ggC+LdzPetX
 xLR3JctmTWMh8Lkl5FzLqcn72aK7Lg3WwoXI1J12d1/Edt+M5FwD0pjM3X6F6speCCv2ChzFpw3
 fPaL8UIcSGj8A+3+X1ul/+NsYEKbWGX/d6GUiBzr5zQYLDPW/kvJCbRDf2H6JyS0bW+5FSMLtO5
 Zi8XdWiiwLz/jPLJRC6Psupjz1kd1YgG/1btRISWPEJMFUa8wFOExrVWu0VoJ4E2NRVGprztiSP
 V94eKHjwufc1L4HcoJQzvfzdLSVrJSgKhOBXHQyOw6lUEh8okUCEBdrkFI9oa8His9WOjweXCCw
 fTDlBIYlWw5FfZQb68uOCk41XK3rtNxAsoi2Y+mgve9YTNUFczaVvVg4kedL2wylX4/lk0MRONO
 XK4uRVSOKRvooJ7sdb/WJFTKowsM87vieuyr6ELNn8IGqXmz7PWSXIbjRRCkZdWVaAOTESNd
X-Proofpoint-GUID: WAK_r4swZpW80e5PMVtyYrP5Mw01x1uW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_04,2025-04-24_02,2025-02-21_01
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
 lib/node/ip4_rewrite.c                 |  15 +--
 lib/node/ip6_lookup.c                  |  15 +--
 lib/node/ip6_rewrite.c                 |  14 +--
 lib/node/meson.build                   |   2 +
 lib/node/node_mbuf_dynfield.c          |  59 ++++++++++
 lib/node/node_private.h                |  40 +------
 lib/node/rte_node_mbuf_dynfield.h      | 149 +++++++++++++++++++++++++
 10 files changed, 243 insertions(+), 73 deletions(-)
 create mode 100644 lib/node/node_mbuf_dynfield.c
 create mode 100644 lib/node/rte_node_mbuf_dynfield.h

--
2.43.0

