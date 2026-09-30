Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985C2CA5FC4
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:50:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 10D5543257;
	Thu,  1 Oct 2026 00:44:53 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id F3D7E42EEE
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:48 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-396ccb1a98dso3375075a91.0
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808288;
 x=1791413088; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EMIFGHPVQcKeHyfre/Rp8MNfGezeLLppTigA7Wk6MqY=;
 b=PCr6CYkOI03bGPnO15de5IUgMM9coB04uf4d32WxvZg6p93WveQkbHjqXjnDmXhRda
 nQokuctA0tJFlYsSkgN25IN51qd00o3Mo22j8LgAyfJW0shkhAWP5LVjIRhBkPvsgbu3
 U/c4Q9yGlUHDIbJ0jNvESqKqsYxhARSDQivpSCqsTcuNWF0K43epDZNVwzq73aT6LIw6
 Tq4wdYj/vXzNlkkpMtIuOJKXuTgdBOPn3F0iqTBXtDzkzG1u2shwHwfUNXqURIJlx0JV
 bjUCjW3CVNMdRs8BS0kDWHbaFTsJ5Nq82gTlyiCRbM0wVnUUrLRnPgIah9x7K515Qv3V
 D30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808288; x=1791413088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EMIFGHPVQcKeHyfre/Rp8MNfGezeLLppTigA7Wk6MqY=;
 b=RgGuKgwAd7XtVpylJAely/PaOvzW6rl/iWzSzB/BUCyktNNfw9NQsx+SwAF0JcMm4Q
 c06ZDa/xJ6R3mdNQhhPq1bqbOp7coJP73H55PwcYO6DAZ7Z3vWQ4fQ9uzwGwq3Yfif61
 7dZZsMMzBVADtRxYzAeqJTSEsR0Ljh5dvkzNlsCEMDW5c56VyM7Vn8nJ3feKlQLXKi13
 AuMOvVpz1PYKv6o+yink+va4qN1gHwC1fDB5UNLvqcVNVqmo24jbkQHjvJIDK1neKeUM
 Q1csShO1fPX/YNDY8LH8BzF60Dgo4EiwtUmq2PNArJ01U3X6fZ0jAvJGJ2XgmuF9N/LY
 Rsug==
X-Gm-Message-State: AFq9FYImOG/MyqP99JWZlzZ+zAPoFjqwgpgJMzg9QYGU8M32vBvXtcno
 oc2X+hRht6FmNiMe1tDLop/xDdYdYId0b9DPSThbpCzdlw/coOxjvl6VPo7esPVPlJFG7h3W1ti
 RzN4wIE4=
X-Gm-Gg: AYBFou22PJRcWGAh/E2EPrKpyApgjOTttlHP+LcLTUgZYE4l5UHFWy/8/5VA13gPTEn
 N0lMtb++AqJLdWFsvDNs9mwCrBaCMpo+eA2aeNPcedJbTtANq5+rdlmvsAM07O/+dr+PFjgfvdn
 nLZtF/dHuUf0Z0yrTemVO1N4+5H48qPF+jMvvACtPlceSL1qWKg1qBFTjO3+BSpVhMTUr6rf+Zh
 1nRtimg/a5MKbGMHeSP6W05Ozls43jOB7r6KV4N3+Dsfyx6WqbwGzbLiMAoFYNf0plmu+QnFxff
 gCBaRBEBjRkMi7JiLXIfwsKlKLB+Jal8QACrbwLvyGOyLRl1AHjiUMFvPiSFKmyTaGtS4HNzcrH
 S4cuWrScwqVAn9jn7dMf+MJkO6DCG4Efds8wYuBR1ya6BeUvMr9kMyQYlbbIs1EsW3vzT9Z0MRE
 pYtD7iR0tg34SeVly2xp4Aa27iRQznGscWo/KRDHrjJNVlzdBerA8KVdDGrj5FtyHGTaaC952IX
 Ph7GNrZcufXWAviChlipMxvu3OKiZGMW6JAgA==
X-Received: by 2002:a17:90a:e7c7:b0:3a2:af98:3c58 with SMTP id
 98e67ed59e1d1-3a4d059c0cbmr2822555a91.0.1790808287511; 
 Wed, 30 Sep 2026 15:44:47 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:47 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 62/65] kvargs: add range conversion handlers
Date: Wed, 30 Sep 2026 15:41:20 -0700
Message-ID: <20260930224340.58580-63-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930224340.58580-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260930224340.58580-1-stephen@networkplumber.org>
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

