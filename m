Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13E0CA5FA2
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 18:06:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C91A040E24;
	Mon, 28 Sep 2026 20:06:30 +0200 (CEST)
Received: from mail-qv2-f43.google.com (mail-qv2-f43.google.com
 [74.125.230.171])
 by mails.dpdk.org (Postfix) with ESMTP id D7D9040DDD
 for <dev@dpdk.org>; Mon, 28 Sep 2026 20:06:28 +0200 (CEST)
Received: by mail-qv2-f43.google.com with SMTP id
 6a1803df08f44-914446005e8so23648116d6.0
 for <dev@dpdk.org>; Mon, 28 Sep 2026 11:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1790618788; x=1791223588; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E9UjTCanECbu2SA6uWLTdAMXGjVFJ6HJ9012iYf/tKM=;
 b=ZWBgJjVMikoejZTqNissFiLBhilbRhf3lqOsshPvu9ySfhENu9yx1wXc2VL6JRzYTh
 RclHyt0bwpbVRLAcczxSGkbIQhRDvUTN0dQzIpyBWpSFQSxgtDSKjKPEYUAUUnwTnFOu
 CRhxgk4lwDjSb9PLwGvfRDhUZ9kwhbiaxApyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790618788; x=1791223588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=E9UjTCanECbu2SA6uWLTdAMXGjVFJ6HJ9012iYf/tKM=;
 b=vSEEJGBNKHDFCQ4AxkDnRUCi75bS1JdYAW7Gh8MzmLXtjuoTSgCCgHdx95+Ol2SnA+
 tIGCtoG//+Y2YLkOt+RCJHolB27cPgd5nuYrnSR9hwRxTgtxtE8c+ZP5T6/4/Xu8igBR
 IYon457ps1HclAvFtD9s8qXPsMDfFdOH4FlBuAfX+WXbDoElMUK7vgpDAMF/ydgqw5/0
 cnfKYI6KBDY1gK3i9bXtrEMQ5WayidTeTus01T2hhFFgKlALVRDFIXxZUFex0GFdE3Ff
 jpdpa455zyux7PQQRalUf7KDUMJHsspDvEkdDsX8wIB3ecJ4qGpGKptjC12RXZ/WcmqG
 nRIA==
X-Gm-Message-State: AFuF++lKBvIk006q5HrjVue3yQ9Z8xl9J7J2cXcwU32HsoPhjzuQsHne
 pxExap1UaAV4uhzkv+335NzJ6yUSRZoReynZXgpkI0xAscCslO6vtMy7+A5nGphJj/pBQ7IFM9d
 4g1L0A+56gq0/XSVzKYf0mTjXf9h1URvXM89roufNV6UmEX4yKsitqEt3/i63N7VnQ3HANb8YDU
 OcuWVia2hLnqXlzXoM3uwLqyWvzhM=
X-Gm-Gg: AYBFou3lOz6VNlk5lZJ5Pp348WWFG43GS9Q7+hlOy+bAUuV2AZKxoENi45qm4QUMFC8
 zG/etCxizY9v6MdErpxscFRaQ/OoAnuDsEw7rAd9Vxoapx3SwC8yvXztNCf5D1mgOoiKrk4WTAg
 hfSMk+KMt//1DjAu1qWfU9IFCifSdje6Q19uzR1BuLQBbYx0Nu3MuyUMP35qvV0t6x5Aw+VwVcB
 8/LwBO0CF2Ww+a1iWXxTAwI15YDqw9BxvJogIrDTpLaW8sR0iYfSCnW4L+Y7zk9lN9DUeviG8te
 /118JzMoMcXSB6qSLBQvOO2HWY0gczHHoeIX7/vZYqHfGHoC5PhAcueAEhWQN/Mb+c+hNvcduqG
 0Wz45Mo1tX1pHhQK6mvOftWX2j/6d8kabGjGPvJ+v1yAX6c32zaVE6c/XnwG3MalP1cDzXRh+hU
 6jxFw9Wh6/QGASBTRSRSiIyCMIwKh53akps9aYXchXhsvRjTGqr4qIh1xpSH8AYEFcd0h08oKFW
 eyrOHHA25kHsJeeuVpI
X-Received: by 2002:a05:620a:1a1e:b0:93c:6467:2b9e with SMTP id
 af79cd13be357-93c64672dc0mr1344413585a.24.1790618787093; 
 Mon, 28 Sep 2026 11:06:27 -0700 (PDT)
Received: from d121029.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c8141617bsm206987285a.25.2026.09.28.11.06.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 11:06:26 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v2 2/2] dts: refactor cryptodev latency test suite
Date: Mon, 28 Sep 2026 14:06:10 -0400
Message-ID: <20260928180610.224307-2-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928180610.224307-1-abailey@iol.unh.edu>
References: <20260827172208.139769-1-abailey@iol.unh.edu>
 <20260928180610.224307-1-abailey@iol.unh.edu>
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

Previously, cryptodev latency testing only covered a handful of
algorithm combinations and virtual device types for testing. The new
implementation makes this test completely configurable to run any
combination of arguments provided through the tests configuration file.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/configurations/tests_config.example.yaml |   17 +
 dts/tests/TestSuite_cryptodev_latency.py     | 1044 ++++++++----------
 2 files changed, 481 insertions(+), 580 deletions(-)

diff --git a/dts/configurations/tests_config.example.yaml b/dts/configurations/tests_config.example.yaml
index fe4bed2847..450a6cc5e7 100644
--- a/dts/configurations/tests_config.example.yaml
+++ b/dts/configurations/tests_config.example.yaml
@@ -66,6 +66,23 @@ hello_world:
 #         - buff_size: 64
 #           Gbps: 1.5
 
+# cryptodev_latency:
+#   # Identical to cryptodev_throughput configuration besides updated test_parameters below.
+#   delta_tolerance: 0.05
+#     - name: "example cipher test" # Add a name for this test config
+#       cipher_algorithm: "aes_cbc" # See `algortihms` in `Optional Fields` for a complete list
+#       virtual_device: "crypto_openssl" # uncomment to run with a virtual device.
+#       test_parameters:  # Buffer sizes and expected throughput, a default is used if not present
+#        - buff_size: 64
+#          avg_cycles: 999999
+#          avg_time_us: 999999
+#        - buff_size: 512
+#          avg_cycles: 999999
+#          avg_time_us: 999999
+#        - buff_size: 2048
+#          avg_cycles: 999999
+#          avg_time_us: 999999
+
 # port_speed_capabilities:
 #   test_parameters:
 #     0 : 100 Gbps # Assign an expected link speed to a port ID in Gbps
