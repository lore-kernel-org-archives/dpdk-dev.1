Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F39BCCFA13
	for <dpdk-dev@archiver.kernel.org>; Fri,  1 May 2026 16:35:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02C6440657;
	Fri,  1 May 2026 18:35:40 +0200 (CEST)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176]) by mails.dpdk.org (Postfix) with ESMTP id 553044028C
 for <dev@dpdk.org>; Fri,  1 May 2026 18:35:38 +0200 (CEST)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-2d868d014a5so2197676eec.1
 for <dev@dpdk.org>; Fri, 01 May 2026 09:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777653337;
 x=1778258137; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4M96PDjjv8tcXwY90eNWZ+Ve2Hzspe+R/6sXv40SdMI=;
 b=G7NTP4k2O+tuZLD8pBwMmZOHjWuEthXLTDrRJ0setElYQS/UyRz4BtqWh0UJy5uFh6
 5VB4vVZWfaG0tEaaDklnE24QOttePE/8liGEz02gdUf+QPe55KvNAvxnst4VeOvRBEm7
 xohVlklaZtuBuyd8t5rJf2RkLGWc72azt5a8J044M4XXAYVwTvD6bEJxG2BxjHe1uBWc
 c2uQgJy8UboA+UiwEeTRz2X3q3hBz77xAwRAon7lTO5sJukf38ZINxMNdQkPDoTgVWck
 y6vWWQ99fcKez27HyAh1j7M9RYpja6VUeGAZw8qLYE1d7JDEIZvxq/wafK8tyijDg/F1
 8Bww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777653337; x=1778258137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4M96PDjjv8tcXwY90eNWZ+Ve2Hzspe+R/6sXv40SdMI=;
 b=NF4+ep/5/oeMO1FhYWOLT2n+azb50klXLyKuTk2HUvyx7OZAgArHXfLAQTL5dUJ658
 E1oftq9YljEvbMRuWY2Lq5rr/Y9kNE+u8TIHeY7wls1xt8by3LIzn2wRxYPVMbJZ2i2t
 HcVt1GvfVkaHm/Hkq5VkXShVLvid9Mjo92pBP+KX9E/Mm6GhqlNwTXkIlY69yj6Yvklp
 rxEeaQ/+mrOaIuogteV1QzavUkBQ3HwgUMm2xiVo0/zP2Q8lhZ6fEgTipmphBgoHMeej
 DhkYNnIgX+LscFdkV6KykIUEClRDaTsZ1AMeFeU6fCuHi7cxmJfsUyrlwrqezhPsXavu
 Sitg==
X-Gm-Message-State: AOJu0YwVGbJ5JKa7EJE7ZkoNcS9LaqiaeGpPKiOTasFzjabdrXeKBzAy
 0z2ivHFhmLGcy8MWz6ZWdqpzggnVVFf5L/QtrER5Fmum+TQxC5IXTH0NfxQLXf1a1JhDS225v8v
 BF0fM
X-Gm-Gg: AeBDievZ6B04q0rxeIWMNhD405NI3nd6UE7HnamyKAhkSQ/WiU34T7Ha+nMmJiFqVTL
 csL+FR67yQMZVanAinxq3Cm5aNMjyJr1SezGfjGGe0z0CouX2jbvImarUi+mJHkMNgdhYFYSXTf
 qjRBaKg+Zj6HQH6EC3fopCmiW7RAPLSbhP5WQzhurQpUivu2oFenfJVf0h/62Em/zN2Jf9ZXFFv
 p2OXDhFjEiWVTFK5eAipj9els+XaHRKOfLXenkgLLa+EOnrxygYXPGbOVcmqx3xxrjOqDa4JCPa
 41fP2vV0SZzHAexaV+8MJO3quja78oN/ijNVW3ygAdiQbLcVEVzadNRVGxqJBxLoggLnAetxcpk
 XCARVI0V3isTj0xdSeY1tMC3mPsB64COMRvaQnlhIoZZQmCWWf0Q6cMaqyMxlpA00NAo9PLG4z7
 VpDdO5ebbsmXjYbKbgHhGaD2Mrotv0nXm3pbkEnb3Y+84=
X-Received: by 2002:a05:7300:a49a:b0:2d2:129a:1694 with SMTP id
 5a478bee46e88-2efb9e7bb88mr40071eec.18.1777653337135; 
 Fri, 01 May 2026 09:35:37 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee3889d5f0sm5196893eec.2.2026.05.01.09.35.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 09:35:36 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Weijun Pan <wpan3636@gmail.com>, Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v2 1/2] test: use inline helpers in buffer comparison macros
Date: Fri,  1 May 2026 09:34:45 -0700
Message-ID: <20260501163533.2689152-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260501163533.2689152-1-stephen@networkplumber.org>
References: <20260429144632.164970-1-stephen@networkplumber.org>
 <20260501163533.2689152-1-stephen@networkplumber.org>
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
   without parentheses, so callers passing expressions like
   "len = x | y" or "off = i + 1" could hit operator precedence
   bugs.

 - Arguments were evaluated multiple times.  For example
   TEST_ASSERT_BUFFERS_ARE_EQUAL_BIT expanded "len" six times and
   "a" / "b" twice each, so passing any expression with a side
   effect (i++, a function call, ...) would misbehave silently.

 - There was no type checking; memcmp accepts any pointer, and
   nothing constrained len/off to unsigned integers.

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

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Marat Khalili <marat.khalili@huawei.com>
Acked-by: Marat Khalili <marat.khalili@huawei.com>
---
 app/test/test.h | 146 ++++++++++++++++++++++++++++++------------------
 1 file changed, 93 insertions(+), 53 deletions(-)

diff --git a/app/test/test.h b/app/test/test.h
index 1f12fc5397..b29233bb32 100644
--- a/app/test/test.h
+++ b/app/test/test.h
@@ -6,12 +6,18 @@
 #define _TEST_H_
 
 #include <errno.h>
+#include <stdbool.h>
 #include <stddef.h>
+#include <stdint.h>
+#include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <sys/queue.h>
 
-#include <rte_hexdump.h>
+#include <rte_bitops.h>
 #include <rte_common.h>
+#include <rte_debug.h>
+#include <rte_hexdump.h>
 #include <rte_lcore.h>
 #include <rte_os_shim.h>
 
@@ -32,70 +38,104 @@
 
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
+	size_t len_bytes = len >> 3;
+	size_t len_bits = len & 7;
+
+	if (memcmp(pa, pb, len_bytes) != 0)
+		return false;
+	if (len_bits != 0) {
+		uint8_t mask = (uint8_t)RTE_GENMASK32(7, 8 - len_bits);
+
+		if ((pa[len_bytes] & mask) != (pb[len_bytes] & mask))
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
+		uint8_t mask = (uint8_t)RTE_GENMASK32(first_bits - 1, 0);
+
+		if ((pa[off_bytes] & mask) != (pb[off_bytes] & mask))
+			return false;
+		RTE_ASSERT(len >= first_bits);
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
+	if (memcmp((a), (b), (len)) != 0) {				\
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

