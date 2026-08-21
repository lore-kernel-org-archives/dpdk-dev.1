Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581E8C5DF8C
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:32:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E3AF540E22;
	Fri, 21 Aug 2026 21:31:18 +0200 (CEST)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mails.dpdk.org (Postfix) with ESMTP id 3A3AE40E30
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:31:17 +0200 (CEST)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-ca00f126b7eso1039158a12.2
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340676;
 x=1787945476; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ENq3sxqv+v6t/lPIQuS7ckoPou4nu25llBp0/lxXZVU=;
 b=vkTcOxIXoJYMQgPlUGrg0dO8jKUzwYFVDdp5ZqDJqE0Qjq4WLf4SGqX2pUDccbHdoL
 KOJfRDNtDKaaaOQObji1CmrrXiuf67/zD3m7Ooj1hijqsXsWkUs9Top/nCHRiOaMFYmI
 RjtHhbb2o5dXH5sl7mnkZL17i7dznQn9nufaQgHN96qEbqduwekxQyhl1Q+brX1LIhg1
 tuTGau4+DVc2oG9N1sxjAwJz0kueQQT6ACunZj3tQbwzlzaN9vszqN1sStku7QyYM3Lu
 a1MnaHKlBAEgnpWRFWrUIywHlXuqIn5MuBa1IDBpGyuoUKjm6sk8yjzzRb/4bKKem9mJ
 u0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340676; x=1787945476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ENq3sxqv+v6t/lPIQuS7ckoPou4nu25llBp0/lxXZVU=;
 b=PtZVQfJaay/yZ7e8BlZOsRoOaKD9Ya2WcwdCoSkJ177AbRaqk6yXlSdNzbY2MErdhQ
 lofbdH/KVUJEn665a/9ozpeCr/WJEwU2fjFGQbibLae1dNEwvijFty+Ty+o7m/Z6PhF8
 +6omsi9TsQeSnWbXVsMTLilj6H91MJ421QEsjq6YTqLgolRjAjNksRlvfe/YelPg0XyQ
 LtOfSWO0szTRUUcnHHoSXQpvYMH7vHANc1thSlHwgcveCCaQKiruZ8HGcnovq+4LzdP/
 eOTSXrlqSpSWt63t622HUabGYtziFQt2DcD1CROjTT+Xs9lsOQBVbwqEpyK/pt1JB/km
 q9oA==
X-Gm-Message-State: AFuF++nnPPacC4qoyYgupczA6F6fhkpB61+Cb626BWC4+wO5+wypRlaa
 gySebeKepmVFxUmksi7dsk63wVbWp+wcspkW/y5/wnctoSp2IGGjsKoPYlp3q11bJHkcRr1rS4l
 q3tOtlOY=
X-Gm-Gg: AR+sD13jpUKDOezXssYt4sHGgTK+qxTkzMMoQljCU4cwJzU8j64yMXeR1FpJvcJ+i1d
 e4X8IHr6yi9xUSz/Y/+ld6+V8fmOH1DV4jPPAzhR6PvP6DO04Cq2NBIeVQXXDhIscNAOPRK3pJ+
 WxEflwUUc1+2UkXTB3o3s1Xv66f5ZhYv92QSefNWgBhQZsC8e7m0OgpfaFakKkwJGURo4n9hM2r
 3D9Jm300vc8nNWo0v0vBv5ZHsVdTIsyHvafylT88l14/4LIhLCg6Xebx0WQbxvXk4rxSRqG7CqJ
 JsjJanx46W/3ZEmLNaIyPqzWkbFNPFpOMWbAefwBAxHXVkCraIGbyNKvDNHCHiM8WFJ8pvrEzo4
 J8AXsBvhGmL7yNAU3AgpLBPBd1Zd7zBb1xi2UVptbyYcaW7rG0IPQX/B/f2K0SEWLuL/tgDRsp6
 AGZ9iulBxZA9ZKW7IhOzrgTOVePAc/eMAvvdLKcPE0Fl5++suPIMNEfvrGd2ouFMxRl4i9kheZG
 ROltbFm0OwBNVesdntiBStr564=
X-Received: by 2002:a05:6a21:2290:b0:3bf:8de9:c647 with SMTP id
 adf61e73a8af0-3cd4b6850a3mr2189052637.0.1787340676218; 
 Fri, 21 Aug 2026 12:31:16 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.31.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:31:15 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Srikanth Yalavarthi <syalavarthi@marvell.com>
Subject: [PATCH v2 57/68] ml/cnxk: use memcpy for fixed size data
Date: Fri, 21 Aug 2026 12:24:52 -0700
Message-ID: <20260821192646.146382-58-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

