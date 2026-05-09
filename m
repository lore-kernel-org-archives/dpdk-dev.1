Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4730CD343F
	for <dpdk-dev@archiver.kernel.org>; Sat,  9 May 2026 06:01:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AB80402E8;
	Sat,  9 May 2026 08:01:41 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 53B0D402E8
 for <dev@dpdk.org>; Sat,  9 May 2026 08:01:38 +0200 (CEST)
Received: from alhe-weh-mana-dpdk-s2.corp.microsoft.com (unknown
 [131.107.1.160])
 by linux.microsoft.com (Postfix) with ESMTPSA id 58E7620B7167;
 Fri,  8 May 2026 23:01:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 58E7620B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1778306495;
 bh=AJIEB5F93lYWD6+hL/WaA+kGRTYrWAk0E9hRUQiL1Ik=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ql7JGrItQi5/jyxo/KKUJ6MYkBmq4TwFHW/DezYnNNlUjT9mMOH8lRXgGJRWIuHt0
 Hfmy953AtV6y70/pTLEHQHaXZbf70G4thGSV5vjU73N8XnSY+Ia41Nz8KMQYfU8S6U
 OaLs8vmUd1zCXKYqb/I+kAT6ok4ElntPnddhprHE=
From: Wei Hu <weh@linux.microsoft.com>
To: dev@dpdk.org,
	stephen@networkplumber.org
Cc: longli@microsoft.com,
	weh@microsoft.com
Subject: [PATCH v2 1/1] net/mana: add device reset support
Date: Fri,  8 May 2026 23:01:13 -0700
Message-Id: <20260509060113.61686-2-weh@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260509060113.61686-1-weh@linux.microsoft.com>
References: <20260509060113.61686-1-weh@linux.microsoft.com>
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

The reset flow has two phases. In the enter phase, running on the
EAL interrupt thread, the driver transitions the device state,
waits for data path threads to reach a quiescent state using RCU,
stops queues, tears down IB resources, and frees per-queue MR
caches. A control thread is then spawned to handle the exit phase:
it waits for the hardware to recover, unregisters the interrupt
handler, re-probes the PCI device, reinitializes MR caches, and
restarts queues.

A per-device spinlock serializes the reset path with ethdev
operations. Operations that cannot wait (configure, queue setup)
return -EBUSY during reset, while dev_stop and dev_close join the
reset thread and use a blocking lock to ensure proper sequencing.

Multi-process support is included: secondary processes unmap and
remap doorbell pages via IPC during the reset enter and exit
phases. Data path functions in both primary and secondary
processes check the device state atomically and return early when
the device is not active.

The driver uses ethdev recovery events to notify upper layers
(e.g. netvsc) of the reset lifecycle: RTE_ETH_EVENT_ERR_RECOVERING
on entry, RTE_ETH_EVENT_RECOVERY_SUCCESS or
RTE_ETH_EVENT_RECOVERY_FAILED on completion. A PCI device removal
event callback distinguishes hot-remove from service reset.

Signed-off-by: Wei Hu <weh@microsoft.com>
---
 drivers/net/mana/mana.c      | 928 +++++++++++++++++++++++++++++++----
 drivers/net/mana/mana.h      |  33 +-
 drivers/net/mana/meson.build |   2 +-
 drivers/net/mana/mp.c        |  89 +++-
 drivers/net/mana/mr.c        |   6 +-
 drivers/net/mana/rx.c        |  24 +-
 drivers/net/mana/tx.c        |  40 +-
 7 files changed, 1016 insertions(+), 106 deletions(-)

diff --git a/drivers/net/mana/mana.c b/drivers/net/mana/mana.c
index 67396cda1f..87ab6f15b1 100644
--- a/drivers/net/mana/mana.c
+++ b/drivers/net/mana/mana.c
@@ -13,7 +13,10 @@
 #include <ethdev_pci.h>
 #include <rte_kvargs.h>
 #include <rte_eal_paging.h>
+#include <rte_alarm.h>
 #include <rte_pci.h>
+#include <rte_rcu_qsbr.h>
+#include <rte_lock_annotations.h>
 
 #include <infiniband/verbs.h>
 #include <infiniband/manadv.h>
@@ -103,6 +106,23 @@ mana_dev_configure(struct rte_eth_dev *dev)
 			      RTE_ETH_RX_OFFLOAD_VLAN_STRIP);
 
 	priv->num_queues = dev->data->nb_rx_queues;
