Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46022C35FF1
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 21:52:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E71E94066D;
	Thu, 13 Mar 2025 22:52:15 +0100 (CET)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id 46418402E5
 for <dev@dpdk.org>; Thu, 13 Mar 2025 22:52:10 +0100 (CET)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-22359001f1aso38246775ad.3
 for <dev@dpdk.org>; Thu, 13 Mar 2025 14:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741902729;
 x=1742507529; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TBnfu1uNEzgCP6fwk5yW0k0muMUuH89kDX20gySZM4s=;
 b=1twJXAle9/14cEqHIw9Dmz0bx9/UZlGe5KL7QWEQeqTPjjvC+iiuxvL8rQjJcWFmo0
 eQnYri6IGu7UBH/boxrcIhETUuykP15o5YOSMzOc58e0JIzjcjFYsB8jhoohMc+IbiNz
 CEV+vXiR6PFgq4YXCWxh57rH5dUjapDIghfNzMaF1AdHtD6AuPGk5xygHUSxI2EWXWFH
 iw5gLkM+JYvwYYzf9FUZnc87Hi/78dSq9ZgRlMngTMyN/uiJQavKhRMkEHhV+1LFGJK7
 kQKto8TQjFjmGRrNj5rSOmiV26uU9SnpAxwnEexPGum9B7Vvu0bYoACKsD752Cj0rB62
 Fa5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741902729; x=1742507529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TBnfu1uNEzgCP6fwk5yW0k0muMUuH89kDX20gySZM4s=;
 b=BHGTPtukjNt/tEzBGkr04DFL+gCpLKhRc635PSIO6wEo9Wk/fNiXe6jWQLFnKF+dZR
 5eio5MLZn0u+ik4CQeNj850ZGmZQRaTu/c1b82s/CPqtRjWnVfW3om/NssSwomvVeazE
 UqzYmVUG9rdHAcZ1bIvF2gf5aKnxgO1ndUvFMboXzyvMMRXzzt8zOhPDLi0tdXKkB84F
 aekqizm2kILE26Ds5BjbgoDwaw6g9e6kV6Jte3GVSDj8wxMUOACDTzrcLM8drmQCQnzv
 NE8k18pnZ2UfxHd4fH+M9sBoQC/Vs96I8kzaz5cmjV+5j9DbNCoCPRHdXFfKpdlOJWlP
 scbg==
X-Gm-Message-State: AOJu0Yz612wUvKhWzsnNwA01q1d4+UxSIf/XuBwcJy8T99KlkVApNVjO
 UnvCgDwVMrKSNmQxUM+akMqBWBBzaL3JEEfawicxq/Z7iDjLo/y9SA1WMT+aIQPWxFbgqakqgg+
 7
X-Gm-Gg: ASbGncv4uc/9TS2igbmTEinRNg5/QaomwEweElYrI3DP+8Eia+5SePvZjJkhvLo07vj
 Em1jMb1HrYlm7Eva+LEeVjMKRNCxouU15xply1SQDBQrtbIyxQrzKv981H3DmLS+PO8Dc7yZWN+
 /qSNu4InipRbjbYd4sOQmWS4+l8lFAEdTanldjx55zsaFanTesjMmUB8tGc92IeSgerR3z092u/
 Y+UqJfdTGjQwFrgXpu8t7QH6e0jIileFWvK6HbCokFOHs2AKIFYrw6DVfYhumV1a2tJ1LAKXaA7
 aQ6E7mJd/+au4ZAfP1/OQJ8wFYeB4iKPTgNdBaerDu3FKMepqKdmLIe1keY2ai/o3T+vgGMXYZk
 bzDa9dZHB5g/h+r4wZKZfEA==
X-Google-Smtp-Source: AGHT+IGReiCCqjQwq6u+Orl2khDb5VM1UapX+BC+3yppEsZH9aQoT2YLhX6WENTDPk7q1+yaQ578+w==
X-Received: by 2002:a17:902:f686:b0:223:397f:46be with SMTP id
 d9443c01a7336-225e0aff8abmr1779545ad.47.1741902729431; 
 Thu, 13 Mar 2025 14:52:09 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6bd3d5bsm18337775ad.217.2025.03.13.14.52.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 14:52:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 08/10] net/ioring: support multi-segment Rx and Tx
