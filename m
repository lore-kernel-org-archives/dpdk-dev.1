Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570C0606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 09:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FT1gzWff
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A676140693;
	Fri, 23 Oct 2026 11:32:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id C70984060C
 for <dev@dpdk.org>; Fri, 23 Oct 2026 11:32:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792747965; x=1824283965;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=5bKV88KflvzOlobF8t7uQSrtGxAslVMP9dCyKjrpB+s=;
 b=FT1gzWff9VKLJWrGCTN9LqWQpTq234y39tuP1znBor+du+yD/XnBpwDZ
 5xvXh/p98SvKW5KiR1E8NgF1lBlUYphFvd1G1ZgMF7PoC9bI+MxzyG/KH
 4+gZQ8bfhY+1CjmBe7LoCpofc1x/dK0gKPx8Z7JQDnAlMOU4asz4excab
 VYSiFvtjWAISCp75+NXw5Z81iAg25pxuyIA6Hk/5fDJhIaVPqnKioCyYn
 muH4we1Z2dTM7vj/X52UQS5k8TxjXXev2nCtXhGpwjuSJiOaXXQfRKnlz
 e7Q22VqR5tN+/bLMlPrD+9EceN7PHkvgYmHC/H3sHkaFWqhlxTfRoaW6G Q==;
X-CSE-ConnectionGUID: pgG8ecxZRzeSw1jVbwvLug==
X-CSE-MsgGUID: vk4WRvPdQL2JsiLQP03zmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1498271"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1498271"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 02:32:44 -0700
X-CSE-ConnectionGUID: 1TfE8SSiSRCzq/9F8nSadg==
X-CSE-MsgGUID: HO2Zko84TPWVb1FRxDBODg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3509468"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 23 Oct 2026 02:32:43 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Ting Xu <ting.xu@intel.com>, Beilei Xing <beilei.xing@intel.com>
Subject: [PATCH v5 04/10] net/iavf: fix memory leaks around IRQ resources
Date: Fri, 23 Oct 2026 10:32:24 +0100
Message-ID: <a97d124a185df54bb9e4b9def2866bb3086a4692.1792747917.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1792747916.git.anatoly.burakov@intel.com>
 <cover.1792747916.git.anatoly.burakov@intel.com>
References: 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

`iavf_config_rx_queues_irqs()` allocates a queue-vector map and may
enable eventfds and allocate an interrupt vector list. If queue startup
then fails, those resources remain allocated. The queue-vector map is
also retained after a normal stop, leaking it across start/stop cycles.

Release the resources on failed startup and free the queue-vector map
on stop.

Fixes: f593944fc988 ("net/iavf: enable IRQ mapping configuration for large VF")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index b5beaee8604..f428eb3becb 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -871,7 +871,7 @@ static int iavf_config_rx_queues_irqs(struct rte_eth_dev *dev,
 						    dev->data->nb_rx_queues)) {
 			PMD_DRV_LOG(ERR, "Failed to allocate %d rx intr_vec",
 				    dev->data->nb_rx_queues);
-			return -1;
+			goto qv_map_alloc_err;
 		}
 	}
 
@@ -981,6 +981,7 @@ static int iavf_config_rx_queues_irqs(struct rte_eth_dev *dev,
 
 qv_map_alloc_err:
 	rte_intr_vec_list_free(intr_handle);
+	rte_intr_efd_disable(intr_handle);
 
 	return -1;
 }
@@ -1034,12 +1035,15 @@ iavf_dev_start(struct rte_eth_dev *dev)
 	struct rte_intr_handle *intr_handle = dev->intr_handle;
 	uint16_t num_queue_pairs;
 	uint16_t index = 0;
+	bool wb_on_itr;
 
 	PMD_INIT_FUNC_TRACE();
 
 	if (adapter->closed)
 		return -1;
 
+	wb_on_itr = (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_WB_ON_ITR) != 0;
+
 	vf->max_pkt_len = dev->data->mtu + IAVF_ETH_OVERHEAD;
 	vf->num_queue_pairs = RTE_MAX(dev->data->nb_rx_queues,
 				      dev->data->nb_tx_queues);
@@ -1089,7 +1093,7 @@ iavf_dev_start(struct rte_eth_dev *dev)
 	}
 	/* re-enable intr again, because efd assign may change */
 	if (dev->data->dev_conf.intr_conf.rxq != 0) {
-		if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_WB_ON_ITR)
+		if (wb_on_itr)
 			rte_intr_disable(intr_handle);
 		rte_intr_enable(intr_handle);
 	}
@@ -1107,7 +1111,7 @@ iavf_dev_start(struct rte_eth_dev *dev)
 
 	if (iavf_start_queues(dev) != 0) {
 		PMD_DRV_LOG(ERR, "enable queues failed");
-		goto error;
+		goto irq_error;
 	}
 
 	iavf_phc_sync_alarm_start(dev);
@@ -1118,6 +1122,13 @@ iavf_dev_start(struct rte_eth_dev *dev)
 
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
@@ -1150,6 +1161,8 @@ iavf_dev_stop(struct rte_eth_dev *dev)
 	rte_intr_vec_list_free(intr_handle);
 
 	iavf_stop_queues(dev);
+	rte_free(vf->qv_map);
+	vf->qv_map = NULL;
 
 	adapter->stopped = 1;
 	dev->data->dev_started = 0;
-- 
2.52.0

