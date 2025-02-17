Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A71C021A9
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Feb 2025 18:58:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6715A4066E;
	Mon, 17 Feb 2025 19:58:07 +0100 (CET)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 0EE68402E4
 for <dev@dpdk.org>; Mon, 17 Feb 2025 19:58:02 +0100 (CET)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-219f8263ae0so82673645ad.0
 for <dev@dpdk.org>; Mon, 17 Feb 2025 10:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739818681;
 x=1740423481; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I+cxE30iDMgKG2myhqcQBfdGul/+jRUsgKmADGpcr1I=;
 b=NQA3Tg5AN+3VpeHh4WcAM5XOlOqgklXOj6kqc73HqG+AesWz71vtmIskLkyoc0Ud/O
 v8fyNg6ZD0Iqf25MiANhtw65k0lsfEaxgRl92cvad3AM0pnIsb3WLfNoe0UtgFVX8Vwj
 +FeKFKCEFQKiRoKRlDAK4IDbMp2mMoUDD5P+H9AW3JabDSFlvQ3PaxTHsGLGXre9rPRO
 bPo8xUcEfUh3ZajUGG04QtFEm8A4j9rEv3R/IF64AmiNViFJSB+b/ijk9B5xbRbjoj7s
 lzOSWieGkztTaEPtcjBQqNOQBb9cKEhHkzw+P1q/hzpeMQs04KeecvGEWrvA/BZXCvaX
 DaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739818681; x=1740423481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I+cxE30iDMgKG2myhqcQBfdGul/+jRUsgKmADGpcr1I=;
 b=eN5wHjzL0N+EHeDcj23yUKrsew+zIzGMZeqWb6Xr0tddGgdhswA8NmcQLfrohkEadr
 M6rryiXmGwmn7JyiklrBUaRCHkW3gYovZMKRSVcSr+R66kBu5T+krFZhtbYnUUoZ6GlS
 HxwBBXMX6iwa6rNhojXZoW528x1nX51ic89Pefr9Vr9pJ+2PERaUq0xK9ZIZmDSbnjex
 J7n0BvQT3tSsyQDPCQusFAPs+sR2SIujW/JnCSfeG2kl0GEnR3riTzS77CKgL1SVEkWO
 Ro4CngNq/WEEOMwcQ7VcZohtV1IlG0/VogQKLeYTP3c16ZRMY8SWlvJ3U9v9zokY8utN
 raOA==
X-Gm-Message-State: AOJu0YxGn7UV3eJeMW9mfN1t2b+MbWYO2AKvzRvEqpxVTeigJe1tUz17
 thVFRve2p8/MBJ7k+Ayu9vB3DZW/RUdbDhDAFG1cR9z3W2cP2KakgcyGHs+GTtXSxG6vU5O/Fwg
 iV2Y=
X-Gm-Gg: ASbGncvorx4+HNb4FkNBpSOEbfZHYpuKFD+OGbflRvYUGgU3m1AgnYzIT5buFrRK4Hg
 ebL2jy0INm1RoCUCudGFXQ10Xg643XoeZ78sc7OqtZwrinV0itgsABGkyyXcP+tFGdPN9szegjx
 7xmQJhxxEJw+9euqjqGWgZByl7vYUNSQytkf9kIbqCz1NqHVFJ4+l/5xVufMqqCXpeAAtCEcRg4
 DIIFH2Y6NCAL2EUjfewaHgbI36Q3z4zQ8ZEKlDoB29xV8WtBV4eQpbbwSxN2wstSqwr4uUjUWOF
 zmWvx+YDLhmNb5IMtc8wGenNKY1Wd7fQS+CiZSqjqmthf6MioiOHCpR0fLkUkMECqwHd
X-Google-Smtp-Source: AGHT+IEG+UG8HcEWeFUpfOkfuP+S9K9nMRwt0hYFC+isXZEpqWoGA2QhHUB/9afNqFW4hesulZcleA==
X-Received: by 2002:a17:902:d542:b0:220:c4e8:3b9f with SMTP id
 d9443c01a7336-22103c6237dmr186126455ad.0.1739818681147; 
 Mon, 17 Feb 2025 10:58:01 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adb57c5dc68sm7815149a12.9.2025.02.17.10.58.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 10:58:00 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 09/11] rawdev: remove unnecessary deref of function pointers
