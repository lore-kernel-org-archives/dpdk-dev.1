Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D032CCD194
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 08:03:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FB48427A0;
	Thu, 16 Oct 2025 10:01:59 +0200 (CEST)
Received: from out28-124.mail.aliyun.com (out28-124.mail.aliyun.com
 [115.124.28.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9257E410FB
 for <dev@dpdk.org>; Thu, 16 Oct 2025 10:01:50 +0200 (CEST)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.f.zFcDW_1760601707 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 16 Oct 2025 16:01:47 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	dev@dpdk.org
Cc: Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>,
 Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v13 12/17] net/nbl: add nbl device rxtx queue setup and
 release ops
Date: Thu, 16 Oct 2025 01:01:23 -0700
Message-Id: <20251016080128.3133579-13-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251016080128.3133579-1-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20251016080128.3133579-1-dimon.zhao@nebula-matrix.com>
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

Implement NBL device Rx and Tx queue setup & release functions

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/nbl_dev/nbl_dev.c             |  75 +++++
 drivers/net/nbl/nbl_dev/nbl_dev.h             |   7 +
 drivers/net/nbl/nbl_ethdev.c                  |   4 +
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c |   2 +
 drivers/net/nbl/nbl_hw/nbl_resource.h         | 187 ++++++++++++
 drivers/net/nbl/nbl_hw/nbl_txrx.c             | 287 ++++++++++++++++--
 drivers/net/nbl/nbl_hw/nbl_txrx.h             |  11 +
 drivers/net/nbl/nbl_include/nbl_def_common.h  |   5 +
 drivers/net/nbl/nbl_include/nbl_include.h     |   1 +
 9 files changed, 556 insertions(+), 23 deletions(-)

diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.c b/drivers/net/nbl/nbl_dev/nbl_dev.c
index b94556a07b..ddd47c8182 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.c
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.c
@@ -62,6 +62,81 @@ int nbl_dev_port_close(struct rte_eth_dev *eth_dev)
 	return 0;
 }
 
