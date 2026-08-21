Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB6BC5DF8C
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:29:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EAD6D40DD0;
	Fri, 21 Aug 2026 21:29:19 +0200 (CEST)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mails.dpdk.org (Postfix) with ESMTP id 773AF406BC
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:29:18 +0200 (CEST)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-84e0688b7e8so973692b3a.1
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340557;
 x=1787945357; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/xAxOuQL4DiqEKwK8++aGqpSXYxxjmcl/6EMho2IdJA=;
 b=CiJqy0giMDOyNIuHuwJAH5zBfClB7Ir1zs812Qm3vKDnObHJVGI1JW1qujKeJ+MB7T
 eilybhcBxRbNZVwY9xHbYubmQH6p2I12nbLj+WVgql2aZDCtbFlFPTmB0dB18/6a0HyE
 c6Q8otMBoKcJO2KcedQVFOS+I1PaAkdvYBz7Y9KKnniKyxACW1i7VP1+U+J890y75MNd
 w4YONQDs6QlJTQku9UdJj2jfMNM1bAKRXeSt/mrZ8kdr/0ZIZsRQB8HKiGWWAhDrz5pW
 93jyFN4NkoH4v0ZhIcFXC376yEhjYo/IT1d8cLDJci8WpN6dfTQd5BF9GYyPr6+sEgzR
 +jmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340557; x=1787945357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/xAxOuQL4DiqEKwK8++aGqpSXYxxjmcl/6EMho2IdJA=;
 b=QUQX/ljJmN8J8stuCTlufbj8H8sTZhUX1nVrWn2fThQAlBLIDQTxU8aZPynHycHTdM
 8/lrDgrPI5H05rUAI3juUb2U77nErajtk5nhWK9tXyzf4kpmR8iH9A9AdcsvlW8/C+PF
 0lR9NKD7akojlk8gC6/ES9Js6eAfOEWX4ph8Jj/sCSAPJHXUDVzPOfrLakgBhS2EP8L5
 voBByDpmS5ymk3gXIRCjpbUnAAUAtCKjnzx0poJOvYV6penCsahWNiHunH4ktJZoyCSQ
 pCJBW2OUwzyRPbhcfqCjWLifpRpSUQ32xK5TQB+ATyGeyZJUxqlPPOJsm4bQyrmPVXLP
 jWkQ==
X-Gm-Message-State: AFuF++kH3JBA1y0/Tl915wckfLH3oo8i8QcSOpRC5PAJciQrXiizR+oT
 CsvovXX2ZWNJ/lM0/4Rq+nwkN3kRuzjbSOTe4F6nYMVVUg9n+TMegmw5KAmcZ2R+uYnEkQ0EeFx
 GA4kS
X-Gm-Gg: AR+sD12fHvFmeL3SLsXTRDQs+ELoPwarxFpkPXGzm8j+j0qsQRTDxycg8ErnzoUjgMA
 9MrUgyJqIexEwhEwWFehRE9uuxTkxv0JTh38vhUGaXCqL1KFrestVNyUJxfrIJJQov+JShCpt8L
 7l6z7SgZS9U1v0f+foZaOBRYbf8xllqvAGwtWK0s4ddDUZ0WHscQp5cEqFbX7i7Qtw+B4sUdNNH
 m7jmnDTCoUV9Ij6rHx8rDnJRBHAvTU7a4sV2yyIqh4vUhjp8a5vkJZsq8C8uoGvvKJorNDPoKOK
 +GCzPdj3FqK/RjqTcjpUFUBEOukdPwyy7Bx78iby88P/9NAAgQZBfh2UPukeQsoj3lIXLW67uVq
 EeqkJ88ns+NVpWUDs/gPHLykPoN5ScUMcl5YbF2b+WFflPuYB55WP0Bu0Keko9MKGqQ2n6i5KzX
 vnlQQWUuXAK3OjLCO37mhE1LnrmuyBu+QtUcV+E6Z9wtncMAsUcziAzrfjAoJFOt0HIHZIxpHw4
 ZHpSKA9ClQducd1uOGDD+gfauCW/qfVPg0VEQ==
X-Received: by 2002:a05:6a21:a41:b0:3c3:68b0:e273 with SMTP id
 adf61e73a8af0-3cd4bbf659dmr2039929637.15.1787340557671; 
 Fri, 21 Aug 2026 12:29:17 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.29.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:29:17 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Rosen Xu <rosen.xu@altera.com>, Sachin Saxena <sachin.saxena@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH v2 22/68] drivers/raw: use memcpy for fixed size data
Date: Fri, 21 Aug 2026 12:24:17 -0700
Message-ID: <20260821192646.146382-23-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

The regular libc memcpy is inline for fix sizes and has
better analysis coverage.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/raw/ifpga/afu_pmd_he_hssi.c         |  4 ++--
 drivers/raw/ifpga/afu_pmd_he_lpbk.c         |  4 ++--
 drivers/raw/ifpga/afu_pmd_he_mem.c          |  4 ++--
 drivers/raw/ifpga/afu_pmd_n3000.c           |  8 ++++----
 drivers/raw/ifpga/ifpga_rawdev.c            | 11 +++++------
 drivers/raw/skeleton/skeleton_rawdev.c      |  8 +++-----
 drivers/raw/skeleton/skeleton_rawdev_test.c |  1 -
 7 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/raw/ifpga/afu_pmd_he_hssi.c b/drivers/raw/ifpga/afu_pmd_he_hssi.c
