Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6613CC8303D
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 02:42:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6903C4065D;
	Wed,  2 Jul 2025 04:42:41 +0200 (CEST)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44]) by mails.dpdk.org (Postfix) with ESMTP id 216ED4065A
 for <dev@dpdk.org>; Wed,  2 Jul 2025 04:42:40 +0200 (CEST)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-3138e64b42aso7327637a91.0
 for <dev@dpdk.org>; Tue, 01 Jul 2025 19:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751424159; x=1752028959; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g59LnJ7cIp9jk+x+EDOsKVQ4iyVNfXwrXknWHeMT16Y=;
 b=ChgMKL+/nsLs2nE4KZlikSp8ti4y+y6heNCTt3RvCnag0KqSHYjRqUJekLR9y9FOJf
 /C6WE4X4WgJ8EZqA+yUeHYWkHP/51QGTIy5HVa3LeMHG6qwuqnYrVIwglkgw8pQ5q1Y4
 NXd1emfAL4ggPM5KH3mkIFS7KWbL0s7cVNvQRqUvKdseO8hR1+FT2Pa8m0LqVINTkuUY
 q8upaP66+JPr/G2bFdKSEvEWjSLWflP/fYsE09WbkwTPJRkbe1XCGCr8Cf7/QJMbu+XZ
 /d3ZC1Vc02ScqDK447oBiLnrF9bdMAMYPlPHTCAnlbNRGxDNuZPA38bSGduZQ6UNyf62
 7wjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751424159; x=1752028959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g59LnJ7cIp9jk+x+EDOsKVQ4iyVNfXwrXknWHeMT16Y=;
 b=B+MQYar4kwLH+snNtUdEhbkig8F8iRYswrRGCKe6ahyNsEJqTxwh6RdVMclrymIkBM
 pn5hB0NRMJa0PTVGQo6YiRTWxWqM71WPOBCsrvrCkJ0PjsxhiCupEUvs6+LOqM/7z8sm
 x2CroBkIF+fzPhCJqpirdLFYxWyHZXJAwmVIbOwUtmy33aHSwwWEqHyZ6p7izr+RnkDa
 ChFh/ii0ac1mOJjfnj4Nvp4vUpZt3qpUG915e1GpNLhVbKUBA6+hr61/TnGAhfFVcds7
 oEEJR8RCkuHo1Q8jVNZyBqmfu6rJiSz/3SgP7jAPW4rXCir8S6Nmw207u7FMENwmrl56
 VaXw==
X-Gm-Message-State: AOJu0YzItAOwX3Lw8VRrHIGNClu4njQueFB4zyyWiYA3rLWA5yFmTzRh
 E/MVgx644uaYOW2z48ZujE75l3a4d+9hGzx+UPXZ+B48FrqUu8VHUOl+fZHcZrW7vX3pP3f/Jwq
 f4qNgWTv4Lw==
X-Gm-Gg: ASbGncsgXfuyRrYte8Se9g0HydOFZxDUuo59F30A/ryEGOzb8570sC21yH6i6miEsty
 bQrqYgvCBK3tpZIY6uPRJtPeDdJn2DKUw9/Vu755hwHDhn8amAzxdLZm5pcERo4wyLlzx9Gq9DQ
 vsuqnxdik6BfIW4Q47Gri72OW/ntc2Cj0HKtRgniQ2Wq1idbJay+EDogmN4r6qhqWERndpmkPDe
 tkgpkwN+h16y/iLiMHAfNkAtUFpNYskpu0FibTgk83f6RgicJC21kQtRzUce3ljCfRjkTs/RsK+
 HP0zPciGAGbmRMhuEX+ZCZeOIgOL9uDhkoTWMiHo2KqnGU5Zp/hLlIeg/7MokDwD
X-Google-Smtp-Source: AGHT+IFXa24WJ6aN9fD27MA9x6YKzuswZlcWi/kdBTZfYIYgVA2bvku04mxh+VHZWfVIegzF2+7dFw==
X-Received: by 2002:a17:90b:2547:b0:313:d6ce:6c6e with SMTP id
 98e67ed59e1d1-31a90b26982mr1914871a91.8.1751424159119; 
 Tue, 01 Jul 2025 19:42:39 -0700 (PDT)
