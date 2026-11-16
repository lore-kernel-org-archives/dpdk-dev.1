Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05D4606A322
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Nov 2026 16:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mF8K/9IN
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FF46402A4;
	Mon, 16 Nov 2026 17:09:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTPS id ECD0440150
 for <dev@dpdk.org>; Mon, 16 Nov 2026 17:09:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794845381; x=1826381381;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=66EH3J9EVPLt19AKPkU42cRTMS1V2Rh7smpBUedqGNA=;
 b=mF8K/9INLSVhue9CMaVLZHPc8uagS7H/13v7Uyz7qqlPtibSDwRY6nR6
 NW/3vBdQ/Hxa3lnG2w2XAh+znfMs3PTViRSq7D2XhWMf8/K7ab7Qhx7GN
 N0AhHY4gVRsgcvJt2XAwkgXkfECKApnvl2jxHNy1qLwcMmh4AIGZ68jL+
 vR0LO/1hzcv2mV9p5pC/ciQOXRvK5C7bfdVeoOW9SFQjyrqzHIqdM/5SU
 I0XFqb5wGxRCcI8FSr9YH1LTGb4pqRNsGchpeWs38aOPNiqG7R6T3NJi4
 S4VdWxHG4qsNlygfcr7PxcHOwhoHCHrfboqb31p6DYj5vHNBOHup+LzvI w==;
X-CSE-ConnectionGUID: UG082WpOQpKPEF1s8jnivQ==
X-CSE-MsgGUID: S6XHgGifQbSt37ePWtpniQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3481859"
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="3481859"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 08:09:39 -0800
X-CSE-ConnectionGUID: Y80arGseQ5WP2GXSniTN8Q==
X-CSE-MsgGUID: g5Z/gUQuQ9q76zfK9iwvjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="9926976"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa009.fm.intel.com with ESMTP; 16 Nov 2026 08:09:38 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 27.03 1/6] eal: add macros for local variable-length structure
 buffers
Date: Mon, 16 Nov 2026 16:09:27 +0000
Message-ID: <20261116160932.1006354-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116160932.1006354-1-bruce.richardson@intel.com>
References: <20261116160932.1006354-1-bruce.richardson@intel.com>
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

Many drivers allocate small control-path messages, which consist of a
header structure followed by a variable-length array, using malloc and
free, which adds error handling and the risk of leaks on error paths.

Add RTE_DEFINE_FLEX and RTE_DEFINE_FLEX_BYTES macros to define such
buffers on the stack instead, (similar to equivalent macros in Linux
kernel). The buffer is a union of a byte array and the structure type,
giving correct alignment and type-safe access via a pointer, with the
byte array first so that zero-initialization covers the whole buffer.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_common.c       | 54 ++++++++++++++++++++++++++++++++++++
 lib/eal/include/rte_common.h | 46 ++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/app/test/test_common.c b/app/test/test_common.c
index 290bf763ee..148d31aee5 100644
--- a/app/test/test_common.c
+++ b/app/test/test_common.c
@@ -796,6 +796,59 @@ test_fls(void)
 	return 0;
 }
 
