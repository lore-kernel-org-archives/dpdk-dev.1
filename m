Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B7BF99C63
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Apr 2026 21:24:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD5804064E;
	Fri, 17 Apr 2026 23:24:49 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 686E240655
 for <dev@dpdk.org>; Fri, 17 Apr 2026 23:24:48 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fy7DJ3X8vzJ4680;
 Sat, 18 Apr 2026 05:24:00 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (unknown [7.214.147.241])
 by mail.maildlp.com (Postfix) with ESMTPS id 7735140569;
 Sat, 18 Apr 2026 05:24:47 +0800 (CST)
Received: from localhost (10.220.239.45) by dubpeml500001.china.huawei.com
 (7.214.147.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 17 Apr
 2026 22:24:46 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: <dev@dpdk.org>
CC: <wathsala.vithanage@arm.com>
Subject: [PATCH v3 2/2] ring: introduce peek API for soring
Date: Fri, 17 Apr 2026 22:23:58 +0100
Message-ID: <20260417212358.212692-3-konstantin.ananyev@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260417212358.212692-1-konstantin.ananyev@huawei.com>
References: <20260416191440.208066-1-konstantin.ananyev@huawei.com>
 <20260417212358.212692-1-konstantin.ananyev@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema100007.china.huawei.com (7.182.19.38) To
 dubpeml500001.china.huawei.com (7.214.147.241)
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

Follow the same pattern as conventional rte_ring and introduce peek API
for soring too.
Basically it provides similar functionality and similar opportunities
for the user, while similar constraints remain - only rings with
certain sync types are supported:
1) Single Producer/Single Consumer (RTE_RING_SYNC_ST)
2) Serialized Producer/Serialized Consumer (RTE_RING_SYNC_MT_HTS).

Signed-off-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 app/test/meson.build                   |   1 +
 app/test/test_soring_mt_stress.c       |  74 +++++++
 app/test/test_soring_peek_stress.c     |  75 +++++++
 app/test/test_soring_stress.c          |   3 +
 app/test/test_soring_stress.h          |   1 +
 app/test/test_soring_stress_impl.h     |  87 +-------
 doc/guides/rel_notes/release_26_07.rst |   8 +
 lib/ring/rte_soring.h                  | 264 +++++++++++++++++++++++++
 lib/ring/soring.c                      | 237 +++++++++++++++++++++-
 9 files changed, 660 insertions(+), 90 deletions(-)
 create mode 100644 app/test/test_soring_peek_stress.c

