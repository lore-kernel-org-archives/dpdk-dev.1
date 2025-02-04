Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384EAC02194
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:11:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE898410DC;
	Tue,  4 Feb 2025 16:11:34 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 9609E40265
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:11:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681893; x=1770217893;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AW8ncKRfp7+7hyrwUs48wonTz78ZRtvN1ty5ynj4Cvw=;
 b=dWmCypggdxkxmHT3Zp/j1dtmoEStzziZF/IgXWsvOuvyEAbyuJWXxtUc
 HscK1KDrgqG1/vEQMOFvEuvX7iEOYAu4MKa9PZJpiEFCE+z7ozZLlP1hX
 kxSW6qxM43tkUhP1LEhuyidUTvf1xraXK8jqnnpmr9znn9dlhGm7uwvch
 sbPv58eBCSjvlXVw6UsdZqh/aavuKv4wNPNY9Y6iAGoehEBLK2Lf+ywHB
 GmbN3whoSUT3f5iixuD0StLJ23anK/keqCtaitVKFHT4mDOPwJYjWPILa
 CceKx0ZkC5g2pbdEGjDI8M7Ux/WLP5eFprb7ADS0NpxEvK04OlvuiGf6O A==;
X-CSE-ConnectionGUID: mcJJGvsTTNCa8vadTy5SuQ==
X-CSE-MsgGUID: nt7LlOBQRsSPzmF1RUQnlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097083"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097083"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:11:27 -0800
X-CSE-ConnectionGUID: aNw3JF9FTD2xoLoR07wZIw==
X-CSE-MsgGUID: eq51d6oTQGOgmTLu6zQp9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792542"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:11:24 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 01/54] net/e1000/base: copy i225 code into e1000
Date: Tue,  4 Feb 2025 15:10:07 +0000
Message-ID: <13c09445b09e188bb7b20787fb296018d834a83c.1738681725.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738681725.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738681725.git.anatoly.burakov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Do a direct copy of i225 code into e1000 directory, replacing all symbol
and definition names with e1000_/E1000_ prefix instead of igc_/IGC_ prefix.
This is done in preparation for merging the two drivers together.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_api.c      |  19 +
 drivers/net/intel/e1000/base/e1000_api.h      |   1 +
 drivers/net/intel/e1000/base/e1000_defines.h  | 175 +++-
 drivers/net/intel/e1000/base/e1000_hw.h       |  46 +
 .../igc_i225.c => e1000/base/e1000_i225.c}    | 816 +++++++++---------
 drivers/net/intel/e1000/base/e1000_i225.h     | 110 +++
 drivers/net/intel/e1000/base/e1000_mac.c      |  24 +-
 drivers/net/intel/e1000/base/e1000_nvm.c      |   1 +
 drivers/net/intel/e1000/base/e1000_osdep.h    |   6 +
 drivers/net/intel/e1000/base/e1000_phy.c      | 140 ++-
 drivers/net/intel/e1000/base/e1000_phy.h      |  17 +
 drivers/net/intel/e1000/base/e1000_regs.h     |  59 ++
 drivers/net/intel/e1000/base/meson.build      |   1 +
 13 files changed, 999 insertions(+), 416 deletions(-)
 copy drivers/net/intel/{igc/base/igc_i225.c => e1000/base/e1000_i225.c} (50%)
 create mode 100644 drivers/net/intel/e1000/base/e1000_i225.h

diff --git a/drivers/net/intel/e1000/base/e1000_api.c b/drivers/net/intel/e1000/base/e1000_api.c
index 6697b4b64f..bd7bb73030 100644
--- a/drivers/net/intel/e1000/base/e1000_api.c
+++ b/drivers/net/intel/e1000/base/e1000_api.c
@@ -354,6 +354,22 @@ s32 e1000_set_mac_type(struct e1000_hw *hw)
 	case E1000_DEV_ID_82576_VF_HV:
 		mac->type = e1000_vfadapt;
 		break;
+	case E1000_DEV_ID_I225_LM:
+	case E1000_DEV_ID_I225_LMVP:
+	case E1000_DEV_ID_I225_V:
+	case E1000_DEV_ID_I225_K:
+	case E1000_DEV_ID_I225_I:
+	case E1000_DEV_ID_I225_IT:
+	case E1000_DEV_ID_I220_V:
+	case E1000_DEV_ID_I225_BLANK_NVM:
+	case E1000_DEV_ID_I226_K:
+	case E1000_DEV_ID_I226_LMVP:
+	case E1000_DEV_ID_I226_LM:
+	case E1000_DEV_ID_I226_V:
+	case E1000_DEV_ID_I226_IT:
+	case E1000_DEV_ID_I226_BLANK_NVM:
+		mac->type = e1000_i225;
+		break;
 	case E1000_DEV_ID_I350_VF:
 	case E1000_DEV_ID_I350_VF_HV:
 		mac->type = e1000_vfadapt_i350;
@@ -470,6 +486,9 @@ s32 e1000_setup_init_funcs(struct e1000_hw *hw, bool init_device)
 	case e1000_i211:
 		e1000_init_function_pointers_i210(hw);
 		break;
+	case e1000_i225:
+		e1000_init_function_pointers_i225(hw);
+		break;
 	case e1000_vfadapt:
 		e1000_init_function_pointers_vf(hw);
 		break;
diff --git a/drivers/net/intel/e1000/base/e1000_api.h b/drivers/net/intel/e1000/base/e1000_api.h
index 6b38e2b7bb..2466c2fd48 100644
--- a/drivers/net/intel/e1000/base/e1000_api.h
+++ b/drivers/net/intel/e1000/base/e1000_api.h
@@ -19,6 +19,7 @@ extern void e1000_init_function_pointers_vf(struct e1000_hw *hw);
 extern void e1000_power_up_fiber_serdes_link(struct e1000_hw *hw);
 extern void e1000_shutdown_fiber_serdes_link(struct e1000_hw *hw);
 extern void e1000_init_function_pointers_i210(struct e1000_hw *hw);
+extern void e1000_init_function_pointers_i225(struct e1000_hw *hw);
 
 s32 e1000_set_obff_timer(struct e1000_hw *hw, u32 itr);
 s32 e1000_set_mac_type(struct e1000_hw *hw);
diff --git a/drivers/net/intel/e1000/base/e1000_defines.h b/drivers/net/intel/e1000/base/e1000_defines.h
index 3fbb6c8ea4..ab8eeb3f3a 100644
--- a/drivers/net/intel/e1000/base/e1000_defines.h
+++ b/drivers/net/intel/e1000/base/e1000_defines.h
@@ -188,6 +188,15 @@
 #define E1000_RCTL_BSEX		0x02000000 /* Buffer size extension */
 #define E1000_RCTL_SECRC	0x04000000 /* Strip Ethernet CRC */
 
+#define E1000_DTXMXPKTSZ_TSN     0x19 /* 1600 bytes of max TX DMA packet size */
+#define E1000_TXPBSIZE_TSN       0x04145145 /* 5k bytes buffer for each queue */
+
+/* Transmit Scheduling */
+#define E1000_TQAVCTRL_TRANSMIT_MODE_TSN 0x00000001
+#define E1000_TQAVCTRL_ENHANCED_QAV      0x00000008
+
+#define E1000_TXQCTL_QUEUE_MODE_LAUNCHT  0x00000001
+
 /* Use byte values for the following shift parameters
  * Usage:
  *     psrctl |= (((ROUNDUP(value0, 128) >> E1000_PSRCTL_BSIZE0_SHIFT) &
@@ -300,6 +309,8 @@
 #define E1000_STATUS_SPEED_10		0x00000000 /* Speed 10Mb/s */
 #define E1000_STATUS_SPEED_100		0x00000040 /* Speed 100Mb/s */
 #define E1000_STATUS_SPEED_1000		0x00000080 /* Speed 1000Mb/s */
+/* Speed 2.5Gb/s indication for I225 */
+#define E1000_STATUS_SPEED_2500		0x00400000
 #define E1000_STATUS_LAN_INIT_DONE	0x00000200 /* Lan Init Compltn by NVM */
 #define E1000_STATUS_PHYRA		0x00000400 /* PHY Reset Asserted */
 #define E1000_STATUS_GIO_MASTER_ENABLE	0x00080000 /* Master request status */
@@ -331,11 +342,16 @@
 #define ADVERTISE_100_FULL		0x0008
 #define ADVERTISE_1000_HALF		0x0010 /* Not used, just FYI */
 #define ADVERTISE_1000_FULL		0x0020
+#define ADVERTISE_2500_HALF		0x0040 /* NOT used, just FYI */
+#define ADVERTISE_2500_FULL		0x0080
 
 /* 1000/H is not supported, nor spec-compliant. */
 #define E1000_ALL_SPEED_DUPLEX	( \
 	ADVERTISE_10_HALF | ADVERTISE_10_FULL | ADVERTISE_100_HALF | \
 	ADVERTISE_100_FULL | ADVERTISE_1000_FULL)
+#define E1000_ALL_SPEED_DUPLEX_2500 ( \
+	ADVERTISE_10_HALF | ADVERTISE_10_FULL | ADVERTISE_100_HALF | \
+	ADVERTISE_100_FULL | ADVERTISE_1000_FULL | ADVERTISE_2500_FULL)
 #define E1000_ALL_NOT_GIG	( \
 	ADVERTISE_10_HALF | ADVERTISE_10_FULL | ADVERTISE_100_HALF | \
 	ADVERTISE_100_FULL)
@@ -344,6 +360,7 @@
 #define E1000_ALL_HALF_DUPLEX	(ADVERTISE_10_HALF | ADVERTISE_100_HALF)
 
 #define AUTONEG_ADVERTISE_SPEED_DEFAULT		E1000_ALL_SPEED_DUPLEX
+#define AUTONEG_ADVERTISE_SPEED_DEFAULT_2500	E1000_ALL_SPEED_DUPLEX_2500
 
 /* LED Control */
 #define E1000_PHY_LED0_MODE_MASK	0x00000007
@@ -586,6 +603,8 @@
 #define E1000_IMS_VMMB		E1000_ICR_VMMB    /* Mail box activity */
 #define E1000_IMS_RXSEQ		E1000_ICR_RXSEQ   /* Rx sequence error */
 #define E1000_IMS_RXDMT0	E1000_ICR_RXDMT0  /* Rx desc min. threshold */
+#define E1000_QVECTOR_MASK	0x7FFC		/* Q-vector mask */
+#define E1000_ITR_VAL_MASK	0x04		/* ITR value mask */
 #define E1000_IMS_RXO		E1000_ICR_RXO     /* Rx overrun */
 #define E1000_IMS_RXT0		E1000_ICR_RXT0    /* Rx timer intr */
 #define E1000_IMS_TXD_LOW	E1000_ICR_TXD_LOW
@@ -618,6 +637,7 @@
 #define E1000_ICS_LSC		E1000_ICR_LSC       /* Link Status Change */
 #define E1000_ICS_RXSEQ		E1000_ICR_RXSEQ     /* Rx sequence error */
 #define E1000_ICS_RXDMT0	E1000_ICR_RXDMT0    /* Rx desc min. threshold */
+#define E1000_ICS_DRSTA		E1000_ICR_DRSTA     /* Device Reset Aserted */
 
 /* Extended Interrupt Cause Set */
 #define E1000_EICS_RX_QUEUE0	E1000_EICR_RX_QUEUE0 /* Rx Queue 0 Interrupt */
@@ -770,6 +790,75 @@
 #define E1000_TIMINCA_INCPERIOD_SHIFT	24
 #define E1000_TIMINCA_INCVALUE_MASK	0x00FFFFFF
 
+/* Time Sync Interrupt Cause/Mask Register Bits */
+#define TSINTR_SYS_WRAP	(1 << 0) /* SYSTIM Wrap around. */
+#define TSINTR_TXTS	(1 << 1) /* Transmit Timestamp. */
+#define TSINTR_TT0	(1 << 3) /* Target Time 0 Trigger. */
+#define TSINTR_TT1	(1 << 4) /* Target Time 1 Trigger. */
+#define TSINTR_AUTT0	(1 << 5) /* Auxiliary Timestamp 0 Taken. */
+#define TSINTR_AUTT1	(1 << 6) /* Auxiliary Timestamp 1 Taken. */
+
+#define TSYNC_INTERRUPTS	TSINTR_TXTS
+
+/* Split Replication Receive Control */
+#define E1000_SRRCTL_TIMESTAMP           0x40000000
+#define E1000_SRRCTL_TIMER1SEL(timer)    (((timer) & 0x3) << 14)
+#define E1000_SRRCTL_TIMER0SEL(timer)    (((timer) & 0x3) << 17)
+
+/* Sample RX tstamp in PHY sop */
+#define E1000_TSYNCRXCTL_RXSYNSIG         0x00000400
+
+/* Sample TX tstamp in PHY sop */
+#define E1000_TSYNCTXCTL_TXSYNSIG         0x00000020
+
+/* TSAUXC Configuration Bits */
+#define TSAUXC_EN_TT0	(1 << 0)  /* Enable target time 0. */
+#define TSAUXC_EN_TT1	(1 << 1)  /* Enable target time 1. */
+#define TSAUXC_EN_CLK0	(1 << 2)  /* Enable Configurable Frequency Clock 0. */
+#define TSAUXC_ST0	(1 << 4)  /* Start Clock 0 Toggle on Target Time 0. */
+#define TSAUXC_EN_CLK1	(1 << 5)  /* Enable Configurable Frequency Clock 1. */
+#define TSAUXC_ST1	(1 << 7)  /* Start Clock 1 Toggle on Target Time 1. */
+#define TSAUXC_EN_TS0	(1 << 8)  /* Enable hardware timestamp 0. */
+#define TSAUXC_EN_TS1	(1 << 10) /* Enable hardware timestamp 0. */
+
+/* SDP Configuration Bits */
+#define AUX0_SEL_SDP0	(0u << 0)  /* Assign SDP0 to auxiliary time stamp 0. */
+#define AUX0_SEL_SDP1	(1u << 0)  /* Assign SDP1 to auxiliary time stamp 0. */
+#define AUX0_SEL_SDP2	(2u << 0)  /* Assign SDP2 to auxiliary time stamp 0. */
+#define AUX0_SEL_SDP3	(3u << 0)  /* Assign SDP3 to auxiliary time stamp 0. */
+#define AUX0_TS_SDP_EN	(1u << 2)  /* Enable auxiliary time stamp trigger 0. */
+#define AUX1_SEL_SDP0	(0u << 3)  /* Assign SDP0 to auxiliary time stamp 1. */
+#define AUX1_SEL_SDP1	(1u << 3)  /* Assign SDP1 to auxiliary time stamp 1. */
+#define AUX1_SEL_SDP2	(2u << 3)  /* Assign SDP2 to auxiliary time stamp 1. */
+#define AUX1_SEL_SDP3	(3u << 3)  /* Assign SDP3 to auxiliary time stamp 1. */
+#define AUX1_TS_SDP_EN	(1u << 5)  /* Enable auxiliary time stamp trigger 1. */
+#define TS_SDP0_EN	(1u << 8)  /* SDP0 is assigned to Tsync. */
+#define TS_SDP1_EN	(1u << 11) /* SDP1 is assigned to Tsync. */
+#define TS_SDP2_EN	(1u << 14) /* SDP2 is assigned to Tsync. */
+#define TS_SDP3_EN	(1u << 17) /* SDP3 is assigned to Tsync. */
+#define TS_SDP0_SEL_TT0	(0u << 6)  /* Target time 0 is output on SDP0. */
+#define TS_SDP0_SEL_TT1	(1u << 6)  /* Target time 1 is output on SDP0. */
+#define TS_SDP1_SEL_TT0	(0u << 9)  /* Target time 0 is output on SDP1. */
+#define TS_SDP1_SEL_TT1	(1u << 9)  /* Target time 1 is output on SDP1. */
+#define TS_SDP0_SEL_FC0	(2u << 6)  /* Freq clock  0 is output on SDP0. */
+#define TS_SDP0_SEL_FC1	(3u << 6)  /* Freq clock  1 is output on SDP0. */
+#define TS_SDP1_SEL_FC0	(2u << 9)  /* Freq clock  0 is output on SDP1. */
+#define TS_SDP1_SEL_FC1	(3u << 9)  /* Freq clock  1 is output on SDP1. */
+#define TS_SDP2_SEL_TT0	(0u << 12) /* Target time 0 is output on SDP2. */
+#define TS_SDP2_SEL_TT1	(1u << 12) /* Target time 1 is output on SDP2. */
+#define TS_SDP2_SEL_FC0	(2u << 12) /* Freq clock  0 is output on SDP2. */
+#define TS_SDP2_SEL_FC1	(3u << 12) /* Freq clock  1 is output on SDP2. */
+#define TS_SDP3_SEL_TT0	(0u << 15) /* Target time 0 is output on SDP3. */
+#define TS_SDP3_SEL_TT1	(1u << 15) /* Target time 1 is output on SDP3. */
+#define TS_SDP3_SEL_FC0	(2u << 15) /* Freq clock  0 is output on SDP3. */
+#define TS_SDP3_SEL_FC1	(3u << 15) /* Freq clock  1 is output on SDP3. */
+
+#define E1000_CTRL_SDP0_DIR	0x00400000  /* SDP0 Data direction */
+#define E1000_CTRL_SDP1_DIR	0x00800000  /* SDP1 Data direction */
+
+/* Extended Device Control */
+#define E1000_CTRL_EXT_SDP2_DIR	0x00000400 /* SDP2 Data direction */
+
 /* ETQF register bit definitions */
 #define E1000_ETQF_1588			(1 << 30)
 #define E1000_FTQF_VF_BP		0x00008000
@@ -824,7 +913,8 @@
 #define E1000_THSTAT_PWR_DOWN		0x00000001 /* Power Down Event */
 #define E1000_THSTAT_LINK_THROTTLE	0x00000002 /* Link Spd Throttle Event */
 
-/* I350 EEE defines */
+/* EEE defines */
+#define E1000_IPCNFG_EEE_2_5G_AN	0x00000010 /* IPCNFG EEE Ena 2.5G AN */
 #define E1000_IPCNFG_EEE_1G_AN		0x00000008 /* IPCNFG EEE Ena 1G AN */
 #define E1000_IPCNFG_EEE_100M_AN	0x00000004 /* IPCNFG EEE Ena 100M AN */
 #define E1000_EEER_TX_LPI_EN		0x00010000 /* EEER Tx LPI Enable */
@@ -854,6 +944,10 @@
 #define E1000_EEE_SU_LPI_CLK_STP	0x00800000 /* EEE LPI Clock Stop */
 #define E1000_EEE_LP_ADV_DEV_I210	7          /* EEE LP Adv Device */
 #define E1000_EEE_LP_ADV_ADDR_I210	61         /* EEE LP Adv Register */
