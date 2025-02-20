Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED383C021AA
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 02:36:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 345554067E;
	Thu, 20 Feb 2025 03:35:44 +0100 (CET)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 1F2F440647
 for <dev@dpdk.org>; Thu, 20 Feb 2025 03:35:33 +0100 (CET)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-220bff984a0so7318585ad.3
 for <dev@dpdk.org>; Wed, 19 Feb 2025 18:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740018932;
 x=1740623732; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7zkbE8wL4VFuETNbjAMqpcGLRhJxgUoOTgGqh2F5/TY=;
 b=o9n8ADSV4oa2RGu+WgnObkEmdokzsoksX9gobP+2pDkk8Ku8S0W15g57qE+Qqxo069
 yjccqMuC1tlUI1yUw5kfZg01KnjDnySTglRwfawGP6tOB6REM6rI3oahZZnrSHStCE3/
 3WhiQk63Mzyyagaq9iW5rbPjSAKb+8EBYGwuCGO4DnP+I+kS99i2LCGR7M+v/z1WvuRW
 6/RbLVhNO9kyXzon4r4IgbNM2VFqc1m0IPp0VU+7XbdoG7tifl3vBhWVUukILie1/CW9
 dbcOaLZHzBCfeSwZNf5zw+qrQVjZ0xr95lQjgfBLPh7oN+HYjjA/O++5Aq+49p8p3nkG
 TFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740018932; x=1740623732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7zkbE8wL4VFuETNbjAMqpcGLRhJxgUoOTgGqh2F5/TY=;
 b=n6DjcsH6E2qURif6OsBg9KjzErfPNV1POFoUtpHnjq2gNEsmMjU+p7hSRcLExqiYW9
 knwIwlQmfRkToA6PXt9lgKh2JkRnVUEqntxqRJU/u9u2kpR/Q2rhQjsPFeoAwqXHOwPi
 ssi6i/935t+/luBgUXrlcEcyJxmBW+gy6rg+KovIsfjsy54wcfH2gsifxQP6qF2dJutQ
 nKJAez1BHXPc9NxPWG+AWzf3uXkn/cgvgThkpaKJO4nPDv8P4819BDlwxF4KXIQHsraj
 g/vWBmWvZYo5DlT6sVtnk5IKFbHMRHS68h7zn65PuqOxPV914cqeA2LOthc/UALhkdHt
 iXwg==
X-Gm-Message-State: AOJu0Yxce9vYkj08Fk4keSzBznjrJMu5lG6GWyHLabXPyvAv3zQf+ukM
 JhU5YlkEAEHJEK2lEpUVh/Mf+kT2GansT5oUsBVGcRg2Dd72qA+6D6lsRFU031r0+48pVXqTLh/
 ztfc=
X-Gm-Gg: ASbGncv3QOGxwYokyhVMky7kxdkrXtiFjQMV0jS41vuBVJ/H/5mMbuiMggfgaZYU/Y4
 WrG2wCNB7+PSM3MeWmiSdCINMUzqVI1zlouBXDCQ5IZsnnOp30xCqEIHXCcG5YHvphi0AzX9TOb
 +NgBBIB4utEelmv2jwcVgrknD7//cF0T2HPHFiez16bKiK2YdQaVFTuiLbzdsnOrnSHt3e5/7EM
 7dxNMy1r5eLwR22XYA6J5qeR148V3BcBb1rZK7jgm8j60eei3Gjcp7sBXgxgcp/7ICnqWfWyiES
 onA8HFY36+PMUswavzzxoFysZTMpqeFSqKZVug5bYZDSGoz9njpxYoeGx1EbcSrT2Tsp
X-Google-Smtp-Source: AGHT+IEGIFe+iRfmgE/MxkYKX2RCD8KTGS1NgqrXc9exqtqZ8+rwhB5LhyFbeYv8+eK6OyepGzzPhw==
X-Received: by 2002:a17:902:e803:b0:216:1543:196c with SMTP id
 d9443c01a7336-221040620b2mr320044485ad.27.1740018932315; 
 Wed, 19 Feb 2025 18:35:32 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d53490b6sm111668345ad.16.2025.02.19.18.35.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 18:35:31 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Srikanth Yalavarthi <syalavarthi@marvell.com>
