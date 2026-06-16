Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14179CD98DA
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 10:28:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5075740E17;
	Tue, 16 Jun 2026 12:27:49 +0200 (CEST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41]) by mails.dpdk.org (Postfix) with ESMTP id 900B240DF6
 for <dev@dpdk.org>; Tue, 16 Jun 2026 12:27:47 +0200 (CEST)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-45ef41adbc1so3223143f8f.0
 for <dev@dpdk.org>; Tue, 16 Jun 2026 03:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781605667; x=1782210467; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W92LjSNg6lbsLDIIH1HyltYsuIdRXJ5b/HbSyPwdLhw=;
 b=EaqnZECVP1mYTpJHytfcWe2Z3V5d8Q2meFf08Fvc9WRsqI62D81n2pY51Fb3ncolwV
 oPjthYh7GW+J/9NUc4xsPd1K+qtw/Z8P3KIYmcw92kUDq6dUiLf12UchJmA2nLPRBarA
 0BD6rdupsxFeDxD52ltKBtD/2DKHwrt+4ffH/vDEM5L122kDayl/siG0bFkIWjHOn6tP
 c3uik/sLJD47KXv2yAqjhkcaRu5frve7NPH9CJfeJURg5+7q0QYzusZyEvhb8lQKZPZT
 EEsKsQgO3f65W+Ku2wFR1YyG8b2XITA/FEmNakOlX6pRsr6FcBBzLMDj90wZiICU4A0F
 344A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781605667; x=1782210467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W92LjSNg6lbsLDIIH1HyltYsuIdRXJ5b/HbSyPwdLhw=;
 b=i8U09KfSYyZpKHDKK0pqW+zguBG7vgAHHwtTHepscMO9AdXp0GRG80Pu+FLIzEP4JU
 LPIUlETpGj/BELrFw71EJHQz4+ZzvcDGlfrXw7Wb2oO4XBCAh7KxTWUfsK1khAKzytN/
 YRUeZ9lmrb51nK7IyYgmUD4l1qMujPlij3+oCq1lqubGrQy2vZpLqeNjGi9sB+/C8yrD
 sXA7+ryJthllyF1guXTOG0emx5La+XaX6Me7zpuJ0jHeWfHzyDPkcdJbXLT5ZyLqLBjp
 Go15cXND/dZk2zWVAq0nhAeU6NYVVh9Okw6JWXLWTiQP4VLxVJOI4Aqof9DQBPqVOXeg
 ObBg==
X-Gm-Message-State: AOJu0Yzm+JHMtGjT8HLSPKuPVF2EF9JYdZxA8sPlE30+eSipJKw82M18
 Js7GZrbs/kdTHE/5njD17Atcn97pOYDdWk+iSBHzCgMP5A6QPANbJZQTVvRgymTX
X-Gm-Gg: Acq92OGXpQvtTxWrb7/LBbI332R17uwJzyn+RJwdEoJFwmZ3opQcSsBIElG+bTmQw1k
 nqAJrD3ihPxDtJraOQu11hxqyLBVpbV6aLr6GeuDWa/EBAVrswC0yQ9q8lJmlhvtlLC64K0ktnX
 fWpXLMcrBnEWXN+GAYnu5EecMkQt5F9dQJKr0SnZSjaGjovDvoDcwg/vY5kwvNxgKWCSC26OVF8
 I8HeFpgBHW9njH+IpeboJaLZCc5y3CcQDhUG+Io6znDATCnBbcxMX22MuWAVYPq+L/B/3W6f1+D
 zASEGeklImWGdS1F/NIL72JeUuDoFEyMni1BtPZi/hte5dMvdWadFrANTZADz0MbCKruj8I55Gk
 DBBV0NZDZUZYNJ5skbOP5oiPHP3/zImz0tUWf6MfsRPJpRHMJbnGhaomhO/bpWhlfEUkFMXb34T
 ETR0hYKv/xPG7qpoeHJzZ/qgcPeIDdaY+1a29RV+zJ564CYJIHXZDwSvdoeaQO30w=
