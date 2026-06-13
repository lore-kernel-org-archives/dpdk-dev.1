Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82F3CD98C5
	for <dpdk-dev@archiver.kernel.org>; Sat, 13 Jun 2026 04:23:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F6E0435DE;
	Sat, 13 Jun 2026 06:23:35 +0200 (CEST)
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com
 [209.85.160.201])
 by mails.dpdk.org (Postfix) with ESMTP id CD9BA435D0
 for <dev@dpdk.org>; Sat, 13 Jun 2026 06:23:29 +0200 (CEST)
Received: by mail-qt1-f201.google.com with SMTP id
 d75a77b69052e-517c65e497eso30150811cf.2
 for <dev@dpdk.org>; Fri, 12 Jun 2026 21:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781324609; x=1781929409; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=80EPOUgWMaVWMZpl5XBAeiDb0RpL4PHcCLHxmenBA0M=;
 b=dKJCMlBUwq9M5OJS0AdigvOOE5X/VCfxX/D0FBhVrKTeaHAXypxRzNXOqRa0bNqHTw
 G4X9T8OGimTo3XoAbBA9Y2BlXkGEXCcb1QagJSMUR3fBb+ukwevIPmkdiE0XJzGtJORN
 P3x64BgQELh3mxv7w+c34qmeNTMc2khrbYcVrzeW8WKrS4ZGFk3qI/pQIuqRD/liMrG1
 /bWsqLKwjmjhna9JLbApA4fhsO70NxAXGZjbSR+j0j7Tm7OIS1Kka4lC3kBg2ckwnupq
 PlMZuZ9qfs8CMpygpc92IRvhobhRreWUFoDTp8v+hvG7zwZx87rlPE2ml4BhQ2NULf1O
 nfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781324609; x=1781929409;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=80EPOUgWMaVWMZpl5XBAeiDb0RpL4PHcCLHxmenBA0M=;
 b=qaTI937y34enLc4OfEvTrf3LWLMzmJZGyxRS+J9HpULwtn4NVm1yK/+GLXLqPs0ECg
 bu4/atX411YtRFfKpjabIxQ9ZKdkxwn2RIkakBcP9K0x52+YEaelIvnYJEBDDgqhZT2m
 JuHCG/L8xfB44GPgpFQ9rtg8yB7UzV3lIZ+K/skuISGSg9dnsn4zbV/OZRAB7EawMGle
 tedz527FCfdU8piSPLe2CG0WksZ43sPoRkizTgJ0lRRa3N7bqIf0cQneH5XMroZfS+7p
 MZjvs73mfQm/DWKSU8wp/K9Uy6C+s6oRH4GHmK598gyBsbCsPhZ/nXh2cxDFGGp/PQ3L
 a41Q==
X-Gm-Message-State: AOJu0Yw2M3EmExVWTXGgVNMfaO+DuWwFFD9hVdvhLAKcY9zFuXhKDJ6Z
 SyD0ZYdtj2OxUAZV/GxrKpjjaXIgRMXELMrtaMM6C+iYFyL4CipjqCepldSvY7o9EQvdmxbKaTW
 Rg4WkfA==
X-Received: from qtvv4-n2.prod.google.com
 ([2002:a05:622a:aa84:20b0:517:6f21:f7be])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:a18c:b0:517:6899:e664
 with SMTP id d75a77b69052e-517fe56165fmr37817771cf.51.1781324608812; Fri, 12
 Jun 2026 21:23:28 -0700 (PDT)
Date: Sat, 13 Jun 2026 04:22:39 +0000
In-Reply-To: <20260613042300.3760470-1-blasko@google.com>
Mime-Version: 1.0
References: <20260605213022.2770893-1-blasko@google.com>
 <20260613042300.3760470-1-blasko@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613042300.3760470-7-blasko@google.com>
Subject: [PATCH v4 6/6] net/gve: reconstruct HW timestamps from DQO
From: Mark Blasko <blasko@google.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, joshwash@google.com, jtranoleary@google.com, 
 blasko@google.com
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
v4:
    - Clarify in GVE documentation that both read_clock ethdev op and
      per-packet RX timestamp offloading require the DQO queue format.

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
index be855b645d..b73375c5c9 100644
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
+Both the ethdev ``.read_clock`` operation and per-packet RX timestamp offloading
+require the DQO queue format.
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
index 2e449d3ee8..73c9a36007 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -91,6 +91,10 @@ New Features
 
   Added network driver for the LinkData network adapters.
 
+* **Updated Google GVE net driver.**
+
+  * Added hardware timestamping support on DQO queues.
+
 * **Updated Intel iavf driver.**
 
   * Added support for transmitting LLDP packets based on mbuf packet type.
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
index 111f66efa8..0b02dcb3ad 100644
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
@@ -828,6 +838,8 @@ gve_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->min_mtu = RTE_ETHER_MIN_MTU;
 
 	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_RSS_HASH;
+	if (!gve_is_gqi(priv) && priv->nic_ts_report_mz)
+		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_TIMESTAMP;
 	dev_info->tx_offload_capa =
 		RTE_ETH_TX_OFFLOAD_MULTI_SEGS	|
 		RTE_ETH_TX_OFFLOAD_UDP_CKSUM	|
@@ -1683,6 +1695,7 @@ gve_dev_init(struct rte_eth_dev *eth_dev)
 	pthread_mutex_init(&priv->nic_ts_lock, &mutexattr);
 	pthread_mutexattr_destroy(&mutexattr);
 
+	priv->mbuf_timestamp_offset = -1;
 	err = gve_init_priv(priv, false);
 	if (err) {
 		pthread_mutex_destroy(&priv->flow_rule_lock);
diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index 1e80f3a906..4a7e5ecdf3 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -261,6 +261,7 @@ struct gve_rx_queue {
 	struct rte_mbuf **refill_bufs;
 
 	uint8_t is_gqi_qpl;
+	bool timestamp_enabled;
 };
 
 struct gve_flow {
@@ -372,8 +373,32 @@ struct gve_priv {
 	RTE_ATOMIC(uint8_t) nic_ts_stale;
 	rte_thread_t nic_ts_thread_id;
 	RTE_ATOMIC(uint8_t) nic_ts_thread_should_stop;
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
2.54.0.1136.gdb2ca164c4-goog

