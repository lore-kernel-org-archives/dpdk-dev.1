Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A6D606A32E
	for <dpdk-dev@archiver.kernel.org>; Sat,  7 Nov 2026 23:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TQjtRr7c
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3218F40E2D;
	Sun,  8 Nov 2026 00:57:28 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTPS id E464340E24;
 Sun,  8 Nov 2026 00:57:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794095847; x=1825631847;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fJHAJnc1D20b6o+jisOgH5+BxytNe+s0/B1cZp3etqk=;
 b=TQjtRr7cfYka4fLl4/fa48oDVFP/5vAK1hlJK7AnZMJSBzBWLrSicphN
 msnc9x0Bb5hasmpQY7I8WEjh1sg8GMZvBzwX91gTCtLCiN+goJn4c5Dtd
 S1bFvp9lsqWwyh+NsDNhpT/JjmVOnIy3tb6/MleecKeBko7Dlm3ropSUI
 y8/E2Jrb0NogGWfc8AGgqcAb6ynHmlHTgNwAUOr87lpf5RPiqV6FhyMZn
 GoA02ZGisVQq9JgYyRpLF2qh2ADWHXA7DmYhK/fp8nBilSEJx6up0xVUm
 zexjtxtfxZcw2Pmqel858bB8Ale5096XcZpYoVEbMe1IakIubstBwmfzP w==;
X-CSE-ConnectionGUID: Plm8nFvKQ76g9S7FHCEHew==
X-CSE-MsgGUID: Qq4dPZ30SMmoMoZeVGqihQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11959"; a="2885085"
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="2885085"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2026 15:57:26 -0800
X-CSE-ConnectionGUID: KYCPKcMJS+e+v8PIPu0heg==
X-CSE-MsgGUID: ZrcAO8uKRUOeowaJD50bhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="7464633"
Received: from pae.iind.intel.com (HELO PAE-35.iind.intel.com) ([10.49.105.82])
 by orviesa005.jf.intel.com with ESMTP; 07 Nov 2026 15:57:24 -0800
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>, stable@dpdk.org
Subject: [PATCH v2 2/8] net/ice: fix DCF parent adapter init error path
Date: Sat,  7 Nov 2026 23:52:12 +0000
Message-Id: <4b3d93e13b482f1545bb4d26e9e63b8eb74212eb.1794094943.git.anurag.mandal@intel.com>
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

ice_dcf_init_parent_adapter() allocates a dummy main VSI
first, but none of its error paths free it.

When ice_flow_init() fails, the error path also skips
ice_flow_uninit(), so the DDP parser and any flow engine
state set up before the failure are not released.

Free the main VSI on all error paths, and call
ice_flow_uninit() when flow init fails.

Fixes: 0b02c9519432 ("net/ice: handle PF initialization by DCF")
Fixes: 829c3106812d ("net/ice: enable switch flow on DCF")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/ice_dcf_parent.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/ice/ice_dcf_parent.c b/drivers/net/intel/ice/ice_dcf_parent.c
index e6398205ce..d5d37f8810 100644
--- a/drivers/net/intel/ice/ice_dcf_parent.c
+++ b/drivers/net/intel/ice/ice_dcf_parent.c
@@ -457,7 +457,7 @@ ice_dcf_init_parent_adapter(struct rte_eth_dev *eth_dev)
 	if (err) {
 		PMD_INIT_LOG(ERR, "failed to init the DCF parent hardware with error %d",
 			     err);
-		return err;
+		goto free_vsi;
 	}
 
 	if (hw->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_QOS) {
@@ -491,7 +491,7 @@ ice_dcf_init_parent_adapter(struct rte_eth_dev *eth_dev)
 	err = ice_flow_init(parent_adapter);
 	if (err) {
 		PMD_INIT_LOG(ERR, "Failed to initialize flow");
-		goto uninit_hw;
+		goto uninit_flow;
 	}
 
 	mac = (const struct rte_ether_addr *)hw->avf.mac.addr;
@@ -504,8 +504,13 @@ ice_dcf_init_parent_adapter(struct rte_eth_dev *eth_dev)
 
 	return 0;
 
+uninit_flow:
+	ice_flow_uninit(parent_adapter);
 uninit_hw:
 	ice_dcf_uninit_parent_hw(parent_hw);
+free_vsi:
+	rte_free(parent_adapter->pf.main_vsi);
+	parent_adapter->pf.main_vsi = NULL;
 	return err;
 }
 
-- 
2.25.1

