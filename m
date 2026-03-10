Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103ABFCC9AA
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 02:51:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C44FA40E0A;
	Tue, 10 Mar 2026 03:49:52 +0100 (CET)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com
 [209.85.210.49]) by mails.dpdk.org (Postfix) with ESMTP id B30B840DCF
 for <dev@dpdk.org>; Tue, 10 Mar 2026 03:49:47 +0100 (CET)
Received: by mail-ot1-f49.google.com with SMTP id
 46e09a7af769-7d74dbfe84cso966873a34.1
 for <dev@dpdk.org>; Mon, 09 Mar 2026 19:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773110987;
 x=1773715787; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aG1CyKepXEeqW4kVyyzrPlO6qLZA9IPA0s0ufpcM0HA=;
 b=TJgkLr9pX+I2LY+hOzpkKb0lPrVKG0nMtvJE6YSlEw+kC4tVoBm5MYxMhwCBonlZ5H
 AVwY5aa5eWoTKEDz6aLujc/ShkPNZbK3eh4N8vaRo60geEdrxqpV1+Wz1YR9dLLjZnkL
 K0EDJ8ft8OX8gXe2vUkByD02tDmOmgsHAmW1cJiUa/d0uy0JlaDbkv1eOtaPilzDAlBq
 cRRuHp2UWzs6Xt5fZEpoZRQa/a5zqpx43Mi6end2fqxXIqAFARVw3vgtDGizLyaiwFja
 Ae+h52fJATSd53N/CWeeFK4JbXJS2x+zm30wRbZe8ZKJqHMhQMcFy9Qqqirt3f9zBv3z
 PA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773110987; x=1773715787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aG1CyKepXEeqW4kVyyzrPlO6qLZA9IPA0s0ufpcM0HA=;
 b=mMNH6oG+NIFRWWE/uygGs87SyURptxIpWy2gtTf0EweSQMPDRjc8C5sEghvSvg5l4D
 rRiM0rERqI+NYUkiR3Hpju9+aTqmKgWOGs03pvNz0qp4gb5RPMUSbwjXQC52j5U9rfWC
 2e1zrh5e8d4P7EBsSqRhMQdJql/ffyfMFUXG4fkkyc4uyKxTm7YRCF5ebOTFZYubBRQu
 cAaeE/ra0vTHpU8dGrUfBbGchhyodLbeJKjs9IuCGtoCk+rc957nMy8bk7tGfMBT4icY
 Zu7iJxngQoAu6S9q2nJcRWs2omv7nNIjM9aU5o3qYMydFjNW87HQrBTOBAHMnx1BuYZg
 DbOA==
X-Gm-Message-State: AOJu0YzmwdAgjB8hV/i6vw0fKOhzytufFm0RtoZMiOa2M9hRA/Qr4vYP
 vLd5jboJ/ePTNBKMM7PE4nb+9g4JZnHPcv97teGau8xqiGpjj1RN6ZOP5UCuuqh4gIvamdxwMN6
 2BcV9jXk=
X-Gm-Gg: ATEYQzwm5bgaUUjw0zlqSV3U/gJaMXp7v4W7UMEX8gX46yyiSu5z4Dy4MTXsKFmSDvw
 OftLpMvM2GGCFtBz6fkc2doVTk0Xm6MJ4j1zD5hUmanU6j8VSXwZGlfcxSe2jFAd+TBhIGGUnAo
 QAb/r8SQfDv7eIxLPPEroxWRjUDLj7kuRBRNi6cX3saYoajgvwIfpIMO8f+J/2x0b3SgXNakhLX
 DEulSYAMLXWbZKdhZuBzzyW3qIAhMdv+k3MHuSZlR0RNiPkXL/TKMDAKRmp1VdZxN7XYS4p3Bg0
 6ax41fLb8Vp+A/nh3uHCiFK/On2R06KkyQO3671tg0WPRIys8RGNELbxUNeUl3UCtLq9nLxByc0
 gmGBOi1haskQJiMfvITpgeujB1kMkLFR878/9K3JzzxHa90zLBgi6LRQ8V2Gm33b8/OWSj9DVtz
 NXV0JEnHT3lOmv9SZ0GGerKPJLyxiLXvTdzLRy0rxlQ+4=
X-Received: by 2002:a05:6830:6287:b0:7cf:d9bb:63a1 with SMTP id
 46e09a7af769-7d726f391fdmr8630989a34.16.1773110987071; 
 Mon, 09 Mar 2026 19:49:47 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d728d1238csm7808572a34.15.2026.03.09.19.49.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 19:49:46 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v19 17/25] net/pcap: avoid use of volatile
Date: Mon,  9 Mar 2026 19:47:52 -0700
Message-ID: <20260310024925.476543-18-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310024925.476543-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310024925.476543-1-stephen@networkplumber.org>
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
index 8be3a59690..20e4b8e6aa 100644
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
@@ -901,11 +901,11 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
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

