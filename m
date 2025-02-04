Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BD8C02196
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:12:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5AEC842788;
	Tue,  4 Feb 2025 16:11:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 7701241109
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:11:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681899; x=1770217899;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=g/xT5QCR1veGPo81ZWoM5qX8UczdwmQPlkNcD0sOpig=;
 b=QxUOLUtkVkVLsS32kf+k//WcHuQIIHtVmXF+0MY2Akf+g7Adbjsej9nD
 iIOoHqZ4vQ1jzueh1ky1etUZLzEHf3tdzsLgug3NQDDCo1eWOmnCcXUxm
 KvzC808PrsYf2/gxvLAkAJsPohRKvaesxQNlOKp4PTEf4cFaCr/UysK1m
 j88wG22u8wipIIZfoyqDrczuj4ostyvcorCpgt6wVkxaAOS1PsiRr6cIG
 PrSwyMOJ8/Pv1XJ7gI3JCV6S8JZYU7/SK7PJ1WhA5J6edhlHd0lGEd02m
 idNOu3BKkkfDZBve9ZsgkkMmA8376oGyNXqAdUzfwqJ/owNAKM+2XwsGL A==;
X-CSE-ConnectionGUID: b59W6GNKTsOPbqabTnGuaw==
X-CSE-MsgGUID: Yol3VNwXQRCIlQ+dHKrdUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097103"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097103"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:11:39 -0800
X-CSE-ConnectionGUID: zfU/mEFrTmWnUHy6zQzraQ==
X-CSE-MsgGUID: YEHsghQ7Qearskr4KB/ehQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792582"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:11:37 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 08/54] net/e1000/base: correct formatting differences
Date: Tue,  4 Feb 2025 15:10:14 +0000
Message-ID: <e01c65d5523163a39c65d18d76ed42ce9e7b487f.1738681726.git.anatoly.burakov@intel.com>
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

There are some mismatches between what's in the base driver, and what is
in DPDK version of it. This patch fixes the following issues:

- Unneeded #ifndef clause
- Missing comments
- Duplicate definitions
- Moved definitions
- Extraneous fall-through comments
- Function comments not matching function names
- Typos in comments
- Wrong or misleading indentation
- Differences in whitespace
- Missing parentheses
- Extra line breaks

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_82575.c   |  8 ----
 drivers/net/intel/e1000/base/e1000_82575.h   | 29 ------------
 drivers/net/intel/e1000/base/e1000_api.c     |  2 -
 drivers/net/intel/e1000/base/e1000_base.c    |  4 +-
 drivers/net/intel/e1000/base/e1000_defines.h | 50 +++++++++++++++-----
 drivers/net/intel/e1000/base/e1000_i225.c    | 24 +++++-----
 drivers/net/intel/e1000/base/e1000_mac.c     |  4 +-
 drivers/net/intel/e1000/base/e1000_nvm.c     |  7 +--
 drivers/net/intel/e1000/base/e1000_osdep.h   | 12 -----
 drivers/net/intel/e1000/base/e1000_phy.c     | 10 ++--
 drivers/net/intel/e1000/base/e1000_regs.h    | 21 ++------
 11 files changed, 63 insertions(+), 108 deletions(-)

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
diff --git a/drivers/net/intel/e1000/base/e1000_api.c b/drivers/net/intel/e1000/base/e1000_api.c
index bc7956cd01..0d55f1b761 100644
--- a/drivers/net/intel/e1000/base/e1000_api.c
+++ b/drivers/net/intel/e1000/base/e1000_api.c
@@ -405,7 +405,6 @@ s32 e1000_set_mac_type(struct e1000_hw *hw)
 	case E1000_DEV_ID_I350_VF_HV:
 		mac->type = e1000_vfadapt_i350;
 		break;
-
 	case E1000_DEV_ID_I354_BACKPLANE_1GBPS:
 	case E1000_DEV_ID_I354_SGMII:
 	case E1000_DEV_ID_I354_BACKPLANE_2_5GBPS:
