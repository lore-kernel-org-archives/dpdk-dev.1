Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF51CD4F3C
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 16:08:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6E7F4065A;
	Tue, 19 May 2026 18:08:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id B07AC40276
 for <dev@dpdk.org>; Tue, 19 May 2026 18:08:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779206917; x=1810742917;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/oTg7z2zgyZnzVG5vDlShGkad8TFaqRgEozCxdQQBSo=;
 b=AXlahgFK1swXKPbJAwJNjshEM/yJ6x2zq/3fv4oCldBRwmsZT9UIXALo
 6vXxPHMsAFrFVAN+e0wywYTJMnSfIn73eKeEBsCPOZIASSHG8M4/m9s+V
 zhBzaduqvi1u/Wdn6KKzPbG80ghYV+iVk7/Hj4WuWzC7Mrhco4INxIND+
 ClJg5+GJyrU8VXnU4gTgP5MoFwL3KZBIumb25IbpGClrObJvOMoiWpVej
 ewbHZWBFQ2EJW1tiwn5QC6qjAI/vBpqxFG37AeVMj1KrgpCMW6Bsz+SPu
 0aVagp7nS5EOwFpMw3HhfLxF3i9Ginq6eyEmROE0h67pT3DJL3XvAHqrr A==;
X-CSE-ConnectionGUID: y9wIHdcKTQS6GG43voE3zg==
X-CSE-MsgGUID: JdIQKsZUR1y9gal9UPclOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80070043"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="80070043"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 09:08:37 -0700
X-CSE-ConnectionGUID: 2wNNq1x1Q7O4QbZhSv+uag==
X-CSE-MsgGUID: OxHrbDTjTLidm51zocvjtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="244784765"
Received: from silpixa00401874.ir.intel.com (HELO
 silpixa00401874.ger.corp.intel.com) ([10.20.224.247])
 by orviesa005.jf.intel.com with ESMTP; 19 May 2026 09:08:36 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 1/8] net/ice: replace use of DPDK-specific memcpy function
Date: Tue, 19 May 2026 16:05:58 +0000
Message-ID: <20260519160823.1004973-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260519160823.1004973-1-bruce.richardson@intel.com>
References: <20260519160823.1004973-1-bruce.richardson@intel.com>
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

The driver use of memcpy is for control path work, for example, flow
configuration and so is fine using the standard libc memcpy function in
place of the DPDK-specific rte_memcpy version.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/base/ice_osdep.h   |  5 ++--
 drivers/net/intel/ice/ice_dcf.c          | 14 ++++-----
 drivers/net/intel/ice/ice_dcf_ethdev.c   | 10 +++----
 drivers/net/intel/ice/ice_dcf_parent.c   |  2 +-
 drivers/net/intel/ice/ice_dcf_sched.c    |  6 ++--
 drivers/net/intel/ice/ice_diagnose.c     |  4 +--
 drivers/net/intel/ice/ice_ethdev.c       | 12 ++++----
 drivers/net/intel/ice/ice_fdir_filter.c  | 36 ++++++++++++------------
 drivers/net/intel/ice/ice_generic_flow.c |  4 +--
 drivers/net/intel/ice/ice_hash.c         |  2 +-
 drivers/net/intel/ice/ice_tm.c           |  2 +-
 11 files changed, 48 insertions(+), 49 deletions(-)

diff --git a/drivers/net/intel/ice/base/ice_osdep.h b/drivers/net/intel/ice/base/ice_osdep.h
index 21c460d007..5d92cf5aa4 100644
--- a/drivers/net/intel/ice/base/ice_osdep.h
+++ b/drivers/net/intel/ice/base/ice_osdep.h
@@ -14,7 +14,6 @@
 #include <stdbool.h>
 
 #include <rte_common.h>
-#include <rte_memcpy.h>
 #include <rte_malloc.h>
 #include <rte_memzone.h>
 #include <rte_byteorder.h>
