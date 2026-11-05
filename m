Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E212606EE88
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 09:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LGqEluaL
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A973C40E26;
	Thu,  5 Nov 2026 10:53:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTPS id B0774402F2;
 Thu,  5 Nov 2026 10:53:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793872389; x=1825408389;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cwt10HOyf8Ysrc2eqlBk/mMVprQYbDULh+uOu0QpN84=;
 b=LGqEluaLCWJKp5KFdGKKePPVJmKW4XZI5ZSDgdFthKDrkuPEUrQZFCCO
 C9R0YD6H+zP7lpin7TZgMdGVxZBMmGkJ/qSARHrLZIytu3HZ7WqvhmlfR
 xZCsNkWtE8wh8GLR7GUzu8LcQ+PFYmbqj2RH8zR3JyNjSLUT+imUMdStf
 sfxkoSk/UY5cmWpwiUu2829xoPJ8mU2/FlrbtMWpVuxpWJwFg11U8RkvJ
 gN1Yle81gPIBgqxMqVWIy2NwZ3KSGA75a6/u88P9oYv/TwqFjRZl5qBVD
 31T90hMqIACf75Sf6Qx9J2h5NNdeN5LLAtftGpstZMJSc7/VnUn0Nutjg w==;
X-CSE-ConnectionGUID: 5DOgQW/xTg+rTTiY3xN7cQ==
X-CSE-MsgGUID: Ih1zV1a1Roi0h7/foUrlVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2683966"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2683966"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 01:53:07 -0800
X-CSE-ConnectionGUID: ruGFtijlRUGQXehz3fXJAw==
X-CSE-MsgGUID: D7ieKO0LRk+JUs3kxBbguw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7034282"
Received: from pae.iind.intel.com (HELO PAE-35.iind.intel.com) ([10.49.105.82])
 by orviesa006.jf.intel.com with ESMTP; 05 Nov 2026 01:53:05 -0800
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>, stable@dpdk.org
Subject: [PATCH 3/8] net/ice: fix DCF queue config buffer leak
Date: Thu,  5 Nov 2026 09:47:20 +0000
Message-Id: <8ccf28d179a10baa09fe9c3f04cb836b08afd069.1793871697.git.anurag.mandal@intel.com>
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

ice_dcf_configure_queues() returns -EINVAL without
freeing the virtchnl message it allocated when the
required Rx descriptor ID (RXDID) is not supported,
so the message leaks on each failed port start.

Free it before return.

Fixes: 4b0d391f0eab ("net/ice: add queue config in DCF")
Fixes: f3fddc93de16 ("net/ice: fix build with 16-byte Rx descriptor in DCF")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/ice/ice_dcf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/intel/ice/ice_dcf.c b/drivers/net/intel/ice/ice_dcf.c
index d87655c11d..09fcf6454f 100644
--- a/drivers/net/intel/ice/ice_dcf.c
+++ b/drivers/net/intel/ice/ice_dcf.c
@@ -1232,6 +1232,7 @@ ice_dcf_configure_queues(struct ice_dcf_hw *hw)
 				    "Queue[%d]", vc_qp->rxq.rxdid, i);
 		} else {
 			PMD_DRV_LOG(ERR, "RXDID 16 is not supported");
+			rte_free(vc_config);
 			return -EINVAL;
 		}
 #else
@@ -1244,6 +1245,7 @@ ice_dcf_configure_queues(struct ice_dcf_hw *hw)
 					"Queue[%d]", vc_qp->rxq.rxdid, i);
 		} else {
 			PMD_DRV_LOG(ERR, "RXDID == 0 is not supported");
+			rte_free(vc_config);
 			return -EINVAL;
 		}
 #endif
-- 
2.25.1

