Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45960C56205
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 16:45:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F39C4027E;
	Thu,  6 Aug 2026 18:45:20 +0200 (CEST)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com
 [209.85.219.51]) by mails.dpdk.org (Postfix) with ESMTP id 4188740262
 for <dev@dpdk.org>; Thu,  6 Aug 2026 18:45:19 +0200 (CEST)
Received: by mail-qv1-f51.google.com with SMTP id
 6a1803df08f44-8efcfdb2b43so17346616d6.3
 for <dev@dpdk.org>; Thu, 06 Aug 2026 09:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1786034718; x=1786639518; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TlABnHDpOGeF0Cido+MGufPb75JtFTdmLuFqt9cbitw=;
 b=bdIYCTpP1PR1VPipblDuwygFzuvc+zBulSv/6lx2+qg08z/XMS3uIkX9U+L7On/xBc
 L9jLwAS3vCFnS/0rabY3lxbkioUciwe/8qTGg+inVDnHNWPiCXcanOXSDqRCXm4dvfe7
 2OubvGryilAt8rX8BDFqZ1t1i8rZuhXtYTZ9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786034718; x=1786639518;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TlABnHDpOGeF0Cido+MGufPb75JtFTdmLuFqt9cbitw=;
 b=dfXUUO4VJhwVBU8RrXgeWt2/VmvFnBhDUThH6SJe+7u7iUC6AhANIaxMsBYJo6pVNX
 sdPM3WaJlTXw2oQQJ7lXR3OLXgUfA/SIrQ8fbi02b/Rn+x/GbSi3wR++2l7c2YbFG60p
 hE17L7PE6W1syIxymYnyhkG+ArEeEWHMAhGN5ziX/8+U/XP1mlMyLGv3wLAtCZmRUs+f
 IaSjLBxmWWtVJvdAZp48qUQuZs7jpHW3NOs7Mc56uHVu8yNKR1cRcsJ6ryI/U5P6TFTW
 qXzzf6UdJIDIqmszl3EfElecSWyS74YgSweky5blcPurA6imJBdSVMS1E7jVx/eX/Ll6
 oFnw==
X-Gm-Message-State: AOJu0YyXj6Demnj69oEbqAfzryueuHE4d/ecgrLhPVqXgKYgBCYcPTx6
 ckKzXBA/eNmrw+iXuZkaeEBtqXtWLCp5SFiI2dxWgxWGKsiNohM8G16d8jK0A7QOiv5NGygkj78
 QCnlVW+fP2tRC3ODFr613kslrfpzFx7lRsM7MBXKgEPGPPL9Ed9ckj3FRBBhLci2S2Se52hYdsP
 +RyQbmrF/fbI3UA2Zc6siWxcfCGJ0=
X-Gm-Gg: AR+sD12LEFY8dpcU2r30qJO55Hy3YVRv604y31rfHsihoAKeBEZr4mSi8GaWOImO9UU
 mDSkPpVB7BSBQoqtICNAXBER0C2ox8lQUfkqcQJ+DPCtRSlH6NVFFlnyKPp5wt9CpsIIF62vCWr
 UH4GrNobfL+fAIm+sSIvQ3hTwbsSAOifXrojcBoFmYaNPvP3oq1USI9oP+EJTHGqBsKca4PAqmZ
 8TURxq3H5nl3LU811YKadYDJV21N+TqemDwKms7f8QteqbIWkWN4orMrW/Gr0q12PFN4x4ulFiF
 jcgk0abbT1m/5MpCzFYjaMrpqYTv9Ls0mZcMPEReUmauLXd54KVFjihN2TNgdFGqLB0LTPWcB/b
 nSyZf4D3yeD1uLgpUivJbiiILXOQK13LvUhwZbVZjaKXzZ0YobuCQLLZH8gOKtLqQi8oLuBf55u
 e3o9XBmoNnlnzHSNlsqZ74SRMQwV2DUUFMDggwvyVmEN3jtczN2PGnBRqhEbG5nhUdlqtl8ZeTN
 UPtEpVPEtwATHQe9tNcbohV0n0WPMvMPeMZlJpA
X-Received: by 2002:a05:6214:2c08:b0:8ea:184f:c15a with SMTP id
 6a1803df08f44-9088125acb0mr203567626d6.17.1786034717231; 
 Thu, 06 Aug 2026 09:45:17 -0700 (PDT)
