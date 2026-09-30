Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AA9CA5FC4
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:44:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 446FE427D8;
	Thu,  1 Oct 2026 00:43:50 +0200 (CEST)
Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com
 [74.125.228.37]) by mails.dpdk.org (Postfix) with ESMTP id 3351A40E16
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:43:47 +0200 (CEST)
Received: by mail-pz2-f37.google.com with SMTP id
 41be03b00d2f7-cc7c9c2df74so617636a12.0
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808226;
 x=1791413026; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MjBr7fpdLUCVsN0c0INPnU0BR3PHtkidFNVGrVRas8U=;
 b=BI9fMnV2k8eegWvCRsAoL7ks5a16vSvrlGm0EoHYZRsUTWopyE+kujLh4LLxMi2b5r
 xO+0X9QxW2MeenVV5r9LR41Ul586Bz7fMOgy1cj5nknGOr4WpC5uvcmNJhfNDkP+sH1u
 4Hzg79cDMX+F7HfBu2G6LTug4L/1XjgcnGDFgWfV0cr3O1fxsyZMV7sK36pJEtljqxgM
 4bk73H2n54VPLUJA2hNVvSvjceus3NnJsTc38YNTMg/p2awOVW+9hDnCt1W3/Gdc9+1U
 BMEhNy/xpX2LolVoAXCPfgisEn/eBM4xxylVjXfJaGjmy+J8kqmxOY5MY3vyAyR6i77Y
 EAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808226; x=1791413026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MjBr7fpdLUCVsN0c0INPnU0BR3PHtkidFNVGrVRas8U=;
 b=fNkXybrM31rkNOvPekrhSdbGCJgyYwaJVvAs8XyBpgdfK/+lw9AGwUeWiErWYPDWF7
 lgrqPo884oI7P0KgXCwjJ4n4sumvQOuKNfzYodL+pG1xtyG1q2wjJ8f0Lg7nUEAkIf4Z
 cOtEBn+L7GULk9iiz5iasxrK264aeP5ESMcHi3gTlfQQwNPrf6ghAza7H5+uwwE8DTnT
 i33aULBPbDvJPQ4XQsKznh+8hcI7/C4ngSNqiIPR8YjNnXCJpCeNT1MFqHk0LzMLW7/M
 6CCYpRQlJqPKP1aTPWoLu+qXQkK7QshZytUuaXJ2f5hijw8xZmI/s66UfhyFyvsKNPuG
 VrwQ==
X-Gm-Message-State: AFq9FYJTco21rENaO8D37DERPt95HLuqS9HmmVqBJ1mG87qSc+nZAIh6
 BtWEeooHwWFe14wx6nBzZ52aBOqG0rjhwX/XmHM3Y6BCq/Dyqg+yLrh7G7KXBrhjC4hEdNGmmDJ
 mi1Ls8zs=
X-Gm-Gg: AYBFou3NqVWFaonnq/cFMVpStBxW2A4SRGyEAxB0dnXasHSTMyN0lmIuniZTQc1c+OT
 Y1IXpCnYCDkC0C9KlQbOHPQnYqyabt3Hf1vRrgMZlW632sdgnxXkU9qvmVwc80FVxguIZ5IfjOF
 jgTFn+gZljDvkIXOFxSS+2X1BQGm3060/ZDiAO+D+TBk+ts4MjPOT1eaT3ZOHu34e0KcZfEW4UR
 j2+QGahqhns9pOkepwHYgCdoZY0EpfrsrIXydx5vDpGLAi1dfURSWv1/tSw3Ueh5C1k64L9N+7i
 gencJi1DkjQqicvTnNy4R7JOENUY5GxeJQQMu8GiPDrQJsrv0boau5doYiP68KaXLdH52DPodPm
 sILSyStIbh4ieP+E/0tJpv6B5LFHXqGwr6Uqn0iiBFke24BanuY6MKPJnwmN56wC6ziLFpma71L
 Gdsw7G9Cri/YPvBt+yUnUoVc976Crt4fpfUVpgaSRGABdyOvr8EidHhQEtja3XFvQ+TrKmJQql8
 CJ4PAvzR2Z4Ro5Beg007Ux1eNmE0It29nj/AQ==
X-Received: by 2002:a17:90b:4ac3:b0:39e:6c68:fd8f with SMTP id
 98e67ed59e1d1-3a4f318ff56mr501609a91.36.1790808226102; 
 Wed, 30 Sep 2026 15:43:46 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:43:45 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v3 04/65] kvargs: add hexadecimal conversion helpers
Date: Wed, 30 Sep 2026 15:40:22 -0700
Message-ID: <20260930224340.58580-5-stephen@networkplumber.org>
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

