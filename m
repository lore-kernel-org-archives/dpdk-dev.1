Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A946CA5FFC
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 19:40:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4428F402DD;
	Mon,  5 Oct 2026 21:40:06 +0200 (CEST)
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mails.dpdk.org (Postfix) with ESMTP id E5BBC402DD
 for <dev@dpdk.org>; Mon,  5 Oct 2026 21:40:04 +0200 (CEST)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc1b80835d5so1172146a12.2
 for <dev@dpdk.org>; Mon, 05 Oct 2026 12:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791229204; x=1791834004; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FsnnzctVtmxamaH9qFhxEQCIimoWK6J5FkbHv30fMdw=;
 b=O9I77AnMFB+xBJfW5ksAr4j10BTtN4jIxknu1HcQY/NU62TV/CCkXir0eHwymP0FxG
 oOjecu14SjU01lSoLnrcCrVz0tLYVYZVT6zxcjpireIoUDpLcRs39SDZ1ZGTToGPOg5P
 VY6xjGQaNEmKX/tulVvOYUO+kqoRRczzaSsCD8X0o1Al/ym/DETlyJdMOvneSKJnbo1s
 PS95ikd+zvnQQjAwbpjaeIx7QvSCt1oXlOtxd00Wuhd0NRNuqzwdYNQrXdlBXbcMEnRW
 HKdQte581CrSBxeSVFzkYWqASc1WsSIQI12BzF+xlxK75JYcqvRASE9T2/Tes3WWNqrl
 wZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791229204; x=1791834004;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FsnnzctVtmxamaH9qFhxEQCIimoWK6J5FkbHv30fMdw=;
 b=HmBfpmETk10rxIcwH1XuxX+WlnKb9HSxkvzcqZvAY7inCthiGgBHBLRxJ+yb3Bus70
 T8dP8/7/zOdZ4zta7QegKEN/q5CRFHfsn1X4BdebDYYuEE0jOQNkkPOShyVpWvy+hS2r
 hqOKAhN/XWa9FtbChvULjEjyosfs6PDmWBKUnseUGvIIibeIXhL5Ju3/C/7bfNzJt4ZI
 5caK3TCf88FA89+QvlUGoakwLMm8qq33xsukd2WkfRo1PRbGEynBSpFBwFy6QiGTH/t2
 3ZRz99LKp7YugnSNZjSxypbLv/rFcoZucYUCMjsjj9mIK6syxkoF/XL1pd6Uq66nmnHH
 sBrA==
X-Gm-Message-State: AFuF++n7HILU+fh8B54bcxtXlG88Z58pFBbgO43WJNWNKyiZrwaSA8Sa
 L5aBEdXxuq8H76P1ppmVBJg8YuWpQ5U2O9FqcfFZCUIzp5EZHGwK2bjsVkijcTC+LUu9qimKzyq
 rJl53oG1yqSb+tw==
X-Received: from pgbfe13.prod.google.com
 ([2002:a05:6a02:288d:b0:cc7:d8ea:a7bc])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6300:2786:20b0:3e0:c961:b5b1 with SMTP id
 adf61e73a8af0-3e0c961be79mr6356937637.45.1791229203513; 
 Mon, 05 Oct 2026 12:40:03 -0700 (PDT)
Date: Mon,  5 Oct 2026 12:39:33 -0700
In-Reply-To: <20261005193943.1175072-1-joshwash@google.com>
Mime-Version: 1.0
References: <20261003025142.1930363-1-joshwash@google.com>
 <20261005193943.1175072-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261005193943.1175072-3-joshwash@google.com>
Subject: [PATCH v2 2/8] net/gve: rename doorbell BAR variable to be more
 generic
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
index 6704cc40b3..9cfdd03b9d 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -1717,7 +1717,7 @@ gve_dev_init(struct rte_eth_dev *eth_dev)
 	gve_write_version(&reg_bar->driver_version);
 
 	priv->reg_bar0 = reg_bar;
-	priv->db_bar2 = db_bar;
+	priv->db_bar = db_bar;
 	priv->pci_dev = pci_dev;
 	priv->state_flags = 0x0;
 
diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index f57e81dbc9..ef54b75c32 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -353,7 +353,7 @@ struct gve_priv {
 	uint32_t num_ntfy_blks; /* spilt between TX and RX so must be even */
 
 	struct gve_registers __iomem *reg_bar0; /* see gve_register.h */
-	rte_be32_t __iomem *db_bar2; /* "array" of doorbells */
+	rte_be32_t __iomem *db_bar; /* "array" of doorbells */
 	struct rte_pci_device *pci_dev;
 
 	/* Admin queue - see gve_adminq.h*/
diff --git a/drivers/net/gve/gve_rx.c b/drivers/net/gve/gve_rx.c
index 2f542c7a66..ac2d174c67 100644
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
index 81d7cacaf6..1fbe875954 100644
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
index 333e82b141..6398191b0a 100644
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
index a44a20b139..fe8b883208 100644
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
2.56.0.rc1.315.gc6ed9934b7-goog

