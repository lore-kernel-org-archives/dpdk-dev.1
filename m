Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E59CCD1BE
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 11:05:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 77F5340648;
	Thu, 23 Oct 2025 13:05:26 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id E0DB2402E1
 for <dev@dpdk.org>; Thu, 23 Oct 2025 13:05:24 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N3hgjS029790
 for <dev@dpdk.org>; Thu, 23 Oct 2025 04:05:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=J
 dojitKBjnG/FUMOGa7kJlpMa467unhF+4ry9mXegqQ=; b=Rj4Kg1HDRzu37jEv8
 yyty7VQ31/bqajCDYsRAOoMw1pEjOAjLLSAnajod+EzBRLGu0dJVGjwUwkRFn01q
 D2mOoQAkYKfj07yqhb1qduOugcLj/d7dk3q2f6eS6fjwVvQgQZMgpCz2bR/YKZtD
 6StD3bEb+JehF+bVyugYH2uq1RA6vt5aGC6+8n066ZCjlHw7PQYFwjtK+h+vksS6
 8KkKesTZTdHN9xblNY6nKQVjxdJzGz5epusICvjoHsPIv5XgOTyuVi/D0yFGwvpe
 bdzJbShinZborbQENJy079q4F40B8RZFk8jSAJoOG+5O3q2+FeWbxzE1+7dL+PdA
 S9G6A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49ycq48v2k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 23 Oct 2025 04:05:24 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 23 Oct 2025 04:05:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 23 Oct 2025 04:05:21 -0700
Received: from cavium-3070-BM23.. (unknown [10.28.34.25])
 by maili.marvell.com (Postfix) with ESMTP id 9EF9A3F70A9;
 Thu, 23 Oct 2025 04:05:20 -0700 (PDT)
From: <skori@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>
Subject: [PATCH v6 5/6] net/cnxk: report link type and status
Date: Thu, 23 Oct 2025 16:32:05 +0530
Message-ID: <20251023110332.6231-5-skori@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023110332.6231-1-skori@marvell.com>
References: <20251023075450.4145667-6-skori@marvell.com>
 <20251023110332.6231-1-skori@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDAzMSBTYWx0ZWRfXzKE1P0ca2ypU
 97nJPM+xArcUN90kI1r+wKAuWfzkndADyoKh4yi22htQtOJmNtjVjMNNKwSCwuS3PCPCReVJJbP
 0W60uTNQFZUyTadMfEJ29r6TryE5wS6nul/Avloc8WHXxqkltPzbTI7h3Ov49TlGqgoC02ayAbc
 wZT3EeNmkLI9IUeS3gwLWSpnLr7X6cgEGs7nbV9om2hwAib50dx2Guo3mFKdibiTD90+4WY6JN7
 Dw4UkxjSwPI5xXGQkEB1KeuD99b0VGsZupLdp057Ja/vm5hz4oHlOmX2jVEi7g/R4mqLm8RW/jB
 Plk/DR69t4rhg7j/6vzNZ5j2VJBj3RjJ+7v7T72ljVdUv403c3rQymnDX6/1cmyemCvJnAjDxxK
 seEDQsL3MKQ7ZdqVkSLTAfkDWh/hHw==
X-Authority-Analysis: v=2.4 cv=fI80HJae c=1 sm=1 tr=0 ts=68fa0bf4 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=Ax6jqZJi9XUBVAB8cagA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 9Pd5qTzXKL2mpCoR7_1LNPedz9qigHLd
X-Proofpoint-ORIG-GUID: 9Pd5qTzXKL2mpCoR7_1LNPedz9qigHLd
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

Retrieves type of port i.e. twisted pair, fibre etc
from firmware and reports the same to user.

Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
---
v5..v6:
 - Rebased on ToT

 drivers/net/cnxk/cnxk_ethdev.c | 19 +++++++++++++++++++
 drivers/net/cnxk/cnxk_ethdev.h |  1 +
 drivers/net/cnxk/cnxk_link.c   | 10 +++++++---
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/net/cnxk/cnxk_ethdev.c b/drivers/net/cnxk/cnxk_ethdev.c
index aa120225ba..7c1aa34de2 100644
--- a/drivers/net/cnxk/cnxk_ethdev.c
+++ b/drivers/net/cnxk/cnxk_ethdev.c
@@ -62,6 +62,17 @@ static const uint32_t cnxk_mac_modes[CGX_MODE_MAX + 1] = {
 	[ETH_MODE_10G_QXGMII_BIT] = RTE_ETH_LINK_SPEED_10G,
 };
 
+static const uint8_t cnxk_port_type[] = {
+	[CGX_PORT_TP] = RTE_ETH_LINK_CONNECTOR_TP,
+	[CGX_PORT_AUI] = RTE_ETH_LINK_CONNECTOR_AUI,
+	[CGX_PORT_MII] = RTE_ETH_LINK_CONNECTOR_MII,
+	[CGX_PORT_FIBRE] = RTE_ETH_LINK_CONNECTOR_FIBER,
+	[CGX_PORT_BNC] = RTE_ETH_LINK_CONNECTOR_BNC,
+	[CGX_PORT_DA] = RTE_ETH_LINK_CONNECTOR_DAC,
+	[CGX_PORT_NONE] = RTE_ETH_LINK_CONNECTOR_NONE,
+	[CGX_PORT_OTHER] = RTE_ETH_LINK_CONNECTOR_OTHER,
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
+		link.link_connector = dev->link_type;
+		rte_eth_linkstatus_set(dev->eth_dev, &link);
 	}
 
 	return speed_capa;
@@ -1787,6 +1805,7 @@ cnxk_nix_dev_stop(struct rte_eth_dev *eth_dev)
 
 	/* Bring down link status internally */
 	memset(&link, 0, sizeof(link));
+	link.link_connector = dev->link_type;
 	rte_eth_linkstatus_set(eth_dev, &link);
 
 	return 0;
diff --git a/drivers/net/cnxk/cnxk_ethdev.h b/drivers/net/cnxk/cnxk_ethdev.h
index 75a6d2794d..3d0a587406 100644
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
index 0bc56fbb8c..b29a4285a3 100644
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
+				 rte_eth_link_connector_to_str(link->link_connector));
 	else
-		plt_info("Port %d: Link Down", (int)(eth_dev->data->port_id));
+		plt_info("Port %d: Link Down - %s", (int)(eth_dev->data->port_id),
+			 rte_eth_link_connector_to_str(link->link_connector));
 }
 
 void
@@ -171,6 +173,7 @@ cnxk_eth_dev_link_status_cb(struct roc_nix *nix, struct roc_nix_link_info *link)
 	eth_link.link_speed = link->speed;
 	eth_link.link_autoneg = RTE_ETH_LINK_AUTONEG;
 	eth_link.link_duplex = link->full_duplex;
+	eth_link.link_connector = dev->link_type;
 
 	/* Print link info */
 	nix_link_status_print(eth_dev, &eth_link);
@@ -210,6 +213,7 @@ cnxk_nix_link_update(struct rte_eth_dev *eth_dev, int wait_to_complete)
 		link.link_autoneg = RTE_ETH_LINK_AUTONEG;
 		if (info.full_duplex)
 			link.link_duplex = info.full_duplex;
+		link.link_connector = dev->link_type;
 	}
 
 	return rte_eth_linkstatus_set(eth_dev, &link);
-- 
2.43.0

