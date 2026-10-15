Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5624CC6B33
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 09:18:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 353AF406FF;
	Thu, 15 Oct 2026 11:17:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id BA391406B8;
 Thu, 15 Oct 2026 11:17:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792055857; x=1823591857;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OBmhBevJY/C0aTDZ4yjbeL0xpEojVNeyyldBoduj934=;
 b=ZXJAA6YwgJbU2agG3IwnSFTGcsMUR8pD8SemYuNswAO6elPV12nmjz11
 yQda0hl5N1NoO8Ayf7hM0zwev3oT/1WKW10UYmgUarBvAgbJmg0kAxIwP
 bjyi/g77yn2UZ82QzInRxHn8KbNjCA+Vr81oyHeqeWQ94kIm1Plm9HFnm
 beQOPARU20OOKbGuXaR5d60mNtbbYjCeV198429uCKFjPUe4pvOW92o9B
 lxJiuHNfQyZdQir+FaAyNQEX7sY+moEyzoWEx6DIkSXpNzL7gG+DsQexJ
 GQMCzyUakK7Nm0DzzxW4h9G/6ULmHIGxsDUaHSEAcpyJNRGSPOe6r9iRL w==;
X-CSE-ConnectionGUID: z8YDBWjRQEGR2co5ZMxALA==
X-CSE-MsgGUID: QksMR80uRACnmEqTqr1BjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="808483"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="808483"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 02:17:36 -0700
X-CSE-ConnectionGUID: +iolgkGMSo6SvVxUIoKNww==
X-CSE-MsgGUID: jqPiwOKLS5CDZ6aTaKQj3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="2000380"
Received: from pae-31.iind.intel.com ([10.49.105.72])
 by fmviesa009.fm.intel.com with ESMTP; 15 Oct 2026 02:17:35 -0700
From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
To: dev@dpdk.org
Cc: grive@u256.net, stephen@networkplumber.org, stable@dpdk.org,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Subject: [PATCH v3 5/6] net/failsafe: fix Rx/Tx burst after sub-device removal
Date: Thu, 15 Oct 2026 16:19:26 +0000
Message-Id: <20261015161927.194886-6-sandeep.penigalapati@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261015161927.194886-1-sandeep.penigalapati@intel.com>
References: <20261014221604.128677-1-sandeep.penigalapati@intel.com>
 <20261015161927.194886-1-sandeep.penigalapati@intel.com>
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

To cope with a disappearing sub-device, fail-safe swapped its Rx/Tx
burst functions to "safe" variants when a removal was handled. This has
no effect: rte_eth_dev_start() copies the burst functions into
rte_eth_fp_ops after calling the PMD start, and the data path invokes
them through that structure. Replacing dev->rx_pkt_burst and
dev->tx_pkt_burst at runtime is therefore ignored, and the fast
variants installed at start keep dereferencing the removed sub-device,
leading to a crash.

Drop failsafe_set_burst_fn() and the _fast burst variants and keep a
single burst path that checks the sub-device state on each call through
an unlikely() guard.

Fixes: c87d435a4d79 ("ethdev: copy fast-path API into separate structure")
Cc: stable@dpdk.org
Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
---
v3:
- New patch, split out from the v2 removal-detection patch.

 drivers/net/failsafe/failsafe_ether.c   |  2 -
 drivers/net/failsafe/failsafe_private.h |  8 ---
 drivers/net/failsafe/failsafe_rxtx.c    | 83 +------------------------
 3 files changed, 1 insertion(+), 92 deletions(-)

diff --git a/drivers/net/failsafe/failsafe_ether.c b/drivers/net/failsafe/failsafe_ether.c
index 92a279a5b9..2c183ea29a 100644
--- a/drivers/net/failsafe/failsafe_ether.c
+++ b/drivers/net/failsafe/failsafe_ether.c
@@ -591,8 +591,6 @@ failsafe_eth_rmv_event_callback(uint16_t port_id __rte_unused,
 		return -1;
 	/* Switch as soon as possible tx_dev. */
 	fs_switch_dev(fs_dev(sdev), sdev);
-	/* Use safe bursts in any case. */
-	failsafe_set_burst_fn(fs_dev(sdev), 1);
 	/*
 	 * Async removal, the sub-PMD will try to unregister
 	 * the callback at the source of the current thread context.
diff --git a/drivers/net/failsafe/failsafe_private.h b/drivers/net/failsafe/failsafe_private.h
index aae091e792..0f14080394 100644
--- a/drivers/net/failsafe/failsafe_private.h
+++ b/drivers/net/failsafe/failsafe_private.h
@@ -208,18 +208,11 @@ int failsafe_hotplug_alarm_cancel(struct rte_eth_dev *dev);
 
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
@@ -487,7 +480,6 @@ fs_switch_dev(struct rte_eth_dev *dev,
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

