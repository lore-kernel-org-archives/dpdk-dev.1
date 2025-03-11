Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1E6C282EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 23:55:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09DEE40670;
	Wed, 12 Mar 2025 00:54:52 +0100 (CET)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id BBCDB4065D
 for <dev@dpdk.org>; Wed, 12 Mar 2025 00:54:46 +0100 (CET)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-22548a28d0cso29766685ad.3
 for <dev@dpdk.org>; Tue, 11 Mar 2025 16:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741737286;
 x=1742342086; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZK7Ezxs5fpLrG9S5sCuIGvAbQh1L5i0rnshzfJrDb8g=;
 b=FXEp+hFaDkFmUMRAev1K2ulg6/2MaE4kItl+qs/z1odq6kIwstsOX6L0giAqdZErw6
 5psYYbBCEbMXhrP/7RoeMUIiWYnzta+CFW7Mh2wuObMs8iWvuU0ttNXlTFWQ9QaQ68Oo
 QIXcpvxwxTdbKed4uEUdXqFRzYcb6NrjAocFf5UFanp9pjiSN4BTq/s/W2/oQmBdJE3n
 aj8AL5EeUU97KiZvhuYD/I95+Eo3brCYfdkujdMVPSm1e/NfoDI9/PfnwsuGhvPaVTfM
 s6+d0aOnQzHzgNLPiswejpkP3jhw0fV3RDmSMJOibCR3T/Kmlq42M9NJBTkqqWqMB9+T
 4ySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741737286; x=1742342086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZK7Ezxs5fpLrG9S5sCuIGvAbQh1L5i0rnshzfJrDb8g=;
 b=GNwhsPqWvVXybaSyAZZ8WerzyCB6H93wBaWMqMeRXY728In2oDKnOMZQiFigbb6vwx
 Awc6EfXRvAHBxg4asKnpFWIx2BTedoR7bqD8t5PHFyyuVOwNKhB2K/u9k37DY3jr9WHb
 wSKSq5obJje15muN0AJdtAkB8lpzy6SUHhvWTIKgiMPST8gbFK11/TRNFztVhR7fjeQ6
 gUrR5Gx7o/t7qQU51SPVQtTxbGEaVH0M/aWfHVRlKUw3zWdRBRSJkH5IqsfV71v7l+eX
 1HzRmXCAKKMNlxycBSlwytnorGRNpsZN8slI2GI1CaiGKPgsJeTfDCKyIjH+Gb/S14Kd
 n2Sg==
X-Gm-Message-State: AOJu0YzUEKtK8RyYvKCtrnjimv42dtoe3lDxSp2QzzqCk5MePm4fCiAL
 iQdiiRAa52lDAebahHiEOd0jCkhy9XbCYkufcxPNrxKGathcxmBKhtXdONnr1KW9sHh1c/mhNG2
 J
X-Gm-Gg: ASbGncstxzThd66F2SCqEUz2w5C93g/Oay3rFr9t//9ohWLr+54PWxTy9AkQmI5NrDp
 J8rp4PGSantD+zOmzYWHN+o1+SkcCemJVstkWBDNHinmmPbVTRdUeUlEBu0zdtN8Y1PEjidnBRC
 rrjsDrvbZMZnrU4f378imeCfvpkwK/YKV5h2xi5N6yFs5AJeJThnmruvxUsZ2oV6VP79o0J/D+F
 TGghlO9Gox2gx2I7ByX2kIG+o3m9qrtcIpyCUIottMRJpOZXH3p6665FmTSNwykxQYHs80CC2G7
 8J6O3woNt6qhXUNg7cewj1QaEOZWZ4Px+6SauGojGgqjUziz4b2P5tKyeJar3zdck72PL2SK/RY
 4T6ufXYikW/tYLks6pUB1WA==
X-Google-Smtp-Source: AGHT+IHCVzIH9fMkMGwr4Sw25wQSObI8rFeHodHdYmVgFFbIdIrH8AayvR6Xg+9RlNw4emPgeDR80g==
X-Received: by 2002:a17:903:32c5:b0:224:2717:7993 with SMTP id
 d9443c01a7336-22428bfaacbmr264223405ad.45.1741737285988; 
 Tue, 11 Mar 2025 16:54:45 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a91cf4sm103734145ad.200.2025.03.11.16.54.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 16:54:45 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 8/9] net/ioring: implement statistics
