Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A085E6817A
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 12:17:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 830BF4064F;
	Tue, 17 Feb 2026 13:15:16 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 4FCC840B8D
 for <dev@dpdk.org>; Tue, 17 Feb 2026 13:15:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771330504; x=1802866504;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=c4UuYkbbsqoCtdaITKXAh9aYUwImHerZmreZWrCjNAc=;
 b=jYVPmygQCtb6KfCgpK+rMfCXSNnHr8RWd4zMdJ/PCr6ipZY3FJCb8H8d
 hnorTiZTd4DksoeamL34FMziBVENv6e0ECsuzS8Ddp7I+Q3/nBW+6iRJq
 t22a8KRn1Dul8p/brdJKjo2eTv5e+7ELzzgsltmAXU0V5ZEt47F5WVgg0
 6uewvwwMjQCwP6tNCA/Qpe+fDKfKpbIw/LsaQrZH9qZqZUkMUFgA/ADZ6
 SzbRcDYtPwMD69uRR1Y37lDvOb7HGLn2fx68Ku0LR3E3HU2qKB2kMy6jc
 KHSpTHEZ8UHtZsB2mifX6XuJUKv0rwXU4xFJqsrVW7gffzz5cug7d5DLO w==;
X-CSE-ConnectionGUID: H2+MPeK5TLqiplcRshXAHw==
X-CSE-MsgGUID: wgTaYuK+RH+lAVVFdFbJ8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="74996058"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="74996058"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 04:15:04 -0800
X-CSE-ConnectionGUID: tZfniMjfRSqsqLUOqjHh1g==
X-CSE-MsgGUID: cNi324VgTfqqH1izX/NjWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="218396841"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 17 Feb 2026 04:15:04 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v5 22/27] net/iavf: avoid rte malloc in queue operations
Date: Tue, 17 Feb 2026 12:14:11 +0000
Message-ID: <e601cb4ddfe7b9415addc4d68ce58dbf8aa4b671.1771330391.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771330390.git.anatoly.burakov@intel.com>
 <cover.1771330390.git.anatoly.burakov@intel.com>
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
 drivers/net/intel/iavf/iavf_vchnl.c | 64 +++++++++++------------------
 1 file changed, 25 insertions(+), 39 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 19dce17612..a947ff92cf 100644
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
 
@@ -1109,17 +1099,14 @@ iavf_switch_queue_lv(struct iavf_adapter *adapter, uint16_t qid,
 		 bool rx, bool on)
 {
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
-	struct virtchnl_del_ena_dis_queues *queue_select;
-	struct virtchnl_queue_chunk *queue_chunk;
+	struct {
+		struct virtchnl_del_ena_dis_queues msg;
+	} queue_req = {0};
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
 
@@ -1138,7 +1125,7 @@ iavf_switch_queue_lv(struct iavf_adapter *adapter, uint16_t qid,
 	else
 		args.ops = VIRTCHNL_OP_DISABLE_QUEUES_V2;
 	args.in_args = (u8 *)queue_select;
-	args.in_args_size = len;
+	args.in_args_size = sizeof(queue_req);
 	args.out_buffer = vf->aq_resp;
 	args.out_size = IAVF_AQ_BUF_SZ;
 	err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
@@ -1146,7 +1133,6 @@ iavf_switch_queue_lv(struct iavf_adapter *adapter, uint16_t qid,
 		PMD_DRV_LOG(ERR, "Failed to execute command of %s",
 			    on ? "OP_ENABLE_QUEUES_V2" : "OP_DISABLE_QUEUES_V2");
 
-	rte_free(queue_select);
 	return err;
 }
 
@@ -1229,7 +1215,7 @@ iavf_configure_queues(struct iavf_adapter *adapter,
 
 	size = sizeof(*vc_config) +
 	       sizeof(vc_config->qpair[0]) * num_queue_pairs;
-	vc_config = rte_zmalloc("cfg_queue", size, 0);
+	vc_config = calloc(1, size);
 	if (!vc_config)
 		return -ENOMEM;
 
@@ -1292,7 +1278,7 @@ iavf_configure_queues(struct iavf_adapter *adapter,
 		PMD_DRV_LOG(ERR, "Failed to execute command of"
 			    " VIRTCHNL_OP_CONFIG_VSI_QUEUES");
 
-	rte_free(vc_config);
+	free(vc_config);
 	return err;
 }
 
-- 
2.47.3

