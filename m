Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A7AFCEE94
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 12:09:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5EBC40288;
	Wed, 25 Feb 2026 13:09:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 65A99400D6
 for <dev@dpdk.org>; Wed, 25 Feb 2026 13:09:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772021360; x=1803557360;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=I5lSJq4Zymf+U76v/2CONqgbZz78pFkhTODUwJP7PPk=;
 b=cx8t2QU6WvIXRUp5iArmohmd4tCnmKveiyalx9Kr8zTe9Og+6PLGL2Ww
 PNp2nmKwn95gQy3FpI2xnTjOVpn/9ZtLSXIvIKi3xCL4PPN+oiP9021gH
 rG0qHX4nrFsorQThtc8Aovy52xTW4WiQ4QRHGyPkx6R7rlO71yVW61Kly
 n9xrFMVrGuDSQfhE9QV/Mtj+apK7tn43wenKAPr04hLgaBzPq69iFf++9
 7/dqiHO4a7MBDQk794Wq0ysTH12R+lFTZEzKnI4aS7dDZCUY3Elx1a7uS
 dKHSLgkfmR3Va8ZUkZjfz80UQn1RGBDz/3eCtrBUM0ThHHaGDVLbgsN7G g==;
X-CSE-ConnectionGUID: SUCiEsYjQQ2qqhZZjvCjaA==
X-CSE-MsgGUID: 004O5TVsRM+NccRa5gLagA==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="72095465"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; d="scan'208";a="72095465"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 04:09:18 -0800
X-CSE-ConnectionGUID: xsQ5We+DS9awKP6mw4wF0A==
X-CSE-MsgGUID: xci/r2JwQp+WKN3SNmZgyw==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 25 Feb 2026 04:09:17 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v1 1/1] net/iavf: remove global adminq response buffer
Date: Wed, 25 Feb 2026 12:09:16 +0000
Message-ID: <2a3001591642339ecf8f91584c83bf0766e0b66d.1772021348.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
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

In many places where we are calling down into virtchnl, we are using a
globally allocated adminq response buffer. This is unnecessary, so replace
with adminq buffers allocated on stack.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf.h        |   1 -
 drivers/net/intel/iavf/iavf_ethdev.c |  13 --
 drivers/net/intel/iavf/iavf_vchnl.c  | 240 +++++++++++++++------------
 3 files changed, 136 insertions(+), 118 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index f9bb398a77..c44ef54766 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -242,7 +242,6 @@ struct iavf_info {
 	volatile RTE_ATOMIC(enum virtchnl_ops) pend_cmd; /* pending command not finished */
 	RTE_ATOMIC(uint32_t) pend_cmd_count;
 	int cmd_retval; /* return value of the cmd response from PF */
-	uint8_t *aq_resp; /* buffer to store the adminq response from PF */
 
 	/** iAVF watchdog enable */
 	bool watchdog_enabled;
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 26e7febecf..d32a3c56a1 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -2545,11 +2545,6 @@ iavf_init_vf(struct rte_eth_dev *dev)
 		goto err;
 	}
 
