Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B43DCD5BB8
	for <dpdk-dev@archiver.kernel.org>; Sat, 23 May 2026 20:04:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED77C4042F;
	Sat, 23 May 2026 22:04:49 +0200 (CEST)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com
 [209.85.210.43]) by mails.dpdk.org (Postfix) with ESMTP id 26FFA402D4
 for <dev@dpdk.org>; Sat, 23 May 2026 22:04:49 +0200 (CEST)
Received: by mail-ot1-f43.google.com with SMTP id
 46e09a7af769-7de431da8fbso7498520a34.1
 for <dev@dpdk.org>; Sat, 23 May 2026 13:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779566688;
 x=1780171488; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F5u/aH5EctZc+ohNGP62WFBUiKy43bHQy/LcTaoN94Q=;
 b=GDX3Ydrff/GkEUof/zUcRCW1gnpxSpHJXw++lRbYVZPZ0E9zQ8w70VvFyikVdV4GHL
 xBU5IAPz4NGS0Apvwuc4Z5WQYxFlPaAR3uFeGygNmlP4KMkaYFT9EUqXlBvvv8eVeJ5j
 WK4dW/fc+149o9dFUuhaSM5mUWdHCuapPxjfSXpB/bvvonGtWGHItNAwPekpY29hLHa9
 jNQuyEkKOdCfTDe9fSasxzk+bHZp0A3cZA/hko7HVJN/LuN2kMZlsILc1wUmIZyW5RfX
 JbgYhVvMrl8PUy+rt2gnbd978Bymz4OglyDBA9qgw/hYoFIenjMT4+S0CMp+NmYp9jaV
 5kPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779566688; x=1780171488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F5u/aH5EctZc+ohNGP62WFBUiKy43bHQy/LcTaoN94Q=;
 b=GZJNzsMRhxF1zN+x+1RoAIvePfd+9HeASpT7D5z5HRjIbkHwo3uAt9h8SEUhl6KfU9
 xDysMR5r6tqmVIjF28QySxtvp9TSb236lbITQot5sfHHodl5S+357Ms8KyOqvNo9B3VD
 VkbLrmOxyaopQEpkBZGyNx1gFtZ01gd1VOU28ZR6eayWyIA8g43XTJfw0irhIZCWPWFm
 qbbfu/ngKrKUp9L3Pb0AK/haGNy7Ab18Kub/XlxGD8cXYswmasQcI3DhX48rJheRUGu+
 iTxVyRl2tgzvyciWQgbWAdamesnp8r3SzlGA1e2kiqr1OrGPMl3JXI8swP5IS2crAcZl
 RCEg==
X-Gm-Message-State: AOJu0YyDIvzK2eUbvPDjWUUF/eLIjMf5GwYeybY4+bu3yLcUsEGDPvRn
 fk96aBsz81DReEFRUGjJbfBTUcZLNeRgvgkNEc3N5OhsJPC+AImXJgusKWmNJKMuZeQAz8yNetK
 2XX2p
X-Gm-Gg: Acq92OEk1MhjapPyRFQZlPNy/fQH6tshvjxr8Bb0HTZx+uFWm/X1iaNM9kVJLNRn9rc
 OIorJDm608/VhlY3Z6EPfvnZpFfbsNHIG9vkOG6/XAobXumSK1OtspV3ivsCiHMQiA69vlzOKZu
 G6yra1PU8LjouDO17ij2392ffQgvaisl1TIo/ilxx9UTx9izeZpezz08QjT/SWNI5VFsf2ANNyC
 5J7TKKSyA4wpFS9tny9rHeRUifRrWQWXu3KDpbZgw1CvqlaKFT7709t7zC1bTAjDcFW8BL+Jzgc
 35tgDpzO46hSGE90e1QZelaPrs2yVqwIp1VYsGcGE720qbZvDAxXfdxE2oZ8OiQYOh7hGcBnce9
 LOv+1sTk3ge8cPevxx3c9CSZfpPYTa3rzVgag3yC34CrRX/QXvY8i1/e4KNBQlHcCqzTVy4i6P9
 HvDvsbFZAmOE2BBSFM0FnyJqAnBSJ2K9aHlsClZkah/VAbpA+sMIfzx4Gi1a8isw==
X-Received: by 2002:a05:7300:2389:b0:2ea:b975:3db1 with SMTP id
 5a478bee46e88-304491d7957mr4167005eec.23.1779566344500; 
 Sat, 23 May 2026 12:59:04 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452255234sm4838428eec.20.2026.05.23.12.59.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 12:59:04 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Xiaoyun Wang <cloud.wangxiaoyun@huawei.com>
Subject: [PATCH v3 22/27] net/hinic: replace rte_atomic32 with stdatomic
Date: Sat, 23 May 2026 12:56:36 -0700
Message-ID: <20260523195839.454952-23-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523195839.454952-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260523195839.454952-1-stephen@networkplumber.org>
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

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/hinic/base/hinic_compat.h    |  2 +-
 drivers/net/hinic/base/hinic_pmd_hwdev.c | 24 ++++++++++++++----------
 drivers/net/hinic/base/hinic_pmd_hwdev.h |  4 ++--
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/net/hinic/base/hinic_compat.h b/drivers/net/hinic/base/hinic_compat.h
index d3994c50e9..b0e42fa9bc 100644
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