Received: from syn-2603-7083-bff0-a0d0-0000-0000-0000-1a64.res6.spectrum.com
 ([2606:4100:3880:1257::1039]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9088008e94asm55592456d6.27.2026.08.06.09.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 09:45:16 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v1] dts: remove crypto test type
Date: Thu,  6 Aug 2026 12:45:05 -0400
Message-ID: <20260806164505.642928-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.55.0
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
 dts/framework/config/test_run.py            |  3 --
 dts/framework/test_run.py                   | 10 +++---
 dts/framework/test_suite.py                 |  6 ----
 dts/framework/testbed_model/topology.py     |  7 ++++-
 dts/tests/TestSuite_cryptodev_latency.py    | 32 +++++++++----------
 dts/tests/TestSuite_cryptodev_throughput.py | 34 ++++++++++-----------
 6 files changed, 44 insertions(+), 48 deletions(-)

diff --git a/dts/framework/config/test_run.py b/dts/framework/config/test_run.py
index 81630df77d..dede681464 100644
--- a/dts/framework/config/test_run.py
+++ b/dts/framework/config/test_run.py
@@ -481,8 +481,6 @@ class TestRunConfiguration(FrozenModel):
     perf: bool
     #: Whether to run functional tests.
     func: bool
-    #: Whether to run cryptography tests.
-    crypto: bool
     #: Whether to run the testing with virtual functions instead of physical functions
     use_virtual_functions: bool
     #: Whether to skip smoke tests.
@@ -522,7 +520,6 @@ def filter_tests(
                 for tt in t.test_cases
                 if (tt.test_type is TestCaseType.FUNCTIONAL and self.func)
                 or (tt.test_type is TestCaseType.PERFORMANCE and self.perf)
-                or (tt.test_type is TestCaseType.CRYPTO and self.crypto)
             )
             # Only include test suites that have at least one test case after filtering
             if test_cases:
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index c20a0fa885..2936e68d9f 100644
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
 