Date: Thu, 13 Mar 2025 14:50:59 -0700
Message-ID: <20250313215151.292944-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250313215151.292944-1-stephen@networkplumber.org>
References: <20241210212757.83490-1-stephen@networkplumber.org>
 <20250313215151.292944-1-stephen@networkplumber.org>
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
 drivers/net/ioring/rte_eth_ioring.c | 203 ++++++++++++++++++++++------
 1 file changed, 160 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ioring/rte_eth_ioring.c b/drivers/net/ioring/rte_eth_ioring.c
index 18546f0137..633bfc21c2 100644
--- a/drivers/net/ioring/rte_eth_ioring.c
+++ b/drivers/net/ioring/rte_eth_ioring.c
@@ -18,6 +18,7 @@
 #include <linux/if.h>
 #include <linux/if_arp.h>
 #include <linux/if_tun.h>
+#include <linux/virtio_net.h>
 
 #include <bus_vdev_driver.h>
 #include <ethdev_driver.h>
@@ -30,12 +31,18 @@
 #include <rte_kvargs.h>
 #include <rte_log.h>
 
+static_assert(RTE_PKTMBUF_HEADROOM >= sizeof(struct virtio_net_hdr));
+
 #define IORING_DEFAULT_BURST	64
 #define IORING_NUM_BUFFERS	1024
 #define IORING_MAX_QUEUES	128
 
 static_assert(IORING_MAX_QUEUES <= RTE_MP_MAX_FD_NUM, "Max queues exceeds MP fd limit");
 
+#define IORING_TX_OFFLOAD	RTE_ETH_TX_OFFLOAD_MULTI_SEGS
+
+#define IORING_RX_OFFLOAD	RTE_ETH_RX_OFFLOAD_SCATTER
+
 #define IORING_DEFAULT_IFNAME	"itap%d"
 #define IORING_MP_KEY		"ioring_mp_send_fds"
 
@@ -162,7 +169,7 @@ tap_open(const char *name, struct ifreq *ifr, uint8_t persist)
 		goto error;
 	}
 
-	int flags = IFF_TAP | IFF_MULTI_QUEUE | IFF_NO_PI;
+	int flags = IFF_TAP | IFF_MULTI_QUEUE | IFF_NO_PI | IFF_VNET_HDR;
 	if ((features & flags) != flags) {
 		PMD_LOG(ERR, "TUN features %#x missing support for %#x",
 			features, features & flags);
@@ -193,6 +200,13 @@ tap_open(const char *name, struct ifreq *ifr, uint8_t persist)
 		goto error;
 	}
 
+
+	int hdr_size = sizeof(struct virtio_net_hdr);
+	if (ioctl(tap_fd, TUNSETVNETHDRSZ, &hdr_size) < 0) {
+		PMD_LOG(ERR, "ioctl(TUNSETVNETHDRSZ) %s", strerror(errno));
+		goto error;
+	}
+
 	return tap_fd;
 error:
 	close(tap_fd);
