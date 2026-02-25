Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF800FD45F1
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 21:09:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D144B402DF;
	Wed, 25 Feb 2026 22:09:07 +0100 (CET)
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by mails.dpdk.org (Postfix) with ESMTP id 9D29F402BB
 for <dev@dpdk.org>; Wed, 25 Feb 2026 22:09:06 +0100 (CET)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-1275910b930so87035c88.0
 for <dev@dpdk.org>; Wed, 25 Feb 2026 13:09:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772053746; cv=none;
 d=google.com; s=arc-20240605;
 b=L+e/D0FChQ9OwezhRBOft7NRHaffPbJPn04XX1bxv9XC2+9DLrwfqmClP1agq2n2fq
 u+6y0IgZowfGfRgaEOfdGeqjbuhfRGKl9fGdnqK8qNO5Kii8FJQ4qEvv7f4ownOvt5i+
 Qv1zoCppBo8eu7+ohdUfDcrK8SnAVVoPoDOyYnSyoyHdtisp5WkRlNngJ5jlAI5EkmyQ
 podpXuPM7ROqTwMfelZ+Q4dWOd7onMEx/YmnTBtywUaNXey5L/5qIoq3VMU/8I7o/3T6
 aIo3g1l8vMp7nddpAP7tuwjNZgnXNTidbvGc1b4y1Bn1t98JDn/z8e2SC31I27l7VykX
 qBEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2JiZbK7zG+QI9RonzWDbs5GabqkG+81htOxaibTvvV0=;
 fh=4dFPO+AHSw1osxvGgZG5UtFWMOKqELH77F1CwBXEARg=;
 b=YHc8zTg1BWUMhorGEE6+DRYoRValc7VzFoQ6VJKJIL9IuAuDCHXAN7dSmsJ5kA4lkF
 0n5RYpAQ2UJHFqCEx1ZVP8Amb8MOmwuh8jxsJPFsoxo+FwFJuHdjP2pQF8jx9XQ/+svi
 32IPZJczwnV4Tij+YEQ8QJP5EMZLpm+bFfk45CgUQHmY3pbMgE7Q1Yau/hqRwJFeLXwV
 jOC/uPo71JVBydNmrj5Mg1gdOL4SP5CaffNLj6rM2TQmrDbA5KvActpamjfr+7NkTGg8
 7lKrITH20qZALnJBe2nHV1uilQPmACiu/eZYpnaw3rNhA2s/jPmoLjL+6mzfKdkOLuSc
 56Tg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1772053746; x=1772658546; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2JiZbK7zG+QI9RonzWDbs5GabqkG+81htOxaibTvvV0=;
 b=h9xr3wE3CJVGCLLl+9U60cwZE48ijH4AVrW4UgAsgFZE89JdUrE7jPxTjIAPKqa9hT
 660k5ge4PO/S8yGq6berkkc+hhjlves2pQ0N3/1KQAwEac/RuG5s8a7cCkLCfbTurBNO
 S1BtjxZGFdmFvNfrZI31T21Zv/KSWS1ZWgHcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772053746; x=1772658546;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2JiZbK7zG+QI9RonzWDbs5GabqkG+81htOxaibTvvV0=;
 b=ENZGflyHFOMUbHRtMXoUBjfk81YFk/Qq31xY7sLo4qazL5w4ofDfkQMPQbzA/4pGDZ
 bLwzEHSkettEr/ZH9X+T6gIEnJ/lzlDVKPyjdksg/GJvH8cbobr0ASzR+dXTTnjO8vtL
 Rc07uGg6Crg8xZ1TDK8CjnxgpV9KoLvPqfrRU/0wyk8S7wquoNCemL5whkoKvsueT4v0
 5A2AfobbmrTs2LZoGy8BuvUh8wzY5auR0pb//hiTPmkGTwT7Gl4sHg6QdXgF/lFfm+7N
 p7WMa/J8OzYmaDlQjCcPiozlco+Mv3FYoxeiRQx5WFK9GFKpg68+TWqN+SG8+PkBaXBi
 N9UA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUvXP5hG/5qkquLkhhbTGU3P8NFSVm+8q+nswtyIBWedugipdT4Ufh0LvlqDJZi7U+8nI=@dpdk.org
X-Gm-Message-State: AOJu0YwTFDOz+rwJFpES4lJktNP2WNQc9rvlL9P3x8mk1NHhDGEEuhcJ
 KytmbQFWhRkas1dxMrK/BnohgI3umN6b9LlfqDOvqU6KyEmGXI2zAqp3nfJh/n3Exx+x9UCsuIr
 boTv6r9zEpfuOHf2h4eGFyKXqTrkee5+292hEnUmXhQ==
X-Gm-Gg: ATEYQzyvuXYv3rojZG33m8Btz+uyzNOaUq8x9hgSWZ5xzolU4GE2dyfSO5rbBqMct3x
 ShBjm1uxuSfeT6RUadoJjzcrc0JFgGF4SDf4zJkmcuVSYCv0p/b2K01QiC6q4E/N/RigPBsvFEc
 m3DxdIp4/SeQA0s4Ycg61swIv2FJ5sZv5mtrIacsGa/NK+41afCreB3kg5+lRVXP7OULTJlX4/e
 BjKvQQ8PIduMUuAJ18mCtFXp6QgSlq9lpIKKVW0pknhPuiXdyP/hHYJjBK9Ni8Y1HZP04mi7vFv
 CpGn5SCsW8JHs5UMeVZ/SRs9zaCbmyqVrMrOJw==
X-Received: by 2002:a05:7022:f9e:b0:123:35cb:96d2 with SMTP id
 a92af1059eb24-127890efbf7mr244068c88.21.1772053745096; Wed, 25 Feb 2026
 13:09:05 -0800 (PST)
MIME-Version: 1.0
References: <20260210193448.69423-1-abailey@iol.unh.edu>
 <20260213193539.103858-1-abailey@iol.unh.edu>
 <20260213193539.103858-3-abailey@iol.unh.edu>
In-Reply-To: <20260213193539.103858-3-abailey@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 25 Feb 2026 16:06:15 -0500
X-Gm-Features: AaiRm51GpFddXisf76mRAtqmCyJuCRrQbcTvJH2a9eoKRsr8otnAdTjit7Cbvzg
Message-ID: <CAJvnSUCDkbiiYGEM_PGWppQdbJNZC0ZSVPqdaTR2=2XP-oF23A@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] dts: add cryptodev package to DTS
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dmarx@iol.unh.edu, dev@dpdk.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Feb 13, 2026 at 2:36=E2=80=AFPM Andrew Bailey <abailey@iol.unh.edu>=
 wrote:
>
> Running the DPDK test crypto performance application is essential for
> testing cryptodev performance in DTS. This application takes numerous
> arguments and can be run in four modes; Throughput, Latency,
> PMD-cyclecount, and Verify. The package to add in this commit allows for
> this application to be run in any of these modes with user supplied
> arguments.
>
> Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
> ---
>  dts/api/cryptodev/__init__.py                | 134 +++++
>  dts/api/cryptodev/config.py                  | 499 +++++++++++++++++++
>  dts/api/cryptodev/types.py                   | 185 +++++++
>  dts/configurations/nodes.example.yaml        |   6 +
>  dts/framework/config/node.py                 |   4 +
>  dts/framework/params/types.py                |  65 +++
>  dts/framework/remote_session/dpdk_shell.py   |   5 +-
>  dts/framework/test_run.py                    |   5 +
>  dts/framework/testbed_model/linux_session.py |  54 ++
>  dts/framework/testbed_model/node.py          |  10 +
>  dts/framework/testbed_model/os_session.py    |  30 ++
>  dts/framework/testbed_model/topology.py      |  89 +++-
>  12 files changed, 1083 insertions(+), 3 deletions(-)
>  create mode 100644 dts/api/cryptodev/__init__.py
>  create mode 100644 dts/api/cryptodev/config.py
>  create mode 100644 dts/api/cryptodev/types.py
>
> diff --git a/dts/api/cryptodev/__init__.py b/dts/api/cryptodev/__init__.p=
y
> new file mode 100644
> index 0000000000..9955657398
> --- /dev/null
> +++ b/dts/api/cryptodev/__init__.py
> @@ -0,0 +1,134 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2025 University of New Hampshire
> +
> +"""Cryptodev-pmd non-interactive shell.
> +
> +Typical usage example in a TestSuite::
> +
> +    cryptodev =3D CryptodevPmd(CryptoPmdParams)
> +    stats =3D cryptodev.run_app()
> +"""
> +
> +import re
> +from typing import TYPE_CHECKING, Any
> +
> +from typing_extensions import Unpack
> +
> +from api.cryptodev.config import CryptoPmdParams, TestType
> +from api.cryptodev.types import (
> +    CryptodevResults,
> +    LatencyResults,
> +    PmdCyclecountResults,
> +    ThroughputResults,
> +    VerifyResults,
> +)
> +from framework.context import get_ctx
> +from framework.exception import RemoteCommandExecutionError, SkippedTest=
Exception
> +from framework.remote_session.dpdk_shell import compute_eal_params
> +
> +if TYPE_CHECKING:
> +    from framework.params.types import CryptoPmdParamsDict
> +from pathlib import PurePath
> +
> +
> +class Cryptodev:
> +    """non-interactive cryptodev application.
> +
> +    Attributes:
> +        _app_params: app parameters to pass to dpdk-test-crypto-perf app=
lication
> +    """
> +
> +    _app_params: dict[str, Any]
> +
> +    def __init__(self, **app_params: Unpack["CryptoPmdParamsDict"]) -> N=
one:
> +        """Initialize the cryptodev application.
> +
> +        Args:
> +            app_params: The application parameters as keyword arguments.
> +
> +        Raises:
> +            ValueError: if the build environment is `None`
> +        """
> +        self._app_params =3D {}
> +        for k, v in app_params.items():
> +            if v is not None:
> +                self._app_params[k] =3D (
> +                    self.vector_directory.joinpath(str(v)) if k =3D=3D "=
test_file" else v
> +                )
> +        dpdk =3D get_ctx().dpdk.build
> +        if dpdk is None:
> +            raise ValueError("No DPDK build environment exists.")
> +        self._path =3D dpdk.get_app("test-crypto-perf")
> +
> +    @property
> +    def path(self) -> PurePath:
> +        """Get the path to the cryptodev application.
> +
> +        Returns:
> +            The path to the cryptodev application.
> +        """
> +        return PurePath(self._path)
> +
> +    @property
> +    def vector_directory(self) -> PurePath:
> +        """Get the path to the cryptodev vector files.
> +
> +        Returns:
> +            The path to the cryptodev vector files.
> +        """
> +        return get_ctx().dpdk_build.remote_dpdk_tree_path.joinpath("app/=
test-crypto-perf/data/")
> +
> +    def run_app(self, numvfs: int | None =3D 0) -> list[CryptodevResults=
]:
> +        """Run the cryptodev application with the given app parameters.
> +
> +        Raises:
> +            SkippedTestException: If the device type is not supported on=
 the main session.
> +            RemoteCommandExecutionError: If there is an error running th=
e command.
> +
> +        Returns:
> +            list[CryptodevResults]: The list of parsed results for the c=
ryptodev application.

Missing the args docstring. Speaking of which, What is the theory
behind passing a vf count from the testsuites to the app? In terms of
what the testsuites require, and whether that aspect should be
configurable from the user side, why the default is zero, etc.

> +        """
> +        try:
> +            result =3D get_ctx().dpdk.run_dpdk_app(
> +                self.path,
> +                compute_eal_params(
> +                    CryptoPmdParams(
> +                        allowed_ports=3Dget_ctx().topology.get_crypto_vf=
s(numvfs),
> +                        memory_channels=3Dget_ctx().dpdk.config.memory_c=
hannels,
> +                        **self._app_params,
> +                    ),
> +                ),
> +                timeout=3D120,
> +            )
> +        except RemoteCommandExecutionError as e:
> +            if "Crypto device type does not support capabilities request=
ed" in e._command_stderr:
> +                raise SkippedTestException(
> +                    f"{self._app_params['devtype']} does not support the=
 requested capabilities"
> +                )
> +            elif "Failed to initialise requested crypto device type" in =
e._command_stderr:
> +                raise SkippedTestException(
> +                    f"could not run application with devtype {self._app_=
params['devtype']}"
> +                )
> +            elif "failed to parse device" in e._command_stderr:
> +                raise SkippedTestException(
> +                    f"dependencies missing for virtual device {self._app=
_params['vdevs'][0].name}"
> +                )
> +            raise e
> +
> +        regex =3D r"^\s+\d+.*$"
> +        parser_options =3D re.MULTILINE
> +        parser: type[CryptodevResults]
> +
> +        match self._app_params["ptest"]:
> +            case TestType.throughput:
> +                parser =3D ThroughputResults
> +            case TestType.latency:
> +                regex =3D r"total operations:.*time[^\n]*"
> +                parser_options |=3D re.DOTALL
> +                parser =3D LatencyResults
> +            case TestType.pmd_cyclecount:
> +                parser =3D PmdCyclecountResults
> +            case TestType.verify:
> +                parser =3D VerifyResults
> +
> +        return [parser.parse(line) for line in re.findall(regex, result.=
stdout, parser_options)]
> diff --git a/dts/api/cryptodev/config.py b/dts/api/cryptodev/config.py
> new file mode 100644
> index 0000000000..c6ec083a43
> --- /dev/null
> +++ b/dts/api/cryptodev/config.py
> @@ -0,0 +1,499 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2025 University of New Hampshire
> +"""Module containing types and parameter classes for cryptodev-pmd appli=
cation."""
> +
> +from dataclasses import dataclass, field
> +from enum import auto
> +from typing import Literal
> +
> +from framework.params import Params, Switch
> +from framework.params.eal import EalParams
> +from framework.utils import StrEnum
> +
> +Silent =3D Literal[""]
> +
> +
> +class DeviceType(StrEnum):
> +    """Enum for cryptodev device types.
> +
> +    Attributes:
> +        crypto_aesni_gcm: AES-NI GCM device type.
> +        crypto_aesni_mb: AES-NI MB device type.
> +        crypto_armv8: ARMv8 device type.
> +        crypto_cn10k: CN10K device type.
> +        crypto_cn9k: CN9K device type.
> +        crypto_dpaa_sec: DPAA SEC device type.
> +        crypto_dpaa2_sec: DPAA2 SEC device type.
> +        crypto_kasumi: KASUMI device type.
> +        crypto_mvsam: MVSAM device type.
> +        crypto_null: NULL device type.
> +        crypto_octeontx: OCTEONTX device type.
> +        crypto_openssl: OpenSSL device type.
> +        crypto_qat: QAT device type.
> +        crypto_scheduler: Scheduler device type.
> +        crypto_snow3g: SNOW3G device type.
> +        crypto_zuc: ZUC device type.
> +    """
> +
> +    crypto_aesni_gcm =3D auto()
> +    crypto_aesni_mb =3D auto()
> +    crypto_armv8 =3D auto()
> +    crypto_cn10k =3D auto()
> +    crypto_cn9k =3D auto()
> +    crypto_dpaa_sec =3D auto()
> +    crypto_dpaa2_sec =3D auto()
> +    crypto_kasumi =3D auto()
> +    crypto_mvsam =3D auto()
> +    crypto_null =3D auto()
> +    crypto_octeontx =3D auto()
> +    crypto_openssl =3D auto()
> +    crypto_qat =3D auto()
> +    crypto_scheduler =3D auto()
> +    crypto_snow3g =3D auto()
> +    crypto_zuc =3D auto()
> +
> +
> +def get_device_from_str(device: str) -> DeviceType | None:
> +    """Get a device type from the given string.
> +
> +    Args:
> +        device: the string representation of the desired device.
> +
> +    Returns:
> +        the device as a DeviceType object.
> +    """
> +    for item in DeviceType:
> +        if device in item.value:
> +            return item
> +    return None
> +
> +
> +class OperationType(StrEnum):
> +    """Enum for cryptodev operation types.
> +
> +    Attributes:
> +        aead: AEAD operation type.
> +        auth_only: Authentication only operation type.
> +        auth_then_cipher: Authentication then cipher operation type.
> +        cipher_only: Cipher only operation type.
> +        cipher_then_auth: Cipher then authentication operation type.
> +        docsis: DOCSIS operation type.
> +        ecdsa_p192r1 =3D ECDSA P-192R1 operation type.
> +        ecdsa_p224r1 =3D ECDSA P-224R1 operation type.
> +        ecdsa_p256r1: ECDSA P-256R1 operation type.
> +        ecdsa_p384r1 =3D ECDSA P-384R1 operation type.
> +        ecdsa_p521r1 =3D ECDSA P-521R1 operation type.
> +        eddsa_25519: EdDSA 25519 operation type.
> +        modex: Modex operation type.
> +        ipsec: IPsec operation type.
> +        pdcp: PDCP operation type.
> +        rsa: RSA operation type.
> +        sm2: SM2 operation type.
> +        tls_record: TLS record operation type.
> +    """
> +
> +    aead =3D auto()
> +    auth_only =3D "auth-only"
> +    auth_then_cipher =3D "auth-then-cipher"
> +    cipher_only =3D "cipher-only"
> +    cipher_then_auth =3D "cipher-then-auth"
> +    docsis =3D auto()
> +    ecdsa_p192r1 =3D auto()
> +    ecdsa_p224r1 =3D auto()
> +    ecdsa_p256r1 =3D auto()
> +    ecdsa_p384r1 =3D auto()
> +    ecdsa_p521r1 =3D auto()
> +    eddsa_25519 =3D auto()
> +    modex =3D auto()
> +    ipsec =3D auto()
> +    pdcp =3D auto()
> +    rsa =3D auto()
> +    sm2 =3D auto()
> +    tls_record =3D "tls-record"
> +
> +    def __str__(self) -> str:
> +        """Override str to return the value."""
> +        return self.value
> +
> +
> +class CipherAlgorithm(StrEnum):
> +    """Enum for cryptodev cipher algorithms.
> +
> +    Attributes:
> +        aes_cbc: AES CBC cipher algorithm.
> +        aes_ctr: AES CTR cipher algorithm.
> +        aes_docsisbpi: AES DOCSIS BPI cipher algorithm.
> +        aes_ecb: AES ECB cipher algorithm.
> +        aes_f8: AES F8 cipher algorithm.
> +        aes_xts: AES XTS cipher algorithm.
> +        arc4: ARC4 cipher algorithm.
> +        null: NULL cipher algorithm.
> +        three_des_cbc: 3DES CBC cipher algorithm.
> +        three_des_ctr: 3DES CTR cipher algorithm.
> +        three_des_ecb: 3DES ECB cipher algorithm.
> +        kasumi_f8: KASUMI F8 cipher algorithm.
> +        snow3g_uea2: SNOW3G UEA2 cipher algorithm.
> +        zuc_eea3: ZUC EEA3 cipher algorithm.
> +    """
> +
> +    aes_cbc =3D "aes-cbc"
> +    aes_ctr =3D "aes-ctr"
> +    aes_docsisbpi =3D "aes-docsisbpi"
> +    aes_ecb =3D "aes-ecb"
> +    aes_f8 =3D "aes-f8"
> +    aes_gcm =3D "aes-gcm"
> +    aes_xts =3D "aes-xts"
> +    arc4 =3D auto()
> +    null =3D auto()
> +    three_des_cbc =3D "3des-cbc"
> +    three_des_ctr =3D "3des-ctr"
> +    three_des_ecb =3D "3des-ecb"
> +    kasumi_f8 =3D "kasumi-f8"
> +    snow3g_uea2 =3D "snow3g-uea2"
> +    zuc_eea3 =3D "zuc-eea3"
> +
> +    def __str__(self):
> +        """Override str to return the value."""
> +        return self.value
> +
> +
> +class AuthenticationAlgorithm(StrEnum):
> +    """Enum for cryptodev authentication algorithms.
> +
> +    Attributes:
> +        aes_cbc_mac: AES CBC MAC authentication algorithm.
> +        aes_cmac: AES CMAC authentication algorithm.
> +        aes_gmac: AES GMAC authentication algorithm.
> +        aes_xcbc_mac: AES XCBC MAC authentication algorithm.
> +        kasumi_f9: KASUMI F9 authentication algorithm.
> +        md5: MD5 authentication algorithm.
> +        md5_hmac: MD5 HMAC authentication algorithm.
> +        sha1: SHA1 authentication algorithm.
> +        sha1_hmac: SHA1 HMAC authentication algorithm.
> +        sha2_224: SHA2-224 authentication algorithm.
> +        sha2_224_hmac: SHA2-224 HMAC authentication algorithm.
> +        sha2_256: SHA2-256 authentication algorithm.
> +        sha2_256_hmac: SHA2-256 HMAC authentication algorithm.
> +        sha2_384: SHA2-384 authentication algorithm.
> +        sha2_384_hmac: SHA2-384 HMAC authentication algorithm.
> +        sha2_512: SHA2-512 authentication algorithm.
> +        sha2_512_hmac: SHA2-512 HMAC authentication algorithm.
> +        snow3g_uia2: SNOW3G UIA2 authentication algorithm.
> +        zuc_eia3: ZUC EIA3 authentication algorithm.
> +    """
> +
> +    aes_cbc_mac =3D "aes-cbc-mac"
> +    aes_cmac =3D "aes-cmac"
> +    aes_gmac =3D "aes-gmac"
> +    aes_xcbc_mac =3D "aes-xcbc-mac"
> +    kasumi_f9 =3D "kasumi-f9"
> +    md5 =3D auto()
> +    md5_hmac =3D "md5-hmac"
> +    sha1 =3D auto()
> +    sha1_hmac =3D "sha1-hmac"
> +    sha2_224 =3D "sha2-224"
> +    sha2_224_hmac =3D "sha2-224-hmac"
> +    sha2_256 =3D "sha2-256"
> +    sha2_256_hmac =3D "sha2-256-hmac"
> +    sha2_384 =3D "sha2-384"
> +    sha2_384_hmac =3D "sha2-384-hmac"
> +    sha2_512 =3D "sha2-512"
> +    sha2_512_hmac =3D "sha2-512-hmac"
> +    snow3g_uia2 =3D "snow3g-uia2"
> +    zuc_eia3 =3D "zuc-eia3"
> +
> +    def __str__(self) -> str:
> +        """Override str to return the value."""
> +        return self.value
> +
> +
> +class TestType(StrEnum):
> +    """Enum for cryptodev test types.
> +
> +    Attributes:
> +        latency: Latency test type.
> +        pmd_cyclecount: PMD cyclecount test type.
> +        throughput: Throughput test type.
> +        verify: Verify test type.
> +    """
> +
> +    latency =3D auto()
> +    pmd_cyclecount =3D "pmd-cyclecount"
> +    throughput =3D auto()
> +    verify =3D auto()
> +
> +    def __str__(self) -> str:
> +        """Override str to return the value."""
> +        return self.value
> +
> +
> +class EncryptDecryptSwitch(StrEnum):
> +    """Enum for cryptodev encrypt/decrypt operations.
> +
> +    Attributes:
> +        decrypt: Decrypt operation.
> +        encrypt: Encrypt operation.
> +    """
> +
> +    decrypt =3D auto()
> +    encrypt =3D auto()
> +
> +
> +class AuthenticationOpMode(StrEnum):
> +    """Enum for cryptodev authentication operation modes.
> +
> +    Attributes:
> +        generate: Generate operation mode.
> +        verify: Verify operation mode.
> +    """
> +
> +    generate =3D auto()
> +    verify =3D auto()
> +
> +
> +class AeadAlgName(StrEnum):
> +    """Enum for cryptodev AEAD algorithms.
> +
> +    Attributes:
> +        aes_ccm: AES CCM algorithm.
> +        aes_gcm: AES GCM algorithm.
> +    """
> +
> +    aes_ccm =3D "aes-ccm"
> +    aes_gcm =3D "aes-gcm"
> +
> +    def __str__(self):
> +        """Override str to return the value."""
> +        return self.value
> +
> +
> +class AsymOpMode(StrEnum):
> +    """Enum for cryptodev asymmetric operation modes.
> +
> +    Attributes:
> +        decrypt: Decrypt operation mode.
> +        encrypt: Encrypt operation mode.
> +        sign: Sign operation mode.
> +        verify: Verify operation mode.
> +    """
> +
> +    decrypt =3D auto()
> +    encrypt =3D auto()
> +    sign =3D auto()
> +    verify =3D auto()
> +
> +
> +class PDCPDomain(StrEnum):
> +    """Enum for cryptodev PDCP domains.
> +
> +    Attributes:
> +        control: Control domain.
> +        user: User domain.
> +    """
> +
> +    control =3D auto()
> +    user =3D auto()
> +
> +
> +class RSAPrivKeyType(StrEnum):
> +    """Enum for cryptodev RSA private key types.
> +
> +    Attributes:
> +        exp: Exponent key type.
> +        qt: QT key type.
> +    """
> +
> +    exp =3D auto()
> +    qt =3D auto()
> +
> +
> +class TLSVersion(StrEnum):
> +    """Enum for cryptodev TLS versions.
> +
> +    Attributes:
> +        DTLS1_2: DTLS 1.2 version.
> +        TLS1_2: TLS 1.2 version.
> +        TLS1_3: TLS 1.3 version.
> +    """
> +
> +    DTLS1_2 =3D "DTLS1.2"
> +    TLS1_2 =3D "TLS1.2"
> +    TLS1_3 =3D "TLS1.3"
> +
> +    def __str__(self):
> +        """Override str to return the value."""
> +        return self.value
> +
> +
> +class RSAPrivKeytype(StrEnum):
> +    """Enum for cryptodev RSA private key types.
> +
> +    Attributes:
> +        exp: Exponent key type.
> +        qt: QT key type.
> +    """
> +
> +    exp =3D auto()
> +    qt =3D auto()
> +
> +
> +class BurstSizeRange:
> +    """Class for burst size parameter.
> +
> +    Attributes:
> +        burst_size: The burst size range, this list must be less than 32=
 elements.
> +    """
> +
> +    burst_size: int | list[int]
> +
> +    def __init__(self, min: int, inc: int, max: int) -> None:
> +        """Initialize the burst size range.
> +
> +        Raises:
> +            ValueError: If the burst size range is more than 32 elements=
.
> +        """

