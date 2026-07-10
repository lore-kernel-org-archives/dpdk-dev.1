Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73984C43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 22:10:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F1F5040A81;
	Sat, 11 Jul 2026 00:10:21 +0200 (CEST)
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com
 [209.85.219.73]) by mails.dpdk.org (Postfix) with ESMTP id 3018B4065A
 for <dev@dpdk.org>; Sat, 11 Jul 2026 00:10:20 +0200 (CEST)
Received: by mail-qv1-f73.google.com with SMTP id
 6a1803df08f44-8eb8914e651so31351116d6.3
 for <dev@dpdk.org>; Fri, 10 Jul 2026 15:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783721419; x=1784326219; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KWYMtNnLHp81POBbJB4td5S4oh1raglKigi09CV5EGw=;
 b=aztXUKB/IlLRLHby67JVybjHRtlCZvKPMuNfoVbgLZzQ6ztj/QGMOJBIRDy75nqbH9
 law4bFUtb1a0DhdFny6RXdZOhgx8bAu5xDcehaNO1np9isdiD1Z4+NIo0CmP3g8VFOdM
 a+FjQ5AVb7JDonYL+DOn0jn6u4qu9u1xoNce13VA/b6vhUfHAtWKtTcmOAIz2z/ue0+j
 /v4Pa3OyxHaThzflN6VjRFGgkZ1n0Gc4NQylOzwde/J5t3VVFZyzylr5VlmZlQp2/NAp
 yc9P+CHorHS7DGVWoc1bJdWJIAUaBqMrCH55Y4k+65suFcFPoB9fktpsJqEdgLJGVzln
 opLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783721419; x=1784326219;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KWYMtNnLHp81POBbJB4td5S4oh1raglKigi09CV5EGw=;
 b=SKxopHOhazLWpevVk8vwHIVuCEOf4HJpAytSaP4YQeKEMzwppOV00lkwwC00JkQg+f
 eUJA7swp4U5jIrvSjckG4L/yqrPjCjeuV5/eQEGlsYXk8d6DyeRXY9jMWyrzg2wMp+fA
 zKIKJL/RbHItra+/ik1tqJBRa2hJDSyz2VVNlWrpkYN1mjgfG2fVN1u1kCXY5xUvEfei
 PjY8yMtadeEn/ZjXEWUOy2hi21DGRv7IzWiIdTtvTi5tBzm8XCjZ316Zd8WJ/cntY++r
 YLhxgxnLjElW2K4Xaik0mXjqSghrFYNPMmyfr0JVyI5ZsB1D51v55R4NXOcYvWVw1vWi
 9V9Q==
X-Gm-Message-State: AOJu0Yyx1klDpr13DdYdAHfLOPqQnC65ajFckx/J8P2N4NEk+opt0teu
 dwXguwuvBc54KIlWvdpwmvxSaFDG0JXHjifT7b8kn+5HNiMS53BIbYCcMVGnWRlzBnx+uyZKxF9
 6UZIPCOeLLP7vCEEolNcpvjJwchAawMfeyML9V6Qqi205kzHT4iFBss+Q/duk2tEEGOIxrnAiWv
 Jy7Aw6EumQziLRMqdWcqt1t9g=
X-Received: from qtvx1.prod.google.com ([2002:ac8:4d41:0:b0:517:6663:a9fe])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5954:0:b0:517:90d2:598b
 with SMTP id d75a77b69052e-51cbf1b5c96mr8289101cf.39.1783721419011; Fri, 10
 Jul 2026 15:10:19 -0700 (PDT)
Date: Fri, 10 Jul 2026 22:10:11 +0000
In-Reply-To: <20260710221013.3913447-1-blasko@google.com>
Mime-Version: 1.0
References: <20260623215325.814776-1-blasko@google.com>
 <20260710221013.3913447-1-blasko@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260710221013.3913447-2-blasko@google.com>
Subject: [PATCH v2 1/2] net/af_xdp: add af_xdp rx metadata and dynamic
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
v2:
  - Replace static metadata struct assumption with layout-agnostic devargs
    (xdp_meta_rx_ts_offset, xdp_meta_valid_hint_offset, and
    xdp_meta_rx_ts_valid_mask).
  - Support per-packet timestamp validity verification via metadata hint flag.
  - Reject PMD probe if validity mask is zero when validity offset is set.
---
 drivers/net/af_xdp/rte_eth_af_xdp.c | 139 +++++++++++++++++++++++++++-
 1 file changed, 134 insertions(+), 5 deletions(-)

diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c b/drivers/net/af_xdp/rte_eth_af_xdp.c
index 2cdb533276..2f9ad7d180 100644
--- a/drivers/net/af_xdp/rte_eth_af_xdp.c
+++ b/drivers/net/af_xdp/rte_eth_af_xdp.c
@@ -62,6 +62,10 @@
 #define PF_XDP AF_XDP
 #endif
 
+
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
 
@@ -398,6 +415,27 @@ af_xdp_rx_zc(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 		rte_pktmbuf_pkt_len(bufs[i]) = len;
 		rte_pktmbuf_data_len(bufs[i]) = len;
+
+		if (rxq->rx_timestamp_enabled &&
+		    timestamp_dynfield_offset >= 0) {
+			/*
+			 * Copy timestamp if validity offset is not defined or
+			 * flag is valid.
+			 */
+			if (rxq->rx_timestamp_valid_offset < 0 ||
+			    (*(uint8_t *)((char *)rte_pktmbuf_mtod(bufs[i], void *) -
+					  rxq->rx_timestamp_valid_offset) &
+			     rxq->rx_timestamp_valid_mask)) {
+				uint64_t *ts_ptr = (uint64_t *)
+					((char *)rte_pktmbuf_mtod(bufs[i], void *) -
+					 rxq->rx_timestamp_offset);
+				*RTE_MBUF_DYNFIELD(bufs[i],
+						   timestamp_dynfield_offset,
+						   uint64_t *) = *ts_ptr;
+				bufs[i]->ol_flags |= timestamp_dynflag;
+			}
+		}
+
 		rx_bytes += len;
 	}
 
