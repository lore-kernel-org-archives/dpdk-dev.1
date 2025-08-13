Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A26C87FCF
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 09:31:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EBC3D40DCE;
	Wed, 13 Aug 2025 11:31:15 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 0FFC440DCD
 for <dev@dpdk.org>; Wed, 13 Aug 2025 11:31:13 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CNUF9W014101
 for <dev@dpdk.org>; Wed, 13 Aug 2025 02:31:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=u
 QSL4CKJ0WOd/6vjKsNF3v1kFdexCOjLZ9RBgaJkDXg=; b=OBj+b/fJIPjtIbCY2
 U/Du+O+mJMDcLK6Wh6CPxZw+yfBH6h5hwHcAxbIxHlk+jSuFmm9x0pfF7XGY4eGa
 l5Nyih/H8kZvQw9o9YMBge1aG6fcjBbouagrtlSPFcGQbGZW9oJuXIDhQEV7Uhk0
 Qy3PgeCx0l9pptKIwV+TV1IpCP3wOxaMSN/QPSInwgZDftv4hfVGCjEKz2LZJGIH
 vd5dhbNcYlkR8jb8fQDblXyPw+kLSZDLgKuOQyo9NsABHSL4mVtO+i5WAurNol6X
 V3PyfZJC5nBvCz20n/i97sQYFTUjhuymJIvMgZldW8aG2i0rVo2Fh+ybVXjjY6TV
 yT8Xg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 48gfb1ry51-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 13 Aug 2025 02:31:13 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 13 Aug 2025 02:31:16 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 13 Aug 2025 02:31:15 -0700
Received: from cavium-3070-BM23.. (unknown [10.28.34.25])
 by maili.marvell.com (Postfix) with ESMTP id D23385B6924;
 Wed, 13 Aug 2025 02:31:09 -0700 (PDT)
From: <skori@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>
Subject: [PATCH v2 3/6] net/cnxk: get speed capability from firmware
Date: Wed, 13 Aug 2025 15:00:54 +0530
Message-ID: <20250813093101.1492434-3-skori@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250813093101.1492434-1-skori@marvell.com>
References: <20250605114231.3036050-6-skori@marvell.com>
 <20250813093101.1492434-1-skori@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 3vburg510NapcfTOj8dK6eS2DulTr-1k
X-Authority-Analysis: v=2.4 cv=K7giHzWI c=1 sm=1 tr=0 ts=689c5b61 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=2OwXVqhp2XgA:10 a=M5GUcnROAAAA:8 a=3CMRPe03__idA2T9rPcA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 3vburg510NapcfTOj8dK6eS2DulTr-1k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDA5MiBTYWx0ZWRfX3OzXRT6jGZ9X
 mv4prBQp0RNHUKVa+Sp2UMDCNgqZa5vXGANoihp/0GT8FRbDoBr7mcDzTK+oo4I4vkZXl6qjujP
 QmSIQLh8+ljgiISaf5kkhaPKefBNHfGw/hXegavnA5SlZf36qJSNQU/R0bK0BRwz19wbjB/oBQ7
 FaOXwPHT5ENHyKqJ99Q6IWXZpEXf7/AqKl604is8Nlb5R53QXP1FM3S01yMnsyLR1dN6aR2hSZK
 ZFU86F9BQisJQO+bxTT0uiLdS5HsShVJ8mYIBwXkEodrE78ZjV+hz1Zo/ixnz9j6mNEoESjVywU
 2DweOzFkGlaFaBNfzzXgzJXUaCsOCEj0+KoppCU52y3v4KVgim0Kp7M+/SjrWkgd5k4Odo9RxFn
 jmIqHcGtGOPwhwSPrywCLydJ0uV+tzLW8G1vD2ZgWg5NtnqMosxNuauzjbUlFs6SJ8g82pv2
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

Currently speed capability is hardcoded to support defined
modes and speeds but MAC can support others modes and speed
too. This information is populated by firmware.

