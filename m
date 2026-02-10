Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241A1E94625
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 00:03:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30D8D40B90;
	Tue, 10 Feb 2026 01:02:35 +0100 (CET)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42]) by mails.dpdk.org (Postfix) with ESMTP id B04D840A77
 for <dev@dpdk.org>; Tue, 10 Feb 2026 01:02:33 +0100 (CET)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-4362507f0feso2368565f8f.0
 for <dev@dpdk.org>; Mon, 09 Feb 2026 16:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770681753;
 x=1771286553; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HC84spky+UWShWSskuhDB9qFmAA+sWRzzp+paEXlzbE=;
 b=ZFZOLq/gNqGYWoGkphYGwHmfSojUX7iPEmPrZHq1SainznKjll/ZuWeo0vBqJtT4qD
 B/zEXeWCEGCmz4hydzZ3LLcBbRC/jM44fZrp5YS3ErFLGwwWooeg2rID2EY54+X/UQDS
 lWKYPyHL9Vv4/zaMP4XsoZghMwBrgtZqhKs+w92jKbSI+BcsDoE2exqEcIOHn1nJ3En9
 AKWvI7Sm+NTnwWTYNZBavLVUTpXUE6hcB2azzUzIlcPiikUeds/LbwYc/VznUMZnAx09
 Shazsx1Q6O6uk0o1m6ZMKiSZio/fb3YQoPITYmX9hxlFGKXF1dsjP1e3OGoZ5Q8Vec/s
 dF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770681753; x=1771286553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HC84spky+UWShWSskuhDB9qFmAA+sWRzzp+paEXlzbE=;
 b=qbOmJWLmZLrcAMoeD0LQDa0FZfKUQcxINfAxuRxmH3l6V3z/0GQUNVlnnp6THZuLjF
 9En1R/vjleGcv1c2TXB6TYtpW/EJYY46LB9D8IJP9UraF1bsNJ5ytui9YBoDS5Ajmt1t
 gOifzzOsvaQbWWIUL9+LteYZRz5p1QhVawQpiJQcrexksJxW47yMr9u/JDhxgtwhb5sD
 ImNDtbHS9WIIzPjANUVFCBL7U4gvbzpX2IZARmg/V8zMprzt40GVmN/d0fS2fSlur3pn
 /t/FyNFHB8GxFsVgF2Q++Vm2DlKVIFLzWthFbmaAZZxBppZBAkOQ0x6KZj4IgaU18jpE
 efNQ==
X-Gm-Message-State: AOJu0Yylnkg2n+JRvPDq5MmkPNjkXfhQZw4v/vP5tsY4Dfxtnv0CGIBU
 K6EYgvL3SCELEFEyDXEWECNJhUWLKEDd02ryrVwCo4b2jtVGRM9RJcZSy/1l8FJ3zj/PWxTFS1p
 /1udy
X-Gm-Gg: AZuq6aKg/h11gJCTRQFFhEDfOrrtpT03i10oKGkL8xVwDhL3kvVqgDgbQ7+ChsWmMly
 upsMnXV/LxoEnyMrlFaoK0T+gPc1ki1BjV5EwIj/dF4t4jU8hXb/b46a4N8Cz6qWgLq0pCJt+d6
 GrmqCCVG5mHC2J1d1nncDqi5egodm6M6UYEBQhF+arTBM4+zAyjuqLr1hWsBLZ3rwwloZZXXVRb
 +W1SjLv+5I5l+HpO+Z5Exi4PIXfbneShSFh9eywXiIE6pFvSc4qIYdrULCxIVb7UemuTOSLZ9rX
 a+hYRH08phJe/obzTH3lsL48x+3RAt4RgmC/nq4s94xY55xoOxUGdhsu4X/HeFKJG4KTzn/Odxc
 f0L0BZ0MBHrmwG/GYr+SipxJ+jRCwYDOlw6nShYACC8KnwHZgTGuLBs6uG44c5Ud7hcp/uMzx3c
 WOQm49BMfcB+dBaiNW9MJa+qLWMU3nTDxvWuJydQPKzJp2GCTP7g==
X-Received: by 2002:a5d:5846:0:b0:436:d824:620b with SMTP id
 ffacd0b85a97d-4377a57c68amr410789f8f.39.1770681753327; 
 Mon, 09 Feb 2026 16:02:33 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436296bd211sm31529133f8f.13.2026.02.09.16.02.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 16:02:32 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v13 13/16] net/pcap: avoid use of volatile
Date: Mon,  9 Feb 2026 16:00:44 -0800
Message-ID: <20260210000201.295839-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260210000201.295839-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260210000201.295839-1-stephen@networkplumber.org>
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
index fde1f9fef2..acfee68711 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -55,10 +55,10 @@ static uint64_t timestamp_rx_dynflag;
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
@@ -913,11 +913,11 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
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

