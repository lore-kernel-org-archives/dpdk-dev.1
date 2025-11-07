Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749F5CCFA05
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 07:03:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6463C40280;
	Fri,  7 Nov 2025 08:03:38 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id AA4FA40264
 for <dev@dpdk.org>; Fri,  7 Nov 2025 08:03:36 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A75XOqX1493227 for <dev@dpdk.org>; Thu, 6 Nov 2025 23:03:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=C
 pWYNr0HY2YRZOdbEzdZHYxO/Bbb2/y5KuGP984JyR8=; b=GtPtPiPDlcg7e3nVr
 q0D5vrHm+CGNSpIGo5+CPUTPKzN1Zpj2HYDFVVcbHX5en41rct9v8jPy4UmMfg5Y
 78Ue8DB2Viyi3w2ylIKYk0kTDYyPGJkX3DVNypWoFR++iAkoAmIm72BDh+iSZOVP
 7YkcDJdwU2bxiIjF/US44lgosnLT2laEMB7Edy880uktn9ihs0KbY6pmmMGM6AGc
 FYEmo1rG+MjEmsIE5CEGnBhDUuh6WOtE3NAtOQncciGAZ96q6opoQ0B5ewWL3Ltn
 W8rr4yy8vFg2hg38UjzV5ZuBQQr9YAXoWi0ks/Te59JY7cqkqHeG5DHKbFAz37UQ
 uKl2Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4a9aqkg919-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 06 Nov 2025 23:03:35 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 6 Nov 2025 23:03:46 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 6 Nov 2025 23:03:46 -0800
Received: from cavium-3070-BM23.. (unknown [10.28.34.25])
 by maili.marvell.com (Postfix) with ESMTP id 4B7343F707C;
 Thu,  6 Nov 2025 23:03:33 -0800 (PST)
From: <skori@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>
Subject: [PATCH v8 1/6] common/cnxk: support link mode configuration
Date: Fri, 7 Nov 2025 12:33:19 +0530
Message-ID: <20251107070330.2155154-1-skori@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104080901.1610706-6-skori@marvell.com>
References: <20251104080901.1610706-6-skori@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=XvD3+FF9 c=1 sm=1 tr=0 ts=690d99c7 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=I4B3QrvN1LbncYpy22gA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA1NCBTYWx0ZWRfX9gaTypCDVET9
 SWv4IlVTWFVFOjiX5m1IxGKjXxWBQgcNSdX/o5/ct7VPwWdq2btyp9blPTspr0lhNYZqQHHRdJr
 VJV/MXECvt7qba93Ru7FaWgD/3fxoHN7ixvM201yBgJAcYoGm7XYiwO2gzs+6V00qYWxa8jUhMG
 WG6uIn4C/YyOJYjTX+OB86yrGgN3wIszLmK/xGrSsO983WLwxN5Pe9QKbzpW3unNrW71RavNJ0n
 tFs+mJi5N7BBPa90FySfQLY+0IQsXsmATeUPD3UPdLS/didfKnVRPJ5Z586QX5uH7SXcMxiPSRo
 S+lE0TG+Gp1JAii/IGrAp6oOM2GCu94+sHEGKIBT+WFIbnHcQETgrzB7kmLreFrDb2rCc72v5Z0
 SQOgaPgA2xIVzMOPKyuxZiPPeVYXtA==
X-Proofpoint-ORIG-GUID: T7-h-zYjiQoqTqYkd4iqRRAimGBssKqh
X-Proofpoint-GUID: T7-h-zYjiQoqTqYkd4iqRRAimGBssKqh
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

CGX MAC can be configured into different modes and speeds
as mentioned below:

 - fixed/autoneg
 - half/full duplex
 - 10M/100M/1G/10G etc speeds.

