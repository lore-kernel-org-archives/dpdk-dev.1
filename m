Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7649CC3ABC0
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 May 2025 07:44:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74B754060C;
	Thu,  8 May 2025 09:44:19 +0200 (CEST)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id 249094025A
 for <dev@dpdk.org>; Thu,  8 May 2025 09:44:18 +0200 (CEST)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-30aa3980af5so968938a91.0
 for <dev@dpdk.org>; Thu, 08 May 2025 00:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746690257; x=1747295057; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZunrMm1acd0v0XXNP8BT8Bbb8tRGxbWjUC27h3MwpRs=;
 b=lYLStiLUXcMxKX4NdXdR8pz0BkbcdS8kF5wE6cpDvzEgLG8x2OifNGwSWOWYfALwDq
 JcNEtNQ77ikW2d6bNyMP9qiE1lTIJ17pCaXjqfWlWTlBJRV7+R+UKvKuXvgyddv58f4C
 b3GWECK8+48QVaKpH4HpM+kG4pGiYsC16IqIXfwAJm938GUHQLywDK00unU+83Zz8Fg9
 k5HliaUICJ2gdDqvgGhLkqFGhhCmy8ZTvmzqx450KBcBm1ih0yF2Og0eKViSRByB5fvA
 fRIUC94O1XGp8kswdjc0tMCh/uO6fNLkvrsjjOZWSzV/uoumXeu+td1IlT+V+csNjLM6
 P/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746690257; x=1747295057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZunrMm1acd0v0XXNP8BT8Bbb8tRGxbWjUC27h3MwpRs=;
 b=YliaB83q6pq2k4krKYYrWLbUXbSjCo4nX/leYxw9a9j5grdVi/HInXWqoOj/VVPLag
 fCXZteQP0xsXRMf0jzHFK/D2lnXSQj5Vf+g632Y1TsQf0JZeljJHtQ3VDZWohR0+lKEE
 djx0HCohRzlHp3p8bP4OYl14dhokeJJLdjpwcBQE0HTNfvEOsByiU7c7/FMJcoB6EG6y
 iNtn8lV9Y5JiApZ99yxnjKTDQlpHHGN2emCHJQsasitgat/7mcR4sv61aONvAtxyTfhF
 lRCx8JvJFmTmcTdy1UKwwONkWwL2Pl0yTnD4hCZv7h6hpa57LdsvZMPkUXlmGHzeBeWV
 qpkA==
X-Gm-Message-State: AOJu0YyJW7RUPXfRK+/s9d2jyniWmi0Ug5avEF4JlqjYjxUTuWv9O49k
 HSiKNyG5rdWyLIj4IyrsxKXUCk74987xxEWgZH7feVimO6B+qe+LQbhcvt1hSdE=
X-Gm-Gg: ASbGncvUhPuAD3vCdZ6ZqIXAV1RCg8oAFwe4s4Kl+3owtESBPJvRjXY5eCt+8yxlK+f
 1Fi2vuYPcGdhq5hJ3PAHADJ66u1ThbF7iGe7mO9NqPHZb2rsRVoV0XmtpqRNqH9boSxhqkl/rsA
 EQh0V4RGln7LAvEGQUmErDmipjEM9RIa/ezQU4sKMNXIhSsjhnepc+ZFK3IeeCE1ANmqFm1YoXD
 J3orZ+4W7ybMN7a0laB9AABSV4z6EbfAIpoymgxcXtH0n9CSIbA01Pd90spsJik5dLf7daVSwnR
 zi1eqqSOA0yiuu0861lkFD0Xax2VaGv5uHP7r7q0BA==
X-Google-Smtp-Source: AGHT+IGxOgggCno5F/E/CeblfXFhQTSZo/iqKRdKzznDR7v9AHLe2VXzy6JLKhfmLlr+xx36CWyV7w==
X-Received: by 2002:a17:90b:17cd:b0:309:f53c:b0a0 with SMTP id
 98e67ed59e1d1-30aac2933e5mr9925296a91.24.1746690256914; 
 Thu, 08 May 2025 00:44:16 -0700 (PDT)
Received: from gmail.com ([121.37.54.139]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30ad4f55825sm1504542a91.31.2025.05.08.00.41.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 00:44:16 -0700 (PDT)
From: Zhangfei Gao <zhangfei.gao@linaro.org>
To: Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Ashish Gupta <ashish.gupta@marvell.com>
Cc: dev@dpdk.org,
	Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH 1/2] compress/uadk: use async mode to replace sync mode
