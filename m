Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85CFECD6EE
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 22:22:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 745C64067E;
	Wed, 11 Feb 2026 23:22:07 +0100 (CET)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id 0621340653
 for <dev@dpdk.org>; Wed, 11 Feb 2026 23:22:05 +0100 (CET)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-43626796202so2152184f8f.3
 for <dev@dpdk.org>; Wed, 11 Feb 2026 14:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770848524;
 x=1771453324; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CBjDWjnRdLIijcCxUNOc1Iv7RFTykEvhFte3iDRitIA=;
 b=AOqFgPtlJOGX8kctWSPNvvTb5aTUJ+V+rxuXsQ3jswjgBerW54iNxwxF5JkdLDaLLB
 m6WLwN7j2W4VvER8EEwc/fsfkzBqCVqwIOAxnyrX4soG5Dl0mQW+a768sR07z6Olejri
 cTQD+foGKRB5UtIx+dTm6I6NUBpmGFSxPWjeB+ZmaC32LkQCJ9cOjKEWO6GDR1w6ArUe
 RSZ2CiILyNLT6Vyqi+TBbFQ3Ifdjt/v1eSQ1rIVBdZ9idK4nIB0+stpwuY4YoeiVHsta
 VynSc9K0fsPZhy/hiPAT/1ZgMthtnZt7ZgyIXyF+IQIESwSO6SiwkwU3KUJDghTx79tp
 mVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770848524; x=1771453324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CBjDWjnRdLIijcCxUNOc1Iv7RFTykEvhFte3iDRitIA=;
 b=g3GEXoFbXEyndMq/5n3/TmQx6odQMy3wJF3WacWxBsJgz5GbNjCsPoyAJHYPp/0zdL
 a8ivgRNx8EqcWDaa//SIRW9JZTVaP3w/0TvML12QRUjQzv5R8iGBgKpO9Bu74aZPJiZ8
 6+Yg1KzbQyStApuaU3Fy2ru3wJ7RRDBmGDMcM7G7Sku5dpDjWMZ7GRRFaVeWVQ3pWKEN
 7faViRDZjsrudShS/7Ad0NMUNA8uGfvA0t7ed4lU9df7PKY/dy4NN6LBrhOrKL4a6/e5
 p0mgW4deb+AEx1PMnORdPVgghvr+al3yonKE3Mi+RPrs7hc6dFz3vL+G8cWESbPgj55I
 fMJw==
X-Gm-Message-State: AOJu0YxIKPlW/zQz4DQwUy3xoiNv0MOKt5TAAUYPKTW3j2kmspNa3+ek
 Gmdp6+f0ba1jLREsrYyGJpMETj0esGb2F0LssXEKGao8OZAC5Jaceo19kUMGam+6/LdKiXQCzVP
 LuD8P
X-Gm-Gg: AZuq6aIUZFckgoHtvGsCRKq0YrU3BfOeje/SsY3QkTJc06bfIWbbSoHAIMGMJwQ1235
 +TRD1E/+ebkl54Nqfk8YCBctd7p/Mixeo/ZGwXJX5e46FEwzZlJ+rZpPtV22+pDbBcIITVyaCgs
 2y7o/fM+PVGJp0wlFD7aSxY/gK+1VQXz8wbXBgr74RUGWKpRThy3fU0BfxyGIhzVmHQG2kbltsW
 MdGfJ/7zcXkQY+VRGqnsfU+QPyiUx3gtooekJzCvTsh7SFtQyPyHJ9AbX8pXjzCeGd5m8C/YoLK
 KxmtAM59+heu3XaunbuikdGOmFqaDkgzO9BfpRXQQXXsICDqTzx4DY630Z5SEn4HqqitsdgtdRe
 StFGR9PPGBpVrCnz8YSwGS641NG6FMw5AJhOTmUoIjoR8MENwupXfCMBMCi7U5C8z9OkZl3PKYt
 IZxlmDqRji+D4e8enVxTpwZjjcZG1HEvNNLQXHXheV5OCvAo8DGwWbcw6g16qzvg==
X-Received: by 2002:a5d:5848:0:b0:436:32e9:993f with SMTP id
 ffacd0b85a97d-4378f1287bbmr304082f8f.3.1770848524627; 
 Wed, 11 Feb 2026 14:22:04 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783e0196bsm7877965f8f.23.2026.02.11.14.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 14:22:03 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v14 13/18] net/pcap: avoid use of volatile
Date: Wed, 11 Feb 2026 13:09:46 -0800
Message-ID: <20260211222130.338797-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211222130.338797-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260211222130.338797-1-stephen@networkplumber.org>
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
index 89c1eac8d2..d4f8811572 100644
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
@@ -928,11 +928,11 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
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

