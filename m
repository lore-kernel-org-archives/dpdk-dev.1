Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB128C88E72
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 20:12:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2565C43009;
	Thu, 17 Sep 2026 22:11:39 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 6DF9E43005
 for <dev@dpdk.org>; Thu, 17 Sep 2026 22:11:34 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2d91a931f66so298315ad.0
 for <dev@dpdk.org>; Thu, 17 Sep 2026 13:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789675893;
 x=1790280693; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=he/WTTWk4yLrEOpsbdSuJGO1S75YdWeyvpOICPAZroE=;
 b=LjgR6CrYYGXQQjZbMIRHcnDiCl88z49eZmj8qLAGw+cpg6LtYFUtCbwToRzXSkHkxM
 e193oSSi3ouHTgb3SGCSB8eD/UxSmQw3d0dcqHmkcPwDaqOnjCSEOje/v9oOiZg7XKni
 cmTat8F03jRMLf91aO8OAYiC32Dt673JbgkHOlqm92/ZugYZWwJ8v6ugV8VIfZXBfuRv
 pyu+1Sz+MPvwFZHELvLCq1Z8mcqS6ytCenktBRrrchwD/VE128eDmTLrout7F/GBpOBk
 ZIg8viXARnByvYkMnnSmHPvjgJH17uh9/iqHBcfN5wbr+kaFJ5ZdkW91aKiRcKGMYCc3
 j+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789675893; x=1790280693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=he/WTTWk4yLrEOpsbdSuJGO1S75YdWeyvpOICPAZroE=;
 b=fbZd3xucDC7mu7QjOx8v8Ds8DMUO/R8A5byklLPc5qetyn11HHMEcAYHzNJrCUOOXL
 t6c1JkL4GVtrzTuRHwWxWxfZBQe899ktB2BDx4u97nawJ9x0mvkqH/eXckiNK8Z4hUWF
 P2+KUs6If+MynGZD89JMcBdwhy5ppWgZsTpwEeZIXPFmqp8WbJi9QTOaR4rhS20FJ1YP
 K5RpPUFV95vYhN0VT5LOinTH+1Qh9tqZ5QlKxoM+HhtKQbVCTug1ru5puayK2Hqp8JHY
 E7ynLD9stHBB7xdjG/jYLS8fE7ZUzpqOXehAnqnweI1OUY84Qq/JCskYSborWJe1q/e6
 e7AQ==
X-Gm-Message-State: AFuF++kKRQ0Z1hfCwUE8LIJke7rw7IeIDzuQCG1fyIlXJgQf0/C2Avyg
 zcxuUcX4myFzlVSwiA1satnwgWPC/6U7OqipV0bks5J316d+Phm3taSfLIxMSNfeN81OkvUCgIw
 sQPnf
X-Gm-Gg: AYBFou0i12wlF/w6kbzp9Ytmutri47zDQb9y4tzDBAzFwTm59Sj2PF2586SZNHlAoKN
 zzyahEL8NGU6i4JxG5JuHevo5ImOckOEgZ0tvF72MlSd5xdZxvCkgNu5RoeYglWczjYWewfAeB3
 xAcYUzp8Ov7Vnz/qYYsKJt5m6aLZbaNU7OO7FCJxJJ2G07l9E22a0IwO+/b5W1rpksHfqvP5l6Y
 hwG1pgW1tRhezuqTUrWrNGf5tSEbEr8M77n0rVHyMxPSQA6+Lf67WoN2f8uVvIJmWeuOHi7x0oJ
 Kbx/MSgw8zLL1Cf3SvW0CHzUx7TSKLfklLQZt2dzRPI0Rj0qr/T1LfULxFOI78TyCicBnR5fA2X
 M1qGu5A+teXFClmGZQCJcIsvNJiCPsjkdqx4hBpzEyy51U/LAPQJXs1PT/eu6SMO/gNfEw8vSi3
 P2QID39soKGHj/UsWejTmkjelT+2I3oQ2bIXjN6m5asBk9LvjRYGx9CykTzMWuWqUIRWdTAadu1
 iNzAsvjyYntqg+PdbGhDkMAtg74Df3WCccmgg==
X-Received: by 2002:a17:902:ecc4:b0:2dd:ad74:6d20 with SMTP id
 d9443c01a7336-2ddb1bc62afmr5654075ad.29.1789675893474; 
 Thu, 17 Sep 2026 13:11:33 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd89f0870bsm31368345ad.63.2026.09.17.13.11.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 13:11:33 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v8 12/25] bus/fslmc: replace rte_atomic with stdatomic
