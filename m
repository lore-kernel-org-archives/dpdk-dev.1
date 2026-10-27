Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C112F606A31B
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 16:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=O6MG0SfC
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 34FE5400D7;
	Tue, 27 Oct 2026 17:21:46 +0100 (CET)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by mails.dpdk.org (Postfix) with ESMTPS id 113FD400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 17:21:45 +0100 (CET)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-53512cd2f85so1509421cf.1
 for <dev@dpdk.org>; Tue, 27 Oct 2026 09:21:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793118104; cv=none;
 d=google.com; s=arc-20260327;
 b=WqvaQhHVXKka/NPyldwjE88+zb37w8HJ0r2EpSvzZu3Mu3BUGwj9eOk7n3fQTcXg+C
 WPBtuGdxwsc+hhFAz7LFRSBGNiDPZHsWVLq/wzky067V3J8/YuTC2TdEQRyzCUNx6BIj
 YtjGICfRFLzNItLqNcEghXbzXoVKI0CrDb9+drs91BIYqDOdZi5HGgL6Hph/tOTwb4cz
 DbkKTd+IIoQOR9vY4iOCcfNnSYOKJXYXOr4bZZ8MlJP8e7LVkRC6xDhSWc6GiEkwgc+N
 cStCefHvI7CF5utkrmTru1D2pEyhvyeWvolOh5fvd0sc2wgGZ850cXmsoJnFZFKLqQaU
 XXKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=s7G9RgZ0Yw+wMOqIDBZ54un7XPErsouAncY9q3+fUiU=;
 fh=/r4EsEkjUD2JWM5yk5r1S2yVXJmDFp/UUBiDifHc/Z8=;
 b=e60ohE8A+0tCdqEYmilu1y77n9h9Dn32HGoyg3Uo8DlovGMyz25WE9Xig4FhqwO57j
 ND1qqe5Qa1KPl7sk4YOHkAT1BKI0tdUOnCLTK4DcFNWmFHAsI1DHlwHIvWIMm8qwksT9
 o91hJX+sC3O3zlY0g0dX7Jf7a6/6HQjcBShzuMATBT0Jg3mHbJegd275FwiMwdXiQIGk
 W7h0r3AcBvRsS3B3nc2/agfXXKIwVbehe33g3RgOC/L6UNz+9UcVKLqzc0tETowkL5Pi
 r/Cfx20nGH/sUJtvP9vK9/JOBybkaoUGl0sGubVcKS3K7naF95sB9O/baMcRCdYhD/nV
 psZg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1793118104; x=1793722904; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=s7G9RgZ0Yw+wMOqIDBZ54un7XPErsouAncY9q3+fUiU=;
 b=O6MG0SfCy3ccJGvNuuzNmR+LTa+5vNtlQkEBZ5fx0cCqRtXekY9w1jy7FXY5nAaIBI
 N85YC7uxJrg70z20rEz9Jf+QuSlgTdQgnewFDeckra5n36H7Omj875/bY0fKLyl0qABh
 pOd94PK6a4Fw1hqz9/f5IuLuKsJbnyMcxcJJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793118104; x=1793722904;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=s7G9RgZ0Yw+wMOqIDBZ54un7XPErsouAncY9q3+fUiU=;
 b=r+vV9LmS+wIr/uyKfTnExdIgBtFOvvu3dSlYakZXMhCp+i4JGsT/beGlloHGABBnAO
 DOJLb2e2RvAmCinUe0qdL4a+cOfqIUEou4Buu8aB233EboXEtKW3rPxegvoXlbqqYSsU
 z/7xNpVvqm/k1llbOpM7GqTYz3bPG+FSrPspCBwoPHhNyKE+gzqBPpHK6bmHN8CtEiVn
 o80pWH1vXOxKafEEdGZHatPhfKUEaDN+/pWAldbQ1kAcwy0Mn7fuds/kh0+a+nGu0+Qc
 nMr9Z//4GrUEkjPgJBpPUQgNauBBl0o0eclFtQq3+YgEfPwO7u7RipmjCAKU5kFu9iGi
 pFtw==
X-Gm-Message-State: AFq9FYI9KvSqkUTSGnVVK3SFl6uCf/5U3Yn3T8GCLoU7mQJ7nOjSjqlp
 6aUb7gXoNN3IvXuUdkx0n0M3NSoYCgxM7+wmBbrJkYWPzs3FwpBT4ZH/IZ3ZQOufQyEbhN+89Ea
 t7GBojDGz1V/9etyYY6aX2xQVjTMQhyswnpI1yWkfKA==
X-Gm-Gg: AYBFou3/FOAx5a8LVbW1o5YC3ZjzBl0kQgFOjL3gIDrl5dPVniTIjzq992b8xKwuJIY
 iU0q0MMgrOiLV+LNPvmAbEDaVMWfJH++KMFuFFF1Pa7lnNBirsVzmZTTdyRFK6jM7JUTOpkScnw
 pwwh/GZhfLzKPzQB36+jMNw1QRDv/IhAX7tVE9dfukZcucqNhQvFMOGWQwWMh7sUtXpWeOnWz/U
 wCmwRvx8FYCksKx7R2itNDaks81ZPXnHanejqbBYjL7Heb1/B4G3YSKzF5wrQj5aDSmbc0s8bLx
 cibPZdv4hCfytKFYNz7j+xuhimIvXN+xDj5qjy4P9VrlZKLShNra2OidnKnftnjv4XDDfUM47ck
 Y+bEkeOwlV3cJpXyvIwksuhzboaTvB2+C4QeRtUsaPs4fyeVUe3tZCOyyngWBkYC5eNhh/KgdoO
 qWJ/qlxBlLfchBNTn5sXV+tIHXkxj7mb3FftihiXpMVgQs3Gp/QCPfCDD9vUzgj2oQVBkXsF2X/
 Adj+10saI8guZUNE9dStV9bR3vZ
X-Received: by 2002:ac8:5d8e:0:b0:535:f3e:745e with SMTP id
 d75a77b69052e-5383b4ae35emr171456001cf.20.1793118103384; Tue, 27 Oct 2026
 09:21:43 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260827172208.139769-1-abailey@iol.unh.edu>
 <20261019200424.898640-1-abailey@iol.unh.edu>
 <20261019200424.898640-2-abailey@iol.unh.edu>
In-Reply-To: <20261019200424.898640-2-abailey@iol.unh.edu>
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Date: Tue, 27 Oct 2026 12:21:07 -0400
X-Gm-Features: AclHuK_p4QUp9NWSlGhSezE7MT9HMwvLrZo1zo29ZrF77v5RAjGQDNFlWhREn68
Message-ID: <CAKYPG+xSzJu9uLiGutSZdJrk2p8mmXT30smDjF8uaw9b-f=HwA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dts: refactor cryptodev latency test suite
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: dev@dpdk.org, luca.vizzarro@arm.com, patrickrobb1997@gmail.com, 
 dladd@iol.unh.edu, lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="00000000000097d2e5065ed4d70c"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--00000000000097d2e5065ed4d70c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Koushik Bhargav Nimoji <:knimoji@iol.unh.edu>

On Mon, Oct 19, 2026 at 4:04=E2=80=AFPM Andrew Bailey <abailey@iol.unh.edu>=
 wrote:

