Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AFACDB47C
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 21:54:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D1F0402A2;
	Tue, 23 Jun 2026 23:54:37 +0200 (CEST)
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com
 [209.85.160.202])
 by mails.dpdk.org (Postfix) with ESMTP id E455740293
 for <dev@dpdk.org>; Tue, 23 Jun 2026 23:54:35 +0200 (CEST)
Received: by mail-qt1-f202.google.com with SMTP id
 d75a77b69052e-519899aa6bfso4548521cf.1
 for <dev@dpdk.org>; Tue, 23 Jun 2026 14:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782251675; x=1782856475; darn=dpdk.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=qa0JsgajxRDLtzkgCmFAOFE/U9oiiF19A8Kt6D3rUEQ=;
 b=CXr5oY5WVGiKWX1icmNNjG1OcsPPlUU5QrrK1hFcLPx/3vm5TaPFCUgmIKkF7GLaTB
 MqQ2sXs/OMNKIBz7TyngAwFF2wL5/FwmxGYBtV+U9yrqdhfZuGoMGd8Nbo3d/KnHWGVT
 oNczfrS3c5cQnqI8oZ9h7JrY+zBPcfiEf/rp4kZpvDOTXokn1ctrdu5eIMhD4b6OF9wL
 zBrhzw4ZPoMr3RH+pYlTg8b89Kw6qSwifMhYdhaCImpoaeMhv3QxamJFncdidLNukx16
 XadohcVPQskVCKzg4MA8UjiOZNwvDMcIQ+EGz5pUb2pTwccVb61qsaoBILeFOqo0RKne
 p7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782251675; x=1782856475;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qa0JsgajxRDLtzkgCmFAOFE/U9oiiF19A8Kt6D3rUEQ=;
 b=rMLsSGjmiPgVEPMxWHdpWa73iCjP6E1cPvmP4lUNx8rKb2E6mrCedwgDHTA1YHvamO
 Gg3cVaBGSWVTE97M38mQtFXwpue9fBy8gJCI14uAGu+DBgrXfX/DlDLXVDzXEPDGxILx
 4mdrHF9g4RW6GCOCBGzCCZQ4EGF6Nbvp92hRa3FbG3QbGvJi9HqGaKdZbwdlU06Ab72u
 gmOUBTU5M7I97YA64TU5+ZToxdkCOYdBDuy5ZSewE8Su+Xd3v+Gq/phBaMU29h5yLOuI
 827kiff5cAemdABZ86T+yxB/Jm3fEuKs+fLdEoqFT6gHVCg3fDvG+/EHC1s1VCkJUoyA
 3ZFA==
X-Gm-Message-State: AOJu0YxqntgF17/Chl6nX+NeIOQdE5gpaRDWed2DyZ7tlobGAZqCsd1/
 x1Z4e2V1fn2EjYucfArkkIXgcyrqeFUtvRQNxCkg6tHep0yYHGzj+J7QjYzo64nhz6SYm1Zw11s
 M8wNDnG5kSka1kZDh+rCSUbjxwfQIV+TbUQZoxNofGT/ndW4BLWQs4kodPYwG9eh+ygp25yrqAD
 FJwrLbBySEglhqm0oTJLYrirE=
X-Received: from qtnn9.prod.google.com ([2002:a05:622a:4649:b0:516:cb08:8941])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:487:b0:517:5e32:af23
 with SMTP id d75a77b69052e-51a61d7cee8mr13425121cf.23.1782251674743; Tue, 23
 Jun 2026 14:54:34 -0700 (PDT)
Date: Tue, 23 Jun 2026 21:53:24 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260623215325.814776-1-blasko@google.com>
Subject: [PATCH] net/af_xdp: add Rx metadata and dynamic timestamping support
From: Mark Blasko <blasko@google.com>
To: dev@dpdk.org, Ciara Loftus <ciara.loftus@intel.com>, 
 Maryam Tahhan <mtahhan@redhat.com>
Cc: Mark Blasko <blasko@google.com>, Joshua Washington <joshwash@google.com>, 
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

Enable dynamic RX timestamping in the AF_XDP Poll Mode Driver.
This extracts the ingress timestamp prepended to the packet
headroom by the XDP program and populates it in the mbuf.

Signed-off-by: Mark Blasko <blasko@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Jasper Tran O'Leary <jtranoleary@google.com>
---
 doc/guides/rel_notes/release_26_07.rst |  5 +++
 drivers/net/af_xdp/rte_eth_af_xdp.c    | 56 +++++++++++++++++++++++++-
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 6eba91a5e9..727442258f 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -63,6 +63,11 @@ New Features
     ``rte_eal_init`` and the application is responsible for probing each device,
   * ``--auto-probing`` enables the initial bus probing, which is the current default behavior.
 
