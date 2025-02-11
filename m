Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0C5C0219D
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 08:51:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA8B24066F;
	Tue, 11 Feb 2025 09:51:00 +0100 (CET)
Received: from localhost.localdomain (unknown [103.233.162.252])
 by mails.dpdk.org (Postfix) with ESMTP id 2753040650
 for <dev@dpdk.org>; Tue, 11 Feb 2025 09:50:55 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id 5B97AA3EE5; Tue, 11 Feb 2025 16:50:31 +0800 (CST)
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net,
	Wenbo Cao <caowenbo@mucse.com>
Cc: stephen@networkplumber.org, dev@dpdk.org, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, yaojun@mucse.com
Subject: [PATCH v9 08/28] net/rnp: add queue setup and release operations
Date: Tue, 11 Feb 2025 16:49:58 +0800
Message-Id: <1739263818-59770-9-git-send-email-caowenbo@mucse.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739263818-59770-1-git-send-email-caowenbo@mucse.com>
References: <1739263818-59770-1-git-send-email-caowenbo@mucse.com>
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

support tx/rx queue setup and release add hw bd
queue reset,sw queue reset.

Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
---
 doc/guides/nics/rnp.rst             |   1 +
 drivers/net/rnp/base/meson.build    |   1 +
 drivers/net/rnp/base/rnp_bdq_if.c   | 398 +++++++++++++++++++++++
 drivers/net/rnp/base/rnp_bdq_if.h   | 149 +++++++++
 drivers/net/rnp/base/rnp_common.h   |   4 +
 drivers/net/rnp/base/rnp_dma_regs.h |  45 +++
 drivers/net/rnp/base/rnp_eth_regs.h |   4 +
 drivers/net/rnp/base/rnp_hw.h       |   3 +
 drivers/net/rnp/base/rnp_osdep.h    |  13 +
 drivers/net/rnp/meson.build         |   1 +
 drivers/net/rnp/rnp.h               |   2 +
 drivers/net/rnp/rnp_ethdev.c        |  38 ++-
 drivers/net/rnp/rnp_rxtx.c          | 476 ++++++++++++++++++++++++++++
 drivers/net/rnp/rnp_rxtx.h          | 123 +++++++
 14 files changed, 1257 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/rnp/base/rnp_bdq_if.c
 create mode 100644 drivers/net/rnp/base/rnp_bdq_if.h
 create mode 100644 drivers/net/rnp/rnp_rxtx.c
 create mode 100644 drivers/net/rnp/rnp_rxtx.h

diff --git a/doc/guides/nics/rnp.rst b/doc/guides/nics/rnp.rst
index 910c2b40eb..8bce5028b6 100644
--- a/doc/guides/nics/rnp.rst
+++ b/doc/guides/nics/rnp.rst
@@ -10,6 +10,7 @@ driver support for the inbuilt network device found in the **Mucse RNP**
 Features
 --------
 
+- Multiple queues for TX and RX
 - Promiscuous mode
 
 Prerequisites
