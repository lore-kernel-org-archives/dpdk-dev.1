Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C7AC5DF81
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:27:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7BD0940E5A;
	Thu, 20 Aug 2026 07:26:12 +0200 (CEST)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mails.dpdk.org (Postfix) with ESMTP id 5022840E41
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:26:03 +0200 (CEST)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-c9eefcf9175so1401306a12.3
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203562;
 x=1787808362; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Lo8hW2g6r3ZTBJdCFczF42DqQHibyrx9y9JL5xU6QsY=;
 b=PhDYICj9Y1ROM4Ca70D7Qtlceizh1szphMq3L/dHPHlQZ5l60tifboXpPXwUZYO6zj
 L6sADEgoN+HwpQv3Lof+31Md0G4m3B3rAJAaAQpBoiqORtFqpApSL2XqpaDOMYySl511
 Z6D/JGvYHlTkr+U5NQILiSWgKDrnYSynuRxUtSf0o6XnL47dmCOAzGpmWSUo4Fy5oMcW
 fOkS/WFPCanjnBFHewFeQoHVODLLPzQH6TwNR3cINJa/JIt+hwenN+K+O3oro4JA/yGN
 PF+l8Ux2B1ZHYGmycXRv4xRpcye9wPCjj3YPo83VoCwLOQ1OtqsxcKYSRYLKtV4SuXre
 0hhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203562; x=1787808362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Lo8hW2g6r3ZTBJdCFczF42DqQHibyrx9y9JL5xU6QsY=;
 b=B+75PKJBo4J9WrUyakHBeszmWNyi0LuNjm5tcUgjQOLT1vUslUE/S4clce5+/IYbE/
 L1lqpuIhE4xTfAMeJuuNAvElikvc7MypEIWH7mfnrI/u3LNh3BOdQbSfOWvTzxJEBJL5
 DduP35T7WPJrgeRulQXtGo7ZQnb09UP+1PKr3dX+gadJoBOJeKSoUO6KOIvCXvn123zY
 Y9ycwTdJufK368o35WO7sQHX2DC/LHhNXBKEO2R9/9qptTdZE2ucQ4XDPYpwlJeNVxk6
 AaVXru2hy8lziMpdqrGE3nstLGp5aRt+o6F/xj0d5V1YoM++G/4Wza5q+pZ4jOYN5uQR
 HCcA==
X-Gm-Message-State: AOJu0Yw/WIexGHi+VSCqLfpuzA5hlBOq0sBJY0xy8Z5mZZajJK8LTsEE
 +bEemdOWlYKIxMc6C45tZEJqHxfP2gxxdKb8pte7jDk4t6m4bCnXtLhcx+KA5V0QcovC/hg3GoZ
 /2/4q
X-Gm-Gg: AR+sD12EqUfHJiRfFd7PMSzKyHqmbqyCkBir/Qnh2nTYeLhRbda+3yrbuj4K+GExWow
 4CwR+iMq+f9Hc1N16s6IuagfGbIAu+BJbGbLqij9cHzx43hOp0/HOj2ggAH6UgR6St5rhQqjmo4
 DbZ78x/X8RMs6a+za0Ec8LjQvr7jMDfTiYfngB1HLJdonfyVCCI0Mi6j7yyLr41YdUdVGF5eAm4
 5Fm4A3wVTWyL+ZGgFnL6qbIKbOzpcTO5v6QdImNJf7MT1HRghUJmS068muEu+bSn6HEm73ei365
 tCDXSZ8obxu/AiNDlzCZkUensT3dSztTuHo+DO+o3ntyYjKGRaAl80tJgAe+2IAXojcRtDZA+/c
 S4O2xDbEEObn8QqcpjakVds2DClnJzVzdCQgvhCMheqmPGOLlsOIz/LpDj2q5vEkEWm+pbFuVUN
 F6q/VIkZwnuFbNO/znjBXfEHb08Aey2blmtiKo9fXvyHaQUsX525CojIMkUAK95CxKN4Wm5M9t2
 X8QP/VfK46loTaBaHlGOQYlOec=
X-Received: by 2002:a05:6a21:6d87:b0:3c3:bbe6:95c7 with SMTP id
 adf61e73a8af0-3cd01253cf7mr18684202637.17.1787203562407; 
 Wed, 19 Aug 2026 22:26:02 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.25.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:26:01 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Srikanth Yalavarthi <syalavarthi@marvell.com>
