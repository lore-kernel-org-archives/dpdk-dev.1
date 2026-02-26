Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAC9FCE095
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 14:34:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52A7540668;
	Thu, 26 Feb 2026 15:34:09 +0100 (CET)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id 634C04060C
 for <dev@dpdk.org>; Thu, 26 Feb 2026 15:34:05 +0100 (CET)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-43767807cf3so654841f8f.1
 for <dev@dpdk.org>; Thu, 26 Feb 2026 06:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772116445; x=1772721245; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3vt8PICzTXkD6tqnZ9Uj/2dpldyb3jBsCGizuoHJd/A=;
 b=kWZf5a8wwfqiA8yQWWhBOzCz6sh0lZ4tlz89w58MMUt5aM/ieCIVtGLGcvwejvUsCr
 zSbkT9xWGUvBSr/SEy0K1P0PJErPyn3iRE1lnnckEM0r+sP5T4+R2sBsRmKK9tLR+MJv
 tqg1D1VdgGN3PbegX06KFAOfYWkwgQSkEx9Qt/dGpYNQnDnou/Ue7w2tKumt9YCqbgjA
 iouxE/ViR5BqQiLizSzyMbFpZtRJSMDpylf2TnWgBORCfLX/36XcEmN9cTYneDawym2w
 Np9+yjwrYsIZfheq2HWlvrnX1hjeQClfzB9MxI1eHAaBMV8YVt5B3zdzB/WYEj59kgBa
 0H5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772116445; x=1772721245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3vt8PICzTXkD6tqnZ9Uj/2dpldyb3jBsCGizuoHJd/A=;
 b=WkEfuqg4D+fiWgOkIwnC7Gbw5cJ7lJpBO+XJ0R9NRx3gccc4rYnziMokkzKbekii8D
 McjMwNdX7LQoq+A03xlR/FHPRtIaxhM9kuuBKQk0mp3xVtQHVwF1MzMhZHdf21l9Brbt
 c6qVXg8aP7b2GiUl1Xhp+mOa+fHEs2pUZ6kDTjAuu5J6XcJedwqCiCHI+sINpFizlN2V
 jVvODswuImUzm3/uEjeaHSNfTywQeaDhWsD70/YQDovjNwWe4JdQGwSLXzHbT/fXoyog
 ZZAhBERAyJmnAzvDz/MNHtD/3QUK1F0mcVuQBbOvQPLvkqpR0O15dN+J5V0HErtBzyQ7
 G41A==
X-Gm-Message-State: AOJu0YzvjpUBjgwgeRfYZvFVIGWR6NNTj6A8FyAsJIxyJzTidF6Sj9Cs
 z5y2CkRX+/AMJi/OAt67cUX2c3oh87OcqijvD8WXbUuD84/4IzKlH7VX0k1nAQ==
X-Gm-Gg: ATEYQzxTNqtVCXHxUYGzE2jieKrIpcaZRlNU0WThuvFBkCS68E6Q4Z2vxrS2bA45b0u
 bKBZTJxxLD3lXSMI5J6Sdfxg60VjWg/Hb5aoWg3TlxbByr/5kQD7emiJDlwDn4E4UusWweWexKF
 D1V7+cHmw0rP6tiq4ta8n+E/4hTNP7/oUn7KrqF/bv79nyZkF1xP/x2IEdkgaxn3W8wm3GoPOi3
 Ooi501wIo+PPrwGe1CxmiBCKxrzxCIPaadEemevtMNbd4Z3nH2olX3vVRJ3KrNFEgnKn+TNCCW7
 E6N3WM+V2OHwwFeCiT3RaLT3hs0EdLiI320WmyC105sVGDJ9yWTrX/roDZCcpCWW3QWytelUNd8
 grgx5YXFLcM/M1gGAy4RqUmH2vZlnhRkMYGJaHxYISHXGwA1jP9QTvTU8AA30v67DyQHBCNAIfb
 jIPo+WGj4ZVzyAL/bplW8rJZYr5w==
