Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08106079D5B
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 15:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Q+VOgLou
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E167940A67;
	Mon, 19 Oct 2026 17:06:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 9162440647
 for <dev@dpdk.org>; Mon, 19 Oct 2026 17:06:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792422400; x=1823958400;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=A6UoKAKxkMTI1HIKzL+l76dYvrWSc+p+9HTSXddSK98=;
 b=Q+VOgLouFUtr1dq09uwvk+I69naLLLylxBzXLnJV8stdwFwwYpSw9ibY
 Q1w1oF5LWTpwnkvhPZmnGydoWj6Ml2n1NkASwSs4lpUT0jjRXEP/OeCH1
 NZrjWULVWXdkU+svd/6R8P0uySiMFdyTPwfx3D1MXlI2rN6GVu91rizRf
 gdJN6p6Ne1hOiBQZ8G6eWaC3IHLE+Nb3xqT515LiAkD8s/IiX8kVy2L2Y
 9DGr9ScEhgABtl6y+gDBJr7/5xUTFlgBbv6kJOo6IqFYPa1hGudwdTXZQ
 6MUHyVUykm87BFWL+0F+cdnYWkSsuruM1hCcQDKoxHubJDZDEE4BD2Xok Q==;
X-CSE-ConnectionGUID: Sxt/EkiLQ6SS5Tzme3UHuA==
X-CSE-MsgGUID: BZacXOCySiOduIEivQdSXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1132172"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1132172"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 08:06:40 -0700
X-CSE-ConnectionGUID: 5dIQOmR+T5+Xtw1ERG7ZYw==
X-CSE-MsgGUID: ZOAE9/KlS8qw5HJselIv6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="4319743"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa012.fm.intel.com with ESMTP; 19 Oct 2026 08:06:38 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Ting Xu <ting.xu@intel.com>, Beilei Xing <beilei.xing@intel.com>
Subject: [PATCH v2 5/9] net/iavf: fix memory leaks around IRQ resources
Date: Mon, 19 Oct 2026 16:06:24 +0100
Message-ID: <ee794412ffe2b5fbb51fcf5a8b25eb74a3203d3a.1792422213.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1792422213.git.anatoly.burakov@intel.com>
 <cover.1792422213.git.anatoly.burakov@intel.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
 drivers/net/intel/iavf/iavf_ethdev.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index befee1d3eb..bb97a89414 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -863,7 +863,7 @@ static int iavf_config_rx_queues_irqs(struct rte_eth_dev *dev,
 	if (rte_intr_cap_multiple(intr_handle) &&
 	    dev->data->dev_conf.intr_conf.rxq) {
 		if (rte_intr_efd_enable(intr_handle, dev->data->nb_rx_queues))
-			return -1;
+			goto efd_alloc_err;
 	}
 
 	if (rte_intr_dp_is_en(intr_handle)) {
@@ -871,7 +871,7 @@ static int iavf_config_rx_queues_irqs(struct rte_eth_dev *dev,
 						    dev->data->nb_rx_queues)) {
 			PMD_DRV_LOG(ERR, "Failed to allocate %d rx intr_vec",
 				    dev->data->nb_rx_queues);
-			return -1;
+			goto qv_map_alloc_err;
 		}
 	}
 
@@ -981,6 +981,8 @@ static int iavf_config_rx_queues_irqs(struct rte_eth_dev *dev,
 
 qv_map_alloc_err:
 	rte_intr_vec_list_free(intr_handle);
+efd_alloc_err:
+	rte_intr_efd_disable(intr_handle);
 
 	return -1;
 }
@@ -1034,12 +1036,15 @@ iavf_dev_start(struct rte_eth_dev *dev)
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
@@ -1089,7 +1094,7 @@ iavf_dev_start(struct rte_eth_dev *dev)
 	}
 	/* re-enable intr again, because efd assign may change */
 	if (dev->data->dev_conf.intr_conf.rxq != 0) {
-		if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_WB_ON_ITR)
+		if (wb_on_itr)
 			rte_intr_disable(intr_handle);
 		rte_intr_enable(intr_handle);
 	}
@@ -1107,7 +1112,7 @@ iavf_dev_start(struct rte_eth_dev *dev)
 
 	if (iavf_start_queues(dev) != 0) {
 		PMD_DRV_LOG(ERR, "enable queues failed");
-		goto error;
+		goto irq_error;
 	}
 
 	iavf_phc_sync_alarm_start(dev);
@@ -1118,6 +1123,13 @@ iavf_dev_start(struct rte_eth_dev *dev)
 
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
@@ -1150,6 +1162,8 @@ iavf_dev_stop(struct rte_eth_dev *dev)
 	rte_intr_vec_list_free(intr_handle);
 
 	iavf_stop_queues(dev);
+	rte_free(vf->qv_map);
+	vf->qv_map = NULL;
 
 	adapter->stopped = 1;
 	dev->data->dev_started = 0;
-- 
2.52.0

