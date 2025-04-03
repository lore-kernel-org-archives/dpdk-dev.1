Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB23C3601B
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Apr 2025 07:08:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 634E240A6F;
	Thu,  3 Apr 2025 09:08:49 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 444A840687
 for <dev@dpdk.org>; Thu,  3 Apr 2025 09:08:48 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5333CBMK006653
 for <dev@dpdk.org>; Thu, 3 Apr 2025 00:08:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=o
 nwJxJvEl3B5B9hVN8m9z746Df/9q9DffM09taTatek=; b=L5jHe5fAzeY9IK5DL
 3CKXfkHJ3lhyuaqV549qAUYT6l1EwcGMX3PCY5Z/YD49ulVV4rPO/ocDgIphy7YS
 W1cvtoKHfRl7PIwGL6/A11G94Qpxemw14bhxMfHxs3xPx4NRV7vddOLlNkIlbizk
 zzs8Pb48KCSoemAe4zRjoeKKqdCLWv5E0OErcSDnCEhe2zcFQELebR36kyt5K2uJ
 9uosWY2P2ntIXEpJt6ZIWmwInynXDFEx8m3hAIb6kzmAUIf8ei58sYKnCzI2A//M
 wzxBtPFH4ZBgAs+tBboVu6kRgeextJt5CejW6vcwq0djCl6Auq15jDYjF/dcfHq2
 QAu7g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 45rvwfb9rt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 03 Apr 2025 00:08:46 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 3 Apr 2025 00:08:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 3 Apr 2025 00:08:45 -0700
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id 26B663F70DA;
 Thu,  3 Apr 2025 00:08:42 -0700 (PDT)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>
Subject: [RFC PATCH 2/4] common/cnxk: support to get speed cap from fwdata
Date: Thu, 3 Apr 2025 12:38:35 +0530
Message-ID: <20250403070837.926292-2-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250403070837.926292-1-ndabilpuram@marvell.com>
References: <20250403070837.926292-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: tLGnaBcV_1hQ0LSBNH2kBcB2TaQq34Ay
X-Authority-Analysis: v=2.4 cv=V6p90fni c=1 sm=1 tr=0 ts=67ee33fe cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=1VfN0jKDGsNesanTltIA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: tLGnaBcV_1hQ0LSBNH2kBcB2TaQq34Ay
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

Speed capability currently is updating as
all speeds capable. Get it from CGX fw data
supported link modes instead.

Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
---
 drivers/common/cnxk/hw/nix.h       | 54 ++++++++++++++++++++++
 drivers/common/cnxk/roc_mbox.h     | 24 +++++++---
 drivers/common/cnxk/roc_nix.h      |  8 +++-
 drivers/common/cnxk/roc_nix_mac.c  | 28 ++++++++++++
 drivers/common/cnxk/roc_nix_priv.h |  2 +
 drivers/common/cnxk/version.map    |  1 +
 drivers/net/cnxk/cnxk_ethdev.c     | 72 ++++++++++++++++++++++++++++--
 7 files changed, 180 insertions(+), 9 deletions(-)