Subject: [PATCH 50/61] ml/cnxk: use memcpy for fixed size data
Date: Wed, 19 Aug 2026 22:12:40 -0700
Message-ID: <20260820052251.1453273-51-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
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
index fa978529f5..7e2c460fb4 100644
--- a/drivers/ml/cnxk/cn10k_ml_model.c
+++ b/drivers/ml/cnxk/cn10k_ml_model.c
@@ -564,7 +564,7 @@ cn10k_ml_model_info_set(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *mo
 
 	/* Set model info */
 	memset(info, 0, sizeof(struct rte_ml_model_info));
-	rte_memcpy(info->name, metadata->model.name, MRVL_ML_MODEL_NAME_LEN);
+	memcpy(info->name, metadata->model.name, MRVL_ML_MODEL_NAME_LEN);
 	snprintf(info->version, RTE_ML_STR_MAX, "%u.%u.%u.%u", metadata->model.version[0],
 		 metadata->model.version[1], metadata->model.version[2],
 		 metadata->model.version[3]);
@@ -583,7 +583,8 @@ cn10k_ml_model_info_set(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *mo
 
 	/* Set input info */
 	for (i = 0; i < info->nb_inputs; i++) {
-		rte_memcpy(input[i].name, io_info->input[i].name, MRVL_ML_INPUT_NAME_LEN);
+		memcpy(input[i].name, io_info->input[i].name,
+		       MRVL_ML_INPUT_NAME_LEN);
 		input[i].nb_dims = io_info->input[i].nb_dims;
 		input[i].shape = &io_info->input[i].shape[0];
 		input[i].type = io_info->input[i].qtype;
@@ -596,7 +597,8 @@ cn10k_ml_model_info_set(struct cnxk_ml_dev *cnxk_mldev, struct cnxk_ml_model *mo
 
 	/* Set output info */
 	for (i = 0; i < info->nb_outputs; i++) {
-		rte_memcpy(output[i].name, io_info->output[i].name, MRVL_ML_INPUT_NAME_LEN);
+		memcpy(output[i].name, io_info->output[i].name,
+		       MRVL_ML_INPUT_NAME_LEN);
 		output[i].nb_dims = io_info->output[i].nb_dims;
 		output[i].shape = &io_info->output[i].shape[0];
 		output[i].type = io_info->output[i].qtype;
diff --git a/drivers/ml/cnxk/cn10k_ml_ops.c b/drivers/ml/cnxk/cn10k_ml_ops.c
index 597806b787..79a03dc10b 100644
--- a/drivers/ml/cnxk/cn10k_ml_ops.c
+++ b/drivers/ml/cnxk/cn10k_ml_ops.c
@@ -668,7 +668,8 @@ cn10k_ml_layer_load(void *device, uint16_t model_id, const char *layer_name, uin
 	}
 
 	/* Copy metadata to internal buffer */
-	rte_memcpy(&layer->glow.metadata, buffer, sizeof(struct cn10k_ml_model_metadata));
+	memcpy(&layer->glow.metadata, buffer,
+	       sizeof(struct cn10k_ml_model_metadata));
 	cn10k_ml_model_metadata_update(&layer->glow.metadata);
 
 	/* Enable support for batch_size of 256 */
@@ -745,11 +746,12 @@ cn10k_ml_model_load(struct cnxk_ml_dev *cnxk_mldev, struct rte_ml_model_params *
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
index f6b3a51c51..191f93486a 100644
--- a/drivers/ml/cnxk/tvmrt_ml_ops.c
+++ b/drivers/ml/cnxk/tvmrt_ml_ops.c
@@ -229,7 +229,7 @@ tvmrt_ml_model_load(struct cnxk_ml_dev *cnxk_mldev, struct rte_ml_model_params *
 	/* Copy mod.so */
 	model->tvmrt.so.buffer = mz->addr;
 	model->tvmrt.so.size = object[0].size;
-	rte_memcpy(model->tvmrt.so.name, object[0].name, RTE_ML_STR_MAX);
+	memcpy(model->tvmrt.so.name, object[0].name, RTE_ML_STR_MAX);
 	rte_memcpy(model->tvmrt.so.buffer, object[0].buffer, object[0].size);
 	rte_free(object[0].buffer);
 
@@ -238,7 +238,7 @@ tvmrt_ml_model_load(struct cnxk_ml_dev *cnxk_mldev, struct rte_ml_model_params *
 		RTE_PTR_ADD(model->tvmrt.so.buffer,
 			    RTE_ALIGN_CEIL(model->tvmrt.so.size, RTE_CACHE_LINE_MIN_SIZE));
 	model->tvmrt.json.size = object[1].size;
-	rte_memcpy(model->tvmrt.json.name, object[1].name, RTE_ML_STR_MAX);
+	memcpy(model->tvmrt.json.name, object[1].name, RTE_ML_STR_MAX);
 	rte_memcpy(model->tvmrt.json.buffer, object[1].buffer, object[1].size);
 	rte_free(object[1].buffer);
 
@@ -247,7 +247,7 @@ tvmrt_ml_model_load(struct cnxk_ml_dev *cnxk_mldev, struct rte_ml_model_params *
 		RTE_PTR_ADD(model->tvmrt.json.buffer,
 			    RTE_ALIGN_CEIL(model->tvmrt.json.size, RTE_CACHE_LINE_MIN_SIZE));
 	model->tvmrt.params.size = object[2].size;
-	rte_memcpy(model->tvmrt.params.name, object[2].name, RTE_ML_STR_MAX);
+	memcpy(model->tvmrt.params.name, object[2].name, RTE_ML_STR_MAX);
 	rte_memcpy(model->tvmrt.params.buffer, object[2].buffer, object[2].size);
 	rte_free(object[2].buffer);
 
-- 
2.53.0

