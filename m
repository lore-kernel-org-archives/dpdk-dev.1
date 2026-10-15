Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF597CC6B34
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 08:03:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68F504025A;
	Thu, 15 Oct 2026 10:03:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 2DDBA40041
 for <dev@dpdk.org>; Thu, 15 Oct 2026 10:03:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792051387; x=1823587387;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=oBZdoX1r8LFL/sZwzYMYydxQPKmnzxPoTZ6tHiX3zdg=;
 b=dBCG6WW9iF1ljXmb5JEeOiAAslhovFYQU3yWyIWSTNYmjsD4STYLGLvN
 oVoyTS4uPtaDhbO5g+JevMc2N3wSpWkNSxD/yj6q5typBxHtYEkLTqmw9
 ygkxEyaKsoQlOgsqpuyGr3QBokSNFWsgrXQMFIgzPb9JJi7+ZhyPXDmsa
 IxZeqLidg5SfHgavNkfxpElVB8+BK7kQs9BT7uTXNklwHPq6fYF518OJc
 g+AABH4j/wisi+c/iPu5CUTcytlHR1v6EvtOUracAD2h2inzc23uI2FeI
 yATXUnSj0+MujLEyT3WBOKMhmPDvzq6/kSnzGe3jpa5jl1CgzUIRA4qsZ g==;
X-CSE-ConnectionGUID: cnjHqR0SRP26TN65UwVbFA==
X-CSE-MsgGUID: /jLLwdS3QLWwfrHtBKnztg==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="700462"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="700462"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 01:03:05 -0700
X-CSE-ConnectionGUID: 7cWuQHCST5mC7jld9gBw4A==
X-CSE-MsgGUID: U9mXgKlZS/2DgEg0uGmGFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="1728544"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa002.fm.intel.com with ESMTP; 15 Oct 2026 01:03:04 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 1/1] net/i40e: fix compile issue in raw parsing
Date: Thu, 15 Oct 2026 09:02:59 +0100
Message-ID: <9e8c2ae1de56389366cbbbc2bf92492e732c3344.1792051372.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
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

When parsing RAW items, we iterate over previously parsed RAW items. They
are sized by an enum, but we should not be using an enum for indexing and
comparing it against an uint8_t RAW ID. Fix it by using uint8_t instead.

Fixes: c8f6ee59ffe6 ("net/i40e: reimplement FDIR parser")

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_flow_fdir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_flow_fdir.c b/drivers/net/intel/i40e/i40e_flow_fdir.c
index cd377b218b..55997295ed 100644
--- a/drivers/net/intel/i40e/i40e_flow_fdir.c
+++ b/drivers/net/intel/i40e/i40e_flow_fdir.c
@@ -799,7 +799,7 @@ i40e_fdir_node_raw_validate(const void *ctx, const struct rte_flow_item *item,
 	const struct i40e_fdir_filter *fdir_filter = &fdir_ctx->fdir_filter;
 	const struct rte_flow_item_raw *raw_spec = item->spec;
 	const struct rte_flow_item_raw *raw_mask = item->mask;
-	enum i40e_flxpld_layer_idx raw_id = fdir_filter->input.flow_ext.raw_id;
+	uint8_t raw_id = fdir_filter->input.flow_ext.raw_id;
 	size_t spec_size, spec_offset;
 	size_t total_size, i;
 	size_t new_src_offset;
@@ -932,7 +932,7 @@ i40e_fdir_node_raw_process(void *ctx,
 	struct i40e_fdir_filter *fdir_filter = &fdir_ctx->fdir_filter;
 	const struct rte_flow_item_raw *raw_spec = item->spec;
 	const struct rte_flow_item_raw *raw_mask = item->mask;
-	enum i40e_flxpld_layer_idx raw_id = fdir_filter->input.flow_ext.raw_id;
+	uint8_t raw_id = fdir_filter->input.flow_ext.raw_id;
 	enum i40e_flxpld_layer_idx layer_idx = fdir_filter->input.flow_ext.layer_idx;
 	struct i40e_fdir_flex_pit *flex_pit;
 	size_t spec_size, spec_offset, i;
-- 
2.52.0

