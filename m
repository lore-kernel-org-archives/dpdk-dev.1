Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54FACA5FA1
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 18:06:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F8D0402F0;
	Mon, 28 Sep 2026 20:06:28 +0200 (CEST)
Received: from mail-qk2-f40.google.com (mail-qk2-f40.google.com
 [74.125.230.232])
 by mails.dpdk.org (Postfix) with ESMTP id 29A7F40275
 for <dev@dpdk.org>; Mon, 28 Sep 2026 20:06:27 +0200 (CEST)
Received: by mail-qk2-f40.google.com with SMTP id
 d75a77b69052e-5332a80a731so26353131cf.0
 for <dev@dpdk.org>; Mon, 28 Sep 2026 11:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1790618786; x=1791223586; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wZfM+S+he+RBc72c09YFBF9ybpioftAd/rBlcnp6djo=;
 b=AYVpv6l/asitg+FqxgS0/m1Hkgi7k7btGAZmTPN0uZJ6CyuAov9btVsapJ9LedyP4l
 TjwvnWkIhBVJS+t44pQJ2ZhO+aC/TjxLZIiaqkokzTmtKGJkgG1sw7djWWAQzv29bAkl
 PX8u/x3YI/QFpBUeyjY8SQGEgPjQ3e8cly5Bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790618786; x=1791223586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wZfM+S+he+RBc72c09YFBF9ybpioftAd/rBlcnp6djo=;
 b=mrKorZr0zmxC8tdWc9XXiZtl4goojn5MYp+tbZ04Z8uaQfi9br+K0G52TFkJ/3Pyn4
 Rc2J9GP3Xt1uY57wqJUzjOaNF8N58CUxOw1pkOA7u7t9UtYv24kyMPeu0PXkrKweDO7L
 LXDc6pmRc6G8c0mu7BBuGdXJm9CPrMIG1bT/9jB+vaG5FPeGBBtaUMJ2JY9iVcWWHN9P
 PsQ+onaVsbtXmNvbECi5u7t0qSNGD8VnKhdJgobj/nbOrZdSyingsPuFILLS243GlBZa
 UDyogt7bnwHep2oRad6RW8htmMUGULdgG9lrrQPTsOpQPeq3tAlv2zKGS1rOmaa08fQ/
 /Pzw==
X-Gm-Message-State: AFuF++lttPReGAPe5TX2yODAGeK7FmWkqqqrjP+E2hHn3vov57XpiBmg
 Z9WFbvrnBPncrXpRUjk3WOD8jHeG+kUej/PxXzzNmRQQBZYTyj9wyJ7roZu/55UqALPoNJz3x/V
 xlosd2zJMhIQrZ4u/BM/gG4OUneyvwlmOgJ92U3SnSQH+CqwSCGsIBuZgux/NTVpeqw1sUMed0E
 6Bw/WYMSmXwMgX6bMUlZqsvGYHQvw=
X-Gm-Gg: AYBFou1RVlzAD1GPGT9aRhmfuM011qyzUk/lZIHEVNZ4Ji0skr7xgvsdn3o2c/5hww6
 UZvhwOk3TcMAIeUzBB9ERFHMCiEDEgQBDIUJVpo9/dSunyBUGgp8hgIahiPNZyc7PJsB+nf+986
 qdiaLiwz3mdVxwjt1bE4Dc4mvLf2ELM505brVCrodfbRaSjUlVWbkT0rm5PDlGcEAzf1oBBG5uT
 RpGDY2mntxJdHG7icYhX2LFXEOCljDeze5nXQdJZErYEC5ZYBtVvdz87GfHVv7CLKO/m/DRVSNw
 Nw3El09QpBfF7XquVLozBHoDDWdk1UMQhDlUDe0FeaxJm3LjIWKIe376JPT31by+OHtWsPpWyv/
 WYWnrM+NnMQb2wkQxa3rgr7g+M8RMSK1Uz/RDWMXDRuqB7DcwCbTjoo6B7j4W2J3obMiRPK7qhu
 mqlVE4pSNKhF2KZkrmmEYqwOBnuMtunLdZLveIdJo9neayjwruCfa1GqSA0CeYrT2sKsiHZKDjm
 RwyiVQJAsL0OIeznrvF
X-Received: by 2002:a05:620a:1789:b0:93b:d7a1:ba0f with SMTP id
 af79cd13be357-93c47554f70mr2172250785a.58.1790618785274; 
 Mon, 28 Sep 2026 11:06:25 -0700 (PDT)
Received: from d121029.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c8141617bsm206987285a.25.2026.09.28.11.06.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 11:06:24 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v2 1/2] dts: refactor cryptodev throughput test suite
Date: Mon, 28 Sep 2026 14:06:09 -0400
Message-ID: <20260928180610.224307-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827172208.139769-1-abailey@iol.unh.edu>
References: <20260827172208.139769-1-abailey@iol.unh.edu>
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

Previously, the cryptodev throughput test suite only allowed for
a small set of algorithms to be tested for a set number of operations.
This is undesirable as a user may want to test one of the hundreds of
possible combinations rather than the much smaller preset tests
previously available. This commit adds support for proper test
configuration of the cryptodev throughput test suite to provide total
coverage of all algorithms.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/api/cryptodev/__init__.py                |  12 +
 dts/api/cryptodev/config.py                  |  47 +
 dts/configurations/nodes.example.yaml        |   2 +-
 dts/configurations/tests_config.example.yaml |  48 +-
 dts/framework/params/__init__.py             |   2 +-
 dts/tests/TestSuite_cryptodev_throughput.py  | 979 ++++++++-----------
 6 files changed, 523 insertions(+), 567 deletions(-)

