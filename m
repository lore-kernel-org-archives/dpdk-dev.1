Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B51BC79FA1
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Sep 2026 02:00:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D8F640272;
	Wed,  9 Sep 2026 04:00:25 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id B899340144
 for <dev@dpdk.org>; Wed,  9 Sep 2026 04:00:23 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6891UjJP1568855 for <dev@dpdk.org>; Tue, 8 Sep 2026 19:00:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=5RfHw06Fnbnmepn71CSh6OS
 hZHoGZbu7L9yPNA8RMLM=; b=Cd/q9RrZdKCrvPr0Rdhona/8XQL9gGkspjzyxr0
 sdzWlJL3+9Z0YNx/RECTJhirH3k3pjqxgBbaRL6NqIBaQTXJKqR3bbbJG6iVa1g4
 C8AYXYtw4+VHJhR1hBJ4+/BvpQPT66rUTlZw46/lUGKqNm4m438/hCidUPYJAM43
 lKmrp3SakViAyJjdiKRJbNcVQTtba5PUzQpG/7jJMvP0SDPq+38ELMD8ddV8QdDl
 G+7QgI2Zvr+gTbu8EzLNKYU3JCTWfttbLweqrQ6C7E1kxvYJn4xH2H/aNI0C+sUv
 FgLwF85FuSAXAor6UkmGrcYvw3setpjh4jekOXB9n7+pmMA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gjwuu01wc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 08 Sep 2026 19:00:22 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Sep 2026 19:00:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 8 Sep 2026 19:00:22 -0700
Received: from LYYJYPGKF4.marvell.com (unknown [10.28.165.174])
 by maili.marvell.com (Postfix) with ESMTP id DDD0D3F7072;
 Tue,  8 Sep 2026 19:00:18 -0700 (PDT)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>, "Kiran
 Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 "Pavan Nikhilesh" <pbhagavatula@marvell.com>,
 Shijith Thotton <sthotton@marvell.com>
CC: <dev@dpdk.org>
Subject: [PATCH 1/2] drivers: align cn20k TIM chunk buffers
Date: Wed, 9 Sep 2026 07:30:10 +0530
Message-ID: <20260909020012.23261-1-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: YvKqfHiKouR8RKyz6XoH-Bld0XKtZ1k2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDAyMCBTYWx0ZWRfXwx7l0PvJipqn
 3uYsmCDO8x7RLksd4+K+lnL/79S0UB1bhlLM3grDGeKkzOnF5Sg42VFc6vjl8A1fMpQhvW6oOc8
 MTnEbfGZrS2P0HU/eNPpkfvtdBAM/5o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDAyMCBTYWx0ZWRfX0/psaagNIB8w
 I69mF5SPVUXNKC3oyo+9bA0I4kbwBVWSmGy6BwCUMtomdANvVYINGce54pLhdOyMvyFQ2tD+U54
 zpoW6Z1CBhCbYwH5YXhjU48f/4FGQu6JA3HCmlRbNC39iDS23plizj9As9PFjeTGNToz9j6SUwy
 764ZZpcK9sMMbH6vvskbWmtSdo98z/UnMS7bEqAONaR2/yOvzCG2aMVpMUClaCQu4revQop78/8
 1hBB655X8YdlNMyPgTEh72RhmEuXmJ+Iu7cogU71M5aSKPy9f0RI2SthWUzVMZ+YQBjkD+O+KBG
 LBelSRO59zkDEBcix+E/mGjczhvmi+T4JjlCgrw+VbSToTaSma4t31+rc6QvV4wYqhiOyOssu0E
 gzCc2ftrzNTJRJKzKtZKeATEugtZDW48X4wGUwUZk/1HaJ+1dzxSgMqn86DsJhmzvv2MDHkFNyd
 dW7x1AbYLiafST7jeNQ==
X-Authority-Analysis: v=2.4 cv=SfzHsPRu c=1 sm=1 tr=0 ts=6aa0bdb6 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=8pbwjcRxknczdkLShE8A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: YvKqfHiKouR8RKyz6XoH-Bld0XKtZ1k2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
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

From: Pavan Nikhilesh <pbhagavatula@marvell.com>

