Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30C6606A31E
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 09:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kY5uUg9F
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59F9040151;
	Tue, 27 Oct 2026 10:50:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTPS id 5B912400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 10:50:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793094637; x=1824630637;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=pegr5QMqtRM94m0YzDL9EuV1Tm4ysploZPWQjBstMi8=;
 b=kY5uUg9FvwtPirF/tMNoGk9b9T9o9RPAJtRlaIZsR5QNS15gueBUCxAJ
 SziPcyE3r8+QHDVd6C+0BS3olCQ2HoPtAwCVn6IDnonyBAjrVzqPriRL/
 p9sHSnY94oxZQrdK9l6ATcBHdF5d5TpSirYZLMRXe6EDBQknbzdnj65hA
 dOQ9Fa8mimepMYSTcJwsfxS/vAK0p0PYfao3z2QwkiVFSJ2OJxULjY1ua
 tJtTmFV0pkUk/yoLPsV4qDpVRCUKz0BcIPzXOVJDUkZWVE/ak+jJD6ssl
 ubuWRP8X5hb5bog/5ewlBltYIPqVSGFNPQDqu7rXrqwwG+FSOKea0Bb64 w==;
X-CSE-ConnectionGUID: 5DXUaS/fSxSgbkuN0sEm3A==
X-CSE-MsgGUID: m6+UaGEXRJuZvp57EByHUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1674909"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1674909"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 02:50:35 -0700
X-CSE-ConnectionGUID: FcWVw6x4R0K+/9igHm4dYg==
X-CSE-MsgGUID: BqcOlQlJT+K1Ep5kKSclGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="6250843"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa012.fm.intel.com with ESMTP; 27 Oct 2026 02:50:16 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Ori Kam <orika@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Adrien Mazarguil <adrien.mazarguil@6wind.com>,
 Nelio Laranjeiro <nelio.laranjeiro@6wind.com>
Subject: [PATCH v4 1/6] ethdev: fix flow conversion with null buffer
Date: Tue, 27 Oct 2026 09:50:08 +0000
Message-ID: <5698ccb3daeebd1d50346d5a3bd8471468056463.1793094528.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <8fa05595f3596e9355dd90df7fc278b104beb20b.1792757739.git.anatoly.burakov@intel.com>
References: <8fa05595f3596e9355dd90df7fc278b104beb20b.1792757739.git.anatoly.burakov@intel.com>
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

rte_flow_conv_pattern() and rte_flow_conv_actions() document that the
destination buffer may be NULL when the size is zero, which is how
callers query the number of bytes required before allocating. Both
functions nonetheless walked the destination with ++dst in the first
pass and dst -= num before the second, regardless of size.

Pointer arithmetic on a NULL pointer is undefined behavior, and is
reported by UBSan as "applying non-zero offset to null pointer" for
every RTE_FLOW_CONV_OP_PATTERN and RTE_FLOW_CONV_OP_ACTIONS size query.

Keep the destination pointer fixed and index it only inside the
size-guarded writes, which are never reached when size is zero.

