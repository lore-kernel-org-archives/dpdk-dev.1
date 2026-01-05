Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A427C79FB7
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Jan 2026 19:07:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DC9640661;
	Mon,  5 Jan 2026 20:06:56 +0100 (CET)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by mails.dpdk.org (Postfix) with ESMTP id F33354026F
 for <dev@dpdk.org>; Mon,  5 Jan 2026 20:06:52 +0100 (CET)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-8b2a4b6876fso26091285a.3
 for <dev@dpdk.org>; Mon, 05 Jan 2026 11:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1767640012; x=1768244812; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ooDX/K+mLjSMUa0LirPxRZefBHt75szwh7dEKCCRMTs=;
 b=duZroeRu2U+kojaQi+VgXTwT4d9/7UFkchXaY9A+f3kDPUrsWoALELq1htCeLCN2QQ
 pXxt2cAA19CJXY5rPD2pfApPXsp7DWwWypWMr20rxm5EJ+iDAMgPArymYu6CFJD1M37H
 kGNML3vFj7APB7Bq0KzxS2jGoN91OTtGJo1ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767640012; x=1768244812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ooDX/K+mLjSMUa0LirPxRZefBHt75szwh7dEKCCRMTs=;
 b=Yb5cADocQqKN+Xam4EO4+cGj81zbLJ7yFeoeS0KF85IwM3HfM+jlQQ8+q+QCKFQumO
 cGccId0KX3t4Sfft+uUfF56cvV4l3MxCujmEeFhcyugzOov35Sn2e5RxyD0OyYgEZyoz
 58XACHUpkQvHqibxPe0apruDOfEFtVN2lQt+Yre959/v0PKnQ91fjTCv4gnJT+pI4x1v
 xD+Rk2PimOcFboQ9/VX+xLsK///CBzV6KlX3XBsqQBkINNJfG5U66njJXv3PJ7ytH2Qq
 pwdj3gVETD9n3NM2IvwoT6TX2khb3lr0wh3PT+iPXds35xPJTlQeNLaLIcyxeX5bjBNG
 WfKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVijAP7XcgpAiwTz5wDXh0fboOFYbP9xUelGivgozatT/Rakl4TFl5KfC+imyO7Sx/dcTQ=@dpdk.org
X-Gm-Message-State: AOJu0Yz/l9avjLmbmV8CwcvXgh+AwwGswyf3Tq0mKgFgR0XJLE/1Isbu
 l6izV/MtEHfyw8pwfI4cKfsWZts+3cL2D7lwjG7FK3kadzYxG5c9TS+KWfZY51UrEIo=
X-Gm-Gg: AY/fxX6aDWMM7wtrAvfJnJX9F9y4+LG+z3cGo5RM3TZATLC3kSWO0EbwO/ixpwYXKeJ
 SbftIEyY3NBSAmURFIq7Y3OmvxvoFNOriZEIZ2+lTYGlB2GQivLPawulFLBdqSkXla8XJVPAYDi
 kHFMZGacON2Yg4fJ15CIwsiUVWeuOTGiMwdy3IPsCP+dDCAGaeZwmIxi4949WxELgl9U79u+ouv
 vetKAFXgw/avPAtaytktW8uMl/Qh1HEvQhu4BapjDJdAE8f3YwTGNMaDJuMZoucw9WA5FwbSvku
 xjEmVLIc6ZUqitTphdNn6Js9P+CPA9InalKTOteO1fBmYkMkX7VeGOv0xzzH2jFAUHsWVPwVmkN
 Xw7tJNlgP3KTUU8hk2lKpt4mU9yXldTXIR4nb5V3Ciffu1WVrpKWFgFAKX9n08Qiy7EXb09q6V8
 /WTgEnX4RIKFKx/7vBeSq1uIM=
X-Google-Smtp-Source: AGHT+IG67/d5d3vQzDTqzeqPPqMDH7InSdblWObKymxB/jeuDWuQgj73+XwI9G6353wE7Yu7j2A64Q==
X-Received: by 2002:a05:620a:454f:b0:8a3:cd9e:e3fd with SMTP id
 af79cd13be357-8c37eb61b9emr80961385a.9.1767640011877; 
 Mon, 05 Jan 2026 11:06:51 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c37f4b9c9esm12426485a.18.2026.01.05.11.06.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 11:06:50 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: probb@iol.unh.edu, dmarx@iol.unh.edu, dev@dpdk.org,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [RFC PATCH 2/3] dts: add cryptodev package to dts
