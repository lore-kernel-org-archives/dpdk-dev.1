Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721B4C54E71
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 14:02:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A089542D3F;
	Wed, 21 May 2025 16:02:46 +0200 (CEST)
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com
 [99.78.197.217]) by mails.dpdk.org (Postfix) with ESMTP id 8AE9E42830
 for <dev@dpdk.org>; Wed, 21 May 2025 16:02:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1747836163; x=1779372163;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=xGA8VQ9blNr6HSjXXavyFK9u4VCFE4JFhYNcKE+EvWA=;
 b=M24i7tb80+c59S9enSH3gLcjRAiKaUJigebVZpKHBAiOvisBiojtU+WC
 rEj0+Pa13rL1U+LFhtp18fKoulXwKTMFoxpYvPVXgApWAPWCG/1pELDxG
 gibDyFq6w33k9808/vS1ifOZpQwa8VoQSG+mENfuMQD8OQOZZxEofu5/m
 ylFi9L3DdBVs9X8d5gV1qcM4MJ0E1MCifyA2dPpQoJAVrWs9m/7lm+Vfa
 PRmIQgIu8IKdhWBZhgvAp0o1uKnFAupWMbXkbsI3wwugFyeoexzFFcZ0G
 ktZhHg7xb696vwThee/WoorTOfRo+uw9LaUuIkcrVgmoNUXWeY7NniUNV Q==;
X-IronPort-AV: E=Sophos;i="6.15,303,1739836800"; d="scan'208";a="52422250"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
 by smtp-border-fw-80006.pdx80.corp.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 14:02:43 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.43.254:25835]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.39.182:2525]
 with esmtp (Farcaster)
 id 4e1eb7db-f220-4705-915f-8722593f7a62; Wed, 21 May 2025 14:02:42 +0000 (UTC)
X-Farcaster-Flow-ID: 4e1eb7db-f220-4705-915f-8722593f7a62
Received: from EX19D007EUA002.ant.amazon.com (10.252.50.68) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 14:02:41 +0000
Received: from HFA15-CG15235BS.amazon.com (10.106.83.30) by
 EX19D007EUA002.ant.amazon.com (10.252.50.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 14:02:39 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH 3/8] net/ena: separate doorbell logic for Rx and Tx
Date: Wed, 21 May 2025 17:02:08 +0300
Message-ID: <20250521140213.2576-4-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250521140213.2576-1-shaibran@amazon.com>
References: <20250521140213.2576-1-shaibran@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.106.83.30]
X-ClientProxiedBy: EX19D042UWA003.ant.amazon.com (10.13.139.44) To
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

