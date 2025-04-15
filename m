Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C41C369AB
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Apr 2025 12:11:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3ADAE402A1;
	Tue, 15 Apr 2025 14:11:53 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id D044340676
 for <dev@dpdk.org>; Tue, 15 Apr 2025 14:11:50 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FBKLb6019561;
 Tue, 15 Apr 2025 05:11:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=z
 R1Jl4/f5gg4Q6IZw8XO7RkWbOzYLObTIAOgqJQnHOQ=; b=UpBG3Z9blLj9ERggW
 /GLVL/cv4nHyj7IRqp5tEtVvI6RVpahcWycHuf8mwSJDiOxbw5VJ+hTNGC/RiCPo
 NlGT9OfwsMZiuUGA+LOgWjCRZlnPmWup/VhsrNWxhk5sTfO4491VH4U0yljEIapF
 +xGMdS1hzVoG43ZqGeQr3HHboqztjDZWa/mNEHI5fXmOqXaemDOzmlDO+anLMf0m
 lPbhhAFeoCa4vrh+PiZkIMlKJzNCmvkc0XsQJHb9eQbjLrwBLsMe40oDUIYwpcO4
 9fMkT1pjRCoOQyKTDXaoh8uA5woUhtff4Ybe2sOoqbVXbgs9HUKr8qAMphbU7cBw
 3WSsg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 461pg703je-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Apr 2025 05:11:49 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 15 Apr 2025 05:11:48 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 15 Apr 2025 05:11:48 -0700
Received: from localhost.localdomain (unknown [10.28.36.185])
 by maili.marvell.com (Postfix) with ESMTP id B446C67398;
 Tue, 15 Apr 2025 05:11:45 -0700 (PDT)
From: Ankur Dwivedi <adwivedi@marvell.com>
To: <dev@dpdk.org>
CC: <jerinj@marvell.com>, <vladimir.medvedkin@intel.com>,
 <ndabilpuram@marvell.com>, <pbhagavatula@marvell.com>,
 <skori@marvell.com>, <rkudurumalla@marvell.com>,
 Ankur Dwivedi <adwivedi@marvell.com>
Subject: [PATCH v1 05/12] node: add next node in packet classification
Date: Tue, 15 Apr 2025 17:40:45 +0530
Message-ID: <20250415121052.1497155-6-adwivedi@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250415121052.1497155-1-adwivedi@marvell.com>
References: <20250415121052.1497155-1-adwivedi@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: w9h1vhVg6TxL57rbN3B4a1S65L6OGff9
X-Proofpoint-ORIG-GUID: w9h1vhVg6TxL57rbN3B4a1S65L6OGff9
X-Authority-Analysis: v=2.4 cv=Gp1C+l1C c=1 sm=1 tr=0 ts=67fe4d05 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=pJLBU1LGCk3Fecw1B2YA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
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

The ip4_lookup_fib is added as next node in packet classification.

Signed-off-by: Ankur Dwivedi <adwivedi@marvell.com>
---
 lib/node/pkt_cls.c      | 1 +
 lib/node/pkt_cls_priv.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/lib/node/pkt_cls.c b/lib/node/pkt_cls.c
index 9d21b7f307..3bd0ec0bbc 100644
--- a/lib/node/pkt_cls.c
+++ b/lib/node/pkt_cls.c
@@ -232,6 +232,7 @@ struct rte_node_register pkt_cls_node = {
 		[PKT_CLS_NEXT_PKT_DROP] = "pkt_drop",
 		[PKT_CLS_NEXT_IP4_LOOKUP] = "ip4_lookup",
 		[PKT_CLS_NEXT_IP6_LOOKUP] = "ip6_lookup",
+		[PKT_CLS_NEXT_IP4_LOOKUP_FIB] = "ip4_lookup_fib",
 	},
 };
 RTE_NODE_REGISTER(pkt_cls_node);
diff --git a/lib/node/pkt_cls_priv.h b/lib/node/pkt_cls_priv.h
index 16135807a1..5d24ec0fbd 100644
--- a/lib/node/pkt_cls_priv.h
+++ b/lib/node/pkt_cls_priv.h
@@ -14,6 +14,7 @@ enum pkt_cls_next_nodes {
 	PKT_CLS_NEXT_PKT_DROP,
 	PKT_CLS_NEXT_IP4_LOOKUP,
 	PKT_CLS_NEXT_IP6_LOOKUP,
+	PKT_CLS_NEXT_IP4_LOOKUP_FIB,
 	PKT_CLS_NEXT_MAX,
 };
 
-- 
2.25.1

