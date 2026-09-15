Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164F4C88E75
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 16:40:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 263E040265;
	Tue, 15 Sep 2026 18:40:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 62C994003C
 for <dev@dpdk.org>; Tue, 15 Sep 2026 18:40:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789490419; x=1821026419;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Iviu3uZElrrJRKScXw8Zs02ubQ07GRuT+0xSpUqBhRE=;
 b=h5Jgvl3GCIXFHOlwEm3bL6oqjXrkERfNjDiKCXpDFOpZoaw1I0kNC+km
 aDwivM/NXLkHxtqw0ieErqwWwZwQFxWkzCxpG1pdtK5/+XeO/V4NMTny+
 jLgdI8J5XloainYO3qfIyxgzYFzjUnN1c1vSbA/PM7gOqsSd3LNEoV5ox
 M/bM/mCVZprrO//V4C5dO5cXFRRfQ6WuXSa8udU8R8n9rakB7c94B6CLc
 dtNfFPFk2wshjwAP82ALElWk+D+WBwwr5+xgqwZQeedYJRtQ+hIGsQqw0
 wZ5qvYZfKKzW1snPzq6JCZTmOudzd5uf7yAVrCKp3tyyFbO1uWXb5KnX/ Q==;
X-CSE-ConnectionGUID: Yz7caNBuTJCTW0nBaUFUqQ==
X-CSE-MsgGUID: WE1+/51xTEmGfYBRpTCTEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89800042"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89800042"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 09:40:17 -0700
X-CSE-ConnectionGUID: Ila3d+15REuJIwr+Ddq2Gw==
X-CSE-MsgGUID: +YlUbsyIQ0Ci9tG9veZ3Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1472731"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by fmviesa013.fm.intel.com with ESMTP; 15 Sep 2026 09:40:15 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 rajesh3.kumar@intel.com, Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH v4] net/iavf: add reading PHC time support
Date: Tue, 15 Sep 2026 16:42:31 +0000
Message-Id: <20260915164231.247037-1-anurag.mandal@intel.com>
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
V4: Addressed Rajesh Kumar's feedback
 - return the error unchanged
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
index e475b64971..cb0e8989e1 100644
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
+		return ret;
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

