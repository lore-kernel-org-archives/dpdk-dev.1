Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AB5CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Sep 2025 09:33:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 445E64067C;
	Tue, 23 Sep 2025 11:33:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 083FE4021F
 for <dev@dpdk.org>; Tue, 23 Sep 2025 11:33:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758619997; x=1790155997;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nypRWxwJi78DlTpcyktgD8Oic8cwBYMUKuKCpT7iuRA=;
 b=X/gMxemTunUCvTEEGwGNywSFN96K5j+OArr+pTpEc9kOEw9oQji3vS1T
 uRIGGXsMInFCZNfF0bSEQNqync6OiUOMTVqly6JNmfs0ZtrP1ELduhGj7
 s5DFkYaNMQA/YhOpKDxavkttbiNVEmVVVXfe7A7+lCrV8kYuNlnViwsi5
 wnM9/4shWqff+6cXNmuUTzrllNaTugIygabI0bW/YDM4ELbJtlpoP1oTC
 9+MGvNwTH5bvY9YmgzjgKnTUE1dzM5ETuspS0jNRKHZr1Pp+ucXL4vLb5
 y0NePCQ8mT+XOoRNckl9M70BduYDnUFjXctfw0GDK8xR5IJ5RHPr25lja A==;
X-CSE-ConnectionGUID: vAovpCRKS0Sm4F+F/sE8wA==
X-CSE-MsgGUID: cMSGNmyLRmCMGyatiZ6y6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="86330416"
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; d="scan'208";a="86330416"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2025 02:33:16 -0700
X-CSE-ConnectionGUID: BNdThH/TT1KrXh1esh7gOw==
X-CSE-MsgGUID: 04iO6yJEQLmIjnO9tnGN+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; d="scan'208";a="176307899"
Received: from gk6031-gr4-41638.igk.intel.com (HELO
 GK6031-GR4-41638-c04.igk.intel.com) ([10.91.173.62])
 by fmviesa007.fm.intel.com with ESMTP; 23 Sep 2025 02:33:08 -0700
From: "Shetty, Praveen" <praveen.shetty@intel.com>
To: bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: dev@dpdk.org, Praveen Shetty <praveen.shetty@intel.com>,
 Dhananjay Shukla <dhananjay.shukla@intel.com>,
 Atul Patel <atul.patel@intel.com>
Subject: [PATCH v3 3/4] net/intel: add config queue support to vCPF
Date: Tue, 23 Sep 2025 14:54:54 +0200
Message-Id: <20250923125455.1484992-4-praveen.shetty@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250923125455.1484992-1-praveen.shetty@intel.com>
References: <20250922141058.1390212-2-praveen.shetty@intel.com>
 <20250923125455.1484992-1-praveen.shetty@intel.com>
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

A "configuration queue" is a software term to denote
a hardware mailbox queue dedicated to NSS programming.
While the hardware does not have a construct of a
"configuration queue", software does to state clearly
the distinction between a queue software dedicates to
regular mailbox processing (e.g. CPChnl or Virtchnl)
and a queue software dedicates to NSS programming
(e.g. SEM/LEM rule programming).

Signed-off-by: Praveen Shetty <praveen.shetty@intel.com>
Tested-by: Dhananjay Shukla <dhananjay.shukla@intel.com>
Tested-by: Atul Patel  <atul.patel@intel.com>
---
 drivers/net/intel/cpfl/cpfl_ethdev.c          | 274 +++++++++++++++---
 drivers/net/intel/cpfl/cpfl_ethdev.h          |  38 ++-
 drivers/net/intel/cpfl/cpfl_vchnl.c           | 143 ++++++++-
 drivers/net/intel/idpf/base/idpf_osdep.h      |   3 +
 drivers/net/intel/idpf/base/virtchnl2.h       |   3 +-
 drivers/net/intel/idpf/idpf_common_device.h   |   2 +
 drivers/net/intel/idpf/idpf_common_virtchnl.c |  38 +++
 drivers/net/intel/idpf/idpf_common_virtchnl.h |   3 +
 8 files changed, 449 insertions(+), 55 deletions(-)

diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c b/drivers/net/intel/cpfl/cpfl_ethdev.c
index d6227c99b5..c411a2a024 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.c
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
@@ -29,6 +29,9 @@
 #define CPFL_FLOW_PARSER	"flow_parser"
 #endif
 
+#define VCPF_FID	0
+#define CPFL_FID	6
+
 rte_spinlock_t cpfl_adapter_lock;
 /* A list for all adapters, one adapter matches one PCI device */
 struct cpfl_adapter_list cpfl_adapter_list;
@@ -1699,7 +1702,8 @@ cpfl_handle_vchnl_event_msg(struct cpfl_adapter_ext *adapter, uint8_t *msg, uint
 	}
 
 	/* ignore if it is ctrl vport */
-	if (adapter->ctrl_vport.base.vport_id == vc_event->vport_id)
+	if (adapter->base.hw.device_id == IDPF_DEV_ID_CPF &&
+			adapter->ctrl_vport.base.vport_id == vc_event->vport_id)
 		return;
 
 	vport = cpfl_find_vport(adapter, vc_event->vport_id);
