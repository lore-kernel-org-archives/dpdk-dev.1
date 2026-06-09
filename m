Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731C8CD8CAC
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 04:42:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 446314042E;
	Tue,  9 Jun 2026 06:42:09 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id CD3A0400EF
 for <dev@dpdk.org>; Tue,  9 Jun 2026 06:42:07 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65941mUO3963446 for <dev@dpdk.org>; Mon, 8 Jun 2026 21:42:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=0fTbogRMTIQPRkD6DqNUSPU
 Z+4secFaq7DpmMWa6hnc=; b=Y2K+zYmsYAq5hgDMUmLcTCsi5Zbr/yFR+29vOK4
 52lfdq3DpCJ+QrJsAyw98lY2dOrOm8/epUwjj5YTrbQ9N1ZqMCSkRJxOxFF7hAWG
 IC3TXliDTfUn6ULcNe0EX2SxF7TfkoQtV3Yxonp+rASuKNLZVJwE6OiTKF8YqtBU
 hLiZ4gVWCtBdGiSDIygghdJaZJ44U6QfYe6yEJohAi3/Eoum3qb9sR5A5ZyNdFV5
 vW5INvVF6Ff/twIKE1W/MBauR6zN3DF/6u4298TrpLRSMaORPz8pc5W25F5q6kFE
 FLBn0xsXD5EhpBNXZAvxBLCfvVyoBe3mIZCgACBrdKvV9AA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4en7t8y1s0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 08 Jun 2026 21:42:06 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 8 Jun 2026 21:42:05 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 8 Jun 2026 21:42:05 -0700
Received: from sj4r760o4u9.sclab.marvell.com (unknown [10.110.150.37])
 by maili.marvell.com (Postfix) with ESMTP id 634A53F704E;
 Mon,  8 Jun 2026 21:42:05 -0700 (PDT)
From: Srikanth Yalavarthi <syalavarthi@marvell.com>
To: Srikanth Yalavarthi <syalavarthi@marvell.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, <sshankarnara@marvell.com>,
 <ptakkar@marvell.com>, <aprabhu@marvell.com>
Subject: [PATCH 1/3] ml/cnxk: update driver to use TVM C runtime
Date: Tue, 9 Jun 2026 10:12:00 +0530
Message-ID: <20260609044202.936153-1-syalavarthi@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA0MCBTYWx0ZWRfX7SrncHfrSaNL
 YHJcqp8pLGsMy8tx23eBzI3jMyxu9drROvEcG29tCQz2h/l5VYEnB2/vQWMNdhKoEuNjNko7I8u
 yGlBlPiQdsOL7l3UK/xfGPls5W9hi6bF/XdbNUV6n8XqznniJHRIafWKE+1mqhmBFG9ZdamF9jU
 GigOQE9MCg5mnAdJGOvesWrDHSD3VQsWW+x1rjpStxuiUCTjPsdWQl+crkUyby341Y2lbCToNzu
 e6nJ9jI7jxVtbU5/eDmh49eItjRMnqDGQjPsw5GLtRPohJrXtjSAOsYUVY2VZB5zU5R8sx5oe7O
 bvPyu0/h8HUklqJBo4LJPVikj1DJKQxsdlBOFdh0tDjRPcohOsTZL6qXwFXH+hvVhpC4tTJpUmw
 K+CBiqsBUjtEFFG/bK1SLdUTeUbc/ULRkN3/CVwLhaJ1agBtkTEthW9SSGbKKhiEfNnnQnZyOG9
 YOWed+D+6kSyUq6KzdA==
X-Authority-Analysis: v=2.4 cv=evLvCIpX c=1 sm=1 tr=0 ts=6a27999e cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=NEAV23lmAAAA:8 a=M5GUcnROAAAA:8 a=yLBtYE77AAAA:8
 a=YvSOJtRPST-JSjD3IuwA:9 a=O8hF6Hzn-FEA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=563i--EqTaB_-fmO0r4f:22
X-Proofpoint-ORIG-GUID: cdeIsxyulB7Eio8hXpLS962gtG6IcHcH
X-Proofpoint-GUID: cdeIsxyulB7Eio8hXpLS962gtG6IcHcH
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

Updated MVTVM layer of the driver to call TVM C runtime
API functions, instead on the TVMDP wrapper library APIs.

Drop all dependencies on TVMDP wrapper library.

Signed-off-by: Srikanth Yalavarthi <syalavarthi@marvell.com>
---
 doc/guides/mldevs/cnxk.rst       |  35 +-
 drivers/ml/cnxk/cnxk_ml_io.h     |  20 +-
 drivers/ml/cnxk/cnxk_ml_ops.c    |  12 +-
 drivers/ml/cnxk/meson.build      |  14 +-
 drivers/ml/cnxk/mvtvm_ml_dev.h   |   3 -
 drivers/ml/cnxk/mvtvm_ml_model.c | 638 ++++++++++++++++++++++++++++---
 drivers/ml/cnxk/mvtvm_ml_model.h |  81 +++-
 drivers/ml/cnxk/mvtvm_ml_ops.c   | 440 ++++++++++++++-------
 drivers/ml/cnxk/mvtvm_ml_ops.h   |   5 +-
 drivers/ml/cnxk/mvtvm_ml_stubs.c |  17 -
 drivers/ml/cnxk/mvtvm_ml_stubs.h |   2 -
 11 files changed, 985 insertions(+), 282 deletions(-)

diff --git a/doc/guides/mldevs/cnxk.rst b/doc/guides/mldevs/cnxk.rst
index fc1bcd9cdb4..17e58d81c0b 100644
--- a/doc/guides/mldevs/cnxk.rst
+++ b/doc/guides/mldevs/cnxk.rst
@@ -111,13 +111,13 @@ on CPU cores or hardware accelerators.
 
 .. note::
 
-   DPDK CNXK ML driver requires TVM version 0.10.0
+   DPDK CNXK ML driver requires TVM version legacy-v0.19.post branch.
 
 .. code-block:: console
 
    git clone https://github.com/apache/tvm.git
    cd tvm
-   git checkout v0.11.0 -b v0.11.0
+   git checkout legacy-v0.19.post -b legacy-v0.19.post
    git submodule update --init
    cmake -S ./ -B build \
       -DCMAKE_INSTALL_PREFIX=<install_prefix> \
@@ -135,37 +135,6 @@ When cross-compiling, more options must be provided to CMake:
    -DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER \
    -DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY
 
-TVMDP
-~~~~~
-
-  Marvell's `TVM Dataplane Library <https://github.com/MarvellEmbeddedProcessors/tvmdp>`_
-  works as an interface between TVM runtime and DPDK drivers.
-  TVMDP library provides a simplified C interface
-  for TVM's runtime based on C++.
-
-.. note::
-
-   TVMDP library is dependent on TVM, dlpack, jansson and dmlc-core libraries.
-
-.. code-block:: console
-
-   git clone https://github.com/MarvellEmbeddedProcessors/tvmdp.git
-   cd tvmdp
-   git checkout main
-   cmake -S ./ -B build \
-      -DCMAKE_INSTALL_PREFIX=<install_prefix> \
-      -DBUILD_SHARED_LIBS=ON
-   make -C build
-   make -C build install
-
-When cross-compiling, more options must be provided to CMake:
-
-.. code-block:: console
-
-   -DCMAKE_C_COMPILER=aarch64-linux-gnu-gcc \
-   -DCMAKE_CXX_COMPILER=aarch64-linux-gnu-g++ \
-   -DCMAKE_FIND_ROOT_PATH=<install_prefix>
-
 libarchive
 ~~~~~~~~~~
 
diff --git a/drivers/ml/cnxk/cnxk_ml_io.h b/drivers/ml/cnxk/cnxk_ml_io.h
index 83329c237aa..17f5b4619f0 100644
--- a/drivers/ml/cnxk/cnxk_ml_io.h
+++ b/drivers/ml/cnxk/cnxk_ml_io.h
@@ -6,7 +6,7 @@
 #define _CNXK_ML_IO_H_
 
 #ifdef RTE_MLDEV_CNXK_ENABLE_MVTVM
-#include <tvmdp.h>
+#include <dlpack/dlpack.h>
 #endif
 
 #include <rte_mldev.h>
@@ -16,7 +16,7 @@
 
 /* Maximum number of layers per model */
 #ifdef RTE_MLDEV_CNXK_ENABLE_MVTVM
-#define ML_CNXK_MODEL_MAX_LAYERS TVMDP_MODEL_LAYERS_MAX
+#define ML_CNXK_MODEL_MAX_LAYERS 128
 #else
 #define ML_CNXK_MODEL_MAX_LAYERS 1
 #endif
@@ -41,7 +41,7 @@ struct cnxk_ml_io {
 	/* Number of dimensions in shape */
 	uint32_t nb_dims;
 
-	/* Shape of input */
+	/* Shape */
 	uint32_t shape[ML_CNXK_MODEL_MAX_DIMS];
 
 	/* Number of elements */
@@ -58,6 +58,20 @@ struct cnxk_ml_io {
 
 	/* Zero point */
 	int64_t zero_point;
+
+#ifdef RTE_MLDEV_CNXK_ENABLE_MVTVM
+	/* Shape - int64_t */
+	int64_t shape_i64[ML_CNXK_MODEL_MAX_DIMS];
+
+	/* Data type */
+	DLDataType datatype;
+
+	/* Model data type */
+	DLDataType model_datatype;
+
+	/* Device */
+	DLDevice device;
+#endif
 };
 
 /* Model / Layer IO structure */
diff --git a/drivers/ml/cnxk/cnxk_ml_ops.c b/drivers/ml/cnxk/cnxk_ml_ops.c
index 9958945670a..938982c7556 100644
--- a/drivers/ml/cnxk/cnxk_ml_ops.c
+++ b/drivers/ml/cnxk/cnxk_ml_ops.c
@@ -634,10 +634,6 @@ cnxk_ml_dev_configure(struct rte_ml_dev *dev, const struct rte_ml_dev_config *co
 		}
 	}
 
-	ret = mvtvm_ml_dev_configure(cnxk_mldev, conf);
-	if (ret != 0)
-		goto error;
-
 	/* Set device capabilities */
 	if (cnxk_mldev->type == CNXK_ML_DEV_TYPE_PCI)
 		cnxk_mldev->max_nb_layers =
@@ -705,9 +701,6 @@ cnxk_ml_dev_close(struct rte_ml_dev *dev)
 	/* Un-initialize xstats */
 	cnxk_ml_xstats_uninit(cnxk_mldev);
 
