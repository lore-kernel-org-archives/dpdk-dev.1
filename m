Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE88C021B1
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 16:58:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE30B40676;
	Thu, 20 Feb 2025 17:57:17 +0100 (CET)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id D382B4065F
 for <dev@dpdk.org>; Thu, 20 Feb 2025 17:57:12 +0100 (CET)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-220c92c857aso21693145ad.0
 for <dev@dpdk.org>; Thu, 20 Feb 2025 08:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740070632;
 x=1740675432; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=okcTA8qfCP27AC3NmfATwxoq9LiF29HCaVCr6mnPbiE=;
 b=nAUzK4BGrHLjYSj4+iOjqbAlp/gr66BJ1LZd98BdFJut/y0vk27a96YsxQP+4CzTTT
 nFQ0uS0sQRHvTM0MUShn04z+CjpmdMasX79bH3PoZxktNnpXxSJvYvb/nowNpdxDJWhC
 Pq4HJDsh3LYOOpWNzOVzBiIH2oyqJ+qGre5/NtCQXWd/DWsjJhpB+cNN8vAW74qr11M1
 TdDrrneOLZ2Alwo9NM2xT3Nss4BvWR3Ob8ZiO0nBpLWr6hGJdB3a5lTsiPGOWr5Wbxb/
 ANOHZPuWSVdARmcG9U9S8odOkxgF1LBIBYpBI8ckzQH45sPdv9kk07trmP7jX0hzG3Vu
 ZFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740070632; x=1740675432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=okcTA8qfCP27AC3NmfATwxoq9LiF29HCaVCr6mnPbiE=;
 b=BfXmx9pGBbCAYNdSM8mo637/M4nuNt0j1owRRztUUpVDXc+hrnZfm82447xE3i0rH8
 fmheqSdeRyyGCKdlWBnqN5pRNYOUKTJmlH74y1k/e45Hm3nrSQ82Q9r2XrI/QXPprvMF
 LHuqm8yS4dmptYM2SObJd3Bgb5Ny6Alj/Sy9ZEWmTadDB/0glhN7glXAk4kCma5oZehS
 3kgDcAqBcfs+yx14Af4u0NbEsXuR5yydbIRwVuRnESvFh/RltsmRlEfrkXVS/X+b6G+n
 HcdhrRIAdqfNGQZsXYPbxZMR7I+mK63EqbzeFEJGr00y5PYY5y8lLEb6WBdKVmW0NJxq
 NroA==
X-Gm-Message-State: AOJu0YyISmOvvNBNjwv8rB15JOunO0bUxV4uDQ5z0mKfGJNOR4IjnKGO
 SDkNhIqw0eaA7hkDBGNCbX5DchLSfbxynJ08J/nWh+Pjwr9H2DPR/yhSmqbrrgk7tQFQF7RsDvy
 L
X-Gm-Gg: ASbGncvz3cX2OPvU2vp5Xujm0jSiev0ZI5US/3n3NOyaMiHQqe5fEzxgPI3dkCYjPFJ
 WxTf4ChB6HUO/hVFR/YkcGouiElXH1mF7LKdTA0knIhp0yrylrHrv6qlm4xqdEzKJ66EHHT/zVd
 bm92eQF4yYCzWsTb9jaYQhFxlwN87lBYhu4MVHvXi1wAkgaxHOXPpFkIjjv+lDgKVYkNfZYhrfa
 S32zFKzi/uCTONusVQu1fiCcmg2nOeGJbtRH15VyxioMh/4x0+oBvwQDZIj5uXaCdmeu6hrnYD0
 rESnJ1RfCayO3XqRt8WGG+YkJtGLHNXM3KscFmtdNv/M8cVYzp1ab04objG8NKtrjhgg
X-Google-Smtp-Source: AGHT+IFOp9YqLDrA6Ngqv/Vrvkvn+V1dBNHYDbvkG50VvmkJEmqNtGEuueA1epPxpt0pdW4xiGcExQ==
X-Received: by 2002:a17:903:32c5:b0:220:fe36:650c with SMTP id
 d9443c01a7336-2218c541d8dmr69021865ad.23.1740070632036; 
 Thu, 20 Feb 2025 08:57:12 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d53491b3sm122729435ad.40.2025.02.20.08.57.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:57:11 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chengwen Feng <fengchengwen@huawei.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Kevin Laatz <kevin.laatz@intel.com>
Subject: [PATCH v3 10/14] dmadev: remove unnecessary deref of function pointers
Date: Thu, 20 Feb 2025 08:55:24 -0800
Message-ID: <20250220165644.16421-11-stephen@networkplumber.org>
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

The expression *dev->dev_ops->dev_info_get and
dev->dev_ops->dev_info_get are equivalent.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
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

