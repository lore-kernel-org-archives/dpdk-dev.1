Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BD3F54ACF
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 15:56:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A383E40666;
	Tue, 24 Mar 2026 16:56:36 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 9AD634025F;
 Tue, 24 Mar 2026 16:56:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774367796; x=1805903796;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=7OAiGr+NgFVXPPu9lFHLOe2a41sxXZvODkAlsPrRed0=;
 b=VFALx+Qo2EM1IQNtGgLMi//5/csY4bWCYmADprLKph4e6RFiApkuVFnT
 B2ZYNGHuI/VPAuVy28dMp8/dR5cuBLQ89B1jS3flCOyJdtUU7GocYSNI5
 NmgKqD0bgm32p/bsq1udn+m/8xWXUtrjIkUzuY/PAvL56Ol8kmAXVItc4
 l2PwIcnM4OeAlxqvvL2ppA1rpqbumedmw1ohhhURQnKKQHa0WWAumDDV4
 gQJJgwbtC+l+0osx+qESumwoN5ZiWGF0S2RLgkIZ97X1m4j4tVElIsa9S
 HQYc+LNV+rcHumoLn1Dok5lXvC0IbR5SM6kvx5u21vBlczSutHrct1hEG A==;
X-CSE-ConnectionGUID: fqil1CSOQAiRB4aEcSdi/w==
X-CSE-MsgGUID: sZyEt2eJTrGTJg8IwpBkTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="79298204"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="79298204"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 08:56:34 -0700
X-CSE-ConnectionGUID: 1e/OvHzSTdmkRLeEZas7pA==
X-CSE-MsgGUID: DMNKn7xISvWKrSUzBSphmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="229311680"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa005.jf.intel.com with ESMTP; 24 Mar 2026 08:56:34 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH] net/i40e: fix raw flow item validation
Date: Tue, 24 Mar 2026 15:56:27 +0000
Message-ID: <20260324155627.1849904-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
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

Commit c138a6c3bd0a ("net/i40e: validate raw flow items before
dereferencing") rejected raw flow items when spec and mask length
fields differ, intending to prevent out-of-bounds pattern access.

This breaks flows using the default rte_flow_item_raw_mask, which
sets mask.length to 0xffff regardless of the spec pattern size. Remove
the erroneous check.

Fixes: c138a6c3bd0a ("net/i40e: validate raw flow items before dereferencing")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/i40e/i40e_flow.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index 84cfddb92d..78191a2d22 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -2360,13 +2360,6 @@ i40e_flow_parse_fdir_pattern(struct rte_eth_dev *dev,
 							   "NULL RAW mask pattern");
 					return -rte_errno;
 				}
-				if (raw_spec->length != raw_mask->length) {
-					rte_flow_error_set(error, EINVAL,
-							   RTE_FLOW_ERROR_TYPE_ITEM,
-							   item,
-							   "RAW spec and mask length mismatch");
-					return -rte_errno;
-				}
 			}
 
 			for (i = 0; i < raw_spec->length; i++) {
-- 
2.43.0

