Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75FCE9A03B
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 16:24:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F18440693;
	Thu, 19 Feb 2026 17:23:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 7C30040663
 for <dev@dpdk.org>; Thu, 19 Feb 2026 17:23:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771518211; x=1803054211;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Dtk/nQvkHTZ0mZ+DGk9UX+rVNdq7kPLPk/lTSzlaWhM=;
 b=I7Uwq7Ko+NtyO8rTJG7Cb5wWsfVvCsKDduQBsOVfznyTmt/VFJOFD4H8
 vzqEDscnStfnc9MPBhCESug59HFLAerhOS6STBm91Awwh2SMtHDLT4wRE
 0pY8bUNqaN5EV3cwt/OuF8+3YwEobHTaMt9KSE0zLOzA6aEDp1TeLjNxX
 uvwTH2gC9uJXC5bpXQ7BLlytB+mXxvTLCdaRyjNRgkgp12vWYwvox0IpV
 rJMkB8NAuMlQPfZL+POFPjXi2X6ngb7ThxB/cfWtLWf2litcJugRNGqjx
 m4ruUn7JsEEcl93i/WRNtTuMkNdXYf5S10GcSiHjEOJA3fAeAqIU9MK8L Q==;
X-CSE-ConnectionGUID: 92B6xxGaRie5LCbbPYFMbA==
X-CSE-MsgGUID: 5Y7X2v3RS2SuwDS9zSOamA==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="83231440"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="83231440"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 08:23:30 -0800
X-CSE-ConnectionGUID: UUv8dp4GR8W4lYU5df0mGA==
X-CSE-MsgGUID: IKMIhDssQl2/1tFo5VdtrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="218699874"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 19 Feb 2026 08:23:29 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v6 11/27] net/i40e: avoid rte malloc in MAC/VLAN filtering
Date: Thu, 19 Feb 2026 16:22:54 +0000
Message-ID: <f27123896c4d6d028ec8ffe6955ca20533453900.1771518103.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771518103.git.anatoly.burakov@intel.com>
 <cover.1771518103.git.anatoly.burakov@intel.com>
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
we are using rte_zmalloc followed by an immediate rte_free. This memory
does not need to be stored in hugepage memory, so replace it with regular
malloc/free or stack allocation where appropriate.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.c  | 135 +++++++++++---------------
 drivers/net/intel/i40e/rte_pmd_i40e.c |  17 ++--
 2 files changed, 65 insertions(+), 87 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index d1f8e12689..72ff2ea59c 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -6,6 +6,7 @@
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
+#include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
 #include <stdarg.h>
@@ -4128,7 +4129,6 @@ static int
 i40e_vlan_offload_set(struct rte_eth_dev *dev, int mask)
 {
 	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
-	struct i40e_mac_filter_info *mac_filter;
 	struct i40e_vsi *vsi = pf->main_vsi;
 	struct rte_eth_rxmode *rxmode;
 	struct i40e_mac_filter *f;
@@ -4163,12 +4163,12 @@ i40e_vlan_offload_set(struct rte_eth_dev *dev, int mask)
 	}
 
 	if (mask & RTE_ETH_VLAN_EXTEND_MASK) {
+		struct i40e_mac_filter_info mac_filter[I40E_NUM_MACADDR_MAX] = {0};
 		i = 0;
 		num = vsi->mac_num;
-		mac_filter = rte_zmalloc("mac_filter_info_data",
-				 num * sizeof(*mac_filter), 0);
-		if (mac_filter == NULL) {
-			PMD_DRV_LOG(ERR, "failed to allocate memory");
+
+		if (num > I40E_NUM_MACADDR_MAX) {
+			PMD_DRV_LOG(ERR, "Too many MAC addresses");
 			return I40E_ERR_NO_MEMORY;
 		}
 
@@ -4206,7 +4206,6 @@ i40e_vlan_offload_set(struct rte_eth_dev *dev, int mask)
 			if (ret)
 				PMD_DRV_LOG(ERR, "i40e vsi add mac fail.");
 		}
-		rte_free(mac_filter);
 	}
 
 	if (mask & RTE_ETH_QINQ_STRIP_MASK) {
@@ -6200,7 +6199,7 @@ i40e_vsi_config_vlan_filter(struct i40e_vsi *vsi, bool on)
 	int i, num;
 	struct i40e_mac_filter *f;
 	void *temp;
-	struct i40e_mac_filter_info *mac_filter;
+	struct i40e_mac_filter_info mac_filter[I40E_NUM_MACADDR_MAX] = {0};
 	enum i40e_mac_filter_type desired_filter;
 	int ret = I40E_SUCCESS;
 
@@ -6213,12 +6212,9 @@ i40e_vsi_config_vlan_filter(struct i40e_vsi *vsi, bool on)
 	}
 
 	num = vsi->mac_num;
