Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4680606A31D
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 20:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=ebtFahbC
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A4294025A;
	Mon, 26 Oct 2026 21:02:10 +0100 (CET)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by mails.dpdk.org (Postfix) with ESMTPS id 28C7340041
 for <dev@dpdk.org>; Mon, 26 Oct 2026 21:02:09 +0100 (CET)
Received: by mail-qt1-f177.google.com with SMTP id
 d75a77b69052e-53665358476so36626211cf.2
 for <dev@dpdk.org>; Mon, 26 Oct 2026 13:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1793044928; x=1793649728; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=saITlS/JNC+P37u2JjT1OpIEE2rc4j7JPSJcRgJwCk8=;
 b=ebtFahbCyYse2/oklGrNOphOa1YaIOHMye164e/vDdsflxt5ikdAjP4pe5safSxMzc
 lAFhFDruJVcxKePwjxRmAVyvwMdZst4EdTkiyDILTrQ7Rlq7CNF7t9mNCL/YmXeyWci0
 iQzGPaXOV3azpzBAR/OYGqATkdeLlD9xHfZjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793044928; x=1793649728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=saITlS/JNC+P37u2JjT1OpIEE2rc4j7JPSJcRgJwCk8=;
 b=sc0BBmulEyxTWmyiZ8KWtfJD/koD3GFhrPvt6iWZ0gFCY50a0zqtedx5kOREx0duUd
 TTT5+FLSfZqZdBE9FglXfeN+7iS6x7ttqXjgKtPZmpKjR6p/UHe8utIoBH8mKcODaGtY
 LaFtfBhqz/B8e83PHrME4PteSQWlwv4jpGnm3IKwqfgmKk0HdTz2+vTg/APjApfKeziF
 pElOuthB+yg0ZtZzS6fJ9Q5aYg+7lSF55UT04SBWCqqlh090/q5SqYLxamQF4r5WdAED
 T5tLb9M1p7oRHA0yDaDNH3aLBEZg9PUebLdEb440rwRv/ApXXgjoi7UQL9U5jcUfLeoO
 3UeQ==
X-Gm-Message-State: AFq9FYIHGvKvTE3mObseNJSmzq0BZILo/ffYyPLL6iW0HomsVIxyyUkB
 NXm4pp7KZ+4kJJrM5jztK2oBaC1olFbeR+vb0ek9cgS2bhjpiPb19cvchanfCBFd6bQzUHk52HC
 WwGnfvDd8m/gj5tFih3q3/4pG7WQIISeYNhrO0+FXDLwheMYZj1NsMd2wiStmPqIV5h8KeiigPG
 pJY2Lp8gEDmxnT/OcinWkI5Pp8vQc=
X-Gm-Gg: AYBFou1R3eSDVg4Fp4Y2/bRWcccL7jlqikQ9Jg1la0nDEfEqZ1Yt5ccEEmNDF6lmsL5
 SJBbvFcBvasHkI+qQoYKAGum0Z5Bv9pt2Hn8z9+GrLjg0iohGTIbxyTZVHOFNcewcTDahJK/eno
 2HW3L/oYzxtG89KdY4Of6HGh5x+HBaC2eTZC/C0+jC7YjkTliuEpexq8fEqYLkuZOLBKXTRtaM8
 kKRkky+e3x9oe+KYq8lZ/CYrylcEQ7P+qG7tSFELoHGprImZ4jO135LQ/YsnHDIweBngtzGTIJE
 /tgBv+gSBhEL1H7QJldvmImkNlzCISFelTS/WR6eFNTZneCJyIUouUewgZwzEsnqewX1p0v3y7C
 uL0mbqN1xLkHmrBqDyyFSlYmFgaUDaH/aDdSWYYNvxn6973gNJs+K0q/B/4soznXtqVKW7NIwSH
 TdaPao+Bj5dXxzOtfCoKJHEQsBpzDrUREI+jEpvRsYnamz8hb4rceNgzKfu7uAN6JFeusgUein2
 Qv/TEVkBHF2IbqWbSO9JBlyTGws50q5svOYdC7zkP7nd6cqXzImSEjbIUJW6h2ssmhRaYT/Ox/J
 lw==
