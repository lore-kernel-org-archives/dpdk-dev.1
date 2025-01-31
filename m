Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58456C02192
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 12:59:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FD4042D7A;
	Fri, 31 Jan 2025 13:59:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 4A794427B5
 for <dev@dpdk.org>; Fri, 31 Jan 2025 13:59:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738328368; x=1769864368;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=LmhOzoUwJWAvK+2nzNMyiq0nFRspDltuBbTHmirh1Vk=;
 b=DUbFnbEzgr7hjZ2WADzZa+Mui1kgZbS8CMK1T1TdiBwSt8pUf2/ECyNN
 F4tCdAGDUFuJbnthbyNyZLnBlb6bek9ZyD51/OQ74khJmjfFPdjjIx/E+
 ea+gCxsrGej5+R05FVz6X7C2aBKsM1ZUqv8k5NL0KMELzMazn/HzUxR6O
 xb9E9xO8thZ4mwzSLP8gcLOAK0slJ5LeIK/bDGZUHf3bl3EhORUqyyv/s
 dB1G0EtkOoSXn0TIVW+nS7qsugJhBqaVfIaW2oY355NapTT7WnlYvLN6u
 CPYnmKjdXTESDV19bJ7uf3Idjmc165dIPKtrOr+kPgTCxcdvMll3hZkEO Q==;
X-CSE-ConnectionGUID: m2mBFR3GQ9iSjHOP8cqVtw==
X-CSE-MsgGUID: KKQvOE8kTD60r8roYBlG3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50315615"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="50315615"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 04:59:27 -0800
X-CSE-ConnectionGUID: MPq1s7vZRSq65Lmqe33dqg==
X-CSE-MsgGUID: JKAl51mGTZiMsi4H4AVnFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="140503351"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa001.fm.intel.com with ESMTP; 31 Jan 2025 04:59:25 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 05/42] net/e1000/base: add NVM/EEPROM support for i225
Date: Fri, 31 Jan 2025 12:58:18 +0000
Message-ID: <26e5f01f2f55270f3ec04dd8f452aae0cadb1462.1738328107.git.anatoly.burakov@intel.com>
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

Add support for NVM/EEPROM operations for i225 series NICs. This is
mostly identical to IGC driver, with some minor differences due to the
way IGC driver was originally generated.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_defines.h |  40 +
 drivers/net/intel/e1000/base/e1000_hw.h      |  20 +
 drivers/net/intel/e1000/base/e1000_i225.c    | 736 +++++++++++++++++++
 drivers/net/intel/e1000/base/e1000_i225.h    |  26 +
 drivers/net/intel/e1000/base/e1000_nvm.c     |   1 +
 drivers/net/intel/e1000/base/e1000_phy.c     |  63 ++
 drivers/net/intel/e1000/base/e1000_phy.h     |   6 +
 drivers/net/intel/e1000/base/e1000_regs.h    |   9 +
 8 files changed, 901 insertions(+)

diff --git a/drivers/net/intel/e1000/base/e1000_defines.h b/drivers/net/intel/e1000/base/e1000_defines.h
index 0e33f27c3f..49e4f6c7cc 100644
--- a/drivers/net/intel/e1000/base/e1000_defines.h
+++ b/drivers/net/intel/e1000/base/e1000_defines.h
@@ -1055,6 +1055,15 @@
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
@@ -1482,6 +1491,37 @@
 #define I210_RXPBSIZE_DEFAULT		0x000000A2 /* RXPBSIZE default */
 #define I210_TXPBSIZE_DEFAULT		0x04000014 /* TXPBSIZE default */
 
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
 
 /* Proxy Filter Control */
 #define E1000_PROXYFC_D0		0x00000001 /* Enable offload in D0 */
diff --git a/drivers/net/intel/e1000/base/e1000_hw.h b/drivers/net/intel/e1000/base/e1000_hw.h
index a21cb070e0..c16dd1cbf7 100644
--- a/drivers/net/intel/e1000/base/e1000_hw.h
+++ b/drivers/net/intel/e1000/base/e1000_hw.h
@@ -381,6 +381,15 @@ enum e1000_serdes_link_state {
 	e1000_serdes_link_forced_up
 };
 
