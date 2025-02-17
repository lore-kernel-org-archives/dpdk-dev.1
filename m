Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F32C021AA
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Feb 2025 18:58:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45F234066C;
	Mon, 17 Feb 2025 19:58:06 +0100 (CET)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id 2EB88402E5
 for <dev@dpdk.org>; Mon, 17 Feb 2025 19:58:01 +0100 (CET)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-22101839807so52762715ad.3
 for <dev@dpdk.org>; Mon, 17 Feb 2025 10:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739818680;
 x=1740423480; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1lNQycMbkBB3vhI3IytwM6LSWOou66F+K4PaW2XhHdA=;
 b=tsm9XrjIltoWJMTKGDPsgNGpxi8XIdUzLujlcJXNeGTBQa8Nb1bZ6fuu+Xj9VECEt4
 h+lIU1AQV5Sgm93bUedpPiNeO/dQ26fhnyyYlf4jW6jG6aHGPT3YpJhoS3pF1ZMNA6N4
 H6C3FQl/0WSXr7+aINIu5kAn4+o1sRMsEA0FoSMMqfCvcHE+ttUuDMCjnf3yS3dGybnd
 gJ7ZccYHh4/IqhJc9nUgW0FtlX+yGy1hHhdnWKSe/KaBMqO04hTDLK3jUP1ZosFerID5
 VapeDOhsuVHNPj//iKv/wO6FLxelRsKLoOfetGKSEvbxuMCm5JnTVU0CjBlEUVUZRGiW
 4C4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739818680; x=1740423480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1lNQycMbkBB3vhI3IytwM6LSWOou66F+K4PaW2XhHdA=;
 b=qdct30yeany5YQxDDMsaLicGlPomNTzZPtxYoB17yiskmwDrwoddJ4NQ6zMEc/mHu/
 ZQ1rPFHATEapFPooUV22AN4JDtJs17aetXf97rGTXSlggqRnm2jBZhRGn/sdCmpZJ3Ef
 ohyEN1eNc+18VvYzV+qFV/Umy0wdIY0Nk9DDgJ0smzspPvN9AYeeGDSZMr7A0YR30Sor
 9NazjD8KmnjJXxyQgNhsXlSlbthdaYTFpySYtPyhtYKphz8j7o78NgngUtk6OLwVt71Q
 bLq9n2fG23M62z47CZR07auwnr3vS/boSkxueus6t/VFiE1vPhpKpneomN1sjCuiqRb2
 Z+Kg==
X-Gm-Message-State: AOJu0YxUu/AmtP6mb2MpkLul9jegRFpi0ST/AWWl8CtePZqt/uxfS7MW
 nqKJD+Dq7iJ9kL6NcDBhSre3jRoRnvxxXF4vKTo5P4CAjywTzuZuq33ycvGTiNYQ5jzChk+Y/Kg
 PYwg=
X-Gm-Gg: ASbGncuTP96cosMu3nar/xjcCVce0ycKhkyFjidDFJUgd3KmT+M8PouaTjDxYbDGRlo
 Ugby7mnfF1bYDO2E6YXXLQ4RP1Ij1W4eFQTpmwHurR4yAGJYT5wuhHedcLBWC8vBcTj/Byr3Kr4
 b6+C0MpvTm1hRzgMIH5g0rBEcBi4DnFjR9XSrKPHMJzg+/VtVk0Xmrq6wZ5WOdGqjaZtGRyPxPB
 D3VZmz4GP6ZD0A5f4x9nI8TS5X5C5vkZy0ZitMEEpvYOxnLlhn2b0eB6PMtfpZqzQcMnIRSigHY
 MsPG5D/OoZFTUjPrCkygQoSOOdA6JMRLDlhQ0nshQMXMJpUjXUWlLFxvtG/PTnD4qrBY
X-Google-Smtp-Source: AGHT+IGEZNTsZ67uzLskDiAxwC3DeWTmXgXL4CwsoLhn7cYWiHUosrj47OmVwAdzuOd98QoucmSkxw==
X-Received: by 2002:a05:6a21:164a:b0:1ee:7714:61 with SMTP id
 adf61e73a8af0-1ee8caab64dmr17839887637.4.1739818680377; 
 Mon, 17 Feb 2025 10:58:00 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adb57c5dc68sm7815149a12.9.2025.02.17.10.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 10:58:00 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 08/11] dmadev: remove unnecessary deref of function pointers
Date: Mon, 17 Feb 2025 10:54:07 -0800
Message-ID: <20250217185743.169778-9-stephen@networkplumber.org>
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

The expression *dev->dev_ops->dev_info_get and
dev->dev_ops->dev_info_get are equivalent.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/dmadev/rte_dmadev.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/lib/dmadev/rte_dmadev.c b/lib/dmadev/rte_dmadev.c
index 8bb7824aa1..4a075ee1c6 100644
--- a/lib/dmadev/rte_dmadev.c
+++ b/lib/dmadev/rte_dmadev.c
@@ -443,11 +443,10 @@ rte_dma_info_get(int16_t dev_id, struct rte_dma_info *dev_info)
 		return -EINVAL;
 	dev = &rte_dma_devices[dev_id];
 
