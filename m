Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA385606A331
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 08:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OUAesHog
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8089F40E45;
	Mon,  2 Nov 2026 09:15:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTPS id A22FE40E3F;
 Mon,  2 Nov 2026 09:15:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793607339; x=1825143339;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ONxy55jXPZ7fFnPp0YrFBV12Gp+I6tfcNe261Bufsag=;
 b=OUAesHogLB3dadYMk2ebxyIZ6k8K8FFK7ttmdyfa1faLsT8unmaLjGwp
 cZI2HBxfBLVdx5Dr97VF8cMKq//t0W29cEsdK2Pe++bClJ1TPTGo7n32e
 a21jfJVV9eXgikWyOkoildAAceAqtyzqQrTVmUJ85XjtxGp0bHYK+ZDeQ
 oGsu1ex2tpG3Vz6B+X8xB5gpRm8fRAYdehJ/TSawUIUdS0A9hVvnZMflO
 0dqZ4WKTrhIuOP4+dMj11UQEUygIg8T0Yvgis5uTNXk4U0YiHP+J+08K1
 d9AzTvIrBCKJguumJ/vw/7Ca96OHh5CrJZG7o2IC40q1SKG2lFIooeXfm Q==;
X-CSE-ConnectionGUID: DWaK9Qs9Q6yZEISKP8WRfA==
X-CSE-MsgGUID: sL0Bq6JsSDaAPFBa0j9B+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2283633"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2283633"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 00:15:38 -0800
X-CSE-ConnectionGUID: 5CP8UVY3SwuQXOH/lxGD3Q==
X-CSE-MsgGUID: PNj9trEYTk252+DaOUT/pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="7818616"
Received: from pae.iind.intel.com (HELO PAE-35.iind.intel.com) ([10.49.105.82])
 by fmviesa012.fm.intel.com with ESMTP; 02 Nov 2026 00:15:37 -0800
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>, stable@dpdk.org
Subject: [PATCH v2 2/7] net/ice: fix resource leaks on port close
Date: Mon,  2 Nov 2026 08:10:32 +0000
Message-Id: <9180f1bfcb85d3d47bf5cd4bd3b4b393a74404e0.1793605752.git.anurag.mandal@intel.com>
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

ice_dev_close() tears down the hardware state rather than with
ice_deinit_hw(), and misses part of it.
The switch filter management structures, the DDP package copy
and any remaining VSI contexts are never freed, and the flow
director counter block, allocated by ice_init_hw(), is never
given back to the firmware.
As ice_dev_reset() is a close followed by an init, the memory
also leaks on every port reset.

Call ice_deinit_hw() instead.

Fixes: f9cf4f864150 ("net/ice: support device initialization")
Fixes: 9c4f15901ada ("net/ice: free memory with matching allocator")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 4c21356736..4abc0c3544 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -3109,13 +3109,9 @@ ice_dev_close(struct rte_eth_dev *dev)
 
 	ice_res_pool_destroy(&pf->msix_pool);
 	ice_release_vsi(pf->main_vsi);
-	ice_sched_cleanup_all(hw);
-	ice_free_hw_tbls(hw);
-	ice_free(hw, hw->port_info);
-	hw->port_info = NULL;
+	ice_deinit_hw(hw);
 	free((void *)(uintptr_t)ad->devargs.ddp_filename);
 	ad->devargs.ddp_filename = NULL;
-	ice_shutdown_all_ctrlq(hw, true);
 	rte_free(pf->proto_xtr);
 	pf->proto_xtr = NULL;
 
-- 
2.25.1

