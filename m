Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA560FD4F05
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 16:16:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C366D410D0;
	Tue, 10 Mar 2026 17:14:23 +0100 (CET)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com
 [209.85.210.49]) by mails.dpdk.org (Postfix) with ESMTP id 03DF640ED0
 for <dev@dpdk.org>; Tue, 10 Mar 2026 17:14:20 +0100 (CET)
Received: by mail-ot1-f49.google.com with SMTP id
 46e09a7af769-7d741f61ee5so2245363a34.1
 for <dev@dpdk.org>; Tue, 10 Mar 2026 09:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773159259;
 x=1773764059; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aG1CyKepXEeqW4kVyyzrPlO6qLZA9IPA0s0ufpcM0HA=;
 b=OEG2Cl2fWG07rfFDuumzDpQNcyA9eHx8sjwtGW0hEykqWHGqSWio3PBuMaU3n9c19s
 9GQUuG88n4NZtilYFeRwyzWwR2MYa4cG9M9FH8KAxznKN6QzHJLnxVhELptvFo+NhiQW
 75aZtC5tub9mHWnfoiDO/WAz7eSwn6yzMw1OaIdGS/GCPharB0fwCCtq/74Hxvfq0cyY
 xW2ulRzLadberHNugeWogsUShFk4N+Km25n5uBXjUjdnWVWaeC+wRSRvbHUhaeA5czFF
 N7/Nsrhd3poE22hI8rz35pgqZ8xI4L8QV1NHj84B+rOAWrqhMZMXfoMLKmvHKxmBejdO
 qdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773159259; x=1773764059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aG1CyKepXEeqW4kVyyzrPlO6qLZA9IPA0s0ufpcM0HA=;
 b=r7b5pKvaPsC2S178hcgfl3VQBauO0FU2pMpcZYuH47ymvbzmO7H/4OIKNwsUFv5nRm
 NRa4GSa8AItPsqiXdtp3BJBO4uuSAa7gRhhSKUsmTWVR93Jyl6iomO1p1ykJnwOBzKXT
 cSAnpkBdGozhrxYcctdZv2kCtrqvq7DOLyw+NAWxMAxiExTRm+RwQuc95ve9LLoEx3k9
 wnYOWto5Ryg7vKC0OUn6oo5jtWj15IeLTYi9RVAXfflQDZZCkZC1DKorI9MpWdUljT+0
 0OO1PSibCStMfmQ6sGxXq1P1oaU61/ySTqMUYPJkrUPgnKWLEeUPG6g2EuSt6nlhV1oK
 7mEg==
X-Gm-Message-State: AOJu0YwX+m3vefnBEwDIGfiwvtY6vHQtRfiNxDxlse3DcHWQTnA0A4bW
 WqAJl9RBPEDxEjniENcNQhuPEC6y7dXoswd3HkqI7LawzhGMy2p+Rec2NWn+0BIhB04OMSPHtvQ
 87Lp0rXY=
X-Gm-Gg: ATEYQzxgzTf6lDojUd4pD0lxFldXpiwpjg2sXkC63kyBI3Y3g0cvmk5oYVmFOFM8Qmy
 Tw3BcKFti7hjvoIWhXQZeVRa8Cm9d6tMExBKlUq4ZM5OKQZNJWneCvTp/AT9axIE0K64bJ+g/1x
 nzLUPMQrjUjNa9lkXWVJaSniAYFUncThPIIvFp2iPkkIobe8eT1XjHYtWDPOLpUOHYoQixAr1Zo
 mueY09zWCmvCpyxfUI6L5Rn/pRbmldCdV14g8LfAMm2TY80FOE4pXgYouZDMZOkzagqEa5vmHej
 Q93MdpCMI+USd3oStyIilB+BuhNFeUwaFqpkpuKIR1AqHHHoBa7bSxvLUFvBmjTWNsjqYhoOwq6
 KPLVt9TkAt9cS0AOR2ICNyedblp0X9X7PtBGdjTiq7t51H9k+NBIz8nL3FNi2Jr6EzUMwNFKYBw
 Mr7ToMmRUwIcP+tmBnjRyOh1zgtCye/gS+
X-Received: by 2002:a05:6830:620f:b0:7d1:9516:6858 with SMTP id
 46e09a7af769-7d72702d2a3mr10356571a34.24.1773159259331; 
 Tue, 10 Mar 2026 09:14:19 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d738e3f421sm7304004a34.25.2026.03.10.09.14.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 09:14:19 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v20 17/25] net/pcap: avoid use of volatile
Date: Tue, 10 Mar 2026 09:09:55 -0700
Message-ID: <20260310161356.194553-18-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310161356.194553-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
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

