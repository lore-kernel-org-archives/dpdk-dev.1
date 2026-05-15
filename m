Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B34ECD4851
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 May 2026 23:20:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D39CB40678;
	Sat, 16 May 2026 01:19:50 +0200 (CEST)
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com
 [209.85.219.74]) by mails.dpdk.org (Postfix) with ESMTP id CEA7D40664
 for <dev@dpdk.org>; Sat, 16 May 2026 01:19:46 +0200 (CEST)
Received: by mail-qv1-f74.google.com with SMTP id
 6a1803df08f44-8b7e68098dcso9999476d6.3
 for <dev@dpdk.org>; Fri, 15 May 2026 16:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1778887186; x=1779491986; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=XrnqlyDwMskxRqSoXl+Q10wX7n1dmV3dW/Um/+WXfWg=;
 b=pKxOsd66dkN/JsTNpFg8Xb5K1CQ3DVU5Kl+65rnWmdEB2WDdLE1S4e9A0/yddQFBqe
 Phybn5hI/h1NVlFJiTSCkHgFG3YJlA2VsDKCYlFO8EHwwMckUicr/Dzi0u8XSiZWAVk6
 U7g0iLTRNPvBuLTP2LCvOsYp/n/FgDMDpKoPgfeFjiDbhwVpwyiZT765ePV9ia2Hz7e9
 r566zwHn/c4T4uDv+w2LxBtp0IYOeA+FPof9I/tZgmGLC27p56wrgZ7GfA6KPCXjI0Nm
 Uu2JMtLQlO05JmpIUU1pHvQQnpPCsEacN8FFYZfRfQIIbXkO5YHXN852vlIZWS0X0y3o
 utjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778887186; x=1779491986;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XrnqlyDwMskxRqSoXl+Q10wX7n1dmV3dW/Um/+WXfWg=;
 b=jU4A5AvV+zPTqEtnDeXrowFurF9YfGVgOlBx+teqNDvDZwGN47TxkxdbVW8eKXGwpL
 C/tIcq1wFXJWbG+0vUYJMQFj2lO7SL6U9jpxZNwbswJzN93vOt6Yio2tVdbpO5FJe0Wi
 DmD+ZtO4BiM6465ccEZzkUgTWSnYdZp53yrFEJQVX+QVd01//r2GU6T6ITJehQS4foF5
 lRclAzjjBve7e7j/DgY7YFXGKJqDAJrn/aI+9tQqh4alcjBhnUjQG1P4p+wxWeJCK2Q2
 IFeapyh5RJZ+ky3ZY4zLp/V7V+7KRm/vmXRBkG1LkcDswqizxQRG6Ro3blxm9cL+kcw+
 Tvcw==
X-Gm-Message-State: AOJu0YxYrSscZhpUCEb5h2vIBnKcsjcGwwJX74VZv03QJ7BluzUAWLE7
 Ss8h0GgysBH5PHl3oVUZbwS5s3kn5lm4z1Y9SycjvIoagl8VhVuf4Kru0EOHT5OVrvwAoD2t5vp
 v0YbPjg==
X-Received: from qvhc11.prod.google.com ([2002:ad4:5aeb:0:b0:8c3:376a:5132])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:a0c:f109:0:b0:89c:4f67:8d17
 with SMTP id 6a1803df08f44-8ca0f5c46ddmr80898696d6.8.1778887185662; Fri, 15
 May 2026 16:19:45 -0700 (PDT)
Date: Fri, 15 May 2026 23:19:35 +0000
In-Reply-To: <20260515231936.3296603-1-blasko@google.com>
Mime-Version: 1.0
References: <20260511224354.872997-1-blasko@google.com>
 <20260515231936.3296603-1-blasko@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515231936.3296603-7-blasko@google.com>
Subject: [PATCH v2 6/6] net/gve: reconstruct HW timestamps from DQO
From: Mark Blasko <blasko@google.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, Mark Blasko <blasko@google.com>, 
 Joshua Washington <joshwash@google.com>,
 "Jasper Tran O'Leary" <jtranoleary@google.com>
