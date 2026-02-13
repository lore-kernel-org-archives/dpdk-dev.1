Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72F0EF99D2
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 19:36:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90A2840674;
	Fri, 13 Feb 2026 20:36:05 +0100 (CET)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by mails.dpdk.org (Postfix) with ESMTP id 4C57140653
 for <dev@dpdk.org>; Fri, 13 Feb 2026 20:36:02 +0100 (CET)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-8cb382f5c0bso138642485a.2
 for <dev@dpdk.org>; Fri, 13 Feb 2026 11:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1771011361; x=1771616161; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zFajDyYysxReDGCEBQMNUxxdy8I1jy10vRHuvJCPmzg=;
 b=i2CP3KeF950uR2i7RH9UNmfFNjmmi7nuUj+kJHFdC2Yh19eE1YjwDg/6DLS7mAKF0w
 NjG2hhxsbJVrU1UzFYOyo2gWfmbZuHWXBBX92l0TpGVll95q43CkWPN9FoEL0rQ4HDh0
 +PXPgZkAe1IUEe12wvvTyyHEm0jgJjXgNFcb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771011361; x=1771616161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zFajDyYysxReDGCEBQMNUxxdy8I1jy10vRHuvJCPmzg=;
 b=Q6LF0LScNDEj+6rKIa1E6ZahTilDThthbR2hdyIN5NrdCEDWk6nKN/7Z/kNU3pABZE
 uBum2UykEXMavVn4mJuFoqMXN0VGbXvlNXXdIAVxAV7RjKPjYVejnxTLcUykq1aYNK35
 qZ4tZywNjPPpOOEYpybgrJKhFN3lrui8WWW+mkGfaOH8PXkmXv7R7vNF2dtrQdPWjF35
 cyRb8cWrdbulCr0XACtL7svFlozmqyv5iu+aeCbfo/EeSOTQ2/Fpx/1Q7S/p88BSRAwv
 5X9JntI//9wwtN4jxOYQOWgz99aNdM0sa2tMY5K2pAumT1q4W4ieAOVZKG9upSRTWAfl
 vJtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNRX1C1iNuc6ks8T2B/LYKbapUnzhEp/B854zAXbtrcfNv5i091K3tE98YM1C+FI+wFis=@dpdk.org
X-Gm-Message-State: AOJu0YxNArMs2XPXhxLSby+qidNCYuDSeHKMvMMF0xT5rPvU6p+okOQE
 QoP9mCZxJt4HYJtkq4FjL5+9fpqhV2ARHNRD/EqPRkhhUYE3OPbt3zcnbUwBRsRJbt897g006Yt
 IPO2y
X-Gm-Gg: AZuq6aIntEZznhnojMOqwkbwgk8M4n1zn7fE9Mtjy5DDrIsU6X0KDBjzBVy9yD1M9LN
 vMT1UalnHDazSySkW3FaDVTtQAPPhz1E6sBPq2gBahzrZoe5QVwaPOlrUuB7uY40t4r/3Rg3wyj
 htDhzAi4K4kbpDi2r17ld5IHVOsdmOgASDcEq5tc98yeyAq0Yo0auCHCeJGcXKMcMWEGRGL6/Ll
 BRBgqVJvcpyLerIuZIiWbTLWqk8DYKGktm95OPUWH4JEN3Xq7BItJizztFt98N7tDxqrxPrCSO2
 fFghqZ6CwowYixsCuLKl13ZnCSS+ninBRdeoKuDQNAYP565WnerXCZCghqDox3xSKVhoMwbHxFq
 cyXpPfewvbEm8ZTA5FPvWzQskG0v3I2zEwsvjSjUO/90c/maPFGXf/7/lc/txjLMIXmkMDYTbfg
 oH6H0i++tpG8zElqTBWJSD5zc8kHzE/6e1JZX0UFYUu0yB9f0mW9uTt40NjF9Gg2g/Z7x7+RBED
 Y8=
X-Received: by 2002:a05:620a:4608:b0:8ca:4288:b175 with SMTP id
 af79cd13be357-8cb4242a549mr364408085a.55.1771011361329; 
 Fri, 13 Feb 2026 11:36:01 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cb45f13a61sm146726085a.7.2026.02.13.11.36.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 11:36:00 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com,
	probb@iol.unh.edu
Cc: dmarx@iol.unh.edu,
	dev@dpdk.org,
	Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v3 3/5] dts: add cryptodev throughput test suite
