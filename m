Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6641FCB622
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 16:41:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C45542797;
	Fri,  6 Mar 2026 17:40:38 +0100 (CET)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by mails.dpdk.org (Postfix) with ESMTP id E90734270A
 for <dev@dpdk.org>; Fri,  6 Mar 2026 17:40:36 +0100 (CET)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-8cb39647a70so908073985a.0
 for <dev@dpdk.org>; Fri, 06 Mar 2026 08:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1772815236; x=1773420036; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2qx2HbAbXlVPKnh2L9feratfVN6TWvzI8TqDvIL1U1Y=;
 b=Y/f66rSRzCqcIzg9wLa8fxUU0MQU19gjJBLIyUeYBSV+STQPwlZBjfvrcLDgpeuNF1
 TeOP3qGBczpGr9rTUbcTllrrCapFRGpyqdEL0dyXUZgr6HDS8MHXRHfzju5QmzGyNX+l
 +AfzkKrWMXByhL7GeGgviz3qEMDlrJ8Xk6OQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772815236; x=1773420036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2qx2HbAbXlVPKnh2L9feratfVN6TWvzI8TqDvIL1U1Y=;
 b=RaJl9BDIxb7MQAgxXj1I90GPDnLW+y3wQ19QoDLX+RXoB3LaAP597kEeTsEA9TdTmk
 pj8CxilLf75oYkw/8v3SzAWm2N5U7EpShM80MRFP6vupWD14mbBfDi09vwsPjPzMB2LC
 SAuRhrxv0cSJZvY2lmPk9Jn4ffwnpypDzZ3Ut9EfWMYA+SnutRMkQ0RGfNr9REyIYn/e
 f7rQsZ7R896zK6MOtj8yMS/Fnz/Zy1SsQhdLLiFWtAhovxOnct45ZEqa0Om+TL/g1PuM
 yZRPoZMJCykh25Q9Wk7zo6JUFNs5RFof3K7QWPfmkKW3XAFHPvHNYGy0Q53SJ8W2Iko3
 07gQ==
X-Gm-Message-State: AOJu0Yz4zPOCcrPvAEVI/ETKYGZ3Fu3zYg1EbO8AvK0vBjtnD3VzZy5j
 6pY6P6fi2uShOL68hUWmFzSmtwWpYZ8GZJtU0LHblwdoxPJz5M9HJylDa/WitTssYOI=
X-Gm-Gg: ATEYQzwvfl6JyofSNuaeGkOinwoSph8ccO31KlCSUHDFfBpfn4Mxm0Ua2bwdBgmL7+t
 oi49rZnjLGxk2NiVsYqSpHl6s1Ek4JTFzfQwFpFW0ZHHhTxEd/mnN7xa57D9mXsEL+9SH1TKURc
 pDFFcMuEh1Nx4de9bEttsUFJC3Nco0sjV2vz42yQRzF6qcYrluMJoXLyae+0yO3COY2tEcg/jQf
 6HWGfg2Zt4P1uBM3A36nKexjockHL4kO573u9XnhEP6phZBzs7uTRE7MCIP4/4nSLC7nIZIVUyg
 is3/IPUo4BfZl8IssoUteJp+dg9tXABPwH/rAimSS1DcyF4RIhU8sjMd5PFNFmZjIJ1MXg+t7Uk
 T7qZzsT+irJvBDABX0B5HdrLrSxEy/W+mn3akcmGeEY5r4wkXeU8uV4Z+mtXRC/QqnaUe6ZsPSl
 CyWjdMsl+57MPuMRTYfbIDSnc8Tmvnfe16PQ+u1bXfgQvuQtPMAF1fc20EXMLCssfrQMIXFkii4
 3Y=
