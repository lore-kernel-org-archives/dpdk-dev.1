Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830D5C44507
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 09:59:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4391040ED9;
	Fri, 17 Jul 2026 11:59:08 +0200 (CEST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42]) by mails.dpdk.org (Postfix) with ESMTP id D353440E96
 for <dev@dpdk.org>; Fri, 17 Jul 2026 11:59:07 +0200 (CEST)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-47dec32798aso7808433f8f.1
 for <dev@dpdk.org>; Fri, 17 Jul 2026 02:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784282347; x=1784887147; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MrRcNFRtamuE5DiMtw4JN30BWfT/zCwE1hM0wBSO0vc=;
 b=rh+5OrDImvd7h602a6FoHzCYItJ+DDFgCO3iWotMM0TaTKenorVrJUipRJF4n44V/H
 Tbs4PVW4FpcWTq8Q30H1U40S2MDiXzjau1nICI92dDApiKlcG08zF25fBygcGVOd+U+D
 85oO9YCJ17yWSYhcz84IK1nG51kWsegjh0KMRocVa5f2AHgchZWy99vrGvqWhLBgKwYX
 XFc5pZhms3pE2h9BJLhe8ILvmmRDz0Ag7uHqHx9GHVzw//ThOuC0OjMyitbseQslfPhL
 JCPGTnAYoTO4tpkw0L570YLDHrYfmLHyjGZ2pE2I3RJAmy5+p1vWN4pujiWq8A/nVWb4
 Iufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784282347; x=1784887147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MrRcNFRtamuE5DiMtw4JN30BWfT/zCwE1hM0wBSO0vc=;
 b=knt/vRrgooH4/oIkvF0+s8z4ziV124g5oOvHebRUM/3BQ+oNwo2h4UBVfb+0aNpE6o
 jyNN0OwjPoHqE6y/iMXCgulGBxLFLtEd/CgOEsU4A50rHv8p6kq11Pq5e8vKG/lV/XzY
 deRvVL0zrownYZjB2OuaEQRfIOzpAQsm/3flzinx5LhF+R3Arkqsh6tqb/avY8CckGVH
 Otk0y/0+4CSQWEhb/7VoEE8HFkHROXpuRk5z2Zi4VjYbuMOAmN3U9eOMj1WhE4v2kSf0
 0hYv/5RJoGJGdIlcJ+92t/fIr8qO13y6SJCgg5QU1NR0LHZ/6G63AIRDHBoHpd4T2nM4
 Lihg==
X-Gm-Message-State: AOJu0Yzyeuz2qAkeicASi9HY4H9wxUruTqbtBMmvr8yRuXdKOeOCgRrO
 RV+84elSWDR4AtHAMbJJfgg5Kyw/vI5RAQy7rxvqE/SfDC6HWbIf7euNCRaa0T0F
X-Gm-Gg: AfdE7cmiEcfZyDJYKGrm0y/t1UVslxD/MvmjfgMXHX7M+0R0+DLY5QNb2PuN8exht/c
 ZntDL/QaCrlQwmWDW7KwngM1y4RyW8PB4E17ChWgig+aQyQpAsW/5OZdEQ5VIloaDabHD4gTpsc
 phz879dj8JIMLroqUxq9bBnUHoxeOM4hfhCcD5flgFj+NR3rIfbzHt4+QYZMbBQyuzwV3OjqR9n
 /TbkQoxlqiETrMupSwVNlZPPW73Y/YbbkC5ave8Hqr/9hvxQwI5MtNk7rUBFEkMM23FYs2kQsyR
 sy5ykSGuEkzsOOWFiEJ34J4nOtAvHYVztKiGbqQKeWDWyoTHgA55rnmZ2LwMiQBnYLqpV7Ky3UZ
 x1bTqKDKs9oABNaBKLriKKmbz2R8cb+jKfbYkqEiV8mNUMFR/4VfEEWXlSILQDsMuYI6sFyFoSL
 /S2W7F0VuY1EzR3xvpYqRhw2ar3qOjaAsGVjI48FRG
