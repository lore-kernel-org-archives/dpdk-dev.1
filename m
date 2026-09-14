Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBDBC88E67
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:49:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1812F4068A;
	Mon, 14 Sep 2026 07:49:32 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 3184440698
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:49:30 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-39dbdfaef3cso1552672a91.1
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789364969;
 x=1789969769; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RMvRtxHYbdq541HgDic1Ne8WPDJQvQMQ4Oaq+f9klxQ=;
 b=wCLaLkg8OHZkJFHWcR0qG677o5l40hQZ6MhGiszBDb0vbEz43FMmzA9sCjGQHaDNEe
 wy+aZ6IH6ZJugi3sjpguRe1q91rqF1ZEafGJ5SptDMefjqvmzffMweFMBTDxid4oa+0E
 r6MCxHUBRE7zafLcjCZdoKn4RlOUZ7gaII84Jc4jUdZxXOqhOl1xk0qjS1J2jbqIQ/BX
 d1E1aIKOSWoSa/cljcxZQQyh0H7cOOZlpePe6yD58ms7EGT/CDmkxqNrDbuemXgxJHei
 dIHBgJw6iG0NmI0UGP4geHei2XJnk5zTbR0iHWkeK4lKG4eVs4swHomE/8ZaFTWnSLLt
 3enQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789364969; x=1789969769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RMvRtxHYbdq541HgDic1Ne8WPDJQvQMQ4Oaq+f9klxQ=;
 b=q3h/Cui18bDDcyanK7iemLd5HCkL+Bs/zI/bM+5RdnhlcOE+PATiqSLBidvJeT7O9Z
 KBXSAZ0kA7H73X92RaHf2ATFg7nNihoKpqgAP3HC40/hQClNxR8z0CbY+QhCtayHrXav
 u23z1wU73jmkBNclRh1DcZf01HUAEQDxAi9+hRJnMInEDDIqBSNssid3+Uxu4/xQHuq0
 teZUWBeuY/16U5T6qXEeEDGwELDc+cHNe2QHQEm/Zdt1VXlGnNzKljDSVQ9oRk5fhpEC
 mxZMqhuvtCtC9gyhFi0zKeh+FvkFf78vGsi34LjqsUmGPH91tz+YQryFcHvT9Q/x+aMa
 IXnQ==
X-Gm-Message-State: AFuF++lVPB42n9qxIskWnQWNXlgrcih/luEIgCbCUmYpDy4oAqBpOV6s
 4rdw2bNotyciVjSf0RqHCqk4oIbZvyBV5azAlpDMOUA9VRRorCoUDHcHpGzuTFOj0IUWUQuwS4V
 I075X
X-Gm-Gg: AYBFou3FrjRQl6MoFMtLPW/ziHXN5AQBtMUdoxhHxXSY4s7Rlu1NltO+5cWmrCJynEK
 x3jc/TyfCHk3JwLfVnGsFhQf87sjC8+QTqSUDwEkwABKaAprmPMKH6DyZAEa1e9GrckoN4YGSYi
 sXWmMaICXbIFZTC+UVAie1xJQsiux47pysoQOVRRjOMbq87EK6crCfqYRMDZkaKTmvEH/wpSHjT
 HMT5EzoEXjFVMmhsPbgzidFlRWQNlVTjvzas9WH03bet4wgAo5aRR4RGoESPIQxUJ+D/Ksmnll1
 rfuWmMEBqqPKu5qykVaNa3nR6N65oispCBSKCiNqvSi0zM3VGdqfqyTkSVJ/v92tuPiI3qLh9rI
 RI8KM2cNofkMrCHJqEHAm9I6bs5AK8Lxe8cWZ78QBT4AVrSZmooXooFbHfwX5Fchh6P7czvKaOB
 MF9+K+CyzDJ3inVguz0M1eZy7goKhJQPDor2bIM8p0bU/AjgQDFfXkLhLHjjEanlDoVpnvpYzxu
 rNfGk8RpXElxYe1zjJoyGFmESqMN47mGzbyFw==
X-Received: by 2002:a17:90b:2f8b:b0:39d:f259:3351 with SMTP id
 98e67ed59e1d1-39df25936a9mr121012a91.0.1789364968945; 
 Sun, 13 Sep 2026 22:49:28 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.49.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:49:28 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 02/62] kvargs: add numeric conversion helpers
Date: Sun, 13 Sep 2026 22:46:33 -0700
Message-ID: <20260914054912.755403-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914054912.755403-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
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

Drivers which take numeric values in devargs each open code the
conversion from string to integer, and often get it wrong.
A survey of the tree finds at least fifteen separate
implementations of "parse an unsigned integer devarg", of which two are
exported from lib/ and byte for byte identical to each other.

The recurring bugs are:

  - atoi() is used, so overflow is undefined and nothing is validated;
  - errno is checked without being reset first, so an unrelated earlier
    failure rejects a valid value;
  - errno is checked but endptr is not, so "foo" is silently accepted
    as zero;
  - endptr is checked but errno is not, so an overflowing value is
    accepted as ULLONG_MAX;
  - the result is stored into a narrower type with no range check, so
    nb_desc=65537 silently becomes 1;
  - strtoul() is used for an unsigned target, so a leading '-' is
    accepted and wrapped around, and dev_caps_mask=-1 enables
    everything;
  - the value is dereferenced without checking for NULL, so a key given
    with no value segfaults;
  - base 0 is passed, so a leading zero unexpectedly selects octal.