Date: Thu, 17 Sep 2026 13:10:16 -0700
Message-ID: <20260917201119.2168234-13-stephen@networkplumber.org>
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

The rte_atomicNN functions and types are deprecated.
The in_use and ref_count flags can be converted to stdatomic.

Note that rte_atomic16_init() and rte_atomic16_clear() were plain
stores with no ordering; only test_and_set() and dec() implied a
full barrier. Initialization happens before the device is put on the
list, so a relaxed store is used there. It is spelled out explicitly
because a plain assignment to an RTE_ATOMIC() object is a sequentially
consistent store when built with enable_stdatomic=true.

Claiming a device now pairs an acquire compare exchange with a release
store on the free path, which is what the test_and_set()/dec() pair was
providing.

Also drop the unneeded NULL check in the loop body: TAILQ_FOREACH
terminates when the iterator becomes NULL, so var is guaranteed
non-NULL inside the loop.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/bus/fslmc/portal/dpaa2_hw_dpbp.c  | 11 ++++++++---
 drivers/bus/fslmc/portal/dpaa2_hw_dpci.c  | 11 ++++++++---
 drivers/bus/fslmc/portal/dpaa2_hw_dpcon.c | 11 ++++++++---
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c  | 14 ++++++++++----
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h   |  9 +++++----
 drivers/bus/fslmc/qbman/include/compat.h  | 18 ++++++------------
 6 files changed, 45 insertions(+), 29 deletions(-)

diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpbp.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpbp.c
index 925e83e97d..d2ddb76baf 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpbp.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpbp.c
@@ -84,7 +84,7 @@ dpaa2_create_dpbp_device(int vdev_fd __rte_unused,
 	}
 
 	dpbp_node->dpbp_id = dpbp_id;
-	rte_atomic16_init(&dpbp_node->in_use);
+	rte_atomic_store_explicit(&dpbp_node->in_use, 0, rte_memory_order_relaxed);
 
 	TAILQ_INSERT_TAIL(&dpbp_dev_list, dpbp_node, next);
 
@@ -103,7 +103,11 @@ struct dpaa2_dpbp_dev *dpaa2_alloc_dpbp_dev(void)
 
 	/* Get DPBP dev handle from list using index */
 	TAILQ_FOREACH(dpbp_dev, &dpbp_dev_list, next) {
-		if (dpbp_dev && rte_atomic16_test_and_set(&dpbp_dev->in_use))
+		uint16_t expected = 0;
+
+		if (rte_atomic_compare_exchange_strong_explicit(&dpbp_dev->in_use,
+				&expected, 1, rte_memory_order_acquire,
+				rte_memory_order_relaxed))
 			break;
 	}
 
@@ -118,7 +122,8 @@ void dpaa2_free_dpbp_dev(struct dpaa2_dpbp_dev *dpbp)
 	/* Match DPBP handle and mark it free */
 	TAILQ_FOREACH(dpbp_dev, &dpbp_dev_list, next) {
 		if (dpbp_dev == dpbp) {
-			rte_atomic16_dec(&dpbp_dev->in_use);
+			rte_atomic_store_explicit(&dpbp_dev->in_use, 0,
+						  rte_memory_order_release);
 			return;
 		}
 	}
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpci.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpci.c
index b546da82f6..20371fe062 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpci.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpci.c
@@ -135,7 +135,7 @@ rte_dpaa2_create_dpci_device(int vdev_fd __rte_unused,
 	}
 
 	dpci_node->dpci_id = dpci_id;
-	rte_atomic16_init(&dpci_node->in_use);
+	rte_atomic_store_explicit(&dpci_node->in_use, 0, rte_memory_order_relaxed);
 
 	TAILQ_INSERT_TAIL(&dpci_dev_list, dpci_node, next);
 
@@ -159,7 +159,11 @@ struct dpaa2_dpci_dev *rte_dpaa2_alloc_dpci_dev(void)
 
 	/* Get DPCI dev handle from list using index */
 	TAILQ_FOREACH(dpci_dev, &dpci_dev_list, next) {
-		if (dpci_dev && rte_atomic16_test_and_set(&dpci_dev->in_use))
+		uint16_t expected = 0;
+
+		if (rte_atomic_compare_exchange_strong_explicit(&dpci_dev->in_use,
+				&expected, 1, rte_memory_order_acquire,
+				rte_memory_order_relaxed))
 			break;
 	}
 
