Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9B2C02196
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:14:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6532C427E6;
	Tue,  4 Feb 2025 16:12:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id BD5064279D
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:11:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681918; x=1770217918;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ke3W3JTLITkRJTMczt6OF/xb6JJm7WgzWR8ovCNgvCA=;
 b=A+yk8W1NPcHvteV8biWxaDTH2Km11KZlSsCLe8t2UQFZay0a7WwsHvaa
 g3pGLiVRAwRgT6DTrdn1bM7ciPDOp10aZZqjHzN5evwZKfeorO8amD7EI
 0i+uCyixyMz/Vvcgkgq6VtT+UydnyyjITgqk3M4rovjHDzFjX/kyOVntV
 N9XVYAh1T9t87t6GbXcJlAWG+OrsNdMdLdTQO9RAYrUJIWjz3UMgnOgLC
 hZaPxrad3i3z2lLmyEfkqwCWla1vkUdYNan0+82f7C77TBlYY+fCuVEgL
 Ae8N+jObkiz7FtmsjsT8LAZ7RxSIhH1TjEox2JNg4DdLEl3Gz+actkJ8S Q==;
X-CSE-ConnectionGUID: RBs70PlVTd6btjWTZ6NJ8Q==
X-CSE-MsgGUID: v+l0+U4BRHunqVpsdlRw9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097134"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097134"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:11:58 -0800
X-CSE-ConnectionGUID: L16dKPvBTCW51cydShzXzA==
X-CSE-MsgGUID: kj7WRPQDQhW5ARvw2RQ0Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792671"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:11:56 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 24/54] net/e1000/base: make set_ltr for i225 non-static
Date: Tue,  4 Feb 2025 15:10:30 +0000
Message-ID: <604177d6753c32510e0eb91bc4901343fc1a3d2c.1738681726.git.anatoly.burakov@intel.com>
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

Some tools need access to the function, so make it non-static.

Signed-off-by: Nir Efrati <nir.efrati@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_i225.c | 2 +-
 drivers/net/intel/e1000/base/e1000_i225.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/e1000/base/e1000_i225.c b/drivers/net/intel/e1000/base/e1000_i225.c
index ed4ac25a1c..a4f5b73724 100644
--- a/drivers/net/intel/e1000/base/e1000_i225.c
+++ b/drivers/net/intel/e1000/base/e1000_i225.c
@@ -908,7 +908,7 @@ s32 e1000_pool_flash_update_done_i225(struct e1000_hw *hw)
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

