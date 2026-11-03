Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63860606EEBE
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mTf6v8hP
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF028427CA;
	Tue,  3 Nov 2026 16:13:57 +0100 (CET)
Received: from mta0.migadu.com (out-43.mta0.migadu.com [91.218.175.43])
 by mails.dpdk.org (Postfix) with ESMTPS id 904E540653
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:13:56 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=V8vrjM5wXG+Qgb/8nHwYvR6htUI1HAngOuTExE/8NII=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718836; v=1; x=1794323636;
 b=mTf6v8hParvwBflXjg0fi//wDT8pLIcxpCryO3BmjEpRriKzAff2dSW/mpK+CO2PKbRc9c4E
 Ehsn2AsAF4baF2Hjhe8bwb30Ok4yW+Y5Oy6bLHTk2C/ZsG6Fa97aYXmEqNqGDJRpXu9N+PQ61TB
 YSqZfln7XluJ3yjDs1KFbq0c=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id c291727a1f12e040;
 Tue, 03 Nov 2026 15:13:56 +0000
X-Mizu-Trace-ID: c291727a1f12e040
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 132/227] net/netvsc: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:30 +0800
Message-ID: <20261103145306.487255-133-chengwen.feng@linux.dev>
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
 drivers/net/netvsc/hn_ethdev.c |  6 +++---
 drivers/net/netvsc/hn_rxtx.c   | 30 +++++++++++++++---------------
 drivers/net/netvsc/hn_var.h    | 10 +++++-----
 drivers/net/netvsc/hn_vf.c     |  8 ++++----
 4 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethdev.c
