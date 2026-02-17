Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413B2E6817B
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 12:16:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A327840A70;
	Tue, 17 Feb 2026 13:14:58 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 5503D40664
 for <dev@dpdk.org>; Tue, 17 Feb 2026 13:14:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771330491; x=1802866491;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=IMtBHo+Nc57iMBdcJskMyVEvXDQyEh2eyJ48gfqCYVU=;
 b=nYKFwx41CDn5UjGcUo1aFDBcVGxeqDCDNMESJBRQo7BOucMM1PrQHcWC
 5mLssV+wndnRyXRZpsrLXVhApUFFyYFSbkEBcFC2bWxS4pHtlOeG5m8MP
 Bpxk3MHB9oRC8kvcuIcanw0WxV7jzAEzJ9HGUFpjzVdJ+8dm2fE6a0RQl
 GM7sGtNrLFzrAQzdFshWgtZdg3zE9OvsjtQbN3xUtnlqXx9WUqhL7jwIM
 Ydmw80ASiP/vhtgswYtsdgxBDARj9LYoGCouvX3UDByDgwOEiYlL4oKcJ
 c4caqaRkD1AerWNOC0k0mwtl7HKC7GDdBTbzIXTGAuVLTavIWkIjZ32zu w==;
X-CSE-ConnectionGUID: 4k3w9woWSB2pyV/HRDvnmQ==
X-CSE-MsgGUID: N7bsc3PMSoGxdynU8LS9mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="74996032"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="74996032"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 04:14:51 -0800
X-CSE-ConnectionGUID: P+K858eKQ4muWyJ/9X6EjA==
X-CSE-MsgGUID: uSLvAsPhTmGrO6bdiX3pAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="218396800"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 17 Feb 2026 04:14:51 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 11/27] net/i40e: avoid rte malloc in MAC/VLAN filtering
Date: Tue, 17 Feb 2026 12:14:00 +0000
Message-ID: <dda55b68b2b70484cb366d680a7fefaff6408959.1771330391.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771330390.git.anatoly.burakov@intel.com>
 <cover.1771330390.git.anatoly.burakov@intel.com>
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

Currently, when adding, removing, or configuring MAC and VLAN filters,
we are using rte_zmalloc followed by an immediate rte_free. This is not
needed as this memory is not being stored anywhere, so replace it with
regular malloc/free.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.c  | 38 +++++++++++++--------------
 drivers/net/intel/i40e/rte_pmd_i40e.c | 16 +++++------
 2 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index 23a8f625ef..1160acc551 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -4165,8 +4165,7 @@ i40e_vlan_offload_set(struct rte_eth_dev *dev, int mask)
 	if (mask & RTE_ETH_VLAN_EXTEND_MASK) {
 		i = 0;
 		num = vsi->mac_num;
-		mac_filter = rte_zmalloc("mac_filter_info_data",
-				 num * sizeof(*mac_filter), 0);
+		mac_filter = calloc(num, sizeof(*mac_filter));
 		if (mac_filter == NULL) {
 			PMD_DRV_LOG(ERR, "failed to allocate memory");
 			return I40E_ERR_NO_MEMORY;
@@ -4206,7 +4205,7 @@ i40e_vlan_offload_set(struct rte_eth_dev *dev, int mask)
 			if (ret)
 				PMD_DRV_LOG(ERR, "i40e vsi add mac fail.");
 		}
-		rte_free(mac_filter);
+		free(mac_filter);
 	}
 
 	if (mask & RTE_ETH_QINQ_STRIP_MASK) {
@@ -6231,8 +6230,7 @@ i40e_vsi_config_vlan_filter(struct i40e_vsi *vsi, bool on)
 
 	num = vsi->mac_num;
 
-	mac_filter = rte_zmalloc("mac_filter_info_data",
-				 num * sizeof(*mac_filter), 0);
+	mac_filter = calloc(num, sizeof(*mac_filter));
 	if (mac_filter == NULL) {
 		PMD_DRV_LOG(ERR, "failed to allocate memory");
 		return I40E_ERR_NO_MEMORY;
@@ -6264,7 +6262,7 @@ i40e_vsi_config_vlan_filter(struct i40e_vsi *vsi, bool on)
 	}
 
 DONE:
-	rte_free(mac_filter);
+	free(mac_filter);
 	return ret;
 }
 
