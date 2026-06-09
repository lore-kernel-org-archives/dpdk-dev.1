Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC94CD8CAE
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 04:42:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 97E5A4066A;
	Tue,  9 Jun 2026 06:42:11 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 017B7400EF
 for <dev@dpdk.org>; Tue,  9 Jun 2026 06:42:08 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65941mUP3963446 for <dev@dpdk.org>; Mon, 8 Jun 2026 21:42:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=S
 AhPQ+fVgp7iKxi/63upR6+RdXlROvZvMmTD7ZQ30Tw=; b=i07SsRICZz8hCtdzD
 VbuoyTl88FF1lqdCWmNfCIXa0EHCaKhAfQ2bWoZszmt80yfzft7yuTYhPeXT6oRZ
 R7Fs5O8ULLp9K5Y8j1ByMvWDRIMDHDnkygNT2lQ4Alx/JhyzgrivUirCW5uPDbq0
 nvJUqnHyvVJ3W5x8wHFS8eo5YPy4QcCehkjO0DMjoNzAYgmut6XNQZWibMntAfMh
 m/WTxJDNhd5uZtRszVaaObtEP0DLsGxWmSXKfxJvHfGqTqpk8C1cPrCJ9z4YtKTf
 JpaQe4eY15QtiMIto10iDF6bkPo53PEnPOpsOEZ8/hvSmdwTlJ8IYxcAuXw7r0Kc
 KuSVg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4en7t8y1s1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 08 Jun 2026 21:42:07 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 8 Jun 2026 21:42:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 8 Jun 2026 21:42:07 -0700
Received: from sj4r760o4u9.sclab.marvell.com (unknown [10.110.150.37])
 by maili.marvell.com (Postfix) with ESMTP id EA9823F7057;
 Mon,  8 Jun 2026 21:42:06 -0700 (PDT)
From: Srikanth Yalavarthi <syalavarthi@marvell.com>
To: Srikanth Yalavarthi <syalavarthi@marvell.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, <sshankarnara@marvell.com>,
 <ptakkar@marvell.com>, <aprabhu@marvell.com>
Subject: [PATCH 2/3] ml/cnxk: rename tvm runtime module components
Date: Tue, 9 Jun 2026 10:12:01 +0530
Message-ID: <20260609044202.936153-2-syalavarthi@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609044202.936153-1-syalavarthi@marvell.com>
References: <20260609044202.936153-1-syalavarthi@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA0MCBTYWx0ZWRfX9kPVzyAGzLtW
 91/6FH2LTIfMQMlrEqfmGkB6n5A+ngbNUKFMEGJ8OV3L0iZBDS2UvpYoz6W+5pDElyYOn0lAsh2
 3/0X8zKyHfiMG6nBqlGqUEvy7PNkk1MpqnHgf3VeYXT0qpWF9syFDyrh0KMsB/TByhLkD+KmZjK
 7LF0RqMHw2fFqR3G74u1HSyunnKYZZ0pDgytONGJctHf70uuxxJ5y/7dTh4oHwEp8/St6s+Lwtt
 4UJ/FqaDTrHW27gHwDrKoVMpljhbClK9wsYvggnU4NdnJFoTAJFDdxquP2WWmrSHxmyTztFhiXa
 e0FfeXd6bv8gdS2XH9N3FumRzp4WI1FAH/VB22FvhRENDVIYkGutQdyCW+3Zhi1Vc0H+k7BI0Ll
 XVr8DNCZzLWIhy6D9wGfYOCv9LMT0M/X/SIbPJ7MnRo1Nl2JDBdA0DYksbnW/lKez8fplt8yIxS
 IRXdqaQjXZV7fI1G87g==
X-Authority-Analysis: v=2.4 cv=evLvCIpX c=1 sm=1 tr=0 ts=6a2799a0 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=yLBtYE77AAAA:8 a=OnZNdORkAAAA:8
 a=c8bQknW_Ws-JRkwN-v8A:9 a=O8hF6Hzn-FEA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=563i--EqTaB_-fmO0r4f:22 a=TpmaGhIeD0-5Lckg_u4S:22
X-Proofpoint-ORIG-GUID: hNjNvnnUHOKNNdvEyfXavj8Jv0q5nxQ3
X-Proofpoint-GUID: hNjNvnnUHOKNNdvEyfXavj8Jv0q5nxQ3
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

Rename all TVM runtime specific files and functions with
tvmrt prefix. Retain mvtvm name prefix for functions and
files related to mvtvm vdev component.

Signed-off-by: Srikanth Yalavarthi <syalavarthi@marvell.com>
---
 drivers/ml/cnxk/cn10k_ml_model.c              |   2 +-
 drivers/ml/cnxk/cnxk_ml_dev.h                 |   4 +-
 drivers/ml/cnxk/cnxk_ml_io.h                  |   6 +-
 drivers/ml/cnxk/cnxk_ml_model.c               |   4 +-
 drivers/ml/cnxk/cnxk_ml_model.h               |  12 +-
 drivers/ml/cnxk/cnxk_ml_ops.c                 |  24 +-
 drivers/ml/cnxk/cnxk_ml_ops.h                 |  10 +-
 drivers/ml/cnxk/meson.build                   |   6 +-
 drivers/ml/cnxk/mvtvm_ml_ops.c                | 818 +-----------------
 drivers/ml/cnxk/mvtvm_ml_ops.h                |  66 --
 drivers/ml/cnxk/mvtvm_ml_stubs.c              |  97 ---
 drivers/ml/cnxk/mvtvm_ml_stubs.h              |  19 -
 .../{mvtvm_ml_model.c => tvmrt_ml_model.c}    | 269 +++---
 .../{mvtvm_ml_model.h => tvmrt_ml_model.h}    |  44 +-
 drivers/ml/cnxk/tvmrt_ml_ops.c                | 818 ++++++++++++++++++
 drivers/ml/cnxk/tvmrt_ml_ops.h                |  79 ++
 drivers/ml/cnxk/tvmrt_ml_stubs.c              | 106 +++
 drivers/ml/cnxk/tvmrt_ml_stubs.h              |  32 +
 18 files changed, 1232 insertions(+), 1184 deletions(-)
 rename drivers/ml/cnxk/{mvtvm_ml_model.c => tvmrt_ml_model.c} (72%)
 rename drivers/ml/cnxk/{mvtvm_ml_model.h => tvmrt_ml_model.h} (78%)
 create mode 100644 drivers/ml/cnxk/tvmrt_ml_ops.c
 create mode 100644 drivers/ml/cnxk/tvmrt_ml_ops.h
 create mode 100644 drivers/ml/cnxk/tvmrt_ml_stubs.c
 create mode 100644 drivers/ml/cnxk/tvmrt_ml_stubs.h