An argument whose valid range is narrower than the type it is stored in
cannot use the typed handlers, so drivers write a handler of their own
which calls rte_kvargs_to_uint() and stores the result. There are about
25 of these.

They do not report the same way. Of the call sites, 22 reject a bad
value with no message at all, so nothing tells the user what the range
was. Those which do log one each word it differently:

  net/af_xdp:   "Invalid busy_budget, must be >= 0 and <= %u"
  dma/skeleton: "Invalid %s, must be 0..%u"
  net/bnxt:     "Invalid parameter passed to rep_q_r2f devargs."

Add handlers which take the bounds from the caller:

    rte_kvargs_handle_urange
    rte_kvargs_handle_irange

A handler has only one opaque pointer, so the bounds are passed and the
result returned through a structure. As the typed handlers, the result
is written only on success, so seeding it with the default leaves it
alone when the key is absent and when the value is rejected.

A value outside the range is now reported as one which does not fit a
whole type already is, naming the key and the bounds.

kvargs_store_uint() grows a minimum to go with the maximum it already
had; the typed handlers pass zero.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_kvargs.c                 | 43 ++++++++++++++++++
 doc/guides/rel_notes/release_26_11.rst |  6 +++
 lib/kvargs/rte_kvargs.c                | 62 +++++++++++++++++++++-----
 lib/kvargs/rte_kvargs.h                | 57 +++++++++++++++++++++++
 4 files changed, 157 insertions(+), 11 deletions(-)

diff --git a/app/test/test_kvargs.c b/app/test/test_kvargs.c
index 6e84ebf35c..12e1376e86 100644
--- a/app/test/test_kvargs.c
+++ b/app/test/test_kvargs.c
@@ -619,6 +619,48 @@ test_kvargs_to_range(void)
 	return TEST_SUCCESS;
 }
 
+static int
+test_handle_range(void)
+{
+	struct rte_kvargs_urange u = { .min = 1, .max = 10, .val = 7 };
+	struct rte_kvargs_irange s = { .min = -10, .max = 10, .val = -7 };
+	struct rte_kvargs *kvlist;
+
+	TEST_ASSERT_SUCCESS(handle_one(rte_kvargs_handle_urange, "10", &u),
+			    "10 rejected in [1,10]");
+	TEST_ASSERT_EQUAL(u.val, 10U, "wrong value");
+
+	/* Out of range and malformed values leave the result alone. */
+	TEST_ASSERT_FAIL(handle_one(rte_kvargs_handle_urange, "11", &u),
+			 "11 accepted in [1,10]");
+	TEST_ASSERT_EQUAL(u.val, 10U, "target clobbered above the range");
+	TEST_ASSERT_FAIL(handle_one(rte_kvargs_handle_urange, "0", &u),
+			 "0 accepted in [1,10]");
+	TEST_ASSERT_EQUAL(u.val, 10U, "target clobbered below the range");
+	TEST_ASSERT_FAIL(handle_one(rte_kvargs_handle_urange, "x", &u),
+			 "\"x\" accepted");
+	TEST_ASSERT_EQUAL(u.val, 10U, "target clobbered on a bad value");
+
+	TEST_ASSERT_SUCCESS(handle_one(rte_kvargs_handle_irange, "-10", &s),
+			    "-10 rejected in [-10,10]");
+	TEST_ASSERT_EQUAL(s.val, -10, "wrong value");
+	TEST_ASSERT_FAIL(handle_one(rte_kvargs_handle_irange, "-11", &s),
+			 "-11 accepted in [-10,10]");
+	TEST_ASSERT_EQUAL(s.val, -10, "target clobbered below the range");
+
+	/* A key which is not present leaves the seeded default alone. */
+	u.val = 7;
+	kvlist = rte_kvargs_parse("other=1", NULL);
+	TEST_ASSERT_NOT_NULL(kvlist, "parse failed");
+	TEST_ASSERT_SUCCESS(rte_kvargs_process(kvlist, "k",
+					       rte_kvargs_handle_urange, &u),
+			    "processing an absent key failed");
+	rte_kvargs_free(kvlist);
+	TEST_ASSERT_EQUAL(u.val, 7U, "default lost when the key is absent");
+
+	return TEST_SUCCESS;
+}
+
 static struct unit_test_suite kvargs_test_suite  = {
 	.suite_name = "Kvargs Unit Test Suite",
 	.setup = NULL,
@@ -651,6 +693,7 @@ static struct unit_test_suite kvargs_test_suite  = {
 		TEST_CASE(test_handle_bool),
 		TEST_CASE(test_handle_socket_id),
 		TEST_CASE(test_kvargs_to_range),
+		TEST_CASE(test_handle_range),
 		TEST_CASES_END() /**< NULL terminate unit test array */
 	}
 };
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 27b3fe4253..e2cab9a484 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -164,6 +164,12 @@ New Features
   ``rte_kvargs_to_hex`` for the cases where a driver needs a narrower range
   than the target type allows.
 
