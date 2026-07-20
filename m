Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE0BC4451B
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Jul 2026 08:01:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E19F402EB;
	Mon, 20 Jul 2026 10:01:00 +0200 (CEST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42]) by mails.dpdk.org (Postfix) with ESMTP id 553C840647
 for <dev@dpdk.org>; Mon, 20 Jul 2026 10:00:58 +0200 (CEST)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-4728c12ba97so4816815f8f.0
 for <dev@dpdk.org>; Mon, 20 Jul 2026 01:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784534458; x=1785139258; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yn6Y7O2b2+HZmTPSzom9dbCPYID6//vt2q0/JQo/LsI=;
 b=rx4L2lBA7wOYZ7uIYIlRNhQVaBdjY9pyxFSCAgc5PUGCI4IhFglJI2lYJay1IpmJmE
 YOJX03r9tTyiGswVP6bYO2etHYVVUjP2MInmmfO7r8sGdS4WaQBLV78MC4kcp+6N6X1S
 jSKgxxPR3dsIfwdOZx8dB1OBQuMOy3IgPa3H9Vk7cHoCGMzfrlpmHlRaSCQDYeL7dnWS
 JSs/ML7/iTar8gaS0WgdBsZE2Vtk+0UVVDzBwst2pmQa0oHMEnWv1oAGtPZEP+WbgM2p
 fyQ+DN5GpAmG2g3KcsXCwVztr9TAneTKLUxZUuWqK7L3fB3lQIWX/jHvyI9wm2/giki1
 qWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784534458; x=1785139258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yn6Y7O2b2+HZmTPSzom9dbCPYID6//vt2q0/JQo/LsI=;
 b=MwpPOrz83IV41Ny/7kJnpi/qOxNLaB5pUDQqFplHm86GlCh+cO/t9uGog7spCupo3n
 QQZPMqGYCN6cV8fTwJcQfHPrxOlu7ItR45cyjQl3SlMfCm4PXg8NtFAaYKYNb+4VStto
 v72j8Lv4wnWHxdx1c4u270mGjYvwYoVDu1vytH8rgpbgjNg8xHfrJYhqQYRVgsxGzSWF
 9c5xztlXc/WdaL8hgFzeDOzWDToHALmfPGsfGqQsacQE1L90ZEU7Y2bu/gj+8sdwbpDP
 fJDwBce+jyyFgiXDRGCbBAQMD18ln1XDnN98GHgmQ41lYZNgarqn9O00Mc1nsc2uAqvd
 WXtQ==
X-Gm-Message-State: AOJu0YwyFRNVHT0mQg9IofKVDVGhiQrK4b7jYe6enfgJfS1sjnDDfedf
 LyQzL57bqYJsDKrE4VCQW1ibqnSqtGwsjTpIUKU79KDWFRLzshXU8mJqOEt1Qg==
X-Gm-Gg: AfdE7ckGbnS0gRwSpZJan9htJBuT8INBYuWe+sF+5dTIQoohPymaKaMxWzIVR3X7/yR
 za8BG3gzoH0rr6Yy6sjPRB6NDw4ns+1J2E+67+TgVrcEev7X2RS9QhWnKdpnk+3327uxAZuhGZo
 cycnhtWYx/iGKUUeVnLZpbarka4uR1VIFGntk34AU6sI5t8qllMzKtqzuOvKxGKp1enysynwyNO
 CNYo9TNvzhW1oVyqBKqmBHf2JxMHARt5B63r/Npraooxbi3L0C58hmr2XVg/b8vfUwaOfFOusQI
 tXTqUMly9Uk/UuCsbnJQMdpDXHoFP8HXX2TyK/tcWcd8yguL9nq0DUa3DzAFHL7Zl6ZBuXBOp3z
 xbGqgqmXUMCp/7csNPQ53gR3mXb3Kt0/5rVqPgRYt4teRca6OjkhJc9c/ZhCXQqrIVh28meox3q
 51wifU2eDor1jFe58VErGzeZOkcAFODyUiUaU5VXoVD/qQcsqluUA=
X-Received: by 2002:a05:6000:1ac9:b0:477:3986:9b54 with SMTP id
 ffacd0b85a97d-47f623157a6mr15354360f8f.20.1784534457769; 
 Mon, 20 Jul 2026 01:00:57 -0700 (PDT)
Received: from freepad.sicorp.iliad.local (free-mobile.vlq16.iliad.fr.
 [213.36.7.11]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e496ffsm27289260f8f.3.2026.07.20.01.00.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 01:00:57 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: anatoly.burakov@intel.com, sivaprasad.tummala@amd.com,
 Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH 2/6] examples/l3fwd-power: check Rx interrupt enable errors
Date: Mon, 20 Jul 2026 10:00:31 +0200
Message-ID: <20260720080035.673782-3-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720080035.673782-1-maxime@leroys.fr>
References: <20260720080035.673782-1-maxime@leroys.fr>
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

rx_interrupt_wait() enabled the Rx queue interrupts of an lcore through
turn_on_off_intr() and ignored the return of
rte_eth_dev_rx_intr_enable(). Some PMDs report a transient condition
there: for example dpaa2 returns -EAGAIN when it finds traffic already
queued while arming, meaning the queue was not armed and the lcore must
poll rather than sleep.