diff --git a/drivers/net/rnp/base/meson.build b/drivers/net/rnp/base/meson.build
index b9db033ff6..c2ef0d05be 100644
--- a/drivers/net/rnp/base/meson.build
+++ b/drivers/net/rnp/base/meson.build
@@ -7,6 +7,7 @@ sources = [
         'rnp_mbx_fw.c',
         'rnp_common.c',
         'rnp_mac.c',
+	'rnp_bdq_if.c',
 ]
 
 error_cflags = ['-Wno-unused-value',
diff --git a/drivers/net/rnp/base/rnp_bdq_if.c b/drivers/net/rnp/base/rnp_bdq_if.c
new file mode 100644
index 0000000000..471c19efda
--- /dev/null
+++ b/drivers/net/rnp/base/rnp_bdq_if.c
@@ -0,0 +1,398 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2023 Mucse IC Design Ltd.
+ */
+
+#include "rnp_osdep.h"
+
+#include "../rnp.h"
+#include "rnp_dma_regs.h"
+#include "rnp_eth_regs.h"
+#include "rnp_bdq_if.h"
+#include "rnp_common.h"
+#include "../rnp_rxtx.h"
+
+static void
+rnp_read_mac_veb(struct rnp_hw *hw,
+		  u16 nr_lane,
+		  u16 vf_id,
+		  struct rnp_veb_cfg *cfg)
+{
+	cfg->mac_lo = RNP_E_REG_RD(hw, RNP_VEB_MAC_LO(nr_lane, vf_id));
+	cfg->mac_hi = RNP_E_REG_RD(hw, RNP_VEB_MAC_HI(nr_lane, vf_id));
+	cfg->ring = RNP_E_REG_RD(hw, RNP_VEB_VF_RING(nr_lane, vf_id));
+}
+
+static void
+rnp_update_mac_veb(struct rnp_hw *hw,
+		   u16 nr_lane,
+		   u16 vf_id,
+		   struct rnp_veb_cfg *cfg)
+{
+	u32 reg = cfg->ring;
+	u16 idx = 0;
+
+	idx = nr_lane;
+	wmb();
+	RNP_E_REG_WR(hw, RNP_VEB_MAC_LO(idx, vf_id), cfg->mac_lo);
+	RNP_E_REG_WR(hw, RNP_VEB_MAC_HI(idx, vf_id), cfg->mac_hi);
+	reg |= ((RNP_VEB_SWITCH_VF_EN | vf_id) << 8);
+	RNP_E_REG_WR(hw, RNP_VEB_VF_RING(idx, vf_id), reg);
+}
+
+void
+rnp_rxq_flow_disable(struct rnp_hw *hw,
+		     u16 hw_idx)
+{
+	u32 fc_ctrl;
+
+	spin_lock(&hw->rxq_reset_lock);
+	fc_ctrl = RNP_E_REG_RD(hw, RNP_RING_FC_EN(hw_idx));
+	wmb();
+	RNP_E_REG_WR(hw, RNP_RING_FC_THRESH(hw_idx), 0);
+	fc_ctrl |= 1 << (hw_idx % 32);
+	wmb();
+	RNP_E_REG_WR(hw, RNP_RING_FC_EN(hw_idx), fc_ctrl);
+}
+
+void
+rnp_rxq_flow_enable(struct rnp_hw *hw,
+		    u16 hw_idx)
+{
+	u32 fc_ctrl;
+
+
+	fc_ctrl = RNP_E_REG_RD(hw, RNP_RING_FC_EN(hw_idx));
+	fc_ctrl &= ~(1 << (hw_idx % 32));
+	wmb();
+	RNP_E_REG_WR(hw, RNP_RING_FC_EN(hw_idx), fc_ctrl);
+
+	spin_unlock(&hw->rxq_reset_lock);
+}
+
+#define RNP_RXQ_RESET_PKT_LEN	(64)
+
+static void
+rnp_reset_xmit(struct rnp_tx_queue *txq, u64 pkt_addr)
+{
+	volatile struct rnp_tx_desc *txbd;
+	struct rnp_txsw_entry *tx_entry;
+	u16 timeout = 0;
+	u16 tx_id;
+
+	tx_id = txq->tx_tail;
+	txbd = &txq->tx_bdr[tx_id];
+	tx_entry = &txq->sw_ring[tx_id];
+	memset(tx_entry, 0, sizeof(*tx_entry));
+
+	txbd->d.addr = pkt_addr;
+	txbd->d.blen = RNP_RXQ_RESET_PKT_LEN;
+	wmb();
+	txbd->d.cmd = cpu_to_le16(RNP_CMD_EOP | RNP_CMD_RS);
+	tx_id = (tx_id + 1) & txq->attr.nb_desc_mask;
+	wmb();
+	RNP_REG_WR(txq->tx_tailreg, 0, tx_id);
+	do {
+		if (txbd->d.cmd & RNP_CMD_DD)
+			break;
+		if (timeout == 1000)
+			RNP_PMD_ERR("rx queue %u reset send pkt is hang",
+					txq->attr.index);
+		timeout++;
+		udelay(10);
+	} while (1);
+}
+
+void
+rnp_reset_hw_rxq_op(struct rnp_hw *hw,
+		    struct rnp_rx_queue *rxq,
+		    struct rnp_tx_queue *txq,
+		    struct rnp_rxq_reset_res *res)
+{
+	u8 reset_pcap[RNP_RXQ_RESET_PKT_LEN] = {
+		0x01, 0x02, 0x27, 0xe2, 0x9f, 0xa6, 0x08, 0x00,
+		0x27, 0xfc, 0x6a, 0xc9, 0x08, 0x00, 0x45, 0x00,
+		0x01, 0xc4, 0xb5, 0xd0, 0x00, 0x7a, 0x40, 0x01,
+		0xbc, 0xea, 0x02, 0x01, 0x01, 0x02, 0x02, 0x01,
+		0x01, 0x01, 0xc8, 0xc9, 0xca, 0xcb, 0xcc, 0xcd,
+		0xce, 0xcf, 0xd0, 0xd1, 0xd2, 0xd3, 0xd4, 0xd5,
+		0xd6, 0xd7, 0xd8, 0xd9, 0xda, 0xdb, 0xdc, 0xdd,
+		0xde, 0xdf, 0xe0, 0xe1, 0xe2, 0xe3, 0xe4, 0xe5};
+	struct rnp_veb_cfg veb_bak_cfg[RNP_MAX_PORT_OF_PF];
+	struct rnp_veb_cfg reset_cfg = {0};
+	volatile struct rnp_rx_desc *rxbd;
+	u16 index = rxq->attr.index;
+	u16 vf_num = hw->mbx.vf_num;
+	u8 *macaddr = res->eth_hdr;
+	u16 timeout = 0;
+	u16 vf_id = 0;
+	u16 head = 0;
+	u16 idx = 0;
+
+	memcpy(macaddr, reset_pcap, RNP_RXQ_RESET_PKT_LEN);
+	macaddr[5] = index;
+	reset_cfg.mac_hi = RNP_GET_MAC_HI(macaddr);
+	reset_cfg.mac_lo = RNP_GET_MAC_LO(macaddr);
+	reset_cfg.ring = index;
+	vf_id = (vf_num != UINT16_MAX) ? vf_num : index / 2;
+	if (hw->mbx.vf_num == UINT16_MAX) {
+		for (idx = 0; idx < RNP_MAX_PORT_OF_PF; idx++) {
+			rnp_read_mac_veb(hw, idx, vf_id, &veb_bak_cfg[idx]);
+			rnp_update_mac_veb(hw, idx, vf_id, &reset_cfg);
+		}
+	} else {
+		idx = rxq->attr.lane_id;
+		rnp_read_mac_veb(hw, idx, vf_id, &veb_bak_cfg[idx]);
+		rnp_update_mac_veb(hw, idx, vf_id, &reset_cfg);
+	}
+	wmb();
+	timeout = 0;
+	do {
+		if (!RNP_E_REG_RD(hw, RNP_RXQ_READY(index)))
+			break;
+		udelay(5);
+		timeout++;
+	} while (timeout < 100);
+	timeout = 0;
+	do {
+		if (RNP_E_REG_RD(hw, RNP_TXQ_READY(index)))
+			break;
+		udelay(10);
+		timeout++;
+	} while (timeout < 100);
+	rxq->rx_tail = RNP_E_REG_RD(hw, RNP_RXQ_HEAD(index));
+	rxbd = &rxq->rx_bdr[rxq->rx_tail];
+	rxbd->d.pkt_addr = res->rx_pkt_addr;
+	if (rxq->rx_tail != rxq->attr.nb_desc_mask)
+		RNP_E_REG_WR(hw, RNP_RXQ_LEN(index), rxq->rx_tail + 1);
+	wmb();
+	RNP_REG_WR(rxq->rx_tailreg, 0, 0);
+	RNP_E_REG_WR(hw, RNP_RXQ_START(index), TRUE);
+	rnp_reset_xmit(txq, res->tx_pkt_addr);
+	timeout = 0;
+	do {
+		if (rxbd->wb.qword1.cmd & cpu_to_le32(RNP_CMD_DD))
+			break;
+		if (timeout == 1000)
+			RNP_PMD_LOG(ERR, "rx_queue[%d] reset queue hang",
+					index);
+		udelay(10);
+		timeout++;
+	} while (1);
+	timeout = 0;
+	do {
+		head = RNP_E_REG_RD(hw, RNP_RXQ_HEAD(index));
+		if (head == 0)
+			break;
+		timeout++;
+		if (timeout == 1000)
+			RNP_PMD_LOG(ERR, "rx_queue[%d] reset head to 0 failed",
+					index);
+		udelay(10);
+	} while (1);
+	RNP_E_REG_WR(hw, RNP_RXQ_START(index), FALSE);
+	rxbd->d.pkt_addr = 0;
+	rxbd->d.cmd = 0;
+	if (hw->mbx.vf_num == UINT16_MAX) {
+		for (idx = 0; idx < 4; idx++)
+			rnp_update_mac_veb(hw, idx, vf_id, &veb_bak_cfg[idx]);
+	} else {
+		idx = rxq->attr.lane_id;
+		rnp_update_mac_veb(hw, idx, vf_id, &veb_bak_cfg[idx]);
+	}
+	rxq->rx_tail = head;
+}
+
+void rnp_setup_rxbdr(struct rnp_hw *hw,
+		     struct rnp_rx_queue *rxq)
+{
+	u16 max_desc = rxq->attr.nb_desc;
+	u16 idx = rxq->attr.index;
+	phys_addr_t bd_address;
+	u32 dmah, dmal;
+	u32 desc_ctrl;
+
+	RNP_E_REG_WR(hw, RNP_RXQ_START(idx), FALSE);
+	bd_address = (phys_addr_t)rxq->ring_phys_addr;
+	dmah = upper_32_bits((uint64_t)bd_address);
+	dmal = lower_32_bits((uint64_t)bd_address);
+	desc_ctrl = rxq->pburst << RNQ_DESC_FETCH_BURST_S | rxq->pthresh;
+	if (hw->mbx.sriov_st)
+		dmah |= (hw->mbx.sriov_st << 24);
+	/* we must set sriov_state to hi dma_address high 8bit for vf isolation
+	 * |---8bit-----|----------24bit--------|
+	 * |sriov_state-|-------high dma address|
+	 * |---------------8bit-----------------|
+	 * |7bit | 6bit |5-0bit-----------------|
+	 * |vf_en|pf_num|-------vf_num----------|
+	 */
+	RNP_E_REG_WR(hw, RNP_RXQ_BASE_ADDR_LO(idx), dmal);
+	RNP_E_REG_WR(hw, RNP_RXQ_BASE_ADDR_HI(idx), dmah);
+	RNP_E_REG_WR(hw, RNP_RXQ_LEN(idx), max_desc);
+	rxq->rx_tailreg = (u32 *)((u8 *)hw->e_ctrl + RNP_RXQ_TAIL(idx));
+	rxq->rx_headreg = (u32 *)((u8 *)hw->e_ctrl + RNP_RXQ_HEAD(idx));
+	rxq->rx_tail = RNP_E_REG_RD(hw, RNP_RXQ_HEAD(idx));
+	RNP_E_REG_WR(hw, RNP_RXQ_DESC_FETCH_CTRL(idx), desc_ctrl);
+	RNP_E_REG_WR(hw, RNP_RXQ_DROP_TIMEOUT_TH(idx),
+			rxq->nodesc_tm_thresh);
+}
+
+int rnp_get_dma_ring_index(struct rnp_eth_port *port, u16 queue_idx)
+{
+	struct rnp_hw *hw = port->hw;
+	u16 lane = port->attr.nr_lane;
+	u16 hwrid = 0;
+
+	switch (hw->nic_mode) {
+	case RNP_DUAL_10G:
+		hwrid = 2 * (queue_idx + lane) - queue_idx % 2;
+		break;
+	case RNP_QUAD_10G:
+		hwrid = 4 * (queue_idx) + lane;
+		break;
+	default:
+		hwrid = queue_idx;
+	}
+
+	return hwrid;
+}
+
+void rnp_setup_txbdr(struct rnp_hw *hw, struct rnp_tx_queue *txq)
+{
+	u16 max_desc = txq->attr.nb_desc;
+	u16 idx = txq->attr.index;
+	phys_addr_t bd_address;
+	u32 desc_ctrl = 0;
+	u32 dmah, dmal;
+
+	bd_address = (phys_addr_t)txq->ring_phys_addr;
+	desc_ctrl = txq->pburst << RNQ_DESC_FETCH_BURST_S | txq->pthresh;
+	dmah = upper_32_bits((u64)bd_address);
+	dmal = lower_32_bits((u64)bd_address);
+	if (hw->mbx.sriov_st)
+		dmah |= (hw->mbx.sriov_st << 24);
+	/* We must set sriov_state to hi dma_address high 8bit for vf isolation
+	 * |---8bit-----|----------24bit--------|
+	 * |sriov_state-|-------high dma address|
+	 * |---------------8bit-----------------|
+	 * |7bit | 6bit |5-0bit-----------------|
+	 * |vf_en|pf_num|-------vf_num----------|
+	 */
+	RNP_E_REG_WR(hw, RNP_TXQ_BASE_ADDR_LO(idx), dmal);
+	RNP_E_REG_WR(hw, RNP_TXQ_BASE_ADDR_HI(idx), dmah);
+	RNP_E_REG_WR(hw, RNP_TXQ_LEN(idx), max_desc);
+	RNP_E_REG_WR(hw, RNP_TXQ_DESC_FETCH_CTRL(idx), desc_ctrl);
+	RNP_E_REG_WR(hw, RNP_RXTX_IRQ_MASK(idx), RNP_RXTX_IRQ_MASK_ALL);
+	txq->tx_headreg = (void *)((u8 *)hw->e_ctrl + RNP_TXQ_HEAD(idx));
+	txq->tx_tailreg = (void *)((u8 *)hw->e_ctrl + RNP_TXQ_TAIL(idx));
+
+	txq->tx_tail = RNP_E_REG_RD(hw, RNP_TXQ_HEAD(idx));
+	RNP_E_REG_WR(hw, RNP_TXQ_TAIL(idx), 0);
+}
+
+static void
+rnp_txq_reset_pre(struct rnp_hw *hw)
+{
+	u16 i = 0;
+
+	spin_lock(&hw->txq_reset_lock);
+	for (i = 0; i < RNP_MAX_RX_QUEUE_NUM; i++) {
+		wmb();
+		RNP_E_REG_WR(hw, RNP_RXQ_START(i), 0);
+	}
+}
+
+static void
+rnp_txq_reset_fin(struct rnp_hw *hw)
+{
+	u16 i = 0;
+
+	for (i = 0; i < RNP_MAX_RX_QUEUE_NUM; i++) {
+		wmb();
+		RNP_E_REG_WR(hw, RNP_RXQ_START(i), 1);
+	}
+	spin_unlock(&hw->txq_reset_lock);
+}
+
+static void
+rnp_xmit_nop_frame_ring(struct rnp_hw *hw,
+			struct rnp_tx_queue *txq,
+			u16 head)
+{
+	volatile struct rnp_tx_desc *tx_desc;
+	u16 check_head = 0;
+	u16 timeout = 0;
+	u16 index = 0;
+	u16 tx_id;
+
+	tx_id = head;
+	index = txq->attr.index;
+	tx_desc = &txq->tx_bdr[tx_id];
+
+	/* set length to 0 */
+	tx_desc->d.blen = 0;
+	tx_desc->d.addr = 0;
+	wmb();
+	tx_desc->d.cmd = cpu_to_le16(RNP_CMD_EOP);
+	wmb();
+	/* update tail */
+	RNP_REG_WR(txq->tx_tailreg, 0, 0);
+	do {
+		check_head = RNP_E_REG_RD(hw, RNP_TXQ_HEAD(index));
+		if (check_head == 0)
+			break;
+		if (timeout == 1000)
+			RNP_PMD_ERR("tx_queue[%d] reset may be hang "
+					"check_head %d base head %d",
+					index, check_head, head);
+		timeout++;
+		udelay(10);
+	} while (1);
+	/* restore the origin right state */
+	wmb();
+	RNP_E_REG_WR(hw, RNP_TXQ_LEN(index), txq->attr.nb_desc);
+}
+
+void rnp_reset_hw_txq_op(struct rnp_hw *hw,
+			 struct rnp_tx_queue *txq)
+{
+	u16 timeout = 0;
+	u16 index = 0;
+	u16 head;
+	u16 tail;
+
+	timeout = 0;
+	/* Disable Tx Queue */
+	index = txq->attr.index;
+	rnp_txq_reset_pre(hw);
+	rmb();
+	tail = RNP_E_REG_RD(hw, RNP_TXQ_TAIL(index));
+	txq->tx_tail = tail;
+	do {
+		/* wait for hw head is stopped */
+		head = RNP_E_REG_RD(hw, RNP_TXQ_HEAD(index));
+		if (head == txq->tx_tail)
+			break;
+		if (timeout > 1000) {
+			RNP_PMD_ERR("txq[%u] 1000*10us can't "
+				    "wait for hw head == tail", index);
+			break;
+		}
+		timeout++;
+		udelay(10);
+	} while (1);
+	rmb();
+	head = RNP_E_REG_RD(hw, RNP_TXQ_HEAD(index));
+	/* head is zero no need to reset */
+	if (head == 0)
+		goto tx_reset_fin;
+	wmb();
+	if (head != txq->attr.nb_desc_mask)
+		RNP_E_REG_WR(hw, RNP_TXQ_LEN(index), head + 1);
+	wmb();
+	/* reset hw head */
+	rnp_xmit_nop_frame_ring(hw, txq, head);
+	rmb();
+	txq->tx_tail = RNP_E_REG_RD(hw, RNP_TXQ_HEAD(index));
+tx_reset_fin:
+	rnp_txq_reset_fin(hw);
+}
diff --git a/drivers/net/rnp/base/rnp_bdq_if.h b/drivers/net/rnp/base/rnp_bdq_if.h
new file mode 100644
index 0000000000..61a38323e5
--- /dev/null
+++ b/drivers/net/rnp/base/rnp_bdq_if.h
@@ -0,0 +1,149 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2023 Mucse IC Design Ltd.
+ */
+
+#ifndef _RNP_BDQ_IF_H_
+#define _RNP_BDQ_IF_H_
+
+#include "rnp_hw.h"
+
+struct rnp_rx_queue;
+struct rnp_tx_queue;
+#pragma pack(push)
+#pragma pack(1)
+/* receive descriptor */
+struct rnp_rx_desc {
+	/* rx buffer descriptor */
+	union {
+		struct {
+			u64 pkt_addr;
+			u16 rsvd[3];
+			u16 cmd;
+		} d;
+		struct {
+			struct {
+				u32 rss_hash;
+				u32 mark_data;
+			} qword0;
+			struct {
+				u32 lens;
+				u16 vlan_tci;
+				u16 cmd;
+			} qword1;
+		} wb;
+	};
+};
+/* tx buffer descriptors (BD) */
+struct rnp_tx_desc {
+	union {
+		struct {
+			u64 addr;       /* pkt dma address */
+			u16 blen;       /* pkt data Len */
+			u16 mac_ip_len; /* mac ip header len */
+			u16 vlan_tci;   /* vlan_tci */
+			u16 cmd;        /* ctrl command */
+		} d;
+		struct {
+			struct {
+				u16 mss;        /* tso sz */
+				u8 vf_num;      /* vf num */
+				u8 l4_len;      /* l4 header size */
+				u8 tunnel_len;  /* tunnel header size */
+				u16 vlan_tci;   /* vlan_tci */
+				u8 veb_tran;    /* mark pkt is transmit by veb */
+			} qword0;
+			struct {
+				u16 rsvd[3];
+				u16 cmd;        /* ctrl command */
+			} qword1;
+		} c;
+	};
+};
+#pragma pack(pop)
+/* common command */
+#define RNP_CMD_EOP              RTE_BIT32(0) /* End Of Packet */
+#define RNP_CMD_DD               RTE_BIT32(1)
+#define RNP_CMD_RS               RTE_BIT32(2)
+#define RNP_DESC_TYPE_S		(3)
+#define RNP_DATA_DESC		(0x00UL << RNP_DESC_TYPE_S)
+#define RNP_CTRL_DESC		(0x01UL << RNP_DESC_TYPE_S)
+/* rx data cmd */
+#define RNP_RX_PTYPE_PTP	RTE_BIT32(4)
+#define RNP_RX_L3TYPE_S		(5)
+#define RNP_RX_L3TYPE_IPV4	(0x00UL << RNP_RX_L3TYPE_S)
+#define RNP_RX_L3TYPE_IPV6	(0x01UL << RNP_RX_L3TYPE_S)
+#define RNP_RX_L4TYPE_S		(6)
+#define RNP_RX_L4TYPE_TCP	(0x01UL << RNP_RX_L4TYPE_S)
+#define RNP_RX_L4TYPE_SCTP	(0x02UL << RNP_RX_L4TYPE_S)
+#define RNP_RX_L4TYPE_UDP	(0x03UL << RNP_RX_L4TYPE_S)
+#define RNP_RX_ERR_MASK		RTE_GENMASK32(12, 8)
+#define RNP_RX_L3_ERR		RTE_BIT32(8)
+#define RNP_RX_L4_ERR		RTE_BIT32(9)
+#define RNP_RX_SCTP_ERR		RTE_BIT32(10)
+#define RNP_RX_IN_L3_ERR	RTE_BIT32(11)
+#define RNP_RX_IN_L4_ERR	RTE_BIT32(12)
+#define RNP_RX_TUNNEL_TYPE_S	(13)
+#define RNP_RX_PTYPE_VXLAN	(0x01UL << RNP_RX_TUNNEL_TYPE_S)
+#define RNP_RX_PTYPE_NVGRE	(0x02UL << RNP_RX_TUNNEL_TYPE_S)
+#define RNP_RX_PTYPE_VLAN	RTE_BIT32(15)
+/* tx data cmd */
+#define RNP_TX_TSO_EN		RTE_BIT32(4)
+#define RNP_TX_L3TYPE_S		(5)
+#define RNP_TX_L3TYPE_IPV6	(0x01UL << RNP_TX_L3TYPE_S)
+#define RNP_TX_L3TYPE_IPV4	(0x00UL << RNP_TX_L3TYPE_S)
+#define RNP_TX_L4TYPE_S		(6)
+#define RNP_TX_L4TYPE_TCP	(0x01UL << RNP_TX_L4TYPE_S)
+#define RNP_TX_L4TYPE_SCTP	(0x02UL << RNP_TX_L4TYPE_S)
+#define RNP_TX_L4TYPE_UDP	(0x03UL << RNP_TX_L4TYPE_S)
+#define RNP_TX_TUNNEL_TYPE_S	(8)
+#define RNP_TX_VXLAN_TUNNEL	(0x01UL << RNP_TX_TUNNEL_TYPE_S)
+#define RNP_TX_NVGRE_TUNNEL	(0x02UL << RNP_TX_TUNNEL_TYPE_S)
+#define RNP_TX_PTP_EN		RTE_BIT32(10)
+#define RNP_TX_IP_CKSUM_EN	RTE_BIT32(11)
+#define RNP_TX_L4CKSUM_EN	RTE_BIT32(12)
+#define RNP_TX_VLAN_CTRL_S	(13)
+#define RNP_TX_VLAN_STRIP	(0x01UL << RNP_TX_VLAN_CTRL_S)
+#define RNP_TX_VLAN_INSERT	(0x02UL << RNP_TX_VLAN_CTRL_S)
+#define RNP_TX_VLAN_VALID	RTE_BIT32(15)
+/* tx data mac_ip len */
+#define RNP_TX_MAC_LEN_S	(9)
+/* tx ctrl cmd */
+#define RNP_TX_LEN_PAD_S	(8)
+#define RNP_TX_OFF_MAC_PAD	(0x01UL << RNP_TX_LEN_PAD_S)
+#define RNP_TX_QINQ_CTRL_S	(10)
+#define RNP_TX_QINQ_INSERT	(0x02UL << RNP_TX_QINQ_CTRL_S)
+#define RNP_TX_QINQ_STRIP	(0x01UL << RNP_TX_QINQ_CTRL_S)
+#define RNP_TX_TO_NPU_EN	RTE_BIT32(15)
+/* descript op end */
+struct rnp_rxq_reset_res {
+	u64 rx_pkt_addr;
+	u64 tx_pkt_addr;
+	u8 *eth_hdr;
+};
+struct rnp_veb_cfg {
+	uint32_t mac_hi;
+	uint32_t mac_lo;
+	uint32_t vid;
+	uint16_t vf_id;
+	uint16_t ring;
+};
+void
+rnp_rxq_flow_enable(struct rnp_hw *hw,
+		    u16 hw_idx);
+void
+rnp_rxq_flow_disable(struct rnp_hw *hw,
+		     u16 hw_idx);
+void
+rnp_reset_hw_rxq_op(struct rnp_hw *hw,
+		    struct rnp_rx_queue *rxq,
+		    struct rnp_tx_queue *txq,
+		    struct rnp_rxq_reset_res *res);
+void rnp_reset_hw_txq_op(struct rnp_hw *hw,
+			 struct rnp_tx_queue *txq);
+void rnp_setup_rxbdr(struct rnp_hw *hw,
+		     struct rnp_rx_queue *rxq);
+void rnp_setup_txbdr(struct rnp_hw *hw,
+		     struct rnp_tx_queue *txq);
+int rnp_get_dma_ring_index(struct rnp_eth_port *port, u16 queue_idx);
+
+#endif /* _RNP_BDQ_IF_H_ */
diff --git a/drivers/net/rnp/base/rnp_common.h b/drivers/net/rnp/base/rnp_common.h
index aaf77a6dad..cf1996a675 100644
--- a/drivers/net/rnp/base/rnp_common.h
+++ b/drivers/net/rnp/base/rnp_common.h
@@ -6,6 +6,10 @@
 #define _RNP_COMMON_H_
 
 #define RNP_NIC_RESET		_NIC_(0x0010)
+#define RNP_GET_MAC_HI(macaddr) (((macaddr[0]) << 8) | (macaddr[1]))
+#define RNP_GET_MAC_LO(macaddr) \
+	((macaddr[2] << 24) | (macaddr[3] << 16) | \
+	 ((macaddr[4] << 8)) | (macaddr[5]))
 int rnp_init_hw(struct rnp_hw *hw);
 int rnp_setup_common_ops(struct rnp_hw *hw);
 
diff --git a/drivers/net/rnp/base/rnp_dma_regs.h b/drivers/net/rnp/base/rnp_dma_regs.h
index 00f8aff944..7c17741c55 100644
--- a/drivers/net/rnp/base/rnp_dma_regs.h
+++ b/drivers/net/rnp/base/rnp_dma_regs.h
@@ -9,5 +9,50 @@
 #define RNP_DMA_HW_EN		(0x10)
 #define RNP_DMA_EN_ALL		(0b1111)
 #define RNP_DMA_HW_STATE	(0x14)
+/* --- queue register --- */
+/* queue enable */
+#define RNP_RXQ_START(qid)	_RING_(0x0010 + 0x100 * (qid))
+#define RNP_RXQ_READY(qid)	_RING_(0x0014 + 0x100 * (qid))
+#define RNP_TXQ_START(qid)	_RING_(0x0018 + 0x100 * (qid))
+#define RNP_TXQ_READY(qid)	_RING_(0x001c + 0x100 * (qid))
+/* queue irq generate ctrl */
+#define RNP_RXTX_IRQ_STAT(qid)	_RING_(0x0020 + 0x100 * (qid))
+#define RNP_RXTX_IRQ_MASK(qid)	_RING_(0x0024 + 0x100 * (qid))
+#define RNP_TX_IRQ_MASK		RTE_BIT32(1)
+#define RNP_RX_IRQ_MASK		RTE_BIT32(0)
+#define RNP_RXTX_IRQ_MASK_ALL	(RNP_RX_IRQ_MASK | RNP_TX_IRQ_MASK)
+#define RNP_RXTX_IRQ_CLER(qid)	_RING_(0x0028 + 0x100 * (qid))
+/* rx-queue setup */
+#define RNP_RXQ_BASE_ADDR_HI(qid)	_RING_(0x0030 + 0x100 * (qid))
+#define RNP_RXQ_BASE_ADDR_LO(qid)	_RING_(0x0034 + 0x100 * (qid))
+#define RNP_RXQ_LEN(qid)		_RING_(0x0038 + 0x100 * (qid))
+#define RNP_RXQ_HEAD(qid)		_RING_(0x003c + 0x100 * (qid))
+#define RNP_RXQ_TAIL(qid)		_RING_(0x0040 + 0x100 * (qid))
+#define RNP_RXQ_DESC_FETCH_CTRL(qid)	_RING_(0x0044 + 0x100 * (qid))
+/* rx queue interrupt generate param */
+#define RNP_RXQ_INT_DELAY_TIMER(qid)	_RING_(0x0048 + 0x100 * (qid))
+#define RNP_RXQ_INT_DELAY_PKTCNT(qid)	_RING_(0x004c + 0x100 * (qid))
+#define RNP_RXQ_RX_PRI_LVL(qid)		_RING_(0x0050 + 0x100 * (qid))
+#define RNP_RXQ_DROP_TIMEOUT_TH(qid)	_RING_(0x0054 + 0x100 * (qid))
+/* tx queue setup */
+#define RNP_TXQ_BASE_ADDR_HI(qid)        _RING_(0x0060 + 0x100 * (qid))
+#define RNP_TXQ_BASE_ADDR_LO(qid)        _RING_(0x0064 + 0x100 * (qid))
+#define RNP_TXQ_LEN(qid)                 _RING_(0x0068 + 0x100 * (qid))
+#define RNP_TXQ_HEAD(qid)                _RING_(0x006c + 0x100 * (qid))
+#define RNP_TXQ_TAIL(qid)                _RING_(0x0070 + 0x100 * (qid))
+#define RNP_TXQ_DESC_FETCH_CTRL(qid)     _RING_(0x0074 + 0x100 * (qid))
+#define RNQ_DESC_FETCH_BURST_S		(16)
+/* tx queue interrupt generate param */
+#define RNP_TXQ_INT_DELAY_TIMER(qid)     _RING_(0x0078 + 0x100 * (qid))
+#define RNP_TXQ_INT_DELAY_PKTCNT(qid)    _RING_(0x007c + 0x100 * (qid))
+/* veb ctrl register */
+#define RNP_VEB_MAC_LO(p, n)	_RING_(0x00a0 + (4 * (p)) + (0x100 * (n)))
+#define RNP_VEB_MAC_HI(p, n)	_RING_(0x00b0 + (4 * (p)) + (0x100 * (n)))
+#define RNP_VEB_VID_CFG(p, n)	_RING_(0x00c0 + (4 * (p)) + (0x100 * (n)))
+#define RNP_VEB_VF_RING(p, n)	_RING_(0x00d0 + (4 * (p)) + (0x100 * (n)))
+#define RNP_MAX_VEB_TB		(64)
+#define RNP_VEB_RING_CFG_S	(8)
+#define RNP_VEB_SWITCH_VF_EN	RTE_BIT32(7)
+#define MAX_VEB_TABLES_NUM	(4)
 
 #endif /* _RNP_DMA_REGS_H_ */
diff --git a/drivers/net/rnp/base/rnp_eth_regs.h b/drivers/net/rnp/base/rnp_eth_regs.h
index c4519ba1e5..10e3d954b8 100644
--- a/drivers/net/rnp/base/rnp_eth_regs.h
+++ b/drivers/net/rnp/base/rnp_eth_regs.h
@@ -10,6 +10,10 @@
 #define RNP_E_FILTER_EN		_ETH_(0x801c)
 #define RNP_E_REDIR_EN		_ETH_(0x8030)
 
+/* rx queue flow ctrl */
+#define RNP_RX_FC_ENABLE	_ETH_(0x8520)
+#define RNP_RING_FC_EN(n)	_ETH_(0x8524 + ((0x4) * ((n) / 32)))
+#define RNP_RING_FC_THRESH(n)	_ETH_(0x8a00 + ((0x4) * (n)))
 /* Mac Host Filter  */
 #define RNP_MAC_FCTRL		_ETH_(0x9110)
 #define RNP_MAC_FCTRL_MPE	RTE_BIT32(8)  /* Multicast Promiscuous En */
diff --git a/drivers/net/rnp/base/rnp_hw.h b/drivers/net/rnp/base/rnp_hw.h
index da2c1d3b0e..ea4e1b8d83 100644
--- a/drivers/net/rnp/base/rnp_hw.h
+++ b/drivers/net/rnp/base/rnp_hw.h
@@ -120,6 +120,9 @@ struct rnp_hw {
 	bool lane_is_sgmii[RNP_MAX_PORT_OF_PF];
 	struct rnp_mbx_info mbx;
 	struct rnp_fw_info fw_info;
+
+	spinlock_t rxq_reset_lock; /* reset op isn't thread safe */
+	spinlock_t txq_reset_lock; /* reset op isn't thread safe */
 };
 
 #endif /* __RNP_H__*/
diff --git a/drivers/net/rnp/base/rnp_osdep.h b/drivers/net/rnp/base/rnp_osdep.h
index f865300029..e088beef8b 100644
--- a/drivers/net/rnp/base/rnp_osdep.h
+++ b/drivers/net/rnp/base/rnp_osdep.h
@@ -14,6 +14,7 @@
 #include <rte_bitops.h>
 #include <rte_cycles.h>
 #include <rte_byteorder.h>
+#include <rte_spinlock.h>
 #include <rte_common.h>
 #include <rte_memzone.h>
 #include <rte_memory.h>
@@ -32,15 +33,27 @@ typedef rte_iova_t dma_addr_t;
 
 #define mb()	rte_mb()
 #define wmb()	rte_wmb()
+#define rmb()	rte_rmb()
 
 #define udelay(x) rte_delay_us(x)
 #define mdelay(x) rte_delay_ms(x)
 
+#ifndef upper_32_bits
+#define upper_32_bits(n) ((u32)(((n) >> 16) >> 16))
+#define lower_32_bits(n) ((u32)((n) & 0xffffffff))
+#endif
+
+#ifndef cpu_to_le32
+#define cpu_to_le16(v)	rte_cpu_to_le_16((u16)(v))
+#define cpu_to_le32(v)	rte_cpu_to_le_32((u32)(v))
+#endif
+
 #define spinlock_t			rte_spinlock_t
 #define spin_lock_init(spinlock_v)	rte_spinlock_init(spinlock_v)
 #define spin_lock(spinlock_v)		rte_spinlock_lock(spinlock_v)
 #define spin_unlock(spinlock_v)		rte_spinlock_unlock(spinlock_v)
 
+#define _RING_(off)	((off) + (0x08000))
 #define _ETH_(off)	((off) + (0x10000))
 #define _NIC_(off)	((off) + (0x30000))
 #define _MAC_(off)	((off) + (0x60000))
diff --git a/drivers/net/rnp/meson.build b/drivers/net/rnp/meson.build
index 660b36e1b0..18cadd46ff 100644
--- a/drivers/net/rnp/meson.build
+++ b/drivers/net/rnp/meson.build
@@ -14,4 +14,5 @@ includes += include_directories('base')
 
 sources = files(
                 'rnp_ethdev.c',
+                'rnp_rxtx.c',
 )
diff --git a/drivers/net/rnp/rnp.h b/drivers/net/rnp/rnp.h
index b777aa2a4a..b579fc1052 100644
--- a/drivers/net/rnp/rnp.h
+++ b/drivers/net/rnp/rnp.h
@@ -105,6 +105,7 @@ struct rnp_eth_port {
 	struct rte_ether_addr mac_addr;
 	struct rte_eth_dev *eth_dev;
 	struct rnp_port_attr attr;
+	struct rnp_tx_queue *tx_queues[RNP_MAX_RX_QUEUE_NUM];
 	struct rnp_hw *hw;
 };
 
@@ -113,6 +114,7 @@ struct rnp_eth_adapter {
 	struct rte_pci_device *pdev;
 	struct rte_eth_dev *eth_dev; /* alloc eth_dev by platform */
 
+	struct rte_mempool *reset_pool;
 	struct rnp_eth_port *ports[RNP_MAX_PORT_OF_PF];
 	uint16_t closed_ports;
 	uint16_t inited_ports;
diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
index 39736b01d0..4f50987877 100644
--- a/drivers/net/rnp/rnp_ethdev.c
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -15,6 +15,7 @@
 #include "base/rnp_mac.h"
 #include "base/rnp_eth_regs.h"
 #include "base/rnp_common.h"
+#include "rnp_rxtx.h"
 
 static struct rte_eth_dev *
 rnp_alloc_eth_port(struct rte_pci_device *pci, char *name)
@@ -177,7 +178,14 @@ static int rnp_dev_infos_get(struct rte_eth_dev *eth_dev,
 	dev_info->reta_size = RNP_RSS_INDIR_SIZE;
 	/* speed cap info */
 	dev_info->speed_capa = rnp_get_speed_caps(eth_dev);
-
+	/* default ring configure */
+	dev_info->default_rxportconf.burst_size = 32;
+	dev_info->default_txportconf.burst_size = 32;
+	dev_info->default_rxportconf.nb_queues = 1;
+	dev_info->default_txportconf.nb_queues = 1;
+	dev_info->default_rxportconf.ring_size = 256;
+	dev_info->default_txportconf.ring_size = 256;
+	/* default port configure */
 	dev_info->default_rxconf = (struct rte_eth_rxconf) {
 		.rx_drop_en = 0,
 		.offloads = 0,
@@ -238,6 +246,11 @@ static const struct eth_dev_ops rnp_eth_dev_ops = {
 	.promiscuous_disable          = rnp_promiscuous_disable,
 	.allmulticast_enable          = rnp_allmulticast_enable,
 	.allmulticast_disable         = rnp_allmulticast_disable,
+
+	.rx_queue_setup               = rnp_rx_queue_setup,
+	.rx_queue_release             = rnp_dev_rx_queue_release,
+	.tx_queue_setup               = rnp_tx_queue_setup,
+	.tx_queue_release             = rnp_dev_tx_queue_release,
 };
 
 static void
@@ -330,6 +343,26 @@ rnp_proc_priv_init(struct rte_eth_dev *dev)
 	return 0;
 }
 
+static int
+rnp_rx_reset_pool_setup(struct rnp_eth_adapter *adapter)
+{
+	struct rte_eth_dev *eth_dev = adapter->eth_dev;
+	char name[RTE_MEMPOOL_NAMESIZE];
+
+	snprintf(name, sizeof(name), "rx_reset_pool_%d:%d",
+			eth_dev->data->port_id, eth_dev->device->numa_node);
+
+	adapter->reset_pool = rte_pktmbuf_pool_create(name, 2,
+			0, 0, RTE_MBUF_DEFAULT_BUF_SIZE,
+			eth_dev->device->numa_node);
+	if (adapter->reset_pool == NULL) {
+		RNP_PMD_ERR("mempool %s create failed", name);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
 static int
 rnp_eth_dev_init(struct rte_eth_dev *eth_dev)
 {
@@ -425,6 +458,9 @@ rnp_eth_dev_init(struct rte_eth_dev *eth_dev)
 			rte_eth_dev_probing_finish(sub_eth_dev);
 		}
 	}
+	ret = rnp_rx_reset_pool_setup(adapter);
+	if (ret)
+		goto eth_alloc_error;
 	/* enable link update event interrupt */
 	rte_intr_callback_register(intr_handle,
 			rnp_dev_interrupt_handler, adapter);
diff --git a/drivers/net/rnp/rnp_rxtx.c b/drivers/net/rnp/rnp_rxtx.c
new file mode 100644
index 0000000000..6aa43945f4
--- /dev/null
+++ b/drivers/net/rnp/rnp_rxtx.c
@@ -0,0 +1,476 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2023 Mucse IC Design Ltd.
+ */
+
+#include <stdint.h>
+
+#include <rte_ethdev.h>
+#include <rte_memzone.h>
+#include <rte_mbuf.h>
+#include <rte_malloc.h>
+
+#include "base/rnp_bdq_if.h"
+#include "base/rnp_dma_regs.h"
+#include "rnp_rxtx.h"
+#include "rnp_logs.h"
+#include "rnp.h"
+
+static void rnp_tx_queue_release_mbuf(struct rnp_tx_queue *txq);
+static void rnp_tx_queue_sw_reset(struct rnp_tx_queue *txq);
+static void rnp_tx_queue_release(void *_txq);
+
+static __rte_always_inline phys_addr_t
+rnp_get_dma_addr(struct rnp_queue_attr *attr, struct rte_mbuf *mbuf)
+{
+	phys_addr_t dma_addr;
+
+	dma_addr = rte_cpu_to_le_64(rte_mbuf_data_iova(mbuf));
+	if (attr->sriov_st)
+		dma_addr |= (attr->sriov_st << 56);
+
+	return dma_addr;
+}
+
+static void rnp_rx_queue_release_mbuf(struct rnp_rx_queue *rxq)
+{
+	uint16_t i;
+
+	if (!rxq)
+		return;
+
+	if (rxq->sw_ring) {
+		for (i = 0; i < rxq->attr.nb_desc; i++) {
+			if (rxq->sw_ring[i].mbuf)
+				rte_pktmbuf_free_seg(rxq->sw_ring[i].mbuf);
+		}
+		memset(rxq->sw_ring, 0,
+				sizeof(rxq->sw_ring[0]) * rxq->attr.nb_desc);
+	}
+}
+
+static void rnp_rx_queue_release(void *_rxq)
+{
+	struct rnp_rx_queue *rxq = (struct rnp_rx_queue *)_rxq;
+
+	PMD_INIT_FUNC_TRACE();
+
+	if (rxq) {
+		rnp_rx_queue_release_mbuf(rxq);
+		if (rxq->rz)
+			rte_memzone_free(rxq->rz);
+		if (rxq->sw_ring)
+			rte_free(rxq->sw_ring);
+		rte_free(rxq);
+	}
+}
+
+static int
+rnp_tx_queue_reset(struct rnp_eth_port *port,
+		   struct rnp_tx_queue *txq)
+{
+	struct rnp_hw *hw = port->hw;
+
+	rnp_reset_hw_txq_op(hw, txq);
+
+	return 0;
+}
+
+static int
+rnp_rx_queue_reset(struct rnp_eth_port *port,
+		   struct rnp_rx_queue *rxq)
+{
+	struct rte_eth_dev_data *data = port->eth_dev->data;
+	struct rnp_eth_adapter *adapter = port->hw->back;
+	struct rte_eth_dev *dev = port->eth_dev;
+	struct rnp_rxq_reset_res res = {0};
+	uint16_t qidx = rxq->attr.queue_id;
+	struct rnp_tx_queue *txq = NULL;
+	struct rte_eth_txconf def_conf;
+	struct rnp_hw *hw = port->hw;
+	struct rte_mbuf *m_mbuf[2];
+	bool tx_new = false;
+	uint16_t index;
+	int err = 0;
+
+	index = rxq->attr.index;
+	/* disable eth send pkts to this ring */
+	rxq->rx_tail = RNP_E_REG_RD(hw, RNP_RXQ_HEAD(index));
+	if (!rxq->rx_tail)
+		return 0;
+	if (qidx < data->nb_tx_queues && data->tx_queues[qidx]) {
+		txq = (struct rnp_tx_queue *)data->tx_queues[qidx];
+	} else {
+		/* tx queues has been release or txq num less than rxq num */
+		def_conf.tx_deferred_start = true;
+		def_conf.tx_free_thresh = 32;
+		def_conf.tx_rs_thresh = 32;
+		if (dev->dev_ops->tx_queue_setup)
+			err = dev->dev_ops->tx_queue_setup(dev, qidx,
+				rxq->attr.nb_desc,
+				dev->data->numa_node, &def_conf);
+		if (err) {
+			RNP_PMD_ERR("rxq[%d] reset pair txq setup fail", qidx);
+			return err;
+		}
+		txq = port->tx_queues[qidx];
+		tx_new = true;
+	}
+	if (unlikely(rte_mempool_get_bulk(adapter->reset_pool, (void *)m_mbuf,
+					2) < 0)) {
+		RNP_PMD_LOG(WARNING, "port[%d] reset rx queue[%d] failed "
+				"because mbuf alloc failed",
+				data->port_id, qidx);
+		return -ENOMEM;
+	}
+	rnp_rxq_flow_disable(hw, index);
+	rte_mbuf_refcnt_set(m_mbuf[0], 1);
+	rte_mbuf_refcnt_set(m_mbuf[1], 1);
+	m_mbuf[0]->data_off = RTE_PKTMBUF_HEADROOM;
+	m_mbuf[1]->data_off = RTE_PKTMBUF_HEADROOM;
+	res.eth_hdr = rte_pktmbuf_mtod(m_mbuf[0], uint8_t *);
+	res.rx_pkt_addr = rnp_get_dma_addr(&rxq->attr, m_mbuf[1]);
+	res.tx_pkt_addr = rnp_get_dma_addr(&txq->attr, m_mbuf[0]);
+	rnp_reset_hw_rxq_op(hw, rxq, txq, &res);
+	if (tx_new)
+		rnp_tx_queue_release(txq);
+	else
+		txq->tx_tail = RNP_E_REG_RD(hw, RNP_TXQ_HEAD(index));
+	if (!tx_new) {
+		if (txq->tx_tail) {
+			rnp_tx_queue_release_mbuf(txq);
+			rnp_tx_queue_reset(port, txq);
+			rnp_tx_queue_sw_reset(txq);
+		}
+	}
+	rte_mempool_put_bulk(adapter->reset_pool, (void **)m_mbuf, 2);
+	rnp_rxq_flow_enable(hw, index);
+	rte_io_wmb();
+	RNP_E_REG_WR(hw, RNP_RXQ_LEN(index), rxq->attr.nb_desc);
+
+	return 0;
+}
+
+static int
+rnp_alloc_rxbdr(struct rte_eth_dev *dev,
+		struct rnp_rx_queue *rxq,
+		uint16_t nb_rx_desc, int socket_id)
+{
+	const struct rte_memzone *rz = NULL;
+	uint32_t size = 0;
+
+	size = (nb_rx_desc + RNP_RX_MAX_BURST_SIZE) *
+		sizeof(struct rnp_rxsw_entry);
+	rxq->sw_ring = rte_zmalloc_socket("rx_swring", size,
+			RTE_CACHE_LINE_SIZE, socket_id);
+	if (rxq->sw_ring == NULL)
+		return -ENOMEM;
+	rz = rte_eth_dma_zone_reserve(dev, "rx_ring", rxq->attr.queue_id,
+			RNP_RX_MAX_RING_SZ, RNP_BD_RING_ALIGN, socket_id);
+	if (rz == NULL) {
+		rte_free(rxq->sw_ring);
+		rxq->sw_ring = NULL;
+		return -ENOMEM;
+	}
+	memset(rz->addr, 0, RNP_RX_MAX_RING_SZ);
+	rxq->rx_bdr = (struct rnp_rx_desc *)rz->addr;
+	rxq->ring_phys_addr = rz->iova;
+	rxq->rz = rz;
+
+	return 0;
+}
+
+static void
+rnp_rx_queue_sw_reset(struct rnp_rx_queue *rxq)
+{
+	uint32_t size = 0;
+	uint32_t idx = 0;
+
+	rxq->nb_rx_free = rxq->attr.nb_desc - 1;
+	rxq->rx_tail = 0;
+
+	size = rxq->attr.nb_desc + RNP_RX_MAX_BURST_SIZE;
+	for (idx = 0; idx < size * sizeof(struct rnp_rx_desc); idx++)
+		((volatile char *)rxq->rx_bdr)[idx] = 0;
+}
+
+
+int rnp_rx_queue_setup(struct rte_eth_dev *eth_dev,
+		       uint16_t qidx,
+		       uint16_t nb_rx_desc,
+		       unsigned int socket_id,
+		       const struct rte_eth_rxconf *rx_conf,
+		       struct rte_mempool *mb_pool)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(eth_dev);
+	struct rte_eth_dev_data *data = eth_dev->data;
+	struct rnp_hw *hw = port->hw;
+	struct rnp_rx_queue *rxq = NULL;
+	uint64_t offloads;
+	int err = 0;
+
+	RNP_PMD_LOG(INFO, "RXQ[%d] setup nb-desc %d", qidx, nb_rx_desc);
+	offloads = rx_conf->offloads | data->dev_conf.rxmode.offloads;
+	if (rte_is_power_of_2(nb_rx_desc) == 0) {
+		RNP_PMD_ERR("Rxq Desc Num Must power of 2");
+		return -EINVAL;
+	}
+	if (nb_rx_desc > RNP_MAX_BD_COUNT)
+		return -EINVAL;
+	/* check whether queue has been created if so release it */
+	if (qidx < data->nb_rx_queues &&
+			data->rx_queues[qidx] != NULL) {
+		rnp_rx_queue_release(data->rx_queues[qidx]);
+		data->rx_queues[qidx] = NULL;
+	}
+	rxq = rte_zmalloc_socket("rnp_rxq", sizeof(struct rnp_rx_queue),
+			RTE_CACHE_LINE_SIZE, socket_id);
+	if (rxq == NULL) {
+		RNP_PMD_ERR("Failed to allocate rx ring memory");
+		return -ENOMEM;
+	}
+	rxq->rx_offloads = offloads;
+	/* queue hw info */
+	rxq->attr.index = rnp_get_dma_ring_index(port, qidx);
+	rxq->attr.nb_desc_mask = nb_rx_desc - 1;
+	rxq->attr.nb_desc = nb_rx_desc;
+	rxq->attr.queue_id = qidx;
+	/* queue map to port hw info */
+	rxq->attr.vf_num = hw->mbx.vf_num;
+	rxq->attr.sriov_st = hw->mbx.sriov_st;
+	rxq->attr.lane_id = port->attr.nr_lane;
+	rxq->attr.port_id = data->port_id;
+#define RNP_RXQ_BD_TIMEOUT   (5000000)
+	rxq->nodesc_tm_thresh = RNP_RXQ_BD_TIMEOUT;
+	rxq->rx_buf_len = (uint16_t)(rte_pktmbuf_data_room_size(mb_pool) -
+			RTE_PKTMBUF_HEADROOM);
+	rxq->mb_pool = mb_pool;
+	err = rnp_alloc_rxbdr(eth_dev, rxq, nb_rx_desc, socket_id);
+	if (err)
+		goto fail;
+	RNP_PMD_LOG(INFO, "PF[%d] dev:[%d] hw-lane[%d] rx_qid[%d] "
+			"hw_ridx %d socket %d",
+			hw->mbx.pf_num, rxq->attr.port_id,
+			rxq->attr.lane_id, qidx,
+			rxq->attr.index, socket_id);
+	rxq->rx_free_thresh = (rx_conf->rx_free_thresh) ?
+		rx_conf->rx_free_thresh : RNP_DEFAULT_RX_FREE_THRESH;
+	rxq->pthresh = (rx_conf->rx_thresh.pthresh) ?
+		rx_conf->rx_thresh.pthresh : RNP_RX_DESC_FETCH_TH;
+	rxq->pburst = (rx_conf->rx_thresh.hthresh) ?
+		rx_conf->rx_thresh.hthresh : RNP_RX_DESC_FETCH_BURST;
+	rnp_setup_rxbdr(hw, rxq);
+	if (rxq->rx_tail) {
+		err = rnp_rx_queue_reset(port, rxq);
+		if (err) {
+			RNP_PMD_ERR("PF[%d] dev:[%d] lane[%d] rx_qid[%d] "
+				    "hw_ridx[%d] bdr setup failed",
+				    hw->mbx.pf_num, rxq->attr.port_id,
+				    rxq->attr.lane_id, qidx, rxq->attr.index);
+			goto rxbd_setup_failed;
+		}
+	}
+	rnp_rx_queue_sw_reset(rxq);
+	data->rx_queues[qidx] = rxq;
+
+	return 0;
+rxbd_setup_failed:
+	if (rxq->rz)
+		rte_memzone_free(rxq->rz);
+fail:
+	rte_free(rxq);
+
+	return err;
+}
+
+static void rnp_tx_queue_release_mbuf(struct rnp_tx_queue *txq)
+{
+	uint16_t i;
+
+	if (!txq)
+		return;
+	if (txq->sw_ring) {
+		for (i = 0; i < txq->attr.nb_desc; i++) {
+			if (txq->sw_ring[i].mbuf) {
+				rte_pktmbuf_free_seg(txq->sw_ring[i].mbuf);
+				txq->sw_ring[i].mbuf = NULL;
+			}
+		}
+	}
+}
+
+static void rnp_tx_queue_release(void *_txq)
+{
+	struct rnp_tx_queue *txq = (struct rnp_tx_queue *)_txq;
+
+	PMD_INIT_FUNC_TRACE();
+
+	if (txq) {
+		rnp_tx_queue_release_mbuf(txq);
+
+		if (txq->rz)
+			rte_memzone_free(txq->rz);
+		if (txq->sw_ring)
+			rte_free(txq->sw_ring);
+		rte_free(txq);
+	}
+}
+
+void
+rnp_dev_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
+{
+	rnp_rx_queue_release(dev->data->rx_queues[qid]);
+}
+
+void
+rnp_dev_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
+{
+	rnp_tx_queue_release(dev->data->tx_queues[qid]);
+}
+
+static int rnp_alloc_txbdr(struct rte_eth_dev *dev,
+			   struct rnp_tx_queue *txq,
+			   uint16_t nb_desc, int socket_id)
+{
+	const struct rte_memzone *rz = NULL;
+	int size;
+
+	size = nb_desc * sizeof(struct rnp_txsw_entry);
+	txq->sw_ring = rte_zmalloc_socket("tx_swq", size,
+			RTE_CACHE_LINE_SIZE, socket_id);
+	if (txq->sw_ring == NULL)
+		return -ENOMEM;
+
+	rz = rte_eth_dma_zone_reserve(dev, "tx_ring", txq->attr.queue_id,
+			RNP_TX_MAX_RING_SZ, RNP_BD_RING_ALIGN, socket_id);
+	if (rz == NULL) {
+		rte_free(txq->sw_ring);
+		txq->sw_ring = NULL;
+		return -ENOMEM;
+	}
+	memset(rz->addr, 0, RNP_TX_MAX_RING_SZ);
+	txq->ring_phys_addr = rz->iova;
+	txq->tx_bdr = rz->addr;
+	txq->rz = rz;
+
+	return 0;
+}
+
+static void
+rnp_tx_queue_sw_reset(struct rnp_tx_queue *txq)
+{
+	struct rnp_txsw_entry *sw_ring = txq->sw_ring;
+	uint32_t idx = 0, prev = 0;
+	uint32_t size = 0;
+
+	prev = (uint16_t)(txq->attr.nb_desc - 1);
+	for (idx = 0; idx < txq->attr.nb_desc; idx++) {
+		sw_ring[idx].mbuf = NULL;
+		sw_ring[idx].last_id = idx;
+		sw_ring[prev].next_id = idx;
+		prev = idx;
+	}
+	txq->nb_tx_free = txq->attr.nb_desc - 1;
+	txq->tx_next_dd = txq->tx_rs_thresh - 1;
+	txq->tx_next_rs = txq->tx_rs_thresh - 1;
+
+	size = (txq->attr.nb_desc + RNP_TX_MAX_BURST_SIZE);
+	for (idx = 0; idx < size * sizeof(struct rnp_tx_desc); idx++)
+		((volatile char *)txq->tx_bdr)[idx] = 0;
+}
+
+int
+rnp_tx_queue_setup(struct rte_eth_dev *dev,
+		   uint16_t qidx, uint16_t nb_desc,
+		   unsigned int socket_id,
+		   const struct rte_eth_txconf *tx_conf)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(dev);
+	struct rte_eth_dev_data *data = dev->data;
+	struct rnp_hw *hw = port->hw;
+	struct rnp_tx_queue *txq;
+	uint64_t offloads = 0;
+	int err = 0;
+
+	PMD_INIT_FUNC_TRACE();
+	offloads = tx_conf->offloads | dev->data->dev_conf.txmode.offloads;
+	RNP_PMD_INFO("TXQ[%d] setup nb-desc %d", qidx, nb_desc);
+	if (rte_is_power_of_2(nb_desc) == 0) {
+		RNP_PMD_ERR("txq Desc num must power of 2");
+		return -EINVAL;
+	}
+	if (nb_desc > RNP_MAX_BD_COUNT)
+		return -EINVAL;
+	/* check whether queue Has been create if so release it */
+	if (qidx < data->nb_tx_queues && data->tx_queues[qidx]) {
+		rnp_tx_queue_release(data->tx_queues[qidx]);
+		data->tx_queues[qidx] = NULL;
+	}
+	txq = rte_zmalloc_socket("rnp_txq", sizeof(struct rnp_tx_queue),
+			RTE_CACHE_LINE_SIZE, socket_id);
+	if (!txq) {
+		RNP_PMD_ERR("Failed to allocate TX ring memory");
+		return -ENOMEM;
+	}
+	txq->tx_rs_thresh = tx_conf->tx_rs_thresh ?
+		tx_conf->tx_rs_thresh : RNP_DEFAULT_TX_RS_THRESH;
+	txq->tx_free_thresh = tx_conf->tx_free_thresh ?
+		tx_conf->tx_free_thresh : RNP_DEFAULT_TX_FREE_THRESH;
+	if (txq->tx_rs_thresh > txq->tx_free_thresh) {
+		RNP_PMD_ERR("tx_rs_thresh must be less than or "
+			     "equal to tx_free_thresh. (tx_free_thresh=%u"
+			     " tx_rs_thresh=%u port=%d queue=%d)",
+			     (unsigned int)tx_conf->tx_free_thresh,
+			     (unsigned int)tx_conf->tx_rs_thresh,
+			     (int)data->port_id,
+			     (int)qidx);
+		err = -EINVAL;
+		goto txbd_setup_failed;
+	}
+	if (txq->tx_rs_thresh + txq->tx_free_thresh >= nb_desc) {
+		RNP_PMD_ERR("tx_rs_thresh + tx_free_thresh >= nb_desc"
+				"%d + %d >= %d", txq->tx_rs_thresh,
+				txq->tx_free_thresh, nb_desc);
+		err = -EINVAL;
+		goto txbd_setup_failed;
+	}
+	txq->pthresh = (tx_conf->tx_thresh.pthresh) ?
+		tx_conf->tx_thresh.pthresh : RNP_TX_DESC_FETCH_TH;
+	txq->pburst = (tx_conf->tx_thresh.hthresh) ?
+		tx_conf->tx_thresh.hthresh : RNP_TX_DESC_FETCH_BURST;
+	txq->free_mbufs = rte_zmalloc_socket("txq->free_mbufs",
+			sizeof(struct rte_mbuf *) * txq->tx_rs_thresh,
+			RTE_CACHE_LINE_SIZE, socket_id);
+	txq->attr.index = rnp_get_dma_ring_index(port, qidx);
+	txq->attr.lane_id = port->attr.nr_lane;
+	txq->attr.port_id = dev->data->port_id;
+	txq->attr.nb_desc_mask = nb_desc - 1;
+	txq->attr.vf_num = hw->mbx.vf_num;
+	txq->attr.nb_desc = nb_desc;
+	txq->attr.queue_id = qidx;
+
+	err = rnp_alloc_txbdr(dev, txq, nb_desc, socket_id);
+	if (err)
+		goto txbd_setup_failed;
+	rnp_setup_txbdr(hw, txq);
+	if (txq->tx_tail)
+		rnp_reset_hw_txq_op(hw, txq);
+	rnp_tx_queue_sw_reset(txq);
+	RNP_PMD_LOG(INFO, "PF[%d] dev:[%d] hw-lane[%d] txq queue_id[%d] "
+			"dma_idx %d socket %d",
+			hw->mbx.pf_num, txq->attr.port_id,
+			txq->attr.lane_id, qidx,
+			txq->attr.index, socket_id);
+	if (qidx < dev->data->nb_tx_queues)
+		data->tx_queues[qidx] = txq;
+	port->tx_queues[qidx] = txq;
+
+	txq->tx_deferred_start = tx_conf->tx_deferred_start;
+	txq->tx_offloads = offloads;
+
+	return 0;
+txbd_setup_failed:
+
+	rte_free(txq);
+
+	return err;
+}
diff --git a/drivers/net/rnp/rnp_rxtx.h b/drivers/net/rnp/rnp_rxtx.h
new file mode 100644
index 0000000000..3ea977ccaa
--- /dev/null
+++ b/drivers/net/rnp/rnp_rxtx.h
@@ -0,0 +1,123 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2023 Mucse IC Design Ltd.
+ */
+
+#ifndef _RNP_RXTX_H_
+#define _RNP_RXTX_H_
+
+#include "rnp.h"
+#include "base/rnp_bdq_if.h"
+
+#define RNP_RX_MAX_BURST_SIZE	(32)
+#define RNP_TX_MAX_BURST_SIZE	(32)
+#define RNP_BD_RING_ALIGN	(128)
+#define RNP_MAX_RING_DESC	(4096)
+#define RNP_RX_MAX_RING_SZ	\
+	((RNP_MAX_RING_DESC + \
+	  RNP_RX_MAX_BURST_SIZE) * \
+	 sizeof(struct rnp_rx_desc))
+#define RNP_TX_MAX_RING_SZ	\
+	((RNP_MAX_RING_DESC + \
+	  RNP_TX_MAX_BURST_SIZE) * \
+	 sizeof(struct rnp_tx_desc))
+
+#define RNP_RX_DESC_FETCH_TH		(96) /* dma fetch desC threshold */
+#define RNP_RX_DESC_FETCH_BURST		(32) /* */
+#define RNP_TX_DESC_FETCH_TH		(64) /* dma fetch desc threshold */
+#define RNP_TX_DESC_FETCH_BURST		(32) /* max-num_descs_peer_read*/
+
+#define RNP_DEFAULT_TX_FREE_THRESH   (32)
+#define RNP_DEFAULT_TX_RS_THRESH     (32)
+#define RNP_DEFAULT_RX_FREE_THRESH   (32)
+
+/* rx queue info */
+struct rnp_queue_attr {
+	uint64_t sriov_st; /* enable sriov info */
+	uint16_t vf_num; /* ring belong to which vf */
+
+	uint16_t queue_id; /* sw queue index*/
+	uint16_t index; /* hw ring index */
+	uint16_t lane_id; /* ring belong to which physical Lane */
+	uint16_t nb_desc; /* max bds */
+	uint16_t nb_desc_mask; /* mask of bds */
+	uint16_t port_id; /* dpdk manage port sequence id */
+};
+
+struct rnp_rxsw_entry {
+	struct rte_mbuf *mbuf;
+};
+
+struct rnp_rx_queue {
+	struct rte_mempool *mb_pool; /* mbuf pool to populate rx ring. */
+	const struct rte_memzone *rz; /* rx hw ring base alloc memzone */
+	uint64_t ring_phys_addr; /* rx hw ring physical addr */
+	volatile struct rnp_rx_desc *rx_bdr; /* rx hw ring rirtual Addr */
+	volatile struct rnp_rx_desc zero_desc;
+	struct rnp_rxsw_entry *sw_ring; /* rx software ring addr */
+	volatile void *rx_tailreg; /* hw desc tail register */
+	volatile void *rx_headreg; /* hw desc head register*/
+	struct rnp_queue_attr attr;
+
+	uint16_t rx_buf_len; /* mempool mbuf buf len */
+	uint16_t nb_rx_free; /* number available use desc */
+	uint16_t rx_free_thresh; /* rx free desc desource thresh */
+	uint16_t rx_tail;
+
+	uint32_t nodesc_tm_thresh; /* rx queue no desc timeout thresh */
+	uint8_t rx_deferred_start; /* do not start queue with dev_start(). */
+	uint8_t pthresh; /* rx desc prefetch threshold */
+	uint8_t pburst; /* rx desc prefetch burst */
+
+	uint64_t rx_offloads; /* user set hw offload features */
+	struct rte_mbuf **free_mbufs; /* rx bulk alloc reserve of free mbufs */
+};
+
+struct rnp_txsw_entry {
+	struct rte_mbuf *mbuf;  /* sync with tx desc dma physical addr */
+	uint16_t next_id;       /* next entry resource used */
+	uint16_t last_id;       /* last entry resource used */
+};
+
+struct rnp_tx_desc;
+struct rnp_tx_queue {
+	const struct rte_memzone *rz;
+	uint64_t ring_phys_addr; /* tx dma ring physical addr */
+	volatile struct rnp_tx_desc *tx_bdr; /* tx dma ring virtual addr */
+	struct rnp_txsw_entry *sw_ring; /* tx software ring addr */
+	volatile void *tx_tailreg; /* hw desc tail register */
+	volatile void *tx_headreg; /* hw desc head register*/
+	struct rnp_queue_attr attr;
+
+	uint16_t nb_tx_free; /* avail desc to set pkts */
+	uint16_t nb_tx_used;
+	uint16_t tx_tail;
+
+	uint16_t tx_next_dd; /* next to scan writeback dd bit */
+	uint16_t tx_rs_thresh; /* number of interval set rs bit */
+	uint16_t tx_next_rs; /* index of next time to set rs bit*/
+	uint16_t tx_free_thresh; /* thresh to free tx desc resource */
+
+	uint8_t tx_deferred_start; /*< Do not start queue with dev_start(). */
+	uint8_t pthresh; /* rx desc prefetch threshold */
+	uint8_t pburst; /* rx desc burst*/
+
+	uint64_t tx_offloads; /* tx offload features */
+	struct rte_mbuf **free_mbufs; /* tx bulk free reserve of free mbufs */
+};
+
+void
+rnp_dev_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid);
+void
+rnp_dev_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid);
+int rnp_rx_queue_setup(struct rte_eth_dev *eth_dev,
+		       uint16_t qidx,
+		       uint16_t nb_rx_desc,
+		       unsigned int socket_id,
+		       const struct rte_eth_rxconf *rx_conf,
+		       struct rte_mempool *mb_pool);
+int rnp_tx_queue_setup(struct rte_eth_dev *dev,
+		       uint16_t qidx, uint16_t nb_desc,
+		       unsigned int socket_id,
+		       const struct rte_eth_txconf *tx_conf);
+
+#endif /* _RNP_RXTX_H_ */
-- 
2.34.1

