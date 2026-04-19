Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A28FB44C2
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Apr 2026 07:06:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B8494066E;
	Fri, 24 Apr 2026 09:05:54 +0200 (CEST)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 by mails.dpdk.org (Postfix) with ESMTP id 16A6D402B5
 for <dev@dpdk.org>; Sun, 19 Apr 2026 18:48:46 +0200 (CEST)
Received: by mail-qt1-f181.google.com with SMTP id
 d75a77b69052e-50d8da3e656so27252961cf.1
 for <dev@dpdk.org>; Sun, 19 Apr 2026 09:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776617325; x=1777222125; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+Tsbf6frJpRJ0sHsOHkQ1ue8ac5SffTnF1tNHbd6ETc=;
 b=JS7o2KNGs/i20CyMEQHuobxwvR76OK0p8cW4r9QI2xrDVmPdM37T+kAJ9qsa4x0sE+
 FROX9ZpsV6qpxa0q6EYOAbI1CdS/OQ8ZRorAf0aGVXzqlkS5LLmkMUvZ+nWD3Fff8DBp
 79E+ApygygICAMJ1jDsoECVaPnuofWKq1MvR1hCQojcYfINOI+ueZbUmQwRet1mGJRKc
 i3MIWtVZvuPZSqSpCTE99ilcE/Xui2Y6ncJH8/zaYQWZVLVqAmMGuyfL++swf36O4d0d
 oItvclCVn7xoQtyRSWNbJjCUiLbtus6rnjHyrzpJm7x5izljfOx7m4L502oUxSIqYdpZ
 I5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776617325; x=1777222125;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Tsbf6frJpRJ0sHsOHkQ1ue8ac5SffTnF1tNHbd6ETc=;
 b=mGyg9vxnKdX+udRBxdMYiT8+9PC2Et4kFt+NIMF9H2ssfuwE0KSQO6KeR0Ii7jUQ1w
 TGwUwan3omEYUIPjIFEdqwZf+iuu33VFsd+vZoNZ0rQHdhQl6ZEBQRnCleZ4aOoB09A0
 UByILjbqngYGlwwAw9Y9T12lpnUy4zHDUYqtt94o6I2hCcOjIjlfAHhCtVl3B4RwvQpS
 z7L1/GvT/Wrat2V7Xis8uvu2BbbJ6KH6tGIIIy8lhAVi5f2Rw40Zjdum4wVTO+HZmh33
 7wJ8UZ+lGaLUdNjX3clUt0HawmwWUtYL60iP4exuRO2mfbmKBTQr07xzvPrboJAFADOO
 6+Lg==
X-Gm-Message-State: AOJu0YxvTdWWySic9pQxjhLUzeokrmDDlkMf256vg13hdhGi5p9mwaBl
 O5Fjaqaczqfq+NoRTzb6iPTqBHejqkV+MDqVMq7RWINCHpas22igWi9OwHPHPxqW
X-Gm-Gg: AeBDieuubGtON2pNfzp9p+a9NUY7EVyC+/hJpL70CpUETyke/v3u0UXVLuebwC9Vk3j
 K9L7FG1n048GBsAB4vN8dY3+gGC28l8hYGFTRaJ+aybYINMpSLhxuSGqh6pYBgbk/UonIZIPwM1
 pnV4gAYelUYKOraMLH9OLlwiTHfjZdsEP/zPOKUuC+WGRTtJwatFMC++XWQDZDZb4Wc1rZakJUG
 MVj3NCCPHi/kziuaYDg87s06lyCwhIm6YrbPlxRGBpil596adbp7IHLTSS7evaUY8IjaI3CjgBX
 SZuaODgYXgUV8+xEjsoVeMOGqX4WlUrWipz+4ckk8XEX8DSQe4Y40Tak/hHZeoJnSBoiXMZmy1R
 GmbQ3Hdep3bRGU5p/OI5I7c5XLZlCI4mRP6by3CDJNTkrKFDw1a3ds9TVxY5pXrTDtWCTBNb/dX
 LLmy/sMnvgIMCgoQOPgpuwqZc=
