Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA10C87FCF
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 09:31:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B15A40DD5;
	Wed, 13 Aug 2025 11:31:18 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id B69EA40DD7
 for <dev@dpdk.org>; Wed, 13 Aug 2025 11:31:16 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D7aHV1007205
 for <dev@dpdk.org>; Wed, 13 Aug 2025 02:31:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=O
 M/pqRxMJeD+4pUV070NmDLhIMc1LXTQy+Cz7am1ArA=; b=lDExUYDJ5yyYR8vUF
 uHsBvFkamSJu+rP0s3IW4WeiZW6i+zMFxm9L33kkI72s7+lTp4CzTtcpnX3UfLKc
 7M3TT4bEd8nJGEZyehCR3CXoL32416QPNj0eslf3w6PZDuGgrH13N4gpR0EAgP0W
 tlo/YkVQHqgGnV6jtELEXA2gBZEQAlJOuJW/5s5ciwpumkco/tumb28l+DY0Bo/L
 PHNpC17pZYcOQGn14lBSMjjdUI/Q2jFGAvz/avqTS9Rcb6kMMzBta0XO/yfa0BRH
 DwBIkvMl4jgkJrpGfz9gs1kdFXo9fEHG2BpfqhEMMRo+fvM/Z3RBKNO+zS4uJfzc
 Bapqw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 48gpfar6q1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 13 Aug 2025 02:31:15 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 13 Aug 2025 02:31:18 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 13 Aug 2025 02:31:18 -0700
Received: from cavium-3070-BM23.. (unknown [10.28.34.25])
 by maili.marvell.com (Postfix) with ESMTP id 67F165B6924;
 Wed, 13 Aug 2025 02:31:12 -0700 (PDT)
From: <skori@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>
Subject: [PATCH v2 4/6] net/cnxk: support link mode configuration
Date: Wed, 13 Aug 2025 15:00:55 +0530
Message-ID: <20250813093101.1492434-4-skori@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250813093101.1492434-1-skori@marvell.com>
References: <20250605114231.3036050-6-skori@marvell.com>
 <20250813093101.1492434-1-skori@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: tKUNY8SmjLp4R3cK3zAbODlnekpCAAQ9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDA5MiBTYWx0ZWRfX+9sdoirwqUas
 pSXrR4Ru34AEI6bc2PMYjKYoQQwMHyd3pF1ep4d6hzc61aDpcmxz7AOMvlJz8CfPFU7nw/BuOSD
 2UpwT+UICC2hq4w+8L0bfd/TIHSIp2ey4QOG1lEtSx6DwrQoKzUVQez/7gbmOgEOltx2YmFOkQs
 xIa6vZGH0jYnhjil2PdRzTO3rPfKBt/80lMo7m/4Gml1X9jiC4Ab6WlBa4BWAU2/NY+CVLJIx94
 h0sZyMgZ7D5aSnfHJiNQkWKihjRIo3lUll376X8skLea0SKEpc7xeQ5iBJCdz6fh1jsSxtyimyA
 +BL6pC1f2HzIWnn0wEpR37V/ah2nz5KUcUn5wYes6GJSStQqbd6cW3AUBmt9uguY5ymW8z1JJIZ
 OZ4ufpjrC6tDtpVt01qXB5nqP1Bxo3UAs/Uo+Y3v3smsTTX9tTF8FfD8Xa8WZp7cnAgSe2uh
X-Proofpoint-ORIG-GUID: tKUNY8SmjLp4R3cK3zAbODlnekpCAAQ9
X-Authority-Analysis: v=2.4 cv=O7M5vA9W c=1 sm=1 tr=0 ts=689c5b63 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=2OwXVqhp2XgA:10 a=M5GUcnROAAAA:8 a=83_Lh2SUWi18qvg5i8YA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
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
index 9fb3367422..5a8b43c037 100644
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
index 903b44de2c..0bc56fbb8c 100644
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
+	plt_info("Advertised modes: %lx", link_info.advertising);
+	plt_info("speed: %u", link_info.speed);
+	plt_info("duplex: %s", link_info.full_duplex == ROC_NIX_LINK_DUPLEX_HALF ?
+						"half-duplex" : "full-duplex");
+	plt_info("autoneg: %s", link_info.autoneg ? "enabled" : "disabled");
+	return roc_nix_mac_link_info_set(nix, &link_info);
+}
-- 
2.43.0

