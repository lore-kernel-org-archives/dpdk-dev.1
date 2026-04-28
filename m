Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E16FF886D
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Apr 2026 18:26:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B35BD40664;
	Tue, 28 Apr 2026 20:26:27 +0200 (CEST)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49]) by mails.dpdk.org (Postfix) with ESMTP id D042D4064C
 for <dev@dpdk.org>; Tue, 28 Apr 2026 20:26:24 +0200 (CEST)
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-8a151012558so126764366d6.3
 for <dev@dpdk.org>; Tue, 28 Apr 2026 11:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1777400784; x=1778005584; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ccCcVN1M9iCHT6r94FFQTfK8iqF2N5Zovyx6jPWznQ=;
 b=Y/pBk3La46oAOSnT/cNPu3gkU/pFKsqwyz/K0+AHiuKGscTNkD4q0dJV75nBtAnm5D
 +gnMhGWghMPO6D64OszFcieOSr4PgCXBdABlrM0B49PflGQ2RFHp6DV9c7szpa3Uopi3
 yfbHgFzFkK5szbdLQ0FfGigZlu6qyTdW27wwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777400784; x=1778005584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2ccCcVN1M9iCHT6r94FFQTfK8iqF2N5Zovyx6jPWznQ=;
 b=FzNYPb6yDaSjvdSjuF6XObIlQ26xUlo4NAUbKqTEb8OIxGg/6HCdbAB1cVm4ozDqFm
 qkZ/7Wmp5htdtAbf6taqczef1fKurPbLYQbstTPpN+KOdp2OhGFwsRIGTD3gcGbNPjzg
 lHt6OF447Vs9YMFcKMB7UgeOJ1NAt/dPjGdcyX0A/w+rX0HzjquAdVASyAySx5p71xGe
 rE8Em8wFM8qAjtxexnlxq2VYPfF9TN2/Msv2pCTNPX9szZtHHDz9yY2asEMzzT+3xWwH
 +8mIEfPX1YAIy21n2B/SqeP4GKr4Lc1Et7i9pWLpay6YGgjmTOcNDaJZs7Z6xHBrz4SL
 7upw==
X-Gm-Message-State: AOJu0Yxn8GTzltth4+K+NZ2q6TVlZtRaiTJ7T6iw5Cwoa+A6X21QdZ5p
 tcNQBC740V9J7/5etTmpXFQpiRNE4Ej75y1wdU97JRMJtNRuNlgMWWV/7y7Os3JnfEXsRw/sC6l
 ruqmqtK+ru4t9KMukpnmlBvsfBtJWPLnOV0QPx0q2/bmU6W/m8UorEobEwRHZ8TuG5NctTD/+0c
 5vU6JulkgorIkKlQjMWJF/fNOR+Ws=
X-Gm-Gg: AeBDies9HUDHx3GBagDLdJy+lmZTL8nNcAOQHcmk6IhHweALNSXj3ravU0SDwtYX/DG
 hN9br/0Kx8rA3+127Rwbke5LpsiawmYEpPM8A6EIHGDrBS+v8I8E+3GvdOOcpxIKSJKFTDHm8BO
 mXi8+E8JHLi4+zJzgCAYSoYg4+tMFyh3E/p93h8JjV5OeZMg4L1f98KsiUkmNv9Eg3MKSuayFUt
 mrswQ5zyvAsaQR0fxM4ZdnbLUziTZnL3rksf3E4zc6NVCaAgXwzRMO3pvmt8RxmNf169fxy6LMa
 nZ5T2pwgxzBSUVRPuFRPg5nYo6F3lAK8mhx+NZi9D52CC88FR01P7ky4eEtRl8e2k2LrENED3oc
 pgVTeIeLNVoX7pdeYpHaTu7kEHlN9r0oSCxNp7P5Uqh50ZLRYs903CY411DoCtqY6KlRiPX2BOH
 4RCJ61l74HHedKLd0pm1zkhnd1nSARIPMu0fL2VeZzLvUwlm9MCMeJtAr14IhjVNQ4GYh/rg2gL
 zA=
X-Received: by 2002:a05:6214:428b:b0:8ae:61bb:95e3 with SMTP id
 6a1803df08f44-8b3e3091e21mr72960486d6.36.1777400783515; 
 Tue, 28 Apr 2026 11:26:23 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3ee9e75a5sm603946d6.20.2026.04.28.11.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 11:26:22 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: lylavoie@iol.unh.edu, ahassick@iol.unh.edu, knimoji@iol.unh.edu,
 dmarx@iol.unh.edu, Andrew Bailey <abailey@iol.unh.edu>
