Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6723E9B258
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 12:26:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A83F40A79;
	Tue, 24 Feb 2026 13:24:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id E4EDF4066F
 for <dev@dpdk.org>; Tue, 24 Feb 2026 13:24:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771935844; x=1803471844;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=8objT8v9E6NMbOC0tXSGahnwfuPPWhTSA/h/CMvn6CY=;
 b=EJlt270+nlftoLOAJt3MCfVH/Q+hNTq8O2H3ak2Sx/AXa9o+qRiLy3es
 v/iFNVVbxaVWzJSAWvQMAQ0rzZkw8YiD6myc3cpOz1TObHiT03RwHeWEY
 77ds+n0VYdctLEI+mwEAXUXTnSSoaGrofLpIad9Vrti4Ey8QpopILrbyt
 Ju3ND96qHQkIeyJd2ae5tqLwPnfxo0U3xwcxYiseQgSirdlkSOg5uNCLv
 WVRd6jAqRwmbYB9iX1dQ/JG9TPD4daeiNaPjcMdBBq4z9Sy7E8xsZOLvR
 CRL7g8Ye8Xxr+/nbC0Q6jD3uBFJIeUu7j9oWCzIM4OhmFjXVR189+MY/x Q==;
X-CSE-ConnectionGUID: o8yFjnDoRSa5dz1VXwBOog==
X-CSE-MsgGUID: pQA3TkSXRAuz2kzc5/1HBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="72158144"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="72158144"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2026 04:24:04 -0800
X-CSE-ConnectionGUID: KqZqL9meScm1L+R2I215pA==
X-CSE-MsgGUID: 5sd57I21QXuJZlOQFqL/5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="243854485"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa001.fm.intel.com with ESMTP; 24 Feb 2026 04:24:03 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v8 22/26] net/iavf: avoid rte malloc in irq map config
Date: Tue, 24 Feb 2026 12:23:31 +0000
Message-ID: <b25deab3856600faf7d234ebceded7a43d496214.1771935744.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771935744.git.anatoly.burakov@intel.com>
 <cover.1771935744.git.anatoly.burakov@intel.com>
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

Currently, when configuring IRQ maps, we are using rte_zmalloc followed
by an immediate rte_free. This memory does not need to be stored in
hugepage memory, so replace it with stack allocation.

The original code did not check maximum IRQ map size, because the design
was built around an anti-pattern of caller having to chunk the IRQ map
calls. This has now been corrected as well.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf.h        |   3 +-
 drivers/net/intel/iavf/iavf_ethdev.c |  15 +---
 drivers/net/intel/iavf/iavf_vchnl.c  | 111 +++++++++++++++++----------
 3 files changed, 73 insertions(+), 56 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 77a2c94290..f9bb398a77 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -511,8 +511,7 @@ int iavf_add_del_vlan_v2(struct iavf_adapter *adapter, uint16_t vlanid,
 			 bool add);
 int iavf_get_vlan_offload_caps_v2(struct iavf_adapter *adapter);
 int iavf_config_irq_map(struct iavf_adapter *adapter);
