Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0F1FF8867
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 14:46:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E0574066A;
	Wed, 29 Apr 2026 16:46:40 +0200 (CEST)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by mails.dpdk.org (Postfix) with ESMTP id B2A3E40151
 for <dev@dpdk.org>; Wed, 29 Apr 2026 16:46:37 +0200 (CEST)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-12dbd0f8063so2805333c88.0
 for <dev@dpdk.org>; Wed, 29 Apr 2026 07:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777473997;
 x=1778078797; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sb7OLcpKOzPvIEt9nApqv7ecGOB7EfX2JfdI1lRw2M0=;
 b=lnH9ZR6pWOdxR9LGpAPcEin5qIxPVi92dpQ2Y7zPvwSltL20/rTDTFG3t5QlI9P2aG
 KvampD5kW/gwrUyFDEcC2WffO028V9P5bdLyPYfkMUVrc78infO3j37MyA0nJfxNDcXt
 6DVAMoneBnWMmKhdxYI3trkLyJGtiK5du2Y+qZb9SASeDXx+CoyeOvWO8KL/f0+IBmV9
 UtR/onfoxcZGa03mMx3hol6/rt4yamLWYRv7oXN37eIOxt/J4QqYZC8wGVfQHbhVHzxR
 DYmjS4Eg7DIDutzY9RltMc0jTedSGzODTDud/GJlTzSM5RHUpkmAL1qviDMNesybQspF
 8rOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777473997; x=1778078797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sb7OLcpKOzPvIEt9nApqv7ecGOB7EfX2JfdI1lRw2M0=;
 b=Nb+466NxyU/5K6vDEov6riYflcXuHVl3if1uZ6xmH/f/hKQFdDCgeqf2NA48BmElsw
 4rnwJjW63P0L7eg9M5q6G6fRyYkqu+C4igGsGVtScu2TelwMguaYCi5fRnYt/Qsy/IT9
 LHq59eKxRDLrENhcihZCQ8SHgXU1JiQCksvoMqm5w4D33E0PO9zRknyC3RNsTi1OJPHQ
 ca5xKQ/dZawmRaJ9CfdY3MQQTUEKDVVKtWPrQrjFCgGn3sBXwCi+ww/JlLby5lPXbuR7
 TdXlc3klQqBFNmPW6Nn9C8KLoFxdAAp23cpuSLgwKLEnMreQkzEJf2Gicxc6tlO9KVKI
 KmwA==
X-Gm-Message-State: AOJu0Yzam9o6kwGZllnAEE10/U1H2tv9kIQKF1HOQFXlS5t5znyAtFa5
 2hMNTk6HT0P1e8K9Sp3Dh+V4+UvuxnYqV4Ngh4swzGEoWyLApv2Y1lHrz3bP96ReQtGLdpyutmI
 ZkUGF
X-Gm-Gg: AeBDietsNYPfwQsCp2sKUD6el3cMNxnhOJKpiZwHAgZeiPSnWa05jbK3vT6gJNbLge5
 RL5iuvra8QR5/soI46Uk04gQRjD6RMNk5RC2U7zU8uWGOUh+41RiBOj7ngKmZcHf3moH5Jg1PNq
 dxYHQqfXn7uUvzXTGS+7DCmX1ZFO19iFs6Z0yCm8cuJnjr7brzSgdJBt4vbu0zaeocLqNFMLRiz
 pIJMq7ZiPQol+UCgjw2WNb+/LogPpXm/lkYtrDyz63kJwyc5M7sZd4TTxUChPKnzI2gs8OYoYC/
 B9ATAAyRFAl9e9uxH1nlkky5xoQaqAJ5j+l8NWi6dtEsgCN/Up2Yy+WILduVY3J4Vw3NmssXpnD
 mocicCNccmOowN8hEP3NAcEyjBkIKr2MmAg7K0xX1i2Eva4dsPKwPM0twtrYzzZZ/Itpm60kD94
 BLCSQuPB/3c1RGMi933In3gjV6zFPBuEggTBI8qFGeF0s=
X-Received: by 2002:a05:7022:2383:b0:12d:c039:6599 with SMTP id
 a92af1059eb24-12ddd9bf25dmr3467425c88.22.1777473996561; 
 Wed, 29 Apr 2026 07:46:36 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12de3269b41sm2631166c88.13.2026.04.29.07.46.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 07:46:36 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Weijun Pan <wpan3636@gmail.com>, stable@dpdk.org,
 Deepak Kumar Jain <deepak.k.jain@intel.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>
Subject: [PATCH 1/2] test: use inline helpers in buffer comparison macros
Date: Wed, 29 Apr 2026 07:42:28 -0700
Message-ID: <20260429144632.164970-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429144632.164970-1-stephen@networkplumber.org>
References: <20260419164818.20609-1-wpan36@wisc.edu>
 <20260429144632.164970-1-stephen@networkplumber.org>
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

