Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B4C606A33B
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 20:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=cGmvhbIT
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79CDC40297;
	Mon, 19 Oct 2026 22:14:08 +0200 (CEST)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48]) by mails.dpdk.org (Postfix) with ESMTP id F32014021E
 for <dev@dpdk.org>; Mon, 19 Oct 2026 22:14:06 +0200 (CEST)
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-91986c5cb75so27025416d6.0
 for <dev@dpdk.org>; Mon, 19 Oct 2026 13:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1792440846; x=1793045646; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LwSXFnVn1xsUDGzaoQCUMD4DLSEfEdzsG51XQ2l3ncQ=;
 b=cGmvhbITGDkDCTY8bT/VJnaOuUfgjJS0o1VRA83XqVXO2Sq1CPprq4B73KKRe1nRJN
 cYF1A0WG2WBVNZSLy7pPNbFolEsjsXIXLVRcyMZ0Hlizh4buv340DtX9tvqEOT90LO01
 HIyKJUcE7zymk4LH27OxBbuxKMuFiskbG00yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792440846; x=1793045646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LwSXFnVn1xsUDGzaoQCUMD4DLSEfEdzsG51XQ2l3ncQ=;
 b=chhcG85WdDfZGV8axzoe/6deiwsv4nW1JEYaZ55dBQyjiTgYnO/UWH27jj5CCOr0UC
 nYBDg3pkxIL7uG4sms3ooIJpXh4zXPF6JXpgdtLF8PCaDRV9pmDK40goKWnRQQgkKtM/
 MY0IFxsYYlB4PC2LhVeUgcwD4IpakARBXUro12VRcnOiRTlMx4QI7riuNM0jAjrz8wNk
 BZ+EXCY+OqKDiKFcoVreNapYfUjaH1OtLEH6cra1UnSsQlfYOGSZi1nmC+z9s/lqWzUr
 QXBY4dtQ6qEQa5LpDoJQ+/mtzhbRtgXKMfaYw8LlozLKKxMSAj51HoD6R2kvK2R9NESD
 GlZQ==
X-Gm-Message-State: AFq9FYIgrmL6UDZAAYtpszpOPIaOIjchQ2h4dkD/Rbs1BVwG86QUJw4p
 WyQZ3F5+fJcL2OGqSMaBAekgCGqufmrku9lab/XsB0ak3zmpbk6nVmcRZRP254H3KzBpyOUVg4Q
 30kU28orSK5jIIh+dLomj0zMqKq13/pzXZg8boTzB2qIVjQoLaVdz8ND7pSA2ZThsnLChqXjd1z
 GHvlUrYF21KMU3qptQlGAsxsp2Wf0=
X-Gm-Gg: AYBFou0TBm2QNYXiROd0gO9P3hC88NloGWBTvtheFKSHEzHN1ODKotKbMbiZdUlindZ
 75OokGv3Rb25DA8OwwppH3yvyFkJ9NVRRkaJunJ5ZNReLprfztuJcXCqUsGM+lqDXX6NNkTGBmk
 Kx5WezTBzjoaJqJMSth/53CYdH2vEXvDB+QSi2BzFoVDGs4sWPXJ9N3hKdxPVbWfBDaxrWnR6jQ
 Yh93W37nGAMmwPgG9iAHIVTtGvFcVETJO5S3licvY1wR+dLFCor6O/KPRGYtZJVvgkUyiLNcce6
 axiXQ1vJRjVgCgXuas2/y15Oc+tuESH1TLkpwkn/tRoz1wMkLYDjxWmrN1GNIdQtaOrBXWgr5Z5
 9d82X6M+4G+RshPct3XX9UG/tR0kJqYwEkFuaX1ioT9LbEi2w/qknGS/bJmnvs8sBQBcXpeGFRl
 lLXshg9674tMI8+gGAiLIV48GqL33E1J+GhXQXv/STIIDQqEViEmprGnaEn/0Gyd+jwDvk5xDQl
 TzKsZE20GNCeGLUaq6I
X-Received: by 2002:a05:620a:4042:b0:93e:fa30:f1ef with SMTP id
 af79cd13be357-93f29dc4771mr1525120585a.67.1792440845851; 
 Mon, 19 Oct 2026 13:14:05 -0700 (PDT)
Received: from d121029.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c040e2ddesm5147486d6.36.2026.10.19.13.14.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 13:14:02 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org, luca.vizzarro@arm.com, patrickrobb1997@gmail.com,
 dladd@iol.unh.edu
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v2] dts: remove crypto test type
Date: Mon, 19 Oct 2026 16:13:42 -0400
Message-ID: <20261019201342.903235-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.55.0
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
v2:
 * Rebased on main.

 dts/api/test_suite.py                       |  6 ----
 dts/framework/config/test_run.py            |  3 --
 dts/framework/test_run.py                   | 10 +++---
 dts/framework/testbed_model/topology.py     |  7 ++++-
 dts/tests/TestSuite_cryptodev_latency.py    | 32 +++++++++----------
 dts/tests/TestSuite_cryptodev_throughput.py | 34 ++++++++++-----------
 6 files changed, 44 insertions(+), 48 deletions(-)

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
index 210ff25af7..5faa006748 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -360,17 +360,17 @@ def next(self) -> State | None:
         ctx.dpdk.setup()
         ctx.topology.setup()

-        testrun_nic_info: list[dict[str, str]] = (
-            self.test_run.ctx.sut_node.main_session.get_nic_info()
-        )
+        # Only collect NIC info if network ports exist.
+        testrun_nic_info: list[dict[str, str]] = []
+        if ctx.topology.sut_ports:
+            testrun_nic_info = self.test_run.ctx.sut_node.main_session.get_nic_info()
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
2.55.0

