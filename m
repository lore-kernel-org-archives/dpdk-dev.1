Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6376EFEFB6E
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 18:27:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40C17402EB;
	Fri, 27 Feb 2026 19:27:11 +0100 (CET)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by mails.dpdk.org (Postfix) with ESMTP id 283EA4060F
 for <dev@dpdk.org>; Fri, 27 Feb 2026 19:27:09 +0100 (CET)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-124a635476fso2806887c88.0
 for <dev@dpdk.org>; Fri, 27 Feb 2026 10:27:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772216828; cv=none;
 d=google.com; s=arc-20240605;
 b=CrPg2wEppGQQvnLseZC67l3+EItISNiI8x2IcIPu+2SE+6RDHZk2oKB+iDWqPd6Zy3
 n+b1ngcFD0V+zRBFAHIEZq2Whx6KQYTkoRE0goGC1EHucS/E9FRvpxp/TtUtXxW1eWCq
 vEiDLBvF/Gq/A62AXNXCfBRNHqbiHCZxT7wjyGAhIf8bcxIByrrchTDykatYh8Yf+Kgg
 vOKKJsEmQpSMmnBpvuQ6C97x4UHHC9olmbhBxvMNN8I6VJFVnmyTm9Xk2AnL/nT1vPZg
 7m4Ep4vgPp8DUaHdxgQwIo9nDGul80xJFuVjlasCTLSAiSqRpMUvyz36FrLtyJkbwh2l
 FR3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TxFjLquCekRHzcFbLETKQZBrtUiAbqkPn8DsB1ZmAS0=;
 fh=eSDrF0i5qT6Vqwk0FVFdiORL9twsajVKGw/F6fg0Rds=;
 b=IBM4g+nZ7yfuKSmDUw/pUFaIDIOTpn69TXfEcOC072K0R+8u6AcvbhXbeYnfKQCRGa
 8Jprw9J6p5uRdSKmYt+ER3fCIl3CVEyGyGDD6NLecF8Ytued3VjT0BEUJRuYBw74uVui
 2pXZ/7VypI3EDvcg4gzcVWBxOluu7GqlzMh2fkVEMfCG3XEDdaaDoIY8AUY5vy+lLyQe
 1Or+DcziDWLfT0iySR2xgXW5JMvTKNmw49eYXnp/MighahgbLuDzxPoE+fWn5DRHL3gQ
 USEM9jxodcBo47GCzZii3nNRiEtUiLqZcDVVUSumb92T/rQOjgpnE0yncRNx4B31Rmdy
 wlRw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1772216828; x=1772821628; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TxFjLquCekRHzcFbLETKQZBrtUiAbqkPn8DsB1ZmAS0=;
 b=Gxmth1bRdo+BmsPN2ZB5SwELeCe0yHpkZyTnmmI7DL1lffp8dtD9VcijFtgAZQDJAK
 67QHe2yYZdkR8crDzyI/1YeYL78V4kLE1fdfdnzvN97IGntPtUo4U3slI2LMBaTKR8jQ
 Wqm4X7TXwgaeqb5UEfPEY0kdMx8PeXfTgfCFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772216828; x=1772821628;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TxFjLquCekRHzcFbLETKQZBrtUiAbqkPn8DsB1ZmAS0=;
 b=Mg9XVD3ITAW8hLyv7xnpoKdRZCquwv+jpBgsYUUj+dKdfDC0T47DAMW7wcKHKjecfL
 4nVSqHeMsKJCsCPvBZ3OcRoklBtq7pBR5JDmriZvehNbbqZxEX4PvnsxenaChKLbe//v
 JWft5R/spEbkRdwGyW6MKNUjAe1coppBdlwjh7K7dwYcGlEzrEqwQ9pA3z0IwLDWhWGN
 jSVX8p3YVnRKBI3ZLYd+PYSa92vqUxnwJG3oEJFgN74anbz+bA6kq9CuLdYa3EZHqRK2
 1iQdJXSTjlRFS1/iCB8+FMy2F36ElY7vNpcZDDHwqXxmJ8y/H5ERk+Z51h9cXZDwcaSP
 iqCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr1M5QatbB4Kv+FarM6+Igg3jsC+qo7na15KzJ15fY1Yf0z4ZzxLO/cUSKnGaLc+G7V2c=@dpdk.org
X-Gm-Message-State: AOJu0YzPP+G7OijNgl76+IrwFOMp5z2mH9fynXuhvePLHIppN8lEL3Bu
 NDwdtFe2SMyG4x1dFSbsQ3IDbjI0xfw23ncMhHcgMr87Ow0JWvZbBvre5MUUYbJoFjsLBKGPRDp
 cBd0uK5Orf2x/ia4HGk9kM8kIhzPDRRXFbB+opBftSQ==
X-Gm-Gg: ATEYQzzLWrATvtFs7ss+/soMf3RUimWxm+1ajxwyLbbKRsl9ZOsUXxU/Ss/zWVso0Jq
 KIGT4F2dWNbCndFoEDQjCaTfJlyCSDL5g24P0QQCXhRLItCpCf4IRa69mBw2eIAPJgWMNmhxfkZ
 DlCUzQxla+8O6HRVaRvwgsDrq31axp69rHTAsxUZfAd93kePUj0uX5iLwf32YAf487xdPiLbKXd
 gc0E8v4pG48orNmvJ1n3yA99BK4UoovtgNXXKIFUtDwpLVjSYIPFnJGkRyffC1qsKrDon9V9dPM
 m4pWGgSjNRxx07yTK/Voqrcv7hu7wmd77/ADZxsWOeN4sMyTrHbivQ==
