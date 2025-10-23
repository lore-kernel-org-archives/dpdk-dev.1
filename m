Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB50CCD1BE
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 11:05:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 238BB402EB;
	Thu, 23 Oct 2025 13:05:20 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 14C23402E1
 for <dev@dpdk.org>; Thu, 23 Oct 2025 13:05:18 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MLSuwa023522
 for <dev@dpdk.org>; Thu, 23 Oct 2025 04:05:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=R
 OPI1MJHUuW2TFI0S9DVH/qSzDv717z2nzYh0HUUKqY=; b=K0UcFkIdDRAmRg+3S
 osFv8CmEEAUhiz1mCY5ybk7GPt5/N05P6p+ft/1r/1+xSkC49h3UxQmo4l7NcGEA
 QKmHVS2Co/aW1y4UMgDS9UpFsUhJXMT/dVIrWlN9MNWVkIMMQuzGfiqAwLrbKvxQ
 rV1Bc4r+ZWLjSlMrsCdibli4mDBrM3vXbMfvtXBvAKcdGopHZiw3/uiI2UrCZMpr
 l1GM1qttFfFq3l1XMTeVY5DdtGJzVkYZ7nyrm75BACLjpRNfkOXcudfrcD7uLwy3
 4x8cB5kA0GI/bGM0s/tWJuBhpoCgnG18/6eXk+OgWzUnN1xCiP4Dno680QqbIs9n
 nKLng==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49y77g1m4n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 23 Oct 2025 04:05:18 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 23 Oct 2025 04:05:16 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 23 Oct 2025 04:05:16 -0700
Received: from cavium-3070-BM23.. (unknown [10.28.34.25])
 by maili.marvell.com (Postfix) with ESMTP id 3308C3F70A9;
 Thu, 23 Oct 2025 04:05:14 -0700 (PDT)
From: <skori@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>
Subject: [PATCH v6 3/6] net/cnxk: get speed capability from firmware
Date: Thu, 23 Oct 2025 16:32:03 +0530
Message-ID: <20251023110332.6231-3-skori@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023110332.6231-1-skori@marvell.com>
References: <20251023075450.4145667-6-skori@marvell.com>
 <20251023110332.6231-1-skori@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE3OSBTYWx0ZWRfX+syZp8afHNZY
 oF4ZeG94NV3r3683s/OTtQ/sV6ZTJSU2yE/ypWw7FPJ7v+thOKDbWVRy774elLADKKIpzyWvN+3
 1t7NGsHEiu9Jx0VumNdTQghS6UvOM92YQeQE56DdFHBPU2Fki9D056DTfVMEkhVnO/n2+d1Ls8I
 NGLguImxD5tuDuPUPdJTggCtJ7TopiGRzF9iLbJTHj9yigAuCfJxloAett8X+dmbHq3nOBiGa1z
 wlMJ4LqOqqLGU+Kh1+9sGlCCFEo6qcFAVUlCAE/EJgWufuQEaHaEXdhGQ4GdfUwFbW7BIxcTk0H
 r0dxEY/rRPkdC5BrijJ/wN3hlYVLkrEHKi24BUZ4AnsfzNro/vJD+oGoBvEWpectJNH7NP/7kFr
 nePR5WKFGmD1zBZtNP/i+SjWui0Ylw==
X-Proofpoint-GUID: YYIMab-uIgUR1ux5NkfybXVJtYIaKQA0
X-Proofpoint-ORIG-GUID: YYIMab-uIgUR1ux5NkfybXVJtYIaKQA0
X-Authority-Analysis: v=2.4 cv=BIq+bVQG c=1 sm=1 tr=0 ts=68fa0bee cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=3CMRPe03__idA2T9rPcA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
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

Currently speed capability is hardcoded to support defined
modes and speeds but MAC can support others modes and speed
too. This information is populated by firmware.

Hence fetching firmware data to provide actual supported
modes and speeds by the port.

Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
---
v5..v6:
 - Rebased on ToT

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

