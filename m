Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB36606A323
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 20:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=LPgA2xPC
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1901140687;
	Mon, 26 Oct 2026 21:23:40 +0100 (CET)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mails.dpdk.org (Postfix) with ESMTPS id EA81440431
 for <dev@dpdk.org>; Mon, 26 Oct 2026 21:23:35 +0100 (CET)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3adcb81f487so5446328a91.3
 for <dev@dpdk.org>; Mon, 26 Oct 2026 13:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1793046214; x=1793651014; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=q8HYsWvFvtGOt5wNGoEfTPaDTsAmt9IXR+U1av+4FuE=;
 b=LPgA2xPCxWLYfuSagftEwbek6a8LS6FhqiIBHlPYgZ2MdG7UBRb9VXOTIvv4L3VsOB
 Rd3fBgkUMkNW/+deNA4ZWCmrlK+vga4sHzoA0mgees5gpNJ6mFuhyZCz8gGXpzhxdf51
 ICPpGX2X0AJ3GlDQ7Q/E75xrmI3KZgCFtOkPg+43bJqIIpKNq1XCabc3upolMCeQ60le
 6BnswHn8FifPUoZE2HZ0zJGH+ERvBrLwAMi21IRXmfC14P58/5ZY5M+je6fiw0CbBAWm
 07riUAd+AR7iR+nxlmT1ukWLfA5fT1O+e1FWp4cKuEuBS27Fk7xuH3ihRJgH886PSBFE
 gcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793046214; x=1793651014;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q8HYsWvFvtGOt5wNGoEfTPaDTsAmt9IXR+U1av+4FuE=;
 b=OO/JUogsnVFaB3ESNzM9s+Ar8WN9IXkog2pA353iR8IXvEUgFuFw1ZWbkyTrf2rsWb
 0gu0jX1XZVeTdsKdyL0fSPyy8Ls+IsiBV57OLtCCBP6YxayDk2ISl+hVJCW7CkOS2Am8
 8zuBLs8UpFq/2Q6sOKXkFTQoDILVKydJofBwImx8iLMKstkOe8zfuwNNTCdENhlw5uWv
 8Vgjx5Qilq3WIipFrMoCNy2gZU53SVMtOK9AaIH0M1iqLtMpnAoqxUuIGBr4fwcGS9iq
 u5wENHaNaSLigWhIcvdMpKqlSas0xCnBweLatOISaWCG+KLGdGCZuKJj+GD/ARPw67KR
 ckdA==
X-Gm-Message-State: AFq9FYJTZ/gteWgJEIO0wfIePL1T4pIF4Yy1EIfDSn4TUdokXd8fhPdT
 894wwAYSyQ2/z0T+vyKkZIc4o4ewCFMVz0Jxlx7VMycY8PcGS1MAyedeHYalKEmjukLhP3VE2Im
 ZnlfywEp32AxlBw==
X-Received: from pjbkb13.prod.google.com ([2002:a17:90a:e7cd:b0:3ab:d5d:f278])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:28c4:b0:3ac:9d14:fe9f with SMTP id
 98e67ed59e1d1-3adead57ca8mr6209373a91.31.1793046214177; 
 Mon, 26 Oct 2026 13:23:34 -0700 (PDT)
Date: Mon, 26 Oct 2026 13:23:27 -0700
In-Reply-To: <20261026202327.3897802-1-joshwash@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261026202327.3897802-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261026202327.3897802-4-joshwash@google.com>
Subject: [PATCH 3/3] net/gve: introduce Tx packet preparation for DQO format
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
are invalid.

Fixes: 84472d3edffa ("net/gve: fix Tx stall on invalid packets")
Cc: stable@dpdk.org

Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Ankit Garg <nktgrg@google.com>
---
Depends-on: series-39707 ("net/gve: fix DQO Tx queue stalls")
---
 drivers/net/gve/gve_ethdev.h |  3 ++
 drivers/net/gve/gve_tx_dqo.c | 64 ++++++++++++++++++++++++++++++++++--
 2 files changed, 65 insertions(+), 2 deletions(-)

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
index 00a4ea9d27..67ad41d618 100644
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
 
@@ -303,6 +305,63 @@ gve_fill_tx_pkt_desc(struct gve_tx_queue *txq, uint16_t *tx_id,
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
+		/* Handle non-TSO packets with a direct check of nb_segs. We
+		 * already validated that the packet is no larger than 9728B, so
+		 * every segment is guaranteed to only require a single
+		 * descriptor.
+		 */
+		nb_descs = tso ? gve_tx_pkt_nb_data_descs(tx_pkt) + 1 :
+			tx_pkt->nb_segs;
+		if (!gve_tx_validate_descs(txq, tx_pkt, nb_descs, tso)) {
+			rte_errno = ENOTSUP;
+			return i;
+		}
+
+		err = rte_net_intel_cksum_prepare(tx_pkt);
+		if (err != 0) {
+			rte_errno = -err;
+			return i;
+		}
+	}
+
+	return nb_pkts;
+}
+
 uint16_t
 gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 {
@@ -349,7 +408,7 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		tso = !!(ol_flags & RTE_MBUF_F_TX_TCP_SEG);
 		csum = !!(ol_flags & GVE_TX_CKSUM_OFFLOAD_MASK_DQO);
 
-		if (!gve_tx_validate_pkt(tx_pkt, tso)) {
+		if (!gve_tx_validate_pkt_limits(tx_pkt, tso)) {
 			txq->stats.invalid_pkts++;
 			rte_pktmbuf_free(tx_pkt);
 			continue;
@@ -703,4 +762,5 @@ void
 gve_set_tx_function_dqo(struct rte_eth_dev *dev)
 {
 	dev->tx_pkt_burst = gve_tx_burst_dqo;
+	dev->tx_pkt_prepare = gve_tx_pkt_prepare_dqo;
 }
-- 
2.56.0.307.g5fe7bd680c-goog

