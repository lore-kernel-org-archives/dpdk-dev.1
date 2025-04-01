Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F78CC36010
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Apr 2025 23:48:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2FAA640653;
	Wed,  2 Apr 2025 01:48:43 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id 1813740430
 for <dev@dpdk.org>; Wed,  2 Apr 2025 01:48:41 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-223fd89d036so131337075ad.1
 for <dev@dpdk.org>; Tue, 01 Apr 2025 16:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1743551320;
 x=1744156120; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JB9ST+9ynOeWjooXsipA8uDwZh7prXoV9CvkSixYKMw=;
 b=d0r8p9+CjQQvgg59zkyFWbglrITLm4fOGIrxnPPYCfJ1mh/bm3VkLTEWMGGIL6ahv6
 ub9mvJ9wKBbCPGN5wHabi9crRFZdpoIHNoVBwYrUbSAJn+NIVIQLn6Bcbij9v7cLgBef
 JZDu3rON5sBffwj+9OAxMBITMpSS23grf8ZD4atWquEwcg7llx2Innb9SKmJ4nXa97G+
 WRptBpoBo4iSvxufsBC9mcd+XUKEkWzUTAMSTQLflHggJH5fkTpvIrqLYY7GjzsC1EAr
 RxZ5bbVKJ1BQL+P2v/M+CIL7JPYiyuqmL02IGiigwHH93RjvuOskAq1dqLjz0iFNCoXJ
 qdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743551320; x=1744156120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JB9ST+9ynOeWjooXsipA8uDwZh7prXoV9CvkSixYKMw=;
 b=M113s8Bdf0VMtjLdzuAFMahnKXElmwWB4AajfShGz8miJwUdCLV14pzTH5uT8orwyC
 gP9/AP6WtuDlgnditvNgwVtDGW4mve9cX9QrZa9hz6pfG57sZbQN6pdtEAlsQEeoEaNr
 uS7kVLeAlKoTmXS6s3ZWVcX2FEw3rURWtIoi0ujS1OCmjpkBW3XZsggItHbkVtf4npFq
 9iUboYQ8/WY8LC+eK3vmuWc/C4nfm56VZRq/XQflkbVE32l9yNrg61VRcb7GLSgHJxav
 sNC9+XOq42HmM2Ra77uOpX1JkbWYC4ZaJxTLcDCggMwF+01OeKLTL6sM3licewK2Bjqj
 4ktw==
X-Gm-Message-State: AOJu0YwrAK6uBfKThMF8AQToBvq0Qev2gBqVPzo9/770kGlgPnGv7kOj
 V1gVJamNs70dAQkD1FhEN+aqzwYy1NppbEoMxBQ0o/JJHNYUp7/TLOVKIuCgRwcp3P9W3d7ZJKg
 2
X-Gm-Gg: ASbGncvRGs44a0yqcps+B10kfzXijZahcGfNMsI70mQu/AExJaLmvEAnABjoxaWcXMF
 G1QsEK3aj3eRoSkiGf0EtOOJhAmME0kkOpdtCNNwIJU1fzTf5w/H2t1Z0iE7VemhG43RRUuYiYz
 ya8yQFuxfF9EUKFU4IsLInBok5IauLgw61zBLTDh/hFiLFXrI3TidYrgfsjcvGbr0s8l+fLm1Lp
 PkeHry9szfWKMLO2nv5GgckZzgR4aXtJZSPCk51x/he1tNM9YXQMOUepQRGdx1Roi32TNuMZqx1
 wWpyYkh39iM5Fs+Qr2X0McIDi4ZO6kwqDyuVVHC9XKFYeleythmFzD4N+iM8F516SMB6th5oRwZ
 J3O3aNpUuM4UqQT5//c39ilDSkaqqUcU=
X-Google-Smtp-Source: AGHT+IFwU1tJNZA8/g/F/twalweyvXetftebzNyyozd7PoSvUy1SpUVreLQOdHkr9+MdGisYU/VBbg==
X-Received: by 2002:a17:902:d4c6:b0:225:ac99:ae08 with SMTP id
 d9443c01a7336-2292f948ce8mr218527835ad.5.1743551320201; 
 Tue, 01 Apr 2025 16:48:40 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291f1f8bc5sm95135175ad.250.2025.04.01.16.48.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 16:48:39 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tetsuya Mukawa <mtetsuyah@gmail.com>
Subject: [PATCH v2 2/4] net/null: Tx optimizations
Date: Tue,  1 Apr 2025 16:47:27 -0700
Message-ID: <20250401234828.10888-3-stephen@networkplumber.org>
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

All the null device does is call pktmbuf_free, can be marked lockless.
The statitistics need to use atomic for this.
Add byte count statistics as well.

Use rte_pktmbuf_free_bulk instead of a loop.
And pktmbuf_free handles multi-segment packets without problems.