diff --git a/dts/api/cryptodev/__init__.py b/dts/api/cryptodev/__init__.py
index 15cffcb409..4187c99c1b 100644
--- a/dts/api/cryptodev/__init__.py
+++ b/dts/api/cryptodev/__init__.py
@@ -78,6 +78,18 @@ def vector_directory(self) -> PurePath:
         """
         return get_ctx().dpdk_build.remote_dpdk_tree_path.joinpath("app/test-crypto-perf/data/")
 
+    def update_params(self, **app_params: Unpack["CryptoPmdParamsDict"]) -> None:
+        """Update the app parameters.
+
+        Args:
+            app_params: app parameters to pass to dpdk-test-crypto-perf application
+        """
+        for k, v in app_params.items():
+            if v is not None:
+                self._app_params[k] = (
+                    self.vector_directory.joinpath(str(v)) if k == "test_file" else v
+                )
+
     def run_app(self, num_vfs: int = 1) -> list[CryptodevResults]:
         """Run the cryptodev application with the given app parameters.
 
diff --git a/dts/api/cryptodev/config.py b/dts/api/cryptodev/config.py
index 69ff7aa59a..7263416e8a 100644
--- a/dts/api/cryptodev/config.py
+++ b/dts/api/cryptodev/config.py
@@ -515,3 +515,50 @@ class CryptoPmdParams(EalParams):
     test_name: str | None = field(default=None, metadata=Params.long("test-name"))
     tls_version: TLSVersion | None = field(default=None, metadata=Params.long("tls-version"))
     total_ops: int | None = field(default=100000, metadata=Params.long("total-ops"))
+
+
+# Algorithm parameter mappings for automatic key/IV size determination
+CIPHER_ALGORITHM_PARAMS = {
+    CipherAlgorithm.aes_cbc: {"key_size": 16, "iv_size": 16},
+    CipherAlgorithm.aes_ctr: {"key_size": 16, "iv_size": 16},
+    CipherAlgorithm.aes_gcm: {"key_size": 16, "iv_size": 16},
+    CipherAlgorithm.aes_ecb: {"key_size": 16, "iv_size": 16},
+    CipherAlgorithm.aes_f8: {"key_size": 16, "iv_size": 16},
+    CipherAlgorithm.aes_xts: {"key_size": 16, "iv_size": 16},
+    CipherAlgorithm.arc4: {"key_size": 16, "iv_size": 16},
+    CipherAlgorithm.null: {"key_size": 16, "iv_size": 16},
+    CipherAlgorithm.aes_docsisbpi: {"key_size": 32, "iv_size": 16},
+    CipherAlgorithm.snow3g_uea2: {"key_size": 16, "iv_size": 16},
+    CipherAlgorithm.zuc_eea3: {"key_size": 16, "iv_size": 16},
+    CipherAlgorithm.kasumi_f8: {"key_size": 16, "iv_size": 8},
+    CipherAlgorithm.three_des_cbc: {"key_size": 8, "iv_size": 8},
+    CipherAlgorithm.three_des_ecb: {"key_size": 24, "iv_size": 8},
+    CipherAlgorithm.three_des_ctr: {"key_size": 24, "iv_size": 8},
+}
+
+AUTHENTICATION_ALGORITHM_PARAMS = {
+    AuthenticationAlgorithm.sha1: {"key_size": 20, "iv_size": 0, "digest_size": 20},
+    AuthenticationAlgorithm.sha1_hmac: {"key_size": 64, "iv_size": 20, "digest_size": 12},
+    AuthenticationAlgorithm.sha2_224: {"key_size": 20, "iv_size": 0, "digest_size": 20},
+    AuthenticationAlgorithm.sha2_224_hmac: {"key_size": 20, "iv_size": 0, "digest_size": 20},
+    AuthenticationAlgorithm.sha2_256: {"key_size": 64, "iv_size": 0, "digest_size": 32},
+    AuthenticationAlgorithm.sha2_256_hmac: {"key_size": 64, "iv_size": 0, "digest_size": 32},
+    AuthenticationAlgorithm.sha2_384: {"key_size": 48, "iv_size": 0, "digest_size": 48},
+    AuthenticationAlgorithm.sha2_384_hmac: {"key_size": 48, "iv_size": 0, "digest_size": 48},
+    AuthenticationAlgorithm.sha2_512: {"key_size": 64, "iv_size": 0, "digest_size": 64},
+    AuthenticationAlgorithm.sha2_512_hmac: {"key_size": 64, "iv_size": 0, "digest_size": 64},
+    AuthenticationAlgorithm.md5: {"key_size": 16, "iv_size": 0, "digest_size": 16},
+    AuthenticationAlgorithm.md5_hmac: {"key_size": 16, "iv_size": 0, "digest_size": 16},
+    AuthenticationAlgorithm.snow3g_uia2: {"key_size": 16, "iv_size": 16, "digest_size": 4},
+    AuthenticationAlgorithm.zuc_eia3: {"key_size": 16, "iv_size": 16, "digest_size": 4},
+    AuthenticationAlgorithm.kasumi_f9: {"key_size": 16, "iv_size": 0, "digest_size": 4},
+    AuthenticationAlgorithm.aes_gmac: {"key_size": 16, "iv_size": 16, "digest_size": 16},
+    AuthenticationAlgorithm.aes_xcbc_mac: {"key_size": 16, "iv_size": 0, "digest_size": 12},
+    AuthenticationAlgorithm.aes_cmac: {"key_size": 16, "iv_size": 0, "digest_size": 16},
+    AuthenticationAlgorithm.aes_cbc_mac: {"key_size": 16, "iv_size": 0, "digest_size": 16},
+}
+
+AEAD_ALGORITHM_PARAMS = {
+    AeadAlgName.aes_gcm: {"key_size": 16, "iv_size": 12, "aad_size": 16, "digest_size": 16},
+    AeadAlgName.aes_ccm: {"key_size": 16, "iv_size": 11, "aad_size": 16, "digest_size": 16},
+}
diff --git a/dts/configurations/nodes.example.yaml b/dts/configurations/nodes.example.yaml
index 334de68f97..ccda20fb87 100644
--- a/dts/configurations/nodes.example.yaml
+++ b/dts/configurations/nodes.example.yaml
@@ -9,7 +9,7 @@
 #   `crypto_device_type`:
 #     Uncomment to run cryptodev tests; the device type of the DUT e.g. (crypto_qat, crypto_zuc,
 #     crypto_aesni_mb); the complete list of device types can be found here