+	DRV_LOG(DEBUG, "priv %p, port %u, dev port %u, num_queues: %u",
+		priv, priv->port_id, priv->dev_port, priv->num_queues);
+
+	/*
+	 * Register data path thread IDs (rx and tx) with the RCU
+	 * quiescent state variable for device state synchronization.
+	 */
+	for (int i = 0; i < 2 * priv->num_queues; i++) {
+		if (rte_rcu_qsbr_thread_register(priv->dev_state_qsv, i) != 0) {
+			DRV_LOG(ERR, "Failed to register rcu qsv thread %d of total %d",
+				i, 2 * priv->num_queues - 1);
+			return -EINVAL;
+		}
+		DRV_LOG(DEBUG,
+			"Register thread 0x%x for priv %p, port %u",
+			i, priv, priv->port_id);
+	}
 
 	manadv_set_context_attr(priv->ib_ctx, MANADV_CTX_ATTR_BUF_ALLOCATORS,
 				(void *)((uintptr_t)&(struct manadv_ctx_allocators){
@@ -214,8 +234,8 @@ mana_dev_start(struct rte_eth_dev *dev)
 
 	DRV_LOG(INFO, "TX/RX queues have started");
 
-	/* Enable datapath for secondary processes */
-	mana_mp_req_on_rxtx(dev, MANA_MP_REQ_START_RXTX);
+	/* Intentionally ignore errors — secondary may not be running */
+	(void)mana_mp_req_on_rxtx(dev, MANA_MP_REQ_START_RXTX);
 
 	ret = rxq_intr_enable(priv);
 	if (ret) {
@@ -242,26 +262,33 @@ mana_dev_stop(struct rte_eth_dev *dev)
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
 
@@ -275,31 +302,58 @@ mana_dev_close(struct rte_eth_dev *dev)
 {
 	struct mana_priv *priv = dev->data->dev_private;
 	int ret;
+	enum mana_device_state state;
+
+	/* Wait for reset thread to finish before freeing resources */
+	if (priv->reset_thread_active) {
+		pthread_mutex_lock(&priv->reset_cond_mutex);
+		rte_atomic_store_explicit(&priv->dev_state,
+			MANA_DEV_ACTIVE, rte_memory_order_release);
+		pthread_cond_signal(&priv->reset_cond);
+		pthread_mutex_unlock(&priv->reset_cond_mutex);
+		rte_thread_join(priv->reset_thread, NULL);
+		priv->reset_thread_active = false;
+	}
 
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
@@ -391,6 +445,27 @@ mana_dev_info_get(struct rte_eth_dev *dev,
 	return 0;
 }
 
+static int
+mana_dev_info_get_lock(struct rte_eth_dev *dev,
+		       struct rte_eth_dev_info *dev_info)
+{
+	struct mana_priv *priv = dev->data->dev_private;
+	int ret;
+
+	if (rte_spinlock_trylock(&priv->reset_ops_lock)) {
+		if (rte_atomic_load_explicit(&priv->dev_state,
+		    rte_memory_order_acquire) != MANA_DEV_ACTIVE) {
+			rte_spinlock_unlock(&priv->reset_ops_lock);
+			return -EBUSY;
+		}
+		ret = mana_dev_info_get(dev, dev_info);
+		rte_spinlock_unlock(&priv->reset_ops_lock);
+	} else {
+		ret = -EBUSY;
+	}
+	return ret;
+}
+
 static void
 mana_dev_tx_queue_info(struct rte_eth_dev *dev, uint16_t queue_id,
 		       struct rte_eth_txq_info *qinfo)
@@ -552,6 +627,29 @@ mana_dev_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
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
+	if (rte_spinlock_trylock(&priv->reset_ops_lock)) {
+		if (rte_atomic_load_explicit(&priv->dev_state,
+		    rte_memory_order_acquire) != MANA_DEV_ACTIVE) {
+			rte_spinlock_unlock(&priv->reset_ops_lock);
+			return -EBUSY;
+		}
+		ret = mana_dev_tx_queue_setup(dev, queue_idx,
+					      nb_desc, socket_id, tx_conf);
+		rte_spinlock_unlock(&priv->reset_ops_lock);
+	} else {
+		ret = -EBUSY;
+	}
+	return ret;
+}
+
 static void
 mana_dev_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
 {
@@ -629,6 +727,30 @@ mana_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
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
+	if (rte_spinlock_trylock(&priv->reset_ops_lock)) {
+		if (rte_atomic_load_explicit(&priv->dev_state,
+		    rte_memory_order_acquire) != MANA_DEV_ACTIVE) {
+			rte_spinlock_unlock(&priv->reset_ops_lock);
+			return -EBUSY;
+		}
+		ret = mana_dev_rx_queue_setup(dev, queue_idx, nb_desc,
+					      socket_id, rx_conf, mp);
+		rte_spinlock_unlock(&priv->reset_ops_lock);
+	} else {
+		ret = -EBUSY;
+	}
+	return ret;
+}
+
 static void
 mana_dev_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
 {
@@ -820,33 +942,217 @@ mana_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
 	return mana_ifreq(priv, SIOCSIFMTU, &request);
 }
 
+#define MANA_OPS_1_LOCK(_func)						\
+static int								\
+_func##_lock(struct rte_eth_dev *dev)					\
+{									\
+	struct mana_priv *priv = dev->data->dev_private;		\
+	int ret;							\
+	if (rte_spinlock_trylock(&priv->reset_ops_lock)) {		\
+		if (rte_atomic_load_explicit(&priv->dev_state,		\
+		    rte_memory_order_acquire) !=			\
+		    MANA_DEV_ACTIVE) {					\
+			rte_spinlock_unlock(&priv->reset_ops_lock);	\
+			return -EBUSY;					\
+		}							\
+		ret = _func(dev);					\
+		rte_spinlock_unlock(&priv->reset_ops_lock);		\
+	} else {							\
+		ret = -EBUSY;						\
+	}								\
+	return ret;							\
+}
+
+MANA_OPS_1_LOCK(mana_dev_configure)
+
+MANA_OPS_1_LOCK(mana_dev_start)
+
+#undef MANA_OPS_1_LOCK
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
+	/* Signal reset thread to stop by setting state, then wait for it.
+	 * Must be done before acquiring the lock to avoid deadlock
+	 * (reset thread also acquires the lock).
+	 */
+	if (priv->reset_thread_active) {
+		pthread_mutex_lock(&priv->reset_cond_mutex);
+		rte_atomic_store_explicit(&priv->dev_state,
+			MANA_DEV_ACTIVE, rte_memory_order_release);
+		pthread_cond_signal(&priv->reset_cond);
+		pthread_mutex_unlock(&priv->reset_cond_mutex);
+		rte_thread_join(priv->reset_thread, NULL);
+		priv->reset_thread_active = false;
+	}
+
+	rte_spinlock_lock(&priv->reset_ops_lock);
+
+	if (rte_atomic_load_explicit(&priv->dev_state,
+	    rte_memory_order_acquire) != MANA_DEV_ACTIVE) {
+		rte_atomic_store_explicit(&priv->dev_state,
+			MANA_DEV_ACTIVE, rte_memory_order_release);
+		rte_spinlock_unlock(&priv->reset_ops_lock);
+		return 0;
+	}
+
+	ret = mana_dev_stop(dev);
+	rte_spinlock_unlock(&priv->reset_ops_lock);
+	return ret;
+}
+
+static int
+mana_dev_close_lock(struct rte_eth_dev *dev)
+{
+	struct mana_priv *priv = dev->data->dev_private;
+	int ret;
+
+	/* Signal reset thread to stop by setting state, then wait for it.
+	 * Must be done before acquiring the lock to avoid deadlock
+	 * (reset thread also acquires the lock).
+	 */
+	if (priv->reset_thread_active) {
+		pthread_mutex_lock(&priv->reset_cond_mutex);
+		rte_atomic_store_explicit(&priv->dev_state,
+			MANA_DEV_ACTIVE, rte_memory_order_release);
+		pthread_cond_signal(&priv->reset_cond);
+		pthread_mutex_unlock(&priv->reset_cond_mutex);
+		rte_thread_join(priv->reset_thread, NULL);
+		priv->reset_thread_active = false;
+	}
+
+	rte_spinlock_lock(&priv->reset_ops_lock);
+
+	if (rte_atomic_load_explicit(&priv->dev_state,
+	    rte_memory_order_acquire) != MANA_DEV_ACTIVE) {
+		rte_atomic_store_explicit(&priv->dev_state,
+			MANA_DEV_ACTIVE, rte_memory_order_release);
+	}
+
+	ret = mana_dev_close(dev);
+	rte_spinlock_unlock(&priv->reset_ops_lock);
+	return ret;
+}
+
+#define MANA_OPS_2_LOCK(_func)						\
+static int								\
+_func##_lock(struct rte_eth_dev *dev,					\
+	       struct rte_eth_rss_conf *rss_conf)			\
+{									\
+	struct mana_priv *priv = dev->data->dev_private;		\
+	int ret;							\
+	if (rte_spinlock_trylock(&priv->reset_ops_lock)) {		\
+		if (rte_atomic_load_explicit(&priv->dev_state,		\
+		    rte_memory_order_acquire) !=			\
+		    MANA_DEV_ACTIVE) {					\
+			rte_spinlock_unlock(&priv->reset_ops_lock);	\
+			return -EBUSY;					\
+		}							\
+		ret = _func(dev, rss_conf);				\
+		rte_spinlock_unlock(&priv->reset_ops_lock);		\
+	} else {							\
+		ret = -EBUSY;						\
+	}								\
+	return ret;							\
+}
+
+MANA_OPS_2_LOCK(mana_rss_hash_update)
+
+MANA_OPS_2_LOCK(mana_rss_hash_conf_get)
+#undef MANA_OPS_2_LOCK
+
+#define MANA_OPS_3_LOCK(_func, _arg)					\
+static void								\
+_func##_lock(struct rte_eth_dev *dev, uint16_t _arg)			\
+{									\
+	struct mana_priv *priv = dev->data->dev_private;		\
+	if (rte_spinlock_trylock(&priv->reset_ops_lock)) {		\
+		if (rte_atomic_load_explicit(&priv->dev_state,		\
+		    rte_memory_order_acquire) !=			\
+		    MANA_DEV_ACTIVE) {					\
+			rte_spinlock_unlock(&priv->reset_ops_lock);	\
+			DRV_LOG(ERR, "Device reset in progress, "	\
+				"%s not called", #_func);		\
+			return;						\
+		}							\
+		_func(dev, _arg);					\
+		rte_spinlock_unlock(&priv->reset_ops_lock);		\
+	} else {							\
+		DRV_LOG(ERR, "Device reset in progress, "		\
+			"%s not called", #_func);			\
+	}								\
+}
+
+MANA_OPS_3_LOCK(mana_dev_tx_queue_release, qid)
+
+MANA_OPS_3_LOCK(mana_dev_rx_queue_release, qid)
+#undef MANA_OPS_3_LOCK
+
+#define MANA_OPS_4_LOCK(_func, _arg)					\
+static int								\
+_func##_lock(struct rte_eth_dev *dev, uint16_t _arg)			\
+{									\
+	struct mana_priv *priv = dev->data->dev_private;		\
+	int ret;							\
+	if (rte_spinlock_trylock(&priv->reset_ops_lock)) {		\
+		if (rte_atomic_load_explicit(&priv->dev_state,		\
+		    rte_memory_order_acquire) !=			\
+		    MANA_DEV_ACTIVE) {					\
+			rte_spinlock_unlock(&priv->reset_ops_lock);	\
+			return -EBUSY;					\
+		}							\
+		ret = _func(dev, _arg);					\
+		rte_spinlock_unlock(&priv->reset_ops_lock);		\
+	} else {							\
+		ret = -EBUSY;						\
+	}								\
+	return ret;							\
+}
+
+MANA_OPS_4_LOCK(mana_rx_intr_enable, rx_queue_id)
+
+MANA_OPS_4_LOCK(mana_rx_intr_disable, rx_queue_id)
+
+MANA_OPS_4_LOCK(mana_mtu_set, mtu)
+#undef MANA_OPS_4_LOCK
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
@@ -1031,28 +1337,398 @@ mana_ibv_device_to_pci_addr(const struct ibv_device *device,
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
+	__rte_no_thread_safety_analysis
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
+	rte_spinlock_lock(&priv->reset_ops_lock);
+
+	dev = &rte_eth_devices[priv->port_id];
+	DRV_LOG(INFO, "Sending RTE_ETH_EVENT_INTR_RMV for port %u",
+		priv->port_id);
+	rte_eth_dev_callback_process(dev,
+		RTE_ETH_EVENT_INTR_RMV, NULL);
+
+	rte_spinlock_unlock(&priv->reset_ops_lock);
+}
+
+/*
+ * Reset thread: sleeps for the reset timer period, then performs
+ * the reset exit sequence. Runs on a control thread so it can call
+ * rte_intr_callback_unregister (which fails from alarm/intr thread).
+ */
+static uint32_t
+mana_reset_thread(void *arg)
+	__rte_no_thread_safety_analysis
+{
+	struct mana_priv *priv = (struct mana_priv *)arg;
+	struct timespec ts;
+
+	DRV_LOG(INFO, "Reset thread started, waiting %us",
+		(unsigned int)(MANA_RESET_TIMER_US / 1000000));
+
+	/* Wait on condvar with timeout — can be woken early by PCI remove */
+	clock_gettime(CLOCK_REALTIME, &ts);
+	ts.tv_sec += MANA_RESET_TIMER_US / 1000000;
+
+	pthread_mutex_lock(&priv->reset_cond_mutex);
+	pthread_cond_timedwait(&priv->reset_cond, &priv->reset_cond_mutex, &ts);
+	pthread_mutex_unlock(&priv->reset_cond_mutex);
+
+	rte_spinlock_lock(&priv->reset_ops_lock);
+
+	if (rte_atomic_load_explicit(&priv->dev_state,
+	    rte_memory_order_acquire) != MANA_DEV_RESET_EXIT) {
+		DRV_LOG(INFO, "Reset thread: dev_state=%d, skipping",
+			(int)rte_atomic_load_explicit(&priv->dev_state,
+			rte_memory_order_acquire));
+		priv->reset_thread_active = false;
+		rte_spinlock_unlock(&priv->reset_ops_lock);
+		return 0;
+	}
+
+	DRV_LOG(INFO, "Reset thread: initiating reset exit");
+	mana_reset_exit(priv);
+	/* Lock is released by mana_reset_exit_delay at the end of
+	 * the reset exit processing. Thread flag is cleared there too.
+	 */
+	return 0;
+}
+
+static void
+mana_reset_enter(struct mana_priv *priv)
+	__rte_no_thread_safety_analysis
+{
+	int ret;
+	uint64_t ticket;
+	struct rte_eth_dev *dev = &rte_eth_devices[priv->port_id];
+
+	rte_atomic_store_explicit(&priv->dev_state, MANA_DEV_RESET_ENTER,
+				     rte_memory_order_release);
+
+	DRV_LOG(DEBUG, "Entering into device reset state");
+	DRV_LOG(DEBUG, "Resetting dev = %p, priv = %p", dev, priv);
+
+	ticket = rte_rcu_qsbr_start(priv->dev_state_qsv);
+
+	while (rte_rcu_qsbr_check(priv->dev_state_qsv, ticket, false) == 0)
+		rte_pause();
+
+	DRV_LOG(DEBUG, "All threads are quiescent");
+
+	/* Stop data path on primary and secondary before unmapping doorbell */
+	ret = mana_dev_stop(dev);
+	if (ret) {
+		DRV_LOG(ERR, "Failed to stop mana dev ret %d", ret);
+		rte_atomic_store_explicit(&priv->dev_state, MANA_DEV_RESET_FAILED,
+				     rte_memory_order_release);
+		goto reset_failed;
+	}
+
+	/* Unmap secondary doorbell pages after data path is stopped */
+	ret = mana_mp_req_on_rxtx(dev, MANA_MP_REQ_RESET_ENTER);
+	if (ret) {
+		DRV_LOG(ERR, "Failed to reset secondary processes ret = %d",
+			ret);
+		rte_atomic_store_explicit(&priv->dev_state, MANA_DEV_RESET_FAILED,
+				     rte_memory_order_release);
+		goto reset_failed;
+	}
+
+	ret = mana_dev_close(dev);
+	if (ret) {
+		DRV_LOG(ERR, "Failed to close mana dev ret %d", ret);
+		rte_atomic_store_explicit(&priv->dev_state, MANA_DEV_RESET_FAILED,
+				     rte_memory_order_release);
+		goto reset_failed;
+	}
+
+	for (int i = 0; i < priv->num_queues; i++) {
+		struct mana_rxq *rxq = dev->data->rx_queues[i];
+		struct mana_txq *txq = dev->data->tx_queues[i];
+
+		DRV_LOG(DEBUG, "Free MR for priv = %p, rxq %u, txq %u",
+			priv, rxq->rxq_idx, txq->txq_idx);
+		mana_mr_btree_free(&rxq->mr_btree);
+		mana_mr_btree_free(&txq->mr_btree);
+	}
+
+	DRV_LOG(DEBUG, "Reset processing exited successfully");
+
+	rte_atomic_store_explicit(&priv->dev_state, MANA_DEV_RESET_EXIT,
+				     rte_memory_order_release);
+
+	ret = rte_thread_create_internal_control(&priv->reset_thread,
+						 "mana-reset",
+						 mana_reset_thread, priv);
+	if (ret) {
+		DRV_LOG(ERR, "Failed to create reset thread ret %d", ret);
+		rte_atomic_store_explicit(&priv->dev_state,
+					  MANA_DEV_RESET_FAILED,
+					  rte_memory_order_release);
+		rte_spinlock_unlock(&priv->reset_ops_lock);
+		return;
+	}
+	priv->reset_thread_active = true;
+
+	DRV_LOG(DEBUG, "Reset thread started");
+
+	/* Release the lock so the application can call dev_stop/dev_close */
+	rte_spinlock_unlock(&priv->reset_ops_lock);
+	return;
+
+reset_failed:
+	rte_spinlock_unlock(&priv->reset_ops_lock);
+}
+
+static uint32_t
+mana_reset_exit_delay(void *arg)
+	__rte_no_thread_safety_analysis
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
+		rte_spinlock_unlock(&priv->reset_ops_lock);
+		return ret;
+	}
+
+	dev = &rte_eth_devices[priv->port_id];
+	pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+
+	DRV_LOG(DEBUG, "Resetting dev = %p, priv = %p", dev, priv);
+
+	ret = ibv_close_device(priv->ib_ctx);
+	priv->ib_ctx = NULL;
+	if (ret) {
+		DRV_LOG(ERR, "Failed to close ibv device %d", ret);
+		rte_atomic_store_explicit(&priv->dev_state, MANA_DEV_RESET_FAILED,
+				     rte_memory_order_release);
+		goto out;
+	}
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
+	rte_atomic_store_explicit(&priv->dev_state, MANA_DEV_ACTIVE,
+				     rte_memory_order_release);
+
+	DRV_LOG(DEBUG, "Exiting the reset complete processing");
+
+	DRV_LOG(INFO, "Sending RTE_ETH_EVENT_RECOVERY_SUCCESS for port %u",
+		priv->port_id);
+	rte_eth_dev_callback_process(dev,
+		RTE_ETH_EVENT_RECOVERY_SUCCESS, NULL);
+
+out:
+	if (ret) {
+		DRV_LOG(INFO, "Sending RTE_ETH_EVENT_RECOVERY_FAILED for port %u",
+			priv->port_id);
+		rte_eth_dev_callback_process(dev,
+			RTE_ETH_EVENT_RECOVERY_FAILED, NULL);
+	}
+	priv->reset_thread_active = false;
+	rte_spinlock_unlock(&priv->reset_ops_lock);
+	return ret;
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
+	DRV_LOG(INFO, "Sending RTE_ETH_EVENT_RECOVERY_FAILED (MR init) for port %u",
+		priv->port_id);
+	rte_eth_dev_callback_process(dev,
+		RTE_ETH_EVENT_RECOVERY_FAILED, NULL);
+
+	priv->reset_thread_active = false;
+	rte_spinlock_unlock(&priv->reset_ops_lock);
+	return ret;
+}
+
+static void
+mana_reset_exit(struct mana_priv *priv)
+	__rte_no_thread_safety_analysis
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
+	__rte_no_thread_safety_analysis
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
+				rte_spinlock_lock(&priv->reset_ops_lock);
+				mana_reset_enter(priv);
+
+				dev = &rte_eth_devices[priv->port_id];
+				DRV_LOG(INFO, "Sending RTE_ETH_EVENT_ERR_RECOVERING for port %u",
+					priv->port_id);
 				rte_eth_dev_callback_process(dev,
-					RTE_ETH_EVENT_INTR_RMV, NULL);
+					RTE_ETH_EVENT_ERR_RECOVERING, NULL);
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
@@ -1063,6 +1739,17 @@ static int
 mana_intr_uninstall(struct mana_priv *priv)
 {
 	int ret;
+	struct rte_eth_dev *dev;
+
+	if (!priv->intr_handle)
+		return 0;
+
+	/* Unregister PCI device removal event callback */
+	dev = &rte_eth_devices[priv->port_id];
+	if (dev->device)
+		rte_dev_event_callback_unregister(dev->device->name,
+						  mana_pci_remove_event_cb,
+						  priv);
 
 	ret = rte_intr_callback_unregister(priv->intr_handle,
 					   mana_intr_handler, priv);
@@ -1072,6 +1759,7 @@ mana_intr_uninstall(struct mana_priv *priv)
 	}
 
 	rte_intr_instance_free(priv->intr_handle);
+	priv->intr_handle = NULL;
 
 	return 0;
 }
