Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B324CAC5A7
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Sep 2025 06:19:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40FFA40615;
	Mon, 22 Sep 2025 08:19:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 0862040659
 for <dev@dpdk.org>; Mon, 22 Sep 2025 08:19:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758521962; x=1790057962;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BCCLMktxRKqcNNFzCY1jisk54rne1iRSHU92jSikBRs=;
 b=LlSkHRZtnfXygwrTBzVAzpiQzUROmPZolFDd0lCJxnm+A5vzX387uQo4
 JmX+rZSWuBagKzaBIa3hAIkpDP2mtGxC2kISXzIWSlQGnQQdO53Tzb0Ng
 JA71xjP7uTOhKVDkKU33BnVp3CXWOe6Y/JKeYewmQ+PxfkD/vaShwQu8v
 3ycW8zxXjJzX193Bcckgio4ZSz1TlLZfCByekjqopJ7fObnF4FS5s5TCM
 02VZJkc9ua41uoQTedaWwEBFOKmZTAmGndbhrj8HJHkfTqVChdmvDzvQB
 qmEcXC5ZRv4kMH3UwQcXygUSdTqgKPwCf6ReU/6ks8u8ZwvTcj8Be9BxM w==;
X-CSE-ConnectionGUID: NsGQglbZS3GFZGjMtzQMhg==
X-CSE-MsgGUID: 78yGAmHVSn+G+o/H+Ft9KA==
X-IronPort-AV: E=McAfee;i="6800,10657,11560"; a="60939100"
X-IronPort-AV: E=Sophos;i="6.18,284,1751266800"; d="scan'208";a="60939100"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2025 23:19:22 -0700
X-CSE-ConnectionGUID: zFadjUMkS62iFhSzlA52Gg==
X-CSE-MsgGUID: lxtkOIwsRxmZDQRHAXXO5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,284,1751266800"; d="scan'208";a="207136446"
Received: from gk6031-gr4-41638.igk.intel.com (HELO
 GK6031-GR4-41638-c04.igk.intel.com) ([10.91.173.62])
 by orviesa002.jf.intel.com with ESMTP; 21 Sep 2025 23:19:19 -0700
From: "Shetty, Praveen" <praveen.shetty@intel.com>
To: bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: dev@dpdk.org, Praveen Shetty <praveen.shetty@intel.com>,
	Shukla@dpdk.org, Dhananjay <dhananjay.shukla@intel.com>,
	atulpatel261194 <Atul.Patel@intel.com>
Subject: [PATCH 4/4] net/cpfl: add cpchnl get vport info support
Date: Mon, 22 Sep 2025 11:48:19 +0200
Message-Id: <20250922094819.1350709-5-praveen.shetty@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250922094819.1350709-1-praveen.shetty@intel.com>
References: <20250922094819.1350709-1-praveen.shetty@intel.com>
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

From: Praveen Shetty <praveen.shetty@intel.com>

vCPF will only receive the relative queue id from the FW.
CPCHNL2_OP_GET_VPORT_INFO cpchnl message is used
to get the absolute rx/tx queue id and vsi of its own vport.
This patch will add the support to call CPCHNL2_OP_GET_VPORT_INFO
cpchnl message from the vCPF PMD.

Signed-off-by: Praveen Shetty <praveen.shetty@intel.com>
Signed-off-by: Shukla, Dhananjay <dhananjay.shukla@intel.com>
Signed-off-by: atulpatel261194 <Atul.Patel@intel.com>
---
 drivers/net/intel/cpfl/cpfl_cpchnl.h |  7 +--
 drivers/net/intel/cpfl/cpfl_ethdev.c | 63 +++++++++++++++++++++++++
 drivers/net/intel/cpfl/cpfl_ethdev.h | 70 +++++++++++++++++++++-------
 3 files changed, 119 insertions(+), 21 deletions(-)

