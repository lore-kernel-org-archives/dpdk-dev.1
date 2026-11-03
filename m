Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B21606A328
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 18:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Op66wslO
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4841641141;
	Tue,  3 Nov 2026 19:14:56 +0100 (CET)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mails.dpdk.org (Postfix) with ESMTPS id 873EA41141
 for <dev@dpdk.org>; Tue,  3 Nov 2026 19:14:54 +0100 (CET)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2e94f72fb9fso42443395ad.1
 for <dev@dpdk.org>; Tue, 03 Nov 2026 10:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793729693; x=1794334493; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CeuqfmwItgMKL7cpGeqOlXR/vBhGWdsQ+XX1rNcrlYo=;
 b=Op66wslOgGc+YtAYfiN1JZEGNPSLy/JnInRJyS9MXrCxAPoKPJR1LnFNxooflKK8TM
 jm0FrKga0zbChkzrDEVum84jAfRxhm3bdDhPnIwwUH9JmET2ILUrUwqztvO71FPgCTUm
 Lx7Q0c0EL42CqRdb57R9PTjen1VJw9RJHJaYhHznJrKj6Wdtl1q0CYxLNuZG6PddTehD
 7s9eA87MgBtfKz0cAL6Xeq0ojUIkcrRfHo644aul0tWIdUlLvbRVKlvfbDXVOhOIqGW2
 cVz8Z7Sf7mVqi8UqMYslr5b5NOS/ZJzjekZNUvW230mWKFVAWPhqXu2GYi5gDPHBIwrK
 xRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793729693; x=1794334493;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CeuqfmwItgMKL7cpGeqOlXR/vBhGWdsQ+XX1rNcrlYo=;
 b=acSCl71kfhbUc5Xyb6fDky8zi7KKX1wzLxYBEB/iFXFqmjf4RIJbDJSJbRt8wpcxB+
 IjKzHDG27nUPE0hJQfDQRy3gkRtSwihfxIUL4ZDXeg7P8GyH7uVe7FeEEGUioGZZlJ0E
 QS0KFrc0vR9x9wLa6Rje5Y2QWUsG+DhpSgWwzCytN+p4UMcNwsIIiQuvOyz6bh6nlXGX
 dDXJuYDVmRMUUekG3hXILsHZ/x0v1HalXAUJLptua91ZV9/g+iuPToxiAQJvt1Z0ET+v
 m0nMvYaC9W8+c0QHEGgR1WMw2n1yUT3dzpaLkdwD/y3dzjQL85ro5e7APuObe/e6UDc5
 43YQ==
X-Gm-Message-State: APuU4Z85d0P3xoBKmCqDUaf4MbHSi4mPSSJoEsjNWWQdcNnbnH8WbaYa
 Cj1A+/BqvCntOI3CyAFe3cOfemA0GHLhI9UtXguHrPN5EfWw2q/W2CMN/zWQqO38Phdoln60rym
 OAD5ZU6klAnyX3Q==
X-Received: from plbkk3.prod.google.com ([2002:a17:903:703:b0:2e9:4ed2:2e34])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:e7c9:b0:3ad:4a8b:c6e1 with SMTP id
 98e67ed59e1d1-3ae8970ef63mr11520578a91.19.1793729692699; 
 Tue, 03 Nov 2026 10:14:52 -0800 (PST)
Date: Tue,  3 Nov 2026 10:14:41 -0800
In-Reply-To: <20261103181442.381856-1-joshwash@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261030184304.508282-1-joshwash@google.com>
 <20261103181442.381856-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103181442.381856-3-joshwash@google.com>
Subject: [PATCH v3 2/3] net/gve: introduce Tx packet preparation for DQO format
From: Joshua Washington <joshwash@google.com>
To: Joshua Washington <joshwash@google.com>,
 Varun Lakkur Ambaji Rao <varun.la@gmail.com>, 
 Tathagat Priyadarshi <tathagat.dpdk@gmail.com>,
 Rushil Gupta <rushilg@google.com>
Cc: dev@dpdk.org, stable@dpdk.org, 
 Praveen Kaligineedi <pkaligineedi@google.com>, Ankit Garg <nktgrg@google.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Before this patch, packets that are invalid in the DQO format with
respect to offloads, descriptor limits, or packet size limits, are
dropped by the driver without any form of recourse for the application,
potentially leading to a disruption in traffic that can be hard to
debug.

Introduce tx_pkt_prepare for the DQ queue format to avoid dropping
packets without first giving the application a way to know that they
are invalid. For TSO packets, this method also computes the TCP
pseudo-header for packets with checksum offloading enabled. Note that
in this case, such packets must have L2/L3/L4 headers in the same mbuf
segment to pass tx_pkt_prepare.

Fixes: 403c671a46b6 ("net/gve: support TSO in DQO RDA")
Cc: stable@dpdk.org

Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Ankit Garg <nktgrg@google.com>
---

Changes in v2:
- Rely on tx_pkt->nb_segs for descriptor limit calculation only as a
  precursor, falling back to the traditional gve_tx_pkt_nb_data_descs()
  if that optimization fails.
