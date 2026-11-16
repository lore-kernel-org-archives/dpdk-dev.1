Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA67606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Nov 2026 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lyu73G5u
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C0FD402C4;
	Mon, 16 Nov 2026 17:09:45 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTPS id 1AB54402A2
 for <dev@dpdk.org>; Mon, 16 Nov 2026 17:09:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794845382; x=1826381382;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4z3tXZTASdSaok/Wx2rZoK+vWq23I4vrIWEUthfxwyQ=;
 b=lyu73G5uEesWQuw1hkTXVQHS6BeRpdb0nvY+Pgl11sK1CwTFyGHXq/Ke
 0OY0YsupE+9xcZ7TWXEvZDyVMBIl1cSETT15pTzzF8E9NznxdBHTBKq7e
 1FwZYgYG6xEaxORSmZYcLDQZefluzUbfzyTNOkWPOP4f0Zjfkh2rfaIeV
 Fm2P+F8o2qVcQmMPbEyOOSF/uoFA/YaJbvPq7mcWZ/Mo9Q4a/JYZ+W8Rl
 SDAuuusYGoy70Njvs2dTrQFO/BOmOeZdWVzec+Uu57pBW3DfoPS301v/q
 f4S1iJiC6Dla7Atu9OQGa5p5yPgrGn3TDG0uwceoX9nks9IYcl/z8+LpN w==;
X-CSE-ConnectionGUID: h4xdzXI0SA20LnNmDVsaKw==
X-CSE-MsgGUID: HqpyvyIfTgS3fYj1A9pAKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3481861"
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="3481861"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 08:09:41 -0800
X-CSE-ConnectionGUID: zJTtx2nYQt2tmgk8SuonPQ==
X-CSE-MsgGUID: 1pvAnBAOR2K919zCwuheNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="9926988"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa009.fm.intel.com with ESMTP; 16 Nov 2026 08:09:40 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 27.03 3/6] net/ice: use stack storage for function-local
 buffers
Date: Mon, 16 Nov 2026 16:09:29 +0000
Message-ID: <20261116160932.1006354-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116160932.1006354-1-bruce.richardson@intel.com>
References: <20261116160932.1006354-1-bruce.richardson@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Rather than using malloc and free for small or medium-sized buffers used
only within a single function, such as adminq and virtchnl messages,
define them on the stack, using RTE_DEFINE_FLEX for those structures
ending in a variable-length array. This removes the allocation failure
and cleanup paths, avoiding potential leaks on error.

Where the number of elements used depends on runtime values, add checks
that those values do not exceed the buffer sizes.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/ice_dcf.c        |  21 ++---
 drivers/net/intel/ice/ice_dcf_parent.c |  12 +--
 drivers/net/intel/ice/ice_dcf_sched.c  |  25 ++----
 drivers/net/intel/ice/ice_diagnose.c   |  12 +--
 drivers/net/intel/ice/ice_ethdev.c     | 104 +++++++------------------
 drivers/net/intel/ice/ice_rxtx.c       |  26 +------
 drivers/net/intel/ice/ice_tm.c         |   7 +-
 7 files changed, 52 insertions(+), 155 deletions(-)

