Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47C1CC6B34
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 08:34:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0957B40291;
	Thu, 15 Oct 2026 10:34:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id ECF0B40041
 for <dev@dpdk.org>; Thu, 15 Oct 2026 10:34:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792053248; x=1823589248;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=IpnmH50ShJG4KU8Bj5Ghunb6jzqsTZ8Pu1niK2Hqu8c=;
 b=hoq1RfyTgz8vGXFRSBS9J6BsMB3W/l1E2gGgJ5zSuwkmIsX6pQEaI1BA
 nlMpMBfxAgBTH0WiMktHTNyZGxR8fZxXVopCbZ3+gbGBZovNBIk0Nwukj
 6t/+mzvVUFLqhd8WzUedWBCKcyA7cyBXjt0t20nKqaHwAs9rGjI9xp479
 3WyCkPF8N9qlFNup2Tp8fTEfHvaFVKROVdWc9MJ7sGxHTiNuQV1tYpS0z
 B8tID4eH4oRas1zgc9laYlKnwQDyLJKo2InyNf2X5nl95dSRP38zGcYJi
 Mn0StX1FtmS2M+jds9dOB1knj/BPGd0LtsVIiFFk69uNCtgGmYIwJ3Suv A==;
X-CSE-ConnectionGUID: WpACxlCJSBukkKDY5pcMdg==
X-CSE-MsgGUID: L28ijcYcT0qe1PLgoEoJVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="697496"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="697496"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 01:34:07 -0700
X-CSE-ConnectionGUID: 1GLpwzU9Rv+2Mcx/ZvBh/g==
X-CSE-MsgGUID: 3YH3U5w8TLuIk5y68Ei3sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="1972786"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa008.fm.intel.com with ESMTP; 15 Oct 2026 01:34:06 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Beilei Xing <beilei.xing@intel.com>, Ting Xu <ting.xu@intel.com>
Subject: [PATCH v1 1/2] net/iavf: fix memory leaks around IRQ resources
Date: Thu, 15 Oct 2026 09:34:03 +0100
Message-ID: <809e0c5b2ab57f1b14c68be8ac34e70cbbe82233.1792053236.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
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

`iavf_config_rx_queues_irqs()` allocates a queue-vector map and may
enable eventfds and allocate an interrupt vector list. If queue startup
then fails, those resources remain allocated. The queue-vector map is
also retained after a normal stop, leaking it across start/stop cycles.

Release the resources on failed startup and free the queue-vector map
on stop. Clean up eventfds when interrupt setup fails as well.

Fixes: f593944fc988 ("net/iavf: enable IRQ mapping configuration for large VF")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 6cf12ec34f..c0c58af746 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -862,7 +862,7 @@ static int iavf_config_rx_queues_irqs(struct rte_eth_dev *dev,
 	if (rte_intr_cap_multiple(intr_handle) &&
 	    dev->data->dev_conf.intr_conf.rxq) {
 		if (rte_intr_efd_enable(intr_handle, dev->data->nb_rx_queues))
-			return -1;
+			goto efd_alloc_err;
 	}
 
 	if (rte_intr_dp_is_en(intr_handle)) {
@@ -870,7 +870,7 @@ static int iavf_config_rx_queues_irqs(struct rte_eth_dev *dev,
 						    dev->data->nb_rx_queues)) {
 			PMD_DRV_LOG(ERR, "Failed to allocate %d rx intr_vec",
 				    dev->data->nb_rx_queues);
-			return -1;
+			goto qv_map_alloc_err;
 		}
 	}
 
@@ -984,6 +984,8 @@ static int iavf_config_rx_queues_irqs(struct rte_eth_dev *dev,
 
 qv_map_alloc_err:
 	rte_intr_vec_list_free(intr_handle);
+efd_alloc_err:
+	rte_intr_efd_disable(intr_handle);
 
 	return -1;
 }
@@ -1037,12 +1039,14 @@ iavf_dev_start(struct rte_eth_dev *dev)
 	struct rte_intr_handle *intr_handle = dev->intr_handle;
 	uint16_t num_queue_pairs;
 	uint16_t index = 0;
+	bool wb_on_itr;
 
 	PMD_INIT_FUNC_TRACE();
 
 	if (adapter->closed)
 		return -1;
 
+	wb_on_itr = (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_WB_ON_ITR) != 0;
 	adapter->stopped = 0;
 
 	vf->max_pkt_len = dev->data->mtu + IAVF_ETH_OVERHEAD;
@@ -1094,7 +1098,7 @@ iavf_dev_start(struct rte_eth_dev *dev)
 	}
 	/* re-enable intr again, because efd assign may change */
 	if (dev->data->dev_conf.intr_conf.rxq != 0) {
-		if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_WB_ON_ITR)
+		if (wb_on_itr)
 			rte_intr_disable(intr_handle);
 		rte_intr_enable(intr_handle);
 	}
@@ -1112,7 +1116,7 @@ iavf_dev_start(struct rte_eth_dev *dev)
 
 	if (iavf_start_queues(dev) != 0) {
 		PMD_DRV_LOG(ERR, "enable queues failed");
-		goto error;
+		goto irq_error;
 	}
 
 	iavf_phc_sync_alarm_start(dev);
@@ -1122,6 +1126,13 @@ iavf_dev_start(struct rte_eth_dev *dev)
 
 	return 0;
 
+irq_error:
+	if (!wb_on_itr && dev->data->dev_conf.intr_conf.rxq != 0)
+		rte_intr_disable(intr_handle);
+	rte_intr_efd_disable(intr_handle);
+	rte_intr_vec_list_free(intr_handle);
+	rte_free(vf->qv_map);
+	vf->qv_map = NULL;
 error:
 	return -1;
 }
@@ -1154,6 +1165,8 @@ iavf_dev_stop(struct rte_eth_dev *dev)
 	rte_intr_vec_list_free(intr_handle);
 
 	iavf_stop_queues(dev);
+	rte_free(vf->qv_map);
+	vf->qv_map = NULL;
 
 	adapter->stopped = 1;
 	dev->data->dev_started = 0;
-- 
2.52.0

