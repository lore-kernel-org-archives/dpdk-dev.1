Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE0DEF584D
	for <dpdk-dev@archiver.kernel.org>; Sat, 14 Feb 2026 23:48:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26C9240676;
	Sun, 15 Feb 2026 00:47:52 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 2688240676
 for <dev@dpdk.org>; Sun, 15 Feb 2026 00:47:49 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-48371119eacso19186395e9.2
 for <dev@dpdk.org>; Sat, 14 Feb 2026 15:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771112869;
 x=1771717669; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F8OQRi7gYJhdLm5hCC104xj1d188QTHEi8mm1B0uZkw=;
 b=DT+uv5Hoxa0pJRGm793hFVWMCUw+61hqv3+2Lnfv8fB9tCBhQyqNjHKcsRlp6NY2gc
 eDKEXWBuFbgceLCJxUHvyOuQ4c43HxRW2zwR6pkyBdyOv3yvMFAOF7PnTwYrzgkpKd2H
 vWRjrpr6RpCVG0PfAxBRJEwkbNs/DMXEh2u4r1z0Q924kv/+YBHCmgPNCBfzuWyObb5k
 lts5YkPwyuAqVyKIFOqOs+YRlz6cAogiTMJamb4dMgc+dEIMdoJ2gyqAr4/6UzT7i9up
 DCNcFp9ik6c1XmODvVyihq9e6iQuprvryxQDMLiKSCP3sW5c3jX+mgQbsEOvA1fUIJ1M
 izVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771112869; x=1771717669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F8OQRi7gYJhdLm5hCC104xj1d188QTHEi8mm1B0uZkw=;
 b=UNqQ0wkTPXtmxBf9NtT084w2llXw1x6kHtoHdWdECai2mEoHDSVS5A71lm/Q3Sr8Lr
 plfLq2E/NTQxK5qFQjX6xAxCMnk4wVorecHLcszW/4ThxTBRfk0yZbqwKCnNQAaznMPk
 zud1Gtg1B2Q9Od/MtPv33PgaavrbSnXoRLACDcPMiNcdwMGvItVB7nlEVKnF7CxlOTKD
 9kKGqxKQsQBW0JxjUIjKjlGF4G+6BNNCVnsTLdodsDQDM1Va9mUJ/TROEEa30px+GIbZ
 zNS7XPXi68feu6QxPcxhzCZVM6bQAUkPpku6YVSVDNYH40NkgX4aOBbvm/eQZm0afYyf
 yrfg==
X-Gm-Message-State: AOJu0Yzd9DlynZZNOT7Rh5ykK2wLLJ6kTbBwLZTttd08+IZFzC4kHwHY
 5fO1jAipOe5YkTdO3QEa5qgpL69MqrRUltjPjalsUCXWKGhfJjLBHWEJwKa/VzBe0Ig6bI1KP7z
 sLAKK
X-Gm-Gg: AZuq6aL5Dd8QAsThE/LoUoK+uA06tYgq+tYZpUTt2ANYvFCk//gbRZzjjYcuxN0V6lx
 oA8pAA0EEtNe5wSL5HON0l/78RmBUeZHH1ygbnfGfc3gzJBxW2crc3tOC2e7BFnEY3q1veFulUC
 9ZAj0kBEX410E0iuxKZMO6HN4eUG32KDvPFISK3WzZqdmWdcR1EC7cGezJoRCV7uYdJ+p7n6aLc
 3UHveXwTx9FXSQGDBiaMLe3cx+J68igZIXo34RKptmqw1abld0U5mtFV1+OeIUc3pksDEOKvJ7n
 t6sdhooy3W5hUrksGjV0IK1isEfprOLZSZsvlA0+0ltKgmnOpKaG+vRKOJPK5p56p5FTsSuAdpE
 FKXC4Iuv1p1JQ/woPkVGyCik1JKxxTkC/jDGfMXhoTsKV5Y8FEVST6ReqJVCYfdOGoxbh+m0wVj
 IaoTY85tv6mk6q3/NxEfHpCxNbPXofaVtcbGqIxPtTBPSGnlkmZB7Ye58T3O40bZW1/iQrt7SoB
 Mg=