Subject: [PATCH v2 12/14] mldev: remove unnecessary deref of function pointers
Date: Wed, 19 Feb 2025 18:32:16 -0800
Message-ID: <20250220023509.630569-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250220023509.630569-1-stephen@networkplumber.org>
References: <20250217185743.169778-1-stephen@networkplumber.org>
 <20250220023509.630569-1-stephen@networkplumber.org>
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

The expression *dev->dev_ops->dev_info_get and
dev->dev_ops->dev_info_get are equivalent in C.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/mldev/rte_mldev.c | 88 +++++++++++++++++++++----------------------
 1 file changed, 44 insertions(+), 44 deletions(-)

diff --git a/lib/mldev/rte_mldev.c b/lib/mldev/rte_mldev.c
index 37d71aebc9..e0e5b8d9e8 100644
--- a/lib/mldev/rte_mldev.c
+++ b/lib/mldev/rte_mldev.c
@@ -237,7 +237,7 @@ rte_ml_dev_info_get(int16_t dev_id, struct rte_ml_dev_info *dev_info)
 	}
 
 	dev = rte_ml_dev_pmd_get_dev(dev_id);
-	if (*dev->dev_ops->dev_info_get == NULL)
+	if (dev->dev_ops->dev_info_get == NULL)
 		return -ENOTSUP;
 
 	if (dev_info == NULL) {
@@ -246,7 +246,7 @@ rte_ml_dev_info_get(int16_t dev_id, struct rte_ml_dev_info *dev_info)
 	}
 	memset(dev_info, 0, sizeof(struct rte_ml_dev_info));
 
-	return (*dev->dev_ops->dev_info_get)(dev, dev_info);
+	return dev->dev_ops->dev_info_get(dev, dev_info);
 }
 
 int
@@ -262,7 +262,7 @@ rte_ml_dev_configure(int16_t dev_id, const struct rte_ml_dev_config *config)
 	}
 
 	dev = rte_ml_dev_pmd_get_dev(dev_id);
-	if (*dev->dev_ops->dev_configure == NULL)
+	if (dev->dev_ops->dev_configure == NULL)
 		return -ENOTSUP;
 
 	if (dev->data->dev_started) {
@@ -285,7 +285,7 @@ rte_ml_dev_configure(int16_t dev_id, const struct rte_ml_dev_config *config)
 		return -EINVAL;
 	}
 
-	return (*dev->dev_ops->dev_configure)(dev, config);
+	return dev->dev_ops->dev_configure(dev, config);
 }
 
 int
@@ -299,7 +299,7 @@ rte_ml_dev_close(int16_t dev_id)
 	}
 
 	dev = rte_ml_dev_pmd_get_dev(dev_id);
-	if (*dev->dev_ops->dev_close == NULL)
+	if (dev->dev_ops->dev_close == NULL)
 		return -ENOTSUP;
 
 	/* Device must be stopped before it can be closed */
@@ -308,7 +308,7 @@ rte_ml_dev_close(int16_t dev_id)
 		return -EBUSY;
 	}
 
-	return (*dev->dev_ops->dev_close)(dev);
+	return dev->dev_ops->dev_close(dev);
 }
 
 int
@@ -323,7 +323,7 @@ rte_ml_dev_start(int16_t dev_id)
 	}
 
 	dev = rte_ml_dev_pmd_get_dev(dev_id);
-	if (*dev->dev_ops->dev_start == NULL)
+	if (dev->dev_ops->dev_start == NULL)
 		return -ENOTSUP;
 
 	if (dev->data->dev_started != 0) {
@@ -331,7 +331,7 @@ rte_ml_dev_start(int16_t dev_id)
 		return -EBUSY;
 	}
 
-	ret = (*dev->dev_ops->dev_start)(dev);
+	ret = dev->dev_ops->dev_start(dev);
 	if (ret == 0)
 		dev->data->dev_started = 1;
 
@@ -350,7 +350,7 @@ rte_ml_dev_stop(int16_t dev_id)
 	}
 
 	dev = rte_ml_dev_pmd_get_dev(dev_id);
