Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEF3C5DF67
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 06:50:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B031C40616;
	Tue, 18 Aug 2026 08:50:09 +0200 (CEST)
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by mails.dpdk.org (Postfix) with ESMTP id BD2FB40294
 for <dev@dpdk.org>; Tue, 18 Aug 2026 08:50:07 +0200 (CEST)
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-66cbb3dcea7so1756165d50.3
 for <dev@dpdk.org>; Mon, 17 Aug 2026 23:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1787035807; x=1787640607; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=g+8g8LOcf0Wn8Jcl0r2UNWJfKZXDss6OxyNKiSOJn78=;
 b=KKGKhrnOHLlWZ2eCHL48Rum6rUvyskDvNhTLvJ6IkhuPyoGuQ3Bdx1S3arodAZM2Fr
 leJCNNNfk9BPCd3hLNZMb14DUUPaAaUK7csUU/G2BB6/vyLwpBCGKSxDY7PiXwgd8pEv
 T5HULVEWRMEO4gNEe2EkRM37EU3PVb0b4y2MRw+mgqJE+M7uE9Dg+O77+h9F697vaHJI
 i3OhQWAz5iUxWOpiUmaoP8/m7peJKJsvaDmUzISP4ZQFLRdDQP7YP6CXdR1aDs62P3gq
 8arhRhiyqhILglwLpFTHGD+xgcuiVkCWke/VlaTpU4LOQLiDH68C2lKhvqT28BhMGg8+
 +CEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787035807; x=1787640607;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g+8g8LOcf0Wn8Jcl0r2UNWJfKZXDss6OxyNKiSOJn78=;
 b=T+5tlMrVJFKZhhR85Cjq0ghFinfbI69CzGlbdFRZ2mlsK1QsfPvT0yu0v/Mg/vVcHL
 kbcIreWM94LzM3cc7bPMfhUl4Jhd0gb7YZMK1N1pSQjO/35jZ7Wh7kByoZ+VnnLSiHVO
 LDBAOsZ1qpBthpEollapoyje6ynxqAxMiy0KD+sHItwW09QRlge4O1WOvt/6ewz62sro
 t1eRRIpcF60eBvbDpi35pdyqI3AXWcW5j2dz8BGOfpDRHoYzZ6AeN3i+EleG4dhRNtB7
 BZpy2WBpJMjxrzc15ktF2WvZ+qwi9PKf+KdtHmSIUf8n8gykXiQEjBruVhzt//ag56u7
 OEEg==
X-Gm-Message-State: AOJu0YwcZNSWszmQL9WEyTJkcYX6PZ1j8XsinXmHFaw4sjtyUpzeZ0vG
 6e399LRJgc+NgnWRhbhg0+Upbjpp9skjeaK9DPbGsO2APUZTVVZ/LJ3bzRzLNLIBB6ivC7LKGWk
 I4DNpGMoc+RkaSd6uw9hPKNAfM4sxrhzIMExAzPrLdW/redQLPBIHNhgNkGuQuaG/nAaWUbZ3ib
 6iAan37pVe9p21vwc8wwP9L+Y=
X-Received: from yxct4.prod.google.com ([2002:a05:690e:2604:b0:66c:b83c:e0b6])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:dce:b0:668:26e7:8e20
 with SMTP id 956f58d0204a3-66c72c7a878mr10585918d50.27.1787035806483; Mon, 17
 Aug 2026 23:50:06 -0700 (PDT)
Date: Tue, 18 Aug 2026 06:49:58 +0000
In-Reply-To: <20260818065000.1597610-1-blasko@google.com>
Mime-Version: 1.0
References: <20260623215325.814776-1-blasko@google.com>
 <20260818065000.1597610-1-blasko@google.com>
X-Mailer: git-send-email 2.55.0.699.gb54405d56f-goog
Message-ID: <20260818065000.1597610-2-blasko@google.com>
Subject: [PATCH v7 1/2] net/af_xdp: add af_xdp rx metadata and dynamic
 timestamping support
From: Mark Blasko <blasko@google.com>
To: dev@dpdk.org, Ciara Loftus <ciara.loftus@intel.com>, 
 Maryam Tahhan <mtahhan@redhat.com>
Cc: joshwash@google.com, jtranoleary@google.com, blasko@google.com
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

Enable dynamic RX timestamping in the AF_XDP Poll Mode Driver using
layout-agnostic metadata offsets and validity verification.

