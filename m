Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0271910A88F5
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Mar 2026 17:49:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D72E40297;
	Thu, 26 Mar 2026 18:49:24 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id B4EE340274
 for <dev@dpdk.org>; Thu, 26 Mar 2026 18:49:23 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fhWV41dKLzHnGkM
 for <dev@dpdk.org>; Fri, 27 Mar 2026 01:48:44 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id F351140086
 for <dev@dpdk.org>; Fri, 27 Mar 2026 01:49:21 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 26 Mar 2026 18:49:21 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: <dev@dpdk.org>
Subject: [PATCH] test: parenthesize common macro arguments
Date: Thu, 26 Mar 2026 17:47:49 +0000
Message-ID: <20260326174749.40972-1-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema100007.china.huawei.com (7.182.19.38) To
 frapema500003.china.huawei.com (7.182.19.114)
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

Parenthesize argument substitutions in macros commonly used by tests.

Without parentheses around arguments macros like TEST_ASSERT_SUCCESS
could produce incorrect results if passed e.g. a ternary expression.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
Very curious how none of the code-checking tools we have like Coverity
flagged this trivial issue.

To highlight non-whitespace changes: git show --word-diff --anchored='/*'

 app/test/test.h            | 86 +++++++++++++++++++-------------------
 lib/eal/include/rte_test.h | 12 +++---
 2 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/app/test/test.h b/app/test/test.h
index 1f12fc5397a8..ad2347d3fe26 100644
--- a/app/test/test.h
+++ b/app/test/test.h
@@ -44,52 +44,24 @@
 
 /* Compare two buffers with offset (length and offset in bytes) */
 #define TEST_ASSERT_BUFFERS_ARE_EQUAL_OFFSET(a, b, len, off, msg, ...) do { \
-	const uint8_t *_a_with_off = (const uint8_t *)a + off;              \
-	const uint8_t *_b_with_off = (const uint8_t *)b + off;              \
+	const uint8_t *_a_with_off = (const uint8_t *)(a) + (off);          \
+	const uint8_t *_b_with_off = (const uint8_t *)(b) + (off);          \
 	TEST_ASSERT_BUFFERS_ARE_EQUAL(_a_with_off, _b_with_off, len, msg);  \
 } while (0)
 
 /* Compare two buffers (length in bits) */
