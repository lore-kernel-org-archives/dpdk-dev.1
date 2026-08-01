Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58086C55171
	for <dpdk-dev@archiver.kernel.org>; Sat,  1 Aug 2026 03:25:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 77ADD40299;
	Sat,  1 Aug 2026 05:25:44 +0200 (CEST)
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 by mails.dpdk.org (Postfix) with ESMTP id 7930B402A7
 for <dev@dpdk.org>; Sat,  1 Aug 2026 05:25:42 +0200 (CEST)
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-80ee3cb097eso53084007b3.1
 for <dev@dpdk.org>; Fri, 31 Jul 2026 20:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1785554742; x=1786159542; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=a+J4sj+Hwhfba6vdGdRWdQdIijuylv+6/MAu/mR7i38=;
 b=WAqub+fsCpTJpwNg9H+/xPpAulve2Xd+njVMceA0lVVFtE5rC5/XILUZH4tx10MK67
 eR8INfMtD3LVi0xrPknWPAjYROjE8ERQvYd3yWF+Uxu74ubQ2DBgv+7uALmGRSPzGtUH
 6V/m9IyFV/V+NuZSumC8KJ60hE5WMZKx/gNnHoZqMeyQzocArkG7AQgHCZfxZd12eAeI
 uiUhW5CPowe62iKwT1GnE8oo9Dx+cqRRHNC3COgJHDcPbleLU5qhQJUvXdKxC+gERHnh
 gRWXBSRO+dOGEKQX1nWoe89YmrpSRUwIvE/fuZVNJo19me8Cj91C39ExBrwZI+OIsS2E
 4SDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785554742; x=1786159542;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a+J4sj+Hwhfba6vdGdRWdQdIijuylv+6/MAu/mR7i38=;
 b=Im9GRyhQ9fz7q+btPbcXTaLgGqyqCYnmXXY6cmRgAC8nYPk886mnSEZSZUlOBtlxzn
 /jGGXl45Fd4+5Z069UrF0u2IdZexbQ4c/MglbVw7uI+nUkC0J8Gj1Ad/XYxCCh7XVf2T
 T+2DIYmEcaix6vcZeUqQnQOLJOC704isg4UN/SLg1hHAgRPGgFiznod8wj7fvJ/qUv0N
 c6PVT5xYomdfzf+JVts8wKf25RlyvYuMvu4rWaxYeMxL3hPSRXV/NyqS30q71VNCW0Tb
 e2g7OL/wf5P79kQazjS1kfSrAGrr5SjxVQqU5F2bxNv4pPHkAFtxwmwlFRzKUPB7Xa0O
 oHQQ==
X-Gm-Message-State: AOJu0Yyy4Djz4xISY0DYzapaFQFk50Ubh9uCUldduQ3XbTY0p6BhrtYL
 Uh2/enJsjA4QOGWwGO2I23kcFekG6gnaPcy+PtaEBJKpnpAz+Ll9vvgTWZc/Hc/6KtC4xZotTrM
 QPgdUINczZnNh1e03TL4jUe/aQlTQe9ltbvgdoscKCOa1HrHYaGcCBNcFdLvSHltENpUqzCB01r
 NIfAPqVIMI66nNoN2dmuwSt+8=
X-Received: from ywbkr4.prod.google.com ([2002:a05:690c:4014:b0:81c:420a:6199])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:6e07:b0:81e:de49:128e
 with SMTP id 00721157ae682-81fd4a32c74mr34109857b3.13.1785554741217; Fri, 31
 Jul 2026 20:25:41 -0700 (PDT)
Date: Sat,  1 Aug 2026 03:25:32 +0000
In-Reply-To: <20260801032534.2865192-1-blasko@google.com>
Mime-Version: 1.0
References: <20260623215325.814776-1-blasko@google.com>
 <20260801032534.2865192-1-blasko@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260801032534.2865192-2-blasko@google.com>
