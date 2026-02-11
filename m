Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94120E9E30A
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 13:54:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA95440B91;
	Wed, 11 Feb 2026 14:53:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 3BE89406FF
 for <dev@dpdk.org>; Wed, 11 Feb 2026 14:53:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770818026; x=1802354026;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=QQlSa7mhsrB34Er42jTjcVkQGqRLyUVrR8VUBzZ3jUs=;
 b=d6K82puh4yjKpmjFTTffAM5f2PMSKYBFyCUGqEjVFS2w2O/A/sATB1Ja
 m8xyjztcpGNPDUzQ+9Jo9AwiXXgNJt/FJJi9xfP7ireEwwmgfB37JnkIE
 6EufxS+elhoUF85g/uhQo8CHYhJ3YgN0dwin0TRuCzJCAw1jlorCbnLHS
 W2Z6DKjtVvdDg/UyCp0FnIeZjY53lFvHx6kcWaeb7kmG20k6tXFYmd9hT
 GFA1RtZbEn6TQG2MdIap2/PyCr3GPEdpD2CAukZ6QC+mcvtFnHYPsKsEI
 /r20+jzHo1Ut9sJtCVO5Dj+7tWELtFWli2i8LBVvAOApkR61jVpo9N3oi A==;
X-CSE-ConnectionGUID: lOz6X4bIRwqJpA4IsUJQMg==
X-CSE-MsgGUID: 0LiUXTJzRWeU4aR6kzK/WA==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75808250"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="75808250"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 05:53:45 -0800
X-CSE-ConnectionGUID: 1nui0J+zQzqluRL5dzcqCg==
X-CSE-MsgGUID: vEcw5c2GQ/2FDn6BtkMCWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="212359591"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa007.jf.intel.com with ESMTP; 11 Feb 2026 05:53:45 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 11/27] net/i40e: avoid rte malloc in MAC/VLAN filtering
Date: Wed, 11 Feb 2026 13:52:53 +0000
Message-ID: <e0e9fe897b674db0e8da9884813b363fee3914bf.1770817884.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770817884.git.anatoly.burakov@intel.com>
 <cover.1770817884.git.anatoly.burakov@intel.com>
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

