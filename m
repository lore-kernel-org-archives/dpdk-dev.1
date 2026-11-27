Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ECA606A32A
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Nov 2026 19:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=TkiVZT4O
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 504C340698;
	Fri, 27 Nov 2026 20:42:21 +0100 (CET)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mails.dpdk.org (Postfix) with ESMTPS id 1E8DF40616
 for <dev@dpdk.org>; Fri, 27 Nov 2026 20:42:17 +0100 (CET)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-89d6bd67045so3885274b3a.0
 for <dev@dpdk.org>; Fri, 27 Nov 2026 11:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1795808535;
 x=1796413335; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FYbgkXLeT9zra1jqAZL1ks8xFntIwxC10XdfzvyBJG8=;
 b=TkiVZT4O4qhvXhudEfGZvHLDplIcZqniyAaGQP4GE4lNiZG95cBZvwWzILzIFFYyAK
 205UHZCXR2cA4c/M6LcObO4Un4DUQvbVU4OemKJjBYXHZTJJ4kz4Z3IqR3O/WOFQwz5Y
 c+5O/BVk4xaMxcy4ytJgm+rcjkJ2XcYVGnVQgeIGBoxACwwhEHv7juXg/KkYgaw8VQi0
 ebiW5uFVSllCMBtCA+22BoUG2LvaYqw30kNFF04XpIKabnAx2vW5T0woiY8bT+iYz7Ab
 yn62+DH+cmohSGWjU5J0GXxeq3Kt2Wcgacy7SCl8pPc1JFd9t7irafl9OeARdC9ZA1Nl
 PYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795808535; x=1796413335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FYbgkXLeT9zra1jqAZL1ks8xFntIwxC10XdfzvyBJG8=;
 b=HQKgQ0BHZZ0VjMcgvjeWZU+tgd5nRGpwgRHSqo2eReRef9DCVytkF6bHcqDZh59ANM
 /TSNPruYK3bjsrwVF3V7K3IS2296GPhCqL2uNWToMKClZklipjotU7IaCa2AjN76RVR+
 DVwkkOz5A4bu8vQYeFuNXVy4cjy48UZ1gI9iUveARxoesX8b7CglPZgnEpJfCqYKDU3Q
 woT08K491nAtp4nFFt70O0RUTKy+fcHKetXgiovgVJNaYKocmMUkOTuZI2I1FQsycuLV
 nb96AffsZIJcYFZzDT1404lDEStSt7telTco2P3Y8Z48ZoQJ9wtXL8akYzXrrZxSm8OJ
 9Cvw==
X-Gm-Message-State: APuU4Z8uWC7fwdeK1l7tkDEMLBAPGB3pr99Zah7TeLXi1+v5eqQISpaX
 +p1TEZdFMm2bGEXD6nJFKs/8WSajc9+N62E++gYOAgn1NGC+IXHq8U12aP597rj7yJS+5wY5Pn7
 rOyChYsc=
X-Gm-Gg: AZFdTZf/ZpYBt6f+qrFSWuPyw3Y1Q4Mp16a3nRl2v3aPQZ3iuRBCOadjnv/l8vbVT+Q
 ooUyt0oiiUR7EcbbMLcb9UeKgZ9bogMDyEO9zMW0LzTOFmvrLbTJiM9Pnq86zz86gIt19fgVWJr
 IpxcBfI+wUlTCK2KdvXgBprh0qt0GYmQrKXjqoN7/ueCJIUM/FqwRvcg9MxNQ0qnxEj+Q5r/i+U
 KkL1wsBh/MgN5wSZy9b3PSUeMcw6HDDBC/dT9taQLnjhSDeWVdtNDti9fEWXhnyXAmAhGL6vvsR
 RQMFW6t12yPr129qI7wJ59pwHqzjaAC+MPnZQWeEjm2ZxhZfP0/SpEx0Dea0hUMK/w7iM5Y+g9k
 YyN2mso8RFsRSdy0x8iiWKsA0q8KVdrC6Jg4pZoNMmVFxjAdkTa7IvKXwmJC53uLwCw/Gatqkug
 5Xha5GcCh/CJbXb0z1L8o9N4Kkl+9OoDmj4FKv2YfBSovOw8iJhKYTWRRVzLcQq2Yq6RONLArSd
 nlPcoUdC92krY4qSNL/cYxsd4i1gWU12EAPrTqiETaDhb8ZP8F0U9Qo1m2UvQgUkksiEkvPJb6F
 mlFv5QnuadpXtHoF0p9GVFrG8e3VhFXjGVyHxDT+INUGb9qpVfcY6kk/swek57P5zRvb
X-Received: by 2002:a05:6a00:13a2:b0:8b6:ac2e:a340 with SMTP id
 d2e1a72fcca58-8c7dd306849mr18477919b3a.16.1795808535532; 
 Fri, 27 Nov 2026 11:42:15 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c872951febsm12881051b3a.14.2026.11.27.11.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 11:42:15 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 5/5] test: allow setting random seed for tests