X-Received: by 2002:a05:622a:613:b0:535:14f9:3f02 with SMTP id
 d75a77b69052e-5383b5b381dmr125089751cf.58.1793044927581; 
 Mon, 26 Oct 2026 13:02:07 -0700 (PDT)
Received: from d121029.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-538394f7e0esm62469961cf.12.2026.10.26.13.02.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 13:02:07 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v3] dts: remove crypto test type
Date: Mon, 26 Oct 2026 16:01:58 -0400
Message-ID: <20261026200158.66094-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260806164505.642928-1-abailey@iol.unh.edu>
References: <20260806164505.642928-1-abailey@iol.unh.edu>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When crypto tests were brought over to new DTS. The test type crypto was
added in order to run without the overhead of a TG. In the last release,
the support for no link topology was added to new DTS. When DTS is ran
in this mode, no TG is made so there is no longer a need for the crypto
test type. Crypto tests have been relabeled as performance tests and can
be run in any topology. Running crypto tests in no link mode revealed
some issues with writing NIC info when there no ports present, in this
case an empty json file is written as a placeholder.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
v3:
 * Added log message to inform about DUT NIC info behavior when
     in no link topology.
 * Removed crypto test type from test run example config.

 dts/api/test_suite.py                       |  6 ----
 dts/configurations/test_run.example.yaml    |  1 -
 dts/framework/config/test_run.py            |  3 --
 dts/framework/test_run.py                   | 12 +++++---
 dts/framework/testbed_model/topology.py     |  7 ++++-
 dts/tests/TestSuite_cryptodev_latency.py    | 32 +++++++++----------
 dts/tests/TestSuite_cryptodev_throughput.py | 34 ++++++++++-----------
 7 files changed, 46 insertions(+), 49 deletions(-)

