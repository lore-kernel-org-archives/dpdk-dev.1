Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBBCC54E65
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 May 2025 13:27:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F1E4C40669;
	Thu, 22 May 2025 15:27:23 +0200 (CEST)
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
 by mails.dpdk.org (Postfix) with ESMTP id 968FE40663
 for <dev@dpdk.org>; Thu, 22 May 2025 15:27:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1747920443; x=1779456443;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=xGA8VQ9blNr6HSjXXavyFK9u4VCFE4JFhYNcKE+EvWA=;
 b=WLV2jAyEQMG7/BvdXXsF2DqbtF//LizyngCppAKCSZgshWjiSUKy6MRW
 sw9FEj58Clz71W3KhPUG27Qb+L2H0NtAtXXfH3ciDOQJlo9PeMj+nWcTo
 /1rrvpAbPG5FONKjyi7Aung9zk27byPF7dzZdMUOoG73Ojd+3Cf9/hXjI
 vOCS59VLco7SU1q4GGnoq/6QAoHk14mDd8naX4RQ2oJmKlQfKIMPxD7uy
 D3izc/H4icZE/WXf0MqKt10d8DAwghtO5I01Y3KCCzq5wCRzJiwBR8FLt
 MzMbhm+F4Tbfobo7SAvPC1BSmUliSjRd1Fs9SGMIjotuM4NSqU/gi48U9 A==;
X-IronPort-AV: E=Sophos;i="6.15,306,1739836800"; d="scan'208";a="493044005"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO
 smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
 by smtp-border-fw-6001.iad6.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 13:27:20 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.43.254:4187]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.22.206:2525]
 with esmtp (Farcaster)
 id e2524250-6b9c-496a-ad39-4e6ce057b2e7; Thu, 22 May 2025 13:27:19 +0000 (UTC)
X-Farcaster-Flow-ID: e2524250-6b9c-496a-ad39-4e6ce057b2e7
Received: from EX19D007EUA002.ant.amazon.com (10.252.50.68) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 13:27:19 +0000
Received: from HFA15-CG15235BS.amazon.com (10.106.83.24) by
 EX19D007EUA002.ant.amazon.com (10.252.50.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 13:27:17 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH v3 3/7] net/ena: separate doorbell logic for Rx and Tx
Date: Thu, 22 May 2025 16:26:10 +0300
Message-ID: <20250522132614.3379-4-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250522132614.3379-1-shaibran@amazon.com>
References: <20250522132614.3379-1-shaibran@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.106.83.24]
X-ClientProxiedBy: EX19D041UWB004.ant.amazon.com (10.13.139.143) To
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

