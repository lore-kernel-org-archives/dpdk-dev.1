Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA9DCCFA05
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 07:04:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79DD240669;
	Fri,  7 Nov 2025 08:03:48 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 1B60C4042E
 for <dev@dpdk.org>; Fri,  7 Nov 2025 08:03:47 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A6ID7It3942992 for <dev@dpdk.org>; Thu, 6 Nov 2025 23:03:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=b
 LkLbPTXUZftnLTXIx1rAE0svEjYdav3ZlmLsC/Ruk4=; b=GEbn6LhGc88mTR39a
 AaAH/HXO8q1j6eP64jxVGtzPOUyHVkwZn848sZoqi++OZTbz1J2yqhScpmwhIzQA
 huH9dpio53+H6REosOD6/yEhsqbUBWuMHs7uWE5CPfINymACfZH0S+FCVLIjKWSF
 0dlT0SnJCI7bHyeBO8ldEwSXTt4GMs0D/9FklCtQVPTWwar3LbLAIc3JvmXP4X16
 27dRAH5r7JKxXKJgZMsV0vThQ85wQWXPTZZPvQ/jZgHq9KiYg7ow4c4ej4VOJXG6
 9SLASL0LXRtDQzuTDKI39xzv23dc3mHCc1WxF0W3z9vDGTljUrP0+RGRQXbyodDF
 Ua+ng==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4a8pk6559q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 06 Nov 2025 23:03:46 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 6 Nov 2025 23:03:45 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 6 Nov 2025 23:03:45 -0800
Received: from cavium-3070-BM23.. (unknown [10.28.34.25])
 by maili.marvell.com (Postfix) with ESMTP id A2B6E3F707C;
 Thu,  6 Nov 2025 23:03:43 -0800 (PST)
From: <skori@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>
Subject: [PATCH v8 5/6] net/cnxk: report link type and status
Date: Fri, 7 Nov 2025 12:33:23 +0530
Message-ID: <20251107070330.2155154-5-skori@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251107070330.2155154-1-skori@marvell.com>
References: <20251104080901.1610706-6-skori@marvell.com>
 <20251107070330.2155154-1-skori@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=IqYTsb/g c=1 sm=1 tr=0 ts=690d99d2 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=Ax6jqZJi9XUBVAB8cagA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 11cXTy2ZzG3cTqoVuEHMbLNt7c4_7F-t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA1NCBTYWx0ZWRfXxI4+GZ5hE/cK
 RoEjA+NysRItnPCBgfi89pJmbVUrFKB8WE7CdR6vpOP15S/zqYviTA4GJMPjQDthICdSOLFdDc+
 +qGgdnX4lz5wCsJlc4MsTmv0H2nPxGJdGRCGo1x0l7se50XT26oSYqJ5jFuGg2FbdPDG3A0SXgY
 dP0rx34UysQazozVGCsW3jyzVah1wYYIzLgx0tTOBSfctepsSDwZ7R89g5J6/Ly1cKZsf+U7yEA
 0oabzpQRC5viVLFalnjRzMlqdu47VpVLRhPszKBfFoQZtutfXzCH8soUkQLG/1QLM+1BmugVWGy
 sSewMehAstNTcVSV2enPWcVvqWzJBtOdmw1LOIuKh8b4OPkdyWsCxQgoP8AVYK6lBCNvfJVvYQm
 98mkAvPcDB5W+s6AugPlam5D2v0MTw==
X-Proofpoint-ORIG-GUID: 11cXTy2ZzG3cTqoVuEHMbLNt7c4_7F-t
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
index b5ef340de5..8ebe27067f 100644
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