+struct flex_test_elem {
+	uint64_t a;
+	uint16_t b;
+};
+
+struct flex_test_hdr {
+	uint16_t num;
+	struct flex_test_elem elems[];
+};
+
+struct flex_test_hdr_one {
+	uint8_t num;
+	struct {
+		uint8_t len;
+		struct flex_test_elem elems[1];
+	} list;
+};
+
+static int
+test_define_flex(void)
+{
+	RTE_DEFINE_FLEX(struct flex_test_hdr, hdr, elems, 4);
+	RTE_DEFINE_FLEX(struct flex_test_hdr_one, hdr_one, list.elems, 3);
+	RTE_DEFINE_FLEX_BYTES(struct flex_test_hdr, hdr_bytes, 100);
+
+	RTE_TEST_ASSERT(sizeof(hdr_u) >= sizeof(*hdr) + 4 * sizeof(hdr->elems[0]),
+		"RTE_DEFINE_FLEX size, flexible array");
+	RTE_TEST_ASSERT(sizeof(hdr_one_u) >= sizeof(*hdr_one) + 3 * sizeof(hdr_one->list.elems[0]),
+		"RTE_DEFINE_FLEX size, nested one-element array");
+	RTE_TEST_ASSERT(sizeof(hdr_bytes_u) >= 100, "RTE_DEFINE_FLEX_BYTES size");
+
+	RTE_TEST_ASSERT((uintptr_t)hdr % alignof(struct flex_test_hdr) == 0,
+		"RTE_DEFINE_FLEX alignment");
+	RTE_TEST_ASSERT((uintptr_t)hdr_one % alignof(struct flex_test_hdr_one) == 0,
+		"RTE_DEFINE_FLEX alignment, nested array");
+	RTE_TEST_ASSERT((uintptr_t)hdr_bytes % alignof(struct flex_test_hdr) == 0,
+		"RTE_DEFINE_FLEX_BYTES alignment");
+
+	for (size_t i = 0; i < sizeof(hdr_u.raw); i++)
+		RTE_TEST_ASSERT(hdr_u.raw[i] == 0, "RTE_DEFINE_FLEX not zeroed");
+	for (size_t i = 0; i < sizeof(hdr_one_u.raw); i++)
+		RTE_TEST_ASSERT(hdr_one_u.raw[i] == 0, "RTE_DEFINE_FLEX not zeroed, nested array");
+	for (size_t i = 0; i < sizeof(hdr_bytes_u.raw); i++)
+		RTE_TEST_ASSERT(hdr_bytes_u.raw[i] == 0, "RTE_DEFINE_FLEX_BYTES not zeroed");
+
+	hdr->num = 4;
+	for (uint16_t i = 0; i < hdr->num; i++)
+		hdr->elems[i].b = i;
+	RTE_TEST_ASSERT_EQUAL(hdr->elems[3].b, 3, "RTE_DEFINE_FLEX element access");
+
+	return 0;
+}
+
 static struct unit_test_suite common_test_suite = {
 	.suite_name = "common autotest",
 	.setup = NULL,
@@ -805,6 +858,7 @@ static struct unit_test_suite common_test_suite = {
 		TEST_CASE(test_ptr_align_edge_cases),
 		TEST_CASE(test_align),
 		TEST_CASE(test_macros),
+		TEST_CASE(test_define_flex),
 		TEST_CASE(test_misc),
 		TEST_CASE(test_bsf),
 		TEST_CASE(test_log2),
diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index fed373f412..4f55b776f8 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -1114,6 +1114,52 @@ __extension__ typedef uint64_t RTE_MARKER64[0];
  */
 #define RTE_SIZEOF_FIELD(type, field) (sizeof(((type *)0)->field))
 
+/**
+ * Define a zero-initialized, local buffer of a given size in bytes,
+ * accessed via a pointer to a structure type.
+ *
+ * This is intended for structures ending in a variable-length array,
+ * e.g. messages with a header followed by a list of elements,
+ * allowing them to be placed on the stack rather than dynamically allocated.
+ * The buffer is suitably aligned for the structure type.
+ *
+ * @param type
+ *   The type of the structure at the start of the buffer.
+ * @param name
+ *   The name of the pointer variable to define, of type "type * const".
+ * @param size
+ *   The size of the buffer in bytes, a compile-time constant
+ *   which must be no smaller than the size of the structure type.
+ */
+#define RTE_DEFINE_FLEX_BYTES(type, name, size) \
+	static_assert((size) >= sizeof(type), "buffer smaller than " RTE_STR(type)); \
+	union { \
+		uint8_t raw[size]; /* first member, so "{0}" zeroes the whole buffer */ \
+		type obj; \
+	} name ## _u = {0}; \
+	type * const name = &name ## _u.obj
+
+/**
+ * Define a zero-initialized, local buffer for a structure ending in an array,
+ * with space for a given number of array elements beyond the size of the structure.
+ *
+ * The buffer is sized as "sizeof(type) + count * sizeof(element)", so for structures
+ * whose array is declared with a single element, e.g. "elem[1]",
+ * "count" elements are available in addition to that one.
+ *
+ * @param type
+ *   The type of the structure.
+ * @param name
+ *   The name of the pointer variable to define, of type "type * const".
+ * @param member
+ *   The array member at the end of the structure.
+ * @param count
+ *   The number of extra array elements to allow for, a compile-time constant.
+ */
+#define RTE_DEFINE_FLEX(type, name, member, count) \
+	RTE_DEFINE_FLEX_BYTES(type, name, \
+		sizeof(type) + RTE_SIZEOF_FIELD(type, member[0]) * (count))
+
 #define _RTE_STR(x) #x
 /** Take a macro value and get a string version of it */
 #define RTE_STR(x) _RTE_STR(x)
-- 
2.55.0