diff --git a/app/test/meson.build b/app/test/meson.build
index 7d458f9c07..033eaebb80 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -185,6 +185,7 @@ source_file_deps = {
     'test_service_cores.c': [],
     'test_soring.c': [],
     'test_soring_mt_stress.c': [],
+    'test_soring_peek_stress.c': [],
     'test_soring_stress.c': [],
     'test_spinlock.c': [],
     'test_stack.c': ['stack'],
diff --git a/app/test/test_soring_mt_stress.c b/app/test/test_soring_mt_stress.c
index 2f90bb4598..b4493b19de 100644
--- a/app/test/test_soring_mt_stress.c
+++ b/app/test/test_soring_mt_stress.c
@@ -33,8 +33,82 @@ _st_ring_release(struct rte_soring *r, uint32_t stage, uint32_t token,
 	rte_soring_release(r, NULL, stage, num, token);
 }
 
+static const struct test_case tests[] = {
+	{
+		.name = "MT_DEQENQ-MT_STG1-PRCS",
+		.func = test_sym_mt1,
+		.wfunc = test_worker_prcs,
+	},
+	{
+		.name = "MT_DEQENQ-MT_STG1-AVG",
+		.func = test_sym_mt1,
+		.wfunc = test_worker_avg,
+	},
+	{
+		.name = "MT_DEQENQ-MT_STG4-PRCS",
+		.func = test_sym_mt4,
+		.wfunc = test_worker_prcs,
+	},
+	{
+		.name = "MT_DEQENQ-MT_STG4-AVG",
+		.func = test_sym_mt4,
+		.wfunc = test_worker_avg,
+	},
+	{
+		.name = "MTRTS_DEQENQ-MT_STG4-PRCS",
+		.func = test_sym_mt_rts4,
+		.wfunc = test_worker_prcs,
+	},
+	{
+		.name = "MTRTS_DEQENQ-MT_STG4-AVG",
+		.func = test_sym_mt_rts4,
+		.wfunc = test_worker_avg,
+	},
+	{
+		.name = "MTHTS_DEQENQ-MT_STG4-PRCS",
+		.func = test_sym_mt_hts4,
+		.wfunc = test_worker_prcs,
+	},
+	{
+		.name = "MTHTS_DEQENQ-MT_STG4-AVG",
+		.func = test_sym_mt_hts4,
+		.wfunc = test_worker_avg,
+	},
+	{
+		.name = "MT_DEQENQ-MT_STG5-1:1-PRCS",
+		.func = test_even_odd_mt5,
+		.wfunc = test_worker_prcs,
+	},
+	{
+		.name = "MT_DEQENQ-MT_STG5-1:1-AVG",
+		.func = test_even_odd_mt5,
+		.wfunc = test_worker_avg,
+	},
+	{
+		.name = "MT_DEQENQ-MT_STG3-1:3-PRCS",
+		.func = test_div_mt3,
+		.wfunc = test_worker_prcs,
+	},
+	{
+		.name = "MT_DEQENQ_MT_STG3-1:3-AVG",
+		.func = test_div_mt3,
+		.wfunc = test_worker_avg,
+	},
+	{
+		.name = "ST_DEQENQ-MT_STG4-PRCS",
+		.func = test_stdenq_stage4,
+		.wfunc = test_worker_prcs,
+	},
+	{
+		.name = "ST_DEQENQ-MT_STG4-AVG",
+		.func = test_stdenq_stage4,
+		.wfunc = test_worker_avg,
+	},
+};
+
 const struct test test_soring_mt_stress = {
 	.name = "MT",
 	.nb_case = RTE_DIM(tests),
 	.cases = tests,
 };
+
diff --git a/app/test/test_soring_peek_stress.c b/app/test/test_soring_peek_stress.c
new file mode 100644
index 0000000000..6ac638f8d7
--- /dev/null
+++ b/app/test/test_soring_peek_stress.c
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 Huawei Technologies Co., Ltd
+ */
+
+#include "test_soring_stress_impl.h"
+
+static inline uint32_t
+_st_ring_dequeue_burst(struct rte_soring *r, void **obj, uint32_t n,
+	uint32_t *avail)
+{
+	uint32_t m;
+
+	m = rte_soring_dequeue_burst_start(r, obj, n, avail);
+	if (m != 0)
+		rte_soring_dequeue_finish(r, m);
+	return m;
+}
+
+static inline uint32_t
+_st_ring_enqueue_bulk(struct rte_soring *r, void * const *obj, uint32_t n,
+	uint32_t *free)
+{
+	uint32_t m;
+
+	m = rte_soring_enqueue_bulk_start(r, n, free);
+	if (m != 0)
+		rte_soring_enqueue_finish(r, obj, m);
+	return m;
+}
+
+static inline uint32_t
+_st_ring_acquire_burst(struct rte_soring *r, uint32_t stage, void **obj,
+	uint32_t num, uint32_t *token, uint32_t *avail)
+{
+	return rte_soring_acquire_burst(r, obj, stage, num, token, avail);
+}
+
+static inline void
+_st_ring_release(struct rte_soring *r, uint32_t stage, uint32_t token,
+	void * const *obj, uint32_t num)
+{
+	RTE_SET_USED(obj);
+	rte_soring_release(r, NULL, stage, num, token);
+}
+
+static const struct test_case tests[] = {
+
+	{
+		.name = "MTHTS_DEQENQ-MT_STG4-PRCS",
+		.func = test_sym_mt_hts4,
+		.wfunc = test_worker_prcs,
+	},
+	{
+		.name = "MTHTS_DEQENQ-MT_STG4-AVG",
+		.func = test_sym_mt_hts4,
+		.wfunc = test_worker_avg,
+	},
+	{
+		.name = "ST_DEQENQ-MT_STG4-PRCS",
+		.func = test_stdenq_stage4,
+		.wfunc = test_worker_prcs,
+	},
+	{
+		.name = "ST_DEQENQ-MT_STG4-AVG",
+		.func = test_stdenq_stage4,
+		.wfunc = test_worker_avg,
+	},
+};
+
+const struct test test_soring_peek_stress = {
+	.name = "PEEK",
+	.nb_case = RTE_DIM(tests),
+	.cases = tests,
+};
+
diff --git a/app/test/test_soring_stress.c b/app/test/test_soring_stress.c
index e5655d49cb..f8fda64378 100644
--- a/app/test/test_soring_stress.c
+++ b/app/test/test_soring_stress.c
@@ -37,6 +37,9 @@ test_ring_stress(void)
 	n = 0;
 	k = 0;
 
+	n += test_soring_peek_stress.nb_case;
+	k += run_test(&test_soring_peek_stress);
+
 	n += test_soring_mt_stress.nb_case;
 	k += run_test(&test_soring_mt_stress);
 
diff --git a/app/test/test_soring_stress.h b/app/test/test_soring_stress.h
index 2341cc9f83..f988244410 100644
--- a/app/test/test_soring_stress.h
+++ b/app/test/test_soring_stress.h
@@ -32,3 +32,4 @@ struct test {
 };
 
 extern const struct test test_soring_mt_stress;
+extern const struct test test_soring_peek_stress;
diff --git a/app/test/test_soring_stress_impl.h b/app/test/test_soring_stress_impl.h
index 015825223d..0efc7e46a0 100644
--- a/app/test/test_soring_stress_impl.h
+++ b/app/test/test_soring_stress_impl.h
@@ -683,7 +683,7 @@ role_mask_denq_st(uint32_t nb_stage, uint32_t role_mask[RTE_MAX_LCORE])
 }
 
 
