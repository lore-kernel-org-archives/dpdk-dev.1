Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9228CD5BDE
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 23:28:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F38C240DD3;
	Wed, 27 May 2026 01:26:16 +0200 (CEST)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id 43C9740A89
 for <dev@dpdk.org>; Wed, 27 May 2026 01:26:10 +0200 (CEST)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-2f0ad52830cso14217878eec.1
 for <dev@dpdk.org>; Tue, 26 May 2026 16:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779837969;
 x=1780442769; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ycTpSUakiO7qol27mbLOjIjTPakMJHfoki8g1Yy/qQ=;
 b=y2cqqKOJi52F1sDdw+3D+Eig70bZqPfEZ/iCBbJ9OZrcFjT+Uwo6L92Pyb1s8AwGxK
 QfuI0eWwqlk1iS/u7o51ImtpyN7TkjdQ6IYQZT1Wpe+SJ3nTdi3ZWM8yKgbb9+waRiIB
 P4n1/SCZq+Pp/AN/0zCygNDK5v9je/VHOri0BskS8cg0cx4zyMxX49Uo+K7fs4YUKwPB
 TrajVV3IaC1VRM/30KAE6rTFbCCDcdpzVKy5YJscxvInrvowPDjXgfs1LHo0Lnnm+SVM
 prn5ziYmiiGp4rAYnJfGEryrjfobqxBkvXjtrtoaKrv4oURFrk16r8soE1awA+4SrbnP
 zIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779837969; x=1780442769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/ycTpSUakiO7qol27mbLOjIjTPakMJHfoki8g1Yy/qQ=;
 b=TyvOty83NyYjcdJxZCPkLp8eIAaVmu7b9lfWWFnBR+56ONp6fHmW8H7+antyeQy2EX
 LI8keyClmhTGRr4OkrzDyVNGpijnmteiZzV6Z7A/F3uNtxZ69qCxMg7DGbaI06ggH3Ly
 sn46hPR1OpMeqNfKKxQucz/NgCmDjdhp7NJN25Yf/sHbGcglL/IGlwhTwt+jruOAOnVk
 6pRQhCB8EnnXAdcM00YJH4NTsVVbh8/5yT0wHz5NDc9raaOEBCpVZ8vTsANG7i3BFaL3
 5J7nKgdk7mrCouN+0D8YnpBIHxIRIZn1Hue6+isxH1WI14D1mUQpulUEh7FKUjIjj5k4
 uOMA==
X-Gm-Message-State: AOJu0YzYyLjIhIAKBn/5vYVO2lrDOO7Re+XvUDzQ+MDyf/amU9U4HVBd
 uxNI6rvrmJaFggsYdRNqUBNqbuxo6oiFrL3oXzB6UA82q4o6pGOLM3SW4hVWiL0SeaEUn1Sa2Nl
 qs0Ka
X-Gm-Gg: Acq92OHlIRXsKK2eRYQ1iza7HMhl/kdjSO4e05jF4DYyb1t0pCJHp03vvqkFnDnY32x
 d6DqzqAYxh9/9OktzTXtMpy3NRwvYyguYCovS5NcwY8YC/seVGCWRdQBeMTgZ34rvaCAcU5Sj3Y
 t2Ff8UhAJKGNzIWTcoyguSc0Zqy/lRpaLWtBWZJwDcnNX/YdCHT7GKybd9q5rK1+FdFSvIEETaw
 1bnGyxA2XiZ2cDjTDB8MDrmLfvVsPf+0iqRmq9PPBPQtkn+j6HGKIeAN2TAjWavAUNJZd6uEzeP
 2X9es+EhH6i/Zl6mfiLVv7FwIitpIrnzCPfyFXE6NygOkQBVFnaE3I3MQTJk9lhfQpKMK06BBzx
 xt4j4hmp/tFieZ5RGzH3LJ2ubooGpoEDYgYajuzOMJhDeUW8iZhD5TN87xGeJEWvcTclnT6bQza
 NC8guOv9ayS+A9XrEcXNl9gw5cEzZ/Aoris348X/bicBNCGdopUfK0rqtRiuWJvZm/JJFU+YGc
X-Received: by 2002:a05:7300:134a:b0:2cf:28e8:d784 with SMTP id
 5a478bee46e88-30449184a7amr9048872eec.19.1779837969319; 
 Tue, 26 May 2026 16:26:09 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452230f1bsm11296132eec.14.2026.05.26.16.26.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 16:26:08 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Xiaoyun Wang <cloud.wangxiaoyun@huawei.com>
Subject: [PATCH v4 22/27] net/hinic: replace rte_atomic32 with stdatomic
Date: Tue, 26 May 2026 16:24:12 -0700
Message-ID: <20260526232542.620966-23-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526232542.620966-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260526232542.620966-1-stephen@networkplumber.org>
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

