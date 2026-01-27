Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3D7D2FED0
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 18:15:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44B5842788;
	Tue, 27 Jan 2026 19:15:18 +0100 (CET)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by mails.dpdk.org (Postfix) with ESMTP id 75F7C40DD0
 for <dev@dpdk.org>; Tue, 27 Jan 2026 19:15:16 +0100 (CET)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-1248d27f2b9so4237916c88.0
 for <dev@dpdk.org>; Tue, 27 Jan 2026 10:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769537715; x=1770142515; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LiSiigt6jNLZB/5K8MndlV/bHxnFT+7hUrXJVfxUmCg=;
 b=UozIrgabzFd12aqcrmMiwHM+g4jvcrjMXNCvX/IR2nLR2kVmOUvfGPbkwB35+Cd7nY
 X4yxVOf8ejWUZckzQeMb0FGrqgVYVxYBZb2Iqyu7BYRvb8CR2Y+EjNB+SYd9HwMEZwd4
 mEPTOs8vgLNrWWYoju766HbwhUYnBXi4mL61j8xPypMZngtEQuc0Y5/moX5HqRPTNY7C
 VYwf/SruFInbc5vnNJTu/SlwkbeeJEPc70EVFpkyY6BA2Jqs56XVlhZAOe0h20L/nFxH
 6cbefcz6rZIIwuJ96XwlrnFV4J1aYuEr46ALG4UOSVaSJb9bAtmn2/eol/gK0BUbknfT
 xyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769537715; x=1770142515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LiSiigt6jNLZB/5K8MndlV/bHxnFT+7hUrXJVfxUmCg=;
 b=BUJjy0uTgVNIIWS6tAwrJXat04oSVex90n/eU1ntzUKDq1xJiJ3LGAYbXE2K+KV2KY
 WZIWJIIki402cggsMLp5K0yQfCLCQROs2ED8m171qAjJUJcX9siu7cSMKPucebGPqIuP
 VE940uYbXiRhzxm6H1wZLrgFZaSDtF4UftrrnA8HcHQ0BuX7illZAfpmDNsE+9KdMEnp
 xzvsUNZ50fbxfYupUbkDWFSCKFs/XAZmZivH0XZXKcaZFj1ghMDK0lY36Crvlo1Lffna
 6ngUxWI/3LIhhpyQiF0uymPOuceCN6NbEXfhCpCp0J18xUZYzohzRYe0AmuPEQcwsrst
 4pRw==
X-Gm-Message-State: AOJu0YwDlWJWh2Yhp2P3os3/nvBlYnloeBagbyQrTRL03TNb5BwPVOEf
 AKRJI+mZpvmT0inz92e2gvmWY1fB3a9AQkyHiVFQlCDC7Jjd7nRBblHNG9CX8Q==
X-Gm-Gg: AZuq6aLdeKHrht+QsE0NgP8kFNp8GU+jJLQf856BlcDs0pYGv/ycggbRJNXj2j+dKXW
 RlNzGSmBMZsE0obwGrFytRfz2Y6L4+QftKYEgvhTKR4ROHQAz0CoVAMGNdFfEm5jydvIhEUIR7u
 DZSTiYVcVg4+4q6LjDjRkwifDyZwuA/1AJ4yQxk+8Vz/K34/YBVEVbK0EaugfpsiI5m8qWAvd5n
 ffQruRFzo1LzjRhfGJM7nKyFc8nmqY07tJXw3Fa8VGU6e0L6f5PGYD63HoVp5DZWRRW2PM5HiF+
 I5wDQrzBs0IePhYO6Jh+yvZfj3Y3+vDcFqWsfJvmyzXfYvcem7dwj2sOHZARvvxzmHOu0FgUAy4
 f5Y99HcCQ/abuis3kioza8QhdQtLv/3de3Us1RmLsVi1IakWLZD/T5SsTgW0SnpDEIjFZue5pxp
 J2paBaGEqHYTDcsiCBYVxFQrqQ/RfnpvBa8NnADhYYMFFgTl5vS+EXvnNs5RIM
