Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D22CC43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 21:09:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E5E1340B94;
	Fri, 10 Jul 2026 23:09:39 +0200 (CEST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47]) by mails.dpdk.org (Postfix) with ESMTP id 2A92140B9D
 for <dev@dpdk.org>; Fri, 10 Jul 2026 23:09:39 +0200 (CEST)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-47362928f65so1355599f8f.2
 for <dev@dpdk.org>; Fri, 10 Jul 2026 14:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783717779; x=1784322579; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3Bb0NClujvefV4BJwNe6rQ55rqR2g/Bpq0616wBgo5A=;
 b=BfE3xvQUHF9mlziOQdlimeGJsjnQ7QfjK7CqbkpPeKbsvPIeoiKgi0YN6M3Fm+9W2u
 b2+4/VRjywd9snEAN2zPriUUxaWG/TpMgFFAfLBdkVWWNX/amLvj4Qfduc6/RJrXs2mQ
 XUB/jfl0zlRVj4WSyiGYRG+DRskCMbofa0rfgc/AXMDRSqx6HqnT4LgsJjgE7cZwo4Gu
 FclytK2gC/62FeV3oCgnhC8bsy2KdUWrx4FV5k7K+y0x7JRoMVzRJoUS1esW8l/EKQFk
 Pwe0gUaQ37ZZB9gqWE3IT+F+NYuZMYceK0MJicX81nflpqmBQHFhODDqV6PFR8vTaQ9S
 IfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783717779; x=1784322579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3Bb0NClujvefV4BJwNe6rQ55rqR2g/Bpq0616wBgo5A=;
 b=ivThsQkusTSDmykjwwPfbMYbVDky+7TWSzzXLKNFhom63onzsaHwu002wyN0SODHtd
 xeL3Wr0AeqGR6FVJY2ixa1q3TkozwMIcvSpCc2dMGm+fZ1jIdGLHKkEkZesmx/h4aH1q
 9xD7Ao/Oe0+nrrdNEkVRZdNqE8FYF5RTAD9qmYtMnMKu580bqhPKup4JJJizGW7UHlpw
 xGhxZaUHy/jlXhylh0/36P6kPKzGzzDA0Gq1lwn5sbB8iTaM1Z6nU1E7SVZitZCSQ7ol
 pSzvrCqRdgCLOD2a0J1kofj3B0UzwwKGX2fSP6iD4f2rO9dxav5ZATUFdpcGxsuFMV6b
 bW3w==
X-Gm-Message-State: AOJu0YyczV/VPeE3y7IzBCqwgyptP8Nf9SF21c77dpkplw5IHdixMPPr
 cP1XmtmcmJahkYQay36AVSLJumWE+AvOkuCUkgfV66stv6ZqZti+RY3dslUx3RSk
X-Gm-Gg: AfdE7cmesXV9X+LeTMzUHrv3XAMBMFIZ7TG8DYP8N0ti2fwAc5c+fV90JF8teXj6o/i
 1Wto2k0W6yZLTZjQTvN564gl6TP/7aKDCzx2d6nzY8HCuSCo3OD1f0jIyyU+akWNvY4sJLQP4tN
 /+pFSUIoKbu64UpNTZg7CYWpJQ6BnGDL+7t4FUqAKTKMXP2SpDW9MAhMUrfbK+JSs9Ooo5m+Aqh
 gaUE7HV9nPnuNUmpoSRMkbUBj3kGPQI0xYhmDFx4zSKScSkAuZVYs1iavbmIvft9JncARmUkJ3v
 Q+KXj1z8Jx0frDT7H01mq5LDbN5B6GsQq3GvtSFXnRldM0KGIp1zVVEVlYufKLd9wyGNK/7sOZB
 JSVwv0YJEctF/0o7v+pdg9jzJhQNJ4xlz44DGL4C+lHgQYF2jqCpiXuQK/kMfjGsm7Xf0Yxruzo
 bkwPmphQ==
X-Received: by 2002:a05:6000:2512:b0:47d:e8be:e728 with SMTP id
 ffacd0b85a97d-47f2dca21e6mr426611f8f.24.1783717778343; 
 Fri, 10 Jul 2026 14:09:38 -0700 (PDT)
Received: from freepad.. ([2a01:e0a:6f:bdf0:a821:a41b:93f0:2def])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039b126sm61657821f8f.24.2026.07.10.14.09.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:09:36 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>, Jun Yang <jun.yang@nxp.com>,
 Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v4 5/6] net/dpaa2: support Rx queue interrupts
Date: Fri, 10 Jul 2026 23:09:19 +0200
Message-ID: <20260710210920.2402309-6-maxime@leroys.fr>
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

Implement .rx_queue_intr_enable / .rx_queue_intr_disable so a worker can
sleep on a queue's data-availability notification instead of busy-polling,
through the generic rte_eth_dev_rx_intr_* API.

A worker wakes on its software portal's DQRI, which fires when the
portal's DQRR is non-empty. To wake on a specific Rx FQ, the FQ is
scheduled to its own DPCON channel, and that channel is told to post a
CDAN (Channel Dequeue Available Notification) to the worker's portal when
it goes non-empty. rx_queue_setup schedules each Rx FQ to its DPCON
(DEST_DPCON) once, when the channel is first grabbed; a worker later, in
rx_queue_intr_enable, points the channel's CDAN at its own DPIO
(dpcon_set_notification), enables it on its portal and arms the DQRI.

The FQ stays scheduled to its DPCON for the life of the port and is
never re-bound: the MC refuses to move a scheduled FQ back to parked at
runtime, and re-issuing DEST_DPCON on a non-empty FQ would strand it (no
empty -> non-empty edge, so no CDAN); only the probe/close dpni_reset
un-schedules it. A Rx queue count change (dev_stop, dev_configure,
rx_queue_setup, dev_start) is therefore supported: growing binds only the
new queues, shrinking leaves the excess FQs scheduled but idle. The
interrupt handle is allocated once at dev_configure, sized to the queue
ceiling, and kept for the life of the port so the application's rx-intr
epoll registration stays valid across a reconfigure. Switching the
interrupt mode on or off is refused after the first configure (it cannot
be undone at runtime); close the port to change it.

One DPCON per FQ (drawn from the shared pool the DPCON move to the
fslmc bus feeds), so each queue keeps its own notification and can be
re-homed to another lcore without a set_queue or a port stop. Unlike the
event PMD, which concentrates N FQs onto one DPCON and lets the QBMan
scheduler load-balance across cores, affinity here is static and there is
no scheduling.

A CDAN only notifies; it does not carry frames. On wake the worker drains
each queue with a volatile dequeue on its DPCON channel
(dpaa2_dev_prefetch_rx_channel, the prefetch poll path retargeted from
the FQ to the channel) and consumes the CDAN from the DQRR. The
notification is one-shot, re-armed on the next idle->sleep.

The DQRI fires immediately on the first CDAN: the arm sets the ITP
holdoff to 0, so the interrupt is raised as soon as the DQRR goes
non-empty; with a zero holdoff the DQRR threshold is immaterial.

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
          rte_epoll_wait  rte_epoll_wait             (9)
                 |
         dpaa2_dev_prefetch_rx_channel               (10)
                 |
             frames -> store

  (1)  WRIOP picks a TC (QoS), then RSS-hashes within the TC to an FQ
  (2)  FQ0..FQ3 are the rte_eth Rx queues
  (3)  dpni_set_queue(DEST_DPCON): one DPCON per FQ (FQ scheduled to it)
  (4)  the lcore portal points each DPCON's CDAN at itself
       (dpcon_set_notification) and enables it; its dedicated channel
       static-dequeues the notifications
  (5)  one QBMan software portal per lcore
  (6)  a non-empty FQ makes its DPCON post a CDAN (a notification, not the
       frames) into the portal DQRR
  (7)  DQRI is raised when the DQRR is non-empty (a CDAN is pending)
  (8)  a portal's queues share one fd (its DQRI eventfd)
  (9)  worker sleeps here when all its queues are idle
  (10) on wake the worker pulls each notified queue's channel; frames land
       in the per-queue store, the CDAN is consumed from the DQRR

