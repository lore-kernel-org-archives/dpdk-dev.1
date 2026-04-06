Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA58DEF4EC8
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Apr 2026 08:51:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5E0B40665;
	Mon,  6 Apr 2026 10:51:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 5D9384065F
 for <dev@dpdk.org>; Mon,  6 Apr 2026 10:51:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775465466; x=1807001466;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=ASKN6n/aEPg3qTHXD3Vr8y8iOSDq7o1Fsaxt9BNvxYc=;
 b=GfJAjVDzPIif+u+cb1Z5tN4wf9KvP0Gq/av2+WrYF9vp+2r9G50mBRxJ
 2uCM5KDn4/09//nohDvHhYWLr9QHNMmruSgdAFz41O+36ivS5V97wDYFt
 CI0gIkh4C9RCmEdhUoDFg3+x6Jp40z6kb/WFuafjbpteRuIuDXeStGsP3
 +SwbfPfXpD5EuQS4X8pUimvbbCKb24IDooSkdSa2xqZ/CEJsYHiWb3HOm
 72IjpGJ/b6AZ4l73BLzTsVxJZvLdSiGlnQhgEcdo3cu5fBxg3YKRBWGAD
 Ywoat9v+f4kpgjMEORb96VKf4aRiersYYsxLWhNZcvGQeoIEsotWpjha4 w==;
X-CSE-ConnectionGUID: uLSYsej6RVCbQ+4l8yGSTA==
X-CSE-MsgGUID: Q2gGxJlMSXmDAACgYgT70A==
X-IronPort-AV: E=McAfee;i="6800,10657,11750"; a="76133632"
X-IronPort-AV: E=Sophos;i="6.23,163,1770624000"; d="scan'208";a="76133632"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2026 01:51:06 -0700
X-CSE-ConnectionGUID: TuHpMIMQSNmt61ixnPM+ew==
X-CSE-MsgGUID: IU4NrgFpSGKQOIJIIewNCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,163,1770624000"; d="scan'208";a="227732504"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by orviesa009.jf.intel.com with ESMTP; 06 Apr 2026 01:51:03 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: bruce.richardson@intel.com, manoj.kumar.subbarao@intel.com,
 aman.deep.singh@intel.com, dev@dpdk.org, rajesh3.kumar@intel.com
Subject: [PATCH v3 2/2] net/iavf: reuse device alarm for PHC sync
Date: Mon,  6 Apr 2026 17:22:08 -0400
Message-ID: <20260406212208.1562899-3-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260406212208.1562899-1-soumyadeep.hore@intel.com>
References: <20260402154655.1540930-2-soumyadeep.hore@intel.com>
 <20260406212208.1562899-1-soumyadeep.hore@intel.com>
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
 drivers/net/intel/iavf/iavf.h        |   6 ++
 drivers/net/intel/iavf/iavf_ethdev.c | 128 +++++++++++++++++++++++++++
 drivers/net/intel/iavf/iavf_vchnl.c  |   4 +
 3 files changed, 138 insertions(+)

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 403c61e2e8..e30fd710f0 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -76,6 +76,7 @@
 #define IAVF_QUEUE_ITR_INTERVAL_MAX     8160 /* 8160 us */
 
 #define IAVF_ALARM_INTERVAL 50000 /* us */