Can you include an args section for the docstring on this init
function? The same goes for other init functions in your patchseries.

> +        if (max - min) % inc > 32:
> +            raise ValueError("Burst size range must be less than 32 elem=
ents.")
> +        self.burst_size =3D list(range(min, max + 1, inc))
> +
> +
> +class ListWrapper:
> +    """Class for wrapping a list of integers.
> +
> +    One of the arguments for the cryptodev application is a list of inte=
gers. However, when
> +    passing a list directly, it causes a syntax error in the command lin=
e. This class wraps
> +    a list of integers and converts it to a comma-separated string for a=
 proper command.
> +    """
> +
> +    def __init__(self, value: list[int]) -> None:
> +        """Initialize the list wrapper."""
> +        self.value =3D value
> +
> +    def __str__(self) -> str:
> +        """Convert the list to a comma-separated string."""
> +        return ",".join(str(v) for v in self.value)
> +
> +
> +@dataclass(slots=3DTrue, kw_only=3DTrue)
> +class CryptoPmdParams(EalParams):
> +    """Parameters for cryptodev-pmd application.
> +
> +    Attributes:
> +        aead_aad_sz: set the size of AEAD AAD.
> +        aead_algo: set AEAD algorithm name from class `AeadAlgName`.
> +        aead_iv_sz: set the size of AEAD iv.
> +        aead_key_sz: set the size of AEAD key.
> +        aead_op: set AEAD operation mode from class `EncryptDecryptSwitc=
h`.
> +        asym_op: set asymmetric operation mode from class `AsymOpMode`.
> +        auth_algo: set authentication algorithm name.
> +        auth_aad_sz: set the size of authentication AAD.
> +        auth_iv_sz: set the size of authentication iv.
> +        auth_key_sz: set the size of authentication key.
> +        auth_op: set authentication operation mode from class `Authentic=
ationOpMode`.
> +        buffer_sz: Set the size of a single packet (plaintext or ciphert=
ext in it).
> +            burst_sz: Set the number of packets per burst. This can be s=
et as a single value or
> +            range of values defined by class `BurstSizeRange`. Default i=
s 16.
> +        burst_sz: Set the number of packets per burst. This can be set a=
s a single value or
> +            range of values defined by class `BurstSizeRange`. Default i=
s 16.
> +        cipher_algo: Set cipher algorithm name from class `CipherAlgorit=
hm`.
> +        cipher_iv_sz: set the size of cipher iv.
> +        cipher_key_sz: set the size of cipher key.
> +        cipher_op: set cipher operation mode from class `EncryptDecryptS=
witch`.
> +        csv_friendly: Enable test result output CSV friendly rather than=
 human friendly.
> +        desc_nb: set the number of descriptors for each crypto device.
> +        devtype: Set the device name from class `DeviceType`.
> +        digest_sz: set the size of digest.
> +        docsis_hdr_sz: set DOCSIS header size(n) in bytes.
> +        enable_sdap: enable service data adaptation protocol.
> +        imix: Set the distribution of packet sizes. A list of weights mu=
st be passed, containing the
> +            same number of items than buffer-sz, so each item in this li=
st will be the weight of the
> +            packet size on the same position in the buffer-sz parameter =
(a list has to be passed in
> +            that parameter).
> +        low_prio_qp_mask: set low priority queue pairs set in the hexade=
cimal mask. This is an
> +            optional parameter, if not set all queue pairs will be on th=
e same high priority.
> +        modex_len: set modex length for asymmetric crypto perf test. Sup=
ported lengths are 60,
> +            128, 255, 448.  Default length is 128.
> +        optype: Set operation type from class `OpType`.
> +        out_of_place: Enable out-of-place crypto operations mode.
> +        pdcp_sn_sz:  set PDCP sequebce number size(n) in bits. Valid val=
ues of n are 5/7/12/15/18.
> +        pdcp_domain: Set PDCP domain to specify short_mac/control/user p=
lane from class
> +            `PDCPDomain`.
> +        pdcp_ses_hfn_en: enable fixed session based HFN instead of per p=
acket HFN.
> +        pmd_cyclecount_delay_pmd: Add a delay (in milliseconds) between =
enqueue and dequeue in
> +            pmd-cyclecount benchmarking mode (useful when benchmarking h=
ardware acceleration).
> +        pool_sz: Set the number if mbufs to be allocated in the mbuf poo=
l.
> +        ptest: Set performance throughput test type from class `TestType=
`.
> +        rsa_modlen: Set RSA modulus length (in bits) for asymmetric cryp=
to perf test.
> +            To be used with RSA asymmetric crypto ops.Supported lengths =
are 1024, 2048, 4096, 8192.
> +            Default length is 1024.
> +        rsa_priv_keytype: set RSA private key type from class `RSAPrivKe=
ytype`. To be used with RSA
> +            asymmetric crypto ops.
> +        segment_sz: Set the size of the segment to use, for Scatter Gath=
er List testing. Use list of
> +            values in buffer-sz in descending order if segment-sz is use=
d. By default, it is set to
> +            the size of the maximum buffer size, including the digest si=
ze, so a single segment is
> +            created.
> +        sessionless: Enable session-less crypto operations mode.
> +        shared_session: Enable sharing sessions between all queue pairs =
on a single crypto PMD. This
> +            can be useful for benchmarking this setup, or finding and de=
bugging concurrency errors
> +            that can occur while using sessions on multiple lcores simul=
taneously.
> +        silent: Disable options dump.
> +        test_file: Set test vector file path. See the Test Vector File c=
hapter.
> +        test_name: Set specific test name section in the test vector fil=
e.
> +        tls_version: Set TLS/DTLS protocol version for perf test from cl=
ass `TLSVersion`.
> +            Default is TLS1.2.
> +        total_ops: Set the number of total operations performed.
> +    """
> +
> +    aead_aad_sz: int | None =3D field(default=3DNone, metadata=3DParams.=
long("aead-aad-sz"))
> +    aead_algo: AeadAlgName | None =3D field(default=3DNone, metadata=3DP=
arams.long("aead-algo"))
> +    aead_iv_sz: int | None =3D field(default=3DNone, metadata=3DParams.l=
ong("aead-iv-sz"))
> +    aead_key_sz: int | None =3D field(default=3DNone, metadata=3DParams.=
long("aead-key-sz"))
> +    aead_op: EncryptDecryptSwitch | None =3D field(default=3DNone, metad=
ata=3DParams.long("aead-op"))
> +    asym_op: AsymOpMode | None =3D field(default=3DNone, metadata=3DPara=
ms.long("asym-op"))
> +    auth_algo: AuthenticationAlgorithm | None =3D field(
> +        default=3DNone, metadata=3DParams.long("auth-algo")
> +    )
> +    auth_iv_sz: int | None =3D field(default=3DNone, metadata=3DParams.l=
ong("auth-iv-sz"))
> +    auth_key_sz: int | None =3D field(default=3DNone, metadata=3DParams.=
long("auth-key-sz"))
> +    auth_op: AuthenticationOpMode | None =3D field(default=3DNone, metad=
ata=3DParams.long("auth-op"))
> +    buffer_sz: BurstSizeRange | ListWrapper | int | None =3D field(
> +        default=3DNone, metadata=3DParams.long("buffer-sz")
> +    )
> +    burst_sz: BurstSizeRange | ListWrapper | int | None =3D field(
> +        default=3DNone, metadata=3DParams.long("burst-sz")
> +    )
> +    cipher_algo: CipherAlgorithm | None =3D field(default=3DNone, metada=
ta=3DParams.long("cipher-algo"))
> +    cipher_iv_sz: int | None =3D field(default=3DNone, metadata=3DParams=
.long("cipher-iv-sz"))
> +    cipher_key_sz: int | None =3D field(default=3DNone, metadata=3DParam=
s.long("cipher-key-sz"))
> +    cipher_op: EncryptDecryptSwitch | None =3D field(default=3DNone, met=
adata=3DParams.long("cipher-op"))
> +    csv_friendly: Switch =3D field(default=3DNone, metadata=3DParams.lon=
g("csv-friendly"))
> +    desc_nb: int | None =3D field(default=3DNone, metadata=3DParams.long=
("desc-nb"))
> +    devtype: DeviceType =3D field(metadata=3DParams.long("devtype"))
> +    digest_sz: int | None =3D field(default=3DNone, metadata=3DParams.lo=
ng("digest-sz"))
> +    docsis_hdr_sz: int | None =3D field(default=3DNone, metadata=3DParam=
s.long("docsis-hdr-sz"))
> +    enable_sdap: Switch =3D None
> +    imix: int | None =3D field(default=3DNone, metadata=3DParams.long("i=
mix"))
> +    low_prio_qp_mask: int | None =3D field(default=3DNone, metadata=3DPa=
rams.convert_value(hex))
> +    modex_len: int | None =3D field(default=3DNone, metadata=3DParams.lo=
ng("modex-len"))
> +    optype: OperationType | None =3D field(default=3DNone, metadata=3DPa=
rams.long("optype"))
> +    out_of_place: Switch =3D None
> +    pdcp_sn_sz: int | None =3D None
> +    pdcp_domain: PDCPDomain | None =3D field(default=3DNone, metadata=3D=
Params.long("pdcp-domain"))
> +    pdcp_ses_hfn_en: Switch | None =3D field(default=3DNone, metadata=3D=
Params.long("pdcp-ses-hfn-en"))
> +    pmd_cyclecount_delay_pmd: int | None =3D field(
> +        default=3DNone, metadata=3DParams.long("pmd-cyclecount-delay-pmd=
")
> +    )
> +    pool_sz: int | None =3D field(default=3DNone, metadata=3DParams.long=
("pool-sz"))
> +    ptest: TestType =3D field(default=3DTestType.throughput, metadata=3D=
Params.long("ptest"))
> +    rsa_modlen: int | None =3D field(default=3DNone, metadata=3DParams.l=
ong("rsa-modlen"))
> +    rsa_priv_keytype: RSAPrivKeytype | None =3D field(
> +        default=3DNone, metadata=3DParams.long("rsa-priv-keytype")
> +    )
> +    segment_sz: int | None =3D field(default=3DNone, metadata=3DParams.l=
ong("segment-sz"))
> +    sessionless: Switch =3D None
> +    shared_session: Switch =3D None
> +    silent: Silent | None =3D field(default=3D"", metadata=3DParams.long=
("silent"))
> +    test_file: str | None =3D field(default=3DNone, metadata=3DParams.lo=
ng("test-file"))
> +    test_name: str | None =3D field(default=3DNone, metadata=3DParams.lo=
ng("test-name"))
> +    tls_version: TLSVersion | None =3D field(default=3DNone, metadata=3D=
Params.long("tls-version"))
> +    total_ops: int | None =3D field(default=3D100000, metadata=3DParams.=
long("total-ops"))
> diff --git a/dts/api/cryptodev/types.py b/dts/api/cryptodev/types.py
> new file mode 100644
> index 0000000000..df73a86fa4
> --- /dev/null
> +++ b/dts/api/cryptodev/types.py
> @@ -0,0 +1,185 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2025 University of New Hampshire
> +
> +"""Cryptodev types module.
> +
> +Exposes types used in the Cryptodev API.
> +"""
> +
> +from dataclasses import dataclass, field
> +
> +from framework.parser import TextParser
> +
> +
> +@dataclass
> +class CryptodevResults(TextParser):
> +    """Base class for all cryptodev results."""
> +
> +    buffer_size: int
> +
> +    def __iter__(self):
> +        """Iteration method to parse result objects.
> +
> +        Yields:
> +            tuple[str, int | float]: a field name and its value.
> +        """
> +        for field_name in self.__dataclass_fields__:
> +            yield field_name, getattr(self, field_name)
> +
> +
> +@dataclass
> +class ThroughputResults(CryptodevResults):
> +    """A parser for throughput test output."""
> +
> +    #:
> +    lcore_id: int =3D field(metadata=3DTextParser.find_int(r"\s*(\d+)"))
> +    #: buffer size used in the run
> +    buffer_size: int =3D field(
> +        metadata=3DTextParser.find_int(r"\s+(?:\d+\s+)(\d+)"),
> +    )
> +    #: burst size used in the run
> +    burst_size: int =3D field(
> +        metadata=3DTextParser.find_int(r"\s+(?:\d+\s+){2}(\d+)"),
> +    )
> +    #: total packets enqueued
> +    enqueued: int =3D field(metadata=3DTextParser.find_int(r"\s+(?:\d+\s=
+){3}(\d+)"))
> +    #: total packets dequeued
> +    dequeued: int =3D field(metadata=3DTextParser.find_int(r"\s+(?:\d+\s=
+){4}(\d+)"))
> +    #: packets that failed enqueue
> +    failed_enqueue: int =3D field(metadata=3DTextParser.find_int(r"\s+(?=
:\d+\s+){5}(\d+)"))
> +    #: packets that failed dequeue
> +    failed_dequeue: int =3D field(metadata=3DTextParser.find_int(r"\s+(?=
:\d+\s+){6}(\d+)"))
> +    #: mega operations per second
> +    mops: float =3D field(metadata=3DTextParser.find_float(r"\s+(?:\d+\s=
+){7}([\d.]+)"))
> +    #: gigabits per second
> +    gbps: float =3D field(metadata=3DTextParser.find_float(r"\s+(?:\d+\s=
+){7}(?:[\d.]+\s+)([\d.]+)"))
> +    #: cpu cycles per buffer
> +    cycles_per_buffer: float =3D field(
> +        metadata=3DTextParser.find_float(r"\s+(?:\d+\s+){7}(?:[\d.]+\s+)=
{2}([\d.]+)")
> +    )
> +
> +
> +@dataclass
> +class LatencyResults(CryptodevResults):
> +    """A parser for latency test output."""
> +
> +    #: buffer size ran with app
> +    buffer_size: int =3D field(
> +        metadata=3DTextParser.find_int(r"Buf(?:.*\n\s+\d+\s+)?(?:fer siz=
e:\s+)?(\d+)"),
> +    )
> +    #: burst size ran with app
> +    burst_size: int =3D field(
> +        metadata=3DTextParser.find_int(rf"Burst(?:.*\n\s+\d+\s+){2}?(?: =
size:\s+)?(\d+)"),
> +    )
> +    #: total operations ran
> +    total_ops: int =3D field(metadata=3DTextParser.find_int(r"total oper=
ations:\s+(\d+)"))
> +    #: number of bursts
> +    num_of_bursts: int =3D field(metadata=3DTextParser.find_int(r"Number=
 of bursts:\s+(\d+)"))
> +    #: minimum enqueued packets
> +    min_enqueued: int =3D field(metadata=3DTextParser.find_int(r"enqueue=
d\s+(?:\d+\s+){2}(\d+)"))
> +    #: maximum enqueued packets
> +    max_enqueued: int =3D field(metadata=3DTextParser.find_int(r"enqueue=
d\s+(?:\d+\s+){3}(\d+)"))
> +    #: average enqueued packets
> +    avg_enqueued: int =3D field(metadata=3DTextParser.find_int(r"enqueue=
d\s+(?:\d+\s+)(\d+)"))
> +    #: total enqueued packets
> +    total_enqueued: int =3D field(metadata=3DTextParser.find_int(r"enque=
ued\s+(\d+)"))
> +    #: minimum dequeued packets
> +    min_dequeued: int =3D field(metadata=3DTextParser.find_int(r"dequeue=
d\s+(?:\d+\s+){2}(\d+)"))
> +    #: maximum dequeued packets
> +    max_dequeued: int =3D field(metadata=3DTextParser.find_int(r"dequeue=
d\s+(?:\d+\s+){3}(\d+)"))
> +    #: average dequeued packets
> +    avg_dequeued: int =3D field(metadata=3DTextParser.find_int(r"dequeue=
d\s+(?:\d+\s+)(\d+)"))
> +    #: total dequeued packets
> +    total_dequeued: int =3D field(metadata=3DTextParser.find_int(r"deque=
ued\s+(\d+)"))
> +    #: minimum cycles per buffer
> +    min_cycles: float =3D field(metadata=3DTextParser.find_float(r"cycle=
s\s+(?:[\d.]+\s+){3}([\d.]+)"))
> +    #: maximum cycles per buffer
> +    max_cycles: float =3D field(metadata=3DTextParser.find_float(r"cycle=
s\s+(?:[\d.]+\s+){2}([\d.]+)"))
> +    #: average cycles per buffer
> +    avg_cycles: float =3D field(metadata=3DTextParser.find_float(r"cycle=
s\s+(?:[\d.]+\s+)([\d.]+)"))
> +    #: total cycles per buffer
> +    total_cycles: float =3D field(metadata=3DTextParser.find_float(r"cyc=
les\s+([\d.]+)"))
> +    #: mimum time in microseconds
> +    min_time_us: float =3D field(
> +        metadata=3DTextParser.find_float(r"time \[us\]\s+(?:[\d.]+\s+){3=
}([\d.]+)")
> +    )
> +    #: maximum time in microseconds
> +    max_time_us: float =3D field(
> +        metadata=3DTextParser.find_float(r"time \[us\]\s+(?:[\d.]+\s+){2=
}([\d.]+)")
> +    )
> +    #: average time in microseconds
> +    avg_time_us: float =3D field(
> +        metadata=3DTextParser.find_float(r"time \[us\]\s+(?:[\d.]+\s+)([=
\d.]+)")
> +    )
> +    #: total time in microseconds
> +    total_time_us: float =3D field(metadata=3DTextParser.find_float(r"ti=
me \[us\]\s+([\d.]+)"))
> +
> +
> +@dataclass
> +class PmdCyclecountResults(CryptodevResults):
> +    """A parser for PMD cycle count test output."""
> +
> +    #:
> +    lcore_id: int =3D field(metadata=3DTextParser.find_int(r"lcore\s+(?:=
id.*\n\s+)?(\d+)"))
> +    #: buffer size used with app run
> +    buffer_size: int =3D field(
> +        metadata=3DTextParser.find_int(r"Buf(?:.*\n\s+(?:\d+\s+))?(?:fer=
 size:\s+)?(\d+)"),
> +    )
> +    #: burst size used with app run
> +    burst_size: int =3D field(
> +        metadata=3DTextParser.find_int(r"Burst(?:.*\n\s+(?:\d+\s+){2})?(=
?: size:\s+)?(\d+)"),
> +    )
> +    #: packets enqueued
> +    enqueued: int =3D field(metadata=3DTextParser.find_int(r"Enqueued.*\=
n\s+(?:\d+\s+){3}(\d+)"))
> +    #: packets dequeued
> +    dequeued: int =3D field(metadata=3DTextParser.find_int(r"Dequeued.*\=
n\s+(?:\d+\s+){4}(\d+)"))
> +    #: number of enqueue packet retries
> +    enqueue_retries: int =3D field(
> +        metadata=3DTextParser.find_int(r"Enq Retries.*\n\s+(?:\d+\s+){5}=
(\d+)")
> +    )
> +    #: number of dequeue packet retries
> +    dequeue_retries: int =3D field(
> +        metadata=3DTextParser.find_int(r"Deq Retries.*\n\s+(?:\d+\s+){6}=
(\d+)")
> +    )
> +    #: number of cycles per operation
> +    cycles_per_operation: float =3D field(
> +        metadata=3DTextParser.find_float(r"Cycles/Op.*\n\s+(?:\d+\s+){7}=
([\d.]+)")
> +    )
> +    #: number of cycles per enqueue
> +    cycles_per_enqueue: float =3D field(
> +        metadata=3DTextParser.find_float(r"Cycles/Enq.*\n\s+(?:\d+\s+){7=
}(?:[\d.]+\s+)([\d.]+)")
> +    )
> +    #: number of cycles per dequeue
> +    cycles_per_dequeue: float =3D field(
> +        metadata=3DTextParser.find_float(r"Cycles/Deq.*\n\s+(?:\d+\s+){7=
}(?:[\d.]+\s+){2}([\d.]+)"),
> +    )
> +
> +
> +@dataclass
> +class VerifyResults(CryptodevResults):
> +    """A parser for verify test output."""
> +
> +    #:
> +    lcore_id: int =3D field(metadata=3DTextParser.find_int(r"lcore\s+(?:=
id.*\n\s+)?(\d+)"))
> +    #: buffer size ran with app
> +    buffer_size: int =3D field(
> +        metadata=3DTextParser.find_int(r"Buf(?:.*\n\s+(?:\d+\s+))?(?:fer=
 size:\s+)?(\d+)"),
> +    )
> +    #: burst size ran with app
> +    burst_size: int =3D field(
> +        metadata=3DTextParser.find_int(r"Burst(?:.*\n\s+(?:\d+\s+){2})?(=
?: size:\s+)?(\d+)"),
> +    )
> +    #: number of packets enqueued
> +    enqueued: int =3D field(metadata=3DTextParser.find_int(r"Enqueued.*\=
n\s+(?:\d+\s+){3}(\d+)"))
> +    #: number of packets dequeued
> +    dequeued: int =3D field(metadata=3DTextParser.find_int(r"Dequeued.*\=
n\s+(?:\d+\s+){4}(\d+)"))
> +    #: number of packets enqueue failed
> +    failed_enqueued: int =3D field(
> +        metadata=3DTextParser.find_int(r"Failed Enq.*\n\s+(?:\d+\s+){5}(=
\d+)")
> +    )
> +    #: number of packets dequeue failed
> +    failed_dequeued: int =3D field(
> +        metadata=3DTextParser.find_int(r"Failed Deq.*\n\s+(?:\d+\s+){6}(=
\d+)")
> +    )
> +    #: total number of failed operations
> +    failed_ops: int =3D field(metadata=3DTextParser.find_int(r"Failed Op=
s.*\n\s+(?:\d+\s+){7}(\d+)"))
> diff --git a/dts/configurations/nodes.example.yaml b/dts/configurations/n=
odes.example.yaml
> index 3f23df11ec..1fc0a38bf5 100644
> --- a/dts/configurations/nodes.example.yaml
> +++ b/dts/configurations/nodes.example.yaml
> @@ -20,6 +20,12 @@
>    hugepages_2mb: # optional; if removed, will use system hugepage config=
uration
>        number_of: 256
>        force_first_numa: false
> +  # cryptodevs: # optional; add each physical bdf as its own element in =
the list

I would rephrase to clarify:

"Uncomment to run cryptodev tests; add physical cryptodev devices by their =
BDF"

I also think that we are at a place now where we have a number of
optional fields in the config files that can be commented or
uncommented, and there may be value in explicitly calling this out,
perhaps with a one liner above all of the YAML fields. I think you are
going in the right direction with your comment, but then we have other
fields which are optional that don't have the same explanation, or
it's phrased differently, resulting in documentation which is
inconsistent and potentially confusing to new people who just want to
fill out their config files. What do you think agree/disagree? If you
agree can you come up with something? Thanks.

> +  #   - name: cryptodev-0
> +  #     pci: "ffff:ff:ff.f"
> +  #     os_driver_for_dpdk: vfio-pci # OS driver that DPDK will use

will use for the cryptodev VFs.

> +  #     os_driver: _ # This is unused but a value is necessary to run dt=
s

If there is really no point in populating the os_driver field, is it
possible to remove the field and force the config parser step in the
framework be tolerant to this?

> +  # crypto_driver: # the device type of the DUT (crypto_qat, crypto_zuc,=
 crypto_aesni_mb)

Put e.g. ahead of the list.

>  # Define a Scapy traffic generator node, having two network ports
>  # physically connected to the corresponding ports in SUT 1 (the peer nod=
e).
>  - name: "TG 1"
> diff --git a/dts/framework/config/node.py b/dts/framework/config/node.py
> index 438a1bdc8f..36068c1ef8 100644
> --- a/dts/framework/config/node.py
> +++ b/dts/framework/config/node.py
> @@ -70,6 +70,10 @@ class NodeConfiguration(FrozenModel):
>      hugepages: HugepageConfiguration | None =3D Field(None, alias=3D"hug=
epages_2mb")
>      #: The ports that can be used in testing.
>      ports: list[PortConfig] =3D Field(min_length=3D1)
> +    #: The pci info used by crypto devices
> +    cryptodevs: list[PortConfig] =3D Field(default=3D[], min_length=3D0)
> +    #: The crypto driver used by crypto devices
> +    crypto_driver: str | None =3D None
>
>      @model_validator(mode=3D"after")
>      def verify_unique_port_names(self) -> Self:
> diff --git a/dts/framework/params/types.py b/dts/framework/params/types.p=
y
> index 5bc4bd37d9..3c7650474c 100644
> --- a/dts/framework/params/types.py
> +++ b/dts/framework/params/types.py
> @@ -15,6 +15,23 @@ def create_testpmd(**kwargs: Unpack[TestPmdParamsDict]=
):
>  from pathlib import PurePath
>  from typing import TypedDict
>
> +from api.cryptodev.config import (
> +    AeadAlgName,
> +    AsymOpMode,
> +    AuthenticationAlgorithm,
> +    AuthenticationOpMode,
> +    BurstSizeRange,
> +    CipherAlgorithm,
> +    DeviceType,
> +    EncryptDecryptSwitch,
> +    ListWrapper,
> +    OperationType,
> +    PDCPDomain,
> +    RSAPrivKeytype,
> +    Silent,
> +    TestType,
> +    TLSVersion,
> +)
>  from api.testpmd.config import (
>      AnonMempoolAllocationMode,
>      EthPeer,
> @@ -55,6 +72,54 @@ class EalParamsDict(TypedDict, total=3DFalse):
>      other_eal_param: Params | None
>
>
> +class CryptoPmdParamsDict(EalParamsDict, total=3DFalse):
> +    """:class:`TypedDict` equivalent of :class:`~.cryptodev.CryptoPmdPar=
ams`."""
> +
> +    aead_aad_sz: int | None
> +    aead_algo: AeadAlgName | None
> +    aead_iv_sz: int | None
> +    aead_key_sz: int | None
> +    aead_op: EncryptDecryptSwitch | None
> +    asym_op: AsymOpMode | None
> +    auth_algo: AuthenticationAlgorithm | None
> +    auth_iv_sz: int | None
> +    auth_key_sz: int | None
> +    auth_op: AuthenticationOpMode | None
> +    buffer_sz: BurstSizeRange | ListWrapper | int | None
> +    burst_sz: BurstSizeRange | ListWrapper | int | None
> +    cipher_algo: CipherAlgorithm | None
> +    cipher_iv_sz: int | None
> +    cipher_key_sz: int | None
> +    cipher_op: EncryptDecryptSwitch | None
> +    csv_friendly: Switch
> +    desc_nb: int | None
> +    devtype: DeviceType | None
> +    digest_sz: int | None
> +    docsis_hdr_sz: int | None
> +    enable_sdap: Switch
> +    imix: int | None
> +    low_prio_qp_mask: int | None
> +    modex_len: int | None
> +    optype: OperationType | None
> +    out_of_place: Switch
> +    pdcp_sn_sz: int | None
> +    pdcp_domain: PDCPDomain | None
> +    pdcp_ses_hfn_en: Switch | None
> +    pmd_cyclecount_delay_pmd: int | None
> +    pool_sz: int | None
> +    ptest: TestType
> +    rsa_modlen: int | None
> +    rsa_priv_keytype: RSAPrivKeytype | None
> +    segment_sz: int | None
> +    sessionless: Switch
> +    shared_session: Switch
> +    silent: Silent | None
> +    test_file: str | None
> +    test_name: str | None
> +    tls_version: TLSVersion | None
> +    total_ops: int | None
> +
> +
>  class TestPmdParamsDict(EalParamsDict, total=3DFalse):
>      """:class:`TypedDict` equivalent of :class:`~.testpmd.TestPmdParams`=
."""
>
> diff --git a/dts/framework/remote_session/dpdk_shell.py b/dts/framework/r=
emote_session/dpdk_shell.py
> index 51b97d4ff6..b94d336d4e 100644
> --- a/dts/framework/remote_session/dpdk_shell.py
> +++ b/dts/framework/remote_session/dpdk_shell.py
> @@ -46,7 +46,10 @@ def compute_eal_params(
>      params.prefix =3D prefix
>
>      if params.allowed_ports is None:
> -        params.allowed_ports =3D ctx.topology.sut_dpdk_ports
> +        if ctx.topology.crypto_vf_ports:
> +            params.allowed_ports =3D [ctx.topology.crypto_vf_ports[0]]
> +        else:
> +            params.allowed_ports =3D ctx.topology.sut_dpdk_ports
>
>      return params
>
> diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
> index ff0a12c9ce..36e6c5a44c 100644
> --- a/dts/framework/test_run.py
> +++ b/dts/framework/test_run.py
> @@ -349,6 +349,9 @@ def next(self) -> State | None:
>
>          if test_run.config.use_virtual_functions:
>              test_run.ctx.topology.instantiate_vf_ports()
> +        if test_run.ctx.sut_node.cryptodevs:
> +            test_run.ctx.topology.instantiate_crypto_vf_ports()
> +            test_run.ctx.topology.configure_cryptodevs("dpdk")
>
>          test_run.ctx.topology.configure_ports("sut", "dpdk")
>          if test_run.ctx.func_tg:
> @@ -442,6 +445,8 @@ def next(self) -> State | None:
>          """Next state."""
>          if self.test_run.config.use_virtual_functions:
>              self.test_run.ctx.topology.delete_vf_ports()
> +        if self.test_run.ctx.sut_node.cryptodevs:
> +            self.test_run.ctx.topology.delete_crypto_vf_ports()
>
>          self.test_run.ctx.shell_pool.terminate_current_pool()
>          if self.test_run.ctx.func_tg and self.test_run.ctx.func_tg.is_se=
tup:
> diff --git a/dts/framework/testbed_model/linux_session.py b/dts/framework=
/testbed_model/linux_session.py
> index 711d4d97c3..27a5f48ecf 100644
> --- a/dts/framework/testbed_model/linux_session.py
> +++ b/dts/framework/testbed_model/linux_session.py
> @@ -10,6 +10,7 @@
>  """
>
>  import json
> +import re
>  from collections.abc import Iterable
>  from functools import cached_property
>  from pathlib import PurePath
> @@ -223,6 +224,30 @@ def devbind_script_path(self) -> PurePath:
>          """
>          raise InternalError("Accessed devbind script path before setup."=
)
>
> +    def create_crypto_vfs(self, pf_port: list[Port]) -> None:
> +        """Overrides :meth:`~os_session.OSSession.create_crypto_vfs`.
> +
> +        Raises:
> +            InternalError: If there are existing VFs which have to be de=
leted.
> +        """
> +        for port in pf_port:
> +            self.delete_crypto_vfs(port)
> +        for port in pf_port:
> +            sys_bus_path =3D f"/sys/bus/pci/devices/{port.pci}".replace(=
":", "\\:")
> +            curr_num_vfs =3D int(
> +                self.send_command(f"cat {sys_bus_path}/sriov_numvfs", pr=
ivileged=3DTrue).stdout
> +            )
> +            if 0 < curr_num_vfs:
> +                raise InternalError("There are existing VFs on the port =
which must be deleted.")
> +            num_vfs =3D int(
> +                self.send_command(f"cat {sys_bus_path}/sriov_totalvfs", =
privileged=3DTrue).stdout
> +            )
> +            self.send_command(
> +                f"echo {num_vfs} | sudo tee {sys_bus_path}/sriov_numvfs"=
, privileged=3DTrue
> +            )
> +
> +        self.refresh_lshw()
> +
>      def create_vfs(self, pf_port: Port) -> None:
>          """Overrides :meth:`~.os_session.OSSession.create_vfs`.
>
> @@ -239,6 +264,23 @@ def create_vfs(self, pf_port: Port) -> None:
>              self.send_command(f"echo 1 | sudo tee {sys_bus_path}/sriov_n=
umvfs", privileged=3DTrue)
>              self.refresh_lshw()
>
> +    def delete_crypto_vfs(self, pf_port: Port) -> None:
> +        """Overrides :meth:`~.os_session.OSSession.delete_crypto_vfs`.""=
"
> +        sys_bus_path =3D f"/sys/bus/pci/devices/{pf_port.pci}".replace("=
:", "\\:")
> +        curr_num_vfs =3D int(
> +            self.send_command(f"cat {sys_bus_path}/sriov_numvfs", privil=
eged=3DTrue).stdout
> +        )
> +        if curr_num_vfs =3D=3D 0:
> +            return self._logger.debug(f"No VFs found on port {pf_port.pc=
i}, skipping deletion")
> +        self.send_command(
> +            f"dpdk-devbind.py -u {pf_port.pci}".replace(":", "\\:"), pri=
vileged=3DTrue, timeout=3D30
> +        )
> +        self.send_command(
> +            f"echo 1 | sudo tee /sys/bus/pci/devices/{pf_port.pci}/remov=
e".replace(":", "\\:"),
> +            privileged=3DTrue,
> +        )
> +        self.send_command("echo 1 | sudo tee /sys/bus/pci/rescan", privi=
leged=3DTrue)
> +
>      def delete_vfs(self, pf_port: Port) -> None:
>          """Overrides :meth:`~.os_session.OSSession.delete_vfs`."""
>          sys_bus_path =3D f"/sys/bus/pci/devices/{pf_port.pci}".replace("=
:", "\\:")
> @@ -250,6 +292,18 @@ def delete_vfs(self, pf_port: Port) -> None:
>          else:
>              self.send_command(f"echo 0 | sudo tee {sys_bus_path}/sriov_n=
umvfs", privileged=3DTrue)
>
> +    def get_pci_addr_of_crypto_vfs(self, pf_port: Port) -> list[str]:
> +        """Overrides :meth:`~.os_session.OSSession.get_pci_addr_of_crypt=
o_vfs`."""
> +        sys_bus_path =3D f"/sys/bus/pci/devices/{pf_port.pci}".replace("=
:", "\\:")
> +        curr_num_vfs =3D int(self.send_command(f"cat {sys_bus_path}/srio=
v_numvfs").stdout)
> +        if curr_num_vfs > 0:
> +            pci_addrs =3D self.send_command(
> +                f"readlink {sys_bus_path}/virtfn*",
> +                privileged=3DTrue,
> +            )
> +            return [pci.replace("../", "") for pci in pci_addrs.stdout.s=
plitlines()]
> +        return []
> +
>      def get_pci_addr_of_vfs(self, pf_port: Port) -> list[str]:
>          """Overrides :meth:`~.os_session.OSSession.get_pci_addr_of_vfs`.=
"""
>          sys_bus_path =3D f"/sys/bus/pci/devices/{pf_port.pci}".replace("=
:", "\\:")
> diff --git a/dts/framework/testbed_model/node.py b/dts/framework/testbed_=
model/node.py
> index 6c3e63a2a1..5c3e02a320 100644
> --- a/dts/framework/testbed_model/node.py
> +++ b/dts/framework/testbed_model/node.py
> @@ -54,6 +54,8 @@ class Node:
>      arch: Architecture
>      lcores: list[LogicalCore]
>      ports: list[Port]
> +    cryptodevs: list[Port]
> +    crypto_driver: str | None
>      _logger: DTSLogger
>      _other_sessions: list[OSSession]
>      _node_info: OSSessionInfo | None
> @@ -82,6 +84,14 @@ def __init__(self, node_config: NodeConfiguration) -> =
None:
>          self._other_sessions =3D []
>          self._setup =3D False
>          self.ports =3D [Port(self, port_config) for port_config in self.=
config.ports]
> +        self.cryptodevs =3D [
> +            Port(self, cryptodev_config) for cryptodev_config in self.co=
nfig.cryptodevs
> +        ]
> +        self.crypto_driver =3D self.config.crypto_driver
> +        if self.cryptodevs:
> +            self.main_session.load_vfio(self.cryptodevs[0])
> +        elif self.ports and self.ports[0].config.os_driver_for_dpdk =3D=
=3D "vfio-pci":
> +            self.main_session.load_vfio(self.ports[0])
>          self._logger.info(f"Created node: {self.name}")
>
>      def setup(self) -> None:
> diff --git a/dts/framework/testbed_model/os_session.py b/dts/framework/te=
stbed_model/os_session.py
> index b94c3e527b..2eeeea6967 100644
> --- a/dts/framework/testbed_model/os_session.py
> +++ b/dts/framework/testbed_model/os_session.py
> @@ -615,6 +615,14 @@ def configure_port_mtu(self, mtu: int, port: Port) -=
> None:
>              port: Port to set `mtu` on.
>          """
>
> +    @abstractmethod
> +    def create_crypto_vfs(self, pf_ports: list[Port]) -> None:
> +        """Creatues virtual functions for each port in 'pf_ports'.
typo

> +
> +        Checks how many virtual functions each crypto device in 'pf_port=
s' supports, and creates
> +            that number of VFs on the port.
> +        """
> +
>      @abstractmethod
>      def create_vfs(self, pf_port: Port) -> None:
>          """Creates virtual functions for `pf_port`.
> @@ -630,6 +638,16 @@ def create_vfs(self, pf_port: Port) -> None:
>              maximum for `pf_port`.
>          """
>
> +    @abstractmethod
> +    def delete_crypto_vfs(self, pf_port: Port) -> None:
> +        """Deletes virtual functions for crypto device 'pf_port'.
> +
> +        Checks how many virtual functions are currently active and remov=
es all if any exist.
> +
> +        Args:
> +            pf_port: The crypto device port to delete virtual functions =
on.
> +        """
> +
>      @abstractmethod
>      def delete_vfs(self, pf_port: Port) -> None:
>          """Deletes virtual functions for `pf_port`.
> @@ -656,3 +674,15 @@ def get_pci_addr_of_vfs(self, pf_port: Port) -> list=
[str]:
>              A list containing all of the PCI addresses of the VFs on the=
 port. If the port has no
>              VFs then the list will be empty.
>          """
> +
> +    @abstractmethod
> +    def get_pci_addr_of_crypto_vfs(self, pf_port: Port) -> list[str]:
> +        """Find the PCI addresses of all virtual functions (VFs) of a cr=
ypto device on `pf_port`.
> +
> +        Args:
> +            pf_port: The port to find the VFs on.
> +
> +        Returns:
> +            A list containing all of the PCI addresses of the VFs on the=
 port. If the port has no
> +            VFs then the list will be empty.
> +        """
> diff --git a/dts/framework/testbed_model/topology.py b/dts/framework/test=
bed_model/topology.py
> index 13b4b58a74..d9af67552a 100644
> --- a/dts/framework/testbed_model/topology.py
> +++ b/dts/framework/testbed_model/topology.py
> @@ -8,6 +8,7 @@
>  The link information then implies what type of topology is available.
>  """
>
> +import re
>  from collections import defaultdict
>  from collections.abc import Iterator
>  from dataclasses import dataclass
> @@ -58,6 +59,8 @@ class Topology:
>      tg_ports: list[Port]
>      pf_ports: list[Port]
>      vf_ports: list[Port]
> +    crypto_pf_ports: list[Port]
> +    crypto_vf_ports: list[Port]
>
>      @classmethod
>      def from_port_links(cls, port_links: Iterator[PortLink]) -> Self:
> @@ -85,7 +88,7 @@ def from_port_links(cls, port_links: Iterator[PortLink]=
) -> Self:
>                      msg =3D "More than two links in a topology are not s=
upported."
>                      raise ConfigurationError(msg)
>
> -        return cls(type, sut_ports, tg_ports, [], [])
> +        return cls(type, sut_ports, tg_ports, [], [], [], [])
>
>      def node_and_ports_from_id(self, node_identifier: NodeIdentifier) ->=
 tuple[Node, list[Port]]:
>          """Retrieve node and its ports for the current topology.
> @@ -105,6 +108,39 @@ def node_and_ports_from_id(self, node_identifier: No=
deIdentifier) -> tuple[Node,
>                  msg =3D f"Invalid node `{node_identifier}` given."
>                  raise InternalError(msg)
>
> +    def get_crypto_vfs(self, numvfs: int | None =3D None) -> list[Port]:

numvfs -> num_vfs

> +        """Retrieve virtual functions from active crypto vfs.
> +
> +        If numvfs is `None`, returns all crypto virtual functions. Other=
wise, returns
> +        `numvfs` number of virtual functions per physical function round=
ed down. If a number of
> +        `numvfs` is less than the number of physical functions, one virt=
ual function is returned.

I am wondering about this design. So, the form of the return value is
unpredictable? What do the testsuites actually require?

> +
> +        Args:
> +            numvfs: Number of virtual functions to return if provided.
> +
> +        Returns:
> +            List containing the requested number of vfs, evenly distribu=
ted among

vfs -> VFs

> +                physcal functions rounded down.

physical typo

> +        """
> +        return_list =3D []
> +        device =3D 1
> +        if len(self.crypto_pf_ports) =3D=3D 0:
> +            return []
> +        if numvfs is None:
> +            return_list.extend(self.crypto_vf_ports)
> +            return return_list
> +        mod =3D numvfs // len(self.crypto_pf_ports)

mod as in modulo? Perhaps you mean integer division instead of mod?

> +        if numvfs < len(self.crypto_pf_ports):
> +            return_list.extend([self.crypto_vf_ports[0]])
> +            return return_list
> +        for i in range(mod):
> +            if i % 8 =3D=3D 0 and i !=3D 0:
> +                device +=3D 1
> +            return_list.extend(
> +                filter(lambda x: re.search(rf"0000:\d+:0{device}.{i}", x=
.pci), self.crypto_vf_ports)
> +            )
> +        return return_list
> +
>      def setup(self) -> None:
>          """Setup topology ports.
>
> @@ -145,6 +181,34 @@ def _setup_ports(self, node_identifier: NodeIdentifi=
er) -> None:
>                      f"for port {port.name} in node {node.name}."
>                  )
>
> +    def instantiate_crypto_vf_ports(self) -> None:
> +        """Create max number of virtual functions allowed on the SUT nod=
e.
> +
> +        Raises:
> +            InternalError: If crypto virtual functions could not be crea=
ted on a port.
> +        """
> +        from framework.context import get_ctx
> +
> +        ctx =3D get_ctx()
> +
> +        for port in ctx.sut_node.cryptodevs:
> +            self.crypto_pf_ports.append(port)
> +        self.delete_crypto_vf_ports()

populating crypto_pf_ports in the instantiate_crypto_vf_ports method?
Possible single responsibility principle violation but not a huge deal
if it cannot be cleanly populated "earlier."

> +
> +        ctx.sut_node.main_session.create_crypto_vfs(self.crypto_pf_ports=
)
> +        for port in self.crypto_pf_ports:
> +            addr_list =3D ctx.sut_node.main_session.get_pci_addr_of_cryp=
to_vfs(port)
> +            if addr_list =3D=3D []:
> +                raise InternalError(f"Failed to create crypto virtual fu=
nction on port {port.pci}")
> +            for addr in addr_list:
> +                vf_config =3D PortConfig(
> +                    name=3Df"{port.name}-crypto-vf-{addr}",
> +                    pci=3Daddr,
> +                    os_driver_for_dpdk=3Dport.config.os_driver_for_dpdk,
> +                    os_driver=3Dport.config.os_driver,
> +                )
> +                self.crypto_vf_ports.append(Port(node=3Dport.node, confi=
g=3Dvf_config))
> +
>      def instantiate_vf_ports(self) -> None:
>          """Create, setup, and add virtual functions to the list of ports=
 on the SUT node.
>
> @@ -189,6 +253,27 @@ def delete_vf_ports(self) -> None:
>          self.sut_ports.clear()
>          self.sut_ports.extend(self.pf_ports)
>
> +    def delete_crypto_vf_ports(self) -> None:
> +        """Delete crypto virtual functions from the SUT node during test=
 run teardown."""
> +        from framework.context import get_ctx
> +
> +        ctx =3D get_ctx()
> +
> +        for port in self.crypto_pf_ports:
> +            ctx.sut_node.main_session.delete_crypto_vfs(port)
> +        self.sut_ports.clear()
> +        self.sut_ports.extend(self.pf_ports)

What list needs to be cleared here? sut_ports or crypto_vf_ports?
Unless I am misundersatnding, your implementation leaves sut_ports to
the ethdev devices and runs everything for cryptodev ports through
crypto_pf_ports and crypto_vf_ports.

> +
> +    def configure_cryptodevs(self, driver: DriverKind):
> +        """Configure the crypto device virtual functoins on the sut and =
bind to specified driver.

functions typo.

Also, is this configuring, or just binding?

> +
> +        Args:
> +            driver: The driver to bind the cryptofunctions

typo. Try to check on the spelling before your next version. :)

> +        """
> +        from framework.context import get_ctx
> +
> +        self._bind_ports_to_drivers(get_ctx().sut_node, self.crypto_vf_p=
orts, driver)
> +
>      def configure_ports(
>          self, node_identifier: NodeIdentifier, drivers: DriverKind | tup=
le[DriverKind, ...]
>      ) -> None:
> @@ -227,7 +312,7 @@ def _bind_ports_to_drivers(
>          for port_id, port in enumerate(ports):
>              driver_kind =3D drivers[port_id] if isinstance(drivers, tupl=
e) else drivers
>              desired_driver =3D port.driver_by_kind(driver_kind)
> -            if port.current_driver !=3D desired_driver:
> +            if port in self.crypto_vf_ports or port.current_driver !=3D =
desired_driver:
>                  driver_to_ports[desired_driver].append(port)
>
>          for driver_name, ports in driver_to_ports.items():
> --
> 2.50.1
>

Reviewed-by: Patrick Robb <probb@iol.unh.edu>