Date: Mon, 17 Feb 2025 10:54:08 -0800
Message-ID: <20250217185743.169778-10-stephen@networkplumber.org>
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

The expression *dev->dev_ops->dev_configure and
dev->dev_ops->dev_configure are equivalent.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/rawdev/rte_rawdev.c | 99 ++++++++++++++++++++---------------------
 1 file changed, 48 insertions(+), 51 deletions(-)

diff --git a/lib/rawdev/rte_rawdev.c b/lib/rawdev/rte_rawdev.c
index 4f8897b639..810e95a440 100644
--- a/lib/rawdev/rte_rawdev.c
+++ b/lib/rawdev/rte_rawdev.c
@@ -77,9 +77,9 @@ rte_rawdev_info_get(uint16_t dev_id, struct rte_rawdev_info *dev_info,
 	rawdev = &rte_rawdevs[dev_id];
 
 	if (dev_info->dev_private != NULL) {
-		if (*rawdev->dev_ops->dev_info_get == NULL)
+		if (rawdev->dev_ops->dev_info_get == NULL)
 			return -ENOTSUP;
-		ret = (*rawdev->dev_ops->dev_info_get)(rawdev,
+		ret = rawdev->dev_ops->dev_info_get(rawdev,
 				dev_info->dev_private,
 				dev_private_size);
 	}
@@ -104,7 +104,7 @@ rte_rawdev_configure(uint16_t dev_id, struct rte_rawdev_info *dev_conf,
 
 	dev = &rte_rawdevs[dev_id];
 
-	if (*dev->dev_ops->dev_configure == NULL)
+	if (dev->dev_ops->dev_configure == NULL)
 		return -ENOTSUP;
 
 	if (dev->started) {
@@ -114,8 +114,7 @@ rte_rawdev_configure(uint16_t dev_id, struct rte_rawdev_info *dev_conf,
 	}
 
 	/* Configure the device */
-	diag = (*dev->dev_ops->dev_configure)(dev, dev_conf->dev_private,
-			dev_private_size);
+	diag = dev->dev_ops->dev_configure(dev, dev_conf->dev_private, dev_private_size);
 	if (diag != 0)
 		RTE_RDEV_ERR("dev%d dev_configure = %d", dev_id, diag);
 	else
@@ -135,10 +134,9 @@ rte_rawdev_queue_conf_get(uint16_t dev_id,
 	RTE_RAWDEV_VALID_DEVID_OR_ERR_RET(dev_id, -EINVAL);
 	dev = &rte_rawdevs[dev_id];
 
-	if (*dev->dev_ops->queue_def_conf == NULL)
+	if (dev->dev_ops->queue_def_conf == NULL)
 		return -ENOTSUP;
-	return (*dev->dev_ops->queue_def_conf)(dev, queue_id, queue_conf,
-			queue_conf_size);
+	return dev->dev_ops->queue_def_conf(dev, queue_id, queue_conf, queue_conf_size);
 }
 
 int
@@ -152,10 +150,9 @@ rte_rawdev_queue_setup(uint16_t dev_id,
 	RTE_RAWDEV_VALID_DEVID_OR_ERR_RET(dev_id, -EINVAL);
 	dev = &rte_rawdevs[dev_id];
 
-	if (*dev->dev_ops->queue_setup == NULL)
+	if (dev->dev_ops->queue_setup == NULL)
 		return -ENOTSUP;
-	return (*dev->dev_ops->queue_setup)(dev, queue_id, queue_conf,
-			queue_conf_size);
+	return dev->dev_ops->queue_setup(dev, queue_id, queue_conf, queue_conf_size);
 }
 
 int
@@ -166,9 +163,9 @@ rte_rawdev_queue_release(uint16_t dev_id, uint16_t queue_id)
 	RTE_RAWDEV_VALID_DEVID_OR_ERR_RET(dev_id, -EINVAL);
 	dev = &rte_rawdevs[dev_id];
 
-	if (*dev->dev_ops->queue_release == NULL)
+	if (dev->dev_ops->queue_release == NULL)
 		return -ENOTSUP;
-	return (*dev->dev_ops->queue_release)(dev, queue_id);
+	return dev->dev_ops->queue_release(dev, queue_id);
 }
 
 uint16_t
@@ -179,9 +176,9 @@ rte_rawdev_queue_count(uint16_t dev_id)
 	RTE_RAWDEV_VALID_DEVID_OR_ERR_RET(dev_id, -EINVAL);
 	dev = &rte_rawdevs[dev_id];
 
-	if (*dev->dev_ops->queue_count == NULL)
+	if (dev->dev_ops->queue_count == NULL)
 		return -ENOTSUP;
-	return (*dev->dev_ops->queue_count)(dev);
+	return dev->dev_ops->queue_count(dev);
 }
 
 int
@@ -194,9 +191,9 @@ rte_rawdev_get_attr(uint16_t dev_id,
 	RTE_RAWDEV_VALID_DEVID_OR_ERR_RET(dev_id, -EINVAL);
 	dev = &rte_rawdevs[dev_id];
 
-	if (*dev->dev_ops->attr_get == NULL)
+	if (dev->dev_ops->attr_get == NULL)
 		return -ENOTSUP;
-	return (*dev->dev_ops->attr_get)(dev, attr_name, attr_value);
+	return dev->dev_ops->attr_get(dev, attr_name, attr_value);
 }
 
 int
@@ -209,9 +206,9 @@ rte_rawdev_set_attr(uint16_t dev_id,
 	RTE_RAWDEV_VALID_DEVID_OR_ERR_RET(dev_id, -EINVAL);
 	dev = &rte_rawdevs[dev_id];
 
-	if (*dev->dev_ops->attr_set == NULL)
+	if (dev->dev_ops->attr_set == NULL)
 		return -ENOTSUP;
-	return (*dev->dev_ops->attr_set)(dev, attr_name, attr_value);
+	return dev->dev_ops->attr_set(dev, attr_name, attr_value);
 }
 
 int
@@ -225,9 +222,9 @@ rte_rawdev_enqueue_buffers(uint16_t dev_id,
 	RTE_RAWDEV_VALID_DEVID_OR_ERR_RET(dev_id, -EINVAL);
 	dev = &rte_rawdevs[dev_id];
 
-	if (*dev->dev_ops->enqueue_bufs == NULL)
+	if (dev->dev_ops->enqueue_bufs == NULL)
 		return -ENOTSUP;
-	return (*dev->dev_ops->enqueue_bufs)(dev, buffers, count, context);
+	return dev->dev_ops->enqueue_bufs(dev, buffers, count, context);
 }
 
 int
@@ -241,9 +238,9 @@ rte_rawdev_dequeue_buffers(uint16_t dev_id,
 	RTE_RAWDEV_VALID_DEVID_OR_ERR_RET(dev_id, -EINVAL);
 	dev = &rte_rawdevs[dev_id];
 
-	if (*dev->dev_ops->dequeue_bufs == NULL)
+	if (dev->dev_ops->dequeue_bufs == NULL)
 		return -ENOTSUP;
-	return (*dev->dev_ops->dequeue_bufs)(dev, buffers, count, context);
+	return dev->dev_ops->dequeue_bufs(dev, buffers, count, context);
 }
 
 int
@@ -254,9 +251,9 @@ rte_rawdev_dump(uint16_t dev_id, FILE *f)
 	RTE_RAWDEV_VALID_DEVID_OR_ERR_RET(dev_id, -EINVAL);
 	dev = &rte_rawdevs[dev_id];
 
-	if (*dev->dev_ops->dump == NULL)
+	if (dev->dev_ops->dump == NULL)
 		return -ENOTSUP;
-	return (*dev->dev_ops->dump)(dev, f);
+	return dev->dev_ops->dump(dev, f);
 }
 
 static int
@@ -264,9 +261,9 @@ xstats_get_count(uint16_t dev_id)
 {
 	struct rte_rawdev *dev = &rte_rawdevs[dev_id];
 
-	if (*dev->dev_ops->xstats_get_names == NULL)
+	if (dev->dev_ops->xstats_get_names == NULL)
 		return -ENOTSUP;
-	return (*dev->dev_ops->xstats_get_names)(dev, NULL, 0);
+	return dev->dev_ops->xstats_get_names(dev, NULL, 0);
 }
 
 int
@@ -287,9 +284,9 @@ rte_rawdev_xstats_names_get(uint16_t dev_id,
 
 	dev = &rte_rawdevs[dev_id];
 
-	if (*dev->dev_ops->xstats_get_names == NULL)
+	if (dev->dev_ops->xstats_get_names == NULL)
 		return -ENOTSUP;
-	return (*dev->dev_ops->xstats_get_names)(dev, xstats_names, size);
+	return dev->dev_ops->xstats_get_names(dev, xstats_names, size);
 }
 
 /* retrieve rawdev extended statistics */
@@ -302,9 +299,9 @@ rte_rawdev_xstats_get(uint16_t dev_id,
 	RTE_RAWDEV_VALID_DEVID_OR_ERR_RET(dev_id, -ENODEV);
 	const struct rte_rawdev *dev = &rte_rawdevs[dev_id];
 
-	if (*dev->dev_ops->xstats_get == NULL)
+	if (dev->dev_ops->xstats_get == NULL)
 		return -ENOTSUP;
-	return (*dev->dev_ops->xstats_get)(dev, ids, values, n);
+	return dev->dev_ops->xstats_get(dev, ids, values, n);
 }
 
 uint64_t
@@ -322,9 +319,9 @@ rte_rawdev_xstats_by_name_get(uint16_t dev_id,
 		id = &temp; /* driver never gets a NULL value */
 
 	/* implemented by driver */
-	if (*dev->dev_ops->xstats_get_by_name == NULL)
+	if (dev->dev_ops->xstats_get_by_name == NULL)
 		return -ENOTSUP;
-	return (*dev->dev_ops->xstats_get_by_name)(dev, name, id);
+	return dev->dev_ops->xstats_get_by_name(dev, name, id);
 }
 
 int
@@ -334,9 +331,9 @@ rte_rawdev_xstats_reset(uint16_t dev_id,
 	RTE_RAWDEV_VALID_DEVID_OR_ERR_RET(dev_id, -EINVAL);
 	struct rte_rawdev *dev = &rte_rawdevs[dev_id];
 
-	if (*dev->dev_ops->xstats_reset == NULL)
+	if (dev->dev_ops->xstats_reset == NULL)
 		return -ENOTSUP;
-	return (*dev->dev_ops->xstats_reset)(dev, ids, nb_ids);
+	return dev->dev_ops->xstats_reset(dev, ids, nb_ids);
 }
 
 int
@@ -345,9 +342,9 @@ rte_rawdev_firmware_status_get(uint16_t dev_id, rte_rawdev_obj_t status_info)
 	RTE_RAWDEV_VALID_DEVID_OR_ERR_RET(dev_id, -EINVAL);
 	struct rte_rawdev *dev = &rte_rawdevs[dev_id];
 
-	if (*dev->dev_ops->firmware_status_get == NULL)
+	if (dev->dev_ops->firmware_status_get == NULL)
 		return -ENOTSUP;
-	return (*dev->dev_ops->firmware_status_get)(dev, status_info);
+	return dev->dev_ops->firmware_status_get(dev, status_info);
 }
 
 int