X-Received: by 2002:a05:6000:2082:b0:43d:dd:8ca4 with SMTP id
 ffacd0b85a97d-46074b82278mr20426907f8f.14.1781605666940; 
 Tue, 16 Jun 2026 03:27:46 -0700 (PDT)
Received: from freepad.iliad.local (free-mobile.vlq16.iliad.fr. [213.36.7.11])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2b0d4fsm47050227f8f.24.2026.06.16.03.27.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:27:46 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: Maxime Leroy <maxime@leroys.fr>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v2 4/6] bus/fslmc/dpio: tune DQRI interrupt coalescing holdoff
Date: Tue, 16 Jun 2026 12:27:24 +0200
Message-ID: <20260616102727.708948-5-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616102727.708948-1-maxime@leroys.fr>
References: <20260611154926.392670-1-maxime@leroys.fr>
 <20260616102727.708948-1-maxime@leroys.fr>
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

The portal DQRI interrupt used a fixed threshold of 3 and a raw 0xFF
timeout. Parameterize dpaa2_dpio_intr_init() with (threshold, timeout) so
each mode supplies its own: the event driver keeps the legacy 3 / 0xFF
and its DPAA2_PORTAL_INTR_THRESHOLD / DPAA2_PORTAL_INTR_TIMEOUT env-var
overrides, while rx-queue interrupts default the threshold to the HW DQRR
ring depth (ring-1, =7 on QBMan >= 4.1) and use a coalescing holdoff in
microseconds, converted to ITP units from the MC-reported QBMan clock
(itp = holdoff_us * clk_MHz / 256, capped at the 12-bit field). The setup
is portal-wide and idempotent, so the first mode to arm a given portal
wins; a portal is normally driven by a single mode.

The net/dpaa2 PMD exposes both rx-queue-interrupt knobs as per-port
devargs: drv_rx_intr_holdoff_us (default 100us) and drv_rx_intr_threshold
(default 0 = ring-1, clamped to [1, ring-1]). Also expose
dpaa2_dpio_intr_deinit() (no longer event-only), and on the intr_init
error paths close the epoll fd and disable the interrupt.

Add qbman_swp_dqrr_size() to expose the ring depth.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 doc/guides/nics/dpaa2.rst                     | 10 +++
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c      | 72 +++++++++++++------
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.h      | 12 +++-
 .../fslmc/qbman/include/fsl_qbman_portal.h    | 10 +++
 drivers/bus/fslmc/qbman/qbman_portal.c        |  6 ++
 drivers/net/dpaa2/dpaa2_ethdev.c              | 60 +++++++++++++++-
 drivers/net/dpaa2/dpaa2_ethdev.h              |  7 ++
 7 files changed, 152 insertions(+), 25 deletions(-)

diff --git a/doc/guides/nics/dpaa2.rst b/doc/guides/nics/dpaa2.rst
index 2d70bd0ab9..47a52c9287 100644
--- a/doc/guides/nics/dpaa2.rst
+++ b/doc/guides/nics/dpaa2.rst
@@ -492,6 +492,16 @@ for details.
   packets, so that user can check what is wrong with those packets.
   e.g. ``fslmc:dpni.1,drv_error_queue=1``
 
+* Use dev arg option ``drv_rx_intr_holdoff_us=<uint32>`` to set the Rx queue
+  interrupt coalescing holdoff in microseconds (default 100). Only applies in
+  Rx queue interrupt mode.
+  e.g. ``fslmc:dpni.1,drv_rx_intr_holdoff_us=50``
+
+* Use dev arg option ``drv_rx_intr_threshold=<uint32>`` to set the Rx queue
+  interrupt coalescing frame threshold; 0 (default) means the DQRR ring depth
+  minus one.
+  e.g. ``fslmc:dpni.1,drv_rx_intr_threshold=4``
+
 Enabling logs
 -------------
 
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
index e6b4e74b3b..c5525a94fa 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
@@ -206,12 +206,35 @@ dpaa2_affine_dpio_intr_to_respective_core(int32_t dpio_id, int cpu_id)
 }
 #endif /* RTE_EVENT_DPAA2 */
 