Hence fetching firmware data to provide actual supported
modes and speeds by the port.

Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
---
 drivers/net/cnxk/cnxk_ethdev.c | 75 ++++++++++++++++++++++++++++++++--
 1 file changed, 72 insertions(+), 3 deletions(-)

diff --git a/drivers/net/cnxk/cnxk_ethdev.c b/drivers/net/cnxk/cnxk_ethdev.c
index 6c723c9cec..14e9707fcb 100644
--- a/drivers/net/cnxk/cnxk_ethdev.c
+++ b/drivers/net/cnxk/cnxk_ethdev.c
@@ -7,6 +7,60 @@
 #include <rte_eventdev.h>
 #include <rte_pmd_cnxk.h>
 
+static const uint32_t cnxk_mac_modes[CGX_MODE_MAX + 1] = {
+	[CGX_MODE_SGMII] = RTE_ETH_LINK_SPEED_1G,
+	[CGX_MODE_1000_BASEX] = RTE_ETH_LINK_SPEED_1G,
+	[CGX_MODE_QSGMII] = RTE_ETH_LINK_SPEED_1G,
+	[CGX_MODE_10G_C2C] = RTE_ETH_LINK_SPEED_10G,
+	[CGX_MODE_10G_C2M] = RTE_ETH_LINK_SPEED_10G,
+	[CGX_MODE_10G_KR] = RTE_ETH_LINK_SPEED_10G,
+	[CGX_MODE_20G_C2C] = RTE_ETH_LINK_SPEED_20G,
+	[CGX_MODE_25G_C2C] = RTE_ETH_LINK_SPEED_25G,
+	[CGX_MODE_25G_C2M] = RTE_ETH_LINK_SPEED_25G,
+	[CGX_MODE_25G_2_C2C] = RTE_ETH_LINK_SPEED_25G,
+	[CGX_MODE_25G_CR] = RTE_ETH_LINK_SPEED_25G,
+	[CGX_MODE_25G_KR] = RTE_ETH_LINK_SPEED_25G,
+	[CGX_MODE_40G_C2C] = RTE_ETH_LINK_SPEED_40G,
+	[CGX_MODE_40G_C2M] = RTE_ETH_LINK_SPEED_40G,
+	[CGX_MODE_40G_CR4] = RTE_ETH_LINK_SPEED_40G,
+	[CGX_MODE_40G_KR4] = RTE_ETH_LINK_SPEED_40G,
+	[CGX_MODE_40GAUI_C2C] = RTE_ETH_LINK_SPEED_40G,
+	[CGX_MODE_50G_C2C] = RTE_ETH_LINK_SPEED_50G,
+	[CGX_MODE_50G_C2M] = RTE_ETH_LINK_SPEED_50G,
+	[CGX_MODE_50G_4_C2C] = RTE_ETH_LINK_SPEED_50G,
+	[CGX_MODE_50G_CR] = RTE_ETH_LINK_SPEED_50G,
+	[CGX_MODE_50G_KR] = RTE_ETH_LINK_SPEED_50G,
+	[CGX_MODE_80GAUI_C2C] = 0, /* No define for 80G */
+	[CGX_MODE_100G_C2C] = RTE_ETH_LINK_SPEED_100G,
+	[CGX_MODE_100G_C2M] = RTE_ETH_LINK_SPEED_100G,
+	[CGX_MODE_100G_CR4] = RTE_ETH_LINK_SPEED_100G,
+	[CGX_MODE_100G_KR4] = RTE_ETH_LINK_SPEED_100G,
+	[CGX_MODE_LAUI_2_C2C_BIT] = RTE_ETH_LINK_SPEED_50G,
+	[CGX_MODE_LAUI_2_C2M_BIT] = RTE_ETH_LINK_SPEED_50G,
+	[CGX_MODE_50GBASE_CR2_C_BIT] = RTE_ETH_LINK_SPEED_50G,
+	[CGX_MODE_50GBASE_KR2_C_BIT] = RTE_ETH_LINK_SPEED_50G,
+	[CGX_MODE_100GAUI_2_C2C_BIT] = RTE_ETH_LINK_SPEED_100G,
+	[CGX_MODE_100GAUI_2_C2M_BIT] = RTE_ETH_LINK_SPEED_100G,
+	[CGX_MODE_100GBASE_CR2_BIT] = RTE_ETH_LINK_SPEED_100G,
+	[CGX_MODE_100GBASE_KR2_BIT] = RTE_ETH_LINK_SPEED_100G,
+	[CGX_MODE_SFI_1G_BIT] = RTE_ETH_LINK_SPEED_1G,
+	[CGX_MODE_25GBASE_CR_C_BIT] = RTE_ETH_LINK_SPEED_25G,
+	[CGX_MODE_25GBASE_KR_C_BIT] = RTE_ETH_LINK_SPEED_25G,
+	[ETH_MODE_SGMII_10M_BIT] = RTE_ETH_LINK_SPEED_10M | RTE_ETH_LINK_SPEED_10M_HD,
+	[ETH_MODE_SGMII_100M_BIT] = RTE_ETH_LINK_SPEED_100M | RTE_ETH_LINK_SPEED_100M_HD,
+	[40] = 0,
+	[41] = 0,
+	[ETH_MODE_2500_BASEX_BIT] = RTE_ETH_LINK_SPEED_2_5G,
+	[ETH_MODE_5000_BASEX_BIT] = RTE_ETH_LINK_SPEED_5G,
+	[ETH_MODE_O_USGMII_BIT] = RTE_ETH_LINK_SPEED_100M,
+	[ETH_MODE_Q_USGMII_BIT] = RTE_ETH_LINK_SPEED_1G,
+	[ETH_MODE_2_5G_USXGMII_BIT] = RTE_ETH_LINK_SPEED_2_5G,
+	[ETH_MODE_5G_USXGMII_BIT] = RTE_ETH_LINK_SPEED_5G,
+	[ETH_MODE_10G_SXGMII_BIT] = RTE_ETH_LINK_SPEED_10G,
+	[ETH_MODE_10G_DXGMII_BIT] = RTE_ETH_LINK_SPEED_10G,
+	[ETH_MODE_10G_QXGMII_BIT] = RTE_ETH_LINK_SPEED_10G,
+};
+
 cnxk_ethdev_rx_offload_cb_t cnxk_ethdev_rx_offload_cb;
 
 #define CNXK_NIX_CQ_INL_CLAMP_MAX (64UL * 1024UL)
