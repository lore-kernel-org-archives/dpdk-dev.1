Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC777CCD1BC
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 07:55:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4BB9B402E3;
	Thu, 23 Oct 2025 09:55:04 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 79BA2402E0
 for <dev@dpdk.org>; Thu, 23 Oct 2025 09:55:02 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N3d51Z022686
 for <dev@dpdk.org>; Thu, 23 Oct 2025 00:55:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=u
 QSL4CKJ0WOd/6vjKsNF3v1kFdexCOjLZ9RBgaJkDXg=; b=PGaFcfq7jj8kA0yoT
 yd7NHksx2VKxbjJv02wwNDz+YhZP+QPRmesec3CYB22Q68+jlSSq2i2NG7lYX5Bz
 7g1XadV1ExJE8slJSuSeolPMbenJgzodomA39qybh1J/rs8RSrczbh6w2820Ml1k
 Zi9wZ4lVPsX8tI7000f5tLYGTPWBOlh3xhnstNODLh6jW7Luu/Wwjsepy70AdtV5
 Eo2Ch0+gwNjLzxydC41h9u8Bg5+oyyMXoQQ0ph8SSkDycjBU41ikiMcJhxBtatwI
 ubsuuSDV7SbccLAezzuwc06Ap2IC/BhXwEYLmTejsZ0k1tRNtY1m2PErgHd9IQ3G
 E6few==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49ycmr0euv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 23 Oct 2025 00:55:01 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 23 Oct 2025 00:55:10 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 23 Oct 2025 00:55:10 -0700
Received: from cavium-3070-BM23.. (unknown [10.28.34.25])
 by maili.marvell.com (Postfix) with ESMTP id C69603F7090;
 Thu, 23 Oct 2025 00:54:58 -0700 (PDT)
From: <skori@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>
Subject: [PATCH v5 3/6] net/cnxk: get speed capability from firmware
Date: Thu, 23 Oct 2025 13:23:27 +0530
Message-ID: <20251023075450.4145667-3-skori@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023075450.4145667-1-skori@marvell.com>
References: <20251023053728.4091023-6-skori@marvell.com>
 <20251023075450.4145667-1-skori@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: qpa1rwLfZKnMMR0wquBqzMZuOTefUtvq
X-Proofpoint-GUID: qpa1rwLfZKnMMR0wquBqzMZuOTefUtvq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDAzMCBTYWx0ZWRfX02koIskzpN6z
 uN4KSfd+nh4G8M2kADuiwEdf2H3AK+2nmKe30FCV0e/Cp/ZMLG3m9x+noiedjJTxA/u68ssvTcW
 k20DGa2Pp9Z6qjkFwzSQqCg8vVatr6vVdLJ6esFRqrsETIIm7jc61PsFadEhji/Egl0seKfGid2
 M3Fm1TMp+DaBui08eofGCXIdRfLSxx0kuT3VRZ78OshAcud8zKLvwhcnMBIAOVzo8/5ZxPsKp0s
 fon1mhJ1gLbx+fdvmdFWm6xD96ZAw2exNYCezFZEqFjMyj8rmsvLL0SoWR8BtITTbVistM2WlDr
 RNhSxEJIuzolQMMlq6PpWsnuRkC3o+watSKm+c+MwTt0hN5MPD9u8W4sicxE757eIrNQK6bNL31
 RUAUjVi/TIy20EIajjF5BDtqNH88Ag==
X-Authority-Analysis: v=2.4 cv=CtSys34D c=1 sm=1 tr=0 ts=68f9df55 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
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

