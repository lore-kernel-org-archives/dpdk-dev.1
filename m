Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89B3C88E5C
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 12:18:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 384C742ED2;
	Wed, 16 Sep 2026 14:18:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 16DBB42DF0
 for <dev@dpdk.org>; Wed, 16 Sep 2026 14:18:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789561118; x=1821097118;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=a5Ur7Qq/aJsMc9GR0xDs4UameCUCVB4IAfWNUMp9POw=;
 b=Tizxi8pIsz9rjmaatj5R6npPaWkW3Zbrflm0rKcAwLj7I67SbJGLw5Fz
 2mzuE+XhDpIKjcKKIacaNjp5U3EAPAX5HEeB9IfXqU9XiBb1HaY0ViICv
 QXQszVgsLiasX6rjvKe/e11NjAJ8VGeAgfywGJokg2rkyv8NwLbf9NB2d
 6FYK4wDGjU4GGB4diZnpgxF/cMbT6Y+kjXy7QimqQlDjovrafQdYIkKC0
 VAgMccitvs+6kWJaUyYiQNPNaWESD5eVlykzxZEfy7BYC/1jj01YOQti9
 SBZvANiJ1TilFOQIZUvaK/p26E8kYpN2dY04/gI7HQ0w8nk2rqX9XG2Xj w==;
X-CSE-ConnectionGUID: bIuPe86bTZGW2BsfOGoHig==
X-CSE-MsgGUID: ReGa4kfPRiuAI3sgrDOc8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="112702935"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="112702935"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 05:18:38 -0700
X-CSE-ConnectionGUID: 0wWUwN8/RtOMRB3RO025CA==
X-CSE-MsgGUID: 5Y/P3h+JQBCTowgPCsdmRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="272850228"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa008.jf.intel.com with ESMTP; 16 Sep 2026 05:18:37 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 03/19] net/intel/common: add utility functions
Date: Wed, 16 Sep 2026 13:18:09 +0100
Message-ID: <6f960051c1dbc0c9361ceec0d7a060398131f559.1789560945.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1789560943.git.anatoly.burakov@intel.com>
 <cover.1789560943.git.anatoly.burakov@intel.com>
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

A lot of parsers will rely on doing the same things over and over, so
create a header with utility functions to aid in writing parsers.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/common/flow_util.h | 228 +++++++++++++++++++++++++++
 1 file changed, 228 insertions(+)
 create mode 100644 drivers/net/intel/common/flow_util.h

