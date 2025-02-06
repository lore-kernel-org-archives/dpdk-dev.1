Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B414C02192
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 01:34:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90DEC40B9C;
	Thu,  6 Feb 2025 02:33:53 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 6E9854067C
 for <dev@dpdk.org>; Thu,  6 Feb 2025 02:33:38 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id F18C1203F5AF; Wed,  5 Feb 2025 17:33:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F18C1203F5AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738805616;
 bh=P2GILx611CmHWZQamm6DnO2lGy135vG+YjfFI9+sUH4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Pp7rUL3r0CUpWCFG8Lh6MvFXfErRapW7N1JX3WhbGt1yd2jfESkHNH14k00ZJUEKY
 8XQgaG3BjYLRBeu6NsoBF9afArHD8ApoIG0XZo/5lkPRf3r1JirAHkH0+4uLyVzROg
 zH+TulPmt6/2FJAfVTJLEymwx5YpPWtCQJyemDlc=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Cc: konstantin.ananyev@huawei.com, thomas@monjalon.net,
 david.marchand@redhat.com
Subject: [PATCH v22 11/27] net/ice: remove use of VLAs
Date: Wed,  5 Feb 2025 17:33:14 -0800
Message-Id: <1738805610-17507-12-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738805610-17507-1-git-send-email-andremue@linux.microsoft.com>
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
 <1738805610-17507-1-git-send-email-andremue@linux.microsoft.com>
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

From: Konstantin Ananyev <konstantin.ananyev@huawei.com>

../drivers/net/ice/ice_rxtx.c:1871:29: warning:
    variable length array used [-Wvla]

Here VLA is used as a temp array for mbufs that will be used as a split
RX data buffers.
As at any given time only one thread can do RX from particular queue,
at rx_queue_setup() we can allocate extra space for that array, and then
safely use it at RX fast-path.

Signed-off-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ice/ice_rxtx.c | 18 ++++++++++++------
 drivers/net/intel/ice/ice_rxtx.h |  2 ++
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 8dd8644b16..437cf0d807 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -1172,7 +1172,7 @@ ice_rx_queue_setup(struct rte_eth_dev *dev,
 	struct ice_vsi *vsi = pf->main_vsi;
 	struct ice_rx_queue *rxq;
 	const struct rte_memzone *rz;
-	uint32_t ring_size;
+	uint32_t ring_size, tlen;
 	uint16_t len;
 	int use_def_burst_func = 1;
 	uint64_t offloads;
@@ -1280,9 +1280,14 @@ ice_rx_queue_setup(struct rte_eth_dev *dev,
 	/* always reserve more for bulk alloc */
 	len = (uint16_t)(nb_desc + ICE_RX_MAX_BURST);
 
+	/* allocate extra entries for SW split buffer */
+	tlen = ((rxq->offloads & RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT) != 0) ?
+		rxq->rx_free_thresh : 0;
+	tlen += len;
+
 	/* Allocate the software ring. */
 	rxq->sw_ring = rte_zmalloc_socket(NULL,
-					  sizeof(struct ice_rx_entry) * len,
+					  sizeof(struct ice_rx_entry) * tlen,
 					  RTE_CACHE_LINE_SIZE,
 					  socket_id);
 	if (!rxq->sw_ring) {
@@ -1291,6 +1296,8 @@ ice_rx_queue_setup(struct rte_eth_dev *dev,
 		return -ENOMEM;
 	}
 
+	rxq->sw_split_buf = (tlen == len) ? NULL : rxq->sw_ring + len;
+
 	ice_reset_rx_queue(rxq);
 	rxq->q_set = true;
 	dev->data->rx_queues[queue_idx] = rxq;
@@ -1864,7 +1871,6 @@ ice_rx_alloc_bufs(struct ice_rx_queue *rxq)
 	uint64_t dma_addr;
 	int diag, diag_pay;
 	uint64_t pay_addr;
-	struct rte_mbuf *mbufs_pay[rxq->rx_free_thresh];
 
 	/* Allocate buffers in bulk */
 	alloc_idx = (uint16_t)(rxq->rx_free_trigger -
@@ -1879,7 +1885,7 @@ ice_rx_alloc_bufs(struct ice_rx_queue *rxq)
 
 	if (rxq->offloads & RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT) {
 		diag_pay = rte_mempool_get_bulk(rxq->rxseg[1].mp,
-				(void *)mbufs_pay, rxq->rx_free_thresh);
+				(void *)rxq->sw_split_buf, rxq->rx_free_thresh);
 		if (unlikely(diag_pay != 0)) {
 			rte_mempool_put_bulk(rxq->mp, (void *)rxep,
 				    rxq->rx_free_thresh);
@@ -1906,8 +1912,8 @@ ice_rx_alloc_bufs(struct ice_rx_queue *rxq)
 			rxdp[i].read.hdr_addr = 0;
 			rxdp[i].read.pkt_addr = dma_addr;
 		} else {
-			mb->next = mbufs_pay[i];
-			pay_addr = rte_cpu_to_le_64(rte_mbuf_data_iova_default(mbufs_pay[i]));
+			mb->next = rxq->sw_split_buf[i].mbuf;
+			pay_addr = rte_cpu_to_le_64(rte_mbuf_data_iova_default(mb->next));
 			rxdp[i].read.hdr_addr = dma_addr;
 			rxdp[i].read.pkt_addr = pay_addr;
 		}
diff --git a/drivers/net/intel/ice/ice_rxtx.h b/drivers/net/intel/ice/ice_rxtx.h
index f9293ac6f9..276d40b57f 100644
--- a/drivers/net/intel/ice/ice_rxtx.h
+++ b/drivers/net/intel/ice/ice_rxtx.h
@@ -139,6 +139,8 @@ struct ice_rx_queue {
 	uint32_t hw_time_high; /* high 32 bits of timestamp */
 	uint32_t hw_time_low; /* low 32 bits of timestamp */
 	uint64_t hw_time_update; /* SW time of HW record updating */
+	struct ice_rx_entry *sw_split_buf;
+	/* address of temp buffer for RX split mbufs */
 	struct rte_eth_rxseg_split rxseg[ICE_RX_MAX_NSEG];
 	uint32_t rxseg_nb;
 	bool ts_enable; /* if rxq timestamp is enabled */
-- 
2.47.2.vfs.0.1

