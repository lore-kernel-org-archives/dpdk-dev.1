Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF1B606A332
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 19:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pMJGXWjb
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C73040E43;
	Mon,  9 Nov 2026 20:43:42 +0100 (CET)
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mails.dpdk.org (Postfix) with ESMTPS id 15AD840E37
 for <dev@dpdk.org>; Mon,  9 Nov 2026 20:43:40 +0100 (CET)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-824cc5f7fcdso1670999a34.3
 for <dev@dpdk.org>; Mon, 09 Nov 2026 11:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794253419; x=1794858219; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wCUzZ58+Zza/UFliGyQSYfuO571dlNMKFW6sTXu/Kbk=;
 b=pMJGXWjbeR2UDt49QMZgI9KotX/teGBBq3C3Afm1JuaDeGUS1iyztaLWS5i7E5DQdp
 oQGxmMKjTKD5pz0YS3K0Q5i8yybQVXGelgKzhcv4OwftFqURbZKVofoBatiI4KbNgPim
 7XcdL5TZoSl1za9ETEEI6G/pRgIgLgkZzD0D93PwwL5N82995SfvFafW4K6Gfywf9A/0
 bIQcKUqZYN/lP4lZCdRZQdxdYsF+MaidpIEo2MlIDWHq0b9AVlk1NC5JI6m7FFE/81/f
 HbtZdf1vgp0Tf1IQlTexlfuS/tZ1rmrr8qe+blEyAjxmdovaz8owCv7Z73tK+PRbX9dr
 GyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794253419; x=1794858219;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wCUzZ58+Zza/UFliGyQSYfuO571dlNMKFW6sTXu/Kbk=;
 b=glnn6zJrCwUw5SvS5ozUN8T7OK36Zo3FF/8vG9N6fGaueRGY71QB1F+e8oGlF1rVOc
 Y0vw5xndkklq4WwXVw6wig5ed7ByEWaGZw8GWvyf9cKPpkfaV/eJgcigqiBCXfJmna7J
 fRUEtX6VOSgPyZoFP+J2Mgg3IVlwT8a48hmNy8G6HcwkiPm1suvRUO/ORfeIrioB1iAC
 u7QLNr35AnQFYvKU6T4UehsM7u919z3uJ+JXDnMIwK7wewBjgiF5VHVEHEgtgsBPyEy0
 c+J3w/yqrYPgeQqeRxhRUXu64Z3S3zS+XLaCjOVF/ZcQz4J8JUjM+1E0bq1+8T12Eq0z
 1Iig==
X-Gm-Message-State: APuU4Z8lL4P2TUb1Cf7FQYdtSgfSWfD4+CVLt/3ZHFkU/1GxbwIgNK51
 Oe+Iec5AtreplT+aL2MksGnZKuXGgmWWZ63okExRRqMQvN0wyxP/Nh/gIo2G7SaGB25xCJBv31X
 qn2jDYzZKIQv4xA==
X-Received: from ilbeb4.prod.google.com ([2002:a05:6e02:4604:b0:53c:2d10:3af1])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:4feb:b0:503:8f9d:f11b with SMTP id
 5614622812f47-5683cde8478mr527062b6e.43.1794253418545; 
 Mon, 09 Nov 2026 11:43:38 -0800 (PST)
Date: Mon,  9 Nov 2026 11:43:30 -0800
In-Reply-To: <20261109194331.393364-1-joshwash@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261103181442.381856-1-joshwash@google.com>
 <20261109194331.393364-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261109194331.393364-3-joshwash@google.com>
Subject: [PATCH v4 2/3] net/gve: introduce Tx packet preparation for DQO format
From: Joshua Washington <joshwash@google.com>
To: Joshua Washington <joshwash@google.com>, Rushil Gupta <rushilg@google.com>,
 Varun Lakkur Ambaji Rao <varun.la@gmail.com>,
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

Fixes: 403c671a46b6 ("net/gve: support TSO in DQO RDA")
Cc: stable@dpdk.org

Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Ankit Garg <nktgrg@google.com>
---

Changes in v4:
- Remove dead checksum check, as checksum offloading is enabled by
  default when TSO is enabled.
Changes in v2:
- Rely on tx_pkt->nb_segs for descriptor limit calculation only as a
  precursor, falling back to the traditional gve_tx_pkt_nb_data_descs()
  if that optimization fails.
- Only call rte_net_intel_cksum_preapre on TSO packets that request
  checksum offloading. This enforces the additional requirement that
  headers are all in the same mbuf segment.
---
 drivers/net/gve/gve_ethdev.h |  3 ++
 drivers/net/gve/gve_tx_dqo.c | 77 +++++++++++++++++++++++++++++++++++-
 2 files changed, 78 insertions(+), 2 deletions(-)

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
index 3a20109a5d..78eaef3e3d 100644
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
 
@@ -283,6 +285,76 @@ gve_fill_tx_pkt_desc(struct gve_tx_queue *txq, uint16_t *tx_id,
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
+		bool tso;
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
+		/* If TSO is enabled, the L4 pseudo header checksum must be
+		 * seeded. In this case, headers must all be in the same buffer.
+		 */
+		if (tso) {
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
@@ -329,7 +401,7 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		tso = !!(ol_flags & RTE_MBUF_F_TX_TCP_SEG);
 		csum = !!(ol_flags & GVE_TX_CKSUM_OFFLOAD_MASK_DQO);
 
-		if (!gve_tx_validate_pkt(tx_pkt, tso)) {
+		if (!gve_tx_validate_pkt_limits(tx_pkt, tso)) {
 			txq->stats.invalid_pkts++;
 			rte_pktmbuf_free(tx_pkt);
 			continue;
@@ -683,4 +755,5 @@ void
 gve_set_tx_function_dqo(struct rte_eth_dev *dev)
 {
 	dev->tx_pkt_burst = gve_tx_burst_dqo;
+	dev->tx_pkt_prepare = gve_tx_pkt_prepare_dqo;
 }
-- 
2.56.0.542.g3ef89b7020-goog

