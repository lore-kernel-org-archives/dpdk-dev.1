Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18730C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 10:56:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B50D402E0;
	Wed,  1 Jul 2026 12:56:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 5A89C40278
 for <dev@dpdk.org>; Wed,  1 Jul 2026 12:32:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782901936; x=1814437936;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=C758pFEK9OAbc6iAytg/CbbvmyynLoHZmmyatcUJUCg=;
 b=IBmegvZEuPt4pAJBVSTn/MgjWb76+X0xK40gSx+shISb7A85RugWggqu
 KAqyrQfKs/SICuNWqF+ZumnQByBi3yxdjjwYnqLx7gahUPRGphNm6FumB
 FV1+09AIA0Ul+Zp4aYUWVPN80g5/KsLkCQol8JK2U7Bgwf6kloyxCQqy/
 3hVa4IPiWe+TOFg5RhYpoje6X9cqaGYXAf/uSUL6ueJ1dVZIbNULlsLkt
 BKErEinsI1ugOwczb30kbZ1dtaUyCoefqk2Zt1l9tybq1jt1yJ36xdIeh
 GyOfZGYUKrWF8JcwWz6e/9eDrgySh4jd5tde9QrmplcIntIgYfsY/FiPv g==;
X-CSE-ConnectionGUID: SBgLHVgySLqQyU0DZi/FpA==
X-CSE-MsgGUID: +f7lNhR0RFK8XdKSazgpMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="87465651"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; d="scan'208";a="87465651"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 03:32:15 -0700
X-CSE-ConnectionGUID: sl+c7XEQRF+c+WEdHeaqMg==
X-CSE-MsgGUID: vOaM1mMxTFatqbK+k9opJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; d="scan'208";a="250809437"
Received: from unknown (HELO spr4..) ([10.138.182.169])
 by orviesa006.jf.intel.com with ESMTP; 01 Jul 2026 03:32:13 -0700
From: Dhananjay Shukla <dhananjay.shukla@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH] net/intel: add MMG device support
Date: Wed,  1 Jul 2026 15:59:48 +0530
Message-Id: <20260701102948.3333550-1-dhananjay.shukla@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 01 Jul 2026 12:55:59 +0200
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

Add support for MMG device initialization in the CPFL PMD by
replacing direct device_id comparisons against CPFL_DEV_ID_MEV and
IXD_DEV_ID_VCPF with the idpf_is_vf_device() helper. This
centralizes VF/PF detection logic in the control path open and makes
the code handle MMG and future device IDs without requiring changes
at every call site.

Additionally:
- Export idpf_is_vf_device() as an internal symbol so it can be
  called from the CPFL driver.
- Skip VIRTCHNL2_OP_GET_STATS in cpfl_dev_stats_reset() for VF
  devices which do not support this virtchannel operation.
- Skip idpf_vc_rss_hash_set() in idpf_vport_rss_config() for VF
  devices which do not support setting RSS hash via virtchannel.

Signed-off-by: Dhananjay Shukla <dhananjay.shukla@intel.com>
---
 drivers/net/intel/cpfl/cpfl_ethdev.c        | 34 ++++++++++++---------
 drivers/net/intel/cpfl/cpfl_ethdev.h        |  6 ++--
 drivers/net/intel/cpfl/cpfl_vchnl.c         | 10 +++---
 drivers/net/intel/idpf/idpf_common_device.c | 13 +++++---
 drivers/net/intel/idpf/idpf_common_device.h |  1 +
 5 files changed, 38 insertions(+), 26 deletions(-)

diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c b/drivers/net/intel/cpfl/cpfl_ethdev.c
index 7ac8797490..e8cb7b71e8 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.c
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
@@ -369,6 +369,12 @@ cpfl_dev_stats_reset(struct rte_eth_dev *dev)
 	struct virtchnl2_vport_stats *pstats = NULL;
 	int ret;
 
