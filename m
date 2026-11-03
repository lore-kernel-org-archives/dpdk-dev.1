Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAFA606D81C
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=o2z5rTk0
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20D5142EE0;
	Tue,  3 Nov 2026 16:16:05 +0100 (CET)
Received: from mta0.migadu.com (out-116.mta0.migadu.com [91.218.175.116])
 by mails.dpdk.org (Postfix) with ESMTPS id 8223942EC5
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:16:03 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=AasUtPM03/xRhMsLEt7pcKjzomfTbp4Ej6R6g0G6QAY=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718963; v=1; x=1794323763;
 b=o2z5rTk062iffQX5NY/fsbqKr8/46Vhsqd7mNZDsJSfnEVLRGXmXaLwk9cqKtvoafkwKO3d3
 gzNuvc9i3BIW53etqg9LL7pUANndnk5rfJZSay+1zKHWxXJRCs8jUdVbC5Z4pp/BM/k+0Iw58GV
 Lr06IyBOvoDga0gS1Q8nOhdU=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 736770b946f3ed06;
 Tue, 03 Nov 2026 15:16:03 +0000
X-Mizu-Trace-ID: 736770b946f3ed06
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 146/227] net/sfc: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:44 +0800
Message-ID: <20261103145306.487255-147-chengwen.feng@linux.dev>
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
 drivers/net/sfc/sfc.c              | 20 ++++++++++----------
 drivers/net/sfc/sfc.h              |  4 ++--
 drivers/net/sfc/sfc_dp_rx.h        |  4 ++--
 drivers/net/sfc/sfc_dp_tx.h        |  4 ++--
 drivers/net/sfc/sfc_ef100_rx.c     | 10 +++++-----
 drivers/net/sfc/sfc_ef100_tx.c     | 10 +++++-----
 drivers/net/sfc/sfc_ef10_essb_rx.c | 10 +++++-----
 drivers/net/sfc/sfc_ef10_rx.c      | 10 +++++-----
 drivers/net/sfc/sfc_ef10_tx.c      | 14 +++++++-------
 drivers/net/sfc/sfc_ethdev.c       | 16 ++++++++--------
 drivers/net/sfc/sfc_ev.c           | 10 +++++-----
 drivers/net/sfc/sfc_ev.h           |  2 +-
 drivers/net/sfc/sfc_mae.c          |  2 +-
 drivers/net/sfc/sfc_mae_counter.c  | 26 +++++++++++++-------------
 drivers/net/sfc/sfc_mcdi.c         |  2 +-
 drivers/net/sfc/sfc_port.c         | 10 +++++-----
 drivers/net/sfc/sfc_repr.c         | 20 ++++++++++----------
 drivers/net/sfc/sfc_repr_proxy.c   | 18 +++++++++---------
 drivers/net/sfc/sfc_rx.c           | 26 +++++++++++++-------------
 drivers/net/sfc/sfc_rx.h           |  2 +-
 drivers/net/sfc/sfc_service.c      | 22 +++++++++++-----------
 drivers/net/sfc/sfc_service.h      |  2 +-
 drivers/net/sfc/sfc_sw_stats.c     |  4 ++--
 drivers/net/sfc/sfc_tso.c          |  6 +++---
 drivers/net/sfc/sfc_tx.c           | 28 ++++++++++++++--------------
 drivers/net/sfc/sfc_tx.h           |  4 ++--
 26 files changed, 143 insertions(+), 143 deletions(-)

diff --git a/drivers/net/sfc/sfc.c b/drivers/net/sfc/sfc.c
index f13c5e2460..2281d5ebc3 100644
--- a/drivers/net/sfc/sfc.c
+++ b/drivers/net/sfc/sfc.c
@@ -36,12 +36,12 @@ sfc_repr_supported(const struct sfc_adapter *sa)
 
 	/*
 	 * Representor proxy should use service lcore on PF's socket
-	 * (sa->socket_id) to be efficient. But the proxy will fall back
+	 * (sa->numa_id) to be efficient. But the proxy will fall back
 	 * to any socket if it is not possible to get the service core
 	 * on the same socket. Check that at least service core on any
 	 * socket is available.
 	 */
-	if (sfc_get_service_lcore(SOCKET_ID_ANY) == RTE_MAX_LCORE)
+	if (sfc_get_service_lcore(RTE_NUMA_ID_ANY) == RTE_MAX_LCORE)
 		return false;
 
 	return true;
@@ -55,20 +55,20 @@ sfc_repr_available(const struct sfc_adapter_shared *sas)
 
 int
 sfc_dma_alloc(struct sfc_adapter *sa, const char *name, uint16_t id,
-	      efx_nic_dma_addr_type_t addr_type, size_t len, int socket_id,
+	      efx_nic_dma_addr_type_t addr_type, size_t len, int numa_id,
 	      efsys_mem_t *esmp)
 {
 	const struct rte_memzone *mz;
 	int rc;
 
-	sfc_log_init(sa, "name=%s id=%u len=%zu socket_id=%d",
-		     name, id, len, socket_id);
+	sfc_log_init(sa, "name=%s id=%u len=%zu numa_id=%d",
+		     name, id, len, numa_id);
 
 	mz = rte_eth_dma_zone_reserve(sa->eth_dev, name, id, len,
-				      sysconf(_SC_PAGESIZE), socket_id);
+				      sysconf(_SC_PAGESIZE), numa_id);
 	if (mz == NULL) {
 		sfc_err(sa, "cannot reserve DMA zone for %s:%u %#x@%d: %s",
-			name, (unsigned int)id, (unsigned int)len, socket_id,
+			name, (unsigned int)id, (unsigned int)len, numa_id,
 			rte_strerror(rte_errno));
 		return ENOMEM;
 	}
