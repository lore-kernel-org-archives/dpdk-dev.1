Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B45CCD1BE
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 11:05:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8995D4042F;
	Thu, 23 Oct 2025 13:05:30 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 4A0DD4042F
 for <dev@dpdk.org>; Thu, 23 Oct 2025 13:05:28 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N3ckdT021882
 for <dev@dpdk.org>; Thu, 23 Oct 2025 04:05:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=Z
 Ei6GcFQFGgzJkjcL2qBASONSItXQUALo/5UCUIoGAU=; b=c2JqXseR8Kjc+gV24
 OGw+rPk/aJz3EbhDi+hJHk1Sz07m1G1p2UzKbcSNDjkROxa9xpwJmozDsyub2K04
 Gm2/JhIDmQaCw+6EHVwdHprEtIG1N5NzhwKPejwkshAdSRMqcGn2lRm68lXv6oJw
 FY86vt2bKQJurHzpB7CfiJqMAN8y206sbH0bO21bDrdbLntm9GyQmXG9GPybdKRT
 wvk/arLkhXSkR0Ytfcdl6hxakoN+5JnTUuqNwQzvXpHQ1E1CXVwv/sp3hIz7fIaU
 O9sR38vrWFSYKNLAP/XmR1/dNFh0V09EMswake8Pogu6TRZs2/P49YSvm7LJisUZ
 1B2GA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49ycmr0w31-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 23 Oct 2025 04:05:27 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 23 Oct 2025 04:05:34 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 23 Oct 2025 04:05:34 -0700
Received: from cavium-3070-BM23.. (unknown [10.28.34.25])
 by maili.marvell.com (Postfix) with ESMTP id 2939F3F70A9;
 Thu, 23 Oct 2025 04:05:22 -0700 (PDT)
From: <skori@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>
Subject: [PATCH v6 6/6] net/cnxk: report link mode
Date: Thu, 23 Oct 2025 16:32:06 +0530
Message-ID: <20251023110332.6231-6-skori@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023110332.6231-1-skori@marvell.com>
References: <20251023075450.4145667-6-skori@marvell.com>
 <20251023110332.6231-1-skori@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: KB9DdYFmn0nS2psrVPctvvDUpNQ_ADHR
X-Proofpoint-GUID: KB9DdYFmn0nS2psrVPctvvDUpNQ_ADHR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDAzMCBTYWx0ZWRfX9iUnaH3d5h/a
 Df5Z3YSNOs33Fh+3yB6WtYfDgGmZZ5jH+Om38Yz/OVfOzqnxhyg8mvBD7EEWruXzPHm8KiPO4fW
 yQzgId1kvzdxkBuXAHzuSj8BY5ixo175FFaJa6Wi6AXV4CowVfOzFNmDHDXZPL9RS9/uEwqvRnH
 hAfx0Mfh4dC7TV2I8XqWqBHpqY40zdG7JiaNyO81iD+2OaM19ZHJQPqYkPp6OXk4rmxVc4uui8S
 AhstJU/IzeVfWLHKgAyAal0VKrA2n9MzEjzSMmJF244dblnMijjfQ0fAMEA0AeSx8nwmdIlDrEe
 XWGJNqlxhZ0S4VUf6Td36bX3bgZc5kkyJTsTbjV5MEQkNZWRIncILF4Al/vaWXMS/0sTa9DROFC
 AXZvbvvI1gljlmYGMlN4yakqKN0qVw==
X-Authority-Analysis: v=2.4 cv=CtSys34D c=1 sm=1 tr=0 ts=68fa0bf7 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=koTAqf3Ast2ZiasxKz8A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
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
v5..v6:
 - Rebased on ToT

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