-#     https://doc.dpdk.org/guides-24.07/cryptodevs/overview.html
+#     https://doc.dpdk.org/guides-26.07/cryptodevs/overview.html
 
 # Define a system under test node, having two network ports physically
 # connected to the corresponding ports in TG 1 (the peer node)
diff --git a/dts/configurations/tests_config.example.yaml b/dts/configurations/tests_config.example.yaml
index ce67385b0b..fe4bed2847 100644
--- a/dts/configurations/tests_config.example.yaml
+++ b/dts/configurations/tests_config.example.yaml
@@ -2,10 +2,13 @@
 
 # Optional Fields:
 #   All fields are optional, uncomment a test suite to run it with a specific configuration.
+#   cryptodev_throughput:
+#       algorithms: https://doc.dpdk.org/guides-26.07/cryptodevs/overview.html
 
 # Define the custom test suite configurations
 hello_world:
   msg: A custom hello world to you!
+
 # single_core_forward_perf:
 #   test_parameters: # Add frame size / descriptor count combinations as needed
 #     - frame_size: 64
@@ -18,18 +21,51 @@ hello_world:
 #       num_descriptors: 1024
 #       expected_mpps: 1.0
 #   delta_tolerance: 0.05
+
 # pmd_rss:
 #   NUM_QUEUES: 4
 #   ACTUAL_KEY_SIZE: 52
 #   ACTUAL_RETA_SIZE: 512
+
 # cryptodev_throughput:
 #   delta_tolerance: 0.05
-#   throughput_test_parameters:
-#     snow3g_uea2_snow3g_uia2: # Add the name of the test suite you would like to run
-#      - buff_size: 64
-#        Gbps: 2.0 # Set gigabits per second according to your devices throughput for this given buffer size
-#      - buff_size: 512
-#        Gbps: 20.0
+#   test_combinations:
+#     - name: "example cipher test" # Add a name for this test config
+#       cipher_algorithm: "aes_cbc" # See `algortihms` in `Optional Fields` for a complete list
+#       virtual_device: "crypto_openssl" # uncomment to run with a virtual device.
+#       test_parameters:  # Buffer sizes and expected throughput, a default is used if not present
+#         - buff_size: 64
+#           Gbps: 1.5 # Set gigabits per second for your devices throughput for this buffer size
+#         - buff_size: 512
+#           Gbps: 3.0
+#         - buff_size: 2048
+#           Gbps: 4.0
+#     - name: "example authentication test"
+#       auth_algorithm: "aes_cbc_mac" # See `algortihms` in `Optional Fields` for a complete list
+#       test_parameters:
+#         - buff_size: 64
+#           Gbps: 1.5
+#     - name: "example cipher then auth test"
+#       ops: 30000000 # Specify total ops to use, 10000000 is used by default
+#       cipher_algorithm: "aes_cbc" # See `algortihms` in `Optional Fields` for a complete list
+#       auth_algorithm: "aes_cbc_mac" # See `algortihms` in `Optional Fields` for a complete list
+#       cipher_key_size: 16
+#       cipher_iv_size: 0
+#       auth_key_size: 16 # Specify key size, a default is used if field is not present
+#       auth_iv_size: 0 # Specify IV size, a default is used if field is not present
+#       test_parameters:
+#         - buff_size: 64
+#           Gbps: 1.5
+#     - name: "example aead test"
+#       aead_algorithm: "aes_gcm" # See `algortihms` in `Optional Fields` for a complete list
+#       aead_key_sz: 16
+#       aead_iv_sz: 16
+#       aead_aad_sz: 16 # Specify AAD size, a default is used if field not present
+#       digest_sz: 16 # Specify a digest size, a default is used if not present
+#       test_parameters:
+#         - buff_size: 64
+#           Gbps: 1.5
+
 # port_speed_capabilities:
 #   test_parameters:
 #     0 : 100 Gbps # Assign an expected link speed to a port ID in Gbps