@@ -87,8 +87,8 @@ sfc_dma_alloc(struct sfc_adapter *sa, const char *name, uint16_t id,
 	esmp->esm_base = mz->addr;
 
 	sfc_info(sa,
-		 "DMA name=%s id=%u len=%lu socket_id=%d => virt=%p iova=%lx",
-		 name, id, len, socket_id, esmp->esm_base,
+		 "DMA name=%s id=%u len=%lu numa_id=%d => virt=%p iova=%lx",
+		 name, id, len, numa_id, esmp->esm_base,
 		 (unsigned long)esmp->esm_addr);
 
 	return 0;
@@ -1292,7 +1292,7 @@ sfc_probe(struct sfc_adapter *sa)
 
 	SFC_ASSERT(sfc_adapter_is_locked(sa));
 
-	sa->socket_id = rte_socket_id();
+	sa->numa_id = rte_numa_id();
 	sa->restart_required = false;
 
 	sfc_log_init(sa, "get family");
diff --git a/drivers/net/sfc/sfc.h b/drivers/net/sfc/sfc.h
index 510790a5f6..c6137d206a 100644
--- a/drivers/net/sfc/sfc.h
+++ b/drivers/net/sfc/sfc.h
@@ -251,7 +251,7 @@ struct sfc_adapter {
 	enum sfc_ethdev_state		state;
 	struct rte_eth_dev		*eth_dev;
 	struct rte_kvargs		*kvargs;
-	int				socket_id;
+	int				numa_id;
 	efsys_bar_t			mem_bar;
 	/* Function control window offset */
 	efsys_dma_addr_t		fcw_offset;
@@ -399,7 +399,7 @@ sfc_get_system_msecs(void)
 }
 
 int sfc_dma_alloc(struct sfc_adapter *sa, const char *name, uint16_t id,
-		  efx_nic_dma_addr_type_t addr_type, size_t len, int socket_id,
+		  efx_nic_dma_addr_type_t addr_type, size_t len, int numa_id,
 		  efsys_mem_t *esmp);
 void sfc_dma_free(const struct sfc_adapter *sa, efsys_mem_t *esmp);
 
diff --git a/drivers/net/sfc/sfc_dp_rx.h b/drivers/net/sfc/sfc_dp_rx.h
index ed667c68d1..edcf93a16d 100644
--- a/drivers/net/sfc/sfc_dp_rx.h
+++ b/drivers/net/sfc/sfc_dp_rx.h
@@ -147,7 +147,7 @@ typedef int (sfc_dp_rx_qsize_up_rings_t)(uint16_t nb_rx_desc,
  * @param port_id	The port identifier
  * @param queue_id	The queue identifier
  * @param pci_addr	PCI function address
- * @param socket_id	Socket identifier to allocate memory
+ * @param numa_id	Socket identifier to allocate memory
  * @param info		Receive queue information
  * @param dp_rxqp	Location for generic datapath receive queue pointer
  *
@@ -155,7 +155,7 @@ typedef int (sfc_dp_rx_qsize_up_rings_t)(uint16_t nb_rx_desc,
  */
 typedef int (sfc_dp_rx_qcreate_t)(uint16_t port_id, uint16_t queue_id,
 				  const struct rte_pci_addr *pci_addr,
-				  int socket_id,
+				  int numa_id,
 				  const struct sfc_dp_rx_qcreate_info *info,
 				  struct sfc_dp_rxq **dp_rxqp);
 
diff --git a/drivers/net/sfc/sfc_dp_tx.h b/drivers/net/sfc/sfc_dp_tx.h
index 0baf8c7dd6..8c3ea29393 100644
--- a/drivers/net/sfc/sfc_dp_tx.h
+++ b/drivers/net/sfc/sfc_dp_tx.h
@@ -119,7 +119,7 @@ typedef int (sfc_dp_tx_qsize_up_rings_t)(uint16_t nb_tx_desc,
  * @param port_id	The port identifier
  * @param queue_id	The queue identifier
  * @param pci_addr	PCI function address
- * @param socket_id	Socket identifier to allocate memory
+ * @param numa_id	Socket identifier to allocate memory
  * @param info		Tx queue details wrapped in structure
  * @param dp_txqp	Location for generic datapath transmit queue pointer
  *
@@ -127,7 +127,7 @@ typedef int (sfc_dp_tx_qsize_up_rings_t)(uint16_t nb_tx_desc,
  */
 typedef int (sfc_dp_tx_qcreate_t)(uint16_t port_id, uint16_t queue_id,
 				  const struct rte_pci_addr *pci_addr,
-				  int socket_id,
+				  int numa_id,
 				  const struct sfc_dp_tx_qcreate_info *info,
 				  struct sfc_dp_txq **dp_txqp);
 
diff --git a/drivers/net/sfc/sfc_ef100_rx.c b/drivers/net/sfc/sfc_ef100_rx.c
index e283879e6b..dec7220b7c 100644
--- a/drivers/net/sfc/sfc_ef100_rx.c
+++ b/drivers/net/sfc/sfc_ef100_rx.c
@@ -767,7 +767,7 @@ sfc_ef100_mk_mbuf_rearm_data(uint16_t port_id, uint16_t prefix_size)
 static sfc_dp_rx_qcreate_t sfc_ef100_rx_qcreate;
 static int
 sfc_ef100_rx_qcreate(uint16_t port_id, uint16_t queue_id,
-		    const struct rte_pci_addr *pci_addr, int socket_id,
+		    const struct rte_pci_addr *pci_addr, int numa_id,
 		    const struct sfc_dp_rx_qcreate_info *info,
 		    struct sfc_dp_rxq **dp_rxqp)
 {
@@ -779,18 +779,18 @@ sfc_ef100_rx_qcreate(uint16_t port_id, uint16_t queue_id,
 		goto fail_rxq_args;
 
 	rc = ENOMEM;
-	rxq = rte_zmalloc_socket("sfc-ef100-rxq", sizeof(*rxq),
-				 RTE_CACHE_LINE_SIZE, socket_id);
+	rxq = rte_zmalloc_numa("sfc-ef100-rxq", sizeof(*rxq),
+				 RTE_CACHE_LINE_SIZE, numa_id);
 	if (rxq == NULL)
 		goto fail_rxq_alloc;
 
 	sfc_dp_queue_init(&rxq->dp.dpq, port_id, queue_id, pci_addr);
 
 	rc = ENOMEM;
-	rxq->sw_ring = rte_calloc_socket("sfc-ef100-rxq-sw_ring",
+	rxq->sw_ring = rte_calloc_numa("sfc-ef100-rxq-sw_ring",
 					 info->rxq_entries,
 					 sizeof(*rxq->sw_ring),
-					 RTE_CACHE_LINE_SIZE, socket_id);
+					 RTE_CACHE_LINE_SIZE, numa_id);
 	if (rxq->sw_ring == NULL)
 		goto fail_desc_alloc;
 
diff --git a/drivers/net/sfc/sfc_ef100_tx.c b/drivers/net/sfc/sfc_ef100_tx.c
index c88ab96454..20ef9d01bc 100644
--- a/drivers/net/sfc/sfc_ef100_tx.c
+++ b/drivers/net/sfc/sfc_ef100_tx.c
@@ -834,7 +834,7 @@ sfc_ef100_tx_qsize_up_rings(uint16_t nb_tx_desc,
 static sfc_dp_tx_qcreate_t sfc_ef100_tx_qcreate;
 static int
 sfc_ef100_tx_qcreate(uint16_t port_id, uint16_t queue_id,
-		    const struct rte_pci_addr *pci_addr, int socket_id,
+		    const struct rte_pci_addr *pci_addr, int numa_id,
 		    const struct sfc_dp_tx_qcreate_info *info,
 		    struct sfc_dp_txq **dp_txqp)
 {
@@ -846,18 +846,18 @@ sfc_ef100_tx_qcreate(uint16_t port_id, uint16_t queue_id,
 		goto fail_bad_args;
 
 	rc = ENOMEM;
-	txq = rte_zmalloc_socket("sfc-ef100-txq", sizeof(*txq),
-				 RTE_CACHE_LINE_SIZE, socket_id);
+	txq = rte_zmalloc_numa("sfc-ef100-txq", sizeof(*txq),
+				 RTE_CACHE_LINE_SIZE, numa_id);
 	if (txq == NULL)
 		goto fail_txq_alloc;
 
 	sfc_dp_queue_init(&txq->dp.dpq, port_id, queue_id, pci_addr);
 
 	rc = ENOMEM;
-	txq->sw_ring = rte_calloc_socket("sfc-ef100-txq-sw_ring",
+	txq->sw_ring = rte_calloc_numa("sfc-ef100-txq-sw_ring",
 					 info->txq_entries,
 					 sizeof(*txq->sw_ring),
-					 RTE_CACHE_LINE_SIZE, socket_id);
+					 RTE_CACHE_LINE_SIZE, numa_id);
 	if (txq->sw_ring == NULL)
 		goto fail_sw_ring_alloc;
 
diff --git a/drivers/net/sfc/sfc_ef10_essb_rx.c b/drivers/net/sfc/sfc_ef10_essb_rx.c
index 6b31cb55d0..bc17abd4c2 100644
--- a/drivers/net/sfc/sfc_ef10_essb_rx.c
+++ b/drivers/net/sfc/sfc_ef10_essb_rx.c
@@ -564,7 +564,7 @@ sfc_ef10_essb_rx_qsize_up_rings(uint16_t nb_rx_desc,
 static sfc_dp_rx_qcreate_t sfc_ef10_essb_rx_qcreate;
 static int
 sfc_ef10_essb_rx_qcreate(uint16_t port_id, uint16_t queue_id,
-			 const struct rte_pci_addr *pci_addr, int socket_id,
+			 const struct rte_pci_addr *pci_addr, int numa_id,
 			 const struct sfc_dp_rx_qcreate_info *info,
 			 struct sfc_dp_rxq **dp_rxqp)
 {
@@ -590,18 +590,18 @@ sfc_ef10_essb_rx_qcreate(uint16_t port_id, uint16_t queue_id,
 		goto fail_no_block_dequeue;
 
 	rc = ENOMEM;
-	rxq = rte_zmalloc_socket("sfc-ef10-rxq", sizeof(*rxq),
-				 RTE_CACHE_LINE_SIZE, socket_id);
+	rxq = rte_zmalloc_numa("sfc-ef10-rxq", sizeof(*rxq),
+				 RTE_CACHE_LINE_SIZE, numa_id);
 	if (rxq == NULL)
 		goto fail_rxq_alloc;
 
 	sfc_dp_queue_init(&rxq->dp.dpq, port_id, queue_id, pci_addr);
 
 	rc = ENOMEM;
-	rxq->sw_ring = rte_calloc_socket("sfc-ef10-rxq-sw_ring",
+	rxq->sw_ring = rte_calloc_numa("sfc-ef10-rxq-sw_ring",
 					 info->rxq_entries,
 					 sizeof(*rxq->sw_ring),
-					 RTE_CACHE_LINE_SIZE, socket_id);
+					 RTE_CACHE_LINE_SIZE, numa_id);
 	if (rxq->sw_ring == NULL)
 		goto fail_desc_alloc;
 
diff --git a/drivers/net/sfc/sfc_ef10_rx.c b/drivers/net/sfc/sfc_ef10_rx.c
index 60442930b3..938d6a516f 100644
--- a/drivers/net/sfc/sfc_ef10_rx.c
+++ b/drivers/net/sfc/sfc_ef10_rx.c
@@ -640,7 +640,7 @@ sfc_ef10_mk_mbuf_rearm_data(uint16_t port_id, uint16_t prefix_size)
 static sfc_dp_rx_qcreate_t sfc_ef10_rx_qcreate;
 static int
 sfc_ef10_rx_qcreate(uint16_t port_id, uint16_t queue_id,
-		    const struct rte_pci_addr *pci_addr, int socket_id,
+		    const struct rte_pci_addr *pci_addr, int numa_id,
 		    const struct sfc_dp_rx_qcreate_info *info,
 		    struct sfc_dp_rxq **dp_rxqp)
 {
@@ -656,18 +656,18 @@ sfc_ef10_rx_qcreate(uint16_t port_id, uint16_t queue_id,
 		goto fail_nic_dma;
 
 	rc = ENOMEM;
-	rxq = rte_zmalloc_socket("sfc-ef10-rxq", sizeof(*rxq),
-				 RTE_CACHE_LINE_SIZE, socket_id);
+	rxq = rte_zmalloc_numa("sfc-ef10-rxq", sizeof(*rxq),
+				 RTE_CACHE_LINE_SIZE, numa_id);
 	if (rxq == NULL)
 		goto fail_rxq_alloc;
 
 	sfc_dp_queue_init(&rxq->dp.dpq, port_id, queue_id, pci_addr);
 
 	rc = ENOMEM;
-	rxq->sw_ring = rte_calloc_socket("sfc-ef10-rxq-sw_ring",
+	rxq->sw_ring = rte_calloc_numa("sfc-ef10-rxq-sw_ring",
 					 info->rxq_entries,
 					 sizeof(*rxq->sw_ring),
-					 RTE_CACHE_LINE_SIZE, socket_id);
+					 RTE_CACHE_LINE_SIZE, numa_id);
 	if (rxq->sw_ring == NULL)
 		goto fail_desc_alloc;
 
diff --git a/drivers/net/sfc/sfc_ef10_tx.c b/drivers/net/sfc/sfc_ef10_tx.c
index 5543dc495f..b11dfb4357 100644
--- a/drivers/net/sfc/sfc_ef10_tx.c
+++ b/drivers/net/sfc/sfc_ef10_tx.c
@@ -933,7 +933,7 @@ sfc_ef10_tx_qsize_up_rings(uint16_t nb_tx_desc,
 static sfc_dp_tx_qcreate_t sfc_ef10_tx_qcreate;
 static int
 sfc_ef10_tx_qcreate(uint16_t port_id, uint16_t queue_id,
-		    const struct rte_pci_addr *pci_addr, int socket_id,
+		    const struct rte_pci_addr *pci_addr, int numa_id,
 		    const struct sfc_dp_tx_qcreate_info *info,
 		    struct sfc_dp_txq **dp_txqp)
 {
@@ -949,29 +949,29 @@ sfc_ef10_tx_qcreate(uint16_t port_id, uint16_t queue_id,
 		goto fail_nic_dma;
 
 	rc = ENOMEM;
-	txq = rte_zmalloc_socket("sfc-ef10-txq", sizeof(*txq),
-				 RTE_CACHE_LINE_SIZE, socket_id);
+	txq = rte_zmalloc_numa("sfc-ef10-txq", sizeof(*txq),
+				 RTE_CACHE_LINE_SIZE, numa_id);
 	if (txq == NULL)
 		goto fail_txq_alloc;
 
 	sfc_dp_queue_init(&txq->dp.dpq, port_id, queue_id, pci_addr);
 
 	rc = ENOMEM;
-	txq->sw_ring = rte_calloc_socket("sfc-ef10-txq-sw_ring",
+	txq->sw_ring = rte_calloc_numa("sfc-ef10-txq-sw_ring",
 					 info->txq_entries,
 					 sizeof(*txq->sw_ring),
-					 RTE_CACHE_LINE_SIZE, socket_id);
+					 RTE_CACHE_LINE_SIZE, numa_id);
 	if (txq->sw_ring == NULL)
 		goto fail_sw_ring_alloc;
 
 	if (info->offloads & (RTE_ETH_TX_OFFLOAD_TCP_TSO |
 			      RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO |
 			      RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO)) {
-		txq->tsoh = rte_calloc_socket("sfc-ef10-txq-tsoh",
+		txq->tsoh = rte_calloc_numa("sfc-ef10-txq-tsoh",
 					      info->txq_entries,
 					      SFC_TSOH_STD_LEN,
 					      RTE_CACHE_LINE_SIZE,
-					      socket_id);
+					      numa_id);
 		if (txq->tsoh == NULL)
 			goto fail_tsoh_alloc;
 
diff --git a/drivers/net/sfc/sfc_ethdev.c b/drivers/net/sfc/sfc_ethdev.c
index 02231e4bce..9fe9c1eef8 100644
--- a/drivers/net/sfc/sfc_ethdev.c
+++ b/drivers/net/sfc/sfc_ethdev.c
@@ -633,7 +633,7 @@ sfc_dev_allmulti_disable(struct rte_eth_dev *dev)
 
 static int
 sfc_rx_queue_setup(struct rte_eth_dev *dev, uint16_t ethdev_qid,
-		   uint16_t nb_rx_desc, unsigned int socket_id,
+		   uint16_t nb_rx_desc, unsigned int numa_id,
 		   const struct rte_eth_rxconf *rx_conf,
 		   struct rte_mempool *mb_pool)
 {
@@ -644,13 +644,13 @@ sfc_rx_queue_setup(struct rte_eth_dev *dev, uint16_t ethdev_qid,
 	sfc_sw_index_t sw_index;
 	int rc;
 
-	sfc_log_init(sa, "RxQ=%u nb_rx_desc=%u socket_id=%u",
-		     ethdev_qid, nb_rx_desc, socket_id);
+	sfc_log_init(sa, "RxQ=%u nb_rx_desc=%u numa_id=%u",
+		     ethdev_qid, nb_rx_desc, numa_id);
 
 	sfc_adapter_lock(sa);
 
 	sw_index = sfc_rxq_sw_index_by_ethdev_rx_qid(sas, sfc_ethdev_qid);
-	rc = sfc_rx_qinit(sa, sw_index, nb_rx_desc, socket_id,
+	rc = sfc_rx_qinit(sa, sw_index, nb_rx_desc, numa_id,
 			  rx_conf, mb_pool);
 	if (rc != 0)
 		goto fail_rx_qinit;
@@ -694,7 +694,7 @@ sfc_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
 
 static int
 sfc_tx_queue_setup(struct rte_eth_dev *dev, uint16_t ethdev_qid,
-		   uint16_t nb_tx_desc, unsigned int socket_id,
+		   uint16_t nb_tx_desc, unsigned int numa_id,
 		   const struct rte_eth_txconf *tx_conf)
 {
 	struct sfc_adapter_shared *sas = sfc_adapter_shared_by_eth_dev(dev);
@@ -703,13 +703,13 @@ sfc_tx_queue_setup(struct rte_eth_dev *dev, uint16_t ethdev_qid,
 	sfc_sw_index_t sw_index;
 	int rc;
 
-	sfc_log_init(sa, "TxQ = %u, nb_tx_desc = %u, socket_id = %u",
-		     ethdev_qid, nb_tx_desc, socket_id);
+	sfc_log_init(sa, "TxQ = %u, nb_tx_desc = %u, numa_id = %u",
+		     ethdev_qid, nb_tx_desc, numa_id);
 
 	sfc_adapter_lock(sa);
 
 	sw_index = sfc_txq_sw_index_by_ethdev_tx_qid(sas, ethdev_qid);
-	rc = sfc_tx_qinit(sa, sw_index, nb_tx_desc, socket_id, tx_conf);
+	rc = sfc_tx_qinit(sa, sw_index, nb_tx_desc, numa_id, tx_conf);
 	if (rc != 0)
 		goto fail_tx_qinit;
 
diff --git a/drivers/net/sfc/sfc_ev.c b/drivers/net/sfc/sfc_ev.c
index f058b3cb9b..6c2938adeb 100644
--- a/drivers/net/sfc/sfc_ev.c
+++ b/drivers/net/sfc/sfc_ev.c
@@ -945,7 +945,7 @@ sfc_ev_stop(struct sfc_adapter *sa)
 int
 sfc_ev_qinit(struct sfc_adapter *sa,
 	     enum sfc_evq_type type, unsigned int type_index,
-	     unsigned int entries, int socket_id, struct sfc_evq **evqp)
+	     unsigned int entries, int numa_id, struct sfc_evq **evqp)
 {
 	struct sfc_evq *evq;
 	int rc;
@@ -956,8 +956,8 @@ sfc_ev_qinit(struct sfc_adapter *sa,
 	SFC_ASSERT(rte_is_power_of_2(entries));
 
 	rc = ENOMEM;
-	evq = rte_zmalloc_socket("sfc-evq", sizeof(*evq), RTE_CACHE_LINE_SIZE,
-				 socket_id);
+	evq = rte_zmalloc_numa("sfc-evq", sizeof(*evq), RTE_CACHE_LINE_SIZE,
+				 numa_id);
 	if (evq == NULL)
 		goto fail_evq_alloc;
 
@@ -969,7 +969,7 @@ sfc_ev_qinit(struct sfc_adapter *sa,
 	rc = sfc_dma_alloc(sa, sfc_evq_type2str(type), type_index,
 			   EFX_NIC_DMA_ADDR_EVENT_RING,
 			   efx_evq_size(sa->nic, evq->entries, sa->evq_flags),
-			   socket_id, &evq->mem);
+			   numa_id, &evq->mem);
 	if (rc != 0)
 		goto fail_dma_alloc;
 
@@ -1044,7 +1044,7 @@ sfc_ev_attach(struct sfc_adapter *sa)
 	rte_spinlock_init(&sa->mgmt_evq_lock);
 
 	rc = sfc_ev_qinit(sa, SFC_EVQ_TYPE_MGMT, 0, sa->evq_min_entries,
-			  sa->socket_id, &sa->mgmt_evq);
+			  sa->numa_id, &sa->mgmt_evq);
 	if (rc != 0)
 		goto fail_mgmt_evq_init;
 
diff --git a/drivers/net/sfc/sfc_ev.h b/drivers/net/sfc/sfc_ev.h
index a4ababc2bc..663a8d7153 100644
--- a/drivers/net/sfc/sfc_ev.h
+++ b/drivers/net/sfc/sfc_ev.h
@@ -214,7 +214,7 @@ void sfc_ev_stop(struct sfc_adapter *sa);
 
 int sfc_ev_qinit(struct sfc_adapter *sa,
 		 enum sfc_evq_type type, unsigned int type_index,
-		 unsigned int entries, int socket_id, struct sfc_evq **evqp);
+		 unsigned int entries, int numa_id, struct sfc_evq **evqp);
 void sfc_ev_qfini(struct sfc_evq *evq);
 int sfc_ev_qstart(struct sfc_evq *evq, unsigned int hw_index);
 void sfc_ev_qstop(struct sfc_evq *evq);
diff --git a/drivers/net/sfc/sfc_mae.c b/drivers/net/sfc/sfc_mae.c
index b0e8b02b41..4e9cc8e7a9 100644
--- a/drivers/net/sfc/sfc_mae.c
+++ b/drivers/net/sfc/sfc_mae.c
@@ -4418,7 +4418,7 @@ sfc_mae_rule_parse_action_count(struct sfc_adapter *sa,
 		goto fail_counter_queue_uninit;
 	}
 
-	if (sfc_get_service_lcore(SOCKET_ID_ANY) == RTE_MAX_LCORE) {
+	if (sfc_get_service_lcore(RTE_NUMA_ID_ANY) == RTE_MAX_LCORE) {
 		rc = EINVAL;
 		goto fail_no_service_core;
 	}
diff --git a/drivers/net/sfc/sfc_mae_counter.c b/drivers/net/sfc/sfc_mae_counter.c
index ba17295719..fc500527bc 100644
--- a/drivers/net/sfc/sfc_mae_counter.c
+++ b/drivers/net/sfc/sfc_mae_counter.c
@@ -47,19 +47,19 @@ sfc_mae_counter_get_service_lcore(struct sfc_adapter *sa)
 {
 	uint32_t cid;
 
-	cid = sfc_get_service_lcore(sa->socket_id);
+	cid = sfc_get_service_lcore(sa->numa_id);
 	if (cid != RTE_MAX_LCORE)
 		return cid;
 
-	if (sa->socket_id != SOCKET_ID_ANY)
-		cid = sfc_get_service_lcore(SOCKET_ID_ANY);
+	if (sa->numa_id != RTE_NUMA_ID_ANY)
+		cid = sfc_get_service_lcore(RTE_NUMA_ID_ANY);
 
 	if (cid == RTE_MAX_LCORE) {
 		sfc_warn(sa, "failed to get service lcore for counter service");
-	} else if (sa->socket_id != SOCKET_ID_ANY) {
+	} else if (sa->numa_id != RTE_NUMA_ID_ANY) {
 		sfc_warn(sa,
 			"failed to get service lcore for counter service at socket %d, but got at socket %u",
-			sa->socket_id, rte_lcore_to_socket_id(cid));
+			sa->numa_id, rte_lcore_to_numa_id(cid));
 	}
 	return cid;
 }
@@ -589,20 +589,20 @@ sfc_mae_counter_service_register(struct sfc_adapter *sa,
 	/* Prepare service info */
 	memset(&service, 0, sizeof(service));
 	rte_strscpy(service.name, counter_service_name, sizeof(service.name));
-	service.socket_id = sa->socket_id;
+	service.socket_id = sa->numa_id;
 	service.callback = sfc_mae_counter_service_routine;
 	service.callback_userdata = sa;
 	sfc_mae_counter_registry_prepare(counter_registry, sa,
 					 counter_stream_flags);
 
-	cid = sfc_get_service_lcore(sa->socket_id);
-	if (cid == RTE_MAX_LCORE && sa->socket_id != SOCKET_ID_ANY) {
+	cid = sfc_get_service_lcore(sa->numa_id);
+	if (cid == RTE_MAX_LCORE && sa->numa_id != RTE_NUMA_ID_ANY) {
 		/* Warn and try to allocate on any NUMA node */
 		sfc_warn(sa,
 			"failed to get service lcore for counter service at socket %d",
-			sa->socket_id);
+			sa->numa_id);
 
-		cid = sfc_get_service_lcore(SOCKET_ID_ANY);
+		cid = sfc_get_service_lcore(RTE_NUMA_ID_ANY);
 	}
 	if (cid == RTE_MAX_LCORE) {
 		rc = ENOTSUP;
@@ -795,7 +795,7 @@ sfc_mae_counter_rxq_attach(struct sfc_adapter *sa)
 	 * mempool backend is chosen since backend is unused.
 	 */
 	mp = rte_pktmbuf_pool_create(name, n_elements, cache_size,
-				     priv_size, data_room_size, sa->socket_id);
+				     priv_size, data_room_size, sa->numa_id);
 	if (mp == NULL) {
 		sfc_err(sa, "failed to create counter RxQ mempool");
 		rc = rte_errno;
@@ -873,7 +873,7 @@ sfc_mae_counter_rxq_init(struct sfc_adapter *sa)
 		goto fail_counter_rxq_init_info;
 
 	rc = sfc_rx_qinit(sa, sa->counter_rxq.sw_index, nb_rx_desc,
-			  sa->socket_id, &rxconf, sa->counter_rxq.mp);
+			  sa->numa_id, &rxconf, sa->counter_rxq.mp);
 	if (rc != 0) {
 		sfc_err(sa, "failed to init counter RxQ");
 		goto fail_counter_rxq_init;
@@ -1058,7 +1058,7 @@ bool
 sfc_mae_counter_stream_enabled(struct sfc_adapter *sa)
 {
 	if ((sa->counter_rxq.state & SFC_COUNTER_RXQ_INITIALIZED) == 0 ||
-	    sfc_get_service_lcore(SOCKET_ID_ANY) == RTE_MAX_LCORE)
+	    sfc_get_service_lcore(RTE_NUMA_ID_ANY) == RTE_MAX_LCORE)
 		return B_FALSE;
 	else
 		return B_TRUE;
diff --git a/drivers/net/sfc/sfc_mcdi.c b/drivers/net/sfc/sfc_mcdi.c
index 65e5e3817c..4dc6c32da6 100644
--- a/drivers/net/sfc/sfc_mcdi.c
+++ b/drivers/net/sfc/sfc_mcdi.c
@@ -22,7 +22,7 @@ sfc_mcdi_dma_alloc(void *cookie, const char *name, size_t len,
 	struct sfc_adapter *sa = cookie;
 
 	return sfc_dma_alloc(sa, name, 0, EFX_NIC_DMA_ADDR_MCDI_BUF, len,
-			     sa->socket_id, esmp);
+			     sa->numa_id, esmp);
 }
 
 static sfc_efx_mcdi_dma_free_cb sfc_mcdi_dma_free;
diff --git a/drivers/net/sfc/sfc_port.c b/drivers/net/sfc/sfc_port.c
index d84648d454..466bf23778 100644
--- a/drivers/net/sfc/sfc_port.c
+++ b/drivers/net/sfc/sfc_port.c
@@ -454,19 +454,19 @@ sfc_port_attach(struct sfc_adapter *sa)
 
 	port->max_mcast_addrs = EFX_MAC_MULTICAST_LIST_MAX;
 	port->nb_mcast_addrs = 0;
-	port->mcast_addrs = rte_calloc_socket("mcast_addr_list_buf",
+	port->mcast_addrs = rte_calloc_numa("mcast_addr_list_buf",
 					      port->max_mcast_addrs,
 					      EFX_MAC_ADDR_LEN, 0,
-					      sa->socket_id);
+					      sa->numa_id);
 	if (port->mcast_addrs == NULL) {
 		rc = ENOMEM;
 		goto fail_mcast_addr_list_buf_alloc;
 	}
 
 	rc = ENOMEM;
-	port->mac_stats_buf = rte_calloc_socket("mac_stats_buf", EFX_MAC_NSTATS,
+	port->mac_stats_buf = rte_calloc_numa("mac_stats_buf", EFX_MAC_NSTATS,
 						sizeof(uint64_t), 0,
-						sa->socket_id);
+						sa->numa_id);
 	if (port->mac_stats_buf == NULL)
 		goto fail_mac_stats_buf_alloc;
 
@@ -474,7 +474,7 @@ sfc_port_attach(struct sfc_adapter *sa)
 	mac_stats_size = RTE_ALIGN(mac_nstats * sizeof(uint64_t), EFX_BUF_SIZE);
 	rc = sfc_dma_alloc(sa, "mac_stats", 0, EFX_NIC_DMA_ADDR_MAC_STATS_BUF,
 			   mac_stats_size,
-			   sa->socket_id, &port->mac_stats_dma_mem);
+			   sa->numa_id, &port->mac_stats_dma_mem);
 	if (rc != 0)
 		goto fail_mac_stats_dma_alloc;
 
diff --git a/drivers/net/sfc/sfc_repr.c b/drivers/net/sfc/sfc_repr.c
index 629cb7af1c..3313cacba7 100644
--- a/drivers/net/sfc/sfc_repr.c
+++ b/drivers/net/sfc/sfc_repr.c
@@ -513,7 +513,7 @@ sfc_repr_dev_link_update(struct rte_eth_dev *dev,
 static int
 sfc_repr_ring_create(uint16_t pf_port_id, uint16_t repr_id,
 		     const char *type_name, uint16_t qid, uint16_t nb_desc,
-		     unsigned int socket_id, struct rte_ring **ring)
+		     unsigned int numa_id, struct rte_ring **ring)
 {
 	char ring_name[RTE_RING_NAMESIZE];
 	int ret;
@@ -529,7 +529,7 @@ sfc_repr_ring_create(uint16_t pf_port_id, uint16_t repr_id,
 	 * a single thread, and the user of the other end (representor proxy)
 	 * is also single-threaded.
 	 */
-	*ring = rte_ring_create(ring_name, nb_desc, socket_id,
+	*ring = rte_ring_create(ring_name, nb_desc, numa_id,
 			       RING_F_SP_ENQ | RING_F_SC_DEQ);
 	if (*ring == NULL)
 		return -rte_errno;
@@ -570,7 +570,7 @@ sfc_repr_rx_qcheck_conf(struct sfc_repr *sr,
 
 static int
 sfc_repr_rx_queue_setup(struct rte_eth_dev *dev, uint16_t rx_queue_id,
-			uint16_t nb_rx_desc, unsigned int socket_id,
+			uint16_t nb_rx_desc, unsigned int numa_id,
 			__rte_unused const struct rte_eth_rxconf *rx_conf,
 			struct rte_mempool *mb_pool)
 {
@@ -586,8 +586,8 @@ sfc_repr_rx_queue_setup(struct rte_eth_dev *dev, uint16_t rx_queue_id,
 		goto fail_check_conf;
 
 	ret = -ENOMEM;
-	rxq = rte_zmalloc_socket("sfc-repr-rxq", sizeof(*rxq),
-				 RTE_CACHE_LINE_SIZE, socket_id);
+	rxq = rte_zmalloc_numa("sfc-repr-rxq", sizeof(*rxq),
+				 RTE_CACHE_LINE_SIZE, numa_id);
 	if (rxq == NULL) {
 		sfcr_err(sr, "%s() failed to alloc RxQ", __func__);
 		goto fail_rxq_alloc;
@@ -595,7 +595,7 @@ sfc_repr_rx_queue_setup(struct rte_eth_dev *dev, uint16_t rx_queue_id,
 
 	ret = sfc_repr_ring_create(srs->pf_port_id, srs->repr_id,
 				   "rx", rx_queue_id, nb_rx_desc,
-				   socket_id, &rxq->ring);
+				   numa_id, &rxq->ring);
 	if (ret != 0) {
 		sfcr_err(sr, "%s() failed to create ring", __func__);
 		goto fail_ring_create;
@@ -672,7 +672,7 @@ sfc_repr_tx_qcheck_conf(struct sfc_repr *sr,
 
 static int
 sfc_repr_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
-			uint16_t nb_tx_desc, unsigned int socket_id,
+			uint16_t nb_tx_desc, unsigned int numa_id,
 			const struct rte_eth_txconf *tx_conf)
 {
 	struct sfc_repr_shared *srs = sfc_repr_shared_by_eth_dev(dev);
@@ -687,14 +687,14 @@ sfc_repr_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
 		goto fail_check_conf;
 
 	ret = -ENOMEM;
-	txq = rte_zmalloc_socket("sfc-repr-txq", sizeof(*txq),
-				 RTE_CACHE_LINE_SIZE, socket_id);
+	txq = rte_zmalloc_numa("sfc-repr-txq", sizeof(*txq),
+				 RTE_CACHE_LINE_SIZE, numa_id);
 	if (txq == NULL)
 		goto fail_txq_alloc;
 
 	ret = sfc_repr_ring_create(srs->pf_port_id, srs->repr_id,
 				   "tx", tx_queue_id, nb_tx_desc,
-				   socket_id, &txq->ring);
+				   numa_id, &txq->ring);
 	if (ret != 0)
 		goto fail_ring_create;
 
diff --git a/drivers/net/sfc/sfc_repr_proxy.c b/drivers/net/sfc/sfc_repr_proxy.c
index ff13795c97..3e9615911a 100644
--- a/drivers/net/sfc/sfc_repr_proxy.c
+++ b/drivers/net/sfc/sfc_repr_proxy.c
@@ -393,7 +393,7 @@ sfc_repr_proxy_txq_init(struct sfc_adapter *sa)
 		sfc_tx_qinit_info(sa, txq->sw_index);
 
 		rc = sfc_tx_qinit(sa, txq->sw_index,
-				  SFC_REPR_PROXY_TX_DESC_COUNT, sa->socket_id,
+				  SFC_REPR_PROXY_TX_DESC_COUNT, sa->numa_id,
 				  &tx_conf);
 
 		if (rc != 0) {
@@ -559,7 +559,7 @@ sfc_repr_proxy_rxq_init(struct sfc_adapter *sa,
 		goto fail_repr_rxq_init_info;
 	}
 
-	rc = sfc_rx_qinit(sa, rxq->sw_index, nb_rx_desc, sa->socket_id, &rxconf,
+	rc = sfc_rx_qinit(sa, rxq->sw_index, nb_rx_desc, sa->numa_id, &rxconf,
 			  rxq->mp);
 	if (rc != 0) {
 		sfc_err(sa, "failed to init representor proxy RxQ");
@@ -898,14 +898,14 @@ sfc_repr_proxy_attach(struct sfc_adapter *sa)
 	if (rc != 0)
 		goto fail_ports_init;
 
-	cid = sfc_get_service_lcore(sa->socket_id);
-	if (cid == RTE_MAX_LCORE && sa->socket_id != SOCKET_ID_ANY) {
+	cid = sfc_get_service_lcore(sa->numa_id);
+	if (cid == RTE_MAX_LCORE && sa->numa_id != RTE_NUMA_ID_ANY) {
 		/* Warn and try to allocate on any NUMA node */
 		sfc_warn(sa,
 			"repr proxy: unable to get service lcore at socket %d",
-			sa->socket_id);
+			sa->numa_id);
 
-		cid = sfc_get_service_lcore(SOCKET_ID_ANY);
+		cid = sfc_get_service_lcore(RTE_NUMA_ID_ANY);
 	}
 	if (cid == RTE_MAX_LCORE) {
 		rc = ENOTSUP;
@@ -916,7 +916,7 @@ sfc_repr_proxy_attach(struct sfc_adapter *sa)
 	memset(&service, 0, sizeof(service));
 	snprintf(service.name, sizeof(service.name),
 		 "net_sfc_%hu_repr_proxy", sfc_sa2shared(sa)->port_id);
-	service.socket_id = rte_lcore_to_socket_id(cid);
+	service.socket_id = rte_lcore_to_numa_id(cid);
 	service.callback = sfc_repr_proxy_routine;
 	service.callback_userdata = rp;
 
@@ -947,7 +947,7 @@ sfc_repr_proxy_attach(struct sfc_adapter *sa)
 fail_register:
 	/*
 	 * No need to rollback service lcore get since
-	 * it just makes socket_id based search and remembers it.
+	 * it just makes numa_id based search and remembers it.
 	 */
 
 fail_get_service_lcore:
@@ -1270,7 +1270,7 @@ sfc_repr_proxy_add_port(uint16_t pf_port_id, uint16_t repr_id,
 	}
 
 	port = rte_zmalloc("sfc-repr-proxy-port", sizeof(*port),
-			   sa->socket_id);
+			   sa->numa_id);
 	if (port == NULL) {
 		rc = ENOMEM;
 		sfc_err(sa, "failed to alloc memory for proxy port");
diff --git a/drivers/net/sfc/sfc_rx.c b/drivers/net/sfc/sfc_rx.c
index 70ad3bf00c..77f29da23f 100644
--- a/drivers/net/sfc/sfc_rx.c
+++ b/drivers/net/sfc/sfc_rx.c
@@ -477,7 +477,7 @@ sfc_efx_rx_qsize_up_rings(uint16_t nb_rx_desc,
 static sfc_dp_rx_qcreate_t sfc_efx_rx_qcreate;
 static int
 sfc_efx_rx_qcreate(uint16_t port_id, uint16_t queue_id,
-		   const struct rte_pci_addr *pci_addr, int socket_id,
+		   const struct rte_pci_addr *pci_addr, int numa_id,
 		   const struct sfc_dp_rx_qcreate_info *info,
 		   struct sfc_dp_rxq **dp_rxqp)
 {
@@ -489,18 +489,18 @@ sfc_efx_rx_qcreate(uint16_t port_id, uint16_t queue_id,
 		goto fail_nic_dma;
 
 	rc = ENOMEM;
-	rxq = rte_zmalloc_socket("sfc-efx-rxq", sizeof(*rxq),
-				 RTE_CACHE_LINE_SIZE, socket_id);
+	rxq = rte_zmalloc_numa("sfc-efx-rxq", sizeof(*rxq),
+				 RTE_CACHE_LINE_SIZE, numa_id);
 	if (rxq == NULL)
 		goto fail_rxq_alloc;
 
 	sfc_dp_queue_init(&rxq->dp.dpq, port_id, queue_id, pci_addr);
 
 	rc = ENOMEM;
-	rxq->sw_desc = rte_calloc_socket("sfc-efx-rxq-sw_desc",
+	rxq->sw_desc = rte_calloc_numa("sfc-efx-rxq-sw_desc",
 					 info->rxq_entries,
 					 sizeof(*rxq->sw_desc),
-					 RTE_CACHE_LINE_SIZE, socket_id);
+					 RTE_CACHE_LINE_SIZE, numa_id);
 	if (rxq->sw_desc == NULL)
 		goto fail_desc_alloc;
 
@@ -1098,7 +1098,7 @@ sfc_rx_mb_pool_buf_size(struct sfc_adapter *sa, struct rte_mempool *mb_pool)
 
 int
 sfc_rx_qinit(struct sfc_adapter *sa, sfc_sw_index_t sw_index,
-	     uint16_t nb_rx_desc, unsigned int socket_id,
+	     uint16_t nb_rx_desc, unsigned int numa_id,
 	     const struct rte_eth_rxconf *rx_conf,
 	     struct rte_mempool *mb_pool)
 {
@@ -1206,7 +1206,7 @@ sfc_rx_qinit(struct sfc_adapter *sa, sfc_sw_index_t sw_index,
 		rxq_info->type_flags |= EFX_RXQ_FLAG_VLAN_STRIPPED_TCI;
 
 	rc = sfc_ev_qinit(sa, SFC_EVQ_TYPE_RX, sw_index,
-			  evq_entries, socket_id, &evq);
+			  evq_entries, numa_id, &evq);
 	if (rc != 0)
 		goto fail_ev_qinit;
 
@@ -1247,7 +1247,7 @@ sfc_rx_qinit(struct sfc_adapter *sa, sfc_sw_index_t sw_index,
 
 	rc = sfc_dma_alloc(sa, "rxq", sw_index, EFX_NIC_DMA_ADDR_RX_RING,
 			   efx_rxq_size(sa->nic, rxq_info->entries),
-			   socket_id, &rxq->mem);
+			   numa_id, &rxq->mem);
 	if (rc != 0)
 		goto fail_dma_alloc;
 
@@ -1280,7 +1280,7 @@ sfc_rx_qinit(struct sfc_adapter *sa, sfc_sw_index_t sw_index,
 	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(sa->eth_dev, *pci_dev);
 	rc = sa->priv.dp_rx->qcreate(sa->eth_dev->data->port_id, sw_index,
 				     &pci_dev->addr,
-				     socket_id, &info, &rxq_info->dp);
+				     numa_id, &info, &rxq_info->dp);
 	if (rc != 0)
 		goto fail_dp_rx_qcreate;
 
@@ -1420,9 +1420,9 @@ sfc_rx_hash_init(struct sfc_adapter *sa)
 	if (rc != 0)
 		return rc;
 
-	hf_map = rte_calloc_socket("sfc-rss-hf-map",
+	hf_map = rte_calloc_numa("sfc-rss-hf-map",
 				   RTE_DIM(sfc_rss_hf_map),
-				   sizeof(*hf_map), 0, sa->socket_id);
+				   sizeof(*hf_map), 0, sa->numa_id);
 	if (hf_map == NULL)
 		return ENOMEM;
 
@@ -1755,9 +1755,9 @@ sfc_rx_configure(struct sfc_adapter *sa)
 	if (sas->rxq_info == NULL) {
 		reconfigure = false;
 		rc = ENOMEM;
-		sas->rxq_info = rte_calloc_socket("sfc-rxqs", nb_rxq_total,
+		sas->rxq_info = rte_calloc_numa("sfc-rxqs", nb_rxq_total,
 						  sizeof(sas->rxq_info[0]), 0,
-						  sa->socket_id);
+						  sa->numa_id);
 		if (sas->rxq_info == NULL)
 			goto fail_rxqs_alloc;
 
diff --git a/drivers/net/sfc/sfc_rx.h b/drivers/net/sfc/sfc_rx.h
index bd189e6a56..8f8948fa53 100644
--- a/drivers/net/sfc/sfc_rx.h
+++ b/drivers/net/sfc/sfc_rx.h
@@ -133,7 +133,7 @@ void sfc_rx_stop(struct sfc_adapter *sa);
 int sfc_rx_qinit_info(struct sfc_adapter *sa, sfc_sw_index_t sw_index,
 		      unsigned int extra_efx_type_flags);
 int sfc_rx_qinit(struct sfc_adapter *sa, unsigned int rx_queue_id,
-		 uint16_t nb_rx_desc, unsigned int socket_id,
+		 uint16_t nb_rx_desc, unsigned int numa_id,
 		 const struct rte_eth_rxconf *rx_conf,
 		 struct rte_mempool *mb_pool);
 void sfc_rx_qfini(struct sfc_adapter *sa, sfc_sw_index_t sw_index);
diff --git a/drivers/net/sfc/sfc_service.c b/drivers/net/sfc/sfc_service.c
index 9c89484406..50272666b8 100644
--- a/drivers/net/sfc/sfc_service.c
+++ b/drivers/net/sfc/sfc_service.c
@@ -27,7 +27,7 @@ RTE_INIT(sfc_service_lcore_init)
 }
 
 static uint32_t
-sfc_find_service_lcore(int *socket_id)
+sfc_find_service_lcore(int *numa_id)
 {
 	uint32_t service_core_list[RTE_MAX_LCORE];
 	uint32_t lcore_id;
@@ -50,18 +50,18 @@ sfc_find_service_lcore(int *socket_id)
 	for (i = 0; i < num; ++i) {
 		lcore_id = service_core_list[i];
 
-		if (*socket_id == SOCKET_ID_ANY) {
-			*socket_id = rte_lcore_to_socket_id(lcore_id);
+		if (*numa_id == RTE_NUMA_ID_ANY) {
+			*numa_id = rte_lcore_to_numa_id(lcore_id);
 			break;
-		} else if (rte_lcore_to_socket_id(lcore_id) ==
-			   (unsigned int)*socket_id) {
+		} else if (rte_lcore_to_numa_id(lcore_id) ==
+			   (unsigned int)*numa_id) {
 			break;
 		}
 	}
 
 	if (i == num) {
 		SFC_GENERIC_LOG(WARNING,
-			"No service cores reserved at socket %d", *socket_id);
+			"No service cores reserved at socket %d", *numa_id);
 		return RTE_MAX_LCORE;
 	}
 
@@ -69,14 +69,14 @@ sfc_find_service_lcore(int *socket_id)
 }
 
 uint32_t
-sfc_get_service_lcore(int socket_id)
+sfc_get_service_lcore(int numa_id)
 {
 	uint32_t lcore_id = RTE_MAX_LCORE;
 
 	rte_spinlock_lock(&sfc_service_lcore_lock);
 
-	if (socket_id != SOCKET_ID_ANY) {
-		lcore_id = sfc_service_lcore[socket_id];
+	if (numa_id != RTE_NUMA_ID_ANY) {
+		lcore_id = sfc_service_lcore[numa_id];
 	} else {
 		size_t i;
 
@@ -89,9 +89,9 @@ sfc_get_service_lcore(int socket_id)
 	}
 
 	if (lcore_id == RTE_MAX_LCORE) {
-		lcore_id = sfc_find_service_lcore(&socket_id);
+		lcore_id = sfc_find_service_lcore(&numa_id);
 		if (lcore_id != RTE_MAX_LCORE)
-			sfc_service_lcore[socket_id] = lcore_id;
+			sfc_service_lcore[numa_id] = lcore_id;
 	}
 
 	rte_spinlock_unlock(&sfc_service_lcore_lock);
diff --git a/drivers/net/sfc/sfc_service.h b/drivers/net/sfc/sfc_service.h
index bbcce28479..16ff71bca8 100644
--- a/drivers/net/sfc/sfc_service.h
+++ b/drivers/net/sfc/sfc_service.h
@@ -12,7 +12,7 @@
 extern "C" {
 #endif
 
-uint32_t sfc_get_service_lcore(int socket_id);
+uint32_t sfc_get_service_lcore(int numa_id);
 
 #ifdef __cplusplus
 }
diff --git a/drivers/net/sfc/sfc_sw_stats.c b/drivers/net/sfc/sfc_sw_stats.c
index 3ae5023b6f..3ec5fda291 100644
--- a/drivers/net/sfc/sfc_sw_stats.c
+++ b/drivers/net/sfc/sfc_sw_stats.c
@@ -831,8 +831,8 @@ sfc_sw_xstats_alloc_queues_bitmap(struct sfc_adapter *sa)
 	*queues_bitmap_mem = NULL;
 	*queues_bitmap = NULL;
 
-	*queues_bitmap_mem = rte_calloc_socket("bitmap_mem", bmp_size, 1, 0,
-					       sa->socket_id);
+	*queues_bitmap_mem = rte_calloc_numa("bitmap_mem", bmp_size, 1, 0,
+					       sa->numa_id);
 	if (*queues_bitmap_mem == NULL)
 		return ENOMEM;
 
diff --git a/drivers/net/sfc/sfc_tso.c b/drivers/net/sfc/sfc_tso.c
index a0827d1c0d..dfeb283cc8 100644
--- a/drivers/net/sfc/sfc_tso.c
+++ b/drivers/net/sfc/sfc_tso.c
@@ -18,15 +18,15 @@
 
 int
 sfc_efx_tso_alloc_tsoh_objs(struct sfc_efx_tx_sw_desc *sw_ring,
-			    unsigned int txq_entries, unsigned int socket_id)
+			    unsigned int txq_entries, unsigned int numa_id)
 {
 	unsigned int i;
 
 	for (i = 0; i < txq_entries; ++i) {
-		sw_ring[i].tsoh = rte_malloc_socket("sfc-efx-txq-tsoh-obj",
+		sw_ring[i].tsoh = rte_malloc_numa("sfc-efx-txq-tsoh-obj",
 						    SFC_TSOH_STD_LEN,
 						    RTE_CACHE_LINE_SIZE,
-						    socket_id);
+						    numa_id);
 		if (sw_ring[i].tsoh == NULL)
 			goto fail_alloc_tsoh_objs;
 	}
diff --git a/drivers/net/sfc/sfc_tx.c b/drivers/net/sfc/sfc_tx.c
index a860265c6a..b525793c9e 100644
--- a/drivers/net/sfc/sfc_tx.c
+++ b/drivers/net/sfc/sfc_tx.c
@@ -132,7 +132,7 @@ sfc_tx_qflush_done(struct sfc_txq_info *txq_info)
 
 int
 sfc_tx_qinit(struct sfc_adapter *sa, sfc_sw_index_t sw_index,
-	     uint16_t nb_tx_desc, unsigned int socket_id,
+	     uint16_t nb_tx_desc, unsigned int numa_id,
 	     const struct rte_eth_txconf *tx_conf)
 {
 	struct sfc_adapter_shared * const sas = sfc_sa2shared(sa);
@@ -182,7 +182,7 @@ sfc_tx_qinit(struct sfc_adapter *sa, sfc_sw_index_t sw_index,
 	txq_info->entries = txq_entries;
 
 	rc = sfc_ev_qinit(sa, SFC_EVQ_TYPE_TX, sw_index,
-			  evq_entries, socket_id, &evq);
+			  evq_entries, numa_id, &evq);
 	if (rc != 0)
 		goto fail_ev_qinit;
 
@@ -196,7 +196,7 @@ sfc_tx_qinit(struct sfc_adapter *sa, sfc_sw_index_t sw_index,
 
 	rc = sfc_dma_alloc(sa, "txq", sw_index, EFX_NIC_DMA_ADDR_TX_RING,
 			   efx_txq_size(sa->nic, txq_info->entries),
-			   socket_id, &txq->mem);
+			   numa_id, &txq->mem);
 	if (rc != 0)
 		goto fail_dma_alloc;
 
@@ -233,7 +233,7 @@ sfc_tx_qinit(struct sfc_adapter *sa, sfc_sw_index_t sw_index,
 	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(sa->eth_dev, *pci_dev);
 	rc = sa->priv.dp_tx->qcreate(sa->eth_dev->data->port_id, sw_index,
 				     &pci_dev->addr,
-				     socket_id, &info, &txq_info->dp);
+				     numa_id, &info, &txq_info->dp);
 	if (rc != 0)
 		goto fail_dp_tx_qinit;
 
@@ -407,9 +407,9 @@ sfc_tx_configure(struct sfc_adapter *sa)
 
 	if (sas->txq_info == NULL) {
 		reconfigure = false;
-		sas->txq_info = rte_calloc_socket("sfc-txqs", nb_txq_total,
+		sas->txq_info = rte_calloc_numa("sfc-txqs", nb_txq_total,
 						  sizeof(sas->txq_info[0]), 0,
-						  sa->socket_id);
+						  sa->numa_id);
 		if (sas->txq_info == NULL)
 			goto fail_txqs_alloc;
 
@@ -1078,7 +1078,7 @@ static sfc_dp_tx_qcreate_t sfc_efx_tx_qcreate;
 static int
 sfc_efx_tx_qcreate(uint16_t port_id, uint16_t queue_id,
 		   const struct rte_pci_addr *pci_addr,
-		   int socket_id,
+		   int numa_id,
 		   const struct sfc_dp_tx_qcreate_info *info,
 		   struct sfc_dp_txq **dp_txqp)
 {
@@ -1091,33 +1091,33 @@ sfc_efx_tx_qcreate(uint16_t port_id, uint16_t queue_id,
 		goto fail_nic_dma;
 
 	rc = ENOMEM;
-	txq = rte_zmalloc_socket("sfc-efx-txq", sizeof(*txq),
-				 RTE_CACHE_LINE_SIZE, socket_id);
+	txq = rte_zmalloc_numa("sfc-efx-txq", sizeof(*txq),
+				 RTE_CACHE_LINE_SIZE, numa_id);
 	if (txq == NULL)
 		goto fail_txq_alloc;
 
 	sfc_dp_queue_init(&txq->dp.dpq, port_id, queue_id, pci_addr);
 
 	rc = ENOMEM;
-	txq->pend_desc = rte_calloc_socket("sfc-efx-txq-pend-desc",
+	txq->pend_desc = rte_calloc_numa("sfc-efx-txq-pend-desc",
 					   EFX_TXQ_LIMIT(info->txq_entries),
 					   sizeof(*txq->pend_desc), 0,
-					   socket_id);
+					   numa_id);
 	if (txq->pend_desc == NULL)
 		goto fail_pend_desc_alloc;
 
 	rc = ENOMEM;
-	txq->sw_ring = rte_calloc_socket("sfc-efx-txq-sw_ring",
+	txq->sw_ring = rte_calloc_numa("sfc-efx-txq-sw_ring",
 					 info->txq_entries,
 					 sizeof(*txq->sw_ring),
-					 RTE_CACHE_LINE_SIZE, socket_id);
+					 RTE_CACHE_LINE_SIZE, numa_id);
 	if (txq->sw_ring == NULL)
 		goto fail_sw_ring_alloc;
 
 	ctrl_txq = sfc_txq_by_dp_txq(&txq->dp);
 	if (ctrl_txq->evq->sa->tso) {
 		rc = sfc_efx_tso_alloc_tsoh_objs(txq->sw_ring,
-						 info->txq_entries, socket_id);
+						 info->txq_entries, numa_id);
 		if (rc != 0)
 			goto fail_alloc_tsoh_objs;
 	}
diff --git a/drivers/net/sfc/sfc_tx.h b/drivers/net/sfc/sfc_tx.h
index 1a33199fdc..c29e00f3c3 100644
--- a/drivers/net/sfc/sfc_tx.h
+++ b/drivers/net/sfc/sfc_tx.h
@@ -110,7 +110,7 @@ void sfc_tx_close(struct sfc_adapter *sa);
 
 int sfc_tx_qinit_info(struct sfc_adapter *sa, sfc_sw_index_t sw_index);
 int sfc_tx_qinit(struct sfc_adapter *sa, sfc_sw_index_t sw_index,
-		 uint16_t nb_tx_desc, unsigned int socket_id,
+		 uint16_t nb_tx_desc, unsigned int numa_id,
 		 const struct rte_eth_txconf *tx_conf);
 void sfc_tx_qfini(struct sfc_adapter *sa, sfc_sw_index_t sw_index);
 
@@ -126,7 +126,7 @@ uint64_t sfc_tx_get_queue_offload_caps(struct sfc_adapter *sa);
 /* From 'sfc_tso.c' */
 int sfc_efx_tso_alloc_tsoh_objs(struct sfc_efx_tx_sw_desc *sw_ring,
 				unsigned int txq_entries,
-				unsigned int socket_id);
+				unsigned int numa_id);
 void sfc_efx_tso_free_tsoh_objs(struct sfc_efx_tx_sw_desc *sw_ring,
 				unsigned int txq_entries);
 int sfc_efx_tso_do(struct sfc_efx_txq *txq, unsigned int idx,
-- 
2.55.0

