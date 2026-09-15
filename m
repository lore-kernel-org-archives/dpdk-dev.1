Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEBDC88E77
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 19:23:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC30542E36;
	Tue, 15 Sep 2026 21:23:13 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 430AA42E12
 for <dev@dpdk.org>; Tue, 15 Sep 2026 21:23:11 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-398b3b189e0so92229a91.2
 for <dev@dpdk.org>; Tue, 15 Sep 2026 12:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789500190;
 x=1790104990; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M3Q0/YULZDFs04m4n3FTQmdCl2pJkzGESLIa6Df7HFk=;
 b=0dfX+7LeNQnwOWipKYht7l54IIJGuQ3Nu2DZ6ayniXIPdl96y7aPmontesCQ6esTqX
 gpx1MnM9zPA+yLuXbcEEEJOOBaRkfO5637L8LZEiuDpxI24sh27ymnpJ3LqpLUpu5Yuw
 UT68a5T+fLfLm6P0YuOWqZm6ByI74hcjIMCLkjDZNwmy56o/TiqGOvLa+riiuzvBEHSf
 GVsgxzh5WalKSfoyvdCNM3wuWsDSe2MHe2ZLtRUdu+dN2q3SZPSgKSWJojwGiW9c5oT3
 jTfBU3Q8BrMxo84qrWFRZWX8nuW4AQXVY9U/493FvHnuC64vxLXvYkuKuSxl8lIqRn62
 n0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789500190; x=1790104990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=M3Q0/YULZDFs04m4n3FTQmdCl2pJkzGESLIa6Df7HFk=;
 b=R6t9GOi2sS89zlHjXEMUgN3Rwj+jDkoOvHaU21fjQTbQyVcATl5QKM2wadCadpOLAD
 LYKpBHld2VlJPKoLnlTpjQBtmTQLJ3KNZLLNt7JZfbyIK+xWPb1OSmRmGAkOsGcNGlBl
 MZLkAqUiNvZgNNsfmj3N86tQV7NLcEBynamNgHKLREEZoCkfriYcCWVYTH3R9sWZlCO9
 zpEd/+22wseRDi7V2A1m0+p2ZsyUUu8Zd0frOhiNCDPvOQQ7k9Saj/Fj9dv8nqMr2GnP
 glRqAB/UkGg9IHmwQHdbkgann1IhxNvljD5XfI8Kc+FZSaQtBkr1JBWaqWeRcEoVf8Xl
 CAjg==
X-Gm-Message-State: AFuF++lNJu18T9kb1FazielRD4HH7bdE0sFwphOTQJncoo5ZjrmYnGXh
 FnIMKOzIHuSlzfvARVppg4YWbZiSO+vaonVzjL4+MoJXqwuxlQBOAtSyQF7WIHMpZ8/7smtN+2a
 9DPRGP5AS4w==
X-Gm-Gg: AYBFou3ROymKV6Rmko6BJ3uMTYb/YyXLGyHB7iUfFFOEO/93JJ7OxlAX/7UlKj8BV6H
 iuMHQhHdZOXmGkUezvs6dRrgvi9CRD0STFVgv5CtztJbHHm3wexJxSHKFD7lhGYVPxsM7x7DKfz
 uhXKWFq+P3Ku/ej6qDy/ML8UZgM85nCPENCm3q+bVF6vQQ7nBW8ItgBN+BA6PvcoPepZeg19Eqb
 SmmoI0gRdgswdZ/szpuZDNMosXfLMd5bIepZc+XyZc73sSWypYa/1mZd/d7fV5PoMtVaE7GXWRq
 lNB5DpjSWPayRcMGKp3YC9aG0wjWEyGiMuTbALVqExHOJwcNvBRKt83ZGtDv7OiaDxRtncLrd+L
 /D3D33LxTUFrfAt0YGYI+tsQs5R6aVhhgaBeVX64THmZXEazNdJoeWSOWfWlK4idPdlz1Ime4ZQ
 zRxxQ+nhnK5biwNcsCRNATU3vd+PoC+qS/m+zKEwJFVrBjPbnN/UF5vQPm+lmyreXUrxTriihqN
 5rnWSkHEvbSyz8wGGutOWrgEMdBRmE3uigIu1ElV4OgBcga
X-Received: by 2002:a17:90b:2803:b0:39d:f253:5fc4 with SMTP id
 98e67ed59e1d1-39df253b354mr15202097a91.17.1789500190350; 
 Tue, 15 Sep 2026 12:23:10 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e1bbfdd49sm217535a91.11.2026.09.15.12.23.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 12:23:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 16/18] test: allow setting random seed for tests
Date: Tue, 15 Sep 2026 12:21:14 -0700
Message-ID: <20260915192207.3926217-17-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915192207.3926217-1-stephen@networkplumber.org>
References: <20260915192207.3926217-1-stephen@networkplumber.org>
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
index 9d1238d6f3..d315d426f4 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -69,6 +69,8 @@ New Features
     64 bits of the value passed to ``rte_srand()`` now affect the state,
     so a given seed produces a different sequence than in previous
     releases.
+  * The test application now accepts a ``DPDK_TEST_SEED`` environment
+    variable to make runs using ``rte_rand()`` repeatable.
 
 
 Removed Items
-- 
2.53.0

