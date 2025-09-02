Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1A6CA1007
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Sep 2025 17:27:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0D3C40674;
	Tue,  2 Sep 2025 19:27:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id C1DBD4065E;
 Tue,  2 Sep 2025 19:27:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756834046; x=1788370046;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=k0AqkMqkBtO38R79+jnP1R9TwbDwRCxGpyMUGF6RZmk=;
 b=LJ20VyJmE4BfEAp94eDeB8Xt03mzDJye1+KtCbADqYqKRaX1aho4bly3
 YXcxUdQgWqGE+PUG5ybTSslvKmasnUzx62RyVT9N8dTg1go72harCdIut
 NpSQ+rlBUKajZehGc2VYrctXHPhwoW12dqtMfTxzlH/5VW3NHjK5kcK+4
 FJ/7pbFQUFFqU3sY7iKsP42Fr3anS/fbke31GSkjPAuQmAO56urkpfspo
 TNeGXevvwsNBznIPNZVLS8f362w0UYPhRft7AQ9pFwMQYkjHkJCBVc8Wo
 jm2/prw/O7ZZv6aj0pr3pFrGZvFaYW22h7HZZ0xNGlC8VT4iZgEBYC3uG Q==;
X-CSE-ConnectionGUID: I52qJ03BSPGxVtLq0ogCuA==
X-CSE-MsgGUID: zeSVSCNfRNaWA2lf2WNw6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="69731981"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="69731981"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2025 10:27:16 -0700
X-CSE-ConnectionGUID: zRinVAN9QwKJQLpqX/h01g==
X-CSE-MsgGUID: Cjd+2M0pRii1tQqyGblmdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="171229110"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa007.jf.intel.com with ESMTP; 02 Sep 2025 10:27:16 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Qi Zhang <qi.z.zhang@intel.com>, Junfeng Guo <junfengg@nvidia.com>
Cc: stable@dpdk.org
Subject: [PATCH v1 03/12] net/ice/base: fix memory leak in HW profile handling
Date: Tue,  2 Sep 2025 18:26:53 +0100
Message-ID: <33597cac6faf31548d3a3e0a07eeb020b000479a.1756833701.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1756833701.git.anatoly.burakov@intel.com>
References: 
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

From: Jacob Keller <jacob.e.keller@intel.com>

The ice_flow_set_hw_prof() function allocates a params structure with
ice_malloc. It uses this structure to hold some data temporarily while
processing the hardware profile to set.

Static analysis indicated that this memory is not released. Fix this
function to free the memory upon exit.

Fixes: 8ebb93942b2c ("net/ice/base: add function to set HW profile for raw flow")
Cc: stable@dpdk.org

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ice/base/ice_flow.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/intel/ice/base/ice_flow.c b/drivers/net/intel/ice/base/ice_flow.c
index cdc9ee26c5..7b0ecd54df 100644
--- a/drivers/net/intel/ice/base/ice_flow.c
+++ b/drivers/net/intel/ice/base/ice_flow.c
@@ -2632,10 +2632,6 @@ ice_flow_set_hw_prof(struct ice_hw *hw, u16 dest_vsi_handle,
 
 	status = ice_flow_assoc_hw_prof(hw, blk, dest_vsi_handle,
 					fdir_vsi_handle, id);
-	if (status)
-		goto free_params;
-
-	return 0;
 
 free_params:
 	ice_free(hw, params);
-- 
2.47.3

