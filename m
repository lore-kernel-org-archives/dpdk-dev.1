Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CF0606BA3A
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 21:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=gf8yMYwK
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C18D40B9D;
	Wed,  4 Nov 2026 22:35:59 +0100 (CET)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mails.dpdk.org (Postfix) with ESMTPS id 1DED340288
 for <dev@dpdk.org>; Wed,  4 Nov 2026 22:35:57 +0100 (CET)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-93a40a9a01aso4902285a.0
 for <dev@dpdk.org>; Wed, 04 Nov 2026 13:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1793828156; x=1794432956; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3K4WS4B06oug0iAR7js9qMtKYk4BHaSUUHIJ7JT3LzA=;
 b=gf8yMYwKSKaSbwiG1h+Yip+zYzqYDGe6Yp1cJtkrlpiH93Y1SmIMndCvra2XucHsjw
 Fz+/QJivFXIUaMIjuQy0LyqsitRDmg9B1oYDni728a5HrmvTTZH11aacnG0CGR53WsK7
 qQoYe2brbfrJ62OMpQbFtllX664/Bbi9Vg9b0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793828156; x=1794432956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3K4WS4B06oug0iAR7js9qMtKYk4BHaSUUHIJ7JT3LzA=;
 b=kvkkH0SgW7kqOjxpG+iabx3DQ42I+pWZFDc0TSBuDJESagVMDupdzn41ZFRXGyCvF2
 Qbv2zVgiDskNKWEh7tft63hCw0YTiq0SpaYIhGYjsDq6WzEfQs1cTPb4mDK9wrXgcSzX
 UJl7iE1bVJFtDPNtOicoebKaiEPIo384CXpdqqTFlXjHmfY8umoqnr84RkXjJvryTz8f
 JXKkoEM45gwAhJdClYklPz2ntjfYBEV5JHboh+uZfmBzI15J5Rkx+JEMDKTZtWLwOnIv
 76CDe6ZyVkVB+eOdI5hM9d29F2Y+PyHHyK74wsjJ7qT3qHU4I+aByx+lf2vH05R+EcC6
 xrfA==
X-Gm-Message-State: APuU4Z/Kw7q4QerjXFeB+DaZt2iK3d99ZHv26zfuXIzETy1iUv2Avhyn
 Mx0UlnQQ/wXnI3orEYEXdn6orOmvjqbmDvf+PfTQ++CUSuCaD2fn6mUfWWBOiA1EVf/RQ9mcu9I
 c+c+EUXbjatnRJcVW5rqaxtY4FTbeOqGR7Giu05v9VrElXwFL05G3nTEoqYjZQn2fpvwT2eyVr2
 eTkrBjPCELG8rK9g9NIvzAVcEiPys=
X-Gm-Gg: AYBFou3B5jRZw0zYvaHoB9IGOhypA9OfSmcH/FSIZ4lPSEhqWcrc2Kskobc5x/vnRnk
 bjDibk4J7Tu+8faIAZA3GBXDE90ZSag/GO4kGiXoYX47+6TcUh85/T4+0Y6sgJWl5scGowqQIfU
 zTMnlL7JnH1K9wNGhx2nnCHfwSqtGesdGuDacjTWWeHv2OhkLqqURA+jogsIXMgZsapeHg/a/te
 yqSSzBwjELKazTJTEQP36+yP8LGD0zMpO0ZSNuJErAoN9ggmhsfAIUgzUvLSgPU5HewKzaHFv9V
 IKZSsObdFv7c3kRjWwEvFHNcYLoKapjTJ+e/Er3HPav41AR9L2scD8mrbZsoMPWGnzMxBD8XHKF
 Lu9bFoEWUNpzsqXBZX3EE5ajwmQcANlLmqjg5C71Oilo0WLXmJeJaVm4PgmhAEq/1KL7420wPOe
 hPMN7J0LKxERdPVIZwQHzlUXx0JbU4cj6nx/9h3b07DmiNn4TkRsfyDQCMb/SpAEOC2edFtAo60
 rLQTx70PZbw4AhA49ECxQlPR9WL0x3znT2zq4tkFKpIJOBbV0X7v+8pBeRk7eg+u1pO4x63Z25B
 sfmwzVHJufsFJA3Z6yR/cOBRbjb5NQ27GCn4XNSTFnJNcSwZDdE=
X-Received: by 2002:a05:620a:1d0a:b0:93e:c173:f694 with SMTP id
 af79cd13be357-945e16da424mr137490185a.40.1793828155393; 
 Wed, 04 Nov 2026 13:35:55 -0800 (PST)
Received: from d121029.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-945d468f904sm299360485a.5.2026.11.04.13.35.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 13:35:54 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, dladd@iol.unh.edu, Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v3 2/2] dts: refactor cryptodev latency test suite
Date: Wed,  4 Nov 2026 16:35:44 -0500
Message-ID: <20261104213544.410065-2-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104213544.410065-1-abailey@iol.unh.edu>
References: <20260827172208.139769-1-abailey@iol.unh.edu>
 <20261104213544.410065-1-abailey@iol.unh.edu>
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

Previously, cryptodev latency testing only covered a handful of
algorithm combinations and virtual device types for testing. The new
implementation makes this test completely configurable to run any
combination of arguments provided through the tests configuration file.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
v3:
 * Added type enforcement to configuration file.
 dts/api/cryptodev/types.py                   |   10 +-
 dts/configurations/tests_config.example.yaml |   17 +
 dts/tests/TestSuite_cryptodev_latency.py     | 1024 ++++++++----------
 dts/tests/TestSuite_cryptodev_throughput.py  |   14 +-
 4 files changed, 473 insertions(+), 592 deletions(-)

diff --git a/dts/api/cryptodev/types.py b/dts/api/cryptodev/types.py
index 539fe44cac..a5f8984f69 100644
--- a/dts/api/cryptodev/types.py
+++ b/dts/api/cryptodev/types.py
@@ -28,6 +28,14 @@ class ThroughputParameters(FrozenModel):
     gbps: float


+class LatencyParameters(FrozenModel):
+    """Test parameters for Throughput runs."""
+
+    buff_size: int
+    avg_cycles: float
+    avg_time_us: float
+
+
 class CryptoConfig(FrozenModel):
     """User supplied configuration for CryptoDev object."""

@@ -70,7 +78,7 @@ class CryptoConfig(FrozenModel):
     #:
     out_of_place: Switch = None
     #:
-    test_parameters: list[ThroughputParameters] | None = None
+    test_parameters: list[ThroughputParameters] | list[LatencyParameters] | None = None
     #:
     virtual_device: str | None = None

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
index 930b2d4a9d..6bdd0a78bb 100644
--- a/dts/tests/TestSuite_cryptodev_latency.py
+++ b/dts/tests/TestSuite_cryptodev_latency.py
@@ -16,6 +16,9 @@
 from api.context import get_ctx
 from api.cryptodev import Cryptodev
 from api.cryptodev.config import (
+    AEAD_ALGORITHM_PARAMS,
+    AUTHENTICATION_ALGORITHM_PARAMS,
+    CIPHER_ALGORITHM_PARAMS,
     AeadAlgName,
     AuthenticationAlgorithm,
     AuthenticationOpMode,
@@ -28,692 +31,539 @@
     get_device_from_str,
 )
 from api.cryptodev.types import (
+    CryptoConfig,
     CryptodevResults,
+    LatencyParameters,
+    ThroughputParameters,
 )
-from api.test import skip, verify
+from api.exception import ConfigurationError, SkippedTestException, TestCaseVerifyError
+from api.test import fail, skip, verify
 from api.test_suite import BaseConfig, TestSuite, perf_suite, perf_test
 from api.testbed_model.virtual_device import VirtualDevice

-config_list: list[dict[str, int | float | str]] = [
-    {"buff_size": 64, "avg_cycles": 99_999.00, "avg_time_us": 9999.0},
-    {"buff_size": 512, "avg_cycles": 99_999.00, "avg_time_us": 9999.0},
-    {"buff_size": 2048, "avg_cycles": 99_999.00, "avg_time_us": 9999.0},
-]
-
 TOTAL_OPS = 10_000_000

