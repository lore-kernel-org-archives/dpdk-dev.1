Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FDBC36010
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Apr 2025 23:49:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8CCE04065D;
	Wed,  2 Apr 2025 01:48:45 +0200 (CEST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id AFE324064E
 for <dev@dpdk.org>; Wed,  2 Apr 2025 01:48:42 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-227aaa82fafso119311395ad.2
 for <dev@dpdk.org>; Tue, 01 Apr 2025 16:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1743551322;
 x=1744156122; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ptmoMZHzp3Zx5Wtn88qfqRljGRAYS9DEyjgU1OvTQn8=;
 b=WiMHeBM7c5PaJYh6LiohMDdT2p6SJUpEzPAFqSiHeDFuMA1+3KPdV/O1qsha1UQg9+
 DslAU8dR4qlRkXwd5JKA/VHEp11wZOM/9tD+USx4leEiRwInlcX2IxRPTbwRbbi142JY
 FWFp7FXd6HCWnetZG+ll42VQilvfdy34xDYjXqdXmA/DUifTlN9uXi27hDEr7TwH5zvA
 Mm/CuaqEPO1yxqzk9qZ6cguLR9VIjEXG82bTzKq4E+9B9CC5vUR8Xb6xB7pF1Racgc3X
 BQgMw6ZlhTIUUjeI4jALm38qxctjCS5IGDOKk54/A3k31eH9Uc5SQk+YbmSyEgSQHYTz
 S4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743551322; x=1744156122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ptmoMZHzp3Zx5Wtn88qfqRljGRAYS9DEyjgU1OvTQn8=;
 b=VqmCvDp3GVwIdFI58d7q98yAWwi6Y2DR0qlwP28SpgwMywox6FVutuanYJphSJmoMy
 UnSLkxqCCT6SCg6Y+BKq1WPitbSM7uXeZk8Uc4K2lU/GQK3pJq0FgBFjAJ80Z2CCbdsD
 ZxRiSOj5kgd2MQBTGO2TKoO5IxnUu779QqVYRhmDYUvStwcAtQn1eRMf/zB30pUk1RN/
 /IJtdiBiMKXGDF5yVFSgGBHSOHSzDKaVLcpvwZr+1r9cVphsy0/bkf/yUZjbDiI0KZR9
 a3BHlJCPIASdte5YumNEgHi/bd5NDGREHynPMZitCOTo7XUAlWSvXzc1c0ufCv5ZjDp1
 nV6g==
X-Gm-Message-State: AOJu0YwPOUCFV7auY6Cf0TCo7UHXtGVvZN9FqVURiCIIAO0qxcklee+A
 lhwrAZMm4fQYQVuzWjUlm6iYqW2a/l5u8Vt/hwStaEQdmtu88iTgsPPjZkO2LlWnIAb/PzRhVgv
 A
X-Gm-Gg: ASbGnctHtm6QAeswbcXyCW4hGjKMLgM+gcdvwSsS3QKHeH5C7mb/QXvRmxppJ62JTc4
 +tjbph8LqRB34AR64DC2L4FCM9XDjEOQURES/sFgOdUSRgDS+jCv9hGn+N7sfcqAO5nmFdcIYlj
 rgoAka16bcrlJFM4UFwOzpG4t1KZS9d39JQvpXzKjR9l2n9QwVUiPeHyaHcNTYWKS1i+PV/LWHf
 yYiN/e/ibVzs3HOiFmVEndiubivmCHBKuViNj2Jb3RJ6hyRSDPBQ8CoHimvnZaerPRLWs/86PI7
 jtfxw9zC5l0JVUItpK5+alu7S7BK6O2hkL+7ZtJ4kMOSVi2ROdkuAsJ5zCgkhAqDFNXAFF87VdJ
 xZWbfin1AadXlXE9cGDsl
X-Google-Smtp-Source: AGHT+IFUh/8UG4P/q6zlBZsikZFcXU4s9ALssXaZJvE44Z8LXnM400mR6pKPb+1yFfuj1UX8Hs1h/Q==
X-Received: by 2002:a17:903:17ce:b0:21f:ba77:c45e with SMTP id
 d9443c01a7336-2292f9eb7a8mr214126025ad.45.1743551321908; 
 Tue, 01 Apr 2025 16:48:41 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291f1f8bc5sm95135175ad.250.2025.04.01.16.48.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 16:48:41 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tetsuya Mukawa <mtetsuyah@gmail.com>
Subject: [PATCH v2 4/4] net/null: count all queues
Date: Tue,  1 Apr 2025 16:47:29 -0700
Message-ID: <20250401234828.10888-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250401234828.10888-1-stephen@networkplumber.org>
References: <20250326213608.581345-1-stephen@networkplumber.org>
 <20250401234828.10888-1-stephen@networkplumber.org>
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
Add byte counters.

Remove the igb_ prefix which was inherited from other driver.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/null/rte_eth_null.c | 57 ++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 30 deletions(-)

diff --git a/drivers/net/null/rte_eth_null.c b/drivers/net/null/rte_eth_null.c
index 40ce5c6ed2..8a9b74a03b 100644
--- a/drivers/net/null/rte_eth_null.c
+++ b/drivers/net/null/rte_eth_null.c
@@ -319,38 +319,39 @@ eth_dev_info(struct rte_eth_dev *dev,
 }
 
 static int
-eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *igb_stats)
+eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 {
-	unsigned int i, num_stats;
-	unsigned long rx_total = 0, tx_total = 0;
-	const struct pmd_internals *internal;
+	const struct pmd_internals *internal = dev->data->dev_private;
+	unsigned int i;
 
-	if ((dev == NULL) || (igb_stats == NULL))
-		return -EINVAL;
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		uint64_t pkts = internal->rx_null_queues[i].rx_pkts;
+		uint64_t bytes = internal->rx_null_queues[i].rx_bytes;
+
+		stats->ipackets += pkts;
+		stats->ibytes += bytes;
 
-	internal = dev->data->dev_private;
-	num_stats = RTE_MIN((unsigned int)RTE_ETHDEV_QUEUE_STAT_CNTRS,
-			RTE_MIN(dev->data->nb_rx_queues,
-				RTE_DIM(internal->rx_null_queues)));
-	for (i = 0; i < num_stats; i++) {
-		igb_stats->q_ipackets[i] =
-			internal->rx_null_queues[i].rx_pkts;
-		rx_total += igb_stats->q_ipackets[i];
+		if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+			stats->q_ipackets[i] = pkts;
+			stats->q_ibytes[i] = bytes;
+		}
 	}
 
