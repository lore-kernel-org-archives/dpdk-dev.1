Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91956606A31A
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 Oct 2026 13:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZpnTeDnv
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1BA504068A;
	Sat, 24 Oct 2026 15:51:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 0E572406FF
 for <dev@dpdk.org>; Sat, 24 Oct 2026 15:51:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792849861; x=1824385861;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=jVcB0S0lSd4cuZH/m3yBnmdi9i7ScjfV4cSZMD6nxlw=;
 b=ZpnTeDnvGZWYQ3Y9K1K7DmdYzeYNnYG0HXyzx7dLEx/18GiofrADCkAY
 W+U2vsp68MHdhIs9tzGB7ypEln5SxQZfJQVEplTsixvMgZ9kjUOfcF/zr
 J2H2Onl9Uv1AbsCQxDz9OSf+AWkSsU+ZT0DIlw6Nq1P7G/y6BW4+bRJCg
 QJSWaj6Ha9FJygnL4od/cu+VDcSoA2t+G5vsKUS/IPRFoET9L97H20bxW
 y1Zhoc/543w8e9brNAi2LZG/vOyAybVyTI9I11tnv85M/FPHnQvEqXt06
 bQ1ud6+dlGu098MX2dOKhWuUjh1RRJl1AeyiV1DG5O1cZshQ3NbvXVJa2 Q==;
X-CSE-ConnectionGUID: +tJPklkDShCFF3JoMek2pQ==
X-CSE-MsgGUID: cUOaMXCyR7iw/23yGtnwaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11944"; a="1600827"
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="1600827"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2026 06:51:00 -0700
X-CSE-ConnectionGUID: 088HrgFRT+KAoFQ/t0N2HQ==
X-CSE-MsgGUID: PBkUsRGWRTyN6YaPFGrZeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="4216699"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa008.fm.intel.com with ESMTP; 24 Oct 2026 06:50:59 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v3 5/5] ethdev: add flow item structure size query
Date: Sat, 24 Oct 2026 14:50:32 +0100
Message-ID: <4c7712b6e63113a23cf8c5f9d5126b628054149a.1792849825.git.anatoly.burakov@intel.com>
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

Add RTE_FLOW_CONV_OP_ITEM_SIZE to retrieve the fixed specification
structure size for a flow item type using the existing descriptor table.

Lookups by type now also reject item types that have no descriptor
entry, instead of returning a NULL name or passing NULL to strlcpy().

Extend the flow conversion unit test to cover the new operation.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 app/test/test_ethdev_flow_conv.c       | 92 ++++++++++++++++++++++++++
 doc/guides/rel_notes/release_26_11.rst |  8 ++-
 lib/ethdev/rte_flow.c                  | 27 +++++++-
 lib/ethdev/rte_flow.h                  | 18 +++++
 4 files changed, 140 insertions(+), 5 deletions(-)

diff --git a/app/test/test_ethdev_flow_conv.c b/app/test/test_ethdev_flow_conv.c
index 104b02dbeb6..79fded8c55f 100644
--- a/app/test/test_ethdev_flow_conv.c
+++ b/app/test/test_ethdev_flow_conv.c
@@ -21,6 +21,92 @@
 /* Guaranteed to be out of range of every descriptor table. */
 #define BOGUS_TYPE INT32_MAX
 
