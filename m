Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0EBC3600E
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 21:36:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 506574066C;
	Wed, 26 Mar 2025 22:36:26 +0100 (CET)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 1313240615
 for <dev@dpdk.org>; Wed, 26 Mar 2025 22:36:23 +0100 (CET)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2243803b776so11349425ad.0
 for <dev@dpdk.org>; Wed, 26 Mar 2025 14:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1743024982;
 x=1743629782; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wu+TZv6MrY1HOJqGHEzNf2vSFpZ7mJYTV/Nk8rh+vXE=;
 b=2its9PR+Hl+mgusM/GsvYX6Wc6sD+mVUmLi06gAzGHnxMNK28rocKTwufZpO7McYHi
 twUdBdEykm5nUF0BiqEapav2KPE9mDDNsqkpTM9aB6vBbqIENOcGCSvAbRVoQI55ZbRC
 NczfpmWGj3ehnoPnRWt5lQk48MozypuNz1Hxju1lG5aM9c9PccOzb9YOWLZvfhDYtP9q
 4ObqcrPAu8+x9V3hF61t9DR4vi7Tx9P/a3xiJZIojLPCJSyoozM0WqwQqBwibn4k0oG/
 aSrllzdxKNn/cUBKzpKk7jfxJwrFlw3J8A0kN/ZxxkL9FNpU1LVLgaJKWaIpBVMG+o2m
 gqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743024982; x=1743629782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wu+TZv6MrY1HOJqGHEzNf2vSFpZ7mJYTV/Nk8rh+vXE=;
 b=gfNYahQ228PU856BoA3KaNBYExetqGSDfSTV3vuWed5KfT4ySQCMhy5C6AddSw1jkm
 hAcURrCJ07GlNZDZhvnC49OZpnHR1HvYLyqZkjNJTltCTlxMe3Mmj2PMzuhWsdhG6FkS
 h5oHhjdWvqynvfkh5nAv5EpImsa5/iwTUa5/kZ0J2kuUgNe5N7vgBWoR/9R6RSco1hPU
 8imdc5tbWEPeuHoY6iB8Hc8IODoSuQ0khVnKKMKsAETINzF0CG8720DxuW6frkLHw9VI
 r5uehV9oiPLWeZFyLlvzVNjp3HDPV49T9SgNkstNBSg80axWsrynBVYnK3LMKPaqM4Y3
 8bVg==
X-Gm-Message-State: AOJu0Yxa3/wGLPSeUmBEJU9KWkizjiQbcPo5SYrvKV4aoGF+MM+0UE9P
 jRnlfc3GfhjF57MsgZRInQSPhxYNRtLxinAlLXj0VY2LQYOWbfLLzSDHMVsjFnEqkh1G3wT18uK
 H
X-Gm-Gg: ASbGncvNTFsOiZNeqMeVSyZsYChBkaItve4r+XrT635RvN/NJm2HeM8rxb5SMSQynOF
 K+G1zos/ODpdx+V9sWgqRp7Q9nclN4P5xjaAAZpzPJ3oTStOgUvpr/F7AbJLhaHxg2pIVBf+FEv
 r1kfWwi/iX3QXrZK1zFEqQyF+UrkJGh4+0RCt/d5AMpqjb0I21koDGg3Z6Cy1mb5tOdnsT4ZRq+
 lDSgnRAzJuDYJny1bHqRGcZQsn4rG3BayKlZjJu9QL7DA+zjG901f5irpPyBJq3UH0AQTARfxXf
 LfEnUAS/yt0NYaHjZR0knMiIxBygiuAX6o+s9/pR3EW5qEaJmIqBYbrRgcZxZ93X1sWg43Ycpuc
 sSTnv0mBwpot3jX7PwF0d
X-Google-Smtp-Source: AGHT+IH7AB5X29v+35lMjIjQDGzbjYj6qxYYaCTDMM4rZAZMTl1CY4tUb/t84WnLER6FXQGID1hWhQ==
X-Received: by 2002:a17:902:e748:b0:224:1935:d9a3 with SMTP id
 d9443c01a7336-228048bb34bmr15245515ad.21.1743024982273; 
 Wed, 26 Mar 2025 14:36:22 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f4597csm115807525ad.75.2025.03.26.14.36.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 14:36:21 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tetsuya Mukawa <mtetsuyah@gmail.com>
Subject: [PATCH 4/4] net/null: count all queues
Date: Wed, 26 Mar 2025 14:35:28 -0700
Message-ID: <20250326213608.581345-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250326213608.581345-1-stephen@networkplumber.org>
References: <20250326213608.581345-1-stephen@networkplumber.org>
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

If RTE_ETHDEV_QUEUE_STAT_CNTRS is less than the number of queues
in a device, the device should still count packets for all queues.

Remove the igb_ prefix which was inherited from other driver.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/null/rte_eth_null.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/net/null/rte_eth_null.c b/drivers/net/null/rte_eth_null.c
index 7ac29b3f81..82b49d471d 100644
--- a/drivers/net/null/rte_eth_null.c
+++ b/drivers/net/null/rte_eth_null.c
@@ -304,31 +304,26 @@ eth_dev_info(struct rte_eth_dev *dev,
 static int
 eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *igb_stats)
 {
-	unsigned int i, num_stats;
+	const struct pmd_internals *internal = dev->data->dev_private;
+	unsigned int i;
 	unsigned long rx_total = 0, tx_total = 0;
-	const struct pmd_internals *internal;
 
-	if ((dev == NULL) || (igb_stats == NULL))
-		return -EINVAL;
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		uint64_t pkts = internal->rx_null_queues[i].rx_pkts;
 
-	internal = dev->data->dev_private;
-	num_stats = RTE_MIN((unsigned int)RTE_ETHDEV_QUEUE_STAT_CNTRS,
-			RTE_MIN(dev->data->nb_rx_queues,
-				RTE_DIM(internal->rx_null_queues)));
-	for (i = 0; i < num_stats; i++) {
-		igb_stats->q_ipackets[i] =
-			internal->rx_null_queues[i].rx_pkts;
-		rx_total += igb_stats->q_ipackets[i];
+		if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS)
+			igb_stats->q_ipackets[i] = pkts;
+
+		rx_total += pkts;
 	}
 
-	num_stats = RTE_MIN((unsigned int)RTE_ETHDEV_QUEUE_STAT_CNTRS,
-			RTE_MIN(dev->data->nb_tx_queues,
-				RTE_DIM(internal->tx_null_queues)));
-	for (i = 0; i < num_stats; i++) {
+	for (i = 0; i < dev->data->nb_tx_queues; i++) {
 		uint64_t pkts = rte_atomic_load_explicit(&internal->tx_null_queues[i].tx_pkts,
-						   rte_memory_order_relaxed);
+							 rte_memory_order_relaxed);
+
+		if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS)
+			igb_stats->q_opackets[i] = pkts;
 
-		igb_stats->q_opackets[i] = pkts;
 		tx_total += pkts;
 	}
 
-- 
2.47.2

