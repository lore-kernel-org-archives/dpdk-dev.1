Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85524C44516
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 09:59:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 017E940E1C;
	Fri, 17 Jul 2026 11:59:07 +0200 (CEST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id 61B5B40E49
 for <dev@dpdk.org>; Fri, 17 Jul 2026 11:59:05 +0200 (CEST)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4954a32cf1eso1726885e9.3
 for <dev@dpdk.org>; Fri, 17 Jul 2026 02:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784282345; x=1784887145; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G/c0hGUYSN/DJ4KqCFmR/l7DZpQCdKbsiAcp0dvtVVc=;
 b=BfFbIdfJp8wnxfItXeI50GqtFC5QX7cfYFUX+GY5onveKVwYhAIQF68Udo418M3PA9
 +iA069bB5CMFxjQWVdj72PeSg9uICRRA/08qcWTSLbuf5+GejjfOrVTrt0Ax4Qb5okdf
 hG7ZnGgs4UnZG697hVw7kk7jo1uibLoJ6hZ9lS5/jyEZZQrZM62XVJAe5qlVf8tTV7U3
 EkS3mEAcopPxdBypIyJAPvGZUQbO8sI/vQcxKEcOxkRIjg72ZfQEcyxjs12NW7GTx2e+
 Oj0G6rxJS9CBOBBFsqx+OWfnXzypO+t4ISKDWzUYEBXnKB/nPnXtrjbOdfbtunUhC+m6
 u+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784282345; x=1784887145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G/c0hGUYSN/DJ4KqCFmR/l7DZpQCdKbsiAcp0dvtVVc=;
 b=P+XCFDa9ieg3LUqr84jzSlIxylbnC+jNBXxD4pek9AbCAddj7qLhH8aFge4dxiEWC9
 Wst9H5wDGX5W4AE64LaHTBLtAvLBwrcsJeudzpzK4VITimEIu1ixZGtcB9A/l+9LzV+I
 SohRspyMJND01/uvMj3D/uGCLgnsDSW96o6u8Qn66CPMU6UVbMc2Urs1OsbsxtWTI3gz
 sMXDbwbHjxGQrpLbw5abhJTUt7yd5ZDQ9FQaEr7hoHDS8QFL5DuQrkP6zl45HXFZMqI+
 c9pSzOwnZWmKk4Tablkyk4X9s0jU21rjow0aWLQp/LBetiNQPGV7Y3OQN/V/29L1eLLj
 bZsQ==
X-Gm-Message-State: AOJu0YwHMWlIEP4NI4p5uWkDXJ2RiKaqx7+fcfTmUm6wnFNtnkaIcFR1
 caIG/dBkqvKaxhKl3bHS5WLhQ0tGIs0iig/gusbljk0jm/ZJGTINq1+wQnwpoI3C
X-Gm-Gg: AfdE7cl/Q2DowE7iXeAjsWlZU/lyvrWX5P4F8vXEKgfRUQWn4Hy99WZqJzIrzXsVmid
 hZy2uifVPNosC/NM9TUrtyModhystij/WdShZDj0hpzcHbJbXRbCKMrLcM3vuLp3FNsvAtOEZkB
 6bUtjLnWyCphlCRkRDtRiAxUgJl6WCEr2lEAUJJ5TubC1BiftWoKTqKpLC6MJQLnzdjNWOILkdN
 t+MGtGmvcrwHoNxIpYhp7jjqG53D/vAA/FUPoe+JkrH9FD2op2+m/HOtJyyy444mg8qm+GS10w0
 BV057Q10YBISyHRQWu8pGr4PviROi0Zn0JV1hbsozP3g+jYoQf0khAXccW7oYfkjf53tM/zoqDL
 xyrsM/QmFIFHd42/TLs56402D4uJISQqkYP+2w1XGuQalq2YxmXiL+q6qFTjFoOJSELoIXYdZtM
 ggCjt6rpDGBZfWB0JJlz/xYMbQdLcDUGfO3k3isddw
X-Received: by 2002:a05:600c:1d1d:b0:492:40a1:1e16 with SMTP id
 5b1f17b1804b1-4954a3d0d86mr19363645e9.8.1784282344821; 
 Fri, 17 Jul 2026 02:59:04 -0700 (PDT)
Received: from freepad.sicorp.iliad.local (free-mobile.vlq16.iliad.fr.
 [213.36.7.11]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49549a359a6sm37822375e9.1.2026.07.17.02.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 02:59:04 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH 1/2] net/tap: support Rx queue interrupt enable/disable
Date: Fri, 17 Jul 2026 11:58:41 +0200
Message-ID: <20260717095842.419130-2-maxime@leroys.fr>
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

The driver registers each queue file descriptor for Rx interrupts but
never provided the rx_queue_intr_enable/disable ops, so
rte_eth_dev_rx_intr_enable() returned -ENOTSUP. Applications that arm
queues before sleeping (l3fwd-power and similar) treat that as "no
interrupt support" and fall back to polling, even though the epoll wait
on the queue fd works. The advertised Rx interrupt feature is therefore
unusable through the generic API.

The queue fd is kept readable by the kernel whenever data is available
and is drained by the Rx burst itself, so there is no interrupt source to
arm or mask. Record whether the port was configured for Rx interrupts and
implement both ops to succeed in that mode and return -ENOTSUP otherwise,
so the generic Rx interrupt API works and applications can block on the
queue fd.

Fixes: 4870a8cdd968 ("net/tap: support Rx interrupt")
Cc: stable@dpdk.org

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/net/tap/rte_eth_tap.c |  5 ++++
 drivers/net/tap/rte_eth_tap.h |  3 +++
 drivers/net/tap/tap_intr.c    | 44 +++++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index b93452f168..99ede19e49 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -935,6 +935,7 @@ static int
 tap_dev_configure(struct rte_eth_dev *dev)
 {
 	struct pmd_internals *pmd = dev->data->dev_private;
+	int intr_mode = !!dev->data->dev_conf.intr_conf.rxq;
 
 	if (dev->data->nb_rx_queues != dev->data->nb_tx_queues) {
 		TAP_LOG(ERR,
@@ -945,6 +946,8 @@ tap_dev_configure(struct rte_eth_dev *dev)
 		return -1;
 	}
 
+	pmd->intr_mode = intr_mode;
+
 	TAP_LOG(INFO, "%s: %s: TX configured queues number: %u",
 		dev->device->name, pmd->name, dev->data->nb_tx_queues);
 
@@ -2098,6 +2101,8 @@ static const struct eth_dev_ops ops = {
 	.tx_queue_stop          = tap_tx_queue_stop,
 	.rx_queue_release       = tap_rx_queue_release,
 	.tx_queue_release       = tap_tx_queue_release,
+	.rx_queue_intr_enable   = tap_rx_queue_intr_enable,
+	.rx_queue_intr_disable  = tap_rx_queue_intr_disable,
 	.flow_ctrl_get          = tap_flow_ctrl_get,
 	.flow_ctrl_set          = tap_flow_ctrl_set,
 	.link_update            = tap_link_update,
diff --git a/drivers/net/tap/rte_eth_tap.h b/drivers/net/tap/rte_eth_tap.h
index f53a5ad077..3180719c34 100644
--- a/drivers/net/tap/rte_eth_tap.h
+++ b/drivers/net/tap/rte_eth_tap.h
@@ -93,6 +93,7 @@ struct pmd_internals {
 
 
 	struct rte_intr_handle *intr_handle;         /* LSC interrupt handle. */
+	int intr_mode;                    /* Rx queue interrupt mode */
 	int ka_fd;                        /* keep-alive file descriptor */
 	struct rte_mempool *gso_ctx_mp;     /* Mempool for GSO packets */
 };
@@ -104,5 +105,7 @@ struct pmd_process_private {
 /* tap_intr.c */
 
 int tap_rx_intr_vec_set(struct rte_eth_dev *dev, int set);
+int tap_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id);
+int tap_rx_queue_intr_disable(struct rte_eth_dev *dev, uint16_t queue_id);
 
 #endif /* _RTE_ETH_TAP_H_ */
diff --git a/drivers/net/tap/tap_intr.c b/drivers/net/tap/tap_intr.c
index 1908f71f97..7db22b69f5 100644
--- a/drivers/net/tap/tap_intr.c
+++ b/drivers/net/tap/tap_intr.c
@@ -112,3 +112,47 @@ tap_rx_intr_vec_set(struct rte_eth_dev *dev, int set)
 		return tap_rx_intr_vec_install(dev);
 	return 0;
 }
+
+/**
+ * Arm a queue for Rx interrupts.
+ *
+ * @param dev
+ *   Pointer to the tap rte_eth_dev device structure.
+ * @param queue_id
+ *   Rx queue index.
+ *
+ * @return
+ *   0 on success, -ENOTSUP if the port was not configured for Rx interrupts.
+ */
+int
+tap_rx_queue_intr_enable(struct rte_eth_dev *dev,
+			 uint16_t queue_id __rte_unused)
+{
+	struct pmd_internals *pmd = dev->data->dev_private;
+
+	if (!pmd->intr_mode)
+		return -ENOTSUP;
+	return 0;
+}
+
+/**
+ * Disarm a queue from Rx interrupts.
+ *
+ * @param dev
+ *   Pointer to the tap rte_eth_dev device structure.
+ * @param queue_id
+ *   Rx queue index.
+ *
+ * @return
+ *   0 on success, -ENOTSUP if the port was not configured for Rx interrupts.
+ */
+int
+tap_rx_queue_intr_disable(struct rte_eth_dev *dev,
+			  uint16_t queue_id __rte_unused)
+{
+	struct pmd_internals *pmd = dev->data->dev_private;
+
+	if (!pmd->intr_mode)
+		return -ENOTSUP;
+	return 0;
+}
-- 
2.43.0