@@ -1421,4 +1420,3 @@ void e1000_shutdown_fiber_serdes_link(struct e1000_hw *hw)
 	if (hw->mac.ops.shutdown_serdes)
 		hw->mac.ops.shutdown_serdes(hw);
 }
-
diff --git a/drivers/net/intel/e1000/base/e1000_base.c b/drivers/net/intel/e1000/base/e1000_base.c
index 3ec32e7240..04fe9f4f91 100644
--- a/drivers/net/intel/e1000/base/e1000_base.c
+++ b/drivers/net/intel/e1000/base/e1000_base.c
@@ -81,8 +81,8 @@ s32 e1000_init_hw_base(struct e1000_hw *hw)
 
 	/* Setup link and flow control */
 	ret_val = mac->ops.setup_link(hw);
-
-	/* Clear all of the statistics registers (clear on read).  It is
+	/*
+	 * Clear all of the statistics registers (clear on read).  It is
 	 * important that we do this after we have tried to establish link
 	 * because the symbol error count will increment wildly if there
 	 * is no link.
diff --git a/drivers/net/intel/e1000/base/e1000_defines.h b/drivers/net/intel/e1000/base/e1000_defines.h
index ab8eeb3f3a..d795c327a3 100644
--- a/drivers/net/intel/e1000/base/e1000_defines.h
+++ b/drivers/net/intel/e1000/base/e1000_defines.h
@@ -188,14 +188,14 @@
 #define E1000_RCTL_BSEX		0x02000000 /* Buffer size extension */
 #define E1000_RCTL_SECRC	0x04000000 /* Strip Ethernet CRC */
 
-#define E1000_DTXMXPKTSZ_TSN     0x19 /* 1600 bytes of max TX DMA packet size */
-#define E1000_TXPBSIZE_TSN       0x04145145 /* 5k bytes buffer for each queue */
+#define E1000_DTXMXPKTSZ_TSN	0x19 /* 1600 bytes of max TX DMA packet size */
+#define E1000_TXPBSIZE_TSN	0x04145145 /* 5k bytes buffer for each queue */
 
 /* Transmit Scheduling */
-#define E1000_TQAVCTRL_TRANSMIT_MODE_TSN 0x00000001
-#define E1000_TQAVCTRL_ENHANCED_QAV      0x00000008
+#define E1000_TQAVCTRL_TRANSMIT_MODE_TSN	0x00000001
+#define E1000_TQAVCTRL_ENHANCED_QAV	0x00000008
 
-#define E1000_TXQCTL_QUEUE_MODE_LAUNCHT  0x00000001
+#define E1000_TXQCTL_QUEUE_MODE_LAUNCHT	0x00000001
 
 /* Use byte values for the following shift parameters
  * Usage:
@@ -801,15 +801,15 @@
 #define TSYNC_INTERRUPTS	TSINTR_TXTS
 
 /* Split Replication Receive Control */
-#define E1000_SRRCTL_TIMESTAMP           0x40000000
-#define E1000_SRRCTL_TIMER1SEL(timer)    (((timer) & 0x3) << 14)
-#define E1000_SRRCTL_TIMER0SEL(timer)    (((timer) & 0x3) << 17)
+#define E1000_SRRCTL_TIMESTAMP		0x40000000
+#define E1000_SRRCTL_TIMER1SEL(timer)	(((timer) & 0x3) << 14)
+#define E1000_SRRCTL_TIMER0SEL(timer)	(((timer) & 0x3) << 17)
 
 /* Sample RX tstamp in PHY sop */
-#define E1000_TSYNCRXCTL_RXSYNSIG         0x00000400
+#define E1000_TSYNCRXCTL_RXSYNSIG	0x00000400
 
 /* Sample TX tstamp in PHY sop */
-#define E1000_TSYNCTXCTL_TXSYNSIG         0x00000020
+#define E1000_TSYNCTXCTL_TXSYNSIG	0x00000020
 
 /* TSAUXC Configuration Bits */
 #define TSAUXC_EN_TT0	(1 << 0)  /* Enable target time 0. */
