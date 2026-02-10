Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5101EB2700
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 19:35:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3440540E31;
	Tue, 10 Feb 2026 20:35:21 +0100 (CET)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com
 [209.85.219.47]) by mails.dpdk.org (Postfix) with ESMTP id 519C440E0A
 for <dev@dpdk.org>; Tue, 10 Feb 2026 20:35:18 +0100 (CET)
Received: by mail-qv1-f47.google.com with SMTP id
 6a1803df08f44-897023602b1so15763176d6.0
 for <dev@dpdk.org>; Tue, 10 Feb 2026 11:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1770752118; x=1771356918; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gsSVyFY6Wn5fZjyCbeg80JtGPVHXMxmWzb3YihbG0W0=;
 b=FLHvX9wmDziab0m/s+lxJPw9picDfOtsjWcVG8LdRsRKBLkFGeem4hAXvjHomZx1HQ
 dI/U7mxQdkj12FE1vC008Zr3NGdl2Lns9l78nO7gsxc757+OzEBff67Ibjni9/K+sXhn
 IjDed2l1IFyTTwCKtf686ttTdExcc4w8DqVbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770752118; x=1771356918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gsSVyFY6Wn5fZjyCbeg80JtGPVHXMxmWzb3YihbG0W0=;
 b=uej2XibqETVM6W+lvvC7rupgaUhDu5BG/3Ao5v6ZN8/cwMP74TMVZq8eW2O/KMZb98
 Q1yRuYdSrdkVbGvgm3U7j+2P2XoVU4KoJTE5GQ7TFWy2qNe9elJBMZne2oQocWPmyZes
 JsOSauUoVNnrZLJf7QtNhDH07x3HsyacwpfrHfphay8VfwYk1fU2FF2tmECFbzB0JR6P
 LFcMEnndmwDVfqEVGemXvJ9rn0JYarZZCJpKgQcAWjAMClujKYBhL8YywnMdy+e/xgW2
 smIqCTizMhwirCr+G/l8Ssa87UA/6/uPGsPLgHDQQseSmbgAZODKipXR9ROzVqK6nLGI
 sy9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlUo8X+tM+f4pJAyBqGnbPqbDka+PfZwXxQ2Hn8mNBn/bXboWjRd007v6AE1gY6yWVcK8=@dpdk.org
X-Gm-Message-State: AOJu0Yy1pUce/FvBiZJwY56nM7/csF1q7wCDXgkgXZ81UVjlRplA87pC
 NUM4NBEpcjl9vJzXTcbzvh8BAxXw0ohS2Wi4+YeJWr40Z1yTMzbqZJPl0qIB7Ts8498=
X-Gm-Gg: AZuq6aKFrdQXrKkUzfaJg2Vld4tVeiY1XVgw8hEUBDjNSsq0HQOAvCSWunfVhGZC9n5
 3RXcC/NLnBrgcc9HuQlX9tt5MNCuazTYu6/2a0QCBu5boKyrApIXBjTuDNxywy3vP2TXWLnmh54
 7DZspReB7aa+clbxwsgxqrlcc8XyU8AaskxyHKk/RGQCOp5OBbjiHztsvEOp1IUbyRYAEnRtK5z
 TdnPro5Ut0en9y/mMzXVlkGwyJGCdSk0znVxJGz7u4XGkG0jb4+833X6/2RBJQJC88qxewgHDrh
 sPv5MM5orF8Yf0TtES0MwtttsVGJL3Oc9xb8lIl7ykd0lTSfUaov/n+izRLAhDzyFowITPec5zT
 mlzhjHJpjXvTLRgIAAelkOpQ+RCrHOxKWlFV8gtj4C0hVaHkZKBtrOUq54MtvvOK6+PBFHqGb9A
 5oDdg8403IIM9cvyIt0ehWbqaxRMkNXqfcH9KbpB5bx/uUe+Fo4pzzcIgDsHo14rj7
X-Received: by 2002:ad4:42c6:0:b0:895:4be1:823e with SMTP id
 6a1803df08f44-8954be183d9mr114058236d6.6.1770752117524; 
 Tue, 10 Feb 2026 11:35:17 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8953bf3b6b2sm107455356d6.6.2026.02.10.11.35.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 11:35:16 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com,
	probb@iol.unh.edu,
	dev@dpdk.org
Cc: dmarx@iol.unh.edu,
	Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v2 4/5] dts: add crypto test decorator
