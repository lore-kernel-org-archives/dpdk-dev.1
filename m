Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00912CCD195
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 11:11:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5121842D7F;
	Fri, 17 Oct 2025 13:11:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id A9910427A2
 for <dev@dpdk.org>; Fri, 17 Oct 2025 13:11:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760699497; x=1792235497;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WdhIAiWvMqur9SgNIMa566AwxpqkxcnZs1njEtHuXD0=;
 b=i2ZIx3UMeOFYfF/ydAfje3LKiNHFVEumcN5WX1DdfoDait1vlsnh47j7
 HwHJJoXjwyea+NR4Pcog1pnjwPIRa5jnD9n1ZEN6R58DXplW5eYQY/yc0
 1xy5BiatpZHMqLOq6VKgsD7Uf2JapR5WFrMKKuB/z4d/KO+PqzrOFcQtW
 BOuUj6qG8PtmAeVMKeE6rC6Dl8XtNR9pp15QZrmmqtuyEoX77ICWk++Qi
 KZ5tDRr6Xqa6vaCwJH9bv7HLSSpSXdGveWcNUyl5JlHiPAvc3kJ7WfzXN
 Q8SJ+dOajQkzDtl2ctfXv2XdBspMMTpt2hfzXU/Dp8Xobxmu9m+d2w7DF g==;
X-CSE-ConnectionGUID: FKYH4u8cTryUWJUBruSokw==
X-CSE-MsgGUID: X7vhIwtbTaWFfTwpefRVFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="74023714"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; d="scan'208";a="74023714"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2025 04:11:36 -0700
X-CSE-ConnectionGUID: qxesWSiTTrSwXabUQ2XMlA==
X-CSE-MsgGUID: yDlMMklNRjWbDVL56nKpEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; d="scan'208";a="182654500"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa006.fm.intel.com with ESMTP; 17 Oct 2025 04:11:35 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [RFC 1/3] ethdev: introduce device reinitialisation API
Date: Fri, 17 Oct 2025 11:11:07 +0000
Message-Id: <20251017111109.1734792-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251017111109.1734792-1-ciara.loftus@intel.com>
References: <20251017111109.1734792-1-ciara.loftus@intel.com>
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

Add a new ethdev API for resetting a device followed by a restoration of
the configuration present at the time of the invocation of the API.
In some cases if the driver can support it, the device will be restarted
if it was started when the API was invoked.

This operation could be useful for example when the user has detected an
issue with the device and wants to reset and reinitialise it in an
attempt to get it working again. While this is possible by calling a
sequence of existing APIs (reset, configure, rx_queue_setup and
tx_queue_setup), in the case where we are restoring the exact same
configuration, much of the reconfiguration performed in those calls
would be unnecessary and can be achieved by calling a subset of that
functionality, which is what this API will perform.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 lib/ethdev/ethdev_driver.h       |  4 ++++
 lib/ethdev/ethdev_trace.h        |  7 +++++++
 lib/ethdev/ethdev_trace_points.c |  3 +++
 lib/ethdev/rte_ethdev.c          | 32 ++++++++++++++++++++++++++++++++
 lib/ethdev/rte_ethdev.h          | 25 +++++++++++++++++++++++++
 5 files changed, 71 insertions(+)

diff --git a/lib/ethdev/ethdev_driver.h b/lib/ethdev/ethdev_driver.h
index 71085bddff..18fff9f1a1 100644
--- a/lib/ethdev/ethdev_driver.h
+++ b/lib/ethdev/ethdev_driver.h
@@ -229,6 +229,9 @@ typedef int (*eth_dev_close_t)(struct rte_eth_dev *dev);
 /** @internal Function used to reset a configured Ethernet device. */
 typedef int (*eth_dev_reset_t)(struct rte_eth_dev *dev);
 
+/** @internal Function used to reinitialise a configured Ethernet device. */
+typedef int (*eth_dev_reinit_t)(struct rte_eth_dev *dev);
+
 /** @internal Function used to detect an Ethernet device removal. */
 typedef int (*eth_is_removed_t)(struct rte_eth_dev *dev);
 
