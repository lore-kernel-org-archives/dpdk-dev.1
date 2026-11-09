Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80387606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 05:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Wz3Pa2oB
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5B7D406A2;
	Mon,  9 Nov 2026 06:43:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTPS id 6391240689;
 Mon,  9 Nov 2026 06:43:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794202999; x=1825738999;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mGCC+5GVI6OLsnd9ZptL1jCcmG1UNConvy2lqnChXO8=;
 b=Wz3Pa2oBCCQHyYB536z53/Mk59Cwz6x3kIejjPgy7r28NJkQ/WMSW04c
 PnhLiO4t6VPeqrC6I23cBb8GJet80RJznTu+HOBcgZpT3Npo4viIEUgRf
 X+nbSCmZcvGXWsJeO0DiiWaq7WvltbHPCJQhOjnpvf68H4NqyNKsBJn5W
 FKOy3TIucjAhMyRn7nN5fdYLLHNouHfmC10Ic+nEWfprqBD8/VCJaLkZA
 00KSuxW3UVolryePfUJESuoEv5t+vL6PLVKW2a7nbwg3RTs8a2mIkQOHf
 SeJGKSaKk4f/B07IA4Q1H8EWjQaED3y3hLwlZlnpYa/p4ewUVEgc0zgaf A==;
X-CSE-ConnectionGUID: 2dspo+qQTT2IiHOBewbjXQ==
X-CSE-MsgGUID: uqJTDi1SQmGUu0w+OtVeRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2924113"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2924113"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Nov 2026 21:43:19 -0800
X-CSE-ConnectionGUID: zrjqPLoSSzOMI9WAYIAWgg==
X-CSE-MsgGUID: tRF4U+fuRwe2pesZphoMDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="7948275"
Received: from pae-31.iind.intel.com ([10.49.105.68])
 by fmviesa002.fm.intel.com with ESMTP; 08 Nov 2026 21:43:17 -0800
From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
To: dev@dpdk.org
Cc: Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, stable@dpdk.org,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Subject: [PATCH 1/2] net/iavf: fix minimum API version log
Date: Mon,  9 Nov 2026 12:45:23 +0000
Message-Id: <20261109124524.115656-2-sandeep.penigalapati@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261109124524.115656-1-sandeep.penigalapati@intel.com>
References: <20261109124524.115656-1-sandeep.penigalapati@intel.com>
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_06_12,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The error path that rejects a VIRTCHNL API version below the
minimum supported by Adaptive VF passes
VIRTCHNL_VERSION_MAJOR_START for both the major and the minor
format arguments. The logged minimum therefore repeats the
major number. Pass VIRTCHNL_VERSION_MINOR_START as the minor
version.

Fixes: 22b123a36d07 ("net/avf: initialize PMD")
Cc: stable@dpdk.org

Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
---
 drivers/net/intel/iavf/iavf_vchnl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 34961fe654..f1354648cf 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -778,7 +778,7 @@ iavf_check_api_version(struct iavf_adapter *adapter)
 		PMD_INIT_LOG(ERR, "VIRTCHNL API version should not be lower"
 			     " than (%u.%u) to support Adaptive VF",
 			     VIRTCHNL_VERSION_MAJOR_START,
-			     VIRTCHNL_VERSION_MAJOR_START);
+			     VIRTCHNL_VERSION_MINOR_START);
 		return -1;
 	} else if (vf->virtchnl_version.major > VIRTCHNL_VERSION_MAJOR ||
 		   (vf->virtchnl_version.major == VIRTCHNL_VERSION_MAJOR &&
-- 
2.34.1

