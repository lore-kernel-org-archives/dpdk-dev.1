Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67137CA5FA7
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:38:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC51242DD0;
	Tue, 29 Sep 2026 18:38:16 +0200 (CEST)
Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com
 [74.125.228.40]) by mails.dpdk.org (Postfix) with ESMTP id 1554C42670
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:12 +0200 (CEST)
Received: by mail-pz2-f40.google.com with SMTP id
 d2e1a72fcca58-8804b59404aso2146655b3a.3
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699891;
 x=1791304691; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j2pE2XY7yj2KugQGX28GmWoOb7k3KhF03PPLlNy8fl8=;
 b=HOzr0Uh12F0ICQbMHz/xVg7uBzMMS/lCoiEYuah6KTijnRPTn05GHtQ76xPUZbnB91
 uRo7yK0vXRo+KVfmY9FwIH6TS5CDlpS2gD/eeMeWm1hxn8VU+eTQsum2VKGAoKc5KhQF
 q2dVFgXsPy6zgXDocyt7WvJdtgLZyoW0XbzjLyYzXPYpSiLxCU+8oXEDj9n0I8VT4PXj
 qDMy9T98R97iSHlmWuZOhv5/Z0e40HujfLr7tJ90T/FuU8U9fO0/rYUi6gpt8ne17JO2
 Dt5paJKP+mKHXY+AfGRQKQxChrbw0xfSUWoQzjKJUm4jHKBueLX3lrw9TU6mF/sRTOmW
 wKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699891; x=1791304691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=j2pE2XY7yj2KugQGX28GmWoOb7k3KhF03PPLlNy8fl8=;
 b=YboMEppP+4tdkD4SSpENJzaOSgqIRjAOVnD+pZ0KL7KV4h1H8nUetk0HzGr5Skc9oc
 /R7EfxWLQrni53+mqQZaYLAoeszwd0Kqs3RKD6W7pfwPHNhLnNRxDtX/JMfIW6uIlO5s
 9ruK4ADxaxSnONk0t8busu6qesZug/3I6HiBHZKqM6KPqKm9heALki7aLFMBb13Q9Rwv
 ExgLac0Hkf/UoKeODfI/BrVX3rjJFl71Itc1P4D7t3I8LgrqK8gDFYbPd2iTYKqxpNKs
 q1l1TVEAXCJeE2EysOnRTLMgCq3uXiZeqgeZ8sprQhirlrrdosgnWeCMvD8r9cpevimA
 n0EQ==
X-Gm-Message-State: AFuF++m/vA03fOjPCzvLxmYrVBRUUBLdvZlSUI7pcDPJX3q/luP/goub
 xCED7OvpT8bgIdV3nOZaA3H+NQWYteFLyvr8ko7jQwBUiJf01MTHdyk2N9mf/rWnU2YHCIOQWrr
 Pq8IaFMw=
X-Gm-Gg: AYBFou22SRsPgVhyb2a+UkYtM+N/7+E4YICswe3cqVPAMTAIuQlEywLOPF0dKZ7JAHA
 4gyaBew/K02NSA3uEfkA9GZ4FEayHq8wODhvBIRBS8YHC+r4rN1SvYQ2e8jHZHR2NfVmsw8oGwt
 5Su/b95Rud168BtQZLgCf0Ok2vPZtIsSerPxGsNF2s9Lbd03hEwl90+V0yxGK0AYzRebvFJsWTx
 +C5u7sGOjBSg6f01egYmq+VyVAlBqW1WGbIklNb2dzpYnDuEUnFHxsLUVgnKJxXtUca1HKojE+S
 ydcYgSP7+n280vgxf33xFQj1mLufHGBcllk946lWmEIhZ+OA1wjq3GMrbiP8zbg/9j35SWhxJ49
 xpTkCKW6Bao6H/h0mcETPv6zRUl0G3AKq3SngibklwlKZntCYUn+hHEvl9dDd6Cqb5Ezg1afjrX
 NQ6X7e08eF6Xxpe9CpXIeepENQ6v1UE7+skFx31UkhcCPSVzyltNxLkguJRkp9x3GcPtGhTT+aB
 eFAogvCXfzv8rltKw08STB6/bLv2TOzvXAKpg==
X-Received: by 2002:a05:6a00:238c:b0:881:a443:497a with SMTP id
 d2e1a72fcca58-881a4435b14mr7938253b3a.0.1790699891139; 
 Tue, 29 Sep 2026 09:38:11 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:10 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 03/61] kvargs: add hexadecimal conversion helpers
Date: Tue, 29 Sep 2026 09:36:06 -0700
Message-ID: <20260929163800.1108305-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929163800.1108305-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260929163800.1108305-1-stephen@networkplumber.org>
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

Several device arguments are documented as a bare hexadecimal mask, with
no 0x prefix, such as the ice hw_debug_mask, the cxgbe filtermode
and filtermask, the hns3 dev_caps_mask and the ark Pkt_dir. Each
open codes strtoull() with base 16, and each gets the validation
wrong in a familiar way. ice checks errno but not the end pointer,
cxgbe checks errno without clearing it first, and hns3 checks
nothing at all, so dev_caps_mask=junk is silently taken as zero.

The existing helpers cannot be used for these. They read base 16 only
when the value carries an explicit 0x prefix, so a documented bare mask
containing a letter, such as "ff", would be rejected outright, while one
which happens to be all digits, such as "10", would be reread as decimal
and change from sixteen to ten.

The second case is the dangerous one: it silently changes the meaning of
a working command line instead of rejecting it, which is the one kind of
breakage the rest of this series is careful to avoid.

Add rte_kvargs_handle_hex32() and rte_kvargs_handle_hex64(), which are
the same as rte_kvargs_handle_u32() and rte_kvargs_handle_u64() except
that the value is always read as hexadecimal, whether or not it carries
a 0x prefix. Expose the underlying rte_kvargs_to_hex() for a mask
narrower than the target type.

A sign is rejected, as it is for the unsigned handlers, so a mask cannot
be given as -1.

Only the 32 and 64 bit widths are added, since those are the only ones
any caller needs; the family can be extended on demand.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
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
index 8a75a53ab7..af19196ba3 100644
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