@@ -210,7 +209,7 @@ struct __rte_packed_begin ice_virt_mem {
 #define ice_free(h, m)      ((void)h, rte_free(m))
 
 #define ice_memset(a, b, c, d) memset((a), (b), (c))
-#define ice_memcpy(a, b, c, d) rte_memcpy((a), (b), (c))
+#define ice_memcpy(a, b, c, d) memcpy((a), (b), (c))
 
 /* Memory fence barrier */
 #define ice_memfence_read()        rte_io_rmb()
@@ -238,7 +237,7 @@ ice_memdup(__rte_unused struct ice_hw *hw, const void *src, size_t size,
 
 	p = ice_malloc(hw, size);
 	if (p)
-		rte_memcpy(p, src, size);
+		memcpy(p, src, size);
 
 	return p;
 }
diff --git a/drivers/net/intel/ice/ice_dcf.c b/drivers/net/intel/ice/ice_dcf.c
index 51716a4d5b..98ae0f8980 100644
--- a/drivers/net/intel/ice/ice_dcf.c
+++ b/drivers/net/intel/ice/ice_dcf.c
@@ -268,7 +268,7 @@ ice_dcf_aq_cmd_handle(struct ice_dcf_hw *hw, struct iavf_arq_event_info *info)
 			cmd->rsp_msglen = RTE_MIN(info->msg_len,
 						  cmd->rsp_buflen);
 			if (likely(cmd->rsp_msglen != 0))
-				rte_memcpy(cmd->rsp_msgbuf, info->msg_buf,
+				memcpy(cmd->rsp_msgbuf, info->msg_buf,
 					   cmd->rsp_msglen);
 
 			/* prevent compiler reordering */
@@ -453,7 +453,7 @@ ice_dcf_get_vf_vsi_map(struct ice_dcf_hw *hw)
 		return 1;
 	}
 
-	rte_memcpy(hw->vf_vsi_map, vsi_map->vf_vsi, len);
+	memcpy(hw->vf_vsi_map, vsi_map->vf_vsi, len);
 	return 0;
 }
 
@@ -731,7 +731,7 @@ dcf_get_vlan_offload_caps_v2(struct ice_dcf_hw *hw)
 		return ret;
 	}
 
-	rte_memcpy(&hw->vlan_v2_caps, &vlan_v2_caps, sizeof(vlan_v2_caps));
+	memcpy(&hw->vlan_v2_caps, &vlan_v2_caps, sizeof(vlan_v2_caps));
 	return 0;
 }
 
@@ -931,7 +931,7 @@ ice_dcf_configure_rss_key(struct ice_dcf_hw *hw)
 
 	rss_key->vsi_id = hw->vsi_res->vsi_id;
 	rss_key->key_len = hw->vf_res->rss_key_size;
-	rte_memcpy(rss_key->key, hw->rss_key, hw->vf_res->rss_key_size);
+	memcpy(rss_key->key, hw->rss_key, hw->vf_res->rss_key_size);
 
 	args.v_op = VIRTCHNL_OP_CONFIG_RSS_KEY;
 	args.req_msglen = len;
@@ -963,7 +963,7 @@ ice_dcf_configure_rss_lut(struct ice_dcf_hw *hw)
 
 	rss_lut->vsi_id = hw->vsi_res->vsi_id;
 	rss_lut->lut_entries = hw->vf_res->rss_lut_size;
-	rte_memcpy(rss_lut->lut, hw->rss_lut, hw->vf_res->rss_lut_size);
+	memcpy(rss_lut->lut, hw->rss_lut, hw->vf_res->rss_lut_size);
 
 	args.v_op = VIRTCHNL_OP_CONFIG_RSS_LUT;
 	args.req_msglen = len;
@@ -1130,7 +1130,7 @@ ice_dcf_init_rss(struct ice_dcf_hw *hw)
 		for (i = 0; i < hw->vf_res->rss_key_size; i++)
 			hw->rss_key[i] = (uint8_t)rte_rand();
 	else
