Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B877E65296
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Feb 2026 17:20:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0121740654;
	Sun,  1 Feb 2026 18:20:04 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 529E640150
 for <dev@dpdk.org>; Sun,  1 Feb 2026 18:19:52 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-47fedb7c68dso37871115e9.2
 for <dev@dpdk.org>; Sun, 01 Feb 2026 09:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769966392;
 x=1770571192; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QTrlYKBvOhXDwdyHf13Jyi/97Ari/INIvdJmizJtVnU=;
 b=Vqvbz70qkVx0xCYpM4rdNiOnTL9CsCUF7W7Wbt8pjrURGqVFSEUXB+ysri0duvAlfs
 uPUUsVCM/JUnYA8SShzumdN2BvCG3BgiLrB1zVMUQUXI37R/nUnmM1gbr6R0o0kOsRd0
 aQW7iR/relRMafz0RgZ6s5aAzwbMyjrARz2K8yd3XuL1zEYtjwEq9v9RvOjzfkXDVQrc
 4mhuhbw68iUdZlIXi6kNSo7Js7KANC8pexLSHRLA0QZ6hDFzUnZjuBT1gZe9S8Zu3drY
 ao5xF79ncmMiEZhXxZkU5/HTpoYepIlhgGvshnC66+0lqkVe7kJhSjQoGgqS9qMlacOk
 VjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769966392; x=1770571192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QTrlYKBvOhXDwdyHf13Jyi/97Ari/INIvdJmizJtVnU=;
 b=gHtr2EQQqj39CHfOMoVDsYtr0QtBmOKOGVmHQUQCk7IKJ0/eOti1PpQClwUfiGbVEy
 wzTjY1LzSE3fLWqTiAhhx/A7cDoX7ueaYlFo46xsw02X5kQnhbI1I0NikDE1XCmnLolF
 S93Ptdgrh/zKM2wq25/Mbc+m79atpzreMZcCz0Y/xq5W5UhzxAp82lAqrosprHzQqBo/
 vkG4d26Me9nZUf+uMIGxP3O+Y/3uYFcEjNmv5SuoeaOPqddYTM3WSaI8hKhSaam082kU
 R3UF10Q1YhlLK2pcNLknvdy8XcYWapJPQZMr4Aro0oqtSuHDeEyBKol3udVTNoP5qM+v
 M4ZA==
X-Gm-Message-State: AOJu0YyObWuFJbx5UNEgfOJ38PyKBnC/rXhDR/VhMXjJOiajgpyWJW3I
 HoJyCGNL+ckZ3MONpKmj3jlKcRWsZUKC5+gnZ/5gNdxjQ8AxGqhwn4+q+tax9JM8zpBoU62RJvo
 CStv/
X-Gm-Gg: AZuq6aJ9vWqqtd4fx9LhN1Vvs2EWZEI8Bi9vaFC2TQuPeCU/DUjLhczkNVmNfB2Ix8h
 /1rOzfGLvm+TMIGXae6ZFwll6j5R6PCVYst/yvo3/RO6eIfx4UXCeZHtaijNROhwilpFnz9nht5
 yHE/w+SjHVbVEXsXiPUZsKlVDP8fzaXDl1s9cYU6yCbESCH8BmOXzuCJUeo4nNH6km87JecRmdn
 8bGnqqnBDCQp6jihNVGew3w1FZnmuGnHVVpFJdU6tEHpUaAE0laAifW4pvp4trRLX60XzCa51XU
 Vuh2LeGd4ZYFMrfdI9a0gw8az/lTBikb2Cg4dB0iH9u9LZYL2t+UjD6UnRuPC2EEJl0lKNLldra
 pJjZ7fBYSakyI5QKrsltdNoGY3cLSEKUeMCqqQq7ZbWKbNsuCKr1bayRsl5Nu4YJaNQb8vUYhWi
 H2PeIMvOgTJEfhOK5Rb31MTv4r/wpsH1KQGD8ZFEDBffGJ2VixMQ==
X-Received: by 2002:a05:600c:8b22:b0:47e:e4ff:e2ac with SMTP id
 5b1f17b1804b1-482db4a7547mr108537235e9.33.1769966391853; 
 Sun, 01 Feb 2026 09:19:51 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806cdd79c7sm346810765e9.2.2026.02.01.09.19.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Feb 2026 09:19:51 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tetsuya Mukawa <mtetsuyah@gmail.com>
Subject: [PATCH v10 4/6] net/null: remove redundant argument validation
Date: Sun,  1 Feb 2026 09:17:35 -0800
Message-ID: <20260201171938.89492-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260201171938.89492-1-stephen@networkplumber.org>
References: <20260104222523.329760-1-stephen@networkplumber.org>
 <20260201171938.89492-1-stephen@networkplumber.org>
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
index 0b6c9577cd..672459fe05 100644
--- a/drivers/net/null/rte_eth_null.c
+++ b/drivers/net/null/rte_eth_null.c
@@ -208,9 +208,6 @@ eth_dev_stop(struct rte_eth_dev *dev)
 {
 	uint16_t i;
 
-	if (dev == NULL)
-		return 0;
-
 	dev->data->dev_link.link_status = RTE_ETH_LINK_DOWN;
 
 	for (i = 0; i < dev->data->nb_rx_queues; i++)
@@ -228,25 +225,16 @@ eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t rx_queue_id,
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
 
@@ -262,24 +250,12 @@ eth_tx_queue_setup(struct rte_eth_dev *dev, uint16_t tx_queue_id,
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
 
@@ -740,7 +716,7 @@ rte_pmd_null_probe(struct rte_vdev_device *dev)
 static int
 rte_pmd_null_remove(struct rte_vdev_device *dev)
 {
-	struct rte_eth_dev *eth_dev = NULL;
+	struct rte_eth_dev *eth_dev;
 
 	if (!dev)
 		return -EINVAL;
-- 
2.51.0

