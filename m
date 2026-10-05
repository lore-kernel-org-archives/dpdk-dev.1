Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA39CA5FFC
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 19:40:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE4FE40E17;
	Mon,  5 Oct 2026 21:40:09 +0200 (CEST)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mails.dpdk.org (Postfix) with ESMTP id AF23C40E0B
 for <dev@dpdk.org>; Mon,  5 Oct 2026 21:40:08 +0200 (CEST)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2df375fb9b2so21090985ad.2
 for <dev@dpdk.org>; Mon, 05 Oct 2026 12:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791229208; x=1791834008; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Kms8pReotyMGgFtivMmWT9lPWVXWPO84ewrFKWYiKFM=;
 b=G+/Lop8Wkygs8vhLikJ6k5XoFg62OWK3jwadQ7TeUfgFYnReIMRgXgLPMm0nm6ZW4W
 0q2Yux69OfsUQFj26wMDZ6Oi75aTIo7rf5bvfgMxrWFu5mexWS827lGh3pT83bXeQq9y
 YttfpYCLT1AZsEtnk3hbLCK3BXRcrg1xatnL+fcdZVSDkSO+7c4Qi12SOSwyyMqfsm8i
 3vNZdlfNxRdqJpImG4ZBBHOeTLW2dvU7DmJHWZsQT0Y+OLZvgV9UrxiyhVw1R5UvXH5Q
 9JHJSmuq0X8h85PVPvOlDdnvqLacgio5d5YK8I2lZY33DY6mpt8YOF8XjqJBveer3x9V
 bOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791229208; x=1791834008;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Kms8pReotyMGgFtivMmWT9lPWVXWPO84ewrFKWYiKFM=;
 b=w4KwINZBP9u1w6vA35xatEgE9T4rIiPk4exHCC225jV0Pzm2W75YC/Rjnw44vIjeDX
 6slsiDi5o2sD7hJY/Ux0aDICnlXcNJzNcohE9hbwOB05wz4bzjoP4Gy2c5aYODswwFMa
 PbYzGl2a0Sz1E/4ZYeRT4KGWzALDk3cft2IMMmL/JxWkWuqgLm+p3xwaIIGvN1SzwgcQ
 kXAcQf9CNVlkP9uBZz9UIDo8hI68aDx5vzWrN49BxoQ9BOWViMbdk9mgaic8Ni6Q1cB1
 aKfkMhbG9P2X3hkLDAwTt4c79GFZ3zP5GtVzSbq+9DFITSCc/HEmcfHd1Eh1jjwt7bCu
 6ZlA==
X-Gm-Message-State: AFq9FYJ1xyVCTy1d4ZOsYHnWLiM972x1H47fqYDpHw6IoVKsHmdDz6ew
 yJWm1d/NNngKVrbtKIy7VSPAbbVkdUAudSVPbhh9lwq4WMIHu+RLFCfs9BBMeQp7PcjstDVhXdv
 1UEGnGzzaqsUGNw==
X-Received: from plhk15.prod.google.com ([2002:a17:902:d58f:b0:2e2:e23b:36c2])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d4c5:b0:2df:90d4:1188 with SMTP id
 d9443c01a7336-2e499f095e2mr108567985ad.7.1791229207484; 
 Mon, 05 Oct 2026 12:40:07 -0700 (PDT)
Date: Mon,  5 Oct 2026 12:39:35 -0700
In-Reply-To: <20261005193943.1175072-1-joshwash@google.com>
Mime-Version: 1.0
References: <20261003025142.1930363-1-joshwash@google.com>
 <20261005193943.1175072-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261005193943.1175072-5-joshwash@google.com>
Subject: [PATCH v2 4/8] net/gve: clean Tx queue directly in dqo
From: Joshua Washington <joshwash@google.com>
To: Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org, Mark Blasko <blasko@google.com>
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
index 1a0ac87ed8..9d8939da33 100644
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
index fe8b883208..7dbe8db39d 100644
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
2.56.0.rc1.315.gc6ed9934b7-goog

