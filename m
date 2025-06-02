Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C277FC5B549
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Jun 2025 06:37:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2279040616;
	Mon,  2 Jun 2025 08:37:25 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id D7356402F1
 for <dev@dpdk.org>; Mon,  2 Jun 2025 08:37:23 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5521jFqe013934;
 Sun, 1 Jun 2025 23:37:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=k
 a2cmyQjYPxCqnjOPswCFiYaRA/4jNCc3Tnt+XMxHUc=; b=J9lOVHebHFq24uJVd
 Bd0lBZB5gtSJ5cgqO6AlILJy102Z+xrI/Te0JVuuI4hLbTgKqOczukYj57z4gIde
 2zLHXRtqCDJe02sGa49T36rBQEFmPFXSQIddy3q2UiPpf0bQUHCQji/VV3zWgRco
 dUioYYVTG15v7lc2SOufi2eHdHrXgA6k/UrGAVjs66utmUhogW2mRG80+E2n2/Bm
 hm7BnHPAEszCPiVinSsmsMCKHx/s83GdUgdoQxpp5rQS8zgqz0qHOIRVbRWzyPFM
 f/HrH/hJT6+K0ALx3MCA/QRctBq9oNIDG3k5g7ZWUIY0CWiOqSDsS58ygQ8kw07T
 hVqgw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 470bpa1t8c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 01 Jun 2025 23:37:23 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 1 Jun 2025 23:37:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 1 Jun 2025 23:37:21 -0700
Received: from localhost.localdomain (unknown [10.28.36.185])
 by maili.marvell.com (Postfix) with ESMTP id A37903F704B;
 Sun,  1 Jun 2025 23:37:18 -0700 (PDT)
From: Ankur Dwivedi <adwivedi@marvell.com>
To: <dev@dpdk.org>
CC: <jerinj@marvell.com>, <vladimir.medvedkin@intel.com>,
 <ndabilpuram@marvell.com>, <pbhagavatula@marvell.com>,
 <skori@marvell.com>, <rkudurumalla@marvell.com>, <nsaxena@marvell.com>,
 Ankur Dwivedi <adwivedi@marvell.com>
Subject: [PATCH v3 05/14] node: move next nodes to public header file
Date: Mon, 2 Jun 2025 12:06:30 +0530
Message-ID: <20250602063639.198550-6-adwivedi@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250602063639.198550-1-adwivedi@marvell.com>
References: <20250509064448.724019-1-adwivedi@marvell.com>
 <20250602063639.198550-1-adwivedi@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=MJNgmNZl c=1 sm=1 tr=0 ts=683d46a3 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=_h17C9ndNxRnRaLl5U8A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: lqmsiIlnVxxxuqFejf_q-bZdIyKia-JZ
X-Proofpoint-GUID: lqmsiIlnVxxxuqFejf_q-bZdIyKia-JZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDA1NSBTYWx0ZWRfX+PjKO7MtXSid
 Et4kiCV+FlM3atV9+o7FUzj6fZGfWWRSEGmbV1ijlqgolyS8YqhF06B48f+j5023CIhreCiZCmB
 tbkt8FlLtXCpZhHR9oyc3R7IACGaUA6oSfZeqm3Q6rIS2TEeDVzxkjmsmERgCdwEciB6NTgufVZ
 KJOPh9QfnLzbgmjZ/YN3FIs4sLnr4XdQyocN9HQyhFiBCEaDldgBkwxJeunJFO1n7wWcj6VRmIr
 UGIwAco6+PlCK+QhAiuFuxFSTrF0WmOGfkBGGeB5E3zY0/H+ccsNy3ef/qFdS50e0Do23k2GBcv
 nKSSTObwSKHMi6hxy9UPl97amigoBgLNpVCkrLiOlBDlvs9b8MenivtsPt6CuVsQTuWxTNczZzr
 njnWfcORTd+JrWG410Su4vsl1HtZGf+aLGjk2kAeALx6weC8mqq/WSgKA7d++i8JsUdQUUDk
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

Moves the next nodes of packet classification node to a public
header files, so that it can be used from applications.

