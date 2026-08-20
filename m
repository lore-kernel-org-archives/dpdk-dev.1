Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A2DC5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:24:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DB6440B97;
	Thu, 20 Aug 2026 07:24:04 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id EB3564067C
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:24:02 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-381b831d535so2841570a91.0
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203442;
 x=1787808242; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/xAxOuQL4DiqEKwK8++aGqpSXYxxjmcl/6EMho2IdJA=;
 b=ktsdNBy5mNXTA9M2hItQCffhBIDbIkXwLlExlgMEuSl/y9pSydx+5cR/YUEcTUPDLF
 CjVTgJrUf5OLaAXGEe/ZV3rw62SnSS/NqOzQGP9Rt6NRPWg9Oa/+3nhFvonpv1BIIwU/
 mvbcB4gep3lC3qye+vwocG29CsE6d7VslcLOjMADRfhZsrDU95yJV3wLYBvg4kL8vULT
 qCR9XG/bJGypp12guIc6Tx8DiPKKjs72OWg7VLMfSt5hQRs+OoAs/MZGrBj+YWl4lCDN
 d6JP4AtJ3EEO9fePTCrqJS+/pT4ExRt0daZj9VaSjKgadzGvXmnMlLCe/C8Y61ZrHxdG
 MFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203442; x=1787808242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/xAxOuQL4DiqEKwK8++aGqpSXYxxjmcl/6EMho2IdJA=;
 b=rOf850qPblKX17TbagCdDffO7sKsdWsZ+4MSJine7opbIfGg9QNBiUHmodFNs88lIS
 wE6zXXfrYbmW6K22MHAvl/2tD3xBiRbusb/Ur2WplIx6AK8jPJ7oPqo3BH+8YCOk0igN
 7qN/FYQz59ECo7WNJ/KEgOiO7cqg0M03zsQB1Q9niXYfWYr/yaCATbzArVamvN57/LZ3
 ES2BPk7DP1PsHIQQBVPkfNQMZ34X1VAQ3E6zFYjRjWBLExYIUs6Va+j3z4QILGLSTXdT
 TsoFzuPB/HCfWR8l70q3DLYr+dTZ2kn28Luvz34K8CrtRTBMp++pN2RKL0TQwj1f30/1
 DzHA==
X-Gm-Message-State: AFuF++kbAcStlXk5RxidlQRDNIUNYNIqVJttdG36KKK4sYvsWCSiimfJ
 LpVZaUZty6oY68Lg0py3lag10M5uIxEW1lIryT9umspJrfNDnE2qCelrqG8Fbt1TEBNj9H/fPPZ
 NH8rX
X-Gm-Gg: AR+sD127oNKe8/jlXWHDOr75B1UgGb9WHosf2e1wFoRZraQKix33+SW7WH/nrmqmQ6a
 870792bhvRSAnhHImMA+2P95gyJq9GT3nbLvI/7syOoPTsuNG9KtUZ2HpoBn4h52P5LETFJMe2T
 FZ1jYTiHXpX9IS8D9Ly2iJXR8j3VIzPpwPa4ny53WvduaZLthBpdLfDm6L4KHUVFZvsH4dssS85
 nbUmIrUVstSf5RdhTMTmwuvKBCrMshULqr1n8aVZ98r8Q4h+4vT0Xfdlv18vY+AtnZMZVyvkrVG
 A1zHDdtikvdNyl9sDaJToahJIPxPGYVO/NjotSJNRjpmNT7y9htD17uOvefedJZQDHrwvyoWF+6
 TFWNoCP4Sr6gHN2q3epDP2wsXLCZg6vV8XTDyNH1nxg/nPyB53vU3aJ762IXJlwjIc0PyL40YCD
 XNaFPnbk/BXYHyzN2oRTah6mSKeJ1yYIA0LEriooWFroiSCJ8w8o6lMLNQ6s7c/PdwQqDY2nYFK
 6BDKi72E7U43sr4ylZKiXdhASo=
X-Received: by 2002:a17:90b:394b:b0:38f:5801:cd76 with SMTP id
 98e67ed59e1d1-39580a53e78mr20183538a91.3.1787203442084; 
 Wed, 19 Aug 2026 22:24:02 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.23.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:24:01 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Rosen Xu <rosen.xu@altera.com>, Sachin Saxena <sachin.saxena@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH 15/61] drivers/raw: use memcpy for fixed size data
Date: Wed, 19 Aug 2026 22:12:05 -0700
Message-ID: <20260820052251.1453273-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
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