-	if (*dev->dev_ops->dev_info_get == NULL)
+	if (dev->dev_ops->dev_info_get == NULL)
 		return -ENOTSUP;
 	memset(dev_info, 0, sizeof(struct rte_dma_info));
-	ret = (*dev->dev_ops->dev_info_get)(dev, dev_info,
-					    sizeof(struct rte_dma_info));
+	ret = dev->dev_ops->dev_info_get(dev, dev_info, sizeof(struct rte_dma_info));
 	if (ret != 0)
 		return ret;
 
@@ -510,10 +509,9 @@ rte_dma_configure(int16_t dev_id, const struct rte_dma_conf *dev_conf)
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->dev_configure == NULL)
+	if (dev->dev_ops->dev_configure == NULL)
 		return -ENOTSUP;
-	ret = (*dev->dev_ops->dev_configure)(dev, dev_conf,
-					     sizeof(struct rte_dma_conf));
+	ret = dev->dev_ops->dev_configure(dev, dev_conf, sizeof(struct rte_dma_conf));
 	if (ret == 0)
 		memcpy(&dev->data->dev_conf, dev_conf,
 		       sizeof(struct rte_dma_conf));
@@ -546,7 +544,7 @@ rte_dma_start(int16_t dev_id)
 	if (dev->dev_ops->dev_start == NULL)
 		goto mark_started;
 
-	ret = (*dev->dev_ops->dev_start)(dev);
+	ret = dev->dev_ops->dev_start(dev);
 	rte_dma_trace_start(dev_id, ret);
 	if (ret != 0)
 		return ret;
@@ -574,7 +572,7 @@ rte_dma_stop(int16_t dev_id)
 	if (dev->dev_ops->dev_stop == NULL)
 		goto mark_stopped;
 
-	ret = (*dev->dev_ops->dev_stop)(dev);
+	ret = dev->dev_ops->dev_stop(dev);
 	rte_dma_trace_stop(dev_id, ret);
 	if (ret != 0)
 		return ret;
@@ -601,9 +599,9 @@ rte_dma_close(int16_t dev_id)
 		return -EBUSY;
 	}
 
-	if (*dev->dev_ops->dev_close == NULL)
+	if (dev->dev_ops->dev_close == NULL)
 		return -ENOTSUP;
-	ret = (*dev->dev_ops->dev_close)(dev);
+	ret = dev->dev_ops->dev_close(dev);
 	if (ret == 0)
 		dma_release(dev);
 
@@ -698,10 +696,9 @@ rte_dma_vchan_setup(int16_t dev_id, uint16_t vchan,
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->vchan_setup == NULL)
+	if (dev->dev_ops->vchan_setup == NULL)
 		return -ENOTSUP;
-	ret = (*dev->dev_ops->vchan_setup)(dev, vchan, conf,
-					sizeof(struct rte_dma_vchan_conf));
+	ret = dev->dev_ops->vchan_setup(dev, vchan, conf, sizeof(struct rte_dma_vchan_conf));
 	rte_dma_trace_vchan_setup(dev_id, vchan, conf, ret);
 
 	return ret;
@@ -723,11 +720,10 @@ rte_dma_stats_get(int16_t dev_id, uint16_t vchan, struct rte_dma_stats *stats)
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->stats_get == NULL)
+	if (dev->dev_ops->stats_get == NULL)
 		return -ENOTSUP;
 	memset(stats, 0, sizeof(struct rte_dma_stats));
-	return (*dev->dev_ops->stats_get)(dev, vchan, stats,
-					  sizeof(struct rte_dma_stats));
+	return dev->dev_ops->stats_get(dev, vchan, stats, sizeof(struct rte_dma_stats));
 }
 
 int
@@ -747,9 +743,9 @@ rte_dma_stats_reset(int16_t dev_id, uint16_t vchan)
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->stats_reset == NULL)
+	if (dev->dev_ops->stats_reset == NULL)
 		return -ENOTSUP;
-	ret = (*dev->dev_ops->stats_reset)(dev, vchan);
+	ret = dev->dev_ops->stats_reset(dev, vchan);
 	rte_dma_trace_stats_reset(dev_id, vchan, ret);
 
 	return ret;
@@ -769,9 +765,9 @@ rte_dma_vchan_status(int16_t dev_id, uint16_t vchan, enum rte_dma_vchan_status *
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->vchan_status == NULL)
+	if (dev->dev_ops->vchan_status == NULL)
 		return -ENOTSUP;
-	return (*dev->dev_ops->vchan_status)(dev, vchan, status);
+	return dev->dev_ops->vchan_status(dev, vchan, status);
 }
 
 static const char *
@@ -850,7 +846,7 @@ rte_dma_dump(int16_t dev_id, FILE *f)
 		dev->data->dev_conf.enable_silent ? "on" : "off");
 
 	if (dev->dev_ops->dev_dump != NULL)
-		ret = (*dev->dev_ops->dev_dump)(dev, f);
+		ret = dev->dev_ops->dev_dump(dev, f);
 	rte_dma_trace_dump(dev_id, f, ret);
 
 	return ret;
-- 
2.47.2

