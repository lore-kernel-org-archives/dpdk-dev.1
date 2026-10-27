Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9656606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 10:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AMeWzVFy
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D63440695;
	Tue, 27 Oct 2026 11:56:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTPS id 3D5C64068E
 for <dev@dpdk.org>; Tue, 27 Oct 2026 11:56:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793098599; x=1824634599;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+/qIm9B8MhUCfoLwOhUzmdTE7zBewMAWVxdkbq+29u8=;
 b=AMeWzVFySy5U4xqWqt53gQ6v9P7ph2Hgy9pMr0gTlCaXuS+64nV22G7n
 37tQ2rfmxmkgsM5WQJa6VCZy0QwD/Wq+glMhiHKT6K624o8x6qpHixhVg
 IsUGBQIshw0JP8UTj3/tu/JpTsMmBwCy07kIif7pZSaOf78EOgX1ZkbTq
 wo1wZMvhk7biEYJJNUZ4DWCbdvxN5Pg5G0g6M2GM/u3wO4UPoIcYDmE6z
 flqDEp5mpGE+FJlFfe4ijykbcYub9kVlKX6vyC2dN72mmXNc1OL8YQ0LJ
 ADab+0gOOAn5+lUO4jKtNlDEEegISToFMY8lOArd2ttoSGVOyoZDqYDDF w==;
X-CSE-ConnectionGUID: RHSEo9sKQ9qusekbqhXmrg==
X-CSE-MsgGUID: FAIqzl/MQWOMGwA+D3wwbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1679305"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1679305"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 03:56:38 -0700
X-CSE-ConnectionGUID: M0eVJ8QBSGKVD46Gws/NLA==
X-CSE-MsgGUID: aScHYqgeSK6NALhCdsMG3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4901474"
Received: from pae.iind.intel.com (HELO PAE-35.iind.intel.com) ([10.49.105.82])
 by fmviesa009.fm.intel.com with ESMTP; 27 Oct 2026 03:56:37 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH 6/7] net/ice: fix FDIR resource leak on setup failure
Date: Tue, 27 Oct 2026 10:51:36 +0000
Message-Id: <1c65a7b85cc16fb3286db9eb022521e177c4e241.1793097896.git.anurag.mandal@intel.com>
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

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
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

