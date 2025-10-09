Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C06CCD187
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 11:16:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9CB04065D;
	Thu,  9 Oct 2025 13:16:39 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id A30F140277
 for <dev@dpdk.org>; Thu,  9 Oct 2025 13:16:36 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 85CA9201F22;
 Thu,  9 Oct 2025 13:16:36 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 26D40201F3A;
 Thu,  9 Oct 2025 13:16:36 +0200 (CEST)
Received: from lsv03379.swis.in-blr01.nxp.com (lsv03379.swis.in-blr01.nxp.com
 [92.120.147.188])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 2D1EE1800085;
 Thu,  9 Oct 2025 19:16:35 +0800 (+08)
From: vanshika.shukla@nxp.com
To: dev@dpdk.org, Gagandeep Singh <g.singh@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Vanshika Shukla <vanshika.shukla@nxp.com>
Cc: Apeksha Gupta <apeksha.gupta@nxp.com>
Subject: [v1 02/12] net/enetc: Add RX and TX queue APIs for ENETC4 PMD
Date: Thu,  9 Oct 2025 16:46:23 +0530
Message-Id: <20251009111633.3585957-3-vanshika.shukla@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251009111633.3585957-1-vanshika.shukla@nxp.com>
References: <20251009111633.3585957-1-vanshika.shukla@nxp.com>
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

From: Apeksha Gupta <apeksha.gupta@nxp.com>

Introduces queue setup, release, start, and stop
APIs for ENETC4 RX and TX queues, enabling:

- Queue configuration and initialization
- Queue resource management (setup, release)
- Queue operation control (start, stop)

Signed-off-by: Apeksha Gupta <apeksha.gupta@nxp.com>
Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 doc/guides/nics/features/enetc4.ini |   1 +
 drivers/net/enetc/enetc.h           |  13 +
 drivers/net/enetc/enetc4_ethdev.c   | 401 ++++++++++++++++++++++++++++
 drivers/net/enetc/enetc4_vf.c       |   8 +
 drivers/net/enetc/enetc_rxtx.c      |  32 ++-
 5 files changed, 452 insertions(+), 3 deletions(-)

diff --git a/doc/guides/nics/features/enetc4.ini b/doc/guides/nics/features/enetc4.ini
index ca3b9ae992..37b548dcab 100644
--- a/doc/guides/nics/features/enetc4.ini
+++ b/doc/guides/nics/features/enetc4.ini
@@ -4,6 +4,7 @@
 ; Refer to default.ini for the full list of available PMD features.
 ;
 [Features]
+Queue start/stop     = Y
 Linux                = Y
 ARMv8                = Y
 Usage doc            = Y
diff --git a/drivers/net/enetc/enetc.h b/drivers/net/enetc/enetc.h
index 19e0fa3a07..df831ce8d0 100644
--- a/drivers/net/enetc/enetc.h
+++ b/drivers/net/enetc/enetc.h
@@ -97,6 +97,19 @@ int enetc4_dev_configure(struct rte_eth_dev *dev);
 int enetc4_dev_close(struct rte_eth_dev *dev);
 int enetc4_dev_infos_get(struct rte_eth_dev *dev __rte_unused,
 			 struct rte_eth_dev_info *dev_info);
