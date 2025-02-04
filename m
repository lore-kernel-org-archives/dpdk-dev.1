Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40744C02196
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:13:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6667C427A3;
	Tue,  4 Feb 2025 16:11:59 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id BCB524270A
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:11:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681905; x=1770217905;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=waIRMuvTRQugc7eZ/EndEPJQfnjDVFgVk5WzeEC0HUY=;
 b=TwShsi2Vr0Qbw/ot/iG9fWMrz52W2t3einp3O3sliSIbLFBEm4BC86dM
 H5JlysmtYZbdDJKiIpEcZld2DuTYBH+AhxJXpz+cF96PKYLYq+xff9o3/
 XTzbehbNIaTmiwnPHSG/RUv3W1cButWuNACc5zzOGTg7ZP1iTd+Yx7F7f
 33CYwqx1UXywTrxW7DnEKqHVBrMt5LnA3WxgbFqBfYSwGtTWiwFh6OCwD
 eyVeYg5DCMxdtA6t3vnqv+5BfcgfkrQ/fZBlUBtCqBQHSRwBjNKs5C63P
 Xi4GSHRAxhDpPORov2sLxA6+r7xRqJBhNhC7sQ/2zgW4Gep/uG9faa+6z Q==;
X-CSE-ConnectionGUID: KdCp29mLTmiuqHYaOwrDGw==
X-CSE-MsgGUID: S/jjuOlgS8Wy5WGuR2SvjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097112"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097112"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:11:45 -0800
X-CSE-ConnectionGUID: 3MLI9LuISZW3PSJZ7DH1SQ==
X-CSE-MsgGUID: Jebj6Xu+R4efB/hB/IQUxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792616"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:11:43 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 13/54] net/e1000/base: remove unused function
Date: Tue,  4 Feb 2025 15:10:19 +0000
Message-ID: <1991962cd0c1dc89188bbc6f4277d171c419034f.1738681726.git.anatoly.burakov@intel.com>
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

From: Nir Efrati <nir.efrati@intel.com>

Integrated NVM is not supported on i225 and can be removed.

Signed-off-by: Nir Efrati <nir.efrati@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_i225.c | 98 +----------------------
 drivers/net/intel/e1000/base/e1000_i225.h |  2 -
 2 files changed, 1 insertion(+), 99 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_i225.c b/drivers/net/intel/e1000/base/e1000_i225.c
index 13b4465b9c..a6f113608b 100644
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
@@ -584,102 +584,6 @@ static s32 __e1000_write_nvm_srwr(struct e1000_hw *hw, u16 offset, u16 words,
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

