Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8E0606A323
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 09:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fbSTnanR
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7C1940BA0;
	Fri, 30 Oct 2026 10:41:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTPS id 747DF40B9D
 for <dev@dpdk.org>; Fri, 30 Oct 2026 10:41:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793353264; x=1824889264;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=I1J84hhaCI0TON8ZRbgjI2OCanHBsCnFB0aJDZlLf0s=;
 b=fbSTnanRj+wmVb6wC75vyq0jylWWbWH9zmO67+DR8vosXLu1OWfJom1Y
 Pfy0EJ0KIwvd0CGBMR8WDlIGCTsyhCM4T9tRsbyzfVHL9YEEOc/Wt+HyG
 XgiM2VqeUK+d1zn6KIqpni7WTl2bbK1kxtU+VXZXyB1tp1ZNd+BaxsCR0
 wteIg5CBEDYi6ML2a41pyJNsO5DyzCRIert6Yjv1ZkdTuMKduhB78P4ys
 XuZxfo+MTv87b1nwu26UGyxxoosKCbg8M9MctN3xFFIyHExHEgRqYcV6c
 ws0SkaOI671JJnvQQmTAr0yLEnhNuqBmvE40/T+zbq0SmyqJ35oLhTUTU A==;
X-CSE-ConnectionGUID: 0Lpdtp+FTH22LvlQVp4kdg==
X-CSE-MsgGUID: BJSP2nXmS8OCRwjILYVkEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2126071"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2126071"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 02:41:04 -0700
X-CSE-ConnectionGUID: qsBToxC9TgOGHzYxYfR2Gw==
X-CSE-MsgGUID: 3s9spZcFSw6uA3RJX98YOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5299661"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 30 Oct 2026 02:41:03 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 7/9] net/i40e: validate raw FDIR offsets and lengths
Date: Fri, 30 Oct 2026 09:40:20 +0000
Message-ID: <2b0130f65f1553dafc9d1432c94b29705a289e74.1793353214.git.anatoly.burakov@intel.com>
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

The FDIR RAW node only rejected absolute offsets when the relative
field was masked, and otherwise treated the offset as relative. It also
accepted odd lengths, but flexible payload is extracted in 2-byte
words, so the last byte was dropped from the match and the data of any
following RAW item was misaligned.

Reject absolute offsets regardless of the mask, and reject odd lengths.

Fixes: 05432a6e4676 ("net/i40e: reimplement FDIR parser")

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_flow_fdir.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_flow_fdir.c b/drivers/net/intel/i40e/i40e_flow_fdir.c
index b1dcc4b6fad..41298508582 100644
--- a/drivers/net/intel/i40e/i40e_flow_fdir.c
+++ b/drivers/net/intel/i40e/i40e_flow_fdir.c
@@ -754,7 +754,7 @@ i40e_fdir_node_raw_validate(const void *ctx, const struct rte_flow_item *item,
 	size_t spec_size, spec_offset;
 	size_t total_size, i;
 	size_t new_src_offset;
-	bool wants_offset, wants_search, wants_limit, wants_absolute;
+	bool wants_offset, wants_search, wants_limit;
 
 	if (raw_mask == NULL) {
 		return rte_flow_error_set(error, EINVAL,
@@ -788,6 +788,11 @@ i40e_fdir_node_raw_validate(const void *ctx, const struct rte_flow_item *item,
 				RTE_FLOW_ERROR_TYPE_ITEM, item,
 				"RAW mask length must match spec length or be 0xffff");
 	}
+	if (raw_spec->length % sizeof(uint16_t) != 0) {
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM, item,
+				"RAW length must be a multiple of 2 bytes");
+	}
 
 	/* control field masks must be all zero or all one */
 	if (!CI_FIELD_IS_ZERO_OR_MASKED(&raw_mask->offset) ||
@@ -799,7 +804,6 @@ i40e_fdir_node_raw_validate(const void *ctx, const struct rte_flow_item *item,
 	wants_offset = raw_mask->offset != 0;
 	wants_search = raw_mask->search != 0 && raw_spec->search != 0;
 	wants_limit = raw_mask->limit != 0 && raw_spec->limit != 0;
-	wants_absolute = raw_mask->relative != 0 && raw_spec->relative == 0;
 
 	/* Offset must be 16-bit aligned */
 	if (wants_offset && (raw_spec->offset % sizeof(uint16_t) != 0)) {
@@ -823,7 +827,7 @@ i40e_fdir_node_raw_validate(const void *ctx, const struct rte_flow_item *item,
 	}
 
 	/* only relative offsets are supported */
-	if (wants_absolute) {
+	if (raw_spec->relative == 0) {
 		return rte_flow_error_set(error, EINVAL,
 				RTE_FLOW_ERROR_TYPE_ITEM, item,
 				"RAW absolute offset not supported");
-- 
2.52.0

