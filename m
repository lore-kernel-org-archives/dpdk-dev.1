Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450F2C5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 14:02:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C308840A6F;
	Thu, 20 Aug 2026 16:01:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 8D11F40150
 for <dev@dpdk.org>; Thu, 20 Aug 2026 16:01:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787234509; x=1818770509;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=w9BAaGEhOW3v5FJLcREF2bq8IoH0w4heZ6vuFqcguL4=;
 b=kry//jAA226s+KN9+vlJZl8jQ/AD4gp/uDh6HCPvYhx9RucFEJZecPd+
 DxPTfDKW526GwzorQfqr3JLaqCUNLYC+mftFlxldvOxQzgj7z1OgaDxwu
 Mg7BzDY1Th0n9J4D5EFrIzarIeaZr68NYMGI2X3SILW+sK0TSF1wP9Txn
 ztXFSgK2KMGrFCaxou9uxFRMg4zU05NBYrqG94yDQQdsXCGzBLLiOCb3h
 /wVnNQIN9MyuKE9SpU7NUWOWCrzj65yLP4U3Q0YyVXBFt95ODIOePvwv5
 DEfNUVOoVStS3k2/OxK9lHpz9r+ACs7eLsR1VypPDp88jF3jssWIq77hS Q==;
X-CSE-ConnectionGUID: MK6xKj7nTbqod02cOVAXPQ==
X-CSE-MsgGUID: ZmJtk3bxRDiBWEhVSrAgLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="75300319"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="75300319"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 07:01:47 -0700
X-CSE-ConnectionGUID: 9UgYaDxnRq27G4cHJlv8Zw==
X-CSE-MsgGUID: jNpB6CtZQ2quWNLpCOcM3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="264719688"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 20 Aug 2026 07:01:45 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 03/21] net/intel/common: add utility functions
Date: Thu, 20 Aug 2026 15:00:48 +0100
Message-ID: <1134429f3eda13e6940adb47d9e5a3720952fcf5.1787233987.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1787233986.git.anatoly.burakov@intel.com>
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
 drivers/net/intel/common/flow_util.h | 183 +++++++++++++++++++++++++++
 1 file changed, 183 insertions(+)
 create mode 100644 drivers/net/intel/common/flow_util.h

diff --git a/drivers/net/intel/common/flow_util.h b/drivers/net/intel/common/flow_util.h
new file mode 100644
index 0000000000..57f12c4637
--- /dev/null
+++ b/drivers/net/intel/common/flow_util.h
@@ -0,0 +1,183 @@
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
+/*
+ * Utility functions primarily intended for flow parsers.
+ */
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