@@ -1387,6 +1390,7 @@ struct eth_dev_ops {
 	eth_dev_set_link_down_t    dev_set_link_down; /**< Device link down */
 	eth_dev_close_t            dev_close;     /**< Close device */
 	eth_dev_reset_t		   dev_reset;	  /**< Reset device */
+	eth_dev_reinit_t	   dev_reinit;	  /**< Reinitialize device */
 	eth_link_update_t          link_update;   /**< Get device link state */
 	eth_speed_lanes_get_t	   speed_lanes_get;	  /**< Get link speed active lanes */
 	eth_speed_lanes_set_t      speed_lanes_set;	  /**< Set link speeds supported lanes */
diff --git a/lib/ethdev/ethdev_trace.h b/lib/ethdev/ethdev_trace.h
index 482befc209..a1eb5a4438 100644
--- a/lib/ethdev/ethdev_trace.h
+++ b/lib/ethdev/ethdev_trace.h
@@ -231,6 +231,13 @@ RTE_TRACE_POINT(
 	rte_trace_point_emit_int(ret);
 )
 
+RTE_TRACE_POINT(
+	rte_ethdev_trace_reinit,
+	RTE_TRACE_POINT_ARGS(uint16_t port_id, int ret),
+	rte_trace_point_emit_u16(port_id);
+	rte_trace_point_emit_int(ret);
+)
+
 RTE_TRACE_POINT(
 	rte_eth_trace_rx_hairpin_queue_setup,
 	RTE_TRACE_POINT_ARGS(uint16_t port_id, uint16_t rx_queue_id,
diff --git a/lib/ethdev/ethdev_trace_points.c b/lib/ethdev/ethdev_trace_points.c
index 071c508327..57713d6e70 100644
--- a/lib/ethdev/ethdev_trace_points.c
+++ b/lib/ethdev/ethdev_trace_points.c
@@ -143,6 +143,9 @@ RTE_TRACE_POINT_REGISTER(rte_ethdev_trace_set_link_down,
 RTE_TRACE_POINT_REGISTER(rte_ethdev_trace_reset,
 	lib.ethdev.reset)
 
+RTE_TRACE_POINT_REGISTER(rte_ethdev_trace_reinit,
+	lib.ethdev.reinit)
+
 RTE_TRACE_POINT_REGISTER(rte_ethdev_trace_is_removed,
 	lib.ethdev.is_removed)
 
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index f22139cb38..67d69fef34 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -2057,6 +2057,38 @@ rte_eth_dev_reset(uint16_t port_id)
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_reinit, 25.11)
+int
+rte_eth_dev_reinit(uint16_t port_id)
+{
+	struct rte_eth_dev *dev;
+	int ret;
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
+	dev = &rte_eth_devices[port_id];
+
+	if (dev->dev_ops->dev_reinit == NULL)
+		return -ENOTSUP;
+
+	if (dev->data->dev_configured == 0) {
+		RTE_ETHDEV_LOG_LINE(INFO,
+			"Cannot reinit device (port %u), device not configured",
+			port_id);
+		return -EINVAL;
+	}
+
+	ret = eth_err(port_id, dev->dev_ops->dev_reinit(dev));
+
+	if (ret == -EBUSY)
+		RTE_ETHDEV_LOG_LINE(INFO,
+			"Cannot reinit started device (port %u), please stop it first",
+			port_id);
+
+	rte_ethdev_trace_reinit(port_id, ret);
+
+	return ret;
+}
+
 RTE_EXPORT_SYMBOL(rte_eth_dev_is_removed)
 int
 rte_eth_dev_is_removed(uint16_t port_id)
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index d23c143eed..accc559af3 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -2989,6 +2989,31 @@ int rte_eth_dev_close(uint16_t port_id);
  */
 int rte_eth_dev_reset(uint16_t port_id);
 
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Reinitialise an Ethernet device and restore its configuration.
+ *
+ * When a device needs to be reset passively and the current configuration
+ * needs to be restored following the reset, the DPDK application can
+ * invoke this function. Some devices may also restart the device after
+ * the reinit if it was started before, if the device can do this safely.
+ *
+ * @param port_id
+ *   The port identifier of the Ethernet device.
+ *
+ * @return
+ *   - (0) if successful.
+ *   - (-ENODEV) if *port_id* is invalid.
+ *   - (-ENOTSUP) if hardware doesn't support this function.
+ *   - (-EBUSY) if the device is started and the driver needs it to be
+ *   stopped before performing the reinit.
+ *   - (<0): Error code of the driver reinitialisation function.
+ */
+__rte_experimental
+int rte_eth_dev_reinit(uint16_t port_id);
+
 /**
  * Enable receipt in promiscuous mode for an Ethernet device.
  *
-- 
2.34.1

