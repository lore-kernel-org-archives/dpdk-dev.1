Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12223C61DFD
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Sep 2026 05:51:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D154D4042E;
	Wed,  2 Sep 2026 07:51:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 27CF3402F0
 for <dev@dpdk.org>; Wed,  2 Sep 2026 07:51:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788328290; x=1819864290;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2pfgSea3VuGDblgdYE5GISFsNVkDqMkT2OqAR8jw96Y=;
 b=gvGolQy9lDMZj7ZZTqilBOiu/F26EkSyUUMtQE0hAAOIF7GpgCYIqhPS
 RIVfSmoVXWhy2RbvsaJYCa5sDg7r+Q+alBH0ri/N+6VT0RY6mGMTGftbM
 YG0BE8/KMKLG48vyflHB4p29t7jvd0WdTzLvgCVH74Vs5Abrx1xEMI+bE
 E6uEF6hSiaF73O4WsjCN9RHRY+E66Ev17kl2Pv+gPzGOBtqMG2c9W2JM/
 gqdETmvTTNW58iOPd/rBEgB9OXc0Jbk4mSwakDC89nyMPucvx1nkH7h5d
 Jo09iXW7Q/9S+6DP4fBlRbycFvmwLdWyeBMS2EaJY9a/B6K3BIFv77PRM w==;
X-CSE-ConnectionGUID: 8tqmrBr3RiaupeZ8W0jhRQ==
X-CSE-MsgGUID: w9QkdhJJQR+mXS9Nj5Jacg==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="88701732"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="88701732"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 22:51:28 -0700
X-CSE-ConnectionGUID: Fz4DbLm0Rtm9KV1XLGG7BA==
X-CSE-MsgGUID: +sT/qkBzQ1O9MkHB0xtBfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="269880097"
Received: from unknown (HELO pae-14.iind.intel.com) ([10.190.203.153])
 by orviesa009.jf.intel.com with ESMTP; 01 Sep 2026 22:51:26 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH v3] net/iavf: add PTP clock read support
Date: Wed,  2 Sep 2026 05:54:01 +0000
Message-Id: <20260902055401.36342-1-anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260727102444.789833-1-anurag.mandal@intel.com>
References: <20260727102444.789833-1-anurag.mandal@intel.com>
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

Added iavf support for the
timesync_read_time ethdev API to read
the device PTP Hardware Clock (PHC).
A VF has no direct access to the PHC,
so the time is fetched from the PF
over virtchnl, and the API is only
advertised when the PF grants the
PTP read capability.

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
V3: Changed read_clock to timesync_read_time
V2: Addressed minor typo

 drivers/net/intel/iavf/iavf.h        |  1 +
 drivers/net/intel/iavf/iavf_ethdev.c | 28 ++++++++++++++++++++++++++++
 drivers/net/intel/iavf/iavf_vchnl.c  | 13 ++++++++++---
 3 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 293adaf6c9..416625d9fb 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -533,4 +533,5 @@ void iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset);
 void iavf_set_no_poll(struct iavf_adapter *adapter, bool link_change);
 bool is_iavf_supported(struct rte_eth_dev *dev);
 void iavf_hash_uninit(struct iavf_adapter *ad);
+int iavf_phc_get_time(struct iavf_adapter *adapter, uint64_t *time);
 #endif /* _IAVF_ETHDEV_H_ */
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index e475b64971..b855be5cfc 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -24,6 +24,7 @@
 #include <rte_cycles.h>
 #include <rte_eal.h>
 #include <rte_ether.h>
+#include <rte_time.h>
 #include <ethdev_driver.h>
 #include <ethdev_pci.h>
 #include <rte_malloc.h>
@@ -165,6 +166,7 @@ static int iavf_set_mc_addr_list(struct rte_eth_dev *dev,
 			struct rte_ether_addr *mc_addrs,
 			uint32_t mc_addrs_num);
 static int iavf_tm_ops_get(struct rte_eth_dev *dev __rte_unused, void *arg);
+static int iavf_timesync_read_time(struct rte_eth_dev *dev, struct timespec *timestamp);
 
 static const struct rte_pci_id pci_id_iavf_map[] = {
 	{ RTE_PCI_DEVICE(IAVF_INTEL_VENDOR_ID, IAVF_DEV_ID_ADAPTIVE_VF) },
@@ -264,6 +266,7 @@ static const struct eth_dev_ops iavf_eth_dev_ops = {
 	.tx_done_cleanup	    = iavf_dev_tx_done_cleanup,
 	.get_monitor_addr           = iavf_get_monitor_addr,
 	.tm_ops_get                 = iavf_tm_ops_get,
+	.timesync_read_time         = iavf_timesync_read_time,
 };
 
 static int
@@ -3662,6 +3665,31 @@ bool is_iavf_supported(struct rte_eth_dev *dev)
 	return !strcmp(dev->device->driver->name, rte_iavf_pmd.driver.name);
 }
 
+static int
+iavf_timesync_read_time(struct rte_eth_dev *dev, struct timespec *timestamp)
+{
+	struct iavf_adapter *adapter =
+		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
+	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
+	uint64_t time;
+	int ret;
+
+	if (adapter->closed)
+		return -EIO;
+
+	if (!(vf->vf_res->vf_cap_flags & VIRTCHNL_VF_CAP_PTP) ||
+	    !(vf->ptp_caps & VIRTCHNL_1588_PTP_CAP_READ_PHC))
+		return -ENOTSUP;
+
+	ret = iavf_phc_get_time(adapter, &time);
+	if (ret != 0)
+		return -EIO;
+
+	*timestamp = rte_ns_to_timespec(time);
+
+	return 0;
+}
+
 RTE_PMD_REGISTER_PCI(net_iavf, rte_iavf_pmd);
 RTE_PMD_REGISTER_PCI_TABLE(net_iavf, pci_id_iavf_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_iavf, "* igb_uio | vfio-pci");
diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index f346837bf1..a63639549c 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -2521,9 +2521,8 @@ iavf_get_ptp_cap(struct iavf_adapter *adapter)
 }
 
 int
-iavf_get_phc_time(struct ci_rx_queue *rxq)
+iavf_phc_get_time(struct iavf_adapter *adapter, uint64_t *time)
 {
-	struct iavf_adapter *adapter = rxq->iavf_vsi->adapter;
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
 	struct virtchnl_phc_time phc_time;
@@ -2543,9 +2542,17 @@ iavf_get_phc_time(struct ci_rx_queue *rxq)
 			    "Failed to execute command of VIRTCHNL_OP_1588_PTP_GET_TIME");
 		goto out;
 	}
-	rxq->phc_time = ((struct virtchnl_phc_time *)args.out_buffer)->time;
+	*time = ((struct virtchnl_phc_time *)args.out_buffer)->time;
 
 out:
 	rte_spinlock_unlock(&vf->phc_time_aq_lock);
 	return err;
 }
+
+int
+iavf_get_phc_time(struct ci_rx_queue *rxq)
+{
+	struct iavf_adapter *adapter = rxq->iavf_vsi->adapter;
+
+	return iavf_phc_get_time(adapter, &rxq->phc_time);
+}
-- 
2.34.1

