Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF915CA601E
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 01:00:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCF9B4067A;
	Sat, 10 Oct 2026 02:59:59 +0200 (CEST)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mails.dpdk.org (Postfix) with ESMTP id 5741040615
 for <dev@dpdk.org>; Sat, 10 Oct 2026 02:59:58 +0200 (CEST)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2e2d4a8623bso2320915ad.1
 for <dev@dpdk.org>; Fri, 09 Oct 2026 17:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791593997; x=1792198797; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pugwP8Fp2sxFToCysrRoDRVWwEvBJsqhCdjw/z4Q3rI=;
 b=a3Tmc8HuVGPq6YQ/mCG1Azg+ebH1YybSCu2xMNHqhJ+33BuId1KDJK5hEh3NSE+D02
 rWloCh+q1wGjmpvZmJKFmTalIXKNbWeDUU7NF2iAAuvNCbj5iw69FJMz17uTSIfWTBaH
 DUKQ6yZaBiai+N6cXqshU2uovHfbNsVYUyhcpSn2iX9EonsCNV35kqNHvQ1YSRjSwEpu
 xv52cJFhBVAwTSC2oeRuXY/poBsksVHG/feOZTh69nNDcXm753WeucyoF8P3rAkHpq1y
 vEor9GqSHQmC6OGT/qBxsNpQICzbzgZBU8M5bjRQwF718dphVsJsEGH7dXok9Fo4y/cd
 mjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791593997; x=1792198797;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pugwP8Fp2sxFToCysrRoDRVWwEvBJsqhCdjw/z4Q3rI=;
 b=lkBjSzIyco8ha4fzJOxN07wjqUXz7mZ90vDL9vk4QwRvE5xwEwVDlUHpx9kPUdlV34
 ax9jb0tfQBVSU9Cpq17wMC82Ac1Ib5Gsd8McCvM44RL5FdUk4zZ9JCTCjJBqEtvslWYD
 YS3CSvC5hF5bDyb5Dovyxr7qvlxJ6Aqr1Umcp9iIiRjJEKkKVpOMqDReReJCqP3AeWrL
 klbVjA0TsjJYA8XGz19xFp5o6rOdI53bfzeUcHVVJzGYv2aoPGAoFG5JibakZqO4dhSF
 kJ/lMyRdsbk4pcH+q8A2UKe3kEAQnCIrGbzhsmMQ6a2oWKU8UZiUllLiIgYSIf5xjmfY
 /A8Q==
X-Gm-Message-State: AFq9FYJWbvZaWoQRAdTKNhaS5p7orExOzHKsTb8vinF7OkV2zxtgpeTO
 O5PBQvwF6BFvjDMLPVP3ZK0h08vlkCutwJ/2I3EqwRvpc7VCP/qs648bj28M4Ts4VrQWh1zzcZY
 /n6wZ+2VIZnM/pA==
X-Received: from plpp3.prod.google.com ([2002:a17:902:c703:b0:2e4:ba71:231a])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:8cc:b0:2e5:6e45:ef76 with SMTP id
 d9443c01a7336-2e8428a1ca1mr27106935ad.16.1791593997086; 
 Fri, 09 Oct 2026 17:59:57 -0700 (PDT)
Date: Fri,  9 Oct 2026 17:59:37 -0700
In-Reply-To: <20261010005942.560881-1-joshwash@google.com>
Mime-Version: 1.0
References: <20261005193943.1175072-1-joshwash@google.com>
 <20261010005942.560881-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.170.g584c36229d-goog
Message-ID: <20261010005942.560881-6-joshwash@google.com>
Subject: [PATCH v3 5/8] net/gve: clean Tx queue directly in dqo
From: Joshua Washington <joshwash@google.com>
To: Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org, blasko@google.com, jtranoleary@google.com
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

From: Mark Blasko <blasko@google.com>

Each Tx completion queue in DPDK is mapped 1:1 to its Tx queue. Remove
the compl_desc id lookup and txqs pointer array, and process descriptor
and packet completions directly on the calling Tx queue.

Signed-off-by: Mark Blasko <blasko@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/gve/gve_ethdev.h |  1 -
 drivers/net/gve/gve_tx_dqo.c | 14 +++++---------
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index fb894f0061..5d4797bfd6 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -193,7 +193,6 @@ struct gve_tx_queue {
 	uint16_t sw_size;
 	uint8_t cur_gen_bit;
 	uint32_t last_desc_cleaned;
-	void **txqs;
 	uint16_t re_cnt;
 
 	/* Only valid for DQO_RDA queue format */
diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index eb9b780920..901c6ca749 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -55,7 +55,6 @@ gve_tx_clean_dqo(struct gve_tx_queue *txq)
 {
 	struct gve_tx_compl_desc *compl_ring;
 	struct gve_tx_compl_desc *compl_desc;
-	struct gve_tx_queue *aim_txq;
 	struct gve_tx_pkt *pkt;
 	uint16_t new_tx_head;
 	uint16_t compl_tag;
@@ -70,15 +69,13 @@ gve_tx_clean_dqo(struct gve_tx_queue *txq)
 
 	rte_io_rmb();
 
-	aim_txq = txq->txqs[compl_desc->id];
-
 	switch (compl_desc->type) {
 	case GVE_COMPL_TYPE_DQO_DESC:
 		new_tx_head = rte_le_to_cpu_16(compl_desc->tx_head);
-		aim_txq->nb_free +=
-			(new_tx_head - aim_txq->last_desc_cleaned)
-				& (aim_txq->nb_tx_desc - 1);
-		aim_txq->last_desc_cleaned = new_tx_head;
+		txq->nb_free +=
+			(new_tx_head - txq->last_desc_cleaned)
+				& (txq->nb_tx_desc - 1);
+		txq->last_desc_cleaned = new_tx_head;
 		break;
 	case GVE_COMPL_TYPE_DQO_REINJECTION:
 		PMD_DRV_DP_LOG(DEBUG, "GVE_COMPL_TYPE_DQO_REINJECTION !!!");
@@ -93,7 +90,7 @@ gve_tx_clean_dqo(struct gve_tx_queue *txq)
 		}
 
 		/* Free packet.*/
-		pkt = &aim_txq->pkt_ring_dqo[compl_tag];
+		pkt = &txq->pkt_ring_dqo[compl_tag];
 		if (unlikely(!pkt->mbuf)) {
 			PMD_DRV_DP_LOG(ERR, "No outstanding packet for completion tag %d",
 				       compl_tag);
@@ -534,7 +531,6 @@ gve_tx_queue_setup_dqo(struct rte_eth_dev *dev, uint16_t queue_id,
 	txq->compl_ring = (struct gve_tx_compl_desc *)mz->addr;
 	txq->compl_ring_phys_addr = mz->iova;
 	txq->compl_ring_mz = mz;
-	txq->txqs = dev->data->tx_queues;
 
 	mz = rte_eth_dma_zone_reserve(dev, "txq_res", queue_id,
 				      sizeof(struct gve_queue_resources),
-- 
2.56.0.170.g584c36229d-goog

