Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381E6FF885A
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Apr 2026 19:36:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D68C40651;
	Tue, 28 Apr 2026 21:36:02 +0200 (CEST)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by mails.dpdk.org (Postfix) with ESMTP id 3128040650
 for <dev@dpdk.org>; Tue, 28 Apr 2026 21:36:01 +0200 (CEST)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-8d65f4073bfso1584762285a.3
 for <dev@dpdk.org>; Tue, 28 Apr 2026 12:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1777404960; x=1778009760; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9yyQ7OrZHY1ga/03Zs49hBhwhxHL0tMI+nqlKc9PJTg=;
 b=ISPJbmqg0Yj62Gke+kHKoq+JQk6EXva0gXtX/atFoGZZKm5NfB4bBpT6Ai15Frh8yz
 yAIfXbbZqQDMR/dFYyx1c0BGipsk85nPi0ob/1w4HYsOPCV4upDRnRPeAh7syPj1nDr7
 AcmFOtIwu5UAcEm1JOiRLxUqktBAfzsTQPwyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777404960; x=1778009760;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9yyQ7OrZHY1ga/03Zs49hBhwhxHL0tMI+nqlKc9PJTg=;
 b=F3PrXUsGVCtGXnVSwHQT4LHEptvGMvu9XsyWBI8gxjDwiWdIoROk8VeaXjPUw6SgZ9
 E9RccMsnoye7UKsUgvhyVwQOhmEhmA3aTc3qzjSx5McL5SeGGe1eBmYptXQX/QdLLqxN
 UsiZLJhMeEzZ3ta86RaZT+vGRyQiX7aEEOonTqyMn55GyxwwPHPdclB9CVx70+PmF5u0
 fxIg9lVSQAaO79ilf8zaOZNGG/dM310JCtOFVTeHO1EIcEO//OIP4nxwr5en7ni+SafP
 mrQHokiS10Z6ynVy2d8CQWxrhRnkD5EvYtGViyPFIZR4jjVQCIPa4U26jx/vPCWSdTBk
 ULzA==
X-Gm-Message-State: AOJu0YzdYUuAaS84HZOPkdLoyx7jTwC+fYZwKSRusyzeFrTNcDvUTCO8
 r7DiFe/vnuwud1xC5FqZ9MvZaJI0daqMT0grVdCh946DZQvvE0WeLeNAc8TmUtaNiSE7wRXwPGX
 OjTgwM0vr+TCOQNNdynsXdIgmzcyOVeHoVDnxZIKjhiq0mq+/MRDe6pCoVKolB2LeWnEU4z/okR
 TsGINtFuk8eUbuQjoxTXIrORfFanY=
X-Gm-Gg: AeBDieuM0/DXK7I5J+NmZ2Mn63Qbp3X66IiMT5CN2s2XjdwaPyBJ3Dx3fJHcA1VAuaR
 MuOIqmZRYufbVro0ki6jIzLBu/A+L5dGUwycKS4/2cOa6u994b2UHb/yenPzXaUMzig7nDevsSn
 MjLk+cwuS4mXhoF88S9HyM8ewJbbyWfKtFMKweRH8aLbG+qs8Moy8pK0LnZvoe/HoLR3UM7h596
 fsTAVkdKSWHTuGYXvfD3Q+JhEHoGmifKAhUqgG2EUteFv4ZfY/zFbV2wq+Pq+H0vanEo6y9s6ra
 1SDr6O5+VwTr2YKWaiqlyvGViS+ZU3Y0yKhHH0BDiO7Ks9XXmGcSSBiCPaSZdcIOVNWLXGzTwBj
 dN9dKCdBy9gNbpRZkW3gxeG3zlBiJJJSEW/88/ow/sbeZAWolcKHrTy9Bmqf2ldvD3PYrNiFMTy
 DB7/6nrqYk8pvVp6v5cK3ot39syp4zzi+kVz7zgdaQzy3UVUVGKxgk4H27yYDBWY//gTB5h0NIh
 D8=
X-Received: by 2002:a05:620a:46a5:b0:8ed:d906:a8ff with SMTP id
 af79cd13be357-8f7d7242f38mr619514185a.14.1777404959909; 
 Tue, 28 Apr 2026 12:35:59 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3ee9e75a5sm1965586d6.20.2026.04.28.12.35.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 12:35:59 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: lylavoie@iol.unh.edu, knimoji@iol.unh.edu, ahassick@iol.unh.edu,
 dmarx@iol.unh.edu, Andrew Bailey <abailey@iol.unh.edu>
Subject: [RFC] dts: add verify coverage for cryptodev testing
Date: Tue, 28 Apr 2026 15:35:41 -0400
Message-ID: <20260428193541.79005-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
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

