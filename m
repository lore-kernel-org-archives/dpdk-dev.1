Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66159C636A1
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Feb 2026 17:34:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1188640A8A;
	Sun, 22 Feb 2026 18:33:02 +0100 (CET)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com
 [209.85.167.171])
 by mails.dpdk.org (Postfix) with ESMTP id 49F8640696
 for <dev@dpdk.org>; Sun, 22 Feb 2026 18:32:48 +0100 (CET)
Received: by mail-oi1-f171.google.com with SMTP id
 5614622812f47-45f18e8f2f5so2419266b6e.3
 for <dev@dpdk.org>; Sun, 22 Feb 2026 09:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771781567;
 x=1772386367; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6k7fPpVxoUHrSPsWjaduPVb/GJqp0NeqaiYJHeqXUns=;
 b=UcsF3YvajwvWn0LXWCjxkbDmhnj3Yok4SYLITyRg6c7FVjTelOP6HT5BpHE3IaQSoH
 HnOrV7e0Gp70z3SpI6LkShuqmlGI71onoWtswBex8BeaOVbrK63ykKYf7Uh2R+p7hp9u
 zUUBbuPp0hHcpAkiTinCodo8SgPhRUT2pJb7u1oaRCu+5ba3wiYjVBFzV5b5nrgTsTTK
 wpT3VEKuSRYvZPXxwx7lzG4G0EukDMhHd1iw+57njJ8fNlL+pfiiXPqI+YCmaO5bwCZe
 WHW9wsK0sKQ48XOLomif6aFPEFfmygGxe4ZhPdnbdDPLHFrO57WfQkl10fQVKyaMbs4+
 c9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771781567; x=1772386367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6k7fPpVxoUHrSPsWjaduPVb/GJqp0NeqaiYJHeqXUns=;
 b=RJMhBVUaV3RrlnvLPm68aBYFCJqVjZn1Ky2nJCgPOmlsSs3s7qpK15pT9+vsPMB3vD
 3IqB9ayTgU5o3gCJa8ALGGHcHX1vt0Y6VTet1siYbv5wqVH1lp1OpK67QVwoSR5DuSZ/
 +MnuNPd4BvD4bWrTpqQonK5fSkZT2Dw3pShoMhLQCD6GC5Ut9r/dFRBxDiAsnl/DLfYB
 Us78pFKKSXbRtMFoFPF2LJdg8m3E8qyDK4fIll7zHu1/8BchgWmS+sEK2i20Ps0nuqFh
 Lz6I70pnrhrxrmIWL81hpY5hT+OeFdKk7f96F9v9BSB91mS0mgMyjhTsXDcEzEJGajHL
 EtHQ==
X-Gm-Message-State: AOJu0YyS1k9XFQjLCFW/vjXY2cJrMJj3xvH3jfoPRXyT9Jm4wZI8KQpt
 qTdsfT9ddtycC7RWncqLiTbvr6lmAvtDxW8Pxxh7d3jK5RiOVSCANuHaTZ8nt+9BWckGj2fCWVg
 n70cf
X-Gm-Gg: AZuq6aLoxQUJCdiD1ARbE0iON1jRQ7fr6PzQzEP2I1nrhOGojrF/DXzuaY4asbIFwz5
 0S2br8bcOt8VkUGM8Agf4CUK8jFfaQMWRPeACxYkVY/p8OxjaMDRRMoHNdQCXD2bUWDz4DAaaIL
 wQQEKNfoT7eEO2Ek5Z7uZHqZPbfZE6/w+mDpRTovTNcCySBZ4Qn4YHXM6jr9wKCl/bevgNtvbGZ
 u23mXOXuaGP3H6ah/hGc1Z7Q8QEyh2omDe0zKREjZdJN5JIKLuyEMxw7luFhRsrCDjy1tDdy9uu
 ugvkuRQEd7i8X4drVzPXlKMIcTiunwJrIqt5ZKFUXRRmGX2vOU0kz7HbboajYNNlmzaHyJgT97Y
 11UDjsNq9DO3CMAQhzk8Q9YK90pjAvkQ4ZsC4f4c1pBCgCqu4ujK+Hgoo+SuxQEcSRfCzWxzuAd
 8uJ+ej6jFF1dk4n21nHh2i/IrBMVBMD7leXSPVYYy66PjC5ZXY3uyw9l7gO6vky+3R5uop+S3v
