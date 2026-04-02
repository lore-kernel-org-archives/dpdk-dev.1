Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F72C111227A
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Apr 2026 03:15:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A738940DDA;
	Thu,  2 Apr 2026 05:15:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 6DE4840DFD
 for <dev@dpdk.org>; Thu,  2 Apr 2026 05:15:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775099716; x=1806635716;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=XCEnx9VG98p5s3c8PG6jeTtEJ3rwvbdBYbQca0mwiew=;
 b=AXkHAK0hcECqFEPrJrdg6EwT1YQukvfC2kbyBcs1/TvynEMwgh9cABXz
 mUmVi1kiKjBzJ2QOiC++Vdom4nKuMb+b5yuBYMSusYPSZzFvjzfRr6v5R
 ZmOrWi9V+cxXedK2mFB2uRoOygtLibWbSc4skWRJj4g9sKTGa5bnfXRg0
 +ohHgmpj0Y+clIR/T2+ILsPmq1VZALGwm9N3FHk9hvnKPmV2rdgAkCJIY
 77nvm71cKNLNuwv6iLkKSOfmbBjQfPA/ZeVNVIukqsI/hrr45jaZXvTOU
 NMKNCYOaG8uxsUUM7dbdhc35N4AeZcl3A6vislq80VJjFwaiC8CRMt089 w==;
X-CSE-ConnectionGUID: dWNtRwbHSA2QcWTnLiLIig==
X-CSE-MsgGUID: 1XPu3jipR66y5Ia5MvZWiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="93732808"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; d="scan'208";a="93732808"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2026 20:15:15 -0700
X-CSE-ConnectionGUID: 0dWXP7AVTEiXwieQ8zL+0Q==
X-CSE-MsgGUID: AH8nrb8tR8yNq75Rsow/Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; d="scan'208";a="225846939"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by orviesa006.jf.intel.com with ESMTP; 01 Apr 2026 20:15:12 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: bruce.richardson@intel.com, manoj.kumar.subbarao@intel.com,
 aman.deep.singh@intel.com, dev@dpdk.org, rajesh3.kumar@intel.com
Subject: [PATCH v2 2/2] net/iavf: reuse device alarm for PHC sync
Date: Thu,  2 Apr 2026 11:46:55 -0400
Message-ID: <20260402154655.1540930-3-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260402154655.1540930-1-soumyadeep.hore@intel.com>
References: <20260402152137.1527322-2-soumyadeep.hore@intel.com>
 <20260402154655.1540930-1-soumyadeep.hore@intel.com>
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
index 403c61e2e8..2f1779d47b 100644
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
 	bool mac_primary_set;
 };
@@ -517,6 +520,8 @@ void iavf_add_del_all_mac_addr(struct iavf_adapter *adapter, bool add);
 int iavf_dev_link_update(struct rte_eth_dev *dev,
 			__rte_unused int wait_to_complete);
 void iavf_dev_alarm_handler(void *param);
+void iavf_phc_sync_alarm_start(struct rte_eth_dev *dev);
+void iavf_phc_sync_alarm_stop(struct rte_eth_dev *dev);
 int iavf_query_stats(struct iavf_adapter *adapter,
 		    struct virtchnl_eth_stats **pstats);
 int iavf_config_promisc(struct iavf_adapter *adapter, bool enable_unicast,
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 1eca20bc9a..02272d45c1 100644
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
@@ -1056,6 +1058,8 @@ iavf_dev_start(struct rte_eth_dev *dev)
 		goto error;
 	}
 
+	iavf_phc_sync_alarm_start(dev);
+
 	return 0;
 
 error:
@@ -1082,6 +1086,8 @@ iavf_dev_stop(struct rte_eth_dev *dev)
 	if (adapter->stopped == 1)
 		return 0;
 
+	iavf_phc_sync_alarm_stop(dev);
+
 	/* Disable the interrupt for Rx */
 	rte_intr_efd_disable(intr_handle);
 	/* Rx interrupt vector mapping free */
@@ -2705,9 +2711,11 @@ void
 iavf_dev_alarm_handler(void *param)
 {
 	struct rte_eth_dev *dev = (struct rte_eth_dev *)param;
+	struct iavf_adapter *adapter;
 	if (dev == NULL || dev->data == NULL || dev->data->dev_private == NULL)
 		return;
 
+	adapter = IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct iavf_hw *hw = IAVF_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	uint32_t icr0;
 
@@ -2723,10 +2731,70 @@ iavf_dev_alarm_handler(void *param)
 
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
@@ -2912,6 +2980,7 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
 	} else {
 		rte_eal_alarm_cancel(iavf_dev_alarm_handler, eth_dev);
 	}
+	iavf_phc_sync_alarm_stop(eth_dev);
 
 	rte_free(eth_dev->data->mac_addrs);
 	eth_dev->data->mac_addrs = NULL;
@@ -2986,6 +3055,7 @@ iavf_dev_close(struct rte_eth_dev *dev)
 	} else {
 		rte_eal_alarm_cancel(iavf_dev_alarm_handler, dev);
 	}
+	iavf_phc_sync_alarm_stop(dev);
 	iavf_disable_irq0(hw);
 
 	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_QOS)
diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 08dd6f2d7f..82943472e1 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -2133,12 +2133,16 @@ iavf_request_queues(struct rte_eth_dev *dev, uint16_t num)
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