+/* holdoff (us) -> QBMan ITP units (256 cycles each), capped at the 12-bit field */
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_dpio_holdoff_to_itp)
+int dpaa2_dpio_holdoff_to_itp(struct dpaa2_dpio_dev *dpio_dev, uint32_t holdoff_us)
+{
+	uint32_t qman_mhz = 0;
+	struct dpio_attr attr;
+	uint64_t itp;
+
+	if (dpio_get_attributes(dpio_dev->dpio, CMD_PRI_LOW, dpio_dev->token, &attr) == 0)
+		qman_mhz = attr.clk / 1000000;
+	itp = qman_mhz ? ((uint64_t)holdoff_us * qman_mhz) / 256 : 0xFF;
+	if (itp > 0xfff)	/* 12-bit ITP field */
+		itp = 0xfff;
+
+	return (int)itp;
+}
+
+/* threshold: DQRR fill raising DQRI (< ring depth); timeout: holdoff in ITP units.
+ * Per-mode values from the caller (eventdev vs rx-queue intr); no env override.
+ * The DQRI config is portal-wide and this is idempotent: the first caller to
+ * arm a portal wins, a later caller's values are ignored (a portal normally
+ * serves a single mode).
+ */
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_dpio_intr_init)
-int dpaa2_dpio_intr_init(struct dpaa2_dpio_dev *dpio_dev, bool build_epoll)
+int dpaa2_dpio_intr_init(struct dpaa2_dpio_dev *dpio_dev, int threshold,
+			 int timeout, bool build_epoll)
 {
-	struct epoll_event epoll_ev;
 	int eventfd, dpio_epoll_fd, ret;
-	int threshold = 0x3, timeout = 0xFF;
+	struct epoll_event epoll_ev;
 
 	if (dpio_dev->intr_enabled)
 		return 0;
@@ -222,12 +245,6 @@ int dpaa2_dpio_intr_init(struct dpaa2_dpio_dev *dpio_dev, bool build_epoll)
 		return -1;
 	}
 
-	if (getenv("DPAA2_PORTAL_INTR_THRESHOLD"))
-		threshold = atoi(getenv("DPAA2_PORTAL_INTR_THRESHOLD"));
-
-	if (getenv("DPAA2_PORTAL_INTR_TIMEOUT"))
-		sscanf(getenv("DPAA2_PORTAL_INTR_TIMEOUT"), "%x", &timeout);
-
 	qbman_swp_interrupt_set_trigger(dpio_dev->sw_portal,
 					QBMAN_SWP_INTERRUPT_DQRI);
 	qbman_swp_interrupt_clear_status(dpio_dev->sw_portal, 0xffffffff);
@@ -238,9 +255,9 @@ int dpaa2_dpio_intr_init(struct dpaa2_dpio_dev *dpio_dev, bool build_epoll)
 	dpio_dev->epoll_fd = -1;
 
 	/* The event PMD dequeues by sleeping on a private epoll instance owned
-	 * by the portal, so build it here. A caller that waits on another
-	 * epoll (the net rx-queue-interrupt path uses the application's) skips
-	 * this.
+	 * by the portal, so build it here. The net rx-queue-interrupt path
+	 * exposes the raw eventfd through the generic ethdev API and waits on
+	 * the application's own epoll instead, so it skips this.
 	 */
 	if (build_epoll) {
 		dpio_epoll_fd = epoll_create(1);
@@ -269,11 +286,14 @@ int dpaa2_dpio_intr_init(struct dpaa2_dpio_dev *dpio_dev, bool build_epoll)
 	return 0;
 }
 
-#ifdef RTE_EVENT_DPAA2
-static void dpaa2_dpio_intr_deinit(struct dpaa2_dpio_dev *dpio_dev)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_dpio_intr_deinit)
+void dpaa2_dpio_intr_deinit(struct dpaa2_dpio_dev *dpio_dev)
 {
 	int ret;
 
+	if (!dpio_dev->intr_enabled)
+		return;
+
 	ret = rte_dpaa2_intr_disable(dpio_dev->intr_handle, 0);
 	if (ret)
 		DPAA2_BUS_ERR("DPIO interrupt disable failed");
@@ -284,7 +304,6 @@ static void dpaa2_dpio_intr_deinit(struct dpaa2_dpio_dev *dpio_dev)
 	}
 	dpio_dev->intr_enabled = 0;
 }
