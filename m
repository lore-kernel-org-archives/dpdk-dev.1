Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC1BCD8CB9
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 07:21:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A42AB402EB;
	Wed, 10 Jun 2026 09:21:37 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id F13AB40270
 for <dev@dpdk.org>; Wed, 10 Jun 2026 09:21:35 +0200 (CEST)
Received: from alhe-weh-mana-dpdk-s2.corp.microsoft.com (unknown
 [167.220.2.160])
 by linux.microsoft.com (Postfix) with ESMTPSA id A59E520B7168;
 Wed, 10 Jun 2026 00:21:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A59E520B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1781076075;
 bh=ve6g2QbIyfH5FNLgQAlc69EiX0MXBtmKJ7IdM7hQALY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Zec3whDuLac7p3m2kvXYeHaSzab0SxNRl+GoWEmaCQgrEDRoOjfgcRsji3S1gaHHV
 de4/HA4wxH3cbEMznh5jG3qyFaxLYA8EidQpyh8FTRo+AIfVdGELLbojUeJC+U5Z8F
 hogNcHGt+dvEOfbMvRtfQND6qNy1y3hYEDlxMCgo=
From: Wei Hu <weh@linux.microsoft.com>
To: dev@dpdk.org,
	stephen@networkplumber.org
Cc: longli@microsoft.com,
	weh@microsoft.com
Subject: [PATCH v8 1/1] net/mana: add device reset support
Date: Wed, 10 Jun 2026 00:21:22 -0700
Message-Id: <dfecc660eabf7aef84bb4942b67672b5b3d708b5.1781017284.git.weh@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1781017284.git.weh@linux.microsoft.com>
References: <cover.1781017284.git.weh@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Wei Hu <weh@microsoft.com>

Add support for handling hardware reset events in the MANA driver.
When the MANA kernel driver receives a hardware service event, it
initiates a device reset and notifies userspace via
IBV_EVENT_DEVICE_FATAL. The DPDK driver handles this by performing
an automatic teardown and recovery sequence.

The interrupt handler sets the device state, blocks new data path
bursts, waits for in-flight bursts to drain using per-queue atomic
flags, and spawns a control thread. The control thread performs
teardown immediately (dev_stop, secondary IPC, dev_close, MR cache
free) before waiting for the hardware recovery timer to fire. This
avoids blocking the EAL interrupt thread on multi-second IPC
timeouts and ibverbs calls. After the recovery delay, the thread
unregisters the interrupt handler, re-probes the PCI device,
reinitializes MR caches, and restarts queues. Each function owns
its own lock scope with no lock hand-off between threads.

Each queue has an atomic burst_state variable where bit 0 is the
in-burst flag and bit 1 is a blocked flag. The data path uses a
single compare-and-swap (0 to 1) to enter a burst, which fails
immediately if the blocked bit is set. The reset path sets the
blocked bit via atomic fetch-or and polls bit 0 to wait for
in-flight bursts to drain. This single-variable design avoids the
need for sequential consistency ordering.

A per-device mutex serializes the reset path with ethdev
operations. The mutex uses PTHREAD_PROCESS_SHARED for multi-process
support and is held across blocking IB verbs calls. A trylock
helper encapsulates the lock acquisition and device state check
for all ethdev operation wrappers. Operations that cannot wait
(configure, queue setup) return -EBUSY during reset, while
dev_stop and dev_close join the reset thread before acquiring
the lock to ensure proper sequencing. A CAS-based helper prevents
double-join of the reset thread.

Multi-process support is included: secondary processes unmap and
remap doorbell pages via IPC during the reset enter and exit
phases. Data path functions in both primary and secondary
processes check the device state atomically and return early when
the device is not active.

The driver emits RTE_ETH_EVENT_ERR_RECOVERING before entering the
reset path so that upper layers (e.g. netvsc) can switch their
data path before queues are stopped. The event is emitted outside
the reset lock to avoid deadlock if the callback calls dev_stop or
dev_close. On completion, the driver emits RECOVERY_SUCCESS or
RECOVERY_FAILED after releasing the lock and clearing the
reset_thread_active flag, preventing self-join deadlock if the
callback calls dev_stop or dev_close. If the enter phase fails
internally, RECOVERY_FAILED is sent immediately so the application
receives a terminal event. A PCI device removal event callback
distinguishes hot-remove from service reset.

Documentation for the device reset feature is added in the MANA
NIC guide and the 26.07 release notes.

Signed-off-by: Wei Hu <weh@microsoft.com>
---
 doc/guides/nics/mana.rst               |   40 +
 doc/guides/rel_notes/release_26_07.rst |    8 +
 drivers/net/mana/mana.c                | 1076 ++++++++++++++++++++++--
 drivers/net/mana/mana.h                |   52 +-
 drivers/net/mana/mp.c                  |   89 +-
 drivers/net/mana/mr.c                  |    6 +-
 drivers/net/mana/rx.c                  |   23 +-
 drivers/net/mana/tx.c                  |   44 +-
 8 files changed, 1230 insertions(+), 108 deletions(-)

diff --git a/doc/guides/nics/mana.rst b/doc/guides/nics/mana.rst
index 0fcab6e2f6..08e345ea61 100644
--- a/doc/guides/nics/mana.rst
+++ b/doc/guides/nics/mana.rst
@@ -71,3 +71,43 @@ The user can specify below argument in devargs.
     The default value is not set,
     meaning all the NICs will be probed and loaded.
     User can specify multiple mac=xx:xx:xx:xx:xx:xx arguments for up to 8 NICs.
+
+Device Reset Support
+--------------------
+
+The MANA PMD supports automatic recovery from hardware service reset events.
+When the MANA kernel driver receives a hardware service event,
+it initiates a device reset and notifies userspace
+via ``IBV_EVENT_DEVICE_FATAL``.
+
+The driver handles this transparently through a two-phase reset flow:
+
+* **Enter phase**: The interrupt handler blocks new data path bursts
+  and waits for all in-flight burst calls to drain
+  using per-queue atomic flags,
+  then spawns a control thread for the remaining work.
+
+* **Teardown and exit phase**: The control thread tears down
+  IB resources and queues, unmaps secondary process doorbell pages,
+  and closes the device. After a delay for hardware recovery,
+  it re-probes the PCI device,
+  reinstalls the interrupt handler,
+  reinitializes resources, and restarts queues.
+
+The driver emits the following ethdev recovery events
+to notify upper layers (e.g. netvsc) of the reset lifecycle:
+
+``RTE_ETH_EVENT_ERR_RECOVERING``
+   Reset has started.
+
+``RTE_ETH_EVENT_RECOVERY_SUCCESS``
+   Device has recovered successfully.
+
+``RTE_ETH_EVENT_RECOVERY_FAILED``
+   Recovery failed.
+
+To distinguish a PCI hot-remove from a service reset,
+the driver registers for PCI device removal events.
+This requires the application to call ``rte_dev_event_monitor_start()``
+for removal events to be delivered
+(e.g. testpmd ``--hot-plug-handling`` option).
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index bd0cec2709..58e8c2422e 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -122,6 +122,14 @@ New Features
   Added AGENTS.md file for AI review
   and supporting scripts to review patches and documentation.
 
+* **Added device reset support to the MANA PMD.**
+
+  Added automatic recovery from hardware service reset events
+  in the MANA poll mode driver. The driver uses ethdev recovery events
+  (``RTE_ETH_EVENT_ERR_RECOVERING``, ``RTE_ETH_EVENT_RECOVERY_SUCCESS``,
+  ``RTE_ETH_EVENT_RECOVERY_FAILED``) to notify upper layers of the
+  reset lifecycle.
+
 
 Removed Items
 -------------
diff --git a/drivers/net/mana/mana.c b/drivers/net/mana/mana.c
index 67396cda1f..96990190b1 100644
--- a/drivers/net/mana/mana.c
+++ b/drivers/net/mana/mana.c
@@ -103,6 +103,8 @@ mana_dev_configure(struct rte_eth_dev *dev)
 			      RTE_ETH_RX_OFFLOAD_VLAN_STRIP);
 
 	priv->num_queues = dev->data->nb_rx_queues;
