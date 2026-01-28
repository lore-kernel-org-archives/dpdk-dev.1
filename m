Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06160D35690
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 09:36:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F791402D7;
	Wed, 28 Jan 2026 10:36:19 +0100 (CET)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178]) by mails.dpdk.org (Postfix) with ESMTP id 43173402D3
 for <dev@dpdk.org>; Wed, 28 Jan 2026 10:36:17 +0100 (CET)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-2b4520f6b32so10651119eec.0
 for <dev@dpdk.org>; Wed, 28 Jan 2026 01:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769592976; x=1770197776; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7tHZ1TQLa2pbQ5CKNkni1OJh9/OAMMfSXBZoAENjHqk=;
 b=Aqjijzsv9KyjDkjSHxa1UBGgX2jb4y/d0fInJI7R6W/Wx7hR9kZ+Hgj0VqrATMt7je
 Kxwvq4ArqQi+x4Plo1BwxHpWv3bTf5C3Hq2GrIC2wEE3Zd802iusOzv/BMUvSIpBZ65Z
 oy1ny5Pj7sFj4XOE2f2v/zFitYPkwVfVojXPWGoa/kiWMbp4oUI+ZvF5Hzo8MSesXCvv
 Xnqz1n95zWvkt/AaOvFBv/+MqSfoXQhRmfZx/+zb4Oh60nBF+pejGShtR9E3cemnh/YO
 Snv7wrexQSYZycdg4X856i+LJkU7o75N+cpU+D5QpQJaV49khKam2CXkpeuW8BqULT9Q
 UsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769592976; x=1770197776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7tHZ1TQLa2pbQ5CKNkni1OJh9/OAMMfSXBZoAENjHqk=;
 b=iEjGQXcRVJihytw6QiQNh1pDxyeeU90swQzsqoqM1rN7ime7W+/jmDmkD81f2HOYFn
 9jg3okByH4jzoKelhVCkL3fy0Fap5DLKlRuMKRbheEiSnOOpM5/TCdM4kSxjcVG817VC
 oAe+8p4m8FRXEJeor3Y2bFLxionT0djIuuc0k/tuyJ4zralecX9PERaNyzYU8+mg6tq1
 6+FD0CCF9xWUjR5eKN9zNC7c1cBgrY6qE4vC1MY6rYThx2qIp9Clho01noSuV2vX068s
 /POasLwNSluF5YztU789xf42q06ual6Bdo8rO8H/T16EW/S2qjYAUt1S6RlJvK8nxxQ2
 DTFw==
X-Gm-Message-State: AOJu0YzxbxdFXoY5vEsZxxL7YtBpT0cpXuC18faMhb46+A2ZtBWuMU9R
 WUwOV6lujmucL21ri3ZQwK+TBEUFadxfhHQWyl5TY/OsOGtS8etjjkVfNxxz/A==
X-Gm-Gg: AZuq6aL+6BsT2Rx5WzATcPQy4p9Joy937c4PQ0ADRO7Gk2kN9Qj2mglxH//96zBYe85
 RkMhE2ZRGh36TiBcVVzRISTrXlNEIuV/6hHCbSGTkrhshi8onyp0OMstO54tZB2C8z8J5RNBMPn
 84j78q9G87dPEFkr/6pmfTBTYtVQSaS/dK5EmWG+YdHthX2BbGK9V6WFtYhE0hG7n9jbkLr6kQB
 QIGzWKlp/+jzIsYz7/6YC6AIZjSWj8Coq2vSuHD98vhnYHSqtpeB+FBSpuIDbwSjMhgj8lKFPlv
 xCtJhCtMsp0j3Byu5iIAqzanxymryM2BbN0e5xWR+gY8r8flIWaDzFWiswtPUeuah23pUMbiAv0
 R1HKgNeEytdpHm3wxvm0/rV2gHujsBVz/MAHzXZg/4M1xnlT30uyASAvr9qPUctk8Vf0+0+92CC
 76kR+butCZcGF39aaJD1HjYw==
X-Received: by 2002:a05:7300:2319:b0:2b0:738e:287e with SMTP id
 5a478bee46e88-2b78d9b5f93mr2613597eec.30.1769592975969; 
 Wed, 28 Jan 2026 01:36:15 -0800 (PST)
