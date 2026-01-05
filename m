Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69814C79FB9
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Jan 2026 19:07:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8671840667;
	Mon,  5 Jan 2026 20:06:57 +0100 (CET)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by mails.dpdk.org (Postfix) with ESMTP id EE4FE402BA
 for <dev@dpdk.org>; Mon,  5 Jan 2026 20:06:53 +0100 (CET)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-8c305b7c472so16547385a.0
 for <dev@dpdk.org>; Mon, 05 Jan 2026 11:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1767640013; x=1768244813; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qk+NwUw78MFIPGVIRzmzPpePLGSAUmTAk2MUHDeAfHw=;
 b=agueXZZW5qAWD97Sqfu1R6MQkAhi3I0t68V49N6ix9raCjWzY7+p83Qo0jpv8QYkFe
 VZLmwICDwaJ6bFhMrvco3I0IMdg72Q5VdmidElWP/ukZOgf0NNfaXUvSe3W/1i2bG0Dx
 rWNABiBaRrurdAUQvaC7xdOfFJSiLkaqr7ndQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767640013; x=1768244813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Qk+NwUw78MFIPGVIRzmzPpePLGSAUmTAk2MUHDeAfHw=;
 b=prj00niuA6cruGFxBHHNdF71JEWG9D4sANr5wXKK1fCkRv85SIz3En09RpqYgNNI35
 N9dnrq7Y17yxmIHc5WytI61pKiY8ze7vLWWbhZwli/IrvVGeq9c3zKUxQsK2I7Hy2Irj
 RSUIg+z6sG99Ef7tMZ4hOwqWLRSenFmzDa3K3wXXunzP/w9s/QgNXXMb6Z0yJtqDJ5cj
 LINLuoOhgi8I9sFOi7DWng4HzXXNgWh+boK/uhGbLMBWaVsyMxt09fRUcY7yUD4adrJq
 j3qw2HtFMDaSVvApL3k+Kyg3xD+y9aCg4R37JQnMJyn5HxxeFmXbdKFh+8njlCQyFcE9
 6rBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSXBrquhbnK6GxXWOCYEG5b/SeasIk9jZ3KQ0LATYbDLpXIjID8XVEbTyBNdLcUlrLHr8=@dpdk.org
X-Gm-Message-State: AOJu0YxqpG51lepEDYPOCU5pusSUajKkS/S45GfEBRRUOWsVaG+dqdUl
 YLXdalJwIy1vwrAu3m8VYPpTkF6w+7h0I+hjqOCKTE+kmfVMf8G3iXanfgDI2bRVAj0=
X-Gm-Gg: AY/fxX4y1lEv7b2cnF5A57Qp/hTfK9q6GyYXOKlEl/LwY8E6wLQEy2pWDbSYiPHDWUm
 0nlymUm7gMRj/no4KDNJpsLzMTbk5399HpblyXpC3E+eRmZL3vZjdnDi1WYaKFHzqvk5BxeFmiO
 ydgQFemwt1hk9RPX8iHDqK5rY/Vod9r6cRfVVtHKINqNr/iDbLMSca0YN82B/YsxLC+wWn0jemx
 QV7LcTXCXx7fUfWM/Ks/AR6h73DULxOUNjlP2QLrKGcXGo3tu4jWHQVCxW3apGeDPl04ACwVWlD
 ocfGhthdrKudbIHGk9TRUNvsV3qAGrDMTW6ZRDAsDB2Blax5GtGTSBstbdpKz+bbrgDamuRnUWR
 bDOOi/wrAe3ZrZnzOLgIOV1p9mYxAVNiCpKYSwFzSA0/jP9vvvZ+mKXV0bph+H1t27iRq3nf8e9
 C5vZy7mctirxkYbUOOODkOMHg=
X-Google-Smtp-Source: AGHT+IGC58LYG2OKw/U9gSf2ZzqN8+INii7OpHUwe1F33l7zX44QdJQQ9EjZJh2FLucPlFcWmCY66g==
X-Received: by 2002:a05:620a:371a:b0:8b2:dabe:de27 with SMTP id
 af79cd13be357-8c37ebe3cafmr80286985a.85.1767640012873; 
 Mon, 05 Jan 2026 11:06:52 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c37f4b9c9esm12426485a.18.2026.01.05.11.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 11:06:52 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: probb@iol.unh.edu, dmarx@iol.unh.edu, dev@dpdk.org,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [RFC PATCH 3/3] dts: add cryptodev testsuite
Date: Mon,  5 Jan 2026 14:06:47 -0500
Message-ID: <20260105190647.63244-3-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260105190647.63244-1-abailey@iol.unh.edu>
References: <20260105190647.63244-1-abailey@iol.unh.edu>
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

