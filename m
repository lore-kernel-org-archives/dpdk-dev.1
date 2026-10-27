Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D04606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 18:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ije0niE+
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 306004067D;
	Tue, 27 Oct 2026 19:56:25 +0100 (CET)
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mails.dpdk.org (Postfix) with ESMTPS id 16B594067D
 for <dev@dpdk.org>; Tue, 27 Oct 2026 19:56:24 +0100 (CET)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cd8b299b05fso240899a12.0
 for <dev@dpdk.org>; Tue, 27 Oct 2026 11:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793127382; x=1793732182; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=n7IjgU3lDtnbsAZtFZMpPi9/UU3A/HvHXl+s7ywJeDM=;
 b=ije0niE+X5Y4PzaXR7/ok2+dPnfg1VbORKCWDDG7mcQfkYEPoJL0ha1zr5nSSIzkxO
 Z1QqwQNC0Z4pxlWb28WqtVOoS29o2juQirki9nUUS4fJeD9RHRwsIB4K4cfT8yhMtfAt
 qyMB0LDAOhZOwFUuPcP5ZRYQ+ikXDR/Y4DzMj7kyCyqd8Gw8L/hIMwp1k7Rzi9wQU+dG
 1GkQZ7xPxKP9mf5feYdzowwcFq8TSnvkfujqqE66YyznKecDNnL8Bs6Aj+H8MeoUAFCi
 SubePUgPIkcIeyYawyogzYkEjpE4I9kPOYQURdDwcOttceBtR0T3xmRj/L8jTzGcKmPF
 syvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793127382; x=1793732182;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n7IjgU3lDtnbsAZtFZMpPi9/UU3A/HvHXl+s7ywJeDM=;
 b=mRVMKv8NmdSXXqzwl8dYp689AmIPUDUIJc7/72LdhxkWvNbZTa6SIVmeTcyGpMuC3Y
 d0jpuZNtdorbYLMIgu+dWlo7r3g1V1QMcTkMoM04YKlVTWUJz/ouG8G/dPBjcdL9XQS6
 0U2hQmJZe1twX8LSbMpZEsRmOjYDXU2eVipLL+/zND9QoP14clZ7PVrHcOyJ0WqwXrFQ
 4yhGvPJ6rVHsJnK30/YJA3DQwTQ+xYLJvUuR8UjsGHI7iF85dKajEhza9lf3ry8EekcR
 ViPmq3ifDEOASgisY8xEM9n0bAAXYa68UhoULA0wAuLhp+/DvhkHv/SEYYK2QEGvWb4/
 rZQA==
X-Gm-Message-State: AFq9FYIDNchJK/BAwKplfCPYbKYUsksBlmJdz8mDCpwdqh2FkX06Fafk
 EJtILXt91Q0K7dgMU6onfyFUNELXKoBpT2xiA07SIsjAhlaFJXat5bdcU/8d5+k3lTU892Cufwh
 fKKIjGJ+xhyAKRAcqWqes+LSZSuOsTH8eqyx8oez6tc/VEBlaa/u962c+Lruv9Kyg3X/ANNtYM4
 4KX9B5m+T6sr/OJUqdaYNIXIzxxbzvjO3JNlKnzpVJDrrimxoIsw==
X-Received: from pgx30.prod.google.com ([2002:a63:175e:0:b0:cc7:492f:3ac1])
 (user=jtranoleary job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:4849:b0:3e8:ea76:9825 with SMTP id
 adf61e73a8af0-3e9020dbaa4mr125549637.4.1793127382333; 
 Tue, 27 Oct 2026 11:56:22 -0700 (PDT)
Date: Tue, 27 Oct 2026 18:54:14 +0000
In-Reply-To: <20261027185420.724684-1-jtranoleary@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261027185420.724684-1-jtranoleary@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027185420.724684-6-jtranoleary@google.com>
Subject: [PATCH 5/9] net/gve: add dedicated mutex for device reset
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

During a proactive device reset, a polling thread may attempt to stop
and start the device outside of the main EAL thread. Guard against
contention by having device start, stop, and reset callbacks acquire
and release the mutex.

Signed-off-by: Jasper Tran O'Leary <jtranoleary@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/gve/gve_ethdev.c | 35 +++++++++++++++++++++++++------
 drivers/net/gve/gve_ethdev.h |  2 ++
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index 44810b864..391e7923f 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -558,16 +558,19 @@ gve_dev_start(struct rte_eth_dev *dev)
 		return -EPERM;
 	}
 
+	priv = dev->data->dev_private;
+
+	pthread_mutex_lock(&priv->reset_lock);
+
 	ret = gve_start_queues(dev);
 	if (ret != 0) {
 		PMD_DRV_LOG(ERR, "Failed to start queues");
-		return ret;
+		goto unlock_and_return;
 	}
 
 	dev->data->dev_started = 1;
 	gve_link_update(dev, 0);
 
