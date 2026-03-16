Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974E3F53D7F
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 17:28:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C13640666;
	Mon, 16 Mar 2026 18:28:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 6B95B4064C
 for <dev@dpdk.org>; Mon, 16 Mar 2026 18:28:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773682083; x=1805218083;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=DGt4/xogFKRIxMlQjnMj5SvOG2dY2NvObrO5EYuAvp4=;
 b=S6GB/XOhYFnEXFi7BTmJXFSv9QrcKbNWKruhHMr+zvplfBE63HF7EftR
 INc3WjDq6AVOqRLhMkieDo3grvj/SMYgI8MKVnu+bdoVr28HeNa8qqnN6
 esObUupdiPX2vj/eJegYpO3GuTelOqfY1TQvMt2l5i7v91l7ZemPhbcJW
 eBZFpmv6+oaD+DpeHMawrf3ePQTEyTTiPzrx1+O9S+OEZUwNM7FfQuRR/
 pmhEu3ItcKlntEDJAplYg6B5vVZUsmaXmkws/qziGvr0PeNeWJzJygnw7
 d1RoEbv9zNdWk+eqtR+ec+D8X2YZ8+GgEbyz1+fwwb+ZCOuNaINVaabFG g==;
X-CSE-ConnectionGUID: SPIfz6FgSsm7d0uMYfNVnw==
X-CSE-MsgGUID: XywgICWwSYGLtYM8919Vew==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="86059613"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="86059613"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 10:28:02 -0700
X-CSE-ConnectionGUID: iER67KYOQU6c6I93WZ0l9g==
X-CSE-MsgGUID: XJOeQLscRpmVoSJyXMQSzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="221228191"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 16 Mar 2026 10:28:01 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH v1 03/21] net/intel/common: add utility functions
Date: Mon, 16 Mar 2026 17:27:31 +0000
Message-ID: <04de10e6a645a239c8979e132f4e1f35313425e2.1773681364.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1773681363.git.anatoly.burakov@intel.com>
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
 drivers/net/intel/common/flow_util.h | 165 +++++++++++++++++++++++++++
 1 file changed, 165 insertions(+)
 create mode 100644 drivers/net/intel/common/flow_util.h

diff --git a/drivers/net/intel/common/flow_util.h b/drivers/net/intel/common/flow_util.h
new file mode 100644
index 0000000000..1337e6c55d
--- /dev/null
+++ b/drivers/net/intel/common/flow_util.h
@@ -0,0 +1,165 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Intel Corporation
+ */
+
+#ifndef _INTEL_COMMON_FLOW_UTIL_H_
+#define _INTEL_COMMON_FLOW_UTIL_H_
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
+ * ci_is_all_byte - Check if memory region is filled with a specific byte value.
+ *
+ * @param ptr: Pointer to memory region
+ * @param len: Length in bytes
+ * @param val: Byte value to check (e.g., 0x00 or 0xFF)
+ *
+ * @return true if all bytes equal @val, false otherwise
+ */
+static inline bool
+ci_is_all_byte(const void *ptr, size_t len, uint8_t val)
+{
+	const uint8_t *bytes = ptr;
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
+ * ci_is_all_zero_or_masked - Check if bytes are all 0x00 OR all 0xFF.
+ * @param ptr: Pointer to memory region
+ * @param len: Length in bytes
+ *
+ * @return true if all bytes are 0x00 OR all bytes are 0xFF, false otherwise
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
+ * ci_is_zero_or_masked - Check if a value is zero OR matches the mask exactly.
+ *
+ * @param value: Data value to check
+ * @param mask: Mask to compare against
+ *
+ * @return true if (value == 0) OR (value == mask), false otherwise
+ *
+ * Usage notes: this is intended for bitfields e.g. VLAN_TCI
+ * For byte-aligned fields, use CI_FIELD_IS_ZERO_OR_MASKED below.
+ */
+static inline bool
+ci_is_zero_or_masked(uint64_t value, uint64_t mask)
+{
+	uint64_t masked_val = value & mask;
+
+	return masked_val == 0 || masked_val == mask;
+}
+
+/**
+ * Check if a struct field is fully masked or unmasked.
+ *
+ * @param field_ptr: Pointer to the mask field (e.g., &eth_mask->hdr.src_addr)
+ */
+#define CI_FIELD_IS_ZERO_OR_MASKED(field_ptr) \
+	ci_is_all_zero_or_masked((field_ptr), sizeof(*(field_ptr)))
+
+/**
+ * Check if a struct field is all 0x00.
+ *
+ * @param field_ptr: Pointer to the mask field (e.g., &eth_mask->hdr.src_addr)
+ */
+#define CI_FIELD_IS_ZERO(field_ptr) \
+	ci_is_all_byte((field_ptr), sizeof(*(field_ptr)), 0x00)
+
+/**
+ * Check if a struct field is all 0xFF.
+ *
+ * @param field_ptr: Pointer to the mask field (e.g., &eth_mask->hdr.src_addr)
+ */
+#define CI_FIELD_IS_MASKED(field_ptr) \
+	ci_is_all_byte((field_ptr), sizeof(*(field_ptr)), 0xFF)
+
+/**
+ * ci_be24_to_cpu - Convert 24-bit big-endian value to host byte order.
+ * @param val: Pointer to 3-byte big-endian value
+ *
+ * @return uint32_t value in host byte order
+ *
+ * Usage: extract 24-bit Big-Endian values (e.g. VXLAN VNI).
+ */
+static inline uint32_t
+ci_be24_to_cpu(const uint8_t val[3])
+{
+	return (val[0] << 16) | (val[1] << 8) | val[2];
+}
+
+/**
+ * ci_is_hex_char - Check if a character is a valid hexadecimal digit.
+ *
+ * @param c: Character to check
+ *
+ * @return true if c is in [0-9a-fA-F], false otherwise
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
+ * ci_hex_char_to_nibble - Convert hex character to 4-bit value.
+ *
+ * @param c: Hex character ('0'-'9', 'a'-'f', 'A'-'F')
+ *
+ * @return Value 0-15, or 0 if invalid
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
2.47.3

