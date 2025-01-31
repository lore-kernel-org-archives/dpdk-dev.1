Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6952FC02194
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 13:01:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6E7A42E02;
	Fri, 31 Jan 2025 13:59:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id A318E42D27
 for <dev@dpdk.org>; Fri, 31 Jan 2025 13:59:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738328379; x=1769864379;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=6FT/77sjM0CEP3oRr+V+8i3r/vsnGbpdEaWPWAbkYj4=;
 b=LNA5OPSSsOW6iy/co+C049okty7ZV5/YqTotdSwCU2vZw9edzznh7Tyw
 dngmv9msyqZOzBe3lSdNjKOEsMabgGg4ddzS6alto3oJ2f9kXHOoIdzax
 UprrCqlRLRu0Hhd+b5kMlK3RhZsbHouyldcSQ5atE5xyl24hYZocAH9U9
 PQ+D1gLgXNViOmaQtQkNpYsKVbwbCjDKzYN0Bsk16lGcB6ki9ptCoM5HU
 CAsqc3wsoFAj2jFz+3dsyDSZ1cUe2DV9E+28wSDm6aSRwU9Y622TvjmUU
 e2LluY9TPixN8dZQmsNSW6eMQM2XlCATcQ7KT9uIgyIT9Xi6CgZkku8i+ w==;
X-CSE-ConnectionGUID: Pd3iSO75ScOcczpHpdgEVw==
X-CSE-MsgGUID: GUNs7WTuTQmuZsQPg43mIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50315631"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="50315631"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 04:59:38 -0800
X-CSE-ConnectionGUID: X4SlnME8RyOAzbZKf54e5w==
X-CSE-MsgGUID: rlFm4lSAR8SdptzS54KGkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="140503381"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa001.fm.intel.com with ESMTP; 31 Jan 2025 04:59:37 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 13/42] net/e1000/base: correct minor formatting issues
Date: Fri, 31 Jan 2025 12:58:26 +0000
Message-ID: <0e5cdd0d1277a191083a616feadd5818b357ed7b.1738328107.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738328106.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
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

There are some mismatches between what's in the base driver, and what is
in DPDK version of it. This patch fixes the following issues:

- Unneeded #ifndef clause
- Missing comments
- Duplicate definitions
- Missed definitions
- Extraneous fall-through comments
- Function comments not matching function names

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_82575.c   |  8 ------
 drivers/net/intel/e1000/base/e1000_82575.h   | 29 --------------------
 drivers/net/intel/e1000/base/e1000_defines.h |  2 --
 drivers/net/intel/e1000/base/e1000_mac.c     |  2 +-
 drivers/net/intel/e1000/base/e1000_nvm.c     |  2 +-
 drivers/net/intel/e1000/base/e1000_phy.c     |  4 +--
 drivers/net/intel/e1000/base/e1000_regs.h    |  3 ++
 7 files changed, 7 insertions(+), 43 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_82575.c b/drivers/net/intel/e1000/base/e1000_82575.c