index 5dc91f9503..ae21ade424 100644
--- a/drivers/net/netvsc/hn_ethdev.c
+++ b/drivers/net/netvsc/hn_ethdev.c
@@ -163,7 +163,7 @@ eth_dev_vmbus_allocate(struct rte_vmbus_device *dev, size_t private_data_size)
 
 		if (private_data_size) {
 			eth_dev->data->dev_private =
-				rte_zmalloc_socket(name, private_data_size,
+				rte_zmalloc_numa(name, private_data_size,
 						     RTE_CACHE_LINE_SIZE, dev->device.numa_node);
 			if (!eth_dev->data->dev_private) {
 				PMD_DRV_LOG(NOTICE, "can not allocate driver data");
@@ -1987,7 +1987,7 @@ static int netvsc_init_once(void)
 	switch (rte_eal_process_type()) {
 	case RTE_PROC_PRIMARY:
 		netvsc_shared_mz = rte_memzone_reserve(MZ_NETVSC_SHARED_DATA,
-				sizeof(*netvsc_shared_data), SOCKET_ID_ANY, 0);
+				sizeof(*netvsc_shared_data), RTE_NUMA_ID_ANY, 0);
 		if (!netvsc_shared_mz) {
 			PMD_DRV_LOG(ERR, "Cannot allocate netvsc shared data");
 			return -rte_errno;
@@ -2091,7 +2091,7 @@ static int eth_hn_probe(struct rte_vmbus_driver *drv __rte_unused,
 		goto vmbus_alloc_failed;
 	}
 
-	process_priv = rte_zmalloc_socket("netvsc_proc_priv",
+	process_priv = rte_zmalloc_numa("netvsc_proc_priv",
 					  sizeof(struct hn_nvs_process_priv),
 					  RTE_CACHE_LINE_SIZE,
 					  dev->device.numa_node);
diff --git a/drivers/net/netvsc/hn_rxtx.c b/drivers/net/netvsc/hn_rxtx.c
index 7987b70ce5..e18fb64f2e 100644
--- a/drivers/net/netvsc/hn_rxtx.c
+++ b/drivers/net/netvsc/hn_rxtx.c
@@ -236,7 +236,7 @@ hn_rx_queue_free_common(struct hn_rx_queue *rxq)
 int
 hn_dev_tx_queue_setup(struct rte_eth_dev *dev,
 		      uint16_t queue_idx, uint16_t nb_desc,
-		      unsigned int socket_id,
+		      unsigned int numa_id,
 		      const struct rte_eth_txconf *tx_conf)
 
 {
@@ -263,8 +263,8 @@ hn_dev_tx_queue_setup(struct rte_eth_dev *dev,
 		return -EINVAL;
 	}
 
-	txq = rte_zmalloc_socket("HN_TXQ", sizeof(*txq), RTE_CACHE_LINE_SIZE,
-				 socket_id);
+	txq = rte_zmalloc_numa("HN_TXQ", sizeof(*txq), RTE_CACHE_LINE_SIZE,
+				 numa_id);
 	if (!txq)
 		return -ENOMEM;
 
@@ -281,7 +281,7 @@ hn_dev_tx_queue_setup(struct rte_eth_dev *dev,
 		     name, nb_desc, sizeof(struct hn_txdesc));
 
 	txq->tx_rndis_mz = rte_memzone_reserve_aligned(name,
-			nb_desc * HN_RNDIS_PKT_ALIGNED, rte_socket_id(),
+			nb_desc * HN_RNDIS_PKT_ALIGNED, rte_numa_id(),
 			RTE_MEMZONE_IOVA_CONTIG, HN_RNDIS_PKT_ALIGNED);
 	if (!txq->tx_rndis_mz) {
 		err = -rte_errno;
@@ -307,7 +307,7 @@ hn_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	 * received
 	 */
 	if (queue_idx >= dev->data->nb_rx_queues) {
-		rxq = hn_rx_queue_alloc(hv, queue_idx, socket_id);
+		rxq = hn_rx_queue_alloc(hv, queue_idx, numa_id);
 
 		if (!rxq) {
 			err = -ENOMEM;
@@ -329,7 +329,7 @@ hn_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	hn_reset_txagg(txq);
 
 	err = hn_vf_tx_queue_setup(dev, queue_idx, nb_desc,
-				     socket_id, tx_conf);
+				     numa_id, tx_conf);
 	if (err == 0) {
 		dev->data->tx_queues[queue_idx] = txq;
 		if (rxq != NULL)
@@ -906,12 +906,12 @@ static void hn_nvs_handle_notify(struct rte_eth_dev *dev,
 
 struct hn_rx_queue *hn_rx_queue_alloc(struct hn_data *hv,
 				      uint16_t queue_id,
-				      unsigned int socket_id)
+				      unsigned int numa_id)
 {
 	struct hn_rx_queue *rxq;
 
-	rxq = rte_zmalloc_socket("HN_RXQ", sizeof(*rxq),
-				 RTE_CACHE_LINE_SIZE, socket_id);
+	rxq = rte_zmalloc_numa("HN_RXQ", sizeof(*rxq),
+				 RTE_CACHE_LINE_SIZE, numa_id);
 	if (!rxq)
 		return NULL;
 
@@ -921,8 +921,8 @@ struct hn_rx_queue *hn_rx_queue_alloc(struct hn_data *hv,
 	rxq->port_id = hv->port_id;
 	rxq->queue_id = queue_id;
 	rxq->event_sz = HN_RXQ_EVENT_DEFAULT;
-	rxq->event_buf = rte_malloc_socket("HN_EVENTS", HN_RXQ_EVENT_DEFAULT,
-					   RTE_CACHE_LINE_SIZE, socket_id);
+	rxq->event_buf = rte_malloc_numa("HN_EVENTS", HN_RXQ_EVENT_DEFAULT,
+					   RTE_CACHE_LINE_SIZE, numa_id);
 	if (!rxq->event_buf) {
 		rte_free(rxq);
 		return NULL;
@@ -962,7 +962,7 @@ hn_dev_rx_queue_info(struct rte_eth_dev *dev, uint16_t queue_id,
 int
 hn_dev_rx_queue_setup(struct rte_eth_dev *dev,
 		      uint16_t queue_idx, uint16_t nb_desc,
-		      unsigned int socket_id,
+		      unsigned int numa_id,
 		      const struct rte_eth_rxconf *rx_conf,
 		      struct rte_mempool *mp)
 {
@@ -982,7 +982,7 @@ hn_dev_rx_queue_setup(struct rte_eth_dev *dev,
 		 * number of Rx queues, we may already have allocated an rxq.
 		 */
 		if (!dev->data->rx_queues[queue_idx])
-			rxq = hn_rx_queue_alloc(hv, queue_idx, socket_id);
+			rxq = hn_rx_queue_alloc(hv, queue_idx, numa_id);
 		else
 			rxq = dev->data->rx_queues[queue_idx];
 
@@ -1004,12 +1004,12 @@ hn_dev_rx_queue_setup(struct rte_eth_dev *dev,
 		 "hn_rx_%u_%u", dev->data->port_id, queue_idx);
 	rxq->rx_ring = rte_ring_create(ring_name,
 				       rte_align32pow2(nb_desc),
-				       socket_id, 0);
+				       numa_id, 0);
 	if (!rxq->rx_ring)
 		goto fail;
 
 	error = hn_vf_rx_queue_setup(dev, queue_idx, nb_desc,
-				     socket_id, rx_conf, mp);
+				     numa_id, rx_conf, mp);
 	if (error)
 		goto fail;
 
diff --git a/drivers/net/netvsc/hn_var.h b/drivers/net/netvsc/hn_var.h
index 7d9a950816..ad6180ef09 100644
--- a/drivers/net/netvsc/hn_var.h
+++ b/drivers/net/netvsc/hn_var.h
@@ -205,7 +205,7 @@ int	hn_chim_init(struct rte_eth_dev *dev);
 void	hn_chim_uninit(struct rte_eth_dev *dev);
 int	hn_dev_link_update(struct rte_eth_dev *dev, int wait);
 int	hn_dev_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
-			      uint16_t nb_desc, unsigned int socket_id,
+			      uint16_t nb_desc, unsigned int numa_id,
 			      const struct rte_eth_txconf *tx_conf);
 void	hn_dev_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid);
 void	hn_dev_tx_queue_info(struct rte_eth_dev *dev, uint16_t queue_idx,
@@ -215,10 +215,10 @@ int	hn_dev_tx_descriptor_status(void *arg, uint16_t offset);
 
 struct hn_rx_queue *hn_rx_queue_alloc(struct hn_data *hv,
 				      uint16_t queue_id,
-				      unsigned int socket_id);
+				      unsigned int numa_id);
 int	hn_dev_rx_queue_setup(struct rte_eth_dev *dev,
 			      uint16_t queue_idx, uint16_t nb_desc,
-			      unsigned int socket_id,
+			      unsigned int numa_id,
 			      const struct rte_eth_rxconf *rx_conf,
 			      struct rte_mempool *mp);
 void	hn_dev_rx_queue_info(struct rte_eth_dev *dev, uint16_t queue_id,
@@ -263,14 +263,14 @@ int	hn_vf_mc_addr_list(struct rte_eth_dev *dev,
 
 int	hn_vf_tx_queue_setup(struct rte_eth_dev *dev,
 			     uint16_t queue_idx, uint16_t nb_desc,
-			     unsigned int socket_id,
+			     unsigned int numa_id,
 			     const struct rte_eth_txconf *tx_conf);
 void	hn_vf_tx_queue_release(struct hn_data *hv, uint16_t queue_id);
 int	hn_vf_tx_queue_status(struct hn_data *hv, uint16_t queue_id, uint16_t offset);
 
 int	hn_vf_rx_queue_setup(struct rte_eth_dev *dev,
 			     uint16_t queue_idx, uint16_t nb_desc,
-			     unsigned int socket_id,
+			     unsigned int numa_id,
 			     const struct rte_eth_rxconf *rx_conf,
 			     struct rte_mempool *mp);
 void	hn_vf_rx_queue_release(struct hn_data *hv, uint16_t queue_id);
diff --git a/drivers/net/netvsc/hn_vf.c b/drivers/net/netvsc/hn_vf.c
index 96e811278a..f226acfedb 100644
--- a/drivers/net/netvsc/hn_vf.c
+++ b/drivers/net/netvsc/hn_vf.c
@@ -848,7 +848,7 @@ int hn_vf_mc_addr_list(struct rte_eth_dev *dev,
 
 int hn_vf_tx_queue_setup(struct rte_eth_dev *dev,
 			 uint16_t queue_idx, uint16_t nb_desc,
-			 unsigned int socket_id,
+			 unsigned int numa_id,
 			 const struct rte_eth_txconf *tx_conf)
 {
 	struct hn_data *hv = dev->data->dev_private;
@@ -860,7 +860,7 @@ int hn_vf_tx_queue_setup(struct rte_eth_dev *dev,
 	if (vf_dev)
 		ret = rte_eth_tx_queue_setup(vf_dev->data->port_id,
 					     queue_idx, nb_desc,
-					     socket_id, tx_conf);
+					     numa_id, tx_conf);
 	rte_rwlock_read_unlock(&hv->vf_lock);
 	return ret;
 }
@@ -881,7 +881,7 @@ void hn_vf_tx_queue_release(struct hn_data *hv, uint16_t queue_id)
 
 int hn_vf_rx_queue_setup(struct rte_eth_dev *dev,
 			 uint16_t queue_idx, uint16_t nb_desc,
-			 unsigned int socket_id,
+			 unsigned int numa_id,
 			 const struct rte_eth_rxconf *rx_conf,
 			 struct rte_mempool *mp)
 {
@@ -894,7 +894,7 @@ int hn_vf_rx_queue_setup(struct rte_eth_dev *dev,
 	if (vf_dev)
 		ret = rte_eth_rx_queue_setup(vf_dev->data->port_id,
 					     queue_idx, nb_desc,
-					     socket_id, rx_conf, mp);
+					     numa_id, rx_conf, mp);
 	rte_rwlock_read_unlock(&hv->vf_lock);
 	return ret;
 }
-- 
2.55.0

