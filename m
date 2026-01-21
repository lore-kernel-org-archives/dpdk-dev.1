Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87712C44506
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 19:30:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72ED34279D;
	Wed, 21 Jan 2026 20:30:36 +0100 (CET)
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com
 [209.85.214.201])
 by mails.dpdk.org (Postfix) with ESMTP id 31D334027A
 for <dev@dpdk.org>; Wed, 21 Jan 2026 20:30:35 +0100 (CET)
Received: by mail-pl1-f201.google.com with SMTP id
 d9443c01a7336-2a77040ede0so1319265ad.2
 for <dev@dpdk.org>; Wed, 21 Jan 2026 11:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1769023834; x=1769628634; darn=dpdk.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=qxsbTQqb7NoYIUChCLKkGsINozNKH6Tdaly9zEYr5gE=;
 b=QVC28GHhOU84XrUsuAU7YeE7Ja5JH5+/QpS5SMHC4/kQvElUT6J++J4WzmOenzSFXR
 N6QLlRQM/jFvbkmIoX9cF40/A3ssGxUWHE4g7uN+qiGc6ePYK1C5vNOgMJtFTkxmNlEQ
 +TvqQ9/AL9rgEVEFuuxmH7Ac57X16mDr5xwM0B41HcdMw1Tzr5XdX17pxAnulrW4TK/y
 91xUyrsQ6U43t1cVJ9fAhJfgbIgnbtgWq1xxfV9Oqhytr9TSjqcbHyJx8doTCP9qMkwS
 a00sdUnqXImhaDG4VvAt/5Z9bl/FdE/DK74N9FFoL1G28iUuCAazdJEtGmeFC5yy81vr
 6NpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769023834; x=1769628634;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qxsbTQqb7NoYIUChCLKkGsINozNKH6Tdaly9zEYr5gE=;
 b=Di9aSLmhmbBFejKlqLZmXgbUb+Ru5uxzfZ1EioVpEowViZR29P23PnZ+HkpLI4DKyx
 uDa7maejBTTT4+JG7YhCovPfUytRkE4nLWEX/SjCcHPp0OLRwCJVIledUmMYOxRwo7oq
 9pHDS0syc+JgtTBetJWRBWuZAEpKCYaLql4UKbPOsFissTJe4irjhYfbribDr4VYZl9V
 7immqamUYZ6danPGu541ld05JQ0OxrVoW7wctpT5J8WyQKSH3CnUA5u8SUWTn7p/xGt1
 lMk2myTBhAHp2La6bSwm+Mvc7PNvA/D9Yl1fi7wF49Zzo3brk7vsBL3JRaN3JmCiWyZ1
 xyLw==
X-Gm-Message-State: AOJu0YzQEjByu/kS7s+EZ+f3IKcACB/U9Q3h2G3mSQtTN1eUSnD2nkce
 7CnJNaTDqxKp/QX4vRmjrV0eU6a3elTsuBTW+jV5EAPyrf/u5lDCX02G2Y1evopserfvZyH35Mo
 +24YruuyRSZlAXSXSpPSIdmA6rg==
X-Received: from plxq13.prod.google.com ([2002:a17:902:dacd:b0:2a7:847f:86d4])
 (user=jtranoleary job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f60b:b0:2a0:daa7:8a57 with SMTP id
 d9443c01a7336-2a76b05165fmr64996705ad.30.1769023834325; 
 Wed, 21 Jan 2026 11:30:34 -0800 (PST)
Date: Wed, 21 Jan 2026 19:30:18 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260121193018.2728602-1-jtranoleary@google.com>
Subject: [PATCH v2] net/gve: add reset path
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
callback for the `rte_eth_dev_reset` function will which reset the
device.

Also, as a precaution, null out device pointers to rx and tx queue
arrays when we release the queues during a reset.

Signed-off-by: Jasper Tran O'Leary <jtranoleary@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
---
 doc/guides/nics/gve.rst                | 10 ++++-
 doc/guides/rel_notes/release_26_03.rst |  3 ++
 drivers/net/gve/gve_ethdev.c            | 40 ++++++++++++++++++++
 drivers/net/gve/gve_rx.c                |  2 +
 drivers/net/gve/gve_rx_dqo.c            |  2 +
 drivers/net/gve/gve_tx.c                |  2 +
 drivers/net/gve/gve_tx_dqo.c            |  2 +
 7 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/doc/guides/nics/gve.rst b/doc/guides/nics/gve.rst
index 2a6798d..415d060 100644
--- a/doc/guides/nics/gve.rst
+++ b/doc/guides/nics/gve.rst
@@ -34,7 +34,7 @@ to find the original base code.
 GVE has 3 queue formats:
 
 - GQI_QPL - GQI with queue page list
-- GQI_RDA - GQI with raw DMA addressing
+- GQI_RDA - GQI with raw DMA addressing (deprecated)
 - DQO_RDA - DQO with raw DMA addressing
 
 GQI_QPL queue format is queue page list mode.
@@ -102,3 +102,11 @@ Because the initial RSS hash creates a default redirection table,
 the redirection table will be available for querying upon initial hash configuration.
 When performing redirection table updates,
 it is possible to update individual table entries.
+
+Application-Initiated Reset
+^^^^^^^^^^^^^^^^^^^^^^^^^^^
+The driver allows an application to reset the gVNIC device. This function
+will tear down and reinitialize the device's resources, including queues and
+administrative queues. The device must be stopped prior to calling the reset
+function. It is the application's responsibility to reinitialize the device
+and restart the device after resetting it.
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index add2251..fd0fc8e 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -55,6 +55,9 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Updated Google Virtual Ethernet (gve) ethernet driver.**
+
+  Added application-initiated device reset.
 
 Removed Items
 -------------
diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index 6341d89..b280382 100644
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
+	int err;
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
2.52.0.457.g6b5491de43-goog

