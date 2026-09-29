Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43F5C9832A
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 14:05:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C027442E64;
	Tue, 29 Sep 2026 16:04:37 +0200 (CEST)
Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com
 [74.125.228.38]) by mails.dpdk.org (Postfix) with ESMTP id 121FC42E48
 for <dev@dpdk.org>; Tue, 29 Sep 2026 16:04:25 +0200 (CEST)
Received: by mail-pz2-f38.google.com with SMTP id
 d2e1a72fcca58-882833a9f61so2107056b3a.2
 for <dev@dpdk.org>; Tue, 29 Sep 2026 07:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790690664;
 x=1791295464; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=he/WTTWk4yLrEOpsbdSuJGO1S75YdWeyvpOICPAZroE=;
 b=DaBnryYjvvXdaAgbJtCtM7TzZNXDMw5g1O6hXVqBMvy9vMyUeZ3kmJKcTNMwovXEa2
 KNHLoh5sEAdwYq5WQAEhAAH0d9WCS3paDWM46sGSeqrR8dv+jPNg9iWkXcwUtWrlDQgA
 6VDPTXaSPo6aJWaNWdyJ4yW+O0Gs1cdkNK9+DGzoyNpsYFCAi3MnET2UdZ8o1nFfQRwG
 EqEnJJ5ZJ5LA0PUWy5CGKovLFuoz4cAqEqIVT8+uyldC70ZwAkbsqwSRvRE49+fKJubp
 u9HHBIxtnn0gJhJpy2JG2CDFzebdHTlvZQKrz7BuAEGDMM5/McB9EN3/GEE8BBcgvv1r
 eKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790690664; x=1791295464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=he/WTTWk4yLrEOpsbdSuJGO1S75YdWeyvpOICPAZroE=;
 b=TgRbpb73LGgZFtxvl+wENwtA1YVyn7rXbRngHX3Knbga6TjI5LQynyGKQl2L8dtSfj
 KaViVIRtzGYdDuaGlbkOwcx9zbPkMWokKqhiV4a6LeVtEUKvZrp3z9EmY03mr+CRSu0d
 G+ACH3NbtDPjwi/hIDzqPkgcX5T+gdEyf2203YVvLHSEaPgHBm4LPFRqqo/ltd4a2J28
 zI4pf+KsVnkCGet1XqUMh59Dw/xj1p39q8U78qpYfyTN1vShW/tKEbDRiisP9C1gIe85
 RWR2z3bfuLKdS2IkHWKEkYz1gMh737vqI9Pnf24CXTPK0X01FGdnrpBEWWmku6lryMoS
 Lcfg==
X-Gm-Message-State: AFuF++mxodou3oMFCVO+Pl6Y702mN/gj89BFa9iD3e4EKb5nu+HK4Ud8
 3WRzAsDNN8dJIRgjPK0iocKUvYPF9/o748pAEI+qZ/T35d07VJUHx5Dz4OWrdQvCCURhx0MjSbm
 O3zJpqJ0=
X-Gm-Gg: AYBFou1lH1DrpdAPeypPgiXztyIUMlom58W2LJ9yQ9Qjp2CDQMlQc0tp1XVyVPP5cup
 cVaBNPQcjUfoxD6gIGASj7HkbhVkNE0kXrco1aHG76aMoT7TzGO5Nt1InyFVfLNTy431E51S3tl
 O45wp2EKvbF+aLPyM9UlgZKAA/AMs6KYSSlffGazawZ615oNuWUfjZ3kHTF7ygNxd11K1mImEXi
 ewiukn9pvsDJUujUnPDBGup+urCvfYgBZ82SZZB0vIgHga2QWzpzdR3Da6mFUzBu/P3CQQCcBzD
 K9152U6c9rmx1uScVNbybgZRXfA4JJlTgmZrZL4Xpvg7GIbP8/glU59G2IFlUqzV59N7Acuq0FT
 X2P75RFpK2erj97C6AqS1EKJnn5t8ihojoK3cwMXXJfgg6tnVJ0unV+suzo/ql5d8k/zYWyqKNW
 sWhzimRbflslZNv9HLiiAgye4mly+y47OTA4+HQUZyLqnoMK0iEk4MGFxiW219Eo7U/R+Gk7U1R
 PtIidTQYjAmg0+37qv07BZPj1e9PTEUK560l+JKKaPrZPvw
X-Received: by 2002:a05:6a00:99f:b0:880:f76a:babb with SMTP id
 d2e1a72fcca58-880f76ac51emr10501272b3a.52.1790690664052; 
 Tue, 29 Sep 2026 07:04:24 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-885e1066470sm998330b3a.18.2026.09.29.07.04.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 07:04:23 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v9 12/25] bus/fslmc: replace rte_atomic with stdatomic
Date: Tue, 29 Sep 2026 07:01:58 -0700
Message-ID: <20260929140409.234453-13-stephen@networkplumber.org>
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

