Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DDD606A785
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BMyHBlKw
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F63542E65;
	Tue,  3 Nov 2026 16:11:20 +0100 (CET)
Received: from mta1.migadu.com (out-145.mta1.migadu.com [95.215.58.145])
 by mails.dpdk.org (Postfix) with ESMTPS id E486E42E5E
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:11:18 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=v1EZGWblW3TNZa4QOY8EIyWd5OPKp7oglA23b+2dy/4=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718678; v=1; x=1794323478;
 b=BMyHBlKwjN6qpQ47xv9lPeUGjz7jA2icQ0mZ5vlMfPs4AbCvLpKknbEDgG85liAqO/uvCTYg
 dkngRfSVC7fovrVFsyvFmfazcMMjre9IrSDVs0xgR54BlGmQkNYM07J0r1NCpLX1ud56dQnZ1Mz
 EPW4dBF1aQcmi6P3cDdfDgKo=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id b59bafd14c77e6b8;
 Tue, 03 Nov 2026 15:11:18 +0000
X-Mizu-Trace-ID: b59bafd14c77e6b8
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 112/227] net/cxgbe: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:10 +0800
Message-ID: <20261103145306.487255-113-chengwen.feng@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103145306.487255-1-chengwen.feng@linux.dev>
References: <20261103145306.487255-1-chengwen.feng@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chengwen Feng <fengchengwen@huawei.com>

Rename socket_id parameters, internal structure fields, variables
and comments to the NUMA node terminology, and switch calls to
the NUMA-named APIs.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/net/cxgbe/base/adapter.h |  6 +++---
 drivers/net/cxgbe/cxgbe_ethdev.c | 16 ++++++++--------
 drivers/net/cxgbe/cxgbe_main.c   | 18 +++++++++---------
 drivers/net/cxgbe/cxgbe_pfvf.h   |  4 ++--
 drivers/net/cxgbe/cxgbevf_main.c |  4 ++--
 drivers/net/cxgbe/sge.c          | 28 ++++++++++++++--------------
 6 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/net/cxgbe/base/adapter.h b/drivers/net/cxgbe/base/adapter.h
index 207f3ecb88..bdeeadbddf 100644
--- a/drivers/net/cxgbe/base/adapter.h
+++ b/drivers/net/cxgbe/base/adapter.h
@@ -759,15 +759,15 @@ int t4_sge_init(struct adapter *adap);
 int t4vf_sge_init(struct adapter *adap);
 int t4_sge_alloc_eth_txq(struct adapter *adap, struct sge_eth_txq *txq,
 			 struct rte_eth_dev *eth_dev, uint16_t queue_id,
-			 unsigned int iqid, int socket_id);
+			 unsigned int iqid, int numa_id);
 int t4_sge_alloc_ctrl_txq(struct adapter *adap, struct sge_ctrl_txq *txq,
 			  struct rte_eth_dev *eth_dev, uint16_t queue_id,
-			  unsigned int iqid, int socket_id);
+			  unsigned int iqid, int numa_id);
 int t4_sge_alloc_rxq(struct adapter *adap, struct sge_rspq *rspq, bool fwevtq,
 		     struct rte_eth_dev *eth_dev, int intr_idx,
 		     struct sge_fl *fl, rspq_handler_t handler,
 		     int cong, struct rte_mempool *mp, int queue_id,
-		     int socket_id);
+		     int numa_id);
 int t4_sge_eth_txq_start(struct sge_eth_txq *txq);
 int t4_sge_eth_txq_stop(struct sge_eth_txq *txq);
 void t4_sge_eth_txq_release(struct adapter *adap, struct sge_eth_txq *txq);