@@ -1110,9 +1110,7 @@
 /* NVM Addressing bits based on type 0=small, 1=large */
 #define E1000_EECD_ADDR_BITS	0x00000400
 #define E1000_EECD_TYPE		0x00002000 /* NVM Type (1-SPI, 0-Microwire) */
-#ifndef E1000_NVM_GRANT_ATTEMPTS
 #define E1000_NVM_GRANT_ATTEMPTS	1000 /* NVM # attempts to gain grant */
-#endif
 #define E1000_EECD_AUTO_RD		0x00000200  /* NVM Auto Read done */
 #define E1000_EECD_SIZE_EX_MASK		0x00007800  /* NVM Size */
 #define E1000_EECD_SIZE_EX_SHIFT	11
@@ -1366,7 +1364,7 @@
 #define BCM54616_E_PHY_ID	0x03625D10
 #define M88_VENDOR		0x0141
 #define I225_I_PHY_ID		0x67C9DC00
-#define I226_LM_PHY_ID          0x67C9DC10
+#define I226_LM_PHY_ID		0x67C9DC10
 
 /* M88E1000 Specific Registers */
 #define M88E1000_PHY_SPEC_CTRL		0x10  /* PHY Specific Control Reg */
@@ -1584,6 +1582,32 @@
 #define I210_RXPBSIZE_DEFAULT		0x000000A2 /* RXPBSIZE default */
 #define I210_TXPBSIZE_DEFAULT		0x04000014 /* TXPBSIZE default */
 
+#define E1000_LTRC_EEEMS_EN		0x00000020 /* Enable EEE LTR max send */
+/* Minimum time for 1000BASE-T where no data will be transmit following move out
+ * of EEE LPI Tx state
+ */
+#define E1000_TW_SYSTEM_1000_MASK	0x000000FF
+/* Minimum time for 100BASE-T where no data will be transmit following move out
+ * of EEE LPI Tx state
+ */
+#define E1000_TW_SYSTEM_100_MASK	0x0000FF00
+#define E1000_TW_SYSTEM_100_SHIFT	8
+#define E1000_LTRMINV_LTRV_MASK		0x000003FF /* LTR minimum value */
+#define E1000_LTRMAXV_LTRV_MASK		0x000003FF /* LTR maximum value */
+#define E1000_LTRMINV_SCALE_MASK	0x00001C00 /* LTR minimum scale */
+#define E1000_LTRMINV_SCALE_SHIFT	10
+/* Reg val to set scale to 1024 nsec */
+#define E1000_LTRMINV_SCALE_1024	2
+/* Reg val to set scale to 32768 nsec */
+#define E1000_LTRMINV_SCALE_32768	3
+#define E1000_LTRMINV_LSNP_REQ		0x00008000 /* LTR Snoop Requirement */
+#define E1000_LTRMAXV_SCALE_MASK	0x00001C00 /* LTR maximum scale */
+#define E1000_LTRMAXV_SCALE_SHIFT	10
+/* Reg val to set scale to 1024 nsec */
+#define E1000_LTRMAXV_SCALE_1024	2
+/* Reg val to set scale to 32768 nsec */
+#define E1000_LTRMAXV_SCALE_32768	3
+#define E1000_LTRMAXV_LSNP_REQ		0x00008000 /* LTR Snoop Requirement */
 
 #define I225_RXPBSIZE_DEFAULT		0x000000A2 /* RXPBSIZE default */
 #define I225_TXPBSIZE_DEFAULT		0x04000014 /* TXPBSIZE default */
