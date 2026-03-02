Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFCFEB362E
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 18:55:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C84940ED8;
	Mon,  2 Mar 2026 19:55:06 +0100 (CET)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48]) by mails.dpdk.org (Postfix) with ESMTP id 6CC6040E41
 for <dev@dpdk.org>; Mon,  2 Mar 2026 19:55:04 +0100 (CET)
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-899e87b04d8so36197456d6.3
 for <dev@dpdk.org>; Mon, 02 Mar 2026 10:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1772477704; x=1773082504; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U7nAg3sMO8C6HxDMf24fN0qehiMnxLl5e3kFvTnMfy4=;
 b=H91BdqmDrZ75rWF3VP402lSIgFoW2FMnLe6d7oDH4LSo7dAY7VQIVY5kRmlb+JGcSo
 MNP9UqpAcqwOe0y7ENlt+wmgQGxPv4+f0w4hi29FPTG8SFGUXCiazsrqI50zTvovgCe9
 NrAh1R0RhysDt4mFlHnv2sPRHBYYMw75X5rUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772477704; x=1773082504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U7nAg3sMO8C6HxDMf24fN0qehiMnxLl5e3kFvTnMfy4=;
 b=e7KJAETeqxxLEx9sKXkDtUyg+sox6gacHwZ7nEr0SoRI+RrFNhoEOzGosxqKw0WSj0
 FwaDqXRXWqrs06Qb61YY8Ffz4hKfJbXj/iLp7V4cxx4B5d+RqgfoSHZZ17oIxU0EmtrF
 i+ojHcW/ZcuHq1d7rF38V1i0aWU3rKLITH9R/wsT8FIK8cOQCut6ZmZspiOJwvg5rPp9
 xjWoyEGDx9hMeNYhCRPhk/6wGW3w1hV5OWDS5wVkiQqxck/oJMkW1Kj/92NLqekWYIIM
 Wf2y6EKKXZDJawdnv/W1XzFKUVuqZotcOtBK684dfk1y1cdV3BtzkV81/AJgbFeNpCYt
 uXYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8WWkPkAQUTJJGyWCQQqLuwsRJjuROf8USRHbkcn6VaX/FyNlamcKj4R4mdMkN+dv05KA=@dpdk.org
X-Gm-Message-State: AOJu0Yx8+h0HwIW5JJa2kniJt10egIUH6K/0zkNwBXvQZGsaMusorHHY
 ED0AP9BxNQ/apbd+BBEJGyRpj6PzMKzw10bGZ9nrj77JU1sJbOHtj87xSoYaytYVJ0g=
X-Gm-Gg: ATEYQzyuUzRAh+1Dq1hYd2qwRbD/W9BeOSD2xkShfeYGTTpv3neJZGDYP6NqThnX1aV
 utJqiOzAsEvZcO0vOj74kRRH0oqRaoSVwJON4j3WYfqR0HsJ3KyZ8mHWu+wlZpuO4W+k4r5UtAT
 lwWqVw4ImcP89vwHgROl3Nlv2rwmu45BK23VgBhkqZNP7UgWPAr8PLUE1/5L/3YV1imzuk5Nlye
 VdFJRxIl2XY4Af+0p30Ii/L+xBGigTxpDFJ7M+1ST7nOpc6OPZ14wVt1c0CrshJtFJ3kwWHLwCA
 cBUOxd7Lgx6nmNzO6uIbsRDu0xw7AEuLVfv4Rh9Q/ylQKPh/SCXb2/34G9ODtES8lNtavkm/8wO
 mf8a4d0485kkEkXItEK2s4OWe9huhZKNbr/JRIGPivc41NEy4ZxMgBijyQfON/BvBbzqoGQvjfn
 LfU49qcWYr+AcjLWsCJ0hqUW+rCo3ZrJE5R0oJyPs3UreAvwMySalSnCn8MlN0rrjars4HxOJUs
 Kc=
X-Received: by 2002:a05:6214:489:b0:893:348e:4126 with SMTP id
 6a1803df08f44-899d1e9355fmr184547206d6.61.1772477703646; 
 Mon, 02 Mar 2026 10:55:03 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-899eed12615sm46719586d6.8.2026.03.02.10.55.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 10:55:02 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: probb@iol.unh.edu
