Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABD8606A331
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 09:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mAlADRbC
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD55940E72;
	Thu,  5 Nov 2026 10:52:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTPS id 0405340E72;
 Thu,  5 Nov 2026 10:52:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793872357; x=1825408357;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gPsNTMfxuZYNaEj8pYopezZZkhk9xDYCVT/5I17Lklg=;
 b=mAlADRbCAXCwCn2Qwj6/aVwtOtavpQiDIZyEDU5Z5+XoMVS3RTRkyhuH
 gUp2cLM7Aa0RZbEo7jnSqogf/or8FG8nPvoe3IkFEpQMu5V/NBCmTn6NA
 P0ri2ZCgEuTyC3BRgWDWLbmpbpvoPiS226ke5v2d/33DmGdKZRyOmL9tz
 nEhLGfikHle62ML+FxbOk4G5155MxYuS6BF5jWKZ+rWCHh9Ot1cTOFugJ
 TMUdIFFac7ZZm5Ry3feUJvgpTPkUPlpJwFP/KX+2FgXmK9ba94nnmQjip
 Pmw3aG7P6aEZHR9udCkS+JlWJTz+INdllgrcHMyYu9yfYwAt8GJ2pnL/Y A==;
X-CSE-ConnectionGUID: /VFXIQSUQeSOLRF0R95E4w==
X-CSE-MsgGUID: 0DrMa2fHTlWL8OkTw5nnCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2683955"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2683955"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 01:52:36 -0800
X-CSE-ConnectionGUID: ibXNJimrRguUfz1kJyMB3g==
X-CSE-MsgGUID: LHN1oPHBTCajJBdRAb0f1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7034199"
Received: from pae.iind.intel.com (HELO PAE-35.iind.intel.com) ([10.49.105.82])
 by orviesa006.jf.intel.com with ESMTP; 05 Nov 2026 01:52:34 -0800
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>, stable@dpdk.org
Subject: [PATCH 2/8] net/ice: fix DCF parent adapter init error path
Date: Thu,  5 Nov 2026 09:47:19 +0000
Message-Id: <dda5504f21585b9c6f4461323c6e11358703c47a.1793871697.git.anurag.mandal@intel.com>
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

