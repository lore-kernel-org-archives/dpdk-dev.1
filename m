Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97978C021A9
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Feb 2025 18:58:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3072C40653;
	Mon, 17 Feb 2025 19:58:05 +0100 (CET)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 78E734042F
 for <dev@dpdk.org>; Mon, 17 Feb 2025 19:58:00 +0100 (CET)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-220e83d65e5so69444635ad.1
 for <dev@dpdk.org>; Mon, 17 Feb 2025 10:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739818680;
 x=1740423480; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NKF/uEbxOyRaV8cHNMiprNcICe8xejq4bqzXCu4xLg4=;
 b=0+Y6JW1qWOJ7kaF5lvqrJ2OgSOuGYctZysQToImFGdL1/jeWyi11THdCumiQqmRuR+
 D+CRG45IBpJ7/SHxOOsZAxzxOEjJ2rGnJHw2FzvhBBaCp2q3dWemj6pcMbQ/6yyxrp7s
 SnLreoffzr+imAdlVUSky2U1VfQlp2oZMTypqApO/WioH5K5ZMWSqarkMJEMWBRAd44R
 p0wTVzUu2PpGsrGIV3U57YuRAdJRvwwe62M1WYKz8GrEq//Bklqr1jA1jZJhpV/EUXtn
 6Nqc66Hp2jHIu7NdedatPpBgy69k9/c3U6ZsP8MbD+Zjc3mMuErQq3h+O+jTy+Bh4H4B
 xiEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739818680; x=1740423480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NKF/uEbxOyRaV8cHNMiprNcICe8xejq4bqzXCu4xLg4=;
 b=sZRAxaUnPR+qLqjjzzeomOssMyGeVPoRCAdCWJpqcBIlHBITsCP4MJ+CM7atcrAgDH
 DEJy8Lw7bNr0jzZRzIgOpwBXg/+Khx2QwTUYFEnHqh5OcD1ulgrjXebCE5WQYV1OQDkE
 +M5VdT7uXBDxGCsBW8w6s3cympdl4x71Z8dOdAcPBDCkbuIZF09/BaLPPiUgF3K+828v
 cvfIjqE8z5439tq5+ExKXu2lWxPqvVQPeeggSrp8D3SOLe7r3rCS+p1ITQgIBazbN0tF
 pYxe3ef2Gly1ZwzMQniZg1z5WoZ0DZeSKn/VTtykfAsrDL0IDTbIXkMDt8wkfHkadkIj
 tupA==
X-Gm-Message-State: AOJu0YxbtSMTIsTBGTswCm/J+ooubHlfh6OttPF7WlilVggHIF/rZIKR
 gUBc5IHFNlz1qXQXltB+7xZWTl2OoKg6uFhHykACRQGR/BkCtcLF/Zt57tUX7qEM6+ZJSRKuEuD
 8mhE=
X-Gm-Gg: ASbGncvAzywQTSlMr1vO5X0ZfCxAYZuGLk0eUXQmsL45YUKF51eu9sTn1GzFtFY+XAY
 ecg8vocDIFL4NCFYCoxXdbGz4xtoOjnPfrmmp0bbtxtgir6VXEXt+C4xLbZZj4c6mIUPN70d6+G
 2Z8pQudxta04McXHThcBauYJNcIiASFcf+A0yGlh33Y5huwn4Fb5uhwPlYgGMKWfR+wKmpSQd7f
 x3GATk3sZm9JQcdy5DHK0DQVENWGoKp0AMwrzAJI3A2mpu0KhxX+Z4TI8XCOwr/tGd//Om0l0sQ
 YYl8zneZ3Auh+gV6bXRa3iUjOx5MA9Waax4EiriqWbXKnzN9wQ4Wgdh1TLk8ZEoIUNDu
X-Google-Smtp-Source: AGHT+IHedpBB0DON0utdyFpoFgkgqqyebT0g6Pg1Oe/oGWizbTfNNz6xdMEPjxDqZbkJwHeGQ/49vQ==
X-Received: by 2002:a17:902:e843:b0:220:f869:1e6e with SMTP id
 d9443c01a7336-221040ac24dmr176114235ad.38.1739818679591; 
 Mon, 17 Feb 2025 10:57:59 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adb57c5dc68sm7815149a12.9.2025.02.17.10.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 10:57:59 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 07/11] compressdev: remove unnecessary deref of function pointers
Date: Mon, 17 Feb 2025 10:54:06 -0800
Message-ID: <20250217185743.169778-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250217185743.169778-1-stephen@networkplumber.org>
References: <20250217185743.169778-1-stephen@networkplumber.org>
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