+int nbl_tx_queue_setup(struct rte_eth_dev *eth_dev, u16 queue_idx,
+		       u16 nb_desc, unsigned int socket_id, const struct rte_eth_txconf *conf)
+{
+	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_dispatch_ops *disp_ops = NBL_DEV_MGT_TO_DISP_OPS(dev_mgt);
+	struct nbl_dev_ring_mgt *ring_mgt = &dev_mgt->net_dev->ring_mgt;
+	struct nbl_dev_ring *tx_ring = &ring_mgt->tx_rings[queue_idx];
+	struct nbl_start_tx_ring_param param = { 0 };
+	int ret;
+
+	param.queue_idx = queue_idx;
+	param.nb_desc = nb_desc;
+	param.socket_id = socket_id;
+	param.conf = conf;
+	param.product = adapter->caps.product_type;
+	param.bond_broadcast_check = NULL;
+	ret =  disp_ops->start_tx_ring(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), &param, &tx_ring->dma);
+	if (ret) {
+		NBL_LOG(ERR, "start_tx_ring failed %d", ret);
+		return ret;
+	}
+
+	tx_ring->desc_num = nb_desc;
+
+	return ret;
+}
+
+int nbl_rx_queue_setup(struct rte_eth_dev *eth_dev, u16 queue_idx,
+		       u16 nb_desc, unsigned int socket_id,
+		       const struct rte_eth_rxconf *conf, struct rte_mempool *mempool)
+{
+	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_dispatch_ops *disp_ops = NBL_DEV_MGT_TO_DISP_OPS(dev_mgt);
+	struct nbl_dev_ring_mgt *ring_mgt = &dev_mgt->net_dev->ring_mgt;
+	struct nbl_dev_ring *rx_ring = &ring_mgt->rx_rings[queue_idx];
+	struct nbl_start_rx_ring_param param = { 0 };
+	int ret;
+
+	param.queue_idx = queue_idx;
+	param.nb_desc = nb_desc;
+	param.socket_id = socket_id;
+	param.conf = conf;
+	param.mempool = mempool;
+	param.product = adapter->caps.product_type;
+	ret =  disp_ops->start_rx_ring(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), &param, &rx_ring->dma);
+	if (ret) {
+		NBL_LOG(ERR, "start_rx_ring failed %d", ret);
+		return ret;
+	}
+
+	rx_ring->desc_num = nb_desc;
+
+	return ret;
+}
+
+void nbl_tx_queues_release(struct rte_eth_dev *eth_dev, uint16_t queue_id)
+{
+	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_dispatch_ops *disp_ops = NBL_DEV_MGT_TO_DISP_OPS(dev_mgt);
+
+	disp_ops->release_tx_ring(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), queue_id);
+}
+
+void nbl_rx_queues_release(struct rte_eth_dev *eth_dev, uint16_t queue_id)
+{
+	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_dispatch_ops *disp_ops = NBL_DEV_MGT_TO_DISP_OPS(dev_mgt);
+
+	disp_ops->release_rx_ring(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), queue_id);
+}
+
 static int nbl_dev_setup_chan_queue(struct nbl_adapter *adapter)
 {
 	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.h b/drivers/net/nbl/nbl_dev/nbl_dev.h
index 4df9383919..b09171096b 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.h
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.h
@@ -56,5 +56,12 @@ int nbl_dev_configure(struct rte_eth_dev *eth_dev);
 int nbl_dev_port_start(struct rte_eth_dev *eth_dev);
 int nbl_dev_port_stop(struct rte_eth_dev *eth_dev);
 int nbl_dev_port_close(struct rte_eth_dev *eth_dev);
+int nbl_tx_queue_setup(struct rte_eth_dev *eth_dev, u16 queue_idx,
+		       u16 nb_desc, unsigned int socket_id, const struct rte_eth_txconf *conf);
+int nbl_rx_queue_setup(struct rte_eth_dev *eth_dev, u16 queue_idx,
+		       u16 nb_desc, unsigned int socket_id,
+		       const struct rte_eth_rxconf *conf, struct rte_mempool *mempool);
+void nbl_tx_queues_release(struct rte_eth_dev *eth_dev, uint16_t queue_id);
+void nbl_rx_queues_release(struct rte_eth_dev *eth_dev, uint16_t queue_id);
 
 #endif
diff --git a/drivers/net/nbl/nbl_ethdev.c b/drivers/net/nbl/nbl_ethdev.c
index c072756318..32506cc830 100644
--- a/drivers/net/nbl/nbl_ethdev.c
+++ b/drivers/net/nbl/nbl_ethdev.c
@@ -30,6 +30,10 @@ const struct eth_dev_ops nbl_eth_dev_ops = {
 	.dev_start = nbl_dev_port_start,
 	.dev_stop = nbl_dev_port_stop,
 	.dev_close = nbl_dev_close,
+	.tx_queue_setup = nbl_tx_queue_setup,
+	.rx_queue_setup = nbl_rx_queue_setup,
+	.tx_queue_release = nbl_tx_queues_release,
+	.rx_queue_release = nbl_rx_queues_release,
 };
 
 static int nbl_eth_dev_init(struct rte_eth_dev *eth_dev)
diff --git a/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c b/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c
index 958c85d319..8e694c342a 100644
--- a/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c
+++ b/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c
@@ -53,6 +53,8 @@ static int nbl_res_start(struct nbl_resource_mgt_leonis *res_mgt_leonis)
 	struct nbl_resource_mgt *res_mgt = &res_mgt_leonis->res_mgt;
 	int ret;
 
+	res_mgt->res_info.base_qid = 0;
+
 	ret = nbl_txrx_mgt_start(res_mgt);
 	if (ret)
 		goto txrx_failed;
diff --git a/drivers/net/nbl/nbl_hw/nbl_resource.h b/drivers/net/nbl/nbl_hw/nbl_resource.h
index d33c1f43e3..2a639db07f 100644
--- a/drivers/net/nbl/nbl_hw/nbl_resource.h
+++ b/drivers/net/nbl/nbl_hw/nbl_resource.h
@@ -16,12 +16,190 @@
 #define NBL_RES_MGT_TO_CHAN_OPS(res_mgt)	(NBL_RES_MGT_TO_CHAN_OPS_TBL(res_mgt)->ops)
 #define NBL_RES_MGT_TO_CHAN_PRIV(res_mgt)	(NBL_RES_MGT_TO_CHAN_OPS_TBL(res_mgt)->priv)
 #define NBL_RES_MGT_TO_ETH_DEV(res_mgt)		((res_mgt)->eth_dev)
+#define NBL_RES_MGT_TO_COMMON(res_mgt)		((res_mgt)->common)
 #define NBL_RES_MGT_TO_TXRX_MGT(res_mgt)	((res_mgt)->txrx_mgt)
+#define NBL_RES_MGT_TO_TX_RING(res_mgt, index)	\
+	(NBL_RES_MGT_TO_TXRX_MGT(res_mgt)->tx_rings[(index)])
+#define NBL_RES_MGT_TO_RX_RING(res_mgt, index)	\
+	(NBL_RES_MGT_TO_TXRX_MGT(res_mgt)->rx_rings[(index)])
+
+union nbl_tx_extend_head {
+	struct nbl_tx_ehdr_leonis {
+		/* DW0 */
+		u32 mac_len :5;
+		u32 ip_len :5;
+		u32 l4_len :4;
+		u32 l4_type :2;
+		u32 inner_ip_type :2;
+		u32 external_ip_type :2;
+		u32 external_ip_len :5;
+		u32 l4_tunnel_type :2;
+		u32 l4_tunnel_len :5;
+		/* DW1 */
+		u32 l4s_sid :10;
+		u32 l4s_sync_ind :1;
+		u32 l4s_redun_ind :1;
+		u32 l4s_redun_head_ind :1;
+		u32 l4s_hdl_ind :1;
+		u32 l4s_pbrac_mode :1;
+		u32 rsv0 :2;
+		u32 mss :14;
+		u32 tso :1;
+		/* DW2 */
+		/* if dport = NBL_TX_DPORT_ETH; dport_info = 0
+		 * if dport = NBL_TX_DPORT_HOST; dport_info = host queue id
+		 * if dport = NBL_TX_DPORT_ECPU; dport_info = ecpu queue_id
+		 */
+		u32 dport_info :11;
+		/* if dport = NBL_TX_DPORT_ETH; dport_id[3:0] = eth port id, dport_id[9:4] = lag id
+		 * if dport = NBL_TX_DPORT_HOST; dport_id[9:0] = host vsi_id
+		 * if dport = NBL_TX_DPORT_ECPU; dport_id[9:0] = ecpu vsi_id
+		 */
+		u32 dport_id :10;
+#define NBL_TX_DPORT_ID_LAG_OFT_LEONIS	(4)
+		u32 dport :3;
+#define NBL_TX_DPORT_ETH		(0)
+#define NBL_TX_DPORT_HOST		(1)
+#define NBL_TX_DPORT_ECPU		(2)
+#define NBL_TX_DPORT_EMP		(3)
+#define NBL_TX_DPORT_BMC		(4)
+#define NBL_TX_DPORT_EMP_DRACO		(2)
+#define NBL_TX_DPORT_BMC_DRACO		(3)
+		u32 fwd :2;
+#define NBL_TX_FWD_TYPE_DROP		(0)
+#define NBL_TX_FWD_TYPE_NORMAL		(1)
+#define NBL_TX_FWD_TYPE_RSV		(2)
+#define NBL_TX_FWD_TYPE_CPU_ASSIGNED	(3)
+		u32 rss_lag_en :1;
+		u32 l4_csum_en :1;
+		u32 l3_csum_en :1;
+		u32 rsv1 :3;
+	} leonis;
+};
+
+union nbl_rx_extend_head {
+	struct nbl_rx_ehdr_leonis {
+		/* DW0 */
+		/* 0x0:eth, 0x1:host, 0x2:ecpu, 0x3:emp, 0x4:bcm */
+		u32 sport :3;
+		u32 dport_info :11;
+		/* sport = 0, sport_id[3:0] = eth id,
+		 * sport = 1, sport_id[9:0] = host vsi_id,
+		 * sport = 2, sport_id[9:0] = ecpu vsi_id,
+		 */
+		u32 sport_id :10;
+		/* 0x0:drop, 0x1:normal, 0x2:cpu upcall */
+		u32 fwd :2;
+		u32 rsv0 :6;
+		/* DW1 */
+		u32 error_code :6;
+		u32 ptype :10;
+		u32 profile_id :4;
+		u32 checksum_status :1;
+		u32 rsv1 :1;
+		u32 l4s_sid :10;
+		/* DW2 */
+		u32 rsv3 :2;
+		u32 l4s_hdl_ind :1;
+		u32 l4s_tcp_offset :14;
+		u32 l4s_resync_ind :1;
+		u32 l4s_check_ind :1;
+		u32 l4s_dec_ind :1;
+		u32 rsv2 :4;
+		u32 num_buffers :8;
+		u32 hash_value;
+	} leonis;
+};
+
+struct nbl_packed_desc {
+	rte_le64_t addr;
+	rte_le32_t len;
+	rte_le16_t id;
+	rte_le16_t flags;
+};
+
+struct nbl_tx_entry {
+	struct rte_mbuf *mbuf;
+	uint16_t first_id;
+};
+
+struct nbl_rx_entry {
+	struct rte_mbuf *mbuf;
+};
 
 struct nbl_res_tx_ring {
+	volatile struct nbl_packed_desc *desc;
+	struct nbl_tx_entry *tx_entry;
+	const struct rte_memzone *net_hdr_mz;
+	volatile uint8_t *notify;
+	const struct rte_eth_dev *eth_dev;
+	struct nbl_common_info *common;
+	u64 default_hdr[2];
+
+	enum nbl_product_type product;
+	int dma_limit_msb;
+	bool dma_set_msb;
+	u16 nb_desc;
+	u16 next_to_clean;
+	u16 next_to_use;
+
+	u16 avail_used_flags;
+	bool used_wrap_counter;
+	u16 notify_qid;
+	u16 exthdr_len;
+
+	u16 vlan_proto;
+	u16 vlan_tci;
+	u16 lag_id;
+	u16 vq_free_cnt;
+	/* Start freeing TX buffers if there are less free descriptors than this value */
+	u16 tx_free_thresh;
+	/* Number of Tx descriptors to use before RS bit is set */
+	u16 tx_rs_thresh;
+
+	unsigned int size;
+
+	u16 queue_id;
+
+	u64 offloads;
+	u64 ring_phys_addr;
+
+	u16 (*prep_tx_ehdr)(union nbl_tx_extend_head *head, struct rte_mbuf *mbuf);
 };
 
 struct nbl_res_rx_ring {
+	volatile struct nbl_packed_desc *desc;
+	struct nbl_rx_entry *rx_entry;
+	struct rte_mempool *mempool;
+	volatile uint8_t *notify;
+	const struct rte_eth_dev *eth_dev;
+	struct nbl_common_info *common;
+	uint64_t mbuf_initializer; /**< value to init mbufs */
+	struct rte_mbuf fake_mbuf;
+
+	enum nbl_product_type product;
+	int dma_limit_msb;
+	unsigned int size;
+	bool dma_set_msb;
+	u16 nb_desc;
+	u16 next_to_clean;
+	u16 next_to_use;
+
+	u16 avail_used_flags;
+	bool used_wrap_counter;
+	u16 notify_qid;
+	u16 exthdr_len;
+
+	u16 vlan_proto;
+	u16 vlan_tci;
+	u16 vq_free_cnt;
+	u16 port_id;
+
+	u16 queue_id;
+	u16 buf_length;
+
+	u64 offloads;
+	u64 ring_phys_addr;
 };
 
 struct nbl_txrx_mgt {
@@ -33,11 +211,20 @@ struct nbl_txrx_mgt {
 	u8 rx_ring_num;
 };
 
+struct nbl_res_info {
+	u16 base_qid;
+	u16 lcore_max;
+	u16 *pf_qid_to_lcore_id;
+	rte_atomic16_t tx_current_queue;
+};
+
 struct nbl_resource_mgt {
 	const struct rte_eth_dev *eth_dev;
 	struct nbl_channel_ops_tbl *chan_ops_tbl;
 	struct nbl_hw_ops_tbl *hw_ops_tbl;
 	struct nbl_txrx_mgt *txrx_mgt;
+	struct nbl_common_info *common;
+	struct nbl_res_info res_info;
 };
 
 struct nbl_resource_mgt_leonis {
diff --git a/drivers/net/nbl/nbl_hw/nbl_txrx.c b/drivers/net/nbl/nbl_hw/nbl_txrx.c
index 5c5caa55eb..d8a3a95c6e 100644
--- a/drivers/net/nbl/nbl_hw/nbl_txrx.c
+++ b/drivers/net/nbl/nbl_hw/nbl_txrx.c
@@ -39,36 +39,275 @@ static void nbl_res_txrx_remove_rings(void *priv)
 	rte_free(txrx_mgt->rx_rings);
 }
 
+static void nbl_res_txrx_stop_tx_ring(void *priv, u16 queue_idx)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_res_tx_ring *tx_ring = NBL_RES_MGT_TO_TX_RING(res_mgt, queue_idx);
+	int i;
+
+	if (!tx_ring)
+		return;
+
+	for (i = 0; i < tx_ring->nb_desc; i++) {
+		if (tx_ring->tx_entry[i].mbuf != NULL) {
+			rte_pktmbuf_free_seg(tx_ring->tx_entry[i].mbuf);
+			memset(&tx_ring->tx_entry[i], 0, sizeof(*tx_ring->tx_entry));
+		}
+		tx_ring->desc[i].flags = 0;
+	}
+
+	tx_ring->avail_used_flags = BIT(NBL_PACKED_DESC_F_AVAIL);
+	tx_ring->used_wrap_counter = 1;
+	tx_ring->next_to_clean = NBL_TX_RS_THRESH - 1;
+	tx_ring->next_to_use = 0;
+	tx_ring->vq_free_cnt = tx_ring->nb_desc;
+}
+
+static void nbl_res_txrx_release_tx_ring(void *priv, u16 queue_idx)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_txrx_mgt *txrx_mgt = NBL_RES_MGT_TO_TXRX_MGT(res_mgt);
+	struct nbl_res_tx_ring *tx_ring = NBL_RES_MGT_TO_TX_RING(res_mgt, queue_idx);
+	if (!tx_ring)
+		return;
+	rte_free(tx_ring->tx_entry);
+	rte_free(tx_ring);
+	txrx_mgt->tx_rings[queue_idx] = NULL;
+}
+
+static inline u16 nbl_prep_tx_ehdr_leonis(union nbl_tx_extend_head *head, struct rte_mbuf *mbuf)
+{
+	RTE_SET_USED(head);
+	RTE_SET_USED(mbuf);
+	return 0;
+}
+
 static int nbl_res_txrx_start_tx_ring(void *priv,
 				      struct nbl_start_tx_ring_param *param,
 				      u64 *dma_addr)
 {
-	RTE_SET_USED(priv);
-	RTE_SET_USED(param);
-	RTE_SET_USED(dma_addr);
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_txrx_mgt *txrx_mgt = NBL_RES_MGT_TO_TXRX_MGT(res_mgt);
+	struct nbl_res_tx_ring *tx_ring = NBL_RES_MGT_TO_TX_RING(res_mgt, param->queue_idx);
+	const struct rte_eth_dev *eth_dev = NBL_RES_MGT_TO_ETH_DEV(res_mgt);
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+	const struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	const struct rte_memzone *memzone;
+	const struct rte_memzone *net_hdr_mz;
+	char vq_hdr_name[NBL_VQ_HDR_NAME_MAXSIZE];
+	struct nbl_tx_ehdr_leonis ext_hdr = {0};
+	uint64_t offloads;
+	u32 size;
+
+	offloads = param->conf->offloads | eth_dev->data->dev_conf.txmode.offloads;
+
+	if (eth_dev->data->tx_queues[param->queue_idx] != NULL) {
+		NBL_LOG(WARNING, "re-setup an already allocated tx queue");
+		nbl_res_txrx_stop_tx_ring(priv, param->queue_idx);
+		eth_dev->data->tx_queues[param->queue_idx] = NULL;
+	}
+
+	tx_ring = rte_zmalloc("nbl_txring", sizeof(*tx_ring), RTE_CACHE_LINE_SIZE);
+	if (!tx_ring) {
+		NBL_LOG(ERR, "allocate tx queue data structure failed");
+		return -ENOMEM;
+	}
+	memset(&tx_ring->default_hdr, 0, sizeof(tx_ring->default_hdr));
+	switch (param->product) {
+	case NBL_LEONIS_TYPE:
+		tx_ring->exthdr_len = sizeof(struct nbl_tx_ehdr_leonis);
+		tx_ring->prep_tx_ehdr = nbl_prep_tx_ehdr_leonis;
+		ext_hdr.fwd = NBL_TX_FWD_TYPE_NORMAL;
+		memcpy(&tx_ring->default_hdr, &ext_hdr, sizeof(struct nbl_tx_ehdr_leonis));
+		break;
+	default:
+		tx_ring->exthdr_len = sizeof(union nbl_tx_extend_head);
+		break;
+	};
+
+	tx_ring->tx_entry = rte_calloc("nbl_tx_entry",
+				       param->nb_desc, sizeof(*tx_ring->tx_entry), 0);
+	if (!tx_ring->tx_entry) {
+		NBL_LOG(ERR, "allocate tx queue %d software ring failed", param->queue_idx);
+		goto alloc_tx_entry_failed;
+	}
+
+	/* Alloc twice memory, and second half is used to back up the desc for desc checking */
+	size = RTE_ALIGN_CEIL(sizeof(tx_ring->desc[0]) * param->nb_desc, 4096);
+	memzone = rte_eth_dma_zone_reserve(eth_dev, "tx_ring", param->queue_idx,
+					   size, RTE_CACHE_LINE_SIZE,
+					   param->socket_id);
+	if (memzone == NULL) {
+		NBL_LOG(ERR, "reserve dma zone for tx ring failed");
+		goto alloc_dma_zone_failed;
+	}
+
+	/* if has no memory to put extend header, apply for new memory */
+	size = param->nb_desc * NBL_TX_HEADER_LEN;
+	snprintf(vq_hdr_name, sizeof(vq_hdr_name), "port%d_vq%d_hdr",
+			eth_dev->data->port_id, param->queue_idx);
+	net_hdr_mz = rte_memzone_reserve_aligned(vq_hdr_name, size,
+						 param->socket_id,
+						 RTE_MEMZONE_IOVA_CONTIG,
+						 RTE_CACHE_LINE_SIZE);
+	if (net_hdr_mz == NULL) {
+		if (rte_errno == EEXIST)
+			net_hdr_mz = rte_memzone_lookup(vq_hdr_name);
+		if (net_hdr_mz == NULL) {
+			NBL_LOG(ERR, "reserve net_hdr_mz dma zone for tx ring failed");
+			goto reserve_net_hdr_mz_failed;
+		}
+	}
+
+	tx_ring->product = param->product;
+	tx_ring->nb_desc = param->nb_desc;
+	tx_ring->vq_free_cnt = param->nb_desc;
+	tx_ring->queue_id = param->queue_idx;
+	tx_ring->notify_qid =
+		(res_mgt->res_info.base_qid + txrx_mgt->queue_offset + param->queue_idx) * 2 + 1;
+	tx_ring->ring_phys_addr = (u64)NBL_DMA_ADDRESS_FULL_TRANSLATE(common, memzone->iova);
+	tx_ring->avail_used_flags = BIT(NBL_PACKED_DESC_F_AVAIL);
+	tx_ring->used_wrap_counter = 1;
+	tx_ring->next_to_clean = NBL_TX_RS_THRESH - 1;
+	tx_ring->next_to_use = 0;
+	tx_ring->desc = (struct nbl_packed_desc *)memzone->addr;
+	tx_ring->net_hdr_mz = net_hdr_mz;
+	tx_ring->eth_dev = eth_dev;
+	tx_ring->dma_set_msb = common->dma_set_msb;
+	tx_ring->dma_limit_msb = common->dma_limit_msb;
+	tx_ring->notify = hw_ops->get_tail_ptr(NBL_RES_MGT_TO_HW_PRIV(res_mgt));
+	tx_ring->offloads = offloads;
+	tx_ring->common = common;
+
+	eth_dev->data->tx_queues[param->queue_idx] = tx_ring;
+
+	txrx_mgt->tx_rings[param->queue_idx] = tx_ring;
+	txrx_mgt->tx_ring_num++;
+
+	*dma_addr = tx_ring->ring_phys_addr;
+
 	return 0;
-}
 
