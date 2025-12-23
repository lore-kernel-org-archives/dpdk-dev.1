Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A492E6FE23
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Dec 2025 18:16:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B291E40674;
	Tue, 23 Dec 2025 19:14:50 +0100 (CET)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47]) by mails.dpdk.org (Postfix) with ESMTP id 9B4E64069D
 for <dev@dpdk.org>; Tue, 23 Dec 2025 19:14:48 +0100 (CET)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-b734fcbf1e3so1032466866b.3
 for <dev@dpdk.org>; Tue, 23 Dec 2025 10:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766513688;
 x=1767118488; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ckPcxqjACKxECZIs8TWH87xa+KWpqiOYhGfkjwzJf+A=;
 b=1FOPpC7z0Yhg6CTRe8WP3U8TVYcKOigTN8m9hQbT4UssrDq/Veygav/M+yxzLdCtDR
 +YaobzpDGwFPihUnpEplpGZtM+1HQDbGSy2DaotGV+pR0yMVg98eY6V1BgBl4EppRY1D
 8lVbTcsO6E+rWL/671PdJnhYBgXsD1yJeZucDl+DYI5GnRvm9LhJZvLUn2oyDqy4RbJU
 7U6HKm6ORjN3GmSb9yRcefk5V91MNAzh7s0DJVm8HV+1R6p8f9ru1K/xkYnA+ZSz9ErR
 vDaR3Eri3GwJ3pLKr2TxRFmEbmJYwNy0zwS3y0l8R0vscJZFqf+1FrV9PaMqeZWeTQzf
 1iGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766513688; x=1767118488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ckPcxqjACKxECZIs8TWH87xa+KWpqiOYhGfkjwzJf+A=;
 b=F81X5UIKGdKbQEV8FapT87rMQBnZbTML43fthywYp7AlIqXPWd5AhQGOupTz5eWcZg
 dlN6JQc69V+NIFaZe68VlGOsh3NCr3P9t6r0UHA2YQwENDKXYspLiLDJmbSMNoxZ3uDq
 fG3wy7PELUY8GQ5kgCA7WUhcTARYIUmETHjnXupMZ3M+V0SeVuxkRkMgsFeKp6c4KuI5
 UFkI/1XiPKGsHtlP1kxPBQeC3x8/3jDgCSNMHYIQ6X8jLncPQk8y92B7w9k+Xs/am8dy
 +rWacsMl2dHlFS/L6meqhMy71E9srf670TXxbcet21vF8l85xwhZTAbucu6PoLYYWMHP
 Vj5g==
X-Gm-Message-State: AOJu0Yzhkz5k1joJ5wozqql5zBzIFeU7DT1GTcTZj33D6ZTq7O3/XQge
 HLqRjYUZ8KV7Lt+ylI2cwrleSHt9L0HdJ54baqBsyleLF0rqTO9HHvFQ3NliIoflxSFtJz9X9ux
 L05wOdDM=
X-Gm-Gg: AY/fxX69omaFA88YZNZxea7Hp0iOSihFfSIq0KtUUJso5DHz6Mq/nUPD4XGnLUCTUCY
 qxRHYj7m7Rt2iE4RFfJMT0jK7CYBsnulwIUrV8EIVt3fouE8GpFthr97Nqv0adO1XFdekCnwfiC
 eLrGUVk+Ix5G/Ue+3TMYy+5CErIzH2p5VHkDv0vQRkYmQOswdvS+IYeaYMXz3s9rT5sVfGfhDRS
 xuiBGUWdzGjWUpA1M5XipsNqp5moA4fvDfD0t9SGLzCvfeVkEKCGRbSVZG1nWukqsBBvCtZOedP
 qdzD2JfuQoq0NTeEDyDo6g2uL+y59oEZwZYnskcQv6Q9xUzX5vBH9UhDqbNjS+mvR474xFFLpHa
 +LmlE+yQwjUhHJpNqW8nX1IHwHD5zOTTqXXjYXVCMNjLnKGCXxjioX/OAZKjXMdaDbAlXOxXzMr
 NirWleCmuPNVLziQysIBUR4OuFoXbdrEZc6cXS2eUtD9SSJNYJug==
X-Google-Smtp-Source: AGHT+IHPyzhap4Q4P3hd2Dt18BTXTiHCUc1e/X8FacZuswTSfWUrS/FMj4XzyiTTzetY7iqMdHNllA==
X-Received: by 2002:a17:907:7f0d:b0:b80:12f5:f6aa with SMTP id
 a640c23a62f3a-b803722927amr1828048466b.56.1766513688079; 
 Tue, 23 Dec 2025 10:14:48 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037f3e271sm1495302566b.60.2025.12.23.10.14.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 10:14:47 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v6 15/18] ethdev: avoid possible overflow in xstat names
Date: Tue, 23 Dec 2025 10:13:13 -0800
Message-ID: <20251223181418.40834-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251223181418.40834-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251223181418.40834-1-stephen@networkplumber.org>
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

