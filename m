Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE72CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 08:09:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1660D40655;
	Tue,  4 Nov 2025 09:09:23 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 983B240672
 for <dev@dpdk.org>; Tue,  4 Nov 2025 09:09:20 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A41KEOE2407406 for <dev@dpdk.org>; Tue, 4 Nov 2025 00:09:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=f
 Z88ZK5tlUt4FZfvX4tiX5AV0O3sObBJheKNZ0D5Xto=; b=TZzcniuOOeYzVdXMC
 dZKyidiExdebx2P+aKVsyMR/KdoK6TyW+rxCBUsWgLXUp0XPfJnag5IW+1SkKjFM
 SsZhEjtkKvHqgtn9KBsVNVNV9kmHULY63vGbvarNCX0rZ4+N9rbrxMhx9XhrBZZH
 Tg4mfD4rZMBnG41S8aI7Y6LBvjD3pxRM8UQuqN7wgz1fxd/VUZ/MpFPrIX4KBQQu
 yfThnRZntPc1i0y1nwcIal9kNJ2E+gMgcK1WEENgZtnM8xacE289+C1dRxod4nzf
 XJsn2CIN3J/uHUfpSKZWMYFnhT/rjRnTOECRW+S6YwRQoFc++JRy690XOffXsIU/
 uCyQA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4a67bcwnpm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 04 Nov 2025 00:09:19 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 4 Nov 2025 00:09:29 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 4 Nov 2025 00:09:29 -0800
Received: from cavium-3070-BM23.. (unknown [10.28.34.25])
 by maili.marvell.com (Postfix) with ESMTP id 449673F7066;
 Tue,  4 Nov 2025 00:09:17 -0800 (PST)
From: <skori@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>
Subject: [PATCH v7 6/6] net/cnxk: report link mode
Date: Tue, 4 Nov 2025 13:38:54 +0530
Message-ID: <20251104080901.1610706-6-skori@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104080901.1610706-1-skori@marvell.com>
References: <20251023110332.6231-6-skori@marvell.com>
 <20251104080901.1610706-1-skori@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: L9ca8oUHY6r81l4EV1XTEa9bA7fWtzqB
X-Proofpoint-GUID: L9ca8oUHY6r81l4EV1XTEa9bA7fWtzqB
X-Authority-Analysis: v=2.4 cv=cs+WUl4i c=1 sm=1 tr=0 ts=6909b4af cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=koTAqf3Ast2ZiasxKz8A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA2NiBTYWx0ZWRfXxtH3T9uY9+Gw
 G9jXe+LPG0YwOyodf7VcNlJVNfDmya0V/LcWOPzNJgdpFHm4vCntr+YCxuKdUvlEJQTdn1+83kd
 6ILnU8AgU04LjlbxmFxzRwNj1E9Dz3oyKMkdoLX4YjF9tbrG/DcIGYfJQbtl8c5j1hvGaW24s62
 Z09Yp6mF8iO5m5cez8Eoe3ifCkRBjldURp/tGRoEHu0DDu+na8TM2729+3oLrn8Oj1o1ymirQp6
 j4nR4Rw9vMZX2o6aMtw1cJiz8U034ltnapsYFmnX5TvEnJhPaUYTCkU+1/A1D5ha2GQGcu2LUi2
 jsxxWyETN04ct/EQqe0+Nn4s3ylTLBkaH5/VXa7EVrN1knOktcOvdHYuLTeRllT5qjZEfG+ONgA
 eLmqOgzjGznoamwkh14ae2GGYWp7zA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
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

