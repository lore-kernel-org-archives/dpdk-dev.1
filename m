Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15595C021B0
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 02:36:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23EE64067B;
	Thu, 20 Feb 2025 03:35:43 +0100 (CET)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id 41A2A40659
 for <dev@dpdk.org>; Thu, 20 Feb 2025 03:35:32 +0100 (CET)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-2fc291f7ddbso694783a91.1
 for <dev@dpdk.org>; Wed, 19 Feb 2025 18:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740018931;
 x=1740623731; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I+cxE30iDMgKG2myhqcQBfdGul/+jRUsgKmADGpcr1I=;
 b=vZX4g/4wl+gaT+PUVQV9HPfoTNDI1GjitQukip4hX+ZHZSOqVyUy25d9gjBeBdznHj
 2b7MQISmLzMs5axSMAPR/PiEK1o6mmlc/vWaV2nruEYI42kk4fZ/bRsbEqgrGUDlBant
 2vyzZrRfGepel3fpCnkgkBYM0KcpDm9pHmamZpZxG34JMV03QbG9DKAxr63UNYQrVu0A
 4Q7QdtnpxMX7m+EBIEoEuDh7z+qOWSVU/UohnyVn1qTQzsZqU/XeEfsu0o8+ppHd0eSl
 zig1WlzvN3YE0WIcBSh1U9gZoqvUsLURV7L0OW2HjYtt7gXFGEFZtn7o/hqZDNrwkOmA
 8bqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740018931; x=1740623731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I+cxE30iDMgKG2myhqcQBfdGul/+jRUsgKmADGpcr1I=;
 b=I0aj/80m/Vj7I/iYrWT70o+vdqlYEB30c8tpH1fzMczH5gk3wNdY20oIpoc0fhd0BJ
 go9WU6w6DRkeEPFkHcGiip5Y6xEFjck0Al8MbhOhCoGr+plmSAVuXgB/kKMz6ZOovguy
 QuyexQx9P9xtWjy0u8ZMH5pusoVckWr0VTazK3sxTwEIjcd36+84xedSAAneH5tH2jJH
 nyDMYQHvJ4Ae06cnhDdKQNuLr0VusEROME8o371v5iff3UD/dIGIW7wm4sArkcb15Xz1
 xsb5YojFkmANecpA3k+b9fb0tVJXy7dgaFOFpEHQn9Ytx9tLAVbSbdV0gFHEblRVHYmP
 LapQ==
X-Gm-Message-State: AOJu0YyyisKB7hdM5IbHn7CpGwWbNT9qkRymBem6T16h+SAzaxP+TFsx
 gXLMPtnw4xCErAiAuGSul1iYGR85/S0YkiNbiEeMuWzKjgbqsqzdK46NCRLxO+77t3lFUq2T2yD
 Fqt4=
X-Gm-Gg: ASbGncudgnZ7RZcbds3sz+l0wa31V8sun4SzOW2ytbN7lwo9NE7eIVsQ9raPzR5kQxD
 v9r5CftCHPmi2rAl4CzZCkVamoOkeVj7i0t6IALRgL8Sc39v1HRmk5hVQJL/2THyCGvJ/sIKyQu
 HIN1IQcddXQ2AsKM0qMeJiY1i/PK7hOfAzXsiw+L5GTmDvjshPHjI41uKf/jaLXDEoKIRABErW4
 AyU3rlqX69IhCtqpCL/Xe5kTcYfhgyR6+jqXKZ47C8E124S3FaDC9kz0q0QTyR0NzMAi7uqWgwv
 haDiZnNqWrhLf7uCE0MXs8zaVQPpHJl1bOd6FbMD8BvcxsfMdJWvfmWcG4vRD5nlt5yb
X-Google-Smtp-Source: AGHT+IG76LTmX3fQkaGT65Z59Wp+k/RHt/92v0UomF1VAglJvM8zKR02jXgW0vCrZ22vP6HCYVpCsw==
X-Received: by 2002:a17:90b:3812:b0:2f4:423a:8fb2 with SMTP id
 98e67ed59e1d1-2fc40f21df3mr31621879a91.20.1740018931409; 
 Wed, 19 Feb 2025 18:35:31 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d53490b6sm111668345ad.16.2025.02.19.18.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 18:35:31 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH v2 11/14] rawdev: remove unnecessary deref of function pointers
Date: Wed, 19 Feb 2025 18:32:15 -0800
Message-ID: <20250220023509.630569-12-stephen@networkplumber.org>
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

