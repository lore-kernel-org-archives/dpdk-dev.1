Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B191C5B543
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Jun 2025 09:07:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EBA8D40664;
	Thu,  5 Jun 2025 11:07:29 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 2552640664
 for <dev@dpdk.org>; Thu,  5 Jun 2025 11:07:28 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554NSHmU027066
 for <dev@dpdk.org>; Thu, 5 Jun 2025 02:07:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=k
 c9yY5UIH5APxTtiv2hAJzwxMYJ8u7y38TaZ+cBtGlY=; b=QzhlqC0BscR3JNUbJ
 ST4a5Gm0xtkDykiFb91JFOREsjjS8Op4bG2ggAnJk69vYS+WPOQkxUNAj4twi3XL
 jSgt/Jk6Y2L9/hs6laMw04owrDjdOLQdNIjX3JqWnKOwniv95DNgzBt24F03+5zx
 97qdkAMmQbDaVCKUTtW2yqHLziiQzFE0pgU1Jh4bKBKXWHa7Vv6Twmtk9TZ0eJ4v
 shYgbvYyLigyxinGmCqpPhHuzzq5cVEwGAuLOglQaAYntApdKztaU8wABSwjUtQO
 RtY5MPDx3l+dPyvI/Q6jfLtGIIu5IZPeKk+Z2wFX7aV13FsCoyQcK8Zh4i5aTShy
 8MC4Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 472yuch1tu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 05 Jun 2025 02:07:27 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 5 Jun 2025 02:07:26 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 5 Jun 2025 02:07:26 -0700
Received: from cavium-3070-BM23.. (unknown [10.28.34.25])
 by maili.marvell.com (Postfix) with ESMTP id 42DB83F7079;
 Thu,  5 Jun 2025 02:07:24 -0700 (PDT)
From: <skori@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>
Subject: [PATCH 7/7] net/cnxk: report link mode
Date: Thu, 5 Jun 2025 14:36:42 +0530
Message-ID: <20250605090657.3032918-7-skori@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250605090657.3032918-1-skori@marvell.com>
References: <20250605090657.3032918-1-skori@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: miLTRXOi8Vb6YOzLHY2oGNNDPRVjP8-0
X-Proofpoint-GUID: miLTRXOi8Vb6YOzLHY2oGNNDPRVjP8-0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDA3OSBTYWx0ZWRfXzDuMusi31ZZf
 f0HW6DbhDuLf9GyChJq3LQZIYPcvQBmYg8LvrvCwlSDdEL7CZYCnsnJGt2FMckb0FQUc+hHcF4z
 GKCX0QYYvC1VYtKVeAxGyMGhRzMEsk513DGTJ2zZPVR3YK3mjgppCAAtPWbnt7RDL3V6bxcjsry
 GBusTK9rEyMbA6RQEVlFZr0ZbASWfB0yrYBRDpyi38Xd1OvP+Clm9vV9+a/jYK0bM4vtGD+O6Jz
 074jBxFW3UFe5csAHAKXtH5yKeuCzFwrloNieMAn5BRGMVS4sLffBssohgPub3GxMWCn4fxGK3a
 4KinN/meLBR9YFUzJdXePWVunmoHV46RM/pywAgVZAdI43Nx/mcuhML6ATRCXrwVZdSOO3PhU/P
 oEm1JOI1IgI00o+aJQQEqSfhMHiEaj4X7RFK+JR+5L+rjKLTxVIgep3toUZmbswOeuP/d/2o
X-Authority-Analysis: v=2.4 cv=Wp0rMcfv c=1 sm=1 tr=0 ts=68415e4f cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=koTAqf3Ast2ZiasxKz8A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
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