-static int
+static int __rte_unused
 test_sym_mt1(int (*test)(void *))
 {
 	uint32_t role_mask[RTE_MAX_LCORE];
@@ -694,7 +694,7 @@ test_sym_mt1(int (*test)(void *))
 			nb_stage, role_mask);
 }
 
-static int
+static int __rte_unused
 test_sym_mt4(int (*test)(void *))
 {
 	uint32_t role_mask[RTE_MAX_LCORE];
@@ -706,7 +706,7 @@ test_sym_mt4(int (*test)(void *))
 			nb_stage, role_mask);
 }
 
-static int
+static int __rte_unused
 test_sym_mt_rts4(int (*test)(void *))
 {
 	uint32_t role_mask[RTE_MAX_LCORE];
@@ -718,7 +718,7 @@ test_sym_mt_rts4(int (*test)(void *))
 			nb_stage, role_mask);
 }
 
-static int
+static int __rte_unused
 test_sym_mt_hts4(int (*test)(void *))
 {
 	uint32_t role_mask[RTE_MAX_LCORE];
@@ -730,7 +730,7 @@ test_sym_mt_hts4(int (*test)(void *))
 			nb_stage, role_mask);
 }
 
-static int
+static int __rte_unused
 test_stdenq_stage4(int (*test)(void *))
 {
 	uint32_t role_mask[RTE_MAX_LCORE];
@@ -743,7 +743,7 @@ test_stdenq_stage4(int (*test)(void *))
 }
 
 
-static int
+static int __rte_unused
 test_even_odd_mt5(int (*test)(void *))
 {
 	uint32_t role_mask[RTE_MAX_LCORE];
@@ -755,7 +755,7 @@ test_even_odd_mt5(int (*test)(void *))
 			nb_stage, role_mask);
 }
 
-static int
+static int __rte_unused
 test_div_mt3(int (*test)(void *))
 {
 	uint32_t role_mask[RTE_MAX_LCORE];
@@ -766,76 +766,3 @@ test_div_mt3(int (*test)(void *))
 	return test_mt(test, RTE_RING_SYNC_MT, RTE_RING_SYNC_MT,
 			nb_stage, role_mask);
 }