Date: Fri, 27 Nov 2026 11:39:37 -0800
Message-ID: <20261127194209.107396-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127194209.107396-1-stephen@networkplumber.org>
References: <20260915192207.3926217-1-stephen@networkplumber.org>
 <20261127194209.107396-1-stephen@networkplumber.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Many tests build their input data with rte_rand(), which is seeded
from the system entropy source and therefore produces a different
sequence on every run. Varying the data is good for coverage, but it
adds noise when comparing performance results between two builds.

Add a DPDK_TEST_SEED environment variable to the test application that
seeds the generator with a fixed value. The generator is reseeded
before each test is dispatched, so a test gets the same input data no
matter what ran before it in the same invocation. When the variable is
not set the behaviour is unchanged and each run gets a random seed.

Note that rand_perf_autotest calls rte_srand() itself. It measures
generator latency rather than any value derived from the sequence, so
it is left alone.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test.c                       | 48 +++++++++++++++++++++++++++
 doc/guides/contributing/unit_test.rst | 15 +++++++++
 2 files changed, 63 insertions(+)

diff --git a/app/test/test.c b/app/test/test.c
index 8f23325cb6..8561b0815e 100644
--- a/app/test/test.c
+++ b/app/test/test.c
@@ -6,6 +6,7 @@
 #include <stdio.h>
 #include <stdint.h>
 #include <stdarg.h>
+#include <stdbool.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <ctype.h>
@@ -21,6 +22,7 @@ extern cmdline_parse_ctx_t main_ctx[];
 #include <rte_eal.h>
 #include <rte_cycles.h>
 #include <rte_log.h>
+#include <rte_random.h>
 #include <rte_string_fns.h>
 #ifdef RTE_LIB_TIMER
 #include <rte_timer.h>
@@ -107,6 +109,33 @@ do_recursive_call(void)
 
 int last_test_result;
 
+/* Tests that use rte_rand() get a different sequence on every run, which
+ * is good for coverage but makes it hard to compare performance results.
+ * Setting DPDK_TEST_SEED gives a repeatable sequence instead.
+ */
+static bool use_test_seed;
+static uint64_t test_seed;
+
+static int
+get_test_seed(void)
+{
+	const char *env = getenv("DPDK_TEST_SEED");
+	char *end;
+
+	if (env == NULL || *env == '\0')
+		return 0;
+
+	errno = 0;
+	test_seed = strtoull(env, &end, 0);
+	if (errno != 0 || end == env || *end != '\0') {
+		fprintf(stderr, "Invalid DPDK_TEST_SEED: '%s'\n", env);
+		return -1;
+	}
+
+	use_test_seed = true;
+	return 0;
+}
+
 #define MAX_EXTRA_ARGS 32
 
 int
@@ -167,8 +196,18 @@ main(int argc, char **argv)
 		goto out;
 	}
 
+	if (get_test_seed() < 0) {
+		ret = -1;
+		goto out;
+	}
+
 	recursive_call = getenv(RECURSIVE_ENV_VAR);
 	if (recursive_call != NULL) {
+		/* Child instances inherit the environment, so seed them
+		 * too rather than leaving them randomly seeded.
+		 */
+		if (use_test_seed)
+			rte_srand(test_seed);
 		ret = do_recursive_call();
 		goto out;
 	}
@@ -225,6 +264,12 @@ main(int argc, char **argv)
 				}
 			}
 
+			/* Reseed before each test so that a test gets the same
+			 * sequence no matter what ran before it.
+			 */
+			if (use_test_seed)
+				rte_srand(test_seed);
+
 			snprintf(buf, sizeof(buf), "%s\n", tests[i]);
 			if (cmdline_parse_check(cl, buf) < 0) {
 				printf("Error: invalid test command: '%s'\n", tests[i]);
@@ -252,6 +297,9 @@ main(int argc, char **argv)
 			goto out;
 		}
 
+		if (use_test_seed)
+			rte_srand(test_seed);
+
 		cmdline_interact(cl);
 		cmdline_stdin_exit(cl);
 	}
diff --git a/doc/guides/contributing/unit_test.rst b/doc/guides/contributing/unit_test.rst
index f13ddff291..5d08fe1792 100644
--- a/doc/guides/contributing/unit_test.rst
+++ b/doc/guides/contributing/unit_test.rst
@@ -114,6 +114,21 @@ via the ``DPDK_TEST_PARAMS`` argument,
 in case some tests need additional configuration.
 This is not currently used in the Meson test suites.
 
+Many tests build their input data with ``rte_rand()``,
+which produces a different sequence on every run.
+This is useful for coverage, but it adds noise when comparing results.
+Setting ``DPDK_TEST_SEED`` to an integer seeds the generator with that
+value before each test command is run, so that a test gets the same input
+data no matter what ran before it::
+
+   $ DPDK_TEST_SEED=42 ./build/app/test/dpdk-test lpm_perf_autotest
+
+This also works when running the tests via Meson::
+
+   $ DPDK_TEST_SEED=42 meson test -C build --suite perf-tests
+
+When the variable is not set, the generator keeps its default random seeding.
+
 
 Running test cases via Meson
 ----------------------------
-- 
2.53.0

