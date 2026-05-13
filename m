Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91141CD4F24
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 May 2026 15:27:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B568840655;
	Wed, 13 May 2026 17:27:39 +0200 (CEST)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by mails.dpdk.org (Postfix) with ESMTP id 3EB284064F
 for <dev@dpdk.org>; Wed, 13 May 2026 17:27:38 +0200 (CEST)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-90fc979d84cso59616785a.1
 for <dev@dpdk.org>; Wed, 13 May 2026 08:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1778686057; x=1779290857; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R5dbvO/yWijzDpnTwEI+WDN5/mbFMNjDCM7djnz+Dcg=;
 b=LA81H2Wu4pN4Xxsq3uS72Vxo8rgMjgg8QOWyAw39upfBmcQ/Kld9C/M9V/q1TT1dsa
 68gb+v3ij4I+f2Ttf3PTwCeauV26wdCNSEdvqHUttbpEkcJvE5mcsg3euhVL6sfLsbkF
 7aEO+VI/cIImFYnJLsvG2GrEFXJ4ZiWN/C0T4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778686057; x=1779290857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R5dbvO/yWijzDpnTwEI+WDN5/mbFMNjDCM7djnz+Dcg=;
 b=rPo2TgEbj2bTKJcI+kSA9/vXAYGIq482jNUkyVLWK+LVHZA6Wo2M4eNOuSjMOGCBy8
 RB3PiKeaa5e+dNpBHMogsxJ7+qsSpu10lG4V9JJxwwnIuWPH/8OY6JRZFvrGcmE0wy76
 Hv+LST3YV9VXKvQXmFw7oLGRChdP+c1I5mJyQkGWg10ccA7NyjiA23JV0nltRNc1OQr+
 ij1uFJXm+KNXgA21cQvzVSUsC18JSLe7L2AQFS+lBxzyvYCnBQj96w1qLnlludGiRE+f
 KUuyVwPpXj+kFTPPGQSqykT0FOSewB7WMTzEn2/F+mdIQE6l/ubJglOqQYlSDPMVxbYy
 8Ggw==
X-Gm-Message-State: AOJu0Yw2oKgDijKwzsc1e+kII0HBpSwnzm/v32rNfikXprQ5+5ikdqE0
 P8d8JskbmqgCuyvE5AfpqOWjvyvMUiIgS7ER1b4XvEuLXW2yftHSNHiEgLlGh+2K058=
X-Gm-Gg: Acq92OFQ5DtR89X7OgLNe5eZeaQZ4qsy8jUmGejy7EtOWlbjgTbwwnwq9xHgDXFnTT+
 lAaLwhQ0nd/sA708lJRAdJTca5ah/R4iAbBhx6JWvliQoz5/ayiEP97vI3CDDZXqwYmAb1gWqUv
 KP2k2O5yY2fqS85+uv4nGek/sBRUFF+aGSR1kXcfQUpvXIn1onrzg/rlDHcGvIaE6Erqffr/2fu
 K/0w4yYEHnkc2u095bMjPUGMnz7jhDLT37Unyrvl4+ChoD/OqujcaJavIat4dc20d1Z3kzbtrp1
 QR5UNfJyvO5IgOJ20ZHw4luSQsL0ZA8IpnWIvtOYjShkUwdu6IlLLq4MMRHSKSFG/qzqplDVIGR
 InpyjgUbhWICLab/zcrZO2BVNgXi63t9XscWvegHdE055Vccs0IPSzNLjbkGjJi80IrWTxpAeKE
 SOnrULi8MWmJLdkWexxoNZwDaqSs/nYq4jfOtgdtHQSiUzR0KNxQCB7taR5SAzXnnu
X-Received: by 2002:a05:620a:7002:b0:8d1:d0db:392e with SMTP id
 af79cd13be357-90fad3838c4mr497375785a.32.1778686057085; 
 Wed, 13 May 2026 08:27:37 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-907b977274csm1645468585a.6.2026.05.13.08.27.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 08:27:36 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: dev@dpdk.org, lylavoie@iol.unh.edu, ahassick@iol.unh.edu,
 knimoji@iol.unh.edu, Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v1 2/2] dts: add latency coverage for cryptodev testing
