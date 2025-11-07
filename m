Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19835CCFA05
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 07:03:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60D704065A;
	Fri,  7 Nov 2025 08:03:46 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 3C41940662
 for <dev@dpdk.org>; Fri,  7 Nov 2025 08:03:45 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A75X6Ph1492965 for <dev@dpdk.org>; Thu, 6 Nov 2025 23:03:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=C
 OvgAC5fpolFZNUpZ5I2vGVGeO4KcqiKEaCEnjyNAAw=; b=HzcllVLo+CCdh30c9
 wMNF01uAmaRtFfjOQ7dP487f0K5wMeZYbjeIFdzplsdzdrzOO28gJ3/ePoF/hgfA
 8rn5m7ZgQiBrLATN4G8DGwo+ZFifmhaANIHNV3DMNGjRGXNowfwHlLamEJVv+L4N
 MKYxKGJ96FikA6sMWjEdih7wM39RdbxOz7mNOzBydQnTsB8QPaQALvfKMS0itisR
 PJpV+EHIZ78pWYQ/KW1rPGPNOuB55lSrXqz8Do4zvnXpFUnJ0uL3a+PAMlJ3ngRW
 2+RU03W+5iQw9svlLpPNwxoLaH2e+NSSd0sxRXwMK7JQ2eM9hOV2dJiG33yzhcSy
 64F3Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4a9aqkg91u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 06 Nov 2025 23:03:43 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 6 Nov 2025 23:03:54 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 6 Nov 2025 23:03:54 -0800
Received: from cavium-3070-BM23.. (unknown [10.28.34.25])
 by maili.marvell.com (Postfix) with ESMTP id D4BB53F707C;
 Thu,  6 Nov 2025 23:03:40 -0800 (PST)
From: <skori@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>
Subject: [PATCH v8 4/6] net/cnxk: support link mode configuration
Date: Fri, 7 Nov 2025 12:33:22 +0530
Message-ID: <20251107070330.2155154-4-skori@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251107070330.2155154-1-skori@marvell.com>
References: <20251104080901.1610706-6-skori@marvell.com>
 <20251107070330.2155154-1-skori@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=XvD3+FF9 c=1 sm=1 tr=0 ts=690d99d0 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=83_Lh2SUWi18qvg5i8YA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA1NSBTYWx0ZWRfX/OdSJd3N7izT
 hg1DQSzZURxaGj+GTT7zlQ6xAZMHzr6kMHGX+nDnikDAhxKPqwI9Ao6N93vGjmwcxadKbZx7gnO
 pXhXe7wQj/aDo5NQK+vKdwB7RQqSMuKwA3e09ASWT8WuJtV/na/MNXSL/n3tLVA94UtWQ85tyFJ
 HzOphMIaEKS09UIL42U9a5EsLM1orqL0HDFoz8VX8PhlPdGAhk3+8sHFDnjWCcENAhQGgPB5IUa
 BWH0bc5EaQRw5c5cNYuYG/ZefsrlK/HJsk0jLSQdF+3zCUvENVA5ovQyP1MgqPRyDbSuXUwSSV1
 sLUrzuAaczkgF8g/f6E01iMOKOro/U6cy3YrsbZWkROuuhr+yrrQkGuydBZY42NEcWulYUSQjZ+
 kZKm37MPSAHvr5nH+vFzRIPyemB+yA==
X-Proofpoint-ORIG-GUID: khos1lunG6OrDu-d7IzHYOTifRvpS-JC
X-Proofpoint-GUID: khos1lunG6OrDu-d7IzHYOTifRvpS-JC
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

As a port can be configured to operate on specific
mode and speed via struct rte_eth_conf::link_speeds
in rte_eth_dev_configure() API.

Implement mentioned configuration passed by user.

Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
---
 drivers/net/cnxk/cnxk_ethdev.c |   6 ++
 drivers/net/cnxk/cnxk_ethdev.h |   1 +
 drivers/net/cnxk/cnxk_link.c   | 132 +++++++++++++++++++++++++++++++++
 3 files changed, 139 insertions(+)

diff --git a/drivers/net/cnxk/cnxk_ethdev.c b/drivers/net/cnxk/cnxk_ethdev.c
index 14e9707fcb..aa120225ba 100644
--- a/drivers/net/cnxk/cnxk_ethdev.c
+++ b/drivers/net/cnxk/cnxk_ethdev.c
@@ -3,6 +3,7 @@
  */
 #include <cnxk_ethdev.h>
 
+#include <rte_bitops.h>
 #include <eal_export.h>
 #include <rte_eventdev.h>
 #include <rte_pmd_cnxk.h>
