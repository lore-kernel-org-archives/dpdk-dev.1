Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AD4C982D0
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 20:13:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CBB454328F;
	Thu, 17 Sep 2026 22:11:45 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 39D2D4325C
 for <dev@dpdk.org>; Thu, 17 Sep 2026 22:11:40 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2d8fdc579daso428655ad.1
 for <dev@dpdk.org>; Thu, 17 Sep 2026 13:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789675899;
 x=1790280699; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WpfAn8SoPnGWlJzbI6Yu1MLUTyATtath/fBPtmVNC78=;
 b=TmHLADxUr5/FEBcFT3P7n+9ZEOpQzsoIwVaKfY5Mn89xHkkPGceY55/yGbl3Pp3/XI
 5DO8cz2CESoTYf2pxbyVxIa4CQeQOjSEfWpOLbjA9xHw/ON8V5WanVWeH1lLl6g2nr/6
 LnIJWp/9QvH4xTD3ivQKVBMJTMo7s+hj5hAz+kKxTYkvhpi5UCQ8b6RWrzIMpqCx0tgY
 HZEh9PyOKZW02uZSPM8ki8jYb2IST1yGabXv0rDXxWgLsi8yzTNNzBRL88CtQo+tGNp5
 +1aonxJLxc4TwTFzsVGq7sC7Zvt+omjb4cMHwIiFJjSZwVgdOUWb25IXrsi3Lt5C2f65
 rRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789675899; x=1790280699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WpfAn8SoPnGWlJzbI6Yu1MLUTyATtath/fBPtmVNC78=;
 b=DVjiajhEjXOVmapmOYEcmTaaZivmQXc6POnm2d52c1bZVt+Mm5H00z6bED9pnh9rXN
 h85SxJvcrvxDBC2tPj5PgDIPv2B52cfbr8hihoEwRlzsL3XiRMng07x2Jb+G856Qq0qo
 silCxBpPlgnEl77KxoySQuhcnM0OmtEofdF1Bp1ejubzRSX9DpBB0/CezQ4WtWfKHTXx
 Zn/YoDqUozd55jLuzhXUzqGipjPSuylqO2sgyG4yBVfZDT7c16mPsvaBvr/iFj7TUgvU
 oB4ZAqyvQ5Op01yWKvoOiG1ZYtQK/pfDmRu36CynFLdqtbXMDjUrN3Md4mTQTIC94kkt
 KSbQ==
X-Gm-Message-State: AFuF++k0hYyuYTAQjrBReX+Sbs1DlUxFnrmpyWtBR/W2igzv2bw/Cwn5
 5hkMmjPVflqNjfPhINRJNLhS4QRcyeijVniUv3a7q6Y8RglzXMSJm2rn9J8aG7jOEjFUNy6K3VJ
 fNPSo
X-Gm-Gg: AYBFou1EBOMxoFuq2sGi2QMan8W8iFM51qgi7E/hFoPZxk9KvBgk70j+kyRK5qO4Eg/
 fl4FRYjPAvjBY9RFOCG+/Ct4fiDpse6G+3rx+npZRCQ6Oe37veYkJX+IHZYT9+0fTEpRly6AXxd
 FVbW+J/iYcx/b7aTEI8huCvo5eZO/ukaVi8dFP1hb7FueW/jGfWzBDzH0/CO8b3WvprCbOMl3LS
 BLHd76I683fUB8jeLWVtfeGXTeioYNLuAB16OB3NVbgvXs9Sn8nbqMIajMvb7RNbPLqvGt10Zun
 1HwJZKuQbOwLUwXP7pZPgSTWJpuo18+SVSS/td1o/Cp2pAvuB0zJ0cMY4MzEZFFKdtwPMu0RGMs
 LuNTqolObRkpr+2N+BByx4gAZh3rtx7JdtLp9gPnSP9Q7Op+vzH47/ReW8M4LhaWY6G3+NDffhK
 evl6Er4Gn8Pc6aqYgH7g28KMQC0mFt0RUt6PnvBIg6shcYqkGpalFBTakz6F4qI/LMcD2tXm8I9
 XrD3IM1fuFKKjkaD7ofv7+oMhf5EcM9FbLtRDc=
X-Received: by 2002:a17:902:e748:b0:2da:f7ad:cfea with SMTP id
 d9443c01a7336-2ddb1ae3d88mr6023655ad.8.1789675899378; 
 Thu, 17 Sep 2026 13:11:39 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd89f0870bsm31368345ad.63.2026.09.17.13.11.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 13:11:38 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Xiaoyun Wang <cloud.wangxiaoyun@huawei.com>
Subject: [PATCH v8 19/25] net/hinic: replace rte_atomic32 with stdatomic
Date: Thu, 17 Sep 2026 13:10:23 -0700
Message-ID: <20260917201119.2168234-20-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917201119.2168234-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260917201119.2168234-1-stephen@networkplumber.org>
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

Convert dma_pool::inuse and hinic_os_dep::dma_alloc_cnt to
RTE_ATOMIC(uint32_t) and replace rte_atomic32_*() with the
rte_atomic_*_explicit() equivalents. The matching local variable
and log format change from int/%d to uint32_t/%u.

Note: the memzone names now start with zero; i.e "0000:03:00.0_0"
which is harmless side effect.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/hinic/base/hinic_compat.h    |  2 +-
 drivers/net/hinic/base/hinic_pmd_hwdev.c | 24 ++++++++++++++----------
 drivers/net/hinic/base/hinic_pmd_hwdev.h |  4 ++--
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/net/hinic/base/hinic_compat.h b/drivers/net/hinic/base/hinic_compat.h
index 707a3b92b9..c53b88b96d 100644
--- a/drivers/net/hinic/base/hinic_compat.h
+++ b/drivers/net/hinic/base/hinic_compat.h
@@ -15,7 +15,7 @@
 #include <rte_memzone.h>
 #include <rte_memcpy.h>
 #include <rte_malloc.h>