- Only call rte_net_intel_cksum_preapre on TSO packets that request
  checksum offloading. This enforces the additional requirement that
  headers are all in the same mbuf segment.
---
 drivers/net/gve/gve_ethdev.h |  3 ++
 drivers/net/gve/gve_tx_dqo.c | 79 +++++++++++++++++++++++++++++++++++-
 2 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index 3a8ddfbbb6..0370dc1479 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -651,6 +651,9 @@ gve_rx_burst_dqo(void *rxq, struct rte_mbuf **rx_pkts, uint16_t nb_pkts);
 uint16_t
 gve_tx_burst_dqo(void *txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts);
 
+uint16_t
+gve_tx_pkt_prepare_dqo(void *txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts);
+
 void
 gve_set_rx_function_dqo(struct rte_eth_dev *dev);
 
diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index 3a20109a5d..7858c21012 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -3,6 +3,8 @@
  * Copyright (c) 2022-2023 Intel Corporation
  */
 
+#include <rte_net.h>
+
 #include "gve_ethdev.h"
 #include "base/gve_adminq.h"
 #include "rte_malloc.h"
@@ -125,7 +127,7 @@ gve_tx_clean_descs_dqo(struct gve_tx_queue *txq, uint16_t nb_descs) {
 
 /* Validate packet lengths against the device limits. */
 static inline bool
-gve_tx_validate_pkt(const struct rte_mbuf *tx_pkt, bool is_tso)
+gve_tx_validate_pkt_limits(const struct rte_mbuf *tx_pkt, bool is_tso)
 {
 	uint32_t headlen;
 
@@ -283,6 +285,78 @@ gve_fill_tx_pkt_desc(struct gve_tx_queue *txq, uint16_t *tx_id,
 	}
 }
 
+uint16_t
+gve_tx_pkt_prepare_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
+{
+	struct gve_tx_queue *txq = tx_queue;
+	uint16_t i;
+
+	for (i = 0; i < nb_pkts; i++) {
+		struct rte_mbuf *tx_pkt;
+		uint16_t nb_descs;
+		bool tso, csum;
+		int err;
+
+		tx_pkt = tx_pkts[i];
+
+#ifdef RTE_ETHDEV_DEBUG_TX
+		const char *reason;
+
+		if (rte_mbuf_check(tx_pkt, true, &reason)) {
+			rte_errno = EINVAL;
+			return i;
+		}
+
+		err = rte_validate_tx_offload(tx_pkt);
+		if (err != 0) {
+			rte_errno = -err;
+			return i;
+		}
+#endif
+
+		tso = !!(tx_pkt->ol_flags & RTE_MBUF_F_TX_TCP_SEG);
+		if (!gve_tx_validate_pkt_limits(tx_pkt, tso)) {
+			rte_errno = EINVAL;
+			return i;
+		}
+
+		if (tso) {
+			nb_descs = gve_tx_pkt_nb_data_descs(tx_pkt) + 1;
+		} else {
+			/* Handle non-TSO packets by directly checking nb_segs.
+			 * The packet has already been validated to be no larger
+			 * than 9728B, so every descriptor is guaranteed to only
+			 * require a single descriptor.
+			 * If the packet does not meet the hardware descriptor
+			 * limits, fall back to the mbuf walk in case the
+			 * mbuf has empty segments.
+			 */
+			if (tx_pkt->nb_segs <= GVE_TX_MAX_DATA_DESCS)
+				continue;
+			nb_descs = gve_tx_pkt_nb_data_descs(tx_pkt);
+		}
+		if (!gve_tx_validate_descs(txq, tx_pkt, nb_descs, tso)) {
+			rte_errno = ENOTSUP;
+			return i;
+		}
+
+		/* If checksum offloading is requested, the L4 pseudo header
+		 * checksum must be seeded. In this case, headers must all be in
+		 * the same buffer.
+		 */
+		csum = !!(tx_pkt->ol_flags & GVE_TX_CKSUM_OFFLOAD_MASK_DQO);
+		if (csum && tso) {
+			err = rte_net_intel_cksum_prepare(tx_pkt);
+			if (err != 0) {
+				rte_errno = -err;
+				return i;
+			}
+		}
+	}
+
+	return nb_pkts;
+}
+
 uint16_t
 gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 {
@@ -329,7 +403,7 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		tso = !!(ol_flags & RTE_MBUF_F_TX_TCP_SEG);
 		csum = !!(ol_flags & GVE_TX_CKSUM_OFFLOAD_MASK_DQO);
 
-		if (!gve_tx_validate_pkt(tx_pkt, tso)) {
+		if (!gve_tx_validate_pkt_limits(tx_pkt, tso)) {
 			txq->stats.invalid_pkts++;
 			rte_pktmbuf_free(tx_pkt);
 			continue;
@@ -683,4 +757,5 @@ void
 gve_set_tx_function_dqo(struct rte_eth_dev *dev)
 {
 	dev->tx_pkt_burst = gve_tx_burst_dqo;
+	dev->tx_pkt_prepare = gve_tx_pkt_prepare_dqo;
 }
-- 
2.56.0.385.gac671c819a-goog

