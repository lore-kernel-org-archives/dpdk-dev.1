Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5CFEB362F
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 18:55:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 073A140E3A;
	Mon,  2 Mar 2026 19:55:04 +0100 (CET)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com
 [209.85.219.50]) by mails.dpdk.org (Postfix) with ESMTP id 22F9A40E3A
 for <dev@dpdk.org>; Mon,  2 Mar 2026 19:55:03 +0100 (CET)
Received: by mail-qv1-f50.google.com with SMTP id
 6a1803df08f44-899fa9610bbso20724976d6.0
 for <dev@dpdk.org>; Mon, 02 Mar 2026 10:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1772477702; x=1773082502; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WeWHqg3o1UOY6XUfOHdO+934KEk654bXnCSCR4GJOfc=;
 b=IROpdXCcMblRL173lwRd9xtbzntIEznYmy7Zi4Xy4jNDPQJDfe/WTVFiDooTn6oetX
 PXp+Z9qE3vn4d+iKt8ynUC1CYFxmwbY9G0wMwEQ7RsVNrj9gM4SS79rXYmqDltqoXGjd
 a8KXuJOCMkaZekN4dW1c9nLGyHRifFZ8EkbDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772477702; x=1773082502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WeWHqg3o1UOY6XUfOHdO+934KEk654bXnCSCR4GJOfc=;
 b=wJ+UnhP6lwSoDBLVDDI+i4VlLpdkczXXmdrrnrejoU6Wn1zBB14/RhTfRCvjfjLDQr
 KHnDxnH0NQRGcdb+uHJC8K46IgcKnzqcQFIgKIAyevXHhh4gOMBN5vf3agbOXxU2Ms0p
 KNtk4EWSbM39KS3Nc/BVhqUSsKfXOEaD4EmZiRVKpzQ8fObmymt7HHjd97OxXN6FGqWD
 8yzRXsNxa+7VUbJBM+xeuv9Vo84evwEsLrv7/4ItTYfV/ZbK67gCsDsJo2vWoSyndjQE
 W9hWHX5UqJIHrWLhZITiDNEutAiOD+ZMAp5XaJwZBNZYI/LW6Jt79+kDXz0VM1vN7A6Y
 Lzag==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6kpfybMW+5oA9ZQhoaCPKekhLJ6uXgPxP2cZT4lHQVcroRK0N1C57oUdA5ygyJi5qLko=@dpdk.org
X-Gm-Message-State: AOJu0YxDvd2rl0fEc7x0ZLWu2emwJRbmGU0PQ97iEwI0RDD+tdNQTQKP
 04Z68l2sai5rAl8Zya001dPCzcRhl4OcUviPHePiSYZVOuQlMhwOgcSs6HyIdwUMACk=
X-Gm-Gg: ATEYQzyy1suDs8pVqNOZWGOpLLemQkNae8EPSv1wq4m3gQ+IcPu4u7yVd2iARy/wAl/
 n9Cc0cA501UIMdvCyzzdP7oA4nfTMZJT85GXqxXRctB5pVrTrXZuNPDNsgCbHAO3VLZjPekmLo4
 LFl5Q0j1F+4/beTUjEQuBfCxVBQQ9xRaBo7iENk6RTDtYtoLIj9ZFVwcjmadhcwhrAmAblZszIW
 rn0A7qkucxNzfJPpkygpIlJfu25eM7JwBfBSSR2fXSRNr9JRJ33nKQFiYmTFSTrvD0zpp0ylm+G
 vkk9sBXcgTJaSHinnCLj8PkmGILCOJvLAlSWaCBGhCSyxpsV9UhM9ZadVjOW3OZCNhLnIULCMtd
 mm+N2oeIKtfpaFKQPrym8V/FGuR35zrmITIAUReh6Q6nqygvuOBQkiKgJ0tXmeHZ6V4TeeghGp6
 OBAnVOM2MS9T/cU6cy+kh0Qnymz6NItJrPyXB3jkTLu91w3JkHyGDNPxfs2TyGBCWR
X-Received: by 2002:a05:6214:e86:b0:897:2b23:3a7d with SMTP id
 6a1803df08f44-899d1d6c84amr202792276d6.2.1772477702289; 
 Mon, 02 Mar 2026 10:55:02 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-899eed12615sm46719586d6.8.2026.03.02.10.55.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 10:55:01 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: probb@iol.unh.edu
Cc: luca.vizzarro@arm.com, dmarx@iol.unh.edu, dev@dpdk.org, gakhil@marvell.com,
 kai.ji@intel.com, dharmikjayesh@arm.com, david.marchand@redhat.com,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v4 4/5] dts: add cryptodev throughput test suite
Date: Mon,  2 Mar 2026 13:54:37 -0500
Message-ID: <20260302185438.122584-5-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260302185438.122584-1-abailey@iol.unh.edu>
References: <20260210193448.69423-1-abailey@iol.unh.edu>
 <20260302185438.122584-1-abailey@iol.unh.edu>
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
performance metrics of supplied crypto devices using the
dpdk-test-crypto-perf application. The results of this application will
be compared against user supplied performance metrics and fail if signs
of regression are apparent.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 .../tests.TestSuite_cryptodev_throughput.rst  |   8 +
 dts/configurations/tests_config.example.yaml  |   8 +
 dts/tests/TestSuite_cryptodev_throughput.py   | 693 ++++++++++++++++++
 3 files changed, 709 insertions(+)
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
diff --git a/dts/configurations/tests_config.example.yaml b/dts/configurations/tests_config.example.yaml
index 64fa630aa0..c9beff9c99 100644
--- a/dts/configurations/tests_config.example.yaml
+++ b/dts/configurations/tests_config.example.yaml
@@ -15,3 +15,11 @@ hello_world:
 #       num_descriptors: 1024
 #       expected_mpps: 1.0
 #   delta_tolerance: 0.05
+# cryptodev_throughput:
+#   delta_tolerance: 0.05
+#   throughput_test_parameters:
+#     snow3g_uea2_snow3g_uia2: # Add the name of the test suite you would like to run
+#      - buff_size: 64
+#        gbps: 2.0 # Set gigabits per second according to your devices throughput for this given buffer size
+#      - buff_size: 512
+#        gbps: 20.0
\ No newline at end of file
diff --git a/dts/tests/TestSuite_cryptodev_throughput.py b/dts/tests/TestSuite_cryptodev_throughput.py
new file mode 100644
index 0000000000..d32879b9aa
--- /dev/null
+++ b/dts/tests/TestSuite_cryptodev_throughput.py
@@ -0,0 +1,693 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 University of New Hampshire
+
+"""DPDK cryptodev performance test suite.
+
+The main goal of this test suite is to utilize the dpdk-test-cryptodev application to gather
+performance metrics for various cryptographic operations supported by DPDK cryptodev-pmd.
+It will then compare the results against predefined baseline given in the test_config file to
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
+from api.test import verify
+from framework.context import get_ctx
+from framework.exception import SkippedTestException
+from framework.test_suite import BaseConfig, TestSuite, func_test
+from framework.testbed_model.virtual_device import VirtualDevice
+
+config_list: list[dict[str, int | float | str]] = [
+    {"buff_size": 64, "Gbps": 1.00},
+    {"buff_size": 512, "Gbps": 1.00},
+    {"buff_size": 2048, "Gbps": 1.00},
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
+        throughput_test_parameters: The test parameters to use in the test suite.
+    """
+
+    delta_tolerance: float = 0.05
+
+    throughput_test_parameters: dict[str, list[dict[str, int | float | str]]] = {
+        "aes_cbc": config_list,
+        "aes_cbc_sha1": config_list,
+        "aes_cbc_sha2": config_list,
+        "aes_cbc_sha2_digest_16": config_list,
+        "aead_aes_gcm": config_list,
+        "aes_docsisbpi": config_list,
+        "sha1_hmac": config_list,
+        "snow3g_uea2_snow3g_uia2": config_list,
+        "zuc_eea3_zuc_eia3": config_list,
+        "kasumi_f8_kasumi_f9": config_list,
+        "open_ssl_vdev": config_list,
+        "aesni_mb_vdev": config_list,
+        "aesni_gcm_vdev": config_list,
+        "kasumi_vdev": config_list,
+        "zuc_vdev": config_list,
+        "snow3g_vdev": config_list,
+    }
+
+
+@requires_link_topology(LinkTopology.NO_LINK)
+class TestCryptodevThroughput(TestSuite):
+    """DPDK Crypto Device Testing Suite."""
+
+    config: Config
+
+    def set_up_suite(self) -> None:
+        """Set up the test suite."""
+        self.throughput_test_parameters: dict[str, list[dict[str, int | float | str]]] = (
+            self.config.throughput_test_parameters
+        )
+        self.delta_tolerance: float = self.config.delta_tolerance
+        self.driver: DeviceType | None = get_device_from_str(
+            str(get_ctx().sut_node.crypto_device_type)
+        )
+        self.buffer_sizes = {}
+
+        for k, v in self.throughput_test_parameters.items():
+            self.buffer_sizes[k] = ListWrapper([int(run["buff_size"]) for run in v])
+
+    def _print_stats(self, test_vals: list[dict[str, int | float | str]]) -> None:
+        element_len = len("Delta Tolerance")
+        border_len = (element_len + 1) * (len(test_vals[0]))
+
+        print(f"{'Throughput Results'.center(border_len)}\n{'=' * border_len}")
+        for k, v in test_vals[0].items():
+            print(f"|{k.title():<{element_len}}", end="")
+        print(f"|\n{'='*border_len}")
+
+        for test_val in test_vals:
+            for k, v in test_val.items():
+                print(f"|{v:<{element_len}}", end="")
+            print(f"|\n{'='*border_len}")
+
+    def _verify_throughput(
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
+                    self.throughput_test_parameters[key],
+                )
+            )[0]
+            test_result = True
+            expected_gbps = parameters["Gbps"]
+            measured_delta = abs(
+                round((getattr(result, "gbps") - expected_gbps) / expected_gbps, 5)
+            )
+
+            # result did not meet the given Gbps parameter, check if within delta.
+            if getattr(result, "gbps") < expected_gbps:
+                if self.delta_tolerance < measured_delta:
+                    test_result = False
+            result_list.append(
+                {
+                    "Buffer Size": parameters["buff_size"],
+                    "Gbps delta": measured_delta,
+                    "delta tolerance": self.delta_tolerance,
+                    "Gbps": getattr(result, "gbps"),
+                    "Gbps target": expected_gbps,
+                    "passed": "PASS" if test_result else "FAIL",
+                }
+            )
+        return result_list
+
+    @func_test
+    def aes_cbc(self) -> None:
+        """aes_cbc test.
+
+        Steps:
+            * Create a cryptodev instance with provided driver and buffer sizes.
+        Verify:
+            * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
+
+        Raises:
+            SkippedTestException: When configuration is not provided.
+        """
+        if "aes_cbc" not in self.throughput_test_parameters:
+            raise SkippedTestException("test not configured")
+        app = Cryptodev(
+            ptest=TestType.throughput,
+            devtype=self.driver,
+            optype=OperationType.cipher_only,
+            cipher_algo=CipherAlgorithm.aes_cbc,
+            cipher_op=EncryptDecryptSwitch.encrypt,
+            cipher_key_sz=16,
+            cipher_iv_sz=16,
+            total_ops=TOTAL_OPS,
+            buffer_sz=self.buffer_sizes["aes_cbc"],
+        )
+        results = self._verify_throughput(app.run_app(), "aes_cbc")
+        self._print_stats(results)
+        for result in results:
+            verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
+
+    def aes_cbc_sha1(self) -> None:
+        """aes_cbc_sha1 test.
+
+        Steps:
+            * Create a cryptodev instance with provided driver and buffer sizes.
+        Verify:
+            * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
+
+        Raises:
+            SkippedTestException: When configuration is not provided.
+        """
+        if "aes_cbc_sha1" not in self.throughput_test_parameters:
+            raise SkippedTestException("test not configured")
+        app = Cryptodev(
+            ptest=TestType.throughput,
+            devtype=self.driver,
+            optype=OperationType.cipher_then_auth,
+            cipher_algo=CipherAlgorithm.aes_cbc,
+            cipher_op=EncryptDecryptSwitch.encrypt,
+            cipher_key_sz=16,
+            cipher_iv_sz=16,
+            auth_algo=AuthenticationAlgorithm.sha1_hmac,
+            auth_op=AuthenticationOpMode.generate,
+            auth_key_sz=64,
+            auth_iv_sz=20,
+            digest_sz=12,
+            total_ops=TOTAL_OPS,
+            buffer_sz=self.buffer_sizes["aes_cbc_sha1"],
+        )
+        results = self._verify_throughput(app.run_app(), "aes_cbc_sha1")
+        self._print_stats(results)
+        for result in results:
+            verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
+
+    def aes_cbc_sha2(self) -> None:
+        """aes_cbc_sha2 test.
+
+        Steps:
+            * Create a cryptodev instance with provided driver and buffer sizes.
+        Verify:
+            * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
+
+        Raises:
+            SkippedTestException: When configuration is not provided.
+        """
+        if "aes_cbc_sha2" not in self.throughput_test_parameters:
+            raise SkippedTestException("test not configured")
+        app = Cryptodev(
+            ptest=TestType.throughput,
+            devtype=self.driver,
+            optype=OperationType.cipher_then_auth,
+            cipher_algo=CipherAlgorithm.aes_cbc,
+            cipher_op=EncryptDecryptSwitch.encrypt,
+            cipher_key_sz=16,
+            cipher_iv_sz=16,
+            auth_algo=AuthenticationAlgorithm.sha2_256_hmac,
+            auth_op=AuthenticationOpMode.generate,
+            auth_key_sz=64,
+            digest_sz=32,
+            total_ops=TOTAL_OPS,
+            buffer_sz=self.buffer_sizes["aes_cbc_sha2"],
+        )
+        results = self._verify_throughput(app.run_app(), "aes_cbc_sha2")
+        self._print_stats(results)
+        for result in results:
+            verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
+
+    @func_test
+    def aes_cbc_sha2_digest_16(self) -> None:
+        """aes_cbc_sha2_digest_16 test.
+
+        Steps:
+            * Create a cryptodev instance with provided driver and buffer sizes.
+        Verify:
+            * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
+
+        Raises:
+            SkippedTestException: When configuration is not provided.
+        """
+        if "aes_cbc_sha2_digest_16" not in self.throughput_test_parameters:
+            raise SkippedTestException("test not configured")
+        app = Cryptodev(
+            ptest=TestType.throughput,
+            devtype=self.driver,
+            optype=OperationType.cipher_then_auth,
+            cipher_algo=CipherAlgorithm.aes_cbc,
+            cipher_op=EncryptDecryptSwitch.encrypt,
+            cipher_key_sz=16,
+            cipher_iv_sz=16,
+            auth_algo=AuthenticationAlgorithm.sha2_256_hmac,
+            auth_op=AuthenticationOpMode.generate,
+            auth_key_sz=64,
+            digest_sz=16,
+            total_ops=TOTAL_OPS,
+            buffer_sz=self.buffer_sizes["aes_cbc_sha2_digest_16"],
+        )
+        results = self._verify_throughput(app.run_app(), "aes_cbc_sha2_digest_16")
+        self._print_stats(results)
+        for result in results:
+            verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
+
+    @func_test
+    def aead_aes_gcm(self) -> None:
+        """aead_aes_gcm test.
+
+        Steps:
+            * Create a cryptodev instance with provided driver and buffer sizes.
+        Verify:
+            * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
+
+        Raises:
+            SkippedTestException: When configuration is not provided.
+        """
+        if "aead_aes_gcm" not in self.throughput_test_parameters:
+            raise SkippedTestException("test not configured")
+        app = Cryptodev(
+            ptest=TestType.throughput,
+            devtype=self.driver,
+            optype=OperationType.aead,
+            aead_algo=AeadAlgName.aes_gcm,
+            aead_op=EncryptDecryptSwitch.encrypt,
+            aead_key_sz=16,
+            aead_iv_sz=12,
+            aead_aad_sz=16,
+            digest_sz=16,
+            total_ops=TOTAL_OPS,
+            buffer_sz=self.buffer_sizes["aead_aes_gcm"],
+        )
+        results = self._verify_throughput(app.run_app(), "aead_aes_gcm")
+        self._print_stats(results)
+        for result in results:
+            verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
+
+    @func_test
+    def aes_docsisbpi(self) -> None:
+        """aes_docsisbpi test.
+
+        Steps:
+            * Create a cryptodev instance with provided driver and buffer sizes.
+        Verify:
+            * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
+
+        Raises:
+            SkippedTestException: When configuration is not provided.
+        """
+        if "aes_docsisbpi" not in self.throughput_test_parameters:
+            raise SkippedTestException("test not configured")
+        app = Cryptodev(
+            ptest=TestType.throughput,
+            devtype=self.driver,
+            optype=OperationType.cipher_only,
+            cipher_algo=CipherAlgorithm.aes_docsisbpi,
+            cipher_op=EncryptDecryptSwitch.encrypt,
+            cipher_key_sz=32,
+            cipher_iv_sz=16,
+            total_ops=TOTAL_OPS,
+            buffer_sz=self.buffer_sizes["aes_docsisbpi"],
+        )
+        results = self._verify_throughput(app.run_app(), "aes_docsisbpi")
+        self._print_stats(results)
+        for result in results:
+            verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
+
+    @crypto_test
+    def sha1_hmac(self) -> None:
+        """sha1_hmac test.
+
+        Steps:
+            * Create a cryptodev instance with provided driver and buffer sizes.
+        Verify:
+            * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
+
+        Raises:
+            SkippedTestException: When configuration is not provided.
+        """
+        if "sha1_hmac" not in self.throughput_test_parameters:
+            raise SkippedTestException("test not configured")
+        app = Cryptodev(
+            ptest=TestType.throughput,
+            devtype=self.driver,
+            optype=OperationType.auth_only,
+            auth_algo=AuthenticationAlgorithm.sha1_hmac,
+            auth_op=AuthenticationOpMode.generate,
+            auth_key_sz=64,
+            auth_iv_sz=16,
+            digest_sz=12,
+            total_ops=TOTAL_OPS,
+            buffer_sz=self.buffer_sizes["sha1_hmac"],
+        )
+        results = self._verify_throughput(app.run_app(), "sha1_hmac")
+        self._print_stats(results)
+        for result in results:
+            verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
+
+    @func_test
+    def snow3g_uea2_snow3g_uia2(self) -> None:
+        """snow3g_uea2_snow3g_uia2 test.
+
+        Steps:
+            * Create a cryptodev instance with provided driver and buffer sizes.
+        Verify:
+            * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
+
+        Raises:
+            SkippedTestException: When configuration is not provided.
+        """
+        if "snow3g_uea2_snow3g_uia2" not in self.throughput_test_parameters:
+            raise SkippedTestException("test not configured")
+        app = Cryptodev(
+            ptest=TestType.throughput,
+            devtype=self.driver,
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
+        results = self._verify_throughput(app.run_app(), "snow3g_uea2_snow3g_uia2")
+        self._print_stats(results)
+        for result in results:
+            verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
+
+    @func_test
+    def zuc_eea3_zuc_eia3(self) -> None:
+        """zuc_eea3_zuc_eia3 test.
+
+        Steps:
+            * Create a cryptodev instance with provided driver and buffer sizes.
+        Verify:
+            * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
+
+        Raises:
+            SkippedTestException: When configuration is not provided.
+        """
+        if "zuc_eea3_zuc_eia3" not in self.throughput_test_parameters:
+            raise SkippedTestException("test not configured")
+        app = Cryptodev(
+            ptest=TestType.throughput,
+            devtype=self.driver,
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
+        results = self._verify_throughput(app.run_app(), "zuc_eea3_zuc_eia3")
+        self._print_stats(results)
+        for result in results:
+            verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
+
+    @func_test
+    def kasumi_f8_kasumi_f9(self) -> None:
+        """kasumi_f8 kasumi_f9 test.
+
+        Steps:
+            * Create a cryptodev instance with provided driver and buffer sizes.
+        Verify:
+            * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
+
+        Raises:
+            SkippedTestException: When configuration is not provided.
+        """
+        if "kasumi_f8_kasumi_f9" not in self.throughput_test_parameters:
+            raise SkippedTestException("test not configured")
+        app = Cryptodev(
+            ptest=TestType.throughput,
+            devtype=self.driver,
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
+        results = self._verify_throughput(app.run_app(), "kasumi_f8_kasumi_f9")
+        self._print_stats(results)
+        for result in results:
+            verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
+
+    # BEGIN VDEV TESTS
+
+
+    def aesni_mb_vdev(self) -> None:
+        """aesni_mb virtual device test.
+
+        Steps:
+            * Create a cryptodev instance with crypto_aesni_mb and supplied buffer sizes.
+        Verify:
+            * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
+
+        Raises:
+            SkippedTestException: When configuration is not provided.
+        """
+        if "aesni_mb_vdev" not in self.throughput_test_parameters:
+            raise SkippedTestException("test not configured")
+        app = Cryptodev(
+            ptest=TestType.throughput,
+            vdevs=[VirtualDevice("crypto_aesni_mb0")],
+            devtype=DeviceType.crypto_aesni_mb,
+            optype=OperationType.cipher_then_auth,
+            cipher_algo=CipherAlgorithm.aes_cbc,
+            cipher_op=EncryptDecryptSwitch.encrypt,
+            cipher_key_sz=32,
+            cipher_iv_sz=16,
+            auth_algo=AuthenticationAlgorithm.sha1_hmac,
+            auth_op=AuthenticationOpMode.generate,
+            auth_key_sz=16,
+            auth_iv_sz=16,
+            digest_sz=4,
+            burst_sz=32,
+            total_ops=TOTAL_OPS,
+            buffer_sz=self.buffer_sizes["aesni_mb_vdev"],
+        )
+        results = self._verify_throughput(app.run_app(), "aesni_mb_vdev")
+        self._print_stats(results)
+        for result in results:
+            verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
+
+    @func_test
+    def aesni_gcm_vdev(self):
+        """aesni_gcm virtual device test.
+
+        Steps:
+            * Create a cryptodev instance with crypto_aesni_gcm and supplied buffer sizes.
+        Verify:
+            * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
+
+        Raises:
+            SkippedTestException: When configuration is not provided.
+        """
+        if "aesni_gcm_vdev" not in self.throughput_test_parameters:
+            raise SkippedTestException("test not configured")
+        app = Cryptodev(
+            ptest=TestType.throughput,
+            vdevs=[VirtualDevice("crypto_aesni_gcm0")],
+            devtype=DeviceType.crypto_aesni_gcm,
+            optype=OperationType.aead,
+            aead_algo=AeadAlgName.aes_gcm,
+            aead_op=EncryptDecryptSwitch.encrypt,
+            aead_key_sz=16,
+            aead_iv_sz=12,
+            aead_aad_sz=16,
+            digest_sz=16,
+            total_ops=TOTAL_OPS,
+            buffer_sz=self.buffer_sizes["aesni_gcm_vdev"],
+        )
+        results = self._verify_throughput(app.run_app(), "aesni_gcm_vdev")
+        self._print_stats(results)
+        for result in results:
+            verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
+
+    @func_test
+    def kasumi_vdev(self) -> None:
+        """Kasmumi virtual device test.
+
+        Steps:
+            * Create a cryptodev instance with crypto_kasumi and supplied buffer sizes.
+        Verify:
+            * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
+
+        Raises:
+            SkippedTestException: When configuration is not provided.
+        """
+        if "kasumi_vdev" not in self.throughput_test_parameters:
+            raise SkippedTestException("test not configured")
+        app = Cryptodev(
+            vdevs=[VirtualDevice("crypto_kasumi0")],
+            ptest=TestType.throughput,
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
+        results = self._verify_throughput(app.run_app(), "kasumi_vdev")
+        self._print_stats(results)
+        for result in results:
+            verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
+
+    @func_test
+    def snow3g_vdev(self) -> None:
+        """snow3g virtual device test.
+
+        Steps:
+            * Create a cryptodev instance with crypto_snow3g and supplied buffer sizes.
+        Verify:
+            * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
+
+        Raises:
+            SkippedTestException: When configuration is not provided.
+        """
+        if "snow3g_vdev" not in self.throughput_test_parameters:
+            raise SkippedTestException("test not configured")
+        app = Cryptodev(
+            ptest=TestType.throughput,
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
+            digest_sz=4,
+            burst_sz=32,
+            total_ops=TOTAL_OPS,
+            buffer_sz=self.buffer_sizes["snow3g_vdev"],
+        )
+        results = self._verify_throughput(app.run_app(), "snow3g_vdev")
+        self._print_stats(results)
+        for result in results:
+            verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
+
+    @func_test
+    def zuc_vdev(self) -> None:
+        """Zuc virtual device test.
+
+        Steps:
+            * Create a cryptodev instance with crypto_zuc and supplied buffer sizes.
+        Verify:
+            * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
+
+        Raises:
+            SkippedTestException: When configuration is not provided.
+        """
+        if "zuc_vdev" not in self.throughput_test_parameters:
+            raise SkippedTestException("test not configured")
+        app = Cryptodev(
+            ptest=TestType.throughput,
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
+        results = self._verify_throughput(app.run_app(), "zuc_vdev")
+        self._print_stats(results)
+        for result in results:
+            verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
+
+    @func_test
+    def open_ssl_vdev(self) -> None:
+        """open_ssl virtual device test.
+
+        Steps:
+            * Create a cryptodev instance with provided driver and buffer sizes.
+        Verify:
+            * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
+
+        Raises:
+            SkippedTestException: When configuration is not provided.
+        """
+        if "open_ssl_vdev" not in self.throughput_test_parameters:
+            raise SkippedTestException("test not configured")
+        app = Cryptodev(
+            ptest=TestType.throughput,
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
+        results = self._verify_throughput(app.run_app(), "open_ssl_vdev")
+        self._print_stats(results)
+        for result in results:
+            verify(
+                result["passed"] == "PASS",
+                "Gbps fell below delta tolerance",
+            )
-- 
2.50.1