@@ -356,9 +353,9 @@ rte_rawdev_firmware_version_get(uint16_t dev_id, rte_rawdev_obj_t version_info)
 	RTE_RAWDEV_VALID_DEVID_OR_ERR_RET(dev_id, -EINVAL);
 	struct rte_rawdev *dev = &rte_rawdevs[dev_id];
 
-	if (*dev->dev_ops->firmware_version_get == NULL)
+	if (dev->dev_ops->firmware_version_get == NULL)
 		return -ENOTSUP;
-	return (*dev->dev_ops->firmware_version_get)(dev, version_info);
+	return dev->dev_ops->firmware_version_get(dev, version_info);
 }
 
 int
@@ -370,9 +367,9 @@ rte_rawdev_firmware_load(uint16_t dev_id, rte_rawdev_obj_t firmware_image)
 	if (!firmware_image)
 		return -EINVAL;
 
-	if (*dev->dev_ops->firmware_load == NULL)
+	if (dev->dev_ops->firmware_load == NULL)
 		return -ENOTSUP;
-	return (*dev->dev_ops->firmware_load)(dev, firmware_image);
+	return dev->dev_ops->firmware_load(dev, firmware_image);
 }
 
 int
@@ -381,9 +378,9 @@ rte_rawdev_firmware_unload(uint16_t dev_id)
 	RTE_RAWDEV_VALID_DEVID_OR_ERR_RET(dev_id, -EINVAL);
 	struct rte_rawdev *dev = &rte_rawdevs[dev_id];
 
