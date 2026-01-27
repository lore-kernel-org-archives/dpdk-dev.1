Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3A9D340A1
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 16:34:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C3404111C;
	Tue, 27 Jan 2026 17:33:35 +0100 (CET)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42]) by mails.dpdk.org (Postfix) with ESMTP id C79C041101
 for <dev@dpdk.org>; Tue, 27 Jan 2026 17:33:33 +0100 (CET)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-42fbc305882so3617573f8f.0
 for <dev@dpdk.org>; Tue, 27 Jan 2026 08:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769531613;
 x=1770136413; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k2efeRNrCdrMPbej6VXPI+4qlGPa2dstlpUlX8ye1Us=;
 b=IMSPeEASFuMr7CrISw48IBvtw23xAfNybiDEsdVo8+I8Z1mRm7dheHCjgNNZrZvEzR
 BlGvfcUd9+dRDp0JQsIRtPA3QFKh40pLIoVkba+SE6nRPigGfqrrtJj/CIT5WExByN9R
 3MeYtbvgP62wZd6v39r5Ro8yaG5F5XhIMQ+vYd4Qbci/GAMormWKqQxgdHbEYmgFYzvB
 pwsjzuE+iTGz+/Zw4jR2N918JOnpats/Xa6rY4v9mi4FnCuSHFLk0z0v5thKEXcRwN8I
 fNsY76Ur0BrKCsWY8mNp/OTFiqATxfyXn8HqLAf+OOIgzeGKmbpoZL7wbljWZFRIdan9
 qG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769531613; x=1770136413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k2efeRNrCdrMPbej6VXPI+4qlGPa2dstlpUlX8ye1Us=;
 b=h26xzJBH7TU2atSYRvoYiH7hkwtWQ0tBz3oVf9FWUm9t4mo+7KGee2+du1MugdskAy
 aoYp/r7l6bK4E0CZtzbkfWBu2Bb+hdVc3juYBxjs4hPnQC1+UeFsaFPe8ZU3K6fpdRoQ
 GuJwqNrHecYhG2wiDWaR1THKjKi3Wyv9HxLKLpuBlTk2e+ks8pzEQrKFYSghpPn0JoH7
 8anVLJPh8S8EAQLjVKpqzsGj9QOhbvi3I7CgQBSV+dxrnmNUgEQ+FJ7jHchxTp0h6hgT
 xjKhxpjO4tAFdw4FXIYd0p3kfGyr4Gf9j4XV4hLpKknJ1dG7V+t4CcyKCT6UtDt9ODQ7
 Mg3A==
X-Gm-Message-State: AOJu0Ywmo8nYv4cqKo8mIn4rm1Tv+pRQqNiIOYGf4Wgy+EO6A3HnK+Fr
 +6NH3FbR+YtuapEaYGB5PDWmHvj/xyJI0JYSV0YxOIpuAqTw/d5SwTgLik9Bs3PqCJsNEhrhCNp
 yu16C
X-Gm-Gg: AZuq6aKC7M8TmOiBgWOtd3A3JGDh74oMUdkB+3VKdBw6WnQncPBiVRx57snVXnUxfG7
 NpanVIQVBXjO+1Rse1xbrLjjeulT7s55qbJZZXhXFcBpvZlwGS+8tQPJe1OslJJkjcukAApCzLy
 KbUqwFSodyVkKFNUUchnXFyEHFDKptnNwC6oQa8II9yDMV3OgH8fZMJjjW6HatEnc46250Gaoy2
 3Go6DFALK1hd69lKfduB+P5SRqkW9pv9UHbXxOU0OsPvvdiLmyvdxJaG2pseClLTe0yCFVck7go
 cn5nvQzZXlbiTHmNj7/5gUHyozN8tLtyABjwRger1HGITZ9ItvqEtEzgOVJef7BKmnOdK4fRJ5X
 Di/6UVQR89FJOpu8H42DvlTpRur1B3pvoEOGYeLgcmaLfkHHqX/6VPht/2hr6m7gzz5B+Pt4X3Y
 AgtbP5iW7g/BEJoxxPSwstHZMz7wRXBQDJaXze1FLQmD1bSzzgog==