This introduces three new vdev devargs to describe the metadata layout:
1. xdp_meta_rx_ts_offset: byte offset of the RX timestamp in metadata.
2. xdp_meta_valid_hint_offset: byte offset of the validity flag byte.
3. xdp_meta_rx_ts_valid_mask: bitmask to verify timestamp validity.

If validation parameters are configured, the PMD verifies the validity
bit at the target offset on a per-packet basis before copying the
timestamp to the standard EAL dynamic field. Otherwise, the timestamp
is assumed valid if metadata space is available.

Signed-off-by: Mark Blasko <blasko@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
---
v7:
- In eth_af_xdp_enable_hw_timestamping(), return -errno immediately if
  SIOCGHWTSTAMP fails so SIOCSHWTSTAMP is only issued with a config that
  was successfully read back from the kernel.
v6:
- Support per-queue Rx timestamp offload via rx_conf->offloads in
  eth_rx_queue_setup() and check all configured queues at eth_dev_start().
- In eth_af_xdp_enable_hw_timestamping(), only accept HWTSTAMP_FILTER_ALL
  and HWTSTAMP_FILTER_SOME as pre-existing filters; preserve config.flags
  and save errno before closing socket.
- Fix feature matrix ordering in af_xdp.ini to match default.ini.
- Validate conversion in parse_hex_arg() and parse_integer_arg().
- Reject overlapping validity hint offset and 8-byte timestamp at probe.
- Unify timestamp extraction in ZC and CP paths using static inline helper.
- Fix "RX" to "Rx" casing per devtools/words-case.txt in docs.
- Document accepted devargs bounds in af_xdp.rst.
- Move CAP_NET_ADMIN requirement and persistent HW filter side effect note
  into a dedicated .. note:: block in af_xdp.rst.
v5:
- Fix rx_timestamp_enabled check in eth_rx_queue_setup().
- Update af_xdp.rst documentation and code example.
- Update release notes for 26.11.
v4:
- Validate rx_timestamp_offset (8 <= offset <= 256) and valid_hint_offset
  (1 <= offset <= 256) bounds.
- Revert parse_integer_arg() to base 10 and add dedicated parse_hex_arg()
  for validity mask.
- Optimize fast-path check and use rte_pktmbuf_mtod_offset() macro.
- Preserve config.tx_type in SIOCSHWTSTAMP instead of forcing
  HWTSTAMP_TX_OFF.
- Return -errno on socket failure and replace (caddr_t) cast with
  (void *).
- Advertise RTE_ETH_RX_OFFLOAD_TIMESTAMP conditionally when
  rx_timestamp_offset >= 0.
- Update af_xdp.ini features matrix with Timestamp offload = Y.
- Document CAP_NET_ADMIN requirement and persistent HW filter side
  effect in af_xdp.rst.
v3:
- Add PMD documentation and release notes entry.
- Move dynamic mbuf timestamp field registration to eth_dev_start().
- Replace 64-bit pointer casting with memcpy.
- Add devargs validation and support auto-base integer parsing.
v2:
- Replace static metadata struct assumption with configurable vdev devargs
  for layout-agnostic timestamp offset extraction and validity verification.
 doc/guides/nics/af_xdp.rst             |  40 ++++
 doc/guides/nics/features/af_xdp.ini    |   1 +
 doc/guides/rel_notes/release_26_11.rst |   6 +
 drivers/net/af_xdp/rte_eth_af_xdp.c    | 245 ++++++++++++++++++++++++-
 4 files changed, 283 insertions(+), 9 deletions(-)