> Previously, cryptodev latency testing only covered a handful of
> algorithm combinations and virtual device types for testing. The new
> implementation makes this test completely configurable to run any
> combination of arguments provided through the tests configuration file.
>
> Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
> ---
>  dts/configurations/tests_config.example.yaml |   17 +
>  dts/tests/TestSuite_cryptodev_latency.py     | 1044 ++++++++----------
>  2 files changed, 481 insertions(+), 580 deletions(-)
>
> diff --git a/dts/configurations/tests_config.example.yaml
> b/dts/configurations/tests_config.example.yaml
> index fe4bed2847..450a6cc5e7 100644
> --- a/dts/configurations/tests_config.example.yaml
> +++ b/dts/configurations/tests_config.example.yaml
> @@ -66,6 +66,23 @@ hello_world:
>  #         - buff_size: 64
>  #           Gbps: 1.5
>
> +# cryptodev_latency:
> +#   # Identical to cryptodev_throughput configuration besides updated
> test_parameters below.
> +#   delta_tolerance: 0.05
> +#     - name: "example cipher test" # Add a name for this test config
> +#       cipher_algorithm: "aes_cbc" # See `algortihms` in `Optional
> Fields` for a complete list
> +#       virtual_device: "crypto_openssl" # uncomment to run with a
> virtual device.
> +#       test_parameters:  # Buffer sizes and expected throughput, a
> default is used if not present
> +#        - buff_size: 64
> +#          avg_cycles: 999999
> +#          avg_time_us: 999999
> +#        - buff_size: 512
> +#          avg_cycles: 999999
> +#          avg_time_us: 999999
> +#        - buff_size: 2048
> +#          avg_cycles: 999999
> +#          avg_time_us: 999999
> +
>  # port_speed_capabilities:
>  #   test_parameters:
>  #     0 : 100 Gbps # Assign an expected link speed to a port ID in Gbps
> diff --git a/dts/tests/TestSuite_cryptodev_latency.py
> b/dts/tests/TestSuite_cryptodev_latency.py
> index 444a5b282c..a9e963bdfb 100644
> --- a/dts/tests/TestSuite_cryptodev_latency.py
> +++ b/dts/tests/TestSuite_cryptodev_latency.py
> @@ -9,6 +9,8 @@
>  ensure performance standards are met.
>  """
>
> +from typing import Any
> +
>  from api.capabilities import (
>      LinkTopology,
>      requires_link_topology,
> @@ -16,6 +18,9 @@
>  from api.context import get_ctx
>  from api.cryptodev import Cryptodev
>  from api.cryptodev.config import (
> +    AEAD_ALGORITHM_PARAMS,
> +    AUTHENTICATION_ALGORITHM_PARAMS,
> +    CIPHER_ALGORITHM_PARAMS,
>      AeadAlgName,
>      AuthenticationAlgorithm,
>      AuthenticationOpMode,
> @@ -30,14 +35,15 @@
>  from api.cryptodev.types import (
>      CryptodevResults,
>  )
> -from api.test import skip, verify
> +from api.exception import ConfigurationError, SkippedTestException,
> TestCaseVerifyError
> +from api.test import fail, skip, verify
>  from api.test_suite import BaseConfig, TestSuite, crypto_test
>  from api.testbed_model.virtual_device import VirtualDevice
>
>  config_list: list[dict[str, int | float | str]] =3D [
> -    {"buff_size": 64, "avg_cycles": 99_999.00, "avg_time_us": 9999.0},
> -    {"buff_size": 512, "avg_cycles": 99_999.00, "avg_time_us": 9999.0},
> -    {"buff_size": 2048, "avg_cycles": 99_999.00, "avg_time_us": 9999.0},
> +    {"buff_size": 64, "avg_cycles": 999_999_999.0, "avg_time_us":
> 999_999_999.0},
> +    {"buff_size": 512, "avg_cycles": 999_999_999.0, "avg_time_us":
> 999_999_999.0},
> +    {"buff_size": 2048, "avg_cycles": 999_999_999.0, "avg_time_us":
> 999_999_999.0},
>  ]
>
>  TOTAL_OPS =3D 10_000_000
> @@ -48,69 +54,191 @@ class Config(BaseConfig):
>
>      Attributes:
>          delta_tolerance: The allowed tolerance below a given baseline.
> -        latency_test_parameters: The test parameters to use in the test
> suite.
> +        test_combinations: List of test combinations with cipher/auth
> algorithms and parameters.
>      """
>
>      delta_tolerance: float =3D 0.05
> -
> -    latency_test_parameters: dict[str, list[dict[str, int | float |
> str]]] =3D {
> -        "aes_cbc": config_list,
> -        "aes_cbc_sha1_hmac": config_list,
> -        "aes_cbc_sha2_hmac": config_list,
> -        "aes_docsisbpi": config_list,
> -        "aes_gcm": config_list,
> -        "kasumi_f8_kasumi_f9": config_list,
> -        "snow3g_uea2_snow3g_uia2": config_list,
> -        "zuc_eea3_zuc_eia3": config_list,
> -        "aesni_gcm_vdev": config_list,
> -        "aesni_mb_cipher_then_auth_vdev": config_list,
> -        "aesni_mb_vdev": config_list,
> -        "kasumi_vdev": config_list,
> -        "open_ssl_vdev": config_list,
> -        "snow3g_vdev": config_list,
> -        "zuc_vdev": config_list,
> -    }
> +    test_combinations: list[dict[str, Any]] =3D [
> +        #: cipher only tests
> +        {
> +            "name": "aes-cbc",
> +            "cipher_algorithm": CipherAlgorithm.aes_cbc.name,
> +            "cipher_key_sz": 16,
> +            "cipher_iv_sz": 16,
> +            "burst_sz": 32,
> +        },
> +        {
> +            "name": "aes-docsisbpi",
> +            "cipher_algorithm": CipherAlgorithm.aes_docsisbpi.name,
> +            "cipher_key_sz": 32,
> +            "cipher_iv_sz": 16,
> +        },
> +        #: cipher then auth tests
> +        {
> +            "name": "aes-cbc/sha1_hmac",
> +            "cipher_algorithm": CipherAlgorithm.aes_cbc.name,
> +            "cipher_key_sz": 16,
> +            "auth_algorithm": AuthenticationAlgorithm.sha1_hmac.name,
> +            "auth_key_sz": 64,
> +            "digest_sz": 12,
> +            "burst_sz": 32,
> +        },
> +        {
> +            "name": "aes-cbc/sha2_hmac",
> +            "cipher_algorithm": CipherAlgorithm.aes_cbc.name,
> +            "cipher_key_sz": 16,
> +            "auth_algorithm": AuthenticationAlgorithm.sha2_256_hmac.name=
,
> +            "auth_key_sz": 64,
> +            "digest_sz": 32,
> +            "burst_sz": 32,
> +        },
> +        {
> +            "name": "kasumi-f8/kasumi-f9",
> +            "cipher_algorithm": CipherAlgorithm.kasumi_f8.name,
> +            "cipher_key_sz": 16,
> +            "cipher_iv_sz": 8,
> +            "auth_algorithm": AuthenticationAlgorithm.kasumi_f9.name,
> +            "auth_key_sz": 16,
> +            "digest_sz": 4,
> +            "burst_sz": 32,
> +        },
> +        {
> +            "name": "snow3g-uea2/snow3g-uia2",
> +            "cipher_algorithm": CipherAlgorithm.snow3g_uea2.name,
> +            "cipher_key_sz": 16,
> +            "cipher_iv_sz": 16,
> +            "auth_algorithm": AuthenticationAlgorithm.snow3g_uia2.name,
> +            "auth_key_sz": 16,
> +            "auth_iv_sz": 16,
> +            "digest_sz": 4,
> +        },
> +        {
> +            "name": "zuc-eea3/zuc-eia3",
> +            "cipher_algorithm": CipherAlgorithm.zuc_eea3.name,
> +            "cipher_key_sz": 16,
> +            "cipher_iv_sz": 16,
> +            "auth_algorithm": AuthenticationAlgorithm.zuc_eia3.name,
> +            "auth_key_sz": 16,
> +            "auth_iv_sz": 16,
> +            "digest_sz": 4,
> +        },
> +        #: aead tests
> +        {
> +            "name": "aes-gcm",
> +            "aead_algorithm": AeadAlgName.aes_gcm.name,
> +            "aead_key_sz": 16,
> +            "aead_iv_sz": 12,
> +            "aead_aad_sz": 16,
> +        },
> +    ]
>
>
>  @requires_link_topology(LinkTopology.NO_LINK)
>  class TestCryptodevLatency(TestSuite):
> -    """DPDK Crypto Device Testing Suite."""
> +    """DPDK Crypto Device Latency Testing Suite."""
>
>      config: Config
>
>      def set_up_suite(self) -> None:
> -        """Set up the test suite."""
> -        self.latency_test_parameters: dict[str, list[dict[str, int |
> float | str]]] =3D (
> -            self.config.latency_test_parameters
> -        )
> +        """Set up the test suite.
> +
> +        Raises:
> +            ConfigurationError: If no tests can be derived from the
> provided config.
> +        """
> +        self.test_combinations: list[dict[str, Any]] =3D
> self.config.test_combinations
>          self.delta_tolerance: float =3D self.config.delta_tolerance
> +        self.ops: int =3D 10_000_000
>          self.device_type: DeviceType | None =3D get_device_from_str(
>              str(get_ctx().sut_node.crypto_device_type)
>          )
> -        self.buffer_sizes =3D {}
> -
> -        for k, v in self.latency_test_parameters.items():
> -            self.buffer_sizes[k] =3D ListWrapper([int(run["buff_size"]) =
for
> run in v])
> +        self.buffer_sizes: dict[str, ListWrapper] =3D {}
> +        self.cipher_tests: list[dict[str, Any]] =3D []
> +        self.auth_tests: list[dict[str, Any]] =3D []
> +        self.cipher_then_auth_tests: list[dict[str, Any]] =3D []
> +        self.aead_tests: list[dict[str, Any]] =3D []
> +
> +        for combination in self.test_combinations:
> +            self.buffer_sizes[combination["name"]] =3D ListWrapper(
> +                [int(run["buff_size"]) for run in
> combination.get("test_parameters", config_list)]
> +            )
> +            is_cipher =3D "cipher_algorithm" in combination
> +            is_auth =3D "auth_algorithm" in combination
> +            aead =3D "aead_algorithm" in combination
> +
> +            if is_cipher and is_auth:
> +                self.cipher_then_auth_tests.append(combination)
> +            elif is_cipher:
> +                self.cipher_tests.append(combination)
> +            elif is_auth:
> +                self.auth_tests.append(combination)
> +            elif aead:
> +                self.aead_tests.append(combination)
> +            else:
> +                raise ConfigurationError(
> +                    "Each test instance must contain either "
> +                    "'cipher_algorithm', 'auth_algorithm', or
> 'aead_algorithm'"
> +                )
>
>      def _print_stats(self, test_vals: list[dict[str, int | float | str]]=
)
> -> None:
> +        """Print the stats of the given test values in a clean format.
> +
> +        Args:
> +            test_vals: the testing values to print
> +        """
> +        assert len(test_vals) > 0, "test_vals must contain at least one
> element"
> +
>          element_len =3D len("Avg Time us Target")
> -        border_len =3D (element_len + 1) * (len(test_vals[0]))
> +        border_len =3D (element_len + 1) * (len(test_vals[0]) - 1)
> +        test_name =3D test_vals[0]["Test Name"]
>
> -        print(f"{'Latency Results'.center(border_len)}\n{'=3D' *
> border_len}")
> +        print(f"{f'{test_name} Latency Results'.center(border_len)}\n{'=
=3D'
> * border_len}")
>          for k, v in test_vals[0].items():
> -            print(f"|{k.title():<{element_len}}", end=3D"")
> +            if k !=3D "Test Name":
> +                print(f"|{k.title():<{element_len}}", end=3D"")
>          print(f"|\n{'=3D' * border_len}")
>
>          for test_val in test_vals:
>              for k, v in test_val.items():
> -                print(f"|{v:<{element_len}}", end=3D"")
> +                if k !=3D "Test Name":
> +                    print(f"|{v:<{element_len}}", end=3D"")
>              print(f"|\n{'=3D' * border_len}")
>
> -    def _verify_latency(
> +    def _print_and_verify(self, all_results: list[list[dict[str, int |
> float | str]]]) -> None:
> +        """Print the given results and then verify all results have
> passed.
> +
> +        Args:
> +            all_results: a list of results to print and verify.
> +        """
> +        for results in all_results:
> +            if len(results) > 0:
> +                self._print_stats(test_vals=3Dresults)
> +
> +        for results in all_results:
> +            for result in results:
> +                verify(
> +                    result["passed"] =3D=3D "PASS",
> +                    f"Gbps fell below delta tolerance for test
> {result['Test Name']}",
> +                )
> +
> +    def _create_summary(
>          self,
>          results: list[CryptodevResults],
> -        key: str,
> +        params: list[dict],
> +        test_name: str,
>      ) -> list[dict[str, int | float | str]]:
> +        """Verify the throughput of the given results against the
> supplied parameters.
> +
> +        Args:
> +            results: The results of the dpdk crypto perf app ran in
> latency mode.
> +            params: The baselines to compare the given results to.
> +            test_name: The test name to pin to the result summary.
> +
> +        Returns:
> +            A summary of latency statistics for a test and whether the
> test passed.
> +
> +        Raises:
> +            RuntimeError: When there are no baselines for a given result=
.
> +        """
>          result_list: list[dict[str, int | float | str]] =3D []
>
>          for result in results:
> @@ -118,601 +246,357 @@ def _verify_latency(
>              parameters: dict[str, int | float | str] =3D next(
>                  filter(
>                      lambda x: x["buff_size"] =3D=3D result.buffer_size,
> -                    self.latency_test_parameters[key],
> +                    params,
>                  ),
>                  {},
>              )
> +            errmsg =3D (
> +                f"No test parameters found for {test_name} with buffer
> size {result.buffer_size}"
> +            )
>              if parameters =3D=3D {}:
> -                raise RuntimeError(
> -                    f"No test parameters found for {key} with buffer siz=
e
> {result.buffer_size}"
> -                )
> +                raise RuntimeError(errmsg)
>              test_result =3D True
> +
>              expected_cycles =3D parameters["avg_cycles"]
> -            expected_time_us =3D parameters["avg_time_us"]
> -            measured_time_delta =3D abs(
> -                (getattr(result, "avg_time_us") - expected_time_us) /
> expected_time_us
> +            assert int(expected_cycles) > 0, "Expected average cycles
> must not be zero"
> +            measured_delta_cycles =3D abs(
> +                round((getattr(result, "avg_cycles") - expected_cycles) =
/
> expected_cycles, 5)
>              )
> -            measured_cycles_delta =3D abs(
> -                (getattr(result, "avg_cycles") - expected_cycles) /
> expected_cycles
> +            expected_time =3D parameters["avg_time_us"]
> +            assert int(expected_time) > 0, "Expected average time must
> not be zero"
> +            measured_delta_time =3D abs(
> +                round((getattr(result, "avg_time_us") - expected_time) /
> expected_time, 5)
>              )
>
> -            # result did not meet the given cycles parameter, check if
> within delta.
> +            # result did not meet the matching parameter, check if withi=
n
> delta.
>              if getattr(result, "avg_cycles") > expected_cycles:
> -                if self.delta_tolerance < measured_cycles_delta:
> +                if self.delta_tolerance > measured_delta_cycles:
>                      test_result =3D False
> -            # result did not meet the given time parameter, check if
> within delta.
> -            if getattr(result, "avg_time_us") > expected_time_us:
> -                if self.delta_tolerance < measured_time_delta:
> +            if getattr(result, "avg_time_us") > expected_time:
> +                if self.delta_tolerance > measured_delta_time:
>                      test_result =3D False
> +
>              result_list.append(
>                  {
> +                    "Test Name": test_name,
>                      "Buffer Size": parameters["buff_size"],
>                      "delta tolerance": self.delta_tolerance,
> -                    "cycles delta": round(measured_cycles_delta, 5),
> -                    "Avg cycles": round(getattr(result, "avg_cycles"), 5=
),
> -                    "Avg cycles target": expected_cycles,
> -                    "time delta": round(measured_time_delta, 5),
> -                    "Avg time us": round(getattr(result, "avg_time_us"),
> 5),
> -                    "Avg time us target": expected_time_us,
> +                    "avg_cycles": getattr(result, "avg_cycles"),
> +                    "avg_cycles target": expected_cycles,
> +                    "avg_cycles delta": measured_delta_cycles,
> +                    "avg_time_us": getattr(result, "avg_time_us"),
> +                    "avg_time_us target": expected_time,
> +                    "avg_time_us delta": measured_delta_time,
>                      "passed": "PASS" if test_result else "FAIL",
>                  }
>              )
>          return result_list
>
>      @crypto_test
> -    def aes_cbc(self) -> None:
> -        """aes_cbc latency test.
> -
> -        Steps:
> -            * Create a cryptodev instance with provided device type and
> buffer sizes.
> -        Verify:
> -            * The latency is below or within delta of provided baseline.
> -
> -        Raises:
> -            SkippedTestException: When configuration is not provided.
> -        """
> -        if "aes_cbc" not in self.latency_test_parameters:
> -            skip("test not configured")
> -        app =3D Cryptodev(
> -            ptest=3DTestType.latency,
> -            devtype=3Dself.device_type,
> -            optype=3DOperationType.cipher_only,
> -            cipher_algo=3DCipherAlgorithm.aes_cbc,
> -            cipher_op=3DEncryptDecryptSwitch.encrypt,
> -            cipher_key_sz=3D16,
> -            cipher_iv_sz=3D16,
> -            burst_sz=3D32,
> -            total_ops=3DTOTAL_OPS,
> -            buffer_sz=3Dself.buffer_sizes["aes_cbc"],
> -        )
> -        results =3D self._verify_latency(app.run_app(), "aes_cbc")
> -        self._print_stats(results)
> -        for result in results:
> -            verify(
> -                result["passed"] =3D=3D "PASS",
> -                "latency was greater than the delta tolerance above
> baseline",
> -            )
> -
> -    @crypto_test
> -    def aes_cbc_sha1_hmac(self) -> None:
> -        """aes_cbc_sha1_hmac latency test.
> -
> -        Steps:
> -            * Create a cryptodev instance with provided device type and
> buffer sizes.
> -        Verify:
> -            * The latency is below or within delta of provided baseline.
> -
> -        Raises:
> -            SkippedTestException: When configuration is not provided.
> -        """
> -        if "aes_cbc_sha1_hmac" not in self.latency_test_parameters:
> -            skip("test not configured")
> -        app =3D Cryptodev(
> -            ptest=3DTestType.latency,
> -            devtype=3Dself.device_type,
> -            optype=3DOperationType.cipher_then_auth,
> -            cipher_algo=3DCipherAlgorithm.aes_cbc,
> -            cipher_op=3DEncryptDecryptSwitch.encrypt,
> -            cipher_key_sz=3D16,
> -            auth_algo=3DAuthenticationAlgorithm.sha1_hmac,
> -            auth_op=3DAuthenticationOpMode.generate,
> -            auth_key_sz=3D64,
> -            digest_sz=3D12,
> -            burst_sz=3D32,
> -            total_ops=3DTOTAL_OPS,
> -            buffer_sz=3Dself.buffer_sizes["aes_cbc_sha1_hmac"],
> -        )
> -        results =3D self._verify_latency(app.run_app(), "aes_cbc_sha1_hm=
ac")
> -        self._print_stats(results)
> -        for result in results:
> -            verify(
> -                result["passed"] =3D=3D "PASS",
> -                "latency was greater than the delta tolerance above
> baseline",
> -            )
> -
> -    @crypto_test
> -    def aes_cbc_sha2_hmac(self) -> None:
> -        """aes_cbc_sha2_hmac latency test.
> +    def cipher_only_tests(self) -> None:
> +        """Cipher only cryptography device tests.
>
>          Steps:
> -            * Create a cryptodev instance with provided device type and
> buffer sizes.
> +            * Run dpdk-test-crypto-perf application with configured
> arguments in cipher only mode.
>          Verify:
> -            * The latency is below or within delta of provided baseline.
> -
> -        Raises:
> -            SkippedTestException: When configuration is not provided.
> +            * The reported statistics are within is within a defined
> tolerance of a given baseline.
>          """
> -        if "aes_cbc_sha2_hmac" not in self.latency_test_parameters:
> -            skip("test not configured")
> -        app =3D Cryptodev(
> -            ptest=3DTestType.latency,
> -            devtype=3Dself.device_type,
> -            optype=3DOperationType.cipher_then_auth,
> -            cipher_algo=3DCipherAlgorithm.aes_cbc,
> -            cipher_op=3DEncryptDecryptSwitch.encrypt,
> -            cipher_key_sz=3D16,
> -            cipher_iv_sz=3D16,
> -            auth_algo=3DAuthenticationAlgorithm.sha2_256_hmac,
> -            auth_op=3DAuthenticationOpMode.generate,
> -            auth_key_sz=3D64,
> -            digest_sz=3D32,
> -            burst_sz=3D32,
> -            total_ops=3DTOTAL_OPS,
> -            buffer_sz=3Dself.buffer_sizes["aes_cbc_sha2_hmac"],
> -        )
> -        results =3D self._verify_latency(app.run_app(), "aes_cbc_sha2_hm=
ac")
> -        self._print_stats(results)
> -        for result in results:
> -            verify(
> -                result["passed"] =3D=3D "PASS",
> -                "latency was greater than the delta tolerance above
> baseline",
> -            )
>
> -    @crypto_test
> -    def aes_docsisbpi(self) -> None:
> -        """aes_docsisbpi latency test.
> -
> -        Steps:
> -            * Create a cryptodev instance with provided device type and
> buffer sizes.
> -        Verify:
> -            * The latency is below or within delta of provided baseline.
> -
> -        Raises:
> -            SkippedTestException: When configuration is not provided.
> -        """
> -        if "aes_docsisbpi" not in self.latency_test_parameters:
> -            skip("test not configured")
> -        app =3D Cryptodev(
> -            ptest=3DTestType.latency,
> -            devtype=3Dself.device_type,
> -            optype=3DOperationType.cipher_only,
> -            cipher_algo=3DCipherAlgorithm.aes_docsisbpi,
> -            cipher_op=3DEncryptDecryptSwitch.encrypt,
> -            cipher_key_sz=3D32,
> -            cipher_iv_sz=3D16,
> -            total_ops=3DTOTAL_OPS,
> -            buffer_sz=3Dself.buffer_sizes["aes_docsisbpi"],
> -        )
> -        results =3D self._verify_latency(app.run_app(), "aes_docsisbpi")
> -        self._print_stats(results)
> -        for result in results:
> -            verify(
> -                result["passed"] =3D=3D "PASS",
> -                "latency was greater than the delta tolerance above
> baseline",
> +        def test(encrypt: EncryptDecryptSwitch) -> list[dict[str, int |
> float | str]]:
> +            """Run a configured throughput test with the given encryptio=
n.
> +
> +            Args:
> +                encrypt: The cipher encryption mode to run throughput
> testing on.
> +
> +            Returns:
> +                The generated summary or an empty list if a test is
> skipped.
> +            """
> +            cipher_params =3D CIPHER_ALGORITHM_PARAMS[
> +                CipherAlgorithm[combination["cipher_algorithm"]]
> +            ]
> +            is_vdev =3D "virtual_device" in combination
> +            app =3D Cryptodev(
> +                ptest=3DTestType.latency,
> +                devtype=3Dself.device_type,
> +                optype=3DOperationType.cipher_only,
> +
> cipher_algo=3DCipherAlgorithm[combination["cipher_algorithm"]],
> +                cipher_op=3Dencrypt,
> +                cipher_key_sz=3Dcombination.get("cipher_key_size",
> cipher_params["key_size"]),
> +                cipher_iv_sz=3Dcombination.get("cipher_iv_size",
> cipher_params["iv_size"]),
> +                digest_sz=3Dcombination.get("digest_size", 0),
> +                total_ops=3Dcombination.get("ops", self.ops),
> +                buffer_sz=3Dself.buffer_sizes[combination.get("name",
> "custom_test")],
>              )
> +            if is_vdev:
> +                app.update_params(
> +                    vdevs=3D[VirtualDevice(combination["virtual_device"]=
)],
> +
> devtype=3Dget_device_from_str(combination["virtual_device"]),
> +                )
>
> -    @crypto_test
> -    def aes_gcm(self) -> None:
> -        """aes_gcm latency test.
> -
> -        Steps:
> -            * Create a cryptodev instance with provided device type and
> buffer sizes.
> -        Verify:
> -            * The latency is below or within delta of provided baseline.
> -
> -        Raises:
> -            SkippedTestException: When configuration is not provided.
> -        """
> -        if "aes_gcm" not in self.latency_test_parameters:
> -            skip("test not configured")
> -        app =3D Cryptodev(
> -            ptest=3DTestType.latency,
> -            devtype=3Dself.device_type,
> -            optype=3DOperationType.aead,
> -            aead_algo=3DAeadAlgName.aes_gcm,
> -            aead_op=3DEncryptDecryptSwitch.encrypt,
> -            aead_key_sz=3D16,
> -            aead_iv_sz=3D12,
> -            aead_aad_sz=3D16,
> -            digest_sz=3D16,
> -            burst_sz=3D32,
> -            total_ops=3DTOTAL_OPS,
> -            buffer_sz=3Dself.buffer_sizes["aes_gcm"],
> -        )
> -        results =3D self._verify_latency(app.run_app(), "aes_gcm")
> -        self._print_stats(results)
> -        for result in results:
> -            verify(
> -                result["passed"] =3D=3D "PASS",
> -                "latency was greater than the delta tolerance above
> baseline",
> -            )
> -
> -    @crypto_test
> -    def kasumi_f8_kasumi_f9(self) -> None:
> -        """kasumi_f8_kasumi_f9 latency test.
> -
> -        Steps:
> -            * Create a cryptodev instance with provided device type and
> buffer sizes.
> -        Verify:
> -            * The latency is below or within delta of provided baseline.
> -
> -        Raises:
> -            SkippedTestException: When configuration is not provided.
> -        """
> -        if "kasumi_f8_kasumi_f9" not in self.latency_test_parameters:
> -            skip("test not configured")
> -        app =3D Cryptodev(
> -            ptest=3DTestType.latency,
> -            devtype=3Dself.device_type,
> -            optype=3DOperationType.cipher_then_auth,
> -            cipher_algo=3DCipherAlgorithm.kasumi_f8,
> -            cipher_op=3DEncryptDecryptSwitch.encrypt,
> -            cipher_key_sz=3D16,
> -            cipher_iv_sz=3D8,
> -            auth_algo=3DAuthenticationAlgorithm.kasumi_f9,
> -            auth_op=3DAuthenticationOpMode.generate,
> -            auth_key_sz=3D16,
> -            digest_sz=3D4,
> -            burst_sz=3D32,
> -            total_ops=3DTOTAL_OPS,
> -            buffer_sz=3Dself.buffer_sizes["kasumi_f8_kasumi_f9"],
> -        )
> -        results =3D self._verify_latency(app.run_app(),
> "kasumi_f8_kasumi_f9")
> -        self._print_stats(results)
> -        for result in results:
> -            verify(
> -                result["passed"] =3D=3D "PASS",
> -                "latency was greater than the delta tolerance above
> baseline",
> -            )
> +            self._logger.info(f"Running configured test: {test_name} in
> {encrypt} mode")
> +            try:
> +                return self._create_summary(
> +                    results=3Dapp.run_app(num_vfs=3D0 if is_vdev else 1)=
,
> +                    params=3Dcombination.get("test_parameters",
> config_list),
> +                    test_name=3Df"{combination.get('name', 'unnamed-test=
')}
> - {encrypt}",
> +                )
> +            # A skip on one test will stop the execution of all tests,
> return empty summary.
> +            except SkippedTestException as e:
> +                self._logger.error(f"test {test_name} skipped: {str(e)}"=
)
> +                return []
> +
> +        test_cases_skipped: int =3D 0
> +        failed: bool =3D False
> +        reason: str =3D ""
> +        # Execute all cipher only tests and verify
> +        for combination in self.cipher_tests:
> +            test_name =3D combination.get("name", "unnamed_test")
> +            combination_results =3D [(test(mode)) for mode in
> EncryptDecryptSwitch]
> +            if all(result =3D=3D [] for result in combination_results):
> +                test_cases_skipped +=3D 1
> +            else:
> +                try:
> +                    self._print_and_verify(combination_results)
> +                except TestCaseVerifyError as e:
> +                    failed =3D True
> +                    reason =3D f"{reason}\n{str(e)}" if reason else str(=
e)
> +        if failed:
> +            fail(reason)
> +        if test_cases_skipped =3D=3D len(self.cipher_tests):
> +            skip("All configured test cases skipped.")
>
>      @crypto_test
> -    def snow3g_uea2_snow3g_uia2(self) -> None:
> -        """snow3g_uea2_snow3g_uia2 latency test.
> +    def auth_only_tests(self) -> None:
> +        """Authentication cryptography device tests.
>
>          Steps:
> -            * Create a cryptodev instance with provided device type and
> buffer sizes.
> +            * Run dpdk-test-crypto-perf application with configured
> parameters in authentication
> +                only moode.
>          Verify:
> -            * The latency is below or within delta of provided baseline.
> -
> -        Raises:
> -            SkippedTestException: When configuration is not provided.
> +            * The resulting statistics are within a delta tolerance of a
> provided baseline.
>          """
> -        if "snow3g_uea2_snow3g_uia2" not in self.latency_test_parameters=
:
> -            skip("test not configured")
> -        app =3D Cryptodev(
> -            ptest=3DTestType.latency,
> -            devtype=3Dself.device_type,
> -            optype=3DOperationType.cipher_then_auth,
> -            cipher_algo=3DCipherAlgorithm.snow3g_uea2,
> -            cipher_op=3DEncryptDecryptSwitch.encrypt,
> -            cipher_key_sz=3D16,
> -            cipher_iv_sz=3D16,
> -            auth_algo=3DAuthenticationAlgorithm.snow3g_uia2,
> -            auth_op=3DAuthenticationOpMode.generate,
> -            auth_key_sz=3D16,
> -            auth_iv_sz=3D16,
> -            digest_sz=3D4,
> -            total_ops=3DTOTAL_OPS,
> -            buffer_sz=3Dself.buffer_sizes["snow3g_uea2_snow3g_uia2"],
> -        )
> -        results =3D self._verify_latency(app.run_app(),
> "snow3g_uea2_snow3g_uia2")
> -        self._print_stats(results)
> -        for result in results:
> -            verify(
> -                result["passed"] =3D=3D "PASS",
> -                "latency was greater than the delta tolerance above
> baseline",
> -            )
> -
> -    @crypto_test
> -    def zuc_eea3_zuc_eia3(self) -> None:
> -        """zuc_eea3_zuc_eia3 cipher and auth latency test.
>
> -        Steps:
> -            * Create a cryptodev instance with provided device type and
> buffer sizes.
> -        Verify:
> -            * The latency is below or within delta of provided baseline.
> -
> -        Raises:
> -            SkippedTestException: When configuration is not provided.
> -        """
> -        if "zuc_eea3_zuc_eia3" not in self.latency_test_parameters:
> -            skip("test not configured")
> -        app =3D Cryptodev(
> -            ptest=3DTestType.latency,
> -            devtype=3Dself.device_type,
> -            optype=3DOperationType.cipher_then_auth,
> -            cipher_algo=3DCipherAlgorithm.zuc_eea3,
> -            cipher_op=3DEncryptDecryptSwitch.encrypt,
> -            cipher_key_sz=3D16,
> -            cipher_iv_sz=3D16,
> -            auth_algo=3DAuthenticationAlgorithm.zuc_eia3,
> -            auth_op=3DAuthenticationOpMode.generate,
> -            auth_key_sz=3D16,
> -            auth_iv_sz=3D16,
> -            digest_sz=3D4,
> -            total_ops=3DTOTAL_OPS,
> -            buffer_sz=3Dself.buffer_sizes["zuc_eea3_zuc_eia3"],
> -        )
> -        results =3D self._verify_latency(app.run_app(), "zuc_eea3_zuc_ei=
a3")
> -        self._print_stats(results)
> -        for result in results:
> -            verify(
> -                result["passed"] =3D=3D "PASS",
> -                "latency was greater than the delta tolerance above
> baseline",
> +        def test(op_mode: AuthenticationOpMode) -> list[dict[str, int |
> float | str]]:
> +            """Run a configured throughput test with the given
> authentication mode.
> +
> +            Args:
> +                op_mode: The authentication op mode to run testing in.
> +
> +            Returns:
> +                The generated summary or an empty list if a test is
> skipped.
> +            """
> +            auth_params =3D AUTHENTICATION_ALGORITHM_PARAMS[
> +                AuthenticationAlgorithm[combination["auth_algorithm"]]
> +            ]
> +            is_vdev: bool =3D "virtual_device" in combination
> +            app =3D Cryptodev(
> +                ptest=3DTestType.latency,
> +                devtype=3Dself.device_type,
> +                optype=3DOperationType.auth_only,
> +
> auth_algo=3DAuthenticationAlgorithm[combination["auth_algorithm"]],
> +                auth_op=3Dop_mode,
> +                auth_key_sz=3Dcombination.get("auth_key_size",
> auth_params["key_size"]),
> +                auth_iv_sz=3Dcombination.get("auth_iv_size",
> auth_params["iv_size"]),
> +                total_ops=3Dcombination.get("ops", self.ops),
> +                digest_sz=3Dcombination.get("digest_size", 0),
> +                buffer_sz=3Dself.buffer_sizes[combination["name"]],
>              )
> +            if is_vdev:
> +                app.update_params(
> +                    vdevs=3D[VirtualDevice(combination["virtual_device"]=
)],
> +
> devtype=3Dget_device_from_str(combination["virtual_device"]),
> +                )
>
> -    # BEGIN VDEV TESTS
> -
> -    @crypto_test
> -    def aesni_gcm_vdev(self) -> None:
> -        """aesni_gcm virtual device latency test.
> -
> -        Steps:
> -            * Create a cryptodev instance with provided device type and
> buffer sizes.
> -        Verify:
> -            * The latency is below or within delta of provided baseline.
> -
> -        Raises:
> -            SkippedTestException: When configuration is not provided.
> -        """
> -        if "aesni_gcm_vdev" not in self.latency_test_parameters:
> -            skip("test not configured")
> -        app =3D Cryptodev(
> -            ptest=3DTestType.latency,
> -            vdevs=3D[VirtualDevice("crypto_aesni_gcm0")],
> -            devtype=3DDeviceType.crypto_aesni_gcm,
> -            optype=3DOperationType.aead,
> -            aead_op=3DEncryptDecryptSwitch.encrypt,
> -            aead_key_sz=3D16,
> -            aead_iv_sz=3D12,
> -            aead_aad_sz=3D16,
> -            digest_sz=3D16,
> -            burst_sz=3D32,
> -            total_ops=3DTOTAL_OPS,
> -            buffer_sz=3Dself.buffer_sizes["aesni_gcm_vdev"],
> -        )
> -        results =3D self._verify_latency(app.run_app(num_vfs=3D0),
> "aesni_gcm_vdev")
> -        self._print_stats(results)
> -        for result in results:
> -            verify(
> -                result["passed"] =3D=3D "PASS",
> -                "latency was greater than the delta tolerance above
> baseline",
> -            )
> +            self._logger.info(f"Running configured test: {test_name} in
> {op_mode} mode")
> +            try:
> +                return self._create_summary(
> +                    results=3Dapp.run_app(num_vfs=3D0 if is_vdev else 1)=
,
> +                    params=3Dcombination.get("test_parameters",
> config_list),
> +                    test_name=3Df"{combination.get('name', 'unnamed-test=
')}
> - {op_mode}",
> +                )
> +            # A skip on one test will stop the execution of all tests,
> return empty summary.
> +            except SkippedTestException as e:
> +                self._logger.error(f"failed to run test {test_name}:
> {str(e)}")
> +                return []
> +
> +        test_cases_skipped: int =3D 0
> +        failed: bool =3D False
> +        reason: str =3D ""
> +        # Execute all auth only tests and verify
> +        for combination in self.auth_tests:
> +            test_name =3D combination.get("name", "unnamed_test")
> +            combination_results =3D [(test(AuthenticationOpMode.generate=
))]
> +            if all(result =3D=3D [] for result in combination_results):
> +                test_cases_skipped +=3D 1
> +            else:
> +                try:
> +                    self._print_and_verify(combination_results)
> +                except TestCaseVerifyError as e:
> +                    failed =3D True
> +                    reason =3D f"{reason}\n{str(e)}" if reason else str(=
e)
> +        if failed:
> +            fail(reason)
> +        if test_cases_skipped =3D=3D len(self.auth_tests):
> +            skip("All configured test cases skipped.")
>
>      @crypto_test
> -    def aesni_mb_cipher_then_auth_vdev(self) -> None:
> -        """aesni_mb vdev cipher and auth latency test.
> +    def aead_test(self) -> None:
> +        """Aead cryptography test.
>
>          Steps:
> -            * Create a cryptodev instance with provided device type and
> buffer sizes.
> +            * Run dpdk-test-crypto-perf application with configured
> parameters in aead mode.
>          Verify:
> -            * The latency is below or within delta of provided baseline.
> -
> -        Raises:
> -            SkippedTestException: When configuration is not provided.
> +            * The resulting statistics are within a delta tolerance of a
> given baseline.
>          """
> -        if "aesni_mb_cipher_then_auth_vdev" not in
> self.latency_test_parameters:
> -            skip("test not configured")
> -        app =3D Cryptodev(
> -            ptest=3DTestType.latency,
> -            vdevs=3D[VirtualDevice("crypto_aesni_mb0")],
> -            devtype=3DDeviceType.crypto_aesni_mb,
> -            optype=3DOperationType.cipher_then_auth,
> -            cipher_algo=3DCipherAlgorithm.aes_cbc,
> -            cipher_op=3DEncryptDecryptSwitch.encrypt,
> -            cipher_key_sz=3D16,
> -            auth_algo=3DAuthenticationAlgorithm.sha1_hmac,
> -            auth_op=3DAuthenticationOpMode.generate,
> -            auth_key_sz=3D64,
> -            digest_sz=3D12,
> -            burst_sz=3D32,
> -            total_ops=3DTOTAL_OPS,
> -            buffer_sz=3Dself.buffer_sizes["aesni_mb_cipher_then_auth_vde=
v"],
> -        )
> -        results =3D self._verify_latency(app.run_app(num_vfs=3D0),
> "aesni_mb_cipher_then_auth_vdev")
> -        self._print_stats(results)
> -        for result in results:
> -            verify(
> -                result["passed"] =3D=3D "PASS",
> -                "latency was greater than the delta tolerance above
> baseline",
> -            )
> -
> -    @crypto_test
> -    def aesni_mb_vdev(self) -> None:
> -        """aesni_mb vdev latency test.
>
> -        Steps:
> -            * Create a cryptodev instance with provided device type and
> buffer sizes.
> -        Verify:
> -            * The latency is below or within delta of provided baseline.
> -
> -        Raises:
> -            SkippedTestException: When configuration is not provided.
> -        """
> -        if "aesni_mb_vdev" not in self.latency_test_parameters:
> -            skip("test not configured")
> -        app =3D Cryptodev(
> -            ptest=3DTestType.latency,
> -            vdevs=3D[VirtualDevice("crypto_aesni_mb0")],
> -            devtype=3DDeviceType.crypto_aesni_mb,
> -            optype=3DOperationType.cipher_only,
> -            cipher_algo=3DCipherAlgorithm.aes_cbc,
> -            cipher_op=3DEncryptDecryptSwitch.encrypt,
> -            cipher_key_sz=3D16,
> -            cipher_iv_sz=3D16,
> -            burst_sz=3D32,
> -            total_ops=3DTOTAL_OPS,
> -            buffer_sz=3Dself.buffer_sizes["aesni_mb_vdev"],
> -        )
> -        results =3D self._verify_latency(app.run_app(num_vfs=3D0),
> "aesni_mb_vdev")
> -        self._print_stats(results)
> -        for result in results:
> -            verify(
> -                result["passed"] =3D=3D "PASS",
> -                "latency was greater than the delta tolerance above
> baseline",
> +        def test() -> list[dict[str, int | float | str]]:
> +            """Execute the dpdk-test-crypto application and verify.
> +
> +            Args:
> +                encrypt: The authentication operation mode to run the
> cryptodev application in.
> +
> +            Returns:
> +                The generated summary or an empty list if a test is
> skipped.
> +            """
> +            is_vdev: bool =3D "virtual_device" in combination
> +            aead_params =3D
> AEAD_ALGORITHM_PARAMS[AeadAlgName[combination["aead_algorithm"]]]
> +            app =3D Cryptodev(
> +                ptest=3DTestType.latency,
> +                devtype=3Dself.device_type,
> +                optype=3DOperationType.aead,
> +                aead_algo=3DAeadAlgName[combination["aead_algorithm"]],
> +                aead_op=3Dcombination.get("aead_op",
> EncryptDecryptSwitch.encrypt),
> +                aead_key_sz=3Dcombination.get("aead_key_size",
> aead_params["key_size"]),
> +                aead_iv_sz=3Dcombination.get("aead_iv_size",
> aead_params["iv_size"]),
> +                aead_aad_sz=3Dcombination.get("aead_size",
> aead_params["aad_size"]),
> +                digest_sz=3Dcombination.get("digest_size",
> aead_params["digest_size"]),
> +                total_ops=3Dcombination.get("ops", self.ops),
> +                buffer_sz=3Dself.buffer_sizes[combination["name"]],
>              )
> +            if is_vdev:
> +                app.update_params(
> +                    vdevs=3D[VirtualDevice(combination["virtual_device"]=
)],
> +
> devtype=3Dget_device_from_str(combination["virtual_device"]),
> +                )
> +            if combination.get("aead_op", None) =3D=3D
> EncryptDecryptSwitch.decrypt:
> +                app.update_params(
> +                    out_of_place=3Dcombination.get("out_of_place", True)=
,
> +                )
>
> -    @crypto_test
> -    def kasumi_vdev(self) -> None:
> -        """Kasumi vdev latency test.
> -
> -        Steps:
> -            * Create a cryptodev instance with provided device type and
> buffer sizes.
> -        Verify:
> -            * The latency is below or within delta of provided baseline.
> -
> -        Raises:
> -            SkippedTestException: When configuration is not provided.
> -        """
> -        if "kasumi_vdev" not in self.latency_test_parameters:
> -            skip("test not configured")
> -        app =3D Cryptodev(
> -            ptest=3DTestType.latency,
> -            vdevs=3D[VirtualDevice("crypto_kasumi0")],
> -            devtype=3DDeviceType.crypto_kasumi,
> -            optype=3DOperationType.cipher_then_auth,
> -            cipher_algo=3DCipherAlgorithm.kasumi_f8,
> -            cipher_op=3DEncryptDecryptSwitch.encrypt,
> -            cipher_key_sz=3D16,
> -            cipher_iv_sz=3D8,
> -            auth_algo=3DAuthenticationAlgorithm.kasumi_f9,
> -            auth_op=3DAuthenticationOpMode.generate,
> -            auth_key_sz=3D16,
> -            digest_sz=3D4,
> -            burst_sz=3D32,
> -            total_ops=3DTOTAL_OPS,
> -            buffer_sz=3Dself.buffer_sizes["kasumi_vdev"],
> -        )
> -        results =3D self._verify_latency(app.run_app(num_vfs=3D0),
> "kasumi_vdev")
> -        self._print_stats(results)
> -        for result in results:
> -            verify(
> -                result["passed"] =3D=3D "PASS",
> -                "latency was greater than the delta tolerance above
> baseline",
> -            )
> +            self._logger.info(f"Running configured test: {test_name}")
> +            try:
> +                return self._create_summary(
> +                    results=3Dapp.run_app(num_vfs=3D0 if is_vdev else 1)=
,
> +                    params=3Dcombination.get("test_parameters",
> config_list),
> +                    test_name=3Df"{combination.get('name',
> 'unnamed-test')}",
> +                )
> +            # Exceptions will stop the execution of all tests, return an
> empty result and continue.
> +            except SkippedTestException as e:
> +                self._logger.error(f"failed to run test {test_name}:
> {str(e)}")
> +                return []
> +
> +        test_cases_skipped: int =3D 0
> +        failed: bool =3D False
> +        reason: str =3D ""
> +        # Execute all aead tests and verify
> +        for combination in self.aead_tests:
> +            test_name =3D combination.get("name", "unnamed_test")
> +            combination_results =3D [test()]
> +            if all(result =3D=3D [] for result in combination_results):
> +                test_cases_skipped +=3D 1
> +            else:
> +                try:
> +                    self._print_and_verify(combination_results)
> +                except TestCaseVerifyError as e:
> +                    failed =3D True
> +                    reason =3D f"{reason}\n{str(e)}" if reason else str(=
e)
> +        if failed:
> +            fail(reason)
> +        if test_cases_skipped =3D=3D len(self.aead_tests):
> +            skip("All configured test cases skipped.")
>
>      @crypto_test
> -    def open_ssl_vdev(self) -> None:
> -        """open_ssl vdev latency test.
> +    def cipher_and_auth_tests(self) -> None:
> +        """Cipher and Authentication tests.
>
>          Steps:
> -            * Create a cryptodev instance with provided device type and
> buffer sizes.
> +            * Run dpdk-test-crypto-perf application in cipher then
> authentication mode
>          Verify:
> -            * The latency is below or within delta of provided baseline.
> -
> -        Raises:
> -            SkippedTestException: When configuration is not provided.
> +            * The resulting statistics are within a delta tolerance of a
> given baseline.
>          """
> -        if "open_ssl_vdev" not in self.latency_test_parameters:
> -            skip("test not configured")
> -        app =3D Cryptodev(
> -            ptest=3DTestType.latency,
> -            vdevs=3D[VirtualDevice("crypto_openssl0")],
> -            devtype=3DDeviceType.crypto_openssl,
> -            optype=3DOperationType.aead,
> -            aead_algo=3DAeadAlgName.aes_gcm,
> -            aead_op=3DEncryptDecryptSwitch.encrypt,
> -            aead_key_sz=3D16,
> -            aead_iv_sz=3D16,
> -            aead_aad_sz=3D16,
> -            digest_sz=3D16,
> -            total_ops=3DTOTAL_OPS,
> -            buffer_sz=3Dself.buffer_sizes["open_ssl_vdev"],
> -        )
> -        results =3D self._verify_latency(app.run_app(num_vfs=3D0),
> "open_ssl_vdev")
> -        self._print_stats(results)
> -        for result in results:
> -            verify(
> -                result["passed"] =3D=3D "PASS",
> -                "latency was greater than the delta tolerance above
> baseline",
> -            )
>
> -    @crypto_test
> -    def snow3g_vdev(self) -> None:
> -        """snow3g vdev latency test.
> -
> -        Steps:
> -            * Create a cryptodev instance with provided device type and
> buffer sizes.
> -        Verify:
> -            * The latency is below or within delta of provided baseline.
> -
> -        Raises:
> -            SkippedTestException: When configuration is not provided.
> -        """
> -        if "snow3g_vdev" not in self.latency_test_parameters:
> -            skip("test not configured")
> -        app =3D Cryptodev(
> -            ptest=3DTestType.latency,
> -            vdevs=3D[VirtualDevice("crypto_snow3g0")],
> -            devtype=3DDeviceType.crypto_snow3g,
> -            optype=3DOperationType.cipher_then_auth,
> -            cipher_algo=3DCipherAlgorithm.snow3g_uea2,
> -            cipher_op=3DEncryptDecryptSwitch.encrypt,
> -            cipher_key_sz=3D16,
> -            cipher_iv_sz=3D16,
> -            auth_algo=3DAuthenticationAlgorithm.snow3g_uia2,
> -            auth_op=3DAuthenticationOpMode.generate,
> -            auth_key_sz=3D16,
> -            auth_iv_sz=3D16,
> -            digest_sz=3D16,
> -            burst_sz=3D32,
> -            total_ops=3DTOTAL_OPS,
> -            buffer_sz=3Dself.buffer_sizes["snow3g_vdev"],
> -        )
> -        results =3D self._verify_latency(app.run_app(num_vfs=3D0),
> "snow3g_vdev")
> -        self._print_stats(results)
> -        for result in results:
> -            verify(
> -                result["passed"] =3D=3D "PASS",
> -                "latency was greater than the delta tolerance above
> baseline",
> +        def test(
> +            encrypt: EncryptDecryptSwitch, op_mode: AuthenticationOpMode
> +        ) -> list[dict[str, int | float | str]]:
> +            """Execute the dpdk-test-crypto application and verify.
> +
> +            Args:
> +                encrypt: The cipher encryption mode to run latency
> testing in.
> +                op_mode: The authentication operation mode to run the
> cryptodev application in.
> +
> +            Returns:
> +                The generated summary or an empty list if a test is
> skipped.
> +            """
> +            is_vdev: bool =3D "virtual_device" in combination
> +            cipher_params =3D CIPHER_ALGORITHM_PARAMS[
> +                CipherAlgorithm[combination["cipher_algorithm"]]
> +            ]
> +            auth_params =3D AUTHENTICATION_ALGORITHM_PARAMS[
> +                AuthenticationAlgorithm[combination["auth_algorithm"]]
> +            ]
> +            app =3D Cryptodev(
> +                ptest=3DTestType.latency,
> +                devtype=3Dself.device_type,
> +                optype=3DOperationType.aead,
> +
> cipher_algo=3DCipherAlgorithm[combination["cipher_algorithm"]],
> +                cipher_op=3Dencrypt,
> +                cipher_key_sz=3Dcombination.get("cipher_key_size",
> cipher_params["key_size"]),
> +                cipher_iv_sz=3Dcombination.get("cipher_iv_size",
> cipher_params["iv_size"]),
> +
> auth_algo=3DAuthenticationAlgorithm[combination["auth_algorithm"]],
> +                auth_op=3Dop_mode,
> +                auth_key_sz=3Dcombination.get("auth_key_size",
> auth_params["key_size"]),
> +                auth_iv_sz=3Dcombination.get("auth_iv_size",
> auth_params["iv_size"]),
> +                total_ops=3Dcombination.get("ops", self.ops),
> +                digest_sz=3Dcombination.get("digest_size", 0),
> +                buffer_sz=3Dself.buffer_sizes[combination["name"]],
>              )
> +            if is_vdev:
> +                app.update_params(
> +                    vdevs=3D[VirtualDevice(combination["virtual_device"]=
)],
> +
> devtype=3Dget_device_from_str(combination["virtual_device"]),
> +                )
>
> -    @crypto_test
> -    def zuc_vdev(self) -> None:
> -        """Zuc vdev latency test.
> -
> -        Steps:
> -            * Create a cryptodev instance with provided device type and
> buffer sizes.
> -        Verify:
> -            * The latency is below or within delta of provided baseline.
> -
> -        Raises:
> -            SkippedTestException: When configuration is not provided.
> -        """
> -        if "zuc_vdev" not in self.latency_test_parameters:
> -            skip("test not configured")
> -        app =3D Cryptodev(
> -            ptest=3DTestType.latency,
> -            vdevs=3D[VirtualDevice("crypto_zuc0")],
> -            devtype=3DDeviceType.crypto_zuc,
> -            optype=3DOperationType.cipher_then_auth,
> -            cipher_algo=3DCipherAlgorithm.zuc_eea3,
> -            cipher_op=3DEncryptDecryptSwitch.encrypt,
> -            cipher_key_sz=3D16,
> -            cipher_iv_sz=3D16,
> -            auth_algo=3DAuthenticationAlgorithm.zuc_eia3,
> -            auth_op=3DAuthenticationOpMode.generate,
> -            auth_key_sz=3D16,
> -            auth_iv_sz=3D16,
> -            digest_sz=3D4,
> -            burst_sz=3D32,
> -            total_ops=3DTOTAL_OPS,
> -            buffer_sz=3Dself.buffer_sizes["zuc_vdev"],
> -        )
> -        results =3D self._verify_latency(app.run_app(num_vfs=3D0), "zuc_=
vdev")
> -        self._print_stats(results)
> -        for result in results:
> -            verify(
> -                result["passed"] =3D=3D "PASS",
> -                "latency was greater than the delta tolerance above
> baseline",
> -            )
> +            self._logger.info(f"Running configured test: {test_name} in
> {encrypt} mode")
> +            try:
> +                return self._create_summary(
> +                    results=3Dapp.run_app(num_vfs=3D0 if is_vdev else 1)=
,
> +                    params=3Dcombination.get("test_parameters",
> config_list),
> +                    test_name=3Df"{combination.get('name', 'unnamed-test=
')}
> - {encrypt}",
> +                )
> +            # Exceptions will stop the execution of all tests, return an
> empty result and continue.
> +            except SkippedTestException as e:
> +                self._logger.error(f"failed to run test {test_name}:
> {str(e)}")
> +                return []
> +
> +        test_cases_skipped: int =3D 0
> +        failed: bool =3D False
> +        reason: str =3D ""
> +        # Execute all cipher_then_auth tests and verify
> +        for combination in self.cipher_then_auth_tests:
> +            print(str(combination))
> +            test_name =3D combination.get("name", "unnamed_test")
> +            combination_results =3D [
> +                test(mode, AuthenticationOpMode.generate) for mode in
> EncryptDecryptSwitch
> +            ]
> +            if all(result =3D=3D [] for result in combination_results):
> +                test_cases_skipped +=3D 1
> +            else:
> +                try:
> +                    self._print_and_verify(combination_results)
> +                except TestCaseVerifyError as e:
> +                    failed =3D True
> +                    reason =3D f"{reason}\n{str(e)}" if reason else str(=
e)
> +        if failed:
> +            fail(reason)
> +        if test_cases_skipped =3D=3D len(self.cipher_then_auth_tests):
> +            skip("All configured test cases skipped.")
> --
> 2.55.0
>
>

--00000000000097d2e5065ed4d70c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+UmV2aWV3ZWQtYnk6IEtvdXNoaWsgQmhhcmdhdiBOaW1vamkgJmx0Ozo8
YSBocmVmPSJtYWlsdG86a25pbW9qaUBpb2wudW5oLmVkdSI+a25pbW9qaUBpb2wudW5oLmVkdTwv
YT4mZ3Q7PC9kaXY+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIGdtYWlsX3F1b3RlX2NvbnRh
aW5lciI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIE1vbiwgT2N0IDE5LCAy
MDI2IGF0IDQ6MDTigK9QTSBBbmRyZXcgQmFpbGV5ICZsdDs8YSBocmVmPSJtYWlsdG86YWJhaWxl
eUBpb2wudW5oLmVkdSI+YWJhaWxleUBpb2wudW5oLmVkdTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rp
dj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAw
cHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1s
ZWZ0OjFleCI+UHJldmlvdXNseSwgY3J5cHRvZGV2IGxhdGVuY3kgdGVzdGluZyBvbmx5IGNvdmVy
ZWQgYSBoYW5kZnVsIG9mPGJyPg0KYWxnb3JpdGhtIGNvbWJpbmF0aW9ucyBhbmQgdmlydHVhbCBk
ZXZpY2UgdHlwZXMgZm9yIHRlc3RpbmcuIFRoZSBuZXc8YnI+DQppbXBsZW1lbnRhdGlvbiBtYWtl
cyB0aGlzIHRlc3QgY29tcGxldGVseSBjb25maWd1cmFibGUgdG8gcnVuIGFueTxicj4NCmNvbWJp
bmF0aW9uIG9mIGFyZ3VtZW50cyBwcm92aWRlZCB0aHJvdWdoIHRoZSB0ZXN0cyBjb25maWd1cmF0
aW9uIGZpbGUuPGJyPg0KPGJyPg0KU2lnbmVkLW9mZi1ieTogQW5kcmV3IEJhaWxleSAmbHQ7PGEg
aHJlZj0ibWFpbHRvOmFiYWlsZXlAaW9sLnVuaC5lZHUiIHRhcmdldD0iX2JsYW5rIj5hYmFpbGV5
QGlvbC51bmguZWR1PC9hPiZndDs8YnI+DQotLS08YnI+DQrCoGR0cy9jb25maWd1cmF0aW9ucy90
ZXN0c19jb25maWcuZXhhbXBsZS55YW1sIHzCoCDCoDE3ICs8YnI+DQrCoGR0cy90ZXN0cy9UZXN0
U3VpdGVfY3J5cHRvZGV2X2xhdGVuY3kucHnCoCDCoCDCoHwgMTA0NCArKysrKysrKy0tLS0tLS0t
LS08YnI+DQrCoDIgZmlsZXMgY2hhbmdlZCwgNDgxIGluc2VydGlvbnMoKyksIDU4MCBkZWxldGlv
bnMoLSk8YnI+DQo8YnI+DQpkaWZmIC0tZ2l0IGEvZHRzL2NvbmZpZ3VyYXRpb25zL3Rlc3RzX2Nv
bmZpZy5leGFtcGxlLnlhbWwgYi9kdHMvY29uZmlndXJhdGlvbnMvdGVzdHNfY29uZmlnLmV4YW1w
bGUueWFtbDxicj4NCmluZGV4IGZlNGJlZDI4NDcuLjQ1MGE2Y2M1ZTcgMTAwNjQ0PGJyPg0KLS0t
IGEvZHRzL2NvbmZpZ3VyYXRpb25zL3Rlc3RzX2NvbmZpZy5leGFtcGxlLnlhbWw8YnI+DQorKysg
Yi9kdHMvY29uZmlndXJhdGlvbnMvdGVzdHNfY29uZmlnLmV4YW1wbGUueWFtbDxicj4NCkBAIC02
Niw2ICs2NiwyMyBAQCBoZWxsb193b3JsZDo8YnI+DQrCoCPCoCDCoCDCoCDCoCDCoC0gYnVmZl9z
aXplOiA2NDxicj4NCsKgI8KgIMKgIMKgIMKgIMKgIMKgR2JwczogMS41PGJyPg0KPGJyPg0KKyMg
Y3J5cHRvZGV2X2xhdGVuY3k6PGJyPg0KKyPCoCDCoCMgSWRlbnRpY2FsIHRvIGNyeXB0b2Rldl90
aHJvdWdocHV0IGNvbmZpZ3VyYXRpb24gYmVzaWRlcyB1cGRhdGVkIHRlc3RfcGFyYW1ldGVycyBi
ZWxvdy48YnI+DQorI8KgIMKgZGVsdGFfdG9sZXJhbmNlOiAwLjA1PGJyPg0KKyPCoCDCoCDCoC0g
bmFtZTogJnF1b3Q7ZXhhbXBsZSBjaXBoZXIgdGVzdCZxdW90OyAjIEFkZCBhIG5hbWUgZm9yIHRo
aXMgdGVzdCBjb25maWc8YnI+DQorI8KgIMKgIMKgIMKgY2lwaGVyX2FsZ29yaXRobTogJnF1b3Q7
YWVzX2NiYyZxdW90OyAjIFNlZSBgYWxnb3J0aWhtc2AgaW4gYE9wdGlvbmFsIEZpZWxkc2AgZm9y
IGEgY29tcGxldGUgbGlzdDxicj4NCisjwqAgwqAgwqAgwqB2aXJ0dWFsX2RldmljZTogJnF1b3Q7
Y3J5cHRvX29wZW5zc2wmcXVvdDsgIyB1bmNvbW1lbnQgdG8gcnVuIHdpdGggYSB2aXJ0dWFsIGRl
dmljZS48YnI+DQorI8KgIMKgIMKgIMKgdGVzdF9wYXJhbWV0ZXJzOsKgICMgQnVmZmVyIHNpemVz
IGFuZCBleHBlY3RlZCB0aHJvdWdocHV0LCBhIGRlZmF1bHQgaXMgdXNlZCBpZiBub3QgcHJlc2Vu
dDxicj4NCisjwqAgwqAgwqAgwqAgLSBidWZmX3NpemU6IDY0PGJyPg0KKyPCoCDCoCDCoCDCoCDC
oCBhdmdfY3ljbGVzOiA5OTk5OTk8YnI+DQorI8KgIMKgIMKgIMKgIMKgIGF2Z190aW1lX3VzOiA5
OTk5OTk8YnI+DQorI8KgIMKgIMKgIMKgIC0gYnVmZl9zaXplOiA1MTI8YnI+DQorI8KgIMKgIMKg
IMKgIMKgIGF2Z19jeWNsZXM6IDk5OTk5OTxicj4NCisjwqAgwqAgwqAgwqAgwqAgYXZnX3RpbWVf
dXM6IDk5OTk5OTxicj4NCisjwqAgwqAgwqAgwqAgLSBidWZmX3NpemU6IDIwNDg8YnI+DQorI8Kg
IMKgIMKgIMKgIMKgIGF2Z19jeWNsZXM6IDk5OTk5OTxicj4NCisjwqAgwqAgwqAgwqAgwqAgYXZn
X3RpbWVfdXM6IDk5OTk5OTxicj4NCis8YnI+DQrCoCMgcG9ydF9zcGVlZF9jYXBhYmlsaXRpZXM6
PGJyPg0KwqAjwqAgwqB0ZXN0X3BhcmFtZXRlcnM6PGJyPg0KwqAjwqAgwqAgwqAwIDogMTAwIEdi
cHMgIyBBc3NpZ24gYW4gZXhwZWN0ZWQgbGluayBzcGVlZCB0byBhIHBvcnQgSUQgaW4gR2Jwczxi
cj4NCmRpZmYgLS1naXQgYS9kdHMvdGVzdHMvVGVzdFN1aXRlX2NyeXB0b2Rldl9sYXRlbmN5LnB5
IGIvZHRzL3Rlc3RzL1Rlc3RTdWl0ZV9jcnlwdG9kZXZfbGF0ZW5jeS5weTxicj4NCmluZGV4IDQ0
NGE1YjI4MmMuLmE5ZTk2M2JkZmIgMTAwNjQ0PGJyPg0KLS0tIGEvZHRzL3Rlc3RzL1Rlc3RTdWl0
ZV9jcnlwdG9kZXZfbGF0ZW5jeS5weTxicj4NCisrKyBiL2R0cy90ZXN0cy9UZXN0U3VpdGVfY3J5
cHRvZGV2X2xhdGVuY3kucHk8YnI+DQpAQCAtOSw2ICs5LDggQEA8YnI+DQrCoGVuc3VyZSBwZXJm
b3JtYW5jZSBzdGFuZGFyZHMgYXJlIG1ldC48YnI+DQrCoCZxdW90OyZxdW90OyZxdW90Ozxicj4N
Cjxicj4NCitmcm9tIHR5cGluZyBpbXBvcnQgQW55PGJyPg0KKzxicj4NCsKgZnJvbSBhcGkuY2Fw
YWJpbGl0aWVzIGltcG9ydCAoPGJyPg0KwqAgwqAgwqBMaW5rVG9wb2xvZ3ksPGJyPg0KwqAgwqAg
wqByZXF1aXJlc19saW5rX3RvcG9sb2d5LDxicj4NCkBAIC0xNiw2ICsxOCw5IEBAPGJyPg0KwqBm
cm9tIGFwaS5jb250ZXh0IGltcG9ydCBnZXRfY3R4PGJyPg0KwqBmcm9tIGFwaS5jcnlwdG9kZXYg
aW1wb3J0IENyeXB0b2Rldjxicj4NCsKgZnJvbSBhcGkuY3J5cHRvZGV2LmNvbmZpZyBpbXBvcnQg
KDxicj4NCivCoCDCoCBBRUFEX0FMR09SSVRITV9QQVJBTVMsPGJyPg0KK8KgIMKgIEFVVEhFTlRJ
Q0FUSU9OX0FMR09SSVRITV9QQVJBTVMsPGJyPg0KK8KgIMKgIENJUEhFUl9BTEdPUklUSE1fUEFS
QU1TLDxicj4NCsKgIMKgIMKgQWVhZEFsZ05hbWUsPGJyPg0KwqAgwqAgwqBBdXRoZW50aWNhdGlv
bkFsZ29yaXRobSw8YnI+DQrCoCDCoCDCoEF1dGhlbnRpY2F0aW9uT3BNb2RlLDxicj4NCkBAIC0z
MCwxNCArMzUsMTUgQEA8YnI+DQrCoGZyb20gYXBpLmNyeXB0b2Rldi50eXBlcyBpbXBvcnQgKDxi
cj4NCsKgIMKgIMKgQ3J5cHRvZGV2UmVzdWx0cyw8YnI+DQrCoCk8YnI+DQotZnJvbSBhcGkudGVz
dCBpbXBvcnQgc2tpcCwgdmVyaWZ5PGJyPg0KK2Zyb20gYXBpLmV4Y2VwdGlvbiBpbXBvcnQgQ29u
ZmlndXJhdGlvbkVycm9yLCBTa2lwcGVkVGVzdEV4Y2VwdGlvbiwgVGVzdENhc2VWZXJpZnlFcnJv
cjxicj4NCitmcm9tIGFwaS50ZXN0IGltcG9ydCBmYWlsLCBza2lwLCB2ZXJpZnk8YnI+DQrCoGZy
b20gYXBpLnRlc3Rfc3VpdGUgaW1wb3J0IEJhc2VDb25maWcsIFRlc3RTdWl0ZSwgY3J5cHRvX3Rl
c3Q8YnI+DQrCoGZyb20gYXBpLnRlc3RiZWRfbW9kZWwudmlydHVhbF9kZXZpY2UgaW1wb3J0IFZp
cnR1YWxEZXZpY2U8YnI+DQo8YnI+DQrCoGNvbmZpZ19saXN0OiBsaXN0W2RpY3Rbc3RyLCBpbnQg
fCBmbG9hdCB8IHN0cl1dID0gWzxicj4NCi3CoCDCoCB7JnF1b3Q7YnVmZl9zaXplJnF1b3Q7OiA2
NCwgJnF1b3Q7YXZnX2N5Y2xlcyZxdW90OzogOTlfOTk5LjAwLCAmcXVvdDthdmdfdGltZV91cyZx
dW90OzogOTk5OS4wfSw8YnI+DQotwqAgwqAgeyZxdW90O2J1ZmZfc2l6ZSZxdW90OzogNTEyLCAm
cXVvdDthdmdfY3ljbGVzJnF1b3Q7OiA5OV85OTkuMDAsICZxdW90O2F2Z190aW1lX3VzJnF1b3Q7
OiA5OTk5LjB9LDxicj4NCi3CoCDCoCB7JnF1b3Q7YnVmZl9zaXplJnF1b3Q7OiAyMDQ4LCAmcXVv
dDthdmdfY3ljbGVzJnF1b3Q7OiA5OV85OTkuMDAsICZxdW90O2F2Z190aW1lX3VzJnF1b3Q7OiA5
OTk5LjB9LDxicj4NCivCoCDCoCB7JnF1b3Q7YnVmZl9zaXplJnF1b3Q7OiA2NCwgJnF1b3Q7YXZn
X2N5Y2xlcyZxdW90OzogOTk5Xzk5OV85OTkuMCwgJnF1b3Q7YXZnX3RpbWVfdXMmcXVvdDs6IDk5
OV85OTlfOTk5LjB9LDxicj4NCivCoCDCoCB7JnF1b3Q7YnVmZl9zaXplJnF1b3Q7OiA1MTIsICZx
dW90O2F2Z19jeWNsZXMmcXVvdDs6IDk5OV85OTlfOTk5LjAsICZxdW90O2F2Z190aW1lX3VzJnF1
b3Q7OiA5OTlfOTk5Xzk5OS4wfSw8YnI+DQorwqAgwqAgeyZxdW90O2J1ZmZfc2l6ZSZxdW90Ozog
MjA0OCwgJnF1b3Q7YXZnX2N5Y2xlcyZxdW90OzogOTk5Xzk5OV85OTkuMCwgJnF1b3Q7YXZnX3Rp
bWVfdXMmcXVvdDs6IDk5OV85OTlfOTk5LjB9LDxicj4NCsKgXTxicj4NCjxicj4NCsKgVE9UQUxf
T1BTID0gMTBfMDAwXzAwMDxicj4NCkBAIC00OCw2OSArNTQsMTkxIEBAIGNsYXNzIENvbmZpZyhC
YXNlQ29uZmlnKTo8YnI+DQo8YnI+DQrCoCDCoCDCoEF0dHJpYnV0ZXM6PGJyPg0KwqAgwqAgwqAg
wqAgwqBkZWx0YV90b2xlcmFuY2U6IFRoZSBhbGxvd2VkIHRvbGVyYW5jZSBiZWxvdyBhIGdpdmVu
IGJhc2VsaW5lLjxicj4NCi3CoCDCoCDCoCDCoCBsYXRlbmN5X3Rlc3RfcGFyYW1ldGVyczogVGhl
IHRlc3QgcGFyYW1ldGVycyB0byB1c2UgaW4gdGhlIHRlc3Qgc3VpdGUuPGJyPg0KK8KgIMKgIMKg
IMKgIHRlc3RfY29tYmluYXRpb25zOiBMaXN0IG9mIHRlc3QgY29tYmluYXRpb25zIHdpdGggY2lw
aGVyL2F1dGggYWxnb3JpdGhtcyBhbmQgcGFyYW1ldGVycy48YnI+DQrCoCDCoCDCoCZxdW90OyZx
dW90OyZxdW90Ozxicj4NCjxicj4NCsKgIMKgIMKgZGVsdGFfdG9sZXJhbmNlOiBmbG9hdCA9IDAu
MDU8YnI+DQotPGJyPg0KLcKgIMKgIGxhdGVuY3lfdGVzdF9wYXJhbWV0ZXJzOiBkaWN0W3N0ciwg
bGlzdFtkaWN0W3N0ciwgaW50IHwgZmxvYXQgfCBzdHJdXV0gPSB7PGJyPg0KLcKgIMKgIMKgIMKg
ICZxdW90O2Flc19jYmMmcXVvdDs6IGNvbmZpZ19saXN0LDxicj4NCi3CoCDCoCDCoCDCoCAmcXVv
dDthZXNfY2JjX3NoYTFfaG1hYyZxdW90OzogY29uZmlnX2xpc3QsPGJyPg0KLcKgIMKgIMKgIMKg
ICZxdW90O2Flc19jYmNfc2hhMl9obWFjJnF1b3Q7OiBjb25maWdfbGlzdCw8YnI+DQotwqAgwqAg
wqAgwqAgJnF1b3Q7YWVzX2RvY3Npc2JwaSZxdW90OzogY29uZmlnX2xpc3QsPGJyPg0KLcKgIMKg
IMKgIMKgICZxdW90O2Flc19nY20mcXVvdDs6IGNvbmZpZ19saXN0LDxicj4NCi3CoCDCoCDCoCDC
oCAmcXVvdDtrYXN1bWlfZjhfa2FzdW1pX2Y5JnF1b3Q7OiBjb25maWdfbGlzdCw8YnI+DQotwqAg
wqAgwqAgwqAgJnF1b3Q7c25vdzNnX3VlYTJfc25vdzNnX3VpYTImcXVvdDs6IGNvbmZpZ19saXN0
LDxicj4NCi3CoCDCoCDCoCDCoCAmcXVvdDt6dWNfZWVhM196dWNfZWlhMyZxdW90OzogY29uZmln
X2xpc3QsPGJyPg0KLcKgIMKgIMKgIMKgICZxdW90O2Flc25pX2djbV92ZGV2JnF1b3Q7OiBjb25m
aWdfbGlzdCw8YnI+DQotwqAgwqAgwqAgwqAgJnF1b3Q7YWVzbmlfbWJfY2lwaGVyX3RoZW5fYXV0
aF92ZGV2JnF1b3Q7OiBjb25maWdfbGlzdCw8YnI+DQotwqAgwqAgwqAgwqAgJnF1b3Q7YWVzbmlf
bWJfdmRldiZxdW90OzogY29uZmlnX2xpc3QsPGJyPg0KLcKgIMKgIMKgIMKgICZxdW90O2thc3Vt
aV92ZGV2JnF1b3Q7OiBjb25maWdfbGlzdCw8YnI+DQotwqAgwqAgwqAgwqAgJnF1b3Q7b3Blbl9z
c2xfdmRldiZxdW90OzogY29uZmlnX2xpc3QsPGJyPg0KLcKgIMKgIMKgIMKgICZxdW90O3Nub3cz
Z192ZGV2JnF1b3Q7OiBjb25maWdfbGlzdCw8YnI+DQotwqAgwqAgwqAgwqAgJnF1b3Q7enVjX3Zk
ZXYmcXVvdDs6IGNvbmZpZ19saXN0LDxicj4NCi3CoCDCoCB9PGJyPg0KK8KgIMKgIHRlc3RfY29t
YmluYXRpb25zOiBsaXN0W2RpY3Rbc3RyLCBBbnldXSA9IFs8YnI+DQorwqAgwqAgwqAgwqAgIzog
Y2lwaGVyIG9ubHkgdGVzdHM8YnI+DQorwqAgwqAgwqAgwqAgezxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCAmcXVvdDtuYW1lJnF1b3Q7OiAmcXVvdDthZXMtY2JjJnF1b3Q7LDxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCAmcXVvdDtjaXBoZXJfYWxnb3JpdGhtJnF1b3Q7OiA8YSBocmVmPSJodHRwOi8v
Q2lwaGVyQWxnb3JpdGhtLmFlc19jYmMubmFtZSIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9i
bGFuayI+Q2lwaGVyQWxnb3JpdGhtLmFlc19jYmMubmFtZTwvYT4sPGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgICZxdW90O2NpcGhlcl9rZXlfc3omcXVvdDs6IDE2LDxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCAmcXVvdDtjaXBoZXJfaXZfc3omcXVvdDs6IDE2LDxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCAmcXVvdDtidXJzdF9zeiZxdW90OzogMzIsPGJyPg0KK8KgIMKgIMKgIMKgIH0sPGJyPg0KK8Kg
IMKgIMKgIMKgIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7bmFtZSZxdW90OzogJnF1
b3Q7YWVzLWRvY3Npc2JwaSZxdW90Oyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7Y2lw
aGVyX2FsZ29yaXRobSZxdW90OzogPGEgaHJlZj0iaHR0cDovL0NpcGhlckFsZ29yaXRobS5hZXNf
ZG9jc2lzYnBpLm5hbWUiIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPkNpcGhlckFs
Z29yaXRobS5hZXNfZG9jc2lzYnBpLm5hbWU8L2E+LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCAm
cXVvdDtjaXBoZXJfa2V5X3N6JnF1b3Q7OiAzMiw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgJnF1
b3Q7Y2lwaGVyX2l2X3N6JnF1b3Q7OiAxNiw8YnI+DQorwqAgwqAgwqAgwqAgfSw8YnI+DQorwqAg
wqAgwqAgwqAgIzogY2lwaGVyIHRoZW4gYXV0aCB0ZXN0czxicj4NCivCoCDCoCDCoCDCoCB7PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgICZxdW90O25hbWUmcXVvdDs6ICZxdW90O2Flcy1jYmMvc2hh
MV9obWFjJnF1b3Q7LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCAmcXVvdDtjaXBoZXJfYWxnb3Jp
dGhtJnF1b3Q7OiA8YSBocmVmPSJodHRwOi8vQ2lwaGVyQWxnb3JpdGhtLmFlc19jYmMubmFtZSIg
cmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+Q2lwaGVyQWxnb3JpdGhtLmFlc19jYmMu
bmFtZTwvYT4sPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgICZxdW90O2NpcGhlcl9rZXlfc3omcXVv
dDs6IDE2LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCAmcXVvdDthdXRoX2FsZ29yaXRobSZxdW90
OzogPGEgaHJlZj0iaHR0cDovL0F1dGhlbnRpY2F0aW9uQWxnb3JpdGhtLnNoYTFfaG1hYy5uYW1l
IiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5BdXRoZW50aWNhdGlvbkFsZ29yaXRo
bS5zaGExX2htYWMubmFtZTwvYT4sPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgICZxdW90O2F1dGhf
a2V5X3N6JnF1b3Q7OiA2NCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7ZGlnZXN0X3N6
JnF1b3Q7OiAxMiw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7YnVyc3Rfc3omcXVvdDs6
IDMyLDxicj4NCivCoCDCoCDCoCDCoCB9LDxicj4NCivCoCDCoCDCoCDCoCB7PGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgICZxdW90O25hbWUmcXVvdDs6ICZxdW90O2Flcy1jYmMvc2hhMl9obWFjJnF1
b3Q7LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCAmcXVvdDtjaXBoZXJfYWxnb3JpdGhtJnF1b3Q7
OiA8YSBocmVmPSJodHRwOi8vQ2lwaGVyQWxnb3JpdGhtLmFlc19jYmMubmFtZSIgcmVsPSJub3Jl
ZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+Q2lwaGVyQWxnb3JpdGhtLmFlc19jYmMubmFtZTwvYT4s
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgICZxdW90O2NpcGhlcl9rZXlfc3omcXVvdDs6IDE2LDxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCAmcXVvdDthdXRoX2FsZ29yaXRobSZxdW90OzogPGEgaHJl
Zj0iaHR0cDovL0F1dGhlbnRpY2F0aW9uQWxnb3JpdGhtLnNoYTJfMjU2X2htYWMubmFtZSIgcmVs
PSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+QXV0aGVudGljYXRpb25BbGdvcml0aG0uc2hh
Ml8yNTZfaG1hYy5uYW1lPC9hPiw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7YXV0aF9r
ZXlfc3omcXVvdDs6IDY0LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCAmcXVvdDtkaWdlc3Rfc3om
cXVvdDs6IDMyLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCAmcXVvdDtidXJzdF9zeiZxdW90Ozog
MzIsPGJyPg0KK8KgIMKgIMKgIMKgIH0sPGJyPg0KK8KgIMKgIMKgIMKgIHs8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgJnF1b3Q7bmFtZSZxdW90OzogJnF1b3Q7a2FzdW1pLWY4L2thc3VtaS1mOSZx
dW90Oyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7Y2lwaGVyX2FsZ29yaXRobSZxdW90
OzogPGEgaHJlZj0iaHR0cDovL0NpcGhlckFsZ29yaXRobS5rYXN1bWlfZjgubmFtZSIgcmVsPSJu
b3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+Q2lwaGVyQWxnb3JpdGhtLmthc3VtaV9mOC5uYW1l
PC9hPiw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7Y2lwaGVyX2tleV9zeiZxdW90Ozog
MTYsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgICZxdW90O2NpcGhlcl9pdl9zeiZxdW90OzogOCw8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7YXV0aF9hbGdvcml0aG0mcXVvdDs6IDxhIGhy
ZWY9Imh0dHA6Ly9BdXRoZW50aWNhdGlvbkFsZ29yaXRobS5rYXN1bWlfZjkubmFtZSIgcmVsPSJu
b3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+QXV0aGVudGljYXRpb25BbGdvcml0aG0ua2FzdW1p
X2Y5Lm5hbWU8L2E+LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCAmcXVvdDthdXRoX2tleV9zeiZx
dW90OzogMTYsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgICZxdW90O2RpZ2VzdF9zeiZxdW90Ozog
NCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7YnVyc3Rfc3omcXVvdDs6IDMyLDxicj4N
CivCoCDCoCDCoCDCoCB9LDxicj4NCivCoCDCoCDCoCDCoCB7PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgICZxdW90O25hbWUmcXVvdDs6ICZxdW90O3Nub3czZy11ZWEyL3Nub3czZy11aWEyJnF1b3Q7
LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCAmcXVvdDtjaXBoZXJfYWxnb3JpdGhtJnF1b3Q7OiA8
YSBocmVmPSJodHRwOi8vQ2lwaGVyQWxnb3JpdGhtLnNub3czZ191ZWEyLm5hbWUiIHJlbD0ibm9y
ZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPkNpcGhlckFsZ29yaXRobS5zbm93M2dfdWVhMi5uYW1l
PC9hPiw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7Y2lwaGVyX2tleV9zeiZxdW90Ozog
MTYsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgICZxdW90O2NpcGhlcl9pdl9zeiZxdW90OzogMTYs
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgICZxdW90O2F1dGhfYWxnb3JpdGhtJnF1b3Q7OiA8YSBo
cmVmPSJodHRwOi8vQXV0aGVudGljYXRpb25BbGdvcml0aG0uc25vdzNnX3VpYTIubmFtZSIgcmVs
PSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+QXV0aGVudGljYXRpb25BbGdvcml0aG0uc25v
dzNnX3VpYTIubmFtZTwvYT4sPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgICZxdW90O2F1dGhfa2V5
X3N6JnF1b3Q7OiAxNiw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7YXV0aF9pdl9zeiZx
dW90OzogMTYsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgICZxdW90O2RpZ2VzdF9zeiZxdW90Ozog
NCw8YnI+DQorwqAgwqAgwqAgwqAgfSw8YnI+DQorwqAgwqAgwqAgwqAgezxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCAmcXVvdDtuYW1lJnF1b3Q7OiAmcXVvdDt6dWMtZWVhMy96dWMtZWlhMyZxdW90
Oyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7Y2lwaGVyX2FsZ29yaXRobSZxdW90Ozog
PGEgaHJlZj0iaHR0cDovL0NpcGhlckFsZ29yaXRobS56dWNfZWVhMy5uYW1lIiByZWw9Im5vcmVm
ZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5DaXBoZXJBbGdvcml0aG0uenVjX2VlYTMubmFtZTwvYT4s
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgICZxdW90O2NpcGhlcl9rZXlfc3omcXVvdDs6IDE2LDxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCAmcXVvdDtjaXBoZXJfaXZfc3omcXVvdDs6IDE2LDxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCAmcXVvdDthdXRoX2FsZ29yaXRobSZxdW90OzogPGEgaHJlZj0i
aHR0cDovL0F1dGhlbnRpY2F0aW9uQWxnb3JpdGhtLnp1Y19laWEzLm5hbWUiIHJlbD0ibm9yZWZl
cnJlciIgdGFyZ2V0PSJfYmxhbmsiPkF1dGhlbnRpY2F0aW9uQWxnb3JpdGhtLnp1Y19laWEzLm5h
bWU8L2E+LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCAmcXVvdDthdXRoX2tleV9zeiZxdW90Ozog
MTYsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgICZxdW90O2F1dGhfaXZfc3omcXVvdDs6IDE2LDxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCAmcXVvdDtkaWdlc3Rfc3omcXVvdDs6IDQsPGJyPg0KK8Kg
IMKgIMKgIMKgIH0sPGJyPg0KK8KgIMKgIMKgIMKgICM6IGFlYWQgdGVzdHM8YnI+DQorwqAgwqAg
wqAgwqAgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCAmcXVvdDtuYW1lJnF1b3Q7OiAmcXVvdDth
ZXMtZ2NtJnF1b3Q7LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCAmcXVvdDthZWFkX2FsZ29yaXRo
bSZxdW90OzogPGEgaHJlZj0iaHR0cDovL0FlYWRBbGdOYW1lLmFlc19nY20ubmFtZSIgcmVsPSJu
b3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+QWVhZEFsZ05hbWUuYWVzX2djbS5uYW1lPC9hPiw8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7YWVhZF9rZXlfc3omcXVvdDs6IDE2LDxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCAmcXVvdDthZWFkX2l2X3N6JnF1b3Q7OiAxMiw8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgJnF1b3Q7YWVhZF9hYWRfc3omcXVvdDs6IDE2LDxicj4NCivCoCDCoCDC
oCDCoCB9LDxicj4NCivCoCDCoCBdPGJyPg0KPGJyPg0KPGJyPg0KwqBAcmVxdWlyZXNfbGlua190
b3BvbG9neShMaW5rVG9wb2xvZ3kuTk9fTElOSyk8YnI+DQrCoGNsYXNzIFRlc3RDcnlwdG9kZXZM
YXRlbmN5KFRlc3RTdWl0ZSk6PGJyPg0KLcKgIMKgICZxdW90OyZxdW90OyZxdW90O0RQREsgQ3J5
cHRvIERldmljZSBUZXN0aW5nIFN1aXRlLiZxdW90OyZxdW90OyZxdW90Ozxicj4NCivCoCDCoCAm
cXVvdDsmcXVvdDsmcXVvdDtEUERLIENyeXB0byBEZXZpY2UgTGF0ZW5jeSBUZXN0aW5nIFN1aXRl
LiZxdW90OyZxdW90OyZxdW90Ozxicj4NCjxicj4NCsKgIMKgIMKgY29uZmlnOiBDb25maWc8YnI+
DQo8YnI+DQrCoCDCoCDCoGRlZiBzZXRfdXBfc3VpdGUoc2VsZikgLSZndDsgTm9uZTo8YnI+DQot
wqAgwqAgwqAgwqAgJnF1b3Q7JnF1b3Q7JnF1b3Q7U2V0IHVwIHRoZSB0ZXN0IHN1aXRlLiZxdW90
OyZxdW90OyZxdW90Ozxicj4NCi3CoCDCoCDCoCDCoCBzZWxmLmxhdGVuY3lfdGVzdF9wYXJhbWV0
ZXJzOiBkaWN0W3N0ciwgbGlzdFtkaWN0W3N0ciwgaW50IHwgZmxvYXQgfCBzdHJdXV0gPSAoPGJy
Pg0KLcKgIMKgIMKgIMKgIMKgIMKgIHNlbGYuY29uZmlnLmxhdGVuY3lfdGVzdF9wYXJhbWV0ZXJz
PGJyPg0KLcKgIMKgIMKgIMKgICk8YnI+DQorwqAgwqAgwqAgwqAgJnF1b3Q7JnF1b3Q7JnF1b3Q7
U2V0IHVwIHRoZSB0ZXN0IHN1aXRlLjxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgUmFpc2VzOjxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCBDb25maWd1cmF0aW9uRXJyb3I6IElmIG5vIHRlc3RzIGNh
biBiZSBkZXJpdmVkIGZyb20gdGhlIHByb3ZpZGVkIGNvbmZpZy48YnI+DQorwqAgwqAgwqAgwqAg
JnF1b3Q7JnF1b3Q7JnF1b3Q7PGJyPg0KK8KgIMKgIMKgIMKgIHNlbGYudGVzdF9jb21iaW5hdGlv
bnM6IGxpc3RbZGljdFtzdHIsIEFueV1dID0gc2VsZi5jb25maWcudGVzdF9jb21iaW5hdGlvbnM8
YnI+DQrCoCDCoCDCoCDCoCDCoHNlbGYuZGVsdGFfdG9sZXJhbmNlOiBmbG9hdCA9IHNlbGYuY29u
ZmlnLmRlbHRhX3RvbGVyYW5jZTxicj4NCivCoCDCoCDCoCDCoCBzZWxmLm9wczogaW50ID0gMTBf
MDAwXzAwMDxicj4NCsKgIMKgIMKgIMKgIMKgc2VsZi5kZXZpY2VfdHlwZTogRGV2aWNlVHlwZSB8
IE5vbmUgPSBnZXRfZGV2aWNlX2Zyb21fc3RyKDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgc3Ry
KGdldF9jdHgoKS5zdXRfbm9kZS5jcnlwdG9fZGV2aWNlX3R5cGUpPGJyPg0KwqAgwqAgwqAgwqAg
wqApPGJyPg0KLcKgIMKgIMKgIMKgIHNlbGYuYnVmZmVyX3NpemVzID0ge308YnI+DQotPGJyPg0K
LcKgIMKgIMKgIMKgIGZvciBrLCB2IGluIHNlbGYubGF0ZW5jeV90ZXN0X3BhcmFtZXRlcnMuaXRl
bXMoKTo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgc2VsZi5idWZmZXJfc2l6ZXNba10gPSBMaXN0
V3JhcHBlcihbaW50KHJ1blsmcXVvdDtidWZmX3NpemUmcXVvdDtdKSBmb3IgcnVuIGluIHZdKTxi
cj4NCivCoCDCoCDCoCDCoCBzZWxmLmJ1ZmZlcl9zaXplczogZGljdFtzdHIsIExpc3RXcmFwcGVy
XSA9IHt9PGJyPg0KK8KgIMKgIMKgIMKgIHNlbGYuY2lwaGVyX3Rlc3RzOiBsaXN0W2RpY3Rbc3Ry
LCBBbnldXSA9IFtdPGJyPg0KK8KgIMKgIMKgIMKgIHNlbGYuYXV0aF90ZXN0czogbGlzdFtkaWN0
W3N0ciwgQW55XV0gPSBbXTxicj4NCivCoCDCoCDCoCDCoCBzZWxmLmNpcGhlcl90aGVuX2F1dGhf
dGVzdHM6IGxpc3RbZGljdFtzdHIsIEFueV1dID0gW108YnI+DQorwqAgwqAgwqAgwqAgc2VsZi5h
ZWFkX3Rlc3RzOiBsaXN0W2RpY3Rbc3RyLCBBbnldXSA9IFtdPGJyPg0KKzxicj4NCivCoCDCoCDC
oCDCoCBmb3IgY29tYmluYXRpb24gaW4gc2VsZi50ZXN0X2NvbWJpbmF0aW9uczo8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgc2VsZi5idWZmZXJfc2l6ZXNbY29tYmluYXRpb25bJnF1b3Q7bmFtZSZx
dW90O11dID0gTGlzdFdyYXBwZXIoPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFtpbnQo
cnVuWyZxdW90O2J1ZmZfc2l6ZSZxdW90O10pIGZvciBydW4gaW4gY29tYmluYXRpb24uZ2V0KCZx
dW90O3Rlc3RfcGFyYW1ldGVycyZxdW90OywgY29uZmlnX2xpc3QpXTxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCApPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIGlzX2NpcGhlciA9ICZxdW90O2NpcGhl
cl9hbGdvcml0aG0mcXVvdDsgaW4gY29tYmluYXRpb248YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
aXNfYXV0aCA9ICZxdW90O2F1dGhfYWxnb3JpdGhtJnF1b3Q7IGluIGNvbWJpbmF0aW9uPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIGFlYWQgPSAmcXVvdDthZWFkX2FsZ29yaXRobSZxdW90OyBpbiBj
b21iaW5hdGlvbjxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgaWYgaXNfY2lwaGVyIGFu
ZCBpc19hdXRoOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzZWxmLmNpcGhlcl90aGVu
X2F1dGhfdGVzdHMuYXBwZW5kKGNvbWJpbmF0aW9uKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBl
bGlmIGlzX2NpcGhlcjo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc2VsZi5jaXBoZXJf
dGVzdHMuYXBwZW5kKGNvbWJpbmF0aW9uKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBlbGlmIGlz
X2F1dGg6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHNlbGYuYXV0aF90ZXN0cy5hcHBl
bmQoY29tYmluYXRpb24pPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIGVsaWYgYWVhZDo8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc2VsZi5hZWFkX3Rlc3RzLmFwcGVuZChjb21iaW5hdGlv
bik8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgZWxzZTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgcmFpc2UgQ29uZmlndXJhdGlvbkVycm9yKDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCAmcXVvdDtFYWNoIHRlc3QgaW5zdGFuY2UgbXVzdCBjb250YWluIGVpdGhlciAm
cXVvdDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7JiMzOTtjaXBo
ZXJfYWxnb3JpdGhtJiMzOTssICYjMzk7YXV0aF9hbGdvcml0aG0mIzM5Oywgb3IgJiMzOTthZWFk
X2FsZ29yaXRobSYjMzk7JnF1b3Q7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICk8YnI+
DQo8YnI+DQrCoCDCoCDCoGRlZiBfcHJpbnRfc3RhdHMoc2VsZiwgdGVzdF92YWxzOiBsaXN0W2Rp
Y3Rbc3RyLCBpbnQgfCBmbG9hdCB8IHN0cl1dKSAtJmd0OyBOb25lOjxicj4NCivCoCDCoCDCoCDC
oCAmcXVvdDsmcXVvdDsmcXVvdDtQcmludCB0aGUgc3RhdHMgb2YgdGhlIGdpdmVuIHRlc3QgdmFs
dWVzIGluIGEgY2xlYW4gZm9ybWF0Ljxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgQXJnczo8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgdGVzdF92YWxzOiB0aGUgdGVzdGluZyB2YWx1ZXMgdG8gcHJp
bnQ8YnI+DQorwqAgwqAgwqAgwqAgJnF1b3Q7JnF1b3Q7JnF1b3Q7PGJyPg0KK8KgIMKgIMKgIMKg
IGFzc2VydCBsZW4odGVzdF92YWxzKSAmZ3Q7IDAsICZxdW90O3Rlc3RfdmFscyBtdXN0IGNvbnRh
aW4gYXQgbGVhc3Qgb25lIGVsZW1lbnQmcXVvdDs8YnI+DQorPGJyPg0KwqAgwqAgwqAgwqAgwqBl
bGVtZW50X2xlbiA9IGxlbigmcXVvdDtBdmcgVGltZSB1cyBUYXJnZXQmcXVvdDspPGJyPg0KLcKg
IMKgIMKgIMKgIGJvcmRlcl9sZW4gPSAoZWxlbWVudF9sZW4gKyAxKSAqIChsZW4odGVzdF92YWxz
WzBdKSk8YnI+DQorwqAgwqAgwqAgwqAgYm9yZGVyX2xlbiA9IChlbGVtZW50X2xlbiArIDEpICog
KGxlbih0ZXN0X3ZhbHNbMF0pIC0gMSk8YnI+DQorwqAgwqAgwqAgwqAgdGVzdF9uYW1lID0gdGVz
dF92YWxzWzBdWyZxdW90O1Rlc3QgTmFtZSZxdW90O108YnI+DQo8YnI+DQotwqAgwqAgwqAgwqAg
cHJpbnQoZiZxdW90O3smIzM5O0xhdGVuY3kgUmVzdWx0cyYjMzk7LmNlbnRlcihib3JkZXJfbGVu
KX1cbnsmIzM5Oz0mIzM5OyAqIGJvcmRlcl9sZW59JnF1b3Q7KTxicj4NCivCoCDCoCDCoCDCoCBw
cmludChmJnF1b3Q7e2YmIzM5O3t0ZXN0X25hbWV9IExhdGVuY3kgUmVzdWx0cyYjMzk7LmNlbnRl
cihib3JkZXJfbGVuKX1cbnsmIzM5Oz0mIzM5OyAqIGJvcmRlcl9sZW59JnF1b3Q7KTxicj4NCsKg
IMKgIMKgIMKgIMKgZm9yIGssIHYgaW4gdGVzdF92YWxzWzBdLml0ZW1zKCk6PGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgIHByaW50KGYmcXVvdDt8e2sudGl0bGUoKTombHQ7e2VsZW1lbnRfbGVufX0m
cXVvdDssIGVuZD0mcXVvdDsmcXVvdDspPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIGlmIGsgIT0g
JnF1b3Q7VGVzdCBOYW1lJnF1b3Q7Ojxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBwcmlu
dChmJnF1b3Q7fHtrLnRpdGxlKCk6Jmx0O3tlbGVtZW50X2xlbn19JnF1b3Q7LCBlbmQ9JnF1b3Q7
JnF1b3Q7KTxicj4NCsKgIMKgIMKgIMKgIMKgcHJpbnQoZiZxdW90O3xcbnsmIzM5Oz0mIzM5OyAq
IGJvcmRlcl9sZW59JnF1b3Q7KTxicj4NCjxicj4NCsKgIMKgIMKgIMKgIMKgZm9yIHRlc3RfdmFs
IGluIHRlc3RfdmFsczo8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoGZvciBrLCB2IGluIHRlc3Rf
dmFsLml0ZW1zKCk6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHByaW50KGYmcXVvdDt8
e3Y6Jmx0O3tlbGVtZW50X2xlbn19JnF1b3Q7LCBlbmQ9JnF1b3Q7JnF1b3Q7KTxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBpZiBrICE9ICZxdW90O1Rlc3QgTmFtZSZxdW90Ozo8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcHJpbnQoZiZxdW90O3x7djombHQ7e2VsZW1l
bnRfbGVufX0mcXVvdDssIGVuZD0mcXVvdDsmcXVvdDspPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAg
wqBwcmludChmJnF1b3Q7fFxueyYjMzk7PSYjMzk7ICogYm9yZGVyX2xlbn0mcXVvdDspPGJyPg0K
PGJyPg0KLcKgIMKgIGRlZiBfdmVyaWZ5X2xhdGVuY3koPGJyPg0KK8KgIMKgIGRlZiBfcHJpbnRf
YW5kX3ZlcmlmeShzZWxmLCBhbGxfcmVzdWx0czogbGlzdFtsaXN0W2RpY3Rbc3RyLCBpbnQgfCBm
bG9hdCB8IHN0cl1dXSkgLSZndDsgTm9uZTo8YnI+DQorwqAgwqAgwqAgwqAgJnF1b3Q7JnF1b3Q7
JnF1b3Q7UHJpbnQgdGhlIGdpdmVuIHJlc3VsdHMgYW5kIHRoZW4gdmVyaWZ5IGFsbCByZXN1bHRz
IGhhdmUgcGFzc2VkLjxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgQXJnczo8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgYWxsX3Jlc3VsdHM6IGEgbGlzdCBvZiByZXN1bHRzIHRvIHByaW50IGFuZCB2
ZXJpZnkuPGJyPg0KK8KgIMKgIMKgIMKgICZxdW90OyZxdW90OyZxdW90Ozxicj4NCivCoCDCoCDC
oCDCoCBmb3IgcmVzdWx0cyBpbiBhbGxfcmVzdWx0czo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
aWYgbGVuKHJlc3VsdHMpICZndDsgMDo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc2Vs
Zi5fcHJpbnRfc3RhdHModGVzdF92YWxzPXJlc3VsdHMpPGJyPg0KKzxicj4NCivCoCDCoCDCoCDC
oCBmb3IgcmVzdWx0cyBpbiBhbGxfcmVzdWx0czo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgZm9y
IHJlc3VsdCBpbiByZXN1bHRzOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB2ZXJpZnko
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJlc3VsdFsmcXVvdDtwYXNzZWQm
cXVvdDtdID09ICZxdW90O1BBU1MmcXVvdDssPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIGYmcXVvdDtHYnBzIGZlbGwgYmVsb3cgZGVsdGEgdG9sZXJhbmNlIGZvciB0ZXN0IHty
ZXN1bHRbJiMzOTtUZXN0IE5hbWUmIzM5O119JnF1b3Q7LDxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCApPGJyPg0KKzxicj4NCivCoCDCoCBkZWYgX2NyZWF0ZV9zdW1tYXJ5KDxicj4NCsKg
IMKgIMKgIMKgIMKgc2VsZiw8YnI+DQrCoCDCoCDCoCDCoCDCoHJlc3VsdHM6IGxpc3RbQ3J5cHRv
ZGV2UmVzdWx0c10sPGJyPg0KLcKgIMKgIMKgIMKgIGtleTogc3RyLDxicj4NCivCoCDCoCDCoCDC
oCBwYXJhbXM6IGxpc3RbZGljdF0sPGJyPg0KK8KgIMKgIMKgIMKgIHRlc3RfbmFtZTogc3RyLDxi
cj4NCsKgIMKgIMKgKSAtJmd0OyBsaXN0W2RpY3Rbc3RyLCBpbnQgfCBmbG9hdCB8IHN0cl1dOjxi
cj4NCivCoCDCoCDCoCDCoCAmcXVvdDsmcXVvdDsmcXVvdDtWZXJpZnkgdGhlIHRocm91Z2hwdXQg
b2YgdGhlIGdpdmVuIHJlc3VsdHMgYWdhaW5zdCB0aGUgc3VwcGxpZWQgcGFyYW1ldGVycy48YnI+
DQorPGJyPg0KK8KgIMKgIMKgIMKgIEFyZ3M6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHJlc3Vs
dHM6IFRoZSByZXN1bHRzIG9mIHRoZSBkcGRrIGNyeXB0byBwZXJmIGFwcCByYW4gaW4gbGF0ZW5j
eSBtb2RlLjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBwYXJhbXM6IFRoZSBiYXNlbGluZXMgdG8g
Y29tcGFyZSB0aGUgZ2l2ZW4gcmVzdWx0cyB0by48YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgdGVz
dF9uYW1lOiBUaGUgdGVzdCBuYW1lIHRvIHBpbiB0byB0aGUgcmVzdWx0IHN1bW1hcnkuPGJyPg0K
Kzxicj4NCivCoCDCoCDCoCDCoCBSZXR1cm5zOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBBIHN1
bW1hcnkgb2YgbGF0ZW5jeSBzdGF0aXN0aWNzIGZvciBhIHRlc3QgYW5kIHdoZXRoZXIgdGhlIHRl
c3QgcGFzc2VkLjxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgUmFpc2VzOjxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCBSdW50aW1lRXJyb3I6IFdoZW4gdGhlcmUgYXJlIG5vIGJhc2VsaW5lcyBmb3Ig
YSBnaXZlbiByZXN1bHQuPGJyPg0KK8KgIMKgIMKgIMKgICZxdW90OyZxdW90OyZxdW90Ozxicj4N
CsKgIMKgIMKgIMKgIMKgcmVzdWx0X2xpc3Q6IGxpc3RbZGljdFtzdHIsIGludCB8IGZsb2F0IHwg
c3RyXV0gPSBbXTxicj4NCjxicj4NCsKgIMKgIMKgIMKgIMKgZm9yIHJlc3VsdCBpbiByZXN1bHRz
Ojxicj4NCkBAIC0xMTgsNjAxICsyNDYsMzU3IEBAIGRlZiBfdmVyaWZ5X2xhdGVuY3koPGJyPg0K
wqAgwqAgwqAgwqAgwqAgwqAgwqBwYXJhbWV0ZXJzOiBkaWN0W3N0ciwgaW50IHwgZmxvYXQgfCBz
dHJdID0gbmV4dCg8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZpbHRlcig8YnI+DQrC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGxhbWJkYSB4OiB4WyZxdW90O2J1ZmZfc2l6
ZSZxdW90O10gPT0gcmVzdWx0LmJ1ZmZlcl9zaXplLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBzZWxmLmxhdGVuY3lfdGVzdF9wYXJhbWV0ZXJzW2tleV0sPGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHBhcmFtcyw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCksPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB7fSw8YnI+DQrCoCDCoCDC
oCDCoCDCoCDCoCDCoCk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgZXJybXNnID0gKDxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmJnF1b3Q7Tm8gdGVzdCBwYXJhbWV0ZXJzIGZvdW5kIGZv
ciB7dGVzdF9uYW1lfSB3aXRoIGJ1ZmZlciBzaXplIHtyZXN1bHQuYnVmZmVyX3NpemV9JnF1b3Q7
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgICk8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIHBh
cmFtZXRlcnMgPT0ge306PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJhaXNlIFJ1bnRp
bWVFcnJvcig8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZiZxdW90O05vIHRl
c3QgcGFyYW1ldGVycyBmb3VuZCBmb3Ige2tleX0gd2l0aCBidWZmZXIgc2l6ZSB7cmVzdWx0LmJ1
ZmZlcl9zaXplfSZxdW90Ozxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCApPGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJhaXNlIFJ1bnRpbWVFcnJvcihlcnJtc2cpPGJyPg0KwqAg
wqAgwqAgwqAgwqAgwqAgwqB0ZXN0X3Jlc3VsdCA9IFRydWU8YnI+DQorPGJyPg0KwqAgwqAgwqAg
wqAgwqAgwqAgwqBleHBlY3RlZF9jeWNsZXMgPSBwYXJhbWV0ZXJzWyZxdW90O2F2Z19jeWNsZXMm
cXVvdDtdPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIGV4cGVjdGVkX3RpbWVfdXMgPSBwYXJhbWV0
ZXJzWyZxdW90O2F2Z190aW1lX3VzJnF1b3Q7XTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBtZWFz
dXJlZF90aW1lX2RlbHRhID0gYWJzKDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAoZ2V0
YXR0cihyZXN1bHQsICZxdW90O2F2Z190aW1lX3VzJnF1b3Q7KSAtIGV4cGVjdGVkX3RpbWVfdXMp
IC8gZXhwZWN0ZWRfdGltZV91czxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBhc3NlcnQgaW50KGV4
cGVjdGVkX2N5Y2xlcykgJmd0OyAwLCAmcXVvdDtFeHBlY3RlZCBhdmVyYWdlIGN5Y2xlcyBtdXN0
IG5vdCBiZSB6ZXJvJnF1b3Q7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIG1lYXN1cmVkX2RlbHRh
X2N5Y2xlcyA9IGFicyg8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcm91bmQoKGdldGF0
dHIocmVzdWx0LCAmcXVvdDthdmdfY3ljbGVzJnF1b3Q7KSAtIGV4cGVjdGVkX2N5Y2xlcykgLyBl
eHBlY3RlZF9jeWNsZXMsIDUpPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqApPGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgIG1lYXN1cmVkX2N5Y2xlc19kZWx0YSA9IGFicyg8YnI+DQotwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgKGdldGF0dHIocmVzdWx0LCAmcXVvdDthdmdfY3ljbGVzJnF1b3Q7KSAt
IGV4cGVjdGVkX2N5Y2xlcykgLyBleHBlY3RlZF9jeWNsZXM8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgZXhwZWN0ZWRfdGltZSA9IHBhcmFtZXRlcnNbJnF1b3Q7YXZnX3RpbWVfdXMmcXVvdDtdPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIGFzc2VydCBpbnQoZXhwZWN0ZWRfdGltZSkgJmd0OyAwLCAm
cXVvdDtFeHBlY3RlZCBhdmVyYWdlIHRpbWUgbXVzdCBub3QgYmUgemVybyZxdW90Ozxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCBtZWFzdXJlZF9kZWx0YV90aW1lID0gYWJzKDxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCByb3VuZCgoZ2V0YXR0cihyZXN1bHQsICZxdW90O2F2Z190aW1lX3Vz
JnF1b3Q7KSAtIGV4cGVjdGVkX3RpbWUpIC8gZXhwZWN0ZWRfdGltZSwgNSk8YnI+DQrCoCDCoCDC
oCDCoCDCoCDCoCDCoCk8YnI+DQo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgIyByZXN1bHQgZGlk
IG5vdCBtZWV0IHRoZSBnaXZlbiBjeWNsZXMgcGFyYW1ldGVyLCBjaGVjayBpZiB3aXRoaW4gZGVs
dGEuPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgICMgcmVzdWx0IGRpZCBub3QgbWVldCB0aGUgbWF0
Y2hpbmcgcGFyYW1ldGVyLCBjaGVjayBpZiB3aXRoaW4gZGVsdGEuPGJyPg0KwqAgwqAgwqAgwqAg
wqAgwqAgwqBpZiBnZXRhdHRyKHJlc3VsdCwgJnF1b3Q7YXZnX2N5Y2xlcyZxdW90OykgJmd0OyBl
eHBlY3RlZF9jeWNsZXM6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIHNlbGYuZGVs
dGFfdG9sZXJhbmNlICZsdDsgbWVhc3VyZWRfY3ljbGVzX2RlbHRhOjxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBpZiBzZWxmLmRlbHRhX3RvbGVyYW5jZSAmZ3Q7IG1lYXN1cmVkX2RlbHRh
X2N5Y2xlczo8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHRlc3RfcmVzdWx0
ID0gRmFsc2U8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgIyByZXN1bHQgZGlkIG5vdCBtZWV0IHRo
ZSBnaXZlbiB0aW1lIHBhcmFtZXRlciwgY2hlY2sgaWYgd2l0aGluIGRlbHRhLjxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCBpZiBnZXRhdHRyKHJlc3VsdCwgJnF1b3Q7YXZnX3RpbWVfdXMmcXVvdDsp
ICZndDsgZXhwZWN0ZWRfdGltZV91czo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYg
c2VsZi5kZWx0YV90b2xlcmFuY2UgJmx0OyBtZWFzdXJlZF90aW1lX2RlbHRhOjxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCBpZiBnZXRhdHRyKHJlc3VsdCwgJnF1b3Q7YXZnX3RpbWVfdXMmcXVvdDsp
ICZndDsgZXhwZWN0ZWRfdGltZTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgc2Vs
Zi5kZWx0YV90b2xlcmFuY2UgJmd0OyBtZWFzdXJlZF9kZWx0YV90aW1lOjxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdGVzdF9yZXN1bHQgPSBGYWxzZTxicj4NCis8YnI+DQrC
oCDCoCDCoCDCoCDCoCDCoCDCoHJlc3VsdF9saXN0LmFwcGVuZCg8YnI+DQrCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7
VGVzdCBOYW1lJnF1b3Q7OiB0ZXN0X25hbWUsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAmcXVvdDtCdWZmZXIgU2l6ZSZxdW90OzogcGFyYW1ldGVyc1smcXVvdDtidWZmX3Np
emUmcXVvdDtdLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7ZGVs
dGEgdG9sZXJhbmNlJnF1b3Q7OiBzZWxmLmRlbHRhX3RvbGVyYW5jZSw8YnI+DQotwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7Y3ljbGVzIGRlbHRhJnF1b3Q7OiByb3VuZChtZWFz
dXJlZF9jeWNsZXNfZGVsdGEsIDUpLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCAmcXVvdDtBdmcgY3ljbGVzJnF1b3Q7OiByb3VuZChnZXRhdHRyKHJlc3VsdCwgJnF1b3Q7YXZn
X2N5Y2xlcyZxdW90OyksIDUpLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAm
cXVvdDtBdmcgY3ljbGVzIHRhcmdldCZxdW90OzogZXhwZWN0ZWRfY3ljbGVzLDxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmcXVvdDt0aW1lIGRlbHRhJnF1b3Q7OiByb3VuZCht
ZWFzdXJlZF90aW1lX2RlbHRhLCA1KSw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgJnF1b3Q7QXZnIHRpbWUgdXMmcXVvdDs6IHJvdW5kKGdldGF0dHIocmVzdWx0LCAmcXVvdDth
dmdfdGltZV91cyZxdW90OyksIDUpLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCAmcXVvdDtBdmcgdGltZSB1cyB0YXJnZXQmcXVvdDs6IGV4cGVjdGVkX3RpbWVfdXMsPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZxdW90O2F2Z19jeWNsZXMmcXVvdDs6IGdl
dGF0dHIocmVzdWx0LCAmcXVvdDthdmdfY3ljbGVzJnF1b3Q7KSw8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7YXZnX2N5Y2xlcyB0YXJnZXQmcXVvdDs6IGV4cGVjdGVk
X2N5Y2xlcyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7YXZnX2N5
Y2xlcyBkZWx0YSZxdW90OzogbWVhc3VyZWRfZGVsdGFfY3ljbGVzLDxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCAmcXVvdDthdmdfdGltZV91cyZxdW90OzogZ2V0YXR0cihyZXN1
bHQsICZxdW90O2F2Z190aW1lX3VzJnF1b3Q7KSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgJnF1b3Q7YXZnX3RpbWVfdXMgdGFyZ2V0JnF1b3Q7OiBleHBlY3RlZF90aW1lLDxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmcXVvdDthdmdfdGltZV91cyBkZWx0
YSZxdW90OzogbWVhc3VyZWRfZGVsdGFfdGltZSw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCZxdW90O3Bhc3NlZCZxdW90OzogJnF1b3Q7UEFTUyZxdW90OyBpZiB0ZXN0X3Jl
c3VsdCBlbHNlICZxdW90O0ZBSUwmcXVvdDssPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqB9PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqApPGJyPg0KwqAgwqAgwqAgwqAgwqByZXR1cm4g
cmVzdWx0X2xpc3Q8YnI+DQo8YnI+DQrCoCDCoCDCoEBjcnlwdG9fdGVzdDxicj4NCi3CoCDCoCBk
ZWYgYWVzX2NiYyhzZWxmKSAtJmd0OyBOb25lOjxicj4NCi3CoCDCoCDCoCDCoCAmcXVvdDsmcXVv
dDsmcXVvdDthZXNfY2JjIGxhdGVuY3kgdGVzdC48YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgIFN0
ZXBzOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCAqIENyZWF0ZSBhIGNyeXB0b2RldiBpbnN0YW5j
ZSB3aXRoIHByb3ZpZGVkIGRldmljZSB0eXBlIGFuZCBidWZmZXIgc2l6ZXMuPGJyPg0KLcKgIMKg
IMKgIMKgIFZlcmlmeTo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgKiBUaGUgbGF0ZW5jeSBpcyBi
ZWxvdyBvciB3aXRoaW4gZGVsdGEgb2YgcHJvdmlkZWQgYmFzZWxpbmUuPGJyPg0KLTxicj4NCi3C
oCDCoCDCoCDCoCBSYWlzZXM6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIFNraXBwZWRUZXN0RXhj
ZXB0aW9uOiBXaGVuIGNvbmZpZ3VyYXRpb24gaXMgbm90IHByb3ZpZGVkLjxicj4NCi3CoCDCoCDC
oCDCoCAmcXVvdDsmcXVvdDsmcXVvdDs8YnI+DQotwqAgwqAgwqAgwqAgaWYgJnF1b3Q7YWVzX2Ni
YyZxdW90OyBub3QgaW4gc2VsZi5sYXRlbmN5X3Rlc3RfcGFyYW1ldGVyczo8YnI+DQotwqAgwqAg
wqAgwqAgwqAgwqAgc2tpcCgmcXVvdDt0ZXN0IG5vdCBjb25maWd1cmVkJnF1b3Q7KTxicj4NCi3C
oCDCoCDCoCDCoCBhcHAgPSBDcnlwdG9kZXYoPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIHB0ZXN0
PVRlc3RUeXBlLmxhdGVuY3ksPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIGRldnR5cGU9c2VsZi5k
ZXZpY2VfdHlwZSw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgb3B0eXBlPU9wZXJhdGlvblR5cGUu
Y2lwaGVyX29ubHksPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIGNpcGhlcl9hbGdvPUNpcGhlckFs
Z29yaXRobS5hZXNfY2JjLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBjaXBoZXJfb3A9RW5jcnlw
dERlY3J5cHRTd2l0Y2guZW5jcnlwdCw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgY2lwaGVyX2tl
eV9zej0xNiw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgY2lwaGVyX2l2X3N6PTE2LDxicj4NCi3C
oCDCoCDCoCDCoCDCoCDCoCBidXJzdF9zej0zMiw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgdG90
YWxfb3BzPVRPVEFMX09QUyw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgYnVmZmVyX3N6PXNlbGYu
YnVmZmVyX3NpemVzWyZxdW90O2Flc19jYmMmcXVvdDtdLDxicj4NCi3CoCDCoCDCoCDCoCApPGJy
Pg0KLcKgIMKgIMKgIMKgIHJlc3VsdHMgPSBzZWxmLl92ZXJpZnlfbGF0ZW5jeShhcHAucnVuX2Fw
cCgpLCAmcXVvdDthZXNfY2JjJnF1b3Q7KTxicj4NCi3CoCDCoCDCoCDCoCBzZWxmLl9wcmludF9z
dGF0cyhyZXN1bHRzKTxicj4NCi3CoCDCoCDCoCDCoCBmb3IgcmVzdWx0IGluIHJlc3VsdHM6PGJy
Pg0KLcKgIMKgIMKgIMKgIMKgIMKgIHZlcmlmeSg8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgcmVzdWx0WyZxdW90O3Bhc3NlZCZxdW90O10gPT0gJnF1b3Q7UEFTUyZxdW90Oyw8YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7bGF0ZW5jeSB3YXMgZ3JlYXRlciB0aGFuIHRo
ZSBkZWx0YSB0b2xlcmFuY2UgYWJvdmUgYmFzZWxpbmUmcXVvdDssPGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgICk8YnI+DQotPGJyPg0KLcKgIMKgIEBjcnlwdG9fdGVzdDxicj4NCi3CoCDCoCBkZWYg
YWVzX2NiY19zaGExX2htYWMoc2VsZikgLSZndDsgTm9uZTo8YnI+DQotwqAgwqAgwqAgwqAgJnF1
b3Q7JnF1b3Q7JnF1b3Q7YWVzX2NiY19zaGExX2htYWMgbGF0ZW5jeSB0ZXN0Ljxicj4NCi08YnI+
DQotwqAgwqAgwqAgwqAgU3RlcHM6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgICogQ3JlYXRlIGEg
Y3J5cHRvZGV2IGluc3RhbmNlIHdpdGggcHJvdmlkZWQgZGV2aWNlIHR5cGUgYW5kIGJ1ZmZlciBz
aXplcy48YnI+DQotwqAgwqAgwqAgwqAgVmVyaWZ5Ojxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCAq
IFRoZSBsYXRlbmN5IGlzIGJlbG93IG9yIHdpdGhpbiBkZWx0YSBvZiBwcm92aWRlZCBiYXNlbGlu
ZS48YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgIFJhaXNlczo8YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgU2tpcHBlZFRlc3RFeGNlcHRpb246IFdoZW4gY29uZmlndXJhdGlvbiBpcyBub3QgcHJvdmlk
ZWQuPGJyPg0KLcKgIMKgIMKgIMKgICZxdW90OyZxdW90OyZxdW90Ozxicj4NCi3CoCDCoCDCoCDC
oCBpZiAmcXVvdDthZXNfY2JjX3NoYTFfaG1hYyZxdW90OyBub3QgaW4gc2VsZi5sYXRlbmN5X3Rl
c3RfcGFyYW1ldGVyczo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgc2tpcCgmcXVvdDt0ZXN0IG5v
dCBjb25maWd1cmVkJnF1b3Q7KTxicj4NCi3CoCDCoCDCoCDCoCBhcHAgPSBDcnlwdG9kZXYoPGJy
Pg0KLcKgIMKgIMKgIMKgIMKgIMKgIHB0ZXN0PVRlc3RUeXBlLmxhdGVuY3ksPGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgIGRldnR5cGU9c2VsZi5kZXZpY2VfdHlwZSw8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgb3B0eXBlPU9wZXJhdGlvblR5cGUuY2lwaGVyX3RoZW5fYXV0aCw8YnI+DQotwqAgwqAg
wqAgwqAgwqAgwqAgY2lwaGVyX2FsZ289Q2lwaGVyQWxnb3JpdGhtLmFlc19jYmMsPGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIGNpcGhlcl9vcD1FbmNyeXB0RGVjcnlwdFN3aXRjaC5lbmNyeXB0LDxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBjaXBoZXJfa2V5X3N6PTE2LDxicj4NCi3CoCDCoCDCoCDC
oCDCoCDCoCBhdXRoX2FsZ289QXV0aGVudGljYXRpb25BbGdvcml0aG0uc2hhMV9obWFjLDxicj4N
Ci3CoCDCoCDCoCDCoCDCoCDCoCBhdXRoX29wPUF1dGhlbnRpY2F0aW9uT3BNb2RlLmdlbmVyYXRl
LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBhdXRoX2tleV9zej02NCw8YnI+DQotwqAgwqAgwqAg
wqAgwqAgwqAgZGlnZXN0X3N6PTEyLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBidXJzdF9zej0z
Miw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgdG90YWxfb3BzPVRPVEFMX09QUyw8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgYnVmZmVyX3N6PXNlbGYuYnVmZmVyX3NpemVzWyZxdW90O2Flc19jYmNf
c2hhMV9obWFjJnF1b3Q7XSw8YnI+DQotwqAgwqAgwqAgwqAgKTxicj4NCi3CoCDCoCDCoCDCoCBy
ZXN1bHRzID0gc2VsZi5fdmVyaWZ5X2xhdGVuY3koYXBwLnJ1bl9hcHAoKSwgJnF1b3Q7YWVzX2Ni
Y19zaGExX2htYWMmcXVvdDspPGJyPg0KLcKgIMKgIMKgIMKgIHNlbGYuX3ByaW50X3N0YXRzKHJl
c3VsdHMpPGJyPg0KLcKgIMKgIMKgIMKgIGZvciByZXN1bHQgaW4gcmVzdWx0czo8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgdmVyaWZ5KDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXN1
bHRbJnF1b3Q7cGFzc2VkJnF1b3Q7XSA9PSAmcXVvdDtQQVNTJnF1b3Q7LDxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCAmcXVvdDtsYXRlbmN5IHdhcyBncmVhdGVyIHRoYW4gdGhlIGRlbHRh
IHRvbGVyYW5jZSBhYm92ZSBiYXNlbGluZSZxdW90Oyw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
KTxicj4NCi08YnI+DQotwqAgwqAgQGNyeXB0b190ZXN0PGJyPg0KLcKgIMKgIGRlZiBhZXNfY2Jj
X3NoYTJfaG1hYyhzZWxmKSAtJmd0OyBOb25lOjxicj4NCi3CoCDCoCDCoCDCoCAmcXVvdDsmcXVv
dDsmcXVvdDthZXNfY2JjX3NoYTJfaG1hYyBsYXRlbmN5IHRlc3QuPGJyPg0KK8KgIMKgIGRlZiBj
aXBoZXJfb25seV90ZXN0cyhzZWxmKSAtJmd0OyBOb25lOjxicj4NCivCoCDCoCDCoCDCoCAmcXVv
dDsmcXVvdDsmcXVvdDtDaXBoZXIgb25seSBjcnlwdG9ncmFwaHkgZGV2aWNlIHRlc3RzLjxicj4N
Cjxicj4NCsKgIMKgIMKgIMKgIMKgU3RlcHM6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgICogQ3Jl
YXRlIGEgY3J5cHRvZGV2IGluc3RhbmNlIHdpdGggcHJvdmlkZWQgZGV2aWNlIHR5cGUgYW5kIGJ1
ZmZlciBzaXplcy48YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgKiBSdW4gZHBkay10ZXN0LWNyeXB0
by1wZXJmIGFwcGxpY2F0aW9uIHdpdGggY29uZmlndXJlZCBhcmd1bWVudHMgaW4gY2lwaGVyIG9u
bHkgbW9kZS48YnI+DQrCoCDCoCDCoCDCoCDCoFZlcmlmeTo8YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgKiBUaGUgbGF0ZW5jeSBpcyBiZWxvdyBvciB3aXRoaW4gZGVsdGEgb2YgcHJvdmlkZWQgYmFz
ZWxpbmUuPGJyPg0KLTxicj4NCi3CoCDCoCDCoCDCoCBSYWlzZXM6PGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIFNraXBwZWRUZXN0RXhjZXB0aW9uOiBXaGVuIGNvbmZpZ3VyYXRpb24gaXMgbm90IHBy
b3ZpZGVkLjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCAqIFRoZSByZXBvcnRlZCBzdGF0aXN0aWNz
IGFyZSB3aXRoaW4gaXMgd2l0aGluIGEgZGVmaW5lZCB0b2xlcmFuY2Ugb2YgYSBnaXZlbiBiYXNl
bGluZS48YnI+DQrCoCDCoCDCoCDCoCDCoCZxdW90OyZxdW90OyZxdW90Ozxicj4NCi3CoCDCoCDC
oCDCoCBpZiAmcXVvdDthZXNfY2JjX3NoYTJfaG1hYyZxdW90OyBub3QgaW4gc2VsZi5sYXRlbmN5
X3Rlc3RfcGFyYW1ldGVyczo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgc2tpcCgmcXVvdDt0ZXN0
IG5vdCBjb25maWd1cmVkJnF1b3Q7KTxicj4NCi3CoCDCoCDCoCDCoCBhcHAgPSBDcnlwdG9kZXYo
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIHB0ZXN0PVRlc3RUeXBlLmxhdGVuY3ksPGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIGRldnR5cGU9c2VsZi5kZXZpY2VfdHlwZSw8YnI+DQotwqAgwqAgwqAg
wqAgwqAgwqAgb3B0eXBlPU9wZXJhdGlvblR5cGUuY2lwaGVyX3RoZW5fYXV0aCw8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgY2lwaGVyX2FsZ289Q2lwaGVyQWxnb3JpdGhtLmFlc19jYmMsPGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIGNpcGhlcl9vcD1FbmNyeXB0RGVjcnlwdFN3aXRjaC5lbmNyeXB0
LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBjaXBoZXJfa2V5X3N6PTE2LDxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCBjaXBoZXJfaXZfc3o9MTYsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIGF1dGhf
YWxnbz1BdXRoZW50aWNhdGlvbkFsZ29yaXRobS5zaGEyXzI1Nl9obWFjLDxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCBhdXRoX29wPUF1dGhlbnRpY2F0aW9uT3BNb2RlLmdlbmVyYXRlLDxicj4NCi3C
oCDCoCDCoCDCoCDCoCDCoCBhdXRoX2tleV9zej02NCw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
ZGlnZXN0X3N6PTMyLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBidXJzdF9zej0zMiw8YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAgdG90YWxfb3BzPVRPVEFMX09QUyw8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgYnVmZmVyX3N6PXNlbGYuYnVmZmVyX3NpemVzWyZxdW90O2Flc19jYmNfc2hhMl9obWFj
JnF1b3Q7XSw8YnI+DQotwqAgwqAgwqAgwqAgKTxicj4NCi3CoCDCoCDCoCDCoCByZXN1bHRzID0g
c2VsZi5fdmVyaWZ5X2xhdGVuY3koYXBwLnJ1bl9hcHAoKSwgJnF1b3Q7YWVzX2NiY19zaGEyX2ht
YWMmcXVvdDspPGJyPg0KLcKgIMKgIMKgIMKgIHNlbGYuX3ByaW50X3N0YXRzKHJlc3VsdHMpPGJy
Pg0KLcKgIMKgIMKgIMKgIGZvciByZXN1bHQgaW4gcmVzdWx0czo8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgdmVyaWZ5KDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXN1bHRbJnF1b3Q7
cGFzc2VkJnF1b3Q7XSA9PSAmcXVvdDtQQVNTJnF1b3Q7LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCAmcXVvdDtsYXRlbmN5IHdhcyBncmVhdGVyIHRoYW4gdGhlIGRlbHRhIHRvbGVyYW5j
ZSBhYm92ZSBiYXNlbGluZSZxdW90Oyw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgKTxicj4NCjxi
cj4NCi3CoCDCoCBAY3J5cHRvX3Rlc3Q8YnI+DQotwqAgwqAgZGVmIGFlc19kb2NzaXNicGkoc2Vs
ZikgLSZndDsgTm9uZTo8YnI+DQotwqAgwqAgwqAgwqAgJnF1b3Q7JnF1b3Q7JnF1b3Q7YWVzX2Rv
Y3Npc2JwaSBsYXRlbmN5IHRlc3QuPGJyPg0KLTxicj4NCi3CoCDCoCDCoCDCoCBTdGVwczo8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgKiBDcmVhdGUgYSBjcnlwdG9kZXYgaW5zdGFuY2Ugd2l0aCBw
cm92aWRlZCBkZXZpY2UgdHlwZSBhbmQgYnVmZmVyIHNpemVzLjxicj4NCi3CoCDCoCDCoCDCoCBW
ZXJpZnk6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgICogVGhlIGxhdGVuY3kgaXMgYmVsb3cgb3Ig
d2l0aGluIGRlbHRhIG9mIHByb3ZpZGVkIGJhc2VsaW5lLjxicj4NCi08YnI+DQotwqAgwqAgwqAg
wqAgUmFpc2VzOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBTa2lwcGVkVGVzdEV4Y2VwdGlvbjog
V2hlbiBjb25maWd1cmF0aW9uIGlzIG5vdCBwcm92aWRlZC48YnI+DQotwqAgwqAgwqAgwqAgJnF1
b3Q7JnF1b3Q7JnF1b3Q7PGJyPg0KLcKgIMKgIMKgIMKgIGlmICZxdW90O2Flc19kb2NzaXNicGkm
cXVvdDsgbm90IGluIHNlbGYubGF0ZW5jeV90ZXN0X3BhcmFtZXRlcnM6PGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIHNraXAoJnF1b3Q7dGVzdCBub3QgY29uZmlndXJlZCZxdW90Oyk8YnI+DQotwqAg
wqAgwqAgwqAgYXBwID0gQ3J5cHRvZGV2KDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBwdGVzdD1U
ZXN0VHlwZS5sYXRlbmN5LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBkZXZ0eXBlPXNlbGYuZGV2
aWNlX3R5cGUsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIG9wdHlwZT1PcGVyYXRpb25UeXBlLmNp
cGhlcl9vbmx5LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBjaXBoZXJfYWxnbz1DaXBoZXJBbGdv
cml0aG0uYWVzX2RvY3Npc2JwaSw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgY2lwaGVyX29wPUVu
Y3J5cHREZWNyeXB0U3dpdGNoLmVuY3J5cHQsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIGNpcGhl
cl9rZXlfc3o9MzIsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIGNpcGhlcl9pdl9zej0xNiw8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgdG90YWxfb3BzPVRPVEFMX09QUyw8YnI+DQotwqAgwqAgwqAg
wqAgwqAgwqAgYnVmZmVyX3N6PXNlbGYuYnVmZmVyX3NpemVzWyZxdW90O2Flc19kb2NzaXNicGkm
cXVvdDtdLDxicj4NCi3CoCDCoCDCoCDCoCApPGJyPg0KLcKgIMKgIMKgIMKgIHJlc3VsdHMgPSBz
ZWxmLl92ZXJpZnlfbGF0ZW5jeShhcHAucnVuX2FwcCgpLCAmcXVvdDthZXNfZG9jc2lzYnBpJnF1
b3Q7KTxicj4NCi3CoCDCoCDCoCDCoCBzZWxmLl9wcmludF9zdGF0cyhyZXN1bHRzKTxicj4NCi3C
oCDCoCDCoCDCoCBmb3IgcmVzdWx0IGluIHJlc3VsdHM6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKg
IHZlcmlmeSg8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmVzdWx0WyZxdW90O3Bhc3Nl
ZCZxdW90O10gPT0gJnF1b3Q7UEFTUyZxdW90Oyw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgJnF1b3Q7bGF0ZW5jeSB3YXMgZ3JlYXRlciB0aGFuIHRoZSBkZWx0YSB0b2xlcmFuY2UgYWJv
dmUgYmFzZWxpbmUmcXVvdDssPGJyPg0KK8KgIMKgIMKgIMKgIGRlZiB0ZXN0KGVuY3J5cHQ6IEVu
Y3J5cHREZWNyeXB0U3dpdGNoKSAtJmd0OyBsaXN0W2RpY3Rbc3RyLCBpbnQgfCBmbG9hdCB8IHN0
cl1dOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCAmcXVvdDsmcXVvdDsmcXVvdDtSdW4gYSBjb25m
aWd1cmVkIHRocm91Z2hwdXQgdGVzdCB3aXRoIHRoZSBnaXZlbiBlbmNyeXB0aW9uLjxicj4NCis8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgQXJnczo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgZW5jcnlwdDogVGhlIGNpcGhlciBlbmNyeXB0aW9uIG1vZGUgdG8gcnVuIHRocm91Z2hwdXQg
dGVzdGluZyBvbi48YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIFJldHVybnM6PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFRoZSBnZW5lcmF0ZWQgc3VtbWFyeSBvciBhbiBlbXB0
eSBsaXN0IGlmIGEgdGVzdCBpcyBza2lwcGVkLjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCAmcXVv
dDsmcXVvdDsmcXVvdDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgY2lwaGVyX3BhcmFtcyA9IENJ
UEhFUl9BTEdPUklUSE1fUEFSQU1TWzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBDaXBo
ZXJBbGdvcml0aG1bY29tYmluYXRpb25bJnF1b3Q7Y2lwaGVyX2FsZ29yaXRobSZxdW90O11dPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIF08YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgaXNfdmRldiA9
ICZxdW90O3ZpcnR1YWxfZGV2aWNlJnF1b3Q7IGluIGNvbWJpbmF0aW9uPGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIGFwcCA9IENyeXB0b2Rldig8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
cHRlc3Q9VGVzdFR5cGUubGF0ZW5jeSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZGV2
dHlwZT1zZWxmLmRldmljZV90eXBlLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBvcHR5
cGU9T3BlcmF0aW9uVHlwZS5jaXBoZXJfb25seSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgY2lwaGVyX2FsZ289Q2lwaGVyQWxnb3JpdGhtW2NvbWJpbmF0aW9uWyZxdW90O2NpcGhlcl9h
bGdvcml0aG0mcXVvdDtdXSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY2lwaGVyX29w
PWVuY3J5cHQsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNpcGhlcl9rZXlfc3o9Y29t
YmluYXRpb24uZ2V0KCZxdW90O2NpcGhlcl9rZXlfc2l6ZSZxdW90OywgY2lwaGVyX3BhcmFtc1sm
cXVvdDtrZXlfc2l6ZSZxdW90O10pLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjaXBo
ZXJfaXZfc3o9Y29tYmluYXRpb24uZ2V0KCZxdW90O2NpcGhlcl9pdl9zaXplJnF1b3Q7LCBjaXBo
ZXJfcGFyYW1zWyZxdW90O2l2X3NpemUmcXVvdDtdKSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgZGlnZXN0X3N6PWNvbWJpbmF0aW9uLmdldCgmcXVvdDtkaWdlc3Rfc2l6ZSZxdW90Oywg
MCksPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHRvdGFsX29wcz1jb21iaW5hdGlvbi5n
ZXQoJnF1b3Q7b3BzJnF1b3Q7LCBzZWxmLm9wcyksPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIGJ1ZmZlcl9zej1zZWxmLmJ1ZmZlcl9zaXplc1tjb21iaW5hdGlvbi5nZXQoJnF1b3Q7bmFt
ZSZxdW90OywgJnF1b3Q7Y3VzdG9tX3Rlc3QmcXVvdDspXSw8YnI+DQrCoCDCoCDCoCDCoCDCoCDC
oCDCoCk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgaWYgaXNfdmRldjo8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgYXBwLnVwZGF0ZV9wYXJhbXMoPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIHZkZXZzPVtWaXJ0dWFsRGV2aWNlKGNvbWJpbmF0aW9uWyZxdW90O3ZpcnR1
YWxfZGV2aWNlJnF1b3Q7XSldLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBk
ZXZ0eXBlPWdldF9kZXZpY2VfZnJvbV9zdHIoY29tYmluYXRpb25bJnF1b3Q7dmlydHVhbF9kZXZp
Y2UmcXVvdDtdKSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKTxicj4NCjxicj4NCi3C
oCDCoCBAY3J5cHRvX3Rlc3Q8YnI+DQotwqAgwqAgZGVmIGFlc19nY20oc2VsZikgLSZndDsgTm9u
ZTo8YnI+DQotwqAgwqAgwqAgwqAgJnF1b3Q7JnF1b3Q7JnF1b3Q7YWVzX2djbSBsYXRlbmN5IHRl
c3QuPGJyPg0KLTxicj4NCi3CoCDCoCDCoCDCoCBTdGVwczo8YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgKiBDcmVhdGUgYSBjcnlwdG9kZXYgaW5zdGFuY2Ugd2l0aCBwcm92aWRlZCBkZXZpY2UgdHlw
ZSBhbmQgYnVmZmVyIHNpemVzLjxicj4NCi3CoCDCoCDCoCDCoCBWZXJpZnk6PGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgICogVGhlIGxhdGVuY3kgaXMgYmVsb3cgb3Igd2l0aGluIGRlbHRhIG9mIHBy
b3ZpZGVkIGJhc2VsaW5lLjxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAgUmFpc2VzOjxicj4NCi3C
oCDCoCDCoCDCoCDCoCDCoCBTa2lwcGVkVGVzdEV4Y2VwdGlvbjogV2hlbiBjb25maWd1cmF0aW9u
IGlzIG5vdCBwcm92aWRlZC48YnI+DQotwqAgwqAgwqAgwqAgJnF1b3Q7JnF1b3Q7JnF1b3Q7PGJy
Pg0KLcKgIMKgIMKgIMKgIGlmICZxdW90O2Flc19nY20mcXVvdDsgbm90IGluIHNlbGYubGF0ZW5j
eV90ZXN0X3BhcmFtZXRlcnM6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIHNraXAoJnF1b3Q7dGVz
dCBub3QgY29uZmlndXJlZCZxdW90Oyk8YnI+DQotwqAgwqAgwqAgwqAgYXBwID0gQ3J5cHRvZGV2
KDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBwdGVzdD1UZXN0VHlwZS5sYXRlbmN5LDxicj4NCi3C
oCDCoCDCoCDCoCDCoCDCoCBkZXZ0eXBlPXNlbGYuZGV2aWNlX3R5cGUsPGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIG9wdHlwZT1PcGVyYXRpb25UeXBlLmFlYWQsPGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIGFlYWRfYWxnbz1BZWFkQWxnTmFtZS5hZXNfZ2NtLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCBhZWFkX29wPUVuY3J5cHREZWNyeXB0U3dpdGNoLmVuY3J5cHQsPGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIGFlYWRfa2V5X3N6PTE2LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBhZWFkX2l2X3N6
PTEyLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBhZWFkX2FhZF9zej0xNiw8YnI+DQotwqAgwqAg
wqAgwqAgwqAgwqAgZGlnZXN0X3N6PTE2LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBidXJzdF9z
ej0zMiw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgdG90YWxfb3BzPVRPVEFMX09QUyw8YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAgYnVmZmVyX3N6PXNlbGYuYnVmZmVyX3NpemVzWyZxdW90O2Flc19n
Y20mcXVvdDtdLDxicj4NCi3CoCDCoCDCoCDCoCApPGJyPg0KLcKgIMKgIMKgIMKgIHJlc3VsdHMg
PSBzZWxmLl92ZXJpZnlfbGF0ZW5jeShhcHAucnVuX2FwcCgpLCAmcXVvdDthZXNfZ2NtJnF1b3Q7
KTxicj4NCi3CoCDCoCDCoCDCoCBzZWxmLl9wcmludF9zdGF0cyhyZXN1bHRzKTxicj4NCi3CoCDC
oCDCoCDCoCBmb3IgcmVzdWx0IGluIHJlc3VsdHM6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIHZl
cmlmeSg8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmVzdWx0WyZxdW90O3Bhc3NlZCZx
dW90O10gPT0gJnF1b3Q7UEFTUyZxdW90Oyw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
JnF1b3Q7bGF0ZW5jeSB3YXMgZ3JlYXRlciB0aGFuIHRoZSBkZWx0YSB0b2xlcmFuY2UgYWJvdmUg
YmFzZWxpbmUmcXVvdDssPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgICk8YnI+DQotPGJyPg0KLcKg
IMKgIEBjcnlwdG9fdGVzdDxicj4NCi3CoCDCoCBkZWYga2FzdW1pX2Y4X2thc3VtaV9mOShzZWxm
KSAtJmd0OyBOb25lOjxicj4NCi3CoCDCoCDCoCDCoCAmcXVvdDsmcXVvdDsmcXVvdDtrYXN1bWlf
Zjhfa2FzdW1pX2Y5IGxhdGVuY3kgdGVzdC48YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgIFN0ZXBz
Ojxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCAqIENyZWF0ZSBhIGNyeXB0b2RldiBpbnN0YW5jZSB3
aXRoIHByb3ZpZGVkIGRldmljZSB0eXBlIGFuZCBidWZmZXIgc2l6ZXMuPGJyPg0KLcKgIMKgIMKg
IMKgIFZlcmlmeTo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgKiBUaGUgbGF0ZW5jeSBpcyBiZWxv
dyBvciB3aXRoaW4gZGVsdGEgb2YgcHJvdmlkZWQgYmFzZWxpbmUuPGJyPg0KLTxicj4NCi3CoCDC
oCDCoCDCoCBSYWlzZXM6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIFNraXBwZWRUZXN0RXhjZXB0
aW9uOiBXaGVuIGNvbmZpZ3VyYXRpb24gaXMgbm90IHByb3ZpZGVkLjxicj4NCi3CoCDCoCDCoCDC
oCAmcXVvdDsmcXVvdDsmcXVvdDs8YnI+DQotwqAgwqAgwqAgwqAgaWYgJnF1b3Q7a2FzdW1pX2Y4
X2thc3VtaV9mOSZxdW90OyBub3QgaW4gc2VsZi5sYXRlbmN5X3Rlc3RfcGFyYW1ldGVyczo8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgc2tpcCgmcXVvdDt0ZXN0IG5vdCBjb25maWd1cmVkJnF1b3Q7
KTxicj4NCi3CoCDCoCDCoCDCoCBhcHAgPSBDcnlwdG9kZXYoPGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIHB0ZXN0PVRlc3RUeXBlLmxhdGVuY3ksPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIGRldnR5
cGU9c2VsZi5kZXZpY2VfdHlwZSw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgb3B0eXBlPU9wZXJh
dGlvblR5cGUuY2lwaGVyX3RoZW5fYXV0aCw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgY2lwaGVy
X2FsZ289Q2lwaGVyQWxnb3JpdGhtLmthc3VtaV9mOCw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
Y2lwaGVyX29wPUVuY3J5cHREZWNyeXB0U3dpdGNoLmVuY3J5cHQsPGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIGNpcGhlcl9rZXlfc3o9MTYsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIGNpcGhlcl9p
dl9zej04LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBhdXRoX2FsZ289QXV0aGVudGljYXRpb25B
bGdvcml0aG0ua2FzdW1pX2Y5LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBhdXRoX29wPUF1dGhl
bnRpY2F0aW9uT3BNb2RlLmdlbmVyYXRlLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBhdXRoX2tl
eV9zej0xNiw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgZGlnZXN0X3N6PTQsPGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgIGJ1cnN0X3N6PTMyLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCB0b3RhbF9v
cHM9VE9UQUxfT1BTLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBidWZmZXJfc3o9c2VsZi5idWZm
ZXJfc2l6ZXNbJnF1b3Q7a2FzdW1pX2Y4X2thc3VtaV9mOSZxdW90O10sPGJyPg0KLcKgIMKgIMKg
IMKgICk8YnI+DQotwqAgwqAgwqAgwqAgcmVzdWx0cyA9IHNlbGYuX3ZlcmlmeV9sYXRlbmN5KGFw
cC5ydW5fYXBwKCksICZxdW90O2thc3VtaV9mOF9rYXN1bWlfZjkmcXVvdDspPGJyPg0KLcKgIMKg
IMKgIMKgIHNlbGYuX3ByaW50X3N0YXRzKHJlc3VsdHMpPGJyPg0KLcKgIMKgIMKgIMKgIGZvciBy
ZXN1bHQgaW4gcmVzdWx0czo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgdmVyaWZ5KDxicj4NCi3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXN1bHRbJnF1b3Q7cGFzc2VkJnF1b3Q7XSA9PSAmcXVv
dDtQQVNTJnF1b3Q7LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmcXVvdDtsYXRlbmN5
IHdhcyBncmVhdGVyIHRoYW4gdGhlIGRlbHRhIHRvbGVyYW5jZSBhYm92ZSBiYXNlbGluZSZxdW90
Oyw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBzZWxm
Ll88YSBocmVmPSJodHRwOi8vbG9nZ2VyLmluZm8iIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJf
YmxhbmsiPmxvZ2dlci5pbmZvPC9hPihmJnF1b3Q7UnVubmluZyBjb25maWd1cmVkIHRlc3Q6IHt0
ZXN0X25hbWV9IGluIHtlbmNyeXB0fSBtb2RlJnF1b3Q7KTxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCB0cnk6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybiBzZWxmLl9jcmVhdGVf
c3VtbWFyeSg8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmVzdWx0cz1hcHAu
cnVuX2FwcChudW1fdmZzPTAgaWYgaXNfdmRldiBlbHNlIDEpLDxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBwYXJhbXM9Y29tYmluYXRpb24uZ2V0KCZxdW90O3Rlc3RfcGFyYW1l
dGVycyZxdW90OywgY29uZmlnX2xpc3QpLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCB0ZXN0X25hbWU9ZiZxdW90O3tjb21iaW5hdGlvbi5nZXQoJiMzOTtuYW1lJiMzOTssICYj
Mzk7dW5uYW1lZC10ZXN0JiMzOTspfSAtIHtlbmNyeXB0fSZxdW90Oyw8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCAjIEEgc2tpcCBvbiBvbmUg
dGVzdCB3aWxsIHN0b3AgdGhlIGV4ZWN1dGlvbiBvZiBhbGwgdGVzdHMsIHJldHVybiBlbXB0eSBz
dW1tYXJ5Ljxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBleGNlcHQgU2tpcHBlZFRlc3RFeGNlcHRp
b24gYXMgZTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc2VsZi5fbG9nZ2VyLmVycm9y
KGYmcXVvdDt0ZXN0IHt0ZXN0X25hbWV9IHNraXBwZWQ6IHtzdHIoZSl9JnF1b3Q7KTxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm4gW108YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKg
IHRlc3RfY2FzZXNfc2tpcHBlZDogaW50ID0gMDxicj4NCivCoCDCoCDCoCDCoCBmYWlsZWQ6IGJv
b2wgPSBGYWxzZTxicj4NCivCoCDCoCDCoCDCoCByZWFzb246IHN0ciA9ICZxdW90OyZxdW90Ozxi
cj4NCivCoCDCoCDCoCDCoCAjIEV4ZWN1dGUgYWxsIGNpcGhlciBvbmx5IHRlc3RzIGFuZCB2ZXJp
Znk8YnI+DQorwqAgwqAgwqAgwqAgZm9yIGNvbWJpbmF0aW9uIGluIHNlbGYuY2lwaGVyX3Rlc3Rz
Ojxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCB0ZXN0X25hbWUgPSBjb21iaW5hdGlvbi5nZXQoJnF1
b3Q7bmFtZSZxdW90OywgJnF1b3Q7dW5uYW1lZF90ZXN0JnF1b3Q7KTxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCBjb21iaW5hdGlvbl9yZXN1bHRzID0gWyh0ZXN0KG1vZGUpKSBmb3IgbW9kZSBpbiBF
bmNyeXB0RGVjcnlwdFN3aXRjaF08YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgaWYgYWxsKHJlc3Vs
dCA9PSBbXSBmb3IgcmVzdWx0IGluIGNvbWJpbmF0aW9uX3Jlc3VsdHMpOjxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCB0ZXN0X2Nhc2VzX3NraXBwZWQgKz0gMTxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCBlbHNlOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB0cnk6PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHNlbGYuX3ByaW50X2FuZF92ZXJpZnkoY29tYmlu
YXRpb25fcmVzdWx0cyk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZXhjZXB0IFRlc3RD
YXNlVmVyaWZ5RXJyb3IgYXMgZTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
ZmFpbGVkID0gVHJ1ZTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZWFzb24g
PSBmJnF1b3Q7e3JlYXNvbn1cbntzdHIoZSl9JnF1b3Q7IGlmIHJlYXNvbiBlbHNlIHN0cihlKTxi
cj4NCivCoCDCoCDCoCDCoCBpZiBmYWlsZWQ6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIGZhaWwo
cmVhc29uKTxicj4NCivCoCDCoCDCoCDCoCBpZiB0ZXN0X2Nhc2VzX3NraXBwZWQgPT0gbGVuKHNl
bGYuY2lwaGVyX3Rlc3RzKTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgc2tpcCgmcXVvdDtBbGwg
Y29uZmlndXJlZCB0ZXN0IGNhc2VzIHNraXBwZWQuJnF1b3Q7KTxicj4NCjxicj4NCsKgIMKgIMKg
QGNyeXB0b190ZXN0PGJyPg0KLcKgIMKgIGRlZiBzbm93M2dfdWVhMl9zbm93M2dfdWlhMihzZWxm
KSAtJmd0OyBOb25lOjxicj4NCi3CoCDCoCDCoCDCoCAmcXVvdDsmcXVvdDsmcXVvdDtzbm93M2df
dWVhMl9zbm93M2dfdWlhMiBsYXRlbmN5IHRlc3QuPGJyPg0KK8KgIMKgIGRlZiBhdXRoX29ubHlf
dGVzdHMoc2VsZikgLSZndDsgTm9uZTo8YnI+DQorwqAgwqAgwqAgwqAgJnF1b3Q7JnF1b3Q7JnF1
b3Q7QXV0aGVudGljYXRpb24gY3J5cHRvZ3JhcGh5IGRldmljZSB0ZXN0cy48YnI+DQo8YnI+DQrC
oCDCoCDCoCDCoCDCoFN0ZXBzOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCAqIENyZWF0ZSBhIGNy
eXB0b2RldiBpbnN0YW5jZSB3aXRoIHByb3ZpZGVkIGRldmljZSB0eXBlIGFuZCBidWZmZXIgc2l6
ZXMuPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgICogUnVuIGRwZGstdGVzdC1jcnlwdG8tcGVyZiBh
cHBsaWNhdGlvbiB3aXRoIGNvbmZpZ3VyZWQgcGFyYW1ldGVycyBpbiBhdXRoZW50aWNhdGlvbjxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBvbmx5IG1vb2RlLjxicj4NCsKgIMKgIMKgIMKg
IMKgVmVyaWZ5Ojxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCAqIFRoZSBsYXRlbmN5IGlzIGJlbG93
IG9yIHdpdGhpbiBkZWx0YSBvZiBwcm92aWRlZCBiYXNlbGluZS48YnI+DQotPGJyPg0KLcKgIMKg
IMKgIMKgIFJhaXNlczo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgU2tpcHBlZFRlc3RFeGNlcHRp
b246IFdoZW4gY29uZmlndXJhdGlvbiBpcyBub3QgcHJvdmlkZWQuPGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgICogVGhlIHJlc3VsdGluZyBzdGF0aXN0aWNzIGFyZSB3aXRoaW4gYSBkZWx0YSB0b2xl
cmFuY2Ugb2YgYSBwcm92aWRlZCBiYXNlbGluZS48YnI+DQrCoCDCoCDCoCDCoCDCoCZxdW90OyZx
dW90OyZxdW90Ozxicj4NCi3CoCDCoCDCoCDCoCBpZiAmcXVvdDtzbm93M2dfdWVhMl9zbm93M2df
dWlhMiZxdW90OyBub3QgaW4gc2VsZi5sYXRlbmN5X3Rlc3RfcGFyYW1ldGVyczo8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgc2tpcCgmcXVvdDt0ZXN0IG5vdCBjb25maWd1cmVkJnF1b3Q7KTxicj4N
Ci3CoCDCoCDCoCDCoCBhcHAgPSBDcnlwdG9kZXYoPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIHB0
ZXN0PVRlc3RUeXBlLmxhdGVuY3ksPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIGRldnR5cGU9c2Vs
Zi5kZXZpY2VfdHlwZSw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgb3B0eXBlPU9wZXJhdGlvblR5
cGUuY2lwaGVyX3RoZW5fYXV0aCw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgY2lwaGVyX2FsZ289
Q2lwaGVyQWxnb3JpdGhtLnNub3czZ191ZWEyLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBjaXBo
ZXJfb3A9RW5jcnlwdERlY3J5cHRTd2l0Y2guZW5jcnlwdCw8YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgY2lwaGVyX2tleV9zej0xNiw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgY2lwaGVyX2l2X3N6
PTE2LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBhdXRoX2FsZ289QXV0aGVudGljYXRpb25BbGdv
cml0aG0uc25vdzNnX3VpYTIsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIGF1dGhfb3A9QXV0aGVu
dGljYXRpb25PcE1vZGUuZ2VuZXJhdGUsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIGF1dGhfa2V5
X3N6PTE2LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBhdXRoX2l2X3N6PTE2LDxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCBkaWdlc3Rfc3o9NCw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgdG90YWxf
b3BzPVRPVEFMX09QUyw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgYnVmZmVyX3N6PXNlbGYuYnVm
ZmVyX3NpemVzWyZxdW90O3Nub3czZ191ZWEyX3Nub3czZ191aWEyJnF1b3Q7XSw8YnI+DQotwqAg
wqAgwqAgwqAgKTxicj4NCi3CoCDCoCDCoCDCoCByZXN1bHRzID0gc2VsZi5fdmVyaWZ5X2xhdGVu
Y3koYXBwLnJ1bl9hcHAoKSwgJnF1b3Q7c25vdzNnX3VlYTJfc25vdzNnX3VpYTImcXVvdDspPGJy
Pg0KLcKgIMKgIMKgIMKgIHNlbGYuX3ByaW50X3N0YXRzKHJlc3VsdHMpPGJyPg0KLcKgIMKgIMKg
IMKgIGZvciByZXN1bHQgaW4gcmVzdWx0czo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgdmVyaWZ5
KDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXN1bHRbJnF1b3Q7cGFzc2VkJnF1b3Q7
XSA9PSAmcXVvdDtQQVNTJnF1b3Q7LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmcXVv
dDtsYXRlbmN5IHdhcyBncmVhdGVyIHRoYW4gdGhlIGRlbHRhIHRvbGVyYW5jZSBhYm92ZSBiYXNl
bGluZSZxdW90Oyw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgKTxicj4NCi08YnI+DQotwqAgwqAg
QGNyeXB0b190ZXN0PGJyPg0KLcKgIMKgIGRlZiB6dWNfZWVhM196dWNfZWlhMyhzZWxmKSAtJmd0
OyBOb25lOjxicj4NCi3CoCDCoCDCoCDCoCAmcXVvdDsmcXVvdDsmcXVvdDt6dWNfZWVhM196dWNf
ZWlhMyBjaXBoZXIgYW5kIGF1dGggbGF0ZW5jeSB0ZXN0Ljxicj4NCjxicj4NCi3CoCDCoCDCoCDC
oCBTdGVwczo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgKiBDcmVhdGUgYSBjcnlwdG9kZXYgaW5z
dGFuY2Ugd2l0aCBwcm92aWRlZCBkZXZpY2UgdHlwZSBhbmQgYnVmZmVyIHNpemVzLjxicj4NCi3C
oCDCoCDCoCDCoCBWZXJpZnk6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgICogVGhlIGxhdGVuY3kg
aXMgYmVsb3cgb3Igd2l0aGluIGRlbHRhIG9mIHByb3ZpZGVkIGJhc2VsaW5lLjxicj4NCi08YnI+
DQotwqAgwqAgwqAgwqAgUmFpc2VzOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBTa2lwcGVkVGVz
dEV4Y2VwdGlvbjogV2hlbiBjb25maWd1cmF0aW9uIGlzIG5vdCBwcm92aWRlZC48YnI+DQotwqAg
wqAgwqAgwqAgJnF1b3Q7JnF1b3Q7JnF1b3Q7PGJyPg0KLcKgIMKgIMKgIMKgIGlmICZxdW90O3p1
Y19lZWEzX3p1Y19laWEzJnF1b3Q7IG5vdCBpbiBzZWxmLmxhdGVuY3lfdGVzdF9wYXJhbWV0ZXJz
Ojxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBza2lwKCZxdW90O3Rlc3Qgbm90IGNvbmZpZ3VyZWQm
cXVvdDspPGJyPg0KLcKgIMKgIMKgIMKgIGFwcCA9IENyeXB0b2Rldig8YnI+DQotwqAgwqAgwqAg
wqAgwqAgwqAgcHRlc3Q9VGVzdFR5cGUubGF0ZW5jeSw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
ZGV2dHlwZT1zZWxmLmRldmljZV90eXBlLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBvcHR5cGU9
T3BlcmF0aW9uVHlwZS5jaXBoZXJfdGhlbl9hdXRoLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBj
aXBoZXJfYWxnbz1DaXBoZXJBbGdvcml0aG0uenVjX2VlYTMsPGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIGNpcGhlcl9vcD1FbmNyeXB0RGVjcnlwdFN3aXRjaC5lbmNyeXB0LDxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCBjaXBoZXJfa2V5X3N6PTE2LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBjaXBo
ZXJfaXZfc3o9MTYsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIGF1dGhfYWxnbz1BdXRoZW50aWNh
dGlvbkFsZ29yaXRobS56dWNfZWlhMyw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgYXV0aF9vcD1B
dXRoZW50aWNhdGlvbk9wTW9kZS5nZW5lcmF0ZSw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgYXV0
aF9rZXlfc3o9MTYsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIGF1dGhfaXZfc3o9MTYsPGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIGRpZ2VzdF9zej00LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCB0
b3RhbF9vcHM9VE9UQUxfT1BTLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBidWZmZXJfc3o9c2Vs
Zi5idWZmZXJfc2l6ZXNbJnF1b3Q7enVjX2VlYTNfenVjX2VpYTMmcXVvdDtdLDxicj4NCi3CoCDC
oCDCoCDCoCApPGJyPg0KLcKgIMKgIMKgIMKgIHJlc3VsdHMgPSBzZWxmLl92ZXJpZnlfbGF0ZW5j
eShhcHAucnVuX2FwcCgpLCAmcXVvdDt6dWNfZWVhM196dWNfZWlhMyZxdW90Oyk8YnI+DQotwqAg
wqAgwqAgwqAgc2VsZi5fcHJpbnRfc3RhdHMocmVzdWx0cyk8YnI+DQotwqAgwqAgwqAgwqAgZm9y
IHJlc3VsdCBpbiByZXN1bHRzOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCB2ZXJpZnkoPGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJlc3VsdFsmcXVvdDtwYXNzZWQmcXVvdDtdID09ICZx
dW90O1BBU1MmcXVvdDssPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZxdW90O2xhdGVu
Y3kgd2FzIGdyZWF0ZXIgdGhhbiB0aGUgZGVsdGEgdG9sZXJhbmNlIGFib3ZlIGJhc2VsaW5lJnF1
b3Q7LDxicj4NCivCoCDCoCDCoCDCoCBkZWYgdGVzdChvcF9tb2RlOiBBdXRoZW50aWNhdGlvbk9w
TW9kZSkgLSZndDsgbGlzdFtkaWN0W3N0ciwgaW50IHwgZmxvYXQgfCBzdHJdXTo8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgJnF1b3Q7JnF1b3Q7JnF1b3Q7UnVuIGEgY29uZmlndXJlZCB0aHJvdWdo
cHV0IHRlc3Qgd2l0aCB0aGUgZ2l2ZW4gYXV0aGVudGljYXRpb24gbW9kZS48YnI+DQorPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIEFyZ3M6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIG9w
X21vZGU6IFRoZSBhdXRoZW50aWNhdGlvbiBvcCBtb2RlIHRvIHJ1biB0ZXN0aW5nIGluLjxicj4N
Cis8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgUmV0dXJuczo8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgVGhlIGdlbmVyYXRlZCBzdW1tYXJ5IG9yIGFuIGVtcHR5IGxpc3QgaWYgYSB0ZXN0
IGlzIHNraXBwZWQuPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgICZxdW90OyZxdW90OyZxdW90Ozxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCBhdXRoX3BhcmFtcyA9IEFVVEhFTlRJQ0FUSU9OX0FMR09S
SVRITV9QQVJBTVNbPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIEF1dGhlbnRpY2F0aW9u
QWxnb3JpdGhtW2NvbWJpbmF0aW9uWyZxdW90O2F1dGhfYWxnb3JpdGhtJnF1b3Q7XV08YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgXTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBpc192ZGV2OiBib29s
ID0gJnF1b3Q7dmlydHVhbF9kZXZpY2UmcXVvdDsgaW4gY29tYmluYXRpb248YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgYXBwID0gQ3J5cHRvZGV2KDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBwdGVzdD1UZXN0VHlwZS5sYXRlbmN5LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBk
ZXZ0eXBlPXNlbGYuZGV2aWNlX3R5cGUsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIG9w
dHlwZT1PcGVyYXRpb25UeXBlLmF1dGhfb25seSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgYXV0aF9hbGdvPUF1dGhlbnRpY2F0aW9uQWxnb3JpdGhtW2NvbWJpbmF0aW9uWyZxdW90O2F1
dGhfYWxnb3JpdGhtJnF1b3Q7XV0sPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGF1dGhf
b3A9b3BfbW9kZSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYXV0aF9rZXlfc3o9Y29t
YmluYXRpb24uZ2V0KCZxdW90O2F1dGhfa2V5X3NpemUmcXVvdDssIGF1dGhfcGFyYW1zWyZxdW90
O2tleV9zaXplJnF1b3Q7XSksPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGF1dGhfaXZf
c3o9Y29tYmluYXRpb24uZ2V0KCZxdW90O2F1dGhfaXZfc2l6ZSZxdW90OywgYXV0aF9wYXJhbXNb
JnF1b3Q7aXZfc2l6ZSZxdW90O10pLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB0b3Rh
bF9vcHM9Y29tYmluYXRpb24uZ2V0KCZxdW90O29wcyZxdW90Oywgc2VsZi5vcHMpLDxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBkaWdlc3Rfc3o9Y29tYmluYXRpb24uZ2V0KCZxdW90O2Rp
Z2VzdF9zaXplJnF1b3Q7LCAwKSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYnVmZmVy
X3N6PXNlbGYuYnVmZmVyX3NpemVzW2NvbWJpbmF0aW9uWyZxdW90O25hbWUmcXVvdDtdXSw8YnI+
DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgaWYgaXNfdmRl
djo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYXBwLnVwZGF0ZV9wYXJhbXMoPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHZkZXZzPVtWaXJ0dWFsRGV2aWNlKGNvbWJp
bmF0aW9uWyZxdW90O3ZpcnR1YWxfZGV2aWNlJnF1b3Q7XSldLDxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBkZXZ0eXBlPWdldF9kZXZpY2VfZnJvbV9zdHIoY29tYmluYXRpb25b
JnF1b3Q7dmlydHVhbF9kZXZpY2UmcXVvdDtdKSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgKTxicj4NCjxicj4NCi3CoCDCoCAjIEJFR0lOIFZERVYgVEVTVFM8YnI+DQotPGJyPg0KLcKg
IMKgIEBjcnlwdG9fdGVzdDxicj4NCi3CoCDCoCBkZWYgYWVzbmlfZ2NtX3ZkZXYoc2VsZikgLSZn
dDsgTm9uZTo8YnI+DQotwqAgwqAgwqAgwqAgJnF1b3Q7JnF1b3Q7JnF1b3Q7YWVzbmlfZ2NtIHZp
cnR1YWwgZGV2aWNlIGxhdGVuY3kgdGVzdC48YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgIFN0ZXBz
Ojxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCAqIENyZWF0ZSBhIGNyeXB0b2RldiBpbnN0YW5jZSB3
aXRoIHByb3ZpZGVkIGRldmljZSB0eXBlIGFuZCBidWZmZXIgc2l6ZXMuPGJyPg0KLcKgIMKgIMKg
IMKgIFZlcmlmeTo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgKiBUaGUgbGF0ZW5jeSBpcyBiZWxv
dyBvciB3aXRoaW4gZGVsdGEgb2YgcHJvdmlkZWQgYmFzZWxpbmUuPGJyPg0KLTxicj4NCi3CoCDC
oCDCoCDCoCBSYWlzZXM6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIFNraXBwZWRUZXN0RXhjZXB0
aW9uOiBXaGVuIGNvbmZpZ3VyYXRpb24gaXMgbm90IHByb3ZpZGVkLjxicj4NCi3CoCDCoCDCoCDC
oCAmcXVvdDsmcXVvdDsmcXVvdDs8YnI+DQotwqAgwqAgwqAgwqAgaWYgJnF1b3Q7YWVzbmlfZ2Nt
X3ZkZXYmcXVvdDsgbm90IGluIHNlbGYubGF0ZW5jeV90ZXN0X3BhcmFtZXRlcnM6PGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIHNraXAoJnF1b3Q7dGVzdCBub3QgY29uZmlndXJlZCZxdW90Oyk8YnI+
DQotwqAgwqAgwqAgwqAgYXBwID0gQ3J5cHRvZGV2KDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBw
dGVzdD1UZXN0VHlwZS5sYXRlbmN5LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCB2ZGV2cz1bVmly
dHVhbERldmljZSgmcXVvdDtjcnlwdG9fYWVzbmlfZ2NtMCZxdW90OyldLDxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCBkZXZ0eXBlPURldmljZVR5cGUuY3J5cHRvX2Flc25pX2djbSw8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgb3B0eXBlPU9wZXJhdGlvblR5cGUuYWVhZCw8YnI+DQotwqAgwqAgwqAg
wqAgwqAgwqAgYWVhZF9vcD1FbmNyeXB0RGVjcnlwdFN3aXRjaC5lbmNyeXB0LDxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCBhZWFkX2tleV9zej0xNiw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgYWVh
ZF9pdl9zej0xMiw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgYWVhZF9hYWRfc3o9MTYsPGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIGRpZ2VzdF9zej0xNiw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
YnVyc3Rfc3o9MzIsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIHRvdGFsX29wcz1UT1RBTF9PUFMs
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIGJ1ZmZlcl9zej1zZWxmLmJ1ZmZlcl9zaXplc1smcXVv
dDthZXNuaV9nY21fdmRldiZxdW90O10sPGJyPg0KLcKgIMKgIMKgIMKgICk8YnI+DQotwqAgwqAg
wqAgwqAgcmVzdWx0cyA9IHNlbGYuX3ZlcmlmeV9sYXRlbmN5KGFwcC5ydW5fYXBwKG51bV92ZnM9
MCksICZxdW90O2Flc25pX2djbV92ZGV2JnF1b3Q7KTxicj4NCi3CoCDCoCDCoCDCoCBzZWxmLl9w
cmludF9zdGF0cyhyZXN1bHRzKTxicj4NCi3CoCDCoCDCoCDCoCBmb3IgcmVzdWx0IGluIHJlc3Vs
dHM6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIHZlcmlmeSg8YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgcmVzdWx0WyZxdW90O3Bhc3NlZCZxdW90O10gPT0gJnF1b3Q7UEFTUyZxdW90Oyw8
YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7bGF0ZW5jeSB3YXMgZ3JlYXRlciB0
aGFuIHRoZSBkZWx0YSB0b2xlcmFuY2UgYWJvdmUgYmFzZWxpbmUmcXVvdDssPGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgICk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgc2VsZi5fPGEgaHJlZj0iaHR0
cDovL2xvZ2dlci5pbmZvIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5sb2dnZXIu
aW5mbzwvYT4oZiZxdW90O1J1bm5pbmcgY29uZmlndXJlZCB0ZXN0OiB7dGVzdF9uYW1lfSBpbiB7
b3BfbW9kZX0gbW9kZSZxdW90Oyk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgdHJ5Ojxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm4gc2VsZi5fY3JlYXRlX3N1bW1hcnkoPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJlc3VsdHM9YXBwLnJ1bl9hcHAobnVtX3Zm
cz0wIGlmIGlzX3ZkZXYgZWxzZSAxKSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgcGFyYW1zPWNvbWJpbmF0aW9uLmdldCgmcXVvdDt0ZXN0X3BhcmFtZXRlcnMmcXVvdDssIGNv
bmZpZ19saXN0KSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdGVzdF9uYW1l
PWYmcXVvdDt7Y29tYmluYXRpb24uZ2V0KCYjMzk7bmFtZSYjMzk7LCAmIzM5O3VubmFtZWQtdGVz
dCYjMzk7KX0gLSB7b3BfbW9kZX0mcXVvdDssPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
ICk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgIyBBIHNraXAgb24gb25lIHRlc3Qgd2lsbCBzdG9w
IHRoZSBleGVjdXRpb24gb2YgYWxsIHRlc3RzLCByZXR1cm4gZW1wdHkgc3VtbWFyeS48YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgZXhjZXB0IFNraXBwZWRUZXN0RXhjZXB0aW9uIGFzIGU6PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHNlbGYuX2xvZ2dlci5lcnJvcihmJnF1b3Q7ZmFpbGVk
IHRvIHJ1biB0ZXN0IHt0ZXN0X25hbWV9OiB7c3RyKGUpfSZxdW90Oyk8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgcmV0dXJuIFtdPGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCB0ZXN0X2Nh
c2VzX3NraXBwZWQ6IGludCA9IDA8YnI+DQorwqAgwqAgwqAgwqAgZmFpbGVkOiBib29sID0gRmFs
c2U8YnI+DQorwqAgwqAgwqAgwqAgcmVhc29uOiBzdHIgPSAmcXVvdDsmcXVvdDs8YnI+DQorwqAg
wqAgwqAgwqAgIyBFeGVjdXRlIGFsbCBhdXRoIG9ubHkgdGVzdHMgYW5kIHZlcmlmeTxicj4NCivC
oCDCoCDCoCDCoCBmb3IgY29tYmluYXRpb24gaW4gc2VsZi5hdXRoX3Rlc3RzOjxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCB0ZXN0X25hbWUgPSBjb21iaW5hdGlvbi5nZXQoJnF1b3Q7bmFtZSZxdW90
OywgJnF1b3Q7dW5uYW1lZF90ZXN0JnF1b3Q7KTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBjb21i
aW5hdGlvbl9yZXN1bHRzID0gWyh0ZXN0KEF1dGhlbnRpY2F0aW9uT3BNb2RlLmdlbmVyYXRlKSld
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIGlmIGFsbChyZXN1bHQgPT0gW10gZm9yIHJlc3VsdCBp
biBjb21iaW5hdGlvbl9yZXN1bHRzKTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdGVz
dF9jYXNlc19za2lwcGVkICs9IDE8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgZWxzZTo8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdHJ5Ojxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBzZWxmLl9wcmludF9hbmRfdmVyaWZ5KGNvbWJpbmF0aW9uX3Jlc3VsdHMpPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGV4Y2VwdCBUZXN0Q2FzZVZlcmlmeUVycm9yIGFzIGU6
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZhaWxlZCA9IFRydWU8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmVhc29uID0gZiZxdW90O3tyZWFzb259XG57
c3RyKGUpfSZxdW90OyBpZiByZWFzb24gZWxzZSBzdHIoZSk8YnI+DQorwqAgwqAgwqAgwqAgaWYg
ZmFpbGVkOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBmYWlsKHJlYXNvbik8YnI+DQorwqAgwqAg
wqAgwqAgaWYgdGVzdF9jYXNlc19za2lwcGVkID09IGxlbihzZWxmLmF1dGhfdGVzdHMpOjxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCBza2lwKCZxdW90O0FsbCBjb25maWd1cmVkIHRlc3QgY2FzZXMg
c2tpcHBlZC4mcXVvdDspPGJyPg0KPGJyPg0KwqAgwqAgwqBAY3J5cHRvX3Rlc3Q8YnI+DQotwqAg
wqAgZGVmIGFlc25pX21iX2NpcGhlcl90aGVuX2F1dGhfdmRldihzZWxmKSAtJmd0OyBOb25lOjxi
cj4NCi3CoCDCoCDCoCDCoCAmcXVvdDsmcXVvdDsmcXVvdDthZXNuaV9tYiB2ZGV2IGNpcGhlciBh
bmQgYXV0aCBsYXRlbmN5IHRlc3QuPGJyPg0KK8KgIMKgIGRlZiBhZWFkX3Rlc3Qoc2VsZikgLSZn
dDsgTm9uZTo8YnI+DQorwqAgwqAgwqAgwqAgJnF1b3Q7JnF1b3Q7JnF1b3Q7QWVhZCBjcnlwdG9n
cmFwaHkgdGVzdC48YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCDCoFN0ZXBzOjxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCAqIENyZWF0ZSBhIGNyeXB0b2RldiBpbnN0YW5jZSB3aXRoIHByb3ZpZGVkIGRl
dmljZSB0eXBlIGFuZCBidWZmZXIgc2l6ZXMuPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgICogUnVu
IGRwZGstdGVzdC1jcnlwdG8tcGVyZiBhcHBsaWNhdGlvbiB3aXRoIGNvbmZpZ3VyZWQgcGFyYW1l
dGVycyBpbiBhZWFkIG1vZGUuPGJyPg0KwqAgwqAgwqAgwqAgwqBWZXJpZnk6PGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgICogVGhlIGxhdGVuY3kgaXMgYmVsb3cgb3Igd2l0aGluIGRlbHRhIG9mIHBy
b3ZpZGVkIGJhc2VsaW5lLjxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAgUmFpc2VzOjxicj4NCi3C
oCDCoCDCoCDCoCDCoCDCoCBTa2lwcGVkVGVzdEV4Y2VwdGlvbjogV2hlbiBjb25maWd1cmF0aW9u
IGlzIG5vdCBwcm92aWRlZC48YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgKiBUaGUgcmVzdWx0aW5n
IHN0YXRpc3RpY3MgYXJlIHdpdGhpbiBhIGRlbHRhIHRvbGVyYW5jZSBvZiBhIGdpdmVuIGJhc2Vs
aW5lLjxicj4NCsKgIMKgIMKgIMKgIMKgJnF1b3Q7JnF1b3Q7JnF1b3Q7PGJyPg0KLcKgIMKgIMKg
IMKgIGlmICZxdW90O2Flc25pX21iX2NpcGhlcl90aGVuX2F1dGhfdmRldiZxdW90OyBub3QgaW4g
c2VsZi5sYXRlbmN5X3Rlc3RfcGFyYW1ldGVyczo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgc2tp
cCgmcXVvdDt0ZXN0IG5vdCBjb25maWd1cmVkJnF1b3Q7KTxicj4NCi3CoCDCoCDCoCDCoCBhcHAg
PSBDcnlwdG9kZXYoPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIHB0ZXN0PVRlc3RUeXBlLmxhdGVu
Y3ksPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIHZkZXZzPVtWaXJ0dWFsRGV2aWNlKCZxdW90O2Ny
eXB0b19hZXNuaV9tYjAmcXVvdDspXSw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgZGV2dHlwZT1E
ZXZpY2VUeXBlLmNyeXB0b19hZXNuaV9tYiw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgb3B0eXBl
PU9wZXJhdGlvblR5cGUuY2lwaGVyX3RoZW5fYXV0aCw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
Y2lwaGVyX2FsZ289Q2lwaGVyQWxnb3JpdGhtLmFlc19jYmMsPGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIGNpcGhlcl9vcD1FbmNyeXB0RGVjcnlwdFN3aXRjaC5lbmNyeXB0LDxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCBjaXBoZXJfa2V5X3N6PTE2LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBhdXRo
X2FsZ289QXV0aGVudGljYXRpb25BbGdvcml0aG0uc2hhMV9obWFjLDxicj4NCi3CoCDCoCDCoCDC
oCDCoCDCoCBhdXRoX29wPUF1dGhlbnRpY2F0aW9uT3BNb2RlLmdlbmVyYXRlLDxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCBhdXRoX2tleV9zej02NCw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgZGln
ZXN0X3N6PTEyLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBidXJzdF9zej0zMiw8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgdG90YWxfb3BzPVRPVEFMX09QUyw8YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgYnVmZmVyX3N6PXNlbGYuYnVmZmVyX3NpemVzWyZxdW90O2Flc25pX21iX2NpcGhlcl90aGVu
X2F1dGhfdmRldiZxdW90O10sPGJyPg0KLcKgIMKgIMKgIMKgICk8YnI+DQotwqAgwqAgwqAgwqAg
cmVzdWx0cyA9IHNlbGYuX3ZlcmlmeV9sYXRlbmN5KGFwcC5ydW5fYXBwKG51bV92ZnM9MCksICZx
dW90O2Flc25pX21iX2NpcGhlcl90aGVuX2F1dGhfdmRldiZxdW90Oyk8YnI+DQotwqAgwqAgwqAg
wqAgc2VsZi5fcHJpbnRfc3RhdHMocmVzdWx0cyk8YnI+DQotwqAgwqAgwqAgwqAgZm9yIHJlc3Vs
dCBpbiByZXN1bHRzOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCB2ZXJpZnkoPGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIHJlc3VsdFsmcXVvdDtwYXNzZWQmcXVvdDtdID09ICZxdW90O1BB
U1MmcXVvdDssPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZxdW90O2xhdGVuY3kgd2Fz
IGdyZWF0ZXIgdGhhbiB0aGUgZGVsdGEgdG9sZXJhbmNlIGFib3ZlIGJhc2VsaW5lJnF1b3Q7LDxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCApPGJyPg0KLTxicj4NCi3CoCDCoCBAY3J5cHRvX3Rlc3Q8
YnI+DQotwqAgwqAgZGVmIGFlc25pX21iX3ZkZXYoc2VsZikgLSZndDsgTm9uZTo8YnI+DQotwqAg
wqAgwqAgwqAgJnF1b3Q7JnF1b3Q7JnF1b3Q7YWVzbmlfbWIgdmRldiBsYXRlbmN5IHRlc3QuPGJy
Pg0KPGJyPg0KLcKgIMKgIMKgIMKgIFN0ZXBzOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCAqIENy
ZWF0ZSBhIGNyeXB0b2RldiBpbnN0YW5jZSB3aXRoIHByb3ZpZGVkIGRldmljZSB0eXBlIGFuZCBi
dWZmZXIgc2l6ZXMuPGJyPg0KLcKgIMKgIMKgIMKgIFZlcmlmeTo8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgKiBUaGUgbGF0ZW5jeSBpcyBiZWxvdyBvciB3aXRoaW4gZGVsdGEgb2YgcHJvdmlkZWQg
YmFzZWxpbmUuPGJyPg0KLTxicj4NCi3CoCDCoCDCoCDCoCBSYWlzZXM6PGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIFNraXBwZWRUZXN0RXhjZXB0aW9uOiBXaGVuIGNvbmZpZ3VyYXRpb24gaXMgbm90
IHByb3ZpZGVkLjxicj4NCi3CoCDCoCDCoCDCoCAmcXVvdDsmcXVvdDsmcXVvdDs8YnI+DQotwqAg
wqAgwqAgwqAgaWYgJnF1b3Q7YWVzbmlfbWJfdmRldiZxdW90OyBub3QgaW4gc2VsZi5sYXRlbmN5
X3Rlc3RfcGFyYW1ldGVyczo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgc2tpcCgmcXVvdDt0ZXN0
IG5vdCBjb25maWd1cmVkJnF1b3Q7KTxicj4NCi3CoCDCoCDCoCDCoCBhcHAgPSBDcnlwdG9kZXYo
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIHB0ZXN0PVRlc3RUeXBlLmxhdGVuY3ksPGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIHZkZXZzPVtWaXJ0dWFsRGV2aWNlKCZxdW90O2NyeXB0b19hZXNuaV9t
YjAmcXVvdDspXSw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgZGV2dHlwZT1EZXZpY2VUeXBlLmNy
eXB0b19hZXNuaV9tYiw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgb3B0eXBlPU9wZXJhdGlvblR5
cGUuY2lwaGVyX29ubHksPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIGNpcGhlcl9hbGdvPUNpcGhl
ckFsZ29yaXRobS5hZXNfY2JjLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBjaXBoZXJfb3A9RW5j
cnlwdERlY3J5cHRTd2l0Y2guZW5jcnlwdCw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgY2lwaGVy
X2tleV9zej0xNiw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgY2lwaGVyX2l2X3N6PTE2LDxicj4N
Ci3CoCDCoCDCoCDCoCDCoCDCoCBidXJzdF9zej0zMiw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
dG90YWxfb3BzPVRPVEFMX09QUyw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgYnVmZmVyX3N6PXNl
bGYuYnVmZmVyX3NpemVzWyZxdW90O2Flc25pX21iX3ZkZXYmcXVvdDtdLDxicj4NCi3CoCDCoCDC
oCDCoCApPGJyPg0KLcKgIMKgIMKgIMKgIHJlc3VsdHMgPSBzZWxmLl92ZXJpZnlfbGF0ZW5jeShh
cHAucnVuX2FwcChudW1fdmZzPTApLCAmcXVvdDthZXNuaV9tYl92ZGV2JnF1b3Q7KTxicj4NCi3C
oCDCoCDCoCDCoCBzZWxmLl9wcmludF9zdGF0cyhyZXN1bHRzKTxicj4NCi3CoCDCoCDCoCDCoCBm
b3IgcmVzdWx0IGluIHJlc3VsdHM6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIHZlcmlmeSg8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmVzdWx0WyZxdW90O3Bhc3NlZCZxdW90O10gPT0g
JnF1b3Q7UEFTUyZxdW90Oyw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7bGF0
ZW5jeSB3YXMgZ3JlYXRlciB0aGFuIHRoZSBkZWx0YSB0b2xlcmFuY2UgYWJvdmUgYmFzZWxpbmUm
cXVvdDssPGJyPg0KK8KgIMKgIMKgIMKgIGRlZiB0ZXN0KCkgLSZndDsgbGlzdFtkaWN0W3N0ciwg
aW50IHwgZmxvYXQgfCBzdHJdXTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7JnF1b3Q7
JnF1b3Q7RXhlY3V0ZSB0aGUgZHBkay10ZXN0LWNyeXB0byBhcHBsaWNhdGlvbiBhbmQgdmVyaWZ5
Ljxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgQXJnczo8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgZW5jcnlwdDogVGhlIGF1dGhlbnRpY2F0aW9uIG9wZXJhdGlvbiBtb2RlIHRv
IHJ1biB0aGUgY3J5cHRvZGV2IGFwcGxpY2F0aW9uIGluLjxicj4NCis8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgUmV0dXJuczo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgVGhlIGdlbmVy
YXRlZCBzdW1tYXJ5IG9yIGFuIGVtcHR5IGxpc3QgaWYgYSB0ZXN0IGlzIHNraXBwZWQuPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgICZxdW90OyZxdW90OyZxdW90Ozxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCBpc192ZGV2OiBib29sID0gJnF1b3Q7dmlydHVhbF9kZXZpY2UmcXVvdDsgaW4gY29tYmlu
YXRpb248YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgYWVhZF9wYXJhbXMgPSBBRUFEX0FMR09SSVRI
TV9QQVJBTVNbQWVhZEFsZ05hbWVbY29tYmluYXRpb25bJnF1b3Q7YWVhZF9hbGdvcml0aG0mcXVv
dDtdXV08YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgYXBwID0gQ3J5cHRvZGV2KDxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBwdGVzdD1UZXN0VHlwZS5sYXRlbmN5LDxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBkZXZ0eXBlPXNlbGYuZGV2aWNlX3R5cGUsPGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIG9wdHlwZT1PcGVyYXRpb25UeXBlLmFlYWQsPGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIGFlYWRfYWxnbz1BZWFkQWxnTmFtZVtjb21iaW5hdGlvblsmcXVvdDth
ZWFkX2FsZ29yaXRobSZxdW90O11dLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBhZWFk
X29wPWNvbWJpbmF0aW9uLmdldCgmcXVvdDthZWFkX29wJnF1b3Q7LCBFbmNyeXB0RGVjcnlwdFN3
aXRjaC5lbmNyeXB0KSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYWVhZF9rZXlfc3o9
Y29tYmluYXRpb24uZ2V0KCZxdW90O2FlYWRfa2V5X3NpemUmcXVvdDssIGFlYWRfcGFyYW1zWyZx
dW90O2tleV9zaXplJnF1b3Q7XSksPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGFlYWRf
aXZfc3o9Y29tYmluYXRpb24uZ2V0KCZxdW90O2FlYWRfaXZfc2l6ZSZxdW90OywgYWVhZF9wYXJh
bXNbJnF1b3Q7aXZfc2l6ZSZxdW90O10pLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBh
ZWFkX2FhZF9zej1jb21iaW5hdGlvbi5nZXQoJnF1b3Q7YWVhZF9zaXplJnF1b3Q7LCBhZWFkX3Bh
cmFtc1smcXVvdDthYWRfc2l6ZSZxdW90O10pLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBkaWdlc3Rfc3o9Y29tYmluYXRpb24uZ2V0KCZxdW90O2RpZ2VzdF9zaXplJnF1b3Q7LCBhZWFk
X3BhcmFtc1smcXVvdDtkaWdlc3Rfc2l6ZSZxdW90O10pLDxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCB0b3RhbF9vcHM9Y29tYmluYXRpb24uZ2V0KCZxdW90O29wcyZxdW90Oywgc2VsZi5v
cHMpLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBidWZmZXJfc3o9c2VsZi5idWZmZXJf
c2l6ZXNbY29tYmluYXRpb25bJnF1b3Q7bmFtZSZxdW90O11dLDxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBpZiBpc192ZGV2Ojxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBhcHAudXBkYXRlX3BhcmFtcyg8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgdmRldnM9W1ZpcnR1YWxEZXZpY2UoY29tYmluYXRpb25bJnF1b3Q7dmly
dHVhbF9kZXZpY2UmcXVvdDtdKV0sPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IGRldnR5cGU9Z2V0X2RldmljZV9mcm9tX3N0cihjb21iaW5hdGlvblsmcXVvdDt2aXJ0dWFsX2Rl
dmljZSZxdW90O10pLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCApPGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIGlmIGNvbWJpbmF0aW9uLmdldCgmcXVvdDthZWFkX29wJnF1b3Q7LCBOb25l
KSA9PSBFbmNyeXB0RGVjcnlwdFN3aXRjaC5kZWNyeXB0Ojxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBhcHAudXBkYXRlX3BhcmFtcyg8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgb3V0X29mX3BsYWNlPWNvbWJpbmF0aW9uLmdldCgmcXVvdDtvdXRfb2ZfcGxhY2UmcXVv
dDssIFRydWUpLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCApPGJyPg0KPGJyPg0KLcKg
IMKgIEBjcnlwdG9fdGVzdDxicj4NCi3CoCDCoCBkZWYga2FzdW1pX3ZkZXYoc2VsZikgLSZndDsg
Tm9uZTo8YnI+DQotwqAgwqAgwqAgwqAgJnF1b3Q7JnF1b3Q7JnF1b3Q7S2FzdW1pIHZkZXYgbGF0
ZW5jeSB0ZXN0Ljxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAgU3RlcHM6PGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgICogQ3JlYXRlIGEgY3J5cHRvZGV2IGluc3RhbmNlIHdpdGggcHJvdmlkZWQgZGV2
aWNlIHR5cGUgYW5kIGJ1ZmZlciBzaXplcy48YnI+DQotwqAgwqAgwqAgwqAgVmVyaWZ5Ojxicj4N
Ci3CoCDCoCDCoCDCoCDCoCDCoCAqIFRoZSBsYXRlbmN5IGlzIGJlbG93IG9yIHdpdGhpbiBkZWx0
YSBvZiBwcm92aWRlZCBiYXNlbGluZS48YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgIFJhaXNlczo8
YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgU2tpcHBlZFRlc3RFeGNlcHRpb246IFdoZW4gY29uZmln
dXJhdGlvbiBpcyBub3QgcHJvdmlkZWQuPGJyPg0KLcKgIMKgIMKgIMKgICZxdW90OyZxdW90OyZx
dW90Ozxicj4NCi3CoCDCoCDCoCDCoCBpZiAmcXVvdDtrYXN1bWlfdmRldiZxdW90OyBub3QgaW4g
c2VsZi5sYXRlbmN5X3Rlc3RfcGFyYW1ldGVyczo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgc2tp
cCgmcXVvdDt0ZXN0IG5vdCBjb25maWd1cmVkJnF1b3Q7KTxicj4NCi3CoCDCoCDCoCDCoCBhcHAg
PSBDcnlwdG9kZXYoPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIHB0ZXN0PVRlc3RUeXBlLmxhdGVu
Y3ksPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIHZkZXZzPVtWaXJ0dWFsRGV2aWNlKCZxdW90O2Ny
eXB0b19rYXN1bWkwJnF1b3Q7KV0sPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIGRldnR5cGU9RGV2
aWNlVHlwZS5jcnlwdG9fa2FzdW1pLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBvcHR5cGU9T3Bl
cmF0aW9uVHlwZS5jaXBoZXJfdGhlbl9hdXRoLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBjaXBo
ZXJfYWxnbz1DaXBoZXJBbGdvcml0aG0ua2FzdW1pX2Y4LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCBjaXBoZXJfb3A9RW5jcnlwdERlY3J5cHRTd2l0Y2guZW5jcnlwdCw8YnI+DQotwqAgwqAgwqAg
wqAgwqAgwqAgY2lwaGVyX2tleV9zej0xNiw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgY2lwaGVy
X2l2X3N6PTgsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIGF1dGhfYWxnbz1BdXRoZW50aWNhdGlv
bkFsZ29yaXRobS5rYXN1bWlfZjksPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIGF1dGhfb3A9QXV0
aGVudGljYXRpb25PcE1vZGUuZ2VuZXJhdGUsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIGF1dGhf
a2V5X3N6PTE2LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBkaWdlc3Rfc3o9NCw8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgYnVyc3Rfc3o9MzIsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIHRvdGFs
X29wcz1UT1RBTF9PUFMsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIGJ1ZmZlcl9zej1zZWxmLmJ1
ZmZlcl9zaXplc1smcXVvdDtrYXN1bWlfdmRldiZxdW90O10sPGJyPg0KLcKgIMKgIMKgIMKgICk8
YnI+DQotwqAgwqAgwqAgwqAgcmVzdWx0cyA9IHNlbGYuX3ZlcmlmeV9sYXRlbmN5KGFwcC5ydW5f
YXBwKG51bV92ZnM9MCksICZxdW90O2thc3VtaV92ZGV2JnF1b3Q7KTxicj4NCi3CoCDCoCDCoCDC
oCBzZWxmLl9wcmludF9zdGF0cyhyZXN1bHRzKTxicj4NCi3CoCDCoCDCoCDCoCBmb3IgcmVzdWx0
IGluIHJlc3VsdHM6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIHZlcmlmeSg8YnI+DQotwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgcmVzdWx0WyZxdW90O3Bhc3NlZCZxdW90O10gPT0gJnF1b3Q7UEFT
UyZxdW90Oyw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7bGF0ZW5jeSB3YXMg
Z3JlYXRlciB0aGFuIHRoZSBkZWx0YSB0b2xlcmFuY2UgYWJvdmUgYmFzZWxpbmUmcXVvdDssPGJy
Pg0KLcKgIMKgIMKgIMKgIMKgIMKgICk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgc2VsZi5fPGEg
aHJlZj0iaHR0cDovL2xvZ2dlci5pbmZvIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5r
Ij5sb2dnZXIuaW5mbzwvYT4oZiZxdW90O1J1bm5pbmcgY29uZmlndXJlZCB0ZXN0OiB7dGVzdF9u
YW1lfSZxdW90Oyk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgdHJ5Ojxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCByZXR1cm4gc2VsZi5fY3JlYXRlX3N1bW1hcnkoPGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJlc3VsdHM9YXBwLnJ1bl9hcHAobnVtX3Zmcz0wIGlmIGlz
X3ZkZXYgZWxzZSAxKSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcGFyYW1z
PWNvbWJpbmF0aW9uLmdldCgmcXVvdDt0ZXN0X3BhcmFtZXRlcnMmcXVvdDssIGNvbmZpZ19saXN0
KSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdGVzdF9uYW1lPWYmcXVvdDt7
Y29tYmluYXRpb24uZ2V0KCYjMzk7bmFtZSYjMzk7LCAmIzM5O3VubmFtZWQtdGVzdCYjMzk7KX0m
cXVvdDssPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICk8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgIyBFeGNlcHRpb25zIHdpbGwgc3RvcCB0aGUgZXhlY3V0aW9uIG9mIGFsbCB0ZXN0cywg
cmV0dXJuIGFuIGVtcHR5IHJlc3VsdCBhbmQgY29udGludWUuPGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIGV4Y2VwdCBTa2lwcGVkVGVzdEV4Y2VwdGlvbiBhcyBlOjxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBzZWxmLl9sb2dnZXIuZXJyb3IoZiZxdW90O2ZhaWxlZCB0byBydW4gdGVzdCB7
dGVzdF9uYW1lfToge3N0cihlKX0mcXVvdDspPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IHJldHVybiBbXTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgdGVzdF9jYXNlc19za2lwcGVkOiBp
bnQgPSAwPGJyPg0KK8KgIMKgIMKgIMKgIGZhaWxlZDogYm9vbCA9IEZhbHNlPGJyPg0KK8KgIMKg
IMKgIMKgIHJlYXNvbjogc3RyID0gJnF1b3Q7JnF1b3Q7PGJyPg0KK8KgIMKgIMKgIMKgICMgRXhl
Y3V0ZSBhbGwgYWVhZCB0ZXN0cyBhbmQgdmVyaWZ5PGJyPg0KK8KgIMKgIMKgIMKgIGZvciBjb21i
aW5hdGlvbiBpbiBzZWxmLmFlYWRfdGVzdHM6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHRlc3Rf
bmFtZSA9IGNvbWJpbmF0aW9uLmdldCgmcXVvdDtuYW1lJnF1b3Q7LCAmcXVvdDt1bm5hbWVkX3Rl
c3QmcXVvdDspPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIGNvbWJpbmF0aW9uX3Jlc3VsdHMgPSBb
dGVzdCgpXTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBpZiBhbGwocmVzdWx0ID09IFtdIGZvciBy
ZXN1bHQgaW4gY29tYmluYXRpb25fcmVzdWx0cyk6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIHRlc3RfY2FzZXNfc2tpcHBlZCArPSAxPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIGVsc2U6
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHRyeTo8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgc2VsZi5fcHJpbnRfYW5kX3ZlcmlmeShjb21iaW5hdGlvbl9yZXN1bHRz
KTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBleGNlcHQgVGVzdENhc2VWZXJpZnlFcnJv
ciBhcyBlOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmYWlsZWQgPSBUcnVl
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJlYXNvbiA9IGYmcXVvdDt7cmVh
c29ufVxue3N0cihlKX0mcXVvdDsgaWYgcmVhc29uIGVsc2Ugc3RyKGUpPGJyPg0KK8KgIMKgIMKg
IMKgIGlmIGZhaWxlZDo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgZmFpbChyZWFzb24pPGJyPg0K
K8KgIMKgIMKgIMKgIGlmIHRlc3RfY2FzZXNfc2tpcHBlZCA9PSBsZW4oc2VsZi5hZWFkX3Rlc3Rz
KTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgc2tpcCgmcXVvdDtBbGwgY29uZmlndXJlZCB0ZXN0
IGNhc2VzIHNraXBwZWQuJnF1b3Q7KTxicj4NCjxicj4NCsKgIMKgIMKgQGNyeXB0b190ZXN0PGJy
Pg0KLcKgIMKgIGRlZiBvcGVuX3NzbF92ZGV2KHNlbGYpIC0mZ3Q7IE5vbmU6PGJyPg0KLcKgIMKg
IMKgIMKgICZxdW90OyZxdW90OyZxdW90O29wZW5fc3NsIHZkZXYgbGF0ZW5jeSB0ZXN0Ljxicj4N
CivCoCDCoCBkZWYgY2lwaGVyX2FuZF9hdXRoX3Rlc3RzKHNlbGYpIC0mZ3Q7IE5vbmU6PGJyPg0K
K8KgIMKgIMKgIMKgICZxdW90OyZxdW90OyZxdW90O0NpcGhlciBhbmQgQXV0aGVudGljYXRpb24g
dGVzdHMuPGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgwqBTdGVwczo8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgKiBDcmVhdGUgYSBjcnlwdG9kZXYgaW5zdGFuY2Ugd2l0aCBwcm92aWRlZCBkZXZpY2Ug
dHlwZSBhbmQgYnVmZmVyIHNpemVzLjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCAqIFJ1biBkcGRr
LXRlc3QtY3J5cHRvLXBlcmYgYXBwbGljYXRpb24gaW4gY2lwaGVyIHRoZW4gYXV0aGVudGljYXRp
b24gbW9kZTxicj4NCsKgIMKgIMKgIMKgIMKgVmVyaWZ5Ojxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCAqIFRoZSBsYXRlbmN5IGlzIGJlbG93IG9yIHdpdGhpbiBkZWx0YSBvZiBwcm92aWRlZCBiYXNl
bGluZS48YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgIFJhaXNlczo8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgU2tpcHBlZFRlc3RFeGNlcHRpb246IFdoZW4gY29uZmlndXJhdGlvbiBpcyBub3QgcHJv
dmlkZWQuPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgICogVGhlIHJlc3VsdGluZyBzdGF0aXN0aWNz
IGFyZSB3aXRoaW4gYSBkZWx0YSB0b2xlcmFuY2Ugb2YgYSBnaXZlbiBiYXNlbGluZS48YnI+DQrC
oCDCoCDCoCDCoCDCoCZxdW90OyZxdW90OyZxdW90Ozxicj4NCi3CoCDCoCDCoCDCoCBpZiAmcXVv
dDtvcGVuX3NzbF92ZGV2JnF1b3Q7IG5vdCBpbiBzZWxmLmxhdGVuY3lfdGVzdF9wYXJhbWV0ZXJz
Ojxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBza2lwKCZxdW90O3Rlc3Qgbm90IGNvbmZpZ3VyZWQm
cXVvdDspPGJyPg0KLcKgIMKgIMKgIMKgIGFwcCA9IENyeXB0b2Rldig8YnI+DQotwqAgwqAgwqAg
wqAgwqAgwqAgcHRlc3Q9VGVzdFR5cGUubGF0ZW5jeSw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
dmRldnM9W1ZpcnR1YWxEZXZpY2UoJnF1b3Q7Y3J5cHRvX29wZW5zc2wwJnF1b3Q7KV0sPGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIGRldnR5cGU9RGV2aWNlVHlwZS5jcnlwdG9fb3BlbnNzbCw8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgb3B0eXBlPU9wZXJhdGlvblR5cGUuYWVhZCw8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgYWVhZF9hbGdvPUFlYWRBbGdOYW1lLmFlc19nY20sPGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgIGFlYWRfb3A9RW5jcnlwdERlY3J5cHRTd2l0Y2guZW5jcnlwdCw8YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAgYWVhZF9rZXlfc3o9MTYsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKg
IGFlYWRfaXZfc3o9MTYsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIGFlYWRfYWFkX3N6PTE2LDxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBkaWdlc3Rfc3o9MTYsPGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIHRvdGFsX29wcz1UT1RBTF9PUFMsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIGJ1ZmZlcl9z
ej1zZWxmLmJ1ZmZlcl9zaXplc1smcXVvdDtvcGVuX3NzbF92ZGV2JnF1b3Q7XSw8YnI+DQotwqAg
wqAgwqAgwqAgKTxicj4NCi3CoCDCoCDCoCDCoCByZXN1bHRzID0gc2VsZi5fdmVyaWZ5X2xhdGVu
Y3koYXBwLnJ1bl9hcHAobnVtX3Zmcz0wKSwgJnF1b3Q7b3Blbl9zc2xfdmRldiZxdW90Oyk8YnI+
DQotwqAgwqAgwqAgwqAgc2VsZi5fcHJpbnRfc3RhdHMocmVzdWx0cyk8YnI+DQotwqAgwqAgwqAg
wqAgZm9yIHJlc3VsdCBpbiByZXN1bHRzOjxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCB2ZXJpZnko
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJlc3VsdFsmcXVvdDtwYXNzZWQmcXVvdDtd
ID09ICZxdW90O1BBU1MmcXVvdDssPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZxdW90
O2xhdGVuY3kgd2FzIGdyZWF0ZXIgdGhhbiB0aGUgZGVsdGEgdG9sZXJhbmNlIGFib3ZlIGJhc2Vs
aW5lJnF1b3Q7LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCApPGJyPg0KPGJyPg0KLcKgIMKgIEBj
cnlwdG9fdGVzdDxicj4NCi3CoCDCoCBkZWYgc25vdzNnX3ZkZXYoc2VsZikgLSZndDsgTm9uZTo8
YnI+DQotwqAgwqAgwqAgwqAgJnF1b3Q7JnF1b3Q7JnF1b3Q7c25vdzNnIHZkZXYgbGF0ZW5jeSB0
ZXN0Ljxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAgU3RlcHM6PGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgICogQ3JlYXRlIGEgY3J5cHRvZGV2IGluc3RhbmNlIHdpdGggcHJvdmlkZWQgZGV2aWNlIHR5
cGUgYW5kIGJ1ZmZlciBzaXplcy48YnI+DQotwqAgwqAgwqAgwqAgVmVyaWZ5Ojxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCAqIFRoZSBsYXRlbmN5IGlzIGJlbG93IG9yIHdpdGhpbiBkZWx0YSBvZiBw
cm92aWRlZCBiYXNlbGluZS48YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgIFJhaXNlczo8YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAgU2tpcHBlZFRlc3RFeGNlcHRpb246IFdoZW4gY29uZmlndXJhdGlv
biBpcyBub3QgcHJvdmlkZWQuPGJyPg0KLcKgIMKgIMKgIMKgICZxdW90OyZxdW90OyZxdW90Ozxi
cj4NCi3CoCDCoCDCoCDCoCBpZiAmcXVvdDtzbm93M2dfdmRldiZxdW90OyBub3QgaW4gc2VsZi5s
YXRlbmN5X3Rlc3RfcGFyYW1ldGVyczo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgc2tpcCgmcXVv
dDt0ZXN0IG5vdCBjb25maWd1cmVkJnF1b3Q7KTxicj4NCi3CoCDCoCDCoCDCoCBhcHAgPSBDcnlw
dG9kZXYoPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIHB0ZXN0PVRlc3RUeXBlLmxhdGVuY3ksPGJy
Pg0KLcKgIMKgIMKgIMKgIMKgIMKgIHZkZXZzPVtWaXJ0dWFsRGV2aWNlKCZxdW90O2NyeXB0b19z
bm93M2cwJnF1b3Q7KV0sPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIGRldnR5cGU9RGV2aWNlVHlw
ZS5jcnlwdG9fc25vdzNnLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBvcHR5cGU9T3BlcmF0aW9u
VHlwZS5jaXBoZXJfdGhlbl9hdXRoLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBjaXBoZXJfYWxn
bz1DaXBoZXJBbGdvcml0aG0uc25vdzNnX3VlYTIsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIGNp
cGhlcl9vcD1FbmNyeXB0RGVjcnlwdFN3aXRjaC5lbmNyeXB0LDxicj4NCi3CoCDCoCDCoCDCoCDC
oCDCoCBjaXBoZXJfa2V5X3N6PTE2LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBjaXBoZXJfaXZf
c3o9MTYsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIGF1dGhfYWxnbz1BdXRoZW50aWNhdGlvbkFs
Z29yaXRobS5zbm93M2dfdWlhMiw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgYXV0aF9vcD1BdXRo
ZW50aWNhdGlvbk9wTW9kZS5nZW5lcmF0ZSw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgYXV0aF9r
ZXlfc3o9MTYsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIGF1dGhfaXZfc3o9MTYsPGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIGRpZ2VzdF9zej0xNiw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgYnVy
c3Rfc3o9MzIsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIHRvdGFsX29wcz1UT1RBTF9PUFMsPGJy
Pg0KLcKgIMKgIMKgIMKgIMKgIMKgIGJ1ZmZlcl9zej1zZWxmLmJ1ZmZlcl9zaXplc1smcXVvdDtz
bm93M2dfdmRldiZxdW90O10sPGJyPg0KLcKgIMKgIMKgIMKgICk8YnI+DQotwqAgwqAgwqAgwqAg
cmVzdWx0cyA9IHNlbGYuX3ZlcmlmeV9sYXRlbmN5KGFwcC5ydW5fYXBwKG51bV92ZnM9MCksICZx
dW90O3Nub3czZ192ZGV2JnF1b3Q7KTxicj4NCi3CoCDCoCDCoCDCoCBzZWxmLl9wcmludF9zdGF0
cyhyZXN1bHRzKTxicj4NCi3CoCDCoCDCoCDCoCBmb3IgcmVzdWx0IGluIHJlc3VsdHM6PGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIHZlcmlmeSg8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
cmVzdWx0WyZxdW90O3Bhc3NlZCZxdW90O10gPT0gJnF1b3Q7UEFTUyZxdW90Oyw8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7bGF0ZW5jeSB3YXMgZ3JlYXRlciB0aGFuIHRoZSBk
ZWx0YSB0b2xlcmFuY2UgYWJvdmUgYmFzZWxpbmUmcXVvdDssPGJyPg0KK8KgIMKgIMKgIMKgIGRl
ZiB0ZXN0KDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBlbmNyeXB0OiBFbmNyeXB0RGVjcnlwdFN3
aXRjaCwgb3BfbW9kZTogQXV0aGVudGljYXRpb25PcE1vZGU8YnI+DQorwqAgwqAgwqAgwqAgKSAt
Jmd0OyBsaXN0W2RpY3Rbc3RyLCBpbnQgfCBmbG9hdCB8IHN0cl1dOjxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCAmcXVvdDsmcXVvdDsmcXVvdDtFeGVjdXRlIHRoZSBkcGRrLXRlc3QtY3J5cHRvIGFw
cGxpY2F0aW9uIGFuZCB2ZXJpZnkuPGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBBcmdz
Ojxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBlbmNyeXB0OiBUaGUgY2lwaGVyIGVuY3J5
cHRpb24gbW9kZSB0byBydW4gbGF0ZW5jeSB0ZXN0aW5nIGluLjxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBvcF9tb2RlOiBUaGUgYXV0aGVudGljYXRpb24gb3BlcmF0aW9uIG1vZGUgdG8g
cnVuIHRoZSBjcnlwdG9kZXYgYXBwbGljYXRpb24gaW4uPGJyPg0KKzxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCBSZXR1cm5zOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBUaGUgZ2VuZXJh
dGVkIHN1bW1hcnkgb3IgYW4gZW1wdHkgbGlzdCBpZiBhIHRlc3QgaXMgc2tpcHBlZC48YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7JnF1b3Q7JnF1b3Q7PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIGlzX3ZkZXY6IGJvb2wgPSAmcXVvdDt2aXJ0dWFsX2RldmljZSZxdW90OyBpbiBjb21iaW5h
dGlvbjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBjaXBoZXJfcGFyYW1zID0gQ0lQSEVSX0FMR09S
SVRITV9QQVJBTVNbPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIENpcGhlckFsZ29yaXRo
bVtjb21iaW5hdGlvblsmcXVvdDtjaXBoZXJfYWxnb3JpdGhtJnF1b3Q7XV08YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgXTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBhdXRoX3BhcmFtcyA9IEFVVEhF
TlRJQ0FUSU9OX0FMR09SSVRITV9QQVJBTVNbPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IEF1dGhlbnRpY2F0aW9uQWxnb3JpdGhtW2NvbWJpbmF0aW9uWyZxdW90O2F1dGhfYWxnb3JpdGht
JnF1b3Q7XV08YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgXTxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCBhcHAgPSBDcnlwdG9kZXYoPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHB0ZXN0PVRl
c3RUeXBlLmxhdGVuY3ksPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGRldnR5cGU9c2Vs
Zi5kZXZpY2VfdHlwZSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgb3B0eXBlPU9wZXJh
dGlvblR5cGUuYWVhZCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY2lwaGVyX2FsZ289
Q2lwaGVyQWxnb3JpdGhtW2NvbWJpbmF0aW9uWyZxdW90O2NpcGhlcl9hbGdvcml0aG0mcXVvdDtd
XSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY2lwaGVyX29wPWVuY3J5cHQsPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNpcGhlcl9rZXlfc3o9Y29tYmluYXRpb24uZ2V0KCZx
dW90O2NpcGhlcl9rZXlfc2l6ZSZxdW90OywgY2lwaGVyX3BhcmFtc1smcXVvdDtrZXlfc2l6ZSZx
dW90O10pLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjaXBoZXJfaXZfc3o9Y29tYmlu
YXRpb24uZ2V0KCZxdW90O2NpcGhlcl9pdl9zaXplJnF1b3Q7LCBjaXBoZXJfcGFyYW1zWyZxdW90
O2l2X3NpemUmcXVvdDtdKSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYXV0aF9hbGdv
PUF1dGhlbnRpY2F0aW9uQWxnb3JpdGhtW2NvbWJpbmF0aW9uWyZxdW90O2F1dGhfYWxnb3JpdGht
JnF1b3Q7XV0sPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGF1dGhfb3A9b3BfbW9kZSw8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYXV0aF9rZXlfc3o9Y29tYmluYXRpb24uZ2V0
KCZxdW90O2F1dGhfa2V5X3NpemUmcXVvdDssIGF1dGhfcGFyYW1zWyZxdW90O2tleV9zaXplJnF1
b3Q7XSksPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGF1dGhfaXZfc3o9Y29tYmluYXRp
b24uZ2V0KCZxdW90O2F1dGhfaXZfc2l6ZSZxdW90OywgYXV0aF9wYXJhbXNbJnF1b3Q7aXZfc2l6
ZSZxdW90O10pLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB0b3RhbF9vcHM9Y29tYmlu
YXRpb24uZ2V0KCZxdW90O29wcyZxdW90Oywgc2VsZi5vcHMpLDxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBkaWdlc3Rfc3o9Y29tYmluYXRpb24uZ2V0KCZxdW90O2RpZ2VzdF9zaXplJnF1
b3Q7LCAwKSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYnVmZmVyX3N6PXNlbGYuYnVm
ZmVyX3NpemVzW2NvbWJpbmF0aW9uWyZxdW90O25hbWUmcXVvdDtdXSw8YnI+DQrCoCDCoCDCoCDC
oCDCoCDCoCDCoCk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgaWYgaXNfdmRldjo8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgYXBwLnVwZGF0ZV9wYXJhbXMoPGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIHZkZXZzPVtWaXJ0dWFsRGV2aWNlKGNvbWJpbmF0aW9uWyZxdW90
O3ZpcnR1YWxfZGV2aWNlJnF1b3Q7XSldLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBkZXZ0eXBlPWdldF9kZXZpY2VfZnJvbV9zdHIoY29tYmluYXRpb25bJnF1b3Q7dmlydHVh
bF9kZXZpY2UmcXVvdDtdKSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKTxicj4NCjxi
cj4NCi3CoCDCoCBAY3J5cHRvX3Rlc3Q8YnI+DQotwqAgwqAgZGVmIHp1Y192ZGV2KHNlbGYpIC0m
Z3Q7IE5vbmU6PGJyPg0KLcKgIMKgIMKgIMKgICZxdW90OyZxdW90OyZxdW90O1p1YyB2ZGV2IGxh
dGVuY3kgdGVzdC48YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgIFN0ZXBzOjxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCAqIENyZWF0ZSBhIGNyeXB0b2RldiBpbnN0YW5jZSB3aXRoIHByb3ZpZGVkIGRl
dmljZSB0eXBlIGFuZCBidWZmZXIgc2l6ZXMuPGJyPg0KLcKgIMKgIMKgIMKgIFZlcmlmeTo8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgKiBUaGUgbGF0ZW5jeSBpcyBiZWxvdyBvciB3aXRoaW4gZGVs
dGEgb2YgcHJvdmlkZWQgYmFzZWxpbmUuPGJyPg0KLTxicj4NCi3CoCDCoCDCoCDCoCBSYWlzZXM6
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIFNraXBwZWRUZXN0RXhjZXB0aW9uOiBXaGVuIGNvbmZp
Z3VyYXRpb24gaXMgbm90IHByb3ZpZGVkLjxicj4NCi3CoCDCoCDCoCDCoCAmcXVvdDsmcXVvdDsm
cXVvdDs8YnI+DQotwqAgwqAgwqAgwqAgaWYgJnF1b3Q7enVjX3ZkZXYmcXVvdDsgbm90IGluIHNl
bGYubGF0ZW5jeV90ZXN0X3BhcmFtZXRlcnM6PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIHNraXAo
JnF1b3Q7dGVzdCBub3QgY29uZmlndXJlZCZxdW90Oyk8YnI+DQotwqAgwqAgwqAgwqAgYXBwID0g
Q3J5cHRvZGV2KDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBwdGVzdD1UZXN0VHlwZS5sYXRlbmN5
LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCB2ZGV2cz1bVmlydHVhbERldmljZSgmcXVvdDtjcnlw
dG9fenVjMCZxdW90OyldLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBkZXZ0eXBlPURldmljZVR5
cGUuY3J5cHRvX3p1Yyw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgb3B0eXBlPU9wZXJhdGlvblR5
cGUuY2lwaGVyX3RoZW5fYXV0aCw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgY2lwaGVyX2FsZ289
Q2lwaGVyQWxnb3JpdGhtLnp1Y19lZWEzLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBjaXBoZXJf
b3A9RW5jcnlwdERlY3J5cHRTd2l0Y2guZW5jcnlwdCw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
Y2lwaGVyX2tleV9zej0xNiw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgY2lwaGVyX2l2X3N6PTE2
LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBhdXRoX2FsZ289QXV0aGVudGljYXRpb25BbGdvcml0
aG0uenVjX2VpYTMsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIGF1dGhfb3A9QXV0aGVudGljYXRp
b25PcE1vZGUuZ2VuZXJhdGUsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIGF1dGhfa2V5X3N6PTE2
LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBhdXRoX2l2X3N6PTE2LDxicj4NCi3CoCDCoCDCoCDC
oCDCoCDCoCBkaWdlc3Rfc3o9NCw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgYnVyc3Rfc3o9MzIs
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIHRvdGFsX29wcz1UT1RBTF9PUFMsPGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgIGJ1ZmZlcl9zej1zZWxmLmJ1ZmZlcl9zaXplc1smcXVvdDt6dWNfdmRldiZx
dW90O10sPGJyPg0KLcKgIMKgIMKgIMKgICk8YnI+DQotwqAgwqAgwqAgwqAgcmVzdWx0cyA9IHNl
bGYuX3ZlcmlmeV9sYXRlbmN5KGFwcC5ydW5fYXBwKG51bV92ZnM9MCksICZxdW90O3p1Y192ZGV2
JnF1b3Q7KTxicj4NCi3CoCDCoCDCoCDCoCBzZWxmLl9wcmludF9zdGF0cyhyZXN1bHRzKTxicj4N
Ci3CoCDCoCDCoCDCoCBmb3IgcmVzdWx0IGluIHJlc3VsdHM6PGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIHZlcmlmeSg8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmVzdWx0WyZxdW90O3Bh
c3NlZCZxdW90O10gPT0gJnF1b3Q7UEFTUyZxdW90Oyw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgJnF1b3Q7bGF0ZW5jeSB3YXMgZ3JlYXRlciB0aGFuIHRoZSBkZWx0YSB0b2xlcmFuY2Ug
YWJvdmUgYmFzZWxpbmUmcXVvdDssPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgICk8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgc2VsZi5fPGEgaHJlZj0iaHR0cDovL2xvZ2dlci5pbmZvIiByZWw9Im5v
cmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5sb2dnZXIuaW5mbzwvYT4oZiZxdW90O1J1bm5pbmcg
Y29uZmlndXJlZCB0ZXN0OiB7dGVzdF9uYW1lfSBpbiB7ZW5jcnlwdH0gbW9kZSZxdW90Oyk8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgdHJ5Ojxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBy
ZXR1cm4gc2VsZi5fY3JlYXRlX3N1bW1hcnkoPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIHJlc3VsdHM9YXBwLnJ1bl9hcHAobnVtX3Zmcz0wIGlmIGlzX3ZkZXYgZWxzZSAxKSw8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcGFyYW1zPWNvbWJpbmF0aW9uLmdl
dCgmcXVvdDt0ZXN0X3BhcmFtZXRlcnMmcXVvdDssIGNvbmZpZ19saXN0KSw8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdGVzdF9uYW1lPWYmcXVvdDt7Y29tYmluYXRpb24uZ2V0
KCYjMzk7bmFtZSYjMzk7LCAmIzM5O3VubmFtZWQtdGVzdCYjMzk7KX0gLSB7ZW5jcnlwdH0mcXVv
dDssPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICk8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgIyBFeGNlcHRpb25zIHdpbGwgc3RvcCB0aGUgZXhlY3V0aW9uIG9mIGFsbCB0ZXN0cywgcmV0
dXJuIGFuIGVtcHR5IHJlc3VsdCBhbmQgY29udGludWUuPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IGV4Y2VwdCBTa2lwcGVkVGVzdEV4Y2VwdGlvbiBhcyBlOjxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBzZWxmLl9sb2dnZXIuZXJyb3IoZiZxdW90O2ZhaWxlZCB0byBydW4gdGVzdCB7dGVz
dF9uYW1lfToge3N0cihlKX0mcXVvdDspPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJl
dHVybiBbXTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgdGVzdF9jYXNlc19za2lwcGVkOiBpbnQg
PSAwPGJyPg0KK8KgIMKgIMKgIMKgIGZhaWxlZDogYm9vbCA9IEZhbHNlPGJyPg0KK8KgIMKgIMKg
IMKgIHJlYXNvbjogc3RyID0gJnF1b3Q7JnF1b3Q7PGJyPg0KK8KgIMKgIMKgIMKgICMgRXhlY3V0
ZSBhbGwgY2lwaGVyX3RoZW5fYXV0aCB0ZXN0cyBhbmQgdmVyaWZ5PGJyPg0KK8KgIMKgIMKgIMKg
IGZvciBjb21iaW5hdGlvbiBpbiBzZWxmLmNpcGhlcl90aGVuX2F1dGhfdGVzdHM6PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIHByaW50KHN0cihjb21iaW5hdGlvbikpPGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIHRlc3RfbmFtZSA9IGNvbWJpbmF0aW9uLmdldCgmcXVvdDtuYW1lJnF1b3Q7LCAmcXVv
dDt1bm5hbWVkX3Rlc3QmcXVvdDspPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIGNvbWJpbmF0aW9u
X3Jlc3VsdHMgPSBbPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHRlc3QobW9kZSwgQXV0
aGVudGljYXRpb25PcE1vZGUuZ2VuZXJhdGUpIGZvciBtb2RlIGluIEVuY3J5cHREZWNyeXB0U3dp
dGNoPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIF08YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgaWYg
YWxsKHJlc3VsdCA9PSBbXSBmb3IgcmVzdWx0IGluIGNvbWJpbmF0aW9uX3Jlc3VsdHMpOjxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB0ZXN0X2Nhc2VzX3NraXBwZWQgKz0gMTxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCBlbHNlOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB0cnk6
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHNlbGYuX3ByaW50X2FuZF92ZXJp
ZnkoY29tYmluYXRpb25fcmVzdWx0cyk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZXhj
ZXB0IFRlc3RDYXNlVmVyaWZ5RXJyb3IgYXMgZTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgZmFpbGVkID0gVHJ1ZTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCByZWFzb24gPSBmJnF1b3Q7e3JlYXNvbn1cbntzdHIoZSl9JnF1b3Q7IGlmIHJlYXNvbiBlbHNl
IHN0cihlKTxicj4NCivCoCDCoCDCoCDCoCBpZiBmYWlsZWQ6PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIGZhaWwocmVhc29uKTxicj4NCivCoCDCoCDCoCDCoCBpZiB0ZXN0X2Nhc2VzX3NraXBwZWQg
PT0gbGVuKHNlbGYuY2lwaGVyX3RoZW5fYXV0aF90ZXN0cyk6PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIHNraXAoJnF1b3Q7QWxsIGNvbmZpZ3VyZWQgdGVzdCBjYXNlcyBza2lwcGVkLiZxdW90Oyk8
YnI+DQotLSA8YnI+DQoyLjU1LjA8YnI+DQo8YnI+DQo8L2Jsb2NrcXVvdGU+PC9kaXY+DQo=
--00000000000097d2e5065ed4d70c--
