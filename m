Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650DBCA9EBB
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 02:29:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EFB0B4067A;
	Sat, 10 Oct 2026 04:29:01 +0200 (CEST)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mails.dpdk.org (Postfix) with ESMTP id C0DC840612
 for <dev@dpdk.org>; Sat, 10 Oct 2026 04:28:57 +0200 (CEST)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-cd3310348d2so944687a12.1
 for <dev@dpdk.org>; Fri, 09 Oct 2026 19:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791599337;
 x=1792204137; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2WeJthHIKLg4vuaVz1RfIhVvwGJNWRtf7WLHO5vVU6M=;
 b=lVHIqsuC286sVHN+jrwCjutC+rtcrNZkxyeNAzwbfR0PYnb8uRAsbcFX4ij/kffePP
 Q1dEHxoyVPzrS6ID1wigsOgp6obxCDt2nsNC9z9gmslHJKxID6VPql4ij0B6eusHcPIi
 GlRwx1vu0fMh1kcOjayp32Z6QmxnEjm7FSxVGA1xrwOVD4gKGU0TQVDAIIRQouB71uUo
 /6FHjvf8xXA5SXbj3dpj/ZHvdv2t0sGsEi1zBV4aCNLvF329kL1iNm2BRll8Feh9G4zC
 hXvPgAswoplwDOxaNDZG0c18AIvRx2LDy+eCri3BpscjMrrV35MUT8d+UOBbf3m+qchd
 4W8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791599337; x=1792204137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2WeJthHIKLg4vuaVz1RfIhVvwGJNWRtf7WLHO5vVU6M=;
 b=dsadfq8iCmi8eY5HbXPrisL8eaBHSYxAv1dGahRvn8B/PBBotLiIgldBiQvujJ60KA
 TkT99LmoC9K+ORChPX7mTE1EYTW/2VBa5432XGV/32jvI/6CZpzMwPlUqcZe9pySJSWW
 LN6UjzVyfeo40a4Vz4WX1gMmAlI0o72pkATvheyNxiHYkWhl57rOmrIDA1YrWMczCeFd
 0fNeunXoMX9zZK443g0/QVcx1iEGALz+ncNXwKPoybxc1rzCf7LJiobmzySrdz4h03XN
 T16W6ptUe6y55oi4VVxvjh2moUSYz2ynqjnm/lh48TkoovAWwSBcCDVce2b34dME92Zj
 cN7g==
X-Gm-Message-State: AFq9FYICjtvolciI8bxY2pe23VaEY+ieVNRygL0682sH+5mQE+3z6pMo
 /rthV8YMV+Jvnn5GWIhxSk5JA3HTBmpGAoHHGNmBEOY7sh8F07IfbL9FqgIrGJui8ZqgN6Ywnpj
 4hcwHziI=
X-Gm-Gg: AYBFou0MA6fNGcE0bLSDbDNnHgyoWu22fOANxrpftjWyEUB6RdEoPBlfGLFdweA4H+e
 bpzYuSruf+paj57T1D9mUE8aIUPk10LQb4kU562NKv48dND+jthstPTOss0SlSaVxXbkrVUItMl
 NjdT43UfYNnqVWTpz6uNhhHqOYu5Cxnd4MULTAifHId+36nYNENEMAzUrLCZmkmwG19gDkx8y6D
 jX8Pe7vkPMb6U1CuTXwM+pbFWBRgVgw9/gpSl3iAZcjtPR0CnZT40+HWY0xowR+kUKL7c7LoOhI
 RD3WuEXdVGkVeHT2WCrJSZYNuSY2f848DVJPMkTqC2P7ScQzgZNjAO3f7064o7y6tHbUfw57MnA
 2Hpg/KvoPWmrnB78IlPwl7gp47SqUf78ieYF7f67b0UFN+SPk/Tx6yTLAkqNfd7bQVaH01bAz69
 HcFttUgxVKjMsqUe8dizDuJyVetUKjAW0TyrErX3anQKuVJThF81PxqK2CdcPPObhrDsMVwftPV
 XCYD8gmVPthJ4+pryfFepixpP9QPS4GmshHpQXfiRnXvCos
X-Received: by 2002:a17:90a:c2cc:b0:3a6:f1d2:57e7 with SMTP id
 98e67ed59e1d1-3ab3a952880mr2362421a91.11.1791599336768; 
 Fri, 09 Oct 2026 19:28:56 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab3690474esm6202882a91.0.2026.10.09.19.28.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 19:28:56 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 5/5] test: allow setting random seed for tests
Date: Fri,  9 Oct 2026 19:27:07 -0700
Message-ID: <20261010022851.1872825-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261010022851.1872825-1-stephen@networkplumber.org>
References: <20260915192207.3926217-1-stephen@networkplumber.org>
 <20261010022851.1872825-1-stephen@networkplumber.org>
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
 app/test/test.c                        | 48 ++++++++++++++++++++++++++
 doc/guides/contributing/unit_test.rst  | 15 ++++++++
 doc/guides/rel_notes/release_26_11.rst |  2 ++
 3 files changed, 65 insertions(+)

diff --git a/app/test/test.c b/app/test/test.c
index c610c3588e..176e4fa1f5 100644
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
@@ -175,8 +204,18 @@ main(int argc, char **argv)
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
@@ -233,6 +272,12 @@ main(int argc, char **argv)
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
@@ -260,6 +305,9 @@ main(int argc, char **argv)
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
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 2d12eb7949..5d5db46190 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -165,6 +165,8 @@ New Features
     64 bits of the value passed to ``rte_srand()`` now affect the state,
     so a given seed produces a different sequence than in previous
     releases.
+  * The test application now accepts a ``DPDK_TEST_SEED`` environment
+    variable to make runs using ``rte_rand()`` repeatable.
 
 
 Removed Items
-- 
2.53.0

