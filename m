Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5512A606B27C
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DkObRvbt
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58C3B42E75;
	Tue,  3 Nov 2026 16:11:57 +0100 (CET)
Received: from mta0.migadu.com (out-237.mta0.migadu.com [91.218.175.237])
 by mails.dpdk.org (Postfix) with ESMTPS id DC36742E76
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:11:55 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=zs6nGMke09jmxVUViZpOo0hnkDzgDamKaKE7alK4fQo=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718715; v=1; x=1794323515;
 b=DkObRvbts2rMcmFZym7FSrBAS95il/DEOr5dMtgQUpQ2iQ1aP3B9/T1ri4sgzRnIxSNunBsz
 KcBHICJ8/9/yiUL5+uFj1n8uA5fY2sdGo6Pq9SRIHMSGSZw/tnhqxGdNGQo9yBSqKry73eGbC0D
 bMfx8vI4NlENJvBYf+VFLR94=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 33c77bae79352f0e;
 Tue, 03 Nov 2026 15:11:55 +0000
X-Mizu-Trace-ID: 33c77bae79352f0e
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 118/227] net/enic: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:16 +0800
Message-ID: <20261103145306.487255-119-chengwen.feng@linux.dev>
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
 drivers/net/enic/base/vnic_cq.c        |  8 +++----
 drivers/net/enic/base/vnic_cq.h        |  4 ++--
 drivers/net/enic/base/vnic_dev.c       |  4 ++--
 drivers/net/enic/base/vnic_dev.h       |  2 +-
 drivers/net/enic/base/vnic_rq.c        |  6 ++---
 drivers/net/enic/base/vnic_rq.h        |  2 +-
 drivers/net/enic/base/vnic_wq.c        |  8 +++----
 drivers/net/enic/base/vnic_wq.h        |  2 +-
 drivers/net/enic/enic.h                |  4 ++--
 drivers/net/enic/enic_ethdev.c         |  8 +++----
 drivers/net/enic/enic_main.c           | 32 +++++++++++++-------------
 drivers/net/enic/enic_sriov.c          | 10 ++++----
 drivers/net/enic/enic_vf_representor.c |  8 +++----
 13 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/drivers/net/enic/base/vnic_cq.c b/drivers/net/enic/base/vnic_cq.c