The expression *dev->dev_ops->dev_info_gets and dev->dev_ops->info_get
are equivalent.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/compressdev/rte_compressdev.c | 56 +++++++++++++++----------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/lib/compressdev/rte_compressdev.c b/lib/compressdev/rte_compressdev.c
index cf2c20a704..1fc4661ef0 100644
--- a/lib/compressdev/rte_compressdev.c
+++ b/lib/compressdev/rte_compressdev.c
@@ -316,9 +316,9 @@ rte_compressdev_queue_pairs_config(struct rte_compressdev *dev,
 
 	memset(&dev_info, 0, sizeof(struct rte_compressdev_info));
 
-	if (*dev->dev_ops->dev_infos_get == NULL)
+	if (dev->dev_ops->dev_infos_get == NULL)
 		return -ENOTSUP;
-	(*dev->dev_ops->dev_infos_get)(dev, &dev_info);
+	dev->dev_ops->dev_infos_get(dev, &dev_info);
 
 	if ((dev_info.max_nb_queue_pairs != 0) &&
 			(nb_qpairs > dev_info.max_nb_queue_pairs)) {
@@ -346,11 +346,11 @@ rte_compressdev_queue_pairs_config(struct rte_compressdev *dev,
 
 		qp = dev->data->queue_pairs;
 
-		if (*dev->dev_ops->queue_pair_release == NULL)
+		if (dev->dev_ops->queue_pair_release == NULL)
 			return -ENOTSUP;
 
 		for (i = nb_qpairs; i < old_nb_queues; i++) {
-			ret = (*dev->dev_ops->queue_pair_release)(dev, i);
+			ret = dev->dev_ops->queue_pair_release(dev, i);
 			if (ret < 0)
 				return ret;
 		}
@@ -397,11 +397,11 @@ rte_compressdev_queue_pairs_release(struct rte_compressdev *dev)
 	COMPRESSDEV_LOG(DEBUG, "Free %d queues pairs on device %u",
 			dev->data->nb_queue_pairs, dev->data->dev_id);
 
-	if (*dev->dev_ops->queue_pair_release == NULL)
+	if (dev->dev_ops->queue_pair_release == NULL)
 		return -ENOTSUP;
 
 	for (i = 0; i < num_qps; i++) {
-		ret = (*dev->dev_ops->queue_pair_release)(dev, i);
+		ret = dev->dev_ops->queue_pair_release(dev, i);
 		if (ret < 0)
 			return ret;
 	}
@@ -432,7 +432,7 @@ rte_compressdev_configure(uint8_t dev_id, struct rte_compressdev_config *config)
 		return -EBUSY;
 	}
 
-	if (*dev->dev_ops->dev_configure == NULL)
+	if (dev->dev_ops->dev_configure == NULL)
 		return -ENOTSUP;
 
 	/* Setup new number of queue pairs and reconfigure device. */
@@ -445,7 +445,7 @@ rte_compressdev_configure(uint8_t dev_id, struct rte_compressdev_config *config)
 		return diag;
 	}
 
-	return (*dev->dev_ops->dev_configure)(dev, config);
+	return dev->dev_ops->dev_configure(dev, config);
 }
 
 int
@@ -463,7 +463,7 @@ rte_compressdev_start(uint8_t dev_id)
 
 	dev = &rte_comp_devices[dev_id];
 
-	if (*dev->dev_ops->dev_start == NULL)
+	if (dev->dev_ops->dev_start == NULL)
 		return -ENOTSUP;
 
 	if (dev->data->dev_started != 0) {
@@ -472,7 +472,7 @@ rte_compressdev_start(uint8_t dev_id)
 		return 0;
 	}
 
-	diag = (*dev->dev_ops->dev_start)(dev);
+	diag = dev->dev_ops->dev_start(dev);
 	if (diag == 0)
 		dev->data->dev_started = 1;
 	else
@@ -493,7 +493,7 @@ rte_compressdev_stop(uint8_t dev_id)
 
 	dev = &rte_comp_devices[dev_id];
 
-	if (*dev->dev_ops->dev_stop == NULL)
+	if (dev->dev_ops->dev_stop == NULL)
 		return;
 
 	if (dev->data->dev_started == 0) {
@@ -502,7 +502,7 @@ rte_compressdev_stop(uint8_t dev_id)
 		return;
 	}
 
-	(*dev->dev_ops->dev_stop)(dev);
+	dev->dev_ops->dev_stop(dev);
 	dev->data->dev_started = 0;
 }
 
@@ -532,9 +532,9 @@ rte_compressdev_close(uint8_t dev_id)
 	if (retval < 0)
 		return retval;
 
