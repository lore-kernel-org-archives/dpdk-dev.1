Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17DDC55838
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 03:26:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0991640A72;
	Thu,  6 Aug 2026 05:26:03 +0200 (CEST)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id A524940A76
 for <dev@dpdk.org>; Thu,  6 Aug 2026 05:26:00 +0200 (CEST)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2d049069377so18096065ad.0
 for <dev@dpdk.org>; Wed, 05 Aug 2026 20:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785986760;
 x=1786591560; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RN2kRZTfp9z+YFHHNaG/AJZq6coPsZA8UN0b4PARnRs=;
 b=GuBv8LTqed6HjmiGb9Twa8OCpAUoATqcGNkWX+sAe66YTya+SUNPHEXdMutPiHt/hk
 Dw8c+gfKj6VGNo/JcDMVCMkLOyG1XT6zuzPfdZzOJlLAS8AiUYcz1wke3YsgZhiQILur
 7AU1EGjPggmyuks+UV8TyIoiKo1h6xkuOTBOEkB1iHFnhX/6FMh0wp6Bp6L1C/CiCM5Z
 jALN7EyRC9tAySxRfzfG0zCBXw0zv8I9W5clKfUUvO5GO71gtr+lcdzs9/MSGJSJcm1Z
 HV0XkMOmIoUbMBgUaArRY9qhBlb2BIK/PKZWsTLsVmoc+4/qQ5G0UYsxjFVCauoPocg/
 BijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785986760; x=1786591560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RN2kRZTfp9z+YFHHNaG/AJZq6coPsZA8UN0b4PARnRs=;
 b=OFQxIULo5Wc4ztFvPwzH/PZmcSsNpx4LUmECEdYHNmfTjLxvThhhkAtxDQOerWJLXR
 KzGOQOoHK5qhM0uECIoPtIQQQQSOtUH5mTyX/cIgN10j6dWPREHmP+SazGAYO0opgu/q
 cGZsyNRNkDmra3mC6JsHw+2KpoipC5lGVP7UHM+P677jkyp6UlK1Ijk0S26kYDJUOd9c
 ueZPzgYtIFMfm4GoKFVP4BwPrRq/zpqYn5N9dLzJrTZgckdUUzAWeXlJaSkDh40w2S5Q
 1TckA+VOor5zCxSiD4u3Ih4JH/apI1UqeGQH8n02166rWTJSKh6k1Twp1vzacPMLAxA6
 e1zg==
X-Gm-Message-State: AOJu0YwpNWXIRbwu1d+nmc2w86LM56BIRBpfvHYXG5lxg/CdS19ftzJ+
 WJw90jfDI0j+dA4eLZmpmrtNBeMti6Ho8M7iRjgEe041XGUhC1bSNuUwWrN2rpbTceaut2mr6PE
 Ga3CWfJ4=
X-Gm-Gg: AR+sD130PoeZvU9vjPRS+xuRQDxHYtEvRmZlo+Z8PreLFys4yha2I88HHiGAP4qn3Gq
 nPYSpNeBmO8+Iy6zJKR+D3MciWRc0ny7L8F79xjJw/k2boWDMV4QDPEoVtS8XGx6thSzemayJTi
 lyzHU5BmqdqL96Ak0BnUzSkYZ51H08aarQppoWdFj6v2TQrrlk7FthmSflu4IrZmN4SCSXiCEQj
 rWFSYvgYMiDQ38UzuKLgR/xc7e3hzikO6sB/CKbVdEXIH/3GwQFuNg1Os04CisW9yZaTDF3zstN
 03tTbN+L7APwWsLPu6rih+E2bGydsS2AWz98T/lscqVJ3i6ilzStWyd2TRfT7R65CuvT03wrdqN
 rmzj3DBORsOGLEpkh+QZrQSl7IohJhXTzlEkxO1XrFkDe4VQlyu6W9KyGM1qN2Ybc92Fwqnu75q
 AW6yeIYPTY5gqJtQaaC4xWm5yeT41LD4iQYJKEUWdMk8CpBFlJLnZ7+ppyuWyVYyqweJKZaGTXo
 97nHYUdpB6NBh9wfsGVsKSb3E0=
X-Received: by 2002:a17:90b:1d52:b0:38f:23d6:b4ad with SMTP id
 98e67ed59e1d1-3903c5433damr12633287a91.8.1785986759689; 
 Wed, 05 Aug 2026 20:25:59 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863b0c61sm23301631eec.6.2026.08.05.20.25.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 20:25:59 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v7 11/24] bus/fslmc: replace rte_atomic16 with stdatomic
Date: Wed,  5 Aug 2026 20:23:03 -0700
Message-ID: <20260806032544.21337-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806032544.21337-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260806032544.21337-1-stephen@networkplumber.org>
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
---
 drivers/bus/fslmc/portal/dpaa2_hw_dpbp.c  | 11 ++++++++---
 drivers/bus/fslmc/portal/dpaa2_hw_dpci.c  | 11 ++++++++---
 drivers/bus/fslmc/portal/dpaa2_hw_dpcon.c | 11 ++++++++---
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c  | 14 ++++++++++----
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h   |  9 +++++----
 5 files changed, 39 insertions(+), 17 deletions(-)

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
-- 
2.53.0

