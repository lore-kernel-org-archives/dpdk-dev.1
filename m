Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E471606EEAA
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=J9HwlUqD
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6389B42E8E;
	Tue,  3 Nov 2026 16:14:46 +0100 (CET)
Received: from mta1.migadu.com (out-117.mta1.migadu.com [95.215.58.117])
 by mails.dpdk.org (Postfix) with ESMTPS id 3BEE84042C
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:14:45 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=Y30p6VxcMA2yYoL11ZCP8aYYZoEWRcKF0xoFncC6d3s=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718884; v=1; x=1794323684;
 b=J9HwlUqDXMFhe+A2TvdVNhifsxASI02PkOOHDr1Pu7cp0RsEm0cZ6NU6uN9MOuXi6j0Vp2kH
 zCLxtCAmj6kbajhYq2ciQN2fo3l9uQ+QZDHCw0HiBHH0faKrJa13ecT+2Rk+nVVUvTeGjq0BeVc
 D5VvghN97n3C2crKOjIW5714=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id 680919f66f32b29e;
 Tue, 03 Nov 2026 15:14:44 +0000
X-Mizu-Trace-ID: 680919f66f32b29e
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 138/227] net/octeon_ep: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:36 +0800
Message-ID: <20261103145306.487255-139-chengwen.feng@linux.dev>
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
 drivers/net/octeon_ep/otx_ep_common.h |  4 ++--
 drivers/net/octeon_ep/otx_ep_ethdev.c | 12 +++++-----
 drivers/net/octeon_ep/otx_ep_rxtx.c   | 32 +++++++++++++--------------
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/net/octeon_ep/otx_ep_common.h b/drivers/net/octeon_ep/otx_ep_common.h
index 406155078b..d9bca31770 100644
--- a/drivers/net/octeon_ep/otx_ep_common.h
+++ b/drivers/net/octeon_ep/otx_ep_common.h
@@ -584,12 +584,12 @@ struct otx_ep_device {
 };
 
 int otx_ep_setup_iqs(struct otx_ep_device *otx_ep, uint32_t iq_no,
-		     int num_descs, unsigned int socket_id);
+		     int num_descs, unsigned int numa_id);
 int otx_ep_delete_iqs(struct otx_ep_device *otx_ep, uint32_t iq_no);
 
 int otx_ep_setup_oqs(struct otx_ep_device *otx_ep, int oq_no, int num_descs,
 		     int desc_size, struct rte_mempool *mpool,
-		     unsigned int socket_id);
+		     unsigned int numa_id);
 int otx_ep_delete_oqs(struct otx_ep_device *otx_ep, uint32_t oq_no);
 
 #define OTX_EP_MAX_PKT_SZ 65498U
diff --git a/drivers/net/octeon_ep/otx_ep_ethdev.c b/drivers/net/octeon_ep/otx_ep_ethdev.c
index ddd3d092c3..10d2adfa87 100644
--- a/drivers/net/octeon_ep/otx_ep_ethdev.c
+++ b/drivers/net/octeon_ep/otx_ep_ethdev.c
@@ -475,7 +475,7 @@ otx_ep_dev_configure(struct rte_eth_dev *eth_dev)
  *    Queue number
  * @param num_rx_descs
  *    Number of entries in the queue
- * @param socket_id
+ * @param numa_id
  *    Where to allocate memory
  * @param rx_conf
  *    Pointer to the struction rte_eth_rxconf