X-Received: by 2002:a05:622a:84:b0:50d:9efe:97e2 with SMTP id
 d75a77b69052e-50e36c4da3dmr155660041cf.44.1776617324961; 
 Sun, 19 Apr 2026 09:48:44 -0700 (PDT)
Received: from gmail.com ([50.93.222.110]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e3bf260fbsm72875771cf.10.2026.04.19.09.48.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 09:48:44 -0700 (PDT)
From: Weijun Pan <wpan3636@gmail.com>
X-Google-Original-From: Weijun Pan <wpan36@wisc.edu>
To: 
Cc: dev@dpdk.org,
	Weijun Pan <wpan36@wisc.edu>
Subject: [PATCH] test: parenthesize assertion macro parameters
Date: Sun, 19 Apr 2026 11:48:18 -0500
Message-Id: <20260419164818.20609-1-wpan36@wisc.edu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 24 Apr 2026 09:05:46 +0200
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

Some test assertion macros use parameters directly in expressions,
which can lead to unexpected evaluation due to operator precedence
after macro substitution.

Fix this by parenthesizing macro parameters and the resulting
expressions in rte_test.h and app/test/test.h.

Bugzilla ID: 1925

Signed-off-by: Weijun Pan <wpan36@wisc.edu>
---
 app/test/test.h            | 34 +++++++++++++++++-----------------
 lib/eal/include/rte_test.h | 12 ++++++------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/app/test/test.h b/app/test/test.h
index 1f12fc5397..b1174e4973 100644
--- a/app/test/test.h
+++ b/app/test/test.h
@@ -34,7 +34,7 @@
 
 /* Compare two buffers (length in bytes) */
 #define TEST_ASSERT_BUFFERS_ARE_EQUAL(a, b, len,  msg, ...) do {	\
-	if (memcmp(a, b, len)) {                                        \
+	if (memcmp((a), (b), (len))) {                                        \
 		printf("TestCase %s() line %d failed: "              \
 			msg "\n", __func__, __LINE__, ##__VA_ARGS__);    \
 		TEST_TRACE_FAILURE(__FILE__, __LINE__, __func__);    \
@@ -44,21 +44,21 @@
 
 /* Compare two buffers with offset (length and offset in bytes) */
 #define TEST_ASSERT_BUFFERS_ARE_EQUAL_OFFSET(a, b, len, off, msg, ...) do { \
-	const uint8_t *_a_with_off = (const uint8_t *)a + off;              \
-	const uint8_t *_b_with_off = (const uint8_t *)b + off;              \
-	TEST_ASSERT_BUFFERS_ARE_EQUAL(_a_with_off, _b_with_off, len, msg);  \
+	const uint8_t *_a_with_off = (const uint8_t *)(a) + (off);              \
+	const uint8_t *_b_with_off = (const uint8_t *)(b) + (off);              \
+	TEST_ASSERT_BUFFERS_ARE_EQUAL(_a_with_off, _b_with_off, (len), msg);  \
 } while (0)
 
 /* Compare two buffers (length in bits) */
 #define TEST_ASSERT_BUFFERS_ARE_EQUAL_BIT(a, b, len, msg, ...) do {	\
 	uint8_t _last_byte_a, _last_byte_b;                       \
 	uint8_t _last_byte_mask, _last_byte_bits;                  \
-	TEST_ASSERT_BUFFERS_ARE_EQUAL(a, b, (len >> 3), msg);     \
-	if (len % 8) {                                              \
-		_last_byte_bits = len % 8;                   \
+	TEST_ASSERT_BUFFERS_ARE_EQUAL((a), (b), ((len) >> 3), msg);     \
+	if ((len) % 8) {                                              \
+		_last_byte_bits = (len) % 8;                   \
 		_last_byte_mask = ~((1 << (8 - _last_byte_bits)) - 1); \
-		_last_byte_a = ((const uint8_t *)a)[len >> 3];            \
-		_last_byte_b = ((const uint8_t *)b)[len >> 3];            \
+		_last_byte_a = ((const uint8_t *)(a))[(len) >> 3];            \
+		_last_byte_b = ((const uint8_t *)(b))[(len) >> 3];            \
 		_last_byte_a &= _last_byte_mask;                     \
 		_last_byte_b &= _last_byte_mask;                    \
 		if (_last_byte_a != _last_byte_b) {                  \
@@ -74,16 +74,16 @@
 #define TEST_ASSERT_BUFFERS_ARE_EQUAL_BIT_OFFSET(a, b, len, off, msg, ...) do {	\
 	uint8_t _first_byte_a, _first_byte_b;                                 \
 	uint8_t _first_byte_mask, _first_byte_bits;                           \
-	uint32_t _len_without_first_byte = (off % 8) ?                       \
-				len - (8 - (off % 8)) :                       \
-				len;                                          \
-	uint32_t _off_in_bytes = (off % 8) ? (off >> 3) + 1 : (off >> 3);     \
-	const uint8_t *_a_with_off = (const uint8_t *)a + _off_in_bytes;      \
-	const uint8_t *_b_with_off = (const uint8_t *)b + _off_in_bytes;      \
+	uint32_t _len_without_first_byte = ((off) % 8) ?                       \
+				((len) - (8 - ((off) % 8))) :                       \
+				(len);                                          \
+	uint32_t _off_in_bytes = ((off) % 8) ? (((off) >> 3) + 1) : ((off) >> 3);     \
+	const uint8_t *_a_with_off = (const uint8_t *)(a) + _off_in_bytes;      \
+	const uint8_t *_b_with_off = (const uint8_t *)(b) + _off_in_bytes;      \
 	TEST_ASSERT_BUFFERS_ARE_EQUAL_BIT(_a_with_off, _b_with_off,           \
 				_len_without_first_byte, msg);                \
-	if (off % 8) {                                                        \
-		_first_byte_bits = 8 - (off % 8);                             \
+	if ((off) % 8) {                                                        \
+		_first_byte_bits = 8 - ((off) % 8);                             \
 		_first_byte_mask = (1 << _first_byte_bits) - 1;               \
 		_first_byte_a = *(_a_with_off - 1);                           \
 		_first_byte_b = *(_b_with_off - 1);                           \
diff --git a/lib/eal/include/rte_test.h b/lib/eal/include/rte_test.h
index 62c8f165af..b73d4e75c2 100644
--- a/lib/eal/include/rte_test.h
+++ b/lib/eal/include/rte_test.h
@@ -26,21 +26,21 @@
 } while (0)
 
 #define RTE_TEST_ASSERT_EQUAL(a, b, msg, ...) \
-	RTE_TEST_ASSERT(a == b, msg, ##__VA_ARGS__)
+	RTE_TEST_ASSERT(((a) == (b)), msg, ##__VA_ARGS__)
 
 #define RTE_TEST_ASSERT_NOT_EQUAL(a, b, msg, ...) \
-	RTE_TEST_ASSERT(a != b, msg, ##__VA_ARGS__)
+	RTE_TEST_ASSERT(((a) != (b)), msg, ##__VA_ARGS__)
 
 #define RTE_TEST_ASSERT_SUCCESS(val, msg, ...) \
-	RTE_TEST_ASSERT(val == 0, msg, ##__VA_ARGS__)
+	RTE_TEST_ASSERT(((val) == 0), msg, ##__VA_ARGS__)
 
 #define RTE_TEST_ASSERT_FAIL(val, msg, ...) \
-	RTE_TEST_ASSERT(val != 0, msg, ##__VA_ARGS__)
+	RTE_TEST_ASSERT(((val) != 0), msg, ##__VA_ARGS__)
 
 #define RTE_TEST_ASSERT_NULL(val, msg, ...) \
-	RTE_TEST_ASSERT(val == NULL, msg, ##__VA_ARGS__)
+	RTE_TEST_ASSERT(((val) == NULL), msg, ##__VA_ARGS__)
 
 #define RTE_TEST_ASSERT_NOT_NULL(val, msg, ...) \
-	RTE_TEST_ASSERT(val != NULL, msg, ##__VA_ARGS__)
+	RTE_TEST_ASSERT(((val) != NULL), msg, ##__VA_ARGS__)
 
 #endif /* _RTE_TEST_H_ */
-- 
2.34.1

