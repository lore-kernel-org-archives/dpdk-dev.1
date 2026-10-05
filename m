Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801E2CA5FFC
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 16:39:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72B3540DD1;
	Mon,  5 Oct 2026 18:38:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 828AE40B9D
 for <dev@dpdk.org>; Mon,  5 Oct 2026 18:38:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791218319; x=1822754319;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=rzVq7OmiADfuVY08NKDDS0CW1fYknzv4FjIrZWXOSyE=;
 b=OUaPe7jfGJ/kf11jDi9MINPwAJKGdnieyUbwuXe1c7NwyX6LWh62uNf7
 xn4dcRfuEwIndg1DQRyW0TFsduEse1tlUHoZFDrfLVFSfbcPENvTIRsmJ
 wN3hq8w2/A9BEy93yttVZEPzLVr6bu1FOZjLPJSAuX97+PHw72H/ZwiZv
 4VClFbNfHyM0JoQOlv5oY0XX/c/6ZWoQL078XBDDcWmyy5LPo8Ijyy10U
 GD2UrDn+WbRsXRuUtseD+vSCjcTOSWCFsVtV8FD1oQq6RcCvNYcWtXkHQ
 hrmKom6UyBaEm49Ca2FEMJlKSUYuib9QMYxyuxb3TogdXMrFPZU7gjq0l w==;
X-CSE-ConnectionGUID: +4P2odxURlq4Z/gcCPaYFQ==
X-CSE-MsgGUID: 02iOitPzTmGK77Es4+fZ+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="90665280"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="90665280"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 09:38:39 -0700
X-CSE-ConnectionGUID: dDWLNU2XQ8iv6tMff9UcHQ==
X-CSE-MsgGUID: MZNcVNjNSxaB0YJ/+gytxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="945699"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa011.fm.intel.com with ESMTP; 05 Oct 2026 09:38:38 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 04/24] net/intel/common: add utility functions
Date: Mon,  5 Oct 2026 17:37:59 +0100
Message-ID: <2165824c4a901ca2d27dda9ef13b40e75f589124.1791218155.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1791218154.git.anatoly.burakov@intel.com>
 <cover.1791218154.git.anatoly.burakov@intel.com>
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
 drivers/net/intel/common/flow_util.h | 263 +++++++++++++++++++++++++++
 1 file changed, 263 insertions(+)
 create mode 100644 drivers/net/intel/common/flow_util.h

diff --git a/drivers/net/intel/common/flow_util.h b/drivers/net/intel/common/flow_util.h
new file mode 100644
index 00000000000..96493ba7631
--- /dev/null
+++ b/drivers/net/intel/common/flow_util.h
@@ -0,0 +1,263 @@
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
+#include <rte_flow.h>
+
+/*
+ * Utility functions primarily intended for flow parsers.
+ */
+
+/**
+ * Get the effective mask of a flow item.
+ *
+ * @param item
+ *   Flow item.
+ * @return
+ *   - NULL if spec is NULL
+ *   - item->mask if mask is not NULL
+ *   - default mask for the item type if mask is NULL
+ *   - NULL if the item type has no default mask
+ */
+static inline const void *
+ci_flow_item_mask(const struct rte_flow_item *item)
+{
+	const void *mask;
+
+	if (item->spec == NULL)
+		return NULL;
+	if (item->mask != NULL)
+		return item->mask;
+	if (rte_flow_conv(RTE_FLOW_CONV_OP_ITEM_DEFAULT_MASK_PTR, &mask, sizeof(mask),
+			(const void *)(uintptr_t)item->type, NULL) < 0)
+		return NULL;
+	return mask;
+}
+
+/*
+ * Simplistic usage counter. Not thread-safe, not atomic.
+ */
+typedef uint32_t ci_usage_count_t;
+
+/**
+ * Claim a usage. Returns true if this is the first usage.
+ *
+ * @param counter
+ *   Usage counter to claim.
+ * @return
+ *   true if this is the first usage, false otherwise.
+ */
+static inline bool
+ci_usage_count_claim(ci_usage_count_t *counter)
+{
+#ifdef CI_DEBUG
+	if (*counter == UINT32_MAX)
+		rte_panic("ci usage counter overflow\n");
+#endif
+	return (*counter)++ == 0;
+}
+
+/**
+ * Release a usage. Returns true if this was the last usage.
+ *
+ * @param counter
+ *   Usage counter to release.
+ * @return
+ *   true if this was the last usage, false otherwise.
+ */
+static inline bool
+ci_usage_count_release(ci_usage_count_t *counter)
+{
+#ifdef CI_DEBUG
+	if (*counter == 0)
+		rte_panic("ci usage counter underflow\n");
+#endif
+	return --(*counter) == 0;
+}
+
+/**
+ * Test whether the currently claimed usage is the last one.
+ *
+ * @param counter
+ *   Usage counter to test.
+ * @return
+ *   true if the current usage is the last one, false otherwise.
+ */
+static inline bool
+ci_usage_count_is_last(const ci_usage_count_t *counter)
+{
+	return *counter == 1;
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
+ *   true if the value is either all-zero or fully masked, false otherwise.
+ */
+static inline bool
+ci_is_zero_or_masked(uint64_t value, uint64_t mask)
+{
+	return value == 0 || value == mask;
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
+#endif /* _COMMON_INTEL_FLOW_UTIL_H_ */
-- 
2.52.0

