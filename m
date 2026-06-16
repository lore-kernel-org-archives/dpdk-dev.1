Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC11CD98DA
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 10:27:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 453C540DD5;
	Tue, 16 Jun 2026 12:27:47 +0200 (CEST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44]) by mails.dpdk.org (Postfix) with ESMTP id 92A0340DD5
 for <dev@dpdk.org>; Tue, 16 Jun 2026 12:27:45 +0200 (CEST)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-45f3cf907ceso2287123f8f.2
 for <dev@dpdk.org>; Tue, 16 Jun 2026 03:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781605665; x=1782210465; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=auTWjIJFIHypbzkavheiNzi2oifcxHsCjQZwKVJEeqg=;
 b=i56G3m4jdzSDafZbtytI3/+6+v4oQ7S5FFiHFthkg0h1WqWIpmG9ODT+RDh+m5d8w9
 7uPIHz5Akjy4G9MxH+9tzrhRgQ6niU4E8H9FwhCoYGOA45nAH6FqTGnKz6iET2xnU9Mz
 83qPk8sKCA9KG8PwcFilCA8fiVkd5P5+inwxb7fnNOb9LaOEQQ1xAG2fJcHmC/bRglvL
 k2Lt72oX1Tbi6dTxFe2AViWe0GXl6IciKDaaOGq8znFlMYv3NvvI0DG58ZX0JB7e0PfY
 HQMMbiGrbRiR5tADRTawvR2AZao5nB+wMcFY56IZWWD79ksDtrAwT7QpQjOi7fy/Pf04
 gcjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781605665; x=1782210465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=auTWjIJFIHypbzkavheiNzi2oifcxHsCjQZwKVJEeqg=;
 b=ki692JlDVGUnTqXYfV1pYVr5R+//rf/Rg6Rf5PRT1Js6pxfZVCyPXb8zPWZxECJwZP
 UyWganjkaNCMCGiQhhGcGZJTnr0EZmIPlw6B2f02ic/zS/jUuA9sh984Iq+61J/YqEVa
 dmz5x24AxAobeg3rt96drGraiXgaAGFh2ExYzuzS1GNuxB1a13VtQb1H8dH1xwULss4g
 YgUCkaPOE7LHC2GQ+Ur1/70UNR8qeUvSVQo6IC/VWG9tGnbCJDkUCSumX3BZBTTQSdt+
 BWJcFUFeJZdzQw0fVA/VzcDsVrAFx+ZRV5kdiIIQbUsGL33dlm19FlKSGwZ94AnubPmo
 Mw8g==
X-Gm-Message-State: AOJu0YyU6V1V/Me4d5NR8V3YWrezIcHlQyT0vcVbyckh/PQs2UAhxJYB
 k/Hq53cTDujvLLICh3ZbVoFAofyO9GFYqMgyLgJUM7tF8sHDtzXJx/QqGutR9T37
X-Gm-Gg: Acq92OFs3aH7XQ9hJb8RJPEoEapUU5Qr3m2I/TjrCWH22GPiwrbpMap5BrhMKH+eMcq
 5BjEw1sGIw/W+gu7zRmhiQ71hp99fZmmBTyeGg+od5iszIOmCkfsTsg3Hb+cfvh33v/Ns14Fe2q
 biZIBusymH9DzWFBfM3wCmOYzPXjo7HJV3BiGlKJGsCsH9Weta15lTsDCcq5rEtrTFMpj0unJ2V
 VsfSyB1iyLRt/9wmjBnUmhKKYAYcp1e9Kvg6+pgb08x3VTn8sBJQLO9Cvc0JGcGS7hENKmHMdXk
 Sr3aNMCBurMowhHBGpmO4XtO6SdG46xaaqmT2c+gHA9jGYPhOPF9bglGaqhAxjOHfQraz9GR9Sg
 v/qFolnlKL78Aoq2WBCxMXuFUckQZ9qs7PkaWAjFQIFiF8csV8K5XcI4WkMEdBNDxOi+0nDG9L0
 C25sTJBxiWDgLv/J0r7UOBkkxnUJJEY2f9hGEX6WcZbYH+FoWjjcDz
X-Received: by 2002:a5d:5d87:0:b0:45e:da9b:97d6 with SMTP id
 ffacd0b85a97d-46074a8a2a8mr22775046f8f.27.1781605664715; 
 Tue, 16 Jun 2026 03:27:44 -0700 (PDT)
Received: from freepad.iliad.local (free-mobile.vlq16.iliad.fr. [213.36.7.11])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2c3782sm38578876f8f.25.2026.06.16.03.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:27:44 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: Maxime Leroy <maxime@leroys.fr>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v2 3/6] net/dpaa2: support Rx queue interrupts
Date: Tue, 16 Jun 2026 12:27:23 +0200
Message-ID: <20260616102727.708948-4-maxime@leroys.fr>
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

Implement .rx_queue_intr_enable / .rx_queue_intr_disable so a worker
can sleep on a queue's data-availability notification instead of
busy-polling, through the generic rte_eth_dev_rx_intr_* API.

A worker wakes on its software portal's DQRI, which fires when the
portal's DQRR holds frames, so the Rx FQ must be scheduled to a channel
that portal dequeues. The natural dpni_set_queue with a notification
destination holds the global MC lock long enough to wedge the firmware
and must target a disabled dpni. But the polling portal is only known
once a worker affines, after dev_start, so the destination cannot be
the worker's portal.