-#include <rte_atomic.h>
+#include <rte_stdatomic.h>
 #include <rte_spinlock.h>
 #include <rte_cycles.h>
 #include <rte_log.h>
diff --git a/drivers/net/hinic/base/hinic_pmd_hwdev.c b/drivers/net/hinic/base/hinic_pmd_hwdev.c
index 818698dcb3..9a1b126632 100644
--- a/drivers/net/hinic/base/hinic_pmd_hwdev.c
+++ b/drivers/net/hinic/base/hinic_pmd_hwdev.c
@@ -116,7 +116,8 @@ static void *hinic_dma_mem_zalloc(struct hinic_hwdev *hwdev, size_t size,
 			   dma_addr_t *dma_handle, unsigned int align,
 			   unsigned int socket_id)
 {
-	int rc, alloc_cnt;
+	int rc;
+	uint32_t alloc_cnt;
 	const struct rte_memzone *mz;
 	char z_name[RTE_MEMZONE_NAMESIZE];
 	hash_sig_t sig;
@@ -125,8 +126,9 @@ static void *hinic_dma_mem_zalloc(struct hinic_hwdev *hwdev, size_t size,
 	if (dma_handle == NULL || 0 == size)
 		return NULL;
 
-	alloc_cnt = rte_atomic32_add_return(&hwdev->os_dep.dma_alloc_cnt, 1);
-	snprintf(z_name, sizeof(z_name), "%s_%d",
+	alloc_cnt = rte_atomic_fetch_add_explicit(&hwdev->os_dep.dma_alloc_cnt,
+						  1, rte_memory_order_relaxed);
+	snprintf(z_name, sizeof(z_name), "%s_%u",
 		 hwdev->pcidev_hdl->name, alloc_cnt);
 
 	mz = rte_memzone_reserve_aligned(z_name, size, socket_id,
@@ -282,7 +284,6 @@ struct dma_pool *dma_pool_create(const char *name, void *dev,
 	if (!pool)
 		return NULL;
 
-	rte_atomic32_set(&pool->inuse, 0);
 	pool->elem_size = size;
 	pool->align = align;
 	pool->boundary = boundary;
@@ -294,12 +295,15 @@ struct dma_pool *dma_pool_create(const char *name, void *dev,
 
 void dma_pool_destroy(struct dma_pool *pool)
 {
+	uint32_t inuse;
+
 	if (!pool)
 		return;
 
-	if (rte_atomic32_read(&pool->inuse) != 0) {
-		PMD_DRV_LOG(ERR, "Leak memory, dma_pool: %s, inuse_count: %d",
-			    pool->name, rte_atomic32_read(&pool->inuse));
+	inuse = rte_atomic_load_explicit(&pool->inuse, rte_memory_order_relaxed);
+	if (inuse != 0) {
+		PMD_DRV_LOG(ERR, "Leak memory, dma_pool: %s, inuse_count: %u",
+			    pool->name, inuse);
 	}
 
 	rte_free(pool);
@@ -312,14 +316,14 @@ void *dma_pool_alloc(struct pci_pool *pool, dma_addr_t *dma_addr)
 	buf = hinic_dma_mem_zalloc(pool->hwdev, pool->elem_size, dma_addr,
 				(u32)pool->align, SOCKET_ID_ANY);
 	if (buf)
-		rte_atomic32_inc(&pool->inuse);
+		rte_atomic_fetch_add_explicit(&pool->inuse, 1, rte_memory_order_relaxed);
 
 	return buf;
 }
 
 void dma_pool_free(struct pci_pool *pool, void *vaddr, dma_addr_t dma)
 {
-	rte_atomic32_dec(&pool->inuse);
+	rte_atomic_fetch_sub_explicit(&pool->inuse, 1, rte_memory_order_relaxed);
 	hinic_dma_mem_free(pool->hwdev, pool->elem_size, vaddr, dma);
 }
 
@@ -329,7 +333,7 @@ int hinic_osdep_init(struct hinic_hwdev *hwdev)
 	struct rte_hash_parameters dh_params = { 0 };
 	struct rte_hash *paddr_hash = NULL;
 
-	rte_atomic32_set(&hwdev->os_dep.dma_alloc_cnt, 0);
+	hwdev->os_dep.dma_alloc_cnt = 0;
 	rte_spinlock_init(&hwdev->os_dep.dma_hash_lock);
 
 	dh_params.name = hwdev->pcidev_hdl->name;
diff --git a/drivers/net/hinic/base/hinic_pmd_hwdev.h b/drivers/net/hinic/base/hinic_pmd_hwdev.h
index d6896b3f13..ad30ddd72e 100644
--- a/drivers/net/hinic/base/hinic_pmd_hwdev.h
+++ b/drivers/net/hinic/base/hinic_pmd_hwdev.h
@@ -18,7 +18,7 @@
 
 /* dma pool */
 struct dma_pool {
-	rte_atomic32_t inuse;
+	RTE_ATOMIC(uint32_t) inuse;
 	size_t elem_size;
 	size_t align;
 	size_t boundary;
@@ -402,7 +402,7 @@ struct hinic_hilink_link_info {
 /* dma os dependency implementation */
 struct hinic_os_dep {
 	/* kernel dma alloc api */
-	rte_atomic32_t dma_alloc_cnt;
+	RTE_ATOMIC(uint32_t) dma_alloc_cnt;
 	rte_spinlock_t  dma_hash_lock;
 	struct rte_hash *dma_addr_hash;
 };
-- 
2.53.0

