Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6BBFCB621
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 16:40:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 10B464278A;
	Fri,  6 Mar 2026 17:40:37 +0100 (CET)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mails.dpdk.org (Postfix) with ESMTP id F0815410D4
 for <dev@dpdk.org>; Fri,  6 Mar 2026 17:40:35 +0100 (CET)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-8cb5c9ba82bso1483746585a.2
 for <dev@dpdk.org>; Fri, 06 Mar 2026 08:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1772815235; x=1773420035; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OezfaT+H+2nmi5j2bmk2ud0ktRnoD60SQGUjy3snjcg=;
 b=L1arI8xPMqKBV5yrco2huNJaj2wha87BM+sxx22HLlpc83JWzzs+9rI72Yy32/YEhP
 hQHHz++hHinOBfod0ZZoHrhcx14T6KFo2wPgmK4Q2LZNHMr6cOCZVaL6gi6XyZtfvess
 ZhICs4g2B2VUXHD3KSdZZpc1/8mA8AGHy3rt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772815235; x=1773420035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OezfaT+H+2nmi5j2bmk2ud0ktRnoD60SQGUjy3snjcg=;
 b=XQKKhbi965+5D1ezMPUR2/VEDd+Z5uWpNbNNYghTYdHKeu0aBYOXar7PNAAN+FODyI
 B54+fnFUgyM8lhoDof0zflHhILTXZLRcKyVZvYfmQCZf0yp+MJ7Iw9Ck6qvA6uLxYZAP
 NNAAUS+G7yUrtVSSAGgcBdGlVaMVi/cmNqwkQOLrb5gpqOQiKO1PVGeDdUuw8QhyeNid
 WWKeMCHFIzW/BJTCd3O0MrTaNL5oCAPRBYlCdx62bANYJuJRX8ayANtrQI9n9JaPhho1
 y6XktvFVefE5RbVGlnu4i3eAVZ7udWafileaHHPZ9w6JPqnsVrNdwqmtSYk6eIn4AU0z
 fd7A==
X-Gm-Message-State: AOJu0YztyBApQPlXvIQEq3PEl9z9FYSNtYkm2Pc5u6gROfYGW+4ROzKR
 0l865nDHzSt4k4sSgdcQb11kmKyJALEGRSWLZQs/mzrmM+JFGXs9YBT7hlxtbQzIPaUu8E0HnUf
 lkdzY
X-Gm-Gg: ATEYQzym9FEJxMxACdVvU+3w8wcD4DsXmpTLIqEH+I55LzRMy48IfOpZ3W7HubfeR2w
 fbDhFLcF7menas/8g09kZ544H3dcpCo4OjQ96Sm8bJ4BhbVb9u/h1hvDpcoYfA11sTcqjU1SwYH
 8Ml5TlfSvKTJpuyWFUZx3eOiT918CqoB3mA5hbFMe5qxjbdNnnJQYVBA5yif8yZzGvX6LK4HOM1
 HuxoWLWN70eKofjwfvGOBdXwYuDF2l715nzpxUdQwtA7mhRge43XgxN+BWWSM5uVrkjw2uWYagC
 pMZf1XUnJFCq7+ey184Gh+m75mg3722ZZfn+gMfESwteFF/Gkjg89qxCPyeJR3y6sgSD7rUnSLe
 46VDgsigMn00baGZjSAHYfD5mWuKSlQJi3p/8oYMOa0FFkLBA3EK4XxByxnfxY5BYGrBUS9gwMe
 OBC1eKZ43Bs+0HHBbFqaGcqnrqtqoxoIrIyS1TH1eIFtvpfIHUVv/tbxhaUD7YhYQI
X-Received: by 2002:a05:620a:1aa9:b0:8c6:ffe3:49e4 with SMTP id
 af79cd13be357-8cd6d4c9e61mr313433685a.52.1772815234874; 
 Fri, 06 Mar 2026 08:40:34 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd6f566fd5sm144608185a.43.2026.03.06.08.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 08:40:34 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: probb@iol.unh.edu
Cc: dev@dpdk.org, luca.vizzarro@arm.com, dmarx@iol.unh.edu, kai.ji@intel.com,
 dharmikjayesh.thakkar@arm.com, david.marchand@redhat.com,
 gakhil@marvell.com, Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v5 3/5] dts: add cryptodev package to DTS
Date: Fri,  6 Mar 2026 11:40:25 -0500
Message-ID: <20260306164027.171723-4-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306164027.171723-1-abailey@iol.unh.edu>
References: <20260210193448.69423-1-abailey@iol.unh.edu>
 <20260306164027.171723-1-abailey@iol.unh.edu>
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

Running the DPDK test crypto performance application is essential for
testing cryptodev performance in DTS. This application takes numerous
arguments and can be run in four modes; Throughput, Latency,
PMD-cyclecount, and Verify. The package to add in this commit allows for
this application to be run in any of these modes with user supplied
arguments.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/api/cryptodev/__init__.py                | 137 +++++
 dts/api/cryptodev/config.py                  | 508 +++++++++++++++++++
 dts/api/cryptodev/types.py                   | 185 +++++++
 dts/configurations/nodes.example.yaml        |  12 +
 dts/framework/config/node.py                 |   4 +
 dts/framework/params/types.py                |  65 +++
 dts/framework/remote_session/dpdk_shell.py   |   5 +-
 dts/framework/test_run.py                    |   5 +
 dts/framework/testbed_model/linux_session.py |  45 ++
 dts/framework/testbed_model/node.py          |  10 +
 dts/framework/testbed_model/os_session.py    |  30 ++
 dts/framework/testbed_model/topology.py      |  78 ++-
 12 files changed, 1081 insertions(+), 3 deletions(-)
 create mode 100644 dts/api/cryptodev/__init__.py
 create mode 100644 dts/api/cryptodev/config.py
 create mode 100644 dts/api/cryptodev/types.py

