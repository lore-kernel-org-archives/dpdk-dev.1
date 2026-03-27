Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047AD10AB82F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 00:20:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2CD7442D55;
	Fri, 27 Mar 2026 01:20:44 +0100 (CET)
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com
 [209.85.215.202])
 by mails.dpdk.org (Postfix) with ESMTP id 010A040151
 for <dev@dpdk.org>; Fri, 27 Mar 2026 01:20:42 +0100 (CET)
Received: by mail-pg1-f202.google.com with SMTP id
 41be03b00d2f7-c7651644975so1020381a12.1
 for <dev@dpdk.org>; Thu, 26 Mar 2026 17:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1774570842; x=1775175642; darn=dpdk.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=y6hZMJd5DCDUVdHFcOJt4SPi/2SWxvX0ueEAEgAAXus=;
 b=UnbUSaWgoxoBT6gOx18+osvDqXl14FHCI6D8oNH8iPeu3NHidue7y74JwT5+AA3W6o
 E0CvA3Os7xHrI4O6YDknfzmrFvhFWvbCTZR7Ax6+1e7Gf0XtmrnNs9QREolhldjDQxPt
 3HPsscWrABCthp+rcu1MUPs9BlnaVfvckYa07U+7TyFlqMuLungfS2Da5r0g9njrAqKk
 QVyfqxksRf46NpM0Ddx3lYNO+6wUagy7vVqQjuEg0EaiHVKQlEfRWgOH684HV3KT0gU1
 ha3zergEaLpv2UJoxvvEj1iWVCh1C3WUk9ci8UmP+hZe1JPXVmqcwTMjRShsRPUkjwuY
 l3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774570842; x=1775175642;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y6hZMJd5DCDUVdHFcOJt4SPi/2SWxvX0ueEAEgAAXus=;
 b=CmsaM2sMJsfjxTecA55dmkgkTKlFa+PfSyrLNbeElJMFtGL+9NC9v4LQ7No4LYpv2h
 l2Y2GHxO/UIOo6wZ70ZDmSTGKZHsRpmwKt4+KDIYImHb0V0A0eJ/BgVmZF7XLO5vtR8/
 OM4v44Ej5W1BrmiqHvPqRQ1C8Ml6B129X3PabbhbKznjxxO7KZRxipK22SPFZYaD93aM
 uGUrSR0K3/gFiWtnMjTFNbLsugdyREG26791Yx9HnFxVwm8vBGrNP9v02pa2u3JouoLi
 mHR/xcU/TQmuLLYuyrc/WYnAaUmvxTslLxOHW2eEUx4Nlmj4F16trgmVIqFZVnv8LgEW
 3nBg==
X-Gm-Message-State: AOJu0YywBsMa/+89E/VVY3DWOHoFo4WmY/BA1/HH39UcUS7NRFjdk6fz
 MUfuvhyF6OJSshYX1w39QCBWHti4GXUDbZDKhWRpj9brlBLYhKpdnmownV9Op5NKsm+8uXOQsFh
 +El6ZDkcPIHjoVNSBdDOVzrX+iQ==
X-Received: from pgbeq24.prod.google.com ([2002:a05:6a02:2698:b0:c76:5ef4:ec3])
 (user=jtranoleary job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:3ca3:b0:39c:3de:efec with SMTP id
 adf61e73a8af0-39c878022f2mr599438637.14.1774570841863; 
 Thu, 26 Mar 2026 17:20:41 -0700 (PDT)
Date: Fri, 27 Mar 2026 00:20:38 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260327002038.3386577-1-jtranoleary@google.com>
Subject: [PATCH] net/gve: add passive device-requested reset
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

In addition to application-initiated resets, during normal operation,
the device can indicate the need to reset by writing a value to a device
status register. This patch introduces an alarm that polls the
status of that register and informs the application of the need to
reset. The application is responsible for registering a callback that
will execute in the event that the alarm discovers that the device
requests a reset.

Signed-off-by: Jasper Tran O'Leary <jtranoleary@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
---
Depends-on: patch-1bf64edce3 ("net/gve: add reset path")

 doc/guides/nics/gve.rst      | 32 ++++++++++++++-
 drivers/net/gve/gve_ethdev.c | 77 ++++++++++++++++++++++++++++++++++++
 drivers/net/gve/gve_ethdev.h |  3 ++
 3 files changed, 110 insertions(+), 2 deletions(-)

diff --git a/doc/guides/nics/gve.rst b/doc/guides/nics/gve.rst
index d94e4cb..f564607 100644
--- a/doc/guides/nics/gve.rst
+++ b/doc/guides/nics/gve.rst
@@ -130,8 +130,8 @@ Security Protocols
 - Flow priorities are not supported (must be 0).
 - Masking is limited to full matches i.e. ``0x00...0`` or ``0xFF...F``.
 
-Application-Initiated Reset
-^^^^^^^^^^^^^^^^^^^^^^^^^^^
+Device Reset
+^^^^^^^^^^^^
 
 The driver allows an application to reset the gVNIC device.
 This function will tear down and reinitialize the device's resources,
@@ -139,3 +139,31 @@ including queues and administrative queues.
 
 It is the application's responsibility to reinitialize
 and restart the device after resetting it.
+
+In addition, the driver supports device-requested resets, which are triggered
+when the device encounters an unrecoverable error. The driver detects this via
+a device status register and raises an ``RTE_ETH_EVENT_INTR_RESET`` event.
+
+The application must register a callback to handle this event. The callback
+should handle the reset process (reset, reconfigure, restart).
+
+.. code-block:: c
+
+   static int
+   dev_rst_req_callback(uint16_t port_id, enum rte_eth_event_type type,
+                        void *param, void *ret_param)
+   {
+       RTE_SET_USED(param);
+       RTE_SET_USED(ret_param);
+
+       if (type == RTE_ETH_EVENT_INTR_RESET) {
+           printf("Device requested reset on port %u\n", port_id);
+           rte_eth_dev_reset(port_id);
+           /* Reconfigure and restart port ... */
+       }
+       return 0;
+   }
+
+   /* Register this callback in the main execution flow */
+   rte_eth_dev_callback_register(port_id, RTE_ETH_EVENT_INTR_RESET,
+                     dev_rst_req_callback, NULL);
diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index fce90ad..7970f46 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -13,6 +13,8 @@
 #include <ethdev_driver.h>
 
 static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device);