@@ -488,7 +488,7 @@ otx_ep_dev_configure(struct rte_eth_dev *eth_dev)
  */
 static int
 otx_ep_rx_queue_setup(struct rte_eth_dev *eth_dev, uint16_t q_no,
-		       uint16_t num_rx_descs, unsigned int socket_id,
+		       uint16_t num_rx_descs, unsigned int numa_id,
 		       const struct rte_eth_rxconf *rx_conf __rte_unused,
 		       struct rte_mempool *mp)
 {
@@ -518,7 +518,7 @@ otx_ep_rx_queue_setup(struct rte_eth_dev *eth_dev, uint16_t q_no,
 	buf_size = mbp_priv->mbuf_data_room_size - RTE_PKTMBUF_HEADROOM;
 
 	if (otx_ep_setup_oqs(otx_epvf, q_no, num_rx_descs, buf_size, mp,
-			     socket_id)) {
+			     numa_id)) {
 		otx_ep_err("droq allocation failed");
 		return -1;
 	}
@@ -563,7 +563,7 @@ otx_ep_rx_queue_release(struct rte_eth_dev *dev, uint16_t q_no)
  * @param num_tx_descs
  *   Number of ringbuffer descriptors
  *
- * @param socket_id
+ * @param numa_id
  *   NUMA socket id, used for memory allocations
  *
  * @param tx_conf
@@ -575,7 +575,7 @@ otx_ep_rx_queue_release(struct rte_eth_dev *dev, uint16_t q_no)
  */
 static int
 otx_ep_tx_queue_setup(struct rte_eth_dev *eth_dev, uint16_t q_no,
-		       uint16_t num_tx_descs, unsigned int socket_id,
+		       uint16_t num_tx_descs, unsigned int numa_id,
 		       const struct rte_eth_txconf *tx_conf __rte_unused)
 {
 	struct otx_ep_device *otx_epvf = OTX_EP_DEV(eth_dev);
@@ -596,7 +596,7 @@ otx_ep_tx_queue_setup(struct rte_eth_dev *eth_dev, uint16_t q_no,
 		return -EINVAL;
 	}
 
-	retval = otx_ep_setup_iqs(otx_epvf, q_no, num_tx_descs, socket_id);
+	retval = otx_ep_setup_iqs(otx_epvf, q_no, num_tx_descs, numa_id);
 
 	if (retval) {
 		otx_ep_err("IQ(TxQ) creation failed.");
diff --git a/drivers/net/octeon_ep/otx_ep_rxtx.c b/drivers/net/octeon_ep/otx_ep_rxtx.c
index a21764868d..ded787268d 100644
--- a/drivers/net/octeon_ep/otx_ep_rxtx.c
+++ b/drivers/net/octeon_ep/otx_ep_rxtx.c
@@ -77,7 +77,7 @@ otx_ep_delete_iqs(struct otx_ep_device *otx_ep, uint32_t iq_no)
 /* IQ initialization */
 static int
 otx_ep_init_instr_queue(struct otx_ep_device *otx_ep, int iq_no, int num_descs,
-		     unsigned int socket_id)
+		     unsigned int numa_id)
 {
 	const struct otx_ep_config *conf;
 	struct otx_ep_instr_queue *iq;
@@ -93,7 +93,7 @@ otx_ep_init_instr_queue(struct otx_ep_device *otx_ep, int iq_no, int num_descs,
 	iq->iq_mz = rte_eth_dma_zone_reserve(otx_ep->eth_dev,
 					     "instr_queue", iq_no, q_size,
 					     OTX_EP_PCI_RING_ALIGN,
-					     socket_id);
+					     numa_id);
 	if (iq->iq_mz == NULL) {
 		otx_ep_err("IQ[%d] memzone alloc failed", iq_no);
 		goto iq_init_fail;
@@ -113,18 +113,18 @@ otx_ep_init_instr_queue(struct otx_ep_device *otx_ep, int iq_no, int num_descs,
 	 * posted to OCTEON 9. This list will be used for freeing the IQ
 	 * data buffer(s) later once the OCTEON 9 fetched the requests.
 	 */
-	iq->req_list = rte_zmalloc_socket("request_list",
+	iq->req_list = rte_zmalloc_numa("request_list",
 			(iq->nb_desc * OTX_EP_IQREQ_LIST_SIZE),
 			RTE_CACHE_LINE_SIZE,
-			rte_socket_id());
+			rte_numa_id());
 	if (iq->req_list == NULL) {
 		otx_ep_err("IQ[%d] req_list alloc failed", iq_no);
 		goto iq_init_fail;
 	}
 
 	for (i = 0; i < iq->nb_desc; i++) {
-		sg = rte_zmalloc_socket("sg_entry", (OTX_EP_MAX_SG_LISTS * OTX_EP_SG_ENTRY_SIZE),
-			OTX_EP_SG_ALIGN, rte_socket_id());
+		sg = rte_zmalloc_numa("sg_entry", (OTX_EP_MAX_SG_LISTS * OTX_EP_SG_ENTRY_SIZE),
+			OTX_EP_SG_ALIGN, rte_numa_id());
 		if (sg == NULL) {
 			otx_ep_err("IQ[%d] sg_entries alloc failed", iq_no);
 			goto iq_init_fail;
@@ -138,8 +138,8 @@ otx_ep_init_instr_queue(struct otx_ep_device *otx_ep, int iq_no, int num_descs,
 		     iq_no, iq->base_addr, (unsigned long)iq->base_addr_dma,
 		     iq->nb_desc);
 
-	iq->mbuf_list = rte_zmalloc_socket("mbuf_list",	(iq->nb_desc * sizeof(struct rte_mbuf *)),
-					   RTE_CACHE_LINE_SIZE, rte_socket_id());
+	iq->mbuf_list = rte_zmalloc_numa("mbuf_list",	(iq->nb_desc * sizeof(struct rte_mbuf *)),
+					   RTE_CACHE_LINE_SIZE, rte_numa_id());
 	if (!iq->mbuf_list) {
 		otx_ep_err("IQ[%d] mbuf_list alloc failed", iq_no);
 		goto iq_init_fail;
@@ -175,7 +175,7 @@ otx_ep_init_instr_queue(struct otx_ep_device *otx_ep, int iq_no, int num_descs,
 
 int
 otx_ep_setup_iqs(struct otx_ep_device *otx_ep, uint32_t iq_no, int num_descs,
-		 unsigned int socket_id)
+		 unsigned int numa_id)
 {
 	struct otx_ep_instr_queue *iq;
 
@@ -186,7 +186,7 @@ otx_ep_setup_iqs(struct otx_ep_device *otx_ep, uint32_t iq_no, int num_descs,
 
 	otx_ep->instr_queue[iq_no] = iq;
 
-	if (otx_ep_init_instr_queue(otx_ep, iq_no, num_descs, socket_id)) {
+	if (otx_ep_init_instr_queue(otx_ep, iq_no, num_descs, numa_id)) {
 		otx_ep_err("IQ init is failed");
 		goto delete_IQ;
 	}
@@ -316,7 +316,7 @@ otx_ep_set_rearm_data(struct otx_ep_device *otx_ep)
 static int
 otx_ep_init_droq(struct otx_ep_device *otx_ep, uint32_t q_no,
 	      uint32_t num_descs, uint32_t desc_size,
-	      struct rte_mempool *mpool, unsigned int socket_id)
+	      struct rte_mempool *mpool, unsigned int numa_id)
 {
 	const struct otx_ep_config *conf = otx_ep->conf;
 	uint32_t c_refill_threshold;
@@ -341,7 +341,7 @@ otx_ep_init_droq(struct otx_ep_device *otx_ep, uint32_t q_no,
 	droq->desc_ring_mz = rte_eth_dma_zone_reserve(otx_ep->eth_dev, "droq",
 						      q_no, desc_ring_size,
 						      OTX_EP_PCI_RING_ALIGN,
-						      socket_id);
+						      numa_id);
 
 	if (droq->desc_ring_mz == NULL) {
 		otx_ep_err("OQ:%d desc_ring allocation failed", q_no);
@@ -356,9 +356,9 @@ otx_ep_init_droq(struct otx_ep_device *otx_ep, uint32_t q_no,
 	otx_ep_dbg("OQ[%d]: num_desc: %d", q_no, droq->nb_desc);
 
 	/* OQ buf_list set up */
-	droq->recv_buf_list = rte_zmalloc_socket("recv_buf_list",
+	droq->recv_buf_list = rte_zmalloc_numa("recv_buf_list",
 				(droq->nb_desc * sizeof(struct rte_mbuf *)),
-				 RTE_CACHE_LINE_SIZE, socket_id);
+				 RTE_CACHE_LINE_SIZE, numa_id);
 	if (droq->recv_buf_list == NULL) {
 		otx_ep_err("OQ recv_buf_list alloc failed");
 		goto init_droq_fail;
@@ -391,7 +391,7 @@ otx_ep_init_droq(struct otx_ep_device *otx_ep, uint32_t q_no,
 int
 otx_ep_setup_oqs(struct otx_ep_device *otx_ep, int oq_no, int num_descs,
 		 int desc_size, struct rte_mempool *mpool,
-		 unsigned int socket_id)
+		 unsigned int numa_id)
 {
 	struct otx_ep_droq *droq;
 
@@ -405,7 +405,7 @@ otx_ep_setup_oqs(struct otx_ep_device *otx_ep, int oq_no, int num_descs,
 	otx_ep->droq[oq_no] = droq;
 
 	if (otx_ep_init_droq(otx_ep, oq_no, num_descs, desc_size, mpool,
-			     socket_id)) {
+			     numa_id)) {
 		otx_ep_err("Droq[%d] Initialization failed", oq_no);
 		goto delete_OQ;
 	}
-- 
2.55.0

