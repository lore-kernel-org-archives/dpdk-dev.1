Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D041D73E83
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 20:27:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7BB340653;
	Thu, 29 Jan 2026 21:26:54 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 40C0E40431
 for <dev@dpdk.org>; Thu, 29 Jan 2026 21:26:48 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-47edd6111b4so14345205e9.1
 for <dev@dpdk.org>; Thu, 29 Jan 2026 12:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769718408;
 x=1770323208; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jihB/3B7attDd1KAU2ZVonAWa0DUHX+1KlYcxqbV77I=;
 b=eQ63P0ThARXncHXlwSUaGAjonDWPA0K2wkTqIxnuca6vwFDwcRzjotO9Xo1ZAH76Ey
 FMpRMGceL8KQNV6jUHqHtUsOA5gN83Eo17MUtwS8M97ok+LLokPpFWCylzVTJUsVd13R
 +RtCmTr3V4ENLdET3v+1gJaP1hHbtDrKPloYE0nhQ4Ith7yXkrjKMvxXVotyBDrnrGvT
 jXnXLNkZq3iJVzTQBNYghyJVwTVzhdE0KuznPugIbcmqZ6Lgcxzh4pK4sTg0Lr0VMPyR
 iWSc+BtOe7FE70ix/nKuVPWnJqd1UKFJaEOsvzhnqrU3jIcsj/rvxykewS8LR7yKei0k
 M1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769718408; x=1770323208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jihB/3B7attDd1KAU2ZVonAWa0DUHX+1KlYcxqbV77I=;
 b=Xbvp0mRCnlBY/Uhag4u1V76fR/zv3thvYHoysOqh4jOcFWb0ghneNBNboaeRPHMqzD
 3U+jZLHBNQO7NgDBcME8wnGMdd77WI+U+FdMxYYSL39+D4/2VvLH+cja7IGsXq63Ds1A
 SKNRbB9VPCuzAzL9gzpQgRRt14tuS+3IDIFjJd+ZtkvquCE70zRDlple/3uSKSmPPxCr
 m4MawJkj1qRb4jOjdSz4hHegqKRSY05REvWY65GOYl7iGhW5NZdB1dfP/BqanLQzh6kt
 vi0npbVjxKG6xzFofHptSuhHiFj7Nxgc7AA7K21WpOrEM0nLBLbxTLaaF38UU948UtIj
 T3ig==
X-Gm-Message-State: AOJu0Yx80MwbV1j7HFipHAfOA/W3zvm8nQRTGQU2XwMTHrc0ynLdW4Gr
 B1hp1UkM9bzyZ+m4dZ4MQX318vhTrB2UHcrkVgOA+Rt3FfxE1y5OgqOg0NyPTK5HOmT7/7bs6Wq
 ybIFr
X-Gm-Gg: AZuq6aJ749MDYG1uLRfMQKin2AdRxTokJml/fpSlhqnyxKfAyZfCMYy78DqDxwdNBE+
 YD3aj7XEpjGcwUhFzg82xY90bsmUeZNYsb1L7NW/P6d78ZddIEPl9uMLkKRwANxJC9MZL0bffmK
 5LdxM5SYAAF0yQ7u++XYTpMElIhooT1vQAJDfSYv/abyw/7TAeC1hAHuKQ1kTX9y5dRa3Fuzl5m
 eTehDaAbHivj1fC8cPCmtnO928XAu5LJleyYjojDwn+9alzH2QgAA036mGuSLvtZBwId1TylBFt
 Wofmyg5bh2qIFdZNoM+opJ2FljBNd32eJjDmTwcWYyV0pLXPOHtbcd0hXjorsSJUgd25r+YCUaP
 aSTXge5HbkQ9LO8oLzRY3MWztxhEnI8E/rLs1hcFJeua12WEwuAJ03rvkzeYX6uBU/ytbN9wdls
 JXWT2J77ocrKuZmutpkqqX7uL3Yr0T3W8Z4HzUpSHtOlfW8v5kmw==
X-Received: by 2002:a05:600c:c4a5:b0:480:6941:d38c with SMTP id
 5b1f17b1804b1-482db492393mr4083965e9.29.1769718407878; 
 Thu, 29 Jan 2026 12:26:47 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-481a5e2ba7asm4819435e9.20.2026.01.29.12.26.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 12:26:46 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tetsuya Mukawa <mtetsuyah@gmail.com>
