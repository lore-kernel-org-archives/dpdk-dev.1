Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B973C5B574
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 07:42:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C05B24113C;
	Tue, 11 Aug 2026 09:40:52 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 0C63040E54
 for <dev@dpdk.org>; Tue, 11 Aug 2026 09:40:41 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E4592200190;
 Tue, 11 Aug 2026 09:40:40 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id ABFA120017E;
 Tue, 11 Aug 2026 09:40:40 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 3545A1800088;
 Tue, 11 Aug 2026 15:40:40 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com,
	Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v6 13/13] net/enetc4: enable Tx PAUSE via VF Rx congestion mode
Date: Tue, 11 Aug 2026 13:10:32 +0530
Message-Id: <20260811074032.3646324-14-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260811074032.3646324-1-g.singh@nxp.com>
References: <20260810104815.2827703-1-g.singh@nxp.com>
 <20260811074032.3646324-1-g.singh@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

When the PF negotiates TX PAUSE on the port it signals this to the VF
via BIT(1) of the PF-to-VF link status mailbox message. The VF PMD must
respond by setting RBMR_CM (BIT(4)) on all active RX rings so the MAC
emits PAUSE frames on ingress pressure.

Add ENETC_RBMR_CM register definition, ENETC_LINK_TX_PAUSE bitmask,
and tx_pause_active state flag. Add enetc4_vf_set_congestion_mode() to
update all active RX rings and persist the state for rings started
later. Hook it into both the interrupt and poll link-update paths, and
apply the saved state in rx_queue_setup() and rx_queue_start().

RX PAUSE (honoring received PAUSE frames) is handled at the MAC level
by the PF and requires no VF PMD changes.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 doc/guides/nics/features/enetc4.ini    |  1 +
 doc/guides/rel_notes/release_26_11.rst |  1 +
 drivers/net/enetc/base/enetc_hw.h      |  1 +
 drivers/net/enetc/enetc.h              | 11 ++++-
 drivers/net/enetc/enetc4_ethdev.c      | 15 ++++++-
 drivers/net/enetc/enetc4_vf.c          | 60 ++++++++++++++++++++++++--
 6 files changed, 83 insertions(+), 6 deletions(-)

diff --git a/doc/guides/nics/features/enetc4.ini b/doc/guides/nics/features/enetc4.ini
index 01b0dc5b80..1f599dace7 100644
--- a/doc/guides/nics/features/enetc4.ini
+++ b/doc/guides/nics/features/enetc4.ini
@@ -14,6 +14,7 @@ Promiscuous mode     = Y
 Allmulticast mode    = Y
 Unicast MAC filter   = Y
 VLAN filter          = Y
+Flow control         = Y
 VLAN offload         = Y
 RSS hash             = Y
 Packet type parsing  = Y
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 47090068d0..f287390db7 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -74,6 +74,7 @@ New Features
   * Added per-queue MSI-X Rx interrupt support for the ENETC4 VF.
   * Added SI-based port VLAN insertion (Tx) and removal (Rx) for ENETC4 PF and VF.
   * Updated ENETC4 VF link status reporting to use bitmask encoding.
+  * Added Tx PAUSE support for the ENETC4 VF via Rx congestion mode.
 
 Removed Items
 -------------
diff --git a/drivers/net/enetc/base/enetc_hw.h b/drivers/net/enetc/base/enetc_hw.h
index 6e96562850..33d075fe59 100644
--- a/drivers/net/enetc/base/enetc_hw.h
+++ b/drivers/net/enetc/base/enetc_hw.h
@@ -51,6 +51,7 @@ enum enetc_bdr_type {TX, RX};
 							+ (off))
 /* RX BDR reg offsets */
 #define ENETC_RBMR		0x0 /* RX BDR mode register*/
+#define ENETC_RBMR_CM		BIT(4)  /* congestion mode: assert congestion to emit TX PAUSE */
 #define ENETC_RBMR_EN		BIT(31)
 
 #define ENETC_BMR_RESET		0x0 /* BDR reset*/
diff --git a/drivers/net/enetc/enetc.h b/drivers/net/enetc/enetc.h
index 4ad6af777b..7f67b2a0b3 100644
--- a/drivers/net/enetc/enetc.h
+++ b/drivers/net/enetc/enetc.h
@@ -6,6 +6,7 @@
 #define _ENETC_H_
 
 #include <pthread.h>
