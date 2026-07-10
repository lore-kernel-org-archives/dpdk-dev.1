Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CA2C44501
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 21:10:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49F4C40611;
	Fri, 10 Jul 2026 23:09:43 +0200 (CEST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id 042344060B
 for <dev@dpdk.org>; Fri, 10 Jul 2026 23:09:42 +0200 (CEST)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-493f60208a5so8334765e9.3
 for <dev@dpdk.org>; Fri, 10 Jul 2026 14:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783717781; x=1784322581; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PvrADQ/3/X+A24hhIBg9rWovm95f2pAk052Ey5QEx2k=;
 b=AmchSWBQGjMUJsGGt368evBrqF8mZaQB9szJ8uuX31j+YrVnLJpZqdy661KutQ9tki
 yVl04aLy2BFdGzH0G3fBteB0r2z+omui1uSaXxs8Be0nTc1V5xXiliTeFAhOaF+/ELpB
 658zzk0lvAGEviSFW40pYVmSRK5QbVHUJEyH0LUszv+J9BWUTYehbDUtugBo8yV6VJql
 tdSnZbCmJNTihjOcg5iZ7cDyG2zzZOBK7725wxf/7GC7AQc/2Ko12eInQALj5tlDCswA
 vgYvqaQDG03AOJaxlUceMkKFgmIZoWHb/uQm7gkEzMzR4RtSZP4EyrdVyVFBPcymKaUy
 GAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783717781; x=1784322581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PvrADQ/3/X+A24hhIBg9rWovm95f2pAk052Ey5QEx2k=;
 b=cRnNRaHjgCxBi+pLCQIV7NSa0BlpJN++uPlczMUX/I2dQ+cnO+BRdFA0CFgwNjIct2
 KOuAZigFWYj6XIDK+8kTeuxwug52s+9HTrM4Camwy7mxfRHwxoxRD0uAQg415DzvvCSX
 x37EpHE0h36kWiR8x3v8P8HfsQxF+mM37lCbbPjGiTLvcUFlOQf35N9+BaQNDuea4V6H
 Egiv5BCv9/Os/2qt1q0RZfInUs2ipWLXXsTjZBv5HyvGeNEl4EWYUXRKSE81de488waS
 jYP+TpI1+/Lo9XgA4IRXdUvDz57HbfeGWwFGYM8Y80oL1Habe8ASYpCo823+0cOMXnw6
 xHZw==
X-Gm-Message-State: AOJu0Yz4JADTpKZfkb7l5uQ/vDsdFypXgJlIcJIsk72Vo+1dD/4o4Rr6
 Hqn9maHCGHGZXIM7fo7amgDf7oFQaaBH2onKmCvyIpX+PoAEOJYGd4nNskVqR07S
X-Gm-Gg: AfdE7ck15ZCI28GjmirBIEsBhs78V2zo0FvTyQxodplUL+T4lSLyGh8tbwgKPH3M7Or
 T9SfUPK2xod9CHPjB4WIvvUs9e+T49+BIAJacyydDy42jAi2DKaCy3JsKqIqPbFD7BDGDg/m0qa
 pokX8mMykHZEhw01QBlLEi6+sXjEo1UaXOqkKdcpKUfTiKDcnyueFHhAb4QbrpbzVV/M3AxmGUQ
 s6bRU0tiPGXPDtA4Kdqs5XHmpwTjCsChBG7qq4w+v6uWRQJxizZOCuF+eojG0duFjXaDaOTHih/
 k4K2wAorcmXuqfvTE7TGUR+SuNX0SuF6mbAHhb1W5c86pDa5EuFdWRtPVebHbmMZUoMzTmbYWmj
 NQeTQHGRZLfseWPTPRbnW7H351J5j2m1Z5PIHP8dDLazWlP+jHTjxBWWRiFvOrqaHIDn2A01qVP
 kn+CILAw==
X-Received: by 2002:a05:600c:a4d:b0:493:e4b2:5290 with SMTP id
 5b1f17b1804b1-493f87e5a62mr4018595e9.12.1783717781557; 
 Fri, 10 Jul 2026 14:09:41 -0700 (PDT)
Received: from freepad.. ([2a01:e0a:6f:bdf0:a821:a41b:93f0:2def])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2e0f165sm62596125e9.0.2026.07.10.14.09.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:09:40 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>, Jun Yang <jun.yang@nxp.com>,
 Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v4 6/6] net/dpaa2: pin Rx queue interrupt to the polling core
