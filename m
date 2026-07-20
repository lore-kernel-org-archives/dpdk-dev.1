Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D183AC44515
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Jul 2026 12:07:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4654D406B8;
	Mon, 20 Jul 2026 14:07:10 +0200 (CEST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id 6227840698
 for <dev@dpdk.org>; Mon, 20 Jul 2026 14:07:09 +0200 (CEST)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09e5so6225625f8f.1
 for <dev@dpdk.org>; Mon, 20 Jul 2026 05:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784549229; x=1785154029; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R2pFYm75PEQOm4evNS7f3hDsdlSmhzOB6oGDlGvlPS8=;
 b=S1rVDSafSGQxb1tQycitR7913NMqBrtV3nF89aHsZ5X+xr9ItipXKdRjTMmX51Pydd
 hmc7sstUW/1z/7j2ujEcL+JrPwx62QrOj2SXstH0SdzGJyoLfhelAXaF55cKNm/qdZ0y
 r/vp+0RyEu/fQsjlNmvGgIvTYmvTrnfsXcAnfhYJa1T33fQ9wPZV+o/v1SLr7iXyneI4
 VXn85EO5qCfjLKB/zMNLp1zsEO/UAg5UobDAuhJp2zTMbkRhiRq3gqE60nRHeQr2czrV
 u4YvQXp46b1ACtN63y0djyDJIbmAsfFLXGKdQUonq/8IJjj+ri0mQeNEqmFMbhQ2qlSW
 bZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784549229; x=1785154029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R2pFYm75PEQOm4evNS7f3hDsdlSmhzOB6oGDlGvlPS8=;
 b=J15yg5l8sxyIFzhQ+mayQYM83pU0PdmCRQBln0zy6vXGzC55leNfi88AHMqNutn6a8
 Qv6bqeNYpEQCq3ihqwZiEg+X6INcqY/Y8ocyGscSKCwbF9l1FHzJlFZjmEhlvEFCgLv+
 heiEUFVhOXBxzz7ahhm+pviqLZPWpdDACy0Y66y2qDB7O2FAqCw/k41Tui5d88Sl5+lY
 B4Rwhn4xsNK9ifkW0ernAzgRDqzGB2KmX+DFpTuPFqWAV5oqKIMMB5owdDx/UeiN2ADP
 WVZixckLlxVlX0SBb3R1/LlitKfBoddKAul5AltIp6pRBo3X5+8LP0VmOSuzcDV3HfJk
 2YHA==
X-Gm-Message-State: AOJu0YzViDmR/dvSLvCK+uXU0vLE+wwnzIHITB4LA9l2tsYHQEJ6F/kj
 zMc7kZSA1wn/85I9Lg20QpX5NvVEqlsrs8z7qrP5diSlkUVGgvPQZeosotD8a9EP
X-Gm-Gg: AR+sD13JF2Wzs2ow5OcImttfT95LOevc7e4vZ4O5CTOCgAE9hqsiRxBOZiCP3hzEeWy
 pLJtx8r3wwDp8jCtSWZVucqIzq44JhzszEf8Mp7HPNw0Sn9OVX3kHMXyg604SQDfKXjlmX4mR02
 zBEEwmRV70HgrjAiAu+Nk7p7LaPcdMg3MQjYGFx4OW3uw2UDnkWrf8Zlgl7Q4RrjLxijrF3S2Hn
 t4++yDugALdEyE+avZ/dqTiWIF9LJ0syGicc7A4BrJmsfyEqI/QFZZBmstzinwAQCjDLk2C8VUu
 DROhMIhnwlxjjZLiDSl9iiloRC4GFoR0uV5UzoR5LHJ4QKw0LsDUOlMw1jSRPuZUkuFw9QMe+jG
 pQMslGmMfdXqnZ0rHlxjK9yXWMGK9IYc2ZG58Uzh60hDR5c3q6wwHFXkcNXYssDM7jbjjUiu/4B
 vjYnFxGR1AmI1xpSDAWEeMV4RebfJ7t/FMRg==
X-Received: by 2002:a05:6000:491c:b0:47f:73fb:daa1 with SMTP id
 ffacd0b85a97d-47f73fbdae1mr7073762f8f.19.1784549228829; 
 Mon, 20 Jul 2026 05:07:08 -0700 (PDT)
Received: from localhost.localdomain (free-mobile.vlq16.iliad.fr.
 [213.36.7.11]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63ec7ea1sm30303491f8f.24.2026.07.20.05.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 05:07:07 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Moti Haimovsky <motih@mellanox.com>, Pascal Mazon <pascal.mazon@6wind.com>
Subject: [PATCH v2 2/3] net/tap: drain queue FD in Rx interrupt mode
Date: Mon, 20 Jul 2026 14:06:58 +0200
Message-ID: <20260720120700.801099-3-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720120700.801099-1-maxime@leroys.fr>
References: <20260717095842.419130-1-maxime@leroys.fr>
 <20260720120700.801099-1-maxime@leroys.fr>
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

The tap Rx path is driven by a SIGIO trigger: pmd_rx_burst() returns
without reading the queue fd unless tap_trigger, bumped by the O_ASYNC
signal handler, has advanced. That avoids a readv() on every empty poll.

In Rx interrupt mode the application blocks on the queue fd through epoll
and polls only after a wakeup. The epoll wakeup and the trigger are
distinct signals, so the burst can return 0 right after a wakeup because
the trigger has not advanced, leaving the fd readable with no further
edge: traffic stalls.

When the port is configured for Rx interrupts, drain the fd
unconditionally in the burst and do not arm the SIGIO trigger on the data
queue fd. A data queue fd can be closed and recreated on a later setup,
so the mode must stay constant to keep every fd on the same SIGIO policy:
it is fixed at configure time and a later change is rejected. Close and
reopen the port to switch modes.

Fixes: 4870a8cdd968 ("net/tap: support Rx interrupt")
Cc: stable@dpdk.org

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/net/tap/rte_eth_tap.c | 20 +++++++++++++++++++-
 drivers/net/tap/rte_eth_tap.h |  2 ++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index dc56c974da..882bb5aa71 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -254,6 +254,12 @@ tun_alloc(struct pmd_internals *pmd, int is_keepalive, int persistent)
 		goto error;
 	}
 
+	/* data queue fds in interrupt mode wake through epoll, not the SIGIO
+	 * trigger; the keep-alive fd always keeps SIGIO
+	 */
+	if (!is_keepalive && pmd->intr_mode)
+		return fd;
+
 	/* Find a free realtime signal */
 	for (signo = SIGRTMIN + 1; signo < SIGRTMAX; signo++) {
 		struct sigaction sa;
@@ -477,7 +483,7 @@ pmd_rx_burst(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	unsigned long num_rx_bytes = 0;
 	uint32_t trigger = tap_trigger;
 
-	if (trigger == rxq->trigger_seen)
+	if (!rxq->intr_mode && trigger == rxq->trigger_seen)
 		return 0;
 
 	process_private = rte_eth_devices[rxq->in_port].process_private;
@@ -937,6 +943,16 @@ tap_dev_configure(struct rte_eth_dev *dev)
 	struct pmd_internals *pmd = dev->data->dev_private;
 	bool intr_mode = dev->data->dev_conf.intr_conf.rxq;
 
+	/* The queue fd is created once and its SIGIO trigger is armed for poll
+	 * mode only; the interrupt mode cannot be toggled on an existing port.
+	 */
+	if (pmd->intr_mode_set && pmd->intr_mode != intr_mode) {
+		TAP_LOG(ERR,
+			"%s: Rx interrupt mode is fixed after configure, close and reopen the port to change it",
+			dev->device->name);
+		return -ENOTSUP;
+	}
+
 	if (dev->data->nb_rx_queues != dev->data->nb_tx_queues) {
 		TAP_LOG(ERR,
 			"%s: number of rx queues %d must be equal to number of tx queues %d",
@@ -947,6 +963,7 @@ tap_dev_configure(struct rte_eth_dev *dev)
 	}
 
 	pmd->intr_mode = intr_mode;
+	pmd->intr_mode_set = true;
 
 	TAP_LOG(INFO, "%s: %s: TX configured queues number: %u",
 		dev->device->name, pmd->name, dev->data->nb_tx_queues);
@@ -1620,6 +1637,7 @@ tap_rx_queue_setup(struct rte_eth_dev *dev,
 	rxq->queue_id = rx_queue_id;
 	rxq->max_rx_segs = max_rx_segs;
 	rxq->rxmode = &dev->data->dev_conf.rxmode;
+	rxq->intr_mode = internals->intr_mode;
 
 	dev->data->rx_queues[rx_queue_id] = rxq;
 	int fd = tap_setup_queue(dev, rx_queue_id, 1);
diff --git a/drivers/net/tap/rte_eth_tap.h b/drivers/net/tap/rte_eth_tap.h
index 51fd2339fc..aae9eea510 100644
--- a/drivers/net/tap/rte_eth_tap.h
+++ b/drivers/net/tap/rte_eth_tap.h
@@ -50,6 +50,7 @@ struct rx_queue {
 	uint16_t queue_id;		/* queue ID*/
 	struct queue_stats stats;        /* Stats for this RX queue */
 	uint16_t max_rx_segs;           /* max scatter segments per packet */
+	bool intr_mode;                 /* 1 when Rx queue interrupts are used */
 	struct rte_eth_rxmode *rxmode;  /* RX features */
 	struct rte_mbuf *pool;          /* mbufs pool for this queue */
 	struct tun_pi pi;               /* packet info for iovecs */
@@ -94,6 +95,7 @@ struct pmd_internals {
 
 	struct rte_intr_handle *intr_handle;         /* LSC interrupt handle. */
 	bool intr_mode;                   /* Rx queue interrupt mode */
+	bool intr_mode_set;               /* intr_mode locked after configure */
 	int ka_fd;                        /* keep-alive file descriptor */
 	struct rte_mempool *gso_ctx_mp;     /* Mempool for GSO packets */
 };
-- 
2.43.0

