Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A57D6CFA7
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 21:44:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 847E340698;
	Thu, 22 Jan 2026 22:44:37 +0100 (CET)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by mails.dpdk.org (Postfix) with ESMTP id 97F4B4067B
 for <dev@dpdk.org>; Thu, 22 Jan 2026 22:44:33 +0100 (CET)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-8c0f13e4424so140883685a.1
 for <dev@dpdk.org>; Thu, 22 Jan 2026 13:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1769118273; x=1769723073; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oP9dZ69849irdNd821FMqYnTgkL+jWx+MWZy5vVnEUw=;
 b=TZLp1HwhTfzSYOEX7BR9ZHMbzRrR+/+DfLlgIKyJcamLIBMjm44eN4YDj4pWcyK7ot
 2cLzUJlRldNalC7xS6ZX8wqtwGWY2kuaWtlc3/WpyBc3Sj63BJu4A2sfLdHHkt/OVjDn
 p1ONlQjWv6wuY+uTNkW2qoYFJrdb5HXsoQpSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769118273; x=1769723073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oP9dZ69849irdNd821FMqYnTgkL+jWx+MWZy5vVnEUw=;
 b=fcy9qHknDZ49viOfxMXh+gBIPu6FtaYc8YOJKFnkw9Ey+01BORrP9s7uXSDrcLfoTq
 yk5HJ+Sv1XalXH8tBTJnOb4sMLC4rYoaFSmPK1t9gBDpph2N+0LKeyC52MjPLnVrOqjg
 4L8E5cErUsIPxfuJjBy8JIFthPNCdzWU5BLGeMewdZZdWqSty/GtMxyzUj17UcRQRMfF
 PsJw5qthaDtT71kyHWYjfzkV/87GUVeFGeuqswY5kJZsKtU+DPMhYyJXflAqcBvFSHtF
 4AejiZYXu+CpsSv6VB/Vse8STpEjKo/+AOB3Fih4c5OGAqvgVFSXecXX4uq64nAVaR5h
 Q1QQ==
X-Gm-Message-State: AOJu0YyOpyi5smvB38AUJQr3sl8a2Yo9HU55rfsdS8NUvBX/p82rsiNd
 aPQcUJBC3CKjGxgBMYQ9UTy0/v0AdOwtLr8SNlWL3xoCqsMi3N+6XKBLnfvwXAgHm3w=
X-Gm-Gg: AZuq6aKwq84vLeGMcdKRl6u9uL4P+z0ONhZqLMtkfIh+9Cii+HCOICnmUCqXgukf/82
 zxbniWKD+DPLbAZzZAC9Q8oCjXszTyqlfHPEoRqOzv/wGW/Xqg1Iu56ekvVMtrLZT71EDlyBtm3
 UmqlCLKL67QLcIdAzcpSUcVk63m1xWdxg4c42GuhX7roajBk8sdNogX0I0K6ZvN/RSY/2i0KXaD
 w/YGPo2FgeYabwOQbOk2+vgDtTfDUqQo2zE7ti6SzYwlkcBPKcz6qVMPV+1prI2KAuip4Oe3Tl7
 /H6T49RnYPsE0ighwA8BaOSeEdXP8s0cZfCHDFIKpvtGMdv74g5hguPLM+CZKXmB53oicmemPRg
 7OmHj5UQwAORF/Ba7BGA+/rg1kXC/1vvGHymmNGqmhg+c7z0VMJBVw1pyADCos3ZyGV0ifKVLIw
 FwXUUCzuMdqj8NR5YfBwe/b0rEBiMSoF6O4wBiU9b/AkHv78RYI6RK/n4+B0QcfFc=
X-Received: by 2002:a05:620a:1725:b0:8b2:6ac5:bcb1 with SMTP id
 af79cd13be357-8c6e2da9bd0mr125824885a.31.1769118272829; 
 Thu, 22 Jan 2026 13:44:32 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c6e3870c48sm28720785a.51.2026.01.22.13.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 13:44:32 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com,
	probb@iol.unh.edu,
	dmarx@iol.unh.edu
Cc: dev@dpdk.org,
	gakhil@marvell.com,
	Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v1 3/5] dts: add cryptodev throughput test suite
Date: Thu, 22 Jan 2026 16:44:22 -0500
Message-ID: <20260122214424.322422-4-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260122214424.322422-1-abailey@iol.unh.edu>
References: <20260122214424.322422-1-abailey@iol.unh.edu>
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

Add cryptodev performance test suite. This test covers throughput
performance metrics of various crypto devices using the
dpdk-test-crypto-perf application. The results of this application will
be compared against user supplied performance metrics and fail if signs
of regression are apparent.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 .../tests.TestSuite_cryptodev_throughput.rst  |   8 +
 dts/tests/TestSuite_cryptodev_throughput.py   | 386 ++++++++++++++++++
 2 files changed, 394 insertions(+)
 create mode 100644 doc/api/dts/tests.TestSuite_cryptodev_throughput.rst
 create mode 100644 dts/tests/TestSuite_cryptodev_throughput.py

