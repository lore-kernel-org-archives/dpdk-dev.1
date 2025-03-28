Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE034C3600C
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 05:17:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EFA340C35;
	Fri, 28 Mar 2025 06:15:36 +0100 (CET)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 by mails.dpdk.org (Postfix) with ESMTP id 6D1CA40299
 for <dev@dpdk.org>; Fri, 28 Mar 2025 06:15:33 +0100 (CET)
X-QQ-mid: bizesmtpsz12t1743138928tv9e51
X-QQ-Originating-IP: pfcn48VS/NvUwaZkFDP2KmmealKiJN/fNXAZ4B8ouPg=
Received: from steven.localdomain ( [103.233.162.252])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 28 Mar 2025 13:15:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4647714785955323696
EX-QQ-RecipientCnt: 5
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net
Cc: stephen@networkplumber.org, dev@dpdk.org, yaojun@mucse.com,
 Wenbo Cao <caowenbo@mucse.com>
Subject: [PATCH v17 17/29] net/rnp: add Rx scatter segment version
Date: Fri, 28 Mar 2025 05:14:32 +0000
Message-Id: <20250328051444.1019208-18-caowenbo@mucse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250328051444.1019208-1-caowenbo@mucse.com>
References: <20250328051444.1019208-1-caowenbo@mucse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: MTyvyLqh9yTf6QMbzZJvpZbmD6BMXhI7exNENNd+LF5y9bY0ViBPTJMs
 CP1TWXU1dpJEuYQjSbnjr7wVrIRIvKsPqUdtelAkWSnBqMYVxSPqHW4LpScZedWMcSVCi6J
 VaIImiY2YxEqz5dYb3cWcNzz9SengVeJ2M70R22S+I0LpLby0Qxw6wm4urBQmIVDfbWN9jc
 kksEt+GZ6rpBbFASiwZRmBollZf9VTK4Qxs7R/If6WPky5+AXHnQCc4v8GSNPQgTJZ2HZax
 u45j3Qho11tYZpjKFmY6rTpHOCUIrSsGnpiDX5F0+RKW2XsHmOJToCv6orcjSoXQy+mMDIr
 jQs6cGJdTnrictpXnmF+jBPi3Idn9ILmVgvYx/as+TS2rb4DWr9WO8y+qjgNCpiZwsnosOj
 T1PW07vnWofv8N9euDFLKw5jojZLbTMGxFjS//287ZV9Az8tp5aFEWCN5xKzYCZPDkG+uix
 kGRm9UnVrd7vk8gRWX9KIaOPlWHaVFnJfc3q+BIS58bF81iar31/KEvROCs353ZnAlbHuy2
 s56gK7PaVGodwzK4dM22iqlquzTMneC6cg2MWgc8PC+1+J85z76l9qJGcQ8992dAYGHJKJ0
 inzrod8wztjLpWGQCL4BD6PG+HmhkcWXURMOKFUhTcqWXwVqqgrspUCggFBxiX46HNeLBD/
 /QCzlz/GzI2kEefVYY3XbMTiahDw5yiLQmF2L4Ary8hJR92qJ05831xchmAl6h3mWva+Rrd
 8fy4Jl3gELmvbGWFbvQIgEG/a/ZOlQ8FFdbL8AtF6X/5DBfiwonR8gvdnRyB7pGt0+vfmtX
 I7QKbYqFJsUrvndgkk2IvSoiM3ZfV0XsBzcU4Hm/xU+SQyxuCYC4vonC2k5nJv3GHenfpgO
 7k9AkhSi8Kd+OvdynaBrTBpenZWNR3CIm/rvpIa3yqwwsY+V596X62DOgWvoqoiB9TwUltv
 N8lE16VL/wi39v+l/f8/dXGeRfBRajrdNMdq0nCeAtxFZuepeW+rCanPeVvKmO6mCWkSeOG
 5kfis9GAjaqNG+Luynrz+A4nTD+XQ1cPqpce5BCZd4fG3ndK83Wz3O+0mOVnWM+DbhARzRb
 KGgRN9pRL72
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0
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

add support scatter multi segment received.

Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
---
 doc/guides/nics/features/rnp.ini |   1 +
 doc/guides/nics/rnp.rst          |   2 +
 drivers/net/rnp/rnp_ethdev.c     |   2 +
 drivers/net/rnp/rnp_rxtx.c       | 130 ++++++++++++++++++++++++++++++-
 drivers/net/rnp/rnp_rxtx.h       |   2 +
 5 files changed, 135 insertions(+), 2 deletions(-)