Content-Type: text/plain; charset="UTF-8"
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

A full 64-bit NIC timestamp is periodically synced via an AdminQ
command and cached in the driver. In the RX datapath, this cached
value is used as a base to expand the 32-bit hardware timestamp into
a full 64-bit value, which is then stored in the mbuf's dynamic
timestamp field.

Signed-off-by: Mark Blasko <blasko@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Jasper Tran O'Leary <jtranoleary@google.com>
---
v2:
    - Scoped timestamp offload capability advertisement strictly
      to DQO queues.
    - Predicated capability advertisement directly on memzone
      allocation.
    - Initialized mbuf_timestamp_offset to -1.
    - Added blank line separating release notes.
---
 doc/guides/nics/features/gve.ini       |  1 +
 doc/guides/nics/gve.rst                | 20 ++++++++++++++++++++
 doc/guides/rel_notes/release_26_07.rst |  4 ++++
 drivers/net/gve/base/gve_desc_dqo.h    |  8 ++++++--
 drivers/net/gve/gve_ethdev.c           | 15 ++++++++++++++-
 drivers/net/gve/gve_ethdev.h           | 25 +++++++++++++++++++++++++
 drivers/net/gve/gve_rx_dqo.c           | 26 ++++++++++++++++++++++++++
 7 files changed, 96 insertions(+), 3 deletions(-)

diff --git a/doc/guides/nics/features/gve.ini b/doc/guides/nics/features/gve.ini
index 89c97fd27a..117ad4fc65 100644
--- a/doc/guides/nics/features/gve.ini
+++ b/doc/guides/nics/features/gve.ini
@@ -13,6 +13,7 @@ RSS hash             = Y
 RSS key update       = Y
 RSS reta update      = Y
 L4 checksum offload  = Y
+Timestamp offload    = Y
 Basic stats          = Y
 FreeBSD              = Y
 Linux                = Y
diff --git a/doc/guides/nics/gve.rst b/doc/guides/nics/gve.rst
index 62648c47ed..4c820ac5a6 100644
--- a/doc/guides/nics/gve.rst
+++ b/doc/guides/nics/gve.rst
@@ -72,6 +72,7 @@ Supported features of the GVE PMD are:
 - Tx UDP/TCP/SCTP Checksum
 - RSS hash configuration
 - RSS redirection table query and update
+- Timestamp offload
 
 Currently, only GQI_QPL and GQI_RDA queue format are supported in PMD.
 Jumbo Frame is not supported in PMD for now.
@@ -132,6 +133,25 @@ Security Protocols
 - Flow priorities are not supported (must be 0).
 - Masking is limited to full matches i.e. ``0x00...0`` or ``0xFF...F``.
 
+Timestamp Offload
+^^^^^^^^^^^^^^^^^
+
+The driver supports hardware-based packet timestamping on supported
+devices via the standard ``RTE_ETH_RX_OFFLOAD_TIMESTAMP`` offload capability.
+While the ethdev ``.read_clock`` operation works regardless of queue format,
+per-packet RX timestamp offloading requires the DQO queue format.
+
+**Limitations**
+
+- If the driver fails to fetch the NIC hardware clock for 7 consecutive periods,
+  the cached timestamp is marked as stale,
+  and the reconstructed timestamps are no longer propagated to the mbuf.
+- The timestamp reconstruction is only accurate
+  if the time between a packet's reception
+  and the last hardware clock sync is less than approximately 2 seconds.
+  The driver's internal clock sync period is set to respect this limitation.
+
+
 Device Reset
 ^^^^^^^^^^^^
 
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 1b012c4776..f07152fe14 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -63,6 +63,10 @@ New Features
     ``rte_eal_init`` and the application is responsible for probing each device,
   * ``--auto-probing`` enables the initial bus probing, which is the current default behavior.
 
+* **Updated Google GVE net driver.**
+
+  * Added hardware timestamping support on DQO queues.
+
 * **Updated PCAP ethernet driver.**
 
   * Added support for VLAN insertion and stripping.