+int enetc4_rx_queue_setup(struct rte_eth_dev *dev, uint16_t rx_queue_id,
+			  uint16_t nb_rx_desc, unsigned int socket_id __rte_unused,
+			  const struct rte_eth_rxconf *rx_conf,
+			  struct rte_mempool *mb_pool);
+int enetc4_rx_queue_start(struct rte_eth_dev *dev, uint16_t qidx);
+int enetc4_rx_queue_stop(struct rte_eth_dev *dev, uint16_t qidx);
+void enetc4_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid);
+int enetc4_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
+			  uint16_t nb_desc, unsigned int socket_id __rte_unused,
+			  const struct rte_eth_txconf *tx_conf);
+int enetc4_tx_queue_start(struct rte_eth_dev *dev, uint16_t qidx);
+int enetc4_tx_queue_stop(struct rte_eth_dev *dev, uint16_t qidx);
+void enetc4_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid);
 
 /*
  * enetc4_vf function prototype
diff --git a/drivers/net/enetc/enetc4_ethdev.c b/drivers/net/enetc/enetc4_ethdev.c
index e96f390626..6f67eda24e 100644
--- a/drivers/net/enetc/enetc4_ethdev.c
+++ b/drivers/net/enetc/enetc4_ethdev.c
@@ -131,10 +131,305 @@ enetc4_dev_infos_get(struct rte_eth_dev *dev __rte_unused,
 	return 0;
 }
 
+static int
+enetc4_alloc_txbdr(struct enetc_bdr *txr, uint16_t nb_desc)
+{
+	int size;
+
+	size = nb_desc * sizeof(struct enetc_swbd);
+	txr->q_swbd = rte_malloc(NULL, size, ENETC_BD_RING_ALIGN);
+	if (txr->q_swbd == NULL)
+		return -ENOMEM;
+
+	size = nb_desc * sizeof(struct enetc_bdr);
+	txr->bd_base = rte_malloc(NULL, size, ENETC_BD_RING_ALIGN);
+	if (txr->bd_base == NULL) {
+		rte_free(txr->q_swbd);
+		txr->q_swbd = NULL;
+		return -ENOMEM;
+	}
+	txr->bd_count = nb_desc;
+	txr->next_to_clean = 0;
+	txr->next_to_use = 0;
+
+	return 0;
+}
+
+static void
+enetc4_free_bdr(struct enetc_bdr *rxr)
+{
+	rte_free(rxr->bd_base);
+	rte_free(rxr->q_swbd);
+	rxr->q_swbd = NULL;
+	rxr->bd_base = NULL;
+}
+
+static void
+enetc4_setup_txbdr(struct enetc_hw *hw, struct enetc_bdr *tx_ring)
+{
+	int idx = tx_ring->index;
+	phys_addr_t bd_address;
+
+	bd_address = (phys_addr_t)
+		     rte_mem_virt2iova((const void *)tx_ring->bd_base);
+	enetc4_txbdr_wr(hw, idx, ENETC_TBBAR0,
+		       lower_32_bits((uint64_t)bd_address));
+	enetc4_txbdr_wr(hw, idx, ENETC_TBBAR1,
+		       upper_32_bits((uint64_t)bd_address));
+	enetc4_txbdr_wr(hw, idx, ENETC_TBLENR,
+		       ENETC_RTBLENR_LEN(tx_ring->bd_count));
+
+	enetc4_txbdr_wr(hw, idx, ENETC_TBCIR, 0);
+	enetc4_txbdr_wr(hw, idx, ENETC_TBCISR, 0);
+	tx_ring->tcir = (void *)((size_t)hw->reg +
+			ENETC_BDR(TX, idx, ENETC_TBCIR));
+	tx_ring->tcisr = (void *)((size_t)hw->reg +
+			 ENETC_BDR(TX, idx, ENETC_TBCISR));
+}
+
+int
+enetc4_tx_queue_setup(struct rte_eth_dev *dev,
+		     uint16_t queue_idx,
+		     uint16_t nb_desc,
+		     unsigned int socket_id __rte_unused,
+		     const struct rte_eth_txconf *tx_conf)
+{
+	int err = 0;
+	struct enetc_bdr *tx_ring;
+	struct rte_eth_dev_data *data = dev->data;
+	struct enetc_eth_adapter *priv =
+			ENETC_DEV_PRIVATE(data->dev_private);
+
+	PMD_INIT_FUNC_TRACE();
+	if (nb_desc > MAX_BD_COUNT)
+		return -1;
+
+	tx_ring = rte_zmalloc(NULL, sizeof(struct enetc_bdr), 0);
+	if (tx_ring == NULL) {
+		ENETC_PMD_ERR("Failed to allocate TX ring memory");
+		err = -ENOMEM;
+		return -1;
+	}
+
+	tx_ring->index = queue_idx;
+	err = enetc4_alloc_txbdr(tx_ring, nb_desc);
+	if (err)
+		goto fail;
+
+	tx_ring->ndev = dev;
+	enetc4_setup_txbdr(&priv->hw.hw, tx_ring);
+	data->tx_queues[queue_idx] = tx_ring;
+	if (!tx_conf->tx_deferred_start) {
+		/* enable ring */
+		enetc4_txbdr_wr(&priv->hw.hw, tx_ring->index,
+			       ENETC_TBMR, ENETC_TBMR_EN);
+		dev->data->tx_queue_state[tx_ring->index] =
+			       RTE_ETH_QUEUE_STATE_STARTED;
+	} else {
+		dev->data->tx_queue_state[tx_ring->index] =
+			       RTE_ETH_QUEUE_STATE_STOPPED;
+	}
+
+	return 0;
+fail:
+	rte_free(tx_ring);
+
+	return err;
+}
+
+void
+enetc4_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
+{
+	void *txq = dev->data->tx_queues[qid];
+
+	if (txq == NULL)
+		return;
+
+	struct enetc_bdr *tx_ring = (struct enetc_bdr *)txq;
+	struct enetc_eth_hw *eth_hw =
+		ENETC_DEV_PRIVATE_TO_HW(tx_ring->ndev->data->dev_private);
+	struct enetc_hw *hw;
+	struct enetc_swbd *tx_swbd;
+	int i;
+	uint32_t val;
+
+	/* Disable the ring */
+	hw = &eth_hw->hw;
+	val = enetc4_txbdr_rd(hw, tx_ring->index, ENETC_TBMR);
+	val &= (~ENETC_TBMR_EN);
+	enetc4_txbdr_wr(hw, tx_ring->index, ENETC_TBMR, val);
+
+	/* clean the ring*/
+	i = tx_ring->next_to_clean;
+	tx_swbd = &tx_ring->q_swbd[i];
+	while (tx_swbd->buffer_addr != NULL) {
+		rte_pktmbuf_free(tx_swbd->buffer_addr);
+		tx_swbd->buffer_addr = NULL;
+		tx_swbd++;
+		i++;
+		if (unlikely(i == tx_ring->bd_count)) {
+			i = 0;
+			tx_swbd = &tx_ring->q_swbd[i];
+		}
+	}
+
+	enetc4_free_bdr(tx_ring);
+	rte_free(tx_ring);
+}
+
+static int
+enetc4_alloc_rxbdr(struct enetc_bdr *rxr, uint16_t nb_desc)
+{
+	int size;
+
+	size = nb_desc * sizeof(struct enetc_swbd);
+	rxr->q_swbd = rte_malloc(NULL, size, ENETC_BD_RING_ALIGN);
+	if (rxr->q_swbd == NULL)
+		return -ENOMEM;
+
+	size = nb_desc * sizeof(struct enetc_bdr);
+	rxr->bd_base = rte_malloc(NULL, size, ENETC_BD_RING_ALIGN);
+	if (rxr->bd_base == NULL) {
+		rte_free(rxr->q_swbd);
+		rxr->q_swbd = NULL;
+		return -ENOMEM;
+	}
+	rxr->bd_count = nb_desc;
+	rxr->next_to_clean = 0;
+	rxr->next_to_use = 0;
+	rxr->next_to_alloc = 0;
+
+	return 0;
+}
+
+static void
+enetc4_setup_rxbdr(struct enetc_hw *hw, struct enetc_bdr *rx_ring,
+		  struct rte_mempool *mb_pool)
+{
+	int idx = rx_ring->index;
+	uint16_t buf_size;
+	phys_addr_t bd_address;
+
+	bd_address = (phys_addr_t)
+		     rte_mem_virt2iova((const void *)rx_ring->bd_base);
+
+	enetc4_rxbdr_wr(hw, idx, ENETC_RBBAR0,
+		       lower_32_bits((uint64_t)bd_address));
+	enetc4_rxbdr_wr(hw, idx, ENETC_RBBAR1,
+		       upper_32_bits((uint64_t)bd_address));
+	enetc4_rxbdr_wr(hw, idx, ENETC_RBLENR,
+		       ENETC_RTBLENR_LEN(rx_ring->bd_count));
+
+	rx_ring->mb_pool = mb_pool;
+	rx_ring->rcir = (void *)((size_t)hw->reg +
+			ENETC_BDR(RX, idx, ENETC_RBCIR));
+	enetc_refill_rx_ring(rx_ring, (enetc_bd_unused(rx_ring)));
+	buf_size = (uint16_t)(rte_pktmbuf_data_room_size(rx_ring->mb_pool) -
+		   RTE_PKTMBUF_HEADROOM);
+	enetc4_rxbdr_wr(hw, idx, ENETC_RBBSR, buf_size);
+	enetc4_rxbdr_wr(hw, idx, ENETC_RBPIR, 0);
+}
+
+int
+enetc4_rx_queue_setup(struct rte_eth_dev *dev,
+		     uint16_t rx_queue_id,
+		     uint16_t nb_rx_desc,
+		     unsigned int socket_id __rte_unused,
+		     const struct rte_eth_rxconf *rx_conf,
+		     struct rte_mempool *mb_pool)
+{
+	int err = 0;
+	struct enetc_bdr *rx_ring;
+	struct rte_eth_dev_data *data =  dev->data;
+	struct enetc_eth_adapter *adapter =
+			ENETC_DEV_PRIVATE(data->dev_private);
+	uint64_t rx_offloads = data->dev_conf.rxmode.offloads;
+
+	PMD_INIT_FUNC_TRACE();
+	if (nb_rx_desc > MAX_BD_COUNT)
+		return -1;
+
+	rx_ring = rte_zmalloc(NULL, sizeof(struct enetc_bdr), 0);
+	if (rx_ring == NULL) {
+		ENETC_PMD_ERR("Failed to allocate RX ring memory");
+		err = -ENOMEM;
+		return err;
+	}
+
+	rx_ring->index = rx_queue_id;
+	err = enetc4_alloc_rxbdr(rx_ring, nb_rx_desc);
+	if (err)
+		goto fail;
+
+	rx_ring->ndev = dev;
+	enetc4_setup_rxbdr(&adapter->hw.hw, rx_ring, mb_pool);
+	data->rx_queues[rx_queue_id] = rx_ring;
+
+	if (!rx_conf->rx_deferred_start) {
+		/* enable ring */
+		enetc4_rxbdr_wr(&adapter->hw.hw, rx_ring->index, ENETC_RBMR,
+			       ENETC_RBMR_EN);
+		dev->data->rx_queue_state[rx_ring->index] =
+			       RTE_ETH_QUEUE_STATE_STARTED;
+	} else {
+		dev->data->rx_queue_state[rx_ring->index] =
+			       RTE_ETH_QUEUE_STATE_STOPPED;
+	}
+
+	rx_ring->crc_len = (uint8_t)((rx_offloads & RTE_ETH_RX_OFFLOAD_KEEP_CRC) ?
+				     RTE_ETHER_CRC_LEN : 0);
+	return 0;
+fail:
+	rte_free(rx_ring);
+
+	return err;
+}
+
+void
+enetc4_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
+{
+	void *rxq = dev->data->rx_queues[qid];
+
+	if (rxq == NULL)
+		return;
+
+	struct enetc_bdr *rx_ring = (struct enetc_bdr *)rxq;
+	struct enetc_eth_hw *eth_hw =
+		ENETC_DEV_PRIVATE_TO_HW(rx_ring->ndev->data->dev_private);
+	struct enetc_swbd *q_swbd;
+	struct enetc_hw *hw;
+	uint32_t val;
+	int i;
+
+	/* Disable the ring */
+	hw = &eth_hw->hw;
+	val = enetc4_rxbdr_rd(hw, rx_ring->index, ENETC_RBMR);
+	val &= (~ENETC_RBMR_EN);
+	enetc4_rxbdr_wr(hw, rx_ring->index, ENETC_RBMR, val);
+
+	/* Clean the ring */
+	i = rx_ring->next_to_clean;
+	q_swbd = &rx_ring->q_swbd[i];
+	while (i != rx_ring->next_to_use) {
+		rte_pktmbuf_free(q_swbd->buffer_addr);
+		q_swbd->buffer_addr = NULL;
+		q_swbd++;
+		i++;
+		if (unlikely(i == rx_ring->bd_count)) {
+			i = 0;
+			q_swbd = &rx_ring->q_swbd[i];
+		}
+	}
+
+	enetc4_free_bdr(rx_ring);
+	rte_free(rx_ring);
+}
+
 int
 enetc4_dev_close(struct rte_eth_dev *dev)
 {
 	struct enetc_eth_hw *hw = ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	uint16_t i;
 	int ret;
 
 	PMD_INIT_FUNC_TRACE();
@@ -146,6 +441,18 @@ enetc4_dev_close(struct rte_eth_dev *dev)
 	else
 		ret = enetc4_dev_stop(dev);
 
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		enetc4_rx_queue_release(dev, i);
+		dev->data->rx_queues[i] = NULL;
+	}
+	dev->data->nb_rx_queues = 0;
+
+	for (i = 0; i < dev->data->nb_tx_queues; i++) {
+		enetc4_tx_queue_release(dev, i);
+		dev->data->tx_queues[i] = NULL;
+	}
+	dev->data->nb_tx_queues = 0;
+
 	if (rte_eal_iova_mode() == RTE_IOVA_PA)
 		dpaax_iova_table_depopulate();
 
