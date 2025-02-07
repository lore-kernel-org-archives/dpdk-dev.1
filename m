Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE12C02199
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 12:47:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60E3642E85;
	Fri,  7 Feb 2025 13:46:16 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id E0F9442E73
 for <dev@dpdk.org>; Fri,  7 Feb 2025 13:46:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738932373; x=1770468373;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=iuXXvTJ80uhCgnW5FI2q0hescRsqPxi8rwDsLWP2ReQ=;
 b=JkyFCzbLCuhxuyU+/fUxyQQgWI7npskj5tgqnN/pA0NiCdnkKv6Uhh5E
 y+b80WOmPQh4OW8ng+66Kd0EmHl+BrZBwn+1AKyk8WdLdNm/SWS8KV8rx
 oouXul4n+GBTwZxnLxn6NB3CmymHOU2n+KKShaMNkEU4nXs30CTRJtUv8
 HV3gmqFUI2EhPoJBDQLOaDKQBLMjwge0ipkaob/puN91DwKKM3jmAQvNV
 kL4dwYqeOrE+zWFJ/z98KRVu/v5p8yQufvR6aII0xS3+AC5ixFnR+tlLE
 KCnaWddCTSECDHxaPVJurW/Jb1soIQhhKnrDTrMX5PKhuqG+0ZOoU6t8H A==;
X-CSE-ConnectionGUID: klZujlD9SEGFANTWef/BKg==
X-CSE-MsgGUID: 6MAyqf97SSOwhiyJHbNFHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43331833"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="43331833"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 04:46:13 -0800
X-CSE-ConnectionGUID: Gx0qdCyuTfugpEy3kyESIw==
X-CSE-MsgGUID: 11NeHbMNTsWJD4u49Gff0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111953644"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa007.jf.intel.com with ESMTP; 07 Feb 2025 04:46:11 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v3 16/36] net/e1000/base: make i225 set LTR non-static
Date: Fri,  7 Feb 2025 12:45:08 +0000
Message-ID: <86f23e8ca92b4bf3e02ab2a9d12bb47f5e255596.1738932115.git.anatoly.burakov@intel.com>
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

Some tools need access to the function, so make it non-static.

Signed-off-by: Nir Efrati <nir.efrati@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_i225.c | 2 +-
 drivers/net/intel/e1000/base/e1000_i225.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/e1000/base/e1000_i225.c b/drivers/net/intel/e1000/base/e1000_i225.c
index b8b57b6628..490165acf0 100644
--- a/drivers/net/intel/e1000/base/e1000_i225.c
+++ b/drivers/net/intel/e1000/base/e1000_i225.c
@@ -907,7 +907,7 @@ s32 e1000_pool_flash_update_done_i225(struct e1000_hw *hw)
  * Set the LTR thresholds based on the link speed (Mbps), EEE, and DMAC
  * settings, otherwise specify that there is no LTR requirement.
  */
-static s32 e1000_set_ltr_i225(struct e1000_hw *hw, bool link)
+s32 e1000_set_ltr_i225(struct e1000_hw *hw, bool link)
 {
 	u16 speed, duplex;
 	u32 tw_system, ltrc, ltrv, ltr_min, ltr_max, scale_min, scale_max;
diff --git a/drivers/net/intel/e1000/base/e1000_i225.h b/drivers/net/intel/e1000/base/e1000_i225.h
index 61b049b1f4..33d8f7b630 100644
--- a/drivers/net/intel/e1000/base/e1000_i225.h
+++ b/drivers/net/intel/e1000/base/e1000_i225.h
@@ -20,6 +20,7 @@ s32 e1000_write_erase_flash_command_i225(struct e1000_hw *hw, u32 opcode,
 s32 e1000_id_led_init_i225(struct e1000_hw *hw);
 s32 e1000_blink_led_i225(struct e1000_hw *hw);
 s32 e1000_check_for_link_i225(struct e1000_hw *hw);
+s32 e1000_set_ltr_i225(struct e1000_hw *hw, bool link);
 s32 e1000_acquire_swfw_sync_i225(struct e1000_hw *hw, u16 mask);
 void e1000_release_swfw_sync_i225(struct e1000_hw *hw, u16 mask);
 s32 e1000_init_hw_i225(struct e1000_hw *hw);
-- 
2.43.5