X-Received: by 2002:a05:7022:2208:b0:11b:9386:a387 with SMTP id
 a92af1059eb24-1278fc8cf0amr1505622c88.42.1772216827859; Fri, 27 Feb 2026
 10:27:07 -0800 (PST)
MIME-Version: 1.0
References: <20260210193448.69423-1-abailey@iol.unh.edu>
 <20260213193539.103858-1-abailey@iol.unh.edu>
 <20260213193539.103858-4-abailey@iol.unh.edu>
In-Reply-To: <20260213193539.103858-4-abailey@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 27 Feb 2026 13:24:16 -0500
X-Gm-Features: AaiRm51qLvDf6NTse-QFxtNWPY55uP4iAQBiaqA0AfN0iZc_007wcmx3QMJoDpY
Message-ID: <CAJvnSUBJVSz6ZPuHuSmN9gyDBqwf_h6pcsJvnQg_9CfsnBNH=w@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] dts: add cryptodev throughput test suite
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
> Add cryptodev performance test suite. This test covers throughput
> performance metrics of supplied crypto devices using the
> dpdk-test-crypto-perf application. The results of this application will
> be compared against user supplied performance metrics and fail if signs
> of regression are apparent.
>
> Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
> ---
>  .../tests.TestSuite_cryptodev_throughput.rst  |   8 +
>  dts/configurations/tests_config.example.yaml  |   8 +
>  dts/tests/TestSuite_cryptodev_throughput.py   | 690 ++++++++++++++++++
>  3 files changed, 706 insertions(+)
>  create mode 100644 doc/api/dts/tests.TestSuite_cryptodev_throughput.rst
>  create mode 100644 dts/tests/TestSuite_cryptodev_throughput.py
>
> diff --git a/doc/api/dts/tests.TestSuite_cryptodev_throughput.rst b/doc/a=
pi/dts/tests.TestSuite_cryptodev_throughput.rst
> new file mode 100644
> index 0000000000..5df5e7547e
> --- /dev/null
> +++ b/doc/api/dts/tests.TestSuite_cryptodev_throughput.rst
> @@ -0,0 +1,8 @@
> +.. SPDX-License-Identifier: BSD-3-Clause
> +
> +cryptodev_throughput Test Suite
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> +
> +.. automodule:: tests.TestSuite_cryptodev_throughput
> +   :members:
> +   :show-inheritance:
> diff --git a/dts/configurations/tests_config.example.yaml b/dts/configura=
tions/tests_config.example.yaml
> index 64fa630aa0..c9beff9c99 100644
> --- a/dts/configurations/tests_config.example.yaml
> +++ b/dts/configurations/tests_config.example.yaml
> @@ -15,3 +15,11 @@ hello_world:
>  #       num_descriptors: 1024
>  #       expected_mpps: 1.0
>  #   delta_tolerance: 0.05
> +# cryptodev_throughput:
> +#   delta_tolerance: 0.05
> +#   throughput_test_parameters:
> +#     snow3g_uea2_snow3g_uia2: # Add the name of the test suite you woul=
d like to run
> +#      - buff_size: 64
> +#        gbps: 2.0 # Set gigabits per second according to your devices t=
hroughput for this given buffer size
> +#      - buff_size: 512
> +#        gbps: 20.0
> \ No newline at end of file
> diff --git a/dts/tests/TestSuite_cryptodev_throughput.py b/dts/tests/Test=
Suite_cryptodev_throughput.py
> new file mode 100644
> index 0000000000..871e47ae63
> --- /dev/null
> +++ b/dts/tests/TestSuite_cryptodev_throughput.py
> @@ -0,0 +1,690 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2025 University of New Hampshire
> +
> +"""DPDK cryptodev performance test suite.
> +
> +The main goal of this testsuite is to utilize the dpdk-test-cryptodev ap=
plication to gather
> +performance metrics for various cryptographic operations supported by DP=
DK cryptodev-pmd.
> +It will then compare the results against predefined baseline given in th=
e test_config file to
> +ensure performance standards are met.
> +"""
> +
> +from api.capabilities import (
> +    LinkTopology,
> +    requires_link_topology,
> +)
> +from api.cryptodev import Cryptodev
> +from api.cryptodev.config import (
> +    AeadAlgName,
> +    AuthenticationAlgorithm,
> +    AuthenticationOpMode,
> +    CipherAlgorithm,
> +    DeviceType,
> +    EncryptDecryptSwitch,
> +    ListWrapper,
> +    OperationType,
> +    TestType,
> +    get_device_from_str,
> +)
> +from api.cryptodev.types import (
> +    CryptodevResults,
> +)
> +from api.test import verify
> +from framework.context import get_ctx
> +from framework.exception import SkippedTestException
> +from framework.test_suite import BaseConfig, TestSuite, func_test
> +from framework.testbed_model.virtual_device import VirtualDevice
> +
> +config_list: list[dict[str, int | float | str]] =3D [
> +    {"buff_size": 64, "gbps": 1.00},
> +    {"buff_size": 512, "gbps": 1.00},
> +    {"buff_size": 2048, "gbps": 1.00},
> +]
> +
> +
> +class Config(BaseConfig):
> +    """Performance test metrics.
> +
> +    Attributes:
> +        delta_tolerance: The allowed tolerance below a given baseline.
> +        throughput_test_parameters: The test parameters to use in the te=
st suite.
> +    """
> +
> +    delta_tolerance: float =3D 0.05
> +
> +    throughput_test_parameters: dict[str, list[dict[str, int | float | s=
tr]]] =3D {
> +        "aes_cbc": config_list,
> +        "aes_cbc_sha1": config_list,
> +        "aes_cbc_sha2": config_list,
> +        "aes_cbc_sha2_digest_16": config_list,
> +        "aead_aes_gcm": config_list,
> +        "aes_docsisbpi": config_list,
> +        "sha1_hmac": config_list,
> +        "snow3g_uea2_snow3g_uia2": config_list,
> +        "zuc_eea3_zuc_eia3": config_list,
> +        "kasumi_f8_kasumi_f9": config_list,
> +        "open_ssl_vdev": config_list,
> +        "aesni_mb_vdev": config_list,
> +        "aesni_gcm_vdev": config_list,
> +        "kasumi_vdev": config_list,
> +        "zuc_vdev": config_list,
> +        "snow3g_vdev": config_list,
> +    }
> +
> +
> +@requires_link_topology(LinkTopology.NO_LINK)
> +class TestCryptodevThroughput(TestSuite):
> +    """DPDK Crypto Device Testing Suite."""
> +
> +    config: Config
> +
> +    def set_up_suite(self) -> None:
> +        """Set up the test suite."""
> +        self.throughput_test_parameters: dict[str, list[dict[str, int | =
float | str]]] =3D (
> +            self.config.throughput_test_parameters
> +        )
> +        self.delta_tolerance: float =3D self.config.delta_tolerance
> +        device: DeviceType | None =3D get_device_from_str(str(get_ctx().=
sut_node.crypto_driver))
> +        self.driver: DeviceType =3D device if device else DeviceType.cry=
pto_qat