+#define IAVF_PHC_SYNC_ALARM_INTERVAL_US 200000
 
 /* The overhead from MTU to max frame size.
  * Considering QinQ packet, the VLAN tag needs to be counted twice.
@@ -383,6 +384,9 @@ struct iavf_adapter {
 	enum iavf_rx_func_type rx_func_type;
 	enum iavf_tx_func_type tx_func_type;
 	uint16_t fdir_ref_cnt;
+	rte_spinlock_t phc_sync_lock;
+	uint16_t phc_sync_ticks;
+	bool phc_sync_paused;
 	struct iavf_devargs devargs;
 	bool mac_primary_set;
 };
@@ -517,6 +521,8 @@ void iavf_add_del_all_mac_addr(struct iavf_adapter *adapter, bool add);
 int iavf_dev_link_update(struct rte_eth_dev *dev,
 			__rte_unused int wait_to_complete);
 void iavf_dev_alarm_handler(void *param);
+void iavf_phc_sync_alarm_start(struct rte_eth_dev *dev);
+void iavf_phc_sync_alarm_stop(struct rte_eth_dev *dev);
 int iavf_query_stats(struct iavf_adapter *adapter,
 		    struct virtchnl_eth_stats **pstats);
 int iavf_config_promisc(struct iavf_adapter *adapter, bool enable_unicast,
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 1eca20bc9a..9c9a5a6b47 100644
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
@@ -145,6 +146,11 @@ static int iavf_dev_rx_queue_intr_disable(struct rte_eth_dev *dev,
 					 uint16_t queue_id);
 static void iavf_dev_interrupt_handler(void *param);
 static void iavf_disable_irq0(struct iavf_hw *hw);
+static struct ci_rx_queue *iavf_phc_sync_rxq_get(struct rte_eth_dev *dev);
+static void iavf_phc_sync_update_all_rxq(struct rte_eth_dev *dev,
+					 uint64_t phc_time,
+					 uint64_t sw_cur_time);
+static bool iavf_phc_sync_alarm_needed(struct rte_eth_dev *dev);
 static int iavf_dev_flow_ops_get(struct rte_eth_dev *dev,
 				 const struct rte_flow_ops **ops);
 static int iavf_set_mc_addr_list(struct rte_eth_dev *dev,
@@ -1056,6 +1062,8 @@ iavf_dev_start(struct rte_eth_dev *dev)
 		goto error;
 	}
 
+	iavf_phc_sync_alarm_start(dev);
+
 	return 0;
 
 error:
@@ -1082,6 +1090,8 @@ iavf_dev_stop(struct rte_eth_dev *dev)
 	if (adapter->stopped == 1)
 		return 0;
 
+	iavf_phc_sync_alarm_stop(dev);
+
 	/* Disable the interrupt for Rx */
 	rte_intr_efd_disable(intr_handle);
 	/* Rx interrupt vector mapping free */
@@ -2705,9 +2715,13 @@ void
 iavf_dev_alarm_handler(void *param)
 {
 	struct rte_eth_dev *dev = (struct rte_eth_dev *)param;
+	struct iavf_adapter *adapter;
+	const uint16_t phc_sync_ticks_max = RTE_MAX((uint16_t)1,
+		(uint16_t)(IAVF_PHC_SYNC_ALARM_INTERVAL_US / IAVF_ALARM_INTERVAL));
 	if (dev == NULL || dev->data == NULL || dev->data->dev_private == NULL)
 		return;
 
+	adapter = IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct iavf_hw *hw = IAVF_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	uint32_t icr0;
 
@@ -2723,10 +2737,121 @@ iavf_dev_alarm_handler(void *param)
 
 	iavf_enable_irq0(hw);
 
+	rte_spinlock_lock(&adapter->phc_sync_lock);
+	if (!adapter->phc_sync_paused &&
+	    iavf_phc_sync_alarm_needed(dev)) {
+		uint16_t phc_sync_ticks =
+			++adapter->phc_sync_ticks;
+
+		if (phc_sync_ticks >= phc_sync_ticks_max) {
+			struct ci_rx_queue *sync_rxq;
+			uint64_t sw_cur_time;
+
+			adapter->phc_sync_ticks = 0;
+			sync_rxq = iavf_phc_sync_rxq_get(dev);
+			if (sync_rxq != NULL && iavf_get_phc_time(sync_rxq) == 0) {
+				sw_cur_time = rte_get_timer_cycles() /
+					(rte_get_timer_hz() / 1000);
+				iavf_phc_sync_update_all_rxq(dev,
+					sync_rxq->phc_time, sw_cur_time);
+			} else if (sync_rxq != NULL) {
+				PMD_DRV_LOG(ERR, "get physical time failed");
+			}
+		}
+	} else {
+		adapter->phc_sync_ticks = 0;
+	}
+	rte_spinlock_unlock(&adapter->phc_sync_lock);
+
 	rte_eal_alarm_set(IAVF_ALARM_INTERVAL,
 			  iavf_dev_alarm_handler, dev);
 }
 