-
-static const struct test_case tests[] = {
-	{
-		.name = "MT_DEQENQ-MT_STG1-PRCS",
-		.func = test_sym_mt1,
-		.wfunc = test_worker_prcs,
-	},
-	{
-		.name = "MT_DEQENQ-MT_STG1-AVG",
-		.func = test_sym_mt1,
-		.wfunc = test_worker_avg,
-	},
-	{
-		.name = "MT_DEQENQ-MT_STG4-PRCS",
-		.func = test_sym_mt4,
-		.wfunc = test_worker_prcs,
-	},
-	{
-		.name = "MT_DEQENQ-MT_STG4-AVG",
-		.func = test_sym_mt4,
-		.wfunc = test_worker_avg,
-	},
-	{
-		.name = "MTRTS_DEQENQ-MT_STG4-PRCS",
-		.func = test_sym_mt_rts4,
-		.wfunc = test_worker_prcs,
-	},
-	{
-		.name = "MTRTS_DEQENQ-MT_STG4-AVG",
-		.func = test_sym_mt_rts4,
-		.wfunc = test_worker_avg,
-	},
-	{
-		.name = "MTHTS_DEQENQ-MT_STG4-PRCS",
-		.func = test_sym_mt_hts4,
-		.wfunc = test_worker_prcs,
-	},
-	{
-		.name = "MTHTS_DEQENQ-MT_STG4-AVG",
-		.func = test_sym_mt_hts4,
-		.wfunc = test_worker_avg,
-	},
-	{
-		.name = "MT_DEQENQ-MT_STG5-1:1-PRCS",
-		.func = test_even_odd_mt5,
-		.wfunc = test_worker_prcs,
-	},
-	{
-		.name = "MT_DEQENQ-MT_STG5-1:1-AVG",
-		.func = test_even_odd_mt5,
-		.wfunc = test_worker_avg,
-	},
-	{
-		.name = "MT_DEQENQ-MT_STG3-1:3-PRCS",
-		.func = test_div_mt3,
-		.wfunc = test_worker_prcs,
-	},
-	{
-		.name = "MT_DEQENQ_MT_STG3-1:3-AVG",
-		.func = test_div_mt3,
-		.wfunc = test_worker_avg,
-	},
-	{
-		.name = "ST_DEQENQ-MT_STG4-PRCS",
-		.func = test_stdenq_stage4,
-		.wfunc = test_worker_prcs,
-	},
-	{
-		.name = "ST_DEQENQ-MT_STG4-AVG",
-		.func = test_stdenq_stage4,
-		.wfunc = test_worker_avg,
-	},
-};
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index f012d47a4b..313f00f6df 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -63,6 +63,14 @@ New Features
     ``rte_eal_init`` and the application is responsible for probing each device,
   * ``--auto-probing`` enables the initial bus probing, which is the current default behavior.
 
+* **Added peek style API for ``rte_soring``.**
+
+  For sorings with producer/consumer in ``RTE_RING_SYNC_ST``,
+  ``RTE_RING_SYNC_MT_HTS`` mode, provide the ability to split enqueue/dequeue
+  operation into two phases (enqueue/dequeue start and enqueue/dequeue finish).
+  This allows the user to inspect objects in the ring without removing them
+  (aka MT safe peek).
+
 
 Removed Items
 -------------
diff --git a/lib/ring/rte_soring.h b/lib/ring/rte_soring.h
index 95c3cc4080..16f042e612 100644
--- a/lib/ring/rte_soring.h
+++ b/lib/ring/rte_soring.h
@@ -607,6 +607,270 @@ void
 rte_soring_releasx(struct rte_soring *r, const void *objs,
 	const void *meta, uint32_t stage, uint32_t n, uint32_t ftoken);
 
