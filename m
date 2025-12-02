Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60133D1171E
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Dec 2025 17:27:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1489840615;
	Tue,  2 Dec 2025 18:26:40 +0100 (CET)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by mails.dpdk.org (Postfix) with ESMTP id 2A68D4065D
 for <dev@dpdk.org>; Tue,  2 Dec 2025 18:26:38 +0100 (CET)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-8b2aa1ae006so730106885a.2
 for <dev@dpdk.org>; Tue, 02 Dec 2025 09:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764696397;
 x=1765301197; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DZWex84WzlSrpAPyfQFIfY+ukmVMYVguOW3PG5erBis=;
 b=um1jPhozA/hAavv2FoBiBjg9qAJ8NS84Lm9GB/9D/mpMAqwF9c6/eHWBapUp+vm70K
 b+0fca3hOJ18Tjt8WNbux1POr1WLgM+ChJa9AL8eFIoj/Rrt9UahGDAg9Mv1/e48fQWE
 Mqvy2O04/a/J/N60rBHtcat14BIZ5SUmpK3Fh/x9dzdCP8fwFfZA0bg38kP/lMwqAkuT
 MVyG1DeRLLUXg5exOoGz2U0j+lLQaFzN6CNy2X1wBMrIJUMNpgCJgDkES9ytBh6HZFfQ
 FwZxasdJRJBYka/8N2lutwu7CqsftqOqpPZVY79OCBa+C41G+c90rrutm9qF14l3HXlx
 KpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764696397; x=1765301197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DZWex84WzlSrpAPyfQFIfY+ukmVMYVguOW3PG5erBis=;
 b=mvRuI8jqVxTIiEWtLzYW2BZvDWL9kiK3Qwhneur0Q2mzjPna1U9CwfI60GUPjBVSo6
 UxbjAe2X2+OdI6NAbPSoIHzOFb0dGE+ZhINGxjj8dcPzOmB0TwOAO9oYQQidYQRR2L8t
 yulHm67QRJONA4S35Ruu2upPHU9/70PFTYWbM3CuvDCnTPwYBb0YR8GVBSx2ag+r2a3N
 M9wl0ba9nUknaAcIMyNMwoHT6toC/obnjCQ4nL2s85WjzjaF6SqnS6xqoxNLma4pUozp
 Un/Jebufkul+kOqmjrbAZr1miPovSNQrkB9j8lTCWBGXhZTLTUv/qFzJ4v/6+iNOgVj3
 Wajg==
X-Gm-Message-State: AOJu0YzTj7YrWF53QxZo2+LqCiBPZoCr28M+CTUXTKbLlKsC9iHtxB6H
 s9XGR0Gh7B+MTMekFLSkeJIoaJUTwyIEl+qcyf/kRnpGeJbJe2JyXLS3EV96Lh94S83IppJ9IeQ
 7oH1N
X-Gm-Gg: ASbGncvgv+TKns1fzn/Xn1ib8LjfgjH7TD3cBJZJq5z+p9JxuQi6zAn3lygV6lmSjQ6
 tIUQzbp2rbvaYoEzD7RfHmptOaHIcmAX1QhvvUzhgKefAjoujGFyhTTD20v+KcdY5Ct96sATX+G
 gnlHo0DIZAvieBgTFqFpx81CyPUBIFHXkRZerfGIblLO61Pc17IPi5aiRlH9XaDUBgtXmEhCLA5
 91Eb9dUxT7KjEfALqBBtOjatgQ2RfFUSTSTU/Co0v6dcu8rkdtj0iQWMqDcrqs430FouDkFU6+J
 N+QRIWHHt383LXNA+WElyuA7Hl3KQV0A9679iNxq5SDQcwE76ftkgBHTOqNocs7Aqv9+r4SQvKx
 PyMt3susWXjNOIGmz82idxf4iFtS7OM4mIYAfg6MX15Ku1VkN92Xli8L7LBF7Q5pbVFHhnDCnaj
 uSWgKq4WgeoacygyAFKigDt08+RkUqtDf7XQJWBuxQBd/mnRGwGQ==
X-Google-Smtp-Source: AGHT+IH1AhaYYDgB3HHLP6IbkcOD6FJBkIURAlNwomC7Dcd9O0eIyz1qS4GudhOUl83T6RuFtZfhNg==
X-Received: by 2002:a05:620a:2a06:b0:8b2:6443:8401 with SMTP id
 af79cd13be357-8b5d342881cmr18517585a.76.1764696397425; 
 Tue, 02 Dec 2025 09:26:37 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b52a1c8405sm1113724885a.38.2025.12.02.09.26.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 09:26:37 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [RFC 5/8] ethdev: avoid possible overflow in xstat names
Date: Tue,  2 Dec 2025 09:24:31 -0800
Message-ID: <20251202172626.283094-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251202172626.283094-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
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
Add a condition that will not happen to warn if it ever does;
maybe some day a new long named queue stat could be added.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ethdev/rte_ethdev.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index c6fe0d5165..5bd3fbc0bc 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -3501,10 +3501,16 @@ eth_basic_stats_get_names(struct rte_eth_dev *dev,
 	num_q = RTE_MIN(dev->data->nb_rx_queues, RTE_ETHDEV_QUEUE_STAT_CNTRS);
 	for (id_queue = 0; id_queue < num_q; id_queue++) {
 		for (idx = 0; idx < RTE_NB_RXQ_STATS; idx++) {
-			snprintf(xstats_names[cnt_used_entries].name,
-				sizeof(xstats_names[0].name),
-				"rx_q%u_%s",
-				id_queue, eth_dev_rxq_stats_strings[idx].name);
+			unsigned int cc;
+
+			cc = snprintf(xstats_names[cnt_used_entries].name, sizeof(xstats_names[0].name),
+				      "rx_q%u_%s",
+				      id_queue, eth_dev_rxq_stats_strings[idx].name);
+
+			/* could only happen if a long string was added to eth_dev_rxq_stats_strings */
+			if (cc >= sizeof(xstats_names[0].name))
+				RTE_ETHDEV_LOG_LINE(ERR, "truncated rxq stat string '%s'",
+						    eth_dev_rxq_stats_strings[idx].name);
 			cnt_used_entries++;
 		}
 
@@ -3512,10 +3518,15 @@ eth_basic_stats_get_names(struct rte_eth_dev *dev,
 	num_q = RTE_MIN(dev->data->nb_tx_queues, RTE_ETHDEV_QUEUE_STAT_CNTRS);
 	for (id_queue = 0; id_queue < num_q; id_queue++) {
 		for (idx = 0; idx < RTE_NB_TXQ_STATS; idx++) {
-			snprintf(xstats_names[cnt_used_entries].name,
-				sizeof(xstats_names[0].name),
-				"tx_q%u_%s",
-				id_queue, eth_dev_txq_stats_strings[idx].name);
+			unsigned int cc;
+
+			cc = snprintf(xstats_names[cnt_used_entries].name, sizeof(xstats_names[0].name),
+				      "tx_q%u_%s",
+				      id_queue, eth_dev_txq_stats_strings[idx].name);
+			/* could only happen if a long string was added to eth_dev_rxq_stats_strings */
+			if (cc >= sizeof(xstats_names[0].name))
+				RTE_ETHDEV_LOG_LINE(ERR, "truncated txq stat string '%s'",
+						    eth_dev_txq_stats_strings[idx].name);
 			cnt_used_entries++;
 		}
 	}
-- 
2.51.0