-	if (*dev->dev_ops->dev_stop == NULL)
+	if (dev->dev_ops->dev_stop == NULL)
 		return -ENOTSUP;
 
 	if (dev->data->dev_started == 0) {
@@ -358,7 +358,7 @@ rte_ml_dev_stop(int16_t dev_id)
 		return -EBUSY;
 	}
 
-	ret = (*dev->dev_ops->dev_stop)(dev);
+	ret = dev->dev_ops->dev_stop(dev);
 	if (ret == 0)
 		dev->data->dev_started = 0;
 
@@ -392,7 +392,7 @@ rte_ml_dev_queue_pair_setup(int16_t dev_id, uint16_t queue_pair_id,
 	}
 
 	dev = rte_ml_dev_pmd_get_dev(dev_id);
-	if (*dev->dev_ops->dev_queue_pair_setup == NULL)
+	if (dev->dev_ops->dev_queue_pair_setup == NULL)
 		return -ENOTSUP;
 
 	if (queue_pair_id >= dev->data->nb_queue_pairs) {
@@ -410,7 +410,7 @@ rte_ml_dev_queue_pair_setup(int16_t dev_id, uint16_t queue_pair_id,
 		return -EBUSY;
 	}
 
-	return (*dev->dev_ops->dev_queue_pair_setup)(dev, queue_pair_id, qp_conf, socket_id);
+	return dev->dev_ops->dev_queue_pair_setup(dev, queue_pair_id, qp_conf, socket_id);
 }
 
 int
@@ -424,7 +424,7 @@ rte_ml_dev_stats_get(int16_t dev_id, struct rte_ml_dev_stats *stats)
 	}
 
 	dev = rte_ml_dev_pmd_get_dev(dev_id);
-	if (*dev->dev_ops->dev_stats_get == NULL)
+	if (dev->dev_ops->dev_stats_get == NULL)
 		return -ENOTSUP;
 
 	if (stats == NULL) {
@@ -433,7 +433,7 @@ rte_ml_dev_stats_get(int16_t dev_id, struct rte_ml_dev_stats *stats)
 	}
 	memset(stats, 0, sizeof(struct rte_ml_dev_stats));
 
-	return (*dev->dev_ops->dev_stats_get)(dev, stats);
+	return dev->dev_ops->dev_stats_get(dev, stats);
 }
 
 void
@@ -447,10 +447,10 @@ rte_ml_dev_stats_reset(int16_t dev_id)
 	}
 
 	dev = rte_ml_dev_pmd_get_dev(dev_id);
-	if (*dev->dev_ops->dev_stats_reset == NULL)
+	if (dev->dev_ops->dev_stats_reset == NULL)
 		return;
 
-	(*dev->dev_ops->dev_stats_reset)(dev);
+	dev->dev_ops->dev_stats_reset(dev);
 }
 
 int
@@ -465,10 +465,10 @@ rte_ml_dev_xstats_names_get(int16_t dev_id, enum rte_ml_dev_xstats_mode mode, in
 	}
 
 	dev = rte_ml_dev_pmd_get_dev(dev_id);
-	if (*dev->dev_ops->dev_xstats_names_get == NULL)
+	if (dev->dev_ops->dev_xstats_names_get == NULL)
 		return -ENOTSUP;
 
-	return (*dev->dev_ops->dev_xstats_names_get)(dev, mode, model_id, xstats_map, size);
+	return dev->dev_ops->dev_xstats_names_get(dev, mode, model_id, xstats_map, size);
 }
 
 int
@@ -482,7 +482,7 @@ rte_ml_dev_xstats_by_name_get(int16_t dev_id, const char *name, uint16_t *stat_i
 	}
 
 	dev = rte_ml_dev_pmd_get_dev(dev_id);
-	if (*dev->dev_ops->dev_xstats_by_name_get == NULL)
+	if (dev->dev_ops->dev_xstats_by_name_get == NULL)
 		return -ENOTSUP;
 
 	if (name == NULL) {
@@ -495,7 +495,7 @@ rte_ml_dev_xstats_by_name_get(int16_t dev_id, const char *name, uint16_t *stat_i
 		return -EINVAL;
 	}
 
-	return (*dev->dev_ops->dev_xstats_by_name_get)(dev, name, stat_id, value);
+	return dev->dev_ops->dev_xstats_by_name_get(dev, name, stat_id, value);
 }
 
 int