+/**
+ * SORING Peek API
+ * Same as with rte_ring, for some sync modes it is possible to split
+ * public enqueue/dequeue API into two phases:
+ * - enqueue/dequeue start
+ * - enqueue/dequeue finish
+ * That allows user to inspect objects in the soring without removing them
+ * from it (aka MT safe peek).
+ * Note that right now this new API is available only for two sync modes:
+ * 1) Single Producer/Single Consumer (RTE_RING_SYNC_ST)
+ * 2) Serialized Producer/Serialized Consumer (RTE_RING_SYNC_MT_HTS).
+ * It is a user responsibility to create/init soring with appropriate sync
+ * modes selected for enqueue/dequeue.
+ * For more information, please refer to corresping rte_ring peek API.
+ */
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Start to enqueue excact number of objects on the soring.
+ * Note that no actual objects are put in the queue by this function,
+ * it just reserves for user such ability.
+ * User has to call appropriate enqueue_elem_finish() to copy objects into the
+ * queue and complete given enqueue operation.
+ *
+ * @param r
+ *   A pointer to the soring structure.
+ * @param n
+ *   The number of objects to add in the soring.
+ * @param free_space
+ *   if non-NULL, returns the amount of space in the soring after the
+ *   enqueue operation has finished.
+ * @return
+ *   - Actual number of objects enqueued, either 0 or n.
+ */
+__rte_experimental
+uint32_t
+rte_soring_enqueue_bulk_start(struct rte_soring *r, uint32_t n,
+	uint32_t *free_space);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Start to enqueue several objects (up to 'n') on the soring.
+ * Note that no actual objects are put in the queue by this function,
+ * it just reserves for user such ability.
+ * User has to call appropriate enqueue_elem_finish() to copy objects into the
+ * queue and complete given enqueue operation.
+ *
+ * @param r
+ *   A pointer to the soring structure.
+ * @param n
+ *   The number of objects to add in the soring.
+ * @param free_space
+ *   if non-NULL, returns the amount of space in the soring after the
+ *   enqueue operation has finished.
+ * @return
+ *   - Actual number of objects enqueued.
+ */
+__rte_experimental
+uint32_t
+rte_soring_enqueue_burst_start(struct rte_soring *r, uint32_t n,
+	uint32_t *free_space);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Complete to enqueue several objects plus metadata on the soring.
+ * Note that number of objects to enqueue should not exceed previous
+ * enqueue_start return value.
+ *
+ * @param r
+ *   A pointer to the soring structure.
+ * @param objs
+ *   A pointer to an array of objects to enqueue.
+ *   Size of objects to enqueue must be the same value as 'elem_size' parameter
+ *   used while creating the soring. Otherwise the results are undefined.
+ * @param n
+ *   The number of objects to add in the soring from the 'objs'.
+ */
+__rte_experimental
+void
+rte_soring_enqueue_finish(struct rte_soring *r, const void *objs, uint32_t n);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Complete to enqueue several objects plus metadata on the soring.
+ * Note that number of objects to enqueue should not exceed previous
+ * enqueue_start return value.
+ *
+ * @param r
+ *   A pointer to the soring structure.
+ * @param objs
+ *   A pointer to an array of objects to enqueue.
+ *   Size of objects to enqueue must be the same value as 'elem_size' parameter
+ *   used while creating the soring. Otherwise the results are undefined.
+ * @param meta
+ *   A pointer to an array of metadata values for each object to enqueue.
+ *   Note that if user not using object metadata values, then this parameter
+ *   can be NULL.
+ *   Size of elements in this array must be the same value as 'meta_size'
+ *   parameter used while creating the soring. If user created the soring with
+ *   'meta_size' value equals zero, then 'meta' parameter should be NULL.
+ *   Otherwise the results are undefined.
+ * @param n
+ *   The number of objects to add in the soring from the 'objs'.
+ */
+__rte_experimental
+void
+rte_soring_enqueux_finish(struct rte_soring *r, const void *objs,
+	const void *meta, uint32_t n);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Start to dequeue several objects plus metadata from the soring.
+ * Dequeues exactly requested number of objects or none.
+ * Note that user has to call appropriate dequeue_finish()
+ * to complete given dequeue operation and actually remove objects from
+ * the soring.
+ *
+ * @param r
+ *   A pointer to the soring structure.
+ * @param objs
+ *   A pointer to an array of objects to dequeue.
+ *   Size of objects to enqueue must be the same value as 'elem_size' parameter
+ *   used while creating the soring. Otherwise the results are undefined.
+ * @param num
+ *   The number of objects to dequeue from the soring into the objs.
+ * @param available
+ *   If non-NULL, returns the number of remaining soring entries after the
+ *   dequeue has finished.
+ * @return
+ *   - Actual number of objects dequeued, either 0 or 'num'.
+ */
+__rte_experimental
+uint32_t
+rte_soring_dequeue_bulk_start(struct rte_soring *r, void *objs, uint32_t num,
+	uint32_t *available);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Start to dequeue several objects plus metadata from the soring.
+ * Dequeues exactly requested number of objects or none.
+ * Note that user has to call appropriate dequeue_finish()
+ * to complete given dequeue operation and actually remove objects from
+ * the soring.
+ *
+ * @param r
+ *   A pointer to the soring structure.
+ * @param objs
+ *   A pointer to an array of objects to dequeue.
+ *   Size of objects to enqueue must be the same value as 'elem_size' parameter
+ *   used while creating the soring. Otherwise the results are undefined.
+ * @param meta
+ *   A pointer to array of metadata values for each object to dequeue.
+ *   Note that if user not using object metadata values, then this parameter
+ *   can be NULL.
+ *   Size of elements in this array must be the same value as 'meta_size'
+ *   parameter used while creating the soring. If user created the soring with
+ *   'meta_size' value equals zero, then 'meta' parameter should be NULL.
+ *   Otherwise the results are undefined.
+ * @param num
+ *   The number of objects to dequeue from the soring into the objs.
+ * @param available
+ *   If non-NULL, returns the number of remaining soring entries after the
+ *   dequeue has finished.
+ * @return
+ *   - Actual number of objects dequeued, either 0 or 'num'.
+ */
+__rte_experimental
+uint32_t
+rte_soring_dequeux_bulk_start(struct rte_soring *r, void *objs, void *meta,
+	uint32_t num, uint32_t *available);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Start to dequeue several objects plus metadata from the soring.
+ * Dequeues up to requested number of objects.
+ * Note that user has to call appropriate dequeue_finish()
+ * to complete given dequeue operation and actually remove objects from
+ * the soring.
+ *
+ * @param r
+ *   A pointer to the soring structure.
+ * @param objs
+ *   A pointer to an array of objects to dequeue.
+ *   Size of objects to enqueue must be the same value as 'elem_size' parameter
+ *   used while creating the soring. Otherwise the results are undefined.
+ * @param num
+ *   The number of objects to dequeue from the soring into the objs.
+ * @param available
+ *   If non-NULL, returns the number of remaining soring entries after the
+ *   dequeue has finished.
+ * @return
+ *   - Actual number of objects dequeued.
+ */
+__rte_experimental
+uint32_t
+rte_soring_dequeue_burst_start(struct rte_soring *r, void *objs, uint32_t num,
+	uint32_t *available);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Start to dequeue several objects plus metadata from the soring.
+ * Dequeues up to requested number of objects.
+ * Note that user has to call appropriate dequeue_finish()
+ * to complete given dequeue operation and actually remove objects from
+ * the soring.
+ *
+ * @param r
+ *   A pointer to the soring structure.
+ * @param objs
+ *   A pointer to an array of objects to dequeue.
+ *   Size of objects to enqueue must be the same value as 'elem_size' parameter
+ *   used while creating the soring. Otherwise the results are undefined.
+ * @param meta
+ *   A pointer to array of metadata values for each object to dequeue.
+ *   Note that if user not using object metadata values, then this parameter
+ *   can be NULL.
+ *   Size of elements in this array must be the same value as 'meta_size'
+ *   parameter used while creating the soring. If user created the soring with
+ *   'meta_size' value equals zero, then 'meta' parameter should be NULL.
+ *   Otherwise the results are undefined.
+ * @param num
+ *   The number of objects to dequeue from the soring into the objs.
+ * @param available
+ *   If non-NULL, returns the number of remaining soring entries after the
+ *   dequeue has finished.
+ * @return
+ *   - Actual number of objects dequeued.
+ */
+__rte_experimental
+uint32_t
+rte_soring_dequeux_burst_start(struct rte_soring *r, void *objs, void *meta,
+	uint32_t num, uint32_t *available);
+
+/**
+ * Complete to dequeue several objects from the soring.
+ * Note that number of objects to dequeue should not exceed previous
+ * dequeue_start return value.
+ *
+ * @param r
+ *   A pointer to the soring structure.
+ * @param num
+ *   The number of objects to remove from the soring.
+ */
+__rte_experimental
+void
+rte_soring_dequeue_finish(struct rte_soring *r, uint32_t num);
+
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/ring/soring.c b/lib/ring/soring.c
index fc7fc55a21..b7d0ad6da8 100644
--- a/lib/ring/soring.c
+++ b/lib/ring/soring.c
@@ -247,6 +247,28 @@ __rte_soring_stage_move_head(struct soring_stage_headtail *d,
 	return n;
 }
 
