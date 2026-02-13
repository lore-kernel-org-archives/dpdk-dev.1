Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498B1EDF14F
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 10:29:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7C4E40DD6;
	Fri, 13 Feb 2026 11:27:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id C973340B8F
 for <dev@dpdk.org>; Fri, 13 Feb 2026 11:27:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770978438; x=1802514438;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=9CTzHKCe7rViDpbsl7FE4iVs2eEyGk8Q+lqJlidA/2U=;
 b=PfrSX7Knlcqc82kYjLlN5cBn4+iRBTow/W7jy7CsWzOd2doYAjq6VZhm
 Jr7X+qbA8EtQNy3R8usyGxxDS3Iy8JJrsyWyPH90i/HqDXRTJ3hnB4rjG
 oPUGex742w1z5bShVslZpmjPRf7edxnE47gSlS+1um4Y63UYwsRGMkOV6
 I4/M5e8zyTdTfR1ODJsjkhoZfmxE8l5P/LawBPb0xmCB0imPrqQIADvor
 VdJf0zKX04ecgosSlIJ0Ef9OPg1ZsiFi+8av9ofXkFeiWqfsaF2S+Axmy
 /TJisQUCQ6CpwF35BRuV8kPJQU1+l8xqbOkMFptyQzpPtOFSQ0asYZZC7 A==;
X-CSE-ConnectionGUID: e9/CBwWJSoSPKaA1xj3BBQ==
X-CSE-MsgGUID: 2mEEixpqTTS3+ijzKGfCRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="83603113"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="83603113"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 02:27:17 -0800
X-CSE-ConnectionGUID: lR3y2/nWTTifmU+EnaeFgw==
X-CSE-MsgGUID: RYlfQAbvTwKjHQUyY+RvOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="217028137"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 13 Feb 2026 02:27:17 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v4 22/27] net/iavf: avoid rte malloc in queue operations
Date: Fri, 13 Feb 2026 10:26:33 +0000
Message-ID: <869fa36c643d5f9da0bd4992fc179914eff53a93.1770978324.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770978324.git.anatoly.burakov@intel.com>
 <cover.1770978324.git.anatoly.burakov@intel.com>
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

Currently, when enabling, disabling, or switching queues, we are using
rte_malloc followed by an immediate rte_free. This is not needed as these
structures are not being stored anywhere, so replace them with stack
allocation or malloc/free where appropriate.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_vchnl.c | 65 ++++++++++++-----------------
 1 file changed, 26 insertions(+), 39 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 19dce17612..af1f5fbfc0 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -1020,19 +1020,15 @@ int
 iavf_enable_queues_lv(struct iavf_adapter *adapter)
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
-	struct virtchnl_del_ena_dis_queues *queue_select;
-	struct virtchnl_queue_chunk *queue_chunk;
+	struct {
+		struct virtchnl_del_ena_dis_queues msg;
+		struct virtchnl_queue_chunk chunks[IAVF_RXTX_QUEUE_CHUNKS_NUM - 1];
+	} queue_req = {0};
+	struct virtchnl_del_ena_dis_queues *queue_select = &queue_req.msg;
+	struct virtchnl_queue_chunk *queue_chunk = queue_select->chunks.chunks;
 	struct iavf_cmd_info args;
-	int err, len;
+	int err;
 
-	len = sizeof(struct virtchnl_del_ena_dis_queues) +
-		  sizeof(struct virtchnl_queue_chunk) *
-		  (IAVF_RXTX_QUEUE_CHUNKS_NUM - 1);
-	queue_select = rte_zmalloc("queue_select", len, 0);
-	if (!queue_select)
-		return -ENOMEM;
-
-	queue_chunk = queue_select->chunks.chunks;
 	queue_select->chunks.num_chunks = IAVF_RXTX_QUEUE_CHUNKS_NUM;
 	queue_select->vport_id = vf->vsi_res->vsi_id;
 
@@ -1048,7 +1044,7 @@ iavf_enable_queues_lv(struct iavf_adapter *adapter)
 
 	args.ops = VIRTCHNL_OP_ENABLE_QUEUES_V2;
 	args.in_args = (u8 *)queue_select;
-	args.in_args_size = len;
+	args.in_args_size = sizeof(queue_req);
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
 	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
@@ -1056,7 +1052,6 @@ iavf_enable_queues_lv(struct iavf_adapter *adapter)
 		PMD_DRV_LOG(ERR,
 			    "Failed to execute command of OP_ENABLE_QUEUES_V2");
 
-	rte_free(queue_select);
 	return err;
 }
 
