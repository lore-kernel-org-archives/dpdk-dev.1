Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FE2EF584D
	for <dpdk-dev@archiver.kernel.org>; Sat, 14 Feb 2026 23:48:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A47540269;
	Sun, 15 Feb 2026 00:47:43 +0100 (CET)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id 9091D402ED
 for <dev@dpdk.org>; Sun, 15 Feb 2026 00:47:39 +0100 (CET)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-436234ef0f0so1345048f8f.1
 for <dev@dpdk.org>; Sat, 14 Feb 2026 15:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771112859;
 x=1771717659; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=17v6QNHnFQiWbFiMmfg9YUmqOMI+BNUOVUg1G/DsBEE=;
 b=WV22weUCEAxqavlYTFM8n6FWXkELAEeXCJTNp1P/AqmD0LRXDxcFp0e5SRrzdZQQBP
 BgwofhuvsM9dAXzwngLf9muM1Xbv0tanxx5WGzcumATWoIRCVoPROVM+D3JJ2w8uXRg7
 o5jWsvZ32aTy5l28Szg9+BCne0Bc0/1mz8nb7vncrpGARiFWr6LrjzU3BFm4aQgt9kAC
 PPUakbEdVk0UHsWWtFUGQP0Xjj0P5+Wuao97/neinVj+J/OHhfhIUtEe5+VyHwHdUlV8
 HhB4vrRFaPd/oqXr6F/D6Lv8owfYwZmrri7cRKAtcw5yY7/+v0hnsDz6p+myqZ0pjNqK
 tTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771112859; x=1771717659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=17v6QNHnFQiWbFiMmfg9YUmqOMI+BNUOVUg1G/DsBEE=;
 b=cqKt3O2JAGKL8Mf3YZzFSKFSDkP5dbGbKJuqj1lQsAmYony4jUpKPjqZBFla7Avg0+
 DAI7y7cYt97+fYyIyG9DYuQU6ZPnXZvcyC9ffCx6Swvq2uYecau54bun+g/VRFS92rlI
 Pr8bWQKXXpWQLDxXEYqQ9rP5BvpxLRGt6lIxiLEGc1ZdjzFe9qcTuIDz+fvcSgtmj7jE
 BnCrG15vR+q4SMsAQmt8Wog1qFM2PQZH0ultIZ3UX1jCQoD23cisBNXTyKFY4qxvxjX2
 5Tyi1kvsvVQMqFG8AguFSYwzXnaildc20PIzlfppArpfX3lWkz4u1eCU+fP3utq2iaWZ
 3nvg==
X-Gm-Message-State: AOJu0Yz7/vkAGYyLfcVSi7GLID0C1YIF3Q8DPHV0d0bwkLfFwFZwf/Yp
 YzBGKyjNwoITsDRNY2Nxq1wBN+7fs4nwywb3jUhliCK3QARpp1/C/GNLWK7Ogalu+Jiw/O8f8kG
 xmXec
X-Gm-Gg: AZuq6aIMA4z7xTFnLJmJWGjfyn1GAnNjLi1h4fKRGnY6MmjDnIOjYq4ZVVdWXdaodFZ
 FuJ7Z7gAGDER/SueU1opRPCGBYxEXytLrSOCQgac6PxDZEwGe+tJvKA/C0y3UVbBKADcP3l8K8u
 xNmb52KLv9BJ0/c+IYCcQaoBXiXHTabfYe70yknAYxG0heis80R0Bxz+jFpVvZFh0O2mySWIWFS
 WdhMG0ez3n8SZ7TKNvjXOyuD7sj6ecNpkLClIDSgYxZcjUI/5xq7LDJT54Sq/dhOUT1Rgb8Vkd3
 lYb3gsoJPLLn2jx6lM3yr77Rr5ujhc/hPpDG8nfi0yEtPQfC7UPAiMzF95nJDKkcwQIPAf6tnhT
 S9fOOg8s5yLkkkjqzvLwMrCRUDxUqwLl5lHxRT14zC1VD4FRdx67TzcwLKgVda7ngsKF8j42F/X
 1962zsYh4ifDc+c95SSVX7Dmj4gaIPmmTGHwCcd0+oenWvSHJ5b+zlCgWrOnPzRdq0
