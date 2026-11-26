Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DCB606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 13:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DejkWVg8
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15AF540609;
	Thu, 26 Nov 2026 14:29:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTPS id 9A21B402BD;
 Thu, 26 Nov 2026 14:29:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795699758; x=1827235758;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=miaDaSLWOMJdfSKsAqbc8oYxLWNSLor/gV19+M/J/OU=;
 b=DejkWVg8SFZD7wFuLgrcsMJ1F7aAXAZAuY5tPBvidUnZNlc1z71XZ3dI
 t6NodyvTwJPQ99VctPiIqZEqa98hj762TX+Q0UBUbCGEvC2vRYggx9dnF
 /ww3KLDe6OPGM5oGp+sODkJG9DNCHJOA+I70WlHhBhQ2mic9kQzCtRDIC
 Gj0zF2JWaacBNNA7AICnflzKm1TnBIUzaqXdzyWSrXBuL/xt4zIo2siHL
 jWjbmI2atQXvhoNNXQffnRVYKpR1Oy2eMHLyRNmLtxmBOFWl8He9EprGt
 rpSQ+teSHR9RvQc7Fx3AzFhjPTU3/XWXezWuZa+HPqSE8pUlSgbvbARN9 g==;
X-CSE-ConnectionGUID: oHpLcbpYRj+YBq8fOnrjfQ==
X-CSE-MsgGUID: k/8YwAW2RH+GsX4yS2y3pQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4578853"
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="4578853"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 05:29:16 -0800
X-CSE-ConnectionGUID: zX/JfHJ+QveVyeEXBxRh9g==
X-CSE-MsgGUID: 5bj0/SbIRJm51Wda7y/XGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; d="scan'208";a="12032045"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa004.jf.intel.com with ESMTP; 26 Nov 2026 05:29:15 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Cunming Liang <cunming.liang@intel.com>
Subject: [PATCH 1/4] net/i40e: fix VMDq Rx interrupt vector mapping
Date: Thu, 26 Nov 2026 13:29:05 +0000
Message-ID: <20261126132909.3488716-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126132909.3488716-1-bruce.richardson@intel.com>
References: <20261126132909.3488716-1-bruce.richardson@intel.com>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The interrupt vector list is indexed by ethdev queue ID, but the driver
derives the VMDq index from the hardware queue number. This can overwrite
a main VSI queue's vector entry and leave the VMDq queue's entry unset.
Enabling or disabling Rx interrupts can then target the wrong vector.

Pass the first ethdev queue ID for each VSI to the binding helper. VMDq
queues follow the main VSI queues in pool order, regardless of their
hardware queue numbers. Also propagate errors when recording queues
that share a vector.

Fixes: be6c228d4da3 ("i40e: support Rx interrupt")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.c | 38 ++++++++++------------------
 drivers/net/intel/i40e/i40e_ethdev.h |  2 +-
 drivers/net/intel/i40e/i40e_fdir.c   |  2 +-
 drivers/net/intel/i40e/i40e_pf.c     |  2 +-
 4 files changed, 16 insertions(+), 28 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index 498c5c7ec4..5ea26c3348 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -1928,7 +1928,7 @@ __vsi_queues_bind_intr(struct i40e_vsi *vsi, uint16_t msix_vect,
 }
 
 int
