Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FCBC28B2F
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 23:55:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 338BE40678;
	Wed, 12 Mar 2025 00:54:53 +0100 (CET)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 8A7BB4065D
 for <dev@dpdk.org>; Wed, 12 Mar 2025 00:54:47 +0100 (CET)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-22423adf751so90258275ad.2
 for <dev@dpdk.org>; Tue, 11 Mar 2025 16:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741737287;
 x=1742342087; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9bqcUhDvYz1RjDzcogE1lUg0Z1NAof+pNDYWuTQQVOg=;
 b=M8qkW2jgNr6gKcL01s4sQnCBUnOb+wEvY4+Lluxve/JWj4ZiCIBJDz9o8VmgkPUkpa
 3+mKh/mQ/lZQC57kPg1olvJstoTVg+shdK3h26oZ9joDoG4ZERHrg8NBEzGtF78/UTTp
 EuuABd9SXkIAxhBfSjph2EPWDwN61oX3zLzvz9MhRFTCvQfBGdILWTRiUIXFj1g7lvgI
 DrikLJR5Tp/Q0U1sGejYA2qSdrqKCHWlupTbzPxR4PGx9FSMQl2DmEO2E7vNN+q13AaV
 SQ+OEjbppoQHHCRhcddy/s7KxZz7R/b1TAOhR8P8y5IPak+QdN6FVXUWILgoiInwEG6t
 /hjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741737287; x=1742342087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9bqcUhDvYz1RjDzcogE1lUg0Z1NAof+pNDYWuTQQVOg=;
 b=A/L8v4qyGpdZdC08i28VZ+6zF6/kRIkQLAWk07eQ7EFeX9emVPNVxovT75qCtzWnFh
 IbAmD8Du96/VfE5TglFNNy+HyZ0He2DeG1xKoAcBAsha5Gv2i904F3y0et8MhT8vPedo
 ZAZsETE1JMvO5M3y3pZo82MCk0tVReECKH3uUtrp0OQoAXW6euWYKbjIaGqTL8qR2FvW
 hkdshPE/BJfTH5q7gDgYbRKnDPCbPS4rFVcM49v2UL24G8S2DptmtFnVXC/HWWjKI+o9
 vykRKhk+PeitHPTFy4fEX7ZT45cnUv9XnixugOlvsSnKV8bwkk0EUaON33VLQnqgnxbq
 eFGw==
X-Gm-Message-State: AOJu0YyxLVdsFYm/8mCsJdSxgQHUfE9CCoTFH6+qhUmHKe2ZpnijIQKE
 moahj7z0bn0AI3vHpyN1VlVVL36pVAWPPSCM7gMQhRXvlkUEF+1zXG8Mmnr4tdNMlXIqH0VAD3U
 q
X-Gm-Gg: ASbGncsvZwA/MtPDzjabxlq7cqVbmkKMYvLJhS+2hrvewxbBbNXgknKvX2vGKXNAXMe
 neGGn1gkQbfY6PtjbwgIxQXcjYBy5kjuJ8TzY1gQ85e85sJu3KCh1qhxJ+r+9KgMYJD1A93nS02
 lARJ7IV216ariaUjpamTYsdcXxIWrJeQcwtlh9KByz2Ak1Wblq+fVRGPrg4/YjWHdO37JOWmozF
 gd4FeFwqNQ5C7HaziOQqU2UH/+h836ltKi4nLZ4P81vn0Q3rDAt/9gVx9MpcFPjCJvFKf5ZS80G
 +jMsGxazvQ18/OxS5LsB67gYoGimSvYd+mGKhVOb1XmDybihrEn1Kay3BPk0vR+mbS37VIxnnm9
 it1dT8smsC4NioE9mLoFIfg==
X-Google-Smtp-Source: AGHT+IGF6Lbr/BgThll0O4v3eycfaXKBpschc8xecFM7fqXKwW8ayo3iKPlX+oqbX7kVpcEE60QIWg==
X-Received: by 2002:a17:903:244c:b0:223:2630:6b82 with SMTP id
 d9443c01a7336-22592e207e9mr79021585ad.10.1741737286777; 
 Tue, 11 Mar 2025 16:54:46 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a91cf4sm103734145ad.200.2025.03.11.16.54.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 16:54:46 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 9/9] net/ioring: support multi-segment Rx and Tx
