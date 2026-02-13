Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FF6EF48F3
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 08:57:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A7A7402B2;
	Fri, 13 Feb 2026 09:57:03 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 1480B402A9
 for <dev@dpdk.org>; Fri, 13 Feb 2026 09:57:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770973022; x=1802509022;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4bitsrgV10YIOONpc2N7iOK36uXol+uZxwrPKkDrSQA=;
 b=cUjuaDA7Wx9mLHYAThbsBG3ilA9DiHZ0Pan+ybrU26KZ13UzQ0CXvxrg
 eFOhvyH2alMJMz+KwmVK9OzdY6VNr9fGxoe5VFor1ZL0VT9Nyx9FX9+uf
 7XohWm9zPzj6GJ3dAL7gtI1tOTBIvA5IW5RoISKRhF7s/S/JwG0KssjSW
 Dt4DqyzeTUOcrGd//n5peLlcFM13c3+ZbevtWsVkWsdQZLIBaU3R8gbPf
 HVExfjwnT8Owmfat01mbU68PTDgwFitzMqd7kYOytUooaIoRGicz610XW
 iZrh3G6xF/Dieenwd6e4sBw9aYwxFN/BMBlJkwyoPBCtRnJV8oGFhPKTN w==;
X-CSE-ConnectionGUID: vEi25DHEQR2rGgpotsXiEA==
X-CSE-MsgGUID: HBqT5JgwS7a87bMFCgVsKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="72050331"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="72050331"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 00:57:01 -0800
X-CSE-ConnectionGUID: ktr8WlMVRvS9SG4ekaTVTw==
X-CSE-MsgGUID: k7gB5bULSniresMnIXFoXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="212113564"
Received: from unknown (HELO localhost.localdomain) ([10.239.252.253])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 00:56:58 -0800
From: Mingjin Ye <mingjinx.ye@intel.com>
To: dev@dpdk.org
Cc: Mingjin Ye <mingjinx.ye@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v2] net/ice: enable link status polling
Date: Fri, 13 Feb 2026 08:57:28 +0000
Message-Id: <20260213085728.3106335-1-mingjinx.ye@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241118085150.2587595-1-mingjinx.ye@intel.com>
References: <20241118085150.2587595-1-mingjinx.ye@intel.com>
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
v2: fix: address issues reported in v1 review.
---
 doc/guides/nics/ice.rst            |   7 ++
 drivers/net/intel/ice/ice_ethdev.c | 109 +++++++++++++++++++++++++++--
 drivers/net/intel/ice/ice_ethdev.h |   2 +
 3 files changed, 114 insertions(+), 4 deletions(-)

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
index ade13600de..c8bf4511bb 100644
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
 
@@ -1482,6 +1485,36 @@ ice_handle_aq_msg(struct rte_eth_dev *dev)
 	rte_free(event.msg_buf);
 }
 #endif
+static void
+ice_link_once_update(void *cb_arg)
+{
+	int ret;
+	struct rte_eth_dev *dev = cb_arg;
+
+	ret = ice_link_update(dev, 0);
+	if (ret == 0)
+		rte_eth_dev_callback_process
+			(dev, RTE_ETH_EVENT_INTR_LSC, NULL);
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
+	if (rte_eal_alarm_set(adapter->devargs.link_status_poll_ms * 1000,
+				&ice_link_cycle_update, cb_arg) != 0) {
+		adapter->lsc_polling = false;
+		PMD_DRV_LOG(ERR, "Failed to enable cycle link update");
+	} else {
+		adapter->lsc_polling = true;
+	}
+}
 
 /**
  * Interrupt handler triggered by NIC for handling
@@ -1499,6 +1532,8 @@ static void
 ice_interrupt_handler(void *param)
 {
 	struct rte_eth_dev *dev = (struct rte_eth_dev *)param;
+	struct ice_adapter *adapter =
+			ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct ice_hw *hw = ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	uint32_t oicr;
 	uint32_t reg;
@@ -1533,10 +1568,28 @@ ice_interrupt_handler(void *param)
 #else
 	if (oicr & PFINT_OICR_LINK_STAT_CHANGE_M) {
 		PMD_DRV_LOG(INFO, "OICR: link state change event");
-		ret = ice_link_update(dev, 0);
-		if (!ret)
-			rte_eth_dev_callback_process
-				(dev, RTE_ETH_EVENT_INTR_LSC, NULL);
+		if (adapter->devargs.link_status_poll_ms <= 0) {
+			ret = ice_link_update(dev, 0);
+			if (ret == 0)
+				rte_eth_dev_callback_process
+					(dev, RTE_ETH_EVENT_INTR_LSC, NULL);
+		} else {
+			/* With link status polling enabled, "link_status"
+			 * updates are confined to the alarm thread to
+			 * avoid race conditions.
+			 */
+			if (rte_eal_alarm_set(1, &ice_link_once_update, dev))
+				PMD_DRV_LOG(ERR, "Failed to enable link update");
+
+			/* Attempt to recover from a failed link status polling. */
+			if (!adapter->lsc_polling) {
+				if (rte_eal_alarm_set(adapter->devargs.link_status_poll_ms * 1000,
+							&ice_link_cycle_update, (void *)dev) != 0)
+					PMD_DRV_LOG(ERR, "Failed to enable cycle link update");
+				else
+					adapter->lsc_polling = true;
+			}
+		}
 	}
 #endif
 