diff --git a/dts/api/test_suite.py b/dts/api/test_suite.py
index c30d447135..a9d502f316 100644
--- a/dts/api/test_suite.py
+++ b/dts/api/test_suite.py
@@ -173,8 +173,6 @@ def filter_test_cases(
                     perf_test_cases.add(test_case)
                 case TestCaseType.FUNCTIONAL:
                     func_test_cases.add(test_case)
-                case TestCaseType.CRYPTO:
-                    pass

         if test_case_sublist_copy:
             raise ConfigurationError(
@@ -280,8 +278,6 @@ class TestCaseType(Enum):
     FUNCTIONAL = auto()
     #:
     PERFORMANCE = auto()
-    #:
-    CRYPTO = auto()


 class TestCase(TestProtocol, Protocol[TestSuiteMethodType]):
@@ -334,8 +330,6 @@ def _decorator(func: TestSuiteMethodType) -> type[TestCase]:
 func_test: Callable[[Any], type["TestCase"]] = TestCase.make_decorator(TestCaseType.FUNCTIONAL)
 #: The decorator for performance test cases.
 perf_test: Callable[[Any], type["TestCase"]] = TestCase.make_decorator(TestCaseType.PERFORMANCE)
-#: The decorator for cryptography test cases.
-crypto_test: Callable[[Any], type["TestCase"]] = TestCase.make_decorator(TestCaseType.CRYPTO)


 @dataclass
diff --git a/dts/configurations/test_run.example.yaml b/dts/configurations/test_run.example.yaml
index 182ee377aa..697677a48c 100644
--- a/dts/configurations/test_run.example.yaml
+++ b/dts/configurations/test_run.example.yaml
@@ -67,7 +67,6 @@ func_traffic_generator:
 #   config: "/opt/trex_config/trex_config.yaml" # Additional configuration files. (Leave blank if not required)
 perf: false # disable performance testing
 func: true # enable functional testing
-crypto: false # disable cryptographic testing
 use_virtual_functions: false # use virtual functions (VFs) instead of physical functions
 skip_smoke_tests: true # see `Optional Fields`
 test_suites: # see `Optional Fields`; the following test suites will be run in their entirety
diff --git a/dts/framework/config/test_run.py b/dts/framework/config/test_run.py
index 97c9a7417a..975451d925 100644
--- a/dts/framework/config/test_run.py
+++ b/dts/framework/config/test_run.py
@@ -483,8 +483,6 @@ class TestRunConfiguration(FrozenModel):
     perf: bool
     #: Whether to run functional tests.
     func: bool
-    #: Whether to run cryptography tests.
-    crypto: bool
     #: Whether to run the testing with virtual functions instead of physical functions
     use_virtual_functions: bool
     #: Whether to skip smoke tests.
@@ -524,7 +522,6 @@ def filter_tests(
                 for tt in t.test_cases
                 if (tt.test_type is TestCaseType.FUNCTIONAL and self.func)
                 or (tt.test_type is TestCaseType.PERFORMANCE and self.perf)
-                or (tt.test_type is TestCaseType.CRYPTO and self.crypto)
             )
             # Only include test suites that have at least one test case after filtering
             if test_cases:
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index 210ff25af7..500aa785df 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -360,17 +360,19 @@ def next(self) -> State | None:
         ctx.dpdk.setup()
         ctx.topology.setup()

-        testrun_nic_info: list[dict[str, str]] = (
-            self.test_run.ctx.sut_node.main_session.get_nic_info()
-        )
+        # Only collect NIC info if network ports exist.
+        testrun_nic_info: list[dict[str, str]] = []
+        if ctx.topology.sut_ports:
+            testrun_nic_info = self.test_run.ctx.sut_node.main_session.get_nic_info()
+        else:
+            self.logger.info("No DUT NIC found, DUT NIC info file will contain an empty JSON list")
         with open(f"{SETTINGS.output_dir}/dut_info.json", "w") as file:
             json.dump(testrun_nic_info, file, indent=3)
-
         self.logger.info(f"DUT NIC info written to: {SETTINGS.output_dir}/dut_info.json")

         if test_run.config.use_virtual_functions:
             ctx.topology.instantiate_vf_ports()
-        if ctx.sut_node.cryptodevs and test_run.config.crypto:
+        if ctx.sut_node.cryptodevs and test_run.config.perf:
             ctx.topology.instantiate_crypto_ports()
             ctx.topology.bind_cryptodevs("dpdk")

diff --git a/dts/framework/testbed_model/topology.py b/dts/framework/testbed_model/topology.py
index 25bcba4c12..2f85967528 100644
--- a/dts/framework/testbed_model/topology.py
+++ b/dts/framework/testbed_model/topology.py
@@ -142,9 +142,14 @@ def setup(self) -> None:

         Binds all the ports to the right kernel driver to retrieve MAC addresses and logical names.
         """
+        from framework.context import get_ctx
+
+        if self.type is not LinkTopology.NO_LINK or get_ctx().sut_node.cryptodevs:
+            self._prepare_devbind_script()
+
         if self.type is LinkTopology.NO_LINK:
             return
-        self._prepare_devbind_script()
+
         self._setup_ports("sut")
         self._setup_ports("tg")

diff --git a/dts/tests/TestSuite_cryptodev_latency.py b/dts/tests/TestSuite_cryptodev_latency.py
index 444a5b282c..63f5113cf7 100644
--- a/dts/tests/TestSuite_cryptodev_latency.py
+++ b/dts/tests/TestSuite_cryptodev_latency.py
@@ -31,7 +31,7 @@
     CryptodevResults,
 )
 from api.test import skip, verify
-from api.test_suite import BaseConfig, TestSuite, crypto_test
+from api.test_suite import BaseConfig, TestSuite, perf_test
 from api.testbed_model.virtual_device import VirtualDevice

 config_list: list[dict[str, int | float | str]] = [
@@ -159,7 +159,7 @@ def _verify_latency(
             )
         return result_list

-    @crypto_test
+    @perf_test
     def aes_cbc(self) -> None:
         """aes_cbc latency test.

@@ -193,7 +193,7 @@ def aes_cbc(self) -> None:
                 "latency was greater than the delta tolerance above baseline",
             )

-    @crypto_test
+    @perf_test
     def aes_cbc_sha1_hmac(self) -> None:
         """aes_cbc_sha1_hmac latency test.

@@ -230,7 +230,7 @@ def aes_cbc_sha1_hmac(self) -> None:
                 "latency was greater than the delta tolerance above baseline",
             )

-    @crypto_test
+    @perf_test
     def aes_cbc_sha2_hmac(self) -> None:
         """aes_cbc_sha2_hmac latency test.

@@ -268,7 +268,7 @@ def aes_cbc_sha2_hmac(self) -> None:
                 "latency was greater than the delta tolerance above baseline",
             )

