Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333171112279
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Apr 2026 02:50:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 73B2940E09;
	Thu,  2 Apr 2026 04:49:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 3CE6340DDA
 for <dev@dpdk.org>; Thu,  2 Apr 2026 04:49:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775098198; x=1806634198;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=e0na3flLqJy18LTtbPVGmiFmimtXisLpM1XHuIOA91o=;
 b=ITTAj3bHJPhjqMdmENrlcyMuZAjfaLGk2XTgx6vfMrCP5RsK4i+eo6pM
 JCcOiYXFq0+hD74Y0XCC7mRe5nhew+MA8DJBb14i2gNIb/r2WkekNmI5J
 Pzj/lcFgedatn1HVtYdNbEFR2V3MxlRwY7fF7MoZIcfzvIi+UVt2yhga4
 EJ/Iu8R4qXynTFmQROPpH99JbExlxy6qRVwHR6vwFnc74gEpIlYudLUTm
 xX+BY2CtPSq+p2R2JTHSuVernluQHZIQ+c9/qTfIqW1h6YbKCdRbDqZDC
 UrRJnWJ73lV3guVMoVX4mccoDdrsXmGAAWdYvUSNFipDzwRZ8Q7KjNouR Q==;
X-CSE-ConnectionGUID: s+a3F7bgRpW3Q6MfBFUp7Q==
X-CSE-MsgGUID: DSTPwxuTRk+7JW5xFG5U8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="87224473"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; d="scan'208";a="87224473"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2026 19:49:57 -0700
X-CSE-ConnectionGUID: rv6VVUbiRK6u3OzuFA4iVw==
X-CSE-MsgGUID: 6769+pN1SEyXTJp9uOZebw==
X-ExtLoop1: 1
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by fmviesa003.fm.intel.com with ESMTP; 01 Apr 2026 19:49:54 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: bruce.richardson@intel.com, manoj.kumar.subbarao@intel.com,
 aman.deep.singh@intel.com, dev@dpdk.org, rajesh3.kumar@intel.com
Subject: [PATCH v1 2/2] net/iavf: reuse device alarm for PHC sync
Date: Thu,  2 Apr 2026 11:21:37 -0400
Message-ID: <20260402152137.1527322-3-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260402152137.1527322-1-soumyadeep.hore@intel.com>
References: <20260402152137.1527322-1-soumyadeep.hore@intel.com>
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

Reuse existing iavf device alarm cadence to drive periodic PHC sync
instead of a dedicated PHC alarm callback.

Keep PHC start/stop hooks as pause/resume controls around queue
reconfiguration and device lifecycle paths.

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
 drivers/net/intel/iavf/iavf.h        |  5 ++
 drivers/net/intel/iavf/iavf_ethdev.c | 70 ++++++++++++++++++++++++++++
 drivers/net/intel/iavf/iavf_vchnl.c  |  4 ++
 3 files changed, 79 insertions(+)

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 39949acc11..caba5b49cd 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -76,6 +76,7 @@
 #define IAVF_QUEUE_ITR_INTERVAL_MAX     8160 /* 8160 us */
 
 #define IAVF_ALARM_INTERVAL 50000 /* us */
+#define IAVF_PHC_SYNC_ALARM_INTERVAL_US 200000
 
 /* The overhead from MTU to max frame size.
  * Considering QinQ packet, the VLAN tag needs to be counted twice.
@@ -383,6 +384,8 @@ struct iavf_adapter {
 	enum iavf_rx_func_type rx_func_type;
 	enum iavf_tx_func_type tx_func_type;
 	uint16_t fdir_ref_cnt;
+	uint8_t phc_sync_ticks;
+	bool phc_sync_paused;
 	struct iavf_devargs devargs;
 };
 
@@ -518,6 +521,8 @@ void iavf_add_del_all_mac_addr(struct iavf_adapter *adapter, bool add);
 int iavf_dev_link_update(struct rte_eth_dev *dev,
 			__rte_unused int wait_to_complete);
 void iavf_dev_alarm_handler(void *param);
+void iavf_phc_sync_alarm_start(struct rte_eth_dev *dev);
+void iavf_phc_sync_alarm_stop(struct rte_eth_dev *dev);
 int iavf_query_stats(struct iavf_adapter *adapter,
 		    struct virtchnl_eth_stats **pstats);
 int iavf_config_promisc(struct iavf_adapter *adapter, bool enable_unicast,
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 802e095174..1cb78e2f36 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -21,6 +21,7 @@
 #include <rte_pci.h>
 #include <rte_alarm.h>
 #include <rte_atomic.h>
+#include <rte_cycles.h>
 #include <rte_eal.h>
 #include <rte_ether.h>
 #include <ethdev_driver.h>
@@ -145,6 +146,7 @@ static int iavf_dev_rx_queue_intr_disable(struct rte_eth_dev *dev,
 					 uint16_t queue_id);
 static void iavf_dev_interrupt_handler(void *param);
 static void iavf_disable_irq0(struct iavf_hw *hw);
+static bool iavf_phc_sync_alarm_needed(struct rte_eth_dev *dev);
 static int iavf_dev_flow_ops_get(struct rte_eth_dev *dev,
 				 const struct rte_flow_ops **ops);
 static int iavf_set_mc_addr_list(struct rte_eth_dev *dev,
@@ -1079,6 +1081,8 @@ iavf_dev_start(struct rte_eth_dev *dev)
 		goto error;
 	}
 
+	iavf_phc_sync_alarm_start(dev);
+
 	return 0;
 
 error:
@@ -1105,6 +1109,8 @@ iavf_dev_stop(struct rte_eth_dev *dev)
 	if (adapter->stopped == 1)
 		return 0;
 
+	iavf_phc_sync_alarm_stop(dev);
+
 	/* Disable the interrupt for Rx */
 	rte_intr_efd_disable(intr_handle);
 	/* Rx interrupt vector mapping free */
