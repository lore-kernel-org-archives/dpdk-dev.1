Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D27606A319
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 20:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=Nh/NCfcG
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D83540608;
	Mon, 19 Oct 2026 22:23:04 +0200 (CEST)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by mails.dpdk.org (Postfix) with ESMTP id F0E9B40609
 for <dev@dpdk.org>; Mon, 19 Oct 2026 22:23:02 +0200 (CEST)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-93f1cf92c9eso259383585a.0
 for <dev@dpdk.org>; Mon, 19 Oct 2026 13:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1792441382; x=1793046182; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uLdQilMd7bDdV7xCwKiqlAkW34ws3KEmoi5Ne6tyt9A=;
 b=Nh/NCfcGCy4ZUN5FFbFtvDRaIsjYaS2v6kvONm342/UWFjRAFlpIDM70VHSLYzx3E0
 bEhMKqen6TPVqW+XHev6V4qxxX8GLaHgj+okpyqzWFyho9ho+Ma+yfltmHTBnc4SE+d4
 e9DPljrHzQjUnDIKbJnJVT8fzO8z36J6nwuHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792441382; x=1793046182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uLdQilMd7bDdV7xCwKiqlAkW34ws3KEmoi5Ne6tyt9A=;
 b=fhdPw7KXr1NwmVVxEkniO/f0eo6KIgZq2siyBRBDPyb6TZCz2xCczWPohdh3snzGKz
 Um8Xf2Rel2x50JIBkwmqPi60pnbr2q6YHxOMTOinGXL3bI95MWagu96YbM3d3Wh1bisp
 7mfxyHZ8jXd4Wb329VrrgLfigVn3fShWQqJRFPA+mmACDWOZ5qq7EYR1Q4CNnaEKHpnH
 xQxryz37VRChR5gr3rd06agpaoxZnltlZfQUNvABbRw86YMG72oEeulxRaAiuWuHmbnn
 uVhtxvmB6Jdv93GoB4ub8z79+4uLZ2TK9V9S+M6l7qsjliK09KPfi+AFK1KpRcAfejJe
 5XPQ==
X-Gm-Message-State: AFq9FYL1nx74czBu3INrFgDrhMaBTmdR0ZCDofQtgVv18ODlq9VRX2+c
 8nvV20QJyOzgTMzizgImEiQGQ10pZa/6zxNAV0QJUwOErfa2kdgPsYZeuSBJ/CDe6p8a8lCxIq7
 6GP4bNM6hx7/osFi8HkN2DQjl/NZ8vjwmVJSXLtbEs2CYHGRZ7iyzWKFqXJwWXuhmKHUnbdsdZM
 lwT4uWlYe1Q48frFWiX7NBq6giXCc=
X-Gm-Gg: AYBFou3FD+Ov5A3AkI9L/WEaRedRZlIgLcdUblzLFHMv1ebMMqYo6wPD+9DpnFONaxc
 QgQYw+p10ObMl4FdvxHn8ImFP3FfAnOF1P7mESBaI4yMQDz8y0tvRz0K/g5sSG+6PDLzag2Pvo1
 wTP+9Dm+OC/sSUP91JCuZxsHnwGhOh615XVO1B4K5pAgGflQnEEclzrLTvaPP6HahRiijGc0zBH
 9bRyxQoIlkg6UCIGkijVfsWPILYlmatQm2QzuOYE5b7zz2P5w66p5RKzsUQ0OqPwLWYHp6tUqTD
 i2TYP12NQzSxPq44SdGGjaidjcf7JwQmTAC8L+lvFiT0vXnjeDokK/Jq1SHTjFRWwmJO3pn9iZy
 LpZv3DHG77fL+6lDQb7dY60t+qjI8dQ4TMifVXohWjr3lFiiB2Gt4NzPG4XvBKjv2XDpFLR8wbf
 UbjC+MC64hYiW2dbuLVsRlstxLXgbUubQGG4QU/nJcstiNum8y57S949ARonrBhpNEDbpgSv/Ob
 iUeH6wWXIkMsBihhX8VS2dEUgdhgQjPXEWAi9KaqxN7cOSbWhyYwIvC379Qp/mIlODmgU3VZlY4
 6Q==
X-Received: by 2002:a05:620a:45ab:b0:93b:d7a0:d9e7 with SMTP id
 af79cd13be357-93f29dcf5d7mr1526774785a.65.1792441382196; 
 Mon, 19 Oct 2026 13:23:02 -0700 (PDT)
Received: from d121029.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c040b4915sm5510666d6.26.2026.10.19.13.23.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 13:23:01 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org, luca.vizzarro@arm.com, patrickrobb1997@gmail.com,
 dladd@iol.unh.edu
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v4 3/3] dts: add verify coverage for cryptodev testing
Date: Mon, 19 Oct 2026 16:22:52 -0400
Message-ID: <20261019202252.907692-3-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019202252.907692-1-abailey@iol.unh.edu>
References: <20260514172553.191331-1-abailey@iol.unh.edu>
 <20261019202252.907692-1-abailey@iol.unh.edu>
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

Currently, next-DTS only covers throughput testing through the
dpdk-test-crypto application. This series adds coverage for the verify
option to next DTS to allow functional testing for various algorithms of
crypto devices and virtual devices.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---

v4:
 * Rebased on Main.

 dts/tests/TestSuite_cryptodev_verify.py | 162 ++++++++++++++++++++++++
 tests.TestSuite_cryptodev_verify.rst    |   8 ++
 2 files changed, 170 insertions(+)
 create mode 100644 dts/tests/TestSuite_cryptodev_verify.py
 create mode 100644 tests.TestSuite_cryptodev_verify.rst

diff --git a/dts/tests/TestSuite_cryptodev_verify.py b/dts/tests/TestSuite_cryptodev_verify.py
new file mode 100644
index 0000000000..bfd11eba45
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
+from api.test_suite import TestSuite, crypto_test
+from api.testbed_model.virtual_device import VirtualDevice
+from framework.context import get_ctx
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
2.55.0

