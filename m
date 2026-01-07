Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D003DD0D178
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Jan 2026 22:27:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98F6A4028B;
	Wed,  7 Jan 2026 23:27:56 +0100 (CET)
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by mails.dpdk.org (Postfix) with ESMTP id 9CDFF4021E
 for <dev@dpdk.org>; Wed,  7 Jan 2026 23:27:54 +0100 (CET)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-121b14efeb8so4256223c88.1
 for <dev@dpdk.org>; Wed, 07 Jan 2026 14:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1767824873; x=1768429673; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9NTmXykCF9FLd3I9t34UqSziV/0qIOMfNF13/2BAWII=;
 b=hSFagxtUrzOn4dqMSGNgfCg4dBKpsIzxZ6rYApCNwVeFbuXDrxLhvJItUMtZAFKbn7
 dOpnP7CCVaTprkwCEmpkH1Wc747amLdPjzmuKlRAhCVHJ7No5bXTGn2qSMOYhwovcUaX
 988eCeAinRCVxZO0M17OT48Y9glm9yyEqDvOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767824873; x=1768429673;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9NTmXykCF9FLd3I9t34UqSziV/0qIOMfNF13/2BAWII=;
 b=gdGw/9Fz/Thde8MSJHXh2ETe2YeCmUByFY4O9Qlde477fpWGSPkQxvJ3R5zKx+OM2h
 pE5qTmO1VyUG9/goYoNaBoidgPBfUH/inGJp0nwC6toENcdErLE+kL/hkOnIJa8Vnd+D
 AFWiLyxYz4NuEUBXFwRXSRGldYEVtaPmDpo7s6zqfJvH6SrygK9U9kJvVSGv/HJ3ivDY
 EU3aSKNp+DGLp+Rv7umYf54Ll2LjzRJ04FBWTFwY48FnuH1s+Cdav+Qshxh7ztX7d7Lv
 vjXeIrEJcKK2cAtbi5hhrMf5hpxMtKbia0mInKKPm0+xBX90B7oRQSI0OWDwy/1dC0e5
 os7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUCbjhDhxry7ODzHYbtaZ6riZDgb/16Ekr4EO/3tO1kpr5Wedij02kReSDwvWy9l1FmEI=@dpdk.org
X-Gm-Message-State: AOJu0YwVOy38oWCpyV2397LiYkwIbBQZUwHm6jh3Wdklz7L5ARdnodI1
 XfZ0CcztYVPWWlNL8j/e7ZvgM7xk/4goyGDTjbRMeeurGNANGkSWoZxQxVxNVLjJpCPV4YV85W+
 qQrv+QyiY8ftnI2PetT4kWc3x+G5H2wogq1R/aEoC7w==
X-Gm-Gg: AY/fxX5tujqnHHR2SGpDRvxEkjFkvSEZVzWya26m8GbbzKZhrb+EKi1BPhJrBeisxs3
 B7PhItl84eGd4l0J0p1qAzJEXIQZs+DAR/zR0foE2LcouEcfYN0BAXgBxL6vx/Iu4KzGh9Ll/hD
 JksftdYKuKGSkW1QWJhmXvz3woIZl+ATeE1kKUe4ryWE9372ZEeQBYgzGl1ZbKGWQPFgcmK379e
 4DFQyTNjtTAOlzVRsxT7HwIJ3oPp52rFf8Z8kFAlK8cU6+NDtgauTACJIypgc6O5eYIDuWJj2uj
 UBf2uiyygdafA1CYbbGP2wco1hNG
X-Google-Smtp-Source: AGHT+IFXT2XJtkz6EDfU53+ssT9K2Mw8OpOeaNXb2UBAvQNzyVKC3gsaAuuMCHMbK70bCxBEFIaZaL3mD9RWqlFcM+c=
X-Received: by 2002:a05:7022:2492:b0:119:e56b:9590 with SMTP id
 a92af1059eb24-121f8afc1acmr3427549c88.21.1767824873315; Wed, 07 Jan 2026
 14:27:53 -0800 (PST)
MIME-Version: 1.0
References: <20260105190647.63244-1-abailey@iol.unh.edu>
 <20260105190647.63244-3-abailey@iol.unh.edu>
In-Reply-To: <20260105190647.63244-3-abailey@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 7 Jan 2026 17:25:49 -0500
X-Gm-Features: AQt7F2qq1weLe8kjbou4Gjzq8Je_zmB3hPPlxtV7wAutuxeO4MKP4fcfsx0ixDI
Message-ID: <CAJvnSUBTtGyQ7WtE9GF-gawS=A8rHAqcaqTSo8eWYa+GBkhRwg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] dts: add cryptodev testsuite
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dmarx@iol.unh.edu, dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000009971a90647d3cdb5"
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

--0000000000009971a90647d3cdb5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 2:06=E2=80=AFPM Andrew Bailey <abailey@iol.unh.edu> =
wrote:

> Add cryptodev performance testsuite, which runs the dpdk-test-crypto
> application and verifies output to user specified metrics.
>

Can you explain your approach with a little more verbosity in the commit
message?

What kinds of devices do you want to test?

Which types of operations?

Are these tests functional or performance?

what combinations of algo/device/ops are being tested and why (I realize
this may still be an open question for this specific testsuite)?

