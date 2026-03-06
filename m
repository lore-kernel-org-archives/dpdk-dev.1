Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEE4FCB622
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 16:41:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 952784278E;
	Fri,  6 Mar 2026 17:40:40 +0100 (CET)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by mails.dpdk.org (Postfix) with ESMTP id 5596A42799
 for <dev@dpdk.org>; Fri,  6 Mar 2026 17:40:38 +0100 (CET)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-8cb38e6d164so1215504285a.3
 for <dev@dpdk.org>; Fri, 06 Mar 2026 08:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1772815238; x=1773420038; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lG6IqjeNoY6GWT6bm6GFh7dmMkgg8t81YMrojlXU4sc=;
 b=NxhRT0ii6aDB+rO3SMfvZbzDD3UHATq/I1i+IIXU903LgXNu+8oyaafAWckSRk7JyE
 VyFSOuL6QG5cHUw5fKeu6YTtgzlSg8zP42VEJ87AsT7ssA+mH73RFkXvWI7uWcmk2VBo
 NSGXhPtzVp6kPtCGfqB/GRntxM7oTQGOwwbvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772815238; x=1773420038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lG6IqjeNoY6GWT6bm6GFh7dmMkgg8t81YMrojlXU4sc=;
 b=oP+hwVkKCuykydKk8vo83/pcQDA62wvXhgrNlTA224C4UNauQs1J3D3QUYnCEyiMlW
 GfxsQD3H20NILXH/+RjX6XqRy+8HpldRjkm3+0n4mQGmYsMWNswqFWAp0iV40yOyhRE6
 SeV+XwS8HJVXmvVBGed7V2fAc5vUvKe+TPJUsF4MMqO2LPj8M8qr3uY+JPkWSS+xKjB7
 UivT2wfiEOyccOaZCo/vi3Gk+0CMWrost/5kCS/DYqLFVcGFp1x3Yn9uo9LorG29d/S5
 XlocrpQ4LRCA5qyPzdPoDV3mHGGxduwyVcVjahYtIsorqlJf8y24R1m9QU+A5ZH74xOT
 /lNQ==
X-Gm-Message-State: AOJu0YxaZRSh8qEL7nxeZ3jT98Vg3U7RAamH3tOiOJpGRtyFZuFMOsqt
 NKAwVK7D0g7hAS4xxSWP9CIRLAkwXxBksa8heY7U5jiz70jONRAE+eevwl9Bnjs0ZXM=
X-Gm-Gg: ATEYQzx8y3z1XUwVlGdfbgvayjKNFwjs+O1Si7tSt9GW6ILTdXOYXs73EvuKFExUREy
 8ZdiJKjVipyNwVUxh3Ecf8d2fzW8yySwq/yPDJUYbqUvi3EGu78smHRYtpFl/gD5VExH1IBA2iH
 nes4LZZEO7M5ysDJLkRYE1MOlRHNrPLQHx7x+N6ggfTeDRNEQbh7ilPIY8Jddj6q7W2ZiTPdLwo
 ybMCUHGo9NbFg5XsN6mfcMPN5tgJ959WKcD2TeE63alMyCSBh/PYxt7xD23b6S2l9YEspsrDvaT
 6A8yMle0chVdox6aiONDNPsy/I8pd97sHsoUWWJknOWOfnhyr53+Il/qku+4O1Hd3UqPxjvLHAj
 zOV+iM2ABvT4rZ2droRwN/iAh9yFBzO1b+XxsI1zC2SOk15n99Dc5NfkZbaBnDuxPbWdT2oiEOm
 oz5f+fzL15FYWIvcGfjdhxcWPgdEwB6PeuW7xV2eWjZzOLKP9LaMdPFh2qMxZD1gBV
X-Received: by 2002:a05:620a:4688:b0:8ca:2cf9:81a0 with SMTP id
 af79cd13be357-8cd6d4cc0c5mr353838785a.51.1772815237514; 
 Fri, 06 Mar 2026 08:40:37 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd6f566fd5sm144608185a.43.2026.03.06.08.40.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 08:40:36 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: probb@iol.unh.edu
Cc: dev@dpdk.org, luca.vizzarro@arm.com, dmarx@iol.unh.edu, kai.ji@intel.com,
 dharmikjayesh.thakkar@arm.com, david.marchand@redhat.com,
 gakhil@marvell.com, Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v5 5/5] dts: add crypto test decorator
Date: Fri,  6 Mar 2026 11:40:27 -0500
Message-ID: <20260306164027.171723-6-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306164027.171723-1-abailey@iol.unh.edu>
References: <20260210193448.69423-1-abailey@iol.unh.edu>
 <20260306164027.171723-1-abailey@iol.unh.edu>
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
index 707a3104ed..ee641f5dce 100644
--- a/dts/configurations/test_run.example.yaml
+++ b/dts/configurations/test_run.example.yaml
@@ -48,6 +48,7 @@ func_traffic_generator:
 #   config: "/opt/trex_config/trex_config.yaml" # Additional configuration files. (Leave blank if not required)
 perf: false # disable performance testing
 func: true # enable functional testing
+crypto: false # disable cryptographic testing
 use_virtual_functions: false # use virtual functions (VFs) instead of physical functions
 skip_smoke_tests: true # see `Optional Fields`
 test_suites: # see `Optional Fields`; the following test suites will be run in their entirety
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
index 638a52ac74..af0a5680ab 100644
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

