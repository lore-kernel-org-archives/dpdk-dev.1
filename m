Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220C8CAC5A5
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 07:55:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05A8940687;
	Wed, 24 Sep 2025 09:53:59 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.5])
 by mails.dpdk.org (Postfix) with ESMTP id 9043140B91
 for <dev@dpdk.org>; Wed, 24 Sep 2025 09:53:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=+7xwtJjTlZANeagRsYEmO/Iv0PVPnTNa1jYpr0VESGE=;
 b=SkUcB6NrZpucBYJCpXjhmU5cHLettNEAGaS/xXcZ5pwiDqZCLAwNOQcG4Ca+AX
 V3z8Q5ArdspIDw7ayc2BY9dUlT0GLeKZf3GDsG+87Kma3XUg3IJufFAwLlz8kiy4
 z4uzWU/dWnT2HcmtapLT/nuXRpN9hQYZEfZY90TcEwYy4=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgDnT+VCo9No80coBA--.31336S17;
 Wed, 24 Sep 2025 15:53:48 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: gongfan1@huawei.com, Feifei Wang <wangfeifei40@huawei.com>,
 Xin Wang <wangxin679@h-partners.com>, Yi Chen <chenyi221@huawei.com>
Subject: [V13 13/18] net/hinic3: add dev ops
Date: Wed, 24 Sep 2025 15:52:00 +0800
Message-ID: <20250924075216.18750-14-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250924075216.18750-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250924075216.18750-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgDnT+VCo9No80coBA--.31336S17
X-Coremail-Antispam: 1Uf129KBjvtXoWkGry3GF1fXw1xKFy3tFW8JFb_yoW8Wr1kKw
 c_ury8Zw1qgw1UCan8t3y0kF1ftryIgF9FqrnYqa1IyryxCr45Xws3Zr1DW3sxW3yFga42
 9F1a9wsI9w1kZrn8WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-
 sFnT9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8OyCtUUUUU==
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiBhXSCmjTmswiKQAAst
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

From: Feifei Wang <wangfeifei40@huawei.com>

Add ops related function codes.

Signed-off-by: Feifei Wang <wangfeifei40@huawei.com>
Signed-off-by: Xin Wang <wangxin679@h-partners.com>
Reviewed-by: Yi Chen <chenyi221@huawei.com>
---
 drivers/net/hinic3/hinic3_ethdev.c | 2617 ++++++++++++++++++++++++++++
 drivers/net/hinic3/hinic3_ethdev.h |   24 +
 drivers/net/hinic3/hinic3_nic_io.c |  802 +++++++++
 drivers/net/hinic3/hinic3_nic_io.h |  169 ++
 drivers/net/hinic3/hinic3_rx.c     |  772 ++++++++
 drivers/net/hinic3/hinic3_rx.h     |  354 ++++
 drivers/net/hinic3/hinic3_tx.c     |  251 +++
 drivers/net/hinic3/hinic3_tx.h     |  313 ++++
 drivers/net/hinic3/meson.build     |    3 +
 9 files changed, 5305 insertions(+)
 create mode 100644 drivers/net/hinic3/hinic3_nic_io.c
 create mode 100644 drivers/net/hinic3/hinic3_nic_io.h
 create mode 100644 drivers/net/hinic3/hinic3_rx.c
 create mode 100644 drivers/net/hinic3/hinic3_rx.h
 create mode 100644 drivers/net/hinic3/hinic3_tx.c
 create mode 100644 drivers/net/hinic3/hinic3_tx.h

diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index d4f1c592cd..1846f55183 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -15,8 +15,301 @@
 #include "base/hinic3_hw_comm.h"
 #include "base/hinic3_nic_cfg.h"
 #include "base/hinic3_nic_event.h"
+#include "hinic3_nic_io.h"
+#include "hinic3_tx.h"
+#include "hinic3_rx.h"
 #include "hinic3_ethdev.h"
 