Why the "else DeviceType.crypto_qat"? Shouldn't the device type be a
required field from the config if we are running a crypto test?

> +        self.buffer_sizes =3D {}
> +
> +        for k, v in self.throughput_test_parameters.items():
> +            self.buffer_sizes[k] =3D ListWrapper([int(run["buff_size"]) =
for run in v])
> +
> +    def _print_stats(self, test_vals: list[dict[str, int | float | str]]=
) -> None:
> +        element_len =3D len("Delta Tolerance")
> +        border_len =3D (element_len + 1) * (len(test_vals[0]))
> +
> +        print(f"{'Throughput Results'.center(border_len)}\n{'=3D' * bord=
er_len}")
> +        for k, v in test_vals[0].items():
> +            print(f"|{k.title():<{element_len}}", end=3D"")
> +        print(f"|\n{'=3D'*border_len}")
> +
> +        for test_val in test_vals:
> +            for k, v in test_val.items():
> +                print(f"|{v:<{element_len}}", end=3D"")
> +            print(f"|\n{'=3D'*border_len}")
> +
> +    def _verify_throughput(
> +        self,
> +        results: list[CryptodevResults],
> +        key: str,
> +    ) -> list[dict[str, int | float | str]]:
> +        result_list: list[dict[str, int | float | str]] =3D []
> +
> +        for result in results:
> +            result_dict =3D {}
> +            parameters: dict[str, int | float | str] =3D list(
> +                filter(
> +                    lambda x: x["buff_size"] =3D=3D result.buffer_size,
> +                    self.throughput_test_parameters[key],
> +                )
> +            )[0]
> +            test_result =3D True
> +            for arg, target_val in parameters.items():

Can you just you a typical "for k, v in parameters.items()"? the name
target_val doesn't really represent both values and it's just
confusing to read in my opinion.

> +                match arg:
> +                    case "buff_size":
> +                        result_dict["Buffer Size"] =3D target_val
> +                        continue
> +                    case "gbps":
> +                        # result did not meet the given gbps parameter, =
check if within delta.
> +                        if target_val > getattr(result, "gbps"):
> +                            delta =3D round((1 - (getattr(result, "gbps"=
) / target_val)), 5)
> +                            if delta > self.delta_tolerance:
> +                                test_result =3D False
> +                        else:
> +                            delta =3D round((1 - target_val / getattr(re=
sult, arg)), 5)

Don't calculate delta once (and in two different ways for that
matter). Start by calculating the delta, and set it to a variable.
Then, you can have your followup business logic do the necessary steps
based on what the delta is. But the first step is to calculate the
delta one time and set it so it can be read for the subsequent steps.

> +                        result_dict["gbps delta"] =3D delta
> +                        result_dict["delta tolerance"] =3D self.delta_to=
lerance
> +                        result_dict["gbps"] =3D getattr(result, "gbps")
> +                        result_dict["gbps target"] =3D target_val
> +            result_dict["passed"] =3D "PASS" if test_result else "FAIL"
> +            result_list.append(result_dict)
> +        return result_list

Overall I think the structure of the logic in this method is a little
confusing but I think it will be okay if you make the change
recommended in my above comment.

