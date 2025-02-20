Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA40C021B1
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 16:58:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9316F40674;
	Thu, 20 Feb 2025 17:57:16 +0100 (CET)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id EADCE4065C
 for <dev@dpdk.org>; Thu, 20 Feb 2025 17:57:11 +0100 (CET)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-220c92c857aso21692885ad.0
 for <dev@dpdk.org>; Thu, 20 Feb 2025 08:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740070631;
 x=1740675431; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8mpDKJKwREZw1mB7Bxj5JCDYw4Ai0XXytBpKAwfNb8c=;
 b=E/rQT4MHgBnbWM60IKIaAVaVQzbhhqMk8xsBERQzrFZ85obJfoHo+NVzMaTugJMiN8
 IYvcVWgYyAFrM8PR7587+ELbUToJwlblnlwxIRxSFm13Lb3EWhZkY5jTdAWppXCbaYUQ
 h3RuCP6DDi4+PnImb5bOcf3ZLJlKNNCYYiB+axNqCFyiInEFneZ9pPHNSSi3Xo7rekQl
 lxAGG+Ku4LfXqT1glUhv802Xof2qnja1mfIb4OA3Le7f1XPOm7oQ31sQXF8HWyfraqud
 hkJusWvxGsgWNu/bfvpXTpo7seOIgwwnKYbk/saumKV1AHM39OlFnLk+F44pgN98oi3G
 UAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740070631; x=1740675431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8mpDKJKwREZw1mB7Bxj5JCDYw4Ai0XXytBpKAwfNb8c=;
 b=azTzGqVbDaEmXmMj9TQXJSokrhfCPNbIqOATzyCbHR30wzH8DHtKN7ctpMMmiO8UuY
 UM6fOtscOjWSwW2aU+ZPVe8TxmwwjE9UZvO7IMZsLNToZrOGQ5aK0PJTHiCN/yWWikYc
 c/GgwaNn6YdmHEXE94prTqA9g2EBLVHyCoM5Y9REh+vz0HA17UtnHRoQPXJYqwrDAxza
 WAprs5zLVqFsLPDjTVmGqPXHMy1OX0bIvC4cdKhGZAVFJwiCQhpRnP5Tk3rC8EAmzMd1
 SMKzMwXyyZ0fw+02hUJzTURC2BjZxJWqCWgeHbh6VNKANO9b2Y5sbkG+68uHknAGOTJf
 8vVg==
X-Gm-Message-State: AOJu0YzDQgYlmnZkQwUz2Y8pEGBKBoiuyT+Q7LG2j57b901U8pjIozRL
 5YDhWs3B6qdZ2E5rM8JDxF6QyHRgdFUgng7RFObHuEqWJPt2l+vVmE55eQVm1P0RQJlqanWjdPn
 1
X-Gm-Gg: ASbGncuc21UStWGvnNzM1ZFwLGF/PYqoQ0amZUpx9MqUIZXebF2GLafftond4KMjtVl
 t/i0uaEaGMtwYsVdlrLL8xfmTJdlCjq++Dud6ecdyiPUD9vkCMox7TN4HDxbtDhFQlxWUTHQqBS
 9ssizavl9vEL+kRWezLBeQwT4L3cEcMcIp96dAK78sLFDy4QeWCNmY8Vwu9BQnMGWjSBamzCZ6I
 ok2Vojjjpiw/FN2E6Z0r04nUhRWOL2mW4P95KFx4Wp9fZxy/yUXed+Tm6JIyAdyFCm0LulzLZAs
 2oYeKpG9g1Wnmd9OXTbhGs86IHUkmH4/i2qSXt/8761baQ2T+BIHSLGBFEd5bCTlDwj4
X-Google-Smtp-Source: AGHT+IHnxFUnzk6S+FjZ9PcYBqgUryzIaij5aZtur7Q56nRQ5ubB2N/UhDCyJbvDW1D9mW04srBdMg==
X-Received: by 2002:a17:902:eccb:b0:220:ff82:1c60 with SMTP id
 d9443c01a7336-2218c3f4367mr69216335ad.14.1740070631041; 
 Thu, 20 Feb 2025 08:57:11 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d53491b3sm122729435ad.40.2025.02.20.08.57.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:57:10 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Fan Zhang <fanzhang.oss@gmail.com>, Ashish Gupta <ashish.gupta@marvell.com>
Subject: [PATCH v3 09/14] compressdev: remove unnecessary deref of function
 pointers
Date: Thu, 20 Feb 2025 08:55:23 -0800
Message-ID: <20250220165644.16421-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250220165644.16421-1-stephen@networkplumber.org>
References: <20250217185743.169778-1-stephen@networkplumber.org>
 <20250220165644.16421-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Acked-by: Morten Brørup <mb@smartsharesystems.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
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