+enum e1000_invm_structure_type {
+	e1000_invm_unitialized_structure		= 0x00,
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
@@ -996,6 +1005,16 @@ struct e1000_dev_spec_vf {
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
 
@@ -1020,6 +1039,7 @@ struct e1000_hw {
 		struct e1000_dev_spec_ich8lan ich8lan;
 		struct e1000_dev_spec_82575 _82575;
 		struct e1000_dev_spec_vf vf;
+		struct e1000_dev_spec_i225 _i225;
 	} dev_spec;
 
 	u16 device_id;
diff --git a/drivers/net/intel/e1000/base/e1000_i225.c b/drivers/net/intel/e1000/base/e1000_i225.c
index a7a42e2f0e..7c8cf8552d 100644
--- a/drivers/net/intel/e1000/base/e1000_i225.c
+++ b/drivers/net/intel/e1000/base/e1000_i225.c
@@ -4,9 +4,75 @@
 
 #include "e1000_api.h"
 
+STATIC s32 e1000_init_nvm_params_i225(struct e1000_hw *hw);
 STATIC s32 e1000_init_mac_params_i225(struct e1000_hw *hw);
 STATIC s32 e1000_init_phy_params_i225(struct e1000_hw *hw);
 STATIC s32 e1000_reset_hw_i225(struct e1000_hw *hw);
+STATIC s32 e1000_acquire_nvm_i225(struct e1000_hw *hw);
+STATIC void e1000_release_nvm_i225(struct e1000_hw *hw);
+STATIC s32 e1000_get_hw_semaphore_i225(struct e1000_hw *hw);
+STATIC s32 __e1000_write_nvm_srwr(struct e1000_hw *hw, u16 offset, u16 words,
+				  u16 *data);
+STATIC s32 e1000_pool_flash_update_done_i225(struct e1000_hw *hw);
+STATIC s32 e1000_valid_led_default_i225(struct e1000_hw *hw, u16 *data);
+
+/**
+ *  e1000_init_nvm_params_i225 - Init NVM func ptrs.
+ *  @hw: pointer to the HW structure
+ **/
+STATIC s32 e1000_init_nvm_params_i225(struct e1000_hw *hw)
+{
+	struct e1000_nvm_info *nvm = &hw->nvm;
+	u32 eecd = E1000_READ_REG(hw, E1000_EECD);
+	u16 size;
+
+	DEBUGFUNC("e1000_init_nvm_params_i225");
+
+	size = (u16)((eecd & E1000_EECD_SIZE_EX_MASK) >>
+		     E1000_EECD_SIZE_EX_SHIFT);
+	/*
+	 * Added to a constant, "size" becomes the left-shift value
+	 * for setting word_size.
+	 */
+	size += NVM_WORD_SIZE_BASE_SHIFT;
+
+	/* Just in case size is out of range, cap it to the largest
+	 * EEPROM size supported
+	 */
+	if (size > 15)
+		size = 15;
+
+	nvm->word_size = 1 << size;
+	nvm->opcode_bits = 8;
+	nvm->delay_usec = 1;
+	nvm->type = e1000_nvm_eeprom_spi;
+
+
+	nvm->page_size = eecd & E1000_EECD_ADDR_BITS ? 32 : 8;
+	nvm->address_bits = eecd & E1000_EECD_ADDR_BITS ?
+			    16 : 8;
+
+	if (nvm->word_size == (1 << 15))
+		nvm->page_size = 128;
+
+	nvm->ops.acquire = e1000_acquire_nvm_i225;
+	nvm->ops.release = e1000_release_nvm_i225;
+	nvm->ops.valid_led_default = e1000_valid_led_default_i225;
+	if (e1000_get_flash_presence_i225(hw)) {
+		hw->nvm.type = e1000_nvm_flash_hw;
+		nvm->ops.read    = e1000_read_nvm_srrd_i225;
+		nvm->ops.write   = e1000_write_nvm_srwr_i225;
+		nvm->ops.validate = e1000_validate_nvm_checksum_i225;
+		nvm->ops.update   = e1000_update_nvm_checksum_i225;
+	} else {
+		hw->nvm.type = e1000_nvm_none;
+		nvm->ops.write    = e1000_null_write_nvm;
+		nvm->ops.validate = e1000_null_ops_generic;
+		nvm->ops.update   = e1000_null_ops_generic;
+	}
+
+	return E1000_SUCCESS;
+}
 
 /**
  *  e1000_init_mac_params_i225 - Init MAC func ptrs.
@@ -15,6 +81,7 @@ STATIC s32 e1000_reset_hw_i225(struct e1000_hw *hw);
 STATIC s32 e1000_init_mac_params_i225(struct e1000_hw *hw)
 {
 	struct e1000_mac_info *mac = &hw->mac;
+	struct e1000_dev_spec_i225 *dev_spec = &hw->dev_spec._i225;
 
 	DEBUGFUNC("e1000_init_mac_params_i225");
 
@@ -38,8 +105,13 @@ STATIC s32 e1000_init_mac_params_i225(struct e1000_hw *hw)
 	mac->ops.check_for_link = e1000_check_for_copper_link_generic;
 	/* link info */
 	mac->ops.get_link_up_info = e1000_get_speed_and_duplex_copper_generic;
+	/* acquire SW_FW sync */
+	mac->ops.acquire_swfw_sync = e1000_acquire_swfw_sync_i225;
+	/* release SW_FW sync */
+	mac->ops.release_swfw_sync = e1000_release_swfw_sync_i225;
 
 	/* Allow a single clear of the SW semaphore on I225 */
+	dev_spec->clear_semaphore_once = true;
 	mac->ops.setup_physical_interface = e1000_setup_copper_link_i225;
 
 	/* Set if part includes ASF firmware */
@@ -103,6 +175,8 @@ STATIC s32 e1000_init_phy_params_i225(struct e1000_hw *hw)
 		goto out;
 
 	E1000_WRITE_REG(hw, E1000_CTRL_EXT, ctrl_ext);
+	phy->ops.read_reg = e1000_read_phy_reg_gpy;
+	phy->ops.write_reg = e1000_write_phy_reg_gpy;
 
 	ret_val = e1000_get_phy_id(hw);
 
@@ -177,6 +251,118 @@ STATIC s32 e1000_reset_hw_i225(struct e1000_hw *hw)
 	return ret_val;
 }
 
+/* e1000_acquire_nvm_i225 - Request for access to EEPROM
+ * @hw: pointer to the HW structure
+ *
+ * Acquire the necessary semaphores for exclusive access to the EEPROM.
+ * Set the EEPROM access request bit and wait for EEPROM access grant bit.
+ * Return successful if access grant bit set, else clear the request for
+ * EEPROM access and return -E1000_ERR_NVM (-1).
+ */
+STATIC s32 e1000_acquire_nvm_i225(struct e1000_hw *hw)
+{
+	s32 ret_val;
+
+	DEBUGFUNC("e1000_acquire_nvm_i225");
+
+	ret_val = e1000_acquire_swfw_sync_i225(hw, E1000_SWFW_EEP_SM);
+
+	return ret_val;
+}
+
+/* e1000_release_nvm_i225 - Release exclusive access to EEPROM
+ * @hw: pointer to the HW structure
+ *
+ * Stop any current commands to the EEPROM and clear the EEPROM request bit,
+ * then release the semaphores acquired.
+ */
+STATIC void e1000_release_nvm_i225(struct e1000_hw *hw)
+{
+	DEBUGFUNC("e1000_release_nvm_i225");
+
+	e1000_release_swfw_sync_i225(hw, E1000_SWFW_EEP_SM);
+}
+
+/* e1000_acquire_swfw_sync_i225 - Acquire SW/FW semaphore
+ * @hw: pointer to the HW structure
+ * @mask: specifies which semaphore to acquire
+ *
+ * Acquire the SW/FW semaphore to access the PHY or NVM.  The mask
+ * will also specify which port we're acquiring the lock for.
+ */
+s32 e1000_acquire_swfw_sync_i225(struct e1000_hw *hw, u16 mask)
+{
+	u32 swfw_sync;
+	u32 swmask = mask;
+	u32 fwmask = mask << 16;
+	s32 ret_val = E1000_SUCCESS;
+	s32 i = 0, timeout = 200; /* FIXME: find real value to use here */
+
+	DEBUGFUNC("e1000_acquire_swfw_sync_i225");
+
+	while (i < timeout) {
+		if (e1000_get_hw_semaphore_i225(hw)) {
+			ret_val = -E1000_ERR_SWFW_SYNC;
+			goto out;
+		}
+
+		swfw_sync = E1000_READ_REG(hw, E1000_SW_FW_SYNC);
+		if (!(swfw_sync & (fwmask | swmask)))
+			break;
+
+		/* Firmware currently using resource (fwmask)
+		 * or other software thread using resource (swmask)
+		 */
+		e1000_put_hw_semaphore_generic(hw);
+		msec_delay_irq(5);
+		i++;
+	}
+
+	if (i == timeout) {
+		DEBUGOUT("Driver can't access resource, SW_FW_SYNC timeout.\n");
+		ret_val = -E1000_ERR_SWFW_SYNC;
+		goto out;
+	}
+
+	swfw_sync |= swmask;
+	E1000_WRITE_REG(hw, E1000_SW_FW_SYNC, swfw_sync);
+
+	e1000_put_hw_semaphore_generic(hw);
+
+out:
+	return ret_val;
+}
+
+/* e1000_release_swfw_sync_i225 - Release SW/FW semaphore
+ * @hw: pointer to the HW structure
+ * @mask: specifies which semaphore to acquire
+ *
+ * Release the SW/FW semaphore used to access the PHY or NVM.  The mask
+ * will also specify which port we're releasing the lock for.
+ */
+void e1000_release_swfw_sync_i225(struct e1000_hw *hw, u16 mask)
+{
+	u32 swfw_sync;
+
+	DEBUGFUNC("e1000_release_swfw_sync_i225");
+
+	/* Releasing the resource requires first getting the HW semaphore.
+	 * If we fail to get the semaphore, there is nothing we can do,
+	 * except log an error and quit. We are not allowed to hang here
+	 * indefinitely, as it may cause denial of service or system crash.
+	 */
+	if (e1000_get_hw_semaphore_i225(hw) != E1000_SUCCESS) {
+		DEBUGOUT("Failed to release SW_FW_SYNC.\n");
+		return;
+	}
+
+	swfw_sync = E1000_READ_REG(hw, E1000_SW_FW_SYNC);
+	swfw_sync &= ~(u32)mask;
+	E1000_WRITE_REG(hw, E1000_SW_FW_SYNC, swfw_sync);
+
+	e1000_put_hw_semaphore_generic(hw);
+}
+
 /*
  * e1000_setup_copper_link_i225 - Configure copper link settings
  * @hw: pointer to the HW structure
@@ -207,6 +393,520 @@ s32 e1000_setup_copper_link_i225(struct e1000_hw *hw)
 	return ret_val;
 }
 
+/* e1000_get_hw_semaphore_i225 - Acquire hardware semaphore
+ * @hw: pointer to the HW structure
+ *
+ * Acquire the HW semaphore to access the PHY or NVM
+ */
+STATIC s32 e1000_get_hw_semaphore_i225(struct e1000_hw *hw)
+{
+	u32 swsm;
+	s32 timeout = E1000_SWSM_TIMEOUT;
+	s32 i = 0;
+
+	DEBUGFUNC("e1000_get_hw_semaphore_i225");
+
+	/* Get the SW semaphore */
+	while (i < timeout) {
+		swsm = E1000_READ_REG(hw, E1000_SWSM);
+		if (!(swsm & E1000_SWSM_SMBI))
+			break;
+
+		usec_delay(50);
+		i++;
+	}
+
+	if (i == timeout) {
+		/* In rare circumstances, the SW semaphore may already be held
+		 * unintentionally. Clear the semaphore once before giving up.
+		 */
+		if (hw->dev_spec._i225.clear_semaphore_once) {
+			hw->dev_spec._i225.clear_semaphore_once = false;
+			e1000_put_hw_semaphore_generic(hw);
+			for (i = 0; i < timeout; i++) {
+				swsm = E1000_READ_REG(hw, E1000_SWSM);
+				if (!(swsm & E1000_SWSM_SMBI))
+					break;
+
+				usec_delay(50);
+			}
+		}
+
+		/* If we do not have the semaphore here, we have to give up. */
+		if (i == timeout) {
+			DEBUGOUT("Driver can't access device -\n");
+			DEBUGOUT("SMBI bit is set.\n");
+			return -E1000_ERR_NVM;
+		}
+	}
+
+	/* Get the FW semaphore. */
+	for (i = 0; i < timeout; i++) {
+		swsm = E1000_READ_REG(hw, E1000_SWSM);
+		E1000_WRITE_REG(hw, E1000_SWSM, swsm | E1000_SWSM_SWESMBI);
+
+		/* Semaphore acquired if bit latched */
+		if (E1000_READ_REG(hw, E1000_SWSM) & E1000_SWSM_SWESMBI)
+			break;
+
+		usec_delay(50);
+	}
+
+	if (i == timeout) {
+		/* Release semaphores */
+		e1000_put_hw_semaphore_generic(hw);
+		DEBUGOUT("Driver can't access the NVM\n");
+		return -E1000_ERR_NVM;
+	}
+
+	return E1000_SUCCESS;
+}
+
+/* e1000_read_nvm_srrd_i225 - Reads Shadow Ram using EERD register
+ * @hw: pointer to the HW structure
+ * @offset: offset of word in the Shadow Ram to read
+ * @words: number of words to read
+ * @data: word read from the Shadow Ram
+ *
+ * Reads a 16 bit word from the Shadow Ram using the EERD register.
+ * Uses necessary synchronization semaphores.
+ */
+s32 e1000_read_nvm_srrd_i225(struct e1000_hw *hw, u16 offset, u16 words,
+			     u16 *data)
+{
+	s32 status = E1000_SUCCESS;
+	u16 i, count;
+
+	DEBUGFUNC("e1000_read_nvm_srrd_i225");
+
+	/* We cannot hold synchronization semaphores for too long,
+	 * because of forceful takeover procedure. However it is more efficient
+	 * to read in bursts than synchronizing access for each word.
+	 */
+	for (i = 0; i < words; i += E1000_EERD_EEWR_MAX_COUNT) {
+		count = (words - i) / E1000_EERD_EEWR_MAX_COUNT > 0 ?
+			E1000_EERD_EEWR_MAX_COUNT : (words - i);
+		if (hw->nvm.ops.acquire(hw) == E1000_SUCCESS) {
+			status = e1000_read_nvm_eerd(hw, offset, count,
+						     data + i);
+			hw->nvm.ops.release(hw);
+		} else {
+			status = E1000_ERR_SWFW_SYNC;
+		}
+
+		if (status != E1000_SUCCESS)
+			break;
+	}
+
+	return status;
+}
+
+/* e1000_write_nvm_srwr_i225 - Write to Shadow RAM using EEWR
+ * @hw: pointer to the HW structure
+ * @offset: offset within the Shadow RAM to be written to
+ * @words: number of words to write
+ * @data: 16 bit word(s) to be written to the Shadow RAM
+ *
+ * Writes data to Shadow RAM at offset using EEWR register.
+ *
+ * If e1000_update_nvm_checksum is not called after this function , the
+ * data will not be committed to FLASH and also Shadow RAM will most likely
+ * contain an invalid checksum.
+ *
+ * If error code is returned, data and Shadow RAM may be inconsistent - buffer
+ * partially written.
+ */
+s32 e1000_write_nvm_srwr_i225(struct e1000_hw *hw, u16 offset, u16 words,
+			      u16 *data)
+{
+	s32 status = E1000_SUCCESS;
+	u16 i, count;
+
+	DEBUGFUNC("e1000_write_nvm_srwr_i225");
+
+	/* We cannot hold synchronization semaphores for too long,
+	 * because of forceful takeover procedure. However it is more efficient
+	 * to write in bursts than synchronizing access for each word.
+	 */
+	for (i = 0; i < words; i += E1000_EERD_EEWR_MAX_COUNT) {
+		count = (words - i) / E1000_EERD_EEWR_MAX_COUNT > 0 ?
+			E1000_EERD_EEWR_MAX_COUNT : (words - i);
+		if (hw->nvm.ops.acquire(hw) == E1000_SUCCESS) {
+			status = __e1000_write_nvm_srwr(hw, offset, count,
+							data + i);
+			hw->nvm.ops.release(hw);
+		} else {
+			status = E1000_ERR_SWFW_SYNC;
+		}
+
+		if (status != E1000_SUCCESS)
+			break;
+	}
+
+	return status;
+}
+
+/* __e1000_write_nvm_srwr - Write to Shadow Ram using EEWR
+ * @hw: pointer to the HW structure
+ * @offset: offset within the Shadow Ram to be written to
+ * @words: number of words to write
+ * @data: 16 bit word(s) to be written to the Shadow Ram
+ *
+ * Writes data to Shadow Ram at offset using EEWR register.
+ *
+ * If e1000_update_nvm_checksum is not called after this function , the
+ * Shadow Ram will most likely contain an invalid checksum.
+ */
+STATIC s32 __e1000_write_nvm_srwr(struct e1000_hw *hw, u16 offset, u16 words,
+				  u16 *data)
+{
+	struct e1000_nvm_info *nvm = &hw->nvm;
+	u32 i, k, eewr = 0;
+	u32 attempts = 100000;
+	s32 ret_val = E1000_SUCCESS;
+
+	DEBUGFUNC("__e1000_write_nvm_srwr");
+
+	/* A check for invalid values:  offset too large, too many words,
+	 * too many words for the offset, and not enough words.
+	 */
+	if ((offset >= nvm->word_size) || (words > (nvm->word_size - offset)) ||
+	    (words == 0)) {
+		DEBUGOUT("nvm parameter(s) out of bounds\n");
+		ret_val = -E1000_ERR_NVM;
+		goto out;
+	}
+
+	for (i = 0; i < words; i++) {
+		ret_val = -E1000_ERR_NVM;
+		eewr = ((offset + i) << E1000_NVM_RW_ADDR_SHIFT) |
+			(data[i] << E1000_NVM_RW_REG_DATA) |
+			E1000_NVM_RW_REG_START;
+
+		E1000_WRITE_REG(hw, E1000_SRWR, eewr);
+
+		for (k = 0; k < attempts; k++) {
+			if (E1000_NVM_RW_REG_DONE &
+			    E1000_READ_REG(hw, E1000_SRWR)) {
+				ret_val = E1000_SUCCESS;
+				break;
+			}
+			usec_delay(5);
+		}
+
+		if (ret_val != E1000_SUCCESS) {
+			DEBUGOUT("Shadow RAM write EEWR timed out\n");
+			break;
+		}
+	}
+
+out:
+	return ret_val;
+}
+
+/* e1000_validate_nvm_checksum_i225 - Validate EEPROM checksum
+ * @hw: pointer to the HW structure
+ *
+ * Calculates the EEPROM checksum by reading/adding each word of the EEPROM
+ * and then verifies that the sum of the EEPROM is equal to 0xBABA.
+ */
+s32 e1000_validate_nvm_checksum_i225(struct e1000_hw *hw)
+{
+	s32 status = E1000_SUCCESS;
+	s32 (*read_op_ptr)(struct e1000_hw *, u16, u16, u16 *);
+
+	DEBUGFUNC("e1000_validate_nvm_checksum_i225");
+
+	if (hw->nvm.ops.acquire(hw) == E1000_SUCCESS) {
+		/* Replace the read function with semaphore grabbing with
+		 * the one that skips this for a while.
+		 * We have semaphore taken already here.
+		 */
+		read_op_ptr = hw->nvm.ops.read;
+		hw->nvm.ops.read = e1000_read_nvm_eerd;
+
+		status = e1000_validate_nvm_checksum_generic(hw);
+
+		/* Revert original read operation. */
+		hw->nvm.ops.read = read_op_ptr;
+
+		hw->nvm.ops.release(hw);
+	} else {
+		status = E1000_ERR_SWFW_SYNC;
+	}
+
+	return status;
+}
+
+/* e1000_update_nvm_checksum_i225 - Update EEPROM checksum
+ * @hw: pointer to the HW structure
+ *
+ * Updates the EEPROM checksum by reading/adding each word of the EEPROM
+ * up to the checksum.  Then calculates the EEPROM checksum and writes the
+ * value to the EEPROM. Next commit EEPROM data onto the Flash.
+ */
+s32 e1000_update_nvm_checksum_i225(struct e1000_hw *hw)
+{
+	s32 ret_val;
+	u16 checksum = 0;
+	u16 i, nvm_data;
+
+	DEBUGFUNC("e1000_update_nvm_checksum_i225");
+
+	/* Read the first word from the EEPROM. If this times out or fails, do
+	 * not continue or we could be in for a very long wait while every
+	 * EEPROM read fails
+	 */
+	ret_val = e1000_read_nvm_eerd(hw, 0, 1, &nvm_data);
+	if (ret_val != E1000_SUCCESS) {
+		DEBUGOUT("EEPROM read failed\n");
+		goto out;
+	}
+
+	if (hw->nvm.ops.acquire(hw) == E1000_SUCCESS) {
+		/* Do not use hw->nvm.ops.write, hw->nvm.ops.read
+		 * because we do not want to take the synchronization
+		 * semaphores twice here.
+		 */
+
+		for (i = 0; i < NVM_CHECKSUM_REG; i++) {
+			ret_val = e1000_read_nvm_eerd(hw, i, 1, &nvm_data);
+			if (ret_val) {
+				hw->nvm.ops.release(hw);
+				DEBUGOUT("NVM Read Error while updating\n");
+				DEBUGOUT("checksum.\n");
+				goto out;
+			}
+			checksum += nvm_data;
+		}
+		checksum = (u16)NVM_SUM - checksum;
+		ret_val = __e1000_write_nvm_srwr(hw, NVM_CHECKSUM_REG, 1,
+						 &checksum);
+		if (ret_val != E1000_SUCCESS) {
+			hw->nvm.ops.release(hw);
+			DEBUGOUT("NVM Write Error while updating checksum.\n");
+			goto out;
+		}
+
+		hw->nvm.ops.release(hw);
+
+		ret_val = e1000_update_flash_i225(hw);
+	} else {
+		ret_val = E1000_ERR_SWFW_SYNC;
+	}
+out:
+	return ret_val;
+}
+
+/* e1000_get_flash_presence_i225 - Check if flash device is detected.
+ * @hw: pointer to the HW structure
+ */
+bool e1000_get_flash_presence_i225(struct e1000_hw *hw)
+{
+	u32 eec = 0;
+	bool ret_val = false;
+
+	DEBUGFUNC("e1000_get_flash_presence_i225");
+
+	eec = E1000_READ_REG(hw, E1000_EECD);
+
+	if (eec & E1000_EECD_FLASH_DETECTED_I225)
+		ret_val = true;
+
+	return ret_val;
+}
+
+/* e1000_set_flsw_flash_burst_counter_i225 - sets FLSW NVM Burst
+ * Counter in FLSWCNT register.
+ *
+ * @hw: pointer to the HW structure
+ * @burst_counter: size in bytes of the Flash burst to read or write
+ */
+s32 e1000_set_flsw_flash_burst_counter_i225(struct e1000_hw *hw,
+					    u32 burst_counter)
+{
+	s32 ret_val = E1000_SUCCESS;
+
+	DEBUGFUNC("e1000_set_flsw_flash_burst_counter_i225");
+
+	/* Validate input data */
+	if (burst_counter < E1000_I225_SHADOW_RAM_SIZE) {
+		/* Write FLSWCNT - burst counter */
+		E1000_WRITE_REG(hw, E1000_I225_FLSWCNT, burst_counter);
+	} else {
+		ret_val = E1000_ERR_INVALID_ARGUMENT;
+	}
+
+	return ret_val;
+}
+
+/* e1000_write_erase_flash_command_i225 - write/erase to a sector
+ * region on a given address.
+ *
+ * @hw: pointer to the HW structure
+ * @opcode: opcode to be used for the write command
+ * @address: the offset to write into the FLASH image
+ */
+s32 e1000_write_erase_flash_command_i225(struct e1000_hw *hw, u32 opcode,
+					 u32 address)
+{
+	u32 flswctl = 0;
+	s32 timeout = E1000_NVM_GRANT_ATTEMPTS;
+	s32 ret_val = E1000_SUCCESS;
+
+	DEBUGFUNC("e1000_write_erase_flash_command_i225");
+
+	flswctl = E1000_READ_REG(hw, E1000_I225_FLSWCTL);
+	/* Polling done bit on FLSWCTL register */
+	while (timeout) {
+		if (flswctl & E1000_FLSWCTL_DONE)
+			break;
+		usec_delay(5);
+		flswctl = E1000_READ_REG(hw, E1000_I225_FLSWCTL);
+		timeout--;
+	}
+
+	if (!timeout) {
+		DEBUGOUT("Flash transaction was not done\n");
+		return -E1000_ERR_NVM;
+	}
+
+	/* Build and issue command on FLSWCTL register */
+	flswctl = address | opcode;
+	E1000_WRITE_REG(hw, E1000_I225_FLSWCTL, flswctl);
+
+	/* Check if issued command is valid on FLSWCTL register */
+	flswctl = E1000_READ_REG(hw, E1000_I225_FLSWCTL);
+	if (!(flswctl & E1000_FLSWCTL_CMDV)) {
+		DEBUGOUT("Write flash command failed\n");
+		ret_val = E1000_ERR_INVALID_ARGUMENT;
+	}
+
+	return ret_val;
+}
+
+/* e1000_update_flash_i225 - Commit EEPROM to the flash
+ * if fw_valid_bit is set, FW is active. setting FLUPD bit in EEC
+ * register makes the FW load the internal shadow RAM into the flash.
+ * Otherwise, fw_valid_bit is 0. if FL_SECU.block_prtotected_sw = 0
+ * then FW is not active so the SW is responsible shadow RAM dump.
+ *
+ * @hw: pointer to the HW structure
+ */
+s32 e1000_update_flash_i225(struct e1000_hw *hw)
+{
+	u16 current_offset_data = 0;
+	u32 block_sw_protect = 1;
+	u16 base_address = 0x0;
+	u32 i, fw_valid_bit;
+	u16 current_offset;
+	s32 ret_val = 0;
+	u32 flup;
+
+	DEBUGFUNC("e1000_update_flash_i225");
+
+	block_sw_protect = E1000_READ_REG(hw, E1000_I225_FLSECU) &
+					  E1000_FLSECU_BLK_SW_ACCESS_I225;
+	fw_valid_bit = E1000_READ_REG(hw, E1000_FWSM) &
+				      E1000_FWSM_FW_VALID_I225;
+	if (fw_valid_bit) {
+		ret_val = e1000_pool_flash_update_done_i225(hw);
+		if (ret_val == -E1000_ERR_NVM) {
+			DEBUGOUT("Flash update time out\n");
+			goto out;
+		}
+
+		flup = E1000_READ_REG(hw, E1000_EECD) | E1000_EECD_FLUPD_I225;
+		E1000_WRITE_REG(hw, E1000_EECD, flup);
+
+		ret_val = e1000_pool_flash_update_done_i225(hw);
+		if (ret_val == E1000_SUCCESS)
+			DEBUGOUT("Flash update complete\n");
+		else
+			DEBUGOUT("Flash update time out\n");
+	} else if (!block_sw_protect) {
+		/* FW is not active and security protection is disabled.
+		 * therefore, SW is in charge of shadow RAM dump.
+		 * Check which sector is valid. if sector 0 is valid,
+		 * base address remains 0x0. otherwise, sector 1 is
+		 * valid and it's base address is 0x1000
+		 */
+		if (E1000_READ_REG(hw, E1000_EECD) & E1000_EECD_SEC1VAL_I225)
+			base_address = 0x1000;
+
+		/* Valid sector erase */
+		ret_val = e1000_write_erase_flash_command_i225(hw,
+						  E1000_I225_ERASE_CMD_OPCODE,
+						  base_address);
+		if (!ret_val) {
+			DEBUGOUT("Sector erase failed\n");
+			goto out;
+		}
+
+		current_offset = base_address;
+
+		/* Write */
+		for (i = 0; i < E1000_I225_SHADOW_RAM_SIZE / 2; i++) {
+			/* Set burst write length */
+			ret_val = e1000_set_flsw_flash_burst_counter_i225(hw,
+									  0x2);
+			if (ret_val != E1000_SUCCESS)
+				break;
+
+			/* Set address and opcode */
+			ret_val = e1000_write_erase_flash_command_i225(hw,
+						E1000_I225_WRITE_CMD_OPCODE,
+						2 * current_offset);
+			if (ret_val != E1000_SUCCESS)
+				break;
+
+			ret_val = e1000_read_nvm_eerd(hw, current_offset,
+						      1, &current_offset_data);
+			if (ret_val) {
+				DEBUGOUT("Failed to read from EEPROM\n");
+				goto out;
+			}
+
+			/* Write CurrentOffseData to FLSWDATA register */
+			E1000_WRITE_REG(hw, E1000_I225_FLSWDATA,
+					current_offset_data);
+			current_offset++;
+
+			/* Wait till operation has finished */
+			ret_val = e1000_poll_eerd_eewr_done(hw,
+						E1000_NVM_POLL_READ);
+			if (ret_val)
+				break;
+
+			usec_delay(1000);
+		}
+	}
+out:
+	return ret_val;
+}
+
+/* e1000_pool_flash_update_done_i225 - Pool FLUDONE status.
+ * @hw: pointer to the HW structure
+ */
+s32 e1000_pool_flash_update_done_i225(struct e1000_hw *hw)
+{
+	s32 ret_val = -E1000_ERR_NVM;
+	u32 i, reg;
+
+	DEBUGFUNC("e1000_pool_flash_update_done_i225");
+
+	for (i = 0; i < E1000_FLUDONE_ATTEMPTS; i++) {
+		reg = E1000_READ_REG(hw, E1000_EECD);
+		if (reg & E1000_EECD_FLUDONE_I225) {
+			ret_val = E1000_SUCCESS;
+			break;
+		}
+		usec_delay(5);
+	}
+
+	return ret_val;
+}
+
 /* e1000_init_function_pointers_i225 - Init func ptrs.
  * @hw: pointer to the HW structure
  *
@@ -216,10 +916,46 @@ void e1000_init_function_pointers_i225(struct e1000_hw *hw)
 {
 	e1000_init_mac_ops_generic(hw);
 	e1000_init_phy_ops_generic(hw);
+	e1000_init_nvm_ops_generic(hw);
 	hw->mac.ops.init_params = e1000_init_mac_params_i225;
+	hw->nvm.ops.init_params = e1000_init_nvm_params_i225;
 	hw->phy.ops.init_params = e1000_init_phy_params_i225;
 }
 
+/* e1000_valid_led_default_i225 - Verify a valid default LED config
+ * @hw: pointer to the HW structure
+ * @data: pointer to the NVM (EEPROM)
+ *
+ * Read the EEPROM for the current default LED configuration.  If the
+ * LED configuration is not valid, set to a valid LED configuration.
+ */
+STATIC s32 e1000_valid_led_default_i225(struct e1000_hw *hw, u16 *data)
+{
+	s32 ret_val;
+
+	DEBUGFUNC("e1000_valid_led_default_i225");
+
+	ret_val = hw->nvm.ops.read(hw, NVM_ID_LED_SETTINGS, 1, data);
+	if (ret_val) {
+		DEBUGOUT("NVM Read Error\n");
+		goto out;
+	}
+
+	if (*data == ID_LED_RESERVED_0000 || *data == ID_LED_RESERVED_FFFF) {
+		switch (hw->phy.media_type) {
+		case e1000_media_type_internal_serdes:
+			*data = ID_LED_DEFAULT_I225_SERDES;
+			break;
+		case e1000_media_type_copper:
+		default:
+			*data = ID_LED_DEFAULT_I225;
+			break;
+		}
+	}
+out:
+	return ret_val;
+}
+
 /* e1000_get_cfg_done_i225 - Read config done bit
  * @hw: pointer to the HW structure
  *
diff --git a/drivers/net/intel/e1000/base/e1000_i225.h b/drivers/net/intel/e1000/base/e1000_i225.h
index 03e0f4fb89..be3b1b76eb 100644
--- a/drivers/net/intel/e1000/base/e1000_i225.h
+++ b/drivers/net/intel/e1000/base/e1000_i225.h
@@ -5,8 +5,22 @@
 #ifndef _E1000_I225_H_
 #define _E1000_I225_H_
 
+bool e1000_get_flash_presence_i225(struct e1000_hw *hw);
+s32 e1000_update_flash_i225(struct e1000_hw *hw);
+s32 e1000_update_nvm_checksum_i225(struct e1000_hw *hw);
+s32 e1000_validate_nvm_checksum_i225(struct e1000_hw *hw);
+s32 e1000_write_nvm_srwr_i225(struct e1000_hw *hw, u16 offset,
+			      u16 words, u16 *data);
+s32 e1000_read_nvm_srrd_i225(struct e1000_hw *hw, u16 offset,
+			     u16 words, u16 *data);
+s32 e1000_set_flsw_flash_burst_counter_i225(struct e1000_hw *hw,
+					    u32 burst_counter);
+s32 e1000_write_erase_flash_command_i225(struct e1000_hw *hw, u32 opcode,
+					 u32 address);
 s32 e1000_id_led_init_i225(struct e1000_hw *hw);
 s32 e1000_blink_led_i225(struct e1000_hw *hw);
+s32 e1000_acquire_swfw_sync_i225(struct e1000_hw *hw, u16 mask);
+void e1000_release_swfw_sync_i225(struct e1000_hw *hw, u16 mask);
 s32 e1000_init_hw_i225(struct e1000_hw *hw);
 s32 e1000_setup_copper_link_i225(struct e1000_hw *hw);
 s32 e1000_set_d0_lplu_state_i225(struct e1000_hw *hw, bool active);
@@ -19,6 +33,18 @@ s32 e1000_set_d3_lplu_state_i225(struct e1000_hw *hw, bool active);
 					 (ID_LED_DEF1_DEF2 <<  4) | \
 					 (ID_LED_OFF1_ON2))
 
+/* NVM offset defaults for I225 devices */
+#define NVM_INIT_CTRL_2_DEFAULT_I225	0X7243
+#define NVM_INIT_CTRL_4_DEFAULT_I225	0x00C1
+#define NVM_LED_1_CFG_DEFAULT_I225	0x0184
+#define NVM_LED_0_2_CFG_DEFAULT_I225	0x200C
+
+#define E1000_I225_SHADOW_RAM_SIZE		4096
+#define E1000_I225_ERASE_CMD_OPCODE		0x02000000
+#define E1000_I225_WRITE_CMD_OPCODE		0x01000000
+#define E1000_FLSWCTL_DONE			0x40000000
+#define E1000_FLSWCTL_CMDV			0x10000000
+
 /* LED Control */
 #define E1000_GLOBAL_BLINK_MODE	0x00000020 /*Blink at 200 ms on and 200 ms off.*/
 #define E1000_LED1_MODE_MASK	0x00000F00
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
diff --git a/drivers/net/intel/e1000/base/e1000_phy.c b/drivers/net/intel/e1000/base/e1000_phy.c
index a7e73112e5..6fac341d71 100644
--- a/drivers/net/intel/e1000/base/e1000_phy.c
+++ b/drivers/net/intel/e1000/base/e1000_phy.c
@@ -4171,6 +4171,69 @@ s32 e1000_read_phy_reg_gs40g(struct e1000_hw *hw, u32 offset, u16 *data)
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
index 87b4d407e5..a7834240e0 100644
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
@@ -131,6 +133,10 @@ s32 e1000_write_xmdio_reg(struct e1000_hw *hw, u16 addr, u8 dev_addr,
 #define E1000_I225_PHPM_ULP		0x0400 /* Ultra Low-Power Mode */
 #define E1000_I225_PHPM_DIS_2500	0x0800 /* Disable 2.5G globally */
 #define E1000_I225_PHPM_DIS_2500_D3	0x1000 /* Disable 2.5G in D3 */
+/* GPY211 - I225 defines */
+#define GPY_MMD_MASK			0xFFFF0000
+#define GPY_MMD_SHIFT			16
+#define GPY_REG_MASK			0x0000FFFF
 /* BM/HV Specific Registers */
 #define BM_PORT_CTRL_PAGE		769
 #define BM_WUC_PAGE			800
diff --git a/drivers/net/intel/e1000/base/e1000_regs.h b/drivers/net/intel/e1000/base/e1000_regs.h
index 20abeeaa46..b9d2a4484b 100644
--- a/drivers/net/intel/e1000/base/e1000_regs.h
+++ b/drivers/net/intel/e1000/base/e1000_regs.h
@@ -10,6 +10,9 @@
 #define E1000_STATUS	0x00008  /* Device Status - RO */
 #define E1000_EECD	0x00010  /* EEPROM/Flash Control - RW */
 #define E1000_EERD	0x00014  /* EEPROM Read - RW */
+#define E1000_EEWR	0x0102C  /* EEPROM Write Register - RW */
+#define E1000_EERD_V2	0x12014  /* EEprom mode read - RW */
+#define E1000_EEWR_V2	0x12018  /* EEprom mode write - RW */
 #define E1000_CTRL_EXT	0x00018  /* Extended Device Control - RW */
 #define E1000_FLA	0x0001C  /* Flash Access - RW */
 #define E1000_MDIC	0x00020  /* MDI Control - RW */
@@ -30,6 +33,11 @@
 #define E1000_FCAL	0x00028  /* Flow Control Address Low - RW */
 #define E1000_FCAH	0x0002C  /* Flow Control Address High -RW */
 #define E1000_FEXT	0x0002C  /* Future Extended - RW */
+#define E1000_I225_FLA		0x1201C /* FLASH access register */
+#define E1000_I225_FLSWCTL	0x12048 /* FLASH control register */
+#define E1000_I225_FLSWDATA	0x1204C /* FLASH data register */
+#define E1000_I225_FLSWCNT	0x12050 /* FLASH Access Counter */
+#define E1000_I225_FLSECU	0x12114 /* FLASH Security */
 #define E1000_FEXTNVM	0x00028  /* Future Extended NVM - RW */
 #define E1000_FEXTNVM3	0x0003C  /* Future Extended NVM 3 - RW */
 #define E1000_FEXTNVM4	0x00024  /* Future Extended NVM 4 - RW */
@@ -90,6 +98,7 @@
 #define E1000_EEMNGCTL_I225	0x01010  /* i225 MNG EEprom Mode Control */
 #define E1000_EEARBC	0x01024  /* EEPROM Auto Read Bus Control */
 #define E1000_EEARBC_I210	0x12024 /* EEPROM Auto Read Bus Control */
+#define E1000_EEARBC_I225	0x12024 /* EEPROM Auto Read Bus Control */
 #define E1000_FLASHT	0x01028  /* FLASH Timer Register */
 #define E1000_EEWR	0x0102C  /* EEPROM Write Register - RW */
 #define E1000_FLSWCTL	0x01030  /* FLASH control register */
-- 
2.43.5

