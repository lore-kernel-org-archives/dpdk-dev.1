Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AF1C43458
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 13:36:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D533040A7D;
	Mon,  6 Jul 2026 15:35:52 +0200 (CEST)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54]) by mails.dpdk.org (Postfix) with ESMTP id A40AA40A72
 for <dev@dpdk.org>; Mon,  6 Jul 2026 15:35:49 +0200 (CEST)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-8f186025973so33635776d6.0
 for <dev@dpdk.org>; Mon, 06 Jul 2026 06:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1783344949; x=1783949749; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5BggnIEqa/6C0gHY/ZfnUb771MlEFYNml8if7GrKjYk=;
 b=MCzYUPVxfiE/DDSsXhVaWaPfIVCGqkNP1i7OS0ilRiVx9aBKzBhN4w/7QFJLlEKwqy
 jJtlh3AByE1TBDF2E82TOprHdD9heApzgVDbMjuFdZefYAPrdAw7TAEfXkVWHMYvJl4x
 oBLVyxT07/iMuQ2ODRd7LXsoSM11yxDywPe6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783344949; x=1783949749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5BggnIEqa/6C0gHY/ZfnUb771MlEFYNml8if7GrKjYk=;
 b=Y433P6vnTY3roGXl/iMFKIK+KemCsEpj9TN9Vh0u+Dkv45/dL26KAu7H7+zy8DopuQ
 wc1JLpz//QIPRhNRg0RBfk0IN33HH+b7/l4xLDydehZOJqwjUnrTnxwZoZ/kxwz0ddm4
 M6x2qpT/4Cg8IApwKAhSIboBx9/EpwWBK61vbRBDRye/IN31BfC3fbi0syqThAx4GaNN
 6/pWJTdKuhDO7hM16JSDZUkKHQH8o3QkCyPb7QYfyTmA/Ql0hZrz3TZQrPSXE9cFvaIm
 uKVYC2a1e2MW3oCk0qpghogY/EnOyLnxOQFb3q6aa13UO78BXhR/0SnrB2HqSNIzsPG3
 zI6w==
X-Gm-Message-State: AOJu0YxnoQcTCUS75WTT2gD4rcmF58H5aYUQTr/PeiF/KwpFSE3P9rFy
 ooou0XYMYNkw+PCOoY9jBHycjoL19QqeLTtjHocnF61Eg00CcXtLX7eJkaSSQCaUE//cv5Nvk6x
 ylcu0T9VZZkqdlxF+8YNWF0eznXltYBApKKA/mtNyXVwc8KEHmM0wR1KQlmSeds9PLM9QTWEQws
 lWEcpdtaouudunGxpCezzTZMU/U+Y=
X-Gm-Gg: AfdE7cnjN/uzqIbImFDwnUzDQyexohhwZoMbxH5+3mMqg+tJkq4xE9b1cDi199gH8W7
 ZGT3kaJ/MZMq7XkiZExIGdeLNgJoGSx651ZuXNjvIApZ4hNygiR2DpoZziEmlKfhWfHBxgFQ70d
 n4Id6/Av+1RzFrvKHJlUdXfMfwxXLgnH0Y5XkPkIrXNL6UyCBsr/d6I3QSCEnUqWFUDHRNYvWXf
 jlW7nYugbzwlnCSPMiV4shg7eM1tFpevnkCCHySMx4k7xax2lPjMilo8laJ70l/gMmyHxAZC3o7
 xBgH1Ept6D6tdExLQDjrfj/l6Wxa62TJQAKVes3QlWCL18m7U1lqusips5s+E+ogWrP0Z8c8wVz
 7e/477TgWhDH2d5wsfbD22Mh07yUGH0UPAWlbJfstOqG3m+xzMFspdyT1s0DThSuq63J+ffgIBk
 +Py8vv/AObsgq2k0n4UsaBvKILiiPEwFMUjQgvGABLFjiN66UZ7T9saA==
X-Received: by 2002:a05:6214:459c:b0:8f2:4723:d88d with SMTP id
 6a1803df08f44-8fcb1af3590mr5945566d6.4.1783344948664; 
 Mon, 06 Jul 2026 06:35:48 -0700 (PDT)
Received: from d121029.iol.unh.edu ([2606:4100:3880:1210:5d7f:246:cd51:1b62])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f46e27d555sm136081246d6.7.2026.07.06.06.35.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 06:35:48 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v2 3/3] dts: add verify coverage for cryptodev testing
Date: Mon,  6 Jul 2026 09:34:28 -0400
Message-ID: <20260706133428.468816-3-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706133428.468816-1-abailey@iol.unh.edu>
References: <20260514172553.191331-1-abailey@iol.unh.edu>
 <20260706133428.468816-1-abailey@iol.unh.edu>
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

Currently, next-DTS only covers throughput testing through the
dpdk-test-crypto application. This series adds coverage for the verify
option to next DTS to allow functional testing for various algorithms of
crypto devices and virtual devices.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/tests/TestSuite_cryptodev_verify.py | 160 ++++++++++++++++++++++++
 tests.TestSuite_cryptodev_verify.rst    |   8 ++
 2 files changed, 168 insertions(+)
 create mode 100644 dts/tests/TestSuite_cryptodev_verify.py
 create mode 100644 tests.TestSuite_cryptodev_verify.rst