-
-	mac_filter = rte_zmalloc("mac_filter_info_data",
-				 num * sizeof(*mac_filter), 0);
-	if (mac_filter == NULL) {
-		PMD_DRV_LOG(ERR, "failed to allocate memory");
-		return I40E_ERR_NO_MEMORY;
+	if (num > I40E_NUM_MACADDR_MAX) {
+		PMD_DRV_LOG(ERR, "Too many MAC addresses");
+		return -1;
 	}
 
 	i = 0;
@@ -6230,7 +6226,7 @@ i40e_vsi_config_vlan_filter(struct i40e_vsi *vsi, bool on)
 		if (ret) {
 			PMD_DRV_LOG(ERR, "Update VSI failed to %s vlan filter",
 				    on ? "enable" : "disable");
-			goto DONE;
+			return ret;
 		}
 		i++;
 	}
@@ -6242,13 +6238,11 @@ i40e_vsi_config_vlan_filter(struct i40e_vsi *vsi, bool on)
 		if (ret) {
 			PMD_DRV_LOG(ERR, "Update VSI failed to %s vlan filter",
 				    on ? "enable" : "disable");
-			goto DONE;
+			return ret;
 		}
 	}
 
-DONE:
-	rte_free(mac_filter);
-	return ret;
+	return 0;
 }
 
 /* Configure vlan stripping on or off */
@@ -7130,19 +7124,20 @@ i40e_add_macvlan_filters(struct i40e_vsi *vsi,
 	uint16_t flags;
 	int ret = I40E_SUCCESS;
 	struct i40e_hw *hw = I40E_VSI_TO_HW(vsi);
-	struct i40e_aqc_add_macvlan_element_data *req_list;
+	uint8_t aq_buff[I40E_AQ_BUF_SZ] = {0};
+	struct i40e_aqc_add_macvlan_element_data *req_list =
+			(struct i40e_aqc_add_macvlan_element_data *)aq_buff;
+
+	if (hw->aq.asq_buf_size > I40E_AQ_BUF_SZ) {
+		PMD_DRV_LOG(ERR, "AdminQ size biffer than max");
+		return I40E_ERR_NO_MEMORY;
+	}
 
 	if (filter == NULL  || total == 0)
 		return I40E_ERR_PARAM;
 	ele_num = hw->aq.asq_buf_size / sizeof(*req_list);
 	ele_buff_size = hw->aq.asq_buf_size;
 
-	req_list = rte_zmalloc("macvlan_add", ele_buff_size, 0);
-	if (req_list == NULL) {
-		PMD_DRV_LOG(ERR, "Fail to allocate memory");
-		return I40E_ERR_NO_MEMORY;
-	}
-
 	num = 0;
 	do {
 		actual_num = (num + ele_num > total) ? (total - num) : ele_num;
@@ -7171,8 +7166,7 @@ i40e_add_macvlan_filters(struct i40e_vsi *vsi,
 				break;
 			default:
 				PMD_DRV_LOG(ERR, "Invalid MAC match type");
-				ret = I40E_ERR_PARAM;
-				goto DONE;
+				return I40E_ERR_PARAM;
 			}
 
 			req_list[i].queue_number = 0;
@@ -7184,14 +7178,11 @@ i40e_add_macvlan_filters(struct i40e_vsi *vsi,
 						actual_num, NULL);
 		if (ret != I40E_SUCCESS) {
 			PMD_DRV_LOG(ERR, "Failed to add macvlan filter");
-			goto DONE;
+			return ret;
 		}
 		num += actual_num;
 	} while (num < total);
-
-DONE:
-	rte_free(req_list);
-	return ret;
+	return I40E_SUCCESS;
 }
 
 int