diff --git a/dts/tests/TestSuite_cryptodev_latency.py b/dts/tests/TestSuite_cryptodev_latency.py
index 4e7d814faa..15c00c7870 100644
--- a/dts/tests/TestSuite_cryptodev_latency.py
+++ b/dts/tests/TestSuite_cryptodev_latency.py
@@ -9,12 +9,17 @@
 ensure performance standards are met.
 """
 
+from typing import Any
+
 from api.capabilities import (
     LinkTopology,
     requires_link_topology,
 )
 from api.cryptodev import Cryptodev
 from api.cryptodev.config import (
+    AEAD_ALGORITHM_PARAMS,
+    AUTHENTICATION_ALGORITHM_PARAMS,
+    CIPHER_ALGORITHM_PARAMS,
     AeadAlgName,
     AuthenticationAlgorithm,
     AuthenticationOpMode,
@@ -29,15 +34,16 @@
 from api.cryptodev.types import (
     CryptodevResults,
 )
-from api.test import skip, verify
+from api.test import fail, skip, verify
 from framework.context import get_ctx
+from framework.exception import ConfigurationError, SkippedTestException, TestCaseVerifyError
 from framework.test_suite import BaseConfig, TestSuite, crypto_test
 from framework.testbed_model.virtual_device import VirtualDevice
 
 config_list: list[dict[str, int | float | str]] = [
-    {"buff_size": 64, "avg_cycles": 99_999.00, "avg_time_us": 9999.0},
-    {"buff_size": 512, "avg_cycles": 99_999.00, "avg_time_us": 9999.0},
-    {"buff_size": 2048, "avg_cycles": 99_999.00, "avg_time_us": 9999.0},
+    {"buff_size": 64, "avg_cycles": 999_999_999.0, "avg_time_us": 999_999_999.0},
+    {"buff_size": 512, "avg_cycles": 999_999_999.0, "avg_time_us": 999_999_999.0},
+    {"buff_size": 2048, "avg_cycles": 999_999_999.0, "avg_time_us": 999_999_999.0},
 ]
 
 TOTAL_OPS = 10_000_000
@@ -48,69 +54,191 @@ class Config(BaseConfig):
 
     Attributes:
         delta_tolerance: The allowed tolerance below a given baseline.
-        latency_test_parameters: The test parameters to use in the test suite.
+        test_combinations: List of test combinations with cipher/auth algorithms and parameters.
     """
 
     delta_tolerance: float = 0.05
-
-    latency_test_parameters: dict[str, list[dict[str, int | float | str]]] = {
-        "aes_cbc": config_list,
-        "aes_cbc_sha1_hmac": config_list,
-        "aes_cbc_sha2_hmac": config_list,
-        "aes_docsisbpi": config_list,
-        "aes_gcm": config_list,
-        "kasumi_f8_kasumi_f9": config_list,
-        "snow3g_uea2_snow3g_uia2": config_list,
-        "zuc_eea3_zuc_eia3": config_list,
-        "aesni_gcm_vdev": config_list,
-        "aesni_mb_cipher_then_auth_vdev": config_list,
-        "aesni_mb_vdev": config_list,
-        "kasumi_vdev": config_list,
-        "open_ssl_vdev": config_list,
-        "snow3g_vdev": config_list,
-        "zuc_vdev": config_list,
-    }
+    test_combinations: list[dict[str, Any]] = [
+        #: cipher only tests
+        {
+            "name": "aes-cbc",
+            "cipher_algorithm": CipherAlgorithm.aes_cbc.name,
+            "cipher_key_sz": 16,
+            "cipher_iv_sz": 16,
+            "burst_sz": 32,
+        },
+        {
+            "name": "aes-docsisbpi",
+            "cipher_algorithm": CipherAlgorithm.aes_docsisbpi.name,
+            "cipher_key_sz": 32,
+            "cipher_iv_sz": 16,
+        },
+        #: cipher then auth tests
+        {
+            "name": "aes-cbc/sha1_hmac",
+            "cipher_algorithm": CipherAlgorithm.aes_cbc.name,
+            "cipher_key_sz": 16,
+            "auth_algorithm": AuthenticationAlgorithm.sha1_hmac.name,
+            "auth_key_sz": 64,
+            "digest_sz": 12,
+            "burst_sz": 32,
+        },
+        {
+            "name": "aes-cbc/sha2_hmac",
+            "cipher_algorithm": CipherAlgorithm.aes_cbc.name,
+            "cipher_key_sz": 16,
+            "auth_algorithm": AuthenticationAlgorithm.sha2_256_hmac.name,
+            "auth_key_sz": 64,
+            "digest_sz": 32,
+            "burst_sz": 32,
+        },
+        {
+            "name": "kasumi-f8/kasumi-f9",
+            "cipher_algorithm": CipherAlgorithm.kasumi_f8.name,
+            "cipher_key_sz": 16,
+            "cipher_iv_sz": 8,
+            "auth_algorithm": AuthenticationAlgorithm.kasumi_f9.name,
+            "auth_key_sz": 16,
+            "digest_sz": 4,
+            "burst_sz": 32,
+        },
+        {
+            "name": "snow3g-uea2/snow3g-uia2",
+            "cipher_algorithm": CipherAlgorithm.snow3g_uea2.name,
+            "cipher_key_sz": 16,
+            "cipher_iv_sz": 16,
+            "auth_algorithm": AuthenticationAlgorithm.snow3g_uia2.name,
+            "auth_key_sz": 16,
+            "auth_iv_sz": 16,
+            "digest_sz": 4,
+        },
+        {
+            "name": "zuc-eea3/zuc-eia3",
+            "cipher_algorithm": CipherAlgorithm.zuc_eea3.name,
+            "cipher_key_sz": 16,
+            "cipher_iv_sz": 16,
+            "auth_algorithm": AuthenticationAlgorithm.zuc_eia3.name,
+            "auth_key_sz": 16,
+            "auth_iv_sz": 16,
+            "digest_sz": 4,
+        },
+        #: aead tests
+        {
+            "name": "aes-gcm",
+            "aead_algorithm": AeadAlgName.aes_gcm.name,
+            "aead_key_sz": 16,
+            "aead_iv_sz": 12,
+            "aead_aad_sz": 16,
+        },
+    ]
 
 
 @requires_link_topology(LinkTopology.NO_LINK)
 class TestCryptodevLatency(TestSuite):
-    """DPDK Crypto Device Testing Suite."""
+    """DPDK Crypto Device Latency Testing Suite."""
 
     config: Config
 
     def set_up_suite(self) -> None:
-        """Set up the test suite."""
-        self.latency_test_parameters: dict[str, list[dict[str, int | float | str]]] = (
-            self.config.latency_test_parameters
-        )
+        """Set up the test suite.
+
+        Raises:
+            ConfigurationError: If no tests can be derived from the provided config.
+        """
+        self.test_combinations: list[dict[str, Any]] = self.config.test_combinations
         self.delta_tolerance: float = self.config.delta_tolerance