@@ -2723,9 +2729,11 @@ void
 iavf_dev_alarm_handler(void *param)
 {
 	struct rte_eth_dev *dev = (struct rte_eth_dev *)param;
+	struct iavf_adapter *adapter;
 	if (dev == NULL || dev->data == NULL || dev->data->dev_private == NULL)
 		return;
 
+	adapter = IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct iavf_hw *hw = IAVF_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	uint32_t icr0;
 
@@ -2741,10 +2749,70 @@ iavf_dev_alarm_handler(void *param)
 
 	iavf_enable_irq0(hw);
 
+	if (iavf_phc_sync_alarm_needed(dev) && !adapter->phc_sync_paused) {
+		adapter->phc_sync_ticks++;
+		if (adapter->phc_sync_ticks >=
+		    IAVF_PHC_SYNC_ALARM_INTERVAL_US / IAVF_ALARM_INTERVAL) {
+			struct ci_rx_queue *rxq = dev->data->rx_queues[0];
+
+			adapter->phc_sync_ticks = 0;
+			if (iavf_get_phc_time(rxq) == 0)
+				rxq->hw_time_update = rte_get_timer_cycles() /
+					(rte_get_timer_hz() / 1000);
+		}
+	} else {
+		adapter->phc_sync_ticks = 0;
+	}
+
 	rte_eal_alarm_set(IAVF_ALARM_INTERVAL,
 			  iavf_dev_alarm_handler, dev);
 }
 
+static bool
+iavf_phc_sync_alarm_needed(struct rte_eth_dev *dev)
+{
+	struct iavf_adapter *adapter;
+
+	adapter = IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
+
+	if (adapter->closed || adapter->stopped)
+		return false;
+
+	if (!(dev->data->dev_conf.rxmode.offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP))
+		return false;
+
+	if (dev->data->nb_rx_queues == 0 || dev->data->rx_queues[0] == NULL)
+		return false;
+
+	return true;
+}
+
+void
+iavf_phc_sync_alarm_start(struct rte_eth_dev *dev)
+{
+	struct iavf_adapter *adapter;
+
+	if (!iavf_phc_sync_alarm_needed(dev))
+		return;
+
+	adapter = IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
+	adapter->phc_sync_paused = false;
+	adapter->phc_sync_ticks = 0;
+}
+
+void
+iavf_phc_sync_alarm_stop(struct rte_eth_dev *dev)
+{
+	struct iavf_adapter *adapter;
+
+	if (dev == NULL || dev->data == NULL || dev->data->dev_private == NULL)
+		return;
+
+	adapter = IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
+	adapter->phc_sync_paused = true;
+	adapter->phc_sync_ticks = 0;
+}
+
 static int
 iavf_dev_flow_ops_get(struct rte_eth_dev *dev,
 		      const struct rte_flow_ops **ops)
@@ -2924,6 +2992,7 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
 	} else {
 		rte_eal_alarm_cancel(iavf_dev_alarm_handler, eth_dev);
 	}
+	iavf_phc_sync_alarm_stop(eth_dev);
 
 	rte_free(eth_dev->data->mac_addrs);
 	eth_dev->data->mac_addrs = NULL;
@@ -2995,6 +3064,7 @@ iavf_dev_close(struct rte_eth_dev *dev)
 	} else {
 		rte_eal_alarm_cancel(iavf_dev_alarm_handler, dev);
 	}
+	iavf_phc_sync_alarm_stop(dev);
 	iavf_disable_irq0(hw);
 
 	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_QOS)
diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 9ad39300c6..4bd51dcc21 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -2091,12 +2091,16 @@ iavf_request_queues(struct rte_eth_dev *dev, uint16_t num)
 	args.out_size = IAVF_AQ_BUF_SZ;
 
 	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_WB_ON_ITR) {
+		iavf_phc_sync_alarm_stop(dev);
 		err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+		iavf_phc_sync_alarm_start(dev);
 	} else {
 		rte_eal_alarm_cancel(iavf_dev_alarm_handler, dev);
+		iavf_phc_sync_alarm_stop(dev);
 		err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
 		rte_eal_alarm_set(IAVF_ALARM_INTERVAL,
 				  iavf_dev_alarm_handler, dev);
+		iavf_phc_sync_alarm_start(dev);
 	}
 
 	if (err) {
-- 
2.47.1

