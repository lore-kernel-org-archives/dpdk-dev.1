Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AA9606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Nov 2026 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZoAjQSd6
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7845F402DF;
	Mon, 16 Nov 2026 17:09:46 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTPS id 0F94240299
 for <dev@dpdk.org>; Mon, 16 Nov 2026 17:09:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794845383; x=1826381383;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=davtEk6SrG/YxBPuMlBM4/2pax9nZeGWt1mD9S0O+YY=;
 b=ZoAjQSd6JdbzG56YzseYJ2lz/oLnbIYaADCDyvzhrFU1HaY1YUNfwikH
 miF9Fzxt2yJknv6sL76CYq+WfK/XUaOxcO//qVUx/YMDo9lnD83+xwqCY
 s/uooVy6rdV4k129Iki8TebUuEOa4fxwoU1wBtTP2pi1RBYz1IgMBwQjg
 bRy8kmUj6A+/Y2NQGwDtLKMrqx40U+xzhDWpgCpRLxEnACi9l6uKwRFEZ
 c261+n3auzw288SLCBe+IC4N26IZHSZd5vaTIZwIJvUyZSCcgIOrIawpJ
 PUY0qsP0pgz+N2nGUMaV4qBeDyOu4lxjpb1X0wa/b508fjLT0eT7asrxe w==;
X-CSE-ConnectionGUID: 7QthbJeyRuiPAhnrTndd9g==
X-CSE-MsgGUID: 9hx5NVivQsiyvOCi5Tdm9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3481865"
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="3481865"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 08:09:42 -0800
X-CSE-ConnectionGUID: GP++CuoTSiOGMLuTfGimfQ==
X-CSE-MsgGUID: wp8tFdB9QWaoGa0XBLm/6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="9926995"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa009.fm.intel.com with ESMTP; 16 Nov 2026 08:09:41 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 27.03 4/6] net/idpf: use stack storage for virtchnl messages
Date: Mon, 16 Nov 2026 16:09:30 +0000
Message-ID: <20261116160932.1006354-5-bruce.richardson@intel.com>
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

Rather than using malloc and free for virtchnl message buffers whose
maximum size is known at compile time, define them on the stack using
RTE_DEFINE_FLEX. This removes the allocation failure and cleanup paths.

As part of this, the queue chunks in idpf_vc_queues_ena_dis() are now
filled sequentially rather than indexed by queue type.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/idpf/idpf_common_device.c   | 27 ++-----
 drivers/net/intel/idpf/idpf_common_virtchnl.c | 77 +++++++------------
 2 files changed, 36 insertions(+), 68 deletions(-)

diff --git a/drivers/net/intel/idpf/idpf_common_device.c b/drivers/net/intel/idpf/idpf_common_device.c
index 1586dae96c..d3cb74f4a8 100644
--- a/drivers/net/intel/idpf/idpf_common_device.c
+++ b/drivers/net/intel/idpf/idpf_common_device.c
@@ -157,23 +157,15 @@ idpf_init_mbx(struct idpf_hw *hw)
 static int
 idpf_get_pkt_type(struct idpf_adapter *adapter)
 {
-	struct virtchnl2_get_ptype_info *req_ptype_info;
-	struct virtchnl2_get_ptype_info *recv_ptype_info;
+	struct virtchnl2_get_ptype_info req_ptype_msg = {0};
+	struct virtchnl2_get_ptype_info *req_ptype_info = &req_ptype_msg;
+	RTE_DEFINE_FLEX_BYTES(struct virtchnl2_get_ptype_info, recv_ptype_info,
+			IDPF_DFLT_MBX_BUF_SIZE);
 	uint16_t recv_num_ptypes = 0;
 	uint16_t ptype_offset, i, j;
 	uint16_t start_ptype_id = 0;
 	int ret;
 
-	req_ptype_info = rte_zmalloc("req_ptype_info", IDPF_DFLT_MBX_BUF_SIZE, 0);
-	if (req_ptype_info == NULL)
-		return -ENOMEM;
-
-	recv_ptype_info = rte_zmalloc("recv_ptype_info", IDPF_DFLT_MBX_BUF_SIZE, 0);
-	if (recv_ptype_info == NULL) {
-		ret = -ENOMEM;
-		goto free_req_ptype_info;
-	}
-
 	while (start_ptype_id < IDPF_MAX_PKT_TYPE) {
 		memset(req_ptype_info, 0, sizeof(*req_ptype_info));
 		memset(recv_ptype_info, 0, sizeof(*recv_ptype_info));
@@ -188,13 +180,13 @@ idpf_get_pkt_type(struct idpf_adapter *adapter)
 		ret = idpf_vc_ptype_info_query(adapter, req_ptype_info, recv_ptype_info);
 		if (ret != 0) {
 			DRV_LOG(ERR, "Fail to query packet type information");
-			goto free_recv_ptype_info;
+			goto out;
 		}
 
 		recv_num_ptypes += rte_le_to_cpu_16(recv_ptype_info->num_ptypes);
 		if (recv_num_ptypes > IDPF_MAX_PKT_TYPE) {
 			ret = -EINVAL;
-			goto free_recv_ptype_info;
+			goto out;
 		}
 
 		start_ptype_id = rte_le_to_cpu_16(req_ptype_info->start_ptype_id) +
@@ -213,7 +205,7 @@ idpf_get_pkt_type(struct idpf_adapter *adapter)
 			ptype_offset += IDPF_GET_PTYPE_SIZE(ptype);
 			if (ptype_offset > IDPF_DFLT_MBX_BUF_SIZE) {
 				ret = -EINVAL;
-				goto free_recv_ptype_info;
+				goto out;
 			}
 
 			for (j = 0; j < ptype->proto_id_count; j++) {
@@ -374,10 +366,7 @@ idpf_get_pkt_type(struct idpf_adapter *adapter)
 		}
 	}
 
-free_recv_ptype_info:
-	rte_free(recv_ptype_info);
-free_req_ptype_info:
-	rte_free(req_ptype_info);
+out:
 	clear_cmd(adapter);
 	return ret;
 }