+#define HINIC3_MIN_RX_BUF_SIZE 1024
+
+#define HINIC3_DEFAULT_BURST_SIZE 32
+#define HINIC3_DEFAULT_NB_QUEUES  1
+#define HINIC3_DEFAULT_RING_SIZE  1024
+#define HINIC3_MAX_LRO_SIZE	  65536
+
+#define HINIC3_DEFAULT_RX_FREE_THRESH 32u
+#define HINIC3_DEFAULT_TX_FREE_THRESH 32u
+
+#define HINIC3_RX_WAIT_CYCLE_THRESH 500
+
+/**
+ * Get the 32-bit VFTA bit mask for the lower 5 bits of the VLAN ID.
+ *
+ * Vlan_id is a 12 bit number. The VFTA array is actually a 4096 bit array,
+ * 128 of 32bit elements. 2^5 = 32. The val of lower 5 bits specifies the bit
+ * in the 32bit element. The higher 7 bit val specifies VFTA array index.
+ */
+#define HINIC3_VFTA_BIT(vlan_id) (1 << ((vlan_id) & 0x1F))
+/**
+ * Get the VFTA index from the upper 7 bits of the VLAN ID.
+ */
+#define HINIC3_VFTA_IDX(vlan_id) ((vlan_id) >> 5)
+
+#define HINIC3_LRO_DEFAULT_TIME_LIMIT 16
+#define HINIC3_LRO_UNIT_WQE_SIZE      1024 /**< Bytes. */
+
+#define HINIC3_MAX_RX_PKT_LEN(rxmod) ((rxmod).mtu)
+int hinic3_logtype; /**< Driver-specific log messages type. */
+
+/**
+ * The different receive modes for the NIC.
+ *
+ * The receive modes are represented as bit flags that control how the
+ * NIC handles various types of network traffic.
+ */
+enum hinic3_rx_mod {
+	/* Enable unicast receive mode. */
+	HINIC3_RX_MODE_UC = 1 << 0,
+	/* Enable multicast receive mode. */
+	HINIC3_RX_MODE_MC = 1 << 1,
+	/* Enable broadcast receive mode. */
+	HINIC3_RX_MODE_BC = 1 << 2,
+	/* Enable receive mode for all multicast addresses. */
+	HINIC3_RX_MODE_MC_ALL = 1 << 3,
+	/* Enable promiscuous mode, receiving all packets. */
+	HINIC3_RX_MODE_PROMISC = 1 << 4,
+};
+
+#define HINIC3_DEFAULT_RX_MODE \
+	(HINIC3_RX_MODE_UC | HINIC3_RX_MODE_MC | HINIC3_RX_MODE_BC)
+
+struct hinic3_xstats_name_off {
+	char name[RTE_ETH_XSTATS_NAME_SIZE];
+	uint32_t offset;
+};
+
+#define HINIC3_FUNC_STAT(_stat_item)                                       \
+	{                                                                  \
+		.name = #_stat_item,                                       \
+		.offset = offsetof(struct hinic3_vport_stats, _stat_item), \
+	}
+
+static const struct hinic3_xstats_name_off hinic3_vport_stats_strings[] = {
+	HINIC3_FUNC_STAT(tx_unicast_pkts_vport),
+	HINIC3_FUNC_STAT(tx_unicast_bytes_vport),
+	HINIC3_FUNC_STAT(tx_multicast_pkts_vport),
+	HINIC3_FUNC_STAT(tx_multicast_bytes_vport),
+	HINIC3_FUNC_STAT(tx_broadcast_pkts_vport),
+	HINIC3_FUNC_STAT(tx_broadcast_bytes_vport),
+
+	HINIC3_FUNC_STAT(rx_unicast_pkts_vport),
+	HINIC3_FUNC_STAT(rx_unicast_bytes_vport),
+	HINIC3_FUNC_STAT(rx_multicast_pkts_vport),
+	HINIC3_FUNC_STAT(rx_multicast_bytes_vport),
+	HINIC3_FUNC_STAT(rx_broadcast_pkts_vport),
+	HINIC3_FUNC_STAT(rx_broadcast_bytes_vport),
+
+	HINIC3_FUNC_STAT(tx_discard_vport),
+	HINIC3_FUNC_STAT(rx_discard_vport),
+	HINIC3_FUNC_STAT(tx_err_vport),
+	HINIC3_FUNC_STAT(rx_err_vport),
+};
+
+#define HINIC3_VPORT_XSTATS_NUM RTE_DIM(hinic3_vport_stats_strings)
+
+#define HINIC3_PORT_STAT(_stat_item)                                       \
+	{                                                                  \
+		.name = #_stat_item,                                       \
+		.offset = offsetof(struct mag_phy_port_stats, _stat_item), \
+	}
+
+static const struct hinic3_xstats_name_off hinic3_phyport_stats_strings[] = {
+	HINIC3_PORT_STAT(mac_tx_fragment_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_undersize_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_undermin_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_64_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_65_127_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_128_255_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_256_511_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_512_1023_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_1024_1518_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_1519_2047_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_2048_4095_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_4096_8191_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_8192_9216_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_9217_12287_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_12288_16383_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_1519_max_bad_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_1519_max_good_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_oversize_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_jabber_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_bad_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_bad_oct_num),
+	HINIC3_PORT_STAT(mac_tx_good_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_good_oct_num),
+	HINIC3_PORT_STAT(mac_tx_total_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_total_oct_num),
+	HINIC3_PORT_STAT(mac_tx_uni_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_multi_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_broad_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_pause_num),
+	HINIC3_PORT_STAT(mac_tx_pfc_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_pfc_pri0_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_pfc_pri1_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_pfc_pri2_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_pfc_pri3_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_pfc_pri4_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_pfc_pri5_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_pfc_pri6_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_pfc_pri7_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_control_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_err_all_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_from_app_good_pkt_num),
+	HINIC3_PORT_STAT(mac_tx_from_app_bad_pkt_num),
+
+	HINIC3_PORT_STAT(mac_rx_fragment_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_undersize_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_undermin_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_64_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_65_127_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_128_255_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_256_511_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_512_1023_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_1024_1518_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_1519_2047_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_2048_4095_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_4096_8191_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_8192_9216_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_9217_12287_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_12288_16383_oct_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_1519_max_bad_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_1519_max_good_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_oversize_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_jabber_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_bad_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_bad_oct_num),
+	HINIC3_PORT_STAT(mac_rx_good_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_good_oct_num),
+	HINIC3_PORT_STAT(mac_rx_total_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_total_oct_num),
+	HINIC3_PORT_STAT(mac_rx_uni_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_multi_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_broad_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_pause_num),
+	HINIC3_PORT_STAT(mac_rx_pfc_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_pfc_pri0_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_pfc_pri1_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_pfc_pri2_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_pfc_pri3_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_pfc_pri4_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_pfc_pri5_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_pfc_pri6_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_pfc_pri7_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_control_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_sym_err_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_fcs_err_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_send_app_good_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_send_app_bad_pkt_num),
+	HINIC3_PORT_STAT(mac_rx_unfilter_pkt_num),
+};
+
+#define HINIC3_PHYPORT_XSTATS_NUM RTE_DIM(hinic3_phyport_stats_strings)
+
+#define HINIC3_RXQ_STAT(_stat_item)                                      \
+	{                                                                \
+		.name = #_stat_item,                                     \
+		.offset = offsetof(struct hinic3_rxq_stats, _stat_item), \
+	}
+
+/**
+ * The name and offset field of RXQ statistic items.
+ *
+ * The inclusion of additional statistics depends on the compilation flags:
+ * - `HINIC3_XSTAT_RXBUF_INFO` enables buffer-related stats.
+ * - `HINIC3_XSTAT_PROF_RX` enables performance timing stats.
+ * - `HINIC3_XSTAT_MBUF_USE` enables memory buffer usage stats.
+ */
+static const struct hinic3_xstats_name_off hinic3_rxq_stats_strings[] = {
+	HINIC3_RXQ_STAT(rx_nombuf),
+	HINIC3_RXQ_STAT(burst_pkts),
+	HINIC3_RXQ_STAT(errors),
+	HINIC3_RXQ_STAT(csum_errors),
+	HINIC3_RXQ_STAT(other_errors),
+	HINIC3_RXQ_STAT(empty),
+
+#ifdef HINIC3_XSTAT_RXBUF_INFO
+	HINIC3_RXQ_STAT(rx_mbuf),
+	HINIC3_RXQ_STAT(rx_avail),
+	HINIC3_RXQ_STAT(rx_hole),
+#endif
+
+#ifdef HINIC3_XSTAT_PROF_RX
+	HINIC3_RXQ_STAT(app_tsc),
+	HINIC3_RXQ_STAT(pmd_tsc),
+#endif
+
+#ifdef HINIC3_XSTAT_MBUF_USE
+	HINIC3_RXQ_STAT(rx_alloc_mbuf_bytes),
+	HINIC3_RXQ_STAT(rx_free_mbuf_bytes),
+	HINIC3_RXQ_STAT(rx_left_mbuf_bytes),
+#endif
+};
+
+#define HINIC3_RXQ_XSTATS_NUM RTE_DIM(hinic3_rxq_stats_strings)
+
+#define HINIC3_TXQ_STAT(_stat_item)                                      \
+	{                                                                \
+		.name = #_stat_item,                                     \
+		.offset = offsetof(struct hinic3_txq_stats, _stat_item), \
+	}
+
+/**
+ * The name and offset field of TXQ statistic items.
+ *
+ * The inclusion of additional statistics depends on the compilation flags:
+ * - `HINIC3_XSTAT_PROF_TX` enables performance timing stats.
+ * - `HINIC3_XSTAT_MBUF_USE` enables memory buffer usage stats.
+ */
+static const struct hinic3_xstats_name_off hinic3_txq_stats_strings[] = {
+	HINIC3_TXQ_STAT(tx_busy),
+	HINIC3_TXQ_STAT(offload_errors),
+	HINIC3_TXQ_STAT(burst_pkts),
+	HINIC3_TXQ_STAT(sge_len0),
+	HINIC3_TXQ_STAT(mbuf_null),
+
+#ifdef HINIC3_XSTAT_PROF_TX
+	HINIC3_TXQ_STAT(app_tsc),
+	HINIC3_TXQ_STAT(pmd_tsc),
+#endif
+
+#ifdef HINIC3_XSTAT_MBUF_USE
+	HINIC3_TXQ_STAT(tx_left_mbuf_bytes),
+#endif
+};
+
+#define HINIC3_TXQ_XSTATS_NUM RTE_DIM(hinic3_txq_stats_strings)
+
+static uint32_t
+hinic3_xstats_calc_num(struct hinic3_nic_dev *nic_dev)
+{
+	if (HINIC3_IS_VF(nic_dev->hwdev)) {
+		return (HINIC3_VPORT_XSTATS_NUM +
+			HINIC3_RXQ_XSTATS_NUM * nic_dev->num_rqs +
+			HINIC3_TXQ_XSTATS_NUM * nic_dev->num_sqs);
+	} else {
+		return (HINIC3_VPORT_XSTATS_NUM + HINIC3_PHYPORT_XSTATS_NUM +
+			HINIC3_RXQ_XSTATS_NUM * nic_dev->num_rqs +
+			HINIC3_TXQ_XSTATS_NUM * nic_dev->num_sqs);
+	}
+}
+
+#define HINIC3_MAX_QUEUE_DEPTH 16384
+#define HINIC3_MIN_QUEUE_DEPTH 128
+#define HINIC3_TXD_ALIGN       1
+#define HINIC3_RXD_ALIGN       1
+
+static const struct rte_eth_desc_lim hinic3_rx_desc_lim = {
+	.nb_max = HINIC3_MAX_QUEUE_DEPTH,
+	.nb_min = HINIC3_MIN_QUEUE_DEPTH,
+	.nb_align = HINIC3_RXD_ALIGN,
+};
+
+static const struct rte_eth_desc_lim hinic3_tx_desc_lim = {
+	.nb_max = HINIC3_MAX_QUEUE_DEPTH,
+	.nb_min = HINIC3_MIN_QUEUE_DEPTH,
+	.nb_align = HINIC3_TXD_ALIGN,
+};
+
 /*
  * Init mac_vlan table in hardwares.
  *
@@ -254,3 +547,2327 @@ hinic3_deinit_sw_rxtxqs(struct hinic3_nic_dev *nic_dev)
 	rte_free(nic_dev->rxqs);
 	nic_dev->rxqs = NULL;
 }
+
+/**
+ * Look up or creates a memory pool for storing packet buffers used in copy
+ * operations.
+ *
+ * @param[in] nic_dev
+ * Pointer to NIC device structure.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ * `-ENOMEM`: Memory pool creation fails.
+ */
+static int
+hinic3_copy_mempool_init(struct hinic3_nic_dev *nic_dev)
+{
+	nic_dev->cpy_mpool = rte_mempool_lookup(HINCI3_CPY_MEMPOOL_NAME);
+	if (nic_dev->cpy_mpool == NULL) {
+		nic_dev->cpy_mpool = rte_pktmbuf_pool_create(HINCI3_CPY_MEMPOOL_NAME,
+			HINIC3_COPY_MEMPOOL_DEPTH, HINIC3_COPY_MEMPOOL_CACHE,
+			0, HINIC3_COPY_MBUF_SIZE, rte_socket_id());
+		if (nic_dev->cpy_mpool == NULL) {
+			PMD_DRV_LOG(ERR,
+				    "Create copy mempool failed, errno: %d, dev_name: %s",
+				    rte_errno, HINCI3_CPY_MEMPOOL_NAME);
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * Clear the reference to the copy memory pool without freeing it.
+ *
+ * @param[in] nic_dev
+ * Pointer to NIC device structure.
+ */
+static void
+hinic3_copy_mempool_uninit(struct hinic3_nic_dev *nic_dev)
+{
+	nic_dev->cpy_mpool = NULL;
+}
+
+/**
+ * Interrupt handler triggered by NIC for handling specific event.
+ *
+ * @param[in] param
+ * The address of parameter (struct rte_eth_dev *) registered before.
+ */
+static void
+hinic3_dev_interrupt_handler(void *param)
+{
+	struct rte_eth_dev *dev = param;
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+
+	if (!hinic3_get_bit(HINIC3_DEV_INTR_EN, &nic_dev->dev_status)) {
+		PMD_DRV_LOG(WARNING,
+			    "Intr is disabled, ignore intr event, dev_name: %s, port_id: %d",
+			    nic_dev->dev_name, dev->data->port_id);
+		return;
+	}
+
+	/* Aeq0 msg handler. */
+	hinic3_dev_handle_aeq_event(nic_dev->hwdev, param);
+}
+
+/**
+ * Do the config for TX/Rx queues, include queue number, mtu size and RSS.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+hinic3_dev_configure(struct rte_eth_dev *dev)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+
+	nic_dev->num_sqs = dev->data->nb_tx_queues;
+	nic_dev->num_rqs = dev->data->nb_rx_queues;
+
+	nic_dev->mtu_size =
+		(uint16_t)HINIC3_PKTLEN_TO_MTU(HINIC3_MAX_RX_PKT_LEN(dev->data->dev_conf.rxmode));
+	if (dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_RSS_FLAG)
+		dev->data->dev_conf.rxmode.offloads |=
+			RTE_ETH_RX_OFFLOAD_RSS_HASH;
+
+	/* Clear fdir filter. */
+	hinic3_free_fdir_filter(dev);
+
+	return 0;
+}
+
+/**
+ * Get information about the device.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ * @param[out] info
+ * Info structure for ethernet device.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+hinic3_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *info)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+
+	info->max_rx_queues = nic_dev->max_rqs;
+	info->max_tx_queues = nic_dev->max_sqs;
+	info->min_rx_bufsize = HINIC3_MIN_RX_BUF_SIZE;
+	info->max_rx_pktlen = HINIC3_MAX_JUMBO_FRAME_SIZE;
+	info->max_mac_addrs = HINIC3_MAX_UC_MAC_ADDRS;
+	info->min_mtu = HINIC3_MIN_MTU_SIZE;
+	info->max_mtu = HINIC3_MAX_MTU_SIZE;
+	info->max_lro_pkt_size = HINIC3_MAX_LRO_SIZE;
+
+	info->rx_queue_offload_capa = 0;
+	info->rx_offload_capa =
+		RTE_ETH_RX_OFFLOAD_VLAN_STRIP | RTE_ETH_RX_OFFLOAD_IPV4_CKSUM |
+		RTE_ETH_RX_OFFLOAD_UDP_CKSUM | RTE_ETH_RX_OFFLOAD_TCP_CKSUM |
+		RTE_ETH_RX_OFFLOAD_SCTP_CKSUM | RTE_ETH_RX_OFFLOAD_VLAN_FILTER |
+		RTE_ETH_RX_OFFLOAD_SCATTER | RTE_ETH_RX_OFFLOAD_TCP_LRO |
+		RTE_ETH_RX_OFFLOAD_RSS_HASH;
+
+	info->tx_queue_offload_capa = 0;
+	info->tx_offload_capa =
+		RTE_ETH_TX_OFFLOAD_VLAN_INSERT | RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |
+		RTE_ETH_TX_OFFLOAD_UDP_CKSUM | RTE_ETH_TX_OFFLOAD_TCP_CKSUM |
+		RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |
+		RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |
+		RTE_ETH_TX_OFFLOAD_TCP_TSO | RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
+
+	info->hash_key_size = HINIC3_RSS_KEY_SIZE;
+	info->reta_size = HINIC3_RSS_INDIR_SIZE;
+	info->flow_type_rss_offloads = HINIC3_RSS_OFFLOAD_ALL;
+
+	info->rx_desc_lim = hinic3_rx_desc_lim;
+	info->tx_desc_lim = hinic3_tx_desc_lim;
+
+	/* Driver-preferred rx/tx parameters. */
+	info->default_rxportconf.burst_size = HINIC3_DEFAULT_BURST_SIZE;
+	info->default_txportconf.burst_size = HINIC3_DEFAULT_BURST_SIZE;
+	info->default_rxportconf.nb_queues = HINIC3_DEFAULT_NB_QUEUES;
+	info->default_txportconf.nb_queues = HINIC3_DEFAULT_NB_QUEUES;
+	info->default_rxportconf.ring_size = HINIC3_DEFAULT_RING_SIZE;
+	info->default_txportconf.ring_size = HINIC3_DEFAULT_RING_SIZE;
+
+	return 0;
+}
+
+static int
+hinic3_fw_version_get(struct rte_eth_dev *dev, char *fw_version, size_t fw_size)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	char mgmt_ver[MGMT_VERSION_MAX_LEN] = {0};
+	int err;
+
+	err = hinic3_get_mgmt_version(nic_dev->hwdev, mgmt_ver,
+				      HINIC3_MGMT_VERSION_MAX_LEN);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Get fw version failed");
+		return -EIO;
+	}
+
+	if (fw_size < strlen(mgmt_ver) + 1)
+		return (strlen(mgmt_ver) + 1);
+
+	strlcpy(fw_version, mgmt_ver, fw_size);
+
+	return 0;
+}
+
+/**
+ * Set ethernet device link state up.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+hinic3_dev_set_link_up(struct rte_eth_dev *dev)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	int err;
+
+	/*
+	 * Vport enable will set function valid in mpu.
+	 * So dev start status need to be checked before vport enable.
+	 */
+	if (hinic3_get_bit(HINIC3_DEV_START, &nic_dev->dev_status)) {
+		err = hinic3_set_vport_enable(nic_dev->hwdev, true);
+		if (err) {
+			PMD_DRV_LOG(ERR, "Enable vport failed, dev_name: %s",
+				    nic_dev->dev_name);
+			return err;
+		}
+	}
+
+	/* Link status follow phy port status, mpu will open pma. */
+	err = hinic3_set_port_enable(nic_dev->hwdev, true);
+	if (err) {
+		PMD_DRV_LOG(ERR,
+			    "Set MAC link up failed, dev_name: %s, port_id: %d",
+			    nic_dev->dev_name, dev->data->port_id);
+		return err;
+	}
+
+	return 0;
+}
+
+/**
+ * Set ethernet device link state down.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+hinic3_dev_set_link_down(struct rte_eth_dev *dev)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	int err;
+
+	err = hinic3_set_vport_enable(nic_dev->hwdev, false);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Disable vport failed, dev_name: %s",
+			    nic_dev->dev_name);
+		return err;
+	}
+
+	/* Link status follow phy port status, mpu will close pma. */
+	err = hinic3_set_port_enable(nic_dev->hwdev, false);
+	if (err) {
+		PMD_DRV_LOG(ERR,
+			"Set MAC link down failed, dev_name: %s, port_id: %d",
+			nic_dev->dev_name, dev->data->port_id);
+		return err;
+	}
+
+	return 0;
+}
+
+/**
+ * Get device physical link information.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ * @param[in] wait_to_complete
+ * Wait for request completion.
+ *
+ * @return
+ * 0 : Link status changed
+ * -1 : Link status not changed.
+ */
+static int
+hinic3_link_update(struct rte_eth_dev *dev, int wait_to_complete)
+{
+#define CHECK_INTERVAL	10  /**< 10ms. */
+#define MAX_REPEAT_TIME 100 /**< 1s (100 * 10ms) in total. */
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	struct rte_eth_link link;
+	uint8_t link_state;
+	unsigned int rep_cnt = MAX_REPEAT_TIME;
+	int ret;
+
+	memset(&link, 0, sizeof(link));
+	do {
+		/* Get link status information from hardware. */
+		ret = hinic3_get_link_state(nic_dev->hwdev, &link_state);
+		if (ret) {
+			link.link_status = RTE_ETH_LINK_DOWN;
+			link.link_speed = RTE_ETH_SPEED_NUM_NONE;
+			link.link_duplex = RTE_ETH_LINK_HALF_DUPLEX;
+			link.link_autoneg = RTE_ETH_LINK_FIXED;
+			goto out;
+		}
+
+		hinic3_get_link_port_info(nic_dev->hwdev, link_state, &link);
+
+		if (!wait_to_complete || link.link_status)
+			break;
+
+		rte_delay_ms(CHECK_INTERVAL);
+	} while (rep_cnt--);
+
+out:
+	return rte_eth_linkstatus_set(dev, &link);
+}
+
+/**
+ * Reset all RX queues (RXQs).
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ */
+static void
+hinic3_reset_rx_queue(struct rte_eth_dev *dev)
+{
+	struct hinic3_rxq *rxq = NULL;
+	struct hinic3_nic_dev *nic_dev;
+	int q_id = 0;
+
+	nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+
+	for (q_id = 0; q_id < nic_dev->num_rqs; q_id++) {
+		rxq = nic_dev->rxqs[q_id];
+
+		rxq->cons_idx = 0;
+		rxq->prod_idx = 0;
+		rxq->delta = rxq->q_depth;
+		rxq->next_to_update = 0;
+	}
+}
+
+/**
+ * Reset all TX queues (TXQs).
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ */
+static void
+hinic3_reset_tx_queue(struct rte_eth_dev *dev)
+{
+	struct hinic3_nic_dev *nic_dev;
+	struct hinic3_txq *txq = NULL;
+	int q_id = 0;
+
+	nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+
+	for (q_id = 0; q_id < nic_dev->num_sqs; q_id++) {
+		txq = nic_dev->txqs[q_id];
+
+		txq->cons_idx = 0;
+		txq->prod_idx = 0;
+		txq->owner = 1;
+
+		/* Clear hardware ci. */
+		*txq->ci_vaddr_base = 0;
+	}
+}
+
+/**
+ * Create the receive queue.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ * @param[in] qid
+ * Receive queue index.
+ * @param[in] nb_desc
+ * Number of descriptors for receive queue.
+ * @param[in] socket_id
+ * Socket index on which memory must be allocated.
+ * @param[in] rx_conf
+ * Thresholds parameters (unused_).
+ * @param[in] mp
+ * Memory pool for buffer allocations.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
+		      unsigned int socket_id, const struct rte_eth_rxconf *rx_conf,
+		      struct rte_mempool *mp)
+{
+	struct hinic3_nic_dev *nic_dev;
+	struct hinic3_rxq *rxq = NULL;
+	const struct rte_memzone *rq_mz = NULL;
+	const struct rte_memzone *cqe_mz = NULL;
+	const struct rte_memzone *pi_mz = NULL;
+	uint16_t rq_depth, rx_free_thresh;
+	uint32_t queue_buf_size;
+	void *db_addr = NULL;
+	int wqe_count;
+	uint32_t buf_size;
+	int err;
+
+	nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+
+	/* Queue depth must be power of 2, otherwise will be aligned up. */
+	rq_depth = (nb_desc & (nb_desc - 1))
+			? ((uint16_t)(1U << (rte_log2_u32(nb_desc) + 1))) : nb_desc;
+
+	/*
+	 * Validate number of receive descriptors.
+	 * It must not exceed hardware maximum and minimum.
+	 */
+	if (rq_depth > HINIC3_MAX_QUEUE_DEPTH ||
+	    rq_depth < HINIC3_MIN_QUEUE_DEPTH) {
+		PMD_DRV_LOG(ERR,
+			    "RX queue depth is out of range from %d to %d",
+			    HINIC3_MIN_QUEUE_DEPTH, HINIC3_MAX_QUEUE_DEPTH);
+		PMD_DRV_LOG(ERR,
+				"nb_desc: %d, q_depth: %d, port: %d queue: %d",
+				nb_desc, rq_depth, dev->data->port_id, qid);
+		return -EINVAL;
+	}
+
+	/*
+	 * The RX descriptor ring will be cleaned after rxq->rx_free_thresh
+	 * descriptors are used or if the number of descriptors required
+	 * to transmit a packet is greater than the number of free RX
+	 * descriptors.
+	 * The following constraints must be satisfied:
+	 * - rx_free_thresh must be greater than 0.
+	 * - rx_free_thresh must be less than the size of the ring minus 1.
+	 * When set to zero use default values.
+	 */
+	rx_free_thresh = rx_conf->rx_free_thresh
+				? rx_conf->rx_free_thresh : HINIC3_DEFAULT_RX_FREE_THRESH;
+	if (rx_free_thresh >= (rq_depth - 1)) {
+		PMD_DRV_LOG(ERR,
+			    "rx_free_thresh must be less than the number of RX descriptors minus 1, rx_free_thresh: %d port: %d queue: %d)",
+			    rx_free_thresh, dev->data->port_id, qid);
+		return -EINVAL;
+	}
+
+	rxq = rte_zmalloc_socket("hinic3_rq", sizeof(struct hinic3_rxq),
+				 RTE_CACHE_LINE_SIZE, socket_id);
+	if (!rxq) {
+		PMD_DRV_LOG(ERR, "Allocate rxq[%d] failed, dev_name: %s", qid,
+			    dev->data->name);
+
+		return -ENOMEM;
+	}
+
+	/* Init rq parameters. */
+	rxq->nic_dev = nic_dev;
+	nic_dev->rxqs[qid] = rxq;
+	rxq->mb_pool = mp;
+	rxq->q_id = qid;
+	rxq->q_depth = rq_depth;
+	rxq->q_mask = rq_depth - 1;
+	rxq->delta = rq_depth;
+	rxq->rx_free_thresh = rx_free_thresh;
+	rxq->rxinfo_align_end = rxq->q_depth - rxq->rx_free_thresh;
+	rxq->port_id = dev->data->port_id;
+	rxq->wait_time_cycle = HINIC3_RX_WAIT_CYCLE_THRESH;
+	rxq->rx_deferred_start = rx_conf->rx_deferred_start;
+	/* If buf_len used for function table, need to translated. */
+	uint16_t rx_buf_size =
+		rte_pktmbuf_data_room_size(rxq->mb_pool) - RTE_PKTMBUF_HEADROOM;
+	err = hinic3_convert_rx_buf_size(rx_buf_size, &buf_size);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Adjust buf size failed, dev_name: %s",
+			    dev->data->name);
+		goto adjust_bufsize_fail;
+	}
+
+	if (buf_size >= HINIC3_RX_BUF_SIZE_4K &&
+	    buf_size < HINIC3_RX_BUF_SIZE_16K)
+		rxq->wqe_type = HINIC3_EXTEND_RQ_WQE;
+	else
+		rxq->wqe_type = HINIC3_NORMAL_RQ_WQE;
+
+	rxq->wqebb_shift = HINIC3_RQ_WQEBB_SHIFT + rxq->wqe_type;
+	rxq->wqebb_size = (uint16_t)RTE_BIT32(rxq->wqebb_shift);
+
+	rxq->buf_len = (uint16_t)buf_size;
+	rxq->rx_buff_shift = rte_log2_u32(rxq->buf_len);
+
+	pi_mz = hinic3_dma_zone_reserve(dev, "hinic3_rq_pi", qid, RTE_PGSIZE_4K,
+					RTE_CACHE_LINE_SIZE, socket_id);
+	if (!pi_mz) {
+		PMD_DRV_LOG(ERR, "Allocate rxq[%d] pi_mz failed, dev_name: %s",
+			    qid, dev->data->name);
+		err = -ENOMEM;
+		goto alloc_pi_mz_fail;
+	}
+	rxq->pi_mz = pi_mz;
+	rxq->pi_dma_addr = pi_mz->iova;
+	rxq->pi_virt_addr = pi_mz->addr;
+
+	err = hinic3_alloc_db_addr(nic_dev->hwdev, &db_addr, HINIC3_DB_TYPE_RQ);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Alloc rq doorbell addr failed");
+		goto alloc_db_err_fail;
+	}
+	rxq->db_addr = db_addr;
+
+	queue_buf_size = RTE_BIT32(rxq->wqebb_shift) * rq_depth;
+	rq_mz = hinic3_dma_zone_reserve(dev, "hinic3_rq_mz", qid,
+					queue_buf_size, RTE_PGSIZE_256K, socket_id);
+	if (!rq_mz) {
+		PMD_DRV_LOG(ERR, "Allocate rxq[%d] rq_mz failed, dev_name: %s",
+			    qid, dev->data->name);
+		err = -ENOMEM;
+		goto alloc_rq_mz_fail;
+	}
+
+	memset(rq_mz->addr, 0, queue_buf_size);
+	rxq->rq_mz = rq_mz;
+	rxq->queue_buf_paddr = rq_mz->iova;
+	rxq->queue_buf_vaddr = rq_mz->addr;
+
+	rxq->rx_info = rte_zmalloc_socket("rx_info",
+					  rq_depth * sizeof(*rxq->rx_info),
+					  RTE_CACHE_LINE_SIZE, socket_id);
+	if (!rxq->rx_info) {
+		PMD_DRV_LOG(ERR, "Allocate rx_info failed, dev_name: %s",
+			    dev->data->name);
+		err = -ENOMEM;
+		goto alloc_rx_info_fail;
+	}
+
+	cqe_mz = hinic3_dma_zone_reserve(dev, "hinic3_cqe_mz", qid,
+					 rq_depth * sizeof(*rxq->rx_cqe),
+					 RTE_CACHE_LINE_SIZE, socket_id);
+	if (!cqe_mz) {
+		PMD_DRV_LOG(ERR, "Allocate cqe mem zone failed, dev_name: %s",
+			    dev->data->name);
+		err = -ENOMEM;
+		goto alloc_cqe_mz_fail;
+	}
+	memset(cqe_mz->addr, 0, rq_depth * sizeof(*rxq->rx_cqe));
+	rxq->cqe_mz = cqe_mz;
+	rxq->cqe_start_paddr = cqe_mz->iova;
+	rxq->cqe_start_vaddr = cqe_mz->addr;
+	rxq->rx_cqe = (struct hinic3_rq_cqe *)rxq->cqe_start_vaddr;
+
+	wqe_count = hinic3_rx_fill_wqe(rxq);
+	if (wqe_count != rq_depth) {
+		PMD_DRV_LOG(ERR, "Fill rx wqe failed, wqe_count: %d, dev_name: %s",
+				wqe_count, dev->data->name);
+		err = -ENOMEM;
+		goto fill_rx_wqe_fail;
+	}
+	/* Record rxq pointer in rte_eth rx_queues. */
+	dev->data->rx_queues[qid] = rxq;
+
+	return 0;
+
+fill_rx_wqe_fail:
+	hinic3_memzone_free(rxq->cqe_mz);
+alloc_cqe_mz_fail:
+	rte_free(rxq->rx_info);
+
+alloc_rx_info_fail:
+	hinic3_memzone_free(rxq->rq_mz);
+
+alloc_rq_mz_fail:
+alloc_db_err_fail:
+	hinic3_memzone_free(rxq->pi_mz);
+
+alloc_pi_mz_fail:
+adjust_bufsize_fail:
+	rte_free(rxq);
+	nic_dev->rxqs[qid] = NULL;
+
+	return err;
+}
+
+/**
+ * Create the transmit queue.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ * @param[in] queue_idx
+ * Transmit queue index.
+ * @param[in] nb_desc
+ * Number of descriptors for transmit queue.
+ * @param[in] socket_id
+ * Socket index on which memory must be allocated.
+ * @param[in] tx_conf
+ * Tx queue configuration parameters (unused_).
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+hinic3_tx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
+		      unsigned int socket_id, const struct rte_eth_txconf *tx_conf)
+{
+	struct hinic3_nic_dev *nic_dev;
+	struct hinic3_hwdev *hwdev;
+	struct hinic3_txq *txq = NULL;
+	const struct rte_memzone *sq_mz = NULL;
+	const struct rte_memzone *ci_mz = NULL;
+	void *db_addr = NULL;
+	uint16_t sq_depth, tx_free_thresh;
+	uint32_t queue_buf_size;
+	int err;
+
+	nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	hwdev = nic_dev->hwdev;
+
+	/* Queue depth must be power of 2, otherwise will be aligned up. */
+	sq_depth = (nb_desc & (nb_desc - 1))
+				? ((uint16_t)(1U << (rte_log2_u32(nb_desc) + 1))) : nb_desc;
+
+	/*
+	 * Validate number of transmit descriptors.
+	 * It must not exceed hardware maximum and minimum.
+	 */
+	if (sq_depth > HINIC3_MAX_QUEUE_DEPTH ||
+	    sq_depth < HINIC3_MIN_QUEUE_DEPTH) {
+		PMD_DRV_LOG(ERR,
+			    "TX queue depth is out of range from %d to %d",
+			    HINIC3_MIN_QUEUE_DEPTH, HINIC3_MAX_QUEUE_DEPTH);
+		PMD_DRV_LOG(ERR,
+			    "nb_desc: %d, q_depth: %d, port: %d queue: %d",
+			    nb_desc, sq_depth, dev->data->port_id, qid);
+		return -EINVAL;
+	}
+
+	/*
+	 * The TX descriptor ring will be cleaned after txq->tx_free_thresh
+	 * descriptors are used or if the number of descriptors required
+	 * to transmit a packet is greater than the number of free TX
+	 * descriptors.
+	 * The following constraints must be satisfied:
+	 * - tx_free_thresh must be greater than 0.
+	 * - tx_free_thresh must be less than the size of the ring minus 1.
+	 * When set to zero use default values.
+	 */
+	tx_free_thresh = tx_conf->tx_free_thresh
+				 ? tx_conf->tx_free_thresh : HINIC3_DEFAULT_TX_FREE_THRESH;
+	if (tx_free_thresh >= (sq_depth - 1)) {
+		PMD_DRV_LOG(ERR,
+			    "tx_free_thresh must be less than the number of tx descriptors minus 1, tx_free_thresh: %d port: %d queue: %d",
+			    tx_free_thresh, dev->data->port_id, qid);
+		return -EINVAL;
+	}
+
+	txq = rte_zmalloc_socket("hinic3_tx_queue", sizeof(struct hinic3_txq),
+				 RTE_CACHE_LINE_SIZE, socket_id);
+	if (!txq) {
+		PMD_DRV_LOG(ERR, "Allocate txq[%d] failed, dev_name: %s", qid,
+			    dev->data->name);
+		return -ENOMEM;
+	}
+	nic_dev->txqs[qid] = txq;
+	txq->nic_dev = nic_dev;
+	txq->q_id = qid;
+	txq->q_depth = sq_depth;
+	txq->q_mask = sq_depth - 1;
+	txq->wqebb_shift = HINIC3_SQ_WQEBB_SHIFT;
+	txq->wqebb_size = (uint16_t)RTE_BIT32(txq->wqebb_shift);
+	txq->tx_free_thresh = tx_free_thresh;
+	txq->owner = 1;
+	txq->cos = nic_dev->default_cos;
+	txq->tx_deferred_start = tx_conf->tx_deferred_start;
+
+	ci_mz = hinic3_dma_zone_reserve(dev, "hinic3_sq_ci", qid,
+					HINIC3_CI_Q_ADDR_SIZE,
+					HINIC3_CI_Q_ADDR_SIZE, socket_id);
+	if (!ci_mz) {
+		PMD_DRV_LOG(ERR, "Allocate txq[%d] ci_mz failed, dev_name: %s",
+			    qid, dev->data->name);
+		err = -ENOMEM;
+		goto alloc_ci_mz_fail;
+	}
+	txq->ci_mz = ci_mz;
+	txq->ci_dma_base = ci_mz->iova;
+	txq->ci_vaddr_base = (volatile uint16_t *)ci_mz->addr;
+
+	queue_buf_size = RTE_BIT32(txq->wqebb_shift) * sq_depth;
+	sq_mz = hinic3_dma_zone_reserve(dev, "hinic3_sq_mz", qid,
+					queue_buf_size, RTE_PGSIZE_256K, socket_id);
+	if (!sq_mz) {
+		PMD_DRV_LOG(ERR, "Allocate txq[%d] sq_mz failed, dev_name: %s",
+			    qid, dev->data->name);
+		err = -ENOMEM;
+		goto alloc_sq_mz_fail;
+	}
+	memset(sq_mz->addr, 0, queue_buf_size);
+	txq->sq_mz = sq_mz;
+	txq->queue_buf_paddr = sq_mz->iova;
+	txq->queue_buf_vaddr = sq_mz->addr;
+	txq->sq_head_addr = (uint64_t)txq->queue_buf_vaddr;
+	txq->sq_bot_sge_addr = txq->sq_head_addr + queue_buf_size;
+
+	err = hinic3_alloc_db_addr(hwdev, &db_addr, HINIC3_DB_TYPE_SQ);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Alloc sq doorbell addr failed");
+		goto alloc_db_err_fail;
+	}
+	txq->db_addr = db_addr;
+
+	txq->tx_info = rte_zmalloc_socket("tx_info",
+					  sq_depth * sizeof(*txq->tx_info),
+					  RTE_CACHE_LINE_SIZE, socket_id);
+	if (!txq->tx_info) {
+		PMD_DRV_LOG(ERR, "Allocate tx_info failed, dev_name: %s",
+			    dev->data->name);
+		err = -ENOMEM;
+		goto alloc_tx_info_fail;
+	}
+
+	/* Record txq pointer in rte_eth tx_queues. */
+	dev->data->tx_queues[qid] = txq;
+
+	return 0;
+
+alloc_tx_info_fail:
+alloc_db_err_fail:
+	hinic3_memzone_free(txq->sq_mz);
+
+alloc_sq_mz_fail:
+	hinic3_memzone_free(txq->ci_mz);
+
+alloc_ci_mz_fail:
+	rte_free(txq);
+	return err;
+}
+
+static void
+hinic3_rx_queue_release(struct rte_eth_dev *dev, uint16_t queue_id)
+{
+	struct hinic3_rxq *rxq = dev->data->rx_queues[queue_id];
+	struct hinic3_nic_dev *nic_dev = rxq->nic_dev;
+
+	PMD_DRV_LOG(DEBUG, "%s rxq_idx:%d queue release.",
+		    rxq->nic_dev->dev_name, rxq->q_id);
+
+	hinic3_free_rxq_mbufs(rxq);
+
+	hinic3_memzone_free(rxq->cqe_mz);
+
+	rte_free(rxq->rx_info);
+	rxq->rx_info = NULL;
+
+	hinic3_memzone_free(rxq->rq_mz);
+
+	hinic3_memzone_free(rxq->pi_mz);
+
+	nic_dev->rxqs[rxq->q_id] = NULL;
+	rte_free(rxq);
+}
+
+static void
+hinic3_tx_queue_release(struct rte_eth_dev *dev, uint16_t queue_id)
+{
+	struct hinic3_txq *txq = dev->data->tx_queues[queue_id];
+	struct hinic3_nic_dev *nic_dev = txq->nic_dev;
+
+	PMD_DRV_LOG(DEBUG, "%s txq_idx:%d queue release.",
+		    txq->nic_dev->dev_name, txq->q_id);
+
+	hinic3_free_txq_mbufs(txq);
+
+	rte_free(txq->tx_info);
+	txq->tx_info = NULL;
+
+	hinic3_memzone_free(txq->sq_mz);
+
+	hinic3_memzone_free(txq->ci_mz);
+
+	nic_dev->txqs[txq->q_id] = NULL;
+	rte_free(txq);
+}
+
+/**
+ * Start RXQ and enables flow director (fdir) filter for RXQ.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ * @param[in] rq_id
+ * RX queue ID to be started.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+hinic3_dev_rx_queue_start(struct rte_eth_dev *dev, uint16_t rq_id)
+{
+	struct hinic3_rxq *rxq = dev->data->rx_queues[rq_id];
+	int rc;
+
+	rc = hinic3_start_rq(dev, rxq);
+	if (rc) {
+		PMD_DRV_LOG(ERR,
+			    "Start rx queue failed, eth_dev:%s, queue_idx:%d",
+			    dev->data->name, rq_id);
+		return rc;
+	}
+	dev->data->rx_queue_state[rq_id] = RTE_ETH_QUEUE_STATE_STARTED;
+
+	rc = hinic3_enable_rxq_fdir_filter(dev, rq_id, true);
+	if (rc) {
+		PMD_DRV_LOG(ERR, "Failed to enable rq : %d fdir filter.",
+			    rq_id);
+		return rc;
+	}
+	return 0;
+}
+
+/**
+ * Stop RXQ and disable flow director (fdir) filter for RXQ.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ * @param[in] rq_id
+ * RX queue ID to be stopped.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+hinic3_dev_rx_queue_stop(struct rte_eth_dev *dev, uint16_t rq_id)
+{
+	struct hinic3_rxq *rxq = dev->data->rx_queues[rq_id];
+	int rc;
+
+	rc = hinic3_enable_rxq_fdir_filter(dev, rq_id, false);
+	if (rc) {
+		PMD_DRV_LOG(ERR, "Failed to disable rq : %d fdir filter.", rq_id);
+		return rc;
+	}
+	rc = hinic3_stop_rq(dev, rxq);
+	if (rc) {
+		PMD_DRV_LOG(ERR,
+			    "Stop rx queue failed, eth_dev:%s, queue_idx:%d",
+			    dev->data->name, rq_id);
+		return rc;
+	}
+	dev->data->rx_queue_state[rq_id] = RTE_ETH_QUEUE_STATE_STOPPED;
+
+	return 0;
+}
+
+static int
+hinic3_dev_tx_queue_start(struct rte_eth_dev *dev, uint16_t sq_id)
+{
+	struct hinic3_txq *txq = dev->data->tx_queues[sq_id];
+
+	PMD_DRV_LOG(DEBUG, "Start tx queue, eth_dev:%s, queue_idx:%d",
+		    dev->data->name, sq_id);
+
+	HINIC3_SET_TXQ_STARTED(txq);
+	dev->data->tx_queue_state[sq_id] = RTE_ETH_QUEUE_STATE_STARTED;
+	return 0;
+}
+
+static int
+hinic3_dev_tx_queue_stop(struct rte_eth_dev *dev, uint16_t sq_id)
+{
+	struct hinic3_txq *txq = dev->data->tx_queues[sq_id];
+	int rc;
+
+	rc = hinic3_stop_sq(txq);
+	if (rc) {
+		PMD_DRV_LOG(ERR,
+			    "Stop tx queue failed, eth_dev:%s, queue_idx:%d",
+			    dev->data->name, sq_id);
+		return rc;
+	}
+	HINIC3_SET_TXQ_STOPPED(txq);
+	dev->data->tx_queue_state[sq_id] = RTE_ETH_QUEUE_STATE_STOPPED;
+
+	return 0;
+}
+
+int
+hinic3_dev_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
+{
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_intr_handle *intr_handle = PCI_DEV_TO_INTR_HANDLE(pci_dev);
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	uint16_t msix_intr;
+
+	if (!rte_intr_dp_is_en(intr_handle) || !intr_handle->intr_vec)
+		return 0;
+
+	msix_intr = (uint16_t)intr_handle->intr_vec[queue_id];
+	hinic3_set_msix_auto_mask_state(nic_dev->hwdev, msix_intr,
+					HINIC3_SET_MSIX_AUTO_MASK);
+	hinic3_set_msix_state(nic_dev->hwdev, msix_intr, HINIC3_MSIX_ENABLE);
+
+	return 0;
+}
+
+int
+hinic3_dev_rx_queue_intr_disable(struct rte_eth_dev *dev, uint16_t queue_id)
+{
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_intr_handle *intr_handle = PCI_DEV_TO_INTR_HANDLE(pci_dev);
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	uint16_t msix_intr;
+
+	if (!rte_intr_dp_is_en(intr_handle) || !intr_handle->intr_vec)
+		return 0;
+
+	msix_intr = (uint16_t)intr_handle->intr_vec[queue_id];
+	hinic3_set_msix_auto_mask_state(nic_dev->hwdev, msix_intr,
+					HINIC3_CLR_MSIX_AUTO_MASK);
+	hinic3_set_msix_state(nic_dev->hwdev, msix_intr, HINIC3_MSIX_DISABLE);
+	hinic3_misx_intr_clear_resend_bit(nic_dev->hwdev, msix_intr,
+					  MSIX_RESEND_TIMER_CLEAR);
+
+	return 0;
+}
+
+static int
+hinic3_set_lro(struct hinic3_nic_dev *nic_dev, struct rte_eth_conf *dev_conf)
+{
+	bool lro_en;
+	int max_lro_size, lro_max_pkt_len;
+	int err;
+
+	/* Config lro. */
+	lro_en = dev_conf->rxmode.offloads & RTE_ETH_RX_OFFLOAD_TCP_LRO ? true
+									: false;
+	max_lro_size = (int)(dev_conf->rxmode.max_lro_pkt_size);
+	/* `max_lro_size` is divisible by `HINIC3_LRO_UNIT_WQE_SIZE`. */
+	lro_max_pkt_len = max_lro_size / HINIC3_LRO_UNIT_WQE_SIZE
+				  ? max_lro_size / HINIC3_LRO_UNIT_WQE_SIZE : 1;
+
+	PMD_DRV_LOG(DEBUG,
+		    "max_lro_size: %d, rx_buff_len: %d, lro_max_pkt_len: %d",
+		    max_lro_size, nic_dev->rx_buff_len, lro_max_pkt_len);
+	PMD_DRV_LOG(DEBUG, "max_rx_pkt_len: %d",
+		    HINIC3_MAX_RX_PKT_LEN(dev_conf->rxmode));
+	err = hinic3_set_rx_lro_state(nic_dev->hwdev, lro_en,
+				      HINIC3_LRO_DEFAULT_TIME_LIMIT, lro_max_pkt_len);
+	if (err)
+		PMD_DRV_LOG(ERR, "Set lro state failed, err: %d", err);
+	return err;
+}
+
+static int
+hinic3_set_vlan(struct rte_eth_dev *dev, struct rte_eth_conf *dev_conf)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	bool vlan_filter, vlan_strip;
+	int err;
+
+	/* Config vlan filter. */
+	vlan_filter = dev_conf->rxmode.offloads &
+		      RTE_ETH_RX_OFFLOAD_VLAN_FILTER;
+
+	err = hinic3_set_vlan_filter(nic_dev->hwdev, vlan_filter);
+	if (err) {
+		PMD_DRV_LOG(ERR,
+			    "Config vlan filter failed, device: %s, port_id: %d, err: %d",
+			    nic_dev->dev_name, dev->data->port_id, err);
+		return err;
+	}
+
+	/* Config vlan stripping. */
+	vlan_strip = dev_conf->rxmode.offloads & RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
+
+	err = hinic3_set_rx_vlan_offload(nic_dev->hwdev, vlan_strip);
+	if (err) {
+		PMD_DRV_LOG(ERR,
+			    "Config vlan strip failed, device: %s, port_id: %d, err: %d",
+			    nic_dev->dev_name, dev->data->port_id, err);
+	}
+
+	return err;
+}
+
+/**
+ * Configure RX mode, checksum offload, LRO, RSS, VLAN and initialize the RXQ
+ * list.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+hinic3_set_rxtx_configure(struct rte_eth_dev *dev)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	struct rte_eth_conf *dev_conf = &dev->data->dev_conf;
+	struct rte_eth_rss_conf *rss_conf = NULL;
+	int err;
+
+	/* Config rx mode. */
+	err = hinic3_set_rx_mode(nic_dev->hwdev, HINIC3_DEFAULT_RX_MODE);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Set rx_mode: 0x%x failed",
+			    HINIC3_DEFAULT_RX_MODE);
+		return err;
+	}
+	nic_dev->rx_mode = HINIC3_DEFAULT_RX_MODE;
+
+	/* Config rx checksum offload. */
+	if (dev_conf->rxmode.offloads & RTE_ETH_RX_OFFLOAD_CHECKSUM)
+		nic_dev->rx_csum_en = HINIC3_DEFAULT_RX_CSUM_OFFLOAD;
+
+	err = hinic3_set_lro(nic_dev, dev_conf);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Set lro failed");
+		return err;
+	}
+	/* Config RSS. */
+	if ((dev_conf->rxmode.mq_mode & RTE_ETH_MQ_RX_RSS_FLAG) &&
+	    nic_dev->num_rqs > 1) {
+		rss_conf = &dev_conf->rx_adv_conf.rss_conf;
+		err = hinic3_update_rss_config(dev, rss_conf);
+		if (err) {
+			PMD_DRV_LOG(ERR, "Set rss config failed, err: %d", err);
+			return err;
+		}
+	}
+
+	err = hinic3_set_vlan(dev, dev_conf);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Set vlan failed, err: %d", err);
+		return err;
+	}
+
+	hinic3_init_rx_queue_list(nic_dev);
+
+	return 0;
+}
+
+/**
+ * Disable RX mode and RSS, and free associated resources.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ */
+static void
+hinic3_remove_rxtx_configure(struct rte_eth_dev *dev)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	uint8_t prio_tc[HINIC3_DCB_UP_MAX] = {0};
+
+	hinic3_set_rx_mode(nic_dev->hwdev, 0);
+
+	if (nic_dev->rss_state == HINIC3_RSS_ENABLE) {
+		hinic3_rss_cfg(nic_dev->hwdev, HINIC3_RSS_DISABLE, 0, prio_tc);
+		hinic3_rss_template_free(nic_dev->hwdev);
+		nic_dev->rss_state = HINIC3_RSS_DISABLE;
+	}
+}
+
+static bool
+hinic3_find_vlan_filter(struct hinic3_nic_dev *nic_dev, uint16_t vlan_id)
+{
+	uint32_t vid_idx, vid_bit;
+
+	vid_idx = HINIC3_VFTA_IDX(vlan_id);
+	vid_bit = HINIC3_VFTA_BIT(vlan_id);
+
+	return (nic_dev->vfta[vid_idx] & vid_bit) ? true : false;
+}
+
+static void
+hinic3_store_vlan_filter(struct hinic3_nic_dev *nic_dev, uint16_t vlan_id, bool on)
+{
+	uint32_t vid_idx, vid_bit;
+
+	vid_idx = HINIC3_VFTA_IDX(vlan_id);
+	vid_bit = HINIC3_VFTA_BIT(vlan_id);
+
+	if (on)
+		nic_dev->vfta[vid_idx] |= vid_bit;
+	else
+		nic_dev->vfta[vid_idx] &= ~vid_bit;
+}
+
+static void
+hinic3_remove_all_vlanid(struct rte_eth_dev *dev)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	int vlan_id;
+	uint16_t func_id;
+
+	func_id = hinic3_global_func_id(nic_dev->hwdev);
+
+	for (vlan_id = 1; vlan_id < RTE_ETHER_MAX_VLAN_ID; vlan_id++) {
+		if (hinic3_find_vlan_filter(nic_dev, vlan_id)) {
+			hinic3_del_vlan(nic_dev->hwdev, vlan_id, func_id);
+			hinic3_store_vlan_filter(nic_dev, vlan_id, false);
+		}
+	}
+}
+
+static void
+hinic3_disable_interrupt(struct rte_eth_dev *dev)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+
+	if (!hinic3_get_bit(HINIC3_DEV_INIT, &nic_dev->dev_status))
+		return;
+
+	/* Disable rte interrupt. */
+	rte_intr_disable(PCI_DEV_TO_INTR_HANDLE(pci_dev));
+	rte_intr_callback_unregister(PCI_DEV_TO_INTR_HANDLE(pci_dev),
+				     hinic3_dev_interrupt_handler, (void *)dev);
+}
+
+static void
+hinic3_enable_interrupt(struct rte_eth_dev *dev)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+
+	if (!hinic3_get_bit(HINIC3_DEV_INIT, &nic_dev->dev_status))
+		return;
+
+	/* Enable rte interrupt. */
+	rte_intr_enable(PCI_DEV_TO_INTR_HANDLE(pci_dev));
+	rte_intr_callback_register(PCI_DEV_TO_INTR_HANDLE(pci_dev),
+				   hinic3_dev_interrupt_handler, (void *)dev);
+}
+
+#define HINIC3_RX_VEC_START RTE_INTR_VEC_RXTX_OFFSET
+
+/** Dp interrupt msix attribute. */
+#define HINIC3_TXRX_MSIX_PENDING_LIMIT	  2
+#define HINIC3_TXRX_MSIX_COALESCE_TIMER	  2
+#define HINIC3_TXRX_MSIX_RESEND_TIMER_CFG 7
+
+static int
+hinic3_init_rxq_msix_attr(void *hwdev, uint16_t msix_index)
+{
+	struct interrupt_info info = {0};
+	int err;
+
+	info.lli_set = 0;
+	info.interrupt_coalesce_set = 1;
+	info.pending_limt = HINIC3_TXRX_MSIX_PENDING_LIMIT;
+	info.coalesce_timer_cfg = HINIC3_TXRX_MSIX_COALESCE_TIMER;
+	info.resend_timer_cfg = HINIC3_TXRX_MSIX_RESEND_TIMER_CFG;
+	info.msix_index = msix_index;
+	err = hinic3_set_interrupt_cfg(hwdev, info);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Set msix attr failed, msix_index %d",
+			    msix_index);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static void
+hinic3_deinit_rxq_intr(struct rte_eth_dev *dev)
+{
+	struct rte_intr_handle *intr_handle = dev->intr_handle;
+
+	rte_intr_efd_disable(intr_handle);
+	if (intr_handle->intr_vec) {
+		rte_free(intr_handle->intr_vec);
+		intr_handle->intr_vec = NULL;
+	}
+}
+
+/**
+ * Initialize RX queue interrupts by enabling MSI-X, allocate interrupt vectors,
+ * and configure interrupt attributes for each RX queue.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ *
+ * @return
+ * 0 on success, negative error code on failure.
+ * - -ENOTSUP if MSI-X interrupts are not supported.
+ * - Error code if enabling event file descriptors fails.
+ * - -ENOMEM if allocating interrupt vectors fails.
+ */
+static int
+hinic3_init_rxq_intr(struct rte_eth_dev *dev)
+{
+	struct rte_intr_handle *intr_handle = NULL;
+	struct hinic3_nic_dev *nic_dev = NULL;
+	struct hinic3_rxq *rxq = NULL;
+	uint32_t nb_rx_queues, i;
+	int err;
+
+	intr_handle = dev->intr_handle;
+	nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	if (!dev->data->dev_conf.intr_conf.rxq)
+		return 0;
+
+	if (!rte_intr_cap_multiple(intr_handle)) {
+		PMD_DRV_LOG(ERR, "Rx queue interrupts require MSI-X interrupts (vfio-pci driver)");
+		return -ENOTSUP;
+	}
+
+	nb_rx_queues = dev->data->nb_rx_queues;
+	err = rte_intr_efd_enable(intr_handle, nb_rx_queues);
+	if (err) {
+		PMD_DRV_LOG(ERR,
+			"Failed to enable event fds for Rx queue interrupts");
+		return err;
+	}
+
+	intr_handle->intr_vec =
+		rte_zmalloc("hinic_intr_vec", nb_rx_queues * sizeof(int), 0);
+	if (intr_handle->intr_vec == NULL) {
+		PMD_DRV_LOG(ERR, "Failed to allocate intr_vec");
+		rte_intr_efd_disable(intr_handle);
+		return -ENOMEM;
+	}
+	intr_handle->vec_list_size = nb_rx_queues;
+	for (i = 0; i < nb_rx_queues; i++)
+		intr_handle->intr_vec[i] = (int)(i + HINIC3_RX_VEC_START);
+
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		rxq = dev->data->rx_queues[i];
+		rxq->dp_intr_en = 1;
+		rxq->msix_entry_idx = (uint16_t)intr_handle->intr_vec[i];
+
+		err = hinic3_init_rxq_msix_attr(nic_dev->hwdev,
+						rxq->msix_entry_idx);
+		if (err) {
+			hinic3_deinit_rxq_intr(dev);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static void
+hinic3_disable_queue_intr(struct rte_eth_dev *dev)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	struct rte_intr_handle *intr_handle = dev->intr_handle;
+	int msix_intr;
+	int i;
+
+	if (intr_handle->intr_vec == NULL)
+		return;
+
+	for (i = 0; i < nic_dev->num_rqs; i++) {
+		msix_intr = intr_handle->intr_vec[i];
+		hinic3_set_msix_state(nic_dev->hwdev, msix_intr,
+				      HINIC3_MSIX_DISABLE);
+		hinic3_misx_intr_clear_resend_bit(nic_dev->hwdev,
+						  msix_intr,
+						  MSIX_RESEND_TIMER_CLEAR);
+	}
+}
+
+/**
+ * Start the device.
+ *
+ * Initialize function table, TXQ and TXQ context, configure RX offload, and
+ * enable vport and port to prepare receiving packets.
+ *
+ * @param[in] eth_dev
+ * Pointer to ethernet device structure.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+hinic3_dev_start(struct rte_eth_dev *eth_dev)
+{
+	struct hinic3_nic_dev *nic_dev = NULL;
+	uint64_t nic_features;
+	struct hinic3_rxq *rxq = NULL;
+	int i;
+	int err;
+
+	nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(eth_dev);
+	err = hinic3_copy_mempool_init(nic_dev);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Create copy mempool failed, dev_name: %s",
+			    eth_dev->data->name);
+		goto init_mpool_fail;
+	}
+	hinic3_update_msix_info(nic_dev->hwdev->hwif);
+	hinic3_disable_interrupt(eth_dev);
+	err = hinic3_init_rxq_intr(eth_dev);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Init rxq intr fail, eth_dev:%s",
+			    eth_dev->data->name);
+		goto init_rxq_intr_fail;
+	}
+
+	hinic3_get_func_rx_buf_size(nic_dev);
+	err = hinic3_init_function_table(nic_dev->hwdev, nic_dev->rx_buff_len);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Init function table failed, dev_name: %s",
+			    eth_dev->data->name);
+		goto init_func_tbl_fail;
+	}
+
+	nic_features = hinic3_get_driver_feature(nic_dev);
+	/*
+	 * You can update the features supported by the driver according to the
+	 * scenario here.
+	 */
+	nic_features &= DEFAULT_DRV_FEATURE;
+	hinic3_update_driver_feature(nic_dev, nic_features);
+
+	err = hinic3_set_feature_to_hw(nic_dev->hwdev, &nic_dev->feature_cap, 1);
+	if (err) {
+		PMD_DRV_LOG(ERR,
+			    "Failed to set nic features to hardware, err %d",
+			    err);
+		goto get_feature_err;
+	}
+
+	/* Reset rx and tx queue. */
+	hinic3_reset_rx_queue(eth_dev);
+	hinic3_reset_tx_queue(eth_dev);
+
+	/* Init txq and rxq context. */
+	err = hinic3_init_qp_ctxts(nic_dev);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Init qp context failed, dev_name: %s",
+			    eth_dev->data->name);
+		goto init_qp_fail;
+	}
+
+	/* Set default mtu. */
+	err = hinic3_set_port_mtu(nic_dev->hwdev, nic_dev->mtu_size);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Set mtu_size[%d] failed, dev_name: %s",
+			    nic_dev->mtu_size, eth_dev->data->name);
+		goto set_mtu_fail;
+	}
+	eth_dev->data->mtu = nic_dev->mtu_size;
+
+	/* Set rx configuration: rss/checksum/rxmode/lro. */
+	err = hinic3_set_rxtx_configure(eth_dev);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Set rx config failed, dev_name: %s",
+			    eth_dev->data->name);
+		goto set_rxtx_config_fail;
+	}
+
+	/* Enable dev interrupt. */
+	hinic3_enable_interrupt(eth_dev);
+	err = hinic3_start_all_rqs(eth_dev);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Set rx config failed, dev_name: %s",
+			    eth_dev->data->name);
+		goto start_rqs_fail;
+	}
+
+	hinic3_start_all_sqs(eth_dev);
+
+	/* Open virtual port and ready to start packet receiving. */
+	err = hinic3_set_vport_enable(nic_dev->hwdev, true);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Enable vport failed, dev_name: %s",
+			    eth_dev->data->name);
+		goto en_vport_fail;
+	}
+
+	/* Open physical port and start packet receiving. */
+	err = hinic3_set_port_enable(nic_dev->hwdev, true);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Enable physical port failed, dev_name: %s",
+			    eth_dev->data->name);
+		goto en_port_fail;
+	}
+
+	/* Update eth_dev link status. */
+	if (eth_dev->data->dev_conf.intr_conf.lsc != 0)
+		hinic3_link_update(eth_dev, 0);
+
+	hinic3_set_bit(HINIC3_DEV_START, &nic_dev->dev_status);
+
+	return 0;
+
+en_port_fail:
+	hinic3_set_vport_enable(nic_dev->hwdev, false);
+
+en_vport_fail:
+	/* Flush tx && rx chip resources in case of setting vport fake fail. */
+	hinic3_flush_qps_res(nic_dev->hwdev);
+	rte_delay_ms(DEV_START_DELAY_MS);
+	for (i = 0; i < nic_dev->num_rqs; i++) {
+		rxq = nic_dev->rxqs[i];
+		hinic3_remove_rq_from_rx_queue_list(nic_dev, rxq->q_id);
+		hinic3_free_rxq_mbufs(rxq);
+		hinic3_dev_rx_queue_intr_disable(eth_dev, rxq->q_id);
+		eth_dev->data->rx_queue_state[i] = RTE_ETH_QUEUE_STATE_STOPPED;
+		eth_dev->data->tx_queue_state[i] = RTE_ETH_QUEUE_STATE_STOPPED;
+	}
+start_rqs_fail:
+	hinic3_remove_rxtx_configure(eth_dev);
+
+set_rxtx_config_fail:
+set_mtu_fail:
+	hinic3_free_qp_ctxts(nic_dev->hwdev);
+
+init_qp_fail:
+get_feature_err:
+init_func_tbl_fail:
+	hinic3_deinit_rxq_intr(eth_dev);
+init_rxq_intr_fail:
+	hinic3_copy_mempool_uninit(nic_dev);
+init_mpool_fail:
+	return err;
+}
+
+/**
+ * Stop the device.
+ *
+ * Stop phy port and vport, flush pending io request, clean context configure
+ * and free io resource.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ */
+static int
+hinic3_dev_stop(struct rte_eth_dev *dev)
+{
+	struct hinic3_nic_dev *nic_dev;
+	struct rte_eth_link link;
+	int err;
+
+	nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	if (!hinic3_test_and_clear_bit(HINIC3_DEV_START,
+				       &nic_dev->dev_status)) {
+		PMD_DRV_LOG(INFO, "Device %s already stopped",
+			    nic_dev->dev_name);
+		return 0;
+	}
+
+	/* Stop phy port and vport. */
+	err = hinic3_set_port_enable(nic_dev->hwdev, false);
+	if (err)
+		PMD_DRV_LOG(WARNING,
+			    "Disable phy port failed, error: %d, dev_name: %s, port_id: %d",
+			    err, dev->data->name, dev->data->port_id);
+
+	err = hinic3_set_vport_enable(nic_dev->hwdev, false);
+	if (err)
+		PMD_DRV_LOG(WARNING,
+			    "Disable vport failed, error: %d, dev_name: %s, port_id: %d",
+			    err, dev->data->name, dev->data->port_id);
+
+	/* Clear recorded link status. */
+	memset(&link, 0, sizeof(link));
+	rte_eth_linkstatus_set(dev, &link);
+
+	/* Disable dp interrupt. */
+	hinic3_disable_queue_intr(dev);
+	hinic3_deinit_rxq_intr(dev);
+
+	/* Flush pending io request. */
+	hinic3_flush_txqs(nic_dev);
+
+	/* After set vport disable 100ms, no packets will be send to host. */
+	rte_delay_ms(DEV_STOP_DELAY_MS);
+
+	hinic3_flush_qps_res(nic_dev->hwdev);
+
+	/* Clean RSS table and rx_mode. */
+	hinic3_remove_rxtx_configure(dev);
+
+	/* Clean root context. */
+	hinic3_free_qp_ctxts(nic_dev->hwdev);
+
+	/* Free all tx and rx mbufs. */
+	hinic3_free_all_txq_mbufs(nic_dev);
+	hinic3_free_all_rxq_mbufs(nic_dev);
+
+	/* Free mempool. */
+	hinic3_copy_mempool_uninit(nic_dev);
+	return 0;
+}
+
+static void
+hinic3_dev_release(struct rte_eth_dev *eth_dev)
+{
+	struct hinic3_nic_dev *nic_dev =
+		HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	int qid;
+
+	/* Release io resource. */
+	for (qid = 0; qid < nic_dev->num_sqs; qid++)
+		hinic3_tx_queue_release(eth_dev, qid);
+
+	for (qid = 0; qid < nic_dev->num_rqs; qid++)
+		hinic3_rx_queue_release(eth_dev, qid);
+
+	hinic3_deinit_sw_rxtxqs(nic_dev);
+
+	hinic3_deinit_mac_addr(eth_dev);
+	rte_free(nic_dev->mc_list);
+
+	hinic3_remove_all_vlanid(eth_dev);
+
+	hinic3_clear_bit(HINIC3_DEV_INTR_EN, &nic_dev->dev_status);
+	hinic3_set_msix_state(nic_dev->hwdev, 0, HINIC3_MSIX_DISABLE);
+	rte_intr_disable(PCI_DEV_TO_INTR_HANDLE(pci_dev));
+	rte_intr_callback_unregister(PCI_DEV_TO_INTR_HANDLE(pci_dev),
+				     hinic3_dev_interrupt_handler,
+				     (void *)eth_dev);
+
+	hinic3_free_nic_hwdev(nic_dev->hwdev);
+	hinic3_free_hwdev(nic_dev->hwdev);
+
+	eth_dev->rx_pkt_burst = NULL;
+	eth_dev->tx_pkt_burst = NULL;
+	eth_dev->dev_ops = NULL;
+
+	rte_free(nic_dev->hwdev);
+	nic_dev->hwdev = NULL;
+}
+
+/**
+ * Close the device.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+hinic3_dev_close(struct rte_eth_dev *eth_dev)
+{
+	struct hinic3_nic_dev *nic_dev =
+		HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(eth_dev);
+	int ret;
+
+	if (hinic3_test_and_set_bit(HINIC3_DEV_CLOSE, &nic_dev->dev_status)) {
+		PMD_DRV_LOG(WARNING, "Device %s already closed",
+			    nic_dev->dev_name);
+		return 0;
+	}
+
+	ret = hinic3_dev_stop(eth_dev);
+
+	hinic3_dev_release(eth_dev);
+	return ret;
+}
+
+#define MIN_RX_BUFFER_SIZE	      256
+#define MIN_RX_BUFFER_SIZE_SMALL_MODE 1518
+
+static int
+hinic3_dev_set_mtu(struct rte_eth_dev *dev, uint16_t mtu)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	int err = 0;
+
+	PMD_DRV_LOG(DEBUG, "Set port mtu, port_id: %d, mtu: %d, max_pkt_len: %d",
+		    dev->data->port_id, mtu, HINIC3_MTU_TO_PKTLEN(mtu));
+
+	err = hinic3_set_port_mtu(nic_dev->hwdev, mtu);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Set port mtu failed, err: %d", err);
+		return err;
+	}
+
+	/* Update max frame size. */
+	HINIC3_MAX_RX_PKT_LEN(dev->data->dev_conf.rxmode) =
+		HINIC3_MTU_TO_PKTLEN(mtu);
+	nic_dev->mtu_size = mtu;
+	return err;
+}
+
+/**
+ * Add or delete vlan id.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ * @param[in] vlan_id
+ * Vlan id is used to filter vlan packets.
+ * @param[in] enable
+ * Disable or enable vlan filter function.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+hinic3_vlan_filter_set(struct rte_eth_dev *dev, uint16_t vlan_id, int enable)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	int err = 0;
+	uint16_t func_id;
+
+	if (vlan_id == 0)
+		return 0;
+
+	func_id = hinic3_global_func_id(nic_dev->hwdev);
+
+	if (enable) {
+		/* If vlanid is already set, just return. */
+		if (hinic3_find_vlan_filter(nic_dev, vlan_id)) {
+			PMD_DRV_LOG(WARNING, "Vlan %u has been added, device: %s",
+				    vlan_id, nic_dev->dev_name);
+			return 0;
+		}
+
+		err = hinic3_add_vlan(nic_dev->hwdev, vlan_id, func_id);
+	} else {
+		/* If vlanid can't be found, just return. */
+		if (!hinic3_find_vlan_filter(nic_dev, vlan_id)) {
+			PMD_DRV_LOG(WARNING,
+				    "Vlan %u is not in the vlan filter list, device: %s",
+				    vlan_id, nic_dev->dev_name);
+			return 0;
+		}
+
+		err = hinic3_del_vlan(nic_dev->hwdev, vlan_id, func_id);
+	}
+
+	if (err) {
+		PMD_DRV_LOG(ERR,
+			    "%s vlan failed, func_id: %d, vlan_id: %d, err: %d",
+			    enable ? "Add" : "Remove", func_id, vlan_id, err);
+		return err;
+	}
+
+	hinic3_store_vlan_filter(nic_dev, vlan_id, enable);
+
+	PMD_DRV_LOG(DEBUG, "%s vlan %u succeed, device: %s",
+		    enable ? "Add" : "Remove", vlan_id, nic_dev->dev_name);
+
+	return 0;
+}
+
+/**
+ * Enable or disable vlan offload.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ * @param[in] mask
+ * Definitions used for VLAN setting, vlan filter of vlan strip.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+hinic3_vlan_offload_set(struct rte_eth_dev *dev, int mask)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	struct rte_eth_rxmode *rxmode = &dev->data->dev_conf.rxmode;
+	bool on;
+	int err;
+
+	/* Enable or disable VLAN filter. */
+	if (mask & RTE_ETH_VLAN_FILTER_MASK) {
+		on = (rxmode->offloads & RTE_ETH_RX_OFFLOAD_VLAN_FILTER) ? true : false;
+		err = hinic3_set_vlan_filter(nic_dev->hwdev, on);
+		if (err) {
+			PMD_DRV_LOG(ERR,
+				    "%s vlan filter failed, device: %s, port_id: %d",
+				    on ? "Enable" : "Disable", nic_dev->dev_name,
+				    dev->data->port_id);
+			return err;
+		}
+		PMD_DRV_LOG(DEBUG,
+			    "%s vlan filter succeed, device: %s, port_id: %d",
+			    on ? "Enable" : "Disable", nic_dev->dev_name,
+			    dev->data->port_id);
+	}
+
+	/* Enable or disable VLAN stripping. */
+	if (mask & RTE_ETH_VLAN_STRIP_MASK) {
+		on = (rxmode->offloads & RTE_ETH_RX_OFFLOAD_VLAN_STRIP) ? true : false;
+		err = hinic3_set_rx_vlan_offload(nic_dev->hwdev, on);
+		if (err) {
+			PMD_DRV_LOG(ERR,
+				    "%s vlan strip failed, device: %s, port_id: %d",
+				    on ? "Enable" : "Disable", nic_dev->dev_name,
+				    dev->data->port_id);
+			return err;
+		}
+
+		PMD_DRV_LOG(DEBUG,
+			    "%s vlan strip succeed, device: %s, port_id: %d",
+			    on ? "Enable" : "Disable", nic_dev->dev_name,
+			    dev->data->port_id);
+	}
+	return 0;
+}
+
+/**
+ * Enable allmulticast mode.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+hinic3_dev_allmulticast_enable(struct rte_eth_dev *dev)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	uint32_t rx_mode = nic_dev->rx_mode | HINIC3_RX_MODE_MC_ALL;
+	int err;
+
+	err = hinic3_set_rx_mode(nic_dev->hwdev, rx_mode);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Enable allmulticast failed, error: %d", err);
+		return err;
+	}
+
+	nic_dev->rx_mode = rx_mode;
+
+	PMD_DRV_LOG(DEBUG,
+		    "Enable allmulticast succeed, nic_dev: %s, port_id: %d",
+		    nic_dev->dev_name, dev->data->port_id);
+	return 0;
+}
+
+/**
+ * Disable allmulticast mode.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+hinic3_dev_allmulticast_disable(struct rte_eth_dev *dev)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	uint32_t rx_mode = nic_dev->rx_mode & (~HINIC3_RX_MODE_MC_ALL);
+	int err;
+
+	err = hinic3_set_rx_mode(nic_dev->hwdev, rx_mode);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Disable allmulticast failed, error: %d", err);
+		return err;
+	}
+
+	nic_dev->rx_mode = rx_mode;
+
+	PMD_DRV_LOG(DEBUG,
+		    "Disable allmulticast succeed, nic_dev: %s, port_id: %d",
+		    nic_dev->dev_name, dev->data->port_id);
+	return 0;
+}
+
+/**
+ * Get device generic statistics.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ * @param[out] stats
+ * Stats structure output buffer.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+hinic3_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	struct hinic3_vport_stats vport_stats;
+	uint64_t rx_discards_pmd = 0;
+	int err;
+
+	err = hinic3_get_vport_stats(nic_dev->hwdev, &vport_stats);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Get vport stats from fw failed, nic_dev: %s",
+			    nic_dev->dev_name);
+		return err;
+	}
+
+	/* Rx queue stats. */
+	for (uint32_t i = 0; i < nic_dev->num_rqs; i++) {
+		struct hinic3_rxq *rxq = nic_dev->rxqs[i];
+#ifdef HINIC3_XSTAT_MBUF_USE
+		rxq->rxq_stats.rx_left_mbuf_bytes =
+			rxq->rxq_stats.rx_alloc_mbuf_bytes -
+			rxq->rxq_stats.rx_free_mbuf_bytes;
+#endif
+		rxq->rxq_stats.errors = rxq->rxq_stats.csum_errors +
+					rxq->rxq_stats.other_errors;
+		if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+			stats->q_ipackets[i] = rxq->rxq_stats.packets;
+			stats->q_ibytes[i] = rxq->rxq_stats.bytes;
+			stats->q_errors[i] = rxq->rxq_stats.errors;
+		}
+		stats->ierrors += rxq->rxq_stats.errors;
+		rx_discards_pmd += rxq->rxq_stats.dropped;
+		dev->data->rx_mbuf_alloc_failed += rxq->rxq_stats.rx_nombuf;
+	}
+
+	/* Tx queue stats. */
+	for (uint32_t i = 0; i < nic_dev->num_sqs; i++) {
+		struct hinic3_txq *txq = nic_dev->txqs[i];
+		stats->oerrors += (txq->txq_stats.tx_busy + txq->txq_stats.offload_errors);
+		if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+			stats->q_opackets[i] = txq->txq_stats.packets;
+			stats->q_obytes[i] = txq->txq_stats.bytes;
+		}
+	}
+
+	/* Vport stats. */
+	stats->oerrors += vport_stats.tx_discard_vport;
+
+	stats->imissed = vport_stats.rx_discard_vport + rx_discards_pmd;
+
+	stats->ipackets = vport_stats.rx_unicast_pkts_vport +
+				vport_stats.rx_multicast_pkts_vport +
+				vport_stats.rx_broadcast_pkts_vport;
+
+	stats->opackets = vport_stats.tx_unicast_pkts_vport +
+				vport_stats.tx_multicast_pkts_vport +
+				vport_stats.tx_broadcast_pkts_vport;
+
+	stats->ibytes = vport_stats.rx_unicast_bytes_vport +
+				vport_stats.rx_multicast_bytes_vport +
+				vport_stats.rx_broadcast_bytes_vport;
+
+	stats->obytes = vport_stats.tx_unicast_bytes_vport +
+				vport_stats.tx_multicast_bytes_vport +
+				vport_stats.tx_broadcast_bytes_vport;
+	return 0;
+}
+
+/**
+ * Clear device generic statistics.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+hinic3_dev_stats_reset(struct rte_eth_dev *dev)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	struct hinic3_rxq *rxq = NULL;
+	struct hinic3_txq *txq = NULL;
+	int qid;
+	int err;
+
+	dev->data->rx_mbuf_alloc_failed = 0;
+
+	err = hinic3_clear_vport_stats(nic_dev->hwdev);
+	if (err)
+		return err;
+
+	for (qid = 0; qid < nic_dev->num_rqs; qid++) {
+		rxq = nic_dev->rxqs[qid];
+		memset(&rxq->rxq_stats, 0, sizeof(struct hinic3_rxq_stats));
+	}
+
+	for (qid = 0; qid < nic_dev->num_sqs; qid++) {
+		txq = nic_dev->txqs[qid];
+		memset(&txq->txq_stats, 0, sizeof(struct hinic3_txq_stats));
+	}
+
+	return 0;
+}
+
+/**
+ * Get device extended statistics.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ * @param[out] xstats
+ * Pointer to rte extended stats table.
+ * @param[in] n
+ * The size of the stats table.
+ *
+ * @return
+ * positive: Number of extended stats on success and stats is filled.
+ * negative: Failure.
+ */
+static int
+hinic3_dev_xstats_get(struct rte_eth_dev *dev, struct rte_eth_xstat *xstats,
+		      unsigned int n)
+{
+	struct hinic3_nic_dev *nic_dev;
+	struct mag_phy_port_stats port_stats;
+	struct hinic3_vport_stats vport_stats;
+	struct hinic3_rxq *rxq = NULL;
+	struct hinic3_rxq_stats rxq_stats;
+	struct hinic3_txq *txq = NULL;
+	struct hinic3_txq_stats txq_stats;
+	uint16_t qid;
+	uint32_t i, count;
+	int err;
+
+	nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	count = hinic3_xstats_calc_num(nic_dev);
+	if (n < count)
+		return count;
+
+	count = 0;
+
+	/* Get stats from rxq stats structure. */
+	for (qid = 0; qid < nic_dev->num_rqs; qid++) {
+		rxq = nic_dev->rxqs[qid];
+
+#ifdef HINIC3_XSTAT_RXBUF_INFO
+		hinic3_get_stats(rxq);
+#endif
+
+#ifdef HINIC3_XSTAT_MBUF_USE
+		rxq->rxq_stats.rx_left_mbuf_bytes =
+			rxq->rxq_stats.rx_alloc_mbuf_bytes -
+			rxq->rxq_stats.rx_free_mbuf_bytes;
+#endif
+		rxq->rxq_stats.errors = rxq->rxq_stats.csum_errors +
+					rxq->rxq_stats.other_errors;
+
+		rxq_stats = rxq->rxq_stats;
+
+		for (i = 0; i < HINIC3_RXQ_XSTATS_NUM; i++) {
+			xstats[count].value = *(uint64_t *)(((char *)&rxq_stats) +
+					    hinic3_rxq_stats_strings[i].offset);
+			xstats[count].id = count;
+			count++;
+		}
+	}
+
+	/* Get stats from txq stats structure. */
+	for (qid = 0; qid < nic_dev->num_sqs; qid++) {
+		txq = nic_dev->txqs[qid];
+		txq_stats = txq->txq_stats;
+
+		for (i = 0; i < HINIC3_TXQ_XSTATS_NUM; i++) {
+			xstats[count].value = *(uint64_t *)(((char *)&txq_stats) +
+					    hinic3_txq_stats_strings[i].offset);
+			xstats[count].id = count;
+			count++;
+		}
+	}
+
+	/* Get stats from vport stats structure. */
+	err = hinic3_get_vport_stats(nic_dev->hwdev, &vport_stats);
+	if (err)
+		return err;
+
+	for (i = 0; i < HINIC3_VPORT_XSTATS_NUM; i++) {
+		xstats[count].value =
+			*(uint64_t *)(((char *)&vport_stats) +
+				      hinic3_vport_stats_strings[i].offset);
+		xstats[count].id = count;
+		count++;
+	}
+
+	if (HINIC3_IS_VF(nic_dev->hwdev))
+		return count;
+
+	/* Get stats from phy port stats structure. */
+	err = hinic3_get_phy_port_stats(nic_dev->hwdev, &port_stats);
+	if (err)
+		return err;
+
+	for (i = 0; i < HINIC3_PHYPORT_XSTATS_NUM; i++) {
+		xstats[count].value =
+			*(uint64_t *)(((char *)&port_stats) +
+				      hinic3_phyport_stats_strings[i].offset);
+		xstats[count].id = count;
+		count++;
+	}
+
+	return count;
+}
+
+/**
+ * Clear device extended statistics.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+hinic3_dev_xstats_reset(struct rte_eth_dev *dev)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	int err;
+
+	err = hinic3_dev_stats_reset(dev);
+	if (err)
+		return err;
+
+	if (hinic3_func_type(nic_dev->hwdev) != TYPE_VF) {
+		err = hinic3_clear_phy_port_stats(nic_dev->hwdev);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+/**
+ * Retrieve names of extended device statistics.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ * @param[out] xstats_names
+ * Buffer to insert names into.
+ *
+ * @return
+ * Number of xstats names.
+ */
+static int
+hinic3_dev_xstats_get_names(struct rte_eth_dev *dev,
+			    struct rte_eth_xstat_name *xstats_names,
+			    __rte_unused unsigned int limit)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	int count = 0;
+	uint16_t i, q_num;
+
+	if (xstats_names == NULL)
+		return hinic3_xstats_calc_num(nic_dev);
+
+	/* Get pmd rxq stats name. */
+	for (q_num = 0; q_num < nic_dev->num_rqs; q_num++) {
+		for (i = 0; i < HINIC3_RXQ_XSTATS_NUM; i++) {
+			snprintf(xstats_names[count].name,
+				 sizeof(xstats_names[count].name),
+				 "rxq%d_%s_pmd", q_num,
+				 hinic3_rxq_stats_strings[i].name);
+			count++;
+		}
+	}
+
+	/* Get pmd txq stats name. */
+	for (q_num = 0; q_num < nic_dev->num_sqs; q_num++) {
+		for (i = 0; i < HINIC3_TXQ_XSTATS_NUM; i++) {
+			snprintf(xstats_names[count].name,
+				 sizeof(xstats_names[count].name),
+				 "txq%d_%s_pmd", q_num,
+				 hinic3_txq_stats_strings[i].name);
+			count++;
+		}
+	}
+
+	/* Get vport stats name. */
+	for (i = 0; i < HINIC3_VPORT_XSTATS_NUM; i++) {
+		strlcpy(xstats_names[count].name,
+			hinic3_vport_stats_strings[i].name,
+			sizeof(xstats_names[count].name));
+		count++;
+	}
+
+	if (HINIC3_IS_VF(nic_dev->hwdev))
+		return count;
+
+	/* Get phy port stats name. */
+	for (i = 0; i < HINIC3_PHYPORT_XSTATS_NUM; i++) {
+		strlcpy(xstats_names[count].name,
+			hinic3_phyport_stats_strings[i].name,
+			sizeof(xstats_names[count].name));
+		count++;
+	}
+
+	return count;
+}
+
+static void
+hinic3_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
+		    struct rte_eth_rxq_info *qinfo)
+{
+	struct hinic3_rxq *rxq = dev->data->rx_queues[queue_id];
+
+	qinfo->mp = rxq->mb_pool;
+	qinfo->nb_desc = rxq->q_depth;
+	qinfo->rx_buf_size = rxq->buf_len;
+	qinfo->conf.offloads = dev->data->dev_conf.rxmode.offloads;
+	qinfo->conf.rx_free_thresh = rxq->rx_free_thresh;
+	qinfo->conf.rx_deferred_start = rxq->rx_deferred_start;
+}
+
+static void
+hinic3_txq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
+		    struct rte_eth_txq_info *qinfo)
+{
+	struct hinic3_txq *txq = dev->data->tx_queues[queue_id];
+
+	qinfo->nb_desc = txq->q_depth;
+	qinfo->conf.offloads = dev->data->dev_conf.txmode.offloads;
+	qinfo->conf.tx_free_thresh = txq->tx_free_thresh;
+	qinfo->conf.tx_deferred_start = txq->tx_deferred_start;
+}
+
+/**
+ * Update MAC address.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ * @param[in] addr
+ * Pointer to MAC address.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+hinic3_set_mac_addr(struct rte_eth_dev *dev, struct rte_ether_addr *addr)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	char mac_addr[RTE_ETHER_ADDR_FMT_SIZE];
+	uint16_t func_id;
+	int err;
+
+	if (!rte_is_valid_assigned_ether_addr(addr)) {
+		rte_ether_format_addr(mac_addr, RTE_ETHER_ADDR_FMT_SIZE, addr);
+		PMD_DRV_LOG(ERR, "Set invalid MAC address %s", mac_addr);
+		return -EINVAL;
+	}
+
+	func_id = hinic3_global_func_id(nic_dev->hwdev);
+	err = hinic3_update_mac(nic_dev->hwdev,
+				nic_dev->default_addr.addr_bytes,
+				addr->addr_bytes, 0, func_id);
+	if (err)
+		return err;
+
+	rte_ether_addr_copy(addr, &nic_dev->default_addr);
+	rte_ether_format_addr(mac_addr, RTE_ETHER_ADDR_FMT_SIZE,
+			      &nic_dev->default_addr);
+
+	PMD_DRV_LOG(DEBUG, "Set new MAC address %s", mac_addr);
+	return 0;
+}
+
+/**
+ * Remove a MAC address.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ * @param[in] index
+ * MAC address index.
+ */
+static void
+hinic3_mac_addr_remove(struct rte_eth_dev *dev, uint32_t index)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	uint16_t func_id;
+	int err;
+
+	if (index >= HINIC3_MAX_UC_MAC_ADDRS) {
+		PMD_DRV_LOG(ERR, "Remove MAC index(%u) is out of range", index);
+		return;
+	}
+
+	func_id = hinic3_global_func_id(nic_dev->hwdev);
+	err = hinic3_del_mac(nic_dev->hwdev,
+			     dev->data->mac_addrs[index].addr_bytes, 0, func_id);
+	if (err)
+		PMD_DRV_LOG(ERR, "Remove MAC index(%u) failed", index);
+}
+
+/**
+ * Add a MAC address.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ * @param[in] mac_addr
+ * MAC address to register.
+ * @param[in] index
+ * MAC address index.
+ * @param[in] vmdq
+ * VMDq pool index to associate address with (unused_).
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+hinic3_mac_addr_add(struct rte_eth_dev *dev, struct rte_ether_addr *mac_addr,
+		    uint32_t index, __rte_unused uint32_t vmdq)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	unsigned int i;
+	uint16_t func_id;
+	int err;
+
+	if (!rte_is_valid_assigned_ether_addr(mac_addr)) {
+		PMD_DRV_LOG(ERR, "Add invalid MAC address");
+		return -EINVAL;
+	}
+
+	if (index >= HINIC3_MAX_UC_MAC_ADDRS) {
+		PMD_DRV_LOG(ERR, "Add MAC index(%u) is out of range", index);
+		return -EINVAL;
+	}
+
+	/* Make sure this address doesn't already be configured. */
+	for (i = 0; i < HINIC3_MAX_UC_MAC_ADDRS; i++) {
+		if (rte_is_same_ether_addr(mac_addr,
+					   &dev->data->mac_addrs[i])) {
+			PMD_DRV_LOG(ERR, "MAC address is already configured");
+			return -EADDRINUSE;
+		}
+	}
+
+	func_id = hinic3_global_func_id(nic_dev->hwdev);
+	err = hinic3_set_mac(nic_dev->hwdev, mac_addr->addr_bytes, 0, func_id);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+/**
+ * Set multicast MAC address.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ * @param[in] mc_addr_set
+ * Pointer to multicast MAC address.
+ * @param[in] nb_mc_addr
+ * The number of multicast MAC address to set.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+hinic3_set_mc_addr_list(struct rte_eth_dev *dev,
+			struct rte_ether_addr *mc_addr_set, uint32_t nb_mc_addr)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	char mac_addr[RTE_ETHER_ADDR_FMT_SIZE];
+	uint16_t func_id;
+	int err;
+	uint32_t i;
+
+	func_id = hinic3_global_func_id(nic_dev->hwdev);
+
+	/* Delete old multi_cast addrs firstly. */
+	hinic3_delete_mc_addr_list(nic_dev);
+
+	if (nb_mc_addr > HINIC3_MAX_MC_MAC_ADDRS)
+		return -EINVAL;
+
+	for (i = 0; i < nb_mc_addr; i++) {
+		if (!rte_is_multicast_ether_addr(&mc_addr_set[i])) {
+			rte_ether_format_addr(mac_addr, RTE_ETHER_ADDR_FMT_SIZE, &mc_addr_set[i]);
+			PMD_DRV_LOG(ERR, "Set mc MAC addr failed, addr(%s) invalid", mac_addr);
+			return -EINVAL;
+		}
+	}
+
+	for (i = 0; i < nb_mc_addr; i++) {
+		err = hinic3_set_mac(nic_dev->hwdev, mc_addr_set[i].addr_bytes, 0, func_id);
+		if (err) {
+			hinic3_delete_mc_addr_list(nic_dev);
+			return err;
+		}
+
+		rte_ether_addr_copy(&mc_addr_set[i], &nic_dev->mc_list[i]);
+	}
+
+	return 0;
+}
+
+static const struct eth_dev_ops hinic3_pmd_ops = {
+	.dev_configure                 = hinic3_dev_configure,
+	.dev_infos_get                 = hinic3_dev_infos_get,
+	.fw_version_get                = hinic3_fw_version_get,
+	.dev_set_link_up               = hinic3_dev_set_link_up,
+	.dev_set_link_down             = hinic3_dev_set_link_down,
+	.link_update                   = hinic3_link_update,
+	.rx_queue_setup                = hinic3_rx_queue_setup,
+	.tx_queue_setup                = hinic3_tx_queue_setup,
+	.rx_queue_release              = hinic3_rx_queue_release,
+	.tx_queue_release              = hinic3_tx_queue_release,
+	.rx_queue_start                = hinic3_dev_rx_queue_start,
+	.rx_queue_stop                 = hinic3_dev_rx_queue_stop,
+	.tx_queue_start                = hinic3_dev_tx_queue_start,
+	.tx_queue_stop                 = hinic3_dev_tx_queue_stop,
+	.rx_queue_intr_enable          = hinic3_dev_rx_queue_intr_enable,
+	.rx_queue_intr_disable         = hinic3_dev_rx_queue_intr_disable,
+	.dev_start                     = hinic3_dev_start,
+	.dev_stop                      = hinic3_dev_stop,
+	.dev_close                     = hinic3_dev_close,
+	.mtu_set                       = hinic3_dev_set_mtu,
+	.vlan_filter_set               = hinic3_vlan_filter_set,
+	.vlan_offload_set              = hinic3_vlan_offload_set,
+	.allmulticast_enable           = hinic3_dev_allmulticast_enable,
+	.allmulticast_disable          = hinic3_dev_allmulticast_disable,
+	.stats_get                     = hinic3_dev_stats_get,
+	.stats_reset                   = hinic3_dev_stats_reset,
+	.xstats_get                    = hinic3_dev_xstats_get,
+	.xstats_reset                  = hinic3_dev_xstats_reset,
+	.xstats_get_names              = hinic3_dev_xstats_get_names,
+	.rxq_info_get                  = hinic3_rxq_info_get,
+	.txq_info_get                  = hinic3_txq_info_get,
+	.mac_addr_set                  = hinic3_set_mac_addr,
+	.mac_addr_remove               = hinic3_mac_addr_remove,
+	.mac_addr_add                  = hinic3_mac_addr_add,
+	.set_mc_addr_list              = hinic3_set_mc_addr_list,
+};
+
+static const struct eth_dev_ops hinic3_pmd_vf_ops = {
+	.dev_configure                 = hinic3_dev_configure,
+	.dev_infos_get                 = hinic3_dev_infos_get,
+	.fw_version_get                = hinic3_fw_version_get,
+	.rx_queue_setup                = hinic3_rx_queue_setup,
+	.tx_queue_setup                = hinic3_tx_queue_setup,
+	.rx_queue_intr_enable          = hinic3_dev_rx_queue_intr_enable,
+	.rx_queue_intr_disable         = hinic3_dev_rx_queue_intr_disable,
+
+	.rx_queue_start                = hinic3_dev_rx_queue_start,
+	.rx_queue_stop                 = hinic3_dev_rx_queue_stop,
+	.tx_queue_start                = hinic3_dev_tx_queue_start,
+	.tx_queue_stop                 = hinic3_dev_tx_queue_stop,
+
+	.dev_start                     = hinic3_dev_start,
+	.link_update                   = hinic3_link_update,
+	.rx_queue_release              = hinic3_rx_queue_release,
+	.tx_queue_release              = hinic3_tx_queue_release,
+	.dev_stop                      = hinic3_dev_stop,
+	.dev_close                     = hinic3_dev_close,
+	.mtu_set                       = hinic3_dev_set_mtu,
+	.vlan_filter_set               = hinic3_vlan_filter_set,
+	.vlan_offload_set              = hinic3_vlan_offload_set,
+	.allmulticast_enable           = hinic3_dev_allmulticast_enable,
+	.allmulticast_disable          = hinic3_dev_allmulticast_disable,
+	.stats_get                     = hinic3_dev_stats_get,
+	.stats_reset                   = hinic3_dev_stats_reset,
+	.xstats_get                    = hinic3_dev_xstats_get,
+	.xstats_reset                  = hinic3_dev_xstats_reset,
+	.xstats_get_names              = hinic3_dev_xstats_get_names,
+	.rxq_info_get                  = hinic3_rxq_info_get,
+	.txq_info_get                  = hinic3_txq_info_get,
+	.mac_addr_set                  = hinic3_set_mac_addr,
+	.mac_addr_remove               = hinic3_mac_addr_remove,
+	.mac_addr_add                  = hinic3_mac_addr_add,
+	.set_mc_addr_list              = hinic3_set_mc_addr_list,
+};
diff --git a/drivers/net/hinic3/hinic3_ethdev.h b/drivers/net/hinic3/hinic3_ethdev.h
index f75e34a8b7..9ab6825c4a 100644
--- a/drivers/net/hinic3/hinic3_ethdev.h
+++ b/drivers/net/hinic3/hinic3_ethdev.h
@@ -115,4 +115,28 @@ struct hinic3_nic_dev {
 	uint32_t vfta[HINIC3_VFTA_SIZE]; /**< VLAN bitmap. */
 };
 