There is no reason for eth_null_tx to check arguments,
no other tx_burst function does.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/null/rte_eth_null.c | 50 ++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/drivers/net/null/rte_eth_null.c b/drivers/net/null/rte_eth_null.c
index 966748689f..b7cc90300d 100644
--- a/drivers/net/null/rte_eth_null.c
+++ b/drivers/net/null/rte_eth_null.c
@@ -39,6 +39,7 @@ struct null_queue {
 
 	RTE_ATOMIC(uint64_t) rx_pkts;
 	RTE_ATOMIC(uint64_t) tx_pkts;
+	RTE_ATOMIC(uint64_t) tx_bytes;
 };
 
 struct pmd_options {
@@ -145,19 +146,18 @@ eth_null_no_rx(void *q __rte_unused, struct rte_mbuf **bufs __rte_unused,
 static uint16_t
 eth_null_tx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
 {
-	int i;
 	struct null_queue *h = q;
-
-	if ((q == NULL) || (bufs == NULL))
-		return 0;
+	unsigned int i;
+	uint64_t bytes = 0;
 
 	for (i = 0; i < nb_bufs; i++)
-		rte_pktmbuf_free(bufs[i]);
+		bytes += rte_pktmbuf_pkt_len(bufs[i]);
 
-	/* NOTE: review for potential ordering optimization */
-	rte_atomic_fetch_add_explicit(&h->tx_pkts, i, rte_memory_order_seq_cst);
+	rte_pktmbuf_free_bulk(bufs, nb_bufs);
+	rte_atomic_fetch_add_explicit(&h->tx_pkts, nb_bufs, rte_memory_order_relaxed);
+	rte_atomic_fetch_add_explicit(&h->tx_bytes, bytes, rte_memory_order_relaxed);
 
-	return i;
+	return nb_bufs;
 }
 
 static uint16_t
@@ -165,22 +165,19 @@ eth_null_copy_tx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
 {
 	struct null_queue *h = q;
 	unsigned int i;
-
-	if ((q == NULL) || (bufs == NULL))
-		return 0;
+	uint64_t bytes = 0;
 
 	for (i = 0; i < nb_bufs; i++) {
 		struct rte_mbuf *m = bufs[i];
 		size_t len = RTE_MIN(h->internals->packet_size, m->data_len);
 
 		rte_memcpy(h->dummy_packet, rte_pktmbuf_mtod(m, void *), len);
-		rte_pktmbuf_free(bufs[i]);
+		bytes += m->pkt_len;
 	}
 
-	/* NOTE: review for potential ordering optimization */
-	rte_atomic_fetch_add_explicit(&h->tx_pkts, i, rte_memory_order_seq_cst);
-
-	return i;
+	rte_atomic_fetch_add_explicit(&h->tx_pkts, nb_bufs, rte_memory_order_relaxed);
+	rte_atomic_fetch_add_explicit(&h->tx_bytes, bytes, rte_memory_order_relaxed);
+	return nb_bufs;
 }
 
 static int
@@ -314,6 +311,8 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->max_rx_queues = RTE_DIM(internals->rx_null_queues);
 	dev_info->max_tx_queues = RTE_DIM(internals->tx_null_queues);
 	dev_info->min_rx_bufsize = 0;
+	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS | RTE_ETH_TX_OFFLOAD_MT_LOCKFREE;
+
 	dev_info->reta_size = internals->reta_size;
 	dev_info->flow_type_rss_offloads = internals->flow_type_rss_offloads;
 	dev_info->hash_key_size = sizeof(internals->rss_key);
@@ -346,10 +345,11 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *igb_stats)
 			RTE_MIN(dev->data->nb_tx_queues,
 				RTE_DIM(internal->tx_null_queues)));
 	for (i = 0; i < num_stats; i++) {
-		/* NOTE: review for atomic access */
-		igb_stats->q_opackets[i] =
-			internal->tx_null_queues[i].tx_pkts;
-		tx_total += igb_stats->q_opackets[i];
+		uint64_t pkts = rte_atomic_load_explicit(&internal->tx_null_queues[i].tx_pkts,
+						   rte_memory_order_relaxed);
+
+		igb_stats->q_opackets[i] = pkts;
+		tx_total += pkts;
 	}
 
 	igb_stats->ipackets = rx_total;
@@ -371,9 +371,13 @@ eth_stats_reset(struct rte_eth_dev *dev)
 	for (i = 0; i < RTE_DIM(internal->rx_null_queues); i++)
 		/* NOTE: review for atomic access */
 		internal->rx_null_queues[i].rx_pkts = 0;
-	for (i = 0; i < RTE_DIM(internal->tx_null_queues); i++)
-		/* NOTE: review for atomic access */
-		internal->tx_null_queues[i].tx_pkts = 0;
+
+	for (i = 0; i < RTE_DIM(internal->tx_null_queues); i++) {
+		struct null_queue *q = &internal->tx_null_queues[i];
+
+		rte_atomic_store_explicit(&q->tx_pkts, 0, rte_memory_order_relaxed);
+		rte_atomic_store_explicit(&q->tx_bytes, 0, rte_memory_order_relaxed);
+	}
 
 	return 0;
 }
-- 
2.47.2

