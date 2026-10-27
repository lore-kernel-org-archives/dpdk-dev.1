Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E468606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 10:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kQELcjBL
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6B004064F;
	Tue, 27 Oct 2026 11:56:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTPS id DA40040431
 for <dev@dpdk.org>; Tue, 27 Oct 2026 11:56:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793098590; x=1824634590;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AzCfwL6p77jValjex2VdBZwCgIjTMI/t0maSykty0rQ=;
 b=kQELcjBL9tC+AWSzxeXXWHjBT2+pAlEQxL1A5mX0F/5fFW8uajeI7E3Q
 rzECfWk871KmpWOP1VugLR1wYyA4kxhxNLqJ9J6SJTYt6ivPSn4uDU6EL
 bZR6MrzgI+kz0g2pFnDEe4yMUIbeGgFp9/HU+3lcvG3jW204caO9iik95
 GI4FhyGpMggox1oD8k6+LkYFrapAYjEjTv3OxshSuzyQBIJCQjO/KaiNY
 pLdhddx/tKC9HOUG/vWm06sectlhZGXQcYqwfQBlluu76LX7QPonZnbeA
 hkt1PPeBx/1O7loWkLR7hrbJM3jCRLdOEcuIkHNwPdcjYv1OS11vAfYYl w==;
X-CSE-ConnectionGUID: RJXuwbnAQv2x1OntobjYXQ==
X-CSE-MsgGUID: O/NLk8uLR1WTJ9zAmxQG8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1679296"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1679296"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 03:56:29 -0700
X-CSE-ConnectionGUID: bM2iy5nVT+62CDn8SZ22Aw==
X-CSE-MsgGUID: k5VtU//wRjyWCTeKrDn0jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4901462"
Received: from pae.iind.intel.com (HELO PAE-35.iind.intel.com) ([10.49.105.82])
 by fmviesa009.fm.intel.com with ESMTP; 27 Oct 2026 03:56:28 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH 2/7] net/ice: fix memory leaks on port close
Date: Tue, 27 Oct 2026 10:51:32 +0000
Message-Id: <31d88770b8572311aad3b1cfb4c1dfb7814e4b0d.1793097896.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1793097896.git.anurag.mandal@intel.com>
References: <cover.1793097896.git.anurag.mandal@intel.com>
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

ice_dev_close() tears down the hardware state rather than with
ice_deinit_hw(), and never frees the switch filter management
structures, the DDP package copy or any remaining VSI contexts.
As ice_dev_reset() is a close followed by an init, they also
leak on every port reset.

Free them on close.

Fixes: f9cf4f864150 ("net/ice: support device initialization")
Fixes: 9c4f15901ada ("net/ice: free memory with matching allocator")

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index dd3a4976ab..27f992aefa 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -3109,8 +3109,12 @@ ice_dev_close(struct rte_eth_dev *dev)
 
 	ice_res_pool_destroy(&pf->msix_pool);
 	ice_release_vsi(pf->main_vsi);
+	ice_cleanup_fltr_mgmt_struct(hw);
+	hw->switch_info = NULL;
 	ice_sched_cleanup_all(hw);
 	ice_free_hw_tbls(hw);
+	ice_free_seg(hw);
+	ice_clear_all_vsi_ctx(hw);
 	ice_free(hw, hw->port_info);
 	hw->port_info = NULL;
 	free((void *)(uintptr_t)ad->devargs.ddp_filename);
-- 
2.25.1

