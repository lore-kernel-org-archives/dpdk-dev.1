Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF00AECD9AA
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 01:12:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCEC940430;
	Fri,  6 Feb 2026 02:12:07 +0100 (CET)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176]) by mails.dpdk.org (Postfix) with ESMTP id 630934042F
 for <dev@dpdk.org>; Fri,  6 Feb 2026 02:12:06 +0100 (CET)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-2b71515d8adso1447730eec.1
 for <dev@dpdk.org>; Thu, 05 Feb 2026 17:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770340325; x=1770945125; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aU14F0exCjFcxw6FHtoA8hjbGd/FpK8gKmiZX3jkWek=;
 b=L9K37mLzp1ABOJf3BgtWfk7Bd2MgIZ9+N9ljo+zAEkaV96+zWxptcinS+fw8I1XnlF
 y693wUIiZ+eo+GdDdfdc5Qq2fw+/Vh01vCnU1TH73NZRiDOXuEWInrc83hjPEH/dWKTL
 Uf7jkbY7ULCsdYl5Nd4JRsJgRI0/AmE/4ojK52O9M0U9cKGtKjGO/JCF/5gaCmiJQelo
 USFVu+g5SRu+9D+cu+tUrwB+xZJXXIDVYrU9z2rWqK5oeC+JqvYS8YBMySio1S5QG42j
 TS9S56SWsPF7e9PcjpWEwVA3nJpebmjAp1bL6Mrhf+Nesw6pBcydFwIM7W35qicjcZWE
 nIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770340325; x=1770945125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aU14F0exCjFcxw6FHtoA8hjbGd/FpK8gKmiZX3jkWek=;
 b=e/rxfs6kgo8xQ6zkL+pX47ZzZJjB/IUtLKTOxDyRDnyxkAI6GMDiSl0xLl3YjeBngC
 +xOhwxfXUMsYYajyYEVV3hYz+LQA85xMPyGp7XL2CCgNWtJ6dm6vGC8XVEzmxEGfT3pe
 /I2ho13PG7ZJWLL+7Z75WJI4c3CXQ5i7tk5laWxN0u+aa8vxqRz8q+OMDVVXYv1+Wrdl
 kFN5tx6/BQQdKRvMYosUAxsk1epiCK2FBqJdEXicTdjc9gqucx/DiFDpHaE2PhZo4RcS
 ZWnHx7gdxAJegTcSjKev5pDvMZdRwWlld5+udyVHEZf2Vct7mqaxVlGzJGwlV0kBfP7g
 C5iA==
X-Gm-Message-State: AOJu0YxbTfQ44W84ALuFWTADxY1cROTWLqnzF9Zz+g2W9/i/LuEVp8DM
 6vzlXQrIHQrTUw+IljfiZI2yD3mwgqQw/Vh0Ia4uMFmEF+FzuYH/wSqTbesJpg==
X-Gm-Gg: AZuq6aIGZgsZowG9k+715c2tZJciW1TWrPydLrBLoUgEVO1O+TyFHsN5QXUh1cVmdzN
 7CgoDJ0yswl0BLKXHtOaVib3tEfRH249FZBoOeApZLcCUZMLqmM/7UfNRYBzPhVwLalWAPcE50M
 WGF6+6uXsvMXRPnUXa36IRCDDiev7utdnBhfbk7X0jIRAJA4ziHsldjmMg715QZoEy3kAL5eany
 U6dQPrznssp7vt/eCD1xITY2PoaWxCPh7M/Fo4lVQlv2eLFAYPSOC7UkYXm3NcHaTmUe6iHPrYY
 mX3APhFqzNX/npP1turXl+O5tq0Grboxiad/GBPAwFWP73HT1NcKc1N600ArK//qzmJCX/EraUo
 Db6dnUS0DUFiY29n/LFlXpXfAEBTeTClPvDx67GCHJqjA31TvRqSxMVLTi83cK7BOX5O6gAWPOD
 agJom4ihUHE2/QCzhUonu8/3zIKCQuliTe++AF8A8WcjMQlwBJfOsZ
X-Received: by 2002:a05:7301:2f91:b0:2ae:5ddf:e223 with SMTP id
 5a478bee46e88-2b85647c454mr454937eec.15.1770340325047; 
 Thu, 05 Feb 2026 17:12:05 -0800 (PST)
Received: from mr41p01nt-relayp03.apple.com ([216.157.103.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b855afc852sm711730eec.13.2026.02.05.17.11.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Feb 2026 17:12:04 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: stephen@networkplumber.org, Scott Mitchell <scott.k.mitch1@gmail.com>,
 linville@tuxdriver.com, stable@dpdk.org
Subject: [PATCH v6 1/4] net/af_packet: fix thread safety and frame calculations
Date: Thu,  5 Feb 2026 17:11:38 -0800
Message-Id: <20260206011141.2377-2-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260206011141.2377-1-scott.k.mitch1@gmail.com>
References: <20260203070740.62305-1-scott.k.mitch1@gmail.com>
 <20260206011141.2377-1-scott.k.mitch1@gmail.com>
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
 doc/guides/rel_notes/release_26_03.rst    |   6 +-
 drivers/net/af_packet/rte_eth_af_packet.c | 151 ++++++++++++++++------
 2 files changed, 119 insertions(+), 38 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 031eaa657e..5eebed5023 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -55,6 +55,11 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Updated af_packet net driver.**
+
+  * Fixed kernel memory barrier protocol for memory availability
+  * Fixed shared memory frame overhead offset calculation
+
 * **Updated AMD axgbe ethernet driver.**
 
   * Added support for V4000 Krackan2e.
@@ -63,7 +68,6 @@ New Features
 
   * Added support for pre and post VF reset callbacks.
 
-
 Removed Items
 -------------
 
diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index c0ba3381ea..78ed3fb858 100644
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
 
+static const uint16_t eth_af_packet_frame_size_max = RTE_IPV4_MAX_PKT_LEN;
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
+	dev_info->max_rx_pktlen = (uint32_t)eth_af_packet_frame_size_max +
+		ETH_AF_PACKET_ETH_OVERHEAD;
+	dev_info->max_mtu = eth_af_packet_frame_size_max;
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
@@ -1081,7 +1117,8 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 	struct rte_kvargs_pair *pair = NULL;
 	unsigned k_idx;
 	unsigned int blockcount;
-	unsigned int blocksize;
+	const int pagesize = getpagesize();
+	unsigned int blocksize = pagesize;
 	unsigned int framesize = DFLT_FRAME_SIZE;
 	unsigned int framecount = DFLT_FRAME_COUNT;
 	unsigned int qpairs = 1;
@@ -1092,8 +1129,6 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 	if (*sockfd < 0)
 		return -1;
 
-	blocksize = getpagesize();
-
 	/*
 	 * Walk arguments for configurable settings
 	 */
@@ -1162,13 +1197,55 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
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

