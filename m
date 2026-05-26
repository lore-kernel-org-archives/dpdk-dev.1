Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC62BCD5BD5
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 23:27:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF26C40A79;
	Wed, 27 May 2026 01:26:07 +0200 (CEST)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176]) by mails.dpdk.org (Postfix) with ESMTP id CD0C4406BB
 for <dev@dpdk.org>; Wed, 27 May 2026 01:26:01 +0200 (CEST)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-30246cfd41aso1026979eec.1
 for <dev@dpdk.org>; Tue, 26 May 2026 16:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779837961;
 x=1780442761; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dRAdtm5R5D+cQIFZdE3yBJjRv6yfvOWgIQCFZllJy5M=;
 b=ZRRmTo/fKCfGEqMAvFmZoHn+p2FL8XVFEbafR0cDOM9Xck6TangmvKHmqaUmOiIDRh
 K+4VEywbmErXbfA+/kOD/t39sH1/cfOMAqQJ238gtvEA+XSMsw3W/Frxg6U41hHtolJz
 L9+a/eNjvzO59uilVvTocdxiyj2nCvEUtSCi8a919Y29W9dGRklsNfKAqmSvoXmTLvP3
 WLHNJuieJgE/ITKhfp6L9eLQRbXQ6CC1AEAzXl7D8ZXn78HYmE+H5FREo3lKL8Au4brR
 6lQiQUzXNQGvOtwblVxFOVKZZLQcHeGmNjbALgeC7Ffqmh/laU87k0fBtSffAbXa3Dl0
 xQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779837961; x=1780442761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dRAdtm5R5D+cQIFZdE3yBJjRv6yfvOWgIQCFZllJy5M=;
 b=Fb1xzTURpGKnIBa4pP+7qrVxN8Qvoj1lGdXVDLKsTNpKk9gdXeAcSxjtk0OAclqW1r
 3T7r86F7dooiwjL+0yKj6CFq2OQ3STg+VOd3zrrKQ4MnEX7JG9kU9d/jSExTu8IYlUaM
 obCWxgLVYvIQ/MW8WLkDc1y+qnX2WbRtNosWVEdC5lXBJI5zZn1xIG254HS5K+6oFpIQ
 iMlANep7BE78/Jt3sSUn4RhOr15nhY1m/sEcTxj0Xz7NMhFkF/My8Z1VdtwrnAq9eOII
 C9Z3v2Wgr5bITYFsxOH/o58pzNCqeFr9X4W7RZ7MNwgq0rEdLkxigDDI2w4RWONPgrQ9
 T78w==
X-Gm-Message-State: AOJu0YwYnRvCWMXZPAq2+RivrvleqiuNjeLMTffY35h/0Vgh2DtpW5Af
 +rxqRCmGPnA4tcBYHVCzFbegWudJ8urB8YMZdR04U82bQ74F9g3L6DXppn54znYqbl6fkDws6Zz
 yesDi
X-Gm-Gg: Acq92OGjpKb0tSJDRRjzpKWXd7mcBF3MhHgxZCGS5mJNiWsRUCoi8O6eXfuvXtgTSQ6
 iImputO3ekMKCiEsEysxbQh0JD/Yj+lQ/aDQQe7hXZLdJcGDEh0mfry/n2iiKNjenqPgWehDB2/
 5T6yK2sncY+bAoxctIl9Fh686Pg7uUMtgMkZHvqrxUy00v7QPom4Z/i9OrqhKyZlOPX4JPJmXqC
 zDK1MkXr5o9213kBlPViO8gg6Vd/XEOx26BY8eY0VTzug3UIhF57aotphoGyYQ+UE5fBY4eGWMD
 wo2nlbnRgfvhirhz96SFIdStad488QFCjEu2ufdrsQZJnyeX2nXamNwQCeZr3Tfky/xCy7yebX9
 Udj7Mr9poG58jtHmNKteC9PwzA19neCOFEbcRELsM4gUFnBBS4zpfMCp+lvA8vF3f/5hqPCWams
 /Qyz5U4IsuWMTD8hl5oD4LbB0D35PwmT4duVpx7YX56s/9x04VK76o/2vaH2Y7iZV11qOEbeEpS
 mf0xtfTQX0=
X-Received: by 2002:a05:7300:b214:b0:2da:7e33:9261 with SMTP id
 5a478bee46e88-3044919c02amr10143953eec.27.1779837960836; 
 Tue, 26 May 2026 16:26:00 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452230f1bsm11296132eec.14.2026.05.26.16.26.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 16:26:00 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v4 14/27] drivers: replace rte_atomic16 with stdatomic
Date: Tue, 26 May 2026 16:24:04 -0700
Message-ID: <20260526232542.620966-15-stephen@networkplumber.org>
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

The rte_atomicNN functions and types are deprecated.
The in_use and reference counts flag can be converted to stdatomic.

Also drop the unneeded NULL check in the loop body: TAILQ_FOREACH
terminates when the iterator becomes NULL, so var is guaranteed
non-NULL inside the loop.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/bus/fslmc/portal/dpaa2_hw_dpbp.c | 10 +++++++---
 drivers/bus/fslmc/portal/dpaa2_hw_dpci.c | 10 +++++++---
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c | 12 ++++++++----
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h  |  8 ++++----
 drivers/event/dpaa2/dpaa2_hw_dpcon.c     | 11 +++++++----
 5 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpbp.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpbp.c
