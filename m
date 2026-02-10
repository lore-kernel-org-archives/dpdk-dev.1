Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15743EF0702
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 16:15:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50F4040DDB;
	Tue, 10 Feb 2026 17:14:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 9C76240B95
 for <dev@dpdk.org>; Tue, 10 Feb 2026 17:14:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770740057; x=1802276057;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=QQlSa7mhsrB34Er42jTjcVkQGqRLyUVrR8VUBzZ3jUs=;
 b=nLoUMZhqty2hjNp9yut2EgdQej5NpC0jWdgo6ESdniaXgiBdoYgKDpyh
 HMDV3Qwbxr6AqG1vVZQZplN1qSDTwDKe9ZlwOm/O4C7yvRb1DrJlidYd3
 TNw3F0eYul1bBgwHc+a1CtMVv01UFjFZZbgiZzOxdHyfaVEngCFCiWfcA
 M35Euvu10HHyxzuZ7MIMEwRRliWO4BJaoe6WRQhu78a7yQIgaCN248WfC
 87itNT48G/yGYr1ZSk/Kbm4CCaiYs5quQ2Wx3pu/I4vdJISyW8z8MweS0
 wrK3gq03/eaT+iu/HyDNW6M92fmXuMnBk17pmBnAc9hvISLeNWmBLhsyK g==;
X-CSE-ConnectionGUID: ae3sgDDMTZOJloZHmDozVA==
X-CSE-MsgGUID: sQhiuvIMQL6ImYT/hsoB+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="89286203"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="89286203"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 08:14:16 -0800
X-CSE-ConnectionGUID: iTGcluJRTJCMEheIV7F09g==
X-CSE-MsgGUID: TmT1392ASGanQj3a9rZB0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="216127755"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 10 Feb 2026 08:14:16 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 11/26] net/i40e: avoid rte malloc in MAC/VLAN filtering
Date: Tue, 10 Feb 2026 16:13:40 +0000
Message-ID: <a4552201d2fb7c8cbb3c77131f017b713a1109f1.1770739925.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770739924.git.anatoly.burakov@intel.com>
 <cover.1770739924.git.anatoly.burakov@intel.com>
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
index 654b0e5d16..806c29368c 100644
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