+	DRV_LOG(DEBUG, "priv %p, port %u, dev port %u, num_queues: %u",
+		priv, priv->port_id, priv->dev_port, priv->num_queues);
 
 	manadv_set_context_attr(priv->ib_ctx, MANADV_CTX_ATTR_BUF_ALLOCATORS,
 				(void *)((uintptr_t)&(struct manadv_ctx_allocators){
@@ -214,8 +216,8 @@ mana_dev_start(struct rte_eth_dev *dev)
 
 	DRV_LOG(INFO, "TX/RX queues have started");
 
-	/* Enable datapath for secondary processes */
-	mana_mp_req_on_rxtx(dev, MANA_MP_REQ_START_RXTX);
+	/* Intentionally ignore errors — secondary may not be running */
+	(void)mana_mp_req_on_rxtx(dev, MANA_MP_REQ_START_RXTX);
 
 	ret = rxq_intr_enable(priv);
 	if (ret) {
@@ -242,26 +244,33 @@ mana_dev_stop(struct rte_eth_dev *dev)
 {
 	int ret;
 	struct mana_priv *priv = dev->data->dev_private;
-
-	rxq_intr_disable(priv);
+	enum mana_device_state state;
+
+	state = rte_atomic_load_explicit(&priv->dev_state,
+					 rte_memory_order_acquire);
+	if (state == MANA_DEV_ACTIVE ||
+	    state == MANA_DEV_RESET_FAILED) {
+		rxq_intr_disable(priv);
+		DRV_LOG(DEBUG, "rxq_intr_disable called");
+	}
 
 	dev->tx_pkt_burst = mana_tx_burst_removed;
 	dev->rx_pkt_burst = mana_rx_burst_removed;
 
-	/* Stop datapath on secondary processes */
-	mana_mp_req_on_rxtx(dev, MANA_MP_REQ_STOP_RXTX);
+	/* Intentionally ignore errors — secondary may not be running */
+	(void)mana_mp_req_on_rxtx(dev, MANA_MP_REQ_STOP_RXTX);
 
 	rte_wmb();
 
 	ret = mana_stop_tx_queues(dev);
 	if (ret) {
-		DRV_LOG(ERR, "failed to stop tx queues");
+		DRV_LOG(ERR, "failed to stop tx queues, ret %d", ret);
 		return ret;
 	}
 
 	ret = mana_stop_rx_queues(dev);
 	if (ret) {
-		DRV_LOG(ERR, "failed to stop tx queues");
+		DRV_LOG(ERR, "failed to stop rx queues, ret %d", ret);
 		return ret;
 	}
 
@@ -275,36 +284,66 @@ mana_dev_close(struct rte_eth_dev *dev)
 {
 	struct mana_priv *priv = dev->data->dev_private;
 	int ret;
+	enum mana_device_state state;
 
+	DRV_LOG(DEBUG, "Free MR for priv %p", priv);
 	mana_remove_all_mr(priv);
 
-	ret = mana_intr_uninstall(priv);
-	if (ret)
-		return ret;
+	state = rte_atomic_load_explicit(&priv->dev_state,
+					 rte_memory_order_acquire);
+	if (state == MANA_DEV_ACTIVE ||
+	    state == MANA_DEV_RESET_FAILED) {
+		ret = mana_intr_uninstall(priv);
+		if (ret)
+			return ret;
+	}
 
 	if (priv->ib_parent_pd) {
-		int err = ibv_dealloc_pd(priv->ib_parent_pd);
-		if (err)
-			DRV_LOG(ERR, "Failed to deallocate parent PD: %d", err);
+		ret = ibv_dealloc_pd(priv->ib_parent_pd);
+		if (ret)
+			DRV_LOG(ERR,
+				"Failed to deallocate parent PD: %d", ret);
 		priv->ib_parent_pd = NULL;
 	}
 
 	if (priv->ib_pd) {
-		int err = ibv_dealloc_pd(priv->ib_pd);
-		if (err)
-			DRV_LOG(ERR, "Failed to deallocate PD: %d", err);
+		ret = ibv_dealloc_pd(priv->ib_pd);
+		if (ret)
+			DRV_LOG(ERR, "Failed to deallocate PD: %d", ret);
 		priv->ib_pd = NULL;
 	}
 
-	ret = ibv_close_device(priv->ib_ctx);
-	if (ret) {
-		ret = errno;
-		return ret;
+	state = rte_atomic_load_explicit(&priv->dev_state,
+					 rte_memory_order_acquire);
+	if (state == MANA_DEV_ACTIVE ||
+	    state == MANA_DEV_RESET_FAILED) {
+		if (priv->ib_ctx) {
+			ret = ibv_close_device(priv->ib_ctx);
+			if (ret) {
+				ret = errno;
+				return ret;
+			}
+			priv->ib_ctx = NULL;
+		}
 	}
 
 	return 0;
 }
 
+/*
+ * Called from mana_pci_remove to free resources allocated
+ * during probe that are not freed by dev_close.
+ */
+static void
+mana_dev_free_resources(struct rte_eth_dev *dev)
+{
+	struct mana_priv *priv = dev->data->dev_private;
+
+	pthread_mutex_destroy(&priv->reset_ops_lock);
+	pthread_mutex_destroy(&priv->reset_cond_mutex);
+	pthread_cond_destroy(&priv->reset_cond);
+}
+
 static int
 mana_dev_info_get(struct rte_eth_dev *dev,
 		  struct rte_eth_dev_info *dev_info)
@@ -391,6 +430,39 @@ mana_dev_info_get(struct rte_eth_dev *dev,
 	return 0;
 }
 
+/*
+ * Try to acquire the reset lock and verify the device is active.
+ * Returns 0 with lock held on success, or -EBUSY if the lock
+ * could not be acquired or the device is not in ACTIVE state.
+ */
+static int
+mana_reset_trylock(struct mana_priv *priv)
+{
+	if (pthread_mutex_trylock(&priv->reset_ops_lock))
+		return -EBUSY;
+
+	if (rte_atomic_load_explicit(&priv->dev_state,
+	    rte_memory_order_acquire) != MANA_DEV_ACTIVE) {
+		pthread_mutex_unlock(&priv->reset_ops_lock);
+		return -EBUSY;
+	}
+	return 0;
+}
+
+static int
+mana_dev_info_get_lock(struct rte_eth_dev *dev,
+		       struct rte_eth_dev_info *dev_info)
+{
+	struct mana_priv *priv = dev->data->dev_private;
+	int ret;
+
+	if (mana_reset_trylock(priv))
+		return -EBUSY;
+	ret = mana_dev_info_get(dev, dev_info);
+	pthread_mutex_unlock(&priv->reset_ops_lock);
+	return ret;
+}
+
 static void
 mana_dev_tx_queue_info(struct rte_eth_dev *dev, uint16_t queue_id,
 		       struct rte_eth_txq_info *qinfo)
@@ -552,6 +624,22 @@ mana_dev_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	return ret;
 }
 
+static int
+mana_dev_tx_queue_setup_lock(struct rte_eth_dev *dev, uint16_t queue_idx,
+			     uint16_t nb_desc, unsigned int socket_id,
+			     const struct rte_eth_txconf *tx_conf)
+{
+	struct mana_priv *priv = dev->data->dev_private;
+	int ret;
+
+	if (mana_reset_trylock(priv))
+		return -EBUSY;
+	ret = mana_dev_tx_queue_setup(dev, queue_idx,
+				      nb_desc, socket_id, tx_conf);
+	pthread_mutex_unlock(&priv->reset_ops_lock);
+	return ret;
+}
+
 static void
 mana_dev_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
 {
@@ -629,6 +717,23 @@ mana_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	return ret;
 }
 
+static int
+mana_dev_rx_queue_setup_lock(struct rte_eth_dev *dev, uint16_t queue_idx,
+			     uint16_t nb_desc, unsigned int socket_id,
+			     const struct rte_eth_rxconf *rx_conf __rte_unused,
+			     struct rte_mempool *mp)
+{
+	struct mana_priv *priv = dev->data->dev_private;
+	int ret;
+
+	if (mana_reset_trylock(priv))
+		return -EBUSY;
+	ret = mana_dev_rx_queue_setup(dev, queue_idx, nb_desc,
+				      socket_id, rx_conf, mp);
+	pthread_mutex_unlock(&priv->reset_ops_lock);
+	return ret;
+}
+
 static void
 mana_dev_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
 {
@@ -820,33 +925,253 @@ mana_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
 	return mana_ifreq(priv, SIOCSIFMTU, &request);
 }
 
+static int
+mana_dev_configure_lock(struct rte_eth_dev *dev)
+{
+	struct mana_priv *priv = dev->data->dev_private;
+	int ret;
+
+	if (mana_reset_trylock(priv))
+		return -EBUSY;
+	ret = mana_dev_configure(dev);
+	pthread_mutex_unlock(&priv->reset_ops_lock);
+	return ret;
+}
+
+static int
+mana_dev_start_lock(struct rte_eth_dev *dev)
+{
+	struct mana_priv *priv = dev->data->dev_private;
+	int ret;
+
+	if (mana_reset_trylock(priv))
+		return -EBUSY;
+	ret = mana_dev_start(dev);
+	pthread_mutex_unlock(&priv->reset_ops_lock);
+	return ret;
+}
+
+/*
+ * Join the reset thread if it is active. Uses CAS on
+ * reset_thread_active to ensure only one caller joins.
+ */
+static void
+mana_join_reset_thread(struct mana_priv *priv)
+{
+	bool expected = true;
+
+	if (rte_atomic_compare_exchange_strong_explicit(
+			&priv->reset_thread_active, &expected, false,
+			rte_memory_order_acq_rel,
+			rte_memory_order_acquire)) {
+		pthread_mutex_lock(&priv->reset_cond_mutex);
+		rte_atomic_store_explicit(&priv->dev_state,
+			MANA_DEV_ACTIVE, rte_memory_order_release);
+		pthread_cond_signal(&priv->reset_cond);
+		pthread_mutex_unlock(&priv->reset_cond_mutex);
+		rte_thread_join(priv->reset_thread, NULL);
+	}
+}
+
+/*
+ * Clear per-queue burst_state so the data path CAS can succeed again.
+ * Must be called under reset_ops_lock when transitioning back to ACTIVE
+ * after a failed or aborted reset.
+ */
+static void
+mana_clear_burst_state(struct rte_eth_dev *dev)
+{
+	struct mana_priv *priv = dev->data->dev_private;
+	int i;
+
+	for (i = 0; i < priv->num_queues; i++) {
+		struct mana_rxq *rxq = dev->data->rx_queues[i];
+		struct mana_txq *txq = dev->data->tx_queues[i];
+
+		if (rxq)
+			rte_atomic_store_explicit(&rxq->burst_state, 0,
+						  rte_memory_order_release);
+		if (txq)
+			rte_atomic_store_explicit(&txq->burst_state, 0,
+						  rte_memory_order_release);
+	}
+}
+
+/*
+ * Custom lock wrappers for dev_stop and dev_close.
+ * These join any active reset thread and use a blocking lock (not
+ * trylock) so they wait for any in-progress reset processing to
+ * finish, rather than returning -EBUSY. When the device is not in
+ * MANA_DEV_ACTIVE state, they transition state to MANA_DEV_ACTIVE.
+ */
+static int
+mana_dev_stop_lock(struct rte_eth_dev *dev)
+{
+	struct mana_priv *priv = dev->data->dev_private;
+	int ret;
+
+	mana_join_reset_thread(priv);
+
+	pthread_mutex_lock(&priv->reset_ops_lock);
+
+	if (rte_atomic_load_explicit(&priv->dev_state,
+	    rte_memory_order_acquire) != MANA_DEV_ACTIVE) {
+		mana_clear_burst_state(dev);
+		rte_atomic_store_explicit(&priv->dev_state,
+			MANA_DEV_ACTIVE, rte_memory_order_release);
+		pthread_mutex_unlock(&priv->reset_ops_lock);
+		return 0;
+	}
+
+	ret = mana_dev_stop(dev);
+	pthread_mutex_unlock(&priv->reset_ops_lock);
+	return ret;
+}
+
+static int
+mana_dev_close_lock(struct rte_eth_dev *dev)
+{
+	struct mana_priv *priv = dev->data->dev_private;
+	int ret;
+
+	mana_join_reset_thread(priv);
+
+	pthread_mutex_lock(&priv->reset_ops_lock);
+
+	if (rte_atomic_load_explicit(&priv->dev_state,
+	    rte_memory_order_acquire) != MANA_DEV_ACTIVE) {
+		mana_clear_burst_state(dev);
+		rte_atomic_store_explicit(&priv->dev_state,
+			MANA_DEV_ACTIVE, rte_memory_order_release);
+	}
+
+	ret = mana_dev_close(dev);
+	pthread_mutex_unlock(&priv->reset_ops_lock);
+	return ret;
+}
+
+static int
+mana_rss_hash_update_lock(struct rte_eth_dev *dev,
+			  struct rte_eth_rss_conf *rss_conf)
+{
+	struct mana_priv *priv = dev->data->dev_private;
+	int ret;
+
+	if (mana_reset_trylock(priv))
+		return -EBUSY;
+	ret = mana_rss_hash_update(dev, rss_conf);
+	pthread_mutex_unlock(&priv->reset_ops_lock);
+	return ret;
+}
+
+static int
+mana_rss_hash_conf_get_lock(struct rte_eth_dev *dev,
+			    struct rte_eth_rss_conf *rss_conf)
+{
+	struct mana_priv *priv = dev->data->dev_private;
+	int ret;
+
+	if (mana_reset_trylock(priv))
+		return -EBUSY;
+	ret = mana_rss_hash_conf_get(dev, rss_conf);
+	pthread_mutex_unlock(&priv->reset_ops_lock);
+	return ret;
+}
+
+static void
+mana_dev_tx_queue_release_lock(struct rte_eth_dev *dev, uint16_t qid)
+{
+	struct mana_priv *priv = dev->data->dev_private;
+
+	if (mana_reset_trylock(priv)) {
+		DRV_LOG(ERR, "Device reset in progress, "
+			"mana_dev_tx_queue_release not called");
+		return;
+	}
+	mana_dev_tx_queue_release(dev, qid);
+	pthread_mutex_unlock(&priv->reset_ops_lock);
+}
+
+static void
+mana_dev_rx_queue_release_lock(struct rte_eth_dev *dev, uint16_t qid)
+{
+	struct mana_priv *priv = dev->data->dev_private;
+
+	if (mana_reset_trylock(priv)) {
+		DRV_LOG(ERR, "Device reset in progress, "
+			"mana_dev_rx_queue_release not called");
+		return;
+	}
+	mana_dev_rx_queue_release(dev, qid);
+	pthread_mutex_unlock(&priv->reset_ops_lock);
+}
+
+static int
+mana_rx_intr_enable_lock(struct rte_eth_dev *dev, uint16_t rx_queue_id)
+{
+	struct mana_priv *priv = dev->data->dev_private;
+	int ret;
+
+	if (mana_reset_trylock(priv))
+		return -EBUSY;
+	ret = mana_rx_intr_enable(dev, rx_queue_id);
+	pthread_mutex_unlock(&priv->reset_ops_lock);
+	return ret;
+}
+
+static int
+mana_rx_intr_disable_lock(struct rte_eth_dev *dev, uint16_t rx_queue_id)
+{
+	struct mana_priv *priv = dev->data->dev_private;
+	int ret;
+
+	if (mana_reset_trylock(priv))
+		return -EBUSY;
+	ret = mana_rx_intr_disable(dev, rx_queue_id);
+	pthread_mutex_unlock(&priv->reset_ops_lock);
+	return ret;
+}
+
+static int
+mana_mtu_set_lock(struct rte_eth_dev *dev, uint16_t mtu)
+{
+	struct mana_priv *priv = dev->data->dev_private;
+	int ret;
+
+	if (mana_reset_trylock(priv))
+		return -EBUSY;
+	ret = mana_mtu_set(dev, mtu);
+	pthread_mutex_unlock(&priv->reset_ops_lock);
+	return ret;
+}
+
 static const struct eth_dev_ops mana_dev_ops = {
-	.dev_configure		= mana_dev_configure,
-	.dev_start		= mana_dev_start,
-	.dev_stop		= mana_dev_stop,
-	.dev_close		= mana_dev_close,
-	.dev_infos_get		= mana_dev_info_get,
+	.dev_configure		= mana_dev_configure_lock,
+	.dev_start		= mana_dev_start_lock,
+	.dev_stop		= mana_dev_stop_lock,
+	.dev_close		= mana_dev_close_lock,
+	.dev_infos_get		= mana_dev_info_get_lock,
 	.txq_info_get		= mana_dev_tx_queue_info,
 	.rxq_info_get		= mana_dev_rx_queue_info,
 	.dev_supported_ptypes_get = mana_supported_ptypes,
-	.rss_hash_update	= mana_rss_hash_update,
-	.rss_hash_conf_get	= mana_rss_hash_conf_get,
-	.tx_queue_setup		= mana_dev_tx_queue_setup,
-	.tx_queue_release	= mana_dev_tx_queue_release,
-	.rx_queue_setup		= mana_dev_rx_queue_setup,
-	.rx_queue_release	= mana_dev_rx_queue_release,
-	.rx_queue_intr_enable	= mana_rx_intr_enable,
-	.rx_queue_intr_disable	= mana_rx_intr_disable,
+	.rss_hash_update	= mana_rss_hash_update_lock,
+	.rss_hash_conf_get	= mana_rss_hash_conf_get_lock,
+	.tx_queue_setup		= mana_dev_tx_queue_setup_lock,
+	.tx_queue_release	= mana_dev_tx_queue_release_lock,
+	.rx_queue_setup		= mana_dev_rx_queue_setup_lock,
+	.rx_queue_release	= mana_dev_rx_queue_release_lock,
+	.rx_queue_intr_enable	= mana_rx_intr_enable_lock,
+	.rx_queue_intr_disable	= mana_rx_intr_disable_lock,
 	.link_update		= mana_dev_link_update,
 	.stats_get		= mana_dev_stats_get,
 	.stats_reset		= mana_dev_stats_reset,
-	.mtu_set		= mana_mtu_set,
+	.mtu_set		= mana_mtu_set_lock,
 };
 
 static const struct eth_dev_ops mana_dev_secondary_ops = {
 	.stats_get = mana_dev_stats_get,
 	.stats_reset = mana_dev_stats_reset,
-	.dev_infos_get = mana_dev_info_get,
+	.dev_infos_get = mana_dev_info_get_lock,
 };
 
 uint16_t
@@ -1031,28 +1356,517 @@ mana_ibv_device_to_pci_addr(const struct ibv_device *device,
 	return 0;
 }
 
+static int mana_pci_probe(struct rte_pci_driver *pci_drv,
+			  struct rte_pci_device *pci_dev);
+static void mana_intr_handler(void *arg);
+static void mana_reset_exit(struct mana_priv *priv);
+
+/* Delay before initiating reset exit after reset enter completes */
+#define MANA_RESET_TIMER_US (15 * 1000000ULL) /* 15 seconds */
+
 /*
- * Interrupt handler from IB layer to notify this device is being removed.
+ * Callback for PCI device removal events from EAL.
+ * If the device is in reset (RESET_EXIT state), this means the PCI
+ * device was hot-removed rather than a service reset. Wake the reset
+ * thread via condvar and notify netvsc via RTE_ETH_EVENT_INTR_RMV.
+ */
+static void
+mana_pci_remove_event_cb(const char *device_name,
+			 enum rte_dev_event_type event, void *cb_arg)
+{
+	struct mana_priv *priv = cb_arg;
+	struct rte_eth_dev *dev;
+
+	if (event != RTE_DEV_EVENT_REMOVE)
+		return;
+
+	DRV_LOG(INFO, "PCI device %s removed", device_name);
+
+	/* Wake the reset thread immediately */
+	pthread_mutex_lock(&priv->reset_cond_mutex);
+	rte_atomic_store_explicit(&priv->dev_state,
+		MANA_DEV_RESET_FAILED, rte_memory_order_release);
+	pthread_cond_signal(&priv->reset_cond);
+	pthread_mutex_unlock(&priv->reset_cond_mutex);
+
+	pthread_mutex_lock(&priv->reset_ops_lock);
+	pthread_mutex_unlock(&priv->reset_ops_lock);
+
+	dev = &rte_eth_devices[priv->port_id];
+	DRV_LOG(INFO, "Sending RTE_ETH_EVENT_INTR_RMV for port %u",
+		priv->port_id);
+	rte_eth_dev_callback_process(dev,
+		RTE_ETH_EVENT_INTR_RMV, NULL);
+}
+
+/*
+ * Reset thread: performs teardown immediately, waits for the
+ * recovery timer, then re-probes and restarts the device.
+ * Runs on a control thread so it can call blocking IPC, ibv
+ * teardown, and rte_intr_callback_unregister (which all must
+ * not run on the EAL interrupt thread).
+ */
+static uint32_t
+mana_reset_thread(void *arg)
+{
+	struct mana_priv *priv = (struct mana_priv *)arg;
+	struct rte_eth_dev *dev = &rte_eth_devices[priv->port_id];
+	struct timespec ts;
+	int ret;
+	int i;
+
+	DRV_LOG(INFO, "Reset thread started");
+
+	pthread_mutex_lock(&priv->reset_ops_lock);
+
+	/* Teardown: stop data path, unmap secondary doorbells, close device,
+	 * free MR caches. Must happen immediately — hardware may be gone.
+	 */
+	ret = mana_dev_stop(dev);
+	if (ret) {
+		DRV_LOG(ERR, "Failed to stop mana dev ret %d", ret);
+		rte_atomic_store_explicit(&priv->dev_state,
+			MANA_DEV_RESET_FAILED, rte_memory_order_release);
+		goto reset_failed;
+	}
+
+	ret = mana_mp_req_on_rxtx(dev, MANA_MP_REQ_RESET_ENTER);
+	if (ret) {
+		DRV_LOG(ERR, "Failed to reset secondary processes ret = %d",
+			ret);
+		rte_atomic_store_explicit(&priv->dev_state,
+			MANA_DEV_RESET_FAILED, rte_memory_order_release);
+		goto reset_failed;
+	}
+
+	ret = mana_dev_close(dev);
+	if (ret) {
+		DRV_LOG(ERR, "Failed to close mana dev ret %d", ret);
+		rte_atomic_store_explicit(&priv->dev_state,
+			MANA_DEV_RESET_FAILED, rte_memory_order_release);
+		goto reset_failed;
+	}
+
+	for (i = 0; i < priv->num_queues; i++) {
+		struct mana_rxq *rxq = dev->data->rx_queues[i];
+		struct mana_txq *txq = dev->data->tx_queues[i];
+
+		DRV_LOG(DEBUG, "Free MR for priv = %p, rxq %u, txq %u",
+			priv, rxq->rxq_idx, txq->txq_idx);
+		mana_mr_btree_free(&rxq->mr_btree);
+		mana_mr_btree_free(&txq->mr_btree);
+	}
+
+	DRV_LOG(DEBUG, "Teardown complete");
+
+	rte_atomic_store_explicit(&priv->dev_state, MANA_DEV_RESET_EXIT,
+				     rte_memory_order_release);
+
+	pthread_mutex_unlock(&priv->reset_ops_lock);
+
+	/* Wait for the recovery timer before re-probing.
+	 * Can be woken early by PCI remove via condvar signal.
+	 */
+	DRV_LOG(INFO, "Waiting %us for hardware recovery",
+		(unsigned int)(MANA_RESET_TIMER_US / 1000000));
+
+	clock_gettime(CLOCK_REALTIME, &ts);
+	ts.tv_sec += MANA_RESET_TIMER_US / 1000000;
+
+	pthread_mutex_lock(&priv->reset_cond_mutex);
+	pthread_cond_timedwait(&priv->reset_cond, &priv->reset_cond_mutex, &ts);
+	pthread_mutex_unlock(&priv->reset_cond_mutex);
+
+	pthread_mutex_lock(&priv->reset_ops_lock);
+
+	if (rte_atomic_load_explicit(&priv->dev_state,
+	    rte_memory_order_acquire) != MANA_DEV_RESET_EXIT) {
+		DRV_LOG(INFO, "Reset thread: dev_state=%d, skipping exit",
+			(int)rte_atomic_load_explicit(&priv->dev_state,
+			rte_memory_order_acquire));
+		pthread_mutex_unlock(&priv->reset_ops_lock);
+		return 0;
+	}
+
+	DRV_LOG(INFO, "Reset thread: initiating reset exit");
+	mana_reset_exit(priv);
+	/* Lock is released by mana_reset_exit_delay.
+	 * reset_thread_active is cleared there before emitting
+	 * the recovery event callback.
+	 */
+	return 0;
+
+reset_failed:
+	mana_clear_burst_state(dev);
+	pthread_mutex_unlock(&priv->reset_ops_lock);
+
+	/* Clear before emitting callback — if the callback calls
+	 * dev_stop/dev_close, mana_join_reset_thread must be a no-op
+	 * to avoid self-join deadlock on the current thread.
+	 */
+	rte_atomic_store_explicit(&priv->reset_thread_active,
+		false, rte_memory_order_release);
+
+	DRV_LOG(INFO, "Sending RTE_ETH_EVENT_RECOVERY_FAILED for port %u",
+		priv->port_id);
+	rte_eth_dev_callback_process(dev,
+		RTE_ETH_EVENT_RECOVERY_FAILED, NULL);
+	return 0;
+}
+
+static void
+mana_reset_enter(struct mana_priv *priv)
+{
+	int ret;
+	int i;
+	struct rte_eth_dev *dev = &rte_eth_devices[priv->port_id];
+
+	/*
+	 * Lock ownership: mana_intr_handler acquires reset_ops_lock,
+	 * mana_reset_enter sets state/drains/spawns thread and releases it.
+	 * The reset thread independently acquires/releases the lock for
+	 * teardown and for the exit (re-probe) phase.
+	 */
+
+	rte_atomic_store_explicit(&priv->dev_state, MANA_DEV_RESET_ENTER,
+				     rte_memory_order_release);
+
+	DRV_LOG(DEBUG, "Entering into device reset state");
+	DRV_LOG(DEBUG, "Resetting dev = %p, priv = %p", dev, priv);
+
+	/* Set the blocked bit on each queue's burst_state so new bursts
+	 * are rejected, then wait for any in-flight burst (bit 0) to finish.
+	 */
+	for (i = 0; i < priv->num_queues; i++) {
+		struct mana_rxq *rxq = dev->data->rx_queues[i];
+		struct mana_txq *txq = dev->data->tx_queues[i];
+
+		if (rxq)
+			rte_atomic_fetch_or_explicit(&rxq->burst_state,
+				MANA_BURST_BLOCKED,
+				rte_memory_order_release);
+		if (txq)
+			rte_atomic_fetch_or_explicit(&txq->burst_state,
+				MANA_BURST_BLOCKED,
+				rte_memory_order_release);
+	}
+
+	/* Wait for all in-flight burst calls to finish (bit 0 to clear) */
+	for (i = 0; i < priv->num_queues; i++) {
+		struct mana_rxq *rxq = dev->data->rx_queues[i];
+		struct mana_txq *txq = dev->data->tx_queues[i];
+
+		if (rxq)
+			while (rte_atomic_load_explicit(&rxq->burst_state,
+				    rte_memory_order_acquire) & 1)
+				rte_pause();
+		if (txq)
+			while (rte_atomic_load_explicit(&txq->burst_state,
+				    rte_memory_order_acquire) & 1)
+				rte_pause();
+	}
+
+	DRV_LOG(DEBUG, "All data path threads drained");
+
+	/* Join previous reset thread if it completed but was not joined.
+	 * Use CAS to avoid double-join if another path joined first.
+	 * Don't use mana_join_reset_thread() here — we are already in
+	 * RESET_ENTER state and must not change dev_state to ACTIVE.
+	 */
+	{
+		bool expected = true;
+
+		if (rte_atomic_compare_exchange_strong_explicit(
+				&priv->reset_thread_active, &expected, false,
+				rte_memory_order_acq_rel,
+				rte_memory_order_acquire))
+			rte_thread_join(priv->reset_thread, NULL);
+	}
+
+	ret = rte_thread_create_internal_control(&priv->reset_thread,
+						 "mana-reset",
+						 mana_reset_thread, priv);
+	if (ret) {
+		DRV_LOG(ERR, "Failed to create reset thread ret %d", ret);
+		rte_atomic_store_explicit(&priv->dev_state,
+					  MANA_DEV_RESET_FAILED,
+					  rte_memory_order_release);
+		goto reset_failed;
+	}
+	rte_atomic_store_explicit(&priv->reset_thread_active,
+		true, rte_memory_order_release);
+
+	DRV_LOG(DEBUG, "Reset thread started");
+
+	pthread_mutex_unlock(&priv->reset_ops_lock);
+	return;
+
+reset_failed:
+	mana_clear_burst_state(dev);
+	pthread_mutex_unlock(&priv->reset_ops_lock);
+}
+
+static uint32_t
+mana_reset_exit_delay(void *arg)
+{
+	struct mana_priv *priv = (struct mana_priv *)arg;
+	uint32_t ret = 0;
+	int i;
+	struct rte_eth_dev *dev;
+	struct rte_pci_device *pci_dev;
+
+	DRV_LOG(DEBUG, "Delayed mana device reset complete processing");
+
+	/* If the app called dev_stop/dev_close during the timer window,
+	 * state is no longer RESET_EXIT. Nothing to do.
+	 */
+	if (rte_atomic_load_explicit(&priv->dev_state,
+	    rte_memory_order_acquire) != MANA_DEV_RESET_EXIT) {
+		DRV_LOG(DEBUG, "State is not RESET_EXIT, skipping");
+		pthread_mutex_unlock(&priv->reset_ops_lock);
+		return ret;
+	}
+
+	dev = &rte_eth_devices[priv->port_id];
+	pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
+
+	DRV_LOG(DEBUG, "Resetting dev = %p, priv = %p", dev, priv);
+
+	ret = ibv_close_device(priv->ib_ctx);
+	if (ret) {
+		DRV_LOG(ERR, "Failed to close ibv device %d", ret);
+		rte_atomic_store_explicit(&priv->dev_state, MANA_DEV_RESET_FAILED,
+				     rte_memory_order_release);
+		goto out;
+	}
+	priv->ib_ctx = NULL;
+
+	ret = mana_pci_probe(NULL, pci_dev);
+	if (ret) {
+		DRV_LOG(ERR, "Failed to probe mana pci dev ret %d", ret);
+		rte_atomic_store_explicit(&priv->dev_state, MANA_DEV_RESET_FAILED,
+				     rte_memory_order_release);
+		goto out;
+	}
+
+	/*
+	 * Init the local MR caches.
+	 */
+	for (i = 0; i < priv->num_queues; i++) {
+		struct mana_rxq *rxq = dev->data->rx_queues[i];
+		struct mana_txq *txq = dev->data->tx_queues[i];
+
+		ret = mana_mr_btree_init(&rxq->mr_btree,
+					 MANA_MR_BTREE_PER_QUEUE_N,
+					 rxq->socket);
+		if (ret) {
+			DRV_LOG(ERR, "Failed to init RXQ %d MR btree "
+				"on socket %u, ret %d", i, rxq->socket, ret);
+			goto mr_init_failed_rxq;
+		}
+
+		ret = mana_mr_btree_init(&txq->mr_btree,
+					 MANA_MR_BTREE_PER_QUEUE_N,
+					 txq->socket);
+		if (ret) {
+			DRV_LOG(ERR, "Failed to init TXQ %d MR btree "
+				"on socket %u, ret %d", i, txq->socket, ret);
+			goto mr_init_failed_txq;
+		}
+	}
+	DRV_LOG(DEBUG, "priv %p, num_queues %u", priv, priv->num_queues);
+
+	/* Start secondaries */
+	ret = mana_mp_req_on_rxtx(dev, MANA_MP_REQ_RESET_EXIT);
+	if (ret) {
+		DRV_LOG(ERR, "Failed to start secondary processes ret = %d",
+			ret);
+		goto mr_init_failed_all;
+	}
+
+	ret = mana_dev_start(dev);
+	if (ret) {
+		DRV_LOG(ERR, "Failed to start mana dev ret %d", ret);
+		goto mr_init_failed_all;
+	}
+
+	/* Clear per-queue burst_state before marking device active so
+	 * data path CAS can succeed again.
+	 */
+	for (i = 0; i < priv->num_queues; i++) {
+		struct mana_rxq *rxq = dev->data->rx_queues[i];
+		struct mana_txq *txq = dev->data->tx_queues[i];
+
+		if (rxq)
+			rte_atomic_store_explicit(&rxq->burst_state, 0,
+						  rte_memory_order_release);
+		if (txq)
+			rte_atomic_store_explicit(&txq->burst_state, 0,
+						  rte_memory_order_release);
+	}
+
+	rte_atomic_store_explicit(&priv->dev_state, MANA_DEV_ACTIVE,
+				     rte_memory_order_release);
+
+	DRV_LOG(DEBUG, "Exiting the reset complete processing");
+	goto out;
+
+mr_init_failed_all:
+	i = priv->num_queues;
+	goto mr_init_failed_rxq;
+
+mr_init_failed_txq:
+	/* RXQ btree at index i was initialized, free it */
+	mana_mr_btree_free(&((struct mana_rxq *)
+			     dev->data->rx_queues[i])->mr_btree);
+
+mr_init_failed_rxq:
+	/* Free all fully initialized btrees for indices < i */
+	for (int j = 0; j < i; j++) {
+		struct mana_rxq *rxq = dev->data->rx_queues[j];
+		struct mana_txq *txq = dev->data->tx_queues[j];
+
+		mana_mr_btree_free(&rxq->mr_btree);
+		mana_mr_btree_free(&txq->mr_btree);
+	}
+	rte_atomic_store_explicit(&priv->dev_state, MANA_DEV_RESET_FAILED,
+				     rte_memory_order_release);
+
+out:
+	pthread_mutex_unlock(&priv->reset_ops_lock);
+
+	/* Clear before emitting callback — if the callback calls
+	 * dev_stop/dev_close, mana_join_reset_thread must be a no-op
+	 * to avoid self-join deadlock on the current thread.
+	 */
+	rte_atomic_store_explicit(&priv->reset_thread_active,
+		false, rte_memory_order_release);
+
+	if (!ret) {
+		DRV_LOG(INFO, "Sending RTE_ETH_EVENT_RECOVERY_SUCCESS for port %u",
+			priv->port_id);
+		rte_eth_dev_callback_process(dev,
+			RTE_ETH_EVENT_RECOVERY_SUCCESS, NULL);
+	} else {
+		DRV_LOG(INFO, "Sending RTE_ETH_EVENT_RECOVERY_FAILED for port %u",
+			priv->port_id);
+		rte_eth_dev_callback_process(dev,
+			RTE_ETH_EVENT_RECOVERY_FAILED, NULL);
+	}
+	return ret;
+}
+
+static void
+mana_reset_exit(struct mana_priv *priv)
+{
+	int ret;
+
+	if (!priv) {
+		DRV_LOG(ERR, "Private structure invalid");
+		return;
+	}
+	DRV_LOG(DEBUG, "Entering into device reset complete processing");
+
+	rxq_intr_disable(priv);
+
+	/* Unregister the interrupt handler. Since mana_reset_exit is always
+	 * called from mana_reset_thread (a non-interrupt thread), the
+	 * interrupt source is inactive and rte_intr_callback_unregister
+	 * succeeds directly.
+	 */
+	if (priv->intr_handle) {
+		ret = rte_intr_callback_unregister(priv->intr_handle,
+						   mana_intr_handler, priv);
+		if (ret < 0)
+			DRV_LOG(ERR, "Failed to unregister intr callback ret %d",
+				ret);
+		else
+			DRV_LOG(DEBUG, "%d intr callback(s) removed", ret);
+
+		rte_intr_instance_free(priv->intr_handle);
+		priv->intr_handle = NULL;
+	}
+
+	/* Proceed directly to reset exit delay (re-probe and restart).
+	 * No need for a separate thread - we are already on
+	 * mana_reset_thread which is a non-interrupt control thread.
+	 */
+	mana_reset_exit_delay(priv);
+}
+
+/*
+ * Interrupt handler from IB layer to notify this device is
+ * being removed or reset.
  */
 static void
 mana_intr_handler(void *arg)
 {
 	struct mana_priv *priv = arg;
 	struct ibv_context *ctx = priv->ib_ctx;
-	struct ibv_async_event event;
+	struct ibv_async_event event = { 0 };
+	struct rte_eth_dev *dev;
 
 	/* Read and ack all messages from IB device */
 	while (true) {
 		if (ibv_get_async_event(ctx, &event))
 			break;
 
-		if (event.event_type == IBV_EVENT_DEVICE_FATAL) {
-			struct rte_eth_dev *dev;
-
-			dev = &rte_eth_devices[priv->port_id];
-			if (dev->data->dev_conf.intr_conf.rmv)
+		switch (event.event_type) {
+		case IBV_EVENT_DEVICE_FATAL:
+			DRV_LOG(INFO, "IBV_EVENT_DEVICE_FATAL received, dev_state=%d",
+				(int)rte_atomic_load_explicit(&priv->dev_state,
+				rte_memory_order_acquire));
+			if (rte_atomic_load_explicit(&priv->dev_state,
+			    rte_memory_order_acquire) == MANA_DEV_ACTIVE) {
+				/* Notify upper layers (e.g. netvsc) before
+				 * acquiring the lock so they can switch data
+				 * path before mana stops queues. Emitting
+				 * outside the lock avoids deadlock if the
+				 * callback calls dev_stop/dev_close.
+				 */
+				dev = &rte_eth_devices[priv->port_id];
+				DRV_LOG(INFO,
+					"Sending RTE_ETH_EVENT_ERR_RECOVERING for port %u",
+					priv->port_id);
 				rte_eth_dev_callback_process(dev,
-					RTE_ETH_EVENT_INTR_RMV, NULL);
+					RTE_ETH_EVENT_ERR_RECOVERING,
+					NULL);
+
+				pthread_mutex_lock(&priv->reset_ops_lock);
+
+				/* Re-check after lock to avoid racing with
+				 * mana_pci_remove_event_cb which may have
+				 * set RESET_FAILED while we waited.
+				 */
+				if (rte_atomic_load_explicit(&priv->dev_state,
+				    rte_memory_order_acquire) !=
+				    MANA_DEV_ACTIVE) {
+					pthread_mutex_unlock(
+						&priv->reset_ops_lock);
+					break;
+				}
+
+				mana_reset_enter(priv);
+
+				if (rte_atomic_load_explicit(&priv->dev_state,
+				    rte_memory_order_acquire) ==
+				    MANA_DEV_RESET_FAILED) {
+					DRV_LOG(INFO,
+						"Sending RTE_ETH_EVENT_RECOVERY_FAILED for port %u",
+						priv->port_id);
+					rte_eth_dev_callback_process(dev,
+						RTE_ETH_EVENT_RECOVERY_FAILED,
+						NULL);
+				}
+			} else {
+				DRV_LOG(ERR, "Already in reset handling, dev_state=%d",
+					(int)rte_atomic_load_explicit(&priv->dev_state,
+					rte_memory_order_acquire));
+			}
+			break;
+
+		default:
+			break;
 		}
 
 		ibv_ack_async_event(&event);
@@ -1063,6 +1877,23 @@ static int
 mana_intr_uninstall(struct mana_priv *priv)
 {
 	int ret;
+	struct rte_eth_dev *dev;
+
+	if (!priv->intr_handle)
+		return 0;
+
+	/* Unregister PCI device removal event callback.
+	 * Do not retry on -EAGAIN to avoid deadlock: the callback
+	 * may be blocked waiting for reset_ops_lock which we hold.
+	 */
+	dev = &rte_eth_devices[priv->port_id];
+	if (dev->device) {
+		ret = rte_dev_event_callback_unregister(dev->device->name,
+			mana_pci_remove_event_cb, priv);
+		if (ret < 0 && ret != -ENOENT)
+			DRV_LOG(WARNING, "Failed to unregister PCI remove cb ret %d",
+				ret);
+	}
 
 	ret = rte_intr_callback_unregister(priv->intr_handle,
 					   mana_intr_handler, priv);
@@ -1072,6 +1903,7 @@ mana_intr_uninstall(struct mana_priv *priv)
 	}
 
 	rte_intr_instance_free(priv->intr_handle);
+	priv->intr_handle = NULL;
 
 	return 0;
 }
@@ -1127,6 +1959,16 @@ mana_intr_install(struct rte_eth_dev *eth_dev, struct mana_priv *priv)
 		goto free_intr;
 	}
 
+	/* Register for PCI device removal events to distinguish
+	 * PCI hot-remove from service reset. This requires the
+	 * application to call rte_dev_event_monitor_start() for
+	 * events to be delivered (e.g. testpmd --hot-plug-handling).
+	 */
+	ret = rte_dev_event_callback_register(eth_dev->device->name,
+					      mana_pci_remove_event_cb, priv);
+	if (ret)
+		DRV_LOG(WARNING, "Failed to register PCI remove event callback");
+
 	eth_dev->intr_handle = priv->intr_handle;
 	return 0;
 
@@ -1156,7 +1998,7 @@ mana_proc_priv_init(struct rte_eth_dev *dev)
 /*
  * Map the doorbell page for the secondary process through IB device handle.
  */
-static int
+int
 mana_map_doorbell_secondary(struct rte_eth_dev *eth_dev, int fd)
 {
 	struct mana_process_priv *priv = eth_dev->process_private;
@@ -1294,17 +2136,29 @@ mana_probe_port(struct ibv_device *ibdev, struct ibv_device_attr_ex *dev_attr,
 	char name[RTE_ETH_NAME_MAX_LEN];
 	int ret;
 	struct ibv_context *ctx = NULL;
+	bool is_reset = false;
+	pthread_mutexattr_t mattr;
+	pthread_condattr_t cattr;
 
 	rte_ether_format_addr(address, sizeof(address), addr);
-	DRV_LOG(INFO, "device located port %u address %s", port, address);
 
-	priv = rte_zmalloc_socket(NULL, sizeof(*priv), RTE_CACHE_LINE_SIZE,
-				  SOCKET_ID_ANY);
-	if (!priv)
-		return -ENOMEM;
+	DRV_LOG(DEBUG, "device located port %u address %s", port, address);
 
 	snprintf(name, sizeof(name), "%s_port%d", pci_dev->device.name, port);
 
+	eth_dev = rte_eth_dev_allocated(name);
+	if (eth_dev) {
+		is_reset = true;
+		priv = eth_dev->data->dev_private;
+		DRV_LOG(DEBUG, "Device reset for eth_dev %p priv %p",
+			eth_dev, priv);
+	} else {
+		priv = rte_zmalloc_socket(NULL, sizeof(*priv), RTE_CACHE_LINE_SIZE,
+					  SOCKET_ID_ANY);
+		if (!priv)
+			return -ENOMEM;
+	}
+
 	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
 		int fd;
 
@@ -1317,6 +2171,7 @@ mana_probe_port(struct ibv_device *ibdev, struct ibv_device_attr_ex *dev_attr,
 
 		eth_dev->device = &pci_dev->device;
 		eth_dev->dev_ops = &mana_dev_secondary_ops;
+
 		ret = mana_proc_priv_init(eth_dev);
 		if (ret)
 			goto failed;
@@ -1336,7 +2191,7 @@ mana_probe_port(struct ibv_device *ibdev, struct ibv_device_attr_ex *dev_attr,
 			goto failed;
 		}
 
-		/* fd is no not used after mapping doorbell */
+		/* fd is not used after mapping doorbell */
 		close(fd);
 
 		eth_dev->tx_pkt_burst = mana_tx_burst;
@@ -1355,22 +2210,6 @@ mana_probe_port(struct ibv_device *ibdev, struct ibv_device_attr_ex *dev_attr,
 		goto failed;
 	}
 
-	eth_dev = rte_eth_dev_allocate(name);
-	if (!eth_dev) {
-		ret = -ENOMEM;
-		goto failed;
-	}
-
-	eth_dev->data->mac_addrs =
-		rte_calloc("mana_mac", 1,
-			   sizeof(struct rte_ether_addr), 0);
-	if (!eth_dev->data->mac_addrs) {
-		ret = -ENOMEM;
-		goto failed;
-	}
-
-	rte_ether_addr_copy(addr, eth_dev->data->mac_addrs);
-
 	priv->ib_pd = ibv_alloc_pd(ctx);
 	if (!priv->ib_pd) {
 		DRV_LOG(ERR, "ibv_alloc_pd failed port %d", port);
@@ -1390,10 +2229,6 @@ mana_probe_port(struct ibv_device *ibdev, struct ibv_device_attr_ex *dev_attr,
 	}
 
 	priv->ib_ctx = ctx;
-	priv->port_id = eth_dev->data->port_id;
-	priv->dev_port = port;
-	eth_dev->data->dev_private = priv;
-	priv->dev_data = eth_dev->data;
 
 	priv->max_rx_queues = dev_attr->orig_attr.max_qp;
 	priv->max_tx_queues = dev_attr->orig_attr.max_qp;
@@ -1415,23 +2250,73 @@ mana_probe_port(struct ibv_device *ibdev, struct ibv_device_attr_ex *dev_attr,
 		name, priv->max_rx_queues, priv->max_rx_desc,
 		priv->max_send_sge, priv->max_mr_size);
 
-	rte_eth_copy_pci_info(eth_dev, pci_dev);
+	if (!is_reset) {
+		eth_dev = rte_eth_dev_allocate(name);
+		if (!eth_dev) {
+			ret = -ENOMEM;
+			goto failed;
+		}
 
-	/* Create async interrupt handler */
-	ret = mana_intr_install(eth_dev, priv);
-	if (ret) {
-		DRV_LOG(ERR, "Failed to install intr handler");
-		goto failed;
+		eth_dev->data->mac_addrs =
+			rte_calloc("mana_mac", 1,
+				   sizeof(struct rte_ether_addr), 0);
+		if (!eth_dev->data->mac_addrs) {
+			ret = -ENOMEM;
+			goto failed;
+		}
+
+		rte_ether_addr_copy(addr, eth_dev->data->mac_addrs);
+	} else {
+		/*
+		 * Reset path.
+		 */
+		rte_ether_format_addr(address, RTE_ETHER_ADDR_FMT_SIZE,
+				      eth_dev->data->mac_addrs);
+		DRV_LOG(DEBUG, "Found existing eth_dev %p with mac addr %s",
+			eth_dev, address);
+		DRV_LOG(DEBUG, "ib_ctx = %p", priv->ib_ctx);
+		goto out;
 	}
 
-	eth_dev->device = &pci_dev->device;
+	priv->port_id = eth_dev->data->port_id;
+	priv->dev_port = port;
+	eth_dev->data->dev_private = priv;
+	priv->dev_data = eth_dev->data;
+	rte_atomic_store_explicit(&priv->dev_state, MANA_DEV_ACTIVE,
+				     rte_memory_order_release);
+
+	rte_eth_copy_pci_info(eth_dev, pci_dev);
 
-	DRV_LOG(INFO, "device %s at port %u", name, eth_dev->data->port_id);
+	pthread_mutexattr_init(&mattr);
+	pthread_mutexattr_setpshared(&mattr, PTHREAD_PROCESS_SHARED);
+	pthread_mutex_init(&priv->reset_ops_lock, &mattr);
+	pthread_mutex_init(&priv->reset_cond_mutex, &mattr);
+	pthread_mutexattr_destroy(&mattr);
+
+	pthread_condattr_init(&cattr);
+	pthread_condattr_setpshared(&cattr, PTHREAD_PROCESS_SHARED);
+	pthread_cond_init(&priv->reset_cond, &cattr);
+	pthread_condattr_destroy(&cattr);
+
+	eth_dev->device = &pci_dev->device;
 
 	eth_dev->rx_pkt_burst = mana_rx_burst_removed;
 	eth_dev->tx_pkt_burst = mana_tx_burst_removed;
 	eth_dev->dev_ops = &mana_dev_ops;
 
+out:
+	/* Create async interrupt handler */
+	ret = mana_intr_install(eth_dev, priv);
+	if (ret) {
+		DRV_LOG(ERR, "Failed to install intr handler, ret %d", ret);
+		goto failed;
+	} else {
+		DRV_LOG(INFO, "mana_intr_install succeeded");
+	}
+
+	DRV_LOG(INFO, "device %s priv %p dev port %d at port %u",
+		name, priv, priv->dev_port, eth_dev->data->port_id);
+
 	rte_eth_dev_probing_finish(eth_dev);
 
 	return 0;
@@ -1439,20 +2324,29 @@ mana_probe_port(struct ibv_device *ibdev, struct ibv_device_attr_ex *dev_attr,
 failed:
 	/* Free the resource for the port failed */
 	if (priv) {
-		if (priv->ib_parent_pd)
+		if (priv->ib_parent_pd) {
 			ibv_dealloc_pd(priv->ib_parent_pd);
+			priv->ib_parent_pd = NULL;
+		}
 
-		if (priv->ib_pd)
+		if (priv->ib_pd) {
 			ibv_dealloc_pd(priv->ib_pd);
+			priv->ib_pd = NULL;
+		}
 	}
 
-	if (eth_dev)
-		rte_eth_dev_release_port(eth_dev);
+	if (!is_reset) {
+		if (eth_dev)
+			rte_eth_dev_release_port(eth_dev);
 
-	rte_free(priv);
+		rte_free(priv);
+	}
 
-	if (ctx)
+	if (ctx) {
 		ibv_close_device(ctx);
+		if (is_reset && priv)
+			priv->ib_ctx = NULL;
+	}
 
 	return ret;
 }
@@ -1617,7 +2511,17 @@ mana_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 static int
 mana_dev_uninit(struct rte_eth_dev *dev)
 {
-	return mana_dev_close(dev);
+	struct mana_priv *priv = dev->data->dev_private;
+	int ret;
+
+	/* Join reset thread before teardown to ensure it has exited
+	 * before we destroy the condvar/mutex in free_resources.
+	 */
+	mana_join_reset_thread(priv);
+
+	ret = mana_dev_close(dev);
+	mana_dev_free_resources(dev);
+	return ret;
 }
 
 /*
diff --git a/drivers/net/mana/mana.h b/drivers/net/mana/mana.h
index 79cc47b6ab..a7b301484a 100644
--- a/drivers/net/mana/mana.h
+++ b/drivers/net/mana/mana.h
@@ -5,6 +5,8 @@
 #ifndef __MANA_H__
 #define __MANA_H__
 
+#include <pthread.h>
+
 #define	PCI_VENDOR_ID_MICROSOFT		0x1414
 #define PCI_DEVICE_ID_MICROSOFT_MANA_PF	0x00b9
 #define PCI_DEVICE_ID_MICROSOFT_MANA	0x00ba
@@ -337,6 +339,26 @@ struct mana_process_priv {
 	void *db_page;
 };
 
+enum mana_device_state {
+	/* Normal running */
+	MANA_DEV_ACTIVE		= 0,
+	/* In reset enter processing */
+	MANA_DEV_RESET_ENTER	= 1,
+	/*
+	 * Reset enter processing completed.
+	 * Waiting for reset exit or in reset exit processing.
+	 */
+	MANA_DEV_RESET_EXIT	= 2,
+	/* Reset failed */
+	MANA_DEV_RESET_FAILED	= 3,
+};
+
+/* burst_state bit layout:
+ *   Bit 0: in-burst (set by data path CAS 0→1, cleared on exit).
+ *   Bit 1: blocked  (set by reset path to reject new bursts).
+ */
+#define MANA_BURST_BLOCKED	2
+
 struct mana_priv {
 	struct rte_eth_dev_data *dev_data;
 	struct mana_process_priv *process_priv;
@@ -368,6 +390,15 @@ struct mana_priv {
 	uint64_t max_mr_size;
 	struct mana_mr_btree mr_btree;
 	rte_spinlock_t	mr_btree_lock;
+	RTE_ATOMIC(enum mana_device_state) dev_state;
+	/* mutex for synchronizing mana reset and some mana_dev_ops callbacks */
+	pthread_mutex_t reset_ops_lock;
+	/* Reset thread ID, valid when reset_thread_active is true */
+	rte_thread_t reset_thread;
+	RTE_ATOMIC(bool) reset_thread_active;
+	/* Condvar to wake reset thread early on PCI remove */
+	pthread_mutex_t reset_cond_mutex;
+	pthread_cond_t reset_cond;
 };
 
 struct mana_txq_desc {
@@ -427,6 +458,14 @@ struct mana_txq {
 	struct mana_mr_btree mr_btree;
 	struct mana_stats stats;
 	unsigned int socket;
+	unsigned int txq_idx;
+
+	/*
+	 * Bit 0: in-burst flag (set by data path, cleared on exit).
+	 * Bit 1: blocked flag (set by reset path via fetch_or).
+	 * Data path CAS 0→1 to enter; fails if blocked bit is set.
+	 */
+	RTE_ATOMIC(uint32_t) burst_state;
 };
 
 struct mana_rxq {
@@ -462,6 +501,14 @@ struct mana_rxq {
 	struct mana_mr_btree mr_btree;
 
 	unsigned int socket;
+	unsigned int rxq_idx;
+
+	/*
+	 * Bit 0: in-burst flag (set by data path, cleared on exit).
+	 * Bit 1: blocked flag (set by reset path via fetch_or).
+	 * Data path CAS 0→1 to enter; fails if blocked bit is set.
+	 */
+	RTE_ATOMIC(uint32_t) burst_state;
 };
 
 extern int mana_logtype_driver;
@@ -543,6 +590,8 @@ enum mana_mp_req_type {
 	MANA_MP_REQ_CREATE_MR,
 	MANA_MP_REQ_START_RXTX,
 	MANA_MP_REQ_STOP_RXTX,
+	MANA_MP_REQ_RESET_ENTER,
+	MANA_MP_REQ_RESET_EXIT,
 };
 
 /* Pameters for IPC. */
@@ -563,8 +612,9 @@ void mana_mp_uninit_primary(void);
 void mana_mp_uninit_secondary(void);
 int mana_mp_req_verbs_cmd_fd(struct rte_eth_dev *dev);
 int mana_mp_req_mr_create(struct mana_priv *priv, uintptr_t addr, uint32_t len);
+int mana_map_doorbell_secondary(struct rte_eth_dev *eth_dev, int fd);
 
-void mana_mp_req_on_rxtx(struct rte_eth_dev *dev, enum mana_mp_req_type type);
+int mana_mp_req_on_rxtx(struct rte_eth_dev *dev, enum mana_mp_req_type type);
 
 void *mana_alloc_verbs_buf(size_t size, void *data);
 void mana_free_verbs_buf(void *ptr, void *data __rte_unused);
diff --git a/drivers/net/mana/mp.c b/drivers/net/mana/mp.c
index 72417fc0c7..1161ebd71c 100644
--- a/drivers/net/mana/mp.c
+++ b/drivers/net/mana/mp.c
@@ -2,10 +2,13 @@
  * Copyright 2022 Microsoft Corporation
  */
 
+#include <sys/mman.h>
 #include <rte_malloc.h>
 #include <ethdev_driver.h>
 #include <rte_log.h>
+#include <rte_eal_paging.h>
 #include <stdlib.h>
+#include <unistd.h>
 
 #include <infiniband/verbs.h>
 
@@ -119,6 +122,23 @@ mana_mp_primary_handle(const struct rte_mp_msg *mp_msg, const void *peer)
 	return ret;
 }
 
+static int
+mana_mp_reset_enter(struct rte_eth_dev *dev)
+{
+	struct mana_process_priv *proc_priv = dev->process_private;
+
+	void *addr = proc_priv->db_page;
+
+	/* Reset the db_page to NULL */
+	proc_priv->db_page = NULL;
+
+	if (addr)
+		(void)munmap(addr, rte_mem_page_size());
+
+	DRV_LOG(DEBUG, "Secondary doorbell pages unmapped");
+	return 0;
+}
+
 static int
 mana_mp_secondary_handle(const struct rte_mp_msg *mp_msg, const void *peer)
 {
@@ -171,6 +191,49 @@ mana_mp_secondary_handle(const struct rte_mp_msg *mp_msg, const void *peer)
 		ret = rte_mp_reply(&mp_res, peer);
 		break;
 
+	case MANA_MP_REQ_RESET_ENTER:
+		DRV_LOG(INFO, "Port %u reset enter", dev->data->port_id);
+		res->result = mana_mp_reset_enter(dev);
+
+		ret = rte_mp_reply(&mp_res, peer);
+		break;
+
+	case MANA_MP_REQ_RESET_EXIT:
+		DRV_LOG(INFO, "Port %u reset exit", dev->data->port_id);
+		{
+			struct mana_process_priv *proc_priv =
+				dev->process_private;
+
+			if (proc_priv->db_page != NULL) {
+				DRV_LOG(DEBUG,
+					"Secondary doorbell already "
+					"mapped to %p",
+					proc_priv->db_page);
+				res->result = 0;
+			} else if (mp_msg->num_fds < 1) {
+				DRV_LOG(ERR,
+					"No FD in RESET_EXIT message");
+				res->result = -EINVAL;
+			} else {
+				int fd = mp_msg->fds[0];
+
+				ret = mana_map_doorbell_secondary(dev,
+								  fd);
+				if (ret) {
+					DRV_LOG(ERR,
+						"Failed secondary "
+						"doorbell map %d",
+						fd);
+					res->result = -ENODEV;
+				} else {
+					res->result = 0;
+				}
+				close(fd);
+			}
+		}
+		ret = rte_mp_reply(&mp_res, peer);
+		break;
+
 	default:
 		DRV_LOG(ERR, "Port %u unknown secondary MP type %u",
 			param->port_id, param->type);
@@ -254,7 +317,7 @@ mana_mp_req_verbs_cmd_fd(struct rte_eth_dev *dev)
 	}
 
 	ret = mp_res->fds[0];
-	DRV_LOG(ERR, "port %u command FD from primary is %d",
+	DRV_LOG(DEBUG, "port %u command FD from primary is %d",
 		dev->data->port_id, ret);
 exit:
 	free(mp_rep.msgs);
@@ -298,27 +361,36 @@ mana_mp_req_mr_create(struct mana_priv *priv, uintptr_t addr, uint32_t len)
 	return ret;
 }
 
-void
+int
 mana_mp_req_on_rxtx(struct rte_eth_dev *dev, enum mana_mp_req_type type)
 {
 	struct rte_mp_msg mp_req = { 0 };
 	struct rte_mp_msg *mp_res;
-	struct rte_mp_reply mp_rep;
+	struct rte_mp_reply mp_rep = { 0 };
 	struct mana_mp_param *res;
 	struct timespec ts = {.tv_sec = MANA_MP_REQ_TIMEOUT_SEC, .tv_nsec = 0};
-	int i, ret;
+	int i, ret = 0;
 
-	if (type != MANA_MP_REQ_START_RXTX && type != MANA_MP_REQ_STOP_RXTX) {
+	if (type != MANA_MP_REQ_START_RXTX && type != MANA_MP_REQ_STOP_RXTX &&
+	    type != MANA_MP_REQ_RESET_ENTER && type != MANA_MP_REQ_RESET_EXIT) {
 		DRV_LOG(ERR, "port %u unknown request (req_type %d)",
 			dev->data->port_id, type);
-		return;
+		return -EINVAL;
 	}
 
 	if (rte_atomic_load_explicit(&mana_shared_data->secondary_cnt, rte_memory_order_relaxed) == 0)
-		return;
+		return 0;
 
 	mp_init_msg(&mp_req, type, dev->data->port_id);
 
+	/* Include IB cmd FD for secondary doorbell remap */
+	if (type == MANA_MP_REQ_RESET_EXIT) {
+		struct mana_priv *priv = dev->data->dev_private;
+
+		mp_req.num_fds = 1;
+		mp_req.fds[0] = priv->ib_ctx->cmd_fd;
+	}
+
 	ret = rte_mp_request_sync(&mp_req, &mp_rep, &ts);
 	if (ret) {
 		if (rte_errno != ENOTSUP)
@@ -329,6 +401,7 @@ mana_mp_req_on_rxtx(struct rte_eth_dev *dev, enum mana_mp_req_type type)
 	if (mp_rep.nb_sent != mp_rep.nb_received) {
 		DRV_LOG(ERR, "port %u not all secondaries responded (%d)",
 			dev->data->port_id, type);
+		ret = -ETIMEDOUT;
 		goto exit;
 	}
 	for (i = 0; i < mp_rep.nb_received; i++) {
@@ -337,9 +410,11 @@ mana_mp_req_on_rxtx(struct rte_eth_dev *dev, enum mana_mp_req_type type)
 		if (res->result) {
 			DRV_LOG(ERR, "port %u request failed on secondary %d",
 				dev->data->port_id, i);
+			ret = res->result;
 			goto exit;
 		}
 	}
 exit:
 	free(mp_rep.msgs);
+	return ret;
 }
diff --git a/drivers/net/mana/mr.c b/drivers/net/mana/mr.c
index c4045141bc..8914f4cf04 100644
--- a/drivers/net/mana/mr.c
+++ b/drivers/net/mana/mr.c
@@ -314,8 +314,10 @@ mana_mr_btree_init(struct mana_mr_btree *bt, int n, int socket)
 void
 mana_mr_btree_free(struct mana_mr_btree *bt)
 {
-	rte_free(bt->table);
-	memset(bt, 0, sizeof(*bt));
+	if (bt && bt->table) {
+		rte_free(bt->table);
+		memset(bt, 0, sizeof(*bt));
+	}
 }
 
 int
diff --git a/drivers/net/mana/rx.c b/drivers/net/mana/rx.c
index 1b8ba1f3a9..aedb05d46f 100644
--- a/drivers/net/mana/rx.c
+++ b/drivers/net/mana/rx.c
@@ -36,6 +36,11 @@ mana_rq_ring_doorbell(struct mana_rxq *rxq)
 		db_page = process_priv->db_page;
 	}
 
+	if (!db_page) {
+		DP_LOG(ERR, "db_page is NULL, cannot ring RX doorbell");
+		return -EINVAL;
+	}
+
 	/* Hardware Spec specifies that software client should set 0 for
 	 * wqe_cnt for Receive Queues.
 	 */
@@ -172,7 +177,7 @@ mana_stop_rx_queues(struct rte_eth_dev *dev)
 
 	for (i = 0; i < priv->num_queues; i++)
 		if (dev->data->rx_queue_state[i] == RTE_ETH_QUEUE_STATE_STOPPED)
-			return -EINVAL;
+			return 0;
 
 	if (priv->rwq_qp) {
 		ret = ibv_destroy_qp(priv->rwq_qp);
@@ -256,6 +261,9 @@ mana_start_rx_queues(struct rte_eth_dev *dev)
 		struct mana_rxq *rxq = dev->data->rx_queues[i];
 		struct ibv_wq_init_attr wq_attr = {};
 
+		rxq->rxq_idx = i;
+		DRV_LOG(DEBUG, "assigning rxq_idx to %d", i);
+
 		manadv_set_context_attr(priv->ib_ctx,
 			MANADV_CTX_ATTR_BUF_ALLOCATORS,
 			(void *)((uintptr_t)&(struct manadv_ctx_allocators){
@@ -451,6 +459,16 @@ mana_rx_burst(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
 	uint32_t pkt_len;
 	uint32_t i;
 	int polled = 0;
+	uint32_t expected = 0;
+
+	/* Single atomic CAS: enter burst only if device is active (0→1).
+	 * Fails immediately if reset path has set the blocked bit.
+	 */
+	if (unlikely(!rte_atomic_compare_exchange_strong_explicit(
+			&rxq->burst_state, &expected, 1,
+			rte_memory_order_acquire,
+			rte_memory_order_relaxed)))
+		return 0;
 
 repoll:
 	/* Polling on new completions if we have no backlog */
@@ -592,6 +610,9 @@ mana_rx_burst(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
 				wqe_consumed, ret);
 	}
 
+	rte_atomic_fetch_and_explicit(&rxq->burst_state, ~(uint32_t)1,
+				     rte_memory_order_release);
+
 	return pkt_received;
 }
 
diff --git a/drivers/net/mana/tx.c b/drivers/net/mana/tx.c
index 57dbbc3651..10f2212b5d 100644
--- a/drivers/net/mana/tx.c
+++ b/drivers/net/mana/tx.c
@@ -17,7 +17,7 @@ mana_stop_tx_queues(struct rte_eth_dev *dev)
 
 	for (i = 0; i < priv->num_queues; i++)
 		if (dev->data->tx_queue_state[i] == RTE_ETH_QUEUE_STATE_STOPPED)
-			return -EINVAL;
+			return 0;
 
 	for (i = 0; i < priv->num_queues; i++) {
 		struct mana_txq *txq = dev->data->tx_queues[i];
@@ -83,6 +83,9 @@ mana_start_tx_queues(struct rte_eth_dev *dev)
 
 		txq = dev->data->tx_queues[i];
 
+		txq->txq_idx = i;
+		DRV_LOG(DEBUG, "assigning txq_idx to %d", txq->txq_idx);
+
 		manadv_set_context_attr(priv->ib_ctx,
 			MANADV_CTX_ATTR_BUF_ALLOCATORS,
 			(void *)((uintptr_t)&(struct manadv_ctx_allocators){
@@ -190,10 +193,34 @@ mana_tx_burst(void *dpdk_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	void *db_page;
 	uint16_t pkt_sent = 0;
 	uint32_t num_comp, i;
+	uint32_t expected = 0;
 #ifdef RTE_ARCH_32
 	uint32_t wqe_count = 0;
 #endif
 
+	db_page = priv->db_page;
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
+		struct rte_eth_dev *dev =
+			&rte_eth_devices[priv->dev_data->port_id];
+		struct mana_process_priv *process_priv = dev->process_private;
+
+		db_page = process_priv->db_page;
+	}
+
+	/* Single atomic CAS: enter burst only if device is active (0→1).
+	 * Fails immediately if reset path has set the blocked bit.
+	 */
+	if (unlikely(!rte_atomic_compare_exchange_strong_explicit(
+			&txq->burst_state, &expected, 1,
+			rte_memory_order_acquire,
+			rte_memory_order_relaxed) || !db_page)) {
+		if (!expected) /* CAS succeeded but db_page NULL — undo */
+			rte_atomic_fetch_and_explicit(&txq->burst_state,
+						      ~(uint32_t)1,
+						      rte_memory_order_release);
+		return 0;
+	}
+
 	/* Process send completions from GDMA */
 	num_comp = gdma_poll_completion_queue(&txq->gdma_cq,
 			txq->gdma_comp_buf, txq->num_desc);
@@ -216,7 +243,8 @@ mana_tx_burst(void *dpdk_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		}
 
 		if (!desc->pkt) {
-			DP_LOG(ERR, "mana_txq_desc has a NULL pkt");
+			DP_LOG(ERR, "mana_txq_desc has a NULL pkt, priv %p, "
+			       "txq = %d", priv, txq->txq_idx);
 		} else {
 			txq->stats.bytes += desc->pkt->pkt_len;
 			rte_pktmbuf_free(desc->pkt);
@@ -474,15 +502,6 @@ mana_tx_burst(void *dpdk_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	}
 
 	/* Ring hardware door bell */
-	db_page = priv->db_page;
-	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
-		struct rte_eth_dev *dev =
-			&rte_eth_devices[priv->dev_data->port_id];
-		struct mana_process_priv *process_priv = dev->process_private;
-
-		db_page = process_priv->db_page;
-	}
-
 	if (pkt_sent) {
 #ifdef RTE_ARCH_32
 		ret = mana_ring_short_doorbell(db_page, GDMA_QUEUE_SEND,
@@ -501,5 +520,8 @@ mana_tx_burst(void *dpdk_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 			DP_LOG(ERR, "mana_ring_doorbell failed ret %d", ret);
 	}
 
+	rte_atomic_fetch_and_explicit(&txq->burst_state, ~(uint32_t)1,
+				     rte_memory_order_release);
+
 	return pkt_sent;
 }
-- 
2.34.1

