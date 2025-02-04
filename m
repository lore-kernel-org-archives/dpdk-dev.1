Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0629C02196
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:16:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84D9442E46;
	Tue,  4 Feb 2025 16:12:32 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 1FBCF42D6A
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:12:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681940; x=1770217940;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fJun1x1+U/rnUBW1zxKpybMTISfu+CgQBzpZ+DoUnFw=;
 b=UURwxsH+iVM4Os7E51JKk3R3nNIqdX1VrPcPv4osu2VbggHVz+D/fihI
 0cK5Cn1BtEDoaPPN1I17+WiCD/lkSy2iA+p+Qhzb8ypKdGG2+mjePpp6P
 9TiOR5KWELgIdvWuohlD3rz5Aarfmg4lsrQnLCN99Bzk1egLNLVL81D7E
 N0IkG7AGNnFX2XnMufqp6C1oqF1Nt5nIa/QygwEP0tabwGuk/VLTBHb2x
 /O4VaEpG0SSO92PE/OkudWf9Uc7Jhef5cJDp5/f/GoHDBxoBeKFn9PgJA
 7SuNwbq+0R6OLVFnOzNEi7Fs6VCfMUU7vmvztfql5TFtbfxBYBou8k/eo g==;
X-CSE-ConnectionGUID: nEqR+V7CT/+ai3ASSh93pQ==
X-CSE-MsgGUID: fVcqjxbfRAKT/YwpB0PZ9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097172"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097172"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:12:19 -0800
X-CSE-ConnectionGUID: yGN2oPv8QT643QZymFnfYg==
X-CSE-MsgGUID: JalZP2aERv29PWK6G+N91A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792755"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:12:18 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 41/54] net/e1000/base: improve NVM checksum handling
Date: Tue,  4 Feb 2025 15:10:47 +0000
Message-ID: <85fe8bf1df8039b315e2d5cbfa17bcf3f42afe59.1738681726.git.anatoly.burakov@intel.com>
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

From: Sasha Neftin <sasha.neftin@intel.com>

When reading NVM checksum, we may encounter the following scenarios:

- Checksum may be invalid, and can be updated
- Checksum may be invalid but cannot be updated because NVM is read-only

For the latter case, we should just ignore invalid checksum and not attempt
to update it.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_ich8lan.c | 24 ++++++++++++++------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_ich8lan.c b/drivers/net/intel/e1000/base/e1000_ich8lan.c
index da36d4c098..77c403fa80 100644
--- a/drivers/net/intel/e1000/base/e1000_ich8lan.c
+++ b/drivers/net/intel/e1000/base/e1000_ich8lan.c
@@ -4364,13 +4364,23 @@ STATIC s32 e1000_validate_nvm_checksum_ich8lan(struct e1000_hw *hw)
 		return ret_val;
 
 	if (!(data & valid_csum_mask)) {
-		data |= valid_csum_mask;
-		ret_val = hw->nvm.ops.write(hw, word, 1, &data);
-		if (ret_val)
-			return ret_val;
-		ret_val = hw->nvm.ops.update(hw);
-		if (ret_val)
-			return ret_val;
+		DEBUGOUT("NVM checksum valid bit not set");
+
+		if (hw->mac.type < e1000_pch_tgp) {
+			data |= valid_csum_mask;
+			ret_val = hw->nvm.ops.write(hw, word, 1, &data);
+			if (ret_val)
+				return ret_val;
+			ret_val = hw->nvm.ops.update(hw);
+			if (ret_val)
+				return ret_val;
+		} else if (hw->mac.type == e1000_pch_tgp) {
+			/* Tiger Lake systems may have uninitialized NVM
+			 * checksum. Since the NVM cannot be updated by
+			 * software, do not validate the checksum.
+			 */
+			return E1000_SUCCESS;
+		}
 	}
 
 	return e1000_validate_nvm_checksum_generic(hw);
-- 
2.43.5