+static int
+item_size(int type, size_t *size, struct rte_flow_error *error)
+{
+	return rte_flow_conv(RTE_FLOW_CONV_OP_ITEM_SIZE, size, sizeof(*size),
+			     RTE_CAST_PTR(const void *, type), error);
+}
+
+static int
+test_flow_conv_item_size(void)
+{
+	struct rte_flow_error error;
+	size_t size;
+	int ret;
+
+	struct {
+		int type;
+		size_t expected;
+	} const known[] = {
+		{ RTE_FLOW_ITEM_TYPE_END, 0 },
+		{ RTE_FLOW_ITEM_TYPE_VOID, 0 },
+		{ RTE_FLOW_ITEM_TYPE_INVERT, 0 },
+		{ RTE_FLOW_ITEM_TYPE_ETH, sizeof(struct rte_flow_item_eth) },
+		{ RTE_FLOW_ITEM_TYPE_IPV4, sizeof(struct rte_flow_item_ipv4) },
+		{ RTE_FLOW_ITEM_TYPE_GRE_KEY, sizeof(rte_be32_t) },
+		{ RTE_FLOW_ITEM_TYPE_GTPC, sizeof(struct rte_flow_item_gtp) },
+		{ RTE_FLOW_ITEM_TYPE_MACSEC,
+		  sizeof(struct rte_flow_item_macsec) },
+		{ RTE_FLOW_ITEM_TYPE_COMPARE,
+		  sizeof(struct rte_flow_item_compare) },
+	};
+
+	for (unsigned int i = 0; i < RTE_DIM(known); i++) {
+		size = SIZE_MAX;
+		ret = item_size(known[i].type, &size, &error);
+		TEST_ASSERT_EQUAL(ret, (int)sizeof(size_t),
+				  "item type %d: unexpected return %d",
+				  known[i].type, ret);
+		TEST_ASSERT_EQUAL(size, known[i].expected,
+				  "item type %d: size %zu, expected %zu",
+				  known[i].type, size, known[i].expected);
+	}
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_flow_conv_item_size_errors(void)
+{
+	struct rte_flow_error error;
+	size_t size;
+	int ret;
+
+	/* Out of range type. */
+	memset(&error, 0, sizeof(error));
+	rte_errno = 0;
+	ret = item_size(BOGUS_TYPE, &size, &error);
+	TEST_ASSERT_EQUAL(ret, -EINVAL, "unexpected return %d", ret);
+	TEST_ASSERT_EQUAL(rte_errno, EINVAL, "rte_errno %d", rte_errno);
+	TEST_ASSERT_EQUAL(error.type, RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
+			  "unexpected error type %d", error.type);
+	TEST_ASSERT_NOT_NULL(error.message, "error message not set");
+
+	/* PMD private type. */
+	rte_errno = 0;
+	ret = item_size(-1, &size, &error);
+	TEST_ASSERT_EQUAL(ret, -EINVAL, "unexpected return %d", ret);
+	TEST_ASSERT_EQUAL(rte_errno, EINVAL, "rte_errno %d", rte_errno);
+
+	/* Destination too small: nothing written, size still reported. */
+	size = SIZE_MAX;
+	ret = rte_flow_conv(RTE_FLOW_CONV_OP_ITEM_SIZE, &size,
+			    sizeof(size) - 1,
+			    RTE_CAST_PTR(const void *, RTE_FLOW_ITEM_TYPE_ETH), &error);
+	TEST_ASSERT_EQUAL(ret, (int)sizeof(size_t), "unexpected return %d",
+			  ret);
+	TEST_ASSERT_EQUAL(size, SIZE_MAX, "destination was written");
+
+	/* NULL destination with zero size is a pure size query. */
+	ret = rte_flow_conv(RTE_FLOW_CONV_OP_ITEM_SIZE, NULL, 0,
+			    RTE_CAST_PTR(const void *, RTE_FLOW_ITEM_TYPE_ETH), &error);
+	TEST_ASSERT_EQUAL(ret, (int)sizeof(size_t), "unexpected return %d",
+			  ret);
+
+	return TEST_SUCCESS;
+}
+
 static int
 test_flow_conv_item_name(void)
 {
@@ -158,6 +244,7 @@ test_flow_conv_tables_complete(void)
 {
 	struct rte_flow_error error;
 	const char *name;
+	size_t size;
 	int ret;
 
 	for (int type = 0; type <= LAST_ITEM_TYPE; type++) {
@@ -167,6 +254,9 @@ test_flow_conv_tables_complete(void)
 		TEST_ASSERT_EQUAL(ret, (int)sizeof(const char **),
 				  "item type %d has no descriptor", type);
 		TEST_ASSERT_NOT_NULL(name, "item type %d has no name", type);
+		ret = item_size(type, &size, &error);
+		TEST_ASSERT_EQUAL(ret, (int)sizeof(size_t),
+				  "item type %d (%s) has no size", type, name);
 	}
 
 	for (int type = 0; type <= LAST_ACTION_TYPE; type++) {
@@ -341,6 +431,8 @@ static struct unit_test_suite flow_conv_testsuite = {
 	.setup = NULL,
 	.teardown = NULL,
 	.unit_test_cases = {
+		TEST_CASE(test_flow_conv_item_size),
+		TEST_CASE(test_flow_conv_item_size_errors),
 		TEST_CASE(test_flow_conv_item_name),
 		TEST_CASE(test_flow_conv_action_name),
 		TEST_CASE(test_flow_conv_item_default_mask),
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 9259954c0f7..f3755bf7ab5 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -113,10 +113,12 @@ New Features
   loss of lock and Tx fault flags.
   The SFF-8472 decoder also reports the Rx loss of signal and Tx fault state.
 
-* **Added flow item default mask lookup.**
+* **Added flow item default mask and size lookup.**
 
-  Added ``RTE_FLOW_CONV_OP_ITEM_DEFAULT_MASK_PTR`` conversion operation
-  to ``rte_flow_conv()`` to retrieve the default mask of a flow item type.
+  Added ``RTE_FLOW_CONV_OP_ITEM_DEFAULT_MASK_PTR`` and
+  ``RTE_FLOW_CONV_OP_ITEM_SIZE`` conversion operations
+  to ``rte_flow_conv()`` to retrieve the default mask
+  and the specification structure size of a flow item type.
 
 * **Added internal ethdev flow graph parser helper API.**
 
diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c
index 65d57717a05..4102bbe5f2a 100644
--- a/lib/ethdev/rte_flow.c
+++ b/lib/ethdev/rte_flow.c
@@ -1182,7 +1182,7 @@ rte_flow_conv_name(int is_action,
 	const struct desc_info *const info = &info_rep[!!is_action];
 	unsigned int type = (uintptr_t)src;
 
-	if (type >= info->num)
+	if (type >= info->num || info->data[type].name == NULL)
 		return rte_flow_error_set
 			(error, EINVAL, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
 			 "unknown object type to retrieve the name of");
@@ -1202,7 +1202,8 @@ rte_flow_conv_item_default_mask(void *dst,
 {
 	unsigned int type = (uintptr_t)src;
 
-	if (type >= RTE_DIM(rte_flow_desc_item))
+	if (type >= RTE_DIM(rte_flow_desc_item) ||
+	    rte_flow_desc_item[type].name == NULL)
 		return rte_flow_error_set
 			(error, EINVAL, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
 			 "unknown item type to retrieve the default mask of");
@@ -1211,6 +1212,25 @@ rte_flow_conv_item_default_mask(void *dst,
 	return sizeof(const void **);
 }
 
+/** Retrieve the specification structure size of a flow item type. */
+static int
+rte_flow_conv_item_size(void *dst,
+			const size_t size,
+			const void *src,
+			struct rte_flow_error *error)
+{
+	unsigned int type = (uintptr_t)src;
+
+	if (type >= RTE_DIM(rte_flow_desc_item) ||
+	    rte_flow_desc_item[type].name == NULL)
+		return rte_flow_error_set
+			(error, EINVAL, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+			 "unknown item type to retrieve the size of");
+	if (size >= sizeof(size_t))
+		*(size_t *)dst = rte_flow_desc_item[type].size;
+	return sizeof(size_t);
+}
+
 /** Helper function to convert flow API objects. */
 RTE_EXPORT_SYMBOL(rte_flow_conv)
 int
@@ -1275,6 +1295,9 @@ rte_flow_conv(enum rte_flow_conv_op op,
 	case RTE_FLOW_CONV_OP_ITEM_DEFAULT_MASK_PTR:
 		ret = rte_flow_conv_item_default_mask(dst, size, src, error);
 		break;
+	case RTE_FLOW_CONV_OP_ITEM_SIZE:
+		ret = rte_flow_conv_item_size(dst, size, src, error);
+		break;
 	default:
 		ret = rte_flow_error_set
 		(error, ENOTSUP, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
diff --git a/lib/ethdev/rte_flow.h b/lib/ethdev/rte_flow.h
index df8101e4395..ff1ffd03e73 100644
--- a/lib/ethdev/rte_flow.h
+++ b/lib/ethdev/rte_flow.h
@@ -4426,6 +4426,24 @@ enum rte_flow_conv_op {
 	 *   @code const void ** @endcode
 	 */
 	RTE_FLOW_CONV_OP_ITEM_DEFAULT_MASK_PTR,
+
+	/**
+	 * Retrieve the fixed size of an item specification structure.
+	 *
+	 * Writes the size of the item specification structure to @p dst,
+	 * or zero for known item types without one. Does not include
+	 * variable-length or externally referenced data (for example, RAW
+	 * pattern bytes). Unknown and PMD-private item types return an error.
+	 *
+	 * No output is written if @p size is smaller than sizeof(size_t).
+	 * The return value is sizeof(size_t), not the item structure size.
+	 *
+	 * - @p src type:
+	 *   @code (const void *)(uintptr_t)enum rte_flow_item_type @endcode
+	 * - @p dst type:
+	 *   @code size_t * @endcode
+	 */
+	RTE_FLOW_CONV_OP_ITEM_SIZE,
 };
 
 /**
-- 
2.52.0