Received: from mac.com ([136.24.82.250]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b7a14bb02csm1834864eec.0.2026.01.28.01.36.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Jan 2026 01:36:15 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: stephen@networkplumber.org, Scott Mitchell <scott.k.mitch1@gmail.com>,
 linville@tuxdriver.com, stable@dpdk.org
Subject: [PATCH v2 1/4] net/af_packet: fix thread safety and frame calculations
Date: Wed, 28 Jan 2026 01:36:04 -0800
Message-Id: <20260128093607.62908-2-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260128093607.62908-1-scott.k.mitch1@gmail.com>
References: <20260127181355.98437-1-scott.k.mitch1@gmail.com>
 <20260128093607.62908-1-scott.k.mitch1@gmail.com>
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

From: Scott Mitchell <scott.k.mitch1@gmail.com>

Thread Safety:
The tp_status field was accessed without proper memory barriers,
violating the kernel's PACKET_MMAP synchronization protocol. The
kernel implements this protocol in net/packet/af_packet.c:
- __packet_get_status: smp_rmb() then READ_ONCE() (volatile read)
- __packet_set_status: WRITE_ONCE() (volatile write) then smp_wmb()

READ_ONCE/WRITE_ONCE use __may_alias__ attribute via __uXX_alias_t
types to prevent compiler optimizations that assume type-based aliasing
rules, which is critical for tp_status access that may be misaligned
within the ring buffer.

Userspace must use equivalent semantics: volatile unaligned_uint32_t
(with __rte_may_alias) reads/writes with explicit memory barriers
(rte_smp_rmb/rte_smp_wmb).

On aarch64 and other weakly-ordered architectures, missing barriers
cause packet corruption because:
- RX: CPU may read stale packet data before seeing tp_status update
- TX: CPU may reorder stores, causing kernel to see tp_status before
  packet data is fully written

This becomes critical with io_uring SQPOLL mode where the kernel
polling thread on a different CPU core asynchronously updates
tp_status, making proper memory ordering essential.

Note: Uses rte_smp_[r/w]mb which triggers checkpatch warnings, but
C11 atomics cannot be used because tp_status is not declared _Atomic
in the kernel's tpacket2_hdr structure. We must match the kernel's
volatile + barrier memory model with __may_alias__ protection.

Frame Calculation Issues:
1. Frame overhead incorrectly calculated as TPACKET_ALIGN(TPACKET2_HDRLEN)
   instead of TPACKET2_HDRLEN - sizeof(struct sockaddr_ll), causing
   incorrect usable frame data size.

2. Frame address calculation assumed sequential layout
   (frame_base + i * frame_size), but the kernel's packet_lookup_frame()
   uses block-based addressing:
     block_idx = position / frames_per_block
     frame_offset = position % frames_per_block
     address = block_start[block_idx] + (frame_offset * frame_size)

   This caused memory corruption when frames don't evenly divide blocks.

Fixes: 364e08f2bbc0 ("af_packet: add PMD for AF_PACKET-based virtual devices")
Cc: linville@tuxdriver.com
Cc: stable@dpdk.org
Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
---
Depends-on: patch-160274 ("eal: add __rte_may_alias to unaligned typedefs")

 drivers/net/af_packet/rte_eth_af_packet.c | 149 +++++++++++++++++-----
 1 file changed, 114 insertions(+), 35 deletions(-)

diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index ef11b8fb6b..6c276bb7fc 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -9,6 +9,8 @@
 #include <rte_common.h>
 #include <rte_string_fns.h>
 #include <rte_mbuf.h>
+#include <rte_atomic.h>
+#include <rte_bitops.h>
 #include <ethdev_driver.h>
 #include <ethdev_vdev.h>
 #include <rte_malloc.h>
@@ -41,6 +43,10 @@
 #define DFLT_FRAME_SIZE		(1 << 11)
 #define DFLT_FRAME_COUNT	(1 << 9)
 
+static const uint16_t ETH_AF_PACKET_FRAME_SIZE_MAX = RTE_IPV4_MAX_PKT_LEN;
+#define ETH_AF_PACKET_FRAME_OVERHEAD (TPACKET2_HDRLEN - sizeof(struct sockaddr_ll))
+#define ETH_AF_PACKET_ETH_OVERHEAD (RTE_ETHER_HDR_LEN + RTE_ETHER_CRC_LEN)
+
 static uint64_t timestamp_dynflag;
 static int timestamp_dynfield_offset = -1;
 
@@ -120,6 +126,28 @@ RTE_LOG_REGISTER_DEFAULT(af_packet_logtype, NOTICE);
 	RTE_LOG_LINE(level, AFPACKET, "%s(): " fmt ":%s", __func__, \
 		## __VA_ARGS__, strerror(errno))
 
+/**
+ * Read tp_status from packet mmap ring. Matches kernel's READ_ONCE() with smp_rmb()
+ * ordering in af_packet.c __packet_get_status.
+ */
+static inline uint32_t
+tpacket_read_status(const volatile void *tp_status)
+{
+	rte_smp_rmb();
+	return *((const volatile unaligned_uint32_t *)tp_status);
+}
+
+/**
+ * Write tp_status to packet mmap ring. Matches kernel's WRITE_ONCE() with smp_wmb()
+ * ordering in af_packet.c __packet_set_status.
+ */
+static inline void
+tpacket_write_status(volatile void *tp_status, uint32_t status)
+{
+	*((volatile unaligned_uint32_t *)tp_status) = status;
+	rte_smp_wmb();
+}
+
 static uint16_t
 eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 {
@@ -129,7 +157,8 @@ eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	uint8_t *pbuf;
 	struct pkt_rx_queue *pkt_q = queue;
 	uint16_t num_rx = 0;
-	unsigned long num_rx_bytes = 0;
+	uint32_t num_rx_bytes = 0;
+	uint32_t tp_status;
 	unsigned int framecount, framenum;
 
 	if (unlikely(nb_pkts == 0))
@@ -144,7 +173,8 @@ eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	for (i = 0; i < nb_pkts; i++) {
 		/* point at the next incoming frame */
 		ppd = (struct tpacket2_hdr *) pkt_q->rd[framenum].iov_base;
-		if ((ppd->tp_status & TP_STATUS_USER) == 0)
+		tp_status = tpacket_read_status(&ppd->tp_status);
+		if ((tp_status & TP_STATUS_USER) == 0)
 			break;
 
 		/* allocate the next mbuf */
@@ -160,7 +190,7 @@ eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		memcpy(rte_pktmbuf_mtod(mbuf, void *), pbuf, rte_pktmbuf_data_len(mbuf));
 
 		/* check for vlan info */
-		if (ppd->tp_status & TP_STATUS_VLAN_VALID) {
+		if (tp_status & TP_STATUS_VLAN_VALID) {
 			mbuf->vlan_tci = ppd->tp_vlan_tci;
 			mbuf->ol_flags |= (RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED);
 
@@ -179,7 +209,7 @@ eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		}
 
 		/* release incoming frame and advance ring buffer */
-		ppd->tp_status = TP_STATUS_KERNEL;
+		tpacket_write_status(&ppd->tp_status, TP_STATUS_KERNEL);
 		if (++framenum >= framecount)
 			framenum = 0;
 		mbuf->port = pkt_q->in_port;
@@ -228,8 +258,8 @@ eth_af_packet_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	struct pollfd pfd;
 	struct pkt_tx_queue *pkt_q = queue;
 	uint16_t num_tx = 0;
-	unsigned long num_tx_bytes = 0;
-	int i;
+	uint32_t num_tx_bytes = 0;
+	uint16_t i;
 
 	if (unlikely(nb_pkts == 0))
 		return 0;
@@ -259,16 +289,6 @@ eth_af_packet_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			}
 		}
 
-		/* point at the next incoming frame */
-		if (!tx_ring_status_available(ppd->tp_status)) {
-			if (poll(&pfd, 1, -1) < 0)
-				break;
-
-			/* poll() can return POLLERR if the interface is down */
-			if (pfd.revents & POLLERR)
-				break;
-		}
-
 		/*
 		 * poll() will almost always return POLLOUT, even if there
 		 * are no extra buffers available
@@ -283,26 +303,28 @@ eth_af_packet_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		 *
 		 * This results in poll() returning POLLOUT.
 		 */
-		if (!tx_ring_status_available(ppd->tp_status))
+		if (unlikely(!tx_ring_status_available(tpacket_read_status(&ppd->tp_status)) &&
+			(poll(&pfd, 1, -1) < 0 || (pfd.revents & POLLERR) != 0 ||
+			 !tx_ring_status_available(tpacket_read_status(&ppd->tp_status))))) {
+			/* Ring is full, stop here. Don't process bufs[i]. */
 			break;
+		}
 
-		/* copy the tx frame data */
-		pbuf = (uint8_t *) ppd + TPACKET2_HDRLEN -
-			sizeof(struct sockaddr_ll);
+		pbuf = (uint8_t *)ppd + ETH_AF_PACKET_FRAME_OVERHEAD;
 
 		struct rte_mbuf *tmp_mbuf = mbuf;
-		while (tmp_mbuf) {
+		do {
 			uint16_t data_len = rte_pktmbuf_data_len(tmp_mbuf);
 			memcpy(pbuf, rte_pktmbuf_mtod(tmp_mbuf, void*), data_len);
 			pbuf += data_len;
 			tmp_mbuf = tmp_mbuf->next;
-		}
+		} while (tmp_mbuf);
 
 		ppd->tp_len = mbuf->pkt_len;
 		ppd->tp_snaplen = mbuf->pkt_len;
 
 		/* release incoming frame and advance ring buffer */
-		ppd->tp_status = TP_STATUS_SEND_REQUEST;
+		tpacket_write_status(&ppd->tp_status, TP_STATUS_SEND_REQUEST);
 		if (++framenum >= framecount)
 			framenum = 0;
 		ppd = (struct tpacket2_hdr *) pkt_q->rd[framenum].iov_base;
@@ -392,10 +414,12 @@ eth_dev_info(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 
 	dev_info->if_index = internals->if_index;
 	dev_info->max_mac_addrs = 1;
-	dev_info->max_rx_pktlen = RTE_ETHER_MAX_LEN;
+	dev_info->max_rx_pktlen = (uint32_t)ETH_AF_PACKET_FRAME_SIZE_MAX +
+		ETH_AF_PACKET_ETH_OVERHEAD;
+	dev_info->max_mtu = ETH_AF_PACKET_FRAME_SIZE_MAX;
 	dev_info->max_rx_queues = (uint16_t)internals->nb_queues;
 	dev_info->max_tx_queues = (uint16_t)internals->nb_queues;
-	dev_info->min_rx_bufsize = 0;
+	dev_info->min_rx_bufsize = ETH_AF_PACKET_ETH_OVERHEAD;
 	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
 		RTE_ETH_TX_OFFLOAD_VLAN_INSERT;
 	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_VLAN_STRIP |
@@ -572,8 +596,7 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 	/* Now get the space available for data in the mbuf */
 	buf_size = rte_pktmbuf_data_room_size(pkt_q->mb_pool) -
 		RTE_PKTMBUF_HEADROOM;
-	data_size = internals->req.tp_frame_size;
-	data_size -= TPACKET2_HDRLEN - sizeof(struct sockaddr_ll);
+	data_size = internals->req.tp_frame_size - ETH_AF_PACKET_FRAME_OVERHEAD;
 
 	if (data_size > buf_size) {
 		PMD_LOG(ERR,
@@ -612,7 +635,7 @@ eth_dev_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
 	int ret;
 	int s;
 	unsigned int data_size = internals->req.tp_frame_size -
-				 TPACKET2_HDRLEN;
+				 ETH_AF_PACKET_FRAME_OVERHEAD;
 
 	if (mtu > data_size)
 		return -EINVAL;
@@ -977,25 +1000,38 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
 		rx_queue->rd = rte_zmalloc_socket(name, rdsize, 0, numa_node);
 		if (rx_queue->rd == NULL)
 			goto error;
+		/* Frame addresses must match kernel's packet_lookup_frame():
+		 * block_idx = position / frames_per_block
+		 * frame_offset = position % frames_per_block
+		 * address = block_start + (frame_offset * frame_size)
+		 */
+		const uint32_t frames_per_block = req->tp_block_size / req->tp_frame_size;
 		for (i = 0; i < req->tp_frame_nr; ++i) {
-			rx_queue->rd[i].iov_base = rx_queue->map + (i * framesize);
+			const uint32_t block_idx = i / frames_per_block;
+			const uint32_t frame_in_block = i % frames_per_block;
+			rx_queue->rd[i].iov_base = rx_queue->map +
+				(block_idx * req->tp_block_size) +
+				(frame_in_block * req->tp_frame_size);
 			rx_queue->rd[i].iov_len = req->tp_frame_size;
 		}
 		rx_queue->sockfd = qsockfd;
 
 		tx_queue = &((*internals)->tx_queue[q]);
 		tx_queue->framecount = req->tp_frame_nr;
-		tx_queue->frame_data_size = req->tp_frame_size;
-		tx_queue->frame_data_size -= TPACKET2_HDRLEN -
-			sizeof(struct sockaddr_ll);
+		tx_queue->frame_data_size = req->tp_frame_size - ETH_AF_PACKET_FRAME_OVERHEAD;
 
 		tx_queue->map = rx_queue->map + req->tp_block_size * req->tp_block_nr;
 
 		tx_queue->rd = rte_zmalloc_socket(name, rdsize, 0, numa_node);
 		if (tx_queue->rd == NULL)
 			goto error;
+		/* See comment above rx_queue->rd initialization. */
 		for (i = 0; i < req->tp_frame_nr; ++i) {
-			tx_queue->rd[i].iov_base = tx_queue->map + (i * framesize);
+			const uint32_t block_idx = i / frames_per_block;
+			const uint32_t frame_in_block = i % frames_per_block;
+			tx_queue->rd[i].iov_base = tx_queue->map +
+				(block_idx * req->tp_block_size) +
+				(frame_in_block * req->tp_frame_size);
 			tx_queue->rd[i].iov_len = req->tp_frame_size;
 		}
 		tx_queue->sockfd = qsockfd;
@@ -1092,7 +1128,8 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 	if (*sockfd < 0)
 		return -1;
 
-	blocksize = getpagesize();
+	const int pagesize = getpagesize();
+	blocksize = pagesize;
 
 	/*
 	 * Walk arguments for configurable settings
@@ -1162,13 +1199,55 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 		return -1;
 	}
 
-	blockcount = framecount / (blocksize / framesize);
+	const unsigned int frames_per_block = blocksize / framesize;
+	blockcount = framecount / frames_per_block;
 	if (!blockcount) {
 		PMD_LOG(ERR,
 			"%s: invalid AF_PACKET MMAP parameters", name);
 		return -1;
 	}
 
+	/*
+	 * https://www.kernel.org/doc/Documentation/networking/packet_mmap.txt
+	 * Check constraints that may be enforced by the kernel and cause failure
+	 * to initialize the rings but explicit error messages aren't provided.
+	 * See packet_set_ring in linux kernel for enforcement:
+	 * https://github.com/torvalds/linux/blob/master/net/packet/af_packet.c
+	 */
+	if (blocksize % pagesize != 0) {
+		/* tp_block_size must be a multiple of PAGE_SIZE */
+		PMD_LOG(WARNING, "%s: %s=%u must be a multiple of PAGE_SIZE=%d",
+			name, ETH_AF_PACKET_BLOCKSIZE_ARG, blocksize, pagesize);
+	}
+	if (framesize % TPACKET_ALIGNMENT != 0) {
+		/* tp_frame_size must be a multiple of TPACKET_ALIGNMENT */
+		PMD_LOG(WARNING, "%s: %s=%u must be a multiple of TPACKET_ALIGNMENT=%d",
+			name, ETH_AF_PACKET_FRAMESIZE_ARG, framesize, TPACKET_ALIGNMENT);
+	}
+	if (frames_per_block == 0 || frames_per_block > UINT_MAX / blockcount ||
+	    framecount != frames_per_block * blockcount) {
+		/* tp_frame_nr must be exactly frames_per_block*tp_block_nr */
+		PMD_LOG(WARNING, "%s: %s=%u must be exactly "
+			"frames_per_block(%s/%s = %u/%u = %u) * blockcount(%u)",
+			name, ETH_AF_PACKET_FRAMECOUNT_ARG, framecount,
+			ETH_AF_PACKET_BLOCKSIZE_ARG, ETH_AF_PACKET_FRAMESIZE_ARG,
+			blocksize, framesize, frames_per_block, blockcount);
+	}
+
+	/* Below conditions may not cause errors but provide hints to improve */
+	if (blocksize % framesize != 0) {
+		PMD_LOG(WARNING, "%s: %s=%u not evenly divisible by %s=%u, "
+			"may waste memory", name,
+			ETH_AF_PACKET_BLOCKSIZE_ARG, blocksize,
+			ETH_AF_PACKET_FRAMESIZE_ARG, framesize);
+	}
+	if (!rte_is_power_of_2(blocksize)) {
+		/* tp_block_size should be a power of two or there will be waste */
+		PMD_LOG(WARNING, "%s: %s=%u should be a power of two "
+			"or there will be a waste of memory",
+			name, ETH_AF_PACKET_BLOCKSIZE_ARG, blocksize);
+	}
+
 	PMD_LOG(DEBUG, "%s: AF_PACKET MMAP parameters:", name);
 	PMD_LOG(DEBUG, "%s:\tblock size %d", name, blocksize);
 	PMD_LOG(DEBUG, "%s:\tblock count %d", name, blockcount);
-- 
2.39.5 (Apple Git-154)

