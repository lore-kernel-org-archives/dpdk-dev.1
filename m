Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F22E92FD2
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Dec 2025 02:30:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F1F5F402AA;
	Tue, 30 Dec 2025 03:30:21 +0100 (CET)
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com
 [209.85.216.73]) by mails.dpdk.org (Postfix) with ESMTP id 46678402A0
 for <dev@dpdk.org>; Tue, 30 Dec 2025 03:30:20 +0100 (CET)
Received: by mail-pj1-f73.google.com with SMTP id
 98e67ed59e1d1-34c2f670a06so12392618a91.3
 for <dev@dpdk.org>; Mon, 29 Dec 2025 18:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1767061819; x=1767666619; darn=dpdk.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=UWYrjU+0YR/X6jvNWHSbwn8hGmBQwLl/Sg2VUAiAZ/8=;
 b=fCaAEPxS5zCx/eureOGdpeGoOiGtTsfKCKpQ2zqp+tEDWMpIh9QnBnKQ69la0tYSPX
 CVO/ohMlPR/AmmAO3J59tYsEhcCsGh/4VQ2PpBrkAuIlV3zWkmz0cn7mIf1OpSTutfon
 hFpdL6UrXAang11roIMaWdEMaRRlUmhSpj8KigwkzkQNU3T6gVb+0SPGv7/IOxc6uwEu
 Oos9/vy63qp+F2P5rH6oM61SZkQT8sXR0URUNQoP0g0fXfDm2gwVdfdmf1hD+wgVrP1G
 yVHZnjDbov6mFOu0DqZlyAr2sfLET7fje6pMgijGiwiicSBT27mRd0wSvpu3vaAYnjvM
 JlAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767061819; x=1767666619;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UWYrjU+0YR/X6jvNWHSbwn8hGmBQwLl/Sg2VUAiAZ/8=;
 b=s6VIAUimjrgjmXXhVWUyDYE3Hqr2VUWyPeAjPHHTyF36gHH1H1wD+TmGmS7rNuv6v2
 zmvIv23bz0JLfThvYERn8tMvrXPGnV8HsrVY45/ETXB/i+G8wxg/GrSSS2RWTl0U3+ja
 iG0gIFNXebcZFJQ2HXHLrW/7Dz41BsiOL+6QJJm600CDh7rYSRqpcp7RXKSkFRGGNluk
 zbPqhNsUjknXo+9IlMTybNnWJwrCf6P3ufI1Is7tr+E8/roDjkikS+6eFyKkLDmCDnz7
 Bog9fL7BpDTr3HG/nS6OxnQetCbTZzZfDO2g9ff5Fa+yTiadiCVegYOESmGBiIKsUTRz
 FSGA==
X-Gm-Message-State: AOJu0Yz0WjH/caI3/FEm/ufy1f5jGdOr2Z3x1QzdkcmZEg4j8NLnke+e
 EZZ5ic9TklxSSSN01rW7hrXTjLWn1LMtALOqojtuuwrNbXjohtOEZL5ppwa/gjbmKKl8vcOVFba
 aR9VBnLXPCbIZbNYdmZicLo3CQA==
X-Google-Smtp-Source: AGHT+IGWIagYaKyqVvQUBK1Mj2Ryhtr8OdPGQeJAORVtYhwYk3o4vRm1TPxoUTwW/Bm20QhyBGW+BhT3J1NRMIOZcw==
X-Received: from pjyd16.prod.google.com ([2002:a17:90a:dfd0:b0:34c:3862:5ac1])
 (user=jtranoleary job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2e0c:b0:341:134:a962 with SMTP id
 98e67ed59e1d1-34e921cc21bmr21050712a91.28.1767061818910; 
 Mon, 29 Dec 2025 18:30:18 -0800 (PST)
Date: Tue, 30 Dec 2025 02:29:58 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20251230022958.3842695-1-jtranoleary@google.com>
Subject: [PATCH] net/gve: add reset path
From: "Jasper Tran O'Leary" <jtranoleary@google.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, "Jasper Tran O'Leary" <jtranoleary@google.com>, 
 Joshua Washington <joshwash@google.com>
Content-Type: text/plain; charset="UTF-8"
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

Currently, the driver does not include any reset functionality and hence
cannot be reset by the application. This patch introduces a driver
callback for the `rte_eth_dev_reset` function which will reset the
device.

Also, as a precaution, null out device pointers to rx and tx queue
arrays when we release the queues during a reset.

Signed-off-by: Jasper Tran O'Leary <jtranoleary@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/gve/gve_ethdev.c | 40 ++++++++++++++++++++++++++++++++++++++++
 drivers/net/gve/gve_rx.c     |  2 ++
 drivers/net/gve/gve_rx_dqo.c |  2 ++
 drivers/net/gve/gve_tx.c     |  2 ++
 drivers/net/gve/gve_tx_dqo.c |  2 ++
 5 files changed, 48 insertions(+)

diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index 6341d89..d62f74b 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -12,6 +12,8 @@
 #include "gve_rss.h"
 #include <ethdev_driver.h>
 
+static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device);
+
 static void
 gve_write_version(uint8_t *driver_version_register)
 {
@@ -550,6 +552,42 @@ gve_dev_close(struct rte_eth_dev *dev)
 	return err;
 }
 
