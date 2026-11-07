Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40697606A326
	for <dpdk-dev@archiver.kernel.org>; Sat,  7 Nov 2026 23:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jAaq92qu
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC97040E54;
	Sun,  8 Nov 2026 00:57:36 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTPS id D0C7240E54;
 Sun,  8 Nov 2026 00:57:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794095855; x=1825631855;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8vePqNQwzn4ZrPMqjlUUe/rxTJ2uR+m/o0UqHpCZa+A=;
 b=jAaq92qu56ASc0/7dv/TqCbn8VcdM9V3OTG3iI1ccOTfpmms365pFCSI
 4RVY3ZQ/i8T2FQBgL1bQ7JSulC2kuHCv3d5g6PAnZcn999i8Mlh1oqgoj
 V72vRC7YptsP8RDLfg4Tf8MsQuC8wVD7Hrq0nOz4uKAInj7spFztC2LOd
 xyIUBvYz6RRrYmia3lwT+wgnCaKB3HelhT93c8exeBkL3xtdpp69APHv0
 lEvhePCPqGJ9vtExrglUj0taazjqw7/GKDI4JOr+H96Xy5vmSwmDuywsa
 nxGjJToSV4cnE80JqwuEFXk0I9tLsnyi+fNMqTYMS0lfOQYdaCM0wDtu5 Q==;
X-CSE-ConnectionGUID: Oed9TXR6RCaxkDwo8Kpnug==
X-CSE-MsgGUID: e+IxQBOoSxiChLecGWBFfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11959"; a="2885092"
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="2885092"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2026 15:57:34 -0800
X-CSE-ConnectionGUID: P+8FgUdARsudr2IdPhgkKg==
X-CSE-MsgGUID: RnqTBdbwTTWV11LYyzgTjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="7464649"
Received: from pae.iind.intel.com (HELO PAE-35.iind.intel.com) ([10.49.105.82])
 by orviesa005.jf.intel.com with ESMTP; 07 Nov 2026 15:57:32 -0800
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>, stable@dpdk.org
Subject: [PATCH v2 5/8] net/ice: fix DCF QoS bandwidth replay config leak
Date: Sat,  7 Nov 2026 23:52:15 +0000
Message-Id: <285894e024af9bf081d823ac0f9e0b7d71f85fd0.1794094943.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1794094943.git.anurag.mandal@intel.com>
References: <cover.1794094943.git.anurag.mandal@intel.com>
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

ice_dcf_hierarchy_commit() keeps a copy of the bandwidth config
of each VF, and of the TC nodes, in qos_bw_cfg[] to replay it
after a VF reset.
Each DCF hierarchy commit allocates commit allocates new copies
of the VF and TC bandwidth config for VF reset replay, without
freeing the previous ones,
They cannot simply be freed there, as the VF reset thread may be
replaying them at the same time.
A new copy is also visible to that thread before it is filled in.
Also, ice_dcf_uninit_hw() frees the array but not the copies, so
they also leak on close and reset.

Fill each new copy first, then swap it in under the lock the VF
reset thread holds while replaying, and free the old copy after
that and free all copies in ice_dcf_uninit_hw().

Fixes: 931ee54072b1 ("net/ice: support QoS bandwidth config after VF reset in DCF")
Fixes: 775a25a372f5 ("net/ice: clear QoS bandwidth on DCF close")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/ice/ice_dcf.c        |  6 ++++++
 drivers/net/intel/ice/ice_dcf_ethdev.h |  2 ++
 drivers/net/intel/ice/ice_dcf_parent.c | 15 +++++++++++++++
 drivers/net/intel/ice/ice_dcf_sched.c  | 17 +++++++++--------
 4 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/net/intel/ice/ice_dcf.c b/drivers/net/intel/ice/ice_dcf.c
