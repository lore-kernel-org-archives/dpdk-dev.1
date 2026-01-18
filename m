Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5CAC9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 17:00:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BDDBC40DCB;
	Sun, 18 Jan 2026 18:00:10 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id 7153F40A70
 for <dev@dpdk.org>; Sun, 18 Jan 2026 18:00:07 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4801d7c72a5so16144065e9.0
 for <dev@dpdk.org>; Sun, 18 Jan 2026 09:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768755607;
 x=1769360407; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QKKQhTEcBC9tY5zXMNoweEKyFNpq8XA+2/D8v8TVIpM=;
 b=2nikk8zf9toStpN5S/qlHdHbUTVc7UO2IQnwk2tsD+xqGu4nLUU2FRb/H25dc4Fq2a
 1YeXMh36bhHojKn3BmzGdhadWsWougpnDosQRX2VLEBic4CXyM23mezQ06LocjD0eejY
 9Hp03TGWCZFGKsZxywUtS2bb/WcHyXFsaMy6d1CHPwZxM5wnhVIu5WOZiJIDH4spauhC
 2/fsMd9S/LfgxiNR3/Y2hEi+j9ffOhchM+zqtxBVG304MIbB8FZE/5dcSy87fvb1Lond
 dgSr3Ahg64FS0tI50OK0R7oCJVHJ7EruvvFlL3TDiF0L+C9FoIoqv2OJDXPaK8V5v7Bs
 uRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768755607; x=1769360407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QKKQhTEcBC9tY5zXMNoweEKyFNpq8XA+2/D8v8TVIpM=;
 b=Mwmk2H/hIfi3iVnE3PH2f9hEZj2XBGtkP0tES3Axhzhhv+W+63u5y6Y9u9iMXF7bKV
 zE00HVpEoxqa+q3Ak4xKW98MWjhxP2qTHfzc0L4xbUAhqwmI5OaYFT0JB9GxMAS6ui8k
 ytIb00qdek07zNoDXpBXg2DFRDq7HIzttLkBtCgEWM+rsy/lCnCX1hiUasC0ft+d9VQe
 Q7cKAdUXnwky1XPGSBVQi1qkbl9ltXrFmMOgOEZt9zDOM4Lt/5v8uYhZvdYK1ymX61hh
 RpCUmhpNFCMbhYNnjX6aHz8Ms43gA1vaYoxR11xZ/09Im5K1vyEO3t/r/GR1qiJFjCzf
 ocFw==
X-Gm-Message-State: AOJu0Yxv7Kw0hb0wNH9dqOjfHJ3yA5/yVPgBM689xj6RK66o1+UNwYr/
 y/wB/1xuA9XArAWa7Jx8oZQydJHy3i8LdStssFDf10FhgM4xA5SRS6fLyH6+GLdyDeqfZzIu0cB
 HBzpJ
X-Gm-Gg: AY/fxX7X3Ug1HNbDKjcTRNtjQmFjzPp9dAw3Agyu1Oh8p5kLGchO9kemmGKVMUHCQ3y
 dtlwpoPXt52TylXvMoXJJAuHXmWt6QaHEEsUNHOUKQ5HM1lDr5kjz46j3dwfJsdUMYwWyXmTaQ3
 4BNsYgRbEhjH86unlhTImy+/yt/ZsbOkfBffFD3xQAzHbo25e0HAc7q7Dr5Li9Vl49hPyRB7KX5
 n+d/C9b6nZmlvAP6JwpIMvKrtntzXpbyaPII1nbeD8R3w0hh3nuimNHtTiBDPoGO66gkSSljUIm
 T0IXwMpqwExHHxQw8mHmZoPdxbotuhU1mc1hkj2tuVzcaS7OU8lTAzW0BtbN6d98Zd0XeZIswl2
 NjP6Eh8cCPi75Yjk3FPYOmGmouPnvEfD2W8gmFNDMhKAY/5kezUqfT3YfQALDBpMg1ERPfoz7Uf
 HgoSJs51UH5AAtz5yzrBjcZqlRn5cyN+afLUbx+RV/KYSOB/+vtg==
X-Received: by 2002:a05:600c:350b:b0:47a:814c:eea1 with SMTP id
 5b1f17b1804b1-4801eb14fe5mr96849795e9.35.1768755607038; 
 Sun, 18 Jan 2026 09:00:07 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e86c1b2sm146849365e9.3.2026.01.18.09.00.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 09:00:06 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 09/11] net/pcap: avoid use of volatile
Date: Sun, 18 Jan 2026 08:58:44 -0800
Message-ID: <20260118165944.41374-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118165944.41374-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260118165944.41374-1-stephen@networkplumber.org>
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
index bc31b526a4..2a06efd0e4 100644
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
@@ -854,11 +854,11 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
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