Subject: [PATCH v4 1/2] net/af_xdp: add af_xdp rx metadata and dynamic
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
v4:
  - Validate rx_timestamp_offset (8 <= offset <= 256) and valid_hint_offset
    (1 <= offset <= 256) bounds.
  - Revert parse_integer_arg() to base 10 and add dedicated parse_hex_arg()
    for validity mask.
  - Optimize fast-path check and use rte_pktmbuf_mtod_offset() macro.
  - Preserve config.tx_type in SIOCSHWTSTAMP instead of forcing
    HWTSTAMP_TX_OFF.
  - Return -errno on socket failure and replace (caddr_t) casts with
    (void *).
  - Advertise RTE_ETH_RX_OFFLOAD_TIMESTAMP conditionally when
    rx_timestamp_offset >= 0.
  - Update af_xdp.ini features matrix with Timestamp offload = Y.
  - Document CAP_NET_ADMIN requirement and persistent HW filter side
    effect in af_xdp.rst.
v3:
  - Add PMD documentation in doc/guides/nics/af_xdp.rst.
  - Add release notes entry in doc/guides/rel_notes/release_26_07.rst.
  - Move dynamic mbuf timestamp field registration to eth_dev_start(),
    conditioned on RTE_ETH_RX_OFFLOAD_TIMESTAMP.
  - Replace 64-bit pointer casting with memcpy to fix ARM unaligned access
    faults.
  - Add devargs validation (validity mask <= 255) and support base 0
    integer parsing.
v2:
  - Replace static metadata struct assumption with layout-agnostic devargs
    (xdp_meta_rx_ts_offset, xdp_meta_valid_hint_offset, and
    xdp_meta_rx_ts_valid_mask).
  - Support per-packet timestamp validity verification via metadata hint
    flag.
  - Reject PMD probe if validity mask is zero when validity offset
    is set.
---
 doc/guides/nics/af_xdp.rst             |  35 ++++
 doc/guides/nics/features/af_xdp.ini    |   1 +
 doc/guides/rel_notes/release_26_07.rst |   6 +
 drivers/net/af_xdp/rte_eth_af_xdp.c    | 223 ++++++++++++++++++++++++-
 4 files changed, 260 insertions(+), 5 deletions(-)