X-Received: by 2002:a05:600c:19cc:b0:477:7bca:8b34 with SMTP id
 5b1f17b1804b1-48373a082eamr97484535e9.6.1771112868663; 
 Sat, 14 Feb 2026 15:47:48 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd1bsm394921485e9.6.2026.02.14.15.47.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Feb 2026 15:47:48 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 10/11] net/rtap: add extended statistics support
Date: Sat, 14 Feb 2026 15:44:19 -0800
Message-ID: <20260214234726.188947-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260214234726.188947-1-stephen@networkplumber.org>
References: <20241210212757.83490-1-stephen@networkplumber.org>
 <20260214234726.188947-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add xstats support to rtap PMD following the virtio PMD design pattern.

Statistics provided per queue (14 Rx + 12 Tx):
- Packet size distribution (6 buckets: 64, 65-127, 128-255, 256-511,
  512-1023, 1024-1518 bytes)
- Packet type classification (broadcast, multicast, unicast)
- Rx offload stats (LRO, checksum validation, mbuf alloc failures)
- Tx offload stats (TSO, checksum offload, multi-segment packets)

Statistics follow DPDK naming convention:
  {direction}_q{queue_id}_{detail}_{unit}

Examples:
  rx_q0_size_64_packets
  rx_q0_broadcast_packets
  rx_q0_lro_packets
  tx_q0_tso_packets
  tx_q0_checksum_offload_packets

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/features/rtap.ini |   1 +
 drivers/net/rtap/meson.build      |   1 +
 drivers/net/rtap/rtap.h           |  41 +++++
 drivers/net/rtap/rtap_ethdev.c    |   3 +
 drivers/net/rtap/rtap_rxtx.c      |   3 +
 drivers/net/rtap/rtap_xstats.c    | 293 ++++++++++++++++++++++++++++++
 6 files changed, 342 insertions(+)
 create mode 100644 drivers/net/rtap/rtap_xstats.c

diff --git a/doc/guides/nics/features/rtap.ini b/doc/guides/nics/features/rtap.ini
index 48fe3f1b33..233227e7d4 100644
--- a/doc/guides/nics/features/rtap.ini
+++ b/doc/guides/nics/features/rtap.ini
@@ -15,6 +15,7 @@ Basic stats          = Y
 Stats per queue      = Y
 TSO                  = Y
 L4 checksum offload  = Y
+Extended stats       = P
 Multiprocess aware   = Y
 Linux                = Y
 ARMv7                = Y
diff --git a/drivers/net/rtap/meson.build b/drivers/net/rtap/meson.build
index 58943e035a..835d1e557d 100644
--- a/drivers/net/rtap/meson.build
+++ b/drivers/net/rtap/meson.build
@@ -22,6 +22,7 @@ sources = files(
         'rtap_intr.c',
         'rtap_netlink.c',
         'rtap_rxtx.c',
+        'rtap_xstats.c',
 )
 
 ext_deps += liburing
diff --git a/drivers/net/rtap/rtap.h b/drivers/net/rtap/rtap.h
index 2c17117a80..ac4a616e99 100644
--- a/drivers/net/rtap/rtap.h
+++ b/drivers/net/rtap/rtap.h
@@ -35,6 +35,22 @@ extern int rtap_logtype;
 #define PMD_TX_LOG(...) do { } while (0)
 #endif
 