The DQRI and eventfd are portal-wide: a queue's eventfd is its portal's
DQRI fd, and the inhibit bit is refcounted by armed queues so disabling
one queue never masks a sibling.

The PMD does not disarm from stop or close: the CDAN and DQRI operations
drive the single-owner QBMan software portal and must run on the polling
lcore, so stop or close can only warn if the application skips
rte_eth_dev_rx_intr_disable().

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
Tested-by: Jun Yang <jun.yang@nxp.com>
---
 doc/guides/nics/dpaa2.rst                     |  28 ++
 doc/guides/nics/features/dpaa2.ini            |   1 +
 doc/guides/rel_notes/release_26_07.rst        |   1 +
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c      |  76 +++-
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.h      |   8 +
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h       |   9 +
 .../fslmc/qbman/include/fsl_qbman_portal.h    |   5 +
 drivers/bus/fslmc/qbman/qbman_portal.c        |   5 +
 drivers/net/dpaa2/dpaa2_ethdev.c              | 409 +++++++++++++++++-
 drivers/net/dpaa2/dpaa2_ethdev.h              |   7 +
 drivers/net/dpaa2/dpaa2_rxtx.c                | 114 ++++-
 11 files changed, 613 insertions(+), 50 deletions(-)

diff --git a/doc/guides/nics/dpaa2.rst b/doc/guides/nics/dpaa2.rst
index 2d70bd0ab9..b10b7c5c77 100644
--- a/doc/guides/nics/dpaa2.rst
+++ b/doc/guides/nics/dpaa2.rst
@@ -406,6 +406,7 @@ Features of the DPAA2 PMD are:
 - Jumbo frames
 - Link flow control
 - Scattered and gather for TX and RX
+- Rx queue interrupts
 - :ref:`Traffic Management API <dptmapi>`
 
 
@@ -553,6 +554,33 @@ is fixed and cannot be changed. So, even when the ``rxmode.mtu``
 member of ``struct rte_eth_conf`` is set to a value lower than 10240, frames
 up to 10240 bytes can still reach the host interface.
 
+Rx queue interrupts
+~~~~~~~~~~~~~~~~~~~
+
+Rx queue interrupts (``rte_eth_dev_rx_intr_*``) let a worker sleep on a queue
+instead of busy-polling. Note:
+
+- Each Rx queue needs its own DPCON (notification channel), drawn from the
+  shared fslmc bus pool. The DPRC must provision at least as many DPCON
+  objects as Rx queues (these are shared with the event PMD); queue setup
+  fails with ``-ENODEV`` if the pool is exhausted.
+- ``rte_eth_dev_rx_intr_enable()`` / ``rte_eth_dev_rx_intr_disable()`` drive the
+  per-lcore QBMan software portal and must be called from the lcore that polls
+  the queue. The application must call ``rte_eth_dev_rx_intr_disable()`` on that
+  lcore before stopping or closing the port.
+- The queue's interrupt fd is bound when the queue is armed (it follows the
+  polling lcore's portal), not at queue setup. The application must therefore
+  arm a queue with ``rte_eth_dev_rx_intr_enable()`` before adding it to an
+  epoll set with ``rte_eth_dev_rx_intr_ctl_q()``; registering before arming
+  would watch an unbound fd. Several queues pinned to the same lcore share one
+  portal fd, so ``rte_eth_dev_rx_intr_ctl_q()`` returns ``-EEXIST`` after the
+  first; treat it as success.
+- The Rx error queue (``drv_err_queue`` devarg) is not drained while a queue
+  runs in interrupt mode.
+- The DPIO MSI is pinned to the polling core as a best-effort latency
+  optimisation (writes ``/proc/irq/<n>/smp_affinity``, needs privilege, and
+  irqbalance may move it back); wakeups are delivered correctly regardless.
+
 Other Limitations
 ~~~~~~~~~~~~~~~~~
 
diff --git a/doc/guides/nics/features/dpaa2.ini b/doc/guides/nics/features/dpaa2.ini
index 5def653d1d..4788afef8d 100644
--- a/doc/guides/nics/features/dpaa2.ini
+++ b/doc/guides/nics/features/dpaa2.ini
@@ -8,6 +8,7 @@ Speed capabilities   = Y
 Link status          = Y
 Link status event    = Y
 Burst mode info      = Y
+Rx interrupt         = Y
 Queue start/stop     = Y
 Scattered Rx         = Y
 MTU update           = Y
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 8b1bdada1a..d3268ab867 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -167,6 +167,7 @@ New Features
     ``RTE_ETH_RX_OFFLOAD_VLAN_STRIP`` is no longer advertised,
     as no hardware strip backs it.
     An application that needs the tag removed must now strip it itself.
+  * Added Rx queue interrupt support (rte_eth_dev_rx_intr_*).
 
 * **Updated NXP enetc ethernet driver.**
 
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
index 05645d667a..9dad78eba4 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
@@ -204,12 +204,23 @@ dpaa2_affine_dpio_intr_to_respective_core(int32_t dpio_id, int cpu_id)
 
 	fclose(file);
 }
+#endif /* RTE_EVENT_DPAA2 */
 
