Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C80CCA470
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 13:56:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4CC140A87;
	Tue, 30 Sep 2025 15:56:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 2EC2240A75
 for <dev@dpdk.org>; Tue, 30 Sep 2025 15:56:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759240567; x=1790776567;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+BfBQ2xW90zeGSd65DYvS5WnVQ+Frpqezhr+4Mltze0=;
 b=LWF1HY0pdPb0AAM2l3vhhpY3mq0TOfPE5Hw6UxY460PKX5gAWP08UljC
 y2ig6W54MYm/GW3Hc3Qwq3GKjfJzeBxjFJs8gYVP47avBYD9Wo4+kkAs/
 IpEuhSbvUziMaRKHVGpkh7LU558MJfDWSZmOkMNMK5Z7B100HHQzXNCZO
 AwuBABZqmrEGmyGyVLelV3wuIN85VJmoTaV3mW8mi6EzgtcqaPR4LL+Oz
 TwBYjqWvgksoVV3NePawUeB/zNPFXOnp3ujIb4mC50sOuY6UwJlZC0Ltt
 jBGhySGvc+kcx0/qxXYT/KXcJlZrr6AbvCDVQ0JyYBJbQCJ0NP9eS0kIB w==;
X-CSE-ConnectionGUID: B9YjimO8QqCTHYDdJ6vI6w==
X-CSE-MsgGUID: MDIa5mV6TrOK/Ga3q7P7aQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="49058323"
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; d="scan'208";a="49058323"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2025 06:56:06 -0700
X-CSE-ConnectionGUID: KAPDhye0SnC6tXmurkL1Ew==
X-CSE-MsgGUID: 4gPLGCu3ThSytEbAfODHrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; d="scan'208";a="178933692"
Received: from gk3153-pr3-41011.igk.intel.com (HELO
 GK3153-PR3-41011-c0b.igk.intel.com) ([10.123.200.84])
 by fmviesa009.fm.intel.com with ESMTP; 30 Sep 2025 06:56:05 -0700
From: "Shetty, Praveen" <praveen.shetty@intel.com>
To: bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: dev@dpdk.org, Praveen Shetty <praveen.shetty@intel.com>,
 Dhananjay Shukla <dhananjay.shukla@intel.com>,
 Atul Patel <Atul.Patel@intel.com>
Subject: [PATCH v4 4/4] net/cpfl: add cpchnl get vport info support
Date: Tue, 30 Sep 2025 15:55:56 +0200
Message-Id: <20250930135556.2861075-5-praveen.shetty@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250930135556.2861075-1-praveen.shetty@intel.com>
References: <20250922094819.1350709-2-praveen.shetty@intel.com>
 <20250930135556.2861075-1-praveen.shetty@intel.com>
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
Signed-off-by: Dhananjay Shukla <dhananjay.shukla@intel.com>
Signed-off-by: Atul Patel <Atul.Patel@intel.com>
---
 drivers/net/intel/cpfl/cpfl_cpchnl.h |  8 ++++
 drivers/net/intel/cpfl/cpfl_ethdev.c | 63 +++++++++++++++++++++++++
 drivers/net/intel/cpfl/cpfl_ethdev.h | 70 +++++++++++++++++++++-------
 3 files changed, 125 insertions(+), 16 deletions(-)

diff --git a/drivers/net/intel/cpfl/cpfl_cpchnl.h b/drivers/net/intel/cpfl/cpfl_cpchnl.h
index 0c9dfcdbf1..c56d3e6cea 100644
--- a/drivers/net/intel/cpfl/cpfl_cpchnl.h
+++ b/drivers/net/intel/cpfl/cpfl_cpchnl.h
@@ -140,6 +140,14 @@ enum cpchnl2_func_type {
 	CPCHNL2_FTYPE_LAN_MAX
 };
 
+/**
+ * @brief function types
+ */
+enum vcpf_cpchnl2_func_type {
+	VCPF_CPCHNL2_FTYPE_LAN_PF = 0,
+	VCPF_CPCHNL2_FTYPE_LAN_VF = 1,
+};
+
 /**
  * @brief containing vport id & type
  */
diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c b/drivers/net/intel/cpfl/cpfl_ethdev.c
index 22f3859dca..110678e312 100644
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
@@ -2722,7 +2759,11 @@ cpfl_dev_vport_init(struct rte_eth_dev *dev, void *init_params)
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
@@ -2792,6 +2833,28 @@ cpfl_dev_vport_init(struct rte_eth_dev *dev, void *init_params)
 			cpfl_p2p_queue_grps_del(vport);
 		}
 	}
+	/* get the vport info */
+	if (adapter->base.hw.device_id == IXD_DEV_ID_VCPF) {
+		pci_dev = RTE_DEV_TO_PCI(dev->device);
+		vi.func_type = VCPF_CPCHNL2_FTYPE_LAN_VF;
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
index f550bca754..be73e05a0e 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.h
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.h
@@ -164,10 +164,20 @@ struct cpfl_itf {
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
 
@@ -319,6 +329,7 @@ cpfl_get_vsi_id(struct cpfl_itf *itf)
 	uint32_t vport_id;
 	int ret;
 	struct cpfl_vport_id vport_identity;
+	u16 vsi_id = 0;
 
 	if (!itf)
 		return CPFL_INVALID_HW_ID;
@@ -328,24 +339,30 @@ cpfl_get_vsi_id(struct cpfl_itf *itf)
 
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
@@ -374,4 +391,25 @@ cpfl_get_itf_by_port_id(uint16_t port_id)
 
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