diff --git a/drivers/net/intel/cpfl/cpfl_cpchnl.h b/drivers/net/intel/cpfl/cpfl_cpchnl.h
index 0c9dfcdbf1..7b01468a83 100644
--- a/drivers/net/intel/cpfl/cpfl_cpchnl.h
+++ b/drivers/net/intel/cpfl/cpfl_cpchnl.h
@@ -133,11 +133,8 @@ CPCHNL2_CHECK_STRUCT_LEN(3792, cpchnl2_queue_groups);
  * @brief function types
  */
 enum cpchnl2_func_type {
-	CPCHNL2_FTYPE_LAN_VF = 0x0,
-	CPCHNL2_FTYPE_LAN_RSV1 = 0x1,
-	CPCHNL2_FTYPE_LAN_PF = 0x2,
-	CPCHNL2_FTYPE_LAN_RSV2 = 0x3,
-	CPCHNL2_FTYPE_LAN_MAX
+	CPCHNL2_FTYPE_LAN_PF = 0,
+	CPCHNL2_FTYPE_LAN_VF = 1,
 };
 
 /**
diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c b/drivers/net/intel/cpfl/cpfl_ethdev.c
index 4dfdf3133f..a1490f6b2c 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.c
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
@@ -1902,6 +1902,43 @@ cpfl_dev_alarm_handler(void *param)
 	rte_eal_alarm_set(CPFL_ALARM_INTERVAL, cpfl_dev_alarm_handler, adapter);
 }
 
+static
+int vcpf_save_vport_info_response(struct cpfl_vport *cpfl_vport,
+		struct cpchnl2_get_vport_info_response *response)
+{
+	struct cpchnl2_vport_info *info;
+	struct vcpf_vport_info *vport_info;
+	struct cpchnl2_queue_group_info *qgp;
+	struct cpchnl2_queue_chunk *q_chnk;
+	u16 num_queue_groups;
+	u16 num_chunks;
+	u32 q_type;
+
+	info = &response->info;
+	vport_info = &cpfl_vport->vport_info;
+	vport_info->vport_index = info->vport_index;
+	vport_info->vsi_id = info->vsi_id;
+
+	num_queue_groups = response->queue_groups.num_queue_groups;
+	for (u16 i = 0; i < num_queue_groups; i++) {
+		qgp = &response->queue_groups.groups[i];
+		num_chunks = qgp->chunks.num_chunks;
+		/* rx q and tx q are stored in first 2 chunks */
+		for (u16 j = 0; j < (num_chunks - 2); j++) {
+			q_chnk = &qgp->chunks.chunks[j];
+			q_type = q_chnk->type;
+			if (q_type == VIRTCHNL2_QUEUE_TYPE_TX) {
+				vport_info->abs_start_txq_id = q_chnk->start_queue_id;
+				vport_info->num_tx_q = q_chnk->num_queues;
+			} else if (q_type == VIRTCHNL2_QUEUE_TYPE_RX) {
+				vport_info->abs_start_rxq_id = q_chnk->start_queue_id;
+				vport_info->num_rx_q = q_chnk->num_queues;
+			}
+		}
+	}
+	return 0;
+}
+
 static int
 cpfl_stop_cfgqs(struct cpfl_adapter_ext *adapter)
 {
@@ -2720,7 +2757,11 @@ cpfl_dev_vport_init(struct rte_eth_dev *dev, void *init_params)
 	/* for sending create vport virtchnl msg prepare */
 	struct virtchnl2_create_vport create_vport_info;
 	struct virtchnl2_add_queue_groups p2p_queue_grps_info;
+	struct cpchnl2_get_vport_info_response response;
 	uint8_t p2p_q_vc_out_info[IDPF_DFLT_MBX_BUF_SIZE] = {0};
+	struct cpfl_vport_id vi;
+	struct cpchnl2_vport_id v_id;
+	struct rte_pci_device *pci_dev = RTE_DEV_TO_PCI(dev->device);
 	int ret = 0;
 
 	dev->dev_ops = &cpfl_eth_dev_ops;
@@ -2790,6 +2831,28 @@ cpfl_dev_vport_init(struct rte_eth_dev *dev, void *init_params)
 			cpfl_p2p_queue_grps_del(vport);
 		}
 	}
+	/* get the vport info */
+	if (adapter->base.hw.device_id == IXD_DEV_ID_VCPF) {
+		pci_dev = RTE_DEV_TO_PCI(dev->device);
+		vi.func_type = CPCHNL2_FTYPE_LAN_VF;
+		vi.pf_id = CPFL_HOST0_CPF_ID;
+		vi.vf_id = pci_dev->addr.function;
+
+		v_id.vport_id = cpfl_vport->base.vport_info.info.vport_id;
+		v_id.vport_type = cpfl_vport->base.vport_info.info.vport_type;
+
+		ret = cpfl_cc_vport_info_get(adapter, &v_id, &vi, &response);
+		if (ret != 0) {
+			PMD_INIT_LOG(ERR, "Failed to send vport info cpchnl message.");
+			return -1;
+		}
+
+		ret = vcpf_save_vport_info_response(cpfl_vport, &response);
+		if (ret != 0) {
+			PMD_INIT_LOG(ERR, "Failed to save cpchnl response.");
+			return -1;
+		}
+	}
 
 	return 0;
 
diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.h b/drivers/net/intel/cpfl/cpfl_ethdev.h
index 81f223eef5..7f5944e2bc 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.h
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.h
@@ -165,10 +165,20 @@ struct cpfl_itf {
 	void *data;
 };
 
+struct vcpf_vport_info {
+	u16 vport_index;
+	u16 vsi_id;
+	u32 abs_start_txq_id;
+	u32 num_tx_q;
+	u32 abs_start_rxq_id;
+	u32 num_rx_q;
+};
+
 struct cpfl_vport {
 	struct cpfl_itf itf;
 	struct idpf_vport base;
 	struct p2p_queue_chunks_info *p2p_q_chunks_info;
+	struct vcpf_vport_info vport_info;
 
 	struct rte_mempool *p2p_mp;
 
@@ -320,6 +330,7 @@ cpfl_get_vsi_id(struct cpfl_itf *itf)
 	uint32_t vport_id;
 	int ret;
 	struct cpfl_vport_id vport_identity;
+	u16 vsi_id;
 
 	if (!itf)
 		return CPFL_INVALID_HW_ID;
@@ -329,24 +340,30 @@ cpfl_get_vsi_id(struct cpfl_itf *itf)
 
 		return repr->vport_info->vport.info.vsi_id;
 	} else if (itf->type == CPFL_ITF_TYPE_VPORT) {
-		vport_id = ((struct cpfl_vport *)itf)->base.vport_id;
-
-		vport_identity.func_type = CPCHNL2_FTYPE_LAN_PF;
-		/* host: CPFL_HOST0_CPF_ID, acc: CPFL_ACC_CPF_ID */
-		vport_identity.pf_id = (itf->adapter->host_id == CPFL_HOST_ID_ACC) ?
-								CPFL_ACC_CPF_ID : CPFL_HOST0_CPF_ID;
-		vport_identity.vf_id = 0;
-		vport_identity.vport_id = vport_id;
-		ret = rte_hash_lookup_data(itf->adapter->vport_map_hash,
-					   &vport_identity,
-					   (void **)&info);
-		if (ret < 0) {
-			PMD_DRV_LOG(ERR, "vport id not exist");
-			goto err;
+		if (itf->adapter->base.hw.device_id == IDPF_DEV_ID_CPF) {
+			vport_id = ((struct cpfl_vport *)itf)->base.vport_id;
+
+			vport_identity.func_type = CPCHNL2_FTYPE_LAN_PF;
+			/* host: CPFL_HOST0_CPF_ID, acc: CPFL_ACC_CPF_ID */
+			vport_identity.pf_id = (itf->adapter->host_id == CPFL_HOST_ID_ACC) ?
+							CPFL_ACC_CPF_ID : CPFL_HOST0_CPF_ID;
+			vport_identity.vf_id = 0;
+			vport_identity.vport_id = vport_id;
+			ret = rte_hash_lookup_data(itf->adapter->vport_map_hash,
+						   &vport_identity,
+						   (void **)&info);
+			if (ret < 0) {
+				PMD_DRV_LOG(ERR, "vport id not exist");
+				goto err;
+			}
+
+			vsi_id = info->vport.info.vsi_id;
+		} else {
+			if (itf->adapter->base.hw.device_id == IXD_DEV_ID_VCPF)
+				vsi_id = (uint16_t)((struct cpfl_vport *)itf)->vport_info.vsi_id;
 		}
-
-		return info->vport.info.vsi_id;
 	}
+	return vsi_id;
 
 err:
 	return CPFL_INVALID_HW_ID;
@@ -375,4 +392,25 @@ cpfl_get_itf_by_port_id(uint16_t port_id)
 
 	return CPFL_DEV_TO_ITF(dev);
 }
+
+static inline uint32_t
+vcpf_get_abs_qid(uint16_t port_id,  uint32_t queue_type)
+{
+	struct cpfl_itf *itf = cpfl_get_itf_by_port_id(port_id);
+	struct cpfl_vport *vport;
+	if (!itf)
+		return CPFL_INVALID_HW_ID;
+	if (itf->type == CPFL_ITF_TYPE_VPORT) {
+		vport = (void *)itf;
+		if (itf->adapter->base.hw.device_id == IXD_DEV_ID_VCPF) {
+			switch (queue_type) {
+			case VIRTCHNL2_QUEUE_TYPE_TX:
+				return vport->vport_info.abs_start_txq_id;
+			case VIRTCHNL2_QUEUE_TYPE_RX:
+				return vport->vport_info.abs_start_rxq_id;
+			}
+		}
+	}
+	return 0;
+}
 #endif /* _CPFL_ETHDEV_H_ */
-- 
2.37.3