Bind each Rx FQ to its own DPCON channel instead. The default Rx burst
pulls frames from the FQ with a volatile dequeue and cannot be
interrupt-driven; to wake on the DQRI the FQ must be pushed to the
portal's DQRR. dev_start issues the DEST_DPCON set_queue statically on
the still-disabled dpni with no knowledge of the polling lcore; a worker
later subscribes its own ethrx portal to the channel and arms the DQRI
in rx_queue_intr_enable (a one-shot per-portal MC op plus QBMan, never
the wedging set_queue).

This pushed/DQRR consumption is how the event PMD works, but the DPCON
use differs. The event PMD uses one DPCON per worker, concentrates N
FQs onto it, and lets the QBMan scheduler load-balance events across
cores. Here affinity is static and there is no scheduling, so each FQ
gets its own DPCON (one per FQ, more channels, drawn from the shared
pool that the DPCON move to the fslmc bus now feeds), bound once at
dev_start before the lcore is known. Frames are delivered by
rte_eth_rx_burst (dpaa2_dev_rx_dqrr), not as events via
rte_event_dequeue.

rte_eth_dev_rx_intr_enable(q) subscribes the lcore portal to q's DPCON
and arms the DQRI. rte_eth_dev_rx_intr_ctl_q(q) adds q's eventfd (the
portal DQRI fd) to the thread epoll.

      wire
       |
    [ DPMAC ]
       |
    [ DPNI ]                                     (1)
       |
    TC0:  FQ0   FQ1   FQ2   FQ3                  (2)
           |     |     |     |                   (3)
        [DPCON][DPCON][DPCON][DPCON]
            \     |     |     /                  (4)
          [ DPIO A ]      [ DPIO B ]             (5)
             |               |
            DQRR            DQRR                 (6)
             |               |
            DQRI            DQRI                 (7)
             |               |
          eventfd         eventfd                (8)
             |               |
        rte_epoll_wait  rte_epoll_wait           (9)
             |               |
        dpaa2_dev_rx_dqrr                        (10)

  (1)  WRIOP picks a TC (QoS), then RSS-hashes within the TC to an FQ
  (2)  FQ0..FQ3 are the rte_eth Rx queues
  (3)  dpni_set_queue(DEST_DPCON): one DPCON per FQ
  (4)  the lcore portal subscribes to its DPCONs (push_set)
  (5)  one QBMan software portal per lcore
  (6)  QMan pushes the FDs into the portal DQRR
  (7)  DQRI is raised when the DQRR is non-empty
  (8)  a portal's queues share one fd (its DQRI eventfd)
  (9)  worker sleeps here when all its queues are idle
  (10) dpaa2_dev_rx_dqrr drains the DQRR, demuxes FDs to FQs by fqd_ctx

The DQRI and eventfd are portal-wide: a queue's eventfd is its portal's
DQRI fd, and the inhibit bit is refcounted by armed queues so disabling
one queue never masks a sibling. The static per-queue bind also lets a
queue be re-homed to another lcore at runtime, the new worker
reclaiming the channel, with no set_queue and no port stop.

On single-core 64-byte forwarding this interrupt path runs at ~5.0 Mpps
versus ~5.86 Mpps polling: per-frame DQRR demux and consume cost about
15 percent over the polling batch dequeue.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 doc/guides/nics/features/dpaa2.ini            |   1 +
 doc/guides/rel_notes/release_26_07.rst        |   4 +
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c      |  11 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.h      |   4 +
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h       |  27 +-
 .../fslmc/qbman/include/fsl_qbman_portal.h    |   1 +
 drivers/bus/fslmc/qbman/qbman_portal.c        |   1 +
 drivers/net/dpaa2/dpaa2_ethdev.c              | 291 +++++++++++++++++-
 drivers/net/dpaa2/dpaa2_ethdev.h              |   3 +
 drivers/net/dpaa2/dpaa2_rxtx.c                | 122 ++++++++
 10 files changed, 459 insertions(+), 6 deletions(-)

diff --git a/doc/guides/nics/features/dpaa2.ini b/doc/guides/nics/features/dpaa2.ini
index 5f9c587847..fff313603f 100644
--- a/doc/guides/nics/features/dpaa2.ini
+++ b/doc/guides/nics/features/dpaa2.ini
@@ -7,6 +7,7 @@
 Speed capabilities   = Y
 Link status          = Y
 Link status event    = Y
+Rx interrupt         = Y
 Burst mode info      = Y
 Queue start/stop     = Y
 Scattered Rx         = Y
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 5d7aa8d1bf..3bc49c3910 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -140,6 +140,10 @@ New Features
 
   * Added support for selective Rx in scalar SPRQ Rx path.
 
+* **Updated NXP dpaa2 driver.**
+
+  * Added Rx queue interrupt support.
+
 * **Updated PCAP ethernet driver.**
 
   * Added support for VLAN insertion and stripping.
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
index 3a5abb2e6d..e6b4e74b3b 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
@@ -204,13 +204,18 @@ dpaa2_affine_dpio_intr_to_respective_core(int32_t dpio_id, int cpu_id)
 
 	fclose(file);
 }
+#endif /* RTE_EVENT_DPAA2 */
 