Date: Fri, 10 Jul 2026 23:09:20 +0200
Message-ID: <20260710210920.2402309-7-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710210920.2402309-1-maxime@leroys.fr>
References: <20260630144329.457643-1-maxime@leroys.fr>
 <20260710210920.2402309-1-maxime@leroys.fr>
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

A CDAN wakes the worker through the portal's VFIO eventfd, which is
signalled regardless of the core that took the MSI, so the wake is
correct either way. By default the MSI affinity is spread across the
housekeeping cores, so the wake crosses cores and adds a little latency.

Pin each DPIO's MSI to the lcore that arms it (as the event driver does)
so the wake lands on the worker's own core. This is a latency
optimisation, not a correctness fix.

Split dpaa2_affine_dpio_intr_to_respective_core out of the
RTE_EVENT_DPAA2 guard, expose dpaa2_dpio_affine_intr_to_core, and call it
from the rx-queue interrupt arm path. The pin is best-effort: it writes
/proc/irq/<n>/smp_affinity (needs privilege) and irqbalance may move it
back.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c | 17 ++++++++++++++---
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.h |  4 ++++
 drivers/net/dpaa2/dpaa2_ethdev.c         |  4 ++++
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
index 9dad78eba4..e17050b625 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
@@ -149,7 +149,6 @@ dpaa2_core_cluster_sdest(int cpu_id)
 	return dpaa2_core_cluster_base + x;
 }
 
-#ifdef RTE_EVENT_DPAA2
 static void
 dpaa2_affine_dpio_intr_to_respective_core(int32_t dpio_id, int cpu_id)
 {
@@ -204,7 +203,19 @@ dpaa2_affine_dpio_intr_to_respective_core(int32_t dpio_id, int cpu_id)
 
 	fclose(file);
 }
-#endif /* RTE_EVENT_DPAA2 */
+
+/* Pin the dpio's MSI IRQ to the calling lcore's core (best-effort), so a
+ * worker sleeping on this portal's eventfd is woken on its own core.
+ */
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_dpio_affine_intr_to_core)
+void
+dpaa2_dpio_affine_intr_to_core(int32_t dpio_id)
+{
+	int cpu_id = dpaa2_get_core_id();
+
+	if (cpu_id >= 0)
+		dpaa2_affine_dpio_intr_to_respective_core(dpio_id, cpu_id);
+}
 
 /* threshold: DQRR fill raising DQRI (< ring depth); timeout: holdoff in ITP units.
  * Per-mode values from the caller (eventdev vs rx-queue intr).
@@ -324,8 +335,8 @@ dpaa2_configure_stashing(struct dpaa2_dpio_dev *dpio_dev, int cpu_id, bool ethrx
 			DPAA2_BUS_ERR("Interrupt registration failed for dpio");
 			return -1;
 		}
+		dpaa2_affine_dpio_intr_to_respective_core(dpio_dev->hw_id, cpu_id);
 	}
-	dpaa2_affine_dpio_intr_to_respective_core(dpio_dev->hw_id, cpu_id);
 #else
 	RTE_SET_USED(ethrx);
 #endif
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h
index 1f6e521341..7e2271cc35 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h
@@ -58,6 +58,10 @@ int dpaa2_dpio_intr_init(struct dpaa2_dpio_dev *dpio_dev, int threshold,
 __rte_internal
 void dpaa2_dpio_intr_deinit(struct dpaa2_dpio_dev *dpio_dev);
 
+/* pin a DPIO's MSI IRQ to the calling lcore's core (rx-queue interrupt mode) */
+__rte_internal
+void dpaa2_dpio_affine_intr_to_core(int32_t dpio_id);
+
 /* allocate memory for FQ - dq storage */
 __rte_internal
 int
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 9d3634d75f..53ea060a4c 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -3170,6 +3170,10 @@ dpaa2_napi_subscribe(struct rte_eth_dev *dev, uint16_t queue_id,
 	}
 	rte_atomic_store_explicit(&dpaa2_q->napi_sub_dpio, dpio,
 			rte_memory_order_release);
+	/* pin this portal's MSI to the worker's core: a CDAN wake then lands on
+	 * the same core the worker sleeps on, instead of the default spread.
+	 */
+	dpaa2_dpio_affine_intr_to_core(dpio->hw_id);
 	return 0;
 }
 
-- 
2.43.0