-	vf->aq_resp = rte_zmalloc("vf_aq_resp", IAVF_AQ_BUF_SZ, 0);
-	if (!vf->aq_resp) {
-		PMD_INIT_LOG(ERR, "unable to allocate vf_aq_resp memory");
-		goto err_aq;
-	}
 	if (iavf_check_api_version(adapter) != 0) {
 		PMD_INIT_LOG(ERR, "check_api version failed");
 		goto err_api;
@@ -2623,8 +2618,6 @@ iavf_init_vf(struct rte_eth_dev *dev)
 	rte_free(vf->vf_res);
 	vf->vsi_res = NULL;
 err_api:
-	rte_free(vf->aq_resp);
-err_aq:
 	iavf_shutdown_adminq(hw);
 err:
 	return -1;
@@ -2642,9 +2635,6 @@ iavf_uninit_vf(struct rte_eth_dev *dev)
 	vf->vsi_res = NULL;
 	vf->vf_res = NULL;
 
-	rte_free(vf->aq_resp);
-	vf->aq_resp = NULL;
-
 	rte_free(vf->qos_cap);
 	vf->qos_cap = NULL;
 
@@ -2997,9 +2987,6 @@ iavf_dev_close(struct rte_eth_dev *dev)
 	vf->vsi_res = NULL;
 	vf->vf_res = NULL;
 
-	rte_free(vf->aq_resp);
-	vf->aq_resp = NULL;
-
 	/*
 	 * If the VF is reset via VFLR, the device will be knocked out of bus
 	 * master mode, and the driver will fail to recover from the reset. Fix
diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 08dd6f2d7f..5e8ca20cf1 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -510,14 +510,11 @@ iavf_handle_virtchnl_msg(struct rte_eth_dev *dev)
 	uint16_t pending, aq_opc;
 	enum virtchnl_ops msg_opc;
 	enum iavf_status msg_ret;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	int ret;
 
-	info.buf_len = IAVF_AQ_BUF_SZ;
-	if (!vf->aq_resp) {
-		PMD_DRV_LOG(ERR, "Buffer for adminq resp should not be NULL");
-		return;
-	}
-	info.msg_buf = vf->aq_resp;
+	info.buf_len = sizeof(msg_buf);
+	info.msg_buf = msg_buf;
 
 	pending = 1;
 	while (pending) {
@@ -599,16 +596,16 @@ iavf_handle_virtchnl_msg(struct rte_eth_dev *dev)
 int
 iavf_enable_vlan_strip(struct iavf_adapter *adapter)
 {
-	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct iavf_cmd_info args;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	int ret;
 
 	memset(&args, 0, sizeof(args));
 	args.ops = VIRTCHNL_OP_ENABLE_VLAN_STRIPPING;
 	args.in_args = NULL;
 	args.in_args_size = 0;
-	args.out_buffer = vf->aq_resp;
-	args.out_size = IAVF_AQ_BUF_SZ;
+	args.out_buffer = msg_buf;
+	args.out_size = sizeof(msg_buf);
 	ret = iavf_execute_vf_cmd_safe(adapter, &args, 0);
 	if (ret)
 		PMD_DRV_LOG(ERR, "Failed to execute command of"
@@ -620,16 +617,16 @@ iavf_enable_vlan_strip(struct iavf_adapter *adapter)
 int
 iavf_disable_vlan_strip(struct iavf_adapter *adapter)
 {
-	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct iavf_cmd_info args;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	int ret;
 
 	memset(&args, 0, sizeof(args));
 	args.ops = VIRTCHNL_OP_DISABLE_VLAN_STRIPPING;
 	args.in_args = NULL;
 	args.in_args_size = 0;
-	args.out_buffer = vf->aq_resp;
-	args.out_size = IAVF_AQ_BUF_SZ;
+	args.out_buffer = msg_buf;
+	args.out_size = sizeof(msg_buf);
 	ret = iavf_execute_vf_cmd_safe(adapter, &args, 0);
 	if (ret)
 		PMD_DRV_LOG(ERR, "Failed to execute command of"
@@ -647,6 +644,7 @@ iavf_check_api_version(struct iavf_adapter *adapter)
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct virtchnl_version_info version, *pver;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct iavf_cmd_info args;
 	int err;
 
@@ -656,8 +654,8 @@ iavf_check_api_version(struct iavf_adapter *adapter)
 	args.ops = VIRTCHNL_OP_VERSION;
 	args.in_args = (uint8_t *)&version;
 	args.in_args_size = sizeof(version);
-	args.out_buffer = vf->aq_resp;
-	args.out_size = IAVF_AQ_BUF_SZ;
+	args.out_buffer = msg_buf;
+	args.out_size = sizeof(msg_buf);
 
 	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
 	if (err) {
@@ -697,12 +695,13 @@ iavf_get_vf_resource(struct iavf_adapter *adapter)
 	struct iavf_hw *hw = IAVF_DEV_PRIVATE_TO_HW(adapter);
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct iavf_cmd_info args;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	uint32_t caps, len;
 	int err, i;
 
 	args.ops = VIRTCHNL_OP_GET_VF_RESOURCES;
-	args.out_buffer = vf->aq_resp;
-	args.out_size = IAVF_AQ_BUF_SZ;
+	args.out_buffer = msg_buf;
+	args.out_size = sizeof(msg_buf);
 
 	caps = IAVF_BASIC_OFFLOAD_CAPS | VIRTCHNL_VF_CAP_ADV_LINK_SPEED |
 		VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC |
@@ -758,13 +757,14 @@ iavf_get_supported_rxdid(struct iavf_adapter *adapter)
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct iavf_cmd_info args;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	int ret;
 
 	args.ops = VIRTCHNL_OP_GET_SUPPORTED_RXDIDS;
 	args.in_args = NULL;
 	args.in_args_size = 0;
-	args.out_buffer = vf->aq_resp;
-	args.out_size = IAVF_AQ_BUF_SZ;
+	args.out_buffer = msg_buf;
+	args.out_size = sizeof(msg_buf);
 
 	ret = iavf_execute_vf_cmd_safe(adapter, &args, 0);
 	if (ret) {
@@ -785,6 +785,7 @@ iavf_config_vlan_strip_v2(struct iavf_adapter *adapter, bool enable)
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct virtchnl_vlan_supported_caps *stripping_caps;
 	struct virtchnl_vlan_setting vlan_strip;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct iavf_cmd_info args;
 	uint32_t *ethertype;
 	int ret;
@@ -808,8 +809,8 @@ iavf_config_vlan_strip_v2(struct iavf_adapter *adapter, bool enable)
 			    VIRTCHNL_OP_DISABLE_VLAN_STRIPPING_V2;
 	args.in_args = (uint8_t *)&vlan_strip;
 	args.in_args_size = sizeof(vlan_strip);
-	args.out_buffer = vf->aq_resp;
-	args.out_size = IAVF_AQ_BUF_SZ;
+	args.out_buffer = msg_buf;
+	args.out_size = sizeof(msg_buf);
 	ret = iavf_execute_vf_cmd_safe(adapter, &args, 0);
 	if (ret)
 		PMD_DRV_LOG(ERR, "fail to execute command %s",
@@ -825,6 +826,7 @@ iavf_config_vlan_insert_v2(struct iavf_adapter *adapter, bool enable)
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct virtchnl_vlan_supported_caps *insertion_caps;
 	struct virtchnl_vlan_setting vlan_insert;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct iavf_cmd_info args;
 	uint32_t *ethertype;
 	int ret;
@@ -848,8 +850,8 @@ iavf_config_vlan_insert_v2(struct iavf_adapter *adapter, bool enable)
 			    VIRTCHNL_OP_DISABLE_VLAN_INSERTION_V2;
 	args.in_args = (uint8_t *)&vlan_insert;
 	args.in_args_size = sizeof(vlan_insert);
-	args.out_buffer = vf->aq_resp;
-	args.out_size = IAVF_AQ_BUF_SZ;
+	args.out_buffer = msg_buf;
+	args.out_size = sizeof(msg_buf);
 	ret = iavf_execute_vf_cmd_safe(adapter, &args, 0);
 	if (ret)
 		PMD_DRV_LOG(ERR, "fail to execute command %s",
@@ -867,6 +869,7 @@ iavf_add_del_vlan_v2(struct iavf_adapter *adapter, uint16_t vlanid, bool add)
 	struct virtchnl_vlan_filter_list_v2 vlan_filter;
 	struct virtchnl_vlan *vlan_setting;
 	struct iavf_cmd_info args;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	uint32_t filtering_caps;
 	int err;
 
@@ -891,8 +894,8 @@ iavf_add_del_vlan_v2(struct iavf_adapter *adapter, uint16_t vlanid, bool add)
 	args.ops = add ? VIRTCHNL_OP_ADD_VLAN_V2 : VIRTCHNL_OP_DEL_VLAN_V2;
 	args.in_args = (uint8_t *)&vlan_filter;
 	args.in_args_size = sizeof(vlan_filter);
-	args.out_buffer = vf->aq_resp;
-	args.out_size = IAVF_AQ_BUF_SZ;
+	args.out_buffer = msg_buf;
+	args.out_size = sizeof(msg_buf);
 	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
 	if (err)
 		PMD_DRV_LOG(ERR, "fail to execute command %s",
@@ -906,13 +909,14 @@ iavf_get_vlan_offload_caps_v2(struct iavf_adapter *adapter)
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct iavf_cmd_info args;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	int ret;
 
 	args.ops = VIRTCHNL_OP_GET_OFFLOAD_VLAN_V2_CAPS;
 	args.in_args = NULL;
 	args.in_args_size = 0;
-	args.out_buffer = vf->aq_resp;
-	args.out_size = IAVF_AQ_BUF_SZ;
+	args.out_buffer = msg_buf;
+	args.out_size = sizeof(msg_buf);
 
 	ret = iavf_execute_vf_cmd_safe(adapter, &args, 0);
 	if (ret) {
@@ -921,7 +925,7 @@ iavf_get_vlan_offload_caps_v2(struct iavf_adapter *adapter)
 		return ret;
 	}
 
-	rte_memcpy(&vf->vlan_v2_caps, vf->aq_resp, sizeof(vf->vlan_v2_caps));
+	rte_memcpy(&vf->vlan_v2_caps, msg_buf, sizeof(vf->vlan_v2_caps));
 
 	return 0;
 }
@@ -932,6 +936,7 @@ iavf_enable_queues(struct iavf_adapter *adapter)
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct virtchnl_queue_select queue_select;
 	struct iavf_cmd_info args;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	int err;
 
 	memset(&queue_select, 0, sizeof(queue_select));
@@ -943,8 +948,8 @@ iavf_enable_queues(struct iavf_adapter *adapter)
 	args.ops = VIRTCHNL_OP_ENABLE_QUEUES;
 	args.in_args = (u8 *)&queue_select;
 	args.in_args_size = sizeof(queue_select);
-	args.out_buffer = vf->aq_resp;
-	args.out_size = IAVF_AQ_BUF_SZ;
+	args.out_buffer = msg_buf;
+	args.out_size = sizeof(msg_buf);
 	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
 	if (err) {
 		PMD_DRV_LOG(ERR,
@@ -960,6 +965,7 @@ iavf_disable_queues(struct iavf_adapter *adapter)
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct virtchnl_queue_select queue_select;
 	struct iavf_cmd_info args;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	int err;
 
 	memset(&queue_select, 0, sizeof(queue_select));
@@ -971,8 +977,8 @@ iavf_disable_queues(struct iavf_adapter *adapter)
 	args.ops = VIRTCHNL_OP_DISABLE_QUEUES;
 	args.in_args = (u8 *)&queue_select;
 	args.in_args_size = sizeof(queue_select);
-	args.out_buffer = vf->aq_resp;
-	args.out_size = IAVF_AQ_BUF_SZ;
+	args.out_buffer = msg_buf;
+	args.out_size = sizeof(msg_buf);
 	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
 	if (err) {
 		PMD_DRV_LOG(ERR,
@@ -989,6 +995,7 @@ iavf_switch_queue(struct iavf_adapter *adapter, uint16_t qid,
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct virtchnl_queue_select queue_select;
 	struct iavf_cmd_info args;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	int err;
 
 	if (adapter->closed)
@@ -1007,8 +1014,8 @@ iavf_switch_queue(struct iavf_adapter *adapter, uint16_t qid,
 		args.ops = VIRTCHNL_OP_DISABLE_QUEUES;
 	args.in_args = (u8 *)&queue_select;
 	args.in_args_size = sizeof(queue_select);
-	args.out_buffer = vf->aq_resp;
-	args.out_size = IAVF_AQ_BUF_SZ;
+	args.out_buffer = msg_buf;
+	args.out_size = sizeof(msg_buf);
 	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
 	if (err)
 		PMD_DRV_LOG(ERR, "Failed to execute command of %s",
@@ -1027,6 +1034,7 @@ iavf_enable_queues_lv(struct iavf_adapter *adapter)
 	struct virtchnl_del_ena_dis_queues *queue_select = &queue_req.msg;
 	struct virtchnl_queue_chunk *queue_chunk = queue_select->chunks.chunks;
 	struct iavf_cmd_info args;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	int err;
 
 	queue_select->chunks.num_chunks = IAVF_RXTX_QUEUE_CHUNKS_NUM;
@@ -1045,8 +1053,8 @@ iavf_enable_queues_lv(struct iavf_adapter *adapter)
 	args.ops = VIRTCHNL_OP_ENABLE_QUEUES_V2;
 	args.in_args = (u8 *)queue_select;
 	args.in_args_size = sizeof(queue_req);
-	args.out_buffer = vf->aq_resp;
-	args.out_size = IAVF_AQ_BUF_SZ;
+	args.out_buffer = msg_buf;
+	args.out_size = sizeof(msg_buf);
 	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
 	if (err)
 		PMD_DRV_LOG(ERR,
@@ -1066,6 +1074,7 @@ iavf_disable_queues_lv(struct iavf_adapter *adapter)
 	struct virtchnl_del_ena_dis_queues *queue_select = &queue_req.msg;
 	struct virtchnl_queue_chunk *queue_chunk = queue_select->chunks.chunks;
 	struct iavf_cmd_info args;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	int err;
 
 	queue_select->chunks.num_chunks = IAVF_RXTX_QUEUE_CHUNKS_NUM;
@@ -1084,8 +1093,8 @@ iavf_disable_queues_lv(struct iavf_adapter *adapter)
 	args.ops = VIRTCHNL_OP_DISABLE_QUEUES_V2;
 	args.in_args = (u8 *)queue_select;
 	args.in_args_size = sizeof(queue_req);
-	args.out_buffer = vf->aq_resp;
-	args.out_size = IAVF_AQ_BUF_SZ;
+	args.out_buffer = msg_buf;
+	args.out_size = sizeof(msg_buf);
 	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
 	if (err)
 		PMD_DRV_LOG(ERR,
@@ -1105,6 +1114,7 @@ iavf_switch_queue_lv(struct iavf_adapter *adapter, uint16_t qid,
 	struct virtchnl_del_ena_dis_queues *queue_select = &queue_req.msg;
 	struct virtchnl_queue_chunk *queue_chunk = queue_select->chunks.chunks;
 	struct iavf_cmd_info args;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	int err;
 
 	queue_select->chunks.num_chunks = 1;
@@ -1126,8 +1136,8 @@ iavf_switch_queue_lv(struct iavf_adapter *adapter, uint16_t qid,
 		args.ops = VIRTCHNL_OP_DISABLE_QUEUES_V2;
 	args.in_args = (u8 *)queue_select;
 	args.in_args_size = sizeof(queue_req);
-	args.out_buffer = vf->aq_resp;
-	args.out_size = IAVF_AQ_BUF_SZ;
+	args.out_buffer = msg_buf;
+	args.out_size = sizeof(msg_buf);
 	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
 	if (err)
 		PMD_DRV_LOG(ERR, "Failed to execute command of %s",
@@ -1142,6 +1152,7 @@ iavf_configure_rss_lut(struct iavf_adapter *adapter)
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct virtchnl_rss_lut *rss_lut;
 	struct iavf_cmd_info args;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	int len, err = 0;
 
 	len = sizeof(*rss_lut) + vf->vf_res->rss_lut_size - 1;
@@ -1156,8 +1167,8 @@ iavf_configure_rss_lut(struct iavf_adapter *adapter)
 	args.ops = VIRTCHNL_OP_CONFIG_RSS_LUT;
 	args.in_args = (u8 *)rss_lut;
 	args.in_args_size = len;
-	args.out_buffer = vf->aq_resp;
-	args.out_size = IAVF_AQ_BUF_SZ;
+	args.out_buffer = msg_buf;
+	args.out_size = sizeof(msg_buf);
 
 	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
 	if (err)
@@ -1174,6 +1185,7 @@ iavf_configure_rss_key(struct iavf_adapter *adapter)
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct virtchnl_rss_key *rss_key;
 	struct iavf_cmd_info args;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	int len, err = 0;
 
 	len = sizeof(*rss_key) + vf->vf_res->rss_key_size - 1;
@@ -1188,8 +1200,8 @@ iavf_configure_rss_key(struct iavf_adapter *adapter)
 	args.ops = VIRTCHNL_OP_CONFIG_RSS_KEY;
 	args.in_args = (u8 *)rss_key;
 	args.in_args_size = len;
-	args.out_buffer = vf->aq_resp;
-	args.out_size = IAVF_AQ_BUF_SZ;
+	args.out_buffer = msg_buf;
+	args.out_size = sizeof(msg_buf);
 
 	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
 	if (err)
@@ -1266,6 +1278,7 @@ iavf_configure_queue_chunk(struct iavf_adapter *adapter,
 	uint16_t chunk_end = chunk_start + chunk_sz;
 	uint16_t i;
 	size_t buf_len;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	int err;
 
 	if (chunk_sz > IAVF_CFG_Q_NUM_PER_BUF)
@@ -1284,8 +1297,8 @@ iavf_configure_queue_chunk(struct iavf_adapter *adapter,
 	args.ops = VIRTCHNL_OP_CONFIG_VSI_QUEUES;
 	args.in_args = (uint8_t *)vc_config;
 	args.in_args_size = buf_len;
-	args.out_buffer = vf->aq_resp;
-	args.out_size = IAVF_AQ_BUF_SZ;
+	args.out_buffer = msg_buf;
+	args.out_size = sizeof(msg_buf);
 
 	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
 	if (err)
@@ -1325,6 +1338,7 @@ iavf_config_irq_map(struct iavf_adapter *adapter)
 	} map_req = {0};
 	struct virtchnl_irq_map_info *map_info = &map_req.map_info;
 	struct iavf_cmd_info args = {0};
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	int i, err, max_vmi = -1;
 	size_t buf_len;
 
@@ -1368,8 +1382,8 @@ iavf_config_irq_map(struct iavf_adapter *adapter)
 	args.ops = VIRTCHNL_OP_CONFIG_IRQ_MAP;
 	args.in_args = (u8 *)map_info;
 	args.in_args_size = buf_len;
-	args.out_buffer = vf->aq_resp;
-	args.out_size = IAVF_AQ_BUF_SZ;
+	args.out_buffer = msg_buf;
+	args.out_size = sizeof(msg_buf);
 	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
 	if (err)
 		PMD_DRV_LOG(ERR, "fail to execute command OP_CONFIG_IRQ_MAP");
@@ -1391,6 +1405,7 @@ iavf_config_irq_map_lv_chunk(struct iavf_adapter *adapter,
 	struct virtchnl_queue_vector_maps *map_info = &chunk_req.map_info;
 	struct virtchnl_queue_vector *qv_maps = chunk_req.qv_maps;
 	size_t buf_len;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	uint16_t i;
 
 	if (chunk_sz > IAVF_CFG_Q_NUM_PER_BUF)
@@ -1413,8 +1428,8 @@ iavf_config_irq_map_lv_chunk(struct iavf_adapter *adapter,
 	args.ops = VIRTCHNL_OP_MAP_QUEUE_VECTOR;
 	args.in_args = (u8 *)map_info;
 	args.in_args_size = buf_len;
-	args.out_buffer = vf->aq_resp;
-	args.out_size = IAVF_AQ_BUF_SZ;
+	args.out_buffer = msg_buf;
+	args.out_size = sizeof(msg_buf);
 
 	return iavf_execute_vf_cmd_safe(adapter, &args, 0);
 }
@@ -1447,6 +1462,7 @@ iavf_add_del_all_mac_addr(struct iavf_adapter *adapter, bool add)
 	struct virtchnl_ether_addr_list *list = &list_req.list;
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct iavf_cmd_info args = {0};
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	int err, i;
 	size_t buf_len;
 
@@ -1473,8 +1489,8 @@ iavf_add_del_all_mac_addr(struct iavf_adapter *adapter, bool add)
 	args.ops = add ? VIRTCHNL_OP_ADD_ETH_ADDR : VIRTCHNL_OP_DEL_ETH_ADDR;
 	args.in_args = (uint8_t *)list;
 	args.in_args_size = buf_len;
-	args.out_buffer = vf->aq_resp;
-	args.out_size = IAVF_AQ_BUF_SZ;
+	args.out_buffer = msg_buf;
+	args.out_size = sizeof(msg_buf);
 	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
 	if (err)
 		PMD_DRV_LOG(ERR, "fail to execute command %s",
@@ -1488,6 +1504,7 @@ iavf_query_stats(struct iavf_adapter *adapter,
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct virtchnl_queue_select q_stats;
 	struct iavf_cmd_info args;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	int err;
 
 	if (adapter->closed)
@@ -1498,8 +1515,8 @@ iavf_query_stats(struct iavf_adapter *adapter,
 	args.ops = VIRTCHNL_OP_GET_STATS;
 	args.in_args = (uint8_t *)&q_stats;
 	args.in_args_size = sizeof(q_stats);
-	args.out_buffer = vf->aq_resp;
-	args.out_size = IAVF_AQ_BUF_SZ;
+	args.out_buffer = msg_buf;
+	args.out_size = sizeof(msg_buf);
 
 	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
 	if (err) {
@@ -1519,6 +1536,7 @@ iavf_config_promisc(struct iavf_adapter *adapter,
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct virtchnl_promisc_info promisc;
 	struct iavf_cmd_info args;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	int err;
 
 	if (adapter->closed)
@@ -1536,8 +1554,8 @@ iavf_config_promisc(struct iavf_adapter *adapter,
 	args.ops = VIRTCHNL_OP_CONFIG_PROMISCUOUS_MODE;
 	args.in_args = (uint8_t *)&promisc;
 	args.in_args_size = sizeof(promisc);
-	args.out_buffer = vf->aq_resp;
-	args.out_size = IAVF_AQ_BUF_SZ;
+	args.out_buffer = msg_buf;
+	args.out_size = sizeof(msg_buf);
 
 	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
 
@@ -1565,6 +1583,7 @@ iavf_add_del_eth_addr(struct iavf_adapter *adapter, struct rte_ether_addr *addr,
 	uint8_t cmd_buffer[sizeof(struct virtchnl_ether_addr_list) +
 			   sizeof(struct virtchnl_ether_addr)];
 	struct iavf_cmd_info args;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	int err;
 
 	if (adapter->closed)
@@ -1580,8 +1599,8 @@ iavf_add_del_eth_addr(struct iavf_adapter *adapter, struct rte_ether_addr *addr,
 	args.ops = add ? VIRTCHNL_OP_ADD_ETH_ADDR : VIRTCHNL_OP_DEL_ETH_ADDR;
 	args.in_args = cmd_buffer;
 	args.in_args_size = sizeof(cmd_buffer);
-	args.out_buffer = vf->aq_resp;
-	args.out_size = IAVF_AQ_BUF_SZ;
+	args.out_buffer = msg_buf;
+	args.out_size = sizeof(msg_buf);
 	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
 	if (err)
 		PMD_DRV_LOG(ERR, "fail to execute command %s",
@@ -1597,6 +1616,7 @@ iavf_add_del_vlan(struct iavf_adapter *adapter, uint16_t vlanid, bool add)
 	uint8_t cmd_buffer[sizeof(struct virtchnl_vlan_filter_list) +
 							sizeof(uint16_t)];
 	struct iavf_cmd_info args;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	int err;
 
 	vlan_list = (struct virtchnl_vlan_filter_list *)cmd_buffer;
@@ -1607,8 +1627,8 @@ iavf_add_del_vlan(struct iavf_adapter *adapter, uint16_t vlanid, bool add)
 	args.ops = add ? VIRTCHNL_OP_ADD_VLAN : VIRTCHNL_OP_DEL_VLAN;
 	args.in_args = cmd_buffer;
 	args.in_args_size = sizeof(cmd_buffer);
-	args.out_buffer = vf->aq_resp;
-	args.out_size = IAVF_AQ_BUF_SZ;
+	args.out_buffer = msg_buf;
+	args.out_size = sizeof(msg_buf);
 	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
 	if (err)
 		PMD_DRV_LOG(ERR, "fail to execute command %s",
@@ -1625,6 +1645,7 @@ iavf_fdir_add(struct iavf_adapter *adapter,
 	struct virtchnl_fdir_add *fdir_ret;
 
 	struct iavf_cmd_info args;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	int err;
 
 	filter->add_fltr.vsi_id = vf->vsi_res->vsi_id;
@@ -1633,8 +1654,8 @@ iavf_fdir_add(struct iavf_adapter *adapter,
 	args.ops = VIRTCHNL_OP_ADD_FDIR_FILTER;
 	args.in_args = (uint8_t *)(&filter->add_fltr);
 	args.in_args_size = sizeof(*(&filter->add_fltr));
-	args.out_buffer = vf->aq_resp;
-	args.out_size = IAVF_AQ_BUF_SZ;
+	args.out_buffer = msg_buf;
+	args.out_size = sizeof(msg_buf);
 
 	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
 	if (err) {
@@ -1685,6 +1706,7 @@ iavf_fdir_del(struct iavf_adapter *adapter,
 	struct virtchnl_fdir_del *fdir_ret;
 
 	struct iavf_cmd_info args;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	int err;
 
 	filter->del_fltr.vsi_id = vf->vsi_res->vsi_id;
@@ -1693,8 +1715,8 @@ iavf_fdir_del(struct iavf_adapter *adapter,
 	args.ops = VIRTCHNL_OP_DEL_FDIR_FILTER;
 	args.in_args = (uint8_t *)(&filter->del_fltr);
 	args.in_args_size = sizeof(filter->del_fltr);
-	args.out_buffer = vf->aq_resp;
-	args.out_size = IAVF_AQ_BUF_SZ;
+	args.out_buffer = msg_buf;
+	args.out_size = sizeof(msg_buf);
 
 	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
 	if (err) {
@@ -1732,6 +1754,7 @@ iavf_fdir_check(struct iavf_adapter *adapter,
 	struct virtchnl_fdir_add *fdir_ret;
 
 	struct iavf_cmd_info args;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	int err;
 
 	filter->add_fltr.vsi_id = vf->vsi_res->vsi_id;
@@ -1740,8 +1763,8 @@ iavf_fdir_check(struct iavf_adapter *adapter,
 	args.ops = VIRTCHNL_OP_ADD_FDIR_FILTER;
 	args.in_args = (uint8_t *)(&filter->add_fltr);
 	args.in_args_size = sizeof(*(&filter->add_fltr));
-	args.out_buffer = vf->aq_resp;
-	args.out_size = IAVF_AQ_BUF_SZ;
+	args.out_buffer = msg_buf;
+	args.out_size = sizeof(msg_buf);
 
 	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
 	if (err) {
@@ -1774,6 +1797,7 @@ iavf_flow_sub(struct iavf_adapter *adapter, struct iavf_fsub_conf *filter)
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct virtchnl_flow_sub *fsub_cfg;
 	struct iavf_cmd_info args;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	int err;
 
 	filter->sub_fltr.vsi_id = vf->vsi_res->vsi_id;
@@ -1783,8 +1807,8 @@ iavf_flow_sub(struct iavf_adapter *adapter, struct iavf_fsub_conf *filter)
 	args.ops = VIRTCHNL_OP_FLOW_SUBSCRIBE;
 	args.in_args = (uint8_t *)(&filter->sub_fltr);
 	args.in_args_size = sizeof(*(&filter->sub_fltr));
-	args.out_buffer = vf->aq_resp;
-	args.out_size = IAVF_AQ_BUF_SZ;
+	args.out_buffer = msg_buf;
+	args.out_size = sizeof(msg_buf);
 
 	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
 	if (err) {
@@ -1825,6 +1849,7 @@ iavf_flow_unsub(struct iavf_adapter *adapter, struct iavf_fsub_conf *filter)
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct virtchnl_flow_unsub *unsub_cfg;
 	struct iavf_cmd_info args;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	int err;
 
 	filter->unsub_fltr.vsi_id = vf->vsi_res->vsi_id;
@@ -1834,8 +1859,8 @@ iavf_flow_unsub(struct iavf_adapter *adapter, struct iavf_fsub_conf *filter)
 	args.ops = VIRTCHNL_OP_FLOW_UNSUBSCRIBE;
 	args.in_args = (uint8_t *)(&filter->unsub_fltr);
 	args.in_args_size = sizeof(filter->unsub_fltr);
-	args.out_buffer = vf->aq_resp;
-	args.out_size = IAVF_AQ_BUF_SZ;
+	args.out_buffer = msg_buf;
+	args.out_size = sizeof(msg_buf);
 
 	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
 	if (err) {
@@ -1869,6 +1894,7 @@ iavf_flow_sub_check(struct iavf_adapter *adapter,
 	struct virtchnl_flow_sub *fsub_cfg;
 
 	struct iavf_cmd_info args;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	int err;
 
 	filter->sub_fltr.vsi_id = vf->vsi_res->vsi_id;
@@ -1877,8 +1903,8 @@ iavf_flow_sub_check(struct iavf_adapter *adapter,
 	args.ops = VIRTCHNL_OP_FLOW_SUBSCRIBE;
 	args.in_args = (uint8_t *)(&filter->sub_fltr);
 	args.in_args_size = sizeof(*(&filter->sub_fltr));
-	args.out_buffer = vf->aq_resp;
-	args.out_size = IAVF_AQ_BUF_SZ;
+	args.out_buffer = msg_buf;
+	args.out_size = sizeof(msg_buf);
 
 	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
 	if (err) {
@@ -1908,8 +1934,8 @@ int
 iavf_add_del_rss_cfg(struct iavf_adapter *adapter,
 		     struct virtchnl_rss_cfg *rss_cfg, bool add)
 {
-	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct iavf_cmd_info args;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	int err;
 
 	memset(&args, 0, sizeof(args));
@@ -1917,8 +1943,8 @@ iavf_add_del_rss_cfg(struct iavf_adapter *adapter,
 		VIRTCHNL_OP_DEL_RSS_CFG;
 	args.in_args = (u8 *)rss_cfg;
 	args.in_args_size = sizeof(*rss_cfg);
-	args.out_buffer = vf->aq_resp;
-	args.out_size = IAVF_AQ_BUF_SZ;
+	args.out_buffer = msg_buf;
+	args.out_size = sizeof(msg_buf);
 
 	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
 	if (err)
@@ -1933,15 +1959,15 @@ iavf_add_del_rss_cfg(struct iavf_adapter *adapter,
 int
 iavf_get_hena_caps(struct iavf_adapter *adapter, uint64_t *caps)
 {
-	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct iavf_cmd_info args;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	int err;
 
 	args.ops = VIRTCHNL_OP_GET_RSS_HENA_CAPS;
 	args.in_args = NULL;
 	args.in_args_size = 0;
-	args.out_buffer = vf->aq_resp;
-	args.out_size = IAVF_AQ_BUF_SZ;
+	args.out_buffer = msg_buf;
+	args.out_size = sizeof(msg_buf);
 
 	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
 	if (err) {
@@ -1957,17 +1983,17 @@ iavf_get_hena_caps(struct iavf_adapter *adapter, uint64_t *caps)
 int
 iavf_set_hena(struct iavf_adapter *adapter, uint64_t hena)
 {
-	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct virtchnl_rss_hena vrh;
 	struct iavf_cmd_info args;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	int err;
 
 	vrh.hena = hena;
 	args.ops = VIRTCHNL_OP_SET_RSS_HENA;
 	args.in_args = (u8 *)&vrh;
 	args.in_args_size = sizeof(vrh);
-	args.out_buffer = vf->aq_resp;
-	args.out_size = IAVF_AQ_BUF_SZ;
+	args.out_buffer = msg_buf;
+	args.out_size = sizeof(msg_buf);
 
 	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
 	if (err)
@@ -1982,14 +2008,15 @@ iavf_get_qos_cap(struct iavf_adapter *adapter)
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct iavf_cmd_info args;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	uint32_t len;
 	int err;
 
 	args.ops = VIRTCHNL_OP_GET_QOS_CAPS;
 	args.in_args = NULL;
 	args.in_args_size = 0;
-	args.out_buffer = vf->aq_resp;
-	args.out_size = IAVF_AQ_BUF_SZ;
+	args.out_buffer = msg_buf;
+	args.out_size = sizeof(msg_buf);
 	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
 
 	if (err) {
@@ -2012,16 +2039,16 @@ int iavf_set_q_tc_map(struct rte_eth_dev *dev,
 {
 	struct iavf_adapter *adapter =
 			IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
-	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(dev->data->dev_private);
 	struct iavf_cmd_info args;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	int err;
 
 	memset(&args, 0, sizeof(args));
 	args.ops = VIRTCHNL_OP_CONFIG_QUEUE_TC_MAP;
 	args.in_args = (uint8_t *)q_tc_mapping;
 	args.in_args_size = size;
-	args.out_buffer = vf->aq_resp;
-	args.out_size = IAVF_AQ_BUF_SZ;
+	args.out_buffer = msg_buf;
+	args.out_size = sizeof(msg_buf);
 
 	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
 	if (err)
@@ -2035,16 +2062,16 @@ int iavf_set_q_bw(struct rte_eth_dev *dev,
 {
 	struct iavf_adapter *adapter =
 			IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
-	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(dev->data->dev_private);
 	struct iavf_cmd_info args;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	int err;
 
 	memset(&args, 0, sizeof(args));
 	args.ops = VIRTCHNL_OP_CONFIG_QUEUE_BW;
 	args.in_args = (uint8_t *)q_bw;
 	args.in_args_size = size;
-	args.out_buffer = vf->aq_resp;
-	args.out_size = IAVF_AQ_BUF_SZ;
+	args.out_buffer = msg_buf;
+	args.out_size = sizeof(msg_buf);
 
 	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
 	if (err)
@@ -2063,6 +2090,7 @@ iavf_add_del_mc_addr_list(struct iavf_adapter *adapter,
 		(IAVF_NUM_MACADDR_MAX * sizeof(struct virtchnl_ether_addr))];
 	struct virtchnl_ether_addr_list *list;
 	struct iavf_cmd_info args;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	uint32_t i;
 	int err;
 
@@ -2089,8 +2117,8 @@ iavf_add_del_mc_addr_list(struct iavf_adapter *adapter,
 	args.in_args = cmd_buffer;
 	args.in_args_size = sizeof(struct virtchnl_ether_addr_list) +
 		i * sizeof(struct virtchnl_ether_addr);
-	args.out_buffer = vf->aq_resp;
-	args.out_size = IAVF_AQ_BUF_SZ;
+	args.out_buffer = msg_buf;
+	args.out_size = sizeof(msg_buf);
 	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
 
 	if (err) {
@@ -2110,6 +2138,7 @@ iavf_request_queues(struct rte_eth_dev *dev, uint16_t num)
 	struct iavf_info *vf =  IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct virtchnl_vf_res_request vfres;
 	struct iavf_cmd_info args;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	uint16_t num_queue_pairs;
 	int err;
 	int i = 0;
@@ -2129,8 +2158,8 @@ iavf_request_queues(struct rte_eth_dev *dev, uint16_t num)
 	args.ops = VIRTCHNL_OP_REQUEST_QUEUES;
 	args.in_args = (u8 *)&vfres;
 	args.in_args_size = sizeof(vfres);
-	args.out_buffer = vf->aq_resp;
-	args.out_size = IAVF_AQ_BUF_SZ;
+	args.out_buffer = msg_buf;
+	args.out_size = sizeof(msg_buf);
 
 	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_WB_ON_ITR) {
 		err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
@@ -2173,14 +2202,15 @@ iavf_get_max_rss_queue_region(struct iavf_adapter *adapter)
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct iavf_cmd_info args;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	uint16_t qregion_width;
 	int err;
 
 	args.ops = VIRTCHNL_OP_GET_MAX_RSS_QREGION;
 	args.in_args = NULL;
 	args.in_args_size = 0;
-	args.out_buffer = vf->aq_resp;
-	args.out_size = IAVF_AQ_BUF_SZ;
+	args.out_buffer = msg_buf;
+	args.out_size = sizeof(msg_buf);
 
 	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
 	if (err) {
@@ -2203,15 +2233,15 @@ iavf_ipsec_crypto_request(struct iavf_adapter *adapter,
 		uint8_t *msg, size_t msg_len,
 		uint8_t *resp_msg, size_t resp_msg_len)
 {
-	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct iavf_cmd_info args;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	int err;
 
 	args.ops = VIRTCHNL_OP_INLINE_IPSEC_CRYPTO;
 	args.in_args = msg;
 	args.in_args_size = msg_len;
-	args.out_buffer = vf->aq_resp;
-	args.out_size = IAVF_AQ_BUF_SZ;
+	args.out_buffer = msg_buf;
+	args.out_size = sizeof(msg_buf);
 
 	err = iavf_execute_vf_cmd_safe(adapter, &args, 1);
 	if (err) {
@@ -2228,9 +2258,9 @@ iavf_ipsec_crypto_request(struct iavf_adapter *adapter,
 int
 iavf_set_vf_quanta_size(struct iavf_adapter *adapter, u16 start_queue_id, u16 num_queues)
 {
-	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct iavf_cmd_info args;
 	struct virtchnl_quanta_cfg q_quanta;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	int err;
 
 	if (adapter->devargs.quanta_size == 0)
@@ -2244,8 +2274,8 @@ iavf_set_vf_quanta_size(struct iavf_adapter *adapter, u16 start_queue_id, u16 nu
 	args.ops = VIRTCHNL_OP_CONFIG_QUANTA;
 	args.in_args = (uint8_t *)&q_quanta;
 	args.in_args_size = sizeof(q_quanta);
-	args.out_buffer = vf->aq_resp;
-	args.out_size = IAVF_AQ_BUF_SZ;
+	args.out_buffer = msg_buf;
+	args.out_size = sizeof(msg_buf);
 
 	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
 	if (err) {
@@ -2262,6 +2292,7 @@ iavf_get_ptp_cap(struct iavf_adapter *adapter)
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct virtchnl_ptp_caps ptp_caps;
 	struct iavf_cmd_info args;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	int err;
 
 	ptp_caps.caps = VIRTCHNL_1588_PTP_CAP_RX_TSTAMP |
@@ -2270,8 +2301,8 @@ iavf_get_ptp_cap(struct iavf_adapter *adapter)
 	args.ops = VIRTCHNL_OP_1588_PTP_GET_CAPS;
 	args.in_args = (uint8_t *)&ptp_caps;
 	args.in_args_size = sizeof(ptp_caps);
-	args.out_buffer = vf->aq_resp;
-	args.out_size = IAVF_AQ_BUF_SZ;
+	args.out_buffer = msg_buf;
+	args.out_size = sizeof(msg_buf);
 
 	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
 	if (err) {
@@ -2292,13 +2323,14 @@ iavf_get_phc_time(struct ci_rx_queue *rxq)
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct virtchnl_phc_time phc_time;
 	struct iavf_cmd_info args;
+	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	int err = 0;
 
 	args.ops = VIRTCHNL_OP_1588_PTP_GET_TIME;
 	args.in_args = (uint8_t *)&phc_time;
 	args.in_args_size = sizeof(phc_time);
-	args.out_buffer = vf->aq_resp;
-	args.out_size = IAVF_AQ_BUF_SZ;
+	args.out_buffer = msg_buf;
+	args.out_size = sizeof(msg_buf);
 
 	rte_spinlock_lock(&vf->phc_time_aq_lock);
 	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
-- 
2.47.3