Date: Tue, 10 Feb 2026 14:34:47 -0500
Message-ID: <20260210193448.69423-5-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260210193448.69423-1-abailey@iol.unh.edu>
References: <20260210193448.69423-1-abailey@iol.unh.edu>
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
index 36e6c5a44c..ada628c59e 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -349,7 +349,7 @@ def next(self) -> State | None:
 
         if test_run.config.use_virtual_functions:
             test_run.ctx.topology.instantiate_vf_ports()
-        if test_run.ctx.sut_node.cryptodevs:
+        if test_run.ctx.sut_node.cryptodevs and test_run.config.crypto:
             test_run.ctx.topology.instantiate_crypto_vf_ports()
             test_run.ctx.topology.configure_cryptodevs("dpdk")
 
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
index ef8fb026c2..10e3c7ff5e 100644
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
@@ -142,7 +142,7 @@ def _verify_throughput(
             result_list.append(result_dict)
         return result_list
 
-    @func_test
+    @crypto_test
     def aes_cbc(self) -> None:
         """aes_cbc test.
 
@@ -172,6 +172,7 @@ def aes_cbc(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "gbps fell below delta tolerance")
 
+    @crypto_test
     def aes_cbc_sha1(self) -> None:
         """aes_cbc_sha1 test.
 
@@ -204,6 +205,7 @@ def aes_cbc_sha1(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "gbps fell below delta tolerance")
 
+    @crypto_test
     def aes_cbc_sha2(self) -> None:
         """aes_cbc_sha2 test.
 
@@ -237,7 +239,7 @@ def aes_cbc_sha2(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "gbps fell below delta tolerance")
 
-    @func_test
+    @crypto_test
     def aes_cbc_sha2_digest_16(self) -> None:
         """aes_cbc_sha2_digest_16 test.
 
@@ -271,7 +273,7 @@ def aes_cbc_sha2_digest_16(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "gbps fell below delta tolerance")
 
-    @func_test
+    @crypto_test
     def aead_aes_gcm(self) -> None:
         """aead_aes_gcm test.
 
@@ -303,7 +305,7 @@ def aead_aes_gcm(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "gbps fell below delta tolerance")
 
-    @func_test
+    @crypto_test
     def aes_docsisbpi(self) -> None:
         """aes_docsiscpi test.
 
@@ -363,7 +365,7 @@ def aes_sha1(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "gbps fell below delta tolerance")
 
-    @func_test
+    @crypto_test
     def snow3g_uea2_snow3g_uia2(self) -> None:
         """snow3g_uea2_snow3g_uia2 test.
 
@@ -398,7 +400,7 @@ def snow3g_uea2_snow3g_uia2(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "gbps fell below delta tolerance")
 
-    @func_test
+    @crypto_test
     def zuc_eea3_zuc_eia3(self) -> None:
         """zuc_eea3_zuc_eia3 test.
 
@@ -433,7 +435,7 @@ def zuc_eea3_zuc_eia3(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "gbps fell below delta tolerance")
 
-    @func_test
+    @crypto_test
     def kasumi_f8_kasumi_f9(self) -> None:
         """kasumi_f8 kasumi_f9 test.
 
@@ -469,7 +471,7 @@ def kasumi_f8_kasumi_f9(self) -> None:
 
     # BEGIN VDEV TESTS
 
-
+    @crypto_test
     def aesni_mb_vdev(self) -> None:
         """aesni_mb virtual device test.
 
@@ -505,7 +507,7 @@ def aesni_mb_vdev(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "gbps fell below delta tolerance")
 
-    @func_test
+    @crypto_test
     def aesni_gcm_vdev(self):
         """aesni_gcm virtual device test.
 
@@ -541,7 +543,7 @@ def aesni_gcm_vdev(self):
         for result in results:
             verify(result["passed"] == "PASS", "gbps fell below delta tolerance")
 
-    @func_test
+    @crypto_test
     def kasumi_vdev(self) -> None:
         """Kasmumi virtual device test.
 
@@ -577,7 +579,7 @@ def kasumi_vdev(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "gbps fell below delta tolerance")
 
-    @func_test
+    @crypto_test
     def snow3g_vdev(self) -> None:
         """snow3g virtual device test.
 
@@ -616,7 +618,7 @@ def snow3g_vdev(self) -> None:
                 f"Gbps and MOps were {result["gbps delta"]} below baseline",
             )
 
-    @func_test
+    @crypto_test
     def zuc_vdev(self) -> None:
         """Zuc virtual device test.
 
@@ -652,7 +654,7 @@ def zuc_vdev(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "gpbs fell below delta tolerance")
 
-    @func_test
+    @crypto_test
     def open_ssl_vdev(self) -> None:
         """open_ssl virtual device test.
 
-- 
2.50.1

