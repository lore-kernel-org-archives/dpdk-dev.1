Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8B6606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Nov 2026 16:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=P9dwLB5v
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47BB8402F0;
	Mon, 16 Nov 2026 17:09:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTPS id DA47C40299
 for <dev@dpdk.org>; Mon, 16 Nov 2026 17:09:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794845384; x=1826381384;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lCIN1/Oha5SABEPElOX7a2X6mpiywpohcD9lTJl9mlE=;
 b=P9dwLB5vXBm2gFYT+Y0szFqAOCqbmHtQS2JrsT7iWYwCYT6WXiqtnTFe
 9WhkMxGIydwoTFa1dRuCn9XWpsuoRKrcT712x/QPNCMUmjdYLepd0xqXT
 azE0yax8DnmDOMnjM0p03CO8kO/fydDvtHoUQ7rXkOm9Pnq2hHB6mXodk
 hyNOWdt/AyyGEG5nVrqrtcSPelI7Wa5I3aWQkJjt7hEusMAU9h+7ztUqr
 6Ce9oZ5giDBJP+qBE6jfWAeYREX1bezgD4ShkVGeDn6llfYK+lmzklDco
 AkRETqVxS8Mkd0KLmtGrqc//xkVflhSV//kA93XnPHEGwUO5lI1wqki7x A==;
X-CSE-ConnectionGUID: t9dXWyYaRbO5VZL+jH88ZQ==
X-CSE-MsgGUID: i+SBFf86SAab+mxPo87nNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3481866"
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="3481866"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 08:09:43 -0800
X-CSE-ConnectionGUID: fgd5oH34QA6f/tuwG4u/dQ==
X-CSE-MsgGUID: G3YDPMd+Saam6V+gt0jjkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="9927001"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa009.fm.intel.com with ESMTP; 16 Nov 2026 08:09:42 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 27.03 5/6] net/cpfl: use stack storage for function-local
 buffers
Date: Mon, 16 Nov 2026 16:09:31 +0000
Message-ID: <20261116160932.1006354-6-bruce.richardson@intel.com>
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Rather than using malloc and free for virtchnl and control queue buffers
used only within a single function, define them on the stack, using
RTE_DEFINE_FLEX for those structures ending in a variable-length array.
This removes the allocation failure and cleanup paths.

Where the number of elements used depends on runtime values, add checks
that those values do not exceed the buffer sizes.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/cpfl/cpfl_fxp_rule.c    | 20 ++++-------
 drivers/net/intel/cpfl/cpfl_representor.c | 15 +++++----
 drivers/net/intel/cpfl/cpfl_vchnl.c       | 41 +++++++++--------------
 3 files changed, 32 insertions(+), 44 deletions(-)