Signed-off-by: Ankur Dwivedi <adwivedi@marvell.com>
---
 lib/node/meson.build            |  1 +
 lib/node/pkt_cls.c              | 33 +++++++++++++++--------------
 lib/node/pkt_cls_priv.h         |  7 -------
 lib/node/rte_node_pkt_cls_api.h | 37 +++++++++++++++++++++++++++++++++
 4 files changed, 55 insertions(+), 23 deletions(-)
 create mode 100644 lib/node/rte_node_pkt_cls_api.h

diff --git a/lib/node/meson.build b/lib/node/meson.build
index d2011c8f56..8112cf7f5b 100644
--- a/lib/node/meson.build
+++ b/lib/node/meson.build
@@ -30,6 +30,7 @@ headers = files(
         'rte_node_eth_api.h',
         'rte_node_ip4_api.h',
         'rte_node_ip6_api.h',
+        'rte_node_pkt_cls_api.h',
         'rte_node_udp4_input_api.h',
 )
 
diff --git a/lib/node/pkt_cls.c b/lib/node/pkt_cls.c
index 9d21b7f307..5d6409fdbf 100644
--- a/lib/node/pkt_cls.c
+++ b/lib/node/pkt_cls.c
@@ -9,36 +9,37 @@
 
 #include "pkt_cls_priv.h"
 #include "node_private.h"
+#include "rte_node_pkt_cls_api.h"
 
 /* Next node for each ptype, default is '0' is "pkt_drop" */
 static const alignas(RTE_CACHE_LINE_SIZE) uint8_t p_nxt[256] = {
-	[RTE_PTYPE_L3_IPV4] = PKT_CLS_NEXT_IP4_LOOKUP,
+	[RTE_PTYPE_L3_IPV4] = RTE_NODE_PKT_CLS_NEXT_IP4_LOOKUP,
 
-	[RTE_PTYPE_L3_IPV4_EXT] = PKT_CLS_NEXT_IP4_LOOKUP,
+	[RTE_PTYPE_L3_IPV4_EXT] = RTE_NODE_PKT_CLS_NEXT_IP4_LOOKUP,
 
-	[RTE_PTYPE_L3_IPV4_EXT_UNKNOWN] = PKT_CLS_NEXT_IP4_LOOKUP,
+	[RTE_PTYPE_L3_IPV4_EXT_UNKNOWN] = RTE_NODE_PKT_CLS_NEXT_IP4_LOOKUP,
 
 	[RTE_PTYPE_L3_IPV4 | RTE_PTYPE_L2_ETHER] =
-		PKT_CLS_NEXT_IP4_LOOKUP,
+		RTE_NODE_PKT_CLS_NEXT_IP4_LOOKUP,
 
 	[RTE_PTYPE_L3_IPV4_EXT | RTE_PTYPE_L2_ETHER] =
-		PKT_CLS_NEXT_IP4_LOOKUP,
+		RTE_NODE_PKT_CLS_NEXT_IP4_LOOKUP,
 
 	[RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_L2_ETHER] =
-		PKT_CLS_NEXT_IP4_LOOKUP,
+		RTE_NODE_PKT_CLS_NEXT_IP4_LOOKUP,
 
-	[RTE_PTYPE_L3_IPV6] = PKT_CLS_NEXT_IP6_LOOKUP,
+	[RTE_PTYPE_L3_IPV6] = RTE_NODE_PKT_CLS_NEXT_IP6_LOOKUP,
 
-	[RTE_PTYPE_L3_IPV6_EXT] = PKT_CLS_NEXT_IP6_LOOKUP,
+	[RTE_PTYPE_L3_IPV6_EXT] = RTE_NODE_PKT_CLS_NEXT_IP6_LOOKUP,
 
-	[RTE_PTYPE_L3_IPV6_EXT_UNKNOWN] = PKT_CLS_NEXT_IP6_LOOKUP,
+	[RTE_PTYPE_L3_IPV6_EXT_UNKNOWN] = RTE_NODE_PKT_CLS_NEXT_IP6_LOOKUP,
 
-	[RTE_PTYPE_L3_IPV6 | RTE_PTYPE_L2_ETHER] = PKT_CLS_NEXT_IP6_LOOKUP,
+	[RTE_PTYPE_L3_IPV6 | RTE_PTYPE_L2_ETHER] = RTE_NODE_PKT_CLS_NEXT_IP6_LOOKUP,
 
-	[RTE_PTYPE_L3_IPV6_EXT | RTE_PTYPE_L2_ETHER] = PKT_CLS_NEXT_IP6_LOOKUP,
+	[RTE_PTYPE_L3_IPV6_EXT | RTE_PTYPE_L2_ETHER] = RTE_NODE_PKT_CLS_NEXT_IP6_LOOKUP,
 
 	[RTE_PTYPE_L3_IPV6_EXT_UNKNOWN | RTE_PTYPE_L2_ETHER] =
-		PKT_CLS_NEXT_IP6_LOOKUP,
+		RTE_NODE_PKT_CLS_NEXT_IP6_LOOKUP,
 };
 
 static uint16_t