diff --git a/drivers/ml/cnxk/cn10k_ml_model.c b/drivers/ml/cnxk/cn10k_ml_model.c
index 12a2dda800e..9cfecea4448 100644
--- a/drivers/ml/cnxk/cn10k_ml_model.c
+++ b/drivers/ml/cnxk/cn10k_ml_model.c
@@ -725,7 +725,7 @@ int
 cn10k_ml_model_get_layer_id(struct cnxk_ml_model *model, const char *layer_name, uint16_t *layer_id)
 {
 	if (model->type == ML_CNXK_MODEL_TYPE_TVM)
-		return mvtvm_ml_model_get_layer_id(model, layer_name, layer_id);
+		return tvmrt_ml_model_get_layer_id(model, layer_name, layer_id);
 
 	*layer_id = 0;
 
diff --git a/drivers/ml/cnxk/cnxk_ml_dev.h b/drivers/ml/cnxk/cnxk_ml_dev.h
index 9e373e65715..e93d76d1af8 100644
--- a/drivers/ml/cnxk/cnxk_ml_dev.h
+++ b/drivers/ml/cnxk/cnxk_ml_dev.h
@@ -9,7 +9,7 @@
 
 #include "cn10k_ml_dev.h"
 
-#ifdef RTE_MLDEV_CNXK_ENABLE_MVTVM
+#ifdef RTE_MLDEV_CNXK_ENABLE_TVMRT
 #include "mvtvm_ml_dev.h"
 #endif
 
@@ -87,7 +87,7 @@ struct cnxk_ml_dev {
 	/* CN10K device structure */
 	struct cn10k_ml_dev cn10k_mldev;
 
-#ifdef RTE_MLDEV_CNXK_ENABLE_MVTVM
+#ifdef RTE_MLDEV_CNXK_ENABLE_TVMRT
 	/* MVTVM device structure */
 	struct mvtvm_ml_dev mvtvm_mldev;
 #endif
diff --git a/drivers/ml/cnxk/cnxk_ml_io.h b/drivers/ml/cnxk/cnxk_ml_io.h
index 17f5b4619f0..3ca852706f5 100644
--- a/drivers/ml/cnxk/cnxk_ml_io.h
+++ b/drivers/ml/cnxk/cnxk_ml_io.h
@@ -5,7 +5,7 @@
 #ifndef _CNXK_ML_IO_H_
 #define _CNXK_ML_IO_H_
 
-#ifdef RTE_MLDEV_CNXK_ENABLE_MVTVM
+#ifdef RTE_MLDEV_CNXK_ENABLE_TVMRT
 #include <dlpack/dlpack.h>
 #endif
 
@@ -15,7 +15,7 @@
 #define ML_CNXK_MAX_MODELS 16
 
 /* Maximum number of layers per model */
-#ifdef RTE_MLDEV_CNXK_ENABLE_MVTVM
+#ifdef RTE_MLDEV_CNXK_ENABLE_TVMRT
 #define ML_CNXK_MODEL_MAX_LAYERS 128
 #else
 #define ML_CNXK_MODEL_MAX_LAYERS 1
@@ -59,7 +59,7 @@ struct cnxk_ml_io {
 	/* Zero point */
 	int64_t zero_point;
 
-#ifdef RTE_MLDEV_CNXK_ENABLE_MVTVM
+#ifdef RTE_MLDEV_CNXK_ENABLE_TVMRT
 	/* Shape - int64_t */
 	int64_t shape_i64[ML_CNXK_MODEL_MAX_DIMS];
 
diff --git a/drivers/ml/cnxk/cnxk_ml_model.c b/drivers/ml/cnxk/cnxk_ml_model.c
index ed6a1ed8665..442bc9460c0 100644
--- a/drivers/ml/cnxk/cnxk_ml_model.c
+++ b/drivers/ml/cnxk/cnxk_ml_model.c
@@ -16,7 +16,7 @@ cnxk_ml_model_get_type(struct rte_ml_model_params *params)
 	uint32_t payload_crc32c;
 	uint32_t header_crc32c;
 
-	type = mvtvm_ml_model_type_get(params);
+	type = tvmrt_ml_model_type_get(params);
 	if (type == ML_CNXK_MODEL_TYPE_TVM)
 		return ML_CNXK_MODEL_TYPE_TVM;
 	else if (type == ML_CNXK_MODEL_TYPE_INVALID)
@@ -89,6 +89,6 @@ cnxk_ml_model_dump(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model,
 		if (layer->type == ML_CNXK_LAYER_TYPE_MRVL)
 			cn10k_ml_layer_print(cnxk_mldev, layer, fp);
 		else
-			mvtvm_ml_layer_print(cnxk_mldev, layer, fp);
+			tvmrt_ml_layer_print(cnxk_mldev, layer, fp);
 	}
 }
diff --git a/drivers/ml/cnxk/cnxk_ml_model.h b/drivers/ml/cnxk/cnxk_ml_model.h
index 1cd5ca1906a..59aea16f970 100644
--- a/drivers/ml/cnxk/cnxk_ml_model.h
+++ b/drivers/ml/cnxk/cnxk_ml_model.h
@@ -11,10 +11,10 @@
 
 #include "cn10k_ml_model.h"
 
-#ifdef RTE_MLDEV_CNXK_ENABLE_MVTVM
-#include "mvtvm_ml_model.h"
+#ifdef RTE_MLDEV_CNXK_ENABLE_TVMRT
+#include "tvmrt_ml_model.h"
 #else
-#include "mvtvm_ml_stubs.h"
+#include "tvmrt_ml_stubs.h"
 #endif
 
 #include "cnxk_ml_io.h"
@@ -152,9 +152,9 @@ struct cnxk_ml_model {
 		/* Model specific data - glow */
 		struct cn10k_ml_model_data glow;
 
-#ifdef RTE_MLDEV_CNXK_ENABLE_MVTVM
-		/* Model type specific data - mvtvm */
-		struct mvtvm_ml_model_data mvtvm;
+#ifdef RTE_MLDEV_CNXK_ENABLE_TVMRT
+		/* Model type specific data - tvmrt */
+		struct tvmrt_ml_model_data tvmrt;
 #endif
 	};
 
diff --git a/drivers/ml/cnxk/cnxk_ml_ops.c b/drivers/ml/cnxk/cnxk_ml_ops.c
index 938982c7556..675cdaae2bd 100644
--- a/drivers/ml/cnxk/cnxk_ml_ops.c
+++ b/drivers/ml/cnxk/cnxk_ml_ops.c
@@ -250,7 +250,7 @@ cnxk_ml_xstats_model_name_update(struct cnxk_ml_dev *cnxk_mldev, uint16_t model_
 		if (model->type == ML_CNXK_MODEL_TYPE_GLOW)
 			cn10k_ml_xstat_model_name_set(cnxk_mldev, model, stat_id, i, suffix);
 		else
-			mvtvm_ml_model_xstat_name_set(cnxk_mldev, model, stat_id, i, suffix);
+			tvmrt_ml_model_xstat_name_set(cnxk_mldev, model, stat_id, i, suffix);
 
 		stat_id++;
 	}
@@ -312,7 +312,7 @@ cnxk_ml_model_xstat_get(struct cnxk_ml_dev *cnxk_mldev, uint16_t obj_idx, int32_
 	goto exit_xstats;
 
 model_xstats:
-	value = mvtvm_ml_model_xstat_get(cnxk_mldev, model, type);
+	value = tvmrt_ml_model_xstat_get(cnxk_mldev, model, type);
 
 exit_xstats:
 	roc_clk_freq_get(&rclk_freq, &sclk_freq);
@@ -1211,7 +1211,7 @@ cnxk_ml_model_load(struct rte_ml_dev *dev, struct rte_ml_model_params *params, u
 	if (type == ML_CNXK_MODEL_TYPE_GLOW)
 		ret = cn10k_ml_model_load(cnxk_mldev, params, model);
 	else
-		ret = mvtvm_ml_model_load(cnxk_mldev, params, model);
+		ret = tvmrt_ml_model_load(cnxk_mldev, params, model);
 	if (ret != 0)
 		goto error;
 
@@ -1225,7 +1225,7 @@ cnxk_ml_model_load(struct rte_ml_dev *dev, struct rte_ml_model_params *params, u
 		total_wb_pages = total_wb_pages + model->layer[layer_id].glow.ocm_map.wb_pages;
 		max_scratch_pages = PLT_MAX(max_scratch_pages,
 					    model->layer[layer_id].glow.ocm_map.scratch_pages);
-#ifdef RTE_MLDEV_CNXK_ENABLE_MVTVM
+#ifdef RTE_MLDEV_CNXK_ENABLE_TVMRT
 	} else {
 		for (layer_id = 0; layer_id < model->nb_layers; layer_id++) {
 			if (model->layer[layer_id].type == ML_CNXK_LAYER_TYPE_MRVL) {
@@ -1247,7 +1247,7 @@ cnxk_ml_model_load(struct rte_ml_dev *dev, struct rte_ml_model_params *params, u
 			plt_ml_dbg("layer_id = %u: wb_pages = %u, scratch_pages = %u", layer_id,
 				   model->layer[layer_id].glow.ocm_map.wb_pages,
 				   model->layer[layer_id].glow.ocm_map.scratch_pages);
-#ifdef RTE_MLDEV_CNXK_ENABLE_MVTVM
+#ifdef RTE_MLDEV_CNXK_ENABLE_TVMRT
 		} else {
 			for (layer_id = 0; layer_id < model->nb_layers; layer_id++) {
 				if (model->layer[layer_id].type == ML_CNXK_LAYER_TYPE_MRVL) {
@@ -1263,9 +1263,9 @@ cnxk_ml_model_load(struct rte_ml_dev *dev, struct rte_ml_model_params *params, u
 
 		if (model->type == ML_CNXK_MODEL_TYPE_GLOW)
 			cn10k_ml_model_unload(cnxk_mldev, model);
-#ifdef RTE_MLDEV_CNXK_ENABLE_MVTVM
+#ifdef RTE_MLDEV_CNXK_ENABLE_TVMRT
 		else {
-			mvtvm_ml_model_unload(cnxk_mldev, model);
+			tvmrt_ml_model_unload(cnxk_mldev, model);
 			return -ENOMEM;
 		}
 #endif
@@ -1312,7 +1312,7 @@ cnxk_ml_model_unload(struct rte_ml_dev *dev, uint16_t model_id)
 	if (model->type == ML_CNXK_MODEL_TYPE_GLOW)
 		ret = cn10k_ml_model_unload(cnxk_mldev, model);
 	else
-		ret = mvtvm_ml_model_unload(cnxk_mldev, model);
+		ret = tvmrt_ml_model_unload(cnxk_mldev, model);
 	if (ret != 0)
 		return ret;
 
@@ -1343,7 +1343,7 @@ cnxk_ml_model_start(struct rte_ml_dev *dev, uint16_t model_id)
 	if (model->type == ML_CNXK_MODEL_TYPE_GLOW)
 		return cn10k_ml_model_start(cnxk_mldev, model);
 	else
-		return mvtvm_ml_model_start(cnxk_mldev, model);
+		return tvmrt_ml_model_start(cnxk_mldev, model);
 
 	return 0;
 }
@@ -1368,7 +1368,7 @@ cnxk_ml_model_stop(struct rte_ml_dev *dev, uint16_t model_id)
 	if (model->type == ML_CNXK_MODEL_TYPE_GLOW)
 		return cn10k_ml_model_stop(cnxk_mldev, model);
 	else
-		return mvtvm_ml_model_stop(cnxk_mldev, model);
+		return tvmrt_ml_model_stop(cnxk_mldev, model);
 
 	return 0;
 }
@@ -1444,7 +1444,7 @@ cnxk_ml_io_quantize(struct rte_ml_dev *dev, uint16_t model_id, struct rte_ml_buf
 	if (model->type == ML_CNXK_MODEL_TYPE_GLOW)
 		info = cn10k_ml_model_io_info_get(model, 0);
 	else
-		info = mvtvm_ml_model_io_info_get(model, 0);
+		info = tvmrt_ml_model_io_info_get(model, 0);
 
 	if (info == NULL)
 		return -EINVAL;
@@ -1500,7 +1500,7 @@ cnxk_ml_io_dequantize(struct rte_ml_dev *dev, uint16_t model_id, struct rte_ml_b
 	if (model->type == ML_CNXK_MODEL_TYPE_GLOW)
 		info = cn10k_ml_model_io_info_get(model, model->nb_layers - 1);
 	else
-		info = mvtvm_ml_model_io_info_get(model, model->nb_layers - 1);
+		info = tvmrt_ml_model_io_info_get(model, model->nb_layers - 1);
 
 	if (info == NULL)
 		return -EINVAL;
diff --git a/drivers/ml/cnxk/cnxk_ml_ops.h b/drivers/ml/cnxk/cnxk_ml_ops.h
index 7a79fec412e..ad10c3d45dc 100644
--- a/drivers/ml/cnxk/cnxk_ml_ops.h
+++ b/drivers/ml/cnxk/cnxk_ml_ops.h
@@ -12,10 +12,12 @@
 
 #include "cn10k_ml_ops.h"
 
-#ifdef RTE_MLDEV_CNXK_ENABLE_MVTVM
+#ifdef RTE_MLDEV_CNXK_ENABLE_TVMRT
 #include "mvtvm_ml_ops.h"
+#include "tvmrt_ml_ops.h"
 #else
 #include "mvtvm_ml_stubs.h"
+#include "tvmrt_ml_stubs.h"
 #endif
 
 /* Request structure */
@@ -25,9 +27,9 @@ struct __rte_aligned(ROC_ALIGN) cnxk_ml_req {
 		/* CN10K */
 		struct cn10k_ml_req cn10k_req;
 
-#ifdef RTE_MLDEV_CNXK_ENABLE_MVTVM
-		/* MVTVM */
-		struct mvtvm_ml_req mvtvm_req;
+#ifdef RTE_MLDEV_CNXK_ENABLE_TVMRT
+		/* TVMRT */
+		struct tvmrt_ml_req tvmrt_req;
 #endif
 	};
 
diff --git a/drivers/ml/cnxk/meson.build b/drivers/ml/cnxk/meson.build
index 5f078bd4fd7..da3cb7a2967 100644
--- a/drivers/ml/cnxk/meson.build
+++ b/drivers/ml/cnxk/meson.build
@@ -53,12 +53,13 @@ deps += ['mldev', 'common_cnxk', 'kvargs', 'hash']
 
 if enable_mvtvm
 
-dpdk_conf.set('RTE_MLDEV_CNXK_ENABLE_MVTVM', 1)
+dpdk_conf.set('RTE_MLDEV_CNXK_ENABLE_TVMRT', 1)
 
 sources += files(
         'mvtvm_ml_dev.c',
         'mvtvm_ml_ops.c',
-        'mvtvm_ml_model.c',
+        'tvmrt_ml_ops.c',
+        'tvmrt_ml_model.c',
 )
 
 ext_deps += jansson_dep
@@ -80,6 +81,7 @@ message('drivers/ml/cnxk: Disabled TVM model support')
 
 sources += files(
         'mvtvm_ml_stubs.c',
+        'tvmrt_ml_stubs.c',
 )
 
 endif
diff --git a/drivers/ml/cnxk/mvtvm_ml_ops.c b/drivers/ml/cnxk/mvtvm_ml_ops.c
index bc47a4bbd75..69b800c8421 100644
--- a/drivers/ml/cnxk/mvtvm_ml_ops.c
+++ b/drivers/ml/cnxk/mvtvm_ml_ops.c
@@ -2,189 +2,19 @@
  * Copyright (c) 2023 Marvell.
  */
 
-#include <errno.h>
-#include <linux/limits.h>
-#include <stdbool.h>
 #include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <sys/mman.h>
-#include <unistd.h>
-
-#include <dlpack/dlpack.h>
-#include <jansson.h>
-
-#include <rte_common.h>
-#include <rte_cycles.h>
-#include <rte_mldev.h>
-#include <rte_mldev_pmd.h>
-
-#include <mldev_utils.h>
 
 #include "cnxk_ml_dev.h"
-#include "cnxk_ml_model.h"
-#include "cnxk_ml_ops.h"
-#include "cnxk_ml_xstats.h"
-
-/* ML model macros */
-#define MVTVM_ML_MODEL_MEMZONE_NAME "ml_mvtvm_model_mz"
-
-/* Shared memory file descriptor name */
-#define ML_MODEL_SHMFD_NAME "mvtvm_shmfd"
-
-/* Shared memory file descriptor path */
-#define ML_MODEL_SHMFD_PATH "/proc/%d/fd/%d"
-
-static int
-mvtvm_ml_tvm_func_get(struct cnxk_ml_model *model, TVMModuleHandle module, const char *name,
-		      TVMFunctionHandle *func)
-{
-	int ret;
-
-	ret = TVMModGetFunction(module, name, 0, func);
-	if (ret != 0) {
-		plt_err("Model load failed, model_id = %u, ret = %d, msg = %s", model->model_id,
-			ret, TVMGetLastError());
-		return ret;
-	}
-
-	if (*func == NULL) {
-		ret = -ENOENT;
-		plt_err("Model load failed, model_id = %u, function '%s' not found",
-			model->model_id, name);
-	}
-
-	return ret;
-}
-
-static int
-mvtvm_ml_tvm_func_call(struct cnxk_ml_model *model, TVMFunctionHandle func, const char *name,
-		       TVMValue *values, int *types, int num_args, TVMValue *ret_val, int *ret_type,
-		       int ret_type_code)
-{
-	int ret;
-
-	ret = TVMFuncCall(func, values, types, num_args, ret_val, ret_type);
-	if (ret != 0) {
-		plt_err("Error calling TVM function '%s', model_id = %u, ret = %d, msg = %s", name,
-			model->model_id, ret, TVMGetLastError());
-		return ret;
-	}
-
-	if (*ret_type != ret_type_code) {
-		ret = -EINVAL;
-		plt_err("TVM function '%s' returned unexpected type, model_id = %u, expected = %d, "
-			"actual = %d",
-			name, model->model_id, ret_type_code, *ret_type);
-	}
-
-	return ret;
-}
-
-static void
-mvtvm_ml_tvm_func_free(TVMFunctionHandle *func)
-{
-	if ((func != NULL) && (*func != NULL)) {
-		TVMFuncFree(*func);
-		*func = NULL;
-	}
-}
-
-static void
-mvtvm_ml_tvm_mod_free(TVMModuleHandle *mod)
-{
-	if ((mod != NULL) && (*mod != NULL)) {
-		TVMModFree(*mod);
-		*mod = NULL;
-	}
-}
-
-__rte_hot static void
-mvtvm_ml_set_poll_addr(struct cnxk_ml_req *req)
-{
-	req->status = &req->mvtvm_req.status;
-}
-
-void
-mvtvm_ml_model_xstat_name_set(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model,
-			      uint16_t stat_id, uint16_t entry, char *suffix)
-{
-	snprintf(cnxk_mldev->xstats.entries[stat_id].map.name,
-		 sizeof(cnxk_mldev->xstats.entries[stat_id].map.name), "%s-%s-%s", model->name,
-		 model_xstats[entry].name, suffix);
-}
-
-#define ML_AVG_FOREACH_QP_MVTVM(cnxk_mldev, model, qp_id, value, count)                            \
-	do {                                                                                       \
-		value = 0;                                                                         \
-		for (qp_id = 0; qp_id < cnxk_mldev->mldev->data->nb_queue_pairs; qp_id++) {        \
-			value += model->mvtvm.burst_xstats[qp_id].tvm_rt_latency_tot;              \
-			count += model->mvtvm.burst_xstats[qp_id].dequeued_count -                 \
-				 model->mvtvm.burst_xstats[qp_id].tvm_rt_reset_count;              \
-		}                                                                                  \
-		if (count != 0)                                                                    \
-			value = value / count;                                                     \
-	} while (0)
-
-#define ML_MIN_FOREACH_QP_MVTVM(cnxk_mldev, model, qp_id, value, count)                            \
-	do {                                                                                       \
-		value = UINT64_MAX;                                                                \
-		for (qp_id = 0; qp_id < cnxk_mldev->mldev->data->nb_queue_pairs; qp_id++) {        \
-			value = PLT_MIN(value,                                                     \
-					model->mvtvm.burst_xstats[qp_id].tvm_rt_latency_min);      \
-			count += model->mvtvm.burst_xstats[qp_id].dequeued_count -                 \
-				 model->mvtvm.burst_xstats[qp_id].tvm_rt_reset_count;              \
-		}                                                                                  \
-		if (count == 0)                                                                    \
-			value = 0;                                                                 \
-	} while (0)
-
-#define ML_MAX_FOREACH_QP_MVTVM(cnxk_mldev, model, qp_id, value, count)                            \
-	do {                                                                                       \
-		value = 0;                                                                         \
-		for (qp_id = 0; qp_id < cnxk_mldev->mldev->data->nb_queue_pairs; qp_id++) {        \
-			value = PLT_MAX(value,                                                     \
-					model->mvtvm.burst_xstats[qp_id].tvm_rt_latency_max);      \
-			count += model->mvtvm.burst_xstats[qp_id].dequeued_count -                 \
-				 model->mvtvm.burst_xstats[qp_id].tvm_rt_reset_count;              \
-		}                                                                                  \
-		if (count == 0)                                                                    \
-			value = 0;                                                                 \
-	} while (0)
-
-uint64_t
-mvtvm_ml_model_xstat_get(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model,
-			 enum cnxk_ml_xstats_type type)
-{
-	uint64_t count = 0;
-	uint64_t value = 0;
-	uint32_t qp_id;
-
-	switch (type) {
-	case avg_rt_latency:
-		ML_AVG_FOREACH_QP_MVTVM(cnxk_mldev, model, qp_id, value, count);
-		break;
-	case min_rt_latency:
-		ML_MIN_FOREACH_QP_MVTVM(cnxk_mldev, model, qp_id, value, count);
-		break;
-	case max_rt_latency:
-		ML_MAX_FOREACH_QP_MVTVM(cnxk_mldev, model, qp_id, value, count);
-		break;
-	default:
-		value = 0;
-	}
-
-	return value;
-}
+#include "mvtvm_ml_ops.h"
 
 int
 mvtvm_ml_dev_info_get(struct cnxk_ml_dev *cnxk_mldev, struct rte_ml_dev_info *dev_info)
 {
-	struct mvtvm_ml_dev *mvtvm_mldev;
+	struct mvtvm_ml_dev *tvmrt_mldev;
 
-	mvtvm_mldev = &cnxk_mldev->mvtvm_mldev;
+	tvmrt_mldev = &cnxk_mldev->mvtvm_mldev;
 
-	dev_info->max_queue_pairs = mvtvm_mldev->max_nb_qpairs;
+	dev_info->max_queue_pairs = tvmrt_mldev->max_nb_qpairs;
 	dev_info->max_desc = ML_MVTVM_MAX_DESC_PER_QP;
 	dev_info->max_io = ML_CNXK_MODEL_MAX_INPUT_OUTPUT;
 	dev_info->max_segments = ML_MVTVM_MAX_SEGMENTS;
@@ -201,643 +31,3 @@ mvtvm_ml_dev_dump(struct cnxk_ml_dev *cnxk_mldev, FILE *fp)
 
 	return 0;
 }
-
-int
-mvtvm_ml_model_load(struct cnxk_ml_dev *cnxk_mldev, struct rte_ml_model_params *params,
-		    struct cnxk_ml_model *model)
-{
-	struct mvtvm_ml_model_object object[ML_MVTVM_MODEL_OBJECT_MAX];
-	struct tvmrt_glow_callback *callback;
-	char str[RTE_MEMZONE_NAMESIZE];
-	char path[PATH_MAX];
-	const struct plt_memzone *mz;
-	size_t model_object_size = 0;
-	size_t model_xstats_size = 0;
-	uint64_t mz_size = 0;
-	TVMFunctionHandle create_fn = NULL;
-	TVMFunctionHandle register_cb_fn = NULL;
-	TVMModuleHandle module_so = NULL;
-	TVMByteArray tvm_params;
-	TVMValue ret_value = {0};
-	TVMValue arg_values[4] = {0};
-	TVMValue tvm_arg_values[1] = {0};
-	int ret_type = kTVMNullptr;
-	int arg_types[4] = {0};
-	int tvm_arg_types[1] = {0};
-	DLDevice device;
-	int ret;
-
-	RTE_SET_USED(cnxk_mldev);
-	model->mvtvm.fd = -1;
-
-	ret = mvtvm_ml_model_blob_parse(params, object);
-	if (ret != 0)
-		return ret;
-
-	model_object_size = RTE_ALIGN_CEIL(object[0].size, RTE_CACHE_LINE_MIN_SIZE) +
-			    RTE_ALIGN_CEIL(object[1].size, RTE_CACHE_LINE_MIN_SIZE) +
-			    RTE_ALIGN_CEIL(object[2].size, RTE_CACHE_LINE_MIN_SIZE);
-
-	model_xstats_size =
-		cnxk_mldev->mldev->data->nb_queue_pairs * sizeof(struct mvtvm_ml_model_xstats);
-
-	mz_size += model_object_size + model_xstats_size;
-
-	/* Allocate memzone for model object */
-	snprintf(str, RTE_MEMZONE_NAMESIZE, "%s_%u", MVTVM_ML_MODEL_MEMZONE_NAME, model->model_id);
-	mz = plt_memzone_reserve_aligned(str, mz_size, 0, ML_CN10K_ALIGN_SIZE);
-	if (!mz) {
-		plt_err("plt_memzone_reserve failed : %s", str);
-		return -ENOMEM;
-	}
-
-	/* Copy mod.so */
-	model->mvtvm.so.buffer = mz->addr;
-	model->mvtvm.so.size = object[0].size;
-	rte_memcpy(model->mvtvm.so.name, object[0].name, RTE_ML_STR_MAX);
-	rte_memcpy(model->mvtvm.so.buffer, object[0].buffer, object[0].size);
-	rte_free(object[0].buffer);
-
-	/* Copy mod.json */
-	model->mvtvm.json.buffer =
-		RTE_PTR_ADD(model->mvtvm.so.buffer,
-			    RTE_ALIGN_CEIL(model->mvtvm.so.size, RTE_CACHE_LINE_MIN_SIZE));
-	model->mvtvm.json.size = object[1].size;
-	rte_memcpy(model->mvtvm.json.name, object[1].name, RTE_ML_STR_MAX);
-	rte_memcpy(model->mvtvm.json.buffer, object[1].buffer, object[1].size);
-	rte_free(object[1].buffer);
-
-	/* Copy mod.params */
-	model->mvtvm.params.buffer =
-		RTE_PTR_ADD(model->mvtvm.json.buffer,
-			    RTE_ALIGN_CEIL(model->mvtvm.json.size, RTE_CACHE_LINE_MIN_SIZE));
-	model->mvtvm.params.size = object[2].size;
-	rte_memcpy(model->mvtvm.params.name, object[2].name, RTE_ML_STR_MAX);
-	rte_memcpy(model->mvtvm.params.buffer, object[2].buffer, object[2].size);
-	rte_free(object[2].buffer);
-
-	ret = mvtvm_ml_model_json_parse(model);
-	if (ret != 0)
-		goto error;
-
-	if (cnxk_mldev->type == CNXK_ML_DEV_TYPE_VDEV &&
-	    model->subtype != ML_CNXK_MODEL_SUBTYPE_TVM_LLVM) {
-		plt_err("Unsupported model sub-type");
-		ret = -ENOTSUP;
-		goto error;
-	}
-
-	/* Set callback function array */
-	if (model->subtype != ML_CNXK_MODEL_SUBTYPE_TVM_LLVM) {
-		callback = &model->mvtvm.cb;
-		callback->tvmrt_glow_layer_load = cn10k_ml_layer_load;
-		callback->tvmrt_glow_layer_unload = cn10k_ml_layer_unload;
-		callback->tvmrt_io_alloc = cn10k_ml_io_alloc;
-		callback->tvmrt_io_free = cn10k_ml_io_free;
-		callback->tvmrt_malloc = cn10k_ml_malloc;
-		callback->tvmrt_free = cn10k_ml_free;
-		callback->tvmrt_quantize = mvtvm_ml_io_quantize;
-		callback->tvmrt_dequantize = mvtvm_ml_io_dequantize;
-		callback->tvmrt_inference = cn10k_ml_inference_sync;
-	} else {
-		callback = NULL;
-	}
-
-	/* Initialize model in TVM runtime */
-	if (model->mvtvm.graph_module != NULL) {
-		ret = -EBUSY;
-		plt_err("TVM runtime: Model load failed, model_id = %u, error = %d",
-			model->model_id, ret);
-		goto error;
-	}
-
-	snprintf(path, sizeof(path), "%s_%d_%u", ML_MODEL_SHMFD_NAME, getpid(), model->model_id);
-	model->mvtvm.fd = memfd_create(path, 0);
-	if (model->mvtvm.fd < 0) {
-		ret = (errno == 0) ? -EIO : -errno;
-		plt_err("TVM runtime: Model load failed, model_id = %u, error = %d",
-			model->model_id, ret);
-		goto error;
-	}
-
-	if (write(model->mvtvm.fd, model->mvtvm.so.buffer, model->mvtvm.so.size) !=
-	    (ssize_t)model->mvtvm.so.size) {
-		ret = (errno == 0) ? -EIO : -errno;
-		plt_err("TVM runtime: Model load failed, model_id = %u, error = %d",
-			model->model_id, ret);
-		goto error;
-	}
-
-	if (lseek(model->mvtvm.fd, 0, SEEK_SET) < 0) {
-		ret = (errno == 0) ? -EIO : -errno;
-		plt_err("TVM runtime: Model load failed, model_id = %u, error = %d",
-			model->model_id, ret);
-		goto error;
-	}
-
-	snprintf(path, sizeof(path), ML_MODEL_SHMFD_PATH, getpid(), model->mvtvm.fd);
-	ret = TVMModLoadFromFile(path, "so", &module_so);
-	if (ret != 0) {
-		plt_err("TVM runtime: Model load failed, model_id = %u, ret = %d, msg = %s",
-			model->model_id, ret, TVMGetLastError());
-		goto error;
-	}
-
-	/* Set device info */
-	device.device_type = kDLCPU;
-	device.device_id = 0;
-
-	if (callback != NULL) {
-		ret = mvtvm_ml_tvm_func_get(model, module_so, "register_cb", &register_cb_fn);
-		if (ret != 0)
-			goto error;
-
-		arg_values[0].v_handle = callback;
-		arg_types[0] = kTVMOpaqueHandle;
-		arg_values[1].v_handle = cnxk_mldev;
-		arg_types[1] = kTVMOpaqueHandle;
-		arg_values[2].v_int64 = model->model_id;
-		arg_types[2] = kDLInt;
-
-		ret = mvtvm_ml_tvm_func_call(model, register_cb_fn, "register_cb", arg_values,
-					     arg_types, 3, &ret_value, &ret_type, kTVMNullptr);
-		if (ret != 0)
-			goto error;
-	}
-
-	ret = TVMFuncGetGlobal("tvm.graph_executor.create", &create_fn);
-	if (ret != 0) {
-		plt_err("TVM runtime: Model load failed, model_id = %u, ret = %d, msg = %s",
-			model->model_id, ret, TVMGetLastError());
-		goto error;
-	}
-
-	arg_values[0].v_str = (const char *)model->mvtvm.json.buffer;
-	arg_types[0] = kTVMStr;
-	arg_values[1].v_handle = module_so;
-	arg_types[1] = kTVMModuleHandle;
-	arg_values[2].v_int64 = device.device_type;
-	arg_types[2] = kDLInt;
-	arg_values[3].v_int64 = device.device_id;
-	arg_types[3] = kDLInt;
-
-	ret = mvtvm_ml_tvm_func_call(model, create_fn, "tvm.graph_executor.create", arg_values,
-				     arg_types, 4, &ret_value, &ret_type, kTVMModuleHandle);
-	if (ret != 0)
-		goto error;
-	model->mvtvm.graph_module = ret_value.v_handle;
-
-	ret = mvtvm_ml_tvm_func_get(model, model->mvtvm.graph_module, "load_params",
-				    &model->mvtvm.load_params);
-	if (ret != 0)
-		goto error;
-	ret = mvtvm_ml_tvm_func_get(model, model->mvtvm.graph_module, "set_input_zero_copy",
-				    &model->mvtvm.set_input_zero_copy);
-	if (ret != 0)
-		goto error;
-	ret = mvtvm_ml_tvm_func_get(model, model->mvtvm.graph_module, "set_output_zero_copy",
-				    &model->mvtvm.set_output_zero_copy);
-	if (ret != 0)
-		goto error;
-	ret = mvtvm_ml_tvm_func_get(model, model->mvtvm.graph_module, "run", &model->mvtvm.run);
-	if (ret != 0)
-		goto error;
-
-	mvtvm_ml_tvm_func_free(&register_cb_fn);
-	mvtvm_ml_tvm_mod_free(&module_so);
-
-	/* Load model parameters into TVM runtime */
-	tvm_params.data = (const char *)model->mvtvm.params.buffer;
-	tvm_params.size = model->mvtvm.params.size;
-	tvm_arg_values[0].v_handle = &tvm_params;
-	tvm_arg_types[0] = kTVMBytes;
-
-	ret = mvtvm_ml_tvm_func_call(model, model->mvtvm.load_params, "load_params", tvm_arg_values,
-				     tvm_arg_types, 1, &ret_value, &ret_type, kTVMNullptr);
-	if (ret != 0)
-		goto error;
-
-	/* Update model I/O data */
-	mvtvm_ml_model_io_info_set(model);
-
-	/* Set model info */
-	mvtvm_ml_model_info_set(cnxk_mldev, model);
-
-	/* Update model xstats name */
-	cnxk_ml_xstats_model_name_update(cnxk_mldev, model->model_id);
-
-	model->mvtvm.burst_xstats =
-		RTE_PTR_ADD(model->mvtvm.params.buffer,
-			    RTE_ALIGN_CEIL(model->mvtvm.params.size, RTE_CACHE_LINE_MIN_SIZE));
-
-	for (int qp_id = 0; qp_id < cnxk_mldev->mldev->data->nb_queue_pairs; qp_id++) {
-		model->mvtvm.burst_xstats[qp_id].tvm_rt_latency_tot = 0;
-		model->mvtvm.burst_xstats[qp_id].tvm_rt_latency = 0;
-		model->mvtvm.burst_xstats[qp_id].tvm_rt_latency_min = UINT64_MAX;
-		model->mvtvm.burst_xstats[qp_id].tvm_rt_latency_max = 0;
-		model->mvtvm.burst_xstats[qp_id].tvm_rt_reset_count = 0;
-		model->mvtvm.burst_xstats[qp_id].dequeued_count = 0;
-	}
-
-	/* Set model specific fast path functions */
-	if (model->subtype == ML_CNXK_MODEL_SUBTYPE_TVM_MRVL) {
-		model->enqueue_single = cn10k_ml_enqueue_single;
-		model->result_update = cn10k_ml_result_update;
-		model->set_error_code = cn10k_ml_set_error_code;
-		model->set_poll_addr = cn10k_ml_set_poll_addr;
-		model->op_error_get = cn10k_ml_op_error_get;
-	} else {
-		model->enqueue_single = mvtvm_ml_enqueue_single;
-		model->result_update = mvtvm_ml_result_update;
-		model->set_error_code = mvtvm_ml_set_error_code;
-		model->set_poll_addr = mvtvm_ml_set_poll_addr;
-		model->op_error_get = mvtvm_ml_op_error_get;
-	}
-
-	return 0;
-
-error:
-	mvtvm_ml_tvm_func_free(&register_cb_fn);
-	if (model != NULL) {
-		mvtvm_ml_tvm_func_free(&model->mvtvm.load_params);
-		mvtvm_ml_tvm_func_free(&model->mvtvm.set_input_zero_copy);
-		mvtvm_ml_tvm_func_free(&model->mvtvm.set_output_zero_copy);
-		mvtvm_ml_tvm_func_free(&model->mvtvm.run);
-		mvtvm_ml_tvm_mod_free(&model->mvtvm.graph_module);
-		if (model->mvtvm.fd >= 0)
-			close(model->mvtvm.fd);
-		memset(&model->mvtvm, 0, sizeof(model->mvtvm));
-		model->mvtvm.fd = -1;
-	}
-	mvtvm_ml_tvm_mod_free(&module_so);
-	plt_memzone_free(mz);
-
-	return ret;
-}
-
-int
-mvtvm_ml_model_unload(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model)
-{
-	char str[RTE_MEMZONE_NAMESIZE];
-	const struct plt_memzone *mz;
-
-	RTE_SET_USED(cnxk_mldev);
-
-	/* Unload model from TVM runtime */
-	if (model->model_id >= cnxk_mldev->mldev->data->nb_models)
-		return -EINVAL;
-
-	if (model->mvtvm.graph_module == NULL)
-		return -EINVAL;
-
-	mvtvm_ml_tvm_func_free(&model->mvtvm.load_params);
-	mvtvm_ml_tvm_func_free(&model->mvtvm.set_input_zero_copy);
-	mvtvm_ml_tvm_func_free(&model->mvtvm.set_output_zero_copy);
-	mvtvm_ml_tvm_func_free(&model->mvtvm.run);
-	mvtvm_ml_tvm_mod_free(&model->mvtvm.graph_module);
-	if (model->mvtvm.fd >= 0)
-		close(model->mvtvm.fd);
-	memset(&model->mvtvm, 0, sizeof(model->mvtvm));
-	model->mvtvm.fd = -1;
-
-	snprintf(str, RTE_MEMZONE_NAMESIZE, "%s_%u", MVTVM_ML_MODEL_MEMZONE_NAME, model->model_id);
-	mz = plt_memzone_lookup(str);
-	if (mz == NULL) {
-		plt_err("Memzone lookup failed for TVM model: model_id = %u, mz = %s",
-			model->model_id, str);
-		return -EINVAL;
-	}
-
-	return plt_memzone_free(mz);
-}
-
-int
-mvtvm_ml_model_start(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model)
-{
-	struct cnxk_ml_layer *layer;
-
-	uint16_t layer_id = 0;
-	int ret = 0;
-
-next_layer:
-	layer = &model->layer[layer_id];
-	if (layer->type == ML_CNXK_LAYER_TYPE_MRVL) {
-		ret = cn10k_ml_layer_start(cnxk_mldev, model->model_id, layer->name);
-		if (ret != 0) {
-			plt_err("Layer start failed, model_id = %u, layer_name = %s, error = %d",
-				model->model_id, layer->name, ret);
-			return ret;
-		}
-	}
-	layer_id++;
-
-	if (layer_id < model->nb_layers)
-		goto next_layer;
-
-	return 0;
-}
-
-int
-mvtvm_ml_model_stop(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model)
-{
-	struct cnxk_ml_layer *layer;
-
-	uint16_t layer_id = 0;
-	int ret = 0;
-
-next_layer:
-	layer = &model->layer[layer_id];
-	if (layer->type == ML_CNXK_LAYER_TYPE_MRVL) {
-		ret = cn10k_ml_layer_stop(cnxk_mldev, model->model_id, layer->name);
-		if (ret != 0) {
-			plt_err("Layer stop failed, model_id = %u, layer_name = %s, error = %d",
-				model->model_id, layer->name, ret);
-			return ret;
-		}
-	}
-	layer_id++;
-
-	if (layer_id < model->nb_layers)
-		goto next_layer;
-
-	return 0;
-}
-
-int
-mvtvm_ml_io_quantize(void *device, uint16_t model_id, const char *layer_name,
-		     const DLTensor **deq_tensor, void *qbuffer)
-{
-	struct cnxk_ml_io_info *info = NULL;
-	struct cnxk_ml_dev *cnxk_mldev;
-	struct cnxk_ml_model *model;
-	uint16_t layer_id = 0;
-	uint8_t *lcl_dbuffer;
-	uint8_t *lcl_qbuffer;
-	uint32_t i;
-	int ret;
-
-#ifdef CNXK_ML_DEV_DEBUG
-	if ((device == NULL) || (deq_tensor == NULL) || (qbuffer == NULL))
-		return -EINVAL;
-#endif
-
-	cnxk_mldev = (struct cnxk_ml_dev *)device;
-
-	model = cnxk_mldev->mldev->data->models[model_id];
-#ifdef CNXK_ML_DEV_DEBUG
-	if (model == NULL) {
-		plt_err("Invalid model_id = %u", model_id);
-		return -EINVAL;
-	}
-#endif
-
-	/* Get layer id */
-	for (layer_id = 0; layer_id < model->nb_layers; layer_id++) {
-		if (strcmp(model->layer[layer_id].name, layer_name) == 0)
-			break;
-	}
-
-#ifdef CNXK_ML_DEV_DEBUG
-	if (layer_id == model->nb_layers) {
-		plt_err("Invalid layer name: %s", layer_name);
-		return -EINVAL;
-	}
-
-	if (model->layer[layer_id].type != ML_CNXK_LAYER_TYPE_MRVL) {
-		plt_err("Invalid layer name / type: %s", layer_name);
-		return -EINVAL;
-	}
-#endif
-
-	info = &model->layer[layer_id].info;
-	lcl_qbuffer = (uint8_t *)qbuffer;
-
-	for (i = 0; i < info->nb_inputs; i++) {
-		lcl_dbuffer = PLT_PTR_ADD(deq_tensor[i]->data, deq_tensor[i]->byte_offset);
-
-		ret = cnxk_ml_io_quantize_single(&info->input[i], lcl_dbuffer, lcl_qbuffer);
-		if (ret < 0)
-			return ret;
-
-		lcl_qbuffer += info->input[i].sz_q;
-	}
-
-	return 0;
-}
-
-int
-mvtvm_ml_io_dequantize(void *device, uint16_t model_id, const char *layer_name, void *qbuffer,
-		       const DLTensor **deq_tensor)
-{
-	struct cnxk_ml_io_info *info = NULL;
-	struct cnxk_ml_dev *cnxk_mldev;
-	struct cnxk_ml_model *model;
-	uint16_t layer_id = 0;
-	uint8_t *lcl_dbuffer;
-	uint8_t *lcl_qbuffer;
-	uint32_t i;
-	int ret;
-
-#ifdef CNXK_ML_DEV_DEBUG
-	if ((device == NULL) || (deq_tensor == NULL) || (qbuffer == NULL))
-		return -EINVAL;
-#endif
-
-	cnxk_mldev = (struct cnxk_ml_dev *)device;
-
-	model = cnxk_mldev->mldev->data->models[model_id];
-#ifdef CNXK_ML_DEV_DEBUG
-	if (model == NULL) {
-		plt_err("Invalid model_id = %u", model_id);
-		return -EINVAL;
-	}
-#endif
-
-	for (layer_id = 0; layer_id < model->nb_layers; layer_id++) {
-		if (strcmp(model->layer[layer_id].name, layer_name) == 0)
-			break;
-	}
-
-#ifdef CNXK_ML_DEV_DEBUG
-	if (layer_id == model->nb_layers) {
-		plt_err("Invalid layer name: %s", layer_name);
-		return -EINVAL;
-	}
-
-	if (model->layer[layer_id].type != ML_CNXK_LAYER_TYPE_MRVL) {
-		plt_err("Invalid layer name / type: %s", layer_name);
-		return -EINVAL;
-	}
-#endif
-
-	info = &model->layer[layer_id].info;
-	lcl_qbuffer = (uint8_t *)qbuffer;
-
-	for (i = 0; i < info->nb_outputs; i++) {
-		lcl_dbuffer = PLT_PTR_ADD(deq_tensor[i]->data, deq_tensor[i]->byte_offset);
-
-		ret = cnxk_ml_io_dequantize_single(&info->output[i], lcl_qbuffer, lcl_dbuffer);
-		if (ret < 0)
-			return ret;
-
-		lcl_qbuffer += info->output[i].sz_q;
-	}
-
-	return 0;
-}
-
-static int
-mvtvm_ml_model_run(struct cnxk_ml_model *model, struct rte_ml_op *op, struct cnxk_ml_req *req)
-{
-	uint8_t i;
-	struct mvtvm_ml_result *run_result;
-	TVMValue arg_values[2] = {0};
-	int arg_types[2] = {0};
-	TVMValue ret_value = {0};
-	int ret_type = kTVMNullptr;
-	int ret = 0;
-
-	rte_memcpy(req->mvtvm_req.input_tensor, model->mvtvm.input_tensor,
-		   model->mvtvm.info.nb_inputs * sizeof(DLTensor));
-	for (i = 0; i < model->mvtvm.info.nb_inputs; i++) {
-		req->mvtvm_req.input_tensor[i].data = op->input[i]->addr;
-		req->mvtvm_req.input_tensor[i].byte_offset = 0;
-	}
-
-	rte_memcpy(req->mvtvm_req.output_tensor, model->mvtvm.output_tensor,
-		   model->mvtvm.info.nb_outputs * sizeof(DLTensor));
-	for (i = 0; i < model->mvtvm.info.nb_outputs; i++) {
-		req->mvtvm_req.output_tensor[i].data = op->output[i]->addr;
-		req->mvtvm_req.output_tensor[i].byte_offset = 0;
-	}
-
-	run_result = &req->mvtvm_req.result;
-	run_result->stats.start_ns = rte_get_tsc_cycles();
-	run_result->error_code = 0;
-
-	for (i = 0; i < model->mvtvm.info.nb_inputs; i++) {
-		arg_values[0].v_int64 = i;
-		arg_types[0] = kDLInt;
-		arg_values[1].v_handle = &req->mvtvm_req.input_tensor[i];
-		arg_types[1] = kTVMDLTensorHandle;
-		ret = mvtvm_ml_tvm_func_call(model, model->mvtvm.set_input_zero_copy,
-					     "set_input_zero_copy", arg_values, arg_types, 2,
-					     &ret_value, &ret_type, kTVMNullptr);
-		if (ret != 0)
-			goto out;
-	}
-
-	for (i = 0; i < model->mvtvm.info.nb_outputs; i++) {
-		arg_values[0].v_int64 = i;
-		arg_types[0] = kDLInt;
-		arg_values[1].v_handle = &req->mvtvm_req.output_tensor[i];
-		arg_types[1] = kTVMDLTensorHandle;
-		ret = mvtvm_ml_tvm_func_call(model, model->mvtvm.set_output_zero_copy,
-					     "set_output_zero_copy", arg_values, arg_types, 2,
-					     &ret_value, &ret_type, kTVMNullptr);
-		if (ret != 0)
-			goto out;
-	}
-
-	ret = mvtvm_ml_tvm_func_call(model, model->mvtvm.run, "run", NULL, NULL, 0, &ret_value,
-				     &ret_type, kTVMNullptr);
-	if (ret != 0)
-		goto out;
-
-out:
-	run_result->stats.end_ns = rte_get_tsc_cycles();
-	req->mvtvm_req.status = 0x1;
-
-	plt_write64(ML_CNXK_POLL_JOB_FINISH, req->status);
-
-	if (ret != 0)
-		run_result->error_code = -EIO;
-
-	return 0;
-}
-
-__rte_hot void
-mvtvm_ml_set_error_code(struct cnxk_ml_req *req, uint64_t etype, uint64_t stype)
-{
-	RTE_SET_USED(stype);
-
-	req->mvtvm_req.result.error_code = etype;
-}
-
-__rte_hot int
-mvtvm_ml_op_error_get(struct cnxk_ml_dev *cnxk_mldev, struct rte_ml_op *op,
-		      struct rte_ml_op_error *error)
-{
-	RTE_SET_USED(cnxk_mldev);
-	RTE_SET_USED(op);
-	RTE_SET_USED(error);
-
-	return 0;
-}
-
-__rte_hot bool
-mvtvm_ml_enqueue_single(struct cnxk_ml_dev *cnxk_mldev, struct rte_ml_op *op, uint16_t layer_id,
-			struct cnxk_ml_qp *qp, uint64_t head)
-{
-	struct cnxk_ml_model *model;
-	struct cnxk_ml_queue *queue;
-	struct cnxk_ml_req *req;
-
-	RTE_SET_USED(layer_id);
-
-	queue = &qp->queue;
-	req = &queue->reqs[head];
-	model = cnxk_mldev->mldev->data->models[op->model_id];
-
-	model->set_poll_addr(req);
-	memset(&req->mvtvm_req.result, 0, sizeof(struct mvtvm_ml_result));
-	req->mvtvm_req.result.error_code = 0x0;
-	req->mvtvm_req.result.user_ptr = op->user_ptr;
-
-	cnxk_ml_set_poll_ptr(req);
-	mvtvm_ml_model_run(model, op, req);
-	req->timeout = plt_tsc_cycles() + queue->wait_cycles;
-	req->op = op;
-
-	return true;
-}
-
-__rte_hot void
-mvtvm_ml_result_update(struct cnxk_ml_dev *cnxk_mldev, int qp_id, void *request)
-{
-	struct mvtvm_ml_model_xstats *xstats;
-	struct mvtvm_ml_result *result;
-	struct cnxk_ml_model *model;
-	struct cnxk_ml_req *req;
-	uint64_t tvm_rt_latency;
-	struct cnxk_ml_qp *qp;
-	struct rte_ml_op *op;
-
-	req = (struct cnxk_ml_req *)request;
-	result = &req->mvtvm_req.result;
-	op = req->op;
-	qp = cnxk_mldev->mldev->data->queue_pairs[qp_id];
-	op->impl_opaque = result->error_code;
-
-	if (likely(result->error_code == 0)) {
-		qp->stats.dequeued_count++;
-		op->status = RTE_ML_OP_STATUS_SUCCESS;
-
-		model = cnxk_mldev->mldev->data->models[op->model_id];
-		xstats = &model->mvtvm.burst_xstats[qp_id];
-
-		if (unlikely(xstats->dequeued_count == xstats->tvm_rt_reset_count)) {
-			xstats->tvm_rt_latency_min = UINT64_MAX;
-			xstats->tvm_rt_latency_max = 0;
-		}
-		tvm_rt_latency = result->stats.end_ns - result->stats.start_ns;
-		xstats->tvm_rt_latency = tvm_rt_latency;
-		xstats->tvm_rt_latency_tot += tvm_rt_latency;
-		xstats->tvm_rt_latency_min = RTE_MIN(xstats->tvm_rt_latency_min, tvm_rt_latency);
-		xstats->tvm_rt_latency_max = RTE_MAX(xstats->tvm_rt_latency_max, tvm_rt_latency);
-		xstats->dequeued_count++;
-	} else {
-		qp->stats.dequeue_err_count++;
-		op->status = RTE_ML_OP_STATUS_ERROR;
-	}
-}
diff --git a/drivers/ml/cnxk/mvtvm_ml_ops.h b/drivers/ml/cnxk/mvtvm_ml_ops.h
index 593f4585b3c..b83246517e7 100644
--- a/drivers/ml/cnxk/mvtvm_ml_ops.h
+++ b/drivers/ml/cnxk/mvtvm_ml_ops.h
@@ -5,77 +5,11 @@
 #ifndef _MVTVM_ML_OPS_H_
 #define _MVTVM_ML_OPS_H_
 
-#include <dlpack/dlpack.h>
-
 #include <rte_mldev.h>
 
 #include "cnxk_ml_xstats.h"
-#include "mvtvm_ml_model.h"
-
-struct cnxk_ml_dev;
-struct cnxk_ml_model;
-struct cnxk_ml_layer;
-struct cnxk_ml_qp;
-struct cnxk_ml_req;
-
-/* Inference stats */
-struct mvtvm_ml_stats {
-	/* Start ns */
-	uint64_t start_ns;
-
-	/* Start ns */
-	uint64_t end_ns;
-};
-
-/* Result structure */
-struct mvtvm_ml_result {
-	/* Job error code */
-	uint64_t error_code;
-
-	/* Inference stats */
-	struct mvtvm_ml_stats stats;
-
-	/* User context pointer */
-	void *user_ptr;
-};
-
-/* MVTVM specific request */
-struct mvtvm_ml_req {
-	/* Input tensors */
-	DLTensor input_tensor[ML_CNXK_MODEL_MAX_INPUT_OUTPUT];
-
-	/* Output tensors */
-	DLTensor output_tensor[ML_CNXK_MODEL_MAX_INPUT_OUTPUT];
-
-	/* Status field for poll mode requests */
-	volatile uint64_t status;
-
-	/* Result */
-	struct mvtvm_ml_result result;
-};
 
 int mvtvm_ml_dev_info_get(struct cnxk_ml_dev *mldev, struct rte_ml_dev_info *dev_info);
 int mvtvm_ml_dev_dump(struct cnxk_ml_dev *cnxk_mldev, FILE *fp);
-int mvtvm_ml_model_load(struct cnxk_ml_dev *cnxk_mldev, struct rte_ml_model_params *params,
-			struct cnxk_ml_model *model);
-int mvtvm_ml_model_unload(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model);
-int mvtvm_ml_model_start(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model);
-int mvtvm_ml_model_stop(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model);
-int mvtvm_ml_io_quantize(void *device, uint16_t model_id, const char *layer_name,
-			 const DLTensor **deq_tensor, void *qbuffer);
-int mvtvm_ml_io_dequantize(void *device, uint16_t model_id, const char *layer_name, void *qbuffer,
-			   const DLTensor **deq_tensor);
-
-__rte_hot bool mvtvm_ml_enqueue_single(struct cnxk_ml_dev *cnxk_mldev, struct rte_ml_op *op,
-				       uint16_t layer_id, struct cnxk_ml_qp *qp, uint64_t head);
-__rte_hot int mvtvm_ml_op_error_get(struct cnxk_ml_dev *cnxk_mldev, struct rte_ml_op *op,
-				    struct rte_ml_op_error *error);
-__rte_hot void mvtvm_ml_result_update(struct cnxk_ml_dev *cnxk_mldev, int qp_id, void *request);
-__rte_hot void mvtvm_ml_set_error_code(struct cnxk_ml_req *req, uint64_t etype, uint64_t stype);
-
-void mvtvm_ml_model_xstat_name_set(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model,
-				   uint16_t stat_id, uint16_t entry, char *suffix);
-uint64_t mvtvm_ml_model_xstat_get(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model,
-				  enum cnxk_ml_xstats_type type);
 
 #endif /* _MVTVM_ML_OPS_H_ */
diff --git a/drivers/ml/cnxk/mvtvm_ml_stubs.c b/drivers/ml/cnxk/mvtvm_ml_stubs.c
index 7c13fac42d6..2341658657f 100644
--- a/drivers/ml/cnxk/mvtvm_ml_stubs.c
+++ b/drivers/ml/cnxk/mvtvm_ml_stubs.c
@@ -7,65 +7,6 @@
 #include "mvtvm_ml_stubs.h"
 
 #include "cnxk_ml_dev.h"
-#include "cnxk_ml_model.h"
-#include "cnxk_ml_xstats.h"
-
-enum cnxk_ml_model_type
-mvtvm_ml_model_type_get(struct rte_ml_model_params *params)
-{
-	RTE_SET_USED(params);
-
-	return ML_CNXK_MODEL_TYPE_UNKNOWN;
-}
-
-int
-mvtvm_ml_model_get_layer_id(struct cnxk_ml_model *model, const char *layer_name, uint16_t *layer_id)
-{
-	RTE_SET_USED(model);
-	RTE_SET_USED(layer_name);
-	RTE_SET_USED(layer_id);
-
-	return -EINVAL;
-}
-
-struct cnxk_ml_io_info *
-mvtvm_ml_model_io_info_get(struct cnxk_ml_model *model, uint16_t layer_id)
-{
-	RTE_SET_USED(model);
-	RTE_SET_USED(layer_id);
-
-	return NULL;
-}
-
-void
-mvtvm_ml_layer_print(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_layer *layer, FILE *fp)
-{
-	RTE_SET_USED(cnxk_mldev);
-	RTE_SET_USED(layer);
-	RTE_SET_USED(fp);
-}
-
-void
-mvtvm_ml_model_xstat_name_set(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model,
-			      uint16_t stat_id, uint16_t entry, char *suffix)
-{
-	RTE_SET_USED(cnxk_mldev);
-	RTE_SET_USED(model);
-	RTE_SET_USED(stat_id);
-	RTE_SET_USED(entry);
-	RTE_SET_USED(suffix);
-}
-
-uint64_t
-mvtvm_ml_model_xstat_get(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model,
-			 enum cnxk_ml_xstats_type type)
-{
-	RTE_SET_USED(cnxk_mldev);
-	RTE_SET_USED(model);
-	RTE_SET_USED(type);
-
-	return 0;
-}
 
 int
 mvtvm_ml_dev_info_get(struct cnxk_ml_dev *cnxk_mldev, struct rte_ml_dev_info *dev_info)
@@ -84,41 +25,3 @@ mvtvm_ml_dev_dump(struct cnxk_ml_dev *cnxk_mldev, FILE *fp)
 
 	return -EINVAL;
 }
-
-int
-mvtvm_ml_model_load(struct cnxk_ml_dev *cnxk_mldev, struct rte_ml_model_params *params,
-		    struct cnxk_ml_model *model)
-{
-	RTE_SET_USED(cnxk_mldev);
-	RTE_SET_USED(params);
-	RTE_SET_USED(model);
-
-	return -EINVAL;
-}
-
-int
-mvtvm_ml_model_unload(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model)
-{
-	RTE_SET_USED(cnxk_mldev);
-	RTE_SET_USED(model);
-
-	return -EINVAL;
-}
-
-int
-mvtvm_ml_model_start(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model)
-{
-	RTE_SET_USED(cnxk_mldev);
-	RTE_SET_USED(model);
-
-	return -EINVAL;
-}
-
-int
-mvtvm_ml_model_stop(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model)
-{
-	RTE_SET_USED(cnxk_mldev);
-	RTE_SET_USED(model);
-
-	return -EINVAL;
-}
diff --git a/drivers/ml/cnxk/mvtvm_ml_stubs.h b/drivers/ml/cnxk/mvtvm_ml_stubs.h
index 15985a75bf4..0eebdbb1ed2 100644
--- a/drivers/ml/cnxk/mvtvm_ml_stubs.h
+++ b/drivers/ml/cnxk/mvtvm_ml_stubs.h
@@ -7,28 +7,9 @@
 
 #include <rte_mldev.h>
 
-#include "cnxk_ml_xstats.h"
-
 struct cnxk_ml_dev;
-struct cnxk_ml_model;
-struct cnxk_ml_layer;
 
-enum cnxk_ml_model_type mvtvm_ml_model_type_get(struct rte_ml_model_params *params);
 int mvtvm_ml_dev_info_get(struct cnxk_ml_dev *cnxk_mldev, struct rte_ml_dev_info *dev_info);
 int mvtvm_ml_dev_dump(struct cnxk_ml_dev *cnxk_mldev, FILE *fp);
-int mvtvm_ml_model_load(struct cnxk_ml_dev *cnxk_mldev, struct rte_ml_model_params *params,
-			struct cnxk_ml_model *model);
-int mvtvm_ml_model_unload(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model);
-int mvtvm_ml_model_start(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model);
-int mvtvm_ml_model_stop(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model);
-
-int mvtvm_ml_model_get_layer_id(struct cnxk_ml_model *model, const char *layer_name,
-				uint16_t *layer_id);
-struct cnxk_ml_io_info *mvtvm_ml_model_io_info_get(struct cnxk_ml_model *model, uint16_t layer_id);
-void mvtvm_ml_layer_print(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_layer *layer, FILE *fp);
-void mvtvm_ml_model_xstat_name_set(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model,
-				   uint16_t stat_id, uint16_t entry, char *suffix);
-uint64_t mvtvm_ml_model_xstat_get(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model,
-				  enum cnxk_ml_xstats_type type);
 
 #endif /* _MVTVM_ML_STUBS_H_ */
diff --git a/drivers/ml/cnxk/mvtvm_ml_model.c b/drivers/ml/cnxk/tvmrt_ml_model.c
similarity index 72%
rename from drivers/ml/cnxk/mvtvm_ml_model.c
rename to drivers/ml/cnxk/tvmrt_ml_model.c
index e1946607629..9bff424f0d8 100644
--- a/drivers/ml/cnxk/mvtvm_ml_model.c
+++ b/drivers/ml/cnxk/tvmrt_ml_model.c
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright (c) 2023 Marvell.
+ * Copyright (c) 2026 Marvell.
  */
 
 #include <errno.h>
@@ -22,13 +22,13 @@
 #include "cnxk_ml_utils.h"
 
 /* Objects list */
-char mvtvm_object_list[ML_MVTVM_MODEL_OBJECT_MAX][RTE_ML_STR_MAX] = {"mod.so", "mod.json",
-								     "mod.params"};
+static char tvmrt_object_list[ML_TVMRT_MODEL_OBJECT_MAX][RTE_ML_STR_MAX] = {"mod.so", "mod.json",
+									    "mod.params"};
 
 enum cnxk_ml_model_type
-mvtvm_ml_model_type_get(struct rte_ml_model_params *params)
+tvmrt_ml_model_type_get(struct rte_ml_model_params *params)
 {
-	bool object_found[ML_MVTVM_MODEL_OBJECT_MAX] = {false, false, false};
+	bool object_found[ML_TVMRT_MODEL_OBJECT_MAX] = {false, false, false};
 	enum cnxk_ml_model_type model_type;
 	struct archive_entry *entry;
 	struct archive *a;
@@ -47,18 +47,18 @@ mvtvm_ml_model_type_get(struct rte_ml_model_params *params)
 
 	/* Parse buffer for available objects */
 	while (archive_read_next_header(a, &entry) == ARCHIVE_OK) {
-		for (i = 0; i < ML_MVTVM_MODEL_OBJECT_MAX; i++) {
+		for (i = 0; i < ML_TVMRT_MODEL_OBJECT_MAX; i++) {
 			if (!object_found[i] &&
-			    (strcmp(archive_entry_pathname(entry), mvtvm_object_list[i]) == 0))
+			    (strcmp(archive_entry_pathname(entry), tvmrt_object_list[i]) == 0))
 				object_found[i] = true;
 		}
 		archive_read_data_skip(a);
 	}
 
 	/* Check if all objects are available */
-	for (i = 0; i < ML_MVTVM_MODEL_OBJECT_MAX; i++) {
+	for (i = 0; i < ML_TVMRT_MODEL_OBJECT_MAX; i++) {
 		if (!object_found[i]) {
-			plt_err("Object %s not found in archive!", mvtvm_object_list[i]);
+			plt_err("Object %s not found in archive!", tvmrt_object_list[i]);
 			model_type = ML_CNXK_MODEL_TYPE_INVALID;
 			goto cleanup;
 		}
@@ -74,15 +74,15 @@ mvtvm_ml_model_type_get(struct rte_ml_model_params *params)
 }
 
 int
-mvtvm_ml_model_blob_parse(struct rte_ml_model_params *params, struct mvtvm_ml_model_object *object)
+tvmrt_ml_model_blob_parse(struct rte_ml_model_params *params, struct tvmrt_ml_model_object *object)
 {
-	bool object_found[ML_MVTVM_MODEL_OBJECT_MAX] = {false, false, false};
+	bool object_found[ML_TVMRT_MODEL_OBJECT_MAX] = {false, false, false};
 	struct archive_entry *entry;
 	struct archive *a;
 	uint8_t i;
 	int ret;
 
-	memset(object, 0, ML_MVTVM_MODEL_OBJECT_MAX * sizeof(*object));
+	memset(object, 0, ML_TVMRT_MODEL_OBJECT_MAX * sizeof(*object));
 
 	/* Open archive */
 	a = archive_read_new();
@@ -97,10 +97,10 @@ mvtvm_ml_model_blob_parse(struct rte_ml_model_params *params, struct mvtvm_ml_mo
 
 	/* Read archive */
 	while (archive_read_next_header(a, &entry) == ARCHIVE_OK) {
-		for (i = 0; i < ML_MVTVM_MODEL_OBJECT_MAX; i++) {
+		for (i = 0; i < ML_TVMRT_MODEL_OBJECT_MAX; i++) {
 			if (!object_found[i] &&
-			    (strcmp(archive_entry_pathname(entry), mvtvm_object_list[i]) == 0)) {
-				memcpy(object[i].name, mvtvm_object_list[i], RTE_ML_STR_MAX);
+			    (strcmp(archive_entry_pathname(entry), tvmrt_object_list[i]) == 0)) {
+				memcpy(object[i].name, tvmrt_object_list[i], RTE_ML_STR_MAX);
 				object[i].size = archive_entry_size(entry);
 				object[i].buffer = rte_malloc(NULL, object[i].size, 0);
 				if (object[i].buffer == NULL) {
@@ -122,9 +122,9 @@ mvtvm_ml_model_blob_parse(struct rte_ml_model_params *params, struct mvtvm_ml_mo
 	}
 
 	/* Check if all objects are parsed */
-	for (i = 0; i < ML_MVTVM_MODEL_OBJECT_MAX; i++) {
+	for (i = 0; i < ML_TVMRT_MODEL_OBJECT_MAX; i++) {
 		if (!object_found[i]) {
-			plt_err("Object %s not found in archive!", mvtvm_object_list[i]);
+			plt_err("Object %s not found in archive!", tvmrt_object_list[i]);
 			ret = -EINVAL;
 			goto error;
 		}
@@ -133,7 +133,7 @@ mvtvm_ml_model_blob_parse(struct rte_ml_model_params *params, struct mvtvm_ml_mo
 	goto cleanup;
 
 error:
-	for (i = 0; i < ML_MVTVM_MODEL_OBJECT_MAX; i++) {
+	for (i = 0; i < ML_TVMRT_MODEL_OBJECT_MAX; i++) {
 		if (object[i].buffer != NULL)
 			rte_free(object[i].buffer);
 	}
@@ -146,7 +146,7 @@ mvtvm_ml_model_blob_parse(struct rte_ml_model_params *params, struct mvtvm_ml_mo
 }
 
 int
-mvtvm_ml_model_get_layer_id(struct cnxk_ml_model *model, const char *layer_name, uint16_t *layer_id)
+tvmrt_ml_model_get_layer_id(struct cnxk_ml_model *model, const char *layer_name, uint16_t *layer_id)
 {
 	uint16_t i;
 
@@ -171,7 +171,7 @@ mvtvm_ml_model_get_layer_id(struct cnxk_ml_model *model, const char *layer_name,
 }
 
 static void
-mvtvm_ml_param_names_free(struct mvtvm_ml_param_names *param_names)
+tvmrt_ml_param_names_free(struct tvmrt_ml_param_names *param_names)
 {
 	size_t i;
 
@@ -184,7 +184,7 @@ mvtvm_ml_param_names_free(struct mvtvm_ml_param_names *param_names)
 }
 
 static int
-mvtvm_ml_blob_read_u64(const uint8_t *blob, size_t blob_size, size_t *offset, uint64_t *value)
+tvmrt_ml_blob_read_u64(const uint8_t *blob, size_t blob_size, size_t *offset, uint64_t *value)
 {
 	if (*offset + sizeof(*value) > blob_size)
 		return -EINVAL;
@@ -196,8 +196,8 @@ mvtvm_ml_blob_read_u64(const uint8_t *blob, size_t blob_size, size_t *offset, ui
 }
 
 static int
-mvtvm_ml_param_names_parse(const uint8_t *blob, size_t blob_size,
-			   struct mvtvm_ml_param_names *param_names)
+tvmrt_ml_param_names_parse(const uint8_t *blob, size_t blob_size,
+			   struct tvmrt_ml_param_names *param_names)
 {
 	uint64_t magic = 0;
 	uint64_t reserved = 0;
@@ -208,18 +208,18 @@ mvtvm_ml_param_names_parse(const uint8_t *blob, size_t blob_size,
 
 	memset(param_names, 0, sizeof(*param_names));
 
-	ret = mvtvm_ml_blob_read_u64(blob, blob_size, &offset, &magic);
+	ret = tvmrt_ml_blob_read_u64(blob, blob_size, &offset, &magic);
 	if (ret != 0)
 		return ret;
 
 	if (magic != TVM_NDARRAY_LIST_MAGIC)
 		return -EINVAL;
 
-	ret = mvtvm_ml_blob_read_u64(blob, blob_size, &offset, &reserved);
+	ret = tvmrt_ml_blob_read_u64(blob, blob_size, &offset, &reserved);
 	if (ret != 0)
 		return ret;
 
-	ret = mvtvm_ml_blob_read_u64(blob, blob_size, &offset, &count);
+	ret = tvmrt_ml_blob_read_u64(blob, blob_size, &offset, &count);
 	if (ret != 0)
 		return ret;
 
@@ -234,7 +234,7 @@ mvtvm_ml_param_names_parse(const uint8_t *blob, size_t blob_size,
 	for (i = 0; i < count; i++) {
 		uint64_t name_len = 0;
 
-		ret = mvtvm_ml_blob_read_u64(blob, blob_size, &offset, &name_len);
+		ret = tvmrt_ml_blob_read_u64(blob, blob_size, &offset, &name_len);
 		if (ret != 0)
 			goto error;
 
@@ -261,12 +261,12 @@ mvtvm_ml_param_names_parse(const uint8_t *blob, size_t blob_size,
 	return 0;
 
 error:
-	mvtvm_ml_param_names_free(param_names);
+	tvmrt_ml_param_names_free(param_names);
 	return ret;
 }
 
 static int
-mvtvm_ml_dtype_parse(const char *dtype_str, DLDataType *dtype)
+tvmrt_ml_dtype_parse(const char *dtype_str, DLDataType *dtype)
 {
 	const char *lanes_str;
 	char base[32] = {0};
@@ -321,7 +321,7 @@ mvtvm_ml_dtype_parse(const char *dtype_str, DLDataType *dtype)
 }
 
 static int
-mvtvm_ml_model_io_set(struct cnxk_ml_io *io, const char *name, json_t *shape, const char *dtype_str,
+tvmrt_ml_model_io_set(struct cnxk_ml_io *io, const char *name, json_t *shape, const char *dtype_str,
 		      DLDevice device)
 {
 	size_t i;
@@ -346,7 +346,7 @@ mvtvm_ml_model_io_set(struct cnxk_ml_io *io, const char *name, json_t *shape, co
 		io->shape_i64[i] = json_integer_value(dim);
 	}
 
-	ret = mvtvm_ml_dtype_parse(dtype_str, &io->datatype);
+	ret = tvmrt_ml_dtype_parse(dtype_str, &io->datatype);
 	if (ret != 0)
 		return ret;
 
@@ -357,8 +357,9 @@ mvtvm_ml_model_io_set(struct cnxk_ml_io *io, const char *name, json_t *shape, co
 	return 0;
 }
 
+
 static int
-mvtvm_ml_json_graph_get_arrays(json_t *json_parsed, json_t **nodes, json_t **arg_nodes,
+tvmrt_ml_json_graph_get_arrays(json_t *json_parsed, json_t **nodes, json_t **arg_nodes,
 			       json_t **heads, json_t **node_row_ptr, json_t **shape_values,
 			       json_t **dtype_values)
 {
@@ -395,9 +396,9 @@ mvtvm_ml_json_graph_get_arrays(json_t *json_parsed, json_t **nodes, json_t **arg
 }
 
 int
-mvtvm_ml_model_json_parse(struct cnxk_ml_model *model)
+tvmrt_ml_model_json_parse(struct cnxk_ml_model *model)
 {
-	struct mvtvm_ml_param_names param_names;
+	struct tvmrt_ml_param_names param_names;
 	json_error_t json_error;
 	json_t *json_parsed;
 	json_t *json_nodes;
@@ -414,16 +415,16 @@ mvtvm_ml_model_json_parse(struct cnxk_ml_model *model)
 	size_t j;
 
 	/* Parse param names from params buffer */
-	ret = mvtvm_ml_param_names_parse(model->mvtvm.params.buffer, model->mvtvm.params.size,
+	ret = tvmrt_ml_param_names_parse(model->tvmrt.params.buffer, model->tvmrt.params.size,
 					 &param_names);
 	if (ret != 0)
 		return ret;
 
 	/* Load JSON graph (single load for both stages) */
-	json_parsed = json_loadb((const char *)model->mvtvm.json.buffer, model->mvtvm.json.size, 0,
+	json_parsed = json_loadb((const char *)model->tvmrt.json.buffer, model->tvmrt.json.size, 0,
 				 &json_error);
 	if (json_parsed == NULL) {
-		mvtvm_ml_param_names_free(&param_names);
+		tvmrt_ml_param_names_free(&param_names);
 		plt_err("TVM runtime: Failed to parse JSON graph, model_id = %u", model->model_id);
 		return -EINVAL;
 	}
@@ -522,12 +523,12 @@ mvtvm_ml_model_json_parse(struct cnxk_ml_model *model)
 	device.device_type = kDLCPU;
 	device.device_id = 0;
 
-	ret = mvtvm_ml_json_graph_get_arrays(json_parsed, &json_nodes, &json_arg_nodes, &json_heads,
+	ret = tvmrt_ml_json_graph_get_arrays(json_parsed, &json_nodes, &json_arg_nodes, &json_heads,
 					     &json_node_row_ptr, &json_shape_values,
 					     &json_dtype_values);
 	if (ret == 0) {
-		model->mvtvm.info.nb_inputs = 0;
-		model->mvtvm.info.nb_outputs = 0;
+		model->tvmrt.info.nb_inputs = 0;
+		model->tvmrt.info.nb_outputs = 0;
 
 		for (i = 0; i < json_array_size(json_arg_nodes); i++) {
 			json_t *arg_node_idx = json_array_get(json_arg_nodes, i);
@@ -561,18 +562,18 @@ mvtvm_ml_model_json_parse(struct cnxk_ml_model *model)
 			if (j < param_names.count)
 				continue;
 
-			if (model->mvtvm.info.nb_inputs >= ML_CNXK_MODEL_MAX_INPUT_OUTPUT) {
+			if (model->tvmrt.info.nb_inputs >= ML_CNXK_MODEL_MAX_INPUT_OUTPUT) {
 				ret = -ENOTSUP;
 				break;
 			}
 
-			ret = mvtvm_ml_model_io_set(
-				&model->mvtvm.info.input[model->mvtvm.info.nb_inputs],
+			ret = tvmrt_ml_model_io_set(
+				&model->tvmrt.info.input[model->tvmrt.info.nb_inputs],
 				json_string_value(name), shape, json_string_value(dtype), device);
 			if (ret != 0)
 				break;
 
-			model->mvtvm.info.nb_inputs++;
+			model->tvmrt.info.nb_inputs++;
 		}
 
 		for (i = 0; ret == 0 && i < json_array_size(json_heads); i++) {
@@ -641,18 +642,18 @@ mvtvm_ml_model_json_parse(struct cnxk_ml_model *model)
 				break;
 			}
 
-			if (model->mvtvm.info.nb_outputs >= ML_CNXK_MODEL_MAX_INPUT_OUTPUT) {
+			if (model->tvmrt.info.nb_outputs >= ML_CNXK_MODEL_MAX_INPUT_OUTPUT) {
 				ret = -ENOTSUP;
 				break;
 			}
 
-			ret = mvtvm_ml_model_io_set(
-				&model->mvtvm.info.output[model->mvtvm.info.nb_outputs],
+			ret = tvmrt_ml_model_io_set(
+				&model->tvmrt.info.output[model->tvmrt.info.nb_outputs],
 				json_string_value(name), shape, json_string_value(dtype), device);
 			if (ret != 0)
 				break;
 
-			model->mvtvm.info.nb_outputs++;
+			model->tvmrt.info.nb_outputs++;
 		}
 	}
 
@@ -661,17 +662,17 @@ mvtvm_ml_model_json_parse(struct cnxk_ml_model *model)
 			model->model_id, ret);
 
 	json_decref(json_parsed);
-	mvtvm_ml_param_names_free(&param_names);
+	tvmrt_ml_param_names_free(&param_names);
 	return ret;
 
 error:
 	json_decref(json_parsed);
-	mvtvm_ml_param_names_free(&param_names);
+	tvmrt_ml_param_names_free(&param_names);
 	return ret;
 }
 
 static enum rte_ml_io_type
-mvtvm_ml_io_type_map(DLDataType dltype)
+tvmrt_ml_io_type_map(DLDataType dltype)
 {
 	switch (dltype.code) {
 	case kDLInt:
@@ -714,7 +715,7 @@ mvtvm_ml_io_type_map(DLDataType dltype)
 }
 
 void
-mvtvm_ml_model_io_info_set(struct cnxk_ml_model *model)
+tvmrt_ml_model_io_info_set(struct cnxk_ml_model *model)
 {
 	int32_t i;
 	uint32_t j;
@@ -723,97 +724,97 @@ mvtvm_ml_model_io_info_set(struct cnxk_ml_model *model)
 		goto tvm_mrvl_model;
 
 	/* Inputs, set for layer_id = 0 */
-	model->mvtvm.info.total_input_sz_d = 0;
-	model->mvtvm.info.total_input_sz_q = 0;
-	for (i = 0; i < model->mvtvm.info.nb_inputs; i++) {
-		model->mvtvm.info.input[i].dtype =
-			mvtvm_ml_io_type_map(model->mvtvm.info.input[i].datatype);
-		model->mvtvm.info.input[i].qtype =
-			mvtvm_ml_io_type_map(model->mvtvm.info.input[i].model_datatype);
-
-		model->mvtvm.info.input[i].nb_elements = 1;
-		for (j = 0; j < model->mvtvm.info.input[i].nb_dims; j++) {
-			model->mvtvm.info.input[i].shape[j] =
-				PLT_U32_CAST(model->mvtvm.info.input[i].shape_i64[j]);
-			model->mvtvm.info.input[i].nb_elements *=
-				model->mvtvm.info.input[i].shape[j];
+	model->tvmrt.info.total_input_sz_d = 0;
+	model->tvmrt.info.total_input_sz_q = 0;
+	for (i = 0; i < model->tvmrt.info.nb_inputs; i++) {
+		model->tvmrt.info.input[i].dtype =
+			tvmrt_ml_io_type_map(model->tvmrt.info.input[i].datatype);
+		model->tvmrt.info.input[i].qtype =
+			tvmrt_ml_io_type_map(model->tvmrt.info.input[i].model_datatype);
+
+		model->tvmrt.info.input[i].nb_elements = 1;
+		for (j = 0; j < model->tvmrt.info.input[i].nb_dims; j++) {
+			model->tvmrt.info.input[i].shape[j] =
+				PLT_U32_CAST(model->tvmrt.info.input[i].shape_i64[j]);
+			model->tvmrt.info.input[i].nb_elements *=
+				model->tvmrt.info.input[i].shape[j];
 		}
 
-		model->mvtvm.info.input[i].sz_d =
-			model->mvtvm.info.input[i].nb_elements *
-			rte_ml_io_type_size_get(model->mvtvm.info.input[i].dtype);
-		model->mvtvm.info.input[i].sz_q =
-			model->mvtvm.info.input[i].nb_elements *
-			rte_ml_io_type_size_get(model->mvtvm.info.input[i].qtype);
+		model->tvmrt.info.input[i].sz_d =
+			model->tvmrt.info.input[i].nb_elements *
+			rte_ml_io_type_size_get(model->tvmrt.info.input[i].dtype);
+		model->tvmrt.info.input[i].sz_q =
+			model->tvmrt.info.input[i].nb_elements *
+			rte_ml_io_type_size_get(model->tvmrt.info.input[i].qtype);
 
-		model->mvtvm.info.total_input_sz_d += model->mvtvm.info.input[i].sz_d;
-		model->mvtvm.info.total_input_sz_q += model->mvtvm.info.input[i].sz_q;
+		model->tvmrt.info.total_input_sz_d += model->tvmrt.info.input[i].sz_d;
+		model->tvmrt.info.total_input_sz_q += model->tvmrt.info.input[i].sz_q;
 
-		model->mvtvm.input_tensor[i].device = model->mvtvm.info.input[i].device;
-		model->mvtvm.input_tensor[i].ndim = model->mvtvm.info.input[i].nb_dims;
-		model->mvtvm.input_tensor[i].dtype = model->mvtvm.info.input[i].datatype;
-		model->mvtvm.input_tensor[i].shape = model->mvtvm.info.input[i].shape_i64;
-		model->mvtvm.input_tensor[i].strides = NULL;
-		model->mvtvm.input_tensor[i].byte_offset = 0;
+		model->tvmrt.input_tensor[i].device = model->tvmrt.info.input[i].device;
+		model->tvmrt.input_tensor[i].ndim = model->tvmrt.info.input[i].nb_dims;
+		model->tvmrt.input_tensor[i].dtype = model->tvmrt.info.input[i].datatype;
+		model->tvmrt.input_tensor[i].shape = model->tvmrt.info.input[i].shape_i64;
+		model->tvmrt.input_tensor[i].strides = NULL;
+		model->tvmrt.input_tensor[i].byte_offset = 0;
 
 		plt_ml_dbg("model_id = %u, input[%u] - sz_d = %u sz_q = %u", model->model_id, i,
-			   model->mvtvm.info.input[i].sz_d, model->mvtvm.info.input[i].sz_q);
+			   model->tvmrt.info.input[i].sz_d, model->tvmrt.info.input[i].sz_q);
 	}
 
 	/* Outputs, set for nb_layers - 1 */
-	model->mvtvm.info.total_output_sz_d = 0;
-	model->mvtvm.info.total_output_sz_q = 0;
-	for (i = 0; i < model->mvtvm.info.nb_outputs; i++) {
-		model->mvtvm.info.output[i].dtype =
-			mvtvm_ml_io_type_map(model->mvtvm.info.output[i].datatype);
-		model->mvtvm.info.output[i].qtype =
-			mvtvm_ml_io_type_map(model->mvtvm.info.output[i].model_datatype);
-
-		model->mvtvm.info.output[i].nb_elements = 1;
-		for (j = 0; j < model->mvtvm.info.output[i].nb_dims; j++) {
-			model->mvtvm.info.output[i].shape[j] =
-				PLT_U32_CAST(model->mvtvm.info.output[i].shape_i64[j]);
-			model->mvtvm.info.output[i].nb_elements *=
-				model->mvtvm.info.output[i].shape[j];
+	model->tvmrt.info.total_output_sz_d = 0;
+	model->tvmrt.info.total_output_sz_q = 0;
+	for (i = 0; i < model->tvmrt.info.nb_outputs; i++) {
+		model->tvmrt.info.output[i].dtype =
+			tvmrt_ml_io_type_map(model->tvmrt.info.output[i].datatype);
+		model->tvmrt.info.output[i].qtype =
+			tvmrt_ml_io_type_map(model->tvmrt.info.output[i].model_datatype);
+
+		model->tvmrt.info.output[i].nb_elements = 1;
+		for (j = 0; j < model->tvmrt.info.output[i].nb_dims; j++) {
+			model->tvmrt.info.output[i].shape[j] =
+				PLT_U32_CAST(model->tvmrt.info.output[i].shape_i64[j]);
+			model->tvmrt.info.output[i].nb_elements *=
+				model->tvmrt.info.output[i].shape[j];
 		}
 
-		model->mvtvm.info.output[i].sz_d =
-			model->mvtvm.info.output[i].nb_elements *
-			rte_ml_io_type_size_get(model->mvtvm.info.output[i].dtype);
-		model->mvtvm.info.output[i].sz_q =
-			model->mvtvm.info.output[i].nb_elements *
-			rte_ml_io_type_size_get(model->mvtvm.info.output[i].qtype);
+		model->tvmrt.info.output[i].sz_d =
+			model->tvmrt.info.output[i].nb_elements *
+			rte_ml_io_type_size_get(model->tvmrt.info.output[i].dtype);
+		model->tvmrt.info.output[i].sz_q =
+			model->tvmrt.info.output[i].nb_elements *
+			rte_ml_io_type_size_get(model->tvmrt.info.output[i].qtype);
 
-		model->mvtvm.info.total_output_sz_d += model->mvtvm.info.output[i].sz_d;
-		model->mvtvm.info.total_output_sz_q += model->mvtvm.info.output[i].sz_q;
+		model->tvmrt.info.total_output_sz_d += model->tvmrt.info.output[i].sz_d;
+		model->tvmrt.info.total_output_sz_q += model->tvmrt.info.output[i].sz_q;
 
-		model->mvtvm.output_tensor[i].device = model->mvtvm.info.output[i].device;
-		model->mvtvm.output_tensor[i].ndim = model->mvtvm.info.output[i].nb_dims;
-		model->mvtvm.output_tensor[i].dtype = model->mvtvm.info.output[i].datatype;
-		model->mvtvm.output_tensor[i].shape = model->mvtvm.info.output[i].shape_i64;
-		model->mvtvm.output_tensor[i].strides = NULL;
-		model->mvtvm.output_tensor[i].byte_offset = 0;
+		model->tvmrt.output_tensor[i].device = model->tvmrt.info.output[i].device;
+		model->tvmrt.output_tensor[i].ndim = model->tvmrt.info.output[i].nb_dims;
+		model->tvmrt.output_tensor[i].dtype = model->tvmrt.info.output[i].datatype;
+		model->tvmrt.output_tensor[i].shape = model->tvmrt.info.output[i].shape_i64;
+		model->tvmrt.output_tensor[i].strides = NULL;
+		model->tvmrt.output_tensor[i].byte_offset = 0;
 
 		plt_ml_dbg("model_id = %u, output[%u] - sz_d = %u sz_q = %u", model->model_id, i,
-			   model->mvtvm.info.output[i].sz_d, model->mvtvm.info.output[i].sz_q);
+			   model->tvmrt.info.output[i].sz_d, model->tvmrt.info.output[i].sz_q);
 	}
 
 	return;
 
 tvm_mrvl_model:
-	cn10k_ml_layer_io_info_set(&model->mvtvm.info, &model->layer[0].glow.metadata);
+	cn10k_ml_layer_io_info_set(&model->tvmrt.info, &model->layer[0].glow.metadata);
 }
 
 struct cnxk_ml_io_info *
-mvtvm_ml_model_io_info_get(struct cnxk_ml_model *model, uint16_t layer_id)
+tvmrt_ml_model_io_info_get(struct cnxk_ml_model *model, uint16_t layer_id)
 {
 	RTE_SET_USED(layer_id);
 
-	return &model->mvtvm.info;
+	return &model->tvmrt.info;
 }
 
 void
-mvtvm_ml_model_info_set(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model)
+tvmrt_ml_model_info_set(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model)
 {
 	struct rte_ml_model_info *info;
 	struct rte_ml_io_info *output;
@@ -837,43 +838,43 @@ mvtvm_ml_model_info_set(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *mo
 	info->io_layout = RTE_ML_IO_LAYOUT_SPLIT;
 	info->min_batches = model->batch_size;
 	info->max_batches = model->batch_size;
-	info->nb_inputs = model->mvtvm.info.nb_inputs;
+	info->nb_inputs = model->tvmrt.info.nb_inputs;
 	info->input_info = input;
-	info->nb_outputs = model->mvtvm.info.nb_outputs;
+	info->nb_outputs = model->tvmrt.info.nb_outputs;
 	info->output_info = output;
 	info->wb_size = 0;
 
 	/* Set input info */
 	for (i = 0; i < info->nb_inputs; i++) {
-		rte_memcpy(input[i].name, model->mvtvm.info.input[i].name, MRVL_ML_INPUT_NAME_LEN);
-		input[i].nb_dims = model->mvtvm.info.input[i].nb_dims;
-		input[i].shape = &model->mvtvm.info.input[i].shape[0];
-		input[i].type = model->mvtvm.info.input[i].qtype;
-		input[i].nb_elements = model->mvtvm.info.input[i].nb_elements;
-		input[i].size = model->mvtvm.info.input[i].nb_elements *
-				rte_ml_io_type_size_get(model->mvtvm.info.input[i].qtype);
-		input[i].scale = model->mvtvm.info.input[i].scale;
+		rte_memcpy(input[i].name, model->tvmrt.info.input[i].name, MRVL_ML_INPUT_NAME_LEN);
+		input[i].nb_dims = model->tvmrt.info.input[i].nb_dims;
+		input[i].shape = &model->tvmrt.info.input[i].shape[0];
+		input[i].type = model->tvmrt.info.input[i].qtype;
+		input[i].nb_elements = model->tvmrt.info.input[i].nb_elements;
+		input[i].size = model->tvmrt.info.input[i].nb_elements *
+				rte_ml_io_type_size_get(model->tvmrt.info.input[i].qtype);
+		input[i].scale = model->tvmrt.info.input[i].scale;
 		input[i].zero_point = 0;
 	}
 
 	/* Set output info */
 	for (i = 0; i < info->nb_outputs; i++) {
-		rte_memcpy(output[i].name, model->mvtvm.info.output[i].name,
+		rte_memcpy(output[i].name, model->tvmrt.info.output[i].name,
 			   MRVL_ML_OUTPUT_NAME_LEN);
-		output[i].nb_dims = model->mvtvm.info.output[i].nb_dims;
-		output[i].shape = &model->mvtvm.info.output[i].shape[0];
-		output[i].type = model->mvtvm.info.output[i].qtype;
-		output[i].nb_elements = model->mvtvm.info.output[i].nb_elements;
-		output[i].size = model->mvtvm.info.output[i].nb_elements *
-				 rte_ml_io_type_size_get(model->mvtvm.info.output[i].qtype);
-		output[i].scale = model->mvtvm.info.output[i].scale;
+		output[i].nb_dims = model->tvmrt.info.output[i].nb_dims;
+		output[i].shape = &model->tvmrt.info.output[i].shape[0];
+		output[i].type = model->tvmrt.info.output[i].qtype;
+		output[i].nb_elements = model->tvmrt.info.output[i].nb_elements;
+		output[i].size = model->tvmrt.info.output[i].nb_elements *
+				 rte_ml_io_type_size_get(model->tvmrt.info.output[i].qtype);
+		output[i].scale = model->tvmrt.info.output[i].scale;
 		output[i].zero_point = 0;
 	}
 
 	return;
 
 tvm_mrvl_model:
-	cn10k_ml_model_info_set(cnxk_mldev, model, &model->mvtvm.info,
+	cn10k_ml_model_info_set(cnxk_mldev, model, &model->tvmrt.info,
 				&model->layer[0].glow.metadata);
 
 	strlcpy(info->name, model->name, RTE_ML_STR_MAX);
@@ -882,7 +883,7 @@ mvtvm_ml_model_info_set(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *mo
 }
 
 void
-mvtvm_ml_layer_print(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_layer *layer, FILE *fp)
+tvmrt_ml_layer_print(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_layer *layer, FILE *fp)
 {
 	char str[STR_LEN];
 	uint8_t i;
diff --git a/drivers/ml/cnxk/mvtvm_ml_model.h b/drivers/ml/cnxk/tvmrt_ml_model.h
similarity index 78%
rename from drivers/ml/cnxk/mvtvm_ml_model.h
rename to drivers/ml/cnxk/tvmrt_ml_model.h
index 1151b0a39ed..bf35dadb8a6 100644
--- a/drivers/ml/cnxk/mvtvm_ml_model.h
+++ b/drivers/ml/cnxk/tvmrt_ml_model.h
@@ -1,9 +1,9 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright (c) 2023 Marvell.
+ * Copyright (c) 2026 Marvell.
  */
 
-#ifndef _MVTVM_ML_MODEL_H_
-#define _MVTVM_ML_MODEL_H_
+#ifndef _TVMRT_ML_MODEL_H_
+#define _TVMRT_ML_MODEL_H_
 
 #include <dlpack/dlpack.h>
 #include <jansson.h>
@@ -30,19 +30,19 @@ struct cnxk_ml_model;
 struct cnxk_ml_layer;
 
 /* Maximum number of objects per model */
-#define ML_MVTVM_MODEL_OBJECT_MAX 3
+#define ML_TVMRT_MODEL_OBJECT_MAX 3
 
 /* Magic number for TVM parameter blobs. */
 #define TVM_NDARRAY_LIST_MAGIC 0xF7E58D4F05049CB7ULL
 
 /* TVM parameter names structure */
-struct mvtvm_ml_param_names {
+struct tvmrt_ml_param_names {
 	char **name;
 	size_t count;
 };
 
 /* TVM object / artifact info structure */
-struct mvtvm_ml_model_object {
+struct tvmrt_ml_model_object {
 	/* Name */
 	char name[RTE_ML_STR_MAX];
 
@@ -85,7 +85,7 @@ struct tvmrt_glow_callback {
 };
 
 /* Model fast-path stats */
-struct mvtvm_ml_model_xstats {
+struct tvmrt_ml_model_xstats {
 	/* Total TVM runtime latency, sum of all inferences */
 	uint64_t tvm_rt_latency_tot;
 
@@ -105,11 +105,11 @@ struct mvtvm_ml_model_xstats {
 	uint64_t tvm_rt_reset_count;
 };
 
-struct mvtvm_ml_model_data {
+struct tvmrt_ml_model_data {
 	/* Model objects */
-	struct mvtvm_ml_model_object so;
-	struct mvtvm_ml_model_object json;
-	struct mvtvm_ml_model_object params;
+	struct tvmrt_ml_model_object so;
+	struct tvmrt_ml_model_object json;
+	struct tvmrt_ml_model_object params;
 
 	/* TVM runtime callbacks */
 	struct tvmrt_glow_callback cb;
@@ -130,7 +130,7 @@ struct mvtvm_ml_model_data {
 	struct cnxk_ml_io_info info;
 
 	/* Stats for burst ops */
-	struct mvtvm_ml_model_xstats *burst_xstats;
+	struct tvmrt_ml_model_xstats *burst_xstats;
 
 	/* Input Tensor */
 	DLTensor input_tensor[ML_CNXK_MODEL_MAX_INPUT_OUTPUT];
@@ -139,15 +139,15 @@ struct mvtvm_ml_model_data {
 	DLTensor output_tensor[ML_CNXK_MODEL_MAX_INPUT_OUTPUT];
 };
 
-enum cnxk_ml_model_type mvtvm_ml_model_type_get(struct rte_ml_model_params *params);
-int mvtvm_ml_model_blob_parse(struct rte_ml_model_params *params,
-			      struct mvtvm_ml_model_object *object);
-int mvtvm_ml_model_get_layer_id(struct cnxk_ml_model *model, const char *layer_name,
+enum cnxk_ml_model_type tvmrt_ml_model_type_get(struct rte_ml_model_params *params);
+int tvmrt_ml_model_blob_parse(struct rte_ml_model_params *params,
+			      struct tvmrt_ml_model_object *object);
+int tvmrt_ml_model_get_layer_id(struct cnxk_ml_model *model, const char *layer_name,
 				uint16_t *layer_id);
-void mvtvm_ml_model_io_info_set(struct cnxk_ml_model *model);
-struct cnxk_ml_io_info *mvtvm_ml_model_io_info_get(struct cnxk_ml_model *model, uint16_t layer_id);
-void mvtvm_ml_model_info_set(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model);
-void mvtvm_ml_layer_print(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_layer *layer, FILE *fp);
-int mvtvm_ml_model_json_parse(struct cnxk_ml_model *model);
+void tvmrt_ml_model_io_info_set(struct cnxk_ml_model *model);
+struct cnxk_ml_io_info *tvmrt_ml_model_io_info_get(struct cnxk_ml_model *model, uint16_t layer_id);
+void tvmrt_ml_model_info_set(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model);
+void tvmrt_ml_layer_print(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_layer *layer, FILE *fp);
+int tvmrt_ml_model_json_parse(struct cnxk_ml_model *model);
 
-#endif /* _MVTVM_ML_MODEL_H_ */
+#endif /* _TVMRT_ML_MODEL_H_ */
diff --git a/drivers/ml/cnxk/tvmrt_ml_ops.c b/drivers/ml/cnxk/tvmrt_ml_ops.c
new file mode 100644
index 00000000000..f6b3a51c51e
--- /dev/null
+++ b/drivers/ml/cnxk/tvmrt_ml_ops.c
@@ -0,0 +1,818 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2026 Marvell.
+ */
+
+#include <errno.h>
+#include <linux/limits.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <unistd.h>
+
+#include <dlpack/dlpack.h>
+#include <jansson.h>
+
+#include <rte_common.h>
+#include <rte_cycles.h>
+#include <rte_mldev.h>
+#include <rte_mldev_pmd.h>
+
+#include <mldev_utils.h>
+
+#include "cnxk_ml_dev.h"
+#include "cnxk_ml_model.h"
+#include "cnxk_ml_ops.h"
+#include "cnxk_ml_xstats.h"
+
+/* ML model macros */
+#define TVMRT_ML_MODEL_MEMZONE_NAME "ml_tvmrt_model_mz"
+
+/* Shared memory file descriptor name */
+#define ML_MODEL_SHMFD_NAME "tvmrt_shmfd"
+
+/* Shared memory file descriptor path */
+#define ML_MODEL_SHMFD_PATH "/proc/%d/fd/%d"
+
+static int
+tvmrt_ml_tvm_func_get(struct cnxk_ml_model *model, TVMModuleHandle module, const char *name,
+		      TVMFunctionHandle *func)
+{
+	int ret;
+
+	ret = TVMModGetFunction(module, name, 0, func);
+	if (ret != 0) {
+		plt_err("Model load failed, model_id = %u, ret = %d, msg = %s", model->model_id,
+			ret, TVMGetLastError());
+		return ret;
+	}
+
+	if (*func == NULL) {
+		ret = -ENOENT;
+		plt_err("Model load failed, model_id = %u, function '%s' not found",
+			model->model_id, name);
+	}
+
+	return ret;
+}
+
+static int
+tvmrt_ml_tvm_func_call(struct cnxk_ml_model *model, TVMFunctionHandle func, const char *name,
+		       TVMValue *values, int *types, int num_args, TVMValue *ret_val, int *ret_type,
+		       int ret_type_code)
+{
+	int ret;
+
+	ret = TVMFuncCall(func, values, types, num_args, ret_val, ret_type);
+	if (ret != 0) {
+		plt_err("Error calling TVM function '%s', model_id = %u, ret = %d, msg = %s", name,
+			model->model_id, ret, TVMGetLastError());
+		return ret;
+	}
+
+	if (*ret_type != ret_type_code) {
+		ret = -EINVAL;
+		plt_err("TVM function '%s' returned unexpected type, model_id = %u, expected = %d, "
+			"actual = %d",
+			name, model->model_id, ret_type_code, *ret_type);
+	}
+
+	return ret;
+}
+
+static void
+tvmrt_ml_tvm_func_free(TVMFunctionHandle *func)
+{
+	if ((func != NULL) && (*func != NULL)) {
+		TVMFuncFree(*func);
+		*func = NULL;
+	}
+}
+
+static void
+tvmrt_ml_tvm_mod_free(TVMModuleHandle *mod)
+{
+	if ((mod != NULL) && (*mod != NULL)) {
+		TVMModFree(*mod);
+		*mod = NULL;
+	}
+}
+
+__rte_hot static void
+tvmrt_ml_set_poll_addr(struct cnxk_ml_req *req)
+{
+	req->status = &req->tvmrt_req.status;
+}
+
+void
+tvmrt_ml_model_xstat_name_set(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model,
+			      uint16_t stat_id, uint16_t entry, char *suffix)
+{
+	snprintf(cnxk_mldev->xstats.entries[stat_id].map.name,
+		 sizeof(cnxk_mldev->xstats.entries[stat_id].map.name), "%s-%s-%s", model->name,
+		 model_xstats[entry].name, suffix);
+}
+
+#define ML_AVG_FOREACH_QP_TVMRT(cnxk_mldev, model, qp_id, value, count)                            \
+	do {                                                                                       \
+		value = 0;                                                                         \
+		for (qp_id = 0; qp_id < cnxk_mldev->mldev->data->nb_queue_pairs; qp_id++) {        \
+			value += model->tvmrt.burst_xstats[qp_id].tvm_rt_latency_tot;              \
+			count += model->tvmrt.burst_xstats[qp_id].dequeued_count -                 \
+				 model->tvmrt.burst_xstats[qp_id].tvm_rt_reset_count;              \
+		}                                                                                  \
+		if (count != 0)                                                                    \
+			value = value / count;                                                     \
+	} while (0)
+
+#define ML_MIN_FOREACH_QP_TVMRT(cnxk_mldev, model, qp_id, value, count)                            \
+	do {                                                                                       \
+		value = UINT64_MAX;                                                                \
+		for (qp_id = 0; qp_id < cnxk_mldev->mldev->data->nb_queue_pairs; qp_id++) {        \
+			value = PLT_MIN(value,                                                     \
+					model->tvmrt.burst_xstats[qp_id].tvm_rt_latency_min);      \
+			count += model->tvmrt.burst_xstats[qp_id].dequeued_count -                 \
+				 model->tvmrt.burst_xstats[qp_id].tvm_rt_reset_count;              \
+		}                                                                                  \
+		if (count == 0)                                                                    \
+			value = 0;                                                                 \
+	} while (0)
+
+#define ML_MAX_FOREACH_QP_TVMRT(cnxk_mldev, model, qp_id, value, count)                            \
+	do {                                                                                       \
+		value = 0;                                                                         \
+		for (qp_id = 0; qp_id < cnxk_mldev->mldev->data->nb_queue_pairs; qp_id++) {        \
+			value = PLT_MAX(value,                                                     \
+					model->tvmrt.burst_xstats[qp_id].tvm_rt_latency_max);      \
+			count += model->tvmrt.burst_xstats[qp_id].dequeued_count -                 \
+				 model->tvmrt.burst_xstats[qp_id].tvm_rt_reset_count;              \
+		}                                                                                  \
+		if (count == 0)                                                                    \
+			value = 0;                                                                 \
+	} while (0)
+
+uint64_t
+tvmrt_ml_model_xstat_get(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model,
+			 enum cnxk_ml_xstats_type type)
+{
+	uint64_t count = 0;
+	uint64_t value = 0;
+	uint32_t qp_id;
+
+	switch (type) {
+	case avg_rt_latency:
+		ML_AVG_FOREACH_QP_TVMRT(cnxk_mldev, model, qp_id, value, count);
+		break;
+	case min_rt_latency:
+		ML_MIN_FOREACH_QP_TVMRT(cnxk_mldev, model, qp_id, value, count);
+		break;
+	case max_rt_latency:
+		ML_MAX_FOREACH_QP_TVMRT(cnxk_mldev, model, qp_id, value, count);
+		break;
+	default:
+		value = 0;
+	}
+
+	return value;
+}
+
+int
+tvmrt_ml_model_load(struct cnxk_ml_dev *cnxk_mldev, struct rte_ml_model_params *params,
+		    struct cnxk_ml_model *model)
+{
+	struct tvmrt_ml_model_object object[ML_TVMRT_MODEL_OBJECT_MAX];
+	struct tvmrt_glow_callback *callback;
+	char str[RTE_MEMZONE_NAMESIZE];
+	char path[PATH_MAX];
+	const struct plt_memzone *mz;
+	size_t model_object_size = 0;
+	size_t model_xstats_size = 0;
+	uint64_t mz_size = 0;
+	TVMFunctionHandle create_fn = NULL;
+	TVMFunctionHandle register_cb_fn = NULL;
+	TVMModuleHandle module_so = NULL;
+	TVMByteArray tvm_params;
+	TVMValue ret_value = {0};
+	TVMValue arg_values[4] = {0};
+	TVMValue tvm_arg_values[1] = {0};
+	int ret_type = kTVMNullptr;
+	int arg_types[4] = {0};
+	int tvm_arg_types[1] = {0};
+	DLDevice device;
+	int ret;
+
+	RTE_SET_USED(cnxk_mldev);
+	model->tvmrt.fd = -1;
+
+	ret = tvmrt_ml_model_blob_parse(params, object);
+	if (ret != 0)
+		return ret;
+
+	model_object_size = RTE_ALIGN_CEIL(object[0].size, RTE_CACHE_LINE_MIN_SIZE) +
+			    RTE_ALIGN_CEIL(object[1].size, RTE_CACHE_LINE_MIN_SIZE) +
+			    RTE_ALIGN_CEIL(object[2].size, RTE_CACHE_LINE_MIN_SIZE);
+
+	model_xstats_size =
+		cnxk_mldev->mldev->data->nb_queue_pairs * sizeof(struct tvmrt_ml_model_xstats);
+
+	mz_size += model_object_size + model_xstats_size;
+
+	/* Allocate memzone for model object */
+	snprintf(str, RTE_MEMZONE_NAMESIZE, "%s_%u", TVMRT_ML_MODEL_MEMZONE_NAME, model->model_id);
+	mz = plt_memzone_reserve_aligned(str, mz_size, 0, ML_CN10K_ALIGN_SIZE);
+	if (!mz) {
+		plt_err("plt_memzone_reserve failed : %s", str);
+		return -ENOMEM;
+	}
+
+	/* Copy mod.so */
+	model->tvmrt.so.buffer = mz->addr;
+	model->tvmrt.so.size = object[0].size;
+	rte_memcpy(model->tvmrt.so.name, object[0].name, RTE_ML_STR_MAX);
+	rte_memcpy(model->tvmrt.so.buffer, object[0].buffer, object[0].size);
+	rte_free(object[0].buffer);
+
+	/* Copy mod.json */
+	model->tvmrt.json.buffer =
+		RTE_PTR_ADD(model->tvmrt.so.buffer,
+			    RTE_ALIGN_CEIL(model->tvmrt.so.size, RTE_CACHE_LINE_MIN_SIZE));
+	model->tvmrt.json.size = object[1].size;
+	rte_memcpy(model->tvmrt.json.name, object[1].name, RTE_ML_STR_MAX);
+	rte_memcpy(model->tvmrt.json.buffer, object[1].buffer, object[1].size);
+	rte_free(object[1].buffer);
+
+	/* Copy mod.params */
+	model->tvmrt.params.buffer =
+		RTE_PTR_ADD(model->tvmrt.json.buffer,
+			    RTE_ALIGN_CEIL(model->tvmrt.json.size, RTE_CACHE_LINE_MIN_SIZE));
+	model->tvmrt.params.size = object[2].size;
+	rte_memcpy(model->tvmrt.params.name, object[2].name, RTE_ML_STR_MAX);
+	rte_memcpy(model->tvmrt.params.buffer, object[2].buffer, object[2].size);
+	rte_free(object[2].buffer);
+
+	ret = tvmrt_ml_model_json_parse(model);
+	if (ret != 0)
+		goto error;
+
+	if (cnxk_mldev->type == CNXK_ML_DEV_TYPE_VDEV &&
+	    model->subtype != ML_CNXK_MODEL_SUBTYPE_TVM_LLVM) {
+		plt_err("Unsupported model sub-type");
+		ret = -ENOTSUP;
+		goto error;
+	}
+
+	/* Set callback function array */
+	if (model->subtype != ML_CNXK_MODEL_SUBTYPE_TVM_LLVM) {
+		callback = &model->tvmrt.cb;
+		callback->tvmrt_glow_layer_load = cn10k_ml_layer_load;
+		callback->tvmrt_glow_layer_unload = cn10k_ml_layer_unload;
+		callback->tvmrt_io_alloc = cn10k_ml_io_alloc;
+		callback->tvmrt_io_free = cn10k_ml_io_free;
+		callback->tvmrt_malloc = cn10k_ml_malloc;
+		callback->tvmrt_free = cn10k_ml_free;
+		callback->tvmrt_quantize = tvmrt_ml_io_quantize;
+		callback->tvmrt_dequantize = tvmrt_ml_io_dequantize;
+		callback->tvmrt_inference = cn10k_ml_inference_sync;
+	} else {
+		callback = NULL;
+	}
+
+	/* Initialize model in TVM runtime */
+	if (model->tvmrt.graph_module != NULL) {
+		ret = -EBUSY;
+		plt_err("TVM runtime: Model load failed, model_id = %u, error = %d",
+			model->model_id, ret);
+		goto error;
+	}
+
+	snprintf(path, sizeof(path), "%s_%d_%u", ML_MODEL_SHMFD_NAME, getpid(), model->model_id);
+	model->tvmrt.fd = memfd_create(path, 0);
+	if (model->tvmrt.fd < 0) {
+		ret = (errno == 0) ? -EIO : -errno;
+		plt_err("TVM runtime: Model load failed, model_id = %u, error = %d",
+			model->model_id, ret);
+		goto error;
+	}
+
+	if (write(model->tvmrt.fd, model->tvmrt.so.buffer, model->tvmrt.so.size) !=
+	    (ssize_t)model->tvmrt.so.size) {
+		ret = (errno == 0) ? -EIO : -errno;
+		plt_err("TVM runtime: Model load failed, model_id = %u, error = %d",
+			model->model_id, ret);
+		goto error;
+	}
+
+	if (lseek(model->tvmrt.fd, 0, SEEK_SET) < 0) {
+		ret = (errno == 0) ? -EIO : -errno;
+		plt_err("TVM runtime: Model load failed, model_id = %u, error = %d",
+			model->model_id, ret);
+		goto error;
+	}
+
+	snprintf(path, sizeof(path), ML_MODEL_SHMFD_PATH, getpid(), model->tvmrt.fd);
+	ret = TVMModLoadFromFile(path, "so", &module_so);
+	if (ret != 0) {
+		plt_err("TVM runtime: Model load failed, model_id = %u, ret = %d, msg = %s",
+			model->model_id, ret, TVMGetLastError());
+		goto error;
+	}
+
+	/* Set device info */
+	device.device_type = kDLCPU;
+	device.device_id = 0;
+
+	if (callback != NULL) {
+		ret = tvmrt_ml_tvm_func_get(model, module_so, "register_cb", &register_cb_fn);
+		if (ret != 0)
+			goto error;
+
+		arg_values[0].v_handle = callback;
+		arg_types[0] = kTVMOpaqueHandle;
+		arg_values[1].v_handle = cnxk_mldev;
+		arg_types[1] = kTVMOpaqueHandle;
+		arg_values[2].v_int64 = model->model_id;
+		arg_types[2] = kDLInt;
+
+		ret = tvmrt_ml_tvm_func_call(model, register_cb_fn, "register_cb", arg_values,
+					     arg_types, 3, &ret_value, &ret_type, kTVMNullptr);
+		if (ret != 0)
+			goto error;
+	}
+
+	ret = TVMFuncGetGlobal("tvm.graph_executor.create", &create_fn);
+	if (ret != 0) {
+		plt_err("TVM runtime: Model load failed, model_id = %u, ret = %d, msg = %s",
+			model->model_id, ret, TVMGetLastError());
+		goto error;
+	}
+
+	arg_values[0].v_str = (const char *)model->tvmrt.json.buffer;
+	arg_types[0] = kTVMStr;
+	arg_values[1].v_handle = module_so;
+	arg_types[1] = kTVMModuleHandle;
+	arg_values[2].v_int64 = device.device_type;
+	arg_types[2] = kDLInt;
+	arg_values[3].v_int64 = device.device_id;
+	arg_types[3] = kDLInt;
+
+	ret = tvmrt_ml_tvm_func_call(model, create_fn, "tvm.graph_executor.create", arg_values,
+				     arg_types, 4, &ret_value, &ret_type, kTVMModuleHandle);
+	if (ret != 0)
+		goto error;
+	model->tvmrt.graph_module = ret_value.v_handle;
+
+	ret = tvmrt_ml_tvm_func_get(model, model->tvmrt.graph_module, "load_params",
+				    &model->tvmrt.load_params);
+	if (ret != 0)
+		goto error;
+	ret = tvmrt_ml_tvm_func_get(model, model->tvmrt.graph_module, "set_input_zero_copy",
+				    &model->tvmrt.set_input_zero_copy);
+	if (ret != 0)
+		goto error;
+	ret = tvmrt_ml_tvm_func_get(model, model->tvmrt.graph_module, "set_output_zero_copy",
+				    &model->tvmrt.set_output_zero_copy);
+	if (ret != 0)
+		goto error;
+	ret = tvmrt_ml_tvm_func_get(model, model->tvmrt.graph_module, "run", &model->tvmrt.run);
+	if (ret != 0)
+		goto error;
+
+	tvmrt_ml_tvm_func_free(&register_cb_fn);
+	tvmrt_ml_tvm_mod_free(&module_so);
+
+	/* Load model parameters into TVM runtime */
+	tvm_params.data = (const char *)model->tvmrt.params.buffer;
+	tvm_params.size = model->tvmrt.params.size;
+	tvm_arg_values[0].v_handle = &tvm_params;
+	tvm_arg_types[0] = kTVMBytes;
+
+	ret = tvmrt_ml_tvm_func_call(model, model->tvmrt.load_params, "load_params", tvm_arg_values,
+				     tvm_arg_types, 1, &ret_value, &ret_type, kTVMNullptr);
+	if (ret != 0)
+		goto error;
+
+	/* Update model I/O data */
+	tvmrt_ml_model_io_info_set(model);
+
+	/* Set model info */
+	tvmrt_ml_model_info_set(cnxk_mldev, model);
+
+	/* Update model xstats name */
+	cnxk_ml_xstats_model_name_update(cnxk_mldev, model->model_id);
+
+	model->tvmrt.burst_xstats =
+		RTE_PTR_ADD(model->tvmrt.params.buffer,
+			    RTE_ALIGN_CEIL(model->tvmrt.params.size, RTE_CACHE_LINE_MIN_SIZE));
+
+	for (int qp_id = 0; qp_id < cnxk_mldev->mldev->data->nb_queue_pairs; qp_id++) {
+		model->tvmrt.burst_xstats[qp_id].tvm_rt_latency_tot = 0;
+		model->tvmrt.burst_xstats[qp_id].tvm_rt_latency = 0;
+		model->tvmrt.burst_xstats[qp_id].tvm_rt_latency_min = UINT64_MAX;
+		model->tvmrt.burst_xstats[qp_id].tvm_rt_latency_max = 0;
+		model->tvmrt.burst_xstats[qp_id].tvm_rt_reset_count = 0;
+		model->tvmrt.burst_xstats[qp_id].dequeued_count = 0;
+	}
+
+	/* Set model specific fast path functions */
+	if (model->subtype == ML_CNXK_MODEL_SUBTYPE_TVM_MRVL) {
+		model->enqueue_single = cn10k_ml_enqueue_single;
+		model->result_update = cn10k_ml_result_update;
+		model->set_error_code = cn10k_ml_set_error_code;
+		model->set_poll_addr = cn10k_ml_set_poll_addr;
+		model->op_error_get = cn10k_ml_op_error_get;
+	} else {
+		model->enqueue_single = tvmrt_ml_enqueue_single;
+		model->result_update = tvmrt_ml_result_update;
+		model->set_error_code = tvmrt_ml_set_error_code;
+		model->set_poll_addr = tvmrt_ml_set_poll_addr;
+		model->op_error_get = tvmrt_ml_op_error_get;
+	}
+
+	return 0;
+
+error:
+	tvmrt_ml_tvm_func_free(&register_cb_fn);
+	if (model != NULL) {
+		tvmrt_ml_tvm_func_free(&model->tvmrt.load_params);
+		tvmrt_ml_tvm_func_free(&model->tvmrt.set_input_zero_copy);
+		tvmrt_ml_tvm_func_free(&model->tvmrt.set_output_zero_copy);
+		tvmrt_ml_tvm_func_free(&model->tvmrt.run);
+		tvmrt_ml_tvm_mod_free(&model->tvmrt.graph_module);
+		if (model->tvmrt.fd >= 0)
+			close(model->tvmrt.fd);
+		memset(&model->tvmrt, 0, sizeof(model->tvmrt));
+		model->tvmrt.fd = -1;
+	}
+	tvmrt_ml_tvm_mod_free(&module_so);
+	plt_memzone_free(mz);
+
+	return ret;
+}
+
+int
+tvmrt_ml_model_unload(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model)
+{
+	char str[RTE_MEMZONE_NAMESIZE];
+	const struct plt_memzone *mz;
+
+	RTE_SET_USED(cnxk_mldev);
+
+	/* Unload model from TVM runtime */
+	if (model->model_id >= cnxk_mldev->mldev->data->nb_models)
+		return -EINVAL;
+
+	if (model->tvmrt.graph_module == NULL)
+		return -EINVAL;
+
+	tvmrt_ml_tvm_func_free(&model->tvmrt.load_params);
+	tvmrt_ml_tvm_func_free(&model->tvmrt.set_input_zero_copy);
+	tvmrt_ml_tvm_func_free(&model->tvmrt.set_output_zero_copy);
+	tvmrt_ml_tvm_func_free(&model->tvmrt.run);
+	tvmrt_ml_tvm_mod_free(&model->tvmrt.graph_module);
+	if (model->tvmrt.fd >= 0)
+		close(model->tvmrt.fd);
+	memset(&model->tvmrt, 0, sizeof(model->tvmrt));
+	model->tvmrt.fd = -1;
+
+	snprintf(str, RTE_MEMZONE_NAMESIZE, "%s_%u", TVMRT_ML_MODEL_MEMZONE_NAME, model->model_id);
+	mz = plt_memzone_lookup(str);
+	if (mz == NULL) {
+		plt_err("Memzone lookup failed for TVM model: model_id = %u, mz = %s",
+			model->model_id, str);
+		return -EINVAL;
+	}
+
+	return plt_memzone_free(mz);
+}
+
+int
+tvmrt_ml_model_start(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model)
+{
+	struct cnxk_ml_layer *layer;
+
+	uint16_t layer_id = 0;
+	int ret = 0;
+
+next_layer:
+	layer = &model->layer[layer_id];
+	if (layer->type == ML_CNXK_LAYER_TYPE_MRVL) {
+		ret = cn10k_ml_layer_start(cnxk_mldev, model->model_id, layer->name);
+		if (ret != 0) {
+			plt_err("Layer start failed, model_id = %u, layer_name = %s, error = %d",
+				model->model_id, layer->name, ret);
+			return ret;
+		}
+	}
+	layer_id++;
+
+	if (layer_id < model->nb_layers)
+		goto next_layer;
+
+	return 0;
+}
+
+int
+tvmrt_ml_model_stop(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model)
+{
+	struct cnxk_ml_layer *layer;
+
+	uint16_t layer_id = 0;
+	int ret = 0;
+
+next_layer:
+	layer = &model->layer[layer_id];
+	if (layer->type == ML_CNXK_LAYER_TYPE_MRVL) {
+		ret = cn10k_ml_layer_stop(cnxk_mldev, model->model_id, layer->name);
+		if (ret != 0) {
+			plt_err("Layer stop failed, model_id = %u, layer_name = %s, error = %d",
+				model->model_id, layer->name, ret);
+			return ret;
+		}
+	}
+	layer_id++;
+
+	if (layer_id < model->nb_layers)
+		goto next_layer;
+
+	return 0;
+}
+
+int
+tvmrt_ml_io_quantize(void *device, uint16_t model_id, const char *layer_name,
+		     const DLTensor **deq_tensor, void *qbuffer)
+{
+	struct cnxk_ml_io_info *info = NULL;
+	struct cnxk_ml_dev *cnxk_mldev;
+	struct cnxk_ml_model *model;
+	uint16_t layer_id = 0;
+	uint8_t *lcl_dbuffer;
+	uint8_t *lcl_qbuffer;
+	uint32_t i;
+	int ret;
+
+#ifdef CNXK_ML_DEV_DEBUG
+	if ((device == NULL) || (deq_tensor == NULL) || (qbuffer == NULL))
+		return -EINVAL;
+#endif
+
+	cnxk_mldev = (struct cnxk_ml_dev *)device;
+
+	model = cnxk_mldev->mldev->data->models[model_id];
+#ifdef CNXK_ML_DEV_DEBUG
+	if (model == NULL) {
+		plt_err("Invalid model_id = %u", model_id);
+		return -EINVAL;
+	}
+#endif
+
+	/* Get layer id */
+	for (layer_id = 0; layer_id < model->nb_layers; layer_id++) {
+		if (strcmp(model->layer[layer_id].name, layer_name) == 0)
+			break;
+	}
+
+#ifdef CNXK_ML_DEV_DEBUG
+	if (layer_id == model->nb_layers) {
+		plt_err("Invalid layer name: %s", layer_name);
+		return -EINVAL;
+	}
+
+	if (model->layer[layer_id].type != ML_CNXK_LAYER_TYPE_MRVL) {
+		plt_err("Invalid layer name / type: %s", layer_name);
+		return -EINVAL;
+	}
+#endif
+
+	info = &model->layer[layer_id].info;
+	lcl_qbuffer = (uint8_t *)qbuffer;
+
+	for (i = 0; i < info->nb_inputs; i++) {
+		lcl_dbuffer = PLT_PTR_ADD(deq_tensor[i]->data, deq_tensor[i]->byte_offset);
+
+		ret = cnxk_ml_io_quantize_single(&info->input[i], lcl_dbuffer, lcl_qbuffer);
+		if (ret < 0)
+			return ret;
+
+		lcl_qbuffer += info->input[i].sz_q;
+	}
+
+	return 0;
+}
+
+int
+tvmrt_ml_io_dequantize(void *device, uint16_t model_id, const char *layer_name, void *qbuffer,
+		       const DLTensor **deq_tensor)
+{
+	struct cnxk_ml_io_info *info = NULL;
+	struct cnxk_ml_dev *cnxk_mldev;
+	struct cnxk_ml_model *model;
+	uint16_t layer_id = 0;
+	uint8_t *lcl_dbuffer;
+	uint8_t *lcl_qbuffer;
+	uint32_t i;
+	int ret;
+
+#ifdef CNXK_ML_DEV_DEBUG
+	if ((device == NULL) || (deq_tensor == NULL) || (qbuffer == NULL))
+		return -EINVAL;
+#endif
+
+	cnxk_mldev = (struct cnxk_ml_dev *)device;
+
+	model = cnxk_mldev->mldev->data->models[model_id];
+#ifdef CNXK_ML_DEV_DEBUG
+	if (model == NULL) {
+		plt_err("Invalid model_id = %u", model_id);
+		return -EINVAL;
+	}
+#endif
+
+	for (layer_id = 0; layer_id < model->nb_layers; layer_id++) {
+		if (strcmp(model->layer[layer_id].name, layer_name) == 0)
+			break;
+	}
+
+#ifdef CNXK_ML_DEV_DEBUG
+	if (layer_id == model->nb_layers) {
+		plt_err("Invalid layer name: %s", layer_name);
+		return -EINVAL;
+	}
+
+	if (model->layer[layer_id].type != ML_CNXK_LAYER_TYPE_MRVL) {
+		plt_err("Invalid layer name / type: %s", layer_name);
+		return -EINVAL;
+	}
+#endif
+
+	info = &model->layer[layer_id].info;
+	lcl_qbuffer = (uint8_t *)qbuffer;
+
+	for (i = 0; i < info->nb_outputs; i++) {
+		lcl_dbuffer = PLT_PTR_ADD(deq_tensor[i]->data, deq_tensor[i]->byte_offset);
+
+		ret = cnxk_ml_io_dequantize_single(&info->output[i], lcl_qbuffer, lcl_dbuffer);
+		if (ret < 0)
+			return ret;
+
+		lcl_qbuffer += info->output[i].sz_q;
+	}
+
+	return 0;
+}
+
+static int
+tvmrt_ml_model_run(struct cnxk_ml_model *model, struct rte_ml_op *op, struct cnxk_ml_req *req)
+{
+	uint8_t i;
+	struct tvmrt_ml_result *run_result;
+	TVMValue arg_values[2] = {0};
+	int arg_types[2] = {0};
+	TVMValue ret_value = {0};
+	int ret_type = kTVMNullptr;
+	int ret = 0;
+
+	rte_memcpy(req->tvmrt_req.input_tensor, model->tvmrt.input_tensor,
+		   model->tvmrt.info.nb_inputs * sizeof(DLTensor));
+	for (i = 0; i < model->tvmrt.info.nb_inputs; i++) {
+		req->tvmrt_req.input_tensor[i].data = op->input[i]->addr;
+		req->tvmrt_req.input_tensor[i].byte_offset = 0;
+	}
+
+	rte_memcpy(req->tvmrt_req.output_tensor, model->tvmrt.output_tensor,
+		   model->tvmrt.info.nb_outputs * sizeof(DLTensor));
+	for (i = 0; i < model->tvmrt.info.nb_outputs; i++) {
+		req->tvmrt_req.output_tensor[i].data = op->output[i]->addr;
+		req->tvmrt_req.output_tensor[i].byte_offset = 0;
+	}
+
+	run_result = &req->tvmrt_req.result;
+	run_result->stats.start_ns = rte_get_tsc_cycles();
+	run_result->error_code = 0;
+
+	for (i = 0; i < model->tvmrt.info.nb_inputs; i++) {
+		arg_values[0].v_int64 = i;
+		arg_types[0] = kDLInt;
+		arg_values[1].v_handle = &req->tvmrt_req.input_tensor[i];
+		arg_types[1] = kTVMDLTensorHandle;
+		ret = tvmrt_ml_tvm_func_call(model, model->tvmrt.set_input_zero_copy,
+					     "set_input_zero_copy", arg_values, arg_types, 2,
+					     &ret_value, &ret_type, kTVMNullptr);
+		if (ret != 0)
+			goto out;
+	}
+
+	for (i = 0; i < model->tvmrt.info.nb_outputs; i++) {
+		arg_values[0].v_int64 = i;
+		arg_types[0] = kDLInt;
+		arg_values[1].v_handle = &req->tvmrt_req.output_tensor[i];
+		arg_types[1] = kTVMDLTensorHandle;
+		ret = tvmrt_ml_tvm_func_call(model, model->tvmrt.set_output_zero_copy,
+					     "set_output_zero_copy", arg_values, arg_types, 2,
+					     &ret_value, &ret_type, kTVMNullptr);
+		if (ret != 0)
+			goto out;
+	}
+
+	ret = tvmrt_ml_tvm_func_call(model, model->tvmrt.run, "run", NULL, NULL, 0, &ret_value,
+				     &ret_type, kTVMNullptr);
+	if (ret != 0)
+		goto out;
+
+out:
+	run_result->stats.end_ns = rte_get_tsc_cycles();
+	req->tvmrt_req.status = 0x1;
+
+	plt_write64(ML_CNXK_POLL_JOB_FINISH, req->status);
+
+	if (ret != 0)
+		run_result->error_code = -EIO;
+
+	return 0;
+}
+
+__rte_hot void
+tvmrt_ml_set_error_code(struct cnxk_ml_req *req, uint64_t etype, uint64_t stype)
+{
+	RTE_SET_USED(stype);
+
+	req->tvmrt_req.result.error_code = etype;
+}
+
+__rte_hot int
+tvmrt_ml_op_error_get(struct cnxk_ml_dev *cnxk_mldev, struct rte_ml_op *op,
+		      struct rte_ml_op_error *error)
+{
+	RTE_SET_USED(cnxk_mldev);
+	RTE_SET_USED(op);
+	RTE_SET_USED(error);
+
+	return 0;
+}
+
+__rte_hot bool
+tvmrt_ml_enqueue_single(struct cnxk_ml_dev *cnxk_mldev, struct rte_ml_op *op, uint16_t layer_id,
+			struct cnxk_ml_qp *qp, uint64_t head)
+{
+	struct cnxk_ml_model *model;
+	struct cnxk_ml_queue *queue;
+	struct cnxk_ml_req *req;
+
+	RTE_SET_USED(layer_id);
+
+	queue = &qp->queue;
+	req = &queue->reqs[head];
+	model = cnxk_mldev->mldev->data->models[op->model_id];
+
+	model->set_poll_addr(req);
+	memset(&req->tvmrt_req.result, 0, sizeof(struct tvmrt_ml_result));
+	req->tvmrt_req.result.error_code = 0x0;
+	req->tvmrt_req.result.user_ptr = op->user_ptr;
+
+	cnxk_ml_set_poll_ptr(req);
+	tvmrt_ml_model_run(model, op, req);
+	req->timeout = plt_tsc_cycles() + queue->wait_cycles;
+	req->op = op;
+
+	return true;
+}
+
+__rte_hot void
+tvmrt_ml_result_update(struct cnxk_ml_dev *cnxk_mldev, int qp_id, void *request)
+{
+	struct tvmrt_ml_model_xstats *xstats;
+	struct tvmrt_ml_result *result;
+	struct cnxk_ml_model *model;
+	struct cnxk_ml_req *req;
+	uint64_t tvm_rt_latency;
+	struct cnxk_ml_qp *qp;
+	struct rte_ml_op *op;
+
+	req = (struct cnxk_ml_req *)request;
+	result = &req->tvmrt_req.result;
+	op = req->op;
+	qp = cnxk_mldev->mldev->data->queue_pairs[qp_id];
+	op->impl_opaque = result->error_code;
+
+	if (likely(result->error_code == 0)) {
+		qp->stats.dequeued_count++;
+		op->status = RTE_ML_OP_STATUS_SUCCESS;
+
+		model = cnxk_mldev->mldev->data->models[op->model_id];
+		xstats = &model->tvmrt.burst_xstats[qp_id];
+
+		if (unlikely(xstats->dequeued_count == xstats->tvm_rt_reset_count)) {
+			xstats->tvm_rt_latency_min = UINT64_MAX;
+			xstats->tvm_rt_latency_max = 0;
+		}
+		tvm_rt_latency = result->stats.end_ns - result->stats.start_ns;
+		xstats->tvm_rt_latency = tvm_rt_latency;
+		xstats->tvm_rt_latency_tot += tvm_rt_latency;
+		xstats->tvm_rt_latency_min = RTE_MIN(xstats->tvm_rt_latency_min, tvm_rt_latency);
+		xstats->tvm_rt_latency_max = RTE_MAX(xstats->tvm_rt_latency_max, tvm_rt_latency);
+		xstats->dequeued_count++;
+	} else {
+		qp->stats.dequeue_err_count++;
+		op->status = RTE_ML_OP_STATUS_ERROR;
+	}
+}
diff --git a/drivers/ml/cnxk/tvmrt_ml_ops.h b/drivers/ml/cnxk/tvmrt_ml_ops.h
new file mode 100644
index 00000000000..f76f2ea000d
--- /dev/null
+++ b/drivers/ml/cnxk/tvmrt_ml_ops.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2026 Marvell.
+ */
+
+#ifndef _TVMRT_ML_OPS_H_
+#define _TVMRT_ML_OPS_H_
+
+#include <dlpack/dlpack.h>
+
+#include <rte_mldev.h>
+
+#include "cnxk_ml_xstats.h"
+#include "tvmrt_ml_model.h"
+
+struct cnxk_ml_dev;
+struct cnxk_ml_model;
+struct cnxk_ml_layer;
+struct cnxk_ml_qp;
+struct cnxk_ml_req;
+
+/* Inference stats */
+struct tvmrt_ml_stats {
+	/* Start ns */
+	uint64_t start_ns;
+
+	/* Start ns */
+	uint64_t end_ns;
+};
+
+/* Result structure */
+struct tvmrt_ml_result {
+	/* Job error code */
+	uint64_t error_code;
+
+	/* Inference stats */
+	struct tvmrt_ml_stats stats;
+
+	/* User context pointer */
+	void *user_ptr;
+};
+
+/* TVMRT specific request */
+struct tvmrt_ml_req {
+	/* Input tensors */
+	DLTensor input_tensor[ML_CNXK_MODEL_MAX_INPUT_OUTPUT];
+
+	/* Output tensors */
+	DLTensor output_tensor[ML_CNXK_MODEL_MAX_INPUT_OUTPUT];
+
+	/* Status field for poll mode requests */
+	volatile uint64_t status;
+
+	/* Result */
+	struct tvmrt_ml_result result;
+};
+
+int tvmrt_ml_model_load(struct cnxk_ml_dev *cnxk_mldev, struct rte_ml_model_params *params,
+			struct cnxk_ml_model *model);
+int tvmrt_ml_model_unload(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model);
+int tvmrt_ml_model_start(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model);
+int tvmrt_ml_model_stop(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model);
+int tvmrt_ml_io_quantize(void *device, uint16_t model_id, const char *layer_name,
+			 const DLTensor **deq_tensor, void *qbuffer);
+int tvmrt_ml_io_dequantize(void *device, uint16_t model_id, const char *layer_name, void *qbuffer,
+			   const DLTensor **deq_tensor);
+
+__rte_hot bool tvmrt_ml_enqueue_single(struct cnxk_ml_dev *cnxk_mldev, struct rte_ml_op *op,
+				       uint16_t layer_id, struct cnxk_ml_qp *qp, uint64_t head);
+__rte_hot int tvmrt_ml_op_error_get(struct cnxk_ml_dev *cnxk_mldev, struct rte_ml_op *op,
+				    struct rte_ml_op_error *error);
+__rte_hot void tvmrt_ml_result_update(struct cnxk_ml_dev *cnxk_mldev, int qp_id, void *request);
+__rte_hot void tvmrt_ml_set_error_code(struct cnxk_ml_req *req, uint64_t etype, uint64_t stype);
+
+void tvmrt_ml_model_xstat_name_set(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model,
+				   uint16_t stat_id, uint16_t entry, char *suffix);
+uint64_t tvmrt_ml_model_xstat_get(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model,
+				  enum cnxk_ml_xstats_type type);
+
+#endif /* _TVMRT_ML_OPS_H_ */
diff --git a/drivers/ml/cnxk/tvmrt_ml_stubs.c b/drivers/ml/cnxk/tvmrt_ml_stubs.c
new file mode 100644
index 00000000000..0b4e53b4327
--- /dev/null
+++ b/drivers/ml/cnxk/tvmrt_ml_stubs.c
@@ -0,0 +1,106 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2026 Marvell.
+ */
+
+#include <rte_mldev.h>
+
+#include "tvmrt_ml_stubs.h"
+
+#include "cnxk_ml_dev.h"
+#include "cnxk_ml_model.h"
+#include "cnxk_ml_xstats.h"
+
+enum cnxk_ml_model_type
+tvmrt_ml_model_type_get(struct rte_ml_model_params *params)
+{
+	RTE_SET_USED(params);
+
+	return ML_CNXK_MODEL_TYPE_UNKNOWN;
+}
+
+int
+tvmrt_ml_model_get_layer_id(struct cnxk_ml_model *model, const char *layer_name, uint16_t *layer_id)
+{
+	RTE_SET_USED(model);
+	RTE_SET_USED(layer_name);
+	RTE_SET_USED(layer_id);
+
+	return -EINVAL;
+}
+
+struct cnxk_ml_io_info *
+tvmrt_ml_model_io_info_get(struct cnxk_ml_model *model, uint16_t layer_id)
+{
+	RTE_SET_USED(model);
+	RTE_SET_USED(layer_id);
+
+	return NULL;
+}
+
+void
+tvmrt_ml_layer_print(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_layer *layer, FILE *fp)
+{
+	RTE_SET_USED(cnxk_mldev);
+	RTE_SET_USED(layer);
+	RTE_SET_USED(fp);
+}
+
+void
+tvmrt_ml_model_xstat_name_set(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model,
+			      uint16_t stat_id, uint16_t entry, char *suffix)
+{
+	RTE_SET_USED(cnxk_mldev);
+	RTE_SET_USED(model);
+	RTE_SET_USED(stat_id);
+	RTE_SET_USED(entry);
+	RTE_SET_USED(suffix);
+}
+
+uint64_t
+tvmrt_ml_model_xstat_get(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model,
+			 enum cnxk_ml_xstats_type type)
+{
+	RTE_SET_USED(cnxk_mldev);
+	RTE_SET_USED(model);
+	RTE_SET_USED(type);
+
+	return 0;
+}
+
+int
+tvmrt_ml_model_load(struct cnxk_ml_dev *cnxk_mldev, struct rte_ml_model_params *params,
+		    struct cnxk_ml_model *model)
+{
+	RTE_SET_USED(cnxk_mldev);
+	RTE_SET_USED(params);
+	RTE_SET_USED(model);
+
+	return -EINVAL;
+}
+
+int
+tvmrt_ml_model_unload(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model)
+{
+	RTE_SET_USED(cnxk_mldev);
+	RTE_SET_USED(model);
+
+	return -EINVAL;
+}
+
+int
+tvmrt_ml_model_start(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model)
+{
+	RTE_SET_USED(cnxk_mldev);
+	RTE_SET_USED(model);
+
+	return -EINVAL;
+}
+
+int
+tvmrt_ml_model_stop(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model)
+{
+	RTE_SET_USED(cnxk_mldev);
+	RTE_SET_USED(model);
+
+	return -EINVAL;
+}
diff --git a/drivers/ml/cnxk/tvmrt_ml_stubs.h b/drivers/ml/cnxk/tvmrt_ml_stubs.h
new file mode 100644
index 00000000000..e0260d36514
--- /dev/null
+++ b/drivers/ml/cnxk/tvmrt_ml_stubs.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2026 Marvell.
+ */
+
+#ifndef _TVMRT_ML_STUBS_H_
+#define _TVMRT_ML_STUBS_H_
+
+#include <rte_mldev.h>
+
+#include "cnxk_ml_xstats.h"
+
+struct cnxk_ml_dev;
+struct cnxk_ml_model;
+struct cnxk_ml_layer;
+
+enum cnxk_ml_model_type tvmrt_ml_model_type_get(struct rte_ml_model_params *params);
+int tvmrt_ml_model_load(struct cnxk_ml_dev *cnxk_mldev, struct rte_ml_model_params *params,
+			struct cnxk_ml_model *model);
+int tvmrt_ml_model_unload(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model);
+int tvmrt_ml_model_start(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model);
+int tvmrt_ml_model_stop(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model);
+
+int tvmrt_ml_model_get_layer_id(struct cnxk_ml_model *model, const char *layer_name,
+				uint16_t *layer_id);
+struct cnxk_ml_io_info *tvmrt_ml_model_io_info_get(struct cnxk_ml_model *model, uint16_t layer_id);
+void tvmrt_ml_layer_print(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_layer *layer, FILE *fp);
+void tvmrt_ml_model_xstat_name_set(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model,
+				   uint16_t stat_id, uint16_t entry, char *suffix);
+uint64_t tvmrt_ml_model_xstat_get(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model,
+				  enum cnxk_ml_xstats_type type);
+
+#endif /* _TVMRT_ML_STUBS_H_ */
-- 
2.34.1