-		rte_memcpy(hw->rss_key, rss_conf->rss_key,
+		memcpy(hw->rss_key, rss_conf->rss_key,
 			   RTE_MIN(rss_conf->rss_key_len,
 				   hw->vf_res->rss_key_size));
 
@@ -1406,7 +1406,7 @@ ice_dcf_add_del_all_mac_addr(struct ice_dcf_hw *hw,
 		return -ENOMEM;
 	}
 
-	rte_memcpy(list->list[0].addr, addr->addr_bytes,
+	memcpy(list->list[0].addr, addr->addr_bytes,
 			sizeof(addr->addr_bytes));
 
 	PMD_DRV_LOG(DEBUG, "add/rm mac:" RTE_ETHER_ADDR_PRT_FMT,
diff --git a/drivers/net/intel/ice/ice_dcf_ethdev.c b/drivers/net/intel/ice/ice_dcf_ethdev.c
index 0d3599d7d0..4fce59617e 100644
--- a/drivers/net/intel/ice/ice_dcf_ethdev.c
+++ b/drivers/net/intel/ice/ice_dcf_ethdev.c
@@ -1336,7 +1336,7 @@ ice_dcf_dev_rss_reta_update(struct rte_eth_dev *dev,
 		return -ENOMEM;
 	}
 	/* store the old lut table temporarily */
-	rte_memcpy(lut, hw->rss_lut, reta_size);
+	memcpy(lut, hw->rss_lut, reta_size);
 
 	for (i = 0; i < reta_size; i++) {
 		idx = i / RTE_ETH_RETA_GROUP_SIZE;
@@ -1345,11 +1345,11 @@ ice_dcf_dev_rss_reta_update(struct rte_eth_dev *dev,
 			lut[i] = reta_conf[idx].reta[shift];
 	}
 
-	rte_memcpy(hw->rss_lut, lut, reta_size);
+	memcpy(hw->rss_lut, lut, reta_size);
 	/* send virtchnnl ops to configure rss*/
 	ret = ice_dcf_configure_rss_lut(hw);
 	if (ret) /* revert back */
-		rte_memcpy(hw->rss_lut, lut, reta_size);
+		memcpy(hw->rss_lut, lut, reta_size);
 	free(lut);
 
 	return ret;
@@ -1399,7 +1399,7 @@ ice_dcf_set_rss_key(struct ice_dcf_hw *hw, uint8_t *key, uint8_t key_len)
 		return -EINVAL;
 	}
 
-	rte_memcpy(hw->rss_key, key, key_len);
+	memcpy(hw->rss_key, key, key_len);
 
 	return ice_dcf_configure_rss_key(hw);
 }
@@ -1456,7 +1456,7 @@ ice_dcf_dev_rss_hash_conf_get(struct rte_eth_dev *dev,
 		return 0;
 
 	rss_conf->rss_key_len = hw->vf_res->rss_key_size;
-	rte_memcpy(rss_conf->rss_key, hw->rss_key, rss_conf->rss_key_len);
+	memcpy(rss_conf->rss_key, hw->rss_key, rss_conf->rss_key_len);
 
 	return 0;
 }
diff --git a/drivers/net/intel/ice/ice_dcf_parent.c b/drivers/net/intel/ice/ice_dcf_parent.c
index f92bd5e726..2c7d94b50d 100644
--- a/drivers/net/intel/ice/ice_dcf_parent.c
+++ b/drivers/net/intel/ice/ice_dcf_parent.c
@@ -418,7 +418,7 @@ ice_dcf_load_pkg(struct ice_adapter *adapter)
 
 	use_dsn = ice_dcf_execute_virtchnl_cmd(&dcf_adapter->real_hw, &vc_cmd) == 0;
 	if (use_dsn)
-		rte_memcpy(&dsn, pkg_info.dsn, sizeof(dsn));
+		memcpy(&dsn, pkg_info.dsn, sizeof(dsn));
 
 	return ice_load_pkg(adapter, use_dsn, dsn);
 }
diff --git a/drivers/net/intel/ice/ice_dcf_sched.c b/drivers/net/intel/ice/ice_dcf_sched.c
index 948774a282..19185ca308 100644
--- a/drivers/net/intel/ice/ice_dcf_sched.c
+++ b/drivers/net/intel/ice/ice_dcf_sched.c
@@ -310,7 +310,7 @@ ice_dcf_node_add(struct rte_eth_dev *dev, uint32_t node_id,
 		tm_node->id = node_id;
 		tm_node->parent = NULL;
 		tm_node->reference_count = 0;
-		rte_memcpy(&tm_node->params, params,
+		memcpy(&tm_node->params, params,
 				 sizeof(struct rte_tm_node_params));
 		hw->tm_conf.root = tm_node;
 
@@ -375,7 +375,7 @@ ice_dcf_node_add(struct rte_eth_dev *dev, uint32_t node_id,
 	tm_node->shaper_profile = shaper_profile;
 	tm_node->reference_count = 0;
 	tm_node->parent = parent_node;
-	rte_memcpy(&tm_node->params, params,
+	memcpy(&tm_node->params, params,
 			 sizeof(struct rte_tm_node_params));
 	if (parent_node_type == ICE_DCF_TM_NODE_TYPE_PORT) {
 		TAILQ_INSERT_TAIL(&hw->tm_conf.tc_list,
@@ -522,7 +522,7 @@ ice_dcf_shaper_profile_add(struct rte_eth_dev *dev,
 	if (!shaper_profile)
 		return -ENOMEM;
 	shaper_profile->shaper_profile_id = shaper_profile_id;
-	rte_memcpy(&shaper_profile->profile, profile,
+	memcpy(&shaper_profile->profile, profile,
 			 sizeof(struct rte_tm_shaper_params));
 	TAILQ_INSERT_TAIL(&hw->tm_conf.shaper_profile_list,
 			  shaper_profile, node);
diff --git a/drivers/net/intel/ice/ice_diagnose.c b/drivers/net/intel/ice/ice_diagnose.c
index a58279a116..4946ace7ae 100644
--- a/drivers/net/intel/ice/ice_diagnose.c
+++ b/drivers/net/intel/ice/ice_diagnose.c
@@ -363,13 +363,13 @@ ice_dump_pkg(struct rte_eth_dev *dev, uint8_t **buff, uint32_t *size)
 	count = *size / ICE_PKG_BUF_SIZE;
 	for (i = 0; i < count; i++) {
 		next_buff = (uint8_t *)(*buff) + i * ICE_PKG_BUF_SIZE;
-		rte_memcpy(pkg_buff.buf, next_buff, ICE_PKG_BUF_SIZE);
+		memcpy(pkg_buff.buf, next_buff, ICE_PKG_BUF_SIZE);
 		if (ice_aq_upload_section(hw,
 					  (struct ice_buf_hdr *)&pkg_buff.buf[0],
 					  ICE_PKG_BUF_SIZE,
 					  NULL))
 			return -EINVAL;
-		rte_memcpy(next_buff, pkg_buff.buf, ICE_PKG_BUF_SIZE);
+		memcpy(next_buff, pkg_buff.buf, ICE_PKG_BUF_SIZE);
 	}
 
 	cache_size = sizeof(struct ice_package_header) + *size;
diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 0f2e7aee14..9ffbce2ae5 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -3697,7 +3697,7 @@ ice_get_default_rss_key(uint8_t *rss_key, uint32_t rss_key_size)
 			key[i] = (uint8_t)rte_rand();
 		default_key_done = true;
 	}
-	rte_memcpy(rss_key, key, RTE_MIN(rss_key_size, sizeof(default_key)));
+	memcpy(rss_key, key, RTE_MIN(rss_key_size, sizeof(default_key)));
 }
 
 static int ice_init_rss(struct ice_pf *pf)
@@ -3752,13 +3752,13 @@ static int ice_init_rss(struct ice_pf *pf)
 	if (!rss_conf->rss_key)
 		ice_get_default_rss_key(vsi->rss_key, vsi->rss_key_size);
 	else
-		rte_memcpy(vsi->rss_key, rss_conf->rss_key,
+		memcpy(vsi->rss_key, rss_conf->rss_key,
 			   RTE_MIN(rss_conf->rss_key_len,
 				   vsi->rss_key_size));
 
-	rte_memcpy(key.standard_rss_key, vsi->rss_key,
+	memcpy(key.standard_rss_key, vsi->rss_key,
 		ICE_AQC_GET_SET_RSS_KEY_DATA_RSS_KEY_SIZE);
-	rte_memcpy(key.extended_hash_key,
+	memcpy(key.extended_hash_key,
 		&vsi->rss_key[ICE_AQC_GET_SET_RSS_KEY_DATA_RSS_KEY_SIZE],
 		ICE_AQC_GET_SET_RSS_KEY_DATA_HASH_KEY_SIZE);
 	ret = ice_aq_set_rss_key(hw, vsi->idx, &key);
@@ -5156,7 +5156,7 @@ ice_vsi_config_vlan_filter(struct ice_vsi *vsi, bool on)
 		vsi->info.sw_flags2 &= ~sw_flags2;
 
 	vsi->info.sw_id = hw->port_info->sw_id;
-	(void)rte_memcpy(&ctxt.info, &vsi->info, sizeof(vsi->info));
+	(void)memcpy(&ctxt.info, &vsi->info, sizeof(vsi->info));
 	ctxt.info.valid_sections =
 		rte_cpu_to_le_16(ICE_AQ_VSI_PROP_SW_VALID |
 				 ICE_AQ_VSI_PROP_SECURITY_VALID);
@@ -5911,7 +5911,7 @@ ice_vsi_vlan_pvid_set(struct ice_vsi *vsi, struct ice_vsi_vlan_pvid_info *info)
 				  ICE_AQ_VSI_INNER_VLAN_EMODE_M);
 	vsi->info.inner_vlan_flags |= vlan_flags;
 	memset(&ctxt, 0, sizeof(ctxt));
-	rte_memcpy(&ctxt.info, &vsi->info, sizeof(vsi->info));
+	memcpy(&ctxt.info, &vsi->info, sizeof(vsi->info));
 	ctxt.info.valid_sections =
 		rte_cpu_to_le_16(ICE_AQ_VSI_PROP_VLAN_VALID);
 	ctxt.vsi_num = vsi->vsi_id;
diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
index 3522d77123..2276a198fc 100644
--- a/drivers/net/intel/ice/ice_fdir_filter.c
+++ b/drivers/net/intel/ice/ice_fdir_filter.c
@@ -1268,7 +1268,7 @@ ice_fdir_add_del_raw(struct ice_pf *pf,
 	struct ice_hw *hw = ICE_PF_TO_HW(pf);
 
 	unsigned char *pkt = (unsigned char *)pf->fdir.prg_pkt;
-	rte_memcpy(pkt, filter->pkt_buf, filter->pkt_len);
+	memcpy(pkt, filter->pkt_buf, filter->pkt_len);
 
 	struct ice_fltr_desc desc;
 	memset(&desc, 0, sizeof(desc));
@@ -1315,16 +1315,16 @@ ice_fdir_extract_fltr_key(struct ice_fdir_fltr_pattern *key,
 	memset(key, 0, sizeof(*key));
 
 	key->flow_type = input->flow_type;
-	rte_memcpy(&key->ip, &input->ip, sizeof(key->ip));
-	rte_memcpy(&key->mask, &input->mask, sizeof(key->mask));
-	rte_memcpy(&key->ext_data, &input->ext_data, sizeof(key->ext_data));
-	rte_memcpy(&key->ext_mask, &input->ext_mask, sizeof(key->ext_mask));
+	memcpy(&key->ip, &input->ip, sizeof(key->ip));
+	memcpy(&key->mask, &input->mask, sizeof(key->mask));
+	memcpy(&key->ext_data, &input->ext_data, sizeof(key->ext_data));
+	memcpy(&key->ext_mask, &input->ext_mask, sizeof(key->ext_mask));
 
-	rte_memcpy(&key->gtpu_data, &input->gtpu_data, sizeof(key->gtpu_data));
-	rte_memcpy(&key->gtpu_mask, &input->gtpu_mask, sizeof(key->gtpu_mask));
+	memcpy(&key->gtpu_data, &input->gtpu_data, sizeof(key->gtpu_data));
+	memcpy(&key->gtpu_mask, &input->gtpu_mask, sizeof(key->gtpu_mask));
 
-	rte_memcpy(&key->l2tpv2_data, &input->l2tpv2_data, sizeof(key->l2tpv2_data));
-	rte_memcpy(&key->l2tpv2_mask, &input->l2tpv2_mask, sizeof(key->l2tpv2_mask));
+	memcpy(&key->l2tpv2_data, &input->l2tpv2_data, sizeof(key->l2tpv2_data));
+	memcpy(&key->l2tpv2_mask, &input->l2tpv2_mask, sizeof(key->l2tpv2_mask));
 
 	key->tunnel_type = filter->tunnel_type;
 }
@@ -1452,7 +1452,7 @@ ice_fdir_create_filter(struct ice_adapter *ad,
 		if (!entry)
 			goto error;
 
-		rte_memcpy(entry, filter, sizeof(*filter));
+		memcpy(entry, filter, sizeof(*filter));
 
 		flow->rule = entry;
 
@@ -1513,7 +1513,7 @@ ice_fdir_create_filter(struct ice_adapter *ad,
 	if (filter->mark_flag == 1)
 		ice_fdir_rx_parsing_enable(ad, 1);
 
-	rte_memcpy(entry, filter, sizeof(*entry));
+	memcpy(entry, filter, sizeof(*entry));
 	ret = ice_fdir_entry_insert(pf, entry, &key);
 	if (ret) {
 		rte_flow_error_set(error, -ret,
@@ -1812,7 +1812,7 @@ ice_fdir_parse_action(struct ice_adapter *ad,
 
 			act_count = actions->conf;
 			filter->input.cnt_ena = ICE_FXD_FLTR_QW0_STAT_ENA_PKTS;
-			rte_memcpy(&filter->act_count, act_count,
+			memcpy(&filter->act_count, act_count,
 						sizeof(filter->act_count));
 
 			break;
@@ -2036,7 +2036,7 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
 				ret_val = -ENOMEM;
 				goto raw_error;
 			}
-			rte_memcpy(pkt_buf, tmp_spec, pkt_len);
+			memcpy(pkt_buf, tmp_spec, pkt_len);
 			filter->pkt_buf = pkt_buf;
 
 			filter->pkt_len = pkt_len;
@@ -2086,11 +2086,11 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
 			p_ext_data = (tunnel_type && is_outer) ?
 				     &filter->input.ext_data_outer :
 				     &filter->input.ext_data;
-			rte_memcpy(&p_ext_data->src_mac,
+			memcpy(&p_ext_data->src_mac,
 				   &eth_spec->hdr.src_addr, RTE_ETHER_ADDR_LEN);
-			rte_memcpy(&p_ext_data->dst_mac,
+			memcpy(&p_ext_data->dst_mac,
 				   &eth_spec->hdr.dst_addr, RTE_ETHER_ADDR_LEN);
-			rte_memcpy(&p_ext_data->ether_type,
+			memcpy(&p_ext_data->ether_type,
 				   &eth_spec->hdr.ether_type, sizeof(eth_spec->hdr.ether_type));
 			break;
 		case RTE_FLOW_ITEM_TYPE_IPV4:
@@ -2256,8 +2256,8 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
 			if (ipv6_mask->hdr.hop_limits == UINT8_MAX)
 				*input_set |= ICE_INSET_IPV6_HOP_LIMIT;
 
-			rte_memcpy(&p_v6->dst_ip, &ipv6_spec->hdr.dst_addr, 16);
-			rte_memcpy(&p_v6->src_ip, &ipv6_spec->hdr.src_addr, 16);
+			memcpy(&p_v6->dst_ip, &ipv6_spec->hdr.dst_addr, 16);
+			memcpy(&p_v6->src_ip, &ipv6_spec->hdr.src_addr, 16);
 			vtc_flow_cpu = rte_be_to_cpu_32(ipv6_spec->hdr.vtc_flow);
 			p_v6->tc = (uint8_t)(vtc_flow_cpu >> ICE_FDIR_IPV6_TC_OFFSET);
 			p_v6->proto = ipv6_spec->hdr.proto;
diff --git a/drivers/net/intel/ice/ice_generic_flow.c b/drivers/net/intel/ice/ice_generic_flow.c
index 62f0c334a1..a3ddbc65a6 100644
--- a/drivers/net/intel/ice/ice_generic_flow.c
+++ b/drivers/net/intel/ice/ice_generic_flow.c
@@ -2121,7 +2121,7 @@ ice_pattern_skip_void_item(struct rte_flow_item *items,
 		pe = ice_find_first_item(pb + 1, true);
 
 		cpy_count = pe - pb;
-		rte_memcpy(items, pb, sizeof(struct rte_flow_item) * cpy_count);
+		memcpy(items, pb, sizeof(struct rte_flow_item) * cpy_count);
 
 		items += cpy_count;
 
@@ -2132,7 +2132,7 @@ ice_pattern_skip_void_item(struct rte_flow_item *items,
 		pb = pe + 1;
 	}
 	/* Copy the END item. */
-	rte_memcpy(items, pe, sizeof(struct rte_flow_item));
+	memcpy(items, pe, sizeof(struct rte_flow_item));
 }
 
 /* Check if the pattern matches a supported item type array */
diff --git a/drivers/net/intel/ice/ice_hash.c b/drivers/net/intel/ice/ice_hash.c
index 77829e607b..51916ff6d7 100644
--- a/drivers/net/intel/ice/ice_hash.c
+++ b/drivers/net/intel/ice/ice_hash.c
@@ -751,7 +751,7 @@ ice_hash_parse_raw_pattern(struct ice_adapter *ad,
 	if (ret)
 		goto free_mem;
 
-	rte_memcpy(&meta->raw.prof, &prof, sizeof(prof));
+	memcpy(&meta->raw.prof, &prof, sizeof(prof));
 
 free_mem:
 	free(pkt_buf);
diff --git a/drivers/net/intel/ice/ice_tm.c b/drivers/net/intel/ice/ice_tm.c
index ff53f2acfd..0285ee3be8 100644
--- a/drivers/net/intel/ice/ice_tm.c
+++ b/drivers/net/intel/ice/ice_tm.c
@@ -356,7 +356,7 @@ ice_shaper_profile_add(struct rte_eth_dev *dev,
 	if (!shaper_profile)
 		return -ENOMEM;
 	shaper_profile->shaper_profile_id = shaper_profile_id;
-	rte_memcpy(&shaper_profile->profile, profile,
+	memcpy(&shaper_profile->profile, profile,
 			 sizeof(struct rte_tm_shaper_params));
 	TAILQ_INSERT_TAIL(&pf->tm_conf.shaper_profile_list,
 			  shaper_profile, node);
-- 
2.51.0

