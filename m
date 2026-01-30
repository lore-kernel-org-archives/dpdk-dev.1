Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7896EE6BF31
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 17:35:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0604440274;
	Fri, 30 Jan 2026 18:35:15 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 2EC0740664
 for <dev@dpdk.org>; Fri, 30 Jan 2026 18:35:07 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-47ee3a63300so24881225e9.2
 for <dev@dpdk.org>; Fri, 30 Jan 2026 09:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769794507;
 x=1770399307; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ovUkmYF0+OUHl2I5Pg4pp/WyHvAQiZvf6VaBNC2OLOo=;
 b=L+C9oBeREXtIaeQlolJE0Dq8Lc2l/PwSKmbhi2l2QLHPw88GAXPlvOudcjlA7YpGv4
 qX9aqyCaZS7UBa6B94I5FijT5yNnDWmUpkgarcKItD/YkZqBMXyCPXWM4Ks9230DdCrq
 8BigWYIbXzzOCxX6ygNpXiRsjgpl7hzfRjOwOjhvwGviPRZq1cZb7x3+QqYIutrpcmmS
 gB/2jpGnBTEGPFFrtQuTraLBh9o09IokLpB5bnuxueg/Gj/7xGhPRNbNufyFtRGg4wUi
 oVaD4MkrdGpwVq1p8gOywCOH/wiZiHSxYIDdkeiAGRN21NJBw3dtZouqqs2MTrqgvbLX
 DRew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769794507; x=1770399307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ovUkmYF0+OUHl2I5Pg4pp/WyHvAQiZvf6VaBNC2OLOo=;
 b=IDAvfaIktJJGNYE+xjF7NRgHqZyfLOXFbpYZ66ZJWEodeU1q5yipJwo5oKgcdo0FQL
 0N079/MLkd0w4EdYnUWHpNZaMvGavfT0Ft1bgGHTRrJPISLNVghfmcj9GfFwny0tUFrO
 MX2hAM4gsIBHRfVOmTG2t5geY/ECrbEkHdiZILg1r5lfJwCVMGSQDppZxIOx8QNaPM79
 2rvPLatkjsl7DR/33V9VTP2HoPH8fOQ8FS2S3DUYxdFeDGAUsUYhdv48+R5vKCaB//A5
 QPmmXi9GvrWaTlxxDPlu02VAinHjsNEKg5Y1PnDsQzxBX6k+U50n5SSbUPJmlkkZp8xr
 9FKA==
X-Gm-Message-State: AOJu0YyqnX8yfZneDCB1XULmcI2kIi8pHmthjrcCsLoHq5rFgz1d1P0p
 IoJKfBqr3c1NW6xdTE62E9V6pl1TDkwbFKhrgVPDjK0Iu5CfEB3TXC8hysK6Z7zey0rZ7e82VM9
 VQy3c
X-Gm-Gg: AZuq6aK7x8Aq+xfCgEqPWRexPYdMi7xeEcJlWj9ZefIUn5jgQAkJ3ibhrZIi61/XPC9
 huc/h/hW7NwMaHKssGna0BFCHQEtrvxVBMWl58seIChin9sZm54cjw8hQgwy44zSxKr9/5EouLK
 XaT3Gr7SpIl/5wdIRuJVHVtakCZg6Bt6UJ223OKq6SRdqwU1AOR1EaShWf2D7L6wULe/v67AsLm
 58AnE1fQOslcFqIx6F/9Bp9JgxId+jwSaVe+5NkSqmQUF4hn9cwQwitfieNJIpWsMF5mh6EozjZ
 2a2Cp46qWfKXBaWKpBdweqRCOwzfb23gfrsuL0WDNGIN8PDUvARUAMUgJ05yHus18f8unam14gm
 qtve7TGX0++5kfIJEd9PZsacLzScBAqwZi85PnXTAvJnT0YcIfwlHi+vNzDxl0fitnSui/5dXCf
 n4Yc2IKUywExAwVR6Gl3bgD45E1rX9ssv22eJo9oWiW2wwCL8J6Q==
X-Received: by 2002:a05:600c:4443:b0:477:7c7d:d9b2 with SMTP id
 5b1f17b1804b1-482db4a1030mr44601255e9.32.1769794506508; 
 Fri, 30 Jan 2026 09:35:06 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce56490sm201085325e9.12.2026.01.30.09.35.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 09:35:06 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v11 06/19] net/pcap: use bulk free
Date: Fri, 30 Jan 2026 09:33:19 -0800
Message-ID: <20260130173447.14546-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130173447.14546-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260130173447.14546-1-stephen@networkplumber.org>
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

Using function rte_pktmbuf_free_bulk is marginally faster here.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 806451dc99..61ba50e356 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -423,8 +423,8 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 		num_tx++;
 		tx_bytes += caplen;
-		rte_pktmbuf_free(mbuf);
 	}
+	rte_pktmbuf_free_bulk(bufs, nb_pkts);
 
 	/*
 	 * Since there's no place to hook a callback when the forwarding
@@ -449,13 +449,10 @@ eth_tx_drop(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	uint32_t tx_bytes = 0;
 	struct pcap_tx_queue *tx_queue = queue;
 
-	if (unlikely(nb_pkts == 0))
-		return 0;
-
-	for (i = 0; i < nb_pkts; i++) {
+	for (i = 0; i < nb_pkts; i++)
 		tx_bytes += bufs[i]->pkt_len;
-		rte_pktmbuf_free(bufs[i]);
-	}
+
+	rte_pktmbuf_free_bulk(bufs, nb_pkts);
 
 	tx_queue->tx_stat.pkts += nb_pkts;
 	tx_queue->tx_stat.bytes += tx_bytes;
@@ -494,7 +491,6 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			PMD_LOG(ERR,
 				"Dropping multi segment PCAP packet. Size (%zd) > max size (%zd).",
 				len, sizeof(temp_data));
-			rte_pktmbuf_free(mbuf);
 			continue;
 		}
 
@@ -508,9 +504,10 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			break;
 		num_tx++;
 		tx_bytes += len;
-		rte_pktmbuf_free(mbuf);
 	}
 
+	rte_pktmbuf_free_bulk(bufs, nb_pkts);
+
 	tx_queue->tx_stat.pkts += num_tx;
 	tx_queue->tx_stat.bytes += tx_bytes;
 	tx_queue->tx_stat.err_pkts += i - num_tx;
-- 
2.51.0