+/* Packet size buckets for xstats (similar to virtio PMD) */
+#define RTAP_NUM_PKT_SIZE_BUCKETS	6
+
+/* Extended statistics for Rx queues */
+struct rtap_rx_xstats {
+	uint64_t size_bins[RTAP_NUM_PKT_SIZE_BUCKETS];
+	uint64_t broadcast_packets;
+	uint64_t multicast_packets;
+	uint64_t unicast_packets;
+	uint64_t lro_packets;
+	uint64_t checksum_good;
+	uint64_t checksum_none;
+	uint64_t checksum_bad;
+	uint64_t mbuf_alloc_failed;
+};
+
 struct rtap_rx_queue {
 	struct rte_mempool *mb_pool;	/* rx buffer pool */
 	struct io_uring io_ring;	/* queue of posted read's */
@@ -45,8 +61,21 @@ struct rtap_rx_queue {
 	uint64_t rx_packets;
 	uint64_t rx_bytes;
 	uint64_t rx_errors;
+
+	struct rtap_rx_xstats xstats;	/* extended statistics */
 } __rte_cache_aligned;
 
+/* Extended statistics for Tx queues */
+struct rtap_tx_xstats {
+	uint64_t size_bins[RTAP_NUM_PKT_SIZE_BUCKETS];
+	uint64_t broadcast_packets;
+	uint64_t multicast_packets;
+	uint64_t unicast_packets;
+	uint64_t tso_packets;
+	uint64_t checksum_offload;
+	uint64_t multiseg_packets;
+};
+
 struct rtap_tx_queue {
 	struct io_uring io_ring;
 	uint16_t port_id;
@@ -56,6 +85,8 @@ struct rtap_tx_queue {
 	uint64_t tx_packets;
 	uint64_t tx_bytes;
 	uint64_t tx_errors;
+
+	struct rtap_tx_xstats xstats;	/* extended statistics */
 } __rte_cache_aligned;
 
 struct rtap_pmd {
@@ -108,4 +139,14 @@ void rtap_rx_intr_vec_uninstall(struct rte_eth_dev *dev);
 int rtap_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id);
 int rtap_rx_queue_intr_disable(struct rte_eth_dev *dev, uint16_t queue_id);
 
+/* rtap_xstats.c */
+int rtap_xstats_get_names(struct rte_eth_dev *dev,
+			  struct rte_eth_xstat_name *xstats_names,
+			  unsigned int limit);
+int rtap_xstats_get(struct rte_eth_dev *dev, struct rte_eth_xstat *xstats,
+		    unsigned int n);
+int rtap_xstats_reset(struct rte_eth_dev *dev);
+void rtap_rx_xstats_update(struct rtap_rx_queue *rxq, struct rte_mbuf *mb);
+void rtap_tx_xstats_update(struct rtap_tx_queue *txq, struct rte_mbuf *mb);
+
 #endif /* _RTAP_H_ */
diff --git a/drivers/net/rtap/rtap_ethdev.c b/drivers/net/rtap/rtap_ethdev.c
index 2cbb66b675..eb581608cc 100644
--- a/drivers/net/rtap/rtap_ethdev.c
+++ b/drivers/net/rtap/rtap_ethdev.c
@@ -541,6 +541,9 @@ static const struct eth_dev_ops rtap_ops = {
 	.allmulticast_disable	= rtap_allmulticast_disable,
 	.stats_get		= rtap_stats_get,
 	.stats_reset		= rtap_stats_reset,
+	.xstats_get		= rtap_xstats_get,
+	.xstats_get_names	= rtap_xstats_get_names,
+	.xstats_reset		= rtap_xstats_reset,
 	.rx_queue_setup		= rtap_rx_queue_setup,
 	.rx_queue_release	= rtap_rx_queue_release,
 	.tx_queue_setup		= rtap_tx_queue_setup,
diff --git a/drivers/net/rtap/rtap_rxtx.c b/drivers/net/rtap/rtap_rxtx.c
index cd9b4f0bac..f0ea53b8cf 100644
--- a/drivers/net/rtap/rtap_rxtx.c
+++ b/drivers/net/rtap/rtap_rxtx.c
@@ -289,6 +289,7 @@ rtap_rx_burst(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 			PMD_RX_LOG(ERR, "Rx mbuf alloc failed");
 			dev->data->rx_mbuf_alloc_failed++;
+			rxq->xstats.mbuf_alloc_failed++;
 
 			nmb = mb;	 /* Reuse original */
 			goto resubmit;
@@ -317,6 +318,7 @@ rtap_rx_burst(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		mb->port = rxq->port_id;
 
 		__rte_mbuf_sanity_check(mb, 1);
+		rtap_rx_xstats_update(rxq, mb);
 		num_bytes += mb->pkt_len;
 		bufs[num_rx++] = mb;
 
@@ -735,6 +737,7 @@ rtap_tx_burst(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 		io_uring_sqe_set_data(sqe, mb);
 		rtap_tx_offload(hdr, mb);
+		rtap_tx_xstats_update(txq, mb);
 
 		PMD_TX_LOG(DEBUG, "write m=%p segs=%u", mb, mb->nb_segs);
 
diff --git a/drivers/net/rtap/rtap_xstats.c b/drivers/net/rtap/rtap_xstats.c
new file mode 100644
index 0000000000..b5886844c5
--- /dev/null
+++ b/drivers/net/rtap/rtap_xstats.c
@@ -0,0 +1,293 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2026 Stephen Hemminger
+ */
+
+#include <stdio.h>
+#include <stddef.h>
+#include <stdint.h>
+#include <string.h>
+
+#include <rte_common.h>
+#include <ethdev_driver.h>
+#include <rte_ethdev.h>
+#include <rte_ether.h>
+
+#include "rtap.h"
+
+/*
+ * Xstats name/offset descriptors, following the virtio PMD pattern.
+ *
+ * Both xstats_get_names and xstats_get iterate these same tables
+ * in the same per-queue order, guaranteeing name[i] matches value[i].
+ */
+struct rtap_xstats_name_off {
+	const char *name;
+	unsigned int offset;
+};
+
+#define RTAP_RXQ_XSTAT(field) { #field, offsetof(struct rtap_rx_xstats, field) }
+#define RTAP_TXQ_XSTAT(field) { #field, offsetof(struct rtap_tx_xstats, field) }
+
+static const struct rtap_xstats_name_off rtap_rxq_xstats[] = {
+	RTAP_RXQ_XSTAT(size_bins[0]),
+	RTAP_RXQ_XSTAT(size_bins[1]),
+	RTAP_RXQ_XSTAT(size_bins[2]),
+	RTAP_RXQ_XSTAT(size_bins[3]),
+	RTAP_RXQ_XSTAT(size_bins[4]),
+	RTAP_RXQ_XSTAT(size_bins[5]),
+	RTAP_RXQ_XSTAT(broadcast_packets),
+	RTAP_RXQ_XSTAT(multicast_packets),
+	RTAP_RXQ_XSTAT(unicast_packets),
+	RTAP_RXQ_XSTAT(lro_packets),
+	RTAP_RXQ_XSTAT(checksum_good),
+	RTAP_RXQ_XSTAT(checksum_none),
+	RTAP_RXQ_XSTAT(checksum_bad),
+	RTAP_RXQ_XSTAT(mbuf_alloc_failed),
+};
+
+static const struct rtap_xstats_name_off rtap_txq_xstats[] = {
+	RTAP_TXQ_XSTAT(size_bins[0]),
+	RTAP_TXQ_XSTAT(size_bins[1]),
+	RTAP_TXQ_XSTAT(size_bins[2]),
+	RTAP_TXQ_XSTAT(size_bins[3]),
+	RTAP_TXQ_XSTAT(size_bins[4]),
+	RTAP_TXQ_XSTAT(size_bins[5]),
+	RTAP_TXQ_XSTAT(broadcast_packets),
+	RTAP_TXQ_XSTAT(multicast_packets),
+	RTAP_TXQ_XSTAT(unicast_packets),
+	RTAP_TXQ_XSTAT(tso_packets),
+	RTAP_TXQ_XSTAT(checksum_offload),
+	RTAP_TXQ_XSTAT(multiseg_packets),
+};
+
+/* Display names for size buckets (indexed by array position) */
+static const char * const rtap_size_bucket_names[] = {
+	"size_64",
+	"size_65_to_127",
+	"size_128_to_255",
+	"size_256_to_511",
+	"size_512_to_1023",
+	"size_1024_to_1518",
+};
+
+/* Size bucket upper bounds for the update helpers */
+static const uint16_t rtap_size_bucket_limits[RTAP_NUM_PKT_SIZE_BUCKETS] = {
+	64, 127, 255, 511, 1023, 1518,
+};
+
+#define RTAP_NUM_RXQ_XSTATS RTE_DIM(rtap_rxq_xstats)
+#define RTAP_NUM_TXQ_XSTATS RTE_DIM(rtap_txq_xstats)
+
+static unsigned int
+rtap_xstats_count(const struct rte_eth_dev *dev)
+{
+	return dev->data->nb_rx_queues * RTAP_NUM_RXQ_XSTATS +
+	       dev->data->nb_tx_queues * RTAP_NUM_TXQ_XSTATS;
+}
+
+/*
+ * Build a display name for a per-queue xstat.
+ *
+ * For size_bins[N] entries, use the human-readable bucket name;
+ * for everything else, use the field name directly.
+ */
+static void
+rtap_xstat_name(char *buf, size_t bufsz,
+		const char *dir, unsigned int q,
+		const struct rtap_xstats_name_off *desc)
+{
+	/* Check if this is a size_bins entry */
+	for (unsigned int i = 0; i < RTAP_NUM_PKT_SIZE_BUCKETS; i++) {
+		char binref[32];
+
+		snprintf(binref, sizeof(binref), "size_bins[%u]", i);
+		if (strcmp(desc->name, binref) == 0) {
+			snprintf(buf, bufsz, "%s_q%u_%s_packets",
+				 dir, q, rtap_size_bucket_names[i]);
+			return;
+		}
+	}
+
+	snprintf(buf, bufsz, "%s_q%u_%s", dir, q, desc->name);
+}
+
+int
+rtap_xstats_get_names(struct rte_eth_dev *dev,
+		      struct rte_eth_xstat_name *xstats_names,
+		      unsigned int limit)
+{
+	unsigned int nb_rx = dev->data->nb_rx_queues;
+	unsigned int nb_tx = dev->data->nb_tx_queues;
+	unsigned int count = rtap_xstats_count(dev);
+	unsigned int idx = 0;
+
+	if (xstats_names == NULL)
+		return count;
+
+	/* Rx queue stats: all stats for queue 0, then all for queue 1, ... */
+	for (unsigned int q = 0; q < nb_rx; q++) {
+		for (unsigned int i = 0; i < RTAP_NUM_RXQ_XSTATS; i++) {
+			if (idx >= limit)
+				goto out;
+
+			rtap_xstat_name(xstats_names[idx].name,
+					sizeof(xstats_names[idx].name),
+					"rx", q, &rtap_rxq_xstats[i]);
+			idx++;
+		}
+	}
+
+	/* Tx queue stats: all stats for queue 0, then all for queue 1, ... */
+	for (unsigned int q = 0; q < nb_tx; q++) {
+		for (unsigned int i = 0; i < RTAP_NUM_TXQ_XSTATS; i++) {
+			if (idx >= limit)
+				goto out;
+
+			rtap_xstat_name(xstats_names[idx].name,
+					sizeof(xstats_names[idx].name),
+					"tx", q, &rtap_txq_xstats[i]);
+			idx++;
+		}
+	}
+
+out:
+	return count;
+}
+
+int
+rtap_xstats_get(struct rte_eth_dev *dev, struct rte_eth_xstat *xstats,
+		unsigned int n)
+{
+	unsigned int nb_rx = dev->data->nb_rx_queues;
+	unsigned int nb_tx = dev->data->nb_tx_queues;
+	unsigned int count = rtap_xstats_count(dev);
+	unsigned int idx = 0;
+
+	if (n < count)
+		return count;
+
+	/* Collect Rx queue xstats — same per-queue order as names */
+	for (unsigned int q = 0; q < nb_rx; q++) {
+		struct rtap_rx_queue *rxq = dev->data->rx_queues[q];
+
+		for (unsigned int i = 0; i < RTAP_NUM_RXQ_XSTATS; i++) {
+			xstats[idx].id = idx;
+			if (rxq == NULL)
+				xstats[idx].value = 0;
+			else
+				xstats[idx].value =
+					*(uint64_t *)((char *)&rxq->xstats +
+						       rtap_rxq_xstats[i].offset);
+			idx++;
+		}
+	}
+
+	/* Collect Tx queue xstats — same per-queue order as names */
+	for (unsigned int q = 0; q < nb_tx; q++) {
+		struct rtap_tx_queue *txq = dev->data->tx_queues[q];
+
+		for (unsigned int i = 0; i < RTAP_NUM_TXQ_XSTATS; i++) {
+			xstats[idx].id = idx;
+			if (txq == NULL)
+				xstats[idx].value = 0;
+			else
+				xstats[idx].value =
+					*(uint64_t *)((char *)&txq->xstats +
+						       rtap_txq_xstats[i].offset);
+			idx++;
+		}
+	}
+
+	return idx;
+}
+
+int
+rtap_xstats_reset(struct rte_eth_dev *dev)
+{
+	for (unsigned int q = 0; q < dev->data->nb_rx_queues; q++) {
+		struct rtap_rx_queue *rxq = dev->data->rx_queues[q];
+		if (rxq != NULL)
+			memset(&rxq->xstats, 0, sizeof(rxq->xstats));
+	}
+
+	for (unsigned int q = 0; q < dev->data->nb_tx_queues; q++) {
+		struct rtap_tx_queue *txq = dev->data->tx_queues[q];
+		if (txq != NULL)
+			memset(&txq->xstats, 0, sizeof(txq->xstats));
+	}
+
+	return 0;
+}
+
+/* Helper to update Rx xstats — called from rx_burst */
+void
+rtap_rx_xstats_update(struct rtap_rx_queue *rxq, struct rte_mbuf *mb)
+{
+	struct rtap_rx_xstats *xs = &rxq->xstats;
+	uint16_t pkt_len = mb->pkt_len;
+	struct rte_ether_hdr *eth_hdr;
+
+	/* Update size bucket */
+	for (unsigned int i = 0; i < RTAP_NUM_PKT_SIZE_BUCKETS; i++) {
+		if (pkt_len <= rtap_size_bucket_limits[i]) {
+			xs->size_bins[i]++;
+			break;
+		}
+	}
+
+	/* Update packet type counters */
+	eth_hdr = rte_pktmbuf_mtod(mb, struct rte_ether_hdr *);
+	if (rte_is_broadcast_ether_addr(&eth_hdr->dst_addr))
+		xs->broadcast_packets++;
+	else if (rte_is_multicast_ether_addr(&eth_hdr->dst_addr))
+		xs->multicast_packets++;
+	else
+		xs->unicast_packets++;
+
+	/* Update offload-related counters */
+	if (mb->ol_flags & RTE_MBUF_F_RX_LRO)
+		xs->lro_packets++;
+
+	if (mb->ol_flags & RTE_MBUF_F_RX_L4_CKSUM_GOOD)
+		xs->checksum_good++;
+	else if (mb->ol_flags & RTE_MBUF_F_RX_L4_CKSUM_NONE)
+		xs->checksum_none++;
+	else if (mb->ol_flags & RTE_MBUF_F_RX_L4_CKSUM_BAD)
+		xs->checksum_bad++;
+}
+
+/* Helper to update Tx xstats — called from tx_burst */
+void
+rtap_tx_xstats_update(struct rtap_tx_queue *txq, struct rte_mbuf *mb)
+{
+	struct rtap_tx_xstats *xs = &txq->xstats;
+	uint16_t pkt_len = mb->pkt_len;
+	struct rte_ether_hdr *eth_hdr;
+
+	/* Update size bucket */
+	for (unsigned int i = 0; i < RTAP_NUM_PKT_SIZE_BUCKETS; i++) {
+		if (pkt_len <= rtap_size_bucket_limits[i]) {
+			xs->size_bins[i]++;
+			break;
+		}
+	}
+
+	/* Update packet type counters */
+	eth_hdr = rte_pktmbuf_mtod(mb, struct rte_ether_hdr *);
+	if (rte_is_broadcast_ether_addr(&eth_hdr->dst_addr))
+		xs->broadcast_packets++;
+	else if (rte_is_multicast_ether_addr(&eth_hdr->dst_addr))
+		xs->multicast_packets++;
+	else
+		xs->unicast_packets++;
+
+	/* Update offload-related counters */
+	if (mb->ol_flags & RTE_MBUF_F_TX_TCP_SEG)
+		xs->tso_packets++;
+
+	if ((mb->ol_flags & RTE_MBUF_F_TX_L4_MASK) != 0)
+		xs->checksum_offload++;
+
+	if (mb->nb_segs > 1)
+		xs->multiseg_packets++;
+}
-- 
2.51.0