@@ -1612,6 +1613,11 @@ cnxk_nix_configure(struct rte_eth_dev *eth_dev)
 		    eth_dev->data->port_id, ea_fmt, nb_rxq, nb_txq,
 		    dev->rx_offloads, dev->tx_offloads);
 
+	/* Configure link parameters */
+	rc = cnxk_nix_link_info_configure(eth_dev);
+	if (rc)
+		plt_warn("Unable to configure requested link attributes, rc=%d continue...", rc);
+
 	/* All good */
 	dev->configured = 1;
 	dev->nb_rxq = data->nb_rx_queues;
diff --git a/drivers/net/cnxk/cnxk_ethdev.h b/drivers/net/cnxk/cnxk_ethdev.h
index 67867c889b..75a6d2794d 100644
--- a/drivers/net/cnxk/cnxk_ethdev.h
+++ b/drivers/net/cnxk/cnxk_ethdev.h
@@ -678,6 +678,7 @@ void cnxk_eth_dev_link_status_cb(struct roc_nix *nix,
 void cnxk_eth_dev_link_status_get_cb(struct roc_nix *nix,
 				     struct roc_nix_link_info *link);
 void cnxk_eth_dev_q_err_cb(struct roc_nix *nix, void *data);
+int cnxk_nix_link_info_configure(struct rte_eth_dev *eth_dev);
 int cnxk_nix_link_update(struct rte_eth_dev *eth_dev, int wait_to_complete);
 int cnxk_nix_queue_stats_mapping(struct rte_eth_dev *dev, uint16_t queue_id,
 				 uint8_t stat_idx, uint8_t is_rx);
diff --git a/drivers/net/cnxk/cnxk_link.c b/drivers/net/cnxk/cnxk_link.c
index 903b44de2c..b5ef340de5 100644
--- a/drivers/net/cnxk/cnxk_link.c
+++ b/drivers/net/cnxk/cnxk_link.c
@@ -4,6 +4,74 @@
 
 #include "cnxk_ethdev.h"
 
+const enum roc_nix_link_mode mac_to_ethtool_mode[CGX_LMAC_TYPE_MAX][2] = {
+	[CGX_LMAC_TYPE_SGMII][ROC_NIX_LINK_DUPLEX_HALF] = ROC_NIX_LINK_MODE_1000BASET_HD,
+	[CGX_LMAC_TYPE_SGMII][ROC_NIX_LINK_DUPLEX_FULL] = ROC_NIX_LINK_MODE_1000BASET_FD,
+	[CGX_LMAC_TYPE_10G_R][ROC_NIX_LINK_DUPLEX_FULL] = ROC_NIX_LINK_MODE_10000BASESR_FD,
+	[CGX_LMAC_TYPE_QSGMII][ROC_NIX_LINK_DUPLEX_HALF] = ROC_NIX_LINK_MODE_1000BASET_HD,
+	[CGX_LMAC_TYPE_QSGMII][ROC_NIX_LINK_DUPLEX_FULL] = ROC_NIX_LINK_MODE_10000BASET_FD,
+};
+
+const enum roc_nix_link_mode rte_to_ethtool_mode[ROC_NIX_LINK_SPEED_MAX] = {
+	0,
+	ROC_NIX_LINK_MODE_10BASET_HD,
+	ROC_NIX_LINK_MODE_10BASET_FD,
+	ROC_NIX_LINK_MODE_100BASET_HD,
+	ROC_NIX_LINK_MODE_100BASET_FD,
+	ROC_NIX_LINK_MODE_1000BASET_FD,
+	ROC_NIX_LINK_MODE_2500BASEX_FD,
+	0,
+	ROC_NIX_LINK_MODE_10000BASESR_FD,
+	0,
+	ROC_NIX_LINK_MODE_25000BASESR_FD,
+	ROC_NIX_LINK_MODE_40000BASELR4_FD,
+	ROC_NIX_LINK_MODE_50000BASELR_ER_FR_FD,
+	0,
+	ROC_NIX_LINK_MODE_100000BASELR4_ER4_FD,
+	0,
+	0,
+};
+
+static uint64_t
+nix_link_advertising_get(struct cnxk_eth_dev *dev, struct roc_nix_link_info *link_info)
+{
+	struct roc_nix_mac_fwdata fwdata;
+	struct roc_nix_link_info linfo;
+	uint64_t advertise = 0;
+	int bit, rc;
+
+	memset(&fwdata, 0, sizeof(fwdata));
+	rc = roc_nix_mac_fwdata_get(&dev->nix, &fwdata);
+	if (rc) {
+		plt_err("Failed to get MAC firmware data");
+		goto exit;
+	}
+
+	memset(&linfo, 0, sizeof(linfo));
+	rc = roc_nix_mac_link_info_get(&dev->nix, &linfo);
+	if (rc) {
+		plt_err("Failed to get MAC link info");
+		goto exit;
+	}
+
+	if (link_info->autoneg) {
+		if (!fwdata.supported_an) {
+			plt_err("Autoneg is not supported");
+			goto exit;
+		} else {
+			for (bit = 0; bit < ROC_NIX_LINK_SPEED_MAX; bit++) {
+				if (link_info->speed_bitmask & BIT_ULL(bit))
+					advertise |= rte_to_ethtool_mode[bit];
+			}
+			goto exit;
+		}
+	}
+
+	advertise |= mac_to_ethtool_mode[linfo.lmac_type_id][link_info->full_duplex];
+exit:
+	return advertise;
+}
+
 void
 cnxk_nix_toggle_flag_link_cfg(struct cnxk_eth_dev *dev, bool set)
 {
@@ -146,3 +214,67 @@ cnxk_nix_link_update(struct rte_eth_dev *eth_dev, int wait_to_complete)
 
 	return rte_eth_linkstatus_set(eth_dev, &link);
 }
+
+int
+cnxk_nix_link_info_configure(struct rte_eth_dev *eth_dev)
+{
+	uint32_t speed_map[] = {
+		RTE_ETH_SPEED_NUM_NONE, RTE_ETH_SPEED_NUM_10M,  RTE_ETH_SPEED_NUM_10M,
+		RTE_ETH_SPEED_NUM_100M, RTE_ETH_SPEED_NUM_100M, RTE_ETH_SPEED_NUM_1G,
+		RTE_ETH_SPEED_NUM_2_5G, RTE_ETH_SPEED_NUM_5G,   RTE_ETH_SPEED_NUM_10G,
+		RTE_ETH_SPEED_NUM_20G,  RTE_ETH_SPEED_NUM_25G,  RTE_ETH_SPEED_NUM_40G,
+		RTE_ETH_SPEED_NUM_50G,  RTE_ETH_SPEED_NUM_56G,  RTE_ETH_SPEED_NUM_100G,
+		RTE_ETH_SPEED_NUM_200G, RTE_ETH_SPEED_NUM_400G
+	};
+	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
+	struct rte_eth_dev_data *data = eth_dev->data;
+	struct rte_eth_conf *conf = &data->dev_conf;
+	uint32_t link_speeds = conf->link_speeds;
+	struct roc_nix_link_info link_info = {0};
+	struct roc_nix *nix = &dev->nix;
+	uint32_t speed = link_speeds;
+	bool fixed;
+
+	plt_info("User passed link configuration: %x", link_speeds);
+
+	if (!roc_nix_is_pf(nix) || link_speeds == RTE_ETH_LINK_SPEED_AUTONEG)
+		return 0;
+
+	fixed = link_speeds & RTE_ETH_LINK_SPEED_FIXED ? true : false;
+	if (fixed) {
+		if (rte_popcount32(link_speeds) == 1) {
+			plt_err("Desired speed is not specified in FIXED mode");
+			return -EINVAL;
+		}
+
+		if (rte_popcount32(link_speeds) > 2) {
+			plt_err("Multiple speeds can't be configured in FIXED mode");
+			return -EINVAL;
+		}
+
+		link_info.autoneg = 0;
+	} else {
+		link_info.autoneg = 1;
+	}
+
+	speed >>= 1;
+	link_info.speed = speed_map[rte_bsf32(speed) + 1];
+	link_info.speed_bitmask = link_speeds & ~RTE_ETH_LINK_SPEED_FIXED;
+	link_info.full_duplex = ((link_speeds & RTE_ETH_LINK_SPEED_10M_HD) ||
+				 (link_speeds & RTE_ETH_LINK_SPEED_100M_HD)) ?
+				  ROC_NIX_LINK_DUPLEX_HALF :
+				  ROC_NIX_LINK_DUPLEX_FULL;
+	link_info.advertising = nix_link_advertising_get(dev, &link_info);
+	if (link_info.advertising == 0) {
+		plt_err("advertising bitmap is not set");
+		return -EINVAL;
+	}
+
+	plt_info("Following link settings are sent to firmware:");
+	plt_info("Advertised modes: %" PRIX64, link_info.advertising);
+	plt_info("speed: %u", link_info.speed);
+	plt_info("duplex: %s", link_info.full_duplex == ROC_NIX_LINK_DUPLEX_HALF ?
+						"half-duplex" : "full-duplex");
+	plt_info("autoneg: %s", link_info.autoneg ? "enabled" : "disabled");
+	return roc_nix_mac_link_info_set(nix, &link_info);
+}
-- 
2.43.0

