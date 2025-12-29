Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDD3E92FD6
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 20:49:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2537740691;
	Mon, 29 Dec 2025 21:48:58 +0100 (CET)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45]) by mails.dpdk.org (Postfix) with ESMTP id 269FC40685
 for <dev@dpdk.org>; Mon, 29 Dec 2025 21:48:56 +0100 (CET)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-42fb4eeb482so4690930f8f.0
 for <dev@dpdk.org>; Mon, 29 Dec 2025 12:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767041336;
 x=1767646136; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ckPcxqjACKxECZIs8TWH87xa+KWpqiOYhGfkjwzJf+A=;
 b=1cBfwe/KEMzjqZ272ShoZoMJSrIxjWT/JOvVsRYg1SvCviF5vd65VZ02k1mIszt8Du
 23sL6tvzSo8uUTfpxmc5ZzEo6A30Ysxc3JN6v5y817jPoCzc9JZm+nINNyQI1HRDU67J
 hNRd4N3e+CLmRQ2diYl4cItW+eW3cgDFIY6trOhh+s8qbylUTqZxpfI2OAsO6Cevj+ZY
 XI8GRsHsvZFzsJl7iqH/eYNeTSZ4BeFS3OOSiYRmxRLril6bZL4w9864RpzpsueMKH+c
 8vhfNrwlBZBR8C4Avt7zScRkud0QziVc9HB1c7bcWTmQnUWixLA0QfqMAgNVTC+2EJcA
 SFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767041336; x=1767646136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ckPcxqjACKxECZIs8TWH87xa+KWpqiOYhGfkjwzJf+A=;
 b=OiwNE8ccae6phCugny094IDX9itXPTVwDiZmtp2WOJT331SSDb3LtmzyghVVPEzQp0
 ANLkYHx+QhvwFR3hACGfJXBQOlm1RA3p0y8g/gOusQoCcMpiUbjeNN1GvAC+Z3pQgzeq
 8fVm8IjFFzBt9uQxv6ChUiT1Gg3zMkqtVZ8oJ63+h42/y8wxSVVvaMPHp6gDzBk0i7kl
 siSWl+dNrXMI36nr8n3u7UD+v4mStmfYtzGCZ/gSWHlh/QTqZuip7tayEc8D8ydJMBhI
 V9fXmo4F7tWwZZ/XHD7mFJ2f6e1rLZnw4PcMpRIwhNdGSK+8WsmknvdaTLeNgv2fQXMI
 32SQ==
X-Gm-Message-State: AOJu0YyKBmeXxnTYCH1Wg+ThNiP5erWIUNalXXaP4fsfxaZZKNYgU/wE
 qTftEI2oTwLNLdBKsC52+AVlrFc0mLBHfJQKeCYQdqnqlK6al3KLIUoR0axWHmF/2S80/gbavNx
 AMczR7zA=
X-Gm-Gg: AY/fxX49REK/UtARBlvx6ZUP5tf4uYkVIwIagqlQpkboZuOMwnlFUvoFHK73yAb4MTj
 arMMxufzPc3tvaCCmdITWk8O+fHHegH5aAnjMOkdYUvcou6UcqdqF/dXiV7SJkdVQzl9tQwiI8D
 G2N8SDqwqyh3Dhqdo1VPlOBmHgs6z/n2vJeUAZ6D6avoTlhseBotJv97EVjYPfYeL6WZCPLVrV0
 eIobidk2v40sOY89+XnmxyNGHJ+6IvKBA1+vk89c/13Rv4tqLDFEFc24X4s7d0yzLUOIeAycXFr
 L+kl25pMlHgwh+O95w7l+FXQJRxkbmYrgg0KCKo978PRy4jI/u20HJpZh/Syie8Ih8MEpym44Jv
 ab0VyflvNN7pnSJXLJ55SBL4DmXXAUfcPhW9CeULn8kulKM8xAreDQEO9cjZ6JSfAlD1TAfXRUt
 SVc9V5c8eTiKsJzf/wKKzf1b3Mdi8a5iUlJoP9efQ+2+tpgyBj2zOQy99FUV7G
X-Google-Smtp-Source: AGHT+IED1blcq60RaY1pugD2w/4bMStmEbmqfS+C26NjvO2CLa1v5iQtmYIBGJZ1kLCrtdzbaSpixw==
X-Received: by 2002:a05:6000:2883:b0:432:86f6:b9e4 with SMTP id
 ffacd0b85a97d-43286f6b9ebmr8583882f8f.1.1767041335726; 
 Mon, 29 Dec 2025 12:48:55 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab2c4fsm64676298f8f.42.2025.12.29.12.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 12:48:54 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v9 15/18] ethdev: avoid possible overflow in xstat names
Date: Mon, 29 Dec 2025 11:38:13 -0800
Message-ID: <20251229204818.61231-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251229204818.61231-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251229204818.61231-1-stephen@networkplumber.org>
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