The regular libc memcpy is inline for fix sizes and has
better analysis coverage.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/ml/cnxk/cn10k_ml_model.c | 8 +++++---
 drivers/ml/cnxk/cn10k_ml_ops.c   | 8 +++++---
 drivers/ml/cnxk/tvmrt_ml_model.c | 9 +++++----
 drivers/ml/cnxk/tvmrt_ml_ops.c   | 6 +++---
 4 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/ml/cnxk/cn10k_ml_model.c b/drivers/ml/cnxk/cn10k_ml_model.c
index 58eebbf076..03817384dd 100644
--- a/drivers/ml/cnxk/cn10k_ml_model.c
+++ b/drivers/ml/cnxk/cn10k_ml_model.c
@@ -565,7 +565,7 @@ cn10k_ml_model_info_set(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *mo
 
 	/* Set model info */
 	memset(info, 0, sizeof(struct rte_ml_model_info));
-	rte_memcpy(info->name, metadata->model.name, MRVL_ML_MODEL_NAME_LEN);
+	memcpy(info->name, metadata->model.name, MRVL_ML_MODEL_NAME_LEN);
 	snprintf(info->version, RTE_ML_STR_MAX, "%u.%u.%u.%u", metadata->model.version[0],
 		 metadata->model.version[1], metadata->model.version[2],
 		 metadata->model.version[3]);
@@ -584,7 +584,8 @@ cn10k_ml_model_info_set(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *mo
 
 	/* Set input info */
 	for (i = 0; i < info->nb_inputs; i++) {
-		rte_memcpy(input[i].name, io_info->input[i].name, MRVL_ML_INPUT_NAME_LEN);
+		memcpy(input[i].name, io_info->input[i].name,
+		       MRVL_ML_INPUT_NAME_LEN);
 		input[i].nb_dims = io_info->input[i].nb_dims;
 		input[i].shape = &io_info->input[i].shape[0];
 		input[i].type = io_info->input[i].qtype;
@@ -597,7 +598,8 @@ cn10k_ml_model_info_set(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *mo
 
 	/* Set output info */
 	for (i = 0; i < info->nb_outputs; i++) {
-		rte_memcpy(output[i].name, io_info->output[i].name, MRVL_ML_INPUT_NAME_LEN);
+		memcpy(output[i].name, io_info->output[i].name,
+		       MRVL_ML_INPUT_NAME_LEN);
 		output[i].nb_dims = io_info->output[i].nb_dims;
 		output[i].shape = &io_info->output[i].shape[0];
 		output[i].type = io_info->output[i].qtype;
diff --git a/drivers/ml/cnxk/cn10k_ml_ops.c b/drivers/ml/cnxk/cn10k_ml_ops.c
index ffe3356720..07b767eded 100644
--- a/drivers/ml/cnxk/cn10k_ml_ops.c
+++ b/drivers/ml/cnxk/cn10k_ml_ops.c
@@ -669,7 +669,8 @@ cn10k_ml_layer_load(void *device, uint16_t model_id, const char *layer_name, uin
 	}
 
 	/* Copy metadata to internal buffer */
-	rte_memcpy(&layer->glow.metadata, buffer, sizeof(struct cn10k_ml_model_metadata));
+	memcpy(&layer->glow.metadata, buffer,
+	       sizeof(struct cn10k_ml_model_metadata));
 	cn10k_ml_model_metadata_update(&layer->glow.metadata);
 
 	/* Enable support for batch_size of 256 */
@@ -746,11 +747,12 @@ cn10k_ml_model_load(struct cnxk_ml_dev *cnxk_mldev, struct rte_ml_model_params *
 	model->subtype = ML_CNXK_MODEL_SUBTYPE_GLOW_MRVL;
 
 	/* Copy metadata to internal buffer */
-	rte_memcpy(&model->glow.metadata, params->addr, sizeof(struct cn10k_ml_model_metadata));
+	memcpy(&model->glow.metadata, params->addr,
+	       sizeof(struct cn10k_ml_model_metadata));
 	cn10k_ml_model_metadata_update(&model->glow.metadata);
 
 	/* Set model name */
-	rte_memcpy(model->name, (char *)model->glow.metadata.model.name, 64);
+	memcpy(model->name, (char *)model->glow.metadata.model.name, 64);
 
 	/* Enable support for batch_size of 256 */
 	if (model->glow.metadata.model.batch_size == 0)
diff --git a/drivers/ml/cnxk/tvmrt_ml_model.c b/drivers/ml/cnxk/tvmrt_ml_model.c
index 319c53a05b..f0bc616148 100644
--- a/drivers/ml/cnxk/tvmrt_ml_model.c
+++ b/drivers/ml/cnxk/tvmrt_ml_model.c
@@ -848,7 +848,7 @@ tvmrt_ml_model_info_set(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *mo
 	if (model->subtype == ML_CNXK_MODEL_SUBTYPE_TVM_MRVL)
 		goto tvm_mrvl_model;
 
-	rte_memcpy(info->name, model->name, RTE_ML_STR_MAX);
+	memcpy(info->name, model->name, RTE_ML_STR_MAX);
 	snprintf(info->version, RTE_ML_STR_MAX, "%u.%u.%u.%u", 0, 0, 0, 0);
 	info->model_id = model->model_id;
 	info->device_id = cnxk_mldev->mldev->data->dev_id;
@@ -863,7 +863,8 @@ tvmrt_ml_model_info_set(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *mo
 
 	/* Set input info */
 	for (i = 0; i < info->nb_inputs; i++) {
-		rte_memcpy(input[i].name, model->tvmrt.info.input[i].name, MRVL_ML_INPUT_NAME_LEN);
+		memcpy(input[i].name, model->tvmrt.info.input[i].name,
+		       MRVL_ML_INPUT_NAME_LEN);
 		input[i].nb_dims = model->tvmrt.info.input[i].nb_dims;
 		input[i].shape = &model->tvmrt.info.input[i].shape[0];
 		input[i].type = model->tvmrt.info.input[i].qtype;
@@ -876,8 +877,8 @@ tvmrt_ml_model_info_set(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *mo
 
 	/* Set output info */
 	for (i = 0; i < info->nb_outputs; i++) {
-		rte_memcpy(output[i].name, model->tvmrt.info.output[i].name,
-			   MRVL_ML_OUTPUT_NAME_LEN);
+		memcpy(output[i].name, model->tvmrt.info.output[i].name,
+		       MRVL_ML_OUTPUT_NAME_LEN);
 		output[i].nb_dims = model->tvmrt.info.output[i].nb_dims;
 		output[i].shape = &model->tvmrt.info.output[i].shape[0];
 		output[i].type = model->tvmrt.info.output[i].qtype;
diff --git a/drivers/ml/cnxk/tvmrt_ml_ops.c b/drivers/ml/cnxk/tvmrt_ml_ops.c
index 01493077bb..b00cec3bcc 100644
--- a/drivers/ml/cnxk/tvmrt_ml_ops.c
+++ b/drivers/ml/cnxk/tvmrt_ml_ops.c
@@ -230,7 +230,7 @@ tvmrt_ml_model_load(struct cnxk_ml_dev *cnxk_mldev, struct rte_ml_model_params *
 	/* Copy mod.so */
 	model->tvmrt.so.buffer = mz->addr;
 	model->tvmrt.so.size = object[0].size;
-	rte_memcpy(model->tvmrt.so.name, object[0].name, RTE_ML_STR_MAX);
+	memcpy(model->tvmrt.so.name, object[0].name, RTE_ML_STR_MAX);
 	rte_memcpy(model->tvmrt.so.buffer, object[0].buffer, object[0].size);
 	rte_free(object[0].buffer);
 
@@ -239,7 +239,7 @@ tvmrt_ml_model_load(struct cnxk_ml_dev *cnxk_mldev, struct rte_ml_model_params *
 		RTE_PTR_ADD(model->tvmrt.so.buffer,
 			    RTE_ALIGN_CEIL(model->tvmrt.so.size, RTE_CACHE_LINE_MIN_SIZE));
 	model->tvmrt.json.size = object[1].size;
-	rte_memcpy(model->tvmrt.json.name, object[1].name, RTE_ML_STR_MAX);
+	memcpy(model->tvmrt.json.name, object[1].name, RTE_ML_STR_MAX);
 	rte_memcpy(model->tvmrt.json.buffer, object[1].buffer, object[1].size);
 	rte_free(object[1].buffer);
 
@@ -248,7 +248,7 @@ tvmrt_ml_model_load(struct cnxk_ml_dev *cnxk_mldev, struct rte_ml_model_params *
 		RTE_PTR_ADD(model->tvmrt.json.buffer,
 			    RTE_ALIGN_CEIL(model->tvmrt.json.size, RTE_CACHE_LINE_MIN_SIZE));
 	model->tvmrt.params.size = object[2].size;
-	rte_memcpy(model->tvmrt.params.name, object[2].name, RTE_ML_STR_MAX);
+	memcpy(model->tvmrt.params.name, object[2].name, RTE_ML_STR_MAX);
 	rte_memcpy(model->tvmrt.params.buffer, object[2].buffer, object[2].size);
 	rte_free(object[2].buffer);
 
-- 
2.53.0

