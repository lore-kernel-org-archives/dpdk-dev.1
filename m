Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A5CC282EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 15:53:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 365F840616;
	Tue, 11 Mar 2025 16:53:14 +0100 (CET)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id A2DA740263
 for <dev@dpdk.org>; Tue, 11 Mar 2025 16:53:12 +0100 (CET)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-2fecba90cc3so10975514a91.2
 for <dev@dpdk.org>; Tue, 11 Mar 2025 08:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741708392;
 x=1742313192; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OQjxUJx7ySvHZTRhvpejgLjrhHreb6EnALGiMYKL4vs=;
 b=QYqv01TNsxDnS9TXeZ/hWW+3CrM+vKRE1ntomphLJ8CtJO0GiMZkpKNCNyF43DM4P/
 0rgVYirSP6cmeCBPRSNXn8ktJkvQ0hf7+yaSLcqlHcJJRm3JEJXp/1lq9HxH4nlTdhNL
 OberEb/3Dz/Gl8aXql4v2kbNp/09C5zRyT6hAyy9HYEP2YRwHOyQtxF8dMcEatBmlAcz
 10CZfyKqhrELsLlgLmMxjH4mBpdxE1+Jb7CDGJqpI0aRhwApSIZKlVxWRffwJzZCtujl
 O2DmNRQMPTTO8JXEEStxV4ibLKo0uJDYoCuLYNQoNeAqklBTYki4Fk1exToNEo/8lQlj
 wPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741708392; x=1742313192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OQjxUJx7ySvHZTRhvpejgLjrhHreb6EnALGiMYKL4vs=;
 b=mdcLEaxTebaVKTXv6h3IQzSTlsb35pdWr9A182QC4v2HCMQeUKEYNT2efet8OcPcYG
 6V9s6fV0jw5PpMUA+NjvSyvb2cqPbYaU4JMX75ReKidx0exr/c29zBpvzdfak6ZRfxkY
 lsiYD0KeqAdMk+KX32Ud68tTQpkaVAzhOJOe8iNHak7aDMIYuv1iHTjB2AALiLgWMZ6q
 IlTOuuPXUXzPZZd+nSHuXvqfTZyYy+cCPmElXEdeA2KbZidkQur1l/WDd/WfJZVZPpY8
 AmR5nqOmkeBm7MfAZE9b+kgyR8yBteEmeKtWPdmzM/MoHK3ajCorf9KFNMSelBMJ94DX
 /YEw==
X-Gm-Message-State: AOJu0YxNFVbx3nJPKOTB0V1qtTfRFl0UwuY+KRRJBQXl3BR3+2gLUxZw
 Mfz7AdenAfhOJOCxSJOEud/sgmqDr36XzZWdPT8uOTk6VwYXvMPixOntBWuqOwGhrbtM4T1MU45
 g
X-Gm-Gg: ASbGncv+XAjdupDD+MTK8X3/x+KfEXKX9mx39BEmWhdiHSBxEZIKZ+1SUUxkl0Dk1B0
 f6h/ePMiq0vMvZ4qYMHvI8aoH3S/qn/CrS5vWE05/8CYEL/qlS90Ip2ff1yZMyINHPliKNneiV5
 5rLhyLdKDxIkTfUs1f8+zSRNd1GnmaeM2d9ue5lqtlgB7PuVupFY4ky6y2SMaIhHGp+sXWs0MJJ
 3rJaiwE0V6rGxYYkWAI1HT1KEnd9r2tTzx7/5vVT52zY7MJ88fdU6ygEUmuqwkZiDFVwzz9a503
 99uS5Y/mTMhZnZx9HopHJz9A7Cl6kmdhdgU3ioEZYCgFgPE4rNPCX/hnEoF9T/WW0UO4WSvCwyF
 DTYCzibRAAEOWwuPiY2Y+hw==
