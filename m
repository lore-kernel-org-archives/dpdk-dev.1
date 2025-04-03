Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CCCC3601B
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Apr 2025 07:09:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AEB3740A6E;
	Thu,  3 Apr 2025 09:08:53 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 529FF406FF
 for <dev@dpdk.org>; Thu,  3 Apr 2025 09:08:52 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532NSgdS013269
 for <dev@dpdk.org>; Thu, 3 Apr 2025 00:08:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=J
 yLK9VbGX+kkQhu1a8YK/aHoGV1sXwRABV4l4rc2QeM=; b=SZsVXOH963GzAVhuJ
 ZBf6r47A9awaKHe9EqaA0TyjIgpSHd7nzUeHL9cgSekcA1uCk/ztWcRAkCH7UZCa
 /ylyOyda3xm1UKvKSQ7Hm2ARmnIkYKk2shDP7J9iqKJj2bIuXeBdVV1cwt7V2iHH
 1wV1cpndeiOVn7eWQSAPZjYAcfFbXy1MEisn0PkqjTEyv8XAEbhr39xjudnko3yO
 PLiwOH6Ll2eyJrHLMiA0ZSd/f3tgCRmp6xGEWcK1/DW5qDpuO8Uxl6vQEX3x1GxJ
 /1jjyMN+Ahx57tUIaC+c0/kEqFbandT3FdlpvVqCXYmecVwE8GdNQexhToSq46ko
 LJFIg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45sexm0qvf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 03 Apr 2025 00:08:51 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 3 Apr 2025 00:08:50 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 3 Apr 2025 00:08:50 -0700
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 75D823F70DA;
 Thu,  3 Apr 2025 00:08:48 -0700 (PDT)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>
Subject: [RFC PATCH 4/4] net/cnxk: report link type along with link status
Date: Thu, 3 Apr 2025 12:38:37 +0530
Message-ID: <20250403070837.926292-4-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250403070837.926292-1-ndabilpuram@marvell.com>
References: <20250403070837.926292-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: BOylIbgorcuUtEp6faXlxu5b5VYl_W0f
X-Authority-Analysis: v=2.4 cv=RN+zH5i+ c=1 sm=1 tr=0 ts=67ee3403 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=IsPr2kbUeO7OAf2wTyUA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: BOylIbgorcuUtEp6faXlxu5b5VYl_W0f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_02,2025-04-02_03,2024-11-22_01
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

Provide link type along with link status get.

Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
---
 drivers/net/cnxk/cnxk_ethdev.c | 21 ++++++++++++++++++++-
 drivers/net/cnxk/cnxk_ethdev.h |  1 +
 drivers/net/cnxk/cnxk_link.c   | 10 +++++++---
 3 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/net/cnxk/cnxk_ethdev.c b/drivers/net/cnxk/cnxk_ethdev.c
index 4dba4968d5..9dc442fa6d 100644
--- a/drivers/net/cnxk/cnxk_ethdev.c
+++ b/drivers/net/cnxk/cnxk_ethdev.c
@@ -6,7 +6,7 @@
 #include <rte_eventdev.h>
 #include <rte_pmd_cnxk.h>
 