-	priv = dev->data->dev_private;
 	/* No stats available yet for Dqo. */
 	if (gve_is_gqi(priv)) {
 		ret = gve_alloc_stats_report(priv,
@@ -576,7 +579,7 @@ gve_dev_start(struct rte_eth_dev *dev)
 		if (ret != 0) {
 			PMD_DRV_LOG(ERR,
 				"Failed to allocate region for stats reporting.");
-			return ret;
+			goto unlock_and_return;
 		}
 		ret = process_priv->ctrl_ops->setup_stats_report(priv,
 				priv->stats_report_len,
@@ -584,13 +587,16 @@ gve_dev_start(struct rte_eth_dev *dev)
 				GVE_STATS_REPORT_TIMER_PERIOD);
 		if (ret != 0) {
 			PMD_DRV_LOG(ERR, "setup_stats_report command failed.");
-			return ret;
+			goto unlock_and_return;
 		}
 	}
 
 	gve_start_dev_status_polling(dev);
+	ret = 0;
 
-	return 0;
+unlock_and_return:
+	pthread_mutex_unlock(&priv->reset_lock);
+	return ret;
 }
 
 static void
@@ -700,10 +706,14 @@ gve_dev_stop(struct rte_eth_dev *dev)
 
 	/*
 	 * Block until all polling callbacks have concluded before tearing down
-	 * any device resources.
+	 * any device resources. Do so before trying to acquire the reset lock
+	 * because a polling callback could be invoking a reset which will
+	 * itself try to acquire the lock.
 	 */
 	gve_stop_dev_status_polling(dev);
 
+	pthread_mutex_lock(&priv->reset_lock);
+
 	dev->data->dev_started = 0;
 	dev->data->dev_link.link_status = RTE_ETH_LINK_DOWN;
 
@@ -719,6 +729,8 @@ gve_dev_stop(struct rte_eth_dev *dev)
 	if (gve_is_gqi(dev->data->dev_private))
 		gve_free_stats_report(dev);
 
+	pthread_mutex_unlock(&priv->reset_lock);
+
 	return 0;
 }
 
@@ -880,6 +892,7 @@ gve_dev_close(struct rte_eth_dev *dev)
 
 	pthread_mutex_destroy(&priv->flow_rule_lock);
 	pthread_mutex_destroy(&priv->nic_ts_lock);
+	pthread_mutex_destroy(&priv->reset_lock);
 
 	rte_free(priv->rxq_configs);
 	priv->rxq_configs = NULL;
@@ -908,6 +921,8 @@ gve_dev_reset(struct rte_eth_dev *dev)
 		return -EPERM;
 	}
 
+	pthread_mutex_lock(&priv->reset_lock);
+
 	/* Tear down all device resources before re-initializing. */
 	if (gve_get_flow_subsystem_ok(priv))
 		gve_teardown_flow_subsystem(priv);
@@ -927,9 +942,12 @@ gve_dev_reset(struct rte_eth_dev *dev)
 		PMD_DRV_LOG(ERR,
 			"Failed to re-init device on port %u after reset.",
 			dev->data->port_id);
+		pthread_mutex_unlock(&priv->reset_lock);
 		return err;
 	}
 
+	pthread_mutex_unlock(&priv->reset_lock);
+
 	return 0;
 }
 
@@ -1971,8 +1989,12 @@ gve_dev_init(struct rte_eth_dev *eth_dev)
 
 	pthread_mutexattr_init(&mutexattr);
 	pthread_mutexattr_setpshared(&mutexattr, PTHREAD_PROCESS_SHARED);
+	pthread_mutexattr_settype(&mutexattr, PTHREAD_MUTEX_RECURSIVE);
+
 	pthread_mutex_init(&priv->flow_rule_lock, &mutexattr);
 	pthread_mutex_init(&priv->nic_ts_lock, &mutexattr);
+	pthread_mutex_init(&priv->reset_lock, &mutexattr);
+
 	pthread_mutexattr_destroy(&mutexattr);
 
 	priv->mbuf_timestamp_offset = -1;
@@ -1980,6 +2002,7 @@ gve_dev_init(struct rte_eth_dev *eth_dev)
 	if (err) {
 		pthread_mutex_destroy(&priv->flow_rule_lock);
 		pthread_mutex_destroy(&priv->nic_ts_lock);
+		pthread_mutex_destroy(&priv->reset_lock);
 		goto free_process_priv;
 	}
 
diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index c56a8a693..d16db54a8 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -385,6 +385,8 @@ struct gve_priv {
 	struct gve_tx_queue **zombie_tx_queues;
 	rte_spinlock_t zombie_lock;
 
+	pthread_mutex_t reset_lock;
+
 	struct gve_registers __iomem *reg_bar0; /* see gve_register.h */
 	rte_be32_t __iomem *db_bar; /* "array" of doorbells */
 	struct rte_pci_device *pci_dev;
-- 
2.56.0.307.g5fe7bd680c-goog

