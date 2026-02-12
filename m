Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993A4EDF04B
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 07:02:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64AAA402C0;
	Thu, 12 Feb 2026 08:02:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id E121C40291
 for <dev@dpdk.org>; Thu, 12 Feb 2026 08:02:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770879758; x=1802415758;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=E53Vc5fyBJVYTOsDDBRXVaxmxJLxjQrmYJO7kf0uIIw=;
 b=VVu+VXiAYqKe1De2oi77o9GDgDAj9qZQXhJMY625KtCdpnPUf9OE9ES/
 ro4ImNowaxUiAXZSFZBA5hSkYC7PXvZNPhcgrbB916tsBoobFDlmdFy+Y
 aDlDpWqb6iSkhmmvq2jTkCMd0QeRrREOkoGHavQRQW2ig6n2mdrkyfnSz
 BI3xqC0IlIq1jqSbjXSN5BHH/PUvb1953e6/tbbN7lfyYvkoCN2H/BNtL
 JCmmPgIMeW8kcaJpwTJmJwNNqHJzTEdaE4FCWIVL9YytzstlDxg8mMJxb
 xbxfMarIT95uj1myKakZtMMaLxSOfJuwwiOHShr0yDCO+9o4WP3IvqCAl w==;
X-CSE-ConnectionGUID: jHJH641WQ6aw3kRN1vG1QQ==
X-CSE-MsgGUID: XLHNIb3VQHKstQjGQ4ONOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="71948694"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="71948694"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 23:02:37 -0800
X-CSE-ConnectionGUID: toq8WhPjT4io0gmZYcCtNQ==
X-CSE-MsgGUID: 8CTsoQbqQiS8q2R8j0pg0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="211796690"
Received: from unknown (HELO localhost.localdomain) ([10.239.252.253])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 23:02:35 -0800
From: Mingjin Ye <mingjinx.ye@intel.com>
To: dev@dpdk.org
Cc: Mingjin Ye <mingjinx.ye@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH] net/ice: enable link status polling
Date: Thu, 12 Feb 2026 07:03:01 +0000
Message-Id: <20260212070302.2480480-1-mingjinx.ye@intel.com>
X-Mailer: git-send-email 2.25.1
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

Add the `link_status_poll_ms` devargs parameter (in milliseconds).
If greater than zero, ICE PF uses an alarm handler to poll link
status periodically.

Signed-off-by: Mingjin Ye <mingjinx.ye@intel.com>
---
 doc/guides/nics/ice.rst            |  7 +++
 drivers/net/intel/ice/ice_ethdev.c | 95 ++++++++++++++++++++++++++++--
 drivers/net/intel/ice/ice_ethdev.h |  1 +
 3 files changed, 99 insertions(+), 4 deletions(-)

diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index 216c79b6f2..0eded96826 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -382,6 +382,13 @@ Runtime Configuration
   * ``segment``: Check number of mbuf segments does not exceed HW limits.
   * ``offload``: Check for use of an unsupported offload flag.
 
+- ``Link status poll`` (default ``not enabled``)
+
+  Link status polling can be enabled by setting the ``devargs``
+  parameter ``link_status_poll_ms`` (in milliseconds). If the value is set
+  to 0 or negative, polling is disabled.
+  For example ``-a 81:00.0,link_status_poll_ms=50`` or ``-a 81:00.0,link_status_poll_ms=0``.
+
 Driver compilation and testing
 ------------------------------
 
diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index ade13600de..ae891caca5 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -15,6 +15,7 @@
 
 #include <rte_tailq.h>
 #include <rte_os_shim.h>
+#include <rte_alarm.h>
 
 #include "eal_firmware.h"
 
@@ -43,6 +44,7 @@
 #define ICE_TM_LEVELS_ARG         "tm_sched_levels"
 #define ICE_SOURCE_PRUNE_ARG      "source-prune"
 #define ICE_LINK_STATE_ON_CLOSE   "link_state_on_close"
+#define ICE_LINK_STATE_POLL_MS_ARG       "link_status_poll_ms"
 
 #define ICE_CYCLECOUNTER_MASK  0xffffffffffffffffULL
 
@@ -61,6 +63,7 @@ static const char * const ice_valid_args[] = {
 	ICE_TM_LEVELS_ARG,
 	ICE_SOURCE_PRUNE_ARG,
 	ICE_LINK_STATE_ON_CLOSE,
+	ICE_LINK_STATE_POLL_MS_ARG,
 	NULL
 };
 
@@ -1482,6 +1485,38 @@ ice_handle_aq_msg(struct rte_eth_dev *dev)
 	rte_free(event.msg_buf);
 }
 #endif
