Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C7F606A321
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 05:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=R9qicxLN
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E77140E21;
	Mon,  9 Nov 2026 06:43:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTPS id 7159C40689;
 Mon,  9 Nov 2026 06:43:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794203003; x=1825739003;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gyjN9gmSJbd6EpBDe+Bo3OsFGgnfDfbC8TQMRroC79w=;
 b=R9qicxLNhOBp2Y/HA+gG+Bysvs9eLusCjXGHQDasq7D9e7HUGFoFig6I
 ShvyTtmL1q0n4v8Yurn70E5Z2txrmVPUk018XlLnrs7UCiDWfmRR2IaWN
 LCeVBukN9UgL+KFUcpsmcyNoFHFgGH7WoNrC99D1GTX5fTBLn79gmsqLS
 lou1VR35VG4FEei4OVy13xFXUh5lnua6Xm2hhNhENJtnQiavUJ3fniVxF
 m9J1cNZ7dWStazD2AcWIpL4ZgLgPJbesvhNxx9WZL5N2DK/9m6CrKruI3
 bNI27Et7SnSWTYTfiSfgXVUPJyAmsVGPqmnaf53Xd07wTd49Kbu1c/ohx Q==;
X-CSE-ConnectionGUID: yp3KOKSVRY+DMyCbMPRWrQ==
X-CSE-MsgGUID: PE2XGUS8RSqi1uRpgeAotw==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2924117"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2924117"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Nov 2026 21:43:23 -0800
X-CSE-ConnectionGUID: c82NBv+MQcu/jpHCtjdfPw==
X-CSE-MsgGUID: zl6af6BmS46AO2BNTPoX+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="7948282"
Received: from pae-31.iind.intel.com ([10.49.105.68])
 by fmviesa002.fm.intel.com with ESMTP; 08 Nov 2026 21:43:21 -0800
From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
To: dev@dpdk.org
Cc: Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, stable@dpdk.org,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Subject: [PATCH 2/2] net/ice: fix DCF minimum API version log
Date: Mon,  9 Nov 2026 12:45:24 +0000
Message-Id: <20261109124524.115656-3-sandeep.penigalapati@intel.com>
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

The DCF error path that rejects a VIRTCHNL API version below
the minimum passes ICE_CPF_VIRTCHNL_VERSION_MAJOR_START for
both the major and the minor format arguments. The logged
minimum therefore repeats the major number. Pass
ICE_CPF_VIRTCHNL_VERSION_MINOR_START as the minor version.

Fixes: 7564d5509611 ("net/ice: add DCF hardware initialization")
Cc: stable@dpdk.org

Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
---
 drivers/net/intel/ice/ice_dcf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/ice_dcf.c b/drivers/net/intel/ice/ice_dcf.c
index 976f2ed260..48a5b9667c 100644
--- a/drivers/net/intel/ice/ice_dcf.c
+++ b/drivers/net/intel/ice/ice_dcf.c
@@ -334,7 +334,7 @@ ice_dcf_init_check_api_version(struct ice_dcf_hw *hw)
 		PMD_INIT_LOG(ERR,
 			     "VIRTCHNL API version should not be lower than (%u.%u)",
 			     ICE_CPF_VIRTCHNL_VERSION_MAJOR_START,
-			     ICE_CPF_VIRTCHNL_VERSION_MAJOR_START);
+			     ICE_CPF_VIRTCHNL_VERSION_MINOR_START);
 		return -1;
 	} else if (pver->major > VIRTCHNL_VERSION_MAJOR ||
 		   (pver->major == VIRTCHNL_VERSION_MAJOR &&
-- 
2.34.1

