Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48E0606A31A
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 Oct 2026 13:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aVbcqd6i
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 34D2240663;
	Sat, 24 Oct 2026 15:50:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 26F2140663
 for <dev@dpdk.org>; Sat, 24 Oct 2026 15:50:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792849853; x=1824385853;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=k94sBFJzbG2cjqaFrnGWNTaKV3b1lX7Ce80WwnqyxdA=;
 b=aVbcqd6ioHC+nRw1D0VT9AalzBEAexxLjLbb1zEi7zP6BIRlD775KS4p
 BEOT0AOe7/cBIrVEGp4x7vd51EbCOZvtkm0Mdy63KyJyJGaRaOtQkE+so
 QFOutIF4bmb9l3qmpsPwifAI+zYC/Q8lSQ1Wxsu0kLsFH4V0qZ4yqsCFp
 lnHPzj629Rtf+1OPWo5n+dW45S+OEH2XdeacOR27cQk1PCpHroyx2zwkB
 3xw2c+DczfOIaBa02cNTk0IJ3N1G+CXCQGy4hg1E15UKLfXVEnyzu1moA
 /Pvuc0RXEa3MWhe5Y9jaA30sd1ePwa69EFqsz3vMu/DRQLYd+Vu6RKmg3 g==;
X-CSE-ConnectionGUID: Qdvh5P0IT92+Nrw4V6Grjw==
X-CSE-MsgGUID: XdtaCLNYSDOgj06q+smbQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11944"; a="1600819"
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="1600819"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2026 06:50:52 -0700
X-CSE-ConnectionGUID: oOIplNaoRuaceb6z+GI4FA==
X-CSE-MsgGUID: v2Y2BPy0SASWAdgUjKRYRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="4216675"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa008.fm.intel.com with ESMTP; 24 Oct 2026 06:50:53 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v3 3/5] ethdev: fix missing flow action descriptors
Date: Sat, 24 Oct 2026 14:50:30 +0100
Message-ID: <5fad64f9397f72b8eea7b50947059e38632e7d94.1792849824.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <5698ccb3daeebd1d50346d5a3bd8471468056463.1792849824.git.anatoly.burakov@intel.com>
References: 
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

RTE_FLOW_ACTION_TYPE_SHARED, RTE_FLOW_ACTION_TYPE_METER_COLOR and
RTE_FLOW_ACTION_TYPE_SKIP_CMAN were never added to
rte_flow_desc_action[]. The table uses designated initializers, so
these slots are zero filled: their name is NULL and their size is
zero.

As a result, RTE_FLOW_CONV_OP_ACTION_NAME on any of them passes a
NULL source to strlcpy(), and rte_flow_copy() as well as the action
conversion operations reject any action list containing one of them
as an unknown action type.

Add the missing descriptor entries.

Fixes: 4d9fd85fb545 ("ethdev: add shared actions to flow API")
Fixes: 5f0d54f372f0 ("ethdev: add pre-defined meter policy API")
Fixes: 6807e8b52a18 ("ethdev: skip congestion management configuration")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/ethdev/rte_flow.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c
index 6e544f4bc91..65d57717a05 100644
--- a/lib/ethdev/rte_flow.c
+++ b/lib/ethdev/rte_flow.c
@@ -324,6 +324,8 @@ static const struct rte_flow_desc_data rte_flow_desc_action[] = {
 	MK_FLOW_ACTION(SET_IPV6_DSCP, sizeof(struct rte_flow_action_set_dscp)),
 	MK_FLOW_ACTION(AGE, sizeof(struct rte_flow_action_age)),
 	MK_FLOW_ACTION(SAMPLE, sizeof(struct rte_flow_action_sample)),
+	/* Deprecated; handle stored in conf as for INDIRECT. */
+	MK_FLOW_ACTION(SHARED, 0),
 	MK_FLOW_ACTION(MODIFY_FIELD,
 		       sizeof(struct rte_flow_action_modify_field)),
 	/**
@@ -334,11 +336,13 @@ static const struct rte_flow_desc_data rte_flow_desc_action[] = {
 	 */
 	MK_FLOW_ACTION(INDIRECT, 0),
 	MK_FLOW_ACTION(CONNTRACK, sizeof(struct rte_flow_action_conntrack)),
+	MK_FLOW_ACTION(METER_COLOR, sizeof(struct rte_flow_action_meter_color)),
 	MK_FLOW_ACTION(PORT_REPRESENTOR, sizeof(struct rte_flow_action_ethdev)),
 	MK_FLOW_ACTION(REPRESENTED_PORT, sizeof(struct rte_flow_action_ethdev)),
 	MK_FLOW_ACTION(METER_MARK, sizeof(struct rte_flow_action_meter_mark)),
 	MK_FLOW_ACTION(SEND_TO_KERNEL, 0),
 	MK_FLOW_ACTION(QUOTA, sizeof(struct rte_flow_action_quota)),
+	MK_FLOW_ACTION(SKIP_CMAN, 0),
 	MK_FLOW_ACTION(IPV6_EXT_PUSH, sizeof(struct rte_flow_action_ipv6_ext_push)),
 	MK_FLOW_ACTION(IPV6_EXT_REMOVE, sizeof(struct rte_flow_action_ipv6_ext_remove)),
 	MK_FLOW_ACTION(INDIRECT_LIST,
-- 
2.52.0