diff --git a/drivers/net/intel/idpf/idpf_common_virtchnl.c b/drivers/net/intel/idpf/idpf_common_virtchnl.c
index 4befd5fc83..2159dd9ad1 100644
--- a/drivers/net/intel/idpf/idpf_common_virtchnl.c
+++ b/drivers/net/intel/idpf/idpf_common_virtchnl.c
@@ -463,15 +463,15 @@ int
 idpf_vc_rss_key_set(struct idpf_vport *vport)
 {
 	struct idpf_adapter *adapter = vport->adapter;
-	struct virtchnl2_rss_key *rss_key;
+	RTE_DEFINE_FLEX(struct virtchnl2_rss_key, rss_key, key, IDPF_RSS_KEY_LEN - 1);
 	struct idpf_cmd_info args;
 	int len, err;
 
+	if (vport->rss_key_size > IDPF_RSS_KEY_LEN)
+		return -EINVAL;
+
 	len = sizeof(*rss_key) + sizeof(rss_key->key[0]) *
 		(vport->rss_key_size - 1);
-	rss_key = rte_zmalloc("rss_key", len, 0);
-	if (rss_key == NULL)
-		return -ENOMEM;
 
 	rss_key->vport_id = vport->vport_id;
 	rss_key->key_len = vport->rss_key_size;
@@ -489,7 +489,6 @@ idpf_vc_rss_key_set(struct idpf_vport *vport)
 	if (err != 0)
 		DRV_LOG(ERR, "Failed to execute command of VIRTCHNL2_OP_SET_RSS_KEY");
 
-	rte_free(rss_key);
 	return err;
 }
 