diff --git a/doc/guides/nics/features/rnp.ini b/doc/guides/nics/features/rnp.ini
index 6d13370e8f..6453762745 100644
--- a/doc/guides/nics/features/rnp.ini
+++ b/doc/guides/nics/features/rnp.ini
@@ -15,5 +15,6 @@ RSS hash             = Y
 RSS key update       = Y
 RSS reta update      = Y
 Inner RSS            = Y
+Scattered Rx         = Y
 Linux                = Y
 x86-64               = Y
diff --git a/doc/guides/nics/rnp.rst b/doc/guides/nics/rnp.rst
index c9d6baa5c2..ddefbc7fb3 100644
--- a/doc/guides/nics/rnp.rst
+++ b/doc/guides/nics/rnp.rst
@@ -44,6 +44,8 @@ Features
 - Promiscuous mode
 - Link state information
 - MTU update
+- Jumbo frames
+- Scatter-Gather IO support
 
 Prerequisites and Pre-conditions
 --------------------------------
diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
index 8cb9078ce9..48e4431945 100644
--- a/drivers/net/rnp/rnp_ethdev.c
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -606,6 +606,8 @@ static int rnp_dev_infos_get(struct rte_eth_dev *eth_dev,
 	dev_info->reta_size = RNP_RSS_INDIR_SIZE;
 	/* speed cap info */
 	dev_info->speed_capa = rnp_get_speed_caps(eth_dev);
+	/* rx support offload cap */
+	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_SCATTER;
 	/* default ring configure */
 	dev_info->default_rxportconf.burst_size = 32;
 	dev_info->default_txportconf.burst_size = 32;
diff --git a/drivers/net/rnp/rnp_rxtx.c b/drivers/net/rnp/rnp_rxtx.c
index 260c34113a..b2ca9b15fc 100644
--- a/drivers/net/rnp/rnp_rxtx.c
+++ b/drivers/net/rnp/rnp_rxtx.c
@@ -826,7 +826,6 @@ rnp_xmit_simple(void *_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		if (txq->tx_next_rs > txq->attr.nb_desc)
 			txq->tx_next_rs = txq->tx_rs_thresh - 1;
 	}
-
 	txq->tx_tail = i;
 
 	rte_wmb();
@@ -835,9 +834,136 @@ rnp_xmit_simple(void *_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	return start;
 }
 
+static int
+rnp_rxq_bulk_alloc(struct rnp_rx_queue *rxq,
+		   volatile struct rnp_rx_desc *rxbd,
+		   struct rnp_rxsw_entry *rxe,
+		   bool bulk_alloc)
+{
+	struct rte_eth_dev_data *data;
+	struct rte_mbuf *nmb = NULL;
+	uint16_t update_tail;
+
+	if (!bulk_alloc) {
+		data = rte_eth_devices[rxq->attr.port_id].data;
+		nmb = rte_mbuf_raw_alloc(rxq->mb_pool);
+		if (unlikely(!nmb)) {
+			data->rx_mbuf_alloc_failed++;
+			return -ENOMEM;
+		}
+		rxbd->d.pkt_addr = 0;
+		rxbd->d.cmd = 0;
+		rxe->mbuf = NULL;
+		rxe->mbuf = nmb;
+		rxbd->d.pkt_addr = rnp_get_dma_addr(&rxq->attr, nmb);
+	}
+	if (rxq->rxrearm_nb > rxq->rx_free_thresh) {
+		rxq->rxrearm_nb -= rxq->rx_free_thresh;
+		rxq->rxrearm_start += rxq->rx_free_thresh;
+		if (rxq->rxrearm_start >= rxq->attr.nb_desc)
+			rxq->rxrearm_start = 0;
+		update_tail = (uint16_t)((rxq->rxrearm_start == 0) ?
+				(rxq->attr.nb_desc - 1) : (rxq->rxrearm_start - 1));
+		rte_io_wmb();
+		RNP_REG_WR(rxq->rx_tailreg, 0, update_tail);
+	}
+
+	return 0;
+}
+
+static __rte_always_inline uint16_t
+rnp_scattered_rx(void *rx_queue, struct rte_mbuf **rx_pkts,
+		 uint16_t nb_pkts)
+{
+	struct rnp_rx_queue *rxq = (struct rnp_rx_queue *)rx_queue;
+	volatile struct rnp_rx_desc *bd_ring = rxq->rx_bdr;
+	struct rte_mbuf *first_seg = rxq->pkt_first_seg;
+	struct rte_mbuf *last_seg = rxq->pkt_last_seg;
+	struct rnp_rxsw_entry *sw_ring = rxq->sw_ring;
+	volatile struct rnp_rx_desc *rxbd;
+	volatile struct rnp_rx_desc rxd;
+	struct rnp_rxsw_entry *rxe;
+	struct rte_mbuf *rxm;
+	uint16_t rx_pkt_len;
+	uint16_t nb_rx = 0;
+	uint16_t rx_status;
+	uint16_t rx_id;
+
+	if (unlikely(!rxq->rxq_started || !rxq->rx_link))
+		return 0;
+	rx_id = rxq->rx_tail;
+	while (nb_rx < nb_pkts) {
+		rxbd = &bd_ring[rx_id];
+		rx_status = rxbd->wb.qword1.cmd;
+		if (!(rx_status & rte_cpu_to_le_16(RNP_CMD_DD)))
+			break;
+		rte_atomic_thread_fence(rte_memory_order_acquire);
+		rxd = *rxbd;
+		rxe = &sw_ring[rx_id];
+		rxm = rxe->mbuf;
+		if (rnp_rxq_bulk_alloc(rxq, rxbd, rxe, false))
+			break;
+		rx_id = (rx_id + 1) & rxq->attr.nb_desc_mask;
+		rte_prefetch0(sw_ring[rx_id].mbuf);
+		if ((rx_id & 0x3) == 0) {
+			rte_prefetch0(&bd_ring[rx_id]);
+			rte_prefetch0(&sw_ring[rx_id]);
+		}
+		rx_pkt_len = rxd.wb.qword1.lens;
+		rxm->data_len = rx_pkt_len;
+		rxm->data_off = RTE_PKTMBUF_HEADROOM;
+		if (!first_seg) {
+			/* first segment pkt */
+			first_seg = rxm;
+			first_seg->nb_segs = 1;
+			first_seg->pkt_len = rx_pkt_len;
+		} else {
+			/* follow-up segment pkt */
+			first_seg->pkt_len =
+				(uint16_t)(first_seg->pkt_len + rx_pkt_len);
+			first_seg->nb_segs++;
+			last_seg->next = rxm;
+		}
+		rxq->rxrearm_nb++;
+		if (!(rx_status & rte_cpu_to_le_16(RNP_CMD_EOP))) {
+			last_seg = rxm;
+			continue;
+		}
+		rxm->next = NULL;
+		first_seg->port = rxq->attr.port_id;
+		/* this the end of packet the large pkt has been recv finish */
+		rte_prefetch0(RTE_PTR_ADD(first_seg->buf_addr,
+					first_seg->data_off));
+		rx_pkts[nb_rx++] = first_seg;
+		first_seg = NULL;
+	}
+	/* update sw record point */
+	rxq->rx_tail = rx_id;
+	rxq->pkt_first_seg = first_seg;
+	rxq->pkt_last_seg = last_seg;
+
+	return nb_rx;
+}
+
+static int
+rnp_check_rx_simple_valid(struct rte_eth_dev *dev)
+{
+	uint64_t rx_offloads = dev->data->dev_conf.rxmode.offloads;
+
+	if (dev->data->scattered_rx || rx_offloads & RTE_ETH_RX_OFFLOAD_SCATTER)
+		return -ENOTSUP;
+	return 0;
+}
+
 int rnp_rx_func_select(struct rte_eth_dev *dev)
 {
-	dev->rx_pkt_burst = rnp_recv_pkts;
+	bool simple_allowed = false;
+
+	simple_allowed = rnp_check_rx_simple_valid(dev) == 0;
+	if (simple_allowed)
+		dev->rx_pkt_burst = rnp_recv_pkts;
+	else
+		dev->rx_pkt_burst = rnp_scattered_rx;
 
 	return 0;
 }
diff --git a/drivers/net/rnp/rnp_rxtx.h b/drivers/net/rnp/rnp_rxtx.h
index a8fd8d052f..973b667cb2 100644
--- a/drivers/net/rnp/rnp_rxtx.h
+++ b/drivers/net/rnp/rnp_rxtx.h
@@ -76,6 +76,8 @@ struct rnp_rx_queue {
 	uint64_t rx_offloads; /* user set hw offload features */
 	struct rte_mbuf **free_mbufs; /* rx bulk alloc reserve of free mbufs */
 	struct rte_mbuf fake_mbuf; /* dummy mbuf */
+	struct rte_mbuf	*pkt_first_seg; /**< First segment of current packet. */
+	struct rte_mbuf *pkt_last_seg; /**< Last segment of current packet. */
 };
 
 struct rnp_txsw_entry {
-- 
2.25.1