-int iavf_config_irq_map_lv(struct iavf_adapter *adapter, uint16_t num,
-			uint16_t index);
+int iavf_config_irq_map_lv(struct iavf_adapter *adapter, uint16_t num);
 void iavf_add_del_all_mac_addr(struct iavf_adapter *adapter, bool add);
 int iavf_dev_link_update(struct rte_eth_dev *dev,
 			__rte_unused int wait_to_complete);
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 6e216f4c0f..26e7febecf 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -919,20 +919,7 @@ static int iavf_config_rx_queues_irqs(struct rte_eth_dev *dev,
 			goto config_irq_map_err;
 		}
 	} else {
-		uint16_t num_qv_maps = dev->data->nb_rx_queues;
-		uint16_t index = 0;
-
-		while (num_qv_maps > IAVF_IRQ_MAP_NUM_PER_BUF) {
-			if (iavf_config_irq_map_lv(adapter,
-					IAVF_IRQ_MAP_NUM_PER_BUF, index)) {
-				PMD_DRV_LOG(ERR, "config interrupt mapping for large VF failed");
-				goto config_irq_map_err;
-			}
-			num_qv_maps -= IAVF_IRQ_MAP_NUM_PER_BUF;
-			index += IAVF_IRQ_MAP_NUM_PER_BUF;
-		}
-
-		if (iavf_config_irq_map_lv(adapter, num_qv_maps, index)) {
+		if (iavf_config_irq_map_lv(adapter, dev->data->nb_rx_queues)) {
 			PMD_DRV_LOG(ERR, "config interrupt mapping for large VF failed");
 			goto config_irq_map_err;
 		}
diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index f0ab3b950b..dce4122410 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -1314,81 +1314,112 @@ int
 iavf_config_irq_map(struct iavf_adapter *adapter)
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
-	struct virtchnl_irq_map_info *map_info;
-	struct virtchnl_vector_map *vecmap;
-	struct iavf_cmd_info args;
-	int len, i, err;
+	struct {
+		struct virtchnl_irq_map_info map_info;
+		struct virtchnl_vector_map vecmap[IAVF_MAX_NUM_QUEUES_DFLT];
+	} map_req = {0};
+	struct virtchnl_irq_map_info *map_info = &map_req.map_info;
+	struct iavf_cmd_info args = {0};
+	int i, err, max_vmi = -1;
 
-	len = sizeof(struct virtchnl_irq_map_info) +
-	      sizeof(struct virtchnl_vector_map) * vf->nb_msix;
+	if (adapter->dev_data->nb_rx_queues > IAVF_MAX_NUM_QUEUES_DFLT) {
+		PMD_DRV_LOG(ERR, "number of queues (%u) exceeds the max supported (%u)",
+			    adapter->dev_data->nb_rx_queues, IAVF_MAX_NUM_QUEUES_DFLT);
+		return -EINVAL;
+	}
 
-	map_info = rte_zmalloc("map_info", len, 0);
-	if (!map_info)
-		return -ENOMEM;
-
-	map_info->num_vectors = vf->nb_msix;
 	for (i = 0; i < adapter->dev_data->nb_rx_queues; i++) {
-		vecmap =
-		    &map_info->vecmap[vf->qv_map[i].vector_id - vf->msix_base];
+		struct virtchnl_vector_map *vecmap;
+		/* always 0 for 1 MSIX, never bigger than rxq for multi MSIX */
+		uint16_t vmi = vf->qv_map[i].vector_id - vf->msix_base;
+
+		/* can't happen but avoid static analysis warnings */
+		if (vmi >= IAVF_MAX_NUM_QUEUES_DFLT) {
+			PMD_DRV_LOG(ERR, "vector id (%u) exceeds the max supported (%u)",
+					vf->qv_map[i].vector_id,
+					vf->msix_base + IAVF_MAX_NUM_QUEUES_DFLT - 1);
+			return -EINVAL;
+		}
+
+		vecmap = &map_info->vecmap[vmi];
 		vecmap->vsi_id = vf->vsi_res->vsi_id;
 		vecmap->rxitr_idx = IAVF_ITR_INDEX_DEFAULT;
 		vecmap->vector_id = vf->qv_map[i].vector_id;
 		vecmap->txq_map = 0;
 		vecmap->rxq_map |= 1 << vf->qv_map[i].queue_id;
+
+		/* MSIX vectors round robin so look for max */
+		if (vmi > max_vmi) {
+			map_info->num_vectors++;
+			max_vmi = vmi;
+		}
 	}
 
 	args.ops = VIRTCHNL_OP_CONFIG_IRQ_MAP;
 	args.in_args = (u8 *)map_info;
-	args.in_args_size = len;
+	args.in_args_size = sizeof(map_req);
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
 	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
 	if (err)
 		PMD_DRV_LOG(ERR, "fail to execute command OP_CONFIG_IRQ_MAP");
 
-	rte_free(map_info);
 	return err;
 }
 
-int
-iavf_config_irq_map_lv(struct iavf_adapter *adapter, uint16_t num,
-		uint16_t index)
+static int
+iavf_config_irq_map_lv_chunk(struct iavf_adapter *adapter,
+		uint16_t chunk_sz,
+		uint16_t chunk_start)
 {
+	struct {
+		struct virtchnl_queue_vector_maps map_info;
+		struct virtchnl_queue_vector qv_maps[IAVF_CFG_Q_NUM_PER_BUF];
+	} chunk_req = {0};
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
-	struct virtchnl_queue_vector_maps *map_info;
-	struct virtchnl_queue_vector *qv_maps;
-	struct iavf_cmd_info args;
-	int len, i, err;
-	int count = 0;
+	struct iavf_cmd_info args = {0};
+	struct virtchnl_queue_vector_maps *map_info = &chunk_req.map_info;
+	struct virtchnl_queue_vector *qv_maps = chunk_req.qv_maps;
+	uint16_t i;
 
-	len = sizeof(struct virtchnl_queue_vector_maps) +
-	      sizeof(struct virtchnl_queue_vector) * (num - 1);
-
-	map_info = rte_zmalloc("map_info", len, 0);
-	if (!map_info)
-		return -ENOMEM;
+	if (chunk_sz > IAVF_CFG_Q_NUM_PER_BUF)
+		return -EINVAL;
 
 	map_info->vport_id = vf->vsi_res->vsi_id;
-	map_info->num_qv_maps = num;
-	for (i = index; i < index + map_info->num_qv_maps; i++) {
-		qv_maps = &map_info->qv_maps[count++];
+	map_info->num_qv_maps = chunk_sz;
+	for (i = 0; i < chunk_sz; i++) {
+		qv_maps = &map_info->qv_maps[i];
 		qv_maps->itr_idx = VIRTCHNL_ITR_IDX_0;
 		qv_maps->queue_type = VIRTCHNL_QUEUE_TYPE_RX;
-		qv_maps->queue_id = vf->qv_map[i].queue_id;
-		qv_maps->vector_id = vf->qv_map[i].vector_id;
+		qv_maps->queue_id = vf->qv_map[chunk_start + i].queue_id;
+		qv_maps->vector_id = vf->qv_map[chunk_start + i].vector_id;
 	}
 
 	args.ops = VIRTCHNL_OP_MAP_QUEUE_VECTOR;
 	args.in_args = (u8 *)map_info;
-	args.in_args_size = len;
+	args.in_args_size = sizeof(chunk_req);
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
-	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
-	if (err)
-		PMD_DRV_LOG(ERR, "fail to execute command OP_MAP_QUEUE_VECTOR");
 
-	rte_free(map_info);
-	return err;
+	return iavf_execute_vf_cmd_safe(adapter, &args, 0);
+}
+
+int
+iavf_config_irq_map_lv(struct iavf_adapter *adapter, uint16_t num)
+{
+	uint16_t c;
+	int err;
+
+	for (c = 0; c < num; c += IAVF_CFG_Q_NUM_PER_BUF) {
+		uint16_t chunk_sz = RTE_MIN(num - c, IAVF_CFG_Q_NUM_PER_BUF);
+		err = iavf_config_irq_map_lv_chunk(adapter, chunk_sz, c);
+		if (err) {
+			PMD_DRV_LOG(ERR, "Failed to configure irq map chunk [%u, %u)",
+					c, c + chunk_sz);
+			return err;
+		}
+	}
+	return 0;
 }
 
 void
-- 
2.47.3