diff --git a/dts/api/cryptodev/__init__.py b/dts/api/cryptodev/__init__.py
new file mode 100644
index 0000000000..a4fafc3713
--- /dev/null
+++ b/dts/api/cryptodev/__init__.py
@@ -0,0 +1,137 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 University of New Hampshire
+
+"""Cryptodev-pmd non-interactive shell.
+
+Typical usage example in a TestSuite::
+
+    cryptodev = CryptodevPmd(CryptoPmdParams)
+    stats = cryptodev.run_app()
+"""
+
+import re
+from typing import TYPE_CHECKING, Any
+
+from typing_extensions import Unpack
+
+from api.cryptodev.config import CryptoPmdParams, TestType
+from api.cryptodev.types import (
+    CryptodevResults,
+    LatencyResults,
+    PmdCyclecountResults,
+    ThroughputResults,
+    VerifyResults,
+)
+from framework.context import get_ctx
+from framework.exception import RemoteCommandExecutionError, SkippedTestException
+from framework.remote_session.dpdk_shell import compute_eal_params
+
+if TYPE_CHECKING:
+    from framework.params.types import CryptoPmdParamsDict
+from pathlib import PurePath
+
+
+class Cryptodev:
+    """non-interactive cryptodev application.
+
+    Attributes:
+        _app_params: app parameters to pass to dpdk-test-crypto-perf application
+    """
+
+    _app_params: dict[str, Any]
+
+    def __init__(self, **app_params: Unpack["CryptoPmdParamsDict"]) -> None:
+        """Initialize the cryptodev application.
+
+        Args:
+            app_params: The application parameters as keyword arguments.
+
+        Raises:
+            ValueError: if the build environment is `None`
+        """
+        self._app_params = {}
+        for k, v in app_params.items():
+            if v is not None:
+                self._app_params[k] = (
+                    self.vector_directory.joinpath(str(v)) if k == "test_file" else v
+                )
+        dpdk = get_ctx().dpdk.build
+        if dpdk is None:
+            raise ValueError("No DPDK build environment exists.")
+        self._path = dpdk.get_app("test-crypto-perf")
+
+    @property
+    def path(self) -> PurePath:
+        """Get the path to the cryptodev application.
+
+        Returns:
+            The path to the cryptodev application.
+        """
+        return PurePath(self._path)
+
+    @property
+    def vector_directory(self) -> PurePath:
+        """Get the path to the cryptodev vector files.
+
+        Returns:
+            The path to the cryptodev vector files.
+        """
+        return get_ctx().dpdk_build.remote_dpdk_tree_path.joinpath("app/test-crypto-perf/data/")
+
+    def run_app(self, num_vfs: int = 1) -> list[CryptodevResults]:
+        """Run the cryptodev application with the given app parameters.
+
+        Args:
+            num_vfs: number of virtual functions to run the crypto-dev application with.
+
+        Raises:
+            SkippedTestException: If the device type is not supported on the main session.
+            RemoteCommandExecutionError: If there is an error running the command.
+
+        Returns:
+            list[CryptodevResults]: The list of parsed results for the cryptodev application.
+        """
+        try:
+            result = get_ctx().dpdk.run_dpdk_app(
+                self.path,
+                compute_eal_params(
+                    CryptoPmdParams(
+                        allowed_ports=get_ctx().topology.get_crypto_vfs(num_vfs),
+                        memory_channels=get_ctx().dpdk.config.memory_channels,
+                        **self._app_params,
+                    ),
+                ),
+                timeout=120,
+            )
+        except RemoteCommandExecutionError as e:
+            if "Crypto device type does not support capabilities requested" in e._command_stderr:
+                raise SkippedTestException(
+                    f"{self._app_params['devtype']} does not support the requested capabilities"
+                )
+            elif "Failed to initialise requested crypto device type" in e._command_stderr:
+                raise SkippedTestException(
+                    f"could not run application with devtype {self._app_params['devtype']}"
+                )
+            elif "failed to parse device" in e._command_stderr:
+                raise SkippedTestException(
+                    f"dependencies missing for virtual device {self._app_params['vdevs'][0].name}"
+                )
+            raise e
+
+        regex = r"^\s+\d+.*$"
+        parser_options = re.MULTILINE
+        parser: type[CryptodevResults]
+
+        match self._app_params["ptest"]:
+            case TestType.throughput:
+                parser = ThroughputResults
+            case TestType.latency:
+                regex = r"total operations:.*time[^\n]*"
+                parser_options |= re.DOTALL
+                parser = LatencyResults
+            case TestType.pmd_cyclecount:
+                parser = PmdCyclecountResults
+            case TestType.verify:
+                parser = VerifyResults
+
+        return [parser.parse(line) for line in re.findall(regex, result.stdout, parser_options)]
diff --git a/dts/api/cryptodev/config.py b/dts/api/cryptodev/config.py
new file mode 100644
index 0000000000..ff4ce25c93
--- /dev/null
+++ b/dts/api/cryptodev/config.py
@@ -0,0 +1,508 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 University of New Hampshire
+"""Module containing types and parameter classes for cryptodev-pmd application."""
+
+from dataclasses import dataclass, field
+from enum import auto
+from typing import Literal
+
+from framework.params import Params, Switch
+from framework.params.eal import EalParams
+from framework.utils import StrEnum
+
+Silent = Literal[""]
+
+
+class DeviceType(StrEnum):
+    """Enum for cryptodev device types.
+
+    Attributes:
+        crypto_aesni_gcm: AES-NI GCM device type.
+        crypto_aesni_mb: AES-NI MB device type.
+        crypto_armv8: ARMv8 device type.
+        crypto_cn10k: CN10K device type.
+        crypto_cn9k: CN9K device type.
+        crypto_dpaa_sec: DPAA SEC device type.
+        crypto_dpaa2_sec: DPAA2 SEC device type.
+        crypto_kasumi: KASUMI device type.
+        crypto_mvsam: MVSAM device type.
+        crypto_null: NULL device type.
+        crypto_octeontx: OCTEONTX device type.
+        crypto_openssl: OpenSSL device type.
+        crypto_qat: QAT device type.
+        crypto_scheduler: Scheduler device type.
+        crypto_snow3g: SNOW3G device type.
+        crypto_zuc: ZUC device type.
+    """
+
+    crypto_aesni_gcm = auto()
+    crypto_aesni_mb = auto()
+    crypto_armv8 = auto()
+    crypto_cn10k = auto()
+    crypto_cn9k = auto()
+    crypto_dpaa_sec = auto()
+    crypto_dpaa2_sec = auto()
+    crypto_kasumi = auto()
+    crypto_mvsam = auto()
+    crypto_null = auto()
+    crypto_octeontx = auto()
+    crypto_openssl = auto()
+    crypto_qat = auto()
+    crypto_scheduler = auto()
+    crypto_snow3g = auto()
+    crypto_zuc = auto()
+
+
+def get_device_from_str(device: str) -> DeviceType | None:
+    """Get a device type from the given string.
+
+    Args:
+        device: the string representation of the desired device.
+
+    Returns:
+        the device as a DeviceType object.
+    """
+    for item in DeviceType:
+        if device in item.value:
+            return item
+    return None
+
+
+class OperationType(StrEnum):
+    """Enum for cryptodev operation types.
+
+    Attributes:
+        aead: AEAD operation type.
+        auth_only: Authentication only operation type.
+        auth_then_cipher: Authentication then cipher operation type.
+        cipher_only: Cipher only operation type.
+        cipher_then_auth: Cipher then authentication operation type.
+        docsis: DOCSIS operation type.
+        ecdsa_p192r1 = ECDSA P-192R1 operation type.
+        ecdsa_p224r1 = ECDSA P-224R1 operation type.
+        ecdsa_p256r1: ECDSA P-256R1 operation type.
+        ecdsa_p384r1 = ECDSA P-384R1 operation type.
+        ecdsa_p521r1 = ECDSA P-521R1 operation type.
+        eddsa_25519: EdDSA 25519 operation type.
+        modex: Modex operation type.
+        ipsec: IPsec operation type.
+        pdcp: PDCP operation type.
+        rsa: RSA operation type.
+        sm2: SM2 operation type.
+        tls_record: TLS record operation type.
+    """
+
+    aead = auto()
+    auth_only = "auth-only"
+    auth_then_cipher = "auth-then-cipher"
+    cipher_only = "cipher-only"
+    cipher_then_auth = "cipher-then-auth"
+    docsis = auto()
+    ecdsa_p192r1 = auto()
+    ecdsa_p224r1 = auto()
+    ecdsa_p256r1 = auto()
+    ecdsa_p384r1 = auto()
+    ecdsa_p521r1 = auto()
+    eddsa_25519 = auto()
+    modex = auto()
+    ipsec = auto()
+    pdcp = auto()
+    rsa = auto()
+    sm2 = auto()
+    tls_record = "tls-record"
+
+    def __str__(self) -> str:
+        """Override str to return the value."""
+        return self.value
+
+
+class CipherAlgorithm(StrEnum):
+    """Enum for cryptodev cipher algorithms.
+
+    Attributes:
+        aes_cbc: AES CBC cipher algorithm.
+        aes_ctr: AES CTR cipher algorithm.
+        aes_docsisbpi: AES DOCSIS BPI cipher algorithm.
+        aes_ecb: AES ECB cipher algorithm.
+        aes_f8: AES F8 cipher algorithm.
+        aes_xts: AES XTS cipher algorithm.
+        arc4: ARC4 cipher algorithm.
+        null: NULL cipher algorithm.
+        three_des_cbc: 3DES CBC cipher algorithm.
+        three_des_ctr: 3DES CTR cipher algorithm.
+        three_des_ecb: 3DES ECB cipher algorithm.
+        kasumi_f8: KASUMI F8 cipher algorithm.
+        snow3g_uea2: SNOW3G UEA2 cipher algorithm.
+        zuc_eea3: ZUC EEA3 cipher algorithm.
+    """
+
+    aes_cbc = "aes-cbc"
+    aes_ctr = "aes-ctr"
+    aes_docsisbpi = "aes-docsisbpi"
+    aes_ecb = "aes-ecb"
+    aes_f8 = "aes-f8"
+    aes_gcm = "aes-gcm"
+    aes_xts = "aes-xts"
+    arc4 = auto()
+    null = auto()
+    three_des_cbc = "3des-cbc"
+    three_des_ctr = "3des-ctr"
+    three_des_ecb = "3des-ecb"
+    kasumi_f8 = "kasumi-f8"
+    snow3g_uea2 = "snow3g-uea2"
+    zuc_eea3 = "zuc-eea3"
+
+    def __str__(self):
+        """Override str to return the value."""
+        return self.value
+
+
+class AuthenticationAlgorithm(StrEnum):
+    """Enum for cryptodev authentication algorithms.
+
+    Attributes:
+        aes_cbc_mac: AES CBC MAC authentication algorithm.
+        aes_cmac: AES CMAC authentication algorithm.
+        aes_gmac: AES GMAC authentication algorithm.
+        aes_xcbc_mac: AES XCBC MAC authentication algorithm.
+        kasumi_f9: KASUMI F9 authentication algorithm.
+        md5: MD5 authentication algorithm.
+        md5_hmac: MD5 HMAC authentication algorithm.
+        sha1: SHA1 authentication algorithm.
+        sha1_hmac: SHA1 HMAC authentication algorithm.
+        sha2_224: SHA2-224 authentication algorithm.
+        sha2_224_hmac: SHA2-224 HMAC authentication algorithm.
+        sha2_256: SHA2-256 authentication algorithm.
+        sha2_256_hmac: SHA2-256 HMAC authentication algorithm.
+        sha2_384: SHA2-384 authentication algorithm.
+        sha2_384_hmac: SHA2-384 HMAC authentication algorithm.
+        sha2_512: SHA2-512 authentication algorithm.
+        sha2_512_hmac: SHA2-512 HMAC authentication algorithm.
+        snow3g_uia2: SNOW3G UIA2 authentication algorithm.
+        zuc_eia3: ZUC EIA3 authentication algorithm.
+    """
+
+    aes_cbc_mac = "aes-cbc-mac"
+    aes_cmac = "aes-cmac"
+    aes_gmac = "aes-gmac"
+    aes_xcbc_mac = "aes-xcbc-mac"
+    kasumi_f9 = "kasumi-f9"
+    md5 = auto()
+    md5_hmac = "md5-hmac"
+    sha1 = auto()
+    sha1_hmac = "sha1-hmac"
+    sha2_224 = "sha2-224"
+    sha2_224_hmac = "sha2-224-hmac"
+    sha2_256 = "sha2-256"
+    sha2_256_hmac = "sha2-256-hmac"
+    sha2_384 = "sha2-384"
+    sha2_384_hmac = "sha2-384-hmac"
+    sha2_512 = "sha2-512"
+    sha2_512_hmac = "sha2-512-hmac"
+    snow3g_uia2 = "snow3g-uia2"
+    zuc_eia3 = "zuc-eia3"
+
+    def __str__(self) -> str:
+        """Override str to return the value."""
+        return self.value
+
+
+class TestType(StrEnum):
+    """Enum for cryptodev test types.
+
+    Attributes:
+        latency: Latency test type.
+        pmd_cyclecount: PMD cyclecount test type.
+        throughput: Throughput test type.
+        verify: Verify test type.
+    """
+
+    latency = auto()
+    pmd_cyclecount = "pmd-cyclecount"
+    throughput = auto()
+    verify = auto()
+
+    def __str__(self) -> str:
+        """Override str to return the value."""
+        return self.value
+
+
+class EncryptDecryptSwitch(StrEnum):
+    """Enum for cryptodev encrypt/decrypt operations.
+
+    Attributes:
+        decrypt: Decrypt operation.
+        encrypt: Encrypt operation.
+    """
+
+    decrypt = auto()
+    encrypt = auto()
+
+
+class AuthenticationOpMode(StrEnum):
+    """Enum for cryptodev authentication operation modes.
+
+    Attributes:
+        generate: Generate operation mode.
+        verify: Verify operation mode.
+    """
+
+    generate = auto()
+    verify = auto()
+
+
+class AeadAlgName(StrEnum):
+    """Enum for cryptodev AEAD algorithms.
+
+    Attributes:
+        aes_ccm: AES CCM algorithm.
+        aes_gcm: AES GCM algorithm.
+    """
+
+    aes_ccm = "aes-ccm"
+    aes_gcm = "aes-gcm"
+
+    def __str__(self):
+        """Override str to return the value."""
+        return self.value
+
+
+class AsymOpMode(StrEnum):
+    """Enum for cryptodev asymmetric operation modes.
+
+    Attributes:
+        decrypt: Decrypt operation mode.
+        encrypt: Encrypt operation mode.
+        sign: Sign operation mode.
+        verify: Verify operation mode.
+    """
+
+    decrypt = auto()
+    encrypt = auto()
+    sign = auto()
+    verify = auto()
+
+
+class PDCPDomain(StrEnum):
+    """Enum for cryptodev PDCP domains.
+
+    Attributes:
+        control: Control domain.
+        user: User domain.
+    """
+
+    control = auto()
+    user = auto()
+
+
+class RSAPrivKeyType(StrEnum):
+    """Enum for cryptodev RSA private key types.
+
+    Attributes:
+        exp: Exponent key type.
+        qt: QT key type.
+    """
+
+    exp = auto()
+    qt = auto()
+
+
+class TLSVersion(StrEnum):
+    """Enum for cryptodev TLS versions.
+
+    Attributes:
+        DTLS1_2: DTLS 1.2 version.
+        TLS1_2: TLS 1.2 version.
+        TLS1_3: TLS 1.3 version.
+    """
+
+    DTLS1_2 = "DTLS1.2"
+    TLS1_2 = "TLS1.2"
+    TLS1_3 = "TLS1.3"
+
+    def __str__(self):
+        """Override str to return the value."""
+        return self.value
+
+
+class RSAPrivKeytype(StrEnum):
+    """Enum for cryptodev RSA private key types.
+
+    Attributes:
+        exp: Exponent key type.
+        qt: QT key type.
+    """
+
+    exp = auto()
+    qt = auto()
+
+
+class BurstSizeRange:
+    """Class for burst size parameter.
+
+    Attributes:
+        burst_size: The burst size range, this list must be less than 32 elements.
+    """
+
+    burst_size: int | list[int]
+
+    def __init__(self, min: int, inc: int, max: int) -> None:
+        """Initialize the burst size range.
+
+        Args:
+            min: minimum value in range (inclusive)
+            inc: space in between each element in the range
+            max: maximum value in range (inclusive)
+
+        Raises:
+            ValueError: If the burst size range is more than 32 elements.
+        """
+        if (max - min) % inc > 32:
+            raise ValueError("Burst size range must be less than 32 elements.")
+        self.burst_size = list(range(min, max + 1, inc))
+
+
+class ListWrapper:
+    """Class for wrapping a list of integers.
+
+    One of the arguments for the cryptodev application is a list of integers. However, when
+    passing a list directly, it causes a syntax error in the command line. This class wraps
+    a list of integers and converts it to a comma-separated string for a proper command.
+    """
+
+    def __init__(self, values: list[int]) -> None:
+        """Initialize the list wrapper.
+
+        Args:
+            values: list of values to wrap
+        """
+        self.values = values
+
+    def __str__(self) -> str:
+        """Convert the list to a comma-separated string."""
+        return ",".join(str(v) for v in self.values)
+
+
+@dataclass(slots=True, kw_only=True)
+class CryptoPmdParams(EalParams):
+    """Parameters for cryptodev-pmd application.
+
+    Attributes:
+        aead_aad_sz: set the size of AEAD AAD.
+        aead_algo: set AEAD algorithm name from class `AeadAlgName`.
+        aead_iv_sz: set the size of AEAD iv.
+        aead_key_sz: set the size of AEAD key.
+        aead_op: set AEAD operation mode from class `EncryptDecryptSwitch`.
+        asym_op: set asymmetric operation mode from class `AsymOpMode`.
+        auth_algo: set authentication algorithm name.
+        auth_aad_sz: set the size of authentication AAD.
+        auth_iv_sz: set the size of authentication iv.
+        auth_key_sz: set the size of authentication key.
+        auth_op: set authentication operation mode from class `AuthenticationOpMode`.
+        buffer_sz: Set the size of a single packet (plaintext or ciphertext in it).
+            burst_sz: Set the number of packets per burst. This can be set as a single value or
+            range of values defined by class `BurstSizeRange`. Default is 16.
+        burst_sz: Set the number of packets per burst. This can be set as a single value or
+            range of values defined by class `BurstSizeRange`. Default is 16.
+        cipher_algo: Set cipher algorithm name from class `CipherAlgorithm`.
+        cipher_iv_sz: set the size of cipher iv.
+        cipher_key_sz: set the size of cipher key.
+        cipher_op: set cipher operation mode from class `EncryptDecryptSwitch`.
+        csv_friendly: Enable test result output CSV friendly rather than human friendly.
+        desc_nb: set the number of descriptors for each crypto device.
+        devtype: Set the device name from class `DeviceType`.
+        digest_sz: set the size of digest.
+        docsis_hdr_sz: set DOCSIS header size(n) in bytes.
+        enable_sdap: enable service data adaptation protocol.
+        imix: Set the distribution of packet sizes. A list of weights must be passed, containing the
+            same number of items than buffer-sz, so each item in this list will be the weight of the
+            packet size on the same position in the buffer-sz parameter (a list has to be passed in
+            that parameter).
+        low_prio_qp_mask: set low priority queue pairs set in the hexadecimal mask. This is an
+            optional parameter, if not set all queue pairs will be on the same high priority.
+        modex_len: set modex length for asymmetric crypto perf test. Supported lengths are 60,
+            128, 255, 448.  Default length is 128.
+        optype: Set operation type from class `OpType`.
+        out_of_place: Enable out-of-place crypto operations mode.
+        pdcp_sn_sz:  set PDCP sequebce number size(n) in bits. Valid values of n are 5/7/12/15/18.
+        pdcp_domain: Set PDCP domain to specify short_mac/control/user plane from class
+            `PDCPDomain`.
+        pdcp_ses_hfn_en: enable fixed session based HFN instead of per packet HFN.
+        pmd_cyclecount_delay_pmd: Add a delay (in milliseconds) between enqueue and dequeue in
+            pmd-cyclecount benchmarking mode (useful when benchmarking hardware acceleration).
+        pool_sz: Set the number if mbufs to be allocated in the mbuf pool.
+        ptest: Set performance throughput test type from class `TestType`.
+        rsa_modlen: Set RSA modulus length (in bits) for asymmetric crypto perf test.
+            To be used with RSA asymmetric crypto ops.Supported lengths are 1024, 2048, 4096, 8192.
+            Default length is 1024.
+        rsa_priv_keytype: set RSA private key type from class `RSAPrivKeytype`. To be used with RSA
+            asymmetric crypto ops.
+        segment_sz: Set the size of the segment to use, for Scatter Gather List testing. Use list of
+            values in buffer-sz in descending order if segment-sz is used. By default, it is set to
+            the size of the maximum buffer size, including the digest size, so a single segment is
+            created.
+        sessionless: Enable session-less crypto operations mode.
+        shared_session: Enable sharing sessions between all queue pairs on a single crypto PMD. This
+            can be useful for benchmarking this setup, or finding and debugging concurrency errors
+            that can occur while using sessions on multiple lcores simultaneously.
+        silent: Disable options dump.
+        test_file: Set test vector file path. See the Test Vector File chapter.
+        test_name: Set specific test name section in the test vector file.
+        tls_version: Set TLS/DTLS protocol version for perf test from class `TLSVersion`.
+            Default is TLS1.2.
+        total_ops: Set the number of total operations performed.
+    """
+
+    aead_aad_sz: int | None = field(default=None, metadata=Params.long("aead-aad-sz"))
+    aead_algo: AeadAlgName | None = field(default=None, metadata=Params.long("aead-algo"))
+    aead_iv_sz: int | None = field(default=None, metadata=Params.long("aead-iv-sz"))
+    aead_key_sz: int | None = field(default=None, metadata=Params.long("aead-key-sz"))
+    aead_op: EncryptDecryptSwitch | None = field(default=None, metadata=Params.long("aead-op"))
+    asym_op: AsymOpMode | None = field(default=None, metadata=Params.long("asym-op"))
+    auth_algo: AuthenticationAlgorithm | None = field(
+        default=None, metadata=Params.long("auth-algo")
+    )
+    auth_iv_sz: int | None = field(default=None, metadata=Params.long("auth-iv-sz"))
+    auth_key_sz: int | None = field(default=None, metadata=Params.long("auth-key-sz"))
+    auth_op: AuthenticationOpMode | None = field(default=None, metadata=Params.long("auth-op"))
+    buffer_sz: BurstSizeRange | ListWrapper | int | None = field(
+        default=None, metadata=Params.long("buffer-sz")
+    )
+    burst_sz: BurstSizeRange | ListWrapper | int | None = field(
+        default=None, metadata=Params.long("burst-sz")
+    )
+    cipher_algo: CipherAlgorithm | None = field(default=None, metadata=Params.long("cipher-algo"))
+    cipher_iv_sz: int | None = field(default=None, metadata=Params.long("cipher-iv-sz"))
+    cipher_key_sz: int | None = field(default=None, metadata=Params.long("cipher-key-sz"))
+    cipher_op: EncryptDecryptSwitch | None = field(default=None, metadata=Params.long("cipher-op"))
+    csv_friendly: Switch = field(default=None, metadata=Params.long("csv-friendly"))
+    desc_nb: int | None = field(default=None, metadata=Params.long("desc-nb"))
+    devtype: DeviceType = field(metadata=Params.long("devtype"))
+    digest_sz: int | None = field(default=None, metadata=Params.long("digest-sz"))
+    docsis_hdr_sz: int | None = field(default=None, metadata=Params.long("docsis-hdr-sz"))
+    enable_sdap: Switch = None
+    imix: int | None = field(default=None, metadata=Params.long("imix"))
+    low_prio_qp_mask: int | None = field(default=None, metadata=Params.convert_value(hex))
+    modex_len: int | None = field(default=None, metadata=Params.long("modex-len"))
+    optype: OperationType | None = field(default=None, metadata=Params.long("optype"))
+    out_of_place: Switch = None
+    pdcp_sn_sz: int | None = None
+    pdcp_domain: PDCPDomain | None = field(default=None, metadata=Params.long("pdcp-domain"))
+    pdcp_ses_hfn_en: Switch | None = field(default=None, metadata=Params.long("pdcp-ses-hfn-en"))
+    pmd_cyclecount_delay_pmd: int | None = field(
+        default=None, metadata=Params.long("pmd-cyclecount-delay-pmd")
+    )
+    pool_sz: int | None = field(default=None, metadata=Params.long("pool-sz"))
+    ptest: TestType = field(default=TestType.throughput, metadata=Params.long("ptest"))
+    rsa_modlen: int | None = field(default=None, metadata=Params.long("rsa-modlen"))
+    rsa_priv_keytype: RSAPrivKeytype | None = field(
+        default=None, metadata=Params.long("rsa-priv-keytype")
+    )
+    segment_sz: int | None = field(default=None, metadata=Params.long("segment-sz"))
+    sessionless: Switch = None
+    shared_session: Switch = None
+    silent: Silent | None = field(default="", metadata=Params.long("silent"))
+    test_file: str | None = field(default=None, metadata=Params.long("test-file"))
+    test_name: str | None = field(default=None, metadata=Params.long("test-name"))
+    tls_version: TLSVersion | None = field(default=None, metadata=Params.long("tls-version"))
+    total_ops: int | None = field(default=100000, metadata=Params.long("total-ops"))
diff --git a/dts/api/cryptodev/types.py b/dts/api/cryptodev/types.py
new file mode 100644
index 0000000000..df73a86fa4
--- /dev/null
+++ b/dts/api/cryptodev/types.py
@@ -0,0 +1,185 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 University of New Hampshire
+
+"""Cryptodev types module.
+
+Exposes types used in the Cryptodev API.
+"""
+
+from dataclasses import dataclass, field
+
+from framework.parser import TextParser
+
+
+@dataclass
+class CryptodevResults(TextParser):
+    """Base class for all cryptodev results."""
+
+    buffer_size: int
+
+    def __iter__(self):
+        """Iteration method to parse result objects.
+
+        Yields:
+            tuple[str, int | float]: a field name and its value.
+        """
+        for field_name in self.__dataclass_fields__:
+            yield field_name, getattr(self, field_name)
+
+
+@dataclass
+class ThroughputResults(CryptodevResults):
+    """A parser for throughput test output."""
+
+    #:
+    lcore_id: int = field(metadata=TextParser.find_int(r"\s*(\d+)"))
+    #: buffer size used in the run
+    buffer_size: int = field(
+        metadata=TextParser.find_int(r"\s+(?:\d+\s+)(\d+)"),
+    )
+    #: burst size used in the run
+    burst_size: int = field(
+        metadata=TextParser.find_int(r"\s+(?:\d+\s+){2}(\d+)"),
+    )
+    #: total packets enqueued
+    enqueued: int = field(metadata=TextParser.find_int(r"\s+(?:\d+\s+){3}(\d+)"))
+    #: total packets dequeued
+    dequeued: int = field(metadata=TextParser.find_int(r"\s+(?:\d+\s+){4}(\d+)"))
+    #: packets that failed enqueue
+    failed_enqueue: int = field(metadata=TextParser.find_int(r"\s+(?:\d+\s+){5}(\d+)"))
+    #: packets that failed dequeue
+    failed_dequeue: int = field(metadata=TextParser.find_int(r"\s+(?:\d+\s+){6}(\d+)"))
+    #: mega operations per second
+    mops: float = field(metadata=TextParser.find_float(r"\s+(?:\d+\s+){7}([\d.]+)"))
+    #: gigabits per second
+    gbps: float = field(metadata=TextParser.find_float(r"\s+(?:\d+\s+){7}(?:[\d.]+\s+)([\d.]+)"))
+    #: cpu cycles per buffer
+    cycles_per_buffer: float = field(
+        metadata=TextParser.find_float(r"\s+(?:\d+\s+){7}(?:[\d.]+\s+){2}([\d.]+)")
+    )
+
+
+@dataclass
+class LatencyResults(CryptodevResults):
+    """A parser for latency test output."""
+
+    #: buffer size ran with app
+    buffer_size: int = field(
+        metadata=TextParser.find_int(r"Buf(?:.*\n\s+\d+\s+)?(?:fer size:\s+)?(\d+)"),
+    )
+    #: burst size ran with app
+    burst_size: int = field(
+        metadata=TextParser.find_int(rf"Burst(?:.*\n\s+\d+\s+){2}?(?: size:\s+)?(\d+)"),
+    )
+    #: total operations ran
+    total_ops: int = field(metadata=TextParser.find_int(r"total operations:\s+(\d+)"))
+    #: number of bursts
+    num_of_bursts: int = field(metadata=TextParser.find_int(r"Number of bursts:\s+(\d+)"))
+    #: minimum enqueued packets
+    min_enqueued: int = field(metadata=TextParser.find_int(r"enqueued\s+(?:\d+\s+){2}(\d+)"))
+    #: maximum enqueued packets
+    max_enqueued: int = field(metadata=TextParser.find_int(r"enqueued\s+(?:\d+\s+){3}(\d+)"))
+    #: average enqueued packets
+    avg_enqueued: int = field(metadata=TextParser.find_int(r"enqueued\s+(?:\d+\s+)(\d+)"))
+    #: total enqueued packets
+    total_enqueued: int = field(metadata=TextParser.find_int(r"enqueued\s+(\d+)"))
+    #: minimum dequeued packets
+    min_dequeued: int = field(metadata=TextParser.find_int(r"dequeued\s+(?:\d+\s+){2}(\d+)"))
+    #: maximum dequeued packets
+    max_dequeued: int = field(metadata=TextParser.find_int(r"dequeued\s+(?:\d+\s+){3}(\d+)"))
+    #: average dequeued packets
+    avg_dequeued: int = field(metadata=TextParser.find_int(r"dequeued\s+(?:\d+\s+)(\d+)"))
+    #: total dequeued packets
+    total_dequeued: int = field(metadata=TextParser.find_int(r"dequeued\s+(\d+)"))
+    #: minimum cycles per buffer
+    min_cycles: float = field(metadata=TextParser.find_float(r"cycles\s+(?:[\d.]+\s+){3}([\d.]+)"))
+    #: maximum cycles per buffer
+    max_cycles: float = field(metadata=TextParser.find_float(r"cycles\s+(?:[\d.]+\s+){2}([\d.]+)"))
+    #: average cycles per buffer
+    avg_cycles: float = field(metadata=TextParser.find_float(r"cycles\s+(?:[\d.]+\s+)([\d.]+)"))
+    #: total cycles per buffer
+    total_cycles: float = field(metadata=TextParser.find_float(r"cycles\s+([\d.]+)"))
+    #: mimum time in microseconds
+    min_time_us: float = field(
+        metadata=TextParser.find_float(r"time \[us\]\s+(?:[\d.]+\s+){3}([\d.]+)")
+    )
+    #: maximum time in microseconds
+    max_time_us: float = field(
+        metadata=TextParser.find_float(r"time \[us\]\s+(?:[\d.]+\s+){2}([\d.]+)")
+    )
+    #: average time in microseconds
+    avg_time_us: float = field(
+        metadata=TextParser.find_float(r"time \[us\]\s+(?:[\d.]+\s+)([\d.]+)")
+    )
+    #: total time in microseconds
+    total_time_us: float = field(metadata=TextParser.find_float(r"time \[us\]\s+([\d.]+)"))
+
+
+@dataclass
+class PmdCyclecountResults(CryptodevResults):
+    """A parser for PMD cycle count test output."""
+
+    #:
+    lcore_id: int = field(metadata=TextParser.find_int(r"lcore\s+(?:id.*\n\s+)?(\d+)"))
+    #: buffer size used with app run
+    buffer_size: int = field(
+        metadata=TextParser.find_int(r"Buf(?:.*\n\s+(?:\d+\s+))?(?:fer size:\s+)?(\d+)"),
+    )
+    #: burst size used with app run
+    burst_size: int = field(
+        metadata=TextParser.find_int(r"Burst(?:.*\n\s+(?:\d+\s+){2})?(?: size:\s+)?(\d+)"),
+    )
+    #: packets enqueued
+    enqueued: int = field(metadata=TextParser.find_int(r"Enqueued.*\n\s+(?:\d+\s+){3}(\d+)"))
+    #: packets dequeued
+    dequeued: int = field(metadata=TextParser.find_int(r"Dequeued.*\n\s+(?:\d+\s+){4}(\d+)"))
+    #: number of enqueue packet retries
+    enqueue_retries: int = field(
+        metadata=TextParser.find_int(r"Enq Retries.*\n\s+(?:\d+\s+){5}(\d+)")
+    )
+    #: number of dequeue packet retries
+    dequeue_retries: int = field(
+        metadata=TextParser.find_int(r"Deq Retries.*\n\s+(?:\d+\s+){6}(\d+)")
+    )
+    #: number of cycles per operation
+    cycles_per_operation: float = field(
+        metadata=TextParser.find_float(r"Cycles/Op.*\n\s+(?:\d+\s+){7}([\d.]+)")
+    )
+    #: number of cycles per enqueue
+    cycles_per_enqueue: float = field(
+        metadata=TextParser.find_float(r"Cycles/Enq.*\n\s+(?:\d+\s+){7}(?:[\d.]+\s+)([\d.]+)")
+    )
+    #: number of cycles per dequeue
+    cycles_per_dequeue: float = field(
+        metadata=TextParser.find_float(r"Cycles/Deq.*\n\s+(?:\d+\s+){7}(?:[\d.]+\s+){2}([\d.]+)"),
+    )
+
+
+@dataclass
+class VerifyResults(CryptodevResults):
+    """A parser for verify test output."""
+
+    #:
+    lcore_id: int = field(metadata=TextParser.find_int(r"lcore\s+(?:id.*\n\s+)?(\d+)"))
+    #: buffer size ran with app
+    buffer_size: int = field(
+        metadata=TextParser.find_int(r"Buf(?:.*\n\s+(?:\d+\s+))?(?:fer size:\s+)?(\d+)"),
+    )
+    #: burst size ran with app
+    burst_size: int = field(
+        metadata=TextParser.find_int(r"Burst(?:.*\n\s+(?:\d+\s+){2})?(?: size:\s+)?(\d+)"),
+    )
+    #: number of packets enqueued
+    enqueued: int = field(metadata=TextParser.find_int(r"Enqueued.*\n\s+(?:\d+\s+){3}(\d+)"))
+    #: number of packets dequeued
+    dequeued: int = field(metadata=TextParser.find_int(r"Dequeued.*\n\s+(?:\d+\s+){4}(\d+)"))
+    #: number of packets enqueue failed
+    failed_enqueued: int = field(
+        metadata=TextParser.find_int(r"Failed Enq.*\n\s+(?:\d+\s+){5}(\d+)")
+    )
+    #: number of packets dequeue failed
+    failed_dequeued: int = field(
+        metadata=TextParser.find_int(r"Failed Deq.*\n\s+(?:\d+\s+){6}(\d+)")
+    )
+    #: total number of failed operations
+    failed_ops: int = field(metadata=TextParser.find_int(r"Failed Ops.*\n\s+(?:\d+\s+){7}(\d+)"))
diff --git a/dts/configurations/nodes.example.yaml b/dts/configurations/nodes.example.yaml
index 4da5585318..b9e567b442 100644
--- a/dts/configurations/nodes.example.yaml
+++ b/dts/configurations/nodes.example.yaml
@@ -4,6 +4,12 @@
 
 # Optional Fields:
 #   `hugepages_2mb`: if removed, will use system hugepage configuration