+#include <rte_stdatomic.h>
 #include <rte_time.h>
 #include <ethdev_pci.h>
 
@@ -141,6 +142,11 @@ struct enetc_eth_hw {
 	 */
 	uint8_t vf_link_legacy;
 	pthread_mutex_t vsi_lock; /* serializes all VSI-PSI mailbox transactions */
+	/* 1 = TX PAUSE negotiated on port; VF RX rings must have RBMR_CM set.
+	 * Updated from the PF-to-VF link status mailbox message (BIT(1)).
+	 * Written on the interrupt thread, read on the control thread.
+	 */
+	RTE_ATOMIC(uint8_t)tx_pause_active;
 	/* Baseline snapshot for VF stats reset (software delta approach). */
 	struct enetc4_vf_stats_saved vf_stats_saved;
 };
@@ -239,8 +245,11 @@ enum vlan_status {
 
 /* Link status bitmask in PF-to-VF mailbox notification.
  * Link up is encoded as the DOWN bit being clear.
+ * TX_PAUSE is set when the port has negotiated TX PAUSE; VF must enable
+ * congestion mode (ENETC_RBMR_CM) on its RX rings accordingly.
  */
-#define ENETC_LINK_DOWN  (1u << 0)
+#define ENETC_LINK_DOWN      (1u << 0)
+#define ENETC_LINK_TX_PAUSE  (1u << 1)
 
 enum speed {
 	ENETC_SPEED_UNKNOWN = 0x0,
diff --git a/drivers/net/enetc/enetc4_ethdev.c b/drivers/net/enetc/enetc4_ethdev.c
index 59632cc790..df22ad0c7b 100644
--- a/drivers/net/enetc/enetc4_ethdev.c
+++ b/drivers/net/enetc/enetc4_ethdev.c
@@ -714,8 +714,13 @@ enetc4_rx_queue_setup(struct rte_eth_dev *dev,
 	}
 
 	if (!rx_conf->rx_deferred_start) {
-		/* enable ring */
+		/* Enable ring; apply congestion mode if TX PAUSE is already active. */
 		rx_enable |= ENETC_RBMR_EN;
+		if (rte_atomic_load_explicit(&adapter->hw.tx_pause_active,
+					     rte_memory_order_acquire))
+			rx_enable |= ENETC_RBMR_CM;
+		else
+			rx_enable &= ~(uint32_t)ENETC_RBMR_CM;
 		enetc4_rxbdr_wr(&adapter->hw.hw, rx_ring->index, ENETC_RBMR,
 			       rx_enable);
 		dev->data->rx_queue_state[rx_ring->index] =
@@ -1092,7 +1097,13 @@ enetc4_rx_queue_start(struct rte_eth_dev *dev, uint16_t qidx)
 	if (dev->data->rx_queue_state[qidx] == RTE_ETH_QUEUE_STATE_STOPPED) {
 		rx_data = enetc4_rxbdr_rd(&priv->hw.hw, rx_ring->index,
 					 ENETC_RBMR);
-		rx_data = rx_data | ENETC_RBMR_EN;
+		rx_data |= ENETC_RBMR_EN;
+		/* Restore congestion mode if TX PAUSE is active. */
+		if (rte_atomic_load_explicit(&priv->hw.tx_pause_active,
+					     rte_memory_order_acquire))
+			rx_data |= ENETC_RBMR_CM;
+		else
+			rx_data &= ~(uint32_t)ENETC_RBMR_CM;
 		enetc4_rxbdr_wr(&priv->hw.hw, rx_ring->index, ENETC_RBMR,
 			       rx_data);
 		dev->data->rx_queue_state[qidx] = RTE_ETH_QUEUE_STATE_STARTED;
diff --git a/drivers/net/enetc/enetc4_vf.c b/drivers/net/enetc/enetc4_vf.c
index af196900cb..7155a60ad7 100644
--- a/drivers/net/enetc/enetc4_vf.c
+++ b/drivers/net/enetc/enetc4_vf.c
@@ -491,6 +491,38 @@ enetc4_decode_link_speed(uint8_t status, bool vf_link_legacy,
 	}
 }
 
+/*
+ * Set or clear ENETC_RBMR_CM (congestion mode) on all active VF RX rings.
+ * When set, the ring signals congestion to the MAC, causing it to emit TX
+ * PAUSE frames on ingress pressure. hw->tx_pause_active is updated so rings
+ * started later inherit the correct state.
+ */
+static void
+enetc4_vf_set_congestion_mode(struct rte_eth_dev *eth_dev, bool enable)
+{
+	struct enetc_eth_hw *hw =
+		ENETC_DEV_PRIVATE_TO_HW(eth_dev->data->dev_private);
+	struct enetc_hw *enetc_hw = &hw->hw;
+	uint16_t nb_rx = eth_dev->data->nb_rx_queues;
+	uint16_t i;
+	uint32_t rbmr;
+
+	rte_atomic_store_explicit(&hw->tx_pause_active, enable ? 1 : 0,
+				  rte_memory_order_release);
+
+	for (i = 0; i < nb_rx; i++) {
+		rbmr = enetc4_rxbdr_rd(enetc_hw, i, ENETC_RBMR);
+		if (enable)
+			rbmr |= ENETC_RBMR_CM;
+		else
+			rbmr &= ~(uint32_t)ENETC_RBMR_CM;
+		enetc4_rxbdr_wr(enetc_hw, i, ENETC_RBMR, rbmr);
+	}
+
+	ENETC_PMD_DEBUG("VF congestion mode %s on %u RX rings",
+			enable ? "enabled" : "disabled", nb_rx);
+}
+
 static void
 enetc4_process_psi_msg(struct rte_eth_dev *eth_dev, struct enetc_hw *enetc_hw)
 {
@@ -498,6 +530,7 @@ enetc4_process_psi_msg(struct rte_eth_dev *eth_dev, struct enetc_hw *enetc_hw)
 		ENETC_DEV_PRIVATE_TO_HW(eth_dev->data->dev_private);
 	struct enetc_psi_reply_msg *msg;
 	struct rte_eth_link link;
+	bool tx_pause;
 	int ret = 0;
 
 	msg = rte_zmalloc(NULL, sizeof(*msg), RTE_CACHE_LINE_SIZE);
@@ -513,9 +546,24 @@ enetc4_process_psi_msg(struct rte_eth_dev *eth_dev, struct enetc_hw *enetc_hw)
 		if (msg->status & ENETC_LINK_DOWN) {
 			ENETC_PMD_DEBUG("Link is down");
 			link.link_status = RTE_ETH_LINK_DOWN;
+			/* Clear congestion mode on link-down so VF rings do not
+			 * assert congestion while the port is offline.
+			 */
+			enetc4_vf_set_congestion_mode(eth_dev, false);
 		} else {
-			ENETC_PMD_DEBUG("Link is up");
+			/* BIT(1) is set when the port has negotiated TX PAUSE.
+			 * Legacy PF does not set this bit so tx_pause stays false.
+			 */
+			tx_pause = !!(msg->status & ENETC_LINK_TX_PAUSE);
+			ENETC_PMD_DEBUG("Link is up, tx_pause=%d", tx_pause);
 			link.link_status = RTE_ETH_LINK_UP;
+
+			/* Apply congestion mode before raising the carrier so
+			 * the VF rings are ready to emit PAUSE before traffic
+			 * starts flowing.
+			 */
+			enetc4_vf_set_congestion_mode(eth_dev, tx_pause);
+
 			/* Re-query speed from PF so the cached value reflects
 			 * the current negotiated speed after link-up.
 			 */
@@ -1205,10 +1253,16 @@ enetc4_vf_link_update(struct rte_eth_dev *dev, int wait_to_complete __rte_unused
 	}
 
 	if (reply_msg->class_id == ENETC_CLASS_ID_LINK_STATUS) {
-		if (reply_msg->status & ENETC_LINK_DOWN)
+		if (reply_msg->status & ENETC_LINK_DOWN) {
 			link.link_status = RTE_ETH_LINK_DOWN;
-		else
+			/* Link is down: disable congestion mode on all RX rings. */
+			enetc4_vf_set_congestion_mode(dev, false);
+		} else {
 			link.link_status = RTE_ETH_LINK_UP;
+			/* Restore congestion mode from the TX PAUSE bit. */
+			enetc4_vf_set_congestion_mode(dev,
+				!!(reply_msg->status & ENETC_LINK_TX_PAUSE));
+		}
 	} else {
 		ENETC_PMD_ERR("Wrong reply message");
 		return -1;
-- 
2.25.1