-i40e_vsi_queues_bind_intr(struct i40e_vsi *vsi, uint16_t itr_idx)
+i40e_vsi_queues_bind_intr(struct i40e_vsi *vsi, uint16_t itr_idx, int ethdev_queue_base)
 {
 	struct rte_eth_dev *dev = I40E_VSI_TO_ETH_DEV(vsi);
 	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
@@ -1937,8 +1937,7 @@ i40e_vsi_queues_bind_intr(struct i40e_vsi *vsi, uint16_t itr_idx)
 	uint16_t msix_vect = vsi->msix_intr;
 	uint16_t nb_msix = RTE_MIN(vsi->nb_msix,
 				   rte_intr_nb_efd_get(intr_handle));
-	uint16_t queue_idx = 0;
-	int record = 0;
+	const bool record = ethdev_queue_base >= 0 && rte_intr_dp_is_en(intr_handle);
 	int i;
 
 	for (i = 0; i < vsi->nb_qps; i++) {
@@ -1959,18 +1958,6 @@ i40e_vsi_queues_bind_intr(struct i40e_vsi *vsi, uint16_t itr_idx)
 	}
 
 	/* PF & VMDq bind interrupt */
-	if (rte_intr_dp_is_en(intr_handle)) {
-		if (vsi->type == I40E_VSI_MAIN) {
-			queue_idx = 0;
-			record = 1;
-		} else if (vsi->type == I40E_VSI_VMDQ2) {
-			struct i40e_vsi *main_vsi =
-				I40E_DEV_PRIVATE_TO_MAIN_VSI(vsi->adapter);
-			queue_idx = vsi->base_queue - main_vsi->nb_qps;
-			record = 1;
-		}
-	}
-
 	for (i = 0; i < vsi->nb_used_qps; i++) {
 		if (vsi->nb_msix == 0) {
 			PMD_DRV_LOG(ERR, "No msix resource");
@@ -1985,19 +1972,20 @@ i40e_vsi_queues_bind_intr(struct i40e_vsi *vsi, uint16_t itr_idx)
 					       vsi->base_queue + i,
 					       vsi->nb_used_qps - i,
 					       itr_idx);
-			for (; !!record && i < vsi->nb_used_qps; i++)
-				rte_intr_vec_list_index_set(intr_handle,
-						queue_idx + i, msix_vect);
+			for (; record && i < vsi->nb_used_qps; i++) {
+				if (rte_intr_vec_list_index_set(intr_handle,
+						ethdev_queue_base + i, msix_vect) != 0)
+					return -rte_errno;
+			}
 			break;
 		}
 		/* 1:1 queue/msix_vect mapping */
 		__vsi_queues_bind_intr(vsi, msix_vect,
 				       vsi->base_queue + i, 1,
 				       itr_idx);
-		if (!!record)
-			if (rte_intr_vec_list_index_set(intr_handle,
-						queue_idx + i, msix_vect))
-				return -rte_errno;
+		if (record && rte_intr_vec_list_index_set(intr_handle,
+				ethdev_queue_base + i, msix_vect) != 0)
+			return -rte_errno;
 
 		msix_vect++;
 		nb_msix--;
@@ -2245,7 +2233,7 @@ i40e_dev_start(struct rte_eth_dev *dev)
 	/* Map queues with MSIX interrupt */
 	main_vsi->nb_used_qps = dev->data->nb_rx_queues -
 		pf->nb_cfg_vmdq_vsi * RTE_LIBRTE_I40E_QUEUE_NUM_PER_VM;
-	ret = i40e_vsi_queues_bind_intr(main_vsi, I40E_ITR_INDEX_DEFAULT);
+	ret = i40e_vsi_queues_bind_intr(main_vsi, I40E_ITR_INDEX_DEFAULT, 0);
 	if (ret < 0)
 		return ret;
 	i40e_vsi_enable_queues_intr(main_vsi);
@@ -2253,8 +2241,8 @@ i40e_dev_start(struct rte_eth_dev *dev)
 	/* Map VMDQ VSI queues with MSIX interrupt */
 	for (i = 0; i < pf->nb_cfg_vmdq_vsi; i++) {
 		pf->vmdq[i].vsi->nb_used_qps = RTE_LIBRTE_I40E_QUEUE_NUM_PER_VM;
-		ret = i40e_vsi_queues_bind_intr(pf->vmdq[i].vsi,
-						I40E_ITR_INDEX_DEFAULT);
+		ret = i40e_vsi_queues_bind_intr(pf->vmdq[i].vsi, I40E_ITR_INDEX_DEFAULT,
+				main_vsi->nb_qps + i * pf->vmdq_nb_qps);
 		if (ret < 0)
 			return ret;
 		i40e_vsi_enable_queues_intr(pf->vmdq[i].vsi);
diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index e5e136f554..93cb8e6bac 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.h
+++ b/drivers/net/intel/i40e/i40e_ethdev.h
@@ -1368,7 +1368,7 @@ void i40e_update_vsi_stats(struct i40e_vsi *vsi);
 void i40e_pf_disable_irq0(struct i40e_hw *hw);
 void i40e_pf_enable_irq0(struct i40e_hw *hw);
 int i40e_dev_link_update(struct rte_eth_dev *dev, int wait_to_complete);
-int i40e_vsi_queues_bind_intr(struct i40e_vsi *vsi, uint16_t itr_idx);
+int i40e_vsi_queues_bind_intr(struct i40e_vsi *vsi, uint16_t itr_idx, int ethdev_queue_base);
 void i40e_vsi_queues_unbind_intr(struct i40e_vsi *vsi);
 void i40e_vsi_disable_queues_intr(struct i40e_vsi *vsi);
 int i40e_vsi_vlan_pvid_set(struct i40e_vsi *vsi,
diff --git a/drivers/net/intel/i40e/i40e_fdir.c b/drivers/net/intel/i40e/i40e_fdir.c
index 69b3b763ba..d71d20389f 100644
--- a/drivers/net/intel/i40e/i40e_fdir.c
+++ b/drivers/net/intel/i40e/i40e_fdir.c
@@ -219,7 +219,7 @@ i40e_fdir_setup(struct i40e_pf *pf)
 
 	/* enable FDIR MSIX interrupt */
 	vsi->nb_used_qps = 1;
-	i40e_vsi_queues_bind_intr(vsi, I40E_ITR_INDEX_NONE);
+	i40e_vsi_queues_bind_intr(vsi, I40E_ITR_INDEX_NONE, -1);
 	i40e_vsi_enable_queues_intr(vsi);
 
 	/* reserve memory for the fdir programming packet */
diff --git a/drivers/net/intel/i40e/i40e_pf.c b/drivers/net/intel/i40e/i40e_pf.c
index c76e035a42..1f816bd1f7 100644
--- a/drivers/net/intel/i40e/i40e_pf.c
+++ b/drivers/net/intel/i40e/i40e_pf.c
@@ -693,7 +693,7 @@ i40e_pf_host_process_cmd_config_irq_map(struct i40e_pf_vf *vf,
 		 * Link all VF RX queues together. Only did mapping work.
 		 * VF can disable/enable the intr by itself.
 		 */
-		i40e_vsi_queues_bind_intr(vf->vsi, itr_idx);
+		i40e_vsi_queues_bind_intr(vf->vsi, itr_idx, -1);
 		goto send_msg;
 	}
 
-- 
2.55.0

