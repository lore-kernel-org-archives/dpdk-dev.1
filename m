Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D77AC43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 14:44:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 628BC40A72;
	Tue, 30 Jun 2026 16:43:51 +0200 (CEST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44]) by mails.dpdk.org (Postfix) with ESMTP id 4C83D409FA
 for <dev@dpdk.org>; Tue, 30 Jun 2026 16:43:49 +0200 (CEST)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-472493849a3so2724298f8f.2
 for <dev@dpdk.org>; Tue, 30 Jun 2026 07:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782830629; x=1783435429; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YpJNkD5kGSqLFjnbKSnGw90eOtqdNZORbmacwjOhRfk=;
 b=IfR54sCPRPwkcuTcYnXDyuPJKEwSLfayGR0NKBqSu5qeJq7Eol/6rMdyishnMCZnUp
 RSe4NjUKnUL6NKpZBARDslBMhI/Tfj9BnteE/9PMP2s0GPqjVPKAiYE7BjW52akW9p2j
 tXHSclOG/ycSQmcaf35by6zadlUx/t9W2akjwKUdYMEVWjJ72n4I5xNvffZFU8YSMd3g
 Yv1p6GUeOd8dmUABiMk/3Kco2JHvVKLSmfvpK2Knh3LY6lw8qRbJUolMfQB/ZTqCHv/u
 cxF+3MKapAmppSyr/PQqBcrjhSfw5OpvRsCD9Ojva8O6epsdy72nldqsQUIquY/ItML3
 yMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782830629; x=1783435429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YpJNkD5kGSqLFjnbKSnGw90eOtqdNZORbmacwjOhRfk=;
 b=cfcOGhArgQZ/ih6sFjFDivySADnQTP2Ie5aU7DUX3IWODqq3RyY5UgUURjVGgu+bt3
 H+h3h/SQjAb5UeFyqg7ZmiH3TH2j/yzPTT9hJtaXu5J4NYVITCFX+OB5zac6Y0b4z9W4
 uRwWWlbdIsGeLRKx3KX7JrSCdgIgMIbLjSK6e5rSn7HueIpS1vaq+2P1COFhQ7q46uoI
 MQs7HLgTyKlVoGYehyWL/wl+mOOZkUOO3K4i4gIfx8RLfeE+CQiNIOiAoC6nR9FEiybG
 Ui99K1tseb2UXpTvhwLPb+YdBcGGAidvx33zLMyT+kVqVWo4uOpkIA+knBtLkifTUfy8
 kI9w==
X-Gm-Message-State: AOJu0YySVJVlPd8UzsU/xQaf5PkxynirhBrZEFHGUOIAIw7T59WR9Bhv
 c7Q9S/R4greRw1L0XXaqvUu7aDFPP+28JG08poUq869QVg2Cok91RpKeE3YalwlY
X-Gm-Gg: AfdE7cl/0Y2yWgu9v8zTMHfq98SuT6SR3inz3JE8Ad1g+siRT0I1RsrhLEAMzAqGOfl
 UVldFQRAU1sFL9b2wFzvz0lVMTKHqcdPP43rm5lAPtYopzzUh/e4J6GjoH5SGZQTWwkiBxmLEZK
 uAx+0tjkAohRvVCggV5Wx+GsVY5FTMRxhFXq5ifahuBtse+AHX3ipXty82Q4dRDx4y+nnSSTSv8
 4gu0AQoO4hPIyjxoZu0k4tV5gN3uUIHtl7NcvcDB+mctSLU1XNCGuFP6gxjzZdnSRfTnr3iRonw
 iJtHp7zQqDNzYH24PGPU2PM1hjMgP00Kl4XvooSeAChs7i2zUEX4oD4uaTp3/MVTXFMApzMkhMB
 wK9z8ABqwONqZThn0JqpYmyB7W2CYrg1bXke5Ch1m5mdxJD25iB7DFhFSZaEa3Ytj55k7MspKUg
 pZTO3OiJb5qG4yXzhUgK0xuKIDJPk7xgb0uoKbp0JRJqyh
X-Received: by 2002:a05:600c:a012:b0:492:699e:3113 with SMTP id
 5b1f17b1804b1-493b82c1268mr62471345e9.35.1782830628816; 
 Tue, 30 Jun 2026 07:43:48 -0700 (PDT)