Add a set of helpers matching arg_handler_t, so they can be passed
straight to rte_kvargs_process(), covering the integer types drivers
actually store into. Each validates the whole string and only writes
the target on success, so a caller supplied default survives a bad
argument.

Add rte_kvargs_handle_bool for on/off style arguments. It accepts the
word forms which only sfc supports today, and treats a key given
without a value as true.

Where a driver needs a range narrower than the target type, expose the
underlying rte_kvargs_to_uint and rte_kvargs_to_int.

Octal is deliberately not supported: no driver documents it, and
reading "010" as eight has been a recurring surprise.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_kvargs.c                 | 221 +++++++++++++
 doc/guides/prog_guide/devargs.rst      |  18 +
 doc/guides/rel_notes/release_26_11.rst |  20 ++
 lib/kvargs/rte_kvargs.c                | 440 +++++++++++++++++++++++++
 lib/kvargs/rte_kvargs.h                | 186 +++++++++++
 5 files changed, 885 insertions(+)

diff --git a/app/test/test_kvargs.c b/app/test/test_kvargs.c
index a14b75948a..b74dfd6acb 100644
--- a/app/test/test_kvargs.c
+++ b/app/test/test_kvargs.c
@@ -2,6 +2,8 @@
  * Copyright 2014 6WIND S.A.
  */
 
+#include <errno.h>
+#include <stdint.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
@@ -328,6 +330,221 @@ static int test_invalid_kvargs(void)
 	return -1;
 }
 
+/* Check the numeric conversion helpers on a value passed through kvargs. */
+static int
+handle_one(arg_handler_t handler, const char *value, void *opaque)
+{
+	struct rte_kvargs *kvlist;
+	char args[128];
+	int ret;
+
+	if (value != NULL)
+		snprintf(args, sizeof(args), "k=%s", value);
+	else
+		snprintf(args, sizeof(args), "k");
+
+	kvlist = rte_kvargs_parse(args, NULL);
+	if (kvlist == NULL)
+		return -1;
+
+	ret = rte_kvargs_process_opt(kvlist, "k", handler, opaque);
+	rte_kvargs_free(kvlist);
+
+	/* rte_kvargs_process_opt() flattens the handler error to -1. */
+	return ret;
+}
+
+/* A handler must accept a good value, and leave the target alone otherwise. */
+#define CHECK_GOOD(handler, type, str, expected) do { \
+	type v = (type)0x5a; \
+	TEST_ASSERT_SUCCESS(handle_one(handler, str, &v), \
+			    "%s rejected \"%s\"", #handler, str); \
+	TEST_ASSERT_EQUAL(v, (type)(expected), \
+			  "%s(\"%s\") gave the wrong value", #handler, str); \
+} while (0)
+
+#define CHECK_BAD(handler, type, str) do { \
+	type v = (type)0x5a; \
+	TEST_ASSERT_FAIL(handle_one(handler, str, &v), \
+			 "%s accepted \"%s\"", #handler, str); \
+	TEST_ASSERT_EQUAL(v, (type)0x5a, \
+			  "%s clobbered the target on \"%s\"", #handler, str); \
+} while (0)
+
+static int
+test_handle_unsigned(void)
+{
+	CHECK_GOOD(rte_kvargs_handle_u8, uint8_t, "0", 0);
+	CHECK_GOOD(rte_kvargs_handle_u8, uint8_t, "255", 255);
+	CHECK_GOOD(rte_kvargs_handle_u8, uint8_t, "0xff", 255);
+	CHECK_GOOD(rte_kvargs_handle_u8, uint8_t, "0XFF", 255);
+	CHECK_GOOD(rte_kvargs_handle_u8, uint8_t, "+7", 7);
+	/* A leading zero must not select octal. */
+	CHECK_GOOD(rte_kvargs_handle_u8, uint8_t, "010", 10);
+	CHECK_BAD(rte_kvargs_handle_u8, uint8_t, "256");
+	CHECK_BAD(rte_kvargs_handle_u8, uint8_t, "-1");
+
+	CHECK_GOOD(rte_kvargs_handle_u16, uint16_t, "65535", 65535);
+	CHECK_BAD(rte_kvargs_handle_u16, uint16_t, "65536");
+
+	CHECK_GOOD(rte_kvargs_handle_u32, uint32_t, "4294967295", UINT32_MAX);
+	CHECK_BAD(rte_kvargs_handle_u32, uint32_t, "4294967296");
+
+	CHECK_GOOD(rte_kvargs_handle_u64, uint64_t, "18446744073709551615",
+		   UINT64_MAX);
+	CHECK_GOOD(rte_kvargs_handle_u64, uint64_t, "0xffffffffffffffff",
+		   UINT64_MAX);
+	CHECK_BAD(rte_kvargs_handle_u64, uint64_t, "18446744073709551616");
+
+	CHECK_GOOD(rte_kvargs_handle_uint, unsigned int, "42", 42);
+	CHECK_GOOD(rte_kvargs_handle_size, size_t, "42", 42);
+
+	/* Malformed values, rejected for every width. */
+	CHECK_BAD(rte_kvargs_handle_u32, uint32_t, "");
+	CHECK_BAD(rte_kvargs_handle_u32, uint32_t, "abc");
+	CHECK_BAD(rte_kvargs_handle_u32, uint32_t, "12abc");
+	CHECK_BAD(rte_kvargs_handle_u32, uint32_t, "12 34");
+	CHECK_BAD(rte_kvargs_handle_u32, uint32_t, "0x");
+	CHECK_BAD(rte_kvargs_handle_u32, uint32_t, "0x0x10");
+	CHECK_BAD(rte_kvargs_handle_u32, uint32_t, "0X0X10");
+	CHECK_BAD(rte_kvargs_handle_u32, uint32_t, "--1");
+	CHECK_BAD(rte_kvargs_handle_u32, uint32_t, "+-1");
+	/* strtoull() would skip the space and negate what follows. */
+	CHECK_BAD(rte_kvargs_handle_u32, uint32_t, "+ 1");
+	CHECK_BAD(rte_kvargs_handle_u32, uint32_t, "- 1");
+	CHECK_BAD(rte_kvargs_handle_u32, uint32_t, "+ -1");
+	/* Trailing white space is fine, though. */
+	CHECK_GOOD(rte_kvargs_handle_u32, uint32_t, " 12 ", 12);
+
+	/* A key with no value at all. */
+	{
+		uint32_t v = 0x5a;
+
+		TEST_ASSERT_FAIL(handle_one(rte_kvargs_handle_u32, NULL, &v),
+				 "u32 accepted a key with no value");
+		TEST_ASSERT_EQUAL(v, 0x5aU, "target clobbered");
+	}
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_handle_signed(void)
+{
+	CHECK_GOOD(rte_kvargs_handle_i8, int8_t, "-128", -128);
+	CHECK_GOOD(rte_kvargs_handle_i8, int8_t, "127", 127);
+	CHECK_BAD(rte_kvargs_handle_i8, int8_t, "-129");
+	CHECK_BAD(rte_kvargs_handle_i8, int8_t, "128");
+
+	CHECK_GOOD(rte_kvargs_handle_i16, int16_t, "-32768", -32768);
+	CHECK_BAD(rte_kvargs_handle_i16, int16_t, "32768");
+
+	CHECK_GOOD(rte_kvargs_handle_i32, int32_t, "-2147483648", INT32_MIN);
+	CHECK_BAD(rte_kvargs_handle_i32, int32_t, "2147483648");
+
+	/* INT64_MIN has a magnitude one past INT64_MAX. */
+	CHECK_GOOD(rte_kvargs_handle_i64, int64_t, "-9223372036854775808",
+		   INT64_MIN);
+	CHECK_GOOD(rte_kvargs_handle_i64, int64_t, "9223372036854775807",
+		   INT64_MAX);
+	CHECK_BAD(rte_kvargs_handle_i64, int64_t, "9223372036854775808");
+	CHECK_BAD(rte_kvargs_handle_i64, int64_t, "-9223372036854775809");
+
+	/* A sign in front of a hex value. */
+	CHECK_GOOD(rte_kvargs_handle_i32, int32_t, "-0x10", -16);
+	CHECK_BAD(rte_kvargs_handle_i32, int32_t, "-0x0x10");
+
+	CHECK_GOOD(rte_kvargs_handle_int, int, "-1", -1);
+	CHECK_GOOD(rte_kvargs_handle_int, int, "+1", 1);
+	CHECK_BAD(rte_kvargs_handle_int, int, "");
+	CHECK_BAD(rte_kvargs_handle_int, int, "1x");
+	CHECK_BAD(rte_kvargs_handle_int, int, "-");
+	CHECK_BAD(rte_kvargs_handle_int, int, "- 1");
+	CHECK_BAD(rte_kvargs_handle_int, int, "--1");
+
+	CHECK_GOOD(rte_kvargs_handle_long, long, "-1", -1);
+	CHECK_GOOD(rte_kvargs_handle_long, long, "+1", 1);
+	CHECK_BAD(rte_kvargs_handle_long, long, "");
+	CHECK_BAD(rte_kvargs_handle_long, long, "1x");
+
+	CHECK_GOOD(rte_kvargs_handle_ulong, unsigned long, "1", 1);
+	CHECK_GOOD(rte_kvargs_handle_ulong, unsigned long, "0x10", 16);
+	CHECK_BAD(rte_kvargs_handle_ulong, unsigned long, "-1");
+	CHECK_BAD(rte_kvargs_handle_ulong, unsigned long, "1x");
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_handle_bool(void)
+{
+	static const char * const yes[] = {
+		"1", "y", "Y", "yes", "YES", "on", "On", "true", "TRUE",
+	};
+	static const char * const no[] = {
+		"0", "n", "N", "no", "NO", "off", "Off", "false", "FALSE",
+	};
+	unsigned int i;
+	bool v;
+
+	for (i = 0; i < RTE_DIM(yes); i++) {
+		v = false;
+		TEST_ASSERT_SUCCESS(handle_one(rte_kvargs_handle_bool, yes[i], &v),
+				    "bool rejected \"%s\"", yes[i]);
+		TEST_ASSERT(v, "\"%s\" should be true", yes[i]);
+	}
+
+	for (i = 0; i < RTE_DIM(no); i++) {
+		v = true;
+		TEST_ASSERT_SUCCESS(handle_one(rte_kvargs_handle_bool, no[i], &v),
+				    "bool rejected \"%s\"", no[i]);
+		TEST_ASSERT(!v, "\"%s\" should be false", no[i]);
+	}
+
+	/* A bare key is enough to enable the option. */
+	v = false;
+	TEST_ASSERT_SUCCESS(handle_one(rte_kvargs_handle_bool, NULL, &v),
+			    "bool rejected a key with no value");
+	TEST_ASSERT(v, "a key with no value should be true");
+
+	/* But a blank value is not a missing one. */
+	CHECK_BAD(rte_kvargs_handle_bool, bool, "");
+	CHECK_BAD(rte_kvargs_handle_bool, bool, "2");
+	CHECK_BAD(rte_kvargs_handle_bool, bool, "yep");
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_kvargs_to_range(void)
+{
+	uint64_t u = 0x5a;
+	int64_t s = 0x5a;
+
+	TEST_ASSERT_SUCCESS(rte_kvargs_to_uint("10", 0, 10, &u), "10 in [0,10]");
+	TEST_ASSERT_EQUAL(u, 10U, "wrong value");
+
+	TEST_ASSERT_EQUAL(rte_kvargs_to_uint("11", 0, 10, &u), -ERANGE,
+			  "11 should be out of [0,10]");
+	TEST_ASSERT_EQUAL(u, 10U, "target clobbered on range error");
+
+	TEST_ASSERT_EQUAL(rte_kvargs_to_uint("0", 1, 10, &u), -ERANGE,
+			  "0 should be out of [1,10]");
+	TEST_ASSERT_EQUAL(rte_kvargs_to_uint(NULL, 0, 10, &u), -EINVAL,
+			  "NULL should be rejected");
+	TEST_ASSERT_EQUAL(rte_kvargs_to_uint("x", 0, 10, &u), -EINVAL,
+			  "\"x\" should be rejected");
+	TEST_ASSERT_EQUAL(rte_kvargs_to_uint("5", 0, 10, NULL), -EINVAL,
+			  "a NULL result should be rejected");
+
+	TEST_ASSERT_SUCCESS(rte_kvargs_to_int("-5", -10, 10, &s), "-5 in [-10,10]");
+	TEST_ASSERT_EQUAL(s, -5, "wrong value");
+	TEST_ASSERT_EQUAL(rte_kvargs_to_int("-11", -10, 10, &s), -ERANGE,
+			  "-11 should be out of [-10,10]");
+
+	return TEST_SUCCESS;
+}
+
 static struct unit_test_suite kvargs_test_suite  = {
 	.suite_name = "Kvargs Unit Test Suite",
 	.setup = NULL,
@@ -354,6 +571,10 @@ static struct unit_test_suite kvargs_test_suite  = {
 		TEST_CASE(test_parse_empty_elements),
 		TEST_CASE(test_parse_with_only_key),
 		TEST_CASE(test_invalid_kvargs),
+		TEST_CASE(test_handle_unsigned),
+		TEST_CASE(test_handle_signed),
+		TEST_CASE(test_handle_bool),
+		TEST_CASE(test_kvargs_to_range),
 		TEST_CASES_END() /**< NULL terminate unit test array */
 	}
 };
diff --git a/doc/guides/prog_guide/devargs.rst b/doc/guides/prog_guide/devargs.rst
index c8a7224aa0..b73ad20cf6 100644
--- a/doc/guides/prog_guide/devargs.rst
+++ b/doc/guides/prog_guide/devargs.rst
@@ -248,6 +248,24 @@ PMD drivers can parse devargs using the kvargs library:
        return 0;
    }
 
+Rather than writing a handler for each numeric argument, use the
+conversion handlers provided by kvargs, which do the range checking:
+
+.. code-block:: c
+
+   uint16_t queues = 1;
+   bool scalar = false;
+
+   rte_kvargs_process(kvlist, "queues", rte_kvargs_handle_u16, &queues);
+   rte_kvargs_process_opt(kvlist, "scalar", rte_kvargs_handle_bool, &scalar);
+
+Boolean arguments accept ``1``, ``y``, ``yes``, ``on`` and ``true``,
+case insensitively, and their negative counterparts. A bare ``scalar``
+with no value means true, but reaches the handler only through
+rte_kvargs_process_opt(); rte_kvargs_process() rejects a missing value
+first. An empty ``scalar=`` is rejected, since that is what an unset
+shell variable expands to.
+
 For Ethernet devices, use ``rte_eth_devargs_parse()``
 to parse standard Ethernet arguments like representors:
 
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 87c7e81bde..c175fe089b 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -55,6 +55,26 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Added numeric conversion helpers to kvargs.**
+
+  Added a set of ``arg_handler_t`` compatible helpers which convert a device
+  argument value into a numeric variable, so that drivers no longer need to
+  open code the conversion and its validation:
+
+  * ``rte_kvargs_handle_u8``, ``rte_kvargs_handle_u16``,
+    ``rte_kvargs_handle_u32``, ``rte_kvargs_handle_u64``,
+    ``rte_kvargs_handle_uint``, ``rte_kvargs_handle_ulong``
+    and ``rte_kvargs_handle_size``
+  * ``rte_kvargs_handle_i8``, ``rte_kvargs_handle_i16``,
+    ``rte_kvargs_handle_i32``, ``rte_kvargs_handle_i64``,
+    ``rte_kvargs_handle_int`` and ``rte_kvargs_handle_long``
+  * ``rte_kvargs_handle_bool``, accepting ``1``, ``y``, ``yes``, ``on``,
+    ``true`` and their negative counterparts. A bare ``key`` means true;
+    an empty ``key=`` is rejected.
+
+  Added ``rte_kvargs_to_uint`` and ``rte_kvargs_to_int`` for the cases where
+  a driver needs a narrower range than the target type allows.
+
 
 Removed Items
 -------------
diff --git a/lib/kvargs/rte_kvargs.c b/lib/kvargs/rte_kvargs.c
index 4e3198b33f..c3bd199f3e 100644
--- a/lib/kvargs/rte_kvargs.c
+++ b/lib/kvargs/rte_kvargs.c
@@ -3,15 +3,28 @@
  * Copyright(c) 2014 6WIND S.A.
  */
 
+#include <ctype.h>
+#include <errno.h>
+#include <inttypes.h>
+#include <limits.h>
 #include <string.h>
 #include <stdlib.h>
 #include <stdbool.h>
+#include <stdint.h>
 
 #include <eal_export.h>
+#include <rte_common.h>
+#include <rte_log.h>
 #include <rte_os_shim.h>
 
 #include "rte_kvargs.h"
 
+RTE_LOG_REGISTER_DEFAULT(kvargs_logtype, INFO);
+#define RTE_LOGTYPE_KVARGS kvargs_logtype
+
+#define KVARGS_LOG(level, ...) \
+	RTE_LOG_LINE(level, KVARGS, __VA_ARGS__)
+
 /*
  * Receive a string with a list of arguments following the pattern
  * key=value,key=value,... and insert them into the list.
@@ -309,3 +322,430 @@ rte_kvargs_parse_delim(const char *args, const char * const valid_keys[],
 	free(copy);
 	return kvlist;
 }
+
+/*
+ * Determine the base of a numeric value and skip over its prefix.
+ *
+ * Only decimal and 0x/0X hexadecimal are recognized. Octal is deliberately
+ * not supported: no driver documents it, and silently reading "010" as eight
+ * has been a recurring source of surprise.
+ *
+ * Returns the base, and advances *str past the "0x" prefix if there is one.
+ * Returns 0 if what follows the prefix is a second one: strtoull() would
+ * strip that itself, making "0x0x10" sixteen rather than the garbage it is.
+ */
+static int
+kvargs_get_base(const char **str)
+{
+	const char *s = *str;
+
+	if (s[0] == '0' && (s[1] == 'x' || s[1] == 'X') &&
+	    isxdigit((unsigned char)s[2])) {
+		s += 2;
+		if (s[0] == '0' && (s[1] == 'x' || s[1] == 'X'))
+			return 0;
+		*str = s;
+		return 16;
+	}
+
+	return 10;
+}
+
+/* Skip trailing white space, and tell whether anything else is left. */
+static bool
+kvargs_at_end(const char *str)
+{
+	while (isspace((unsigned char)*str))
+		str++;
+
+	return *str == '\0';
+}
+
+/*
+ * Consume an optional sign, and report whether it was negative.
+ *
+ * strtoull() skips white space and a sign of its own, and negates on '-',
+ * so the sign has to be taken away from it: it is handled here and anything
+ * that follows must be a digit or an 0x prefix. That rejects "+-1" and
+ * "- 1", which strtoull() would otherwise accept.
+ */
+static bool
+kvargs_get_sign(const char **str)
+{
+	const char *s = *str;
+	bool negative;
+
+	while (isspace((unsigned char)*s))
+		s++;
+
+	negative = (*s == '-');
+	if (*s == '-' || *s == '+')
+		s++;
+
+	*str = s;
+	return negative;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_kvargs_to_uint, 26.11)
+int
+rte_kvargs_to_uint(const char *value, uint64_t min, uint64_t max,
+		   uint64_t *result)
+{
+	const char *str = value;
+	unsigned long long val;
+	char *endptr;
+	int base;
+
+	if (str == NULL || result == NULL)
+		return -EINVAL;
+
+	/* "-1" would otherwise be silently wrapped around to UINT64_MAX. */
+	if (kvargs_get_sign(&str))
+		return -EINVAL;
+
+	base = kvargs_get_base(&str);
+	if (base == 0)
+		return -EINVAL;	/* doubled 0x prefix */
+
+	/* Nothing may sit between the sign and the digits. */
+	if (!isxdigit((unsigned char)*str))
+		return -EINVAL;
+
+	errno = 0;
+	val = strtoull(str, &endptr, base);
+	if (endptr == str)
+		return -EINVAL;	/* no digits in this base */
+	if (errno == ERANGE)
+		return -ERANGE;
+	if (errno != 0)
+		return -EINVAL;
+	if (!kvargs_at_end(endptr))
+		return -EINVAL;	/* trailing garbage */
+
+	if (val < min || val > max)
+		return -ERANGE;
+
+	*result = val;
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_kvargs_to_int, 26.11)
+int
+rte_kvargs_to_int(const char *value, int64_t min, int64_t max, int64_t *result)
+{
+	const char *str = value;
+	unsigned long long mag;
+	char *endptr;
+	bool negative;
+	int64_t val;
+	int base;
+
+	if (str == NULL || result == NULL)
+		return -EINVAL;
+
+	negative = kvargs_get_sign(&str);
+	base = kvargs_get_base(&str);
+	if (base == 0)
+		return -EINVAL;	/* doubled 0x prefix */
+
+	/* Nothing may sit between the sign and the digits. */
+	if (!isxdigit((unsigned char)*str))
+		return -EINVAL;
+
+	/*
+	 * The sign is consumed above, so that the 0x prefix can be found
+	 * behind it, and the magnitude is parsed unsigned. Letting strtoll()
+	 * do the whole job instead would reject INT64_MIN, whose magnitude is
+	 * one past INT64_MAX.
+	 */
+	errno = 0;
+	mag = strtoull(str, &endptr, base);
+	if (endptr == str)
+		return -EINVAL;
+	if (errno == ERANGE)
+		return -ERANGE;
+	if (errno != 0)
+		return -EINVAL;
+	if (!kvargs_at_end(endptr))
+		return -EINVAL;
+
+	if (negative) {
+		if (mag > (unsigned long long)INT64_MAX + 1)
+			return -ERANGE;
+		/* Negate in unsigned space; -INT64_MIN would overflow. */
+		val = (int64_t)(-(uint64_t)mag);
+	} else {
+		if (mag > INT64_MAX)
+			return -ERANGE;
+		val = (int64_t)mag;
+	}
+
+	if (val < min || val > max)
+		return -ERANGE;
+
+	*result = val;
+	return 0;
+}
+
+/*
+ * The typed handlers below share this shape: convert with a range matching
+ * the target type, then store. The target is written only on success, so a
+ * caller-supplied default survives a bad argument.
+ */
+static int
+kvargs_store_uint(const char *key, const char *value, void *opaque,
+		  uint64_t max, uint64_t *val)
+{
+	int ret;
+
+	if (opaque == NULL)
+		return -EINVAL;
+
+	ret = rte_kvargs_to_uint(value, 0, max, val);
+	if (ret < 0)
+		KVARGS_LOG(ERR, "invalid value \"%s\" for key \"%s\", expected 0..%" PRIu64,
+			   value != NULL ? value : "", key != NULL ? key : "", max);
+
+	return ret;
+}
+
+static int
+kvargs_store_int(const char *key, const char *value, void *opaque,
+		 int64_t min, int64_t max, int64_t *val)
+{
+	int ret;
+
+	if (opaque == NULL)
+		return -EINVAL;
+
+	ret = rte_kvargs_to_int(value, min, max, val);
+	if (ret < 0)
+		KVARGS_LOG(ERR, "invalid value \"%s\" for key \"%s\", expected %" PRId64 "..%" PRId64,
+			   value != NULL ? value : "", key != NULL ? key : "",
+			   min, max);
+
+	return ret;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_kvargs_handle_u8, 26.11)
+int
+rte_kvargs_handle_u8(const char *key, const char *value, void *opaque)
+{
+	uint64_t val;
+	int ret;
+
+	ret = kvargs_store_uint(key, value, opaque, UINT8_MAX, &val);
+	if (ret == 0)
+		*(uint8_t *)opaque = (uint8_t)val;
+
+	return ret;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_kvargs_handle_u16, 26.11)
+int
+rte_kvargs_handle_u16(const char *key, const char *value, void *opaque)
+{
+	uint64_t val;
+	int ret;
+
+	ret = kvargs_store_uint(key, value, opaque, UINT16_MAX, &val);
+	if (ret == 0)
+		*(uint16_t *)opaque = (uint16_t)val;
+
+	return ret;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_kvargs_handle_u32, 26.11)
+int
+rte_kvargs_handle_u32(const char *key, const char *value, void *opaque)
+{
+	uint64_t val;
+	int ret;
+
+	ret = kvargs_store_uint(key, value, opaque, UINT32_MAX, &val);
+	if (ret == 0)
+		*(uint32_t *)opaque = (uint32_t)val;
+
+	return ret;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_kvargs_handle_u64, 26.11)
+int
+rte_kvargs_handle_u64(const char *key, const char *value, void *opaque)
+{
+	uint64_t val;
+	int ret;
+
+	ret = kvargs_store_uint(key, value, opaque, UINT64_MAX, &val);
+	if (ret == 0)
+		*(uint64_t *)opaque = (uint64_t)val;
+
+	return ret;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_kvargs_handle_uint, 26.11)
+int
+rte_kvargs_handle_uint(const char *key, const char *value, void *opaque)
+{
+	uint64_t val;
+	int ret;
+
+	ret = kvargs_store_uint(key, value, opaque, UINT_MAX, &val);
+	if (ret == 0)
+		*(unsigned int *)opaque = (unsigned int)val;
+
+	return ret;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_kvargs_handle_size, 26.11)
+int
+rte_kvargs_handle_size(const char *key, const char *value, void *opaque)
+{
+	uint64_t val;
+	int ret;
+
+	ret = kvargs_store_uint(key, value, opaque, SIZE_MAX, &val);
+	if (ret == 0)
+		*(size_t *)opaque = (size_t)val;
+
+	return ret;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_kvargs_handle_i8, 26.11)
+int
+rte_kvargs_handle_i8(const char *key, const char *value, void *opaque)
+{
+	int64_t val;
+	int ret;
+
+	ret = kvargs_store_int(key, value, opaque, INT8_MIN, INT8_MAX, &val);
+	if (ret == 0)
+		*(int8_t *)opaque = (int8_t)val;
+
+	return ret;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_kvargs_handle_i16, 26.11)
+int
+rte_kvargs_handle_i16(const char *key, const char *value, void *opaque)
+{
+	int64_t val;
+	int ret;
+
+	ret = kvargs_store_int(key, value, opaque, INT16_MIN, INT16_MAX, &val);
+	if (ret == 0)
+		*(int16_t *)opaque = (int16_t)val;
+
+	return ret;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_kvargs_handle_i32, 26.11)
+int
+rte_kvargs_handle_i32(const char *key, const char *value, void *opaque)
+{
+	int64_t val;
+	int ret;
+
+	ret = kvargs_store_int(key, value, opaque, INT32_MIN, INT32_MAX, &val);
+	if (ret == 0)
+		*(int32_t *)opaque = (int32_t)val;
+
+	return ret;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_kvargs_handle_i64, 26.11)
+int
+rte_kvargs_handle_i64(const char *key, const char *value, void *opaque)
+{
+	int64_t val;
+	int ret;
+
+	ret = kvargs_store_int(key, value, opaque, INT64_MIN, INT64_MAX, &val);
+	if (ret == 0)
+		*(int64_t *)opaque = (int64_t)val;
+
+	return ret;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_kvargs_handle_int, 26.11)
+int
+rte_kvargs_handle_int(const char *key, const char *value, void *opaque)
+{
+	int64_t val;
+	int ret;
+
+	ret = kvargs_store_int(key, value, opaque, INT_MIN, INT_MAX, &val);
+	if (ret == 0)
+		*(int *)opaque = (int)val;
+
+	return ret;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_kvargs_handle_long, 26.11)
+int
+rte_kvargs_handle_long(const char *key, const char *value, void *opaque)
+{
+	int64_t val;
+	int ret;
+
+	ret = kvargs_store_int(key, value, opaque, LONG_MIN, LONG_MAX, &val);
+	if (ret == 0)
+		*(long *)opaque = (long)val;
+
+	return ret;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_kvargs_handle_ulong, 26.11)
+int
+rte_kvargs_handle_ulong(const char *key, const char *value, void *opaque)
+{
+	uint64_t val;
+	int ret;
+
+	ret = kvargs_store_uint(key, value, opaque, ULONG_MAX, &val);
+	if (ret == 0)
+		*(unsigned long *)opaque = (unsigned long)val;
+
+	return ret;
+}
+
+static const char * const kvargs_true[] = { "1", "y", "yes", "on", "true" };
+static const char * const kvargs_false[] = { "0", "n", "no", "off", "false" };
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_kvargs_handle_bool, 26.11)
+int
+rte_kvargs_handle_bool(const char *key, const char *value, void *opaque)
+{
+	unsigned int i;
+
+	if (opaque == NULL)
+		return -EINVAL;
+
+	/* A bare key means true; only rte_kvargs_process_opt() allows it.
+	 * An empty value is a blank value, not a missing one, so it is
+	 * rejected below.
+	 */
+	if (value == NULL) {
+		*(bool *)opaque = true;
+		return 0;
+	}
+
+	for (i = 0; i < RTE_DIM(kvargs_true); i++) {
+		if (strcasecmp(value, kvargs_true[i]) == 0) {
+			*(bool *)opaque = true;
+			return 0;
+		}
+	}
+
+	for (i = 0; i < RTE_DIM(kvargs_false); i++) {
+		if (strcasecmp(value, kvargs_false[i]) == 0) {
+			*(bool *)opaque = false;
+			return 0;
+		}
+	}
+
+	KVARGS_LOG(ERR, "invalid value \"%s\" for key \"%s\", expected a boolean",
+		   value, key != NULL ? key : "");
+
+	return -EINVAL;
+}
diff --git a/lib/kvargs/rte_kvargs.h b/lib/kvargs/rte_kvargs.h
index 73fa1e621b..118cf3c79b 100644
--- a/lib/kvargs/rte_kvargs.h
+++ b/lib/kvargs/rte_kvargs.h
@@ -21,6 +21,10 @@
  * ethernet devices at initialization for arguments parsing.
  */
 
+#include <stdint.h>
+
+#include <rte_compat.h>
+
 #ifdef __cplusplus
 extern "C" {
 #endif
@@ -230,6 +234,188 @@ int rte_kvargs_process_opt(const struct rte_kvargs *kvlist,
 unsigned rte_kvargs_count(const struct rte_kvargs *kvlist,
 	const char *key_match);
 
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Handlers to convert a key/value pair into a numeric type.
+ *
+ * The functions below all match the ``arg_handler_t`` prototype, so they can
+ * be passed directly to rte_kvargs_process():
+ *
+ * @code
+ *   uint16_t nb_desc = DEFAULT_NB_DESC;
+ *
+ *   ret = rte_kvargs_process(kvlist, "nb_desc",
+ *                            rte_kvargs_handle_u16, &nb_desc);
+ * @endcode
+ *
+ * The value string is accepted only if it represents the whole number, that
+ * is:
+ *
+ * - it is not NULL and not empty;
+ * - it is decimal, or hexadecimal with a ``0x`` or ``0X`` prefix;
+ * - it has no trailing characters other than white space;
+ * - it does not overflow the target type.
+ *
+ * A leading ``+`` or ``-`` sign is accepted. The unsigned handlers reject a
+ * negative value rather than wrapping it around, which is what strtoul()
+ * would otherwise do.
+ *
+ * Note that a leading zero does @b not select octal, so ``010`` is ten and
+ * not eight.
+ *
+ * @param key
+ *   The key, used for error reporting only. May be NULL.
+ * @param value
+ *   The value to convert.
+ * @param opaque
+ *   Pointer to the variable to store the result into. The pointed-to type
+ *   must match the handler: for example rte_kvargs_handle_u16() requires a
+ *   ``uint16_t *``. On error the variable is left unmodified.
+ *
+ * @return
+ *   - 0 on success.
+ *   - -EINVAL if the value is missing or malformed, or if @p opaque is NULL.
+ *   - -ERANGE if the value does not fit in the target type.
+ */
+__rte_experimental
+int rte_kvargs_handle_u8(const char *key, const char *value, void *opaque);
+
+/** Convert a value to uint16_t. See rte_kvargs_handle_u8(). */
+__rte_experimental
+int rte_kvargs_handle_u16(const char *key, const char *value, void *opaque);
+
+/** Convert a value to uint32_t. See rte_kvargs_handle_u8(). */
+__rte_experimental
+int rte_kvargs_handle_u32(const char *key, const char *value, void *opaque);
+
+/** Convert a value to uint64_t. See rte_kvargs_handle_u8(). */
+__rte_experimental
+int rte_kvargs_handle_u64(const char *key, const char *value, void *opaque);
+
+/** Convert a value to int8_t. See rte_kvargs_handle_u8(). */
+__rte_experimental
+int rte_kvargs_handle_i8(const char *key, const char *value, void *opaque);
+
+/** Convert a value to int16_t. See rte_kvargs_handle_u8(). */
+__rte_experimental
+int rte_kvargs_handle_i16(const char *key, const char *value, void *opaque);
+
+/** Convert a value to int32_t. See rte_kvargs_handle_u8(). */
+__rte_experimental
+int rte_kvargs_handle_i32(const char *key, const char *value, void *opaque);
+
+/** Convert a value to int64_t. See rte_kvargs_handle_u8(). */
+__rte_experimental
+int rte_kvargs_handle_i64(const char *key, const char *value, void *opaque);
+
+/** Convert a value to unsigned int. See rte_kvargs_handle_u8(). */
+__rte_experimental
+int rte_kvargs_handle_uint(const char *key, const char *value, void *opaque);
+
+/** Convert a value to int. See rte_kvargs_handle_u8(). */
+__rte_experimental
+int rte_kvargs_handle_int(const char *key, const char *value, void *opaque);
+
+/** Convert a value to long. See rte_kvargs_handle_u8(). */
+__rte_experimental
+int rte_kvargs_handle_long(const char *key, const char *value, void *opaque);
+
+/** Convert a value to unsigned long. See rte_kvargs_handle_u8(). */
+__rte_experimental
+int rte_kvargs_handle_ulong(const char *key, const char *value, void *opaque);
+
+/** Convert a value to size_t. See rte_kvargs_handle_u8(). */
+__rte_experimental
+int rte_kvargs_handle_size(const char *key, const char *value, void *opaque);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Convert a key/value pair to a boolean.
+ *
+ * Accepts, case insensitively, ``1``, ``y``, ``yes``, ``on`` and ``true``
+ * for true; ``0``, ``n``, ``no``, ``off`` and ``false`` for false.
+ *
+ * A key given without a value, as in ``key``, is treated as true. Use
+ * rte_kvargs_process_opt() rather than rte_kvargs_process() to support
+ * that form, since the latter rejects a missing value before the handler
+ * is called. An empty value, as in ``key=``, is rejected.
+ *
+ * @param key
+ *   The key, used for error reporting only. May be NULL.
+ * @param value
+ *   The value to convert. NULL means true.
+ * @param opaque
+ *   Pointer to a ``bool`` to store the result into. On error it is left
+ *   unmodified.
+ *
+ * @return
+ *   - 0 on success.
+ *   - -EINVAL if the value is malformed or if @p opaque is NULL.
+ */
+__rte_experimental
+int rte_kvargs_handle_bool(const char *key, const char *value, void *opaque);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Convert a string to an unsigned integer, checking it against a range.
+ *
+ * This is the underlying conversion used by the rte_kvargs_handle_*()
+ * unsigned handlers. It is meant for drivers which need a range narrower
+ * than the target type, or which parse a value obtained from
+ * rte_kvargs_get() rather than from a handler.
+ *
+ * @param value
+ *   The string to convert. Must be non-NULL and non-empty. See
+ *   rte_kvargs_handle_u8() for the accepted syntax.
+ * @param min
+ *   Smallest acceptable value, inclusive.
+ * @param max
+ *   Largest acceptable value, inclusive.
+ * @param result
+ *   Where to store the converted value. Left unmodified on error.
+ *
+ * @return
+ *   - 0 on success.
+ *   - -EINVAL if the value is missing or malformed, or if @p result is NULL.
+ *   - -ERANGE if the value is outside [@p min, @p max].
+ */
+__rte_experimental
+int rte_kvargs_to_uint(const char *value, uint64_t min, uint64_t max,
+	uint64_t *result);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Convert a string to a signed integer, checking it against a range.
+ *
+ * This is the signed counterpart of rte_kvargs_to_uint().
+ *
+ * @param value
+ *   The string to convert. Must be non-NULL and non-empty. See
+ *   rte_kvargs_handle_u8() for the accepted syntax.
+ * @param min
+ *   Smallest acceptable value, inclusive.
+ * @param max
+ *   Largest acceptable value, inclusive.
+ * @param result
+ *   Where to store the converted value. Left unmodified on error.
+ *
+ * @return
+ *   - 0 on success.
+ *   - -EINVAL if the value is missing or malformed, or if @p result is NULL.
+ *   - -ERANGE if the value is outside [@p min, @p max].
+ */
+__rte_experimental
+int rte_kvargs_to_int(const char *value, int64_t min, int64_t max,
+	int64_t *result);
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.53.0