@@ -510,7 +510,7 @@ rte_ml_dev_xstats_get(int16_t dev_id, enum rte_ml_dev_xstats_mode mode, int32_t
 	}
 
 	dev = rte_ml_dev_pmd_get_dev(dev_id);
-	if (*dev->dev_ops->dev_xstats_get == NULL)
+	if (dev->dev_ops->dev_xstats_get == NULL)
 		return -ENOTSUP;
 
 	if (stat_ids == NULL) {
@@ -523,7 +523,7 @@ rte_ml_dev_xstats_get(int16_t dev_id, enum rte_ml_dev_xstats_mode mode, int32_t
 		return -EINVAL;
 	}
 
-	return (*dev->dev_ops->dev_xstats_get)(dev, mode, model_id, stat_ids, values, nb_ids);
+	return dev->dev_ops->dev_xstats_get(dev, mode, model_id, stat_ids, values, nb_ids);
 }
 
 int
@@ -538,10 +538,10 @@ rte_ml_dev_xstats_reset(int16_t dev_id, enum rte_ml_dev_xstats_mode mode, int32_
 	}
 
 	dev = rte_ml_dev_pmd_get_dev(dev_id);
-	if (*dev->dev_ops->dev_xstats_reset == NULL)
+	if (dev->dev_ops->dev_xstats_reset == NULL)
 		return -ENOTSUP;
 
-	return (*dev->dev_ops->dev_xstats_reset)(dev, mode, model_id, stat_ids, nb_ids);
+	return dev->dev_ops->dev_xstats_reset(dev, mode, model_id, stat_ids, nb_ids);
 }
 
 int
@@ -555,7 +555,7 @@ rte_ml_dev_dump(int16_t dev_id, FILE *fd)
 	}
 
 	dev = rte_ml_dev_pmd_get_dev(dev_id);
-	if (*dev->dev_ops->dev_dump == NULL)
+	if (dev->dev_ops->dev_dump == NULL)
 		return -ENOTSUP;
 
 	if (fd == NULL) {
@@ -563,7 +563,7 @@ rte_ml_dev_dump(int16_t dev_id, FILE *fd)
 		return -EINVAL;
 	}
 
-	return (*dev->dev_ops->dev_dump)(dev, fd);
+	return dev->dev_ops->dev_dump(dev, fd);
 }
 
 int
@@ -577,10 +577,10 @@ rte_ml_dev_selftest(int16_t dev_id)
 	}
 
 	dev = rte_ml_dev_pmd_get_dev(dev_id);
-	if (*dev->dev_ops->dev_selftest == NULL)
+	if (dev->dev_ops->dev_selftest == NULL)
 		return -ENOTSUP;
 
-	return (*dev->dev_ops->dev_selftest)(dev);
+	return dev->dev_ops->dev_selftest(dev);
 }
 
 int
@@ -594,7 +594,7 @@ rte_ml_model_load(int16_t dev_id, struct rte_ml_model_params *params, uint16_t *
 	}
 
 	dev = rte_ml_dev_pmd_get_dev(dev_id);
-	if (*dev->dev_ops->model_load == NULL)
+	if (dev->dev_ops->model_load == NULL)
 		return -ENOTSUP;
 
 	if (params == NULL) {
@@ -607,7 +607,7 @@ rte_ml_model_load(int16_t dev_id, struct rte_ml_model_params *params, uint16_t *
 		return -EINVAL;
 	}
 
-	return (*dev->dev_ops->model_load)(dev, params, model_id);
+	return dev->dev_ops->model_load(dev, params, model_id);
 }
 
 int
@@ -621,10 +621,10 @@ rte_ml_model_unload(int16_t dev_id, uint16_t model_id)
 	}
 
 	dev = rte_ml_dev_pmd_get_dev(dev_id);
-	if (*dev->dev_ops->model_unload == NULL)
+	if (dev->dev_ops->model_unload == NULL)
 		return -ENOTSUP;
 
-	return (*dev->dev_ops->model_unload)(dev, model_id);
+	return dev->dev_ops->model_unload(dev, model_id);
 }
 
 int
@@ -638,10 +638,10 @@ rte_ml_model_start(int16_t dev_id, uint16_t model_id)
 	}
 
 	dev = rte_ml_dev_pmd_get_dev(dev_id);