diff --git a/dts/tests/TestSuite_cryptodev_verify.py b/dts/tests/TestSuite_cryptodev_verify.py
new file mode 100644
index 0000000000..d93f93d09d
--- /dev/null
+++ b/dts/tests/TestSuite_cryptodev_verify.py
@@ -0,0 +1,160 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 University of New Hampshire
+
+"""DPDK cryptodev verify test suite.
+
+The main goal of this test suite is to utilize the verify mode of dpdk-test-crypto application
+to ensure functional correctness for various cryptographic operations supported by DPDK
+cryptodev-pmd.
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
+    OperationType,
+    TestType,
+    get_device_from_str,
+)
+from api.cryptodev.types import (
+    CryptodevResults,
+)
+from api.test import verify
+from framework.context import get_ctx
+from framework.test_suite import TestSuite, crypto_test
+from framework.testbed_model.virtual_device import VirtualDevice
+
+TOTAL_OPS = 10_000_000
+AES_CBC_DATA = "test_aes_cbc.data"
+AES_GCM_DATA = "test_aes_gcm.data"
+
+
+@requires_link_topology(LinkTopology.NO_LINK)
+class TestCryptodevVerify(TestSuite):
+    """DPDK Crypto Device Testing Suite."""
+
+    def set_up_suite(self) -> None:
+        """Set up the test suite."""
+        self.device_type: DeviceType | None = get_device_from_str(
+            str(get_ctx().sut_node.crypto_device_type)
+        )
+
+    def _verify_output(
+        self,
+        results: list[CryptodevResults],
+    ) -> bool:
+        for result in results:
+            if (
+                getattr(result, "failed_enqueued") > 0
+                or getattr(result, "failed_dequeued") > 0
+                or getattr(result, "failed_ops") > 0
+            ):
+                return False
+        return True
+
+    @crypto_test
+    def aesni_mb_vdev(self) -> None:
+        """aesni_mb_vdev test.
+
+        Steps:
+            * Create a cryptodev instance with aesni_mb virtual device and provided buffer sizes.
+        Verify:
+            * The aes_cbc cipher and sha1_hmac authentication algorithms are working as expected
+                with the dpdk-test-crypto application.
+        """
+        app = Cryptodev(
+            vdevs=[VirtualDevice("crypto_aesni_mb0")],
+            ptest=TestType.verify,
+            test_file=AES_CBC_DATA,
+            test_name="sha1_hmac_buff_32",
+            devtype=DeviceType.crypto_aesni_mb,
+            optype=OperationType.cipher_then_auth,
+            cipher_algo=CipherAlgorithm.aes_cbc,
+            cipher_op=EncryptDecryptSwitch.encrypt,
+            cipher_key_sz=32,
+            cipher_iv_sz=16,
+            auth_algo=AuthenticationAlgorithm.sha1_hmac,
+            auth_op=AuthenticationOpMode.generate,
+            auth_key_sz=64,
+            digest_sz=12,
+            burst_sz=32,
+            buffer_sz=32,
+            total_ops=TOTAL_OPS,
+        )
+
+        verify(self._verify_output(app.run_app(num_vfs=0)), "Failed to verify test sha1_hmac_buff_32")
+
+    @crypto_test
+    def openssl_vdev(self) -> None:
+        """Openssl vdev test.
+
+        Steps:
+            * Create a cryptodev instance with openssl virtual device and provided buffer sizes.
+        Verify:
+            * The aes_cbc cipher and sha1_hmac authentication algorithms are working as expected
+                with the dpdk-test-crypto application.
+
+        Raises:
+            SkippedTestException: When configuration is not provided.
+        """
+        app = Cryptodev(
+            vdevs=[VirtualDevice("crypto_openssl0")],
+            ptest=TestType.verify,
+            test_file=AES_GCM_DATA,
+            test_name="aes_gcm_buff_32",
+            devtype=DeviceType.crypto_openssl,
+            optype=OperationType.aead,
+            aead_algo=AeadAlgName.aes_gcm,
+            aead_op=EncryptDecryptSwitch.encrypt,
+            aead_key_sz=16,
+            aead_aad_sz=16,
+            aead_iv_sz=12,
+            digest_sz=16,
+            burst_sz=32,
+            buffer_sz=32,
+            total_ops=TOTAL_OPS,
+        )
+
+        verify(self._verify_output(app.run_app(num_vfs=0)), "Failed to verify test aes_gcm_buff_32")
+
+    @crypto_test
+    def sha1_hmac_buff_32(self) -> None:
+        """aes_cbc test.
+
+        Steps:
+            * Create a cryptodev instance with provided device type and buffer sizes.
+        Verify:
+            * The aes_cbc cipher and sha1_hmac authentication algorithms are working as expected
+                with the dpdk-test-crypto application.
+
+        Raises:
+            SkippedTestException: When configuration is not provided.
+        """
+        app = Cryptodev(
+            ptest=TestType.verify,
+            test_file=AES_CBC_DATA,
+            test_name="sha1_hmac_buff_32",
+            devtype=self.device_type,
+            optype=OperationType.cipher_then_auth,
+            cipher_algo=CipherAlgorithm.aes_cbc,
+            cipher_op=EncryptDecryptSwitch.encrypt,
+            cipher_key_sz=32,
+            cipher_iv_sz=16,
+            auth_algo=AuthenticationAlgorithm.sha1_hmac,
+            auth_op=AuthenticationOpMode.generate,
+            auth_key_sz=64,
+            digest_sz=20,
+            burst_sz=32,
+            buffer_sz=32,
+            total_ops=TOTAL_OPS,
+        )
+
+        verify(self._verify_output(app.run_app()), "Failed to verify test sha1_hmac_buff_32")
diff --git a/tests.TestSuite_cryptodev_verify.rst b/tests.TestSuite_cryptodev_verify.rst
new file mode 100644
index 0000000000..d0a305a7d5
--- /dev/null
+++ b/tests.TestSuite_cryptodev_verify.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+cryptodev_verify Test Suite
+===========================
+
+.. automodule:: tests.TestSuite_cryptodev_verify
+   :members:
+   :show-inheritance:
-- 
2.54.0