+#   `cryptodevs`:
+#     Uncomment to run cryptodev tests; add physical cryptodev devices by their BDF
+#   `crypto_device_type`:
+#     Uncomment to run cryptodev tests; the device type of the DUT e.g. (crypto_qat, crypto_zuc,
+#     crypto_aesni_mb) the complete list of device types can be found here
+#     https://doc.dpdk.org/guides-24.07/cryptodevs/overview.html
 
 # Define a system under test node, having two network ports physically
 # connected to the corresponding ports in TG 1 (the peer node)
@@ -23,6 +29,12 @@
   hugepages_2mb: # see 'Optional Fields'
       number_of: 256
       force_first_numa: false
+  # cryptodevs: # see `Optional Fields`
+  #   - name: cryptodev-0
+  #     pci: "ffff:ff:ff.9"
+  #     os_driver_for_dpdk: vfio-pci # OS driver that DPDK will use for cryptodev VFs
+  #     os_driver: _ # This is unused but a value is necessary to run dts
+  # crypto_device_type: # see `Optional Fields`
 # Define a Scapy traffic generator node, having two network ports
 # physically connected to the corresponding ports in SUT 1 (the peer node).
 - name: "TG 1"
diff --git a/dts/framework/config/node.py b/dts/framework/config/node.py
index 438a1bdc8f..792290f11f 100644
--- a/dts/framework/config/node.py
+++ b/dts/framework/config/node.py
@@ -70,6 +70,10 @@ class NodeConfiguration(FrozenModel):
     hugepages: HugepageConfiguration | None = Field(None, alias="hugepages_2mb")
     #: The ports that can be used in testing.
     ports: list[PortConfig] = Field(min_length=1)