index 53900cf8f1..c781085348 100644
--- a/drivers/net/intel/e1000/base/e1000_82575.c
+++ b/drivers/net/intel/e1000/base/e1000_82575.c
@@ -1497,21 +1497,14 @@ STATIC s32 e1000_setup_copper_link_82575(struct e1000_hw *hw)
 	}
 	switch (hw->phy.type) {
 	case e1000_phy_i210:
-	/* Fall through */
 	case e1000_phy_m88:
 		switch (hw->phy.id) {
 		case I347AT4_E_PHY_ID:
-		/* Fall through */
 		case M88E1112_E_PHY_ID:
-		/* Fall through */
 		case M88E1340M_E_PHY_ID:
-		/* Fall through */
 		case M88E1543_E_PHY_ID:
-		/* Fall through */
 		case M88E1512_E_PHY_ID:
-		/* Fall through */
 		case I210_I_PHY_ID:
-		/* Fall through */
 			ret_val = e1000_copper_link_setup_m88_gen2(hw);
 			break;
 		default:
@@ -1721,7 +1714,6 @@ STATIC s32 e1000_get_media_type_82575(struct e1000_hw *hw)
 			dev_spec->sgmii_active = true;
 			break;
 		}
-		/* Fall through for I2C based SGMII */
 		/* Fall through */
 	case E1000_CTRL_EXT_LINK_MODE_PCIE_SERDES:
 		/* read media type from SFP EEPROM */
diff --git a/drivers/net/intel/e1000/base/e1000_82575.h b/drivers/net/intel/e1000/base/e1000_82575.h
index 006b37ae98..e2364606d5 100644
--- a/drivers/net/intel/e1000/base/e1000_82575.h
+++ b/drivers/net/intel/e1000/base/e1000_82575.h
@@ -90,11 +90,8 @@ struct e1000_adv_context_desc {
 };
 
 /* SRRCTL bit definitions */
-#define E1000_SRRCTL_BSIZEPKT_SHIFT		10 /* Shift _right_ */
 #define E1000_SRRCTL_BSIZEHDRSIZE_MASK		0x00000F00
-#define E1000_SRRCTL_BSIZEHDRSIZE_SHIFT		2  /* Shift _left_ */
 #define E1000_SRRCTL_DESCTYPE_LEGACY		0x00000000
-#define E1000_SRRCTL_DESCTYPE_ADV_ONEBUF	0x02000000
 #define E1000_SRRCTL_DESCTYPE_HDR_SPLIT		0x04000000
 #define E1000_SRRCTL_DESCTYPE_HDR_SPLIT_ALWAYS	0x0A000000
 #define E1000_SRRCTL_DESCTYPE_HDR_REPLICATION	0x06000000
@@ -210,36 +207,10 @@ struct e1000_adv_context_desc {
 #define E1000_RXDADV_IPSEC_ERROR_INVALID_LENGTH		0x10000000
 #define E1000_RXDADV_IPSEC_ERROR_AUTHENTICATION_FAILED	0x18000000
 
-/* Adv Transmit Descriptor Config Masks */
-#define E1000_ADVTXD_DTYP_CTXT	0x00200000 /* Advanced Context Descriptor */
-#define E1000_ADVTXD_DTYP_DATA	0x00300000 /* Advanced Data Descriptor */
-#define E1000_ADVTXD_DCMD_EOP	0x01000000 /* End of Packet */
-#define E1000_ADVTXD_DCMD_IFCS	0x02000000 /* Insert FCS (Ethernet CRC) */
-#define E1000_ADVTXD_DCMD_RS	0x08000000 /* Report Status */
-#define E1000_ADVTXD_DCMD_DDTYP_ISCSI	0x10000000 /* DDP hdr type or iSCSI */
-#define E1000_ADVTXD_DCMD_DEXT	0x20000000 /* Descriptor extension (1=Adv) */
-#define E1000_ADVTXD_DCMD_VLE	0x40000000 /* VLAN pkt enable */
-#define E1000_ADVTXD_DCMD_TSE	0x80000000 /* TCP Seg enable */
-#define E1000_ADVTXD_MAC_LINKSEC	0x00040000 /* Apply LinkSec on pkt */
-#define E1000_ADVTXD_MAC_TSTAMP		0x00080000 /* IEEE1588 Timestamp pkt */
-#define E1000_ADVTXD_STAT_SN_CRC	0x00000002 /* NXTSEQ/SEED prsnt in WB */
-#define E1000_ADVTXD_IDX_SHIFT		4  /* Adv desc Index shift */
-#define E1000_ADVTXD_POPTS_ISCO_1ST	0x00000000 /* 1st TSO of iSCSI PDU */
-#define E1000_ADVTXD_POPTS_ISCO_MDL	0x00000800 /* Middle TSO of iSCSI PDU */
-#define E1000_ADVTXD_POPTS_ISCO_LAST	0x00001000 /* Last TSO of iSCSI PDU */
-/* 1st & Last TSO-full iSCSI PDU*/
-#define E1000_ADVTXD_POPTS_ISCO_FULL	0x00001800
-#define E1000_ADVTXD_POPTS_IPSEC	0x00000400 /* IPSec offload request */
-#define E1000_ADVTXD_PAYLEN_SHIFT	14 /* Adv desc PAYLEN shift */
-
-/* Additional Transmit Descriptor Control definitions */
-#define E1000_TXDCTL_QUEUE_ENABLE	0x02000000 /* Ena specific Tx Queue */
 #define E1000_TXDCTL_SWFLSH		0x04000000 /* Tx Desc. wbk flushing */
 /* Tx Queue Arbitration Priority 0=low, 1=high */
 #define E1000_TXDCTL_PRIORITY		0x08000000
 
-/* Additional Receive Descriptor Control definitions */
-#define E1000_RXDCTL_QUEUE_ENABLE	0x02000000 /* Ena specific Rx Queue */
 #define E1000_RXDCTL_SWFLSH		0x04000000 /* Rx Desc. wbk flushing */
 
 /* Direct Cache Access (DCA) definitions */
diff --git a/drivers/net/intel/e1000/base/e1000_defines.h b/drivers/net/intel/e1000/base/e1000_defines.h
index 44d6888824..4a5559d0ca 100644
--- a/drivers/net/intel/e1000/base/e1000_defines.h
+++ b/drivers/net/intel/e1000/base/e1000_defines.h
@@ -1117,9 +1117,7 @@
 /* NVM Addressing bits based on type 0=small, 1=large */
 #define E1000_EECD_ADDR_BITS	0x00000400
 #define E1000_EECD_TYPE		0x00002000 /* NVM Type (1-SPI, 0-Microwire) */
-#ifndef E1000_NVM_GRANT_ATTEMPTS
 #define E1000_NVM_GRANT_ATTEMPTS	1000 /* NVM # attempts to gain grant */
-#endif
 #define E1000_EECD_AUTO_RD		0x00000200  /* NVM Auto Read done */
 #define E1000_EECD_SIZE_EX_MASK		0x00007800  /* NVM Size */
 #define E1000_EECD_SIZE_EX_SHIFT	11
diff --git a/drivers/net/intel/e1000/base/e1000_mac.c b/drivers/net/intel/e1000/base/e1000_mac.c
index ec012f1733..0db114c0df 100644
--- a/drivers/net/intel/e1000/base/e1000_mac.c
+++ b/drivers/net/intel/e1000/base/e1000_mac.c
@@ -1673,7 +1673,7 @@ s32 e1000_get_speed_and_duplex_copper_generic(struct e1000_hw *hw, u16 *speed,
 }
 
 /**
- *  e1000_get_speed_and_duplex_fiber_generic - Retrieve current speed/duplex
+ *  e1000_get_speed_and_duplex_fiber_serdes_generic - return fiber defaults
  *  @hw: pointer to the HW structure
  *  @speed: stores the current speed
  *  @duplex: stores the current duplex
diff --git a/drivers/net/intel/e1000/base/e1000_nvm.c b/drivers/net/intel/e1000/base/e1000_nvm.c
index aec5e80986..2b38bbc117 100644
--- a/drivers/net/intel/e1000/base/e1000_nvm.c
+++ b/drivers/net/intel/e1000/base/e1000_nvm.c
@@ -30,7 +30,7 @@ void e1000_init_nvm_ops_generic(struct e1000_hw *hw)
 }
 
 /**
- *  e1000_null_nvm_read - No-op function, return 0
+ *  e1000_null_read_nvm - No-op function, return 0
  *  @hw: pointer to the HW structure
  *  @a: dummy variable
  *  @b: dummy variable
diff --git a/drivers/net/intel/e1000/base/e1000_phy.c b/drivers/net/intel/e1000/base/e1000_phy.c
index 6fac341d71..60d6bdfa4e 100644
--- a/drivers/net/intel/e1000/base/e1000_phy.c
+++ b/drivers/net/intel/e1000/base/e1000_phy.c
@@ -770,7 +770,7 @@ s32 e1000_read_phy_reg_igp_locked(struct e1000_hw *hw, u32 offset, u16 *data)
 }
 
 /**
- *  e1000_write_phy_reg_igp - Write igp PHY register
+ *  __e1000_write_phy_reg_igp - Write igp PHY register
  *  @hw: pointer to the HW structure
  *  @offset: register offset to write to
  *  @data: data to write at register offset
@@ -1014,7 +1014,7 @@ STATIC s32 e1000_set_master_slave_mode(struct e1000_hw *hw)
 		break;
 	case e1000_ms_auto:
 		phy_data &= ~CR_1000T_MS_ENABLE;
-		/* fall-through */
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/net/intel/e1000/base/e1000_regs.h b/drivers/net/intel/e1000/base/e1000_regs.h
index b30419d712..1a12940b9f 100644
--- a/drivers/net/intel/e1000/base/e1000_regs.h
+++ b/drivers/net/intel/e1000/base/e1000_regs.h
@@ -5,6 +5,7 @@
 #ifndef _E1000_REGS_H_
 #define _E1000_REGS_H_
 
+/* General Register Descriptions */
 #define E1000_CTRL	0x00000  /* Device Control - RW */
 #define E1000_CTRL_DUP	0x00004  /* Device Control Duplicate (Shadow) - RW */
 #define E1000_STATUS	0x00008  /* Device Status - RO */
@@ -13,6 +14,7 @@
 #define E1000_EEWR	0x0102C  /* EEPROM Write Register - RW */
 #define E1000_EERD_V2	0x12014  /* EEprom mode read - RW */
 #define E1000_EEWR_V2	0x12018  /* EEprom mode write - RW */
+/* NVM  Register Descriptions */
 #define E1000_CTRL_EXT	0x00018  /* Extended Device Control - RW */
 #define E1000_FLA	0x0001C  /* Flash Access - RW */
 #define E1000_MDIC	0x00020  /* MDI Control - RW */
@@ -23,6 +25,7 @@
 #define E1000_BARCTRL			0x5BBC /* BAR ctrl reg */
 #define E1000_BARCTRL_FLSIZE		0x0700 /* BAR ctrl Flsize */
 #define E1000_BARCTRL_CSRSIZE		0x2000 /* BAR ctrl CSR size */
+#define E1000_BARCTRL_CSRSIZE_SHIFT	13
 #define E1000_MPHY_ADDR_CTRL	0x0024 /* GbE MPHY Address Control */
 #define E1000_MPHY_DATA		0x0E10 /* GBE MPHY Data */
 #define E1000_MPHY_STAT		0x0E0C /* GBE MPHY Statistics */
-- 
2.43.5