Date: Thu,  8 May 2025 07:41:18 +0000
Message-Id: <20250508074119.356011-2-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250508074119.356011-1-zhangfei.gao@linaro.org>
References: <20250508074119.356011-1-zhangfei.gao@linaro.org>
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

To get better performance, using async mode to replace sync mode

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/compress/uadk/uadk_compress_pmd.c     | 107 +++++++++++++-----
 .../compress/uadk/uadk_compress_pmd_private.h |   2 +-
 2 files changed, 82 insertions(+), 27 deletions(-)

diff --git a/drivers/compress/uadk/uadk_compress_pmd.c b/drivers/compress/uadk/uadk_compress_pmd.c
index 1f4c4cfd00..1d87208d0b 100644
--- a/drivers/compress/uadk/uadk_compress_pmd.c
+++ b/drivers/compress/uadk/uadk_compress_pmd.c
@@ -12,6 +12,9 @@
 
 #include "uadk_compress_pmd_private.h"
 
+#define UADK_COMP_DEF_CTXS    2
+static char alg_name[8] = "deflate";
+
 static const struct
 rte_compressdev_capabilities uadk_compress_pmd_capabilities[] = {
 	{   /* Deflate */
@@ -29,16 +32,49 @@ uadk_compress_pmd_config(struct rte_compressdev *dev,
 			 struct rte_compressdev_config *config __rte_unused)
 {
 	struct uadk_compress_priv *priv = dev->data->dev_private;
+	struct wd_ctx_params cparams = {0};
+	struct wd_ctx_nums *ctx_set_num;
 	int ret;
 
-	if (!priv->env_init) {
-		ret = wd_comp_env_init(NULL);
-		if (ret < 0)
-			return -EINVAL;
-		priv->env_init = true;
+	if (priv->init)
+		return 0;
+
+	ctx_set_num = calloc(WD_DIR_MAX, sizeof(*ctx_set_num));
+	if (!ctx_set_num) {
+		UADK_LOG(ERR, "failed to alloc ctx_set_size!");
+		return -WD_ENOMEM;
+	}
+
+	cparams.op_type_num = WD_DIR_MAX;
+	cparams.ctx_set_num = ctx_set_num;
+	cparams.bmp = numa_allocate_nodemask();
+	if (!cparams.bmp) {
+		UADK_LOG(ERR, "failed to create nodemask!");
+		ret = -WD_ENOMEM;
+		goto out_freectx;
 	}
 
+	numa_bitmask_setall(cparams.bmp);
+
+	for (int i = 0; i < WD_DIR_MAX; i++)
+		ctx_set_num[i].async_ctx_num = UADK_COMP_DEF_CTXS;
+
+	ret = wd_comp_init2_(alg_name, SCHED_POLICY_RR, TASK_HW, &cparams);
+	numa_free_nodemask(cparams.bmp);
+	free(ctx_set_num);
+
+	if (ret) {
+		UADK_LOG(ERR, "failed to do comp init2!");
+		return ret;
+	}
+
+	priv->init = true;
+
 	return 0;
+
+out_freectx:
+	free(ctx_set_num);
+	return ret;
 }
 
 static int
@@ -57,9 +93,9 @@ uadk_compress_pmd_close(struct rte_compressdev *dev)
 {
 	struct uadk_compress_priv *priv = dev->data->dev_private;
 
-	if (priv->env_init) {
-		wd_comp_env_uninit();
-		priv->env_init = false;
+	if (priv->init) {
+		wd_comp_uninit2();
+		priv->init = false;
 	}
 
 	return 0;
@@ -291,9 +327,25 @@ static struct rte_compressdev_ops uadk_compress_pmd_ops = {
 		.private_xform_free	= uadk_compress_pmd_xform_free,
 };
 
+static void *uadk_compress_pmd_async_cb(struct wd_comp_req *req,
+					void *data __rte_unused)
+{
+	struct rte_comp_op *op = req->cb_param;
+	uint16_t dst_len = rte_pktmbuf_data_len(op->m_dst);
+
+	if (req->dst_len <= dst_len) {
+		op->produced += req->dst_len;
+		op->status = RTE_COMP_OP_STATUS_SUCCESS;
+	} else  {
+		op->status = RTE_COMP_OP_STATUS_OUT_OF_SPACE_TERMINATED;
+	}
+
+	return NULL;
+}
+
 static uint16_t
-uadk_compress_pmd_enqueue_burst_sync(void *queue_pair,
-				     struct rte_comp_op **ops, uint16_t nb_ops)
+uadk_compress_pmd_enqueue_burst_async(void *queue_pair,
+				      struct rte_comp_op **ops, uint16_t nb_ops)
 {
 	struct uadk_compress_qp *qp = queue_pair;
 	struct uadk_compress_xform *xform;
@@ -318,21 +370,15 @@ uadk_compress_pmd_enqueue_burst_sync(void *queue_pair,
 				req.dst = rte_pktmbuf_mtod(op->m_dst, uint8_t *);
 				req.dst_len = dst_len;
 				req.op_type = (enum wd_comp_op_type)xform->type;
-				req.cb = NULL;
+				req.cb = uadk_compress_pmd_async_cb;
+				req.cb_param = op;
 				req.data_fmt = WD_FLAT_BUF;
 				do {
-					ret = wd_do_comp_sync(xform->handle, &req);
+					ret = wd_do_comp_async(xform->handle, &req);
 				} while (ret == -WD_EBUSY);
 
 				op->consumed += req.src_len;
 
-				if (req.dst_len <= dst_len) {
-					op->produced += req.dst_len;
-					op->status = RTE_COMP_OP_STATUS_SUCCESS;
-				} else  {
-					op->status = RTE_COMP_OP_STATUS_OUT_OF_SPACE_TERMINATED;
-				}
-
 				if (ret) {
 					op->status = RTE_COMP_OP_STATUS_ERROR;
 					break;
@@ -361,18 +407,27 @@ uadk_compress_pmd_enqueue_burst_sync(void *queue_pair,
 }
 
 static uint16_t
-uadk_compress_pmd_dequeue_burst_sync(void *queue_pair,
-				     struct rte_comp_op **ops,
-				     uint16_t nb_ops)
+uadk_compress_pmd_dequeue_burst_async(void *queue_pair,
+				      struct rte_comp_op **ops,
+				      uint16_t nb_ops)
 {
 	struct uadk_compress_qp *qp = queue_pair;
 	unsigned int nb_dequeued = 0;
+	unsigned int recv = 0;
+	int ret;
 
 	nb_dequeued = rte_ring_dequeue_burst(qp->processed_pkts,
 			(void **)ops, nb_ops, NULL);
+	if (nb_dequeued == 0)
+		return 0;
+
+	do {
+		ret = wd_comp_poll(nb_dequeued, &recv);
+	} while (ret == -WD_EAGAIN);
+
 	qp->qp_stats.dequeued_count += nb_dequeued;
 
-	return nb_dequeued;
+	return recv;
 }
 
 static int
@@ -386,7 +441,7 @@ uadk_compress_probe(struct rte_vdev_device *vdev)
 	struct uacce_dev *udev;
 	const char *name;
 
-	udev = wd_get_accel_dev("deflate");
+	udev = wd_get_accel_dev(alg_name);
 	if (!udev)
 		return -ENODEV;
 
@@ -402,8 +457,8 @@ uadk_compress_probe(struct rte_vdev_device *vdev)
 	}
 
 	compressdev->dev_ops = &uadk_compress_pmd_ops;
-	compressdev->dequeue_burst = uadk_compress_pmd_dequeue_burst_sync;
-	compressdev->enqueue_burst = uadk_compress_pmd_enqueue_burst_sync;
+	compressdev->dequeue_burst = uadk_compress_pmd_dequeue_burst_async;
+	compressdev->enqueue_burst = uadk_compress_pmd_enqueue_burst_async;
 	compressdev->feature_flags = RTE_COMPDEV_FF_HW_ACCELERATED;
 
 	return 0;
diff --git a/drivers/compress/uadk/uadk_compress_pmd_private.h b/drivers/compress/uadk/uadk_compress_pmd_private.h
index 6db53744fd..1b8708889d 100644
--- a/drivers/compress/uadk/uadk_compress_pmd_private.h
+++ b/drivers/compress/uadk/uadk_compress_pmd_private.h
@@ -7,7 +7,7 @@
 #define _UADK_COMPRESS_PMD_PRIVATE_H_
 
 struct uadk_compress_priv {
-	bool env_init;
+	bool init;
 };
 
 struct __rte_cache_aligned uadk_compress_qp {
-- 
2.25.1