diff --git a/dts/framework/test_suite.py b/dts/framework/test_suite.py
index 69ce26040a..48e0366b61 100644
--- a/dts/framework/test_suite.py
+++ b/dts/framework/test_suite.py
@@ -174,8 +174,6 @@ def filter_test_cases(
                     perf_test_cases.add(test_case)
                 case TestCaseType.FUNCTIONAL:
                     func_test_cases.add(test_case)
-                case TestCaseType.CRYPTO:
-                    pass
 
         if test_case_sublist_copy:
             raise ConfigurationError(
@@ -281,8 +279,6 @@ class TestCaseType(Enum):
     FUNCTIONAL = auto()
     #:
     PERFORMANCE = auto()
-    #:
-    CRYPTO = auto()
 
 
 class TestCase(TestProtocol, Protocol[TestSuiteMethodType]):
@@ -335,8 +331,6 @@ def _decorator(func: TestSuiteMethodType) -> type[TestCase]:
 func_test: Callable[[Any], type["TestCase"]] = TestCase.make_decorator(TestCaseType.FUNCTIONAL)
 #: The decorator for performance test cases.
 perf_test: Callable[[Any], type["TestCase"]] = TestCase.make_decorator(TestCaseType.PERFORMANCE)
-#: The decorator for cryptography test cases.
-crypto_test: Callable[[Any], type["TestCase"]] = TestCase.make_decorator(TestCaseType.CRYPTO)
 
 
 @dataclass
diff --git a/dts/framework/testbed_model/topology.py b/dts/framework/testbed_model/topology.py
index 1db444fc01..c3220553a2 100644
--- a/dts/framework/testbed_model/topology.py
+++ b/dts/framework/testbed_model/topology.py
@@ -143,9 +143,14 @@ def setup(self) -> None:
 
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
index 4e7d814faa..eac96f4a66 100644
--- a/dts/tests/TestSuite_cryptodev_latency.py
+++ b/dts/tests/TestSuite_cryptodev_latency.py
@@ -31,7 +31,7 @@
 )
 from api.test import skip, verify
 from framework.context import get_ctx
-from framework.test_suite import BaseConfig, TestSuite, crypto_test
+from framework.test_suite import BaseConfig, TestSuite, perf_test
 from framework.testbed_model.virtual_device import VirtualDevice
 
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
index 2fc0d8779a..17af743fd8 100644
--- a/dts/tests/TestSuite_cryptodev_throughput.py
+++ b/dts/tests/TestSuite_cryptodev_throughput.py
@@ -32,7 +32,7 @@
 from api.test import verify
 from framework.context import get_ctx
 from framework.exception import SkippedTestException
-from framework.test_suite import BaseConfig, TestSuite, crypto_test
+from framework.test_suite import BaseConfig, TestSuite, perf_test
 from framework.testbed_model.virtual_device import VirtualDevice
 
 config_list: list[dict[str, int | float | str]] = [
@@ -145,7 +145,7 @@ def _verify_throughput(
             )
         return result_list
 
-    @crypto_test
+    @perf_test
     def aes_cbc(self) -> None:
         """aes_cbc test.
 
@@ -175,7 +175,7 @@ def aes_cbc(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
 
-    @crypto_test
+    @perf_test
     def aes_cbc_sha1(self) -> None:
         """aes_cbc_sha1 test.
 
@@ -210,7 +210,7 @@ def aes_cbc_sha1(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
 
-    @crypto_test
+    @perf_test
     def aes_cbc_sha2(self) -> None:
         """aes_cbc_sha2 test.
 
@@ -244,7 +244,7 @@ def aes_cbc_sha2(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
 
-    @crypto_test
+    @perf_test
     def aes_cbc_sha2_digest_16(self) -> None:
         """aes_cbc_sha2_digest_16 test.
 
@@ -278,7 +278,7 @@ def aes_cbc_sha2_digest_16(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
 
-    @crypto_test
+    @perf_test
     def aead_aes_gcm(self) -> None:
         """aead_aes_gcm test.
 
@@ -310,7 +310,7 @@ def aead_aes_gcm(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
 
-    @crypto_test
+    @perf_test
     def aes_docsisbpi(self) -> None:
         """aes_docsisbpi test.
 
@@ -340,7 +340,7 @@ def aes_docsisbpi(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
 
-    @crypto_test
+    @perf_test
     def sha1_hmac(self) -> None:
         """sha1_hmac test.
 
@@ -371,7 +371,7 @@ def sha1_hmac(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
 
-    @crypto_test
+    @perf_test
     def snow3g_uea2_snow3g_uia2(self) -> None:
         """snow3g_uea2_snow3g_uia2 test.
 
@@ -406,7 +406,7 @@ def snow3g_uea2_snow3g_uia2(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
 
-    @crypto_test
+    @perf_test
     def zuc_eea3_zuc_eia3(self) -> None:
         """zuc_eea3_zuc_eia3 test.
 
@@ -441,7 +441,7 @@ def zuc_eea3_zuc_eia3(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
 
-    @crypto_test
+    @perf_test
     def kasumi_f8_kasumi_f9(self) -> None:
         """kasumi_f8 kasumi_f9 test.
 
@@ -478,7 +478,7 @@ def kasumi_f8_kasumi_f9(self) -> None:
 
     # BEGIN VDEV TESTS
 
-    @crypto_test
+    @perf_test
     def aesni_mb_vdev(self) -> None:
         """aesni_mb virtual device test.
 
@@ -515,7 +515,7 @@ def aesni_mb_vdev(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
 
-    @crypto_test
+    @perf_test
     def aesni_gcm_vdev(self):
         """aesni_gcm virtual device test.
 
@@ -548,7 +548,7 @@ def aesni_gcm_vdev(self):
         for result in results:
             verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
 
-    @crypto_test
+    @perf_test
     def kasumi_vdev(self) -> None:
         """Kasmumi virtual device test.
 
@@ -584,7 +584,7 @@ def kasumi_vdev(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
 
-    @crypto_test
+    @perf_test
     def snow3g_vdev(self) -> None:
         """snow3g virtual device test.
 
@@ -621,7 +621,7 @@ def snow3g_vdev(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
 
-    @crypto_test
+    @perf_test
     def zuc_vdev(self) -> None:
         """Zuc virtual device test.
 
@@ -658,7 +658,7 @@ def zuc_vdev(self) -> None:
         for result in results:
             verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
 
-    @crypto_test
+    @perf_test
     def open_ssl_vdev(self) -> None:
         """open_ssl virtual device test.
 
-- 
2.55.0