X-Received: by 2002:a05:600c:1549:b0:47e:e2eb:bc22 with SMTP id
 5b1f17b1804b1-483739fc78cmr109181055e9.5.1771112858922; 
 Sat, 14 Feb 2026 15:47:38 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd1bsm394921485e9.6.2026.02.14.15.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Feb 2026 15:47:38 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 04/11] net/rtap: add statistics and device info
Date: Sat, 14 Feb 2026 15:44:13 -0800
Message-ID: <20260214234726.188947-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260214234726.188947-1-stephen@networkplumber.org>
References: <20241210212757.83490-1-stephen@networkplumber.org>
 <20260214234726.188947-1-stephen@networkplumber.org>
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

Implement basic and per-queue statistics collection.
Usual statistics per queue: packets, bytes, errors.

The imissed counter reports kernel rx_dropped (packets dropped
before reaching the interface) retrieved via netlink IFLA_STATS64.
The rx_drop_base field captures the baseline value at stats_reset.

Device info reports ifindex, max queue counts, and default
burst/ring sizes.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/features/rtap.ini |   2 +
 drivers/net/rtap/rtap.h           |   2 +
 drivers/net/rtap/rtap_ethdev.c    | 120 ++++++++++++++++++++++++++++++
 3 files changed, 124 insertions(+)

diff --git a/doc/guides/nics/features/rtap.ini b/doc/guides/nics/features/rtap.ini
index c064e1e0b9..9bef9e341d 100644
--- a/doc/guides/nics/features/rtap.ini
+++ b/doc/guides/nics/features/rtap.ini
@@ -5,6 +5,8 @@
 ;
 [Features]
 Scattered Rx         = P
+Basic stats          = Y
+Stats per queue      = Y
 Linux                = Y
 ARMv7                = Y
 ARMv8                = Y
diff --git a/drivers/net/rtap/rtap.h b/drivers/net/rtap/rtap.h
index 823b8c59f7..abfde20e60 100644
--- a/drivers/net/rtap/rtap.h
+++ b/drivers/net/rtap/rtap.h
@@ -62,6 +62,8 @@ struct rtap_pmd {
 	int if_index;			/* interface index */
 	int nlsk_fd;			/* netlink control socket */
 	struct rte_ether_addr eth_addr; /* address assigned by kernel */
+
+	uint64_t rx_drop_base;		/* value of rx_dropped when reset */
 };
 
 /* rtap_ethdev.c */
diff --git a/drivers/net/rtap/rtap_ethdev.c b/drivers/net/rtap/rtap_ethdev.c
index 463e24a6e1..888f8e7f39 100644
--- a/drivers/net/rtap/rtap_ethdev.c
+++ b/drivers/net/rtap/rtap_ethdev.c
@@ -2,6 +2,7 @@
  * Copyright (c) 2026 Stephen Hemminger
  */
 
+#include <assert.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <stdlib.h>
@@ -11,6 +12,7 @@
 #include <sys/ioctl.h>
 #include <net/if.h>
 #include <linux/if_tun.h>
+#include <linux/if_link.h>
 #include <linux/virtio_net.h>
 
 #include <rte_config.h>
@@ -29,6 +31,14 @@
 
 #define RTAP_DEFAULT_IFNAME	"rtap%d"
 
+#define RTAP_DEFAULT_BURST	64
+#define RTAP_NUM_BUFFERS	1024
+#define RTAP_MAX_QUEUES		128
+#define RTAP_MIN_RX_BUFSIZE	RTE_ETHER_MIN_LEN
+#define RTAP_MAX_RX_PKTLEN	RTE_ETHER_MAX_JUMBO_FRAME_LEN
+
+static_assert(RTAP_MAX_QUEUES <= RTE_MP_MAX_FD_NUM, "Max queues exceeds MP fd limit");
+
 #define RTAP_IFACE_ARG		"iface"
 #define RTAP_PERSIST_ARG	"persist"
 
@@ -157,6 +167,112 @@ rtap_dev_configure(struct rte_eth_dev *dev)
 	return 0;
 }
 
