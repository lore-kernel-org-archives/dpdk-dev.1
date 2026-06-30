Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7ED2C43327
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 14:16:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1173F4068E;
	Tue, 30 Jun 2026 16:16:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 52FCE40648;
 Tue, 30 Jun 2026 16:16:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782829007; x=1814365007;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8EcUX6tWPTVbSr1C9e6ez4yjUmVJbsklvMIuqjk5iPY=;
 b=QJuTvmbmbjiYnGkWQ2tPUnOgkfIxBZ0vxouMu7xQON/hnjxKFi+BNjfe
 p4WAXJoD04FsPNelvGWL317e4CR9WYd0IfCUyB9S43sNW/rzf+ex8qIyT
 OcVouPApONWDbJ2Ls8T9sJW5ZFLS0tx8lJspIg1wAMidEZ68NCT+tnLXD
 Nv9jAp3jJG8LAmq2rySBcxedGz6WrVDbwIN/L0SYi2q0oV81vwQ1+Gju6
 U+pX2OZodOvVcUuDsWGq5xdAuNhcqsTJaZ5ZzSmOIHO2MSO+4by8r/ADq
 Kqv0SHJflyKE3bZAWKZWUPQW/Mvk6rj8cKn86tyQG1XT8o+F0sPJ/8cWh Q==;
X-CSE-ConnectionGUID: wxMjxsH1ScS9VLx51wTogg==
X-CSE-MsgGUID: wml/qKpXSi6a3a83DWKbXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="94693505"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; d="scan'208";a="94693505"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 07:16:46 -0700
X-CSE-ConnectionGUID: K3vhqF27S7Kdh6aoehFzcA==
X-CSE-MsgGUID: yom39KBUSoSS25oYoU1Tuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; d="scan'208";a="248291042"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa010.fm.intel.com with ESMTP; 30 Jun 2026 07:16:45 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH 1/2] net/ice: poll AdminQ if interrupt delivery unavailable
Date: Tue, 30 Jun 2026 14:16:26 +0000
Message-ID: <20260630141627.1035420-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630141627.1035420-1-ciara.loftus@intel.com>
References: <20260630141627.1035420-1-ciara.loftus@intel.com>
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
2dd7e99855 ("net/ice: revert fix link up when starting device"), the link
status was often wrong after dev_start, and there was no mechanism to
self-correct.

Rather than restoring the blocking wait removed by that commit which
would re-impose a startup delay on every platform, instead activate a
periodic alarm that drains the AdminQ on a 50ms interval, replicating the
role of the interrupt handler on platforms where interrupt delivery is not
supported.

Fixes: 2dd7e99855 ("net/ice: revert fix link up when starting device")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 45 +++++++++++++++++++++++++++++-
 drivers/net/intel/ice/ice_ethdev.h |  1 +
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 022d92a2f6..447742ff8d 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -3,6 +3,7 @@
  */
 
 #include <rte_string_fns.h>
+#include <rte_alarm.h>
 #include <ethdev_pci.h>
 
 #include <ctype.h>
@@ -108,7 +109,11 @@ enum ice_link_state_on_close {
 
 #define ICE_RSS_LUT_GLOBAL_QUEUE_NB	64
 
+/* Polling interval used when the interrupt path is unavailable */
+#define ICE_AQ_ALARM_INTERVAL 50000 /* us */
+
 static int ice_dev_configure(struct rte_eth_dev *dev);
+static void ice_aq_alarm_handler(void *param);
 static int ice_dev_start(struct rte_eth_dev *dev);
 static int ice_dev_stop(struct rte_eth_dev *dev);
 static int ice_dev_close(struct rte_eth_dev *dev);
@@ -1473,6 +1478,28 @@ ice_handle_aq_msg(struct rte_eth_dev *dev)
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
@@ -2913,6 +2940,11 @@ ice_dev_stop(struct rte_eth_dev *dev)
 	rte_intr_efd_disable(intr_handle);
 	rte_intr_vec_list_free(intr_handle);
 
+	if (pf->use_aq_polling) {
+		rte_eal_alarm_cancel(ice_aq_alarm_handler, dev);
+		pf->use_aq_polling = false;
+	}
+
 	pf->adapter_stopped = true;
 	dev->data->dev_started = 0;
 
@@ -4434,7 +4466,13 @@ ice_dev_start(struct rte_eth_dev *dev)
 	if (ice_rxq_intr_setup(dev))
 		return -EIO;
 
-	rte_intr_enable(pci_dev->intr_handle);
+	/* Fall back to polling the AdminQ via an alarm on platforms where
+	 * interrupt delivery is unavailable.
+	 */
+	if (rte_intr_enable(pci_dev->intr_handle) != 0) {
+		pf->use_aq_polling = true;
+		rte_eal_alarm_set(ICE_AQ_ALARM_INTERVAL, ice_aq_alarm_handler, dev);
+	}
 
 	/* Enable receiving broadcast packets and transmitting packets */
 	ice_set_bit(ICE_PROMISC_BCAST_RX, pmask);
@@ -4497,6 +4535,11 @@ ice_dev_start(struct rte_eth_dev *dev)
 	for (i = 0; i < nb_txq; i++)
 		ice_tx_queue_stop(dev, i);
 
+	if (pf->use_aq_polling) {
+		rte_eal_alarm_cancel(ice_aq_alarm_handler, dev);
+		pf->use_aq_polling = false;
+	}
+
 	return -EIO;
 }
 
diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index 20e8a13fe9..86b256fc3f 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -599,6 +599,7 @@ struct ice_pf {
 	struct ice_eth_stats internal_stats;
 	bool offset_loaded;
 	bool adapter_stopped;
+	bool use_aq_polling; /* true when interrupt path unavailable */
 	struct ice_flow_list flow_list;
 	rte_spinlock_t flow_ops_lock;
 	bool init_link_up;
-- 
2.43.0