The TEST_ASSERT_BUFFERS_ARE_EQUAL family of macros had several
problems stemming from doing all the work inside the macro body:

 - Macro parameters were used directly in arithmetic expressions
   without parentheses.
 - Arguments were evaluated multiple times.
 - There was no type checking.

In addition, the _OFFSET and _BIT_OFFSET wrappers chained to the
inner assertion macro passing only "msg" and dropped the variadic
arguments, so any printf parameters after the format string were
silently lost on failure.

Move the comparison logic into static inline helpers and keep the
macros as thin wrappers around the printf / TEST_TRACE_FAILURE /
return TEST_FAILED boilerplate (which must remain a macro to
capture __func__ / __LINE__ and to return from the caller).
Each argument is now evaluated exactly once where the macro hands
it to the helper, the size_t parameters give the compiler real
types to check against, and the bit-mask arithmetic lives in C
rather than the preprocessor.  Existing call sites need no
changes.

Bugzilla ID: 1925
Suggested-by: Weijun Pan <wpan3636@gmail.com>
Fixes: db4faf469816 ("app/test: add new buffer comparison macros")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test.h | 147 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 95 insertions(+), 52 deletions(-)

diff --git a/app/test/test.h b/app/test/test.h
index 1f12fc5397..ebf6727639 100644
--- a/app/test/test.h
+++ b/app/test/test.h
@@ -6,8 +6,12 @@
 #define _TEST_H_
 
 #include <errno.h>
+#include <stdbool.h>
 #include <stddef.h>
+#include <stdint.h>
+#include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <sys/queue.h>
 
 #include <rte_hexdump.h>
@@ -32,70 +36,109 @@
 
 #define TEST_ASSERT_EQUAL RTE_TEST_ASSERT_EQUAL
 
+/*
+ * Helpers backing the TEST_ASSERT_BUFFERS_ARE_EQUAL* macros.
+ *
+ * Keeping the comparison logic in inline functions ensures each macro
+ * argument is evaluated exactly once and gives the compiler real types
+ * to check against, which the original all-macro implementation could
+ * not provide.
+ */
+static inline bool
+test_buffers_equal(const void *a, const void *b, size_t len)
+{
+	return memcmp(a, b, len) == 0;
+}
+
+static inline bool
+test_buffers_equal_offset(const void *a, const void *b,
+		size_t len, size_t off)
+{
+	const uint8_t *pa = (const uint8_t *)a + off;
+	const uint8_t *pb = (const uint8_t *)b + off;
+
+	return memcmp(pa, pb, len) == 0;
+}
+
+static inline bool
+test_buffers_equal_bit(const void *a, const void *b, size_t len)
+{
+	const uint8_t *pa = a;
+	const uint8_t *pb = b;
+	size_t whole = len >> 3;
+	size_t extra = len & 7;
+
+	if (memcmp(pa, pb, whole) != 0)
+		return false;
+	if (extra != 0) {
+		uint8_t mask = (uint8_t)~((1U << (8 - extra)) - 1);
+
+		if ((pa[whole] & mask) != (pb[whole] & mask))
+			return false;
+	}
+	return true;
+}
+
+static inline bool
+test_buffers_equal_bit_offset(const void *a, const void *b,
+		size_t len, size_t off)
+{
+	const uint8_t *pa = a;
+	const uint8_t *pb = b;
+	size_t off_bits = off & 7;
+	size_t off_bytes = off >> 3;
+
+	if (off_bits != 0) {
+		uint8_t first_bits = 8 - off_bits;
+		uint8_t mask = (1U << first_bits) - 1;
+
+		if ((pa[off_bytes] & mask) != (pb[off_bytes] & mask))
+			return false;
+		off_bytes++;
+		len -= first_bits;
+	}
+	return test_buffers_equal_bit(pa + off_bytes, pb + off_bytes, len);
+}
+
 /* Compare two buffers (length in bytes) */
