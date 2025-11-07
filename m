Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153B7CCFA05
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 07:04:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D0824066D;
	Fri,  7 Nov 2025 08:03:51 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id AE44640667
 for <dev@dpdk.org>; Fri,  7 Nov 2025 08:03:50 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A73U16i1335551 for <dev@dpdk.org>; Thu, 6 Nov 2025 23:03:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=I
 OmCTEYB1Yj5TdV2D7Ro5xrr6N77B6E60U9XuFdOduo=; b=cMoeJuHkUZVBg0X8U
 vg0zb5nHyz/DqvjHjYqoAW3YgikcYq9SAdh1V99yP0K4K9RmFL7BCHCAVQ1Qm5ay
 HGIHvlWWyKM/imlNH802/vkefWe65k+0k7qtNMtzE8DenQCKQJ1NoXQVvs/7lkGq
 NaFzHCfPjNGg0Hgj0SJrOSGh9i4JwweEQiqG+A4I1XmDe/h9CiS98hBuyDUrmiCA
 03QIkeUeyuPOgvrCYGMF3hwGUy0GhmZ7XiMIUPXZ2MDz1tE941nADNJdMZCzDqQK
 UB9Et1kc+jD5hGjofWLZJswbjuPZmeqtwvIx/GiPnYXvj/RZlIOosH83py1ftJ1O
 nrtlw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4a98wkgn9w-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 06 Nov 2025 23:03:49 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 6 Nov 2025 23:03:59 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 6 Nov 2025 23:03:59 -0800
Received: from cavium-3070-BM23.. (unknown [10.28.34.25])
 by maili.marvell.com (Postfix) with ESMTP id 2B0D23F707C;
 Thu,  6 Nov 2025 23:03:45 -0800 (PST)
From: <skori@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>
Subject: [PATCH v8 6/6] net/cnxk: report link mode
Date: Fri, 7 Nov 2025 12:33:24 +0530
Message-ID: <20251107070330.2155154-6-skori@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251107070330.2155154-1-skori@marvell.com>
References: <20251104080901.1610706-6-skori@marvell.com>
 <20251107070330.2155154-1-skori@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: tJmDeeG5kyZ1XztQRpdxW8mNIUpWRWRh
X-Proofpoint-GUID: tJmDeeG5kyZ1XztQRpdxW8mNIUpWRWRh
X-Authority-Analysis: v=2.4 cv=WY8BqkhX c=1 sm=1 tr=0 ts=690d99d5 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=SQ8vdVzYx1Jpl62JnecA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA1NSBTYWx0ZWRfXzGEYmzqhRzSF
 WaoUhSlEAjhVTGfkVWWD1I5ueksx8aCmy0ywEKQLCySO/cso0XE1cBh2/Kn5JXz1uxGgMeB1GKq
 0NX7KI2vf2jyedkAahm+LT4brRYE1D/v6vlKOqSd3YA0BaRN1gvxIbdnfshyYrIEh7aagBFoCNm
 z5gQcDSQmhHhDwEmyek74jvlSTACjm/AxdbBxVzk8pDBLRE0xOEzdp5wLBaFP+yIk5MXCJYqSDN
 togFTKha4/SG6032vuKvBTznix+XdqSvonJJ5MnHsjOmi3NRfCqYSzSffwF0TwWONIT14w46lYD
 Dd6FK9IVpgPuVVgxisDDe3k859jLz6FUJtcb81ziHMaFK60eRVuTVxxEPhYb0tnGJndGyLjcM79
 rFN4ZzloxRj0WLNHbMmw9IrwKhfPig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_01,2025-11-06_01,2025-10-01_01
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
 doc/guides/rel_notes/release_25_11.rst | 8 ++++++++
 drivers/net/cnxk/cnxk_link.c           | 4 ++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
index c5ba335cfc..b7921f5b57 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -128,6 +128,14 @@ New Features
 
   Added ENETC4 PMD for multiple new generation SoCs.
 
+* **Updated CNXK ethernet driver.**
+
+  Added support to set/get link configuration as mentioned below:
+
+  * Get speed capability from firmware instead of hard coded values.
+  * Report link type, mode and status.
+  * Configure link mode.
+
 * **Updated Wangxun txgbe ethernet driver.**
 
   Added support for Wangxun Amber-Lite NIC series,
diff --git a/drivers/net/cnxk/cnxk_link.c b/drivers/net/cnxk/cnxk_link.c
index 8ebe27067f..dde2c3a313 100644
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

