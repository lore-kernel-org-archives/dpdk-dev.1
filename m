Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17B7606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 18:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TAF5dhKe
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7630F40611;
	Tue, 27 Oct 2026 19:58:28 +0100 (CET)
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mails.dpdk.org (Postfix) with ESMTPS id 6D24C40698
 for <dev@dpdk.org>; Tue, 27 Oct 2026 19:58:27 +0100 (CET)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cd61bdc8683so124435a12.3
 for <dev@dpdk.org>; Tue, 27 Oct 2026 11:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793127506; x=1793732306; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ywtheBdE6lXWGVFGZQuqE5rZ3uFBebM1bdIsruQcvk4=;
 b=TAF5dhKe4CM5NHty9Ae60XzSYA4fcOIfXXIV24EFy9sfsHVTgkj10JmJp71/HANCvs
 wGi4RAtgDPlmaoSLEi5F8UlMbXv0FSoqBUuuXNsFAQwjBc9/njGr8ersUHK649kk1LCi
 fhMfsx5TTueCdjX7hoIlKs3Nuh9SJX4mK2W/YVZh4Q8i9BQvjT01JfeLw/xcMOyeEeR0
 nfKA7CAgPHq1DSKcoQ/BSfCF7U63ZGxL3Lht9JBJDtgjEaaQcyYXiv0CYQAgIBjsWF23
 RI9dpno0AhGq4bunEhOUADLiL8GYfKEny+GRBkPLSqff+szgY0jHEwRsVlKV8qa1S+Ke
 4yPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793127506; x=1793732306;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ywtheBdE6lXWGVFGZQuqE5rZ3uFBebM1bdIsruQcvk4=;
 b=lGZobw8vJWMH4kIdC3MfRydIGovExtzngzIOb9gwO4N5ZZQKCOFh1H5SN5rl/bMOcb
 +SrFKx+FT/thkS0VWKuvCd24qlAMXdexD7uHRr0O0NDpQsKn5jWgnmSE3ZjESYfOhYS+
 vTfoyti386I+nG91bLBYjgaQB6A4SarbuIhLyyueZvmkKkifuNLWXNFmaxRM/nWWHNjf
 j7MTDXazcYeHWMofn/fSYwvoP/5wz2FtzN4Js4owFpr19U7MXAhiGl1ujZ0hrMHWUUb3
 W6YjkG0hpaZX5SgivfB/vG+zOntDFzFPCt97Ypc1pCvgWBfJ3D906G5o6bOjnCr6LWpH
 ziZg==
X-Gm-Message-State: AFq9FYIj5hYo2ygdA9hrBnpvh9xXZnlx0NqM7nstTxHiN4YbbEqmAejf
 jci6t4ziZqrJuavgtydHmRC+XdAiATkSolLOVrUmmcemMQ8tRTQU4zyEOKGEToczgDqLHQbiy2k
 mt3/Mvijabv3ShHYY2n46i9+zGhKrclVInV934+rZjlYIbxdG6x/kzq6KuLvQb8NvRojhNZ/zuy
 0w1cro9HKXwDC9g5CX0SHWutjECAOa7rG34mwPtoLbRTAckin95g==
X-Received: from pghg7.prod.google.com ([2002:a63:e607:0:b0:cc7:d4f0:846d])
 (user=jtranoleary job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:a0a:b0:3e2:d68:e8f6 with SMTP id
 adf61e73a8af0-3e902421a58mr108634637.63.1793127505504; 
 Tue, 27 Oct 2026 11:58:25 -0700 (PDT)
Date: Tue, 27 Oct 2026 18:54:18 +0000
In-Reply-To: <20261027185420.724684-1-jtranoleary@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261027185420.724684-1-jtranoleary@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027185420.724684-10-jtranoleary@google.com>
Subject: [PATCH 9/9] net/gve: move dev status poller to its own thread
From: "Jasper Tran O'Leary" <jtranoleary@google.com>
To: dev@dpdk.org, Joshua Washington <joshwash@google.com>
Cc: "Jasper Tran O'Leary" <jtranoleary@google.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Joshua Washington <joshwash@google.com>

The DPDK alarm and interrupts infrastructure make use of the same global
thread for processing. This causes problems in GVE related to the device
status poller, as the reset path invoked by that poller sends mailbox
messages and blocks waiting for their completion.

When the device status poller is on the alarm thread, that blocking call
leads to a temporary lockup, as the mailbox interrupt cannot come in
while the status poller holds the global alarm thread, causing message
timeouts. Because the interrupts infrastructure is managed by DPDK
itself, that leaves moving the device status poller off of the shared
global alarm/interrupt thread as the only viable option.

Spin off a device status thread on initialization that checks for
resets. The single thread will stay alive until the driver is torn down
in gve_dev_close.

Update the polling frequency to every 100ms for quicker error recovery,
since the poller is no longer on the shared thread.

Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Jasper Tran O'Leary <jtranoleary@google.com>
---
 drivers/net/gve/base/gve.h   |  1 +
 drivers/net/gve/gve_ethdev.c | 81 ++++++++++++++++---------------
 drivers/net/gve/gve_ethdev.h | 30 +++++++++++-
 3 files changed, 72 insertions(+), 40 deletions(-)

diff --git a/drivers/net/gve/base/gve.h b/drivers/net/gve/base/gve.h
index 18363fae3..4d9890625 100644
--- a/drivers/net/gve/base/gve.h
+++ b/drivers/net/gve/base/gve.h
@@ -52,6 +52,7 @@ enum gve_state_flags_bit {
 	GVE_PRIV_FLAGS_DEVICE_RINGS_OK		= 3,
 	GVE_PRIV_FLAGS_FLOW_SUBSYSTEM_OK	= 4,
 	GVE_PRIV_FLAGS_NAPI_ENABLED		= 5,
+	GVE_PRIV_FLAGS_STATUS_POLLER_OK		= 7,
 };
 
 enum gve_rss_hash_algorithm {
diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index c2cfd18dc..7c335a72d 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -590,7 +590,6 @@ gve_dev_start(struct rte_eth_dev *dev)
 		}
 	}
 