index bcb952935a..cf5ac5b459 100644
--- a/drivers/raw/ifpga/afu_pmd_he_hssi.c
+++ b/drivers/raw/ifpga/afu_pmd_he_hssi.c
@@ -6,6 +6,7 @@
 #include <stdio.h>
 #include <stdint.h>
 #include <stdlib.h>
+#include <string.h>
 #include <inttypes.h>
 #include <unistd.h>
 #include <fcntl.h>
@@ -15,7 +16,6 @@
 
 #include <rte_eal.h>
 #include <rte_malloc.h>
-#include <rte_memcpy.h>
 #include <rte_io.h>
 #include <bus_pci_driver.h>
 #include <bus_ifpga_driver.h>
@@ -313,7 +313,7 @@ static int he_hssi_config(struct afu_rawdev *dev, void *config,
 	if (cfg->port >= NUM_HE_HSSI_PORTS)
 		return -EINVAL;
 
-	rte_memcpy(&priv->he_hssi_cfg, cfg, sizeof(priv->he_hssi_cfg));
+	memcpy(&priv->he_hssi_cfg, cfg, sizeof(priv->he_hssi_cfg));
 
 	return 0;
 }
diff --git a/drivers/raw/ifpga/afu_pmd_he_lpbk.c b/drivers/raw/ifpga/afu_pmd_he_lpbk.c
index df3b093157..9ecff2ac14 100644
--- a/drivers/raw/ifpga/afu_pmd_he_lpbk.c
+++ b/drivers/raw/ifpga/afu_pmd_he_lpbk.c
@@ -6,6 +6,7 @@
 #include <stdio.h>
 #include <stdint.h>
 #include <stdlib.h>
+#include <string.h>
 #include <inttypes.h>
 #include <unistd.h>
 #include <fcntl.h>
@@ -15,7 +16,6 @@
 
 #include <rte_eal.h>
 #include <rte_malloc.h>
-#include <rte_memcpy.h>
 #include <rte_io.h>
 #include <bus_pci_driver.h>
 #include <bus_ifpga_driver.h>
@@ -362,7 +362,7 @@ static int he_lpbk_config(struct afu_rawdev *dev, void *config,
 	if ((cfg->end < cfg->begin) || (cfg->end > MAX_CACHE_LINES))
 		return -EINVAL;
 
-	rte_memcpy(&priv->he_lpbk_cfg, cfg, sizeof(priv->he_lpbk_cfg));
+	memcpy(&priv->he_lpbk_cfg, cfg, sizeof(priv->he_lpbk_cfg));
 
 	return 0;
 }
diff --git a/drivers/raw/ifpga/afu_pmd_he_mem.c b/drivers/raw/ifpga/afu_pmd_he_mem.c
index b595cd729c..b0453fbe55 100644
--- a/drivers/raw/ifpga/afu_pmd_he_mem.c
+++ b/drivers/raw/ifpga/afu_pmd_he_mem.c
@@ -6,6 +6,7 @@
 #include <stdio.h>
 #include <stdint.h>
 #include <stdlib.h>
+#include <string.h>
 #include <unistd.h>
 #include <fcntl.h>
 #include <poll.h>
@@ -14,7 +15,6 @@
 
 #include <rte_eal.h>
 #include <rte_malloc.h>
-#include <rte_memcpy.h>
 #include <rte_io.h>
 #include <bus_pci_driver.h>
 #include <bus_ifpga_driver.h>
@@ -125,7 +125,7 @@ static int he_mem_tg_config(struct afu_rawdev *dev, void *config,
 	if (config_size != sizeof(struct rte_pmd_afu_he_mem_tg_cfg))
 		return -EINVAL;
 
-	rte_memcpy(&priv->he_mem_tg_cfg, config, sizeof(priv->he_mem_tg_cfg));
+	memcpy(&priv->he_mem_tg_cfg, config, sizeof(priv->he_mem_tg_cfg));
 
 	return 0;
 }
diff --git a/drivers/raw/ifpga/afu_pmd_n3000.c b/drivers/raw/ifpga/afu_pmd_n3000.c
index d5520a0d71..06acfbd12d 100644
--- a/drivers/raw/ifpga/afu_pmd_n3000.c
+++ b/drivers/raw/ifpga/afu_pmd_n3000.c
@@ -1864,8 +1864,8 @@ static int n3000_afu_config(struct afu_rawdev *dev, void *config,
 		if ((cfg->nlb_cfg.end < cfg->nlb_cfg.begin) ||
 			(cfg->nlb_cfg.end > MAX_CACHE_LINES))
 			return -EINVAL;
-		rte_memcpy(&priv->nlb_cfg, &cfg->nlb_cfg,
-			sizeof(struct rte_pmd_afu_nlb_cfg));
+		memcpy(&priv->nlb_cfg, &cfg->nlb_cfg,
+		       sizeof(struct rte_pmd_afu_nlb_cfg));
 	} else if (cfg->type == RTE_PMD_AFU_N3000_DMA) {
 		if (cfg->dma_cfg.index >= NUM_N3000_DMA)
 			return -EINVAL;
@@ -1884,8 +1884,8 @@ static int n3000_afu_config(struct afu_rawdev *dev, void *config,
 					cfg->dma_cfg.length);
 			}
 		}