-	if (*dev->dev_ops->dev_close == NULL)
+	if (dev->dev_ops->dev_close == NULL)
 		return -ENOTSUP;
-	retval = (*dev->dev_ops->dev_close)(dev);
+	retval = dev->dev_ops->dev_close(dev);
 
 	if (retval < 0)
 		return retval;
@@ -571,10 +571,10 @@ rte_compressdev_queue_pair_setup(uint8_t dev_id, uint16_t queue_pair_id,
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->queue_pair_setup == NULL)
+	if (dev->dev_ops->queue_pair_setup == NULL)
 		return -ENOTSUP;
 
-	return (*dev->dev_ops->queue_pair_setup)(dev, queue_pair_id,
+	return dev->dev_ops->queue_pair_setup(dev, queue_pair_id,
 			max_inflight_ops, socket_id);
 }
 
@@ -618,9 +618,9 @@ rte_compressdev_stats_get(uint8_t dev_id, struct rte_compressdev_stats *stats)
 	dev = &rte_comp_devices[dev_id];
 	memset(stats, 0, sizeof(*stats));
 
-	if (*dev->dev_ops->stats_get == NULL)
+	if (dev->dev_ops->stats_get == NULL)
 		return -ENOTSUP;
-	(*dev->dev_ops->stats_get)(dev, stats);
+	dev->dev_ops->stats_get(dev, stats);
 	return 0;
 }
 
@@ -636,9 +636,9 @@ rte_compressdev_stats_reset(uint8_t dev_id)
 
 	dev = &rte_comp_devices[dev_id];
 
-	if (*dev->dev_ops->stats_reset == NULL)
+	if (dev->dev_ops->stats_reset == NULL)
 		return;
-	(*dev->dev_ops->stats_reset)(dev);
+	dev->dev_ops->stats_reset(dev);
 }
 
 
@@ -656,9 +656,9 @@ rte_compressdev_info_get(uint8_t dev_id, struct rte_compressdev_info *dev_info)
 
 	memset(dev_info, 0, sizeof(struct rte_compressdev_info));
 
-	if (*dev->dev_ops->dev_infos_get == NULL)
+	if (dev->dev_ops->dev_infos_get == NULL)
 		return;
-	(*dev->dev_ops->dev_infos_get)(dev, dev_info);
+	dev->dev_ops->dev_infos_get(dev, dev_info);
 
 	dev_info->driver_name = dev->device->driver->name;
 }
@@ -676,9 +676,9 @@ rte_compressdev_private_xform_create(uint8_t dev_id,
 	if (xform == NULL || priv_xform == NULL || dev == NULL)
 		return -EINVAL;
 
-	if (*dev->dev_ops->private_xform_create == NULL)
+	if (dev->dev_ops->private_xform_create == NULL)
 		return -ENOTSUP;
-	ret = (*dev->dev_ops->private_xform_create)(dev, xform, priv_xform);
+	ret = dev->dev_ops->private_xform_create(dev, xform, priv_xform);
 	if (ret < 0) {
 		COMPRESSDEV_LOG(ERR,
 			"dev_id %d failed to create private_xform: err=%d",
@@ -700,7 +700,7 @@ rte_compressdev_private_xform_free(uint8_t dev_id, void *priv_xform)
 	if (dev == NULL || priv_xform == NULL)
 		return -EINVAL;
 
-	if (*dev->dev_ops->private_xform_free == NULL)
+	if (dev->dev_ops->private_xform_free == NULL)
 		return -ENOTSUP;
 	ret = dev->dev_ops->private_xform_free(dev, priv_xform);
 	if (ret < 0) {
@@ -726,9 +726,9 @@ rte_compressdev_stream_create(uint8_t dev_id,
 	if (xform == NULL || dev == NULL || stream == NULL)
 		return -EINVAL;
 
-	if (*dev->dev_ops->stream_create == NULL)
+	if (dev->dev_ops->stream_create == NULL)
 		return -ENOTSUP;
-	ret = (*dev->dev_ops->stream_create)(dev, xform, stream);
+	ret = dev->dev_ops->stream_create(dev, xform, stream);
 	if (ret < 0) {
 		COMPRESSDEV_LOG(ERR,
 			"dev_id %d failed to create stream: err=%d",
@@ -751,7 +751,7 @@ rte_compressdev_stream_free(uint8_t dev_id, void *stream)
 	if (dev == NULL || stream == NULL)
 		return -EINVAL;
 
-	if (*dev->dev_ops->stream_free == NULL)
+	if (dev->dev_ops->stream_free == NULL)
 		return -ENOTSUP;
 	ret = dev->dev_ops->stream_free(dev, stream);
 	if (ret < 0) {
-- 
2.47.2