X-Received: by 2002:a05:6000:4312:b0:439:93dd:7387 with SMTP id
 ffacd0b85a97d-4399429d1bbmr8191052f8f.3.1772116444844; 
 Thu, 26 Feb 2026 06:34:04 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.96])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4398bb96b90sm17993866f8f.9.2026.02.26.06.34.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 06:34:04 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 david.marchand@redhat.com, Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org
Subject: [PATCH v2 02/17] net/dpaa2: fix rx error queue memory leaks
Date: Thu, 26 Feb 2026 15:33:26 +0100
Message-ID: <20260226143341.282188-3-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218160453.142311-1-maxime@leroys.fr>
References: <20260218160453.142311-1-maxime@leroys.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The rx_err_vq is allocated separately with rte_zmalloc() in
dpaa2_alloc_rx_tx_queues(), but is never properly freed in two paths:

1. On port close: dpaa2_free_rx_tx_queues() only frees the q_storage
contents via dpaa2_queue_storage_free() — the dpaa2_queue struct itself
is never freed, leaking memory on every port close.

2. On allocation error: the fail: path frees the error queue's
   q_storage but never frees the rx_err_vq struct itself, which was
   separately allocated with rte_zmalloc(). This has been missing
   since the error queue was first introduced.

Add the missing rte_free() calls and NULL assignments in both paths.

Also replace the DPAAX_RX_ERROR_QUEUE_FLAG check with a direct
priv->rx_err_vq NULL check, which is safe because rx_err_vq is
zero-initialized and only set when the flag is active. This avoids a
NULL dereference if rx_err_vq allocation itself fails and also
simplifies the cleanup in dpaa2_free_rx_tx_queues() for consistency.

As a defensive measure, also add a NULL guard to the
dpaa2_queue_storage_free() macro to prevent NULL pointer dereference
from callers in error paths.

Fixes: 46d02eeaaeb8 ("net/dpaa2: fix queue freeing")
Fixes: 4690a6114ff6 ("net/dpaa2: enable error queues optionally")
Cc: stable@dpdk.org

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h | 16 +++++++++-------
 drivers/net/dpaa2/dpaa2_ethdev.c        |  8 ++++++--
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
index 10bc191645..e625a5c035 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
@@ -223,13 +223,15 @@ struct swp_active_dqs {
 
 #define dpaa2_queue_storage_free(q, num) \
 ({ \
-	int i; \
-	\
-	for (i = 0; i < (num); i++) { \
-		if ((q)->q_storage[i]) { \
-			dpaa2_free_dq_storage((q)->q_storage[i]); \
-			rte_free((q)->q_storage[i]); \
-			(q)->q_storage[i] = NULL; \
+	if (q) { \
+		int i; \
+		\
+		for (i = 0; i < (num); i++) { \
+			if ((q)->q_storage[i]) { \
+				dpaa2_free_dq_storage((q)->q_storage[i]); \
+				rte_free((q)->q_storage[i]); \
+				(q)->q_storage[i] = NULL; \
+			} \
 		} \
 	} \
 })
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index cef819650b..eb8333458e 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -620,9 +620,11 @@ dpaa2_alloc_rx_tx_queues(struct rte_eth_dev *dev)
 		priv->rx_vq[i--] = NULL;
 	}
 
-	if (priv->flags & DPAAX_RX_ERROR_QUEUE_FLAG) {
+	if (priv->rx_err_vq) {
 		dpaa2_q = priv->rx_err_vq;
 		dpaa2_queue_storage_free(dpaa2_q, RTE_MAX_LCORE);
+		rte_free(dpaa2_q);
+		priv->rx_err_vq = NULL;
 	}
 
 	rte_free(mc_q);
@@ -688,9 +690,11 @@ dpaa2_free_rx_tx_queues(struct rte_eth_dev *dev)
 				priv->tx_conf_vq[i] = NULL;
 			}
 		}
-		if (priv->flags & DPAAX_RX_ERROR_QUEUE_FLAG) {
+		if (priv->rx_err_vq) {
 			dpaa2_q = priv->rx_err_vq;
 			dpaa2_queue_storage_free(dpaa2_q, RTE_MAX_LCORE);
+			rte_free(dpaa2_q);
+			priv->rx_err_vq = NULL;
 		}
 
 		/*free memory for all queues (RX+TX) */
-- 
2.43.0

