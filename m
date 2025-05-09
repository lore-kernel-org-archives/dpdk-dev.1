Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CC8C3ABBC
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 May 2025 06:46:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5ACF4064F;
	Fri,  9 May 2025 08:46:15 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 2AE3D4064F
 for <dev@dpdk.org>; Fri,  9 May 2025 08:46:14 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5496TZS5022602;
 Thu, 8 May 2025 23:46:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=d
 BmPdIglKPzQ9nv6QauDDxgnDLV0vQbX879EnC0ko0I=; b=k0S86d/q3eQAlAf+W
 pPVGjapU2B0Px+YH0Td/IgTmrotFbcDH8C1mEEPgSloseE0DVzQnR5dnC/nker9T
 j0w54RXxp7kAo/KpZRAFpyMgsF4xT1eFp9m2abEzW0JpBnF4wv7UwBQ6beaS7WZc
 O7a5oO5S3MDEubfqnwN/izDQy/UDzOYYPuRV1NDrmUZWb05qaUyi7IcPjSwyJDG0
 d4Yom55QfoLfXU5MIKV68C4My+KBNSwF6q3MXCo9FX0225ehVscf8KieKNYpvLRJ
 2T+EDgDuv0C3zRehkjheEA+FH9BJW6y+NBibgbAtKi3y7+cDkz0uqmCrkwYOOVnQ
 fHs5g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46hcg080y9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 23:46:12 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 8 May 2025 23:46:11 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 8 May 2025 23:46:11 -0700
Received: from localhost.localdomain (unknown [10.28.36.185])
 by maili.marvell.com (Postfix) with ESMTP id 92A5F3F704F;
 Thu,  8 May 2025 23:46:08 -0700 (PDT)
From: Ankur Dwivedi <adwivedi@marvell.com>
To: <dev@dpdk.org>
CC: <jerinj@marvell.com>, <vladimir.medvedkin@intel.com>,
 <ndabilpuram@marvell.com>, <pbhagavatula@marvell.com>,
 <skori@marvell.com>, <rkudurumalla@marvell.com>, <nsaxena@marvell.com>,
 Ankur Dwivedi <adwivedi@marvell.com>
Subject: [PATCH v2 12/13] node: add next node in packet classification
Date: Fri, 9 May 2025 12:14:47 +0530
Message-ID: <20250509064448.724019-13-adwivedi@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250509064448.724019-1-adwivedi@marvell.com>
References: <20250415121052.1497155-1-adwivedi@marvell.com>
 <20250509064448.724019-1-adwivedi@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: CPX-wmMKR6UnypcCiAjn3Wviz_U3BZ_B
X-Proofpoint-ORIG-GUID: CPX-wmMKR6UnypcCiAjn3Wviz_U3BZ_B
X-Authority-Analysis: v=2.4 cv=BaPY0qt2 c=1 sm=1 tr=0 ts=681da4b4 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=aoojJjtGkrQehFeo5SAA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDA2MyBTYWx0ZWRfX2nKcvWWBmM1X
 R3oqLQuj8UkWME6EAmyXL/1/z8J1zNfTPdAJZUJZNgxze7gGRKBRzYP5uNDfOM/Lhob1pHmAA6A
 dMhJ70PqSqtcTeS+WJbRLimfBfSudY1puOAy0AfgsC6+ibSVJUMNSVZ7o2BAElRxKSWZPxszVe4
 XTw6JhXPduTzYPha9O+d0HdayPQEW1jzqilujLPDp6S/O3jd/qQ/i+udYbsKDGzZrwUPkwOKsLJ
 nqo/Vpa5RJrsmvaYs5svbnjEQ9qxiD77oYNE8RALklC9J3pHdKB5cPa57HM+lfUmsSZAbjnIZB5
 6q98fp1hQmEPe+DOYh1/4337/Wufni7CFFTdKDnns+4zth9h0TrNcyfSu9KQ4O3/jeBZcZ4thiE
 LCaEDPPcunw0kG4j9XXck53OjNZq2pA8a89Q4CbIWOss2jyxEAFMpAxNhuGbQ3jsFa1kJMRC
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

The ip6_lookup_fib is added as next node in packet classification.

Signed-off-by: Ankur Dwivedi <adwivedi@marvell.com>
---
 lib/node/pkt_cls.c              | 1 +
 lib/node/rte_node_pkt_cls_api.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/lib/node/pkt_cls.c b/lib/node/pkt_cls.c
index f6e76989bc..ca323ea573 100644
--- a/lib/node/pkt_cls.c
+++ b/lib/node/pkt_cls.c
@@ -234,6 +234,7 @@ struct rte_node_register pkt_cls_node = {
 		[RTE_NODE_PKT_CLS_NEXT_IP4_LOOKUP] = "ip4_lookup",
 		[RTE_NODE_PKT_CLS_NEXT_IP6_LOOKUP] = "ip6_lookup",
 		[RTE_NODE_PKT_CLS_NEXT_IP4_LOOKUP_FIB] = "ip4_lookup_fib",
+		[RTE_NODE_PKT_CLS_NEXT_IP6_LOOKUP_FIB] = "ip6_lookup_fib",
 	},
 };
 RTE_NODE_REGISTER(pkt_cls_node);
diff --git a/lib/node/rte_node_pkt_cls_api.h b/lib/node/rte_node_pkt_cls_api.h
index 8f935bebbe..cf617d6985 100644
--- a/lib/node/rte_node_pkt_cls_api.h
+++ b/lib/node/rte_node_pkt_cls_api.h
@@ -28,6 +28,7 @@ enum rte_node_pkt_cls_next {
 	RTE_NODE_PKT_CLS_NEXT_IP4_LOOKUP,
 	RTE_NODE_PKT_CLS_NEXT_IP6_LOOKUP,
 	RTE_NODE_PKT_CLS_NEXT_IP4_LOOKUP_FIB,
+	RTE_NODE_PKT_CLS_NEXT_IP6_LOOKUP_FIB,
 	RTE_NODE_PKT_CLS_NEXT_MAX,
 };
 
-- 
2.25.1

