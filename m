Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A80CC6B1D
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:14:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F09440E18;
	Wed, 14 Oct 2026 17:14:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 5478040144;
 Wed, 14 Oct 2026 17:14:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791990856; x=1823526856;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rEamoKa5VOxaTjYcN2CQe4XyB0tv53AwhHIK7UWpd50=;
 b=irAU97eq1mZxn6wkLEsd6fHvK8BP0268Shh1vYJm4FgTvaMVmYkMBAda
 5RvLdgizUfFLWQ92o+jYbFnseh2WwHI/PrEJ4/BEOkwg8QJa5cx+wooBI
 Ot1wlDu3k6WphbEag2HNmNQDh0UXlr5gpU09cEVO4rtNf278yOZdapwgG
 eHyUEWi4VOTad7EyookY3TwAjlxCm/IdLCQdCzEWcx4vCKnfuFcg+HwgX
 lSrNRKGord9r8BqbSKiZ2QrraFOOCUxi4ErCkWyQecnqSPLvFFrt50JuG
 4eM1p1fkdiRcotEQhtdU8uN93QKDrrOhxie9uTT2c/Aqj4WHf1k+iDFaI A==;
X-CSE-ConnectionGUID: YXT4Oxr4Rqals6RQqqjp0g==
X-CSE-MsgGUID: UK1DDQrNSQur0ImpuKmd7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="642352"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="642352"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 08:14:10 -0700
X-CSE-ConnectionGUID: 08MQBJB9STGjYfwaGOKTsw==
X-CSE-MsgGUID: QqSQWVUgRxSMdJSs18FKIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1785452"
Received: from pae-31.iind.intel.com ([10.49.105.72])
 by fmviesa008.fm.intel.com with ESMTP; 14 Oct 2026 08:14:09 -0700
From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
To: dev@dpdk.org
Cc: Gaetan Rivet <grive@u256.net>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Subject: [PATCH v2 5/5] net/failsafe: detect sub-device removal via device
 event
Date: Wed, 14 Oct 2026 22:16:04 +0000
Message-Id: <20261014221604.128677-6-sandeep.penigalapati@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261014221604.128677-1-sandeep.penigalapati@intel.com>
References: <20261014194257.123356-1-sandeep.penigalapati@intel.com>
 <20261014221604.128677-1-sandeep.penigalapati@intel.com>
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

Fail-safe relied on the removal (RMV) interrupt and on swapping the
Rx/Tx burst functions to "safe" variants to cope with a disappearing
sub-device. When a sub-device does not support the RMV interrupt (for
example a VFIO device whose removal is only reported by the bus as a
device event on the release request), the removal was not detected:
the burst functions kept polling the gone device and traffic was not
failed over to the other sub-device.

Register a bus device-event callback for sub-devices without RMV
interrupt support and run the existing removal handling from it. The
callback is registered and unregistered by the primary process only:
struct sub_device lives in shared memory, so in a secondary process the
registration flag would read as set and sdev->dev would point into the
primary address space; dereferencing it would crash.

With removal now reported reliably, the per-burst safe/fast function
switching is no longer needed; drop failsafe_set_burst_fn() and the
_fast burst variants and keep a single burst path guarded by an
unlikely() check.

Fixes: a46f8d584eb8 ("net/failsafe: add fail-safe PMD")
Cc: stable@dpdk.org
Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
---
v2:
- Clarify in a comment that a secondary detects removal via the shared
  sub_device state checked by fs_rx_unsafe()/fs_tx_unsafe().

 drivers/net/failsafe/failsafe_ether.c   | 29 ++++++++-
 drivers/net/failsafe/failsafe_ops.c     | 19 ++++++
 drivers/net/failsafe/failsafe_private.h | 13 ++--
 drivers/net/failsafe/failsafe_rxtx.c    | 83 +------------------------
 4 files changed, 52 insertions(+), 92 deletions(-)

diff --git a/drivers/net/failsafe/failsafe_ether.c b/drivers/net/failsafe/failsafe_ether.c
index f23580ed37..2a15eb4da5 100644
--- a/drivers/net/failsafe/failsafe_ether.c
+++ b/drivers/net/failsafe/failsafe_ether.c
@@ -386,6 +386,22 @@ failsafe_eth_dev_unregister_callbacks(struct sub_device *sdev)
 			     " %d", SUB_ID(sdev));
 		sdev->lsc_callback = 0;
 	}
+	/*
+	 * The bus device-event callback is registered by the primary only
+	 * (hotplug is handled there). sub_device is shared memory, so in a
+	 * secondary the flag reads as set and sdev->dev holds the primary's
+	 * pointer; dereferencing it (rte_dev_name) would crash. Skip it.
+	 */
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY &&
+	    sdev->dev_event_callback) {
+		ret = rte_dev_event_callback_unregister(rte_dev_name(sdev->dev),
+						failsafe_dev_event_callback,
+						sdev);
+		if (ret < 0)
+			WARN("Failed to unregister device event callback for"
+			     " sub_device %d", SUB_ID(sdev));
+		sdev->dev_event_callback = 0;
+	}
 }
 
 void