+static inline void
+__enqueue_elems(struct rte_soring *r, const void *objs, const void *meta,
+	uint32_t head, uint32_t n)
+{
+	__rte_ring_do_enqueue_elems(&r[1], objs, r->size, head & r->mask,
+		r->esize, n);
+	if (meta != NULL)
+		__rte_ring_do_enqueue_elems(r->meta, meta, r->size,
+			head & r->mask, r->msize, n);
+}
+
+static inline void
+__dequeue_elems(const struct rte_soring *r, void *objs,  void *meta,
+	uint32_t head, uint32_t n)
+{
+	__rte_ring_do_dequeue_elems(objs, &r[1], r->size, head & r->mask,
+			r->esize, n);
+	if (meta != NULL)
+		__rte_ring_do_dequeue_elems(meta, r->meta, r->size,
+			head & r->mask, r->msize, n);
+}
+
 static inline uint32_t
 soring_enqueue(struct rte_soring *r, const void *objs,
 	const void *meta, uint32_t n, enum rte_ring_queue_behavior behavior,
@@ -263,11 +285,7 @@ soring_enqueue(struct rte_soring *r, const void *objs,
 	n = __rte_soring_move_prod_head(r, n, behavior, st,
 			&prod_head, &prod_next, &nb_free);
 	if (n != 0) {
-		__rte_ring_do_enqueue_elems(&r[1], objs, r->size,
-			prod_head & r->mask, r->esize, n);
-		if (meta != NULL)
-			__rte_ring_do_enqueue_elems(r->meta, meta, r->size,
-				prod_head & r->mask, r->msize, n);
+		__enqueue_elems(r, objs, meta, prod_head, n);
 		__rte_soring_update_tail(&r->prod, st, prod_head, prod_next, 1);
 	}
 
@@ -276,6 +294,70 @@ soring_enqueue(struct rte_soring *r, const void *objs,
 	return n;
 }
 
+static inline uint32_t
+soring_enqueue_start(struct rte_soring *r, uint32_t num,
+	enum rte_ring_queue_behavior behavior, uint32_t *free_space)
+{
+	enum rte_ring_sync_type st;
+	uint32_t free, head, n, next;
+
+	RTE_ASSERT(r != NULL && r->nb_stage > 0);
+
+	st = r->prod.ht.sync_type;
+
+	switch (st) {
+	case RTE_RING_SYNC_ST:
+		n = __rte_ring_headtail_move_head(&r->prod.ht, &r->cons.ht,
+			r->capacity, RTE_RING_SYNC_ST, num, behavior,
+			&head, &next, &free);
+		break;
+	case RTE_RING_SYNC_MT_HTS:
+		n = __rte_ring_hts_move_head(&r->prod.hts, &r->cons.ht,
+			r->capacity, num, behavior, &head, &free);
+		break;
+	default:
+		/* unsupported mode, shouldn't be here */
+		RTE_ASSERT(0);
+		free = 0;
+		n = 0;
+	}
+
+	if (free_space != NULL)
+		*free_space = free - n;
+	return n;
+}
+
+static inline void
+soring_enqueue_finish(struct rte_soring *r, const void *objs, const void *meta,
+	uint32_t num)
+{
+	enum rte_ring_sync_type st;
+	uint32_t n, tail;
+
+	RTE_ASSERT(r != NULL && r->nb_stage > 0);
+	RTE_ASSERT(meta == NULL || r->meta != NULL);
+
+	st = r->prod.ht.sync_type;
+
+	switch (st) {
+	case RTE_RING_SYNC_ST:
+		n = __rte_ring_st_get_tail(&r->prod.ht, &tail, num);
+		if (n != 0)
+			__enqueue_elems(r, objs, meta, tail, n);
+		__rte_ring_st_set_head_tail(&r->prod.ht, tail, n, 1);
+		break;
+	case RTE_RING_SYNC_MT_HTS:
+		n = __rte_ring_hts_get_tail(&r->prod.hts, &tail, num);
+		if (n != 0)
+			__enqueue_elems(r, objs, meta, tail, n);
+		__rte_ring_hts_set_head_tail(&r->prod.hts, tail, n, 1);
+		break;
+	default:
+		/* unsupported mode, shouldn't be here */
+		RTE_ASSERT(0);
+	}
+}
+
 static inline uint32_t
 soring_dequeue(struct rte_soring *r, void *objs, void *meta,
 	uint32_t num, enum rte_ring_queue_behavior behavior,
@@ -296,11 +378,7 @@ soring_dequeue(struct rte_soring *r, void *objs, void *meta,
 
 	/* we have some elems to consume */
 	if (n != 0) {
-		__rte_ring_do_dequeue_elems(objs, &r[1], r->size,
-			cons_head & r->mask, r->esize, n);
-		if (meta != NULL)
-			__rte_ring_do_dequeue_elems(meta, r->meta, r->size,
-				cons_head & r->mask, r->msize, n);
+		__dequeue_elems(r, objs, meta, cons_head, n);
 		__rte_soring_update_tail(&r->cons, st, cons_head, cons_next, 0);
 	}
 
@@ -309,6 +387,67 @@ soring_dequeue(struct rte_soring *r, void *objs, void *meta,
 	return n;
 }
 
+static inline uint32_t
+soring_dequeue_start(struct rte_soring *r, void *objs, void *meta,
+	uint32_t num, enum rte_ring_queue_behavior behavior,
+	uint32_t *available)
+{
+	enum rte_ring_sync_type st;
+	uint32_t avail, head, next, n, ns;
+
+	RTE_ASSERT(r != NULL && r->nb_stage > 0);
+	RTE_ASSERT(meta == NULL || r->meta != NULL);
+
+	ns = r->nb_stage - 1;
+	st = r->cons.ht.sync_type;
+
+	switch (st) {
+	case RTE_RING_SYNC_ST:
+		n = __rte_ring_headtail_move_head(&r->cons.ht, &r->stage[ns].ht,
+			0, RTE_RING_SYNC_ST, num, behavior, &head, &next,
+			&avail);
+		break;
+	case RTE_RING_SYNC_MT_HTS:
+		n = __rte_ring_hts_move_head(&r->cons.hts, &r->stage[ns].ht,
+			0, num, behavior, &head, &avail);
+		break;
+	default:
+		/* unsupported mode, shouldn't be here */
+		RTE_ASSERT(0);
+		avail = 0;
+		n = 0;
+	}
+
+	/* we have some elems to consume */
+	if (n != 0)
+		__dequeue_elems(r, objs, meta, head, n);
+
+	if (available != NULL)
+		*available = avail - n;
+	return n;
+}
+
+
+static inline void
+soring_dequeue_finish(struct rte_soring *r, uint32_t num)
+{
+	uint32_t n, tail;
+
+	switch (r->cons.ht.sync_type) {
+	case RTE_RING_SYNC_ST:
+		n = __rte_ring_st_get_tail(&r->cons.ht, &tail, num);
+		__rte_ring_st_set_head_tail(&r->cons.ht, tail, n, 0);
+		break;
+	case RTE_RING_SYNC_MT_HTS:
+		n = __rte_ring_hts_get_tail(&r->cons.hts, &tail, num);
+		__rte_ring_hts_set_head_tail(&r->cons.hts, tail, n, 0);
+		break;
+	default:
+		/* unsupported mode, shouldn't be here */
+		RTE_ASSERT(0);
+	}
+}
+
 /*
  * Verify internal SORING state.
  * WARNING: if expected value is not equal to actual one, it means that for
@@ -598,3 +737,81 @@ rte_soring_free_count(const struct rte_soring *r)
 {
 	return r->capacity - rte_soring_count(r);
 }
+
+/*
+ * SORING public peek API
+ */
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_enqueue_bulk_start, 26.07)
+uint32_t
+rte_soring_enqueue_bulk_start(struct rte_soring *r, uint32_t n,
+	uint32_t *free_space)
+{
+	return soring_enqueue_start(r, n, RTE_RING_QUEUE_FIXED, free_space);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_enqueue_burst_start, 26.07)
+uint32_t
+rte_soring_enqueue_burst_start(struct rte_soring *r, uint32_t n,
+	uint32_t *free_space)
+{
+	return soring_enqueue_start(r, n, RTE_RING_QUEUE_VARIABLE, free_space);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_enqueue_finish, 26.07)
+void
+rte_soring_enqueue_finish(struct rte_soring *r, const void *objs, uint32_t n)
+{
+	soring_enqueue_finish(r, objs, NULL, n);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_enqueux_finish, 26.07)
+void
+rte_soring_enqueux_finish(struct rte_soring *r, const void *objs,
+	const void *meta, uint32_t n)
+{
+	soring_enqueue_finish(r, objs, meta, n);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_dequeue_bulk_start, 26.07)
+uint32_t
+rte_soring_dequeue_bulk_start(struct rte_soring *r, void *objs, uint32_t num,
+	uint32_t *available)
+{
+	return soring_dequeue_start(r, objs, NULL, num, RTE_RING_QUEUE_FIXED,
+		available);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_dequeux_bulk_start, 26.07)
+uint32_t
+rte_soring_dequeux_bulk_start(struct rte_soring *r, void *objs, void *meta,
+	uint32_t num, uint32_t *available)
+{
+	return soring_dequeue_start(r, objs, meta, num, RTE_RING_QUEUE_FIXED,
+		available);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_dequeue_burst_start, 26.07)
+uint32_t
+rte_soring_dequeue_burst_start(struct rte_soring *r, void *objs, uint32_t num,
+	uint32_t *available)
+{
+	return soring_dequeue_start(r, objs, NULL, num, RTE_RING_QUEUE_VARIABLE,
+		available);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_dequeux_burst_start, 26.07)
+uint32_t
+rte_soring_dequeux_burst_start(struct rte_soring *r, void *objs, void *meta,
+	uint32_t num, uint32_t *available)
+{
+	return soring_dequeue_start(r, objs, meta, num, RTE_RING_QUEUE_VARIABLE,
+		available);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_soring_dequeue_finish, 26.07)
+void
+rte_soring_dequeue_finish(struct rte_soring *r, uint32_t n)
+{
+	soring_dequeue_finish(r, n);
+}
-- 
2.51.0

