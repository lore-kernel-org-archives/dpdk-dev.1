Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B0BC3ABDD
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 07:15:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 63CB7402E1;
	Fri, 16 May 2025 09:15:25 +0200 (CEST)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mails.dpdk.org (Postfix) with ESMTP id D595C402AF
 for <dev@dpdk.org>; Fri, 16 May 2025 09:15:22 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.162.112])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ZzJHH2M5Hz1k1M1;
 Fri, 16 May 2025 15:14:35 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id B09591400DD;
 Fri, 16 May 2025 15:15:20 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 16 May 2025 15:15:20 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <lihuisong@huawei.com>, <fengchengwen@huawei.com>,
 <stephen@networkplumber.org>
Subject: [PATCH v5 2/2] net/hns3: fix Rx packet without CRC data
Date: Fri, 16 May 2025 15:15:19 +0800
Message-ID: <20250516071519.3190805-3-huangdengdui@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250516071519.3190805-1-huangdengdui@huawei.com>
References: <20241127100807.683461-1-haijie1@huawei.com>
 <20250516071519.3190805-1-huangdengdui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemo500011.china.huawei.com (7.202.195.194)
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

When KEEP_CRC offload is enabled, the CRC data is still stripped
in following cases:
1. For HIP08 network engine, the packet type is TCP and the length
   is less than or equal to 60B.
2. For HIP09 network engine, the packet type is IP and the length
   is less than or equal to 60B.

So driver has to recaculate packet CRC for this rare scenarios.

In addition, to avoid impacting performance, KEEP_CRC is not
supported when NEON or SVE algorithm is used.

Fixes: 8973d7c4ca12 ("net/hns3: support keeping CRC")
Cc: stable@dpdk.org

Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
Acked-by: Huisong Li <lihuisong@huawei.com>
Acked-by: Jie Hai <haijie1@huawei.com>
---
 drivers/net/hns3/hns3_ethdev.c        |   2 +
 drivers/net/hns3/hns3_ethdev.h        |  23 +++++
 drivers/net/hns3/hns3_rxtx.c          | 129 +++++++++++++++++++++-----
 drivers/net/hns3/hns3_rxtx.h          |   6 ++
 drivers/net/hns3/hns3_rxtx_vec.c      |   3 +-
 drivers/net/hns3/hns3_rxtx_vec_neon.h |  19 ----
 drivers/net/hns3/hns3_rxtx_vec_sve.c  |   3 +-
 7 files changed, 141 insertions(+), 44 deletions(-)

diff --git a/drivers/net/hns3/hns3_ethdev.c b/drivers/net/hns3/hns3_ethdev.c
index 9f99525e70..50c6ed0744 100644
--- a/drivers/net/hns3/hns3_ethdev.c
+++ b/drivers/net/hns3/hns3_ethdev.c
@@ -2743,6 +2743,7 @@ hns3_get_capability(struct hns3_hw *hw)
 		hw->udp_cksum_mode = HNS3_SPECIAL_PORT_SW_CKSUM_MODE;
 		pf->support_multi_tc_pause = false;
 		hw->rx_dma_addr_align = HNS3_RX_DMA_ADDR_ALIGN_64;
+		hw->strip_crc_ptype = HNS3_STRIP_CRC_PTYPE_TCP;
 		return 0;
 	}
 
@@ -2764,6 +2765,7 @@ hns3_get_capability(struct hns3_hw *hw)
 	hw->udp_cksum_mode = HNS3_SPECIAL_PORT_HW_CKSUM_MODE;
 	pf->support_multi_tc_pause = true;
 	hw->rx_dma_addr_align = HNS3_RX_DMA_ADDR_ALIGN_128;
+	hw->strip_crc_ptype = HNS3_STRIP_CRC_PTYPE_IP;
 
 	return 0;
 }