+static struct ci_rx_queue *
+iavf_phc_sync_rxq_get(struct rte_eth_dev *dev)
+{
+	struct ci_rx_queue *rxq;
+	uint16_t i;
+
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		rxq = dev->data->rx_queues[i];
+		if (rxq != NULL)
+			return rxq;
+	}
+
+	return NULL;
+}
+
+static void
+iavf_phc_sync_update_all_rxq(struct rte_eth_dev *dev,
+				     uint64_t phc_time,
+				     uint64_t sw_cur_time)
+{
+	struct ci_rx_queue *rxq;
+	uint16_t i;
+
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		rxq = dev->data->rx_queues[i];
+		if (rxq == NULL)
+			continue;
+
+		rxq->phc_time = phc_time;
+		rxq->hw_time_update = sw_cur_time;
+	}
+}
+
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
+	if (dev->data->nb_rx_queues == 0)
+		return false;
+
+	if (iavf_phc_sync_rxq_get(dev) == NULL)
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
+	rte_spinlock_lock(&adapter->phc_sync_lock);
+	adapter->phc_sync_paused = false;
+	adapter->phc_sync_ticks = 0;
+	rte_spinlock_unlock(&adapter->phc_sync_lock);
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
+	rte_spinlock_lock(&adapter->phc_sync_lock);
+	adapter->phc_sync_paused = true;
+	adapter->phc_sync_ticks = 0;
+	rte_spinlock_unlock(&adapter->phc_sync_lock);
+}
+
 static int
 iavf_dev_flow_ops_get(struct rte_eth_dev *dev,
 		      const struct rte_flow_ops **ops)
@@ -2808,6 +2933,7 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
 	adapter->dev_data = eth_dev->data;
 	adapter->stopped = 1;
 	adapter->mac_primary_set = false;
+	rte_spinlock_init(&adapter->phc_sync_lock);
 
 	if (iavf_dev_event_handler_init())
 		goto init_vf_err;
@@ -2912,6 +3038,7 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
 	} else {
 		rte_eal_alarm_cancel(iavf_dev_alarm_handler, eth_dev);
 	}
+	iavf_phc_sync_alarm_stop(eth_dev);
 
 	rte_free(eth_dev->data->mac_addrs);
 	eth_dev->data->mac_addrs = NULL;
@@ -2986,6 +3113,7 @@ iavf_dev_close(struct rte_eth_dev *dev)
 	} else {
 		rte_eal_alarm_cancel(iavf_dev_alarm_handler, dev);
 	}
+	iavf_phc_sync_alarm_stop(dev);
 	iavf_disable_irq0(hw);
 
 	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_QOS)
diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 08dd6f2d7f..79ef4cec56 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -2133,12 +2133,16 @@ iavf_request_queues(struct rte_eth_dev *dev, uint16_t num)
 	args.out_size = IAVF_AQ_BUF_SZ;
 
 	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_WB_ON_ITR) {
+		iavf_phc_sync_alarm_stop(dev);
 		err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
+		iavf_phc_sync_alarm_start(dev);
 	} else {
+		iavf_phc_sync_alarm_stop(dev);
 		rte_eal_alarm_cancel(iavf_dev_alarm_handler, dev);
 		err = iavf_execute_vf_cmd_safe(adapter, &args, 0);
 		rte_eal_alarm_set(IAVF_ALARM_INTERVAL,
 				  iavf_dev_alarm_handler, dev);
+		iavf_phc_sync_alarm_start(dev);
 	}
 
 	if (err) {
-- 
2.47.1