X-Received: by 2002:a05:6000:3103:b0:47e:4b03:4909 with SMTP id
 ffacd0b85a97d-47f6230e52cmr2781996f8f.18.1784282347040; 
 Fri, 17 Jul 2026 02:59:07 -0700 (PDT)
Received: from freepad.sicorp.iliad.local (free-mobile.vlq16.iliad.fr.
 [213.36.7.11]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63eeb360sm2390629f8f.34.2026.07.17.02.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 02:59:06 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH 2/2] net/tap: drain queue FD in Rx interrupt mode
Date: Fri, 17 Jul 2026 11:58:42 +0200
Message-ID: <20260717095842.419130-3-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717095842.419130-1-maxime@leroys.fr>
References: <20260717095842.419130-1-maxime@leroys.fr>
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
 drivers/net/tap/rte_eth_tap.c | 18 +++++++++++++++++-
 drivers/net/tap/rte_eth_tap.h |  2 ++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index 99ede19e49..ea9ef76335 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -254,6 +254,10 @@ tun_alloc(struct pmd_internals *pmd, int is_keepalive, int persistent)
 		goto error;
 	}
 
+	/* interrupt mode wakes through epoll on the data queue fd, not the SIGIO trigger */
+	if (pmd->intr_mode)
+		return fd;
+
 	/* Find a free realtime signal */
 	for (signo = SIGRTMIN + 1; signo < SIGRTMAX; signo++) {
 		struct sigaction sa;
@@ -477,7 +481,7 @@ pmd_rx_burst(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	unsigned long num_rx_bytes = 0;
 	uint32_t trigger = tap_trigger;
 
-	if (trigger == rxq->trigger_seen)
+	if (!rxq->intr_mode && trigger == rxq->trigger_seen)
 		return 0;
 
 	process_private = rte_eth_devices[rxq->in_port].process_private;
@@ -937,6 +941,16 @@ tap_dev_configure(struct rte_eth_dev *dev)
 	struct pmd_internals *pmd = dev->data->dev_private;
 	int intr_mode = !!dev->data->dev_conf.intr_conf.rxq;
 
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
@@ -947,6 +961,7 @@ tap_dev_configure(struct rte_eth_dev *dev)
 	}
 
 	pmd->intr_mode = intr_mode;
+	pmd->intr_mode_set = 1;
 
 	TAP_LOG(INFO, "%s: %s: TX configured queues number: %u",
 		dev->device->name, pmd->name, dev->data->nb_tx_queues);
@@ -1620,6 +1635,7 @@ tap_rx_queue_setup(struct rte_eth_dev *dev,
 	rxq->queue_id = rx_queue_id;
 	rxq->max_rx_segs = max_rx_segs;
 	rxq->rxmode = &dev->data->dev_conf.rxmode;
+	rxq->intr_mode = internals->intr_mode;
 
 	dev->data->rx_queues[rx_queue_id] = rxq;
 	int fd = tap_setup_queue(dev, rx_queue_id, 1);
diff --git a/drivers/net/tap/rte_eth_tap.h b/drivers/net/tap/rte_eth_tap.h
index 3180719c34..abe22aac9f 100644
--- a/drivers/net/tap/rte_eth_tap.h
+++ b/drivers/net/tap/rte_eth_tap.h
@@ -50,6 +50,7 @@ struct rx_queue {
 	uint16_t queue_id;		/* queue ID*/
 	struct queue_stats stats;        /* Stats for this RX queue */
 	uint16_t max_rx_segs;           /* max scatter segments per packet */
+	uint16_t intr_mode;             /* 1 when Rx queue interrupts are used */
 	struct rte_eth_rxmode *rxmode;  /* RX features */
 	struct rte_mbuf *pool;          /* mbufs pool for this queue */
 	struct tun_pi pi;               /* packet info for iovecs */
@@ -94,6 +95,7 @@ struct pmd_internals {
 
 	struct rte_intr_handle *intr_handle;         /* LSC interrupt handle. */
 	int intr_mode;                    /* Rx queue interrupt mode */
+	int intr_mode_set;                /* intr_mode locked after configure */
 	int ka_fd;                        /* keep-alive file descriptor */
 	struct rte_mempool *gso_ctx_mp;     /* Mempool for GSO packets */
 };
-- 
2.43.0