Subject: [RFC PATCH 2/2] dts: add latency coverage for cryptodev testing
Date: Tue, 28 Apr 2026 14:15:01 -0400
Message-ID: <20260428181501.72434-2-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260428181501.72434-1-abailey@iol.unh.edu>
References: <20260428181501.72434-1-abailey@iol.unh.edu>
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

Currently, next DTS only has cryptodev testing coverage for throughput
metrics. This patch adds a test suite to include latency testing for
crypto devices.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 .../dts/tests.TestSuite_cryptodev_latency.rst |   8 +
 dts/tests/TestSuite_cryptodev_latency.py      | 356 ++++++++++++++++++
 2 files changed, 364 insertions(+)
 create mode 100644 doc/api/dts/tests.TestSuite_cryptodev_latency.rst
 create mode 100644 dts/tests/TestSuite_cryptodev_latency.py

diff --git a/doc/api/dts/tests.TestSuite_cryptodev_latency.rst b/doc/api/dts/tests.TestSuite_cryptodev_latency.rst
new file mode 100644
index 0000000000..1bf4a0f4b0
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_cryptodev_latency.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+cryptodev_latency Test Suite
+============================
+
+.. automodule:: tests.TestSuite_cryptodev_latency
+   :members:
+   :show-inheritance:
diff --git a/dts/tests/TestSuite_cryptodev_latency.py b/dts/tests/TestSuite_cryptodev_latency.py
new file mode 100644
index 0000000000..39c9ee02c4
--- /dev/null
+++ b/dts/tests/TestSuite_cryptodev_latency.py
@@ -0,0 +1,356 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 University of New Hampshire
+
+"""DPDK cryptodev performance test suite.
+
+The main goal of this test suite is to utilize the dpdk-test-cryptodev application to gather
+performance metrics for various cryptographic operations supported by DPDK cryptodev-pmd.
+It will then compare the results against a predefined baseline given in the test_config file to
+ensure performance standards are met.
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
+config_list: list[dict[str, int | float | str]] = [
+    {"buff_size": 64, "avg_cycles": 9999.00, "avg_time_us": 9999.0},
+    {"buff_size": 512, "avg_cycles": 9999.00, "avg_time_us": 9999.0},
+    {"buff_size": 2048, "avg_cycles": 9999.00, "avg_time_us": 9999.0},
+]
+
+TOTAL_OPS = 10_000_000
+
+
+class Config(BaseConfig):
+    """Performance test metrics.
+
+    Attributes:
+        delta_tolerance: The allowed tolerance below a given baseline.
+        latency_test_parameters: The test parameters to use in the test suite.
+    """
+
+    delta_tolerance: float = 0.05
+
+    latency_test_parameters: dict[str, list[dict[str, int | float | str]]] = {
+        "aes_gcm": config_list,
+        "aes_cbc_sha1_hmac": config_list,
+        "aes_cbc": config_list,
+        "vdev_aesni_gcm": config_list,
+        "vdev_aesni_mb": config_list,
+        "vdev_aesni_mb_cipher_then_auth": config_list,
+    }
+
+
+@requires_link_topology(LinkTopology.NO_LINK)
+class TestCryptodevLatency(TestSuite):
+    """DPDK Crypto Device Testing Suite."""
+
+    config: Config
+
+    def set_up_suite(self) -> None:
+        """Set up the test suite."""
+        self.latency_test_parameters: dict[str, list[dict[str, int | float | str]]] = (
+            self.config.latency_test_parameters
+        )
+        self.delta_tolerance: float = self.config.delta_tolerance
+        self.device_type: DeviceType | None = get_device_from_str(
+            str(get_ctx().sut_node.crypto_device_type)
+        )
+        self.buffer_sizes = {}
+
+        for k, v in self.latency_test_parameters.items():
+            self.buffer_sizes[k] = ListWrapper([int(run["buff_size"]) for run in v])
+
+    def _print_stats(self, test_vals: list[dict[str, int | float | str]]) -> None:
+        element_len = len("Avg Time us Target")
+        border_len = (element_len + 1) * (len(test_vals[0]))
+
+        print(f"{'Latency Results'.center(border_len)}\n{'=' * border_len}")
+        for k, v in test_vals[0].items():
+            print(f"|{k.title():<{element_len}}", end="")
+        print(f"|\n{'='*border_len}")
+
+        for test_val in test_vals:
+            for k, v in test_val.items():
+                print(f"|{v:<{element_len}}", end="")
+            print(f"|\n{'='*border_len}")
+
+    def _verify_latency(
+        self,
+        results: list[CryptodevResults],
+        key: str,
+    ) -> list[dict[str, int | float | str]]:
+        result_list: list[dict[str, int | float | str]] = []
+
+        for result in results:
+            # get the corresponding baseline for the current buffer size
+            parameters: dict[str, int | float | str] = list(
+                filter(
+                    lambda x: x["buff_size"] == result.buffer_size,
+                    self.latency_test_parameters[key],
+                )
+            )[0]
+            test_result = True
+            expected_cycles = parameters["avg_cycles"]
+            expected_time_us = parameters["avg_time_us"]
+            measured_time_delta = abs(
+                (getattr(result, "avg_time_us") - expected_time_us) / expected_time_us
+            )
+            measured_cycles_delta = abs(
+                (getattr(result, "avg_cycles") - expected_cycles) / expected_cycles
+            )
+
+            # result did not meet the given cycles parameter, check if within delta.
+            if getattr(result, "avg_cycles") > expected_cycles:
+                if self.delta_tolerance < measured_cycles_delta:
+                    test_result = False
+            # result did not meet the given time parameter, check if within delta.
+            if getattr(result, "avg_time_us") > expected_time_us:
+                if self.delta_tolerance < measured_time_delta:
+                    test_result = False
+            result_list.append(
+                {
+                    "Buffer Size": parameters["buff_size"],
+                    "delta tolerance": self.delta_tolerance,
+                    "cycles delta": round(measured_cycles_delta, 5),
+                    "Avg cycles": round(getattr(result, "avg_cycles"), 5),
+                    "Avg cycles target": expected_cycles,
+                    "time delta": round(measured_time_delta, 5),
+                    "Avg time us": round(getattr(result, "avg_time_us"), 5),
+                    "Avg time us target": expected_time_us,
+                    "passed": "PASS" if test_result else "FAIL",
+                }
+            )
+        return result_list
+
+    @crypto_test
+    def aes_gcm(self) -> None:
+        """aes_gcm latency test.
+
+        Steps:
+            * Create a cryptodev instance with provided device type and buffer sizes.
+        Verify:
+            * The latency is below or within delta of provided baseline.
+
+        Raises:
+            SkippedTestException: When configuration is not provided.
+        """
+        if "aes_gcm" not in self.latency_test_parameters:
+            skip("test not configured")
+        app = Cryptodev(
+            ptest=TestType.latency,
+            burst_sz=32,
+            buffer_sz=ListWrapper(self.buffer_sizes["aes_gcm"]),
+            devtype=self.device_type,
+            optype=OperationType.aead,
+            aead_algo=AeadAlgName.aes_gcm,
+            aead_op=EncryptDecryptSwitch.encrypt,
+            aead_key_sz=16,
+            aead_iv_sz=12,
+            aead_aad_sz=16,
+            digest_sz=16,
+            total_ops=TOTAL_OPS,
+        )
+        results = self._verify_latency(app.run_app(), "aes_gcm")
+        self._print_stats(results)
+        for result in results:
+            verify(
+                result["passed"] == "PASS",
+                "latency fell more than the delta tolerance below baseline",
+            )
+
+    @crypto_test
+    def aes_cbc_sha1_hmac(self) -> None:
+        """aes_cbc_sha1_hmac latency test.
+
+        Steps:
+            * Create a cryptodev instance with provided device type and buffer sizes.
+        Verify:
+            * The latency is below or within delta of provided baseline.
+
+        Raises:
+            SkippedTestException: When configuration is not provided.
+        """
+        if "aes_cbc_sha1_hmac" not in self.latency_test_parameters:
+            skip("test not configured")
+        app = Cryptodev(
+            ptest=TestType.latency,
+            burst_sz=32,
+            buffer_sz=ListWrapper(self.buffer_sizes["aes_cbc_sha1_hmac"]),
+            devtype=self.device_type,
+            optype=OperationType.cipher_then_auth,
+            cipher_algo=CipherAlgorithm.aes_cbc,
+            cipher_op=EncryptDecryptSwitch.encrypt,
+            cipher_key_sz=16,
+            auth_algo=AuthenticationAlgorithm.sha1_hmac,
+            auth_op=AuthenticationOpMode.generate,
+            auth_key_sz=64,
+            digest_sz=12,
+            total_ops=TOTAL_OPS,
+        )
+        results = self._verify_latency(app.run_app(), "aes_cbc_sha1_hmac")
+        self._print_stats(results)
+        for result in results:
+            verify(
+                result["passed"] == "PASS",
+                "latency fell more than the delta tolerance below baseline",
+            )
+
+    @crypto_test
+    def aes_cbc(self) -> None:
+        """aes_cbc latency test.
+
+        Steps:
+            * Create a cryptodev instance with provided device type and buffer sizes.
+        Verify:
+            * The latency is below or within delta of provided baseline.
+
+        Raises:
+            SkippedTestException: When configuration is not provided.
+        """
+        if "aes_cbc" not in self.latency_test_parameters:
+            skip("test not configured")
+        app = Cryptodev(
+            ptest=TestType.latency,
+            burst_sz=32,
+            buffer_sz=ListWrapper(self.buffer_sizes["aes_cbc"]),
+            devtype=self.device_type,
+            optype=OperationType.cipher_only,
+            cipher_algo=CipherAlgorithm.aes_cbc,
+            cipher_op=EncryptDecryptSwitch.encrypt,
+            cipher_key_sz=16,
+            cipher_iv_sz=16,
+            total_ops=TOTAL_OPS,
+        )
+        results = self._verify_latency(app.run_app(), "aes_cbc")
+        self._print_stats(results)
+        for result in results:
+            verify(
+                result["passed"] == "PASS",
+                "latency fell more than the delta tolerance below baseline",
+            )
+
+    @crypto_test
+    def vdev_aesni_gcm(self) -> None:
+        """aesni_gcm virtual device latency test.
+
+        Steps:
+            * Create a cryptodev instance with provided device type and buffer sizes.
+        Verify:
+            * The latency is below or within delta of provided baseline.
+
+        Raises:
+            SkippedTestException: When configuration is not provided.
+        """
+        if "vdev_aesni_gcm" not in self.latency_test_parameters:
+            skip("test not configured")
+        app = Cryptodev(
+            ptest=TestType.latency,
+            vdevs=[VirtualDevice("crypto_aesni_gcm0")],
+            burst_sz=32,
+            buffer_sz=self.buffer_sizes["vdev_aesni_gcm"],
+            devtype=DeviceType.crypto_aesni_gcm,
+            optype=OperationType.aead,
+            aead_op=EncryptDecryptSwitch.encrypt,
+            aead_key_sz=16,
+            aead_iv_sz=12,
+            aead_aad_sz=16,
+            digest_sz=16,
+            total_ops=TOTAL_OPS,
+        )
+        results = self._verify_latency(app.run_app(), "vdev_aesni_gcm")
+        self._print_stats(results)
+        for result in results:
+            verify(result["passed"] == "PASS", "latency fell more than the delta tolerance")
+
+    @crypto_test
+    def vdev_aesni_mb(self) -> None:
+        """aesni_mb vdev latency test.
+
+        Steps:
+            * Create a cryptodev instance with provided device type and buffer sizes.
+        Verify:
+            * The latency is below or within delta of provided baseline.
+
+        Raises:
+            SkippedTestException: When configuration is not provided.
+        """
+        if "vdev_aesni_mb" not in self.latency_test_parameters:
+            skip("test not configured")
+        app = Cryptodev(
+            ptest=TestType.latency,
+            vdevs=[VirtualDevice("crypto_aesni_mb0")],
+            burst_sz=32,
+            buffer_sz=self.buffer_sizes["vdev_aesni_mb"],
+            devtype=DeviceType.crypto_aesni_mb,
+            optype=OperationType.cipher_only,
+            cipher_algo=CipherAlgorithm.aes_cbc,
+            cipher_op=EncryptDecryptSwitch.encrypt,
+            cipher_key_sz=16,
+            cipher_iv_sz=16,
+            total_ops=TOTAL_OPS,
+        )
+        results = self._verify_latency(app.run_app(), "vdev_aesni_mb")
+        self._print_stats(results)
+        for result in results:
+            verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
+
+    @crypto_test
+    def vdev_aesni_mb_cipher_then_auth(self) -> None:
+        """aesni_mb vdev cipher and auth latency test.
+
+        Steps:
+            * Create a cryptodev instance with provided device type and buffer sizes.
+        Verify:
+            * The latency is below or within delta of provided baseline.
+
+        Raises:
+            SkippedTestException: When configuration is not provided.
+        """
+        if "vdev_aesni_mb" not in self.latency_test_parameters:
+            skip("test not configured")
+        app = Cryptodev(
+            ptest=TestType.latency,
+            vdevs=[VirtualDevice("crypto_aesni_mb0")],
+            burst_sz=32,
+            buffer_sz=self.buffer_sizes["vdev_aesni_mb"],
+            devtype=DeviceType.crypto_aesni_mb,
+            optype=OperationType.cipher_then_auth,
+            cipher_algo=CipherAlgorithm.aes_cbc,
+            cipher_op=EncryptDecryptSwitch.encrypt,
+            cipher_key_sz=16,
+            auth_algo=AuthenticationAlgorithm.sha1_hmac,
+            auth_op=AuthenticationOpMode.generate,
+            auth_key_sz=64,
+            digest_sz=12,
+            total_ops=TOTAL_OPS,
+        )
+        results = self._verify_latency(app.run_app(), "vdev_aesni_mb_cipher_then_auth")
+        self._print_stats(results)
+        for result in results:
+            verify(
+                result["passed"] == "PASS",
+                "latency fell more than the delta tolerance below baseline",
+            )
-- 
2.50.1