Date: Tue, 11 Mar 2025 16:51:26 -0700
Message-ID: <20250311235424.172440-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250311235424.172440-1-stephen@networkplumber.org>
References: <20241210212757.83490-1-stephen@networkplumber.org>
 <20250311235424.172440-1-stephen@networkplumber.org>
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

Add support for basic statistics

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/features/ioring.ini |  2 +
 drivers/net/ioring/rte_eth_ioring.c | 57 +++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/doc/guides/nics/features/ioring.ini b/doc/guides/nics/features/ioring.ini
index da47062adb..c9a4582d0e 100644
--- a/doc/guides/nics/features/ioring.ini
+++ b/doc/guides/nics/features/ioring.ini
@@ -9,6 +9,8 @@ MTU update           = Y
 Promiscuous mode     = Y
 Allmulticast mode    = Y
 Multiprocess aware   = Y
+Basic stats          = Y
+Stats per queue      = Y
 Linux		     = Y
 x86-64               = Y
 Usage doc            = Y
diff --git a/drivers/net/ioring/rte_eth_ioring.c b/drivers/net/ioring/rte_eth_ioring.c
index d473c3fcbb..83446dc660 100644
--- a/drivers/net/ioring/rte_eth_ioring.c
+++ b/drivers/net/ioring/rte_eth_ioring.c
@@ -364,6 +364,61 @@ eth_dev_info(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	return 0;
 }
 
+static int
+eth_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
+{
+	for (uint16_t i = 0; i < dev->data->nb_rx_queues; i++) {
+		const struct rx_queue *rxq = dev->data->rx_queues[i];
+
+		stats->ipackets += rxq->rx_packets;
+		stats->ibytes += rxq->rx_bytes;
+		stats->ierrors += rxq->rx_errors;
+		stats->rx_nombuf += rxq->rx_nombuf;
+
+		if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+			stats->q_ipackets[i] = rxq->rx_packets;
+			stats->q_ibytes[i] = rxq->rx_bytes;
+		}
+	}
+
+	for (uint16_t i = 0; i < dev->data->nb_tx_queues; i++) {
+		const struct tx_queue *txq = dev->data->tx_queues[i];
+
+		stats->opackets += txq->tx_packets;
+		stats->obytes += txq->tx_bytes;
+		stats->oerrors += txq->tx_errors;
+
+		if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+			stats->q_opackets[i] = txq->tx_packets;
+			stats->q_obytes[i] = txq->tx_bytes;
+		}
+	}
+
+	return 0;
+}
+
+static int
+eth_dev_stats_reset(struct rte_eth_dev *dev)
+{
+	for (uint16_t i = 0; i < dev->data->nb_rx_queues; i++) {
+		struct rx_queue *rxq = dev->data->rx_queues[i];
+
+		rxq->rx_packets = 0;
+		rxq->rx_bytes = 0;
+		rxq->rx_nombuf = 0;
+		rxq->rx_errors = 0;
+	}
+
+	for (uint16_t i = 0; i < dev->data->nb_tx_queues; i++) {
+		struct tx_queue *txq = dev->data->tx_queues[i];
+
+		txq->tx_packets = 0;
+		txq->tx_bytes = 0;
+		txq->tx_errors = 0;
+	}
+	return 0;
+}
+
 static int
 eth_dev_close(struct rte_eth_dev *dev)
 {
@@ -732,6 +787,8 @@ static const struct eth_dev_ops ops = {
 	.promiscuous_disable	= eth_dev_promiscuous_disable,
 	.allmulticast_enable	= eth_dev_allmulticast_enable,
 	.allmulticast_disable	= eth_dev_allmulticast_disable,
+	.stats_get              = eth_dev_stats_get,
+	.stats_reset            = eth_dev_stats_reset,
 	.rx_queue_setup		= eth_rx_queue_setup,
 	.rx_queue_release	= eth_rx_queue_release,
 	.tx_queue_setup		= eth_tx_queue_setup,
-- 
2.47.2

