Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6DBC43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Jul 2026 11:26:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB297409FA;
	Thu,  9 Jul 2026 13:26:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 0A6F3402BB;
 Thu,  9 Jul 2026 13:26:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783596384; x=1815132384;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3cjntBy2oG0a4edsD6U7MsEV8bMcnVN8AoHs/jGV7tw=;
 b=BNQ7TEMMwJsCCBYe2AcLnngM9YzReEFlWF+pCKS9RXQMTQUTWYblJQCx
 wc2v4fO5hQVYt/CGm8VSZreb0bkmXc4wRW3TKOLA3gxSzFzWNmeKK8vf4
 qWw94qUVAvlwYIs1d/vTYjTmPB2Yj84fXLzL94sUK1nIfVHXyo/VL65Sd
 e7V9xrc6WWJsxaCXJla4IQA/RPsFMn1ctYmFjAbVU4z2V9j4HvfJuo/wn
 A/YY88gZFwzm4XhOptjWs2NTBJte5KmW1m+dfH4hCyyYYtxuMM2OwvYXi
 59n+jQp34mZRMhLILkn6yRBlZphrrvqQBID44B6qkTuLL3qU59UScbXBF w==;
X-CSE-ConnectionGUID: /8TxRivfR/ej1YoMr6vBig==
X-CSE-MsgGUID: aMU0gpI3SY25JU8c5MnRpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="94879766"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="94879766"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2026 04:26:23 -0700
X-CSE-ConnectionGUID: ystr1APXSSm49fpN7RwJ5Q==
X-CSE-MsgGUID: 4wjL2oejT4amYL9UP8c6SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="259461748"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa005.fm.intel.com with ESMTP; 09 Jul 2026 04:26:22 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, Ciara Loftus <ciara.loftus@intel.com>,
 stable@dpdk.org
Subject: [PATCH v2 1/3] net/ice: poll AdminQ if interrupt delivery unavailable
Date: Thu,  9 Jul 2026 11:25:54 +0000
Message-ID: <20260709112556.1765262-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709112556.1765262-1-ciara.loftus@intel.com>
References: <20260630141627.1035420-1-ciara.loftus@intel.com>
 <20260709112556.1765262-1-ciara.loftus@intel.com>
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

If interrupt registration fails eg. on FreeBSD with nic_uio, the ice
interrupt handler is never called and AdminQ messages, including
unsolicited link state notifications, are never processed.

This gap has always existed but was partially masked by the blocking link
status poll in the ice dev_start function, which would delay some time
until the link was up before returning. In this case, the link status was
typically correct after dev_start. However after that delay was removed in
commit 2dd7e998550e ("net/ice: revert fix link up when starting device"),
the link status was often wrong after dev_start, and there was no mechanism
to self-correct.

Rather than restoring the blocking wait removed by that commit which
would re-impose a startup delay on every platform, instead activate a
periodic alarm that drains the AdminQ on a 50ms interval, replicating the
role of the interrupt handler on platforms where interrupt delivery is not
supported.

Fixes: 2dd7e998550e ("net/ice: revert fix link up when starting device")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
* Added warning on rte_eal_alarm_set failure
* Only set use_aq_polling if rte_eal_alarm_set succeeds
* Move alarm cancel in ice_dev_stop to prevent a race
* Remove unnecessary alarm cancel from ice_dev_start error path
---
 drivers/net/intel/ice/ice_ethdev.c | 42 +++++++++++++++++++++++++++++-
 drivers/net/intel/ice/ice_ethdev.h |  1 +
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 4be5b63c9a..8db5168b88 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -3,6 +3,7 @@
  */
 
 #include <rte_string_fns.h>
+#include <rte_alarm.h>
 #include <ethdev_pci.h>
 
 #include <ctype.h>
@@ -110,7 +111,11 @@ enum ice_link_state_on_close {
 
 #define ICE_RSS_LUT_GLOBAL_QUEUE_NB	64
 
+/* Polling interval used when the interrupt path is unavailable */
+#define ICE_AQ_ALARM_INTERVAL 50000 /* us */
+
 static int ice_dev_configure(struct rte_eth_dev *dev);
+static void ice_aq_alarm_handler(void *param);
 static int ice_dev_start(struct rte_eth_dev *dev);
 static int ice_dev_stop(struct rte_eth_dev *dev);
 static int ice_dev_close(struct rte_eth_dev *dev);
@@ -1475,6 +1480,28 @@ ice_handle_aq_msg(struct rte_eth_dev *dev)
 	}
 }
 
+/*
+ * Alarm-based AdminQ polling handler that drains the AdminQ to process
+ * async events, then re-arms itself.
+ *
+ * @param param
+ *  The address of parameter (struct rte_eth_dev *) registered before.
+ *
+ * @return
+ *  void
+ */
+static void
+ice_aq_alarm_handler(void *param)
+{
+	struct rte_eth_dev *dev = (struct rte_eth_dev *)param;
+	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+
+	if (!pf->adapter_stopped) {
+		ice_handle_aq_msg(dev);
+		rte_eal_alarm_set(ICE_AQ_ALARM_INTERVAL, ice_aq_alarm_handler, dev);
+	}
+}
+
 /**
  * Interrupt handler triggered by NIC for handling
  * specific interrupt.
@@ -2961,6 +2988,11 @@ ice_dev_stop(struct rte_eth_dev *dev)
 	pf->adapter_stopped = true;
 	dev->data->dev_started = 0;
 
+	if (pf->use_aq_polling) {
+		rte_eal_alarm_cancel(ice_aq_alarm_handler, dev);
+		pf->use_aq_polling = false;
+	}
+
 	return 0;
 }
 
@@ -4479,7 +4511,15 @@ ice_dev_start(struct rte_eth_dev *dev)
 	if (ice_rxq_intr_setup(dev))
 		return -EIO;
 
-	rte_intr_enable(pci_dev->intr_handle);
+	/* Fall back to polling the AdminQ via an alarm on platforms where
+	 * interrupt delivery is unavailable.
+	 */
+	if (rte_intr_enable(pci_dev->intr_handle) != 0) {
+		if (rte_eal_alarm_set(ICE_AQ_ALARM_INTERVAL, ice_aq_alarm_handler, dev) != 0)
+			PMD_DRV_LOG(WARNING, "Failed to set alarm for AdminQ polling");
+		else
+			pf->use_aq_polling = true;
+	}
 
 	/* Enable receiving broadcast packets and transmitting packets */
 	ice_set_bit(ICE_PROMISC_BCAST_RX, pmask);
diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index 0a9d75b9cd..7ee3ea8a70 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -599,6 +599,7 @@ struct ice_pf {
 	struct ice_eth_stats internal_stats;
 	bool offset_loaded;
 	bool adapter_stopped;
+	bool use_aq_polling; /* true when alarm polls AdminQ in place of interrupt */
 	struct ice_flow_list flow_list;
 	rte_spinlock_t flow_ops_lock;
 	bool init_link_up;
-- 
2.43.0