Split the helper into rx_intr_enable_all(), which returns the error and
unwinds the queues it already armed, and rx_intr_disable_all(). Return
the error from rx_interrupt_wait(); in the sleep path, on -EAGAIN go back
to polling, and on any other error give up interrupt mode for the lcore
instead of sleeping on unarmed queues.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 examples/l3fwd-power/main.c | 74 ++++++++++++++++++++++++++++++++-----
 1 file changed, 64 insertions(+), 10 deletions(-)

diff --git a/examples/l3fwd-power/main.c b/examples/l3fwd-power/main.c
index 764899217c..70f76d202e 100644
--- a/examples/l3fwd-power/main.c
+++ b/examples/l3fwd-power/main.c
@@ -863,12 +863,32 @@ sleep_until_rx_interrupt(int num, int lcore)
 	return 0;
 }
 
-static void turn_on_off_intr(struct lcore_conf *qconf, bool on)
+static void
+rx_intr_disable_all(struct lcore_conf *qconf)
 {
+	struct lcore_rx_queue *rx_queue;
+	uint16_t queue_id;
+	uint16_t port_id;
 	int i;
+
+	for (i = 0; i < qconf->n_rx_queue; ++i) {
+		rx_queue = &(qconf->rx_queue_list[i]);
+		port_id = rx_queue->port_id;
+		queue_id = rx_queue->queue_id;
+
+		rte_spinlock_lock(&(locks[port_id]));
+		rte_eth_dev_rx_intr_disable(port_id, queue_id);
+		rte_spinlock_unlock(&(locks[port_id]));
+	}
+}
+
+static int
+rx_intr_enable_all(struct lcore_conf *qconf)
+{
 	struct lcore_rx_queue *rx_queue;
 	uint16_t queue_id;
 	uint16_t port_id;
+	int i, ret;
 
 	for (i = 0; i < qconf->n_rx_queue; ++i) {
 		rx_queue = &(qconf->rx_queue_list[i]);
@@ -876,12 +896,26 @@ static void turn_on_off_intr(struct lcore_conf *qconf, bool on)
 		queue_id = rx_queue->queue_id;
 
 		rte_spinlock_lock(&(locks[port_id]));
-		if (on)
-			rte_eth_dev_rx_intr_enable(port_id, queue_id);
-		else
-			rte_eth_dev_rx_intr_disable(port_id, queue_id);
+		ret = rte_eth_dev_rx_intr_enable(port_id, queue_id);
 		rte_spinlock_unlock(&(locks[port_id]));
+		if (ret != 0)
+			goto fail;
 	}
+
+	return 0;
+
+fail:
+	while (--i >= 0) {
+		rx_queue = &(qconf->rx_queue_list[i]);
+		port_id = rx_queue->port_id;
+		queue_id = rx_queue->queue_id;
+
+		rte_spinlock_lock(&(locks[port_id]));
+		rte_eth_dev_rx_intr_disable(port_id, queue_id);
+		rte_spinlock_unlock(&(locks[port_id]));
+	}
+
+	return ret;
 }
 
 static int event_register(struct lcore_conf *qconf)
@@ -910,12 +944,18 @@ static int event_register(struct lcore_conf *qconf)
 	return 0;
 }
 
-static void
+static int
 rx_interrupt_wait(struct lcore_conf *qconf)
 {
-	turn_on_off_intr(qconf, 1);
+	int ret;
+
+	ret = rx_intr_enable_all(qconf);
+	if (ret != 0)
+		return ret;
+
 	sleep_until_rx_interrupt(qconf->n_rx_queue, rte_lcore_id());
-	turn_on_off_intr(qconf, 0);
+	rx_intr_disable_all(qconf);
+	return 0;
 }
 
 /* Main processing loop. 8< */
@@ -931,6 +971,7 @@ static int main_intr_loop(__rte_unused void *dummy)
 	uint32_t lcore_rx_idle_count = 0;
 	uint32_t lcore_idle_hint = 0;
 	int intr_en = 0;
+	int ret;
 
 	const uint64_t drain_tsc = (rte_get_tsc_hz() + US_PER_S - 1) /
 				   US_PER_S * BURST_TX_DRAIN_US;
@@ -1062,7 +1103,13 @@ static int main_intr_loop(__rte_unused void *dummy)
 			else {
 				/* suspend until rx interrupt triggers */
 				if (intr_en) {
-					rx_interrupt_wait(qconf);
+					ret = rx_interrupt_wait(qconf);
+					if (ret == -EAGAIN)
+						goto start_rx;
+					if (ret != 0) {
+						intr_en = 0;
+						continue;
+					}
 					/**
 					 * start receiving packets immediately
 					 */
@@ -1214,6 +1261,7 @@ main_legacy_loop(__rte_unused void *dummy)
 	uint32_t lcore_rx_idle_count = 0;
 	uint32_t lcore_idle_hint = 0;
 	int intr_en = 0;
+	int ret;
 
 	const uint64_t drain_tsc = (rte_get_tsc_hz() + US_PER_S - 1) / US_PER_S * BURST_TX_DRAIN_US;
 
@@ -1376,7 +1424,13 @@ main_legacy_loop(__rte_unused void *dummy)
 			else {
 				/* suspend until rx interrupt triggers */
 				if (intr_en) {
-					rx_interrupt_wait(qconf);
+					ret = rx_interrupt_wait(qconf);
+					if (ret == -EAGAIN)
+						goto start_rx;
+					if (ret != 0) {
+						intr_en = 0;
+						continue;
+					}
 					/**
 					 * start receiving packets immediately
 					 */
-- 
2.43.0