@@ -350,6 +364,8 @@ eth_dev_info(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->max_rx_queues = IORING_MAX_QUEUES;
 	dev_info->max_tx_queues = IORING_MAX_QUEUES;
 	dev_info->min_rx_bufsize = 0;
+	dev_info->tx_queue_offload_capa = IORING_TX_OFFLOAD;
+	dev_info->tx_offload_capa = dev_info->tx_queue_offload_capa;
 
 	dev_info->default_rxportconf = (struct rte_eth_dev_portconf) {
 		.burst_size = IORING_DEFAULT_BURST,
@@ -478,7 +494,6 @@ static inline void
 eth_rx_submit(struct rx_queue *rxq, int fd, struct rte_mbuf *mb)
 {
 	struct io_uring_sqe *sqe = io_uring_get_sqe(&rxq->io_ring);
-
 	if (unlikely(sqe == NULL)) {
 		PMD_LOG(DEBUG, "io_uring no rx sqe");
 		rxq->rx_errors++;
@@ -487,10 +502,81 @@ eth_rx_submit(struct rx_queue *rxq, int fd, struct rte_mbuf *mb)
 	}
 	io_uring_sqe_set_data(sqe, mb);
 
-	void *buf = rte_pktmbuf_mtod_offset(mb, void *, 0);
-	unsigned int nbytes = rte_pktmbuf_tailroom(mb);
+	RTE_ASSERT(rte_pktmbuf_headroom(mb) >= sizeof(struct virtio_net_hdr));
+	void *buf = rte_pktmbuf_mtod_offset(mb, void *, -sizeof(struct virtio_net_hdr));
+	unsigned int nbytes = sizeof(struct virtio_net_hdr) + rte_pktmbuf_tailroom(mb);
+
+	/* optimize for the case where packet fits in one mbuf */
+	if (mb->nb_segs == 1) {
+		io_uring_prep_read(sqe, fd, buf, nbytes, 0);
+	} else {
+		uint16_t nsegs = mb->nb_segs;
+		RTE_ASSERT(nsegs > 0 && nsegs < IOV_MAX);
+		struct iovec iovs[RTE_MBUF_MAX_NB_SEGS];
+
+		iovs[0].iov_base = buf;
+		iovs[0].iov_len = nbytes;
+
+		for (uint16_t i = 1; i < nsegs; i++) {
+			mb = mb->next;
+			iovs[i].iov_base = rte_pktmbuf_mtod(mb, void *);
+			iovs[i].iov_len = rte_pktmbuf_tailroom(mb);
+		}
+		io_uring_prep_readv(sqe, fd, iovs, nsegs, 0);
+	}
+
+}
+
+
+/* Allocates one or more mbuf's to be used for reading packets */
+static struct rte_mbuf *
+eth_ioring_rx_alloc(struct rx_queue *rxq)
+{
+	const struct rte_eth_dev *dev = &rte_eth_devices[rxq->port_id];
+	int buf_size = dev->data->mtu;
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
+	__rte_mbuf_sanity_check(m, 1);
+	return m;
+}
+
+
+/* set length of received mbuf segments */
+static inline void
+eth_ioring_rx_adjust(struct rte_mbuf *mb, size_t len)
+{
+	struct rte_mbuf *seg;
+	unsigned int nsegs = 0;
+
+	for (seg = mb; seg != NULL && len > 0; seg = seg->next) {
+		uint16_t seg_len = RTE_MIN(len, rte_pktmbuf_tailroom(mb));
+
+		seg->data_len = seg_len;
+		len -= seg_len;
+		++nsegs;
+	}
 
-	io_uring_prep_read(sqe, fd, buf, nbytes, 0);
+	mb->nb_segs = nsegs;
+	if (len == 0 && seg != NULL) {
+		/* free any residual */
+		rte_pktmbuf_free(seg->next);
+		seg->next = NULL;
+	}
 }
 
 static uint16_t
@@ -505,37 +591,42 @@ eth_ioring_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 	io_uring_for_each_cqe(&rxq->io_ring, head, cqe) {
 		struct rte_mbuf *mb = (void *)(uintptr_t)cqe->user_data;
-		ssize_t len = cqe->res;
+		int32_t len = cqe->res;
 
-		PMD_RX_LOG(DEBUG, "cqe %u len %zd", num_cqe, len);
-		num_cqe++;
+		PMD_RX_LOG(DEBUG, "complete m=%p len=%d", mb, len);
 
-		if (unlikely(len < RTE_ETHER_HDR_LEN)) {
-			if (len < 0)
-				PMD_LOG(ERR, "io_uring_read: %s", strerror(-len));
-			else
-				PMD_LOG(ERR, "io_uring_read missing hdr");
+		num_cqe++;
 
+		struct virtio_net_hdr *hdr;
+		if (unlikely(len < (ssize_t)(sizeof(*hdr) + RTE_ETHER_HDR_LEN))) {
+			PMD_LOG(ERR, "io_uring_read result = %d", len);
 			rxq->rx_errors++;
 			goto resubmit;
 		}
 
-		struct rte_mbuf *nmb = rte_pktmbuf_alloc(rxq->mb_pool);
-		if (unlikely(nmb == 0)) {
-			PMD_LOG(DEBUG, "Rx mbuf alloc failed");
+		/* virtio header is before packet data */
+		hdr = rte_pktmbuf_mtod_offset(mb, struct virtio_net_hdr *, -sizeof(*hdr));
+		len -= sizeof(*hdr);
+
+		struct rte_mbuf *nmb = eth_ioring_rx_alloc(rxq);
+		if (!nmb) {
+			PMD_RX_LOG(NOTICE, "alloc failed");
 			++rxq->rx_nombuf;
 			goto resubmit;
 		}
 
-		mb->pkt_len = len;
-		mb->data_len = len;
 		mb->port = rxq->port_id;
-		__rte_mbuf_sanity_check(mb, 1);
+		mb->pkt_len = len;
+
+		if (mb->nb_segs == 1)
+			mb->data_len = len;
+		else
+			eth_ioring_rx_adjust(mb, len);
 
-		num_bytes += len;
+		num_bytes += mb->pkt_len;
 		bufs[num_rx++] = mb;
 
-		mb = nmb;
+		mb = nmb;	/* use the new buffer when resubmitting */
 resubmit:
 		eth_rx_submit(rxq, fd, mb);
 
@@ -581,20 +672,17 @@ eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id, uint16_t nb_rx_de
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
@@ -701,8 +789,6 @@ eth_ioring_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	if (unlikely(nb_pkts == 0))
 		return 0;
 
-	PMD_TX_LOG(DEBUG, "%d packets to xmit", nb_pkts);
-
 	if (io_uring_sq_space_left(&txq->io_ring) < txq->free_thresh)
 		eth_ioring_tx_cleanup(txq);
 
@@ -710,23 +796,54 @@ eth_ioring_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 	for (num_tx = 0; num_tx < nb_pkts; num_tx++) {
 		struct rte_mbuf *mb = bufs[num_tx];
+		struct virtio_net_hdr *hdr;
 
 		struct io_uring_sqe *sqe = io_uring_get_sqe(&txq->io_ring);
 		if (sqe == NULL)
 			break;	/* submit ring is full */
 
+		if (rte_mbuf_refcnt_read(mb) == 1 &&
+		    RTE_MBUF_DIRECT(mb) &&
+		    rte_pktmbuf_headroom(mb) >= sizeof(*hdr)) {
+			hdr = rte_pktmbuf_mtod_offset(mb, struct virtio_net_hdr *, sizeof(*hdr));
+		} else {
+			struct rte_mbuf *mh = rte_pktmbuf_alloc(mb->pool);
+			if (unlikely(mh == NULL)) {
+				++txq->tx_errors;
+				rte_pktmbuf_free(mb);
+				continue;
+			}
+
+			hdr = rte_pktmbuf_mtod_offset(mh, struct virtio_net_hdr *, sizeof(*hdr));
+			mh->next = mb;
+			mh->nb_segs = mb->nb_segs + 1;
+			mh->pkt_len = mb->pkt_len;
+			mh->ol_flags = mb->ol_flags & RTE_MBUF_F_TX_OFFLOAD_MASK;
+			mb = mh;
+		}
+
 		io_uring_sqe_set_data(sqe, mb);
 
-		if (rte_mbuf_refcnt_read(mb) == 1 &&
-		    RTE_MBUF_DIRECT(mb) && mb->nb_segs == 1) {
-			void *base = rte_pktmbuf_mtod(mb, void *);
-			io_uring_prep_write(sqe, fd, base, mb->pkt_len, 0);
+		PMD_TX_LOG(DEBUG, "write m=%p segs=%u", mb, mb->nb_segs);
+		void *buf = rte_pktmbuf_mtod_offset(mb, void *, -sizeof(*hdr));
+		unsigned int nbytes = sizeof(struct virtio_net_hdr) + mb->data_len;
 
-			PMD_TX_LOG(DEBUG, "tx mbuf: %p submit", mb);
+		if (mb->nb_segs == 1) {
+			io_uring_prep_write(sqe, fd, buf, nbytes, 0);
 		} else {
-			PMD_LOG(ERR, "Can't do mbuf without space yet!");
-			++txq->tx_errors;
-			continue;
+			struct iovec iovs[RTE_MBUF_MAX_NB_SEGS + 1];
+			unsigned int niov = mb->nb_segs;
+
+			iovs[0].iov_base = buf;
+			iovs[0].iov_len = nbytes;
+
+			for (unsigned int i = 1; i < niov; i++) {
+				mb = mb->next;
+				iovs[i].iov_base = rte_pktmbuf_mtod(mb, void *);
+				iovs[i].iov_len = mb->data_len;
+			}
+
+			io_uring_prep_writev(sqe, fd, iovs, niov, 0);
 		}
 	}
 
-- 
2.47.2