-#endif
 
 static int
 dpaa2_configure_stashing(struct dpaa2_dpio_dev *dpio_dev, int cpu_id)
@@ -306,9 +325,18 @@ dpaa2_configure_stashing(struct dpaa2_dpio_dev *dpio_dev, int cpu_id)
 	}
 
 #ifdef RTE_EVENT_DPAA2
-	if (dpaa2_dpio_intr_init(dpio_dev, true)) {
-		DPAA2_BUS_ERR("Interrupt registration failed for dpio");
-		return -1;
+	{
+		int threshold = 3, timeout = 0xFF;
+
+		if (getenv("DPAA2_PORTAL_INTR_THRESHOLD"))
+			threshold = atoi(getenv("DPAA2_PORTAL_INTR_THRESHOLD"));
+		if (getenv("DPAA2_PORTAL_INTR_TIMEOUT"))
+			sscanf(getenv("DPAA2_PORTAL_INTR_TIMEOUT"), "%x", &timeout);
+
+		if (dpaa2_dpio_intr_init(dpio_dev, threshold, timeout, true)) {
+			DPAA2_BUS_ERR("Interrupt registration failed for dpio");
+			return -1;
+		}
 	}
 	dpaa2_affine_dpio_intr_to_respective_core(dpio_dev->hw_id, cpu_id);
 #endif
@@ -319,9 +347,11 @@ dpaa2_configure_stashing(struct dpaa2_dpio_dev *dpio_dev, int cpu_id)
 static void dpaa2_put_qbman_swp(struct dpaa2_dpio_dev *dpio_dev)
 {
 	if (dpio_dev) {
-#ifdef RTE_EVENT_DPAA2
+		/* rx-queue interrupts (net PMD) can arm a portal without the
+		 * event driver; tear it down unconditionally. Safe when never
+		 * armed: intr_deinit returns early if intr is not enabled.
+		 */
 		dpaa2_dpio_intr_deinit(dpio_dev);
-#endif
 		rte_atomic16_clear(&dpio_dev->ref_count);
 	}
 }
@@ -512,6 +542,8 @@ dpaa2_create_dpio_device(int vdev_fd,
 		goto err;
 	}
 
+	DPAA2_BUS_DEBUG("QBMAN clk = %u Hz (%u MHz)", attr.clk, attr.clk / 1000000);
+
 	/* find the SoC type for the first time */
 	if (!dpaa2_svr_family) {
 		struct mc_soc_version mc_plat_info = {0};
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h
index 10dd968e5f..090fa14410 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h
@@ -50,9 +50,17 @@ int dpaa2_affine_qbman_swp(void);
 __rte_internal
 int dpaa2_affine_qbman_ethrx_swp(void);
 
-/* set up a DPIO portal's DQRI interrupt (rx-queue interrupt mode) */
+/* set up / tear down a DPIO portal's DQRI interrupt (rx-queue interrupt mode) */
 __rte_internal
-int dpaa2_dpio_intr_init(struct dpaa2_dpio_dev *dpio_dev, bool build_epoll);
+int dpaa2_dpio_intr_init(struct dpaa2_dpio_dev *dpio_dev, int threshold,
+			 int timeout, bool build_epoll);
+
+__rte_internal
+void dpaa2_dpio_intr_deinit(struct dpaa2_dpio_dev *dpio_dev);
+
+/* convert a coalescing holdoff (microseconds) to QBMan ITP units */
+__rte_internal
+int dpaa2_dpio_holdoff_to_itp(struct dpaa2_dpio_dev *dpio_dev, uint32_t holdoff_us);
 
 /* allocate memory for FQ - dq storage */
 __rte_internal
diff --git a/drivers/bus/fslmc/qbman/include/fsl_qbman_portal.h b/drivers/bus/fslmc/qbman/include/fsl_qbman_portal.h
index bb8bd86103..e9eda31927 100644
--- a/drivers/bus/fslmc/qbman/include/fsl_qbman_portal.h
+++ b/drivers/bus/fslmc/qbman/include/fsl_qbman_portal.h
@@ -157,6 +157,16 @@ uint32_t qbman_swp_intr_timeout_read_status(struct qbman_swp *p);
  */
 void qbman_swp_intr_timeout_write(struct qbman_swp *p, uint32_t mask);
 
+/**
+ * qbman_swp_dqrr_size() - Get the HW DQRR ring depth of a software portal.
+ * @p: the given software portal object.
+ *
+ * Returns the number of DQRR entries (4 on QBMan < 4.1, 8 on >= 4.1). Useful
+ * as the upper bound for the DQRR interrupt coalescing threshold.
+ */
+__rte_internal
+uint8_t qbman_swp_dqrr_size(struct qbman_swp *p);
+
 /**
  * qbman_swp_interrupt_get_trigger() - Get the data in software portal
  * interrupt enable register.
diff --git a/drivers/bus/fslmc/qbman/qbman_portal.c b/drivers/bus/fslmc/qbman/qbman_portal.c
index 947415363a..81c2d87e0a 100644
--- a/drivers/bus/fslmc/qbman/qbman_portal.c
+++ b/drivers/bus/fslmc/qbman/qbman_portal.c
@@ -433,6 +433,12 @@ void qbman_swp_intr_timeout_write(struct qbman_swp *p, uint32_t mask)
 	qbman_cinh_write(&p->sys, QBMAN_CINH_SWP_ITPR, mask);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_dqrr_size)
+uint8_t qbman_swp_dqrr_size(struct qbman_swp *p)
+{
+	return p->dqrr.dqrr_size;
+}
+
 uint32_t qbman_swp_interrupt_get_trigger(struct qbman_swp *p)
 {
 	return qbman_cinh_read(&p->sys, QBMAN_CINH_SWP_IER);
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 61e7c820de..76e2df6167 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -36,6 +36,9 @@
 #define DRIVER_ERROR_QUEUE  "drv_err_queue"
 #define DRIVER_NO_TAILDROP  "drv_no_taildrop"
 #define DRIVER_NO_DATA_STASHING "drv_no_data_stashing"
+#define DRIVER_RX_INTR_HOLDOFF_US "drv_rx_intr_holdoff_us"
+#define DPAA2_RX_INTR_HOLDOFF_US_DEF 100
+#define DRIVER_RX_INTR_THRESHOLD "drv_rx_intr_threshold"
 #define CHECK_INTERVAL         100  /* 100ms */
 #define MAX_REPEAT_TIME        90   /* 9s (90 * 100ms) in total */
 
@@ -2873,7 +2876,7 @@ dpaa2_dev_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
 	struct dpaa2_queue *dpaa2_q = priv->rx_vq[queue_id];
 	struct dpaa2_dpio_dev *dpio, *old;
-	int ret;
+	int ret, threshold, timeout, dqrr_max;
 
 	if (!dpaa2_q->napi_dpcon)
 		return -ENOTSUP;	/* no channel -> caller keeps polling */
@@ -2882,10 +2885,22 @@ dpaa2_dev_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
 		return -EIO;
 	dpio = DPAA2_PER_LCORE_ETHRX_DPIO;
 
+	/* threshold from drv_rx_intr_threshold (0 = ring-1), holdoff from
+	 * drv_rx_intr_holdoff_us. idempotent: no-op if the dpio is already
+	 * armed (e.g. event driver)
+	 */
+	dqrr_max = qbman_swp_dqrr_size(dpio->sw_portal) - 1;
+	threshold = priv->rx_intr_threshold ? (int)priv->rx_intr_threshold : dqrr_max;
+	if (threshold < 1 || threshold > dqrr_max) {
+		DPAA2_PMD_WARN("drv_rx_intr_threshold %d out of [1, %d], clamping",
+			       threshold, dqrr_max);
+		threshold = threshold < 1 ? 1 : dqrr_max;
+	}
+	timeout = dpaa2_dpio_holdoff_to_itp(dpio, priv->rx_intr_holdoff_us);
 	/* build_epoll=false: the generic ethdev rx-intr API waits on the
 	 * application epoll, not the portal's private one (event PMD only).
 	 */
-	ret = dpaa2_dpio_intr_init(dpio, false);	/* VFIO eventfd, no MC */
+	ret = dpaa2_dpio_intr_init(dpio, threshold, timeout, false);
 	if (ret)
 		return ret;
 
@@ -3139,6 +3154,35 @@ dpaa2_get_devargs(struct rte_devargs *devargs, const char *key)
 	return 1;
 }
 
+static int
+u32_devarg_handler(__rte_unused const char *key, const char *value, void *opaque)
+{
+	char *end;
+	unsigned long v = strtoul(value, &end, 0);
+
+	if (*value == '\0' || *end != '\0' || v > UINT32_MAX)
+		return -1;
+	*(uint32_t *)opaque = (uint32_t)v;
+
+	return 0;
+}
+
+/* Read a u32-valued devarg into *out, leaving *out untouched if absent. */
+static void
+dpaa2_get_devargs_u32(struct rte_devargs *devargs, const char *key, uint32_t *out)
+{
+	struct rte_kvargs *kvlist;
+
+	if (!devargs)
+		return;
+	kvlist = rte_kvargs_parse(devargs->args, NULL);
+	if (!kvlist)
+		return;
+	if (rte_kvargs_count(kvlist, key))
+		rte_kvargs_process(kvlist, key, u32_devarg_handler, out);
+	rte_kvargs_free(kvlist);
+}
+
 static int
 dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 {
@@ -3166,6 +3210,14 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 		DPAA2_PMD_INFO("No RX prefetch mode");
 	}
 
+	priv->rx_intr_holdoff_us = DPAA2_RX_INTR_HOLDOFF_US_DEF;
+	dpaa2_get_devargs_u32(dev->devargs, DRIVER_RX_INTR_HOLDOFF_US,
+			      &priv->rx_intr_holdoff_us);
+
+	priv->rx_intr_threshold = 0;
+	dpaa2_get_devargs_u32(dev->devargs, DRIVER_RX_INTR_THRESHOLD,
+			      &priv->rx_intr_threshold);
+
 	if (dpaa2_get_devargs(dev->devargs, DRIVER_LOOPBACK_MODE)) {
 		priv->flags |= DPAA2_RX_LOOPBACK_MODE;
 		DPAA2_PMD_INFO("Rx loopback mode");
@@ -3681,5 +3733,7 @@ RTE_PMD_REGISTER_PARAM_STRING(NET_DPAA2_PMD_DRIVER_NAME,
 		DRIVER_RX_PARSE_ERR_DROP "=<int>"
 		DRIVER_ERROR_QUEUE "=<int>"
 		DRIVER_NO_TAILDROP "=<int>"
-		DRIVER_NO_DATA_STASHING "=<int>");
+		DRIVER_NO_DATA_STASHING "=<int> "
+		DRIVER_RX_INTR_HOLDOFF_US "=<uint32> "
+		DRIVER_RX_INTR_THRESHOLD "=<uint32>");
 RTE_LOG_REGISTER_DEFAULT(dpaa2_logtype_pmd, NOTICE);
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index 3765f79e84..84785c0561 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -412,6 +412,13 @@ struct dpaa2_dev_priv {
 	uint8_t max_cgs;
 	uint8_t cgid_in_use[MAX_RX_QUEUES];
 
+	/* DQRI holdoff (us) for rx-queue interrupts (drv_rx_intr_holdoff_us) */
+	uint32_t rx_intr_holdoff_us;
+	/* DQRI threshold for rx-queue interrupts (drv_rx_intr_threshold);
+	 * 0 = auto (DQRR ring depth - 1)
+	 */
+	uint32_t rx_intr_threshold;
+
 	uint16_t dpni_ver_major;
 	uint16_t dpni_ver_minor;
 	uint32_t speed_capa;
-- 
2.43.0

