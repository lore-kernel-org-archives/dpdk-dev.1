Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6832E606A31C
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 18:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DXg9oSHi
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DEC0D40E22;
	Fri, 30 Oct 2026 19:43:13 +0100 (CET)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mails.dpdk.org (Postfix) with ESMTPS id 5EAE640E21
 for <dev@dpdk.org>; Fri, 30 Oct 2026 19:43:13 +0100 (CET)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ab7f1efe5dso1830846a91.1
 for <dev@dpdk.org>; Fri, 30 Oct 2026 11:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793385792; x=1793990592; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CoN7pvjk+RPvVPqmn5YZgavCrNkbO/BWGSUNJEMa4M0=;
 b=DXg9oSHixlN/eO3PQwyMnmkgtFOXMaTtb1a0uoUAmYdrDS/iZiweaQvwBtbbXt3fFC
 kUtmR5EqSFEjG1OEOJ1TtIABoioznfbQJL4xxnhSc++h5fdyaUoaz/HQwNxjHlFkC7yr
 4EBuCX3eMbUKbyuMoEi6iUfbJUv1jICFSea/Yz6I4A+8OOSKO/dX9c0PdmkGKothZ8Hx
 j9s2f468qDPBbrnS79EJ7Z5ucj6LkjkjQcALAygjcG/StmmWoKg+tpahbUOUlPMaxygn
 fXcOSxlWbhUM44LZhdO3PdPg0LRBFlB+/ZL7gbFQfKwNu2zsS6/0tJD7aYbU/FAnjIGj
 OFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793385792; x=1793990592;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CoN7pvjk+RPvVPqmn5YZgavCrNkbO/BWGSUNJEMa4M0=;
 b=MbV6bsn4a8PlC/k8rJg/4SN3JduXBb2qkito+WQQSYLY8M8q2r+0Kci5xwHmr8zeMc
 E+H0sfw1H70ii6G5HZd4S6yHYULi/NbB3Es46nQ5/at9Odx0o0hLdMyAgbwZz2wJO9KD
 bAAYSkfBJzPo0GWnGu4qPZBN9sas043oM+yQfq0XW8XD2/AOpNnDf+kxPWPOOtQ15869
 z4K26BPhI1CPKE6TV+c+X1sgyyDWujc5F/HNteJbW55Bmgez9pMxLulkDqL3JV1JRN0Q
 jqR6ikw7+kmQbliE5hvtxqaMMMA6abCSVkvs5KC3C9PirTgXIH8EOZc9798yqLJgXIfe
 ixhQ==
X-Gm-Message-State: AFq9FYIcarj1LC0dt0Mmqx865XxssibdhKym9vnVsyd5dneauSx2D6kJ
 mhxwzVRkZiX6GkrhdzsIX9NaWtzLTeOivZZ973tT3sd83P7M2oe8Z/FiZnvi3VE/w6Wp5nPW2Up
 EGDk79sm5I99QpQ==
X-Received: from pjbcq4.prod.google.com ([2002:a17:90a:f984:b0:3ad:ce09:ff3])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:380c:b0:3ad:13fe:41ba with SMTP id
 98e67ed59e1d1-3ae897c8968mr2432830a91.52.1793385791642; 
 Fri, 30 Oct 2026 11:43:11 -0700 (PDT)
Date: Fri, 30 Oct 2026 11:43:02 -0700
In-Reply-To: <20261030184304.508282-1-joshwash@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261030184304.508282-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261030184304.508282-4-joshwash@google.com>
Subject: [PATCH v2 3/4] net/gve: introduce Tx packet preparation for DQO format
From: Joshua Washington <joshwash@google.com>
To: Joshua Washington <joshwash@google.com>,
 Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
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

Fixes: 84472d3edffa ("net/gve: fix Tx stall on invalid packets")
Cc: stable@dpdk.org

Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Ankit Garg <nktgrg@google.com>
---
Depends-on: series-39707 ("net/gve: fix DQO Tx queue stalls")

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
index 26c6a304a6..ab5af33ca9 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -649,6 +649,9 @@ gve_rx_burst_dqo(void *rxq, struct rte_mbuf **rx_pkts, uint16_t nb_pkts);
 uint16_t
 gve_tx_burst_dqo(void *txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts);
 
+uint16_t
+gve_tx_pkt_prepare_dqo(void *txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts);
+
 void
 gve_set_rx_function_dqo(struct rte_eth_dev *dev);
 
diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index 00a4ea9d27..d6ed238849 100644
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
 
@@ -303,6 +305,78 @@ gve_fill_tx_pkt_desc(struct gve_tx_queue *txq, uint16_t *tx_id,
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
@@ -349,7 +423,7 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		tso = !!(ol_flags & RTE_MBUF_F_TX_TCP_SEG);
 		csum = !!(ol_flags & GVE_TX_CKSUM_OFFLOAD_MASK_DQO);
 
-		if (!gve_tx_validate_pkt(tx_pkt, tso)) {
+		if (!gve_tx_validate_pkt_limits(tx_pkt, tso)) {
 			txq->stats.invalid_pkts++;
 			rte_pktmbuf_free(tx_pkt);
 			continue;
@@ -703,4 +777,5 @@ void
 gve_set_tx_function_dqo(struct rte_eth_dev *dev)
 {
 	dev->tx_pkt_burst = gve_tx_burst_dqo;
+	dev->tx_pkt_prepare = gve_tx_pkt_prepare_dqo;
 }
-- 
2.56.0.317.g454f8302e1-goog