diff --git a/drivers/net/cxgbe/cxgbe_ethdev.c b/drivers/net/cxgbe/cxgbe_ethdev.c
index 93554f354c..0d427663db 100644
--- a/drivers/net/cxgbe/cxgbe_ethdev.c
+++ b/drivers/net/cxgbe/cxgbe_ethdev.c
@@ -501,7 +501,7 @@ int cxgbe_dev_tx_queue_stop(struct rte_eth_dev *eth_dev, uint16_t tx_queue_id)
 
 int cxgbe_dev_tx_queue_setup(struct rte_eth_dev *eth_dev,
 			     uint16_t queue_idx, uint16_t nb_desc,
-			     unsigned int socket_id,
+			     unsigned int numa_id,
 			     const struct rte_eth_txconf *tx_conf __rte_unused)
 {
 	struct port_info *pi = eth_dev->data->dev_private;
@@ -512,9 +512,9 @@ int cxgbe_dev_tx_queue_setup(struct rte_eth_dev *eth_dev,
 	int err = 0;
 
 	txq = &s->ethtxq[pi->first_txqset + queue_idx];
-	dev_debug(adapter, "%s: eth_dev->data->nb_tx_queues = %d; queue_idx = %d; nb_desc = %d; socket_id = %d; pi->first_qset = %u\n",
+	dev_debug(adapter, "%s: eth_dev->data->nb_tx_queues = %d; queue_idx = %d; nb_desc = %d; numa_id = %d; pi->first_qset = %u\n",
 		  __func__, eth_dev->data->nb_tx_queues, queue_idx, nb_desc,
-		  socket_id, pi->first_txqset);
+		  numa_id, pi->first_txqset);
 
 	/*  Free up the existing queue  */
 	if (eth_dev->data->tx_queues[queue_idx]) {
@@ -544,7 +544,7 @@ int cxgbe_dev_tx_queue_setup(struct rte_eth_dev *eth_dev,
 	txq->q.size = temp_nb_desc;
 
 	err = t4_sge_alloc_eth_txq(adapter, txq, eth_dev, queue_idx,
-				   s->fw_evtq.cntxt_id, socket_id);
+				   s->fw_evtq.cntxt_id, numa_id);
 
 	dev_debug(adapter, "%s: txq->q.cntxt_id= %u txq->q.abs_id= %u err = %d\n",
 		  __func__, txq->q.cntxt_id, txq->q.abs_id, err);
@@ -605,7 +605,7 @@ int cxgbe_dev_rx_queue_stop(struct rte_eth_dev *eth_dev, uint16_t rx_queue_id)
 
 int cxgbe_dev_rx_queue_setup(struct rte_eth_dev *eth_dev,
 			     uint16_t queue_idx, uint16_t nb_desc,
-			     unsigned int socket_id,
+			     unsigned int numa_id,
 			     const struct rte_eth_rxconf *rx_conf __rte_unused,
 			     struct rte_mempool *mp)
 {
@@ -620,9 +620,9 @@ int cxgbe_dev_rx_queue_setup(struct rte_eth_dev *eth_dev,
 	struct sge_eth_rxq *rxq;
 
 	rxq = &s->ethrxq[pi->first_rxqset + queue_idx];
-	dev_debug(adapter, "%s: eth_dev->data->nb_rx_queues = %d; queue_idx = %d; nb_desc = %d; socket_id = %d; mp = %p\n",
+	dev_debug(adapter, "%s: eth_dev->data->nb_rx_queues = %d; queue_idx = %d; nb_desc = %d; numa_id = %d; mp = %p\n",
 		  __func__, eth_dev->data->nb_rx_queues, queue_idx, nb_desc,
-		  socket_id, mp);
+		  numa_id, mp);
 
 	err = cxgbe_dev_info_get(eth_dev, &dev_info);
 	if (err != 0) {
@@ -672,7 +672,7 @@ int cxgbe_dev_rx_queue_setup(struct rte_eth_dev *eth_dev,
 			       &rxq->fl, NULL,
 			       is_pf4(adapter) ?
 			       t4_get_tp_ch_map(adapter, pi->tx_chan) : 0, mp,
-			       queue_idx, socket_id);
+			       queue_idx, numa_id);
 
 	dev_debug(adapter, "%s: err = %d; port_id = %d; cntxt_id = %u; abs_id = %u\n",
 		  __func__, err, pi->port_id, rxq->rspq.cntxt_id,
diff --git a/drivers/net/cxgbe/cxgbe_main.c b/drivers/net/cxgbe/cxgbe_main.c
index 2ed21f2d66..9adbc82d69 100644
--- a/drivers/net/cxgbe/cxgbe_main.c
+++ b/drivers/net/cxgbe/cxgbe_main.c
@@ -208,7 +208,7 @@ int cxgbe_setup_sge_ctrl_txq(struct adapter *adapter)
 		err = t4_sge_alloc_ctrl_txq(adapter, q,
 					    adapter->eth_dev,  i,
 					    s->fw_evtq.cntxt_id,
-					    rte_socket_id());
+					    rte_numa_id());
 		if (err) {
 			dev_err(adapter, "Failed to alloc ctrl txq. Err: %d",
 				err);
@@ -221,7 +221,7 @@ int cxgbe_setup_sge_ctrl_txq(struct adapter *adapter)
 						     RTE_CACHE_LINE_SIZE,
 						     RTE_MBUF_PRIV_ALIGN,
 						     RTE_MBUF_DEFAULT_BUF_SIZE,
-						     SOCKET_ID_ANY);
+						     RTE_NUMA_ID_ANY);
 		if (!q->mb_pool) {
 			err = -rte_errno;
 			dev_err(adapter,
@@ -276,7 +276,7 @@ int cxgbe_setup_sge_fwevtq(struct adapter *adapter)
 
 	err = t4_sge_alloc_rxq(adapter, &s->fw_evtq, true, adapter->eth_dev,
 			       msi_idx, NULL, fwevtq_handler, -1, NULL, 0,
-			       rte_socket_id());
+			       rte_numa_id());
 	return err;
 }
 
@@ -605,15 +605,15 @@ int cxgbe_cfg_queues(struct rte_eth_dev *eth_dev)
 	u16 i;
 
 	if (!(adap->flags & CFG_QUEUES)) {
-		s->ethrxq = rte_calloc_socket(NULL, s->max_ethqsets,
+		s->ethrxq = rte_calloc_numa(NULL, s->max_ethqsets,
 					      sizeof(struct sge_eth_rxq), 0,
-					      rte_socket_id());
+					      rte_numa_id());
 		if (!s->ethrxq)
 			return -ENOMEM;
 
-		s->ethtxq = rte_calloc_socket(NULL, s->max_ethqsets,
+		s->ethtxq = rte_calloc_numa(NULL, s->max_ethqsets,
 					      sizeof(struct sge_eth_txq), 0,
-					      rte_socket_id());
+					      rte_numa_id());
 		if (!s->ethtxq) {
 			rte_free(s->ethrxq);
 			s->ethrxq = NULL;
@@ -2239,7 +2239,7 @@ int cxgbe_probe(struct adapter *adapter)
 	}
 
 	for_each_port(adapter, i) {
-		const unsigned int numa_node = rte_socket_id();
+		const unsigned int numa_node = rte_numa_id();
 		char name[RTE_ETH_NAME_MAX_LEN];
 		struct rte_eth_dev *eth_dev;
 
@@ -2263,7 +2263,7 @@ int cxgbe_probe(struct adapter *adapter)
 			goto out_free;
 
 		eth_dev->data->dev_private =
-			rte_zmalloc_socket(name, sizeof(struct port_info),
+			rte_zmalloc_numa(name, sizeof(struct port_info),
 					   RTE_CACHE_LINE_SIZE, numa_node);
 		if (!eth_dev->data->dev_private)
 			goto out_free;
diff --git a/drivers/net/cxgbe/cxgbe_pfvf.h b/drivers/net/cxgbe/cxgbe_pfvf.h
index 11e95b5836..fd90b96784 100644
--- a/drivers/net/cxgbe/cxgbe_pfvf.h
+++ b/drivers/net/cxgbe/cxgbe_pfvf.h
@@ -29,10 +29,10 @@ int cxgbe_dev_allmulticast_disable(struct rte_eth_dev *eth_dev);
 int cxgbe_mac_addr_set(struct rte_eth_dev *dev, struct rte_ether_addr *addr);
 int cxgbe_dev_configure(struct rte_eth_dev *eth_dev);
 int cxgbe_dev_tx_queue_setup(struct rte_eth_dev *eth_dev, uint16_t queue_idx,
-			     uint16_t nb_desc, unsigned int socket_id,
+			     uint16_t nb_desc, unsigned int numa_id,
 			     const struct rte_eth_txconf *tx_conf);
 int cxgbe_dev_rx_queue_setup(struct rte_eth_dev *eth_dev, uint16_t queue_idx,
-			     uint16_t nb_desc, unsigned int socket_id,
+			     uint16_t nb_desc, unsigned int numa_id,
 			     const struct rte_eth_rxconf *rx_conf,
 			     struct rte_mempool *mp);
 int cxgbe_dev_tx_queue_start(struct rte_eth_dev *eth_dev,
diff --git a/drivers/net/cxgbe/cxgbevf_main.c b/drivers/net/cxgbe/cxgbevf_main.c
index d0c93f8ac3..cc77730f6e 100644
--- a/drivers/net/cxgbe/cxgbevf_main.c
+++ b/drivers/net/cxgbe/cxgbevf_main.c
@@ -201,7 +201,7 @@ int cxgbevf_probe(struct adapter *adapter)
 
 	pmask = adapter->params.vfres.pmask;
 	for_each_port(adapter, i) {
-		const unsigned int numa_node = rte_socket_id();
+		const unsigned int numa_node = rte_numa_id();
 		char name[RTE_ETH_NAME_MAX_LEN];
 		struct rte_eth_dev *eth_dev;
 		int port_id;
@@ -232,7 +232,7 @@ int cxgbevf_probe(struct adapter *adapter)
 			goto out_free;
 		}
 		eth_dev->data->dev_private =
-			rte_zmalloc_socket(name, sizeof(struct port_info),
+			rte_zmalloc_numa(name, sizeof(struct port_info),
 					   RTE_CACHE_LINE_SIZE, numa_node);
 		if (!eth_dev->data->dev_private)
 			goto out_free;
diff --git a/drivers/net/cxgbe/sge.c b/drivers/net/cxgbe/sge.c
index b8dac0c46e..044fd7118f 100644
--- a/drivers/net/cxgbe/sge.c
+++ b/drivers/net/cxgbe/sge.c
@@ -1366,7 +1366,7 @@ int t4_mgmt_tx(struct sge_ctrl_txq *q, struct rte_mbuf *mbuf)
  * @dev: the port associated with the queue
  * @z_name: memzone's name
  * @queue_id: queue index
- * @socket_id: preferred socket id for memory allocations
+ * @numa_id: preferred socket id for memory allocations
  * @nelem: the number of descriptors
  * @elem_size: the size of each descriptor
  * @stat_size: extra space in HW ring for status information
@@ -1383,7 +1383,7 @@ int t4_mgmt_tx(struct sge_ctrl_txq *q, struct rte_mbuf *mbuf)
  * of the SW ring.
  */
 static void *alloc_ring(struct rte_eth_dev *dev, const char *z_name,
-			uint16_t queue_id, int socket_id, size_t nelem,
+			uint16_t queue_id, int numa_id, size_t nelem,
 			size_t elem_size, size_t stat_size, size_t sw_size,
 			dma_addr_t *phys, void *metadata)
 {
@@ -1396,9 +1396,9 @@ static void *alloc_ring(struct rte_eth_dev *dev, const char *z_name,
 		 dev->data->port_id, queue_id, z_name);
 
 	dev_debug(adapter, "%s: nelem = %zu; elem_size = %zu; sw_size = %zu; "
-		  "stat_size = %zu; queue_id = %u; socket_id = %d; z_name = %s;"
+		  "stat_size = %zu; queue_id = %u; numa_id = %d; z_name = %s;"
 		  " z_name_sw = %s\n", __func__, nelem, elem_size, sw_size,
-		  stat_size, queue_id, socket_id, z_name, z_name_sw);
+		  stat_size, queue_id, numa_id, z_name, z_name_sw);
 
 	/*
 	 * Allocate TX/RX ring hardware descriptors. A memzone large enough to
@@ -1406,14 +1406,14 @@ static void *alloc_ring(struct rte_eth_dev *dev, const char *z_name,
 	 * resizing in later calls to the queue setup function.
 	 */
 	tz = rte_eth_dma_zone_reserve(dev, z_name, queue_id, len, 4096,
-				      socket_id);
+				      numa_id);
 	if (!tz)
 		return NULL;
 
 	memset(tz->addr, 0, len);
 	if (sw_size) {
-		s = rte_zmalloc_socket(z_name_sw, nelem * sw_size,
-				       RTE_CACHE_LINE_SIZE, socket_id);
+		s = rte_zmalloc_numa(z_name_sw, nelem * sw_size,
+				       RTE_CACHE_LINE_SIZE, numa_id);
 
 		if (!s) {
 			dev_err(adapter, "%s: failed to get sw_ring memory\n",
@@ -1756,7 +1756,7 @@ static int cxgbe_sge_fl_buf_size_index(const struct adapter *adap,
 int t4_sge_alloc_rxq(struct adapter *adap, struct sge_rspq *iq, bool fwevtq,
 		     struct rte_eth_dev *eth_dev, int intr_idx,
 		     struct sge_fl *fl, rspq_handler_t hnd, int cong,
-		     struct rte_mempool *mp, int queue_id, int socket_id)
+		     struct rte_mempool *mp, int queue_id, int numa_id)
 {
 	struct port_info *pi = eth_dev->data->dev_private;
 	u8 pciechan, fl_buf_size_idx = 0;
@@ -1777,7 +1777,7 @@ int t4_sge_alloc_rxq(struct adapter *adap, struct sge_rspq *iq, bool fwevtq,
 	iq->size = cxgbe_roundup(iq->size, 16);
 
 	iq->desc = alloc_ring(eth_dev, fwevtq ? "fwq_ring" : "rx_ring",
-			      queue_id, socket_id, iq->size, iq->iqe_len,
+			      queue_id, numa_id, iq->size, iq->iqe_len,
 			      0, 0, &iq->phys_addr, NULL);
 	if (!iq->desc)
 		return -ENOMEM;
@@ -1834,7 +1834,7 @@ int t4_sge_alloc_rxq(struct adapter *adap, struct sge_rspq *iq, bool fwevtq,
 			fl->size = s->fl_starve_thres - 1 + 2 * 8;
 		fl->size = cxgbe_roundup(fl->size, 8);
 
-		fl->desc = alloc_ring(eth_dev, "fl_ring", queue_id, socket_id,
+		fl->desc = alloc_ring(eth_dev, "fl_ring", queue_id, numa_id,
 				      fl->size, sizeof(__be64), s->stat_len,
 				      sizeof(struct rx_sw_desc),
 				      &fl->addr, &fl->sdesc);
@@ -2019,7 +2019,7 @@ int t4_sge_eth_txq_stop(struct sge_eth_txq *txq)
 
 int t4_sge_alloc_eth_txq(struct adapter *adap, struct sge_eth_txq *txq,
 			 struct rte_eth_dev *eth_dev, uint16_t queue_id,
-			 unsigned int iqid, int socket_id)
+			 unsigned int iqid, int numa_id)
 {
 	int ret, nentries;
 	struct fw_eq_eth_cmd c;
@@ -2030,7 +2030,7 @@ int t4_sge_alloc_eth_txq(struct adapter *adap, struct sge_eth_txq *txq,
 	/* Add status entries */
 	nentries = txq->q.size + s->stat_len / sizeof(struct tx_desc);
 
-	txq->q.desc = alloc_ring(eth_dev, "tx_ring", queue_id, socket_id,
+	txq->q.desc = alloc_ring(eth_dev, "tx_ring", queue_id, numa_id,
 				 txq->q.size, sizeof(struct tx_desc),
 				 s->stat_len, sizeof(struct tx_sw_desc),
 				 &txq->q.phys_addr, &txq->q.sdesc);
@@ -2092,7 +2092,7 @@ int t4_sge_alloc_eth_txq(struct adapter *adap, struct sge_eth_txq *txq,
 
 int t4_sge_alloc_ctrl_txq(struct adapter *adap, struct sge_ctrl_txq *txq,
 			  struct rte_eth_dev *eth_dev, uint16_t queue_id,
-			  unsigned int iqid, int socket_id)
+			  unsigned int iqid, int numa_id)
 {
 	int ret, nentries;
 	struct fw_eq_ctrl_cmd c;
@@ -2103,7 +2103,7 @@ int t4_sge_alloc_ctrl_txq(struct adapter *adap, struct sge_ctrl_txq *txq,
 	nentries = txq->q.size + s->stat_len / sizeof(struct tx_desc);
 
 	txq->q.desc = alloc_ring(eth_dev, "ctrl_tx_ring", queue_id,
-				 socket_id, txq->q.size, sizeof(struct tx_desc),
+				 numa_id, txq->q.size, sizeof(struct tx_desc),
 				 0, 0, &txq->q.phys_addr, NULL);
 	if (!txq->q.desc)
 		return -ENOMEM;
-- 
2.55.0