diff --git a/doc/guides/nics/af_xdp.rst b/doc/guides/nics/af_xdp.rst
index 8bd17f04ae..b48f7fb9f0 100644
--- a/doc/guides/nics/af_xdp.rst
+++ b/doc/guides/nics/af_xdp.rst
@@ -212,6 +212,41 @@ the AF_XDP PMD configures it internally to the `AF_XDP Device Plugin for Kuberne
 
    --vdev=net_af_xdp0,use_pinned_map=1,dp_path="/tmp/afxdp_dp/<<interface name>>/xsks_map"
 
+xdp_meta_rx_ts_offset
+~~~~~~~~~~~~~~~~~~~~~
+
+The ``xdp_meta_rx_ts_offset`` argument specifies the byte offset of the 64-bit RX
+timestamp within the XDP metadata headroom area (prepended before packet data).
+
+.. code-block:: console
+
+    --vdev net_af_xdp,iface=ens786f1,xdp_meta_rx_ts_offset=8
+
+xdp_meta_valid_hint_offset
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The ``xdp_meta_valid_hint_offset`` argument specifies the byte offset of the validity
+flag byte within the XDP metadata headroom area.
+
+.. code-block:: console
+
+    --vdev net_af_xdp,iface=ens786f1,xdp_meta_rx_ts_offset=8,xdp_meta_valid_hint_offset=4
+
+xdp_meta_rx_ts_valid_mask
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The ``xdp_meta_rx_ts_valid_mask`` argument specifies the bitmask (in hex or decimal) used
+to verify timestamp validity at ``xdp_meta_valid_hint_offset``.
+
+.. code-block:: console
+
+    --vdev net_af_xdp,iface=ens786f1,xdp_meta_rx_ts_offset=8,xdp_meta_valid_hint_offset=4,xdp_meta_rx_ts_valid_mask=0x1
+
+Enabling dynamic Rx timestamping configures ``HWTSTAMP_FILTER_ALL`` on the kernel
+netdev interface via ``SIOCSHWTSTAMP`` (which requires ``CAP_NET_ADMIN``). This
+hardware filter setting persists on the netdev interface after the DPDK application
+exits.
+
 Limitations
 -----------
 
diff --git a/doc/guides/nics/features/af_xdp.ini b/doc/guides/nics/features/af_xdp.ini
index d2461dacfa..6fc70ec153 100644
--- a/doc/guides/nics/features/af_xdp.ini
+++ b/doc/guides/nics/features/af_xdp.ini
@@ -5,6 +5,7 @@
 ;
 [Features]
 Link status          = Y
+Timestamp offload    = Y
 Power mgmt address monitor = Y
 MTU update           = Y
 Promiscuous mode     = Y
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 8b1bdada1a..8af0b8d615 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -135,6 +135,12 @@ New Features
 
   Added network driver for the LinkData network adapters.
 
+* **Updated AF_XDP PMD.**
+
+  * Added support for RX metadata hardware timestamping via vdev devargs
+    ``xdp_meta_rx_ts_offset``, ``xdp_meta_valid_hint_offset``, and
+    ``xdp_meta_rx_ts_valid_mask``.
+
 * **Updated Google gve driver.**
 
   * Added hardware timestamping support on DQO queues.
diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c b/drivers/net/af_xdp/rte_eth_af_xdp.c
index 2cdb533276..b75c87b641 100644
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
 
@@ -398,6 +415,28 @@ af_xdp_rx_zc(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 		rte_pktmbuf_pkt_len(bufs[i]) = len;
 		rte_pktmbuf_data_len(bufs[i]) = len;
+
+		if (rxq->rx_timestamp_enabled) {
+			/*
+			 * Copy timestamp if validity offset is not defined or
+			 * flag is valid.
+			 */
+			if (rxq->rx_timestamp_valid_offset < 0 ||
+			    (*rte_pktmbuf_mtod_offset(bufs[i], uint8_t *,
+						      -rxq->rx_timestamp_valid_offset) &
+			     rxq->rx_timestamp_valid_mask)) {
+				uint64_t ts;
+				memcpy(&ts,
+				       rte_pktmbuf_mtod_offset(bufs[i], char *,
+							       -rxq->rx_timestamp_offset),
+				       sizeof(ts));
+				*RTE_MBUF_DYNFIELD(bufs[i],
+						   timestamp_dynfield_offset,
+						   uint64_t *) = ts;
+				bufs[i]->ol_flags |= timestamp_dynflag;
+			}
+		}
+
 		rx_bytes += len;
 	}
 
@@ -457,6 +496,26 @@ af_xdp_rx_cp(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		len = desc->len;
 		pkt = xsk_umem__get_data(rxq->umem->mz->addr, addr);
 
+		if (rxq->rx_timestamp_enabled) {
+			/*
+			 * Copy timestamp if validity offset is not defined or
+			 * flag is valid.
+			 */
+			if (rxq->rx_timestamp_valid_offset < 0 ||
+			    (*(uint8_t *)((char *)pkt -
+					  rxq->rx_timestamp_valid_offset) &
+			     rxq->rx_timestamp_valid_mask)) {
+				uint64_t ts;
+				memcpy(&ts,
+				       (char *)pkt - rxq->rx_timestamp_offset,
+				       sizeof(ts));
+				*RTE_MBUF_DYNFIELD(mbufs[i],
+						   timestamp_dynfield_offset,
+						   uint64_t *) = ts;
+				mbufs[i]->ol_flags |= timestamp_dynflag;
+			}
+		}
+
 		rte_memcpy(rte_pktmbuf_mtod(mbufs[i], void *), pkt, len);
 		rte_ring_enqueue(umem->buf_ring, (void *)addr);
 		rte_pktmbuf_pkt_len(mbufs[i]) = len;
@@ -738,11 +797,79 @@ eth_af_xdp_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 #endif
 }
 
+static int
+eth_af_xdp_enable_hw_timestamping(const char *if_name)
+{
+	struct hwtstamp_config config = {0};
+	struct ifreq ifr = {0};
+	int fd, ret;
+
+	fd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (fd < 0)
+		return -errno;
+
+	ifr.ifr_data = (void *)&config;
+	strlcpy(ifr.ifr_name, if_name, IFNAMSIZ);
+
+	ret = ioctl(fd, SIOCGHWTSTAMP, &ifr);
+	if (ret == 0) {
+		if (config.rx_filter != HWTSTAMP_FILTER_NONE) {
+			close(fd);
+			return 0;
+		}
+	}
+
+	config.flags = 0;
+	config.rx_filter = HWTSTAMP_FILTER_ALL;
+
+	ret = ioctl(fd, SIOCSHWTSTAMP, &ifr);
+	close(fd);
+
+	if (ret < 0)
+		return -errno;
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
 	uint16_t i;
 
+	if (dev->data->dev_conf.rxmode.offloads &
+	    RTE_ETH_RX_OFFLOAD_TIMESTAMP) {
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
@@ -870,6 +997,11 @@ eth_dev_info(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
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
@@ -1873,7 +2005,13 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 	process_private->rxq_xsk_fds[rx_queue_id] = rxq->fds[0].fd;
 
 	rxq->port = dev->data->port_id;
-
+	rxq->rx_timestamp_offset = internals->rx_timestamp_offset;
+	rxq->rx_timestamp_valid_offset = internals->rx_timestamp_valid_offset;
+	rxq->rx_timestamp_valid_mask = internals->rx_timestamp_valid_mask;
+	rxq->rx_timestamp_enabled = (rxq->rx_timestamp_offset >= 0) &&
+				    (timestamp_dynfield_offset >= 0) &&
+				    !!(dev->data->dev_conf.rxmode.offloads &
+				       RTE_ETH_RX_OFFLOAD_TIMESTAMP);
 	dev->data->rx_queues[rx_queue_id] = rxq;
 	return 0;
 
@@ -2032,6 +2170,24 @@ parse_integer_arg(const char *key __rte_unused,
 	return 0;
 }
 
+/** parse hex from argument */
+static int
+parse_hex_arg(const char *key __rte_unused,
+	      const char *value, void *extra_args)
+{
+	int *i = (int *)extra_args;
+	char *end;
+
+	unsigned long val = strtoul(value, &end, 16);
+	if (val > UINT8_MAX) {
+		AF_XDP_LOG_LINE(ERR, "Validity mask must be a valid hex byte (0-0xFF).");
+		return -EINVAL;
+	}
+
+	*i = (int)val;
+	return 0;
+}
+
 /** parse name argument */
 static int
 parse_name_arg(const char *key __rte_unused,
@@ -2146,7 +2302,9 @@ static int
 parse_parameters(struct rte_kvargs *kvlist, char *if_name, int *start_queue,
 		 int *queue_cnt, int *shared_umem, char *prog_path,
 		 int *busy_budget, int *force_copy, int *use_cni,
-		 int *use_pinned_map, char *dp_path, uint32_t *xdp_mode)
+		 int *use_pinned_map, char *dp_path, uint32_t *xdp_mode,
+		 int *rx_timestamp_offset, int *rx_timestamp_valid_offset,
+		 int *rx_timestamp_valid_mask)
 {
 	int ret;
 
@@ -2209,6 +2367,21 @@ parse_parameters(struct rte_kvargs *kvlist, char *if_name, int *start_queue,
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
@@ -2248,7 +2421,9 @@ static struct rte_eth_dev *
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
@@ -2281,6 +2456,9 @@ init_internals(struct rte_vdev_device *dev, const char *if_name,
 	internals->use_pinned_map = use_pinned_map;
 	internals->mode_flag = XDP_FLAGS_UPDATE_IF_NOEXIST | xdp_mode;
 	strlcpy(internals->dp_path, dp_path, PATH_MAX);
+	internals->rx_timestamp_offset = rx_timestamp_offset;
+	internals->rx_timestamp_valid_offset = rx_timestamp_valid_offset;
+	internals->rx_timestamp_valid_mask = (uint8_t)rx_timestamp_valid_mask;
 
 	if (xdp_get_channels_info(if_name, &internals->max_queue_cnt,
 				  &internals->configured_queue_cnt)) {
@@ -2474,6 +2652,9 @@ rte_pmd_af_xdp_probe(struct rte_vdev_device *dev)
 	int use_pinned_map = 0;
 	uint32_t xdp_mode = 0;
 	char dp_path[PATH_MAX] = {'\0'};
+	int rx_timestamp_offset = -1;
+	int rx_timestamp_valid_offset = -1;
+	int rx_timestamp_valid_mask = 0;
 	struct rte_eth_dev *eth_dev = NULL;
 	const char *name = rte_vdev_device_name(dev);
 
@@ -2517,11 +2698,42 @@ rte_pmd_af_xdp_probe(struct rte_vdev_device *dev)
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
@@ -2585,7 +2797,8 @@ rte_pmd_af_xdp_probe(struct rte_vdev_device *dev)
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
2.55.0.508.g3f0d502094-goog