-static void nbl_res_txrx_stop_tx_ring(void *priv, u16 queue_idx)
-{
-	RTE_SET_USED(priv);
-	RTE_SET_USED(queue_idx);
+reserve_net_hdr_mz_failed:
+	rte_memzone_free(memzone);
+alloc_dma_zone_failed:
+	rte_free(tx_ring->tx_entry);
+	tx_ring->tx_entry = NULL;
+	tx_ring->size = 0;
+alloc_tx_entry_failed:
+	rte_free(tx_ring);
+	return -ENOMEM;
 }
 
-static void nbl_res_txrx_release_txring(void *priv, u16 queue_idx)
+static void nbl_res_txrx_stop_rx_ring(void *priv, u16 queue_idx)
 {
-	RTE_SET_USED(priv);
-	RTE_SET_USED(queue_idx);
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_res_rx_ring *rx_ring =
+			NBL_RES_MGT_TO_RX_RING(res_mgt, queue_idx);
+	u16 i;
+
+	if (!rx_ring)
+		return;
+	if (rx_ring->rx_entry != NULL) {
+		for (i = 0; i < rx_ring->nb_desc; i++) {
+			if (rx_ring->rx_entry[i].mbuf != NULL) {
+				rte_pktmbuf_free_seg(rx_ring->rx_entry[i].mbuf);
+				rx_ring->rx_entry[i].mbuf = NULL;
+			}
+			rx_ring->desc[i].flags = 0;
+		}
+
+		for (i = rx_ring->nb_desc; i < rx_ring->nb_desc + NBL_DESC_PER_LOOP_VEC_MAX; i++)
+			rx_ring->desc[i].flags = 0;
+	}
+
+	rx_ring->next_to_clean = 0;
+	rx_ring->next_to_use = 0;
 }
 
 static int nbl_res_txrx_start_rx_ring(void *priv,
 				      struct nbl_start_rx_ring_param *param,
 				      u64 *dma_addr)
 {
-	RTE_SET_USED(priv);
-	RTE_SET_USED(param);
-	RTE_SET_USED(dma_addr);
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_txrx_mgt *txrx_mgt = NBL_RES_MGT_TO_TXRX_MGT(res_mgt);
+	struct nbl_res_rx_ring *rx_ring = NBL_RES_MGT_TO_RX_RING(res_mgt, param->queue_idx);
+	const struct rte_eth_dev *eth_dev = NBL_RES_MGT_TO_ETH_DEV(res_mgt);
+	const struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+	const struct rte_memzone *memzone;
+	u32 size;
+
+	if (eth_dev->data->rx_queues[param->queue_idx] != NULL) {
+		NBL_LOG(WARNING, "re-setup an already allocated rx queue");
+		nbl_res_txrx_stop_rx_ring(priv, param->queue_idx);
+		eth_dev->data->rx_queues[param->queue_idx] = NULL;
+	}
+
+	rx_ring = rte_zmalloc_socket("nbl_rxring", sizeof(*rx_ring),
+				 RTE_CACHE_LINE_SIZE, param->socket_id);
+	if (rx_ring == NULL) {
+		NBL_LOG(ERR, "allocate rx queue data structure failed");
+		return -ENOMEM;
+	}
+
+	size = sizeof(rx_ring->rx_entry[0]) * (param->nb_desc + NBL_DESC_PER_LOOP_VEC_MAX);
+	rx_ring->rx_entry = rte_zmalloc_socket("rxq rx_entry", size,
+					       RTE_CACHE_LINE_SIZE,
+					       param->socket_id);
+	if (rx_ring->rx_entry == NULL) {
+		NBL_LOG(ERR, "allocate rx queue %d software ring failed", param->queue_idx);
+		goto alloc_rx_entry_failed;
+	}
+
+	size = sizeof(rx_ring->desc[0]) * (param->nb_desc + NBL_DESC_PER_LOOP_VEC_MAX);
+	memzone = rte_eth_dma_zone_reserve(eth_dev, "rx_ring", param->queue_idx,
+					   size, RTE_CACHE_LINE_SIZE,
+					   param->socket_id);
+	if (memzone == NULL) {
+		NBL_LOG(ERR, "reserve dma zone for rx ring failed");
+		goto alloc_dma_zone_failed;
+	}
+
+	rx_ring->product = param->product;
+	rx_ring->mempool = param->mempool;
+	rx_ring->nb_desc = param->nb_desc;
+	rx_ring->queue_id = param->queue_idx;
+	rx_ring->notify_qid =
+		(res_mgt->res_info.base_qid + txrx_mgt->queue_offset + param->queue_idx) * 2;
+	rx_ring->ring_phys_addr = NBL_DMA_ADDRESS_FULL_TRANSLATE(common, memzone->iova);
+	rx_ring->desc = (struct nbl_packed_desc *)memzone->addr;
+	rx_ring->port_id = eth_dev->data->port_id;
+	rx_ring->eth_dev = eth_dev;
+	rx_ring->dma_set_msb = common->dma_set_msb;
+	rx_ring->dma_limit_msb = common->dma_limit_msb;
+	rx_ring->common = common;
+	rx_ring->notify = hw_ops->get_tail_ptr(NBL_RES_MGT_TO_HW_PRIV(res_mgt));
+
+	switch (param->product) {
+	case NBL_LEONIS_TYPE:
+		rx_ring->exthdr_len = sizeof(struct nbl_rx_ehdr_leonis);
+		break;
+	default:
+		rx_ring->exthdr_len = sizeof(union nbl_rx_extend_head);
+	};
+
+	eth_dev->data->rx_queues[param->queue_idx] = rx_ring;
+
+	txrx_mgt->rx_rings[param->queue_idx] = rx_ring;
+	txrx_mgt->rx_ring_num++;
+
+	*dma_addr = rx_ring->ring_phys_addr;
+
 	return 0;
+
+alloc_dma_zone_failed:
+	rte_free(rx_ring->rx_entry);
+	rx_ring->rx_entry = NULL;
+	rx_ring->size = 0;
+alloc_rx_entry_failed:
+	rte_free(rx_ring);
+	return -ENOMEM;
 }
 
 static int nbl_res_alloc_rx_bufs(void *priv, u16 queue_idx)
