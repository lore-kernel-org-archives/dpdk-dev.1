Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5AFD6CFA7
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 21:44:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6A38406B4;
	Thu, 22 Jan 2026 22:44:38 +0100 (CET)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48]) by mails.dpdk.org (Postfix) with ESMTP id E347040684
 for <dev@dpdk.org>; Thu, 22 Jan 2026 22:44:34 +0100 (CET)
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-888bd3bd639so19515066d6.1
 for <dev@dpdk.org>; Thu, 22 Jan 2026 13:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1769118274; x=1769723074; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h76Y3IPrDinV+dIDjngfQXlzjZqTinNjkun/nC2KCS8=;
 b=NjkFZtvxKY2XJqjeAbdxcGq/cNtEjaAiIt7CWzIusJ3sYTmemW0QfYV5hnxRrscEXq
 shg2M7uLGjo0e96VRF1IZeFa2byCCNpG8Mv2+ZT2Y78G2qbhgpf0fc4bzKQ+3MQuBHbr
 rhXoc4byof8OQ2Topv2MiNz0N8Q/MKukIfz1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769118274; x=1769723074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h76Y3IPrDinV+dIDjngfQXlzjZqTinNjkun/nC2KCS8=;
 b=sGtxgYJfzN/MwUesBPwcQszuSQcaE0xrS/bEboZt3/nukF/j4Cjjxi3tzROnaOPGjP
 nMXwTFsUI+9XIiVzMbtdnTb8YvozoYknV4NnuXhoAs10pxxZKIpMsyKpNcQVzCWmtCH7
 3w7wxFmawaOmmHRfh543gL58k9TIwXxQbJckr8Fbngxoz+IRZWGiQyHyZ1ReICPmirlW
 hVFf77sGnAtDN0HuhAsL7BB2Aaxm6QLjJaQMMcY+fon650WZSkT2Kp66LlmXDOCO9xPq
 Dkpa/qajBYY3yr2KQ1GNW1aeUSofVaA5/ZykqTgI9GqijrZPEUiNJKKV4sPt3rgrQgrg
 PIIg==
X-Gm-Message-State: AOJu0Yy7Yxj1I9xyOQixd2k9dUqfxPqROSLPVS3yVKgwKjnVws+FeSvU
 Z8W5CDFbzMPwesHVagf0OSWRk0/P/vaWqVR4pNrmPWnKLZxywZars2aSCCI8D8eW1NY=
X-Gm-Gg: AZuq6aIjaw3umzuGNAYiGFJTLZ+DlnFVooqCfp6DdPhq7rVzx1AmmsdSfmnnuIJvxqx
 UryE2XzpZETmnvnUF75eA4pbH3XuMAUP/m5yTXn7urf8WMj9B/OmBUijgqoSW+Tsx2fzH55iw+U
 gZIWaQv3r1aHVe8Z4PXmMdKoHW1bCgx+PzUDEeWNnjONtLGCOhphzw8awUyPMbUsU92andWfFZK
 UDt5DGDgOh+5MCA+OxtQs/bUo5hTv+gB8EF3J2Keu4eNMVyiLPTGnde485hh0vbcLxnQBk2qyVW
 2o1KKtiqCaLgJMv6iYiTW3JYrK1rtm4AeI5g850NP9BuK5s5WCOIbcYu1GjG3TtXLqu25R4FaLR
 PRVI24KYb0UbyVbcyuSHvTYVm3c3u3AbnbKuOa+d+nswYhDiGADAj08n2mOAFgSTm3OFXDpKvr4
 RquSxaBMfq57/TjAdw+CfLV8T986pWE7v5qRNGGg8Zl2nY8xtJhIsiqAXPAsm/VHs=
X-Received: by 2002:a05:6214:29e9:b0:880:51c6:bee8 with SMTP id
 6a1803df08f44-894904b4184mr11983366d6.20.1769118274204; 
 Thu, 22 Jan 2026 13:44:34 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c6e3870c48sm28720785a.51.2026.01.22.13.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 13:44:33 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com,
	probb@iol.unh.edu,
	dmarx@iol.unh.edu
Cc: dev@dpdk.org,
	gakhil@marvell.com,
	Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v1 4/5] dts: add crypto test decorator
Date: Thu, 22 Jan 2026 16:44:23 -0500
Message-ID: <20260122214424.322422-5-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260122214424.322422-1-abailey@iol.unh.edu>
References: <20260122214424.322422-1-abailey@iol.unh.edu>
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