X-Google-Smtp-Source: AGHT+IH5C0Zj0CU6s54j5dVmiER2zogVklrzzS7vCN0Uge92+2YHYUuknNSUF5pnzeHS/+59Jn2wrQ==
X-Received: by 2002:a05:6a21:4cc5:b0:1f5:9330:29fe with SMTP id
 adf61e73a8af0-1f593302c1fmr3036363637.17.1741708391859; 
 Tue, 11 Mar 2025 08:53:11 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af283576bc2sm9500013a12.38.2025.03.11.08.53.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 08:53:11 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Rosen Xu <rosen.xu@intel.com>
Subject: [PATCH 1/4] raw/ifpga: remove unnecessary deref of function pointers
Date: Tue, 11 Mar 2025 08:51:29 -0700
Message-ID: <20250311155300.13410-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250311155300.13410-1-stephen@networkplumber.org>
References: <20250311155300.13410-1-stephen@networkplumber.org>
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

The expression *dev->ops->start and dev->ops->start are equivalent.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/raw/ifpga/afu_pmd_core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/raw/ifpga/afu_pmd_core.c b/drivers/raw/ifpga/afu_pmd_core.c
index 3ab1f47ac1..f650b76cfe 100644
--- a/drivers/raw/ifpga/afu_pmd_core.c
+++ b/drivers/raw/ifpga/afu_pmd_core.c
@@ -39,7 +39,7 @@ static int afu_rawdev_configure(const struct rte_rawdev *rawdev,
 		return -ENODEV;
 
 	if (dev->ops && dev->ops->config)
-		ret = (*dev->ops->config)(dev, config, config_size);
+		ret = dev->ops->config(dev, config, config_size);
 
 	return ret;
 }
@@ -62,7 +62,7 @@ static int afu_rawdev_start(struct rte_rawdev *rawdev)
 	}
 
 	if (dev->ops && dev->ops->start)
-		ret = (*dev->ops->start)(dev);
+		ret = dev->ops->start(dev);
 
 	afu_rawdev_unlock(dev);
 
@@ -87,7 +87,7 @@ static void afu_rawdev_stop(struct rte_rawdev *rawdev)
 	}
 
 	if (dev->ops && dev->ops->stop)
-		ret = (*dev->ops->stop)(dev);
+		ret = dev->ops->stop(dev);
 
 	afu_rawdev_unlock(dev);
 }
@@ -104,7 +104,7 @@ static int afu_rawdev_close(struct rte_rawdev *rawdev)
 		return -ENODEV;
 
 	if (dev->ops && dev->ops->close)
-		ret = (*dev->ops->close)(dev);
+		ret = dev->ops->close(dev);
 
 	return ret;
 }
@@ -127,7 +127,7 @@ static int afu_rawdev_reset(struct rte_rawdev *rawdev)
 	}
 
 	if (dev->ops && dev->ops->reset)
-		ret = (*dev->ops->reset)(dev);
+		ret = dev->ops->reset(dev);
 
 	afu_rawdev_unlock(dev);
 
@@ -155,7 +155,7 @@ static int afu_rawdev_selftest(uint16_t dev_id)
 	}
 
 	if (dev->ops && dev->ops->test)
-		ret = (*dev->ops->test)(dev);
+		ret = dev->ops->test(dev);
 
 	afu_rawdev_unlock(dev);
 
@@ -174,7 +174,7 @@ static int afu_rawdev_dump(struct rte_rawdev *rawdev, FILE *f)
 		return -ENODEV;
 
 	if (dev->ops && dev->ops->dump)
-		ret = (*dev->ops->dump)(dev, f);
+		ret = dev->ops->dump(dev, f);
 
 	return ret;
 }
@@ -326,7 +326,7 @@ static int afu_rawdev_create(struct rte_afu_device *afu_dev, int socket_id)
 	}
 
 	if (dev->ops->init) {
-		ret = (*dev->ops->init)(dev);
+		ret = dev->ops->init(dev);
 		if (ret) {
 			IFPGA_RAWDEV_PMD_ERR("Failed to init %s", name);
 			goto cleanup;
-- 
2.47.2