-    @crypto_test
+    @perf_test
     def aes_docsisbpi(self) -> None:
         """aes_docsisbpi latency test.

@@ -301,7 +301,7 @@ def aes_docsisbpi(self) -> None:
                 "latency was greater than the delta tolerance above baseline",
             )

-    @crypto_test
+    @perf_test
     def aes_gcm(self) -> None:
         """aes_gcm latency test.

@@ -337,7 +337,7 @@ def aes_gcm(self) -> None:
                 "latency was greater than the delta tolerance above baseline",
             )

-    @crypto_test
+    @perf_test
     def kasumi_f8_kasumi_f9(self) -> None:
         """kasumi_f8_kasumi_f9 latency test.

@@ -375,7 +375,7 @@ def kasumi_f8_kasumi_f9(self) -> None:
                 "latency was greater than the delta tolerance above baseline",
             )

-    @crypto_test
+    @perf_test
     def snow3g_uea2_snow3g_uia2(self) -> None:
         """snow3g_uea2_snow3g_uia2 latency test.

@@ -413,7 +413,7 @@ def snow3g_uea2_snow3g_uia2(self) -> None:
                 "latency was greater than the delta tolerance above baseline",
             )

-    @crypto_test
+    @perf_test
     def zuc_eea3_zuc_eia3(self) -> None:
         """zuc_eea3_zuc_eia3 cipher and auth latency test.

@@ -453,7 +453,7 @@ def zuc_eea3_zuc_eia3(self) -> None:

     # BEGIN VDEV TESTS

-    @crypto_test
+    @perf_test
     def aesni_gcm_vdev(self) -> None:
         """aesni_gcm virtual device latency test.

@@ -489,7 +489,7 @@ def aesni_gcm_vdev(self) -> None:
                 "latency was greater than the delta tolerance above baseline",
             )

-    @crypto_test
+    @perf_test
     def aesni_mb_cipher_then_auth_vdev(self) -> None:
         """aesni_mb vdev cipher and auth latency test.

@@ -527,7 +527,7 @@ def aesni_mb_cipher_then_auth_vdev(self) -> None:
                 "latency was greater than the delta tolerance above baseline",
             )

-    @crypto_test
+    @perf_test
     def aesni_mb_vdev(self) -> None:
         """aesni_mb vdev latency test.

@@ -562,7 +562,7 @@ def aesni_mb_vdev(self) -> None:
                 "latency was greater than the delta tolerance above baseline",
             )

-    @crypto_test
+    @perf_test
     def kasumi_vdev(self) -> None:
         """Kasumi vdev latency test.

@@ -601,7 +601,7 @@ def kasumi_vdev(self) -> None:
                 "latency was greater than the delta tolerance above baseline",
             )

-    @crypto_test
+    @perf_test
     def open_ssl_vdev(self) -> None:
         """open_ssl vdev latency test.

@@ -637,7 +637,7 @@ def open_ssl_vdev(self) -> None:
                 "latency was greater than the delta tolerance above baseline",
             )

-    @crypto_test
+    @perf_test
     def snow3g_vdev(self) -> None:
         """snow3g vdev latency test.

@@ -677,7 +677,7 @@ def snow3g_vdev(self) -> None:
                 "latency was greater than the delta tolerance above baseline",
             )

-    @crypto_test
+    @perf_test
     def zuc_vdev(self) -> None:
         """Zuc vdev latency test.