+* **Updated AF_XDP ethernet driver.**
+
+  * Added support for dynamic RX metadata and timestamping offload
+    (``RTE_ETH_RX_OFFLOAD_TIMESTAMP``).
+
 * **Added LinkData sxe2 ethernet driver.**
 
   Added network driver for the LinkData network adapters.
diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c b/drivers/net/af_xdp/rte_eth_af_xdp.c
index 2cdb533276..c90e232d57 100644
--- a/drivers/net/af_xdp/rte_eth_af_xdp.c
+++ b/drivers/net/af_xdp/rte_eth_af_xdp.c
@@ -62,6 +62,13 @@
 #define PF_XDP AF_XDP
 #endif
 
+struct af_xdp_rx_metadata {
+	uint64_t rx_timestamp;
+};
+
+static int timestamp_dynfield_offset = -1;
+static uint64_t timestamp_dynflag;
+
 RTE_LOG_REGISTER_DEFAULT(af_xdp_logtype, NOTICE);
 #define RTE_LOGTYPE_NET_AF_XDP af_xdp_logtype
 
@@ -144,6 +151,7 @@ struct pkt_rx_queue {
 	struct pollfd fds[1];
 	int xsk_queue_idx;
 	int busy_budget;
+	bool rx_timestamp_enabled;
 };
 
 struct tx_stats {
@@ -398,6 +406,20 @@ af_xdp_rx_zc(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 		rte_pktmbuf_pkt_len(bufs[i]) = len;
 		rte_pktmbuf_data_len(bufs[i]) = len;
+
+		if (rxq->rx_timestamp_enabled &&
+		    timestamp_dynfield_offset >= 0) {
+			struct af_xdp_rx_metadata *meta;
+
+			meta = (struct af_xdp_rx_metadata *)
+				((char *)rte_pktmbuf_mtod(bufs[i], void *) -
+				 sizeof(struct af_xdp_rx_metadata));
+			*RTE_MBUF_DYNFIELD(bufs[i],
+					   timestamp_dynfield_offset,
+					   uint64_t *) = meta->rx_timestamp;
+			bufs[i]->ol_flags |= timestamp_dynflag;
+		}
+
 		rx_bytes += len;
 	}
 
@@ -457,6 +479,18 @@ af_xdp_rx_cp(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		len = desc->len;
 		pkt = xsk_umem__get_data(rxq->umem->mz->addr, addr);
 
+		if (rxq->rx_timestamp_enabled &&
+		    timestamp_dynfield_offset >= 0) {
+			struct af_xdp_rx_metadata *meta;
+
+			meta = (struct af_xdp_rx_metadata *)((char *)pkt -
+				sizeof(struct af_xdp_rx_metadata));
+			*RTE_MBUF_DYNFIELD(mbufs[i],
+					   timestamp_dynfield_offset,
+					   uint64_t *) = meta->rx_timestamp;
+			mbufs[i]->ol_flags |= timestamp_dynflag;
+		}
+
 		rte_memcpy(rte_pktmbuf_mtod(mbufs[i], void *), pkt, len);
 		rte_ring_enqueue(umem->buf_ring, (void *)addr);
 		rte_pktmbuf_pkt_len(mbufs[i]) = len;
@@ -743,6 +777,23 @@ eth_dev_start(struct rte_eth_dev *dev)
 {
 	uint16_t i;
 
+	if (dev->data->dev_conf.rxmode.offloads &
+	    RTE_ETH_RX_OFFLOAD_TIMESTAMP) {
+		int rc;
+
+		rc = rte_mbuf_dyn_rx_timestamp_register(
+				&timestamp_dynfield_offset,
+				&timestamp_dynflag);
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
@@ -870,6 +921,8 @@ eth_dev_info(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->max_rx_queues = internals->queue_cnt;
 	dev_info->max_tx_queues = internals->queue_cnt;
 
+	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_TIMESTAMP;
+
 	dev_info->min_mtu = RTE_ETHER_MIN_MTU;
 #if defined(XDP_UMEM_UNALIGNED_CHUNK_FLAG)
 	dev_info->max_rx_pktlen = getpagesize() -
@@ -1873,7 +1926,8 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 	process_private->rxq_xsk_fds[rx_queue_id] = rxq->fds[0].fd;
 
 	rxq->port = dev->data->port_id;
-
+	rxq->rx_timestamp_enabled = !!(dev->data->dev_conf.rxmode.offloads &
+					RTE_ETH_RX_OFFLOAD_TIMESTAMP);
 	dev->data->rx_queues[rx_queue_id] = rxq;
 	return 0;
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog

