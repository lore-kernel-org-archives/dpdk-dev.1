Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCE7606A320
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Nov 2026 11:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WKteGWJK
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C5CC40263;
	Fri, 20 Nov 2026 12:37:45 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTPS id 57FF840151
 for <dev@dpdk.org>; Fri, 20 Nov 2026 12:37:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795174664; x=1826710664;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=KyM3cXLTXGbkN94qj/SjPrtOSfGvy+ZRdOZlmQuDCBc=;
 b=WKteGWJKY4AE4Y/5VwdGcM4s64jMzIBT83sIVYIIT3T+1KpAymJ5CJ9D
 BnU37Oo5tVl5EyXSLeEPuuLCER4VGnhZ1tdx2TXzwsAXohPjRiX8kMCnz
 refBn2pxZXgYI1lzKOcUaEy8+5zt9Gfw9veB45mk6jWB9BWDKIFI8ZZhS
 Rja+XhqJbvCsWzGab64Eb1seVs2K/oUWKcQhLR0/x640ZQrLSp+t5pwt5
 KByDdHFOntufEo92kn6rCREyyC9ZA4tGuuxV/RHrKFGnm1Zw3j8vuU0P3
 wj71+R4q9kIt6xTPIh1iFVWIGwj33PraLf0AuEKa3ceMT6HOauH0suVlr w==;
X-CSE-ConnectionGUID: ZCtwlE52S6a2LzeQDcdPew==
X-CSE-MsgGUID: y5KZZrqASn63tNFv/BXjFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3935145"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="3935145"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 03:37:42 -0800
X-CSE-ConnectionGUID: ef4BFzHkQeyUuDzL7Fakyg==
X-CSE-MsgGUID: qm1cQ+dBQSu8ccLQc4rTIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; d="scan'208";a="10897992"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa002.fm.intel.com with ESMTP; 20 Nov 2026 03:37:40 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v1 1/1] net/ixgbe: reject duplicate FDIR fuzzy items
Date: Fri, 20 Nov 2026 11:37:37 +0000
Message-ID: <dc523a0ed953dc3defdb3427f50de8403af61e45.1795174649.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
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

The FDIR pattern pre-parser stops at the first FUZZY item, making
its duplicate check unreachable. Continue scanning so a second FUZZY
item would be rejected.

Coverity issue: 507457

Fixes: a3af16becec8 ("net/ixgbe: reimplement FDIR parser")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---

Notes:
    Note on CC to stable: this was only added in 26.11 but the fix will
    likely be deferred to 26.11.1 which is in fact a stable release.

 drivers/net/intel/ixgbe/ixgbe_flow_fdir.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow_fdir.c b/drivers/net/intel/ixgbe/ixgbe_flow_fdir.c
index 5e9f8593e51..593e614e1b2 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow_fdir.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow_fdir.c
@@ -1113,8 +1113,6 @@ ixgbe_fdir_pattern_parse(struct ci_flow_engine_ctx *ctx,
 
 		if (signature_match(item))
 			fdir_ctx->rule.mode = RTE_FDIR_MODE_SIGNATURE;
-
-		break;
 	}
 
 	return 0;
-- 
2.52.0

