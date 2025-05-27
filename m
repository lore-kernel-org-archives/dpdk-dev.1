Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057B4C54F30
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 13:18:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF4F740BA4;
	Tue, 27 May 2025 15:18:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 2645540B94
 for <dev@dpdk.org>; Tue, 27 May 2025 15:17:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748351880; x=1779887880;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zvFWdZ6O6yisFaVOq2Ha+XoSUDTdUb0Pp504TZ056DQ=;
 b=fK0YEJ1McfsmZMGVT3qi0NYE6QiRUrDdGhPJyNrGSaN5fA7wNHaNqQW8
 ISdP6eAmevHR30BN0UzUaBApfH+VxSyArrBDLhmfkVlygPFnhMG6ko37e
 ubTQfLiIhFfR+lfDvSvR5n+S6p0HBPWnrW9hJyISLo2948TMvUoniWLj5
 wbY58n7wMJAM2UCep8FiLIYuOsNjLdDVCXYa2MuJUf7NO2/0TP+qHcqnI
 XNab0A5Sz0gsfA+wDrpa8oeZB/2XQN3Ym2YMev8z6+z4DI5uTtR8R8Q1j
 uU38hqou0t5e0XeK7jFvUqI+2mdHZojwN8u7Kn2Mx+aBZGV/tNftafQ2H A==;
X-CSE-ConnectionGUID: jTw/NVzzSFmL0taYTryB9w==
X-CSE-MsgGUID: XKEl/adTT/6zjHNNhfR3mQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="67884848"
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="67884848"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 06:18:00 -0700
X-CSE-ConnectionGUID: ATkLIJkbS22+e4Sj1rWzIQ==
X-CSE-MsgGUID: MPRgGTNTTpCPQw+sMthMxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="143150078"
Received: from unknown (HELO silpixa00401120.ir.intel.com) ([10.55.128.58])
 by fmviesa008.fm.intel.com with ESMTP; 27 May 2025 06:17:58 -0700
From: Dhanya Pillai <dhanya.r.pillai@intel.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Mikolaj Filar <mikolajx.filar@intel.com>,
 Dhanya Pillai <dhanya.r.pillai@intel.com>
Subject: [PATCH v3 07/10] net/ice/base: support for MAC rule with own filter
 flags
Date: Tue, 27 May 2025 13:17:26 +0000
Message-ID: <20250527131741.7606-8-dhanya.r.pillai@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250527131741.7606-1-dhanya.r.pillai@intel.com>
References: <20250527131741.7606-1-dhanya.r.pillai@intel.com>
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

From: Mikolaj Filar <mikolajx.filar@intel.com>

Current implementation of ice_add_mac_rule overwrites flags passed in
fltr_info member of the m_list with ICE_FLTR_TX. This implementation
allows to use own flags with a new ice_add_mac_with_fltr_flag function.
No functional change in MAC filters.

Signed-off-by: Mikolaj Filar <mikolajx.filar@intel.com>
Signed-off-by: Dhanya Pillai <dhanya.r.pillai@intel.com>
---
 drivers/net/intel/ice/base/ice_switch.c | 46 ++++++++++++++++++++++---
 drivers/net/intel/ice/base/ice_switch.h |  1 +
 2 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/ice/base/ice_switch.c b/drivers/net/intel/ice/base/ice_switch.c
index 468a9f055d..777fc88d01 100644
--- a/drivers/net/intel/ice/base/ice_switch.c
+++ b/drivers/net/intel/ice/base/ice_switch.c
@@ -5112,11 +5112,12 @@ ice_aq_get_res_descs(struct ice_hw *hw, u16 num_entries,
 }
 
 /**
- * ice_add_mac_rule - Add a MAC address based filter rule
+ * ice_add_mac_rule_with_fltr_flag - Add a MAC address based filter rule
  * @hw: pointer to the hardware structure
  * @m_list: list of MAC addresses and forwarding information
  * @sw: pointer to switch info struct for which function add rule
  * @lport: logic port number on which function add rule
+ * @flag: filter flag
  *
  * IMPORTANT: When the umac_shared flag is set to false and m_list has
  * multiple unicast addresses, the function assumes that all the
@@ -5125,8 +5126,8 @@ ice_aq_get_res_descs(struct ice_hw *hw, u16 num_entries,
  * list should be taken care of in the caller of this function.
  */
 static int
