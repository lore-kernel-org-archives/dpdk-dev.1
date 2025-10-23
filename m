Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDD1CCD193
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 05:38:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CF3040430;
	Thu, 23 Oct 2025 07:37:57 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id E1FB5402E6
 for <dev@dpdk.org>; Thu, 23 Oct 2025 07:37:55 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MNSFE9020016
 for <dev@dpdk.org>; Wed, 22 Oct 2025 22:37:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=k
 c9yY5UIH5APxTtiv2hAJzwxMYJ8u7y38TaZ+cBtGlY=; b=U0HBkVPuW6XPIXk1I
 0wmwsQn7FO0w2oRd2ZIiaxZE1inybtCsWKcMD/ywHZEnIL/rn/lJzfmrLTZidZg3
 wzHk1z5LTIOlFTzz+c/8vjoL74ucUbOa8PcsVY5l3FlyKCMezsaWyYkElHKqsiiC
 kILKw0QfM6t2mfoNasE6D98ID4WzU75LiAznO6VxJoTFZytx2Clay/FAm+MMDh3m
 erqBumxDEcHZw9htM1VY2OTaeEQDe79Foro5WteNjCLgZpkBhyICHBebVCnDReml
 4R0PyTg91YB0hDJLb2KuQVKPIuX7t/xXjYH2US9I/2YceA/IiIND8sR+W+3hUiBb
 tt7mg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49y8yjrpcc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 22 Oct 2025 22:37:55 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 22 Oct 2025 22:37:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 22 Oct 2025 22:37:57 -0700
Received: from cavium-3070-BM23.. (unknown [10.28.34.25])
 by maili.marvell.com (Postfix) with ESMTP id 136B73F704C;
 Wed, 22 Oct 2025 22:37:45 -0700 (PDT)
From: <skori@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>
Subject: [PATCH v4 6/6] net/cnxk: report link mode
Date: Thu, 23 Oct 2025 11:07:18 +0530
Message-ID: <20251023053728.4091023-6-skori@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023053728.4091023-1-skori@marvell.com>
References: <20250814081637.1905660-6-skori@marvell.com>
 <20251023053728.4091023-1-skori@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ws_VlPjDIuFWpaJv-DdwLhfZ-K8L75ta
X-Authority-Analysis: v=2.4 cv=RLi+3oi+ c=1 sm=1 tr=0 ts=68f9bf33 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=koTAqf3Ast2ZiasxKz8A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE5NiBTYWx0ZWRfXz7GJ9+8nRAH7
 /oS8UAHelb3gkTcb+WBevTlKS6a75r/MjV2z7q8GetreHAGES1HsuUMmWwvAXzG1d9/SrxnPS0D
 B1Ys6p6Ff36bnyNTuze4UKA/4Fm1PMZWk9vf+n/sQheyzzLNzHCVFpEMrIczJ1e9/xogZPM7Ihf
 dedeWcAH+62+eahvcOXCmXWPeA0xtCfZk1f+ZK9ucYg6KjmzbMjo+ikJ5AoRejzFlysiaqmvD4+
 6Bi8GTd0DbvaSJcZdYk/ad4o26kzZ3KmnvnuX/cLovxipNTHW6GhXQP4jd9LH8vE1VLic/hO1mD
 AAfkW09wBBJBK0VLnlVZ9oBlNOSfWLdK0lC0WjXTNZR12+NMJMRU9huHj29rwxHkAWZxIXnzOfr
 kLDGj5pUAd/IPu8llacL/H4OVamfWQ==
X-Proofpoint-ORIG-GUID: ws_VlPjDIuFWpaJv-DdwLhfZ-K8L75ta
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

