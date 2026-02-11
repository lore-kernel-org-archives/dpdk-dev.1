Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9072AE9E30A
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 13:56:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7DC0440E1C;
	Wed, 11 Feb 2026 14:54:03 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 49E9A40DFB
 for <dev@dpdk.org>; Wed, 11 Feb 2026 14:53:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770818039; x=1802354039;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=9CTzHKCe7rViDpbsl7FE4iVs2eEyGk8Q+lqJlidA/2U=;
 b=Ja4TPxPxG7mQAwsJbdGjIBuwff0WKu7hZ9qdpjaGtEpYPkpvjJqCze2F
 YW5IVZxJGYbHY6iUpwff3X1kCmh634S5XD4634ZTwkoGiC4HdIEN7teiN
 yqN+8spo8SqhYCG2Cr4IzHXkoCXbBbdodWUPCATGp2s8ZfMpnEbC69dbn
 TzmkMgaJ4pXTS0FfL5SX0VuPd5vBETIA4j/5ERBoABKsViuhrrPscfrp4
 XuyiLsQGTqtR6AxyBWK9WErkYxes/WHcSuDqP6isLV9BXnW087oMUprnr
 CeQ6b4H4Gb+BZnd49vdEH5886gdSxg+RTV59rjT+0fycWxRTAiV8YOKLQ A==;
X-CSE-ConnectionGUID: NF0SRp2bSCq2XbZkTTpJLw==
X-CSE-MsgGUID: +IjSHKmeST+okueWXJdCCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75808272"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="75808272"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 05:53:58 -0800
X-CSE-ConnectionGUID: GdFqdvOeSB6Op2jY99BtTw==
X-CSE-MsgGUID: +nwxiHzVQ5K6nYsHU7yCcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="212359677"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa007.jf.intel.com with ESMTP; 11 Feb 2026 05:53:58 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v3 22/27] net/iavf: avoid rte malloc in queue operations
Date: Wed, 11 Feb 2026 13:53:04 +0000
Message-ID: <d9b93f692da3107e492d95b3b5dbba711ab9de7d.1770817884.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770817884.git.anatoly.burakov@intel.com>
 <cover.1770817884.git.anatoly.burakov@intel.com>
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