index e966de2f67..2c538a4b5d 100644
--- a/drivers/net/enic/base/vnic_cq.c
+++ b/drivers/net/enic/base/vnic_cq.c
@@ -15,7 +15,7 @@ void vnic_cq_free(struct vnic_cq *cq)
 }
 
 int vnic_cq_alloc(struct vnic_dev *vdev, struct vnic_cq *cq, unsigned int index,
-	unsigned int socket_id,
+	unsigned int numa_id,
 	unsigned int desc_count, unsigned int desc_size)
 {
 	int err;
@@ -34,7 +34,7 @@ int vnic_cq_alloc(struct vnic_dev *vdev, struct vnic_cq *cq, unsigned int index,
 
 	snprintf(res_name, sizeof(res_name), "%d-cq-%u", instance++, index);
 	err = vnic_dev_alloc_desc_ring(vdev, &cq->ring, desc_count, desc_size,
-		socket_id, res_name);
+		numa_id, res_name);
 	if (err)
 		return err;
 
@@ -42,7 +42,7 @@ int vnic_cq_alloc(struct vnic_dev *vdev, struct vnic_cq *cq, unsigned int index,
 }
 
 int vnic_admin_cq_alloc(struct vnic_dev *vdev, struct vnic_cq *cq, unsigned int index,
-	unsigned int socket_id, unsigned int desc_count, unsigned int desc_size)
+	unsigned int numa_id, unsigned int desc_count, unsigned int desc_size)
 {
 	int err;
 	char res_name[RTE_MEMZONE_NAMESIZE];
@@ -60,7 +60,7 @@ int vnic_admin_cq_alloc(struct vnic_dev *vdev, struct vnic_cq *cq, unsigned int
 
 	snprintf(res_name, sizeof(res_name), "%d-admin-cq-%u", instance++, index);
 	err = vnic_dev_alloc_desc_ring(vdev, &cq->ring, desc_count, desc_size,
-		socket_id, res_name);
+		numa_id, res_name);
 	if (err)
 		return err;
 
diff --git a/drivers/net/enic/base/vnic_cq.h b/drivers/net/enic/base/vnic_cq.h
index 6469a5c12a..9b3462ba4f 100644
--- a/drivers/net/enic/base/vnic_cq.h
+++ b/drivers/net/enic/base/vnic_cq.h
@@ -64,10 +64,10 @@ struct vnic_cq {
 
 void vnic_cq_free(struct vnic_cq *cq);
 int vnic_cq_alloc(struct vnic_dev *vdev, struct vnic_cq *cq, unsigned int index,
-	unsigned int socket_id,
+	unsigned int numa_id,
 	unsigned int desc_count, unsigned int desc_size);
 int vnic_admin_cq_alloc(struct vnic_dev *vdev, struct vnic_cq *cq, unsigned int index,
-	unsigned int socket_id, unsigned int desc_count, unsigned int desc_size);
+	unsigned int numa_id, unsigned int desc_count, unsigned int desc_size);
 void vnic_cq_init(struct vnic_cq *cq, unsigned int flow_control_enable,
 	unsigned int color_enable, unsigned int cq_head, unsigned int cq_tail,
 	unsigned int cq_tail_color, unsigned int interrupt_enable,
diff --git a/drivers/net/enic/base/vnic_dev.c b/drivers/net/enic/base/vnic_dev.c
index ba8ecc16f2..73596fd62b 100644
--- a/drivers/net/enic/base/vnic_dev.c
+++ b/drivers/net/enic/base/vnic_dev.c
@@ -260,7 +260,7 @@ void vnic_dev_clear_desc_ring(struct vnic_dev_ring *ring)
 int vnic_dev_alloc_desc_ring(struct vnic_dev *vdev,
 	struct vnic_dev_ring *ring,
 	unsigned int desc_count, unsigned int desc_size,
-	__rte_unused unsigned int socket_id,
+	__rte_unused unsigned int numa_id,
 	char *z_name)
 {
 	void *alloc_addr;
@@ -1199,7 +1199,7 @@ struct vnic_dev *vnic_dev_register(struct vnic_dev *vdev,
 		char name[RTE_MEMZONE_NAMESIZE];
 		snprintf((char *)name, sizeof(name), "%s-vnic",
 			  pdev->device.name);
-		vdev = (struct vnic_dev *)rte_zmalloc_socket(name,
+		vdev = (struct vnic_dev *)rte_zmalloc_numa(name,
 					sizeof(struct vnic_dev),
 					RTE_CACHE_LINE_SIZE,
 					pdev->device.numa_node);
diff --git a/drivers/net/enic/base/vnic_dev.h b/drivers/net/enic/base/vnic_dev.h
index 0336e07ffc..d8ab91ac15 100644
--- a/drivers/net/enic/base/vnic_dev.h
+++ b/drivers/net/enic/base/vnic_dev.h
@@ -96,7 +96,7 @@ unsigned int vnic_dev_desc_ring_size(struct vnic_dev_ring *ring,
 	unsigned int desc_count, unsigned int desc_size);
 void vnic_dev_clear_desc_ring(struct vnic_dev_ring *ring);
 int vnic_dev_alloc_desc_ring(struct vnic_dev *vdev, struct vnic_dev_ring *ring,
-	unsigned int desc_count, unsigned int desc_size, unsigned int socket_id,
+	unsigned int desc_count, unsigned int desc_size, unsigned int numa_id,
 	char *z_name);
 void vnic_dev_free_desc_ring(struct vnic_dev *vdev,
 	struct vnic_dev_ring *ring);
diff --git a/drivers/net/enic/base/vnic_rq.c b/drivers/net/enic/base/vnic_rq.c
index 88def104ad..933a00b14e 100644
--- a/drivers/net/enic/base/vnic_rq.c
+++ b/drivers/net/enic/base/vnic_rq.c
@@ -39,7 +39,7 @@ int vnic_rq_alloc(struct vnic_dev *vdev, struct vnic_rq *rq, unsigned int index,
 
 	snprintf(res_name, sizeof(res_name), "%d-rq-%u", instance++, index);
 	rc = vnic_dev_alloc_desc_ring(vdev, &rq->ring, desc_count, desc_size,
-		rq->socket_id, res_name);
+		rq->numa_id, res_name);
 	return rc;
 }
 
@@ -53,7 +53,7 @@ int vnic_admin_rq_alloc(struct vnic_dev *vdev, struct vnic_rq *rq,
 	rq->index = 0;
 	rq->vdev = vdev;
 	rq->admin_chan = true;
-	rq->socket_id = SOCKET_ID_ANY;
+	rq->numa_id = RTE_NUMA_ID_ANY;
 
 	rq->ctrl = vnic_dev_get_res(vdev, RES_TYPE_ADMIN_RQ, 0);
 	if (!rq->ctrl) {
@@ -65,7 +65,7 @@ int vnic_admin_rq_alloc(struct vnic_dev *vdev, struct vnic_rq *rq,
 
 	snprintf(res_name, sizeof(res_name), "%d-admin-rq", instance++);
 	rc = vnic_dev_alloc_desc_ring(vdev, &rq->ring, desc_count, desc_size,
-		rq->socket_id, res_name);
+		rq->numa_id, res_name);
 	return rc;
 }
 
diff --git a/drivers/net/enic/base/vnic_rq.h b/drivers/net/enic/base/vnic_rq.h
index 0f068d2e18..985dfae9ac 100644
--- a/drivers/net/enic/base/vnic_rq.h
+++ b/drivers/net/enic/base/vnic_rq.h
@@ -60,7 +60,7 @@ struct vnic_rq {
 	unsigned int pkts_outstanding;
 	uint16_t rx_nb_hold;
 	uint16_t rx_free_thresh;
-	unsigned int socket_id;
+	unsigned int numa_id;
 	struct rte_mempool *mp;
 	uint16_t rxst_idx;
 	uint32_t tot_pkts;
diff --git a/drivers/net/enic/base/vnic_wq.c b/drivers/net/enic/base/vnic_wq.c
index 04eabefae7..cca99151e1 100644
--- a/drivers/net/enic/base/vnic_wq.c
+++ b/drivers/net/enic/base/vnic_wq.c
@@ -26,16 +26,16 @@ int vnic_wq_alloc_ring(struct vnic_dev *vdev, struct vnic_wq *wq,
 	snprintf(res_name, sizeof(res_name), "%d-%swq-%u",
 		 instance++, wq->admin_chan ? "admin-" : "", wq->index);
 	return vnic_dev_alloc_desc_ring(vdev, &wq->ring, desc_count, desc_size,
-		wq->socket_id, res_name);
+		wq->numa_id, res_name);
 }
 
 static int vnic_wq_alloc_bufs(struct vnic_wq *wq)
 {
 	unsigned int count = wq->ring.desc_count;
        /* Allocate the mbuf ring */
-	wq->bufs = (struct rte_mbuf **)rte_zmalloc_socket(wq->admin_chan ? "admin-wq-bufs" : "wq-bufs",
+	wq->bufs = (struct rte_mbuf **)rte_zmalloc_numa(wq->admin_chan ? "admin-wq-bufs" : "wq-bufs",
 		    sizeof(struct rte_mbuf *) * count,
-		    RTE_CACHE_LINE_SIZE, wq->socket_id);
+		    RTE_CACHE_LINE_SIZE, wq->numa_id);
 	wq->head_idx = 0;
 	wq->tail_idx = 0;
 	if (wq->bufs == NULL)
@@ -94,7 +94,7 @@ int vnic_admin_wq_alloc(struct vnic_dev *vdev, struct vnic_wq *wq,
 	wq->index = 0;
 	wq->vdev = vdev;
 	wq->admin_chan = true;
-	wq->socket_id = SOCKET_ID_ANY;
+	wq->numa_id = RTE_NUMA_ID_ANY;
 
 	err = vnic_wq_get_ctrl(vdev, wq, 0, RES_TYPE_ADMIN_WQ);
 	if (err) {
diff --git a/drivers/net/enic/base/vnic_wq.h b/drivers/net/enic/base/vnic_wq.h
index 381f78431c..8529a8d0f9 100644
--- a/drivers/net/enic/base/vnic_wq.h
+++ b/drivers/net/enic/base/vnic_wq.h
@@ -46,7 +46,7 @@ struct vnic_wq {
 	unsigned int head_idx;
 	unsigned int cq_pend;
 	unsigned int tail_idx;
-	unsigned int socket_id;
+	unsigned int numa_id;
 	const struct rte_memzone *cqmsg_rz;
 	uint16_t last_completed_index;
 	uint64_t offloads;
diff --git a/drivers/net/enic/enic.h b/drivers/net/enic/enic.h
index 0a8d4a29ca..d2806c8a89 100644
--- a/drivers/net/enic/enic.h
+++ b/drivers/net/enic/enic.h
@@ -399,14 +399,14 @@ void enic_free_wq(void *txq);
 int enic_alloc_intr_resources(struct enic *enic);
 int enic_setup_finish(struct enic *enic);
 int enic_alloc_wq(struct enic *enic, uint16_t queue_idx,
-		  unsigned int socket_id, uint16_t nb_desc);
+		  unsigned int numa_id, uint16_t nb_desc);
 void enic_start_wq(struct enic *enic, uint16_t queue_idx);
 int enic_stop_wq(struct enic *enic, uint16_t queue_idx);
 void enic_start_rq(struct enic *enic, uint16_t queue_idx);
 int enic_stop_rq(struct enic *enic, uint16_t queue_idx);
 void enic_free_rq(void *rxq);
 int enic_alloc_rq(struct enic *enic, uint16_t queue_idx,
-		  unsigned int socket_id, struct rte_mempool *mp,
+		  unsigned int numa_id, struct rte_mempool *mp,
 		  uint16_t nb_desc, uint16_t free_thresh);
 int enic_set_vnic_res(struct enic *enic);
 int enic_init_rss_nic_cfg(struct enic *enic);
diff --git a/drivers/net/enic/enic_ethdev.c b/drivers/net/enic/enic_ethdev.c
index 648aa67a85..ea34a05a06 100644
--- a/drivers/net/enic/enic_ethdev.c
+++ b/drivers/net/enic/enic_ethdev.c
@@ -166,7 +166,7 @@ static int enicpmd_dev_setup_intr(struct enic *enic)
 static int enicpmd_dev_tx_queue_setup(struct rte_eth_dev *eth_dev,
 	uint16_t queue_idx,
 	uint16_t nb_desc,
-	unsigned int socket_id,
+	unsigned int numa_id,
 	const struct rte_eth_txconf *tx_conf)
 {
 	int ret;
@@ -183,7 +183,7 @@ static int enicpmd_dev_tx_queue_setup(struct rte_eth_dev *eth_dev,
 		eth_dev->data->dev_conf.txmode.offloads;
 	eth_dev->data->tx_queues[queue_idx] = (void *)wq;
 
-	ret = enic_alloc_wq(enic, queue_idx, socket_id, nb_desc);
+	ret = enic_alloc_wq(enic, queue_idx, numa_id, nb_desc);
 	if (ret) {
 		dev_err(enic, "error in allocating wq\n");
 		return ret;
@@ -285,7 +285,7 @@ static int enicpmd_dev_rx_queue_count(void *rx_queue)
 static int enicpmd_dev_rx_queue_setup(struct rte_eth_dev *eth_dev,
 	uint16_t queue_idx,
 	uint16_t nb_desc,
-	unsigned int socket_id,
+	unsigned int numa_id,
 	const struct rte_eth_rxconf *rx_conf,
 	struct rte_mempool *mp)
 {
@@ -300,7 +300,7 @@ static int enicpmd_dev_rx_queue_setup(struct rte_eth_dev *eth_dev,
 	eth_dev->data->rx_queues[queue_idx] =
 		(void *)&enic->rq[enic_rte_rq_idx_to_sop_idx(queue_idx)];
 
-	ret = enic_alloc_rq(enic, queue_idx, socket_id, mp, nb_desc,
+	ret = enic_alloc_rq(enic, queue_idx, numa_id, mp, nb_desc,
 			    rx_conf->rx_free_thresh);
 	if (ret) {
 		dev_err(enic, "error in allocating rq\n");
diff --git a/drivers/net/enic/enic_main.c b/drivers/net/enic/enic_main.c
index 0c7f085d66..414ee5e3b9 100644
--- a/drivers/net/enic/enic_main.c
+++ b/drivers/net/enic/enic_main.c
@@ -333,7 +333,7 @@ enic_alloc_consistent(void *priv, size_t size,
 	struct enic_memzone_entry *mze;
 
 	rz = rte_memzone_reserve_aligned((const char *)name, size,
-			SOCKET_ID_ANY, RTE_MEMZONE_IOVA_CONTIG, ENIC_PAGE_SIZE);
+			RTE_NUMA_ID_ANY, RTE_MEMZONE_IOVA_CONTIG, ENIC_PAGE_SIZE);
 	if (!rz) {
 		pr_err("%s : Failed to allocate memory requested for %s\n",
 			__func__, name);
@@ -787,7 +787,7 @@ int enic_stop_rq(struct enic *enic, uint16_t queue_idx)
 }
 
 int enic_alloc_rq(struct enic *enic, uint16_t queue_idx,
-	unsigned int socket_id, struct rte_mempool *mp,
+	unsigned int numa_id, struct rte_mempool *mp,
 	uint16_t nb_desc, uint16_t free_thresh)
 {
 	struct enic_vf_representor *vf;
@@ -824,9 +824,9 @@ int enic_alloc_rq(struct enic *enic, uint16_t queue_idx,
 	rq_sop->data_queue_idx = data_queue_idx;
 	rq_data->is_sop = 0;
 	rq_data->data_queue_idx = 0;
-	rq_sop->socket_id = socket_id;
+	rq_sop->numa_id = numa_id;
 	rq_sop->mp = mp;
-	rq_data->socket_id = socket_id;
+	rq_data->numa_id = numa_id;
 	rq_data->mp = mp;
 	rq_sop->in_use = 1;
 	rq_sop->rx_free_thresh = free_thresh;
@@ -952,7 +952,7 @@ int enic_alloc_rq(struct enic *enic, uint16_t queue_idx,
 	}
 
 	rc = vnic_cq_alloc(enic->vdev, &enic->cq[cq_idx], cq_idx,
-			   socket_id, nb_sop_desc + nb_data_desc,
+			   numa_id, nb_sop_desc + nb_data_desc,
 			   enic->cq64 ?	sizeof(struct cq_enet_rq_desc_64) :
 			   sizeof(struct cq_enet_rq_desc));
 	if (rc) {
@@ -962,26 +962,26 @@ int enic_alloc_rq(struct enic *enic, uint16_t queue_idx,
 
 	/* Allocate the mbuf rings */
 	rq_sop->mbuf_ring = (struct rte_mbuf **)
-		rte_zmalloc_socket("rq->mbuf_ring",
+		rte_zmalloc_numa("rq->mbuf_ring",
 				   sizeof(struct rte_mbuf *) * nb_sop_desc,
-				   RTE_CACHE_LINE_SIZE, rq_sop->socket_id);
+				   RTE_CACHE_LINE_SIZE, rq_sop->numa_id);
 	if (rq_sop->mbuf_ring == NULL)
 		goto err_free_cq;
 
 	if (rq_data->in_use) {
 		rq_data->mbuf_ring = (struct rte_mbuf **)
-			rte_zmalloc_socket("rq->mbuf_ring",
+			rte_zmalloc_numa("rq->mbuf_ring",
 				sizeof(struct rte_mbuf *) * nb_data_desc,
-				RTE_CACHE_LINE_SIZE, rq_sop->socket_id);
+				RTE_CACHE_LINE_SIZE, rq_sop->numa_id);
 		if (rq_data->mbuf_ring == NULL)
 			goto err_free_sop_mbuf;
 	}
 
 	rq_sop->free_mbufs = (struct rte_mbuf **)
-		rte_zmalloc_socket("rq->free_mbufs",
+		rte_zmalloc_numa("rq->free_mbufs",
 				   sizeof(struct rte_mbuf *) *
 				   ENIC_RX_BURST_MAX,
-				   RTE_CACHE_LINE_SIZE, rq_sop->socket_id);
+				   RTE_CACHE_LINE_SIZE, rq_sop->numa_id);
 	if (rq_sop->free_mbufs == NULL)
 		goto err_free_data_mbuf;
 	rq_sop->num_free_mbufs = 0;
@@ -1022,7 +1022,7 @@ void enic_free_wq(void *txq)
 }
 
 int enic_alloc_wq(struct enic *enic, uint16_t queue_idx,
-	unsigned int socket_id, uint16_t nb_desc)
+	unsigned int numa_id, uint16_t nb_desc)
 {
 	struct enic_vf_representor *vf;
 	int err;
@@ -1045,7 +1045,7 @@ int enic_alloc_wq(struct enic *enic, uint16_t queue_idx,
 		cq_index = enic_cq_wq(enic, queue_idx);
 	}
 	wq = &enic->wq[queue_idx];
-	wq->socket_id = socket_id;
+	wq->numa_id = numa_id;
 	/*
 	 * rte_eth_tx_queue_setup() checks min, max, and alignment. So just
 	 * print an info message for diagnostics.
@@ -1062,7 +1062,7 @@ int enic_alloc_wq(struct enic *enic, uint16_t queue_idx,
 	}
 
 	err = vnic_cq_alloc(enic->vdev, &enic->cq[cq_index], cq_index,
-		socket_id, nb_desc,
+		numa_id, nb_desc,
 		sizeof(struct cq_enet_wq_desc));
 	if (err) {
 		vnic_wq_free(wq);
@@ -1075,7 +1075,7 @@ int enic_alloc_wq(struct enic *enic, uint16_t queue_idx,
 		instance++);
 
 	wq->cqmsg_rz = rte_memzone_reserve_aligned((const char *)name,
-			sizeof(uint32_t), SOCKET_ID_ANY,
+			sizeof(uint32_t), RTE_NUMA_ID_ANY,
 			RTE_MEMZONE_IOVA_CONTIG, ENIC_PAGE_SIZE);
 	if (!wq->cqmsg_rz)
 		return -ENOMEM;
@@ -1682,7 +1682,7 @@ int enic_set_mtu(struct enic *enic, uint16_t new_mtu)
 			continue;
 
 		enic_free_rq(rq);
-		rc = enic_alloc_rq(enic, rq_idx, rq->socket_id, rq->mp,
+		rc = enic_alloc_rq(enic, rq_idx, rq->numa_id, rq->mp,
 				   rq->tot_nb_desc, rq->rx_free_thresh);
 		if (rc) {
 			dev_err(enic,
diff --git a/drivers/net/enic/enic_sriov.c b/drivers/net/enic/enic_sriov.c
index 29faa31512..42b6440357 100644
--- a/drivers/net/enic/enic_sriov.c
+++ b/drivers/net/enic/enic_sriov.c
@@ -79,7 +79,7 @@ static int enic_enable_admin_rq(struct enic *enic)
 		return err;
 	}
 	err = vnic_admin_cq_alloc(enic->vdev, cq, cq_idx,
-		SOCKET_ID_ANY, desc_count, sizeof(struct cq_enet_rq_desc));
+		RTE_NUMA_ID_ANY, desc_count, sizeof(struct cq_enet_rq_desc));
 	if (err) {
 		dev_err(enic, "failed to allocate CQ for admin RQ\n");
 		return err;
@@ -106,7 +106,7 @@ static int enic_enable_admin_rq(struct enic *enic)
 	 */
 	snprintf((char *)name, sizeof(name), "admin-rq-buf-%d", instance++);
 	rq->admin_msg_rz = rte_memzone_reserve_aligned((const char *)name,
-			desc_count * rqbuf_size, SOCKET_ID_ANY,
+			desc_count * rqbuf_size, RTE_NUMA_ID_ANY,
 			RTE_MEMZONE_IOVA_CONTIG, ENIC_PAGE_SIZE);
 	if (!rq->admin_msg_rz)
 		return -ENOMEM;
@@ -151,7 +151,7 @@ static int enic_enable_admin_wq(struct enic *enic)
 		return err;
 	}
 	err = vnic_admin_cq_alloc(enic->vdev, cq, cq_idx,
-		SOCKET_ID_ANY, desc_count, sizeof(struct cq_enet_wq_desc));
+		RTE_NUMA_ID_ANY, desc_count, sizeof(struct cq_enet_wq_desc));
 	if (err) {
 		vnic_wq_free(wq);
 		dev_err(enic, "failed to allocate CQ for admin WQ\n");
@@ -160,7 +160,7 @@ static int enic_enable_admin_wq(struct enic *enic)
 	snprintf((char *)name, sizeof(name),
 		 "vnic_cqmsg-%s-admin-wq-%d", enic->bdf_name, instance++);
 	wq->cqmsg_rz = rte_memzone_reserve_aligned((const char *)name,
-			sizeof(uint32_t), SOCKET_ID_ANY,
+			sizeof(uint32_t), RTE_NUMA_ID_ANY,
 			RTE_MEMZONE_IOVA_CONTIG, ENIC_PAGE_SIZE);
 	if (!wq->cqmsg_rz)
 		return -ENOMEM;
@@ -183,7 +183,7 @@ static int enic_enable_admin_wq(struct enic *enic)
 
 	snprintf((char *)name, sizeof(name), "admin-wq-buf-%d", instance++);
 	wq->admin_msg_rz = rte_memzone_reserve_aligned((const char *)name,
-			desc_count * wqbuf_size, SOCKET_ID_ANY,
+			desc_count * wqbuf_size, RTE_NUMA_ID_ANY,
 			RTE_MEMZONE_IOVA_CONTIG, ENIC_PAGE_SIZE);
 	if (!wq->admin_msg_rz)
 		return -ENOMEM;
diff --git a/drivers/net/enic/enic_vf_representor.c b/drivers/net/enic/enic_vf_representor.c
index fc836100b4..bb6adb3e6c 100644
--- a/drivers/net/enic/enic_vf_representor.c
+++ b/drivers/net/enic/enic_vf_representor.c
@@ -41,7 +41,7 @@ static uint16_t enic_vf_xmit_pkts(void *tx_queue,
 static int enic_vf_dev_tx_queue_setup(struct rte_eth_dev *eth_dev,
 	uint16_t queue_idx,
 	uint16_t nb_desc,
-	unsigned int socket_id,
+	unsigned int numa_id,
 	const struct rte_eth_txconf *tx_conf)
 {
 	struct enic_vf_representor *vf;
@@ -62,7 +62,7 @@ static int enic_vf_dev_tx_queue_setup(struct rte_eth_dev *eth_dev,
 		eth_dev->data->dev_conf.txmode.offloads;
 	eth_dev->data->tx_queues[0] = (void *)wq;
 	/* Pass vf not pf because of cq index calculation. See enic_alloc_wq */
-	err = enic_alloc_wq(&vf->enic, queue_idx, socket_id, nb_desc);
+	err = enic_alloc_wq(&vf->enic, queue_idx, numa_id, nb_desc);
 	if (err) {
 		ENICPMD_LOG(ERR, "error in allocating wq");
 		return err;
@@ -83,7 +83,7 @@ static void enic_vf_dev_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
 static int enic_vf_dev_rx_queue_setup(struct rte_eth_dev *eth_dev,
 	uint16_t queue_idx,
 	uint16_t nb_desc,
-	unsigned int socket_id,
+	unsigned int numa_id,
 	const struct rte_eth_rxconf *rx_conf,
 	struct rte_mempool *mp)
 {
@@ -101,7 +101,7 @@ static int enic_vf_dev_rx_queue_setup(struct rte_eth_dev *eth_dev,
 	pf = vf->pf;
 	eth_dev->data->rx_queues[queue_idx] =
 		(void *)&pf->rq[vf->pf_rq_sop_idx];
-	ret = enic_alloc_rq(&vf->enic, queue_idx, socket_id, mp, nb_desc,
+	ret = enic_alloc_rq(&vf->enic, queue_idx, numa_id, mp, nb_desc,
 			    rx_conf->rx_free_thresh);
 	if (ret) {
 		ENICPMD_LOG(ERR, "error in allocating rq");
-- 
2.55.0