Fixes: 063911ee1df4 ("ethdev: add flow API object converter")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/ethdev/rte_flow.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c
index 0ebf59165d4..704ed663c5f 100644
--- a/lib/ethdev/rte_flow.c
+++ b/lib/ethdev/rte_flow.c
@@ -921,7 +921,12 @@ rte_flow_conv_pattern(struct rte_flow_item *dst,
 	size_t ret;
 	unsigned int i;
 
-	for (i = 0, off = 0; !num || i != num; ++i, ++src, ++dst) {
+	/*
+	 * dst may be NULL when size is zero, so it is only ever indexed
+	 * inside the size-guarded writes below; pointer arithmetic on a
+	 * NULL pointer is undefined behavior.
+	 */
+	for (i = 0, off = 0; !num || i != num; ++i, ++src) {
 		/**
 		 * allow PMD private flow item
 		 */
@@ -932,7 +937,7 @@ rte_flow_conv_pattern(struct rte_flow_item *dst,
 				(error, ENOTSUP, RTE_FLOW_ERROR_TYPE_ITEM, src,
 				 "cannot convert unknown item type");
 		if (size >= off + sizeof(*dst))
-			*dst = (struct rte_flow_item){
+			dst[i] = (struct rte_flow_item){
 				.type = src->type,
 			};
 		off += sizeof(*dst);
@@ -941,8 +946,7 @@ rte_flow_conv_pattern(struct rte_flow_item *dst,
 	}
 	num = i;
 	src -= num;
-	dst -= num;
-	do {
+	for (i = 0; i != num; ++i, ++src) {
 		if (src->spec) {
 			off = RTE_ALIGN_CEIL(off, sizeof(double));
 			ret = rte_flow_conv_item_spec
@@ -950,7 +954,7 @@ rte_flow_conv_pattern(struct rte_flow_item *dst,
 				 size > off ? size - off : 0, src,
 				 RTE_FLOW_CONV_ITEM_SPEC);
 			if (size && size >= off + ret)
-				dst->spec = (void *)(data + off);
+				dst[i].spec = (void *)(data + off);
 			off += ret;
 
 		}
@@ -961,7 +965,7 @@ rte_flow_conv_pattern(struct rte_flow_item *dst,
 				 size > off ? size - off : 0, src,
 				 RTE_FLOW_CONV_ITEM_LAST);
 			if (size && size >= off + ret)
-				dst->last = (void *)(data + off);
+				dst[i].last = (void *)(data + off);
 			off += ret;
 		}
 		if (src->mask) {
@@ -971,12 +975,10 @@ rte_flow_conv_pattern(struct rte_flow_item *dst,
 				 size > off ? size - off : 0, src,
 				 RTE_FLOW_CONV_ITEM_MASK);
 			if (size && size >= off + ret)
-				dst->mask = (void *)(data + off);
+				dst[i].mask = (void *)(data + off);
 			off += ret;
 		}
-		++src;
-		++dst;
-	} while (--num);
+	}
 	return off;
 }
 
@@ -1014,7 +1016,12 @@ rte_flow_conv_actions(struct rte_flow_action *dst,
 	size_t ret;
 	unsigned int i;
 
-	for (i = 0, off = 0; !num || i != num; ++i, ++src, ++dst) {
+	/*
+	 * dst may be NULL when size is zero, so it is only ever indexed
+	 * inside the size-guarded writes below; pointer arithmetic on a
+	 * NULL pointer is undefined behavior.
+	 */
+	for (i = 0, off = 0; !num || i != num; ++i, ++src) {
 		/**
 		 * allow PMD private flow action
 		 */
@@ -1025,7 +1032,7 @@ rte_flow_conv_actions(struct rte_flow_action *dst,
 				(error, ENOTSUP, RTE_FLOW_ERROR_TYPE_ACTION,
 				 src, "cannot convert unknown action type");
 		if (size >= off + sizeof(*dst))
-			*dst = (struct rte_flow_action){
+			dst[i] = (struct rte_flow_action){
 				.type = src->type,
 			};
 		off += sizeof(*dst);
@@ -1034,8 +1041,7 @@ rte_flow_conv_actions(struct rte_flow_action *dst,
 	}
 	num = i;
 	src -= num;
-	dst -= num;
-	do {
+	for (i = 0; i != num; ++i, ++src) {
 		if (src->type == RTE_FLOW_ACTION_TYPE_INDIRECT) {
 			/*
 			 * Indirect action conf fills the indirect action
@@ -1043,19 +1049,17 @@ rte_flow_conv_actions(struct rte_flow_action *dst,
 			 * of duplicating the pointer memory.
 			 */
 			if (size)
-				dst->conf = src->conf;
+				dst[i].conf = src->conf;
 		} else if (src->conf) {
 			off = RTE_ALIGN_CEIL(off, sizeof(double));
 			ret = rte_flow_conv_action_conf
 				((void *)(data + off),
 				 size > off ? size - off : 0, src);
 			if (size && size >= off + ret)
-				dst->conf = (void *)(data + off);
+				dst[i].conf = (void *)(data + off);
 			off += ret;
 		}
-		++src;
-		++dst;
-	} while (--num);
+	}
 	return off;
 }
 
-- 
2.52.0

