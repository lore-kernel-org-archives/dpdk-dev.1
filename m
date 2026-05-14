Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A52CD4F39
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 May 2026 17:26:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1DB3A40395;
	Thu, 14 May 2026 19:26:28 +0200 (CEST)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by mails.dpdk.org (Postfix) with ESMTP id 50BEB4064F
 for <dev@dpdk.org>; Thu, 14 May 2026 19:26:25 +0200 (CEST)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-90ea08cc5ceso415088785a.2
 for <dev@dpdk.org>; Thu, 14 May 2026 10:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1778779584; x=1779384384; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tmgmrPzedAvpWMAwJrxJhr66PWKlyEF22W4Et0lVqoM=;
 b=SutLY6ADLDcQhpGLwhm3924R80DJXxapuovcVErg3QN1PbjLRh0ONazB398SYs3I/3
 gdN2iysaGBeyMkYLXjCLp9Lkjh69VGCzw9cNhpbVRZea+27+j2dUhXHHAQP0JDjUta2l
 xPWrcPJRwQDgBllUAzDXiVBBBOink4gB6E2i0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778779584; x=1779384384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tmgmrPzedAvpWMAwJrxJhr66PWKlyEF22W4Et0lVqoM=;
 b=lejaQxkUcGnnbMV16oHj+kJcwi5EU4Rvel77YjNbNMq+aF1UNaRk3u/DM5uvTPbos4
 cllmITRGxVSuWzDvhDxvXKrYssOGnMCNQORp9R1fo/4gkABzwlqTphrJQdjxysrWtO3n
 Z0h7O9AcRHN0RjWFGDayUv6GgDnl05gqNnO0HUH1WE2QgI7YKDd8pfmeJgHMjvlC/3Mn
 I7MBpCOV+Eo90tj7rEz9cnsU5AVldpkNKT3ZbkyL3/wjkjexF2BQhbhpDa/IzabmbkVC
 WKyxSXpIF8WPSEkwYV+N+UDnTXBo5OGxGadMFbWfkX3TWvpDfekIEN+qnApLuiKM9UUX
 dMhQ==
X-Gm-Message-State: AOJu0YwejXRWSv4vYfu2sGLm89rOEpF0u6aT32W0kKdQwnDLDOcwl1yU
 cS8nR6JylUkGjaClh6MNoV+ha+1BqoFNaBm2qw8u5L5kx9P+lNQuIYP0Y1EtcGMBycU=
X-Gm-Gg: Acq92OFHTEIGBIyJru0y7ookf1CyJNtbIe+h2p7hJTAYu6tDbmbFi99jZXYzEbn5AYz
 hGNv1YGXbQmf1YgpYP4aq2HHfzjHQSAoTtSv+GOczZnn8AgPeLHyzJOB05pYxT7gDRm6UFcpSmP
 ukIXG7VOg9KYjGwFv7nSvp6cLlI4e7t+zviFHUYi0pEcxh/Bh4dsRy8GQIGLPJo+K3iW2tYr6xL
 Iy1lopCpbwnGXZZqL9ObiVq9dDHWkLgBKLz91oCAQIVWhEKhfRMpKF779xJkDHD7/NJnGj7XUpV
 3qNKZ9LpuGBtDbC50t0GhlZdETr5giq6fNA8iT9RMPEWpgK5NMk9IzD5zncmkVB+zj1RPQumbga
 T1Rjnh2/uQt1Dlp9VRU+kUYAu6h4/CMM+I0HOo2RDA9rbGDDvzTpl3/O02nRMk48xvMNdL9xPhP
 OCPKX5I/H1DE3nKpy4W2HWerajKAYbayDdtE9q5L2xwX/AgFs4eXevIh6LDlKPRBh1
X-Received: by 2002:a05:620a:711b:b0:90f:64c0:37fa with SMTP id
 af79cd13be357-911cdd443e2mr82732485a.11.1778779584511; 
 Thu, 14 May 2026 10:26:24 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-910bd8211e2sm296882685a.47.2026.05.14.10.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:26:24 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: dev@dpdk.org, lylavoie@iol.unh.edu, ahassick@iol.unh.edu,
 knimoji@iol.unh.edu, Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v1 3/3] dts: add verify coverage for cryptodev testing
Date: Thu, 14 May 2026 13:25:53 -0400
Message-ID: <20260514172553.191331-3-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260514172553.191331-1-abailey@iol.unh.edu>
References: <20260428193541.79005-1-abailey@iol.unh.edu>
 <20260514172553.191331-1-abailey@iol.unh.edu>
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
index 0000000000..45014a4243
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
+        verify(self._verify_output(app.run_app()), "Failed to verify test sha1_hmac_buff_32")
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
+        verify(self._verify_output(app.run_app()), "Failed to verify test aes_gcm_buff_32")
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
2.50.1