+static void
+ice_link_once_update(void *cb_arg)
+{
+	int ret;
+	struct timespec sys_time;
+	struct rte_eth_dev *dev = cb_arg;
+
+	ret = ice_link_update(dev, 0);
+	if (!ret) {
+		clock_gettime(CLOCK_REALTIME, &sys_time);
+		PMD_DRV_LOG(INFO, "Current SYS Time: %.24s %.9ld ns",
+				ctime(&sys_time.tv_sec), sys_time.tv_nsec);
+
+		rte_eth_dev_callback_process
+			(dev, RTE_ETH_EVENT_INTR_LSC, NULL);
+	}
+}
+
+static void
+ice_link_cycle_update(void *cb_arg)
+{
+	struct rte_eth_dev *dev = cb_arg;
+	struct ice_adapter *adapter =
+		ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
+
+	ice_link_once_update(cb_arg);
+
+	/* re-alarm link update */
+	if (rte_eal_alarm_set(adapter->devargs.link_status_poll_ms,
+				&ice_link_cycle_update, cb_arg))
+		PMD_DRV_LOG(ERR, "Failed to enable cycle link update");
+}
 
 /**
  * Interrupt handler triggered by NIC for handling
@@ -1499,6 +1534,8 @@ static void
 ice_interrupt_handler(void *param)
 {
 	struct rte_eth_dev *dev = (struct rte_eth_dev *)param;
+	struct ice_adapter *adapter =
+			ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct ice_hw *hw = ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	uint32_t oicr;
 	uint32_t reg;
@@ -1533,10 +1570,19 @@ ice_interrupt_handler(void *param)
 #else
 	if (oicr & PFINT_OICR_LINK_STAT_CHANGE_M) {
 		PMD_DRV_LOG(INFO, "OICR: link state change event");
-		ret = ice_link_update(dev, 0);
-		if (!ret)
-			rte_eth_dev_callback_process
-				(dev, RTE_ETH_EVENT_INTR_LSC, NULL);
+		if (adapter->devargs.link_status_poll_ms <= 0) {
+			ret = ice_link_update(dev, 0);
+			if (!ret)
+				rte_eth_dev_callback_process
+					(dev, RTE_ETH_EVENT_INTR_LSC, NULL);
+		} else {
+			/* With link status polling enabled, "link_status"
+			 * updates are confined to the alarm thread to
+			 * avoid race conditions.
+			 */
+			if (rte_eal_alarm_set(1, &ice_link_once_update, dev))
+				PMD_DRV_LOG(ERR, "Failed to enable link update");
+		}
 	}
 #endif
 
@@ -2381,6 +2427,25 @@ ice_parse_mbuf_check(__rte_unused const char *key, const char *value, void *args
 	return ret;
 }
 
+static int
+ice_parse_link_status_poll_ms(__rte_unused const char *key,
+		const char *value, void *args)
+{
+	int *num = (int *)args;
+	int tmp;
+
+	if (value == NULL || args == NULL)
+		return -EINVAL;
+
+	tmp = strtoul(value, NULL, 10);
+	if (errno == EINVAL || errno == ERANGE)
+		return -1;
+
+	*num = tmp * 1000;
+
+	return 0;
+}
+
 static int ice_parse_devargs(struct rte_eth_dev *dev)
 {
 	struct ice_adapter *ad =
@@ -2469,6 +2534,12 @@ static int ice_parse_devargs(struct rte_eth_dev *dev)
 
 	ret = rte_kvargs_process(kvlist, ICE_LINK_STATE_ON_CLOSE,
 				 &parse_link_state_on_close, &ad->devargs.link_state_on_close);
+	if (ret)
+		goto bail;
+
+	ret = rte_kvargs_process(kvlist, ICE_LINK_STATE_POLL_MS_ARG,
+				 &ice_parse_link_status_poll_ms,
+				 &ad->devargs.link_status_poll_ms);
 
 bail:
 	rte_kvargs_free(kvlist);
@@ -2902,6 +2973,9 @@ ice_dev_stop(struct rte_eth_dev *dev)
 	if (pf->adapter_stopped)
 		return 0;
 
+	if (ad->devargs.link_status_poll_ms > 0)
+		rte_eal_alarm_cancel(&ice_link_cycle_update, (void *)dev);
+
 	/* stop and clear all Rx queues */
 	for (i = 0; i < data->nb_rx_queues; i++)
 		ice_rx_queue_stop(dev, i);
@@ -4398,6 +4472,8 @@ ice_dev_start(struct rte_eth_dev *dev)
 	struct rte_eth_dev_data *data = dev->data;
 	struct ice_hw *hw = ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+	struct rte_pci_device *pci_dev = ICE_DEV_TO_PCI(dev);
+	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct ice_vsi *vsi = pf->main_vsi;
 	struct ice_adapter *ad =
 			ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
@@ -4474,8 +4550,19 @@ ice_dev_start(struct rte_eth_dev *dev)
 
 	ice_dev_set_link_up(dev);
 
+	/* Disable interrupts to avoid race on link status between callback and main thread. */
+	rte_intr_disable(intr_handle);
 	/* Call get_link_info aq command to enable/disable LSE */
 	ice_link_update(dev, 1);
+	rte_intr_enable(intr_handle);
+
+	if (ad->devargs.link_status_poll_ms > 0) {
+		if (rte_eal_alarm_set(ad->devargs.link_status_poll_ms,
+					&ice_link_cycle_update, (void *)dev) < 0) {
+			PMD_DRV_LOG(ERR, "Failed to enable cycle link update");
+			goto rx_err;
+		}
+	}
 
 	pf->adapter_stopped = false;
 
diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index 9562b2b8f1..781fa3d6ae 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -631,6 +631,7 @@ struct ice_devargs {
 	char xtr_field_name[RTE_MBUF_DYN_NAMESIZE];
 	uint64_t mbuf_check;
 	const char *ddp_filename;
+	uint32_t link_status_poll_ms;
 };
 
 /**
-- 
2.25.1