+config_list: list[LatencyParameters] = [
+    LatencyParameters(buff_size=64, avg_cycles=999_999_999.0, avg_time_us=999_999_999.0),
+    LatencyParameters(buff_size=512, avg_cycles=999_999_999.0, avg_time_us=999_999_999.0),
+    LatencyParameters(buff_size=2048, avg_cycles=999_999_999.0, avg_time_us=999_999_999.0),
+]
+

 class Config(BaseConfig):
     """Performance test metrics.

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
+    test_combinations: list[CryptoConfig] = [
+        #: cipher only tests
+        CryptoConfig(
+            name="aes-cbc (cipher only)",
+            cipher_algorithm=CipherAlgorithm.aes_cbc,
+            burst_size=32,
+        ),
+        CryptoConfig(
+            name="aead-docsisbpi (cipher only)",
+            cipher_algorithm=CipherAlgorithm.aes_docsisbpi,
+        ),
+        #: cipher then auth tests
+        CryptoConfig(
+            name="aes-cbc/sha1-hmac (cipher then auth)",
+            cipher_algorithm=CipherAlgorithm.aes_cbc,
+            auth_algorithm=AuthenticationAlgorithm.sha1_hmac,
+            burst_size=32,
+            virtual_device="crypto_openssl",
+        ),
+        CryptoConfig(
+            name="aes-cbc/sha2-256-hmac (cipher then auth)",
+            cipher_algorithm=CipherAlgorithm.aes_cbc,
+            auth_algorithm=AuthenticationAlgorithm.sha2_256_hmac,
+            burst_size=32,
+            virtual_device="crypto_openssl",
+        ),
+        CryptoConfig(
+            name="kasumi-f8/kasumi-f9 (cipher then auth)",
+            cipher_algorithm=CipherAlgorithm.kasumi_f8,
+            auth_algorithm=AuthenticationAlgorithm.kasumi_f9,
+            burst_size=32,
+        ),
+        CryptoConfig(
+            name="snow3g-uea2/snow3g-uia2 (cipher then auth)",
+            cipher_algorithm=CipherAlgorithm.snow3g_uea2,
+            auth_algorithm=AuthenticationAlgorithm.snow3g_uia2,
+        ),
+        CryptoConfig(
+            name="zuc-eea3/zuc-eia3 (cipher then auth)",
+            cipher_algorithm=CipherAlgorithm.zuc_eea3,
+            auth_algorithm=AuthenticationAlgorithm.zuc_eia3,
+        ),
+        #: aead tests
+        CryptoConfig(
+            name="aead-aes-gcm (aead)",
+            aead_algorithm=AeadAlgName.aes_gcm,
+        ),
+    ]


 @requires_link_topology(LinkTopology.NO_LINK)
 @perf_suite
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
+        self.test_combinations: list[CryptoConfig] = self.config.test_combinations
         self.delta_tolerance: float = self.config.delta_tolerance
+        self.ops: int = 10_000_000
         self.device_type: DeviceType | None = get_device_from_str(
             str(get_ctx().sut_node.crypto_device_type)
         )
-        self.buffer_sizes = {}
+        self.buffer_sizes: dict[str, ListWrapper] = {}

-        for k, v in self.latency_test_parameters.items():
-            self.buffer_sizes[k] = ListWrapper([int(run["buff_size"]) for run in v])
+        # categorize configured tests
+        self.cipher_tests: list[CryptoConfig] = []
+        self.auth_tests: list[CryptoConfig] = []
+        self.cipher_then_auth_tests: list[CryptoConfig] = []
+        self.aead_tests: list[CryptoConfig] = []
+
+        for combination in self.test_combinations:
+            self.buffer_sizes[combination.name] = ListWrapper(
+                [int(run.buff_size) for run in combination.test_parameters or config_list]
+            )
+            is_cipher = combination.cipher_algorithm is not None
+            is_auth = combination.auth_algorithm is not None
+            aead = combination.aead_algorithm is not None
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
+        params: list[LatencyParameters] | list[ThroughputParameters],
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
+        filtered_params: list[LatencyParameters] = [
+            p for p in params if isinstance(p, LatencyParameters)
+        ]

         for result in results:
             # get the corresponding baseline for the current buffer size
-            parameters: dict[str, int | float | str] = next(
-                filter(
-                    lambda x: x["buff_size"] == result.buffer_size,
-                    self.latency_test_parameters[key],
-                ),
-                {},
+            parameters: LatencyParameters | None = next(
+                (p for p in filtered_params if p.buff_size == result.buffer_size), None
             )
-            if parameters == {}:
-                raise RuntimeError(
-                    f"No test parameters found for {key} with buffer size {result.buffer_size}"
-                )
+            errmsg = (
+                f"No test parameters found for {test_name} with buffer size {result.buffer_size}"
+            )
+            if parameters is None:
+                raise RuntimeError(errmsg)
             test_result = True
-            expected_cycles = parameters["avg_cycles"]
-            expected_time_us = parameters["avg_time_us"]
-            measured_time_delta = abs(
-                (getattr(result, "avg_time_us") - expected_time_us) / expected_time_us
+
+            expected_cycles = parameters.avg_cycles
+            assert expected_cycles > 0, "Expected average cycles must not be zero"
+            measured_delta_cycles = abs(
+                round((getattr(result, "avg_cycles") - expected_cycles) / expected_cycles, 5)
             )
-            measured_cycles_delta = abs(
-                (getattr(result, "avg_cycles") - expected_cycles) / expected_cycles
+            expected_time = parameters.avg_time_us
+            assert expected_time > 0, "Expected average time must not be zero"
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
-                    "Buffer Size": parameters["buff_size"],
+                    "Test Name": test_name,
+                    "Buffer Size": parameters.buff_size,
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

     @perf_test
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
-    @perf_test
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
-    @perf_test
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
-
-    @perf_test
-    def aes_docsisbpi(self) -> None:
-        """aes_docsisbpi latency test.

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
-            )
-
-    @perf_test
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
+        def test() -> list[dict[str, int | float | str]]:
+            """Run a configured throughput test with the given encryption.
+
+            Args:
+                encrypt: The cipher encryption mode to run throughput testing on.
+
+            Returns:
+                The generated summary or an empty list if a test is skipped.
+            """
+            assert combination.cipher_algorithm, "Cipher algorithm required for cipher test."
+            cipher_params = CIPHER_ALGORITHM_PARAMS[combination.cipher_algorithm]
+            app = Cryptodev(
+                ptest=TestType.latency,
+                devtype=self.device_type,
+                optype=OperationType.cipher_only,
+                cipher_algo=combination.cipher_algorithm,
+                cipher_op=combination.cipher_op or EncryptDecryptSwitch.encrypt,
+                cipher_key_sz=combination.cipher_key_size or cipher_params["key_size"],
+                cipher_iv_sz=combination.cipher_iv_size or cipher_params["iv_size"],
+                digest_sz=combination.digest_size or None,
+                total_ops=combination.ops or self.ops,
+                buffer_sz=self.buffer_sizes[combination.name],
             )
