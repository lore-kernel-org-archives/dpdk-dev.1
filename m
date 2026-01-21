Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4321FC44506
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 22:00:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44E9A42DA3;
	Wed, 21 Jan 2026 23:00:41 +0100 (CET)
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com
 [209.85.216.74]) by mails.dpdk.org (Postfix) with ESMTP id F2F4B40279
 for <dev@dpdk.org>; Wed, 21 Jan 2026 23:00:39 +0100 (CET)
Received: by mail-pj1-f74.google.com with SMTP id
 98e67ed59e1d1-34c5d203988so580184a91.3
 for <dev@dpdk.org>; Wed, 21 Jan 2026 14:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1769032839; x=1769637639; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=zvz2PLRdPrbaZ6Iv1mhdy58A+3o6DxwpVGXuyksLV6k=;
 b=iKJzIY4ju6efXnzEQ9TjStyPSkgxkZio87rQcCjLW1RygwIyWH1JX6bUlux+Ciiz6o
 2fLnEPVodlJ3gtxm55m9ETEtf281ZW/zrvQXIyXsgzrCT1pLJeqNo3XhIYwtZtkRy7ef
 D4uOtSPgncrs1zIeuGg069GDkDhIDPcQ3uvuqyAvdK4dD1pseg8iT1e3Pw/B5OW48Sg/
 CwETZ0Raab5rtU0ArLRCWcHgFNba4FBNk4q6ci+JOOO0uPWdf0rnjJ4haw7JC9R/dWBa
 wnDPSAssMf8cBmh1ZVnAipc3+umK87DK0m4Fem1HYEqfW/0pL6lkj/kwXIrnWIt9UM4u
 /2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769032839; x=1769637639;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zvz2PLRdPrbaZ6Iv1mhdy58A+3o6DxwpVGXuyksLV6k=;
 b=VsHUIZehaS/8ltjAaJDIoAR87UBcWBakzaCDOysCGY/tjQuC86NWUcd4+Kev7LkR4L
 74tDrKCA257yHQ8FveOvKBrZRy4VCTOojs+1OvLo3cp3H7HN3kKo7tkLnNsN+4alXhlO
 B1WvE27T5WRQsuTHU3PHJlG1aRTc7IH++VaTWkPedTZoFjZMNCLR2XqlZlvEZbrrcH8B
 m6kCM8By5QOS2NcnWLhlU5HYg0g8jp7PRQArpBLLkNfJjZPmRquOMyjBafWQhviyKFNF
 KVRm6nH24l+NWOwfqiWPJnZQroMfM5xvNGgZLyydRdKfzncMp4LVCY5R5172PhvlwyFP
 CkvA==
X-Gm-Message-State: AOJu0Yx5wHd4CukoJOqYjO7wnKp5tS50ddPKSYPD3762o5u5QBokRzds
 Oz6QJHYR9AiQedPJWpSfBStBxxu1tsshpUw2Y1QoI3UkEeP2srCmrJieGga6ZTGAHeYSMVCWSoc
 WNSy0jXfkWVQ5pVpPRd9c0ctV3A==
X-Received: from pjbqj7.prod.google.com ([2002:a17:90b:28c7:b0:34c:811d:e3ca])
 (user=jtranoleary job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4b4e:b0:34c:f92a:ad05 with SMTP id
 98e67ed59e1d1-35272efcb5fmr18218755a91.11.1769032838711; 
 Wed, 21 Jan 2026 14:00:38 -0800 (PST)
Date: Wed, 21 Jan 2026 22:00:35 +0000
In-Reply-To: <20260121193018.2728602-1-jtranoleary@google.com>
Mime-Version: 1.0
References: <20260121193018.2728602-1-jtranoleary@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260121220035.3090402-1-jtranoleary@google.com>
Subject: [PATCH v3] net/gve: add reset path
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
v3:
* Remove unnecessary check that device is stopped, update documentation
  accordingly.

v2:
* Remove unnecessary variable initialization.
* Document reset feature and add to release notes.

 doc/guides/nics/gve.rst                |  9 ++++++-
 doc/guides/rel_notes/release_26_03.rst |  3 +++
 drivers/net/gve/gve_ethdev.c            | 33 +++++++++++++++++++++++++
 drivers/net/gve/gve_rx.c                |  2 ++
 drivers/net/gve/gve_rx_dqo.c            |  2 ++
 drivers/net/gve/gve_tx.c                |  2 ++
 drivers/net/gve/gve_tx_dqo.c            |  2 ++
 7 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/doc/guides/nics/gve.rst b/doc/guides/nics/gve.rst
index 2a6798d..6b4d1f7 100644
--- a/doc/guides/nics/gve.rst
+++ b/doc/guides/nics/gve.rst
@@ -34,7 +34,7 @@ to find the original base code.
 GVE has 3 queue formats:
 
 - GQI_QPL - GQI with queue page list
-- GQI_RDA - GQI with raw DMA addressing
+- GQI_RDA - GQI with raw DMA addressing (deprecated)
 - DQO_RDA - DQO with raw DMA addressing
 
 GQI_QPL queue format is queue page list mode.
@@ -102,3 +102,10 @@ Because the initial RSS hash creates a default redirection table,
 the redirection table will be available for querying upon initial hash configuration.
 When performing redirection table updates,
 it is possible to update individual table entries.
+
+Application-Initiated Reset
+^^^^^^^^^^^^^^^^^^^^^^^^^^^
+The driver allows an application to reset the gVNIC device. This function
+will tear down and reinitialize the device's resources, including queues and
+administrative queues. It is the application's responsibility to reinitialize
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
index 6341d89..5912fec 100644
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
@@ -550,6 +552,35 @@ gve_dev_close(struct rte_eth_dev *dev)
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
@@ -1068,6 +1099,7 @@ static const struct eth_dev_ops gve_eth_dev_ops = {
 	.dev_start            = gve_dev_start,
 	.dev_stop             = gve_dev_stop,
 	.dev_close            = gve_dev_close,
+	.dev_reset            = gve_dev_reset,
 	.dev_infos_get        = gve_dev_info_get,
 	.rx_queue_setup       = gve_rx_queue_setup,
 	.tx_queue_setup       = gve_tx_queue_setup,
@@ -1094,6 +1126,7 @@ static const struct eth_dev_ops gve_eth_dev_ops_dqo = {
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

