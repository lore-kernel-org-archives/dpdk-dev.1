Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726BBCD5BB8
	for <dpdk-dev@archiver.kernel.org>; Sat, 23 May 2026 20:00:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3FD5640B9D;
	Sat, 23 May 2026 21:59:03 +0200 (CEST)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176]) by mails.dpdk.org (Postfix) with ESMTP id 610CF4066E
 for <dev@dpdk.org>; Sat, 23 May 2026 21:58:57 +0200 (CEST)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-3042a388168so2043541eec.1
 for <dev@dpdk.org>; Sat, 23 May 2026 12:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779566336;
 x=1780171136; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s8kKAWF7z88seYdlPhOaaF0JU9MdHH8cp3UX8I+9Vi8=;
 b=wLTER/5V0XoIbO2ipknPKz1UU6A5JO5x6zM4oiYBj1FTX4/ADi7oqUKKZoN1zE+tlo
 VpPkuiIKukJUqVxcbXj2xQPI0a5CejCGDYmLG4oGMAGh5E/RE9YgkKxNj9FkGYsFm64s
 TtrstmuIMzoJ8i3oRuUROEv1XgE11rGoPpxHimWm5VeR07zOY7Is25tCIba+mvMZHxwF
 00itzYlfM4XKoP6QId4FRrOoZc18vJ13yyyXKTA7LncTJkQn/rDcau6k6mSDEhsk1hvS
 CuC2qZVFSRg9XrBQby2gEKU/BgeykLYgPmc/2VRUZfpkceB1usL0dz+hmtXTEU4nXQfK
 4zyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779566336; x=1780171136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s8kKAWF7z88seYdlPhOaaF0JU9MdHH8cp3UX8I+9Vi8=;
 b=j9nwN8YYhRSSaFsBV9wMakupWEH9hp1uSwzK1Od1MXtvvqQzVs5REDhN1LKNXj4uiF
 Uv41s2lkCI9DSF1qFkGswKvyAxql6dpmxP0p9NNQadx5X5MJRG1T1XBcV5Ki2jLifZK+
 jodi3LC2eUBKQF2L1Xn6S6ZRzkFd//PNZazsj5eo1AcgGKv9UglQqbVQ6AKaQPyiPnBe
 uFP58ELxImyrvy5Z0tHCdnt/Swn+o4E3r47Q+IHidyrdcCFxSUDRoWWDX4ZRhRkDFoSC
 m2MvZNKwtiaRrb9pbuy6jTM+M+uugKOj5raV/a+ikVg9g6Qh3nkUvBV0c6AWkh9/12DZ
 AJTQ==
X-Gm-Message-State: AOJu0Yy8/ruVgT1O960ctHRjHvCwgq3uHqWU6wGETYK75LMh61pVY6sE
 +Sr0DXAibNHBN3Q8FsQcL9gpAZpQYe2nG/0aK9+vGVMkUrVncOtUxMZU8GqBab4udJ9D73VNTx3
 yWKwP
X-Gm-Gg: Acq92OEywXFKFsHmvyei9MaLgIvjgRqTFWkSclpyGFiV077LQXyTkvqZuFLG7okcbPL
 IaWDmoYXc/IlYlXSa9mxseN9xZP1RRNdkAyPCY39Y4/lndEOLUVqAOG9uaA6gfpgUkueVbIXMP8
 +V+NdRtKFZRaXB8ieVuvtjwtwvnpfXKO1ZW1OgaZxssNzPL/7vJr2Jlje/F4ZlR0EIFUnCxfYKw
 gJNDuGsgErlexle4bbGS/+srsE14zeVVM3gcLMfM2lJAfI78BJtNldw9jy2ny4ur68BKb8oHp43
 gCU8svdsCvVv0i/WG1g0IkBNASYiT61gCcwmIsXl6OXhcznoB6UeeZe9AVxPrcdLwCpmcBNWsbK
 kedV3joilkgQj8BY3w1E2A/pneG+wOTOpBINMSlDamttNwVqb9nF1/kgINOU67bRlNa0b1m9AKI
 KOK+/MWoBCfN6/muHN08xVPsztZHGdjZDSVUgsXIozyKfw3jqEHp6uEhS8Mx0Xfw==
X-Received: by 2002:a05:7300:7c0d:b0:2ed:a58c:942 with SMTP id
 5a478bee46e88-3044a41f423mr3257553eec.8.1779566336399; 
 Sat, 23 May 2026 12:58:56 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452255234sm4838428eec.20.2026.05.23.12.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 12:58:56 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v3 14/27] drivers: replace rte_atomic16 with stdatomic
Date: Sat, 23 May 2026 12:56:28 -0700
Message-ID: <20260523195839.454952-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523195839.454952-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260523195839.454952-1-stephen@networkplumber.org>
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
index 925e83e97d..d94f3965b6 100644
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
+		uint32_t expected = 0;
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
index b546da82f6..789282085b 100644
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
+		uint32_t expected = 0;
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
index 2a9e519668..4d89915c29 100644
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
+		uint32_t expected = 0;
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
index ea5b0d4b85..9240534448 100644
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
+		uint32_t expected = 0;
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