@@ -1903,18 +1907,30 @@ cpfl_stop_cfgqs(struct cpfl_adapter_ext *adapter)
 {
 	int i, ret;
 
-	for (i = 0; i < CPFL_TX_CFGQ_NUM; i++) {
-		ret = idpf_vc_queue_switch(&adapter->ctrl_vport.base, i, false, false,
+	for (i = 0; i < adapter->num_tx_cfgq; i++) {
+		if (adapter->base.hw.device_id == IXD_DEV_ID_VCPF)
+			ret = idpf_vc_ena_dis_one_queue_vcpf(&adapter->base,
+					adapter->cfgq_info[0].id,
+					VIRTCHNL2_QUEUE_TYPE_CONFIG_TX, false);
+		else
+			ret = idpf_vc_queue_switch(&adapter->ctrl_vport.base, i, false, false,
 								VIRTCHNL2_QUEUE_TYPE_CONFIG_TX);
+
 		if (ret) {
 			PMD_DRV_LOG(ERR, "Fail to disable Tx config queue.");
 			return ret;
 		}
 	}
 
-	for (i = 0; i < CPFL_RX_CFGQ_NUM; i++) {
-		ret = idpf_vc_queue_switch(&adapter->ctrl_vport.base, i, true, false,
-								VIRTCHNL2_QUEUE_TYPE_CONFIG_RX);
+	for (i = 0; i < adapter->num_rx_cfgq; i++) {
+		if (adapter->base.hw.device_id == IXD_DEV_ID_VCPF)
+			ret = idpf_vc_ena_dis_one_queue_vcpf(&adapter->base,
+					adapter->cfgq_info[1].id,
+					VIRTCHNL2_QUEUE_TYPE_CONFIG_RX, false);
+		else
+			ret = idpf_vc_queue_switch(&adapter->ctrl_vport.base, i, true, false,
+							VIRTCHNL2_QUEUE_TYPE_CONFIG_RX);
+
 		if (ret) {
 			PMD_DRV_LOG(ERR, "Fail to disable Rx config queue.");
 			return ret;
@@ -1922,6 +1938,7 @@ cpfl_stop_cfgqs(struct cpfl_adapter_ext *adapter)
 	}
 
 	return 0;
+
 }
 
 static int
@@ -1941,8 +1958,13 @@ cpfl_start_cfgqs(struct cpfl_adapter_ext *adapter)
 		return ret;
 	}
 
-	for (i = 0; i < CPFL_TX_CFGQ_NUM; i++) {
-		ret = idpf_vc_queue_switch(&adapter->ctrl_vport.base, i, false, true,
+	for (i = 0; i < adapter->num_tx_cfgq; i++) {
+		if (adapter->base.hw.device_id == IXD_DEV_ID_VCPF)
+			ret = idpf_vc_ena_dis_one_queue_vcpf(&adapter->base,
+					adapter->cfgq_info[0].id,
+					VIRTCHNL2_QUEUE_TYPE_CONFIG_TX, true);
+		else
+			ret = idpf_vc_queue_switch(&adapter->ctrl_vport.base, i, false, true,
 								VIRTCHNL2_QUEUE_TYPE_CONFIG_TX);
 		if (ret) {
 			PMD_DRV_LOG(ERR, "Fail to enable Tx config queue.");
@@ -1950,8 +1972,13 @@ cpfl_start_cfgqs(struct cpfl_adapter_ext *adapter)
 		}
 	}
 
-	for (i = 0; i < CPFL_RX_CFGQ_NUM; i++) {
-		ret = idpf_vc_queue_switch(&adapter->ctrl_vport.base, i, true, true,
+	for (i = 0; i < adapter->num_rx_cfgq; i++) {
+		if (adapter->base.hw.device_id == IXD_DEV_ID_VCPF)
+			ret = idpf_vc_ena_dis_one_queue_vcpf(&adapter->base,
+					adapter->cfgq_info[1].id,
+					VIRTCHNL2_QUEUE_TYPE_CONFIG_RX, true);
+		else
+			ret = idpf_vc_queue_switch(&adapter->ctrl_vport.base, i, true, true,
 								VIRTCHNL2_QUEUE_TYPE_CONFIG_RX);
 		if (ret) {
 			PMD_DRV_LOG(ERR, "Fail to enable Rx config queue.");
@@ -1971,14 +1998,20 @@ cpfl_remove_cfgqs(struct cpfl_adapter_ext *adapter)
 
 	create_cfgq_info = adapter->cfgq_info;
 
-	for (i = 0; i < CPFL_CFGQ_NUM; i++) {
-		if (adapter->ctlqp[i])
+	for (i = 0; i < adapter->num_cfgq; i++) {
+		if (adapter->ctlqp[i]) {
 			cpfl_vport_ctlq_remove(hw, adapter->ctlqp[i]);
+			adapter->ctlqp[i] = NULL;
+		}
 		if (create_cfgq_info[i].ring_mem.va)
 			idpf_free_dma_mem(&adapter->base.hw, &create_cfgq_info[i].ring_mem);
 		if (create_cfgq_info[i].buf_mem.va)
 			idpf_free_dma_mem(&adapter->base.hw, &create_cfgq_info[i].buf_mem);
 	}
+	if (adapter->ctlqp) {
+		rte_free(adapter->ctlqp);
+		adapter->ctlqp = NULL;
+	}
 }
 
 static int
@@ -1988,7 +2021,16 @@ cpfl_add_cfgqs(struct cpfl_adapter_ext *adapter)
 	int ret = 0;
 	int i = 0;
 
-	for (i = 0; i < CPFL_CFGQ_NUM; i++) {
+	adapter->ctlqp = rte_zmalloc("ctlqp", adapter->num_cfgq *
+				sizeof(struct idpf_ctlq_info *),
+				RTE_CACHE_LINE_SIZE);
+
+	if (!adapter->ctlqp) {
+		PMD_DRV_LOG(ERR, "Failed to allocate memory for control queues");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < adapter->num_cfgq; i++) {
 		cfg_cq = NULL;
 		ret = cpfl_vport_ctlq_add((struct idpf_hw *)(&adapter->base.hw),
 					  &adapter->cfgq_info[i],
@@ -2007,6 +2049,62 @@ cpfl_add_cfgqs(struct cpfl_adapter_ext *adapter)
 	return ret;
 }
 
+static
+int vcpf_save_chunk_in_cfgq(struct cpfl_adapter_ext *adapter)
+{
+	struct virtchnl2_add_queues *add_q =
+		(struct virtchnl2_add_queues *)adapter->addq_recv_info;
+	struct vcpf_cfg_queue *cfgq;
+	struct virtchnl2_queue_reg_chunk *q_chnk;
+	u16 rx, tx, num_chunks, num_q, struct_size;
+	u32 q_id, q_type;
+
+	rx = 0; tx = 0;
+
+	cfgq = rte_zmalloc("cfgq", adapter->num_cfgq *
+				sizeof(struct vcpf_cfg_queue),
+				RTE_CACHE_LINE_SIZE);
+
+	if (!cfgq) {
+		PMD_DRV_LOG(ERR, "Failed to allocate memory for cfgq");
+		return -ENOMEM;
+	}
+
+	struct_size = idpf_struct_size(add_q, chunks.chunks, (add_q->chunks.num_chunks - 1));
+	adapter->cfgq_in.cfgq_add = rte_zmalloc("config_queues", struct_size, 0);
+	rte_memcpy(adapter->cfgq_in.cfgq_add, add_q, struct_size);
+
+	num_chunks = add_q->chunks.num_chunks;
+	for (u16 i = 0; i < num_chunks; i++) {
+		num_q = add_q->chunks.chunks[i].num_queues;
+		q_chnk = &add_q->chunks.chunks[i];
+		for (u16 j = 0; j < num_q; j++) {
+			if (rx > adapter->num_cfgq || tx > adapter->num_cfgq)
+				break;
+			q_id = q_chnk->start_queue_id + j;
+			q_type = q_chnk->type;
+			if (q_type == VIRTCHNL2_QUEUE_TYPE_MBX_TX) {
+				cfgq[0].qid = q_id;
+				cfgq[0].qtail_reg_start = q_chnk->qtail_reg_start;
+				cfgq[0].qtail_reg_spacing = q_chnk->qtail_reg_spacing;
+				q_chnk->type = VIRTCHNL2_QUEUE_TYPE_CONFIG_TX;
+				tx++;
+			} else if (q_type == VIRTCHNL2_QUEUE_TYPE_MBX_RX) {
+				cfgq[1].qid = q_id;
+				cfgq[1].qtail_reg_start = q_chnk->qtail_reg_start;
+				cfgq[1].qtail_reg_spacing = q_chnk->qtail_reg_spacing;
+				q_chnk->type = VIRTCHNL2_QUEUE_TYPE_CONFIG_RX;
+				rx++;
+			}
+		}
+	}
+
+	adapter->cfgq_in.cfgq = cfgq;
+	adapter->cfgq_in.num_cfgq = adapter->num_cfgq;
+
+	return 0;
+}
+
 #define CPFL_CFGQ_RING_LEN		512
 #define CPFL_CFGQ_DESCRIPTOR_SIZE	32
 #define CPFL_CFGQ_BUFFER_SIZE		256
@@ -2017,32 +2115,71 @@ cpfl_cfgq_setup(struct cpfl_adapter_ext *adapter)
 {
 	struct cpfl_ctlq_create_info *create_cfgq_info;
 	struct cpfl_vport *vport;
+	struct vcpf_cfgq_info *cfgq_info = &adapter->cfgq_in;
 	int i, err;
 	uint32_t ring_size = CPFL_CFGQ_RING_SIZE * sizeof(struct idpf_ctlq_desc);
 	uint32_t buf_size = CPFL_CFGQ_RING_SIZE * CPFL_CFGQ_BUFFER_SIZE;
+	uint64_t tx_qtail_start;
+	uint64_t rx_qtail_start;
+	uint32_t tx_qtail_spacing;
+	uint32_t rx_qtail_spacing;
 
 	vport = &adapter->ctrl_vport;
+
+	tx_qtail_start = vport->base.chunks_info.tx_qtail_start;
+	tx_qtail_spacing = vport->base.chunks_info.tx_qtail_spacing;
+	rx_qtail_start = vport->base.chunks_info.rx_qtail_start;
+	rx_qtail_spacing = vport->base.chunks_info.rx_qtail_spacing;
+
+	adapter->cfgq_info = rte_zmalloc("cfgq_info", adapter->num_cfgq *
+				sizeof(struct cpfl_ctlq_create_info),
+				RTE_CACHE_LINE_SIZE);
+
+	if (!adapter->cfgq_info) {
+		PMD_DRV_LOG(ERR, "Failed to allocate memory for cfgq_info");
+		return -ENOMEM;
+	}
+
 	create_cfgq_info = adapter->cfgq_info;
 
-	for (i = 0; i < CPFL_CFGQ_NUM; i++) {
+	for (i = 0; i < adapter->num_cfgq; i++) {
 		if (i % 2 == 0) {
-			/* Setup Tx config queue */
-			create_cfgq_info[i].id = vport->base.chunks_info.tx_start_qid + i / 2;
+		/* Setup Tx config queue */
+			if (adapter->base.hw.device_id == IXD_DEV_ID_VCPF)
+				create_cfgq_info[i].id = cfgq_info->cfgq[i].qid;
+			else
+				create_cfgq_info[i].id = vport->base.chunks_info.tx_start_qid +
+								i / 2;
+
 			create_cfgq_info[i].type = IDPF_CTLQ_TYPE_CONFIG_TX;
 			create_cfgq_info[i].len = CPFL_CFGQ_RING_SIZE;
 			create_cfgq_info[i].buf_size = CPFL_CFGQ_BUFFER_SIZE;
 			memset(&create_cfgq_info[i].reg, 0, sizeof(struct idpf_ctlq_reg));
-			create_cfgq_info[i].reg.tail = vport->base.chunks_info.tx_qtail_start +
-				i / 2 * vport->base.chunks_info.tx_qtail_spacing;
+			if (adapter->base.hw.device_id == IXD_DEV_ID_VCPF)
+				create_cfgq_info[i].reg.tail = cfgq_info->cfgq[i].qtail_reg_start;
+			else
+				create_cfgq_info[i].reg.tail = tx_qtail_start +
+								i / 2 * tx_qtail_spacing;
+
 		} else {
-			/* Setup Rx config queue */
-			create_cfgq_info[i].id = vport->base.chunks_info.rx_start_qid + i / 2;
+		/* Setup Rx config queue */
+			if (adapter->base.hw.device_id == IXD_DEV_ID_VCPF)
+				create_cfgq_info[i].id = cfgq_info->cfgq[i].qid;
+			else
+				create_cfgq_info[i].id = vport->base.chunks_info.rx_start_qid +
+								i / 2;
+
 			create_cfgq_info[i].type = IDPF_CTLQ_TYPE_CONFIG_RX;
 			create_cfgq_info[i].len = CPFL_CFGQ_RING_SIZE;
 			create_cfgq_info[i].buf_size = CPFL_CFGQ_BUFFER_SIZE;
 			memset(&create_cfgq_info[i].reg, 0, sizeof(struct idpf_ctlq_reg));
-			create_cfgq_info[i].reg.tail = vport->base.chunks_info.rx_qtail_start +
-				i / 2 * vport->base.chunks_info.rx_qtail_spacing;
+			if (adapter->base.hw.device_id == IXD_DEV_ID_VCPF)
+				create_cfgq_info[i].reg.tail = cfgq_info->cfgq[i].qtail_reg_start;
+			else
+				create_cfgq_info[i].reg.tail = rx_qtail_start +
+								i / 2 * rx_qtail_spacing;
+
+
 			if (!idpf_alloc_dma_mem(&adapter->base.hw, &create_cfgq_info[i].buf_mem,
 						buf_size)) {
 				err = -ENOMEM;
@@ -2050,19 +2187,24 @@ cpfl_cfgq_setup(struct cpfl_adapter_ext *adapter)
 			}
 		}
 		if (!idpf_alloc_dma_mem(&adapter->base.hw, &create_cfgq_info[i].ring_mem,
-					ring_size)) {
+				ring_size)) {
 			err = -ENOMEM;
 			goto free_mem;
 		}
 	}
+
 	return 0;
 free_mem:
-	for (i = 0; i < CPFL_CFGQ_NUM; i++) {
+	for (i = 0; i < adapter->num_cfgq; i++) {
 		if (create_cfgq_info[i].ring_mem.va)
 			idpf_free_dma_mem(&adapter->base.hw, &create_cfgq_info[i].ring_mem);
 		if (create_cfgq_info[i].buf_mem.va)
 			idpf_free_dma_mem(&adapter->base.hw, &create_cfgq_info[i].buf_mem);
 	}
+	if (adapter->cfgq_info) {
+		rte_free(adapter->cfgq_info);
+		adapter->cfgq_info = NULL;
+	}
 	return err;
 }
 
@@ -2107,7 +2249,10 @@ cpfl_ctrl_path_close(struct cpfl_adapter_ext *adapter)
 {
 	cpfl_stop_cfgqs(adapter);
 	cpfl_remove_cfgqs(adapter);
-	idpf_vc_vport_destroy(&adapter->ctrl_vport.base);
+	if (adapter->base.hw.device_id == IDPF_DEV_ID_CPF)
+		idpf_vc_vport_destroy(&adapter->ctrl_vport.base);
+	else
+		vcpf_del_queues(adapter);
 }
 
 static int
@@ -2115,22 +2260,39 @@ cpfl_ctrl_path_open(struct cpfl_adapter_ext *adapter)
 {
 	int ret;
 
-	ret = cpfl_vc_create_ctrl_vport(adapter);
-	if (ret) {
-		PMD_INIT_LOG(ERR, "Failed to create control vport");
-		return ret;
-	}
+	if (adapter->base.hw.device_id == IDPF_DEV_ID_CPF) {
+		ret = cpfl_vc_create_ctrl_vport(adapter);
+		if (ret) {
+			PMD_INIT_LOG(ERR, "Failed to create control vport");
+			return ret;
+		}
 
-	ret = cpfl_init_ctrl_vport(adapter);
-	if (ret) {
-		PMD_INIT_LOG(ERR, "Failed to init control vport");
-		goto err_init_ctrl_vport;
+		ret = cpfl_init_ctrl_vport(adapter);
+		if (ret) {
+			PMD_INIT_LOG(ERR, "Failed to init control vport");
+			goto err_init_ctrl_vport;
+		}
+	} else {
+		ret = vcpf_add_queues(adapter);
+		if (ret) {
+			PMD_INIT_LOG(ERR, "Failed to add queues");
+			return ret;
+		}
+
+		ret = vcpf_save_chunk_in_cfgq(adapter);
+		if (ret) {
+			PMD_INIT_LOG(ERR, "Failed to save config queue chunk");
+			return ret;
+		}
 	}
 
 	ret = cpfl_cfgq_setup(adapter);
 	if (ret) {
 		PMD_INIT_LOG(ERR, "Failed to setup control queues");
-		goto err_cfgq_setup;
+		if (adapter->base.hw.device_id == IDPF_DEV_ID_CPF)
+			goto err_cfgq_setup;
+		else
+			goto err_del_cfg;
 	}
 
 	ret = cpfl_add_cfgqs(adapter);
@@ -2153,9 +2315,13 @@ cpfl_ctrl_path_open(struct cpfl_adapter_ext *adapter)
 	cpfl_remove_cfgqs(adapter);
 err_cfgq_setup:
 err_init_ctrl_vport:
-	idpf_vc_vport_destroy(&adapter->ctrl_vport.base);
+	if (adapter->base.hw.device_id == IDPF_DEV_ID_CPF)
+		idpf_vc_vport_destroy(&adapter->ctrl_vport.base);
+err_del_cfg:
+	vcpf_del_queues(adapter);
 
 	return ret;
+
 }
 
 static struct virtchnl2_get_capabilities req_caps = {
@@ -2291,12 +2457,29 @@ get_running_host_id(void)
 	return host_id;
 }
 
+static uint8_t
+set_config_queue_details(struct cpfl_adapter_ext *adapter, struct rte_pci_addr *pci_addr)
+{
+	if (pci_addr->function == CPFL_FID) {
+		adapter->num_cfgq = CPFL_CFGQ_NUM;
+		adapter->num_rx_cfgq = CPFL_RX_CFGQ_NUM;
+		adapter->num_tx_cfgq = CPFL_TX_CFGQ_NUM;
+	} else if (pci_addr->function == VCPF_FID) {
+		adapter->num_cfgq = VCPF_CFGQ_NUM;
+		adapter->num_rx_cfgq = VCPF_RX_CFGQ_NUM;
+		adapter->num_tx_cfgq = VCPF_TX_CFGQ_NUM;
+	}
+
+	return 0;
+}
+
 static int
 cpfl_adapter_ext_init(struct rte_pci_device *pci_dev, struct cpfl_adapter_ext *adapter,
 		      struct cpfl_devargs *devargs)
 {
 	struct idpf_adapter *base = &adapter->base;
 	struct idpf_hw *hw = &base->hw;
+	struct rte_pci_addr *pci_addr = &pci_dev->addr;
 	int ret = 0;
 
 #ifndef RTE_HAS_JANSSON
@@ -2348,10 +2531,23 @@ cpfl_adapter_ext_init(struct rte_pci_device *pci_dev, struct cpfl_adapter_ext *a
 		goto err_vports_alloc;
 	}
 
-	ret = cpfl_ctrl_path_open(adapter);
+	/* set the number of config queues to be requested */
+	ret = set_config_queue_details(adapter, pci_addr);
 	if (ret) {
-		PMD_INIT_LOG(ERR, "Failed to setup control path");
-		goto err_create_ctrl_vport;
+		PMD_INIT_LOG(ERR, "Failed to set the config queue details");
+		return -1;
+	}
+
+	if (pci_addr->function == VCPF_FID || pci_addr->function == CPFL_FID) {
+		ret = cpfl_ctrl_path_open(adapter);
+		if (ret) {
+			PMD_INIT_LOG(ERR, "Failed to setup control path");
+			if (pci_addr->function == CPFL_FID)
+				goto err_create_ctrl_vport;
+			else
+				return ret;
+		}
+
 	}
 
 #ifdef RTE_HAS_JANSSON
diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.h b/drivers/net/intel/cpfl/cpfl_ethdev.h
index 2cfcdd6206..81f223eef5 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.h
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.h
@@ -90,6 +90,9 @@
 #define CPFL_FPCP_CFGQ_TX	0
 #define CPFL_FPCP_CFGQ_RX	1
 #define CPFL_CFGQ_NUM		8
+#define VCPF_RX_CFGQ_NUM	1
+#define VCPF_TX_CFGQ_NUM	1
+#define VCPF_CFGQ_NUM		2
 
 /* bit[15:14] type
  * bit[13] host/accelerator core
@@ -201,6 +204,30 @@ struct cpfl_metadata {
 	struct cpfl_metadata_chunk chunks[CPFL_META_LENGTH];
 };
 
+/**
+ * struct vcpf_cfg_queue - config queue information
+ * @qid: rx/tx queue id
+ * @qtail_reg_start: rx/tx tail queue register start
+ * @qtail_reg_spacing: rx/tx tail queue register spacing
+ */
+struct vcpf_cfg_queue {
+	u32 qid;
+	u64 qtail_reg_start;
+	u32 qtail_reg_spacing;
+};
+
+/**
+ * struct vcpf_cfgq_info - config queue information
+ * @num_cfgq: number of config queues
+ * @cfgq_add: config queue add information
+ * @cfgq: config queue information
+ */
+struct vcpf_cfgq_info {
+	u16 num_cfgq;
+	struct virtchnl2_add_queues *cfgq_add;
+	struct vcpf_cfg_queue *cfgq;
+};
+
 struct cpfl_adapter_ext {
 	TAILQ_ENTRY(cpfl_adapter_ext) next;
 	struct idpf_adapter base;
@@ -230,8 +257,13 @@ struct cpfl_adapter_ext {
 	/* ctrl vport and ctrl queues. */
 	struct cpfl_vport ctrl_vport;
 	uint8_t ctrl_vport_recv_info[IDPF_DFLT_MBX_BUF_SIZE];
-	struct idpf_ctlq_info *ctlqp[CPFL_CFGQ_NUM];
-	struct cpfl_ctlq_create_info cfgq_info[CPFL_CFGQ_NUM];
+	struct idpf_ctlq_info **ctlqp;
+	struct cpfl_ctlq_create_info *cfgq_info;
+	struct vcpf_cfgq_info cfgq_in;
+	uint8_t addq_recv_info[IDPF_DFLT_MBX_BUF_SIZE];
+	uint16_t num_cfgq;
+	uint16_t num_rx_cfgq;
+	uint16_t num_tx_cfgq;
 	uint8_t host_id;
 };
 
@@ -252,6 +284,8 @@ int cpfl_config_ctlq_rx(struct cpfl_adapter_ext *adapter);
 int cpfl_config_ctlq_tx(struct cpfl_adapter_ext *adapter);
 int cpfl_alloc_dma_mem_batch(struct idpf_dma_mem *orig_dma, struct idpf_dma_mem *dma,
 			     uint32_t size, int batch_size);
+int vcpf_add_queues(struct cpfl_adapter_ext *adapter);
+int vcpf_del_queues(struct cpfl_adapter_ext *adapter);
 
 #define CPFL_DEV_TO_PCI(eth_dev)		\
 	RTE_DEV_TO_PCI((eth_dev)->device)
diff --git a/drivers/net/intel/cpfl/cpfl_vchnl.c b/drivers/net/intel/cpfl/cpfl_vchnl.c
index 7d277a0e8e..9c842b60df 100644
--- a/drivers/net/intel/cpfl/cpfl_vchnl.c
+++ b/drivers/net/intel/cpfl/cpfl_vchnl.c
@@ -106,6 +106,106 @@ cpfl_vc_create_ctrl_vport(struct cpfl_adapter_ext *adapter)
 	return err;
 }
 
+#define VCPF_CFQ_MB_INDEX                0xFF
+int
+vcpf_add_queues(struct cpfl_adapter_ext *adapter)
+{
+	struct virtchnl2_add_queues add_cfgq;
+	struct idpf_cmd_info args;
+	int err;
+
+	memset(&add_cfgq, 0, sizeof(struct virtchnl2_add_queues));
+	u16 num_cfgq = 1;
+
+	add_cfgq.num_tx_q = rte_cpu_to_le_16(num_cfgq);
+	add_cfgq.num_rx_q = rte_cpu_to_le_16(num_cfgq);
+	add_cfgq.mbx_q_index = VCPF_CFQ_MB_INDEX;
+
+	add_cfgq.vport_id = rte_cpu_to_le_32(VCPF_CFGQ_VPORT_ID);
+	add_cfgq.num_tx_complq = 0;
+	add_cfgq.num_rx_bufq = 0;
+
+	memset(&args, 0, sizeof(args));
+	args.ops = VIRTCHNL2_OP_ADD_QUEUES;
+	args.in_args = (uint8_t *)&add_cfgq;
+	args.in_args_size = sizeof(add_cfgq);
+	args.out_buffer = adapter->base.mbx_resp;
+	args.out_size = IDPF_DFLT_MBX_BUF_SIZE;
+
+	err = idpf_vc_cmd_execute(&adapter->base, &args);
+	if (err) {
+		PMD_DRV_LOG(ERR,
+			    "Failed to execute command VIRTCHNL2_OP_ADD_QUEUES");
+		return err;
+	}
+
+	rte_memcpy(adapter->addq_recv_info, args.out_buffer, IDPF_DFLT_MBX_BUF_SIZE);
+
+	return err;
+}
+
+int
+vcpf_del_queues(struct cpfl_adapter_ext *adapter)
+{
+	struct virtchnl2_del_ena_dis_queues *del_cfgq;
+	u16 num_chunks;
+	struct idpf_cmd_info args;
+	int i, err, size;
+
+	num_chunks = adapter->cfgq_in.cfgq_add->chunks.num_chunks;
+	size = idpf_struct_size(del_cfgq, chunks.chunks, (num_chunks - 1));
+	del_cfgq = rte_zmalloc("del_cfgq", size, 0);
+	if (!del_cfgq) {
+		PMD_DRV_LOG(ERR, "Failed to allocate virtchnl2_del_ena_dis_queues");
+		err = -ENOMEM;
+		return err;
+	}
+
+	del_cfgq->vport_id = rte_cpu_to_le_32(VCPF_CFGQ_VPORT_ID);
+	del_cfgq->chunks.num_chunks = num_chunks;
+
+	/* fill config queue chunk data */
+	for (i = 0; i < num_chunks; i++) {
+		del_cfgq->chunks.chunks[i].type =
+			adapter->cfgq_in.cfgq_add->chunks.chunks[i].type;
+		del_cfgq->chunks.chunks[i].start_queue_id =
+			adapter->cfgq_in.cfgq_add->chunks.chunks[i].start_queue_id;
+		del_cfgq->chunks.chunks[i].num_queues =
+			adapter->cfgq_in.cfgq_add->chunks.chunks[i].num_queues;
+	}
+
+	memset(&args, 0, sizeof(args));
+	args.ops = VIRTCHNL2_OP_DEL_QUEUES;
+	args.in_args = (uint8_t *)del_cfgq;
+	args.in_args_size = idpf_struct_size(del_cfgq, chunks.chunks,
+						(del_cfgq->chunks.num_chunks - 1));
+	args.out_buffer = adapter->base.mbx_resp;
+	args.out_size = IDPF_DFLT_MBX_BUF_SIZE;
+
+	err = idpf_vc_cmd_execute(&adapter->base, &args);
+	rte_free(del_cfgq);
+	if (err) {
+		PMD_DRV_LOG(ERR,
+			    "Failed to execute command VIRTCHNL2_OP_DEL_QUEUES");
+		return err;
+	}
+
+	if (adapter->cfgq_info) {
+		rte_free(adapter->cfgq_info);
+		adapter->cfgq_info = NULL;
+	}
+	adapter->cfgq_in.num_cfgq = 0;
+	if (adapter->cfgq_in.cfgq_add) {
+		rte_free(adapter->cfgq_in.cfgq_add);
+		adapter->cfgq_in.cfgq_add = NULL;
+	}
+	if (adapter->cfgq_in.cfgq) {
+		rte_free(adapter->cfgq_in.cfgq);
+		adapter->cfgq_in.cfgq = NULL;
+	}
+	return err;
+}
+
 int
 cpfl_config_ctlq_rx(struct cpfl_adapter_ext *adapter)
 {
@@ -116,13 +216,16 @@ cpfl_config_ctlq_rx(struct cpfl_adapter_ext *adapter)
 	uint16_t num_qs;
 	int size, err, i;
 
-	if (vport->base.rxq_model != VIRTCHNL2_QUEUE_MODEL_SINGLE) {
-		PMD_DRV_LOG(ERR, "This rxq model isn't supported.");
-		err = -EINVAL;
-		return err;
+	if (adapter->base.hw.device_id != IXD_DEV_ID_VCPF) {
+		if (vport->base.rxq_model != VIRTCHNL2_QUEUE_MODEL_SINGLE) {
+			PMD_DRV_LOG(ERR, "This rxq model isn't supported.");
+			err = -EINVAL;
+			return err;
+		}
 	}
 
-	num_qs = CPFL_RX_CFGQ_NUM;
+	num_qs = adapter->num_rx_cfgq;
+
 	size = sizeof(*vc_rxqs) + (num_qs - 1) *
 		sizeof(struct virtchnl2_rxq_info);
 	vc_rxqs = rte_zmalloc("cfg_rxqs", size, 0);
@@ -131,7 +234,12 @@ cpfl_config_ctlq_rx(struct cpfl_adapter_ext *adapter)
 		err = -ENOMEM;
 		return err;
 	}
-	vc_rxqs->vport_id = vport->base.vport_id;
+
+	if (adapter->base.hw.device_id == IXD_DEV_ID_VCPF)
+		vc_rxqs->vport_id = rte_cpu_to_le_32(VCPF_CFGQ_VPORT_ID);
+	else
+		vc_rxqs->vport_id = vport->base.vport_id;
+
 	vc_rxqs->num_qinfo = num_qs;
 
 	for (i = 0; i < num_qs; i++) {
@@ -141,7 +249,8 @@ cpfl_config_ctlq_rx(struct cpfl_adapter_ext *adapter)
 		rxq_info->queue_id = adapter->cfgq_info[2 * i + 1].id;
 		rxq_info->model = VIRTCHNL2_QUEUE_MODEL_SINGLE;
 		rxq_info->data_buffer_size = adapter->cfgq_info[2 * i + 1].buf_size;
-		rxq_info->max_pkt_size = vport->base.max_pkt_len;
+		if (adapter->base.hw.device_id != IXD_DEV_ID_VCPF)
+			rxq_info->max_pkt_size = vport->base.max_pkt_len;
 		rxq_info->desc_ids = VIRTCHNL2_RXDID_2_FLEX_SQ_NIC_M;
 		rxq_info->qflags |= VIRTCHNL2_RX_DESC_SIZE_32BYTE;
 		rxq_info->ring_len = adapter->cfgq_info[2 * i + 1].len;
@@ -172,13 +281,16 @@ cpfl_config_ctlq_tx(struct cpfl_adapter_ext *adapter)
 	uint16_t num_qs;
 	int size, err, i;
 
-	if (vport->base.txq_model != VIRTCHNL2_QUEUE_MODEL_SINGLE) {
-		PMD_DRV_LOG(ERR, "This txq model isn't supported.");
-		err = -EINVAL;
-		return err;
+	if (adapter->base.hw.device_id != IXD_DEV_ID_VCPF) {
+		if (vport->base.txq_model != VIRTCHNL2_QUEUE_MODEL_SINGLE) {
+			PMD_DRV_LOG(ERR, "This txq model isn't supported.");
+			err = -EINVAL;
+			return err;
+		}
 	}
 
-	num_qs = CPFL_TX_CFGQ_NUM;
+	num_qs = adapter->num_tx_cfgq;
+
 	size = sizeof(*vc_txqs) + (num_qs - 1) *
 		sizeof(struct virtchnl2_txq_info);
 	vc_txqs = rte_zmalloc("cfg_txqs", size, 0);
@@ -187,7 +299,12 @@ cpfl_config_ctlq_tx(struct cpfl_adapter_ext *adapter)
 		err = -ENOMEM;
 		return err;
 	}
-	vc_txqs->vport_id = vport->base.vport_id;
+
+	if (adapter->base.hw.device_id == IXD_DEV_ID_VCPF)
+		vc_txqs->vport_id = rte_cpu_to_le_32(VCPF_CFGQ_VPORT_ID);
+	else
+		vc_txqs->vport_id = vport->base.vport_id;
+
 	vc_txqs->num_qinfo = num_qs;
 
 	for (i = 0; i < num_qs; i++) {
diff --git a/drivers/net/intel/idpf/base/idpf_osdep.h b/drivers/net/intel/idpf/base/idpf_osdep.h
index 7b43df3079..47b95d0da6 100644
--- a/drivers/net/intel/idpf/base/idpf_osdep.h
+++ b/drivers/net/intel/idpf/base/idpf_osdep.h
@@ -361,6 +361,9 @@ idpf_hweight32(u32 num)
 
 #endif
 
+#define idpf_struct_size(ptr, field, num) \
+	(sizeof(*(ptr)) + sizeof(*(ptr)->field) * (num))
+
 enum idpf_mac_type {
 	IDPF_MAC_UNKNOWN = 0,
 	IDPF_MAC_PF,
diff --git a/drivers/net/intel/idpf/base/virtchnl2.h b/drivers/net/intel/idpf/base/virtchnl2.h
index cf010c0504..6cfb4f56fa 100644
--- a/drivers/net/intel/idpf/base/virtchnl2.h
+++ b/drivers/net/intel/idpf/base/virtchnl2.h
@@ -1024,7 +1024,8 @@ struct virtchnl2_add_queues {
 	__le16 num_tx_complq;
 	__le16 num_rx_q;
 	__le16 num_rx_bufq;
-	u8 pad[4];
+	u8 mbx_q_index;
+	u8 pad[3];
 
 	struct virtchnl2_queue_reg_chunks chunks;
 };
diff --git a/drivers/net/intel/idpf/idpf_common_device.h b/drivers/net/intel/idpf/idpf_common_device.h
index d536ce7e15..f962a3f805 100644
--- a/drivers/net/intel/idpf/idpf_common_device.h
+++ b/drivers/net/intel/idpf/idpf_common_device.h
@@ -45,6 +45,8 @@
 	(sizeof(struct virtchnl2_ptype) +				\
 	 (((p)->proto_id_count ? ((p)->proto_id_count - 1) : 0) * sizeof((p)->proto_id[0])))
 
+#define VCPF_CFGQ_VPORT_ID               0xFFFFFFFF
+
 struct idpf_adapter {
 	struct idpf_hw hw;
 	struct virtchnl2_version_info virtchnl_version;
diff --git a/drivers/net/intel/idpf/idpf_common_virtchnl.c b/drivers/net/intel/idpf/idpf_common_virtchnl.c
index bab854e191..e927d7415a 100644
--- a/drivers/net/intel/idpf/idpf_common_virtchnl.c
+++ b/drivers/net/intel/idpf/idpf_common_virtchnl.c
@@ -787,6 +787,44 @@ idpf_vc_ena_dis_one_queue(struct idpf_vport *vport, uint16_t qid,
 	return err;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_ena_dis_one_queue_vcpf)
+int
+idpf_vc_ena_dis_one_queue_vcpf(struct idpf_adapter *adapter, uint16_t qid,
+			  uint32_t type, bool on)
+{
+	struct virtchnl2_del_ena_dis_queues *queue_select;
+	struct virtchnl2_queue_chunk *queue_chunk;
+	struct idpf_cmd_info args;
+	int err, len;
+
+	len = sizeof(struct virtchnl2_del_ena_dis_queues);
+	queue_select = rte_zmalloc("queue_select", len, 0);
+	if (queue_select == NULL)
+		return -ENOMEM;
+
+	queue_chunk = queue_select->chunks.chunks;
+	queue_select->chunks.num_chunks = 1;
+	queue_select->vport_id = rte_cpu_to_le_32(VCPF_CFGQ_VPORT_ID);
+
+	queue_chunk->type = type;
+	queue_chunk->start_queue_id = qid;
+	queue_chunk->num_queues = 1;
+
+	args.ops = on ? VIRTCHNL2_OP_ENABLE_QUEUES :
+		VIRTCHNL2_OP_DISABLE_QUEUES;
+	args.in_args = (uint8_t *)queue_select;
+	args.in_args_size = len;
+	args.out_buffer = adapter->mbx_resp;
+	args.out_size = IDPF_DFLT_MBX_BUF_SIZE;
+	err = idpf_vc_cmd_execute(adapter, &args);
+	if (err != 0)
+		DRV_LOG(ERR, "Failed to execute command of VIRTCHNL2_OP_%s_QUEUES",
+			on ? "ENABLE" : "DISABLE");
+
+	rte_free(queue_select);
+	return err;
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_queue_switch)
 int
 idpf_vc_queue_switch(struct idpf_vport *vport, uint16_t qid,
diff --git a/drivers/net/intel/idpf/idpf_common_virtchnl.h b/drivers/net/intel/idpf/idpf_common_virtchnl.h
index 68cba9111c..90fce65676 100644
--- a/drivers/net/intel/idpf/idpf_common_virtchnl.h
+++ b/drivers/net/intel/idpf/idpf_common_virtchnl.h
@@ -76,6 +76,9 @@ __rte_internal
 int idpf_vc_ena_dis_one_queue(struct idpf_vport *vport, uint16_t qid,
 			      uint32_t type, bool on);
 __rte_internal
+int idpf_vc_ena_dis_one_queue_vcpf(struct idpf_adapter *adapter, uint16_t qid,
+			      uint32_t type, bool on);
+__rte_internal
 int idpf_vc_queue_grps_del(struct idpf_vport *vport,
 			   uint16_t num_q_grps,
 			   struct virtchnl2_queue_group_id *qg_ids);
-- 
2.37.3

