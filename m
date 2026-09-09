Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D0DC79FB7
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Sep 2026 15:05:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F84441153;
	Wed,  9 Sep 2026 17:04:58 +0200 (CEST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id 2CD0C41148
 for <dev@dpdk.org>; Wed,  9 Sep 2026 17:04:57 +0200 (CEST)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-486955ae01eso123102f8f.0
 for <dev@dpdk.org>; Wed, 09 Sep 2026 08:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788966297; x=1789571097; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yn6Y7O2b2+HZmTPSzom9dbCPYID6//vt2q0/JQo/LsI=;
 b=T8bO76NqMArbD1iNNLi3whoJ9KS9kSO8Fol/kRy2w3NaQ4yCPgZhfVSvQZhOvMoVwE
 tDWZLnlc19rfB7mMp912MHvfeZ+t9IaPerCYAV7rJNDNd6N0qXOKXZTEfVonuQlDMX2S
 uiBp+0fe4ewFjruFBFnDd/MDeTOarlsqzwtLrSg/AcTkN9kRQISTkXsNhIIAJukEnlQs
 1eBMRLSShH+r/No6zdqZlGGZ4lXFe3F75OS3z3qoAx9WfOeAyrKREHQKO8hisU00uGpv
 5/HdG1GJrhaIOowVgB/GU3o2c09JCj0oOxUHmOPXqPSaVFeSYHqwzsoToB4nz6Xnl9it
 PTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788966297; x=1789571097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yn6Y7O2b2+HZmTPSzom9dbCPYID6//vt2q0/JQo/LsI=;
 b=VopQTdWwB/nSM9cS8/ZX8VuzooPh65U4acWnX6sIifjVLytG6UBr8SWB9IYTggtOvs
 VSENSFJO1CBaBA/1sMteS6Bl4aEsNhjd7yJ0vBS+47p3IvhUnfBaHcAZ+8d4Z8pob/NL
 pU5I5Ive6WHHcdr0uwfYfrmaNALA4U7u2aH7rr3WFDUd4toXLvYhaPlgtWQEeuk0exjY
 KudchmJcHJQz9GbZe2YgPqyHjzfWTQrgbRy5oeXWZWPjRMZKybyD4geHPyx/tv7IsRu/
 0YbHVJ+kv3MPS0vqLa15QhpZkIJWYnE1zVLm+Ypyoe9a35MsYAmUOc31MzSJOZtbHgyv
 yodA==
X-Gm-Message-State: AFuF++k042HlBu2D+7OL6eV034qFrY26No5ZSO9m8PG41OotNQxEJk7X
 chB/wrFDvy748dUKBUd05mBRgOk3rXh2We4dUcMneYeWR8XvPjYvfAbdrTPfaQ==
X-Gm-Gg: AYBFou2ddisk/veVEwvlxEHjBdGY4DKifDBxUjZM4+NFOKr8tPvd6UwIy8PnFHoIhMP
 H6Bc7g5OjWtxL4aeQLs7E5GSpQFWCIXmA6ZibP3aNqJBfCcs/MEusQpFOrLPZCx3L2uRq6qeptB
 sJ2mIh7qGQM9VupPUMdaAz3ZwyHtERr6tGC9ALlD1vgpXyOJ6IjSjBabjZGVF3N8p4Nni5/v4kI
 mF9y6frrDWWB8yTnIU6ZQeqW1Zp0O9lfHlrNuzH7anrD9S5Wqhuhj8XIuyRRy2KvC9rLUOrXIaP
 v78HmD2yaZWLXOaB+2gOz5jEUc6DJTJGr1vRosRAtXcJfO1IZGB/Yhz5p0ZfsKbN94Q8zz4QWfU
 Eyokq8LUI6/tgbtxDjbltRTCEgrGPTccIGRu7TbP+EDaGA3J6euAQbTT+Zjwn2rO+5rxvjD8wyB
 vQc7JFtInuaOZnN6Ecknd153AdDrB+oKOQ6NCuJdh6WxuDV7HtyVr/uO9nd6NbYNz9LtG0IBkiH
 5PKQwb3IhyfE8YeTdYRYYHpntDahqkGm6FOycSw5xgXRkpkGOx2dS52SZB5
X-Received: by 2002:a05:600c:1c23:b0:49c:eb16:9fd with SMTP id
 5b1f17b1804b1-49cf820a8e3mr396792275e9.3.1788966296598; 
 Wed, 09 Sep 2026 08:04:56 -0700 (PDT)
Received: from freepad.iliad.local (free-mobile.vlq16.iliad.fr. [213.36.7.11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf7703cefsm634279285e9.5.2026.09.09.08.04.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 08:04:56 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, anatoly.burakov@intel.com,
 sivaprasad.tummala@amd.com, Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v2 2/6] examples/l3fwd-power: check Rx interrupt enable errors
Date: Wed,  9 Sep 2026 17:04:45 +0200
Message-ID: <20260909150449.856295-3-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909150449.856295-1-maxime@leroys.fr>
References: <20260720080035.673782-1-maxime@leroys.fr>
 <20260909150449.856295-1-maxime@leroys.fr>
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