@@ -781,15 +780,13 @@ idpf_vc_ena_dis_one_queue(struct idpf_vport *vport, uint16_t qid,
 			  uint32_t type, bool on)
 {
 	struct idpf_adapter *adapter = vport->adapter;
-	struct virtchnl2_del_ena_dis_queues *queue_select;
+	struct virtchnl2_del_ena_dis_queues queue_select_msg = {0};
+	struct virtchnl2_del_ena_dis_queues *queue_select = &queue_select_msg;
 	struct virtchnl2_queue_chunk *queue_chunk;
 	struct idpf_cmd_info args;
 	int err, len;
 
 	len = sizeof(struct virtchnl2_del_ena_dis_queues);
-	queue_select = rte_zmalloc("queue_select", len, 0);
-	if (queue_select == NULL)
-		return -ENOMEM;
 
 	queue_chunk = queue_select->chunks.chunks;
 	queue_select->chunks.num_chunks = 1;
@@ -810,7 +807,6 @@ idpf_vc_ena_dis_one_queue(struct idpf_vport *vport, uint16_t qid,
 		DRV_LOG(ERR, "Failed to execute command of VIRTCHNL2_OP_%s_QUEUES",
 			on ? "ENABLE" : "DISABLE");
 
-	rte_free(queue_select);
 	return err;
 }
 
@@ -819,15 +815,13 @@ int
 idpf_vc_ena_dis_one_queue_vcpf(struct idpf_adapter *adapter, uint16_t qid,
 			  uint32_t type, bool on)
 {
-	struct virtchnl2_del_ena_dis_queues *queue_select;
+	struct virtchnl2_del_ena_dis_queues queue_select_msg = {0};
+	struct virtchnl2_del_ena_dis_queues *queue_select = &queue_select_msg;
 	struct virtchnl2_queue_chunk *queue_chunk;
 	struct idpf_cmd_info args;
 	int err, len;
 
 	len = sizeof(struct virtchnl2_del_ena_dis_queues);
-	queue_select = rte_zmalloc("queue_select", len, 0);
-	if (queue_select == NULL)
-		return -ENOMEM;
 
 	queue_chunk = queue_select->chunks.chunks;
 	queue_select->chunks.num_chunks = 1;
@@ -848,7 +842,6 @@ idpf_vc_ena_dis_one_queue_vcpf(struct idpf_adapter *adapter, uint16_t qid,
 		DRV_LOG(ERR, "Failed to execute command of VIRTCHNL2_OP_%s_QUEUES",
 			on ? "ENABLE" : "DISABLE");
 
-	rte_free(queue_select);
 	return err;
 }
 
@@ -893,16 +886,18 @@ idpf_vc_queue_switch(struct idpf_vport *vport, uint16_t qid,
 }
 
 #define IDPF_RXTX_QUEUE_CHUNKS_NUM	2
+#define IDPF_RXTX_QUEUE_CHUNKS_MAX	(IDPF_RXTX_QUEUE_CHUNKS_NUM + 2)
 RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_queues_ena_dis)
 int
 idpf_vc_queues_ena_dis(struct idpf_vport *vport, bool enable)
 {
 	struct idpf_adapter *adapter = vport->adapter;
-	struct virtchnl2_del_ena_dis_queues *queue_select;
+	RTE_DEFINE_FLEX(struct virtchnl2_del_ena_dis_queues, queue_select, chunks.chunks,
+			IDPF_RXTX_QUEUE_CHUNKS_MAX - 1);
 	struct virtchnl2_queue_chunk *queue_chunk;
 	uint32_t type;
 	struct idpf_cmd_info args;
-	uint16_t num_chunks;
+	uint16_t num_chunks, idx = 0;
 	int err, len;
 
 	num_chunks = IDPF_RXTX_QUEUE_CHUNKS_NUM;
@@ -913,38 +908,35 @@ idpf_vc_queues_ena_dis(struct idpf_vport *vport, bool enable)
 
 	len = sizeof(struct virtchnl2_del_ena_dis_queues) +
 		sizeof(struct virtchnl2_queue_chunk) * (num_chunks - 1);
-	queue_select = rte_zmalloc("queue_select", len, 0);
-	if (queue_select == NULL)
-		return -ENOMEM;
 
 	queue_chunk = queue_select->chunks.chunks;
 	queue_select->chunks.num_chunks = num_chunks;
 	queue_select->vport_id = vport->vport_id;
 
 	type = VIRTCHNL_QUEUE_TYPE_RX;
-	queue_chunk[type].type = type;
-	queue_chunk[type].start_queue_id = vport->chunks_info.rx_start_qid;
-	queue_chunk[type].num_queues = vport->num_rx_q;
+	queue_chunk[idx].type = type;
+	queue_chunk[idx].start_queue_id = vport->chunks_info.rx_start_qid;
+	queue_chunk[idx++].num_queues = vport->num_rx_q;
 
 	type = VIRTCHNL2_QUEUE_TYPE_TX;
-	queue_chunk[type].type = type;
-	queue_chunk[type].start_queue_id = vport->chunks_info.tx_start_qid;
-	queue_chunk[type].num_queues = vport->num_tx_q;
+	queue_chunk[idx].type = type;
+	queue_chunk[idx].start_queue_id = vport->chunks_info.tx_start_qid;
+	queue_chunk[idx++].num_queues = vport->num_tx_q;
 
 	if (vport->rxq_model == VIRTCHNL2_QUEUE_MODEL_SPLIT) {
 		type = VIRTCHNL2_QUEUE_TYPE_RX_BUFFER;
-		queue_chunk[type].type = type;
-		queue_chunk[type].start_queue_id =
+		queue_chunk[idx].type = type;
+		queue_chunk[idx].start_queue_id =
 			vport->chunks_info.rx_buf_start_qid;
-		queue_chunk[type].num_queues = vport->num_rx_bufq;
+		queue_chunk[idx++].num_queues = vport->num_rx_bufq;
 	}
 
 	if (vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SPLIT) {
 		type = VIRTCHNL2_QUEUE_TYPE_TX_COMPLETION;
-		queue_chunk[type].type = type;
-		queue_chunk[type].start_queue_id =
+		queue_chunk[idx].type = type;
+		queue_chunk[idx].start_queue_id =
 			vport->chunks_info.tx_compl_start_qid;
-		queue_chunk[type].num_queues = vport->num_tx_complq;
+		queue_chunk[idx++].num_queues = vport->num_tx_complq;
 	}
 
 	args.ops = enable ? VIRTCHNL2_OP_ENABLE_QUEUES :
@@ -958,7 +950,6 @@ idpf_vc_queues_ena_dis(struct idpf_vport *vport, bool enable)
 		DRV_LOG(ERR, "Failed to execute command of VIRTCHNL2_OP_%s_QUEUES",
 			enable ? "ENABLE" : "DISABLE");
 
-	rte_free(queue_select);
 	return err;
 }
 
@@ -1044,7 +1035,8 @@ int
 idpf_vc_rxq_config(struct idpf_vport *vport, struct idpf_rx_queue *rxq)
 {
 	struct idpf_adapter *adapter = vport->adapter;
-	struct virtchnl2_config_rx_queues *vc_rxqs = NULL;
+	RTE_DEFINE_FLEX(struct virtchnl2_config_rx_queues, vc_rxqs, qinfo,
+			IDPF_RXQ_PER_GRP + IDPF_RX_BUFQ_PER_GRP - 1);
 	struct virtchnl2_rxq_info *rxq_info;
 	struct idpf_cmd_info args;
 	uint16_t num_qs;
@@ -1057,12 +1049,6 @@ idpf_vc_rxq_config(struct idpf_vport *vport, struct idpf_rx_queue *rxq)
 
 	size = sizeof(*vc_rxqs) + (num_qs - 1) *
 		sizeof(struct virtchnl2_rxq_info);
-	vc_rxqs = rte_zmalloc("cfg_rxqs", size, 0);
-	if (vc_rxqs == NULL) {
-		DRV_LOG(ERR, "Failed to allocate virtchnl2_config_rx_queues");
-		err = -ENOMEM;
-		return err;
-	}
 	vc_rxqs->vport_id = vport->vport_id;
 	vc_rxqs->num_qinfo = num_qs;
 	if (vport->rxq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE) {
@@ -1122,7 +1108,6 @@ idpf_vc_rxq_config(struct idpf_vport *vport, struct idpf_rx_queue *rxq)
 	args.out_size = IDPF_DFLT_MBX_BUF_SIZE;
 
 	err = idpf_vc_cmd_execute(adapter, &args);
-	rte_free(vc_rxqs);
 	if (err != 0)
 		DRV_LOG(ERR, "Failed to execute command of VIRTCHNL2_OP_CONFIG_RX_QUEUES");
 
@@ -1170,7 +1155,8 @@ int
 idpf_vc_txq_config(struct idpf_vport *vport, struct ci_tx_queue *txq)
 {
 	struct idpf_adapter *adapter = vport->adapter;
-	struct virtchnl2_config_tx_queues *vc_txqs = NULL;
+	RTE_DEFINE_FLEX(struct virtchnl2_config_tx_queues, vc_txqs, qinfo,
+			IDPF_TXQ_PER_GRP + IDPF_TX_COMPLQ_PER_GRP - 1);
 	struct virtchnl2_txq_info *txq_info;
 	struct idpf_cmd_info args;
 	uint16_t num_qs;
@@ -1183,12 +1169,6 @@ idpf_vc_txq_config(struct idpf_vport *vport, struct ci_tx_queue *txq)
 
 	size = sizeof(*vc_txqs) + (num_qs - 1) *
 		sizeof(struct virtchnl2_txq_info);
-	vc_txqs = rte_zmalloc("cfg_txqs", size, 0);
-	if (vc_txqs == NULL) {
-		DRV_LOG(ERR, "Failed to allocate virtchnl2_config_tx_queues");
-		err = -ENOMEM;
-		return err;
-	}
 	vc_txqs->vport_id = vport->vport_id;
 	vc_txqs->num_qinfo = num_qs;
 
@@ -1230,7 +1210,6 @@ idpf_vc_txq_config(struct idpf_vport *vport, struct ci_tx_queue *txq)
 	args.out_size = IDPF_DFLT_MBX_BUF_SIZE;
 
 	err = idpf_vc_cmd_execute(adapter, &args);
-	rte_free(vc_txqs);
 	if (err != 0)
 		DRV_LOG(ERR, "Failed to execute command of VIRTCHNL2_OP_CONFIG_TX_QUEUES");
 
-- 
2.55.0

