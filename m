Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3C2C02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 12:48:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1793442E37;
	Fri,  7 Feb 2025 13:46:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 85A4842E89
 for <dev@dpdk.org>; Fri,  7 Feb 2025 13:46:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738932377; x=1770468377;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=vTh8zCRtYCL8Kexp2vUMcirUrRc0ZKRa3s5vnw2FGTE=;
 b=GYaSbP0hEpR4Ii+IQSOkMKx/YcaDIl+X+/ptFbBgxLOfQpQN6kBP5Fst
 /2cdBbf1oPUDL8BPAJuXvK2s+YndwHF4YA3Zt3kIU+R+ID276eF/QjgKT
 XYKrT+hxc/txPCJHVHVcec0ClOoXSNyjpIT3IyFLRuL2n1iqo02ttgxu/
 EdxMSp9BTN99ZFqLb3BQqDeJAEt3+wZMDNr+6vbgf90YuD+fCNFPgJ8wY
 8Wp2m9EK0/8RrGyKcOHYjp4Udg8/vC/sNaP9IDJOfG8MYQWNjBVmjnPRD
 RpfhM2/h8VCPCDiJS4iRxeuX2+oDTIE9AqYAd62w3w+PEDq+/bw9coFXh A==;
X-CSE-ConnectionGUID: Qex823srSYCL+n0RizUVPQ==
X-CSE-MsgGUID: pIBJEobXRyqPwHoOtiAh9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43331845"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="43331845"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 04:46:17 -0800
X-CSE-ConnectionGUID: vJPOqiaCTyOvMOsxCRfbMQ==
X-CSE-MsgGUID: xczOPbm3R0yLW3ccyGHybw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111953683"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa007.jf.intel.com with ESMTP; 07 Feb 2025 04:46:15 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v3 19/36] net/e1000/base: add EEE common API function
Date: Fri,  7 Feb 2025 12:45:11 +0000
Message-ID: <bbfc7d535e1615ab67469b5832c4a5bdb0183aa9.1738932115.git.anatoly.burakov@intel.com>
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

From: Evgeny Efimov <evgeny.efimov@intel.com>

Add enable/disable EEE API to base code.

Signed-off-by: Evgeny Efimov <evgeny.efimov@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_api.c  | 17 +++++++++++++++++
 drivers/net/intel/e1000/base/e1000_api.h  |  1 +
 drivers/net/intel/e1000/base/e1000_hw.h   |  1 +
 drivers/net/intel/e1000/base/e1000_i225.c |  2 ++
 4 files changed, 21 insertions(+)

diff --git a/drivers/net/intel/e1000/base/e1000_api.c b/drivers/net/intel/e1000/base/e1000_api.c
index 0d55f1b761..e51e887f01 100644
--- a/drivers/net/intel/e1000/base/e1000_api.c
+++ b/drivers/net/intel/e1000/base/e1000_api.c
@@ -1420,3 +1420,20 @@ void e1000_shutdown_fiber_serdes_link(struct e1000_hw *hw)
 	if (hw->mac.ops.shutdown_serdes)
 		hw->mac.ops.shutdown_serdes(hw);
 }
+
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
index a1fb94b63c..b3af96977c 100644
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
index 490165acf0..4d3d65a6ef 100644
--- a/drivers/net/intel/e1000/base/e1000_i225.c
+++ b/drivers/net/intel/e1000/base/e1000_i225.c
@@ -94,6 +94,8 @@ static s32 e1000_init_mac_params_i225(struct e1000_hw *hw)
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

