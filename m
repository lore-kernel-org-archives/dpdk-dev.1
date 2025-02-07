Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9C2C02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 12:47:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7C4F42E67;
	Fri,  7 Feb 2025 13:46:11 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 24FC942E6D
 for <dev@dpdk.org>; Fri,  7 Feb 2025 13:46:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738932371; x=1770468371;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=+Fc02A2hhgF7ex8jxfZbGOguxoI65i1Fr1DUMx+vGsw=;
 b=Q2/Wo4OcAzA4pOIvDFSALumrk+Qu28fXppWSK6vH9df4sILwd62pLg5X
 bpoOT21rpOCFhKQdi9JrR765fxrQDAxrPSH27tQXFdUBTQpAeTVtVqYL2
 +d0ReANrwJaKbNSPpFe1Rq53J7uCW+GXxYI+e2wKJW9xu4ZK3uAqKXfu7
 DaNopYGjtkH/emI6+MVaQreCA3cf+4I5qvRBQ4k7/p5sH11DOQ4+VlsUB
 9SI43oSs2qnvtsSbs/wMQiaU82XggXAJBO3ec2J9iD4ZJSJ2Vksn8s9YY
 gAuB51jExby5aCH7mMi18BTDoSte5m+m7cedcfmu8J/i0EaavP7Bx2sJA w==;
X-CSE-ConnectionGUID: /WfoFzF0QAmxQ1kQjNxtWg==
X-CSE-MsgGUID: zrO1HZp6TjWhSRiDPiUsKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43331829"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="43331829"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 04:46:10 -0800
X-CSE-ConnectionGUID: dczl/P5dT3uzieUh9bbujQ==
X-CSE-MsgGUID: Y8x6WiUiQy6eR8QgR1BiIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111953588"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa007.jf.intel.com with ESMTP; 07 Feb 2025 04:46:07 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v3 13/36] net/e1000/base: remove unused function
Date: Fri,  7 Feb 2025 12:45:05 +0000
Message-ID: <6523afb4eadee34630bdcd9f553a166a31e12164.1738932115.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738932113.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738932113.git.anatoly.burakov@intel.com>
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

From: Nir Efrati <nir.efrati@intel.com>

Integrated NVM is not supported on i225 and can be removed.

Signed-off-by: Nir Efrati <nir.efrati@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_i225.c | 98 +----------------------
 drivers/net/intel/e1000/base/e1000_i225.h |  2 -
 2 files changed, 1 insertion(+), 99 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_i225.c b/drivers/net/intel/e1000/base/e1000_i225.c