Subject: [PATCH v9 3/5] net/null: remove redundant argument validation
Date: Thu, 29 Jan 2026 12:25:29 -0800
Message-ID: <20260129202635.173530-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260129202635.173530-1-stephen@networkplumber.org>
References: <20260104222523.329760-1-stephen@networkplumber.org>
 <20260129202635.173530-1-stephen@networkplumber.org>
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

The dev_ops callbacks for stop, rx_queue_setup, and tx_queue_setup
are only called from the ethdev layer which already validates the
device pointer and queue index arguments.

Remove the redundant checks for:
 - dev == NULL in eth_dev_stop, eth_rx_queue_setup, eth_tx_queue_setup
 - queue_id >= nb_queues in eth_rx_queue_setup, eth_tx_queue_setup

Also consolidate variable declarations with their initializations
and remove unnecessary NULL initialization in rte_pmd_null_remove.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/null/rte_eth_null.c | 44 ++++++++-------------------------
 1 file changed, 10 insertions(+), 34 deletions(-)

diff --git a/drivers/net/null/rte_eth_null.c b/drivers/net/null/rte_eth_null.c
index cd7a29bce9..d5c419ec15 100644
--- a/drivers/net/null/rte_eth_null.c
+++ b/drivers/net/null/rte_eth_null.c
@@ -207,9 +207,6 @@ eth_dev_stop(struct rte_eth_dev *dev)
 {
 	uint16_t i;
 
-	if (dev == NULL)
-		return 0;
-
 	dev->data->dev_link.link_status = RTE_ETH_LINK_DOWN;
 
 	for (i = 0; i < dev->data->nb_rx_queues; i++)
@@ -227,25 +224,16 @@ eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t rx_queue_id,
 		const struct rte_eth_rxconf *rx_conf __rte_unused,
 		struct rte_mempool *mb_pool)
 {
+	struct pmd_internals *internals = dev->data->dev_private;
+	unsigned int packet_size = internals->packet_size;
 	struct rte_mbuf *dummy_packet;
-	struct pmd_internals *internals;
-	unsigned int packet_size;
 
-	if ((dev == NULL) || (mb_pool == NULL))
+	if (mb_pool == NULL)
 		return -EINVAL;
 
-	internals = dev->data->dev_private;
-
-	if (rx_queue_id >= dev->data->nb_rx_queues)
-		return -ENODEV;
-
-	packet_size = internals->packet_size;
-
 	internals->rx_null_queues[rx_queue_id].mb_pool = mb_pool;
-	dev->data->rx_queues[rx_queue_id] =
-		&internals->rx_null_queues[rx_queue_id];
-	dummy_packet = rte_zmalloc_socket(NULL,
-			packet_size, 0, dev->data->numa_node);
+	dev->data->rx_queues[rx_queue_id] = &internals->rx_null_queues[rx_queue_id];
+	dummy_packet = rte_zmalloc_socket(NULL, packet_size, 0, dev->data->numa_node);
 	if (dummy_packet == NULL)
 		return -ENOMEM;
 
@@ -261,24 +249,12 @@ eth_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
 		unsigned int socket_id __rte_unused,
 		const struct rte_eth_txconf *tx_conf __rte_unused)
 {
+	struct pmd_internals *internals = dev->data->dev_private;
+	unsigned int packet_size = internals->packet_size;
 	struct rte_mbuf *dummy_packet;
-	struct pmd_internals *internals;
-	unsigned int packet_size;
-
-	if (dev == NULL)
-		return -EINVAL;
 
-	internals = dev->data->dev_private;
-
-	if (tx_queue_id >= dev->data->nb_tx_queues)
-		return -ENODEV;
-
-	packet_size = internals->packet_size;
-
-	dev->data->tx_queues[tx_queue_id] =
-		&internals->tx_null_queues[tx_queue_id];
-	dummy_packet = rte_zmalloc_socket(NULL,
-			packet_size, 0, dev->data->numa_node);
+	dev->data->tx_queues[tx_queue_id] = &internals->tx_null_queues[tx_queue_id];
+	dummy_packet = rte_zmalloc_socket(NULL, packet_size, 0, dev->data->numa_node);
 	if (dummy_packet == NULL)
 		return -ENOMEM;
 
@@ -739,7 +715,7 @@ rte_pmd_null_probe(struct rte_vdev_device *dev)
 static int
 rte_pmd_null_remove(struct rte_vdev_device *dev)
 {
-	struct rte_eth_dev *eth_dev = NULL;
+	struct rte_eth_dev *eth_dev;
 
 	if (!dev)
 		return -EINVAL;
-- 
2.51.0

