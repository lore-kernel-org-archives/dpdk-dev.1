Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E6E606A326
	for <dpdk-dev@archiver.kernel.org>; Sat,  7 Nov 2026 23:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Gh6jP4wJ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8DA840E4B;
	Sun,  8 Nov 2026 00:57:32 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTPS id 2AF4740E49;
 Sun,  8 Nov 2026 00:57:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794095852; x=1825631852;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jYahlffnXgzXeimmSJiPke3KbyRc6INEjV0ZuD6tuXQ=;
 b=Gh6jP4wJVlBo6PqAxextsvljEL9hnU/U5xtoWH79uv+ZEgmBNe2gIKAN
 kDDkpZPhQWhX7rLxjg9NeSieQvt2w9D3LkebVK7CLjwIW35gEk/+lbA0/
 99Fch4/NWjKad2a0MEl3gRgPmakAGD3C+sDniJ/ApSElSClXJOQT9ZdrK
 /ITrIGyqxo11PGX58CoGKhSLUtft7YSA/ehSQNIIDLoEEZgrPC6kWRJdl
 Fg+ebyO6yQTUv8yae9pt3rmh01KZOq968DDbPY2susZkuvv8LBp9Wsz8Q
 etSJbe0fI9qHHK/lh26C93800j56zLcIjcfbXOTuLr8MZSS+pjKKJL3Vy Q==;
X-CSE-ConnectionGUID: ZCiqHoMKQWuA9pVfltVebA==
X-CSE-MsgGUID: uoVtoyxVRMexYO5KYUXkSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11959"; a="2885090"
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="2885090"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2026 15:57:31 -0800
X-CSE-ConnectionGUID: zu0yhdeoTOqyJPMmcqFUeA==
X-CSE-MsgGUID: ZieYl+rYSliQBqWnWASRhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="7464643"
Received: from pae.iind.intel.com (HELO PAE-35.iind.intel.com) ([10.49.105.82])
 by orviesa005.jf.intel.com with ESMTP; 07 Nov 2026 15:57:30 -0800
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>, stable@dpdk.org
Subject: [PATCH v2 4/8] net/ice: fix DCF QoS buffer leak on commit
Date: Sat,  7 Nov 2026 23:52:14 +0000
Message-Id: <5cbbbf8c0cfcc3f94ae22fbc4269e60702bcb6b1.1794094943.git.anurag.mandal@intel.com>
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

ice_dcf_hierarchy_commit() frees its temporary VF
and TC bandwidth buffers only on the error path,
so every successful commit still leaks them.

Free them on success as well.

Fixes: efd5d15a886b ("net/ice: fix memory leak in DCF QoS bandwidth config")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/ice_dcf_sched.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/intel/ice/ice_dcf_sched.c b/drivers/net/intel/ice/ice_dcf_sched.c
index 84342241aa..de28019c5b 100644
--- a/drivers/net/intel/ice/ice_dcf_sched.c
+++ b/drivers/net/intel/ice/ice_dcf_sched.c
@@ -849,6 +849,8 @@ static int ice_dcf_hierarchy_commit(struct rte_eth_dev *dev,
 		   ICE_NONDMA_TO_NONDMA);
 
 	hw->tm_conf.committed = true;
+	free(vf_bw);
+	free(tc_bw);
 	return ret_val;
 
 fail_clear:
-- 
2.25.1

