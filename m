Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3D6606BE10
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Nov 2026 11:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hFUraWxk
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47EA940297;
	Mon, 16 Nov 2026 12:15:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTPS id 704AE400EF;
 Mon, 16 Nov 2026 12:15:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794827723; x=1826363723;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=w6sSh38JW+LhVxrwFFDMWmBSV/gUzF31lggjvRT+S0E=;
 b=hFUraWxkgQlM3SM881ik9FHxUufjdwEqLk+oRuUGUIheITmqg1IU0ujf
 oWlDyt/vWpgBLsFAlIr11Buga9V+ueljv3bV2OQyNiElVZyrGtnzLLKRy
 UaT+EdMlWrM4aaDVRyIZOg4Kzl15mvea4ed2RaYpc1UJExnlhiRoZlN1H
 y+ZKZc6rtpslAW98y1vBmYWN6dzGKziNL/Fs9OJ7b1D9hovGZp9W30sWV
 8m7b4O05cBwO6Ai4X9WCCb8kIIJMB4bPsYjs/wVhhBvpDvt3R4XztBNU0
 FBCrry7MVd6z9tYkuVTQPDQxYPsJlF0Q7Ql8TLq7GZcWzbdCeaRLZvz3D g==;
X-CSE-ConnectionGUID: ahApqnioT+OqcqJgNPD3pQ==
X-CSE-MsgGUID: z2LUYA95Tym9V0302kGbYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3454855"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3454855"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 03:15:15 -0800
X-CSE-ConnectionGUID: TLj4HLSYTGqLFS34qiMUBg==
X-CSE-MsgGUID: vksI8hURSoSf3Fqw5PxAFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9932172"
Received: from silpixa00401921.ir.intel.com (HELO vm-gnr921..) ([10.20.224.96])
 by fmviesa007.fm.intel.com with ESMTP; 16 Nov 2026 03:15:15 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH] net/ixgbe: fix integer overflow in n-tuple filter mask
Date: Mon, 16 Nov 2026 11:14:50 +0000
Message-ID: <20261116111450.9700-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
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

The uint8_t 5-tuple mask is promoted to a signed int before being
shifted by IXGBE_FTQF_5TUPLE_MASK_SHIFT (25). The result does not fit in
32 bits, which is undefined behaviour for a signed type. In practice it is
harmless since the bit that is lost does not contain any useful
information. Regardless it should be fixed instead of relying on the
undefined behaviour.

Fix it by casting the mask to uint32_t before the shift. For an unsigned
type the result keeps only the low 32 bits, so the programmed value is
unchanged.

Coverity issue: 507466

Fixes: 76db0ac63987 ("ixgbe: add filters")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 7592031217..c81802c04c 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -6413,7 +6413,7 @@ ixgbe_ntuple_filter_program(struct ixgbe_hw *hw, uint16_t index,
 		mask &= IXGBE_FTQF_DEST_PORT_MASK;
 	if (filter_info->proto_mask == 0)
 		mask &= IXGBE_FTQF_PROTOCOL_COMP_MASK;
-	ftqf |= mask << IXGBE_FTQF_5TUPLE_MASK_SHIFT;
+	ftqf |= (uint32_t)mask << IXGBE_FTQF_5TUPLE_MASK_SHIFT;
 	ftqf |= IXGBE_FTQF_POOL_MASK_EN;
 	ftqf |= IXGBE_FTQF_QUEUE_ENABLE;
 
-- 
2.43.0