Date: Wed, 13 May 2026 11:27:15 -0400
Message-ID: <20260513152715.133381-2-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260513152715.133381-1-abailey@iol.unh.edu>
References: <20260428181501.72434-1-abailey@iol.unh.edu>
 <20260513152715.133381-1-abailey@iol.unh.edu>
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
 dts/tests/TestSuite_cryptodev_latency.py      | 695 ++++++++++++++++++
 2 files changed, 703 insertions(+)
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
index 0000000000..54edd4e0a6
--- /dev/null
+++ b/dts/tests/TestSuite_cryptodev_latency.py
@@ -0,0 +1,695 @@
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
+    {"buff_size": 64, "avg_cycles": 99_999.00, "avg_time_us": 9999.0},
+    {"buff_size": 512, "avg_cycles": 99_999.00, "avg_time_us": 9999.0},
+    {"buff_size": 2048, "avg_cycles": 99_999.00, "avg_time_us": 9999.0},
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
+        "aes_cbc": config_list,
+        "aes_cbc_sha1_hmac": config_list,
+        "aes_cbc_sha2_hmac": config_list,
+        "aes_docsisbpi": config_list,
+        "aes_gcm": config_list,
+        "kasumi_f8_kasumi_f9": config_list,
+        "snow3g_uea2_snow3g_uia2": config_list,
+        "zuc_eea3_zuc_eia3": config_list,
+        "aesni_gcm_vdev": config_list,
+        "aesni_mb_cipher_then_auth_vdev": config_list,
+        "aesni_mb_vdev": config_list,
+        "kasumi_vdev": config_list,
+        "open_ssl_vdev": config_list,
+        "snow3g_vdev": config_list,
+        "zuc_vdev": config_list,
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
+            devtype=self.device_type,
+            optype=OperationType.cipher_only,
+            cipher_algo=CipherAlgorithm.aes_cbc,
+            cipher_op=EncryptDecryptSwitch.encrypt,
+            cipher_key_sz=16,
+            cipher_iv_sz=16,
+            burst_sz=32,
+            total_ops=TOTAL_OPS,
+            buffer_sz=self.buffer_sizes["aes_cbc"],
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
+            devtype=self.device_type,
+            optype=OperationType.cipher_then_auth,
+            cipher_algo=CipherAlgorithm.aes_cbc,
+            cipher_op=EncryptDecryptSwitch.encrypt,
+            cipher_key_sz=16,
+            auth_algo=AuthenticationAlgorithm.sha1_hmac,
+            auth_op=AuthenticationOpMode.generate,
+            auth_key_sz=64,
+            digest_sz=12,
+            burst_sz=32,
+            total_ops=TOTAL_OPS,
+            buffer_sz=self.buffer_sizes["aes_cbc_sha1_hmac"],
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
+    def aes_cbc_sha2_hmac(self) -> None:
+        """aes_cbc_sha2_hmac latency test.
+
+        Steps:
+            * Create a cryptodev instance with provided device type and buffer sizes.
+        Verify:
+            * The latency is below or within delta of provided baseline.
+
+        Raises:
+            SkippedTestException: When configuration is not provided.
+        """
+        if "aes_cbc_sha2_hmac" not in self.latency_test_parameters:
+            skip("test not configured")
+        app = Cryptodev(
+            ptest=TestType.latency,
+            devtype=self.device_type,
+            optype=OperationType.cipher_then_auth,
+            cipher_algo=CipherAlgorithm.aes_cbc,
+            cipher_op=EncryptDecryptSwitch.encrypt,
+            cipher_key_sz=16,
+            cipher_iv_sz=16,
+            auth_algo=AuthenticationAlgorithm.sha2_256_hmac,
+            auth_op=AuthenticationOpMode.generate,
+            auth_key_sz=64,
+            digest_sz=32,
+            burst_sz=32,
+            total_ops=TOTAL_OPS,
+            buffer_sz=self.buffer_sizes["aes_cbc_sha2_hmac"],
+        )
+        results = self._verify_latency(app.run_app(), "aes_cbc_sha2_hmac")
+        self._print_stats(results)
+        for result in results:
+            verify(
+                result["passed"] == "PASS",
+                "latency fell more than the delta tolerance below baseline",
+            )
+
+    @crypto_test
+    def aes_docsisbpi(self) -> None:
+        """aes_docsisbpi latency test.
+
+        Steps:
+            * Create a cryptodev instance with provided device type and buffer sizes.
+        Verify:
+            * The latency is below or within delta of provided baseline.
+
+        Raises:
+            SkippedTestException: When configuration is not provided.
+        """
+        if "aes_docsisbpi" not in self.latency_test_parameters:
+            skip("test not configured")
+        app = Cryptodev(
+            ptest=TestType.latency,
+            devtype=self.device_type,
+            optype=OperationType.cipher_only,
+            cipher_algo=CipherAlgorithm.aes_docsisbpi,
+            cipher_op=EncryptDecryptSwitch.encrypt,
+            cipher_key_sz=32,
+            cipher_iv_sz=16,
+            total_ops=TOTAL_OPS,
+            buffer_sz=self.buffer_sizes["aes_docsisbpi"],
+        )
+        results = self._verify_latency(app.run_app(), "aes_docsisbpi")
+        self._print_stats(results)
+        for result in results:
+            verify(
+                result["passed"] == "PASS",
+                "latency fell more than the delta tolerance below baseline",
+            )
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
+            devtype=self.device_type,
+            optype=OperationType.aead,
+            aead_algo=AeadAlgName.aes_gcm,
+            aead_op=EncryptDecryptSwitch.encrypt,
+            aead_key_sz=16,
+            aead_iv_sz=12,
+            aead_aad_sz=16,
+            digest_sz=16,
+            burst_sz=32,
+            total_ops=TOTAL_OPS,
+            buffer_sz=self.buffer_sizes["aes_gcm"],
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
+    def kasumi_f8_kasumi_f9(self) -> None:
+        """kasumi_f8_kasumi_f9 latency test.
+
+        Steps:
+            * Create a cryptodev instance with provided device type and buffer sizes.
+        Verify:
+            * The latency is below or within delta of provided baseline.
+
+        Raises:
+            SkippedTestException: When configuration is not provided.
+        """
+        if "kasumi_f8_kasumi_f9" not in self.latency_test_parameters:
+            skip("test not configured")
+        app = Cryptodev(
+            ptest=TestType.latency,
+            devtype=self.device_type,
+            optype=OperationType.cipher_then_auth,
+            cipher_algo=CipherAlgorithm.kasumi_f8,
+            cipher_op=EncryptDecryptSwitch.encrypt,
+            cipher_key_sz=16,
+            cipher_iv_sz=8,
+            auth_algo=AuthenticationAlgorithm.kasumi_f9,
+            auth_op=AuthenticationOpMode.generate,
+            auth_key_sz=16,
+            digest_sz=4,
+            burst_sz=32,
+            total_ops=TOTAL_OPS,
+            buffer_sz=self.buffer_sizes["kasumi_f8_kasumi_f9"],
+        )
+        results = self._verify_latency(app.run_app(), "kasumi_f8_kasumi_f9")
+        self._print_stats(results)
+        for result in results:
+            verify(
+                result["passed"] == "PASS",
+                "latency fell more than the delta tolerance below baseline",
+            )
+
+    @crypto_test
+    def snow3g_uea2_snow3g_uia2(self) -> None:
+        """snow3g_uea2_snow3g_uia2 latency test.
+
+        Steps:
+            * Create a cryptodev instance with provided device type and buffer sizes.
+        Verify:
+            * The latency is below or within delta of provided baseline.
+
+        Raises:
+            SkippedTestException: When configuration is not provided.
+        """
+        if "snow3g_uea2_snow3g_uia2" not in self.latency_test_parameters:
+            skip("test not configured")
+        app = Cryptodev(
+            ptest=TestType.latency,
+            devtype=self.device_type,
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
+            total_ops=TOTAL_OPS,
+            buffer_sz=self.buffer_sizes["snow3g_uea2_snow3g_uia2"],
+        )
+        results = self._verify_latency(app.run_app(), "snow3g_uea2_snow3g_uia2")
+        self._print_stats(results)
+        for result in results:
+            verify(
+                result["passed"] == "PASS",
+                "latency fell more than the delta tolerance below baseline",
+            )
+
+    @crypto_test
+    def zuc_eea3_zuc_eia3(self) -> None:
+        """zuc_eea3_zuc_eia3 vdev cipher and auth latency test.
+
+        Steps:
+            * Create a cryptodev instance with provided device type and buffer sizes.
+        Verify:
+            * The latency is below or within delta of provided baseline.
+
+        Raises:
+            SkippedTestException: When configuration is not provided.
+        """
+        if "zuc_eea3_zuc_eia3" not in self.latency_test_parameters:
+            skip("test not configured")
+        app = Cryptodev(
+            ptest=TestType.latency,
+            devtype=self.device_type,
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
+            total_ops=TOTAL_OPS,
+            buffer_sz=self.buffer_sizes["zuc_eea3_zuc_eia3"],
+        )
+        results = self._verify_latency(app.run_app(), "zuc_eea3_zuc_eia3")
+        self._print_stats(results)
+        for result in results:
+            verify(
+                result["passed"] == "PASS",
+                "latency fell more than the delta tolerance below baseline",
+            )
+
+    # BEGIN VDEV TESTS
+
+    @crypto_test
+    def aesni_gcm_vdev(self) -> None:
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
+        if "aesni_gcm_vdev" not in self.latency_test_parameters:
+            skip("test not configured")
+        app = Cryptodev(
+            ptest=TestType.latency,
+            vdevs=[VirtualDevice("crypto_aesni_gcm0")],
+            devtype=DeviceType.crypto_aesni_gcm,
+            optype=OperationType.aead,
+            aead_op=EncryptDecryptSwitch.encrypt,
+            aead_key_sz=16,
+            aead_iv_sz=12,
+            aead_aad_sz=16,
+            digest_sz=16,
+            burst_sz=32,
+            total_ops=TOTAL_OPS,
+            buffer_sz=self.buffer_sizes["aesni_gcm_vdev"],
+        )
+        results = self._verify_latency(app.run_app(), "aesni_gcm_vdev")
+        self._print_stats(results)
+        for result in results:
+            verify(result["passed"] == "PASS", "latency fell more than the delta tolerance")
+
+    @crypto_test
+    def aesni_mb_cipher_then_auth_vdev(self) -> None:
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
+        if "aesni_mb_cipher_then_auth_vdev" not in self.latency_test_parameters:
+            skip("test not configured")
+        app = Cryptodev(
+            ptest=TestType.latency,
+            vdevs=[VirtualDevice("crypto_aesni_mb0")],
+            devtype=DeviceType.crypto_aesni_mb,
+            optype=OperationType.cipher_then_auth,
+            cipher_algo=CipherAlgorithm.aes_cbc,
+            cipher_op=EncryptDecryptSwitch.encrypt,
+            cipher_key_sz=16,
+            auth_algo=AuthenticationAlgorithm.sha1_hmac,
+            auth_op=AuthenticationOpMode.generate,
+            auth_key_sz=64,
+            digest_sz=12,
+            burst_sz=32,
+            total_ops=TOTAL_OPS,
+            buffer_sz=self.buffer_sizes["aesni_mb_cipher_then_auth_vdev"],
+        )
+        results = self._verify_latency(app.run_app(), "aesni_mb_cipher_then_auth_vdev")
+        self._print_stats(results)
+        for result in results:
+            verify(
+                result["passed"] == "PASS",
+                "latency fell more than the delta tolerance below baseline",
+            )
+
+    @crypto_test
+    def aesni_mb_vdev(self) -> None:
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
+        if "aesni_mb_vdev" not in self.latency_test_parameters:
+            skip("test not configured")
+        app = Cryptodev(
+            ptest=TestType.latency,
+            vdevs=[VirtualDevice("crypto_aesni_mb0")],
+            devtype=DeviceType.crypto_aesni_mb,
+            optype=OperationType.cipher_only,
+            cipher_algo=CipherAlgorithm.aes_cbc,
+            cipher_op=EncryptDecryptSwitch.encrypt,
+            cipher_key_sz=16,
+            cipher_iv_sz=16,
+            burst_sz=32,
+            total_ops=TOTAL_OPS,
+            buffer_sz=self.buffer_sizes["aesni_mb_vdev"],
+        )
+        results = self._verify_latency(app.run_app(), "aesni_mb_vdev")
+        self._print_stats(results)
+        for result in results:
+            verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
+
+    @crypto_test
+    def kasumi_vdev(self) -> None:
+        """Kasumi vdev latency test.
+
+        Steps:
+            * Create a cryptodev instance with provided device type and buffer sizes.
+        Verify:
+            * The latency is below or within delta of provided baseline.
+
+        Raises:
+            SkippedTestException: When configuration is not provided.
+        """
+        if "kasumi_vdev" not in self.latency_test_parameters:
+            skip("test not configured")
+        app = Cryptodev(
+            ptest=TestType.latency,
+            vdevs=[VirtualDevice("crypto_kasumi0")],
+            devtype=DeviceType.crypto_kasumi,
+            optype=OperationType.cipher_then_auth,
+            cipher_algo=CipherAlgorithm.kasumi_f8,
+            cipher_op=EncryptDecryptSwitch.encrypt,
+            cipher_key_sz=16,
+            cipher_iv_sz=8,
+            auth_algo=AuthenticationAlgorithm.kasumi_f9,
+            auth_op=AuthenticationOpMode.generate,
+            auth_key_sz=16,
+            digest_sz=4,
+            burst_sz=32,
+            total_ops=TOTAL_OPS,
+            buffer_sz=self.buffer_sizes["kasumi_vdev"],
+        )
+        results = self._verify_latency(app.run_app(), "kasmui_vdev")
+        self._print_stats(results)
+        for result in results:
+            verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
+
+    @crypto_test
+    def open_ssl_vdev(self) -> None:
+        """open_ssl vdev latency test.
+
+        Steps:
+            * Create a cryptodev instance with provided device type and buffer sizes.
+        Verify:
+            * The latency is below or within delta of provided baseline.
+
+        Raises:
+            SkippedTestException: When configuration is not provided.
+        """
+        if "open_ssl_vdev" not in self.latency_test_parameters:
+            skip("test not configured")
+        app = Cryptodev(
+            ptest=TestType.latency,
+            vdevs=[VirtualDevice("crypto_openssl0")],
+            devtype=DeviceType.crypto_openssl,
+            optype=OperationType.aead,
+            aead_algo=AeadAlgName.aes_gcm,
+            aead_op=EncryptDecryptSwitch.encrypt,
+            aead_key_sz=16,
+            aead_iv_sz=16,
+            aead_aad_sz=16,
+            digest_sz=16,
+            total_ops=TOTAL_OPS,
+            buffer_sz=self.buffer_sizes["open_ssl_vdev"],
+        )
+        results = self._verify_latency(app.run_app(), "open_ssl_vdev")
+        self._print_stats(results)
+        for result in results:
+            verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
+
+    @crypto_test
+    def snow3g_vdev(self) -> None:
+        """snow3g vdev latency test.
+
+        Steps:
+            * Create a cryptodev instance with provided device type and buffer sizes.
+        Verify:
+            * The latency is below or within delta of provided baseline.
+
+        Raises:
+            SkippedTestException: When configuration is not provided.
+        """
+        if "snow3g_vdev" not in self.latency_test_parameters:
+            skip("test not configured")
+        app = Cryptodev(
+            ptest=TestType.latency,
+            vdevs=[VirtualDevice("crypto_snow3g0")],
+            devtype=DeviceType.crypto_snow3g,
+            optype=OperationType.cipher_then_auth,
+            cipher_algo=CipherAlgorithm.snow3g_uea2,
+            cipher_op=EncryptDecryptSwitch.encrypt,
+            cipher_key_sz=16,
+            cipher_iv_sz=16,
+            auth_algo=AuthenticationAlgorithm.snow3g_uia2,
+            auth_op=AuthenticationOpMode.generate,
+            auth_key_sz=16,
+            auth_iv_sz=16,
+            digest_sz=16,
+            burst_sz=32,
+            total_ops=TOTAL_OPS,
+            buffer_sz=self.buffer_sizes["open_ssl_vdev"],
+        )
+        results = self._verify_latency(app.run_app(), "open_ssl_vdev")
+        self._print_stats(results)
+        for result in results:
+            verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
+
+    @crypto_test
+    def zuc_vdev(self) -> None:
+        """Zuc vdev latency test.
+
+        Steps:
+            * Create a cryptodev instance with provided device type and buffer sizes.
+        Verify:
+            * The latency is below or within delta of provided baseline.
+
+        Raises:
+            SkippedTestException: When configuration is not provided.
+        """
+        if "zuc_vdev" not in self.latency_test_parameters:
+            skip("test not configured")
+        app = Cryptodev(
+            ptest=TestType.latency,
+            vdevs=[VirtualDevice("crypto_zuc0")],
+            devtype=DeviceType.crypto_zuc,
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
+            burst_sz=32,
+            total_ops=TOTAL_OPS,
+            buffer_sz=self.buffer_sizes["zuc_vdev"],
+        )
+        results = self._verify_latency(app.run_app(), "zuc_vdev")
+        self._print_stats(results)
+        for result in results:
+            verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
-- 
2.50.1

