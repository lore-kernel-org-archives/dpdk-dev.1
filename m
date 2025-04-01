Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D70C36010
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Apr 2025 23:48:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6655740659;
	Wed,  2 Apr 2025 01:48:44 +0200 (CEST)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id C57DA4060F
 for <dev@dpdk.org>; Wed,  2 Apr 2025 01:48:41 +0200 (CEST)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-227aaa82fafso119311325ad.2
 for <dev@dpdk.org>; Tue, 01 Apr 2025 16:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1743551321;
 x=1744156121; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+80+ku5gCA62WnZC0R6qK4dPbWCXGxUsAN2BcUijyk4=;
 b=i9oTPU4Tjqvy3jhcfjBm899d0kOmj7tcOop2rXKbpB2E1/6ADWt5YJhuEVytYGefSV
 KMlv8j09mNjGJJuk/ufzTk+IUP4BcUyvAIkP8xHT1tFtHk2mqaplaeSNZbQZwrJUb5z2
 d6WWeXGz0XPP43vctyHE1zeEZ/n4U005W2S0HONdK6tJna7esZ8Z4xvNRbu1n66p5Gtz
 qAXQoJEhoH5JIL93knDKNnjMaG/5muWdkn+/QFILrS9+AvjcLBtMSsDECtuRHRS2pUrA
 x+7pwOo4ThvasJ851dryHWlS6M0W6JPbekgfXcts/l9kEUx4YMWBlc/tZCoQ0ForyWwB
 2NWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743551321; x=1744156121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+80+ku5gCA62WnZC0R6qK4dPbWCXGxUsAN2BcUijyk4=;
 b=SlDb03jOEBBMt3/fhZAFamvu4/DIXjAx+qY5VbDqiMojLAREcl6RUTh1Wnc5DmRrJD
 01v3alnSw9jrnfq6geLpnvTTHhPdkj0WChV6pG8hGTa0gnFxoAQwUGKV6MQiZbejjl0G
 /5aYwSmINXVAQZTJIr79wTHapAwgIH92UTBE2e7tGWtJT/0uuArowBFDLemnJS0fFiti
 s6wuaMkI2iHzV+ZisfnXy2ITNwV8ES0tPf+TGkJ0UwTbSS6GFVmn05zayxQ/XkRH7IT1
 4qjZaggceJquOurxAbV4NgZVAhbCP89ePcgB+zzKbdeLsUKyj46hugOdb+f7qebyZ+am
 +bRQ==
X-Gm-Message-State: AOJu0Yxc1Px5VHk1S5YOzFTqPuEeo4mgiNsuYWFVE8ECc0AMTwzMEaVq
 OfGrXolxvIbJRjGul0vlTojNCtqzlJHxwQB3DBKYZ1UztLkzAbqhNvOXqDPMNiIQlYsF9yupCtM
 c
X-Gm-Gg: ASbGncuKZpvMM71ETWjh6ynxOQS/ePLusVtjMSedOelp2e0bY1fhPbhm8bBn/z5lcWL
 AFnsycCNs9LHwkyamj9wAg0/YCejSPoz8cfBu2KlxV/ATiijGRgU50PRt6pEZftfB0f4Kisem5A
 N8MkUvJIJo/DMvtfCN7wqmvFRheZaOB/gDs28BbZwztf0cvWhwj0RqflUfyTf0+If9bgmzBvlO6
 I7yMHKh8Q52DA/sUIdcA4giDFbkhyayWxBjrvxIiEK1Fvm8FX0PCeN/UbAgrrV+flg2mc+4LOzO
 tNky+UbngiaVAJ/VZlUQZ2tbEGMeRUV7myBRYIhr9I4faHyJtkfH55iptUFkrPXzS7uXkDh3BeS
 sxLyeSuMHzzK30GVueZVj
X-Google-Smtp-Source: AGHT+IE9q8CaA5aGIFRnRL03efssZ5P+R/tiRgS6Z7YhOa6U069JaaqKrxfUz2bvURc+FpWs9r7/gQ==
X-Received: by 2002:a17:902:d4d0:b0:224:1780:c1ec with SMTP id
 d9443c01a7336-2292f9d5958mr275082085ad.35.1743551321037; 
 Tue, 01 Apr 2025 16:48:41 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291f1f8bc5sm95135175ad.250.2025.04.01.16.48.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 16:48:40 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tetsuya Mukawa <mtetsuyah@gmail.com>