diff --git a/dts/tests/TestSuite_cryptodev_throughput.py b/dts/tests/TestSuite_cryptodev_throughput.py
index 59f64f2cd7..845d998291 100644
--- a/dts/tests/TestSuite_cryptodev_throughput.py
+++ b/dts/tests/TestSuite_cryptodev_throughput.py
@@ -31,7 +31,7 @@
     CryptodevResults,
 )
 from api.test import skip, verify
-from api.test_suite import BaseConfig, TestSuite, crypto_test
+from api.test_suite import BaseConfig, TestSuite, perf_test
 from api.testbed_model.virtual_device import VirtualDevice

 config_list: list[dict[str, int | float | str]] = [
@@ -144,7 +144,7 @@ def _verify_throughput(
             )
         return result_list

-    @crypto_test
+    @perf_test
     def aes_cbc(self) -> None:
         """aes_cbc test.

@@ -171,7 +171,7 @@ def aes_cbc(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")

-    @crypto_test
+    @perf_test
     def aes_cbc_sha1(self) -> None:
         """aes_cbc_sha1 test.

@@ -203,7 +203,7 @@ def aes_cbc_sha1(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")

-    @crypto_test
+    @perf_test
     def aes_cbc_sha2(self) -> None:
         """aes_cbc_sha2 test.

@@ -234,7 +234,7 @@ def aes_cbc_sha2(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")

-    @crypto_test
+    @perf_test
     def aes_cbc_sha2_digest_16(self) -> None:
         """aes_cbc_sha2_digest_16 test.

@@ -265,7 +265,7 @@ def aes_cbc_sha2_digest_16(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")

-    @crypto_test
+    @perf_test
     def aead_aes_gcm(self) -> None:
         """aead_aes_gcm test.

@@ -294,7 +294,7 @@ def aead_aes_gcm(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")

-    @crypto_test
+    @perf_test
     def aes_docsisbpi(self) -> None:
         """aes_docsisbpi test.

@@ -321,7 +321,7 @@ def aes_docsisbpi(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")

-    @crypto_test
+    @perf_test
     def sha1_hmac(self) -> None:
         """sha1_hmac test.

@@ -349,7 +349,7 @@ def sha1_hmac(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")

-    @crypto_test
+    @perf_test
     def snow3g_uea2_snow3g_uia2(self) -> None:
         """snow3g_uea2_snow3g_uia2 test.

@@ -381,7 +381,7 @@ def snow3g_uea2_snow3g_uia2(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")

-    @crypto_test
+    @perf_test
     def zuc_eea3_zuc_eia3(self) -> None:
         """zuc_eea3_zuc_eia3 test.

@@ -413,7 +413,7 @@ def zuc_eea3_zuc_eia3(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")

-    @crypto_test
+    @perf_test
     def kasumi_f8_kasumi_f9(self) -> None:
         """kasumi_f8 kasumi_f9 test.

@@ -447,7 +447,7 @@ def kasumi_f8_kasumi_f9(self) -> None:

     # BEGIN VDEV TESTS

-    @crypto_test
+    @perf_test
     def aesni_mb_vdev(self) -> None:
         """aesni_mb virtual device test.

@@ -481,7 +481,7 @@ def aesni_mb_vdev(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")

-    @crypto_test
+    @perf_test
     def aesni_gcm_vdev(self):
         """aesni_gcm virtual device test.

@@ -511,7 +511,7 @@ def aesni_gcm_vdev(self):
         for result in results:
             verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")

-    @crypto_test
+    @perf_test
     def kasumi_vdev(self) -> None:
         """Kasmumi virtual device test.

@@ -544,7 +544,7 @@ def kasumi_vdev(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")

-    @crypto_test
+    @perf_test
     def snow3g_vdev(self) -> None:
         """snow3g virtual device test.

@@ -578,7 +578,7 @@ def snow3g_vdev(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")

-    @crypto_test
+    @perf_test
     def zuc_vdev(self) -> None:
         """Zuc virtual device test.

@@ -612,7 +612,7 @@ def zuc_vdev(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")

-    @crypto_test
+    @perf_test
     def open_ssl_vdev(self) -> None:
         """open_ssl virtual device test.

--
2.56.0

