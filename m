Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCD6EF99D2
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 19:36:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D9FC40679;
	Fri, 13 Feb 2026 20:36:06 +0100 (CET)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id 08C4E40656
 for <dev@dpdk.org>; Fri, 13 Feb 2026 20:36:03 +0100 (CET)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-8cb3bae8d3eso140745785a.1
 for <dev@dpdk.org>; Fri, 13 Feb 2026 11:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1771011362; x=1771616162; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nQcprJtRby0e93lftBPiH1BNWcgxoGBOfAtaAOnzMhQ=;
 b=W6/g+BoQUV6qeohfoUUlBr/rtGXS7KYpUdzinxe7PhR6D+xXCcY25SBz7M5TqzmgIX
 xYwEfhy0tUvm2N/bzr1sG2ZnztWAOaSqQ8eZDWImeyxk3AQIu541VQvOKdg9emP5cKHA
 M+V+VY7sTqYxMjkobPXFHqgSm0rT4zROk3d+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771011362; x=1771616162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nQcprJtRby0e93lftBPiH1BNWcgxoGBOfAtaAOnzMhQ=;
 b=QfuUouBxemEsFaDgIOU7V4C6IaB/qiKsC9Ap81qzQ8OSKGjFMFUwR4JSEJaUpvNkIG
 ZAOn/CpzJRMBDrYAhyquLPn0xpqyIlDls9ZJyHTGndDhSZzGe9NaFaDKtwj5Ly/0AqY6
 kJYK9CQJ5giYPSUu/iek1bC0iUhsFYge2NotYCf2jNeKcikFP1ij6hFR5qm/ds3FN+9L
 Wf8XUzT75qZauT2XBcKkg5uOOa0NkXpIr8B/9IFlycNizj5berm7Xc8h7fRjWqq/Zf3W
 6A/CAyuEalZosiyAGrNFCzBKtVZ+ftR/4dPPHFZIuELZIDhlYGoaZ7qrS1itwSnoVdCK
 Sl2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfPIF6zWXyjqrgc3k+B+Q8RdQRo7KXALF7hdrXN0cYhnDp8FJ23NlZc0A2bdfLdPPcHwY=@dpdk.org
X-Gm-Message-State: AOJu0YzQmYhUIao6CBKZjZwh9JpA45k4CU5jmieWeJu/Tf65gjb02/hw
 pRGFlg4S8+tVlN69Lb7TLQ20vMXBBiXyI7U5QKGMEEwIrFqFSeP0ENIo544rzBh36bI=
X-Gm-Gg: AZuq6aLSW25T9QCDCcNme81gIV3ADMBOSafH5bFXg773ZZnAOcnF8fj3jpd6sM+FjXt
 STeieZe0/Xt1neo3U+hncjOBH9RB7EOn92en4yiobMmhCO2IyDcs1CYAHPhuPF4Zd7cssWlfxTS
 MVSmEnUUHv42sO79jEOz6OIq1IZmwCWbS4WC34r/O4An2mLKCdlq1MfnFv8Z81c6o/rWWSutqWc
 ht9vByltvvNnT/fiOShu80Qe7tMGXNJ8Gd9ATJuXx6j5JQTm2hvps4U9gD8aJt2Mch6/dDynj45
 s5m5BzSbaopuAWDzuaSHwthQ17vS64SWCriFKckGq1jYCjbGZsqfJZH0w38XL5iDA604vZB8zGH
 0993jwy7Z7OG9q9qTj5MrmoCkA+1pCCn7CuO0I1wS4OPXXOEwFdKE1vyOlnmVl0Q7QtgbRtdKjh
 +bVGBLW0/sQGsbv/885BW+eZ8NVbHCFl8GbUdCL078ESGUHcXa/IlPct6AlS2fvEpP
X-Received: by 2002:a05:620a:4095:b0:8c7:6f8:ae4c with SMTP id
 af79cd13be357-8cb408d6a21mr462090385a.43.1771011362314; 
 Fri, 13 Feb 2026 11:36:02 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cb45f13a61sm146726085a.7.2026.02.13.11.36.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 11:36:01 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com,
	probb@iol.unh.edu
