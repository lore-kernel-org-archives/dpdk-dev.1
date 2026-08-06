Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09043C55838
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 03:27:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B62F840BA6;
	Thu,  6 Aug 2026 05:26:12 +0200 (CEST)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mails.dpdk.org (Postfix) with ESMTP id 3136A40B9C
 for <dev@dpdk.org>; Thu,  6 Aug 2026 05:26:09 +0200 (CEST)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-caf45fc5202so1576545a12.1
 for <dev@dpdk.org>; Wed, 05 Aug 2026 20:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785986768;
 x=1786591568; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/ycTpSUakiO7qol27mbLOjIjTPakMJHfoki8g1Yy/qQ=;
 b=EWt/Rj89UWBxSVBeZ/S+pPSMbs2GqNmcYTso1uPOzSIHldjrTGwFmLtilJmWvrdQOS
 2+rq2iqxrDZTeybanOkyr5MDV3zM3gCuClBKMKH7EIrNmUOP1zB2bV8jpIAVqvSc/3j1
 xIReA71sxPCGrRKhHMbhrDYjWcejN+Odz6rdOTIbXE7jEhfK93EiO3RmM/CcGHGtdWL2
 OdkWNs/e/JY1qcMkIzwcpcq7PPI1P+5VKHjd7dWK0cFb0WW2c5w+MzfDXmjh2zyul/Z6
 XwFSXnrit2OqfcwNOv/iZT6XhbtTnhDuvPojozCZ9Oqi68ncSYFBG8/NvnDnAloku4mD
 2Qbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785986768; x=1786591568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/ycTpSUakiO7qol27mbLOjIjTPakMJHfoki8g1Yy/qQ=;
 b=lgTVwC8wqXRP6XPvBw8b5BzKhShaR7JhRonxy+H+7O1MrBONBpVinh0804ENHPLAXw
 UTQRDOwwEyc9K0KTudmEgZ2PJADM6hI9M/EOkFqV5uQ/kcfDIQlo0WvVDp9MMpiuD+AI
 bOF/7SNYszZ2m4tgQhuMzTGK+9x5cPLBbwbYYJWKHK3NW5mEorRsY6NAbgHMWkN670Es
 WvKWq4vHNu+lYTqnehkbomUkRvpSKgYB3vnEBPWo0NylS7U9qthGS/TSlNDvqXZypUJu
 fs+beKLf5jbWNfXkKuQ/GW7CBswxRtnUkw4O4v69roosAyLCEYFZ7pQ79shDnY4XboTL
 kdpg==
X-Gm-Message-State: AOJu0YwtABXWnd1kpaFspQvO9+tsDxcYoMkBqIdCF/PB/ICAhz1nAMuu
 e0pGgWVG19n0FK2bHC8r8tbFDguBy4iCGHRjnluvvlaWIme/boSARwN4P78Q/gOgCB07CoaSUCy
 Cc+uPqVk=
X-Gm-Gg: AR+sD12e9UfKfXkHrVVJ/V2KZNV0ShbdN75LqbB2nQ7YwkUtzn7mgjYC/koMRVpyA5j
 w/MehkVvzQhGXN1pQgeBSwoJyI8K74NrGAOeXJq9ztHldwLZH5c0HnUrGpY9uv9b3lI0Qr03uCK
 LkdfZymu1qGz5G4CkDLkGGsX7dPHIxUwcdAJXK9VfRZwG0DVxiPL8CXj6K6oq0mHdQyJBrD00dZ
 lJtXMoJ7RWATLneZKoNgKCv68N1r7tpCCIRuYTkn7kJFQYIfE9I1TD7MNz/F7VV6aRglo/DAA4X
 /5hRf42T91EUi4MS77JnT+mbh6lPakSpr45qkRAPvPyV9vLH5niQFwv6mDoRwh/VnCwKnof1+LL
 L6yz579CZZZlIgubdHEq4MkLQVlIeVwAvt+voBLJzJsNZLDlSbewTr4yf7WvZAfYKWA1p0WWauS
 Mi2X9kk4ah5/3NYJjgTD1AJELVqqaMMOngzzEQCotMfrrEibGWE1so/ob8lCPIvEMEWnvOWDaKA
 44DeowobeNu1wy/fXZP3BiAcM4=
X-Received: by 2002:a05:6a21:998c:b0:3c8:e397:cf77 with SMTP id
 adf61e73a8af0-3cb85df18ffmr13638460637.2.1785986768375; 
 Wed, 05 Aug 2026 20:26:08 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863b0c61sm23301631eec.6.2026.08.05.20.26.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 20:26:08 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Xiaoyun Wang <cloud.wangxiaoyun@huawei.com>
Subject: [PATCH v7 19/24] net/hinic: replace rte_atomic32 with stdatomic
Date: Wed,  5 Aug 2026 20:23:11 -0700
Message-ID: <20260806032544.21337-20-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806032544.21337-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260806032544.21337-1-stephen@networkplumber.org>
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