-#define TEST_ASSERT_BUFFERS_ARE_EQUAL(a, b, len,  msg, ...) do {	\
-	if (memcmp(a, b, len)) {                                        \
-		printf("TestCase %s() line %d failed: "              \
-			msg "\n", __func__, __LINE__, ##__VA_ARGS__);    \
-		TEST_TRACE_FAILURE(__FILE__, __LINE__, __func__);    \
-		return TEST_FAILED;                                  \
-	}                                                        \
+#define TEST_ASSERT_BUFFERS_ARE_EQUAL(a, b, len, msg, ...) do {		\
+	if (!test_buffers_equal((a), (b), (len))) {			\
+		printf("TestCase %s() line %d failed: " msg "\n",	\
+			__func__, __LINE__, ##__VA_ARGS__);		\
+		TEST_TRACE_FAILURE(__FILE__, __LINE__, __func__);	\
+		return TEST_FAILED;					\
+	}								\
 } while (0)
 
 /* Compare two buffers with offset (length and offset in bytes) */
 #define TEST_ASSERT_BUFFERS_ARE_EQUAL_OFFSET(a, b, len, off, msg, ...) do { \
-	const uint8_t *_a_with_off = (const uint8_t *)a + off;              \
-	const uint8_t *_b_with_off = (const uint8_t *)b + off;              \
-	TEST_ASSERT_BUFFERS_ARE_EQUAL(_a_with_off, _b_with_off, len, msg);  \
+	if (!test_buffers_equal_offset((a), (b), (len), (off))) {	\
+		printf("TestCase %s() line %d failed: " msg "\n",	\
+			__func__, __LINE__, ##__VA_ARGS__);		\
+		TEST_TRACE_FAILURE(__FILE__, __LINE__, __func__);	\
+		return TEST_FAILED;					\
+	}								\
 } while (0)
 
 /* Compare two buffers (length in bits) */
 #define TEST_ASSERT_BUFFERS_ARE_EQUAL_BIT(a, b, len, msg, ...) do {	\
-	uint8_t _last_byte_a, _last_byte_b;                       \
-	uint8_t _last_byte_mask, _last_byte_bits;                  \
-	TEST_ASSERT_BUFFERS_ARE_EQUAL(a, b, (len >> 3), msg);     \
-	if (len % 8) {                                              \
-		_last_byte_bits = len % 8;                   \
-		_last_byte_mask = ~((1 << (8 - _last_byte_bits)) - 1); \
-		_last_byte_a = ((const uint8_t *)a)[len >> 3];            \
-		_last_byte_b = ((const uint8_t *)b)[len >> 3];            \
-		_last_byte_a &= _last_byte_mask;                     \
-		_last_byte_b &= _last_byte_mask;                    \
-		if (_last_byte_a != _last_byte_b) {                  \
-			printf("TestCase %s() line %d failed: "              \
-				msg "\n", __func__, __LINE__, ##__VA_ARGS__);\
-			TEST_TRACE_FAILURE(__FILE__, __LINE__, __func__);    \
-			return TEST_FAILED;                                  \
-		}                                                        \
-	}                                                            \
+	if (!test_buffers_equal_bit((a), (b), (len))) {			\
+		printf("TestCase %s() line %d failed: " msg "\n",	\
+			__func__, __LINE__, ##__VA_ARGS__);		\
+		TEST_TRACE_FAILURE(__FILE__, __LINE__, __func__);	\
+		return TEST_FAILED;					\
+	}								\
 } while (0)
 
 /* Compare two buffers with offset (length and offset in bits) */
-#define TEST_ASSERT_BUFFERS_ARE_EQUAL_BIT_OFFSET(a, b, len, off, msg, ...) do {	\
-	uint8_t _first_byte_a, _first_byte_b;                                 \
-	uint8_t _first_byte_mask, _first_byte_bits;                           \
-	uint32_t _len_without_first_byte = (off % 8) ?                       \
-				len - (8 - (off % 8)) :                       \
-				len;                                          \
-	uint32_t _off_in_bytes = (off % 8) ? (off >> 3) + 1 : (off >> 3);     \
-	const uint8_t *_a_with_off = (const uint8_t *)a + _off_in_bytes;      \
-	const uint8_t *_b_with_off = (const uint8_t *)b + _off_in_bytes;      \
-	TEST_ASSERT_BUFFERS_ARE_EQUAL_BIT(_a_with_off, _b_with_off,           \
-				_len_without_first_byte, msg);                \
-	if (off % 8) {                                                        \
-		_first_byte_bits = 8 - (off % 8);                             \
-		_first_byte_mask = (1 << _first_byte_bits) - 1;               \
-		_first_byte_a = *(_a_with_off - 1);                           \
-		_first_byte_b = *(_b_with_off - 1);                           \
-		_first_byte_a &= _first_byte_mask;                            \
-		_first_byte_b &= _first_byte_mask;                            \
-		if (_first_byte_a != _first_byte_b) {                         \
-			printf("TestCase %s() line %d failed: "               \
-				msg "\n", __func__, __LINE__, ##__VA_ARGS__); \
-			TEST_TRACE_FAILURE(__FILE__, __LINE__, __func__);     \
-			return TEST_FAILED;                                   \
-		}                                                             \
-	}                                                                     \
+#define TEST_ASSERT_BUFFERS_ARE_EQUAL_BIT_OFFSET(a, b, len, off, msg, ...) \
+do {									\
+	if (!test_buffers_equal_bit_offset((a), (b), (len), (off))) {	\
+		printf("TestCase %s() line %d failed: " msg "\n",	\
+			__func__, __LINE__, ##__VA_ARGS__);		\
+		TEST_TRACE_FAILURE(__FILE__, __LINE__, __func__);	\
+		return TEST_FAILED;					\
+	}								\
 } while (0)
 
 #define TEST_ASSERT_NOT_EQUAL RTE_TEST_ASSERT_NOT_EQUAL
-- 
2.53.0

