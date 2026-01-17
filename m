Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07FECA5FE6
	for <dpdk-dev@archiver.kernel.org>; Sat, 17 Jan 2026 22:01:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B286142F71;
	Sat, 17 Jan 2026 23:01:02 +0100 (CET)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42]) by mails.dpdk.org (Postfix) with ESMTP id 86DDB42F67
 for <dev@dpdk.org>; Sat, 17 Jan 2026 23:01:01 +0100 (CET)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-4327778df7fso1861828f8f.3
 for <dev@dpdk.org>; Sat, 17 Jan 2026 14:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768687261;
 x=1769292061; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vWAWewT4lJEvTjagebvVseWWjjTEuBLQujJ7s86FwN4=;
 b=lmyYQDQuovGspEto4h5wL+ZHqwnIrHblSsWuJ94kZMivDxx+4LsL9IgA5s0G6Xddq9
 oQmlXqBt/I/cQFFqMXVJ5K6CPsnkm8cAawa/hUlgrPDCJc3AEdB1EQSj76GIBf4wLTqv
 HyTkIkUXXJ1BsVjorKlIZEQHLbzW5oNhdwbXAaF1yqJilIYXURLUwcqUdwz3ByzqZrJA
 wjkMQcjngjYTnhNaZ0zJuCEsRZ2WmUrqW6drkhjlvVSzP16pPmXAMFE/LMcYx2mq33+s
 Vwoj7IcLIZtqqZMDB3LPATe1ohfF17evmeMEyARG3p25m5R1WRvktQ6AHjBY0d/3rzTL
 EZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768687261; x=1769292061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vWAWewT4lJEvTjagebvVseWWjjTEuBLQujJ7s86FwN4=;
 b=dBTGkgCqx0xYW0Ubbe0XRqQfOUYORVQ6OD0cu3cIF33sLlNX50uXgD7TE9F0xa1f2F
 uL0FWL8MuVZqiHBZg1geIUQVorW/huCNyBzjy6d+fHiIQu83sfyRh6yusYiJBM6eXNx7
 dAG81VLGPefrr98C2zCHTIMBdSXYoISAG1X9WMhKpyyVA8JPqREM/pVxK6bHj78p4bHk
 oRQQu8x1OoHS3Iwdoi4dYA97y7aNlCGDIfVQfjd+n0mbu8zd4HhsKiE3H26x83z1B53j
 iDTGap81Udu4F5gmy509OArUESE13w7P8EB9DvkDJdcR4VITVFAl1VKCC2uuGXBtYWwW
 gChQ==
X-Gm-Message-State: AOJu0Yz63mHF0z4LjxKkiOL2BsdF1T8rS1sN/bYUdA502g9UojbmR1+k
 IhvPUwAn0tVAJ84tGaqVL087BkMQFYUkMtxZIIdhBE33DuKkovbQMe7Eroio8LKB0EOyvWIPalP
 YliuG
X-Gm-Gg: AY/fxX58r+4kPZn3w6lSsYXuJSXruim9vaR33Is2CZMxY063E+GobXcDXkA4mh0YWyK
 ZrjQttdlsffRq1ZQxHiO47NrUyT3nogHTxtmXAItPrEgojrCSNPxHNiUZzGZSlovstrwaukWGf1
 jtaqHdh6DK5wLUF0meqBcM7+w/yRQn9A/uFK0S3W+Dpo6B3DX8E09Le5JOSRubnHIh7Pi9l3cQB
 q869axaZFkqfJMomRBeBEwk5fBlb27r/R8SAFj+ajcZbZayd233PeFes597xP/6RdPohsSe+/ZR
 cvat0oQexvCYHphLwzy2zBb+O4h3Gj1SaHWHPgybuQ0WUVaSJHA1Ap1C95tcLZrOJC6IvFgcQZf
 H+02BC27KIb3CF3bi140HxPJ6Z1M5eW8TUzPH579dXZmxbHnp762ttp4YcTA+4Oa8+4hxPT/wFo
 YFGNEl+MP9u+8LBBQh3fz/HZu+WeSXC1s0guAxZFTZJlmWEXuKtA==
X-Received: by 2002:a05:6000:1847:b0:42b:5592:ebe6 with SMTP id
 ffacd0b85a97d-43569df48d2mr6826675f8f.0.1768687261074; 
 Sat, 17 Jan 2026 14:01:01 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356992681esm13309352f8f.11.2026.01.17.14.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Jan 2026 14:01:00 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 09/11] net/pcap: avoid use of volatile
Date: Sat, 17 Jan 2026 13:57:08 -0800
Message-ID: <20260117220030.273471-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260117220030.273471-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260117220030.273471-1-stephen@networkplumber.org>
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
index 9d4408a845..9da79378f5 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -49,10 +49,10 @@ static uint64_t timestamp_rx_dynflag;
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
@@ -855,11 +855,11 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
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