@@ -1064,19 +1059,15 @@ int
 iavf_disable_queues_lv(struct iavf_adapter *adapter)
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
-	struct virtchnl_del_ena_dis_queues *queue_select;
-	struct virtchnl_queue_chunk *queue_chunk;
+	struct {
+		struct virtchnl_del_ena_dis_queues msg;
+		struct virtchnl_queue_chunk chunks[IAVF_RXTX_QUEUE_CHUNKS_NUM - 1];
+	} queue_req = {0};
+	struct virtchnl_del_ena_dis_queues *queue_select = &queue_req.msg;
+	struct virtchnl_queue_chunk *queue_chunk = queue_select->chunks.chunks;
 	struct iavf_cmd_info args;
-	int err, len;
+	int err;
 
-	len = sizeof(struct virtchnl_del_ena_dis_queues) +
-		  sizeof(struct virtchnl_queue_chunk) *
-		  (IAVF_RXTX_QUEUE_CHUNKS_NUM - 1);
-	queue_select = rte_zmalloc("queue_select", len, 0);
-	if (!queue_select)
-		return -ENOMEM;
-
-	queue_chunk = queue_select->chunks.chunks;
 	queue_select->chunks.num_chunks = IAVF_RXTX_QUEUE_CHUNKS_NUM;
 	queue_select->vport_id = vf->vsi_res->vsi_id;
 
@@ -1092,7 +1083,7 @@ iavf_disable_queues_lv(struct iavf_adapter *adapter)
 
 	args.ops = VIRTCHNL_OP_DISABLE_QUEUES_V2;
 	args.in_args = (u8 *)queue_select;
-	args.in_args_size = len;
+	args.in_args_size = sizeof(queue_req);
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
 	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
@@ -1100,7 +1091,6 @@ iavf_disable_queues_lv(struct iavf_adapter *adapter)
 		PMD_DRV_LOG(ERR,
 			    "Failed to execute command of OP_DISABLE_QUEUES_V2");
 
-	rte_free(queue_select);
 	return err;
 }
 
@@ -1109,17 +1099,15 @@ iavf_switch_queue_lv(struct iavf_adapter *adapter, uint16_t qid,
 		 bool rx, bool on)
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
-	struct virtchnl_del_ena_dis_queues *queue_select;
-	struct virtchnl_queue_chunk *queue_chunk;
+	struct {
+		struct virtchnl_del_ena_dis_queues msg;
+		struct virtchnl_queue_chunk chunks[IAVF_RXTX_QUEUE_CHUNKS_NUM - 1];
+	} queue_req;
+	struct virtchnl_del_ena_dis_queues *queue_select = &queue_req.msg;
+	struct virtchnl_queue_chunk *queue_chunk = queue_select->chunks.chunks;
 	struct iavf_cmd_info args;
-	int err, len;
+	int err;
 
-	len = sizeof(struct virtchnl_del_ena_dis_queues);
-	queue_select = rte_zmalloc("queue_select", len, 0);
-	if (!queue_select)
-		return -ENOMEM;
-
-	queue_chunk = queue_select->chunks.chunks;
 	queue_select->chunks.num_chunks = 1;
 	queue_select->vport_id = vf->vsi_res->vsi_id;
 
@@ -1138,7 +1126,7 @@ iavf_switch_queue_lv(struct iavf_adapter *adapter, uint16_t qid,
 	else
 		args.ops = VIRTCHNL_OP_DISABLE_QUEUES_V2;
 	args.in_args = (u8 *)queue_select;
-	args.in_args_size = len;
+	args.in_args_size = sizeof(queue_req);
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
 	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
@@ -1146,7 +1134,6 @@ iavf_switch_queue_lv(struct iavf_adapter *adapter, uint16_t qid,
 		PMD_DRV_LOG(ERR, "Failed to execute command of %s",
 			    on ? "OP_ENABLE_QUEUES_V2" : "OP_DISABLE_QUEUES_V2");
 
-	rte_free(queue_select);
 	return err;
 }
 
@@ -1229,7 +1216,7 @@ iavf_configure_queues(struct iavf_adapter *adapter,
 
 	size = sizeof(*vc_config) +
 	       sizeof(vc_config->qpair[0]) * num_queue_pairs;
-	vc_config = rte_zmalloc("cfg_queue", size, 0);
+	vc_config = calloc(1, size);
 	if (!vc_config)
 		return -ENOMEM;
 
@@ -1292,7 +1279,7 @@ iavf_configure_queues(struct iavf_adapter *adapter,
 		PMD_DRV_LOG(ERR, "Failed to execute command of"
 			    " VIRTCHNL_OP_CONFIG_VSI_QUEUES");
 
-	rte_free(vc_config);
+	free(vc_config);
 	return err;
 }
 
-- 
2.47.3