X-Received: by 2002:a05:6000:4282:b0:431:752:671e with SMTP id
 ffacd0b85a97d-435dd05ae8dmr3941147f8f.15.1769531613326; 
 Tue, 27 Jan 2026 08:33:33 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f745dbsm39978513f8f.34.2026.01.27.08.33.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 08:33:32 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v13 14/17] ethdev: avoid possible overflow in xstat names
Date: Tue, 27 Jan 2026 08:30:28 -0800
Message-ID: <20260127163258.75566-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127163258.75566-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260127163258.75566-1-stephen@networkplumber.org>
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

The compiler doesn't know that all the elements in the table
of queue stats are short enough to avoid overflowing the snprintf.
Add a condition to warn if it ever does;
maybe some day a new long named queue stat could be added.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/ethdev/rte_ethdev.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 2659e8d9eb..8026e7adb4 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -3488,9 +3488,10 @@ eth_basic_stats_get_names(struct rte_eth_dev *dev,
 	uint16_t num_q;
 
 	for (idx = 0; idx < RTE_NB_STATS; idx++) {
-		strlcpy(xstats_names[cnt_used_entries].name,
-			eth_dev_stats_strings[idx].name,
-			sizeof(xstats_names[0].name));
+		if (strlcpy(xstats_names[cnt_used_entries].name, eth_dev_stats_strings[idx].name,
+			    sizeof(xstats_names[0].name)) >= sizeof(xstats_names[0].name))
+			RTE_ETHDEV_LOG_LINE(ERR, "statistic name '%s' will be truncated",
+					    xstats_names[cnt_used_entries].name);
 		cnt_used_entries++;
 	}
 
@@ -3500,10 +3501,17 @@ eth_basic_stats_get_names(struct rte_eth_dev *dev,
 	num_q = RTE_MIN(dev->data->nb_rx_queues, RTE_ETHDEV_QUEUE_STAT_CNTRS);
 	for (id_queue = 0; id_queue < num_q; id_queue++) {
 		for (idx = 0; idx < RTE_NB_RXQ_STATS; idx++) {
-			snprintf(xstats_names[cnt_used_entries].name,
-				sizeof(xstats_names[0].name),
-				"rx_q%u_%s",
-				id_queue, eth_dev_rxq_stats_strings[idx].name);
+			unsigned int cc;
+
+			cc = snprintf(xstats_names[cnt_used_entries].name,
+				      sizeof(xstats_names[0].name),
+				      "rx_q%u_%s",
+				      id_queue, eth_dev_rxq_stats_strings[idx].name);
+
+			/* could only happen if a long string was added */
+			if (cc >= sizeof(xstats_names[0].name))
+				RTE_ETHDEV_LOG_LINE(ERR, "truncated rxq stat string '%s'",
+						    eth_dev_rxq_stats_strings[idx].name);
 			cnt_used_entries++;
 		}
 
@@ -3511,10 +3519,15 @@ eth_basic_stats_get_names(struct rte_eth_dev *dev,
 	num_q = RTE_MIN(dev->data->nb_tx_queues, RTE_ETHDEV_QUEUE_STAT_CNTRS);
 	for (id_queue = 0; id_queue < num_q; id_queue++) {
 		for (idx = 0; idx < RTE_NB_TXQ_STATS; idx++) {
-			snprintf(xstats_names[cnt_used_entries].name,
-				sizeof(xstats_names[0].name),
-				"tx_q%u_%s",
-				id_queue, eth_dev_txq_stats_strings[idx].name);
+			unsigned int cc;
+
+			cc = snprintf(xstats_names[cnt_used_entries].name,
+				      sizeof(xstats_names[0].name),
+				      "tx_q%u_%s",
+				      id_queue, eth_dev_txq_stats_strings[idx].name);
+			if (cc >= sizeof(xstats_names[0].name))
+				RTE_ETHDEV_LOG_LINE(ERR, "truncated txq stat string '%s'",
+						    eth_dev_txq_stats_strings[idx].name);
 			cnt_used_entries++;
 		}
 	}
-- 
2.51.0