-	if (mvtvm_ml_dev_close(cnxk_mldev) != 0)
-		plt_err("Failed to close MVTVM ML Device");
-
 	if (cnxk_mldev->type == CNXK_ML_DEV_TYPE_PCI) {
 		if (cn10k_ml_dev_close(cnxk_mldev) != 0)
 			plt_err("Failed to close CN10K ML Device");
@@ -1234,7 +1227,7 @@ cnxk_ml_model_load(struct rte_ml_dev *dev, struct rte_ml_model_params *params, u
 					    model->layer[layer_id].glow.ocm_map.scratch_pages);
 #ifdef RTE_MLDEV_CNXK_ENABLE_MVTVM
 	} else {
-		for (layer_id = 0; layer_id < model->mvtvm.metadata.model.nb_layers; layer_id++) {
+		for (layer_id = 0; layer_id < model->nb_layers; layer_id++) {
 			if (model->layer[layer_id].type == ML_CNXK_LAYER_TYPE_MRVL) {
 				total_wb_pages = total_wb_pages +
 						 model->layer[layer_id].glow.ocm_map.wb_pages;
@@ -1256,8 +1249,7 @@ cnxk_ml_model_load(struct rte_ml_dev *dev, struct rte_ml_model_params *params, u
 				   model->layer[layer_id].glow.ocm_map.scratch_pages);
 #ifdef RTE_MLDEV_CNXK_ENABLE_MVTVM
 		} else {
-			for (layer_id = 0; layer_id < model->mvtvm.metadata.model.nb_layers;
-			     layer_id++) {
+			for (layer_id = 0; layer_id < model->nb_layers; layer_id++) {
 				if (model->layer[layer_id].type == ML_CNXK_LAYER_TYPE_MRVL) {
 					plt_ml_dbg(
 						"layer_id = %u: wb_pages = %u, scratch_pages = %u",
diff --git a/drivers/ml/cnxk/meson.build b/drivers/ml/cnxk/meson.build
index ef7e21d7476..5f078bd4fd7 100644
--- a/drivers/ml/cnxk/meson.build
+++ b/drivers/ml/cnxk/meson.build
@@ -19,30 +19,24 @@ if not jansson_dep.found()
         enable_mvtvm = false
 endif
 
-dlpack_dep = dependency('dlpack', method: 'cmake', required: false, cmake_args: 'CONFIG')
+dlpack_dep = dependency('dlpack', method: 'cmake', required: false)
 if not dlpack_dep.found()
         message('drivers/ml/cnxk: dlpack not found')
         enable_mvtvm = false
 endif
 
-dmlc_dep = dependency('dmlc', method: 'cmake', required: false, cmake_args: 'CONFIG')
+dmlc_dep = dependency('dmlc', method: 'cmake', required: false)
 if not dmlc_dep.found()
         message('drivers/ml/cnxk: dmlc not found')
         enable_mvtvm = false
 endif
 
-tvm_dep = dependency('tvm', method: 'cmake', required: false, cmake_args: 'CONFIG', modules : ['tvm::tvm_runtime'])
+tvm_dep = dependency('tvm', method: 'cmake', required: false, modules : ['tvm::tvm_runtime'])
 if not tvm_dep.found()
         message('drivers/ml/cnxk: tvm_runtime not found')
         enable_mvtvm = false
 endif
 
-tvmdp_dep = dependency('tvmdp', method: 'pkg-config', required: false)
-if not tvmdp_dep.found()
-        message('drivers/ml/cnxk: tvmdp not found')
-        enable_mvtvm = false
-endif
-
 sources = files(
         'cn10k_ml_dev.c',
         'cn10k_ml_ops.c',
@@ -68,10 +62,10 @@ sources += files(
 )
 
 ext_deps += jansson_dep
+ext_deps += libarchive
 ext_deps += dlpack_dep
 ext_deps += dmlc_dep
 ext_deps += tvm_dep
-ext_deps += tvmdp_dep
 stdcpp_dep = cc.find_library('stdc++', required: true)
 if not cc.links(min_c_code, dependencies: stdcpp_dep)
     error('broken dependency, "libstdc++"')
diff --git a/drivers/ml/cnxk/mvtvm_ml_dev.h b/drivers/ml/cnxk/mvtvm_ml_dev.h
index 6922c193372..05e30f094cd 100644
--- a/drivers/ml/cnxk/mvtvm_ml_dev.h
+++ b/drivers/ml/cnxk/mvtvm_ml_dev.h
@@ -19,9 +19,6 @@ extern struct rte_ml_dev_ops cnxk_ml_ops;
 /* Maximum number of descriptors per queue-pair */
 #define ML_MVTVM_MAX_DESC_PER_QP 1024
 
-/* Maximum number of inputs / outputs per model */
-#define ML_MVTVM_MAX_INPUT_OUTPUT 32
-
 /* Maximum number of segments for IO data */
 #define ML_MVTVM_MAX_SEGMENTS 1
 
diff --git a/drivers/ml/cnxk/mvtvm_ml_model.c b/drivers/ml/cnxk/mvtvm_ml_model.c
index 4c7aa906da0..e1946607629 100644
--- a/drivers/ml/cnxk/mvtvm_ml_model.c
+++ b/drivers/ml/cnxk/mvtvm_ml_model.c
@@ -2,6 +2,12 @@
  * Copyright (c) 2023 Marvell.
  */
 
+#include <errno.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
 #include <archive.h>
 #include <archive_entry.h>
 
@@ -23,6 +29,7 @@ enum cnxk_ml_model_type
 mvtvm_ml_model_type_get(struct rte_ml_model_params *params)
 {
 	bool object_found[ML_MVTVM_MODEL_OBJECT_MAX] = {false, false, false};
+	enum cnxk_ml_model_type model_type;
 	struct archive_entry *entry;
 	struct archive *a;
 	uint8_t i;
@@ -33,9 +40,10 @@ mvtvm_ml_model_type_get(struct rte_ml_model_params *params)
 	archive_read_support_filter_all(a);
 	archive_read_support_format_all(a);
 
+	model_type = ML_CNXK_MODEL_TYPE_UNKNOWN;
 	ret = archive_read_open_memory(a, params->addr, params->size);
 	if (ret != ARCHIVE_OK)
-		return ML_CNXK_MODEL_TYPE_UNKNOWN;
+		goto cleanup;
 
 	/* Parse buffer for available objects */
 	while (archive_read_next_header(a, &entry) == ARCHIVE_OK) {
@@ -51,11 +59,18 @@ mvtvm_ml_model_type_get(struct rte_ml_model_params *params)
 	for (i = 0; i < ML_MVTVM_MODEL_OBJECT_MAX; i++) {
 		if (!object_found[i]) {
 			plt_err("Object %s not found in archive!", mvtvm_object_list[i]);
-			return ML_CNXK_MODEL_TYPE_INVALID;
+			model_type = ML_CNXK_MODEL_TYPE_INVALID;
+			goto cleanup;
 		}
 	}
 
-	return ML_CNXK_MODEL_TYPE_TVM;
+	model_type = ML_CNXK_MODEL_TYPE_TVM;
+
+cleanup:
+	archive_read_close(a);
+	archive_read_free(a);
+
+	return model_type;
 }
 
 int
@@ -67,14 +82,18 @@ mvtvm_ml_model_blob_parse(struct rte_ml_model_params *params, struct mvtvm_ml_mo
 	uint8_t i;
 	int ret;
 
+	memset(object, 0, ML_MVTVM_MODEL_OBJECT_MAX * sizeof(*object));
+
 	/* Open archive */
 	a = archive_read_new();
 	archive_read_support_filter_all(a);
 	archive_read_support_format_all(a);
 
 	ret = archive_read_open_memory(a, params->addr, params->size);
-	if (ret != ARCHIVE_OK)
-		return archive_errno(a);
+	if (ret != ARCHIVE_OK) {
+		ret = archive_errno(a);
+		goto cleanup;
+	}
 
 	/* Read archive */
 	while (archive_read_next_header(a, &entry) == ARCHIVE_OK) {
@@ -84,11 +103,16 @@ mvtvm_ml_model_blob_parse(struct rte_ml_model_params *params, struct mvtvm_ml_mo
 				memcpy(object[i].name, mvtvm_object_list[i], RTE_ML_STR_MAX);
 				object[i].size = archive_entry_size(entry);
 				object[i].buffer = rte_malloc(NULL, object[i].size, 0);
+				if (object[i].buffer == NULL) {
+					ret = -ENOMEM;
+					goto error;
+				}
 
 				if (archive_read_data(a, object[i].buffer, object[i].size) !=
 				    object[i].size) {
 					plt_err("Failed to read object from model archive: %s",
 						object[i].name);
+					ret = -EINVAL;
 					goto error;
 				}
 				object_found[i] = true;
@@ -101,17 +125,24 @@ mvtvm_ml_model_blob_parse(struct rte_ml_model_params *params, struct mvtvm_ml_mo
 	for (i = 0; i < ML_MVTVM_MODEL_OBJECT_MAX; i++) {
 		if (!object_found[i]) {
 			plt_err("Object %s not found in archive!", mvtvm_object_list[i]);
+			ret = -EINVAL;
 			goto error;
 		}
 	}
-	return 0;
+	ret = 0;
+	goto cleanup;
 
 error:
 	for (i = 0; i < ML_MVTVM_MODEL_OBJECT_MAX; i++) {
-		rte_free(object[i].buffer);
+		if (object[i].buffer != NULL)
+			rte_free(object[i].buffer);
 	}
 
-	return -EINVAL;
+cleanup:
+	archive_read_close(a);
+	archive_read_free(a);
+
+	return ret;
 }
 
 int
@@ -119,12 +150,12 @@ mvtvm_ml_model_get_layer_id(struct cnxk_ml_model *model, const char *layer_name,
 {
 	uint16_t i;
 
-	for (i = 0; i < model->mvtvm.metadata.model.nb_layers; i++) {
+	for (i = 0; i < model->nb_layers; i++) {
 		if (strcmp(model->layer[i].name, layer_name) == 0)
 			break;
 	}
 
-	if (i == model->mvtvm.metadata.model.nb_layers) {
+	if (i == model->nb_layers) {
 		plt_err("Invalid layer name: %s", layer_name);
 		return -EINVAL;
 	}
@@ -139,6 +170,506 @@ mvtvm_ml_model_get_layer_id(struct cnxk_ml_model *model, const char *layer_name,
 	return 0;
 }
 
+static void
+mvtvm_ml_param_names_free(struct mvtvm_ml_param_names *param_names)
+{
+	size_t i;
+
+	for (i = 0; i < param_names->count; i++)
+		free(param_names->name[i]);
+
+	free(param_names->name);
+	param_names->name = NULL;
+	param_names->count = 0;
+}
+
+static int
+mvtvm_ml_blob_read_u64(const uint8_t *blob, size_t blob_size, size_t *offset, uint64_t *value)
+{
+	if (*offset + sizeof(*value) > blob_size)
+		return -EINVAL;
+
+	memcpy(value, blob + *offset, sizeof(*value));
+	*offset += sizeof(*value);
+
+	return 0;
+}
+
+static int
+mvtvm_ml_param_names_parse(const uint8_t *blob, size_t blob_size,
+			   struct mvtvm_ml_param_names *param_names)
+{
+	uint64_t magic = 0;
+	uint64_t reserved = 0;
+	uint64_t count = 0;
+	size_t offset = 0;
+	int ret;
+	size_t i;
+
+	memset(param_names, 0, sizeof(*param_names));
+
+	ret = mvtvm_ml_blob_read_u64(blob, blob_size, &offset, &magic);
+	if (ret != 0)
+		return ret;
+
+	if (magic != TVM_NDARRAY_LIST_MAGIC)
+		return -EINVAL;
+
+	ret = mvtvm_ml_blob_read_u64(blob, blob_size, &offset, &reserved);
+	if (ret != 0)
+		return ret;
+
+	ret = mvtvm_ml_blob_read_u64(blob, blob_size, &offset, &count);
+	if (ret != 0)
+		return ret;
+
+	if (count > SIZE_MAX / sizeof(*param_names->name))
+		return -EINVAL;
+
+	param_names->name = calloc(count, sizeof(*param_names->name));
+	if (count != 0 && param_names->name == NULL)
+		return -ENOMEM;
+
+	param_names->count = count;
+	for (i = 0; i < count; i++) {
+		uint64_t name_len = 0;
+
+		ret = mvtvm_ml_blob_read_u64(blob, blob_size, &offset, &name_len);
+		if (ret != 0)
+			goto error;
+
+		if (name_len == SIZE_MAX) {
+			ret = -EINVAL;
+			goto error;
+		}
+
+		if (offset + name_len > blob_size) {
+			ret = -EINVAL;
+			goto error;
+		}
+
+		param_names->name[i] = calloc(name_len + 1, 1);
+		if (param_names->name[i] == NULL) {
+			ret = -ENOMEM;
+			goto error;
+		}
+
+		memcpy(param_names->name[i], blob + offset, name_len);
+		offset += name_len;
+	}
+
+	return 0;
+
+error:
+	mvtvm_ml_param_names_free(param_names);
+	return ret;
+}
+
+static int
+mvtvm_ml_dtype_parse(const char *dtype_str, DLDataType *dtype)
+{
+	const char *lanes_str;
+	char base[32] = {0};
+	long bits;
+	long lanes = 1;
+
+	if (dtype_str == NULL || dtype == NULL)
+		return -EINVAL;
+
+	lanes_str = strchr(dtype_str, 'x');
+	if (lanes_str != NULL) {
+		size_t base_len = lanes_str - dtype_str;
+
+		if (base_len >= sizeof(base))
+			return -EINVAL;
+		memcpy(base, dtype_str, base_len);
+		lanes = strtol(lanes_str + 1, NULL, 10);
+		if (lanes <= 0 || lanes > UINT16_MAX)
+			return -EINVAL;
+	} else {
+		snprintf(base, sizeof(base), "%s", dtype_str);
+	}
+
+	memset(dtype, 0, sizeof(*dtype));
+	dtype->lanes = (uint16_t)lanes;
+
+	if (strncmp(base, "int", 3) == 0) {
+		bits = strtol(base + 3, NULL, 10);
+		dtype->code = kDLInt;
+	} else if (strncmp(base, "uint", 4) == 0) {
+		bits = strtol(base + 4, NULL, 10);
+		dtype->code = kDLUInt;
+	} else if (strncmp(base, "float", 5) == 0) {
+		bits = strtol(base + 5, NULL, 10);
+		dtype->code = kDLFloat;
+	} else if (strncmp(base, "bfloat", 6) == 0) {
+		bits = strtol(base + 6, NULL, 10);
+		dtype->code = kDLBfloat;
+	} else if (strcmp(base, "bool") == 0) {
+		bits = 1;
+		dtype->code = kDLUInt;
+	} else {
+		return -EINVAL;
+	}
+
+	if (bits <= 0 || bits > UINT8_MAX)
+		return -EINVAL;
+
+	dtype->bits = (uint8_t)bits;
+
+	return 0;
+}
+
+static int
+mvtvm_ml_model_io_set(struct cnxk_ml_io *io, const char *name, json_t *shape, const char *dtype_str,
+		      DLDevice device)
+{
+	size_t i;
+	int ret;
+
+	memset(io, 0, sizeof(*io));
+	if (name != NULL)
+		snprintf(io->name, sizeof(io->name), "%s", name);
+
+	if (!json_is_array(shape))
+		return -EINVAL;
+
+	io->nb_dims = json_array_size(shape);
+	if (io->nb_dims > ML_CNXK_MODEL_MAX_DIMS)
+		return -ENOTSUP;
+
+	for (i = 0; i < (size_t)io->nb_dims; i++) {
+		json_t *dim = json_array_get(shape, i);
+
+		if (!json_is_integer(dim))
+			return -EINVAL;
+		io->shape_i64[i] = json_integer_value(dim);
+	}
+
+	ret = mvtvm_ml_dtype_parse(dtype_str, &io->datatype);
+	if (ret != 0)
+		return ret;
+
+	io->model_datatype = io->datatype;
+	io->scale = 1.0f;
+	io->device = device;
+
+	return 0;
+}
+
+static int
+mvtvm_ml_json_graph_get_arrays(json_t *json_parsed, json_t **nodes, json_t **arg_nodes,
+			       json_t **heads, json_t **node_row_ptr, json_t **shape_values,
+			       json_t **dtype_values)
+{
+	json_t *attrs;
+	json_t *shape_attr;
+	json_t *dtype_attr;
+
+	*nodes = json_object_get(json_parsed, "nodes");
+	*arg_nodes = json_object_get(json_parsed, "arg_nodes");
+	*heads = json_object_get(json_parsed, "heads");
+	*node_row_ptr = json_object_get(json_parsed, "node_row_ptr");
+	attrs = json_object_get(json_parsed, "attrs");
+
+	if (!json_is_array(*nodes) || !json_is_array(*arg_nodes) || !json_is_array(*heads) ||
+	    !json_is_array(*node_row_ptr) || !json_is_object(attrs))
+		return -EINVAL;
+
+	if (json_array_size(*node_row_ptr) != json_array_size(*nodes) + 1)
+		return -EINVAL;
+
+	shape_attr = json_object_get(attrs, "shape");
+	dtype_attr = json_object_get(attrs, "dltype");
+	if (!json_is_array(shape_attr) || json_array_size(shape_attr) < 2 ||
+	    !json_is_array(dtype_attr) || json_array_size(dtype_attr) < 2)
+		return -EINVAL;
+
+	*shape_values = json_array_get(shape_attr, 1);
+	*dtype_values = json_array_get(dtype_attr, 1);
+
+	if (!json_is_array(*shape_values) || !json_is_array(*dtype_values))
+		return -EINVAL;
+
+	return 0;
+}
+
+int
+mvtvm_ml_model_json_parse(struct cnxk_ml_model *model)
+{
+	struct mvtvm_ml_param_names param_names;
+	json_error_t json_error;
+	json_t *json_parsed;
+	json_t *json_nodes;
+	json_t *json_arg_nodes;
+	json_t *json_heads;
+	json_t *json_node_row_ptr;
+	json_t *json_shape_values;
+	json_t *json_dtype_values;
+	uint16_t nb_mrvl_layers;
+	uint16_t nb_llvm_layers;
+	DLDevice device;
+	int ret;
+	size_t i;
+	size_t j;
+
+	/* Parse param names from params buffer */
+	ret = mvtvm_ml_param_names_parse(model->mvtvm.params.buffer, model->mvtvm.params.size,
+					 &param_names);
+	if (ret != 0)
+		return ret;
+
+	/* Load JSON graph (single load for both stages) */
+	json_parsed = json_loadb((const char *)model->mvtvm.json.buffer, model->mvtvm.json.size, 0,
+				 &json_error);
+	if (json_parsed == NULL) {
+		mvtvm_ml_param_names_free(&param_names);
+		plt_err("TVM runtime: Failed to parse JSON graph, model_id = %u", model->model_id);
+		return -EINVAL;
+	}
+
+	/* Parse nodes to extract layer info */
+	json_nodes = json_object_get(json_parsed, "nodes");
+	if (!json_is_array(json_nodes)) {
+		ret = -EINVAL;
+		plt_err("TVM runtime: Failed to parse JSON nodes, model_id = %u, error = %d",
+			model->model_id, ret);
+		goto error;
+	}
+
+	model->nb_layers = 0;
+	nb_mrvl_layers = 0;
+	nb_llvm_layers = 0;
+	for (i = 0; i < json_array_size(json_nodes); i++) {
+		json_t *node = json_array_get(json_nodes, i);
+		json_t *op = json_object_get(node, "op");
+		json_t *name;
+		json_t *attrs;
+		json_t *compiler;
+
+		if (!json_is_string(op) || strcmp(json_string_value(op), "tvm_op") != 0)
+			continue;
+
+		if (model->nb_layers >= ML_CNXK_MODEL_MAX_LAYERS) {
+			ret = -ENOTSUP;
+			plt_err("TVM runtime: Number of layers exceeds maximum (%u), model_id = %u, error = %d",
+				ML_CNXK_MODEL_MAX_LAYERS, model->model_id, ret);
+			goto error;
+		}
+
+		name = json_object_get(node, "name");
+		if (!json_is_string(name)) {
+			ret = -EINVAL;
+			plt_err("TVM runtime: Failed to parse JSON node name, model_id = %u, error = %d",
+				model->model_id, ret);
+			goto error;
+		}
+
+		if (json_string_value(name) != NULL)
+			snprintf(model->layer[model->nb_layers].name,
+				 sizeof(model->layer[model->nb_layers].name), "%s",
+				 json_string_value(name));
+		else
+			snprintf(model->layer[model->nb_layers].name,
+				 sizeof(model->layer[model->nb_layers].name), "tvm_layer_%u",
+				 model->nb_layers);
+
+		attrs = json_object_get(node, "attrs");
+		compiler = json_is_object(attrs) ? json_object_get(attrs, "Compiler") : NULL;
+		if (json_is_string(compiler)) {
+			if (strcmp(json_string_value(compiler), "mrvl") == 0 ||
+			    strcmp(json_string_value(compiler), "MRVL") == 0) {
+				model->layer[model->nb_layers].type = ML_CNXK_LAYER_TYPE_MRVL;
+				nb_mrvl_layers++;
+			} else {
+				model->layer[model->nb_layers].type = ML_CNXK_LAYER_TYPE_UNKNOWN;
+			}
+		} else {
+			model->layer[model->nb_layers].type = ML_CNXK_LAYER_TYPE_LLVM;
+			nb_llvm_layers++;
+		}
+		model->nb_layers++;
+	}
+
+	/* Set model fields */
+	snprintf(model->name, sizeof(model->name), "tvm_model_%u", model->model_id);
+	model->batch_size = 1;
+
+	/* Validate layer counts */
+	if ((nb_llvm_layers == 0) && (nb_mrvl_layers == 0)) {
+		plt_err("Invalid model, nb_llvm_layers = %u, nb_mrvl_layers = %u", nb_llvm_layers,
+			nb_mrvl_layers);
+		ret = -EINVAL;
+		goto error;
+	}
+
+	if (nb_llvm_layers + nb_mrvl_layers != model->nb_layers) {
+		plt_err("Invalid model, nb_llvm_layers = %u, nb_mrvl_layers = %u, nb_layers = %u",
+			nb_llvm_layers, nb_mrvl_layers, model->nb_layers);
+		ret = -EINVAL;
+		goto error;
+	}
+
+	/* Set model subtype */
+	if ((nb_llvm_layers == 0) && (nb_mrvl_layers == 1))
+		model->subtype = ML_CNXK_MODEL_SUBTYPE_TVM_MRVL;
+	else if ((nb_llvm_layers > 0) && (nb_mrvl_layers == 0))
+		model->subtype = ML_CNXK_MODEL_SUBTYPE_TVM_LLVM;
+	else
+		model->subtype = ML_CNXK_MODEL_SUBTYPE_TVM_HYBRID;
+
+	/* Parse I/O info from the same JSON graph */
+	device.device_type = kDLCPU;
+	device.device_id = 0;
+
+	ret = mvtvm_ml_json_graph_get_arrays(json_parsed, &json_nodes, &json_arg_nodes, &json_heads,
+					     &json_node_row_ptr, &json_shape_values,
+					     &json_dtype_values);
+	if (ret == 0) {
+		model->mvtvm.info.nb_inputs = 0;
+		model->mvtvm.info.nb_outputs = 0;
+
+		for (i = 0; i < json_array_size(json_arg_nodes); i++) {
+			json_t *arg_node_idx = json_array_get(json_arg_nodes, i);
+			json_t *node;
+			json_t *shape;
+			json_t *dtype;
+			json_t *name;
+			json_int_t node_id;
+
+			if (!json_is_integer(arg_node_idx)) {
+				ret = -EINVAL;
+				break;
+			}
+
+			node_id = json_integer_value(arg_node_idx);
+			node = json_array_get(json_nodes, node_id);
+			shape = json_array_get(json_shape_values, node_id);
+			dtype = json_array_get(json_dtype_values, node_id);
+			name = json_object_get(node, "name");
+			if (!json_is_object(node) || !json_is_array(shape) ||
+			    !json_is_string(dtype) || !json_is_string(name)) {
+				ret = -EINVAL;
+				break;
+			}
+
+			for (j = 0; j < param_names.count; j++) {
+				if (strcmp(param_names.name[j], json_string_value(name)) == 0)
+					break;
+			}
+
+			if (j < param_names.count)
+				continue;
+
+			if (model->mvtvm.info.nb_inputs >= ML_CNXK_MODEL_MAX_INPUT_OUTPUT) {
+				ret = -ENOTSUP;
+				break;
+			}
+
+			ret = mvtvm_ml_model_io_set(
+				&model->mvtvm.info.input[model->mvtvm.info.nb_inputs],
+				json_string_value(name), shape, json_string_value(dtype), device);
+			if (ret != 0)
+				break;
+
+			model->mvtvm.info.nb_inputs++;
+		}
+
+		for (i = 0; ret == 0 && i < json_array_size(json_heads); i++) {
+			json_t *head = json_array_get(json_heads, i);
+			json_t *node;
+			json_t *shape;
+			json_t *dtype;
+			json_t *name;
+			json_t *node_id_json;
+			json_t *output_idx_json;
+			json_t *entry_base_json;
+			json_t *entry_limit_json;
+			json_int_t node_id;
+			json_int_t output_idx;
+			json_int_t entry_base;
+			json_int_t entry_limit;
+			size_t entry_id;
+
+			if (!json_is_array(head) || json_array_size(head) < 2) {
+				ret = -EINVAL;
+				break;
+			}
+
+			node_id_json = json_array_get(head, 0);
+			output_idx_json = json_array_get(head, 1);
+			if (!json_is_integer(node_id_json) || !json_is_integer(output_idx_json)) {
+				ret = -EINVAL;
+				break;
+			}
+
+			node_id = json_integer_value(node_id_json);
+			output_idx = json_integer_value(output_idx_json);
+			if (node_id < 0 || output_idx < 0) {
+				ret = -EINVAL;
+				break;
+			}
+
+			node = json_array_get(json_nodes, (size_t)node_id);
+			entry_base_json = json_array_get(json_node_row_ptr, (size_t)node_id);
+			entry_limit_json = json_array_get(json_node_row_ptr, (size_t)node_id + 1);
+			if (!json_is_object(node) || !json_is_integer(entry_base_json) ||
+			    !json_is_integer(entry_limit_json)) {
+				ret = -EINVAL;
+				break;
+			}
+
+			entry_base = json_integer_value(entry_base_json);
+			entry_limit = json_integer_value(entry_limit_json);
+			if (entry_base < 0 || entry_limit < entry_base) {
+				ret = -EINVAL;
+				break;
+			}
+
+			if (output_idx >= (entry_limit - entry_base)) {
+				ret = -EINVAL;
+				break;
+			}
+
+			entry_id = (size_t)entry_base + (size_t)output_idx;
+			shape = json_array_get(json_shape_values, entry_id);
+			dtype = json_array_get(json_dtype_values, entry_id);
+			name = json_object_get(node, "name");
+			if (!json_is_array(shape) || !json_is_string(dtype) ||
+			    !json_is_string(name)) {
+				ret = -EINVAL;
+				break;
+			}
+
+			if (model->mvtvm.info.nb_outputs >= ML_CNXK_MODEL_MAX_INPUT_OUTPUT) {
+				ret = -ENOTSUP;
+				break;
+			}
+
+			ret = mvtvm_ml_model_io_set(
+				&model->mvtvm.info.output[model->mvtvm.info.nb_outputs],
+				json_string_value(name), shape, json_string_value(dtype), device);
+			if (ret != 0)
+				break;
+
+			model->mvtvm.info.nb_outputs++;
+		}
+	}
+
+	if (ret != 0)
+		plt_err("TVM runtime: Failed to get metadata, model_id = %u, error = %d",
+			model->model_id, ret);
+
+	json_decref(json_parsed);
+	mvtvm_ml_param_names_free(&param_names);
+	return ret;
+
+error:
+	json_decref(json_parsed);
+	mvtvm_ml_param_names_free(&param_names);
+	return ret;
+}
+
 static enum rte_ml_io_type
 mvtvm_ml_io_type_map(DLDataType dltype)
 {
@@ -185,32 +716,27 @@ mvtvm_ml_io_type_map(DLDataType dltype)
 void
 mvtvm_ml_model_io_info_set(struct cnxk_ml_model *model)
 {
-	struct tvmdp_model_metadata *metadata;
 	int32_t i;
-	int32_t j;
+	uint32_t j;
 
 	if (model->subtype == ML_CNXK_MODEL_SUBTYPE_TVM_MRVL)
 		goto tvm_mrvl_model;
 
-	metadata = &model->mvtvm.metadata;
-
 	/* Inputs, set for layer_id = 0 */
-	model->mvtvm.info.nb_inputs = metadata->model.num_input;
 	model->mvtvm.info.total_input_sz_d = 0;
 	model->mvtvm.info.total_input_sz_q = 0;
-	for (i = 0; i < metadata->model.num_input; i++) {
-		rte_strscpy(model->mvtvm.info.input[i].name, metadata->input[i].name,
-			    TVMDP_NAME_STRLEN);
+	for (i = 0; i < model->mvtvm.info.nb_inputs; i++) {
 		model->mvtvm.info.input[i].dtype =
-			mvtvm_ml_io_type_map(metadata->input[i].datatype);
+			mvtvm_ml_io_type_map(model->mvtvm.info.input[i].datatype);
 		model->mvtvm.info.input[i].qtype =
-			mvtvm_ml_io_type_map(metadata->input[i].model_datatype);
-		model->mvtvm.info.input[i].nb_dims = metadata->input[i].ndim;
+			mvtvm_ml_io_type_map(model->mvtvm.info.input[i].model_datatype);
 
 		model->mvtvm.info.input[i].nb_elements = 1;
-		for (j = 0; j < metadata->input[i].ndim; j++) {
-			model->mvtvm.info.input[i].shape[j] = metadata->input[i].shape[j];
-			model->mvtvm.info.input[i].nb_elements *= metadata->input[i].shape[j];
+		for (j = 0; j < model->mvtvm.info.input[i].nb_dims; j++) {
+			model->mvtvm.info.input[i].shape[j] =
+				PLT_U32_CAST(model->mvtvm.info.input[i].shape_i64[j]);
+			model->mvtvm.info.input[i].nb_elements *=
+				model->mvtvm.info.input[i].shape[j];
 		}
 
 		model->mvtvm.info.input[i].sz_d =
@@ -219,15 +745,14 @@ mvtvm_ml_model_io_info_set(struct cnxk_ml_model *model)
 		model->mvtvm.info.input[i].sz_q =
 			model->mvtvm.info.input[i].nb_elements *
 			rte_ml_io_type_size_get(model->mvtvm.info.input[i].qtype);
-		model->mvtvm.info.input[i].scale = metadata->input[i].scale;
 
 		model->mvtvm.info.total_input_sz_d += model->mvtvm.info.input[i].sz_d;
 		model->mvtvm.info.total_input_sz_q += model->mvtvm.info.input[i].sz_q;
 
-		model->mvtvm.input_tensor[i].device = metadata->input[i].device;
-		model->mvtvm.input_tensor[i].ndim = metadata->input[i].ndim;
-		model->mvtvm.input_tensor[i].dtype = metadata->input[i].datatype;
-		model->mvtvm.input_tensor[i].shape = metadata->input[i].shape;
+		model->mvtvm.input_tensor[i].device = model->mvtvm.info.input[i].device;
+		model->mvtvm.input_tensor[i].ndim = model->mvtvm.info.input[i].nb_dims;
+		model->mvtvm.input_tensor[i].dtype = model->mvtvm.info.input[i].datatype;
+		model->mvtvm.input_tensor[i].shape = model->mvtvm.info.input[i].shape_i64;
 		model->mvtvm.input_tensor[i].strides = NULL;
 		model->mvtvm.input_tensor[i].byte_offset = 0;
 
@@ -236,22 +761,20 @@ mvtvm_ml_model_io_info_set(struct cnxk_ml_model *model)
 	}
 
 	/* Outputs, set for nb_layers - 1 */
-	model->mvtvm.info.nb_outputs = metadata->model.num_output;
 	model->mvtvm.info.total_output_sz_d = 0;
 	model->mvtvm.info.total_output_sz_q = 0;
-	for (i = 0; i < metadata->model.num_output; i++) {
-		rte_strscpy(model->mvtvm.info.output[i].name, metadata->output[i].name,
-			    TVMDP_NAME_STRLEN);
+	for (i = 0; i < model->mvtvm.info.nb_outputs; i++) {
 		model->mvtvm.info.output[i].dtype =
-			mvtvm_ml_io_type_map(metadata->output[i].datatype);
+			mvtvm_ml_io_type_map(model->mvtvm.info.output[i].datatype);
 		model->mvtvm.info.output[i].qtype =
-			mvtvm_ml_io_type_map(metadata->output[i].model_datatype);
-		model->mvtvm.info.output[i].nb_dims = metadata->output[i].ndim;
+			mvtvm_ml_io_type_map(model->mvtvm.info.output[i].model_datatype);
 
 		model->mvtvm.info.output[i].nb_elements = 1;
-		for (j = 0; j < metadata->output[i].ndim; j++) {
-			model->mvtvm.info.output[i].shape[j] = metadata->output[i].shape[j];
-			model->mvtvm.info.output[i].nb_elements *= metadata->output[i].shape[j];
+		for (j = 0; j < model->mvtvm.info.output[i].nb_dims; j++) {
+			model->mvtvm.info.output[i].shape[j] =
+				PLT_U32_CAST(model->mvtvm.info.output[i].shape_i64[j]);
+			model->mvtvm.info.output[i].nb_elements *=
+				model->mvtvm.info.output[i].shape[j];
 		}
 
 		model->mvtvm.info.output[i].sz_d =
@@ -260,15 +783,14 @@ mvtvm_ml_model_io_info_set(struct cnxk_ml_model *model)
 		model->mvtvm.info.output[i].sz_q =
 			model->mvtvm.info.output[i].nb_elements *
 			rte_ml_io_type_size_get(model->mvtvm.info.output[i].qtype);
-		model->mvtvm.info.output[i].scale = metadata->output[i].scale;
 
 		model->mvtvm.info.total_output_sz_d += model->mvtvm.info.output[i].sz_d;
 		model->mvtvm.info.total_output_sz_q += model->mvtvm.info.output[i].sz_q;
 
-		model->mvtvm.output_tensor[i].device = metadata->output[i].device;
-		model->mvtvm.output_tensor[i].ndim = metadata->output[i].ndim;
-		model->mvtvm.output_tensor[i].dtype = metadata->output[i].datatype;
-		model->mvtvm.output_tensor[i].shape = metadata->output[i].shape;
+		model->mvtvm.output_tensor[i].device = model->mvtvm.info.output[i].device;
+		model->mvtvm.output_tensor[i].ndim = model->mvtvm.info.output[i].nb_dims;
+		model->mvtvm.output_tensor[i].dtype = model->mvtvm.info.output[i].datatype;
+		model->mvtvm.output_tensor[i].shape = model->mvtvm.info.output[i].shape_i64;
 		model->mvtvm.output_tensor[i].strides = NULL;
 		model->mvtvm.output_tensor[i].byte_offset = 0;
 
@@ -293,7 +815,6 @@ mvtvm_ml_model_io_info_get(struct cnxk_ml_model *model, uint16_t layer_id)
 void
 mvtvm_ml_model_info_set(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model)
 {
-	struct tvmdp_model_metadata *metadata;
 	struct rte_ml_model_info *info;
 	struct rte_ml_io_info *output;
 	struct rte_ml_io_info *input;
@@ -309,26 +830,23 @@ mvtvm_ml_model_info_set(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *mo
 	if (model->subtype == ML_CNXK_MODEL_SUBTYPE_TVM_MRVL)
 		goto tvm_mrvl_model;
 
-	metadata = &model->mvtvm.metadata;
-	rte_memcpy(info->name, metadata->model.name, TVMDP_NAME_STRLEN);
-	snprintf(info->version, RTE_ML_STR_MAX, "%u.%u.%u.%u", metadata->model.version[0],
-		 metadata->model.version[1], metadata->model.version[2],
-		 metadata->model.version[3]);
+	rte_memcpy(info->name, model->name, RTE_ML_STR_MAX);
+	snprintf(info->version, RTE_ML_STR_MAX, "%u.%u.%u.%u", 0, 0, 0, 0);
 	info->model_id = model->model_id;
 	info->device_id = cnxk_mldev->mldev->data->dev_id;
 	info->io_layout = RTE_ML_IO_LAYOUT_SPLIT;
 	info->min_batches = model->batch_size;
 	info->max_batches = model->batch_size;
-	info->nb_inputs = metadata->model.num_input;
+	info->nb_inputs = model->mvtvm.info.nb_inputs;
 	info->input_info = input;
-	info->nb_outputs = metadata->model.num_output;
+	info->nb_outputs = model->mvtvm.info.nb_outputs;
 	info->output_info = output;
 	info->wb_size = 0;
 
 	/* Set input info */
 	for (i = 0; i < info->nb_inputs; i++) {
-		rte_memcpy(input[i].name, metadata->input[i].name, MRVL_ML_INPUT_NAME_LEN);
-		input[i].nb_dims = metadata->input[i].ndim;
+		rte_memcpy(input[i].name, model->mvtvm.info.input[i].name, MRVL_ML_INPUT_NAME_LEN);
+		input[i].nb_dims = model->mvtvm.info.input[i].nb_dims;
 		input[i].shape = &model->mvtvm.info.input[i].shape[0];
 		input[i].type = model->mvtvm.info.input[i].qtype;
 		input[i].nb_elements = model->mvtvm.info.input[i].nb_elements;
@@ -340,15 +858,16 @@ mvtvm_ml_model_info_set(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *mo
 
 	/* Set output info */
 	for (i = 0; i < info->nb_outputs; i++) {
-		rte_memcpy(output[i].name, metadata->output[i].name, MRVL_ML_OUTPUT_NAME_LEN);
-		output[i].nb_dims = metadata->output[i].ndim;
+		rte_memcpy(output[i].name, model->mvtvm.info.output[i].name,
+			   MRVL_ML_OUTPUT_NAME_LEN);
+		output[i].nb_dims = model->mvtvm.info.output[i].nb_dims;
 		output[i].shape = &model->mvtvm.info.output[i].shape[0];
 		output[i].type = model->mvtvm.info.output[i].qtype;
 		output[i].nb_elements = model->mvtvm.info.output[i].nb_elements;
 		output[i].size = model->mvtvm.info.output[i].nb_elements *
 				 rte_ml_io_type_size_get(model->mvtvm.info.output[i].qtype);
-		input[i].scale = model->mvtvm.info.output[i].scale;
-		input[i].zero_point = 0;
+		output[i].scale = model->mvtvm.info.output[i].scale;
+		output[i].zero_point = 0;
 	}
 
 	return;
@@ -357,8 +876,7 @@ mvtvm_ml_model_info_set(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *mo
 	cn10k_ml_model_info_set(cnxk_mldev, model, &model->mvtvm.info,
 				&model->layer[0].glow.metadata);
 
-	metadata = &model->mvtvm.metadata;
-	strlcpy(info->name, metadata->model.name, TVMDP_NAME_STRLEN);
+	strlcpy(info->name, model->name, RTE_ML_STR_MAX);
 
 	info->io_layout = RTE_ML_IO_LAYOUT_PACKED;
 }
diff --git a/drivers/ml/cnxk/mvtvm_ml_model.h b/drivers/ml/cnxk/mvtvm_ml_model.h
index 7ffce380945..1151b0a39ed 100644
--- a/drivers/ml/cnxk/mvtvm_ml_model.h
+++ b/drivers/ml/cnxk/mvtvm_ml_model.h
@@ -5,7 +5,21 @@
 #ifndef _MVTVM_ML_MODEL_H_
 #define _MVTVM_ML_MODEL_H_
 
-#include <tvmdp.h>
+#include <dlpack/dlpack.h>
+#include <jansson.h>
+#include <rte_common.h>
+
+#if defined(RTE_CC_GCC) || defined(RTE_CC_CLANG)
+__rte_diagnostic_push
+RTE_PRAGMA(GCC diagnostic ignored "-Wstrict-prototypes")
+#include <tvm/runtime/c_runtime_api.h>
+__rte_diagnostic_pop
+#else
+#include <tvm/runtime/c_runtime_api.h>
+#endif
+
+#include <stddef.h>
+#include <stdint.h>
 
 #include <rte_mldev.h>
 
@@ -18,19 +32,56 @@ struct cnxk_ml_layer;
 /* Maximum number of objects per model */
 #define ML_MVTVM_MODEL_OBJECT_MAX 3
 
-/* Objects list */
-extern char mvtvm_object_list[ML_MVTVM_MODEL_OBJECT_MAX][RTE_ML_STR_MAX];
+/* Magic number for TVM parameter blobs. */
+#define TVM_NDARRAY_LIST_MAGIC 0xF7E58D4F05049CB7ULL
 
-/* Model object structure */
+/* TVM parameter names structure */
+struct mvtvm_ml_param_names {
+	char **name;
+	size_t count;
+};
+
+/* TVM object / artifact info structure */
 struct mvtvm_ml_model_object {
 	/* Name */
 	char name[RTE_ML_STR_MAX];
 
-	/* Temporary buffer */
+	/* Buffer address */
 	uint8_t *buffer;
 
 	/* Buffer size */
 	int64_t size;
+
+	/* Offset */
+	uint32_t offset;
+};
+
+/* Glow model callback functions */
+typedef int (*tvmrt_glow_layer_load_cb)(void *device, uint16_t model_id, const char *layer_name,
+					uint8_t *buffer, size_t size, uint16_t *index);
+typedef int (*tvmrt_glow_layer_unload_cb)(void *device, uint16_t model_id, const char *layer_name);
+typedef int (*tvmrt_io_alloc_cb)(void *device, uint16_t model_id, const char *layer_name,
+				 uint64_t **input_qbuffer, uint64_t **output_qbuffer);
+typedef int (*tvmrt_io_free_cb)(void *device, uint16_t model_id, const char *layer_name);
+typedef int (*tvmrt_malloc_cb)(const char *name, size_t size, uint32_t align, void **addr);
+typedef int (*tvmrt_free_cb)(const char *name);
+typedef int (*tvmrt_quantize_cb)(void *device, uint16_t model_id, const char *layer_name,
+				 const DLTensor **deq_tensor, void *qbuffer);
+typedef int (*tvmrt_dequantize_cb)(void *device, uint16_t model_id, const char *layer_name,
+				   void *qbuffer, const DLTensor **deq_tensor);
+typedef int (*tvmrt_inference_cb)(void *device, uint16_t index, void *input, void *output,
+				  uint16_t nb_batches);
+
+struct tvmrt_glow_callback {
+	tvmrt_glow_layer_load_cb tvmrt_glow_layer_load;
+	tvmrt_glow_layer_unload_cb tvmrt_glow_layer_unload;
+	tvmrt_io_alloc_cb tvmrt_io_alloc;
+	tvmrt_io_free_cb tvmrt_io_free;
+	tvmrt_malloc_cb tvmrt_malloc;
+	tvmrt_free_cb tvmrt_free;
+	tvmrt_quantize_cb tvmrt_quantize;
+	tvmrt_dequantize_cb tvmrt_dequantize;
+	tvmrt_inference_cb tvmrt_inference;
 };
 
 /* Model fast-path stats */
@@ -55,15 +106,26 @@ struct mvtvm_ml_model_xstats {
 };
 
 struct mvtvm_ml_model_data {
-	/* Model metadata */
-	struct tvmdp_model_metadata metadata;
-
 	/* Model objects */
-	struct tvmdp_model_object object;
+	struct mvtvm_ml_model_object so;
+	struct mvtvm_ml_model_object json;
+	struct mvtvm_ml_model_object params;
 
 	/* TVM runtime callbacks */
 	struct tvmrt_glow_callback cb;
 
+	/* TVM Graph Module */
+	TVMModuleHandle graph_module;
+
+	/* Shared object memfd used to load the TVM module */
+	int fd;
+
+	/* TVM Function Handles */
+	TVMFunctionHandle load_params;
+	TVMFunctionHandle set_input_zero_copy;
+	TVMFunctionHandle set_output_zero_copy;
+	TVMFunctionHandle run;
+
 	/* Model I/O info */
 	struct cnxk_ml_io_info info;
 
@@ -86,5 +148,6 @@ void mvtvm_ml_model_io_info_set(struct cnxk_ml_model *model);
 struct cnxk_ml_io_info *mvtvm_ml_model_io_info_get(struct cnxk_ml_model *model, uint16_t layer_id);
 void mvtvm_ml_model_info_set(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *model);
 void mvtvm_ml_layer_print(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_layer *layer, FILE *fp);
+int mvtvm_ml_model_json_parse(struct cnxk_ml_model *model);
 
 #endif /* _MVTVM_ML_MODEL_H_ */
diff --git a/drivers/ml/cnxk/mvtvm_ml_ops.c b/drivers/ml/cnxk/mvtvm_ml_ops.c
index 80b22460db9..bc47a4bbd75 100644
--- a/drivers/ml/cnxk/mvtvm_ml_ops.c
+++ b/drivers/ml/cnxk/mvtvm_ml_ops.c
@@ -2,7 +2,17 @@
  * Copyright (c) 2023 Marvell.
  */
 
+#include <errno.h>
+#include <linux/limits.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <unistd.h>
+
 #include <dlpack/dlpack.h>
+#include <jansson.h>
 
 #include <rte_common.h>
 #include <rte_cycles.h>
@@ -19,6 +29,76 @@
 /* ML model macros */
 #define MVTVM_ML_MODEL_MEMZONE_NAME "ml_mvtvm_model_mz"
 
+/* Shared memory file descriptor name */
+#define ML_MODEL_SHMFD_NAME "mvtvm_shmfd"
+
+/* Shared memory file descriptor path */
+#define ML_MODEL_SHMFD_PATH "/proc/%d/fd/%d"
+
+static int
+mvtvm_ml_tvm_func_get(struct cnxk_ml_model *model, TVMModuleHandle module, const char *name,
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
+mvtvm_ml_tvm_func_call(struct cnxk_ml_model *model, TVMFunctionHandle func, const char *name,
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
+mvtvm_ml_tvm_func_free(TVMFunctionHandle *func)
+{
+	if ((func != NULL) && (*func != NULL)) {
+		TVMFuncFree(*func);
+		*func = NULL;
+	}
+}
+
+static void
+mvtvm_ml_tvm_mod_free(TVMModuleHandle *mod)
+{
+	if ((mod != NULL) && (*mod != NULL)) {
+		TVMModFree(*mod);
+		*mod = NULL;
+	}
+}
+
 __rte_hot static void
 mvtvm_ml_set_poll_addr(struct cnxk_ml_req *req)
 {
@@ -30,8 +110,8 @@ mvtvm_ml_model_xstat_name_set(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_mod
 			      uint16_t stat_id, uint16_t entry, char *suffix)
 {
 	snprintf(cnxk_mldev->xstats.entries[stat_id].map.name,
-		 sizeof(cnxk_mldev->xstats.entries[stat_id].map.name), "%s-%s-%s",
-		 model->mvtvm.metadata.model.name, model_xstats[entry].name, suffix);
+		 sizeof(cnxk_mldev->xstats.entries[stat_id].map.name), "%s-%s-%s", model->name,
+		 model_xstats[entry].name, suffix);
 }
 
 #define ML_AVG_FOREACH_QP_MVTVM(cnxk_mldev, model, qp_id, value, count)                            \
@@ -106,43 +186,13 @@ mvtvm_ml_dev_info_get(struct cnxk_ml_dev *cnxk_mldev, struct rte_ml_dev_info *de
 
 	dev_info->max_queue_pairs = mvtvm_mldev->max_nb_qpairs;
 	dev_info->max_desc = ML_MVTVM_MAX_DESC_PER_QP;
-	dev_info->max_io = ML_MVTVM_MAX_INPUT_OUTPUT;
+	dev_info->max_io = ML_CNXK_MODEL_MAX_INPUT_OUTPUT;
 	dev_info->max_segments = ML_MVTVM_MAX_SEGMENTS;
 	dev_info->align_size = RTE_CACHE_LINE_SIZE;
 
 	return 0;
 }
 
-int
-mvtvm_ml_dev_configure(struct cnxk_ml_dev *cnxk_mldev, const struct rte_ml_dev_config *conf)
-{
-	int ret;
-
-	RTE_SET_USED(conf);
-
-	/* Configure TVMDP library */
-	ret = tvmdp_configure(cnxk_mldev->mldev->data->nb_models, rte_get_tsc_cycles);
-	if (ret != 0)
-		plt_err("TVMDP configuration failed, error = %d", ret);
-
-	return ret;
-}
-
-int
-mvtvm_ml_dev_close(struct cnxk_ml_dev *cnxk_mldev)
-{
-	int ret;
-
-	RTE_SET_USED(cnxk_mldev);
-
-	/* Close TVMDP library configuration */
-	ret = tvmdp_close();
-	if (ret != 0)
-		plt_err("TVMDP close failed, error = %d", ret);
-
-	return ret;
-}
-
 int
 mvtvm_ml_dev_dump(struct cnxk_ml_dev *cnxk_mldev, FILE *fp)
 {
@@ -159,16 +209,26 @@ mvtvm_ml_model_load(struct cnxk_ml_dev *cnxk_mldev, struct rte_ml_model_params *
 	struct mvtvm_ml_model_object object[ML_MVTVM_MODEL_OBJECT_MAX];
 	struct tvmrt_glow_callback *callback;
 	char str[RTE_MEMZONE_NAMESIZE];
+	char path[PATH_MAX];
 	const struct plt_memzone *mz;
 	size_t model_object_size = 0;
 	size_t model_xstats_size = 0;
-	uint16_t nb_mrvl_layers;
-	uint16_t nb_llvm_layers;
-	uint8_t layer_id = 0;
 	uint64_t mz_size = 0;
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
 	int ret;
 
 	RTE_SET_USED(cnxk_mldev);
+	model->mvtvm.fd = -1;
 
 	ret = mvtvm_ml_model_blob_parse(params, object);
 	if (ret != 0)
@@ -192,80 +252,39 @@ mvtvm_ml_model_load(struct cnxk_ml_dev *cnxk_mldev, struct rte_ml_model_params *
 	}
 
 	/* Copy mod.so */
-	model->mvtvm.object.so.addr = mz->addr;
-	model->mvtvm.object.so.size = object[0].size;
-	rte_memcpy(model->mvtvm.object.so.name, object[0].name, TVMDP_NAME_STRLEN);
-	rte_memcpy(model->mvtvm.object.so.addr, object[0].buffer, object[0].size);
+	model->mvtvm.so.buffer = mz->addr;
+	model->mvtvm.so.size = object[0].size;
+	rte_memcpy(model->mvtvm.so.name, object[0].name, RTE_ML_STR_MAX);
+	rte_memcpy(model->mvtvm.so.buffer, object[0].buffer, object[0].size);
 	rte_free(object[0].buffer);
 
 	/* Copy mod.json */
-	model->mvtvm.object.json.addr =
-		RTE_PTR_ADD(model->mvtvm.object.so.addr,
-			    RTE_ALIGN_CEIL(model->mvtvm.object.so.size, RTE_CACHE_LINE_MIN_SIZE));
-	model->mvtvm.object.json.size = object[1].size;
-	rte_memcpy(model->mvtvm.object.json.name, object[1].name, TVMDP_NAME_STRLEN);
-	rte_memcpy(model->mvtvm.object.json.addr, object[1].buffer, object[1].size);
+	model->mvtvm.json.buffer =
+		RTE_PTR_ADD(model->mvtvm.so.buffer,
+			    RTE_ALIGN_CEIL(model->mvtvm.so.size, RTE_CACHE_LINE_MIN_SIZE));
+	model->mvtvm.json.size = object[1].size;
+	rte_memcpy(model->mvtvm.json.name, object[1].name, RTE_ML_STR_MAX);
+	rte_memcpy(model->mvtvm.json.buffer, object[1].buffer, object[1].size);
 	rte_free(object[1].buffer);
 
 	/* Copy mod.params */
-	model->mvtvm.object.params.addr =
-		RTE_PTR_ADD(model->mvtvm.object.json.addr,
-			    RTE_ALIGN_CEIL(model->mvtvm.object.json.size, RTE_CACHE_LINE_MIN_SIZE));
-	model->mvtvm.object.params.size = object[2].size;
-	rte_memcpy(model->mvtvm.object.params.name, object[2].name, TVMDP_NAME_STRLEN);
-	rte_memcpy(model->mvtvm.object.params.addr, object[2].buffer, object[2].size);
+	model->mvtvm.params.buffer =
+		RTE_PTR_ADD(model->mvtvm.json.buffer,
+			    RTE_ALIGN_CEIL(model->mvtvm.json.size, RTE_CACHE_LINE_MIN_SIZE));
+	model->mvtvm.params.size = object[2].size;
+	rte_memcpy(model->mvtvm.params.name, object[2].name, RTE_ML_STR_MAX);
+	rte_memcpy(model->mvtvm.params.buffer, object[2].buffer, object[2].size);
 	rte_free(object[2].buffer);
 
-	/* Get metadata - stage 1 */
-	ret = tvmdp_model_metadata_get_stage1(model->mvtvm.object.json.addr,
-					      model->mvtvm.object.json.size,
-					      &model->mvtvm.metadata);
-	if (ret != 0) {
-		plt_err("TVMDP: Failed to parse metadata - stage 1, model_id = %u, error = %d",
-			model->model_id, ret);
-		goto error;
-	}
-
-	/* Set model fields */
-	plt_strlcpy(model->name, model->mvtvm.metadata.model.name, TVMDP_NAME_STRLEN);
-	model->batch_size = 1;
-	model->nb_layers = model->mvtvm.metadata.model.nb_layers;
-
-	/* Update layer info */
-	nb_mrvl_layers = 0;
-	nb_llvm_layers = 0;
-	for (layer_id = 0; layer_id < model->mvtvm.metadata.model.nb_layers; layer_id++) {
-		rte_strscpy(model->layer[layer_id].name,
-			    model->mvtvm.metadata.model.layer[layer_id].name, TVMDP_NAME_STRLEN);
-		if (strcmp(model->mvtvm.metadata.model.layer[layer_id].type, "mrvl") == 0 ||
-		    strcmp(model->mvtvm.metadata.model.layer[layer_id].type, "MRVL") == 0) {
-			model->layer[layer_id].type = ML_CNXK_LAYER_TYPE_MRVL;
-			nb_mrvl_layers++;
-		} else if (strcmp(model->mvtvm.metadata.model.layer[layer_id].type, "llvm") == 0 ||
-			   strcmp(model->mvtvm.metadata.model.layer[layer_id].type, "LLVM") == 0) {
-			model->layer[layer_id].type = ML_CNXK_LAYER_TYPE_LLVM;
-			nb_llvm_layers++;
-		}
-	}
-
-	if ((nb_llvm_layers == 0) && (nb_mrvl_layers == 0)) {
-		plt_err("Invalid model, nb_llvm_layers = %u, nb_mrvl_layers = %u", nb_llvm_layers,
-			nb_mrvl_layers);
+	ret = mvtvm_ml_model_json_parse(model);
+	if (ret != 0)
 		goto error;
-	}
-
-	/* Set model subtype */
-	if ((nb_llvm_layers == 0) && (nb_mrvl_layers == 1))
-		model->subtype = ML_CNXK_MODEL_SUBTYPE_TVM_MRVL;
-	else if ((nb_llvm_layers > 0) && (nb_mrvl_layers == 0))
-		model->subtype = ML_CNXK_MODEL_SUBTYPE_TVM_LLVM;
-	else
-		model->subtype = ML_CNXK_MODEL_SUBTYPE_TVM_HYBRID;
 
 	if (cnxk_mldev->type == CNXK_ML_DEV_TYPE_VDEV &&
 	    model->subtype != ML_CNXK_MODEL_SUBTYPE_TVM_LLVM) {
 		plt_err("Unsupported model sub-type");
-		return -ENOTSUP;
+		ret = -ENOTSUP;
+		goto error;
 	}
 
 	/* Set callback function array */
@@ -284,23 +303,120 @@ mvtvm_ml_model_load(struct cnxk_ml_dev *cnxk_mldev, struct rte_ml_model_params *
 		callback = NULL;
 	}
 
-	/* Initialize model in TVMDP */
-	ret = tvmdp_model_load(cnxk_mldev, model->model_id, (void *)(&model->mvtvm.object),
-			       callback);
+	/* Initialize model in TVM runtime */
+	if (model->mvtvm.graph_module != NULL) {
+		ret = -EBUSY;
+		plt_err("TVM runtime: Model load failed, model_id = %u, error = %d",
+			model->model_id, ret);
+		goto error;
+	}
+
+	snprintf(path, sizeof(path), "%s_%d_%u", ML_MODEL_SHMFD_NAME, getpid(), model->model_id);
+	model->mvtvm.fd = memfd_create(path, 0);
+	if (model->mvtvm.fd < 0) {
+		ret = (errno == 0) ? -EIO : -errno;
+		plt_err("TVM runtime: Model load failed, model_id = %u, error = %d",
+			model->model_id, ret);
+		goto error;
+	}
+
+	if (write(model->mvtvm.fd, model->mvtvm.so.buffer, model->mvtvm.so.size) !=
+	    (ssize_t)model->mvtvm.so.size) {
+		ret = (errno == 0) ? -EIO : -errno;
+		plt_err("TVM runtime: Model load failed, model_id = %u, error = %d",
+			model->model_id, ret);
+		goto error;
+	}
+
+	if (lseek(model->mvtvm.fd, 0, SEEK_SET) < 0) {
+		ret = (errno == 0) ? -EIO : -errno;
+		plt_err("TVM runtime: Model load failed, model_id = %u, error = %d",
+			model->model_id, ret);
+		goto error;
+	}
+
+	snprintf(path, sizeof(path), ML_MODEL_SHMFD_PATH, getpid(), model->mvtvm.fd);
+	ret = TVMModLoadFromFile(path, "so", &module_so);
 	if (ret != 0) {
-		plt_err("TVMDP: Model load failed, model_id = %u, error = %d", model->model_id,
-			ret);
+		plt_err("TVM runtime: Model load failed, model_id = %u, ret = %d, msg = %s",
+			model->model_id, ret, TVMGetLastError());
 		goto error;
 	}
 
-	/* Get model metadata - stage 2 */
-	ret = tvmdp_model_metadata_get_stage2(model->model_id, &model->mvtvm.metadata);
+	/* Set device info */
+	device.device_type = kDLCPU;
+	device.device_id = 0;
+
+	if (callback != NULL) {
+		ret = mvtvm_ml_tvm_func_get(model, module_so, "register_cb", &register_cb_fn);
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
+		ret = mvtvm_ml_tvm_func_call(model, register_cb_fn, "register_cb", arg_values,
+					     arg_types, 3, &ret_value, &ret_type, kTVMNullptr);
+		if (ret != 0)
+			goto error;
+	}
+
+	ret = TVMFuncGetGlobal("tvm.graph_executor.create", &create_fn);
 	if (ret != 0) {
-		plt_err("TVMDP: Failed to get metadata, model_id = %u, error = %d",
-			model->model_id, ret);
+		plt_err("TVM runtime: Model load failed, model_id = %u, ret = %d, msg = %s",
+			model->model_id, ret, TVMGetLastError());
 		goto error;
 	}
 
+	arg_values[0].v_str = (const char *)model->mvtvm.json.buffer;
+	arg_types[0] = kTVMStr;
+	arg_values[1].v_handle = module_so;
+	arg_types[1] = kTVMModuleHandle;
+	arg_values[2].v_int64 = device.device_type;
+	arg_types[2] = kDLInt;
+	arg_values[3].v_int64 = device.device_id;
+	arg_types[3] = kDLInt;
+
+	ret = mvtvm_ml_tvm_func_call(model, create_fn, "tvm.graph_executor.create", arg_values,
+				     arg_types, 4, &ret_value, &ret_type, kTVMModuleHandle);
+	if (ret != 0)
+		goto error;
+	model->mvtvm.graph_module = ret_value.v_handle;
+
+	ret = mvtvm_ml_tvm_func_get(model, model->mvtvm.graph_module, "load_params",
+				    &model->mvtvm.load_params);
+	if (ret != 0)
+		goto error;
+	ret = mvtvm_ml_tvm_func_get(model, model->mvtvm.graph_module, "set_input_zero_copy",
+				    &model->mvtvm.set_input_zero_copy);
+	if (ret != 0)
+		goto error;
+	ret = mvtvm_ml_tvm_func_get(model, model->mvtvm.graph_module, "set_output_zero_copy",
+				    &model->mvtvm.set_output_zero_copy);
+	if (ret != 0)
+		goto error;
+	ret = mvtvm_ml_tvm_func_get(model, model->mvtvm.graph_module, "run", &model->mvtvm.run);
+	if (ret != 0)
+		goto error;
+
+	mvtvm_ml_tvm_func_free(&register_cb_fn);
+	mvtvm_ml_tvm_mod_free(&module_so);
+
+	/* Load model parameters into TVM runtime */
+	tvm_params.data = (const char *)model->mvtvm.params.buffer;
+	tvm_params.size = model->mvtvm.params.size;
+	tvm_arg_values[0].v_handle = &tvm_params;
+	tvm_arg_types[0] = kTVMBytes;
+
+	ret = mvtvm_ml_tvm_func_call(model, model->mvtvm.load_params, "load_params", tvm_arg_values,
+				     tvm_arg_types, 1, &ret_value, &ret_type, kTVMNullptr);
+	if (ret != 0)
+		goto error;
+
 	/* Update model I/O data */
 	mvtvm_ml_model_io_info_set(model);
 
@@ -310,9 +426,9 @@ mvtvm_ml_model_load(struct cnxk_ml_dev *cnxk_mldev, struct rte_ml_model_params *
 	/* Update model xstats name */
 	cnxk_ml_xstats_model_name_update(cnxk_mldev, model->model_id);
 
-	model->mvtvm.burst_xstats = RTE_PTR_ADD(
-		model->mvtvm.object.params.addr,
-		RTE_ALIGN_CEIL(model->mvtvm.object.params.size, RTE_CACHE_LINE_MIN_SIZE));
+	model->mvtvm.burst_xstats =
+		RTE_PTR_ADD(model->mvtvm.params.buffer,
+			    RTE_ALIGN_CEIL(model->mvtvm.params.size, RTE_CACHE_LINE_MIN_SIZE));
 
 	for (int qp_id = 0; qp_id < cnxk_mldev->mldev->data->nb_queue_pairs; qp_id++) {
 		model->mvtvm.burst_xstats[qp_id].tvm_rt_latency_tot = 0;
@@ -341,7 +457,20 @@ mvtvm_ml_model_load(struct cnxk_ml_dev *cnxk_mldev, struct rte_ml_model_params *
 	return 0;
 
 error:
-	rte_memzone_free(mz);
+	mvtvm_ml_tvm_func_free(&register_cb_fn);
+	if (model != NULL) {
+		mvtvm_ml_tvm_func_free(&model->mvtvm.load_params);
+		mvtvm_ml_tvm_func_free(&model->mvtvm.set_input_zero_copy);
+		mvtvm_ml_tvm_func_free(&model->mvtvm.set_output_zero_copy);
+		mvtvm_ml_tvm_func_free(&model->mvtvm.run);
+		mvtvm_ml_tvm_mod_free(&model->mvtvm.graph_module);
+		if (model->mvtvm.fd >= 0)
+			close(model->mvtvm.fd);
+		memset(&model->mvtvm, 0, sizeof(model->mvtvm));
+		model->mvtvm.fd = -1;
+	}
+	mvtvm_ml_tvm_mod_free(&module_so);
+	plt_memzone_free(mz);
 
 	return ret;
 }
@@ -351,20 +480,28 @@ mvtvm_ml_model_unload(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *mode
 {
 	char str[RTE_MEMZONE_NAMESIZE];
 	const struct plt_memzone *mz;
-	int ret;
 
 	RTE_SET_USED(cnxk_mldev);
 
-	/* Initialize model in TVMDP */
-	ret = tvmdp_model_unload(model->model_id);
-	if (ret != 0) {
-		plt_err("TVMDP: Model unload failed, model_id = %u, error = %d", model->model_id,
-			ret);
-		return ret;
-	}
+	/* Unload model from TVM runtime */
+	if (model->model_id >= cnxk_mldev->mldev->data->nb_models)
+		return -EINVAL;
+
+	if (model->mvtvm.graph_module == NULL)
+		return -EINVAL;
+
+	mvtvm_ml_tvm_func_free(&model->mvtvm.load_params);
+	mvtvm_ml_tvm_func_free(&model->mvtvm.set_input_zero_copy);
+	mvtvm_ml_tvm_func_free(&model->mvtvm.set_output_zero_copy);
+	mvtvm_ml_tvm_func_free(&model->mvtvm.run);
+	mvtvm_ml_tvm_mod_free(&model->mvtvm.graph_module);
+	if (model->mvtvm.fd >= 0)
+		close(model->mvtvm.fd);
+	memset(&model->mvtvm, 0, sizeof(model->mvtvm));
+	model->mvtvm.fd = -1;
 
 	snprintf(str, RTE_MEMZONE_NAMESIZE, "%s_%u", MVTVM_ML_MODEL_MEMZONE_NAME, model->model_id);
-	mz = rte_memzone_lookup(str);
+	mz = plt_memzone_lookup(str);
 	if (mz == NULL) {
 		plt_err("Memzone lookup failed for TVM model: model_id = %u, mz = %s",
 			model->model_id, str);
@@ -455,13 +592,13 @@ mvtvm_ml_io_quantize(void *device, uint16_t model_id, const char *layer_name,
 #endif
 
 	/* Get layer id */
-	for (layer_id = 0; layer_id < model->mvtvm.metadata.model.nb_layers; layer_id++) {
+	for (layer_id = 0; layer_id < model->nb_layers; layer_id++) {
 		if (strcmp(model->layer[layer_id].name, layer_name) == 0)
 			break;
 	}
 
 #ifdef CNXK_ML_DEV_DEBUG
-	if (layer_id == model->mvtvm.metadata.model.nb_layers) {
+	if (layer_id == model->nb_layers) {
 		plt_err("Invalid layer name: %s", layer_name);
 		return -EINVAL;
 	}
@@ -516,13 +653,13 @@ mvtvm_ml_io_dequantize(void *device, uint16_t model_id, const char *layer_name,
 	}
 #endif
 
-	for (layer_id = 0; layer_id < model->mvtvm.metadata.model.nb_layers; layer_id++) {
+	for (layer_id = 0; layer_id < model->nb_layers; layer_id++) {
 		if (strcmp(model->layer[layer_id].name, layer_name) == 0)
 			break;
 	}
 
 #ifdef CNXK_ML_DEV_DEBUG
-	if (layer_id == model->mvtvm.metadata.model.nb_layers) {
+	if (layer_id == model->nb_layers) {
 		plt_err("Invalid layer name: %s", layer_name);
 		return -EINVAL;
 	}
@@ -553,28 +690,69 @@ static int
 mvtvm_ml_model_run(struct cnxk_ml_model *model, struct rte_ml_op *op, struct cnxk_ml_req *req)
 {
 	uint8_t i;
+	struct mvtvm_ml_result *run_result;
+	TVMValue arg_values[2] = {0};
+	int arg_types[2] = {0};
+	TVMValue ret_value = {0};
+	int ret_type = kTVMNullptr;
+	int ret = 0;
 
 	rte_memcpy(req->mvtvm_req.input_tensor, model->mvtvm.input_tensor,
-		   model->mvtvm.metadata.model.num_input * sizeof(DLTensor));
-	for (i = 0; i < model->mvtvm.metadata.model.num_input; i++) {
+		   model->mvtvm.info.nb_inputs * sizeof(DLTensor));
+	for (i = 0; i < model->mvtvm.info.nb_inputs; i++) {
 		req->mvtvm_req.input_tensor[i].data = op->input[i]->addr;
 		req->mvtvm_req.input_tensor[i].byte_offset = 0;
 	}
 
 	rte_memcpy(req->mvtvm_req.output_tensor, model->mvtvm.output_tensor,
-		   model->mvtvm.metadata.model.num_output * sizeof(DLTensor));
-	for (i = 0; i < model->mvtvm.metadata.model.num_output; i++) {
+		   model->mvtvm.info.nb_outputs * sizeof(DLTensor));
+	for (i = 0; i < model->mvtvm.info.nb_outputs; i++) {
 		req->mvtvm_req.output_tensor[i].data = op->output[i]->addr;
 		req->mvtvm_req.output_tensor[i].byte_offset = 0;
 	}
 
-	tvmdp_model_run(model->model_id, model->mvtvm.metadata.model.num_input,
-			req->mvtvm_req.input_tensor, model->mvtvm.metadata.model.num_output,
-			req->mvtvm_req.output_tensor, &req->mvtvm_req.result,
-			&req->mvtvm_req.status);
+	run_result = &req->mvtvm_req.result;
+	run_result->stats.start_ns = rte_get_tsc_cycles();
+	run_result->error_code = 0;
+
+	for (i = 0; i < model->mvtvm.info.nb_inputs; i++) {
+		arg_values[0].v_int64 = i;
+		arg_types[0] = kDLInt;
+		arg_values[1].v_handle = &req->mvtvm_req.input_tensor[i];
+		arg_types[1] = kTVMDLTensorHandle;
+		ret = mvtvm_ml_tvm_func_call(model, model->mvtvm.set_input_zero_copy,
+					     "set_input_zero_copy", arg_values, arg_types, 2,
+					     &ret_value, &ret_type, kTVMNullptr);
+		if (ret != 0)
+			goto out;
+	}
+
+	for (i = 0; i < model->mvtvm.info.nb_outputs; i++) {
+		arg_values[0].v_int64 = i;
+		arg_types[0] = kDLInt;
+		arg_values[1].v_handle = &req->mvtvm_req.output_tensor[i];
+		arg_types[1] = kTVMDLTensorHandle;
+		ret = mvtvm_ml_tvm_func_call(model, model->mvtvm.set_output_zero_copy,
+					     "set_output_zero_copy", arg_values, arg_types, 2,
+					     &ret_value, &ret_type, kTVMNullptr);
+		if (ret != 0)
+			goto out;
+	}
+
+	ret = mvtvm_ml_tvm_func_call(model, model->mvtvm.run, "run", NULL, NULL, 0, &ret_value,
+				     &ret_type, kTVMNullptr);
+	if (ret != 0)
+		goto out;
+
+out:
+	run_result->stats.end_ns = rte_get_tsc_cycles();
+	req->mvtvm_req.status = 0x1;
 
 	plt_write64(ML_CNXK_POLL_JOB_FINISH, req->status);
 
+	if (ret != 0)
+		run_result->error_code = -EIO;
+
 	return 0;
 }
 
diff --git a/drivers/ml/cnxk/mvtvm_ml_ops.h b/drivers/ml/cnxk/mvtvm_ml_ops.h
index d8f2f361fb1..593f4585b3c 100644
--- a/drivers/ml/cnxk/mvtvm_ml_ops.h
+++ b/drivers/ml/cnxk/mvtvm_ml_ops.h
@@ -7,11 +7,10 @@
 
 #include <dlpack/dlpack.h>
 
-#include <tvmdp.h>
-
 #include <rte_mldev.h>
 
 #include "cnxk_ml_xstats.h"
+#include "mvtvm_ml_model.h"
 
 struct cnxk_ml_dev;
 struct cnxk_ml_model;
@@ -56,8 +55,6 @@ struct mvtvm_ml_req {
 };
 
 int mvtvm_ml_dev_info_get(struct cnxk_ml_dev *mldev, struct rte_ml_dev_info *dev_info);
-int mvtvm_ml_dev_configure(struct cnxk_ml_dev *cnxk_mldev, const struct rte_ml_dev_config *conf);
-int mvtvm_ml_dev_close(struct cnxk_ml_dev *cnxk_mldev);
 int mvtvm_ml_dev_dump(struct cnxk_ml_dev *cnxk_mldev, FILE *fp);
 int mvtvm_ml_model_load(struct cnxk_ml_dev *cnxk_mldev, struct rte_ml_model_params *params,
 			struct cnxk_ml_model *model);
diff --git a/drivers/ml/cnxk/mvtvm_ml_stubs.c b/drivers/ml/cnxk/mvtvm_ml_stubs.c
index 126a954c916..7c13fac42d6 100644
--- a/drivers/ml/cnxk/mvtvm_ml_stubs.c
+++ b/drivers/ml/cnxk/mvtvm_ml_stubs.c
@@ -76,23 +76,6 @@ mvtvm_ml_dev_info_get(struct cnxk_ml_dev *cnxk_mldev, struct rte_ml_dev_info *de
 	return -ENOTSUP;
 }
 
-int
-mvtvm_ml_dev_configure(struct cnxk_ml_dev *cnxk_mldev, const struct rte_ml_dev_config *conf)
-{
-	RTE_SET_USED(cnxk_mldev);
-	RTE_SET_USED(conf);
-
-	return 0;
-}
-
-int
-mvtvm_ml_dev_close(struct cnxk_ml_dev *cnxk_mldev)
-{
-	RTE_SET_USED(cnxk_mldev);
-
-	return 0;
-}
-
 int
 mvtvm_ml_dev_dump(struct cnxk_ml_dev *cnxk_mldev, FILE *fp)
 {
diff --git a/drivers/ml/cnxk/mvtvm_ml_stubs.h b/drivers/ml/cnxk/mvtvm_ml_stubs.h
index 4220a963f2d..15985a75bf4 100644
--- a/drivers/ml/cnxk/mvtvm_ml_stubs.h
+++ b/drivers/ml/cnxk/mvtvm_ml_stubs.h
@@ -15,8 +15,6 @@ struct cnxk_ml_layer;
 
 enum cnxk_ml_model_type mvtvm_ml_model_type_get(struct rte_ml_model_params *params);
 int mvtvm_ml_dev_info_get(struct cnxk_ml_dev *cnxk_mldev, struct rte_ml_dev_info *dev_info);
-int mvtvm_ml_dev_configure(struct cnxk_ml_dev *cnxk_mldev, const struct rte_ml_dev_config *conf);
-int mvtvm_ml_dev_close(struct cnxk_ml_dev *cnxk_mldev);
 int mvtvm_ml_dev_dump(struct cnxk_ml_dev *cnxk_mldev, FILE *fp);
 int mvtvm_ml_model_load(struct cnxk_ml_dev *cnxk_mldev, struct rte_ml_model_params *params,
 			struct cnxk_ml_model *model);
-- 
2.34.1