-	num_stats = RTE_MIN((unsigned int)RTE_ETHDEV_QUEUE_STAT_CNTRS,
-			RTE_MIN(dev->data->nb_tx_queues,
-				RTE_DIM(internal->tx_null_queues)));
-	for (i = 0; i < num_stats; i++) {
-		uint64_t pkts = rte_atomic_load_explicit(&internal->tx_null_queues[i].tx_pkts,
-						   rte_memory_order_relaxed);
+	for (i = 0; i < dev->data->nb_tx_queues; i++) {
+		const struct null_queue *q = &internal->tx_null_queues[i];
+		uint64_t pkts, bytes;
 
-		igb_stats->q_opackets[i] = pkts;
-		tx_total += pkts;
-	}
+		pkts = rte_atomic_load_explicit(&q->tx_pkts, rte_memory_order_relaxed);
+		bytes = rte_atomic_load_explicit(&q->tx_bytes, rte_memory_order_relaxed);
+
+		stats->opackets = pkts;
+		stats->obytes = bytes;
 
-	igb_stats->ipackets = rx_total;
-	igb_stats->opackets = tx_total;
+		if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+			stats->q_opackets[i] = pkts;
+			stats->q_obytes[i] = bytes;
+		}
+	}
 
 	return 0;
 }
@@ -358,13 +359,9 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *igb_stats)
 static int
 eth_stats_reset(struct rte_eth_dev *dev)
 {
+	struct pmd_internals *internal = dev->data->dev_private;
 	unsigned int i;
-	struct pmd_internals *internal;
-
-	if (dev == NULL)
-		return -EINVAL;
 
-	internal = dev->data->dev_private;
 	for (i = 0; i < RTE_DIM(internal->rx_null_queues); i++) {
 		internal->rx_null_queues[i].rx_pkts = 0;
 		internal->rx_null_queues[i].rx_bytes = 0;
-- 
2.47.2