-static int dpaa2_dpio_intr_init(struct dpaa2_dpio_dev *dpio_dev, bool build_epoll)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_dpio_intr_init)
+int dpaa2_dpio_intr_init(struct dpaa2_dpio_dev *dpio_dev, bool build_epoll)
 {
 	struct epoll_event epoll_ev;
 	int eventfd, dpio_epoll_fd, ret;
 	int threshold = 0x3, timeout = 0xFF;
 
+	if (dpio_dev->intr_enabled)
+		return 0;
+
 	ret = rte_dpaa2_intr_enable(dpio_dev->intr_handle, 0);
 	if (ret) {
 		DPAA2_BUS_ERR("Interrupt registration failed");
@@ -259,9 +264,12 @@ static int dpaa2_dpio_intr_init(struct dpaa2_dpio_dev *dpio_dev, bool build_epol
 		dpio_dev->epoll_fd = dpio_epoll_fd;
 	}
 
+	dpio_dev->intr_enabled = 1;
+
 	return 0;
 }
 
+#ifdef RTE_EVENT_DPAA2
 static void dpaa2_dpio_intr_deinit(struct dpaa2_dpio_dev *dpio_dev)
 {
 	int ret;
@@ -274,6 +282,7 @@ static void dpaa2_dpio_intr_deinit(struct dpaa2_dpio_dev *dpio_dev)
 		close(dpio_dev->epoll_fd);
 		dpio_dev->epoll_fd = -1;
 	}
+	dpio_dev->intr_enabled = 0;
 }
 #endif
 
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h
index 328e1e788a..10dd968e5f 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h
@@ -50,6 +50,10 @@ int dpaa2_affine_qbman_swp(void);
 __rte_internal
 int dpaa2_affine_qbman_ethrx_swp(void);
 
+/* set up a DPIO portal's DQRI interrupt (rx-queue interrupt mode) */
+__rte_internal
+int dpaa2_dpio_intr_init(struct dpaa2_dpio_dev *dpio_dev, bool build_epoll);
+
 /* allocate memory for FQ - dq storage */
 __rte_internal
 int
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
index 79a2ec41e3..af75e96b27 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
@@ -133,6 +133,8 @@ struct dpaa2_dpio_dev {
 	struct rte_intr_handle *intr_handle; /* Interrupt related info */
 	int32_t	epoll_fd; /**< File descriptor created for interrupt polling */
 	int32_t hw_id; /**< An unique ID of this DPIO device instance */
+	uint8_t intr_enabled; /**< DQRI portal interrupt already set up */
+	uint16_t ethrx_intr_refcnt; /**< rx queues currently armed on this portal */
 	struct dpaa2_portal_dqrr dpaa2_held_bufs;
 };
 
