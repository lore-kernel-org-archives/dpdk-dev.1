Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52051606EE91
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 09:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fnEBhuP/
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CC2941149;
	Thu,  5 Nov 2026 10:53:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTPS id 8C4294060F;
 Thu,  5 Nov 2026 10:53:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793872393; x=1825408393;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vIBZl/kkosGeuCEbXXffk3WWo4OgKSZvVqzeGPYyYPI=;
 b=fnEBhuP/zQEeNTJgxtWfJfz+8nVyBC+yTuYVUHVORIia7P/eKry/6wDW
 Dvxyn4AFN0aae3c1ocwApFsdSt0WfFXpQvQALjP1GMbdK3sUUdhYDWTCa
 RfKvtSaHfQApmwSkVGPyds2jXpk1qgCN1Ee5/mA8HcuGj3CpXv6UkwUPE
 hANqAMtoQwtDHVSXARWwW+SWbcezDF3a7oZ8856sXYlC1y4EygDBHyAQ6
 3ye8HGecQ5SBqqazLV9BrnFKPWO5Xbk61i0pv3leTqlv3mwHEAm/77cur
 LPMjImB5j1TP7I04X7Bsp0fD9rBxI4Ca2fJzVPEB9euFU9nROAhDeGq1s w==;
X-CSE-ConnectionGUID: GpiV6f7TSKWHfOm9FCoC5A==
X-CSE-MsgGUID: +TfMZVQbTxyMwUWPdYalaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2683969"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2683969"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 01:53:12 -0800
X-CSE-ConnectionGUID: 84V1fVODR5q05AzH3zEhpg==
X-CSE-MsgGUID: NCvIhaRsQZSTKcJH6o8OrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7034302"
Received: from pae.iind.intel.com (HELO PAE-35.iind.intel.com) ([10.49.105.82])
 by orviesa006.jf.intel.com with ESMTP; 05 Nov 2026 01:53:10 -0800
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>, stable@dpdk.org
Subject: [PATCH 5/8] net/ice: fix DCF QoS bandwidth replay config leak
Date: Thu,  5 Nov 2026 09:47:22 +0000
Message-Id: <af5fbafe6cfc167e80b3a69b2080b20b431ac166.1793871697.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1793871697.git.anurag.mandal@intel.com>
References: <cover.1793871697.git.anurag.mandal@intel.com>
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
Each commit allocates new copies without freeing the old ones,
and ice_dcf_uninit_hw() frees the array but not the copies, so
they also leak on close and reset.

Free the old copy before allocating a new one, and free all copies
in ice_dcf_uninit_hw().

Fixes: 931ee54072b1 ("net/ice: support QoS bandwidth config after VF reset in DCF")
Fixes: 775a25a372f5 ("net/ice: clear QoS bandwidth on DCF close")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/ice/ice_dcf.c       | 6 ++++++
 drivers/net/intel/ice/ice_dcf_sched.c | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/intel/ice/ice_dcf.c b/drivers/net/intel/ice/ice_dcf.c
index 09fcf6454f..c2b557d0da 100644
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
 
diff --git a/drivers/net/intel/ice/ice_dcf_sched.c b/drivers/net/intel/ice/ice_dcf_sched.c
index de28019c5b..f8755c7dcb 100644
--- a/drivers/net/intel/ice/ice_dcf_sched.c
+++ b/drivers/net/intel/ice/ice_dcf_sched.c
@@ -813,6 +813,7 @@ static int ice_dcf_hierarchy_commit(struct rte_eth_dev *dev,
 		if (ret_val)
 			goto fail_clear;
 
+		rte_free(hw->qos_bw_cfg[vf_id]);
 		hw->qos_bw_cfg[vf_id] = rte_zmalloc("vf_bw_cfg", size, 0);
 		if (!hw->qos_bw_cfg[vf_id]) {
 			ret_val = ICE_ERR_NO_MEMORY;
@@ -840,6 +841,7 @@ static int ice_dcf_hierarchy_commit(struct rte_eth_dev *dev,
 		goto fail_clear;
 
 	/* store TC node bw configuration */
+	rte_free(hw->qos_bw_cfg[ICE_DCF_VFID]);
 	hw->qos_bw_cfg[ICE_DCF_VFID] = rte_zmalloc("tc_bw_cfg", size, 0);
 	if (!hw->qos_bw_cfg[ICE_DCF_VFID]) {
 		ret_val = ICE_ERR_NO_MEMORY;
-- 
2.25.1