X-Received: by 2002:a05:7022:1e0f:b0:11b:9b98:aa4b with SMTP id
 a92af1059eb24-124a0065d5amr1395165c88.6.1769537714834; 
 Tue, 27 Jan 2026 10:15:14 -0800 (PST)
Received: from mr41p01nt-relayp03.apple.com ([17.199.85.102])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-124a7bf8f5dsm483172c88.7.2026.01.27.10.15.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Jan 2026 10:15:14 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: Scott Mitchell <scott.k.mitch1@gmail.com>, linville@tuxdriver.com,
 stable@dpdk.org
Subject: [PATCH v1 1/3] net/af_packet: fix thread safety and frame calculations
Date: Tue, 27 Jan 2026 10:13:53 -0800
Message-Id: <20260127181355.98437-2-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260127181355.98437-1-scott.k.mitch1@gmail.com>
References: <20260127181355.98437-1-scott.k.mitch1@gmail.com>
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

The AF_PACKET driver had multiple correctness issues that could
cause data races and memory corruption in multi-threaded environments.

Thread Safety Issues:

1. Statistics counters (rx_pkts, tx_pkts, rx_bytes, tx_bytes, etc.)
   were declared as 'volatile unsigned long' which provides no
   atomicity guarantees and can cause torn reads/writes on 32-bit
   platforms or when the compiler uses multiple instructions.

2. The tp_status field was accessed without memory barriers, violating
   the kernel's synchronization protocol. The kernel uses READ_ONCE/
   WRITE_ONCE with smp_rmb() barriers (see __packet_get_status and
   __packet_set_status in net/packet/af_packet.c). Userspace must
   use equivalent atomic operations with acquire/release semantics.

3. Statistics are collected in datapath threads but consumed by
   management threads calling eth_stats_get(), creating unsynchronized
   cross-thread access.

These issues become more critical with upcoming features like io_uring
SQPOLL mode, where the kernel's submission queue polling thread operates
independently and asynchronously updates tp_status from a different CPU
core, making proper memory ordering essential.

Frame Calculation Issues:

4. Frame overhead was incorrectly calculated, failing to account for
   the TPACKET2_HDRLEN structure layout and sockaddr_ll offset.

5. Frame address calculation assumed sequential frame layout
   (frame_base + i * frame_size), but the kernel's
   packet_lookup_frame() uses block-based addressing:
   block_start + (frame_in_block * frame_size). This causes memory
   corruption when block_size is not evenly divisible by frame_size.

Changes:

