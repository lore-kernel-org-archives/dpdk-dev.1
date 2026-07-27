Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90875C53209
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Jul 2026 13:54:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3984440685;
	Mon, 27 Jul 2026 15:54:30 +0200 (CEST)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45]) by mails.dpdk.org (Postfix) with ESMTP id B4F694068E
 for <dev@dpdk.org>; Mon, 27 Jul 2026 15:54:28 +0200 (CEST)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-8f256eaedf8so28594736d6.2
 for <dev@dpdk.org>; Mon, 27 Jul 2026 06:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785160468; x=1785765268; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ngJUogwp9bU9UsEuenxdbR3UdVV7LRWg2iTziWt2fGg=;
 b=khLN1OVrNvZrmXmm9IhdA9qslrofkrsvxBBVKffRLgex7d44E/evedud3SsllRr/sK
 6t3bKz/QgU+Q6ye5lKGrDhRAT53bmV9K/F8VjYaJlcNrVFkAkqfKrhjHc35lLag+rLDI
 yACjB8L5zyjg/YLec6Vi+OrP5KjkwdlETQz8ciyW8orGWrtkC0RBYmRDBuzcAq4rq5K0
 liADWWhwy21tgqubkz7DbjHyrF3Qu4Nm535ouP6/dDOljpSzVzghc4tj3q2O9MlQm5aE
 Pj/1biiSsyTzxqqQ/7NfDwjk3EhQ/fFKwH9iqHzZn+1d5odW4eMisMnv3PRK0ixd7Lz2
 Hcuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785160468; x=1785765268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ngJUogwp9bU9UsEuenxdbR3UdVV7LRWg2iTziWt2fGg=;
 b=Z23Nyo72+56eQU65TIUgIkTQAqN2xtUakrSB8LM6w0Hd2Ks4fbX9fvB0vuyLFDlxwX
 gv1FVl91p84KuyJOtaPLL5AvVJS7iEipLY4Ia/Y4BWebzIoJ9Cnr7kPVksL1G6JCxWSx
 9LdJ1aHBOUEYEd5TeOaifxc1aPR+xOYoEnxWrRmZzmRU/WxdeNTqlLKG2QADkI6Kyg69
 rcdcSUUkdLZBj48X9FTfMRW/PGDHwbSINbweT+dpUehMFN7nq4i1vEMy0Vr3tIh9aEfE
 1HqU664weSRiBijrsfodqJYJ8LnsR/5ZAQOmzF6FbUKcLDiJE19ZVI+6t0fNvfnsvO5W
 fWbg==
X-Gm-Message-State: AOJu0Yyrb0RX8CsXO4gaNyob00mP6G8rfhY0zHOurjqvNV45pOlLAqTX
 NgTS4RG6yHVI6eOpOPoU4z1eIG5YHKbX70GTbTWz2eLklinTU1iY9lMa
X-Gm-Gg: AR+sD11pSryaxKPSrFpjazrNjkG7oqcJRQsDWO3SM9mYhTPihG0imPfStWMYOYEDceb
 g4xD4sz3HoXltpmhQ2ClvqT3NyUMwV7VpAhXmtzpD3DAteqCGaHkJe1w1+PXJE7c8G8L2amOr8u
 ikU0D5mlJcusB7uQRcriKC774duereuxY5U5MM95We2I3AL6o6VRuwLbEfNBqN+UCDGCgbH45WU
 RGBIOpZn9Rg2sxK/RQcWB+7a+YBMOVzZRpV6PEVTOrQGdaBh+CAC8NOKPkld9p7enkKx3HkHXV7
 q+u9/mM9hKnoviK+Y/DgAQ6MsX0Ll5cCX1Em/8HQ6U1hyoJUCQ55PFz3m1EMPVLAYjKNPRz+xKE
 JZ+P9Ho7BBSlGRxcpyah2o9ggY50RlysXEVtGedeEC5J1pIwSGW7u8Ov9z3CUv6f+ix39Qrjawv
 wwHf4IlQ2dBcMfMyw7v5gV30YOKnBJS8o=
X-Received: by 2002:ad4:5def:0:b0:904:75a6:450f with SMTP id
 6a1803df08f44-907ec814e3amr99619366d6.46.1785160467780; 
 Mon, 27 Jul 2026 06:54:27 -0700 (PDT)
Received: from freepad.iliad.local (free-mobile.vlq16.iliad.fr. [213.36.7.11])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-907e851b717sm65313496d6.7.2026.07.27.06.54.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 06:54:27 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, ferruh.yigit@amd.com, Maxime Leroy <maxime@leroys.fr>,
 stable@dpdk.org
Subject: [PATCH v3 3/4] net/tap: drain queue FD in Rx interrupt mode
Date: Mon, 27 Jul 2026 15:54:09 +0200
Message-ID: <20260727135411.2590931-4-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727135411.2590931-1-maxime@leroys.fr>
References: <20260727135411.2590931-1-maxime@leroys.fr>
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

In Rx interrupt mode the application does not busy poll: it waits on the
queue fd through the Rx interrupt API and bursts only after a wakeup. The
trigger is process wide and the signal is sent to the process, since the
fd owner is set with F_SETOWN and getpid(), so it is not necessarily
handled by the thread that was woken for that queue. The burst can
therefore run before the trigger has advanced and return 0 while the fd is
readable. The registration done by rte_intr_rx_ctl() is edge triggered
(EPOLLET), so no further wakeup comes for data that is already queued: the
packet waits for the next arrival, and the last one waits forever.

Seen with grout in interrupt mode: the echo reply to the first ping stays
in the fd until the second request creates a new edge, so the first ping
times out and the second burst returns both replies.

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
index 770d75f0c7..f846ce1fda 100644
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
index df9a8f8a7a..24fd055df9 100644
--- a/drivers/net/tap/rte_eth_tap.h
+++ b/drivers/net/tap/rte_eth_tap.h
@@ -51,6 +51,7 @@ struct rx_queue {
 	uint16_t queue_id;		/* queue ID*/
 	struct queue_stats stats;        /* Stats for this RX queue */
 	uint16_t max_rx_segs;           /* max scatter segments per packet */
+	bool intr_mode;                 /* Rx queue interrupt mode */
 	struct rte_eth_rxmode *rxmode;  /* RX features */
 	struct rte_mbuf *pool;          /* mbufs pool for this queue */
 	struct tun_pi pi;               /* packet info for iovecs */
@@ -95,6 +96,7 @@ struct pmd_internals {
 
 	struct rte_intr_handle *intr_handle;         /* LSC interrupt handle. */
 	bool intr_mode;                   /* Rx queue interrupt mode */
+	bool intr_mode_set;               /* intr_mode locked after configure */
 	int ka_fd;                        /* keep-alive file descriptor */
 	struct rte_mempool *gso_ctx_mp;     /* Mempool for GSO packets */
 };
-- 
2.43.0