@@ -7154,7 +7152,7 @@ i40e_add_macvlan_filters(struct i40e_vsi *vsi,
 	ele_num = hw->aq.asq_buf_size / sizeof(*req_list);
 	ele_buff_size = hw->aq.asq_buf_size;
 
-	req_list = rte_zmalloc("macvlan_add", ele_buff_size, 0);
+	req_list = calloc(1, ele_buff_size);
 	if (req_list == NULL) {
 		PMD_DRV_LOG(ERR, "Fail to allocate memory");
 		return I40E_ERR_NO_MEMORY;
@@ -7207,7 +7205,7 @@ i40e_add_macvlan_filters(struct i40e_vsi *vsi,
 	} while (num < total);
 
 DONE:
-	rte_free(req_list);
+	free(req_list);
 	return ret;
 }
 
@@ -7230,7 +7228,7 @@ i40e_remove_macvlan_filters(struct i40e_vsi *vsi,
 	ele_num = hw->aq.asq_buf_size / sizeof(*req_list);
 	ele_buff_size = hw->aq.asq_buf_size;
 
-	req_list = rte_zmalloc("macvlan_remove", ele_buff_size, 0);
+	req_list = calloc(1, ele_buff_size);
 	if (req_list == NULL) {
 		PMD_DRV_LOG(ERR, "Fail to allocate memory");
 		return I40E_ERR_NO_MEMORY;
@@ -7286,7 +7284,7 @@ i40e_remove_macvlan_filters(struct i40e_vsi *vsi,
 	} while (num < total);
 
 DONE:
-	rte_free(req_list);
+	free(req_list);
 	return ret;
 }
 
@@ -7455,7 +7453,7 @@ i40e_vsi_remove_all_macvlan_filter(struct i40e_vsi *vsi)
 	else
 		num = vsi->mac_num * vsi->vlan_num;
 
-	mv_f = rte_zmalloc("macvlan_data", num * sizeof(*mv_f), 0);
+	mv_f = calloc(num, sizeof(*mv_f));
 	if (mv_f == NULL) {
 		PMD_DRV_LOG(ERR, "failed to allocate memory");
 		return I40E_ERR_NO_MEMORY;
@@ -7484,7 +7482,7 @@ i40e_vsi_remove_all_macvlan_filter(struct i40e_vsi *vsi)
 
 	ret = i40e_remove_macvlan_filters(vsi, mv_f, num);
 DONE:
-	rte_free(mv_f);
+	free(mv_f);
 
 	return ret;
 }
@@ -7510,7 +7508,7 @@ i40e_vsi_add_vlan(struct i40e_vsi *vsi, uint16_t vlan)
 		return I40E_ERR_PARAM;
 	}
 
-	mv_f = rte_zmalloc("macvlan_data", mac_num * sizeof(*mv_f), 0);
+	mv_f = calloc(mac_num, sizeof(*mv_f));
 
 	if (mv_f == NULL) {
 		PMD_DRV_LOG(ERR, "failed to allocate memory");
@@ -7532,7 +7530,7 @@ i40e_vsi_add_vlan(struct i40e_vsi *vsi, uint16_t vlan)
 	vsi->vlan_num++;
 	ret = I40E_SUCCESS;
 DONE:
-	rte_free(mv_f);
+	free(mv_f);
 	return ret;
 }
 
@@ -7561,7 +7559,7 @@ i40e_vsi_delete_vlan(struct i40e_vsi *vsi, uint16_t vlan)
 		return I40E_ERR_PARAM;
 	}
 
-	mv_f = rte_zmalloc("macvlan_data", mac_num * sizeof(*mv_f), 0);
+	mv_f = calloc(mac_num, sizeof(*mv_f));
 
 	if (mv_f == NULL) {
 		PMD_DRV_LOG(ERR, "failed to allocate memory");
@@ -7594,7 +7592,7 @@ i40e_vsi_delete_vlan(struct i40e_vsi *vsi, uint16_t vlan)
 	vsi->vlan_num--;
 	ret = I40E_SUCCESS;
 DONE:
-	rte_free(mv_f);
+	free(mv_f);
 	return ret;
 }
 
@@ -7626,7 +7624,7 @@ i40e_vsi_add_mac(struct i40e_vsi *vsi, struct i40e_mac_filter_info *mac_filter)
 			mac_filter->filter_type == I40E_MAC_HASH_MATCH)
 		vlan_num = 1;
 