diff --git a/drivers/net/intel/common/flow_util.h b/drivers/net/intel/common/flow_util.h
new file mode 100644
index 00000000000..698a83a1785
--- /dev/null
+++ b/drivers/net/intel/common/flow_util.h
@@ -0,0 +1,228 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Intel Corporation
+ */
+
+#ifndef _COMMON_INTEL_FLOW_UTIL_H_
+#define _COMMON_INTEL_FLOW_UTIL_H_
+
+#include <stdint.h>
+#include <stdbool.h>
+#include <string.h>
+
+#include <rte_debug.h>
+
+/*
+ * Utility functions primarily intended for flow parsers.
+ */
+
+/*
+ * Simplistic reference counter. Not thread-safe, not atomic.
+ */
+struct ci_refcount {
+	uint32_t count;
+};
+
+/**
+ * Take a reference. Returns true if this is the first reference.
+ *
+ * @param ref
+ *   Reference count to acquire.
+ * @return
+ *   true if this is the first reference, false otherwise.
+ */
+static inline bool
+ci_refcount_acquire(struct ci_refcount *ref)
+{
+#ifdef CI_DEBUG
+	if (ref->count == UINT32_MAX)
+		rte_panic("ci_refcount overflow\n");
+#endif
+	return ref->count++ == 0;
+}
+
+/**
+ * Drop a reference. Returns true if this was the last reference.
+ *
+ * @param ref
+ *   Reference count to release.
+ * @return
+ *   true if this was the last reference, false otherwise.
+ */
+static inline bool
+ci_refcount_release(struct ci_refcount *ref)
+{
+#ifdef CI_DEBUG
+	if (ref->count == 0)
+		rte_panic("ci_refcount underflow\n");
+#endif
+	return --ref->count == 0;
+}
+
+/**
+ * Check if memory region is filled with a specific byte value.
+ *
+ * @param ptr
+ *   Pointer to memory region.
+ * @param len
+ *   Length in bytes.
+ * @param val
+ *   Byte value to check (e.g. 0x00 or 0xFF).
+ * @return
+ *   true if all bytes equal val, false otherwise.
+ */
+static inline bool
+ci_is_all_byte(const void *ptr, size_t len, uint8_t val)
+{
+	const uint8_t *bytes = (const uint8_t *)ptr;
+	const uint32_t pattern32 = 0x01010101U * val;
+	size_t i = 0;
+
+	/* Process 4-byte chunks using memcpy */
+	for (; i + 4 <= len; i += 4) {
+		uint32_t chunk;
+		memcpy(&chunk, bytes + i, 4);
+		if (chunk != pattern32)
+			return false;
+	}
+
+	/* Process remaining bytes */
+	for (; i < len; i++) {
+		if (bytes[i] != val)
+			return false;
+	}
+
+	return true;
+}
+
+/**
+ * Check if bytes are all 0x00 OR all 0xFF.
+ *
+ * @param ptr
+ *   Pointer to memory region.
+ * @param len
+ *   Length in bytes.
+ * @return
+ *   true if all bytes are 0x00 OR all bytes are 0xFF, false otherwise.
+ */
+static inline bool
+ci_is_all_zero_or_masked(const void *ptr, size_t len)
+{
+	const uint8_t *bytes = (const uint8_t *)ptr;
+	uint8_t first_val;
+
+	/* zero length cannot be valid */
+	if (len == 0)
+		return false;
+
+	first_val = bytes[0];
+
+	if (first_val != 0x00 && first_val != 0xFF)
+		return false;
+
+	return ci_is_all_byte(ptr, len, first_val);
+}
+
+/**
+ * Check if a value has no bits outside the mask, and within the mask is
+ * either all-zero or all-one.
+ *
+ * This is intended for bitfields e.g. VLAN_TCI. For byte-aligned fields,
+ * use CI_FIELD_IS_ZERO_OR_MASKED below.
+ *
+ * @param value
+ *   Data value to check.
+ * @param mask
+ *   Mask to compare against.
+ * @return
+ *   true if (value & ~mask) == 0 AND (value & mask) is 0 or mask,
+ *   false otherwise.
+ */
+static inline bool
+ci_is_zero_or_masked(uint64_t value, uint64_t mask)
+{
+	uint64_t masked = value & mask;
+	uint64_t unmasked = value & ~mask;
+
+	return unmasked == 0 && (masked == 0 || masked == mask);
+}
+
+/**
+ * Check if a struct field is fully masked or unmasked.
+ *
+ * @param field_ptr
+ *   Pointer to the mask field (e.g. &eth_mask->hdr.src_addr).
+ */
+#define CI_FIELD_IS_ZERO_OR_MASKED(field_ptr) \
+	ci_is_all_zero_or_masked((field_ptr), sizeof(*(field_ptr)))
+
+/**
+ * Check if a struct field is all 0x00.
+ *
+ * @param field_ptr
+ *   Pointer to the mask field (e.g. &eth_mask->hdr.src_addr).
+ */
+#define CI_FIELD_IS_ZERO(field_ptr) \
+	ci_is_all_byte((field_ptr), sizeof(*(field_ptr)), 0x00)
+
+/**
+ * Check if a struct field is all 0xFF.
+ *
+ * @param field_ptr
+ *   Pointer to the mask field (e.g. &eth_mask->hdr.src_addr).
+ */
+#define CI_FIELD_IS_MASKED(field_ptr) \
+	ci_is_all_byte((field_ptr), sizeof(*(field_ptr)), 0xFF)
+
+/**
+ * Convert 24-bit big-endian value to host byte order.
+ *
+ * Used to extract 24-bit big-endian values (e.g. VXLAN VNI).
+ *
+ * @param val
+ *   Pointer to 3-byte big-endian value.
+ * @return
+ *   Value in host byte order.
+ */
+static inline uint32_t
+ci_be24_to_cpu(const uint8_t val[3])
+{
+	return (val[0] << 16) | (val[1] << 8) | val[2];
+}
+
+/**
+ * Check if a character is a valid hexadecimal digit.
+ *
+ * @param c
+ *   Character to check.
+ * @return
+ *   true if c is in [0-9a-fA-F], false otherwise.
+ */
+static inline bool
+ci_is_hex_char(unsigned char c)
+{
+	return ((c >= '0' && c <= '9') ||
+		(c >= 'a' && c <= 'f') ||
+		(c >= 'A' && c <= 'F'));
+}
+
+/**
+ * Convert hex character to 4-bit value.
+ *
+ * @param c
+ *   Hex character ('0'-'9', 'a'-'f', 'A'-'F').
+ * @return
+ *   Value 0-15, or 0 if invalid.
+ */
+static inline unsigned char
+ci_hex_char_to_nibble(unsigned char c)
+{
+	if (c >= '0' && c <= '9')
+		return c - '0';
+	if (c >= 'a' && c <= 'f')
+		return c - 'a' + 10;
+	if (c >= 'A' && c <= 'F')
+		return c - 'A' + 10;
+	return 0;
+}
+
+#endif /* _INTEL_COMMON_FLOW_UTIL_H_ */
-- 
2.52.0

