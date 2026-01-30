Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACA1E6BF31
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 17:36:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9556840A80;
	Fri, 30 Jan 2026 18:35:47 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id AF7094067E
 for <dev@dpdk.org>; Fri, 30 Jan 2026 18:35:23 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4806d23e9f1so26638055e9.2
 for <dev@dpdk.org>; Fri, 30 Jan 2026 09:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769794523;
 x=1770399323; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pbBk96tqE/zPvaA27s6XrfOAfUs7pLICJ9EkYivSEf4=;
 b=MMTS3rlkfMvQFaqwk9wTHxBIRrxDZxBWDHzUTI8CDfsXwNbq2d1kTFa95NeZQ/tevT
 2oJuXBeR/kHwJLndjGU/CxgnLtURbr90ZZoupj9Aaj5PJBDwCG3hR4MIRHSXLT+VIJgF
 bnlGTQIwjlIL9gPbFpUxHao28cBcfk1so0KQJ68gOXdhC8b9kj0BSCW7rE6lLVWBM1zR
 5fqtE5rXBdcI7gbTBgRHOWrWq42MdyrOf0h3ewZXOMydwn0z0y77+5N0fP18N8/HKTpv
 TuqWY5owKSuDTsAWO3LybyVkbHYd8SxmVTnS+dpgMRJZ3Ne6zN/qWGGrWyC7KF8p+7Ju
 BO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769794523; x=1770399323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pbBk96tqE/zPvaA27s6XrfOAfUs7pLICJ9EkYivSEf4=;
 b=DPfvgCgcReLSHpLL+eWOgh9zw6m1bc4FzhM3jod7Kl4BZtGPEy4olqYgHG2X0dC50X
 8fs/8kR2VZqFp/PrfeAZi96248sF0mjiyuHecIIhHmlBqDnLFpon3BiMssFz9a7sCClF
 yY/dO7BMiAmQmg2YFFNid2A4XaocYy0lN+4n9fKLPzvzKz4uUszZdN/Ri0X0ZsJqkMJn
 Fs+KA3SDplSKihcYSyjISTqO7dy8pgaNa/ak3vUyDAKJhxwS6i8dHxoxmhByL3V3U8Ml
 eEsvI7F8wowN7p2dsGeIlLRKksviKpH8A9gjudRQkqlUBV5LwKkyDE1OhXZZtH1lLxmg
 G8TQ==
X-Gm-Message-State: AOJu0YyZhTVir1bPBLKUoBbn04z9t8YlL0cP4S0fUnjnoUIOC0kWuBvG
 dSfPm1WsoTTfLU7qObWm5sTEbxnjpZkCtg3SPIukYgwKsTPueGzA43kSIP8p3bTuq4a4JGH2FUB
 sVGIU
X-Gm-Gg: AZuq6aJZpfDyfV+KJVNceQ8ind7Yzi7b0W2kxKU6IRuxdmxHuA8yFiLsbWkRfvYtWeT
 4DgU4rLmFUNB561LMWbbh3DZQwBEiF9Th2QwngFyZAgs84Vx8JxfPzYFNZTJBILiCW/4r1Sh5TR
 auXv29BoE2XHLWjKqH61tF3i08Pfh3MtIv8qIgkfGAwaoP1aWHuL7BuEPMpALMG/Ms6rZ2HvZYA
 6NI3I4e/z6c0EvC4/4XBFzGU0M/NrIJK9Mp+pE0J5fBlTpF4QAYWpYt0RWQ0EszJqfaMbvPg3sw
 RZVmW4IfeNxsSSeHsF3CY2kESJljtLPZ0r/wrIsOYvmqE8aSdJwAno+FCMHJtpyTuOpTWUJVTGz
 rZMwUgo4pQe6HnYIfwJakT0Bxvt872Zo8ADAC1uLOe3qjnhK0TOKi/dDYmKNslfY7KgGbP8s9Z/
 T8AxWw9rgIkxdB3+1uMqduvfJadSRDIXAKbG04OYHD9OUB9ZGidg==
X-Received: by 2002:a05:600c:310f:b0:479:1b0f:dfff with SMTP id
 5b1f17b1804b1-482db4602f0mr44656055e9.10.1769794523308; 
 Fri, 30 Jan 2026 09:35:23 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce56490sm201085325e9.12.2026.01.30.09.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 09:35:22 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v11 16/19] net/pcap: avoid use of volatile
Date: Fri, 30 Jan 2026 09:33:29 -0800
Message-ID: <20260130173447.14546-17-stephen@networkplumber.org>
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

Using volatile for statistics is not necessary since only one
thread is allowed to operate on a queue at a time.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index e7c4f3be5f..5e72a985e4 100644
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
@@ -837,11 +837,11 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
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