@@ -42,14 +96,29 @@ nix_get_tx_offload_capa(struct cnxk_eth_dev *dev)
 static inline uint32_t
 nix_get_speed_capa(struct cnxk_eth_dev *dev)
 {
+	struct roc_nix_mac_fwdata fwdata;
 	uint32_t speed_capa;
+	uint8_t mode;
+	int rc;
 
 	/* Auto negotiation disabled */
 	speed_capa = RTE_ETH_LINK_SPEED_FIXED;
 	if (!roc_nix_is_vf_or_sdp(&dev->nix) && !roc_nix_is_lbk(&dev->nix)) {
-		speed_capa |= RTE_ETH_LINK_SPEED_1G | RTE_ETH_LINK_SPEED_10G |
-			      RTE_ETH_LINK_SPEED_25G | RTE_ETH_LINK_SPEED_40G |
-			      RTE_ETH_LINK_SPEED_50G | RTE_ETH_LINK_SPEED_100G;
+		memset(&fwdata, 0, sizeof(fwdata));
+		rc = roc_nix_mac_fwdata_get(&dev->nix, &fwdata);
+		if (rc) {
+			plt_err("Failed to get MAC firmware data");
+			return 0;
+		}
+
+		if (fwdata.supported_an)
+			speed_capa = 0;
+
+		/* Translate advertised modes to speed_capa */
+		for (mode = 0; mode < CGX_MODE_MAX; mode++) {
+			if (fwdata.supported_link_modes & BIT_ULL(mode))
+				speed_capa |= cnxk_mac_modes[mode];
+		}
 	}
 
 	return speed_capa;
-- 
2.43.0