Date: Mon,  5 Jan 2026 14:06:46 -0500
Message-ID: <20260105190647.63244-2-abailey@iol.unh.edu>
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

Running the DPDK test crypto performance application is essential for
testing cryptodev performance in DTS. This application takes numerous
arguments and can be run in four modes; Throughput, Latency,
PMD-cyclecount, and Verify. The package to add in this commit allows for
this application to be run in any of these modes with user supplied
arguments.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/api/capabilities.py       |  48 ++++
 dts/api/cryptodev/__init__.py | 225 ++++++++++++++++
 dts/api/cryptodev/config.py   | 484 ++++++++++++++++++++++++++++++++++
 dts/api/cryptodev/types.py    | 136 ++++++++++
 dts/framework/params/types.py |  65 +++++
 5 files changed, 958 insertions(+)
 create mode 100644 dts/api/cryptodev/__init__.py
 create mode 100644 dts/api/cryptodev/config.py
 create mode 100644 dts/api/cryptodev/types.py

diff --git a/dts/api/capabilities.py b/dts/api/capabilities.py
index 243759668f..ebdd9350e1 100644
--- a/dts/api/capabilities.py
+++ b/dts/api/capabilities.py
@@ -66,6 +66,36 @@ def default(cls) -> "LinkTopology":
         return cls.TWO_LINKS
 
 