@@ -592,8 +608,6 @@ failsafe_eth_rmv_event_callback(uint16_t port_id __rte_unused,
 		return -1;
 	/* Switch as soon as possible tx_dev. */
 	fs_switch_dev(fs_dev(sdev), sdev);
-	/* Use safe bursts in any case. */
-	failsafe_set_burst_fn(fs_dev(sdev), 1);
 	/*
 	 * Async removal, the sub-PMD will try to unregister
 	 * the callback at the source of the current thread context.
@@ -603,6 +617,17 @@ failsafe_eth_rmv_event_callback(uint16_t port_id __rte_unused,
 	return 0;
 }
 
+void
+failsafe_dev_event_callback(const char *device_name __rte_unused,
+			    enum rte_dev_event_type type,
+			    void *cb_arg)
+{
+	if (type != RTE_DEV_EVENT_REMOVE)
+		return;
+	failsafe_eth_rmv_event_callback(PORT_ID((struct sub_device *)cb_arg),
+					RTE_ETH_EVENT_INTR_RMV, cb_arg, NULL);
+}
+
 int
 failsafe_eth_lsc_event_callback(uint16_t port_id __rte_unused,
 				enum rte_eth_event_type event __rte_unused,
diff --git a/drivers/net/failsafe/failsafe_ops.c b/drivers/net/failsafe/failsafe_ops.c
index f0c12dfaa3..d5b49a39c2 100644
--- a/drivers/net/failsafe/failsafe_ops.c
+++ b/drivers/net/failsafe/failsafe_ops.c
@@ -82,6 +82,25 @@ fs_dev_configure(struct rte_eth_dev *dev)
 			else
 				sdev->rmv_callback = 1;
 		}
+		/*
+		 * Without RMV interrupts, a hot-unplug is only reported by the
+		 * bus (e.g. a VFIO device release request) as a device event.
+		 * Only the primary registers for it; a secondary learns of the
+		 * removal through the shared sub_device state checked by
+		 * fs_rx_unsafe()/fs_tx_unsafe() on every burst.
+		 */
+		if (rte_eal_process_type() == RTE_PROC_PRIMARY &&
+		    !rmv_interrupt && sdev->dev != NULL &&
+		    sdev->dev_event_callback == 0) {
+			ret = rte_dev_event_callback_register(rte_dev_name(sdev->dev),
+					failsafe_dev_event_callback,
+					sdev);
+			if (ret)
+				WARN("Failed to register device event callback for sub_device %d",
+				     SUB_ID(sdev));
+			else
+				sdev->dev_event_callback = 1;
+		}
 		dev->data->dev_conf.intr_conf.rmv = 0;
 		if (lsc_interrupt && sdev->lsc_callback == 0) {
 			ret = rte_eth_dev_callback_register(PORT_ID(sdev),
diff --git a/drivers/net/failsafe/failsafe_private.h b/drivers/net/failsafe/failsafe_private.h
index aae091e792..a565ee2fbc 100644
--- a/drivers/net/failsafe/failsafe_private.h
+++ b/drivers/net/failsafe/failsafe_private.h
@@ -138,6 +138,8 @@ struct sub_device {
 	unsigned int rmv_callback:1;
 	/* LSC callback registration state */
 	unsigned int lsc_callback:1;
+	/* Bus device event (removal) callback registration state */
+	unsigned int dev_event_callback:1;
 };
 
 /*
@@ -208,18 +210,11 @@ int failsafe_hotplug_alarm_cancel(struct rte_eth_dev *dev);
 
 /* RX / TX */
 
-void failsafe_set_burst_fn(struct rte_eth_dev *dev, int force_safe);
-
 uint16_t failsafe_rx_burst(void *rxq,
 		struct rte_mbuf **rx_pkts, uint16_t nb_pkts);
 uint16_t failsafe_tx_burst(void *txq,
 		struct rte_mbuf **tx_pkts, uint16_t nb_pkts);
 
-uint16_t failsafe_rx_burst_fast(void *rxq,
-		struct rte_mbuf **rx_pkts, uint16_t nb_pkts);
-uint16_t failsafe_tx_burst_fast(void *txq,
-		struct rte_mbuf **tx_pkts, uint16_t nb_pkts);
-
 /* ARGS */
 
 int failsafe_args_parse(struct rte_eth_dev *dev, const char *params);
@@ -246,6 +241,9 @@ int failsafe_eth_rmv_event_callback(uint16_t port_id,
 int failsafe_eth_lsc_event_callback(uint16_t port_id,
 				    enum rte_eth_event_type event,
 				    void *cb_arg, void *out);
+void failsafe_dev_event_callback(const char *device_name,
+				 enum rte_dev_event_type type,
+				 void *cb_arg);
 int failsafe_eth_new_event_callback(uint16_t port_id,
 				    enum rte_eth_event_type event,
 				    void *cb_arg, void *out);
@@ -487,7 +485,6 @@ fs_switch_dev(struct rte_eth_dev *dev,
 	} else {
 		return;
 	}
-	failsafe_set_burst_fn(dev, 0);
 	rte_wmb();
 }
 
diff --git a/drivers/net/failsafe/failsafe_rxtx.c b/drivers/net/failsafe/failsafe_rxtx.c
index 500483bda3..8d53d9dd40 100644
--- a/drivers/net/failsafe/failsafe_rxtx.c
+++ b/drivers/net/failsafe/failsafe_rxtx.c
@@ -28,39 +28,6 @@ fs_tx_unsafe(struct sub_device *sdev)
 		(sdev->state != DEV_STARTED);
 }
 
-void
-failsafe_set_burst_fn(struct rte_eth_dev *dev, int force_safe)
-{
-	struct sub_device *sdev;
-	uint8_t i;
-	int need_safe;
-	int safe_set;
-
-	need_safe = force_safe;
-	FOREACH_SUBDEV(sdev, i, dev)
-		need_safe |= fs_rx_unsafe(sdev);
-	safe_set = (dev->rx_pkt_burst == &failsafe_rx_burst);
-	if (need_safe && !safe_set) {
-		DEBUG("Using safe RX bursts%s",
-		      (force_safe ? " (forced)" : ""));
-		dev->rx_pkt_burst = &failsafe_rx_burst;
-	} else if (!need_safe && safe_set) {
-		DEBUG("Using fast RX bursts");
-		dev->rx_pkt_burst = &failsafe_rx_burst_fast;
-	}
-	need_safe = force_safe || fs_tx_unsafe(TX_SUBDEV(dev));
-	safe_set = (dev->tx_pkt_burst == &failsafe_tx_burst);
-	if (need_safe && !safe_set) {
-		DEBUG("Using safe TX bursts%s",
-		      (force_safe ? " (forced)" : ""));
-		dev->tx_pkt_burst = &failsafe_tx_burst;
-	} else if (!need_safe && safe_set) {
-		DEBUG("Using fast TX bursts");
-		dev->tx_pkt_burst = &failsafe_tx_burst_fast;
-	}
-	rte_wmb();
-}
-
 /*
  * Override source port in Rx packets.
  *
@@ -89,7 +56,7 @@ failsafe_rx_burst(void *queue,
 	rxq = queue;
 	sdev = rxq->sdev;
 	do {
-		if (fs_rx_unsafe(sdev)) {
+		if (unlikely(fs_rx_unsafe(sdev))) {
 			nb_rx = 0;
 			sdev = sdev->next;
 			continue;
@@ -108,34 +75,6 @@ failsafe_rx_burst(void *queue,
 	return nb_rx;
 }
 
-uint16_t
-failsafe_rx_burst_fast(void *queue,
-			 struct rte_mbuf **rx_pkts,
-			 uint16_t nb_pkts)
-{
-	struct sub_device *sdev;
-	struct rxq *rxq;
-	void *sub_rxq;
-	uint16_t nb_rx;
-
-	rxq = queue;
-	sdev = rxq->sdev;
-	do {
-		RTE_ASSERT(!fs_rx_unsafe(sdev));
-		sub_rxq = ETH(sdev)->data->rx_queues[rxq->qid];
-		FS_ATOMIC_P(rxq->refcnt[sdev->sid]);
-		nb_rx = ETH(sdev)->
-			rx_pkt_burst(sub_rxq, rx_pkts, nb_pkts);
-		FS_ATOMIC_V(rxq->refcnt[sdev->sid]);
-		sdev = sdev->next;
-	} while (nb_rx == 0 && sdev != rxq->sdev);
-	rxq->sdev = sdev;
-	if (nb_rx)
-		failsafe_rx_set_port(rx_pkts, nb_rx,
-				     rxq->priv->data->port_id);
-	return nb_rx;
-}
-
 uint16_t
 failsafe_tx_burst(void *queue,
 		  struct rte_mbuf **tx_pkts,
@@ -156,23 +95,3 @@ failsafe_tx_burst(void *queue,
 	FS_ATOMIC_V(txq->refcnt[sdev->sid]);
 	return nb_tx;
 }
-
-uint16_t
-failsafe_tx_burst_fast(void *queue,
-			 struct rte_mbuf **tx_pkts,
-			 uint16_t nb_pkts)
-{
-	struct sub_device *sdev;
-	struct txq *txq;
-	void *sub_txq;
-	uint16_t nb_tx;
-
-	txq = queue;
-	sdev = TX_SUBDEV(&rte_eth_devices[txq->priv->data->port_id]);
-	RTE_ASSERT(!fs_tx_unsafe(sdev));
-	sub_txq = ETH(sdev)->data->tx_queues[txq->qid];
-	FS_ATOMIC_P(txq->refcnt[sdev->sid]);
-	nb_tx = ETH(sdev)->tx_pkt_burst(sub_txq, tx_pkts, nb_pkts);
-	FS_ATOMIC_V(txq->refcnt[sdev->sid]);
-	return nb_tx;
-}
-- 
2.34.1