+	/* VF devices do not support VIRTCHNL2_OP_GET_STATS */
+	if (idpf_is_vf_device(&vport->adapter->hw)) {
+		cpfl_reset_mbuf_alloc_failed_stats(dev);
+		return 0;
+	}
+
 	ret = idpf_vc_stats_query(vport, &pstats);
 	if (ret != 0)
 		return ret;
@@ -1703,7 +1709,7 @@ cpfl_handle_vchnl_event_msg(struct cpfl_adapter_ext *adapter, uint8_t *msg, uint
 	}
 
 	/* ignore if it is ctrl vport */
-	if (adapter->base.hw.device_id == CPFL_DEV_ID_MEV &&
+	if (!idpf_is_vf_device(&adapter->base.hw) &&
 			adapter->ctrl_vport.base.vport_id == vc_event->vport_id)
 		return;
 
@@ -1946,7 +1952,7 @@ cpfl_stop_cfgqs(struct cpfl_adapter_ext *adapter)
 	int i, ret;
 
 	for (i = 0; i < adapter->num_tx_cfgq; i++) {
-		if (adapter->base.hw.device_id == IXD_DEV_ID_VCPF)
+		if (idpf_is_vf_device(&adapter->base.hw))
 			ret = idpf_vc_ena_dis_one_queue_vcpf(&adapter->base,
 					adapter->cfgq_info[0].id,
 					VIRTCHNL2_QUEUE_TYPE_CONFIG_TX, false);
@@ -1961,7 +1967,7 @@ cpfl_stop_cfgqs(struct cpfl_adapter_ext *adapter)
 	}
 
 	for (i = 0; i < adapter->num_rx_cfgq; i++) {
-		if (adapter->base.hw.device_id == IXD_DEV_ID_VCPF)
+		if (idpf_is_vf_device(&adapter->base.hw))
 			ret = idpf_vc_ena_dis_one_queue_vcpf(&adapter->base,
 					adapter->cfgq_info[1].id,
 					VIRTCHNL2_QUEUE_TYPE_CONFIG_RX, false);
@@ -1997,7 +2003,7 @@ cpfl_start_cfgqs(struct cpfl_adapter_ext *adapter)
 	}
 
 	for (i = 0; i < adapter->num_tx_cfgq; i++) {
-		if (adapter->base.hw.device_id == IXD_DEV_ID_VCPF)
+		if (idpf_is_vf_device(&adapter->base.hw))
 			ret = idpf_vc_ena_dis_one_queue_vcpf(&adapter->base,
 					adapter->cfgq_info[0].id,
 					VIRTCHNL2_QUEUE_TYPE_CONFIG_TX, true);
@@ -2011,7 +2017,7 @@ cpfl_start_cfgqs(struct cpfl_adapter_ext *adapter)
 	}
 
 	for (i = 0; i < adapter->num_rx_cfgq; i++) {
-		if (adapter->base.hw.device_id == IXD_DEV_ID_VCPF)
+		if (idpf_is_vf_device(&adapter->base.hw))
 			ret = idpf_vc_ena_dis_one_queue_vcpf(&adapter->base,
 					adapter->cfgq_info[1].id,
 					VIRTCHNL2_QUEUE_TYPE_CONFIG_RX, true);
@@ -2185,7 +2191,7 @@ cpfl_cfgq_setup(struct cpfl_adapter_ext *adapter)
 	for (i = 0; i < adapter->num_cfgq; i++) {
 		if (i % 2 == 0) {
 		/* Setup Tx config queue */
-			if (adapter->base.hw.device_id == IXD_DEV_ID_VCPF)
+			if (idpf_is_vf_device(&adapter->base.hw))
 				create_cfgq_info[i].id = cfgq_info->cfgq[i].qid;
 			else
 				create_cfgq_info[i].id = vport->base.chunks_info.tx_start_qid +
@@ -2195,7 +2201,7 @@ cpfl_cfgq_setup(struct cpfl_adapter_ext *adapter)
 			create_cfgq_info[i].len = CPFL_CFGQ_RING_SIZE;
 			create_cfgq_info[i].buf_size = CPFL_CFGQ_BUFFER_SIZE;
 			memset(&create_cfgq_info[i].reg, 0, sizeof(struct idpf_ctlq_reg));
-			if (adapter->base.hw.device_id == IXD_DEV_ID_VCPF)
+			if (idpf_is_vf_device(&adapter->base.hw))
 				create_cfgq_info[i].reg.tail = cfgq_info->cfgq[i].qtail_reg_start;
 			else
 				create_cfgq_info[i].reg.tail = tx_qtail_start +
@@ -2203,7 +2209,7 @@ cpfl_cfgq_setup(struct cpfl_adapter_ext *adapter)
 
 		} else {
 		/* Setup Rx config queue */
-			if (adapter->base.hw.device_id == IXD_DEV_ID_VCPF)
+			if (idpf_is_vf_device(&adapter->base.hw))
 				create_cfgq_info[i].id = cfgq_info->cfgq[i].qid;
 			else
 				create_cfgq_info[i].id = vport->base.chunks_info.rx_start_qid +
@@ -2213,7 +2219,7 @@ cpfl_cfgq_setup(struct cpfl_adapter_ext *adapter)
 			create_cfgq_info[i].len = CPFL_CFGQ_RING_SIZE;
 			create_cfgq_info[i].buf_size = CPFL_CFGQ_BUFFER_SIZE;
 			memset(&create_cfgq_info[i].reg, 0, sizeof(struct idpf_ctlq_reg));
-			if (adapter->base.hw.device_id == IXD_DEV_ID_VCPF)
+			if (idpf_is_vf_device(&adapter->base.hw))
 				create_cfgq_info[i].reg.tail = cfgq_info->cfgq[i].qtail_reg_start;
 			else
 				create_cfgq_info[i].reg.tail = rx_qtail_start +
@@ -2289,7 +2295,7 @@ cpfl_ctrl_path_close(struct cpfl_adapter_ext *adapter)
 {
 	cpfl_stop_cfgqs(adapter);
 	cpfl_remove_cfgqs(adapter);
-	if (adapter->base.hw.device_id == CPFL_DEV_ID_MEV)
+	if (!idpf_is_vf_device(&adapter->base.hw))
 		idpf_vc_vport_destroy(&adapter->ctrl_vport.base);
 	else
 		vcpf_del_queues(adapter);
@@ -2300,7 +2306,7 @@ cpfl_ctrl_path_open(struct cpfl_adapter_ext *adapter)
 {
 	int ret;
 
-	if (adapter->base.hw.device_id == CPFL_DEV_ID_MEV) {
+	if (!idpf_is_vf_device(&adapter->base.hw)) {
 		ret = cpfl_vc_create_ctrl_vport(adapter);
 		if (ret) {
 			PMD_INIT_LOG(ERR, "Failed to create control vport");
@@ -2329,7 +2335,7 @@ cpfl_ctrl_path_open(struct cpfl_adapter_ext *adapter)
 	ret = cpfl_cfgq_setup(adapter);
 	if (ret) {
 		PMD_INIT_LOG(ERR, "Failed to setup control queues");
-		if (adapter->base.hw.device_id == CPFL_DEV_ID_MEV)
+		if (!idpf_is_vf_device(&adapter->base.hw))
 			goto err_cfgq_setup;
 		else
 			goto err_del_cfg;
@@ -2355,7 +2361,7 @@ cpfl_ctrl_path_open(struct cpfl_adapter_ext *adapter)
 	cpfl_remove_cfgqs(adapter);
 err_cfgq_setup:
 err_init_ctrl_vport:
-	if (adapter->base.hw.device_id == CPFL_DEV_ID_MEV)
+	if (!idpf_is_vf_device(&adapter->base.hw))
 		idpf_vc_vport_destroy(&adapter->ctrl_vport.base);
 err_del_cfg:
 	vcpf_del_queues(adapter);
@@ -2835,7 +2841,7 @@ cpfl_dev_vport_init(struct rte_eth_dev *dev, void *init_params)
 		}
 	}
 	/* get the vport info */
-	if (adapter->base.hw.device_id == IXD_DEV_ID_VCPF) {
+	if (idpf_is_vf_device(&adapter->base.hw)) {
 		pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 		vi.func_type = VCPF_CPCHNL2_FTYPE_LAN_VF;
 		vi.pf_id = CPFL_HOST0_CPF_ID;
diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.h b/drivers/net/intel/cpfl/cpfl_ethdev.h
index d41aa93191..31c9d7f1a7 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.h
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.h
@@ -340,7 +340,7 @@ cpfl_get_vsi_id(struct cpfl_itf *itf)
 
 		return repr->vport_info->vport.info.vsi_id;
 	} else if (itf->type == CPFL_ITF_TYPE_VPORT) {
-		if (itf->adapter->base.hw.device_id == CPFL_DEV_ID_MEV) {
+		if (!idpf_is_vf_device(&itf->adapter->base.hw)) {
 			vport_id = ((struct cpfl_vport *)itf)->base.vport_id;
 
 			vport_identity.func_type = CPCHNL2_FTYPE_LAN_PF;
@@ -359,7 +359,7 @@ cpfl_get_vsi_id(struct cpfl_itf *itf)
 
 			vsi_id = info->vport.info.vsi_id;
 		} else {
-			if (itf->adapter->base.hw.device_id == IXD_DEV_ID_VCPF)
+			if (idpf_is_vf_device(&itf->adapter->base.hw))
 				vsi_id = (uint16_t)((struct cpfl_vport *)itf)->vport_info.vsi_id;
 		}
 	}
@@ -402,7 +402,7 @@ vcpf_get_abs_qid(uint16_t port_id,  uint32_t queue_type)
 		return CPFL_INVALID_HW_ID;
 	if (itf->type == CPFL_ITF_TYPE_VPORT) {
 		vport = (void *)itf;
-		if (itf->adapter->base.hw.device_id == IXD_DEV_ID_VCPF) {
+		if (idpf_is_vf_device(&itf->adapter->base.hw)) {
 			switch (queue_type) {
 			case VIRTCHNL2_QUEUE_TYPE_TX:
 				return vport->vport_info.abs_start_txq_id;
diff --git a/drivers/net/intel/cpfl/cpfl_vchnl.c b/drivers/net/intel/cpfl/cpfl_vchnl.c
index c9d122d2c3..593516f700 100644
--- a/drivers/net/intel/cpfl/cpfl_vchnl.c
+++ b/drivers/net/intel/cpfl/cpfl_vchnl.c
@@ -216,7 +216,7 @@ cpfl_config_ctlq_rx(struct cpfl_adapter_ext *adapter)
 	uint16_t num_qs;
 	int size, err, i;
 
-	if (adapter->base.hw.device_id != IXD_DEV_ID_VCPF) {
+	if (!idpf_is_vf_device(&adapter->base.hw)) {
 		if (vport->base.rxq_model != VIRTCHNL2_QUEUE_MODEL_SINGLE) {
 			PMD_DRV_LOG(ERR, "This rxq model isn't supported.");
 			err = -EINVAL;
@@ -235,7 +235,7 @@ cpfl_config_ctlq_rx(struct cpfl_adapter_ext *adapter)
 		return err;
 	}
 
-	if (adapter->base.hw.device_id == IXD_DEV_ID_VCPF)
+	if (idpf_is_vf_device(&adapter->base.hw))
 		vc_rxqs->vport_id = rte_cpu_to_le_32(VCPF_CFGQ_VPORT_ID);
 	else
 		vc_rxqs->vport_id = vport->base.vport_id;
@@ -249,7 +249,7 @@ cpfl_config_ctlq_rx(struct cpfl_adapter_ext *adapter)
 		rxq_info->queue_id = adapter->cfgq_info[2 * i + 1].id;
 		rxq_info->model = VIRTCHNL2_QUEUE_MODEL_SINGLE;
 		rxq_info->data_buffer_size = adapter->cfgq_info[2 * i + 1].buf_size;
-		if (adapter->base.hw.device_id != IXD_DEV_ID_VCPF)
+		if (!idpf_is_vf_device(&adapter->base.hw))
 			rxq_info->max_pkt_size = vport->base.max_pkt_len;
 		rxq_info->desc_ids = VIRTCHNL2_RXDID_2_FLEX_SQ_NIC_M;
 		rxq_info->qflags |= VIRTCHNL2_RX_DESC_SIZE_32BYTE;
@@ -281,7 +281,7 @@ cpfl_config_ctlq_tx(struct cpfl_adapter_ext *adapter)
 	uint16_t num_qs;
 	int size, err, i;
 
-	if (adapter->base.hw.device_id != IXD_DEV_ID_VCPF) {
+	if (!idpf_is_vf_device(&adapter->base.hw)) {
 		if (vport->base.txq_model != VIRTCHNL2_QUEUE_MODEL_SINGLE) {
 			PMD_DRV_LOG(ERR, "This txq model isn't supported.");
 			err = -EINVAL;
@@ -300,7 +300,7 @@ cpfl_config_ctlq_tx(struct cpfl_adapter_ext *adapter)
 		return err;
 	}
 
-	if (adapter->base.hw.device_id == IXD_DEV_ID_VCPF)
+	if (idpf_is_vf_device(&adapter->base.hw))
 		vc_txqs->vport_id = rte_cpu_to_le_32(VCPF_CFGQ_VPORT_ID);
 	else
 		vc_txqs->vport_id = vport->base.vport_id;
diff --git a/drivers/net/intel/idpf/idpf_common_device.c b/drivers/net/intel/idpf/idpf_common_device.c
index f27a911977..1586dae96c 100644
--- a/drivers/net/intel/idpf/idpf_common_device.c
+++ b/drivers/net/intel/idpf/idpf_common_device.c
@@ -451,6 +451,7 @@ idpf_adapter_init(struct idpf_adapter *adapter)
  *
  * Return: 1 for VF device, 0 for PF device.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_is_vf_device)
 bool idpf_is_vf_device(struct idpf_hw *hw)
 {
 	if (hw->device_id == IDPF_DEV_ID_SRIOV  || hw->device_id == IXD_DEV_ID_VCPF)
@@ -608,6 +609,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(idpf_vport_rss_config)
 int
 idpf_vport_rss_config(struct idpf_vport *vport)
 {
+	struct idpf_hw *hw = &vport->adapter->hw;
 	int ret;
 
 	ret = idpf_vc_rss_key_set(vport);
@@ -622,10 +624,13 @@ idpf_vport_rss_config(struct idpf_vport *vport)
 		return ret;
 	}
 
-	ret = idpf_vc_rss_hash_set(vport);
-	if (ret != 0) {
-		DRV_LOG(ERR, "Failed to configure RSS hash");
-		return ret;
+	/* VF devices do not support setting RSS hash */
+	if (!idpf_is_vf_device(hw)) {
+		ret = idpf_vc_rss_hash_set(vport);
+		if (ret != 0) {
+			DRV_LOG(ERR, "Failed to configure RSS hash");
+			return ret;
+		}
 	}
 
 	return ret;
diff --git a/drivers/net/intel/idpf/idpf_common_device.h b/drivers/net/intel/idpf/idpf_common_device.h
index aee3cd317c..f4c7f1b2d1 100644
--- a/drivers/net/intel/idpf/idpf_common_device.h
+++ b/drivers/net/intel/idpf/idpf_common_device.h
@@ -63,6 +63,7 @@
 (PCI_BASE_CLASS_NETWORK_ETHERNET << 16 | PCI_SUB_BASE_CLASS_NETWORK_ETHERNET << 8 |  \
 IDPF_NETWORK_ETHERNET_PROGIF)
 
+__rte_internal
 bool idpf_is_vf_device(struct idpf_hw *hw);
 
 enum idpf_rx_func_type {
-- 
2.34.1

