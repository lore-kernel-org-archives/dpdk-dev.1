Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45260D37497
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 20:17:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5676D40684;
	Fri,  5 Dec 2025 21:16:11 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 4028D40696
 for <dev@dpdk.org>; Fri,  5 Dec 2025 21:16:10 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-47798ded6fcso20120525e9.1
 for <dev@dpdk.org>; Fri, 05 Dec 2025 12:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764965770;
 x=1765570570; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ckPcxqjACKxECZIs8TWH87xa+KWpqiOYhGfkjwzJf+A=;
 b=xuyrQAIunao0tEPnhFQAhtQhE13IQmhMPH/AV5qgqxwn2MqlHE0lz5hwZPipbTHMds
 iecHWJ3TAaqY7LGIMFglPZaYGriG4Jk+cnZR57ZR+jmdn+K7LVz/R/ePv7d+OH8C8cOf
 IOArduRTezjeFt6j6TenwoFNfCoTr5spjQ5HFuZCPHbiY1N5jUyGRBmtYFSIVsEyToXQ
 TFvhR2ZSZkj8JhqUOxwecUblKKBk+zn/5v1lpGVv5rwDsj9o7DBEraG9Jv6vZIXtGlW1
 1dkvQcLYQc13DnWF4n4f93Bk5ythtukLFECgIeVbpGzD00+LIxwbPw/od9KuDfmkVIzN
 Ujjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764965770; x=1765570570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ckPcxqjACKxECZIs8TWH87xa+KWpqiOYhGfkjwzJf+A=;
 b=dLMWzL3bx+DF4LrpMaJT3La0Mi9eAj1tHa0TNkViVIlVNSVvr7uQ3ekB/v+DKCoNEI
 h59aXH2DN67NfAlXbUKXleUrGx3TuBKUI7q3/keFuWD/Po0BOZZdeHhvQ2dlhBRP6PYI
 TGBKMowq2ZH8ZUTf8spMZhslXdmQLAOb2OGPmhCAC8D2ThlF/jfKksLG9u3Zf+eewome
 9IA7OI9FAawpmpb8PFBSLr9Igw2UjbpJOUGr7kszu+PNB5dm2OkF4oGzWmlxmzhMaDkx
 DDUzrIdnuC3iI4JCo4p/2Oy39VnzMDbCKvmZ8PRZtnE5R6zOVXgQ7/cqUoOPQTLEe7F0
 bHkw==
X-Gm-Message-State: AOJu0YwjMoqkI6gS7vPCvrh50DYTtszCfkhjPwWUGcPXhN566ml2E+YB
 IiWUjQyKRpWGZP2lDDXZaZ9kPYwwOad7yuSeUJYjx6hbRqlEiSffVTbnlZ2j4DypIg9gcXLiiLW
 Lsfb6
X-Gm-Gg: ASbGncs1fixFe8NHVziNkvHuChtlZH6HXLm8DI9h8W/m9DDStZ16I2mLDcy1h5ajCDP
 cu8zZLSaK12N6UI5zXjiHBS89CJyJHHnH/X7CC4FXT8FRvZxE5M6LwhXg/+aI0czLXpNud2jXtC
 Htw/Ah9Fsmo7o+gg48Tx+UTRKZKjEHfMXOzQbTtvOJOzfaWQVak/bmiW/r2b8OgMpQEXdkR/p83
 JOlOPj+/ORPFv7BeSy/9gr1ZdNMGMOwB39e+aP/brBo0fZo9EMqEkWj9Du9kOV8wWVzS+SWsN1J
 Le5wsYYm4QCA8qtq9Un9q/QDtV12EskSsHdZfzfuG/6Is8cw1bFUWxPX3dUwqrAOYLAvb2IR55u
 ykHbh9w14CRt9xBTXT/0RO+boZwfiSIvToc48otzhrDDQw9xi17dlJMPla9jVhJpwETiI7/slWQ
 b2jkVzOXnZ1voUQ7oo7zFl2g3/rpahOlFZOk9J8O3S7gxh9U5ULw==
X-Google-Smtp-Source: AGHT+IFbRrT/zYIT2UIgCWY+ChZ4LLOBAxVLbtLXcbLjzhWYf2vIw79+jGo74HvVgbGjtH/wTWfN8Q==
X-Received: by 2002:a05:600c:3485:b0:46e:37fc:def0 with SMTP id
 5b1f17b1804b1-47939df4a05mr5399435e9.9.1764965769870; 
 Fri, 05 Dec 2025 12:16:09 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47935fce542sm45344875e9.0.2025.12.05.12.16.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 12:16:09 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v3 14/16] ethdev: avoid possible overflow in xstat names
Date: Fri,  5 Dec 2025 12:11:43 -0800
Message-ID: <20251205201537.251131-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251205201537.251131-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251205201537.251131-1-stephen@networkplumber.org>
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