-#define TEST_ASSERT_BUFFERS_ARE_EQUAL_BIT(a, b, len, msg, ...) do {	\
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
-} while (0)
-
-/* Compare two buffers with offset (length and offset in bits) */
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
+#define TEST_ASSERT_BUFFERS_ARE_EQUAL_BIT(a, b, len, msg, ...) do {           \
+	uint8_t _last_byte_a, _last_byte_b;                                   \
+	uint8_t _last_byte_mask, _last_byte_bits;                             \
+	TEST_ASSERT_BUFFERS_ARE_EQUAL(a, b, ((len) >> 3), msg);               \
+	if ((len) % 8) {                                                      \
+		_last_byte_bits = (len) % 8;                                  \
+		_last_byte_mask = ~((1 << (8 - _last_byte_bits)) - 1);        \
+		_last_byte_a = ((const uint8_t *)(a))[(len) >> 3];            \
+		_last_byte_b = ((const uint8_t *)(b))[(len) >> 3];            \
+		_last_byte_a &= _last_byte_mask;                              \
+		_last_byte_b &= _last_byte_mask;                              \
+		if (_last_byte_a != _last_byte_b) {                           \
 			printf("TestCase %s() line %d failed: "               \
 				msg "\n", __func__, __LINE__, ##__VA_ARGS__); \
 			TEST_TRACE_FAILURE(__FILE__, __LINE__, __func__);     \
@@ -98,6 +70,34 @@
 	}                                                                     \
 } while (0)
 
+/* Compare two buffers with offset (length and offset in bits) */
+#define TEST_ASSERT_BUFFERS_ARE_EQUAL_BIT_OFFSET(a, b, len, off, msg, ...) do { \
+	uint8_t _first_byte_a, _first_byte_b;                                   \
+	uint8_t _first_byte_mask, _first_byte_bits;                             \
+	uint32_t _len_without_first_byte = ((off) % 8) ?                        \
+				(len) - (8 - ((off) % 8)) :                     \
+				(len);                                          \
+	uint32_t _off_in_bytes = ((off) % 8) ? ((off) >> 3) + 1 : ((off) >> 3); \
+	const uint8_t *_a_with_off = (const uint8_t *)(a) + _off_in_bytes;      \
+	const uint8_t *_b_with_off = (const uint8_t *)(b) + _off_in_bytes;      \
+	TEST_ASSERT_BUFFERS_ARE_EQUAL_BIT(_a_with_off, _b_with_off,             \
+				_len_without_first_byte, msg);                  \
+	if ((off) % 8) {                                                        \
+		_first_byte_bits = 8 - ((off) % 8);                             \
+		_first_byte_mask = (1 << _first_byte_bits) - 1;                 \
+		_first_byte_a = *(_a_with_off - 1);                             \
+		_first_byte_b = *(_b_with_off - 1);                             \
+		_first_byte_a &= _first_byte_mask;                              \
+		_first_byte_b &= _first_byte_mask;                              \
+		if (_first_byte_a != _first_byte_b) {                           \
+			printf("TestCase %s() line %d failed: "                 \
+				msg "\n", __func__, __LINE__, ##__VA_ARGS__);   \
+			TEST_TRACE_FAILURE(__FILE__, __LINE__, __func__);       \
+			return TEST_FAILED;                                     \
+		}                                                               \
+	}                                                                       \
+} while (0)
+
 #define TEST_ASSERT_NOT_EQUAL RTE_TEST_ASSERT_NOT_EQUAL
 
 #define TEST_ASSERT_SUCCESS RTE_TEST_ASSERT_SUCCESS
@@ -198,7 +198,7 @@ void add_test_command(struct test_command *t);
 #define REGISTER_TEST_COMMAND(cmd, func) \
 	static struct test_command test_struct_##cmd = { \
 		.command = RTE_STR(cmd), \
-		.callback = func, \
+		.callback = (func), \
 	}; \
 	RTE_INIT(test_register_##cmd) \
 	{ \
diff --git a/lib/eal/include/rte_test.h b/lib/eal/include/rte_test.h
index 62c8f165af59..d132d3156b5a 100644
--- a/lib/eal/include/rte_test.h
+++ b/lib/eal/include/rte_test.h
@@ -26,21 +26,21 @@
 } while (0)
 
 #define RTE_TEST_ASSERT_EQUAL(a, b, msg, ...) \
-	RTE_TEST_ASSERT(a == b, msg, ##__VA_ARGS__)
+	RTE_TEST_ASSERT((a) == (b), msg, ##__VA_ARGS__)
 
 #define RTE_TEST_ASSERT_NOT_EQUAL(a, b, msg, ...) \
-	RTE_TEST_ASSERT(a != b, msg, ##__VA_ARGS__)
+	RTE_TEST_ASSERT((a) != (b), msg, ##__VA_ARGS__)
 
 #define RTE_TEST_ASSERT_SUCCESS(val, msg, ...) \
-	RTE_TEST_ASSERT(val == 0, msg, ##__VA_ARGS__)
+	RTE_TEST_ASSERT((val) == 0, msg, ##__VA_ARGS__)
 
 #define RTE_TEST_ASSERT_FAIL(val, msg, ...) \
-	RTE_TEST_ASSERT(val != 0, msg, ##__VA_ARGS__)
+	RTE_TEST_ASSERT((val) != 0, msg, ##__VA_ARGS__)
 
 #define RTE_TEST_ASSERT_NULL(val, msg, ...) \
-	RTE_TEST_ASSERT(val == NULL, msg, ##__VA_ARGS__)
+	RTE_TEST_ASSERT((val) == NULL, msg, ##__VA_ARGS__)
 
 #define RTE_TEST_ASSERT_NOT_NULL(val, msg, ...) \
-	RTE_TEST_ASSERT(val != NULL, msg, ##__VA_ARGS__)
+	RTE_TEST_ASSERT((val) != NULL, msg, ##__VA_ARGS__)
 
 #endif /* _RTE_TEST_H_ */
-- 
2.43.0