index 925e83e97d..7b08593338 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpbp.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpbp.c
@@ -84,7 +84,7 @@ dpaa2_create_dpbp_device(int vdev_fd __rte_unused,
 	}
 
 	dpbp_node->dpbp_id = dpbp_id;
-	rte_atomic16_init(&dpbp_node->in_use);
+	dpbp_node->in_use = 0;
 
 	TAILQ_INSERT_TAIL(&dpbp_dev_list, dpbp_node, next);
 
@@ -103,7 +103,10 @@ struct dpaa2_dpbp_dev *dpaa2_alloc_dpbp_dev(void)
 
 	/* Get DPBP dev handle from list using index */
 	TAILQ_FOREACH(dpbp_dev, &dpbp_dev_list, next) {
-		if (dpbp_dev && rte_atomic16_test_and_set(&dpbp_dev->in_use))
+		uint16_t expected = 0;
+		if (rte_atomic_compare_exchange_strong_explicit(
+			    &dpbp_dev->in_use, &expected, 1,
+			    rte_memory_order_acquire, rte_memory_order_relaxed))
 			break;
 	}
 
@@ -118,7 +121,8 @@ void dpaa2_free_dpbp_dev(struct dpaa2_dpbp_dev *dpbp)
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
index b546da82f6..0e36fcdcd4 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpci.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpci.c
@@ -135,7 +135,7 @@ rte_dpaa2_create_dpci_device(int vdev_fd __rte_unused,
 	}
 
 	dpci_node->dpci_id = dpci_id;
-	rte_atomic16_init(&dpci_node->in_use);
+	dpci_node->in_use = 0;
 
 	TAILQ_INSERT_TAIL(&dpci_dev_list, dpci_node, next);
 
@@ -159,7 +159,10 @@ struct dpaa2_dpci_dev *rte_dpaa2_alloc_dpci_dev(void)
 
 	/* Get DPCI dev handle from list using index */
 	TAILQ_FOREACH(dpci_dev, &dpci_dev_list, next) {
-		if (dpci_dev && rte_atomic16_test_and_set(&dpci_dev->in_use))
+		uint16_t expected = 0;
+		if (rte_atomic_compare_exchange_strong_explicit(
+			    &dpci_dev->in_use, &expected, 1,
+			    rte_memory_order_acquire, rte_memory_order_relaxed))
 			break;
 	}
 
@@ -174,7 +177,8 @@ void rte_dpaa2_free_dpci_dev(struct dpaa2_dpci_dev *dpci)
 	/* Match DPCI handle and mark it free */
 	TAILQ_FOREACH(dpci_dev, &dpci_dev_list, next) {
 		if (dpci_dev == dpci) {
-			rte_atomic16_dec(&dpci_dev->in_use);
+			rte_atomic_store_explicit(&dpci_dev->in_use, 0,
+						  rte_memory_order_release);
 			return;
 		}
 	}
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
index 2a9e519668..06ddb366d8 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
@@ -293,7 +293,7 @@ static void dpaa2_put_qbman_swp(struct dpaa2_dpio_dev *dpio_dev)
 #ifdef RTE_EVENT_DPAA2
 		dpaa2_dpio_intr_deinit(dpio_dev);
 #endif
-		rte_atomic16_clear(&dpio_dev->ref_count);
+		rte_atomic_store_explicit(&dpio_dev->ref_count, 0, rte_memory_order_release);
 	}
 }
 
@@ -305,7 +305,10 @@ static struct dpaa2_dpio_dev *dpaa2_get_qbman_swp(void)
 
 	/* Get DPIO dev handle from list using index */
 	TAILQ_FOREACH(dpio_dev, &dpio_dev_list, next) {
-		if (dpio_dev && rte_atomic16_test_and_set(&dpio_dev->ref_count))
+		uint16_t expected = 0;
+		if (rte_atomic_compare_exchange_strong_explicit(
+			    &dpio_dev->ref_count, &expected, 1,
+			    rte_memory_order_acquire, rte_memory_order_relaxed))
 			break;
 	}
 	if (!dpio_dev) {
@@ -326,7 +329,8 @@ static struct dpaa2_dpio_dev *dpaa2_get_qbman_swp(void)
 		ret = dpaa2_configure_stashing(dpio_dev, cpu_id);
 		if (ret) {
 			DPAA2_BUS_ERR("dpaa2_configure_stashing failed");
-			rte_atomic16_clear(&dpio_dev->ref_count);
+			rte_atomic_store_explicit(&dpio_dev->ref_count, 0,
+						  rte_memory_order_release);
 			return NULL;
 		}
 	}