Currently, a test case is decorated to signify whether to use Scapy or
TREX. This change allows test suites that do not use a traffic generator
to avoid the overhead of initializing either one.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/framework/config/test_run.py             |  3 +++
 dts/framework/test_suite.py                  |  4 +++
 dts/framework/testbed_model/linux_session.py | 27 +-------------------
 dts/framework/testbed_model/os_session.py    |  4 ---
 dts/tests/TestSuite_cryptodev_throughput.py  | 16 ++++++------
 5 files changed, 16 insertions(+), 38 deletions(-)

diff --git a/dts/framework/config/test_run.py b/dts/framework/config/test_run.py
index 6c292a3675..39f2c7cdf6 100644
--- a/dts/framework/config/test_run.py
+++ b/dts/framework/config/test_run.py
@@ -481,6 +481,8 @@ class TestRunConfiguration(FrozenModel):
     perf: bool
     #: Whether to run functional tests.
     func: bool
+    #: Whether to run cryptography tests.
+    crypto: bool
     #: Whether to run the testing with virtual functions instead of physical functions
     use_virtual_functions: bool
     #: Whether to skip smoke tests.
@@ -522,6 +524,7 @@ def filter_tests(
                     for tt in t.test_cases
                     if (tt.test_type is TestCaseType.FUNCTIONAL and self.func)
                     or (tt.test_type is TestCaseType.PERFORMANCE and self.perf)
+                    or (tt.test_type is TestCaseType.CRYPTO and self.crypto)
                 ),
             )
             for t in test_suites
diff --git a/dts/framework/test_suite.py b/dts/framework/test_suite.py
index 856dae0a85..e86096cefe 100644
--- a/dts/framework/test_suite.py
+++ b/dts/framework/test_suite.py
@@ -281,6 +281,8 @@ class TestCaseType(Enum):
     FUNCTIONAL = auto()
     #:
     PERFORMANCE = auto()
+    #:
+    CRYPTO = auto()
 
 
 class TestCase(TestProtocol, Protocol[TestSuiteMethodType]):
@@ -333,6 +335,8 @@ def _decorator(func: TestSuiteMethodType) -> type[TestCase]:
 func_test: Callable = TestCase.make_decorator(TestCaseType.FUNCTIONAL)
 #: The decorator for performance test cases.
 perf_test: Callable = TestCase.make_decorator(TestCaseType.PERFORMANCE)
+#: The decorator for cryptography test cases.
+crypto_test: Callable = TestCase.make_decorator(TestCaseType.CRYPTO)
 
 
 @dataclass
diff --git a/dts/framework/testbed_model/linux_session.py b/dts/framework/testbed_model/linux_session.py
index fb6081ab37..8d678c5b5d 100644
--- a/dts/framework/testbed_model/linux_session.py
+++ b/dts/framework/testbed_model/linux_session.py
@@ -194,8 +194,7 @@ def bind_ports_to_driver(self, ports: list[Port], driver_name: str) -> None:
             verify=True,
         )
 
-        if self._lshw_net_info:
-            del self._lshw_net_info
+        del self._lshw_net_info
 
     def bring_up_link(self, ports: Iterable[Port]) -> None:
         """Overrides :meth:`~.os_session.OSSession.bring_up_link`."""
@@ -225,30 +224,6 @@ def devbind_script_path(self) -> PurePath:
         """
         raise InternalError("Accessed devbind script path before setup.")
 
-    def load_vfio(self, pf_port: Port) -> None:
-        """Overrides :meth:'~os_session.OSSession,load_vfio`."""
-        cmd_result = self.send_command(f"lspci -nn -s {pf_port.pci}")
-        device = re.search(r":([0-9a-fA-F]{4})\]", cmd_result.stdout)
-        if device and device.group(1) in ["37c8", "0435", "19e2"]:
-            self.send_command(
-                "modprobe -r vfio_iommu_type1; modprobe -r vfio_pci",
-                privileged=True,
-            )
-            self.send_command(
-                "modprobe -r vfio_virqfd; modprobe -r vfio",
-                privileged=True,
-            )
-            self.send_command(
-                "modprobe vfio-pci disable_denylist=1 enable_sriov=1", privileged=True
-            )
-            self.send_command(
-                "echo 1 | tee /sys/module/vfio/parameters/enable_unsafe_noiommu_mode",
-                privileged=True,
-            )
-        else:
-            self.send_command("modprobe vfio-pci")
-        self.refresh_lshw()
-
     def create_crypto_vfs(self, pf_port: list[Port]) -> None:
         """Overrides :meth:`~os_session.OSSession.create_crypto_vfs`.
 
diff --git a/dts/framework/testbed_model/os_session.py b/dts/framework/testbed_model/os_session.py
index 4a4fc1f34a..2eeeea6967 100644
--- a/dts/framework/testbed_model/os_session.py
+++ b/dts/framework/testbed_model/os_session.py
@@ -615,10 +615,6 @@ def configure_port_mtu(self, mtu: int, port: Port) -> None:
             port: Port to set `mtu` on.
         """
 