@@ -1127,6 +1815,14 @@ mana_intr_install(struct rte_eth_dev *eth_dev, struct mana_priv *priv)
 		goto free_intr;
 	}
 
+	/* Register for PCI device removal events to distinguish
+	 * PCI hot-remove from service reset.
+	 */
+	ret = rte_dev_event_callback_register(eth_dev->device->name,
+					      mana_pci_remove_event_cb, priv);
+	if (ret)
+		DRV_LOG(WARNING, "Failed to register PCI remove event callback");
+
 	eth_dev->intr_handle = priv->intr_handle;
 	return 0;
 
@@ -1156,7 +1852,7 @@ mana_proc_priv_init(struct rte_eth_dev *dev)
 /*
  * Map the doorbell page for the secondary process through IB device handle.
  */
-static int
+int
 mana_map_doorbell_secondary(struct rte_eth_dev *eth_dev, int fd)
 {
 	struct mana_process_priv *priv = eth_dev->process_private;
@@ -1294,17 +1990,28 @@ mana_probe_port(struct ibv_device *ibdev, struct ibv_device_attr_ex *dev_attr,
 	char name[RTE_ETH_NAME_MAX_LEN];
 	int ret;
 	struct ibv_context *ctx = NULL;
+	size_t sz;
+	bool is_reset = false;
 
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
 
@@ -1317,6 +2024,7 @@ mana_probe_port(struct ibv_device *ibdev, struct ibv_device_attr_ex *dev_attr,
 
 		eth_dev->device = &pci_dev->device;
 		eth_dev->dev_ops = &mana_dev_secondary_ops;
+
 		ret = mana_proc_priv_init(eth_dev);
 		if (ret)
 			goto failed;
@@ -1336,7 +2044,7 @@ mana_probe_port(struct ibv_device *ibdev, struct ibv_device_attr_ex *dev_attr,
 			goto failed;
 		}
 
-		/* fd is no not used after mapping doorbell */
+		/* fd is not used after mapping doorbell */
 		close(fd);
 
 		eth_dev->tx_pkt_burst = mana_tx_burst;
@@ -1355,22 +2063,6 @@ mana_probe_port(struct ibv_device *ibdev, struct ibv_device_attr_ex *dev_attr,
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
@@ -1390,10 +2082,6 @@ mana_probe_port(struct ibv_device *ibdev, struct ibv_device_attr_ex *dev_attr,
 	}
 
 	priv->ib_ctx = ctx;
-	priv->port_id = eth_dev->data->port_id;
-	priv->dev_port = port;
-	eth_dev->data->dev_private = priv;
-	priv->dev_data = eth_dev->data;
 
 	priv->max_rx_queues = dev_attr->orig_attr.max_qp;
 	priv->max_tx_queues = dev_attr->orig_attr.max_qp;
@@ -1415,23 +2103,85 @@ mana_probe_port(struct ibv_device *ibdev, struct ibv_device_attr_ex *dev_attr,
 		name, priv->max_rx_queues, priv->max_rx_desc,
 		priv->max_send_sge, priv->max_mr_size);
 
+	if (!is_reset) {
+		eth_dev = rte_eth_dev_allocate(name);
+		if (!eth_dev) {
+			ret = -ENOMEM;
+			goto failed;
+		}
+
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
+	}
+
+	priv->port_id = eth_dev->data->port_id;
+	priv->dev_port = port;
+	eth_dev->data->dev_private = priv;
+	priv->dev_data = eth_dev->data;
+	rte_atomic_store_explicit(&priv->dev_state, MANA_DEV_ACTIVE,
+				     rte_memory_order_release);
+
 	rte_eth_copy_pci_info(eth_dev, pci_dev);
 
-	/* Create async interrupt handler */
-	ret = mana_intr_install(eth_dev, priv);
-	if (ret) {
-		DRV_LOG(ERR, "Failed to install intr handler");
+	/*
+	 * Now we've got maximum queues. Init the qsv to be the
+	 * double of maximum queues for both rx and tx queues.
+	 */
+	sz = rte_rcu_qsbr_get_memsize(2 * priv->max_rx_queues);
+	priv->dev_state_qsv = rte_zmalloc_socket("mana_rcu", sz,
+					    RTE_CACHE_LINE_SIZE,
+					    SOCKET_ID_ANY);
+	if (!priv->dev_state_qsv) {
+		DRV_LOG(ERR, "No memory for dev_state_qsv");
+		ret = -ENOMEM;
+		goto failed;
+	}
+	ret = rte_rcu_qsbr_init(priv->dev_state_qsv, 2 * priv->max_rx_queues);
+	if (ret < 0) {
+		DRV_LOG(ERR, "Init dev_state_qsv failed ret %d", ret);
 		goto failed;
 	}
 
-	eth_dev->device = &pci_dev->device;
+	rte_spinlock_init(&priv->reset_ops_lock);
+	pthread_mutex_init(&priv->reset_cond_mutex, NULL);
+	pthread_cond_init(&priv->reset_cond, NULL);
 
-	DRV_LOG(INFO, "device %s at port %u", name, eth_dev->data->port_id);
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
@@ -1439,20 +2189,32 @@ mana_probe_port(struct ibv_device *ibdev, struct ibv_device_attr_ex *dev_attr,
 failed:
 	/* Free the resource for the port failed */
 	if (priv) {
-		if (priv->ib_parent_pd)
+		if (!is_reset && priv->dev_state_qsv)
+			rte_free(priv->dev_state_qsv);
+
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
diff --git a/drivers/net/mana/mana.h b/drivers/net/mana/mana.h
index 79cc47b6ab..7f8f1ff638 100644
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
@@ -337,6 +339,20 @@ struct mana_process_priv {
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
 struct mana_priv {
 	struct rte_eth_dev_data *dev_data;
 	struct mana_process_priv *process_priv;
@@ -368,6 +384,16 @@ struct mana_priv {
 	uint64_t max_mr_size;
 	struct mana_mr_btree mr_btree;
 	rte_spinlock_t	mr_btree_lock;
+	RTE_ATOMIC(enum mana_device_state) dev_state;
+	struct rte_rcu_qsbr *dev_state_qsv;
+	/* lock for synchronizing mana reset and some mana_dev_ops callbacks */
+	rte_spinlock_t reset_ops_lock;
+	/* Reset thread ID, valid when reset_thread_active is true */
+	rte_thread_t reset_thread;
+	bool reset_thread_active;
+	/* Condvar to wake reset thread early on PCI remove */
+	pthread_mutex_t reset_cond_mutex;
+	pthread_cond_t reset_cond;
 };
 
 struct mana_txq_desc {
@@ -427,6 +453,7 @@ struct mana_txq {
 	struct mana_mr_btree mr_btree;
 	struct mana_stats stats;
 	unsigned int socket;
+	unsigned int txq_idx;
 };
 
 struct mana_rxq {
@@ -462,6 +489,7 @@ struct mana_rxq {
 	struct mana_mr_btree mr_btree;
 
 	unsigned int socket;
+	unsigned int rxq_idx;
 };
 
 extern int mana_logtype_driver;
@@ -543,6 +571,8 @@ enum mana_mp_req_type {
 	MANA_MP_REQ_CREATE_MR,
 	MANA_MP_REQ_START_RXTX,
 	MANA_MP_REQ_STOP_RXTX,
+	MANA_MP_REQ_RESET_ENTER,
+	MANA_MP_REQ_RESET_EXIT,
 };
 
 /* Pameters for IPC. */
@@ -563,8 +593,9 @@ void mana_mp_uninit_primary(void);
 void mana_mp_uninit_secondary(void);
 int mana_mp_req_verbs_cmd_fd(struct rte_eth_dev *dev);
 int mana_mp_req_mr_create(struct mana_priv *priv, uintptr_t addr, uint32_t len);
+int mana_map_doorbell_secondary(struct rte_eth_dev *eth_dev, int fd);
 
-void mana_mp_req_on_rxtx(struct rte_eth_dev *dev, enum mana_mp_req_type type);
+int mana_mp_req_on_rxtx(struct rte_eth_dev *dev, enum mana_mp_req_type type);
 
 void *mana_alloc_verbs_buf(size_t size, void *data);
 void mana_free_verbs_buf(void *ptr, void *data __rte_unused);
diff --git a/drivers/net/mana/meson.build b/drivers/net/mana/meson.build
index 19d4b3695e..5b01d9f57e 100644
--- a/drivers/net/mana/meson.build
+++ b/drivers/net/mana/meson.build
@@ -7,7 +7,7 @@ if not is_linux or not (dpdk_conf.has('RTE_ARCH_X86') or dpdk_conf.has('RTE_ARCH
     subdir_done()
 endif
 
-deps += ['pci', 'bus_pci', 'net', 'eal', 'kvargs']
+deps += ['pci', 'bus_pci', 'net', 'eal', 'kvargs', 'rcu']
 
 sources += files(
         'gdma.c',
diff --git a/drivers/net/mana/mp.c b/drivers/net/mana/mp.c
index 72417fc0c7..c06641f7d9 100644
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
+	proc_priv->db_page = (void *)0;
+
+	if (addr)
+		(void)munmap(addr, rte_mem_page_size());
+
+	DRV_LOG(DEBUG, "All secondary threads are quiescent");
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
+			if (proc_priv->db_page != 0) {
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
index 1b8ba1f3a9..ae05d8dd2f 100644
--- a/drivers/net/mana/rx.c
+++ b/drivers/net/mana/rx.c
@@ -2,6 +2,7 @@
  * Copyright 2022 Microsoft Corporation
  */
 #include <ethdev_driver.h>
+#include <rte_rcu_qsbr.h>
 
 #include <infiniband/verbs.h>
 #include <infiniband/manadv.h>
@@ -36,6 +37,11 @@ mana_rq_ring_doorbell(struct mana_rxq *rxq)
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
@@ -172,7 +178,7 @@ mana_stop_rx_queues(struct rte_eth_dev *dev)
 
 	for (i = 0; i < priv->num_queues; i++)
 		if (dev->data->rx_queue_state[i] == RTE_ETH_QUEUE_STATE_STOPPED)
-			return -EINVAL;
+			return 0;
 
 	if (priv->rwq_qp) {
 		ret = ibv_destroy_qp(priv->rwq_qp);
@@ -256,6 +262,9 @@ mana_start_rx_queues(struct rte_eth_dev *dev)
 		struct mana_rxq *rxq = dev->data->rx_queues[i];
 		struct ibv_wq_init_attr wq_attr = {};
 
+		rxq->rxq_idx = i;
+		DRV_LOG(DEBUG, "assigning rxq_idx to %d", i);
+
 		manadv_set_context_attr(priv->ib_ctx,
 			MANADV_CTX_ATTR_BUF_ALLOCATORS,
 			(void *)((uintptr_t)&(struct manadv_ctx_allocators){
@@ -451,6 +460,17 @@ mana_rx_burst(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
 	uint32_t pkt_len;
 	uint32_t i;
 	int polled = 0;
+	struct rte_rcu_qsbr *dstate_qsv = priv->dev_state_qsv;
+	unsigned int tid = rxq->rxq_idx;
+
+	rte_rcu_qsbr_thread_online(dstate_qsv, tid);
+
+	if (unlikely(rte_atomic_load_explicit(&priv->dev_state,
+			    rte_memory_order_acquire) != MANA_DEV_ACTIVE)) {
+		/* Device reset occurred. */
+		rte_rcu_qsbr_thread_offline(dstate_qsv, tid);
+		return 0;
+	}
 
 repoll:
 	/* Polling on new completions if we have no backlog */
@@ -592,6 +612,8 @@ mana_rx_burst(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
 				wqe_consumed, ret);
 	}
 
+	rte_rcu_qsbr_thread_offline(dstate_qsv, tid);
+
 	return pkt_received;
 }
 
diff --git a/drivers/net/mana/tx.c b/drivers/net/mana/tx.c
index 57dbbc3651..3b07a8b9a6 100644
--- a/drivers/net/mana/tx.c
+++ b/drivers/net/mana/tx.c
@@ -3,6 +3,7 @@
  */
 
 #include <ethdev_driver.h>
+#include <rte_rcu_qsbr.h>
 
 #include <infiniband/verbs.h>
 #include <infiniband/manadv.h>
@@ -17,7 +18,7 @@ mana_stop_tx_queues(struct rte_eth_dev *dev)
 
 	for (i = 0; i < priv->num_queues; i++)
 		if (dev->data->tx_queue_state[i] == RTE_ETH_QUEUE_STATE_STOPPED)
-			return -EINVAL;
+			return 0;
 
 	for (i = 0; i < priv->num_queues; i++) {
 		struct mana_txq *txq = dev->data->tx_queues[i];
@@ -83,6 +84,9 @@ mana_start_tx_queues(struct rte_eth_dev *dev)
 
 		txq = dev->data->tx_queues[i];
 
+		txq->txq_idx = i;
+		DRV_LOG(DEBUG, "assigning txq_idx to %d", txq->txq_idx);
+
 		manadv_set_context_attr(priv->ib_ctx,
 			MANADV_CTX_ATTR_BUF_ALLOCATORS,
 			(void *)((uintptr_t)&(struct manadv_ctx_allocators){
@@ -190,10 +194,30 @@ mana_tx_burst(void *dpdk_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	void *db_page;
 	uint16_t pkt_sent = 0;
 	uint32_t num_comp, i;
+	unsigned int tid = priv->num_queues + txq->txq_idx;
+	struct rte_rcu_qsbr *dstate_qsv = priv->dev_state_qsv;
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
+	rte_rcu_qsbr_thread_online(dstate_qsv, tid);
+
+	if (unlikely(rte_atomic_load_explicit(&priv->dev_state,
+			    rte_memory_order_acquire) != MANA_DEV_ACTIVE || !db_page)) {
+		/* Device reset event occurred. */
+		rte_rcu_qsbr_thread_offline(dstate_qsv, tid);
+		return 0;
+	}
+
 	/* Process send completions from GDMA */
 	num_comp = gdma_poll_completion_queue(&txq->gdma_cq,
 			txq->gdma_comp_buf, txq->num_desc);
@@ -216,7 +240,8 @@ mana_tx_burst(void *dpdk_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		}
 
 		if (!desc->pkt) {
-			DP_LOG(ERR, "mana_txq_desc has a NULL pkt");
+			DP_LOG(ERR, "mana_txq_desc has a NULL pkt, priv %p, "
+			       "txq = %d", priv, txq->txq_idx);
 		} else {
 			txq->stats.bytes += desc->pkt->pkt_len;
 			rte_pktmbuf_free(desc->pkt);
@@ -474,15 +499,6 @@ mana_tx_burst(void *dpdk_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
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
@@ -501,5 +517,7 @@ mana_tx_burst(void *dpdk_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 			DP_LOG(ERR, "mana_ring_doorbell failed ret %d", ret);
 	}
 
+	rte_rcu_qsbr_thread_offline(dstate_qsv, tid);
+
 	return pkt_sent;
 }
-- 
2.34.1

