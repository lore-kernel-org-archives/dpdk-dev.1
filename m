Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DEE606A31E
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 20:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=XdVhcQz3
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6CF14067A;
	Mon, 26 Oct 2026 21:17:22 +0100 (CET)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by mails.dpdk.org (Postfix) with ESMTPS id 9ED7A40041
 for <dev@dpdk.org>; Mon, 26 Oct 2026 21:17:19 +0100 (CET)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-53c4b82919fso19730701cf.0
 for <dev@dpdk.org>; Mon, 26 Oct 2026 13:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1793045838; x=1793650638; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GOEukwG3JQxz2UOE+N91iPSg/A8vV8wMnwtQ8e05cRY=;
 b=XdVhcQz3gOsNmxb8XKS7JjzOVhrntjyKJQuxsHCeW/THKrYOuR1ripWyD67kHt6HcE
 fIBRNLu6k0F2R+R+hWUWrzy+ilR6c2TL5AFujxLhumQuM/JA0ndvlHeWyLNvV7xxqcsy
 fPAXM5Y+Oh1P6phCDvXY/5K3i8ELj+hd3fs64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793045838; x=1793650638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GOEukwG3JQxz2UOE+N91iPSg/A8vV8wMnwtQ8e05cRY=;
 b=vylUdyQHUPlA9XrOiPhibek1UhN/ibxPc1OsoiXpB5OvP/ux0PNdo8B/iJ+KJFQzRi
 xyRcHJa4E3nE8/426nwXW7VI6dGxBeGh72Tn0hpxptlNxQ5Zb9aDv+bAwAg1xpXPOFsU
 3/yHaTWbMaLMrj+LVgUJD9/7CAxD4kxs7xwslRmDBdTbw1XFd2ANhyLKSS1v/xz15r7S
 kAwaeoSeFqqaLpnde16KxQaz6FM4r5WOgX/A5DghG12AjZ3JUFo51bYaLnIBUYzL0iKv
 KrvOV/sgn53mCBPSWWkIiY/5zLv/3tBvxUr/N7tzaX0nnXvycXjpaGV7w46DKX63l8T4
 FESQ==
X-Gm-Message-State: AFq9FYJBLwXObBGsFakWfWebMZSLfpp1uLTF3y4hUHsyuyqgwEgial9W
 61K/a4vGTiazG+L3khTmUggp4m9TymbaMAj3uzYXKcUzwmqlQ4TW1ZZSuytSOQHaXuovbq4Dfct
 fyfEy1FNm/9qC7/gNuwC3WSL4MS4QueGq1rA+fiEMz745wUG9u/5Tsccvq7TnkghEZcfAM7+ms4
 bKmbAxWoYKIDPBqPaHoXp7S+r3PLk=
X-Gm-Gg: AYBFou0lAoHYIdrCjvVWRXrGq9LozbBokJrm6jK7Zwo61BAw5mPuo5VgnvZtSp5g/KA
 kk36oAWa9nx8bnHJ2i5Z1Uff5kf6sgQZfthx2NHz/LSXhkfjKCm3X904EJcQSlGjYPU4W6EFn3I
 HpyY1v0NoN97O6PjXkxhxOyVumNFJD6EdD03mxBFFcdjxncGikFZL5PTB6EYIdL3Z+s2tU0+Fj8
 3Tge66pCy2srVAlDdxxD2W/Ga7BavNetN6c96jyCorWLvq4a3uLXeVDUeLRX5OrFjFUbN+56K1N
 /kt8mZtcxbcHw8Vdmw193jzS04QNryAZW70kIbdIDjdqNb8Ie+sQwvG8rxKPzsFjFa11sIGoUcz
 iJ2xPmjhLqLX2DiHffC//P6XbQMZhZpC5N9CjWHvRshIAfn9rYsenlwbZslKThBM1L0v7XF5hB3
 Dxx+sRJ31AaDnQXoC+HN3WdiJB7vjSb5IcKMFxwxCMaztw/jqOqvlIvw5lMK++96VOYquBZHxOn
 /HttiOghnVMxKL99wX0xHt4zgs8xovGrco3rsDSkCS694Wn4cN6/PSC9/Nf3pkdc7MhE8GWZvHe
 4M5xDMNPynQgmBXmCTH8Ocdk
X-Received: by 2002:a05:622a:34b:b0:536:5663:5558 with SMTP id
 d75a77b69052e-5383b37137emr135207171cf.7.1793045838285; 
 Mon, 26 Oct 2026 13:17:18 -0700 (PDT)
Received: from d121029.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c47c50e10sm81969766d6.25.2026.10.26.13.17.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 13:17:18 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v5 3/3] dts: add verify coverage for cryptodev testing
Date: Mon, 26 Oct 2026 16:16:43 -0400
Message-ID: <20261026201643.72369-4-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261026201643.72369-1-abailey@iol.unh.edu>
References: <20260428193541.79005-1-abailey@iol.unh.edu>
 <20261026201643.72369-1-abailey@iol.unh.edu>
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
dpdk-test-crypto application. This commit adds coverage for the verify
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
2.56.0