+    #: The pci info used by crypto devices
+    cryptodevs: list[PortConfig] = Field(default=[], min_length=0)
+    #: The crypto driver used by crypto devices
+    crypto_device_type: str | None = None
 
     @model_validator(mode="after")
     def verify_unique_port_names(self) -> Self:
diff --git a/dts/framework/params/types.py b/dts/framework/params/types.py
index 5bc4bd37d9..3c7650474c 100644
--- a/dts/framework/params/types.py
+++ b/dts/framework/params/types.py
@@ -15,6 +15,23 @@ def create_testpmd(**kwargs: Unpack[TestPmdParamsDict]):
 from pathlib import PurePath
 from typing import TypedDict
 
+from api.cryptodev.config import (
+    AeadAlgName,
+    AsymOpMode,
+    AuthenticationAlgorithm,
+    AuthenticationOpMode,
+    BurstSizeRange,
+    CipherAlgorithm,
+    DeviceType,
+    EncryptDecryptSwitch,
+    ListWrapper,
+    OperationType,
+    PDCPDomain,
+    RSAPrivKeytype,
+    Silent,
+    TestType,
+    TLSVersion,
+)
 from api.testpmd.config import (
     AnonMempoolAllocationMode,
     EthPeer,
@@ -55,6 +72,54 @@ class EalParamsDict(TypedDict, total=False):
     other_eal_param: Params | None
 
 
+class CryptoPmdParamsDict(EalParamsDict, total=False):
+    """:class:`TypedDict` equivalent of :class:`~.cryptodev.CryptoPmdParams`."""
+
+    aead_aad_sz: int | None
+    aead_algo: AeadAlgName | None
+    aead_iv_sz: int | None
+    aead_key_sz: int | None
+    aead_op: EncryptDecryptSwitch | None
+    asym_op: AsymOpMode | None
+    auth_algo: AuthenticationAlgorithm | None
+    auth_iv_sz: int | None
+    auth_key_sz: int | None
+    auth_op: AuthenticationOpMode | None
+    buffer_sz: BurstSizeRange | ListWrapper | int | None
+    burst_sz: BurstSizeRange | ListWrapper | int | None
+    cipher_algo: CipherAlgorithm | None
+    cipher_iv_sz: int | None
+    cipher_key_sz: int | None
+    cipher_op: EncryptDecryptSwitch | None
+    csv_friendly: Switch
+    desc_nb: int | None
+    devtype: DeviceType | None
+    digest_sz: int | None
+    docsis_hdr_sz: int | None
+    enable_sdap: Switch
+    imix: int | None
+    low_prio_qp_mask: int | None
+    modex_len: int | None
+    optype: OperationType | None
+    out_of_place: Switch
+    pdcp_sn_sz: int | None
+    pdcp_domain: PDCPDomain | None
+    pdcp_ses_hfn_en: Switch | None
+    pmd_cyclecount_delay_pmd: int | None
+    pool_sz: int | None
+    ptest: TestType
+    rsa_modlen: int | None
+    rsa_priv_keytype: RSAPrivKeytype | None
+    segment_sz: int | None
+    sessionless: Switch
+    shared_session: Switch
+    silent: Silent | None
+    test_file: str | None
+    test_name: str | None
+    tls_version: TLSVersion | None
+    total_ops: int | None
+
+
 class TestPmdParamsDict(EalParamsDict, total=False):
     """:class:`TypedDict` equivalent of :class:`~.testpmd.TestPmdParams`."""
 
diff --git a/dts/framework/remote_session/dpdk_shell.py b/dts/framework/remote_session/dpdk_shell.py
index 51b97d4ff6..b94d336d4e 100644
--- a/dts/framework/remote_session/dpdk_shell.py
+++ b/dts/framework/remote_session/dpdk_shell.py
@@ -46,7 +46,10 @@ def compute_eal_params(
     params.prefix = prefix
 
     if params.allowed_ports is None:
-        params.allowed_ports = ctx.topology.sut_dpdk_ports
+        if ctx.topology.crypto_vf_ports:
+            params.allowed_ports = [ctx.topology.crypto_vf_ports[0]]
+        else:
+            params.allowed_ports = ctx.topology.sut_dpdk_ports
 
     return params
 
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index ff0a12c9ce..494eb40046 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -349,6 +349,9 @@ def next(self) -> State | None:
 
         if test_run.config.use_virtual_functions:
             test_run.ctx.topology.instantiate_vf_ports()
+        if test_run.ctx.sut_node.cryptodevs:
+            test_run.ctx.topology.instantiate_crypto_ports()
+            test_run.ctx.topology.bind_cryptodevs("dpdk")
 
         test_run.ctx.topology.configure_ports("sut", "dpdk")
         if test_run.ctx.func_tg:
@@ -442,6 +445,8 @@ def next(self) -> State | None:
         """Next state."""
         if self.test_run.config.use_virtual_functions:
             self.test_run.ctx.topology.delete_vf_ports()
+        if self.test_run.ctx.sut_node.cryptodevs:
+            self.test_run.ctx.topology.delete_crypto_vf_ports()
 
         self.test_run.ctx.shell_pool.terminate_current_pool()
         if self.test_run.ctx.func_tg and self.test_run.ctx.func_tg.is_setup:
diff --git a/dts/framework/testbed_model/linux_session.py b/dts/framework/testbed_model/linux_session.py
index 2f4aef1460..ee943462c2 100644
--- a/dts/framework/testbed_model/linux_session.py
+++ b/dts/framework/testbed_model/linux_session.py
@@ -10,6 +10,7 @@
 """
 
 import json
+import re
 from collections.abc import Iterable
 from functools import cached_property
 from pathlib import PurePath
@@ -247,6 +248,30 @@ def load_vfio(self, pf_port: Port) -> None:
             self.send_command("modprobe vfio-pci")
         self.refresh_lshw()
 
+    def create_crypto_vfs(self, pf_port: list[Port]) -> None:
+        """Overrides :meth:`~os_session.OSSession.create_crypto_vfs`.
+
+        Raises:
+            InternalError: If there are existing VFs which have to be deleted.
+        """
+        for port in pf_port:
+            self.delete_crypto_vfs(port)
+        for port in pf_port:
+            sys_bus_path = f"/sys/bus/pci/devices/{port.pci}".replace(":", "\\:")
+            curr_num_vfs = int(
+                self.send_command(f"cat {sys_bus_path}/sriov_numvfs", privileged=True).stdout
+            )
+            if 0 < curr_num_vfs:
+                raise InternalError("There are existing VFs on the port which must be deleted.")
+            num_vfs = int(
+                self.send_command(f"cat {sys_bus_path}/sriov_totalvfs", privileged=True).stdout
+            )
+            self.send_command(
+                f"echo {num_vfs} | sudo tee {sys_bus_path}/sriov_numvfs", privileged=True
+            )
+
+        self.refresh_lshw()
+
     def create_vfs(self, pf_port: Port) -> None:
         """Overrides :meth:`~.os_session.OSSession.create_vfs`.
 
@@ -263,6 +288,14 @@ def create_vfs(self, pf_port: Port) -> None:
             self.send_command(f"echo 1 | sudo tee {sys_bus_path}/sriov_numvfs", privileged=True)
             self.refresh_lshw()
 
+    def delete_crypto_vfs(self, pf_port: Port) -> None:
+        """Overrides :meth:`~.os_session.OSSession.delete_crypto_vfs`."""
+        self.send_command(
+            f"echo 1 | sudo tee /sys/bus/pci/devices/{pf_port.pci}/remove".replace(":", "\\:"),
+            privileged=True,
+        )
+        self.send_command("echo 1 | sudo tee /sys/bus/pci/rescan", privileged=True)
+
     def delete_vfs(self, pf_port: Port) -> None:
         """Overrides :meth:`~.os_session.OSSession.delete_vfs`."""
         sys_bus_path = f"/sys/bus/pci/devices/{pf_port.pci}".replace(":", "\\:")
@@ -274,6 +307,18 @@ def delete_vfs(self, pf_port: Port) -> None:
         else:
             self.send_command(f"echo 0 | sudo tee {sys_bus_path}/sriov_numvfs", privileged=True)
 
+    def get_pci_addr_of_crypto_vfs(self, pf_port: Port) -> list[str]:
+        """Overrides :meth:`~.os_session.OSSession.get_pci_addr_of_crypto_vfs`."""
+        sys_bus_path = f"/sys/bus/pci/devices/{pf_port.pci}".replace(":", "\\:")
+        curr_num_vfs = int(self.send_command(f"cat {sys_bus_path}/sriov_numvfs").stdout)
+        if curr_num_vfs > 0:
+            pci_addrs = self.send_command(
+                f"readlink {sys_bus_path}/virtfn*",
+                privileged=True,
+            )
+            return [pci.replace("../", "") for pci in pci_addrs.stdout.splitlines()]
+        return []
+
     def get_pci_addr_of_vfs(self, pf_port: Port) -> list[str]:
         """Overrides :meth:`~.os_session.OSSession.get_pci_addr_of_vfs`."""
         sys_bus_path = f"/sys/bus/pci/devices/{pf_port.pci}".replace(":", "\\:")
diff --git a/dts/framework/testbed_model/node.py b/dts/framework/testbed_model/node.py
index 6c3e63a2a1..67a96ef4e5 100644
--- a/dts/framework/testbed_model/node.py
+++ b/dts/framework/testbed_model/node.py
@@ -54,6 +54,8 @@ class Node:
     arch: Architecture
     lcores: list[LogicalCore]
     ports: list[Port]
+    cryptodevs: list[Port]
+    crypto_device_type: str | None
     _logger: DTSLogger
     _other_sessions: list[OSSession]
     _node_info: OSSessionInfo | None
@@ -82,6 +84,14 @@ def __init__(self, node_config: NodeConfiguration) -> None:
         self._other_sessions = []
         self._setup = False
         self.ports = [Port(self, port_config) for port_config in self.config.ports]
+        self.cryptodevs = [
+            Port(self, cryptodev_config) for cryptodev_config in self.config.cryptodevs
+        ]
+        self.crypto_device_type = self.config.crypto_device_type
+        if self.cryptodevs:
+            self.main_session.load_vfio(self.cryptodevs[0])
+        elif self.ports and self.ports[0].config.os_driver_for_dpdk == "vfio-pci":
+            self.main_session.load_vfio(self.ports[0])
         self._logger.info(f"Created node: {self.name}")
 
     def setup(self) -> None:
diff --git a/dts/framework/testbed_model/os_session.py b/dts/framework/testbed_model/os_session.py
index f3064feeaa..2c267afed1 100644
--- a/dts/framework/testbed_model/os_session.py
+++ b/dts/framework/testbed_model/os_session.py
@@ -619,6 +619,14 @@ def configure_port_mtu(self, mtu: int, port: Port) -> None:
     def load_vfio(self, pf_port: Port) -> None:
         """Load the vfio module according to the device type of the given port."""
 
+    @abstractmethod
+    def create_crypto_vfs(self, pf_ports: list[Port]) -> None:
+        """Creates virtual functions for each port in 'pf_ports'.
+
+        Checks how many virtual functions each crypto device in 'pf_ports' supports, and creates
+            that number of VFs on the port.
+        """
+
     @abstractmethod
     def create_vfs(self, pf_port: Port) -> None:
         """Creates virtual functions for `pf_port`.
@@ -634,6 +642,16 @@ def create_vfs(self, pf_port: Port) -> None:
             maximum for `pf_port`.
         """
 
+    @abstractmethod
+    def delete_crypto_vfs(self, pf_port: Port) -> None:
+        """Deletes virtual functions for crypto device 'pf_port'.
+
+        Checks how many virtual functions are currently active and removes all if any exist.
+
+        Args:
+            pf_port: The crypto device port to delete virtual functions on.
+        """
+
     @abstractmethod
     def delete_vfs(self, pf_port: Port) -> None:
         """Deletes virtual functions for `pf_port`.
@@ -660,3 +678,15 @@ def get_pci_addr_of_vfs(self, pf_port: Port) -> list[str]:
             A list containing all of the PCI addresses of the VFs on the port. If the port has no
             VFs then the list will be empty.
         """
+
+    @abstractmethod
+    def get_pci_addr_of_crypto_vfs(self, pf_port: Port) -> list[str]:
+        """Find the PCI addresses of all virtual functions (VFs) of a crypto device on `pf_port`.
+
+        Args:
+            pf_port: The port to find the VFs on.
+
+        Returns:
+            A list containing all of the PCI addresses of the VFs on the port. If the port has no
+            VFs then the list will be empty.
+        """
diff --git a/dts/framework/testbed_model/topology.py b/dts/framework/testbed_model/topology.py
index 13b4b58a74..34862c4d2e 100644
--- a/dts/framework/testbed_model/topology.py
+++ b/dts/framework/testbed_model/topology.py
@@ -8,6 +8,7 @@
 The link information then implies what type of topology is available.
 """
 
+import re
 from collections import defaultdict
 from collections.abc import Iterator
 from dataclasses import dataclass
@@ -58,6 +59,8 @@ class Topology:
     tg_ports: list[Port]
     pf_ports: list[Port]
     vf_ports: list[Port]
+    crypto_pf_ports: list[Port]
+    crypto_vf_ports: list[Port]
 
     @classmethod
     def from_port_links(cls, port_links: Iterator[PortLink]) -> Self:
@@ -85,7 +88,7 @@ def from_port_links(cls, port_links: Iterator[PortLink]) -> Self:
                     msg = "More than two links in a topology are not supported."
                     raise ConfigurationError(msg)
 
-        return cls(type, sut_ports, tg_ports, [], [])
+        return cls(type, sut_ports, tg_ports, [], [], [], [])
 
     def node_and_ports_from_id(self, node_identifier: NodeIdentifier) -> tuple[Node, list[Port]]:
         """Retrieve node and its ports for the current topology.
@@ -105,6 +108,32 @@ def node_and_ports_from_id(self, node_identifier: NodeIdentifier) -> tuple[Node,
                 msg = f"Invalid node `{node_identifier}` given."
                 raise InternalError(msg)
 
+    def get_crypto_vfs(self, num_vfs: int) -> list[Port]:
+        """Retrieve virtual functions from active crypto vfs.
+
+        Args:
+            num_vfs: Number of virtual functions to return.
+
+        Returns:
+            List containing the requested number of VFs
+
+        Raises:
+            ValueError: If there are not `num_vfs` available VFs
+        """
+        return_list: list[Port] = []
+        device = 1
+        if len(self.crypto_vf_ports) < num_vfs or num_vfs < 0:
+            raise ValueError
+        for i in range(num_vfs):
+            if i % 8 == 0 and i != 0:
+                device += 1
+            for port in filter(
+                lambda x: re.search(rf"0000:\d+:0{device}.{i}", x.pci), self.crypto_vf_ports
+            ):
+                if len(return_list) < num_vfs:
+                    return_list.append(port)
+        return return_list
+
     def setup(self) -> None:
         """Setup topology ports.
 
@@ -145,6 +174,32 @@ def _setup_ports(self, node_identifier: NodeIdentifier) -> None:
                     f"for port {port.name} in node {node.name}."
                 )
 
+    def instantiate_crypto_ports(self) -> None:
+        """Create max number of virtual functions allowed on the SUT node from physical BDFs.
+
+        Raises:
+            InternalError: If crypto virtual functions could not be created on a port.
+        """
+        from framework.context import get_ctx
+
+        ctx = get_ctx()
+        for port in ctx.sut_node.cryptodevs:
+            self.crypto_pf_ports.append(port)
+
+        ctx.sut_node.main_session.create_crypto_vfs(self.crypto_pf_ports)
+        for port in self.crypto_pf_ports:
+            addr_list = ctx.sut_node.main_session.get_pci_addr_of_crypto_vfs(port)
+            if addr_list == []:
+                raise InternalError(f"Failed to create crypto virtual function on port {port.pci}")
+            for addr in addr_list:
+                vf_config = PortConfig(
+                    name=f"{port.name}-crypto-vf-{addr}",
+                    pci=addr,
+                    os_driver_for_dpdk=port.config.os_driver_for_dpdk,
+                    os_driver=port.config.os_driver,
+                )
+                self.crypto_vf_ports.append(Port(node=port.node, config=vf_config))
+
     def instantiate_vf_ports(self) -> None:
         """Create, setup, and add virtual functions to the list of ports on the SUT node.
 
@@ -189,6 +244,25 @@ def delete_vf_ports(self) -> None:
         self.sut_ports.clear()
         self.sut_ports.extend(self.pf_ports)
 
+    def delete_crypto_vf_ports(self) -> None:
+        """Delete crypto virtual functions from the SUT node during test run teardown."""
+        from framework.context import get_ctx
+
+        ctx = get_ctx()
+
+        for port in self.crypto_pf_ports:
+            ctx.sut_node.main_session.delete_crypto_vfs(port)
+
+    def bind_cryptodevs(self, driver: DriverKind):
+        """Bind the crypto device virtual functions on the sut to the specified driver.
+
+        Args:
+            driver: The driver to bind the crypto functions
+        """
+        from framework.context import get_ctx
+
+        self._bind_ports_to_drivers(get_ctx().sut_node, self.crypto_vf_ports, driver)
+
     def configure_ports(
         self, node_identifier: NodeIdentifier, drivers: DriverKind | tuple[DriverKind, ...]
     ) -> None:
@@ -227,7 +301,7 @@ def _bind_ports_to_drivers(
         for port_id, port in enumerate(ports):
             driver_kind = drivers[port_id] if isinstance(drivers, tuple) else drivers
             desired_driver = port.driver_by_kind(driver_kind)
-            if port.current_driver != desired_driver:
+            if port in self.crypto_vf_ports or port.current_driver != desired_driver:
                 driver_to_ports[desired_driver].append(port)
 
         for driver_name, ports in driver_to_ports.items():
-- 
2.50.1

