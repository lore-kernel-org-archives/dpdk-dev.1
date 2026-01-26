Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433ABD19523
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 23:26:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0DA0640DDD;
	Tue, 27 Jan 2026 00:25:04 +0100 (CET)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47]) by mails.dpdk.org (Postfix) with ESMTP id 7B2DE40DDA
 for <dev@dpdk.org>; Tue, 27 Jan 2026 00:25:02 +0100 (CET)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-42fbc305552so4379486f8f.0
 for <dev@dpdk.org>; Mon, 26 Jan 2026 15:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769469902;
 x=1770074702; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k2efeRNrCdrMPbej6VXPI+4qlGPa2dstlpUlX8ye1Us=;
 b=QUkavzN1vFvjwVVbYAmZvrdxSDP3sXhdgtEQnCVd5gPpm1M2VWTa8hWFDXjZAR8kmz
 nfU7wxK94oXR5bgXuUq23+H5bj0blG2SstodaDbC/zn3c0uS1UWDDCjlMTamkJGqeyK4
 HxL4A6bhZE9P0T9gl3vCjfnJMjEHJhn1hMJysW1sahleILpFi242IvheLZmt2qwxsHEL
 nJ8o5PjF7qEVzQbJchQ1wjXtUG7SzszuKiO2JY6i4n+xBp0asyDTfiw/q1VjNgc8TW5t
 gz+SXp8gotsXiqHQxbEefK16bD1YGNlXkqohesWBiLyouJZocnux7eb94aLrlsMbZNuf
 8aJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769469902; x=1770074702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k2efeRNrCdrMPbej6VXPI+4qlGPa2dstlpUlX8ye1Us=;
 b=ajuwMnHIJtmNRTdyGezTE3g2zQOtLI9BgliD0MH6RNnXfSZIVXuaBU4ladvUqQhtYQ
 9H4uCKJ5W4DSIusdqNAMcez65MQGOQuil9eGNyX98/foxosKEdOK50WrCsSdTKfuvpsi
 hWFz9YMSgsdzM0Giw1MvIV2NReUQFCh6Uv04T3AGKtiXu7RJRGrm70Wok5L8/NULrYXx
 dkb03SC0CNlg9OWSbAJwTMsGxix7deiS9y3+paAFgqKQpmzPlBJdlnTbDI8AJkpiJI28
 Y90svEulH3rSx7TPHGDdq4HZieXPOG4vxR9biXBV8H7v0EorvYVbO393jANOOpjompUS
 hp+A==
X-Gm-Message-State: AOJu0YwVWdhM4BsMFpIOOKzuOcc6aUK9fCwuLjm+rsFuNkQt5KlzK/L0
 550Bm4z4LHZavucZnVJO0AqHAHVQ7GoNZiIoJElhFRkiktOjeRRyoUf8Ad23DX5dXlMfkX26xzy
 E32Vc
X-Gm-Gg: AZuq6aKVNws/sh65zQY3MHm1Q8TgZpUR54SzTaHrwarhGjXGmjKMdG3f6sLQGPhhkqA
 rFt+R3s4inOK8DETSHzjxo5tBpqXaPUYyOcOq9L89+y782Jee1w1vm+qyT1bhn5GMzWZCABAthA
 0MadMigcpg4UEmazGigII4pqt/DppAA9Gl4jRu0MkEgu8dZ2OR2hc/rzosbKarjAb4ZO5Dz+Hdb
 nHe/dMimcONmbbzVkzCAx3NXGBToI2VdpBwk2cYRDuNBRhKghjFI1HIs2UEMIm+FAcAJ484HHWo
 yIUu26ljWiJIhYvgmDDgoPq3Ow+WoXqrYe+uixJ529MwtOMrswwAHk8I75MgfewO4uDTv1nztOR
 lp/xk4RNAjRTFAOqnswKx/c4/f8Mw6LHSrjlf2RNgtFH/qFWN20qhKaqQwCSacR7XDtco8bUUIE
 ndwFqYFRBfilOuf2f7+1N9e0ZsDtLzqHZrgVPzKEbUVlsGKbfSvQ==
X-Received: by 2002:a05:6000:4008:b0:430:f5ed:83e3 with SMTP id
 ffacd0b85a97d-435ca123e42mr8907195f8f.6.1769469902034; 
 Mon, 26 Jan 2026 15:25:02 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24a6fsm33711846f8f.16.2026.01.26.15.25.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 15:25:01 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v12 14/17] ethdev: avoid possible overflow in xstat names
Date: Mon, 26 Jan 2026 15:22:22 -0800
Message-ID: <20260126232428.276534-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126232428.276534-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260126232428.276534-1-stephen@networkplumber.org>
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

