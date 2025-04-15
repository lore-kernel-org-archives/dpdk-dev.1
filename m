Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC71C369B4
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Apr 2025 12:12:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 184AA40A4B;
	Tue, 15 Apr 2025 14:12:30 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id E72254067B
 for <dev@dpdk.org>; Tue, 15 Apr 2025 14:12:28 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F6iVV1029009;
 Tue, 15 Apr 2025 05:12:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=U
 ip9/APYXoNz1HHW6ECowpyE/lir+l1XWScnuvRtfAc=; b=THbb72SRPzC6Pj/kx
 k3miwzu7buON1EOxelsbyq3Ilk1Hj9Q7YuvpbwZzcU4+wjfemiUiC5YI0D7PMWUb
 skcrDMc72SSUFH1JaYpltZK19CoGRPH9FhdgAFzzY9IdXrHYFT2/pd4qUY8GaKpI
 FQAWsJXcOwXJO6Rm7yh0SsvTeApDuImx6DGASk+zzXYEwY9H60LjALZl4MV6Plnf
 1IaJohot/IabhfhITtL9weYOtlsHrKpfTOdNln+trPau7VbnNEzkYT2nTxhtWBPv
 QFqLCbgHE+6VSWlYCbzDlNwCTN6/XiiW11RwtxwJi3Bx35MPkEkMS9TKvLdfPX0C
 KQZcg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4608x9d9u2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Apr 2025 05:12:27 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 15 Apr 2025 05:12:27 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 15 Apr 2025 05:12:27 -0700
Received: from localhost.localdomain (unknown [10.28.36.185])
 by maili.marvell.com (Postfix) with ESMTP id 3F40167398;
 Tue, 15 Apr 2025 05:12:23 -0700 (PDT)
From: Ankur Dwivedi <adwivedi@marvell.com>
To: <dev@dpdk.org>
CC: <jerinj@marvell.com>, <vladimir.medvedkin@intel.com>,
 <ndabilpuram@marvell.com>, <pbhagavatula@marvell.com>,
 <skori@marvell.com>, <rkudurumalla@marvell.com>,
 Ankur Dwivedi <adwivedi@marvell.com>
Subject: [PATCH v1 11/12] node: add next node in packet classification
Date: Tue, 15 Apr 2025 17:40:51 +0530
Message-ID: <20250415121052.1497155-12-adwivedi@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250415121052.1497155-1-adwivedi@marvell.com>
References: <20250415121052.1497155-1-adwivedi@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=avOyCTZV c=1 sm=1 tr=0 ts=67fe4d2b cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=aoojJjtGkrQehFeo5SAA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: ZNyKhCnxEQ5EBhSY1tpq2BMNkGQmtEvq
X-Proofpoint-ORIG-GUID: ZNyKhCnxEQ5EBhSY1tpq2BMNkGQmtEvq
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

The ip6_lookup_fib is added as next node in packet classification.

Signed-off-by: Ankur Dwivedi <adwivedi@marvell.com>
---
 lib/node/pkt_cls.c      | 1 +
 lib/node/pkt_cls_priv.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/lib/node/pkt_cls.c b/lib/node/pkt_cls.c
index 3bd0ec0bbc..56bd5176b2 100644
--- a/lib/node/pkt_cls.c
+++ b/lib/node/pkt_cls.c
@@ -233,6 +233,7 @@ struct rte_node_register pkt_cls_node = {
 		[PKT_CLS_NEXT_IP4_LOOKUP] = "ip4_lookup",
 		[PKT_CLS_NEXT_IP6_LOOKUP] = "ip6_lookup",
 		[PKT_CLS_NEXT_IP4_LOOKUP_FIB] = "ip4_lookup_fib",
+		[PKT_CLS_NEXT_IP6_LOOKUP_FIB] = "ip6_lookup_fib",
 	},
 };
 RTE_NODE_REGISTER(pkt_cls_node);
diff --git a/lib/node/pkt_cls_priv.h b/lib/node/pkt_cls_priv.h
index 5d24ec0fbd..c3b753a6a4 100644
--- a/lib/node/pkt_cls_priv.h
+++ b/lib/node/pkt_cls_priv.h
@@ -15,6 +15,7 @@ enum pkt_cls_next_nodes {
 	PKT_CLS_NEXT_IP4_LOOKUP,
 	PKT_CLS_NEXT_IP6_LOOKUP,
 	PKT_CLS_NEXT_IP4_LOOKUP_FIB,
+	PKT_CLS_NEXT_IP6_LOOKUP_FIB,
 	PKT_CLS_NEXT_MAX,
 };
 
-- 
2.25.1