-	mv_f = rte_zmalloc("macvlan_data", vlan_num * sizeof(*mv_f), 0);
+	mv_f = calloc(vlan_num, sizeof(*mv_f));
 	if (mv_f == NULL) {
 		PMD_DRV_LOG(ERR, "failed to allocate memory");
 		return I40E_ERR_NO_MEMORY;
@@ -7665,7 +7663,7 @@ i40e_vsi_add_mac(struct i40e_vsi *vsi, struct i40e_mac_filter_info *mac_filter)
 
 	ret = I40E_SUCCESS;
 DONE:
-	rte_free(mv_f);
+	free(mv_f);
 
 	return ret;
 }
@@ -7696,7 +7694,7 @@ i40e_vsi_delete_mac(struct i40e_vsi *vsi, struct rte_ether_addr *addr)
 			filter_type == I40E_MAC_HASH_MATCH)
 		vlan_num = 1;
 
-	mv_f = rte_zmalloc("macvlan_data", vlan_num * sizeof(*mv_f), 0);
+	mv_f = calloc(vlan_num, sizeof(*mv_f));
 	if (mv_f == NULL) {
 		PMD_DRV_LOG(ERR, "failed to allocate memory");
 		return I40E_ERR_NO_MEMORY;
@@ -7725,7 +7723,7 @@ i40e_vsi_delete_mac(struct i40e_vsi *vsi, struct rte_ether_addr *addr)
 
 	ret = I40E_SUCCESS;
 DONE:
-	rte_free(mv_f);
+	free(mv_f);
 	return ret;
 }
 
diff --git a/drivers/net/intel/i40e/rte_pmd_i40e.c b/drivers/net/intel/i40e/rte_pmd_i40e.c
index a358f68bc5..fb73fa924f 100644
--- a/drivers/net/intel/i40e/rte_pmd_i40e.c
+++ b/drivers/net/intel/i40e/rte_pmd_i40e.c
@@ -233,7 +233,7 @@ i40e_vsi_rm_mac_filter(struct i40e_vsi *vsi)
 			   filter_type == I40E_MAC_HASH_MATCH)
 			vlan_num = 1;
 
-		mv_f = rte_zmalloc("macvlan_data", vlan_num * sizeof(*mv_f), 0);
+		mv_f = calloc(vlan_num, sizeof(*mv_f));
 		if (!mv_f) {
 			PMD_DRV_LOG(ERR, "failed to allocate memory");
 			return I40E_ERR_NO_MEMORY;
@@ -250,18 +250,18 @@ i40e_vsi_rm_mac_filter(struct i40e_vsi *vsi)
 			ret = i40e_find_all_vlan_for_mac(vsi, mv_f, vlan_num,
 							 &f->mac_info.mac_addr);
 			if (ret != I40E_SUCCESS) {
-				rte_free(mv_f);
+				free(mv_f);
 				return ret;
 			}
 		}
 
 		ret = i40e_remove_macvlan_filters(vsi, mv_f, vlan_num);
 		if (ret != I40E_SUCCESS) {
-			rte_free(mv_f);
+			free(mv_f);
 			return ret;
 		}
 
-		rte_free(mv_f);
+		free(mv_f);
 		ret = I40E_SUCCESS;
 	}
 
@@ -294,7 +294,7 @@ i40e_vsi_restore_mac_filter(struct i40e_vsi *vsi)
 			   f->mac_info.filter_type == I40E_MAC_HASH_MATCH)
 			vlan_num = 1;
 
-		mv_f = rte_zmalloc("macvlan_data", vlan_num * sizeof(*mv_f), 0);
+		mv_f = calloc(vlan_num, sizeof(*mv_f));
 		if (!mv_f) {
 			PMD_DRV_LOG(ERR, "failed to allocate memory");
 			return I40E_ERR_NO_MEMORY;
@@ -312,18 +312,18 @@ i40e_vsi_restore_mac_filter(struct i40e_vsi *vsi)
 			ret = i40e_find_all_vlan_for_mac(vsi, mv_f, vlan_num,
 							 &f->mac_info.mac_addr);
 			if (ret != I40E_SUCCESS) {
-				rte_free(mv_f);
+				free(mv_f);
 				return ret;
 			}
 		}
 
 		ret = i40e_add_macvlan_filters(vsi, mv_f, vlan_num);
 		if (ret != I40E_SUCCESS) {
-			rte_free(mv_f);
+			free(mv_f);
 			return ret;
 		}
 
-		rte_free(mv_f);
+		free(mv_f);
 		ret = I40E_SUCCESS;
 	}
 
-- 
2.47.3

