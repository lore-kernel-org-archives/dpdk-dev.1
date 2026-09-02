Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D66C61DD6
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Sep 2026 05:51:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82C1E4042E;
	Wed,  2 Sep 2026 07:51:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 054BE4042E
 for <dev@dpdk.org>; Wed,  2 Sep 2026 07:51:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788328310; x=1819864310;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2XLpu+cfldn+1kiRHtv/bqx4J2Q+bXV7ufQTt4yg9GU=;
 b=QBcRP/LtnS2/UPpSwfwPJhmDqxpEzQoSYPnXzTetC2xBvYzTb/42cf12
 zHMqKc5vkmkWGm3mu4r12GnQKNKaWBzidCFPxVgdw7xHsQ+cSHtS7KqX0
 qFmL4gRtmIOCovHlbjf91GRBds2Yjfejy7lQUfZBaPPkPqiUvqT47UBId
 BLifhpI7YckcBW1u0EKcOKpRBPvPz//RV+NzVN6brJN4Eh11AY5vtyIOX
 31QVZmxXpWc0FrT/mmWbyGPtPC+FiE6tpAAis4YHlwycebCFQcEcG0iKw
 LN5G64cgLR/hxayG9ATO/Y5JS9WYERcUtOP8jeuyCUM7Hbe38ADDVCSXB Q==;
X-CSE-ConnectionGUID: jpe/8CObRU29t7s7pbQctQ==
X-CSE-MsgGUID: EmAKcZd9RsCukM0of8dgEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="88624819"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="88624819"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 22:51:50 -0700
X-CSE-ConnectionGUID: y7QncFWJRtCMUk20GmMmsA==
X-CSE-MsgGUID: Xx/Kz6ZQSvmp4tmc4tsddg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="267538607"
Received: from unknown (HELO icx008-fc43.iind.intel.com) ([10.190.212.196])
 by orviesa006.jf.intel.com with ESMTP; 01 Sep 2026 22:51:47 -0700
From: Rajesh Kumar <rajesh3.kumar@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andrew.rybchenko@oktetlabs.ru, stephen@networkplumber.org,
 aman.deep.singh@intel.com, Rajesh Kumar <rajesh3.kumar@intel.com>
Subject: [RFC PATCH v4 2/3] net/ice: support per-packet Tx timestamp slots
Date: Wed,  2 Sep 2026 11:21:23 +0530
Message-ID: <20260902055125.836268-3-rajesh3.kumar@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902055125.836268-1-rajesh3.kumar@intel.com>
References: <20260827122200.339388-2-rajesh3.kumar@intel.com>
 <20260902055125.836268-1-rajesh3.kumar@intel.com>
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

The ice PHY provides 64 Tx timestamp slots per port, but the driver only
ever used a single static slot (ptp_tx_index), which limits PTP Tx
timestamping to one in-flight packet at a time.

Implement the ethdev Tx timestamp slot management ops on top of an atomic
per-adapter slot bitmap:

 - timesync_tx_ts_get_capabilities reports the per-packet slot type and
   the number of slots,
 - timesync_tx_timestamp_slot_alloc reserves a free slot using a
   compare-exchange loop; on E822 the 64 quad slots are split evenly
   between the PFs sharing the quad so allocations never overlap,
 - timesync_read_tx_timestamp_slot polls the PHY ready bitmap for the
   given slot and returns the adjusted timestamp,
 - timesync_tx_timestamp_slot_release clears the PHY timestamp (E810)
   and frees the bitmap bit.

The Tx context descriptor now takes the timestamp index from the mbuf
dynamic field registered by the ethdev layer when the packet carries the
Tx timestamp slot dynamic flag, and falls back to the legacy static index
otherwise.

While at it, make the legacy single-slot read path use ptp_tx_index
instead of a hardcoded slot 0, and clear the PHY timestamp on E810 after
a read or a timeout so a stale entry cannot block later requests.

Signed-off-by: Rajesh Kumar <rajesh3.kumar@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 210 ++++++++++++++++++++++++++++-
 drivers/net/intel/ice/ice_ethdev.h |   2 +
 drivers/net/intel/ice/ice_rxtx.c   |  11 +-
 3 files changed, 220 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 76b8ff0a72..0109dc2621 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -196,6 +196,14 @@ static int ice_timesync_read_rx_timestamp(struct rte_eth_dev *dev,
 					  uint32_t flags);
 static int ice_timesync_read_tx_timestamp(struct rte_eth_dev *dev,
 					  struct timespec *timestamp);