index f94856ad9c..4bc3c07d81 100644
--- a/drivers/net/intel/ice/ice_dcf.c
+++ b/drivers/net/intel/ice/ice_dcf.c
@@ -884,6 +884,7 @@ ice_dcf_uninit_hw(struct rte_eth_dev *eth_dev, struct ice_dcf_hw *hw)
 {
 	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
+	uint16_t i;
 
 	if (hw->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_QOS)
 		if (hw->tm_conf.committed) {
@@ -919,6 +920,11 @@ ice_dcf_uninit_hw(struct rte_eth_dev *eth_dev, struct ice_dcf_hw *hw)
 	rte_free(hw->rss_key);
 	hw->rss_key = NULL;
 
+	if (hw->qos_bw_cfg != NULL) {
+		for (i = 0; i < hw->num_vfs; i++)
+			rte_free(hw->qos_bw_cfg[i]);
+	}
+
 	rte_free(hw->qos_bw_cfg);
 	hw->qos_bw_cfg = NULL;
 
diff --git a/drivers/net/intel/ice/ice_dcf_ethdev.h b/drivers/net/intel/ice/ice_dcf_ethdev.h
index 6dcbaac5eb..4560be6330 100644
--- a/drivers/net/intel/ice/ice_dcf_ethdev.h
+++ b/drivers/net/intel/ice/ice_dcf_ethdev.h
@@ -75,6 +75,8 @@ void ice_dcf_handle_pf_event_msg(struct ice_dcf_hw *dcf_hw,
 				 uint8_t *msg, uint16_t msglen);
 int ice_dcf_init_parent_adapter(struct rte_eth_dev *eth_dev);
 void ice_dcf_uninit_parent_adapter(struct rte_eth_dev *eth_dev);
+void ice_dcf_replace_qos_bw_cfg(struct ice_dcf_hw *hw, uint16_t idx,
+				struct virtchnl_dcf_bw_cfg_list *bw_cfg);
 
 int ice_devargs_check(struct rte_devargs *devargs, enum ice_dcf_devrarg devarg_type);
 int ice_dcf_vf_repr_init(struct rte_eth_dev *vf_rep_eth_dev, void *init_param);
diff --git a/drivers/net/intel/ice/ice_dcf_parent.c b/drivers/net/intel/ice/ice_dcf_parent.c
index d5d37f8810..4d620fe8f5 100644
--- a/drivers/net/intel/ice/ice_dcf_parent.c
+++ b/drivers/net/intel/ice/ice_dcf_parent.c
@@ -162,6 +162,21 @@ ice_dcf_vsi_update_service_handler(void *param)
 	return 0;
 }
 
+void
+ice_dcf_replace_qos_bw_cfg(struct ice_dcf_hw *hw, uint16_t idx,
+			   struct virtchnl_dcf_bw_cfg_list *bw_cfg)
+{
+	struct virtchnl_dcf_bw_cfg_list *old;
+
+	/* the VF reset thread replays this config while holding the lock */
+	rte_spinlock_lock(&vsi_update_lock);
+	old = hw->qos_bw_cfg[idx];
+	hw->qos_bw_cfg[idx] = bw_cfg;
+	rte_spinlock_unlock(&vsi_update_lock);
+
+	rte_free(old);
+}
+
 static void
 start_vsi_reset_thread(struct ice_dcf_hw *dcf_hw, bool vfr, uint16_t vf_id)
 {
diff --git a/drivers/net/intel/ice/ice_dcf_sched.c b/drivers/net/intel/ice/ice_dcf_sched.c
index de28019c5b..a524d9c777 100644
--- a/drivers/net/intel/ice/ice_dcf_sched.c
+++ b/drivers/net/intel/ice/ice_dcf_sched.c
@@ -725,6 +725,7 @@ static int ice_dcf_hierarchy_commit(struct rte_eth_dev *dev,
 	struct ice_dcf_hw *hw = &adapter->real_hw;
 	struct virtchnl_dcf_bw_cfg_list *vf_bw = NULL;
 	struct virtchnl_dcf_bw_cfg_list *tc_bw = NULL;
+	struct virtchnl_dcf_bw_cfg_list *bw_cfg;
 	struct ice_dcf_tm_node_list *vsi_list = &hw->tm_conf.vsi_list;
 	struct rte_tm_shaper_params *profile;
 	struct ice_dcf_tm_node *tm_node;
@@ -813,14 +814,14 @@ static int ice_dcf_hierarchy_commit(struct rte_eth_dev *dev,
 		if (ret_val)
 			goto fail_clear;
 
-		hw->qos_bw_cfg[vf_id] = rte_zmalloc("vf_bw_cfg", size, 0);
-		if (!hw->qos_bw_cfg[vf_id]) {
+		bw_cfg = rte_zmalloc("vf_bw_cfg", size, 0);
+		if (!bw_cfg) {
 			ret_val = ICE_ERR_NO_MEMORY;
 			goto fail_clear;
 		}
 		/* store the bandwidth information for replay */
-		ice_memcpy(hw->qos_bw_cfg[vf_id], vf_bw, size,
-			   ICE_NONDMA_TO_NONDMA);
+		ice_memcpy(bw_cfg, vf_bw, size, ICE_NONDMA_TO_NONDMA);
+		ice_dcf_replace_qos_bw_cfg(hw, vf_id, bw_cfg);
 		ice_memset(vf_bw, 0, size, ICE_NONDMA_MEM);
 	}
 
@@ -840,13 +841,13 @@ static int ice_dcf_hierarchy_commit(struct rte_eth_dev *dev,
 		goto fail_clear;
 
 	/* store TC node bw configuration */
-	hw->qos_bw_cfg[ICE_DCF_VFID] = rte_zmalloc("tc_bw_cfg", size, 0);
-	if (!hw->qos_bw_cfg[ICE_DCF_VFID]) {
+	bw_cfg = rte_zmalloc("tc_bw_cfg", size, 0);
+	if (!bw_cfg) {
 		ret_val = ICE_ERR_NO_MEMORY;
 		goto fail_clear;
 	}
-	ice_memcpy(hw->qos_bw_cfg[ICE_DCF_VFID], tc_bw, size,
-		   ICE_NONDMA_TO_NONDMA);
+	ice_memcpy(bw_cfg, tc_bw, size, ICE_NONDMA_TO_NONDMA);
+	ice_dcf_replace_qos_bw_cfg(hw, ICE_DCF_VFID, bw_cfg);
 
 	hw->tm_conf.committed = true;
 	free(vf_bw);
-- 
2.25.1