@@ -7204,21 +7195,22 @@ i40e_remove_macvlan_filters(struct i40e_vsi *vsi,
 	uint16_t flags;
 	int ret = I40E_SUCCESS;
 	struct i40e_hw *hw = I40E_VSI_TO_HW(vsi);
-	struct i40e_aqc_remove_macvlan_element_data *req_list;
+	uint8_t aq_buff[I40E_AQ_BUF_SZ] = {0};
+	struct i40e_aqc_remove_macvlan_element_data *req_list =
+			(struct i40e_aqc_remove_macvlan_element_data *)aq_buff;
 	enum i40e_admin_queue_err aq_status;
 
 	if (filter == NULL  || total == 0)
 		return I40E_ERR_PARAM;
 
-	ele_num = hw->aq.asq_buf_size / sizeof(*req_list);
-	ele_buff_size = hw->aq.asq_buf_size;
-
-	req_list = rte_zmalloc("macvlan_remove", ele_buff_size, 0);
-	if (req_list == NULL) {
-		PMD_DRV_LOG(ERR, "Fail to allocate memory");
+	if (hw->aq.asq_buf_size > I40E_AQ_BUF_SZ) {
+		PMD_DRV_LOG(ERR, "AdminQ size biffer than max");
 		return I40E_ERR_NO_MEMORY;
 	}
 
+	ele_num = hw->aq.asq_buf_size / sizeof(*req_list);
+	ele_buff_size = hw->aq.asq_buf_size;
+
 	num = 0;
 	do {
 		actual_num = (num + ele_num > total) ? (total - num) : ele_num;
@@ -7247,8 +7239,7 @@ i40e_remove_macvlan_filters(struct i40e_vsi *vsi,
 				break;
 			default:
 				PMD_DRV_LOG(ERR, "Invalid MAC filter type");
-				ret = I40E_ERR_PARAM;
-				goto DONE;
+				return I40E_ERR_PARAM;
 			}
 			req_list[i].flags = rte_cpu_to_le_16(flags);
 		}
@@ -7262,15 +7253,13 @@ i40e_remove_macvlan_filters(struct i40e_vsi *vsi,
 				ret = I40E_SUCCESS;
 			} else {
 				PMD_DRV_LOG(ERR, "Failed to remove macvlan filter");
-				goto DONE;
+				return ret;
 			}
 		}
 		num += actual_num;
 	} while (num < total);
 
-DONE:
-	rte_free(req_list);
-	return ret;
+	return I40E_SUCCESS;
 }
 
 /* Find out specific MAC filter */
@@ -7438,7 +7427,7 @@ i40e_vsi_remove_all_macvlan_filter(struct i40e_vsi *vsi)
 	else
 		num = vsi->mac_num * vsi->vlan_num;
 
-	mv_f = rte_zmalloc("macvlan_data", num * sizeof(*mv_f), 0);
+	mv_f = calloc(num, sizeof(*mv_f));
 	if (mv_f == NULL) {
 		PMD_DRV_LOG(ERR, "failed to allocate memory");
 		return I40E_ERR_NO_MEMORY;
@@ -7467,7 +7456,7 @@ i40e_vsi_remove_all_macvlan_filter(struct i40e_vsi *vsi)
 
 	ret = i40e_remove_macvlan_filters(vsi, mv_f, num);
 DONE:
-	rte_free(mv_f);
+	free(mv_f);
 
 	return ret;
 }