Cc: dmarx@iol.unh.edu,
	dev@dpdk.org,
	Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v3 4/5] dts: add crypto test decorator
Date: Fri, 13 Feb 2026 14:35:38 -0500
Message-ID: <20260213193539.103858-5-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260213193539.103858-1-abailey@iol.unh.edu>
References: <20260210193448.69423-1-abailey@iol.unh.edu>
 <20260213193539.103858-1-abailey@iol.unh.edu>
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
index 871e47ae63..387afe8bcd 100644
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
 
@@ -206,6 +207,7 @@ def aes_cbc_sha1(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "gbps fell below delta tolerance")
 
+    @crypto_test
     def aes_cbc_sha2(self) -> None:
         """aes_cbc_sha2 test.
 
@@ -239,7 +241,7 @@ def aes_cbc_sha2(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "gbps fell below delta tolerance")
 
-    @func_test
+    @crypto_test
     def aes_cbc_sha2_digest_16(self) -> None:
         """aes_cbc_sha2_digest_16 test.
 
@@ -273,7 +275,7 @@ def aes_cbc_sha2_digest_16(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "gbps fell below delta tolerance")
 
-    @func_test
+    @crypto_test
     def aead_aes_gcm(self) -> None:
         """aead_aes_gcm test.
 
@@ -305,7 +307,7 @@ def aead_aes_gcm(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "gbps fell below delta tolerance")
 
-    @func_test
+    @crypto_test
     def aes_docsisbpi(self) -> None:
         """aes_docsiscpi test.
 
@@ -366,7 +368,7 @@ def sha1_hmac(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "gbps fell below delta tolerance")
 
-    @func_test
+    @crypto_test
     def snow3g_uea2_snow3g_uia2(self) -> None:
         """snow3g_uea2_snow3g_uia2 test.
 
@@ -401,7 +403,7 @@ def snow3g_uea2_snow3g_uia2(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "gbps fell below delta tolerance")
 
-    @func_test
+    @crypto_test
     def zuc_eea3_zuc_eia3(self) -> None:
         """zuc_eea3_zuc_eia3 test.
 
@@ -436,7 +438,7 @@ def zuc_eea3_zuc_eia3(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "gbps fell below delta tolerance")
 
-    @func_test
+    @crypto_test
     def kasumi_f8_kasumi_f9(self) -> None:
         """kasumi_f8 kasumi_f9 test.
 
@@ -473,7 +475,7 @@ def kasumi_f8_kasumi_f9(self) -> None:
 
     # BEGIN VDEV TESTS
 
-
+    @crypto_test
     def aesni_mb_vdev(self) -> None:
         """aesni_mb virtual device test.
 
@@ -510,7 +512,7 @@ def aesni_mb_vdev(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "gbps fell below delta tolerance")
 
-    @func_test
+    @crypto_test
     def aesni_gcm_vdev(self):
         """aesni_gcm virtual device test.
 
@@ -543,7 +545,7 @@ def aesni_gcm_vdev(self):
         for result in results:
             verify(result["passed"] == "PASS", "gbps fell below delta tolerance")
 
-    @func_test
+    @crypto_test
     def kasumi_vdev(self) -> None:
         """Kasmumi virtual device test.
 
@@ -579,7 +581,7 @@ def kasumi_vdev(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "gbps fell below delta tolerance")
 
-    @func_test
+    @crypto_test
     def snow3g_vdev(self) -> None:
         """snow3g virtual device test.
 
@@ -616,7 +618,7 @@ def snow3g_vdev(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "gpbs fell below delta tolerance")
 
-    @func_test
+    @crypto_test
     def zuc_vdev(self) -> None:
         """Zuc virtual device test.
 
@@ -653,7 +655,7 @@ def zuc_vdev(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "gpbs fell below delta tolerance")
 
-    @func_test
+    @crypto_test
     def open_ssl_vdev(self) -> None:
         """open_ssl virtual device test.
 
-- 
2.50.1

