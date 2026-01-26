Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F176D1950F
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 18:09:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26B284069D;
	Mon, 26 Jan 2026 19:08:40 +0100 (CET)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44]) by mails.dpdk.org (Postfix) with ESMTP id 8409740649
 for <dev@dpdk.org>; Mon, 26 Jan 2026 19:08:31 +0100 (CET)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-435903c4040so2941942f8f.3
 for <dev@dpdk.org>; Mon, 26 Jan 2026 10:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769450911;
 x=1770055711; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bx7FHjqPTkQp+JYt9cMMsDZoxR4calzZY8kmGrugMtg=;
 b=dUFKQ4BILW766/1HuvB2yBajonhMDbq8XZBB6O1eF9tvahom/kXzBtOwWs4benMqof
 j01W8gBozZS9J32EDfJN403/TXGstBNVW+YlYfMJQzerqZbKNoE3gg9s48mI7Zi7TWPf
 N8w/GuWb0ftUvsaRm33taZqnC3uEoVymA2ItCLxlCWzDVAiZQCARLsC80CzH3w+6lltx
 SaC59aA70VzS3jBGCkNJxhnJEwDNf03fz8ckEMQdeMsT/WEzDwl/XgoBqK+f8c78BbRB
 CgRkFm5u43bOx4GRYtU+7LArzpFKKvpUcdkhOHDAsCRhOth+DSwxBJOp51RSkoQPkvJ4
 3wIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769450911; x=1770055711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bx7FHjqPTkQp+JYt9cMMsDZoxR4calzZY8kmGrugMtg=;
 b=qVFaSsLRA6OBncWjNyDeq2k9ClFRtq0SURhvcJ/SK7d00uasA+LDbgT2z5t/njsIje
 cF/eTZ7Q/NiM2YuPDRo+J9sZT5RvF6QFScoLjWnvkemtCw+QgSjB42lil46O/pg8cG0X
 qzjqXeXbXkZTqszybRA4kvNHlhHRQVY3xDZfFpErGGcwXXs6Ah7GvCKKcr0axI3CV3Tl
 pPjhQiOR6yzJeAX0jKC3h495mGWtFxOFMvWpgkXKBLDhPohkUwxPCNM5fOkFjNFm3LqA
 cTBsfZiednQFblvmaS+ZYKS9Pn7a8hDttDl6pzfK7q9FlhxzOCArkOonntBOdlawm5xv
 58mw==
X-Gm-Message-State: AOJu0YyrPuWWCaFxpbcn6EiIzceJyeleWnLQ/TUXaB9ATETxgVvKcmx5
 7eYl5aXvOEcW+OlkxGNh5cfHjFmoY9vBaSKV+10jnSY1Tw1GBZKNLOdY7UyNNmVGkKGsznYlJCF
 xgElA
X-Gm-Gg: AZuq6aLmWD0LCGYZJXHHN7wu23ryrDIgsu0HHiguAMLsAeLWi38iS1Ln327K4k7FoiZ
 L3ncoOjBI1+baoAHihyYT3K8eVZZmCfyAfSDKJVYtDBsM4ztzF5AomKvaAAdEI0b2v/poRVzKYy
 pxOclp2x5A4j/CgQf3IrjgyG2dr243TQ6xmqtn+rz3qcuJu42ICIY7lfeu5Cmy4njjzE7Fu+/t+
 I5X+0ABtE+kavqEq69z56xQSY2ipq6PMcXfZsHCoN19GNR+o8mlkj5ebkBCGTc7LDfrQ8IByrfZ
 djSVodn/fjW80YmLz5AzCtER0hWvAfiD1mK3O8EnqeuDZ4BT4z4pT5pdQp+ELq8Z2QEYX14Syho
 D30uvdTeTjzq3yjPx3vEUCxaYV3w0hHLdkvBqbATBqJAhwBCH0/yMIfEKNVwug+36WFZ3N8+6aX
 Csnqv38kLkf+wuD4Jl41UlbIL3qMh8hdmEBdg4hU5ZFV3Vrw4smA==
X-Received: by 2002:a5d:5d89:0:b0:432:c0e6:cfc0 with SMTP id
 ffacd0b85a97d-435ca39ba1amr8752901f8f.57.1769450911112; 
 Mon, 26 Jan 2026 10:08:31 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c02c91sm31845864f8f.9.2026.01.26.10.08.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 10:08:30 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v7 12/13] net/pcap: avoid use of volatile
Date: Mon, 26 Jan 2026 10:06:49 -0800
Message-ID: <20260126180807.100891-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126180807.100891-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260126180807.100891-1-stephen@networkplumber.org>
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
index 1670cd56cf..c960264db2 100644
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
@@ -840,11 +840,11 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
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