@@ -7475,7 +7464,7 @@ i40e_vsi_remove_all_macvlan_filter(struct i40e_vsi *vsi)
 int
 i40e_vsi_add_vlan(struct i40e_vsi *vsi, uint16_t vlan)
 {
-	struct i40e_macvlan_filter *mv_f;
+	struct i40e_macvlan_filter mv_f[I40E_NUM_MACADDR_MAX] = {0};
 	int mac_num;
 	int ret = I40E_SUCCESS;
 
@@ -7492,37 +7481,31 @@ i40e_vsi_add_vlan(struct i40e_vsi *vsi, uint16_t vlan)
 		PMD_DRV_LOG(ERR, "Error! VSI doesn't have a mac addr");
 		return I40E_ERR_PARAM;
 	}
-
-	mv_f = rte_zmalloc("macvlan_data", mac_num * sizeof(*mv_f), 0);
-
-	if (mv_f == NULL) {
-		PMD_DRV_LOG(ERR, "failed to allocate memory");
-		return I40E_ERR_NO_MEMORY;
+	if (mac_num > I40E_NUM_MACADDR_MAX) {
+		PMD_DRV_LOG(ERR, "Error! Too many MAC addresses");
+		return I40E_ERR_PARAM;
 	}
 
 	ret = i40e_find_all_mac_for_vlan(vsi, mv_f, mac_num, vlan);
 
 	if (ret != I40E_SUCCESS)
-		goto DONE;
+		return ret;
 
 	ret = i40e_add_macvlan_filters(vsi, mv_f, mac_num);
 
 	if (ret != I40E_SUCCESS)
-		goto DONE;
+		return ret;
 
 	i40e_set_vlan_filter(vsi, vlan, 1);
 
 	vsi->vlan_num++;
-	ret = I40E_SUCCESS;
-DONE:
-	rte_free(mv_f);
-	return ret;
+	return I40E_SUCCESS;
 }
 
 int
 i40e_vsi_delete_vlan(struct i40e_vsi *vsi, uint16_t vlan)
 {
-	struct i40e_macvlan_filter *mv_f;
+	struct i40e_macvlan_filter mv_f[I40E_NUM_MACADDR_MAX] = {0};
 	int mac_num;
 	int ret = I40E_SUCCESS;
 
@@ -7543,42 +7526,36 @@ i40e_vsi_delete_vlan(struct i40e_vsi *vsi, uint16_t vlan)
 		PMD_DRV_LOG(ERR, "Error! VSI doesn't have a mac addr");
 		return I40E_ERR_PARAM;
 	}
-
-	mv_f = rte_zmalloc("macvlan_data", mac_num * sizeof(*mv_f), 0);
-
-	if (mv_f == NULL) {
-		PMD_DRV_LOG(ERR, "failed to allocate memory");
-		return I40E_ERR_NO_MEMORY;
+	if (mac_num > I40E_NUM_MACADDR_MAX) {
+		PMD_DRV_LOG(ERR, "Error! Too many MAC addresses");
+		return I40E_ERR_PARAM;
 	}
 
 	ret = i40e_find_all_mac_for_vlan(vsi, mv_f, mac_num, vlan);
 
 	if (ret != I40E_SUCCESS)
-		goto DONE;
+		return ret;
 
 	ret = i40e_remove_macvlan_filters(vsi, mv_f, mac_num);
 
 	if (ret != I40E_SUCCESS)
-		goto DONE;
+		return ret;
 
 	/* This is last vlan to remove, replace all mac filter with vlan 0 */
 	if (vsi->vlan_num == 1) {
 		ret = i40e_find_all_mac_for_vlan(vsi, mv_f, mac_num, 0);
 		if (ret != I40E_SUCCESS)
-			goto DONE;
+			return ret;
 
 		ret = i40e_add_macvlan_filters(vsi, mv_f, mac_num);
 		if (ret != I40E_SUCCESS)
-			goto DONE;
+			return ret;
 	}
 
 	i40e_set_vlan_filter(vsi, vlan, 0);
 
 	vsi->vlan_num--;
-	ret = I40E_SUCCESS;
-DONE:
-	rte_free(mv_f);
-	return ret;
+	return I40E_SUCCESS;
 }
 
 int
