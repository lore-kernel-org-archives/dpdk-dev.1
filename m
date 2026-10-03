Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA02CA5FE3
	for <dpdk-dev@archiver.kernel.org>; Sat,  3 Oct 2026 02:52:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5148C42E7B;
	Sat,  3 Oct 2026 04:51:54 +0200 (CEST)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mails.dpdk.org (Postfix) with ESMTP id AEA5442EA1
 for <dev@dpdk.org>; Sat,  3 Oct 2026 04:51:52 +0200 (CEST)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2e2dc7312e5so1824495ad.1
 for <dev@dpdk.org>; Fri, 02 Oct 2026 19:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790995912; x=1791600712; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Kms8pReotyMGgFtivMmWT9lPWVXWPO84ewrFKWYiKFM=;
 b=WUkJJWPfMmtRzpXm7XTdw9Gla1SET+tb6OEf92wDPR8KNV72RS/L24f7op13cx/rkD
 PsxUQUlPqm6V93GCD3ija8OuEuMPbHJm/F1aNgoqF6lGThDDkvJxGEmybe75QwqUNPyX
 CsGssk84y1C2Rt7iWiOW/oca0IBpE4Dfoz4k3o/tY8dnBeKkCB/c8DtFi3qi4uM4JKEV
 t8AWNSpnoVJ14HxJ7MJx6FWaib18xJyclV7OkWQDIMwhdN7QdYq+hmrTQLkjgClcMqMO
 KnMjAaodQEnSWEyFN2IPWNkivhaVYegp5UuwmP4uxXzx9sZOr95h635gfmxRQCtMcORM
 FQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790995912; x=1791600712;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Kms8pReotyMGgFtivMmWT9lPWVXWPO84ewrFKWYiKFM=;
 b=FolHMPAYIFEjnxO414d1gySMHaJK606PHrT72uE1NV7YgbklJd/fVV0EYve6qLmHNN
 aQFjjqehV7RGpL7O1yvn5Xw3kN+AA2n5xyGZD2VVlL7cfEEr15JV30yZ0THEHVBEsIb1
 kYuWruoQclaqTg68vbJ16NCHNtubkV1tesWGQX6CuQAWv/ilpgTBrGkAXAgb9OTcfvfW
 JD2hWRXTeUhqi6P/fc/hvXGQExnGGSq10m9qjSx9/WV0oQltC3XqPBYVDavsDHOND5ST
 ylQYMP3+hoO5agQzjueXtcrLG5NT4kpxlmZPpYp5yqvFs8XrTTBsVrveLgw2lxVhOiR0
 o7xQ==
X-Gm-Message-State: AFq9FYK5PTUK9VD5ZpdwzwKcFTYSrjfQzGt5brMW3M6keN45osmYxaXe
 TboypCpqLhjeuwFVIJjbdn0GDw6tbQzHQorsJCRkidIAtS3rvMpz9msDwQHUqPEOUfDS9BZT+15
 cCATQPmxig+Gq9A==
X-Received: from plek8.prod.google.com ([2002:a17:903:4508:b0:2e4:a869:a39d])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2b06:b0:2e1:35f0:6837 with SMTP id
 d9443c01a7336-2e51053b9c6mr11102075ad.50.1790995911235; 
 Fri, 02 Oct 2026 19:51:51 -0700 (PDT)
Date: Fri,  2 Oct 2026 19:51:36 -0700
In-Reply-To: <20261003025142.1930363-1-joshwash@google.com>
Mime-Version: 1.0
References: <20261003025142.1930363-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261003025142.1930363-5-joshwash@google.com>
Subject: [PATCH 4/8] net/gve: clean Tx queue directly in dqo
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