index 36cbe65ccd..d9e3ab2cbc 100644
--- a/drivers/net/intel/e1000/base/e1000_i225.c
+++ b/drivers/net/intel/e1000/base/e1000_i225.c
@@ -65,7 +65,7 @@ static s32 e1000_init_nvm_params_i225(struct e1000_hw *hw)
 		nvm->ops.validate = e1000_validate_nvm_checksum_i225;
 		nvm->ops.update   = e1000_update_nvm_checksum_i225;
 	} else {
-		hw->nvm.type = e1000_nvm_invm;
+		hw->nvm.type = e1000_nvm_none;
 		nvm->ops.write    = e1000_null_write_nvm;
 		nvm->ops.validate = e1000_null_ops_generic;
 		nvm->ops.update   = e1000_null_ops_generic;
@@ -591,102 +591,6 @@ static s32 __e1000_write_nvm_srwr(struct e1000_hw *hw, u16 offset, u16 words,
 	return ret_val;
 }
 
-/* e1000_read_invm_version_i225 - Reads iNVM version and image type
- * @hw: pointer to the HW structure
- * @invm_ver: version structure for the version read
- *
- * Reads iNVM version and image type.
- */
-s32 e1000_read_invm_version_i225(struct e1000_hw *hw,
-				 struct e1000_fw_version *invm_ver)
-{
-	u32 *record = NULL;
-	u32 *next_record = NULL;
-	u32 i = 0;
-	u32 invm_dword = 0;
-	u32 invm_blocks = E1000_INVM_SIZE - (E1000_INVM_ULT_BYTES_SIZE /
-					     E1000_INVM_RECORD_SIZE_IN_BYTES);
-	u32 buffer[E1000_INVM_SIZE];
-	s32 status = -E1000_ERR_INVM_VALUE_NOT_FOUND;
-	u16 version = 0;
-
-	DEBUGFUNC("e1000_read_invm_version_i225");
-
-	/* Read iNVM memory */
-	for (i = 0; i < E1000_INVM_SIZE; i++) {
-		invm_dword = E1000_READ_REG(hw, E1000_INVM_DATA_REG(i));
-		buffer[i] = invm_dword;
-	}
-
-	/* Read version number */
-	for (i = 1; i < invm_blocks; i++) {
-		record = &buffer[invm_blocks - i];
-		next_record = &buffer[invm_blocks - i + 1];
-
-		/* Check if we have first version location used */
-		if (i == 1 && (*record & E1000_INVM_VER_FIELD_ONE) == 0) {
-			version = 0;
-			status = E1000_SUCCESS;
-			break;
-		}
-		/* Check if we have second version location used */
-		else if ((i == 1) &&
-			 ((*record & E1000_INVM_VER_FIELD_TWO) == 0)) {
-			version = (*record & E1000_INVM_VER_FIELD_ONE) >> 3;
-			status = E1000_SUCCESS;
-			break;
-		}
-		/* Check if we have odd version location
-		 * used and it is the last one used
-		 */
-		else if ((((*record & E1000_INVM_VER_FIELD_ONE) == 0) &&
-			  ((*record & 0x3) == 0)) || (((*record & 0x3) != 0) &&
-			   (i != 1))) {
-			version = (*next_record & E1000_INVM_VER_FIELD_TWO)
-				  >> 13;
-			status = E1000_SUCCESS;
-			break;
-		}
-		/* Check if we have even version location
-		 * used and it is the last one used
-		 */
-		else if (((*record & E1000_INVM_VER_FIELD_TWO) == 0) &&
-			 ((*record & 0x3) == 0)) {
-			version = (*record & E1000_INVM_VER_FIELD_ONE) >> 3;
-			status = E1000_SUCCESS;
-			break;
-		}
-	}
-
-	if (status == E1000_SUCCESS) {
-		invm_ver->invm_major = (version & E1000_INVM_MAJOR_MASK)
-					>> E1000_INVM_MAJOR_SHIFT;
-		invm_ver->invm_minor = version & E1000_INVM_MINOR_MASK;
-	}
-	/* Read Image Type */
-	for (i = 1; i < invm_blocks; i++) {
-		record = &buffer[invm_blocks - i];
-		next_record = &buffer[invm_blocks - i + 1];
-
-		/* Check if we have image type in first location used */
-		if (i == 1 && (*record & E1000_INVM_IMGTYPE_FIELD) == 0) {
-			invm_ver->invm_img_type = 0;
-			status = E1000_SUCCESS;
-			break;
-		}
-		/* Check if we have image type in first location used */
-		else if ((((*record & 0x3) == 0) &&
-			  ((*record & E1000_INVM_IMGTYPE_FIELD) == 0)) ||
-			    ((((*record & 0x3) != 0) && (i != 1)))) {
-			invm_ver->invm_img_type =
-				(*next_record & E1000_INVM_IMGTYPE_FIELD) >> 23;
-			status = E1000_SUCCESS;
-			break;
-		}
-	}
-	return status;
-}
-
 /* e1000_validate_nvm_checksum_i225 - Validate EEPROM checksum
  * @hw: pointer to the HW structure
  *
diff --git a/drivers/net/intel/e1000/base/e1000_i225.h b/drivers/net/intel/e1000/base/e1000_i225.h
index b0414b6a36..ef4e646e02 100644
--- a/drivers/net/intel/e1000/base/e1000_i225.h
+++ b/drivers/net/intel/e1000/base/e1000_i225.h
@@ -13,8 +13,6 @@ s32 e1000_write_nvm_srwr_i225(struct e1000_hw *hw, u16 offset,
 			      u16 words, u16 *data);
 s32 e1000_read_nvm_srrd_i225(struct e1000_hw *hw, u16 offset,
 			     u16 words, u16 *data);
-s32 e1000_read_invm_version_i225(struct e1000_hw *hw,
-				 struct e1000_fw_version *invm_ver);
 s32 e1000_set_flsw_flash_burst_counter_i225(struct e1000_hw *hw,
 					    u32 burst_counter);
 s32 e1000_write_erase_flash_command_i225(struct e1000_hw *hw, u32 opcode,
-- 
2.43.5