Received: from gmail.com ([121.37.54.139]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-315f539e69fsm18171096a91.11.2025.07.01.19.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 19:42:38 -0700 (PDT)
From: Zhangfei Gao <zhangfei.gao@linaro.org>
To: Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Ashish Gupta <ashish.gupta@marvell.com>
Cc: dev@dpdk.org,
	Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v4 1/2] compress/uadk: use async mode to replace sync mode
Date: Wed,  2 Jul 2025 02:42:15 +0000
Message-Id: <20250702024216.49587-2-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250702024216.49587-1-zhangfei.gao@linaro.org>
References: <20250702024216.49587-1-zhangfei.gao@linaro.org>
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
 doc/guides/compressdevs/uadk.rst              | 15 +++
 drivers/compress/uadk/meson.build             |  4 +-
 drivers/compress/uadk/uadk_compress_pmd.c     | 94 ++++++++++++++-----
 .../compress/uadk/uadk_compress_pmd_private.h |  2 +-
 4 files changed, 86 insertions(+), 29 deletions(-)

diff --git a/doc/guides/compressdevs/uadk.rst b/doc/guides/compressdevs/uadk.rst
index a29043e0c0..8812fd180a 100644
--- a/doc/guides/compressdevs/uadk.rst
+++ b/doc/guides/compressdevs/uadk.rst
@@ -96,3 +96,18 @@ Test steps
 	sudo dpdk-test --vdev=compress_uadk
 	RTE>>compressdev_autotest
 	RTE>>quit
+
+
+As a reference, the following table shows a mapping between the past DPDK versions
+and the UADK library version supported by them:
+
+.. _table_uadk_compress_pmd_versions:
+
+.. table:: DPDK and external UADK library version compatibility
+
+   ==============  ============================
+   DPDK version    UADK library version
+   ==============  ============================
+   24.07 - 25.03   2.4  - 2.8
+   25.07+          2.9.1
+   ==============  ============================
diff --git a/drivers/compress/uadk/meson.build b/drivers/compress/uadk/meson.build
index 34113cd08c..100fb2fc19 100644
--- a/drivers/compress/uadk/meson.build
+++ b/drivers/compress/uadk/meson.build
@@ -13,7 +13,7 @@ sources = files(
 )
 
 deps += 'bus_vdev'
-dep = dependency('libwd_comp', required: false, method: 'pkg-config')
+dep = dependency('libwd_comp', version: '>=2.9', required: false, method: 'pkg-config')
 if not dep.found()
     build = false
     reason = 'missing dependency, "libwd_comp"'
@@ -21,7 +21,7 @@ else
     ext_deps += dep
 endif
 
-dep = dependency('libwd', required: false, method: 'pkg-config')
+dep = dependency('libwd', version: '>=2.9', required: false, method: 'pkg-config')
 if not dep.found()
     build = false
     reason = 'missing dependency, "libwd"'
diff --git a/drivers/compress/uadk/uadk_compress_pmd.c b/drivers/compress/uadk/uadk_compress_pmd.c
index 1f4c4cfd00..0d5cd21bec 100644
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
@@ -29,15 +32,35 @@ uadk_compress_pmd_config(struct rte_compressdev *dev,
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
 	}
 
+	cparams.op_type_num = WD_DIR_MAX;
+	cparams.ctx_set_num = ctx_set_num;
+
+	for (int i = 0; i < WD_DIR_MAX; i++)
+		ctx_set_num[i].async_ctx_num = UADK_COMP_DEF_CTXS;
+
+	ret = wd_comp_init2_(alg_name, SCHED_POLICY_RR, TASK_MIX, &cparams);
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
 }
 
@@ -57,9 +80,9 @@ uadk_compress_pmd_close(struct rte_compressdev *dev)
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
@@ -291,9 +314,25 @@ static struct rte_compressdev_ops uadk_compress_pmd_ops = {
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
@@ -318,21 +357,15 @@ uadk_compress_pmd_enqueue_burst_sync(void *queue_pair,
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
@@ -361,18 +394,27 @@ uadk_compress_pmd_enqueue_burst_sync(void *queue_pair,
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
@@ -386,7 +428,7 @@ uadk_compress_probe(struct rte_vdev_device *vdev)
 	struct uacce_dev *udev;
 	const char *name;
 
-	udev = wd_get_accel_dev("deflate");
+	udev = wd_get_accel_dev(alg_name);
 	if (!udev)
 		return -ENODEV;
 
@@ -402,8 +444,8 @@ uadk_compress_probe(struct rte_vdev_device *vdev)
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