+  Added ``rte_kvargs_handle_urange`` and ``rte_kvargs_handle_irange``,
+  which take the bounds and return the result through a
+  ``struct rte_kvargs_urange`` or ``struct rte_kvargs_irange``. An
+  argument whose valid range is narrower than its storage type no longer
+  needs a handler of its own, and a value outside the range is reported
+  as one which does not fit a whole type already is.
 
 Removed Items
 -------------
diff --git a/lib/kvargs/rte_kvargs.c b/lib/kvargs/rte_kvargs.c
index 22bde9616c..7d85e60092 100644
--- a/lib/kvargs/rte_kvargs.c
+++ b/lib/kvargs/rte_kvargs.c
@@ -554,17 +554,19 @@ rte_kvargs_to_hex(const char *value, uint64_t max, uint64_t *result)
  */
 static int
 kvargs_store_uint(const char *key, const char *value, void *opaque,
-		  uint64_t max, uint64_t *val)
+		  uint64_t min, uint64_t max, uint64_t *val)
 {
 	int ret;
 
 	if (opaque == NULL)
 		return -EINVAL;
 
-	ret = rte_kvargs_to_uint(value, 0, max, val);
+	ret = rte_kvargs_to_uint(value, min, max, val);
 	if (ret < 0)
-		KVARGS_LOG(ERR, "invalid value \"%s\" for key \"%s\", expected 0..%" PRIu64,
-			   value != NULL ? value : "", key != NULL ? key : "", max);
+		KVARGS_LOG(ERR,
+			   "invalid value \"%s\" for key \"%s\", expected %" PRIu64 "..%" PRIu64,
+			   value != NULL ? value : "", key != NULL ? key : "",
+			   min, max);
 
 	return ret;
 }
@@ -595,7 +597,7 @@ rte_kvargs_handle_u8(const char *key, const char *value, void *opaque)
 	uint64_t val;
 	int ret;
 
-	ret = kvargs_store_uint(key, value, opaque, UINT8_MAX, &val);
+	ret = kvargs_store_uint(key, value, opaque, 0, UINT8_MAX, &val);
 	if (ret == 0)
 		*(uint8_t *)opaque = (uint8_t)val;
 
@@ -609,7 +611,7 @@ rte_kvargs_handle_u16(const char *key, const char *value, void *opaque)
 	uint64_t val;
 	int ret;
 
-	ret = kvargs_store_uint(key, value, opaque, UINT16_MAX, &val);
+	ret = kvargs_store_uint(key, value, opaque, 0, UINT16_MAX, &val);
 	if (ret == 0)
 		*(uint16_t *)opaque = (uint16_t)val;
 
@@ -623,7 +625,7 @@ rte_kvargs_handle_u32(const char *key, const char *value, void *opaque)
 	uint64_t val;
 	int ret;
 
-	ret = kvargs_store_uint(key, value, opaque, UINT32_MAX, &val);
+	ret = kvargs_store_uint(key, value, opaque, 0, UINT32_MAX, &val);
 	if (ret == 0)
 		*(uint32_t *)opaque = (uint32_t)val;
 
@@ -637,7 +639,7 @@ rte_kvargs_handle_u64(const char *key, const char *value, void *opaque)
 	uint64_t val;
 	int ret;
 
-	ret = kvargs_store_uint(key, value, opaque, UINT64_MAX, &val);
+	ret = kvargs_store_uint(key, value, opaque, 0, UINT64_MAX, &val);
 	if (ret == 0)
 		*(uint64_t *)opaque = (uint64_t)val;
 
@@ -651,7 +653,7 @@ rte_kvargs_handle_uint(const char *key, const char *value, void *opaque)
 	uint64_t val;
 	int ret;
 
-	ret = kvargs_store_uint(key, value, opaque, UINT_MAX, &val);
+	ret = kvargs_store_uint(key, value, opaque, 0, UINT_MAX, &val);
 	if (ret == 0)
 		*(unsigned int *)opaque = (unsigned int)val;
 
