Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708AFC54E65
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 11:15:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 703B6427B0;
	Wed, 21 May 2025 13:15:08 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id CD384427AC
 for <dev@dpdk.org>; Wed, 21 May 2025 13:15:06 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b2TGt2pDHz6DB40;
 Wed, 21 May 2025 19:10:14 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id B3E5614020A;
 Wed, 21 May 2025 19:15:05 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 May 2025 13:15:05 +0200
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: <dev@dpdk.org>
CC: <honnappa.nagarahalli@arm.com>, <jerinj@marvell.com>,
 <hemant.agrawal@nxp.com>, <drc@linux.ibm.com>
Subject: [PATCH v1 1/4] ring: introduce extra run-time checks
Date: Wed, 21 May 2025 12:14:29 +0100
Message-ID: <20250521111432.207936-2-konstantin.ananyev@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521111432.207936-1-konstantin.ananyev@huawei.com>
References: <20250521111432.207936-1-konstantin.ananyev@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapeml100004.china.huawei.com (7.182.85.167) To
 frapeml500007.china.huawei.com (7.182.85.172)
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

Add RTE_ASSERT() to check that different move_tail() flavors
return meaningful  *entries value.
It also helps to ensure that inside move_tail(), it uses correct
head/tail values.

Signed-off-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 lib/ring/rte_ring_c11_pvt.h      | 2 +-
 lib/ring/rte_ring_elem_pvt.h     | 8 ++++++--
 lib/ring/rte_ring_hts_elem_pvt.h | 8 ++++++--
 lib/ring/rte_ring_rts_elem_pvt.h | 8 ++++++--
 lib/ring/soring.c                | 2 ++
 5 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/lib/ring/rte_ring_c11_pvt.h b/lib/ring/rte_ring_c11_pvt.h
index b9388af0da..0845cd6dcf 100644
--- a/lib/ring/rte_ring_c11_pvt.h
+++ b/lib/ring/rte_ring_c11_pvt.h
@@ -104,10 +104,10 @@ __rte_ring_headtail_move_head(struct rte_ring_headtail *d,
 			n = (behavior == RTE_RING_QUEUE_FIXED) ?
 					0 : *entries;
 
+		*new_head = *old_head + n;
 		if (n == 0)
 			return 0;
 
-		*new_head = *old_head + n;
 		if (is_st) {
 			d->head = *new_head;
 			success = 1;
diff --git a/lib/ring/rte_ring_elem_pvt.h b/lib/ring/rte_ring_elem_pvt.h
index 6eafae121f..2e71040830 100644
--- a/lib/ring/rte_ring_elem_pvt.h
+++ b/lib/ring/rte_ring_elem_pvt.h
@@ -341,8 +341,10 @@ __rte_ring_move_prod_head(struct rte_ring *r, unsigned int is_sp,
 		uint32_t *old_head, uint32_t *new_head,
 		uint32_t *free_entries)
 {
-	return __rte_ring_headtail_move_head(&r->prod, &r->cons, r->capacity,
+	n = __rte_ring_headtail_move_head(&r->prod, &r->cons, r->capacity,
 			is_sp, n, behavior, old_head, new_head, free_entries);
+	RTE_ASSERT(*free_entries <= r->capacity);
+	return n;
 }
 
 /**
@@ -374,8 +376,10 @@ __rte_ring_move_cons_head(struct rte_ring *r, unsigned int is_sc,
 		uint32_t *old_head, uint32_t *new_head,
 		uint32_t *entries)
 {
-	return __rte_ring_headtail_move_head(&r->cons, &r->prod, 0,
+	n = __rte_ring_headtail_move_head(&r->cons, &r->prod, 0,
 			is_sc, n, behavior, old_head, new_head, entries);
+	RTE_ASSERT(*entries <= r->capacity);
+	return n;
 }
 
 /**
diff --git a/lib/ring/rte_ring_hts_elem_pvt.h b/lib/ring/rte_ring_hts_elem_pvt.h
index e2b82dd1e6..c59e5f6420 100644
--- a/lib/ring/rte_ring_hts_elem_pvt.h
+++ b/lib/ring/rte_ring_hts_elem_pvt.h
@@ -136,8 +136,10 @@ __rte_ring_hts_move_prod_head(struct rte_ring *r, unsigned int num,
 	enum rte_ring_queue_behavior behavior, uint32_t *old_head,
 	uint32_t *free_entries)
 {
-	return __rte_ring_hts_move_head(&r->hts_prod, &r->cons,
+	num = __rte_ring_hts_move_head(&r->hts_prod, &r->cons,
 			r->capacity, num, behavior, old_head, free_entries);
+	RTE_ASSERT(*free_entries <= r->capacity);
+	return num;
 }
 
 /**
@@ -148,8 +150,10 @@ __rte_ring_hts_move_cons_head(struct rte_ring *r, unsigned int num,
 	enum rte_ring_queue_behavior behavior, uint32_t *old_head,
 	uint32_t *entries)
 {
-	return __rte_ring_hts_move_head(&r->hts_cons, &r->prod,
+	num = __rte_ring_hts_move_head(&r->hts_cons, &r->prod,
 			0, num, behavior, old_head, entries);
+	RTE_ASSERT(*entries <= r->capacity);
+	return num;
 }
 
 /**
diff --git a/lib/ring/rte_ring_rts_elem_pvt.h b/lib/ring/rte_ring_rts_elem_pvt.h
index 96825931f8..509fa674fb 100644
--- a/lib/ring/rte_ring_rts_elem_pvt.h
+++ b/lib/ring/rte_ring_rts_elem_pvt.h
@@ -152,8 +152,10 @@ __rte_ring_rts_move_prod_head(struct rte_ring *r, uint32_t num,
 	enum rte_ring_queue_behavior behavior, uint32_t *old_head,
 	uint32_t *free_entries)
 {
-	return __rte_ring_rts_move_head(&r->rts_prod, &r->cons,
+	num = __rte_ring_rts_move_head(&r->rts_prod, &r->cons,
 			r->capacity, num, behavior, old_head, free_entries);
+	RTE_ASSERT(*free_entries <= r->capacity);
+	return num;
 }
 
 /**
@@ -164,8 +166,10 @@ __rte_ring_rts_move_cons_head(struct rte_ring *r, uint32_t num,
 	enum rte_ring_queue_behavior behavior, uint32_t *old_head,
 	uint32_t *entries)
 {
-	return __rte_ring_rts_move_head(&r->rts_cons, &r->prod,
+	num = __rte_ring_rts_move_head(&r->rts_cons, &r->prod,
 			0, num, behavior, old_head, entries);
+	RTE_ASSERT(*entries <= r->capacity);
+	return num;
 }
 
 /**
diff --git a/lib/ring/soring.c b/lib/ring/soring.c
index 797484d6bf..21a1a27e24 100644
--- a/lib/ring/soring.c
+++ b/lib/ring/soring.c
@@ -156,6 +156,7 @@ __rte_soring_move_prod_head(struct rte_soring *r, uint32_t num,
 		n = 0;
 	}
 
+	RTE_ASSERT(*free <= r->capacity);
 	return n;
 }
 
@@ -190,6 +191,7 @@ __rte_soring_move_cons_head(struct rte_soring *r, uint32_t stage, uint32_t num,
 		n = 0;
 	}
 
+	RTE_ASSERT(*avail <= r->capacity);
 	return n;
 }
 
-- 
2.43.0