+static int
+gve_dev_reset(struct rte_eth_dev *dev)
+{
+	struct gve_priv *priv = dev->data->dev_private;
+	int err = 0;
+
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
+		PMD_DRV_LOG(ERR,
+			"Device reset on port %u not supported in secondary processes.",
+			dev->data->port_id);
+		return -EPERM;
+	}
+
+	if (dev->data->dev_started) {
+		PMD_DRV_LOG(ERR,
+			"Must stop device on port %u before reset.",
+			dev->data->port_id);
+		return -EBUSY;
+	}
+
+	/* Tear down all device resources before re-initializing. */
+	gve_free_queues(dev);
+	gve_teardown_device_resources(priv);
+	gve_adminq_free(priv);
+
+	err = gve_init_priv(priv, true);
+	if (err != 0) {
+		PMD_DRV_LOG(ERR,
+			"Failed to re-init device on port %u after reset.",
+			dev->data->port_id);
+		return err;
+	}
+
+	return 0;
+}
+
 static int
 gve_verify_driver_compatibility(struct gve_priv *priv)
 {
@@ -1068,6 +1106,7 @@ static const struct eth_dev_ops gve_eth_dev_ops = {
 	.dev_start            = gve_dev_start,
 	.dev_stop             = gve_dev_stop,
 	.dev_close            = gve_dev_close,
+	.dev_reset            = gve_dev_reset,
 	.dev_infos_get        = gve_dev_info_get,
 	.rx_queue_setup       = gve_rx_queue_setup,
 	.tx_queue_setup       = gve_tx_queue_setup,
@@ -1094,6 +1133,7 @@ static const struct eth_dev_ops gve_eth_dev_ops_dqo = {
 	.dev_start            = gve_dev_start,
 	.dev_stop             = gve_dev_stop,
 	.dev_close            = gve_dev_close,
+	.dev_reset            = gve_dev_reset,
 	.dev_infos_get        = gve_dev_info_get,
 	.rx_queue_setup       = gve_rx_queue_setup_dqo,
 	.tx_queue_setup       = gve_tx_queue_setup_dqo,
diff --git a/drivers/net/gve/gve_rx.c b/drivers/net/gve/gve_rx.c
index 7a91c31..625649c 100644
--- a/drivers/net/gve/gve_rx.c
+++ b/drivers/net/gve/gve_rx.c
@@ -290,6 +290,8 @@ gve_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
 	rte_memzone_free(q->qres_mz);
 	q->qres = NULL;
 	rte_free(q);
+
+	dev->data->rx_queues[qid] = NULL;
 }
 
 int
diff --git a/drivers/net/gve/gve_rx_dqo.c b/drivers/net/gve/gve_rx_dqo.c
index a0ef21b..3aa82b3 100644
--- a/drivers/net/gve/gve_rx_dqo.c
+++ b/drivers/net/gve/gve_rx_dqo.c
@@ -252,6 +252,8 @@ gve_rx_queue_release_dqo(struct rte_eth_dev *dev, uint16_t qid)
 	rte_memzone_free(q->qres_mz);
 	q->qres = NULL;
 	rte_free(q);
+
+	dev->data->rx_queues[qid] = NULL;
 }
 
 static void
diff --git a/drivers/net/gve/gve_tx.c b/drivers/net/gve/gve_tx.c
index 015ea96..5c73c21 100644
--- a/drivers/net/gve/gve_tx.c
+++ b/drivers/net/gve/gve_tx.c
@@ -547,6 +547,8 @@ gve_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid)
 	rte_memzone_free(q->qres_mz);
 	q->qres = NULL;
 	rte_free(q);
+
+	dev->data->tx_queues[qid] = NULL;
 }
 
 int
diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index 64141ac..4c632d7 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -379,6 +379,8 @@ gve_tx_queue_release_dqo(struct rte_eth_dev *dev, uint16_t qid)
 	rte_memzone_free(q->qres_mz);
 	q->qres = NULL;
 	rte_free(q);
+
+	dev->data->tx_queues[qid] = NULL;
 }
 
 static int
-- 
2.52.0.351.gbe84eed79e-goog

