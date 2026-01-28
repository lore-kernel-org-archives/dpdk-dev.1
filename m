Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE82D3567F
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 06:04:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37AAF402D3;
	Wed, 28 Jan 2026 07:04:17 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id DBAF2402CC
 for <dev@dpdk.org>; Wed, 28 Jan 2026 07:04:14 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60S1N3gt3583494 for <dev@dpdk.org>; Tue, 27 Jan 2026 22:04:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=I
 V5ddKfyy8eW4ArMVwpEBoeTM+SAJ5+oOnyM11u/s64=; b=axDeHzPXal61deERB
 3CBU9Mc63Blkb0cIBjRzbs1DneYrcDcu1raqqAsd7ZPFFfHa6CvAMIiae0OlChzM
 zVN7yDQAxBMSq68+ZfHIhXiR3rHTe39AHssPUrjcHVmug/0qwbVkEXCfozx9koFu
 kE2+kpZwZQGyavBTMLMMimfBgX41y4DAQZ0hfaS4oQPiZn4YZKEr5RDP1AcR9j7X
 NLC/nNELJm1u3uEQk6u3nJ4dEBkBzjEqYB9dlIypmb5zXXHXlIMouv/U4QS3JM22
 GR8XSltK6+54qyiaTffvHRk+G7aGC1lTviWqfAVik1H1WOby+KXr2dj2PqioIH4J
 nY3ng==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4by8r68f16-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 27 Jan 2026 22:04:14 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 Jan 2026 22:04:13 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 27 Jan 2026 22:04:13 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id E44563F706F;
 Tue, 27 Jan 2026 22:04:10 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH 08/18] net/cnxk: add CPT code check for soft expiry
Date: Wed, 28 Jan 2026 11:33:06 +0530
Message-ID: <20260128060316.3967610-8-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260128060316.3967610-1-rbhansali@marvell.com>
References: <20260128060316.3967610-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Ka/fcAYD c=1 sm=1 tr=0 ts=6979a6de cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=XyxXChsBumu1WMGwIQ0A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA0NiBTYWx0ZWRfX0rOwpyDyXMgQ
 vwv5mEmhajqIptmtZEfi2IbvAOsa++pWwopooBfA1JPdN+KoVA9NUwAjeqSWEOm2aiXPZzGF0Zy
 s5f+lnKII/ilPgVZK5WcxjYfejFfYqCAjMbTRhOMw9jJyjsSGHuBBmKFdPdttiins89Nvpxioz2
 SqaFL/Xwu2q11E2Skz37ysKmo+g2wYMNyq/Btvfxn1ZNNpKZC+DI+k4BB5CNaYc/qYpKD7DLMf9
 hoRYBC68r3y5vuLVVz2fYmq0HsNAiNZItU+t4cKjo2GCIwSeCHLqNZHgtb3JS/3m1AXnCAguuYU
 yjNuf5UVGfgQJfTJWj8JolbIUnvZN9rPzESKFxM2XEjaS8zuM+5h7Dm2ua1MssJHCW7TKaOx7FM
 q7GWVR7hftUVL3f0uzGuCwoTSYZQ3MLyMrqWNzprN40xwoVFhdzWnEa0rX4+NIX9beV1hP0n/8h
 6xg7LQF4d1XN82QMx7w==
X-Proofpoint-GUID: A9xPIY23yOeIV_5E7JYy30ozH-x3Q9w9
X-Proofpoint-ORIG-GUID: A9xPIY23yOeIV_5E7JYy30ozH-x3Q9w9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_05,2026-01-27_03,2025-10-01_01
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

Add CPT ucode 0xF2 check as well for soft expiry handling.

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/net/cnxk/cn20k_ethdev_sec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/cnxk/cn20k_ethdev_sec.c b/drivers/net/cnxk/cn20k_ethdev_sec.c
index baa3423e28..bddc02eb3b 100644
--- a/drivers/net/cnxk/cn20k_ethdev_sec.c
+++ b/drivers/net/cnxk/cn20k_ethdev_sec.c
@@ -464,6 +464,7 @@ cn20k_eth_sec_post_event(struct rte_eth_dev *eth_dev, struct roc_ow_ipsec_outb_s
 			desc.subtype = RTE_ETH_EVENT_IPSEC_SA_BYTE_HARD_EXPIRY;
 		break;
 	case ROC_IE_OW_UCC_SUCCESS_SA_SOFTEXP_FIRST:
+	case ROC_IE_OW_UCC_SUCCESS_SA_SOFTEXP_AGAIN:
 		if (sa->w2.s.life_unit == ROC_IE_OW_SA_LIFE_UNIT_PKTS)
 			desc.subtype = RTE_ETH_EVENT_IPSEC_SA_PKT_EXPIRY;
 		else
-- 
2.34.1

