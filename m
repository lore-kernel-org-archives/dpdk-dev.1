Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C02606A321
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 15:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=D0RDubdg
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F23EA40285;
	Tue, 10 Nov 2026 16:16:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTPS id B126240281;
 Tue, 10 Nov 2026 16:16:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794323811; x=1825859811;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=w1Nyq1PDGVFJckXOMhi4raXZ+rAmidNl0NNwtTaZeho=;
 b=D0RDubdgu2eWfLAkeKAnDVQaZbpuGruYChqZvFtKTNtqTOPaE7bLeiPy
 1zr2aLavgbz+3VwYq+z4KR2UCncG/eGL4NA/h0XpeCteO7Sa8YHSJm/bx
 X1ocI78qB3PZA4sUVezFdekJv00XHyIWMfen5IPjuLpLJyThB95BYCHHQ
 mCQckn0Jia5h3hQcwGah1TSqhpXp5NPBWd9Uw49NlehaYzynrX7ljvjpS
 yKWbz/cNaJzHn9o5POz3OFt+q3rjBh24lgxD/KEncUh1L4IK3n3xzoor1
 l0Htq+HZ54QdvU9ehVCBXkqFey5YRPaV5mcxe4Vg3MjhaNM/fxc38itVS w==;
X-CSE-ConnectionGUID: CxUyAaLASMuDsqvAkhP7KA==
X-CSE-MsgGUID: KffmgT3yTwK3ZZxDJ0ZryA==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="2950117"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="2950117"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2026 07:16:49 -0800
X-CSE-ConnectionGUID: ffJG1fPtSD+u7Q9CLlx5tw==
X-CSE-MsgGUID: Uc1WNjApTguX/0fuE0KI+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="8005564"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa008.jf.intel.com with ESMTP; 10 Nov 2026 07:16:49 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH] net/ice: fix DCF probe failure when ACL is unavailable
Date: Tue, 10 Nov 2026 15:15:39 +0000
Message-ID: <20261110151539.125810-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
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

Currently, the DCF requests the ACL flow engine unconditionally and
fails the whole probe if its initialisation fails. The PF driver can
legitimately refuse the ACL capability to a DCF and in that case it
silently drops every ACL AdminQ command instead of returning an error.
The DCF then times out on the ACL table allocation and probe fails,
even though the switch and RSS engines would have worked.

Fix it by treating an ACL engine initialisation failure as non-fatal
when running as DCF. Log a warning, mark the engine disabled and continue
initialising the remaining engines.

Fixes: 40d466fa9f76 ("net/ice: support ACL filter in DCF")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/ice/ice_dcf_parent.c   | 2 ++
 drivers/net/intel/ice/ice_generic_flow.c | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/intel/ice/ice_dcf_parent.c b/drivers/net/intel/ice/ice_dcf_parent.c
index 4d620fe8f5a..39c88508ad3 100644
--- a/drivers/net/intel/ice/ice_dcf_parent.c
+++ b/drivers/net/intel/ice/ice_dcf_parent.c
@@ -497,6 +497,8 @@ ice_dcf_init_parent_adapter(struct rte_eth_dev *eth_dev)
 
 	ice_dcf_update_vf_vsi_map(parent_hw, hw->num_vfs, hw->vf_vsi_map);
 
+	/* Retry ACL initialization after reset unless disabled by devargs. */
+	parent_adapter->disabled_engine_mask &= ~BIT(ICE_FLOW_ENGINE_ACL);
 	if (ice_devargs_check(eth_dev->device->devargs, ICE_DCF_DEVARG_ACL))
 		parent_adapter->disabled_engine_mask |= BIT(ICE_FLOW_ENGINE_ACL);
 
diff --git a/drivers/net/intel/ice/ice_generic_flow.c b/drivers/net/intel/ice/ice_generic_flow.c
index 1602691b1cc..6d8bf6a939d 100644
--- a/drivers/net/intel/ice/ice_generic_flow.c
+++ b/drivers/net/intel/ice/ice_generic_flow.c
@@ -2012,6 +2012,14 @@ ice_flow_init(struct ice_adapter *ad)
 
 		ret = engine->init(ad);
 		if (ret) {
+			/* The PF may refuse the ACL capability to a DCF. Run without it. */
+			if (ad->hw.dcf_enabled && engine->type == ICE_FLOW_ENGINE_ACL) {
+				PMD_INIT_LOG(WARNING, "ACL engine not available, disabling it");
+				if (engine->uninit)
+					engine->uninit(ad);
+				ad->disabled_engine_mask |= BIT(ICE_FLOW_ENGINE_ACL);
+				continue;
+			}
 			PMD_INIT_LOG(ERR, "Failed to initialize engine %d",
 					engine->type);
 			return ret;
-- 
2.43.0