@@ -174,7 +178,8 @@ void rte_dpaa2_free_dpci_dev(struct dpaa2_dpci_dev *dpci)
 	/* Match DPCI handle and mark it free */
 	TAILQ_FOREACH(dpci_dev, &dpci_dev_list, next) {
 		if (dpci_dev == dpci) {
-			rte_atomic16_dec(&dpci_dev->in_use);
+			rte_atomic_store_explicit(&dpci_dev->in_use, 0,
+						  rte_memory_order_release);
 			return;
 		}
 	}
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpcon.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpcon.c
index 6fd96ec0b9..eff8bc2445 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpcon.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpcon.c
@@ -81,7 +81,7 @@ rte_dpaa2_create_dpcon_device(int dev_fd __rte_unused,
 	dpcon_node->qbman_ch_id = attr.qbman_ch_id;
 	dpcon_node->num_priorities = attr.num_priorities;
 	dpcon_node->dpcon_id = dpcon_id;
-	rte_atomic16_init(&dpcon_node->in_use);
+	rte_atomic_store_explicit(&dpcon_node->in_use, 0, rte_memory_order_relaxed);
 
 	TAILQ_INSERT_TAIL(&dpcon_dev_list, dpcon_node, next);
 
@@ -95,7 +95,11 @@ struct dpaa2_dpcon_dev *rte_dpaa2_alloc_dpcon_dev(void)
 
 	/* Get DPCON dev handle from list using index */
 	TAILQ_FOREACH(dpcon_dev, &dpcon_dev_list, next) {
-		if (dpcon_dev && rte_atomic16_test_and_set(&dpcon_dev->in_use))
+		uint16_t expected = 0;
+
+		if (rte_atomic_compare_exchange_strong_explicit(&dpcon_dev->in_use,
+				&expected, 1, rte_memory_order_acquire,
+				rte_memory_order_relaxed))
 			break;
 	}
 
@@ -110,7 +114,8 @@ void rte_dpaa2_free_dpcon_dev(struct dpaa2_dpcon_dev *dpcon)
 	/* Match DPCON handle and mark it free */
 	TAILQ_FOREACH(dpcon_dev, &dpcon_dev_list, next) {
 		if (dpcon_dev == dpcon) {
-			rte_atomic16_dec(&dpcon_dev->in_use);
+			rte_atomic_store_explicit(&dpcon_dev->in_use, 0,
+						  rte_memory_order_release);
 			return;
 		}
 	}
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
index e17050b625..9fe449ed38 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
@@ -352,7 +352,8 @@ static void dpaa2_put_qbman_swp(struct dpaa2_dpio_dev *dpio_dev)
 		 * armed: intr_deinit returns early if intr is not enabled.
 		 */
 		dpaa2_dpio_intr_deinit(dpio_dev);
-		rte_atomic16_clear(&dpio_dev->ref_count);
+		rte_atomic_store_explicit(&dpio_dev->ref_count, 0,
+					  rte_memory_order_release);
 	}
 }
 
@@ -364,7 +365,11 @@ static struct dpaa2_dpio_dev *dpaa2_get_qbman_swp(bool ethrx)
 
 	/* Get DPIO dev handle from list using index */
 	TAILQ_FOREACH(dpio_dev, &dpio_dev_list, next) {
-		if (dpio_dev && rte_atomic16_test_and_set(&dpio_dev->ref_count))
+		uint16_t expected = 0;
+
+		if (rte_atomic_compare_exchange_strong_explicit(&dpio_dev->ref_count,
+				&expected, 1, rte_memory_order_acquire,
+				rte_memory_order_relaxed))
 			break;
 	}
 	if (!dpio_dev) {
@@ -385,7 +390,8 @@ static struct dpaa2_dpio_dev *dpaa2_get_qbman_swp(bool ethrx)
 		ret = dpaa2_configure_stashing(dpio_dev, cpu_id, ethrx);
 		if (ret) {
 			DPAA2_BUS_ERR("dpaa2_configure_stashing failed");
-			rte_atomic16_clear(&dpio_dev->ref_count);
+			rte_atomic_store_explicit(&dpio_dev->ref_count, 0,
+						  rte_memory_order_release);
 			return NULL;
 		}
 	}