diff --git a/drivers/net/hns3/hns3_ethdev.h b/drivers/net/hns3/hns3_ethdev.h
index 085a83773f..d164b9e38c 100644
--- a/drivers/net/hns3/hns3_ethdev.h
+++ b/drivers/net/hns3/hns3_ethdev.h
@@ -51,6 +51,10 @@
 #define HNS3_SPECIAL_PORT_SW_CKSUM_MODE         0
 #define HNS3_SPECIAL_PORT_HW_CKSUM_MODE         1
 
+#define HNS3_STRIP_CRC_PTYPE_NONE         0
+#define HNS3_STRIP_CRC_PTYPE_TCP          1
+#define HNS3_STRIP_CRC_PTYPE_IP           2
+
 #define HNS3_UC_MACADDR_NUM		128
 #define HNS3_VF_UC_MACADDR_NUM		48
 #define HNS3_MC_MACADDR_NUM		128
@@ -652,6 +656,25 @@ struct hns3_hw {
 	 */
 	uint8_t udp_cksum_mode;
 
+	/*
+	 * When KEEP_CRC offload is enabled, the CRC data of some type packets
+	 * whose length is less than or equal to HNS3_KEEP_CRC_OK_MIN_PKT_LEN
+	 * is still be stripped on some network engine. So here has to use this
+	 * field to distinguish the difference between different network engines.
+	 * value range:
+	 *  - HNS3_STRIP_CRC_PTYPE_TCP
+	 *     This value for HIP08 network engine.
+	 *     Indicates that only the IP-TCP packet type is stripped.
+	 *
+	 *  - HNS3_STRIP_CRC_PTYPE_IP
+	 *     This value for HIP09 network engine.
+	 *     Indicates that all IP packet types are stripped.
+	 *
+	 *  - HNS3_STRIP_CRC_PTYPE_NONE
+	 *     Indicates that all packet types are not stripped.
+	 */
+	uint8_t strip_crc_ptype;
+
 	struct hns3_port_base_vlan_config port_base_vlan_cfg;
 
 	pthread_mutex_t flows_lock; /* rte_flow ops lock */
diff --git a/drivers/net/hns3/hns3_rxtx.c b/drivers/net/hns3/hns3_rxtx.c
index 49b6f16ccd..bde46733b0 100644
--- a/drivers/net/hns3/hns3_rxtx.c
+++ b/drivers/net/hns3/hns3_rxtx.c
@@ -11,6 +11,7 @@
 #include <rte_io.h>
 #include <rte_net.h>
 #include <rte_malloc.h>
+#include <rte_net_crc.h>
 #if defined(RTE_ARCH_ARM64)
 #include <rte_cpuflags.h>
 #include <rte_vect.h>
@@ -94,6 +95,10 @@ hns3_rx_queue_release(void *queue)
 			rte_free(rxq->sw_ring);
 			rxq->sw_ring = NULL;
 		}
+		if (rxq->crc_ctx) {
+			rte_net_crc_free(rxq->crc_ctx);
+			rxq->crc_ctx = NULL;
+		}
 		rte_free(rxq);
 	}
 }
@@ -1768,8 +1773,9 @@ hns3_rx_buf_len_calc(struct rte_mempool *mp, uint16_t *rx_buf_len)
 }
 
 static int
-hns3_rxq_conf_runtime_check(struct hns3_hw *hw, uint16_t buf_size,
-				uint16_t nb_desc)
+hns3_rxq_conf_runtime_check(struct hns3_hw *hw,
+			    const struct rte_eth_rxconf *conf,
+			    uint16_t buf_size, uint16_t nb_desc)
 {
 	struct rte_eth_dev *dev = &rte_eth_devices[hw->data->port_id];
 	eth_rx_burst_t pkt_burst = dev->rx_pkt_burst;
@@ -1802,6 +1808,14 @@ hns3_rxq_conf_runtime_check(struct hns3_hw *hw, uint16_t buf_size,
 			return -EINVAL;
 		}
 	}
