Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4ABC71130
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Jul 2025 23:18:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7DE2040685;
	Tue,  8 Jul 2025 01:18:21 +0200 (CEST)
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com
 [209.85.210.201])
 by mails.dpdk.org (Postfix) with ESMTP id B395740677
 for <dev@dpdk.org>; Tue,  8 Jul 2025 01:18:17 +0200 (CEST)
Received: by mail-pf1-f201.google.com with SMTP id
 d2e1a72fcca58-74b185fba41so2885786b3a.1
 for <dev@dpdk.org>; Mon, 07 Jul 2025 16:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1751930297; x=1752535097; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=0joAZ8QH7nPn/iVTF+6Y3daHRhQ+gLay70HBFt7Gy7w=;
 b=DJmXiwPxC/QiYMq1NhoJXA2++fpN6JM8e7wxNmUF5SJlJGlub2uDSB7ZcqBXHBMHGo
 TQLFo/i9WO5gts3F3g46ptpl5EfVT9D1MKzFatvDuriitie3yrFYe48BNFQIVugLTj59
 iCEnMaFoWlnKi2Gq8ZTwA1hoNqVere9aBpk46AcVARsm0VYwsyf4KqYVILmgWRSA2fj6
 oUlQDLaWThSgLWhNu8BhCRLO78AP+M4xx1zAY/GGpglhP+2aEjeEhQ4hdVAdoIzNtkNJ
 59rO+Q53UoK2K1ojraqo+TkgNdzWjlAVfQBXWe/g5qTet8DujjuxG42/tUkofSnb3V7T
 gW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751930297; x=1752535097;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0joAZ8QH7nPn/iVTF+6Y3daHRhQ+gLay70HBFt7Gy7w=;
 b=H+OXffJ6NgcxFurX1LmqjAIQ8EoNRsoipRUG+56Bd6PDOORQG2QCRphg2ABK7UD/Z1
 2cyTWjjiNGVIpzhh4yw1mnZ02ocWzRtJIaLUo+xCKTFCXJ0NzVzJhj5S97aO1jRAtGVp
 ZF2+takCGWj9J3HiCX6VmXrNnbhVSLhzvGECfV10bAu0/qfng2/by6fSOcYhIeHfqS/F
 cnyKga3vQ7dN5MI6FSyQUIg7Qi4JgrUrERMTWUNP2PTmXkYecC+/TPuW7gc88oYL5Ktb
 NVXUSllPoE7nuLtoCRNSj+hDRHeulBruK3ec0HQ/F6dCGzG9c+EzquHVAq4Pqo2u08iq
 jlfw==
X-Gm-Message-State: AOJu0YxrDo2yV2irzE5s208BbTDLDG8KLEbFOyYzmTO+cRU6dPtUDsWU
 X7EdwoFt/gSpA+nZS2oJxsroLEgSmrrI/bten3RwWOx7HYxhXP4AetP9x8Me/OLK7RQpx8pb+65
 mCuVBBM5RiDFhvw==
X-Google-Smtp-Source: AGHT+IH0bZ8vBjsmXysLa9HSaVWyHJIoA2Qy7OUeDZNjQsLOwYDMvOTFLM5AGD+r1ZYvde0/weS1ElB6abzjsg==
X-Received: from pfbce13.prod.google.com
 ([2002:a05:6a00:2a0d:b0:746:1eb5:7f3e])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:bd93:b0:748:31ed:ba8a with SMTP id
 d2e1a72fcca58-74d24994a25mr1202062b3a.15.1751930296877; 
 Mon, 07 Jul 2025 16:18:16 -0700 (PDT)
Date: Mon,  7 Jul 2025 16:18:06 -0700
In-Reply-To: <20250707231812.1937260-1-joshwash@google.com>
Mime-Version: 1.0
References: <20250707231812.1937260-1-joshwash@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250707231812.1937260-3-joshwash@google.com>
Subject: [PATCH 2/7] net/gve: clean when there are insufficient Tx descs
From: Joshua Washington <joshwash@google.com>
To: Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>, 
 Rushil Gupta <rushilg@google.com>, Junfeng Guo <junfengg@nvidia.com>
Cc: dev@dpdk.org, junfeng.guo@intel.com, stable@dpdk.org, 
 Ankit Garg <nktgrg@google.com>
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

A single packet can technically require more than 32 (free_thresh)
descriptors to send. Count the number of descriptors needed to send out
a packet in DQO Tx, and ensure that there are enough descriptors in the
ring before writing. If there are not enough free descriptors, drop the
packet and increment drop counters.

Fixes: 4022f9999f56 ("net/gve: support basic Tx data path for DQO")
Cc: junfeng.guo@intel.com
Cc: stable@dpdk.org

Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Ankit Garg <nktgrg@google.com>
---
 drivers/net/gve/gve_tx_dqo.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index 6227fa73b0..652a0e5175 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -74,6 +74,12 @@ gve_tx_clean_dqo(struct gve_tx_queue *txq)
 	txq->complq_tail = next;
 }
 
+static inline void
+gve_tx_clean_descs_dqo(struct gve_tx_queue *txq, uint16_t nb_descs) {
+	while (--nb_descs)
+		gve_tx_clean_dqo(txq);
+}
+
 static uint16_t
 gve_tx_pkt_nb_data_descs(struct rte_mbuf *tx_pkt)
 {
@@ -107,7 +113,6 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	struct rte_mbuf **sw_ring;
 	struct rte_mbuf *tx_pkt;
 	uint16_t mask, sw_mask;
-	uint16_t nb_to_clean;
 	uint16_t nb_tx = 0;
 	uint64_t ol_flags;
 	uint16_t nb_descs;
@@ -130,11 +135,9 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	for (nb_tx = 0; nb_tx < nb_pkts; nb_tx++) {
 		tx_pkt = tx_pkts[nb_tx];
 
-		if (txq->nb_free <= txq->free_thresh) {
-			nb_to_clean = DQO_TX_MULTIPLIER * txq->rs_thresh;
-			while (nb_to_clean--)
-				gve_tx_clean_dqo(txq);
-		}
+		if (txq->nb_free <= txq->free_thresh)
+			gve_tx_clean_descs_dqo(txq, DQO_TX_MULTIPLIER *
+					       txq->rs_thresh);
 
 		ol_flags = tx_pkt->ol_flags;
 		first_sw_id = sw_id;
@@ -144,8 +147,16 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 		nb_descs = gve_tx_pkt_nb_data_descs(tx_pkt);
 		nb_descs += tso;
-		if (txq->nb_free < nb_descs)
-			break;
+
+		/* Clean if there aren't enough descriptors to send the packet. */
+		if (unlikely(txq->nb_free < nb_descs)) {
+			int nb_to_clean = RTE_MAX(DQO_TX_MULTIPLIER * txq->rs_thresh,
+						  nb_descs);
+
+			gve_tx_clean_descs_dqo(txq, nb_to_clean);
+			if (txq->nb_free < nb_descs)
+				break;
+		}
 
 		if (tso) {
 			txd = &txr[tx_id];
-- 
2.50.0.727.gbf7dc18ff4-goog