-	gve_start_dev_status_polling(dev);
 	ret = 0;
 
 unlock_and_return:
@@ -703,14 +702,6 @@ gve_dev_stop(struct rte_eth_dev *dev)
 		return -EPERM;
 	}
 
-	/*
-	 * Block until all polling callbacks have concluded before tearing down
-	 * any device resources. Do so before trying to acquire the reset lock
-	 * because a polling callback could be invoking a reset which will
-	 * itself try to acquire the lock.
-	 */
-	gve_stop_dev_status_polling(dev);
-
 	pthread_mutex_lock(&priv->reset_lock);
 
 	dev->data->dev_started = 0;
@@ -869,6 +860,16 @@ gve_dev_close(struct rte_eth_dev *dev)
 		return 0;
 	}
 
+	/*
+	 * Block until all polling callbacks have concluded before tearing down
+	 * any device resources. Do so before trying to acquire the reset lock
+	 * in gve_dev_stop() because a polling callback could be invoking a
+	 * reset which will itself try to acquire the lock, leading to a
+	 * deadlock.
+	 */
+	if (gve_get_dev_status_poller_ok(priv))
+		gve_stop_dev_status_polling(dev);
+
 	if (dev->data->dev_started) {
 		err = gve_dev_stop(dev);
 		if (err != 0)
@@ -1691,8 +1692,6 @@ gve_internal_recover_device(struct rte_eth_dev *dev)
 		}
 	}
 
-	gve_stop_dev_status_polling(dev);
-
 	if (gve_is_gqi(priv))
 		gve_free_stats_report(dev);
 
@@ -1772,63 +1771,59 @@ recover_fail:
 	return ret;
 }
 