Received: from localhost.localdomain (free-mobile.vlq16.iliad.fr.
 [213.36.7.11]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493b8ca8671sm78959545e9.11.2026.06.30.07.43.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 07:43:48 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, sachin.saxena@nxp.com, david.marchand@redhat.com,
 Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v3 6/6] net/dpaa2: pin Rx queue interrupt to the polling core
Date: Tue, 30 Jun 2026 16:43:29 +0200
Message-ID: <20260630144329.457643-7-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630144329.457643-1-maxime@leroys.fr>
References: <20260616102727.708948-1-maxime@leroys.fr>
 <20260630144329.457643-1-maxime@leroys.fr>
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

Split dpaa2_affine_dpio_intr_to_respective_core out of the RTE_EVENT_DPAA2
guard, expose dpaa2_dpio_affine_intr_to_core, and call it from the rx-queue
interrupt arm path. The pin is best-effort: it writes
/proc/irq/<n>/smp_affinity (needs privilege) and irqbalance may move it
back.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c | 45 +++++++++++++-----------
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.h |  4 +++
 drivers/net/dpaa2/dpaa2_ethdev.c         |  2 ++
 3 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
index 354d81b4d1..057f2bb70d 100644
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
 
 /* arm the portal DQRI (threshold/timeout); idempotent, first caller per portal wins */
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_dpio_intr_init)
@@ -299,31 +310,25 @@ dpaa2_configure_stashing(struct dpaa2_dpio_dev *dpio_dev, int cpu_id, bool ethrx
 	}
 
 #ifdef RTE_EVENT_DPAA2
-	{
-		/* ethrx portal: immediate DQRI (1, 0); event portal: coalesced (3, 0xFF).
-		 * Each mode is tunable through its own env vars.
-		 */
-		const char *thr_env = "DPAA2_PORTAL_INTR_THRESHOLD";
-		const char *to_env = "DPAA2_PORTAL_INTR_TIMEOUT";
+	/* only the event PMD's portal is set up here; the net ethrx portal is
+	 * configured by the net PMD in rx_queue_intr_enable
+	 */
+	if (!ethrx) {
 		int threshold = 3, timeout = 0xFF;
 
-		if (ethrx) {
-			thr_env = "DPAA2_PORTAL_ETHRX_INTR_THRESHOLD";
-			to_env = "DPAA2_PORTAL_ETHRX_INTR_TIMEOUT";
-			threshold = 1;
-			timeout = 0;
-		}
-		if (getenv(thr_env))
-			threshold = atoi(getenv(thr_env));
-		if (getenv(to_env))
-			sscanf(getenv(to_env), "%x", &timeout);
+		if (getenv("DPAA2_PORTAL_INTR_THRESHOLD"))
+			threshold = atoi(getenv("DPAA2_PORTAL_INTR_THRESHOLD"));
+		if (getenv("DPAA2_PORTAL_INTR_TIMEOUT"))
+			sscanf(getenv("DPAA2_PORTAL_INTR_TIMEOUT"), "%x", &timeout);
 
-		if (dpaa2_dpio_intr_init(dpio_dev, threshold, timeout, !ethrx)) {
+		if (dpaa2_dpio_intr_init(dpio_dev, threshold, timeout, true)) {
 			DPAA2_BUS_ERR("Interrupt registration failed for dpio");
 			return -1;
 		}
+		dpaa2_affine_dpio_intr_to_respective_core(dpio_dev->hw_id, cpu_id);
 	}
-	dpaa2_affine_dpio_intr_to_respective_core(dpio_dev->hw_id, cpu_id);
+#else
+	RTE_SET_USED(ethrx);
 #endif
 
 	return 0;
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
index 36f8669644..2a721eb005 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -3148,6 +3148,8 @@ dpaa2_napi_subscribe(struct rte_eth_dev *dev, uint16_t queue_id,
 	}
 	rte_atomic_store_explicit(&dpaa2_q->napi_sub_dpio, dpio,
 			rte_memory_order_release);
+	/* pin this portal's MSI to the worker's core so a CDAN wake lands locally */
+	dpaa2_dpio_affine_intr_to_core(dpio->hw_id);
 	return 0;
 }
 
-- 
2.43.0