Several device arguments are documented as a bare hexadecimal mask,
with no 0x prefix. Each place the driver open codes strtoull() with
base 16, and each gets the validation wrong in a one way or another.

Introduce a new helper to handle these type of args.
Add rte_kvargs_handle_hex32() and rte_kvargs_handle_hex64().

A sign is rejected, as it is for the unsigned handlers,
so a mask cannot be given as -1.

Only the 32 and 64 bit widths are added, since those are the only ones
any caller needs.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test/test_kvargs.c                 |  45 +++++++++
 doc/guides/rel_notes/release_26_11.rst |   8 +-
 lib/kvargs/rte_kvargs.c                | 131 ++++++++++++++++++++++---
 lib/kvargs/rte_kvargs.h                |  44 +++++++++
 4 files changed, 213 insertions(+), 15 deletions(-)

diff --git a/app/test/test_kvargs.c b/app/test/test_kvargs.c
index f05c7918e9..6e84ebf35c 100644
--- a/app/test/test_kvargs.c
+++ b/app/test/test_kvargs.c
@@ -475,6 +475,50 @@ test_handle_signed(void)
 	return TEST_SUCCESS;
 }
 
+static int
+test_handle_hex(void)
+{
+	uint64_t u = 0x5a;
+
+	/* The 0x prefix is optional, and a bare value is still hexadecimal. */
+	CHECK_GOOD(rte_kvargs_handle_hex32, uint32_t, "0xff", 0xff);
+	CHECK_GOOD(rte_kvargs_handle_hex32, uint32_t, "0XFF", 0xff);
+	CHECK_GOOD(rte_kvargs_handle_hex32, uint32_t, "ff", 0xff);
+	CHECK_GOOD(rte_kvargs_handle_hex32, uint32_t, "FF", 0xff);
+	/* "10" is sixteen here, not ten. */
+	CHECK_GOOD(rte_kvargs_handle_hex32, uint32_t, "10", 0x10);
+	CHECK_GOOD(rte_kvargs_handle_hex32, uint32_t, "0", 0);
+	CHECK_GOOD(rte_kvargs_handle_hex32, uint32_t, "00110F10", 0x00110f10);
+	CHECK_GOOD(rte_kvargs_handle_hex32, uint32_t, "ffffffff", 0xffffffff);
+	CHECK_BAD(rte_kvargs_handle_hex32, uint32_t, "100000000");
+	CHECK_BAD(rte_kvargs_handle_hex32, uint32_t, "");
+	CHECK_BAD(rte_kvargs_handle_hex32, uint32_t, "-1");
+	CHECK_BAD(rte_kvargs_handle_hex32, uint32_t, "0x");
+	CHECK_BAD(rte_kvargs_handle_hex32, uint32_t, "0x0x10");
+	CHECK_BAD(rte_kvargs_handle_hex32, uint32_t, "1g");
+	CHECK_BAD(rte_kvargs_handle_hex32, uint32_t, "0x1p");
+
+	CHECK_GOOD(rte_kvargs_handle_hex64, uint64_t, "0xF", 0xf);
+	CHECK_GOOD(rte_kvargs_handle_hex64, uint64_t, "F", 0xf);
+	CHECK_GOOD(rte_kvargs_handle_hex64, uint64_t, "ffffffffffffffff",
+		   UINT64_MAX);
+	CHECK_BAD(rte_kvargs_handle_hex64, uint64_t, "10000000000000000");
+	CHECK_BAD(rte_kvargs_handle_hex64, uint64_t, "-1");
+
+	/* The underlying conversion, with a mask narrower than the type. */
+	TEST_ASSERT_SUCCESS(rte_kvargs_to_hex("fff", 0xfff, &u), "fff in 0..fff");
+	TEST_ASSERT_EQUAL(u, 0xfffU, "wrong value");
+	TEST_ASSERT_EQUAL(rte_kvargs_to_hex("1000", 0xfff, &u), -ERANGE,
+			  "1000 should be out of 0..fff");
+	TEST_ASSERT_EQUAL(u, 0xfffU, "target clobbered on range error");
+	TEST_ASSERT_EQUAL(rte_kvargs_to_hex(NULL, 0xfff, &u), -EINVAL,
+			  "NULL should be rejected");
+	TEST_ASSERT_EQUAL(rte_kvargs_to_hex("f", 0xfff, NULL), -EINVAL,
+			  "a NULL result should be rejected");
+
+	return TEST_SUCCESS;
+}
+
 static int
 test_handle_bool(void)
 {
@@ -603,6 +647,7 @@ static struct unit_test_suite kvargs_test_suite  = {
 		TEST_CASE(test_invalid_kvargs),
 		TEST_CASE(test_handle_unsigned),
 		TEST_CASE(test_handle_signed),
+		TEST_CASE(test_handle_hex),
 		TEST_CASE(test_handle_bool),
 		TEST_CASE(test_handle_socket_id),
 		TEST_CASE(test_kvargs_to_range),
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 7225e9e787..27b3fe4253 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -156,9 +156,13 @@ New Features
   * ``rte_kvargs_handle_bool``, accepting ``1``, ``y``, ``yes``, ``on``,
     ``true`` and their negative counterparts. A bare ``key`` means true;
     an empty ``key=`` is rejected.
+  * ``rte_kvargs_handle_hex32`` and ``rte_kvargs_handle_hex64``, for the
+    arguments documented as a bare hexadecimal mask, where the value is
+    always read as hexadecimal whether or not it carries a ``0x`` prefix
 
-  Added ``rte_kvargs_to_uint`` and ``rte_kvargs_to_int`` for the cases where
-  a driver needs a narrower range than the target type allows.
+  Added ``rte_kvargs_to_uint``, ``rte_kvargs_to_int`` and
+  ``rte_kvargs_to_hex`` for the cases where a driver needs a narrower range
+  than the target type allows.
 
 
 Removed Items
diff --git a/lib/kvargs/rte_kvargs.c b/lib/kvargs/rte_kvargs.c
index 6e5e3fcd7c..22bde9616c 100644
--- a/lib/kvargs/rte_kvargs.c
+++ b/lib/kvargs/rte_kvargs.c
@@ -323,6 +323,35 @@ rte_kvargs_parse_delim(const char *args, const char * const valid_keys[],
 	return kvlist;
 }
 
+/*
+ * Skip over a "0x" prefix if there is one.
+ *
+ * Returns true if a prefix was consumed, and advances *str past it. Only one
+ * prefix is ever consumed: a second one is left in place so that the caller
+ * rejects it, since strtoull() would otherwise strip it itself and read
+ * "0x0x10" as sixteen rather than as the garbage it is.
+ */
+static bool
+kvargs_skip_hex_prefix(const char **str)
+{
+	const char *s = *str;
+
+	if (s[0] == '0' && (s[1] == 'x' || s[1] == 'X') &&
+	    isxdigit((unsigned char)s[2])) {
+		*str = s + 2;
+		return true;
+	}
+
+	return false;
+}
+
+/* Tell whether a "0x" prefix is present, without consuming it. */
+static bool
+kvargs_has_hex_prefix(const char *str)
+{
+	return str[0] == '0' && (str[1] == 'x' || str[1] == 'X');
+}
+
 /*
  * Determine the base of a numeric value and skip over its prefix.
  *
@@ -331,24 +360,15 @@ rte_kvargs_parse_delim(const char *args, const char * const valid_keys[],
  * has been a recurring source of surprise.
  *
  * Returns the base, and advances *str past the "0x" prefix if there is one.
- * Returns 0 if what follows the prefix is a second one: strtoull() would
- * strip that itself, making "0x0x10" sixteen rather than the garbage it is.
+ * Returns 0 if what follows the prefix is a second one, which is not a number.
  */
 static int
 kvargs_get_base(const char **str)
 {
-	const char *s = *str;
-
-	if (s[0] == '0' && (s[1] == 'x' || s[1] == 'X') &&
-	    isxdigit((unsigned char)s[2])) {
-		s += 2;
-		if (s[0] == '0' && (s[1] == 'x' || s[1] == 'X'))
-			return 0;
-		*str = s;
-		return 16;
-	}
+	if (!kvargs_skip_hex_prefix(str))
+		return 10;
 
-	return 10;
+	return kvargs_has_hex_prefix(*str) ? 0 : 16;
 }
 
 /* Skip trailing white space, and tell whether anything else is left. */
@@ -487,6 +507,46 @@ rte_kvargs_to_int(const char *value, int64_t min, int64_t max, int64_t *result)
 	return 0;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_kvargs_to_hex, 26.11)
+int
+rte_kvargs_to_hex(const char *value, uint64_t max, uint64_t *result)
+{
+	const char *str = value;
+	unsigned long long val;
+	char *endptr;
+
+	if (str == NULL || result == NULL)
+		return -EINVAL;
+
+	/* A mask has no sign; "-1" must not wrap around to UINT64_MAX. */
+	if (kvargs_get_sign(&str))
+		return -EINVAL;
+
+	/* The 0x prefix is optional here, but still accepted. */
+	if (kvargs_skip_hex_prefix(&str) && kvargs_has_hex_prefix(str))
+		return -EINVAL;	/* doubled 0x prefix */
+
+	if (!isxdigit((unsigned char)*str))
+		return -EINVAL;
+
+	errno = 0;
+	val = strtoull(str, &endptr, 16);
+	if (endptr == str)
+		return -EINVAL;
+	if (errno == ERANGE)
+		return -ERANGE;
+	if (errno != 0)
+		return -EINVAL;
+	if (!kvargs_at_end(endptr))
+		return -EINVAL;	/* trailing garbage */
+
+	if (val > max)
+		return -ERANGE;
+
+	*result = val;
+	return 0;
+}
+
 /*
  * The typed handlers below share this shape: convert with a range matching
  * the target type, then store. The target is written only on success, so a
@@ -710,6 +770,51 @@ rte_kvargs_handle_ulong(const char *key, const char *value, void *opaque)
 	return ret;
 }
 
+static int
+kvargs_store_hex(const char *key, const char *value, void *opaque,
+		 uint64_t max, uint64_t *val)
+{
+	int ret;
+
+	if (opaque == NULL)
+		return -EINVAL;
+
+	ret = rte_kvargs_to_hex(value, max, val);
+	if (ret < 0)
+		KVARGS_LOG(ERR, "invalid value \"%s\" for key \"%s\", expected 0..%" PRIx64 " in hex",
+			   value != NULL ? value : "", key != NULL ? key : "", max);
+
+	return ret;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_kvargs_handle_hex32, 26.11)
+int
+rte_kvargs_handle_hex32(const char *key, const char *value, void *opaque)
+{
+	uint64_t val;
+	int ret;
+
+	ret = kvargs_store_hex(key, value, opaque, UINT32_MAX, &val);
+	if (ret == 0)
+		*(uint32_t *)opaque = (uint32_t)val;
+
+	return ret;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_kvargs_handle_hex64, 26.11)
+int
+rte_kvargs_handle_hex64(const char *key, const char *value, void *opaque)
+{
+	uint64_t val;
+	int ret;
+
+	ret = kvargs_store_hex(key, value, opaque, UINT64_MAX, &val);
+	if (ret == 0)
+		*(uint64_t *)opaque = val;
+
+	return ret;
+}
+
 static const char * const kvargs_true[] = { "1", "y", "yes", "on", "true" };
 static const char * const kvargs_false[] = { "0", "n", "no", "off", "false" };
 
diff --git a/lib/kvargs/rte_kvargs.h b/lib/kvargs/rte_kvargs.h
index acc15607bc..fe18841709 100644
--- a/lib/kvargs/rte_kvargs.h
+++ b/lib/kvargs/rte_kvargs.h
@@ -330,6 +330,24 @@ int rte_kvargs_handle_ulong(const char *key, const char *value, void *opaque);
 __rte_experimental
 int rte_kvargs_handle_size(const char *key, const char *value, void *opaque);
 
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Convert a bit mask to uint32_t.
+ *
+ * As rte_kvargs_handle_u32(), except that the value is always read as
+ * hexadecimal, with or without a ``0x`` prefix, so ``10`` is sixteen. This
+ * is for arguments documented as a bare hexadecimal mask; use
+ * rte_kvargs_handle_u32() for a count or a size.
+ */
+__rte_experimental
+int rte_kvargs_handle_hex32(const char *key, const char *value, void *opaque);
+
+/** Convert a hexadecimal value to uint64_t. See rte_kvargs_handle_hex32(). */
+__rte_experimental
+int rte_kvargs_handle_hex64(const char *key, const char *value, void *opaque);
+
 /**
  * @warning
  * @b EXPERIMENTAL: this API may change without prior notice.
@@ -443,6 +461,32 @@ __rte_experimental
 int rte_kvargs_to_int(const char *value, int64_t min, int64_t max,
 	int64_t *result);
 
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Convert a hexadecimal string to an unsigned integer, checking it against
+ * a maximum.
+ *
+ * This is the conversion underlying rte_kvargs_handle_hex32(), and is the
+ * hexadecimal counterpart of rte_kvargs_to_uint(). The minimum is always
+ * zero, since a negative value is rejected rather than wrapped around.
+ *
+ * @param value
+ *   The string to convert. Must be non-NULL and non-empty.
+ * @param max
+ *   Largest acceptable value, inclusive.
+ * @param result
+ *   Where to store the converted value. Left unmodified on error.
+ *
+ * @return
+ *   - 0 on success.
+ *   - -EINVAL if the value is missing or malformed, or if @p result is NULL.
+ *   - -ERANGE if the value is greater than @p max.
+ */
+__rte_experimental
+int rte_kvargs_to_hex(const char *value, uint64_t max, uint64_t *result);
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.53.0