@@ -2381,6 +2434,26 @@ ice_parse_mbuf_check(__rte_unused const char *key, const char *value, void *args
 	return ret;
 }
 
+static int
+ice_parse_link_status_poll_ms(__rte_unused const char *key,
+		const char *value, void *args)
+{
+	int *num = args;
+	int tmp;
+
+	if (value == NULL || args == NULL)
+		return -EINVAL;
+
+	errno = 0;
+	tmp = strtoul(value, NULL, 10);
+	if (errno == EINVAL || errno == ERANGE)
+		return -1;
+
+	*num = tmp;
+
+	return 0;
+}
+
 static int ice_parse_devargs(struct rte_eth_dev *dev)
 {
 	struct ice_adapter *ad =
@@ -2469,6 +2542,12 @@ static int ice_parse_devargs(struct rte_eth_dev *dev)
 
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
@@ -2902,6 +2981,12 @@ ice_dev_stop(struct rte_eth_dev *dev)
 	if (pf->adapter_stopped)
 		return 0;
 
+	if (ad->devargs.link_status_poll_ms > 0) {
+		rte_eal_alarm_cancel(&ice_link_cycle_update, (void *)dev);
+		ad->lsc_polling = false;
+	}
+
+
 	/* stop and clear all Rx queues */
 	for (i = 0; i < data->nb_rx_queues; i++)
 		ice_rx_queue_stop(dev, i);
@@ -4398,6 +4483,8 @@ ice_dev_start(struct rte_eth_dev *dev)
 	struct rte_eth_dev_data *data = dev->data;
 	struct ice_hw *hw = ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+	struct rte_pci_device *pci_dev = ICE_DEV_TO_PCI(dev);
+	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct ice_vsi *vsi = pf->main_vsi;
 	struct ice_adapter *ad =
 			ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
@@ -4474,8 +4561,22 @@ ice_dev_start(struct rte_eth_dev *dev)
 
 	ice_dev_set_link_up(dev);
 
+	/* Disable interrupts to avoid race on link status between callback and main thread. */
+	rte_intr_disable(intr_handle);
 	/* Call get_link_info aq command to enable/disable LSE */
 	ice_link_update(dev, 1);
+	rte_intr_enable(intr_handle);
+
+	if (ad->devargs.link_status_poll_ms > 0) {
+		if (rte_eal_alarm_set(ad->devargs.link_status_poll_ms * 1000,
+					&ice_link_cycle_update, (void *)dev) != 0) {
+			PMD_DRV_LOG(ERR, "Failed to enable cycle link update");
+			ad->lsc_polling = false;
+			goto rx_err;
+		} else {
+			ad->lsc_polling = true;
+		}
+	}
 
 	pf->adapter_stopped = false;
 
diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index 9562b2b8f1..66d0fce6b6 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -631,6 +631,7 @@ struct ice_devargs {
 	char xtr_field_name[RTE_MBUF_DYN_NAMESIZE];
 	uint64_t mbuf_check;
 	const char *ddp_filename;
+	uint32_t link_status_poll_ms;
 };
 
 /**
@@ -686,6 +687,7 @@ struct ice_adapter {
 	unsigned long disabled_engine_mask;
 	struct ice_parser *psr;
 	bool rx_vec_offload_support;
+	bool lsc_polling;
 };
 
 struct ice_vsi_vlan_pvid_info {
-- 
2.25.1