Add cryptodev performance testsuite, which runs the dpdk-test-crypto
application and verifies output to user specified metrics.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/tests/TestSuite_cryptodev_throughput.py | 460 ++++++++++++++++++++
 1 file changed, 460 insertions(+)
 create mode 100644 dts/tests/TestSuite_cryptodev_throughput.py

diff --git a/dts/tests/TestSuite_cryptodev_throughput.py b/dts/tests/TestSuite_cryptodev_throughput.py
new file mode 100644
index 0000000000..adc7b01b99
--- /dev/null
+++ b/dts/tests/TestSuite_cryptodev_throughput.py
@@ -0,0 +1,460 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 University of New Hampshire
+"""DPDK cryptodev performance test suite.
+
+The main goal of this testsuite is to utilize the dpdk-test-cryptodev application to gather
+performance metrics for various cryptographic operations supported by DPDK cryptodev-pmd.
+It will then compare the results against predefined thresholds defined in the test_config file to
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
+from framework.testbed_model.virtual_device import VirtualDevice
+
+
+class Config(BaseConfig):
+    """Performance test metrics."""
+
+    throughput_test_parameters: dict[str, int | float] = {
+        "enqueued": 0,
+        "dequeued": 0,
+        "failed_enqueued": 0,
+        "failed_dequeued": 0,
+        "mops": 0,
+        "gbps": 0,
+        "cycles_per_buffer": 0,
+    }
+
+
+@requires_link_topology(LinkTopology.NO_LINK)
+class TestCryptodevThroughput(TestSuite):
+    """DPDK Crypto Device Testing Suite.
+
+    This test suite is comprised of 8 test cases:
+    1. verify throughput metrics of openssl encrypt virtual device with aes-gcm algorithm
+    2. verify throughput metrics of QAT device encrypt with aes-cbc cipher algorithm and sha256-hmac
+        auth algorithm
+    3. verify throughput metrics of QAT device encrypt with aes-gcm aead algorithm
+    4. verify throughput metrics of QAT device decrypt with aes-docsibpi cipher algorithm
+    5. verify throughput metrics of QAT device encrypt with aes-docsibpi cipher algorithm
+    6. verify throughput metrics of QAT device encrypt with kasumi-f8 cipher algorithm and kasumi-f9
+        auth algorithm
+    7. verify throughput metrics of QAT device encrypt with snow3g-uea2 cipher algorithm and
+        snow3g-uia2 auth algorithm
+    8. verify throughput metrics of QAT device encrypt with zuc-eea3 cipher algorithm and zuc-eia3
+        auth algorithm
+    """
+
+    config: Config
+    unsupported_cryptodevs: list[DeviceType] = []
+
+    def set_up_suite(self) -> None:
+        """Set up the test suite.
+
+        Setup: Retrieve application parameters from the configuration.
+        """
+        self.throughput_test_parameters = self.config.throughput_test_parameters
+
+    def _verify_throughput(self, results: list[CryptodevResults]) -> None:
+        """Verify throughput results against predefined thresholds.
+
+        Arguments:
+            results: The results containing throughput metrics to verify.
+        """
+        for result in results:
+            for key, value in self.throughput_test_parameters.items():
+                result_value = getattr(result, key, None)
+                if result_value is not None:
+                    verify(
+                        result_value > value,
+                        f"Throughput metric {key} is below the threshold: {result_value} < {value}",
+                    )
+
+    def _run_app(self, app: Cryptodev) -> None:
+        """Run the given cryptodev application, print statistics, and verify throughput.
+
+        Arguments:
+            app: The cryptodev application to run and collect data on.
+
+        Raises:
+            SkippedTestException: If the cryptodev application cannot be run with the given
+                configuration.
+        """
+        print("UNSUPPORTED CRYPTO DEVS:", self.unsupported_cryptodevs)
+        try:
+            results: list[CryptodevResults] = app.run_app()
+        except Exception as e:
+            if "devtype" in str(e):
+                self.unsupported_cryptodevs.append(app._app_params["devtype"])
+            print(f"Skipping test: {e}")
+            raise
+        app.print_stats(results)
+        self._verify_throughput(results)
+
+    @func_test
+    def openssl_aead_aes_gcm_encrypt(self) -> None:
+        """Basic test to run on all NICs with openssl virtual device.
+
+        Steps:
+            * Create a Cryptodev application instance with OpenSSL virtual device
+            * Run the application and gather throughput statistics
+
+        Verify:
+            * Throughput results meet predefined thresholds
+        """
+        app = Cryptodev(
+            vdevs=[VirtualDevice("crypto_openssl")],
+            ptest=TestType.throughput,
+            devtype=DeviceType.crypto_openssl,
+            aead_algo=AeadAlgName.aes_gcm,
+            aead_aad_sz=16,
+            aead_key_sz=16,
+            aead_iv_sz=16,
+            digest_sz=16,
+            aead_op=EncryptDecryptSwitch.encrypt,
+            optype=OperationType.aead,
+            total_ops=10_000_000,
+        )
+        self._run_app(app)
+
+    @func_test
+    def qat_cipher_then_auth_aes_cbc_encrypt(self) -> None:
+        """Test throughput on a QAT device with aes-cbc and sha2-256-hmac algorithms.
+
+        Steps:
+            * Create a Cryptodev application instance with QAT device
+                and cipher_then_auth operation with aes-cbc and sha2-256-hmac algorithms
+            * Run the application and gather throughput statistics
+
+        Verify:
+            * Throughput results meet predefined thresholds
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
+            total_ops=10_000_000,
+            burst_sz=32,
+            buffer_sz=ListWrapper([64, 128, 256, 512, 1024, 2048]),
+        )
+        self._run_app(app)
+
+    @func_test
+    def qat_aead_aes_gcm_encrypt(self) -> None:
+        """Test throughput on a QAT device with aes-gcm algorithm.
+
+        Steps:
+            * Create a Cryptodev application instance with QAT device
+                and aead operation with aes-gcm algorithm
+            * Run the application and gather throughput statistics
+
+        Verify:
+            * Throughput results meet predefined thresholds
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
+            total_ops=10_000_000,
+            burst_sz=32,
+            buffer_sz=ListWrapper([64, 128, 256, 512, 1024, 2048]),
+        )
+        self._run_app(app)
+
+    @func_test
+    def qat_cipher_aes_docsisbpi_decrypt(self) -> None:
+        """Test throughput on a QAT device with aes-docsibpi algorithm.
+
+        Steps:
+            * Create a Cryptodev application instance with QAT device
+                and cipher_only operation with aes-docsibpi algorithm
+            * Run the application and gather throughput statistics
+
+        Verify:
+            * Throughput results meet predefined thresholds
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
+            buffer_sz=ListWrapper([40, 64, 70, 128, 256, 512, 1024, 2048]),
+            total_ops=10_000_000,
+        )
+        self._run_app(app)
+
+    @func_test
+    def qat_cipher_aes_docsisbpi_encrypt(self) -> None:
+        """Test throughput on a QAT device with aes-docsibpi algorithm.
+
+        Steps:
+            * Create a Cryptodev application instance with QAT device
+                and cipher_only operation with aes-docsibpi algorithm
+            * Run the application and gather throughput statistics
+
+        Verify:
+            * Throughput results meet predefined thresholds
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
+            buffer_sz=ListWrapper([40, 64, 70, 128, 256, 512, 1024, 2048]),
+            total_ops=10_000_000,
+        )
+        self._run_app(app)
+
+    @func_test
+    def qat_cipher_then_auth_kasumi_f8_encrypt(self) -> None:
+        """Test throughput on a QAT device with kasumi-f8 and kasumi-f9 algorithms.
+
+        Steps:
+            * Create a Cryptodev application instance with QAT device
+                and cipher_then_auth operation with kasumi-f8 and kasumi-f9 algorithms
+            * Run the application and gather throughput statistics
+
+        Verify:
+            * Throughput results meet predefined thresholds
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
+            total_ops=10_000_000,
+            burst_sz=32,
+            buffer_sz=ListWrapper([64, 128, 256, 512, 1024, 2048]),
+        )
+        self._run_app(app)
+
+    @func_test
+    def qat_cipher_then_auth_snow3g_uea2_encrpyt(self) -> None:
+        """Test throughput on a QAT device with snow3g-uea2 and snow3g-uia2 algorithms.
+
+        Steps:
+            * Create a Cryptodev application instance with QAT device
+                and cipher_then_auth operation with snow3g-uea2 and snow3g-uia2 algorithms
+            * Run the application and gather throughput statistics
+
+        Verify:
+            * Throughput results meet predefined thresholds
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
+            total_ops=10_000_000,
+            burst_sz=32,
+            buffer_sz=ListWrapper([64, 128, 256, 512, 1024, 2048]),
+        )
+        self._run_app(app)
+
+    @func_test
+    def qat_cipher_then_auth_zuc_eea3_encrypt(self) -> None:
+        """Test throughput on a QAT device with zuc-eea3 and zuc-eia3 algorithms.
+
+        Steps:
+            * Create a Cryptodev application instance with QAT device
+                and cipher_then_auth operation with zuc-eea3 and zuc-eia3 algorithms
+            * Run the application and gather throughput statistics
+
+        Verify:
+            * Throughput results meet predefined thresholds
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
+            total_ops=10_000_000,
+            burst_sz=32,
+            buffer_sz=ListWrapper([64, 128, 256, 512, 1024, 2048]),
+        )
+        self._run_app(app)
+
+    @func_test
+    def a_wrong_devtype(self) -> None:
+        """Test throughput on a QAT device.
+
+        Steps:
+            * Create a Cryptodev application instance with QAT device
+                and cipher_then_auth operation with aes-cbc and sha2-256-hmac algorithms
+            * Run the application and gather throughput statistics
+
+        Verify:
+            * Throughput results meet predefined thresholds
+        """
+        app = Cryptodev(
+            ptest=TestType.throughput,
+            devtype=DeviceType.crypto_mvsam,
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
+            burst_sz=32,
+            buffer_sz=ListWrapper([64, 128, 256, 512, 1024, 2048]),
+        )
+        self._run_app(app)
+
+    @func_test
+    def anotha_one(self) -> None:
+        """Test throughput on a QAT device.
+
+        Steps:
+            * Create a Cryptodev application instance with QAT device
+                and cipher_then_auth operation with aes-cbc and sha2-256-hmac algorithms
+            * Run the application and gather throughput statistics
+
+        Verify:
+            * Throughput results meet predefined thresholds
+        """
+        app = Cryptodev(
+            ptest=TestType.throughput,
+            devtype=DeviceType.crypto_zuc,
+            optype=OperationType.cipher_then_auth,
+            cipher_algo=CipherAlgorithm.aes_ecb,
+            cipher_op=EncryptDecryptSwitch.encrypt,
+            cipher_key_sz=16,
+            cipher_iv_sz=16,
+            auth_algo=AuthenticationAlgorithm.sha2_256_hmac,
+            auth_op=AuthenticationOpMode.generate,
+            auth_key_sz=64,
+            digest_sz=32,
+            total_ops=10_000_000,
+            burst_sz=32,
+            buffer_sz=ListWrapper([64, 128, 256, 512, 1024, 2048]),
+        )
+        self._run_app(app)
+
+    @func_test
+    def wrong_auth_alg(self) -> None:
+        """Test throughput on a QAT device.
+
+        Steps:
+            * Create a Cryptodev application instance with QAT device
+                and cipher_then_auth operation with aes-cbc and sha2-256-hmac algorithms
+            * Run the application and gather throughput statistics
+
+        Verify:
+            * Throughput results meet predefined thresholds
+        """
+        app = Cryptodev(
+            ptest=TestType.throughput,
+            devtype=DeviceType.crypto_qat,
+            optype=OperationType.cipher_then_auth,
+            cipher_algo=CipherAlgorithm.aes_cbc,
+            cipher_op=EncryptDecryptSwitch.encrypt,
+            cipher_key_sz=16,
+            cipher_iv_sz=16,
+            auth_algo=AuthenticationAlgorithm.md5,
+            auth_op=AuthenticationOpMode.generate,
+            auth_key_sz=64,
+            digest_sz=32,
+            total_ops=10_000_000,
+            burst_sz=32,
+            buffer_sz=ListWrapper([64, 128, 256, 512, 1024, 2048]),
+        )
+        self._run_app(app)
+
+    @func_test
+    def wrong_auth_and_cipher_alg(self) -> None:
+        """Test throughput on a QAT device.
+
+        Steps:
+            * Create a Cryptodev application instance with QAT device
+                and cipher_then_auth operation with aes-cbc and sha2-256-hmac algorithms
+            * Run the application and gather throughput statistics
+
+        Verify:
+            * Throughput results meet predefined thresholds
+        """
+        app = Cryptodev(
+            ptest=TestType.throughput,
+            devtype=DeviceType.crypto_qat,
+            optype=OperationType.cipher_then_auth,
+            cipher_algo=CipherAlgorithm.aes_ecb,
+            cipher_op=EncryptDecryptSwitch.encrypt,
+            cipher_key_sz=16,
+            cipher_iv_sz=16,
+            auth_algo=AuthenticationAlgorithm.md5,
+            auth_op=AuthenticationOpMode.generate,
+            auth_key_sz=64,
+            digest_sz=32,
+            total_ops=10_000_000,
+            burst_sz=32,
+            buffer_sz=ListWrapper([64, 128, 256, 512, 1024, 2048]),
+        )
+        self._run_app(app)
-- 
2.50.1

