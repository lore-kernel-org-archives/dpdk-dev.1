Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3217DD30CC1
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 20:25:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8517240A77;
	Tue, 13 Jan 2026 21:24:04 +0100 (CET)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43]) by mails.dpdk.org (Postfix) with ESMTP id D9BB640A76
 for <dev@dpdk.org>; Tue, 13 Jan 2026 21:24:02 +0100 (CET)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-b86ed375d37so472811566b.3
 for <dev@dpdk.org>; Tue, 13 Jan 2026 12:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768335842;
 x=1768940642; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ckPcxqjACKxECZIs8TWH87xa+KWpqiOYhGfkjwzJf+A=;
 b=x1/gi12iMx5JJh1NXH1gKrqM28Jlrud0l3dSXCRQzkDCIbdO3AQFFkwNi8C8U2Tg4E
 l7GYShbLntWZo0nZomwFAhY2YW040OMsOeZMYXxEJaORXC03aFPILcN90OI3nDc169V3
 bLs2om9QzQ3RkwlIHhiDbloNziMv/1wwhFHrgKhT4Jwn/4kxlyfh5/Y9kzJ2C4nS4lj4
 fvZhY5BO9IuhdOKjmutqSJUCv4QLYiSheAstwqL4LFvG+t32xdmM20BbCNXJY0vxpvUj
 gFWYI8Na8HJ/UHZ++MaCjoI/yBNEWj+cGxRPW/fd6uvqzqOgL+S8mKKUuJkNrCAlHSgY
 niRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768335842; x=1768940642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ckPcxqjACKxECZIs8TWH87xa+KWpqiOYhGfkjwzJf+A=;
 b=BfDw4osVweIFV1FCXL2mdEkuPhvZE56U8sqpBnSFtirUI6IRZD9+1BsV0SPWB/bUji
 mYtbqw71GMoUgWeNuueReVie3p/Hidfx8FkPSD5xYecviIuuGsSZMLXXiD3o8VkQVecq
 e9Q835lrqBNjrluL00Do7jAZCX8saOVqUmiiRD3geMU3KOoxpLLyHwl4EZrgCbgQMq/v
 00gWlS2hqRffBSo5xG6RGZ73hkm1W4ixvA9VC8NLj4FuS046woNr9+CRR1C0gHLyl8Wf
 7miRs1Z7GKa+rSdbkm+MWmzIHd3fW33zI9u4h1M+DE4oIjTzElHaNEWxcbT7ckZjuQpJ
 uUGQ==
X-Gm-Message-State: AOJu0YznHG9pZvOqQ55Rbxu00RT5eh9QB7u+1PpmsuODHgsaCiPqImKS
 cfuPzKxbAZB0nckUjmcQfhcI4EaTFBCjLugQr0Pll6OnlpcwPmMdC2M2navq0n+eHxjCcstNhoS
 23ZXl
X-Gm-Gg: AY/fxX60NH4Dp77oUMXSyN10pvMA2URXsl4/n3R87LQ9hvA8sV0oiaOGsVO6kcyG5sa
 apfeAU41pvKJYQuV05UZk5dmzN0MfxlNvb4iIBHB7AdxrWGniRbOXQ8JN/05wG8fI/TCAURkzQb
 IofAVF1pAJ/BA0VtiUSEcFkdpJh1i8BUac+Wdq4+ZIg302PHhUXP4omTAXFh+7xfI7eJQpwutpE
 XfcaaX+Dg3nk98ZLsgvw7x7/YuH6r69dqd5xHBy00Zqbqa4Mp/QBZzZIshAewJPuZRY+EI/bwcQ
 YJlavR0PEk8M6G/is4xMQkv2HJih0AX40P4etL01xbpJISI8QxzHmWDfv+byF/y63UTRFaRrNtB
 QAu8vuLxhtR6y6V3WNiyWzLwyEFYkSKwchwkDS4kTHUwRRHlCh9HlIozgIs92qdyXm5qn6nJtoy
 jIY+HxBSHA30x2NELxKf1+/q3HBv+SCMQfoHtGkWvcelxfSKMY7w==
X-Received: by 2002:a17:907:1c18:b0:b87:2780:1b34 with SMTP id
 a640c23a62f3a-b8761293ffbmr26469766b.61.1768335842306; 
 Tue, 13 Jan 2026 12:24:02 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a23433asm2314992166b.3.2026.01.13.12.24.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 12:24:01 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v10 15/18] ethdev: avoid possible overflow in xstat names
Date: Tue, 13 Jan 2026 12:21:54 -0800
Message-ID: <20260113202329.35190-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113202329.35190-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260113202329.35190-1-stephen@networkplumber.org>
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

