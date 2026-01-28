Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2760AD46BEE
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 18:42:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A84D40B8F;
	Wed, 28 Jan 2026 19:42:06 +0100 (CET)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42]) by mails.dpdk.org (Postfix) with ESMTP id 2C34040672
 for <dev@dpdk.org>; Wed, 28 Jan 2026 19:41:55 +0100 (CET)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-42fb4eeb482so154142f8f.0
 for <dev@dpdk.org>; Wed, 28 Jan 2026 10:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769625715;
 x=1770230515; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q1e7yQ1CVDaoar8XhDJ6IGdY7IDYnJZsR97nHOuXg9M=;
 b=Cm1TukdZTwx0xutj7IzhEOD/+hJO0jE1k2vPThf1puN+WokEC7MuTWcFZe3lqxjepM
 5pzxHieMyWuP0codc8u5y/iJWIFfTE4DeQVGSAoKLmPnd3K9BvSZ1RqY+hd1vxCLIRNE
 sCyv08KDUAzLCFYNlQGLdUrDoS9GeDKDffmTqvO/tFIFpfVQqlFLl4p+N2hSyRLkTVCS
 sBra0ACoJjqjRqBKdv68jaw2pZHDYvVyXi2qCvgkaOvoJewK+CVymdjGHGyrnVv9oa4L
 RXq3JfCKZYcJp/YaI8k66yJN/L6bkTdF0xkfpw10KRDfYgKFCoFq+1/pm80ydM9Bo3TI
 y9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769625715; x=1770230515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q1e7yQ1CVDaoar8XhDJ6IGdY7IDYnJZsR97nHOuXg9M=;
 b=KFAlm235a5lykZj/fepfgzK1XeMnwJnAvNq/4ZgZZPkOHUpTecZ5P6NjpPWWMdKOaM
 852eF1obPVLGiXx/fUi/7CJhHj2K00Z+4K5MYMTXJNS/hJ2jUtMiNJTZVQ+N+D0eQ020
 VBO3Z5gzhNv1bGuC91ily39XwIgFz6wCdyPRmaQkHnRwcSPtLBVmeWkwvGe2NYMBGxx4
 Cjp6mnMhkigtZN5EM9Pl3wHIn/u+z5YPtckslULLAqCJeQtzfWgdXmTQAUNVO0Vt0aGq
 lrxVveqWY1LIlXhFABXArKsN4fiYL5p8ZmChKe00pnujL70h6qy5+FIK62NfjOZijSfI
 +K7g==
X-Gm-Message-State: AOJu0YwvQ+wuZ32PcwgLKwplvresvoGukk1LZgNS8x3XhucvKyz6R3Vn
 +eMOqnIcaetstv8OmHScH9hTXbaHdEfyFZKiRcV/ueeFlyCZ5YUlvCEVjuEOIJE/3JgQRHDbpT1
 QPfpD
X-Gm-Gg: AZuq6aKx9uFreVkX0IHgfEZfuZeauRzxV+tNmQPCUojJhFupLBKglALCi29dr5jLImd
 Dmbz70k4rdYXKkC3g7EMtu1AZL5P7CpMRcPTqrWvxxK0j+KU0KZ2ilBrvjMx1jedA/pfzYsTA9m
 5c8xxjJuu/w/5gPN/XGXT7zQuAaSWvnHCQc6UcHyYQsX2V+OVsQAcCK0zL7SjtXvphgflIt2BDj
 ZP5oJ1DJ3mAja6RJVqjRXbxTw56Mur0nu6zglRreAYha5Hv5haTbk1X/LPxatdSPE2a1ME+al31
 r47hlx/fKf2g5/XwxYtOW7T1ZIj6Ht4+g6ijJ4U2PCGmndCr5pfQ8nj5+r9usTqw7dPDMkObeq3
 LUpLmA1DFR1z2dGGUnnvwjLd4GlsoDh2AAf0p3d8qXw7g6r0eZbosjoOi6NV+6ln72osUikNv9K
 1W0lN8FZd0DohMD44qjLgDgpj8m9yYHiNFObaQvLPkLVD8JeTHHg==
X-Received: by 2002:a05:6000:613:b0:435:aaba:b8e9 with SMTP id
 ffacd0b85a97d-435dcf6893dmr7377988f8f.0.1769625714689; 
 Wed, 28 Jan 2026 10:41:54 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ee562sm9015430f8f.18.2026.01.28.10.41.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 10:41:54 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v9 12/15] net/pcap: avoid use of volatile
Date: Wed, 28 Jan 2026 10:40:41 -0800
Message-ID: <20260128184130.445567-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260128184130.445567-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260128184130.445567-1-stephen@networkplumber.org>
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

Using volatile for statistics is not necessary since only one
thread is allowed to operate on a queue at a time.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 8eb6356794..6380d76110 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -54,10 +54,10 @@ static uint64_t timestamp_rx_dynflag;
 static int timestamp_dynfield_offset = -1;
 
 struct queue_stat {
-	volatile unsigned long pkts;
-	volatile unsigned long bytes;
-	volatile unsigned long err_pkts;
-	volatile unsigned long rx_nombuf;
+	uint64_t pkts;
+	uint64_t bytes;
+	uint64_t err_pkts;
+	uint64_t rx_nombuf;
 };
 
 struct queue_missed_stat {
@@ -838,11 +838,11 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 	      struct eth_queue_stats *qstats)
 {
 	unsigned int i;
-	unsigned long rx_packets_total = 0, rx_bytes_total = 0;
-	unsigned long rx_missed_total = 0;
-	unsigned long rx_nombuf_total = 0, rx_err_total = 0;
-	unsigned long tx_packets_total = 0, tx_bytes_total = 0;
-	unsigned long tx_packets_err_total = 0;
+	uint64_t rx_packets_total = 0, rx_bytes_total = 0;
+	uint64_t rx_missed_total = 0;
+	uint64_t rx_nombuf_total = 0, rx_err_total = 0;
+	uint64_t tx_packets_total = 0, tx_bytes_total = 0;
+	uint64_t tx_packets_err_total = 0;
 	const struct pmd_internals *internal = dev->data->dev_private;
 
 	for (i = 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS &&
-- 
2.51.0

