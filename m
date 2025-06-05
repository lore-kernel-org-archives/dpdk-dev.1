Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBD7C5AE59
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Jun 2025 11:43:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3614940670;
	Thu,  5 Jun 2025 13:42:53 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id D716F4067B
 for <dev@dpdk.org>; Thu,  5 Jun 2025 13:42:51 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554NaOPQ000528
 for <dev@dpdk.org>; Thu, 5 Jun 2025 04:42:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=E
 RnQZw10KJykvycrz1FfCO4FR4XYjoPXfDeP+XELlL8=; b=OKJg1tDZD7y3gAQSX
 iFveiBikgC5zHpt+6u8Jw0v5q6rLE3HOKjP/Jy/R/qyCYn9HFD4JD61M+gwYpcFX
 w2ArHS5PTgYgXnmN2diVPwtjDRDAfvdqPj0LQvyqgbG+VF3NpubiwAtGoJecRIAx
 iNY6ul+YLPSxfrgP3cOw8qjqc/bSG8Suwp4gFNI+RolOGPXs5HzTd+RfAZ9srz2/
 DBX6uqIW+03Aaq8RJjwv0DAJkRiryfcOwA05+4NEsDOqUsj7hrpwCyHftjehQNIn
 E8o1MFJAY//rpDX+zDMQl6rtsXLPYkxGh5Hq00dcuFRnhNEOE50SLnslw9uABKj1
 fWehA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 472yyb9a42-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 05 Jun 2025 04:42:51 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 5 Jun 2025 04:42:49 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 5 Jun 2025 04:42:49 -0700
Received: from cavium-3070-BM23.. (unknown [10.28.34.25])
 by maili.marvell.com (Postfix) with ESMTP id A4B073F7051;
 Thu,  5 Jun 2025 04:42:47 -0700 (PDT)
From: <skori@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>
Subject: [PATCH 6/6] net/cnxk: report link mode
Date: Thu, 5 Jun 2025 17:12:20 +0530
Message-ID: <20250605114231.3036050-6-skori@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250605114231.3036050-1-skori@marvell.com>
References: <20250605114231.3036050-1-skori@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 2vMV3rkDkN9r4gJxaeQOsgITDclw7Za7
X-Authority-Analysis: v=2.4 cv=F9hXdrhN c=1 sm=1 tr=0 ts=684182bb cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=koTAqf3Ast2ZiasxKz8A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDEwMCBTYWx0ZWRfX6kno6h0kcmfk
 jCPoTxiHo9YZwTmcqNBbRFDYX+wy4vW69648OGCy5cFg/3LS8z8/rfRZV5IUKtNgvt/vkPeud3N
 mbhh3romypOdv81DylJVvQU1oP678dS3BgphuoDMAX1Ujr4OL3PZens7XZVhX3ND1CzSTQU5Y2l
 Bv3YkhTIF+OiIWBJsAR1XND9V4humZa/Liaw0PUGhZpgP6wTqzN7xnxYkXnggaRy0zAbUEP8eRB
 jdUt0dLA4LH8Gj4eqSuL/N6x2E/ERJNyQsruHlNuaO9cat7HVnYXS0fG6BOSRnKcG2OAYPngZA6
 JnKooaxDOqDTI8suTWhC0mLlwuMZW8/psn359sULrdNCmYRMDxZ8gJBm7zk8i56IZf83opWeVmH
 9aXHRf+ZwxteKfqgsqhItgEe4BuVI9ZRU45JDQJZ2jIEoKhqcKUbEAu4UMYzYlkUnZCW8KcR
X-Proofpoint-ORIG-GUID: 2vMV3rkDkN9r4gJxaeQOsgITDclw7Za7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_02,2025-06-03_02,2025-03-28_01
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

Depends-on: patch-35378 ("ethdev: add support to provide link type")

Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
---
 drivers/net/cnxk/cnxk_link.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/cnxk/cnxk_link.c b/drivers/net/cnxk/cnxk_link.c
index a074f6f65e..d2b2372871 100644
--- a/drivers/net/cnxk/cnxk_link.c
+++ b/drivers/net/cnxk/cnxk_link.c
@@ -171,7 +171,7 @@ cnxk_eth_dev_link_status_cb(struct roc_nix *nix, struct roc_nix_link_info *link)
 
 	eth_link.link_status = link->status;
 	eth_link.link_speed = link->speed;
-	eth_link.link_autoneg = RTE_ETH_LINK_AUTONEG;
+	eth_link.link_autoneg = link->autoneg ? RTE_ETH_LINK_AUTONEG : RTE_ETH_LINK_FIXED;
 	eth_link.link_duplex = link->full_duplex;
 	eth_link.link_type = dev->link_type;
 
@@ -210,7 +210,7 @@ cnxk_nix_link_update(struct rte_eth_dev *eth_dev, int wait_to_complete)
 			return rc;
 		link.link_status = info.status;
 		link.link_speed = info.speed;
-		link.link_autoneg = RTE_ETH_LINK_AUTONEG;
+		link.link_autoneg = info.autoneg ? RTE_ETH_LINK_AUTONEG : RTE_ETH_LINK_FIXED;
 		if (info.full_duplex)
 			link.link_duplex = info.full_duplex;
 		link.link_type = dev->link_type;
-- 
2.43.0