@@ -441,7 +445,7 @@ dpaa2_create_dpio_device(int vdev_fd,
 
 	dpio_dev->dpio = NULL;
 	dpio_dev->hw_id = object_id;
-	rte_atomic16_init(&dpio_dev->ref_count);
+
 	/* Using single portal  for all devices */
 	dpio_dev->mc_portal = dpaa2_get_mcp_ptr(MC_PORTAL_INDEX);
 
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
index e625a5c035..f2298b18e5 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
@@ -112,7 +112,7 @@ struct dpaa2_dpio_dev {
 	TAILQ_ENTRY(dpaa2_dpio_dev) next;
 		/**< Pointer to Next device instance */
 	uint16_t index; /**< Index of a instance in the list */
-	rte_atomic16_t ref_count;
+	RTE_ATOMIC(uint16_t) ref_count;
 		/**< How many thread contexts are sharing this.*/
 	uint16_t eqresp_ci;
 	uint16_t eqresp_pi;
@@ -141,7 +141,7 @@ struct dpaa2_dpbp_dev {
 		/**< Pointer to Next device instance */
 	struct fsl_mc_io dpbp;  /** handle to DPBP portal object */
 	uint16_t token;
-	rte_atomic16_t in_use;
+	RTE_ATOMIC(uint16_t) in_use;
 	uint32_t dpbp_id; /*HW ID for DPBP object */
 };
 
@@ -257,7 +257,7 @@ struct dpaa2_dpci_dev {
 		/**< Pointer to Next device instance */
 	struct fsl_mc_io dpci;  /** handle to DPCI portal object */
 	uint16_t token;
-	rte_atomic16_t in_use;
+	RTE_ATOMIC(uint16_t) in_use;
 	uint32_t dpci_id; /*HW ID for DPCI object */
 	struct dpaa2_queue rx_queue[DPAA2_DPCI_MAX_QUEUES];
 	struct dpaa2_queue tx_queue[DPAA2_DPCI_MAX_QUEUES];
@@ -267,7 +267,7 @@ struct dpaa2_dpcon_dev {
 	TAILQ_ENTRY(dpaa2_dpcon_dev) next;
 	struct fsl_mc_io dpcon;
 	uint16_t token;
-	rte_atomic16_t in_use;
+	RTE_ATOMIC(uint16_t) in_use;
 	uint32_t dpcon_id;
 	uint16_t qbman_ch_id;
 	uint8_t num_priorities;
diff --git a/drivers/event/dpaa2/dpaa2_hw_dpcon.c b/drivers/event/dpaa2/dpaa2_hw_dpcon.c
index ea5b0d4b85..4d1d55eace 100644
--- a/drivers/event/dpaa2/dpaa2_hw_dpcon.c
+++ b/drivers/event/dpaa2/dpaa2_hw_dpcon.c
@@ -15,6 +15,7 @@
 #include <rte_malloc.h>
 #include <rte_memcpy.h>
 #include <rte_string_fns.h>
+#include <rte_stdatomic.h>
 #include <rte_cycles.h>
 #include <rte_kvargs.h>
 #include <dev_driver.h>
@@ -53,7 +54,7 @@ rte_dpaa2_create_dpcon_device(int dev_fd __rte_unused,
 	int ret, dpcon_id = obj->object_id;
 
 	/* Allocate DPAA2 dpcon handle */
-	dpcon_node = rte_malloc(NULL, sizeof(struct dpaa2_dpcon_dev), 0);
+	dpcon_node = rte_zmalloc(NULL, sizeof(struct dpaa2_dpcon_dev), 0);
 	if (!dpcon_node) {
 		DPAA2_EVENTDEV_ERR(
 				"Memory allocation failed for dpcon device");
@@ -85,7 +86,6 @@ rte_dpaa2_create_dpcon_device(int dev_fd __rte_unused,
 	dpcon_node->qbman_ch_id = attr.qbman_ch_id;
 	dpcon_node->num_priorities = attr.num_priorities;
 	dpcon_node->dpcon_id = dpcon_id;
-	rte_atomic16_init(&dpcon_node->in_use);
 
 	TAILQ_INSERT_TAIL(&dpcon_dev_list, dpcon_node, next);
 
@@ -98,7 +98,10 @@ struct dpaa2_dpcon_dev *rte_dpaa2_alloc_dpcon_dev(void)
 
 	/* Get DPCON dev handle from list using index */
 	TAILQ_FOREACH(dpcon_dev, &dpcon_dev_list, next) {
-		if (dpcon_dev && rte_atomic16_test_and_set(&dpcon_dev->in_use))
+		uint16_t expected = 0;
+		if (rte_atomic_compare_exchange_strong_explicit(
+			    &dpcon_dev->in_use, &expected, 1,
+			    rte_memory_order_acquire, rte_memory_order_relaxed))
 			break;
 	}
 
@@ -112,7 +115,7 @@ void rte_dpaa2_free_dpcon_dev(struct dpaa2_dpcon_dev *dpcon)
 	/* Match DPCON handle and mark it free */
 	TAILQ_FOREACH(dpcon_dev, &dpcon_dev_list, next) {
 		if (dpcon_dev == dpcon) {
-			rte_atomic16_dec(&dpcon_dev->in_use);
+			rte_atomic_store_explicit(&dpcon_dev->in_use, 0, rte_memory_order_release);
 			return;
 		}
 	}
-- 
2.53.0