Date: Fri, 13 Feb 2026 14:35:37 -0500
Message-ID: <20260213193539.103858-4-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260213193539.103858-1-abailey@iol.unh.edu>
References: <20260210193448.69423-1-abailey@iol.unh.edu>
 <20260213193539.103858-1-abailey@iol.unh.edu>
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
 dts/tests/TestSuite_cryptodev_throughput.py   | 690 ++++++++++++++++++
 3 files changed, 706 insertions(+)
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
index 0000000000..871e47ae63
--- /dev/null
+++ b/dts/tests/TestSuite_cryptodev_throughput.py
@@ -0,0 +1,690 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 University of New Hampshire
+
+"""DPDK cryptodev performance test suite.
+
+The main goal of this testsuite is to utilize the dpdk-test-cryptodev application to gather
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
+    {"buff_size": 64, "gbps": 1.00},
+    {"buff_size": 512, "gbps": 1.00},
+    {"buff_size": 2048, "gbps": 1.00},
+]
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
+        device: DeviceType | None = get_device_from_str(str(get_ctx().sut_node.crypto_driver))
+        self.driver: DeviceType = device if device else DeviceType.crypto_qat
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
+            result_dict = {}
+            parameters: dict[str, int | float | str] = list(
+                filter(
+                    lambda x: x["buff_size"] == result.buffer_size,
+                    self.throughput_test_parameters[key],
+                )
+            )[0]
+            test_result = True
+            for arg, target_val in parameters.items():
+                match arg:
+                    case "buff_size":
+                        result_dict["Buffer Size"] = target_val
+                        continue
+                    case "gbps":
+                        # result did not meet the given gbps parameter, check if within delta.
+                        if target_val > getattr(result, "gbps"):
+                            delta = round((1 - (getattr(result, "gbps") / target_val)), 5)
+                            if delta > self.delta_tolerance:
+                                test_result = False
+                        else:
+                            delta = round((1 - target_val / getattr(result, arg)), 5)
+                        result_dict["gbps delta"] = delta
+                        result_dict["delta tolerance"] = self.delta_tolerance
+                        result_dict["gbps"] = getattr(result, "gbps")
+                        result_dict["gbps target"] = target_val
+            result_dict["passed"] = "PASS" if test_result else "FAIL"
+            result_list.append(result_dict)
+        return result_list
+
+    @func_test
+    def aes_cbc(self) -> None:
+        """aes_cbc test.
+
+        Steps:
+            * Create a cryptodev instance with provided driver and buffer sizes.
+        Verify:
+            * The resulting gbps is greater than expected_gbps*(1-delta_tolerance).
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
+            total_ops=10_000_000,
+            buffer_sz=self.buffer_sizes["aes_cbc"],
+        )
+        results = self._verify_throughput(app.run_app(), "aes_cbc")
+        self._print_stats(results)
+        for result in results:
+            verify(result["passed"] == "PASS", "gbps fell below delta tolerance")
+
+    def aes_cbc_sha1(self) -> None:
+        """aes_cbc_sha1 test.
+
+        Steps:
+            * Create a cryptodev instance with provided driver and buffer sizes.
+        Verify:
+            * The resulting gbps is greater than expected_gbps*(1-delta_tolerance).
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
+            total_ops=10_000_000,
+            buffer_sz=self.buffer_sizes["aes_cbc_sha1"],
+        )
+        results = self._verify_throughput(app.run_app(), "aes_cbc_sha1")
+        self._print_stats(results)
+        for result in results:
+            verify(result["passed"] == "PASS", "gbps fell below delta tolerance")
+
+    def aes_cbc_sha2(self) -> None:
+        """aes_cbc_sha2 test.
+
+        Steps:
+            * Create a cryptodev instance with provided driver and buffer sizes.
+        Verify:
+            * The resulting gbps is greater than expected_gbps*(1-delta_tolerance).
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
+            total_ops=10_000_000,
+            buffer_sz=self.buffer_sizes["aes_cbc_sha2"],
+        )
+        results = self._verify_throughput(app.run_app(), "aes_cbc_sha2")
+        self._print_stats(results)
+        for result in results:
+            verify(result["passed"] == "PASS", "gbps fell below delta tolerance")
+
+    @func_test
+    def aes_cbc_sha2_digest_16(self) -> None:
+        """aes_cbc_sha2_digest_16 test.
+
+        Steps:
+            * Create a cryptodev instance with provided driver and buffer sizes.
+        Verify:
+            * The resulting gbps is greater than expected_gbps*(1-delta_tolerance).
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
+            total_ops=10_000_000,
+            buffer_sz=self.buffer_sizes["aes_cbc_sha2_digest_16"],
+        )
+        results = self._verify_throughput(app.run_app(), "aes_cbc_sha2_digest_16")
+        self._print_stats(results)
+        for result in results:
+            verify(result["passed"] == "PASS", "gbps fell below delta tolerance")
+
+    @func_test
+    def aead_aes_gcm(self) -> None:
+        """aead_aes_gcm test.
+
+        Steps:
+            * Create a cryptodev instance with provided driver and buffer sizes.
+        Verify:
+            * The resulting gbps is greater than expected_gbps*(1-delta_tolerance).
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
+            total_ops=10_000_000,
+            buffer_sz=self.buffer_sizes["aead_aes_gcm"],
+        )
+        results = self._verify_throughput(app.run_app(), "aead_aes_gcm")
+        self._print_stats(results)
+        for result in results:
+            verify(result["passed"] == "PASS", "gbps fell below delta tolerance")
+
+    @func_test
+    def aes_docsisbpi(self) -> None:
+        """aes_docsiscpi test.
+
+        Steps:
+            * Create a cryptodev instance with provided driver and buffer sizes.
+        Verify:
+            * The resulting gbps is greater than expected_gbps*(1-delta_tolerance).
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
+            total_ops=10_000_000,
+            buffer_sz=self.buffer_sizes["aes_docsisbpi"],
+        )
+        results = self._verify_throughput(app.run_app(), "aes_docsisbpi")
+        self._print_stats(results)
+        for result in results:
+            verify(result["passed"] == "PASS", "gbps fell below delta tolerance")
+
+    @crypto_test
+    def sha1_hmac(self) -> None:
+        """sha1_hmac test.
+
+        Steps:
+            * Create a cryptodev instance with provided driver and buffer sizes.
+        Verify:
+            * The resulting gbps is greater than expected_gbps*(1-delta_tolerance).
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
+            total_ops=10_000_000,
+            buffer_sz=self.buffer_sizes["sha1_hmac"],
+        )
+        results = self._verify_throughput(app.run_app(), "sha1_hmac")
+        self._print_stats(results)
+        for result in results:
+            verify(result["passed"] == "PASS", "gbps fell below delta tolerance")
+
+    @func_test
+    def snow3g_uea2_snow3g_uia2(self) -> None:
+        """snow3g_uea2_snow3g_uia2 test.
+
+        Steps:
+            * Create a cryptodev instance with provided driver and buffer sizes.
+        Verify:
+            * The resulting gbps is greater than expected_gbps*(1-delta_tolerance).
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
+            total_ops=10_000_000,
+            buffer_sz=self.buffer_sizes["snow3g_uea2_snow3g_uia2"],
+        )
+        results = self._verify_throughput(app.run_app(), "snow3g_uea2_snow3g_uia2")
+        self._print_stats(results)
+        for result in results:
+            verify(result["passed"] == "PASS", "gbps fell below delta tolerance")
+
+    @func_test
+    def zuc_eea3_zuc_eia3(self) -> None:
+        """zuc_eea3_zuc_eia3 test.
+
+        Steps:
+            * Create a cryptodev instance with provided driver and buffer sizes.
+        Verify:
+            * The resulting gbps is greater than expected_gbps*(1-delta_tolerance).
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
+            total_ops=10_000_000,
+            buffer_sz=self.buffer_sizes["zuc_eea3_zuc_eia3"],
+        )
+        results = self._verify_throughput(app.run_app(), "zuc_eea3_zuc_eia3")
+        self._print_stats(results)
+        for result in results:
+            verify(result["passed"] == "PASS", "gbps fell below delta tolerance")
+
+    @func_test
+    def kasumi_f8_kasumi_f9(self) -> None:
+        """kasumi_f8 kasumi_f9 test.
+
+        Steps:
+            * Create a cryptodev instance with provided driver and buffer sizes.
+        Verify:
+            * The resulting gbps is greater than expected_gbps*(1-delta_tolerance).
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
+            total_ops=10_000_000,
+            buffer_sz=self.buffer_sizes["kasumi_f8_kasumi_f9"],
+        )
+        results = self._verify_throughput(app.run_app(), "kasumi_f8_kasumi_f9")
+        self._print_stats(results)
+        for result in results:
+            verify(result["passed"] == "PASS", "gbps fell below delta tolerance")
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
+            * The resulting gbps is greater than expected_gbps*(1-delta_tolerance).
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
+            total_ops=10_000_000,
+            buffer_sz=self.buffer_sizes["aesni_mb_vdev"],
+        )
+        results = self._verify_throughput(app.run_app(), "aesni_mb_vdev")
+        self._print_stats(results)
+        for result in results:
+            verify(result["passed"] == "PASS", "gbps fell below delta tolerance")
+
+    @func_test
+    def aesni_gcm_vdev(self):
+        """aesni_gcm virtual device test.
+
+        Steps:
+            * Create a cryptodev instance with crypto_aesni_gcm and supplied buffer sizes.
+        Verify:
+            * The resulting gbps is greater than expected_gbps*(1-delta_tolerance).
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
+            total_ops=10_000_000,
+            buffer_sz=self.buffer_sizes["aesni_gcm_vdev"],
+        )
+        results = self._verify_throughput(app.run_app(), "aesni_gcm_vdev")
+        self._print_stats(results)
+        for result in results:
+            verify(result["passed"] == "PASS", "gbps fell below delta tolerance")
+
+    @func_test
+    def kasumi_vdev(self) -> None:
+        """Kasmumi virtual device test.
+
+        Steps:
+            * Create a cryptodev instance with crypto_kasumi and supplied buffer sizes.
+        Verify:
+            * The resulting gbps is greater than expected_gbps*(1-delta_tolerance).
+
+        Raises:
+            SkippedTestException: When configuration is not provided.
+        """
+        if "kasumi_vdev" not in self.throughput_test_parameters:
+            raise SkippedTestException("test not configured")
+        app = Cryptodev(
+            vdevs=[VirtualDevice("crypto_kasumi0")],
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
+            burst_sz=32,
+            total_ops=10_000_000,
+            buffer_sz=self.buffer_sizes["kasumi_vdev"],
+        )
+        results = self._verify_throughput(app.run_app(), "kasumi_vdev")
+        self._print_stats(results)
+        for result in results:
+            verify(result["passed"] == "PASS", "gbps fell below delta tolerance")
+
+    @func_test
+    def snow3g_vdev(self) -> None:
+        """snow3g virtual device test.
+
+        Steps:
+            * Create a cryptodev instance with crypto_snow3g and supplied buffer sizes.
+        Verify:
+            * The resulting gbps is greater than expected_gbps*(1-delta_tolerance).
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
+            total_ops=10_000_000,
+            buffer_sz=self.buffer_sizes["snow3g_vdev"],
+        )
+        results = self._verify_throughput(app.run_app(), "snow3g_vdev")
+        self._print_stats(results)
+        for result in results:
+            verify(result["passed"] == "PASS", "gpbs fell below delta tolerance")
+
+    @func_test
+    def zuc_vdev(self) -> None:
+        """Zuc virtual device test.
+
+        Steps:
+            * Create a cryptodev instance with crypto_zuc and supplied buffer sizes.
+        Verify:
+            * The resulting gbps is greater than expected_gbps*(1-delta_tolerance).
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
+            total_ops=10_000_000,
+            buffer_sz=self.buffer_sizes["zuc_vdev"],
+        )
+        results = self._verify_throughput(app.run_app(), "zuc_vdev")
+        self._print_stats(results)
+        for result in results:
+            verify(result["passed"] == "PASS", "gpbs fell below delta tolerance")
+
+    @func_test
+    def open_ssl_vdev(self) -> None:
+        """open_ssl virtual device test.
+
+        Steps:
+            * Create a cryptodev instance with provided driver and buffer sizes.
+        Verify:
+            * The resulting gbps is greater than expected_gbps*(1-delta_tolerance).
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
+            total_ops=100_000,
+            buffer_sz=self.buffer_sizes["open_ssl_vdev"],
+        )
+        results = self._verify_throughput(app.run_app(), "open_ssl_vdev")
+        self._print_stats(results)
+        for result in results:
+            verify(
+                result["passed"] == "PASS",
+                "gbps fell below delta tolerance",
+            )
-- 
2.50.1