diff --git a/drivers/common/cnxk/hw/nix.h b/drivers/common/cnxk/hw/nix.h
index d16fa3b3ec..de989153ff 100644
--- a/drivers/common/cnxk/hw/nix.h
+++ b/drivers/common/cnxk/hw/nix.h
@@ -2681,4 +2681,58 @@ struct nix_lso_format {
  */
 #define NIX_CHAN_CPT_X2P_MASK (0x7ffull)
 
+/* CGX modes defined by firmware */
+enum cgx_mode {
+	CGX_MODE_SGMII,
+	CGX_MODE_1000_BASEX,
+	CGX_MODE_QSGMII,
+	CGX_MODE_10G_C2C,
+	CGX_MODE_10G_C2M,
+	CGX_MODE_10G_KR,
+	CGX_MODE_20G_C2C,
+	CGX_MODE_25G_C2C,
+	CGX_MODE_25G_C2M,
+	CGX_MODE_25G_2_C2C,
+	CGX_MODE_25G_CR,
+	CGX_MODE_25G_KR,
+	CGX_MODE_40G_C2C,
+	CGX_MODE_40G_C2M,
+	CGX_MODE_40G_CR4,
+	CGX_MODE_40G_KR4,
+	CGX_MODE_40GAUI_C2C,
+	CGX_MODE_50G_C2C,
+	CGX_MODE_50G_C2M,
+	CGX_MODE_50G_4_C2C,
+	CGX_MODE_50G_CR,
+	CGX_MODE_50G_KR,
+	CGX_MODE_80GAUI_C2C,
+	CGX_MODE_100G_C2C,
+	CGX_MODE_100G_C2M,
+	CGX_MODE_100G_CR4,
+	CGX_MODE_100G_KR4,
+	CGX_MODE_LAUI_2_C2C_BIT,
+	CGX_MODE_LAUI_2_C2M_BIT,
+	CGX_MODE_50GBASE_CR2_C_BIT,
+	CGX_MODE_50GBASE_KR2_C_BIT, /* = 30 */
+	CGX_MODE_100GAUI_2_C2C_BIT,
+	CGX_MODE_100GAUI_2_C2M_BIT,
+	CGX_MODE_100GBASE_CR2_BIT,
+	CGX_MODE_100GBASE_KR2_BIT,
+	CGX_MODE_SFI_1G_BIT,
+	CGX_MODE_25GBASE_CR_C_BIT,
+	CGX_MODE_25GBASE_KR_C_BIT,
+	ETH_MODE_SGMII_10M_BIT,
+	ETH_MODE_SGMII_100M_BIT,      /* = 39 */
+	ETH_MODE_2500_BASEX_BIT = 42, /* Mode group 1 */
+	ETH_MODE_5000_BASEX_BIT,
+	ETH_MODE_O_USGMII_BIT,
+	ETH_MODE_Q_USGMII_BIT,
+	ETH_MODE_2_5G_USXGMII_BIT,
+	ETH_MODE_5G_USXGMII_BIT,
+	ETH_MODE_10G_SXGMII_BIT,
+	ETH_MODE_10G_DXGMII_BIT,
+	ETH_MODE_10G_QXGMII_BIT,
+	CGX_MODE_MAX /* = 51 */
+};
+
 #endif /* __NIX_HW_H__ */
diff --git a/drivers/common/cnxk/roc_mbox.h b/drivers/common/cnxk/roc_mbox.h
index a82d120d1d..9038ca8fcf 100644
--- a/drivers/common/cnxk/roc_mbox.h
+++ b/drivers/common/cnxk/roc_mbox.h
@@ -755,8 +755,17 @@ enum fec_type {
 };
 
 struct phy_s {
-	uint64_t __io can_change_mod_type : 1;
-	uint64_t __io mod_type : 1;
+	struct {
+		uint64_t __io can_change_mod_type:1;
+		uint64_t __io mod_type:1;
+		uint64_t __io has_fec_stats:1;
+	} misc;
+	struct fec_stats_s {
+		uint32_t __io rsfec_corr_cws;
+		uint32_t __io rsfec_uncorr_cws;
+		uint32_t __io brfec_corr_blks;
+		uint32_t __io brfec_uncorr_blks;
+	} fec_stats;
 };
 
 struct cgx_lmac_fwdata_s {
@@ -764,13 +773,18 @@ struct cgx_lmac_fwdata_s {
 	uint64_t __io supported_fec;
 	uint64_t __io supported_an;
 	uint64_t __io supported_link_modes;
-	/* Only applicable if AN is supported */
+	/* only applicable if AN is supported */
 	uint64_t __io advertised_fec;
-	uint64_t __io advertised_link_modes;
+	uint64_t __io advertised_link_modes_own : 1; /* CGX_CMD_OWN */
+	uint64_t __io advertised_link_modes : 63;
 	/* Only applicable if SFP/QSFP slot is present */
 	struct sfp_eeprom_s sfp_eeprom;
 	struct phy_s phy;
-#define LMAC_FWDATA_RESERVED_MEM 1023
+	uint32_t __io lmac_type;
+	uint32_t __io portm_idx;
+	uint64_t __io mgmt_port : 1;
+	uint64_t __io advertised_an : 1;
+#define LMAC_FWDATA_RESERVED_MEM 1019
 	uint64_t __io reserved[LMAC_FWDATA_RESERVED_MEM];
 };
 
diff --git a/drivers/common/cnxk/roc_nix.h b/drivers/common/cnxk/roc_nix.h
index a1bd14ffc4..c438a4447c 100644
--- a/drivers/common/cnxk/roc_nix.h
+++ b/drivers/common/cnxk/roc_nix.h
@@ -413,6 +413,11 @@ struct roc_nix_link_info {
 	uint64_t port : 8;
 };
 
+struct roc_nix_mac_fwdata {
+	uint64_t advertised_link_modes;
+	uint64_t supported_link_modes;
+};
+
 /** Maximum name length for extended statistics counters */
 #define ROC_NIX_XSTATS_NAME_SIZE 64
 
@@ -493,7 +498,7 @@ struct roc_nix {
 	bool reass_ena;
 	TAILQ_ENTRY(roc_nix) next;
 
-#define ROC_NIX_MEM_SZ (6 * 1112)
+#define ROC_NIX_MEM_SZ (6 * 1200)
 	uint8_t reserved[ROC_NIX_MEM_SZ] __plt_cache_aligned;
 } __plt_cache_aligned;
 
@@ -856,6 +861,7 @@ void __roc_api roc_nix_mac_link_info_get_cb_unregister(struct roc_nix *roc_nix);
 int __roc_api roc_nix_q_err_cb_register(struct roc_nix *roc_nix, q_err_get_t sq_err_handle);
 void __roc_api roc_nix_q_err_cb_unregister(struct roc_nix *roc_nix);
 int __roc_api roc_nix_mac_stats_reset(struct roc_nix *roc_nix);
+int __roc_api roc_nix_mac_fwdata_get(struct roc_nix *roc_nix, struct roc_nix_mac_fwdata *fwdata);
 
 /* Ops */
 int __roc_api roc_nix_switch_hdr_set(struct roc_nix *roc_nix,
diff --git a/drivers/common/cnxk/roc_nix_mac.c b/drivers/common/cnxk/roc_nix_mac.c
index 54db1adf17..b99f93818a 100644
--- a/drivers/common/cnxk/roc_nix_mac.c
+++ b/drivers/common/cnxk/roc_nix_mac.c
@@ -412,3 +412,31 @@ roc_nix_mac_link_info_get_cb_unregister(struct roc_nix *roc_nix)
 
 	dev->ops->link_status_get = NULL;
 }
+
+int
+roc_nix_mac_fwdata_get(struct roc_nix *roc_nix, struct roc_nix_mac_fwdata *data)
+{
+	struct nix *nix = roc_nix_to_nix_priv(roc_nix);
+	struct cgx_fw_data *fw_data;
+	struct dev *dev = &nix->dev;
+	struct mbox *mbox;
+	int rc;
+
+	if (roc_nix_is_sdp(roc_nix))
+		return 0;
+
+	mbox = mbox_get(dev->mbox);
+
+	mbox_alloc_msg_cgx_get_aux_link_info(mbox);
+	rc = mbox_process_msg(mbox, (void *)&fw_data);
+	if (rc)
+		goto exit;
+
+	nix->supported_link_modes = fw_data->fwdata.supported_link_modes;
+	nix->advertised_link_modes = fw_data->fwdata.advertised_link_modes;
+	data->supported_link_modes = nix->supported_link_modes;
+	data->advertised_link_modes = nix->advertised_link_modes;
+exit:
+	mbox_put(mbox);
+	return rc;
+}
diff --git a/drivers/common/cnxk/roc_nix_priv.h b/drivers/common/cnxk/roc_nix_priv.h
index 09a55e43ce..31e37fc356 100644
--- a/drivers/common/cnxk/roc_nix_priv.h
+++ b/drivers/common/cnxk/roc_nix_priv.h
@@ -130,6 +130,8 @@ struct nix {
 	uint16_t bpid[NIX_MAX_CHAN];
 	struct nix_qint *qints_mem;
 	struct nix_qint *cints_mem;
+	uint64_t supported_link_modes;
+	uint64_t advertised_link_modes;
 	uint8_t configured_qints;
 	uint8_t configured_cints;
 	uint8_t exact_match_ena;
diff --git a/drivers/common/cnxk/version.map b/drivers/common/cnxk/version.map
index cdbfc1d39a..93cfaa96da 100644
--- a/drivers/common/cnxk/version.map
+++ b/drivers/common/cnxk/version.map
@@ -307,6 +307,7 @@ INTERNAL {
 	roc_nix_mac_addr_add;
 	roc_nix_mac_addr_del;
 	roc_nix_mac_addr_set;
+	roc_nix_mac_fwdata_get;
 	roc_nix_mac_link_cb_register;
 	roc_nix_mac_link_cb_unregister;
 	roc_nix_mac_link_info_get_cb_register;
diff --git a/drivers/net/cnxk/cnxk_ethdev.c b/drivers/net/cnxk/cnxk_ethdev.c
index 289ae96afa..4dba4968d5 100644
--- a/drivers/net/cnxk/cnxk_ethdev.c
+++ b/drivers/net/cnxk/cnxk_ethdev.c
@@ -6,6 +6,60 @@
 #include <rte_eventdev.h>
 #include <rte_pmd_cnxk.h>
 
+const uint32_t cnxk_mac_modes[CGX_MODE_MAX + 1] = {
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
+	[ETH_MODE_SGMII_10M_BIT] = RTE_ETH_LINK_SPEED_10M,
+	[ETH_MODE_SGMII_100M_BIT] = RTE_ETH_LINK_SPEED_100M,
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
@@ -40,14 +94,26 @@ nix_get_tx_offload_capa(struct cnxk_eth_dev *dev)
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
+		/* Translate advertised modes to speed_capa */
+		for (mode = 0; mode < CGX_MODE_MAX; mode++) {
+			if (fwdata.supported_link_modes & BIT_ULL(mode))
+				speed_capa |= cnxk_mac_modes[mode];
+		}
 	}
 
 	return speed_capa;
-- 
2.34.1

