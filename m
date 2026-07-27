Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE8DC531D0
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Jul 2026 10:25:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95B9540279;
	Mon, 27 Jul 2026 12:25:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 6C1D7400D6
 for <dev@dpdk.org>; Mon, 27 Jul 2026 12:25:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785147937; x=1816683937;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=hQazpuIM+aX4qf1G2QRhRaebnNXxR1WsPKKg5XZ5S04=;
 b=NdaEixuwpIwAaL8q9Rnm0V2Oyq42PrUDpB345xsTES0tN2ckdxojQdvR
 3tedn2i+WczkQ5BM6ekDSgwveN/NZ4WarMVmf/M+P9IlBb0pSsrE/Cf16
 yBfJ2Q/zDNAiWwuj5o2kWqRJ6nuBvoWu5+Lxcg1Gl9e8rc+Oz6ynfbtdu
 VFE6AMvSYa7iDLHd6sB3pcty0IVezj+Gq3Un1iTts82JeWxeloj1tv07h
 rnTo731xwnv8nVjwTigvVM7wTuWB/Rf3e37EJJ82Aa9AzTNdVbzV36e+0
 OEZpKP+219x2rlIopSrbRUP9VUGWg2760V9MjcLGFhndzjgVi+GW70Fun g==;
X-CSE-ConnectionGUID: o41zw8exQy2BwuOp8KABaA==
X-CSE-MsgGUID: nTOW23Q3SFihKYIJar5CqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="96069314"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; d="scan'208";a="96069314"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2026 03:25:19 -0700
X-CSE-ConnectionGUID: hw80r9WhQP6xejNzaRhNyg==
X-CSE-MsgGUID: daVwLMeuSuqHnWyZzxD4SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; d="scan'208";a="259441750"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by orviesa007.jf.intel.com with ESMTP; 27 Jul 2026 03:25:16 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH] net/iavf: add clock read support
Date: Mon, 27 Jul 2026 10:24:44 +0000
Message-Id: <20260727102444.789833-1-anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
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

Implemented read_clock ethdev operation by adding
iavf_dev_read_clock() feature to get current time
in nanoseconds for scheduling packets based on
transmit time.

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/iavf/iavf.h        |  3 ++-
 drivers/net/intel/iavf/iavf_ethdev.c | 24 ++++++++++++++++++++++++
 drivers/net/intel/iavf/iavf_vchnl.c  | 13 ++++++++++---
 3 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 293adaf6c9..cf2b6596d5 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -533,4 +533,5 @@ void iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset);
 void iavf_set_no_poll(struct iavf_adapter *adapter, bool link_change);
 bool is_iavf_supported(struct rte_eth_dev *dev);
 void iavf_hash_uninit(struct iavf_adapter *ad);
-#endif /* _IAVF_ETHDEV_H_ */
+int iavf_phc_get_time(struct iavf_adapter *adapter, uint64_t *time);
+#endif /* _IAVF_ETHDEV_H_ u*/
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index e475b64971..1a36885107 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -165,6 +165,7 @@ static int iavf_set_mc_addr_list(struct rte_eth_dev *dev,
 			struct rte_ether_addr *mc_addrs,
 			uint32_t mc_addrs_num);
 static int iavf_tm_ops_get(struct rte_eth_dev *dev __rte_unused, void *arg);
+static int iavf_dev_read_clock(struct rte_eth_dev *dev, uint64_t *clock);
 
 static const struct rte_pci_id pci_id_iavf_map[] = {
 	{ RTE_PCI_DEVICE(IAVF_INTEL_VENDOR_ID, IAVF_DEV_ID_ADAPTIVE_VF) },
@@ -264,6 +265,7 @@ static const struct eth_dev_ops iavf_eth_dev_ops = {
 	.tx_done_cleanup	    = iavf_dev_tx_done_cleanup,
 	.get_monitor_addr           = iavf_get_monitor_addr,
 	.tm_ops_get                 = iavf_tm_ops_get,
+	.read_clock                 = iavf_dev_read_clock,
 };
 
 static int
@@ -3662,6 +3664,28 @@ bool is_iavf_supported(struct rte_eth_dev *dev)
 	return !strcmp(dev->device->driver->name, rte_iavf_pmd.driver.name);
 }
 
+static int
+iavf_dev_read_clock(struct rte_eth_dev *dev, uint64_t *clock)
+{
+	struct iavf_adapter *adapter =
+		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
+	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
+	int ret;
+
+	if (adapter->closed)
+		return -EIO;
+
+	if (!(vf->vf_res->vf_cap_flags & VIRTCHNL_VF_CAP_PTP) ||
+	    !(vf->ptp_caps & VIRTCHNL_1588_PTP_CAP_READ_PHC))
+		return -ENOTSUP;
+
+	ret = iavf_phc_get_time(adapter, clock);
+	if (ret != 0)
+		return -EIO;
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