@@ -500,7 +506,7 @@ dpaa2_create_dpio_device(int vdev_fd,
 
 	dpio_dev->dpio = NULL;
 	dpio_dev->hw_id = object_id;
-	rte_atomic16_init(&dpio_dev->ref_count);
+	rte_atomic_store_explicit(&dpio_dev->ref_count, 0, rte_memory_order_relaxed);
 	/* Using single portal  for all devices */
 	dpio_dev->mc_portal = dpaa2_get_mcp_ptr(MC_PORTAL_INDEX);
 
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
index ef65e7895a..556e1b01c0 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
@@ -9,6 +9,7 @@
 #define _DPAA2_HW_PVT_H_
 
 #include <rte_compat.h>
+#include <rte_stdatomic.h>
 #include <rte_eventdev.h>
 #include <dpaax_iova_table.h>
 
@@ -112,7 +113,7 @@ struct dpaa2_dpio_dev {
 	TAILQ_ENTRY(dpaa2_dpio_dev) next;
 		/**< Pointer to Next device instance */
 	uint16_t index; /**< Index of a instance in the list */
-	rte_atomic16_t ref_count;
+	RTE_ATOMIC(uint16_t) ref_count;
 		/**< How many thread contexts are sharing this.*/
 	uint16_t eqresp_ci;
 	uint16_t eqresp_pi;
@@ -143,7 +144,7 @@ struct dpaa2_dpbp_dev {
 		/**< Pointer to Next device instance */
 	struct fsl_mc_io dpbp;  /** handle to DPBP portal object */
 	uint16_t token;
-	rte_atomic16_t in_use;
+	RTE_ATOMIC(uint16_t) in_use;
 	uint32_t dpbp_id; /*HW ID for DPBP object */
 };
 
@@ -266,7 +267,7 @@ struct dpaa2_dpci_dev {
 		/**< Pointer to Next device instance */
 	struct fsl_mc_io dpci;  /** handle to DPCI portal object */
 	uint16_t token;
-	rte_atomic16_t in_use;
+	RTE_ATOMIC(uint16_t) in_use;
 	uint32_t dpci_id; /*HW ID for DPCI object */
 	struct dpaa2_queue rx_queue[DPAA2_DPCI_MAX_QUEUES];
 	struct dpaa2_queue tx_queue[DPAA2_DPCI_MAX_QUEUES];
@@ -276,7 +277,7 @@ struct dpaa2_dpcon_dev {
 	TAILQ_ENTRY(dpaa2_dpcon_dev) next;
 	struct fsl_mc_io dpcon;
 	uint16_t token;
-	rte_atomic16_t in_use;
+	RTE_ATOMIC(uint16_t) in_use;
 	uint32_t dpcon_id;
 	uint16_t qbman_ch_id;
 	uint8_t num_priorities;
diff --git a/drivers/bus/fslmc/qbman/include/compat.h b/drivers/bus/fslmc/qbman/include/compat.h
index 5a57bd8ed1..c933cb328a 100644
--- a/drivers/bus/fslmc/qbman/include/compat.h
+++ b/drivers/bus/fslmc/qbman/include/compat.h
@@ -81,18 +81,12 @@ do { \
 
 #define dma_wmb()		rte_io_wmb()
 
-#define atomic_t                rte_atomic32_t
-#define atomic_read(v)          rte_atomic32_read(v)
-#define atomic_set(v, i)        rte_atomic32_set(v, i)
+typedef RTE_ATOMIC(uint32_t) atomic_t;
 
-#define atomic_inc(v)           rte_atomic32_add(v, 1)
-#define atomic_dec(v)           rte_atomic32_sub(v, 1)
-
-#define atomic_inc_and_test(v)  rte_atomic32_inc_and_test(v)
-#define atomic_dec_and_test(v)  rte_atomic32_dec_and_test(v)
-
-#define atomic_inc_return(v)    rte_atomic32_add_return(v, 1)
-#define atomic_dec_return(v)    rte_atomic32_sub_return(v, 1)
-#define atomic_sub_and_test(i, v) (rte_atomic32_sub_return(v, i) == 0)
+#define atomic_set(v, i)        rte_atomic_store_explicit((v), (i), rte_memory_order_relaxed)
+#define atomic_inc(v)           ((void)rte_atomic_fetch_add_explicit((v), 1, \
+								     rte_memory_order_seq_cst))
+#define atomic_dec_and_test(v)  (rte_atomic_fetch_sub_explicit((v), 1, \
+							       rte_memory_order_seq_cst) == 1)
 
 #endif /* HEADER_COMPAT_H */
-- 
2.53.0