diff --git a/drivers/net/intel/ice/ice_dcf.c b/drivers/net/intel/ice/ice_dcf.c
index 12eb58dc2a..3e9654244d 100644
--- a/drivers/net/intel/ice/ice_dcf.c
+++ b/drivers/net/intel/ice/ice_dcf.c
@@ -1275,18 +1275,19 @@ ice_dcf_configure_queues(struct ice_dcf_hw *hw)
 int
 ice_dcf_config_irq_map(struct ice_dcf_hw *hw)
 {
-	struct virtchnl_irq_map_info *map_info;
+	RTE_DEFINE_FLEX(struct virtchnl_irq_map_info, map_info, vecmap, RTE_DIM(hw->rxq_map));
 	struct virtchnl_vector_map *vecmap;
 	struct dcf_virtchnl_cmd args;
 	int len, i, err;
 
+	if (hw->nb_msix > RTE_DIM(hw->rxq_map)) {
+		PMD_DRV_LOG(ERR, "Too many interrupt vectors: %u", hw->nb_msix);
+		return -EINVAL;
+	}
+
 	len = sizeof(struct virtchnl_irq_map_info) +
 	      sizeof(struct virtchnl_vector_map) * hw->nb_msix;
 
-	map_info = rte_zmalloc("map_info", len, 0);
-	if (!map_info)
-		return -ENOMEM;
-
 	map_info->num_vectors = hw->nb_msix;
 	for (i = 0; i < hw->nb_msix; i++) {
 		vecmap = &map_info->vecmap[i];
@@ -1306,7 +1307,6 @@ ice_dcf_config_irq_map(struct ice_dcf_hw *hw)
 	if (err)
 		PMD_DRV_LOG(ERR, "fail to execute command OP_CONFIG_IRQ_MAP");
 
-	rte_free(map_info);
 	return err;
 }
 
@@ -1402,7 +1402,7 @@ ice_dcf_add_del_all_mac_addr(struct ice_dcf_hw *hw,
 			     struct rte_ether_addr *addr,
 			     bool add, uint8_t type)
 {
-	struct virtchnl_ether_addr_list *list;
+	RTE_DEFINE_FLEX(struct virtchnl_ether_addr_list, list, list, 1);
 	struct dcf_virtchnl_cmd args;
 	int len, err = 0;
 
@@ -1417,12 +1417,6 @@ ice_dcf_add_del_all_mac_addr(struct ice_dcf_hw *hw,
 	len = sizeof(struct virtchnl_ether_addr_list);
 	len += sizeof(struct virtchnl_ether_addr);
 
-	list = rte_zmalloc(NULL, len, 0);
-	if (!list) {
-		PMD_DRV_LOG(ERR, "fail to allocate memory");
-		return -ENOMEM;
-	}
-
 	memcpy(list->list[0].addr, addr->addr_bytes,
 			sizeof(addr->addr_bytes));
 
@@ -1442,6 +1436,5 @@ ice_dcf_add_del_all_mac_addr(struct ice_dcf_hw *hw,
 		PMD_DRV_LOG(ERR, "fail to execute command %s",
 			    add ? "OP_ADD_ETHER_ADDRESS" :
 			    "OP_DEL_ETHER_ADDRESS");
-	rte_free(list);
 	return err;
 }
diff --git a/drivers/net/intel/ice/ice_dcf_parent.c b/drivers/net/intel/ice/ice_dcf_parent.c
index 4d620fe8f5..3dfdb5d9ce 100644
--- a/drivers/net/intel/ice/ice_dcf_parent.c
+++ b/drivers/net/intel/ice/ice_dcf_parent.c
@@ -321,7 +321,7 @@ ice_dcf_query_port_ets(struct ice_hw *parent_hw, struct ice_dcf_hw *real_hw)
 static int
 ice_dcf_init_parent_hw(struct ice_hw *hw)
 {
-	struct ice_aqc_get_phy_caps_data *pcaps;
+	struct ice_aqc_get_phy_caps_data pcaps = {0};
 	int status;
 
 	status = ice_aq_get_fw_ver(hw, NULL);
@@ -345,17 +345,9 @@ ice_dcf_init_parent_hw(struct ice_hw *hw)
 	if (status)
 		goto err_unroll_alloc;
 
-	pcaps = (struct ice_aqc_get_phy_caps_data *)
-		ice_malloc(hw, sizeof(*pcaps));
-	if (!pcaps) {
-		status = ICE_ERR_NO_MEMORY;
-		goto err_unroll_alloc;
-	}
-
 	/* Initialize port_info struct with PHY capabilities */
 	status = ice_aq_get_phy_caps(hw->port_info, false,
-				     ICE_AQC_REPORT_TOPO_CAP_MEDIA, pcaps, NULL);
-	ice_free(hw, pcaps);
+				     ICE_AQC_REPORT_TOPO_CAP_MEDIA, &pcaps, NULL);
 	if (status)
 		goto err_unroll_alloc;
 
diff --git a/drivers/net/intel/ice/ice_dcf_sched.c b/drivers/net/intel/ice/ice_dcf_sched.c
index a524d9c777..75752f4071 100644
--- a/drivers/net/intel/ice/ice_dcf_sched.c
+++ b/drivers/net/intel/ice/ice_dcf_sched.c
@@ -723,8 +723,8 @@ static int ice_dcf_hierarchy_commit(struct rte_eth_dev *dev,
 {
 	struct ice_dcf_adapter *adapter = dev->data->dev_private;
 	struct ice_dcf_hw *hw = &adapter->real_hw;
-	struct virtchnl_dcf_bw_cfg_list *vf_bw = NULL;
-	struct virtchnl_dcf_bw_cfg_list *tc_bw = NULL;
+	RTE_DEFINE_FLEX(struct virtchnl_dcf_bw_cfg_list, vf_bw, cfg, ICE_MAX_TRAFFIC_CLASS - 1);
+	RTE_DEFINE_FLEX(struct virtchnl_dcf_bw_cfg_list, tc_bw, cfg, ICE_MAX_TRAFFIC_CLASS - 1);
 	struct virtchnl_dcf_bw_cfg_list *bw_cfg;
 	struct ice_dcf_tm_node_list *vsi_list = &hw->tm_conf.vsi_list;
 	struct rte_tm_shaper_params *profile;
@@ -745,19 +745,15 @@ static int ice_dcf_hierarchy_commit(struct rte_eth_dev *dev,
 	if (ret_val)
 		goto fail_clear;
 
+	if (hw->tm_conf.nb_tc_node > ICE_MAX_TRAFFIC_CLASS) {
+		PMD_DRV_LOG(ERR, "Too many TC nodes: %u", hw->tm_conf.nb_tc_node);
+		ret_val = ICE_ERR_PARAM;
+		goto fail_clear;
+	}
+
 	size = sizeof(struct virtchnl_dcf_bw_cfg_list) +
 		sizeof(struct virtchnl_dcf_bw_cfg) *
 		(hw->tm_conf.nb_tc_node - 1);
-	vf_bw = calloc(1, size);
-	if (!vf_bw) {
-		ret_val = ICE_ERR_NO_MEMORY;
-		goto fail_clear;
-	}
-	tc_bw = calloc(1, size);
-	if (!tc_bw) {
-		ret_val = ICE_ERR_NO_MEMORY;
-		goto fail_clear;
-	}
 
 	/* port bandwidth (Kbps) */
 	port_bw = hw->link_speed * 1000;
@@ -850,14 +846,9 @@ static int ice_dcf_hierarchy_commit(struct rte_eth_dev *dev,
 	ice_dcf_replace_qos_bw_cfg(hw, ICE_DCF_VFID, bw_cfg);
 
 	hw->tm_conf.committed = true;
-	free(vf_bw);
-	free(tc_bw);
 	return ret_val;
 
 fail_clear:
-	free(vf_bw);
-	free(tc_bw);
-
 	/* clear all the traffic manager configuration */
 	if (clear_on_fail) {
 		ice_dcf_tm_conf_uninit(dev);
diff --git a/drivers/net/intel/ice/ice_diagnose.c b/drivers/net/intel/ice/ice_diagnose.c
index ecfcdf5559..320b42c5eb 100644
--- a/drivers/net/intel/ice/ice_diagnose.c
+++ b/drivers/net/intel/ice/ice_diagnose.c
@@ -453,13 +453,9 @@ ice_dump_switch(struct rte_eth_dev *dev, uint8_t **buff2, uint32_t *size)
 	for (i = 0; i < ICE_BLK_MAX_COUNT; i++) {
 		int res;
 		uint16_t buff_size;
-		uint8_t *buff;
+		uint8_t buff[ICE_PKG_BUF_SIZE];
 		uint32_t offset = 0;
 
-		buff = malloc(ICE_PKG_BUF_SIZE);
-		if (!buff)
-			return ICE_ERR_NO_MEMORY;
-
 		if (tbl_idx == 0) {
 			char tbl_idx_str[TBL_IDX_STR_SIZE];
 			memset(tbl_idx_str, 0, sizeof(tbl_idx_str));
@@ -475,16 +471,12 @@ ice_dump_switch(struct rte_eth_dev *dev, uint8_t **buff2, uint32_t *size)
 			ICE_PKG_BUF_SIZE,
 			&buff_size, &tbl_id, &tbl_idx, NULL, cd);
 
-		if (res) {
-			free(buff);
+		if (res)
 			return res;
-		}
 
 		offset = covert_byte_to_hex(&buffer, buff, buff_size);
 		buffer += offset;
 
-		free(buff);
-
 		if (tbl_idx == 0xffff) {
 			tbl_idx = 0;
 			memset(buffer, '\n', sizeof(char));
diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 457c955b2e..7835f6a905 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -1134,7 +1134,8 @@ ice_find_mac_filter(struct ice_vsi *vsi, struct rte_ether_addr *macaddr)
 static int
 ice_add_mac_filter(struct ice_vsi *vsi, struct rte_ether_addr *mac_addr)
 {
-	struct ice_fltr_list_entry *m_list_itr = NULL;
+	struct ice_fltr_list_entry m_list_entry = {0};
+	struct ice_fltr_list_entry *m_list_itr = &m_list_entry;
 	struct ice_mac_filter *f;
 	struct LIST_HEAD_TYPE list_head;
 	struct ice_hw *hw = ICE_VSI_TO_HW(vsi);
@@ -1155,12 +1156,6 @@ ice_add_mac_filter(struct ice_vsi *vsi, struct rte_ether_addr *mac_addr)
 
 	INIT_LIST_HEAD(&list_head);
 
-	m_list_itr = (struct ice_fltr_list_entry *)
-		ice_malloc(hw, sizeof(*m_list_itr));
-	if (!m_list_itr) {
-		ret = -ENOMEM;
-		goto DONE;
-	}
 	ice_memcpy(m_list_itr->fltr_info.l_data.mac.mac_addr,
 		   mac_addr, ETH_ALEN, ICE_NONDMA_TO_NONDMA);
 	m_list_itr->fltr_info.src_id = ICE_SRC_ID_VSI;
@@ -1175,31 +1170,26 @@ ice_add_mac_filter(struct ice_vsi *vsi, struct rte_ether_addr *mac_addr)
 	ret = ice_add_mac(hw, &list_head);
 	if (ret != ICE_SUCCESS) {
 		PMD_DRV_LOG(ERR, "Failed to add MAC filter");
-		ret = -EINVAL;
-		goto DONE;
+		return -EINVAL;
 	}
 	/* Add the mac addr into mac list */
 	f = rte_zmalloc(NULL, sizeof(*f), 0);
 	if (!f) {
 		PMD_DRV_LOG(ERR, "failed to allocate memory");
-		ret = -ENOMEM;
-		goto DONE;
+		return -ENOMEM;
 	}
 	rte_ether_addr_copy(mac_addr, &f->mac_info.mac_addr);
 	TAILQ_INSERT_TAIL(&vsi->mac_list, f, next);
 	vsi->mac_num++;
 
-	ret = 0;
-
-DONE:
-	ice_free(hw, m_list_itr);
-	return ret;
+	return 0;
 }
 
 static int
 ice_remove_mac_filter(struct ice_vsi *vsi, struct rte_ether_addr *mac_addr)
 {
-	struct ice_fltr_list_entry *m_list_itr = NULL;
+	struct ice_fltr_list_entry m_list_entry = {0};
+	struct ice_fltr_list_entry *m_list_itr = &m_list_entry;
 	struct ice_mac_filter *f;
 	struct LIST_HEAD_TYPE list_head;
 	struct ice_hw *hw = ICE_VSI_TO_HW(vsi);
@@ -1212,12 +1202,6 @@ ice_remove_mac_filter(struct ice_vsi *vsi, struct rte_ether_addr *mac_addr)
 
 	INIT_LIST_HEAD(&list_head);
 
-	m_list_itr = (struct ice_fltr_list_entry *)
-		ice_malloc(hw, sizeof(*m_list_itr));
-	if (!m_list_itr) {
-		ret = -ENOMEM;
-		goto DONE;
-	}
 	ice_memcpy(m_list_itr->fltr_info.l_data.mac.mac_addr,
 		   mac_addr, ETH_ALEN, ICE_NONDMA_TO_NONDMA);
 	m_list_itr->fltr_info.src_id = ICE_SRC_ID_VSI;
@@ -1232,8 +1216,7 @@ ice_remove_mac_filter(struct ice_vsi *vsi, struct rte_ether_addr *mac_addr)
 	ret = ice_remove_mac(hw, &list_head);
 	if (ret != ICE_SUCCESS) {
 		PMD_DRV_LOG(ERR, "Failed to remove MAC filter");
-		ret = -EINVAL;
-		goto DONE;
+		return -EINVAL;
 	}
 
 	/* Remove the mac addr from mac list */
@@ -1241,10 +1224,7 @@ ice_remove_mac_filter(struct ice_vsi *vsi, struct rte_ether_addr *mac_addr)
 	rte_free(f);
 	vsi->mac_num--;
 
-	ret = 0;
-DONE:
-	ice_free(hw, m_list_itr);
-	return ret;
+	return 0;
 }
 
 /* Find out specific VLAN filter */
@@ -1265,7 +1245,8 @@ ice_find_vlan_filter(struct ice_vsi *vsi, struct ice_vlan *vlan)
 static int
 ice_add_vlan_filter(struct ice_vsi *vsi, struct ice_vlan *vlan)
 {
-	struct ice_fltr_list_entry *v_list_itr = NULL;
+	struct ice_fltr_list_entry v_list_entry = {0};
+	struct ice_fltr_list_entry *v_list_itr = &v_list_entry;
 	struct ice_vlan_filter *f;
 	struct LIST_HEAD_TYPE list_head;
 	struct ice_hw *hw;
@@ -1288,12 +1269,6 @@ ice_add_vlan_filter(struct ice_vsi *vsi, struct ice_vlan *vlan)
 
 	INIT_LIST_HEAD(&list_head);
 
-	v_list_itr = (struct ice_fltr_list_entry *)
-		      ice_malloc(hw, sizeof(*v_list_itr));
-	if (!v_list_itr) {
-		ret = -ENOMEM;
-		goto DONE;
-	}
 	v_list_itr->fltr_info.l_data.vlan.vlan_id = vlan->vid;
 	v_list_itr->fltr_info.l_data.vlan.tpid = vlan->tpid;
 	v_list_itr->fltr_info.l_data.vlan.tpid_valid = true;
@@ -1309,33 +1284,28 @@ ice_add_vlan_filter(struct ice_vsi *vsi, struct ice_vlan *vlan)
 	ret = ice_add_vlan(hw, &list_head);
 	if (ret != ICE_SUCCESS) {
 		PMD_DRV_LOG(ERR, "Failed to add VLAN filter");
-		ret = -EINVAL;
-		goto DONE;
+		return -EINVAL;
 	}
 
 	/* Add vlan into vlan list */
 	f = rte_zmalloc(NULL, sizeof(*f), 0);
 	if (!f) {
 		PMD_DRV_LOG(ERR, "failed to allocate memory");
-		ret = -ENOMEM;
-		goto DONE;
+		return -ENOMEM;
 	}
 	f->vlan_info.vlan.tpid = vlan->tpid;
 	f->vlan_info.vlan.vid = vlan->vid;
 	TAILQ_INSERT_TAIL(&vsi->vlan_list, f, next);
 	vsi->vlan_num++;
 
-	ret = 0;
-
-DONE:
-	ice_free(hw, v_list_itr);
-	return ret;
+	return 0;
 }
 
 static int
 ice_remove_vlan_filter(struct ice_vsi *vsi, struct ice_vlan *vlan)
 {
-	struct ice_fltr_list_entry *v_list_itr = NULL;
+	struct ice_fltr_list_entry v_list_entry = {0};
+	struct ice_fltr_list_entry *v_list_itr = &v_list_entry;
 	struct ice_vlan_filter *f;
 	struct LIST_HEAD_TYPE list_head;
 	struct ice_hw *hw;
@@ -1353,13 +1323,6 @@ ice_remove_vlan_filter(struct ice_vsi *vsi, struct ice_vlan *vlan)
 
 	INIT_LIST_HEAD(&list_head);
 
-	v_list_itr = (struct ice_fltr_list_entry *)
-		      ice_malloc(hw, sizeof(*v_list_itr));
-	if (!v_list_itr) {
-		ret = -ENOMEM;
-		goto DONE;
-	}
-
 	v_list_itr->fltr_info.l_data.vlan.vlan_id = vlan->vid;
 	v_list_itr->fltr_info.l_data.vlan.tpid = vlan->tpid;
 	v_list_itr->fltr_info.l_data.vlan.tpid_valid = true;
@@ -1375,8 +1338,7 @@ ice_remove_vlan_filter(struct ice_vsi *vsi, struct ice_vlan *vlan)
 	ret = ice_remove_vlan(hw, &list_head);
 	if (ret != ICE_SUCCESS) {
 		PMD_DRV_LOG(ERR, "Failed to remove VLAN filter");
-		ret = -EINVAL;
-		goto DONE;
+		return -EINVAL;
 	}
 
 	/* Remove the vlan id from vlan list */
@@ -1384,10 +1346,7 @@ ice_remove_vlan_filter(struct ice_vsi *vsi, struct ice_vlan *vlan)
 	rte_free(f);
 	vsi->vlan_num--;
 
-	ret = 0;
-DONE:
-	ice_free(hw, v_list_itr);
-	return ret;
+	return 0;
 }
 
 static int
@@ -2554,7 +2513,7 @@ ice_get_hw_res(struct ice_hw *hw, uint16_t res_type,
 		uint16_t num, uint16_t desc_id,
 		uint16_t *prof_buf, uint16_t *num_prof)
 {
-	struct ice_aqc_res_elem *resp_buf;
+	struct ice_aqc_res_elem resp_buf[ICE_MAX_RES_DESC_NUM] = {0};
 	int ret;
 	uint16_t buf_len;
 	bool res_shared = 1;
@@ -2563,10 +2522,10 @@ ice_get_hw_res(struct ice_hw *hw, uint16_t res_type,
 	struct ice_aqc_get_allocd_res_desc *cmd =
 			&aq_desc.params.get_res_desc;
 
+	if (num > RTE_DIM(resp_buf))
+		return -EINVAL;
+
 	buf_len = sizeof(*resp_buf) * num;
-	resp_buf = ice_malloc(hw, buf_len);
-	if (!resp_buf)
-		return -ENOMEM;
 
 	ice_fill_dflt_direct_cmd_desc(&aq_desc,
 			ice_aqc_opc_get_allocd_res_desc);
@@ -2580,13 +2539,14 @@ ice_get_hw_res(struct ice_hw *hw, uint16_t res_type,
 	if (!ret)
 		*num_prof = LE16_TO_CPU(cmd->ops.resp.num_desc);
 	else
-		goto exit;
+		return ret;
+
+	if (*num_prof > num)
+		return -EIO;
 
 	ice_memcpy(prof_buf, resp_buf, sizeof(*resp_buf) *
 			(*num_prof), ICE_NONDMA_TO_NONDMA);
 
-exit:
-	ice_free(hw, resp_buf);
 	return ret;
 }
 static int
@@ -5276,7 +5236,8 @@ ice_phy_conf_link(struct ice_hw *hw,
 	struct ice_aqc_set_phy_cfg_data cfg = { 0 };
 	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(hw->back);
 	struct ice_port_info *pi = hw->port_info;
-	struct ice_aqc_get_phy_caps_data *phy_caps;
+	struct ice_aqc_get_phy_caps_data phy_caps_data = {0};
+	struct ice_aqc_get_phy_caps_data *phy_caps = &phy_caps_data;
 	int err;
 	u64 phy_type_low = 0;
 	u64 phy_type_high = 0;
@@ -5284,11 +5245,6 @@ ice_phy_conf_link(struct ice_hw *hw,
 	if (!pi)
 		return -EIO;
 
-	phy_caps = (struct ice_aqc_get_phy_caps_data *)
-		ice_malloc(hw, sizeof(*phy_caps));
-	if (!phy_caps)
-		return ICE_ERR_NO_MEMORY;
-
 
 	if (ice_fw_supports_report_dflt_cfg(pi->hw))
 		err = ice_aq_get_phy_caps(pi, false, ICE_AQC_REPORT_DFLT_CFG,
@@ -5297,7 +5253,7 @@ ice_phy_conf_link(struct ice_hw *hw,
 		err = ice_aq_get_phy_caps(pi, false, ICE_AQC_REPORT_TOPO_CAP_MEDIA,
 					  phy_caps, NULL);
 	if (err)
-		goto done;
+		return err;
 
 	ice_update_phy_type(&phy_type_low, &phy_type_high, link_speeds_bitmap);
 
@@ -5333,8 +5289,6 @@ ice_phy_conf_link(struct ice_hw *hw,
 
 	err = ice_aq_set_phy_cfg(hw, pi, &cfg, NULL);
 
-done:
-	ice_free(hw, phy_caps);
 	return err;
 }
 
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 6f19e070ee..a865541375 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -790,7 +790,7 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 	struct ice_vsi *vsi;
 	struct ice_hw *hw;
 	struct ice_pf *pf;
-	struct ice_aqc_add_tx_qgrp *txq_elem;
+	RTE_DEFINE_FLEX(struct ice_aqc_add_tx_qgrp, txq_elem, txqs, 1);
 	struct ice_tlan_ctx tx_ctx;
 	int buf_len;
 	struct ice_adapter *ad = ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
@@ -816,9 +816,6 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 		return 0;
 
 	buf_len = ice_struct_size(txq_elem, txqs, 1);
-	txq_elem = ice_malloc(hw, buf_len);
-	if (!txq_elem)
-		return -ENOMEM;
 
 	vsi = txq->ice_vsi;
 	hw = ICE_VSI_TO_HW(vsi);
@@ -854,13 +851,11 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 		}
 		if (cgd_idx >= ICE_MAX_TRAFFIC_CLASS) {
 			PMD_DRV_LOG(ERR, "Bad queue mapping configuration");
-			ice_free(hw, txq_elem);
 			return -EINVAL;
 		}
 	} else if (pf->dcb_num_tcs > 1) {
 		/* TM only manages the TC0 scheduler subtree. */
 		PMD_DRV_LOG(ERR, "TM hierarchy is not supported together with multi-TC DCB");
-		ice_free(hw, txq_elem);
 		return -EINVAL;
 	}
 
@@ -874,7 +869,6 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 			txq_elem, buf_len, NULL);
 	if (err) {
 		PMD_DRV_LOG(ERR, "Failed to add lan txq");
-		ice_free(hw, txq_elem);
 		return -EIO;
 	}
 	/* store the schedule node id */
@@ -884,7 +878,6 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 	if (pf->tm_conf.committed)
 		if (ice_tm_setup_txq_node(pf, hw, tx_queue_id, txq->q_teid) != 0) {
 			PMD_DRV_LOG(ERR, "Failed to set up txq traffic management node");
-			ice_free(hw, txq_elem);
 			return -EIO;
 		}
 
@@ -893,15 +886,10 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 	txq->use_ctx = ad->use_ctx;
 
 	if (txq->tsq != NULL && txq->tsq->ts_flag > 0) {
-		struct ice_aqc_set_txtime_qgrp *ts_elem;
+		RTE_DEFINE_FLEX(struct ice_aqc_set_txtime_qgrp, ts_elem, txtimeqs, 1);
 		struct ice_txtime_ctx txtime_ctx = { 0 };
 		u8 ts_buf_len = ice_struct_size(ts_elem, txtimeqs, 1);
 
-		ts_elem = ice_malloc(hw, ts_buf_len);
-		if (!ts_elem) {
-			ice_free(hw, txq_elem);
-			return -ENOMEM;
-		}
 		ice_setup_txtime_ctx(txq, &txtime_ctx, true);
 		ice_set_ctx(hw, (u8 *)&txtime_ctx,
 				ts_elem->txtimeqs[0].txtime_ctx,
@@ -913,10 +901,8 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 		ICE_PCI_REG_WRITE(txq->qtx_tail, 0);
 
 		err = ice_aq_set_txtimeq(hw, txq->reg_idx, 1, ts_elem, ts_buf_len, NULL);
-		ice_free(hw, ts_elem);
 		if (err) {
 			PMD_DRV_LOG(ERR, "Failed to set Tx Time queue context, error: %d", err);
-			ice_free(hw, txq_elem);
 			return err;
 		}
 	} else {
@@ -928,7 +914,6 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 
 	dev->data->tx_queue_state[tx_queue_id] = RTE_ETH_QUEUE_STATE_STARTED;
 
-	ice_free(hw, txq_elem);
 	return 0;
 }
 
@@ -1052,7 +1037,7 @@ ice_fdir_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 	int err;
 	struct ice_vsi *vsi;
 	struct ice_hw *hw;
-	struct ice_aqc_add_tx_qgrp *txq_elem;
+	RTE_DEFINE_FLEX(struct ice_aqc_add_tx_qgrp, txq_elem, txqs, 1);
 	struct ice_tlan_ctx tx_ctx;
 	int buf_len;
 
@@ -1066,9 +1051,6 @@ ice_fdir_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 	}
 
 	buf_len = ice_struct_size(txq_elem, txqs, 1);
-	txq_elem = ice_malloc(hw, buf_len);
-	if (!txq_elem)
-		return -ENOMEM;
 
 	vsi = txq->ice_vsi;
 	hw = ICE_VSI_TO_HW(vsi);
@@ -1100,13 +1082,11 @@ ice_fdir_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 			      txq_elem, buf_len, NULL);
 	if (err) {
 		PMD_DRV_LOG(ERR, "Failed to add FDIR txq");
-		ice_free(hw, txq_elem);
 		return -EIO;
 	}
 	/* store the schedule node id */
 	txq->q_teid = txq_elem->txqs[0].q_teid;
 
-	ice_free(hw, txq_elem);
 	return 0;
 }
 
diff --git a/drivers/net/intel/ice/ice_tm.c b/drivers/net/intel/ice/ice_tm.c
index 9566a36098..82b0bc5f4a 100644
--- a/drivers/net/intel/ice/ice_tm.c
+++ b/drivers/net/intel/ice/ice_tm.c
@@ -712,14 +712,10 @@ ice_tm_setup_txq_node(struct ice_pf *pf, struct ice_hw *hw, uint16_t qid, uint32
 
 	/* if the queue node has been put in the wrong place in hierarchy */
 	if (hw_node->parent != sw_node->parent->sched_node) {
-		struct ice_aqc_move_txqs_data *buf;
+		RTE_DEFINE_FLEX(struct ice_aqc_move_txqs_data, buf, txqs, 1);
 		uint8_t txqs_moved = 0;
 		uint16_t buf_size = ice_struct_size(buf, txqs, 1);
 
-		buf = calloc(1, buf_size);
-		if (buf == NULL)
-			return -ENOMEM;
-
 		struct ice_sched_node *parent = hw_node->parent;
 		struct ice_sched_node *new_parent = sw_node->parent->sched_node;
 		buf->src_teid = parent->info.node_teid;
@@ -729,7 +725,6 @@ ice_tm_setup_txq_node(struct ice_pf *pf, struct ice_hw *hw, uint16_t qid, uint32
 
 		int ret = ice_aq_move_recfg_lan_txq(hw, 1, true, false, false, false, 50,
 						NULL, buf, buf_size, &txqs_moved, NULL);
-		free(buf);
 		if (ret || txqs_moved == 0) {
 			PMD_DRV_LOG(ERR, "move lan queue %u failed", qid);
 			return ICE_ERR_PARAM;
-- 
2.55.0

