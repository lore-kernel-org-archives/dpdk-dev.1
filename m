Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DC9C61CE8
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 10:26:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4636940E28;
	Mon,  9 Jun 2025 12:25:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id B069140DF6
 for <dev@dpdk.org>; Mon,  9 Jun 2025 12:25:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749464748; x=1781000748;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=vrDre07shhexk9prQYi93t0WbAcX+bX2SqEylJSAMV0=;
 b=QN9HRBjuj6rgWIPa0II9BdO7i6ThgpnHI3Z4/7Q4EQCw2PUpZbvtygNY
 48mKnvWqWeNku06jLfnbKqzZeZbdpDra5lq4aLvGNAGKzsOo+BH/D2IT0
 PMtAEWOuleBXg6XfLIOnJRhX2VSY4DxLqixAaenpexLddZ4n54xy7EDGL
 yr+qco4W8NPYA6y6oNjm3pIveLXvobHip8NCOPk1yAw8oo0OQH9mM0kpR
 sIjjheG95yucqx8Zo7KrhmLdkiTdoNwxDF4OkLrrOSo9eymEU4LpHIZm4
 NwTeFotT47MdP0Fo33EwUnTJMPTtLz4vg77Y7LYHf1xRP34TKcyc+7Xhm w==;
X-CSE-ConnectionGUID: B8QglmjjSFqqQEWJLNyuLA==
X-CSE-MsgGUID: Olr3PL7gT2azwSsWa8+L4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="51448509"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="51448509"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 03:25:47 -0700
X-CSE-ConnectionGUID: nVtuJXfSSSWPgDS80xpXbA==
X-CSE-MsgGUID: Q5QFCTU6RmuipDXxPq31lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="146356441"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa006.fm.intel.com with ESMTP; 09 Jun 2025 03:25:46 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v1 3/5] net/ixgbe: add support for toggling VF Tx queues
Date: Mon,  9 Jun 2025 11:25:36 +0100
Message-ID: <928a2d2b299a7c3a35517ade3a1b6e0d62d82461.1749464704.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1749464704.git.anatoly.burakov@intel.com>
References: 
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

From: Piotr Pietruszewski <piotr.pietruszewski@intel.com>

Add method to toggle VF's TX queues to work around silicon errata.

Signed-off-by: Piotr Pietruszewski <piotr.pietruszewski@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/base/ixgbe_api.c    | 13 +++++
 drivers/net/intel/ixgbe/base/ixgbe_api.h    |  1 +
 drivers/net/intel/ixgbe/base/ixgbe_common.c | 56 +++++++++++++++++++++
 drivers/net/intel/ixgbe/base/ixgbe_common.h |  1 +
 drivers/net/intel/ixgbe/base/ixgbe_type.h   |  1 +
 5 files changed, 72 insertions(+)

diff --git a/drivers/net/intel/ixgbe/base/ixgbe_api.c b/drivers/net/intel/ixgbe/base/ixgbe_api.c
index ffff670dd3..6caa68b5c5 100644
--- a/drivers/net/intel/ixgbe/base/ixgbe_api.c
+++ b/drivers/net/intel/ixgbe/base/ixgbe_api.c
@@ -1116,6 +1116,19 @@ s32 ixgbe_set_vlvf(struct ixgbe_hw *hw, u32 vlan, u32 vind, bool vlan_on,
 			       IXGBE_NOT_IMPLEMENTED);
 }
 
+/**
+ * ixgbe_toggle_txdctl - Toggle VF's queues
+ * @hw: pointer to hardware structure
+ * @vind: VMDq pool index
+ *
+ * Enable and disable each queue in VF.
+ */
+s32 ixgbe_toggle_txdctl(struct ixgbe_hw *hw, u32 vind)
+{
+	return ixgbe_call_func(hw, hw->mac.ops.toggle_txdctl, (hw,
+			       vind), IXGBE_NOT_IMPLEMENTED);
+}
+
 /**
  * ixgbe_fc_enable - Enable flow control
  * @hw: pointer to hardware structure
diff --git a/drivers/net/intel/ixgbe/base/ixgbe_api.h b/drivers/net/intel/ixgbe/base/ixgbe_api.h
index 5d2b2313eb..4f166f729a 100644
--- a/drivers/net/intel/ixgbe/base/ixgbe_api.h
+++ b/drivers/net/intel/ixgbe/base/ixgbe_api.h
@@ -102,6 +102,7 @@ s32 ixgbe_set_vfta(struct ixgbe_hw *hw, u32 vlan,
 s32 ixgbe_set_vlvf(struct ixgbe_hw *hw, u32 vlan, u32 vind,
 		   bool vlan_on, u32 *vfta_delta, u32 vfta,
 		   bool vlvf_bypass);
+s32 ixgbe_toggle_txdctl(struct ixgbe_hw *hw, u32 vind);
 s32 ixgbe_fc_enable(struct ixgbe_hw *hw);
 s32 ixgbe_setup_fc(struct ixgbe_hw *hw);
 s32 ixgbe_set_fw_drv_ver(struct ixgbe_hw *hw, u8 maj, u8 min, u8 build,
diff --git a/drivers/net/intel/ixgbe/base/ixgbe_common.c b/drivers/net/intel/ixgbe/base/ixgbe_common.c
index fbc9605e4d..099bdce568 100644
--- a/drivers/net/intel/ixgbe/base/ixgbe_common.c
+++ b/drivers/net/intel/ixgbe/base/ixgbe_common.c
@@ -104,6 +104,7 @@ s32 ixgbe_init_ops_generic(struct ixgbe_hw *hw)
 	mac->ops.init_uta_tables = NULL;
 	mac->ops.enable_rx = ixgbe_enable_rx_generic;
 	mac->ops.disable_rx = ixgbe_disable_rx_generic;
+	mac->ops.toggle_txdctl = ixgbe_toggle_txdctl_generic;
 
 	/* Flow Control */
 	mac->ops.fc_enable = ixgbe_fc_enable_generic;