+/**
+ * Enable interrupt for the specified RX queue.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ * @param[in] queue_id
+ * The ID of the receive queue for which the interrupt is being enabled.
+ * @return
+ * 0 on success, a negative error code on failure.
+ */
+int hinic3_dev_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id);
+
+/**
+ * Disable interrupt for the specified RX queue.
+ *
+ * @param[in] dev
+ * Pointer to ethernet device structure.
+ * @param[in] queue_id
+ * The ID of the receive queue for which the interrupt is being disabled.
+ * @return
+ * 0 on success, a negative error code on failure.
+ */
+int hinic3_dev_rx_queue_intr_disable(struct rte_eth_dev *dev,
+				     uint16_t queue_id);
 #endif /* _HINIC3_ETHDEV_H_ */
diff --git a/drivers/net/hinic3/hinic3_nic_io.c b/drivers/net/hinic3/hinic3_nic_io.c
new file mode 100644
index 0000000000..7f2972f1d1
--- /dev/null
+++ b/drivers/net/hinic3/hinic3_nic_io.c
@@ -0,0 +1,802 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+
+#include "base/hinic3_compat.h"
+#include "base/hinic3_cmd.h"
+#include "base/hinic3_cmdq.h"
+#include "base/hinic3_hw_comm.h"
+#include "base/hinic3_nic_cfg.h"
+#include "hinic3_nic_io.h"
+#include "hinic3_rx.h"
+#include "hinic3_tx.h"
+
+#define HINIC3_DEAULT_TX_CI_PENDING_LIMIT   3
+#define HINIC3_DEAULT_TX_CI_COALESCING_TIME 16
+#define HINIC3_DEAULT_DROP_THD_ON	    0xFFFF
+#define HINIC3_DEAULT_DROP_THD_OFF	    0
+
+#define WQ_PREFETCH_MAX	      6
+#define WQ_PREFETCH_MIN	      1
+#define WQ_PREFETCH_THRESHOLD 256
+
+#define HINIC3_Q_CTXT_MAX \
+	((uint16_t)(((HINIC3_CMDQ_BUF_SIZE - 8) - RTE_PKTMBUF_HEADROOM) / 64))
+
+enum hinic3_qp_ctxt_type {
+	HINIC3_QP_CTXT_TYPE_SQ,
+	HINIC3_QP_CTXT_TYPE_RQ,
+};
+
+struct hinic3_qp_ctxt_header {
+	uint16_t num_queues;
+	uint16_t queue_type;
+	uint16_t start_qid;
+	uint16_t rsvd;
+};
+
+struct hinic3_sq_ctxt {
+	uint32_t ci_pi;
+	uint32_t drop_mode_sp;    /**< Packet drop mode and special flags. */
+	uint32_t wq_pfn_hi_owner; /**< High PFN and ownership flag. */
+	uint32_t wq_pfn_lo;	     /**< Low bits of work queue PFN. */
+
+	uint32_t rsvd0;	  /**< Reserved field 0. */
+	uint32_t pkt_drop_thd; /**< Packet drop threshold. */
+	uint32_t global_sq_id;
+	uint32_t vlan_ceq_attr; /**< VLAN and CEQ attributes. */
+
+	uint32_t pref_cache;	       /**< Cache prefetch settings for the queue. */
+	uint32_t pref_ci_owner;     /**< Prefetch settings for CI and ownership. */
+	uint32_t pref_wq_pfn_hi_ci; /**< Prefetch settings for high PFN and CI. */
+	uint32_t pref_wq_pfn_lo;    /**< Prefetch settings for low PFN. */
+
+	uint32_t rsvd8;	     /**< Reserved field 8. */
+	uint32_t rsvd9;	     /**< Reserved field 9. */
+	uint32_t wq_block_pfn_hi; /**< High bits of work queue block PFN. */
+	uint32_t wq_block_pfn_lo; /**< Low bits of work queue block PFN. */
+};
+
+struct hinic3_rq_ctxt {
+	uint32_t ci_pi;
+	uint32_t ceq_attr;		  /**< Completion event queue attributes. */
+	uint32_t wq_pfn_hi_type_owner; /**< High PFN, WQE type and ownership flag. */
+	uint32_t wq_pfn_lo;		  /**< Low bits of work queue PFN. */
+
+	uint32_t rsvd[3];	 /**< Reserved field. */
+	uint32_t cqe_sge_len; /**< CQE scatter/gather element length. */
+
+	uint32_t pref_cache;	       /**< Cache prefetch settings for the queue. */
+	uint32_t pref_ci_owner;     /**< Prefetch settings for CI and ownership. */
+	uint32_t pref_wq_pfn_hi_ci; /**< Prefetch settings for high PFN and CI. */
+	uint32_t pref_wq_pfn_lo;    /**< Prefetch settings for low PFN. */
+
+	uint32_t pi_paddr_hi;     /**< High 32-bits of PI DMA address. */
+	uint32_t pi_paddr_lo;     /**< Low 32-bits of PI DMA address. */
+	uint32_t wq_block_pfn_hi; /**< High bits of work queue block PFN. */
+	uint32_t wq_block_pfn_lo; /**< Low bits of work queue block PFN. */
+};
+
+struct hinic3_sq_ctxt_block {
+	struct hinic3_qp_ctxt_header cmdq_hdr;
+	struct hinic3_sq_ctxt sq_ctxt[HINIC3_Q_CTXT_MAX];
+};
+
+struct hinic3_rq_ctxt_block {
+	struct hinic3_qp_ctxt_header cmdq_hdr;
+	struct hinic3_rq_ctxt rq_ctxt[HINIC3_Q_CTXT_MAX];
+};
+
+struct hinic3_clean_queue_ctxt {
+	struct hinic3_qp_ctxt_header cmdq_hdr;
+	uint32_t rsvd;
+};
+
+#define SQ_CTXT_SIZE(num_sqs)                         \
+	((uint16_t)(sizeof(struct hinic3_qp_ctxt_header) + \
+	       (num_sqs) * sizeof(struct hinic3_sq_ctxt)))
+
+#define RQ_CTXT_SIZE(num_rqs)                         \
+	((uint16_t)(sizeof(struct hinic3_qp_ctxt_header) + \
+	       (num_rqs) * sizeof(struct hinic3_rq_ctxt)))
+
+#define CI_IDX_HIGH_SHIFH 12
+
+#define CI_HIGN_IDX(val) ((val) >> CI_IDX_HIGH_SHIFH)
+
+#define SQ_CTXT_PI_IDX_SHIFT 0
+#define SQ_CTXT_CI_IDX_SHIFT 16
+
+#define SQ_CTXT_PI_IDX_MASK 0xFFFFU
+#define SQ_CTXT_CI_IDX_MASK 0xFFFFU
+
+#define SQ_CTXT_CI_PI_SET(val, member) \
+	(((val) & SQ_CTXT_##member##_MASK) << SQ_CTXT_##member##_SHIFT)
+
+#define SQ_CTXT_MODE_SP_FLAG_SHIFT  0
+#define SQ_CTXT_MODE_PKT_DROP_SHIFT 1
+
+#define SQ_CTXT_MODE_SP_FLAG_MASK  0x1U
+#define SQ_CTXT_MODE_PKT_DROP_MASK 0x1U
+
+#define SQ_CTXT_MODE_SET(val, member)           \
+	(((val) & SQ_CTXT_MODE_##member##_MASK) \
+	 << SQ_CTXT_MODE_##member##_SHIFT)
+
+#define SQ_CTXT_WQ_PAGE_HI_PFN_SHIFT 0
+#define SQ_CTXT_WQ_PAGE_OWNER_SHIFT  23
+
+#define SQ_CTXT_WQ_PAGE_HI_PFN_MASK 0xFFFFFU
+#define SQ_CTXT_WQ_PAGE_OWNER_MASK  0x1U
+
+#define SQ_CTXT_WQ_PAGE_SET(val, member)           \
+	(((val) & SQ_CTXT_WQ_PAGE_##member##_MASK) \
+	 << SQ_CTXT_WQ_PAGE_##member##_SHIFT)
+
+#define SQ_CTXT_PKT_DROP_THD_ON_SHIFT  0
+#define SQ_CTXT_PKT_DROP_THD_OFF_SHIFT 16
+
+#define SQ_CTXT_PKT_DROP_THD_ON_MASK  0xFFFFU
+#define SQ_CTXT_PKT_DROP_THD_OFF_MASK 0xFFFFU
+
+#define SQ_CTXT_PKT_DROP_THD_SET(val, member)       \
+	(((val) & SQ_CTXT_PKT_DROP_##member##_MASK) \
+	 << SQ_CTXT_PKT_DROP_##member##_SHIFT)
+
+#define SQ_CTXT_GLOBAL_SQ_ID_SHIFT 0
+
+#define SQ_CTXT_GLOBAL_SQ_ID_MASK 0x1FFFU
+
+#define SQ_CTXT_GLOBAL_QUEUE_ID_SET(val, member) \
+	(((val) & SQ_CTXT_##member##_MASK) << SQ_CTXT_##member##_SHIFT)
+
+#define SQ_CTXT_VLAN_TAG_SHIFT	       0
+#define SQ_CTXT_VLAN_TYPE_SEL_SHIFT    16
+#define SQ_CTXT_VLAN_INSERT_MODE_SHIFT 19
+#define SQ_CTXT_VLAN_CEQ_EN_SHIFT      23
+
+#define SQ_CTXT_VLAN_TAG_MASK	      0xFFFFU
+#define SQ_CTXT_VLAN_TYPE_SEL_MASK    0x7U
+#define SQ_CTXT_VLAN_INSERT_MODE_MASK 0x3U
+#define SQ_CTXT_VLAN_CEQ_EN_MASK      0x1U
+
+#define SQ_CTXT_VLAN_CEQ_SET(val, member)       \
+	(((val) & SQ_CTXT_VLAN_##member##_MASK) \
+	 << SQ_CTXT_VLAN_##member##_SHIFT)
+
+#define SQ_CTXT_PREF_CACHE_THRESHOLD_SHIFT 0
+#define SQ_CTXT_PREF_CACHE_MAX_SHIFT	   14
+#define SQ_CTXT_PREF_CACHE_MIN_SHIFT	   25
+
+#define SQ_CTXT_PREF_CACHE_THRESHOLD_MASK 0x3FFFU
+#define SQ_CTXT_PREF_CACHE_MAX_MASK	  0x7FFU
+#define SQ_CTXT_PREF_CACHE_MIN_MASK	  0x7FU
+
+#define SQ_CTXT_PREF_CI_HI_SHIFT 0
+#define SQ_CTXT_PREF_OWNER_SHIFT 4
+
+#define SQ_CTXT_PREF_CI_HI_MASK 0xFU
+#define SQ_CTXT_PREF_OWNER_MASK 0x1U
+
+#define SQ_CTXT_PREF_WQ_PFN_HI_SHIFT 0
+#define SQ_CTXT_PREF_CI_LOW_SHIFT    20
+
+#define SQ_CTXT_PREF_WQ_PFN_HI_MASK 0xFFFFFU
+#define SQ_CTXT_PREF_CI_LOW_MASK    0xFFFU
+
+#define SQ_CTXT_PREF_SET(val, member)           \
+	(((val) & SQ_CTXT_PREF_##member##_MASK) \
+	 << SQ_CTXT_PREF_##member##_SHIFT)
+
+#define SQ_CTXT_WQ_BLOCK_PFN_HI_SHIFT 0
+
+#define SQ_CTXT_WQ_BLOCK_PFN_HI_MASK 0x7FFFFFU
+
+#define SQ_CTXT_WQ_BLOCK_SET(val, member)           \
+	(((val) & SQ_CTXT_WQ_BLOCK_##member##_MASK) \
+	 << SQ_CTXT_WQ_BLOCK_##member##_SHIFT)
+
+#define RQ_CTXT_PI_IDX_SHIFT 0
+#define RQ_CTXT_CI_IDX_SHIFT 16
+
+#define RQ_CTXT_PI_IDX_MASK 0xFFFFU
+#define RQ_CTXT_CI_IDX_MASK 0xFFFFU
+
+#define RQ_CTXT_CI_PI_SET(val, member) \
+	(((val) & RQ_CTXT_##member##_MASK) << RQ_CTXT_##member##_SHIFT)
+
+#define RQ_CTXT_CEQ_ATTR_INTR_SHIFT	21
+#define RQ_CTXT_CEQ_ATTR_INTR_ARM_SHIFT 30
+#define RQ_CTXT_CEQ_ATTR_EN_SHIFT	31
+
+#define RQ_CTXT_CEQ_ATTR_INTR_MASK     0x3FFU
+#define RQ_CTXT_CEQ_ATTR_INTR_ARM_MASK 0x1U
+#define RQ_CTXT_CEQ_ATTR_EN_MASK       0x1U
+
+#define RQ_CTXT_CEQ_ATTR_SET(val, member)           \
+	(((val) & RQ_CTXT_CEQ_ATTR_##member##_MASK) \
+	 << RQ_CTXT_CEQ_ATTR_##member##_SHIFT)
+
+#define RQ_CTXT_WQ_PAGE_HI_PFN_SHIFT   0
+#define RQ_CTXT_WQ_PAGE_WQE_TYPE_SHIFT 28
+#define RQ_CTXT_WQ_PAGE_OWNER_SHIFT    31
+
+#define RQ_CTXT_WQ_PAGE_HI_PFN_MASK   0xFFFFFU
+#define RQ_CTXT_WQ_PAGE_WQE_TYPE_MASK 0x3U
+#define RQ_CTXT_WQ_PAGE_OWNER_MASK    0x1U
+
+#define RQ_CTXT_WQ_PAGE_SET(val, member)           \
+	(((val) & RQ_CTXT_WQ_PAGE_##member##_MASK) \
+	 << RQ_CTXT_WQ_PAGE_##member##_SHIFT)
+
+#define RQ_CTXT_CQE_LEN_SHIFT 28
+
+#define RQ_CTXT_CQE_LEN_MASK 0x3U
+
+#define RQ_CTXT_CQE_LEN_SET(val, member) \
+	(((val) & RQ_CTXT_##member##_MASK) << RQ_CTXT_##member##_SHIFT)
+
+#define RQ_CTXT_PREF_CACHE_THRESHOLD_SHIFT 0
+#define RQ_CTXT_PREF_CACHE_MAX_SHIFT	   14
+#define RQ_CTXT_PREF_CACHE_MIN_SHIFT	   25
+
+#define RQ_CTXT_PREF_CACHE_THRESHOLD_MASK 0x3FFFU
+#define RQ_CTXT_PREF_CACHE_MAX_MASK	  0x7FFU
+#define RQ_CTXT_PREF_CACHE_MIN_MASK	  0x7FU
+
+#define RQ_CTXT_PREF_CI_HI_SHIFT 0
+#define RQ_CTXT_PREF_OWNER_SHIFT 4
+
+#define RQ_CTXT_PREF_CI_HI_MASK 0xFU
+#define RQ_CTXT_PREF_OWNER_MASK 0x1U
+
+#define RQ_CTXT_PREF_WQ_PFN_HI_SHIFT 0
+#define RQ_CTXT_PREF_CI_LOW_SHIFT    20
+
+#define RQ_CTXT_PREF_WQ_PFN_HI_MASK 0xFFFFFU
+#define RQ_CTXT_PREF_CI_LOW_MASK    0xFFFU
+
+#define RQ_CTXT_PREF_SET(val, member)           \
+	(((val) & RQ_CTXT_PREF_##member##_MASK) \
+	 << RQ_CTXT_PREF_##member##_SHIFT)
+
+#define RQ_CTXT_WQ_BLOCK_PFN_HI_SHIFT 0
+
+#define RQ_CTXT_WQ_BLOCK_PFN_HI_MASK 0x7FFFFFU
+
+#define RQ_CTXT_WQ_BLOCK_SET(val, member)           \
+	(((val) & RQ_CTXT_WQ_BLOCK_##member##_MASK) \
+	 << RQ_CTXT_WQ_BLOCK_##member##_SHIFT)
+
+#define SIZE_16BYTES(size) (RTE_ALIGN((size), 16) >> 4)
+
+#define WQ_PAGE_PFN_SHIFT  12
+#define WQ_BLOCK_PFN_SHIFT 9
+
+#define WQ_PAGE_PFN(page_addr)	((page_addr) >> WQ_PAGE_PFN_SHIFT)
+#define WQ_BLOCK_PFN(page_addr) ((page_addr) >> WQ_BLOCK_PFN_SHIFT)
+
+/**
+ * Prepare the command queue header and converted it to big-endian format.
+ *
+ * @param[out] qp_ctxt_hdr
+ * Pointer to command queue context header structure to be initialized.
+ * @param[in] ctxt_type
+ * Type of context (SQ/RQ) to be set in header.
+ * @param[in] num_queues
+ * Number of queues.
+ * @param[in] q_id
+ * Starting queue ID for this context.
+ */
+static void
+hinic3_qp_prepare_cmdq_header(struct hinic3_qp_ctxt_header *qp_ctxt_hdr,
+			      enum hinic3_qp_ctxt_type ctxt_type,
+			      uint16_t num_queues, uint16_t q_id)
+{
+	qp_ctxt_hdr->queue_type = ctxt_type;
+	qp_ctxt_hdr->num_queues = num_queues;
+	qp_ctxt_hdr->start_qid = q_id;
+	qp_ctxt_hdr->rsvd = 0;
+
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);
+
+	hinic3_cpu_to_be32(qp_ctxt_hdr, sizeof(*qp_ctxt_hdr));
+}
+
+/**
+ * Initialize context structure for specified TXQ by configuring various queue
+ * parameters (e.g., ci, pi, work queue page addresses).
+ *
+ * @param[in] sq
+ * Pointer to TXQ structure.
+ * @param[in] sq_id
+ * ID of TXQ being configured.
+ * @param[out] sq_ctxt
+ * Pointer to structure that will hold TXQ context.
+ */
+static void
+hinic3_sq_prepare_ctxt(struct hinic3_txq *sq, uint16_t sq_id,
+		       struct hinic3_sq_ctxt *sq_ctxt)
+{
+	uint64_t wq_page_addr, wq_page_pfn, wq_block_pfn;
+	uint32_t wq_page_pfn_hi, wq_page_pfn_lo, wq_block_pfn_hi, wq_block_pfn_lo;
+	uint16_t pi_start, ci_start;
+
+	ci_start = sq->cons_idx & sq->q_mask;
+	pi_start = sq->prod_idx & sq->q_mask;
+
+	/* Read the first page from hardware table. */
+	wq_page_addr = sq->queue_buf_paddr;
+
+	wq_page_pfn = WQ_PAGE_PFN(wq_page_addr);
+	wq_page_pfn_hi = upper_32_bits(wq_page_pfn);
+	wq_page_pfn_lo = lower_32_bits(wq_page_pfn);
+
+	/* Use 0-level CLA. */
+	wq_block_pfn = WQ_BLOCK_PFN(wq_page_addr);
+	wq_block_pfn_hi = upper_32_bits(wq_block_pfn);
+	wq_block_pfn_lo = lower_32_bits(wq_block_pfn);
+
+	sq_ctxt->ci_pi = SQ_CTXT_CI_PI_SET(ci_start, CI_IDX) |
+			 SQ_CTXT_CI_PI_SET(pi_start, PI_IDX);
+
+	sq_ctxt->drop_mode_sp = SQ_CTXT_MODE_SET(0, SP_FLAG) |
+				SQ_CTXT_MODE_SET(0, PKT_DROP);
+
+	sq_ctxt->wq_pfn_hi_owner = SQ_CTXT_WQ_PAGE_SET(wq_page_pfn_hi, HI_PFN) |
+				   SQ_CTXT_WQ_PAGE_SET(1, OWNER);
+
+	sq_ctxt->wq_pfn_lo = wq_page_pfn_lo;
+
+	sq_ctxt->pkt_drop_thd =
+		SQ_CTXT_PKT_DROP_THD_SET(HINIC3_DEAULT_DROP_THD_ON, THD_ON) |
+		SQ_CTXT_PKT_DROP_THD_SET(HINIC3_DEAULT_DROP_THD_OFF, THD_OFF);
+
+	sq_ctxt->global_sq_id =
+		SQ_CTXT_GLOBAL_QUEUE_ID_SET(sq_id, GLOBAL_SQ_ID);
+
+	/* Insert c-vlan in default. */
+	sq_ctxt->vlan_ceq_attr = SQ_CTXT_VLAN_CEQ_SET(0, CEQ_EN) |
+				 SQ_CTXT_VLAN_CEQ_SET(1, INSERT_MODE);
+
+	sq_ctxt->rsvd0 = 0;
+
+	sq_ctxt->pref_cache =
+		SQ_CTXT_PREF_SET(WQ_PREFETCH_MIN, CACHE_MIN) |
+		SQ_CTXT_PREF_SET(WQ_PREFETCH_MAX, CACHE_MAX) |
+		SQ_CTXT_PREF_SET(WQ_PREFETCH_THRESHOLD, CACHE_THRESHOLD);
+
+	sq_ctxt->pref_ci_owner =
+		SQ_CTXT_PREF_SET(CI_HIGN_IDX(ci_start), CI_HI) |
+		SQ_CTXT_PREF_SET(1, OWNER);
+
+	sq_ctxt->pref_wq_pfn_hi_ci =
+		SQ_CTXT_PREF_SET(ci_start, CI_LOW) |
+		SQ_CTXT_PREF_SET(wq_page_pfn_hi, WQ_PFN_HI);
+
+	sq_ctxt->pref_wq_pfn_lo = wq_page_pfn_lo;
+
+	sq_ctxt->wq_block_pfn_hi =
+		SQ_CTXT_WQ_BLOCK_SET(wq_block_pfn_hi, PFN_HI);
+
+	sq_ctxt->wq_block_pfn_lo = wq_block_pfn_lo;
+
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);
+
+	hinic3_cpu_to_be32(sq_ctxt, sizeof(*sq_ctxt));
+}
+
+/**
+ * Initialize context structure for specified RXQ by configuring various queue
+ * parameters (e.g., ci, pi, work queue page addresses).
+ *
+ * @param[in] rq
+ * Pointer to RXQ structure.
+ * @param[out] rq_ctxt
+ * Pointer to structure that will hold RXQ context.
+ */
+static void
+hinic3_rq_prepare_ctxt(struct hinic3_rxq *rq, struct hinic3_rq_ctxt *rq_ctxt)
+{
+	uint64_t wq_page_addr, wq_page_pfn, wq_block_pfn;
+	uint32_t wq_page_pfn_hi, wq_page_pfn_lo, wq_block_pfn_hi, wq_block_pfn_lo;
+	uint16_t pi_start, ci_start;
+	uint16_t wqe_type = rq->wqebb_shift - HINIC3_RQ_WQEBB_SHIFT;
+	uint8_t intr_disable;
+
+	/* RQ depth is in unit of 8 Bytes. */
+	ci_start = (uint16_t)((rq->cons_idx & rq->q_mask) << wqe_type);
+	pi_start = (uint16_t)((rq->prod_idx & rq->q_mask) << wqe_type);
+
+	/* Read the first page from hardware table. */
+	wq_page_addr = rq->queue_buf_paddr;
+
+	wq_page_pfn = WQ_PAGE_PFN(wq_page_addr);
+	wq_page_pfn_hi = upper_32_bits(wq_page_pfn);
+	wq_page_pfn_lo = lower_32_bits(wq_page_pfn);
+
+	/* Use 0-level CLA. */
+	wq_block_pfn = WQ_BLOCK_PFN(wq_page_addr);
+	wq_block_pfn_hi = upper_32_bits(wq_block_pfn);
+	wq_block_pfn_lo = lower_32_bits(wq_block_pfn);
+
+	rq_ctxt->ci_pi = RQ_CTXT_CI_PI_SET(ci_start, CI_IDX) |
+			 RQ_CTXT_CI_PI_SET(pi_start, PI_IDX);
+
+	/* RQ doesn't need ceq, msix_entry_idx set 1, but mask not enable. */
+	intr_disable = rq->dp_intr_en ? 0 : 1;
+	rq_ctxt->ceq_attr = RQ_CTXT_CEQ_ATTR_SET(intr_disable, EN) |
+			    RQ_CTXT_CEQ_ATTR_SET(0, INTR_ARM) |
+			    RQ_CTXT_CEQ_ATTR_SET(rq->msix_entry_idx, INTR);
+
+	/* Use 32Byte WQE with SGE for CQE in default. */
+	rq_ctxt->wq_pfn_hi_type_owner =
+		RQ_CTXT_WQ_PAGE_SET(wq_page_pfn_hi, HI_PFN) |
+		RQ_CTXT_WQ_PAGE_SET(1, OWNER);
+
+	switch (wqe_type) {
+	case HINIC3_EXTEND_RQ_WQE:
+		/* Use 32Byte WQE with SGE for CQE. */
+		rq_ctxt->wq_pfn_hi_type_owner |=
+			RQ_CTXT_WQ_PAGE_SET(0, WQE_TYPE);
+		break;
+	case HINIC3_NORMAL_RQ_WQE:
+		/* Use 16Byte WQE with 32Bytes SGE for CQE. */
+		rq_ctxt->wq_pfn_hi_type_owner |=
+			RQ_CTXT_WQ_PAGE_SET(2, WQE_TYPE);
+		rq_ctxt->cqe_sge_len = RQ_CTXT_CQE_LEN_SET(1, CQE_LEN);
+		break;
+	default:
+		PMD_DRV_LOG(INFO, "Invalid rq wqe type: %u", wqe_type);
+	}
+
+	rq_ctxt->wq_pfn_lo = wq_page_pfn_lo;
+
+	rq_ctxt->pref_cache =
+		RQ_CTXT_PREF_SET(WQ_PREFETCH_MIN, CACHE_MIN) |
+		RQ_CTXT_PREF_SET(WQ_PREFETCH_MAX, CACHE_MAX) |
+		RQ_CTXT_PREF_SET(WQ_PREFETCH_THRESHOLD, CACHE_THRESHOLD);
+
+	rq_ctxt->pref_ci_owner =
+		RQ_CTXT_PREF_SET(CI_HIGN_IDX(ci_start), CI_HI) |
+		RQ_CTXT_PREF_SET(1, OWNER);
+
+	rq_ctxt->pref_wq_pfn_hi_ci =
+		RQ_CTXT_PREF_SET(wq_page_pfn_hi, WQ_PFN_HI) |
+		RQ_CTXT_PREF_SET(ci_start, CI_LOW);
+
+	rq_ctxt->pref_wq_pfn_lo = wq_page_pfn_lo;
+
+	rq_ctxt->pi_paddr_hi = upper_32_bits(rq->pi_dma_addr);
+	rq_ctxt->pi_paddr_lo = lower_32_bits(rq->pi_dma_addr);
+
+	rq_ctxt->wq_block_pfn_hi =
+		RQ_CTXT_WQ_BLOCK_SET(wq_block_pfn_hi, PFN_HI);
+
+	rq_ctxt->wq_block_pfn_lo = wq_block_pfn_lo;
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);
+
+	hinic3_cpu_to_be32(rq_ctxt, sizeof(*rq_ctxt));
+}
+
+/**
+ * Allocate a command buffer, prepare context for each SQ queue by setting
+ * various parameters, send context data to hardware. It processes SQ queues in
+ * batches, with each batch not exceeding `HINIC3_Q_CTXT_MAX` SQ contexts.
+ *
+ * @param[in] nic_dev
+ * Pointer to NIC device structure.
+ *
+ * @return
+ * 0 on success, a negative error code on failure.
+ * - -ENOMEM if the memory allocation for the command buffer fails.
+ * - -EFAULT if the hardware returns an error while processing the context data.
+ */
+static int
+init_sq_ctxts(struct hinic3_nic_dev *nic_dev)
+{
+	struct hinic3_sq_ctxt_block *sq_ctxt_block = NULL;
+	struct hinic3_sq_ctxt *sq_ctxt = NULL;
+	struct hinic3_cmd_buf *cmd_buf = NULL;
+	struct hinic3_txq *sq = NULL;
+	uint64_t out_param = 0;
+	uint16_t q_id, curr_id, max_ctxts, i;
+	int err = 0;
+
+	cmd_buf = hinic3_alloc_cmd_buf(nic_dev->hwdev);
+	if (!cmd_buf) {
+		PMD_DRV_LOG(ERR, "Allocate cmd buf for sq ctx failed");
+		return -ENOMEM;
+	}
+
+	q_id = 0;
+	while (q_id < nic_dev->num_sqs) {
+		sq_ctxt_block = cmd_buf->buf;
+		sq_ctxt = sq_ctxt_block->sq_ctxt;
+
+		max_ctxts = (nic_dev->num_sqs - q_id) > HINIC3_Q_CTXT_MAX
+				    ? HINIC3_Q_CTXT_MAX
+				    : (nic_dev->num_sqs - q_id);
+
+		hinic3_qp_prepare_cmdq_header(&sq_ctxt_block->cmdq_hdr,
+					      HINIC3_QP_CTXT_TYPE_SQ,
+					      max_ctxts, q_id);
+
+		for (i = 0; i < max_ctxts; i++) {
+			curr_id = q_id + i;
+			sq = nic_dev->txqs[curr_id];
+			hinic3_sq_prepare_ctxt(sq, curr_id, &sq_ctxt[i]);
+		}
+
+		cmd_buf->size = SQ_CTXT_SIZE(max_ctxts);
+		rte_atomic_thread_fence(rte_memory_order_seq_cst);
+		err = hinic3_cmdq_direct_resp(nic_dev->hwdev, HINIC3_MOD_L2NIC,
+					      HINIC3_UCODE_CMD_MODIFY_QUEUE_CTX,
+					      cmd_buf, &out_param, 0);
+		if (err || out_param != 0) {
+			PMD_DRV_LOG(ERR,
+				    "Set SQ ctxts failed, err: %d, out_param: %" PRIu64,
+				    err, out_param);
+
+			err = -EFAULT;
+			break;
+		}
+
+		q_id += max_ctxts;
+	}
+
+	hinic3_free_cmd_buf(cmd_buf);
+	return err;
+}
+
+/**
+ * Initialize context for all RQ in device.
+ *
+ * @param[in] nic_dev
+ * Pointer to NIC device structure.
+ *
+ * @return
+ * 0 on success, a negative error code on failure.
+ * - -ENOMEM if the memory allocation for the command buffer fails.
+ * - -EFAULT if the hardware returns an error while processing the context data.
+ */
+static int
+init_rq_ctxts(struct hinic3_nic_dev *nic_dev)
+{
+	struct hinic3_rq_ctxt_block *rq_ctxt_block = NULL;
+	struct hinic3_rq_ctxt *rq_ctxt = NULL;
+	struct hinic3_cmd_buf *cmd_buf = NULL;
+	struct hinic3_rxq *rq = NULL;
+	uint64_t out_param = 0;
+	uint16_t q_id, curr_id, max_ctxts, i;
+	int err = 0;
+
+	cmd_buf = hinic3_alloc_cmd_buf(nic_dev->hwdev);
+	if (!cmd_buf) {
+		PMD_DRV_LOG(ERR, "Allocate cmd buf for rq ctx failed");
+		return -ENOMEM;
+	}
+
+	q_id = 0;
+	while (q_id < nic_dev->num_rqs) {
+		rq_ctxt_block = cmd_buf->buf;
+		rq_ctxt = rq_ctxt_block->rq_ctxt;
+
+		max_ctxts = (nic_dev->num_rqs - q_id) > HINIC3_Q_CTXT_MAX
+				    ? HINIC3_Q_CTXT_MAX
+				    : (nic_dev->num_rqs - q_id);
+
+		hinic3_qp_prepare_cmdq_header(&rq_ctxt_block->cmdq_hdr,
+					      HINIC3_QP_CTXT_TYPE_RQ,
+					      max_ctxts, q_id);
+
+		for (i = 0; i < max_ctxts; i++) {
+			curr_id = q_id + i;
+			rq = nic_dev->rxqs[curr_id];
+			hinic3_rq_prepare_ctxt(rq, &rq_ctxt[i]);
+		}
+
+		cmd_buf->size = RQ_CTXT_SIZE(max_ctxts);
+		rte_atomic_thread_fence(rte_memory_order_seq_cst);
+		err = hinic3_cmdq_direct_resp(nic_dev->hwdev, HINIC3_MOD_L2NIC,
+					      HINIC3_UCODE_CMD_MODIFY_QUEUE_CTX,
+					      cmd_buf, &out_param, 0);
+		if (err || out_param != 0) {
+			PMD_DRV_LOG(ERR,
+				    "Set RQ ctxts failed, err: %d, out_param: %" PRIu64,
+				    err, out_param);
+			err = -EFAULT;
+			break;
+		}
+
+		q_id += max_ctxts;
+	}
+
+	hinic3_free_cmd_buf(cmd_buf);
+	return err;
+}
+
+/**
+ * Allocate memory for command buffer, construct related command request, send a
+ * command to hardware to clean up queue offload context.
+ *
+ * @param[in] nic_dev
+ * Pointer to NIC device structure.
+ * @param[in] ctxt_type
+ * The type of queue context to clean.
+ * The queue context type that determines which queue type to clean up.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+clean_queue_offload_ctxt(struct hinic3_nic_dev *nic_dev,
+			 enum hinic3_qp_ctxt_type ctxt_type)
+{
+	struct hinic3_clean_queue_ctxt *ctxt_block = NULL;
+	struct hinic3_cmd_buf *cmd_buf;
+	uint64_t out_param = 0;
+	int err;
+
+	cmd_buf = hinic3_alloc_cmd_buf(nic_dev->hwdev);
+	if (!cmd_buf) {
+		PMD_DRV_LOG(ERR, "Allocate cmd buf for LRO/TSO space failed");
+		return -ENOMEM;
+	}
+
+	/* Construct related command request. */
+	ctxt_block = cmd_buf->buf;
+	/* Assumed max_rqs must be equal to max_sqs. */
+	ctxt_block->cmdq_hdr.num_queues = nic_dev->max_sqs;
+	ctxt_block->cmdq_hdr.queue_type = ctxt_type;
+	ctxt_block->cmdq_hdr.start_qid = 0;
+	/*
+	 * Add a memory barrier to ensure that instructions are not out of order
+	 * due to compilation optimization.
+	 */
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);
+
+	hinic3_cpu_to_be32(ctxt_block, sizeof(*ctxt_block));
+
+	cmd_buf->size = sizeof(*ctxt_block);
+
+	/* Send a command to hardware to clean up queue offload context. */
+	err = hinic3_cmdq_direct_resp(nic_dev->hwdev, HINIC3_MOD_L2NIC,
+				      HINIC3_UCODE_CMD_CLEAN_QUEUE_CONTEXT,
+				      cmd_buf, &out_param, 0);
+	if ((err) || (out_param)) {
+		PMD_DRV_LOG(ERR,
+			    "Clean queue offload ctxts failed, err: %d, out_param: %" PRIu64,
+			    err, out_param);
+		err = -EFAULT;
+	}
+
+	hinic3_free_cmd_buf(cmd_buf);
+	return err;
+}
+
+static int
+clean_qp_offload_ctxt(struct hinic3_nic_dev *nic_dev)
+{
+	/* Clean LRO/TSO context space. */
+	return (clean_queue_offload_ctxt(nic_dev, HINIC3_QP_CTXT_TYPE_SQ) ||
+		clean_queue_offload_ctxt(nic_dev, HINIC3_QP_CTXT_TYPE_RQ));
+}
+
+void
+hinic3_get_func_rx_buf_size(struct hinic3_nic_dev *nic_dev)
+{
+	struct hinic3_rxq *rxq = NULL;
+	uint16_t q_id;
+	uint16_t buf_size = 0;
+
+	for (q_id = 0; q_id < nic_dev->num_rqs; q_id++) {
+		rxq = nic_dev->rxqs[q_id];
+
+		if (rxq == NULL)
+			continue;
+
+		if (q_id == 0)
+			buf_size = rxq->buf_len;
+
+		buf_size = buf_size > rxq->buf_len ? rxq->buf_len : buf_size;
+	}
+
+	nic_dev->rx_buff_len = buf_size;
+}
+
+int
+hinic3_init_qp_ctxts(struct hinic3_nic_dev *nic_dev)
+{
+	struct hinic3_hwdev *hwdev = NULL;
+	struct hinic3_sq_attr sq_attr;
+	uint32_t rq_depth = 0;
+	uint32_t sq_depth = 0;
+	uint16_t q_id;
+	int err;
+
+	if (!nic_dev)
+		return -EINVAL;
+
+	hwdev = nic_dev->hwdev;
+
+	err = init_sq_ctxts(nic_dev);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Init SQ ctxts failed");
+		return err;
+	}
+
+	err = init_rq_ctxts(nic_dev);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Init RQ ctxts failed");
+		return err;
+	}
+
+	err = clean_qp_offload_ctxt(nic_dev);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Clean qp offload ctxts failed");
+		return err;
+	}
+
+	if (nic_dev->num_rqs != 0)
+		rq_depth = ((uint32_t)nic_dev->rxqs[0]->q_depth)
+			   << nic_dev->rxqs[0]->wqe_type;
+
+	if (nic_dev->num_sqs != 0)
+		sq_depth = nic_dev->txqs[0]->q_depth;
+
+	err = hinic3_set_root_ctxt(hwdev, rq_depth, sq_depth,
+				   nic_dev->rx_buff_len);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Set root context failed");
+		return err;
+	}
+
+	/* Configure CI tables for each SQ. */
+	for (q_id = 0; q_id < nic_dev->num_sqs; q_id++) {
+		sq_attr.ci_dma_base = nic_dev->txqs[q_id]->ci_dma_base >> 0x2;
+		sq_attr.pending_limit = HINIC3_DEAULT_TX_CI_PENDING_LIMIT;
+		sq_attr.coalescing_time = HINIC3_DEAULT_TX_CI_COALESCING_TIME;
+		sq_attr.intr_en = 0;
+		sq_attr.intr_idx = 0; /**< Tx doesn't need interrupt. */
+		sq_attr.l2nic_sqn = q_id;
+		sq_attr.dma_attr_off = 0;
+		err = hinic3_set_ci_table(hwdev, &sq_attr);
+		if (err) {
+			PMD_DRV_LOG(ERR, "Set ci table failed");
+			goto set_cons_idx_table_err;
+		}
+	}
+
+	return 0;
+
+set_cons_idx_table_err:
+	hinic3_clean_root_ctxt(hwdev);
+	return err;
+}
+
+void
+hinic3_free_qp_ctxts(struct hinic3_hwdev *hwdev)
+{
+	if (!hwdev)
+		return;
+
+	hinic3_clean_root_ctxt(hwdev);
+}
+
+void
+hinic3_update_driver_feature(struct hinic3_nic_dev *nic_dev, uint64_t s_feature)
+{
+	if (!nic_dev)
+		return;
+
+	nic_dev->feature_cap = s_feature;
+
+	PMD_DRV_LOG(DEBUG, "Update nic feature to 0x%" PRIx64, nic_dev->feature_cap);
+}
+
+uint64_t
+hinic3_get_driver_feature(struct hinic3_nic_dev *nic_dev)
+{
+	return nic_dev->feature_cap;
+}
diff --git a/drivers/net/hinic3/hinic3_nic_io.h b/drivers/net/hinic3/hinic3_nic_io.h
new file mode 100644
index 0000000000..db5802e4b7
--- /dev/null
+++ b/drivers/net/hinic3/hinic3_nic_io.h
@@ -0,0 +1,169 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+
+#ifndef _HINIC3_NIC_IO_H_
+#define _HINIC3_NIC_IO_H_
+
+#include "hinic3_ethdev.h"
+
+#define HINIC3_SQ_WQEBB_SHIFT 4
+#define HINIC3_RQ_WQEBB_SHIFT 3
+
+#define HINIC3_SQ_WQEBB_SIZE  RTE_BIT32(HINIC3_SQ_WQEBB_SHIFT)
+#define HINIC3_CQE_SIZE_SHIFT 4
+
+/* Ci addr should RTE_CACHE_SIZE(64B) alignment for performance. */
+#define HINIC3_CI_Q_ADDR_SIZE 64
+
+#define CI_TABLE_SIZE(num_qps, pg_sz) \
+	(RTE_ALIGN((num_qps) * HINIC3_CI_Q_ADDR_SIZE, pg_sz))
+
+#define HINIC3_CI_VADDR(base_addr, q_id) \
+	((volatile uint8_t *)(base_addr) + (q_id) * HINIC3_CI_Q_ADDR_SIZE)
+
+#define HINIC3_CI_PADDR(base_paddr, q_id) \
+	((base_paddr) + (q_id) * HINIC3_CI_Q_ADDR_SIZE)
+
+enum hinic3_rq_wqe_type {
+	HINIC3_COMPACT_RQ_WQE,
+	HINIC3_NORMAL_RQ_WQE,
+	HINIC3_EXTEND_RQ_WQE
+};
+
+enum hinic3_queue_type {
+	HINIC3_SQ,
+	HINIC3_RQ,
+	HINIC3_MAX_QUEUE_TYPE,
+};
+
+/* Doorbell info. */
+struct hinic3_db {
+	uint32_t db_info;
+	uint32_t pi_hi;
+};
+
+#define DB_INFO_QID_SHIFT	 0
+#define DB_INFO_NON_FILTER_SHIFT 22
+#define DB_INFO_CFLAG_SHIFT	 23
+#define DB_INFO_COS_SHIFT	 24
+#define DB_INFO_TYPE_SHIFT	 27
+
+#define DB_INFO_QID_MASK	0x1FFFU
+#define DB_INFO_NON_FILTER_MASK 0x1U
+#define DB_INFO_CFLAG_MASK	0x1U
+#define DB_INFO_COS_MASK	0x7U
+#define DB_INFO_TYPE_MASK	0x1FU
+#define DB_INFO_SET(val, member) \
+	(((uint32_t)(val) & DB_INFO_##member##_MASK) << DB_INFO_##member##_SHIFT)
+
+#define DB_PI_LOW_MASK	      0xFFU
+#define DB_PI_HIGH_MASK	      0xFFU
+#define DB_PI_LOW(pi)	      ((pi) & DB_PI_LOW_MASK)
+#define DB_PI_HI_SHIFT	      8
+#define DB_PI_HIGH(pi)	      (((pi) >> DB_PI_HI_SHIFT) & DB_PI_HIGH_MASK)
+#define DB_INFO_UPPER_32(val) (((uint64_t)(val)) << 32)
+
+#define DB_ADDR(db_addr, pi) ((uint64_t *)(db_addr) + DB_PI_LOW(pi))
+#define SRC_TYPE	     1
+
+/* Cflag data path. */
+#define SQ_CFLAG_DP 0
+#define RQ_CFLAG_DP 1
+
+#define MASKED_QUEUE_IDX(queue, idx) ((idx) & (queue)->q_mask)
+
+#define NIC_WQE_ADDR(queue, idx)                           \
+	({                                                 \
+		typeof(queue) __queue = (queue);           \
+		(void *)((uint64_t)(__queue->queue_buf_vaddr) + \
+			 ((idx) << __queue->wqebb_shift)); \
+	})
+
+/**
+ * Write send queue doorbell.
+ *
+ * @param[in] db_addr
+ * Doorbell address.
+ * @param[in] q_id
+ * Send queue id.
+ * @param[in] cos
+ * Send queue cos.
+ * @param[in] cflag
+ * Cflag data path.
+ * @param[in] pi
+ * Send queue pi.
+ */
+static inline void
+hinic3_write_db(void *db_addr, uint16_t q_id, int cos, uint8_t cflag, uint16_t pi)
+{
+	uint64_t db = DB_PI_HIGH(pi);
+
+	db = DB_INFO_UPPER_32(db) | DB_INFO_SET(SRC_TYPE, TYPE) |
+	     DB_INFO_SET(cflag, CFLAG) | DB_INFO_SET(cos, COS) |
+	     DB_INFO_SET(q_id, QID);
+
+	rte_atomic_thread_fence(rte_memory_order_release); /**< Write all before the doorbell. */
+	/* Hardware will do endianness converting. */
+	rte_write64(db, DB_ADDR(db_addr, pi));
+}
+
+/**
+ * Get minimum RX buffer size for device.
+ *
+ * @param[in] nic_dev
+ * Pointer to ethernet device structure.
+ */
+void hinic3_get_func_rx_buf_size(struct hinic3_nic_dev *nic_dev);
+
+/**
+ * Initialize qps contexts, set SQ ci attributes, arm all SQ.
+ *
+ * Function will perform following steps:
+ * - Initialize SQ contexts.
+ * - Initialize RQ contexts.
+ * - Clean QP offload contexts of SQ and RQ.
+ * - Set root context for device.
+ * - Configure CI tables for each SQ.
+ *
+ * @param[in] nic_dev
+ * Pointer to ethernet device structure.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int hinic3_init_qp_ctxts(struct hinic3_nic_dev *nic_dev);
+
+/**
+ * Free queue pair context.
+ *
+ * @param[in] hwdev
+ * Pointer to hardware device structure.
+ */
+void hinic3_free_qp_ctxts(struct hinic3_hwdev *hwdev);
+
+/**
+ * Update driver feature capabilities.
+ *
+ * @param[in] nic_dev
+ * Pointer to ethernet device structure.
+ * @param[out] s_feature
+ * s_feature driver supported.
+ *
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+void hinic3_update_driver_feature(struct hinic3_nic_dev *nic_dev, uint64_t s_feature);
+
+/**
+ * Get driver feature capabilities.
+ *
+ * @param[in] nic_dev
+ * Pointer to ethernet device structure.
+ *
+ * @return
+ * Feature capabilities of driver.
+ */
+uint64_t hinic3_get_driver_feature(struct hinic3_nic_dev *nic_dev);
+
+#endif /* _HINIC3_NIC_IO_H_ */
diff --git a/drivers/net/hinic3/hinic3_rx.c b/drivers/net/hinic3/hinic3_rx.c
new file mode 100644
index 0000000000..ea85038b55
--- /dev/null
+++ b/drivers/net/hinic3/hinic3_rx.c
@@ -0,0 +1,772 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+
+#include "base/hinic3_compat.h"
+#include "base/hinic3_hwif.h"
+#include "base/hinic3_hwdev.h"
+#include "base/hinic3_wq.h"
+#include "base/hinic3_nic_cfg.h"
+#include "hinic3_nic_io.h"
+#include "hinic3_ethdev.h"
+#include "hinic3_rx.h"
+
+/**
+ * Get wqe from receive queue.
+ *
+ * @param[in] rxq
+ * Receive queue.
+ * @param[out] rq_wqe
+ * Receive queue wqe.
+ * @param[out] pi
+ * Current pi.
+ */
+static inline void
+hinic3_get_rq_wqe(struct hinic3_rxq *rxq, struct hinic3_rq_wqe **rq_wqe,
+		  uint16_t *pi)
+{
+	*pi = MASKED_QUEUE_IDX(rxq, rxq->prod_idx);
+
+	/* Get only one rxq wqe. */
+	rxq->prod_idx++;
+	rxq->delta--;
+
+	*rq_wqe = NIC_WQE_ADDR(rxq, *pi);
+}
+
+/**
+ * Put wqe into receive queue.
+ *
+ * @param[in] rxq
+ * Receive queue.
+ * @param[in] wqe_cnt
+ * Wqebb counters.
+ */
+static inline void
+hinic3_put_rq_wqe(struct hinic3_rxq *rxq, uint16_t wqe_cnt)
+{
+	rxq->delta += wqe_cnt;
+	rxq->prod_idx -= wqe_cnt;
+}
+
+/**
+ * Get receive queue local pi.
+ *
+ * @param[in] rxq
+ * Receive queue.
+ * @return
+ * Receive queue local pi.
+ */
+static inline uint16_t
+hinic3_get_rq_local_pi(struct hinic3_rxq *rxq)
+{
+	return MASKED_QUEUE_IDX(rxq, rxq->prod_idx);
+}
+
+uint16_t
+hinic3_rx_fill_wqe(struct hinic3_rxq *rxq)
+{
+	struct hinic3_rq_wqe *rq_wqe = NULL;
+	struct hinic3_nic_dev *nic_dev = rxq->nic_dev;
+	rte_iova_t cqe_dma;
+	uint16_t pi = 0;
+	uint16_t i;
+
+	cqe_dma = rxq->cqe_start_paddr;
+	for (i = 0; i < rxq->q_depth; i++) {
+		hinic3_get_rq_wqe(rxq, &rq_wqe, &pi);
+		if (!rq_wqe) {
+			PMD_DRV_LOG(ERR,
+				    "Get rq wqe failed, rxq id: %d, wqe id: %d",
+				    rxq->q_id, i);
+			break;
+		}
+
+		if (rxq->wqe_type == HINIC3_EXTEND_RQ_WQE) {
+			/* Unit of cqe length is 16B. */
+			hinic3_set_sge(&rq_wqe->extend_wqe.cqe_sect.sge,
+				       cqe_dma,
+				       HINIC3_CQE_LEN >> HINIC3_CQE_SIZE_SHIFT);
+			/* Use fixed len. */
+			rq_wqe->extend_wqe.buf_desc.sge.len = nic_dev->rx_buff_len;
+		} else {
+			rq_wqe->normal_wqe.cqe_hi_addr = upper_32_bits(cqe_dma);
+			rq_wqe->normal_wqe.cqe_lo_addr = lower_32_bits(cqe_dma);
+		}
+
+		cqe_dma += sizeof(struct hinic3_rq_cqe);
+
+		hinic3_cpu_to_hw(rq_wqe, rxq->wqebb_size);
+	}
+
+	hinic3_put_rq_wqe(rxq, i);
+
+	return i;
+}
+
+static struct rte_mbuf *
+hinic3_rx_alloc_mbuf(struct hinic3_rxq *rxq, rte_iova_t *dma_addr)
+{
+	struct rte_mbuf *mbuf = NULL;
+
+	if (unlikely(rte_pktmbuf_alloc_bulk(rxq->mb_pool, &mbuf, 1) != 0))
+		return NULL;
+
+	*dma_addr = rte_mbuf_data_iova_default(mbuf);
+#ifdef HINIC3_XSTAT_MBUF_USE
+	rxq->rxq_stats.rx_alloc_mbuf_bytes++;
+#endif
+	return mbuf;
+}
+
+#ifdef HINIC3_XSTAT_RXBUF_INFO
+static void
+hinic3_rxq_buffer_done_count(struct hinic3_rxq *rxq)
+{
+	uint16_t sw_ci, avail_pkts = 0, hit_done = 0, cqe_hole = 0;
+	RTE_ATOMIC(uint32_t)status;
+	volatile struct hinic3_rq_cqe *rx_cqe;
+
+	for (sw_ci = 0; sw_ci < rxq->q_depth; sw_ci++) {
+		rx_cqe = &rxq->rx_cqe[sw_ci];
+
+		/* Check current ci is done. */
+		status = rx_cqe->status;
+		if (!HINIC3_GET_RX_DONE(status)) {
+			if (hit_done) {
+				cqe_hole++;
+				hit_done = 0;
+			}
+			continue;
+		}
+
+		avail_pkts++;
+		hit_done = 1;
+	}
+
+	rxq->rxq_stats.rx_avail = avail_pkts;
+	rxq->rxq_stats.rx_hole = cqe_hole;
+}
+
+void
+hinic3_get_stats(struct hinic3_rxq *rxq)
+{
+	rxq->rxq_stats.rx_mbuf = rxq->q_depth - hinic3_get_rq_free_wqebb(rxq);
+
+	hinic3_rxq_buffer_done_count(rxq);
+}
+#endif
+
+uint16_t
+hinic3_rx_fill_buffers(struct hinic3_rxq *rxq)
+{
+	struct hinic3_rq_wqe *rq_wqe = NULL;
+	struct hinic3_rx_info *rx_info = NULL;
+	struct rte_mbuf *mb = NULL;
+	rte_iova_t dma_addr;
+	uint16_t i, free_wqebbs;
+
+	free_wqebbs = rxq->delta - 1;
+	for (i = 0; i < free_wqebbs; i++) {
+		rx_info = &rxq->rx_info[rxq->next_to_update];
+
+		mb = hinic3_rx_alloc_mbuf(rxq, &dma_addr);
+		if (!mb) {
+			PMD_DRV_LOG(ERR, "Alloc mbuf failed");
+			break;
+		}
+
+		rx_info->mbuf = mb;
+
+		rq_wqe = NIC_WQE_ADDR(rxq, rxq->next_to_update);
+
+		/* Fill buffer address only. */
+		if (rxq->wqe_type == HINIC3_EXTEND_RQ_WQE) {
+			rq_wqe->extend_wqe.buf_desc.sge.hi_addr =
+				hinic3_hw_be32(upper_32_bits(dma_addr));
+			rq_wqe->extend_wqe.buf_desc.sge.lo_addr =
+				hinic3_hw_be32(lower_32_bits(dma_addr));
+		} else {
+			rq_wqe->normal_wqe.buf_hi_addr =
+				hinic3_hw_be32(upper_32_bits(dma_addr));
+			rq_wqe->normal_wqe.buf_lo_addr =
+				hinic3_hw_be32(lower_32_bits(dma_addr));
+		}
+
+		rxq->next_to_update = (rxq->next_to_update + 1) & rxq->q_mask;
+	}
+
+	if (likely(i > 0)) {
+		hinic3_write_db(rxq->db_addr, rxq->q_id, 0, RQ_CFLAG_DP,
+				(rxq->next_to_update << rxq->wqe_type));
+		/* Init rxq contxet used, need to optimization. */
+		rxq->prod_idx = rxq->next_to_update;
+		rxq->delta -= i;
+	} else {
+		PMD_DRV_LOG(ERR, "Alloc rx buffers failed, rxq_id: %d", rxq->q_id);
+	}
+
+	return i;
+}
+
+void
+hinic3_free_rxq_mbufs(struct hinic3_rxq *rxq)
+{
+	struct hinic3_rx_info *rx_info = NULL;
+	int free_wqebbs = hinic3_get_rq_free_wqebb(rxq) + 1;
+	volatile struct hinic3_rq_cqe *rx_cqe = NULL;
+	uint16_t ci;
+
+	while (free_wqebbs++ < rxq->q_depth) {
+		ci = hinic3_get_rq_local_ci(rxq);
+
+		rx_cqe = &rxq->rx_cqe[ci];
+
+		/* Clear done bit. */
+		rx_cqe->status = 0;
+
+		rx_info = &rxq->rx_info[ci];
+		rte_pktmbuf_free(rx_info->mbuf);
+		rx_info->mbuf = NULL;
+
+		hinic3_update_rq_local_ci(rxq, 1);
+#ifdef HINIC3_XSTAT_MBUF_USE
+		rxq->rxq_stats.rx_free_mbuf_bytes++;
+#endif
+	}
+}
+
+void
+hinic3_free_all_rxq_mbufs(struct hinic3_nic_dev *nic_dev)
+{
+	uint16_t qid;
+
+	for (qid = 0; qid < nic_dev->num_rqs; qid++)
+		hinic3_free_rxq_mbufs(nic_dev->rxqs[qid]);
+}
+
+static uint32_t
+hinic3_rx_alloc_mbuf_bulk(struct hinic3_rxq *rxq, struct rte_mbuf **mbufs,
+			  uint32_t exp_mbuf_cnt)
+{
+	uint32_t avail_cnt;
+	int err;
+
+	err = rte_pktmbuf_alloc_bulk(rxq->mb_pool, mbufs, exp_mbuf_cnt);
+	if (likely(err == 0)) {
+		avail_cnt = exp_mbuf_cnt;
+	} else {
+		avail_cnt = 0;
+		rxq->rxq_stats.rx_nombuf += exp_mbuf_cnt;
+	}
+#ifdef HINIC3_XSTAT_MBUF_USE
+	rxq->rxq_stats.rx_alloc_mbuf_bytes += avail_cnt;
+#endif
+	return avail_cnt;
+}
+
+static int
+hinic3_rearm_rxq_mbuf(struct hinic3_rxq *rxq)
+{
+	struct hinic3_rq_wqe *rq_wqe = NULL;
+	struct rte_mbuf **rearm_mbufs;
+	uint32_t i, free_wqebbs, rearm_wqebbs, exp_wqebbs;
+	rte_iova_t dma_addr;
+	uint16_t pi;
+	struct hinic3_nic_dev *nic_dev = rxq->nic_dev;
+
+	/* Check free wqebb cnt fo rearm. */
+	free_wqebbs = hinic3_get_rq_free_wqebb(rxq);
+	if (unlikely(free_wqebbs < rxq->rx_free_thresh))
+		return -ENOMEM;
+
+	/* Get rearm mbuf array. */
+	pi = hinic3_get_rq_local_pi(rxq);
+	rearm_mbufs = (struct rte_mbuf **)(&rxq->rx_info[pi]);
+
+	/* Check rxq free wqebbs turn around. */
+	exp_wqebbs = rxq->q_depth - pi;
+	if (free_wqebbs < exp_wqebbs)
+		exp_wqebbs = free_wqebbs;
+
+	/* Alloc mbuf in bulk. */
+	rearm_wqebbs = hinic3_rx_alloc_mbuf_bulk(rxq, rearm_mbufs, exp_wqebbs);
+	if (unlikely(rearm_wqebbs == 0))
+		return -ENOMEM;
+
+	/* Rearm rxq mbuf. */
+	rq_wqe = NIC_WQE_ADDR(rxq, pi);
+	for (i = 0; i < rearm_wqebbs; i++) {
+		dma_addr = rte_mbuf_data_iova_default(rearm_mbufs[i]);
+
+		/* Fill buffer address only. */
+		if (rxq->wqe_type == HINIC3_EXTEND_RQ_WQE) {
+			rq_wqe->extend_wqe.buf_desc.sge.hi_addr =
+				hinic3_hw_be32(upper_32_bits(dma_addr));
+			rq_wqe->extend_wqe.buf_desc.sge.lo_addr =
+				hinic3_hw_be32(lower_32_bits(dma_addr));
+			rq_wqe->extend_wqe.buf_desc.sge.len =
+				nic_dev->rx_buff_len;
+		} else {
+			rq_wqe->normal_wqe.buf_hi_addr =
+				hinic3_hw_be32(upper_32_bits(dma_addr));
+			rq_wqe->normal_wqe.buf_lo_addr =
+				hinic3_hw_be32(lower_32_bits(dma_addr));
+		}
+
+		rq_wqe =
+			(struct hinic3_rq_wqe *)((uint64_t)rq_wqe + rxq->wqebb_size);
+	}
+	rxq->prod_idx += rearm_wqebbs;
+	rxq->delta -= rearm_wqebbs;
+
+	hinic3_write_db(rxq->db_addr, rxq->q_id, 0, RQ_CFLAG_DP,
+			((pi + rearm_wqebbs) & rxq->q_mask) << rxq->wqe_type);
+	return 0;
+}
+
+static int
+hinic3_init_rss_key(struct hinic3_nic_dev *nic_dev,
+		    struct rte_eth_rss_conf *rss_conf)
+{
+	uint8_t default_rss_key[HINIC3_RSS_KEY_SIZE] = {
+			 0x6d, 0x5a, 0x56, 0xda, 0x25, 0x5b, 0x0e, 0xc2,
+			 0x41, 0x67, 0x25, 0x3d, 0x43, 0xa3, 0x8f, 0xb0,
+			 0xd0, 0xca, 0x2b, 0xcb, 0xae, 0x7b, 0x30, 0xb4,
+			 0x77, 0xcb, 0x2d, 0xa3, 0x80, 0x30, 0xf2, 0x0c,
+			 0x6a, 0x42, 0xb7, 0x3b, 0xbe, 0xac, 0x01, 0xfa};
+	uint8_t hashkey[HINIC3_RSS_KEY_SIZE] = {0};
+	int err;
+
+	if (rss_conf->rss_key == NULL ||
+	    rss_conf->rss_key_len > HINIC3_RSS_KEY_SIZE)
+		memcpy(hashkey, default_rss_key, HINIC3_RSS_KEY_SIZE);
+	else
+		memcpy(hashkey, rss_conf->rss_key, rss_conf->rss_key_len);
+
+	err = hinic3_rss_set_hash_key(nic_dev->hwdev, hashkey, HINIC3_RSS_KEY_SIZE);
+	if (err)
+		return err;
+
+	memcpy(nic_dev->rss_key, hashkey, HINIC3_RSS_KEY_SIZE);
+	return 0;
+}
+
+void
+hinic3_add_rq_to_rx_queue_list(struct hinic3_nic_dev *nic_dev, uint16_t queue_id)
+{
+	uint8_t rss_queue_count = nic_dev->num_rss;
+
+	RTE_ASSERT(rss_queue_count <= (RTE_DIM(nic_dev->rx_queue_list) - 1));
+
+	nic_dev->rx_queue_list[rss_queue_count] = (uint8_t)queue_id;
+	nic_dev->num_rss++;
+}
+
+void
+hinic3_init_rx_queue_list(struct hinic3_nic_dev *nic_dev)
+{
+	nic_dev->num_rss = 0;
+}
+
+static void
+hinic3_fill_indir_tbl(struct hinic3_nic_dev *nic_dev, uint32_t *indir_tbl)
+{
+	uint8_t rss_queue_count = nic_dev->num_rss;
+	int i = 0;
+	int j;
+
+	if (rss_queue_count == 0) {
+		/* Delete q_id from indir tbl. */
+		for (i = 0; i < HINIC3_RSS_INDIR_SIZE; i++)
+			/* Invalid value in indir tbl. */
+			indir_tbl[i] = 0xFFFF;
+	} else {
+		while (i < HINIC3_RSS_INDIR_SIZE)
+			for (j = 0; (j < rss_queue_count) &&
+				    (i < HINIC3_RSS_INDIR_SIZE); j++)
+				indir_tbl[i++] = nic_dev->rx_queue_list[j];
+	}
+}
+
+int
+hinic3_refill_indir_rqid(struct hinic3_rxq *rxq)
+{
+	struct hinic3_nic_dev *nic_dev = rxq->nic_dev;
+	uint32_t *indir_tbl;
+	int err;
+
+	indir_tbl = rte_zmalloc(NULL, HINIC3_RSS_INDIR_SIZE * sizeof(uint32_t), 0);
+	if (!indir_tbl) {
+		PMD_DRV_LOG(ERR,
+			    "Alloc indir_tbl mem failed, eth_dev:%s, queue_idx:%d",
+			    nic_dev->dev_name, rxq->q_id);
+		return -ENOMEM;
+	}
+
+	/* Build indir tbl according to the number of rss queue. */
+	hinic3_fill_indir_tbl(nic_dev, indir_tbl);
+
+	err = hinic3_rss_set_indir_tbl(nic_dev->hwdev, indir_tbl,
+				       HINIC3_RSS_INDIR_SIZE);
+	if (err) {
+		PMD_DRV_LOG(ERR,
+			"Set indirect table failed, eth_dev:%s, queue_idx:%d",
+			nic_dev->dev_name, rxq->q_id);
+		goto out;
+	}
+
+out:
+	rte_free(indir_tbl);
+	return err;
+}
+
+static int
+hinic3_init_rss_type(struct hinic3_nic_dev *nic_dev,
+		     struct rte_eth_rss_conf *rss_conf)
+{
+	struct hinic3_rss_type rss_type = {0};
+	uint64_t rss_hf = rss_conf->rss_hf;
+	int err;
+
+	rss_type.ipv4 = (rss_hf & (RTE_ETH_RSS_IPV4 | RTE_ETH_RSS_FRAG_IPV4)) ? 1 : 0;
+	rss_type.tcp_ipv4 = (rss_hf & RTE_ETH_RSS_NONFRAG_IPV4_TCP) ? 1 : 0;
+	rss_type.ipv6 = (rss_hf & (RTE_ETH_RSS_IPV6 | RTE_ETH_RSS_FRAG_IPV6)) ? 1 : 0;
+	rss_type.ipv6_ext = (rss_hf & RTE_ETH_RSS_IPV6_EX) ? 1 : 0;
+	rss_type.tcp_ipv6 = (rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_TCP) ? 1 : 0;
+	rss_type.tcp_ipv6_ext = (rss_hf & RTE_ETH_RSS_IPV6_TCP_EX) ? 1 : 0;
+	rss_type.udp_ipv4 = (rss_hf & RTE_ETH_RSS_NONFRAG_IPV4_UDP) ? 1 : 0;
+	rss_type.udp_ipv6 = (rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_UDP) ? 1 : 0;
+
+	err = hinic3_set_rss_type(nic_dev->hwdev, rss_type);
+	return err;
+}
+
+int
+hinic3_update_rss_config(struct rte_eth_dev *dev,
+			 struct rte_eth_rss_conf *rss_conf)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	uint8_t prio_tc[HINIC3_DCB_UP_MAX] = {0};
+	uint8_t num_tc = 0;
+	int err;
+
+	if (rss_conf->rss_hf == 0) {
+		rss_conf->rss_hf = HINIC3_RSS_OFFLOAD_ALL;
+	} else if ((rss_conf->rss_hf & HINIC3_RSS_OFFLOAD_ALL) == 0) {
+		PMD_DRV_LOG(ERR, "Doesn't support rss hash type: %" PRIu64,
+			    rss_conf->rss_hf);
+		return -EINVAL;
+	}
+
+	err = hinic3_rss_template_alloc(nic_dev->hwdev);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Alloc rss template failed, err: %d", err);
+		return err;
+	}
+
+	err = hinic3_init_rss_key(nic_dev, rss_conf);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Init rss hash key failed, err: %d", err);
+		goto init_rss_fail;
+	}
+
+	err = hinic3_init_rss_type(nic_dev, rss_conf);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Init rss hash type failed, err: %d", err);
+		goto init_rss_fail;
+	}
+
+	err = hinic3_rss_set_hash_engine(nic_dev->hwdev,
+					 HINIC3_RSS_HASH_ENGINE_TYPE_TOEP);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Init rss hash function failed, err: %d", err);
+		goto init_rss_fail;
+	}
+
+	err = hinic3_rss_cfg(nic_dev->hwdev, HINIC3_RSS_ENABLE, num_tc,
+			     prio_tc);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Enable rss failed, err: %d", err);
+		goto init_rss_fail;
+	}
+
+	nic_dev->rss_state = HINIC3_RSS_ENABLE;
+	return 0;
+
+init_rss_fail:
+	if (hinic3_rss_template_free(nic_dev->hwdev))
+		PMD_DRV_LOG(WARNING, "Free rss template failed");
+
+	return err;
+}
+
+/**
+ * Search given queue array to find position of given id.
+ * Return queue pos or queue_count if not found.
+ */
+static uint8_t
+hinic3_find_queue_pos_by_rq_id(uint8_t *queues, uint8_t queues_count, uint8_t queue_id)
+{
+	uint8_t pos;
+
+	for (pos = 0; pos < queues_count; pos++) {
+		if (queue_id == queues[pos])
+			break;
+	}
+
+	return pos;
+}
+
+void
+hinic3_remove_rq_from_rx_queue_list(struct hinic3_nic_dev *nic_dev,
+				    uint16_t queue_id)
+{
+	uint8_t queue_pos;
+	uint8_t rss_queue_count = nic_dev->num_rss;
+
+	queue_pos = hinic3_find_queue_pos_by_rq_id(nic_dev->rx_queue_list,
+						   rss_queue_count, queue_id);
+	/*
+	 * If queue was not at the end of the list,
+	 * shift started queues up queue array list.
+	 */
+	if (queue_pos < rss_queue_count) {
+		rss_queue_count--;
+		memmove(nic_dev->rx_queue_list + queue_pos,
+			nic_dev->rx_queue_list + queue_pos + 1,
+			(rss_queue_count - queue_pos) *
+				sizeof(nic_dev->rx_queue_list[0]));
+	}
+
+	RTE_ASSERT(rss_queue_count < RTE_DIM(nic_dev->rx_queue_list));
+	nic_dev->num_rss = rss_queue_count;
+}
+
+static void
+hinic3_rx_queue_release_mbufs(struct hinic3_rxq *rxq)
+{
+	uint16_t sw_ci, ci_mask, free_wqebbs;
+	uint16_t rx_buf_len;
+	uint32_t vlan_len, pkt_len;
+	RTE_ATOMIC(uint32_t)status;
+	uint32_t pkt_left_len = 0;
+	uint32_t nr_released = 0;
+	struct hinic3_rx_info *rx_info;
+	volatile struct hinic3_rq_cqe *rx_cqe;
+
+	sw_ci = hinic3_get_rq_local_ci(rxq);
+	rx_info = &rxq->rx_info[sw_ci];
+	rx_cqe = &rxq->rx_cqe[sw_ci];
+	free_wqebbs = hinic3_get_rq_free_wqebb(rxq) + 1;
+	status = rx_cqe->status;
+	ci_mask = rxq->q_mask;
+
+	while (free_wqebbs < rxq->q_depth) {
+		rx_buf_len = rxq->buf_len;
+		if (pkt_left_len != 0) {
+			/* Flush continues jumbo rqe. */
+			pkt_left_len = (pkt_left_len <= rx_buf_len)
+					       ? 0 : (pkt_left_len - rx_buf_len);
+		} else if (HINIC3_GET_RX_FLUSH(status)) {
+			/* Flush one released rqe. */
+			pkt_left_len = 0;
+		} else if (HINIC3_GET_RX_DONE(status)) {
+			/* Flush single packet or first jumbo rqe. */
+			vlan_len = hinic3_hw_cpu32(rx_cqe->vlan_len);
+			pkt_len = HINIC3_GET_RX_PKT_LEN(vlan_len);
+			pkt_left_len = (pkt_len <= rx_buf_len)
+					       ? 0 : (pkt_len - rx_buf_len);
+		} else {
+			break;
+		}
+		rte_pktmbuf_free(rx_info->mbuf);
+
+		rx_info->mbuf = NULL;
+		rx_cqe->status = 0;
+		nr_released++;
+		free_wqebbs++;
+
+		/* Update ci to next cqe. */
+		sw_ci++;
+		sw_ci &= ci_mask;
+		rx_info = &rxq->rx_info[sw_ci];
+		rx_cqe = &rxq->rx_cqe[sw_ci];
+		status = rx_cqe->status;
+	}
+
+	hinic3_update_rq_local_ci(rxq, nr_released);
+}
+
+int
+hinic3_poll_rq_empty(struct hinic3_rxq *rxq)
+{
+	uint64_t end;
+	int free_wqebb;
+	int err = -EFAULT;
+
+	end = msecs_to_cycles(HINIC3_FLUSH_QUEUE_TIMEOUT) + cycles;
+	do {
+		free_wqebb = hinic3_get_rq_free_wqebb(rxq) + 1;
+		if (free_wqebb == rxq->q_depth) {
+			err = 0;
+			break;
+		}
+		hinic3_rx_queue_release_mbufs(rxq);
+		rte_delay_us(1);
+	} while (time_before(cycles, end));
+
+	return err;
+}
+
+void
+hinic3_dump_cqe_status(struct hinic3_rxq *rxq, uint32_t *cqe_done_cnt,
+		       uint32_t *cqe_hole_cnt, uint32_t *head_ci, uint32_t *head_done)
+{
+	uint16_t sw_ci;
+	uint16_t avail_pkts = 0;
+	uint16_t hit_done = 0;
+	uint16_t cqe_hole = 0;
+	RTE_ATOMIC(uint32_t)status;
+	volatile struct hinic3_rq_cqe *rx_cqe;
+
+	sw_ci = hinic3_get_rq_local_ci(rxq);
+	rx_cqe = &rxq->rx_cqe[sw_ci];
+	status = rx_cqe->status;
+	*head_done = HINIC3_GET_RX_DONE(status);
+	*head_ci = sw_ci;
+
+	for (sw_ci = 0; sw_ci < rxq->q_depth; sw_ci++) {
+		rx_cqe = &rxq->rx_cqe[sw_ci];
+
+		/* Check current ci is done. */
+		status = rx_cqe->status;
+		if (!HINIC3_GET_RX_DONE(status) ||
+		    !HINIC3_GET_RX_FLUSH(status)) {
+			if (hit_done) {
+				cqe_hole++;
+				hit_done = 0;
+			}
+
+			continue;
+		}
+
+		avail_pkts++;
+		hit_done = 1;
+	}
+
+	*cqe_done_cnt = avail_pkts;
+	*cqe_hole_cnt = cqe_hole;
+}
+
+int
+hinic3_stop_rq(struct rte_eth_dev *eth_dev, struct hinic3_rxq *rxq)
+{
+	struct hinic3_nic_dev *nic_dev = rxq->nic_dev;
+	uint32_t cqe_done_cnt = 0;
+	uint32_t cqe_hole_cnt = 0;
+	uint32_t head_ci, head_done;
+	int err;
+
+	/* Disable rxq intr. */
+	hinic3_dev_rx_queue_intr_disable(eth_dev, rxq->q_id);
+
+	/* Lock dev queue switch. */
+	rte_spinlock_lock(&nic_dev->queue_list_lock);
+
+	if (nic_dev->num_rss == 1) {
+		err = hinic3_set_vport_enable(nic_dev->hwdev, false);
+		if (err) {
+			PMD_DRV_LOG(ERR, "%s Disable vport failed, rc:%d",
+				    nic_dev->dev_name, err);
+		}
+	}
+	hinic3_remove_rq_from_rx_queue_list(nic_dev, rxq->q_id);
+
+	/*
+	 * If RSS is enable, remove q_id from rss indir table.
+	 * If RSS is disable, no mbuf in rq, packet will be dropped.
+	 */
+	if (nic_dev->rss_state == HINIC3_RSS_ENABLE) {
+		err = hinic3_refill_indir_rqid(rxq);
+		if (err) {
+			PMD_DRV_LOG(ERR,
+				    "Clear rq in indirect table failed, eth_dev:%s, queue_idx:%d",
+				    nic_dev->dev_name, rxq->q_id);
+			hinic3_add_rq_to_rx_queue_list(nic_dev, rxq->q_id);
+			goto set_indir_failed;
+		}
+	}
+
+	/* Unlock dev queue list switch. */
+	rte_spinlock_unlock(&nic_dev->queue_list_lock);
+
+	/* Send flush rxq cmd to device. */
+	err = hinic3_set_rq_flush(nic_dev->hwdev, rxq->q_id);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Flush rq failed, eth_dev:%s, queue_idx:%d",
+			    nic_dev->dev_name, rxq->q_id);
+		goto rq_flush_failed;
+	}
+
+	err = hinic3_poll_rq_empty(rxq);
+	if (err) {
+		hinic3_dump_cqe_status(rxq, &cqe_done_cnt, &cqe_hole_cnt,
+				       &head_ci, &head_done);
+		PMD_DRV_LOG(ERR, "Poll rq empty timeout");
+		PMD_DRV_LOG(ERR,
+			    "eth_dev:%s, queue_idx:%d, mbuf_left:%d, cqe_done:%d, cqe_hole:%d, cqe[%d].done=%d",
+			    nic_dev->dev_name, rxq->q_id,
+			    rxq->q_depth - hinic3_get_rq_free_wqebb(rxq),
+			    cqe_done_cnt, cqe_hole_cnt, head_ci, head_done);
+		goto poll_rq_failed;
+	}
+
+	return 0;
+
+poll_rq_failed:
+rq_flush_failed:
+	rte_spinlock_lock(&nic_dev->queue_list_lock);
+set_indir_failed:
+	hinic3_add_rq_to_rx_queue_list(nic_dev, rxq->q_id);
+	if (nic_dev->rss_state == HINIC3_RSS_ENABLE)
+		hinic3_refill_indir_rqid(rxq);
+	rte_spinlock_unlock(&nic_dev->queue_list_lock);
+	hinic3_dev_rx_queue_intr_enable(eth_dev, rxq->q_id);
+	return err;
+}
+
+int
+hinic3_start_rq(struct rte_eth_dev *eth_dev, struct hinic3_rxq *rxq)
+{
+	struct hinic3_nic_dev *nic_dev = rxq->nic_dev;
+	int err = 0;
+
+	/* Lock dev queue switch.  */
+	rte_spinlock_lock(&nic_dev->queue_list_lock);
+	hinic3_add_rq_to_rx_queue_list(nic_dev, rxq->q_id);
+
+	if (nic_dev->rss_state == HINIC3_RSS_ENABLE) {
+		err = hinic3_refill_indir_rqid(rxq);
+		if (err) {
+			PMD_DRV_LOG(ERR,
+				    "Refill rq to indirect table failed, eth_dev:%s, queue_idx:%d err:%d",
+				    nic_dev->dev_name, rxq->q_id, err);
+			hinic3_remove_rq_from_rx_queue_list(nic_dev, rxq->q_id);
+		}
+	}
+	hinic3_rearm_rxq_mbuf(rxq);
+	if (rxq->nic_dev->num_rss == 1) {
+		err = hinic3_set_vport_enable(nic_dev->hwdev, true);
+		if (err)
+			PMD_DRV_LOG(ERR, "%s enable vport failed, err:%d",
+				    nic_dev->dev_name, err);
+	}
+
+	/* Unlock dev queue list switch. */
+	rte_spinlock_unlock(&nic_dev->queue_list_lock);
+
+	hinic3_dev_rx_queue_intr_enable(eth_dev, rxq->q_id);
+
+	return err;
+}
diff --git a/drivers/net/hinic3/hinic3_rx.h b/drivers/net/hinic3/hinic3_rx.h
new file mode 100644
index 0000000000..1a92df59b7
--- /dev/null
+++ b/drivers/net/hinic3/hinic3_rx.h
@@ -0,0 +1,354 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+
+#ifndef _HINIC3_RX_H_
+#define _HINIC3_RX_H_
+
+#define RQ_CQE_OFFOLAD_TYPE_PKT_TYPE_SHIFT    0
+#define RQ_CQE_OFFOLAD_TYPE_PKT_UMBCAST_SHIFT 19
+#define RQ_CQE_OFFOLAD_TYPE_VLAN_EN_SHIFT     21
+#define RQ_CQE_OFFOLAD_TYPE_RSS_TYPE_SHIFT    24
+
+#define RQ_CQE_OFFOLAD_TYPE_PKT_TYPE_MASK    0xFFFU
+#define RQ_CQE_OFFOLAD_TYPE_PKT_UMBCAST_MASK 0x3U
+#define RQ_CQE_OFFOLAD_TYPE_VLAN_EN_MASK     0x1U
+#define RQ_CQE_OFFOLAD_TYPE_RSS_TYPE_MASK    0xFFU
+
+#define DPI_EXT_ACTION_FILED (1ULL << 32)
+
+#define RQ_CQE_OFFOLAD_TYPE_GET(val, member)               \
+	(((val) >> RQ_CQE_OFFOLAD_TYPE_##member##_SHIFT) & \
+	 RQ_CQE_OFFOLAD_TYPE_##member##_MASK)
+
+#define HINIC3_GET_RX_PKT_TYPE(offload_type) \
+	RQ_CQE_OFFOLAD_TYPE_GET(offload_type, PKT_TYPE)
+
+#define HINIC3_GET_RX_PKT_UMBCAST(offload_type) \
+	RQ_CQE_OFFOLAD_TYPE_GET(offload_type, PKT_UMBCAST)
+
+#define HINIC3_GET_RX_VLAN_OFFLOAD_EN(offload_type) \
+	RQ_CQE_OFFOLAD_TYPE_GET(offload_type, VLAN_EN)
+
+#define HINIC3_GET_RSS_TYPES(offload_type) \
+	RQ_CQE_OFFOLAD_TYPE_GET(offload_type, RSS_TYPE)
+
+#define RQ_CQE_SGE_VLAN_SHIFT 0
+#define RQ_CQE_SGE_LEN_SHIFT  16
+
+#define RQ_CQE_SGE_VLAN_MASK 0xFFFFU
+#define RQ_CQE_SGE_LEN_MASK  0xFFFFU
+
+#define RQ_CQE_SGE_GET(val, member) \
+	(((val) >> RQ_CQE_SGE_##member##_SHIFT) & RQ_CQE_SGE_##member##_MASK)
+
+#define HINIC3_GET_RX_VLAN_TAG(vlan_len) RQ_CQE_SGE_GET(vlan_len, VLAN)
+
+#define HINIC3_GET_RX_PKT_LEN(vlan_len) RQ_CQE_SGE_GET(vlan_len, LEN)
+
+#define RQ_CQE_STATUS_CSUM_ERR_SHIFT  0
+#define RQ_CQE_STATUS_NUM_LRO_SHIFT   16
+#define RQ_CQE_STATUS_LRO_PUSH_SHIFT  25
+#define RQ_CQE_STATUS_LRO_ENTER_SHIFT 26
+#define RQ_CQE_STATUS_LRO_INTR_SHIFT  27
+
+#define RQ_CQE_STATUS_BP_EN_SHIFT     30
+#define RQ_CQE_STATUS_RXDONE_SHIFT    31
+#define RQ_CQE_STATUS_DECRY_PKT_SHIFT 29
+#define RQ_CQE_STATUS_FLUSH_SHIFT     28
+
+#define RQ_CQE_STATUS_CSUM_ERR_MASK  0xFFFFU
+#define RQ_CQE_STATUS_NUM_LRO_MASK   0xFFU
+#define RQ_CQE_STATUS_LRO_PUSH_MASK  0X1U
+#define RQ_CQE_STATUS_LRO_ENTER_MASK 0X1U
+#define RQ_CQE_STATUS_LRO_INTR_MASK  0X1U
+#define RQ_CQE_STATUS_BP_EN_MASK     0X1U
+#define RQ_CQE_STATUS_RXDONE_MASK    0x1U
+#define RQ_CQE_STATUS_FLUSH_MASK     0x1U
+#define RQ_CQE_STATUS_DECRY_PKT_MASK 0x1U
+
+#define RQ_CQE_STATUS_GET(val, member)               \
+	(((val) >> RQ_CQE_STATUS_##member##_SHIFT) & \
+	 RQ_CQE_STATUS_##member##_MASK)
+
+#define HINIC3_GET_RX_CSUM_ERR(status) RQ_CQE_STATUS_GET(status, CSUM_ERR)
+
+#define HINIC3_GET_RX_DONE(status) RQ_CQE_STATUS_GET(status, RXDONE)
+
+#define HINIC3_GET_RX_FLUSH(status) RQ_CQE_STATUS_GET(status, FLUSH)
+
+#define HINIC3_GET_RX_BP_EN(status) RQ_CQE_STATUS_GET(status, BP_EN)
+
+#define HINIC3_GET_RX_NUM_LRO(status) RQ_CQE_STATUS_GET(status, NUM_LRO)
+
+#define HINIC3_RX_IS_DECRY_PKT(status) RQ_CQE_STATUS_GET(status, DECRY_PKT)
+
+#define RQ_CQE_SUPER_CQE_EN_SHIFT  0
+#define RQ_CQE_PKT_NUM_SHIFT	   1
+#define RQ_CQE_PKT_LAST_LEN_SHIFT  6
+#define RQ_CQE_PKT_FIRST_LEN_SHIFT 19
+
+#define RQ_CQE_SUPER_CQE_EN_MASK  0x1
+#define RQ_CQE_PKT_NUM_MASK	  0x1FU
+#define RQ_CQE_PKT_FIRST_LEN_MASK 0x1FFFU
+#define RQ_CQE_PKT_LAST_LEN_MASK  0x1FFFU
+
+#define RQ_CQE_PKT_NUM_GET(val, member) \
+	(((val) >> RQ_CQE_PKT_##member##_SHIFT) & RQ_CQE_PKT_##member##_MASK)
+#define HINIC3_GET_RQ_CQE_PKT_NUM(pkt_info) RQ_CQE_PKT_NUM_GET(pkt_info, NUM)
+
+#define RQ_CQE_SUPER_CQE_EN_GET(val, member) \
+	(((val) >> RQ_CQE_##member##_SHIFT) & RQ_CQE_##member##_MASK)
+
+#define HINIC3_GET_SUPER_CQE_EN(pkt_info) \
+	RQ_CQE_SUPER_CQE_EN_GET(pkt_info, SUPER_CQE_EN)
+
+#define RQ_CQE_PKT_LEN_GET(val, member) \
+	(((val) >> RQ_CQE_PKT_##member##_SHIFT) & RQ_CQE_PKT_##member##_MASK)
+
+#define RQ_CQE_DECRY_INFO_DECRY_STATUS_SHIFT  8
+#define RQ_CQE_DECRY_INFO_ESP_NEXT_HEAD_SHIFT 0
+
+#define RQ_CQE_DECRY_INFO_DECRY_STATUS_MASK  0xFFU
+#define RQ_CQE_DECRY_INFO_ESP_NEXT_HEAD_MASK 0xFFU
+
+#define RQ_CQE_DECRY_INFO_GET(val, member)               \
+	(((val) >> RQ_CQE_DECRY_INFO_##member##_SHIFT) & \
+	 RQ_CQE_DECRY_INFO_##member##_MASK)
+
+#define HINIC3_GET_DECRYPT_STATUS(decry_info) \
+	RQ_CQE_DECRY_INFO_GET(decry_info, DECRY_STATUS)
+
+#define HINIC3_GET_ESP_NEXT_HEAD(decry_info) \
+	RQ_CQE_DECRY_INFO_GET(decry_info, ESP_NEXT_HEAD)
+
+/* Rx cqe checksum err */
+#define HINIC3_RX_CSUM_IP_CSUM_ERR      RTE_BIT32(0)
+#define HINIC3_RX_CSUM_TCP_CSUM_ERR     RTE_BIT32(1)
+#define HINIC3_RX_CSUM_UDP_CSUM_ERR     RTE_BIT32(2)
+#define HINIC3_RX_CSUM_IGMP_CSUM_ERR    RTE_BIT32(3)
+#define HINIC3_RX_CSUM_ICMP_V4_CSUM_ERR RTE_BIT32(4)
+#define HINIC3_RX_CSUM_ICMP_V6_CSUM_ERR RTE_BIT32(5)
+#define HINIC3_RX_CSUM_SCTP_CRC_ERR     RTE_BIT32(6)
+#define HINIC3_RX_CSUM_HW_CHECK_NONE    RTE_BIT32(7)
+#define HINIC3_RX_CSUM_IPSU_OTHER_ERR   RTE_BIT32(8)
+
+#define HINIC3_DEFAULT_RX_CSUM_OFFLOAD 0xFFF
+#define HINIC3_CQE_LEN		       32
+
+#define HINIC3_RSS_OFFLOAD_ALL (         \
+	RTE_ETH_RSS_IPV4 |               \
+	RTE_ETH_RSS_FRAG_IPV4 |          \
+	RTE_ETH_RSS_NONFRAG_IPV4_TCP |   \
+	RTE_ETH_RSS_NONFRAG_IPV4_UDP |   \
+	RTE_ETH_RSS_NONFRAG_IPV4_OTHER | \
+	RTE_ETH_RSS_IPV6 |               \
+	RTE_ETH_RSS_FRAG_IPV6 |          \
+	RTE_ETH_RSS_NONFRAG_IPV6_TCP |   \
+	RTE_ETH_RSS_NONFRAG_IPV6_UDP |   \
+	RTE_ETH_RSS_NONFRAG_IPV6_OTHER | \
+	RTE_ETH_RSS_IPV6_EX |            \
+	RTE_ETH_RSS_IPV6_TCP_EX |        \
+	RTE_ETH_RSS_IPV6_UDP_EX)
+
+struct hinic3_rxq_stats {
+	uint64_t packets;
+	uint64_t bytes;
+	uint64_t errors;
+	uint64_t csum_errors;
+	uint64_t other_errors;
+	uint64_t unlock_bp;
+	uint64_t dropped;
+
+	uint64_t rx_nombuf;
+	uint64_t rx_discards;
+	uint64_t burst_pkts;
+	uint64_t empty;
+	uint64_t tsc;
+#ifdef HINIC3_XSTAT_MBUF_USE
+	uint64_t rx_alloc_mbuf_bytes;
+	uint64_t rx_free_mbuf_bytes;
+	uint64_t rx_left_mbuf_bytes;
+#endif
+
+#ifdef HINIC3_XSTAT_RXBUF_INFO
+	uint64_t rx_mbuf;
+	uint64_t rx_avail;
+	uint64_t rx_hole;
+#endif
+
+#ifdef HINIC3_XSTAT_PROF_RX
+	uint64_t app_tsc;
+	uint64_t pmd_tsc;
+#endif
+};
+
+struct __rte_cache_aligned hinic3_rq_cqe {
+	RTE_ATOMIC(uint32_t)status;
+	uint32_t vlan_len;
+
+	uint32_t offload_type;
+	uint32_t hash_val;
+	uint32_t mark_id_0;
+	uint32_t mark_id_1;
+	uint32_t mark_id_2;
+	uint32_t pkt_info;
+};
+
+/**
+ * Attention: please do not add any member in hinic3_rx_info
+ * because rxq bulk rearm mode will write mbuf in rx_info.
+ */
+struct hinic3_rx_info {
+	struct rte_mbuf *mbuf;
+};
+
+struct hinic3_sge_sect {
+	struct hinic3_sge sge;
+	uint32_t rsvd;
+};
+
+struct hinic3_rq_extend_wqe {
+	struct hinic3_sge_sect buf_desc;
+	struct hinic3_sge_sect cqe_sect;
+};
+
+struct hinic3_rq_normal_wqe {
+	uint32_t buf_hi_addr;
+	uint32_t buf_lo_addr;
+	uint32_t cqe_hi_addr;
+	uint32_t cqe_lo_addr;
+};
+
+struct hinic3_rq_wqe {
+	union {
+		struct hinic3_rq_normal_wqe normal_wqe;
+		struct hinic3_rq_extend_wqe extend_wqe;
+	};
+};
+
+struct __rte_cache_aligned hinic3_rxq {
+	struct hinic3_nic_dev *nic_dev;
+
+	uint16_t q_id;
+	uint16_t q_depth;
+	uint16_t q_mask;
+	uint16_t buf_len;
+
+	uint32_t rx_buff_shift;
+
+	uint16_t rx_free_thresh;
+	uint16_t rxinfo_align_end;
+	uint16_t wqebb_shift;
+	uint16_t wqebb_size;
+
+	uint16_t wqe_type;
+	uint16_t cons_idx;
+	uint16_t prod_idx;
+	uint16_t delta;
+
+	uint16_t next_to_update;
+	uint16_t port_id;
+
+	const struct rte_memzone *rq_mz;
+	void *queue_buf_vaddr; /**< rxq dma info */
+	rte_iova_t queue_buf_paddr;
+
+	const struct rte_memzone *pi_mz;
+	uint16_t *pi_virt_addr;
+	void *db_addr;
+	rte_iova_t pi_dma_addr;
+
+	struct hinic3_rx_info *rx_info;
+	struct hinic3_rq_cqe *rx_cqe;
+	struct rte_mempool *mb_pool;
+
+	const struct rte_memzone *cqe_mz;
+	rte_iova_t cqe_start_paddr;
+	void *cqe_start_vaddr;
+	uint8_t dp_intr_en;
+	uint16_t msix_entry_idx;
+
+	bool rx_deferred_start; /* don't start this queue in dev start */
+	unsigned long status;
+	uint64_t wait_time_cycle;
+
+	struct hinic3_rxq_stats rxq_stats;
+#ifdef HINIC3_XSTAT_PROF_RX
+	uint64_t prof_rx_end_tsc; /**< Performance profiling. */
+#endif
+};
+
+uint16_t hinic3_rx_fill_wqe(struct hinic3_rxq *rxq);
+
+uint16_t hinic3_rx_fill_buffers(struct hinic3_rxq *rxq);
+
+void hinic3_free_rxq_mbufs(struct hinic3_rxq *rxq);
+
+void hinic3_free_all_rxq_mbufs(struct hinic3_nic_dev *nic_dev);
+
+int hinic3_update_rss_config(struct rte_eth_dev *dev,
+			     struct rte_eth_rss_conf *rss_conf);
+
+int hinic3_poll_rq_empty(struct hinic3_rxq *rxq);
+
+void hinic3_dump_cqe_status(struct hinic3_rxq *rxq, uint32_t *cqe_done_cnt,
+			    uint32_t *cqe_hole_cnt, uint32_t *head_ci, uint32_t *head_done);
+
+int hinic3_stop_rq(struct rte_eth_dev *eth_dev, struct hinic3_rxq *rxq);
+
+int hinic3_start_rq(struct rte_eth_dev *eth_dev, struct hinic3_rxq *rxq);
+
+uint16_t hinic3_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts);
+
+void hinic3_add_rq_to_rx_queue_list(struct hinic3_nic_dev *nic_dev,
+				    uint16_t queue_id);
+
+int hinic3_refill_indir_rqid(struct hinic3_rxq *rxq);
+
+void hinic3_init_rx_queue_list(struct hinic3_nic_dev *nic_dev);
+
+void hinic3_remove_rq_from_rx_queue_list(struct hinic3_nic_dev *nic_dev,
+					 uint16_t queue_id);
+int hinic3_start_all_rqs(struct rte_eth_dev *eth_dev);
+
+#ifdef HINIC3_XSTAT_RXBUF_INFO
+void hinic3_get_stats(struct hinic3_rxq *rxq);
+#endif
+
+/**
+ * Get receive queue local ci.
+ *
+ * @param[in] rxq
+ * Pointer to receive queue structure.
+ * @return
+ * Receive queue local ci.
+ */
+static inline uint16_t
+hinic3_get_rq_local_ci(struct hinic3_rxq *rxq)
+{
+	return MASKED_QUEUE_IDX(rxq, rxq->cons_idx);
+}
+
+static inline uint16_t
+hinic3_get_rq_free_wqebb(struct hinic3_rxq *rxq)
+{
+	return rxq->delta - 1;
+}
+
+/**
+ * Update receive queue local ci.
+ *
+ * @param[in] rxq
+ * Pointer to receive queue structure.
+ * @param[out] wqe_cnt
+ * Wqebb counters.
+ */
+static inline void
+hinic3_update_rq_local_ci(struct hinic3_rxq *rxq, uint16_t wqe_cnt)
+{
+	rxq->cons_idx += wqe_cnt;
+	rxq->delta += wqe_cnt;
+}
+
+#endif /* _HINIC3_RX_H_ */
diff --git a/drivers/net/hinic3/hinic3_tx.c b/drivers/net/hinic3/hinic3_tx.c
new file mode 100644
index 0000000000..8a167c49f7
--- /dev/null
+++ b/drivers/net/hinic3/hinic3_tx.c
@@ -0,0 +1,251 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+
+#include "base/hinic3_compat.h"
+#include "base/hinic3_nic_cfg.h"
+#include "base/hinic3_hwdev.h"
+#include "hinic3_nic_io.h"
+#include "hinic3_ethdev.h"
+#include "hinic3_tx.h"
+
+#define HINIC3_TX_TASK_WRAPPED	  1
+#define HINIC3_TX_BD_DESC_WRAPPED 2
+
+#define TX_MSS_DEFAULT 0x3E00
+#define TX_MSS_MIN     0x50
+
+#define HINIC3_MAX_TX_FREE_BULK 64
+
+#define MAX_PAYLOAD_OFFSET 221
+
+#define HINIC3_TX_OUTER_CHECKSUM_FLAG_SET    1
+#define HINIC3_TX_OUTER_CHECKSUM_FLAG_NO_SET 0
+
+#define HINIC3_TX_OFFLOAD_MASK \
+	(HINIC3_TX_CKSUM_OFFLOAD_MASK | HINIC3_PKT_TX_VLAN_PKT)
+
+#define HINIC3_TX_CKSUM_OFFLOAD_MASK                          \
+	(HINIC3_PKT_TX_IP_CKSUM | HINIC3_PKT_TX_TCP_CKSUM |   \
+	 HINIC3_PKT_TX_UDP_CKSUM | HINIC3_PKT_TX_SCTP_CKSUM | \
+	 HINIC3_PKT_TX_OUTER_IP_CKSUM | HINIC3_PKT_TX_TCP_SEG)
+
+static inline uint16_t
+hinic3_get_sq_free_wqebbs(struct hinic3_txq *sq)
+{
+	return ((sq->q_depth -
+		 (((sq->prod_idx - sq->cons_idx) + sq->q_depth) & sq->q_mask)) - 1);
+}
+
+static inline void
+hinic3_update_sq_local_ci(struct hinic3_txq *sq, uint16_t wqe_cnt)
+{
+	sq->cons_idx += wqe_cnt;
+}
+
+static inline uint16_t
+hinic3_get_sq_local_ci(struct hinic3_txq *sq)
+{
+	return MASKED_QUEUE_IDX(sq, sq->cons_idx);
+}
+
+static inline uint16_t
+hinic3_get_sq_hw_ci(struct hinic3_txq *sq)
+{
+	return MASKED_QUEUE_IDX(sq, hinic3_hw_cpu16(*sq->ci_vaddr_base));
+}
+
+static inline void
+hinic3_free_cpy_mbuf(struct hinic3_nic_dev *nic_dev __rte_unused,
+		     struct rte_mbuf *cpy_skb)
+{
+	rte_pktmbuf_free(cpy_skb);
+}
+
+/**
+ * Cleans up buffers (mbuf) in the send queue (txq) and returns these buffers to
+ * their memory pool.
+ *
+ * @param[in] txq
+ * Point to send queue.
+ * @param[in] free_cnt
+ * Number of mbufs to be released.
+ * @return
+ * Number of released mbufs.
+ */
+static int
+hinic3_xmit_mbuf_cleanup(struct hinic3_txq *txq, uint32_t free_cnt)
+{
+	struct hinic3_tx_info *tx_info = NULL;
+	struct rte_mbuf *mbuf = NULL;
+	struct rte_mbuf *mbuf_temp = NULL;
+	struct rte_mbuf *mbuf_free[HINIC3_MAX_TX_FREE_BULK];
+
+	int nb_free = 0;
+	int wqebb_cnt = 0;
+	uint16_t hw_ci, sw_ci, sq_mask;
+	uint32_t i;
+
+	hw_ci = hinic3_get_sq_hw_ci(txq);
+	sw_ci = hinic3_get_sq_local_ci(txq);
+	sq_mask = txq->q_mask;
+
+	for (i = 0; i < free_cnt; ++i) {
+		tx_info = &txq->tx_info[sw_ci];
+		if (hw_ci == sw_ci ||
+		    (((hw_ci - sw_ci) & sq_mask) < tx_info->wqebb_cnt))
+			break;
+		/*
+		 * The cpy_mbuf is usually used in the arge-sized package
+		 * scenario.
+		 */
+		if (unlikely(tx_info->cpy_mbuf != NULL)) {
+			hinic3_free_cpy_mbuf(txq->nic_dev, tx_info->cpy_mbuf);
+			tx_info->cpy_mbuf = NULL;
+		}
+		sw_ci = (sw_ci + tx_info->wqebb_cnt) & sq_mask;
+
+		wqebb_cnt += tx_info->wqebb_cnt;
+		mbuf = tx_info->mbuf;
+
+		if (likely(mbuf->nb_segs == 1)) {
+			mbuf_temp = rte_pktmbuf_prefree_seg(mbuf);
+			tx_info->mbuf = NULL;
+			if (unlikely(mbuf_temp == NULL))
+				continue;
+
+			mbuf_free[nb_free++] = mbuf_temp;
+			/*
+			 * If the pools of different mbufs are different,
+			 * release the mbufs of the same pool.
+			 */
+			if (unlikely(mbuf_temp->pool != mbuf_free[0]->pool ||
+				     nb_free >= HINIC3_MAX_TX_FREE_BULK)) {
+				rte_mempool_put_bulk(mbuf_free[0]->pool,
+						     (void **)mbuf_free,
+						     (nb_free - 1));
+				nb_free = 0;
+				mbuf_free[nb_free++] = mbuf_temp;
+			}
+		} else {
+			rte_pktmbuf_free(mbuf);
+			tx_info->mbuf = NULL;
+		}
+	}
+
+	if (nb_free > 0)
+		rte_mempool_put_bulk(mbuf_free[0]->pool, (void **)mbuf_free, nb_free);
+
+	hinic3_update_sq_local_ci(txq, wqebb_cnt);
+
+	return i;
+}
+
+static inline void
+hinic3_tx_free_mbuf_force(struct hinic3_txq *txq __rte_unused,
+			  struct rte_mbuf *mbuf)
+{
+	rte_pktmbuf_free(mbuf);
+}
+
+/**
+ * Release the mbuf and update the consumer index for sending queue.
+ *
+ * @param[in] txq
+ * Point to send queue.
+ */
+void
+hinic3_free_txq_mbufs(struct hinic3_txq *txq)
+{
+	struct hinic3_tx_info *tx_info = NULL;
+	uint16_t free_wqebbs;
+	uint16_t ci;
+
+	free_wqebbs = hinic3_get_sq_free_wqebbs(txq) + 1;
+
+	while (free_wqebbs < txq->q_depth) {
+		ci = hinic3_get_sq_local_ci(txq);
+
+		tx_info = &txq->tx_info[ci];
+		if (unlikely(tx_info->cpy_mbuf != NULL)) {
+			hinic3_free_cpy_mbuf(txq->nic_dev, tx_info->cpy_mbuf);
+			tx_info->cpy_mbuf = NULL;
+		}
+		hinic3_tx_free_mbuf_force(txq, tx_info->mbuf);
+		hinic3_update_sq_local_ci(txq, tx_info->wqebb_cnt);
+
+		free_wqebbs = (uint16_t)(free_wqebbs + tx_info->wqebb_cnt);
+		tx_info->mbuf = NULL;
+	}
+}
+
+void
+hinic3_free_all_txq_mbufs(struct hinic3_nic_dev *nic_dev)
+{
+	uint16_t qid;
+	for (qid = 0; qid < nic_dev->num_sqs; qid++)
+		hinic3_free_txq_mbufs(nic_dev->txqs[qid]);
+}
+
+int
+hinic3_tx_done_cleanup(void *txq, uint32_t free_cnt)
+{
+	struct hinic3_txq *tx_queue = txq;
+	uint32_t try_free_cnt = !free_cnt ? tx_queue->q_depth : free_cnt;
+
+	return hinic3_xmit_mbuf_cleanup(tx_queue, try_free_cnt);
+}
+
+int
+hinic3_stop_sq(struct hinic3_txq *txq)
+{
+	struct hinic3_nic_dev *nic_dev = txq->nic_dev;
+	uint64_t timeout;
+	int err = -EFAULT;
+	int free_wqebbs;
+
+	timeout = msecs_to_cycles(HINIC3_FLUSH_QUEUE_TIMEOUT) + cycles;
+	do {
+		hinic3_tx_done_cleanup(txq, 0);
+		free_wqebbs = hinic3_get_sq_free_wqebbs(txq) + 1;
+		if (free_wqebbs == txq->q_depth) {
+			err = 0;
+			break;
+		}
+
+		rte_delay_us(1);
+	} while (time_before(cycles, timeout));
+
+	if (err) {
+		PMD_DRV_LOG(WARNING, "%s Wait sq empty timeout", nic_dev->dev_name);
+		PMD_DRV_LOG(WARNING,
+			    "queue_idx: %u, sw_ci: %u, hw_ci: %u, sw_pi: %u, free_wqebbs: %u, q_depth:%u",
+			    txq->q_id,
+			    hinic3_get_sq_local_ci(txq),
+			    hinic3_get_sq_hw_ci(txq),
+			    MASKED_QUEUE_IDX(txq, txq->prod_idx),
+			    free_wqebbs,
+			    txq->q_depth);
+	}
+
+	return err;
+}
+
+/**
+ * Stop all sending queues (SQs).
+ *
+ * @param[in] txq
+ * Point to send queue.
+ */
+void
+hinic3_flush_txqs(struct hinic3_nic_dev *nic_dev)
+{
+	uint16_t qid;
+	int err;
+
+	for (qid = 0; qid < nic_dev->num_sqs; qid++) {
+		err = hinic3_stop_sq(nic_dev->txqs[qid]);
+		if (err)
+			PMD_DRV_LOG(ERR, "Stop sq%d failed", qid);
+	}
+}
diff --git a/drivers/net/hinic3/hinic3_tx.h b/drivers/net/hinic3/hinic3_tx.h
new file mode 100644
index 0000000000..cf6b9ce89b
--- /dev/null
+++ b/drivers/net/hinic3/hinic3_tx.h
@@ -0,0 +1,313 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+
+#ifndef _HINIC3_TX_H_
+#define _HINIC3_TX_H_
+
+#define MAX_SINGLE_SGE_SIZE		 65536
+#define HINIC3_NONTSO_PKT_MAX_SGE	 38 /**< non-tso max sge 38. */
+#define HINIC3_NONTSO_SEG_NUM_VALID(num) ((num) <= HINIC3_NONTSO_PKT_MAX_SGE)
+
+#define HINIC3_TSO_PKT_MAX_SGE		127 /**< tso max sge 127. */
+#define HINIC3_TSO_SEG_NUM_INVALID(num) ((num) > HINIC3_TSO_PKT_MAX_SGE)
+
+/* Tx offload info. */
+struct hinic3_tx_offload_info {
+	uint8_t outer_l2_len;
+	uint8_t outer_l3_type;
+	uint16_t outer_l3_len;
+
+	uint8_t inner_l2_len;
+	uint8_t inner_l3_type;
+	uint16_t inner_l3_len;
+
+	uint8_t tunnel_length;
+	uint8_t tunnel_type;
+	uint8_t inner_l4_type;
+	uint8_t inner_l4_len;
+
+	uint16_t payload_offset;
+	uint8_t inner_l4_tcp_udp;
+	uint8_t rsvd0; /**< Reserved field. */
+};
+
+/* Tx wqe ctx. */
+struct hinic3_wqe_info {
+	uint8_t around; /**< Indicates whether the WQE is bypassed. */
+	uint8_t cpy_mbuf_cnt;
+	uint16_t sge_cnt;
+
+	uint8_t offload;
+	uint8_t rsvd0; /**< Reserved field 0. */
+	uint16_t payload_offset;
+
+	uint8_t wrapped;
+	uint8_t owner;
+	uint16_t pi;
+
+	uint16_t wqebb_cnt;
+	uint16_t rsvd1; /**< Reserved field 1. */
+
+	uint32_t queue_info;
+};
+
+/* Descriptor for the send queue of wqe. */
+struct hinic3_sq_wqe_desc {
+	uint32_t ctrl_len;
+	uint32_t queue_info;
+	uint32_t hi_addr;
+	uint32_t lo_addr;
+};
+
+/* Describes the send queue task. */
+struct hinic3_sq_task {
+	uint32_t pkt_info0;
+	uint32_t ip_identify;
+	uint32_t pkt_info2;
+	uint32_t vlan_offload;
+};
+
+/* Descriptor that describes the transmit queue buffer. */
+struct hinic3_sq_bufdesc {
+	uint32_t len;     /**< 31-bits Length, L2NIC only use length[17:0]. */
+	uint32_t rsvd;    /**< Reserved field. */
+	uint32_t hi_addr; /**< Upper address. */
+	uint32_t lo_addr; /**< Lower address. */
+};
+
+/* Compact work queue entry that describes the send queue (SQ). */
+struct hinic3_sq_compact_wqe {
+	struct hinic3_sq_wqe_desc wqe_desc;
+};
+
+/* Extend work queue entry that describes the send queue (SQ). */
+struct hinic3_sq_extend_wqe {
+	struct hinic3_sq_wqe_desc wqe_desc;
+	struct hinic3_sq_task task;
+	struct hinic3_sq_bufdesc buf_desc[];
+};
+
+struct hinic3_sq_wqe {
+	union {
+		struct hinic3_sq_compact_wqe compact_wqe;
+		struct hinic3_sq_extend_wqe extend_wqe;
+	};
+};
+
+struct hinic3_sq_wqe_combo {
+	struct hinic3_sq_wqe_desc *hdr;
+	struct hinic3_sq_task *task;
+	struct hinic3_sq_bufdesc *bds_head;
+	uint32_t wqe_type;
+	uint32_t task_type;
+};
+
+enum sq_wqe_data_format {
+	SQ_NORMAL_WQE = 0,
+};
+
+/* Indicates the type of a WQE. */
+enum sq_wqe_ec_type {
+	SQ_WQE_COMPACT_TYPE = 0,
+	SQ_WQE_EXTENDED_TYPE = 1,
+};
+
+#define COMPACT_WQE_MAX_CTRL_LEN 0x3FFF
+
+/* Indicates the type of tasks with different lengths. */
+enum sq_wqe_tasksect_len_type {
+	SQ_WQE_TASKSECT_46BITS = 0,
+	SQ_WQE_TASKSECT_16BYTES = 1,
+};
+
+/** Setting and obtaining queue information */
+#define SQ_CTRL_BD0_LEN_SHIFT	   0
+#define SQ_CTRL_RSVD_SHIFT	   18
+#define SQ_CTRL_BUFDESC_NUM_SHIFT  19
+#define SQ_CTRL_TASKSECT_LEN_SHIFT 27
+#define SQ_CTRL_DATA_FORMAT_SHIFT  28
+#define SQ_CTRL_DIRECT_SHIFT	   29
+#define SQ_CTRL_EXTENDED_SHIFT	   30
+#define SQ_CTRL_OWNER_SHIFT	   31
+
+#define SQ_CTRL_BD0_LEN_MASK	  0x3FFFFU
+#define SQ_CTRL_RSVD_MASK	  0x1U
+#define SQ_CTRL_BUFDESC_NUM_MASK  0xFFU
+#define SQ_CTRL_TASKSECT_LEN_MASK 0x1U
+#define SQ_CTRL_DATA_FORMAT_MASK  0x1U
+#define SQ_CTRL_DIRECT_MASK	  0x1U
+#define SQ_CTRL_EXTENDED_MASK	  0x1U
+#define SQ_CTRL_OWNER_MASK	  0x1U
+
+#define SQ_CTRL_SET(val, member) \
+	(((uint32_t)(val) & SQ_CTRL_##member##_MASK) << SQ_CTRL_##member##_SHIFT)
+#define SQ_CTRL_GET(val, member) \
+	(((val) >> SQ_CTRL_##member##_SHIFT) & SQ_CTRL_##member##_MASK)
+#define SQ_CTRL_CLEAR(val, member) \
+	((val) & (~(SQ_CTRL_##member##_MASK << SQ_CTRL_##member##_SHIFT)))
+
+#define SQ_CTRL_QUEUE_INFO_PKT_TYPE_SHIFT  0
+#define SQ_CTRL_QUEUE_INFO_PLDOFF_SHIFT	   2
+#define SQ_CTRL_QUEUE_INFO_UFO_SHIFT	   10
+#define SQ_CTRL_QUEUE_INFO_TSO_SHIFT	   11
+#define SQ_CTRL_QUEUE_INFO_TCPUDP_CS_SHIFT 12
+#define SQ_CTRL_QUEUE_INFO_MSS_SHIFT	   13
+#define SQ_CTRL_QUEUE_INFO_SCTP_SHIFT	   27
+#define SQ_CTRL_QUEUE_INFO_UC_SHIFT	   28
+#define SQ_CTRL_QUEUE_INFO_PRI_SHIFT	   29
+
+#define SQ_CTRL_QUEUE_INFO_PKT_TYPE_MASK  0x3U
+#define SQ_CTRL_QUEUE_INFO_PLDOFF_MASK	  0xFFU
+#define SQ_CTRL_QUEUE_INFO_UFO_MASK	  0x1U
+#define SQ_CTRL_QUEUE_INFO_TSO_MASK	  0x1U
+#define SQ_CTRL_QUEUE_INFO_TCPUDP_CS_MASK 0x1U
+#define SQ_CTRL_QUEUE_INFO_MSS_MASK	  0x3FFFU
+#define SQ_CTRL_QUEUE_INFO_SCTP_MASK	  0x1U
+#define SQ_CTRL_QUEUE_INFO_UC_MASK	  0x1U
+#define SQ_CTRL_QUEUE_INFO_PRI_MASK	  0x7U
+
+#define SQ_CTRL_QUEUE_INFO_SET(val, member)                \
+	(((uint32_t)(val) & SQ_CTRL_QUEUE_INFO_##member##_MASK) \
+	 << SQ_CTRL_QUEUE_INFO_##member##_SHIFT)
+#define SQ_CTRL_QUEUE_INFO_GET(val, member)               \
+	(((val) >> SQ_CTRL_QUEUE_INFO_##member##_SHIFT) & \
+	 SQ_CTRL_QUEUE_INFO_##member##_MASK)
+#define SQ_CTRL_QUEUE_INFO_CLEAR(val, member)          \
+	((val) & (~(SQ_CTRL_QUEUE_INFO_##member##_MASK \
+		    << SQ_CTRL_QUEUE_INFO_##member##_SHIFT)))
+
+/* Setting and obtaining task information */
+#define SQ_TASK_INFO0_TUNNEL_FLAG_SHIFT	    19
+#define SQ_TASK_INFO0_ESP_NEXT_PROTO_SHIFT  22
+#define SQ_TASK_INFO0_INNER_L4_EN_SHIFT	    24
+#define SQ_TASK_INFO0_INNER_L3_EN_SHIFT	    25
+#define SQ_TASK_INFO0_INNER_L4_PSEUDO_SHIFT 26
+#define SQ_TASK_INFO0_OUT_L4_EN_SHIFT	    27
+#define SQ_TASK_INFO0_OUT_L3_EN_SHIFT	    28
+#define SQ_TASK_INFO0_OUT_L4_PSEUDO_SHIFT   29
+#define SQ_TASK_INFO0_ESP_OFFLOAD_SHIFT	    30
+#define SQ_TASK_INFO0_IPSEC_PROTO_SHIFT	    31
+
+#define SQ_TASK_INFO0_TUNNEL_FLAG_MASK	   0x1U
+#define SQ_TASK_INFO0_ESP_NEXT_PROTO_MASK  0x3U
+#define SQ_TASK_INFO0_INNER_L4_EN_MASK	   0x1U
+#define SQ_TASK_INFO0_INNER_L3_EN_MASK	   0x1U
+#define SQ_TASK_INFO0_INNER_L4_PSEUDO_MASK 0x1U
+#define SQ_TASK_INFO0_OUT_L4_EN_MASK	   0x1U
+#define SQ_TASK_INFO0_OUT_L3_EN_MASK	   0x1U
+#define SQ_TASK_INFO0_OUT_L4_PSEUDO_MASK   0x1U
+#define SQ_TASK_INFO0_ESP_OFFLOAD_MASK	   0x1U
+#define SQ_TASK_INFO0_IPSEC_PROTO_MASK	   0x1U
+
+#define SQ_TASK_INFO0_SET(val, member)                \
+	(((uint32_t)(val) & SQ_TASK_INFO0_##member##_MASK) \
+	 << SQ_TASK_INFO0_##member##_SHIFT)
+#define SQ_TASK_INFO0_GET(val, member)               \
+	(((val) >> SQ_TASK_INFO0_##member##_SHIFT) & \
+	 SQ_TASK_INFO0_##member##_MASK)
+
+#define SQ_TASK_INFO1_SET(val, member)           \
+	(((val) & SQ_TASK_INFO1_##member##_MASK) \
+	 << SQ_TASK_INFO1_##member##_SHIFT)
+#define SQ_TASK_INFO1_GET(val, member)               \
+	(((val) >> SQ_TASK_INFO1_##member##_SHIFT) & \
+	 SQ_TASK_INFO1_##member##_MASK)
+
+#define SQ_TASK_INFO3_VLAN_TAG_SHIFT	   0
+#define SQ_TASK_INFO3_VLAN_TYPE_SHIFT	   16
+#define SQ_TASK_INFO3_VLAN_TAG_VALID_SHIFT 19
+
+#define SQ_TASK_INFO3_VLAN_TAG_MASK	  0xFFFFU
+#define SQ_TASK_INFO3_VLAN_TYPE_MASK	  0x7U
+#define SQ_TASK_INFO3_VLAN_TAG_VALID_MASK 0x1U
+
+#define SQ_TASK_INFO3_SET(val, member)           \
+	(((val) & SQ_TASK_INFO3_##member##_MASK) \
+	 << SQ_TASK_INFO3_##member##_SHIFT)
+#define SQ_TASK_INFO3_GET(val, member)               \
+	(((val) >> SQ_TASK_INFO3_##member##_SHIFT) & \
+	 SQ_TASK_INFO3_##member##_MASK)
+
+/* Defines the TX queue status. */
+enum hinic3_txq_status {
+	HINIC3_TXQ_STATUS_START = 0,
+	HINIC3_TXQ_STATUS_STOP,
+};
+
+/* Setting and obtaining status information. */
+#define HINIC3_TXQ_IS_STARTED(txq)  ((txq)->status == HINIC3_TXQ_STATUS_START)
+#define HINIC3_TXQ_IS_STOPPED(txq)  ((txq)->status == HINIC3_TXQ_STATUS_STOP)
+#define HINIC3_SET_TXQ_STARTED(txq) ((txq)->status = HINIC3_TXQ_STATUS_START)
+#define HINIC3_SET_TXQ_STOPPED(txq) ((txq)->status = HINIC3_TXQ_STATUS_STOP)
+
+/* Txq info. */
+struct hinic3_txq_stats {
+	uint64_t packets;
+	uint64_t bytes;
+	uint64_t tx_busy;
+	uint64_t offload_errors;
+	uint64_t burst_pkts;
+	uint64_t sge_len0;
+	uint64_t mbuf_null;
+	uint64_t cpy_pkts;
+	uint64_t sge_len_too_large;
+
+#ifdef HINIC3_XSTAT_PROF_TX
+	uint64_t app_tsc;
+	uint64_t pmd_tsc;
+#endif
+
+#ifdef HINIC3_XSTAT_MBUF_USE
+	uint64_t tx_left_mbuf_bytes;
+#endif
+};
+
+/* Structure for storing the information sent. */
+struct hinic3_tx_info {
+	struct rte_mbuf *mbuf;
+	struct rte_mbuf *cpy_mbuf;
+	int wqebb_cnt;
+};
+
+/* Indicates the sending queue of information. */
+struct __rte_cache_aligned hinic3_txq {
+	struct hinic3_nic_dev *nic_dev;
+	uint16_t q_id;
+	uint16_t q_depth;
+	uint16_t q_mask;
+	uint16_t wqebb_size;
+	uint16_t wqebb_shift;
+	uint16_t cons_idx;
+	uint16_t prod_idx;
+	uint16_t status;
+
+	uint16_t tx_free_thresh;
+	uint16_t owner;
+	bool tx_deferred_start; /* don't start this queue in dev start */
+	void *db_addr;
+	struct hinic3_tx_info *tx_info;
+
+	const struct rte_memzone *sq_mz;
+	void *queue_buf_vaddr;
+	rte_iova_t queue_buf_paddr;
+
+	const struct rte_memzone *ci_mz;
+	volatile uint16_t *ci_vaddr_base;
+	rte_iova_t ci_dma_base;
+	uint64_t sq_head_addr;
+	uint64_t sq_bot_sge_addr;
+	uint32_t cos;
+	struct hinic3_txq_stats txq_stats;
+#ifdef HINIC3_XSTAT_PROF_TX
+	uint64_t prof_tx_end_tsc;
+#endif
+};
+
+void hinic3_flush_txqs(struct hinic3_nic_dev *nic_dev);
+void hinic3_free_txq_mbufs(struct hinic3_txq *txq);
+void hinic3_free_all_txq_mbufs(struct hinic3_nic_dev *nic_dev);
+int hinic3_stop_sq(struct hinic3_txq *txq);
+int hinic3_start_all_sqs(struct rte_eth_dev *eth_dev);
+int hinic3_tx_done_cleanup(void *txq, uint32_t free_cnt);
+#endif /**< _HINIC3_TX_H_ */
diff --git a/drivers/net/hinic3/meson.build b/drivers/net/hinic3/meson.build
index 018b300f75..64f49e52dd 100644
--- a/drivers/net/hinic3/meson.build
+++ b/drivers/net/hinic3/meson.build
@@ -20,6 +20,9 @@ subdir('base')
 
 sources = files(
         'hinic3_ethdev.c',
+        'hinic3_nic_io.c',
+        'hinic3_rx.c',
+        'hinic3_tx.c',
 )
 
 includes += include_directories('base')
\ No newline at end of file
-- 
2.47.0.windows.2

