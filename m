Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69275E7FDE0
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 22:18:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E5B9F4066C;
	Mon,  2 Feb 2026 23:18:33 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 744E140668
 for <dev@dpdk.org>; Mon,  2 Feb 2026 23:18:33 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4806bf03573so24431315e9.2
 for <dev@dpdk.org>; Mon, 02 Feb 2026 14:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770070713;
 x=1770675513; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QTrlYKBvOhXDwdyHf13Jyi/97Ari/INIvdJmizJtVnU=;
 b=Zpd9rLO8zRCa/ibgadcxv21OzGcv1RGdjplSprD3ltYPDMw6AesY1rLt4b2qCwKUhg
 pl6De0QZ+ol9IReN7EJ3lkvgNXcqS5bPGHMHHatj9bqTAaeVmECDRYT6jvN5C/HFO9uz
 Z85g29NKSW4cf0FZyatsKFzYOUWpkQglkur01MJP7P5ao1A2r0G0LR9hp2ZI7HGtRGYJ
 zEuFnovJdV0wOYuM/oWgNPAO0IOcgnT8+dTjkkZZ2etmIo6meHiPTuGJuUcoKm7JkRTE
 zSeTk7/X6Li26MIMnXbizKUS1gbTD3lVxQbAPPxWRPdFqXgTH/2s61pL4CgmnS6d7V5D
 TdNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770070713; x=1770675513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QTrlYKBvOhXDwdyHf13Jyi/97Ari/INIvdJmizJtVnU=;
 b=bAJtVMfsBZ9SUM+qoJNQvwvkCeuo+4jXQvL/NiSQ//F2T97LiIgxq+lvWNNuPPH9wN
 qAJFf8y9mSDhY7fLiOQ8aQ9iMZF1c22D3dvk1+SkIAsky6Io4mPu+DtoHcetFub1SZKm
 tnuTbe+sF9eg33XfhWK9KsF2db/ZlvJ1sjnEE5Z9HKsPNlbT/mkGlGM/GDdqbFcXMZBM
 6HNJjlWg6aa3pcNOMCtGDU3CLfaJg5Ow0utiXkMBVQ9nK1/Mn7olMFvRtV7z5oxQuWET
 U9tH+DLl/6Pklx4qwTUPk6QYTLOz2nXcV763YKMF3m3zoj1URlpU4jNzDQ6WDi0z0vm1
 H9Sw==
X-Gm-Message-State: AOJu0YxfhOu2MwE42DIlxiuPFbRnDtKdJ7PUVltdtMT1kRAd7QtnXsJE
 Erj3p79kZf3R9SNcfPbmHF11+YirrFzGmlhO1Vg++0t3hzmzsgqbRbMONRmbsJMovIGQAC/j87I
 XvK/j
X-Gm-Gg: AZuq6aJPxFeARgUAM+z+hMUi6KPky3BXKmiyIq/uYGx8/IG0/o8Wt0uc4fUwcxVlEIC
 PFe+18J7QNHIlpy80S7XETaBNGdygpAAdYY48nl+z2HtFzH+akIXzYDqWM3UzhoakSLkm4hIY05
 PNF271bwJQXHa1qobYq09Qwf/4rLyLSqp6NJm7T4iNLB2LcnOnatLBXdK761pDhgPaxQ4Cm/HqG
 0JjFFjEmKZYsP210+bMlrkMc9YSNBnRBFj83LFcw/xA/JykWHFdf+MF0MXhaPAqGzxq+xoA0Zrl
 XfuR2GyFz0sQm4ncgnmRaT4HkIcva/VoYE8cAhSxTpzrD41RzHI3zhuacpdrvpVeUiNc5Ny2bfd
 Ix0jsHa8zK74brKzM27+rY2FJxjKSsno3jACYndOjgcwRyFZrHSbLOV9c25NT4gs4U8gJ7UOAvs
 MPHrbURK3HJfIfx+6hTWEyroCz/VkKqLCzVI1vGdacWkKDWTIy1g==
X-Received: by 2002:a05:600c:3b23:b0:477:7af8:c8ad with SMTP id
 5b1f17b1804b1-482db4a01edmr195607225e9.31.1770070713034; 
 Mon, 02 Feb 2026 14:18:33 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ee04csm47109336f8f.12.2026.02.02.14.18.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 14:18:32 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tetsuya Mukawa <mtetsuyah@gmail.com>
Subject: [PATCH v11 4/7] net/null: remove redundant argument validation
Date: Mon,  2 Feb 2026 14:16:49 -0800
Message-ID: <20260202221820.204680-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260202221820.204680-1-stephen@networkplumber.org>
References: <20260104222523.329760-1-stephen@networkplumber.org>
 <20260202221820.204680-1-stephen@networkplumber.org>
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

