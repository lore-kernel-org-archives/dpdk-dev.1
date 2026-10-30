Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514D6606A32F
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 09:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZZ6URcLU
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 244BC40B8F;
	Fri, 30 Oct 2026 10:41:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTPS id A234E40B9E
 for <dev@dpdk.org>; Fri, 30 Oct 2026 10:41:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793353261; x=1824889261;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=yEuq8JdEAWeec2PeJ6EC6BgiOk2TGnCmGfX2QR9gB5M=;
 b=ZZ6URcLU4m9+4o7oh4qxVzJviwZ2wYs64fZLvjlzs18WvJPWl/7Sc/vj
 Ay8H0ESRC41QDCaFri5Q2cjBsKm7+/VZ1xauvM+5jF9DAJY1wvEayYX8r
 50jR0845aAdmTxtIuxwYbS9ol9MTu1cKcgt7+6X6oKcMewbl5I8zyDHV+
 IaJlog+CyXRcmcNGNyedu1yt8RFVKJAoMMZ5CpL4bHsmlW5fmO8YeZw7l
 MaS20wiD3obNK6yBcYxnPTEsgsEDjqZ56rvQp1OnCWOFQ7mDIJeuYYiiM
 nXRj7YQ+NXGDIpmMQHsuzw8PnOPQoNolyXu88W3I3YGhOMkK+uIif4uPa Q==;
X-CSE-ConnectionGUID: WKVrx87QSqKUHNUMTmAy5w==
X-CSE-MsgGUID: fKsTEBcfTs2S43Hll8rOQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2126059"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2126059"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 02:41:01 -0700
X-CSE-ConnectionGUID: 42x9/iz1Q2GV8WTYnWhrjw==
X-CSE-MsgGUID: ZifuHaq3TeKLl9aHtOBkfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5299636"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 30 Oct 2026 02:41:00 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 6/9] net/i40e: fix SCTP verification tag truncation in FDIR
Date: Fri, 30 Oct 2026 09:40:19 +0000
Message-ID: <371a3ee9a8b844772c3ed68eb5409ac6edc2ab17.1793353214.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <5e64cc416c8ab3b038eee6bb55836e0b8ed507ab.1793353214.git.anatoly.burakov@intel.com>
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

The SCTP verification tag is a 32-bit field, but the FDIR SCTP node
stored its spec and mask in 16-bit variables, truncating the tag
programmed into the filter.

Fixes: 05432a6e4676 ("net/i40e: reimplement FDIR parser")

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_flow_fdir.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/i40e/i40e_flow_fdir.c b/drivers/net/intel/i40e/i40e_flow_fdir.c
index 0c9dce6fd9d..b1dcc4b6fad 100644
--- a/drivers/net/intel/i40e/i40e_flow_fdir.c
+++ b/drivers/net/intel/i40e/i40e_flow_fdir.c
@@ -684,7 +684,8 @@ i40e_fdir_node_sctp_process(void *ctx, const struct rte_flow_item *item,
 	struct i40e_fdir_filter *fdir_filter = &fdir_ctx->fdir_filter;
 	const struct rte_flow_item_sctp *sctp_spec = item->spec;
 	const struct rte_flow_item_sctp *sctp_mask = ci_flow_item_mask(item);
-	rte_be16_t src_spec, dst_spec, src_mask, dst_mask, tag_spec, tag_mask;
+	rte_be16_t src_spec, dst_spec, src_mask, dst_mask;
+	rte_be32_t tag_spec, tag_mask;
 	bool is_ipv4;
 
 	/* Set layer index for L4 flexible payload */
-- 
2.52.0