+#define E1000_EEE_SU_LPI_CLK_STP	0x00800000 /* EEE LPI Clock Stop */
+#define E1000_EEE_LP_ADV_DEV_I225	7          /* EEE LP Adv Device */
+#define E1000_EEE_LP_ADV_ADDR_I225	61         /* EEE LP Adv Register */
+
 /* PCI Express Control */
 #define E1000_GCR_RXD_NO_SNOOP		0x00000001
 #define E1000_GCR_RXDSCW_NO_SNOOP	0x00000002
@@ -992,6 +1086,12 @@
 #define PHY_1000T_STATUS	0x0A /* 1000Base-T Status Reg */
 #define PHY_EXT_STATUS		0x0F /* Extended Status Reg */
 
+/* PHY GPY 211 registers */
+#define STANDARD_AN_REG_MASK	0x0007 /* MMD */
+#define ANEG_MULTIGBT_AN_CTRL	0x0020 /* MULTI GBT AN Control Register */
+#define MMD_DEVADDR_SHIFT	16     /* Shift MMD to higher bits */
+#define CR_2500T_FD_CAPS	0x0080 /* Advertise 2500T FD capability */
+
 #define PHY_CONTROL_LB		0x4000 /* PHY Loopback bit */
 
 /* NVM Control */
@@ -1038,6 +1138,15 @@
 /* Firmware code revision field word offset*/
 #define E1000_I210_FW_VER_OFFSET	328
 
+#define E1000_EECD_FLUPD_I225		0x00800000 /* Update FLASH */
+#define E1000_EECD_FLUDONE_I225		0x04000000 /* Update FLASH done */
+#define E1000_EECD_FLASH_DETECTED_I225	0x00080000 /* FLASH detected */
+#define E1000_FLUDONE_ATTEMPTS		20000
+#define E1000_EERD_EEWR_MAX_COUNT	512 /* buffered EEPROM words rw */
+#define E1000_EECD_SEC1VAL_I225		0x02000000 /* Sector One Valid */
+#define E1000_FLSECU_BLK_SW_ACCESS_I225	0x00000004 /* Block SW access */
+#define E1000_FWSM_FW_VALID_I225	0x8000 /* FW valid bit */
+
 #define E1000_NVM_RW_REG_DATA	16  /* Offset to data in NVM read/write regs */
 #define E1000_NVM_RW_REG_DONE	2   /* Offset to READ/WRITE done bit */
 #define E1000_NVM_RW_REG_START	1   /* Start operation */
@@ -1256,6 +1365,8 @@
 #define IGP04E1000_E_PHY_ID	0x02A80391
 #define BCM54616_E_PHY_ID	0x03625D10
 #define M88_VENDOR		0x0141
+#define I225_I_PHY_ID		0x67C9DC00
+#define I226_LM_PHY_ID          0x67C9DC10
 
 /* M88E1000 Specific Registers */
 #define M88E1000_PHY_SPEC_CTRL		0x10  /* PHY Specific Control Reg */
@@ -1378,6 +1489,8 @@
 #define GG82563_PHY_INBAND_CTRL		GG82563_REG(194, 18) /* Inband Ctrl */
 
 /* MDI Control */
+#define E1000_MDIC_DATA_MASK	0x0000FFFF
+#define E1000_MDIC_INT_EN		0x20000000
 #define E1000_MDIC_REG_MASK	0x001F0000
 #define E1000_MDIC_REG_SHIFT	16
 #define E1000_MDIC_PHY_MASK	0x03E00000
@@ -1388,6 +1501,14 @@
 #define E1000_MDIC_ERROR	0x40000000
 #define E1000_MDIC_DEST		0x80000000
 
+#define E1000_N0_QUEUE -1
+
+#define E1000_MAX_MAC_HDR_LEN	127
+#define E1000_MAX_NETWORK_HDR_LEN	511
+
+#define E1000_VLAPQF_QUEUE_SEL(_n, q_idx) ((q_idx) << ((_n) * 4))
+#define E1000_VLAPQF_P_VALID(_n)	(0x1 << (3 + (_n) * 4))
+#define E1000_VLAPQF_QUEUE_MASK	0x03
 #define E1000_VFTA_BLOCK_SIZE	8
 /* SerDes Control */
 #define E1000_GEN_CTL_READY		0x80000000
@@ -1464,6 +1585,57 @@
 #define I210_TXPBSIZE_DEFAULT		0x04000014 /* TXPBSIZE default */
 
 
+#define I225_RXPBSIZE_DEFAULT		0x000000A2 /* RXPBSIZE default */
+#define I225_TXPBSIZE_DEFAULT		0x04000014 /* TXPBSIZE default */
+#define E1000_RXPBS_SIZE_I225_MASK	0x0000003F /* Rx packet buffer size */
+#define E1000_TXPB0S_SIZE_I225_MASK	0x0000003F /* Tx packet buffer 0 size */
+#define E1000_STM_OPCODE		0xDB00
+#define E1000_EEPROM_FLASH_SIZE_WORD	0x11
+#define INVM_DWORD_TO_RECORD_TYPE(invm_dword) \
+	(u8)((invm_dword) & 0x7)
+#define INVM_DWORD_TO_WORD_ADDRESS(invm_dword) \
+	(u8)(((invm_dword) & 0x0000FE00) >> 9)
+#define INVM_DWORD_TO_WORD_DATA(invm_dword) \
+	(u16)(((invm_dword) & 0xFFFF0000) >> 16)
+#define E1000_INVM_RSA_KEY_SHA256_DATA_SIZE_IN_DWORDS	8
+#define E1000_INVM_CSR_AUTOLOAD_DATA_SIZE_IN_DWORDS	1
+#define E1000_INVM_ULT_BYTES_SIZE		8
+#define E1000_INVM_RECORD_SIZE_IN_BYTES	4
+#define E1000_INVM_VER_FIELD_ONE		0x1FF8
+#define E1000_INVM_VER_FIELD_TWO		0x7FE000
+#define E1000_INVM_IMGTYPE_FIELD		0x1F800000
+
+#define E1000_INVM_MAJOR_MASK	0x3F0
+#define E1000_INVM_MINOR_MASK	0xF
+#define E1000_INVM_MAJOR_SHIFT	4
+
+/* PLL Defines */
+#define E1000_PCI_PMCSR		0x44
+#define E1000_PCI_PMCSR_D3		0x03
+#define E1000_MAX_PLL_TRIES		5
+#define E1000_PHY_PLL_UNCONF		0xFF
+#define E1000_PHY_PLL_FREQ_PAGE	0xFC0000
+#define E1000_PHY_PLL_FREQ_REG		0x000E
+#define E1000_INVM_DEFAULT_AL		0x202F
+#define E1000_INVM_AUTOLOAD		0x0A
+#define E1000_INVM_PLL_WO_VAL		0x0010
+
+/* Proxy Filter Control Extended */
+#define E1000_PROXYFCEX_MDNS		0x00000001 /* mDNS */
+#define E1000_PROXYFCEX_MDNS_M		0x00000002 /* mDNS Multicast */
+#define E1000_PROXYFCEX_MDNS_U		0x00000004 /* mDNS Unicast */
+#define E1000_PROXYFCEX_IPV4_M		0x00000008 /* IPv4 Multicast */
+#define E1000_PROXYFCEX_IPV6_M		0x00000010 /* IPv6 Multicast */
+#define E1000_PROXYFCEX_IGMP		0x00000020 /* IGMP */
+#define E1000_PROXYFCEX_IGMP_M		0x00000040 /* IGMP Multicast */
+#define E1000_PROXYFCEX_ARPRES		0x00000080 /* ARP Response */
+#define E1000_PROXYFCEX_ARPRES_D	0x00000100 /* ARP Response Directed */
+#define E1000_PROXYFCEX_ICMPV4		0x00000200 /* ICMPv4 */
+#define E1000_PROXYFCEX_ICMPV4_D	0x00000400 /* ICMPv4 Directed */
+#define E1000_PROXYFCEX_ICMPV6		0x00000800 /* ICMPv6 */
+#define E1000_PROXYFCEX_ICMPV6_D	0x00001000 /* ICMPv6 Directed */
+#define E1000_PROXYFCEX_DNS		0x00002000 /* DNS */
+
 /* Proxy Filter Control */
 #define E1000_PROXYFC_D0		0x00000001 /* Enable offload in D0 */
 #define E1000_PROXYFC_EX		0x00000004 /* Directed exact proxy */
@@ -1473,6 +1645,7 @@
 #define E1000_PROXYFC_IPV4		0x00000040 /* Directed IPv4 Enable */
 #define E1000_PROXYFC_IPV6		0x00000080 /* Directed IPv6 Enable */
 #define E1000_PROXYFC_NS		0x00000200 /* IPv6 Neighbor Solicitation */
+#define E1000_PROXYFC_NS_DIRECTED	0x00000400 /* Directed NS Proxy Ena */
 #define E1000_PROXYFC_ARP		0x00000800 /* ARP Request Proxy Ena */
 /* Proxy Status */
 #define E1000_PROXYS_CLEAR		0xFFFFFFFF /* Clear */
diff --git a/drivers/net/intel/e1000/base/e1000_hw.h b/drivers/net/intel/e1000/base/e1000_hw.h
index c7e6903ecc..e341c9fe68 100644
--- a/drivers/net/intel/e1000/base/e1000_hw.h
+++ b/drivers/net/intel/e1000/base/e1000_hw.h
@@ -168,6 +168,20 @@ struct e1000_hw;
 #define E1000_DEV_ID_I210_SERDES_FLASHLESS	0x157C
 #define E1000_DEV_ID_I210_SGMII_FLASHLESS	0x15F6
 #define E1000_DEV_ID_I211_COPPER		0x1539
+#define E1000_DEV_ID_I225_LM			0x15F2
+#define E1000_DEV_ID_I225_LMVP			0x5502
+#define E1000_DEV_ID_I225_V			0x15F3
+#define E1000_DEV_ID_I225_K			0x3100
+#define E1000_DEV_ID_I225_I			0x15F8
+#define E1000_DEV_ID_I225_IT			0x0D9F
+#define E1000_DEV_ID_I220_V			0x15F7
+#define E1000_DEV_ID_I225_BLANK_NVM		0x15FD
+#define E1000_DEV_ID_I226_K           0x3102
+#define E1000_DEV_ID_I226_LMVP        0x5503
+#define E1000_DEV_ID_I226_LM          0x125B
+#define E1000_DEV_ID_I226_V           0x125C
+#define E1000_DEV_ID_I226_IT          0x125D
+#define E1000_DEV_ID_I226_BLANK_NVM   0x125F
 #define E1000_DEV_ID_I354_BACKPLANE_1GBPS	0x1F40
 #define E1000_DEV_ID_I354_SGMII			0x1F41
 #define E1000_DEV_ID_I354_BACKPLANE_2_5GBPS	0x1F45
