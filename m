Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD237606A325
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Nov 2026 11:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nFvaqFct
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2641402D6;
	Wed, 18 Nov 2026 12:57:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTPS id D13D240298;
 Wed, 18 Nov 2026 12:57:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795003062; x=1826539062;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Oy+pcMaFZKO2MFabFmB6E7cYJIubwh54lxNKIafGneI=;
 b=nFvaqFct8bZLK0+CJ8O4yPgV52wH69StSPYmYjp19kTuooK29SlqNrVz
 +P/QAsnixBsofe2Hd9hFZwR58HzEgkq6P+fqZF5Abs7S8cS3Dr6shSiDl
 tJqUGq5vYUEZ1Rbn73PN05zc0M2UjOxaFI7pE0x3JYVnhDKZbXO8LTFfU
 wJXpQZlrFW0pgQiYwIOleH8bZ9uNFAuKIddtulT/Uoj31eberWVYw/U8o
 J29c9M/HVQG38d9bwDHCwLGfb4iJjXagERSgtRaOXimYlR+/8KvnUYoS+
 iKhoBKUvmH09T8mfKtFe7q+Iwr7RI1W9bfYfVjcu9IbcIN2u87rPsF+Vx A==;
X-CSE-ConnectionGUID: eR9hRPxXRy+uq8POdzNrnQ==
X-CSE-MsgGUID: SmktL1R6TYWuvzWuQ+Ezww==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3694864"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3694864"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 03:57:28 -0800
X-CSE-ConnectionGUID: MtzPlldURvqVELsMDsr78Q==
X-CSE-MsgGUID: gUslzVpiRse5KA6aIuN+dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10268892"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 18 Nov 2026 03:57:27 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [PATCH] net/ice: fix silent drop of MAC addrs in ACL rules
Date: Wed, 18 Nov 2026 11:57:24 +0000
Message-ID: <20261118115724.2708792-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.55.0
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

For devices with 4 or more ports, the size of the ACL rules supported is
narrower, so MAC addresess are not handled there (see [1]). Reject such
rules in the ACL block rather than silently accepting them with missing
filter fields. Those rules can then be passed to other engines which may
be able to accept and correctly implement them.

[1] https://github.com/DPDK/dpdk/blob/main/drivers/net/intel/ice/ice_acl_filter.c#L170

Fixes: 40d466fa9f76 ("net/ice: support ACL filter in DCF")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/ice_acl_filter.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/intel/ice/ice_acl_filter.c b/drivers/net/intel/ice/ice_acl_filter.c
index 0f913126de..931c5469d2 100644
--- a/drivers/net/intel/ice/ice_acl_filter.c
+++ b/drivers/net/intel/ice/ice_acl_filter.c
@@ -998,6 +998,15 @@ ice_acl_parse(struct ice_adapter *ad,
 		goto error;
 	}
 
+	/* MAC fields are only in the ACL profile with fewer than 4 PFs */
+	if (ad->hw.dev_caps.num_funcs >= 4 &&
+			(input_set & (ICE_INSET_SMAC | ICE_INSET_DMAC)) != 0) {
+		ret = rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM_SPEC, pattern,
+				"MAC address match not supported by ACL on this device");
+		goto error;
+	}
+
 	ret = ice_acl_parse_action(&parsed_actions, filter, error);
 	if (ret)
 		goto error;
-- 
2.55.0