+
+	if ((conf->offloads & RTE_ETH_RX_OFFLOAD_KEEP_CRC) &&
+	    pkt_burst != hns3_recv_pkts_simple &&
+	    pkt_burst != hns3_recv_scattered_pkts) {
+		hns3_err(hw, "KEEP_CRC offload is not supported with the current Rx function.");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -1838,7 +1852,7 @@ hns3_rx_queue_conf_check(struct hns3_hw *hw, const struct rte_eth_rxconf *conf,
 	}
 
 	if (hw->data->dev_started) {
-		ret = hns3_rxq_conf_runtime_check(hw, *buf_size, nb_desc);
+		ret = hns3_rxq_conf_runtime_check(hw, conf, *buf_size, nb_desc);
 		if (ret) {
 			hns3_err(hw, "Rx queue runtime setup fail.");
 			return ret;
@@ -1959,6 +1973,15 @@ hns3_rx_queue_setup(struct rte_eth_dev *dev, uint16_t idx, uint16_t nb_desc,
 	else
 		rxq->crc_len = 0;
 
+	rxq->keep_crc_fail_ptype = hw->strip_crc_ptype;
+
+	rxq->crc_ctx = rte_net_crc_set_alg(RTE_NET_CRC_SCALAR, RTE_NET_CRC32_ETH);
+	if (rxq->crc_ctx == NULL) {
+		hns3_err(hw, "Failed to allocate the CRC context.");
+		hns3_rx_queue_release(rxq);
+		return -ENOMEM;
+	}
+
 	rxq->bulk_mbuf_num = 0;
 
 	rte_spinlock_lock(&hw->lock);
@@ -2433,6 +2456,54 @@ hns3_rx_ptp_timestamp_handle(struct hns3_rx_queue *rxq, struct rte_mbuf *mbuf,
 	pf->rx_timestamp = timestamp;
 }
 
+static inline bool
+hns3_need_recalculate_crc(struct hns3_rx_queue *rxq, struct rte_mbuf *m)
+{
+	uint32_t ptype = m->packet_type;
+
+	if (rxq->keep_crc_fail_ptype == HNS3_STRIP_CRC_PTYPE_NONE)
+		return false;
+
+	if (m->pkt_len > HNS3_KEEP_CRC_OK_MIN_PKT_LEN)
+		return false;
+
+	if (!(RTE_ETH_IS_IPV4_HDR(ptype) || RTE_ETH_IS_IPV6_HDR(ptype)))
+		return false;
+
+	if (rxq->keep_crc_fail_ptype == HNS3_STRIP_CRC_PTYPE_TCP)
+		return (ptype & RTE_PTYPE_L4_MASK) == RTE_PTYPE_L4_TCP;
+
+	return true;
+}
+
+/*
+ * The hns3 driver requires that mbuf size must be at least 512B.
+ * When CRC is stripped by hardware, the pkt_len must be less than
+ * or equal to 60B. Therefore, the space of the mbuf is enough
+ * to insert the CRC.
+ */
+static_assert(HNS3_KEEP_CRC_OK_MIN_PKT_LEN < HNS3_MIN_BD_BUF_SIZE,
+	      "buffer size too small to insert CRC");
+
+static inline void
+hns3_recalculate_crc(struct hns3_rx_queue *rxq, struct rte_mbuf *m)
+{
+	char *append_data;
+	uint32_t crc;
+
+	crc = rte_net_crc_calc(rxq->crc_ctx, rte_pktmbuf_mtod(m, void *), m->data_len);
+
+	/*
+	 * After CRC is stripped by hardware, pkt_len and data_len do not
+	 * contain the CRC length. Therefore, after CRC data is appended
+	 * by PMD again.
+	 */
+	append_data = rte_pktmbuf_append(m, RTE_ETHER_CRC_LEN);
+
+	/* CRC data is binary data and does not care about the byte order. */
+	memcpy(append_data, &crc, RTE_ETHER_CRC_LEN);
+}
+
 uint16_t
 hns3_recv_pkts_simple(void *rx_queue,
 		      struct rte_mbuf **rx_pkts,
@@ -2503,8 +2574,7 @@ hns3_recv_pkts_simple(void *rx_queue,
 		rxdp->rx.bd_base_info = 0;
 
 		rxm->data_off = RTE_PKTMBUF_HEADROOM;
-		rxm->pkt_len = (uint16_t)(rte_le_to_cpu_16(rxd.rx.pkt_len)) -
-				rxq->crc_len;
+		rxm->pkt_len = (uint16_t)(rte_le_to_cpu_16(rxd.rx.pkt_len));
 		rxm->data_len = rxm->pkt_len;
 		rxm->port = rxq->port_id;
 		rxm->hash.rss = rte_le_to_cpu_32(rxd.rx.rss_hash);
@@ -2529,6 +2599,12 @@ hns3_recv_pkts_simple(void *rx_queue,
 		if (rxm->packet_type == RTE_PTYPE_L2_ETHER_TIMESYNC)
 			rxm->ol_flags |= RTE_MBUF_F_RX_IEEE1588_PTP;
 
+		if (unlikely(rxq->crc_len > 0) &&
+		    hns3_need_recalculate_crc(rxq, rxm))
+			hns3_recalculate_crc(rxq, rxm);
+		rxm->pkt_len -= rxq->crc_len;
+		rxm->data_len -= rxq->crc_len;
+
 		hns3_rxd_to_vlan_tci(rxq, rxm, l234_info, &rxd);
 
 		/* Increment bytes counter  */
@@ -2695,10 +2771,10 @@ hns3_recv_scattered_pkts(void *rx_queue,
 
 		rxm->data_off = RTE_PKTMBUF_HEADROOM;
 		rxm->data_len = rte_le_to_cpu_16(rxd.rx.size);
+		rxm->next = NULL;
 
 		if (!(bd_base_info & BIT(HNS3_RXD_FE_B))) {
 			last_seg = rxm;
-			rxm->next = NULL;
 			continue;
 		}
 
@@ -2713,22 +2789,6 @@ hns3_recv_scattered_pkts(void *rx_queue,
 		 */
 		first_seg->pkt_len = rte_le_to_cpu_16(rxd.rx.pkt_len);
 
-		/*
-		 * This is the last buffer of the received packet. If the CRC
-		 * is not stripped by the hardware:
-		 *  - Subtract the CRC length from the total packet length.
-		 *  - If the last buffer only contains the whole CRC or a part
-		 *  of it, free the mbuf associated to the last buffer. If part
-		 *  of the CRC is also contained in the previous mbuf, subtract
-		 *  the length of that CRC part from the data length of the
-		 *  previous mbuf.
-		 */
-		rxm->next = NULL;
-		if (unlikely(rxq->crc_len > 0)) {
-			first_seg->pkt_len -= rxq->crc_len;
-			recalculate_data_len(last_seg, rxm, rxq);
-		}
-
 		first_seg->port = rxq->port_id;
 		first_seg->hash.rss = rte_le_to_cpu_32(rxd.rx.rss_hash);
 		first_seg->ol_flags |= RTE_MBUF_F_RX_RSS_HASH;
@@ -2757,6 +2817,31 @@ hns3_recv_scattered_pkts(void *rx_queue,
 
 		if (first_seg->packet_type == RTE_PTYPE_L2_ETHER_TIMESYNC)
 			rxm->ol_flags |= RTE_MBUF_F_RX_IEEE1588_PTP;
+		/*
+		 * This is the last buffer of the received packet. If the CRC
+		 * is not stripped by the hardware:
+		 *  - Subtract the CRC length from the total packet length.
+		 *  - If the last buffer only contains the whole CRC or a part
+		 *  of it, free the mbuf associated to the last buffer. If part
+		 *  of the CRC is also contained in the previous mbuf, subtract
+		 *  the length of that CRC part from the data length of the
+		 *  previous mbuf.
+		 *
+		 * In addition, the CRC is still stripped for a kind of packets
+		 * in hns3 NIC:
+		 * 1. All IP-TCP packet whose the length is less than and equal
+		 *    to 60 Byte (no CRC) on HIP08 network engine.
+		 * 2. All IP packet whose the length is less than and equal to
+		 *    60 Byte (no CRC) on HIP09 network engine.
+		 * In this case, the PMD calculates the CRC and appends it to
+		 * mbuf.
+		 */
+		if (unlikely(rxq->crc_len > 0)) {
+			if (hns3_need_recalculate_crc(rxq, first_seg))
+				hns3_recalculate_crc(rxq, first_seg);
+			first_seg->pkt_len -= rxq->crc_len;
+			recalculate_data_len(last_seg, rxm, rxq);
+		}
 
 		hns3_rxd_to_vlan_tci(rxq, first_seg, l234_info, &rxd);
 
diff --git a/drivers/net/hns3/hns3_rxtx.h b/drivers/net/hns3/hns3_rxtx.h
index 0bce89ebaa..b602b2326b 100644
--- a/drivers/net/hns3/hns3_rxtx.h
+++ b/drivers/net/hns3/hns3_rxtx.h
@@ -178,6 +178,8 @@
 		(HNS3_TXD_VLD_CMD | HNS3_TXD_FE_CMD | HNS3_TXD_DEFAULT_BDTYPE)
 #define HNS3_TXD_SEND_SIZE_SHIFT	16
 
+#define HNS3_KEEP_CRC_OK_MIN_PKT_LEN	60
+
 enum hns3_pkt_l2t_type {
 	HNS3_L2_TYPE_UNICAST,
 	HNS3_L2_TYPE_MULTICAST,
@@ -341,6 +343,7 @@ struct hns3_rx_queue {
 	 */
 	uint8_t pvid_sw_discard_en:1;
 	uint8_t ptype_en:1;          /* indicate if the ptype field enabled */
+	uint8_t keep_crc_fail_ptype:2;
 
 	uint64_t mbuf_initializer; /* value to init mbufs used with vector rx */
 	/* offset_table: used for vector, to solve execute re-order problem */
@@ -362,6 +365,9 @@ struct hns3_rx_queue {
 
 	struct rte_mbuf fake_mbuf; /* fake mbuf used with vector rx */
 
+	/* The CRC context, which is used by software to calculate CRC data. */
+	struct rte_net_crc *crc_ctx;
+
 	/*
 	 * The following fields are not accessed in the I/O path, so they are
 	 * placed at the end.
diff --git a/drivers/net/hns3/hns3_rxtx_vec.c b/drivers/net/hns3/hns3_rxtx_vec.c
index 9708ec614e..bf37ce51b1 100644
--- a/drivers/net/hns3/hns3_rxtx_vec.c
+++ b/drivers/net/hns3/hns3_rxtx_vec.c
@@ -185,7 +185,8 @@ hns3_rx_check_vec_support(struct rte_eth_dev *dev)
 	struct rte_eth_rxmode *rxmode = &dev->data->dev_conf.rxmode;
 	uint64_t offloads_mask = RTE_ETH_RX_OFFLOAD_TCP_LRO |
 				 RTE_ETH_RX_OFFLOAD_VLAN |
-				 RTE_ETH_RX_OFFLOAD_TIMESTAMP;
+				 RTE_ETH_RX_OFFLOAD_TIMESTAMP |
+				 RTE_ETH_RX_OFFLOAD_KEEP_CRC;
 
 	if (dev->data->scattered_rx)
 		return -ENOTSUP;
diff --git a/drivers/net/hns3/hns3_rxtx_vec_neon.h b/drivers/net/hns3/hns3_rxtx_vec_neon.h
index f2e155c9f5..8fd81b8612 100644
--- a/drivers/net/hns3/hns3_rxtx_vec_neon.h
+++ b/drivers/net/hns3/hns3_rxtx_vec_neon.h
@@ -148,14 +148,6 @@ hns3_recv_burst_vec(struct hns3_rx_queue *__restrict rxq,
 		8, 9, 10, 11,	         /* rx.rss_hash to rte_mbuf.hash.rss */
 	};
 
-	uint16x8_t crc_adjust = {
-		0, 0,         /* ignore pkt_type field */
-		rxq->crc_len, /* sub crc on pkt_len */
-		0,            /* ignore high-16bits of pkt_len */
-		rxq->crc_len, /* sub crc on data_len */
-		0, 0, 0,      /* ignore non-length fields */
-	};
-
 	/* compile-time verifies the shuffle mask */
 	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, pkt_len) !=
 			 offsetof(struct rte_mbuf, rx_descriptor_fields1) + 4);
@@ -171,7 +163,6 @@ hns3_recv_burst_vec(struct hns3_rx_queue *__restrict rxq,
 		uint8x16_t pkt_mb1, pkt_mb2, pkt_mb3, pkt_mb4;
 		uint64x2_t mbp1, mbp2;
 		uint16x4_t bd_vld = {0};
-		uint16x8_t tmp;
 		uint64_t stat;
 
 		/* calc how many bd valid */
@@ -225,16 +216,6 @@ hns3_recv_burst_vec(struct hns3_rx_queue *__restrict rxq,
 		pkt_mb3 = vqtbl2q_u8(pkt_mbuf3, shuf_desc_fields_msk);
 		pkt_mb4 = vqtbl2q_u8(pkt_mbuf4, shuf_desc_fields_msk);
 
-		/* 4 packets remove crc */
-		tmp = vsubq_u16(vreinterpretq_u16_u8(pkt_mb1), crc_adjust);
-		pkt_mb1 = vreinterpretq_u8_u16(tmp);
-		tmp = vsubq_u16(vreinterpretq_u16_u8(pkt_mb2), crc_adjust);
-		pkt_mb2 = vreinterpretq_u8_u16(tmp);
-		tmp = vsubq_u16(vreinterpretq_u16_u8(pkt_mb3), crc_adjust);
-		pkt_mb3 = vreinterpretq_u8_u16(tmp);
-		tmp = vsubq_u16(vreinterpretq_u16_u8(pkt_mb4), crc_adjust);
-		pkt_mb4 = vreinterpretq_u8_u16(tmp);
-
 		/* save packet info to rx_pkts mbuf */
 		vst1q_u8((void *)&sw_ring[pos + 0].mbuf->rx_descriptor_fields1,
 			 pkt_mb1);
diff --git a/drivers/net/hns3/hns3_rxtx_vec_sve.c b/drivers/net/hns3/hns3_rxtx_vec_sve.c
index 8aa4448558..67c87f570e 100644
--- a/drivers/net/hns3/hns3_rxtx_vec_sve.c
+++ b/drivers/net/hns3/hns3_rxtx_vec_sve.c
@@ -36,8 +36,7 @@ hns3_desc_parse_field_sve(struct hns3_rx_queue *rxq,
 		/* init rte_mbuf.rearm_data last 64-bit */
 		rx_pkts[i]->ol_flags = RTE_MBUF_F_RX_RSS_HASH;
 		rx_pkts[i]->hash.rss = rxdp[i].rx.rss_hash;
-		rx_pkts[i]->pkt_len = rte_le_to_cpu_16(rxdp[i].rx.pkt_len) -
-					rxq->crc_len;
+		rx_pkts[i]->pkt_len = rte_le_to_cpu_16(rxdp[i].rx.pkt_len);
 		rx_pkts[i]->data_len = rx_pkts[i]->pkt_len;
 
 		l234_info = rxdp[i].rx.l234_info;
-- 
2.33.0