+static void gve_start_dev_status_polling(struct rte_eth_dev *dev);
+static void gve_stop_dev_status_polling(struct rte_eth_dev *dev);
 
 static void
 gve_write_version(uint8_t *driver_version_register)
@@ -411,6 +413,11 @@ gve_dev_start(struct rte_eth_dev *dev)
 	struct gve_priv *priv;
 	int ret;
 
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
+		PMD_DRV_LOG(WARNING, "Cannot start device in secondary.");
+		return -EPERM;
+	}
+
 	ret = gve_start_queues(dev);
 	if (ret != 0) {
 		PMD_DRV_LOG(ERR, "Failed to start queues");
@@ -440,6 +447,8 @@ gve_dev_start(struct rte_eth_dev *dev)
 		}
 	}
 
+	gve_start_dev_status_polling(dev);
+
 	return 0;
 }
 
@@ -448,6 +457,17 @@ gve_dev_stop(struct rte_eth_dev *dev)
 {
 	struct gve_priv *priv = dev->data->dev_private;
 
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
+		PMD_DRV_LOG(WARNING, "Cannot stop device in secondary.");
+		return -EPERM;
+	}
+
+	/*
+	 * Block until all polling callbacks have concluded before tearing down
+	 * any device resources.
+	 */
+	gve_stop_dev_status_polling(dev);
+
 	dev->data->dev_started = 0;
 	dev->data->dev_link.link_status = RTE_ETH_LINK_DOWN;
 
@@ -1311,6 +1331,63 @@ gve_set_default_ring_size_bounds(struct gve_priv *priv)
 	priv->min_rx_desc_cnt = GVE_DEFAULT_MIN_RX_RING_SIZE;
 }
 
+static void
+gve_check_device_status(void *arg)
+{
+	struct rte_eth_dev *dev = arg;
+	struct gve_priv *priv = dev->data->dev_private;
+	uint32_t dev_status;
+	int ret;
+
+	dev_status = ioread32be(&priv->reg_bar0->device_status);
+
+	if (dev_status & GVE_DEVICE_STATUS_RESET_MASK) {
+		PMD_DRV_LOG(INFO,
+			"Device on port %u requests a reset. Stopping device status polling.",
+			dev->data->port_id);
+		rte_eth_dev_callback_process(dev, RTE_ETH_EVENT_INTR_RESET,
+			NULL);
+	} else {
+		ret = rte_eal_alarm_set(GVE_DEV_POLL_INTERVAL_US,
+					gve_check_device_status, dev);
+		if (ret != 0) {
+			PMD_DRV_LOG(ERR,
+				"Port %u: Failed to re-arm alarm poller!",
+				dev->data->port_id);
+		}
+	}
+}
+
+static void
+gve_start_dev_status_polling(struct rte_eth_dev *dev)
+{
+	int ret;
+
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return;
+
+	ret = rte_eal_alarm_set(GVE_DEV_POLL_INTERVAL_US,
+				gve_check_device_status,
+				dev);
+
+	if (ret != 0) {
+		PMD_DRV_LOG(ERR,
+			"Port %u: Failed to arm device reset polling alarm! Err=%d",
+			dev->data->port_id, ret);
+	} else {
+		PMD_DRV_LOG(INFO,
+			"Port %u: Armed device reset polling alarm.",
+			dev->data->port_id);
+	}
+}
+
+static void
+gve_stop_dev_status_polling(struct rte_eth_dev *dev)
+{
+	/* Blocks until all in-progress callbacks have completed. */
+	rte_eal_alarm_cancel(gve_check_device_status, dev);
+}
+
 static int
 gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 {
diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index 8fd098c..0577f03 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -7,6 +7,7 @@
 
 #include <ethdev_driver.h>
 #include <ethdev_pci.h>
+#include <rte_alarm.h>
 #include <rte_ether.h>
 #include <rte_pci.h>
 #include <pthread.h>
@@ -57,6 +58,8 @@
 	RTE_ETH_RSS_NONFRAG_IPV6_UDP |	\
 	RTE_ETH_RSS_IPV6_UDP_EX)
 
+#define GVE_DEV_POLL_INTERVAL_US (1 * 1000 * 1000) /* 1 second in microseconds */
+
 /* A list of pages registered with the device during setup and used by a queue
  * as buffers
  */
-- 
2.53.0.1118.gaef5881109-goog