-ice_add_mac_rule(struct ice_hw *hw, struct LIST_HEAD_TYPE *m_list,
-		 struct ice_switch_info *sw, u8 lport)
+ice_add_mac_rule_with_fltr_flag(struct ice_hw *hw, struct LIST_HEAD_TYPE *m_list,
+			struct ice_switch_info *sw, u8 lport, u16 flag)
 {
 	struct ice_sw_recipe *recp_list = &sw->recp_list[ICE_SW_LKUP_MAC];
 	struct ice_sw_rule_lkup_rx_tx *s_rule, *r_iter;
@@ -5148,7 +5149,7 @@ ice_add_mac_rule(struct ice_hw *hw, struct LIST_HEAD_TYPE *m_list,
 		u16 vsi_handle;
 		u16 hw_vsi_id;
 
-		m_list_itr->fltr_info.flag = ICE_FLTR_TX;
+		m_list_itr->fltr_info.flag = flag;
 		vsi_handle = m_list_itr->fltr_info.vsi_handle;
 		if (!ice_is_vsi_valid(hw, vsi_handle))
 			return ICE_ERR_PARAM;
@@ -5268,6 +5269,26 @@ ice_add_mac_rule(struct ice_hw *hw, struct LIST_HEAD_TYPE *m_list,
 	return status;
 }
 
+/**
+ * ice_add_mac_rule - Add a MAC address based filter rule
+ * @hw: pointer to the hardware structure
+ * @m_list: list of MAC addresses and forwarding information
+ * @sw: pointer to switch info struct for which function add rule
+ * @lport: logic port number on which function add rule
+ *
+ * IMPORTANT: When the umac_shared flag is set to false and m_list has
+ * multiple unicast addresses, the function assumes that all the
+ * addresses are unique in a given add_mac call. It doesn't
+ * check for duplicates in this case, removing duplicates from a given
+ * list should be taken care of in the caller of this function.
+ */
+static int
+ice_add_mac_rule(struct ice_hw *hw, struct LIST_HEAD_TYPE *m_list,
+		 struct ice_switch_info *sw, u8 lport)
+{
+	return ice_add_mac_rule_with_fltr_flag(hw, m_list, sw, lport, ICE_FLTR_TX);
+}
+
 /**
  * ice_add_mac - Add a MAC address based filter rule
  * @hw: pointer to the hardware structure
@@ -5284,6 +5305,23 @@ int ice_add_mac(struct ice_hw *hw, struct LIST_HEAD_TYPE *m_list)
 				hw->port_info->lport);
 }
 
+/**
+ * ice_add_mac_with_fltr_flag - Add a MAC address based filter rule
+ * @hw: pointer to the hardware structure
+ * @m_list: list of MAC addresses and forwarding information
+ * @flag: filter flag
+ *
+ * Function add MAC rule for logical port from HW struct
+ */
+int ice_add_mac_with_fltr_flag(struct ice_hw *hw, struct LIST_HEAD_TYPE *m_list, u16 flag)
+{
+	if (!m_list || !hw)
+		return ICE_ERR_PARAM;
+
+	return ice_add_mac_rule_with_fltr_flag(hw, m_list, hw->switch_info,
+				hw->port_info->lport, flag);
+}
+
 /**
  * ice_add_vlan_internal - Add one VLAN based filter rule
  * @hw: pointer to the hardware structure
diff --git a/drivers/net/intel/ice/base/ice_switch.h b/drivers/net/intel/ice/base/ice_switch.h
index 00bffe4e4e..8eac7739fb 100644
--- a/drivers/net/intel/ice/base/ice_switch.h
+++ b/drivers/net/intel/ice/base/ice_switch.h
@@ -548,6 +548,7 @@ ice_add_vlan(struct ice_hw *hw, struct LIST_HEAD_TYPE *m_list);
 int ice_remove_vlan(struct ice_hw *hw, struct LIST_HEAD_TYPE *v_list);
 void ice_rem_all_sw_rules_info(struct ice_hw *hw);
 int ice_add_mac(struct ice_hw *hw, struct LIST_HEAD_TYPE *m_lst);
+int ice_add_mac_with_fltr_flag(struct ice_hw *hw, struct LIST_HEAD_TYPE *m_list, u16 flag);
 int ice_remove_mac(struct ice_hw *hw, struct LIST_HEAD_TYPE *m_lst);
 int
 ice_add_eth_mac(struct ice_hw *hw, struct LIST_HEAD_TYPE *em_list);
-- 
2.43.0