X-Received: by 2002:a05:6808:1a1b:b0:45a:5584:b8ec with SMTP id
 5614622812f47-46446304618mr3210703b6e.32.1771781567520; 
 Sun, 22 Feb 2026 09:32:47 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157d2d7922sm5608972fac.12.2026.02.22.09.32.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 09:32:46 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 17/19] net/tap: consolidate queue statistics
Date: Sun, 22 Feb 2026 09:30:52 -0800
Message-ID: <20260222173225.522754-18-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260222173225.522754-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260222173225.522754-1-stephen@networkplumber.org>
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

The per-queue packet statistics had structure elements
for both transmit and receive but each queue structure
was only used in one direction. Rearrange and get the
correct statistic based on context.

The rx_nombuf statistic can be accumulated in the device
structure and rte_eth_stats_get() handles it from there.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/tap/rte_eth_tap.c | 48 +++++++++++++++++------------------
 drivers/net/tap/rte_eth_tap.h | 17 +++++--------
 2 files changed, 31 insertions(+), 34 deletions(-)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index 9efdbc7012..2630a53ce4 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -467,7 +467,7 @@ pmd_rx_burst(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 		/* Packet couldn't fit in the provided mbuf */
 		if (unlikely(rxq->pi.flags & TUN_PKT_STRIP)) {
-			rxq->stats.ierrors++;
+			rxq->stats.errors++;
 			continue;
 		}
 
@@ -479,7 +479,8 @@ pmd_rx_burst(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			struct rte_mbuf *buf = rte_pktmbuf_alloc(rxq->mp);
 
 			if (unlikely(!buf)) {
-				rxq->stats.rx_nombuf++;
+				rte_eth_devices[rxq->in_port].data->rx_mbuf_alloc_failed++;
+
 				/* No new buf has been allocated: do nothing */
 				if (!new_tail || !seg)
 					goto end;
@@ -524,8 +525,8 @@ pmd_rx_burst(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		num_rx_bytes += mbuf->pkt_len;
 	}
 end:
-	rxq->stats.ipackets += num_rx;
-	rxq->stats.ibytes += num_rx_bytes;
+	rxq->stats.packets += num_rx;
+	rxq->stats.bytes += num_rx_bytes;
 
 	if (trigger && num_rx < nb_pkts)
 		rxq->trigger_seen = trigger;
@@ -709,7 +710,7 @@ pmd_tx_burst(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			tso_segsz = mbuf_in->tso_segsz + hdrs_len;
 			if (unlikely(tso_segsz == hdrs_len) ||
 				tso_segsz > *txq->mtu) {
-				txq->stats.errs++;
+				txq->stats.errors++;
 				break;
 			}
 			gso_ctx->gso_size = tso_segsz;
@@ -747,7 +748,7 @@ pmd_tx_burst(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		ret = tap_write_mbufs(txq, num_mbufs, mbuf,
 				&num_packets, &num_tx_bytes);
 		if (ret == -1) {
-			txq->stats.errs++;
+			txq->stats.errors++;
 			/* free tso mbufs */
 			if (num_tso_mbufs > 0)
 				rte_pktmbuf_free_bulk(mbuf, num_tso_mbufs);
@@ -765,9 +766,9 @@ pmd_tx_burst(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		}
 	}
 
-	txq->stats.opackets += num_packets;
-	txq->stats.errs += nb_pkts - num_tx;
-	txq->stats.obytes += num_tx_bytes;
+	txq->stats.packets += num_packets;
+	txq->stats.errors += nb_pkts - num_tx;
+	txq->stats.bytes += num_tx_bytes;
 
 	return num_tx;
 }
@@ -960,7 +961,7 @@ tap_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *tap_stats,
 	unsigned int i;
 	uint64_t rx_total = 0, tx_total = 0, tx_err_total = 0;
 	uint64_t rx_bytes_total = 0, tx_bytes_total = 0;
-	uint64_t rx_nombuf = 0, ierrors = 0;
+	uint64_t ierrors = 0;
 
 	/* rx queue statistics */
 	for (i = 0; i < dev->data->nb_rx_queues; i++) {
@@ -969,13 +970,12 @@ tap_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *tap_stats,
 		if (rxq == NULL)
 			continue;
 		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			qstats->q_ipackets[i] = rxq->stats.ipackets;
-			qstats->q_ibytes[i] = rxq->stats.ibytes;
+			qstats->q_ipackets[i] = rxq->stats.packets;
+			qstats->q_ibytes[i] = rxq->stats.bytes;
 		}
-		rx_total += rxq->stats.ipackets;
-		rx_bytes_total += rxq->stats.ibytes;
-		rx_nombuf += rxq->stats.rx_nombuf;
-		ierrors += rxq->stats.ierrors;
+		rx_total += rxq->stats.packets;
+		rx_bytes_total += rxq->stats.bytes;
+		ierrors += rxq->stats.errors;
 	}
 
 	/* tx queue statistics */
@@ -985,21 +985,21 @@ tap_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *tap_stats,
 		if (txq == NULL)
 			continue;
 		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			qstats->q_opackets[i] = txq->stats.opackets;
-			qstats->q_obytes[i] = txq->stats.obytes;
+			qstats->q_opackets[i] = txq->stats.packets;
+			qstats->q_obytes[i] = txq->stats.bytes;
 		}
-		tx_total += txq->stats.opackets;
-		tx_bytes_total += txq->stats.obytes;
-		tx_err_total += txq->stats.errs;
+		tx_total += txq->stats.packets;
+		tx_bytes_total += txq->stats.bytes;
+		tx_err_total += txq->stats.errors;
 	}
 
 	tap_stats->ipackets = rx_total;
 	tap_stats->ibytes = rx_bytes_total;
 	tap_stats->ierrors = ierrors;
-	tap_stats->rx_nombuf = rx_nombuf;
 	tap_stats->opackets = tx_total;
 	tap_stats->oerrors = tx_err_total;
 	tap_stats->obytes = tx_bytes_total;
+
 	return 0;
 }
 
