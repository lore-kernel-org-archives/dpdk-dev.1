Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1888CC021B0
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 02:36:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F1B640670;
	Thu, 20 Feb 2025 03:35:42 +0100 (CET)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id 2EA3040616
 for <dev@dpdk.org>; Thu, 20 Feb 2025 03:35:31 +0100 (CET)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-219f8263ae0so8316665ad.0
 for <dev@dpdk.org>; Wed, 19 Feb 2025 18:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740018930;
 x=1740623730; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1lNQycMbkBB3vhI3IytwM6LSWOou66F+K4PaW2XhHdA=;
 b=i2l1hHckEZMcdFejHXiYWsspZf2o+2VgWtLcUNSd8tvdK6Mbpnh8taDIpBU0LC5dlx
 kJYIQ9ocsy6xDfe729hLpg1Q3lj3lSg0aVuVhOr17XrivsVA0nQc8xWJZSoChYANFn08
 oVfELQQpR47CBcDM3RfZ3jeujGljthomKLQIXT1e8cM6oqvZNdxvyf6xDImODkh3TNX2
 C/o6jRh/zIPKz4fqnmACOoIXfHSqmkqXUmNm5MEjCje2DKEdbJEcwN9q2WKpkWgYY1wW
 BsK/rpp+tEUCf0lX6y7W7aB6pIehmL3AQx9Kb4JPnAuWmw4EvPtR/BdhzwwknbTXrRqe
 AYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740018930; x=1740623730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1lNQycMbkBB3vhI3IytwM6LSWOou66F+K4PaW2XhHdA=;
 b=bv1V4fQUrQxPBiWAlmLBgzCJab8zcJYq++8OtF3RbBd+U/kXg743jsI2s0682bIIkm
 wc+Kb9INeK+VTmnUkfJEqiu+Oq57iR4dzmJqQ8axt/rfYeWCbgBklaaavJFjr0EICcp6
 UCc2sU1j5VGReapN4IpzUtWVuijAYmrUwTGOhZ9NjOiC+9JtSLQoMKI9v0xSXZ1NlPEB
 /jM5/Z+yDJ3f8BRnGg/00gf2IRkYeghnFxgS/w0SS0+4DeJ/ZNU4cfQQX6DVd31X4ooS
 +kpdn9Bf62k6jIBtMUVji0mMWfccygk9ak31u3H9ybZjT507gF5H/f4YvEiSOa3KxsQ9
 oonQ==
X-Gm-Message-State: AOJu0Yz1NGrUfSsEtAJbMQJ/TMKts4nuepQKUVvrstpBmmOj7zUs5vZX
 qe0M8IL5ora6xAqYJXPVjKKBZsyoelPUwc5ClWh5EdFlaVyMolMks+Gj08ChUtsBojYpuWdGouS
 GW7M=
X-Gm-Gg: ASbGncudL8ckGv0kqzGTiRw9TdaZzLJOVS3X99Ht+xjllT3wOwDR+4PTEVLary3gAxM
 +jK+nnG5aHuR+jm0ZRNN9S3BtrqjHKhWWFIPWH5lGkapxkR6MmGsGvKstSaD3r5flBYu9p/5jbH
 iXXDvsWBb+Ip1v9A3PCZnkuAIfODI/E6CAdU7yEFsEFMC+lFZHSBvlh9f/xrHgAQZy45Rtc0b7K
 vdI/3Ummnmg6xbP+I+gV3ilHdyitylp9N9VTR+V1E8MxqQAI1EX+vDAO/WeApvgMIXM22mTipj+
 FvZKab6DmzRPrks3CmkerJqtz0yN+S8Xnr4r7LjIEoHkeVkxtfXObhVh0FgrHvZxiZSK
X-Google-Smtp-Source: AGHT+IEUHrq1kP0fdO0m6bDyW478/dR0YHxlwXZBygU1Di2oLXUEY5eEZjZ0dGVwq3jPle/+SLJYaQ==
X-Received: by 2002:a17:903:2301:b0:21f:6ce1:7410 with SMTP id
 d9443c01a7336-2210405d629mr397247345ad.24.1740018930398; 
 Wed, 19 Feb 2025 18:35:30 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d53490b6sm111668345ad.16.2025.02.19.18.35.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 18:35:29 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Kevin Laatz <kevin.laatz@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 10/14] dmadev: remove unnecessary deref of function pointers
Date: Wed, 19 Feb 2025 18:32:14 -0800
Message-ID: <20250220023509.630569-11-stephen@networkplumber.org>
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

