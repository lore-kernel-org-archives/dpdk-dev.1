Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FBBC02194
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:15:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E8C242D87;
	Tue,  4 Feb 2025 16:12:20 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 8BA21427B9
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:12:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681926; x=1770217926;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VNpL6ecYUILDwTt8p2T3HB+Gj41rrYsZ9ahFLJexUqQ=;
 b=EGoNMvPPsCrFU1xHaH6jDKObCYCX24QT23jX2jJxjDEFIMGgCNl1gTFy
 gHkSP5aiVCmbgzeReYTEvFFE5kqkxrfhwpyKLpOC9YwubAEGgTIq6mEIl
 8SMvssWvcOiMgHOnB5FW66o25PYo6yi6yqF1izivQzwzRroKzTT6Zib0p
 HUhjR+Z9NIvA7+p4pqs6m4xSbSd+YFRZ4YpZsMUUvgaWXRV/IQayc16AB
 B2StDK22B0xCiKIaLKIvsQxRWHsUm1k2o4FoA2W3YWJ1sWitw+YTFCO6T
 caa3bUZlhiYMZ+awilOGtVusQtU/fYgLCgSlQP6KfVP1HtGiQ/VdNnPZ0 Q==;
X-CSE-ConnectionGUID: 262lL8wNQ7C+SXwWWnG96w==
X-CSE-MsgGUID: U/aoqS8DSbeCw9XicVysHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097146"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097146"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:12:06 -0800
X-CSE-ConnectionGUID: Wx8GhZ49SjmKsx+btdAnAQ==
X-CSE-MsgGUID: qg4gNm67QzCUr3FymOf8vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792706"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:12:04 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 30/54] net/e1000/base: add EEE common API function
Date: Tue,  4 Feb 2025 15:10:36 +0000
Message-ID: <802db306cad631101554c547676211755c6f43be.1738681726.git.anatoly.burakov@intel.com>
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
index c8d3114c28..b4607538e0 100644
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