@@ -4107,6 +4108,61 @@ s32 ixgbe_clear_vfta_generic(struct ixgbe_hw *hw)
 	return IXGBE_SUCCESS;
 }
 
+/**
+ * ixgbe_toggle_txdctl_generic - Toggle VF's queues
+ * @hw: pointer to hardware structure
+ * @vf_number: VF index
+ *
+ * Enable and disable each queue in VF.
+ */
+s32 ixgbe_toggle_txdctl_generic(struct ixgbe_hw *hw, u32 vf_number)
+{
+	u8  queue_count, i;
+	u32 offset, reg;
+
+	if (vf_number > 63)
+		return IXGBE_ERR_PARAM;
+
+	/*
+	 * Determine number of queues by checking
+	 * number of virtual functions
+	 */
+	reg = IXGBE_READ_REG(hw, IXGBE_GCR_EXT);
+	switch (reg & IXGBE_GCR_EXT_VT_MODE_MASK) {
+	case IXGBE_GCR_EXT_VT_MODE_64:
+		queue_count = 2;
+		break;
+	case IXGBE_GCR_EXT_VT_MODE_32:
+		queue_count = 4;
+		break;
+	case IXGBE_GCR_EXT_VT_MODE_16:
+		queue_count = 8;
+		break;
+	default:
+		return IXGBE_ERR_CONFIG;
+	}
+
+	/* Toggle queues */
+	for (i = 0; i < queue_count; ++i) {
+		/* Calculate offset of current queue */
+		offset = queue_count * vf_number + i;
+
+		/* Enable queue */
+		reg = IXGBE_READ_REG(hw, IXGBE_PVFTXDCTL(offset));
+		reg |= IXGBE_TXDCTL_ENABLE;
+		IXGBE_WRITE_REG(hw, IXGBE_PVFTXDCTL(offset), reg);
+		IXGBE_WRITE_FLUSH(hw);
+
+		/* Disable queue */
+		reg = IXGBE_READ_REG(hw, IXGBE_PVFTXDCTL(offset));
+		reg &= ~IXGBE_TXDCTL_ENABLE;
+		IXGBE_WRITE_REG(hw, IXGBE_PVFTXDCTL(offset), reg);
+		IXGBE_WRITE_FLUSH(hw);
+	}
+
+	return IXGBE_SUCCESS;
+}
+
 /**
  * ixgbe_need_crosstalk_fix - Determine if we need to do cross talk fix
  * @hw: pointer to hardware structure
diff --git a/drivers/net/intel/ixgbe/base/ixgbe_common.h b/drivers/net/intel/ixgbe/base/ixgbe_common.h
index bc4466ddf3..b4f469500f 100644
--- a/drivers/net/intel/ixgbe/base/ixgbe_common.h
+++ b/drivers/net/intel/ixgbe/base/ixgbe_common.h
@@ -111,6 +111,7 @@ s32 ixgbe_set_vlvf_generic(struct ixgbe_hw *hw, u32 vlan, u32 vind,
 			   bool vlvf_bypass);
 s32 ixgbe_clear_vfta_generic(struct ixgbe_hw *hw);
 s32 ixgbe_find_vlvf_slot(struct ixgbe_hw *hw, u32 vlan, bool vlvf_bypass);
+s32 ixgbe_toggle_txdctl_generic(struct ixgbe_hw *hw, u32 vind);
 
 s32 ixgbe_check_mac_link_generic(struct ixgbe_hw *hw,
 			       ixgbe_link_speed *speed,
diff --git a/drivers/net/intel/ixgbe/base/ixgbe_type.h b/drivers/net/intel/ixgbe/base/ixgbe_type.h
index 99ae823119..73f7eeabab 100644
--- a/drivers/net/intel/ixgbe/base/ixgbe_type.h
+++ b/drivers/net/intel/ixgbe/base/ixgbe_type.h
@@ -4026,6 +4026,7 @@ struct ixgbe_mac_operations {
 	void (*set_vlan_anti_spoofing)(struct ixgbe_hw *, bool, int);
 	s32 (*update_xcast_mode)(struct ixgbe_hw *, int);
 	s32 (*set_rlpml)(struct ixgbe_hw *, u16);
+	s32 (*toggle_txdctl)(struct ixgbe_hw *hw, u32 vf_index);
 
 	/* Flow Control */
 	s32 (*fc_enable)(struct ixgbe_hw *);
-- 
2.47.1