diff --git a/doc/api/dts/tests.TestSuite_cryptodev_throughput.rst b/doc/api/dts/tests.TestSuite_cryptodev_throughput.rst
new file mode 100644
index 0000000000..5df5e7547e
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_cryptodev_throughput.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+cryptodev_throughput Test Suite
+===============================
+
+.. automodule:: tests.TestSuite_cryptodev_throughput
+   :members:
+   :show-inheritance:
diff --git a/dts/tests/TestSuite_cryptodev_throughput.py b/dts/tests/TestSuite_cryptodev_throughput.py
new file mode 100644
index 0000000000..b75b41e532
--- /dev/null
+++ b/dts/tests/TestSuite_cryptodev_throughput.py
@@ -0,0 +1,386 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 University of New Hampshire
+
+"""DPDK cryptodev performance test suite.
+
+The main goal of this testsuite is to utilize the dpdk-test-cryptodev application to gather
+performance metrics for various cryptographic operations supported by DPDK cryptodev-pmd.
+It will then compare the results against predefined baseline defined in the test_config file to
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
+)
+from api.cryptodev.types import (
+    CryptodevResults,
+)
+from api.test import verify
+from framework.test_suite import BaseConfig, TestSuite, func_test
+
+
+class Config(BaseConfig):
+    """Performance test metrics."""
+
+    common_params: dict[str, int | float] = {
+        "Gbps Delta": 0.05,
+    }
+    throughput_test_parameters: list[dict[str, int | float | str]] = [
+        {
+            **common_params,
+            "buff_size": 64,
+            "mops": 9.85,
+            "gbps": 2.49,
+        },
+        {
+            **common_params,
+            "buff_size": 128,
+            "mops": 4.83,
+            "gbps": 4.95,
+        },
+        {
+            **common_params,
+            "buff_size": 256,
+            "mops": 4.77,
+            "gbps": 9.76,
+        },
+        {
+            **common_params,
+            "buff_size": 512,
+            "mops": 4.52,
+            "gbps": 18.52,
+        },
+        {
+            **common_params,
+            "buff_size": 1048,
+            "mops": 3.77,
+            "gbps": 30.87,
+        },
+        {
+            **common_params,
+            "buff_size": 2048,
+            "mops": 2.49,
+            "gbps": 40.86,
+        },
+    ]
+
+
+@requires_link_topology(LinkTopology.NO_LINK)
+class TestCryptodevThroughput(TestSuite):
+    """DPDK Crypto Device Testing Suite."""
+
+    config: Config
+    unsupported_cryptodevs: list[DeviceType] = []
+
+    def set_up_suite(self) -> None:
+        """Set up the test suite.
+
+        Setup: Retrieve application parameters from the configuration.
+        """
+        self.throughput_test_parameters: list[dict[str, int | float | str]] = (
+            self.config.throughput_test_parameters
+        )
+        self.buffer_sizes = ListWrapper(
+            [int(run["buff_size"]) for run in self.throughput_test_parameters]
+        )
+
+    def _print_stats(self, test_vals) -> None:
+        element_len = len("Gbps Target")
+        border_len = (element_len + 1) * (len(test_vals[0].items()))
+        print(f"{'Throughput Results'.center(border_len)}")
+        print("=" * border_len)
+        for k, v in test_vals[0].items():
+            print(f"|{k.title():<{element_len}}", end="")
+        print(f"|\n{'='*border_len}")
+        for test_val in test_vals:
+            for k, v in test_val.items():
+                print(f"|{v:<{element_len}}", end="")
+            print(f"|\n{'='*border_len}")
+
+    def _verify_throughput(
+        self, results: list[CryptodevResults]
+    ) -> list[dict[str, int | float | str]]:
+        result_list = []
+        for result in results:
+            result_dict = {}
+            parameters = list(
+                filter(
+                    lambda x: x["buff_size"] == result.buffer_size,
+                    self.throughput_test_parameters,
+                )
+            )[0]
+            test_result = True
+            for key, target_val in parameters.items():
+                if key == "buff_size" or key == "delta":
+                    result_dict[key] = target_val
+                    continue
+                if target_val > getattr(result, key):
+                    delta = round((1 - (getattr(result, key) / target_val)), 5)
+                    if delta > parameters["delta"]:
+                        test_result = False
+                else:
+                    delta = round((1 - target_val / getattr(result, key)), 5)
+                result_dict[key] = getattr(result, key)
+                result_dict[f"{key} target"] = target_val
+                result_dict[f"{key} delta"] = delta
+            result_dict["passed"] = "PASS" if test_result else "FAIL"
+            result_list.append(result_dict)
+        return result_list
+
+    @func_test
+    def qat_cipher_then_auth_aes_cbc_encrypt(self) -> None:
+        """Test throughput on crypto_qat device type with aes-cbc and sha2-256-hmac algorithms.
+
+        Steps:
+            * Create a Cryptodev application instance with crypto_qat devtype
+                and cipher_then_auth operation with aes-cbc and sha2-256-hmac algorithms
+            * Run the application and gather throughput statistics
+
+        Verify:
+            * Throughput results meet predefined baseline
+        """
+        app = Cryptodev(
+            ptest=TestType.throughput,
+            devtype=DeviceType.crypto_qat,
+            optype=OperationType.cipher_then_auth,
+            cipher_algo=CipherAlgorithm.aes_cbc,
+            cipher_op=EncryptDecryptSwitch.encrypt,
+            cipher_key_sz=16,
+            cipher_iv_sz=16,
+            auth_algo=AuthenticationAlgorithm.sha2_256_hmac,
+            auth_op=AuthenticationOpMode.generate,
+            auth_key_sz=64,
+            digest_sz=32,
+            total_ops=30_000_000,
+            burst_sz=32,
+            buffer_sz=self.buffer_sizes,
+        )
+        results = self._verify_throughput(app.run_app(numvfs=0))
+        self._print_stats(results)
+        for result in results:
+            verify(
+                result["passed"] == "PASS",
+                f"""Gbps was {result["gbps delta"]} below baseline
+                \nMOps was {result["mops delta"]} below baseline""",
+            )
+
+    @func_test
+    def qat_aead_aes_gcm_encrypt(self) -> None:
+        """Test throughput on a crypto_qat device type with aes-gcm algorithm.
+
+        Steps:
+            * Create a Cryptodev application instance with QAT device
+                and aead operation with aes-gcm algorithm
+            * Run the application and gather throughput statistics
+
+        Verify:
+            * Throughput results meet predefined baseline
+        """
+        app = Cryptodev(
+            ptest=TestType.throughput,
+            devtype=DeviceType.crypto_qat,
+            optype=OperationType.aead,
+            aead_aad_sz=16,
+            aead_key_sz=16,
+            aead_iv_sz=12,
+            aead_op=EncryptDecryptSwitch.encrypt,
+            aead_algo=AeadAlgName.aes_gcm,
+            digest_sz=16,
+            total_ops=30_000_000,
+            burst_sz=32,
+            buffer_sz=self.buffer_sizes,
+        )
+        results = self._verify_throughput(app.run_app(numvfs=1))
+        self._print_stats(results)
+        for result in results:
+            verify(
+                result["passed"] == "PASS",
+                f"Gbps and MOps were {result["gbps delta"]} below baseline",
+            )
+
+    @func_test
+    def qat_cipher_aes_docsisbpi_decrypt(self) -> None:
+        """Test throughput on a crypto_qat devtype with aes-docsibpi algorithm.
+
+        Steps:
+            * Create a Cryptodev application instance with QAT device
+                and cipher_only operation with aes-docsibpi algorithm
+            * Run the application and gather throughput statistics
+
+        Verify:
+            * Throughput results meet predefined baseline
+        """
+        app = Cryptodev(
+            ptest=TestType.throughput,
+            devtype=DeviceType.crypto_qat,
+            optype=OperationType.cipher_only,
+            cipher_algo=CipherAlgorithm.aes_docsisbpi,
+            cipher_op=EncryptDecryptSwitch.decrypt,
+            cipher_key_sz=32,
+            cipher_iv_sz=16,
+            burst_sz=32,
+            buffer_sz=self.buffer_sizes,
+            total_ops=30_000_000,
+        )
+        results = self._verify_throughput(app.run_app(numvfs=1))
+        self._print_stats(results)
+        for result in results:
+            verify(
+                result["passed"] == "PASS",
+                f"Gbps and MOps were {result["gbps delta"]} below baseline",
+            )
+
+    @func_test
+    def qat_cipher_aes_docsisbpi_encrypt(self) -> None:
+        """Test throughput on a crypto_qat device type with aes-docsibpi algorithm.
+
+        Steps:
+            * Create a Cryptodev application instance with crypto_qat device
+                and cipher_only operation with aes-docsibpi algorithm
+            * Run the application and gather throughput statistics
+
+        Verify:
+            * Throughput results meet predefined baseline
+        """
+        app = Cryptodev(
+            ptest=TestType.throughput,
+            devtype=DeviceType.crypto_qat,
+            optype=OperationType.cipher_only,
+            cipher_algo=CipherAlgorithm.aes_docsisbpi,
+            cipher_op=EncryptDecryptSwitch.encrypt,
+            cipher_key_sz=32,
+            cipher_iv_sz=16,
+            burst_sz=32,
+            buffer_sz=self.buffer_sizes,
+            total_ops=30_000_000,
+        )
+        results = self._verify_throughput(app.run_app(numvfs=3))
+        self._print_stats(results)
+        for result in results:
+            verify(
+                result["passed"] == "PASS",
+                f"Gbps and MOps were {result["gbps delta"]} below baseline",
+            )
+
+    @func_test
+    def qat_cipher_then_auth_kasumi_f8_encrypt(self) -> None:
+        """Test throughput on a crypto_qat device type with kasumi-f8 and kasumi-f9 algorithms.
+
+        Steps:
+            * Create a Cryptodev application instance with crypto_qat device
+                and cipher_then_auth operation with kasumi-f8 and kasumi-f9 algorithms
+            * Run the application and gather throughput statistics
+
+        Verify:
+            * Throughput results meet predefined baseline
+        """
+        app = Cryptodev(
+            ptest=TestType.throughput,
+            devtype=DeviceType.crypto_qat,
+            optype=OperationType.cipher_then_auth,
+            cipher_algo=CipherAlgorithm.kasumi_f8,
+            cipher_op=EncryptDecryptSwitch.encrypt,
+            cipher_key_sz=16,
+            cipher_iv_sz=8,
+            auth_algo=AuthenticationAlgorithm.kasumi_f9,
+            auth_op=AuthenticationOpMode.generate,
+            auth_key_sz=16,
+            digest_sz=4,
+            total_ops=30_000_000,
+            burst_sz=32,
+            buffer_sz=self.buffer_sizes,
+        )
+        results = self._verify_throughput(app.run_app(numvfs=6))
+        self._print_stats(results)
+        for result in results:
+            verify(
+                result["passed"] == "PASS",
+                f"Gbps and MOps were {result["gbps delta"]} below baseline",
+            )
+
+    @func_test
+    def qat_cipher_then_auth_snow3g_uea2_encrpyt(self) -> None:
+        """Test throughput on a crypto_qat device type with snow3g-uea2 and snow3g-uia2 algorithms.
+
+        Steps:
+            * Create a Cryptodev application instance with crypto_qat device
+                and cipher_then_auth operation with snow3g-uea2 and snow3g-uia2 algorithms
+            * Run the application and gather throughput statistics
+
+        Verify:
+            * Throughput results meet predefined baseline
+        """
+        app = Cryptodev(
+            ptest=TestType.throughput,
+            devtype=DeviceType.crypto_qat,
+            optype=OperationType.cipher_then_auth,
+            cipher_algo=CipherAlgorithm.snow3g_uea2,
+            cipher_op=EncryptDecryptSwitch.encrypt,
+            cipher_key_sz=16,
+            cipher_iv_sz=16,
+            auth_algo=AuthenticationAlgorithm.snow3g_uia2,
+            auth_op=AuthenticationOpMode.generate,
+            auth_key_sz=16,
+            auth_iv_sz=16,
+            digest_sz=4,
+            total_ops=30_000_000,
+            burst_sz=32,
+            buffer_sz=self.buffer_sizes,
+        )
+        results = self._verify_throughput(app.run_app(numvfs=12))
+        self._print_stats(results)
+        for result in results:
+            verify(
+                result["passed"] == "PASS",
+                f"Gbps and MOps were {result["gbps delta"]} below baseline",
+            )
+
+    @func_test
+    def qat_cipher_then_auth_zuc_eea3_encrypt(self) -> None:
+        """Test throughput on a crypto_qat device type with zuc-eea3 and zuc-eia3 algorithms.
+
+        Steps:
+            * Create a Cryptodev application instance with crypto_qat device
+                and cipher_then_auth operation with zuc-eea3 and zuc-eia3 algorithms
+            * Run the application and gather throughput statistics
+
+        Verify:
+            * Throughput results meet predefined baseline
+        """
+        app = Cryptodev(
+            ptest=TestType.throughput,
+            devtype=DeviceType.crypto_qat,
+            optype=OperationType.cipher_then_auth,
+            cipher_algo=CipherAlgorithm.zuc_eea3,
+            cipher_op=EncryptDecryptSwitch.encrypt,
+            cipher_key_sz=16,
+            cipher_iv_sz=16,
+            auth_algo=AuthenticationAlgorithm.zuc_eia3,
+            auth_op=AuthenticationOpMode.generate,
+            auth_key_sz=16,
+            auth_iv_sz=16,
+            digest_sz=4,
+            total_ops=30_000_000,
+            burst_sz=32,
+            buffer_sz=self.buffer_sizes,
+        )
+        results = self._verify_throughput(app.run_app(numvfs=12))
+        self._print_stats(results)
+        for result in results:
+            verify(
+                result["passed"] == "PASS",
+                f"Gbps and MOps were {result["gbps delta"]} below baseline",
+            )
-- 
2.50.1

