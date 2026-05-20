Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4421FCD4F3C
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 12:53:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6A5A40B90;
	Wed, 20 May 2026 14:53:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 8C91E406BC
 for <dev@dpdk.org>; Wed, 20 May 2026 14:53:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779281601; x=1810817601;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OeyIheMcVmU927n9luQ7IT6+rJmsgVnqdKu0SrJTwS4=;
 b=dM1J0tx6yRIod+JPnRpsGCVGXuGKm4/dWF4jXtJXuqbWtRXDgh+ZGobz
 BzsG8rgLN+nFMMgGdGuzvDTfNuSPrr3em4ksg7avSnOxM8QdMxguSmmPq
 xXpDXbcLki+uEAKAdI9xrU2+yMETGKXqx6+q5xefM5wenW4xp5xBvE03F
 pQjkeznSj1w+OU/J3ALhQ1BjnV91z96dfooTFZ8/N1x9PwYtNumw1+uoO
 DPgrcR0AbY74oFfCucNlOrnHm2flI0JEdOpkg4dPboO3Xg20dT+4f9dwU
 aWt4lBsmy7mJHAuII2TwyLs584j1ioWIYWGXuxILaYJ1XnTeRfclrBLWm A==;
X-CSE-ConnectionGUID: RIYZ/yawQO6AZYAiMEDt0Q==
X-CSE-MsgGUID: qjT04+gHQMSYelTdd746NA==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="91570277"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="91570277"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 05:53:20 -0700
X-CSE-ConnectionGUID: /XRTpF36Q+qxz+ctVYBa/w==
X-CSE-MsgGUID: HhrVnGWpThG/De3mjqR0jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="235908293"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa010.fm.intel.com with ESMTP; 20 May 2026 05:53:19 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Dima Ruinskiy <dima.ruinskiy@intel.com>,
 Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 06/10] net/e1000/base: fix coding style issues
Date: Wed, 20 May 2026 12:52:43 +0000
Message-ID: <20260520125256.354336-7-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520125256.354336-1-ciara.loftus@intel.com>
References: <20260520125256.354336-1-ciara.loftus@intel.com>
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

From: Dima Ruinskiy <dima.ruinskiy@intel.com>

Fix whitespace and tab inconsistencies.

Fixes: a3358d942fa9 ("net/e1000/base: enable new I219 devices")
Fixes: bdca22d62ff0 ("net/e1000/base: add PHY read/write retry mechanism")

Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/e1000/base/e1000_ich8lan.c | 6 +++---
 drivers/net/intel/e1000/base/e1000_phy.c     | 5 ++---
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_ich8lan.c b/drivers/net/intel/e1000/base/e1000_ich8lan.c
index 96b9ad6a70..e62847fb4e 100644
--- a/drivers/net/intel/e1000/base/e1000_ich8lan.c
+++ b/drivers/net/intel/e1000/base/e1000_ich8lan.c
@@ -4178,7 +4178,7 @@ STATIC s32 e1000_update_nvm_checksum_spt(struct e1000_hw *hw)
 
 		usec_delay(100);
 
-		/* Write the data to the new bank. Offset in words*/
+		/* Write the data to the new bank. Offset in words */
 		act_offset = i + new_bank_offset;
 		ret_val = e1000_retry_write_flash_dword_ich8lan(hw, act_offset,
 								dword);
@@ -4201,7 +4201,7 @@ STATIC s32 e1000_update_nvm_checksum_spt(struct e1000_hw *hw)
 	 */
 	act_offset = new_bank_offset + E1000_ICH_NVM_SIG_WORD;
 
-	/*offset in words but we read dword*/
+	/* offset in words but we read dword */
 	--act_offset;
 	ret_val = e1000_read_flash_dword_ich8lan(hw, act_offset, &dword);
 
@@ -4214,7 +4214,7 @@ STATIC s32 e1000_update_nvm_checksum_spt(struct e1000_hw *hw)
 	if (ret_val)
 		goto release;
 
-	/* offset in words but we read dword*/
+	/* offset in words but we read dword */
 	act_offset = old_bank_offset + E1000_ICH_NVM_SIG_WORD - 1;
 	ret_val = e1000_read_flash_dword_ich8lan(hw, act_offset, &dword);
 
diff --git a/drivers/net/intel/e1000/base/e1000_phy.c b/drivers/net/intel/e1000/base/e1000_phy.c
index b449c6ef42..31ef5089ba 100644
--- a/drivers/net/intel/e1000/base/e1000_phy.c
+++ b/drivers/net/intel/e1000/base/e1000_phy.c
@@ -253,7 +253,7 @@ s32 e1000_phy_reset_dsp_generic(struct e1000_hw *hw)
 	return hw->phy.ops.write_reg(hw, M88E1000_PHY_GEN_CONTROL, 0);
 }
 
-void e1000_disable_phy_retry_mechanism(struct e1000_hw* hw, u32* phy_retries_original)
+void e1000_disable_phy_retry_mechanism(struct e1000_hw *hw, u32 *phy_retries_original)
 {
 	DEBUGFUNC("e1000_disable_phy_retry_mechanism");
 
@@ -262,7 +262,7 @@ void e1000_disable_phy_retry_mechanism(struct e1000_hw* hw, u32* phy_retries_ori
 	hw->phy.current_retry_counter = 0;
 }
 
-void e1000_enable_phy_retry_mechanism(struct e1000_hw* hw, u32 phy_retries_original)
+void e1000_enable_phy_retry_mechanism(struct e1000_hw *hw, u32 phy_retries_original)
 {
 	DEBUGFUNC("e1000_enable_phy_retry_mechanism");
 
@@ -346,7 +346,6 @@ s32 e1000_read_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 *data)
 		}
 	}
 
-
 	return -E1000_ERR_PHY;
 }
 
-- 
2.43.0