cn20k timer needs chunk buffers to be 256B aligned. Align the chunk
buffer header and size.
Update HWWQE response types and base code.

Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
---
 drivers/common/cnxk/hw/tim.h         |  2 +-
 drivers/common/cnxk/roc_mbox.h       | 11 ++++-
 drivers/common/cnxk/roc_tim.c        |  5 +-
 drivers/common/cnxk/roc_tim.h        |  4 +-
 drivers/event/cnxk/cnxk_tim_evdev.c  | 71 +++++++++++++++-------------
 drivers/event/cnxk/cnxk_tim_evdev.h  |  1 +
 drivers/event/cnxk/cnxk_tim_worker.h |  5 +-
 7 files changed, 58 insertions(+), 41 deletions(-)

diff --git a/drivers/common/cnxk/hw/tim.h b/drivers/common/cnxk/hw/tim.h
index 75700a11b868..4333256ab836 100644
--- a/drivers/common/cnxk/hw/tim.h
+++ b/drivers/common/cnxk/hw/tim.h
@@ -56,6 +56,6 @@
 #define TIM_MIN_BUCKET_SIZE    1
 #define TIM_BUCKET_WRAP_SIZE   3
 #define TIM_BUCKET_MIN_GAP     1
-#define TIM_NPA_TMO            0xFFFF
+#define TIM_NPA_TMO            0
 
 #endif /* __TIM_HW_H__ */