@@ -665,7 +667,7 @@ rte_kvargs_handle_size(const char *key, const char *value, void *opaque)
 	uint64_t val;
 	int ret;
 
-	ret = kvargs_store_uint(key, value, opaque, SIZE_MAX, &val);
+	ret = kvargs_store_uint(key, value, opaque, 0, SIZE_MAX, &val);
 	if (ret == 0)
 		*(size_t *)opaque = (size_t)val;
 
@@ -763,7 +765,7 @@ rte_kvargs_handle_ulong(const char *key, const char *value, void *opaque)
 	uint64_t val;
 	int ret;
 
-	ret = kvargs_store_uint(key, value, opaque, ULONG_MAX, &val);
+	ret = kvargs_store_uint(key, value, opaque, 0, ULONG_MAX, &val);
 	if (ret == 0)
 		*(unsigned long *)opaque = (unsigned long)val;
 
@@ -873,3 +875,41 @@ rte_kvargs_handle_socket_id(const char *key, const char *value, void *opaque)
 
 	return ret;
 }
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_kvargs_handle_urange, 26.11)
+int
+rte_kvargs_handle_urange(const char *key, const char *value, void *opaque)
+{
+	struct rte_kvargs_urange *range = opaque;
+	uint64_t val;
+	int ret;
+
+	if (range == NULL)
+		return -EINVAL;
+
+	ret = kvargs_store_uint(key, value, opaque, range->min, range->max,
+				&val);
+	if (ret == 0)
+		range->val = val;
+
+	return ret;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_kvargs_handle_irange, 26.11)
+int
+rte_kvargs_handle_irange(const char *key, const char *value, void *opaque)
+{
+	struct rte_kvargs_irange *range = opaque;
+	int64_t val;
+	int ret;
+
+	if (range == NULL)
+		return -EINVAL;
+
+	ret = kvargs_store_int(key, value, opaque, range->min, range->max,
+			       &val);
+	if (ret == 0)
+		range->val = val;
+
+	return ret;
+}
diff --git a/lib/kvargs/rte_kvargs.h b/lib/kvargs/rte_kvargs.h
index fe18841709..ac79640085 100644
--- a/lib/kvargs/rte_kvargs.h
+++ b/lib/kvargs/rte_kvargs.h
@@ -487,6 +487,63 @@ int rte_kvargs_to_int(const char *value, int64_t min, int64_t max,
 __rte_experimental
 int rte_kvargs_to_hex(const char *value, uint64_t max, uint64_t *result);
 
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Range and result for rte_kvargs_handle_urange().
+ */
+struct rte_kvargs_urange {
+	uint64_t min;	/**< Smallest acceptable value, inclusive. */
+	uint64_t max;	/**< Largest acceptable value, inclusive. */
+	uint64_t val;	/**< The result, written only on success. */
+};
+
+/** Range and result for rte_kvargs_handle_irange(). */
+struct rte_kvargs_irange {
+	int64_t min;	/**< Smallest acceptable value, inclusive. */
+	int64_t max;	/**< Largest acceptable value, inclusive. */
+	int64_t val;	/**< The result, written only on success. */
+};
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Convert a key/value pair to an unsigned integer in a range.
+ *
+ * As rte_kvargs_handle_u8(), except that the bounds are given by the
+ * caller rather than by the target type. This is for an argument whose
+ * valid range is narrower than the type it is stored in.
+ *
+ * The bounds are passed and the result returned through the same
+ * structure, since a handler has only one opaque pointer. Seed ``val``
+ * with the default: it is left alone when the key is absent and when
+ * the value is rejected.
+ *
+ * @param key
+ *   The key, used for error reporting only. May be NULL.
+ * @param value
+ *   The value to convert.
+ * @param opaque
+ *   Pointer to a ``struct rte_kvargs_urange`` holding the range. On
+ *   success its ``val`` is set, on error it is left unmodified.
+ *
+ * @return
+ *   - 0 on success.
+ *   - -EINVAL if the value is missing or malformed, or if @p opaque is NULL.
+ *   - -ERANGE if the value is outside the range.
+ */
+__rte_experimental
+int rte_kvargs_handle_urange(const char *key, const char *value, void *opaque);
+
+/**
+ * Convert a value to a signed integer in a range, taking a
+ * ``struct rte_kvargs_irange``. See rte_kvargs_handle_urange().
+ */
+__rte_experimental
+int rte_kvargs_handle_irange(const char *key, const char *value, void *opaque);
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.53.0

