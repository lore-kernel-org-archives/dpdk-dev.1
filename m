Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB52D2F35C
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 19:26:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A69794068A;
	Tue, 13 Jan 2026 20:25:55 +0100 (CET)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51]) by mails.dpdk.org (Postfix) with ESMTP id DC7184067B
 for <dev@dpdk.org>; Tue, 13 Jan 2026 20:25:53 +0100 (CET)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-64b921d9e67so13656410a12.3
 for <dev@dpdk.org>; Tue, 13 Jan 2026 11:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768332353;
 x=1768937153; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d+SOf1FgPftt188i9zJ6FQyj3Oyh/5Gb+/t0jZHINVQ=;
 b=M3gJ4FB/ExLRE8vQMTKjqCUOBBqTgY8eHjo2eYMxRpaYgeljmHE2zu6cNV0nD9dwMJ
 CQT/zxxLfctufcE6sT8YQIaWTz/VyUYBRjdNe/B2Y3rzBLswos4KxzNS3jVIDp9x0z/3
 2JiWoc9ihVbrkI4H4hF8C9FhFLAv1ubvwFt+Xvhcy7OU27F1d7LUEeuSv6QLGvpD2Eyw
 WAXU7Pb2cZTVGHmn0GvC9N4z0rfX7SedYkAvSPAxmP/kNjPl6i6opGVb5XgTe0T+bW8R
 1I7GngVkPisCMbOa8oGO9lhHhVof86jI6+JoUxaJLjjQ8g+L0DMgv0qBR0NTTkxhbz1x
 Hu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768332353; x=1768937153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d+SOf1FgPftt188i9zJ6FQyj3Oyh/5Gb+/t0jZHINVQ=;
 b=SzdhFnoUQ619EmTt5gavZLudzUFZ85YZR17OfjZO2tLG9MzfH50w4svYgugbvxPXjJ
 Cun+eihyEBw8M90aNVcvsXw5ajUi0WdqFKD3d7Py46jx1qhQYe4ixeH63LH0KXO4yVFh
 oZkFSeqIc/yF5Q31yOiwMih7aakzyJzA+8wBwskWhUZGL69hj2o2jDoQ2bppcQZvSMay
 ymTZ338jnAtICRZlvs8FVSl0lS0pcE6i03s96YOC18RPSNnkTujUaUQlI0xgIVdr06BU
 Kv1fFcxnsnRI1Xw+K/+DDweeGLGJWoTHczPOjAxkKJk/QdBut23R45AAZ1SKjhPW7aPn
 IPPg==
X-Gm-Message-State: AOJu0Yz/gfkcpqtbccnmUsDFaVmL8TdRzYwbM/TOh4GN34uw/k8Id6Ix
 edTYsqbQaJ95qLAjMW7y+MBloLazrDn20yUcUFiDS2036aX2+8MXQp/KI4OWSb8y170jNT0L/tk
 6xNZs
X-Gm-Gg: AY/fxX5hYwqwmVAeD4H/3Z/b3umuGJOXvDFepysZYGI+SWRtYhSUHre7L4LgMlI/qfj
 iKvKX/XVRXiMGYl6NqK0B5uzIv++93nr8Rp0ikea9BfsGnqxLR+scCKIJgEIjPMhnGJcyRswwtA
 Jbt9kz4zDL0Scgcokjq0bX4HoN2aUsXH9VPkq3D4H11W8mNgvaJS2uTZ8fJRLh7fq6JOog0jdXT
 7LeRu6BlIfAN6t2fm53vS48FfZD9biHxGW6Vf66HOW6Au3+260KVsdLhWwDDWh0ZvzcUR1x2O1P
 IyhC8tb2TIy/SRxJiopni1zcoW+ENlkI3yYol54t10YUGUxeEkBNOgMjkkPbnVZYb9AOthcB4Qi
 BP2+3cVLYqG9Hu7b6uV2EnjbnLD9m4yLE/6msUCXl6eI1wKIfeT5YSvqeRkSobRN43c2gNMBpY+
 9bcqmClQMr8mQKKx39cHA98LRbNT5qkAQGTzgyjbWtmDjcubth3Q==
X-Received: by 2002:a17:907:3f13:b0:b87:3430:fad4 with SMTP id
 a640c23a62f3a-b87610217dfmr17606566b.21.1768332353470; 
 Tue, 13 Jan 2026 11:25:53 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507b22c3absm20945603a12.0.2026.01.13.11.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 11:25:53 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 8/9] net/pcap: avoid use of volatile
Date: Tue, 13 Jan 2026 11:23:40 -0800
Message-ID: <20260113192530.116470-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113192530.116470-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260113192530.116470-1-stephen@networkplumber.org>
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
index 6dbcd58465..0c7eb00314 100644
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
@@ -828,11 +828,11 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
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