> +
> +    @func_test
> +    def aes_cbc(self) -> None:
> +        """aes_cbc test.
> +
> +        Steps:
> +            * Create a cryptodev instance with provided driver and buffe=
r sizes.
> +        Verify:
> +            * The resulting gbps is greater than expected_gbps*(1-delta_=
tolerance).
> +
> +        Raises:
> +            SkippedTestException: When configuration is not provided.
> +        """
> +        if "aes_cbc" not in self.throughput_test_parameters:
> +            raise SkippedTestException("test not configured")
> +        app =3D Cryptodev(
> +            ptest=3DTestType.throughput,
> +            devtype=3Dself.driver,
> +            optype=3DOperationType.cipher_only,
> +            cipher_algo=3DCipherAlgorithm.aes_cbc,
> +            cipher_op=3DEncryptDecryptSwitch.encrypt,
> +            cipher_key_sz=3D16,
> +            cipher_iv_sz=3D16,
> +            total_ops=3D10_000_000,
> +            buffer_sz=3Dself.buffer_sizes["aes_cbc"],
> +        )
> +        results =3D self._verify_throughput(app.run_app(), "aes_cbc")
> +        self._print_stats(results)
> +        for result in results:
> +            verify(result["passed"] =3D=3D "PASS", "gbps fell below delt=
a tolerance")
> +
> +    def aes_cbc_sha1(self) -> None:
> +        """aes_cbc_sha1 test.
> +
> +        Steps:
> +            * Create a cryptodev instance with provided driver and buffe=
r sizes.
> +        Verify:
> +            * The resulting gbps is greater than expected_gbps*(1-delta_=
tolerance).
> +
> +        Raises:
> +            SkippedTestException: When configuration is not provided.
> +        """
> +        if "aes_cbc_sha1" not in self.throughput_test_parameters:
> +            raise SkippedTestException("test not configured")
> +        app =3D Cryptodev(
> +            ptest=3DTestType.throughput,
> +            devtype=3Dself.driver,
> +            optype=3DOperationType.cipher_then_auth,
> +            cipher_algo=3DCipherAlgorithm.aes_cbc,
> +            cipher_op=3DEncryptDecryptSwitch.encrypt,
> +            cipher_key_sz=3D16,
> +            cipher_iv_sz=3D16,
> +            auth_algo=3DAuthenticationAlgorithm.sha1_hmac,
> +            auth_op=3DAuthenticationOpMode.generate,
> +            auth_key_sz=3D64,
> +            auth_iv_sz=3D20,
> +            digest_sz=3D12,
> +            total_ops=3D10_000_000,
> +            buffer_sz=3Dself.buffer_sizes["aes_cbc_sha1"],
> +        )
> +        results =3D self._verify_throughput(app.run_app(), "aes_cbc_sha1=
")
> +        self._print_stats(results)
> +        for result in results:
> +            verify(result["passed"] =3D=3D "PASS", "gbps fell below delt=
a tolerance")
> +
> +    def aes_cbc_sha2(self) -> None:
> +        """aes_cbc_sha2 test.
> +
> +        Steps:
> +            * Create a cryptodev instance with provided driver and buffe=
r sizes.
> +        Verify:
> +            * The resulting gbps is greater than expected_gbps*(1-delta_=
tolerance).
> +
> +        Raises:
> +            SkippedTestException: When configuration is not provided.
> +        """
> +        if "aes_cbc_sha2" not in self.throughput_test_parameters:
> +            raise SkippedTestException("test not configured")
> +        app =3D Cryptodev(
> +            ptest=3DTestType.throughput,
> +            devtype=3Dself.driver,
> +            optype=3DOperationType.cipher_then_auth,
> +            cipher_algo=3DCipherAlgorithm.aes_cbc,
> +            cipher_op=3DEncryptDecryptSwitch.encrypt,
> +            cipher_key_sz=3D16,
> +            cipher_iv_sz=3D16,
> +            auth_algo=3DAuthenticationAlgorithm.sha2_256_hmac,
> +            auth_op=3DAuthenticationOpMode.generate,
> +            auth_key_sz=3D64,
> +            digest_sz=3D32,
> +            total_ops=3D10_000_000,
> +            buffer_sz=3Dself.buffer_sizes["aes_cbc_sha2"],
> +        )
> +        results =3D self._verify_throughput(app.run_app(), "aes_cbc_sha2=
")
> +        self._print_stats(results)
> +        for result in results:
> +            verify(result["passed"] =3D=3D "PASS", "gbps fell below delt=
a tolerance")
> +
> +    @func_test
> +    def aes_cbc_sha2_digest_16(self) -> None:
> +        """aes_cbc_sha2_digest_16 test.
> +
> +        Steps:
> +            * Create a cryptodev instance with provided driver and buffe=
r sizes.
> +        Verify:
> +            * The resulting gbps is greater than expected_gbps*(1-delta_=
tolerance).
> +
> +        Raises:
> +            SkippedTestException: When configuration is not provided.
> +        """
> +        if "aes_cbc_sha2_digest_16" not in self.throughput_test_paramete=
rs:
> +            raise SkippedTestException("test not configured")
> +        app =3D Cryptodev(
> +            ptest=3DTestType.throughput,
> +            devtype=3Dself.driver,
> +            optype=3DOperationType.cipher_then_auth,
> +            cipher_algo=3DCipherAlgorithm.aes_cbc,
> +            cipher_op=3DEncryptDecryptSwitch.encrypt,
> +            cipher_key_sz=3D16,
> +            cipher_iv_sz=3D16,
> +            auth_algo=3DAuthenticationAlgorithm.sha2_256_hmac,
> +            auth_op=3DAuthenticationOpMode.generate,
> +            auth_key_sz=3D64,
> +            digest_sz=3D16,
> +            total_ops=3D10_000_000,
> +            buffer_sz=3Dself.buffer_sizes["aes_cbc_sha2_digest_16"],
> +        )
> +        results =3D self._verify_throughput(app.run_app(), "aes_cbc_sha2=
_digest_16")
> +        self._print_stats(results)
> +        for result in results:
> +            verify(result["passed"] =3D=3D "PASS", "gbps fell below delt=
a tolerance")
> +
> +    @func_test
> +    def aead_aes_gcm(self) -> None:
> +        """aead_aes_gcm test.
> +
> +        Steps:
> +            * Create a cryptodev instance with provided driver and buffe=
r sizes.
> +        Verify:
> +            * The resulting gbps is greater than expected_gbps*(1-delta_=
tolerance).
> +
> +        Raises:
> +            SkippedTestException: When configuration is not provided.
> +        """
> +        if "aead_aes_gcm" not in self.throughput_test_parameters:
> +            raise SkippedTestException("test not configured")
> +        app =3D Cryptodev(
> +            ptest=3DTestType.throughput,
> +            devtype=3Dself.driver,
> +            optype=3DOperationType.aead,
> +            aead_algo=3DAeadAlgName.aes_gcm,
> +            aead_op=3DEncryptDecryptSwitch.encrypt,
> +            aead_key_sz=3D16,
> +            aead_iv_sz=3D12,
> +            aead_aad_sz=3D16,
> +            digest_sz=3D16,
> +            total_ops=3D10_000_000,
> +            buffer_sz=3Dself.buffer_sizes["aead_aes_gcm"],
> +        )
> +        results =3D self._verify_throughput(app.run_app(), "aead_aes_gcm=
")
> +        self._print_stats(results)
> +        for result in results:
> +            verify(result["passed"] =3D=3D "PASS", "gbps fell below delt=
a tolerance")
> +
> +    @func_test
> +    def aes_docsisbpi(self) -> None:
> +        """aes_docsiscpi test.

docsisbpi

> +
> +        Steps:
> +            * Create a cryptodev instance with provided driver and buffe=
r sizes.
> +        Verify:
> +            * The resulting gbps is greater than expected_gbps*(1-delta_=
tolerance).
> +
> +        Raises:
> +            SkippedTestException: When configuration is not provided.
> +        """
> +        if "aes_docsisbpi" not in self.throughput_test_parameters:
> +            raise SkippedTestException("test not configured")
> +        app =3D Cryptodev(
> +            ptest=3DTestType.throughput,
> +            devtype=3Dself.driver,
> +            optype=3DOperationType.cipher_only,
> +            cipher_algo=3DCipherAlgorithm.aes_docsisbpi,
> +            cipher_op=3DEncryptDecryptSwitch.encrypt,
> +            cipher_key_sz=3D32,
> +            cipher_iv_sz=3D16,
> +            total_ops=3D10_000_000,
> +            buffer_sz=3Dself.buffer_sizes["aes_docsisbpi"],
> +        )
> +        results =3D self._verify_throughput(app.run_app(), "aes_docsisbp=
i")
> +        self._print_stats(results)
> +        for result in results:
> +            verify(result["passed"] =3D=3D "PASS", "gbps fell below delt=
a tolerance")
> +
> +    @crypto_test
> +    def sha1_hmac(self) -> None:
> +        """sha1_hmac test.
> +
> +        Steps:
> +            * Create a cryptodev instance with provided driver and buffe=
r sizes.
> +        Verify:
> +            * The resulting gbps is greater than expected_gbps*(1-delta_=
tolerance).
> +
> +        Raises:
> +            SkippedTestException: When configuration is not provided.
> +        """
> +        if "sha1_hmac" not in self.throughput_test_parameters:
> +            raise SkippedTestException("test not configured")
> +        app =3D Cryptodev(
> +            ptest=3DTestType.throughput,
> +            devtype=3Dself.driver,
> +            optype=3DOperationType.auth_only,
> +            auth_algo=3DAuthenticationAlgorithm.sha1_hmac,
> +            auth_op=3DAuthenticationOpMode.generate,
> +            auth_key_sz=3D64,
> +            auth_iv_sz=3D16,
> +            digest_sz=3D12,
> +            total_ops=3D10_000_000,
> +            buffer_sz=3Dself.buffer_sizes["sha1_hmac"],
> +        )
> +        results =3D self._verify_throughput(app.run_app(), "sha1_hmac")
> +        self._print_stats(results)
> +        for result in results:
> +            verify(result["passed"] =3D=3D "PASS", "gbps fell below delt=
a tolerance")
> +
> +    @func_test
> +    def snow3g_uea2_snow3g_uia2(self) -> None:
> +        """snow3g_uea2_snow3g_uia2 test.
> +
> +        Steps:
> +            * Create a cryptodev instance with provided driver and buffe=
r sizes.
> +        Verify:
> +            * The resulting gbps is greater than expected_gbps*(1-delta_=
tolerance).
> +
> +        Raises:
> +            SkippedTestException: When configuration is not provided.
> +        """
> +        if "snow3g_uea2_snow3g_uia2" not in self.throughput_test_paramet=
ers:
> +            raise SkippedTestException("test not configured")
> +        app =3D Cryptodev(
> +            ptest=3DTestType.throughput,
> +            devtype=3Dself.driver,
> +            optype=3DOperationType.cipher_then_auth,
> +            cipher_algo=3DCipherAlgorithm.snow3g_uea2,
> +            cipher_op=3DEncryptDecryptSwitch.encrypt,
> +            cipher_key_sz=3D16,
> +            cipher_iv_sz=3D16,
> +            auth_algo=3DAuthenticationAlgorithm.snow3g_uia2,
> +            auth_op=3DAuthenticationOpMode.generate,
> +            auth_key_sz=3D16,
> +            auth_iv_sz=3D16,
> +            digest_sz=3D4,
> +            total_ops=3D10_000_000,
> +            buffer_sz=3Dself.buffer_sizes["snow3g_uea2_snow3g_uia2"],
> +        )
> +        results =3D self._verify_throughput(app.run_app(), "snow3g_uea2_=
snow3g_uia2")
> +        self._print_stats(results)
> +        for result in results:
> +            verify(result["passed"] =3D=3D "PASS", "gbps fell below delt=
a tolerance")
> +
> +    @func_test
> +    def zuc_eea3_zuc_eia3(self) -> None:
> +        """zuc_eea3_zuc_eia3 test.
> +
> +        Steps:
> +            * Create a cryptodev instance with provided driver and buffe=
r sizes.
> +        Verify:
> +            * The resulting gbps is greater than expected_gbps*(1-delta_=
tolerance).
> +
> +        Raises:
> +            SkippedTestException: When configuration is not provided.
> +        """
> +        if "zuc_eea3_zuc_eia3" not in self.throughput_test_parameters:
> +            raise SkippedTestException("test not configured")
> +        app =3D Cryptodev(
> +            ptest=3DTestType.throughput,
> +            devtype=3Dself.driver,
> +            optype=3DOperationType.cipher_then_auth,
> +            cipher_algo=3DCipherAlgorithm.zuc_eea3,
> +            cipher_op=3DEncryptDecryptSwitch.encrypt,
> +            cipher_key_sz=3D16,
> +            cipher_iv_sz=3D16,
> +            auth_algo=3DAuthenticationAlgorithm.zuc_eia3,
> +            auth_op=3DAuthenticationOpMode.generate,
> +            auth_key_sz=3D16,
> +            auth_iv_sz=3D16,
> +            digest_sz=3D4,
> +            total_ops=3D10_000_000,
> +            buffer_sz=3Dself.buffer_sizes["zuc_eea3_zuc_eia3"],
> +        )
> +        results =3D self._verify_throughput(app.run_app(), "zuc_eea3_zuc=
_eia3")
> +        self._print_stats(results)
> +        for result in results:
> +            verify(result["passed"] =3D=3D "PASS", "gbps fell below delt=
a tolerance")
> +
> +    @func_test
> +    def kasumi_f8_kasumi_f9(self) -> None:
> +        """kasumi_f8 kasumi_f9 test.
> +
> +        Steps:
> +            * Create a cryptodev instance with provided driver and buffe=
r sizes.
> +        Verify:
> +            * The resulting gbps is greater than expected_gbps*(1-delta_=
tolerance).
> +
> +        Raises:
> +            SkippedTestException: When configuration is not provided.
> +        """
> +        if "kasumi_f8_kasumi_f9" not in self.throughput_test_parameters:
> +            raise SkippedTestException("test not configured")
> +        app =3D Cryptodev(
> +            ptest=3DTestType.throughput,
> +            devtype=3Dself.driver,
> +            optype=3DOperationType.cipher_then_auth,
> +            cipher_algo=3DCipherAlgorithm.kasumi_f8,
> +            cipher_op=3DEncryptDecryptSwitch.encrypt,
> +            cipher_key_sz=3D16,
> +            cipher_iv_sz=3D8,
> +            auth_algo=3DAuthenticationAlgorithm.kasumi_f9,
> +            auth_op=3DAuthenticationOpMode.generate,
> +            auth_key_sz=3D16,
> +            digest_sz=3D4,
> +            burst_sz=3D32,
> +            total_ops=3D10_000_000,
> +            buffer_sz=3Dself.buffer_sizes["kasumi_f8_kasumi_f9"],
> +        )
> +        results =3D self._verify_throughput(app.run_app(), "kasumi_f8_ka=
sumi_f9")
> +        self._print_stats(results)
> +        for result in results:
> +            verify(result["passed"] =3D=3D "PASS", "gbps fell below delt=
a tolerance")
> +
> +    # BEGIN VDEV TESTS
> +
> +
> +    def aesni_mb_vdev(self) -> None:
> +        """aesni_mb virtual device test.
> +
> +        Steps:
> +            * Create a cryptodev instance with crypto_aesni_mb and suppl=
ied buffer sizes.
> +        Verify:
> +            * The resulting gbps is greater than expected_gbps*(1-delta_=
tolerance).
> +
> +        Raises:
> +            SkippedTestException: When configuration is not provided.
> +        """
> +        if "aesni_mb_vdev" not in self.throughput_test_parameters:
> +            raise SkippedTestException("test not configured")
> +        app =3D Cryptodev(
> +            ptest=3DTestType.throughput,
> +            vdevs=3D[VirtualDevice("crypto_aesni_mb0")],
> +            devtype=3DDeviceType.crypto_aesni_mb,
> +            optype=3DOperationType.cipher_then_auth,
> +            cipher_algo=3DCipherAlgorithm.aes_cbc,
> +            cipher_op=3DEncryptDecryptSwitch.encrypt,
> +            cipher_key_sz=3D32,
> +            cipher_iv_sz=3D16,
> +            auth_algo=3DAuthenticationAlgorithm.sha1_hmac,
> +            auth_op=3DAuthenticationOpMode.generate,
> +            auth_key_sz=3D16,
> +            auth_iv_sz=3D16,
> +            digest_sz=3D4,
> +            burst_sz=3D32,
> +            total_ops=3D10_000_000,
> +            buffer_sz=3Dself.buffer_sizes["aesni_mb_vdev"],
> +        )
> +        results =3D self._verify_throughput(app.run_app(), "aesni_mb_vde=
v")
> +        self._print_stats(results)
> +        for result in results:
> +            verify(result["passed"] =3D=3D "PASS", "gbps fell below delt=
a tolerance")
> +
> +    @func_test
> +    def aesni_gcm_vdev(self):
> +        """aesni_gcm virtual device test.
> +
> +        Steps:
> +            * Create a cryptodev instance with crypto_aesni_gcm and supp=
lied buffer sizes.
> +        Verify:
> +            * The resulting gbps is greater than expected_gbps*(1-delta_=
tolerance).
> +
> +        Raises:
> +            SkippedTestException: When configuration is not provided.
> +        """
> +        if "aesni_gcm_vdev" not in self.throughput_test_parameters:
> +            raise SkippedTestException("test not configured")
> +        app =3D Cryptodev(
> +            ptest=3DTestType.throughput,
> +            vdevs=3D[VirtualDevice("crypto_aesni_gcm0")],
> +            devtype=3DDeviceType.crypto_aesni_gcm,
> +            optype=3DOperationType.aead,
> +            aead_algo=3DAeadAlgName.aes_gcm,
> +            aead_op=3DEncryptDecryptSwitch.encrypt,
> +            aead_key_sz=3D16,
> +            aead_iv_sz=3D12,
> +            aead_aad_sz=3D16,
> +            digest_sz=3D16,
> +            total_ops=3D10_000_000,
> +            buffer_sz=3Dself.buffer_sizes["aesni_gcm_vdev"],
> +        )
> +        results =3D self._verify_throughput(app.run_app(), "aesni_gcm_vd=
ev")
> +        self._print_stats(results)
> +        for result in results:
> +            verify(result["passed"] =3D=3D "PASS", "gbps fell below delt=
a tolerance")
> +
> +    @func_test
> +    def kasumi_vdev(self) -> None:
> +        """Kasmumi virtual device test.
> +
> +        Steps:
> +            * Create a cryptodev instance with crypto_kasumi and supplie=
d buffer sizes.
> +        Verify:
> +            * The resulting gbps is greater than expected_gbps*(1-delta_=
tolerance).
> +
> +        Raises:
> +            SkippedTestException: When configuration is not provided.
> +        """
> +        if "kasumi_vdev" not in self.throughput_test_parameters:
> +            raise SkippedTestException("test not configured")
> +        app =3D Cryptodev(
> +            vdevs=3D[VirtualDevice("crypto_kasumi0")],
> +            ptest=3DTestType.throughput,
> +            devtype=3DDeviceType.crypto_qat,

Should this be crypto_kasumi?

> +            optype=3DOperationType.cipher_then_auth,
> +            cipher_algo=3DCipherAlgorithm.kasumi_f8,
> +            cipher_op=3DEncryptDecryptSwitch.encrypt,
> +            cipher_key_sz=3D16,
> +            cipher_iv_sz=3D8,
> +            auth_algo=3DAuthenticationAlgorithm.kasumi_f9,
> +            auth_op=3DAuthenticationOpMode.generate,
> +            auth_key_sz=3D16,
> +            digest_sz=3D4,
> +            burst_sz=3D32,
> +            total_ops=3D10_000_000,
> +            buffer_sz=3Dself.buffer_sizes["kasumi_vdev"],
> +        )
> +        results =3D self._verify_throughput(app.run_app(), "kasumi_vdev"=
)
> +        self._print_stats(results)
> +        for result in results:
> +            verify(result["passed"] =3D=3D "PASS", "gbps fell below delt=
a tolerance")
> +
> +    @func_test
> +    def snow3g_vdev(self) -> None:
> +        """snow3g virtual device test.
> +
> +        Steps:
> +            * Create a cryptodev instance with crypto_snow3g and supplie=
d buffer sizes.
> +        Verify:
> +            * The resulting gbps is greater than expected_gbps*(1-delta_=
tolerance).
> +
> +        Raises:
> +            SkippedTestException: When configuration is not provided.
> +        """
> +        if "snow3g_vdev" not in self.throughput_test_parameters:
> +            raise SkippedTestException("test not configured")
> +        app =3D Cryptodev(
> +            ptest=3DTestType.throughput,
> +            vdevs=3D[VirtualDevice("crypto_snow3g0")],
> +            devtype=3DDeviceType.crypto_snow3g,
> +            optype=3DOperationType.cipher_then_auth,
> +            cipher_algo=3DCipherAlgorithm.snow3g_uea2,
> +            cipher_op=3DEncryptDecryptSwitch.encrypt,
> +            cipher_key_sz=3D16,
> +            cipher_iv_sz=3D16,
> +            auth_algo=3DAuthenticationAlgorithm.snow3g_uia2,
> +            auth_op=3DAuthenticationOpMode.generate,
> +            auth_key_sz=3D16,
> +            auth_iv_sz=3D16,
> +            digest_sz=3D4,
> +            burst_sz=3D32,
> +            total_ops=3D10_000_000,
> +            buffer_sz=3Dself.buffer_sizes["snow3g_vdev"],
> +        )
> +        results =3D self._verify_throughput(app.run_app(), "snow3g_vdev"=
)
> +        self._print_stats(results)
> +        for result in results:
> +            verify(result["passed"] =3D=3D "PASS", "gpbs fell below delt=
a tolerance")

gpbs -> gbps

Also switch to Gbps instead of gbps throughout the suite for error
strings and docstrings (code is okay to be lowercase).

> +
> +    @func_test
> +    def zuc_vdev(self) -> None:
> +        """Zuc virtual device test.
> +
> +        Steps:
> +            * Create a cryptodev instance with crypto_zuc and supplied b=
uffer sizes.
> +        Verify:
> +            * The resulting gbps is greater than expected_gbps*(1-delta_=
tolerance).
> +
> +        Raises:
> +            SkippedTestException: When configuration is not provided.
> +        """
> +        if "zuc_vdev" not in self.throughput_test_parameters:
> +            raise SkippedTestException("test not configured")
> +        app =3D Cryptodev(
> +            ptest=3DTestType.throughput,
> +            vdevs=3D[VirtualDevice("crypto_zuc0")],
> +            devtype=3DDeviceType.crypto_zuc,
> +            optype=3DOperationType.cipher_then_auth,
> +            cipher_algo=3DCipherAlgorithm.zuc_eea3,
> +            cipher_op=3DEncryptDecryptSwitch.encrypt,
> +            cipher_key_sz=3D16,
> +            cipher_iv_sz=3D16,
> +            auth_algo=3DAuthenticationAlgorithm.zuc_eia3,
> +            auth_op=3DAuthenticationOpMode.generate,
> +            auth_key_sz=3D16,
> +            auth_iv_sz=3D16,
> +            digest_sz=3D4,
> +            burst_sz=3D32,
> +            total_ops=3D10_000_000,

Maybe set 10_000_00 to a variable which can be referenced in each testsuite=
?

> +            buffer_sz=3Dself.buffer_sizes["zuc_vdev"],
> +        )
> +        results =3D self._verify_throughput(app.run_app(), "zuc_vdev")
> +        self._print_stats(results)
> +        for result in results:
> +            verify(result["passed"] =3D=3D "PASS", "gpbs fell below delt=
a tolerance")

Gbps

> +
> +    @func_test
> +    def open_ssl_vdev(self) -> None:
> +        """open_ssl virtual device test.
> +
> +        Steps:
> +            * Create a cryptodev instance with provided driver and buffe=
r sizes.
> +        Verify:
> +            * The resulting gbps is greater than expected_gbps*(1-delta_=
tolerance).
> +
> +        Raises:
> +            SkippedTestException: When configuration is not provided.
> +        """
> +        if "open_ssl_vdev" not in self.throughput_test_parameters:
> +            raise SkippedTestException("test not configured")
> +        app =3D Cryptodev(
> +            ptest=3DTestType.throughput,
> +            vdevs=3D[VirtualDevice("crypto_openssl0")],
> +            devtype=3DDeviceType.crypto_openssl,
> +            optype=3DOperationType.aead,
> +            aead_algo=3DAeadAlgName.aes_gcm,
> +            aead_op=3DEncryptDecryptSwitch.encrypt,
> +            aead_key_sz=3D16,
> +            aead_iv_sz=3D16,
> +            aead_aad_sz=3D16,
> +            digest_sz=3D16,
> +            total_ops=3D100_000,

I'm guessing there is a reason but why fewer ops for this test? Just curiou=
s.

> +            buffer_sz=3Dself.buffer_sizes["open_ssl_vdev"],
> +        )
> +        results =3D self._verify_throughput(app.run_app(), "open_ssl_vde=
v")
> +        self._print_stats(results)
> +        for result in results:
> +            verify(
> +                result["passed"] =3D=3D "PASS",
> +                "gbps fell below delta tolerance",
> +            )
> --
> 2.50.1
>


I noticed that for the VF creation, the crypto interface is being read
3x. Are there 1-2 additional checks happening, or are we just hitting
these code paths multiple times for good reason? Maybe not, I'm just
checking if there are any inadvertent calls. I guess this is a matter
for the 2/5 patch though:

2026/02/26 04:44:46 - test_run_setup - dts.SUT 1 - INFO - Sending:
'sudo -- sh -c 'cat /sys/bus/pci/devices/0000\:76\:00.0/sriov_numvfs''
2026/02/26 04:44:46 - test_run_setup - dts.SUT 1 - INFO - Sending:
'sudo -- sh -c 'cat /sys/bus/pci/devices/0000\:76\:00.0/sriov_numvfs''
2026/02/26 04:44:47 - test_run_setup - dts.SUT 1 - INFO - Sending:
'sudo -- sh -c 'cat /sys/bus/pci/devices/0000\:76\:00.0/sriov_numvfs''

Reviewed-by: Patrick Robb <probb@iol.unh.edu>
