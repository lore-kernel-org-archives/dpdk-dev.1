Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC229E63CBF
	for <dpdk-dev@archiver.kernel.org>; Sun, 25 Jan 2026 19:24:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D5B940676;
	Sun, 25 Jan 2026 20:23:39 +0100 (CET)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id 7EE3F4042F
 for <dev@dpdk.org>; Sun, 25 Jan 2026 20:23:31 +0100 (CET)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-4359a316d89so2893278f8f.0
 for <dev@dpdk.org>; Sun, 25 Jan 2026 11:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769369011;
 x=1769973811; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vhk6YnkEccqBjh4aMQ8WgnJWncfi9k6hYjEpLubrXAw=;
 b=r/IYq1ik6d+6ZgAN3oVDgr/HrXn0tMDqRGMlJdPLzPooEjoiVfZWo4Ubko3VoJoWzB
 4fPYfttk0qs8u2OLWkS8RleAYpfN5Ct6wSYMjppRciPS6dGLBSM0ePR87+fpCk9c2C3W
 mNmPR80f2pFI4CVCCw9xXVLdYFl9kymPa7DZqX2yC4WoGK8Fbn9cdgf01kePcg91StxJ
 ERwqLajXJzAqwDixGipDDExpvyt+7lAUNNzdAx3W60QxCr4cIchl8CKTBeKBCPY8CTx7
 2e9M0EK8oZHnxJFelnmyi2B/eGJi/jHs8XaxBKpSh+XKM6WRHS1nzRyXkMuNId3BeDfR
 ggIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769369011; x=1769973811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Vhk6YnkEccqBjh4aMQ8WgnJWncfi9k6hYjEpLubrXAw=;
 b=s9wS8rH56hH3p9ilxR8LCSxF0t4vVAMo1m3GO4pvf9OJcQWxUtXLvRt/jbAbi5z+eZ
 fIWkmkOqo3cnSYXOYlY+6+FhBlRHQrSSZoWvVQnnND0iuILte6bEe6nSAxn37cHV7z5d
 1Dd5R8Pnpi+wy0ZtLj4LuSPda7Z2Wb6JLQnEfSqzylNXI2ocqySmlAUcf6kLyOLG6IfA
 ZNmfvuFv2EScJ8EIaWMtyr7fPWCwnQrhosIwol0vOaRMtQAvICuwOVAmCuWwlrg2zqtB
 f+bPadWyrnUfrBHs2d1A3HnfMe3N/D42sSV5vU9gz50uTciPVpMwhp4gH4YXLU0pLoZ4
 Mzrg==
X-Gm-Message-State: AOJu0YyQVafjg15o3TVIPBJi66S1zQ+5/F0vna9gBtlnezaFwKm4qf6f
 NgtF+qGJPjgH0VdiMKeg9o+kNPGFHtwbKSBFhNEjTi1hXLIghSe2usWHQQPdIZm7nMgR/Yfu1mw
 IIiz2
X-Gm-Gg: AZuq6aIHXfABdeSQTEL1yVH2VPF1TcjqBOv3YCiOLp30pLXSuDVh/QWAPBli1xcXVhe
 kXxdIq/uafm8raDXzcf9G9K4QngiJJjeUGdZoNRI+y0KiuBLm9jKD8zic06HTedSnvtDRo05t1G
 Yc/M80GiRTA411QRspWKePtF1b8pTPufhrx8HR5NgM5FGzjp4K72fGQKyYaU97CSGlhxy3+zE4c
 7eriITep+eFNKjK7MDc+f4kRASPA0jbIsFoy+re4/Ry6Fbe2JOVemh8v+vdnIRl0IHTdglNsfLc
 MBh+pcNPrS0bHbMprb5yKhBZ9i5Vifn3MYCWB+drYd8V9clqL8NtZyOJ8Cp7+Gw1Wy/HAileQ5T
 1QILhaGy/tbEUCzZBIRjq+qHYck09FY6NFXQm+cQI33khtDlLh0SvT+HHzcmGvA1MUwiNJh3/Qn
 4lAzjAfNaxWNi5xI8/tuTJeXoBssmEi2Jsjtbvk9wGDje1LLPa40yP4tassN5f
X-Received: by 2002:a05:6000:2481:b0:430:f7dc:7e96 with SMTP id
 ffacd0b85a97d-435ca139175mr3750105f8f.48.1769369010989; 
 Sun, 25 Jan 2026 11:23:30 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f7b4d8sm22854362f8f.38.2026.01.25.11.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 11:23:30 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 12/13] net/pcap: avoid use of volatile
Date: Sun, 25 Jan 2026 11:20:10 -0800
Message-ID: <20260125192248.497563-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260125192248.497563-2-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260125192248.497563-2-stephen@networkplumber.org>
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
index c79b00332e..55cea14045 100644
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
@@ -849,11 +849,11 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
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