Subject: [PATCH v2 3/4] net/null: optimize Rx
Date: Tue,  1 Apr 2025 16:47:28 -0700
Message-ID: <20250401234828.10888-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250401234828.10888-1-stephen@networkplumber.org>
References: <20250326213608.581345-1-stephen@networkplumber.org>
 <20250401234828.10888-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

No other rx_burst function checks args, remove it.

Since rx_burst can only safely be called by a single thread
at a time, there is no need for atomic operations on statistics.
Add byte count statistics.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/null/rte_eth_null.c | 38 ++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/net/null/rte_eth_null.c b/drivers/net/null/rte_eth_null.c
index b7cc90300d..40ce5c6ed2 100644
--- a/drivers/net/null/rte_eth_null.c
+++ b/drivers/net/null/rte_eth_null.c
@@ -37,7 +37,9 @@ struct null_queue {
 	struct rte_mempool *mb_pool;
 	void *dummy_packet;
 
-	RTE_ATOMIC(uint64_t) rx_pkts;
+	uint64_t rx_pkts;
+	uint64_t rx_bytes;
+
 	RTE_ATOMIC(uint64_t) tx_pkts;
 	RTE_ATOMIC(uint64_t) tx_bytes;
 };
@@ -85,12 +87,10 @@ RTE_LOG_REGISTER_DEFAULT(eth_null_logtype, NOTICE);
 static uint16_t
 eth_null_rx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
 {
-	int i;
+	unsigned int i;
 	struct null_queue *h = q;
 	unsigned int packet_size;
-
-	if ((q == NULL) || (bufs == NULL))
-		return 0;
+	uint64_t bytes = 0;
 
 	packet_size = h->internals->packet_size;
 	if (rte_pktmbuf_alloc_bulk(h->mb_pool, bufs, nb_bufs) != 0)
@@ -99,24 +99,22 @@ eth_null_rx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
 	for (i = 0; i < nb_bufs; i++) {
 		bufs[i]->data_len = (uint16_t)packet_size;
 		bufs[i]->pkt_len = packet_size;
+		bytes += packet_size;
 		bufs[i]->port = h->internals->port_id;
 	}
 
-	/* NOTE: review for potential ordering optimization */
-	rte_atomic_fetch_add_explicit(&h->rx_pkts, i, rte_memory_order_seq_cst);
-
-	return i;
+	h->rx_pkts += nb_bufs;
+	h->rx_bytes += bytes;
+	return nb_bufs;
 }
 
 static uint16_t
 eth_null_copy_rx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
 {
-	int i;
+	unsigned int i;
 	struct null_queue *h = q;
 	unsigned int packet_size;
-
-	if ((q == NULL) || (bufs == NULL))
-		return 0;
+	uint64_t bytes = 0;
 
 	packet_size = h->internals->packet_size;
 	if (rte_pktmbuf_alloc_bulk(h->mb_pool, bufs, nb_bufs) != 0)
@@ -127,13 +125,13 @@ eth_null_copy_rx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
 					packet_size);
 		bufs[i]->data_len = (uint16_t)packet_size;
 		bufs[i]->pkt_len = packet_size;
+		bytes += packet_size;
 		bufs[i]->port = h->internals->port_id;
 	}
 
-	/* NOTE: review for potential ordering optimization */
-	rte_atomic_fetch_add_explicit(&h->rx_pkts, i, rte_memory_order_seq_cst);
-
-	return i;
+	h->rx_pkts += nb_bufs;
+	h->rx_bytes += bytes;
+	return nb_bufs;
 }
 
 static uint16_t
@@ -335,7 +333,6 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *igb_stats)
 			RTE_MIN(dev->data->nb_rx_queues,
 				RTE_DIM(internal->rx_null_queues)));
 	for (i = 0; i < num_stats; i++) {
-		/* NOTE: review for atomic access */
 		igb_stats->q_ipackets[i] =
 			internal->rx_null_queues[i].rx_pkts;
 		rx_total += igb_stats->q_ipackets[i];
@@ -368,9 +365,10 @@ eth_stats_reset(struct rte_eth_dev *dev)
 		return -EINVAL;
 
 	internal = dev->data->dev_private;
-	for (i = 0; i < RTE_DIM(internal->rx_null_queues); i++)
-		/* NOTE: review for atomic access */
+	for (i = 0; i < RTE_DIM(internal->rx_null_queues); i++) {
 		internal->rx_null_queues[i].rx_pkts = 0;
+		internal->rx_null_queues[i].rx_bytes = 0;
+	}
 
 	for (i = 0; i < RTE_DIM(internal->tx_null_queues); i++) {
 		struct null_queue *q = &internal->tx_null_queues[i];
-- 
2.47.2