@@ -457,6 +495,25 @@ af_xdp_rx_cp(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		len = desc->len;
 		pkt = xsk_umem__get_data(rxq->umem->mz->addr, addr);
 
+		if (rxq->rx_timestamp_enabled &&
+		    timestamp_dynfield_offset >= 0) {
+			/*
+			 * Copy timestamp if validity offset is not defined or
+			 * flag is valid.
+			 */
+			if (rxq->rx_timestamp_valid_offset < 0 ||
+			    (*(uint8_t *)((char *)pkt -
+					  rxq->rx_timestamp_valid_offset) &
+			     rxq->rx_timestamp_valid_mask)) {
+				uint64_t *ts_ptr = (uint64_t *)((char *)pkt -
+					rxq->rx_timestamp_offset);
+				*RTE_MBUF_DYNFIELD(mbufs[i],
+						   timestamp_dynfield_offset,
+						   uint64_t *) = *ts_ptr;
+				mbufs[i]->ol_flags |= timestamp_dynflag;
+			}
+		}
+
 		rte_memcpy(rte_pktmbuf_mtod(mbufs[i], void *), pkt, len);
 		rte_ring_enqueue(umem->buf_ring, (void *)addr);
 		rte_pktmbuf_pkt_len(mbufs[i]) = len;
@@ -743,6 +800,22 @@ eth_dev_start(struct rte_eth_dev *dev)
 {
 	uint16_t i;
 
+	if (dev->data->dev_conf.rxmode.offloads &
+	    RTE_ETH_RX_OFFLOAD_TIMESTAMP) {
+		int rc;
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
+	}
+
 	dev->data->dev_link.link_status = RTE_ETH_LINK_UP;
 	for (i = 0; i < dev->data->nb_rx_queues; i++) {
 		dev->data->rx_queue_state[i] = RTE_ETH_QUEUE_STATE_STARTED;
@@ -870,6 +943,8 @@ eth_dev_info(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->max_rx_queues = internals->queue_cnt;
 	dev_info->max_tx_queues = internals->queue_cnt;
 
+	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_TIMESTAMP;
+
 	dev_info->min_mtu = RTE_ETHER_MIN_MTU;
 #if defined(XDP_UMEM_UNALIGNED_CHUNK_FLAG)
 	dev_info->max_rx_pktlen = getpagesize() -
@@ -1873,7 +1948,12 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 	process_private->rxq_xsk_fds[rx_queue_id] = rxq->fds[0].fd;
 
 	rxq->port = dev->data->port_id;
-
+	rxq->rx_timestamp_offset = internals->rx_timestamp_offset;
+	rxq->rx_timestamp_valid_offset = internals->rx_timestamp_valid_offset;
+	rxq->rx_timestamp_valid_mask = internals->rx_timestamp_valid_mask;
+	rxq->rx_timestamp_enabled = (rxq->rx_timestamp_offset >= 0) &&
+				    !!(dev->data->dev_conf.rxmode.offloads &
+				       RTE_ETH_RX_OFFLOAD_TIMESTAMP);
 	dev->data->rx_queues[rx_queue_id] = rxq;
 	return 0;
 
@@ -2032,6 +2112,22 @@ parse_integer_arg(const char *key __rte_unused,
 	return 0;
 }
 
+static int
+parse_mask_arg(const char *key __rte_unused,
+	       const char *value, void *extra_args)
+{
+	int *i = (int *)extra_args;
+	char *end;
+
+	*i = strtol(value, &end, 0);
+	if (*i < 0) {
+		AF_XDP_LOG_LINE(ERR, "Argument has to be positive.");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /** parse name argument */
 static int
 parse_name_arg(const char *key __rte_unused,
@@ -2146,7 +2242,9 @@ static int
 parse_parameters(struct rte_kvargs *kvlist, char *if_name, int *start_queue,
 		 int *queue_cnt, int *shared_umem, char *prog_path,
 		 int *busy_budget, int *force_copy, int *use_cni,
-		 int *use_pinned_map, char *dp_path, uint32_t *xdp_mode)
+		 int *use_pinned_map, char *dp_path, uint32_t *xdp_mode,
+		 int *rx_timestamp_offset, int *rx_timestamp_valid_offset,
+		 int *rx_timestamp_valid_mask)
 {
 	int ret;
 
@@ -2209,6 +2307,21 @@ parse_parameters(struct rte_kvargs *kvlist, char *if_name, int *start_queue,
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
+				 &parse_mask_arg, rx_timestamp_valid_mask);
+	if (ret < 0)
+		goto free_kvlist;
+
 free_kvlist:
 	rte_kvargs_free(kvlist);
 	return ret;
@@ -2248,7 +2361,9 @@ static struct rte_eth_dev *
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
@@ -2281,6 +2396,9 @@ init_internals(struct rte_vdev_device *dev, const char *if_name,
 	internals->use_pinned_map = use_pinned_map;
 	internals->mode_flag = XDP_FLAGS_UPDATE_IF_NOEXIST | xdp_mode;
 	strlcpy(internals->dp_path, dp_path, PATH_MAX);
+	internals->rx_timestamp_offset = rx_timestamp_offset;
+	internals->rx_timestamp_valid_offset = rx_timestamp_valid_offset;
+	internals->rx_timestamp_valid_mask = (uint8_t)rx_timestamp_valid_mask;
 
 	if (xdp_get_channels_info(if_name, &internals->max_queue_cnt,
 				  &internals->configured_queue_cnt)) {
@@ -2474,6 +2592,9 @@ rte_pmd_af_xdp_probe(struct rte_vdev_device *dev)
 	int use_pinned_map = 0;
 	uint32_t xdp_mode = 0;
 	char dp_path[PATH_MAX] = {'\0'};
+	int rx_timestamp_offset = -1;
+	int rx_timestamp_valid_offset = -1;
+	int rx_timestamp_valid_mask = 0;
 	struct rte_eth_dev *eth_dev = NULL;
 	const char *name = rte_vdev_device_name(dev);
 
@@ -2517,11 +2638,18 @@ rte_pmd_af_xdp_probe(struct rte_vdev_device *dev)
 	if (parse_parameters(kvlist, if_name, &xsk_start_queue_idx,
 			     &xsk_queue_cnt, &shared_umem, prog_path,
 			     &busy_budget, &force_copy, &use_cni, &use_pinned_map,
-			     dp_path, &xdp_mode) < 0) {
+			     dp_path, &xdp_mode, &rx_timestamp_offset,
+			     &rx_timestamp_valid_offset, &rx_timestamp_valid_mask) < 0) {
 		AF_XDP_LOG_LINE(ERR, "Invalid kvargs value");
 		return -EINVAL;
 	}
 
+	if (rx_timestamp_valid_offset >= 0 && rx_timestamp_valid_mask == 0) {
+		AF_XDP_LOG_LINE(ERR,
+			"Validity mask cannot be zero when validity offset is configured");
+		return -EINVAL;
+	}
+
 	if (use_cni && use_pinned_map) {
 		AF_XDP_LOG_LINE(ERR, "When '%s' parameter is used, '%s' parameter is not valid",
 			ETH_AF_XDP_USE_CNI_ARG, ETH_AF_XDP_USE_PINNED_MAP_ARG);
@@ -2585,7 +2713,8 @@ rte_pmd_af_xdp_probe(struct rte_vdev_device *dev)
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
2.55.0.141.g00534a21ce-goog