diff --git a/dts/framework/params/__init__.py b/dts/framework/params/__init__.py
index b5bae9dad9..04e2c0f386 100644
--- a/dts/framework/params/__init__.py
+++ b/dts/framework/params/__init__.py
@@ -334,7 +334,7 @@ def _make_switch(
         """
         prefix = f"{'-' if is_short else '--'}{'no-' if is_no else ''}"
         name = name.replace("_", "-")
-        value = f"{' ' if is_short else '='}{value}" if value else ""
+        value = f"{' ' if is_short else '='}{value}" if value or value == 0 else ""
         return f"{prefix}{name}{value}"
 
     def __str__(self) -> str:
diff --git a/dts/tests/TestSuite_cryptodev_throughput.py b/dts/tests/TestSuite_cryptodev_throughput.py
index 2fc0d8779a..08718f3cd0 100644
--- a/dts/tests/TestSuite_cryptodev_throughput.py
+++ b/dts/tests/TestSuite_cryptodev_throughput.py
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
@@ -29,9 +34,9 @@
 from api.cryptodev.types import (
     CryptodevResults,
 )
-from api.test import verify
+from api.test import fail, skip, verify
 from framework.context import get_ctx
-from framework.exception import SkippedTestException
+from framework.exception import ConfigurationError, SkippedTestException, TestCaseVerifyError
 from framework.test_suite import BaseConfig, TestSuite, crypto_test
 from framework.testbed_model.virtual_device import VirtualDevice
 
@@ -41,37 +46,57 @@
     {"buff_size": 2048, "Gbps": 1.00},
 ]
 
-TOTAL_OPS = 10_000_000
-
 
 class Config(BaseConfig):
     """Performance test metrics.
 
     Attributes:
         delta_tolerance: The allowed tolerance below a given baseline.
-        throughput_test_parameters: The test parameters to use in the test suite.
+        test_combinations: List of test combinations with cipher/auth algorithms and parameters.
     """
 
     delta_tolerance: float = 0.05
-
-    throughput_test_parameters: dict[str, list[dict[str, int | float | str]]] = {
-        "aes_cbc": config_list,
-        "aes_cbc_sha1": config_list,
-        "aes_cbc_sha2": config_list,
-        "aes_cbc_sha2_digest_16": config_list,
-        "aead_aes_gcm": config_list,
-        "aes_docsisbpi": config_list,
-        "sha1_hmac": config_list,
-        "snow3g_uea2_snow3g_uia2": config_list,
-        "zuc_eea3_zuc_eia3": config_list,
-        "kasumi_f8_kasumi_f9": config_list,
-        "open_ssl_vdev": config_list,
-        "aesni_mb_vdev": config_list,
-        "aesni_gcm_vdev": config_list,
-        "kasumi_vdev": config_list,
-        "zuc_vdev": config_list,
-        "snow3g_vdev": config_list,
-    }
+    test_combinations: list[dict[str, Any]] = [
+        #: cipher only tests
+        {
+            "name": "aes-cbc (cipher only)",
+            "cipher_algorithm": CipherAlgorithm.aes_cbc.name,
+        },
+        {
+            "name": "aead-docsisbpi (cipher only)",
+            "cipher_algorithm": CipherAlgorithm.aes_docsisbpi.name,
+        },
+        #: authentication only tests
+        {
+            "name": "sha1-hmac (auth only)",
+            "auth_algorithm": AuthenticationAlgorithm.sha1_hmac.name,
+            "auth_iv_size": 16,
+        },
+        #: cipher then auth tests
+        {
+            "name": "aes-cbc/sha1-hmac (cipher then auth)",
+            "cipher_algorithm": CipherAlgorithm.aes_cbc.name,
+            "auth_algorithm": AuthenticationAlgorithm.sha1_hmac.name,
+            "virtual_device": "crypto_openssl",
+        },
+        {
+            "name": "aes-cbc/sha2-256-hmac (cipher then auth)",
+            "cipher_algorithm": CipherAlgorithm.aes_cbc.name,
+            "auth_algorithm": AuthenticationAlgorithm.sha2_256_hmac.name,
+            "virtual_device": "crypto_openssl",
+        },
+        {
+            "name": "aes-cbc/sha2-256-hmac/digest-16 (cipher then auth)",
+            "cipher_algorithm": CipherAlgorithm.aes_cbc.name,
+            "auth_algorithm": AuthenticationAlgorithm.sha2_256_hmac.name,
+            "digest_size": 16,
+        },
+        #: aead tests
+        {
+            "name": "aead-aes-gcm",
+            "aead_algorithm": AeadAlgName.aes_gcm.name,
+        },
+    ]
 
 
 @requires_link_topology(LinkTopology.NO_LINK)
@@ -81,60 +106,137 @@ class TestCryptodevThroughput(TestSuite):
     config: Config
 
     def set_up_suite(self) -> None:
-        """Set up the test suite."""
-        self.throughput_test_parameters: dict[str, list[dict[str, int | float | str]]] = (
-            self.config.throughput_test_parameters
-        )
+        """Set up the test suite.
+
+        Raises:
+            ConfigurationError: When a test config contains no algorithm to test.
+        """
+        self.test_combinations: list[dict[str, Any]] = self.config.test_combinations
         self.delta_tolerance: float = self.config.delta_tolerance
+        self.ops: int = 10_000_000
         self.device_type: DeviceType | None = get_device_from_str(
             str(get_ctx().sut_node.crypto_device_type)
         )
-        self.buffer_sizes = {}
+        self.buffer_sizes: dict[str, ListWrapper] = {}
+
+        # categorize configured tests
+        self.cipher_tests: list[dict[str, Any]] = []
+        self.auth_tests: list[dict[str, Any]] = []
+        self.cipher_then_auth_tests: list[dict[str, Any]] = []
+        self.aead_tests: list[dict[str, Any]] = []
+
+        # Filter tests by operation types
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
 
-        for k, v in self.throughput_test_parameters.items():
-            self.buffer_sizes[k] = ListWrapper([int(run["buff_size"]) for run in v])
+    def _print_and_verify(self, all_results: list[list[dict[str, int | float | str]]]) -> None:
+        """Print the given results and verify all results have passed.
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
 
     def _print_stats(self, test_vals: list[dict[str, int | float | str]]) -> None:
+        """Print the stats of the given test values in a clean format.
+
+        Args:
+            test_vals: the testing values to print
+        """
+        assert len(test_vals) > 0, "test_vals must contain at least one element"
+
         element_len = len("Delta Tolerance")
-        border_len = (element_len + 1) * (len(test_vals[0]))
+        border_len = (element_len + 1) * (len(test_vals[0]) - 1)
+        test_name = test_vals[0]["Test Name"]
 
-        print(f"{'Throughput Results'.center(border_len)}\n{'=' * border_len}")
+        print(f"{f'{test_name} Throughput Results'.center(border_len)}\n{'=' * border_len}")
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
 
-    def _verify_throughput(
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
+            results: The results of the dpdk crypto perf app ran in throughput mode.
+            params: The baselines to compare the given results to.
+            test_name: The test name to pin to the result summary.
+
+        Returns:
+            A summary of throughput statistics for a test and whether the test passed.
+
+        Raises:
+            RuntimeError: When there are no baselines for a given result.
+        """
         result_list: list[dict[str, int | float | str]] = []
 
         for result in results:
             # get the corresponding baseline for the current buffer size
-            parameters: dict[str, int | float | str] = list(
+            parameters: dict[str, int | float | str] = next(
                 filter(
                     lambda x: x["buff_size"] == result.buffer_size,
-                    self.throughput_test_parameters[key],
-                )
-            )[0]
+                    params,
+                ),
+                {},
+            )
+            errmsg = (
+                f"No test parameters found for {test_name} with buffer size {result.buffer_size}"
+            )
+            if parameters == {}:
+                raise RuntimeError(errmsg)
             test_result = True
             expected_gbps = parameters["Gbps"]
             measured_delta = abs(
                 round((getattr(result, "gbps") - expected_gbps) / expected_gbps, 5)
             )
-
             # result did not meet the given Gbps parameter, check if within delta.
             if getattr(result, "gbps") < expected_gbps:
                 if self.delta_tolerance < measured_delta:
                     test_result = False
+
             result_list.append(
                 {
+                    "Test Name": test_name,
                     "Buffer Size": parameters["buff_size"],
                     "Gbps delta": measured_delta,
                     "delta tolerance": self.delta_tolerance,
@@ -146,550 +248,309 @@ def _verify_throughput(
         return result_list
 
     @crypto_test
-    def aes_cbc(self) -> None:
-        """aes_cbc test.
-
-        Steps:
-            * Create a cryptodev instance with provided device type and buffer sizes.
-        Verify:
-            * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
-
-        Raises:
-            SkippedTestException: When configuration is not provided.
-        """
-        if "aes_cbc" not in self.throughput_test_parameters:
-            raise SkippedTestException("test not configured")
-        app = Cryptodev(
-            ptest=TestType.throughput,
-            devtype=self.device_type,
-            optype=OperationType.cipher_only,
-            cipher_algo=CipherAlgorithm.aes_cbc,
-            cipher_op=EncryptDecryptSwitch.encrypt,
-            cipher_key_sz=16,
-            cipher_iv_sz=16,
-            total_ops=TOTAL_OPS,
-            buffer_sz=self.buffer_sizes["aes_cbc"],
-        )
-        results = self._verify_throughput(app.run_app(), "aes_cbc")
-        self._print_stats(results)
-        for result in results:
-            verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
-
-    @crypto_test
-    def aes_cbc_sha1(self) -> None:
-        """aes_cbc_sha1 test.
-
-        Steps:
-            * Create a cryptodev instance with provided device type and buffer sizes.
-        Verify:
-            * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
-
-        Raises:
-            SkippedTestException: When configuration is not provided.
-        """
-        if "aes_cbc_sha1" not in self.throughput_test_parameters:
-            raise SkippedTestException("test not configured")
-        app = Cryptodev(
-            ptest=TestType.throughput,
-            devtype=self.device_type,
-            optype=OperationType.cipher_then_auth,
-            cipher_algo=CipherAlgorithm.aes_cbc,
-            cipher_op=EncryptDecryptSwitch.encrypt,
-            cipher_key_sz=16,
-            cipher_iv_sz=16,
-            auth_algo=AuthenticationAlgorithm.sha1_hmac,
-            auth_op=AuthenticationOpMode.generate,
-            auth_key_sz=64,
-            auth_iv_sz=20,
-            digest_sz=12,
-            total_ops=TOTAL_OPS,
-            buffer_sz=self.buffer_sizes["aes_cbc_sha1"],
-        )
-        results = self._verify_throughput(app.run_app(), "aes_cbc_sha1")
-        self._print_stats(results)
-        for result in results:
-            verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
-
-    @crypto_test
-    def aes_cbc_sha2(self) -> None:
-        """aes_cbc_sha2 test.
-
-        Steps:
-            * Create a cryptodev instance with provided device type and buffer sizes.
-        Verify:
-            * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
-
-        Raises:
-            SkippedTestException: When configuration is not provided.
-        """
-        if "aes_cbc_sha2" not in self.throughput_test_parameters:
-            raise SkippedTestException("test not configured")
-        app = Cryptodev(
-            ptest=TestType.throughput,
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
-            total_ops=TOTAL_OPS,
-            buffer_sz=self.buffer_sizes["aes_cbc_sha2"],
-        )
-        results = self._verify_throughput(app.run_app(), "aes_cbc_sha2")
-        self._print_stats(results)
-        for result in results:
-            verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
-
-    @crypto_test
-    def aes_cbc_sha2_digest_16(self) -> None:
-        """aes_cbc_sha2_digest_16 test.
-
-        Steps:
-            * Create a cryptodev instance with provided device type and buffer sizes.
-        Verify:
-            * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
-
-        Raises:
-            SkippedTestException: When configuration is not provided.
-        """
-        if "aes_cbc_sha2_digest_16" not in self.throughput_test_parameters:
-            raise SkippedTestException("test not configured")
-        app = Cryptodev(
-            ptest=TestType.throughput,
-            devtype=self.device_type,
-            optype=OperationType.cipher_then_auth,
-            cipher_algo=CipherAlgorithm.aes_cbc,
-            cipher_op=EncryptDecryptSwitch.encrypt,
-            cipher_key_sz=16,
-            cipher_iv_sz=16,
-            auth_algo=AuthenticationAlgorithm.sha2_256_hmac,
-            auth_op=AuthenticationOpMode.generate,
-            auth_key_sz=64,
-            digest_sz=16,
-            total_ops=TOTAL_OPS,
-            buffer_sz=self.buffer_sizes["aes_cbc_sha2_digest_16"],
-        )
-        results = self._verify_throughput(app.run_app(), "aes_cbc_sha2_digest_16")
-        self._print_stats(results)
-        for result in results:
-            verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
-
-    @crypto_test
-    def aead_aes_gcm(self) -> None:
-        """aead_aes_gcm test.
-
-        Steps:
-            * Create a cryptodev instance with provided device type and buffer sizes.
-        Verify:
-            * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
-
-        Raises:
-            SkippedTestException: When configuration is not provided.
-        """
-        if "aead_aes_gcm" not in self.throughput_test_parameters:
-            raise SkippedTestException("test not configured")
-        app = Cryptodev(
-            ptest=TestType.throughput,
-            devtype=self.device_type,
-            optype=OperationType.aead,
-            aead_algo=AeadAlgName.aes_gcm,
-            aead_op=EncryptDecryptSwitch.encrypt,
-            aead_key_sz=16,
-            aead_iv_sz=12,
-            aead_aad_sz=16,
-            digest_sz=16,
-            total_ops=TOTAL_OPS,
-            buffer_sz=self.buffer_sizes["aead_aes_gcm"],
-        )
-        results = self._verify_throughput(app.run_app(), "aead_aes_gcm")
-        self._print_stats(results)
-        for result in results:
-            verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
-
-    @crypto_test
-    def aes_docsisbpi(self) -> None:
-        """aes_docsisbpi test.
-
-        Steps:
-            * Create a cryptodev instance with provided device type and buffer sizes.
-        Verify:
-            * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
-
-        Raises:
-            SkippedTestException: When configuration is not provided.
-        """
-        if "aes_docsisbpi" not in self.throughput_test_parameters:
-            raise SkippedTestException("test not configured")
-        app = Cryptodev(
-            ptest=TestType.throughput,
-            devtype=self.device_type,
-            optype=OperationType.cipher_only,
-            cipher_algo=CipherAlgorithm.aes_docsisbpi,
-            cipher_op=EncryptDecryptSwitch.encrypt,
-            cipher_key_sz=32,
-            cipher_iv_sz=16,
-            total_ops=TOTAL_OPS,
-            buffer_sz=self.buffer_sizes["aes_docsisbpi"],
-        )
-        results = self._verify_throughput(app.run_app(), "aes_docsisbpi")
-        self._print_stats(results)
-        for result in results:
-            verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
-
-    @crypto_test
-    def sha1_hmac(self) -> None:
-        """sha1_hmac test.
-
-        Steps:
-            * Create a cryptodev instance with provided device type and buffer sizes.
-        Verify:
-            * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
-
-        Raises:
-            SkippedTestException: When configuration is not provided.
-        """
-        if "sha1_hmac" not in self.throughput_test_parameters:
-            raise SkippedTestException("test not configured")
-        app = Cryptodev(
-            ptest=TestType.throughput,
-            devtype=self.device_type,
-            optype=OperationType.auth_only,
-            auth_algo=AuthenticationAlgorithm.sha1_hmac,
-            auth_op=AuthenticationOpMode.generate,
-            auth_key_sz=64,
-            auth_iv_sz=16,
-            digest_sz=12,
-            total_ops=TOTAL_OPS,
-            buffer_sz=self.buffer_sizes["sha1_hmac"],
-        )
-        results = self._verify_throughput(app.run_app(), "sha1_hmac")
-        self._print_stats(results)
-        for result in results:
-            verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
-
-    @crypto_test
-    def snow3g_uea2_snow3g_uia2(self) -> None:
-        """snow3g_uea2_snow3g_uia2 test.
-
-        Steps:
-            * Create a cryptodev instance with provided device type and buffer sizes.
-        Verify:
-            * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
-
-        Raises:
-            SkippedTestException: When configuration is not provided.
-        """
-        if "snow3g_uea2_snow3g_uia2" not in self.throughput_test_parameters:
-            raise SkippedTestException("test not configured")
-        app = Cryptodev(
-            ptest=TestType.throughput,
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
-        results = self._verify_throughput(app.run_app(), "snow3g_uea2_snow3g_uia2")
-        self._print_stats(results)
-        for result in results:
-            verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
-
-    @crypto_test
-    def zuc_eea3_zuc_eia3(self) -> None:
-        """zuc_eea3_zuc_eia3 test.
+    def cipher_only_tests(self) -> None:
+        """Cipher only cryptography device tests.
 
         Steps:
-            * Create a cryptodev instance with provided device type and buffer sizes.
+            * Run dpdk-test-crypto-perf application with configured arguments in cipher only mode.
         Verify:
-            * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
-
-        Raises:
-            SkippedTestException: When configuration is not provided.
+            * The reported Gbps is within a defined tolerance of a given baseline.
         """
-        if "zuc_eea3_zuc_eia3" not in self.throughput_test_parameters:
-            raise SkippedTestException("test not configured")
-        app = Cryptodev(
-            ptest=TestType.throughput,
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
-        results = self._verify_throughput(app.run_app(), "zuc_eea3_zuc_eia3")
-        self._print_stats(results)
-        for result in results:
-            verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
-
-    @crypto_test
-    def kasumi_f8_kasumi_f9(self) -> None:
-        """kasumi_f8 kasumi_f9 test.
 
-        Steps:
-            * Create a cryptodev instance with provided device type and buffer sizes.
-        Verify:
-            * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
-
-        Raises:
-            SkippedTestException: When configuration is not provided.
-        """
-        if "kasumi_f8_kasumi_f9" not in self.throughput_test_parameters:
-            raise SkippedTestException("test not configured")
-        app = Cryptodev(
-            ptest=TestType.throughput,
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
-        results = self._verify_throughput(app.run_app(), "kasumi_f8_kasumi_f9")
-        self._print_stats(results)
-        for result in results:
-            verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
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
+                ptest=TestType.throughput,
+                devtype=self.device_type,
+                optype=OperationType.cipher_only,
+                cipher_algo=CipherAlgorithm[combination["cipher_algorithm"]],
+                cipher_op=encrypt,
+                cipher_key_sz=combination.get("cipher_key_size", cipher_params["key_size"]),
+                cipher_iv_sz=combination.get("cipher_iv_size", cipher_params["iv_size"]),
+                digest_sz=combination.get("digest_size", 0),
+                total_ops=combination.get("ops", self.ops),
+                buffer_sz=self.buffer_sizes[combination.get("name", "custom_test")],
+            )
+            if is_vdev:
+                app.update_params(
+                    vdevs=[VirtualDevice(combination["virtual_device"])],
+                    devtype=get_device_from_str(combination["virtual_device"]),
+                )
 
-    # BEGIN VDEV TESTS
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
-    def aesni_mb_vdev(self) -> None:
-        """aesni_mb virtual device test.
+    def auth_only_tests(self) -> None:
+        """Authentication cryptography device tests.
 
         Steps:
-            * Create a cryptodev instance with crypto_aesni_mb and supplied buffer sizes.
+            * Run dpdk-test-crypto-perf application with configured parameters in authentication
+                only moode.
         Verify:
-            * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
-
-        Raises:
-            SkippedTestException: When configuration is not provided.
+            * The resulting Gbps is within a delta tolerance of a provided baseline.
         """
-        if "aesni_mb_vdev" not in self.throughput_test_parameters:
-            raise SkippedTestException("test not configured")
-        app = Cryptodev(
-            ptest=TestType.throughput,
-            vdevs=[VirtualDevice("crypto_aesni_mb0")],
-            devtype=DeviceType.crypto_aesni_mb,
-            optype=OperationType.cipher_then_auth,
-            cipher_algo=CipherAlgorithm.aes_cbc,
-            cipher_op=EncryptDecryptSwitch.encrypt,
-            cipher_key_sz=32,
-            cipher_iv_sz=16,
-            auth_algo=AuthenticationAlgorithm.sha1_hmac,
-            auth_op=AuthenticationOpMode.generate,
-            auth_key_sz=16,
-            auth_iv_sz=16,
-            digest_sz=4,
-            burst_sz=32,
-            total_ops=TOTAL_OPS,
-            buffer_sz=self.buffer_sizes["aesni_mb_vdev"],
-        )
-        results = self._verify_throughput(app.run_app(num_vfs=0), "aesni_mb_vdev")
-        self._print_stats(results)
-        for result in results:
-            verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
-
-    @crypto_test
-    def aesni_gcm_vdev(self):
-        """aesni_gcm virtual device test.
 
-        Steps:
-            * Create a cryptodev instance with crypto_aesni_gcm and supplied buffer sizes.
-        Verify:
-            * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
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
+                ptest=TestType.throughput,
+                devtype=self.device_type,
+                optype=OperationType.auth_only,
+                auth_algo=AuthenticationAlgorithm[combination["auth_algorithm"]],
+                auth_op=op_mode,
+                auth_key_sz=combination.get("auth_key_size", auth_params["key_size"]),
+                auth_iv_sz=combination.get("auth_iv_size", auth_params["iv_size"]),
+                total_ops=combination.get("ops", self.ops),
+                digest_sz=combination.get("digest_size", 0),
+                buffer_sz=self.buffer_sizes[combination["name"]],
+            )
+            if is_vdev:
+                app.update_params(
+                    vdevs=[VirtualDevice(combination["virtual_device"])],
+                    devtype=get_device_from_str(combination["virtual_device"]),
+                )
 
-        Raises:
-            SkippedTestException: When configuration is not provided.
-        """
-        if "aesni_gcm_vdev" not in self.throughput_test_parameters:
-            raise SkippedTestException("test not configured")
-        app = Cryptodev(
-            ptest=TestType.throughput,
-            vdevs=[VirtualDevice("crypto_aesni_gcm0")],
-            devtype=DeviceType.crypto_aesni_gcm,
-            optype=OperationType.aead,
-            aead_algo=AeadAlgName.aes_gcm,
-            aead_op=EncryptDecryptSwitch.encrypt,
-            aead_key_sz=16,
-            aead_iv_sz=12,
-            aead_aad_sz=16,
-            digest_sz=16,
-            total_ops=TOTAL_OPS,
-            buffer_sz=self.buffer_sizes["aesni_gcm_vdev"],
-        )
-        results = self._verify_throughput(app.run_app(num_vfs=0), "aesni_gcm_vdev")
-        self._print_stats(results)
-        for result in results:
-            verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
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
-    def kasumi_vdev(self) -> None:
-        """Kasmumi virtual device test.
+    def aead_test(self) -> None:
+        """Aead cryptography test.
 
         Steps:
-            * Create a cryptodev instance with crypto_kasumi and supplied buffer sizes.
+            * Run dpdk-test-crypto-perf application with configured parameters in aead mode.
         Verify:
-            * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
-
-        Raises:
-            SkippedTestException: When configuration is not provided.
+            * The resulting Gbps is within a delta tolerance of a given baseline.
         """
-        if "kasumi_vdev" not in self.throughput_test_parameters:
-            raise SkippedTestException("test not configured")
-        app = Cryptodev(
-            vdevs=[VirtualDevice("crypto_kasumi0")],
-            ptest=TestType.throughput,
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
-        results = self._verify_throughput(app.run_app(num_vfs=0), "kasumi_vdev")
-        self._print_stats(results)
-        for result in results:
-            verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
-
-    @crypto_test
-    def snow3g_vdev(self) -> None:
-        """snow3g virtual device test.
 
-        Steps:
-            * Create a cryptodev instance with crypto_snow3g and supplied buffer sizes.
-        Verify:
-            * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
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
+                ptest=TestType.throughput,
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
+            )
+            if is_vdev:
+                app.update_params(
+                    vdevs=[VirtualDevice(combination["virtual_device"])],
+                    devtype=get_device_from_str(combination["virtual_device"]),
+                )
+            if combination.get("aead_op", None) == EncryptDecryptSwitch.decrypt:
+                app.update_params(
+                    out_of_place=combination.get("out_of_place", True),
+                )
 
-        Raises:
-            SkippedTestException: When configuration is not provided.
-        """
-        if "snow3g_vdev" not in self.throughput_test_parameters:
-            raise SkippedTestException("test not configured")
-        app = Cryptodev(
-            ptest=TestType.throughput,
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
-            digest_sz=4,
-            burst_sz=32,
-            total_ops=TOTAL_OPS,
-            buffer_sz=self.buffer_sizes["snow3g_vdev"],
-        )
-        results = self._verify_throughput(app.run_app(num_vfs=0), "snow3g_vdev")
-        self._print_stats(results)
-        for result in results:
-            verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
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
-    def zuc_vdev(self) -> None:
-        """Zuc virtual device test.
+    def cipher_and_auth_tests(self) -> None:
+        """Cipher and Authentication tests.
 
         Steps:
-            * Create a cryptodev instance with crypto_zuc and supplied buffer sizes.
+            * Run dpdk-test-crypto-perf application in cipher then authentication mode
         Verify:
-            * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
-
-        Raises:
-            SkippedTestException: When configuration is not provided.
+            * The resulting Gbps is within a delta tolerance of a given baseline.
         """
-        if "zuc_vdev" not in self.throughput_test_parameters:
-            raise SkippedTestException("test not configured")
-        app = Cryptodev(
-            ptest=TestType.throughput,
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
-        results = self._verify_throughput(app.run_app(num_vfs=0), "zuc_vdev")
-        self._print_stats(results)
-        for result in results:
-            verify(result["passed"] == "PASS", "Gbps fell below delta tolerance")
-
-    @crypto_test
-    def open_ssl_vdev(self) -> None:
-        """open_ssl virtual device test.
 
-        Steps:
-            * Create a cryptodev instance with provided device type and buffer sizes.
-        Verify:
-            * The resulting Gbps is greater than expected_gbps*(1-delta_tolerance).
-
-        Raises:
-            SkippedTestException: When configuration is not provided.
-        """
-        if "open_ssl_vdev" not in self.throughput_test_parameters:
-            raise SkippedTestException("test not configured")
-        app = Cryptodev(
-            ptest=TestType.throughput,
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
-        results = self._verify_throughput(app.run_app(num_vfs=0), "open_ssl_vdev")
-        self._print_stats(results)
-        for result in results:
-            verify(
-                result["passed"] == "PASS",
-                "Gbps fell below delta tolerance",
+        def test(
+            encrypt: EncryptDecryptSwitch, op_mode: AuthenticationOpMode
+        ) -> list[dict[str, int | float | str]]:
+            """Execute the dpdk-test-crypto application and verify.
+
+            Args:
+                encrypt: The cipher encryption mode to run throughput testing in.
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
+                ptest=TestType.throughput,
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
+
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