-	if (*dev->dev_ops->firmware_load == NULL)
+	if (dev->dev_ops->firmware_load == NULL)
 		return -ENOTSUP;
-	return (*dev->dev_ops->firmware_unload)(dev);
+	return dev->dev_ops->firmware_unload(dev);
 }
 
 int
@@ -392,9 +389,9 @@ rte_rawdev_selftest(uint16_t dev_id)
 	RTE_RAWDEV_VALID_DEVID_OR_ERR_RET(dev_id, -EINVAL);
 	struct rte_rawdev *dev = &rte_rawdevs[dev_id];
 
-	if (*dev->dev_ops->dev_selftest == NULL)
+	if (dev->dev_ops->dev_selftest == NULL)
 		return -ENOTSUP;
-	return (*dev->dev_ops->dev_selftest)(dev_id);
+	return dev->dev_ops->dev_selftest(dev_id);
 }
 
 int
@@ -416,7 +413,7 @@ rte_rawdev_start(uint16_t dev_id)
 	if (dev->dev_ops->dev_start == NULL)
 		goto mark_started;
 
-	diag = (*dev->dev_ops->dev_start)(dev);
+	diag = dev->dev_ops->dev_start(dev);
 	if (diag != 0)
 		return diag;
 
@@ -444,7 +441,7 @@ rte_rawdev_stop(uint16_t dev_id)
 	if (dev->dev_ops->dev_stop == NULL)
 		goto mark_stopped;
 
