Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC90CD8CAD
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 04:42:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7738540671;
	Tue,  9 Jun 2026 06:42:12 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 5209340664
 for <dev@dpdk.org>; Tue,  9 Jun 2026 06:42:10 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6594Ku0b026583 for <dev@dpdk.org>; Mon, 8 Jun 2026 21:42:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=D
 0+F6WloKZIpeAW/uGKmIiLOm7o95ajgZmLCXavEWnY=; b=jmG7uBO9W+hTvKi6b
 zUDTOEZVBKhkyM9Wo1H4LP/CB/GSxnif+vGj70FPUkRE+5C3LGjVFMu0kwy00DLM
 ainuKoHjr/OF/2MUxXmAdELSI9y+wOULHan1VueG8xSLGLY+os8V0qEXItc3VlBJ
 dCdzpiaMqY3fYX+Eq+Wu6N3QGCP4wLNZZ67s9+KNRBYjA74s9M6cqPx+Jz7l09Ts
 1SoBAQi608SFwww8yaH3SOlskDsztfmOizj9K82Gc5H6EOb45wO0c5He0gk6VIsC
 K56mjwhe1AiiB54qjhRhEl3uKe8Cia48UfyneTliCXFfoAP3FDhoMDZUcTWI0AK1
 tzGog==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4epbqp81rg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 08 Jun 2026 21:42:09 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 8 Jun 2026 21:42:08 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 8 Jun 2026 21:42:08 -0700
Received: from sj4r760o4u9.sclab.marvell.com (unknown [10.110.150.37])
 by maili.marvell.com (Postfix) with ESMTP id 539F83F704E;
 Mon,  8 Jun 2026 21:42:08 -0700 (PDT)
From: Srikanth Yalavarthi <syalavarthi@marvell.com>
To: Srikanth Yalavarthi <syalavarthi@marvell.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, <sshankarnara@marvell.com>,
 <ptakkar@marvell.com>, <aprabhu@marvell.com>
Subject: [PATCH 3/3] ml/cnxk: updated checks for number of MRVL layers
Date: Tue, 9 Jun 2026 10:12:02 +0530
Message-ID: <20260609044202.936153-3-syalavarthi@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609044202.936153-1-syalavarthi@marvell.com>
References: <20260609044202.936153-1-syalavarthi@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA0MCBTYWx0ZWRfX8Nrw9faVDnbL
 MDDqMlacRzr3Eh+p2ZtkZ2huGztNI+gdEJMaUhWeOS1c4HxtJkFWDI+pK9VkPTxktJ1kQOK2seH
 Zhb5a7fPfNTuYSfKH0DzQ/RZqo0J4Q2+OqyNFnfg9ZMh7KNYJV1heUZHEy90Tz919B0SBJvMjuI
 wXIljDwhCxVAV2wzqKQKfAMX1HWcQaZWaln4isgejxrh2N2110D9xnacGez9KhDOzDuSucqKJfh
 4X1ARi2pXZWqXuGkvGsydsobhWHH6HQ4I9obLp1nZOuPhVMRSE4rIjFLjYtcBYF0/8YjkE2TTyH
 eCEUIhG4XfdbJy/hLIBwRmVpsqo72XuuZHCCaoTnm0J3ncSusTeOMrNDLCUJJKDmaF9nemNDGGh
 vKfLpL4Mbi0QOs/9ctDbwq7JPH6CzNeuBpBBednrMltGDgZ7/WoVkuLhPCeLYyeW2cOAyKDn8Ez
 dAKmI/m/dzkfRJKtW6A==
X-Authority-Analysis: v=2.4 cv=Y6zIdBeN c=1 sm=1 tr=0 ts=6a2799a1 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=La8GtXxJzkl7KZlA0w0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: RlIMSGYYMCgffBDg820KgSKv6jWm-Bsz
X-Proofpoint-ORIG-GUID: RlIMSGYYMCgffBDg820KgSKv6jWm-Bsz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
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

Add checks to validate the current active MRVL layers
and increased the maximum number of layers supported
to 512 for LLVM only models.