diff --git a/drivers/net/gve/base/gve_desc_dqo.h b/drivers/net/gve/base/gve_desc_dqo.h
index 71d9d60bb9..c1534959c2 100644
--- a/drivers/net/gve/base/gve_desc_dqo.h
+++ b/drivers/net/gve/base/gve_desc_dqo.h
@@ -226,7 +226,8 @@ struct gve_rx_compl_desc_dqo {
 
 	u8 status_error1;
 
-	__le16 reserved5;
+	u8 reserved5;
+	u8 ts_sub_nsecs_low;
 	__le16 buf_id; /* Buffer ID which was sent on the buffer queue. */
 
 	union {
@@ -237,9 +238,12 @@ struct gve_rx_compl_desc_dqo {
 	};
 	__le32 hash;
 	__le32 reserved6;
-	__le64 reserved7;
+	__le32 reserved7;
+	__le32 ts; /* timestamp in nanosecs */
 } __packed;
 
+#define GVE_DQO_RX_HWTSTAMP_VALID 0x1
+
 GVE_CHECK_STRUCT_LEN(32, gve_rx_compl_desc_dqo);
 
 /* Ringing the doorbell too often can hurt performance.
diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index c600062faf..c0c715f804 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -214,6 +214,7 @@ static int
 gve_dev_configure(struct rte_eth_dev *dev)
 {
 	struct gve_priv *priv = dev->data->dev_private;
+	int err;
 
 	if (dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_RSS_FLAG) {
 		dev->data->dev_conf.rxmode.offloads |= RTE_ETH_RX_OFFLOAD_RSS_HASH;
@@ -223,13 +224,22 @@ gve_dev_configure(struct rte_eth_dev *dev)
 	if (dev->data->dev_conf.rxmode.offloads & RTE_ETH_RX_OFFLOAD_TCP_LRO)
 		priv->enable_rsc = 1;
 
+	if (dev->data->dev_conf.rxmode.offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP) {
+		err = rte_mbuf_dyn_rx_timestamp_register(&priv->mbuf_timestamp_offset,
+							 &priv->mbuf_timestamp_mask);
+		if (err < 0) {
+			PMD_DRV_LOG(ERR, "Failed to register dynamic timestamp field");
+			return err;
+		}
+	}
+
 	/* Reset RSS RETA in case number of queues changed. */
 	if (priv->rss_config.indir) {
 		struct gve_rss_config update_reta_config;
 		gve_init_rss_config_from_priv(priv, &update_reta_config);
 		gve_generate_rss_reta(dev, &update_reta_config);
 
-		int err = gve_adminq_configure_rss(priv, &update_reta_config);
+		err = gve_adminq_configure_rss(priv, &update_reta_config);
 		if (err)
 			PMD_DRV_LOG(ERR,
 				"Could not reconfigure RSS redirection table.");
@@ -817,6 +827,8 @@ gve_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->min_mtu = RTE_ETHER_MIN_MTU;
 
 	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_RSS_HASH;
+	if (!gve_is_gqi(priv) && priv->nic_ts_report_mz)
+		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_TIMESTAMP;
 	dev_info->tx_offload_capa =
 		RTE_ETH_TX_OFFLOAD_MULTI_SEGS	|
 		RTE_ETH_TX_OFFLOAD_UDP_CKSUM	|
@@ -1652,6 +1664,7 @@ gve_dev_init(struct rte_eth_dev *eth_dev)
 	priv->max_nb_txq = max_tx_queues;
 	priv->max_nb_rxq = max_rx_queues;
 
+	priv->mbuf_timestamp_offset = -1;
 	err = gve_init_priv(priv, false);
 	if (err)
 		return err;
diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index 7e6f24e910..35d532284e 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -260,6 +260,7 @@ struct gve_rx_queue {
 	struct rte_mbuf **refill_bufs;
 
 	uint8_t is_gqi_qpl;
+	bool timestamp_enabled;
 };
 
 struct gve_flow {
@@ -368,8 +369,32 @@ struct gve_priv {
 	RTE_ATOMIC(uint64_t) last_read_nic_timestamp;
 	RTE_ATOMIC(uint32_t) nic_ts_read_fails;
 	RTE_ATOMIC(uint8_t) nic_ts_stale;
+
+	int mbuf_timestamp_offset;
+	uint64_t mbuf_timestamp_mask;
 };
 
+/* Expand the hardware timestamp to the full 64 bits of width.
+ *
+ * This algorithm works by using the passed hardware timestamp to generate a
+ * diff relative to the last read of the nic clock. This diff can be positive or
+ * negative, as it is possible that we have read the clock more recently than
+ * the hardware has received this packet. To detect this, we use the high bit of
+ * the diff, and assume that the read is more recent if the high bit is set. In
+ * this case we invert the process.
+ *
+ * Note that this means if the time delta between packet reception and the last
+ * clock read is greater than ~2 seconds, this will provide invalid results.
+ */
+static inline uint64_t
+gve_reconstruct_ts(uint64_t last_sync, uint32_t ts)
+{
+	uint32_t low = (uint32_t)last_sync;
+	int32_t diff = (int32_t)(ts - low);
+
+	return last_sync + diff;
+}
+
 static inline bool
 gve_is_gqi(struct gve_priv *priv)
 {
diff --git a/drivers/net/gve/gve_rx_dqo.c b/drivers/net/gve/gve_rx_dqo.c
index 8035aee572..cc343f3fd8 100644
--- a/drivers/net/gve/gve_rx_dqo.c
+++ b/drivers/net/gve/gve_rx_dqo.c
@@ -160,6 +160,8 @@ gve_rx_burst_dqo(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 {
 	volatile struct gve_rx_compl_desc_dqo *rx_desc;
 	struct gve_rx_queue *rxq;
+	uint64_t last_sync = 0;
+	struct gve_priv *priv;
 	struct rte_mbuf *rxm;
 	uint16_t rx_buf_id;
 	uint16_t pkt_len;
@@ -171,6 +173,15 @@ gve_rx_burst_dqo(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 	nb_rx = 0;
 	rxq = rx_queue;
 	rx_id = rxq->rx_tail;
+	priv = rxq->hw;
+
+	if (rxq->timestamp_enabled &&
+	    !rte_atomic_load_explicit(&priv->nic_ts_stale,
+				      rte_memory_order_acquire)) {
+		last_sync =
+			rte_atomic_load_explicit(&priv->last_read_nic_timestamp,
+						 rte_memory_order_relaxed);
+	}
 
 	while (nb_rx < nb_pkts) {
 		rx_desc = &rxq->compl_ring[rx_id];
@@ -208,6 +219,16 @@ gve_rx_burst_dqo(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 		gve_parse_csum_ol_flags(rxm, rx_desc);
 		rxm->hash.rss = rte_le_to_cpu_32(rx_desc->hash);
 
+		if (last_sync != 0 &&
+		    (rx_desc->ts_sub_nsecs_low & GVE_DQO_RX_HWTSTAMP_VALID) &&
+		    priv->mbuf_timestamp_offset >= 0) {
+			uint32_t ts = rte_le_to_cpu_32(rx_desc->ts);
+			uint64_t full_ts = gve_reconstruct_ts(last_sync, ts);
+
+			*RTE_MBUF_DYNFIELD(rxm, priv->mbuf_timestamp_offset, uint64_t *) = full_ts;
+			rxm->ol_flags |= priv->mbuf_timestamp_mask;
+		}
+
 		rx_pkts[nb_rx++] = rxm;
 		bytes += pkt_len;
 	}
@@ -320,6 +341,11 @@ gve_rx_queue_setup_dqo(struct rte_eth_dev *dev, uint16_t queue_id,
 		return -ENOMEM;
 	}
 
+	/* Setup hardware timestamping if enabled */
+	if ((conf->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP) ||
+	    (dev->data->dev_conf.rxmode.offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP))
+		rxq->timestamp_enabled = true;
+
 	/* check free_thresh here */
 	free_thresh = conf->rx_free_thresh ?
 			conf->rx_free_thresh : GVE_DEFAULT_RX_FREE_THRESH;
-- 
2.54.0.563.g4f69b47b94-goog