diff --git a/doc/guides/nics/af_xdp.rst b/doc/guides/nics/af_xdp.rst
index c455b4c066..94e47a2ab9 100644
--- a/doc/guides/nics/af_xdp.rst
+++ b/doc/guides/nics/af_xdp.rst
@@ -212,6 +212,46 @@ the AF_XDP PMD configures it internally to the `AF_XDP Device Plugin for Kuberne
 
    --vdev=net_af_xdp0,use_pinned_map=1,dp_path="/tmp/afxdp_dp/<<interface name>>/xsks_map"
 
+xdp_meta_rx_ts_offset
+~~~~~~~~~~~~~~~~~~~~~
+
+The ``xdp_meta_rx_ts_offset`` argument specifies the byte offset of the 64-bit Rx
+timestamp within the XDP metadata headroom area. All metadata offsets are measured
+backwards from the start of packet data (``rte_pktmbuf_mtod()``). The accepted range
+is 8 to 256 bytes.
+
+.. code-block:: console
+
+    --vdev net_af_xdp,iface=ens786f1,xdp_meta_rx_ts_offset=8
+
+xdp_meta_valid_hint_offset
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The ``xdp_meta_valid_hint_offset`` argument specifies the byte offset of the validity
+flag byte within the XDP metadata headroom area, measured backwards from the start of
+packet data. The accepted range is 1 to 256 bytes.
+
+.. code-block:: console
+
+    --vdev net_af_xdp,iface=ens786f1,xdp_meta_rx_ts_offset=8,xdp_meta_valid_hint_offset=12
+
+xdp_meta_rx_ts_valid_mask
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The ``xdp_meta_rx_ts_valid_mask`` argument specifies the bitmask (in hex) used
+to verify timestamp validity at ``xdp_meta_valid_hint_offset``.
+
+.. code-block:: console
+
+    --vdev net_af_xdp,iface=ens786f1,xdp_meta_rx_ts_offset=8,xdp_meta_valid_hint_offset=12,xdp_meta_rx_ts_valid_mask=0x1
+
+.. note::
+
+    Enabling dynamic Rx timestamping configures ``HWTSTAMP_FILTER_ALL`` on the kernel
+    netdev interface via ``SIOCSHWTSTAMP`` (which requires ``CAP_NET_ADMIN``). This
+    hardware filter setting persists on the netdev interface after the DPDK application
+    exits.
+
 Limitations
 -----------
 
diff --git a/doc/guides/nics/features/af_xdp.ini b/doc/guides/nics/features/af_xdp.ini
index d2461dacfa..57614fae94 100644
--- a/doc/guides/nics/features/af_xdp.ini
+++ b/doc/guides/nics/features/af_xdp.ini
@@ -8,6 +8,7 @@ Link status          = Y
 Power mgmt address monitor = Y
 MTU update           = Y
 Promiscuous mode     = Y
+Timestamp offload    = Y
 Basic stats          = Y
 Stats per queue      = Y
 Multiprocess aware   = Y
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c8cc86295d..1de3db22e9 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -55,6 +55,12 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Updated AF_XDP PMD.**
+
+  * Added support for Rx metadata hardware timestamping via vdev devargs
+    ``xdp_meta_rx_ts_offset``, ``xdp_meta_valid_hint_offset``, and
+    ``xdp_meta_rx_ts_valid_mask``.
+
 
 Removed Items
 -------------
diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c b/drivers/net/af_xdp/rte_eth_af_xdp.c
index 2cdb533276..e51f40fc1a 100644
--- a/drivers/net/af_xdp/rte_eth_af_xdp.c
+++ b/drivers/net/af_xdp/rte_eth_af_xdp.c
@@ -15,6 +15,7 @@
 #include <linux/if_link.h>
 #include <linux/ethtool.h>
 #include <linux/sockios.h>
+#include <linux/net_tstamp.h>
 #include "af_xdp_deps.h"
 
 #include <rte_ethdev.h>
@@ -62,6 +63,9 @@
 #define PF_XDP AF_XDP
 #endif
 
+static int timestamp_dynfield_offset = -1;
+static uint64_t timestamp_dynflag;
+
 RTE_LOG_REGISTER_DEFAULT(af_xdp_logtype, NOTICE);
 #define RTE_LOGTYPE_NET_AF_XDP af_xdp_logtype
 
@@ -144,6 +148,10 @@ struct pkt_rx_queue {
 	struct pollfd fds[1];
 	int xsk_queue_idx;
 	int busy_budget;
+	bool rx_timestamp_enabled;
+	int rx_timestamp_offset;
+	int rx_timestamp_valid_offset;
+	uint8_t rx_timestamp_valid_mask;
 };
 
 struct tx_stats {
@@ -183,6 +191,9 @@ struct pmd_internals {
 
 	struct pkt_rx_queue *rx_queues;
 	struct pkt_tx_queue *tx_queues;
+	int rx_timestamp_offset;
+	int rx_timestamp_valid_offset;
+	uint8_t rx_timestamp_valid_mask;
 };
 
 struct pmd_process_private {
@@ -200,6 +211,9 @@ struct pmd_process_private {
 #define ETH_AF_XDP_USE_PINNED_MAP_ARG	"use_pinned_map"
 #define ETH_AF_XDP_DP_PATH_ARG			"dp_path"
 #define ETH_AF_XDP_MODE_ARG				"mode"
+#define ETH_AF_XDP_RX_TIMESTAMP_OFFSET_ARG	"xdp_meta_rx_ts_offset"
+#define ETH_AF_XDP_RX_TIMESTAMP_VALID_OFFSET_ARG	"xdp_meta_valid_hint_offset"
+#define ETH_AF_XDP_RX_TIMESTAMP_VALID_MASK_ARG	"xdp_meta_rx_ts_valid_mask"
 
 /* Define different modes for af_xdp prog to attach */
 #define ETH_AF_XDP_DRV_MODE_ARG			"drv"
@@ -232,6 +246,9 @@ static const char * const valid_arguments[] = {
 	ETH_AF_XDP_USE_PINNED_MAP_ARG,
 	ETH_AF_XDP_DP_PATH_ARG,
 	ETH_AF_XDP_MODE_ARG,
+	ETH_AF_XDP_RX_TIMESTAMP_OFFSET_ARG,
+	ETH_AF_XDP_RX_TIMESTAMP_VALID_OFFSET_ARG,
+	ETH_AF_XDP_RX_TIMESTAMP_VALID_MASK_ARG,
 	NULL
 };
 
@@ -330,6 +347,23 @@ reserve_fill_queue(struct xsk_umem_info *umem, uint16_t reserve_size,
 #endif
 }
 
+static inline void
+af_xdp_extract_timestamp(struct pkt_rx_queue *rxq, struct rte_mbuf *mbuf, const void *base)
+{
+	/*
+	 * Extract timestamp to mbuf dynamic field if validity offset is
+	 * not defined or flag is valid.
+	 */
+	if (rxq->rx_timestamp_valid_offset < 0 ||
+	    (*((const uint8_t *)base - rxq->rx_timestamp_valid_offset) &
+	     rxq->rx_timestamp_valid_mask)) {
+		uint64_t ts;
+		memcpy(&ts, (const char *)base - rxq->rx_timestamp_offset, sizeof(ts));
+		*RTE_MBUF_DYNFIELD(mbuf, timestamp_dynfield_offset, uint64_t *) = ts;
+		mbuf->ol_flags |= timestamp_dynflag;
+	}
+}
+
 #if defined(XDP_UMEM_UNALIGNED_CHUNK_FLAG)
 static uint16_t
 af_xdp_rx_zc(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
@@ -398,6 +432,11 @@ af_xdp_rx_zc(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 		rte_pktmbuf_pkt_len(bufs[i]) = len;
 		rte_pktmbuf_data_len(bufs[i]) = len;
+
+		if (rxq->rx_timestamp_enabled)
+			af_xdp_extract_timestamp(rxq, bufs[i],
+						 rte_pktmbuf_mtod(bufs[i], void *));
+
 		rx_bytes += len;
 	}
 
@@ -457,6 +496,9 @@ af_xdp_rx_cp(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		len = desc->len;
 		pkt = xsk_umem__get_data(rxq->umem->mz->addr, addr);
 
+		if (rxq->rx_timestamp_enabled)
+			af_xdp_extract_timestamp(rxq, mbufs[i], pkt);
+
 		rte_memcpy(rte_pktmbuf_mtod(mbufs[i], void *), pkt, len);
 		rte_ring_enqueue(umem->buf_ring, (void *)addr);
 		rte_pktmbuf_pkt_len(mbufs[i]) = len;
@@ -738,11 +780,92 @@ eth_af_xdp_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 #endif
 }
 
+static int
+eth_af_xdp_enable_hw_timestamping(const char *if_name)
+{
+	struct hwtstamp_config config = {0};
+	struct ifreq ifr = {0};
+	int fd, ret, err = 0;
+
+	fd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (fd < 0)
+		return -errno;
+
+	ifr.ifr_data = (void *)&config;
+	strlcpy(ifr.ifr_name, if_name, IFNAMSIZ);
+
+	ret = ioctl(fd, SIOCGHWTSTAMP, &ifr);
+	if (ret < 0) {
+		err = -errno;
+		close(fd);
+		return err;
+	}
+
+	if (config.rx_filter == HWTSTAMP_FILTER_ALL ||
+	    config.rx_filter == HWTSTAMP_FILTER_SOME) {
+		close(fd);
+		return 0;
+	}
+
+	config.rx_filter = HWTSTAMP_FILTER_ALL;
+	ret = ioctl(fd, SIOCSHWTSTAMP, &ifr);
+	if (ret < 0)
+		err = -errno;
+	close(fd);
+
+	if (ret < 0)
+		return err;
+
+	if (config.rx_filter == HWTSTAMP_FILTER_NONE)
+		return -ENOTSUP;
+
+	return 0;
+}
+
 static int
 eth_dev_start(struct rte_eth_dev *dev)
 {
+	struct pmd_internals *internals = dev->data->dev_private;
+	bool rx_timestamp_enabled = false;
 	uint16_t i;
 
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		struct pkt_rx_queue *rxq = dev->data->rx_queues[i];
+		if (rxq && rxq->rx_timestamp_enabled) {
+			rx_timestamp_enabled = true;
+			break;
+		}
+	}
+
+	if (rx_timestamp_enabled) {
+		int rc;
+
+		if (internals->rx_timestamp_offset < 0) {
+			AF_XDP_LOG_LINE(ERR,
+				"Timestamp offload requested but xdp_meta_rx_ts_offset parameter not configured");
+			return -EINVAL;
+		}
+
+		rc = rte_mbuf_dyn_rx_timestamp_register(&timestamp_dynfield_offset,
+							&timestamp_dynflag);
+		if (rc) {
+			AF_XDP_LOG_LINE(ERR,
+				"Failed to register mbuf timestamp field");
+			return rc;
+		}
+		AF_XDP_LOG_LINE(INFO,
+			"Registered mbuf timestamp field, offset: %d",
+			timestamp_dynfield_offset);
+
+		rc = eth_af_xdp_enable_hw_timestamping(internals->if_name);
+		if (rc < 0) {
+			AF_XDP_LOG_LINE(ERR,
+				"Could not enable HW timestamping on %s: %s",
+				internals->if_name, strerror(-rc));
+			return rc;
+		}
+	}
+
 	dev->data->dev_link.link_status = RTE_ETH_LINK_UP;
 	for (i = 0; i < dev->data->nb_rx_queues; i++) {
 		dev->data->rx_queue_state[i] = RTE_ETH_QUEUE_STATE_STARTED;
@@ -870,6 +993,11 @@ eth_dev_info(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->max_rx_queues = internals->queue_cnt;
 	dev_info->max_tx_queues = internals->queue_cnt;
 
+	if (internals->rx_timestamp_offset >= 0) {
+		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_TIMESTAMP;
+		dev_info->rx_queue_offload_capa |= RTE_ETH_RX_OFFLOAD_TIMESTAMP;
+	}
+
 	dev_info->min_mtu = RTE_ETHER_MIN_MTU;
 #if defined(XDP_UMEM_UNALIGNED_CHUNK_FLAG)
 	dev_info->max_rx_pktlen = getpagesize() -
@@ -1827,7 +1955,7 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 		   uint16_t rx_queue_id,
 		   uint16_t nb_rx_desc,
 		   unsigned int socket_id __rte_unused,
-		   const struct rte_eth_rxconf *rx_conf __rte_unused,
+		   const struct rte_eth_rxconf *rx_conf,
 		   struct rte_mempool *mb_pool)
 {
 	struct pmd_internals *internals = dev->data->dev_private;
@@ -1873,7 +2001,13 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 	process_private->rxq_xsk_fds[rx_queue_id] = rxq->fds[0].fd;
 
 	rxq->port = dev->data->port_id;
-
+	rxq->rx_timestamp_offset = internals->rx_timestamp_offset;
+	rxq->rx_timestamp_valid_offset = internals->rx_timestamp_valid_offset;
+	rxq->rx_timestamp_valid_mask = internals->rx_timestamp_valid_mask;
+	rxq->rx_timestamp_enabled = (rxq->rx_timestamp_offset >= 0) &&
+					!!((dev->data->dev_conf.rxmode.offloads |
+					    rx_conf->offloads) &
+					   RTE_ETH_RX_OFFLOAD_TIMESTAMP);
 	dev->data->rx_queues[rx_queue_id] = rxq;
 	return 0;
 
@@ -2022,13 +2156,42 @@ parse_integer_arg(const char *key __rte_unused,
 {
 	int *i = (int *)extra_args;
 	char *end;
+	long val;
 
-	*i = strtol(value, &end, 10);
-	if (*i < 0) {
-		AF_XDP_LOG_LINE(ERR, "Argument has to be positive.");
+	if (value == NULL || extra_args == NULL)
+		return -EINVAL;
+
+	errno = 0;
+	val = strtol(value, &end, 10);
+	if (errno != 0 || end == value || *end != '\0' || val < 0 || val > INT_MAX) {
+		AF_XDP_LOG_LINE(ERR, "Argument has to be a valid non-negative integer.");
 		return -EINVAL;
 	}
 
+	*i = (int)val;
+	return 0;
+}
+
+/** parse hex from argument */
+static int
+parse_hex_arg(const char *key __rte_unused,
+	      const char *value, void *extra_args)
+{
+	int *i = (int *)extra_args;
+	char *end;
+	unsigned long val;
+
+	if (value == NULL || extra_args == NULL)
+		return -EINVAL;
+
+	errno = 0;
+	val = strtoul(value, &end, 16);
+	if (errno != 0 || end == value || *end != '\0' || val > UINT8_MAX) {
+		AF_XDP_LOG_LINE(ERR, "Validity mask must be a valid hex byte (0-0xFF).");
+		return -EINVAL;
+	}
+
+	*i = (int)val;
 	return 0;
 }
 
@@ -2146,7 +2309,9 @@ static int
 parse_parameters(struct rte_kvargs *kvlist, char *if_name, int *start_queue,
 		 int *queue_cnt, int *shared_umem, char *prog_path,
 		 int *busy_budget, int *force_copy, int *use_cni,
-		 int *use_pinned_map, char *dp_path, uint32_t *xdp_mode)
+		 int *use_pinned_map, char *dp_path, uint32_t *xdp_mode,
+		 int *rx_timestamp_offset, int *rx_timestamp_valid_offset,
+		 int *rx_timestamp_valid_mask)
 {
 	int ret;
 
@@ -2209,6 +2374,21 @@ parse_parameters(struct rte_kvargs *kvlist, char *if_name, int *start_queue,
 	if (ret < 0)
 		goto free_kvlist;
 
+	ret = rte_kvargs_process(kvlist, ETH_AF_XDP_RX_TIMESTAMP_OFFSET_ARG,
+				 &parse_integer_arg, rx_timestamp_offset);
+	if (ret < 0)
+		goto free_kvlist;
+
+	ret = rte_kvargs_process(kvlist, ETH_AF_XDP_RX_TIMESTAMP_VALID_OFFSET_ARG,
+				 &parse_integer_arg, rx_timestamp_valid_offset);
+	if (ret < 0)
+		goto free_kvlist;
+
+	ret = rte_kvargs_process(kvlist, ETH_AF_XDP_RX_TIMESTAMP_VALID_MASK_ARG,
+				 &parse_hex_arg, rx_timestamp_valid_mask);
+	if (ret < 0)
+		goto free_kvlist;
+
 free_kvlist:
 	rte_kvargs_free(kvlist);
 	return ret;
@@ -2248,7 +2428,9 @@ static struct rte_eth_dev *
 init_internals(struct rte_vdev_device *dev, const char *if_name,
 	       int start_queue_idx, int queue_cnt, int shared_umem,
 	       const char *prog_path, int busy_budget, int force_copy,
-	       int use_cni, int use_pinned_map, const char *dp_path, uint32_t xdp_mode)
+	       int use_cni, int use_pinned_map, const char *dp_path, uint32_t xdp_mode,
+	       int rx_timestamp_offset, int rx_timestamp_valid_offset,
+	       int rx_timestamp_valid_mask)
 {
 	const char *name = rte_vdev_device_name(dev);
 	const unsigned int numa_node = dev->device.numa_node;
@@ -2281,6 +2463,9 @@ init_internals(struct rte_vdev_device *dev, const char *if_name,
 	internals->use_pinned_map = use_pinned_map;
 	internals->mode_flag = XDP_FLAGS_UPDATE_IF_NOEXIST | xdp_mode;
 	strlcpy(internals->dp_path, dp_path, PATH_MAX);
+	internals->rx_timestamp_offset = rx_timestamp_offset;
+	internals->rx_timestamp_valid_offset = rx_timestamp_valid_offset;
+	internals->rx_timestamp_valid_mask = (uint8_t)rx_timestamp_valid_mask;
 
 	if (xdp_get_channels_info(if_name, &internals->max_queue_cnt,
 				  &internals->configured_queue_cnt)) {
@@ -2474,6 +2659,9 @@ rte_pmd_af_xdp_probe(struct rte_vdev_device *dev)
 	int use_pinned_map = 0;
 	uint32_t xdp_mode = 0;
 	char dp_path[PATH_MAX] = {'\0'};
+	int rx_timestamp_offset = -1;
+	int rx_timestamp_valid_offset = -1;
+	int rx_timestamp_valid_mask = 0;
 	struct rte_eth_dev *eth_dev = NULL;
 	const char *name = rte_vdev_device_name(dev);
 
@@ -2517,11 +2705,49 @@ rte_pmd_af_xdp_probe(struct rte_vdev_device *dev)
 	if (parse_parameters(kvlist, if_name, &xsk_start_queue_idx,
 			     &xsk_queue_cnt, &shared_umem, prog_path,
 			     &busy_budget, &force_copy, &use_cni, &use_pinned_map,
-			     dp_path, &xdp_mode) < 0) {
+			     dp_path, &xdp_mode, &rx_timestamp_offset,
+			     &rx_timestamp_valid_offset, &rx_timestamp_valid_mask) < 0) {
 		AF_XDP_LOG_LINE(ERR, "Invalid kvargs value");
 		return -EINVAL;
 	}
 
+	if (rx_timestamp_offset >= 0) {
+		if (rx_timestamp_offset < (int)sizeof(uint64_t) ||
+		    rx_timestamp_offset > XDP_PACKET_HEADROOM) {
+			AF_XDP_LOG_LINE(ERR,
+				"Timestamp offset must be between %zu and %u bytes",
+				sizeof(uint64_t), XDP_PACKET_HEADROOM);
+			return -EINVAL;
+		}
+	}
+
+	if (rx_timestamp_valid_offset >= 0) {
+		if (rx_timestamp_offset < 0) {
+			AF_XDP_LOG_LINE(ERR,
+				"Timestamp offset must be configured when validity offset is configured");
+			return -EINVAL;
+		}
+		if (rx_timestamp_valid_offset < 1 ||
+		    rx_timestamp_valid_offset > XDP_PACKET_HEADROOM) {
+			AF_XDP_LOG_LINE(ERR,
+				"Validity hint offset must be between 1 and %u bytes",
+				XDP_PACKET_HEADROOM);
+			return -EINVAL;
+		}
+		if (rx_timestamp_valid_offset > rx_timestamp_offset - (int)sizeof(uint64_t) &&
+		    rx_timestamp_valid_offset <= rx_timestamp_offset) {
+			AF_XDP_LOG_LINE(ERR,
+				"Validity hint offset %d overlaps with 8-byte timestamp at offset %d",
+				rx_timestamp_valid_offset, rx_timestamp_offset);
+			return -EINVAL;
+		}
+		if (rx_timestamp_valid_mask == 0) {
+			AF_XDP_LOG_LINE(ERR,
+				"Validity mask cannot be zero when validity offset is configured");
+			return -EINVAL;
+		}
+	}
+
 	if (use_cni && use_pinned_map) {
 		AF_XDP_LOG_LINE(ERR, "When '%s' parameter is used, '%s' parameter is not valid",
 			ETH_AF_XDP_USE_CNI_ARG, ETH_AF_XDP_USE_PINNED_MAP_ARG);
@@ -2585,7 +2811,8 @@ rte_pmd_af_xdp_probe(struct rte_vdev_device *dev)
 	eth_dev = init_internals(dev, if_name, xsk_start_queue_idx,
 				 xsk_queue_cnt, shared_umem, prog_path,
 				 busy_budget, force_copy, use_cni, use_pinned_map,
-				 dp_path, xdp_mode);
+				 dp_path, xdp_mode, rx_timestamp_offset,
+				 rx_timestamp_valid_offset, rx_timestamp_valid_mask);
 	if (eth_dev == NULL) {
 		AF_XDP_LOG_LINE(ERR, "Failed to init internals");
 		return -1;
-- 
2.55.0.699.gb54405d56f-goog