diff --git a/drivers/net/intel/cpfl/cpfl_fxp_rule.c b/drivers/net/intel/cpfl/cpfl_fxp_rule.c
index d1c992dfe4..c522dde6d8 100644
--- a/drivers/net/intel/cpfl/cpfl_fxp_rule.c
+++ b/drivers/net/intel/cpfl/cpfl_fxp_rule.c
@@ -13,23 +13,21 @@ int
 cpfl_send_ctlq_msg(struct idpf_hw *hw, struct idpf_ctlq_info *cq, u16 num_q_msg,
 		   struct idpf_ctlq_msg q_msg[])
 {
-	struct idpf_ctlq_msg **msg_ptr_list;
+	struct idpf_ctlq_msg *msg_ptr_list[CPFL_FLOW_BATCH_SIZE] = {0};
 	u16 clean_count = 0;
 	int num_cleaned = 0;
 	int retries = 0;
 	int ret = 0;
 
-	msg_ptr_list = calloc(num_q_msg, sizeof(struct idpf_ctlq_msg *));
-	if (!msg_ptr_list) {
-		PMD_INIT_LOG(ERR, "no memory for cleaning ctlq");
-		ret = -ENOMEM;
-		goto err;
+	if (num_q_msg > RTE_DIM(msg_ptr_list)) {
+		PMD_INIT_LOG(ERR, "too many messages for ctlq: %u", num_q_msg);
+		return -EINVAL;
 	}
 
 	ret = cpfl_vport_ctlq_send(hw, cq, num_q_msg, q_msg);
 	if (ret) {
 		PMD_INIT_LOG(ERR, "cpfl_vport_ctlq_send() failed with error: 0x%4x", ret);
-		goto send_err;
+		return ret;
 	}
 
 	while (retries <= CTLQ_SEND_RETRIES) {
@@ -38,7 +36,7 @@ cpfl_send_ctlq_msg(struct idpf_hw *hw, struct idpf_ctlq_info *cq, u16 num_q_msg,
 					       &msg_ptr_list[num_cleaned]);
 		if (ret) {
 			PMD_INIT_LOG(ERR, "clean ctlq failed: 0x%4x", ret);
-			goto send_err;
+			return ret;
 		}
 
 		num_cleaned += clean_count;
@@ -50,13 +48,9 @@ cpfl_send_ctlq_msg(struct idpf_hw *hw, struct idpf_ctlq_info *cq, u16 num_q_msg,
 
 	if (retries > CTLQ_SEND_RETRIES) {
 		PMD_INIT_LOG(ERR, "timed out while polling for completions");
-		ret = -1;
-		goto send_err;
+		return -1;
 	}
 
-send_err:
-	free(msg_ptr_list);
-err:
 	return ret;
 }
 
diff --git a/drivers/net/intel/cpfl/cpfl_representor.c b/drivers/net/intel/cpfl/cpfl_representor.c
index bb28c0b989..91bbb3af48 100644
--- a/drivers/net/intel/cpfl/cpfl_representor.c
+++ b/drivers/net/intel/cpfl/cpfl_representor.c
@@ -558,14 +558,11 @@ cpfl_repr_create(struct rte_pci_device *pci_dev, struct cpfl_adapter_ext *adapte
 	uint32_t iter = 0;
 	const struct cpfl_repr_id *repr_id;
 	const struct cpfl_vport_id *vp_id;
-	struct cpchnl2_get_vport_list_response *vlist_resp;
+	RTE_DEFINE_FLEX_BYTES(struct cpchnl2_get_vport_list_response, vlist_resp,
+			IDPF_DFLT_MBX_BUF_SIZE);
 	struct cpchnl2_get_vport_info_response vinfo_resp;
 	int ret;
 
-	vlist_resp = rte_zmalloc(NULL, IDPF_DFLT_MBX_BUF_SIZE, 0);
-	if (vlist_resp == NULL)
-		return -ENOMEM;
-
 	rte_spinlock_lock(&adapter->repr_lock);
 
 	while (rte_hash_iterate(adapter->repr_allowlist_hash,
@@ -603,6 +600,13 @@ cpfl_repr_create(struct rte_pci_device *pci_dev, struct cpfl_adapter_ext *adapte
 			PMD_INIT_LOG(WARNING, "No matched vport for representor %s", name);
 			continue;
 		}
+		if (vlist_resp->nof_vports > (IDPF_DFLT_MBX_BUF_SIZE - sizeof(*vlist_resp)) /
+				sizeof(vlist_resp->vports[0])) {
+			PMD_INIT_LOG(ERR, "Invalid vport count %u for representor %s",
+				     vlist_resp->nof_vports, name);
+			ret = -EINVAL;
+			goto err;
+		}
 
 		/* get all vport info for the port representor */
 		for (i = 0; i < vlist_resp->nof_vports; i++) {
@@ -657,6 +661,5 @@ cpfl_repr_create(struct rte_pci_device *pci_dev, struct cpfl_adapter_ext *adapte
 
 err:
 	rte_spinlock_unlock(&adapter->repr_lock);
-	rte_free(vlist_resp);
 	return ret;
 }
diff --git a/drivers/net/intel/cpfl/cpfl_vchnl.c b/drivers/net/intel/cpfl/cpfl_vchnl.c
index 593516f700..6a4e4dac1b 100644
--- a/drivers/net/intel/cpfl/cpfl_vchnl.c
+++ b/drivers/net/intel/cpfl/cpfl_vchnl.c
@@ -147,18 +147,16 @@ vcpf_add_queues(struct cpfl_adapter_ext *adapter)
 int
 vcpf_del_queues(struct cpfl_adapter_ext *adapter)
 {
-	struct virtchnl2_del_ena_dis_queues *del_cfgq;
+	RTE_DEFINE_FLEX(struct virtchnl2_del_ena_dis_queues, del_cfgq, chunks.chunks,
+			VCPF_CFGQ_NUM - 1);
 	u16 num_chunks;
 	struct idpf_cmd_info args;
-	int i, err, size;
+	int i, err;
 
 	num_chunks = adapter->cfgq_in.cfgq_add->chunks.num_chunks;
-	size = idpf_struct_size(del_cfgq, chunks.chunks, (num_chunks - 1));
-	del_cfgq = rte_zmalloc("del_cfgq", size, 0);
-	if (!del_cfgq) {
-		PMD_DRV_LOG(ERR, "Failed to allocate virtchnl2_del_ena_dis_queues");
-		err = -ENOMEM;
-		return err;
+	if (num_chunks > VCPF_CFGQ_NUM) {
+		PMD_DRV_LOG(ERR, "Too many config queue chunks: %u", num_chunks);
+		return -EINVAL;
 	}
 
 	del_cfgq->vport_id = rte_cpu_to_le_32(VCPF_CFGQ_VPORT_ID);
@@ -183,7 +181,6 @@ vcpf_del_queues(struct cpfl_adapter_ext *adapter)
 	args.out_size = IDPF_DFLT_MBX_BUF_SIZE;
 
 	err = idpf_vc_cmd_execute(&adapter->base, &args);
-	rte_free(del_cfgq);
 	if (err) {
 		PMD_DRV_LOG(ERR,
 			    "Failed to execute command VIRTCHNL2_OP_DEL_QUEUES");
@@ -210,7 +207,7 @@ int
 cpfl_config_ctlq_rx(struct cpfl_adapter_ext *adapter)
 {
 	struct cpfl_vport *vport = &adapter->ctrl_vport;
-	struct virtchnl2_config_rx_queues *vc_rxqs = NULL;
+	RTE_DEFINE_FLEX(struct virtchnl2_config_rx_queues, vc_rxqs, qinfo, CPFL_RX_CFGQ_NUM - 1);
 	struct virtchnl2_rxq_info *rxq_info;
 	struct idpf_cmd_info args;
 	uint16_t num_qs;
@@ -225,15 +222,13 @@ cpfl_config_ctlq_rx(struct cpfl_adapter_ext *adapter)
 	}
 
 	num_qs = adapter->num_rx_cfgq;
+	if (num_qs > CPFL_RX_CFGQ_NUM) {
+		PMD_DRV_LOG(ERR, "Too many Rx config queues: %u", num_qs);
+		return -EINVAL;
+	}
 
 	size = sizeof(*vc_rxqs) + (num_qs - 1) *
 		sizeof(struct virtchnl2_rxq_info);
-	vc_rxqs = rte_zmalloc("cfg_rxqs", size, 0);
-	if (!vc_rxqs) {
-		PMD_DRV_LOG(ERR, "Failed to allocate virtchnl2_config_rx_queues");
-		err = -ENOMEM;
-		return err;
-	}
 
 	if (idpf_is_vf_device(&adapter->base.hw))
 		vc_rxqs->vport_id = rte_cpu_to_le_32(VCPF_CFGQ_VPORT_ID);
@@ -264,7 +259,6 @@ cpfl_config_ctlq_rx(struct cpfl_adapter_ext *adapter)
 	args.out_size = IDPF_DFLT_MBX_BUF_SIZE;
 
 	err = idpf_vc_cmd_execute(&adapter->base, &args);
-	rte_free(vc_rxqs);
 	if (err)
 		PMD_DRV_LOG(ERR, "Failed to execute command of VIRTCHNL2_OP_CONFIG_RX_QUEUES");
 
@@ -275,7 +269,7 @@ int
 cpfl_config_ctlq_tx(struct cpfl_adapter_ext *adapter)
 {
 	struct cpfl_vport *vport = &adapter->ctrl_vport;
-	struct virtchnl2_config_tx_queues *vc_txqs = NULL;
+	RTE_DEFINE_FLEX(struct virtchnl2_config_tx_queues, vc_txqs, qinfo, CPFL_TX_CFGQ_NUM - 1);
 	struct virtchnl2_txq_info *txq_info;
 	struct idpf_cmd_info args;
 	uint16_t num_qs;
@@ -290,15 +284,13 @@ cpfl_config_ctlq_tx(struct cpfl_adapter_ext *adapter)
 	}
 
 	num_qs = adapter->num_tx_cfgq;
+	if (num_qs > CPFL_TX_CFGQ_NUM) {
+		PMD_DRV_LOG(ERR, "Too many Tx config queues: %u", num_qs);
+		return -EINVAL;
+	}
 
 	size = sizeof(*vc_txqs) + (num_qs - 1) *
 		sizeof(struct virtchnl2_txq_info);
-	vc_txqs = rte_zmalloc("cfg_txqs", size, 0);
-	if (!vc_txqs) {
-		PMD_DRV_LOG(ERR, "Failed to allocate virtchnl2_config_tx_queues");
-		err = -ENOMEM;
-		return err;
-	}
 
 	if (idpf_is_vf_device(&adapter->base.hw))
 		vc_txqs->vport_id = rte_cpu_to_le_32(VCPF_CFGQ_VPORT_ID);
@@ -325,7 +317,6 @@ cpfl_config_ctlq_tx(struct cpfl_adapter_ext *adapter)
 	args.out_size = IDPF_DFLT_MBX_BUF_SIZE;
 
 	err = idpf_vc_cmd_execute(&adapter->base, &args);
-	rte_free(vc_txqs);
 	if (err)
 		PMD_DRV_LOG(ERR, "Failed to execute command of VIRTCHNL2_OP_CONFIG_TX_QUEUES");
 
-- 
2.55.0