Currently, next-DTS only covers throughput testing through the
dpdk-test-crypto application. This series adds coverage for the verify
option to next DTS to allow functional testing for various algorithms of
crypto devices and virtual devices.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/tests/TestSuite_cryptodev_verify.py | 228 ++++++++++++++++++++++++
 tests.TestSuite_cryptodev_verify.rst    |   8 +
 2 files changed, 236 insertions(+)
 create mode 100644 dts/tests/TestSuite_cryptodev_verify.py
 create mode 100644 tests.TestSuite_cryptodev_verify.rst

diff --git a/dts/tests/TestSuite_cryptodev_verify.py b/dts/tests/TestSuite_cryptodev_verify.py
new file mode 100644
index 0000000000..a3f797b225
--- /dev/null
+++ b/dts/tests/TestSuite_cryptodev_verify.py
@@ -0,0 +1,228 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 University of New Hampshire
+
+"""DPDK cryptodev verify test suite.
+
+The main goal of this test suite is to utilize the verify mode of dpdk-test-crypto application
+to ensure functional correctness for various cryptographic operations supported by DPDK
+cryptodev-pmd.
+"""
+
+from api.capabilities import (
+    LinkTopology,
+    requires_link_topology,
+)
+from api.cryptodev import Cryptodev
+from api.cryptodev.config import (
+    AeadAlgName,
+    AuthenticationAlgorithm,
+    AuthenticationOpMode,
+    CipherAlgorithm,
+    DeviceType,
+    EncryptDecryptSwitch,
+    ListWrapper,
+    OperationType,
+    TestType,
+    get_device_from_str,
+)
+from api.cryptodev.types import (
+    CryptodevResults,
+)
+from api.test import skip, verify
+from framework.context import get_ctx
+from framework.test_suite import BaseConfig, TestSuite, crypto_test
+from framework.testbed_model.virtual_device import VirtualDevice
+
+TOTAL_OPS = 10_000_000
+TEST_FILE = "/path/to/test/vector/file.data"
+config_list = [64, 512, 1024, 2048]
+
+
+class Config(BaseConfig):
+    """Performance test metrics.
+
+    Attributes:
+        delta_tolerance: The allowed tolerance below a given baseline.
+        throughput_test_parameters: The test parameters to use in the test suite.
+    """
+
+    delta_tolerance: float = 0.05
+
+    verify_test_parameters: dict[str, list[int]] = {
+        "aesni_mb_vdev": config_list,
+        "openssl_vdev": config_list,
+        "sha1_hmac_buff_32": config_list,
+    }
+
+
+@requires_link_topology(LinkTopology.NO_LINK)
+class TestCryptodevVerify(TestSuite):
+    """DPDK Crypto Device Testing Suite."""
+
+    config: Config
+
+    def set_up_suite(self) -> None:
+        """Set up the test suite."""
+        self.verify_test_parameters: dict[str, list[int]] = self.config.verify_test_parameters
+        self.delta_tolerance: float = self.config.delta_tolerance
+        self.device_type: DeviceType | None = get_device_from_str(
+            str(get_ctx().sut_node.crypto_device_type)
+        )
+        self.buffer_sizes = {}
+
+        for k, v in self.verify_test_parameters.items():
+            self.buffer_sizes[k] = ListWrapper(v)
+
+    def _print_stats(self, test_vals: list[dict[str, int | float]]) -> None:
+        element_len = len("Delta Tolerance")
+        border_len = (element_len + 1) * (len(test_vals[0]))
+
+        print(f"{'Verify Results'.center(border_len)}\n{'=' * border_len}")
+        for k, v in test_vals[0].items():
+            print(f"|{k.title():<{element_len}}", end="")
+        print(f"|\n{'='*border_len}")
+
+        for test_val in test_vals:
+            for k, v in test_val.items():
+                print(f"|{v:<{element_len}}", end="")
+            print(f"|\n{'='*border_len}")
+
+    def _verify_output(
+        self,
+        results: list[CryptodevResults],
+        key: str,
+    ) -> list[dict[str, int | float]]:
+        result_list: list[dict[str, int | float]] = []
+        if key not in self.verify_test_parameters:
+            skip(f"{key} test not configured")
+
+        results_list = []
+        passed = True
+        for result in results:
+            if getattr(result, "failed_enqueue") / TOTAL_OPS > self.delta_tolerance:
+                passed = False
+            if getattr(result, "failed_dequeue") / TOTAL_OPS > self.delta_tolerance:
+                passed = False
+            if getattr(result, "failed_ops") / TOTAL_OPS > self.delta_tolerance:
+                passed = False
+            results_list.append(
+                {
+                    "Failed Enqueue": getattr(result, "failed_enqueue"),
+                    "Failed Dequeue": getattr(result, "failed_dequeue"),
+                    "Failed Operations": getattr(result, "failed_ops"),
+                    "Delta Tolerance": self.delta_tolerance,
+                    "Passed": passed,
+                }
+            )
+        return result_list
+
+    @crypto_test
+    def aesni_mb_vdev(self) -> None:
+        """aesni_mb_vdev test.
+
+        Steps:
+            * Create a cryptodev instance with aesni_mb virtual device and provided buffer sizes.
+        Verify:
+            * The aes_cbc cipher and sha1_hmac authentication algorithms are working as expected
+                with the dpdk-test-crypto application.
+        """
+        if "aesni_mb_vdev" not in self.verify_test_parameters:
+            skip("test not configured")
+        app = Cryptodev(
+            vdevs=[VirtualDevice("crypto_aesni_mb0")],
+            ptest=TestType.verify,
+            test_file=TEST_FILE,
+            test_name="sha1_hmac_buff_32",
+            devtype=DeviceType.crypto_aesni_mb,
+            optype=OperationType.cipher_then_auth,
+            cipher_algo=CipherAlgorithm.aes_cbc,
+            cipher_op=EncryptDecryptSwitch.encrypt,
+            cipher_key_sz=32,
+            cipher_iv_sz=16,
+            auth_algo=AuthenticationAlgorithm.sha1_hmac,
+            auth_op=AuthenticationOpMode.generate,
+            auth_key_sz=64,
+            digest_sz=12,
+            burst_sz=32,
+            total_ops=TOTAL_OPS,
+            buffer_sz=self.buffer_sizes["aesni_mb_vdev"],
+        )
+        results = self._verify_output(app.run_app(), "aesni_mb_vdev")
+        self._print_stats(results)
+        for result in results:
+            verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
+
+    @crypto_test
+    def openssl_vdev(self) -> None:
+        """Openssl vdev test.
+
+        Steps:
+            * Create a cryptodev instance with openssl virtual device and provided buffer sizes.
+        Verify:
+            * The aes_cbc cipher and sha1_hmac authentication algorithms are working as expected
+                with the dpdk-test-crypto application.
+
+        Raises:
+            SkippedTestException: When configuration is not provided.
+        """
+        if "openssl_vdev" not in self.verify_test_parameters:
+            skip("test not configured")
+        app = Cryptodev(
+            vdevs=[VirtualDevice("crypto_openssl0")],
+            ptest=TestType.verify,
+            test_file=TEST_FILE,
+            test_name="aes_gcm_buff_32",
+            devtype=DeviceType.crypto_openssl,
+            optype=OperationType.aead,
+            aead_algo=AeadAlgName.aes_gcm,
+            aead_op=EncryptDecryptSwitch.encrypt,
+            aead_key_sz=16,
+            aead_aad_sz=16,
+            aead_iv_sz=12,
+            digest_sz=16,
+            burst_sz=32,
+            buffer_sz=self.buffer_sizes["aesni_mb"],
+            total_ops=TOTAL_OPS,
+        )
+        results = self._verify_output(app.run_app(), "openssl_vdev")
+        self._print_stats(results)
+        for result in results:
+            verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
+
+    @crypto_test
+    def sha1_hmac_buff_32(self) -> None:
+        """aes_cbc test.
+
+        Steps:
+            * Create a cryptodev instance with provided device type and buffer sizes.
+        Verify:
+            * The aes_cbc cipher and sha1_hmac authentication algorithms are working as expected
+                with the dpdk-test-crypto application.
+
+        Raises:
+            SkippedTestException: When configuration is not provided.
+        """
+        if "sha1_hmac_buff_32" not in self.verify_test_parameters:
+            skip("test not configured")
+        app = Cryptodev(
+            ptest=TestType.verify,
+            test_file=TEST_FILE,
+            test_name="sha1_hmac_buff_32",
+            devtype=self.device_type,
+            optype=OperationType.aead,
+            cipher_algo=CipherAlgorithm.aes_cbc,
+            cipher_op=EncryptDecryptSwitch.encrypt,
+            cipher_key_sz=32,
+            cipher_iv_sz=16,
+            auth_algo=AuthenticationAlgorithm.sha1_hmac,
+            auth_op=AuthenticationOpMode.generate,
+            auth_key_sz=64,
+            digest_sz=20,
+            burst_sz=32,
+            buffer_sz=self.buffer_sizes["sha1_hmac_buff_32"],
+            total_ops=TOTAL_OPS,
+        )
+        results = self._verify_output(app.run_app(), "sha1_hmac_buff_32")
+        self._print_stats(results)
+        for result in results:
+            verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
diff --git a/tests.TestSuite_cryptodev_verify.rst b/tests.TestSuite_cryptodev_verify.rst
new file mode 100644
index 0000000000..d0a305a7d5
--- /dev/null
+++ b/tests.TestSuite_cryptodev_verify.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+cryptodev_verify Test Suite
+===========================
+
+.. automodule:: tests.TestSuite_cryptodev_verify
+   :members:
+   :show-inheritance:
--
2.50.1