-static void
+static unsigned int
 gve_check_device_status(void *arg)
 {
 	struct gve_process_private *process_priv;
 	struct rte_eth_dev *dev = arg;
 	struct gve_priv *priv = dev->data->dev_private;
-	int ret;
 
 	process_priv = dev->process_private;
 
-	gve_clean_zombie_queues(priv, false);
+	while (gve_get_dev_status_poller_ok(priv)) {
+		gve_clean_zombie_queues(priv, false);
+
+		if (!process_priv->ctrl_ops->check_device_needs_reset(priv))
+			goto sleep;
 
-	if (process_priv->ctrl_ops->check_device_needs_reset(priv)) {
 		pthread_mutex_lock(&priv->reset_lock);
 
 		/*
 		 * Defend against TOCTOU by checking if a reset is still needed
 		 * after acquiring the lock.
 		 */
-		if (process_priv->ctrl_ops->check_device_needs_reset(priv)) {
-			PMD_DRV_LOG(NOTICE,
-				    "Port %u: Device requested reset. Executing proactive recovery.",
-				    dev->data->port_id);
-
-			ret = gve_internal_recover_device(dev);
-			if (ret == 0) {
-				pthread_mutex_unlock(&priv->reset_lock);
-				return;
-			}
-		}
+		if (!process_priv->ctrl_ops->check_device_needs_reset(priv))
+			goto unlock;
+
+		PMD_DRV_LOG(NOTICE,
+			    "Port %u: Device requested reset. Executing proactive recovery.",
+			    dev->data->port_id);
 
+		gve_internal_recover_device(dev);
+unlock:
 		pthread_mutex_unlock(&priv->reset_lock);
+sleep:
+		rte_delay_us_sleep(GVE_DEV_POLL_INTERVAL_US);
 	}
 
-	if (dev->data->dev_started) {
-		ret = rte_eal_alarm_set(GVE_DEV_POLL_INTERVAL_US,
-					gve_check_device_status, dev);
-		if (ret != 0)
-			PMD_DRV_LOG(ERR,
-				    "Port %u: Failed to re-arm alarm poller!",
-				    dev->data->port_id);
-	}
+	return 0;
 }
 
 static void
 gve_start_dev_status_polling(struct rte_eth_dev *dev)
 {
+	struct gve_priv *priv = dev->data->dev_private;
 	int ret;
 
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
 		return;
 
-	ret = rte_eal_alarm_set(GVE_DEV_POLL_INTERVAL_US,
-				gve_check_device_status,
-				dev);
-
+	gve_set_dev_status_poller_ok(priv);
+	ret = rte_thread_create_internal_control(&priv->dev_status_thread,
+						 "gve-dev-status",
+						 gve_check_device_status, dev);
 	if (ret != 0) {
+		gve_clear_dev_status_poller_ok(priv);
 		PMD_DRV_LOG(ERR,
 			"Port %u: Failed to arm device reset polling alarm! Err=%d",
 			dev->data->port_id, ret);
@@ -1842,8 +1837,12 @@ gve_start_dev_status_polling(struct rte_eth_dev *dev)
 static void
 gve_stop_dev_status_polling(struct rte_eth_dev *dev)
 {
+	struct gve_priv *priv = dev->data->dev_private;
+
 	/* Blocks until all in-progress callbacks have completed. */
-	rte_eal_alarm_cancel(gve_check_device_status, dev);
+	gve_clear_dev_status_poller_ok(priv);
+
+	rte_thread_join(priv->dev_status_thread, NULL);
 }
 
 static int
@@ -1859,9 +1858,11 @@ gve_dev_reset(struct rte_eth_dev *dev)
 		return -EPERM;
 	}
 
+	gve_stop_dev_status_polling(dev);
 	pthread_mutex_lock(&priv->reset_lock);
 	ret = gve_internal_recover_device(dev);
 	pthread_mutex_unlock(&priv->reset_lock);
+	gve_start_dev_status_polling(dev);
 
 	return ret;
 }
@@ -2178,6 +2179,8 @@ gve_dev_init(struct rte_eth_dev *eth_dev)
 
 	eth_dev->data->mac_addrs = &priv->dev_addr;
 
+	gve_start_dev_status_polling(eth_dev);
+
 	return 0;
 
 free_process_priv:
diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index 495b60c11..560a9501b 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -66,7 +66,7 @@
 	RTE_ETH_RSS_NONFRAG_IPV6_UDP |	\
 	RTE_ETH_RSS_IPV6_UDP_EX)
 
-#define GVE_DEV_POLL_INTERVAL_US (1 * 1000 * 1000) /* 1 second in microseconds */
+#define GVE_DEV_POLL_INTERVAL_US (100 * 1000) /* 100ms in microseconds */
 
 /* A list of pages registered with the device during setup and used by a queue
  * as buffers
@@ -386,6 +386,7 @@ struct gve_priv {
 	struct gve_tx_queue **zombie_tx_queues;
 	rte_spinlock_t zombie_lock;
 
+	rte_thread_t dev_status_thread;
 	pthread_mutex_t reset_lock;
 
 	struct gve_registers __iomem *reg_bar0; /* see gve_register.h */
@@ -581,6 +582,33 @@ gve_clear_flow_subsystem_ok(struct gve_priv *priv)
 				&priv->state_flags);
 }
 
+static inline bool
+gve_get_dev_status_poller_ok(struct gve_priv *priv)
+{
+	bool ret;
+
+	ret = !!rte_bit_relaxed_get32(GVE_PRIV_FLAGS_STATUS_POLLER_OK,
+				      &priv->state_flags);
+	rte_atomic_thread_fence(rte_memory_order_acquire);
+	return ret;
+}
+
+static inline void
+gve_set_dev_status_poller_ok(struct gve_priv *priv)
+{
+	rte_atomic_thread_fence(rte_memory_order_release);
+	rte_bit_relaxed_set32(GVE_PRIV_FLAGS_STATUS_POLLER_OK,
+			      &priv->state_flags);
+}
+
+static inline void
+gve_clear_dev_status_poller_ok(struct gve_priv *priv)
+{
+	rte_atomic_thread_fence(rte_memory_order_release);
+	rte_bit_relaxed_clear32(GVE_PRIV_FLAGS_STATUS_POLLER_OK,
+				&priv->state_flags);
+}
+
 int
 gve_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id, uint16_t nb_desc,
 		   unsigned int socket_id, const struct rte_eth_rxconf *conf,
-- 
2.56.0.307.g5fe7bd680c-goog