Date: Tue, 11 Mar 2025 16:51:27 -0700
Message-ID: <20250311235424.172440-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250311235424.172440-1-stephen@networkplumber.org>
References: <20241210212757.83490-1-stephen@networkplumber.org>
 <20250311235424.172440-1-stephen@networkplumber.org>
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

Use readv/writev to handle multi-segment transmit and receive.
Account for virtio header that will be used for offload (later).

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/ioring/rte_eth_ioring.c | 140 ++++++++++++++++++++--------
 1 file changed, 102 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ioring/rte_eth_ioring.c b/drivers/net/ioring/rte_eth_ioring.c
index 83446dc660..a803a9820b 100644
--- a/drivers/net/ioring/rte_eth_ioring.c
+++ b/drivers/net/ioring/rte_eth_ioring.c
@@ -18,6 +18,7 @@
 #include <linux/if.h>
 #include <linux/if_arp.h>
 #include <linux/if_tun.h>
+#include <linux/virtio_net.h>
 
 #include <bus_vdev_driver.h>
 #include <ethdev_driver.h>
@@ -35,8 +36,11 @@
 #define IORING_MAX_QUEUES	128
 static_assert(IORING_MAX_QUEUES <= RTE_MP_MAX_FD_NUM, "Max queues exceeds MP fd limit");
 
-#define IORING_TX_OFFLOAD	RTE_ETH_TX_OFFLOAD_VLAN_INSERT
-#define IORING_RX_OFFLOAD	RTE_ETH_RX_OFFLOAD_VLAN_STRIP
+#define IORING_TX_OFFLOAD	(RTE_ETH_TX_OFFLOAD_VLAN_INSERT | \
+				 RTE_ETH_TX_OFFLOAD_MULTI_SEGS)
+
+#define IORING_RX_OFFLOAD	(RTE_ETH_RX_OFFLOAD_VLAN_STRIP | \
+				 RTE_ETH_RX_OFFLOAD_SCATTER)
 
 #define IORING_DEFAULT_IFNAME	"itap%d"
 #define IORING_MP_KEY		"ioring_mp_send_fds"
@@ -166,7 +170,7 @@ tap_open(const char *name, struct ifreq *ifr, uint8_t persist)
 		goto error;
 	}
 
