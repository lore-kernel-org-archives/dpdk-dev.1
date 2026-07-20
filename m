Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A3AC44515
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Jul 2026 12:07:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52BD640696;
	Mon, 20 Jul 2026 14:07:09 +0200 (CEST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43]) by mails.dpdk.org (Postfix) with ESMTP id 1DD254028E
 for <dev@dpdk.org>; Mon, 20 Jul 2026 14:07:06 +0200 (CEST)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-47f365afc5aso4785157f8f.0
 for <dev@dpdk.org>; Mon, 20 Jul 2026 05:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784549226; x=1785154026; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+w14eWNkuQKLStPzrEEpApjShuS1k//kG+1NbAJzSqE=;
 b=LwbmpamkSq3AhD3fG1hR7hFC+o5YdsFjtTGW0wv1494V0A7nt6BVC62LJ1GE7m0XiH
 UWuleJIQs1KNRhr883vlaO8A5LGcnDk3b0mFrV0PpAIcPz1+wQ9E2MdBWAP5RRT634bt
 VVqbJrKWLcg9V4vd8S7pFje1muSVEIsPKI0NbbP5+a99sPAhXvtxzHWNmA/wPkwVSkbU
 B21mKtKA5+7QvVuiPlbpxGqt66J/yc6hEZqHmlBuTRw1AYBfnx/Ptels2eQIPlQg8a78
 pj3uzTyAaNmZ8D52WXPwylLeGb4ev4A8f1QR5l4QBPb5ZPTo5GAtMy487pun20drv6cx
 Du5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784549226; x=1785154026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+w14eWNkuQKLStPzrEEpApjShuS1k//kG+1NbAJzSqE=;
 b=DH+pO2ZoKPG4pqbR3AAIvgDZXGDW2mAQ4pmBHZN8j79b5kZg8gbYfXTTQLsGCTT7uD
 dxMoZVVXCDsX6CZxrIRhJBeMQ5mdDmRpQ9dFf6xhu+RKuoTfm0L6xkbqymVcSdmIH5PZ
 GsmrGLbSrJx8R+xh3bYVQbuoIHGFekE0mLVTxO4rRZe/CFimMDg+Xwj4PeD8Alf+1uX3
 GqwH1hqTOnl9UCrDaBz4WF+67nnPnEIbi2FBUX/ybEwiHSUOPNq7vAcxDXzbTTbYLSRm
 KE45IpDou94D36WclLBkKrqr4T0dzma0imV4vGdDAfHVfxj+tXlCw0zZ2oOMq5yX6iF4
 7k5w==
X-Gm-Message-State: AOJu0YwVOUaY1ZxB7BOUhq5KOzC933y6giVt5DjgFQw7brnXgM9BaUVG
 ugBU5ziQ+xCGVCEB3krWDh+cJeIVqA411nzDJC81g2mJsFKlhVTff+WgWJjzVAoR
X-Gm-Gg: AR+sD11RuPbYzLxxvpIk8tlTEXO6gF2MFFjRHzwFSdVCkOgYSl++0oCl34jcXX2gOkW
 aiadPSl7hpD31xG+3dXci9cQyQ5om3w3nFZDmT0t2W1nJDiPK1T7NmzqPAwXAWcGqbHUHax82me
 n8WVkXCa8Tu+RLUEHmVP//awFbqMoelBznfoZo4K6v7Nx0S5MaJGmyNgCuT6Rf2BfZvUcNBnSjg
 RMqFT8hGKL29foxjgUD2flzZQPbwS6eFdpfDVBhQvEjpPKkjTzd12tuF1Tzp5mF/JE1IhyBHbrD
 xsevIul7OQlHHHpg832NqKaI24vPYPa9vp6We12Y+s1WvdBiQJ8tIaasFCqGozvLommhuEGizJp
 LYNyjER9Pe/eIiGRR26GnrVTm+ROdFSKnoSycu5wxKIDYzSbKRgJFAf62GUIiUSlmoSh9tzfxD/
 VnklF3SBqpP+o+P4syLemktwxceznc3JGcGQ==
X-Received: by 2002:a05:6000:3110:b0:475:6c34:2120 with SMTP id
 ffacd0b85a97d-47f6230bd64mr16472998f8f.18.1784549225580; 
 Mon, 20 Jul 2026 05:07:05 -0700 (PDT)
Received: from localhost.localdomain (free-mobile.vlq16.iliad.fr.
 [213.36.7.11]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e49ce4sm30222657f8f.8.2026.07.20.05.07.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 05:07:05 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Pascal Mazon <pascal.mazon@6wind.com>, Moti Haimovsky <motih@mellanox.com>
Subject: [PATCH v2 1/3] net/tap: support Rx queue interrupt enable/disable
Date: Mon, 20 Jul 2026 14:06:57 +0200
Message-ID: <20260720120700.801099-2-maxime@leroys.fr>
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
index b93452f168..dc56c974da 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -935,6 +935,7 @@ static int
 tap_dev_configure(struct rte_eth_dev *dev)
 {
 	struct pmd_internals *pmd = dev->data->dev_private;
+	bool intr_mode = dev->data->dev_conf.intr_conf.rxq;
 
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
index f53a5ad077..51fd2339fc 100644
--- a/drivers/net/tap/rte_eth_tap.h
+++ b/drivers/net/tap/rte_eth_tap.h
@@ -93,6 +93,7 @@ struct pmd_internals {
 
 
 	struct rte_intr_handle *intr_handle;         /* LSC interrupt handle. */
+	bool intr_mode;                   /* Rx queue interrupt mode */
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