Cc: luca.vizzarro@arm.com, dmarx@iol.unh.edu, dev@dpdk.org, gakhil@marvell.com,
 kai.ji@intel.com, dharmikjayesh@arm.com, david.marchand@redhat.com,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v4 5/5] dts: add crypto test decorator
Date: Mon,  2 Mar 2026 13:54:38 -0500
Message-ID: <20260302185438.122584-6-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260302185438.122584-1-abailey@iol.unh.edu>
References: <20260210193448.69423-1-abailey@iol.unh.edu>
 <20260302185438.122584-1-abailey@iol.unh.edu>
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

Currently, a test case is decorated to signify whether to use Scapy or
TREX. This change allows test suites that do not use a traffic generator
to avoid the overhead of initializing either one.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/configurations/test_run.example.yaml    |  1 +
 dts/framework/config/test_run.py            |  3 +++
 dts/framework/test_run.py                   |  2 +-
 dts/framework/test_suite.py                 |  6 +++++
 dts/tests/TestSuite_cryptodev_throughput.py | 30 +++++++++++----------
 5 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/dts/configurations/test_run.example.yaml b/dts/configurations/test_run.example.yaml
index c8035fccf0..3eaffc2aa4 100644
--- a/dts/configurations/test_run.example.yaml
+++ b/dts/configurations/test_run.example.yaml
@@ -31,6 +31,7 @@ func_traffic_generator:
 #   config: "/opt/trex_config/trex_config.yaml" # Additional configuration files. (Leave blank if not required)
 perf: false # disable performance testing
 func: true # enable functional testing
+crypto: false # disable cryptographic testing
 use_virtual_functions: false # use virtual functions (VFs) instead of physical functions
 skip_smoke_tests: true # optional
 # by removing the `test_suites` field, this test run will run every test suite available
diff --git a/dts/framework/config/test_run.py b/dts/framework/config/test_run.py
index 6c292a3675..39f2c7cdf6 100644
--- a/dts/framework/config/test_run.py
+++ b/dts/framework/config/test_run.py
@@ -481,6 +481,8 @@ class TestRunConfiguration(FrozenModel):
     perf: bool
     #: Whether to run functional tests.
     func: bool
+    #: Whether to run cryptography tests.
+    crypto: bool
     #: Whether to run the testing with virtual functions instead of physical functions
     use_virtual_functions: bool
     #: Whether to skip smoke tests.
@@ -522,6 +524,7 @@ def filter_tests(
                     for tt in t.test_cases
                     if (tt.test_type is TestCaseType.FUNCTIONAL and self.func)
                     or (tt.test_type is TestCaseType.PERFORMANCE and self.perf)
+                    or (tt.test_type is TestCaseType.CRYPTO and self.crypto)
                 ),
             )
             for t in test_suites
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index 494eb40046..94dc6023a7 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -349,7 +349,7 @@ def next(self) -> State | None:
 
         if test_run.config.use_virtual_functions:
             test_run.ctx.topology.instantiate_vf_ports()
-        if test_run.ctx.sut_node.cryptodevs:
+        if test_run.ctx.sut_node.cryptodevs and test_run.config.crypto:
             test_run.ctx.topology.instantiate_crypto_ports()
             test_run.ctx.topology.bind_cryptodevs("dpdk")
 
