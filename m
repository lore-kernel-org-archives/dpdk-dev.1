Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A20CCA601E
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 01:00:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 545804065A;
	Sat, 10 Oct 2026 02:59:53 +0200 (CEST)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mails.dpdk.org (Postfix) with ESMTP id 4F5AB40656
 for <dev@dpdk.org>; Sat, 10 Oct 2026 02:59:52 +0200 (CEST)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2e60bb65626so2534825ad.0
 for <dev@dpdk.org>; Fri, 09 Oct 2026 17:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791593991; x=1792198791; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=67ge9In6SMOkSfBK5kgHay0tVXQdJaKNBNmkuiA3tWA=;
 b=uorq6R2jl8R39pwi1p5R3rilPOkoJ+LbDu59MLp6zkutByIqAKD/WZ+DSyGlLltHhv
 Qt6zpHj8vgErOPhbohj4Zpr7NlALsa5j6b36R1vXF/Py4C8vi2pX3DI2nUTJ1XhI/kdy
 33AsnkPu43cPY3s3fKZCHjn4Ja3er7x/qpwyjt4vUnfc9SPPklqocsDm328gtYwPzXOb
 Wrua5Q00orCv6nF1MXoyqjFycnor1C3LdHTob0X0vz2LM31kUSXq1EA1ZdX2bjXGBF+C
 wNQmFUtgbCv5DILpxwqFK04jtTSzueMd6lbI0qAJKxx8O+1eKhNZHhyXFotmw3O9rc8J
 IYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791593991; x=1792198791;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=67ge9In6SMOkSfBK5kgHay0tVXQdJaKNBNmkuiA3tWA=;
 b=zY+azWVPkm+0Ao3m/a0whMEKQ69tbUbLckqyIxvlZxM1kLbI0BMEpanmf0qaknLu50
 5hLMkQ8OWkywSe7/SlAi1QihF8aBi1SlqwCT13ClAt9DLr78pxmPmp71rJbk2HgAvEI1
 Fx/XhTsBDKXwpTbQrghpQKlei5N+uCbh4UDZ5wEuOkiu00k73xEFOqTR4ZCCuHXxxb5d
 Tt0gEZXfmCbsbrVhCHgoB/wcP8iSmJ+7EH6FytuSkeDH2P4vKRlasKXKcL2raiIti+La
 /m7rzYzyDieTrTKLnCgHny0iTtXP4fvLXxsRnK2u4id/JwKBcOdTxbnzzHScXUxyrn99
 8yuw==
X-Gm-Message-State: AFq9FYKkrecEZ20nK6X/rwTXK7F2Y3aCP/v2GfHNQJQAu45kJE8UnfcU
 sQadlDEGcL70bnU2u5qF/ot6VXepouUR1yHQOyy2tgHVJAdr7dQcqyqwTlqzqYYocisMejheEP6
 NuGiSjGbMFSrJfA==
X-Received: from plkb5.prod.google.com ([2002:a17:903:fa5:b0:2e6:13a2:7648])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d4d1:b0:2e4:905f:5a3a with SMTP id
 d9443c01a7336-2e8428359eamr22354895ad.2.1791593991178; 
 Fri, 09 Oct 2026 17:59:51 -0700 (PDT)
Date: Fri,  9 Oct 2026 17:59:35 -0700
In-Reply-To: <20261010005942.560881-1-joshwash@google.com>
Mime-Version: 1.0
References: <20261005193943.1175072-1-joshwash@google.com>
 <20261010005942.560881-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.170.g584c36229d-goog
Message-ID: <20261010005942.560881-4-joshwash@google.com>
Subject: [PATCH v3 3/8] net/gve: rename doorbell BAR variable to be more
 generic
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

Rename db_bar2 to db_bar in struct gve_priv and update queue doorbell
references across the driver. The doorbells will be in BAR 0 in GVE
Mailbox mode.

Signed-off-by: Mark Blasko <blasko@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/gve/gve_ethdev.c | 2 +-
 drivers/net/gve/gve_ethdev.h | 2 +-
 drivers/net/gve/gve_rx.c     | 4 ++--
 drivers/net/gve/gve_rx_dqo.c | 4 ++--
 drivers/net/gve/gve_tx.c     | 4 ++--
 drivers/net/gve/gve_tx_dqo.c | 4 ++--
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index ecf4247c19..30ceeeabd0 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -1759,7 +1759,7 @@ gve_dev_init(struct rte_eth_dev *eth_dev)
 	gve_write_version(&reg_bar->driver_version);
 
 	priv->reg_bar0 = reg_bar;
-	priv->db_bar2 = db_bar;
+	priv->db_bar = db_bar;
 	priv->pci_dev = pci_dev;
 	priv->port_id = eth_dev->data->port_id;
 	priv->state_flags = 0x0;
diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index 7dbc1753a5..10572a754e 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -348,7 +348,7 @@ struct gve_priv {
 	uint32_t num_ntfy_blks; /* spilt between TX and RX so must be even */
 
 	struct gve_registers __iomem *reg_bar0; /* see gve_register.h */
-	rte_be32_t __iomem *db_bar2; /* "array" of doorbells */
+	rte_be32_t __iomem *db_bar; /* "array" of doorbells */
 	struct rte_pci_device *pci_dev;
 	uint16_t port_id;
 
diff --git a/drivers/net/gve/gve_rx.c b/drivers/net/gve/gve_rx.c
index 472d8406ba..09f9d8d480 100644
--- a/drivers/net/gve/gve_rx.c
+++ b/drivers/net/gve/gve_rx.c
@@ -349,7 +349,7 @@ gve_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id,
 	rxq->is_gqi_qpl = hw->queue_format == GVE_GQI_QPL_FORMAT;
 	rxq->mpool = pool;
 	rxq->hw = hw;
-	rxq->ntfy_addr = &hw->db_bar2[rte_be_to_cpu_32(hw->irq_dbs[rxq->ntfy_id].id)];
+	rxq->ntfy_addr = &hw->db_bar[rte_be_to_cpu_32(hw->irq_dbs[rxq->ntfy_id].id)];
 
 	mbuf_len =
 		rte_pktmbuf_data_room_size(rxq->mpool) - RTE_PKTMBUF_HEADROOM;
@@ -483,7 +483,7 @@ gve_rx_queue_start(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 
 	rxq = dev->data->rx_queues[rx_queue_id];
 
-	rxq->qrx_tail = &hw->db_bar2[rte_be_to_cpu_32(rxq->qres->db_index)];
+	rxq->qrx_tail = &hw->db_bar[rte_be_to_cpu_32(rxq->qres->db_index)];
 
 	rte_write32(rte_cpu_to_be_32(GVE_IRQ_MASK), rxq->ntfy_addr);
 
diff --git a/drivers/net/gve/gve_rx_dqo.c b/drivers/net/gve/gve_rx_dqo.c
index 1f901c5fd4..03c62edee6 100644
--- a/drivers/net/gve/gve_rx_dqo.c
+++ b/drivers/net/gve/gve_rx_dqo.c
@@ -370,7 +370,7 @@ gve_rx_queue_setup_dqo(struct rte_eth_dev *dev, uint16_t queue_id,
 
 	rxq->mpool = pool;
 	rxq->hw = hw;
-	rxq->ntfy_addr = &hw->db_bar2[rte_be_to_cpu_32(hw->irq_dbs[rxq->ntfy_id].id)];
+	rxq->ntfy_addr = &hw->db_bar[rte_be_to_cpu_32(hw->irq_dbs[rxq->ntfy_id].id)];
 
 	mbuf_len =
 		rte_pktmbuf_data_room_size(rxq->mpool) - RTE_PKTMBUF_HEADROOM;
@@ -519,7 +519,7 @@ gve_rx_queue_start_dqo(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 
 	rxq = dev->data->rx_queues[rx_queue_id];
 
-	rxq->qrx_tail = &hw->db_bar2[rte_be_to_cpu_32(rxq->qres->db_index)];
+	rxq->qrx_tail = &hw->db_bar[rte_be_to_cpu_32(rxq->qres->db_index)];
 
 	rte_write32(rte_cpu_to_le_32(GVE_NO_INT_MODE_DQO |
 				     GVE_ITR_NO_UPDATE_DQO),
diff --git a/drivers/net/gve/gve_tx.c b/drivers/net/gve/gve_tx.c
index 568e948daa..279669165f 100644
--- a/drivers/net/gve/gve_tx.c
+++ b/drivers/net/gve/gve_tx.c
@@ -606,7 +606,7 @@ gve_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id, uint16_t nb_desc,
 	txq->ntfy_id = queue_id;
 	txq->is_gqi_qpl = hw->queue_format == GVE_GQI_QPL_FORMAT;
 	txq->hw = hw;
-	txq->ntfy_addr = &hw->db_bar2[rte_be_to_cpu_32(hw->irq_dbs[txq->ntfy_id].id)];
+	txq->ntfy_addr = &hw->db_bar[rte_be_to_cpu_32(hw->irq_dbs[txq->ntfy_id].id)];
 
 	/* Allocate software ring */
 	txq->sw_ring = rte_zmalloc_socket("gve tx sw ring",
@@ -694,7 +694,7 @@ gve_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 
 	txq = dev->data->tx_queues[tx_queue_id];
 
-	txq->qtx_tail = &hw->db_bar2[rte_be_to_cpu_32(txq->qres->db_index)];
+	txq->qtx_tail = &hw->db_bar[rte_be_to_cpu_32(txq->qres->db_index)];
 	txq->qtx_head =
 		&hw->cnt_array[rte_be_to_cpu_32(txq->qres->counter_index)];
 
diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index 0b4d6074ab..eb9b780920 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -495,7 +495,7 @@ gve_tx_queue_setup_dqo(struct rte_eth_dev *dev, uint16_t queue_id,
 	txq->port_id = dev->data->port_id;
 	txq->ntfy_id = queue_id;
 	txq->hw = hw;
-	txq->ntfy_addr = &hw->db_bar2[rte_be_to_cpu_32(hw->irq_dbs[txq->ntfy_id].id)];
+	txq->ntfy_addr = &hw->db_bar[rte_be_to_cpu_32(hw->irq_dbs[txq->ntfy_id].id)];
 
 	/* Allocate software ring */
 	sw_size = nb_desc;
@@ -575,7 +575,7 @@ gve_tx_queue_start_dqo(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 
 	txq = dev->data->tx_queues[tx_queue_id];
 
-	txq->qtx_tail = &hw->db_bar2[rte_be_to_cpu_32(txq->qres->db_index)];
+	txq->qtx_tail = &hw->db_bar[rte_be_to_cpu_32(txq->qres->db_index)];
 	txq->qtx_head =
 		&hw->cnt_array[rte_be_to_cpu_32(txq->qres->counter_index)];
 
-- 
2.56.0.170.g584c36229d-goog

