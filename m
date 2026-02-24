Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71135F3C995
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 15:17:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6395040BA0;
	Tue, 24 Feb 2026 16:15:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 4063C40612
 for <dev@dpdk.org>; Tue, 24 Feb 2026 16:15:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771946101; x=1803482101;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=oc2e0xbk0c6xWtkRmx84tgLylMNX0gP5DbA412AjLaE=;
 b=bCMA/+08fwzKc4WZ43LWrEfj7VmXz4nil+f7NOnsl5BxBcdwoHxoYMkK
 y6752Xa1qg71xANyt6i5k/trA2qnKF+V66lhfgJx02WtGZdnVB7ZJxNLE
 q610hoCf/kPbhWAnw3ID2qhfDxLy7MkU3FnQAkU35QFeaFHt2P8wharXZ
 jJf6eONNYUKv6PwaiMxUgF5CCbyamxqlci742y+oWaWzqGHCmjNxvvXIi
 epyony6EaVZQNOFrCqF3VxHQ2OyrzGasJ0Qlku5ylq1DIV3m8Zknkc6aw
 b8HGgWinKw4tCpZrfVKSSPMvWefc4iGJGunkeBati855+hGmQ6bpD6+xM A==;
X-CSE-ConnectionGUID: vjBVWviSTteXlx7krbN4ZQ==
X-CSE-MsgGUID: lWICqMLiTBS/3nuC+eyqlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="84056276"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="84056276"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2026 07:15:01 -0800
X-CSE-ConnectionGUID: X9ggq416Q9GHAbrIcucmfQ==
X-CSE-MsgGUID: b8fv/p4bSjGoRblGDPVm8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="220526232"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa005.fm.intel.com with ESMTP; 24 Feb 2026 07:15:00 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v9 22/26] net/iavf: avoid rte malloc in irq map config
Date: Tue, 24 Feb 2026 15:14:27 +0000
Message-ID: <5e6a55afa2b45e3ee5ec17af7a6c548c96e9698b.1771945933.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771945933.git.anatoly.burakov@intel.com>
 <cover.1771945933.git.anatoly.burakov@intel.com>
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
 drivers/net/intel/iavf/iavf_vchnl.c  | 121 ++++++++++++++++++---------
 3 files changed, 83 insertions(+), 56 deletions(-)

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
index eb9e4d0c2d..08dd6f2d7f 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -1319,81 +1319,122 @@ int
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
+	size_t buf_len;
 
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
 
+	/* for some reason PF side checks for buffer being too big, so adjust it down */
+	buf_len = sizeof(struct virtchnl_irq_map_info) +
+		  sizeof(struct virtchnl_vector_map) * map_info->num_vectors;
+
 	args.ops = VIRTCHNL_OP_CONFIG_IRQ_MAP;
 	args.in_args = (u8 *)map_info;
-	args.in_args_size = len;
+	args.in_args_size = buf_len;
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
+	size_t buf_len;
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
 
+	/* for some reason PF side checks for buffer being too big, so adjust it down */
+	buf_len = sizeof(struct virtchnl_queue_vector_maps) +
+		  sizeof(struct virtchnl_queue_vector) * chunk_sz;
+
 	args.ops = VIRTCHNL_OP_MAP_QUEUE_VECTOR;
 	args.in_args = (u8 *)map_info;
-	args.in_args_size = len;
+	args.in_args_size = buf_len;
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