+static int ice_timesync_tx_timestamp_slot_alloc(struct rte_eth_dev *dev,
+						uint32_t *slot_id);
+static int ice_timesync_tx_ts_get_capabilities(struct rte_eth_dev *dev,
+					       struct rte_eth_timesync_tx_ts_caps *caps);
+static int ice_timesync_read_tx_timestamp_slot(struct rte_eth_dev *dev, uint32_t slot_id,
+		struct rte_eth_timesync_dual_domain_timestamp *timestamp);
+static int ice_timesync_tx_timestamp_slot_release(struct rte_eth_dev *dev,
+						  uint32_t slot_id);
 static int ice_timesync_adjust_time(struct rte_eth_dev *dev, int64_t delta);
 static int ice_timesync_adjust_freq(struct rte_eth_dev *dev, int64_t ppm);
 static int ice_timesync_read_time(struct rte_eth_dev *dev,
@@ -340,6 +348,10 @@ static const struct eth_dev_ops ice_eth_dev_ops = {
 	.timesync_enable              = ice_timesync_enable,
 	.timesync_read_rx_timestamp   = ice_timesync_read_rx_timestamp,
 	.timesync_read_tx_timestamp   = ice_timesync_read_tx_timestamp,
+	.timesync_tx_timestamp_slot_alloc = ice_timesync_tx_timestamp_slot_alloc,
+	.timesync_tx_ts_get_capabilities  = ice_timesync_tx_ts_get_capabilities,
+	.timesync_read_tx_timestamp_slot  = ice_timesync_read_tx_timestamp_slot,
+	.timesync_tx_timestamp_slot_release = ice_timesync_tx_timestamp_slot_release,
 	.timesync_adjust_time         = ice_timesync_adjust_time,
 	.timesync_adjust_freq         = ice_timesync_adjust_freq,
 	.timesync_read_time           = ice_timesync_read_time,
@@ -7157,6 +7169,188 @@ static int ice_ptp_write_init(struct ice_hw *hw)
 	return ice_ptp_init_time(hw, ns, true);
 }
 
+/*
+ * Allocate one TX timestamp slot from the per-port 64-slot bitmap using CAS.
+ * Returns slot index [0..max-1] or -ENOSPC if all slots are taken.
+ * For E822, max is capped so PFs sharing a quad use non-overlapping ranges.
+ */
+static int
+ice_ptp_alloc_tx_slot(struct ice_adapter *ad)
+{
+	uint64_t old, new_bm, range_mask, free_in_range;
+	uint8_t slot, max_slots, base_slot;
+	bool swapped;
+
+	/*
+	 * E822: multiple PFs share one quad's 64 slots.
+	 * Divide evenly: each PF occupies (64 / ports_per_quad) slots starting
+	 * at (pf_offset_in_quad * slots_per_pf).
+	 */
+	if (ad->hw.phy_model == ICE_PHY_E822) {
+		uint8_t ppq = ICE_PORTS_PER_QUAD;
+		uint8_t slots_per_pf = 64 / ppq;
+		uint8_t pf_offset = ad->hw.pf_id % ppq;
+
+		base_slot = pf_offset * slots_per_pf;
+		max_slots = slots_per_pf;
+	} else {
+		/* E810, E830, ETH56G: full 64 slots per PF BAR / per lport */
+		base_slot = 0;
+		max_slots = 64;
+	}
+
+	range_mask = (max_slots == 64) ? UINT64_MAX :
+		     (((uint64_t)1 << max_slots) - 1) << base_slot;
+
+	do {
+		old = rte_atomic_load_explicit(&ad->ts_slot_bitmap,
+					       rte_memory_order_relaxed);
+		free_in_range = ~old & range_mask;
+		if (free_in_range == 0)
+			return -ENOSPC;
+
+		slot = (uint8_t)rte_ctz64(free_in_range);
+		new_bm = old | RTE_BIT64(slot);
+		swapped = rte_atomic_compare_exchange_weak_explicit(&ad->ts_slot_bitmap,
+				&old, new_bm, rte_memory_order_acquire,
+				rte_memory_order_relaxed);
+	} while (!swapped);
+	return slot;
+}
+
+/* Release a TX timestamp slot back to the bitmap. */
+static void
+ice_ptp_release_tx_slot(struct ice_adapter *ad, uint8_t slot)
+{
+	rte_atomic_fetch_and_explicit(&ad->ts_slot_bitmap, ~RTE_BIT64(slot),
+				      rte_memory_order_release);
+}
+
+/* Allocate a TX timestamp slot from the per-port bitmap for the per-packet slot API. */
+static int
+ice_get_next_tx_desc_idx(struct rte_eth_dev *dev)
+{
+	struct ice_adapter *ad;
+	int slot;
+
+	if (dev == NULL)
+		return -EINVAL;
+
+	ad = ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
+	slot = ice_ptp_alloc_tx_slot(ad);
+	if (slot < 0) {
+		PMD_DRV_LOG(DEBUG, "PTP TX: all 64 timestamp slots busy");
+		return slot;
+	}
+
+	/*
+	 * Do NOT update ptp_tx_index: that field belongs to the legacy
+	 * single-inflight path and is set statically in ice_ptp_init_info().
+	 */
+	return slot;
+}
+
+static int
+ice_ptp_read_tx_dual_timestamp(struct rte_eth_dev *dev, uint8_t slot,
+			       struct rte_eth_timesync_dual_domain_timestamp *dual)
+{
+	struct ice_adapter *ad;
+	struct ice_hw *hw;
+	uint64_t tstamp_ready, tstamp, adjusted_ns;
+	int ret;
+
+	if (dev == NULL || dual == NULL)
+		return -EINVAL;
+
+	ad = ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
+	hw = ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+
+	ret = ice_get_phy_tx_tstamp_ready(hw, ad->ptp_tx_block, &tstamp_ready);
+	if (ret)
+		return -EAGAIN;
+
+	if (!(tstamp_ready & RTE_BIT64(slot)))
+		return -EAGAIN;
+
+	ret = ice_read_phy_tstamp(hw, ad->ptp_tx_block, slot, &tstamp);
+	if (ret || tstamp == 0)
+		return -EAGAIN;
+
+	adjusted_ns = ice_tstamp_convert_32b_64b(hw, ad, 1,
+			(tstamp >> 8) & 0xFFFFFFFF);
+
+	dual->adjusted_ns = (int64_t)adjusted_ns;
+	dual->raw_ns = 0;
+	dual->valid_mask = RTE_ETH_TIMESYNC_DUAL_DOMAIN_TIMESTAMP_ADJUSTED_VALID;
+
+	return 0;
+}
+
+static void
+ice_ptp_free_tx_slot(struct rte_eth_dev *dev, uint8_t slot)
+{
+	struct ice_adapter *ad;
+	struct ice_hw *hw;
+
+	if (dev == NULL)
+		return;
+
+	ad = ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
+	hw = ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+
+	if (hw->phy_model == ICE_PHY_E810)
+		(void)ice_clear_phy_tstamp(hw, ad->ptp_tx_block, slot);
+	ice_ptp_release_tx_slot(ad, slot);
+}
+
+static int
+ice_timesync_tx_ts_get_capabilities(struct rte_eth_dev *dev __rte_unused,
+				    struct rte_eth_timesync_tx_ts_caps *caps)
+{
+	caps->type = RTE_ETH_TIMESYNC_TX_TS_PER_PACKET;
+	caps->max_slots = 64;
+	return 0;
+}
+
+static int
+ice_timesync_tx_timestamp_slot_alloc(struct rte_eth_dev *dev,
+				     uint32_t *slot_id)
+{
+	int idx;
+
+	if (dev == NULL || slot_id == NULL)
+		return -EINVAL;
+
+	idx = ice_get_next_tx_desc_idx(dev);
+	if (idx < 0)
+		return idx;
+
+	*slot_id = (uint32_t)(uint16_t)idx;
+	return 0;
+}
+
+static int
+ice_timesync_read_tx_timestamp_slot(struct rte_eth_dev *dev, uint32_t slot_id,
+		struct rte_eth_timesync_dual_domain_timestamp *timestamp)
+{
+	if (dev == NULL || timestamp == NULL || slot_id > 63)
+		return -EINVAL;
+
+	memset(timestamp, 0, sizeof(*timestamp));
+
+	return ice_ptp_read_tx_dual_timestamp(dev, (uint8_t)slot_id, timestamp);
+}
+
+static int
+ice_timesync_tx_timestamp_slot_release(struct rte_eth_dev *dev, uint32_t slot_id)
+{
+	if (dev == NULL || slot_id > 63)
+		return -EINVAL;
+
+	ice_ptp_free_tx_slot(dev, (uint8_t)slot_id);
+	return 0;
+}
+
 static int
 ice_timesync_enable(struct rte_eth_dev *dev)
 {
@@ -7239,6 +7433,11 @@ ice_timesync_read_tx_timestamp(struct rte_eth_dev *dev,
 	/* Set the end time with a delay of 10 microseconds */
 	end_time = rte_get_timer_cycles() + (rte_get_timer_hz() / 100000);
 
+	/*
+	 * ptp_tx_index is a static slot set in ice_ptp_init_info(); it is NOT
+	 * allocated via ice_ptp_alloc_tx_slot() so the bitmap must not be
+	 * touched.
+	 */
 	do {
 		ret = ice_get_phy_tx_tstamp_ready(hw, ad->ptp_tx_block, &tstamp_ready);
 		if (ret) {
@@ -7246,11 +7445,15 @@ ice_timesync_read_tx_timestamp(struct rte_eth_dev *dev,
 			return -1;
 		}
 
-		if ((tstamp_ready & BIT_ULL(0)) == 0 && rte_get_timer_cycles() > end_time) {
+		if (!(tstamp_ready & BIT_ULL(ad->ptp_tx_index)) &&
+		    rte_get_timer_cycles() > end_time) {
 			PMD_DRV_LOG(ERR, "Timeout to get phy ready for timestamp");
+			if (hw->phy_model == ICE_PHY_E810)
+				(void)ice_clear_phy_tstamp(hw, ad->ptp_tx_block,
+							   ad->ptp_tx_index);
 			return -1;
 		}
-	} while ((tstamp_ready & BIT_ULL(0)) == 0);
+	} while (!(tstamp_ready & BIT_ULL(ad->ptp_tx_index)));
 
 	ret = ice_read_phy_tstamp(hw, ad->ptp_tx_block, ad->ptp_tx_index, &tstamp);
 	if (ret || tstamp == 0) {
@@ -7261,6 +7464,9 @@ ice_timesync_read_tx_timestamp(struct rte_eth_dev *dev,
 	ts_ns = ice_tstamp_convert_32b_64b(hw, ad, 1, (tstamp >> 8) & mask);
 	*timestamp = rte_ns_to_timespec(ts_ns);
 
+	if (hw->phy_model == ICE_PHY_E810)
+		(void)ice_clear_phy_tstamp(hw, ad->ptp_tx_block, ad->ptp_tx_index);
+
 	return 0;
 }
 
diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index 7ee3ea8a70..d5fed14fae 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -684,6 +684,8 @@ struct ice_adapter {
 	/* For PTP */
 	uint8_t ptp_tx_block;
 	uint8_t ptp_tx_index;
+	/* Atomic bitmask of in-use TX timestamp slots (bit N = slot N occupied). */
+	RTE_ATOMIC(uint64_t)ts_slot_bitmap;
 	bool ptp_ena;
 	bool txpp_ena;	/* For TxPP */
 	uint64_t time_hw;
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index c4b5454c53..25e51099e5 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -3038,10 +3038,19 @@ get_context_desc(uint64_t ol_flags, const struct rte_mbuf *tx_pkt,
 	const union ci_tx_offload *tx_offload, const struct ci_tx_queue *txq,
 	uint64_t *qw0, uint64_t *qw1)
 {
+	const struct rte_eth_timesync_tx_slot_info *ts_info;
 	uint16_t cd_l2tag2 = 0;
 	uint64_t cd_type_cmd_tso_mss = ICE_TX_DESC_DTYPE_CTX;
 	uint32_t cd_tunneling_params = 0;
-	uint64_t ptp_tx_index = txq->ice_vsi->adapter->ptp_tx_index;
+	uint64_t ptp_tx_index;
+
+	/* A zero dynflag means the port is not using per-packet slots. */
+	ts_info = rte_eth_timesync_tx_slot_info_get(txq->port_id);
+	if (ol_flags & ts_info->dynflag)
+		ptp_tx_index = *RTE_MBUF_DYNFIELD(tx_pkt, ts_info->offset,
+				uint32_t *);
+	else
+		ptp_tx_index = txq->ice_vsi->adapter->ptp_tx_index;
 
 	if (ice_calc_context_desc(ol_flags) == 0)
 		return 0;
-- 
2.55.0

