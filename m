Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B96C83F03
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 14:31:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3DC7D40267;
	Thu,  3 Jul 2025 16:31:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 5D10640264
 for <dev@dpdk.org>; Thu,  3 Jul 2025 16:31:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751553110; x=1783089110;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Mh3VFlDJNSNQSpseeszqvgHg6doMLHWpoQAPIj+mRxM=;
 b=dKxlk6mXS/YzU9kw0d2W7lvEJCimSlxpJJygbw5c+YaZRgi+zFS8QrPV
 jn4JRtU8Aoq1sh2yRad8bLHqSVSBEs3ZXvSkauwADAhc4tbpm76TJ9IqC
 vUla8+zA9tvvutSDifEJi6a4S8q36yBGgDvgBFP6kfEIcUD/srPLfyAgg
 Cfy5gw1rKY7cye8WaLUOd1f7cQ0H6YNm27nLWfsH3ewJI+sRGDB6Bbiji
 M0WPA2FqnMqBaUG9mLpQdxDDMcthe2JNfOncCSyt1x+912XQ8VnK3wF+B
 2u+eNFz8esS/MRDLoMUwl4/3QuQ2F2wf//c7toGxcc0Ma57IzhtqFPrUW g==;
X-CSE-ConnectionGUID: E0d4AZvgSTy0exh8zyXDDA==
X-CSE-MsgGUID: 823Yt+jtQtOErvdUk0OvVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="57555097"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; d="scan'208";a="57555097"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 07:31:49 -0700
X-CSE-ConnectionGUID: 4+/e/UtlQKKG4vSHaTdiFw==
X-CSE-MsgGUID: l8vmo3OXSyGpKeFLGviJGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; d="scan'208";a="154021446"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by fmviesa007.fm.intel.com with ESMTP; 03 Jul 2025 07:31:47 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: ciara.loftus@intel.com,
	dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2] net/intel: deprecate some SSE paths
Date: Thu,  3 Jul 2025 14:31:19 +0000
Message-Id: <20250703143119.1140097-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250703121624.1050845-1-ciara.loftus@intel.com>
References: <20250703121624.1050845-1-ciara.loftus@intel.com>
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
 doc/guides/rel_notes/deprecation.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index e2d4125308..0d020c9c1f 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -80,6 +80,13 @@ Deprecation Notices
   and the header struct ``rte_vxlan_gpe_hdr`` with the macro ``RTE_ETHER_VXLAN_GPE_HLEN``
   will be removed in DPDK 25.11.
 
+* net/intel: drivers that have an SSE vector path alongside other vector paths,
+  namely i40e, iavf and ice, will have their SSE vector paths removed in DPDK 25.11.
+  Modern x86 systems all support AVX2, if not AVX-512, so the SSE path is no longer
+  widely used. This change will not result in any feature loss, as the fallback
+  scalar paths which have feature parity with SSE will be used in the cases where
+  the SSE paths would have been used.
+
 * ethdev: The flow API matching pattern structures, ``struct rte_flow_item_*``,
   should start with relevant protocol header structure from lib/net/.
   The individual protocol header fields and the protocol header struct
-- 
2.34.1