@@ -164,6 +166,20 @@ typedef void (dpaa2_queue_cb_dqrr_t)(struct qbman_swp *swp,
 typedef void (dpaa2_queue_cb_eqresp_free_t)(uint16_t eqresp_ci,
 					struct dpaa2_queue *dpaa2_q);
 
+#define DPAA2_NAPI_FD_STASH_SIZE 64	/*!< power of 2; >= 2x rx burst so the
+					 * peer port's frames fit before HW
+					 * backpressure (2 ports/worker)
+					 */
+
+/* Lcore-local FIFO of raw FDs demuxed to this queue by another queue's burst
+ * on the same portal (see dpaa2_queue::napi_stash).
+ */
+struct dpaa2_napi_stash {
+	uint16_t head;	/*!< pop index (drain) */
+	uint16_t tail;	/*!< push index (park) */
+	struct qbman_fd fd[DPAA2_NAPI_FD_STASH_SIZE];
+};
+
 struct __rte_cache_aligned dpaa2_queue {
 	struct rte_mempool *mb_pool; /**< mbuf pool to populate RX ring. */
 	union {
@@ -176,7 +192,7 @@ struct __rte_cache_aligned dpaa2_queue {
 	uint8_t cgid;		/*! < Congestion Group id for this queue */
 	uint64_t rx_pkts;
 	uint64_t tx_pkts;
-	uint64_t err_pkts;
+	uint64_t err_pkts;	/*!< also counts NAPI stash-full drops (imissed) */
 	union {
 		/**Ingress*/
 		struct queue_storage_info_t *q_storage[RTE_MAX_LCORE];
@@ -195,6 +211,15 @@ struct __rte_cache_aligned dpaa2_queue {
 	uint64_t offloads;
 	uint64_t lpbk_cntx;
 	uint8_t data_stashing_off;
+	/* NAPI rx-interrupt: per-queue DPCON bound to this FQ at dev_start
+	 * (DEST_DPCON, static); the polling worker subscribes its ethrx portal
+	 * to the channel and arms the DQRI, rx_dqrr drains+demuxes by fqd_ctx.
+	 */
+	struct dpaa2_dpcon_dev *napi_dpcon;	/*!< notif channel, NULL = napi off */
+	RTE_ATOMIC(struct dpaa2_dpio_dev *) napi_sub_dpio;	/*!< subscribed portal or NULL */
+	uint8_t napi_channel_index;		/*!< portal-local static-dequeue idx */
+	uint8_t napi_armed;			/*!< this queue requests DQRI wakeups */
+	struct dpaa2_napi_stash napi_stash;	/*!< NAPI/DQRR demux FDs (~2 KB) */
 };
 
 struct swp_active_dqs {
diff --git a/drivers/bus/fslmc/qbman/include/fsl_qbman_portal.h b/drivers/bus/fslmc/qbman/include/fsl_qbman_portal.h
index 5375ea386d..bb8bd86103 100644
--- a/drivers/bus/fslmc/qbman/include/fsl_qbman_portal.h
+++ b/drivers/bus/fslmc/qbman/include/fsl_qbman_portal.h
@@ -189,6 +189,7 @@ int qbman_swp_interrupt_get_inhibit(struct qbman_swp *p);
  * @p: the given software portal object.
  * @mask: The value to set in SWP_IIR register.
  */
+__rte_internal
 void qbman_swp_interrupt_set_inhibit(struct qbman_swp *p, int inhibit);
 
 	/************/
diff --git a/drivers/bus/fslmc/qbman/qbman_portal.c b/drivers/bus/fslmc/qbman/qbman_portal.c
index 84853924e7..947415363a 100644
--- a/drivers/bus/fslmc/qbman/qbman_portal.c
+++ b/drivers/bus/fslmc/qbman/qbman_portal.c
@@ -448,6 +448,7 @@ int qbman_swp_interrupt_get_inhibit(struct qbman_swp *p)
 	return qbman_cinh_read(&p->sys, QBMAN_CINH_SWP_IIR);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_interrupt_set_inhibit)
 void qbman_swp_interrupt_set_inhibit(struct qbman_swp *p, int inhibit)
 {
 	qbman_cinh_write(&p->sys, QBMAN_CINH_SWP_IIR,
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 803a8321e0..61e7c820de 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -623,6 +623,8 @@ dpaa2_clear_queue_active_dps(struct dpaa2_queue *q, int num_lcores)
 	}
 }
 
+static void dpaa2_dev_rx_queue_intr_unbind(struct dpaa2_queue *dpaa2_q);
+
 static void
 dpaa2_free_rx_tx_queues(struct rte_eth_dev *dev)
 {
@@ -640,6 +642,12 @@ dpaa2_free_rx_tx_queues(struct rte_eth_dev *dev)
 		/* cleaning up queue storage */
 		for (i = 0; i < priv->nb_rx_queues; i++) {
 			dpaa2_q = priv->rx_vq[i];
+			if (dpaa2_q->napi_dpcon) {	/* release the rx-intr channel */
+				dpaa2_dev_rx_queue_intr_unbind(dpaa2_q);
+				rte_dpaa2_free_dpcon_dev(dpaa2_q->napi_dpcon);
+				dpaa2_q->napi_dpcon = NULL;
+				dpaa2_q->napi_sub_dpio = NULL;
+			}
 			dpaa2_clear_queue_active_dps(dpaa2_q,
 						RTE_MAX_LCORE);
 			dpaa2_queue_storage_free(dpaa2_q,
@@ -845,6 +853,19 @@ dpaa2_eth_dev_configure(struct rte_eth_dev *dev)
 		}
 	}
 
+	if (dev->data->dev_conf.intr_conf.rxq) {
+		if (!dev->intr_handle)
+			dev->intr_handle = rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
+		if (!dev->intr_handle ||
+		    rte_intr_vec_list_alloc(dev->intr_handle, "rxq_intr",
+				dev->data->nb_rx_queues) ||
+		    rte_intr_nb_efd_set(dev->intr_handle, dev->data->nb_rx_queues) ||
+		    rte_intr_type_set(dev->intr_handle, RTE_INTR_HANDLE_EXT)) {
+			DPAA2_PMD_ERR("Failed to set up rx-queue interrupts");
+			return -rte_errno;
+		}
+	}
+
 	dpaa2_tm_init(dev);
 
 	return 0;
@@ -863,6 +884,7 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 {
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
 	struct fsl_mc_io *dpni = dev->process_private;
+	bool dpcon_allocated = false;
 	struct dpaa2_queue *dpaa2_q;
 	struct dpni_queue cfg;
 	uint8_t options = 0;
@@ -903,6 +925,21 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	dpaa2_q->bp_array = rte_dpaa2_bpid_info;
 	dpaa2_q->offloads = rx_conf->offloads;
 
+	/* NAPI: grab a DPCON channel so dev_start can bind this FQ statically.
+	 * The DQRR burst replaces the poll path for every queue at once, so a
+	 * missing channel is fatal rather than a silent per-queue fallback.
+	 */
+	dpaa2_q->napi_sub_dpio = NULL;
+	if (dev->data->dev_conf.intr_conf.rxq && !dpaa2_q->napi_dpcon) {
+		dpaa2_q->napi_dpcon = rte_dpaa2_alloc_dpcon_dev();
+		if (!dpaa2_q->napi_dpcon) {
+			DPAA2_PMD_ERR("rxq %d: no DPCON for rx-queue interrupts",
+				      rx_queue_id);
+			return -ENODEV;
+		}
+		dpcon_allocated = true;
+	}
+
 	/*Get the flow id from given VQ id*/
 	flow_id = dpaa2_q->flow_id;
 	memset(&cfg, 0, sizeof(struct dpni_queue));
@@ -910,6 +947,10 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	options = options | DPNI_QUEUE_OPT_USER_CTX;
 	cfg.user_context = (size_t)(dpaa2_q);
 
+	/* clear any stale DPIO dest left scheduled by a prior rx-intr run */
+	options |= DPNI_QUEUE_OPT_DEST;
+	cfg.destination.type = DPNI_DEST_NONE;
+
 	/* check if a private cgr available. */
 	for (i = 0; i < priv->max_cgs; i++) {
 		if (!priv->cgid_in_use[i]) {
@@ -950,7 +991,7 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 			dpaa2_q->tc_index, flow_id, options, &cfg);
 	if (ret) {
 		DPAA2_PMD_ERR("Error in setting the rx flow: = %d", ret);
-		return ret;
+		goto err_free_dpcon;
 	}
 
 	dpaa2_q->nb_desc = nb_rx_desc;
@@ -991,7 +1032,7 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 		if (ret) {
 			DPAA2_PMD_ERR("Error in setting taildrop. err=(%d)",
 				ret);
-			return ret;
+			goto err_free_dpcon;
 		}
 	} else { /* Disable tail Drop */
 		struct dpni_taildrop taildrop = {0};
@@ -1011,12 +1052,22 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 		if (ret) {
 			DPAA2_PMD_ERR("Error in setting taildrop. err=(%d)",
 				ret);
-			return ret;
+			goto err_free_dpcon;
 		}
 	}
 
 	dev->data->rx_queues[rx_queue_id] = dpaa2_q;
 	return 0;
+
+err_free_dpcon:
+	/* free only the DPCON this call allocated; a pre-existing one belongs to
+	 * an earlier setup and is released at dev_close
+	 */
+	if (dpcon_allocated) {
+		rte_dpaa2_free_dpcon_dev(dpaa2_q->napi_dpcon);
+		dpaa2_q->napi_dpcon = NULL;
+	}
+	return ret;
 }
 
 static int
@@ -1175,6 +1226,62 @@ dpaa2_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	return 0;
 }
 
+/* Fully release a queue's rx-interrupt state: detach the FQ from its DPCON,
+ * unbind the static dequeue channel from the portal and free any stashed FDs.
+ * Teardown only: the port is stopped and the portal quiesced; not a runtime
+ * rx_queue_intr_disable() replacement. Call before freeing the DPCON.
+ */
+static void
+dpaa2_dev_rx_queue_intr_unbind(struct dpaa2_queue *dpaa2_q)
+{
+	struct dpaa2_dev_priv *priv;
+	struct dpaa2_dpio_dev *dpio;
+	struct fsl_mc_io *dpni;
+	struct dpni_queue cfg;
+	int ret;
+
+	if (!dpaa2_q || !dpaa2_q->napi_dpcon)
+		return;
+
+	/* detach the FQ from its DPCON so it no longer points at a channel
+	 * about to be returned to the pool (dpni is disabled at teardown)
+	 */
+	priv = dpaa2_q->eth_data->dev_private;
+	dpni = priv->eth_dev->process_private;
+	memset(&cfg, 0, sizeof(cfg));
+	cfg.destination.type = DPNI_DEST_NONE;
+	ret = dpni_set_queue(dpni, CMD_PRI_LOW, priv->token, DPNI_QUEUE_RX,
+			     dpaa2_q->tc_index, dpaa2_q->flow_id,
+			     DPNI_QUEUE_OPT_DEST, &cfg);
+	if (ret)
+		DPAA2_PMD_ERR("napi: DEST_NONE rxq flow %u: %d",
+			      dpaa2_q->flow_id, ret);
+
+	/* unbind the static dequeue channel from the portal it was armed on */
+	dpio = rte_atomic_load_explicit(&dpaa2_q->napi_sub_dpio,
+			rte_memory_order_acquire);
+	if (dpio) {
+		qbman_swp_push_set(dpio->sw_portal,
+				dpaa2_q->napi_channel_index, 0);
+		if (dpaa2_q->napi_armed) {
+			dpaa2_q->napi_armed = 0;
+			if (dpio->ethrx_intr_refcnt > 0 &&
+			    --dpio->ethrx_intr_refcnt == 0)
+				qbman_swp_interrupt_set_inhibit(dpio->sw_portal, 1);
+		}
+		ret = dpio_remove_static_dequeue_channel(dpio->dpio, CMD_PRI_LOW,
+				dpio->token, dpaa2_q->napi_dpcon->dpcon_id);
+		if (ret)
+			DPAA2_PMD_ERR("napi: remove DPCON %d static dequeue channel: %d",
+				      dpaa2_q->napi_dpcon->dpcon_id, ret);
+		rte_atomic_store_explicit(&dpaa2_q->napi_sub_dpio, NULL,
+				rte_memory_order_release);
+	}
+
+	/* free FDs parked for this queue but never drained by a burst */
+	dpaa2_dev_rx_queue_napi_stash_drain(dpaa2_q);
+}
+
 static void
 dpaa2_dev_rx_queue_release(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 {
@@ -1204,6 +1311,12 @@ dpaa2_dev_rx_queue_release(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 		priv->cgid_in_use[dpaa2_q->cgid] = 0;
 		dpaa2_q->cgid = DPAA2_INVALID_CGID;
 	}
+
+	if (dpaa2_q->napi_dpcon) {
+		dpaa2_dev_rx_queue_intr_unbind(dpaa2_q);
+		rte_dpaa2_free_dpcon_dev(dpaa2_q->napi_dpcon);
+		dpaa2_q->napi_dpcon = NULL;
+	}
 }
 
 static int
@@ -1354,6 +1467,36 @@ dpaa2_dev_start(struct rte_eth_dev *dev)
 	intr_handle = dpaa2_dev->intr_handle;
 
 	PMD_INIT_FUNC_TRACE();
+
+	/* NAPI: bind each rx FQ to its own DPCON channel while the dpni is still
+	 * disabled (a DEST set_queue on an enabled dpni wedges the shared MC).
+	 * Static, affinity-free; the polling worker subscribes its portal later.
+	 */
+	if (dev->data->dev_conf.intr_conf.rxq) {
+		for (i = 0; i < data->nb_rx_queues; i++) {
+			dpaa2_q = data->rx_queues[i];
+			if (!dpaa2_q->napi_dpcon)
+				continue;
+			memset(&cfg, 0, sizeof(cfg));
+			cfg.destination.type = DPNI_DEST_DPCON;
+			cfg.destination.id = dpaa2_q->napi_dpcon->dpcon_id;
+			cfg.user_context = (size_t)dpaa2_q;
+			ret = dpni_set_queue(dpni, CMD_PRI_LOW, priv->token,
+					DPNI_QUEUE_RX, dpaa2_q->tc_index,
+					dpaa2_q->flow_id,
+					DPNI_QUEUE_OPT_DEST | DPNI_QUEUE_OPT_USER_CTX,
+					&cfg);
+			if (ret) {
+				DPAA2_PMD_ERR("napi: DPCON bind rxq %d: %d", i, ret);
+				return ret;
+			}
+		}
+		/* DQRR burst for all queues; a queue only yields frames once
+		 * rx_queue_intr_enable() has subscribed its portal
+		 */
+		dev->rx_pkt_burst = dpaa2_dev_rx_dqrr;
+	}
+
 	ret = dpni_enable(dpni, CMD_PRI_LOW, priv->token);
 	if (ret) {
 		DPAA2_PMD_ERR("Failure in enabling dpni %d device: err=%d",
@@ -1824,6 +1967,13 @@ dpaa2_dev_stats_get(struct rte_eth_dev *dev,
 	stats->oerrors = value.page_2.egress_discarded_frames;
 	stats->imissed = value.page_2.ingress_nobuffer_discards;
 
+	/* software Rx drops (full napi stash) are not in the HW counters */
+	for (i = 0; i < priv->nb_rx_queues; i++) {
+		dpaa2_rxq = priv->rx_vq[i];
+		if (dpaa2_rxq != NULL)
+			stats->imissed += dpaa2_rxq->err_pkts;
+	}
+
 	/* Fill in per queue stats */
 	if (qstats != NULL) {
 		for (i = 0; (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) &&
@@ -2137,8 +2287,10 @@ dpaa2_dev_stats_reset(struct rte_eth_dev *dev)
 	/* Reset the per queue stats in dpaa2_queue structure */
 	for (i = 0; i < priv->nb_rx_queues; i++) {
 		dpaa2_q = priv->rx_vq[i];
-		if (dpaa2_q)
+		if (dpaa2_q) {
 			dpaa2_q->rx_pkts = 0;
+			dpaa2_q->err_pkts = 0;
+		}
 	}
 
 	for (i = 0; i < priv->nb_tx_queues; i++) {
@@ -2698,6 +2850,135 @@ rte_pmd_dpaa2_thread_init(void)
 	}
 }
 
+/* Arm rx-queue interrupts on the worker lcore: subscribe its ethrx portal to
+ * the queue's DPCON channel (one-shot per-portal MC) and unmask the portal DQRI
+ * (pure QBMan).
+ *
+ * Affinity is static queue-to-lcore; a lcore may own several rx queues. The
+ * DQRI and the eventfd are portal-wide, so frames are demuxed by fqd_ctx in the
+ * burst and the portal's inhibit bit is reference-counted by the number of its
+ * queues currently armed (ethrx_intr_refcnt) -- disabling one queue must not
+ * mask wakeups still wanted by its siblings. napi_armed and ethrx_intr_refcnt
+ * are plain (not atomic): these ops run on the queue's owner lcore against its
+ * own portal (one portal per lcore), so per-portal isolation keeps them from
+ * racing, not control-plane serialization.
+ *
+ * A re-home reclaims the channel by poking the old portal, so the caller must
+ * have quiesced the previous owner and disabled the queue there; napi_armed is
+ * then 0 and only the new portal is counted.
+ */
+static int
+dpaa2_dev_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_queue *dpaa2_q = priv->rx_vq[queue_id];
+	struct dpaa2_dpio_dev *dpio, *old;
+	int ret;
+
+	if (!dpaa2_q->napi_dpcon)
+		return -ENOTSUP;	/* no channel -> caller keeps polling */
+
+	if (dpaa2_affine_qbman_ethrx_swp())
+		return -EIO;
+	dpio = DPAA2_PER_LCORE_ETHRX_DPIO;
+
+	/* build_epoll=false: the generic ethdev rx-intr API waits on the
+	 * application epoll, not the portal's private one (event PMD only).
+	 */
+	ret = dpaa2_dpio_intr_init(dpio, false);	/* VFIO eventfd, no MC */
+	if (ret)
+		return ret;
+
+	old = rte_atomic_load_explicit(&dpaa2_q->napi_sub_dpio, rte_memory_order_acquire);
+	if (old && old != dpio && dpaa2_q->napi_armed) {
+		DPAA2_PMD_ERR("rxq %d still armed on another portal; disable it first",
+			      queue_id);
+		return -EBUSY;
+	}
+	if (old != dpio) {
+		if (old) {	/* reclaim from old portal (quiesced; QBMan MMIO unsynced) */
+			qbman_swp_push_set(old->sw_portal,
+					dpaa2_q->napi_channel_index, 0);
+			ret = dpio_remove_static_dequeue_channel(old->dpio,
+					CMD_PRI_LOW, old->token,
+					dpaa2_q->napi_dpcon->dpcon_id);
+			/* push_set(0) above already stops the old portal from
+			 * dequeuing; a failed unbind only leaks a static-channel
+			 * slot on the old DPIO, so warn and proceed
+			 */
+			if (ret)
+				DPAA2_PMD_WARN("napi: reclaim rxq %d: %d",
+					       queue_id, ret);
+			/* on no portal until the add below succeeds */
+			rte_atomic_store_explicit(&dpaa2_q->napi_sub_dpio, NULL,
+					rte_memory_order_release);
+		}
+		ret = dpio_add_static_dequeue_channel(dpio->dpio, CMD_PRI_LOW,
+				dpio->token, dpaa2_q->napi_dpcon->dpcon_id,
+				&dpaa2_q->napi_channel_index);
+		if (ret) {
+			DPAA2_PMD_ERR("napi: subscribe rxq %d: %d", queue_id, ret);
+			return ret;
+		}
+		qbman_swp_push_set(dpio->sw_portal,
+				dpaa2_q->napi_channel_index, 1);
+		/* point this queue's eventfd at the portal's DQRI fd so the
+		 * generic rte_eth_dev_rx_intr_ctl_q epoll wakes on it
+		 */
+		if (rte_intr_vec_list_index_set(dev->intr_handle, queue_id, queue_id) ||
+		    rte_intr_efds_index_set(dev->intr_handle, queue_id,
+				rte_intr_fd_get(dpio->intr_handle))) {
+			DPAA2_PMD_ERR("napi: efd wiring rxq %d", queue_id);
+			/* unwind the half-done subscription so HW and driver
+			 * state stay consistent
+			 */
+			qbman_swp_push_set(dpio->sw_portal,
+					dpaa2_q->napi_channel_index, 0);
+			dpio_remove_static_dequeue_channel(dpio->dpio,
+					CMD_PRI_LOW, dpio->token,
+					dpaa2_q->napi_dpcon->dpcon_id);
+			return -EIO;
+		}
+		rte_atomic_store_explicit(&dpaa2_q->napi_sub_dpio, dpio, rte_memory_order_release);
+	}
+
+	/* arm this queue; the portal DQRI is unmasked only on the 0 -> 1 edge
+	 * of its armed-queue count
+	 */
+	if (!dpaa2_q->napi_armed) {
+		dpaa2_q->napi_armed = 1;
+		if (dpio->ethrx_intr_refcnt++ == 0) {
+			qbman_swp_interrupt_clear_status(dpio->sw_portal,
+					0xffffffff);
+			qbman_swp_interrupt_set_inhibit(dpio->sw_portal, 0);
+		}
+	}
+
+	return 0;
+}
+
+/* Disarm rx-queue interrupts for this queue. The portal DQRI is masked only
+ * once the last of its queues disarms; act on the portal the queue is actually
+ * subscribed to, not the caller's current portal.
+ */
+static int
+dpaa2_dev_rx_queue_intr_disable(struct rte_eth_dev *dev, uint16_t queue_id)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_queue *dpaa2_q = priv->rx_vq[queue_id];
+	struct dpaa2_dpio_dev *dpio;
+
+	dpio = rte_atomic_load_explicit(&dpaa2_q->napi_sub_dpio, rte_memory_order_acquire);
+	if (dpio && dpaa2_q->napi_armed) {
+		dpaa2_q->napi_armed = 0;
+		if (dpio->ethrx_intr_refcnt > 0 &&
+		    --dpio->ethrx_intr_refcnt == 0)
+			qbman_swp_interrupt_set_inhibit(dpio->sw_portal, 1);
+	}
+
+	return 0;
+}
+
 static struct eth_dev_ops dpaa2_ethdev_ops = {
 	.dev_configure	  = dpaa2_eth_dev_configure,
 	.dev_start	      = dpaa2_dev_start,
@@ -2726,6 +3007,8 @@ static struct eth_dev_ops dpaa2_ethdev_ops = {
 	.vlan_tpid_set	      = dpaa2_vlan_tpid_set,
 	.rx_queue_setup    = dpaa2_dev_rx_queue_setup,
 	.rx_queue_release  = dpaa2_dev_rx_queue_release,
+	.rx_queue_intr_enable = dpaa2_dev_rx_queue_intr_enable,
+	.rx_queue_intr_disable = dpaa2_dev_rx_queue_intr_disable,
 	.tx_queue_setup    = dpaa2_dev_tx_queue_setup,
 	.rx_burst_mode_get = dpaa2_dev_rx_burst_mode_get,
 	.tx_burst_mode_get = dpaa2_dev_tx_burst_mode_get,
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index 4da47a543a..3765f79e84 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -491,6 +491,9 @@ uint16_t dpaa2_dev_loopback_rx(void *queue, struct rte_mbuf **bufs,
 
 uint16_t dpaa2_dev_prefetch_rx(void *queue, struct rte_mbuf **bufs,
 			       uint16_t nb_pkts);
+uint16_t dpaa2_dev_rx_dqrr(void *queue, struct rte_mbuf **bufs,
+			   uint16_t nb_pkts);
+void dpaa2_dev_rx_queue_napi_stash_drain(struct dpaa2_queue *dpaa2_q);
 void dpaa2_dev_process_parallel_event(struct qbman_swp *swp,
 				      const struct qbman_fd *fd,
 				      const struct qbman_result *dq,
diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index b316e23e87..189accc1de 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -922,6 +922,128 @@ dpaa2_dev_prefetch_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	return num_rx;
 }
 
+/* Convert a DQRR'd FD (single or scatter-gather) to an mbuf and apply software
+ * VLAN strip, like the poll path.
+ */
+static inline struct rte_mbuf *
+dpaa2_dqrr_fd_to_mbuf(const struct qbman_fd *fd,
+		      struct rte_eth_dev_data *eth_data)
+{
+	struct rte_mbuf *m;
+
+	if (unlikely(DPAA2_FD_GET_FORMAT(fd) == qbman_fd_sg))
+		m = eth_sg_fd_to_mbuf(fd, eth_data->port_id);
+	else
+		m = eth_fd_to_mbuf(fd, eth_data->port_id);
+	if (eth_data->dev_conf.rxmode.offloads & RTE_ETH_RX_OFFLOAD_VLAN_STRIP)
+		rte_vlan_strip(m);
+	return m;
+}
+
+/* prefetch a DQRR'd FD's HW annotation (parse area) ahead of conversion */
+static inline void
+dpaa2_dqrr_prefetch_annot(const struct qbman_fd *fd)
+{
+	rte_prefetch0((void *)((size_t)DPAA2_IOVA_TO_VADDR(DPAA2_GET_FD_ADDR(fd))
+			       + DPAA2_FD_PTA_SIZE));
+}
+
+/* Free FDs a sibling burst parked in this queue's stash but that were never
+ * drained (queue released/freed while the lcore still held its frames).
+ */
+void
+dpaa2_dev_rx_queue_napi_stash_drain(struct dpaa2_queue *dpaa2_q)
+{
+	struct dpaa2_napi_stash *stash = &dpaa2_q->napi_stash;
+	const struct qbman_fd *fd;
+
+	while (stash->head != stash->tail) {
+		fd = &stash->fd[stash->head & (DPAA2_NAPI_FD_STASH_SIZE - 1)];
+		rte_pktmbuf_free(dpaa2_dqrr_fd_to_mbuf(fd, dpaa2_q->eth_data));
+		stash->head++;
+	}
+	stash->head = 0;
+	stash->tail = 0;
+}
+
+/* rx interrupt/DQRR path: the FQ is scheduled to a channel the lcore's ethrx
+ * portal statically dequeues -- a VDQ on a scheduled FQ never completes, so DQRR
+ * is the only model compatible with interrupt sleep. One portal serves every
+ * queue the lcore owns, so the burst demuxes by fqd_ctx: own frames are
+ * returned, foreign ones have their raw FD parked in the target queue's stash.
+ *
+ * The application must therefore poll all queues assigned to the lcore after a
+ * wakeup -- the same scheduling contract as plain DPDK polling. When a foreign
+ * queue's stash is full the FD is dropped (freed) rather than left on the shared
+ * DQRR ring, which would head-of-line block every other queue on the portal.
+ */
+uint16_t __rte_hot
+dpaa2_dev_rx_dqrr(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
+{
+	struct dpaa2_queue *dpaa2_q = queue;
+	struct rte_eth_dev_data *eth_data = dpaa2_q->eth_data;
+	struct dpaa2_napi_stash *stash = &dpaa2_q->napi_stash;
+	const struct qbman_result *dq;
+	const struct qbman_fd *fd;
+	struct dpaa2_queue *rxq;
+	struct qbman_swp *swp;
+	uint16_t num_rx = 0;
+
+	if (unlikely(!DPAA2_PER_LCORE_ETHRX_DPIO)) {
+		if (dpaa2_affine_qbman_ethrx_swp()) {
+			DPAA2_PMD_ERR("Failure in affining portal");
+			return 0;
+		}
+	}
+	swp = DPAA2_PER_LCORE_ETHRX_PORTAL;
+
+	/* our frames parked by another queue's burst -- convert now (hot) */
+	while (num_rx < nb_pkts && stash->head != stash->tail) {
+		fd = &stash->fd[stash->head & (DPAA2_NAPI_FD_STASH_SIZE - 1)];
+		if (dpaa2_svr_family != SVR_LX2160A &&
+		    (uint16_t)(stash->head + 1) != stash->tail)
+			dpaa2_dqrr_prefetch_annot(&stash->fd[(stash->head + 1) &
+					(DPAA2_NAPI_FD_STASH_SIZE - 1)]);
+		bufs[num_rx++] = dpaa2_dqrr_fd_to_mbuf(fd, eth_data);
+		stash->head++;
+	}
+
+	while (num_rx < nb_pkts) {
+		dq = qbman_swp_dqrr_next(swp);
+		if (!dq)
+			break;			/* ring momentarily empty */
+		qbman_swp_prefetch_dqrr_next(swp);
+		fd = qbman_result_DQ_fd(dq);
+		/* parse summary is in the FRC on LX2160A; annotation is HW-stashed */
+		if (dpaa2_svr_family != SVR_LX2160A)
+			dpaa2_dqrr_prefetch_annot(fd);
+		rxq = (struct dpaa2_queue *)(size_t)qbman_result_DQ_fqd_ctx(dq);
+		if (unlikely(!rxq))
+			rxq = dpaa2_q;
+		if (rxq == dpaa2_q) {
+			bufs[num_rx++] = dpaa2_dqrr_fd_to_mbuf(fd, eth_data);
+		} else {
+			struct dpaa2_napi_stash *fs = &rxq->napi_stash;
+
+			if (unlikely((uint16_t)(fs->tail - fs->head) >=
+						DPAA2_NAPI_FD_STASH_SIZE)) {
+				/* stash full: drop rather than leave it on the ring
+				 * and head-of-line block the shared portal
+				 */
+				rte_pktmbuf_free(dpaa2_dqrr_fd_to_mbuf(fd, rxq->eth_data));
+				rxq->err_pkts++;
+			} else {
+				fs->fd[fs->tail & (DPAA2_NAPI_FD_STASH_SIZE - 1)] = *fd;
+				fs->tail++;
+			}
+		}
+		qbman_swp_dqrr_consume(swp, dq);
+	}
+
+	dpaa2_q->rx_pkts += num_rx;
+	return num_rx;
+}
+
 void __rte_hot
 dpaa2_dev_process_parallel_event(struct qbman_swp *swp,
 				 const struct qbman_fd *fd,
-- 
2.43.0

