Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD04CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 14:06:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1653F42E94;
	Tue, 29 Sep 2026 16:04:44 +0200 (CEST)
Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com
 [74.125.228.38]) by mails.dpdk.org (Postfix) with ESMTP id 075E442E5D
 for <dev@dpdk.org>; Tue, 29 Sep 2026 16:04:33 +0200 (CEST)
Received: by mail-pz2-f38.google.com with SMTP id
 d2e1a72fcca58-88379342f7fso1381095b3a.1
 for <dev@dpdk.org>; Tue, 29 Sep 2026 07:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790690672;
 x=1791295472; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WpfAn8SoPnGWlJzbI6Yu1MLUTyATtath/fBPtmVNC78=;
 b=bYgBvPvSYJ2hiH2QQWTM+V/D3eeyYDsH8vbJxgTClNN2I5hpXboS5qvgRnRqFzSNVH
 2rlzq2pJGv0cXSDJzYUmK2j1z2QKE0d6OpTRgrk4eUWZQXBslos7JqBjPMQootMjxrtM
 +fOi2VgsdGM3fFDj7yQHa8e8aN1NMKx9pnRuksT3dimswOhOUH+g/TmUvKuhBRQmMVPU
 YX+8Ky9xpVa81galwnlhTVUQq5BmHGYI/n0FNdCBC6UzpwDT3nSPXUMkVKaNC8jQiSze
 fWi/wVIdKR1PbYEmnwNsyuNLQtiIsi6yLHgamw9xhY3o1rNUys7WZIAFIh6FW5ua8bDw
 2mxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790690672; x=1791295472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WpfAn8SoPnGWlJzbI6Yu1MLUTyATtath/fBPtmVNC78=;
 b=ynvQNV68qDneMz1VDRyV8jGfoy91UCvx7vQeOTSWqFKYtr8xx7vyeCfVBgFZ2P+r5N
 oJxvjvLzGPvsnplJ3to6nAIhjrzGMdzQRP/90VxOPMJ0YdDuTT4tJXp+np/8FCMsWNuF
 z4XoxQ33QlOVHlCDSyMCX8D0Zqgd+bLqpNuUTYSYJMIepG0mQCfxMGsPGakOxG7qUD4l
 e8QJpHtHPG1xiUaAMwQojdYG/w5KywhtWnBu0k8vOAujYgj88u27qV8/JnQS3qUIH/2O
 1W5UTKukkIIjlRE/ePosixWum5Ye45qjevbJVllMU3O4DPVCddgtfhFKWezZUEtPHB+P
 OgEg==
X-Gm-Message-State: AFuF++lYBDbLsa4rYeD54Hx6hwgUi5KVkKyhYQOuL1WtVln2W9jirQyJ
 J/spwMV+YC0DdWYRMhTa245uBWUTAFaPw34xbDkrXr0YgJzGq/OsmOwtExRs9lKaPbQnXm+PVzZ
 o/ONmNA4=
X-Gm-Gg: AYBFou1Tgv24Aa0swNMTE6vhRIhwhLeMBDF0Ua27qNOkpWADTAH/RRCgM36Y/vG8ewN
 wb0i/f8YulLuWvt8q4WCndoArPjz4oxRJK1mlHIFn2cVhxmRbGdKyDOAXrvVuoZ/E5/mUTHgG5y
 cYcAg3UAw3EOwKTjFHdtsFH7IEOlcF0zhlbouSp9nvTntY23bqMeeDS8x7vxhdGv5lHEpbaIftE
 /pNAvYvjXEYyodcrjJXpF0lrwq5vpA+JjUoZ3gKhqhOUE2nnqgbBgpVogAbit57kEMKSENPDUEq
 JjF79qCoEyPzMxvRT8ePqtFNYlNMgCMZbKCBJrI7f8nmvl4wxi01GtJL/1vgu20fNnlYjZftWD2
 OEPZrHBuOPqYk0PA07F8IvIuCMLqMpaTE/QR2tcg8fnTxSJp/VtLOps14EmXUeGkMO4z0gN4Ccf
 WHl5Jb1+mVX1XkSs04/fExbXbOhe4jPwHOb2XQw/7bPhRia9KEHeb43NzVoTyMnZr/DBoyPRwt8
 A2duE6DWYDhzI+dytnDO+FqQupkU1TC/uKdPKUrkLTmofDVaQ==
X-Received: by 2002:a05:6a21:1bc6:b0:3dd:a006:ed9b with SMTP id
 adf61e73a8af0-3de0e8fb20cmr14934738637.49.1790690672075; 
 Tue, 29 Sep 2026 07:04:32 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-885e1066470sm998330b3a.18.2026.09.29.07.04.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 07:04:31 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Xiaoyun Wang <cloud.wangxiaoyun@huawei.com>
Subject: [PATCH v9 19/25] net/hinic: replace rte_atomic32 with stdatomic
Date: Tue, 29 Sep 2026 07:02:05 -0700
Message-ID: <20260929140409.234453-20-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929140409.234453-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260929140409.234453-1-stephen@networkplumber.org>
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

