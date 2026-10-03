Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04755CA5FE3
	for <dpdk-dev@archiver.kernel.org>; Sat,  3 Oct 2026 02:52:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 142D742D9D;
	Sat,  3 Oct 2026 04:51:51 +0200 (CEST)
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mails.dpdk.org (Postfix) with ESMTP id B96AE40299
 for <dev@dpdk.org>; Sat,  3 Oct 2026 04:51:48 +0200 (CEST)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-88679c4f94cso35996b3a.0
 for <dev@dpdk.org>; Fri, 02 Oct 2026 19:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790995908; x=1791600708; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FsnnzctVtmxamaH9qFhxEQCIimoWK6J5FkbHv30fMdw=;
 b=McaXomZyV6qFYqj2dk5ih2x/LPo718k68wCCSQhaziFo8PweSBdrVW6+0p4GUMg3zM
 7zGpzmEMXGAnp3FKV08cZ/1WLw7FQA7/K90s8jhSCgAYoAd8XGbc58S9iqkFTlXXeSae
 VAlE0shaEGf1YA5VrBxtMy4NXnsIRK6uOQ0dMHRf1LBpWxS0dE0JWCOdsJvHc49B+0Ma
 bBBZo3CHHIS/3pSBLAK8jYq9FSSWj7dSTGnnoK1w03+PyWTyriMIvT+8cCenjHAJoXxE
 gZdZPM2+UGC7aI5PwKKeNaHLSIHfvLLd0myP2f1bywdARLD3jLeftNdYeIzrM2rZ7kHE
 6z5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790995908; x=1791600708;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FsnnzctVtmxamaH9qFhxEQCIimoWK6J5FkbHv30fMdw=;
 b=MtDeOF8YsfgMs9Ufiv1dyGbGQI/FnvU6iiyG7DlfaXQMbl4MrJbJfQF1VpZhvkgRDx
 RvX9/NatcYGVBDG3PVcB2ubRM9l3FExYHRzNhdMiH9+70MuQbqWQJQWj+0My4L6z8olU
 iP1BGp8x/HJMv8Z2ZqGqrdy4rxbtjfZFFJFkIGckKhDzbDKZVkvc2jbtcBVAYKfnEThE
 MlAVRkdFOs2nIkwzxTC8ZMbZe0IDQJnZrwi3Oc+ryeaCt4LN6HrhUd34ccl0mxZf9rje
 oppSLvFxeA4mYhpk6hXqI27PDWLYcHyCGoinVLYIsWi9lWOiWUx59pDBD/skUhz22i0Y
 AEKw==
X-Gm-Message-State: AFuF++ljMTWl6XXLkd93dDilNl3g1K9F0rFExnhMMD7/ldek0U9rMooD
 dxPRHp1rQxwBvl1DlRNzNucbk+fJu2gSSRooHDMi7K88DZqdrvPRXd6ptsPfUfrCkfBaZsr/yDa
 iiXEtr04mcZKDQA==
X-Received: from pfbdn21.prod.google.com
 ([2002:a05:6a00:4995:b0:882:f0bf:4ab1])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3e03:b0:878:34d7:6994 with SMTP id
 d2e1a72fcca58-88af5118571mr4435031b3a.36.1790995907447; 
 Fri, 02 Oct 2026 19:51:47 -0700 (PDT)
Date: Fri,  2 Oct 2026 19:51:34 -0700
In-Reply-To: <20261003025142.1930363-1-joshwash@google.com>
Mime-Version: 1.0
References: <20261003025142.1930363-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261003025142.1930363-3-joshwash@google.com>
Subject: [PATCH 2/8] net/gve: rename doorbell BAR variable to be more generic
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

