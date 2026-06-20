Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42C8CD98F2
	for <dpdk-dev@archiver.kernel.org>; Sat, 20 Jun 2026 02:32:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7AA024028D;
	Sat, 20 Jun 2026 04:31:56 +0200 (CEST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com
 [209.85.128.174])
 by mails.dpdk.org (Postfix) with ESMTP id 592F840B9D
 for <dev@dpdk.org>; Sat, 20 Jun 2026 04:31:54 +0200 (CEST)
Received: by mail-yw1-f174.google.com with SMTP id
 00721157ae682-7fffb090ddfso25981737b3.1
 for <dev@dpdk.org>; Fri, 19 Jun 2026 19:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781922714;
 x=1782527514; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dRAdtm5R5D+cQIFZdE3yBJjRv6yfvOWgIQCFZllJy5M=;
 b=ol1c3afL7qSXEYy629IU0nuT94bXSNjFTW/7UiPiYohJijGOOspRJLqR2aexNVTixL
 vNmeqL630hoyY0fa+E1kUFGP0u7+Zb+19D40M9hPBekFDGmlPkc76YaKbE7V2Qhz85qi
 Fy9/X0tatwSWvogusUeNoEZHH0uAb5yE9JoYsi/Fh86vDr4vVokGptm8ixeXxIQHQcU4
 3sXj/KKybAbIbrg8IERtIM0E9So/vylNMW73lzU/C4WHyDyIvg7jJKOE8iTHY5uElXhv
 WSi2GVH3Vp4zbGrWfbfaYE6WCxdQFmsn2nqkreG55NXCKvsxlOQEhtf1VXWNk6hH/LQC
 +emg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781922714; x=1782527514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dRAdtm5R5D+cQIFZdE3yBJjRv6yfvOWgIQCFZllJy5M=;
 b=c+5pjVjtmKhsJA0fBpPSSy1irA+4IGftifsSEvnLLwXnDXw/MFjRjlFDC7nHOW2a8w
 ERSWfmkark/6XtD77gW3WdAqZ1+R9rvicmpP0+2VYpXQhLvS0VmIbbeoLvJKvQgxCAub
 UP9hf7ifg873kaNYZXuGIqsK2mjFwpoJlYVY3G08yTY3Eg80E7Vwjtgwlb2McqmPmvyO
 CGEocVa6BwnHpxOmYgWmJdUh/tBhA6rnWGRBTGEfFjhxnGGV09dlojmXbqSLHZaaNIzP
 lnydVqHfjOXEW155v2gx3EoFU7tBrcdR4z4iv7M0lMyTIGjpJK2Uo3KwDwKtOJqLv01A
 tyqw==
X-Gm-Message-State: AOJu0Yxys4yzc2Pxq890S4iqpu5YVwpnPqELJsDvLa1PFe3xhznKeKLZ
 mpD8j355UT8CR4PAQ/KmVWEPOxBA9EAP6/9R2p3sCJK4aXYYjywfzoGls9Ji65or5tfwkwvGgEz
 VnDWq
X-Gm-Gg: AfdE7ckLm3/r/7Fa1NjyQ+AHOeSoI0IAwxcirGAq5J6wjhVLJ8XiZrP4GZsLrL9pWl4
 6GqR3Ka+gevC0FVSn+0XjNodO85UlNcUpI/KMNn+/J10e0IiKa/D5562Pbv/y7GAEDPYXzBWvmh
 +L7X1ZiLWXibzaz1wIfcRhplp5qPS/P0ESahpCBIe+1eNNmVlsHcT8kXmidxHrXlrw1JGBNsw6x
 Yw3dm+EY7PSz5R2USo/AAbAZikSzA2MGW3u5pbn33TESJMlp56GwuhzXYP7ynQAjQj8YL1ND9uq
 EHuTS+hRm3aMHea3hmq0pK+zy4i6L92sxaqRA7nTuyxN69mbDf/yyE1QWGMUlnznrbs0Sa0FVNo
 jig2ZgQTcVxYXLh8WPvCXq5LfCFrZw2SxHg5WfuibzEZeE9iIcZ1qr32DPC7WXvxzouG4vpyBx4
 CsyR8BhmfiU8JqmsKiovxXfPKcTAqp6SrBtibKYLmuPf0oQ4Ve62I=
X-Received: by 2002:a05:690c:6311:b0:7ff:1399:9004 with SMTP id
 00721157ae682-80121720a88mr51618187b3.8.1781922713657; 
 Fri, 19 Jun 2026 19:31:53 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8025c96ffd5sm6045897b3.9.2026.06.19.19.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 19:31:53 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v5 11/24] drivers: replace rte_atomic16 with stdatomic
Date: Fri, 19 Jun 2026 19:28:36 -0700
Message-ID: <20260620023134.42877-12-stephen@networkplumber.org>
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

