Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DB0EB26F7
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 18:32:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E70E140B94;
	Tue, 10 Feb 2026 19:32:30 +0100 (CET)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by mails.dpdk.org (Postfix) with ESMTP id 0CEF740B91
 for <dev@dpdk.org>; Tue, 10 Feb 2026 19:32:30 +0100 (CET)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-502a789834fso53353541cf.2
 for <dev@dpdk.org>; Tue, 10 Feb 2026 10:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1770748340; x=1771353140; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gsSVyFY6Wn5fZjyCbeg80JtGPVHXMxmWzb3YihbG0W0=;
 b=YMwYV3QnkiSumP3+dpdPTrOmgyj4rlp/gWjaypMGXeoIvVt9RxLVbuHAszOvC/+6bH
 A4vohcCkioNX5YSdrqVpTz3e/a6DTzZMfW6qh7D6JOOdJqHrosx6+7pHmeHJT/dpi5Bv
 LPz8i2x9mBBdL2QyKjy2IutPln/aO6JIQTxUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770748340; x=1771353140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gsSVyFY6Wn5fZjyCbeg80JtGPVHXMxmWzb3YihbG0W0=;
 b=jrPzhrEgAJPQmu222yQ/Mcx5CP05/4rnnBtu01tjT9/bS1MtEJuyGLezXRlAIhRH5D
 JOieocvts/Lrg/o8WVAN7rM9qQo49WTLmCi0Pu4T4sjn+CoVgR+7VJ0bZF6plSK29rmB
 OBfFHRweOtbCwmIEvZQFKrctR8dx1xNxnfGsKdmy3eqXOvB/EDRJu86BTMn+ZQCuKVh7
 i5+N6awy8YnsxHEZWVCLDmtfzKJbReply/opVVGI5KQ1/aMh9wZiwO0P3c/YotTMcdtS
 7Gdyh5IlInrM6JWm6UnpOeGHGfD7hCAyrGtkd6Q5FkTz3b5Wx4LVykbHkHmr8R/wEDA1
 519w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiwb23RLpnOwPnIYR6QVb4/k2Ldjl0GKF/ZY5DdB2AvXnWAVGm6WXfknKsVUf+nB5NOMA=@dpdk.org
X-Gm-Message-State: AOJu0Yy8WPA24YZ8ts6g1W9OxVwm9UEGZ7jlhwDm2hxPn2t3Ht+7OzOP
 57Ux23B/7PTiY9NJVBs83GRo8Bw/WoAjQe13XJwCnW/m/nw/hGFXF+4FZafPGeMnswYLYV6aDfI
 5OLK/
X-Gm-Gg: AZuq6aK3imCelmxwG7WV5pZFLY572uOleiqU/BJpK8FaP9REO7H60PL2jYBeMjFvSIg
 waOs7JMI11ZAZiE9L/Df9w/WnzhdhN7fXlY82oljs4o77aiqfe18YiyJciK7GuuBLbNv+ZX8LMU
 Dhn5UjrdzXDoY+bT2ZI44C6ixtwCq7l94qcatSunkXlie/nTbMVf301lnp1oEtiKPgPdCIzo/Da
 /HtgIlApJSO+A7Tvh8GQEqFtXXQQWKLqVGPPGGhzRG9XOtoDIVHU8nKt4P9XXc55q/RHzZNlJcg
 QuD8QXkCLXZLZlFlufCLZYK6+voUR6vg9xgm55u0gAlgrMJUAug3hCvhKkSpexlBxU1nX+hXbUS
 YZhwEM8som7E9hIemm1Iwm09eO+fybnO7MDw9hHReEu9i6oi4gQ4LMyRF4vYXt8w/WjnS9yENms
 FKJVIRoqoJ08tJDPkMvJkdaIJihFk7iFT3kVnqaKnAKpP/6e2o/KkyZOZe+vh7e5l6
X-Received: by 2002:a05:620a:d88:b0:8b2:1ee9:dcfb with SMTP id
 af79cd13be357-8cb1f6b3433mr389549085a.8.1770746813569; 
 Tue, 10 Feb 2026 10:06:53 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8caf77f2868sm1079300385a.3.2026.02.10.10.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 10:06:53 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com,
	probb@iol.unh.edu
Cc: dmarx@iol.unh.edu,
	dev@dpdk.org,
	Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v2 4/5] dts: add crypto test decorator
Date: Tue, 10 Feb 2026 13:06:44 -0500
Message-ID: <20260210180645.65880-5-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260210180645.65880-1-abailey@iol.unh.edu>
References: <20260122214424.322422-1-abailey@iol.unh.edu>
 <20260210180645.65880-1-abailey@iol.unh.edu>
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