@@ -78,16 +317,18 @@ static int nbl_res_alloc_rx_bufs(void *priv, u16 queue_idx)
 	return 0;
 }
 
-static void nbl_res_txrx_stop_rx_ring(void *priv, u16 queue_idx)
-{
-	RTE_SET_USED(priv);
-	RTE_SET_USED(queue_idx);
-}
-
 static void nbl_res_txrx_release_rx_ring(void *priv, u16 queue_idx)
 {
-	RTE_SET_USED(priv);
-	RTE_SET_USED(queue_idx);
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_txrx_mgt *txrx_mgt = NBL_RES_MGT_TO_TXRX_MGT(res_mgt);
+	struct nbl_res_rx_ring *rx_ring =
+			NBL_RES_MGT_TO_RX_RING(res_mgt, queue_idx);
+	if (!rx_ring)
+		return;
+
+	rte_free(rx_ring->rx_entry);
+	rte_free(rx_ring);
+	txrx_mgt->rx_rings[queue_idx] = NULL;
 }
 
 static void nbl_res_txrx_update_rx_ring(void *priv, u16 index)
@@ -106,7 +347,7 @@ do {										\
 	NBL_TXRX_SET_OPS(remove_rings, nbl_res_txrx_remove_rings);		\
 	NBL_TXRX_SET_OPS(start_tx_ring, nbl_res_txrx_start_tx_ring);		\
 	NBL_TXRX_SET_OPS(stop_tx_ring, nbl_res_txrx_stop_tx_ring);		\
-	NBL_TXRX_SET_OPS(release_tx_ring, nbl_res_txrx_release_txring);		\
+	NBL_TXRX_SET_OPS(release_tx_ring, nbl_res_txrx_release_tx_ring);	\
 	NBL_TXRX_SET_OPS(start_rx_ring, nbl_res_txrx_start_rx_ring);		\
 	NBL_TXRX_SET_OPS(alloc_rx_bufs, nbl_res_alloc_rx_bufs);			\
 	NBL_TXRX_SET_OPS(stop_rx_ring, nbl_res_txrx_stop_rx_ring);		\
diff --git a/drivers/net/nbl/nbl_hw/nbl_txrx.h b/drivers/net/nbl/nbl_hw/nbl_txrx.h
index 56dbd3c587..197da844ab 100644
--- a/drivers/net/nbl/nbl_hw/nbl_txrx.h
+++ b/drivers/net/nbl/nbl_hw/nbl_txrx.h
@@ -7,4 +7,15 @@
 
 #include "nbl_resource.h"
 
+#define NBL_PACKED_DESC_F_AVAIL			(7)
+#define NBL_PACKED_DESC_F_USED			(15)
+#define NBL_VRING_DESC_F_NEXT			(1 << 0)
+#define NBL_VRING_DESC_F_WRITE			(1 << 1)
+
+#define NBL_TX_RS_THRESH			(32)
+#define NBL_TX_HEADER_LEN			(32)
+#define NBL_VQ_HDR_NAME_MAXSIZE			(32)
+
+#define NBL_DESC_PER_LOOP_VEC_MAX		(8)
+
 #endif
diff --git a/drivers/net/nbl/nbl_include/nbl_def_common.h b/drivers/net/nbl/nbl_include/nbl_def_common.h
index 45db1e7413..14823dd998 100644
--- a/drivers/net/nbl/nbl_include/nbl_def_common.h
+++ b/drivers/net/nbl/nbl_include/nbl_def_common.h
@@ -79,6 +79,11 @@ struct nbl_dev_user_link_stat {
 #define NBL_DEV_USER_SET_PROMISC_MODE	_IO(NBL_DEV_USER_TYPE, 10)
 #define NBL_DEV_USER_SET_MCAST_MODE	_IO(NBL_DEV_USER_TYPE, 11)
 
+#define NBL_DMA_ADDRESS_FULL_TRANSLATE(hw, address)					\
+	({ typeof(hw) _hw = (hw);							\
+	((((u64)((_hw)->dma_set_msb)) << ((u64)((_hw)->dma_limit_msb))) | (address));	\
+	})
+
 struct nbl_dma_mem {
 	void *va;
 	uint64_t pa;
diff --git a/drivers/net/nbl/nbl_include/nbl_include.h b/drivers/net/nbl/nbl_include/nbl_include.h
index eb4be89f11..823498d48f 100644
--- a/drivers/net/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/nbl/nbl_include/nbl_include.h
@@ -88,6 +88,7 @@ struct nbl_start_tx_ring_param {
 	u32 socket_id;
 	enum nbl_product_type product;
 	const struct rte_eth_txconf *conf;
+	bool (*bond_broadcast_check)(struct rte_mbuf *mbuf);
 };
 
 struct nbl_txrx_queue_param {
-- 
2.34.1

