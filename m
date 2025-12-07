Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF19CD2CE17
	for <dpdk-dev@archiver.kernel.org>; Sun,  7 Dec 2025 19:14:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 068CE40689;
	Sun,  7 Dec 2025 20:13:19 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id 240E24067C
 for <dev@dpdk.org>; Sun,  7 Dec 2025 20:13:17 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4779ce2a624so48477315e9.2
 for <dev@dpdk.org>; Sun, 07 Dec 2025 11:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765134797;
 x=1765739597; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ckPcxqjACKxECZIs8TWH87xa+KWpqiOYhGfkjwzJf+A=;
 b=vRhS4B75YfNnVisN4ArcDK4lpiL5BtoPldl9IugqOdrtaHfdiy7MoFFFC02jP6hmie
 7x4tF3c7Kv54ePGS//cCFt8MKq72ThYeCbhfBApGMCkNAVjZkIZGZo7ICysgDX0+DMU/
 UrO8E3KvyUgG8dF190d+Z1KmaBZGCh3/TdKBL3Cf7uGi3QE1O0fm8U5fvp8vQTYFsar8
 EH3w3n3JEuOo0UlaLuqCh+RmIcLV9ma6wj9QbYLv3t7jJW9q6FPbQC/P/YOfyIQoeH4C
 E2XdlvsjRlRoYfFVNcuj5D2wck2ELCWpgadbL9MNp4FpqcC7TI+1z95m00iR6qG2rc6h
 dEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765134797; x=1765739597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ckPcxqjACKxECZIs8TWH87xa+KWpqiOYhGfkjwzJf+A=;
 b=Ix7zb8FWKiaCXoblvEcf4m9oUVPne9kCxvWiPVr0eHJEeI8YGklK1RVsMxrebfsHBY
 Pa0XYHOQW9302C6EbjwIdhs9Ygy4wrI/MIeLiqcyEk5oGmqQsDS7be3BKTOjRshIIuL4
 Vvc5NgnfGj7JKB7hyoc0dd8T4lR570Pv6asixRcRzWFMr/LG/+Djmg2OmM6Fx8NtmS2H
 HZwBB4xanKvjKQ/aCKTYPbr2DqqyTPP/tW2IuSq7TdaYGFUPE5xDjd+kE0iNGYrjljlU
 ef9c9qV6Etz7RBKHgWNlWcfeMx+okoZZfNtQmzue0DqDMxWD+Mn6amddZzFP+UoVj9k7
 gzPw==
X-Gm-Message-State: AOJu0Yy9D3J5nfhJ4E76/aAAbYl6VSpw+hIxpUWzWJ2Be0VbDzNW3jPF
 //IpkxgNZOLJQvMipUV4jZ1vyG9CwgeuuAwj9+4Nyx1ATqI38erH0kW8RhWyNdEPC5i0NEP0sRr
 Njnax
X-Gm-Gg: ASbGnctjCvFj+TMktIo3N6VMhpKUANRp2MvIeGu5DDEzFQpgRoWbwl6GfrXcCpuQ7Ia
 BQ3n2QP/3tRuuexztTqN+m+vx+gK6w9YsvbYYc2DBqIHiqv8MPnQMiQtRRiAjJ5ZIvr0P4B6Qq0
 df2Q6jGJa/VD2h0zMxaAuFH29YmHnGbz4TKI366us6cyISzoW1R1odXzWS6rk5l7RbKirBIuhXv
 0ggZWypr3JG0XF09ksX3a/BovPRO7pPe6DduZX5stgyMg+bZiyx3mN3YJ1G+tpaZScNwLlc1q3m
 icYoBay2qqZVhUEzwSiLJxWWTA3toZqf2A6sSZuBAlWDmxM8OBiB0DmbNMnX3LOWe3gVvO9pm0H
 +7cmbXri4PnHnaHo2wK6uAlJOZ6TKVGFR9aDSVpXZ0g5kweMrKXVyODASYXTekwxnyGIrdlmKIt
 kblDnplFLYsKacI+V9MhmcoPTtthewXREHiuKvp5Krny+FxI38ag==
X-Google-Smtp-Source: AGHT+IGHeH5ifKBXBq2hh7lV8wRrMOfmcgYS9Dt/16LBAsPp0vVNS6waZ7M/PcJU7HS21qWY0zKy4A==
X-Received: by 2002:a05:600c:4446:b0:477:b0b9:3131 with SMTP id
 5b1f17b1804b1-47939df7d12mr62846045e9.8.1765134796694; 
 Sun, 07 Dec 2025 11:13:16 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479310b8e70sm205124205e9.5.2025.12.07.11.13.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Dec 2025 11:13:16 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v5 15/17] ethdev: avoid possible overflow in xstat names
Date: Sun,  7 Dec 2025 11:12:06 -0800
Message-ID: <20251207191242.165619-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251207191242.165619-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251207191242.165619-1-stephen@networkplumber.org>
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
index c6fe0d5165..05de3335e5 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -3489,9 +3489,10 @@ eth_basic_stats_get_names(struct rte_eth_dev *dev,
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
 
@@ -3501,10 +3502,17 @@ eth_basic_stats_get_names(struct rte_eth_dev *dev,
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
 
@@ -3512,10 +3520,15 @@ eth_basic_stats_get_names(struct rte_eth_dev *dev,
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

