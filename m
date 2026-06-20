Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74723CD98F2
	for <dpdk-dev@archiver.kernel.org>; Sat, 20 Jun 2026 02:33:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 34EF040E26;
	Sat, 20 Jun 2026 04:32:09 +0200 (CEST)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com
 [209.85.128.170])
 by mails.dpdk.org (Postfix) with ESMTP id A372040A8A
 for <dev@dpdk.org>; Sat, 20 Jun 2026 04:32:05 +0200 (CEST)
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-7ea6923cc94so28837737b3.3
 for <dev@dpdk.org>; Fri, 19 Jun 2026 19:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781922725;
 x=1782527525; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ycTpSUakiO7qol27mbLOjIjTPakMJHfoki8g1Yy/qQ=;
 b=RxfZd1ZX0BBRI130Ym6TggkiFhvG+cm0X/8204MQgfR00IvFFbNG19E9rRlQ/vKLTB
 +Q6Qj/GlfD+M6Fz2ji0169PdhwPeT/Z5LWsmzZOd11A+biHzUvz48DKkWdWllydpChTJ
 2Yr6cC7eYUIdr29Sh0Bs3r8YGZ7q03ZtSNsIv3pNJRULTMbwOgo3AcHJkbsFJuBMMoa9
 AV0vzHS4bZoo4o3fePYGXgQWYrd4bNfgornkfUpGunFVv4OWj8DAE4Gq+I1QfNNkl16L
 rLP8Dj4dNMNV/Hyhp4Rqs5JDFgee5NgUcV3V5ZSQeWj0PijqDvRzQeh1L9N4Uq0fqhVJ
 dFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781922725; x=1782527525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/ycTpSUakiO7qol27mbLOjIjTPakMJHfoki8g1Yy/qQ=;
 b=jDy8JTsOq0WXBii7bnHKISKbNOz+v0vnvTqGtXUFkv0sEo1XVXUfCoJ1Ls0ggHItCL
 tNRNpjooAtAsZCEv725H7faNItKP/+QpLW/maG5DNwnbjMJqvf6+rdzfG8i6ajgVpgFx
 GEtCJSJYeSnybjsoVJIa0td7ey02/RQcSiaoEJc3wbipUT4x5oAIRFaJpUVlYzS+LcGW
 XebjlduvFp9sJaLUzlroYfxRnxmrDk/2vB29fVGz+3GjYBpDAfc8CMsbslVRD2mzu4pa
 r+alP5770Tale1thBFmUu463Yn+vioSzU47FJG6xBLn46KM0knaLdy7h6sQQOnZ6IIVI
 KvOQ==
X-Gm-Message-State: AOJu0Yxe4WxPy41o2PErh0lSK8JMy1kBdY4Hb22aTaVRPjEg7oBQxpdQ
 jzZwgqjwiMj/fP1NMj8iP46b1hpjFsckSMfjjgyoYAdIejwhUBPW9Zp6tiB9tzbqolhiRmzsI7d
 gItql
X-Gm-Gg: AfdE7cnC9k2XgwPCqg/j+b4hbqDBc5WoKaIYvaEUTrJFllWpmUlXfBeFh+es2SmTCJX
 d8dL+ZaU6fdsNDjipllCRcrEgL9jazTuDSabqU9XZ9UXrsCXGuLauG41dEL+D3KrJIXJtP0kSez
 geyxFPxdx18pCCVItpJ2b6jTrLA6sSj2KO/HddhyX7CFHhPMlCzfamsJQu4sVELwAmHM/gkp7w1
 t81aZ2tLWftRbqPsTXKrMKVQwfHC4+uzpMN+vMi7vOnEsG0WEN1WDgUtjJ2S7IvFedH4xiIynd3
 Onh4OIVxtGxwtUOoJbNYM5VMTMq3cRN82XpFkPKAC9s37QatmJJ/sWAStwccmcaGR389AYkMncy
 RK8l9orCnxwmux2EF4h/2O+MKdXF5CQDBuuditq7atGEBY2oS3ozO9owxduDGKpU4DWeXBupK0a
 IP8ykpgxFOF/kmaTKwrVhABpkEwN0rcTlIZSt2FfX5aWGyfwJNWUc=
X-Received: by 2002:a05:690c:e3cb:b0:7bd:5579:185a with SMTP id
 00721157ae682-801336f1b65mr64227517b3.25.1781922724922; 
 Fri, 19 Jun 2026 19:32:04 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8025c96ffd5sm6045897b3.9.2026.06.19.19.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 19:32:04 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Xiaoyun Wang <cloud.wangxiaoyun@huawei.com>
Subject: [PATCH v5 19/24] net/hinic: replace rte_atomic32 with stdatomic
Date: Fri, 19 Jun 2026 19:28:44 -0700
Message-ID: <20260620023134.42877-20-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260620023134.42877-1-stephen@networkplumber.org>
References: <https://inbox.dpdk.org/dev/20260521042043.1590536-1-stephen@networkplumber.org>
 <20260620023134.42877-1-stephen@networkplumber.org>
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