+        self.ops: int = 10_000_000
         self.device_type: DeviceType | None = get_device_from_str(
             str(get_ctx().sut_node.crypto_device_type)
         )
-        self.buffer_sizes = {}
-
-        for k, v in self.latency_test_parameters.items():
-            self.buffer_sizes[k] = ListWrapper([int(run["buff_size"]) for run in v])
+        self.buffer_sizes: dict[str, ListWrapper] = {}
+        self.cipher_tests: list[dict[str, Any]] = []
+        self.auth_tests: list[dict[str, Any]] = []
+        self.cipher_then_auth_tests: list[dict[str, Any]] = []
+        self.aead_tests: list[dict[str, Any]] = []
+
+        for combination in self.test_combinations:
+            self.buffer_sizes[combination["name"]] = ListWrapper(
+                [int(run["buff_size"]) for run in combination.get("test_parameters", config_list)]
+            )
+            is_cipher = "cipher_algorithm" in combination
+            is_auth = "auth_algorithm" in combination
+            aead = "aead_algorithm" in combination
+
+            if is_cipher and is_auth:
+                self.cipher_then_auth_tests.append(combination)
+            elif is_cipher:
+                self.cipher_tests.append(combination)
+            elif is_auth:
+                self.auth_tests.append(combination)
+            elif aead:
+                self.aead_tests.append(combination)
+            else:
+                raise ConfigurationError(
+                    "Each test instance must contain either "
+                    "'cipher_algorithm', 'auth_algorithm', or 'aead_algorithm'"
+                )
 
     def _print_stats(self, test_vals: list[dict[str, int | float | str]]) -> None:
+        """Print the stats of the given test values in a clean format.
+
+        Args:
+            test_vals: the testing values to print
+        """
+        assert len(test_vals) > 0, "test_vals must contain at least one element"
+
         element_len = len("Avg Time us Target")
-        border_len = (element_len + 1) * (len(test_vals[0]))
+        border_len = (element_len + 1) * (len(test_vals[0]) - 1)
+        test_name = test_vals[0]["Test Name"]
 
-        print(f"{'Latency Results'.center(border_len)}\n{'=' * border_len}")
+        print(f"{f'{test_name} Latency Results'.center(border_len)}\n{'=' * border_len}")
         for k, v in test_vals[0].items():
-            print(f"|{k.title():<{element_len}}", end="")
+            if k != "Test Name":
+                print(f"|{k.title():<{element_len}}", end="")
         print(f"|\n{'=' * border_len}")
 
         for test_val in test_vals:
             for k, v in test_val.items():
-                print(f"|{v:<{element_len}}", end="")
+                if k != "Test Name":
+                    print(f"|{v:<{element_len}}", end="")
             print(f"|\n{'=' * border_len}")
 
