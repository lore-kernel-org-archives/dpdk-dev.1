Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1879CC77B7C
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 12:16:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32A9D40267;
	Thu,  3 Jul 2025 14:16:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 5471E40264
 for <dev@dpdk.org>; Thu,  3 Jul 2025 14:16:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751544993; x=1783080993;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=umLoJVUcGw1G9SMFmks5bP0cgxVgvirjsZ5CaV9tIaQ=;
 b=E1W+y0qAZl/r5MAYcMhD3csMkHSHfsSbK5MSEzvWd92wN1wP0S7n14Ig
 ArlS4F4ju8L0/A+UShSfJK+fMqc78wmPBikMsbd9JzOqLhLsLqg7a2zbL
 iXLymsxJj6tGzM9zRdWpRfzT+1WBe1X4H3nElJ3M2dTxQl7lEk5alZAx5
 rQlMm+OjjqSE/Rk1PtLNmyG9F8/df4m0jN4yi4h6jzwr+tbb7OBU8kBFw
 aBxvjX/2EgfDwrva5rlIRJvsGgOavzsNXcdtltoZ/9YjLwGrdf2ahSx2T
 6MR+sxtmmgzQfyFbd90ytae6caxkJcc+FPcNPASX7iMngbV7HGgviAALO w==;
X-CSE-ConnectionGUID: 8zlI1ubASL2/q6XWGc7EEQ==
X-CSE-MsgGUID: ioJe8JnHTauQw2Up7Mt2vQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53587352"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; d="scan'208";a="53587352"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 05:16:31 -0700
X-CSE-ConnectionGUID: nrEqoykzQBKDucdrgQHw6Q==
X-CSE-MsgGUID: UGhp7BkhS92p2DfHNwYAOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; d="scan'208";a="153787198"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by orviesa006.jf.intel.com with ESMTP; 03 Jul 2025 05:16:30 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: ciara.loftus@intel.com,
	dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH] net/intel: deprecate some SSE paths
Date: Thu,  3 Jul 2025 12:16:24 +0000
Message-Id: <20250703121624.1050845-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

The SSE rx and tx paths will be removed from the i40e, iavf and ice
drivers in the 25.11 release. Each of these drivers have faster vector
paths (AVX2 and AVX-512) which have feature parity with the soon to be
removed SSE paths. In environments where AVX2 or AVX-512 are not
supported, the scalar path will still be used, which also has feature
parity.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 doc/guides/rel_notes/deprecation.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index e2d4125308..7b9b6beaa5 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -80,6 +80,11 @@ Deprecation Notices
   and the header struct ``rte_vxlan_gpe_hdr`` with the macro ``RTE_ETHER_VXLAN_GPE_HLEN``
   will be removed in DPDK 25.11.
 
+* net/intel: drivers that have an SSE vector path alongside other vector paths, namely
+  i40e, iavf and ice, will have their SSE vector paths removed in DPDK 25.11. This change
+  will not result in any feature loss, as the fallback scalar paths which have feature
+  parity with SSE will be used in the cases where the SSE paths would have been used.
+
 * ethdev: The flow API matching pattern structures, ``struct rte_flow_item_*``,
   should start with relevant protocol header structure from lib/net/.
   The individual protocol header fields and the protocol header struct
-- 
2.34.1