+            if combination.virtual_device:
+                app.update_params(
+                    vdevs=[VirtualDevice(combination.virtual_device)],
+                    devtype=get_device_from_str(combination.virtual_device),
+                )

-    @perf_test
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
+            self._logger.info(f"Running configured test: {test_name}")
+            try:
+                return self._create_summary(
+                    results=app.run_app(num_vfs=0 if combination.virtual_device else 1),
+                    params=combination.test_parameters or config_list,
+                    test_name=combination.name,
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
+            test_name = combination.name
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
+        if test_cases_skipped == len(self.cipher_tests):
+            skip("All configured test cases skipped.")

     @perf_test
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

-    @perf_test
-    def zuc_eea3_zuc_eia3(self) -> None:
-        """zuc_eea3_zuc_eia3 cipher and auth latency test.
-
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
+        def test() -> list[dict[str, int | float | str]]:
+            """Run a configured throughput test with the given authentication mode.
+
+            Args:
+                op_mode: The authentication op mode to run testing in.
+
+            Returns:
+                The generated summary or an empty list if a test is skipped.
+            """
+            assert combination.auth_algorithm, "Authentication algorithm required for auth test."
+            auth_params = AUTHENTICATION_ALGORITHM_PARAMS[combination.auth_algorithm]
+            app = Cryptodev(
+                ptest=TestType.latency,
+                devtype=self.device_type,
+                optype=OperationType.auth_only,
+                auth_algo=combination.auth_algorithm,
+                auth_op=combination.auth_op or AuthenticationOpMode.generate,
+                auth_key_sz=combination.auth_key_size or auth_params["key_size"],
+                auth_iv_sz=combination.auth_iv_size or auth_params["iv_size"],
+                total_ops=combination.ops or self.ops,
+                digest_sz=combination.digest_size or None,
+                buffer_sz=self.buffer_sizes[combination.name],
             )
+            if combination.virtual_device:
+                app.update_params(
+                    vdevs=[VirtualDevice(combination.virtual_device)],
+                    devtype=get_device_from_str(combination.virtual_device),
+                )

-    # BEGIN VDEV TESTS
+            self._logger.info(f"Running configured test: {test_name}")
+            try:
+                return self._create_summary(
+                    results=app.run_app(num_vfs=0 if combination.virtual_device else 1),
+                    params=combination.test_parameters or config_list,
+                    test_name=combination.name,
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
+            test_name = combination.name
+            combination_results = [(test())]
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

     @perf_test
-    def aesni_gcm_vdev(self) -> None:
-        """aesni_gcm virtual device latency test.
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
-
-    @perf_test
-    def aesni_mb_cipher_then_auth_vdev(self) -> None:
-        """aesni_mb vdev cipher and auth latency test.
-
-        Steps:
-            * Create a cryptodev instance with provided device type and buffer sizes.
-        Verify:
-            * The latency is below or within delta of provided baseline.

-        Raises:
-            SkippedTestException: When configuration is not provided.
-        """
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
+        def test() -> list[dict[str, int | float | str]]:
+            """Execute the dpdk-test-crypto application and verify.
+
+            Args:
+                encrypt: The authentication operation mode to run the cryptodev application in.
+
+            Returns:
+                The generated summary or an empty list if a test is skipped.
+            """
+            assert combination.aead_algorithm, "Aead algorithm required for aead test."
+            aead_params = AEAD_ALGORITHM_PARAMS[combination.aead_algorithm]
+            app = Cryptodev(
+                ptest=TestType.latency,
+                devtype=self.device_type,
+                optype=OperationType.aead,
+                aead_algo=combination.aead_algorithm,
+                aead_op=combination.aead_op or EncryptDecryptSwitch.encrypt,
+                aead_key_sz=combination.aead_key_size or aead_params["key_size"],
+                aead_iv_sz=combination.aead_iv_size or aead_params["iv_size"],
+                aead_aad_sz=combination.aead_size or aead_params["aad_size"],
+                digest_sz=combination.digest_size or aead_params["digest_size"],
+                total_ops=combination.ops or self.ops,
+                buffer_sz=self.buffer_sizes[combination.name],
             )
+            if combination.virtual_device:
+                app.update_params(
+                    vdevs=[VirtualDevice(combination.virtual_device)],
+                    devtype=get_device_from_str(combination.virtual_device),
+                )
+            if combination.out_of_place:
+                app.update_params(
+                    out_of_place=combination.out_of_place,
+                )

-    @perf_test
-    def aesni_mb_vdev(self) -> None:
-        """aesni_mb vdev latency test.
-
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
-            )
+            self._logger.info(f"Running configured test: {test_name}")
+            try:
+                return self._create_summary(
+                    results=app.run_app(num_vfs=0 if combination.virtual_device else 1),
+                    params=combination.test_parameters or config_list,
+                    test_name=combination.name,
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
+            test_name = combination.name
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

     @perf_test
-    def kasumi_vdev(self) -> None:
-        """Kasumi vdev latency test.
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

-    @perf_test
-    def open_ssl_vdev(self) -> None:
-        """open_ssl vdev latency test.
+        def test() -> list[dict[str, int | float | str]]:
+            """Execute the dpdk-test-crypto application and verify.

-        Steps:
-            * Create a cryptodev instance with provided device type and buffer sizes.
-        Verify:
-            * The latency is below or within delta of provided baseline.
+            Args:
+                encrypt: The cipher encryption mode to run latency testing in.
+                op_mode: The authentication operation mode to run the cryptodev application in.

-        Raises:
-            SkippedTestException: When configuration is not provided.
-        """
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
+            Returns:
+                The generated summary or an empty list if a test is skipped.
+            """
+            assert combination.cipher_algorithm and combination.auth_algorithm, (
+                "Cipher and auth algorithms required for cipher then auth test."
             )
-
-    @perf_test
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
+            cipher_params = CIPHER_ALGORITHM_PARAMS[combination.cipher_algorithm]
+            auth_params = AUTHENTICATION_ALGORITHM_PARAMS[combination.auth_algorithm]
+            app = Cryptodev(
+                ptest=TestType.latency,
+                devtype=self.device_type,
+                optype=OperationType.cipher_then_auth,
+                cipher_algo=combination.cipher_algorithm,
+                cipher_op=combination.cipher_op or EncryptDecryptSwitch.encrypt,
+                cipher_key_sz=combination.cipher_key_size or cipher_params["key_size"],
+                cipher_iv_sz=combination.cipher_iv_size or cipher_params["iv_size"],
+                auth_algo=combination.auth_algorithm,
+                auth_op=AuthenticationOpMode.generate,
+                auth_key_sz=combination.auth_key_size or auth_params["key_size"],
+                auth_iv_sz=combination.auth_iv_size or auth_params["iv_size"],
+                total_ops=combination.ops or self.ops,
+                digest_sz=combination.digest_size or None,
+                buffer_sz=self.buffer_sizes[combination.name],
             )
+            if combination.virtual_device:
+                app.update_params(
+                    vdevs=[VirtualDevice(combination.virtual_device)],
+                    devtype=get_device_from_str(combination.virtual_device),
+                )

-    @perf_test
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
+            self._logger.info(f"Running configured test: {test_name}")
+            try:
+                return self._create_summary(
+                    results=app.run_app(num_vfs=0 if combination.virtual_device else 1),
+                    params=combination.test_parameters or config_list,
+                    test_name=combination.name,
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
+            test_name = combination.name
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
+        if test_cases_skipped == len(self.cipher_then_auth_tests):
+            skip("All configured test cases skipped.")
diff --git a/dts/tests/TestSuite_cryptodev_throughput.py b/dts/tests/TestSuite_cryptodev_throughput.py
index fbc7306ff3..394c5b4945 100644
--- a/dts/tests/TestSuite_cryptodev_throughput.py
+++ b/dts/tests/TestSuite_cryptodev_throughput.py
@@ -33,6 +33,7 @@
 from api.cryptodev.types import (
     CryptoConfig,
     CryptodevResults,
+    LatencyParameters,
     ThroughputParameters,
 )
 from api.exception import ConfigurationError, SkippedTestException, TestCaseVerifyError
@@ -193,7 +194,7 @@ def _print_stats(self, test_vals: list[dict[str, int | float | str]]) -> None:
     def _create_summary(
         self,
         results: list[CryptodevResults],
-        params: list[ThroughputParameters],
+        params: list[ThroughputParameters] | list[LatencyParameters],
         test_name: str,
     ) -> list[dict[str, int | float | str]]:
         """Verify the throughput of the given results against the supplied parameters.
@@ -210,11 +211,14 @@ def _create_summary(
             RuntimeError: When there are no baselines for a given result.
         """
         result_list: list[dict[str, int | float | str]] = []
+        filtered_params: list[ThroughputParameters] = [
+            p for p in params if isinstance(p, ThroughputParameters)
+        ]

         for result in results:
             # get the corresponding baseline for the current buffer size
             parameters: ThroughputParameters | None = next(
-                (p for p in params if p.buff_size == result.buffer_size),
+                (p for p in filtered_params if p.buff_size == result.buffer_size),
                 None,
             )
             errmsg = (
@@ -286,7 +290,9 @@ def test() -> list[dict[str, int | float | str]]:
                     devtype=get_device_from_str(combination.virtual_device),
                 )

-            self._logger.info(f"Running configured test: {test_name} in {combination.cipher_op} mode")
+            self._logger.info(
+                f"Running configured test: {test_name} in {combination.cipher_op} mode"
+            )
             try:
                 return self._create_summary(
                     results=app.run_app(num_vfs=0 if combination.virtual_device else 1),
@@ -358,7 +364,7 @@ def test() -> list[dict[str, int | float | str]]:
                     devtype=get_device_from_str(combination.virtual_device),
                 )

-            self._logger.info(f"Running configured test: {test_name} in {combination.auth_op or AuthenticationOpMode.generate} mode")
+            self._logger.info(f"Running configured test: {test_name}")
             try:
                 return self._create_summary(
                     results=app.run_app(num_vfs=0 if combination.virtual_device else 1),
--
2.56.0

