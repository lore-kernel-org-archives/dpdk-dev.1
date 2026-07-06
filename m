Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47917C43458
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 15:02:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E79C406B6;
	Mon,  6 Jul 2026 17:02:18 +0200 (CEST)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com
 [209.85.167.174])
 by mails.dpdk.org (Postfix) with ESMTP id B2227402C3
 for <dev@dpdk.org>; Mon,  6 Jul 2026 17:02:14 +0200 (CEST)
Received: by mail-oi1-f174.google.com with SMTP id
 5614622812f47-48f0e5e6698so1755895b6e.1
 for <dev@dpdk.org>; Mon, 06 Jul 2026 08:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1783350134; x=1783954934; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DmlmCGfriAnyE7oyllSzuW2rLWm2pXjxaSHF5an4kFI=;
 b=XcQlkuCtOUVNs74rcReV2Jj8Mi6xbY/BReieV122ac8lNJag+EbqoC8qsllJgQKxGV
 SsfFtSMoOAPbtSfyjtNdBrLp8tv2uupWCkbqsc5nRPCmKqxBfbXmPJqnVtpK0zbi03GW
 7h/x0klrSpAI/zI10P9vcNmf52kjfwS5mP/dE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783350134; x=1783954934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DmlmCGfriAnyE7oyllSzuW2rLWm2pXjxaSHF5an4kFI=;
 b=K3vuTIAl2orpsRfzvzeMzC6DvO+g2ngVja5MuYuBTluHH2uw/OVrrywp1I/cdjhkOj
 Zo/nJQPgWvMnLW9kbsMCVkrbFK0YEbwPXxwhiNbm6RldZBGpbYTGD/KxJnNDBVs0Iicg
 6CsSUzqHMrO0QZk15ATK920bea5TwRZGIO6CBrTJOMHJJKlNTg+vByMBCF3B+TxVxKxX
 6w7CT3JCwahtXUI6IvN9FqbXDxcbZWM33w6iQPeD1c0A97ZKRZSn0Y64degOP1uQtwvb
 ea4pM0m+gLbIqo0lq8+hjvjcJRkiC24dp8zCeKYcI685NPPYvWtbAggd6CRabJQwNAHX
 P3EA==
X-Gm-Message-State: AOJu0YzcdCRb76P/g+1iHQ5Fm/ZD5kkrxqwCf0Xm4tsKsaROzyefEm3N
 QNOgKeWcvYuzX3zMX2+mTK9JNJUUzQtslPHEpdPCRp6LZR+OGGxYMJW1xgW0ogVOaML4nhm74F2
 5Rgxk4+TBODxlnDwR77B9R0W49oJkruFJcG7s2f3c+NT/Wo8jN5d1zvQcRwHjEuqAalsglOm10N
 FlxGCR3VfOvnh42wlrWg6kqyrx9Ko=
X-Gm-Gg: AfdE7ckEGfvhaodUIUiPijUUNkX6u6/dROYkTDhoGFSq5aH8DT01LkmJbW1GqduINyF
 xNven17qNfm0ak4uskmtqXqlHSw8qkc6lKzABkgjC+iP89tcF1/FLdiaxqXrD64c1rKwU1OebVX
 YQiIcaMLHjt4AcZC+8qhbGTALRr7q8yGAJpeSexCDJQStTGABUuxLauxeqoTIDUKZAoTZsLZ51K
 ca/mT1EMHGS4AsCYQZRB4GNY2sCBT0xeDXNokHGxmlO9j6XP4sBFXvh/IabpCLspvHdYtknunnC
 mC2u7lWWQiw7P6pYb3f1xt42oZfT2dpXsEAgIwckJmPT0FP71nthU2tSM9+UCJHPgxZkycsc37a
 IEiRm1td05dpPV1p+QvnkX99HEIiALZoUmuMUxMh9IcXJrMJw+TueDwpYCQXL7jDVdEVtkRSK7c
 aqcuKy7um1YLjIqOxWrbGlyfYXXv72m4OW6m9nc49oeCVjirzYahrDd7/I36yTNyM5
X-Received: by 2002:a05:6808:5283:b0:495:feaa:9db9 with SMTP id
 5614622812f47-49fdc871dbcmr709179b6e.10.1783350133221; 
 Mon, 06 Jul 2026 08:02:13 -0700 (PDT)
Received: from d121029.iol.unh.edu ([2606:4100:3880:1210:5d7f:246:cd51:1b62])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f4726b3201sm138661976d6.46.2026.07.06.08.02.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 08:02:12 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v3 3/3] dts: add verify coverage for cryptodev testing
Date: Mon,  6 Jul 2026 11:02:05 -0400
Message-ID: <20260706150205.497924-3-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706150205.497924-1-abailey@iol.unh.edu>
References: <20260514172553.191331-1-abailey@iol.unh.edu>
 <20260706150205.497924-1-abailey@iol.unh.edu>
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
 dts/tests/TestSuite_cryptodev_verify.py | 162 ++++++++++++++++++++++++
 tests.TestSuite_cryptodev_verify.rst    |   8 ++
 2 files changed, 170 insertions(+)
 create mode 100644 dts/tests/TestSuite_cryptodev_verify.py
 create mode 100644 tests.TestSuite_cryptodev_verify.rst

diff --git a/dts/tests/TestSuite_cryptodev_verify.py b/dts/tests/TestSuite_cryptodev_verify.py
new file mode 100644
index 0000000000..0fc405fcc9
--- /dev/null
+++ b/dts/tests/TestSuite_cryptodev_verify.py
@@ -0,0 +1,162 @@
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
+        verify(
+            self._verify_output(app.run_app(num_vfs=0)), "Failed to verify test sha1_hmac_buff_32"
+        )
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

