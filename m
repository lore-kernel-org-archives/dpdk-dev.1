Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA42CCD1BC
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 07:55:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50A1A40612;
	Thu, 23 Oct 2025 09:55:12 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id C141F4060C
 for <dev@dpdk.org>; Thu, 23 Oct 2025 09:55:10 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N3hMuR029340
 for <dev@dpdk.org>; Thu, 23 Oct 2025 00:55:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=R
 v9aU8hdiNEUJWIM4KzNyCsRu0RZ1/l/taXkJMJ2d/8=; b=VyvIE6gPXGHkaFwdk
 K62wun/+mBbFXYjfHkpkWJKqgolHqXzGbQl0Kxi3pJkCHd8f/79H07H6F9JCxIR8
 r5ML4DsYzQwAroKN64AyfaXQrOsccTpc3ZnL6oQnmzLHTjkeL5mlhb8qVt1QDNFz
 HlDvaaoC4serMAj2YHijuNEy1KnWtDEVPNVqNVNOv4y5fBD2HAzL0W+7dCjYljRf
 N82otqmD02XrQ41+NRT1UBZxAM406HUv8J9sGI80632i+T0H6bUHtsF62kSIULKJ
 vQGkT+JPYpAgr0SAxQVrMMLY6q/og3IkNEOX5McqUbRDjhFc5rMAi64YmSCuJCSo
 imIZg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49ycq48ds7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 23 Oct 2025 00:55:09 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 23 Oct 2025 00:55:08 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 23 Oct 2025 00:55:08 -0700
Received: from cavium-3070-BM23.. (unknown [10.28.34.25])
 by maili.marvell.com (Postfix) with ESMTP id 5FBA53F7090;
 Thu, 23 Oct 2025 00:55:06 -0700 (PDT)
From: <skori@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>
Subject: [PATCH v5 6/6] net/cnxk: report link mode
Date: Thu, 23 Oct 2025 13:23:30 +0530
Message-ID: <20251023075450.4145667-6-skori@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023075450.4145667-1-skori@marvell.com>
References: <20251023053728.4091023-6-skori@marvell.com>
 <20251023075450.4145667-1-skori@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDAzMSBTYWx0ZWRfXw06I4b4W2B80
 qwV7J3JUHAaoO2VYLjviDwX7KtMIrnr/HxlgMfaEmyt9L5gn/8byfsEhRTERFUXXwNlOWByURWr
 Kiva4SfUMzEQKl+P2qWt6vlDF+8J2A5RQTS0BzYvFRPojheC8/YGiq8HUBOv7c6JG45xq/CtxEK
 mCY0RNDhgUzXSQbxx2RE2z7BVBXiMM7C6CoVGYVslRnaUaSrhBRCCWrnnDJRwZanTcfofZueMnh
 gUYII8EDL7AfVAJQOAEUjsM4/YunLeWU/ujoqAKs2sUltHs18MuZiQl7S6zvRn/KQShkTqDzS4U
 KD46nFp+ZqUTpMpzy5ccpifEpB0/m8QSINCiuyfJ2IVm9UG3JhCYjborlRTNZbfpK9nzmQgmUZH
 UVOQMoiTYt7djc5I2+OaSZRltECQAQ==
X-Authority-Analysis: v=2.4 cv=fI80HJae c=1 sm=1 tr=0 ts=68f9df5d cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=koTAqf3Ast2ZiasxKz8A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: bXP1tL6MDQGH_7tzm95JAwOC9CndWLxy
X-Proofpoint-ORIG-GUID: bXP1tL6MDQGH_7tzm95JAwOC9CndWLxy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
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

From: Sunil Kumar Kori <skori@marvell.com>

Reports link mode whether fixed or autonegotiation

Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
---
v4..v5:
 - Fix build failure.

 drivers/net/cnxk/cnxk_link.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/cnxk/cnxk_link.c b/drivers/net/cnxk/cnxk_link.c
index b29a4285a3..2eda47b809 100644
--- a/drivers/net/cnxk/cnxk_link.c
+++ b/drivers/net/cnxk/cnxk_link.c
@@ -171,7 +171,7 @@ cnxk_eth_dev_link_status_cb(struct roc_nix *nix, struct roc_nix_link_info *link)
 
 	eth_link.link_status = link->status;
 	eth_link.link_speed = link->speed;
-	eth_link.link_autoneg = RTE_ETH_LINK_AUTONEG;
+	eth_link.link_autoneg = link->autoneg ? RTE_ETH_LINK_AUTONEG : RTE_ETH_LINK_FIXED;
 	eth_link.link_duplex = link->full_duplex;
 	eth_link.link_connector = dev->link_type;
 
@@ -210,7 +210,7 @@ cnxk_nix_link_update(struct rte_eth_dev *eth_dev, int wait_to_complete)
 			return rc;
 		link.link_status = info.status;
 		link.link_speed = info.speed;
-		link.link_autoneg = RTE_ETH_LINK_AUTONEG;
+		link.link_autoneg = info.autoneg ? RTE_ETH_LINK_AUTONEG : RTE_ETH_LINK_FIXED;
 		if (info.full_duplex)
 			link.link_duplex = info.full_duplex;
 		link.link_connector = dev->link_type;
-- 
2.43.0