Signed-off-by: Srikanth Yalavarthi <syalavarthi@marvell.com>
---
 drivers/ml/cnxk/cn10k_ml_ops.c   |  6 +++---
 drivers/ml/cnxk/cnxk_ml_dev.h    |  4 ++--
 drivers/ml/cnxk/cnxk_ml_io.h     |  2 +-
 drivers/ml/cnxk/cnxk_ml_ops.c    | 14 +++++++-------
 drivers/ml/cnxk/tvmrt_ml_model.c | 17 +++++++++++++++++
 5 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/ml/cnxk/cn10k_ml_ops.c b/drivers/ml/cnxk/cn10k_ml_ops.c
index b30af7c7a44..00c0d87a6d6 100644
--- a/drivers/ml/cnxk/cn10k_ml_ops.c
+++ b/drivers/ml/cnxk/cn10k_ml_ops.c
@@ -624,15 +624,15 @@ cn10k_ml_layer_load(void *device, uint16_t model_id, const char *layer_name, uin
 		return ret;
 
 	/* Get index */
-	for (idx = 0; idx < cnxk_mldev->max_nb_layers; idx++) {
+	for (idx = 0; idx < cnxk_mldev->max_mrvl_layers; idx++) {
 		if (!cnxk_mldev->index_map[idx].active) {
 			layer->index = idx;
 			break;
 		}
 	}
 
-	if (idx >= cnxk_mldev->max_nb_layers) {
-		plt_err("No slots available for model layers, model_id = %u, layer_id = %u",
+	if (idx >= cnxk_mldev->max_mrvl_layers) {
+		plt_err("No slots available for model MRVL layers, model_id = %u, layer_id = %u",
 			model->model_id, layer_id);
 		return -1;
 	}
diff --git a/drivers/ml/cnxk/cnxk_ml_dev.h b/drivers/ml/cnxk/cnxk_ml_dev.h
index e93d76d1af8..181a04737d7 100644
--- a/drivers/ml/cnxk/cnxk_ml_dev.h
+++ b/drivers/ml/cnxk/cnxk_ml_dev.h
@@ -93,9 +93,9 @@ struct cnxk_ml_dev {
 #endif
 
 	/* Maximum number of layers */
-	uint64_t max_nb_layers;
+	uint64_t max_mrvl_layers;
 
-	/* Index map */
+	/* Index map for MRVL layers */
 	struct cnxk_ml_index_map *index_map;
 };
 
diff --git a/drivers/ml/cnxk/cnxk_ml_io.h b/drivers/ml/cnxk/cnxk_ml_io.h
index 3ca852706f5..e6efd588f75 100644
--- a/drivers/ml/cnxk/cnxk_ml_io.h
+++ b/drivers/ml/cnxk/cnxk_ml_io.h
@@ -16,7 +16,7 @@
 
 /* Maximum number of layers per model */
 #ifdef RTE_MLDEV_CNXK_ENABLE_TVMRT
-#define ML_CNXK_MODEL_MAX_LAYERS 128
+#define ML_CNXK_MODEL_MAX_LAYERS 512
 #else
 #define ML_CNXK_MODEL_MAX_LAYERS 1
 #endif
diff --git a/drivers/ml/cnxk/cnxk_ml_ops.c b/drivers/ml/cnxk/cnxk_ml_ops.c
index 675cdaae2bd..dc057643068 100644
--- a/drivers/ml/cnxk/cnxk_ml_ops.c
+++ b/drivers/ml/cnxk/cnxk_ml_ops.c
@@ -636,30 +636,30 @@ cnxk_ml_dev_configure(struct rte_ml_dev *dev, const struct rte_ml_dev_config *co
 
 	/* Set device capabilities */
 	if (cnxk_mldev->type == CNXK_ML_DEV_TYPE_PCI)
-		cnxk_mldev->max_nb_layers =
+		cnxk_mldev->max_mrvl_layers =
 			cnxk_mldev->cn10k_mldev.fw.req->cn10k_req.jd.fw_load.cap.s.max_models;
 	else
-		cnxk_mldev->max_nb_layers = ML_CNXK_MAX_MODELS;
+		cnxk_mldev->max_mrvl_layers = 0;
 
 	cnxk_mldev->mldev->enqueue_burst = cnxk_ml_enqueue_burst;
 	cnxk_mldev->mldev->dequeue_burst = cnxk_ml_dequeue_burst;
 	cnxk_mldev->mldev->op_error_get = cnxk_ml_op_error_get;
 
 	/* Allocate and initialize index_map */
-	if (cnxk_mldev->index_map == NULL) {
+	if (cnxk_mldev->type == CNXK_ML_DEV_TYPE_PCI && cnxk_mldev->index_map == NULL) {
 		cnxk_mldev->index_map =
 			rte_zmalloc("cnxk_ml_index_map",
-				    sizeof(struct cnxk_ml_index_map) * cnxk_mldev->max_nb_layers,
+				    sizeof(struct cnxk_ml_index_map) * cnxk_mldev->max_mrvl_layers,
 				    RTE_CACHE_LINE_SIZE);
 		if (cnxk_mldev->index_map == NULL) {
-			plt_err("Failed to get memory for index_map, nb_layers %" PRIu64,
-				cnxk_mldev->max_nb_layers);
+			plt_err("Failed to get memory for index_map, nb_mrvl_layers %" PRIu64,
+				cnxk_mldev->max_mrvl_layers);
 			ret = -ENOMEM;
 			goto error;
 		}
 	}
 
-	for (i = 0; i < cnxk_mldev->max_nb_layers; i++)
+	for (i = 0; i < cnxk_mldev->max_mrvl_layers; i++)
 		cnxk_mldev->index_map[i].active = false;
 
 	/* Initialize xstats */
diff --git a/drivers/ml/cnxk/tvmrt_ml_model.c b/drivers/ml/cnxk/tvmrt_ml_model.c
index 9bff424f0d8..319c53a05b5 100644
--- a/drivers/ml/cnxk/tvmrt_ml_model.c
+++ b/drivers/ml/cnxk/tvmrt_ml_model.c
@@ -398,6 +398,7 @@ tvmrt_ml_json_graph_get_arrays(json_t *json_parsed, json_t **nodes, json_t **arg
 int
 tvmrt_ml_model_json_parse(struct cnxk_ml_model *model)
 {
+	struct cnxk_ml_dev *cnxk_mldev = model->cnxk_mldev;
 	struct tvmrt_ml_param_names param_names;
 	json_error_t json_error;
 	json_t *json_parsed;
@@ -407,6 +408,7 @@ tvmrt_ml_model_json_parse(struct cnxk_ml_model *model)
 	json_t *json_node_row_ptr;
 	json_t *json_shape_values;
 	json_t *json_dtype_values;
+	uint16_t nb_active_mrvl_layers;
 	uint16_t nb_mrvl_layers;
 	uint16_t nb_llvm_layers;
 	DLDevice device;
@@ -511,6 +513,21 @@ tvmrt_ml_model_json_parse(struct cnxk_ml_model *model)
 		goto error;
 	}
 
+	nb_active_mrvl_layers = 0;
+	for (i = 0; i < cnxk_mldev->max_mrvl_layers; i++) {
+		if (cnxk_mldev->index_map[i].active)
+			nb_active_mrvl_layers++;
+	}
+
+	if (nb_active_mrvl_layers + nb_mrvl_layers > cnxk_mldev->max_mrvl_layers) {
+		ret = -ENOSPC;
+		plt_err("TVM runtime: Total MRVL layers (%u) exceeds maximum supported "
+			"MRVL layers (%" PRIu64 "), model_id = %u, error = %d",
+			nb_active_mrvl_layers + nb_mrvl_layers, cnxk_mldev->max_mrvl_layers,
+			model->model_id, ret);
+		goto error;
+	}
+
 	/* Set model subtype */
 	if ((nb_llvm_layers == 0) && (nb_mrvl_layers == 1))
 		model->subtype = ML_CNXK_MODEL_SUBTYPE_TVM_MRVL;
-- 
2.34.1

