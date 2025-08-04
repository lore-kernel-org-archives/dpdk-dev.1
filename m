Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DE7C87FCB
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 Aug 2025 20:50:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4272C406FF;
	Mon,  4 Aug 2025 22:50:29 +0200 (CEST)
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com
 [209.85.210.202])
 by mails.dpdk.org (Postfix) with ESMTP id 779E740653
 for <dev@dpdk.org>; Mon,  4 Aug 2025 22:50:27 +0200 (CEST)
Received: by mail-pf1-f202.google.com with SMTP id
 d2e1a72fcca58-76bf73032abso1908505b3a.1
 for <dev@dpdk.org>; Mon, 04 Aug 2025 13:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1754340626; x=1754945426; darn=dpdk.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=AdjSto8mmNGASJJwJRXSGy3RYRjJEwOaefhXfrREe9w=;
 b=Nuxj17LA0wTIIDpo6Fadoa1nDrn6JgLs5LuNUl1Mnco3zDVkysLKJxG4i0sAXUyKzO
 WpRDRVpIGV4xTPY/fAcpJfldgotZ9qMB43bY2kXP0cdbeeh8cEDCpLvSBw5mV/ftbBYe
 J9Qid075FPSb/iOE67eu3hwDzTHxpn/TIOjGsRtVszVHdUMMOCTJOVlqTbbtHS+l6HGw
 rdzBPBwbG5P0OFgO7rY9ufUUzpq6/sIQxO2Y0e0L82ZBwzzlBjCA7OI8Yww4/jVqYv+1
 b7CgDbUW60d/8RFO4BCexH9TbEv5KEexVRoJpnu3fQq0Gw2Xfh/nvkKGr/G/D/uwk/Uo
 pCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754340626; x=1754945426;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AdjSto8mmNGASJJwJRXSGy3RYRjJEwOaefhXfrREe9w=;
 b=xK2OSH2O7fmrANMo8Cwgk+PAux2No5LDkmGsos9FuJaSmIP0f7oASmly7g0gWK9DxA
 1KA+Uwy22Q8Vq+zsHI/MVJspkh8CsqfniavN3y6scP0lteb94q6cCa0qmCuWiGajSTF+
 fZAeHscpVWjShIHl83yd73O83fX2uYXeX6hR3NjG4E0sOBdTkPS4r4Vnh5fM94L/burE
 TvIZw71RN4pgp2harr4HG2b/GcIFxFCYuMnNJ46CduNJWqWP3qy6qCoIyCFEJj/3u7YT
 E9b5S86GzUg/1WC+jWx0PoO7FxlYM+hT/uBZYp4203YYkcdv5yXXVAl+bz6p96kYFazX
 sF2A==
X-Gm-Message-State: AOJu0Ywy7rPccGKqeCCw7jVw9tUZeAk9sA8UztBWuJxLyDzPyr92CLuB
 67lAEtYjVGOmbgR0ZlOq8ewRi7YAl4TgtjKj2SSYzMPkRDLdIoodPXpxcsTjHt3L63jTcTflivx
 bJ5IsPXuerXpX+g==
X-Google-Smtp-Source: AGHT+IEQWlYH9NME1xaowIZ9np9uNj1A7O61PxUuztE8nH4+c/8g6QzSQafze2BJgJFw/ubR2/l0uDFnlaSm0g==
X-Received: from pfsq6.prod.google.com ([2002:a05:6a00:2a6:b0:76b:eff0:e9b7])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2d21:b0:748:ff39:a0f7 with SMTP id
 d2e1a72fcca58-76bec340d67mr13682501b3a.9.1754340626435; 
 Mon, 04 Aug 2025 13:50:26 -0700 (PDT)
Date: Mon,  4 Aug 2025 13:50:24 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250804205024.873414-1-joshwash@google.com>
Subject: [PATCH] net/gve: properly disable interrupts on DQ
From: Joshua Washington <joshwash@google.com>
To: Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>, Junfeng Guo <junfengg@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org, 
 Praveen Kaligineedi <pkaligineedi@google.com>
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

When starting RX and TX queues in the DQ queue format, the driver was
erroneously writing GVE_IRQ_MASK to the IRQ doorbell. GQ and DQ have
different interrupt register layouts, so writing this bit is incorrect.
Update the register write to properly enable NO_INT_MODE for DQO.

Fixes: b044845bb015 ("net/gve: support queue start/stop")
Cc: stable@dpdk.org

Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
---
 drivers/net/gve/base/gve_desc_dqo.h | 4 ++++
 drivers/net/gve/gve_rx_dqo.c        | 4 +++-
 drivers/net/gve/gve_tx_dqo.c        | 4 +++-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/gve/base/gve_desc_dqo.h b/drivers/net/gve/base/gve_desc_dqo.h
index bb4a18d4d1..71d9d60bb9 100644
--- a/drivers/net/gve/base/gve_desc_dqo.h
+++ b/drivers/net/gve/base/gve_desc_dqo.h
@@ -248,4 +248,8 @@ GVE_CHECK_STRUCT_LEN(32, gve_rx_compl_desc_dqo);
  */
 #define GVE_RX_BUF_THRESH_DQO 32
 
+/* GVE IRQ */
+#define GVE_NO_INT_MODE_DQO BIT(30)
+#define GVE_ITR_NO_UPDATE_DQO (3 << 3)
+
 #endif /* _GVE_DESC_DQO_H_ */
diff --git a/drivers/net/gve/gve_rx_dqo.c b/drivers/net/gve/gve_rx_dqo.c
index 285c6ddd61..0103add985 100644
--- a/drivers/net/gve/gve_rx_dqo.c
+++ b/drivers/net/gve/gve_rx_dqo.c
@@ -415,7 +415,9 @@ gve_rx_queue_start_dqo(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 
 	rxq->qrx_tail = &hw->db_bar2[rte_be_to_cpu_32(rxq->qres->db_index)];
 
-	rte_write32(rte_cpu_to_be_32(GVE_IRQ_MASK), rxq->ntfy_addr);
+	rte_write32(rte_cpu_to_le_32(GVE_NO_INT_MODE_DQO |
+				     GVE_ITR_NO_UPDATE_DQO),
+		    rxq->ntfy_addr);
 
 	ret = gve_rxq_mbufs_alloc_dqo(rxq);
 	if (ret != 0) {
diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index 6984f92443..0a16b6a52d 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -415,7 +415,9 @@ gve_tx_queue_start_dqo(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 	txq->qtx_head =
 		&hw->cnt_array[rte_be_to_cpu_32(txq->qres->counter_index)];
 
-	rte_write32(rte_cpu_to_be_32(GVE_IRQ_MASK), txq->ntfy_addr);
+	rte_write32(rte_cpu_to_le_32(GVE_NO_INT_MODE_DQO |
+				     GVE_ITR_NO_UPDATE_DQO),
+		    txq->ntfy_addr);
 
 	dev->data->tx_queue_state[tx_queue_id] = RTE_ETH_QUEUE_STATE_STARTED;
 
-- 
2.50.1.565.gc32cd1483b-goog

