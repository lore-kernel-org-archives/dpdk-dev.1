Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18B8606A324
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 08:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ksB/5Z0A
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92A8740E3E;
	Mon,  2 Nov 2026 09:15:46 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTPS id 87D1040E6E;
 Mon,  2 Nov 2026 09:15:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793607344; x=1825143344;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3nYxnlB6hH1D0AqB6KxXaJ+Zc9mi1xJcMAbYSrrK9jk=;
 b=ksB/5Z0ABYCGmJ7Ev9YSpdwTOFkaIvqWKYKDny9mxO815ZLd2mvPhlXB
 6h09rtGrbhts6TjYDJfHi4rUI93xampEASJs1pHCyqlY6Agd3T4lH8E1x
 6zl+wq9Jqqm/q0kdKlF+yXk76EHD27fcZjQhhc3dEI25f3WED97MgoKXI
 0OPm7JtCdeDU0Nu8LFzp8zKMPbiHYwIY9RKmdNfkbZS2Kgu8RSMUU8mRw
 Y3q/oCtC5uA7l326dmZUElfD3gruRCG6ycZcoqCMzQ4sgoqQ9rsz3K73E
 ao3qs9elJ2pWXWu8Gc4IGD5qWMOkettVas2RO+ASTxBOuIpvxoloAraI0 w==;
X-CSE-ConnectionGUID: wcfjQ1EiQ1mcQ99yrpje5Q==
X-CSE-MsgGUID: 2/k2KHU6TQOG+WZDghkPzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2283635"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2283635"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 00:15:44 -0800
X-CSE-ConnectionGUID: gfPMCXZPR2aW0HKzHQXERg==
X-CSE-MsgGUID: iu+kHlnyTMeaMiYGILT+oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="7818674"
Received: from pae.iind.intel.com (HELO PAE-35.iind.intel.com) ([10.49.105.82])
 by fmviesa012.fm.intel.com with ESMTP; 02 Nov 2026 00:15:42 -0800
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>, stable@dpdk.org
Subject: [PATCH v2 4/7] net/ice: fix main VSI leak on init failure
Date: Mon,  2 Nov 2026 08:10:34 +0000
Message-Id: <e8baa03e20849948357f45caadd42888ddb3ae46.1793605752.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1793605751.git.anurag.mandal@intel.com>
References: <cover.1793605751.git.anurag.mandal@intel.com>
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

When ice_send_driver_ver(), ice_flow_init() or ice_reset_fxp_resource()
fails in ice_dev_init(), the error path skips releasing the main VSI
created by ice_pf_setup(). This leaks the VSI structure, its MAC
filters and the VSI in hardware.

Release the main VSI on these error paths.

Fixes: 9481b0902efe ("net/ice: send driver version to firmware")
Fixes: 96b25c496aad ("net/ice: fix memzone leak after device init failure")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index d8d2b818d8..53a14dfd2b 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -2833,7 +2833,7 @@ ice_dev_init(struct rte_eth_dev *dev)
 	ret = ice_send_driver_ver(hw);
 	if (ret) {
 		PMD_INIT_LOG(ERR, "Failed to send driver version");
-		goto err_pf_setup;
+		goto err_release_vsi;
 	}
 
 	vsi = pf->main_vsi;
@@ -2905,6 +2905,9 @@ ice_dev_init(struct rte_eth_dev *dev)
 	ice_pf_disable_irq0(hw);
 	rte_intr_callback_unregister(intr_handle,
 				     ice_interrupt_handler, dev);
+err_release_vsi:
+	ice_release_vsi(pf->main_vsi);
+	pf->main_vsi = NULL;
 err_pf_setup:
 	ice_res_pool_destroy(&pf->msix_pool);
 err_msix_pool_init:
-- 
2.25.1