diff --git a/dts/framework/test_suite.py b/dts/framework/test_suite.py
index 9c57e343ac..e86096cefe 100644
--- a/dts/framework/test_suite.py
+++ b/dts/framework/test_suite.py
@@ -174,6 +174,8 @@ def filter_test_cases(
                     perf_test_cases.add(test_case)
                 case TestCaseType.FUNCTIONAL:
                     func_test_cases.add(test_case)
+                case TestCaseType.CRYPTO:
+                    pass
 
         if test_case_sublist_copy:
             raise ConfigurationError(
@@ -279,6 +281,8 @@ class TestCaseType(Enum):
     FUNCTIONAL = auto()
     #:
     PERFORMANCE = auto()
+    #:
+    CRYPTO = auto()
 
 
 class TestCase(TestProtocol, Protocol[TestSuiteMethodType]):
@@ -331,6 +335,8 @@ def _decorator(func: TestSuiteMethodType) -> type[TestCase]:
 func_test: Callable = TestCase.make_decorator(TestCaseType.FUNCTIONAL)
 #: The decorator for performance test cases.
 perf_test: Callable = TestCase.make_decorator(TestCaseType.PERFORMANCE)
+#: The decorator for cryptography test cases.
+crypto_test: Callable = TestCase.make_decorator(TestCaseType.CRYPTO)
 
 
 @dataclass
diff --git a/dts/tests/TestSuite_cryptodev_throughput.py b/dts/tests/TestSuite_cryptodev_throughput.py
index d32879b9aa..1680a6b328 100644
--- a/dts/tests/TestSuite_cryptodev_throughput.py
+++ b/dts/tests/TestSuite_cryptodev_throughput.py
@@ -32,7 +32,7 @@
 from api.test import verify
 from framework.context import get_ctx
 from framework.exception import SkippedTestException
-from framework.test_suite import BaseConfig, TestSuite, func_test
+from framework.test_suite import BaseConfig, TestSuite, crypto_test
 from framework.testbed_model.virtual_device import VirtualDevice
 
 config_list: list[dict[str, int | float | str]] = [
@@ -145,7 +145,7 @@ def _verify_throughput(
             )
         return result_list
 
-    @func_test
+    @crypto_test
     def aes_cbc(self) -> None:
         """aes_cbc test.
 
@@ -175,6 +175,7 @@ def aes_cbc(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
 
+    @crypto_test
     def aes_cbc_sha1(self) -> None:
         """aes_cbc_sha1 test.
 
@@ -209,6 +210,7 @@ def aes_cbc_sha1(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
 
+    @crypto_test
     def aes_cbc_sha2(self) -> None:
         """aes_cbc_sha2 test.
 
@@ -242,7 +244,7 @@ def aes_cbc_sha2(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
 
-    @func_test
+    @crypto_test
     def aes_cbc_sha2_digest_16(self) -> None:
         """aes_cbc_sha2_digest_16 test.
 
@@ -276,7 +278,7 @@ def aes_cbc_sha2_digest_16(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
 
-    @func_test
+    @crypto_test
     def aead_aes_gcm(self) -> None:
         """aead_aes_gcm test.
 
@@ -308,7 +310,7 @@ def aead_aes_gcm(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
 
-    @func_test
+    @crypto_test
     def aes_docsisbpi(self) -> None:
         """aes_docsisbpi test.
 
@@ -369,7 +371,7 @@ def sha1_hmac(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
 
-    @func_test
+    @crypto_test
     def snow3g_uea2_snow3g_uia2(self) -> None:
         """snow3g_uea2_snow3g_uia2 test.
 
@@ -404,7 +406,7 @@ def snow3g_uea2_snow3g_uia2(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
 
-    @func_test
+    @crypto_test
     def zuc_eea3_zuc_eia3(self) -> None:
         """zuc_eea3_zuc_eia3 test.
 
@@ -439,7 +441,7 @@ def zuc_eea3_zuc_eia3(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
 
-    @func_test
+    @crypto_test
     def kasumi_f8_kasumi_f9(self) -> None:
         """kasumi_f8 kasumi_f9 test.
 
@@ -476,7 +478,7 @@ def kasumi_f8_kasumi_f9(self) -> None:
 
     # BEGIN VDEV TESTS
 
-
+    @crypto_test
     def aesni_mb_vdev(self) -> None:
         """aesni_mb virtual device test.
 
@@ -513,7 +515,7 @@ def aesni_mb_vdev(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
 
-    @func_test
+    @crypto_test
     def aesni_gcm_vdev(self):
         """aesni_gcm virtual device test.
 
@@ -546,7 +548,7 @@ def aesni_gcm_vdev(self):
         for result in results:
             verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
 
-    @func_test
+    @crypto_test
     def kasumi_vdev(self) -> None:
         """Kasmumi virtual device test.
 
@@ -582,7 +584,7 @@ def kasumi_vdev(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
 
-    @func_test
+    @crypto_test
     def snow3g_vdev(self) -> None:
         """snow3g virtual device test.
 
@@ -619,7 +621,7 @@ def snow3g_vdev(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
 
-    @func_test
+    @crypto_test
     def zuc_vdev(self) -> None:
         """Zuc virtual device test.
 
@@ -656,7 +658,7 @@ def zuc_vdev(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
 
-    @func_test
+    @crypto_test
     def open_ssl_vdev(self) -> None:
         """open_ssl virtual device test.
 
-- 
2.50.1

