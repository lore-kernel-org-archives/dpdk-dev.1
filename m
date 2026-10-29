Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30AF606A331
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Oct 2026 16:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ikNsQVjW
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9996E4067A;
	Thu, 29 Oct 2026 17:41:28 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTPS id C7B62400D6
 for <dev@dpdk.org>; Thu, 29 Oct 2026 17:41:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793292085; x=1824828085;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=jNBqj7JbiPcFxW4ecIOU5o74FnavEZHpE+9UuWzuaWA=;
 b=ikNsQVjWEonALuyA0hAdq85MR7HX3lCCLF0bGn32VILJgDfKkygTmmul
 vF6gGD7n0lbMa/d++URBQ4xeJCp0DPeMvlbTB4E4AmBr/kHYdkt0xlLjy
 NOxpOSMHicqhoTQCvdRjuQ2XaTvr8a+l+MSnJn7SEda/J9dWP/qI810uF
 YKVncnmA9mFzfE31W1SYbEKcJ9eXH86o3xv0G+m2BsZEPGhytEcCysP4V
 dzcF7s9Sd0K5448EYdRN1Qa1tbC9VhcMlJvkV56RHDFVvNlJYDCcfmYJm
 I4x6PlR/sLlTwomZFgA9FHGmu7Rh7J+wRNT6NLHITicHEibEwKYGwtcRZ Q==;
X-CSE-ConnectionGUID: UYCCnyW3Td2qohlowtvznQ==
X-CSE-MsgGUID: WY6IEHxiStWZPYF/efOGuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="1954952"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1954952"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 09:41:02 -0700
X-CSE-ConnectionGUID: XGwu9zwHQHm25gGwj80sCw==
X-CSE-MsgGUID: YtPOWZSTSCys/cPxbczIWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5280313"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa009.jf.intel.com with ESMTP; 29 Oct 2026 09:41:01 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v1 2/4] net/ixgbe: fix FDIR IPv6 address mask validation
Date: Thu, 29 Oct 2026 16:40:56 +0000
Message-ID: <12fe46ce9793387f3c023f2d8472e336ade15b72.1793292050.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <9c545ac681db1bd835a88516322c1441951e3ed6.1793292050.git.anatoly.burakov@intel.com>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Flow director masks IPv6 addresses per byte, but the parser only accepts
masks that cover either the whole address or none of it.

Accept masks where each byte is either fully masked or unmasked.

Fixes: ea0f9067b2cf ("net/ixgbe: reimplement FDIR parser")

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_flow_fdir.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow_fdir.c b/drivers/net/intel/ixgbe/ixgbe_flow_fdir.c
index 13df5eea810..9c9dc8846fa 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow_fdir.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow_fdir.c
@@ -207,6 +207,7 @@ ixgbe_validate_fdir_normal_ipv6(const void *ctx,
 	const struct ixgbe_fdir_ctx *fdir_ctx = ctx;
 	const struct rte_flow_item_ipv6 *ipv6_mask = ci_flow_item_mask(item);
 	const struct ixgbe_fdir_rule *rule = &fdir_ctx->rule;
+	uint8_t i;
 
 	if (rule->mode == RTE_FDIR_MODE_PERFECT_MAC_VLAN) {
 		return rte_flow_error_set(error, EINVAL,
@@ -229,15 +230,13 @@ ixgbe_validate_fdir_normal_ipv6(const void *ctx,
 				"Only src/dst addresses supported");
 	}
 
-	if (!CI_FIELD_IS_ZERO_OR_MASKED(&ipv6_mask->hdr.src_addr)) {
-		return rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM, item,
-				"Partial src address masks not supported");
-	}
-	if (!CI_FIELD_IS_ZERO_OR_MASKED(&ipv6_mask->hdr.dst_addr)) {
-		return rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_ITEM, item,
-				"Partial dst address masks not supported");
+	for (i = 0; i < sizeof(ipv6_mask->hdr.src_addr); i++) {
+		if (!CI_FIELD_IS_ZERO_OR_MASKED(&ipv6_mask->hdr.src_addr.a[i]) ||
+		    !CI_FIELD_IS_ZERO_OR_MASKED(&ipv6_mask->hdr.dst_addr.a[i])) {
+			return rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ITEM, item,
+					"Partial address byte masks not supported");
+		}
 	}
 
 	return 0;
-- 
2.52.0

