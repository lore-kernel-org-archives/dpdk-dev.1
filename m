Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4969C0218F
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 13:01:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F4DC42E56;
	Fri, 31 Jan 2025 13:59:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 0CDFF42DDF
 for <dev@dpdk.org>; Fri, 31 Jan 2025 13:59:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738328384; x=1769864384;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=oLHWJ89QnnOb3+D6dwYkVy1YF5oZWkJYMAgrvRCmZnY=;
 b=DUQa4n8aRHBuyUWoxFzayvwBut8m90XBSDSjyIFEN+2gYfsIhgrIuZeu
 tKzEFoK7gt25RUtqZRYAYoYXUopv/ItJMhzgMpSg60IZPMHR93NLlRxsc
 Oob5SGo3ilDr+2fyY/svf4rX2e0ngSnTXX7zCds1amVGoO2s1gNn3TfKB
 akdcaeL+rogSay2zldgsoPO052ZW9Hj8vNGxFWnaGc4clkvicZCtcLz1g
 qv9SIyVEi8tnSz71Wk8dqAFM0yJtsaPi18VAzhiPgeFX1BVrH5ZhnTuVs
 K4EFDm3IgKelUymeVbgvg4ozfcthe4GDRZYjp/RR2NYt4LyNqwmjcqI4w A==;
X-CSE-ConnectionGUID: zpSFGPH4QMKYeOqSx/rtrw==
X-CSE-MsgGUID: oDcpW06sRWWuAoZIXdRLPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50315638"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="50315638"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 04:59:44 -0800
X-CSE-ConnectionGUID: t6sRz0mqSFCdqntsAB5ZlQ==
X-CSE-MsgGUID: a1qEY2GJQq2JAyz97iKUow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="140503398"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa001.fm.intel.com with ESMTP; 31 Jan 2025 04:59:43 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 18/42] net/e1000/base: add EEE common API function
Date: Fri, 31 Jan 2025 12:58:31 +0000
Message-ID: <f2c0c21b87ee63ea868caa5ae61bcc3bb49ad7b0.1738328107.git.anatoly.burakov@intel.com>
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

From: Evgeny Efimov <evgeny.efimov@intel.com>

Add enable/disable EEE API to base code.

Signed-off-by: Evgeny Efimov <evgeny.efimov@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_api.c  | 16 ++++++++++++++++
 drivers/net/intel/e1000/base/e1000_api.h  |  1 +
 drivers/net/intel/e1000/base/e1000_hw.h   |  1 +
 drivers/net/intel/e1000/base/e1000_i225.c |  2 ++
 4 files changed, 20 insertions(+)

diff --git a/drivers/net/intel/e1000/base/e1000_api.c b/drivers/net/intel/e1000/base/e1000_api.c
index bc7956cd01..1ab1cade27 100644
--- a/drivers/net/intel/e1000/base/e1000_api.c
+++ b/drivers/net/intel/e1000/base/e1000_api.c
@@ -1422,3 +1422,19 @@ void e1000_shutdown_fiber_serdes_link(struct e1000_hw *hw)
 		hw->mac.ops.shutdown_serdes(hw);
 }
 
+/**
+ *  e1000_set_eee - Set EEE
+ *  @hw: pointer to the HW structure
+ *  @adv2p5G: boolean flag enabling 2.5G EEE advertisement
+ *  @adv1G: boolean flag enabling 1G EEE advertisement
+ *  @adv100M: boolean flag enabling 100M EEE advertisement
+ *
+ *  Enable/disable EEE based on setting in dev_spec structure.
+ **/
+s32 e1000_set_eee(struct e1000_hw *hw, bool adv2p5G, bool adv1G, bool adv100M)
+{
+	if (hw->mac.ops.set_eee)
+		return hw->mac.ops.set_eee(hw, adv2p5G, adv1G, adv100M);
+
+	return -E1000_ERR_CONFIG;
+}
diff --git a/drivers/net/intel/e1000/base/e1000_api.h b/drivers/net/intel/e1000/base/e1000_api.h
index 2466c2fd48..591a3ddc3f 100644
--- a/drivers/net/intel/e1000/base/e1000_api.h
+++ b/drivers/net/intel/e1000/base/e1000_api.h
@@ -88,6 +88,7 @@ s32 e1000_mng_write_cmd_header(struct e1000_hw *hw,
 			       struct e1000_host_mng_command_header *hdr);
 s32 e1000_mng_write_dhcp_info(struct e1000_hw *hw, u8 *buffer, u16 length);
 u32  e1000_translate_register_82542(u32 reg);
+s32 e1000_set_eee(struct e1000_hw *hw, bool adv2p5G, bool adv1G, bool adv100M);
 
 
 
diff --git a/drivers/net/intel/e1000/base/e1000_hw.h b/drivers/net/intel/e1000/base/e1000_hw.h
index e98413d4b2..3743b8849d 100644
--- a/drivers/net/intel/e1000/base/e1000_hw.h
+++ b/drivers/net/intel/e1000/base/e1000_hw.h
@@ -748,6 +748,7 @@ struct e1000_mac_operations {
 	void (*update_mc_addr_list)(struct e1000_hw *, u8 *, u32);
 	s32  (*reset_hw)(struct e1000_hw *);
 	s32  (*init_hw)(struct e1000_hw *);
+	s32  (*set_eee)(struct e1000_hw *, bool, bool, bool);
 	void (*shutdown_serdes)(struct e1000_hw *);
 	void (*power_up_serdes)(struct e1000_hw *);
 	s32  (*setup_link)(struct e1000_hw *);
diff --git a/drivers/net/intel/e1000/base/e1000_i225.c b/drivers/net/intel/e1000/base/e1000_i225.c
index 067ec8924d..cfb61bad00 100644
--- a/drivers/net/intel/e1000/base/e1000_i225.c
+++ b/drivers/net/intel/e1000/base/e1000_i225.c
@@ -94,6 +94,8 @@ STATIC s32 e1000_init_mac_params_i225(struct e1000_hw *hw)
 	mac->mta_reg_count = 128;
 	/* Set rar entry count */
 	mac->rar_entry_count = E1000_RAR_ENTRIES_BASE;
+	/* Set EEE */
+	mac->ops.set_eee = e1000_set_eee_i225;
 	/* bus type/speed/width */
 	mac->ops.get_bus_info = e1000_get_bus_info_pcie_generic;
 	/* reset */
-- 
2.43.5

