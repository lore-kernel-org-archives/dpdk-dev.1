Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0280EC7EE39
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 11:14:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9C5740656;
	Mon, 30 Jun 2025 13:14:40 +0200 (CEST)
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
 by mails.dpdk.org (Postfix) with ESMTP id 8F10440656
 for <dev@dpdk.org>; Mon, 30 Jun 2025 13:14:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1751282080; x=1782818080;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=xGA8VQ9blNr6HSjXXavyFK9u4VCFE4JFhYNcKE+EvWA=;
 b=iHLrBAh07ClJQiUEn0IdEY8fDQ31UqBUSFj5lfPrMiRuSkASBDGivmGT
 /b35WrqDMDGAqG2o5VvQMThw0tIQwly7m16DBKxhGL3d8bIBg/tRrPRiL
 G/vqLYUP8E9mCrQslny9eBK+h9XFKLkl8irvLx7bJuAZHJA61kAfKFlWx
 SMBkfDXLM+yWxoIh2YyApigNt6n1+CuYv5cR/lUTYsegDi9MBdVT9iCnd
 hNBEopJkQRSsO73A2JNY0hAAL6srue3V+SyPosoztJVwWxgPDJ+mT8n9x
 CUeoEeoGVj5bFr/oGO1LjL967d6Urtwe8N93H9qN7aFQ7icGYmJdYLM/8 Q==;
X-IronPort-AV: E=Sophos;i="6.16,277,1744070400"; d="scan'208";a="514298125"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
 by smtp-border-fw-6002.iad6.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 11:14:38 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.43.254:6986]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.9.108:2525]
 with esmtp (Farcaster)
 id b7e2a0c3-1a8e-45c7-a27b-4cfa18e64774; Mon, 30 Jun 2025 11:14:36 +0000 (UTC)
X-Farcaster-Flow-ID: b7e2a0c3-1a8e-45c7-a27b-4cfa18e64774
Received: from EX19D007EUA002.ant.amazon.com (10.252.50.68) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 30 Jun 2025 11:14:36 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.9) by
 EX19D007EUA002.ant.amazon.com (10.252.50.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 30 Jun 2025 11:14:34 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH 3/7] net/ena: separate doorbell logic for Rx and Tx
Date: Mon, 30 Jun 2025 14:13:54 +0300
Message-ID: <20250630111358.3476-4-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250630111358.3476-1-shaibran@amazon.com>
References: <20250630111358.3476-1-shaibran@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.213.9]
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
 EX19D007EUA002.ant.amazon.com (10.252.50.68)
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

The function ena_com_write_sq_doorbell() currently
checks for LLQ mode using is_llq_max_tx_burst_exists()
which is relevant only for TX queues.
Since RX queues do not operate in LLQ mode, this check
is unnecessary for the RX path.

This patch separates the doorbell write logic into two
distinct handlers for RX and TX, eliminating the
irrelevant LLQ check in the RX path.

Signed-off-by: Shai Brandes <shaibran@amazon.com>
Reviewed-by: Amit Bernstein <amitbern@amazon.com>
Reviewed-by: Yosef Raisman <yraisman@amazon.com>
---
 drivers/net/ena/base/ena_eth_com.h | 15 ++++++++++++++-
 drivers/net/ena/ena_ethdev.c       |  6 +++---
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ena/base/ena_eth_com.h b/drivers/net/ena/base/ena_eth_com.h
index 8a12ed5fba..9e0a7af325 100644
--- a/drivers/net/ena/base/ena_eth_com.h
+++ b/drivers/net/ena/base/ena_eth_com.h
@@ -159,7 +159,20 @@ static inline bool ena_com_is_doorbell_needed(struct ena_com_io_sq *io_sq,
 	return num_entries_needed > io_sq->entries_in_tx_burst_left;
 }
 
-static inline int ena_com_write_sq_doorbell(struct ena_com_io_sq *io_sq)
+static inline int ena_com_write_rx_sq_doorbell(struct ena_com_io_sq *io_sq)
+{
+	u16 tail = io_sq->tail;
+
+	ena_trc_dbg(ena_com_io_sq_to_ena_dev(io_sq),
+		    "Write submission queue doorbell for queue: %d tail: %d\n",
+		    io_sq->qid, tail);
+
+	ENA_REG_WRITE32(io_sq->bus, tail, io_sq->db_addr);
+
+	return 0;
+}
+
+static inline int ena_com_write_tx_sq_doorbell(struct ena_com_io_sq *io_sq)
 {
 	u16 max_entries_in_tx_burst = io_sq->llq_info.max_entries_in_tx_burst;
 	u16 tail = io_sq->tail;
diff --git a/drivers/net/ena/ena_ethdev.c b/drivers/net/ena/ena_ethdev.c
index a13506890f..d8ff6851d2 100644
--- a/drivers/net/ena/ena_ethdev.c
+++ b/drivers/net/ena/ena_ethdev.c
@@ -1835,7 +1835,7 @@ static int ena_populate_rx_queue(struct ena_ring *rxq, unsigned int count)
 	/* When we submitted free resources to device... */
 	if (likely(i > 0)) {
 		/* ...let HW know that it can fill buffers with data. */
-		ena_com_write_sq_doorbell(rxq->ena_com_io_sq);
+		ena_com_write_rx_sq_doorbell(rxq->ena_com_io_sq);
 
 		rxq->next_to_use = next_to_use;
 	}
@@ -3163,7 +3163,7 @@ static int ena_xmit_mbuf(struct ena_ring *tx_ring, struct rte_mbuf *mbuf)
 		PMD_TX_LOG_LINE(DEBUG,
 			"LLQ Tx max burst size of queue %d achieved, writing doorbell to send burst",
 			tx_ring->id);
-		ena_com_write_sq_doorbell(tx_ring->ena_com_io_sq);
+		ena_com_write_tx_sq_doorbell(tx_ring->ena_com_io_sq);
 		tx_ring->tx_stats.doorbells++;
 		tx_ring->pkts_without_db = false;
 	}
@@ -3296,7 +3296,7 @@ static uint16_t eth_ena_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 	/* If there are ready packets to be xmitted... */
 	if (likely(tx_ring->pkts_without_db)) {
 		/* ...let HW do its best :-) */
-		ena_com_write_sq_doorbell(tx_ring->ena_com_io_sq);
+		ena_com_write_tx_sq_doorbell(tx_ring->ena_com_io_sq);
 		tx_ring->tx_stats.doorbells++;
 		tx_ring->pkts_without_db = false;
 	}
-- 
2.17.1