@@ -7609,7 +7586,7 @@ i40e_vsi_add_mac(struct i40e_vsi *vsi, struct i40e_mac_filter_info *mac_filter)
 			mac_filter->filter_type == I40E_MAC_HASH_MATCH)
 		vlan_num = 1;
 
-	mv_f = rte_zmalloc("macvlan_data", vlan_num * sizeof(*mv_f), 0);
+	mv_f = calloc(vlan_num, sizeof(*mv_f));
 	if (mv_f == NULL) {
 		PMD_DRV_LOG(ERR, "failed to allocate memory");
 		return I40E_ERR_NO_MEMORY;
@@ -7648,7 +7625,7 @@ i40e_vsi_add_mac(struct i40e_vsi *vsi, struct i40e_mac_filter_info *mac_filter)
 
 	ret = I40E_SUCCESS;
 DONE:
-	rte_free(mv_f);
+	free(mv_f);
 
 	return ret;
 }
@@ -7679,7 +7656,7 @@ i40e_vsi_delete_mac(struct i40e_vsi *vsi, struct rte_ether_addr *addr)
 			filter_type == I40E_MAC_HASH_MATCH)
 		vlan_num = 1;
 
-	mv_f = rte_zmalloc("macvlan_data", vlan_num * sizeof(*mv_f), 0);
+	mv_f = calloc(vlan_num, sizeof(*mv_f));
 	if (mv_f == NULL) {
 		PMD_DRV_LOG(ERR, "failed to allocate memory");
 		return I40E_ERR_NO_MEMORY;
@@ -7708,7 +7685,7 @@ i40e_vsi_delete_mac(struct i40e_vsi *vsi, struct rte_ether_addr *addr)
 
 	ret = I40E_SUCCESS;
 DONE:
-	rte_free(mv_f);
+	free(mv_f);
 	return ret;
 }
 
diff --git a/drivers/net/intel/i40e/rte_pmd_i40e.c b/drivers/net/intel/i40e/rte_pmd_i40e.c
index a358f68bc5..4839a1d9bf 100644
--- a/drivers/net/intel/i40e/rte_pmd_i40e.c
+++ b/drivers/net/intel/i40e/rte_pmd_i40e.c
@@ -2,6 +2,7 @@
  * Copyright(c) 2010-2017 Intel Corporation
  */
 
+#include <stdlib.h>
 #include <eal_export.h>
 #include <rte_string_fns.h>
 #include <rte_malloc.h>
@@ -233,7 +234,7 @@ i40e_vsi_rm_mac_filter(struct i40e_vsi *vsi)
 			   filter_type == I40E_MAC_HASH_MATCH)
 			vlan_num = 1;
 
-		mv_f = rte_zmalloc("macvlan_data", vlan_num * sizeof(*mv_f), 0);
+		mv_f = calloc(vlan_num, sizeof(*mv_f));
 		if (!mv_f) {
 			PMD_DRV_LOG(ERR, "failed to allocate memory");
 			return I40E_ERR_NO_MEMORY;
@@ -250,18 +251,18 @@ i40e_vsi_rm_mac_filter(struct i40e_vsi *vsi)
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
 
@@ -294,7 +295,7 @@ i40e_vsi_restore_mac_filter(struct i40e_vsi *vsi)
 			   f->mac_info.filter_type == I40E_MAC_HASH_MATCH)
 			vlan_num = 1;
 
-		mv_f = rte_zmalloc("macvlan_data", vlan_num * sizeof(*mv_f), 0);
+		mv_f = calloc(vlan_num, sizeof(*mv_f));
 		if (!mv_f) {
 			PMD_DRV_LOG(ERR, "failed to allocate memory");
 			return I40E_ERR_NO_MEMORY;
@@ -312,18 +313,18 @@ i40e_vsi_restore_mac_filter(struct i40e_vsi *vsi)
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

