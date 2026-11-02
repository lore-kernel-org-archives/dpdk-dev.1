Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E1F606A324
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 08:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Q4mEt6/a
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC74740EAB;
	Mon,  2 Nov 2026 09:15:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTPS id 0EA0140E5A;
 Mon,  2 Nov 2026 09:15:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793607350; x=1825143350;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hK0wYASQwgz/RWwx+54FaJf99+ypVzuGUs0/ejT/IHI=;
 b=Q4mEt6/a/AyT0gp0UGLp4BRTofslb04xJQQkSzzwKj1/Ente+0rawqxr
 R17QdJB10XzvDSQpQLGSa+HaCar6ImyJSvZuJJyVEUb+nGVSidaTxIT2f
 eJU5qBP6WlVua60QEw0l97Xtau7jFUGOzzieyv2KSorKtlGpFtpAbMTF/
 RyVjU0bWIy3qHGPmYhNG5JOZjj8MmSw7BJfdUku2ux7UPX9Ta6dRk8Gj1
 1W2CanTu4iNHr89vh60VK/GfuFhsIK9ki9zyTtwmCJdzopw4016xvUIn3
 gf1Jr/utmXssQ7mi03r2uyoSmQT+jfuww9pe5mfkx2V4aXaUTz+Co545n g==;
X-CSE-ConnectionGUID: KaY0AZiMRR+z4vUSPqj/rg==
X-CSE-MsgGUID: l5Nk3rZzRWWSE9jQBLL+Ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2283640"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2283640"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 00:15:49 -0800
X-CSE-ConnectionGUID: ElSZj6xMR0qN0ivd61hKxA==
X-CSE-MsgGUID: 19EBh9OaRUOEjPvYmKIq9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="7818703"
Received: from pae.iind.intel.com (HELO PAE-35.iind.intel.com) ([10.49.105.82])
 by fmviesa012.fm.intel.com with ESMTP; 02 Nov 2026 00:15:48 -0800
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>, stable@dpdk.org
Subject: [PATCH v2 6/7] net/ice: fix FDIR resource leak on setup failure
Date: Mon,  2 Nov 2026 08:10:36 +0000
Message-Id: <5dc2e08ba2c6d5b4132ff61acad9eda62704632d.1793605752.git.anurag.mandal@intel.com>
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

ice_fdir_setup() returns directly when the filter list or counter
initialization fails, leaking the FDIR VSI, plus the filter hash table
and map in the counter case. Its other error paths release the queues
and the VSI, but not the hash table, hash map or counter pools.

As fdir_vsi is reset on failure, ice_fdir_teardown() cannot release
them later either. The hash table name also stays registered, so the
next FDIR setup for the device fails.

Release everything set up so far on all error paths.

Fixes: 1a2fc1799f09 ("net/ice: reject duplicated flow for flow director")
Fixes: 0f880c3df192 ("net/ice: add flow director counter resource init/release")
Fixes: 84dc7a95a2d3 ("net/ice: enable flow director engine")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/ice_fdir_filter.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
index 2350bd5523..44604cfae6 100644
--- a/drivers/net/intel/ice/ice_fdir_filter.c
+++ b/drivers/net/intel/ice/ice_fdir_filter.c
@@ -477,13 +477,15 @@ ice_fdir_setup(struct ice_pf *pf)
 	err = ice_fdir_init_filter_list(pf);
 	if (err) {
 		PMD_DRV_LOG(ERR, "Failed to init FDIR filter list.");
-		return -EINVAL;
+		err = -EINVAL;
+		goto fail_filter_list;
 	}
 
 	err = ice_fdir_counter_init(pf);
 	if (err) {
 		PMD_DRV_LOG(ERR, "Failed to init FDIR counter.");
-		return -EINVAL;
+		err = -EINVAL;
+		goto fail_counter;
 	}
 
 	/*Fdir tx queue setup*/
@@ -554,6 +556,10 @@ ice_fdir_setup(struct ice_pf *pf)
 	ice_tx_queue_release(pf->fdir.txq);
 	pf->fdir.txq = NULL;
 fail_setup_tx:
+	ice_fdir_counter_release(pf);
+fail_counter:
+	ice_fdir_release_filter_list(pf);
+fail_filter_list:
 	ice_release_vsi(vsi);
 	pf->fdir.fdir_vsi = NULL;
 	return err;
-- 
2.25.1