-static int dpaa2_dpio_intr_init(struct dpaa2_dpio_dev *dpio_dev, bool build_epoll)
+/* threshold: DQRR fill raising DQRI (< ring depth); timeout: holdoff in ITP units.
+ * Per-mode values from the caller (eventdev vs rx-queue intr).
+ * The DQRI config is portal-wide and this is idempotent: the first caller to
+ * arm a portal wins, a later caller's values are ignored (a portal normally
+ * serves a single mode).
+ */
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_dpio_intr_init)
+int dpaa2_dpio_intr_init(struct dpaa2_dpio_dev *dpio_dev, int threshold,
+			 int timeout, bool build_epoll)
 {
-	struct epoll_event epoll_ev;
 	int eventfd, dpio_epoll_fd, ret;
-	int threshold = 0x3, timeout = 0xFF;
+	struct epoll_event epoll_ev;
+
+	if (dpio_dev->intr_enabled)
+		return 0;
 
 	ret = rte_dpaa2_intr_enable(dpio_dev->intr_handle, 0);
 	if (ret) {
@@ -217,12 +228,6 @@ static int dpaa2_dpio_intr_init(struct dpaa2_dpio_dev *dpio_dev, bool build_epol
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
@@ -233,9 +238,9 @@ static int dpaa2_dpio_intr_init(struct dpaa2_dpio_dev *dpio_dev, bool build_epol
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
 		dpio_epoll_fd = epoll_create1(EPOLL_CLOEXEC);
@@ -259,13 +264,19 @@ static int dpaa2_dpio_intr_init(struct dpaa2_dpio_dev *dpio_dev, bool build_epol
 		dpio_dev->epoll_fd = dpio_epoll_fd;
 	}
 
+	dpio_dev->intr_enabled = 1;
+
 	return 0;
 }
 
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
@@ -274,11 +285,11 @@ static void dpaa2_dpio_intr_deinit(struct dpaa2_dpio_dev *dpio_dev)
 		close(dpio_dev->epoll_fd);
 		dpio_dev->epoll_fd = -1;
 	}
+	dpio_dev->intr_enabled = 0;
 }
-#endif
 
 static int
-dpaa2_configure_stashing(struct dpaa2_dpio_dev *dpio_dev, int cpu_id)
+dpaa2_configure_stashing(struct dpaa2_dpio_dev *dpio_dev, int cpu_id, bool ethrx)
 {
 	int sdest, ret;
 
@@ -297,11 +308,26 @@ dpaa2_configure_stashing(struct dpaa2_dpio_dev *dpio_dev, int cpu_id)
 	}
 
 #ifdef RTE_EVENT_DPAA2
-	if (dpaa2_dpio_intr_init(dpio_dev, true)) {
-		DPAA2_BUS_ERR("Interrupt registration failed for dpio");
-		return -1;
+	/* Only the event PMD's portal is set up here (coalesced DQRI, private
+	 * epoll). The net rx-interrupt portal (ethrx) is configured by the net
+	 * PMD in rx_queue_intr_enable, so do not touch it here.
+	 */
+	if (!ethrx) {
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
+#else
+	RTE_SET_USED(ethrx);
 #endif
 
 	return 0;
@@ -310,14 +336,16 @@ dpaa2_configure_stashing(struct dpaa2_dpio_dev *dpio_dev, int cpu_id)
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
 
-static struct dpaa2_dpio_dev *dpaa2_get_qbman_swp(void)
+static struct dpaa2_dpio_dev *dpaa2_get_qbman_swp(bool ethrx)
 {
 	struct dpaa2_dpio_dev *dpio_dev = NULL;
 	int cpu_id;
@@ -343,7 +371,7 @@ static struct dpaa2_dpio_dev *dpaa2_get_qbman_swp(void)
 		if (dpaa2_svr_family != SVR_LX2160A)
 			qbman_swp_update(dpio_dev->sw_portal, 1);
 	} else {
-		ret = dpaa2_configure_stashing(dpio_dev, cpu_id);
+		ret = dpaa2_configure_stashing(dpio_dev, cpu_id, ethrx);
 		if (ret) {
 			DPAA2_BUS_ERR("dpaa2_configure_stashing failed");
 			rte_atomic16_clear(&dpio_dev->ref_count);
@@ -370,7 +398,7 @@ dpaa2_affine_qbman_swp(void)
 
 	/* Populate the dpaa2_io_portal structure */
 	if (!RTE_PER_LCORE(_dpaa2_io).dpio_dev) {
-		dpio_dev = dpaa2_get_qbman_swp();
+		dpio_dev = dpaa2_get_qbman_swp(false);
 		if (!dpio_dev) {
 			DPAA2_BUS_ERR("Error in software portal allocation");
 			return -1;
@@ -392,7 +420,7 @@ dpaa2_affine_qbman_ethrx_swp(void)
 
 	/* Populate the dpaa2_io_portal structure */
 	if (!RTE_PER_LCORE(_dpaa2_io).ethrx_dpio_dev) {
-		dpio_dev = dpaa2_get_qbman_swp();
+		dpio_dev = dpaa2_get_qbman_swp(true);
 		if (!dpio_dev) {
 			DPAA2_BUS_ERR("Error in software portal allocation");
 			return -1;
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h
index 328e1e788a..1f6e521341 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.h
@@ -50,6 +50,14 @@ int dpaa2_affine_qbman_swp(void);
 __rte_internal
 int dpaa2_affine_qbman_ethrx_swp(void);
 
+/* set up / tear down a DPIO portal's DQRI interrupt (rx-queue interrupt mode) */
+__rte_internal
+int dpaa2_dpio_intr_init(struct dpaa2_dpio_dev *dpio_dev, int threshold,
+			 int timeout, bool build_epoll);
+
+__rte_internal
+void dpaa2_dpio_intr_deinit(struct dpaa2_dpio_dev *dpio_dev);
+
 /* allocate memory for FQ - dq storage */
 __rte_internal
 int
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
index 2a6d970101..ef65e7895a 100644
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
 
@@ -195,6 +197,13 @@ struct __rte_cache_aligned dpaa2_queue {
 	uint64_t offloads;
 	uint64_t lpbk_cntx;
 	uint8_t data_stashing_off;
+	/* NAPI rx-interrupt: per-queue DPCON bound to this FQ at dev_start
+	 * (DEST_DPCON, static); the polling worker points the channel's CDAN at
+	 * its ethrx portal, arms the DQRI, and drains by channel volatile pull.
+	 */
+	struct dpaa2_dpcon_dev *napi_dpcon;	/*!< notif channel, NULL = napi off */
+	RTE_ATOMIC(struct dpaa2_dpio_dev *) napi_sub_dpio;	/*!< subscribed portal or NULL */
+	uint8_t napi_armed;			/*!< this queue requests DQRI wakeups */
 };
 
 struct swp_active_dqs {
diff --git a/drivers/bus/fslmc/qbman/include/fsl_qbman_portal.h b/drivers/bus/fslmc/qbman/include/fsl_qbman_portal.h
index 5375ea386d..b9e7789766 100644
--- a/drivers/bus/fslmc/qbman/include/fsl_qbman_portal.h
+++ b/drivers/bus/fslmc/qbman/include/fsl_qbman_portal.h
@@ -189,6 +189,7 @@ int qbman_swp_interrupt_get_inhibit(struct qbman_swp *p);
  * @p: the given software portal object.
  * @mask: The value to set in SWP_IIR register.
  */
+__rte_internal
 void qbman_swp_interrupt_set_inhibit(struct qbman_swp *p, int inhibit);
 
 	/************/
@@ -400,6 +401,7 @@ void qbman_pull_desc_set_wq(struct qbman_pull_desc *d, uint32_t wqid,
  * @chid: the channel id to be dequeued.
  * @dct: the dequeue command type.
  */
+__rte_internal
 void qbman_pull_desc_set_channel(struct qbman_pull_desc *d, uint32_t chid,
 				 enum qbman_pull_type_e dct);
 
@@ -1298,6 +1300,7 @@ int qbman_swp_fq_xoff(struct qbman_swp *s, uint32_t fqid);
  *
  * Return 0 for success, or negative error code for failure.
  */
+__rte_internal
 int qbman_swp_CDAN_set_context(struct qbman_swp *s, uint16_t channelid,
 			       uint64_t ctx);
 
@@ -1308,6 +1311,7 @@ int qbman_swp_CDAN_set_context(struct qbman_swp *s, uint16_t channelid,
  *
  * Return 0 for success, or negative error code for failure.
  */
+__rte_internal
 int qbman_swp_CDAN_enable(struct qbman_swp *s, uint16_t channelid);
 
 /**
@@ -1317,6 +1321,7 @@ int qbman_swp_CDAN_enable(struct qbman_swp *s, uint16_t channelid);
  *
  * Return 0 for success, or negative error code for failure.
  */
+__rte_internal
 int qbman_swp_CDAN_disable(struct qbman_swp *s, uint16_t channelid);
 
 /**
diff --git a/drivers/bus/fslmc/qbman/qbman_portal.c b/drivers/bus/fslmc/qbman/qbman_portal.c
index 84853924e7..c93bec5dd3 100644
--- a/drivers/bus/fslmc/qbman/qbman_portal.c
+++ b/drivers/bus/fslmc/qbman/qbman_portal.c
@@ -448,6 +448,7 @@ int qbman_swp_interrupt_get_inhibit(struct qbman_swp *p)
 	return qbman_cinh_read(&p->sys, QBMAN_CINH_SWP_IIR);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_interrupt_set_inhibit)
 void qbman_swp_interrupt_set_inhibit(struct qbman_swp *p, int inhibit)
 {
 	qbman_cinh_write(&p->sys, QBMAN_CINH_SWP_IIR,
@@ -1878,6 +1879,7 @@ void qbman_pull_desc_set_wq(struct qbman_pull_desc *d, uint32_t wqid,
 	d->pull.dq_src = wqid;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_pull_desc_set_channel)
 void qbman_pull_desc_set_channel(struct qbman_pull_desc *d, uint32_t chid,
 				 enum qbman_pull_type_e dct)
 {
@@ -2921,6 +2923,7 @@ static int qbman_swp_CDAN_set(struct qbman_swp *s, uint16_t channelid,
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_CDAN_set_context)
 int qbman_swp_CDAN_set_context(struct qbman_swp *s, uint16_t channelid,
 			       uint64_t ctx)
 {
@@ -2929,6 +2932,7 @@ int qbman_swp_CDAN_set_context(struct qbman_swp *s, uint16_t channelid,
 				  0, ctx);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_CDAN_enable)
 int qbman_swp_CDAN_enable(struct qbman_swp *s, uint16_t channelid)
 {
 	return qbman_swp_CDAN_set(s, channelid,
@@ -2936,6 +2940,7 @@ int qbman_swp_CDAN_enable(struct qbman_swp *s, uint16_t channelid)
 				  1, 0);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_CDAN_disable)
 int qbman_swp_CDAN_disable(struct qbman_swp *s, uint16_t channelid)
 {
 	return qbman_swp_CDAN_set(s, channelid,
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 61122b323f..9d3634d75f 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -5,6 +5,8 @@
 
 #include <time.h>
 #include <net/if.h>
+#include <unistd.h>
+#include <errno.h>
 
 #include <eal_export.h>
 #include <rte_mbuf.h>
@@ -25,6 +27,7 @@
 #include <dpaa2_hw_mempool.h>
 #include <dpaa2_hw_dpio.h>
 #include <mc/fsl_dpmng.h>
+#include <mc/fsl_dpcon.h>
 #include "dpaa2_ethdev.h"
 #include "dpaa2_sparser.h"
 #include <fsl_qbman_debug.h>
@@ -658,6 +661,8 @@ dpaa2_clear_queue_active_dps(struct dpaa2_queue *q, int num_lcores)
 	}
 }
 
+static void dpaa2_dev_rx_queue_intr_unbind(struct dpaa2_queue *dpaa2_q);
+
 static void
 dpaa2_free_rx_tx_queues(struct rte_eth_dev *dev)
 {
@@ -675,6 +680,13 @@ dpaa2_free_rx_tx_queues(struct rte_eth_dev *dev)
 		/* cleaning up queue storage */
 		for (i = 0; i < priv->nb_rx_queues; i++) {
 			dpaa2_q = priv->rx_vq[i];
+			if (dpaa2_q->napi_dpcon) {	/* release the rx-intr channel */
+				dpaa2_dev_rx_queue_intr_unbind(dpaa2_q);
+				rte_dpaa2_free_dpcon_dev(dpaa2_q->napi_dpcon);
+				dpaa2_q->napi_dpcon = NULL;
+				rte_atomic_store_explicit(&dpaa2_q->napi_sub_dpio,
+						NULL, rte_memory_order_release);
+			}
 			dpaa2_clear_queue_active_dps(dpaa2_q,
 						RTE_MAX_LCORE);
 			dpaa2_queue_storage_free(dpaa2_q,
@@ -728,6 +740,15 @@ dpaa2_eth_dev_configure(struct rte_eth_dev *dev)
 
 	PMD_INIT_FUNC_TRACE();
 
+	/* interrupt mode is fixed once set; the queue count may still change */
+	if (priv->intr_mode_set &&
+	    priv->intr_mode != eth_conf->intr_conf.rxq) {
+		DPAA2_PMD_ERR("Rx interrupt mode is fixed after configure; close the port to change it");
+		return -ENOTSUP;
+	}
+	priv->intr_mode = eth_conf->intr_conf.rxq;
+	priv->intr_mode_set = 1;
+
 	/* Rx offloads which are enabled by default */
 	if (dev_rx_offloads_nodis & ~rx_offloads) {
 		DPAA2_PMD_INFO(
@@ -880,6 +901,28 @@ dpaa2_eth_dev_configure(struct rte_eth_dev *dev)
 		}
 	}
 
+	/* allocate the intr handle once, sized to the queue ceiling; kept across
+	 * reconfigure and freed at dev_close so the app epoll registration holds
+	 */
+	if (dev->data->dev_conf.intr_conf.rxq && dev->intr_handle == NULL) {
+		dev->intr_handle = rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
+		if (!dev->intr_handle ||
+		    rte_intr_vec_list_alloc(dev->intr_handle, "rxq_intr",
+				priv->nb_rx_queues) ||
+		    rte_intr_nb_efd_set(dev->intr_handle, priv->nb_rx_queues) ||
+		    rte_intr_type_set(dev->intr_handle, RTE_INTR_HANDLE_EXT)) {
+			DPAA2_PMD_ERR("Failed to set up rx-queue interrupts");
+			/* capture the error before cleanup may clobber rte_errno */
+			ret = rte_errno ? -rte_errno : -EIO;
+			if (dev->intr_handle) {
+				rte_intr_vec_list_free(dev->intr_handle);
+				rte_intr_instance_free(dev->intr_handle);
+				dev->intr_handle = NULL;
+			}
+			return ret;
+		}
+	}
+
 	dpaa2_tm_init(dev);
 
 	return 0;
@@ -898,6 +941,7 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 {
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
 	struct fsl_mc_io *dpni = dev->process_private;
+	bool dpcon_allocated = false;
 	struct dpaa2_queue *dpaa2_q;
 	struct dpni_queue cfg;
 	uint8_t options = 0;
@@ -938,6 +982,29 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	dpaa2_q->bp_array = rte_dpaa2_bpid_info;
 	dpaa2_q->offloads = rx_conf->offloads;
 
+	/* NAPI: grab a DPCON channel so dev_start can bind this FQ statically.
+	 * The DQRR burst replaces the poll path for every queue at once, so a
+	 * missing channel is fatal rather than a silent per-queue fallback.
+	 */
+	rte_atomic_store_explicit(&dpaa2_q->napi_sub_dpio, NULL,
+			rte_memory_order_release);
+	if (dev->data->dev_conf.intr_conf.rxq && !dpaa2_q->napi_dpcon) {
+		dpaa2_q->napi_dpcon = rte_dpaa2_alloc_dpcon_dev();
+		if (!dpaa2_q->napi_dpcon) {
+			DPAA2_PMD_ERR("rxq %d: no DPCON for rx-queue interrupts",
+				      rx_queue_id);
+			return -ENODEV;
+		}
+		dpcon_allocated = true;
+		/* the DPCON must be enabled to generate CDAN notifications */
+		ret = dpcon_enable(&dpaa2_q->napi_dpcon->dpcon, CMD_PRI_LOW,
+				   dpaa2_q->napi_dpcon->token);
+		if (ret) {
+			DPAA2_PMD_ERR("rxq %d: dpcon_enable: %d", rx_queue_id, ret);
+			goto err_free_dpcon;
+		}
+	}
+
 	/*Get the flow id from given VQ id*/
 	flow_id = dpaa2_q->flow_id;
 	memset(&cfg, 0, sizeof(struct dpni_queue));
@@ -945,6 +1012,15 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	options = options | DPNI_QUEUE_OPT_USER_CTX;
 	cfg.user_context = (size_t)(dpaa2_q);
 
+	/* napi: schedule the FQ to its DPCON once, when the channel is first
+	 * grabbed; never re-bound (the MC refuses scheduled->parked at runtime)
+	 */
+	if (dpcon_allocated) {
+		options |= DPNI_QUEUE_OPT_DEST;
+		cfg.destination.type = DPNI_DEST_DPCON;
+		cfg.destination.id = dpaa2_q->napi_dpcon->dpcon_id;
+	}
+
 	/* check if a private cgr available. */
 	for (i = 0; i < priv->max_cgs; i++) {
 		if (!priv->cgid_in_use[i]) {
@@ -985,7 +1061,7 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 			dpaa2_q->tc_index, flow_id, options, &cfg);
 	if (ret) {
 		DPAA2_PMD_ERR("Error in setting the rx flow: = %d", ret);
-		return ret;
+		goto err_free_dpcon;
 	}
 
 	dpaa2_q->nb_desc = nb_rx_desc;
@@ -1026,7 +1102,7 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 		if (ret) {
 			DPAA2_PMD_ERR("Error in setting taildrop. err=(%d)",
 				ret);
-			return ret;
+			goto err_free_dpcon;
 		}
 	} else { /* Disable tail Drop */
 		struct dpni_taildrop taildrop = {0};
@@ -1046,12 +1122,22 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
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
@@ -1210,6 +1296,28 @@ dpaa2_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	return 0;
 }
 
+/* drop a queue's worker portal reference; the FQ stays scheduled to its DPCON
+ * (only dpni_reset at close un-schedules it). Teardown only.
+ */
+static void
+dpaa2_dev_rx_queue_intr_unbind(struct dpaa2_queue *dpaa2_q)
+{
+	if (!dpaa2_q || !dpaa2_q->napi_dpcon)
+		return;
+
+	/* the portal (CDAN, DQRI) can only be torn down on the polling lcore;
+	 * warn if the app skipped rte_eth_dev_rx_intr_disable() before stop/close
+	 */
+	if (dpaa2_q->napi_armed)
+		DPAA2_PMD_WARN("rxq flow %u freed while armed; call "
+			       "rte_eth_dev_rx_intr_disable() on the polling "
+			       "lcore before stop/close", dpaa2_q->flow_id);
+
+	/* CDAN and DQRI teardown is the worker's job via rte_eth_dev_rx_intr_disable() */
+	rte_atomic_store_explicit(&dpaa2_q->napi_sub_dpio, NULL,
+			rte_memory_order_release);
+}
+
 static void
 dpaa2_dev_rx_queue_release(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 {
@@ -1239,6 +1347,10 @@ dpaa2_dev_rx_queue_release(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 		priv->cgid_in_use[dpaa2_q->cgid] = 0;
 		dpaa2_q->cgid = DPAA2_INVALID_CGID;
 	}
+
+	/* keep the DPCON on the FQ across a reconfigure; freed at dev_close */
+	if (dpaa2_q->napi_dpcon)
+		dpaa2_dev_rx_queue_intr_unbind(dpaa2_q);
 }
 
 static int
@@ -1289,7 +1401,9 @@ dpaa2_supported_ptypes_get(struct rte_eth_dev *dev, size_t *no_of_elements)
 
 	if (dev->rx_pkt_burst == dpaa2_dev_prefetch_rx ||
 		dev->rx_pkt_burst == dpaa2_dev_rx ||
-		dev->rx_pkt_burst == dpaa2_dev_loopback_rx) {
+		dev->rx_pkt_burst == dpaa2_dev_loopback_rx ||
+		dev->rx_pkt_burst == dpaa2_dev_rx_channel ||
+		dev->rx_pkt_burst == dpaa2_dev_prefetch_rx_channel) {
 		*no_of_elements = RTE_DIM(ptypes);
 		return ptypes;
 	}
@@ -1389,6 +1503,27 @@ dpaa2_dev_start(struct rte_eth_dev *dev)
 	intr_handle = dpaa2_dev->intr_handle;
 
 	PMD_INIT_FUNC_TRACE();
+
+	/* napi: FQs are scheduled to their DPCON at rx_queue_setup, not here; just
+	 * select the channel burst (the worker subscribes its portal later)
+	 */
+	if (dev->data->dev_conf.intr_conf.rxq) {
+		for (i = 0; i < data->nb_rx_queues; i++) {
+			dpaa2_q = data->rx_queues[i];
+			/* the channel burst below derefs napi_dpcon, so every
+			 * rx queue must own a channel
+			 */
+			if (!dpaa2_q->napi_dpcon) {
+				DPAA2_PMD_ERR("napi: rxq %d has no DPCON channel", i);
+				return -ENODEV;
+			}
+		}
+		if (priv->flags & DPAA2_NO_PREFETCH_RX)
+			dev->rx_pkt_burst = dpaa2_dev_rx_channel;
+		else
+			dev->rx_pkt_burst = dpaa2_dev_prefetch_rx_channel;
+	}
+
 	ret = dpni_enable(dpni, CMD_PRI_LOW, priv->token);
 	if (ret) {
 		DPAA2_PMD_ERR("Failure in enabling dpni %d device: err=%d",
@@ -1569,6 +1704,15 @@ dpaa2_dev_close(struct rte_eth_dev *dev)
 
 	/* Free private queues memory */
 	dpaa2_free_rx_tx_queues(dev);
+	/* release the rx-queue interrupt vector and instance allocated at
+	 * dev_configure (configure/close pair); the per-queue CDAN and portal
+	 * teardown is the worker's job via rte_eth_dev_rx_intr_disable().
+	 */
+	if (dev->intr_handle) {
+		rte_intr_vec_list_free(dev->intr_handle);
+		rte_intr_instance_free(dev->intr_handle);
+		dev->intr_handle = NULL;
+	}
 	/* Close the device at underlying layer*/
 	ret = dpni_close(dpni, CMD_PRI_LOW, priv->token);
 	if (ret) {
@@ -2897,6 +3041,258 @@ rte_pmd_dpaa2_thread_init(void)
 	}
 }
 
+/* Arm rx-queue interrupts on the worker lcore: subscribe its ethrx portal to
+ * the queue's DPCON channel (one-shot per-portal MC) and unmask the portal DQRI
+ * (pure QBMan).
+ *
+ * Affinity is static queue-to-lcore; a lcore may own several rx queues. The
+ * DQRI and the eventfd are portal-wide; on wake the worker polls each armed
+ * queue's channel (one FQ per channel, no per-frame demux) and the portal's
+ * inhibit bit is reference-counted by the number of its
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
+/* Drain the portal DQRR (consuming pending CDANs) then clear SWPn_ISR.
+ * Clearing while the ring is non-empty re-asserts the DQRI at once, so drain
+ * first. Shared by arm and disarm; the caller sets the inhibit bit.
+ */
+static void
+dpaa2_napi_drain_portal(struct dpaa2_dpio_dev *dpio)
+{
+	const struct qbman_result *dq;
+
+	while ((dq = qbman_swp_dqrr_next(dpio->sw_portal)))
+		qbman_swp_dqrr_consume(dpio->sw_portal, dq);
+	qbman_swp_interrupt_clear_status(dpio->sw_portal, 0xffffffff);
+}
+
+/* Quiesce this queue's in-flight prefetch VDQ before a sleep: a pull left in
+ * flight strands the FQ (no empty->non-empty edge, no CDAN). Returns -EAGAIN if
+ * the completed pull captured a frame -> abort the sleep and keep polling.
+ */
+static int
+dpaa2_napi_quiesce_vdq(struct dpaa2_queue *dpaa2_q)
+{
+	struct queue_storage_info_t *qs = dpaa2_q->q_storage[rte_lcore_id()];
+	struct qbman_result *dq;
+
+	if (!qs || !qs->active_dqs)
+		return 0;
+	dq = qs->active_dqs;
+	while (!qbman_check_command_complete(dq))
+		;
+	/* a completed pull holding a frame must not be dropped: leave it. Inspect
+	 * without qbman_check_new_result(), which zeroes the token the next burst
+	 * needs to detect completion.
+	 */
+	if (!qbman_result_DQ_is_pull_complete(dq) ||
+	    (qbman_result_DQ_flags(dq) & QBMAN_DQ_STAT_VALIDFRAME)) {
+		return -EAGAIN;
+	}
+	/* empty pull-complete: consume the token, drop the storage for a fresh pull */
+	while (!qbman_check_new_result(dq))
+		;
+	clear_swp_active_dqs(qs->active_dpio_id);
+	qs->active_dqs = NULL;
+	return 0;
+}
+
+/* Route this DPCON's CDAN to the worker's DPIO at MC level (re-issued on
+ * re-home), with the queue as the wake-demux context.
+ */
+static int
+dpaa2_napi_set_cdan_dest(struct dpaa2_queue *dpaa2_q, struct dpaa2_dpio_dev *dpio)
+{
+	struct dpcon_notification_cfg ncfg = {
+		.dpio_id = dpio->hw_id,
+		.priority = 0,
+		.user_ctx = (uint64_t)(uintptr_t)dpaa2_q,
+	};
+
+	return dpcon_set_notification(&dpaa2_q->napi_dpcon->dpcon,
+			CMD_PRI_LOW, dpaa2_q->napi_dpcon->token, &ncfg);
+}
+
+/* (Re)subscribe the queue's DPCON channel to dpio: set the CDAN context on the
+ * new portal, route notifications there, and wire the queue's eventfd into the
+ * generic rx-intr epoll. CDAN is not enabled here; the arm path is the sole
+ * arming point. Runs on the initial arm and on an lcore re-home.
+ */
+static int
+dpaa2_napi_subscribe(struct rte_eth_dev *dev, uint16_t queue_id,
+		     struct dpaa2_dpio_dev *dpio, struct dpaa2_dpio_dev *old)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_queue *dpaa2_q = priv->rx_vq[queue_id];
+	uint16_t chid = dpaa2_q->napi_dpcon->qbman_ch_id;
+	int ret;
+
+	if (old) {
+		/* re-home: CDAN already off old (-EBUSY ensures it was disabled
+		 * first); just drop the sub, never touch a foreign portal.
+		 */
+		rte_atomic_store_explicit(&dpaa2_q->napi_sub_dpio, NULL,
+				rte_memory_order_release);
+	}
+	/* push_set ORs the channel-0 bit (idempotent across queues sharing the
+	 * portal); CDAN context = the queue, so the wake path can demux it.
+	 */
+	qbman_swp_push_set(dpio->sw_portal, 0, 1);
+	/* context only; the arm path is the sole place that enables the CDAN */
+	ret = qbman_swp_CDAN_set_context(dpio->sw_portal, chid,
+			(uint64_t)(uintptr_t)dpaa2_q);
+	if (ret) {
+		DPAA2_PMD_ERR("napi: CDAN set_context rxq %d: %d", queue_id, ret);
+		return ret;
+	}
+	ret = dpaa2_napi_set_cdan_dest(dpaa2_q, dpio);
+	if (ret) {
+		DPAA2_PMD_ERR("napi: dpcon_set_notification rxq %d: %d",
+			      queue_id, ret);
+		return ret;		/* CDAN not enabled here -> nothing to unwind */
+	}
+	DPAA2_PMD_DEBUG("napi-cdan rxq=%u dpio=%u chid=%u",
+		queue_id, dpio->index, chid);
+	/* point the queue's eventfd at the portal DQRI fd for the generic epoll */
+	if (rte_intr_vec_list_index_set(dev->intr_handle, queue_id,
+			queue_id + RTE_INTR_VEC_RXTX_OFFSET) ||
+	    rte_intr_efds_index_set(dev->intr_handle, queue_id,
+			rte_intr_fd_get(dpio->intr_handle))) {
+		DPAA2_PMD_ERR("napi: efd wiring rxq %d", queue_id);
+		return -EIO;
+	}
+	rte_atomic_store_explicit(&dpaa2_q->napi_sub_dpio, dpio,
+			rte_memory_order_release);
+	return 0;
+}
+
+static int
+dpaa2_dev_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_queue *dpaa2_q = priv->rx_vq[queue_id];
+	struct dpaa2_dpio_dev *dpio, *old;
+	int ret;
+
+	/* the generic API has no dev_started guard (unlike the burst dummy ops),
+	 * so it can reach us after a stop; do not arm a stopped port, let the
+	 * caller fall back to polling.
+	 */
+	if (!dev->data->dev_started)
+		return -EIO;
+	if (!dpaa2_q->napi_dpcon)
+		return -ENOTSUP;	/* no channel -> caller keeps polling */
+
+	if (dpaa2_affine_qbman_ethrx_swp())
+		return -EIO;
+	dpio = DPAA2_PER_LCORE_ETHRX_DPIO;
+
+	old = rte_atomic_load_explicit(&dpaa2_q->napi_sub_dpio, rte_memory_order_acquire);
+	if (old && old != dpio && dpaa2_q->napi_armed) {
+		DPAA2_PMD_ERR("rxq %d still armed on another portal; disable it first",
+			      queue_id);
+		return -EBUSY;
+	}
+
+	ret = dpaa2_napi_quiesce_vdq(dpaa2_q);
+	if (ret)
+		return ret;
+
+	/* holdoff 0: the DQRI fires immediately on the first entry, so the
+	 * threshold is moot (1 here). build_epoll=false: the generic rx-intr API
+	 * waits on the application epoll, not the portal's private one. Idempotent
+	 * per dpio.
+	 */
+	ret = dpaa2_dpio_intr_init(dpio, 1, 0, false);
+	if (ret)
+		return ret;
+
+	if (old != dpio) {
+		ret = dpaa2_napi_subscribe(dev, queue_id, dpio, old);
+		if (ret)
+			return ret;
+	}
+
+	/* first arm on this portal: mask + drain stale CDANs, so the unmask on
+	 * the 0 -> 1 edge below is the sole DQRI open (independent of prior state)
+	 */
+	if (!dpaa2_q->napi_armed && dpio->ethrx_intr_refcnt == 0) {
+		qbman_swp_interrupt_set_inhibit(dpio->sw_portal, 1);
+		dpaa2_napi_drain_portal(dpio);
+	}
+
+	/* CDAN is one-shot and the sole arming point, re-armed every sleep.
+	 * Publish armed/refcnt only on a successful initial enable.
+	 */
+	ret = qbman_swp_CDAN_enable(dpio->sw_portal, dpaa2_q->napi_dpcon->qbman_ch_id);
+	if (ret) {
+		DPAA2_PMD_DEBUG("napi: CDAN arm rxq %d: %d", queue_id, ret);
+		/* initial arm: nothing published; re-arm: state kept. Don't sleep. */
+		return -EAGAIN;
+	}
+
+	if (!dpaa2_q->napi_armed) {
+		dpaa2_q->napi_armed = 1;
+		/* unmask the portal DQRI once, on the 0 -> 1 armed-queue edge */
+		if (dpio->ethrx_intr_refcnt++ == 0)
+			qbman_swp_interrupt_set_inhibit(dpio->sw_portal, 0);
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
+	uint64_t ev;
+	ssize_t nb;
+
+	dpio = rte_atomic_load_explicit(&dpaa2_q->napi_sub_dpio, rte_memory_order_acquire);
+	if (dpio && dpaa2_q->napi_armed) {
+		dpaa2_q->napi_armed = 0;
+		/* Silence this queue's CDAN on the portal the worker owns. Runs on
+		 * the polling lcore, so this is the only safe place to drive the
+		 * single-owner software portal. It also returns the channel to the
+		 * pool clean (CDAN disabled) and lets a sibling queue keep its own
+		 * interrupt (per-queue, unlike the portal-wide DQRI mask below).
+		 */
+		qbman_swp_CDAN_disable(dpio->sw_portal,
+				dpaa2_q->napi_dpcon->qbman_ch_id);
+		if (dpio->ethrx_intr_refcnt > 0 &&
+		    --dpio->ethrx_intr_refcnt == 0) {
+			/* last queue on the shared portal: drain + clear so the next
+			 * arm sees a clean portal (once per wake), then mask.
+			 */
+			dpaa2_napi_drain_portal(dpio);
+			qbman_swp_interrupt_set_inhibit(dpio->sw_portal, 1);
+			/* drain the VFIO eventfd: it is EPOLLET and the EAL leaves
+			 * RTE_INTR_HANDLE_EXT undrained, so a stale count suppresses the
+			 * next wake edge. Same as dpaa/mlx4/mlx5 do on disarm.
+			 */
+			nb = read(rte_intr_fd_get(dpio->intr_handle), &ev, sizeof(ev));
+			if (nb != (ssize_t)sizeof(ev) && errno != EAGAIN)
+				DPAA2_PMD_DEBUG("napi: eventfd drain rxq %d (%zd)",
+						queue_id, nb);
+		}
+	}
+
+	return 0;
+}
+
 static struct eth_dev_ops dpaa2_ethdev_ops = {
 	.dev_configure	  = dpaa2_eth_dev_configure,
 	.dev_start	      = dpaa2_dev_start,
@@ -2925,6 +3321,11 @@ static struct eth_dev_ops dpaa2_ethdev_ops = {
 	.vlan_tpid_set	      = dpaa2_vlan_tpid_set,
 	.rx_queue_setup    = dpaa2_dev_rx_queue_setup,
 	.rx_queue_release  = dpaa2_dev_rx_queue_release,
+	/* arm/disarm drive the per-lcore QBMan portal: the app must call
+	 * rte_eth_dev_rx_intr_disable() from the polling lcore before stop/close.
+	 */
+	.rx_queue_intr_enable = dpaa2_dev_rx_queue_intr_enable,
+	.rx_queue_intr_disable = dpaa2_dev_rx_queue_intr_disable,
 	.tx_queue_setup    = dpaa2_dev_tx_queue_setup,
 	.rx_burst_mode_get = dpaa2_dev_rx_burst_mode_get,
 	.tx_burst_mode_get = dpaa2_dev_tx_burst_mode_get,
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index 3f224c654e..149954fb6b 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -444,6 +444,9 @@ struct dpaa2_dev_priv {
 	rte_spinlock_t lpbk_qp_lock;
 
 	uint8_t channel_inuse;
+	/* Rx-interrupt mode latched at the first dev_configure */
+	uint8_t intr_mode;
+	uint8_t intr_mode_set;
 	/* Stores correction offset for one step timestamping */
 	uint16_t ptp_correction_offset;
 	/* for mac counters */
@@ -500,6 +503,10 @@ uint16_t dpaa2_dev_loopback_rx(void *queue, struct rte_mbuf **bufs,
 
 uint16_t dpaa2_dev_prefetch_rx(void *queue, struct rte_mbuf **bufs,
 			       uint16_t nb_pkts);
+uint16_t dpaa2_dev_prefetch_rx_channel(void *queue, struct rte_mbuf **bufs,
+				       uint16_t nb_pkts);
+uint16_t dpaa2_dev_rx_channel(void *queue, struct rte_mbuf **bufs,
+			      uint16_t nb_pkts);
 void dpaa2_dev_process_parallel_event(struct qbman_swp *swp,
 				      const struct qbman_fd *fd,
 				      const struct qbman_result *dq,
diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index 884cea43c9..c31d6556ad 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -764,13 +764,13 @@ dump_err_pkts(struct dpaa2_queue *dpaa2_q)
  * It will return the packets as requested in previous call without honoring
  * the current nb_pkts or bufs space.
  */
-uint16_t
-dpaa2_dev_prefetch_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
+static __rte_always_inline uint16_t
+dpaa2_dev_prefetch_rx_common(void *queue, struct rte_mbuf **bufs,
+			     uint16_t nb_pkts, bool by_channel)
 {
 	/* Function receive frames for a given device and VQ*/
 	struct dpaa2_queue *dpaa2_q = queue;
 	struct qbman_result *dq_storage, *dq_storage1 = NULL;
-	uint32_t fqid = dpaa2_q->fqid;
 	int ret, num_rx = 0, pull_size;
 	uint8_t pending, status;
 	struct qbman_swp *swp;
@@ -778,12 +778,18 @@ dpaa2_dev_prefetch_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	struct qbman_pull_desc pulldesc;
 	struct queue_storage_info_t *q_storage;
 	struct rte_eth_dev_data *eth_data = dpaa2_q->eth_data;
-	struct dpaa2_dev_priv *priv = eth_data->dev_private;
 
 	q_storage = dpaa2_q->q_storage[rte_lcore_id()];
 
-	if (unlikely(priv->flags & DPAAX_RX_ERROR_QUEUE_FLAG))
-		dump_err_pkts(priv->rx_err_vq);
+	/* the error-queue drain runs on the regular portal (DPAA2_PER_LCORE_PORTAL);
+	 * the channel/interrupt path owns the ethrx portal, so skip it there
+	 */
+	if (!by_channel) {
+		struct dpaa2_dev_priv *priv = eth_data->dev_private;
+
+		if (unlikely(priv->flags & DPAAX_RX_ERROR_QUEUE_FLAG))
+			dump_err_pkts(priv->rx_err_vq);
+	}
 
 	if (unlikely(!DPAA2_PER_LCORE_ETHRX_DPIO)) {
 		ret = dpaa2_affine_qbman_ethrx_swp();
@@ -793,7 +799,7 @@ dpaa2_dev_prefetch_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		}
 	}
 
-	if (unlikely(!rte_dpaa2_bpid_info &&
+	if (!by_channel && unlikely(!rte_dpaa2_bpid_info &&
 		     rte_eal_process_type() == RTE_PROC_SECONDARY))
 		rte_dpaa2_bpid_info = dpaa2_q->bp_array;
 
@@ -806,7 +812,12 @@ dpaa2_dev_prefetch_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		qbman_pull_desc_clear(&pulldesc);
 		qbman_pull_desc_set_numframes(&pulldesc,
 					      q_storage->last_num_pkts);
-		qbman_pull_desc_set_fq(&pulldesc, fqid);
+		if (by_channel)
+			qbman_pull_desc_set_channel(&pulldesc,
+				dpaa2_q->napi_dpcon->qbman_ch_id,
+				qbman_pull_type_active);
+		else
+			qbman_pull_desc_set_fq(&pulldesc, dpaa2_q->fqid);
 		qbman_pull_desc_set_storage(&pulldesc, dq_storage,
 			(uint64_t)(DPAA2_VADDR_TO_IOVA(dq_storage)), 1);
 		if (check_swp_active_dqs(DPAA2_PER_LCORE_ETHRX_DPIO->index)) {
@@ -842,7 +853,12 @@ dpaa2_dev_prefetch_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	dq_storage1 = q_storage->dq_storage[q_storage->toggle];
 	qbman_pull_desc_clear(&pulldesc);
 	qbman_pull_desc_set_numframes(&pulldesc, pull_size);
-	qbman_pull_desc_set_fq(&pulldesc, fqid);
+	if (by_channel)
+		qbman_pull_desc_set_channel(&pulldesc,
+			dpaa2_q->napi_dpcon->qbman_ch_id,
+			qbman_pull_type_active);
+	else
+		qbman_pull_desc_set_fq(&pulldesc, dpaa2_q->fqid);
 	qbman_pull_desc_set_storage(&pulldesc, dq_storage1,
 		(uint64_t)(DPAA2_VADDR_TO_IOVA(dq_storage1)), 1);
 
@@ -885,6 +901,8 @@ dpaa2_dev_prefetch_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			bufs[num_rx] = eth_fd_to_mbuf(fd, eth_data->port_id);
 #if defined(RTE_LIBRTE_IEEE1588)
 		if (bufs[num_rx]->ol_flags & RTE_MBUF_F_RX_IEEE1588_TMST) {
+			struct dpaa2_dev_priv *priv = eth_data->dev_private;
+
 			priv->rx_timestamp =
 				*dpaa2_timestamp_dynfield(bufs[num_rx]);
 		}
@@ -918,6 +936,27 @@ dpaa2_dev_prefetch_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	return num_rx;
 }
 
+uint16_t __rte_hot
+dpaa2_dev_prefetch_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
+{
+	return dpaa2_dev_prefetch_rx_common(queue, bufs, nb_pkts, false);
+}
+
+/* rx interrupt/CDAN path: each Rx FQ is scheduled to its own DPCON channel,
+ * which a CDAN notifies on empty->non-empty. A VDQ on a scheduled FQ never
+ * completes, so the channel is drained by a volatile pull on the CHANNEL (not
+ * the FQID); one FQ per channel, so no demux is needed. Same prefetch pipeline
+ * as dpaa2_dev_prefetch_rx (one VDQ kept in flight to mask the ~700 cycle
+ * latency); the portal's single in-flight VDQ (global_active_dqs) must be
+ * quiesced before an interrupt sleep.
+ */
+uint16_t __rte_hot
+dpaa2_dev_prefetch_rx_channel(void *queue, struct rte_mbuf **bufs,
+			      uint16_t nb_pkts)
+{
+	return dpaa2_dev_prefetch_rx_common(queue, bufs, nb_pkts, true);
+}
+
 void __rte_hot
 dpaa2_dev_process_parallel_event(struct qbman_swp *swp,
 				 const struct qbman_fd *fd,
@@ -997,8 +1036,9 @@ dpaa2_dev_process_ordered_event(struct qbman_swp *swp,
 	qbman_swp_dqrr_consume(swp, dq);
 }
 
-uint16_t
-dpaa2_dev_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
+static __rte_always_inline uint16_t
+dpaa2_dev_rx_common(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts,
+		    bool by_channel)
 {
 	/* Function receive frames for a given device and VQ */
 	struct dpaa2_queue *dpaa2_q = queue;
@@ -1012,24 +1052,39 @@ dpaa2_dev_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	struct rte_eth_dev_data *eth_data = dpaa2_q->eth_data;
 	struct dpaa2_dev_priv *priv = eth_data->dev_private;
 
-	if (unlikely(priv->flags & DPAAX_RX_ERROR_QUEUE_FLAG))
+	if (!by_channel && unlikely(priv->flags & DPAAX_RX_ERROR_QUEUE_FLAG))
 		dump_err_pkts(priv->rx_err_vq);
 
-	if (unlikely(!DPAA2_PER_LCORE_DPIO)) {
-		ret = dpaa2_affine_qbman_swp();
-		if (ret) {
-			DPAA2_PMD_ERR(
-				"Failed to allocate IO portal, tid: %d",
-				rte_gettid());
-			return 0;
+	if (by_channel) {
+		if (unlikely(!DPAA2_PER_LCORE_ETHRX_DPIO)) {
+			ret = dpaa2_affine_qbman_ethrx_swp();
+			if (ret) {
+				DPAA2_PMD_ERR("Failure in affining portal");
+				return 0;
+			}
+		}
+		swp = DPAA2_PER_LCORE_ETHRX_PORTAL;
+	} else {
+		if (unlikely(!DPAA2_PER_LCORE_DPIO)) {
+			ret = dpaa2_affine_qbman_swp();
+			if (ret) {
+				DPAA2_PMD_ERR("Failed to allocate IO portal, tid: %d",
+					rte_gettid());
+				return 0;
+			}
 		}
+		swp = DPAA2_PER_LCORE_PORTAL;
 	}
-	swp = DPAA2_PER_LCORE_PORTAL;
 
 	do {
 		dq_storage = dpaa2_q->q_storage[0]->dq_storage[0];
 		qbman_pull_desc_clear(&pulldesc);
-		qbman_pull_desc_set_fq(&pulldesc, fqid);
+		if (by_channel)
+			qbman_pull_desc_set_channel(&pulldesc,
+				dpaa2_q->napi_dpcon->qbman_ch_id,
+				qbman_pull_type_active);
+		else
+			qbman_pull_desc_set_fq(&pulldesc, fqid);
 		qbman_pull_desc_set_storage(&pulldesc, dq_storage,
 				(size_t)(DPAA2_VADDR_TO_IOVA(dq_storage)), 1);
 
@@ -1108,6 +1163,22 @@ dpaa2_dev_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	return num_rx;
 }
 
+uint16_t
+dpaa2_dev_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
+{
+	return dpaa2_dev_rx_common(queue, bufs, nb_pkts, false);
+}
+
+/* rx-interrupt path: synchronous volatile dequeue on the queue's DPCON channel
+ * (no prefetch pipeline, so nothing is left in flight across an interrupt
+ * sleep, and a channel VDQ -- unlike an FQ VDQ -- completes on a scheduled FQ).
+ */
+uint16_t __rte_hot
+dpaa2_dev_rx_channel(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
+{
+	return dpaa2_dev_rx_common(queue, bufs, nb_pkts, true);
+}
+
 uint16_t dpaa2_dev_tx_conf(void *queue)
 {
 	/* Function receive frames for a given device and VQ */
@@ -1500,7 +1571,6 @@ dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	}
 skip_tx:
 	dpaa2_q->tx_pkts += num_tx;
-
 	for (loop = 0; loop < free_count; loop++) {
 		if (buf_to_free[loop].pkt_id < num_tx)
 			rte_pktmbuf_free_seg(buf_to_free[loop].seg);
-- 
2.43.0