@@ -1012,14 +1012,14 @@ tap_stats_reset(struct rte_eth_dev *dev)
 		struct rx_queue *rxq = dev->data->rx_queues[i];
 
 		if (rxq != NULL)
-			memset(&rxq->stats, 0, sizeof(struct pkt_stats));
+			memset(&rxq->stats, 0, sizeof(rxq->stats));
 	}
 
 	for (i = 0; i < dev->data->nb_tx_queues; i++) {
 		struct tx_queue *txq = dev->data->tx_queues[i];
 
 		if (txq != NULL)
-			memset(&txq->stats, 0, sizeof(struct pkt_stats));
+			memset(&txq->stats, 0, sizeof(txq->stats));
 	}
 
 	return 0;
diff --git a/drivers/net/tap/rte_eth_tap.h b/drivers/net/tap/rte_eth_tap.h
index 78182b1185..fc7086e97d 100644
--- a/drivers/net/tap/rte_eth_tap.h
+++ b/drivers/net/tap/rte_eth_tap.h
@@ -9,6 +9,7 @@
 #include <sys/queue.h>
 #include <sys/uio.h>
 #include <inttypes.h>
+#include <limits.h>
 #include <net/if.h>
 
 #include <linux/if_tun.h>
@@ -33,14 +34,10 @@ enum rte_tuntap_type {
 	ETH_TUNTAP_TYPE_MAX,
 };
 
-struct pkt_stats {
-	uint64_t opackets;              /* Number of output packets */
-	uint64_t ipackets;              /* Number of input packets */
-	uint64_t obytes;                /* Number of bytes on output */
-	uint64_t ibytes;                /* Number of bytes on input */
-	uint64_t errs;                  /* Number of TX error packets */
-	uint64_t ierrors;               /* Number of RX error packets */
-	uint64_t rx_nombuf;             /* Nb of RX mbuf alloc failures */
+struct queue_stats {
+	uint64_t packets;
+	uint64_t bytes;
+	uint64_t errors;
 };
 
 struct rx_queue {
@@ -48,7 +45,7 @@ struct rx_queue {
 	uint32_t trigger_seen;          /* Last seen Rx trigger value */
 	uint16_t in_port;               /* Port ID */
 	uint16_t queue_id;		/* queue ID*/
-	struct pkt_stats stats;         /* Stats for this RX queue */
+	struct queue_stats stats;        /* Stats for this RX queue */
 	uint16_t max_rx_segs;           /* max scatter segments per packet */
 	struct rte_eth_rxmode *rxmode;  /* RX features */
 	struct rte_mbuf *pool;          /* mbufs pool for this queue */
@@ -60,7 +57,7 @@ struct tx_queue {
 	int type;                       /* Type field - TUN|TAP */
 	uint16_t *mtu;                  /* Pointer to MTU from dev_data */
 	uint16_t csum:1;                /* Enable checksum offloading */
-	struct pkt_stats stats;         /* Stats for this TX queue */
+	struct queue_stats stats;        /* Stats for this TX queue */
 	struct rte_gso_ctx gso_ctx;     /* GSO context */
 	uint16_t out_port;              /* Port ID */
 	uint16_t queue_id;		/* queue ID*/
-- 
2.51.0