diff --git a/drivers/net/intel/e1000/base/e1000_i225.c b/drivers/net/intel/e1000/base/e1000_i225.c
index 018b22210e..2b2ea6ed7b 100644
--- a/drivers/net/intel/e1000/base/e1000_i225.c
+++ b/drivers/net/intel/e1000/base/e1000_i225.c
@@ -550,8 +550,8 @@ static s32 __e1000_write_nvm_srwr(struct e1000_hw *hw, u16 offset, u16 words,
 	/* A check for invalid values:  offset too large, too many words,
 	 * too many words for the offset, and not enough words.
 	 */
-	if (offset >= nvm->word_size || words > (nvm->word_size - offset) ||
-			words == 0) {
+	if ((offset >= nvm->word_size) || (words > (nvm->word_size - offset)) ||
+	    (words == 0)) {
 		DEBUGOUT("nvm parameter(s) out of bounds\n");
 		ret_val = -E1000_ERR_NVM;
 		goto out;
@@ -688,8 +688,7 @@ s32 e1000_read_invm_version_i225(struct e1000_hw *hw,
 s32 e1000_validate_nvm_checksum_i225(struct e1000_hw *hw)
 {
 	s32 status = E1000_SUCCESS;
-	s32 (*read_op_ptr)(struct e1000_hw *hw, u16 offset,
-			u16 count, u16 *data);
+	s32 (*read_op_ptr)(struct e1000_hw *, u16, u16, u16 *);
 
 	DEBUGFUNC("e1000_validate_nvm_checksum_i225");
 
@@ -1005,22 +1004,23 @@ static s32 e1000_set_ltr_i225(struct e1000_hw *hw, bool link)
 		/* Check if using copper interface with EEE enabled or if the
 		 * link speed is 10 Mbps.
 		 */
-		if (hw->phy.media_type == e1000_media_type_copper &&
-				!hw->dev_spec._i225.eee_disable &&
-				speed != SPEED_10) {
+		if ((hw->phy.media_type == e1000_media_type_copper) &&
+		    !(hw->dev_spec._i225.eee_disable) &&
+		     (speed != SPEED_10)) {
 			/* EEE enabled, so send LTRMAX threshold. */
 			ltrc = E1000_READ_REG(hw, E1000_LTRC) |
 				E1000_LTRC_EEEMS_EN;
 			E1000_WRITE_REG(hw, E1000_LTRC, ltrc);
 
 			/* Calculate tw_system (nsec). */
-			if (speed == SPEED_100)
+			if (speed == SPEED_100) {
 				tw_system = ((E1000_READ_REG(hw, E1000_EEE_SU) &
-					E1000_TW_SYSTEM_100_MASK) >>
-					E1000_TW_SYSTEM_100_SHIFT) * 500;
-			else
+					     E1000_TW_SYSTEM_100_MASK) >>
+					     E1000_TW_SYSTEM_100_SHIFT) * 500;
+			} else {
 				tw_system = (E1000_READ_REG(hw, E1000_EEE_SU) &
-					E1000_TW_SYSTEM_1000_MASK) * 500;
+					     E1000_TW_SYSTEM_1000_MASK) * 500;
+			}
 		} else {
 			tw_system = 0;
 		}
diff --git a/drivers/net/intel/e1000/base/e1000_mac.c b/drivers/net/intel/e1000/base/e1000_mac.c
index 02e03bed1f..7e53da613c 100644
--- a/drivers/net/intel/e1000/base/e1000_mac.c
+++ b/drivers/net/intel/e1000/base/e1000_mac.c
@@ -1645,7 +1645,7 @@ s32 e1000_get_speed_and_duplex_copper_generic(struct e1000_hw *hw, u16 *speed,
 		 * and 2.5 Gbps link modes. An additional bit is used
 		 * to differentiate between 1 Gbps and 2.5 Gbps.
 		 */
-		if (hw->mac.type == e1000_i225 &&
+		if ((hw->mac.type == e1000_i225) &&
 		    (status & E1000_STATUS_SPEED_2500)) {
 			*speed = SPEED_2500;
 			DEBUGOUT("2500 Mbs, ");
@@ -1673,7 +1673,7 @@ s32 e1000_get_speed_and_duplex_copper_generic(struct e1000_hw *hw, u16 *speed,
 }
 
 /**
- *  e1000_get_speed_and_duplex_fiber_generic - Retrieve current speed/duplex
+ *  e1000_get_speed_and_duplex_fiber_serdes_generic - return fiber defaults
  *  @hw: pointer to the HW structure
  *  @speed: stores the current speed
  *  @duplex: stores the current duplex
diff --git a/drivers/net/intel/e1000/base/e1000_nvm.c b/drivers/net/intel/e1000/base/e1000_nvm.c
index aec5e80986..0d43a49c14 100644
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
@@ -136,8 +136,7 @@ STATIC void e1000_shift_out_eec_bits(struct e1000_hw *hw, u16 data, u16 count)
 	mask = 0x01 << (count - 1);
 	if (nvm->type == e1000_nvm_eeprom_microwire)
 		eecd &= ~E1000_EECD_DO;
-	else
-	if (nvm->type == e1000_nvm_eeprom_spi)
+	else if (nvm->type == e1000_nvm_eeprom_spi)
 		eecd |= E1000_EECD_DO;
 
 	do {
@@ -1361,5 +1360,3 @@ void e1000_get_fw_version(struct e1000_hw *hw, struct e1000_fw_version *fw_vers)
 				     eeprom_verl;
 	}
 }
-
-
diff --git a/drivers/net/intel/e1000/base/e1000_osdep.h b/drivers/net/intel/e1000/base/e1000_osdep.h
index 7b29a526b4..1df343be8c 100644
--- a/drivers/net/intel/e1000/base/e1000_osdep.h
+++ b/drivers/net/intel/e1000/base/e1000_osdep.h
@@ -116,18 +116,6 @@ static inline uint16_t e1000_read_addr16(volatile void *addr)
 	return rte_le_to_cpu_16(E1000_PCI_REG16(addr));
 }
 
-/* Necessary defines */
-#define E1000_MRQC_ENABLE_MASK                  0x00000007
-#define E1000_MRQC_RSS_FIELD_IPV6_EX		0x00080000
-#define E1000_ALL_FULL_DUPLEX   ( \
-        ADVERTISE_10_FULL | ADVERTISE_100_FULL | ADVERTISE_1000_FULL)
-
-#define M88E1543_E_PHY_ID    0x01410EA0
-#define ULP_SUPPORT
-
-#define E1000_RCTL_DTYP_MASK	0x00000C00 /* Descriptor type mask */
-#define E1000_MRQC_RSS_FIELD_IPV6_EX            0x00080000
-
 /* Register READ/WRITE macros */
 
 #define E1000_READ_REG(hw, reg) \
diff --git a/drivers/net/intel/e1000/base/e1000_phy.c b/drivers/net/intel/e1000/base/e1000_phy.c
index 23701db882..ff37a54b6b 100644
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
@@ -4433,7 +4433,7 @@ s32 e1000_read_xmdio_reg(struct e1000_hw *hw, u16 addr, u8 dev_addr, u16 *data)
 {
 	DEBUGFUNC("e1000_read_xmdio_reg");
 
-		return __e1000_access_xmdio_reg(hw, addr, dev_addr, data, true);
+	return __e1000_access_xmdio_reg(hw, addr, dev_addr, data, true);
 }
 
 /**
@@ -4447,6 +4447,6 @@ s32 e1000_write_xmdio_reg(struct e1000_hw *hw, u16 addr, u8 dev_addr, u16 data)
 {
 	DEBUGFUNC("e1000_write_xmdio_reg");
 
-		return __e1000_access_xmdio_reg(hw, addr, dev_addr, &data,
-						false);
+	return __e1000_access_xmdio_reg(hw, addr, dev_addr, &data,
+				false);
 }
diff --git a/drivers/net/intel/e1000/base/e1000_regs.h b/drivers/net/intel/e1000/base/e1000_regs.h
index 32acbb4789..994e3c391b 100644
--- a/drivers/net/intel/e1000/base/e1000_regs.h
+++ b/drivers/net/intel/e1000/base/e1000_regs.h
@@ -5,11 +5,14 @@
 #ifndef _E1000_REGS_H_
 #define _E1000_REGS_H_
 
+/* General Register Descriptions */
 #define E1000_CTRL	0x00000  /* Device Control - RW */
 #define E1000_CTRL_DUP	0x00004  /* Device Control Duplicate (Shadow) - RW */
 #define E1000_STATUS	0x00008  /* Device Status - RO */
 #define E1000_EECD	0x00010  /* EEPROM/Flash Control - RW */
 #define E1000_EERD	0x00014  /* EEPROM Read - RW */
+#define E1000_EEWR	0x0102C  /* EEPROM Write Register - RW */
+/* NVM  Register Descriptions */
 #define E1000_CTRL_EXT	0x00018  /* Extended Device Control - RW */
 #define E1000_FLA	0x0001C  /* Flash Access - RW */
 #define E1000_MDIC	0x00020  /* MDI Control - RW */
@@ -96,7 +99,6 @@
 #define E1000_EEARBC_I210	0x12024 /* EEPROM Auto Read Bus Control */
 #define E1000_EEARBC_I225	0x12024 /* EEPROM Auto Read Bus Control */
 #define E1000_FLASHT	0x01028  /* FLASH Timer Register */
-#define E1000_EEWR	0x0102C  /* EEPROM Write Register - RW */
 #define E1000_FLSWCTL	0x01030  /* FLASH control register */
 #define E1000_FLSWDATA	0x01034  /* FLASH data register */
 #define E1000_FLSWCNT	0x01038  /* FLASH Access Counter */
@@ -267,7 +269,6 @@
 				 (0x054E0 + ((_i - 16) * 8)))
 #define E1000_RAH(_i)		(((_i) <= 15) ? (0x05404 + ((_i) * 8)) : \
 				 (0x054E4 + ((_i - 16) * 8)))
-
 #define E1000_VLAPQF		0x055B0  /* VLAN Priority Queue Filter VLAPQF */
 
 #define E1000_SHRAL(_i)		(0x05438 + ((_i) * 8))
@@ -719,7 +720,6 @@
 #define E1000_LTRMINV	0x5BB0 /* LTR Minimum Value */
 #define E1000_LTRMAXV	0x5BB4 /* LTR Maximum Value */
 
-
 /* IEEE 1588 TIMESYNCH */
 #define E1000_TRGTTIML0	0x0B644 /* Target Time Register 0 Low  - RW */
 #define E1000_TRGTTIMH0	0x0B648 /* Target Time Register 0 High - RW */
@@ -729,21 +729,6 @@
 #define E1000_FREQOUT1	0x0B658 /* Frequency Out 1 Control Register - RW */
 #define E1000_TSSDP	0x0003C  /* Time Sync SDP Configuration Register - RW */
 
-#define E1000_LTRC_EEEMS_EN			(1 << 5)
-#define E1000_TW_SYSTEM_100_MASK		0xff00
-#define E1000_TW_SYSTEM_100_SHIFT	8
-#define E1000_TW_SYSTEM_1000_MASK	0xff
-#define E1000_LTRMINV_SCALE_1024		0x02
-#define E1000_LTRMINV_SCALE_32768	0x03
-#define E1000_LTRMAXV_SCALE_1024		0x02
-#define E1000_LTRMAXV_SCALE_32768	0x03
-#define E1000_LTRMINV_LTRV_MASK		0x1ff
-#define E1000_LTRMINV_LSNP_REQ		0x80
-#define E1000_LTRMINV_SCALE_SHIFT	10
-#define E1000_LTRMAXV_LTRV_MASK		0x1ff
-#define E1000_LTRMAXV_LSNP_REQ		0x80
-#define E1000_LTRMAXV_SCALE_SHIFT	10
-
 #define E1000_MRQC_ENABLE_MASK		0x00000007
 #define E1000_MRQC_RSS_FIELD_IPV6_EX	0x00080000
 #define E1000_RCTL_DTYP_MASK		0x00000C00 /* Descriptor type mask */
-- 
2.43.5