-		rte_memcpy(&priv->dma_cfg, &cfg->dma_cfg,
-			sizeof(struct rte_pmd_afu_dma_cfg));
+		memcpy(&priv->dma_cfg, &cfg->dma_cfg,
+		       sizeof(struct rte_pmd_afu_dma_cfg));
 	} else {
 		IFPGA_RAWDEV_PMD_ERR("Invalid type of N3000 AFU");
 		return -EINVAL;
diff --git a/drivers/raw/ifpga/ifpga_rawdev.c b/drivers/raw/ifpga/ifpga_rawdev.c
index 1846cca669..b293cd626c 100644
--- a/drivers/raw/ifpga/ifpga_rawdev.c
+++ b/drivers/raw/ifpga/ifpga_rawdev.c
@@ -14,7 +14,6 @@
 #include <rte_log.h>
 #include <rte_malloc.h>
 #include <rte_devargs.h>
-#include <rte_memcpy.h>
 #include <rte_pci.h>
 #include <bus_pci_driver.h>
 #include <rte_kvargs.h>
@@ -258,7 +257,7 @@ static int ifpga_rawdev_fill_info(struct ifpga_rawdev *ifpga_dev)
 	if (point < 12)
 		return -1;
 	point -= 12;
-	rte_memcpy(ifpga_dev->parent_bdf, &link[point], 12);
+	memcpy(ifpga_dev->parent_bdf, &link[point], 12);
 
 	point = strlen(link1);
 	if (point < 26)
@@ -949,10 +948,10 @@ ifpga_rawdev_pr(struct rte_rawdev *dev,
 		if (ret)
 			return ret;
 
-		rte_memcpy(&afu_pr_conf->afu_id.uuid.uuid_low, uuid.b,
-			sizeof(u64));
-		rte_memcpy(&afu_pr_conf->afu_id.uuid.uuid_high, uuid.b + 8,
-			sizeof(u64));
+		memcpy(&afu_pr_conf->afu_id.uuid.uuid_low, uuid.b,
+		       sizeof(u64));
+		memcpy(&afu_pr_conf->afu_id.uuid.uuid_high, uuid.b + 8,
+		       sizeof(u64));
 
 		IFPGA_RAWDEV_PMD_INFO("%s: uuid_l=0x%lx, uuid_h=0x%lx",
 			__func__,
diff --git a/drivers/raw/skeleton/skeleton_rawdev.c b/drivers/raw/skeleton/skeleton_rawdev.c
index 6e99d35536..256f45cb5d 100644
--- a/drivers/raw/skeleton/skeleton_rawdev.c
+++ b/drivers/raw/skeleton/skeleton_rawdev.c
@@ -20,7 +20,6 @@
 #include <rte_log.h>
 #include <rte_malloc.h>
 #include <rte_memory.h>
-#include <rte_memcpy.h>
 #include <rte_lcore.h>
 #include <bus_vdev_driver.h>
 
@@ -245,8 +244,8 @@ static int skeleton_rawdev_queue_def_conf(struct rte_rawdev *dev,
 	skelq = &skeldev->queues[queue_id];
 
 	if (queue_id < SKELETON_MAX_QUEUES)
-		rte_memcpy(queue_conf, skelq,
-			sizeof(struct skeleton_rawdev_queue));
+		memcpy(queue_conf, skelq,
+		       sizeof(struct skeleton_rawdev_queue));
 
 	return 0;
 }
@@ -281,8 +280,7 @@ static int skeleton_rawdev_queue_setup(struct rte_rawdev *dev,
 
 	if (skeldev->num_queues > queue_id &&
 	    q->depth < SKELETON_QUEUE_MAX_DEPTH) {
-		rte_memcpy(q, queue_conf,
-			   sizeof(struct skeleton_rawdev_queue));
+		memcpy(q, queue_conf, sizeof(struct skeleton_rawdev_queue));
 		clear_queue_bufs(queue_id);
 	} else {
 		SKELETON_PMD_ERR("Invalid queue configuration");
diff --git a/drivers/raw/skeleton/skeleton_rawdev_test.c b/drivers/raw/skeleton/skeleton_rawdev_test.c
index 99765feb41..d818912f0f 100644
--- a/drivers/raw/skeleton/skeleton_rawdev_test.c
+++ b/drivers/raw/skeleton/skeleton_rawdev_test.c
@@ -7,7 +7,6 @@
 #include <rte_common.h>
 #include <rte_mbuf.h>
 #include <rte_malloc.h>
-#include <rte_memcpy.h>
 #include <dev_driver.h>
 #include <rte_rawdev.h>
 #include <bus_vdev_driver.h>
-- 
2.53.0