-	(*dev->dev_ops->dev_stop)(dev);
+	dev->dev_ops->dev_stop(dev);
 
 mark_stopped:
 	dev->started = 0;
@@ -458,7 +455,7 @@ rte_rawdev_close(uint16_t dev_id)
 	RTE_RAWDEV_VALID_DEVID_OR_ERR_RET(dev_id, -EINVAL);
 	dev = &rte_rawdevs[dev_id];
 
-	if (*dev->dev_ops->dev_close == NULL)
+	if (dev->dev_ops->dev_close == NULL)
 		return -ENOTSUP;
 	/* Device must be stopped before it can be closed */
 	if (dev->started == 1) {
@@ -467,7 +464,7 @@ rte_rawdev_close(uint16_t dev_id)
 		return -EBUSY;
 	}
 
-	return (*dev->dev_ops->dev_close)(dev);
+	return dev->dev_ops->dev_close(dev);
 }
 
 int
@@ -478,10 +475,10 @@ rte_rawdev_reset(uint16_t dev_id)
 	RTE_RAWDEV_VALID_DEVID_OR_ERR_RET(dev_id, -EINVAL);
 	dev = &rte_rawdevs[dev_id];
 
-	if (*dev->dev_ops->dev_reset == NULL)
+	if (dev->dev_ops->dev_reset == NULL)
 		return -ENOTSUP;
 	/* Reset is not dependent on state of the device */
-	return (*dev->dev_ops->dev_reset)(dev);
+	return dev->dev_ops->dev_reset(dev);
 }
 
 static inline uint8_t
-- 
2.47.2