-const uint32_t cnxk_mac_modes[CGX_MODE_MAX + 1] = {
+static const uint32_t cnxk_mac_modes[CGX_MODE_MAX + 1] = {
 	[CGX_MODE_SGMII] = RTE_ETH_LINK_SPEED_1G,
 	[CGX_MODE_1000_BASEX] = RTE_ETH_LINK_SPEED_1G,
 	[CGX_MODE_QSGMII] = RTE_ETH_LINK_SPEED_1G,
@@ -60,6 +60,17 @@ const uint32_t cnxk_mac_modes[CGX_MODE_MAX + 1] = {
 	[ETH_MODE_10G_QXGMII_BIT] = RTE_ETH_LINK_SPEED_10G,
 };
 
+static const uint8_t cnxk_port_type[] = {
+	[CGX_PORT_TP] = RTE_ETH_LINK_TYPE_TP,
+	[CGX_PORT_AUI] = RTE_ETH_LINK_TYPE_AUI,
+	[CGX_PORT_MII] = RTE_ETH_LINK_TYPE_MII,
+	[CGX_PORT_FIBRE] = RTE_ETH_LINK_TYPE_FIBRE,
+	[CGX_PORT_BNC] = RTE_ETH_LINK_TYPE_BNC,
+	[CGX_PORT_DA] = RTE_ETH_LINK_TYPE_DA,
+	[CGX_PORT_NONE] = RTE_ETH_LINK_TYPE_NONE,
+	[CGX_PORT_OTHER] = RTE_ETH_LINK_TYPE_OTHER,
+};
+
 cnxk_ethdev_rx_offload_cb_t cnxk_ethdev_rx_offload_cb;
 
 #define CNXK_NIX_CQ_INL_CLAMP_MAX (64UL * 1024UL)
@@ -95,6 +106,7 @@ static inline uint32_t
 nix_get_speed_capa(struct cnxk_eth_dev *dev)
 {
 	struct roc_nix_mac_fwdata fwdata;
+	struct rte_eth_link link;
 	uint32_t speed_capa;
 	uint8_t mode;
 	int rc;
@@ -114,6 +126,12 @@ nix_get_speed_capa(struct cnxk_eth_dev *dev)
 			if (fwdata.supported_link_modes & BIT_ULL(mode))
 				speed_capa |= cnxk_mac_modes[mode];
 		}
+		dev->link_type = cnxk_port_type[(uint8_t)fwdata.port_type];
+
+		/* Set link type at init */
+		memset(&link, 0, sizeof(link));
+		link.link_type = dev->link_type;
+		rte_eth_linkstatus_set(dev->eth_dev, &link);
 	}
 
 	return speed_capa;
@@ -1757,6 +1775,7 @@ cnxk_nix_dev_stop(struct rte_eth_dev *eth_dev)
 
 	/* Bring down link status internally */
 	memset(&link, 0, sizeof(link));
+	link.link_type = dev->link_type;
 	rte_eth_linkstatus_set(eth_dev, &link);
 
 	return 0;
diff --git a/drivers/net/cnxk/cnxk_ethdev.h b/drivers/net/cnxk/cnxk_ethdev.h
index daf80be51b..5f8df43d42 100644
--- a/drivers/net/cnxk/cnxk_ethdev.h
+++ b/drivers/net/cnxk/cnxk_ethdev.h
@@ -370,6 +370,7 @@ struct cnxk_eth_dev {
 	uint64_t rx_offload_capa;
 	uint64_t tx_offload_capa;
 	uint32_t speed_capa;
+	uint8_t link_type;
 	/* Configured Rx and Tx offloads */
 	uint64_t rx_offloads;
 	uint64_t tx_offloads;
diff --git a/drivers/net/cnxk/cnxk_link.c b/drivers/net/cnxk/cnxk_link.c
index 903b44de2c..38970eddd6 100644
--- a/drivers/net/cnxk/cnxk_link.c
+++ b/drivers/net/cnxk/cnxk_link.c
@@ -47,14 +47,16 @@ static void
 nix_link_status_print(struct rte_eth_dev *eth_dev, struct rte_eth_link *link)
 {
 	if (link && link->link_status)
-		plt_info("Port %d: Link Up - speed %u Mbps - %s",
+		plt_info("Port %d: Link Up - speed %u Mbps - %s - %s",
 			 (int)(eth_dev->data->port_id),
 			 (uint32_t)link->link_speed,
 			 link->link_duplex == RTE_ETH_LINK_FULL_DUPLEX
 				 ? "full-duplex"
-				 : "half-duplex");
+				 : "half-duplex",
+				 rte_eth_link_type_to_str(link->link_type));
 	else
-		plt_info("Port %d: Link Down", (int)(eth_dev->data->port_id));
+		plt_info("Port %d: Link Down - %s", (int)(eth_dev->data->port_id),
+			 rte_eth_link_type_to_str(link->link_type));
 }
 
 void
@@ -103,6 +105,7 @@ cnxk_eth_dev_link_status_cb(struct roc_nix *nix, struct roc_nix_link_info *link)
 	eth_link.link_speed = link->speed;
 	eth_link.link_autoneg = RTE_ETH_LINK_AUTONEG;
 	eth_link.link_duplex = link->full_duplex;
+	eth_link.link_type = dev->link_type;
 
 	/* Print link info */
 	nix_link_status_print(eth_dev, &eth_link);
@@ -142,6 +145,7 @@ cnxk_nix_link_update(struct rte_eth_dev *eth_dev, int wait_to_complete)
 		link.link_autoneg = RTE_ETH_LINK_AUTONEG;
 		if (info.full_duplex)
 			link.link_duplex = info.full_duplex;
+		link.link_type = dev->link_type;
 	}
 
 	return rte_eth_linkstatus_set(eth_dev, &link);
-- 
2.34.1