+class CryptoCapability(IntEnum):
+    """DPDK Crypto capabilities.
+
+    The capabilities are used to mark test cases or suites that require a specific
+    DPDK Crypto capability to run. The capabilities are used by the test framework to
+    determine whether a test case or suite can be run on the current testbed.
+    """
+
+    AESNI_GCM = 0
+    AESNI_MB = auto()
+    ARMV8 = auto()
+    CN10K = auto()
+    CN9K = auto()
+    DPAA_SEC = auto()
+    DPAA2_SEC = auto()
+    KASUMI = auto()
+    MVSAM = auto()
+    NULL = auto()
+    OCTEONTX = auto()
+    OPENSSL = auto()
+    QAT = auto()
+    SCHEDULER = auto()
+    SNOW3G = auto()
+    ZUC = auto()
+
+    def __str__(self) -> str:
+        """Override the default string representation to return the name of the capability."""
+        return self.name
+
+
 class NicCapability(IntEnum):
     """DPDK NIC capabilities.
 
@@ -264,3 +294,21 @@ def add_required_capability(
         return test_case_or_suite
 
     return add_required_capability
+
+
+def requires_crypto_capability(
+    crypto_capability: CryptoCapability,
+) -> Callable[[type["TestProtocol"]], type["TestProtocol"]]:
+    """Decorator to add a single required Crypto capability to a test case or test suite.
+
+    Args:
+        crypto_capability: The Crypto capability that is required by the test case or test suite.
+    """
+
+    def add_required_capability(
+        test_case_or_suite: type["TestProtocol"],
+    ) -> type["TestProtocol"]:
+        # perhaps we need to make a decorated version like nic capability
+        return test_case_or_suite
+
+    return add_required_capability
diff --git a/dts/api/cryptodev/__init__.py b/dts/api/cryptodev/__init__.py
new file mode 100644
index 0000000000..644a746193
--- /dev/null
+++ b/dts/api/cryptodev/__init__.py
@@ -0,0 +1,225 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 University of New Hampshire
+
+"""Cryptodev-pmd non-interactive shell.
+
+Typical usage example in a TestSuite::
+
+    cryptodev = CryptodevPmd(CryptoPmdParams)
+    stats = cryptodev.run_app()
+    cryptodev.print_stats(stats)
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
+from framework.config.node import PortConfig
+from framework.context import get_ctx
+from framework.exception import RemoteCommandExecutionError, SkippedTestException
+from framework.testbed_model.cpu import LogicalCoreList
+from framework.testbed_model.port import Port
+
+if TYPE_CHECKING:
+    from framework.params.types import CryptoPmdParamsDict
+from pathlib import PurePath
+
+from framework.remote_session.dpdk import DPDKBuildEnvironment
+
+
+class Cryptodev:
+    """non-interactive cryptodev application.
+
+    Attributes:
+        _dpdk: The dpdk runtime to run the cryptodev app on.
+        _app_params: A combination of application and EAL parameters.
+    """
+
+    _dpdk: DPDKBuildEnvironment
+    _app_params: dict[str, Any]
+
+    def __init__(self, **app_params: Unpack["CryptoPmdParamsDict"]) -> None:
+        """Initialize the cryptodev application.
+
+        Args:
+            app_params: The application parameters as keyword arguments.
+        """
+        self._app_params = {}
+        for k, v in app_params.items():
+            if v is not None:
+                self._app_params[k] = (
+                    self.vector_directory.joinpath(str(v)) if k == "test_file" else v
+                )
+        self._dpdk = get_ctx().dpdk_build
+        self._path = self._dpdk.get_app("test-crypto-perf")
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
+        return self._dpdk.remote_dpdk_tree_path.joinpath("app/test-crypto-perf/data/")
+
+    @staticmethod
+    def _print_latency_stats(
+        ptest: type[CryptodevResults], results: LatencyResults, print_title: bool
+    ) -> None:
+        """Print the stats table after a latency test has been run.
+
+        Args:
+            ptest: The type of performance test being run.
+            results: The latency results to print.
+            print_title: Whether to print the title of the table.
+        """
+        table_header = ["", "min", "max", "avg", "total"]
+        element_len = max(len(metric) for metric, _ in results) + 3
+        border_len = (element_len + 1) * (len(table_header))
+
+        if print_title:
+            print(f"{f'{ptest.__name__}'.center(border_len)}")
+            print("=" * border_len)
+        print_header = True
+        for metric, data in results:
+            # Print presets
+            if metric in ("buffer_size", "burst_size"):
+                print(f"{metric}: {data}")
+                continue
+            elif "min" in metric:
+                if print_header:
+                    print("=" * border_len)
+                    for stat in table_header:
+                        print(f"|{stat:^{element_len}}", end="")
+                    print(f"|\n{'=' * border_len}|", end="")
+                    print_header = False
+                # Fill table with data
+                print(f"\n|{metric.replace('min_', '', 1):<{element_len}}|", end="")
+            print(f"{data:<{element_len}}|", end="")
+        print(f"\n{'=' * border_len}")
+
+    @staticmethod
+    def _print_stats_helper(
+        ptest: type[CryptodevResults],
+        results: CryptodevResults,
+        border_len: int,
+        print_header: bool,
+    ) -> None:
+        """Print the stats table after a throughput, verify, or pmd_cyclecount test.
+
+        Args:
+            ptest: The type of performance test being run.
+            results: The results to print.
+            border_len: The width of the table in characters.
+            print_header: Whether to print the title of the table.
+        """
+        if isinstance(results, LatencyResults):
+            return Cryptodev._print_latency_stats(ptest, results, print_header)
+        if print_header:
+            print(f"{f'{ptest.__name__}'.center(border_len)}")
+            print("=" * border_len)
+            for metric, data in results:
+                print(f"|{metric:<{len(metric) + 3}}", end="")
+            print(f"|\n{'=' * border_len}")
+        for metric, data in results:
+            print(f"|{data:<{len(metric) + 3}}", end="")
+        print(f"|\n{'=' * border_len}")
+
+    @staticmethod
+    def print_stats(results: list[CryptodevResults]) -> None:
+        """Print the statistics of the most recent run of the cryptodev application.
+
+        Raises:
+            ValueError: If stats are printed before the application has been run.
+        """
+        print_header = True
+        if len(results) == 0:
+            raise ValueError("No results to print.")
+        border_len = sum(len(key) + 4 for key in vars(results[0]))
+        for result in results:
+            Cryptodev._print_stats_helper(type(result), result, border_len, print_header)
+            print_header = False
+
+    def run_app(self) -> list[CryptodevResults]:
+        """Run the cryptodev application with the current parameters.
+
+        Raises:
+            SkippedTestException: If the device type is not supported on the main session.
+            RemoteCommandExecutionError: If there is an error running the command.
+            ValueError: If an invalid performance test type is specified.
+
+        Returns:
+            list[CryptodevResults]: The list of parsed results for the cryptodev application.
+        """
+        crypto_ports = [
+            Port(
+                self._dpdk._node,
+                PortConfig(
+                    name="crypto_port0", pci="0000:03:01.0", os_driver="", os_driver_for_dpdk=""
+                ),
+            )
+        ]
+        send_command = f"{self.path} --socket-mem 2048,0 {
+            CryptoPmdParams(
+                lcore_list=LogicalCoreList([9,10]),
+                allowed_ports= crypto_ports,
+                memory_channels=6,
+                **self._app_params,
+            )
+        }"
+
+        try:
+            # run cryptodev app on the sut node
+            result = self._dpdk._node.main_session.send_command(
+                send_command, privileged=True, timeout=120
+            )
+        except RemoteCommandExecutionError as e:
+            # skip test when device or algorithm is not supported
+            if "No crypto devices type" in e._command_stderr:
+                print(
+                    f"Skipping test: {self._app_params['devtype']}\
+                        type not supported on this session."
+                )
+                raise SkippedTestException(
+                    f"Could not run cryptodev application with devtype\
+                        {self._app_params['devtype']}"
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
+            case _:
+                raise ValueError(f"Ptest {self._app_params['ptest']} is not a valid option")
+
+        return [parser.parse(line) for line in re.findall(regex, result.stdout, parser_options)]
diff --git a/dts/api/cryptodev/config.py b/dts/api/cryptodev/config.py
new file mode 100644
index 0000000000..8b1a293018
--- /dev/null
+++ b/dts/api/cryptodev/config.py
@@ -0,0 +1,484 @@
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
+    def __init__(self, value: list[int]) -> None:
+        """Initialize the list wrapper."""
+        self.value = value
+
+    def __str__(self) -> str:
+        """Convert the list to a comma-separated string."""
+        return ",".join(str(v) for v in self.value)
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
index 0000000000..dfc8bc7796
--- /dev/null
+++ b/dts/api/cryptodev/types.py
@@ -0,0 +1,136 @@
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
+    """A happy class docstring."""
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
+    """A happy class docstring."""
+
+    lcore_id: int = field(metadata=TextParser.find_int(r"\s*(\d+)"))
+    buffer_size: int = field(
+        metadata=TextParser.find_int(r"\s+(?:\d+\s+)(\d+)"),
+    )
+    burst_size: int = field(
+        metadata=TextParser.find_int(r"\s+(?:\d+\s+){2}(\d+)"),
+    )
+    enqueued: int = field(metadata=TextParser.find_int(r"\s+(?:\d+\s+){3}(\d+)"))
+    dequeued: int = field(metadata=TextParser.find_int(r"\s+(?:\d+\s+){4}(\d+)"))
+    failed_enqueue: int = field(metadata=TextParser.find_int(r"\s+(?:\d+\s+){5}(\d+)"))
+    failed_dequeue: int = field(metadata=TextParser.find_int(r"\s+(?:\d+\s+){6}(\d+)"))
+    mops: float = field(metadata=TextParser.find_float(r"\s+(?:\d+\s+){7}([\d.]+)"))
+    gbps: float = field(metadata=TextParser.find_float(r"\s+(?:\d+\s+){7}(?:[\d.]+\s+)([\d.]+)"))
+    cycles_per_buffer: float = field(
+        metadata=TextParser.find_float(r"\s+(?:\d+\s+){7}(?:[\d.]+\s+){2}([\d.]+)")
+    )
+
+
+@dataclass
+class LatencyResults(CryptodevResults):
+    """A parser for latency test output."""
+
+    buffer_size: int = field(
+        metadata=TextParser.find_int(r"Buf(?:.*\n\s+\d+\s+)?(?:fer size:\s+)?(\d+)"),
+    )
+    burst_size: int = field(
+        metadata=TextParser.find_int(rf"Burst(?:.*\n\s+\d+\s+){2}?(?: size:\s+)?(\d+)"),
+    )
+
+    # total_ops: int = field(metadata=TextParser.find_int(r"total operations:\s+(\d+)"))
+    # num_of_bursts: int = field(metadata=TextParser.find_int(r"Number of bursts:\s+(\d+)"))
+    min_enqueued: int = field(metadata=TextParser.find_int(r"enqueued\s+(?:\d+\s+){2}(\d+)"))
+    max_enqueued: int = field(metadata=TextParser.find_int(r"enqueued\s+(?:\d+\s+){3}(\d+)"))
+    avg_enqueued: int = field(metadata=TextParser.find_int(r"enqueued\s+(?:\d+\s+)(\d+)"))
+    total_enqueued: int = field(metadata=TextParser.find_int(r"enqueued\s+(\d+)"))
+    min_dequeued: int = field(metadata=TextParser.find_int(r"dequeued\s+(?:\d+\s+){2}(\d+)"))
+    max_dequeued: int = field(metadata=TextParser.find_int(r"dequeued\s+(?:\d+\s+){3}(\d+)"))
+    avg_dequeued: int = field(metadata=TextParser.find_int(r"dequeued\s+(?:\d+\s+)(\d+)"))
+    total_dequeued: int = field(metadata=TextParser.find_int(r"dequeued\s+(\d+)"))
+    min_cycles: float = field(metadata=TextParser.find_float(r"cycles\s+(?:[\d.]+\s+){3}([\d.]+)"))
+    max_cycles: float = field(metadata=TextParser.find_float(r"cycles\s+(?:[\d.]+\s+){2}([\d.]+)"))
+    avg_cycles: float = field(metadata=TextParser.find_float(r"cycles\s+(?:[\d.]+\s+)([\d.]+)"))
+    total_cycles: float = field(metadata=TextParser.find_float(r"cycles\s+([\d.]+)"))
+    min_time_us: float = field(
+        metadata=TextParser.find_float(r"time \[us\]\s+(?:[\d.]+\s+){3}([\d.]+)")
+    )
+    max_time_us: float = field(
+        metadata=TextParser.find_float(r"time \[us\]\s+(?:[\d.]+\s+){2}([\d.]+)")
+    )
+    avg_time_us: float = field(
+        metadata=TextParser.find_float(r"time \[us\]\s+(?:[\d.]+\s+)([\d.]+)")
+    )
+    total_time_us: float = field(metadata=TextParser.find_float(r"time \[us\]\s+([\d.]+)"))
+
+
+@dataclass
+class PmdCyclecountResults(CryptodevResults):
+    """A parser for PMD cycle count test output."""
+
+    lcore_id: int = field(metadata=TextParser.find_int(r"lcore\s+(?:id.*\n\s+)?(\d+)"))
+    buffer_size: int = field(
+        metadata=TextParser.find_int(r"Buf(?:.*\n\s+(?:\d+\s+))?(?:fer size:\s+)?(\d+)"),
+    )
+    burst_size: int = field(
+        metadata=TextParser.find_int(r"Burst(?:.*\n\s+(?:\d+\s+){2})?(?: size:\s+)?(\d+)"),
+    )
+    enqueued: int = field(metadata=TextParser.find_int(r"Enqueued.*\n\s+(?:\d+\s+){3}(\d+)"))
+    dequeued: int = field(metadata=TextParser.find_int(r"Dequeued.*\n\s+(?:\d+\s+){4}(\d+)"))
+    enqueue_retries: int = field(
+        metadata=TextParser.find_int(r"Enq Retries.*\n\s+(?:\d+\s+){5}(\d+)")
+    )
+    dequeue_retries: int = field(
+        metadata=TextParser.find_int(r"Deq Retries.*\n\s+(?:\d+\s+){6}(\d+)")
+    )
+    cycles_per_operation: float = field(
+        metadata=TextParser.find_float(r"Cycles/Op.*\n\s+(?:\d+\s+){7}([\d.]+)")
+    )
+    cycles_per_enqueue: float = field(
+        metadata=TextParser.find_float(r"Cycles/Enq.*\n\s+(?:\d+\s+){7}(?:[\d.]+\s+)([\d.]+)")
+    )
+    cycles_per_dequeue: float = field(
+        metadata=TextParser.find_float(r"Cycles/Deq.*\n\s+(?:\d+\s+){7}(?:[\d.]+\s+){2}([\d.]+)"),
+    )
+
+
+@dataclass
+class VerifyResults(CryptodevResults):
+    """A parser for verify test output."""
+
+    lcore_id: int = field(metadata=TextParser.find_int(r"lcore\s+(?:id.*\n\s+)?(\d+)"))
+    buffer_size: int = field(
+        metadata=TextParser.find_int(r"Buf(?:.*\n\s+(?:\d+\s+))?(?:fer size:\s+)?(\d+)"),
+    )
+    burst_size: int = field(
+        metadata=TextParser.find_int(r"Burst(?:.*\n\s+(?:\d+\s+){2})?(?: size:\s+)?(\d+)"),
+    )
+    enqueued: int = field(metadata=TextParser.find_int(r"Enqueued.*\n\s+(?:\d+\s+){3}(\d+)"))
+    dequeued: int = field(metadata=TextParser.find_int(r"Dequeued.*\n\s+(?:\d+\s+){4}(\d+)"))
+    failed_enqueued: int = field(
+        metadata=TextParser.find_int(r"Failed Enq.*\n\s+(?:\d+\s+){5}(\d+)")
+    )
+    failed_dequeued: int = field(
+        metadata=TextParser.find_int(r"Failed Deq.*\n\s+(?:\d+\s+){6}(\d+)")
+    )
+    failed_ops: int = field(metadata=TextParser.find_int(r"Failed Ops.*\n\s+(?:\d+\s+){7}(\d+)"))
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
 
-- 
2.50.1