+static int
+rtap_dev_info(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
+{
+	struct rtap_pmd *pmd = dev->data->dev_private;
+
+	dev_info->if_index = pmd->if_index;
+	dev_info->max_mac_addrs = 1;
+	dev_info->max_rx_pktlen = RTAP_MAX_RX_PKTLEN;
+	dev_info->min_rx_bufsize = RTAP_MIN_RX_BUFSIZE;
+	dev_info->max_rx_queues = RTAP_MAX_QUEUES;
+	dev_info->max_tx_queues = RTAP_MAX_QUEUES;
+
+	dev_info->default_rxportconf = (struct rte_eth_dev_portconf) {
+		.burst_size = RTAP_DEFAULT_BURST,
+		.ring_size = RTAP_NUM_BUFFERS,
+		.nb_queues = 1,
+	};
+	dev_info->default_txportconf = (struct rte_eth_dev_portconf) {
+		.burst_size = RTAP_DEFAULT_BURST,
+		.ring_size = RTAP_NUM_BUFFERS,
+		.nb_queues = 1,
+	};
+	return 0;
+}
+
+static int
+rtap_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
+	       struct eth_queue_stats *qstats)
+{
+	struct rtap_pmd *pmd = dev->data->dev_private;
+	struct rtnl_link_stats64 kstats;
+	uint16_t i;
+
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		struct rtap_rx_queue *rxq = dev->data->rx_queues[i];
+		if (rxq == NULL)
+			continue;
+
+		stats->ipackets += rxq->rx_packets;
+		stats->ibytes += rxq->rx_bytes;
+		stats->ierrors += rxq->rx_errors;
+
+		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+			qstats->q_ipackets[i] = rxq->rx_packets;
+			qstats->q_ibytes[i] = rxq->rx_bytes;
+			qstats->q_errors[i] = rxq->rx_errors;
+		}
+	}
+
+	for (i = 0; i < dev->data->nb_tx_queues; i++) {
+		struct rtap_tx_queue *txq = dev->data->tx_queues[i];
+		if (txq == NULL)
+			continue;
+
+		stats->opackets += txq->tx_packets;
+		stats->obytes += txq->tx_bytes;
+		stats->oerrors += txq->tx_errors;
+
+		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+			qstats->q_opackets[i] = txq->tx_packets;
+			qstats->q_obytes[i] = txq->tx_bytes;
+		}
+	}
+
+	/* Get kernel rx_dropped counter via netlink */
+	if (rtap_nl_get_stats(pmd->if_index, &kstats) == 0 &&
+	    kstats.rx_dropped > pmd->rx_drop_base)
+		stats->imissed = kstats.rx_dropped - pmd->rx_drop_base;
+
+	return 0;
+}
+
+static int
+rtap_stats_reset(struct rte_eth_dev *dev)
+{
+	struct rtap_pmd *pmd = dev->data->dev_private;
+	struct rtnl_link_stats64 kstats;
+	uint16_t i;
+
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		struct rtap_rx_queue *rxq = dev->data->rx_queues[i];
+		if (rxq == NULL)
+			continue;
+
+		rxq->rx_packets = 0;
+		rxq->rx_bytes = 0;
+		rxq->rx_errors = 0;
+	}
+
+	for (i = 0; i < dev->data->nb_tx_queues; i++) {
+		struct rtap_tx_queue *txq = dev->data->tx_queues[i];
+		if (txq == NULL)
+			continue;
+
+		txq->tx_packets = 0;
+		txq->tx_bytes = 0;
+		txq->tx_errors = 0;
+	}
+
+	/* Capture current rx_dropped as baseline via netlink */
+	if (rtap_nl_get_stats(pmd->if_index, &kstats) == 0)
+		pmd->rx_drop_base = kstats.rx_dropped;
+
+	return 0;
+}
+
 static int
 rtap_dev_close(struct rte_eth_dev *dev)
 {
@@ -247,7 +363,10 @@ static const struct eth_dev_ops rtap_ops = {
 	.dev_start		= rtap_dev_start,
 	.dev_stop		= rtap_dev_stop,
 	.dev_configure		= rtap_dev_configure,
+	.dev_infos_get		= rtap_dev_info,
 	.dev_close		= rtap_dev_close,
+	.stats_get		= rtap_stats_get,
+	.stats_reset		= rtap_stats_reset,
 	.rx_queue_setup		= rtap_rx_queue_setup,
 	.rx_queue_release	= rtap_rx_queue_release,
 	.tx_queue_setup		= rtap_tx_queue_setup,
@@ -262,6 +381,7 @@ rtap_create(struct rte_eth_dev *dev, const char *tap_name, uint8_t persist)
 
 	pmd->keep_fd = -1;
 	pmd->nlsk_fd = -1;
+	pmd->rx_drop_base = 0;
 
 	dev->dev_ops = &rtap_ops;
 
-- 
2.51.0