-	if (*dev->dev_ops->model_start == NULL)
+	if (dev->dev_ops->model_start == NULL)
 		return -ENOTSUP;
 
-	return (*dev->dev_ops->model_start)(dev, model_id);
+	return dev->dev_ops->model_start(dev, model_id);
 }
 
 int
@@ -655,10 +655,10 @@ rte_ml_model_stop(int16_t dev_id, uint16_t model_id)
 	}
 
 	dev = rte_ml_dev_pmd_get_dev(dev_id);
-	if (*dev->dev_ops->model_stop == NULL)
+	if (dev->dev_ops->model_stop == NULL)
 		return -ENOTSUP;
 
-	return (*dev->dev_ops->model_stop)(dev, model_id);
+	return dev->dev_ops->model_stop(dev, model_id);
 }
 
 int
@@ -672,7 +672,7 @@ rte_ml_model_info_get(int16_t dev_id, uint16_t model_id, struct rte_ml_model_inf
 	}
 
 	dev = rte_ml_dev_pmd_get_dev(dev_id);
-	if (*dev->dev_ops->model_info_get == NULL)
+	if (dev->dev_ops->model_info_get == NULL)
 		return -ENOTSUP;
 
 	if (model_info == NULL) {
@@ -681,7 +681,7 @@ rte_ml_model_info_get(int16_t dev_id, uint16_t model_id, struct rte_ml_model_inf
 		return -EINVAL;
 	}
 
-	return (*dev->dev_ops->model_info_get)(dev, model_id, model_info);
+	return dev->dev_ops->model_info_get(dev, model_id, model_info);
 }
 
 int
@@ -695,7 +695,7 @@ rte_ml_model_params_update(int16_t dev_id, uint16_t model_id, void *buffer)
 	}
 
 	dev = rte_ml_dev_pmd_get_dev(dev_id);
-	if (*dev->dev_ops->model_params_update == NULL)
+	if (dev->dev_ops->model_params_update == NULL)
 		return -ENOTSUP;
 
 	if (buffer == NULL) {
@@ -703,7 +703,7 @@ rte_ml_model_params_update(int16_t dev_id, uint16_t model_id, void *buffer)
 		return -EINVAL;
 	}
 
-	return (*dev->dev_ops->model_params_update)(dev, model_id, buffer);
+	return dev->dev_ops->model_params_update(dev, model_id, buffer);
 }
 
 int
@@ -718,7 +718,7 @@ rte_ml_io_quantize(int16_t dev_id, uint16_t model_id, struct rte_ml_buff_seg **d
 	}
 
 	dev = rte_ml_dev_pmd_get_dev(dev_id);
-	if (*dev->dev_ops->io_quantize == NULL)
+	if (dev->dev_ops->io_quantize == NULL)
 		return -ENOTSUP;
 
 	if (dbuffer == NULL) {
@@ -731,7 +731,7 @@ rte_ml_io_quantize(int16_t dev_id, uint16_t model_id, struct rte_ml_buff_seg **d
 		return -EINVAL;
 	}
 
-	return (*dev->dev_ops->io_quantize)(dev, model_id, dbuffer, qbuffer);
+	return dev->dev_ops->io_quantize(dev, model_id, dbuffer, qbuffer);
 }
 
 int
@@ -746,7 +746,7 @@ rte_ml_io_dequantize(int16_t dev_id, uint16_t model_id, struct rte_ml_buff_seg *
 	}
 
 	dev = rte_ml_dev_pmd_get_dev(dev_id);
-	if (*dev->dev_ops->io_dequantize == NULL)
+	if (dev->dev_ops->io_dequantize == NULL)
 		return -ENOTSUP;
 
 	if (qbuffer == NULL) {
@@ -759,7 +759,7 @@ rte_ml_io_dequantize(int16_t dev_id, uint16_t model_id, struct rte_ml_buff_seg *
 		return -EINVAL;
 	}
 
-	return (*dev->dev_ops->io_dequantize)(dev, model_id, qbuffer, dbuffer);
+	return dev->dev_ops->io_dequantize(dev, model_id, qbuffer, dbuffer);
 }
 
 /** Initialise rte_ml_op mempool element */
-- 
2.47.2

