Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965E9C55167
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jul 2026 05:01:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C34E40E11;
	Fri, 31 Jul 2026 07:00:23 +0200 (CEST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mails.dpdk.org (Postfix) with ESMTP id 9F69D4067C
 for <dev@dpdk.org>; Fri, 31 Jul 2026 07:00:12 +0200 (CEST)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-cbb8b54fcf8so490599a12.0
 for <dev@dpdk.org>; Thu, 30 Jul 2026 22:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785474012;
 x=1786078812; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/ycTpSUakiO7qol27mbLOjIjTPakMJHfoki8g1Yy/qQ=;
 b=hD07skEZArT6HFb0H6DoW0reCwbPGY9UgallzBRuq11/Uzf/Na7dYPrC2W4WR9aoaZ
 aIUcGuuzMSfwo+qXJTgpdBAEceNtXcDCM8A6d+t/adlfjmhewBn3Hu8hlSDvUE2DjJOX
 40RIKQtz6AYXPpgsEC/++Twz/hToC7WCPrl++/j61ELPdv4FfCvfMGG1Y4liFGY/0YD2
 yz0PC/tGM6Xkz+Y8b5WVRCTL6XbVxDfmw8tHa9ppWOlJJ0Q1qMzPHEzAGkKJY2FKfB2G
 kE55Y1CFBfe9cPe8/yqNdeX7hnHojbZAnxrtLs4p1w1+E2/ssjjpKA33TtvoOw/ibjwa
 kLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785474012; x=1786078812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/ycTpSUakiO7qol27mbLOjIjTPakMJHfoki8g1Yy/qQ=;
 b=UFsgWnSs/YDnrhINQA3aSDaNQNvvFxRPBHeUoH1hJkBsIRhQtVBZhYtJvrsUvFrB42
 tiNCXHpIg+oSiyfTsUAruusTrvm6sCVGdO5nRwkAwParo7Tn+CtKXzHRVTjOISV5JMRW
 cbHfzwIzXqYRrFZwVuIW7y5V7TXEAbSzoH7irlTfszsDOq+hkpHVFrzuB3ufuJp4HrwN
 M07RGDLM/3qEQ/6CQGdk3OngkfqMg4PLpSsSs4WcpMHpVIuE3kmavCKFgL60x/7qNsDT
 xmt0c4WSi1HN+BBDbt5LM1X9uLy1UllBLhhF+w2KrlDlHgZkgg1fmv5XUAsV80rqq+MF
 5jWQ==
X-Gm-Message-State: AOJu0YyDc4M5pzYoe7VhrYGkEMM8pz49LwD9kAQCj2rsxOzIPvNZBZkh
 lPfGgP/zZZJK9sLGaM2dp9RGYZy/MGqVgmDZVkzOiwNuowgzwh4Ev9w+LowzlxoL8Sdpgi9O/bQ
 NbfhQ
X-Gm-Gg: AR+sD13pa4b72w2S+AHWcQvT0DGJpAQwof1iuWITf2gM97dRSIgguIH7ACPyJS7ur18
 MRa/xDnMW0Xob7CXPdFE/SgDBuplBbmdWfm3CrilFtVm98TDNDYIoHc33H0XXxtPZ19CrIqEV+S
 KO9WYAgYAtmjYcjd8vKDcGELHyc17exn5FvDBS5rr88YALpBwg5yj2Uk5BKk+p5KNB2CEBY2nFT
 AnmDDmKHHXqntZc2n5XDmcJrnEoY3+VmrRhSPMex69kb0MDoGyhpqYu2St9QcLUgHPJZ8czNdTA
 kyvFbiUj69jIgziJPOzmg/VU6PqI4rSX7iS/AoVAHgbAPVYidF1DMpWy0iIZAXo99HYUEEmrDmw
 VBJU4Uwa6BSA6hLwiK8tTw5c4as3lGbuwB0AlfLKkEVIj4N3DzSVxBAuhwbPHx2VBLF5WCn0M3u
 358Qz9HdtTSJx9BEb40Es5G4wBofpPl2NWcvUKYyDzqzJ+S0KAxwvLRzUJPVE2EBnT112aICOdW
 WiBRP089MBinM3pCTSNaYeAErg=
X-Received: by 2002:a05:6a20:4387:b0:3aa:c964:3c27 with SMTP id
 adf61e73a8af0-3c91b31f2demr502853637.46.1785474011804; 
 Thu, 30 Jul 2026 22:00:11 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153e06f0f9sm823245eec.23.2026.07.30.22.00.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 22:00:11 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Xiaoyun Wang <cloud.wangxiaoyun@huawei.com>
Subject: [PATCH v6 19/24] net/hinic: replace rte_atomic32 with stdatomic
Date: Thu, 30 Jul 2026 21:57:57 -0700
Message-ID: <20260731045948.769926-20-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731045948.769926-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260731045948.769926-1-stephen@networkplumber.org>
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