Sync mailbox and implement that to configure above mentioned
settings.

Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
---
 drivers/common/cnxk/hw/nix.h                  | 70 ++++++++++++++
 drivers/common/cnxk/roc_mbox.h                | 15 ++-
 drivers/common/cnxk/roc_nix.h                 | 95 ++++++++++++++++++-
 drivers/common/cnxk/roc_nix_mac.c             | 38 +++++++-
 drivers/common/cnxk/roc_nix_priv.h            |  2 +
 .../common/cnxk/roc_platform_base_symbols.c   |  1 +
 6 files changed, 211 insertions(+), 10 deletions(-)

diff --git a/drivers/common/cnxk/hw/nix.h b/drivers/common/cnxk/hw/nix.h
index d16fa3b3ec..f344d4de99 100644
--- a/drivers/common/cnxk/hw/nix.h
+++ b/drivers/common/cnxk/hw/nix.h
@@ -2681,4 +2681,74 @@ struct nix_lso_format {
  */
 #define NIX_CHAN_CPT_X2P_MASK (0x7ffull)
 
+/* CGX lmac types defined by firmware */
+enum cgx_lmac_type {
+	CGX_LMAC_TYPE_SGMII = 0,
+	CGX_LMAC_TYPE_XAUI = 1,
+	CGX_LMAC_TYPE_RXAUI = 2,
+	CGX_LMAC_TYPE_10G_R = 3,
+	CGX_LMAC_TYPE_40G_R = 4,
+	CGX_LMAC_TYPE_QSGMII = 6,
+	CGX_LMAC_TYPE_25G_R = 7,
+	CGX_LMAC_TYPE_50G_R = 8,
+	CGX_LMAC_TYPE_100G_R = 9,
+	CGX_LMAC_TYPE_USXGMII = 10,
+	CGX_LMAC_TYPE_USGMII = 11,
+	CGX_LMAC_TYPE_MAX,
+};
+
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
index e1bed7858f..595cc353f4 100644
--- a/drivers/common/cnxk/roc_mbox.h
+++ b/drivers/common/cnxk/roc_mbox.h
@@ -766,13 +766,18 @@ struct cgx_lmac_fwdata_s {
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
+	uint64_t __io port;
+#define LMAC_FWDATA_RESERVED_MEM 1018
 	uint64_t __io reserved[LMAC_FWDATA_RESERVED_MEM];
 };
 
@@ -800,8 +805,10 @@ struct cgx_set_link_mode_args {
 	uint32_t __io speed;
 	uint8_t __io duplex;
 	uint8_t __io an;
-	uint8_t __io ports;
+	uint8_t __io mode_baseidx;
+	uint8_t __io multimode;
 	uint64_t __io mode;
+	uint64_t __io advertising;
 };
 
 struct cgx_set_link_mode_req {
diff --git a/drivers/common/cnxk/roc_nix.h b/drivers/common/cnxk/roc_nix.h
index a9cdc42617..41334327bb 100644
--- a/drivers/common/cnxk/roc_nix.h
+++ b/drivers/common/cnxk/roc_nix.h
@@ -16,6 +16,7 @@
 #define ROC_NIX_SQB_THRESH	      30U
 #define ROC_NIX_SQB_SLACK	      12U
 #define ROC_NIX_AURA_THRESH	      95U
+#define ROC_NIX_LINK_SPEED_ALL	      0xFFFFF
 
 /* Reserved interface types for BPID allocation */
 #define ROC_NIX_INTF_TYPE_CGX  0
@@ -109,6 +110,89 @@ enum roc_nix_bpf_stats {
 	ROC_NIX_BPF_RED_OCTS_F_DROP = BIT_ULL(11),
 };
 
+enum roc_nix_link_duplex {
+	ROC_NIX_LINK_DUPLEX_FULL = 0,
+	ROC_NIX_LINK_DUPLEX_HALF = 1
+};
+
+enum roc_nix_link_speed_bits {
+	ROC_NIX_LINK_SPEED_NONE_BIT = BIT_ULL(0),
+	ROC_NIX_LINK_SPEED_10M_HD_BIT = BIT_ULL(1),
+	ROC_NIX_LINK_SPEED_10M_BIT = BIT_ULL(2),
+	ROC_NIX_LINK_SPEED_100M_HD_BIT = BIT_ULL(3),
+	ROC_NIX_LINK_SPEED_100M_BIT = BIT_ULL(4),
+	ROC_NIX_LINK_SPEED_1G_BIT = BIT_ULL(5),
+	ROC_NIX_LINK_SPEED_2_5G_BIT = BIT_ULL(6),
+	ROC_NIX_LINK_SPEED_5G_BIT = BIT_ULL(7),
+	ROC_NIX_LINK_SPEED_10G_BIT = BIT_ULL(8),
+	ROC_NIX_LINK_SPEED_20G_BIT = BIT_ULL(9),
+	ROC_NIX_LINK_SPEED_25G_BIT = BIT_ULL(10),
+	ROC_NIX_LINK_SPEED_40G_BIT = BIT_ULL(11),
+	ROC_NIX_LINK_SPEED_50G_BIT = BIT_ULL(12),
+	ROC_NIX_LINK_SPEED_56G_BIT = BIT_ULL(13),
+	ROC_NIX_LINK_SPEED_100G_BIT = BIT_ULL(14),
+	ROC_NIX_LINK_SPEED_200G_BIT = BIT_ULL(15),
+	ROC_NIX_LINK_SPEED_400G_BIT = BIT_ULL(16),
+	ROC_NIX_LINK_SPEED_MAX = 17
+};
+
+enum roc_nix_link_mode {
+	ROC_NIX_LINK_MODE_10BASET_HD = BIT_ULL(0),
+	ROC_NIX_LINK_MODE_10BASET_FD = BIT_ULL(1),
+	ROC_NIX_LINK_MODE_100BASET_HD = BIT_ULL(2),
+	ROC_NIX_LINK_MODE_100BASET_FD = BIT_ULL(3),
+	ROC_NIX_LINK_MODE_1000BASET_HD = BIT_ULL(4),
+	ROC_NIX_LINK_MODE_1000BASET_FD = BIT_ULL(5),
+	ROC_NIX_LINK_MODE_AUTONEG = BIT_ULL(6),
+	ROC_NIX_LINK_MODE_10000BASET_FD = BIT_ULL(12),
+	ROC_NIX_LINK_MODE_2500BASEX_FD = BIT_ULL(15),
+	ROC_NIX_LINK_MODE_1000BASEKX_FD = BIT_ULL(17),
+	ROC_NIX_LINK_MODE_10000BASEKX4_FD = BIT_ULL(18),
+	ROC_NIX_LINK_MODE_10000BASEKR_FD = BIT_ULL(19),
+	ROC_NIX_LINK_MODE_10000BASER_FEC = BIT_ULL(20),
+	ROC_NIX_LINK_MODE_20000BASEMLD2_FD = BIT_ULL(21),
+	ROC_NIX_LINK_MODE_20000BASEKR2_FD = BIT_ULL(22),
+	ROC_NIX_LINK_MODE_40000BASEKR4_FD = BIT_ULL(23),
+	ROC_NIX_LINK_MODE_40000BASECR4_FD = BIT_ULL(24),
+	ROC_NIX_LINK_MODE_40000BASESR4_FD = BIT_ULL(25),
+	ROC_NIX_LINK_MODE_40000BASELR4_FD = BIT_ULL(26),
+	ROC_NIX_LINK_MODE_56000BASEKR4_FD = BIT_ULL(27),
+	ROC_NIX_LINK_MODE_56000BASECR4_FD = BIT_ULL(28),
+	ROC_NIX_LINK_MODE_56000BASESR4_FD = BIT_ULL(29),
+	ROC_NIX_LINK_MODE_56000BASELR4_FD = BIT_ULL(30),
+	ROC_NIX_LINK_MODE_25000BASECR_FD = BIT_ULL(31),
+	ROC_NIX_LINK_MODE_25000BASEKR_FD = BIT_ULL(32),
+	ROC_NIX_LINK_MODE_25000BASESR_FD = BIT_ULL(33),
+	ROC_NIX_LINK_MODE_50000BASECR2_FD = BIT_ULL(34),
+	ROC_NIX_LINK_MODE_50000BASEKR2_FD = BIT_ULL(35),
+	ROC_NIX_LINK_MODE_100000BASEKR4_FD = BIT_ULL(36),
+	ROC_NIX_LINK_MODE_100000BASESR4_FD = BIT_ULL(37),
+	ROC_NIX_LINK_MODE_100000BASECR4_FD = BIT_ULL(38),
+	ROC_NIX_LINK_MODE_100000BASELR4_ER4_FD = BIT_ULL(39),
+	ROC_NIX_LINK_MODE_50000BASESR2_FD = BIT_ULL(40),
+	ROC_NIX_LINK_MODE_1000BASEX_FD = BIT_ULL(41),
+	ROC_NIX_LINK_MODE_10000BASECR_FD = BIT_ULL(42),
+	ROC_NIX_LINK_MODE_10000BASESR_FD = BIT_ULL(43),
+	ROC_NIX_LINK_MODE_10000BASELR_FD = BIT_ULL(44),
+	ROC_NIX_LINK_MODE_10000BASELRM_FD = BIT_ULL(45),
+	ROC_NIX_LINK_MODE_10000BASEER_FD = BIT_ULL(46),
+	ROC_NIX_LINK_MODE_2500BASET_FD = BIT_ULL(47),
+	ROC_NIX_LINK_MODE_5000BASET_FD = BIT_ULL(48),
+	ROC_NIX_LINK_MODE_FEC_NONE = BIT_ULL(49),
+	ROC_NIX_LINK_MODE_FEC_RS = BIT_ULL(50),
+	ROC_NIX_LINK_MODE_FEC_BASER = BIT_ULL(51),
+	ROC_NIX_LINK_MODE_50000BASEKR_FD = BIT_ULL(52),
+	ROC_NIX_LINK_MODE_50000BASESR_FD = BIT_ULL(53),
+	ROC_NIX_LINK_MODE_50000BASECR_FD = BIT_ULL(54),
+	ROC_NIX_LINK_MODE_50000BASELR_ER_FR_FD = BIT_ULL(55),
+	ROC_NIX_LINK_MODE_50000BASEDR_FD = BIT_ULL(56),
+	ROC_NIX_LINK_MODE_100000BASEKR2_FD = BIT_ULL(57),
+	ROC_NIX_LINK_MODE_100000BASESR2_FD = BIT_ULL(58),
+	ROC_NIX_LINK_MODE_100000BASECR2_FD = BIT_ULL(59),
+	ROC_NIX_LINK_MODE_100000BASELR2_ER2_FR2_FD = BIT_ULL(60),
+	ROC_NIX_LINK_MODE_100000BASEDR2_FD = BIT_ULL(61),
+};
+
 struct roc_nix_bpf_cfg {
 	enum roc_nix_bpf_algo alg;
 	enum roc_nix_bpf_lmode lmode;
@@ -413,9 +497,17 @@ struct roc_nix_link_info {
 	uint64_t full_duplex : 1;
 	uint64_t lmac_type_id : 4;
 	uint64_t speed : 20;
+	uint64_t speed_bitmask : 16;
 	uint64_t autoneg : 1;
 	uint64_t fec : 2;
 	uint64_t port : 8;
+	uint64_t advertising;
+};
+
+struct roc_nix_mac_fwdata {
+	uint64_t advertised_link_modes;
+	uint64_t supported_link_modes;
+	uint64_t supported_an;
 };
 
 /** Maximum name length for extended statistics counters */
@@ -502,7 +594,7 @@ struct roc_nix {
 	bool reass_ena;
 	TAILQ_ENTRY(roc_nix) next;
 
-#define ROC_NIX_MEM_SZ (6 * 1112)
+#define ROC_NIX_MEM_SZ (6 * 1131)
 	uint8_t reserved[ROC_NIX_MEM_SZ] __plt_cache_aligned;
 } __plt_cache_aligned;
 
@@ -865,6 +957,7 @@ void __roc_api roc_nix_mac_link_info_get_cb_unregister(struct roc_nix *roc_nix);
 int __roc_api roc_nix_q_err_cb_register(struct roc_nix *roc_nix, q_err_get_t sq_err_handle);
 void __roc_api roc_nix_q_err_cb_unregister(struct roc_nix *roc_nix);
 int __roc_api roc_nix_mac_stats_reset(struct roc_nix *roc_nix);
+int __roc_api roc_nix_mac_fwdata_get(struct roc_nix *roc_nix, struct roc_nix_mac_fwdata *fwdata);
 
 /* Ops */
 int __roc_api roc_nix_switch_hdr_set(struct roc_nix *roc_nix,
diff --git a/drivers/common/cnxk/roc_nix_mac.c b/drivers/common/cnxk/roc_nix_mac.c
index 54db1adf17..08b4f30810 100644
--- a/drivers/common/cnxk/roc_nix_mac.c
+++ b/drivers/common/cnxk/roc_nix_mac.c
@@ -267,20 +267,19 @@ roc_nix_mac_link_info_set(struct roc_nix *roc_nix,
 	struct cgx_set_link_mode_req *req;
 	int rc;
 
-	rc = roc_nix_mac_link_state_set(roc_nix, link_info->status);
-	if (rc)
-		goto exit;
-
 	req = mbox_alloc_msg_cgx_set_link_mode(mbox);
 	if (req == NULL) {
 		rc =  -ENOSPC;
 		goto exit;
 	}
+
+	req->args.advertising = link_info->advertising;
 	req->args.speed = link_info->speed;
 	req->args.duplex = link_info->full_duplex;
 	req->args.an = link_info->autoneg;
 
-	rc = mbox_process(mbox);
+	/* Link mode changes takes more time. */
+	rc = mbox_process_tmo(mbox, mbox->rsp_tmo * 4);
 exit:
 	mbox_put(mbox);
 	return rc;
@@ -412,3 +411,32 @@ roc_nix_mac_link_info_get_cb_unregister(struct roc_nix *roc_nix)
 
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
+	data->supported_an = fw_data->fwdata.supported_an;
+exit:
+	mbox_put(mbox);
+	return rc;
+}
diff --git a/drivers/common/cnxk/roc_nix_priv.h b/drivers/common/cnxk/roc_nix_priv.h
index dc3450a3d4..c949621196 100644
--- a/drivers/common/cnxk/roc_nix_priv.h
+++ b/drivers/common/cnxk/roc_nix_priv.h
@@ -138,6 +138,8 @@ struct nix {
 	uint16_t bpid[NIX_MAX_CHAN];
 	struct nix_qint *qints_mem;
 	struct nix_qint *cints_mem;
+	uint64_t supported_link_modes;
+	uint64_t advertised_link_modes;
 	uint8_t configured_qints;
 	uint8_t configured_cints;
 	uint8_t exact_match_ena;
diff --git a/drivers/common/cnxk/roc_platform_base_symbols.c b/drivers/common/cnxk/roc_platform_base_symbols.c
index a557bfe5eb..ff64e82914 100644
--- a/drivers/common/cnxk/roc_platform_base_symbols.c
+++ b/drivers/common/cnxk/roc_platform_base_symbols.c
@@ -310,6 +310,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_link_info_set)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_mtu_set)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_max_rx_len_set)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_stats_reset)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_fwdata_get)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_link_cb_register)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_link_cb_unregister)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_link_info_get_cb_register)
-- 
2.43.0