@@ -173,7 +480,93 @@ enetc4_dev_configure(struct rte_eth_dev *dev)
 	return 0;
 }
 
+int
+enetc4_rx_queue_start(struct rte_eth_dev *dev, uint16_t qidx)
+{
+	struct enetc_eth_adapter *priv =
+			ENETC_DEV_PRIVATE(dev->data->dev_private);
+	struct enetc_bdr *rx_ring;
+	uint32_t rx_data;
+
+	PMD_INIT_FUNC_TRACE();
+	rx_ring = dev->data->rx_queues[qidx];
+	if (dev->data->rx_queue_state[qidx] == RTE_ETH_QUEUE_STATE_STOPPED) {
+		rx_data = enetc4_rxbdr_rd(&priv->hw.hw, rx_ring->index,
+					 ENETC_RBMR);
+		rx_data = rx_data | ENETC_RBMR_EN;
+		enetc4_rxbdr_wr(&priv->hw.hw, rx_ring->index, ENETC_RBMR,
+			       rx_data);
+		dev->data->rx_queue_state[qidx] = RTE_ETH_QUEUE_STATE_STARTED;
+	}
+
+	return 0;
+}
+
+int
+enetc4_rx_queue_stop(struct rte_eth_dev *dev, uint16_t qidx)
+{
+	struct enetc_eth_adapter *priv =
+			ENETC_DEV_PRIVATE(dev->data->dev_private);
+	struct enetc_bdr *rx_ring;
+	uint32_t rx_data;
+
+	PMD_INIT_FUNC_TRACE();
+	rx_ring = dev->data->rx_queues[qidx];
+	if (dev->data->rx_queue_state[qidx] == RTE_ETH_QUEUE_STATE_STARTED) {
+		rx_data = enetc4_rxbdr_rd(&priv->hw.hw, rx_ring->index,
+					 ENETC_RBMR);
+		rx_data = rx_data & (~ENETC_RBMR_EN);
+		enetc4_rxbdr_wr(&priv->hw.hw, rx_ring->index, ENETC_RBMR,
+			       rx_data);
+		dev->data->rx_queue_state[qidx] = RTE_ETH_QUEUE_STATE_STOPPED;
+	}
+
+	return 0;
+}
+
+int
+enetc4_tx_queue_start(struct rte_eth_dev *dev, uint16_t qidx)
+{
+	struct enetc_eth_adapter *priv =
+			ENETC_DEV_PRIVATE(dev->data->dev_private);
+	struct enetc_bdr *tx_ring;
+	uint32_t tx_data;
 
+	PMD_INIT_FUNC_TRACE();
+	tx_ring = dev->data->tx_queues[qidx];
+	if (dev->data->tx_queue_state[qidx] == RTE_ETH_QUEUE_STATE_STOPPED) {
+		tx_data = enetc4_txbdr_rd(&priv->hw.hw, tx_ring->index,
+					 ENETC_TBMR);
+		tx_data = tx_data | ENETC_TBMR_EN;
+		enetc4_txbdr_wr(&priv->hw.hw, tx_ring->index, ENETC_TBMR,
+			       tx_data);
+		dev->data->tx_queue_state[qidx] = RTE_ETH_QUEUE_STATE_STARTED;
+	}
+
+	return 0;
+}
+
+int
+enetc4_tx_queue_stop(struct rte_eth_dev *dev, uint16_t qidx)
+{
+	struct enetc_eth_adapter *priv =
+			ENETC_DEV_PRIVATE(dev->data->dev_private);
+	struct enetc_bdr *tx_ring;
+	uint32_t tx_data;
+
+	PMD_INIT_FUNC_TRACE();
+	tx_ring = dev->data->tx_queues[qidx];
+	if (dev->data->tx_queue_state[qidx] == RTE_ETH_QUEUE_STATE_STARTED) {
+		tx_data = enetc4_txbdr_rd(&priv->hw.hw, tx_ring->index,
+					 ENETC_TBMR);
+		tx_data = tx_data & (~ENETC_TBMR_EN);
+		enetc4_txbdr_wr(&priv->hw.hw, tx_ring->index, ENETC_TBMR,
+			       tx_data);
+		dev->data->tx_queue_state[qidx] = RTE_ETH_QUEUE_STATE_STOPPED;
+	}
+
+	return 0;
+}
 
 /*
  * The set of PCI devices this driver supports
@@ -190,6 +583,14 @@ static const struct eth_dev_ops enetc4_ops = {
 	.dev_stop             = enetc4_dev_stop,
 	.dev_close            = enetc4_dev_close,
 	.dev_infos_get        = enetc4_dev_infos_get,
+	.rx_queue_setup       = enetc4_rx_queue_setup,
+	.rx_queue_start       = enetc4_rx_queue_start,
+	.rx_queue_stop        = enetc4_rx_queue_stop,
+	.rx_queue_release     = enetc4_rx_queue_release,
+	.tx_queue_setup       = enetc4_tx_queue_setup,
+	.tx_queue_start       = enetc4_tx_queue_start,
+	.tx_queue_stop        = enetc4_tx_queue_stop,
+	.tx_queue_release     = enetc4_tx_queue_release,
 };
 
 /*
diff --git a/drivers/net/enetc/enetc4_vf.c b/drivers/net/enetc/enetc4_vf.c
index 7996d6decb..0c68229a8d 100644
--- a/drivers/net/enetc/enetc4_vf.c
+++ b/drivers/net/enetc/enetc4_vf.c
@@ -41,6 +41,14 @@ static const struct eth_dev_ops enetc4_vf_ops = {
 	.dev_stop             = enetc4_vf_dev_stop,
 	.dev_close            = enetc4_dev_close,
 	.dev_infos_get        = enetc4_dev_infos_get,
+	.rx_queue_setup       = enetc4_rx_queue_setup,
+	.rx_queue_start       = enetc4_rx_queue_start,
+	.rx_queue_stop        = enetc4_rx_queue_stop,
+	.rx_queue_release     = enetc4_rx_queue_release,
+	.tx_queue_setup       = enetc4_tx_queue_setup,
+	.tx_queue_start       = enetc4_tx_queue_start,
+	.tx_queue_stop        = enetc4_tx_queue_stop,
+	.tx_queue_release     = enetc4_tx_queue_release,
 };
 
 static int
diff --git a/drivers/net/enetc/enetc_rxtx.c b/drivers/net/enetc/enetc_rxtx.c
index ea64c9f682..1fc5f11339 100644
--- a/drivers/net/enetc/enetc_rxtx.c
+++ b/drivers/net/enetc/enetc_rxtx.c
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2018-2020 NXP
+ * Copyright 2018-2024 NXP
  */
 
 #include <stdbool.h>
@@ -11,6 +11,7 @@
 #include "rte_memzone.h"
 
 #include "base/enetc_hw.h"
+#include "base/enetc4_hw.h"
 #include "enetc.h"
 #include "enetc_logs.h"
 
@@ -85,6 +86,12 @@ enetc_xmit_pkts(void *tx_queue,
 	int i, start, bds_to_use;
 	struct enetc_tx_bd *txbd;
 	struct enetc_bdr *tx_ring = (struct enetc_bdr *)tx_queue;
+	unsigned short buflen;
+	uint8_t *data;
+	int j;
+
+	struct enetc_eth_hw *hw =
+			ENETC_DEV_PRIVATE_TO_HW(tx_ring->ndev->data->dev_private);
 
 	i = tx_ring->next_to_use;
 
@@ -95,6 +102,13 @@ enetc_xmit_pkts(void *tx_queue,
 	start = 0;
 	while (nb_pkts--) {
 		tx_ring->q_swbd[i].buffer_addr = tx_pkts[start];
+
+		if (hw->device_id == ENETC4_DEV_ID || hw->device_id == ENETC4_DEV_ID_VF) {
+			buflen = rte_pktmbuf_pkt_len(tx_ring->q_swbd[i].buffer_addr);
+			data = rte_pktmbuf_mtod(tx_ring->q_swbd[i].buffer_addr, void *);
+			for (j = 0; j <= buflen; j += RTE_CACHE_LINE_SIZE)
+				dcbf(data + j);
+		}
 		txbd = ENETC_TXBD(*tx_ring, i);
 		tx_swbd = &tx_ring->q_swbd[i];
 		txbd->frm_len = tx_pkts[start]->pkt_len;
@@ -326,6 +340,12 @@ enetc_clean_rx_ring(struct enetc_bdr *rx_ring,
 	int cleaned_cnt, i, bd_count;
 	struct enetc_swbd *rx_swbd;
 	union enetc_rx_bd *rxbd;
+	uint32_t bd_status;
+	uint8_t *data;
+	uint32_t j;
+	struct enetc_eth_hw *hw =
+			ENETC_DEV_PRIVATE_TO_HW(rx_ring->ndev->data->dev_private);
+
 
 	/* next descriptor to process */
 	i = rx_ring->next_to_clean;
@@ -351,9 +371,8 @@ enetc_clean_rx_ring(struct enetc_bdr *rx_ring,
 
 	cleaned_cnt = enetc_bd_unused(rx_ring);
 	rx_swbd = &rx_ring->q_swbd[i];
-	while (likely(rx_frm_cnt < work_limit)) {
-		uint32_t bd_status;
 
+	while (likely(rx_frm_cnt < work_limit)) {
 		bd_status = rte_le_to_cpu_32(rxbd->r.lstatus);
 		if (!bd_status)
 			break;
@@ -366,6 +385,13 @@ enetc_clean_rx_ring(struct enetc_bdr *rx_ring,
 		rx_swbd->buffer_addr->ol_flags = 0;
 		enetc_dev_rx_parse(rx_swbd->buffer_addr,
 				   rxbd->r.parse_summary);
+
+		if (hw->device_id == ENETC4_DEV_ID || hw->device_id == ENETC4_DEV_ID_VF) {
+			data = rte_pktmbuf_mtod(rx_swbd->buffer_addr, void *);
+			for (j = 0; j <= rx_swbd->buffer_addr->pkt_len; j += RTE_CACHE_LINE_SIZE)
+				dccivac(data + j);
+		}
+
 		rx_pkts[rx_frm_cnt] = rx_swbd->buffer_addr;
 		cleaned_cnt++;
 		rx_swbd++;
-- 
2.25.1