diff --git a/drivers/common/cnxk/roc_mbox.h b/drivers/common/cnxk/roc_mbox.h
index 52ecde656378..f5ea84b7341e 100644
--- a/drivers/common/cnxk/roc_mbox.h
+++ b/drivers/common/cnxk/roc_mbox.h
@@ -3196,7 +3196,9 @@ struct tim_config_req {
 	uint32_t __io chunksize;
 	uint32_t __io interval_lo;
 	uint8_t __io gpioedge;
-	uint8_t __io rsvd[3];
+	uint8_t __io priority : 1;
+	uint8_t __io rsvd8 : 7;
+	uint8_t __io rsvd[2];
 	uint32_t __io interval_hi;
 	uint64_t __io intervalns;
 	uint64_t __io clockfreq;
@@ -3222,7 +3224,12 @@ struct tim_feat_info {
 	uint8_t __io engines;
 	uint8_t __io hwwqe : 1;
 	uint8_t __io intvl_ext : 1;
-	uint8_t __io rsvd8[4];
+	uint16_t __io max_prd_timers;
+#define TIM_HWWQE_VER_0 0
+#define TIM_HWWQE_VER_1 1
+	uint8_t __io hwwqe_ver : 4;
+	uint8_t __io rsvd4 : 4;
+	uint8_t __io rsvd8;
 	uint64_t __io rsvd[2];
 };
 
diff --git a/drivers/common/cnxk/roc_tim.c b/drivers/common/cnxk/roc_tim.c
index a1461fedb1b4..54204c10783b 100644
--- a/drivers/common/cnxk/roc_tim.c
+++ b/drivers/common/cnxk/roc_tim.c
@@ -194,8 +194,8 @@ roc_tim_lf_base_get(struct roc_tim *roc_tim, uint8_t ring_id)
 
 int
 roc_tim_lf_config(struct roc_tim *roc_tim, uint8_t ring_id, enum roc_tim_clk_src clk_src,
-		  uint8_t ena_periodic, uint8_t ena_dfb, uint32_t bucket_sz, uint32_t chunk_sz,
-		  uint64_t interval, uint64_t intervalns, uint64_t clockfreq)
+		  uint8_t ena_periodic, uint8_t ena_dfb, uint8_t prio, uint32_t bucket_sz,
+		  uint32_t chunk_sz, uint64_t interval, uint64_t intervalns, uint64_t clockfreq)
 {
 	struct sso *sso = roc_sso_to_sso_priv(roc_tim->roc_sso);
 	struct dev *dev = &sso->dev;
@@ -217,6 +217,7 @@ roc_tim_lf_config(struct roc_tim *roc_tim, uint8_t ring_id, enum roc_tim_clk_src
 	req->interval_hi = interval >> 32;
 	req->intervalns = intervalns;
 	req->clockfreq = clockfreq;
+	req->priority = prio;
 	req->gpioedge = TIM_GPIO_LTOH_TRANS;
 
 	rc = mbox_process(mbox);
diff --git a/drivers/common/cnxk/roc_tim.h b/drivers/common/cnxk/roc_tim.h
index 2eb6e6962bd1..d6302585f37e 100644
--- a/drivers/common/cnxk/roc_tim.h
+++ b/drivers/common/cnxk/roc_tim.h
@@ -47,8 +47,8 @@ int __roc_api roc_tim_lf_enable(struct roc_tim *roc_tim, uint8_t ring_id,
 int __roc_api roc_tim_lf_disable(struct roc_tim *roc_tim, uint8_t ring_id);
 int __roc_api roc_tim_lf_config(struct roc_tim *roc_tim, uint8_t ring_id,
 				enum roc_tim_clk_src clk_src, uint8_t ena_periodic, uint8_t ena_dfb,
-				uint32_t bucket_sz, uint32_t chunk_sz, uint64_t interval,
-				uint64_t intervalns, uint64_t clockfreq);
+				uint8_t prio, uint32_t bucket_sz, uint32_t chunk_sz,
+				uint64_t interval, uint64_t intervalns, uint64_t clockfreq);
 int __roc_api roc_tim_lf_config_hwwqe(struct roc_tim *roc_tim, uint8_t ring_id,
 				      struct roc_tim_hwwqe_cfg *cfg);
 int __roc_api roc_tim_lf_interval(struct roc_tim *roc_tim,
diff --git a/drivers/event/cnxk/cnxk_tim_evdev.c b/drivers/event/cnxk/cnxk_tim_evdev.c
index 8cdb8a72dd3c..75414408776d 100644
--- a/drivers/event/cnxk/cnxk_tim_evdev.c
+++ b/drivers/event/cnxk/cnxk_tim_evdev.c
@@ -18,6 +18,7 @@ cnxk_tim_chnk_pool_create(struct cnxk_tim_ring *tim_ring,
 {
 	unsigned int mp_flags = 0;
 	unsigned int cache_sz;
+	const char *ops;
 	char pool_name[25];
 	int rc;
 
@@ -33,41 +34,43 @@ cnxk_tim_chnk_pool_create(struct cnxk_tim_ring *tim_ring,
 
 	cache_sz = CNXK_TIM_MAX_POOL_CACHE_SZ;
 	tim_ring->nb_chunks += (cache_sz * rte_lcore_count());
-	if (!tim_ring->disable_npa) {
-		tim_ring->chunk_pool = rte_mempool_create_empty(
-			pool_name, tim_ring->nb_chunks, tim_ring->chunk_sz,
-			cache_sz, 0, rte_socket_id(), mp_flags);
 
-		if (tim_ring->chunk_pool == NULL) {
-			plt_err("Unable to create chunkpool.");
-			return -ENOMEM;
-		}
+	tim_ring->chunk_pool = rte_mempool_create_empty(pool_name, tim_ring->nb_chunks,
+							tim_ring->chunk_sz, cache_sz, 0,
+							rte_socket_id(), mp_flags);
+	if (tim_ring->chunk_pool == NULL) {
+		plt_err("Unable to create chunkpool.");
+		return -ENOMEM;
+	}
 
-		rc = rte_mempool_set_ops_byname(tim_ring->chunk_pool,
-						rte_mbuf_platform_mempool_ops(),
-						NULL);
-		if (rc < 0) {
-			plt_err("Unable to set chunkpool ops");
-			goto free;
-		}
+	/* cn20k needs 256B-aligned chunk buffers (cn20k-tim 14.2). */
+	if (roc_model_is_cn20k())
+		tim_ring->chunk_pool->header_size = RTE_ALIGN_CEIL(
+			tim_ring->chunk_pool->header_size, CNXK_TIM_CN20K_CHUNK_BUF_ALIGN);
 
-		rc = rte_mempool_populate_default(tim_ring->chunk_pool);
-		if (rc < 0) {
-			plt_err("Unable to set populate chunkpool.");
-			goto free;
-		}
-		tim_ring->aura = roc_npa_aura_handle_to_aura(
-			tim_ring->chunk_pool->pool_id);
+	if (!tim_ring->disable_npa)
+		ops = rte_mbuf_platform_mempool_ops();
+	else if (mp_flags & RTE_MEMPOOL_F_SP_PUT)
+		ops = "ring_sp_sc";
+	else
+		ops = "ring_mp_mc";
+
+	rc = rte_mempool_set_ops_byname(tim_ring->chunk_pool, ops, NULL);
+	if (rc < 0) {
+		plt_err("Unable to set chunkpool ops");
+		goto free;
+	}
+
+	rc = rte_mempool_populate_default(tim_ring->chunk_pool);
+	if (rc < 0) {
+		plt_err("Unable to populate chunkpool.");
+		goto free;
+	}
+
+	if (!tim_ring->disable_npa) {
+		tim_ring->aura = roc_npa_aura_handle_to_aura(tim_ring->chunk_pool->pool_id);
 		tim_ring->ena_dfb = tim_ring->ena_periodic ? 1 : 0;
 	} else {
-		tim_ring->chunk_pool = rte_mempool_create(
-			pool_name, tim_ring->nb_chunks, tim_ring->chunk_sz,
-			cache_sz, 0, NULL, NULL, NULL, NULL, rte_socket_id(),
-			mp_flags);
-		if (tim_ring->chunk_pool == NULL) {
-			plt_err("Unable to create chunkpool.");
-			return -ENOMEM;
-		}
 		tim_ring->ena_dfb = 1;
 	}
 
@@ -250,6 +253,10 @@ cnxk_tim_ring_create(struct rte_event_timer_adapter *adptr)
 		}
 	}
 
+	if (roc_model_is_cn20k())
+		tim_ring->chunk_sz =
+			RTE_ALIGN_CEIL(tim_ring->chunk_sz, CNXK_TIM_CN20K_CHUNK_BUF_ALIGN);
+
 	if (!dev->tim.feat.hwwqe && tim_ring->disable_npa) {
 		tim_ring->nb_chunks =
 			tim_ring->nb_timers /
@@ -274,7 +281,7 @@ cnxk_tim_ring_create(struct rte_event_timer_adapter *adptr)
 		goto tim_bkt_free;
 
 	rc = roc_tim_lf_config(&dev->tim, tim_ring->ring_id, clk_src,
-			       tim_ring->ena_periodic, tim_ring->ena_dfb,
+			       tim_ring->ena_periodic, tim_ring->ena_dfb, 0,
 			       tim_ring->nb_bkts, tim_ring->chunk_sz,
 			       tim_ring->tck_int, tim_ring->tck_nsec, clk_freq);
 	if (rc < 0) {
@@ -282,7 +289,7 @@ cnxk_tim_ring_create(struct rte_event_timer_adapter *adptr)
 		goto tim_chnk_free;
 	}
 
-	if (dev->tim.feat.hwwqe) {
+	if (dev->tim.feat.hwwqe && dev->tim.feat.hwwqe_ver != TIM_HWWQE_VER_0) {
 		rc = cnxk_tim_enable_hwwqe(dev, tim_ring);
 		if (rc < 0) {
 			plt_err("Failed to enable hwwqe");
diff --git a/drivers/event/cnxk/cnxk_tim_evdev.h b/drivers/event/cnxk/cnxk_tim_evdev.h
index 114a89ee5aec..83e9cfd458fb 100644
--- a/drivers/event/cnxk/cnxk_tim_evdev.h
+++ b/drivers/event/cnxk/cnxk_tim_evdev.h
@@ -25,6 +25,7 @@
 #define CNXK_TIM_MAX_BUCKETS	    (0xFFFFF)
 #define CNXK_TIM_RING_DEF_CHUNK_SZ  (1024)
 #define CNXK_TIM_CHUNK_ALIGNMENT    (16)
+#define CNXK_TIM_CN20K_CHUNK_BUF_ALIGN (256)
 #define CNXK_TIM_MAX_BURST	    (16)
 #define CNXK_TIM_NB_CHUNK_SLOTS(sz) (((sz) / CNXK_TIM_CHUNK_ALIGNMENT) - 1)
 #define CNXK_TIM_MIN_CHUNK_SLOTS    (0x1)
diff --git a/drivers/event/cnxk/cnxk_tim_worker.h b/drivers/event/cnxk/cnxk_tim_worker.h
index 09f84091abba..6a9099a23f3a 100644
--- a/drivers/event/cnxk/cnxk_tim_worker.h
+++ b/drivers/event/cnxk/cnxk_tim_worker.h
@@ -625,14 +625,15 @@ cnxk_tim_add_entry_hwwqe(struct cnxk_tim_ring *const tim_ring, struct rte_event_
 	rsp >>= 4;
 	switch (rsp) {
 	case 0x3:
-		tim->state = RTE_EVENT_TIMER_ERROR_TOOEARLY;
+		tim->state = RTE_EVENT_TIMER_ERROR_TOOLATE;
 		rc = !rc;
 		break;
 	case 0x4:
-		tim->state = RTE_EVENT_TIMER_ERROR_TOOLATE;
+		tim->state = RTE_EVENT_TIMER_ERROR_TOOEARLY;
 		rc = !rc;
 		break;
 	case 0x1:
+	case 0x5:
 		tim->state = RTE_EVENT_TIMER_ARMED;
 		break;
 	default:
-- 
2.50.1 (Apple Git-155)