- Replace 'volatile unsigned long' counters with RTE_ATOMIC(uint64_t)
- Use rte_atomic_load_explicit() with rte_memory_order_acquire when
  reading tp_status (matching kernel's smp_rmb() + READ_ONCE())
- Use rte_atomic_store_explicit() with rte_memory_order_release when
  writing tp_status (matching kernel's WRITE_ONCE() protocol)
- Use rte_memory_order_relaxed for statistics updates (no ordering
  required between independent counters)
- Fix ETH_AF_PACKET_FRAME_OVERHEAD calculation
- Fix frame address calculation to match kernel's packet_lookup_frame()
- Add validation warnings for kernel constraints (alignment, block/frame
  relationships)
- Merge separate stat collection loops in eth_stats_get() for efficiency

Fixes: 364e08f2bbc0 ("af_packet: add PMD for AF_PACKET-based virtual devices")
Cc: linville@tuxdriver.com
Cc: stable@dpdk.org
Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
---
 drivers/net/af_packet/rte_eth_af_packet.c | 227 +++++++++++++++-------
 1 file changed, 158 insertions(+), 69 deletions(-)

diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index ef11b8fb6b..2ee52a402b 100644
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
 
@@ -57,10 +63,10 @@ struct __rte_cache_aligned pkt_rx_queue {
 	uint8_t vlan_strip;
 	uint8_t timestamp_offloading;
 
-	volatile unsigned long rx_pkts;
-	volatile unsigned long rx_bytes;
-	volatile unsigned long rx_nombuf;
-	volatile unsigned long rx_dropped_pkts;
+	RTE_ATOMIC(uint64_t) rx_pkts;
+	RTE_ATOMIC(uint64_t) rx_bytes;
+	RTE_ATOMIC(uint64_t) rx_nombuf;
+	RTE_ATOMIC(uint64_t) rx_dropped_pkts;
 };
 
 struct __rte_cache_aligned pkt_tx_queue {
@@ -72,9 +78,9 @@ struct __rte_cache_aligned pkt_tx_queue {
 	unsigned int framecount;
 	unsigned int framenum;
 
-	volatile unsigned long tx_pkts;
-	volatile unsigned long err_pkts;
-	volatile unsigned long tx_bytes;
+	RTE_ATOMIC(uint64_t) tx_pkts;
+	RTE_ATOMIC(uint64_t) err_pkts;
+	RTE_ATOMIC(uint64_t) tx_bytes;
 };
 
 struct pmd_internals {
@@ -129,7 +135,7 @@ eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	uint8_t *pbuf;
 	struct pkt_rx_queue *pkt_q = queue;
 	uint16_t num_rx = 0;
-	unsigned long num_rx_bytes = 0;
+	uint32_t num_rx_bytes = 0;
 	unsigned int framecount, framenum;
 
 	if (unlikely(nb_pkts == 0))
@@ -144,13 +150,16 @@ eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	for (i = 0; i < nb_pkts; i++) {
 		/* point at the next incoming frame */
 		ppd = (struct tpacket2_hdr *) pkt_q->rd[framenum].iov_base;
-		if ((ppd->tp_status & TP_STATUS_USER) == 0)
+		uint32_t tp_status = rte_atomic_load_explicit(&ppd->tp_status,
+					rte_memory_order_acquire);
+		if ((tp_status & TP_STATUS_USER) == 0)
 			break;
 
 		/* allocate the next mbuf */
 		mbuf = rte_pktmbuf_alloc(pkt_q->mb_pool);
 		if (unlikely(mbuf == NULL)) {
-			pkt_q->rx_nombuf++;
+			rte_atomic_fetch_add_explicit(&pkt_q->rx_nombuf, 1,
+				rte_memory_order_relaxed);
 			break;
 		}
 
@@ -160,7 +169,7 @@ eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		memcpy(rte_pktmbuf_mtod(mbuf, void *), pbuf, rte_pktmbuf_data_len(mbuf));
 
 		/* check for vlan info */
-		if (ppd->tp_status & TP_STATUS_VLAN_VALID) {
+		if (tp_status & TP_STATUS_VLAN_VALID) {
 			mbuf->vlan_tci = ppd->tp_vlan_tci;
 			mbuf->ol_flags |= (RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED);
 
@@ -179,7 +188,8 @@ eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		}
 
 		/* release incoming frame and advance ring buffer */
-		ppd->tp_status = TP_STATUS_KERNEL;
+		rte_atomic_store_explicit(&ppd->tp_status, TP_STATUS_KERNEL,
+					rte_memory_order_release);
 		if (++framenum >= framecount)
 			framenum = 0;
 		mbuf->port = pkt_q->in_port;
@@ -190,8 +200,8 @@ eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		num_rx_bytes += mbuf->pkt_len;
 	}
 	pkt_q->framenum = framenum;
-	pkt_q->rx_pkts += num_rx;
-	pkt_q->rx_bytes += num_rx_bytes;
+	rte_atomic_fetch_add_explicit(&pkt_q->rx_pkts, num_rx, rte_memory_order_relaxed);
+	rte_atomic_fetch_add_explicit(&pkt_q->rx_bytes, num_rx_bytes, rte_memory_order_relaxed);
 	return num_rx;
 }
 
@@ -228,8 +238,8 @@ eth_af_packet_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	struct pollfd pfd;
 	struct pkt_tx_queue *pkt_q = queue;
 	uint16_t num_tx = 0;
-	unsigned long num_tx_bytes = 0;
-	int i;
+	uint32_t num_tx_bytes = 0;
+	uint16_t i;
 
 	if (unlikely(nb_pkts == 0))
 		return 0;
@@ -259,16 +269,6 @@ eth_af_packet_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
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
@@ -283,26 +283,31 @@ eth_af_packet_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		 *
 		 * This results in poll() returning POLLOUT.
 		 */
-		if (!tx_ring_status_available(ppd->tp_status))
+		if (unlikely(!tx_ring_status_available(rte_atomic_load_explicit(&ppd->tp_status,
+				rte_memory_order_acquire)) &&
+			(poll(&pfd, 1, -1) < 0 || (pfd.revents & POLLERR) != 0 ||
+			 !tx_ring_status_available(rte_atomic_load_explicit(&ppd->tp_status,
+					 rte_memory_order_acquire))))) {
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
+		rte_atomic_store_explicit(&ppd->tp_status, TP_STATUS_SEND_REQUEST,
+					rte_memory_order_release);
 		if (++framenum >= framecount)
 			framenum = 0;
 		ppd = (struct tpacket2_hdr *) pkt_q->rd[framenum].iov_base;
@@ -326,9 +331,9 @@ eth_af_packet_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	}
 
 	pkt_q->framenum = framenum;
-	pkt_q->tx_pkts += num_tx;
-	pkt_q->err_pkts += i - num_tx;
-	pkt_q->tx_bytes += num_tx_bytes;
+	rte_atomic_fetch_add_explicit(&pkt_q->tx_pkts, num_tx, rte_memory_order_relaxed);
+	rte_atomic_fetch_add_explicit(&pkt_q->err_pkts, i - num_tx, rte_memory_order_relaxed);
+	rte_atomic_fetch_add_explicit(&pkt_q->tx_bytes, num_tx_bytes, rte_memory_order_relaxed);
 	return i;
 }
 
@@ -392,10 +397,12 @@ eth_dev_info(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 
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
@@ -436,24 +443,42 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats, struct eth_q
 
 	for (i = 0; i < internal->nb_queues; i++) {
 		/* reading drop count clears the value, therefore keep total value */
-		internal->rx_queue[i].rx_dropped_pkts +=
-			packet_drop_count(internal->rx_queue[i].sockfd);
-
-		rx_total += internal->rx_queue[i].rx_pkts;
-		rx_bytes_total += internal->rx_queue[i].rx_bytes;
-		rx_dropped_total += internal->rx_queue[i].rx_dropped_pkts;
-		rx_nombuf_total += internal->rx_queue[i].rx_nombuf;
-
-		tx_total += internal->tx_queue[i].tx_pkts;
-		tx_err_total += internal->tx_queue[i].err_pkts;
-		tx_bytes_total += internal->tx_queue[i].tx_bytes;
+		uint64_t rx_curr_dropped_pkts = packet_drop_count(internal->rx_queue[i].sockfd);
+		uint64_t rx_prev_dropped_pkts =
+			rte_atomic_fetch_add_explicit(&internal->rx_queue[i].rx_dropped_pkts,
+					rx_curr_dropped_pkts,
+					rte_memory_order_relaxed);
+
+		uint64_t rx_pkts = rte_atomic_load_explicit(&internal->rx_queue[i].rx_pkts,
+					rte_memory_order_relaxed);
+		uint64_t rx_bytes = rte_atomic_load_explicit(&internal->rx_queue[i].rx_bytes,
+					rte_memory_order_relaxed);
+		uint64_t rx_nombuf = rte_atomic_load_explicit(&internal->rx_queue[i].rx_nombuf,
+					rte_memory_order_relaxed);
+
+
+		uint64_t tx_pkts = rte_atomic_load_explicit(&internal->tx_queue[i].tx_pkts,
+					rte_memory_order_relaxed);
+		uint64_t tx_bytes = rte_atomic_load_explicit(&internal->tx_queue[i].tx_bytes,
+					rte_memory_order_relaxed);
+		uint64_t err_pkts = rte_atomic_load_explicit(&internal->tx_queue[i].err_pkts,
+					rte_memory_order_relaxed);
+
+		rx_total += rx_pkts;
+		rx_bytes_total += rx_bytes;
+		rx_nombuf_total += rx_nombuf;
+		rx_dropped_total += (rx_curr_dropped_pkts + rx_prev_dropped_pkts);
+
+		tx_total += tx_pkts;
+		tx_err_total += err_pkts;
+		tx_bytes_total += tx_bytes;
 
 		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			qstats->q_ipackets[i] = internal->rx_queue[i].rx_pkts;
-			qstats->q_ibytes[i] = internal->rx_queue[i].rx_bytes;
-			qstats->q_opackets[i] = internal->tx_queue[i].tx_pkts;
-			qstats->q_obytes[i] = internal->tx_queue[i].tx_bytes;
-			qstats->q_errors[i] = internal->rx_queue[i].rx_nombuf;
+			qstats->q_ipackets[i] = rx_pkts;
+			qstats->q_ibytes[i] = rx_bytes;
+			qstats->q_opackets[i] = tx_pkts;
+			qstats->q_obytes[i] = tx_bytes;
+			qstats->q_errors[i] = rx_nombuf;
 		}
 	}
 
@@ -477,14 +502,21 @@ eth_stats_reset(struct rte_eth_dev *dev)
 		/* clear socket counter */
 		packet_drop_count(internal->rx_queue[i].sockfd);
 
-		internal->rx_queue[i].rx_pkts = 0;
-		internal->rx_queue[i].rx_bytes = 0;
-		internal->rx_queue[i].rx_nombuf = 0;
-		internal->rx_queue[i].rx_dropped_pkts = 0;
-
-		internal->tx_queue[i].tx_pkts = 0;
-		internal->tx_queue[i].err_pkts = 0;
-		internal->tx_queue[i].tx_bytes = 0;
+		rte_atomic_store_explicit(&internal->rx_queue[i].rx_pkts, 0,
+				rte_memory_order_relaxed);
+		rte_atomic_store_explicit(&internal->rx_queue[i].rx_bytes, 0,
+				rte_memory_order_relaxed);
+		rte_atomic_store_explicit(&internal->rx_queue[i].rx_nombuf, 0,
+				rte_memory_order_relaxed);
+		rte_atomic_store_explicit(&internal->rx_queue[i].rx_dropped_pkts, 0,
+				rte_memory_order_relaxed);
+
+		rte_atomic_store_explicit(&internal->tx_queue[i].tx_pkts, 0,
+				rte_memory_order_relaxed);
+		rte_atomic_store_explicit(&internal->tx_queue[i].err_pkts, 0,
+				rte_memory_order_relaxed);
+		rte_atomic_store_explicit(&internal->tx_queue[i].tx_bytes, 0,
+				rte_memory_order_relaxed);
 	}
 
 	return 0;
@@ -572,8 +604,7 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 	/* Now get the space available for data in the mbuf */
 	buf_size = rte_pktmbuf_data_room_size(pkt_q->mb_pool) -
 		RTE_PKTMBUF_HEADROOM;
-	data_size = internals->req.tp_frame_size;
-	data_size -= TPACKET2_HDRLEN - sizeof(struct sockaddr_ll);
+	data_size = internals->req.tp_frame_size - ETH_AF_PACKET_FRAME_OVERHEAD;
 
 	if (data_size > buf_size) {
 		PMD_LOG(ERR,
@@ -612,7 +643,7 @@ eth_dev_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
 	int ret;
 	int s;
 	unsigned int data_size = internals->req.tp_frame_size -
-				 TPACKET2_HDRLEN;
+				 ETH_AF_PACKET_FRAME_OVERHEAD;
 
 	if (mtu > data_size)
 		return -EINVAL;
@@ -977,8 +1008,18 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
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
@@ -994,8 +1035,13 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
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
@@ -1092,7 +1138,8 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 	if (*sockfd < 0)
 		return -1;
 
-	blocksize = getpagesize();
+	const int pagesize = getpagesize();
+	blocksize = pagesize;
 
 	/*
 	 * Walk arguments for configurable settings
@@ -1162,13 +1209,55 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
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