X-Received: by 2002:a05:620a:414c:b0:8ca:4288:b158 with SMTP id
 af79cd13be357-8cd6d4fae41mr375634685a.43.1772815236043; 
 Fri, 06 Mar 2026 08:40:36 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd6f566fd5sm144608185a.43.2026.03.06.08.40.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 08:40:35 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: probb@iol.unh.edu
Cc: dev@dpdk.org, luca.vizzarro@arm.com, dmarx@iol.unh.edu, kai.ji@intel.com,
 dharmikjayesh.thakkar@arm.com, david.marchand@redhat.com,
 gakhil@marvell.com, Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v5 4/5] dts: add cryptodev throughput test suite
Date: Fri,  6 Mar 2026 11:40:26 -0500
Message-ID: <20260306164027.171723-5-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306164027.171723-1-abailey@iol.unh.edu>
References: <20260210193448.69423-1-abailey@iol.unh.edu>
 <20260306164027.171723-1-abailey@iol.unh.edu>
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
index 39e96660a5..209d7dd393 100644
--- a/dts/configurations/tests_config.example.yaml
+++ b/dts/configurations/tests_config.example.yaml
@@ -22,3 +22,11 @@ hello_world:
 #   NUM_QUEUES: 4
 #   ACTUAL_KEY_SIZE: 52
 #   ACTUAL_RETA_SIZE: 512
+# cryptodev_throughput:
+#   delta_tolerance: 0.05
+#   throughput_test_parameters:
+#     snow3g_uea2_snow3g_uia2: # Add the name of the test suite you would like to run
+#      - buff_size: 64
+#        Gbps: 2.0 # Set gigabits per second according to your devices throughput for this given buffer size
+#      - buff_size: 512
+#        Gbps: 20.0
\ No newline at end of file
diff --git a/dts/tests/TestSuite_cryptodev_throughput.py b/dts/tests/TestSuite_cryptodev_throughput.py
new file mode 100644
index 0000000000..638a52ac74
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
+        self.device_type: DeviceType | None = get_device_from_str(
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
+            * Create a cryptodev instance with provided device type and buffer sizes.
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
+            devtype=self.device_type,
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
+            * Create a cryptodev instance with provided device type and buffer sizes.
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
+            devtype=self.device_type,
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
+            * Create a cryptodev instance with provided device type and buffer sizes.
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
+            * Create a cryptodev instance with provided device type and buffer sizes.
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
+            devtype=self.device_type,
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
+            * Create a cryptodev instance with provided device type and buffer sizes.
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
+            devtype=self.device_type,
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
+            * Create a cryptodev instance with provided device type and buffer sizes.
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
+            devtype=self.device_type,
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
+            * Create a cryptodev instance with provided device type and buffer sizes.
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
+            devtype=self.device_type,
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
+            * Create a cryptodev instance with provided device type and buffer sizes.
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
+            * Create a cryptodev instance with provided device type and buffer sizes.
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
+            * Create a cryptodev instance with provided device type and buffer sizes.
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
+        results = self._verify_throughput(app.run_app(num_vfs=0), "aesni_mb_vdev")
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
+        results = self._verify_throughput(app.run_app(num_vfs=0), "aesni_gcm_vdev")
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
+        results = self._verify_throughput(app.run_app(num_vfs=0), "kasumi_vdev")
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
+        results = self._verify_throughput(app.run_app(num_vfs=0), "snow3g_vdev")
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
+        results = self._verify_throughput(app.run_app(num_vfs=0), "zuc_vdev")
+        self._print_stats(results)
+        for result in results:
+            verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
+
+    @func_test
+    def open_ssl_vdev(self) -> None:
+        """open_ssl virtual device test.
+
+        Steps:
+            * Create a cryptodev instance with provided device type and buffer sizes.
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
+        results = self._verify_throughput(app.run_app(num_vfs=0), "open_ssl_vdev")
+        self._print_stats(results)
+        for result in results:
+            verify(
+                result["passed"] == "PASS",
+                "Gbps fell below delta tolerance",
+            )
-- 
2.50.1