@@ -226,12 +227,12 @@ struct rte_node_register pkt_cls_node = {
 	.process = pkt_cls_node_process,
 	.name = "pkt_cls",
 
-	.nb_edges = PKT_CLS_NEXT_MAX,
+	.nb_edges = RTE_NODE_PKT_CLS_NEXT_MAX,
 	.next_nodes = {
 		/* Pkt drop node starts at '0' */
-		[PKT_CLS_NEXT_PKT_DROP] = "pkt_drop",
-		[PKT_CLS_NEXT_IP4_LOOKUP] = "ip4_lookup",
-		[PKT_CLS_NEXT_IP6_LOOKUP] = "ip6_lookup",
+		[RTE_NODE_PKT_CLS_NEXT_PKT_DROP] = "pkt_drop",
+		[RTE_NODE_PKT_CLS_NEXT_IP4_LOOKUP] = "ip4_lookup",
+		[RTE_NODE_PKT_CLS_NEXT_IP6_LOOKUP] = "ip6_lookup",
 	},
 };
 RTE_NODE_REGISTER(pkt_cls_node);
diff --git a/lib/node/pkt_cls_priv.h b/lib/node/pkt_cls_priv.h
index 16135807a1..63c26cae2a 100644
--- a/lib/node/pkt_cls_priv.h
+++ b/lib/node/pkt_cls_priv.h
@@ -10,11 +10,4 @@ struct pkt_cls_node_ctx {
 	uint16_t l2l3_type;
 };
 
-enum pkt_cls_next_nodes {
-	PKT_CLS_NEXT_PKT_DROP,
-	PKT_CLS_NEXT_IP4_LOOKUP,
-	PKT_CLS_NEXT_IP6_LOOKUP,
-	PKT_CLS_NEXT_MAX,
-};
-
 #endif /* __INCLUDE_PKT_CLS_PRIV_H__ */
diff --git a/lib/node/rte_node_pkt_cls_api.h b/lib/node/rte_node_pkt_cls_api.h
new file mode 100644
index 0000000000..36276db63c
--- /dev/null
+++ b/lib/node/rte_node_pkt_cls_api.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2025 Marvell.
+ */
+
+#ifndef __INCLUDE_RTE_NODE_PKT_CLS_API_H__
+#define __INCLUDE_RTE_NODE_PKT_CLS_API_H__
+
+/**
+ * @file rte_node_pkt_cls_api.h
+ *
+ * @warning
+ * @b EXPERIMENTAL:
+ * All functions in this file may be changed or removed without prior notice.
+ *
+ * This API allows to do control path functions of pkt_cls node.
+ */
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/*
+ * Packet classification (pkt_cls) next nodes.
+ */
+
+enum rte_node_pkt_cls_next {
+	RTE_NODE_PKT_CLS_NEXT_PKT_DROP,
+	RTE_NODE_PKT_CLS_NEXT_IP4_LOOKUP,
+	RTE_NODE_PKT_CLS_NEXT_IP6_LOOKUP,
+	RTE_NODE_PKT_CLS_NEXT_MAX,
+};
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __INCLUDE_RTE_NODE_PKT_CLS_API_H__ */
-- 
2.25.1