etc.


>
> Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
> ---
>  dts/tests/TestSuite_cryptodev_throughput.py | 460 ++++++++++++++++++++
>  1 file changed, 460 insertions(+)
>  create mode 100644 dts/tests/TestSuite_cryptodev_throughput.py
>
> diff --git a/dts/tests/TestSuite_cryptodev_throughput.py
> b/dts/tests/TestSuite_cryptodev_throughput.py
> new file mode 100644
> index 0000000000..adc7b01b99
> --- /dev/null
> +++ b/dts/tests/TestSuite_cryptodev_throughput.py
> @@ -0,0 +1,460 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2025 University of New Hampshire
> +"""DPDK cryptodev performance test suite.
> +
> +The main goal of this testsuite is to utilize the dpdk-test-cryptodev
> application to gather
> +performance metrics for various cryptographic operations supported by
> DPDK cryptodev-pmd.
> +It will then compare the results against predefined thresholds defined i=
n
> the test_config file to
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
> +)
> +from api.cryptodev.types import (
> +    CryptodevResults,
> +)
> +from api.test import verify
> +from framework.test_suite import BaseConfig, TestSuite, func_test
> +from framework.testbed_model.virtual_device import VirtualDevice
> +
> +
> +class Config(BaseConfig):
> +    """Performance test metrics."""
> +
> +    throughput_test_parameters: dict[str, int | float] =3D {
> +        "enqueued": 0,
> +        "dequeued": 0,
> +        "failed_enqueued": 0,
> +        "failed_dequeued": 0,
> +        "mops": 0,
> +        "gbps": 0,
> +        "cycles_per_buffer": 0,
> +    }
> +
> +
> +@requires_link_topology(LinkTopology.NO_LINK)
> +class TestCryptodevThroughput(TestSuite):
> +    """DPDK Crypto Device Testing Suite.
> +
> +    This test suite is comprised of 8 test cases:
> +    1. verify throughput metrics of openssl encrypt virtual device with
> aes-gcm algorithm
> +    2. verify throughput metrics of QAT device encrypt with aes-cbc
> cipher algorithm and sha256-hmac
> +        auth algorithm
> +    3. verify throughput metrics of QAT device encrypt with aes-gcm aead
> algorithm
> +    4. verify throughput metrics of QAT device decrypt with aes-docsibpi
> cipher algorithm
> +    5. verify throughput metrics of QAT device encrypt with aes-docsibpi
> cipher algorithm
> +    6. verify throughput metrics of QAT device encrypt with kasumi-f8
> cipher algorithm and kasumi-f9
> +        auth algorithm
> +    7. verify throughput metrics of QAT device encrypt with snow3g-uea2
> cipher algorithm and
> +        snow3g-uia2 auth algorithm
> +    8. verify throughput metrics of QAT device encrypt with zuc-eea3
> cipher algorithm and zuc-eia3
> +        auth algorithm
>

Testcases should most likely be device agnostic. I.e. the dpdk-crypto-perf
app should be able to perform encrypt/decrypt with algorithm X with any
device that supports X, not just a QAT series crypto device.


> +    """
> +
> +    config: Config
> +    unsupported_cryptodevs: list[DeviceType] =3D []
> +
> +    def set_up_suite(self) -> None:
> +        """Set up the test suite.
> +
> +        Setup: Retrieve application parameters from the configuration.
> +        """
> +        self.throughput_test_parameters =3D
> self.config.throughput_test_parameters
> +
> +    def _verify_throughput(self, results: list[CryptodevResults]) -> Non=
e:
> +        """Verify throughput results against predefined thresholds.
>

Can you use the term baseline instead of threshold?


> +
> +        Arguments:
> +            results: The results containing throughput metrics to verify=
.
> +        """
> +        for result in results:
> +            for key, value in self.throughput_test_parameters.items():
> +                result_value =3D getattr(result, key, None)
> +                if result_value is not None:
> +                    verify(
> +                        result_value > value,
> +                        f"Throughput metric {key} is below the threshold=
:
> {result_value} < {value}",
> +                    )
>

2 possible issues:

1. I think we need to have some "delta tolerance" I assume. I.e. the test
probably won't produce the literal same amount of operations as expected
form the baseline, it might be +1% or -1% etc. So, either bake in some
delta tolerance (like the 5% we use for ethdev performance testing) or
allow a delta tolerance to be passed in via config (with a default value as
well of course).

2. I think the way this will work as written is the first time it meets a
key/value which does not meet the baseline, verify will fail the testsuite.
This is okay but we want to log the entire table of results before calling
verify, so that the person running the testsuite can see the whole table
from results. If 3 of the values are failing, we want to ensure they can
see all 3, not just the first one. Let me know if this doesn't make sense.


> +
> +    def _run_app(self, app: Cryptodev) -> None:
> +        """Run the given cryptodev application, print statistics, and
> verify throughput.
> +
> +        Arguments:
> +            app: The cryptodev application to run and collect data on.
> +
> +        Raises:
> +            SkippedTestException: If the cryptodev application cannot be
> run with the given
> +                configuration.
> +        """
> +        print("UNSUPPORTED CRYPTO DEVS:", self.unsupported_cryptodevs)
> +        try:
> +            results: list[CryptodevResults] =3D app.run_app()
> +        except Exception as e:
> +            if "devtype" in str(e):
> +
> self.unsupported_cryptodevs.append(app._app_params["devtype"])


Just checking that I understand the problem and solution. A use may try to
run the test with a BDF pointing to a device which dpdk-crypto-perf does
not support, right? However, don't we just need to indicate that at the
time when dpdk-crypto-perf does not start, instead of re-printing it every
time we do a subsequent run of dpdk-crypto-perf? Maybe we can talk in
person.


> +            print(f"Skipping test: {e}")
> +            raise
> +        app.print_stats(results)
> +        self._verify_throughput(results)
> +
> +    @func_test
> +    def openssl_aead_aes_gcm_encrypt(self) -> None:
> +        """Basic test to run on all NICs with openssl virtual device.
>

