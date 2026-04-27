Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE1DFF8867
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 09:59:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B2D5E4067C;
	Wed, 29 Apr 2026 11:58:27 +0200 (CEST)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com
 [209.85.167.175])
 by mails.dpdk.org (Postfix) with ESMTP id BAE91402EA
 for <dev@dpdk.org>; Mon, 27 Apr 2026 19:18:03 +0200 (CEST)
Received: by mail-oi1-f175.google.com with SMTP id
 5614622812f47-463a0e14abfso5255572b6e.2
 for <dev@dpdk.org>; Mon, 27 Apr 2026 10:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777310283; x=1777915083; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KzeNRM7R8IhG1qe0Pbw0+8JnbH2cmqfUM23bleFmGIE=;
 b=Ti/RpBtUOBaGT2dvomJZM5kiIyTZrkcgP4mRWfvO+s0vjhZYXkRuzhPPK6izm8xz6U
 zy2HNdr1SRyu8kePkDv6sCnZxsa+WrTw8NgHkPdZ2d7aaWk51mJnTk4BUHccAwRWYt0N
 gzq4izZwZ4I0muKYOL2mM6SPqnSR6sctG2Uk5JbEpwETd9ViFxl1iblcrVdKpv1nnRnx
 8iYjnSR1sIAKCs7/uqD4RD5hbAgLQqQ8rbNPMkT5S84WC7Adwa069zLfeur9lfIFgolN
 4U9PuHcfik+BQ+tICCc+7niI63P/h+9PgaXU17nFKIa2/0gzseyrcDG+1O3Q9aAgg4yL
 Fk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777310283; x=1777915083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KzeNRM7R8IhG1qe0Pbw0+8JnbH2cmqfUM23bleFmGIE=;
 b=dCe9QEbOauAshgepbM1ceJX8XoT9sU+UY/0z8UUZKry051dtjjoiUdqAeDly+7yCOE
 8FOEiFGwqvDs3J4Qa7BuqZGrwpyuHD/Mzzx+cNogJXXTmkJu67jd6ANMWrpmEw+R/4F9
 ZhTYWbRgPl9A2Qp8abX7t9N3pB2B2gYprtiaBwnG58H6yMw/TP4SVbvcoLo1JStcBqAd
 WyXsagCLdFC1+loRZKAhfvXxI54b8FqTKKt/HIqAwBuPBft32rFx0llo4lWapLwy9wXV
 5h2dpEJ4CIz1K793uRT264XFO4IzPU/e4tl386K9ZqGvr0uDw3llNSUPe5LyvxE+l3Ql
 MHsg==
X-Gm-Message-State: AOJu0Yy8q4NVvln6v+sEFuNosrYNbQdJygp0gqt3USPka6q6vYsXNTke
 S9FgXuU4XMREU8a3LSOSOTeJnvq0JXn6HNXfKSo9E9j0biK/UqVIC4kPcoRIflnQ
X-Gm-Gg: AeBDiev2VjLl8F2WuYvoToOzEDmEnIC7oN0XDnNf3w6fdGoL9vAmZq9ps6mjtI7i+Rb
 eIMYIkYCLm6NHHBskA46FZXcz0aOx4/L0mHBdo/uPYY/9SpcRhaqjMpL0+hTtKSuvAUP5oz5WaS
 VPCT/8pLKajzuMXYurX+nbRUz99Cgmuzr4SzkA5a7od1jQEHRg77W3iiYSXUjV1nlf6lHagxcim
 ibfvFzwInow9Wck2I89UHEsiAbDOqJtFpDp94ArsbWArrmJELb1ilzAwTLyCnwzjZydp1xyAKUl
 ZzGm9Jg/pgi2q3I30KCdG9fqEBQZ04mdXDoiztoLNJkjOhaUUV96OjzuhA5HUv5b0YNIfYgFYN6
 lbwDDefd8/epqBCtzcJHKLPv5KImYD+vZ7rw4km8m0FvP6wRhiJERWHkOQ+S6pqGzsR+PZmawrb
 n3bs4vYmVj4VeXXRI1noQEbbr6NAo=
X-Received: by 2002:a05:6808:c284:b0:467:eccb:b788 with SMTP id
 5614622812f47-47c26cdf1c9mr8324b6e.9.1777310282419; 
 Mon, 27 Apr 2026 10:18:02 -0700 (PDT)
Received: from gmail.com ([50.93.222.110]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7de984bddd7sm38298a34.3.2026.04.27.10.18.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 10:18:01 -0700 (PDT)
From: Weijun Pan <wpan3636@gmail.com>
To: 
Cc: dev@dpdk.org,
	Weijun Pan <wpan3636@gmail.com>
Subject: [PATCH v2] test: parenthesize assertion macro parameters
Date: Mon, 27 Apr 2026 12:17:13 -0500
Message-Id: <20260427171714.9887-1-wpan3636@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260419164818.20609-1-wpan36@wisc.edu>
References: <20260419164818.20609-1-wpan36@wisc.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 29 Apr 2026 11:58:18 +0200
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

This is a test macro robustness fix and does not fix a runtime issue
in DPDK, so no Fixes or stable tags are added.

Bugzilla ID: 1925

Signed-off-by: Weijun Pan <wpan3636@gmail.com>

---
v2:
- Remove unnecessary parentheses surrounded by commas
- Keep parenthesize substitutions even in unambiguous places in rte_test.h
  to maintain coding style: parenthesize a condition
- Keep msg unparenthesized to preserve string literal concatenation
---
 app/test/test.h            | 30 +++++++++++++++---------------
 lib/eal/include/rte_test.h | 12 ++++++------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/app/test/test.h b/app/test/test.h
index 1f12fc5397..e7539418a8 100644
--- a/app/test/test.h
+++ b/app/test/test.h
@@ -44,8 +44,8 @@
 
 /* Compare two buffers with offset (length and offset in bytes) */
 #define TEST_ASSERT_BUFFERS_ARE_EQUAL_OFFSET(a, b, len, off, msg, ...) do { \
-	const uint8_t *_a_with_off = (const uint8_t *)a + off;              \
-	const uint8_t *_b_with_off = (const uint8_t *)b + off;              \
+	const uint8_t *_a_with_off = (const uint8_t *)(a) + (off);              \
+	const uint8_t *_b_with_off = (const uint8_t *)(b) + (off);              \
 	TEST_ASSERT_BUFFERS_ARE_EQUAL(_a_with_off, _b_with_off, len, msg);  \
 } while (0)
 
@@ -53,12 +53,12 @@
 #define TEST_ASSERT_BUFFERS_ARE_EQUAL_BIT(a, b, len, msg, ...) do {	\
 	uint8_t _last_byte_a, _last_byte_b;                       \
 	uint8_t _last_byte_mask, _last_byte_bits;                  \
-	TEST_ASSERT_BUFFERS_ARE_EQUAL(a, b, (len >> 3), msg);     \
-	if (len % 8) {                                              \
-		_last_byte_bits = len % 8;                   \
+	TEST_ASSERT_BUFFERS_ARE_EQUAL(a, b, ((len) >> 3), msg);     \
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