-    @abstractmethod
-    def load_vfio(self, pf_port: Port) -> None:
-        """Load the vfio module according to the device type of the given port."""
-
     @abstractmethod
     def create_crypto_vfs(self, pf_ports: list[Port]) -> None:
         """Creatues virtual functions for each port in 'pf_ports'.
diff --git a/dts/tests/TestSuite_cryptodev_throughput.py b/dts/tests/TestSuite_cryptodev_throughput.py
index b75b41e532..f18a051299 100644
--- a/dts/tests/TestSuite_cryptodev_throughput.py
+++ b/dts/tests/TestSuite_cryptodev_throughput.py
@@ -29,7 +29,7 @@
     CryptodevResults,
 )
 from api.test import verify
-from framework.test_suite import BaseConfig, TestSuite, func_test
+from framework.test_suite import BaseConfig, TestSuite, crypto_test
 
 
 class Config(BaseConfig):
@@ -140,7 +140,7 @@ def _verify_throughput(
             result_list.append(result_dict)
         return result_list
 
-    @func_test
+    @crypto_test
     def qat_cipher_then_auth_aes_cbc_encrypt(self) -> None:
         """Test throughput on crypto_qat device type with aes-cbc and sha2-256-hmac algorithms.
 
@@ -177,7 +177,7 @@ def qat_cipher_then_auth_aes_cbc_encrypt(self) -> None:
                 \nMOps was {result["mops delta"]} below baseline""",
             )
 
-    @func_test
+    @crypto_test
     def qat_aead_aes_gcm_encrypt(self) -> None:
         """Test throughput on a crypto_qat device type with aes-gcm algorithm.
 
@@ -211,7 +211,7 @@ def qat_aead_aes_gcm_encrypt(self) -> None:
                 f"Gbps and MOps were {result["gbps delta"]} below baseline",
             )
 
-    @func_test
+    @crypto_test
     def qat_cipher_aes_docsisbpi_decrypt(self) -> None:
         """Test throughput on a crypto_qat devtype with aes-docsibpi algorithm.
 
@@ -243,7 +243,7 @@ def qat_cipher_aes_docsisbpi_decrypt(self) -> None:
                 f"Gbps and MOps were {result["gbps delta"]} below baseline",
             )
 
-    @func_test
+    @crypto_test
     def qat_cipher_aes_docsisbpi_encrypt(self) -> None:
         """Test throughput on a crypto_qat device type with aes-docsibpi algorithm.
 
@@ -275,7 +275,7 @@ def qat_cipher_aes_docsisbpi_encrypt(self) -> None:
                 f"Gbps and MOps were {result["gbps delta"]} below baseline",
             )
 
-    @func_test
+    @crypto_test
     def qat_cipher_then_auth_kasumi_f8_encrypt(self) -> None:
         """Test throughput on a crypto_qat device type with kasumi-f8 and kasumi-f9 algorithms.
 
@@ -311,7 +311,7 @@ def qat_cipher_then_auth_kasumi_f8_encrypt(self) -> None:
                 f"Gbps and MOps were {result["gbps delta"]} below baseline",
             )
 
-    @func_test
+    @crypto_test
     def qat_cipher_then_auth_snow3g_uea2_encrpyt(self) -> None:
         """Test throughput on a crypto_qat device type with snow3g-uea2 and snow3g-uia2 algorithms.
 
@@ -348,7 +348,7 @@ def qat_cipher_then_auth_snow3g_uea2_encrpyt(self) -> None:
                 f"Gbps and MOps were {result["gbps delta"]} below baseline",
             )
 
-    @func_test
+    @crypto_test
     def qat_cipher_then_auth_zuc_eea3_encrypt(self) -> None:
         """Test throughput on a crypto_qat device type with zuc-eea3 and zuc-eia3 algorithms.
 
-- 
2.50.1