-    def _verify_latency(
+    def _print_and_verify(self, all_results: list[list[dict[str, int | float | str]]]) -> None:
+        """Print the given results and then verify all results have passed.
+
+        Args:
+            all_results: a list of results to print and verify.
+        """
+        for results in all_results:
+            if len(results) > 0:
+                self._print_stats(test_vals=results)
+
+        for results in all_results:
+            for result in results:
+                verify(
+                    result["passed"] == "PASS",
+                    f"Gbps fell below delta tolerance for test {result['Test Name']}",
+                )
+
+    def _create_summary(
         self,
         results: list[CryptodevResults],
-        key: str,
+        params: list[dict],
+        test_name: str,
     ) -> list[dict[str, int | float | str]]:
+        """Verify the throughput of the given results against the supplied parameters.
+
+        Args:
+            results: The results of the dpdk crypto perf app ran in latency mode.
+            params: The baselines to compare the given results to.
+            test_name: The test name to pin to the result summary.
+
+        Returns:
+            A summary of latency statistics for a test and whether the test passed.
+
+        Raises:
+            RuntimeError: When there are no baselines for a given result.
+        """
         result_list: list[dict[str, int | float | str]] = []
 
         for result in results:
@@ -118,601 +246,357 @@ def _verify_latency(
             parameters: dict[str, int | float | str] = next(
                 filter(
                     lambda x: x["buff_size"] == result.buffer_size,
-                    self.latency_test_parameters[key],
+                    params,
                 ),
                 {},
             )
+            errmsg = (
+                f"No test parameters found for {test_name} with buffer size {result.buffer_size}"
+            )
             if parameters == {}:
-                raise RuntimeError(
-                    f"No test parameters found for {key} with buffer size {result.buffer_size}"
-                )
+                raise RuntimeError(errmsg)
             test_result = True
+
             expected_cycles = parameters["avg_cycles"]
-            expected_time_us = parameters["avg_time_us"]
-            measured_time_delta = abs(
-                (getattr(result, "avg_time_us") - expected_time_us) / expected_time_us
+            assert int(expected_cycles) > 0, "Expected average cycles must not be zero"
+            measured_delta_cycles = abs(
+                round((getattr(result, "avg_cycles") - expected_cycles) / expected_cycles, 5)
             )
-            measured_cycles_delta = abs(
-                (getattr(result, "avg_cycles") - expected_cycles) / expected_cycles
+            expected_time = parameters["avg_time_us"]
+            assert int(expected_time) > 0, "Expected average time must not be zero"
+            measured_delta_time = abs(
+                round((getattr(result, "avg_time_us") - expected_time) / expected_time, 5)
             )
 
-            # result did not meet the given cycles parameter, check if within delta.
+            # result did not meet the matching parameter, check if within delta.
             if getattr(result, "avg_cycles") > expected_cycles:
-                if self.delta_tolerance < measured_cycles_delta:
+                if self.delta_tolerance > measured_delta_cycles:
                     test_result = False
-            # result did not meet the given time parameter, check if within delta.
-            if getattr(result, "avg_time_us") > expected_time_us:
-                if self.delta_tolerance < measured_time_delta:
+            if getattr(result, "avg_time_us") > expected_time:
+                if self.delta_tolerance > measured_delta_time:
                     test_result = False
+
             result_list.append(
                 {
+                    "Test Name": test_name,
                     "Buffer Size": parameters["buff_size"],
                     "delta tolerance": self.delta_tolerance,
-                    "cycles delta": round(measured_cycles_delta, 5),
-                    "Avg cycles": round(getattr(result, "avg_cycles"), 5),
-                    "Avg cycles target": expected_cycles,
-                    "time delta": round(measured_time_delta, 5),
-                    "Avg time us": round(getattr(result, "avg_time_us"), 5),
-                    "Avg time us target": expected_time_us,
+                    "avg_cycles": getattr(result, "avg_cycles"),
+                    "avg_cycles target": expected_cycles,
+                    "avg_cycles delta": measured_delta_cycles,
+                    "avg_time_us": getattr(result, "avg_time_us"),
+                    "avg_time_us target": expected_time,
+                    "avg_time_us delta": measured_delta_time,
                     "passed": "PASS" if test_result else "FAIL",
                 }
             )
         return result_list
 
     @crypto_test
-    def aes_cbc(self) -> None:
-        """aes_cbc latency test.
-
-        Steps:
-            * Create a cryptodev instance with provided device type and buffer sizes.
-        Verify:
-            * The latency is below or within delta of provided baseline.
-
-        Raises:
-            SkippedTestException: When configuration is not provided.
-        """
-        if "aes_cbc" not in self.latency_test_parameters:
-            skip("test not configured")
-        app = Cryptodev(
-            ptest=TestType.latency,
-            devtype=self.device_type,
-            optype=OperationType.cipher_only,
-            cipher_algo=CipherAlgorithm.aes_cbc,
-            cipher_op=EncryptDecryptSwitch.encrypt,
-            cipher_key_sz=16,
-            cipher_iv_sz=16,
-            burst_sz=32,
-            total_ops=TOTAL_OPS,
-            buffer_sz=self.buffer_sizes["aes_cbc"],
-        )
-        results = self._verify_latency(app.run_app(), "aes_cbc")
-        self._print_stats(results)
-        for result in results:
-            verify(
-                result["passed"] == "PASS",
-                "latency was greater than the delta tolerance above baseline",
-            )
-
-    @crypto_test
-    def aes_cbc_sha1_hmac(self) -> None:
-        """aes_cbc_sha1_hmac latency test.
-
-        Steps:
-            * Create a cryptodev instance with provided device type and buffer sizes.
-        Verify:
-            * The latency is below or within delta of provided baseline.
-
-        Raises:
-            SkippedTestException: When configuration is not provided.
-        """
-        if "aes_cbc_sha1_hmac" not in self.latency_test_parameters:
-            skip("test not configured")
-        app = Cryptodev(
-            ptest=TestType.latency,
-            devtype=self.device_type,
-            optype=OperationType.cipher_then_auth,
-            cipher_algo=CipherAlgorithm.aes_cbc,
-            cipher_op=EncryptDecryptSwitch.encrypt,
-            cipher_key_sz=16,
-            auth_algo=AuthenticationAlgorithm.sha1_hmac,
-            auth_op=AuthenticationOpMode.generate,
-            auth_key_sz=64,
-            digest_sz=12,
-            burst_sz=32,
-            total_ops=TOTAL_OPS,
-            buffer_sz=self.buffer_sizes["aes_cbc_sha1_hmac"],
-        )
-        results = self._verify_latency(app.run_app(), "aes_cbc_sha1_hmac")
-        self._print_stats(results)
-        for result in results:
-            verify(
-                result["passed"] == "PASS",
-                "latency was greater than the delta tolerance above baseline",
-            )
-
-    @crypto_test
-    def aes_cbc_sha2_hmac(self) -> None:
-        """aes_cbc_sha2_hmac latency test.
+    def cipher_only_tests(self) -> None:
+        """Cipher only cryptography device tests.
 
         Steps:
-            * Create a cryptodev instance with provided device type and buffer sizes.
+            * Run dpdk-test-crypto-perf application with configured arguments in cipher only mode.
         Verify:
-            * The latency is below or within delta of provided baseline.
-
-        Raises:
-            SkippedTestException: When configuration is not provided.
+            * The reported statistics are within is within a defined tolerance of a given baseline.
         """
-        if "aes_cbc_sha2_hmac" not in self.latency_test_parameters:
-            skip("test not configured")
-        app = Cryptodev(
-            ptest=TestType.latency,
-            devtype=self.device_type,
-            optype=OperationType.cipher_then_auth,
-            cipher_algo=CipherAlgorithm.aes_cbc,
-            cipher_op=EncryptDecryptSwitch.encrypt,
-            cipher_key_sz=16,
-            cipher_iv_sz=16,
-            auth_algo=AuthenticationAlgorithm.sha2_256_hmac,
-            auth_op=AuthenticationOpMode.generate,
-            auth_key_sz=64,
-            digest_sz=32,
-            burst_sz=32,
-            total_ops=TOTAL_OPS,
-            buffer_sz=self.buffer_sizes["aes_cbc_sha2_hmac"],
-        )
-        results = self._verify_latency(app.run_app(), "aes_cbc_sha2_hmac")
-        self._print_stats(results)
-        for result in results:
-            verify(
-                result["passed"] == "PASS",
-                "latency was greater than the delta tolerance above baseline",
-            )
 
-    @crypto_test
-    def aes_docsisbpi(self) -> None:
-        """aes_docsisbpi latency test.
-
-        Steps:
-            * Create a cryptodev instance with provided device type and buffer sizes.
-        Verify:
-            * The latency is below or within delta of provided baseline.
-
-        Raises:
-            SkippedTestException: When configuration is not provided.
-        """
-        if "aes_docsisbpi" not in self.latency_test_parameters:
-            skip("test not configured")
-        app = Cryptodev(
-            ptest=TestType.latency,
-            devtype=self.device_type,
-            optype=OperationType.cipher_only,
-            cipher_algo=CipherAlgorithm.aes_docsisbpi,
-            cipher_op=EncryptDecryptSwitch.encrypt,
-            cipher_key_sz=32,
-            cipher_iv_sz=16,
-            total_ops=TOTAL_OPS,
-            buffer_sz=self.buffer_sizes["aes_docsisbpi"],
-        )
-        results = self._verify_latency(app.run_app(), "aes_docsisbpi")
-        self._print_stats(results)
-        for result in results:
-            verify(
-                result["passed"] == "PASS",
-                "latency was greater than the delta tolerance above baseline",
+        def test(encrypt: EncryptDecryptSwitch) -> list[dict[str, int | float | str]]:
+            """Run a configured throughput test with the given encryption.
+
+            Args:
+                encrypt: The cipher encryption mode to run throughput testing on.
+
+            Returns:
+                The generated summary or an empty list if a test is skipped.
+            """
+            cipher_params = CIPHER_ALGORITHM_PARAMS[
+                CipherAlgorithm[combination["cipher_algorithm"]]
+            ]
+            is_vdev = "virtual_device" in combination
+            app = Cryptodev(
+                ptest=TestType.latency,
+                devtype=self.device_type,
+                optype=OperationType.cipher_only,
+                cipher_algo=CipherAlgorithm[combination["cipher_algorithm"]],
+                cipher_op=encrypt,
+                cipher_key_sz=combination.get("cipher_key_size", cipher_params["key_size"]),
+                cipher_iv_sz=combination.get("cipher_iv_size", cipher_params["iv_size"]),
+                digest_sz=combination.get("digest_size", 0),
+                total_ops=combination.get("ops", self.ops),
+                buffer_sz=self.buffer_sizes[combination.get("name", "custom_test")],
             )
+            if is_vdev:
+                app.update_params(
+                    vdevs=[VirtualDevice(combination["virtual_device"])],
+                    devtype=get_device_from_str(combination["virtual_device"]),
+                )
 
-    @crypto_test
-    def aes_gcm(self) -> None:
-        """aes_gcm latency test.
-
-        Steps:
-            * Create a cryptodev instance with provided device type and buffer sizes.
-        Verify:
-            * The latency is below or within delta of provided baseline.
-
-        Raises:
-            SkippedTestException: When configuration is not provided.
-        """
-        if "aes_gcm" not in self.latency_test_parameters:
-            skip("test not configured")
-        app = Cryptodev(
-            ptest=TestType.latency,
-            devtype=self.device_type,
-            optype=OperationType.aead,
-            aead_algo=AeadAlgName.aes_gcm,
-            aead_op=EncryptDecryptSwitch.encrypt,
-            aead_key_sz=16,
-            aead_iv_sz=12,
-            aead_aad_sz=16,
-            digest_sz=16,
-            burst_sz=32,
-            total_ops=TOTAL_OPS,
-            buffer_sz=self.buffer_sizes["aes_gcm"],
-        )
-        results = self._verify_latency(app.run_app(), "aes_gcm")
-        self._print_stats(results)
-        for result in results:
-            verify(
-                result["passed"] == "PASS",
-                "latency was greater than the delta tolerance above baseline",
-            )
-
-    @crypto_test
-    def kasumi_f8_kasumi_f9(self) -> None:
-        """kasumi_f8_kasumi_f9 latency test.
-
-        Steps:
-            * Create a cryptodev instance with provided device type and buffer sizes.
-        Verify:
-            * The latency is below or within delta of provided baseline.
-
-        Raises:
-            SkippedTestException: When configuration is not provided.
-        """
-        if "kasumi_f8_kasumi_f9" not in self.latency_test_parameters:
-            skip("test not configured")
-        app = Cryptodev(
-            ptest=TestType.latency,
-            devtype=self.device_type,
-            optype=OperationType.cipher_then_auth,
-            cipher_algo=CipherAlgorithm.kasumi_f8,
-            cipher_op=EncryptDecryptSwitch.encrypt,
-            cipher_key_sz=16,
-            cipher_iv_sz=8,
-            auth_algo=AuthenticationAlgorithm.kasumi_f9,
-            auth_op=AuthenticationOpMode.generate,
-            auth_key_sz=16,
-            digest_sz=4,
-            burst_sz=32,
-            total_ops=TOTAL_OPS,
-            buffer_sz=self.buffer_sizes["kasumi_f8_kasumi_f9"],
-        )
-        results = self._verify_latency(app.run_app(), "kasumi_f8_kasumi_f9")
-        self._print_stats(results)
-        for result in results:
-            verify(
-                result["passed"] == "PASS",
-                "latency was greater than the delta tolerance above baseline",
-            )
+            self._logger.info(f"Running configured test: {test_name} in {encrypt} mode")
+            try:
+                return self._create_summary(
+                    results=app.run_app(num_vfs=0 if is_vdev else 1),
+                    params=combination.get("test_parameters", config_list),
+                    test_name=f"{combination.get('name', 'unnamed-test')} - {encrypt}",
+                )
+            # A skip on one test will stop the execution of all tests, return empty summary.
+            except SkippedTestException as e:
+                self._logger.error(f"test {test_name} skipped: {str(e)}")
+                return []
+
+        test_cases_skipped: int = 0
+        failed: bool = False
+        reason: str = ""
+        # Execute all cipher only tests and verify
+        for combination in self.cipher_tests:
+            test_name = combination.get("name", "unnamed_test")
+            combination_results = [(test(mode)) for mode in EncryptDecryptSwitch]
+            if all(result == [] for result in combination_results):
+                test_cases_skipped += 1
+            else:
+                try:
+                    self._print_and_verify(combination_results)
+                except TestCaseVerifyError as e:
+                    failed = True
+                    reason = f"{reason}\n{str(e)}" if reason else str(e)
+        if failed:
+            fail(reason)
+        if test_cases_skipped == len(self.cipher_tests):
+            skip("All configured test cases skipped.")
 
     @crypto_test
-    def snow3g_uea2_snow3g_uia2(self) -> None:
-        """snow3g_uea2_snow3g_uia2 latency test.
+    def auth_only_tests(self) -> None:
+        """Authentication cryptography device tests.
 
         Steps:
-            * Create a cryptodev instance with provided device type and buffer sizes.
+            * Run dpdk-test-crypto-perf application with configured parameters in authentication
+                only moode.
         Verify:
-            * The latency is below or within delta of provided baseline.
-
-        Raises:
-            SkippedTestException: When configuration is not provided.
+            * The resulting statistics are within a delta tolerance of a provided baseline.
         """
-        if "snow3g_uea2_snow3g_uia2" not in self.latency_test_parameters:
-            skip("test not configured")
-        app = Cryptodev(
-            ptest=TestType.latency,
-            devtype=self.device_type,
-            optype=OperationType.cipher_then_auth,
-            cipher_algo=CipherAlgorithm.snow3g_uea2,
-            cipher_op=EncryptDecryptSwitch.encrypt,
-            cipher_key_sz=16,
-            cipher_iv_sz=16,
-            auth_algo=AuthenticationAlgorithm.snow3g_uia2,
-            auth_op=AuthenticationOpMode.generate,
-            auth_key_sz=16,
-            auth_iv_sz=16,
-            digest_sz=4,
-            total_ops=TOTAL_OPS,
-            buffer_sz=self.buffer_sizes["snow3g_uea2_snow3g_uia2"],
-        )
-        results = self._verify_latency(app.run_app(), "snow3g_uea2_snow3g_uia2")
-        self._print_stats(results)
-        for result in results:
-            verify(
-                result["passed"] == "PASS",
-                "latency was greater than the delta tolerance above baseline",
-            )
-
-    @crypto_test
-    def zuc_eea3_zuc_eia3(self) -> None:
-        """zuc_eea3_zuc_eia3 cipher and auth latency test.
 
-        Steps:
-            * Create a cryptodev instance with provided device type and buffer sizes.
-        Verify:
-            * The latency is below or within delta of provided baseline.
-
-        Raises:
-            SkippedTestException: When configuration is not provided.
-        """
-        if "zuc_eea3_zuc_eia3" not in self.latency_test_parameters:
-            skip("test not configured")
-        app = Cryptodev(
-            ptest=TestType.latency,
-            devtype=self.device_type,
-            optype=OperationType.cipher_then_auth,
-            cipher_algo=CipherAlgorithm.zuc_eea3,
-            cipher_op=EncryptDecryptSwitch.encrypt,
-            cipher_key_sz=16,
-            cipher_iv_sz=16,
-            auth_algo=AuthenticationAlgorithm.zuc_eia3,
-            auth_op=AuthenticationOpMode.generate,
-            auth_key_sz=16,
-            auth_iv_sz=16,
-            digest_sz=4,
-            total_ops=TOTAL_OPS,
-            buffer_sz=self.buffer_sizes["zuc_eea3_zuc_eia3"],
-        )
-        results = self._verify_latency(app.run_app(), "zuc_eea3_zuc_eia3")
-        self._print_stats(results)
-        for result in results:
-            verify(
-                result["passed"] == "PASS",
-                "latency was greater than the delta tolerance above baseline",
+        def test(op_mode: AuthenticationOpMode) -> list[dict[str, int | float | str]]:
+            """Run a configured throughput test with the given authentication mode.
+
+            Args:
+                op_mode: The authentication op mode to run testing in.
+
+            Returns:
+                The generated summary or an empty list if a test is skipped.
+            """
+            auth_params = AUTHENTICATION_ALGORITHM_PARAMS[
+                AuthenticationAlgorithm[combination["auth_algorithm"]]
+            ]
+            is_vdev: bool = "virtual_device" in combination
+            app = Cryptodev(
+                ptest=TestType.latency,
+                devtype=self.device_type,
+                optype=OperationType.auth_only,
+                auth_algo=AuthenticationAlgorithm[combination["auth_algorithm"]],
+                auth_op=op_mode,
+                auth_key_sz=combination.get("auth_key_size", auth_params["key_size"]),
+                auth_iv_sz=combination.get("auth_iv_size", auth_params["iv_size"]),
+                total_ops=combination.get("ops", self.ops),
+                digest_sz=combination.get("digest_size", 0),
+                buffer_sz=self.buffer_sizes[combination["name"]],
             )
+            if is_vdev:
+                app.update_params(
+                    vdevs=[VirtualDevice(combination["virtual_device"])],
+                    devtype=get_device_from_str(combination["virtual_device"]),
+                )
 
-    # BEGIN VDEV TESTS
-
-    @crypto_test
-    def aesni_gcm_vdev(self) -> None:
-        """aesni_gcm virtual device latency test.
-
-        Steps:
-            * Create a cryptodev instance with provided device type and buffer sizes.
-        Verify:
-            * The latency is below or within delta of provided baseline.
-
-        Raises:
-            SkippedTestException: When configuration is not provided.
-        """
-        if "aesni_gcm_vdev" not in self.latency_test_parameters:
-            skip("test not configured")
-        app = Cryptodev(
-            ptest=TestType.latency,
-            vdevs=[VirtualDevice("crypto_aesni_gcm0")],
-            devtype=DeviceType.crypto_aesni_gcm,
-            optype=OperationType.aead,
-            aead_op=EncryptDecryptSwitch.encrypt,
-            aead_key_sz=16,
-            aead_iv_sz=12,
-            aead_aad_sz=16,
-            digest_sz=16,
-            burst_sz=32,
-            total_ops=TOTAL_OPS,
-            buffer_sz=self.buffer_sizes["aesni_gcm_vdev"],
-        )
-        results = self._verify_latency(app.run_app(num_vfs=0), "aesni_gcm_vdev")
-        self._print_stats(results)
-        for result in results:
-            verify(
-                result["passed"] == "PASS",
-                "latency was greater than the delta tolerance above baseline",
-            )
+            self._logger.info(f"Running configured test: {test_name} in {op_mode} mode")
+            try:
+                return self._create_summary(
+                    results=app.run_app(num_vfs=0 if is_vdev else 1),
+                    params=combination.get("test_parameters", config_list),
+                    test_name=f"{combination.get('name', 'unnamed-test')} - {op_mode}",
+                )
+            # A skip on one test will stop the execution of all tests, return empty summary.
+            except SkippedTestException as e:
+                self._logger.error(f"failed to run test {test_name}: {str(e)}")
+                return []
+
+        test_cases_skipped: int = 0
+        failed: bool = False
+        reason: str = ""
+        # Execute all auth only tests and verify
+        for combination in self.auth_tests:
+            test_name = combination.get("name", "unnamed_test")
+            combination_results = [(test(AuthenticationOpMode.generate))]
+            if all(result == [] for result in combination_results):
+                test_cases_skipped += 1
+            else:
+                try:
+                    self._print_and_verify(combination_results)
+                except TestCaseVerifyError as e:
+                    failed = True
+                    reason = f"{reason}\n{str(e)}" if reason else str(e)
+        if failed:
+            fail(reason)
+        if test_cases_skipped == len(self.auth_tests):
+            skip("All configured test cases skipped.")
 
     @crypto_test
-    def aesni_mb_cipher_then_auth_vdev(self) -> None:
-        """aesni_mb vdev cipher and auth latency test.
+    def aead_test(self) -> None:
+        """Aead cryptography test.
 
         Steps:
-            * Create a cryptodev instance with provided device type and buffer sizes.
+            * Run dpdk-test-crypto-perf application with configured parameters in aead mode.
         Verify:
-            * The latency is below or within delta of provided baseline.
-
-        Raises:
-            SkippedTestException: When configuration is not provided.
+            * The resulting statistics are within a delta tolerance of a given baseline.
         """
-        if "aesni_mb_cipher_then_auth_vdev" not in self.latency_test_parameters:
-            skip("test not configured")
-        app = Cryptodev(
-            ptest=TestType.latency,
-            vdevs=[VirtualDevice("crypto_aesni_mb0")],
-            devtype=DeviceType.crypto_aesni_mb,
-            optype=OperationType.cipher_then_auth,
-            cipher_algo=CipherAlgorithm.aes_cbc,
-            cipher_op=EncryptDecryptSwitch.encrypt,
-            cipher_key_sz=16,
-            auth_algo=AuthenticationAlgorithm.sha1_hmac,
-            auth_op=AuthenticationOpMode.generate,
-            auth_key_sz=64,
-            digest_sz=12,
-            burst_sz=32,
-            total_ops=TOTAL_OPS,
-            buffer_sz=self.buffer_sizes["aesni_mb_cipher_then_auth_vdev"],
-        )
-        results = self._verify_latency(app.run_app(num_vfs=0), "aesni_mb_cipher_then_auth_vdev")
-        self._print_stats(results)
-        for result in results:
-            verify(
-                result["passed"] == "PASS",
-                "latency was greater than the delta tolerance above baseline",
-            )
-
-    @crypto_test
-    def aesni_mb_vdev(self) -> None:
-        """aesni_mb vdev latency test.
 
-        Steps:
-            * Create a cryptodev instance with provided device type and buffer sizes.
-        Verify:
-            * The latency is below or within delta of provided baseline.
-
-        Raises:
-            SkippedTestException: When configuration is not provided.
-        """
-        if "aesni_mb_vdev" not in self.latency_test_parameters:
-            skip("test not configured")
-        app = Cryptodev(
-            ptest=TestType.latency,
-            vdevs=[VirtualDevice("crypto_aesni_mb0")],
-            devtype=DeviceType.crypto_aesni_mb,
-            optype=OperationType.cipher_only,
-            cipher_algo=CipherAlgorithm.aes_cbc,
-            cipher_op=EncryptDecryptSwitch.encrypt,
-            cipher_key_sz=16,
-            cipher_iv_sz=16,
-            burst_sz=32,
-            total_ops=TOTAL_OPS,
-            buffer_sz=self.buffer_sizes["aesni_mb_vdev"],
-        )
-        results = self._verify_latency(app.run_app(num_vfs=0), "aesni_mb_vdev")
-        self._print_stats(results)
-        for result in results:
-            verify(
-                result["passed"] == "PASS",
-                "latency was greater than the delta tolerance above baseline",
+        def test() -> list[dict[str, int | float | str]]:
+            """Execute the dpdk-test-crypto application and verify.
+
+            Args:
+                encrypt: The authentication operation mode to run the cryptodev application in.
+
+            Returns:
+                The generated summary or an empty list if a test is skipped.
+            """
+            is_vdev: bool = "virtual_device" in combination
+            aead_params = AEAD_ALGORITHM_PARAMS[AeadAlgName[combination["aead_algorithm"]]]
+            app = Cryptodev(
+                ptest=TestType.latency,
+                devtype=self.device_type,
+                optype=OperationType.aead,
+                aead_algo=AeadAlgName[combination["aead_algorithm"]],
+                aead_op=combination.get("aead_op", EncryptDecryptSwitch.encrypt),
+                aead_key_sz=combination.get("aead_key_size", aead_params["key_size"]),
+                aead_iv_sz=combination.get("aead_iv_size", aead_params["iv_size"]),
+                aead_aad_sz=combination.get("aead_size", aead_params["aad_size"]),
+                digest_sz=combination.get("digest_size", aead_params["digest_size"]),
+                total_ops=combination.get("ops", self.ops),
+                buffer_sz=self.buffer_sizes[combination["name"]],
             )
+            if is_vdev:
+                app.update_params(
+                    vdevs=[VirtualDevice(combination["virtual_device"])],
+                    devtype=get_device_from_str(combination["virtual_device"]),
+                )
+            if combination.get("aead_op", None) == EncryptDecryptSwitch.decrypt:
+                app.update_params(
+                    out_of_place=combination.get("out_of_place", True),
+                )
 
-    @crypto_test
-    def kasumi_vdev(self) -> None:
-        """Kasumi vdev latency test.
-
-        Steps:
-            * Create a cryptodev instance with provided device type and buffer sizes.
-        Verify:
-            * The latency is below or within delta of provided baseline.
-
-        Raises:
-            SkippedTestException: When configuration is not provided.
-        """
-        if "kasumi_vdev" not in self.latency_test_parameters:
-            skip("test not configured")
-        app = Cryptodev(
-            ptest=TestType.latency,
-            vdevs=[VirtualDevice("crypto_kasumi0")],
-            devtype=DeviceType.crypto_kasumi,
-            optype=OperationType.cipher_then_auth,
-            cipher_algo=CipherAlgorithm.kasumi_f8,
-            cipher_op=EncryptDecryptSwitch.encrypt,
-            cipher_key_sz=16,
-            cipher_iv_sz=8,
-            auth_algo=AuthenticationAlgorithm.kasumi_f9,
-            auth_op=AuthenticationOpMode.generate,
-            auth_key_sz=16,
-            digest_sz=4,
-            burst_sz=32,
-            total_ops=TOTAL_OPS,
-            buffer_sz=self.buffer_sizes["kasumi_vdev"],
-        )
-        results = self._verify_latency(app.run_app(num_vfs=0), "kasumi_vdev")
-        self._print_stats(results)
-        for result in results:
-            verify(
-                result["passed"] == "PASS",
-                "latency was greater than the delta tolerance above baseline",
-            )
+            self._logger.info(f"Running configured test: {test_name}")
+            try:
+                return self._create_summary(
+                    results=app.run_app(num_vfs=0 if is_vdev else 1),
+                    params=combination.get("test_parameters", config_list),
+                    test_name=f"{combination.get('name', 'unnamed-test')}",
+                )
+            # Exceptions will stop the execution of all tests, return an empty result and continue.
+            except SkippedTestException as e:
+                self._logger.error(f"failed to run test {test_name}: {str(e)}")
+                return []
+
+        test_cases_skipped: int = 0
+        failed: bool = False
+        reason: str = ""
+        # Execute all aead tests and verify
+        for combination in self.aead_tests:
+            test_name = combination.get("name", "unnamed_test")
+            combination_results = [test()]
+            if all(result == [] for result in combination_results):
+                test_cases_skipped += 1
+            else:
+                try:
+                    self._print_and_verify(combination_results)
+                except TestCaseVerifyError as e:
+                    failed = True
+                    reason = f"{reason}\n{str(e)}" if reason else str(e)
+        if failed:
+            fail(reason)
+        if test_cases_skipped == len(self.aead_tests):
+            skip("All configured test cases skipped.")
 
     @crypto_test
-    def open_ssl_vdev(self) -> None:
-        """open_ssl vdev latency test.
+    def cipher_and_auth_tests(self) -> None:
+        """Cipher and Authentication tests.
 
         Steps:
-            * Create a cryptodev instance with provided device type and buffer sizes.
+            * Run dpdk-test-crypto-perf application in cipher then authentication mode
         Verify:
-            * The latency is below or within delta of provided baseline.
-
-        Raises:
-            SkippedTestException: When configuration is not provided.
+            * The resulting statistics are within a delta tolerance of a given baseline.
         """
-        if "open_ssl_vdev" not in self.latency_test_parameters:
-            skip("test not configured")
-        app = Cryptodev(
-            ptest=TestType.latency,
-            vdevs=[VirtualDevice("crypto_openssl0")],
-            devtype=DeviceType.crypto_openssl,
-            optype=OperationType.aead,
-            aead_algo=AeadAlgName.aes_gcm,
-            aead_op=EncryptDecryptSwitch.encrypt,
-            aead_key_sz=16,
-            aead_iv_sz=16,
-            aead_aad_sz=16,
-            digest_sz=16,
-            total_ops=TOTAL_OPS,
-            buffer_sz=self.buffer_sizes["open_ssl_vdev"],
-        )
-        results = self._verify_latency(app.run_app(num_vfs=0), "open_ssl_vdev")
-        self._print_stats(results)
-        for result in results:
-            verify(
-                result["passed"] == "PASS",
-                "latency was greater than the delta tolerance above baseline",
-            )
 
-    @crypto_test
-    def snow3g_vdev(self) -> None:
-        """snow3g vdev latency test.
-
-        Steps:
-            * Create a cryptodev instance with provided device type and buffer sizes.
-        Verify:
-            * The latency is below or within delta of provided baseline.
-
-        Raises:
-            SkippedTestException: When configuration is not provided.
-        """
-        if "snow3g_vdev" not in self.latency_test_parameters:
-            skip("test not configured")
-        app = Cryptodev(
-            ptest=TestType.latency,
-            vdevs=[VirtualDevice("crypto_snow3g0")],
-            devtype=DeviceType.crypto_snow3g,
-            optype=OperationType.cipher_then_auth,
-            cipher_algo=CipherAlgorithm.snow3g_uea2,
-            cipher_op=EncryptDecryptSwitch.encrypt,
-            cipher_key_sz=16,
-            cipher_iv_sz=16,
-            auth_algo=AuthenticationAlgorithm.snow3g_uia2,
-            auth_op=AuthenticationOpMode.generate,
-            auth_key_sz=16,
-            auth_iv_sz=16,
-            digest_sz=16,
-            burst_sz=32,
-            total_ops=TOTAL_OPS,
-            buffer_sz=self.buffer_sizes["snow3g_vdev"],
-        )
-        results = self._verify_latency(app.run_app(num_vfs=0), "snow3g_vdev")
-        self._print_stats(results)
-        for result in results:
-            verify(
-                result["passed"] == "PASS",
-                "latency was greater than the delta tolerance above baseline",
+        def test(
+            encrypt: EncryptDecryptSwitch, op_mode: AuthenticationOpMode
+        ) -> list[dict[str, int | float | str]]:
+            """Execute the dpdk-test-crypto application and verify.
+
+            Args:
+                encrypt: The cipher encryption mode to run latency testing in.
+                op_mode: The authentication operation mode to run the cryptodev application in.
+
+            Returns:
+                The generated summary or an empty list if a test is skipped.
+            """
+            is_vdev: bool = "virtual_device" in combination
+            cipher_params = CIPHER_ALGORITHM_PARAMS[
+                CipherAlgorithm[combination["cipher_algorithm"]]
+            ]
+            auth_params = AUTHENTICATION_ALGORITHM_PARAMS[
+                AuthenticationAlgorithm[combination["auth_algorithm"]]
+            ]
+            app = Cryptodev(
+                ptest=TestType.latency,
+                devtype=self.device_type,
+                optype=OperationType.aead,
+                cipher_algo=CipherAlgorithm[combination["cipher_algorithm"]],
+                cipher_op=encrypt,
+                cipher_key_sz=combination.get("cipher_key_size", cipher_params["key_size"]),
+                cipher_iv_sz=combination.get("cipher_iv_size", cipher_params["iv_size"]),
+                auth_algo=AuthenticationAlgorithm[combination["auth_algorithm"]],
+                auth_op=op_mode,
+                auth_key_sz=combination.get("auth_key_size", auth_params["key_size"]),
+                auth_iv_sz=combination.get("auth_iv_size", auth_params["iv_size"]),
+                total_ops=combination.get("ops", self.ops),
+                digest_sz=combination.get("digest_size", 0),
+                buffer_sz=self.buffer_sizes[combination["name"]],
             )
+            if is_vdev:
+                app.update_params(
+                    vdevs=[VirtualDevice(combination["virtual_device"])],
+                    devtype=get_device_from_str(combination["virtual_device"]),
+                )
 
-    @crypto_test
-    def zuc_vdev(self) -> None:
-        """Zuc vdev latency test.
-
-        Steps:
-            * Create a cryptodev instance with provided device type and buffer sizes.
-        Verify:
-            * The latency is below or within delta of provided baseline.
-
-        Raises:
-            SkippedTestException: When configuration is not provided.
-        """
-        if "zuc_vdev" not in self.latency_test_parameters:
-            skip("test not configured")
-        app = Cryptodev(
-            ptest=TestType.latency,
-            vdevs=[VirtualDevice("crypto_zuc0")],
-            devtype=DeviceType.crypto_zuc,
-            optype=OperationType.cipher_then_auth,
-            cipher_algo=CipherAlgorithm.zuc_eea3,
-            cipher_op=EncryptDecryptSwitch.encrypt,
-            cipher_key_sz=16,
-            cipher_iv_sz=16,
-            auth_algo=AuthenticationAlgorithm.zuc_eia3,
-            auth_op=AuthenticationOpMode.generate,
-            auth_key_sz=16,
-            auth_iv_sz=16,
-            digest_sz=4,
-            burst_sz=32,
-            total_ops=TOTAL_OPS,
-            buffer_sz=self.buffer_sizes["zuc_vdev"],
-        )
-        results = self._verify_latency(app.run_app(num_vfs=0), "zuc_vdev")
-        self._print_stats(results)
-        for result in results:
-            verify(
-                result["passed"] == "PASS",
-                "latency was greater than the delta tolerance above baseline",
-            )
+            self._logger.info(f"Running configured test: {test_name} in {encrypt} mode")
+            try:
+                return self._create_summary(
+                    results=app.run_app(num_vfs=0 if is_vdev else 1),
+                    params=combination.get("test_parameters", config_list),
+                    test_name=f"{combination.get('name', 'unnamed-test')} - {encrypt}",
+                )
+            # Exceptions will stop the execution of all tests, return an empty result and continue.
+            except SkippedTestException as e:
+                self._logger.error(f"failed to run test {test_name}: {str(e)}")
+                return []
+
+        test_cases_skipped: int = 0
+        failed: bool = False
+        reason: str = ""
+        # Execute all cipher_then_auth tests and verify
+        for combination in self.cipher_then_auth_tests:
+            print(str(combination))
+            test_name = combination.get("name", "unnamed_test")
+            combination_results = [
+                test(mode, AuthenticationOpMode.generate) for mode in EncryptDecryptSwitch
+            ]
+            if all(result == [] for result in combination_results):
+                test_cases_skipped += 1
+            else:
+                try:
+                    self._print_and_verify(combination_results)
+                except TestCaseVerifyError as e:
+                    failed = True
+                    reason = f"{reason}\n{str(e)}" if reason else str(e)
+        if failed:
+            fail(reason)
+        if test_cases_skipped == len(self.cipher_then_auth_tests):
+            skip("All configured test cases skipped.")
-- 
2.55.0