-	int flags = IFF_TAP | IFF_MULTI_QUEUE | IFF_NO_PI;
+	int flags = IFF_TAP | IFF_MULTI_QUEUE | IFF_NO_PI | IFF_VNET_HDR;
 	if ((features & flags) != flags) {
 		PMD_LOG(ERR, "TUN features %#x missing support for %#x",
 			features, features & flags);
@@ -354,6 +358,8 @@ eth_dev_info(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->max_rx_queues = IORING_MAX_QUEUES;
 	dev_info->max_tx_queues = IORING_MAX_QUEUES;
 	dev_info->min_rx_bufsize = 0;
+	dev_info->tx_queue_offload_capa = IORING_TX_OFFLOAD;
+	dev_info->tx_offload_capa = dev_info->tx_queue_offload_capa;
 
 	dev_info->default_rxportconf = (struct rte_eth_dev_portconf) {
 		.burst_size = IORING_DEFAULT_BURST,
@@ -487,13 +493,44 @@ eth_rx_submit(struct rx_queue *rxq, int fd, struct rte_mbuf *mb)
 		PMD_LOG(DEBUG, "io_uring no rx sqe");
 		rxq->rx_errors++;
 		rte_pktmbuf_free(mb);
-	} else {
-		void *base = rte_pktmbuf_mtod(mb, void *);
-		size_t len = mb->buf_len;
+		return;
+	}
 
-		io_uring_prep_read(sqe, fd, base, len, 0);
-		io_uring_sqe_set_data(sqe, mb);
+	RTE_VERIFY(mb->nb_segs < IOV_MAX);
+	struct iovec iovs[IOV_MAX];
+
+	for (uint16_t i = 0; i < mb->nb_segs; i++) {
+		iovs[i].iov_base = rte_pktmbuf_mtod(mb, void *);
+		iovs[i].iov_len = rte_pktmbuf_tailroom(mb);
+		mb = mb->next;
 	}
+	io_uring_sqe_set_data(sqe, mb);
+	io_uring_prep_readv(sqe, fd, iovs, mb->nb_segs, 0);
+}
+
+static struct rte_mbuf *
+eth_ioring_rx_alloc(struct rx_queue *rxq)
+{
+	const struct rte_eth_dev *dev = &rte_eth_devices[rxq->port_id];
+	int buf_size = dev->data->mtu + sizeof(struct virtio_net_hdr);
+	struct rte_mbuf *m = NULL;
+	struct rte_mbuf **tail = &m;
+
+	do {
+		struct rte_mbuf *seg = rte_pktmbuf_alloc(rxq->mb_pool);
+		if (unlikely(seg == NULL)) {
+			rte_pktmbuf_free(m);
+			return NULL;
+		}
+		*tail = seg;
+		tail = &seg->next;
+		if (seg != m)
+			++m->nb_segs;
+
+		buf_size -= rte_pktmbuf_tailroom(seg);
+	} while (buf_size > 0);
+
+	return m;
 }
 
 static uint16_t
@@ -513,7 +550,8 @@ eth_ioring_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		PMD_RX_LOG(DEBUG, "cqe %u len %zd", num_cqe, len);
 		num_cqe++;
 
-		if (unlikely(len < RTE_ETHER_HDR_LEN)) {
+		struct virtio_net_hdr *hdr;
+		if (unlikely(len < (ssize_t)(sizeof(*hdr) + RTE_ETHER_HDR_LEN))) {
 			if (len < 0)
 				PMD_LOG(ERR, "io_uring_read: %s", strerror(-len));
 			else
@@ -523,19 +561,31 @@ eth_ioring_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			goto resubmit;
 		}
 
-		struct rte_mbuf *nmb = rte_pktmbuf_alloc(rxq->mb_pool);
-		if (unlikely(nmb == 0)) {
-			PMD_LOG(DEBUG, "Rx mbuf alloc failed");
+		hdr = rte_pktmbuf_mtod(mb, struct virtio_net_hdr *);
+
+		struct rte_mbuf *nmb = eth_ioring_rx_alloc(rxq);
+		if (!nmb) {
 			++rxq->rx_nombuf;
 			goto resubmit;
 		}
 
-		if (rxq->offloads & RTE_ETH_RX_OFFLOAD_VLAN_STRIP)
-			rte_vlan_strip(mb);
+		len -= sizeof(*hdr);
+		mb->data_off += sizeof(*hdr);
 
 		mb->pkt_len = len;
-		mb->data_len = len;
 		mb->port = rxq->port_id;
+		struct rte_mbuf *seg = mb;
+		for (;;) {
+			seg->data_len = RTE_MIN(len, mb->buf_len);
+			seg = seg->next;
+			len -= seg->data_len;
+		} while (len > 0 && seg != NULL);
+
+		RTE_VERIFY(!(seg == NULL && len > 0));
+
+		if (rxq->offloads & RTE_ETH_RX_OFFLOAD_VLAN_STRIP)
+			rte_vlan_strip(mb);
+
 		__rte_mbuf_sanity_check(mb, 1);
 
 		num_bytes += len;
@@ -555,6 +605,7 @@ eth_ioring_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	return num_rx;
 }
 
+
 static int
 eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id, uint16_t nb_rx_desc,
 		   unsigned int socket_id, const struct rte_eth_rxconf *rx_conf,
@@ -587,20 +638,17 @@ eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id, uint16_t nb_rx_de
 		return -1;
 	}
 
-	struct rte_mbuf **mbufs = alloca(nb_rx_desc * sizeof(struct rte_mbuf *));
-	if (mbufs == NULL) {
-		PMD_LOG(ERR, "alloca for %u failed", nb_rx_desc);
-		return -1;
-	}
+	int fd = eth_queue_fd(rxq->port_id, rxq->queue_id);
 
-	if (rte_pktmbuf_alloc_bulk(mb_pool, mbufs, nb_rx_desc) < 0) {
-		PMD_LOG(ERR, "Rx mbuf alloc %u bufs failed", nb_rx_desc);
-		return -1;
-	}
+	for (uint16_t i = 0; i < nb_rx_desc; i++) {
+		struct rte_mbuf *mb = eth_ioring_rx_alloc(rxq);
+		if (mb == NULL) {
+			PMD_LOG(ERR, "Rx mbuf alloc buf failed");
+			return -1;
+		}
 
-	int fd = eth_queue_fd(rxq->port_id, rxq->queue_id);
-	for (uint16_t i = 0; i < nb_rx_desc; i++)
-		eth_rx_submit(rxq, fd, mbufs[i]);
+		eth_rx_submit(rxq, fd, mb);
+	}
 
 	io_uring_submit(&rxq->io_ring);
 	return 0;
@@ -740,31 +788,47 @@ eth_ioring_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 	PMD_TX_LOG(DEBUG, "%d packets to xmit", nb_pkts);
 
-	if (io_uring_sq_space_left(&txq->io_ring) < txq->free_thresh)
+	if (likely(io_uring_sq_space_left(&txq->io_ring) < txq->free_thresh))
 		eth_ioring_tx_cleanup(txq);
 
 	int fd = eth_queue_fd(txq->port_id, txq->queue_id);
 
 	for (num_tx = 0; num_tx < nb_pkts; num_tx++) {
 		struct rte_mbuf *mb = bufs[num_tx];
+		struct virtio_net_hdr *hdr;
 
 		struct io_uring_sqe *sqe = io_uring_get_sqe(&txq->io_ring);
 		if (sqe == NULL)
 			break;	/* submit ring is full */
 
-		io_uring_sqe_set_data(sqe, mb);
+		if (rte_mbuf_refcnt_read(mb) == 1 && RTE_MBUF_DIRECT(mb) &&
+		    rte_pktmbuf_headroom(mb) >= sizeof(*hdr)) {
+			hdr = (struct virtio_net_hdr *)rte_pktmbuf_prepend(mb, sizeof(*hdr));
+		} else {
+			struct rte_mbuf *mh = rte_pktmbuf_alloc(mb->pool);
+			if (unlikely(mh == NULL))
+				break;
+			hdr = (struct virtio_net_hdr *)rte_pktmbuf_append(mh, sizeof(*hdr));
 
-		if (rte_mbuf_refcnt_read(mb) == 1 &&
-		    RTE_MBUF_DIRECT(mb) && mb->nb_segs == 1) {
-			void *base = rte_pktmbuf_mtod(mb, void *);
-			io_uring_prep_write(sqe, fd, base, mb->pkt_len, 0);
+			mh->next = mb;
+			mh->nb_segs = mb->nb_segs + 1;
+			mh->pkt_len += mb->pkt_len;
+			mh->ol_flags = mb->ol_flags & RTE_MBUF_F_TX_OFFLOAD_MASK;
+			mb = mh;
+		}
+		memset(hdr, 0, sizeof(*hdr));
 
-			PMD_TX_LOG(DEBUG, "tx mbuf: %p submit", mb);
-		} else {
-			PMD_LOG(ERR, "Can't do mbuf without space yet!");
-			++txq->tx_errors;
-			continue;
+		io_uring_sqe_set_data(sqe, mb);
+
+		struct iovec iovs[RTE_MBUF_MAX_NB_SEGS + 1];
+		unsigned int niov = mb->nb_segs;
+		for (unsigned int i = 0; i < niov; i++) {
+			iovs[i].iov_base = rte_pktmbuf_mtod(mb, char *);
+			iovs[i].iov_len = mb->data_len;
+			mb = mb->next;
 		}
+
+		io_uring_prep_writev(sqe, fd, iovs, niov, 0);
 	}
 	if (num_tx > 0)
 		io_uring_submit(&txq->io_ring);
-- 
2.47.2

