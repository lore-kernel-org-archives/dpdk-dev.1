Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11693C5AE59
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Jun 2025 11:43:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A7EC4065E;
	Thu,  5 Jun 2025 13:42:50 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 623F140656
 for <dev@dpdk.org>; Thu,  5 Jun 2025 13:42:49 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5559Zlqf005807
 for <dev@dpdk.org>; Thu, 5 Jun 2025 04:42:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=9
 0lJGda3e7UPWdajvW6elHCS9CTYqwlh9RarTUreqro=; b=BEDJPPIVUIe53kIWJ
 X5z03XmNgvimsg5UEEtU1CjO1ETpjMG6w9GKKLW7Plq9y+3zeTXv+3DToMhOe77S
 Gtv7/ukh5EO9w+bzrIt6UCQdpSvyfiKVXTRkmZPdooWqWLL/rhPYqXOulVOPK3Nf
 aKz5cxxNVDe2Wy4/oW5RwwIJOqsoWHynjStlC7i8P/qDyHE7v26Ky1QOF3bcbij/
 PYasn6m3vqyed17IyCk7wlA40smFgQeCw0ssajJZIrWErYgCs5DMpi9yup999mqi
 LcKpocRB1Efi17hWpaCDZ9W5NHCcx6IzCgYls3MpKRW1k3GwsD3AdczqAoCKcubz
 old1w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4738r7g78b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 05 Jun 2025 04:42:48 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 5 Jun 2025 04:42:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 5 Jun 2025 04:42:47 -0700
Received: from cavium-3070-BM23.. (unknown [10.28.34.25])
 by maili.marvell.com (Postfix) with ESMTP id D7FBE3F7051;
 Thu,  5 Jun 2025 04:42:44 -0700 (PDT)
From: <skori@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>
Subject: [PATCH 5/6] net/cnxk: report link type and status
Date: Thu, 5 Jun 2025 17:12:19 +0530
Message-ID: <20250605114231.3036050-5-skori@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250605114231.3036050-1-skori@marvell.com>
References: <20250605114231.3036050-1-skori@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=UNHdHDfy c=1 sm=1 tr=0 ts=684182b8 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=Ax6jqZJi9XUBVAB8cagA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDEwMCBTYWx0ZWRfX4CAL2h45WOwK
 eq2FcW/v3yJjy40scSOCwLDx1lgYxs/V85I1kl+DDbF4M9mptIfsI1mdNzuRWcmZFPiH6CKEjpl
 DvtZA7DjXLKZmA6Ra47bVvmCNt7rLyOASrZ0x9t8q6O+jeDVL3/7LU6gCsmRSgviuzuJiCI2Ecg
 AMmSL6Noq9bsUZDtnaUKydFz3vCgxXjEQK+mGfkF+eD9WdCVb6ow+pMAPvlZnOUiEUqRwd3ug3/
 I6PyY6fR1MJnSSzGDmwGixAGMZD3AJflKkLJ+pZy0DkewsuCsVJZ8aeBYa6uoDc6P9eD55seUQz
 /44ffK6Xsrl/WRc0SmSjCcvoOpO6oWAN8baD1F0FazhTYXoIWZee5iJeevv8mhqBK/VbVUs+xGS
 68hjSgNdLSmPZodEroSVS3+WXx+UWqSbyzT4MAwD7dZfm6C8cGVCTZY2UleTk6tlUyVHcXMs
X-Proofpoint-ORIG-GUID: JzVKHu5sCC1oy9LT1VUOwpmnSynlF3nL
X-Proofpoint-GUID: JzVKHu5sCC1oy9LT1VUOwpmnSynlF3nL
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

Retrieves type of port i.e. twisted pair, fibre etc
from firmware and reports the same to user.

Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
---
 drivers/net/cnxk/cnxk_ethdev.c | 19 +++++++++++++++++++
 drivers/net/cnxk/cnxk_ethdev.h |  1 +
 drivers/net/cnxk/cnxk_link.c   | 10 +++++++---
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/net/cnxk/cnxk_ethdev.c b/drivers/net/cnxk/cnxk_ethdev.c
index 34f391e755..d5df73cc91 100644
--- a/drivers/net/cnxk/cnxk_ethdev.c
+++ b/drivers/net/cnxk/cnxk_ethdev.c
@@ -62,6 +62,17 @@ static const uint32_t cnxk_mac_modes[CGX_MODE_MAX + 1] = {
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
@@ -98,6 +109,7 @@ static inline uint32_t
 nix_get_speed_capa(struct cnxk_eth_dev *dev)
 {
 	struct roc_nix_mac_fwdata fwdata;
+	struct rte_eth_link link;
 	uint32_t speed_capa;
 	uint8_t mode;
 	int rc;
@@ -120,6 +132,12 @@ nix_get_speed_capa(struct cnxk_eth_dev *dev)
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
@@ -1784,6 +1802,7 @@ cnxk_nix_dev_stop(struct rte_eth_dev *eth_dev)
 
 	/* Bring down link status internally */
 	memset(&link, 0, sizeof(link));
+	link.link_type = dev->link_type;
 	rte_eth_linkstatus_set(eth_dev, &link);
 
 	return 0;
diff --git a/drivers/net/cnxk/cnxk_ethdev.h b/drivers/net/cnxk/cnxk_ethdev.h
index c11a3e6ce0..17734b806b 100644
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
index 0bc56fbb8c..a074f6f65e 100644
--- a/drivers/net/cnxk/cnxk_link.c
+++ b/drivers/net/cnxk/cnxk_link.c
@@ -115,14 +115,16 @@ static void
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
@@ -171,6 +173,7 @@ cnxk_eth_dev_link_status_cb(struct roc_nix *nix, struct roc_nix_link_info *link)
 	eth_link.link_speed = link->speed;
 	eth_link.link_autoneg = RTE_ETH_LINK_AUTONEG;
 	eth_link.link_duplex = link->full_duplex;
+	eth_link.link_type = dev->link_type;
 
 	/* Print link info */
 	nix_link_status_print(eth_dev, &eth_link);
@@ -210,6 +213,7 @@ cnxk_nix_link_update(struct rte_eth_dev *eth_dev, int wait_to_complete)
 		link.link_autoneg = RTE_ETH_LINK_AUTONEG;
 		if (info.full_duplex)
 			link.link_duplex = info.full_duplex;
+		link.link_type = dev->link_type;
 	}
 
 	return rte_eth_linkstatus_set(eth_dev, &link);
-- 
2.43.0