I don't know about the description above because the testing is being run
on the vdev, not any NIC (which really isn't involved in the test).

I see from DPDK docs that crypto_openssl vdev supports aead aes-gcm, but so
do the physical devices, and you have a separate QAT case like the openssl
one above (and maybe this is a good solution). Is the idea to have a
testcase per device (physical or virtual) per algo?
https://doc.dpdk.org/guides-25.11/cryptodevs/overview.html#supported-aead-a=
lgorithms


> +
> +        Steps:
> +            * Create a Cryptodev application instance with OpenSSL
> virtual device
> +            * Run the application and gather throughput statistics
> +
> +        Verify:
> +            * Throughput results meet predefined thresholds
> +        """
> +        app =3D Cryptodev(
> +            vdevs=3D[VirtualDevice("crypto_openssl")],
> +            ptest=3DTestType.throughput,
> +            devtype=3DDeviceType.crypto_openssl,
> +            aead_algo=3DAeadAlgName.aes_gcm,
> +            aead_aad_sz=3D16,
> +            aead_key_sz=3D16,
> +            aead_iv_sz=3D16,
> +            digest_sz=3D16,
> +            aead_op=3DEncryptDecryptSwitch.encrypt,
> +            optype=3DOperationType.aead,
> +            total_ops=3D10_000_000,
> +        )
> +        self._run_app(app)
> +
> +    @func_test
> +    def qat_cipher_then_auth_aes_cbc_encrypt(self) -> None:
> +        """Test throughput on a QAT device with aes-cbc and sha2-256-hma=
c
> algorithms.
> +
> +        Steps:
> +            * Create a Cryptodev application instance with QAT device
> +                and cipher_then_auth operation with aes-cbc and
> sha2-256-hmac algorithms
> +            * Run the application and gather throughput statistics
> +
> +        Verify:
> +            * Throughput results meet predefined thresholds
> +        """
> +        app =3D Cryptodev(
> +            ptest=3DTestType.throughput,
> +            devtype=3DDeviceType.crypto_qat,
> +            optype=3DOperationType.cipher_then_auth,
>

args should be ordered the same way for each instantiation of Cryptodev
even if you are using named args. I.e. no optype as a final arg for the
previous test and as one of the first for this test.


> +            cipher_algo=3DCipherAlgorithm.aes_cbc,
> +            cipher_op=3DEncryptDecryptSwitch.encrypt,
> +            cipher_key_sz=3D16,
> +            cipher_iv_sz=3D16,
> +            auth_algo=3DAuthenticationAlgorithm.sha2_256_hmac,
> +            auth_op=3DAuthenticationOpMode.generate,
> +            auth_key_sz=3D64,
> +            digest_sz=3D32,
> +            total_ops=3D10_000_000,
> +            burst_sz=3D32,
> +            buffer_sz=3DListWrapper([64, 128, 256, 512, 1024, 2048]),
> +        )
> +        self._run_app(app)
> +
> +    @func_test
> +    def qat_aead_aes_gcm_encrypt(self) -> None:
> +        """Test throughput on a QAT device with aes-gcm algorithm.
> +
> +        Steps:
> +            * Create a Cryptodev application instance with QAT device
> +                and aead operation with aes-gcm algorithm
> +            * Run the application and gather throughput statistics
> +
> +        Verify:
> +            * Throughput results meet predefined thresholds
> +        """
> +        app =3D Cryptodev(
> +            ptest=3DTestType.throughput,
> +            devtype=3DDeviceType.crypto_qat,
> +            optype=3DOperationType.aead,
> +            aead_aad_sz=3D16,
> +            aead_key_sz=3D16,
> +            aead_iv_sz=3D12,
> +            aead_op=3DEncryptDecryptSwitch.encrypt,
> +            aead_algo=3DAeadAlgName.aes_gcm,
> +            digest_sz=3D16,
> +            total_ops=3D10_000_000,
> +            burst_sz=3D32,
> +            buffer_sz=3DListWrapper([64, 128, 256, 512, 1024, 2048]),
> +        )
> +        self._run_app(app)
> +
> +    @func_test
> +    def qat_cipher_aes_docsisbpi_decrypt(self) -> None:
> +        """Test throughput on a QAT device with aes-docsibpi algorithm.
> +
> +        Steps:
> +            * Create a Cryptodev application instance with QAT device
> +                and cipher_only operation with aes-docsibpi algorithm
> +            * Run the application and gather throughput statistics
> +
> +        Verify:
> +            * Throughput results meet predefined thresholds
> +        """
> +        app =3D Cryptodev(
> +            ptest=3DTestType.throughput,
> +            devtype=3DDeviceType.crypto_qat,
> +            optype=3DOperationType.cipher_only,
> +            cipher_algo=3DCipherAlgorithm.aes_docsisbpi,
> +            cipher_op=3DEncryptDecryptSwitch.decrypt,
> +            cipher_key_sz=3D32,
> +            cipher_iv_sz=3D16,
> +            burst_sz=3D32,
> +            buffer_sz=3DListWrapper([40, 64, 70, 128, 256, 512, 1024,
> 2048]),
> +            total_ops=3D10_000_000,
> +        )
> +        self._run_app(app)
> +
> +    @func_test
> +    def qat_cipher_aes_docsisbpi_encrypt(self) -> None:
> +        """Test throughput on a QAT device with aes-docsibpi algorithm.
> +
> +        Steps:
> +            * Create a Cryptodev application instance with QAT device
> +                and cipher_only operation with aes-docsibpi algorithm
> +            * Run the application and gather throughput statistics
> +
> +        Verify:
> +            * Throughput results meet predefined thresholds
> +        """
> +        app =3D Cryptodev(
> +            ptest=3DTestType.throughput,
> +            devtype=3DDeviceType.crypto_qat,
> +            optype=3DOperationType.cipher_only,
> +            cipher_algo=3DCipherAlgorithm.aes_docsisbpi,
> +            cipher_op=3DEncryptDecryptSwitch.encrypt,
> +            cipher_key_sz=3D32,
> +            cipher_iv_sz=3D16,
> +            burst_sz=3D32,
> +            buffer_sz=3DListWrapper([40, 64, 70, 128, 256, 512, 1024,
> 2048]),
> +            total_ops=3D10_000_000,
> +        )
> +        self._run_app(app)
> +
> +    @func_test
> +    def qat_cipher_then_auth_kasumi_f8_encrypt(self) -> None:
> +        """Test throughput on a QAT device with kasumi-f8 and kasumi-f9
> algorithms.
> +
> +        Steps:
> +            * Create a Cryptodev application instance with QAT device
> +                and cipher_then_auth operation with kasumi-f8 and
> kasumi-f9 algorithms
> +            * Run the application and gather throughput statistics
> +
> +        Verify:
> +            * Throughput results meet predefined thresholds
> +        """
> +        app =3D Cryptodev(
> +            ptest=3DTestType.throughput,
> +            devtype=3DDeviceType.crypto_qat,
> +            optype=3DOperationType.cipher_then_auth,
> +            cipher_algo=3DCipherAlgorithm.kasumi_f8,
> +            cipher_op=3DEncryptDecryptSwitch.encrypt,
> +            cipher_key_sz=3D16,
> +            cipher_iv_sz=3D8,
> +            auth_algo=3DAuthenticationAlgorithm.kasumi_f9,
> +            auth_op=3DAuthenticationOpMode.generate,
> +            auth_key_sz=3D16,
> +            digest_sz=3D4,
> +            total_ops=3D10_000_000,
> +            burst_sz=3D32,
> +            buffer_sz=3DListWrapper([64, 128, 256, 512, 1024, 2048]),
> +        )
> +        self._run_app(app)
> +
> +    @func_test
> +    def qat_cipher_then_auth_snow3g_uea2_encrpyt(self) -> None:
> +        """Test throughput on a QAT device with snow3g-uea2 and
> snow3g-uia2 algorithms.
> +
> +        Steps:
> +            * Create a Cryptodev application instance with QAT device
> +                and cipher_then_auth operation with snow3g-uea2 and
> snow3g-uia2 algorithms
> +            * Run the application and gather throughput statistics
> +
> +        Verify:
> +            * Throughput results meet predefined thresholds
> +        """
> +        app =3D Cryptodev(
> +            ptest=3DTestType.throughput,
> +            devtype=3DDeviceType.crypto_qat,
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
> +            burst_sz=3D32,
> +            buffer_sz=3DListWrapper([64, 128, 256, 512, 1024, 2048]),
> +        )
> +        self._run_app(app)
> +
> +    @func_test
> +    def qat_cipher_then_auth_zuc_eea3_encrypt(self) -> None:
> +        """Test throughput on a QAT device with zuc-eea3 and zuc-eia3
> algorithms.
> +
> +        Steps:
> +            * Create a Cryptodev application instance with QAT device
> +                and cipher_then_auth operation with zuc-eea3 and zuc-eia=
3
> algorithms
> +            * Run the application and gather throughput statistics
> +
> +        Verify:
> +            * Throughput results meet predefined thresholds
> +        """
> +        app =3D Cryptodev(
> +            ptest=3DTestType.throughput,
> +            devtype=3DDeviceType.crypto_qat,
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
> +            burst_sz=3D32,
> +            buffer_sz=3DListWrapper([64, 128, 256, 512, 1024, 2048]),
> +        )
> +        self._run_app(app)
> +
> +    @func_test
> +    def a_wrong_devtype(self) -> None:
>

Can you explain the name of this test and its purpose?


> +        """Test throughput on a QAT device.
> +
> +        Steps:
> +            * Create a Cryptodev application instance with QAT device
> +                and cipher_then_auth operation with aes-cbc and
> sha2-256-hmac algorithms
> +            * Run the application and gather throughput statistics
> +
> +        Verify:
> +            * Throughput results meet predefined thresholds
> +        """
> +        app =3D Cryptodev(
> +            ptest=3DTestType.throughput,
> +            devtype=3DDeviceType.crypto_mvsam,
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
> +            burst_sz=3D32,
> +            buffer_sz=3DListWrapper([64, 128, 256, 512, 1024, 2048]),
> +        )
> +        self._run_app(app)
> +
> +    @func_test
> +    def anotha_one(self) -> None:
>

... I'm glad we're in the RFC period!


> +        """Test throughput on a QAT device.
>
>
>

--0000000000009971a90647d3cdb5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jan 5, 2026 =
at 2:06=E2=80=AFPM Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.unh.edu"=
 target=3D"_blank">abailey@iol.unh.edu</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">Add cryptodev performance testsuite, =
which runs the dpdk-test-crypto<br>
application and verifies output to user specified metrics.<br></blockquote>=
<div><br></div><div>Can you explain your approach with a little more verbos=
ity in the commit message?</div><div><br></div><div>What kinds of devices d=
o you want to test?</div><div><br></div><div>Which types of operations?</di=
v><div><br></div><div>Are these tests functional or performance?</div><div>=
<br></div><div>what combinations of algo/device/ops are being tested and wh=
y (I realize this may still be an open question for this specific testsuite=
)?</div><div><br></div><div>etc.</div><div>=C2=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
<br>
Signed-off-by: Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.unh.edu" tar=
get=3D"_blank">abailey@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0dts/tests/TestSuite_cryptodev_throughput.py | 460 +++++++++++++++++++=
+<br>
=C2=A01 file changed, 460 insertions(+)<br>
=C2=A0create mode 100644 dts/tests/TestSuite_cryptodev_throughput.py<br>
<br>
diff --git a/dts/tests/TestSuite_cryptodev_throughput.py b/dts/tests/TestSu=
ite_cryptodev_throughput.py<br>
new file mode 100644<br>
index 0000000000..adc7b01b99<br>
--- /dev/null<br>
+++ b/dts/tests/TestSuite_cryptodev_throughput.py<br>
@@ -0,0 +1,460 @@<br>
+# SPDX-License-Identifier: BSD-3-Clause<br>
+# Copyright(c) 2025 University of New Hampshire<br>
+&quot;&quot;&quot;DPDK cryptodev performance test suite.<br>
+<br>
+The main goal of this testsuite is to utilize the dpdk-test-cryptodev appl=
ication to gather<br>
+performance metrics for various cryptographic operations supported by DPDK=
 cryptodev-pmd.<br>
+It will then compare the results against predefined thresholds defined in =
the test_config file to<br>
+ensure performance standards are met.<br>
+&quot;&quot;&quot;<br>
+<br>
+from api.capabilities import (<br>
+=C2=A0 =C2=A0 LinkTopology,<br>
+=C2=A0 =C2=A0 requires_link_topology,<br>
+)<br>
+from api.cryptodev import Cryptodev<br>
+from api.cryptodev.config import (<br>
+=C2=A0 =C2=A0 AeadAlgName,<br>
+=C2=A0 =C2=A0 AuthenticationAlgorithm,<br>
+=C2=A0 =C2=A0 AuthenticationOpMode,<br>
+=C2=A0 =C2=A0 CipherAlgorithm,<br>
+=C2=A0 =C2=A0 DeviceType,<br>
+=C2=A0 =C2=A0 EncryptDecryptSwitch,<br>
+=C2=A0 =C2=A0 ListWrapper,<br>
+=C2=A0 =C2=A0 OperationType,<br>
+=C2=A0 =C2=A0 TestType,<br>
+)<br>
+from api.cryptodev.types import (<br>
+=C2=A0 =C2=A0 CryptodevResults,<br>
+)<br>
+from api.test import verify<br>
+from framework.test_suite import BaseConfig, TestSuite, func_test<br>
+from framework.testbed_model.virtual_device import VirtualDevice<br>
+<br>
+<br>
+class Config(BaseConfig):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Performance test metrics.&quot;&quot;&quot=
;<br>
+<br>
+=C2=A0 =C2=A0 throughput_test_parameters: dict[str, int | float] =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;enqueued&quot;: 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;dequeued&quot;: 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;failed_enqueued&quot;: 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;failed_dequeued&quot;: 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;mops&quot;: 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;gbps&quot;: 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;cycles_per_buffer&quot;: 0,<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+<br>
+@requires_link_topology(LinkTopology.NO_LINK)<br>
+class TestCryptodevThroughput(TestSuite):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;DPDK Crypto Device Testing Suite.<br>
+<br>
+=C2=A0 =C2=A0 This test suite is comprised of 8 test cases:<br>
+=C2=A0 =C2=A0 1. verify throughput metrics of openssl encrypt virtual devi=
ce with aes-gcm algorithm<br>
+=C2=A0 =C2=A0 2. verify throughput metrics of QAT device encrypt with aes-=
cbc cipher algorithm and sha256-hmac<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 auth algorithm<br>
+=C2=A0 =C2=A0 3. verify throughput metrics of QAT device encrypt with aes-=
gcm aead algorithm<br>
+=C2=A0 =C2=A0 4. verify throughput metrics of QAT device decrypt with aes-=
docsibpi cipher algorithm<br>
+=C2=A0 =C2=A0 5. verify throughput metrics of QAT device encrypt with aes-=
docsibpi cipher algorithm<br>
+=C2=A0 =C2=A0 6. verify throughput metrics of QAT device encrypt with kasu=
mi-f8 cipher algorithm and kasumi-f9<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 auth algorithm<br>
+=C2=A0 =C2=A0 7. verify throughput metrics of QAT device encrypt with snow=
3g-uea2 cipher algorithm and<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 snow3g-uia2 auth algorithm<br>
+=C2=A0 =C2=A0 8. verify throughput metrics of QAT device encrypt with zuc-=
eea3 cipher algorithm and zuc-eia3<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 auth algorithm<br></blockquote><div><br></div>=
<div>Testcases=C2=A0should most likely be device agnostic. I.e. the dpdk-cr=
ypto-perf app should be able to perform encrypt/decrypt with algorithm X wi=
th any device that supports X, not just a QAT series crypto device.</div><d=
iv>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 config: Config<br>
+=C2=A0 =C2=A0 unsupported_cryptodevs: list[DeviceType] =3D []<br>
+<br>
+=C2=A0 =C2=A0 def set_up_suite(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Set up the test suite.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Setup: Retrieve application parameters from th=
e configuration.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.throughput_test_parameters =3D self.confi=
g.throughput_test_parameters<br>
+<br>
+=C2=A0 =C2=A0 def _verify_throughput(self, results: list[CryptodevResults]=
) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Verify throughput results ag=
ainst predefined thresholds.<br></blockquote><div><br></div><div>Can you us=
e the term baseline instead of threshold?</div><div>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Arguments:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 results: The results containing =
throughput metrics to verify.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for result in results:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for key, value in self.throughpu=
t_test_parameters.items():<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result_value =3D g=
etattr(result, key, None)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if result_value is=
 not None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 veri=
fy(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 result_value &gt; value,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 f&quot;Throughput metric {key} is below the threshold: {result_v=
alue} &lt; {value}&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br=
></blockquote><div><br></div><div>2 possible issues:</div><div><br></div><d=
iv>1. I think we need to have some &quot;delta tolerance&quot; I assume. I.=
e. the test probably won&#39;t=C2=A0produce the literal same amount of oper=
ations as expected form the baseline, it might be=C2=A0+1% or -1% etc. So, =
either bake in some delta tolerance (like the 5% we use for ethdev performa=
nce testing) or allow a delta tolerance to be passed in via config (with a =
default value as well of course).</div><div><br></div><div>2. I think the w=
ay this will work as written is the first time it meets a key/value which d=
oes not meet the baseline, verify will fail the testsuite. This is okay but=
 we want to log the entire table of results before calling verify, so that =
the person running the testsuite can see the whole table from results. If 3=
 of the values are failing, we want to ensure they can see all 3, not just =
the first one. Let me know if this doesn&#39;t make sense.</div><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 def _run_app(self, app: Cryptodev) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Run the given cryptodev appl=
ication, print statistics, and verify throughput.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Arguments:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 app: The cryptodev application t=
o run and collect data on.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SkippedTestException: If the cry=
ptodev application cannot be run with the given<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 configuration.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;UNSUPPORTED CRYPTO DEVS:&quot;, se=
lf.unsupported_cryptodevs)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 results: list[CryptodevResults] =
=3D app.run_app()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 except Exception as e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;devtype&quot; in str(e)=
:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.unsupported_c=
ryptodevs.append(app._app_params[&quot;devtype&quot;])</blockquote><div><br=
></div><div>Just checking that I understand the problem and solution. A use=
 may try to run the test with a BDF pointing to a device which dpdk-crypto-=
perf does not support, right? However, don&#39;t we just need to indicate t=
hat at the time when dpdk-crypto-perf does not start, instead of re-printin=
g it every time we do a subsequent run of dpdk-crypto-perf? Maybe we can ta=
lk in person.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(f&quot;Skipping test: {e}&=
quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 app.print_stats(results)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._verify_throughput(results)<br>
+<br>
+=C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 def openssl_aead_aes_gcm_encrypt(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Basic test to run on all NIC=
s with openssl virtual device.<br></blockquote><div><br></div><div>I don&#3=
9;t know about the description above because the testing is being run on th=
e vdev, not any NIC (which really isn&#39;t involved in the test).</div><di=
v><br></div><div>I see from DPDK docs that crypto_openssl vdev supports aea=
d aes-gcm, but so do the physical devices, and you have a separate QAT case=
 like the openssl one above (and maybe this is a good solution). Is the ide=
a to have a testcase per device (physical or virtual) per algo?=C2=A0<a hre=
f=3D"https://doc.dpdk.org/guides-25.11/cryptodevs/overview.html#supported-a=
ead-algorithms">https://doc.dpdk.org/guides-25.11/cryptodevs/overview.html#=
supported-aead-algorithms</a></div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Create a Cryptodev application=
 instance with OpenSSL virtual device<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Run the application and gather=
 throughput statistics<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Throughput results meet predef=
ined thresholds<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 app =3D Cryptodev(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vdevs=3D[VirtualDevice(&quot;cry=
pto_openssl&quot;)],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ptest=3DTestType.throughput,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devtype=3DDeviceType.crypto_open=
ssl,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aead_algo=3DAeadAlgName.aes_gcm,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aead_aad_sz=3D16,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aead_key_sz=3D16,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aead_iv_sz=3D16,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 digest_sz=3D16,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aead_op=3DEncryptDecryptSwitch.e=
ncrypt,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optype=3DOperationType.aead,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 total_ops=3D10_000_000,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._run_app(app)<br>
+<br>
+=C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 def qat_cipher_then_auth_aes_cbc_encrypt(self) -&gt; None:<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Test throughput on a QAT dev=
ice with aes-cbc and sha2-256-hmac algorithms.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Create a Cryptodev application=
 instance with QAT device<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 and cipher_then_au=
th operation with aes-cbc and sha2-256-hmac algorithms<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Run the application and gather=
 throughput statistics<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Throughput results meet predef=
ined thresholds<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 app =3D Cryptodev(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ptest=3DTestType.throughput,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devtype=3DDeviceType.crypto_qat,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optype=3DOperationType.cipher_th=
en_auth,<br></blockquote><div><br></div><div>args should be ordered the sam=
e way for each=C2=A0instantiation of Cryptodev even if you are using named =
args. I.e. no optype=C2=A0as a final arg for the previous test and as one o=
f the first for this test.</div><div>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_algo=3DCipherAlgorithm.ae=
s_cbc,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_op=3DEncryptDecryptSwitch=
.encrypt,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_key_sz=3D16,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_iv_sz=3D16,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_algo=3DAuthenticationAlgori=
thm.sha2_256_hmac,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_op=3DAuthenticationOpMode.g=
enerate,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_key_sz=3D64,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 digest_sz=3D32,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 total_ops=3D10_000_000,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 burst_sz=3D32,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buffer_sz=3DListWrapper([64, 128=
, 256, 512, 1024, 2048]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._run_app(app)<br>
+<br>
+=C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 def qat_aead_aes_gcm_encrypt(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Test throughput on a QAT dev=
ice with aes-gcm algorithm.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Create a Cryptodev application=
 instance with QAT device<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 and aead operation=
 with aes-gcm algorithm<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Run the application and gather=
 throughput statistics<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Throughput results meet predef=
ined thresholds<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 app =3D Cryptodev(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ptest=3DTestType.throughput,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devtype=3DDeviceType.crypto_qat,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optype=3DOperationType.aead,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aead_aad_sz=3D16,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aead_key_sz=3D16,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aead_iv_sz=3D12,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aead_op=3DEncryptDecryptSwitch.e=
ncrypt,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aead_algo=3DAeadAlgName.aes_gcm,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 digest_sz=3D16,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 total_ops=3D10_000_000,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 burst_sz=3D32,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buffer_sz=3DListWrapper([64, 128=
, 256, 512, 1024, 2048]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._run_app(app)<br>
+<br>
+=C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 def qat_cipher_aes_docsisbpi_decrypt(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Test throughput on a QAT dev=
ice with aes-docsibpi algorithm.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Create a Cryptodev application=
 instance with QAT device<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 and cipher_only op=
eration with aes-docsibpi algorithm<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Run the application and gather=
 throughput statistics<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Throughput results meet predef=
ined thresholds<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 app =3D Cryptodev(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ptest=3DTestType.throughput,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devtype=3DDeviceType.crypto_qat,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optype=3DOperationType.cipher_on=
ly,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_algo=3DCipherAlgorithm.ae=
s_docsisbpi,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_op=3DEncryptDecryptSwitch=
.decrypt,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_key_sz=3D32,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_iv_sz=3D16,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 burst_sz=3D32,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buffer_sz=3DListWrapper([40, 64,=
 70, 128, 256, 512, 1024, 2048]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 total_ops=3D10_000_000,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._run_app(app)<br>
+<br>
+=C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 def qat_cipher_aes_docsisbpi_encrypt(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Test throughput on a QAT dev=
ice with aes-docsibpi algorithm.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Create a Cryptodev application=
 instance with QAT device<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 and cipher_only op=
eration with aes-docsibpi algorithm<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Run the application and gather=
 throughput statistics<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Throughput results meet predef=
ined thresholds<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 app =3D Cryptodev(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ptest=3DTestType.throughput,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devtype=3DDeviceType.crypto_qat,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optype=3DOperationType.cipher_on=
ly,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_algo=3DCipherAlgorithm.ae=
s_docsisbpi,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_op=3DEncryptDecryptSwitch=
.encrypt,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_key_sz=3D32,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_iv_sz=3D16,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 burst_sz=3D32,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buffer_sz=3DListWrapper([40, 64,=
 70, 128, 256, 512, 1024, 2048]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 total_ops=3D10_000_000,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._run_app(app)<br>
+<br>
+=C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 def qat_cipher_then_auth_kasumi_f8_encrypt(self) -&gt; None:=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Test throughput on a QAT dev=
ice with kasumi-f8 and kasumi-f9 algorithms.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Create a Cryptodev application=
 instance with QAT device<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 and cipher_then_au=
th operation with kasumi-f8 and kasumi-f9 algorithms<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Run the application and gather=
 throughput statistics<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Throughput results meet predef=
ined thresholds<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 app =3D Cryptodev(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ptest=3DTestType.throughput,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devtype=3DDeviceType.crypto_qat,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optype=3DOperationType.cipher_th=
en_auth,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_algo=3DCipherAlgorithm.ka=
sumi_f8,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_op=3DEncryptDecryptSwitch=
.encrypt,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_key_sz=3D16,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_iv_sz=3D8,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_algo=3DAuthenticationAlgori=
thm.kasumi_f9,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_op=3DAuthenticationOpMode.g=
enerate,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_key_sz=3D16,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 digest_sz=3D4,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 total_ops=3D10_000_000,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 burst_sz=3D32,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buffer_sz=3DListWrapper([64, 128=
, 256, 512, 1024, 2048]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._run_app(app)<br>
+<br>
+=C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 def qat_cipher_then_auth_snow3g_uea2_encrpyt(self) -&gt; Non=
e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Test throughput on a QAT dev=
ice with snow3g-uea2 and snow3g-uia2 algorithms.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Create a Cryptodev application=
 instance with QAT device<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 and cipher_then_au=
th operation with snow3g-uea2 and snow3g-uia2 algorithms<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Run the application and gather=
 throughput statistics<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Throughput results meet predef=
ined thresholds<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 app =3D Cryptodev(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ptest=3DTestType.throughput,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devtype=3DDeviceType.crypto_qat,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optype=3DOperationType.cipher_th=
en_auth,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_algo=3DCipherAlgorithm.sn=
ow3g_uea2,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_op=3DEncryptDecryptSwitch=
.encrypt,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_key_sz=3D16,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_iv_sz=3D16,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_algo=3DAuthenticationAlgori=
thm.snow3g_uia2,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_op=3DAuthenticationOpMode.g=
enerate,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_key_sz=3D16,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_iv_sz=3D16,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 digest_sz=3D4,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 total_ops=3D10_000_000,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 burst_sz=3D32,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buffer_sz=3DListWrapper([64, 128=
, 256, 512, 1024, 2048]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._run_app(app)<br>
+<br>
+=C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 def qat_cipher_then_auth_zuc_eea3_encrypt(self) -&gt; None:<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Test throughput on a QAT dev=
ice with zuc-eea3 and zuc-eia3 algorithms.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Create a Cryptodev application=
 instance with QAT device<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 and cipher_then_au=
th operation with zuc-eea3 and zuc-eia3 algorithms<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Run the application and gather=
 throughput statistics<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Throughput results meet predef=
ined thresholds<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 app =3D Cryptodev(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ptest=3DTestType.throughput,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devtype=3DDeviceType.crypto_qat,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optype=3DOperationType.cipher_th=
en_auth,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_algo=3DCipherAlgorithm.zu=
c_eea3,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_op=3DEncryptDecryptSwitch=
.encrypt,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_key_sz=3D16,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_iv_sz=3D16,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_algo=3DAuthenticationAlgori=
thm.zuc_eia3,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_op=3DAuthenticationOpMode.g=
enerate,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_key_sz=3D16,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_iv_sz=3D16,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 digest_sz=3D4,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 total_ops=3D10_000_000,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 burst_sz=3D32,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buffer_sz=3DListWrapper([64, 128=
, 256, 512, 1024, 2048]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._run_app(app)<br>
+<br>
+=C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 def a_wrong_devtype(self) -&gt; None:<br></blockquote><div><=
br></div><div>Can you explain the=C2=A0name of this test and its purpose?</=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Test throughput on a QAT dev=
ice.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Create a Cryptodev application=
 instance with QAT device<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 and cipher_then_au=
th operation with aes-cbc and sha2-256-hmac algorithms<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Run the application and gather=
 throughput statistics<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Throughput results meet predef=
ined thresholds<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 app =3D Cryptodev(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ptest=3DTestType.throughput,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devtype=3DDeviceType.crypto_mvsa=
m,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optype=3DOperationType.cipher_th=
en_auth,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_algo=3DCipherAlgorithm.ae=
s_cbc,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_op=3DEncryptDecryptSwitch=
.encrypt,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_key_sz=3D16,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_iv_sz=3D16,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_algo=3DAuthenticationAlgori=
thm.sha2_256_hmac,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_op=3DAuthenticationOpMode.g=
enerate,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_key_sz=3D64,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 digest_sz=3D32,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 total_ops=3D10_000_000,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 burst_sz=3D32,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buffer_sz=3DListWrapper([64, 128=
, 256, 512, 1024, 2048]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._run_app(app)<br>
+<br>
+=C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 def anotha_one(self) -&gt; None:<br></blockquote><div><br></=
div><div>... I&#39;m glad we&#39;re in the RFC period!</div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Test throughput on a QAT dev=
ice.<br><br>
<br>
</blockquote></div></div>
</div>

--0000000000009971a90647d3cdb5--