@@ -229,6 +243,7 @@ enum e1000_mac_type {
 	e1000_i354,
 	e1000_i210,
 	e1000_i211,
+	e1000_i225,
 	e1000_vfadapt,
 	e1000_vfadapt_i350,
 	e1000_num_macs  /* List is 1-based, so subtract 1 for true count. */
@@ -277,6 +292,7 @@ enum e1000_phy_type {
 	e1000_phy_82580,
 	e1000_phy_vf,
 	e1000_phy_i210,
+	e1000_phy_i225,
 };
 
 enum e1000_bus_type {
@@ -363,6 +379,15 @@ enum e1000_serdes_link_state {
 	e1000_serdes_link_forced_up
 };
 
+enum e1000_invm_structure_type {
+	e1000_invm_uninitialized_structure		= 0x00,
+	e1000_invm_word_autoload_structure		= 0x01,
+	e1000_invm_csr_autoload_structure		= 0x02,
+	e1000_invm_phy_register_autoload_structure	= 0x03,
+	e1000_invm_rsa_key_sha256_structure		= 0x04,
+	e1000_invm_invalidated_structure		= 0x0f,
+};
+
 #define __le16 u16
 #define __le32 u32
 #define __le64 u64
@@ -762,6 +787,15 @@ struct e1000_nvm_operations {
 	s32  (*write)(struct e1000_hw *, u16, u16, u16 *);
 };
 
+struct e1000_info {
+	s32 (*get_invariants)(struct e1000_hw *hw);
+	struct e1000_mac_operations *mac_ops;
+	const struct e1000_phy_operations *phy_ops;
+	struct e1000_nvm_operations *nvm_ops;
+};
+
+extern const struct e1000_info e1000_i225_info;
+
 struct e1000_mac_info {
 	struct e1000_mac_operations ops;
 	u8 addr[ETH_ADDR_LEN];
@@ -978,6 +1012,16 @@ struct e1000_dev_spec_vf {
 	u32 v2p_mailbox;
 };
 
+struct e1000_dev_spec_i225 {
+	bool global_device_reset;
+	bool eee_disable;
+	bool clear_semaphore_once;
+	bool module_plugged;
+	u8 media_port;
+	bool mas_capable;
+	u32 mtu;
+};
+
 struct e1000_hw {
 	void *back;
 
@@ -1002,6 +1046,7 @@ struct e1000_hw {
 		struct e1000_dev_spec_ich8lan ich8lan;
 		struct e1000_dev_spec_82575 _82575;
 		struct e1000_dev_spec_vf vf;
+		struct e1000_dev_spec_i225 _i225;
 	} dev_spec;
 
 	u16 device_id;
@@ -1019,6 +1064,7 @@ struct e1000_hw {
 #include "e1000_ich8lan.h"
 #include "e1000_82575.h"
 #include "e1000_i210.h"
+#include "e1000_i225.h"
 #include "e1000_base.h"
 
 /* These functions must be implemented by drivers */
diff --git a/drivers/net/intel/igc/base/igc_i225.c b/drivers/net/intel/e1000/base/e1000_i225.c
similarity index 50%
copy from drivers/net/intel/igc/base/igc_i225.c
copy to drivers/net/intel/e1000/base/e1000_i225.c
index 17a1573064..018b22210e 100644
--- a/drivers/net/intel/igc/base/igc_i225.c
+++ b/drivers/net/intel/e1000/base/e1000_i225.c
@@ -2,34 +2,34 @@
  * Copyright(c) 2001-2020 Intel Corporation
  */
 
-#include "igc_api.h"
+#include "e1000_api.h"
 
-static s32 igc_init_nvm_params_i225(struct igc_hw *hw);
-static s32 igc_init_mac_params_i225(struct igc_hw *hw);
-static s32 igc_init_phy_params_i225(struct igc_hw *hw);
-static s32 igc_reset_hw_i225(struct igc_hw *hw);
-static s32 igc_acquire_nvm_i225(struct igc_hw *hw);
-static void igc_release_nvm_i225(struct igc_hw *hw);
-static s32 igc_get_hw_semaphore_i225(struct igc_hw *hw);
-static s32 __igc_write_nvm_srwr(struct igc_hw *hw, u16 offset, u16 words,
+static s32 e1000_init_nvm_params_i225(struct e1000_hw *hw);
+static s32 e1000_init_mac_params_i225(struct e1000_hw *hw);
+static s32 e1000_init_phy_params_i225(struct e1000_hw *hw);
+static s32 e1000_reset_hw_i225(struct e1000_hw *hw);
+static s32 e1000_acquire_nvm_i225(struct e1000_hw *hw);
+static void e1000_release_nvm_i225(struct e1000_hw *hw);
+static s32 e1000_get_hw_semaphore_i225(struct e1000_hw *hw);
+static s32 __e1000_write_nvm_srwr(struct e1000_hw *hw, u16 offset, u16 words,
 				  u16 *data);
-static s32 igc_pool_flash_update_done_i225(struct igc_hw *hw);
-static s32 igc_valid_led_default_i225(struct igc_hw *hw, u16 *data);
+static s32 e1000_pool_flash_update_done_i225(struct e1000_hw *hw);
+static s32 e1000_valid_led_default_i225(struct e1000_hw *hw, u16 *data);
 
 /**
- *  igc_init_nvm_params_i225 - Init NVM func ptrs.
+ *  e1000_init_nvm_params_i225 - Init NVM func ptrs.
  *  @hw: pointer to the HW structure
  **/
-static s32 igc_init_nvm_params_i225(struct igc_hw *hw)
+static s32 e1000_init_nvm_params_i225(struct e1000_hw *hw)
 {
-	struct igc_nvm_info *nvm = &hw->nvm;
-	u32 eecd = IGC_READ_REG(hw, IGC_EECD);
+	struct e1000_nvm_info *nvm = &hw->nvm;
+	u32 eecd = E1000_READ_REG(hw, E1000_EECD);
 	u16 size;
 
-	DEBUGFUNC("igc_init_nvm_params_i225");
+	DEBUGFUNC("e1000_init_nvm_params_i225");
 
-	size = (u16)((eecd & IGC_EECD_SIZE_EX_MASK) >>
-		     IGC_EECD_SIZE_EX_SHIFT);
+	size = (u16)((eecd & E1000_EECD_SIZE_EX_MASK) >>
+		     E1000_EECD_SIZE_EX_SHIFT);
 	/*
 	 * Added to a constant, "size" becomes the left-shift value
 	 * for setting word_size.
@@ -45,122 +45,122 @@ static s32 igc_init_nvm_params_i225(struct igc_hw *hw)
 	nvm->word_size = 1 << size;
 	nvm->opcode_bits = 8;
 	nvm->delay_usec = 1;
-	nvm->type = igc_nvm_eeprom_spi;
+	nvm->type = e1000_nvm_eeprom_spi;
 
 
-	nvm->page_size = eecd & IGC_EECD_ADDR_BITS ? 32 : 8;
-	nvm->address_bits = eecd & IGC_EECD_ADDR_BITS ?
+	nvm->page_size = eecd & E1000_EECD_ADDR_BITS ? 32 : 8;
+	nvm->address_bits = eecd & E1000_EECD_ADDR_BITS ?
 			    16 : 8;
 
 	if (nvm->word_size == (1 << 15))
 		nvm->page_size = 128;
 
-	nvm->ops.acquire = igc_acquire_nvm_i225;
-	nvm->ops.release = igc_release_nvm_i225;
-	nvm->ops.valid_led_default = igc_valid_led_default_i225;
-	if (igc_get_flash_presence_i225(hw)) {
-		hw->nvm.type = igc_nvm_flash_hw;
-		nvm->ops.read    = igc_read_nvm_srrd_i225;
-		nvm->ops.write   = igc_write_nvm_srwr_i225;
-		nvm->ops.validate = igc_validate_nvm_checksum_i225;
-		nvm->ops.update   = igc_update_nvm_checksum_i225;
+	nvm->ops.acquire = e1000_acquire_nvm_i225;
+	nvm->ops.release = e1000_release_nvm_i225;
+	nvm->ops.valid_led_default = e1000_valid_led_default_i225;
+	if (e1000_get_flash_presence_i225(hw)) {
+		hw->nvm.type = e1000_nvm_flash_hw;
+		nvm->ops.read    = e1000_read_nvm_srrd_i225;
+		nvm->ops.write   = e1000_write_nvm_srwr_i225;
+		nvm->ops.validate = e1000_validate_nvm_checksum_i225;
+		nvm->ops.update   = e1000_update_nvm_checksum_i225;
 	} else {
-		hw->nvm.type = igc_nvm_invm;
-		nvm->ops.write    = igc_null_write_nvm;
-		nvm->ops.validate = igc_null_ops_generic;
-		nvm->ops.update   = igc_null_ops_generic;
+		hw->nvm.type = e1000_nvm_invm;
+		nvm->ops.write    = e1000_null_write_nvm;
+		nvm->ops.validate = e1000_null_ops_generic;
+		nvm->ops.update   = e1000_null_ops_generic;
 	}
 
-	return IGC_SUCCESS;
+	return E1000_SUCCESS;
 }
 
 /**
- *  igc_init_mac_params_i225 - Init MAC func ptrs.
+ *  e1000_init_mac_params_i225 - Init MAC func ptrs.
  *  @hw: pointer to the HW structure
  **/
-static s32 igc_init_mac_params_i225(struct igc_hw *hw)
+static s32 e1000_init_mac_params_i225(struct e1000_hw *hw)
 {
-	struct igc_mac_info *mac = &hw->mac;
-	struct igc_dev_spec_i225 *dev_spec = &hw->dev_spec._i225;
+	struct e1000_mac_info *mac = &hw->mac;
+	struct e1000_dev_spec_i225 *dev_spec = &hw->dev_spec._i225;
 
-	DEBUGFUNC("igc_init_mac_params_i225");
+	DEBUGFUNC("e1000_init_mac_params_i225");
 
 	/* Initialize function pointer */
-	igc_init_mac_ops_generic(hw);
+	e1000_init_mac_ops_generic(hw);
 
 	/* Set media type */
-	hw->phy.media_type = igc_media_type_copper;
+	hw->phy.media_type = e1000_media_type_copper;
 	/* Set mta register count */
 	mac->mta_reg_count = 128;
 	/* Set rar entry count */
-	mac->rar_entry_count = IGC_RAR_ENTRIES_BASE;
+	mac->rar_entry_count = E1000_RAR_ENTRIES_BASE;
 
 	/* reset */
-	mac->ops.reset_hw = igc_reset_hw_i225;
+	mac->ops.reset_hw = e1000_reset_hw_i225;
 	/* hw initialization */
-	mac->ops.init_hw = igc_init_hw_i225;
+	mac->ops.init_hw = e1000_init_hw_i225;
 	/* link setup */
-	mac->ops.setup_link = igc_setup_link_generic;
+	mac->ops.setup_link = e1000_setup_link_generic;
 	/* check for link */
-	mac->ops.check_for_link = igc_check_for_link_i225;
+	mac->ops.check_for_link = e1000_check_for_link_i225;
 	/* link info */
-	mac->ops.get_link_up_info = igc_get_speed_and_duplex_copper_generic;
+	mac->ops.get_link_up_info = e1000_get_speed_and_duplex_copper_generic;
 	/* acquire SW_FW sync */
-	mac->ops.acquire_swfw_sync = igc_acquire_swfw_sync_i225;
+	mac->ops.acquire_swfw_sync = e1000_acquire_swfw_sync_i225;
 	/* release SW_FW sync */
-	mac->ops.release_swfw_sync = igc_release_swfw_sync_i225;
+	mac->ops.release_swfw_sync = e1000_release_swfw_sync_i225;
 
 	/* Allow a single clear of the SW semaphore on I225 */
 	dev_spec->clear_semaphore_once = true;
-	mac->ops.setup_physical_interface = igc_setup_copper_link_i225;
+	mac->ops.setup_physical_interface = e1000_setup_copper_link_i225;
 
 	/* Set if part includes ASF firmware */
 	mac->asf_firmware_present = true;
 
 	/* multicast address update */
-	mac->ops.update_mc_addr_list = igc_update_mc_addr_list_generic;
+	mac->ops.update_mc_addr_list = e1000_update_mc_addr_list_generic;
 
-	mac->ops.write_vfta = igc_write_vfta_generic;
+	mac->ops.write_vfta = e1000_write_vfta_generic;
 
 	/* Disable EEE by default */
 	dev_spec->eee_disable = true;
 
-	return IGC_SUCCESS;
+	return E1000_SUCCESS;
 }
 
 /**
- *  igc_init_phy_params_i225 - Init PHY func ptrs.
+ *  e1000_init_phy_params_i225 - Init PHY func ptrs.
  *  @hw: pointer to the HW structure
  **/
-static s32 igc_init_phy_params_i225(struct igc_hw *hw)
+static s32 e1000_init_phy_params_i225(struct e1000_hw *hw)
 {
-	struct igc_phy_info *phy = &hw->phy;
-	s32 ret_val = IGC_SUCCESS;
+	struct e1000_phy_info *phy = &hw->phy;
+	s32 ret_val = E1000_SUCCESS;
 	u32 ctrl_ext;
 
-	DEBUGFUNC("igc_init_phy_params_i225");
+	DEBUGFUNC("e1000_init_phy_params_i225");
 
-	phy->ops.read_i2c_byte = igc_read_i2c_byte_generic;
-	phy->ops.write_i2c_byte = igc_write_i2c_byte_generic;
+	phy->ops.read_i2c_byte = e1000_read_i2c_byte_generic;
+	phy->ops.write_i2c_byte = e1000_write_i2c_byte_generic;
 
-	if (hw->phy.media_type != igc_media_type_copper) {
-		phy->type = igc_phy_none;
+	if (hw->phy.media_type != e1000_media_type_copper) {
+		phy->type = e1000_phy_none;
 		goto out;
 	}
 
-	phy->ops.power_up   = igc_power_up_phy_copper;
-	phy->ops.power_down = igc_power_down_phy_copper_base;
+	phy->ops.power_up   = e1000_power_up_phy_copper;
+	phy->ops.power_down = e1000_power_down_phy_copper_base;
 
 	phy->autoneg_mask = AUTONEG_ADVERTISE_SPEED_DEFAULT_2500;
 
 	phy->reset_delay_us	= 100;
 
-	phy->ops.acquire	= igc_acquire_phy_base;
-	phy->ops.check_reset_block = igc_check_reset_block_generic;
-	phy->ops.commit		= igc_phy_sw_reset_generic;
-	phy->ops.release	= igc_release_phy_base;
+	phy->ops.acquire	= e1000_acquire_phy_base;
+	phy->ops.check_reset_block = e1000_check_reset_block_generic;
+	phy->ops.commit		= e1000_phy_sw_reset_generic;
+	phy->ops.release	= e1000_release_phy_base;
 
-	ctrl_ext = IGC_READ_REG(hw, IGC_CTRL_EXT);
+	ctrl_ext = E1000_READ_REG(hw, E1000_CTRL_EXT);
 
 	/* Make sure the PHY is in a good state. Several people have reported
 	 * firmware leaving the PHY's page select register set to something
@@ -171,12 +171,12 @@ static s32 igc_init_phy_params_i225(struct igc_hw *hw)
 	if (ret_val)
 		goto out;
 
-	IGC_WRITE_REG(hw, IGC_CTRL_EXT, ctrl_ext);
-	phy->ops.read_reg = igc_read_phy_reg_gpy;
-	phy->ops.write_reg = igc_write_phy_reg_gpy;
+	E1000_WRITE_REG(hw, E1000_CTRL_EXT, ctrl_ext);
+	phy->ops.read_reg = e1000_read_phy_reg_gpy;
+	phy->ops.write_reg = e1000_write_phy_reg_gpy;
 
-	ret_val = igc_get_phy_id(hw);
-	phy->type = igc_phy_i225;
+	ret_val = e1000_get_phy_id(hw);
+	phy->type = e1000_phy_i225;
 
 
 out:
@@ -184,41 +184,41 @@ static s32 igc_init_phy_params_i225(struct igc_hw *hw)
 }
 
 /**
- *  igc_reset_hw_i225 - Reset hardware
+ *  e1000_reset_hw_i225 - Reset hardware
  *  @hw: pointer to the HW structure
  *
  *  This resets the hardware into a known state.
  **/
-static s32 igc_reset_hw_i225(struct igc_hw *hw)
+static s32 e1000_reset_hw_i225(struct e1000_hw *hw)
 {
 	u32 ctrl;
 	s32 ret_val;
 
-	DEBUGFUNC("igc_reset_hw_i225");
+	DEBUGFUNC("e1000_reset_hw_i225");
 
 	/*
 	 * Prevent the PCI-E bus from sticking if there is no TLP connection
 	 * on the last TLP read/write transaction when MAC is reset.
 	 */
-	ret_val = igc_disable_pcie_master_generic(hw);
+	ret_val = e1000_disable_pcie_master_generic(hw);
 	if (ret_val)
 		DEBUGOUT("PCI-E Master disable polling has failed.\n");
 
 	DEBUGOUT("Masking off all interrupts\n");
-	IGC_WRITE_REG(hw, IGC_IMC, 0xffffffff);
+	E1000_WRITE_REG(hw, E1000_IMC, 0xffffffff);
 
-	IGC_WRITE_REG(hw, IGC_RCTL, 0);
-	IGC_WRITE_REG(hw, IGC_TCTL, IGC_TCTL_PSP);
-	IGC_WRITE_FLUSH(hw);
+	E1000_WRITE_REG(hw, E1000_RCTL, 0);
+	E1000_WRITE_REG(hw, E1000_TCTL, E1000_TCTL_PSP);
+	E1000_WRITE_FLUSH(hw);
 
 	msec_delay(10);
 
-	ctrl = IGC_READ_REG(hw, IGC_CTRL);
+	ctrl = E1000_READ_REG(hw, E1000_CTRL);
 
 	DEBUGOUT("Issuing a global reset to MAC\n");
-	IGC_WRITE_REG(hw, IGC_CTRL, ctrl | IGC_CTRL_RST);
+	E1000_WRITE_REG(hw, E1000_CTRL, ctrl | E1000_CTRL_RST);
 
-	ret_val = igc_get_auto_rd_done_generic(hw);
+	ret_val = e1000_get_auto_rd_done_generic(hw);
 	if (ret_val) {
 		/*
 		 * When auto config read does not complete, do not
@@ -229,167 +229,167 @@ static s32 igc_reset_hw_i225(struct igc_hw *hw)
 	}
 
 	/* Clear any pending interrupt events. */
-	IGC_WRITE_REG(hw, IGC_IMC, 0xffffffff);
-	IGC_READ_REG(hw, IGC_ICR);
+	E1000_WRITE_REG(hw, E1000_IMC, 0xffffffff);
+	E1000_READ_REG(hw, E1000_ICR);
 
 	/* Install any alternate MAC address into RAR0 */
-	ret_val = igc_check_alt_mac_addr_generic(hw);
+	ret_val = e1000_check_alt_mac_addr_generic(hw);
 
 	return ret_val;
 }
 
-/* igc_acquire_nvm_i225 - Request for access to EEPROM
+/* e1000_acquire_nvm_i225 - Request for access to EEPROM
  * @hw: pointer to the HW structure
  *
  * Acquire the necessary semaphores for exclusive access to the EEPROM.
  * Set the EEPROM access request bit and wait for EEPROM access grant bit.
  * Return successful if access grant bit set, else clear the request for
- * EEPROM access and return -IGC_ERR_NVM (-1).
+ * EEPROM access and return -E1000_ERR_NVM (-1).
  */
-static s32 igc_acquire_nvm_i225(struct igc_hw *hw)
+static s32 e1000_acquire_nvm_i225(struct e1000_hw *hw)
 {
 	s32 ret_val;
 
-	DEBUGFUNC("igc_acquire_nvm_i225");
+	DEBUGFUNC("e1000_acquire_nvm_i225");
 
-	ret_val = igc_acquire_swfw_sync_i225(hw, IGC_SWFW_EEP_SM);
+	ret_val = e1000_acquire_swfw_sync_i225(hw, E1000_SWFW_EEP_SM);
 
 	return ret_val;
 }
 
-/* igc_release_nvm_i225 - Release exclusive access to EEPROM
+/* e1000_release_nvm_i225 - Release exclusive access to EEPROM
  * @hw: pointer to the HW structure
  *
  * Stop any current commands to the EEPROM and clear the EEPROM request bit,
  * then release the semaphores acquired.
  */
-static void igc_release_nvm_i225(struct igc_hw *hw)
+static void e1000_release_nvm_i225(struct e1000_hw *hw)
 {
-	DEBUGFUNC("igc_release_nvm_i225");
+	DEBUGFUNC("e1000_release_nvm_i225");
 
-	igc_release_swfw_sync_i225(hw, IGC_SWFW_EEP_SM);
+	e1000_release_swfw_sync_i225(hw, E1000_SWFW_EEP_SM);
 }
 
-/* igc_acquire_swfw_sync_i225 - Acquire SW/FW semaphore
+/* e1000_acquire_swfw_sync_i225 - Acquire SW/FW semaphore
  * @hw: pointer to the HW structure
  * @mask: specifies which semaphore to acquire
  *
  * Acquire the SW/FW semaphore to access the PHY or NVM.  The mask
  * will also specify which port we're acquiring the lock for.
  */
-s32 igc_acquire_swfw_sync_i225(struct igc_hw *hw, u16 mask)
+s32 e1000_acquire_swfw_sync_i225(struct e1000_hw *hw, u16 mask)
 {
 	u32 swfw_sync;
 	u32 swmask = mask;
 	u32 fwmask = mask << 16;
-	s32 ret_val = IGC_SUCCESS;
+	s32 ret_val = E1000_SUCCESS;
 	s32 i = 0, timeout = 200; /* FIXME: find real value to use here */
 
-	DEBUGFUNC("igc_acquire_swfw_sync_i225");
+	DEBUGFUNC("e1000_acquire_swfw_sync_i225");
 
 	while (i < timeout) {
-		if (igc_get_hw_semaphore_i225(hw)) {
-			ret_val = -IGC_ERR_SWFW_SYNC;
+		if (e1000_get_hw_semaphore_i225(hw)) {
+			ret_val = -E1000_ERR_SWFW_SYNC;
 			goto out;
 		}
 
-		swfw_sync = IGC_READ_REG(hw, IGC_SW_FW_SYNC);
+		swfw_sync = E1000_READ_REG(hw, E1000_SW_FW_SYNC);
 		if (!(swfw_sync & (fwmask | swmask)))
 			break;
 
 		/* Firmware currently using resource (fwmask)
 		 * or other software thread using resource (swmask)
 		 */
-		igc_put_hw_semaphore_generic(hw);
+		e1000_put_hw_semaphore_generic(hw);
 		msec_delay_irq(5);
 		i++;
 	}
 
 	if (i == timeout) {
 		DEBUGOUT("Driver can't access resource, SW_FW_SYNC timeout.\n");
-		ret_val = -IGC_ERR_SWFW_SYNC;
+		ret_val = -E1000_ERR_SWFW_SYNC;
 		goto out;
 	}
 
 	swfw_sync |= swmask;
-	IGC_WRITE_REG(hw, IGC_SW_FW_SYNC, swfw_sync);
+	E1000_WRITE_REG(hw, E1000_SW_FW_SYNC, swfw_sync);
 
-	igc_put_hw_semaphore_generic(hw);
+	e1000_put_hw_semaphore_generic(hw);
 
 out:
 	return ret_val;
 }
 
-/* igc_release_swfw_sync_i225 - Release SW/FW semaphore
+/* e1000_release_swfw_sync_i225 - Release SW/FW semaphore
  * @hw: pointer to the HW structure
  * @mask: specifies which semaphore to acquire
  *
  * Release the SW/FW semaphore used to access the PHY or NVM.  The mask
  * will also specify which port we're releasing the lock for.
  */
-void igc_release_swfw_sync_i225(struct igc_hw *hw, u16 mask)
+void e1000_release_swfw_sync_i225(struct e1000_hw *hw, u16 mask)
 {
 	u32 swfw_sync;
 
-	DEBUGFUNC("igc_release_swfw_sync_i225");
+	DEBUGFUNC("e1000_release_swfw_sync_i225");
 
-	while (igc_get_hw_semaphore_i225(hw) != IGC_SUCCESS)
+	while (e1000_get_hw_semaphore_i225(hw) != E1000_SUCCESS)
 		; /* Empty */
 
-	swfw_sync = IGC_READ_REG(hw, IGC_SW_FW_SYNC);
+	swfw_sync = E1000_READ_REG(hw, E1000_SW_FW_SYNC);
 	swfw_sync &= ~mask;
-	IGC_WRITE_REG(hw, IGC_SW_FW_SYNC, swfw_sync);
+	E1000_WRITE_REG(hw, E1000_SW_FW_SYNC, swfw_sync);
 
-	igc_put_hw_semaphore_generic(hw);
+	e1000_put_hw_semaphore_generic(hw);
 }
 
 /*
- * igc_setup_copper_link_i225 - Configure copper link settings
+ * e1000_setup_copper_link_i225 - Configure copper link settings
  * @hw: pointer to the HW structure
  *
  * Configures the link for auto-neg or forced speed and duplex.  Then we check
  * for link, once link is established calls to configure collision distance
  * and flow control are called.
  */
-s32 igc_setup_copper_link_i225(struct igc_hw *hw)
+s32 e1000_setup_copper_link_i225(struct e1000_hw *hw)
 {
 	u32 phpm_reg;
 	s32 ret_val;
 	u32 ctrl;
 
-	DEBUGFUNC("igc_setup_copper_link_i225");
+	DEBUGFUNC("e1000_setup_copper_link_i225");
 
-	ctrl = IGC_READ_REG(hw, IGC_CTRL);
-	ctrl |= IGC_CTRL_SLU;
-	ctrl &= ~(IGC_CTRL_FRCSPD | IGC_CTRL_FRCDPX);
-	IGC_WRITE_REG(hw, IGC_CTRL, ctrl);
+	ctrl = E1000_READ_REG(hw, E1000_CTRL);
+	ctrl |= E1000_CTRL_SLU;
+	ctrl &= ~(E1000_CTRL_FRCSPD | E1000_CTRL_FRCDPX);
+	E1000_WRITE_REG(hw, E1000_CTRL, ctrl);
 
-	phpm_reg = IGC_READ_REG(hw, IGC_I225_PHPM);
-	phpm_reg &= ~IGC_I225_PHPM_GO_LINKD;
-	IGC_WRITE_REG(hw, IGC_I225_PHPM, phpm_reg);
+	phpm_reg = E1000_READ_REG(hw, E1000_I225_PHPM);
+	phpm_reg &= ~E1000_I225_PHPM_GO_LINKD;
+	E1000_WRITE_REG(hw, E1000_I225_PHPM, phpm_reg);
 
-	ret_val = igc_setup_copper_link_generic(hw);
+	ret_val = e1000_setup_copper_link_generic(hw);
 
 	return ret_val;
 }
 
-/* igc_get_hw_semaphore_i225 - Acquire hardware semaphore
+/* e1000_get_hw_semaphore_i225 - Acquire hardware semaphore
  * @hw: pointer to the HW structure
  *
  * Acquire the HW semaphore to access the PHY or NVM
  */
-static s32 igc_get_hw_semaphore_i225(struct igc_hw *hw)
+static s32 e1000_get_hw_semaphore_i225(struct e1000_hw *hw)
 {
 	u32 swsm;
 	s32 timeout = hw->nvm.word_size + 1;
 	s32 i = 0;
 
-	DEBUGFUNC("igc_get_hw_semaphore_i225");
+	DEBUGFUNC("e1000_get_hw_semaphore_i225");
 
 	/* Get the SW semaphore */
 	while (i < timeout) {
-		swsm = IGC_READ_REG(hw, IGC_SWSM);
-		if (!(swsm & IGC_SWSM_SMBI))
+		swsm = E1000_READ_REG(hw, E1000_SWSM);
+		if (!(swsm & E1000_SWSM_SMBI))
 			break;
 
 		usec_delay(50);
@@ -402,10 +402,10 @@ static s32 igc_get_hw_semaphore_i225(struct igc_hw *hw)
 		 */
 		if (hw->dev_spec._i225.clear_semaphore_once) {
 			hw->dev_spec._i225.clear_semaphore_once = false;
-			igc_put_hw_semaphore_generic(hw);
+			e1000_put_hw_semaphore_generic(hw);
 			for (i = 0; i < timeout; i++) {
-				swsm = IGC_READ_REG(hw, IGC_SWSM);
-				if (!(swsm & IGC_SWSM_SMBI))
+				swsm = E1000_READ_REG(hw, E1000_SWSM);
+				if (!(swsm & E1000_SWSM_SMBI))
 					break;
 
 				usec_delay(50);
@@ -416,17 +416,17 @@ static s32 igc_get_hw_semaphore_i225(struct igc_hw *hw)
 		if (i == timeout) {
 			DEBUGOUT("Driver can't access device -\n");
 			DEBUGOUT("SMBI bit is set.\n");
-			return -IGC_ERR_NVM;
+			return -E1000_ERR_NVM;
 		}
 	}
 
 	/* Get the FW semaphore. */
 	for (i = 0; i < timeout; i++) {
-		swsm = IGC_READ_REG(hw, IGC_SWSM);
-		IGC_WRITE_REG(hw, IGC_SWSM, swsm | IGC_SWSM_SWESMBI);
+		swsm = E1000_READ_REG(hw, E1000_SWSM);
+		E1000_WRITE_REG(hw, E1000_SWSM, swsm | E1000_SWSM_SWESMBI);
 
 		/* Semaphore acquired if bit latched */
-		if (IGC_READ_REG(hw, IGC_SWSM) & IGC_SWSM_SWESMBI)
+		if (E1000_READ_REG(hw, E1000_SWSM) & E1000_SWSM_SWESMBI)
 			break;
 
 		usec_delay(50);
@@ -434,15 +434,15 @@ static s32 igc_get_hw_semaphore_i225(struct igc_hw *hw)
 
 	if (i == timeout) {
 		/* Release semaphores */
-		igc_put_hw_semaphore_generic(hw);
+		e1000_put_hw_semaphore_generic(hw);
 		DEBUGOUT("Driver can't access the NVM\n");
-		return -IGC_ERR_NVM;
+		return -E1000_ERR_NVM;
 	}
 
-	return IGC_SUCCESS;
+	return E1000_SUCCESS;
 }
 
-/* igc_read_nvm_srrd_i225 - Reads Shadow Ram using EERD register
+/* e1000_read_nvm_srrd_i225 - Reads Shadow Ram using EERD register
  * @hw: pointer to the HW structure
  * @offset: offset of word in the Shadow Ram to read
  * @words: number of words to read
@@ -451,37 +451,37 @@ static s32 igc_get_hw_semaphore_i225(struct igc_hw *hw)
  * Reads a 16 bit word from the Shadow Ram using the EERD register.
  * Uses necessary synchronization semaphores.
  */
-s32 igc_read_nvm_srrd_i225(struct igc_hw *hw, u16 offset, u16 words,
+s32 e1000_read_nvm_srrd_i225(struct e1000_hw *hw, u16 offset, u16 words,
 			     u16 *data)
 {
-	s32 status = IGC_SUCCESS;
+	s32 status = E1000_SUCCESS;
 	u16 i, count;
 
-	DEBUGFUNC("igc_read_nvm_srrd_i225");
+	DEBUGFUNC("e1000_read_nvm_srrd_i225");
 
 	/* We cannot hold synchronization semaphores for too long,
 	 * because of forceful takeover procedure. However it is more efficient
 	 * to read in bursts than synchronizing access for each word.
 	 */
-	for (i = 0; i < words; i += IGC_EERD_EEWR_MAX_COUNT) {
-		count = (words - i) / IGC_EERD_EEWR_MAX_COUNT > 0 ?
-			IGC_EERD_EEWR_MAX_COUNT : (words - i);
-		if (hw->nvm.ops.acquire(hw) == IGC_SUCCESS) {
-			status = igc_read_nvm_eerd(hw, offset, count,
+	for (i = 0; i < words; i += E1000_EERD_EEWR_MAX_COUNT) {
+		count = (words - i) / E1000_EERD_EEWR_MAX_COUNT > 0 ?
+			E1000_EERD_EEWR_MAX_COUNT : (words - i);
+		if (hw->nvm.ops.acquire(hw) == E1000_SUCCESS) {
+			status = e1000_read_nvm_eerd(hw, offset, count,
 						     data + i);
 			hw->nvm.ops.release(hw);
 		} else {
-			status = IGC_ERR_SWFW_SYNC;
+			status = E1000_ERR_SWFW_SYNC;
 		}
 
-		if (status != IGC_SUCCESS)
+		if (status != E1000_SUCCESS)
 			break;
 	}
 
 	return status;
 }
 
-/* igc_write_nvm_srwr_i225 - Write to Shadow RAM using EEWR
+/* e1000_write_nvm_srwr_i225 - Write to Shadow RAM using EEWR
  * @hw: pointer to the HW structure
  * @offset: offset within the Shadow RAM to be written to
  * @words: number of words to write
@@ -489,44 +489,44 @@ s32 igc_read_nvm_srrd_i225(struct igc_hw *hw, u16 offset, u16 words,
  *
  * Writes data to Shadow RAM at offset using EEWR register.
  *
- * If igc_update_nvm_checksum is not called after this function , the
+ * If e1000_update_nvm_checksum is not called after this function , the
  * data will not be committed to FLASH and also Shadow RAM will most likely
  * contain an invalid checksum.
  *
  * If error code is returned, data and Shadow RAM may be inconsistent - buffer
  * partially written.
  */
-s32 igc_write_nvm_srwr_i225(struct igc_hw *hw, u16 offset, u16 words,
+s32 e1000_write_nvm_srwr_i225(struct e1000_hw *hw, u16 offset, u16 words,
 			      u16 *data)
 {
-	s32 status = IGC_SUCCESS;
+	s32 status = E1000_SUCCESS;
 	u16 i, count;
 
-	DEBUGFUNC("igc_write_nvm_srwr_i225");
+	DEBUGFUNC("e1000_write_nvm_srwr_i225");
 
 	/* We cannot hold synchronization semaphores for too long,
 	 * because of forceful takeover procedure. However it is more efficient
 	 * to write in bursts than synchronizing access for each word.
 	 */
-	for (i = 0; i < words; i += IGC_EERD_EEWR_MAX_COUNT) {
-		count = (words - i) / IGC_EERD_EEWR_MAX_COUNT > 0 ?
-			IGC_EERD_EEWR_MAX_COUNT : (words - i);
-		if (hw->nvm.ops.acquire(hw) == IGC_SUCCESS) {
-			status = __igc_write_nvm_srwr(hw, offset, count,
+	for (i = 0; i < words; i += E1000_EERD_EEWR_MAX_COUNT) {
+		count = (words - i) / E1000_EERD_EEWR_MAX_COUNT > 0 ?
+			E1000_EERD_EEWR_MAX_COUNT : (words - i);
+		if (hw->nvm.ops.acquire(hw) == E1000_SUCCESS) {
+			status = __e1000_write_nvm_srwr(hw, offset, count,
 							data + i);
 			hw->nvm.ops.release(hw);
 		} else {
-			status = IGC_ERR_SWFW_SYNC;
+			status = E1000_ERR_SWFW_SYNC;
 		}
 
-		if (status != IGC_SUCCESS)
+		if (status != E1000_SUCCESS)
 			break;
 	}
 
 	return status;
 }
 
-/* __igc_write_nvm_srwr - Write to Shadow Ram using EEWR
+/* __e1000_write_nvm_srwr - Write to Shadow Ram using EEWR
  * @hw: pointer to the HW structure
  * @offset: offset within the Shadow Ram to be written to
  * @words: number of words to write
@@ -534,18 +534,18 @@ s32 igc_write_nvm_srwr_i225(struct igc_hw *hw, u16 offset, u16 words,
  *
  * Writes data to Shadow Ram at offset using EEWR register.
  *
- * If igc_update_nvm_checksum is not called after this function , the
+ * If e1000_update_nvm_checksum is not called after this function , the
  * Shadow Ram will most likely contain an invalid checksum.
  */
-static s32 __igc_write_nvm_srwr(struct igc_hw *hw, u16 offset, u16 words,
+static s32 __e1000_write_nvm_srwr(struct e1000_hw *hw, u16 offset, u16 words,
 				  u16 *data)
 {
-	struct igc_nvm_info *nvm = &hw->nvm;
+	struct e1000_nvm_info *nvm = &hw->nvm;
 	u32 i, k, eewr = 0;
 	u32 attempts = 100000;
-	s32 ret_val = IGC_SUCCESS;
+	s32 ret_val = E1000_SUCCESS;
 
-	DEBUGFUNC("__igc_write_nvm_srwr");
+	DEBUGFUNC("__e1000_write_nvm_srwr");
 
 	/* A check for invalid values:  offset too large, too many words,
 	 * too many words for the offset, and not enough words.
@@ -553,27 +553,27 @@ static s32 __igc_write_nvm_srwr(struct igc_hw *hw, u16 offset, u16 words,
 	if (offset >= nvm->word_size || words > (nvm->word_size - offset) ||
 			words == 0) {
 		DEBUGOUT("nvm parameter(s) out of bounds\n");
-		ret_val = -IGC_ERR_NVM;
+		ret_val = -E1000_ERR_NVM;
 		goto out;
 	}
 
 	for (i = 0; i < words; i++) {
-		eewr = ((offset + i) << IGC_NVM_RW_ADDR_SHIFT) |
-			(data[i] << IGC_NVM_RW_REG_DATA) |
-			IGC_NVM_RW_REG_START;
+		eewr = ((offset + i) << E1000_NVM_RW_ADDR_SHIFT) |
+			(data[i] << E1000_NVM_RW_REG_DATA) |
+			E1000_NVM_RW_REG_START;
 
-		IGC_WRITE_REG(hw, IGC_SRWR, eewr);
+		E1000_WRITE_REG(hw, E1000_SRWR, eewr);
 
 		for (k = 0; k < attempts; k++) {
-			if (IGC_NVM_RW_REG_DONE &
-			    IGC_READ_REG(hw, IGC_SRWR)) {
-				ret_val = IGC_SUCCESS;
+			if (E1000_NVM_RW_REG_DONE &
+			    E1000_READ_REG(hw, E1000_SRWR)) {
+				ret_val = E1000_SUCCESS;
 				break;
 			}
 			usec_delay(5);
 		}
 
-		if (ret_val != IGC_SUCCESS) {
+		if (ret_val != E1000_SUCCESS) {
 			DEBUGOUT("Shadow RAM write EEWR timed out\n");
 			break;
 		}
@@ -583,30 +583,30 @@ static s32 __igc_write_nvm_srwr(struct igc_hw *hw, u16 offset, u16 words,
 	return ret_val;
 }
 
-/* igc_read_invm_version_i225 - Reads iNVM version and image type
+/* e1000_read_invm_version_i225 - Reads iNVM version and image type
  * @hw: pointer to the HW structure
  * @invm_ver: version structure for the version read
  *
  * Reads iNVM version and image type.
  */
-s32 igc_read_invm_version_i225(struct igc_hw *hw,
-				 struct igc_fw_version *invm_ver)
+s32 e1000_read_invm_version_i225(struct e1000_hw *hw,
+				 struct e1000_fw_version *invm_ver)
 {
 	u32 *record = NULL;
 	u32 *next_record = NULL;
 	u32 i = 0;
 	u32 invm_dword = 0;
-	u32 invm_blocks = IGC_INVM_SIZE - (IGC_INVM_ULT_BYTES_SIZE /
-					     IGC_INVM_RECORD_SIZE_IN_BYTES);
-	u32 buffer[IGC_INVM_SIZE];
-	s32 status = -IGC_ERR_INVM_VALUE_NOT_FOUND;
+	u32 invm_blocks = E1000_INVM_SIZE - (E1000_INVM_ULT_BYTES_SIZE /
+					     E1000_INVM_RECORD_SIZE_IN_BYTES);
+	u32 buffer[E1000_INVM_SIZE];
+	s32 status = -E1000_ERR_INVM_VALUE_NOT_FOUND;
 	u16 version = 0;
 
-	DEBUGFUNC("igc_read_invm_version_i225");
+	DEBUGFUNC("e1000_read_invm_version_i225");
 
 	/* Read iNVM memory */
-	for (i = 0; i < IGC_INVM_SIZE; i++) {
-		invm_dword = IGC_READ_REG(hw, IGC_INVM_DATA_REG(i));
+	for (i = 0; i < E1000_INVM_SIZE; i++) {
+		invm_dword = E1000_READ_REG(hw, E1000_INVM_DATA_REG(i));
 		buffer[i] = invm_dword;
 	}
 
@@ -616,44 +616,44 @@ s32 igc_read_invm_version_i225(struct igc_hw *hw,
 		next_record = &buffer[invm_blocks - i + 1];
 
 		/* Check if we have first version location used */
-		if (i == 1 && (*record & IGC_INVM_VER_FIELD_ONE) == 0) {
+		if (i == 1 && (*record & E1000_INVM_VER_FIELD_ONE) == 0) {
 			version = 0;
-			status = IGC_SUCCESS;
+			status = E1000_SUCCESS;
 			break;
 		}
 		/* Check if we have second version location used */
 		else if ((i == 1) &&
-			 ((*record & IGC_INVM_VER_FIELD_TWO) == 0)) {
-			version = (*record & IGC_INVM_VER_FIELD_ONE) >> 3;
-			status = IGC_SUCCESS;
+			 ((*record & E1000_INVM_VER_FIELD_TWO) == 0)) {
+			version = (*record & E1000_INVM_VER_FIELD_ONE) >> 3;
+			status = E1000_SUCCESS;
 			break;
 		}
 		/* Check if we have odd version location
 		 * used and it is the last one used
 		 */
-		else if ((((*record & IGC_INVM_VER_FIELD_ONE) == 0) &&
+		else if ((((*record & E1000_INVM_VER_FIELD_ONE) == 0) &&
 			  ((*record & 0x3) == 0)) || (((*record & 0x3) != 0) &&
 			   (i != 1))) {
-			version = (*next_record & IGC_INVM_VER_FIELD_TWO)
+			version = (*next_record & E1000_INVM_VER_FIELD_TWO)
 				  >> 13;
-			status = IGC_SUCCESS;
+			status = E1000_SUCCESS;
 			break;
 		}
 		/* Check if we have even version location
 		 * used and it is the last one used
 		 */
-		else if (((*record & IGC_INVM_VER_FIELD_TWO) == 0) &&
+		else if (((*record & E1000_INVM_VER_FIELD_TWO) == 0) &&
 			 ((*record & 0x3) == 0)) {
-			version = (*record & IGC_INVM_VER_FIELD_ONE) >> 3;
-			status = IGC_SUCCESS;
+			version = (*record & E1000_INVM_VER_FIELD_ONE) >> 3;
+			status = E1000_SUCCESS;
 			break;
 		}
 	}
 
-	if (status == IGC_SUCCESS) {
-		invm_ver->invm_major = (version & IGC_INVM_MAJOR_MASK)
-					>> IGC_INVM_MAJOR_SHIFT;
-		invm_ver->invm_minor = version & IGC_INVM_MINOR_MASK;
+	if (status == E1000_SUCCESS) {
+		invm_ver->invm_major = (version & E1000_INVM_MAJOR_MASK)
+					>> E1000_INVM_MAJOR_SHIFT;
+		invm_ver->invm_minor = version & E1000_INVM_MINOR_MASK;
 	}
 	/* Read Image Type */
 	for (i = 1; i < invm_blocks; i++) {
@@ -661,92 +661,92 @@ s32 igc_read_invm_version_i225(struct igc_hw *hw,
 		next_record = &buffer[invm_blocks - i + 1];
 
 		/* Check if we have image type in first location used */
-		if (i == 1 && (*record & IGC_INVM_IMGTYPE_FIELD) == 0) {
+		if (i == 1 && (*record & E1000_INVM_IMGTYPE_FIELD) == 0) {
 			invm_ver->invm_img_type = 0;
-			status = IGC_SUCCESS;
+			status = E1000_SUCCESS;
 			break;
 		}
 		/* Check if we have image type in first location used */
 		else if ((((*record & 0x3) == 0) &&
-			  ((*record & IGC_INVM_IMGTYPE_FIELD) == 0)) ||
+			  ((*record & E1000_INVM_IMGTYPE_FIELD) == 0)) ||
 			    ((((*record & 0x3) != 0) && (i != 1)))) {
 			invm_ver->invm_img_type =
-				(*next_record & IGC_INVM_IMGTYPE_FIELD) >> 23;
-			status = IGC_SUCCESS;
+				(*next_record & E1000_INVM_IMGTYPE_FIELD) >> 23;
+			status = E1000_SUCCESS;
 			break;
 		}
 	}
 	return status;
 }
 
-/* igc_validate_nvm_checksum_i225 - Validate EEPROM checksum
+/* e1000_validate_nvm_checksum_i225 - Validate EEPROM checksum
  * @hw: pointer to the HW structure
  *
  * Calculates the EEPROM checksum by reading/adding each word of the EEPROM
  * and then verifies that the sum of the EEPROM is equal to 0xBABA.
  */
-s32 igc_validate_nvm_checksum_i225(struct igc_hw *hw)
+s32 e1000_validate_nvm_checksum_i225(struct e1000_hw *hw)
 {
-	s32 status = IGC_SUCCESS;
-	s32 (*read_op_ptr)(struct igc_hw *hw, u16 offset,
+	s32 status = E1000_SUCCESS;
+	s32 (*read_op_ptr)(struct e1000_hw *hw, u16 offset,
 			u16 count, u16 *data);
 
-	DEBUGFUNC("igc_validate_nvm_checksum_i225");
+	DEBUGFUNC("e1000_validate_nvm_checksum_i225");
 
-	if (hw->nvm.ops.acquire(hw) == IGC_SUCCESS) {
+	if (hw->nvm.ops.acquire(hw) == E1000_SUCCESS) {
 		/* Replace the read function with semaphore grabbing with
 		 * the one that skips this for a while.
 		 * We have semaphore taken already here.
 		 */
 		read_op_ptr = hw->nvm.ops.read;
-		hw->nvm.ops.read = igc_read_nvm_eerd;
+		hw->nvm.ops.read = e1000_read_nvm_eerd;
 
-		status = igc_validate_nvm_checksum_generic(hw);
+		status = e1000_validate_nvm_checksum_generic(hw);
 
 		/* Revert original read operation. */
 		hw->nvm.ops.read = read_op_ptr;
 
 		hw->nvm.ops.release(hw);
 	} else {
-		status = IGC_ERR_SWFW_SYNC;
+		status = E1000_ERR_SWFW_SYNC;
 	}
 
 	return status;
 }
 
-/* igc_update_nvm_checksum_i225 - Update EEPROM checksum
+/* e1000_update_nvm_checksum_i225 - Update EEPROM checksum
  * @hw: pointer to the HW structure
  *
  * Updates the EEPROM checksum by reading/adding each word of the EEPROM
  * up to the checksum.  Then calculates the EEPROM checksum and writes the
  * value to the EEPROM. Next commit EEPROM data onto the Flash.
  */
-s32 igc_update_nvm_checksum_i225(struct igc_hw *hw)
+s32 e1000_update_nvm_checksum_i225(struct e1000_hw *hw)
 {
 	s32 ret_val;
 	u16 checksum = 0;
 	u16 i, nvm_data;
 
-	DEBUGFUNC("igc_update_nvm_checksum_i225");
+	DEBUGFUNC("e1000_update_nvm_checksum_i225");
 
 	/* Read the first word from the EEPROM. If this times out or fails, do
 	 * not continue or we could be in for a very long wait while every
 	 * EEPROM read fails
 	 */
-	ret_val = igc_read_nvm_eerd(hw, 0, 1, &nvm_data);
-	if (ret_val != IGC_SUCCESS) {
+	ret_val = e1000_read_nvm_eerd(hw, 0, 1, &nvm_data);
+	if (ret_val != E1000_SUCCESS) {
 		DEBUGOUT("EEPROM read failed\n");
 		goto out;
 	}
 
-	if (hw->nvm.ops.acquire(hw) == IGC_SUCCESS) {
+	if (hw->nvm.ops.acquire(hw) == E1000_SUCCESS) {
 		/* Do not use hw->nvm.ops.write, hw->nvm.ops.read
 		 * because we do not want to take the synchronization
 		 * semaphores twice here.
 		 */
 
 		for (i = 0; i < NVM_CHECKSUM_REG; i++) {
-			ret_val = igc_read_nvm_eerd(hw, i, 1, &nvm_data);
+			ret_val = e1000_read_nvm_eerd(hw, i, 1, &nvm_data);
 			if (ret_val) {
 				hw->nvm.ops.release(hw);
 				DEBUGOUT("NVM Read Error while updating\n");
@@ -756,9 +756,9 @@ s32 igc_update_nvm_checksum_i225(struct igc_hw *hw)
 			checksum += nvm_data;
 		}
 		checksum = (u16)NVM_SUM - checksum;
-		ret_val = __igc_write_nvm_srwr(hw, NVM_CHECKSUM_REG, 1,
+		ret_val = __e1000_write_nvm_srwr(hw, NVM_CHECKSUM_REG, 1,
 						 &checksum);
-		if (ret_val != IGC_SUCCESS) {
+		if (ret_val != E1000_SUCCESS) {
 			hw->nvm.ops.release(hw);
 			DEBUGOUT("NVM Write Error while updating checksum.\n");
 			goto out;
@@ -766,102 +766,102 @@ s32 igc_update_nvm_checksum_i225(struct igc_hw *hw)
 
 		hw->nvm.ops.release(hw);
 
-		ret_val = igc_update_flash_i225(hw);
+		ret_val = e1000_update_flash_i225(hw);
 	} else {
-		ret_val = IGC_ERR_SWFW_SYNC;
+		ret_val = E1000_ERR_SWFW_SYNC;
 	}
 out:
 	return ret_val;
 }
 
-/* igc_get_flash_presence_i225 - Check if flash device is detected.
+/* e1000_get_flash_presence_i225 - Check if flash device is detected.
  * @hw: pointer to the HW structure
  */
-bool igc_get_flash_presence_i225(struct igc_hw *hw)
+bool e1000_get_flash_presence_i225(struct e1000_hw *hw)
 {
 	u32 eec = 0;
 	bool ret_val = false;
 
-	DEBUGFUNC("igc_get_flash_presence_i225");
+	DEBUGFUNC("e1000_get_flash_presence_i225");
 
-	eec = IGC_READ_REG(hw, IGC_EECD);
+	eec = E1000_READ_REG(hw, E1000_EECD);
 
-	if (eec & IGC_EECD_FLASH_DETECTED_I225)
+	if (eec & E1000_EECD_FLASH_DETECTED_I225)
 		ret_val = true;
 
 	return ret_val;
 }
 
-/* igc_set_flsw_flash_burst_counter_i225 - sets FLSW NVM Burst
+/* e1000_set_flsw_flash_burst_counter_i225 - sets FLSW NVM Burst
  * Counter in FLSWCNT register.
  *
  * @hw: pointer to the HW structure
  * @burst_counter: size in bytes of the Flash burst to read or write
  */
-s32 igc_set_flsw_flash_burst_counter_i225(struct igc_hw *hw,
+s32 e1000_set_flsw_flash_burst_counter_i225(struct e1000_hw *hw,
 					    u32 burst_counter)
 {
-	s32 ret_val = IGC_SUCCESS;
+	s32 ret_val = E1000_SUCCESS;
 
-	DEBUGFUNC("igc_set_flsw_flash_burst_counter_i225");
+	DEBUGFUNC("e1000_set_flsw_flash_burst_counter_i225");
 
 	/* Validate input data */
-	if (burst_counter < IGC_I225_SHADOW_RAM_SIZE) {
+	if (burst_counter < E1000_I225_SHADOW_RAM_SIZE) {
 		/* Write FLSWCNT - burst counter */
-		IGC_WRITE_REG(hw, IGC_I225_FLSWCNT, burst_counter);
+		E1000_WRITE_REG(hw, E1000_I225_FLSWCNT, burst_counter);
 	} else {
-		ret_val = IGC_ERR_INVALID_ARGUMENT;
+		ret_val = E1000_ERR_INVALID_ARGUMENT;
 	}
 
 	return ret_val;
 }
 
-/* igc_write_erase_flash_command_i225 - write/erase to a sector
+/* e1000_write_erase_flash_command_i225 - write/erase to a sector
  * region on a given address.
  *
  * @hw: pointer to the HW structure
  * @opcode: opcode to be used for the write command
  * @address: the offset to write into the FLASH image
  */
-s32 igc_write_erase_flash_command_i225(struct igc_hw *hw, u32 opcode,
+s32 e1000_write_erase_flash_command_i225(struct e1000_hw *hw, u32 opcode,
 					 u32 address)
 {
 	u32 flswctl = 0;
-	s32 timeout = IGC_NVM_GRANT_ATTEMPTS;
-	s32 ret_val = IGC_SUCCESS;
+	s32 timeout = E1000_NVM_GRANT_ATTEMPTS;
+	s32 ret_val = E1000_SUCCESS;
 
-	DEBUGFUNC("igc_write_erase_flash_command_i225");
+	DEBUGFUNC("e1000_write_erase_flash_command_i225");
 
-	flswctl = IGC_READ_REG(hw, IGC_I225_FLSWCTL);
+	flswctl = E1000_READ_REG(hw, E1000_I225_FLSWCTL);
 	/* Polling done bit on FLSWCTL register */
 	while (timeout) {
-		if (flswctl & IGC_FLSWCTL_DONE)
+		if (flswctl & E1000_FLSWCTL_DONE)
 			break;
 		usec_delay(5);
-		flswctl = IGC_READ_REG(hw, IGC_I225_FLSWCTL);
+		flswctl = E1000_READ_REG(hw, E1000_I225_FLSWCTL);
 		timeout--;
 	}
 
 	if (!timeout) {
 		DEBUGOUT("Flash transaction was not done\n");
-		return -IGC_ERR_NVM;
+		return -E1000_ERR_NVM;
 	}
 
 	/* Build and issue command on FLSWCTL register */
 	flswctl = address | opcode;
-	IGC_WRITE_REG(hw, IGC_I225_FLSWCTL, flswctl);
+	E1000_WRITE_REG(hw, E1000_I225_FLSWCTL, flswctl);
 
 	/* Check if issued command is valid on FLSWCTL register */
-	flswctl = IGC_READ_REG(hw, IGC_I225_FLSWCTL);
-	if (!(flswctl & IGC_FLSWCTL_CMDV)) {
+	flswctl = E1000_READ_REG(hw, E1000_I225_FLSWCTL);
+	if (!(flswctl & E1000_FLSWCTL_CMDV)) {
 		DEBUGOUT("Write flash command failed\n");
-		ret_val = IGC_ERR_INVALID_ARGUMENT;
+		ret_val = E1000_ERR_INVALID_ARGUMENT;
 	}
 
 	return ret_val;
 }
 
-/* igc_update_flash_i225 - Commit EEPROM to the flash
+/* e1000_update_flash_i225 - Commit EEPROM to the flash
  * if fw_valid_bit is set, FW is active. setting FLUPD bit in EEC
  * register makes the FW load the internal shadow RAM into the flash.
  * Otherwise, fw_valid_bit is 0. if FL_SECU.block_prtotected_sw = 0
@@ -869,7 +869,7 @@ s32 igc_write_erase_flash_command_i225(struct igc_hw *hw, u32 opcode,
  *
  * @hw: pointer to the HW structure
  */
-s32 igc_update_flash_i225(struct igc_hw *hw)
+s32 e1000_update_flash_i225(struct e1000_hw *hw)
 {
 	u16 current_offset_data = 0;
 	u32 block_sw_protect = 1;
@@ -879,24 +879,24 @@ s32 igc_update_flash_i225(struct igc_hw *hw)
 	s32 ret_val = 0;
 	u32 flup;
 
-	DEBUGFUNC("igc_update_flash_i225");
+	DEBUGFUNC("e1000_update_flash_i225");
 
-	block_sw_protect = IGC_READ_REG(hw, IGC_I225_FLSECU) &
-					  IGC_FLSECU_BLK_SW_ACCESS_I225;
-	fw_valid_bit = IGC_READ_REG(hw, IGC_FWSM) &
-				      IGC_FWSM_FW_VALID_I225;
+	block_sw_protect = E1000_READ_REG(hw, E1000_I225_FLSECU) &
+					  E1000_FLSECU_BLK_SW_ACCESS_I225;
+	fw_valid_bit = E1000_READ_REG(hw, E1000_FWSM) &
+				      E1000_FWSM_FW_VALID_I225;
 	if (fw_valid_bit) {
-		ret_val = igc_pool_flash_update_done_i225(hw);
-		if (ret_val == -IGC_ERR_NVM) {
+		ret_val = e1000_pool_flash_update_done_i225(hw);
+		if (ret_val == -E1000_ERR_NVM) {
 			DEBUGOUT("Flash update time out\n");
 			goto out;
 		}
 
-		flup = IGC_READ_REG(hw, IGC_EECD) | IGC_EECD_FLUPD_I225;
-		IGC_WRITE_REG(hw, IGC_EECD, flup);
+		flup = E1000_READ_REG(hw, E1000_EECD) | E1000_EECD_FLUPD_I225;
+		E1000_WRITE_REG(hw, E1000_EECD, flup);
 
-		ret_val = igc_pool_flash_update_done_i225(hw);
-		if (ret_val == IGC_SUCCESS)
+		ret_val = e1000_pool_flash_update_done_i225(hw);
+		if (ret_val == E1000_SUCCESS)
 			DEBUGOUT("Flash update complete\n");
 		else
 			DEBUGOUT("Flash update time out\n");
@@ -907,12 +907,12 @@ s32 igc_update_flash_i225(struct igc_hw *hw)
 		 * base address remains 0x0. otherwise, sector 1 is
 		 * valid and it's base address is 0x1000
 		 */
-		if (IGC_READ_REG(hw, IGC_EECD) & IGC_EECD_SEC1VAL_I225)
+		if (E1000_READ_REG(hw, E1000_EECD) & E1000_EECD_SEC1VAL_I225)
 			base_address = 0x1000;
 
 		/* Valid sector erase */
-		ret_val = igc_write_erase_flash_command_i225(hw,
-						  IGC_I225_ERASE_CMD_OPCODE,
+		ret_val = e1000_write_erase_flash_command_i225(hw,
+						  E1000_I225_ERASE_CMD_OPCODE,
 						  base_address);
 		if (!ret_val) {
 			DEBUGOUT("Sector erase failed\n");
@@ -922,21 +922,21 @@ s32 igc_update_flash_i225(struct igc_hw *hw)
 		current_offset = base_address;
 
 		/* Write */
-		for (i = 0; i < IGC_I225_SHADOW_RAM_SIZE / 2; i++) {
+		for (i = 0; i < E1000_I225_SHADOW_RAM_SIZE / 2; i++) {
 			/* Set burst write length */
-			ret_val = igc_set_flsw_flash_burst_counter_i225(hw,
+			ret_val = e1000_set_flsw_flash_burst_counter_i225(hw,
 									  0x2);
-			if (ret_val != IGC_SUCCESS)
+			if (ret_val != E1000_SUCCESS)
 				break;
 
 			/* Set address and opcode */
-			ret_val = igc_write_erase_flash_command_i225(hw,
-						IGC_I225_WRITE_CMD_OPCODE,
+			ret_val = e1000_write_erase_flash_command_i225(hw,
+						E1000_I225_WRITE_CMD_OPCODE,
 						2 * current_offset);
-			if (ret_val != IGC_SUCCESS)
+			if (ret_val != E1000_SUCCESS)
 				break;
 
-			ret_val = igc_read_nvm_eerd(hw, current_offset,
+			ret_val = e1000_read_nvm_eerd(hw, current_offset,
 						      1, &current_offset_data);
 			if (ret_val) {
 				DEBUGOUT("Failed to read from EEPROM\n");
@@ -944,13 +944,13 @@ s32 igc_update_flash_i225(struct igc_hw *hw)
 			}
 
 			/* Write CurrentOffseData to FLSWDATA register */
-			IGC_WRITE_REG(hw, IGC_I225_FLSWDATA,
+			E1000_WRITE_REG(hw, E1000_I225_FLSWDATA,
 					current_offset_data);
 			current_offset++;
 
 			/* Wait till operation has finished */
-			ret_val = igc_poll_eerd_eewr_done(hw,
-						IGC_NVM_POLL_READ);
+			ret_val = e1000_poll_eerd_eewr_done(hw,
+						E1000_NVM_POLL_READ);
 			if (ret_val)
 				break;
 
@@ -961,20 +961,20 @@ s32 igc_update_flash_i225(struct igc_hw *hw)
 	return ret_val;
 }
 
-/* igc_pool_flash_update_done_i225 - Pool FLUDONE status.
+/* e1000_pool_flash_update_done_i225 - Pool FLUDONE status.
  * @hw: pointer to the HW structure
  */
-s32 igc_pool_flash_update_done_i225(struct igc_hw *hw)
+s32 e1000_pool_flash_update_done_i225(struct e1000_hw *hw)
 {
-	s32 ret_val = -IGC_ERR_NVM;
+	s32 ret_val = -E1000_ERR_NVM;
 	u32 i, reg;
 
-	DEBUGFUNC("igc_pool_flash_update_done_i225");
+	DEBUGFUNC("e1000_pool_flash_update_done_i225");
 
-	for (i = 0; i < IGC_FLUDONE_ATTEMPTS; i++) {
-		reg = IGC_READ_REG(hw, IGC_EECD);
-		if (reg & IGC_EECD_FLUDONE_I225) {
-			ret_val = IGC_SUCCESS;
+	for (i = 0; i < E1000_FLUDONE_ATTEMPTS; i++) {
+		reg = E1000_READ_REG(hw, E1000_EECD);
+		if (reg & E1000_EECD_FLUDONE_I225) {
+			ret_val = E1000_SUCCESS;
 			break;
 		}
 		usec_delay(5);
@@ -983,20 +983,20 @@ s32 igc_pool_flash_update_done_i225(struct igc_hw *hw)
 	return ret_val;
 }
 
-/* igc_set_ltr_i225 - Set Latency Tolerance Reporting thresholds.
+/* e1000_set_ltr_i225 - Set Latency Tolerance Reporting thresholds.
  * @hw: pointer to the HW structure
  * @link: bool indicating link status
  *
  * Set the LTR thresholds based on the link speed (Mbps), EEE, and DMAC
  * settings, otherwise specify that there is no LTR requirement.
  */
-static s32 igc_set_ltr_i225(struct igc_hw *hw, bool link)
+static s32 e1000_set_ltr_i225(struct e1000_hw *hw, bool link)
 {
 	u16 speed, duplex;
 	u32 tw_system, ltrc, ltrv, ltr_min, ltr_max, scale_min, scale_max;
 	s32 size;
 
-	DEBUGFUNC("igc_set_ltr_i225");
+	DEBUGFUNC("e1000_set_ltr_i225");
 
 	/* If we do not have link, LTR thresholds are zero. */
 	if (link) {
@@ -1005,35 +1005,35 @@ static s32 igc_set_ltr_i225(struct igc_hw *hw, bool link)
 		/* Check if using copper interface with EEE enabled or if the
 		 * link speed is 10 Mbps.
 		 */
-		if (hw->phy.media_type == igc_media_type_copper &&
+		if (hw->phy.media_type == e1000_media_type_copper &&
 				!hw->dev_spec._i225.eee_disable &&
 				speed != SPEED_10) {
 			/* EEE enabled, so send LTRMAX threshold. */
-			ltrc = IGC_READ_REG(hw, IGC_LTRC) |
-				IGC_LTRC_EEEMS_EN;
-			IGC_WRITE_REG(hw, IGC_LTRC, ltrc);
+			ltrc = E1000_READ_REG(hw, E1000_LTRC) |
+				E1000_LTRC_EEEMS_EN;
+			E1000_WRITE_REG(hw, E1000_LTRC, ltrc);
 
 			/* Calculate tw_system (nsec). */
 			if (speed == SPEED_100)
-				tw_system = ((IGC_READ_REG(hw, IGC_EEE_SU) &
-					IGC_TW_SYSTEM_100_MASK) >>
-					IGC_TW_SYSTEM_100_SHIFT) * 500;
+				tw_system = ((E1000_READ_REG(hw, E1000_EEE_SU) &
+					E1000_TW_SYSTEM_100_MASK) >>
+					E1000_TW_SYSTEM_100_SHIFT) * 500;
 			else
-				tw_system = (IGC_READ_REG(hw, IGC_EEE_SU) &
-					IGC_TW_SYSTEM_1000_MASK) * 500;
+				tw_system = (E1000_READ_REG(hw, E1000_EEE_SU) &
+					E1000_TW_SYSTEM_1000_MASK) * 500;
 		} else {
 			tw_system = 0;
 		}
 
 		/* Get the Rx packet buffer size. */
-		size = IGC_READ_REG(hw, IGC_RXPBS) &
-			IGC_RXPBS_SIZE_I225_MASK;
+		size = E1000_READ_REG(hw, E1000_RXPBS) &
+			E1000_RXPBS_SIZE_I225_MASK;
 
 		/* Calculations vary based on DMAC settings. */
-		if (IGC_READ_REG(hw, IGC_DMACR) & IGC_DMACR_DMAC_EN) {
-			size -= (IGC_READ_REG(hw, IGC_DMACR) &
-				 IGC_DMACR_DMACTHR_MASK) >>
-				 IGC_DMACR_DMACTHR_SHIFT;
+		if (E1000_READ_REG(hw, E1000_DMACR) & E1000_DMACR_DMAC_EN) {
+			size -= (E1000_READ_REG(hw, E1000_DMACR) &
+				 E1000_DMACR_DMACTHR_MASK) >>
+				 E1000_DMACR_DMACTHR_SHIFT;
 			/* Convert size to bits. */
 			size *= 1024 * 8;
 		} else {
@@ -1048,7 +1048,7 @@ static s32 igc_set_ltr_i225(struct igc_hw *hw, bool link)
 		if (size < 0) {
 			DEBUGOUT1("Invalid effective Rx buffer size %d\n",
 				  size);
-			return -IGC_ERR_CONFIG;
+			return -E1000_ERR_CONFIG;
 		}
 
 		/* Calculate the thresholds. Since speed is in Mbps, simplify
@@ -1058,46 +1058,46 @@ static s32 igc_set_ltr_i225(struct igc_hw *hw, bool link)
 		 */
 		ltr_min = (1000 * size) / speed;
 		ltr_max = ltr_min + tw_system;
-		scale_min = (ltr_min / 1024) < 1024 ? IGC_LTRMINV_SCALE_1024 :
-			    IGC_LTRMINV_SCALE_32768;
-		scale_max = (ltr_max / 1024) < 1024 ? IGC_LTRMAXV_SCALE_1024 :
-			    IGC_LTRMAXV_SCALE_32768;
-		ltr_min /= scale_min == IGC_LTRMINV_SCALE_1024 ? 1024 : 32768;
-		ltr_max /= scale_max == IGC_LTRMAXV_SCALE_1024 ? 1024 : 32768;
+		scale_min = (ltr_min / 1024) < 1024 ? E1000_LTRMINV_SCALE_1024 :
+			    E1000_LTRMINV_SCALE_32768;
+		scale_max = (ltr_max / 1024) < 1024 ? E1000_LTRMAXV_SCALE_1024 :
+			    E1000_LTRMAXV_SCALE_32768;
+		ltr_min /= scale_min == E1000_LTRMINV_SCALE_1024 ? 1024 : 32768;
+		ltr_max /= scale_max == E1000_LTRMAXV_SCALE_1024 ? 1024 : 32768;
 
 		/* Only write the LTR thresholds if they differ from before. */
-		ltrv = IGC_READ_REG(hw, IGC_LTRMINV);
-		if (ltr_min != (ltrv & IGC_LTRMINV_LTRV_MASK)) {
-			ltrv = IGC_LTRMINV_LSNP_REQ | ltr_min |
-			      (scale_min << IGC_LTRMINV_SCALE_SHIFT);
-			IGC_WRITE_REG(hw, IGC_LTRMINV, ltrv);
+		ltrv = E1000_READ_REG(hw, E1000_LTRMINV);
+		if (ltr_min != (ltrv & E1000_LTRMINV_LTRV_MASK)) {
+			ltrv = E1000_LTRMINV_LSNP_REQ | ltr_min |
+			      (scale_min << E1000_LTRMINV_SCALE_SHIFT);
+			E1000_WRITE_REG(hw, E1000_LTRMINV, ltrv);
 		}
 
-		ltrv = IGC_READ_REG(hw, IGC_LTRMAXV);
-		if (ltr_max != (ltrv & IGC_LTRMAXV_LTRV_MASK)) {
-			ltrv = IGC_LTRMAXV_LSNP_REQ | ltr_max |
-			      (scale_min << IGC_LTRMAXV_SCALE_SHIFT);
-			IGC_WRITE_REG(hw, IGC_LTRMAXV, ltrv);
+		ltrv = E1000_READ_REG(hw, E1000_LTRMAXV);
+		if (ltr_max != (ltrv & E1000_LTRMAXV_LTRV_MASK)) {
+			ltrv = E1000_LTRMAXV_LSNP_REQ | ltr_max |
+			      (scale_min << E1000_LTRMAXV_SCALE_SHIFT);
+			E1000_WRITE_REG(hw, E1000_LTRMAXV, ltrv);
 		}
 	}
 
-	return IGC_SUCCESS;
+	return E1000_SUCCESS;
 }
 
-/* igc_check_for_link_i225 - Check for link
+/* e1000_check_for_link_i225 - Check for link
  * @hw: pointer to the HW structure
  *
  * Checks to see of the link status of the hardware has changed.  If a
  * change in link status has been detected, then we read the PHY registers
  * to get the current speed/duplex if link exists.
  */
-s32 igc_check_for_link_i225(struct igc_hw *hw)
+s32 e1000_check_for_link_i225(struct e1000_hw *hw)
 {
-	struct igc_mac_info *mac = &hw->mac;
+	struct e1000_mac_info *mac = &hw->mac;
 	s32 ret_val;
 	bool link = false;
 
-	DEBUGFUNC("igc_check_for_link_i225");
+	DEBUGFUNC("e1000_check_for_link_i225");
 
 	/* We only want to go out to the PHY registers to see if
 	 * Auto-Neg has completed and/or if our link status has
@@ -1105,7 +1105,7 @@ s32 igc_check_for_link_i225(struct igc_hw *hw)
 	 * a Link Status Change or Rx Sequence Error interrupt.
 	 */
 	if (!mac->get_link_status) {
-		ret_val = IGC_SUCCESS;
+		ret_val = E1000_SUCCESS;
 		goto out;
 	}
 
@@ -1113,7 +1113,7 @@ s32 igc_check_for_link_i225(struct igc_hw *hw)
 	 * link.  If so, then we want to get the current speed/duplex
 	 * of the PHY.
 	 */
-	ret_val = igc_phy_has_link_generic(hw, 1, 0, &link);
+	ret_val = e1000_phy_has_link_generic(hw, 1, 0, &link);
 	if (ret_val)
 		goto out;
 
@@ -1125,7 +1125,7 @@ s32 igc_check_for_link_i225(struct igc_hw *hw)
 	/* Check if there was DownShift, must be checked
 	 * immediately after link-up
 	 */
-	igc_check_downshift_generic(hw);
+	e1000_check_downshift_generic(hw);
 
 	/* If we are forcing speed/duplex, then we simply return since
 	 * we have already determined whether we have link or not.
@@ -1144,45 +1144,45 @@ s32 igc_check_for_link_i225(struct igc_hw *hw)
 	 * settings because we may have had to re-autoneg with a
 	 * different link partner.
 	 */
-	ret_val = igc_config_fc_after_link_up_generic(hw);
+	ret_val = e1000_config_fc_after_link_up_generic(hw);
 	if (ret_val)
 		DEBUGOUT("Error configuring flow control\n");
 out:
 	/* Now that we are aware of our link settings, we can set the LTR
 	 * thresholds.
 	 */
-	ret_val = igc_set_ltr_i225(hw, link);
+	ret_val = e1000_set_ltr_i225(hw, link);
 
 	return ret_val;
 }
 
-/* igc_init_function_pointers_i225 - Init func ptrs.
+/* e1000_init_function_pointers_i225 - Init func ptrs.
  * @hw: pointer to the HW structure
  *
  * Called to initialize all function pointers and parameters.
  */
-void igc_init_function_pointers_i225(struct igc_hw *hw)
+void e1000_init_function_pointers_i225(struct e1000_hw *hw)
 {
-	igc_init_mac_ops_generic(hw);
-	igc_init_phy_ops_generic(hw);
-	igc_init_nvm_ops_generic(hw);
-	hw->mac.ops.init_params = igc_init_mac_params_i225;
-	hw->nvm.ops.init_params = igc_init_nvm_params_i225;
-	hw->phy.ops.init_params = igc_init_phy_params_i225;
+	e1000_init_mac_ops_generic(hw);
+	e1000_init_phy_ops_generic(hw);
+	e1000_init_nvm_ops_generic(hw);
+	hw->mac.ops.init_params = e1000_init_mac_params_i225;
+	hw->nvm.ops.init_params = e1000_init_nvm_params_i225;
+	hw->phy.ops.init_params = e1000_init_phy_params_i225;
 }
 
-/* igc_valid_led_default_i225 - Verify a valid default LED config
+/* e1000_valid_led_default_i225 - Verify a valid default LED config
  * @hw: pointer to the HW structure
  * @data: pointer to the NVM (EEPROM)
  *
  * Read the EEPROM for the current default LED configuration.  If the
  * LED configuration is not valid, set to a valid LED configuration.
  */
-static s32 igc_valid_led_default_i225(struct igc_hw *hw, u16 *data)
+static s32 e1000_valid_led_default_i225(struct e1000_hw *hw, u16 *data)
 {
 	s32 ret_val;
 
-	DEBUGFUNC("igc_valid_led_default_i225");
+	DEBUGFUNC("e1000_valid_led_default_i225");
 
 	ret_val = hw->nvm.ops.read(hw, NVM_ID_LED_SETTINGS, 1, data);
 	if (ret_val) {
@@ -1192,10 +1192,10 @@ static s32 igc_valid_led_default_i225(struct igc_hw *hw, u16 *data)
 
 	if (*data == ID_LED_RESERVED_0000 || *data == ID_LED_RESERVED_FFFF) {
 		switch (hw->phy.media_type) {
-		case igc_media_type_internal_serdes:
+		case e1000_media_type_internal_serdes:
 			*data = ID_LED_DEFAULT_I225_SERDES;
 			break;
-		case igc_media_type_copper:
+		case e1000_media_type_copper:
 		default:
 			*data = ID_LED_DEFAULT_I225;
 			break;
@@ -1205,24 +1205,24 @@ static s32 igc_valid_led_default_i225(struct igc_hw *hw, u16 *data)
 	return ret_val;
 }
 
-/* igc_get_cfg_done_i225 - Read config done bit
+/* e1000_get_cfg_done_i225 - Read config done bit
  * @hw: pointer to the HW structure
  *
  * Read the management control register for the config done bit for
  * completion status.  NOTE: silicon which is EEPROM-less will fail trying
  * to read the config done bit, so an error is *ONLY* logged and returns
- * IGC_SUCCESS.  If we were to return with error, EEPROM-less silicon
+ * E1000_SUCCESS.  If we were to return with error, EEPROM-less silicon
  * would not be able to be reset or change link.
  */
-static s32 igc_get_cfg_done_i225(struct igc_hw *hw)
+static s32 e1000_get_cfg_done_i225(struct e1000_hw *hw)
 {
 	s32 timeout = PHY_CFG_TIMEOUT;
-	u32 mask = IGC_NVM_CFG_DONE_PORT_0;
+	u32 mask = E1000_NVM_CFG_DONE_PORT_0;
 
-	DEBUGFUNC("igc_get_cfg_done_i225");
+	DEBUGFUNC("e1000_get_cfg_done_i225");
 
 	while (timeout) {
-		if (IGC_READ_REG(hw, IGC_EEMNGCTL_I225) & mask)
+		if (E1000_READ_REG(hw, E1000_EEMNGCTL_I225) & mask)
 			break;
 		msec_delay(1);
 		timeout--;
@@ -1230,86 +1230,86 @@ static s32 igc_get_cfg_done_i225(struct igc_hw *hw)
 	if (!timeout)
 		DEBUGOUT("MNG configuration cycle has not completed.\n");
 
-	return IGC_SUCCESS;
+	return E1000_SUCCESS;
 }
 
-/* igc_init_hw_i225 - Init hw for I225
+/* e1000_init_hw_i225 - Init hw for I225
  * @hw: pointer to the HW structure
  *
  * Called to initialize hw for i225 hw family.
  */
-s32 igc_init_hw_i225(struct igc_hw *hw)
+s32 e1000_init_hw_i225(struct e1000_hw *hw)
 {
 	s32 ret_val;
 
-	DEBUGFUNC("igc_init_hw_i225");
+	DEBUGFUNC("e1000_init_hw_i225");
 
-	hw->phy.ops.get_cfg_done = igc_get_cfg_done_i225;
-	ret_val = igc_init_hw_base(hw);
-	igc_set_eee_i225(hw, false, false, false);
+	hw->phy.ops.get_cfg_done = e1000_get_cfg_done_i225;
+	ret_val = e1000_init_hw_base(hw);
+	e1000_set_eee_i225(hw, false, false, false);
 	return ret_val;
 }
 
 /*
- * igc_set_d0_lplu_state_i225 - Set Low-Power-Link-Up (LPLU) D0 state
+ * e1000_set_d0_lplu_state_i225 - Set Low-Power-Link-Up (LPLU) D0 state
  * @hw: pointer to the HW structure
  * @active: true to enable LPLU, false to disable
  *
  * Note: since I225 does not actually support LPLU, this function
  * simply enables/disables 1G and 2.5G speeds in D0.
  */
-s32 igc_set_d0_lplu_state_i225(struct igc_hw *hw, bool active)
+s32 e1000_set_d0_lplu_state_i225(struct e1000_hw *hw, bool active)
 {
 	u32 data;
 
-	DEBUGFUNC("igc_set_d0_lplu_state_i225");
+	DEBUGFUNC("e1000_set_d0_lplu_state_i225");
 
-	data = IGC_READ_REG(hw, IGC_I225_PHPM);
+	data = E1000_READ_REG(hw, E1000_I225_PHPM);
 
 	if (active) {
-		data |= IGC_I225_PHPM_DIS_1000;
-		data |= IGC_I225_PHPM_DIS_2500;
+		data |= E1000_I225_PHPM_DIS_1000;
+		data |= E1000_I225_PHPM_DIS_2500;
 	} else {
-		data &= ~IGC_I225_PHPM_DIS_1000;
-		data &= ~IGC_I225_PHPM_DIS_2500;
+		data &= ~E1000_I225_PHPM_DIS_1000;
+		data &= ~E1000_I225_PHPM_DIS_2500;
 	}
 
-	IGC_WRITE_REG(hw, IGC_I225_PHPM, data);
-	return IGC_SUCCESS;
+	E1000_WRITE_REG(hw, E1000_I225_PHPM, data);
+	return E1000_SUCCESS;
 }
 
 /*
- * igc_set_d3_lplu_state_i225 - Set Low-Power-Link-Up (LPLU) D3 state
+ * e1000_set_d3_lplu_state_i225 - Set Low-Power-Link-Up (LPLU) D3 state
  * @hw: pointer to the HW structure
  * @active: true to enable LPLU, false to disable
  *
  * Note: since I225 does not actually support LPLU, this function
  * simply enables/disables 100M, 1G and 2.5G speeds in D3.
  */
-s32 igc_set_d3_lplu_state_i225(struct igc_hw *hw, bool active)
+s32 e1000_set_d3_lplu_state_i225(struct e1000_hw *hw, bool active)
 {
 	u32 data;
 
-	DEBUGFUNC("igc_set_d3_lplu_state_i225");
+	DEBUGFUNC("e1000_set_d3_lplu_state_i225");
 
-	data = IGC_READ_REG(hw, IGC_I225_PHPM);
+	data = E1000_READ_REG(hw, E1000_I225_PHPM);
 
 	if (active) {
-		data |= IGC_I225_PHPM_DIS_100_D3;
-		data |= IGC_I225_PHPM_DIS_1000_D3;
-		data |= IGC_I225_PHPM_DIS_2500_D3;
+		data |= E1000_I225_PHPM_DIS_100_D3;
+		data |= E1000_I225_PHPM_DIS_1000_D3;
+		data |= E1000_I225_PHPM_DIS_2500_D3;
 	} else {
-		data &= ~IGC_I225_PHPM_DIS_100_D3;
-		data &= ~IGC_I225_PHPM_DIS_1000_D3;
-		data &= ~IGC_I225_PHPM_DIS_2500_D3;
+		data &= ~E1000_I225_PHPM_DIS_100_D3;
+		data &= ~E1000_I225_PHPM_DIS_1000_D3;
+		data &= ~E1000_I225_PHPM_DIS_2500_D3;
 	}
 
-	IGC_WRITE_REG(hw, IGC_I225_PHPM, data);
-	return IGC_SUCCESS;
+	E1000_WRITE_REG(hw, E1000_I225_PHPM, data);
+	return E1000_SUCCESS;
 }
 
 /**
- *  igc_set_eee_i225 - Enable/disable EEE support
+ *  e1000_set_eee_i225 - Enable/disable EEE support
  *  @hw: pointer to the HW structure
  *  @adv2p5G: boolean flag enabling 2.5G EEE advertisement
  *  @adv1G: boolean flag enabling 1G EEE advertisement
@@ -1318,55 +1318,55 @@ s32 igc_set_d3_lplu_state_i225(struct igc_hw *hw, bool active)
  *  Enable/disable EEE based on setting in dev_spec structure.
  *
  **/
-s32 igc_set_eee_i225(struct igc_hw *hw, bool adv2p5G, bool adv1G,
+s32 e1000_set_eee_i225(struct e1000_hw *hw, bool adv2p5G, bool adv1G,
 		       bool adv100M)
 {
 	u32 ipcnfg, eeer;
 
-	DEBUGFUNC("igc_set_eee_i225");
+	DEBUGFUNC("e1000_set_eee_i225");
 
-	if (hw->mac.type != igc_i225 ||
-	    hw->phy.media_type != igc_media_type_copper)
+	if (hw->mac.type != e1000_i225 ||
+	    hw->phy.media_type != e1000_media_type_copper)
 		goto out;
-	ipcnfg = IGC_READ_REG(hw, IGC_IPCNFG);
-	eeer = IGC_READ_REG(hw, IGC_EEER);
+	ipcnfg = E1000_READ_REG(hw, E1000_IPCNFG);
+	eeer = E1000_READ_REG(hw, E1000_EEER);
 
 	/* enable or disable per user setting */
 	if (!(hw->dev_spec._i225.eee_disable)) {
-		u32 eee_su = IGC_READ_REG(hw, IGC_EEE_SU);
+		u32 eee_su = E1000_READ_REG(hw, E1000_EEE_SU);
 
 		if (adv100M)
-			ipcnfg |= IGC_IPCNFG_EEE_100M_AN;
+			ipcnfg |= E1000_IPCNFG_EEE_100M_AN;
 		else
-			ipcnfg &= ~IGC_IPCNFG_EEE_100M_AN;
+			ipcnfg &= ~E1000_IPCNFG_EEE_100M_AN;
 
 		if (adv1G)
-			ipcnfg |= IGC_IPCNFG_EEE_1G_AN;
+			ipcnfg |= E1000_IPCNFG_EEE_1G_AN;
 		else
-			ipcnfg &= ~IGC_IPCNFG_EEE_1G_AN;
+			ipcnfg &= ~E1000_IPCNFG_EEE_1G_AN;
 
 		if (adv2p5G)
-			ipcnfg |= IGC_IPCNFG_EEE_2_5G_AN;
+			ipcnfg |= E1000_IPCNFG_EEE_2_5G_AN;
 		else
-			ipcnfg &= ~IGC_IPCNFG_EEE_2_5G_AN;
+			ipcnfg &= ~E1000_IPCNFG_EEE_2_5G_AN;
 
-		eeer |= (IGC_EEER_TX_LPI_EN | IGC_EEER_RX_LPI_EN |
-			IGC_EEER_LPI_FC);
+		eeer |= (E1000_EEER_TX_LPI_EN | E1000_EEER_RX_LPI_EN |
+			E1000_EEER_LPI_FC);
 
 		/* This bit should not be set in normal operation. */
-		if (eee_su & IGC_EEE_SU_LPI_CLK_STP)
+		if (eee_su & E1000_EEE_SU_LPI_CLK_STP)
 			DEBUGOUT("LPI Clock Stop Bit should not be set!\n");
 	} else {
-		ipcnfg &= ~(IGC_IPCNFG_EEE_2_5G_AN | IGC_IPCNFG_EEE_1G_AN |
-			IGC_IPCNFG_EEE_100M_AN);
-		eeer &= ~(IGC_EEER_TX_LPI_EN | IGC_EEER_RX_LPI_EN |
-			IGC_EEER_LPI_FC);
+		ipcnfg &= ~(E1000_IPCNFG_EEE_2_5G_AN | E1000_IPCNFG_EEE_1G_AN |
+			E1000_IPCNFG_EEE_100M_AN);
+		eeer &= ~(E1000_EEER_TX_LPI_EN | E1000_EEER_RX_LPI_EN |
+			E1000_EEER_LPI_FC);
 	}
-	IGC_WRITE_REG(hw, IGC_IPCNFG, ipcnfg);
-	IGC_WRITE_REG(hw, IGC_EEER, eeer);
-	IGC_READ_REG(hw, IGC_IPCNFG);
-	IGC_READ_REG(hw, IGC_EEER);
+	E1000_WRITE_REG(hw, E1000_IPCNFG, ipcnfg);
+	E1000_WRITE_REG(hw, E1000_EEER, eeer);
+	E1000_READ_REG(hw, E1000_IPCNFG);
+	E1000_READ_REG(hw, E1000_EEER);
 out:
 
-	return IGC_SUCCESS;
+	return E1000_SUCCESS;
 }
diff --git a/drivers/net/intel/e1000/base/e1000_i225.h b/drivers/net/intel/e1000/base/e1000_i225.h
new file mode 100644
index 0000000000..b0414b6a36
--- /dev/null
+++ b/drivers/net/intel/e1000/base/e1000_i225.h
@@ -0,0 +1,110 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2001-2020 Intel Corporation
+ */
+
+#ifndef _E1000_I225_H_
+#define _E1000_I225_H_
+
+bool e1000_get_flash_presence_i225(struct e1000_hw *hw);
+s32 e1000_update_flash_i225(struct e1000_hw *hw);
+s32 e1000_update_nvm_checksum_i225(struct e1000_hw *hw);
+s32 e1000_validate_nvm_checksum_i225(struct e1000_hw *hw);
+s32 e1000_write_nvm_srwr_i225(struct e1000_hw *hw, u16 offset,
+			      u16 words, u16 *data);
+s32 e1000_read_nvm_srrd_i225(struct e1000_hw *hw, u16 offset,
+			     u16 words, u16 *data);
+s32 e1000_read_invm_version_i225(struct e1000_hw *hw,
+				 struct e1000_fw_version *invm_ver);
+s32 e1000_set_flsw_flash_burst_counter_i225(struct e1000_hw *hw,
+					    u32 burst_counter);
+s32 e1000_write_erase_flash_command_i225(struct e1000_hw *hw, u32 opcode,
+					 u32 address);
+s32 e1000_check_for_link_i225(struct e1000_hw *hw);
+s32 e1000_acquire_swfw_sync_i225(struct e1000_hw *hw, u16 mask);
+void e1000_release_swfw_sync_i225(struct e1000_hw *hw, u16 mask);
+s32 e1000_init_hw_i225(struct e1000_hw *hw);
+s32 e1000_setup_copper_link_i225(struct e1000_hw *hw);
+s32 e1000_set_d0_lplu_state_i225(struct e1000_hw *hw, bool active);
+s32 e1000_set_d3_lplu_state_i225(struct e1000_hw *hw, bool active);
+s32 e1000_set_eee_i225(struct e1000_hw *hw, bool adv2p5G, bool adv1G,
+		       bool adv100M);
+
+#define ID_LED_DEFAULT_I225		((ID_LED_OFF1_ON2  << 8) | \
+					 (ID_LED_DEF1_DEF2 <<  4) | \
+					 (ID_LED_OFF1_OFF2))
+#define ID_LED_DEFAULT_I225_SERDES	((ID_LED_DEF1_DEF2 << 8) | \
+					 (ID_LED_DEF1_DEF2 <<  4) | \
+					 (ID_LED_OFF1_ON2))
+
+/* NVM offset defaults for I225 devices */
+#define NVM_INIT_CTRL_2_DEFAULT_I225	0X7243
+#define NVM_INIT_CTRL_4_DEFAULT_I225	0x00C1
+#define NVM_LED_1_CFG_DEFAULT_I225	0x0184
+#define NVM_LED_0_2_CFG_DEFAULT_I225	0x200C
+
+#define E1000_MRQC_ENABLE_RSS_4Q		0x00000002
+#define E1000_MRQC_ENABLE_VMDQ			0x00000003
+#define E1000_MRQC_ENABLE_VMDQ_RSS_2Q		0x00000005
+#define E1000_MRQC_RSS_FIELD_IPV4_UDP		0x00400000
+#define E1000_MRQC_RSS_FIELD_IPV6_UDP		0x00800000
+#define E1000_MRQC_RSS_FIELD_IPV6_UDP_EX	0x01000000
+#define E1000_I225_SHADOW_RAM_SIZE		4096
+#define E1000_I225_ERASE_CMD_OPCODE		0x02000000
+#define E1000_I225_WRITE_CMD_OPCODE		0x01000000
+#define E1000_FLSWCTL_DONE			0x40000000
+#define E1000_FLSWCTL_CMDV			0x10000000
+
+/* SRRCTL bit definitions */
+#define E1000_SRRCTL_BSIZEHDRSIZE_MASK		0x00000F00
+#define E1000_SRRCTL_DESCTYPE_LEGACY		0x00000000
+#define E1000_SRRCTL_DESCTYPE_HDR_SPLIT		0x04000000
+#define E1000_SRRCTL_DESCTYPE_HDR_SPLIT_ALWAYS	0x0A000000
+#define E1000_SRRCTL_DESCTYPE_HDR_REPLICATION	0x06000000
+#define E1000_SRRCTL_DESCTYPE_HDR_REPLICATION_LARGE_PKT 0x08000000
+#define E1000_SRRCTL_DESCTYPE_MASK		0x0E000000
+#define E1000_SRRCTL_DROP_EN			0x80000000
+#define E1000_SRRCTL_BSIZEPKT_MASK		0x0000007F
+#define E1000_SRRCTL_BSIZEHDR_MASK		0x00003F00
+
+#define E1000_RXDADV_RSSTYPE_MASK	0x0000000F
+#define E1000_RXDADV_RSSTYPE_SHIFT	12
+#define E1000_RXDADV_HDRBUFLEN_MASK	0x7FE0
+#define E1000_RXDADV_HDRBUFLEN_SHIFT	5
+#define E1000_RXDADV_SPLITHEADER_EN	0x00001000
+#define E1000_RXDADV_SPH		0x8000
+#define E1000_RXDADV_STAT_TS		0x10000 /* Pkt was time stamped */
+#define E1000_RXDADV_ERR_HBO		0x00800000
+
+/* RSS Hash results */
+#define E1000_RXDADV_RSSTYPE_NONE	0x00000000
+#define E1000_RXDADV_RSSTYPE_IPV4_TCP	0x00000001
+#define E1000_RXDADV_RSSTYPE_IPV4	0x00000002
+#define E1000_RXDADV_RSSTYPE_IPV6_TCP	0x00000003
+#define E1000_RXDADV_RSSTYPE_IPV6_EX	0x00000004
+#define E1000_RXDADV_RSSTYPE_IPV6	0x00000005
+#define E1000_RXDADV_RSSTYPE_IPV6_TCP_EX 0x00000006
+#define E1000_RXDADV_RSSTYPE_IPV4_UDP	0x00000007
+#define E1000_RXDADV_RSSTYPE_IPV6_UDP	0x00000008
+#define E1000_RXDADV_RSSTYPE_IPV6_UDP_EX 0x00000009
+
+/* RSS Packet Types as indicated in the receive descriptor */
+#define E1000_RXDADV_PKTTYPE_ILMASK	0x000000F0
+#define E1000_RXDADV_PKTTYPE_TLMASK	0x00000F00
+#define E1000_RXDADV_PKTTYPE_NONE	0x00000000
+#define E1000_RXDADV_PKTTYPE_IPV4	0x00000010 /* IPV4 hdr present */
+#define E1000_RXDADV_PKTTYPE_IPV4_EX	0x00000020 /* IPV4 hdr + extensions */
+#define E1000_RXDADV_PKTTYPE_IPV6	0x00000040 /* IPV6 hdr present */
+#define E1000_RXDADV_PKTTYPE_IPV6_EX	0x00000080 /* IPV6 hdr + extensions */
+#define E1000_RXDADV_PKTTYPE_TCP	0x00000100 /* TCP hdr present */
+#define E1000_RXDADV_PKTTYPE_UDP	0x00000200 /* UDP hdr present */
+#define E1000_RXDADV_PKTTYPE_SCTP	0x00000400 /* SCTP hdr present */
+#define E1000_RXDADV_PKTTYPE_NFS	0x00000800 /* NFS hdr present */
+
+#define E1000_RXDADV_PKTTYPE_IPSEC_ESP	0x00001000 /* IPSec ESP */
+#define E1000_RXDADV_PKTTYPE_IPSEC_AH	0x00002000 /* IPSec AH */
+#define E1000_RXDADV_PKTTYPE_LINKSEC	0x00004000 /* LinkSec Encap */
+#define E1000_RXDADV_PKTTYPE_ETQF	0x00008000 /* PKTTYPE is ETQF index */
+#define E1000_RXDADV_PKTTYPE_ETQF_MASK	0x00000070 /* ETQF has 8 indices */
+#define E1000_RXDADV_PKTTYPE_ETQF_SHIFT	4 /* Right-shift 4 bits */
+
+#endif
diff --git a/drivers/net/intel/e1000/base/e1000_mac.c b/drivers/net/intel/e1000/base/e1000_mac.c
index d3b3a6bac9..02e03bed1f 100644
--- a/drivers/net/intel/e1000/base/e1000_mac.c
+++ b/drivers/net/intel/e1000/base/e1000_mac.c
@@ -987,9 +987,13 @@ s32 e1000_setup_link_generic(struct e1000_hw *hw)
 	 * based on the EEPROM flow control settings.
 	 */
 	if (hw->fc.requested_mode == e1000_fc_default) {
-		ret_val = e1000_set_default_fc_generic(hw);
-		if (ret_val)
-			return ret_val;
+		if (hw->mac.type == e1000_i225) {
+			hw->fc.requested_mode = e1000_fc_full;
+		} else {
+			ret_val = e1000_set_default_fc_generic(hw);
+			if (ret_val)
+				return ret_val;
+		}
 	}
 
 	/* Save off the requested flow control mode for use later.  Depending
@@ -1637,8 +1641,18 @@ s32 e1000_get_speed_and_duplex_copper_generic(struct e1000_hw *hw, u16 *speed,
 
 	status = E1000_READ_REG(hw, E1000_STATUS);
 	if (status & E1000_STATUS_SPEED_1000) {
-		*speed = SPEED_1000;
-		DEBUGOUT("1000 Mbs, ");
+		/* For I225, STATUS will indicate 1G speed in both 1 Gbps
+		 * and 2.5 Gbps link modes. An additional bit is used
+		 * to differentiate between 1 Gbps and 2.5 Gbps.
+		 */
+		if (hw->mac.type == e1000_i225 &&
+		    (status & E1000_STATUS_SPEED_2500)) {
+			*speed = SPEED_2500;
+			DEBUGOUT("2500 Mbs, ");
+		} else {
+			*speed = SPEED_1000;
+			DEBUGOUT("1000 Mbs, ");
+		}
 	} else if (status & E1000_STATUS_SPEED_100) {
 		*speed = SPEED_100;
 		DEBUGOUT("100 Mbs, ");
diff --git a/drivers/net/intel/e1000/base/e1000_nvm.c b/drivers/net/intel/e1000/base/e1000_nvm.c
index 430fecaf6d..aec5e80986 100644
--- a/drivers/net/intel/e1000/base/e1000_nvm.c
+++ b/drivers/net/intel/e1000/base/e1000_nvm.c
@@ -1295,6 +1295,7 @@ void e1000_get_fw_version(struct e1000_hw *hw, struct e1000_fw_version *fw_vers)
 			return;
 		}
 		/* fall through */
+	case e1000_i225:
 	case e1000_i350:
 		hw->nvm.ops.read(hw, NVM_ETRACK_HIWORD, 1, &etrack_test);
 		/* find combo image version */
diff --git a/drivers/net/intel/e1000/base/e1000_osdep.h b/drivers/net/intel/e1000/base/e1000_osdep.h
index 46565d05e7..0cf6da1545 100644
--- a/drivers/net/intel/e1000/base/e1000_osdep.h
+++ b/drivers/net/intel/e1000/base/e1000_osdep.h
@@ -117,9 +117,15 @@ static inline uint16_t e1000_read_addr16(volatile void *addr)
 #define E1000_READ_REG(hw, reg) \
 	e1000_read_addr(E1000_PCI_REG_ADDR((hw), (reg)))
 
+#define E1000_READ_REG_LE_VALUE(hw, reg) \
+	rte_read32(E1000_PCI_REG_ADDR((hw), (reg)))
+
 #define E1000_WRITE_REG(hw, reg, value) \
 	E1000_PCI_REG_WRITE(E1000_PCI_REG_ADDR((hw), (reg)), (value))
 
+#define E1000_WRITE_REG_LE_VALUE(hw, reg, value) \
+	rte_write32(value, E1000_PCI_REG_ADDR((hw), (reg)))
+
 #define E1000_READ_REG_ARRAY(hw, reg, index) \
 	E1000_PCI_REG(E1000_PCI_REG_ARRAY_ADDR((hw), (reg), (index)))
 
diff --git a/drivers/net/intel/e1000/base/e1000_phy.c b/drivers/net/intel/e1000/base/e1000_phy.c
index 62d0be5080..ed3fc24365 100644
--- a/drivers/net/intel/e1000/base/e1000_phy.c
+++ b/drivers/net/intel/e1000/base/e1000_phy.c
@@ -1457,6 +1457,7 @@ s32 e1000_phy_setup_autoneg(struct e1000_hw *hw)
 	s32 ret_val;
 	u16 mii_autoneg_adv_reg;
 	u16 mii_1000t_ctrl_reg = 0;
+	u16 aneg_multigbt_an_ctrl = 0;
 
 	DEBUGFUNC("e1000_phy_setup_autoneg");
 
@@ -1475,6 +1476,32 @@ s32 e1000_phy_setup_autoneg(struct e1000_hw *hw)
 			return ret_val;
 	}
 
+	/*
+	 * IGC/IGB merge note: in base code, there was a PHY ID check for I225
+	 * at this point. However, in DPDK version of IGC this check was
+	 * removed because it interfered with some i225-based NICs, and it was
+	 * deemed unnecessary because only the i225 NIC would've called this
+	 * code anyway because it was in the IGC driver.
+	 *
+	 * In IGB, it is no longer the case that this code is only called by
+	 * i225 NICs, so it could be argued that the check should've been added
+	 * back. However, as evidenced in the original commit removing the
+	 * check, the removal was causing problems with some i225-based NICs,
+	 * adding it back would've introduced the issue again. It is assumed
+	 * that only i225 will attempt to advertise 2.5G speed anyway, so it is
+	 * hoped that not adding the check will not cause problems.
+	 */
+	if (phy->autoneg_mask & ADVERTISE_2500_FULL) {
+	/* Read the MULTI GBT AN Control Register - reg 7.32 */
+		ret_val = phy->ops.read_reg(hw, (STANDARD_AN_REG_MASK <<
+					    MMD_DEVADDR_SHIFT) |
+					    ANEG_MULTIGBT_AN_CTRL,
+					    &aneg_multigbt_an_ctrl);
+
+		if (ret_val)
+			return ret_val;
+	}
+
 	/* Need to parse both autoneg_advertised and fc and set up
 	 * the appropriate PHY registers.  First we will parse for
 	 * autoneg_advertised software override.  Since we can advertise
@@ -1528,6 +1555,18 @@ s32 e1000_phy_setup_autoneg(struct e1000_hw *hw)
 		mii_1000t_ctrl_reg |= CR_1000T_FD_CAPS;
 	}
 
+	/* We do not allow the Phy to advertise 2500 Mb Half Duplex */
+	if (phy->autoneg_advertised & ADVERTISE_2500_HALF)
+		DEBUGOUT("Advertise 2500mb Half duplex request denied!\n");
+
+	/* Do we want to advertise 2500 Mb Full Duplex? */
+	if (phy->autoneg_advertised & ADVERTISE_2500_FULL) {
+		DEBUGOUT("Advertise 2500mb Full duplex\n");
+		aneg_multigbt_an_ctrl |= CR_2500T_FD_CAPS;
+	} else {
+		aneg_multigbt_an_ctrl &= ~CR_2500T_FD_CAPS;
+	}
+
 	/* Check for a software override of the flow control settings, and
 	 * setup the PHY advertisement registers accordingly.  If
 	 * auto-negotiation is enabled, then software will have to set the
@@ -1592,6 +1631,28 @@ s32 e1000_phy_setup_autoneg(struct e1000_hw *hw)
 		ret_val = phy->ops.write_reg(hw, PHY_1000T_CTRL,
 					     mii_1000t_ctrl_reg);
 
+	/*
+	 * IGC/IGB merge note: in base code, there was a PHY ID check for I225
+	 * at this point. However, in DPDK version of IGC this check was
+	 * removed because it interfered with some i225-based NICs, and it was
+	 * deemed unnecessary because only the i225 NIC would've called this
+	 * code anyway because it was in the IGC driver.
+	 *
+	 * In IGB, it is no longer the case that this code is only called by
+	 * i225 NICs, so it could be argued that the check should've been added
+	 * back. However, as evidenced in the original commit removing the
+	 * check, the removal was causing problems with some i225-based NICs,
+	 * adding it back would've introduced the issue again. It is assumed
+	 * that only i225 will attempt to advertise 2.5G speed anyway, so it is
+	 * hoped that not adding the check will not cause problems.
+	 */
+	if (phy->autoneg_mask & ADVERTISE_2500_FULL)
+		ret_val = phy->ops.write_reg(hw,
+					     (STANDARD_AN_REG_MASK <<
+					     MMD_DEVADDR_SHIFT) |
+					     ANEG_MULTIGBT_AN_CTRL,
+					     aneg_multigbt_an_ctrl);
+
 	return ret_val;
 }
 
@@ -1848,6 +1909,7 @@ s32 e1000_phy_force_speed_duplex_m88(struct e1000_hw *hw)
 			case M88E1543_E_PHY_ID:
 			case M88E1512_E_PHY_ID:
 			case I210_I_PHY_ID:
+			case I225_I_PHY_ID:
 				reset_dsp = false;
 				break;
 			default:
@@ -1889,6 +1951,8 @@ s32 e1000_phy_force_speed_duplex_m88(struct e1000_hw *hw)
 		return E1000_SUCCESS;
 	if (hw->phy.id == I210_I_PHY_ID)
 		return E1000_SUCCESS;
+	if (hw->phy.id == I225_I_PHY_ID)
+		return E1000_SUCCESS;
 	if ((hw->phy.id == M88E1543_E_PHY_ID) ||
 	    (hw->phy.id == M88E1512_E_PHY_ID))
 		return E1000_SUCCESS;
@@ -2416,7 +2480,7 @@ s32 e1000_get_cable_length_m88(struct e1000_hw *hw)
 s32 e1000_get_cable_length_m88_gen2(struct e1000_hw *hw)
 {
 	struct e1000_phy_info *phy = &hw->phy;
-	s32 ret_val;
+	s32 ret_val  = 0;
 	u16 phy_data, phy_data2, is_cm;
 	u16 index, default_page;
 
@@ -2444,6 +2508,8 @@ s32 e1000_get_cable_length_m88_gen2(struct e1000_hw *hw)
 		phy->max_cable_length = phy_data / (is_cm ? 100 : 1);
 		phy->cable_length = phy_data / (is_cm ? 100 : 1);
 		break;
+	case I225_I_PHY_ID:
+		break;
 	case M88E1543_E_PHY_ID:
 	case M88E1512_E_PHY_ID:
 	case M88E1340M_E_PHY_ID:
@@ -3023,6 +3089,9 @@ enum e1000_phy_type e1000_get_phy_type_from_id(u32 phy_id)
 	case I210_I_PHY_ID:
 		phy_type = e1000_phy_i210;
 		break;
+	case I225_I_PHY_ID:
+		phy_type = e1000_phy_i225;
+		break;
 	default:
 		phy_type = e1000_phy_unknown;
 		break;
@@ -3890,7 +3959,7 @@ s32 e1000_phy_force_speed_duplex_82577(struct e1000_hw *hw)
 	struct e1000_phy_info *phy = &hw->phy;
 	s32 ret_val;
 	u16 phy_data;
-	bool link;
+	bool link = false;
 
 	DEBUGFUNC("e1000_phy_force_speed_duplex_82577");
 
@@ -4083,6 +4152,73 @@ s32 e1000_read_phy_reg_gs40g(struct e1000_hw *hw, u32 offset, u16 *data)
 	return ret_val;
 }
 
+/**
+ *  e1000_write_phy_reg_gpy - Write GPY PHY register
+ *  @hw: pointer to the HW structure
+ *  @offset: register offset to write to
+ *  @data: data to write at register offset
+ *
+ *  Acquires semaphore, if necessary, then writes the data to PHY register
+ *  at the offset.  Release any acquired semaphores before exiting.
+ **/
+s32 e1000_write_phy_reg_gpy(struct e1000_hw *hw, u32 offset, u16 data)
+{
+	s32 ret_val;
+	u8 dev_addr = (offset & GPY_MMD_MASK) >> GPY_MMD_SHIFT;
+
+	DEBUGFUNC("e1000_write_phy_reg_gpy");
+
+	offset = offset & GPY_REG_MASK;
+
+	if (!dev_addr) {
+		ret_val = hw->phy.ops.acquire(hw);
+		if (ret_val)
+			return ret_val;
+		ret_val = e1000_write_phy_reg_mdic(hw, offset, data);
+		if (ret_val)
+			return ret_val;
+		hw->phy.ops.release(hw);
+	} else {
+		ret_val = e1000_write_xmdio_reg(hw, (u16)offset, dev_addr,
+						data);
+	}
+	return ret_val;
+}
+
+/**
+ *  e1000_read_phy_reg_gpy - Read GPY PHY register
+ *  @hw: pointer to the HW structure
+ *  @offset: lower half is register offset to read to
+ *     upper half is MMD to use.
+ *  @data: data to read at register offset
+ *
+ *  Acquires semaphore, if necessary, then reads the data in the PHY register
+ *  at the offset.  Release any acquired semaphores before exiting.
+ **/
+s32 e1000_read_phy_reg_gpy(struct e1000_hw *hw, u32 offset, u16 *data)
+{
+	s32 ret_val;
+	u8 dev_addr = (offset & GPY_MMD_MASK) >> GPY_MMD_SHIFT;
+
+	DEBUGFUNC("e1000_read_phy_reg_gpy");
+
+	offset = offset & GPY_REG_MASK;
+
+	if (!dev_addr) {
+		ret_val = hw->phy.ops.acquire(hw);
+		if (ret_val)
+			return ret_val;
+		ret_val = e1000_read_phy_reg_mdic(hw, offset, data);
+		if (ret_val)
+			return ret_val;
+		hw->phy.ops.release(hw);
+	} else {
+		ret_val = e1000_read_xmdio_reg(hw, (u16)offset, dev_addr,
+					       data);
+	}
+	return ret_val;
+}
+
 /**
  *  e1000_read_phy_reg_mphy - Read mPHY control register
  *  @hw: pointer to the HW structure
diff --git a/drivers/net/intel/e1000/base/e1000_phy.h b/drivers/net/intel/e1000/base/e1000_phy.h
index 81c5308589..a7834240e0 100644
--- a/drivers/net/intel/e1000/base/e1000_phy.h
+++ b/drivers/net/intel/e1000/base/e1000_phy.h
@@ -86,6 +86,8 @@ s32  e1000_phy_force_speed_duplex_82577(struct e1000_hw *hw);
 s32  e1000_get_cable_length_82577(struct e1000_hw *hw);
 s32  e1000_write_phy_reg_gs40g(struct e1000_hw *hw, u32 offset, u16 data);
 s32  e1000_read_phy_reg_gs40g(struct e1000_hw *hw, u32 offset, u16 *data);
+s32  e1000_write_phy_reg_gpy(struct e1000_hw *hw, u32 offset, u16 data);
+s32  e1000_read_phy_reg_gpy(struct e1000_hw *hw, u32 offset, u16 *data);
 s32 e1000_read_phy_reg_mphy(struct e1000_hw *hw, u32 address, u32 *data);
 s32 e1000_write_phy_reg_mphy(struct e1000_hw *hw, u32 address, u32 data,
 			     bool line_override);
@@ -120,6 +122,21 @@ s32 e1000_write_xmdio_reg(struct e1000_hw *hw, u16 addr, u8 dev_addr,
 #define GS40G_MAC_SPEED_1G		0X0006
 #define GS40G_COPPER_SPEC		0x0010
 
+#define E1000_I225_PHPM			0x0E14 /* I225 PHY Power Management */
+#define E1000_I225_PHPM_DIS_1000_D3	0x0008 /* Disable 1G in D3 */
+#define E1000_I225_PHPM_LINK_ENERGY	0x0010 /* Link Energy Detect */
+#define E1000_I225_PHPM_GO_LINKD	0x0020 /* Go Link Disconnect */
+#define E1000_I225_PHPM_DIS_1000	0x0040 /* Disable 1G globally */
+#define E1000_I225_PHPM_SPD_B2B_EN	0x0080 /* Smart Power Down Back2Back */
+#define E1000_I225_PHPM_RST_COMPL	0x0100 /* PHY Reset Completed */
+#define E1000_I225_PHPM_DIS_100_D3	0x0200 /* Disable 100M in D3 */
+#define E1000_I225_PHPM_ULP		0x0400 /* Ultra Low-Power Mode */
+#define E1000_I225_PHPM_DIS_2500	0x0800 /* Disable 2.5G globally */
+#define E1000_I225_PHPM_DIS_2500_D3	0x1000 /* Disable 2.5G in D3 */
+/* GPY211 - I225 defines */
+#define GPY_MMD_MASK			0xFFFF0000
+#define GPY_MMD_SHIFT			16
+#define GPY_REG_MASK			0x0000FFFF
 /* BM/HV Specific Registers */
 #define BM_PORT_CTRL_PAGE		769
 #define BM_WUC_PAGE			800
diff --git a/drivers/net/intel/e1000/base/e1000_regs.h b/drivers/net/intel/e1000/base/e1000_regs.h
index 092d9d71e6..32acbb4789 100644
--- a/drivers/net/intel/e1000/base/e1000_regs.h
+++ b/drivers/net/intel/e1000/base/e1000_regs.h
@@ -30,6 +30,10 @@
 #define E1000_FCAL	0x00028  /* Flow Control Address Low - RW */
 #define E1000_FCAH	0x0002C  /* Flow Control Address High -RW */
 #define E1000_FEXT	0x0002C  /* Future Extended - RW */
+#define E1000_I225_FLSWCTL	0x12048 /* FLASH control register */
+#define E1000_I225_FLSWDATA	0x1204C /* FLASH data register */
+#define E1000_I225_FLSWCNT	0x12050 /* FLASH Access Counter */
+#define E1000_I225_FLSECU	0x12114 /* FLASH Security */
 #define E1000_FEXTNVM	0x00028  /* Future Extended NVM - RW */
 #define E1000_FEXTNVM3	0x0003C  /* Future Extended NVM 3 - RW */
 #define E1000_FEXTNVM4	0x00024  /* Future Extended NVM 4 - RW */
@@ -87,8 +91,10 @@
 #define E1000_IOSFPC	0x00F28  /* TX corrupted data  */
 #define E1000_EEMNGCTL	0x01010  /* MNG EEprom Control */
 #define E1000_EEMNGCTL_I210	0x01010  /* i210 MNG EEprom Mode Control */
+#define E1000_EEMNGCTL_I225	0x01010  /* i225 MNG EEprom Mode Control */
 #define E1000_EEARBC	0x01024  /* EEPROM Auto Read Bus Control */
 #define E1000_EEARBC_I210	0x12024 /* EEPROM Auto Read Bus Control */
+#define E1000_EEARBC_I225	0x12024 /* EEPROM Auto Read Bus Control */
 #define E1000_FLASHT	0x01028  /* FLASH Timer Register */
 #define E1000_EEWR	0x0102C  /* EEPROM Write Register - RW */
 #define E1000_FLSWCTL	0x01030  /* FLASH control register */
@@ -261,6 +267,9 @@
 				 (0x054E0 + ((_i - 16) * 8)))
 #define E1000_RAH(_i)		(((_i) <= 15) ? (0x05404 + ((_i) * 8)) : \
 				 (0x054E4 + ((_i - 16) * 8)))
+
+#define E1000_VLAPQF		0x055B0  /* VLAN Priority Queue Filter VLAPQF */
+
 #define E1000_SHRAL(_i)		(0x05438 + ((_i) * 8))
 #define E1000_SHRAH(_i)		(0x0543C + ((_i) * 8))
 #define E1000_IP4AT_REG(_i)	(0x05840 + ((_i) * 8))
@@ -482,6 +491,17 @@
 #define E1000_IP6AT	0x05880  /* IPv6 Address Table - RW Array */
 #define E1000_WUPL	0x05900  /* Wakeup Packet Length - RW */
 #define E1000_WUPM	0x05A00  /* Wakeup Packet Memory - RO A */
+#define E1000_WUPM_EXT	0x0B800  /* Wakeup Packet Memory Extended - RO Array */
+#define E1000_WUFC_EXT	0x0580C  /* Wakeup Filter Control Extended - RW */
+#define E1000_WUS_EXT	0x05814  /* Wakeup Status Extended - RW1C */
+#define E1000_FHFTSL	0x05804  /* Flex Filter Indirect Table Select - RW */
+#define E1000_PROXYFCEX	0x05590  /* Proxy Filter Control Extended - RW1C */
+#define E1000_PROXYEXS	0x05594  /* Proxy Extended Status - RO */
+#define E1000_WFUTPF	0x05500  /* Wake Flex UDP TCP Port Filter - RW Array */
+#define E1000_RFUTPF	0x05580  /* Range Flex UDP TCP Port Filter - RW */
+#define E1000_RWPFC	0x05584  /* Range Wake Port Filter Control - RW */
+#define E1000_WFUTPS	0x05588  /* Wake Filter UDP TCP Status - RW1C */
+#define E1000_WCS	0x0558C  /* Wake Control Status - RW1C */
 /* MSI-X Table Register Descriptions */
 #define E1000_PBACL	0x05B68  /* MSIx PBA Clear - Read/Write 1's to clear */
 #define E1000_FFLT	0x05F00  /* Flexible Filter Length Table - RW Array */
@@ -593,6 +613,14 @@
 #define E1000_RXMTRL	0x0B634 /* Time sync Rx EtherType and Msg Type - RW */
 #define E1000_RXUDP	0x0B638 /* Time Sync Rx UDP Port - RW */
 
+#define E1000_QBVCYCLET	0x331C
+#define E1000_QBVCYCLET_S 0x3320
+#define E1000_STQT(_n)	(0x3324 + 0x4 * (_n))
+#define E1000_ENDQT(_n)	(0x3334 + 0x4 * (_n))
+#define E1000_TXQCTL(_n)	(0x3344 + 0x4 * (_n))
+#define E1000_BASET_L	0x3314
+#define E1000_BASET_H	0x3318
+
 /* Filtering Registers */
 #define E1000_SAQF(_n)	(0x05980 + (4 * (_n))) /* Source Address Queue Fltr */
 #define E1000_DAQF(_n)	(0x059A0 + (4 * (_n))) /* Dest Address Queue Fltr */
@@ -678,6 +706,7 @@
 #define E1000_LTRC	0x01A0 /* Latency Tolerance Reporting Control */
 #define E1000_EEER	0x0E30 /* Energy Efficient Ethernet "EEE"*/
 #define E1000_EEE_SU	0x0E34 /* EEE Setup */
+#define E1000_EEE_SU_2P5	0x0E3C /* EEE 2.5G Setup */
 #define E1000_TLPIC	0x4148 /* EEE Tx LPI Count - TLPIC */
 #define E1000_RLPIC	0x414C /* EEE Rx LPI Count - RLPIC */
 
@@ -687,6 +716,36 @@
 #define E1000_O2BGPTC	0x08FE4 /* OS2BMC packets received by BMC */
 #define E1000_O2BSPC	0x0415C /* OS2BMC packets transmitted by host */
 
+#define E1000_LTRMINV	0x5BB0 /* LTR Minimum Value */
+#define E1000_LTRMAXV	0x5BB4 /* LTR Maximum Value */
 
 
+/* IEEE 1588 TIMESYNCH */
+#define E1000_TRGTTIML0	0x0B644 /* Target Time Register 0 Low  - RW */
+#define E1000_TRGTTIMH0	0x0B648 /* Target Time Register 0 High - RW */
+#define E1000_TRGTTIML1	0x0B64C /* Target Time Register 1 Low  - RW */
+#define E1000_TRGTTIMH1	0x0B650 /* Target Time Register 1 High - RW */
+#define E1000_FREQOUT0	0x0B654 /* Frequency Out 0 Control Register - RW */
+#define E1000_FREQOUT1	0x0B658 /* Frequency Out 1 Control Register - RW */
+#define E1000_TSSDP	0x0003C  /* Time Sync SDP Configuration Register - RW */
+
+#define E1000_LTRC_EEEMS_EN			(1 << 5)
+#define E1000_TW_SYSTEM_100_MASK		0xff00
+#define E1000_TW_SYSTEM_100_SHIFT	8
+#define E1000_TW_SYSTEM_1000_MASK	0xff
+#define E1000_LTRMINV_SCALE_1024		0x02
+#define E1000_LTRMINV_SCALE_32768	0x03
+#define E1000_LTRMAXV_SCALE_1024		0x02
+#define E1000_LTRMAXV_SCALE_32768	0x03
+#define E1000_LTRMINV_LTRV_MASK		0x1ff
+#define E1000_LTRMINV_LSNP_REQ		0x80
+#define E1000_LTRMINV_SCALE_SHIFT	10
+#define E1000_LTRMAXV_LTRV_MASK		0x1ff
+#define E1000_LTRMAXV_LSNP_REQ		0x80
+#define E1000_LTRMAXV_SCALE_SHIFT	10
+
+#define E1000_MRQC_ENABLE_MASK		0x00000007
+#define E1000_MRQC_RSS_FIELD_IPV6_EX	0x00080000
+#define E1000_RCTL_DTYP_MASK		0x00000C00 /* Descriptor type mask */
+
 #endif
diff --git a/drivers/net/intel/e1000/base/meson.build b/drivers/net/intel/e1000/base/meson.build
index e73f3d6d55..033b3af2e2 100644
--- a/drivers/net/intel/e1000/base/meson.build
+++ b/drivers/net/intel/e1000/base/meson.build
@@ -12,6 +12,7 @@ sources = [
         'e1000_82575.c',
         'e1000_api.c',
         'e1000_i210.c',
+        'e1000_i225.c',
         'e1000_ich8lan.c',
         'e1000_mac.c',
         'e1000_manage.c',
-- 
2.43.5

