Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE16E606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=is1AZjcu
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A43140151;
	Tue, 27 Oct 2026 14:41:26 +0100 (CET)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
 [209.85.160.170])
 by mails.dpdk.org (Postfix) with ESMTPS id CE45E400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 14:41:23 +0100 (CET)
Received: by mail-qt1-f170.google.com with SMTP id
 d75a77b69052e-5361e313e63so40119161cf.3
 for <dev@dpdk.org>; Tue, 27 Oct 2026 06:41:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793108482; cv=none;
 d=google.com; s=arc-20260327;
 b=LAPllKvp14tHehx6mvmalWTzCfJCxbQnZqpXfor55iV+9iN2HpFE2UeCXQGUXQ2kVX
 DSgRdzHvIbntNQXQ0nSkwOosBbFLBJAvfzLJ0/MMX4EdojrTLQkVJpqmVBSkRYsnMtje
 szYclrYM5SsHoNiroHtBWaHiHOrXRjgjUdV4JAXq5vB62f4Dh44Me/O7rKBImopFp9+0
 b0AmLFpEz8imaITUlSBobrdQknjHLvHh/pFtQZ7Y00j7J+pinAeodlg3tSjvVXaBxreD
 qWRdiHFe4ac/BdYoNVMkt+DxcHXEehgH89/fbkrPsWHcPpMkgLZYGepF7AOG2M1ESmJv
 C4YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3gMabKidvOwZBTFr6NZf+UmE/k/mlVnbbkhWaJbBUpY=;
 fh=/r4EsEkjUD2JWM5yk5r1S2yVXJmDFp/UUBiDifHc/Z8=;
 b=p4xOGQWaztBIisOJN408xwX+X1bz39VDeMWGwRorPysK5Vip9y4PgkVCNiSKsgC3QV
 tvy1Xks9Jgjw/nFL+PaGu03ZWt2xcaXewtsAtTAZ4EtIaRMvY7TsKQyg6P/SZF4ojG1G
 HialYgjqIF9xfPnGYveYMnadklcqF/fWZq4xOSImvSqKAy3iZwkzCTblUlLXuRJJBbtJ
 H3MKIPqN3eQjCYnC5Z+jwG5mzfG9LY+1wNTTB637SR0k/OYeBc2uuOA7KYKnj5vH8oC5
 x2DkuOVR6AKfG686jdcBR1ObkglVqDp40qnu53ZSD0PXteInJhO8xlHqzssD/2zhK699
 1HGg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1793108482; x=1793713282; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3gMabKidvOwZBTFr6NZf+UmE/k/mlVnbbkhWaJbBUpY=;
 b=is1AZjcuXGRRveYPgsG7FRlrhje4mbkOd6He8MTLlRaas+50dI9hsIKs6AZXviLTos
 YCGqNuCkhEh8ErrFhVMQGQ1q0EuQcCyEi2hpgBLoWNPe6rGIDFsgjTBsxYw/ODRkukDO
 EdhnDu1hh9FMn80+77YgH0xaror+zprkSBQcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793108482; x=1793713282;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3gMabKidvOwZBTFr6NZf+UmE/k/mlVnbbkhWaJbBUpY=;
 b=O5QytOISnUiCtrtFynaZu6HcJqtENjop6LAoD1C5Vv73jNFhxe54OiM0VMApdlDjkP
 DWVWh6Qzst/+iWToh1UjLrRSlQerILSOrXQvjC3mmCcc+iYl87js0cWwAshbgmo4opns
 sXvIkELC0T1fU2YZzUne8Y4RwzwFTkQkoOxbXOlhsuAGdKpkc7CLnGeTlcpyCcfNFKXp
 twX/ZpTcbhqTw2C3hY5RLnp2MmlrYeZ0uZz54X5ZjmqQKhiygagEW9kL8x65SKP40YLb
 EIkicxPFLdTDd7/zmoC9GQcyAQkSBJhZrrVsQ11CJGbGfw+xI+eFmG78Tcb6CKWCkKtE
 E9gg==
X-Gm-Message-State: AFq9FYLrga5O6mco5rK1ZaAEunQZj+AMfTT8rm9Ei3iqmV2q8DNbTPBp
 KER2Eq+aSahzy9KteJcfeEmvMK3XRmbJBgh3Db4ufHnsqxZAYA/cm0cIKeIOopQE3t1IG7BUPVw
 a7QK8TwdDWzQJwHlDJxfn3i7knSITJAkWNzDk/kYBog==
X-Gm-Gg: AYBFou1m0206VHa49pCQ+NkELudgMZwl+XTt8CXHaTq8Pil4F6x0b9H26SpTitjYY6S
 GGayzrDPpPKPiQTBaQ04dWrNmmyOteFQhD8AvZy6xVqdX+Q9c9lAuxuKHzCtlncSe+hJAZv7y4Q
 Z1d74pKPPXLwGXNhhlOB0uvrCr7ASy3MgVw466DsV6szCcslmF7iYkPRWHjowdLxAjH1CP+bpz8
 lMIqxImYmpZox4WZzsahHdI/85Tv7fnVF3oRqy2vwSsZF7GtkAH7G7ihSE2KuWDTGz4D5kjmuK6
 U+NWAzwrYjD2Ek9/9ZW9ieX2ylfuseoApVNVa4AgEhJdiVIfAdCTkmHj9jVY1nVz8ljGqQuWaUA
 bg0zAojlVHoYFuP4LdIkLCxOG+eps9ALHXXsIPQAoA6CpuYl9rSd2QX9VaZh6YIbJAwYGSveVxE
 TNvnyKARFr1HTx7Ze854TkKijnFVScDRAualuUW2OYMHlRqR9SIbtK6/DFRfADLuc4ryTmYMVcx
 Tu0FOa7OnfmQDYb/CH2KN+nDITA
X-Received: by 2002:ac8:5a08:0:b0:537:a19c:6e52 with SMTP id
 d75a77b69052e-5383b59fd24mr166259191cf.56.1793108481182; Tue, 27 Oct 2026
 06:41:21 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260827172208.139769-1-abailey@iol.unh.edu>
 <20261019200424.898640-1-abailey@iol.unh.edu>
In-Reply-To: <20261019200424.898640-1-abailey@iol.unh.edu>
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Date: Tue, 27 Oct 2026 09:40:45 -0400
X-Gm-Features: AclHuK_XqRHAjhXhdLzB8V7CPkasGpFG4JwPTkVndFxBd3m9Pwr035faZpwgMkc
Message-ID: <CAKYPG+wWtzvvNCaDfwQV8tGSb4bQ=A5zfA6=fXNXWx9kbsKYWg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dts: refactor cryptodev throughput test suite
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: dev@dpdk.org, luca.vizzarro@arm.com, patrickrobb1997@gmail.com, 
 dladd@iol.unh.edu, lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="000000000000109e66065ed29a2a"
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

--000000000000109e66065ed29a2a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>

On Mon, Oct 19, 2026 at 4:04=E2=80=AFPM Andrew Bailey <abailey@iol.unh.edu>=
 wrote:

> Previously, the cryptodev throughput test suite only allowed for
> a small set of algorithms to be tested for a set number of operations.
> This is undesirable as a user may want to test one of the hundreds of
> possible combinations rather than the much smaller preset tests
> previously available. This commit adds support for proper test
> configuration of the cryptodev throughput test suite to provide total
> coverage of all algorithms.
>
> Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
> ---
>  dts/api/cryptodev/__init__.py                |  12 +
>  dts/api/cryptodev/config.py                  |  47 +
>  dts/api/params/__init__.py                   |   2 +-
>  dts/configurations/nodes.example.yaml        |   2 +-
>  dts/configurations/tests_config.example.yaml |  48 +-
>  dts/tests/TestSuite_cryptodev_throughput.py  | 930 +++++++++----------
>  6 files changed, 523 insertions(+), 518 deletions(-)
>
> diff --git a/dts/api/cryptodev/__init__.py b/dts/api/cryptodev/__init__.p=
y
> index 496079c2af..ffcfee4ac7 100644
> --- a/dts/api/cryptodev/__init__.py
> +++ b/dts/api/cryptodev/__init__.py
> @@ -78,6 +78,18 @@ def vector_directory(self) -> PurePath:
>          """
>          return
> get_ctx().dpdk_build.remote_dpdk_tree_path.joinpath("app/test-crypto-perf=
/data/")
>
> +    def update_params(self, **app_params: Unpack["CryptoPmdParamsDict"])
> -> None:
> +        """Update the app parameters.
> +
> +        Args:
> +            app_params: app parameters to pass to dpdk-test-crypto-perf
> application
> +        """
> +        for k, v in app_params.items():
> +            if v is not None:
> +                self._app_params[k] =3D (
> +                    self.vector_directory.joinpath(str(v)) if k =3D=3D
> "test_file" else v
> +                )
> +
>      def run_app(self, num_vfs: int =3D 1) -> list[CryptodevResults]:
>          """Run the cryptodev application with the given app parameters.
>
> diff --git a/dts/api/cryptodev/config.py b/dts/api/cryptodev/config.py
> index 3420c2fe91..252d3237c8 100644
> --- a/dts/api/cryptodev/config.py
> +++ b/dts/api/cryptodev/config.py
> @@ -515,3 +515,50 @@ class CryptoPmdParams(EalParams):
>      test_name: str | None =3D field(default=3DNone,
> metadata=3DParams.long("test-name"))
>      tls_version: TLSVersion | None =3D field(default=3DNone,
> metadata=3DParams.long("tls-version"))
>      total_ops: int | None =3D field(default=3D100000,
> metadata=3DParams.long("total-ops"))
> +
> +
> +# Algorithm parameter mappings for automatic key/IV size determination
> +CIPHER_ALGORITHM_PARAMS =3D {
> +    CipherAlgorithm.aes_cbc: {"key_size": 16, "iv_size": 16},
> +    CipherAlgorithm.aes_ctr: {"key_size": 16, "iv_size": 16},
> +    CipherAlgorithm.aes_gcm: {"key_size": 16, "iv_size": 16},
> +    CipherAlgorithm.aes_ecb: {"key_size": 16, "iv_size": 16},
> +    CipherAlgorithm.aes_f8: {"key_size": 16, "iv_size": 16},
> +    CipherAlgorithm.aes_xts: {"key_size": 16, "iv_size": 16},
> +    CipherAlgorithm.arc4: {"key_size": 16, "iv_size": 16},
> +    CipherAlgorithm.null: {"key_size": 16, "iv_size": 16},
> +    CipherAlgorithm.aes_docsisbpi: {"key_size": 32, "iv_size": 16},
> +    CipherAlgorithm.snow3g_uea2: {"key_size": 16, "iv_size": 16},
> +    CipherAlgorithm.zuc_eea3: {"key_size": 16, "iv_size": 16},
> +    CipherAlgorithm.kasumi_f8: {"key_size": 16, "iv_size": 8},
> +    CipherAlgorithm.three_des_cbc: {"key_size": 8, "iv_size": 8},
> +    CipherAlgorithm.three_des_ecb: {"key_size": 24, "iv_size": 8},
> +    CipherAlgorithm.three_des_ctr: {"key_size": 24, "iv_size": 8},
> +}
> +
> +AUTHENTICATION_ALGORITHM_PARAMS =3D {
> +    AuthenticationAlgorithm.sha1: {"key_size": 20, "iv_size": 0,
> "digest_size": 20},
> +    AuthenticationAlgorithm.sha1_hmac: {"key_size": 64, "iv_size": 20,
> "digest_size": 12},
> +    AuthenticationAlgorithm.sha2_224: {"key_size": 20, "iv_size": 0,
> "digest_size": 20},
> +    AuthenticationAlgorithm.sha2_224_hmac: {"key_size": 20, "iv_size": 0=
,
> "digest_size": 20},
> +    AuthenticationAlgorithm.sha2_256: {"key_size": 64, "iv_size": 0,
> "digest_size": 32},
> +    AuthenticationAlgorithm.sha2_256_hmac: {"key_size": 64, "iv_size": 0=
,
> "digest_size": 32},
> +    AuthenticationAlgorithm.sha2_384: {"key_size": 48, "iv_size": 0,
> "digest_size": 48},
> +    AuthenticationAlgorithm.sha2_384_hmac: {"key_size": 48, "iv_size": 0=
,
> "digest_size": 48},
> +    AuthenticationAlgorithm.sha2_512: {"key_size": 64, "iv_size": 0,
> "digest_size": 64},
> +    AuthenticationAlgorithm.sha2_512_hmac: {"key_size": 64, "iv_size": 0=
,
> "digest_size": 64},
> +    AuthenticationAlgorithm.md5: {"key_size": 16, "iv_size": 0,
> "digest_size": 16},
> +    AuthenticationAlgorithm.md5_hmac: {"key_size": 16, "iv_size": 0,
> "digest_size": 16},
> +    AuthenticationAlgorithm.snow3g_uia2: {"key_size": 16, "iv_size": 16,
> "digest_size": 4},
> +    AuthenticationAlgorithm.zuc_eia3: {"key_size": 16, "iv_size": 16,
> "digest_size": 4},
> +    AuthenticationAlgorithm.kasumi_f9: {"key_size": 16, "iv_size": 0,
> "digest_size": 4},
> +    AuthenticationAlgorithm.aes_gmac: {"key_size": 16, "iv_size": 16,
> "digest_size": 16},
> +    AuthenticationAlgorithm.aes_xcbc_mac: {"key_size": 16, "iv_size": 0,
> "digest_size": 12},
> +    AuthenticationAlgorithm.aes_cmac: {"key_size": 16, "iv_size": 0,
> "digest_size": 16},
> +    AuthenticationAlgorithm.aes_cbc_mac: {"key_size": 16, "iv_size": 0,
> "digest_size": 16},
> +}
> +
> +AEAD_ALGORITHM_PARAMS =3D {
> +    AeadAlgName.aes_gcm: {"key_size": 16, "iv_size": 12, "aad_size": 16,
> "digest_size": 16},
> +    AeadAlgName.aes_ccm: {"key_size": 16, "iv_size": 11, "aad_size": 16,
> "digest_size": 16},
> +}
> diff --git a/dts/api/params/__init__.py b/dts/api/params/__init__.py
> index b5bae9dad9..04e2c0f386 100644
> --- a/dts/api/params/__init__.py
> +++ b/dts/api/params/__init__.py
> @@ -334,7 +334,7 @@ def _make_switch(
>          """
>          prefix =3D f"{'-' if is_short else '--'}{'no-' if is_no else ''}=
"
>          name =3D name.replace("_", "-")
> -        value =3D f"{' ' if is_short else '=3D'}{value}" if value else "=
"
> +        value =3D f"{' ' if is_short else '=3D'}{value}" if value or val=
ue =3D=3D
> 0 else ""
>          return f"{prefix}{name}{value}"
>
>      def __str__(self) -> str:
> diff --git a/dts/configurations/nodes.example.yaml
> b/dts/configurations/nodes.example.yaml
> index 334de68f97..ccda20fb87 100644
> --- a/dts/configurations/nodes.example.yaml
> +++ b/dts/configurations/nodes.example.yaml
> @@ -9,7 +9,7 @@
>  #   `crypto_device_type`:
>  #     Uncomment to run cryptodev tests; the device type of the DUT e.g.
> (crypto_qat, crypto_zuc,
>  #     crypto_aesni_mb); the complete list of device types can be found
> here
> -#     https://doc.dpdk.org/guides-24.07/cryptodevs/overview.html
> +#     https://doc.dpdk.org/guides-26.07/cryptodevs/overview.html
>
>  # Define a system under test node, having two network ports physically
>  # connected to the corresponding ports in TG 1 (the peer node)
> diff --git a/dts/configurations/tests_config.example.yaml
> b/dts/configurations/tests_config.example.yaml
> index ce67385b0b..fe4bed2847 100644
> --- a/dts/configurations/tests_config.example.yaml
> +++ b/dts/configurations/tests_config.example.yaml
> @@ -2,10 +2,13 @@
>
>  # Optional Fields:
>  #   All fields are optional, uncomment a test suite to run it with a
> specific configuration.
> +#   cryptodev_throughput:
> +#       algorithms:
> https://doc.dpdk.org/guides-26.07/cryptodevs/overview.html
>
>  # Define the custom test suite configurations
>  hello_world:
>    msg: A custom hello world to you!
> +
>  # single_core_forward_perf:
>  #   test_parameters: # Add frame size / descriptor count combinations as
> needed
>  #     - frame_size: 64
> @@ -18,18 +21,51 @@ hello_world:
>  #       num_descriptors: 1024
>  #       expected_mpps: 1.0
>  #   delta_tolerance: 0.05
> +
>  # pmd_rss:
>  #   NUM_QUEUES: 4
>  #   ACTUAL_KEY_SIZE: 52
>  #   ACTUAL_RETA_SIZE: 512
> +
>  # cryptodev_throughput:
>  #   delta_tolerance: 0.05
> -#   throughput_test_parameters:
> -#     snow3g_uea2_snow3g_uia2: # Add the name of the test suite you woul=
d
> like to run
> -#      - buff_size: 64
> -#        Gbps: 2.0 # Set gigabits per second according to your devices
> throughput for this given buffer size
> -#      - buff_size: 512
> -#        Gbps: 20.0
> +#   test_combinations:
> +#     - name: "example cipher test" # Add a name for this test config
> +#       cipher_algorithm: "aes_cbc" # See `algortihms` in `Optional
> Fields` for a complete list
> +#       virtual_device: "crypto_openssl" # uncomment to run with a
> virtual device.
> +#       test_parameters:  # Buffer sizes and expected throughput, a
> default is used if not present
> +#         - buff_size: 64
> +#           Gbps: 1.5 # Set gigabits per second for your devices
> throughput for this buffer size
> +#         - buff_size: 512
> +#           Gbps: 3.0
> +#         - buff_size: 2048
> +#           Gbps: 4.0
> +#     - name: "example authentication test"
> +#       auth_algorithm: "aes_cbc_mac" # See `algortihms` in `Optional
> Fields` for a complete list
> +#       test_parameters:
> +#         - buff_size: 64
> +#           Gbps: 1.5
> +#     - name: "example cipher then auth test"
> +#       ops: 30000000 # Specify total ops to use, 10000000 is used by
> default
> +#       cipher_algorithm: "aes_cbc" # See `algortihms` in `Optional
> Fields` for a complete list
> +#       auth_algorithm: "aes_cbc_mac" # See `algortihms` in `Optional
> Fields` for a complete list
> +#       cipher_key_size: 16
> +#       cipher_iv_size: 0
> +#       auth_key_size: 16 # Specify key size, a default is used if field
> is not present
> +#       auth_iv_size: 0 # Specify IV size, a default is used if field is
> not present
> +#       test_parameters:
> +#         - buff_size: 64
> +#           Gbps: 1.5
> +#     - name: "example aead test"
> +#       aead_algorithm: "aes_gcm" # See `algortihms` in `Optional Fields=
`
> for a complete list
> +#       aead_key_sz: 16
> +#       aead_iv_sz: 16
> +#       aead_aad_sz: 16 # Specify AAD size, a default is used if field
> not present
> +#       digest_sz: 16 # Specify a digest size, a default is used if not
> present
> +#       test_parameters:
> +#         - buff_size: 64
> +#           Gbps: 1.5
> +
>  # port_speed_capabilities:
>  #   test_parameters:
>  #     0 : 100 Gbps # Assign an expected link speed to a port ID in Gbps
> diff --git a/dts/tests/TestSuite_cryptodev_throughput.py
> b/dts/tests/TestSuite_cryptodev_throughput.py
> index 59f64f2cd7..d061ec02dc 100644
> --- a/dts/tests/TestSuite_cryptodev_throughput.py
> +++ b/dts/tests/TestSuite_cryptodev_throughput.py
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
> @@ -30,7 +35,8 @@
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
> @@ -40,37 +46,57 @@
>      {"buff_size": 2048, "Gbps": 1.00},
>  ]
>
> -TOTAL_OPS =3D 10_000_000
> -
>
>  class Config(BaseConfig):
>      """Performance test metrics.
>
>      Attributes:
>          delta_tolerance: The allowed tolerance below a given baseline.
> -        throughput_test_parameters: The test parameters to use in the
> test suite.
> +        test_combinations: List of test combinations with cipher/auth
> algorithms and parameters.
>      """
>
>      delta_tolerance: float =3D 0.05
> -
> -    throughput_test_parameters: dict[str, list[dict[str, int | float |
> str]]] =3D {
> -        "aes_cbc": config_list,
> -        "aes_cbc_sha1": config_list,
> -        "aes_cbc_sha2": config_list,
> -        "aes_cbc_sha2_digest_16": config_list,
> -        "aead_aes_gcm": config_list,
> -        "aes_docsisbpi": config_list,
> -        "sha1_hmac": config_list,
> -        "snow3g_uea2_snow3g_uia2": config_list,
> -        "zuc_eea3_zuc_eia3": config_list,
> -        "kasumi_f8_kasumi_f9": config_list,
> -        "open_ssl_vdev": config_list,
> -        "aesni_mb_vdev": config_list,
> -        "aesni_gcm_vdev": config_list,
> -        "kasumi_vdev": config_list,
> -        "zuc_vdev": config_list,
> -        "snow3g_vdev": config_list,
> -    }
> +    test_combinations: list[dict[str, Any]] =3D [
> +        #: cipher only tests
> +        {
> +            "name": "aes-cbc (cipher only)",
> +            "cipher_algorithm": CipherAlgorithm.aes_cbc.name,
> +        },
> +        {
> +            "name": "aead-docsisbpi (cipher only)",
> +            "cipher_algorithm": CipherAlgorithm.aes_docsisbpi.name,
> +        },
> +        #: authentication only tests
> +        {
> +            "name": "sha1-hmac (auth only)",
> +            "auth_algorithm": AuthenticationAlgorithm.sha1_hmac.name,
> +            "auth_iv_size": 16,
> +        },
> +        #: cipher then auth tests
> +        {
> +            "name": "aes-cbc/sha1-hmac (cipher then auth)",
> +            "cipher_algorithm": CipherAlgorithm.aes_cbc.name,
> +            "auth_algorithm": AuthenticationAlgorithm.sha1_hmac.name,
> +            "virtual_device": "crypto_openssl",
> +        },
> +        {
> +            "name": "aes-cbc/sha2-256-hmac (cipher then auth)",
> +            "cipher_algorithm": CipherAlgorithm.aes_cbc.name,
> +            "auth_algorithm": AuthenticationAlgorithm.sha2_256_hmac.name=
,
> +            "virtual_device": "crypto_openssl",
> +        },
> +        {
> +            "name": "aes-cbc/sha2-256-hmac/digest-16 (cipher then auth)"=
,
> +            "cipher_algorithm": CipherAlgorithm.aes_cbc.name,
> +            "auth_algorithm": AuthenticationAlgorithm.sha2_256_hmac.name=
,
> +            "digest_size": 16,
> +        },
> +        #: aead tests
> +        {
> +            "name": "aead-aes-gcm",
> +            "aead_algorithm": AeadAlgName.aes_gcm.name,
> +        },
> +    ]
>
>
>  @requires_link_topology(LinkTopology.NO_LINK)
> @@ -80,60 +106,137 @@ class TestCryptodevThroughput(TestSuite):
>      config: Config
>
>      def set_up_suite(self) -> None:
> -        """Set up the test suite."""
> -        self.throughput_test_parameters: dict[str, list[dict[str, int |
> float | str]]] =3D (
> -            self.config.throughput_test_parameters
> -        )
> +        """Set up the test suite.
> +
> +        Raises:
> +            ConfigurationError: When a test config contains no algorithm
> to test.
> +        """
> +        self.test_combinations: list[dict[str, Any]] =3D
> self.config.test_combinations
>          self.delta_tolerance: float =3D self.config.delta_tolerance
> +        self.ops: int =3D 10_000_000
>          self.device_type: DeviceType | None =3D get_device_from_str(
>              str(get_ctx().sut_node.crypto_device_type)
>          )
> -        self.buffer_sizes =3D {}
> +        self.buffer_sizes: dict[str, ListWrapper] =3D {}
> +
> +        # categorize configured tests
> +        self.cipher_tests: list[dict[str, Any]] =3D []
> +        self.auth_tests: list[dict[str, Any]] =3D []
> +        self.cipher_then_auth_tests: list[dict[str, Any]] =3D []
> +        self.aead_tests: list[dict[str, Any]] =3D []
> +
> +        # Filter tests by operation types
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
> -        for k, v in self.throughput_test_parameters.items():
> -            self.buffer_sizes[k] =3D ListWrapper([int(run["buff_size"]) =
for
> run in v])
> +    def _print_and_verify(self, all_results: list[list[dict[str, int |
> float | str]]]) -> None:
> +        """Print the given results and verify all results have passed.
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
>          element_len =3D len("Delta Tolerance")
> -        border_len =3D (element_len + 1) * (len(test_vals[0]))
> +        border_len =3D (element_len + 1) * (len(test_vals[0]) - 1)
> +        test_name =3D test_vals[0]["Test Name"]
>
> -        print(f"{'Throughput Results'.center(border_len)}\n{'=3D' *
> border_len}")
> +        print(f"{f'{test_name} Throughput
> Results'.center(border_len)}\n{'=3D' * border_len}")
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
> -    def _verify_throughput(
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
> throughput mode.
> +            params: The baselines to compare the given results to.
> +            test_name: The test name to pin to the result summary.
> +
> +        Returns:
> +            A summary of throughput statistics for a test and whether th=
e
> test passed.
> +
> +        Raises:
> +            RuntimeError: When there are no baselines for a given result=
.
> +        """
>          result_list: list[dict[str, int | float | str]] =3D []
>
>          for result in results:
>              # get the corresponding baseline for the current buffer size
> -            parameters: dict[str, int | float | str] =3D list(
> +            parameters: dict[str, int | float | str] =3D next(
>                  filter(
>                      lambda x: x["buff_size"] =3D=3D result.buffer_size,
> -                    self.throughput_test_parameters[key],
> -                )
> -            )[0]
> +                    params,
> +                ),
> +                {},
> +            )
> +            errmsg =3D (
> +                f"No test parameters found for {test_name} with buffer
> size {result.buffer_size}"
> +            )
> +            if parameters =3D=3D {}:
> +                raise RuntimeError(errmsg)
>              test_result =3D True
>              expected_gbps =3D parameters["Gbps"]
>              measured_delta =3D abs(
>                  round((getattr(result, "gbps") - expected_gbps) /
> expected_gbps, 5)
>              )
> -
>              # result did not meet the given Gbps parameter, check if
> within delta.
>              if getattr(result, "gbps") < expected_gbps:
>                  if self.delta_tolerance < measured_delta:
>                      test_result =3D False
> +
>              result_list.append(
>                  {
> +                    "Test Name": test_name,
>                      "Buffer Size": parameters["buff_size"],
>                      "Gbps delta": measured_delta,
>                      "delta tolerance": self.delta_tolerance,
> @@ -145,502 +248,309 @@ def _verify_throughput(
>          return result_list
>
>      @crypto_test
> -    def aes_cbc(self) -> None:
> -        """aes_cbc test.
> -
> -        Steps:
> -            * Create a cryptodev instance with provided device type and
> buffer sizes.
> -        Verify:
> -            * The resulting Gbps is greater than
> expected_gbps*(1-delta_tolerance).
> -        """
> -        if "aes_cbc" not in self.throughput_test_parameters:
> -            skip("test not configured")
> -        app =3D Cryptodev(
> -            ptest=3DTestType.throughput,
> -            devtype=3Dself.device_type,
> -            optype=3DOperationType.cipher_only,
> -            cipher_algo=3DCipherAlgorithm.aes_cbc,
> -            cipher_op=3DEncryptDecryptSwitch.encrypt,
> -            cipher_key_sz=3D16,
> -            cipher_iv_sz=3D16,
> -            total_ops=3DTOTAL_OPS,
> -            buffer_sz=3Dself.buffer_sizes["aes_cbc"],
> -        )
> -        results =3D self._verify_throughput(app.run_app(), "aes_cbc")
> -        self._print_stats(results)
> -        for result in results:
> -            verify(result["passed"] =3D=3D "PASS", "Gbps fell below delt=
a
> tolerance")
> -
> -    @crypto_test
> -    def aes_cbc_sha1(self) -> None:
> -        """aes_cbc_sha1 test.
> -
> -        Steps:
> -            * Create a cryptodev instance with provided device type and
> buffer sizes.
> -        Verify:
> -            * The resulting Gbps is greater than
> expected_gbps*(1-delta_tolerance).
> -        """
> -        if "aes_cbc_sha1" not in self.throughput_test_parameters:
> -            skip("test not configured")
> -        app =3D Cryptodev(
> -            ptest=3DTestType.throughput,
> -            devtype=3Dself.device_type,
> -            optype=3DOperationType.cipher_then_auth,
> -            cipher_algo=3DCipherAlgorithm.aes_cbc,
> -            cipher_op=3DEncryptDecryptSwitch.encrypt,
> -            cipher_key_sz=3D16,
> -            cipher_iv_sz=3D16,
> -            auth_algo=3DAuthenticationAlgorithm.sha1_hmac,
> -            auth_op=3DAuthenticationOpMode.generate,
> -            auth_key_sz=3D64,
> -            auth_iv_sz=3D20,
> -            digest_sz=3D12,
> -            total_ops=3DTOTAL_OPS,
> -            buffer_sz=3Dself.buffer_sizes["aes_cbc_sha1"],
> -        )
> -        results =3D self._verify_throughput(app.run_app(), "aes_cbc_sha1=
")
> -        self._print_stats(results)
> -        for result in results:
> -            verify(result["passed"] =3D=3D "PASS", "Gbps fell below delt=
a
> tolerance")
> -
> -    @crypto_test
> -    def aes_cbc_sha2(self) -> None:
> -        """aes_cbc_sha2 test.
> -
> -        Steps:
> -            * Create a cryptodev instance with provided device type and
> buffer sizes.
> -        Verify:
> -            * The resulting Gbps is greater than
> expected_gbps*(1-delta_tolerance).
> -        """
> -        if "aes_cbc_sha2" not in self.throughput_test_parameters:
> -            skip("test not configured")
> -        app =3D Cryptodev(
> -            ptest=3DTestType.throughput,
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
> -            total_ops=3DTOTAL_OPS,
> -            buffer_sz=3Dself.buffer_sizes["aes_cbc_sha2"],
> -        )
> -        results =3D self._verify_throughput(app.run_app(), "aes_cbc_sha2=
")
> -        self._print_stats(results)
> -        for result in results:
> -            verify(result["passed"] =3D=3D "PASS", "Gbps fell below delt=
a
> tolerance")
> -
> -    @crypto_test
> -    def aes_cbc_sha2_digest_16(self) -> None:
> -        """aes_cbc_sha2_digest_16 test.
> -
> -        Steps:
> -            * Create a cryptodev instance with provided device type and
> buffer sizes.
> -        Verify:
> -            * The resulting Gbps is greater than
> expected_gbps*(1-delta_tolerance).
> -        """
> -        if "aes_cbc_sha2_digest_16" not in
> self.throughput_test_parameters:
> -            skip("test not configured")
> -        app =3D Cryptodev(
> -            ptest=3DTestType.throughput,
> -            devtype=3Dself.device_type,
> -            optype=3DOperationType.cipher_then_auth,
> -            cipher_algo=3DCipherAlgorithm.aes_cbc,
> -            cipher_op=3DEncryptDecryptSwitch.encrypt,
> -            cipher_key_sz=3D16,
> -            cipher_iv_sz=3D16,
> -            auth_algo=3DAuthenticationAlgorithm.sha2_256_hmac,
> -            auth_op=3DAuthenticationOpMode.generate,
> -            auth_key_sz=3D64,
> -            digest_sz=3D16,
> -            total_ops=3DTOTAL_OPS,
> -            buffer_sz=3Dself.buffer_sizes["aes_cbc_sha2_digest_16"],
> -        )
> -        results =3D self._verify_throughput(app.run_app(),
> "aes_cbc_sha2_digest_16")
> -        self._print_stats(results)
> -        for result in results:
> -            verify(result["passed"] =3D=3D "PASS", "Gbps fell below delt=
a
> tolerance")
> -
> -    @crypto_test
> -    def aead_aes_gcm(self) -> None:
> -        """aead_aes_gcm test.
> -
> -        Steps:
> -            * Create a cryptodev instance with provided device type and
> buffer sizes.
> -        Verify:
> -            * The resulting Gbps is greater than
> expected_gbps*(1-delta_tolerance).
> -        """
> -        if "aead_aes_gcm" not in self.throughput_test_parameters:
> -            skip("test not configured")
> -        app =3D Cryptodev(
> -            ptest=3DTestType.throughput,
> -            devtype=3Dself.device_type,
> -            optype=3DOperationType.aead,
> -            aead_algo=3DAeadAlgName.aes_gcm,
> -            aead_op=3DEncryptDecryptSwitch.encrypt,
> -            aead_key_sz=3D16,
> -            aead_iv_sz=3D12,
> -            aead_aad_sz=3D16,
> -            digest_sz=3D16,
> -            total_ops=3DTOTAL_OPS,
> -            buffer_sz=3Dself.buffer_sizes["aead_aes_gcm"],
> -        )
> -        results =3D self._verify_throughput(app.run_app(), "aead_aes_gcm=
")
> -        self._print_stats(results)
> -        for result in results:
> -            verify(result["passed"] =3D=3D "PASS", "Gbps fell below delt=
a
> tolerance")
> -
> -    @crypto_test
> -    def aes_docsisbpi(self) -> None:
> -        """aes_docsisbpi test.
> -
> -        Steps:
> -            * Create a cryptodev instance with provided device type and
> buffer sizes.
> -        Verify:
> -            * The resulting Gbps is greater than
> expected_gbps*(1-delta_tolerance).
> -        """
> -        if "aes_docsisbpi" not in self.throughput_test_parameters:
> -            skip("test not configured")
> -        app =3D Cryptodev(
> -            ptest=3DTestType.throughput,
> -            devtype=3Dself.device_type,
> -            optype=3DOperationType.cipher_only,
> -            cipher_algo=3DCipherAlgorithm.aes_docsisbpi,
> -            cipher_op=3DEncryptDecryptSwitch.encrypt,
> -            cipher_key_sz=3D32,
> -            cipher_iv_sz=3D16,
> -            total_ops=3DTOTAL_OPS,
> -            buffer_sz=3Dself.buffer_sizes["aes_docsisbpi"],
> -        )
> -        results =3D self._verify_throughput(app.run_app(), "aes_docsisbp=
i")
> -        self._print_stats(results)
> -        for result in results:
> -            verify(result["passed"] =3D=3D "PASS", "Gbps fell below delt=
a
> tolerance")
> -
> -    @crypto_test
> -    def sha1_hmac(self) -> None:
> -        """sha1_hmac test.
> -
> -        Steps:
> -            * Create a cryptodev instance with provided device type and
> buffer sizes.
> -        Verify:
> -            * The resulting Gbps is greater than
> expected_gbps*(1-delta_tolerance).
> -        """
> -        if "sha1_hmac" not in self.throughput_test_parameters:
> -            skip("test not configured")
> -        app =3D Cryptodev(
> -            ptest=3DTestType.throughput,
> -            devtype=3Dself.device_type,
> -            optype=3DOperationType.auth_only,
> -            auth_algo=3DAuthenticationAlgorithm.sha1_hmac,
> -            auth_op=3DAuthenticationOpMode.generate,
> -            auth_key_sz=3D64,
> -            auth_iv_sz=3D16,
> -            digest_sz=3D12,
> -            total_ops=3DTOTAL_OPS,
> -            buffer_sz=3Dself.buffer_sizes["sha1_hmac"],
> -        )
> -        results =3D self._verify_throughput(app.run_app(), "sha1_hmac")
> -        self._print_stats(results)
> -        for result in results:
> -            verify(result["passed"] =3D=3D "PASS", "Gbps fell below delt=
a
> tolerance")
> -
> -    @crypto_test
> -    def snow3g_uea2_snow3g_uia2(self) -> None:
> -        """snow3g_uea2_snow3g_uia2 test.
> -
> -        Steps:
> -            * Create a cryptodev instance with provided device type and
> buffer sizes.
> -        Verify:
> -            * The resulting Gbps is greater than
> expected_gbps*(1-delta_tolerance).
> -        """
> -        if "snow3g_uea2_snow3g_uia2" not in
> self.throughput_test_parameters:
> -            skip("test not configured")
> -        app =3D Cryptodev(
> -            ptest=3DTestType.throughput,
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
> -        results =3D self._verify_throughput(app.run_app(),
> "snow3g_uea2_snow3g_uia2")
> -        self._print_stats(results)
> -        for result in results:
> -            verify(result["passed"] =3D=3D "PASS", "Gbps fell below delt=
a
> tolerance")
> -
> -    @crypto_test
> -    def zuc_eea3_zuc_eia3(self) -> None:
> -        """zuc_eea3_zuc_eia3 test.
> +    def cipher_only_tests(self) -> None:
> +        """Cipher only cryptography device tests.
>
>          Steps:
> -            * Create a cryptodev instance with provided device type and
> buffer sizes.
> +            * Run dpdk-test-crypto-perf application with configured
> arguments in cipher only mode.
>          Verify:
> -            * The resulting Gbps is greater than
> expected_gbps*(1-delta_tolerance).
> +            * The reported Gbps is within a defined tolerance of a given
> baseline.
>          """
> -        if "zuc_eea3_zuc_eia3" not in self.throughput_test_parameters:
> -            skip("test not configured")
> -        app =3D Cryptodev(
> -            ptest=3DTestType.throughput,
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
> -        results =3D self._verify_throughput(app.run_app(),
> "zuc_eea3_zuc_eia3")
> -        self._print_stats(results)
> -        for result in results:
> -            verify(result["passed"] =3D=3D "PASS", "Gbps fell below delt=
a
> tolerance")
>
> -    @crypto_test
> -    def kasumi_f8_kasumi_f9(self) -> None:
> -        """kasumi_f8 kasumi_f9 test.
> -
> -        Steps:
> -            * Create a cryptodev instance with provided device type and
> buffer sizes.
> -        Verify:
> -            * The resulting Gbps is greater than
> expected_gbps*(1-delta_tolerance).
> -        """
> -        if "kasumi_f8_kasumi_f9" not in self.throughput_test_parameters:
> -            skip("test not configured")
> -        app =3D Cryptodev(
> -            ptest=3DTestType.throughput,
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
> -        results =3D self._verify_throughput(app.run_app(),
> "kasumi_f8_kasumi_f9")
> -        self._print_stats(results)
> -        for result in results:
> -            verify(result["passed"] =3D=3D "PASS", "Gbps fell below delt=
a
> tolerance")
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
> +                ptest=3DTestType.throughput,
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
> +            )
> +            if is_vdev:
> +                app.update_params(
> +                    vdevs=3D[VirtualDevice(combination["virtual_device"]=
)],
> +
> devtype=3Dget_device_from_str(combination["virtual_device"]),
> +                )
>
> -    # BEGIN VDEV TESTS
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
> -    def aesni_mb_vdev(self) -> None:
> -        """aesni_mb virtual device test.
> +    def auth_only_tests(self) -> None:
> +        """Authentication cryptography device tests.
>
>          Steps:
> -            * Create a cryptodev instance with crypto_aesni_mb and
> supplied buffer sizes.
> +            * Run dpdk-test-crypto-perf application with configured
> parameters in authentication
> +                only moode.
>          Verify:
> -            * The resulting Gbps is greater than
> expected_gbps*(1-delta_tolerance).
> +            * The resulting Gbps is within a delta tolerance of a
> provided baseline.
>          """
> -        if "aesni_mb_vdev" not in self.throughput_test_parameters:
> -            skip("test not configured")
> -        app =3D Cryptodev(
> -            ptest=3DTestType.throughput,
> -            vdevs=3D[VirtualDevice("crypto_aesni_mb0")],
> -            devtype=3DDeviceType.crypto_aesni_mb,
> -            optype=3DOperationType.cipher_then_auth,
> -            cipher_algo=3DCipherAlgorithm.aes_cbc,
> -            cipher_op=3DEncryptDecryptSwitch.encrypt,
> -            cipher_key_sz=3D32,
> -            cipher_iv_sz=3D16,
> -            auth_algo=3DAuthenticationAlgorithm.sha1_hmac,
> -            auth_op=3DAuthenticationOpMode.generate,
> -            auth_key_sz=3D16,
> -            auth_iv_sz=3D16,
> -            digest_sz=3D4,
> -            burst_sz=3D32,
> -            total_ops=3DTOTAL_OPS,
> -            buffer_sz=3Dself.buffer_sizes["aesni_mb_vdev"],
> -        )
> -        results =3D self._verify_throughput(app.run_app(num_vfs=3D0),
> "aesni_mb_vdev")
> -        self._print_stats(results)
> -        for result in results:
> -            verify(result["passed"] =3D=3D "PASS", "Gbps fell below delt=
a
> tolerance")
>
> -    @crypto_test
> -    def aesni_gcm_vdev(self):
> -        """aesni_gcm virtual device test.
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
> +                ptest=3DTestType.throughput,
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
> +            )
> +            if is_vdev:
> +                app.update_params(
> +                    vdevs=3D[VirtualDevice(combination["virtual_device"]=
)],
> +
> devtype=3Dget_device_from_str(combination["virtual_device"]),
> +                )
>
> -        Steps:
> -            * Create a cryptodev instance with crypto_aesni_gcm and
> supplied buffer sizes.
> -        Verify:
> -            * The resulting Gbps is greater than
> expected_gbps*(1-delta_tolerance).
> -        """
> -        if "aesni_gcm_vdev" not in self.throughput_test_parameters:
> -            skip("test not configured")
> -        app =3D Cryptodev(
> -            ptest=3DTestType.throughput,
> -            vdevs=3D[VirtualDevice("crypto_aesni_gcm0")],
> -            devtype=3DDeviceType.crypto_aesni_gcm,
> -            optype=3DOperationType.aead,
> -            aead_algo=3DAeadAlgName.aes_gcm,
> -            aead_op=3DEncryptDecryptSwitch.encrypt,
> -            aead_key_sz=3D16,
> -            aead_iv_sz=3D12,
> -            aead_aad_sz=3D16,
> -            digest_sz=3D16,
> -            total_ops=3DTOTAL_OPS,
> -            buffer_sz=3Dself.buffer_sizes["aesni_gcm_vdev"],
> -        )
> -        results =3D self._verify_throughput(app.run_app(num_vfs=3D0),
> "aesni_gcm_vdev")
> -        self._print_stats(results)
> -        for result in results:
> -            verify(result["passed"] =3D=3D "PASS", "Gbps fell below delt=
a
> tolerance")
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
> -    def kasumi_vdev(self) -> None:
> -        """Kasmumi virtual device test.
> +    def aead_test(self) -> None:
> +        """Aead cryptography test.
>
>          Steps:
> -            * Create a cryptodev instance with crypto_kasumi and supplie=
d
> buffer sizes.
> +            * Run dpdk-test-crypto-perf application with configured
> parameters in aead mode.
>          Verify:
> -            * The resulting Gbps is greater than
> expected_gbps*(1-delta_tolerance).
> +            * The resulting Gbps is within a delta tolerance of a given
> baseline.
>          """
> -        if "kasumi_vdev" not in self.throughput_test_parameters:
> -            skip("test not configured")
> -        app =3D Cryptodev(
> -            vdevs=3D[VirtualDevice("crypto_kasumi0")],
> -            ptest=3DTestType.throughput,
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
> -        results =3D self._verify_throughput(app.run_app(num_vfs=3D0),
> "kasumi_vdev")
> -        self._print_stats(results)
> -        for result in results:
> -            verify(result["passed"] =3D=3D "PASS", "Gbps fell below delt=
a
> tolerance")
>
> -    @crypto_test
> -    def snow3g_vdev(self) -> None:
> -        """snow3g virtual device test.
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
> +                ptest=3DTestType.throughput,
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
> +            )
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
> -        Steps:
> -            * Create a cryptodev instance with crypto_snow3g and supplie=
d
> buffer sizes.
> -        Verify:
> -            * The resulting Gbps is greater than
> expected_gbps*(1-delta_tolerance).
> -        """
> -        if "snow3g_vdev" not in self.throughput_test_parameters:
> -            skip("test not configured")
> -        app =3D Cryptodev(
> -            ptest=3DTestType.throughput,
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
> -            digest_sz=3D4,
> -            burst_sz=3D32,
> -            total_ops=3DTOTAL_OPS,
> -            buffer_sz=3Dself.buffer_sizes["snow3g_vdev"],
> -        )
> -        results =3D self._verify_throughput(app.run_app(num_vfs=3D0),
> "snow3g_vdev")
> -        self._print_stats(results)
> -        for result in results:
> -            verify(result["passed"] =3D=3D "PASS", "Gbps fell below delt=
a
> tolerance")
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
> -    def zuc_vdev(self) -> None:
> -        """Zuc virtual device test.
> +    def cipher_and_auth_tests(self) -> None:
> +        """Cipher and Authentication tests.
>
>          Steps:
> -            * Create a cryptodev instance with crypto_zuc and supplied
> buffer sizes.
> +            * Run dpdk-test-crypto-perf application in cipher then
> authentication mode
>          Verify:
> -            * The resulting Gbps is greater than
> expected_gbps*(1-delta_tolerance).
> +            * The resulting Gbps is within a delta tolerance of a given
> baseline.
>          """
> -        if "zuc_vdev" not in self.throughput_test_parameters:
> -            skip("test not configured")
> -        app =3D Cryptodev(
> -            ptest=3DTestType.throughput,
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
> -        results =3D self._verify_throughput(app.run_app(num_vfs=3D0),
> "zuc_vdev")
> -        self._print_stats(results)
> -        for result in results:
> -            verify(result["passed"] =3D=3D "PASS", "Gbps fell below delt=
a
> tolerance")
> -
> -    @crypto_test
> -    def open_ssl_vdev(self) -> None:
> -        """open_ssl virtual device test.
>
> -        Steps:
> -            * Create a cryptodev instance with provided device type and
> buffer sizes.
> -        Verify:
> -            * The resulting Gbps is greater than
> expected_gbps*(1-delta_tolerance).
> -        """
> -        if "open_ssl_vdev" not in self.throughput_test_parameters:
> -            skip("test not configured")
> -        app =3D Cryptodev(
> -            ptest=3DTestType.throughput,
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
> -        results =3D self._verify_throughput(app.run_app(num_vfs=3D0),
> "open_ssl_vdev")
> -        self._print_stats(results)
> -        for result in results:
> -            verify(
> -                result["passed"] =3D=3D "PASS",
> -                "Gbps fell below delta tolerance",
> +        def test(
> +            encrypt: EncryptDecryptSwitch, op_mode: AuthenticationOpMode
> +        ) -> list[dict[str, int | float | str]]:
> +            """Execute the dpdk-test-crypto application and verify.
> +
> +            Args:
> +                encrypt: The cipher encryption mode to run throughput
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
> +                ptest=3DTestType.throughput,
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
> +
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

--000000000000109e66065ed29a2a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Koushik Bhargav Nimoji &lt;<a href=3D"mailto:=
knimoji@iol.unh.edu">knimoji@iol.unh.edu</a>&gt;</div><br><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Oct 19, 2026 at 4:0=
4=E2=80=AFPM Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.unh.edu" targe=
t=3D"_blank">abailey@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Previously, the cryptodev throughput test =
suite only allowed for<br>
a small set of algorithms to be tested for a set number of operations.<br>
This is undesirable as a user may want to test one of the hundreds of<br>
possible combinations rather than the much smaller preset tests<br>
previously available. This commit adds support for proper test<br>
configuration of the cryptodev throughput test suite to provide total<br>
coverage of all algorithms.<br>
<br>
Signed-off-by: Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.unh.edu" tar=
get=3D"_blank">abailey@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0dts/api/cryptodev/__init__.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 12 +<br>
=C2=A0dts/api/cryptodev/config.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 47 +<br>
=C2=A0dts/api/params/__init__.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
=C2=A0dts/configurations/nodes.example.yaml=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A02 +-<br>
=C2=A0dts/configurations/tests_config.example.yaml |=C2=A0 48 +-<br>
=C2=A0dts/tests/TestSuite_cryptodev_throughput.py=C2=A0 | 930 +++++++++----=
------<br>
=C2=A06 files changed, 523 insertions(+), 518 deletions(-)<br>
<br>
diff --git a/dts/api/cryptodev/__init__.py b/dts/api/cryptodev/__init__.py<=
br>
index 496079c2af..ffcfee4ac7 100644<br>
--- a/dts/api/cryptodev/__init__.py<br>
+++ b/dts/api/cryptodev/__init__.py<br>
@@ -78,6 +78,18 @@ def vector_directory(self) -&gt; PurePath:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return get_ctx().dpdk_build.remote_dpdk_t=
ree_path.joinpath(&quot;app/test-crypto-perf/data/&quot;)<br>
<br>
+=C2=A0 =C2=A0 def update_params(self, **app_params: Unpack[&quot;CryptoPmd=
ParamsDict&quot;]) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Update the app parameters.<b=
r>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 app_params: app parameters to pa=
ss to dpdk-test-crypto-perf application<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for k, v in app_params.items():<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if v is not None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._app_params[k=
] =3D (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self=
.vector_directory.joinpath(str(v)) if k =3D=3D &quot;test_file&quot; else v=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
=C2=A0 =C2=A0 =C2=A0def run_app(self, num_vfs: int =3D 1) -&gt; list[Crypto=
devResults]:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Run the cryptodev appli=
cation with the given app parameters.<br>
<br>
diff --git a/dts/api/cryptodev/config.py b/dts/api/cryptodev/config.py<br>
index 3420c2fe91..252d3237c8 100644<br>
--- a/dts/api/cryptodev/config.py<br>
+++ b/dts/api/cryptodev/config.py<br>
@@ -515,3 +515,50 @@ class CryptoPmdParams(EalParams):<br>
=C2=A0 =C2=A0 =C2=A0test_name: str | None =3D field(default=3DNone, metadat=
a=3DParams.long(&quot;test-name&quot;))<br>
=C2=A0 =C2=A0 =C2=A0tls_version: TLSVersion | None =3D field(default=3DNone=
, metadata=3DParams.long(&quot;tls-version&quot;))<br>
=C2=A0 =C2=A0 =C2=A0total_ops: int | None =3D field(default=3D100000, metad=
ata=3DParams.long(&quot;total-ops&quot;))<br>
+<br>
+<br>
+# Algorithm parameter mappings for automatic key/IV size determination<br>
+CIPHER_ALGORITHM_PARAMS =3D {<br>
+=C2=A0 =C2=A0 CipherAlgorithm.aes_cbc: {&quot;key_size&quot;: 16, &quot;iv=
_size&quot;: 16},<br>
+=C2=A0 =C2=A0 CipherAlgorithm.aes_ctr: {&quot;key_size&quot;: 16, &quot;iv=
_size&quot;: 16},<br>
+=C2=A0 =C2=A0 CipherAlgorithm.aes_gcm: {&quot;key_size&quot;: 16, &quot;iv=
_size&quot;: 16},<br>
+=C2=A0 =C2=A0 CipherAlgorithm.aes_ecb: {&quot;key_size&quot;: 16, &quot;iv=
_size&quot;: 16},<br>
+=C2=A0 =C2=A0 CipherAlgorithm.aes_f8: {&quot;key_size&quot;: 16, &quot;iv_=
size&quot;: 16},<br>
+=C2=A0 =C2=A0 CipherAlgorithm.aes_xts: {&quot;key_size&quot;: 16, &quot;iv=
_size&quot;: 16},<br>
+=C2=A0 =C2=A0 CipherAlgorithm.arc4: {&quot;key_size&quot;: 16, &quot;iv_si=
ze&quot;: 16},<br>
+=C2=A0 =C2=A0 CipherAlgorithm.null: {&quot;key_size&quot;: 16, &quot;iv_si=
ze&quot;: 16},<br>
+=C2=A0 =C2=A0 CipherAlgorithm.aes_docsisbpi: {&quot;key_size&quot;: 32, &q=
uot;iv_size&quot;: 16},<br>
+=C2=A0 =C2=A0 CipherAlgorithm.snow3g_uea2: {&quot;key_size&quot;: 16, &quo=
t;iv_size&quot;: 16},<br>
+=C2=A0 =C2=A0 CipherAlgorithm.zuc_eea3: {&quot;key_size&quot;: 16, &quot;i=
v_size&quot;: 16},<br>
+=C2=A0 =C2=A0 CipherAlgorithm.kasumi_f8: {&quot;key_size&quot;: 16, &quot;=
iv_size&quot;: 8},<br>
+=C2=A0 =C2=A0 CipherAlgorithm.three_des_cbc: {&quot;key_size&quot;: 8, &qu=
ot;iv_size&quot;: 8},<br>
+=C2=A0 =C2=A0 CipherAlgorithm.three_des_ecb: {&quot;key_size&quot;: 24, &q=
uot;iv_size&quot;: 8},<br>
+=C2=A0 =C2=A0 CipherAlgorithm.three_des_ctr: {&quot;key_size&quot;: 24, &q=
uot;iv_size&quot;: 8},<br>
+}<br>
+<br>
+AUTHENTICATION_ALGORITHM_PARAMS =3D {<br>
+=C2=A0 =C2=A0 AuthenticationAlgorithm.sha1: {&quot;key_size&quot;: 20, &qu=
ot;iv_size&quot;: 0, &quot;digest_size&quot;: 20},<br>
+=C2=A0 =C2=A0 AuthenticationAlgorithm.sha1_hmac: {&quot;key_size&quot;: 64=
, &quot;iv_size&quot;: 20, &quot;digest_size&quot;: 12},<br>
+=C2=A0 =C2=A0 AuthenticationAlgorithm.sha2_224: {&quot;key_size&quot;: 20,=
 &quot;iv_size&quot;: 0, &quot;digest_size&quot;: 20},<br>
+=C2=A0 =C2=A0 AuthenticationAlgorithm.sha2_224_hmac: {&quot;key_size&quot;=
: 20, &quot;iv_size&quot;: 0, &quot;digest_size&quot;: 20},<br>
+=C2=A0 =C2=A0 AuthenticationAlgorithm.sha2_256: {&quot;key_size&quot;: 64,=
 &quot;iv_size&quot;: 0, &quot;digest_size&quot;: 32},<br>
+=C2=A0 =C2=A0 AuthenticationAlgorithm.sha2_256_hmac: {&quot;key_size&quot;=
: 64, &quot;iv_size&quot;: 0, &quot;digest_size&quot;: 32},<br>
+=C2=A0 =C2=A0 AuthenticationAlgorithm.sha2_384: {&quot;key_size&quot;: 48,=
 &quot;iv_size&quot;: 0, &quot;digest_size&quot;: 48},<br>
+=C2=A0 =C2=A0 AuthenticationAlgorithm.sha2_384_hmac: {&quot;key_size&quot;=
: 48, &quot;iv_size&quot;: 0, &quot;digest_size&quot;: 48},<br>
+=C2=A0 =C2=A0 AuthenticationAlgorithm.sha2_512: {&quot;key_size&quot;: 64,=
 &quot;iv_size&quot;: 0, &quot;digest_size&quot;: 64},<br>
+=C2=A0 =C2=A0 AuthenticationAlgorithm.sha2_512_hmac: {&quot;key_size&quot;=
: 64, &quot;iv_size&quot;: 0, &quot;digest_size&quot;: 64},<br>
+=C2=A0 =C2=A0 AuthenticationAlgorithm.md5: {&quot;key_size&quot;: 16, &quo=
t;iv_size&quot;: 0, &quot;digest_size&quot;: 16},<br>
+=C2=A0 =C2=A0 AuthenticationAlgorithm.md5_hmac: {&quot;key_size&quot;: 16,=
 &quot;iv_size&quot;: 0, &quot;digest_size&quot;: 16},<br>
+=C2=A0 =C2=A0 AuthenticationAlgorithm.snow3g_uia2: {&quot;key_size&quot;: =
16, &quot;iv_size&quot;: 16, &quot;digest_size&quot;: 4},<br>
+=C2=A0 =C2=A0 AuthenticationAlgorithm.zuc_eia3: {&quot;key_size&quot;: 16,=
 &quot;iv_size&quot;: 16, &quot;digest_size&quot;: 4},<br>
+=C2=A0 =C2=A0 AuthenticationAlgorithm.kasumi_f9: {&quot;key_size&quot;: 16=
, &quot;iv_size&quot;: 0, &quot;digest_size&quot;: 4},<br>
+=C2=A0 =C2=A0 AuthenticationAlgorithm.aes_gmac: {&quot;key_size&quot;: 16,=
 &quot;iv_size&quot;: 16, &quot;digest_size&quot;: 16},<br>
+=C2=A0 =C2=A0 AuthenticationAlgorithm.aes_xcbc_mac: {&quot;key_size&quot;:=
 16, &quot;iv_size&quot;: 0, &quot;digest_size&quot;: 12},<br>
+=C2=A0 =C2=A0 AuthenticationAlgorithm.aes_cmac: {&quot;key_size&quot;: 16,=
 &quot;iv_size&quot;: 0, &quot;digest_size&quot;: 16},<br>
+=C2=A0 =C2=A0 AuthenticationAlgorithm.aes_cbc_mac: {&quot;key_size&quot;: =
16, &quot;iv_size&quot;: 0, &quot;digest_size&quot;: 16},<br>
+}<br>
+<br>
+AEAD_ALGORITHM_PARAMS =3D {<br>
+=C2=A0 =C2=A0 AeadAlgName.aes_gcm: {&quot;key_size&quot;: 16, &quot;iv_siz=
e&quot;: 12, &quot;aad_size&quot;: 16, &quot;digest_size&quot;: 16},<br>
+=C2=A0 =C2=A0 AeadAlgName.aes_ccm: {&quot;key_size&quot;: 16, &quot;iv_siz=
e&quot;: 11, &quot;aad_size&quot;: 16, &quot;digest_size&quot;: 16},<br>
+}<br>
diff --git a/dts/api/params/__init__.py b/dts/api/params/__init__.py<br>
index b5bae9dad9..04e2c0f386 100644<br>
--- a/dts/api/params/__init__.py<br>
+++ b/dts/api/params/__init__.py<br>
@@ -334,7 +334,7 @@ def _make_switch(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prefix =3D f&quot;{&#39;-&#39; if is_shor=
t else &#39;--&#39;}{&#39;no-&#39; if is_no else &#39;&#39;}&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0name =3D name.replace(&quot;_&quot;, &quo=
t;-&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D f&quot;{&#39; &#39; if is_short else=
 &#39;=3D&#39;}{value}&quot; if value else &quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D f&quot;{&#39; &#39; if is_short else=
 &#39;=3D&#39;}{value}&quot; if value or value =3D=3D 0 else &quot;&quot;<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return f&quot;{prefix}{name}{value}&quot;=
<br>
<br>
=C2=A0 =C2=A0 =C2=A0def __str__(self) -&gt; str:<br>
diff --git a/dts/configurations/nodes.example.yaml b/dts/configurations/nod=
es.example.yaml<br>
index 334de68f97..ccda20fb87 100644<br>
--- a/dts/configurations/nodes.example.yaml<br>
+++ b/dts/configurations/nodes.example.yaml<br>
@@ -9,7 +9,7 @@<br>
=C2=A0#=C2=A0 =C2=A0`crypto_device_type`:<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0Uncomment to run cryptodev tests; the device typ=
e of the DUT e.g. (crypto_qat, crypto_zuc,<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0crypto_aesni_mb); the complete list of device ty=
pes can be found here<br>
-#=C2=A0 =C2=A0 =C2=A0<a href=3D"https://doc.dpdk.org/guides-24.07/cryptode=
vs/overview.html" rel=3D"noreferrer" target=3D"_blank">https://doc.dpdk.org=
/guides-24.07/cryptodevs/overview.html</a><br>
+#=C2=A0 =C2=A0 =C2=A0<a href=3D"https://doc.dpdk.org/guides-26.07/cryptode=
vs/overview.html" rel=3D"noreferrer" target=3D"_blank">https://doc.dpdk.org=
/guides-26.07/cryptodevs/overview.html</a><br>
<br>
=C2=A0# Define a system under test node, having two network ports physicall=
y<br>
=C2=A0# connected to the corresponding ports in TG 1 (the peer node)<br>
diff --git a/dts/configurations/tests_config.example.yaml b/dts/configurati=
ons/tests_config.example.yaml<br>
index ce67385b0b..fe4bed2847 100644<br>
--- a/dts/configurations/tests_config.example.yaml<br>
+++ b/dts/configurations/tests_config.example.yaml<br>
@@ -2,10 +2,13 @@<br>
<br>
=C2=A0# Optional Fields:<br>
=C2=A0#=C2=A0 =C2=A0All fields are optional, uncomment a test suite to run =
it with a specific configuration.<br>
+#=C2=A0 =C2=A0cryptodev_throughput:<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0algorithms: <a href=3D"https://doc.dpdk.org/gu=
ides-26.07/cryptodevs/overview.html" rel=3D"noreferrer" target=3D"_blank">h=
ttps://doc.dpdk.org/guides-26.07/cryptodevs/overview.html</a><br>
<br>
=C2=A0# Define the custom test suite configurations<br>
=C2=A0hello_world:<br>
=C2=A0 =C2=A0msg: A custom hello world to you!<br>
+<br>
=C2=A0# single_core_forward_perf:<br>
=C2=A0#=C2=A0 =C2=A0test_parameters: # Add frame size / descriptor count co=
mbinations as needed<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0- frame_size: 64<br>
@@ -18,18 +21,51 @@ hello_world:<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0 =C2=A0num_descriptors: 1024<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0 =C2=A0expected_mpps: 1.0<br>
=C2=A0#=C2=A0 =C2=A0delta_tolerance: 0.05<br>
+<br>
=C2=A0# pmd_rss:<br>
=C2=A0#=C2=A0 =C2=A0NUM_QUEUES: 4<br>
=C2=A0#=C2=A0 =C2=A0ACTUAL_KEY_SIZE: 52<br>
=C2=A0#=C2=A0 =C2=A0ACTUAL_RETA_SIZE: 512<br>
+<br>
=C2=A0# cryptodev_throughput:<br>
=C2=A0#=C2=A0 =C2=A0delta_tolerance: 0.05<br>
-#=C2=A0 =C2=A0throughput_test_parameters:<br>
-#=C2=A0 =C2=A0 =C2=A0snow3g_uea2_snow3g_uia2: # Add the name of the test s=
uite you would like to run<br>
-#=C2=A0 =C2=A0 =C2=A0 - buff_size: 64<br>
-#=C2=A0 =C2=A0 =C2=A0 =C2=A0 Gbps: 2.0 # Set gigabits per second according=
 to your devices throughput for this given buffer size<br>
-#=C2=A0 =C2=A0 =C2=A0 - buff_size: 512<br>
-#=C2=A0 =C2=A0 =C2=A0 =C2=A0 Gbps: 20.0<br>
+#=C2=A0 =C2=A0test_combinations:<br>
+#=C2=A0 =C2=A0 =C2=A0- name: &quot;example cipher test&quot; # Add a name =
for this test config<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0cipher_algorithm: &quot;aes_cbc&quot; # See `a=
lgortihms` in `Optional Fields` for a complete list<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0virtual_device: &quot;crypto_openssl&quot; # u=
ncomment to run with a virtual device.<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0test_parameters:=C2=A0 # Buffer sizes and expe=
cted throughput, a default is used if not present<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- buff_size: 64<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Gbps: 1.5 # Set gigabits per sec=
ond for your devices throughput for this buffer size<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- buff_size: 512<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Gbps: 3.0<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- buff_size: 2048<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Gbps: 4.0<br>
+#=C2=A0 =C2=A0 =C2=A0- name: &quot;example authentication test&quot;<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0auth_algorithm: &quot;aes_cbc_mac&quot; # See =
`algortihms` in `Optional Fields` for a complete list<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0test_parameters:<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- buff_size: 64<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Gbps: 1.5<br>
+#=C2=A0 =C2=A0 =C2=A0- name: &quot;example cipher then auth test&quot;<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0ops: 30000000 # Specify total ops to use, 1000=
0000 is used by default<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0cipher_algorithm: &quot;aes_cbc&quot; # See `a=
lgortihms` in `Optional Fields` for a complete list<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0auth_algorithm: &quot;aes_cbc_mac&quot; # See =
`algortihms` in `Optional Fields` for a complete list<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0cipher_key_size: 16<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0cipher_iv_size: 0<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0auth_key_size: 16 # Specify key size, a defaul=
t is used if field is not present<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0auth_iv_size: 0 # Specify IV size, a default i=
s used if field is not present<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0test_parameters:<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- buff_size: 64<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Gbps: 1.5<br>
+#=C2=A0 =C2=A0 =C2=A0- name: &quot;example aead test&quot;<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0aead_algorithm: &quot;aes_gcm&quot; # See `alg=
ortihms` in `Optional Fields` for a complete list<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0aead_key_sz: 16<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0aead_iv_sz: 16<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0aead_aad_sz: 16 # Specify AAD size, a default =
is used if field not present<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0digest_sz: 16 # Specify a digest size, a defau=
lt is used if not present<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0test_parameters:<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- buff_size: 64<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Gbps: 1.5<br>
+<br>
=C2=A0# port_speed_capabilities:<br>
=C2=A0#=C2=A0 =C2=A0test_parameters:<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A00 : 100 Gbps # Assign an expected link speed to =
a port ID in Gbps<br>
diff --git a/dts/tests/TestSuite_cryptodev_throughput.py b/dts/tests/TestSu=
ite_cryptodev_throughput.py<br>
index 59f64f2cd7..d061ec02dc 100644<br>
--- a/dts/tests/TestSuite_cryptodev_throughput.py<br>
+++ b/dts/tests/TestSuite_cryptodev_throughput.py<br>
@@ -9,6 +9,8 @@<br>
=C2=A0ensure performance standards are met.<br>
=C2=A0&quot;&quot;&quot;<br>
<br>
+from typing import Any<br>
+<br>
=C2=A0from api.capabilities import (<br>
=C2=A0 =C2=A0 =C2=A0LinkTopology,<br>
=C2=A0 =C2=A0 =C2=A0requires_link_topology,<br>
@@ -16,6 +18,9 @@<br>
=C2=A0from api.context import get_ctx<br>
=C2=A0from api.cryptodev import Cryptodev<br>
=C2=A0from api.cryptodev.config import (<br>
+=C2=A0 =C2=A0 AEAD_ALGORITHM_PARAMS,<br>
+=C2=A0 =C2=A0 AUTHENTICATION_ALGORITHM_PARAMS,<br>
+=C2=A0 =C2=A0 CIPHER_ALGORITHM_PARAMS,<br>
=C2=A0 =C2=A0 =C2=A0AeadAlgName,<br>
=C2=A0 =C2=A0 =C2=A0AuthenticationAlgorithm,<br>
=C2=A0 =C2=A0 =C2=A0AuthenticationOpMode,<br>
@@ -30,7 +35,8 @@<br>
=C2=A0from api.cryptodev.types import (<br>
=C2=A0 =C2=A0 =C2=A0CryptodevResults,<br>
=C2=A0)<br>
-from api.test import skip, verify<br>
+from api.exception import ConfigurationError, SkippedTestException, TestCa=
seVerifyError<br>
+from api.test import fail, skip, verify<br>
=C2=A0from api.test_suite import BaseConfig, TestSuite, crypto_test<br>
=C2=A0from api.testbed_model.virtual_device import VirtualDevice<br>
<br>
@@ -40,37 +46,57 @@<br>
=C2=A0 =C2=A0 =C2=A0{&quot;buff_size&quot;: 2048, &quot;Gbps&quot;: 1.00},<=
br>
=C2=A0]<br>
<br>
-TOTAL_OPS =3D 10_000_000<br>
-<br>
<br>
=C2=A0class Config(BaseConfig):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Performance test metrics.<br>
<br>
=C2=A0 =C2=A0 =C2=A0Attributes:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0delta_tolerance: The allowed tolerance be=
low a given baseline.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 throughput_test_parameters: The test parameter=
s to use in the test suite.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 test_combinations: List of test combinations w=
ith cipher/auth algorithms and parameters.<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0delta_tolerance: float =3D 0.05<br>
-<br>
-=C2=A0 =C2=A0 throughput_test_parameters: dict[str, list[dict[str, int | f=
loat | str]]] =3D {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;aes_cbc&quot;: config_list,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;aes_cbc_sha1&quot;: config_list,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;aes_cbc_sha2&quot;: config_list,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;aes_cbc_sha2_digest_16&quot;: config_lis=
t,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;aead_aes_gcm&quot;: config_list,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;aes_docsisbpi&quot;: config_list,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;sha1_hmac&quot;: config_list,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;snow3g_uea2_snow3g_uia2&quot;: config_li=
st,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;zuc_eea3_zuc_eia3&quot;: config_list,<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;kasumi_f8_kasumi_f9&quot;: config_list,<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;open_ssl_vdev&quot;: config_list,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;aesni_mb_vdev&quot;: config_list,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;aesni_gcm_vdev&quot;: config_list,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;kasumi_vdev&quot;: config_list,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;zuc_vdev&quot;: config_list,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;snow3g_vdev&quot;: config_list,<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 test_combinations: list[dict[str, Any]] =3D [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 #: cipher only tests<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;name&quot;: &quot;aes-cbc =
(cipher only)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;cipher_algorithm&quot;: <a=
 href=3D"http://CipherAlgorithm.aes_cbc.name" rel=3D"noreferrer" target=3D"=
_blank">CipherAlgorithm.aes_cbc.name</a>,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;name&quot;: &quot;aead-doc=
sisbpi (cipher only)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;cipher_algorithm&quot;: <a=
 href=3D"http://CipherAlgorithm.aes_docsisbpi.name" rel=3D"noreferrer" targ=
et=3D"_blank">CipherAlgorithm.aes_docsisbpi.name</a>,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 #: authentication only tests<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;name&quot;: &quot;sha1-hma=
c (auth only)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;auth_algorithm&quot;: <a h=
ref=3D"http://AuthenticationAlgorithm.sha1_hmac.name" rel=3D"noreferrer" ta=
rget=3D"_blank">AuthenticationAlgorithm.sha1_hmac.name</a>,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;auth_iv_size&quot;: 16,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 #: cipher then auth tests<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;name&quot;: &quot;aes-cbc/=
sha1-hmac (cipher then auth)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;cipher_algorithm&quot;: <a=
 href=3D"http://CipherAlgorithm.aes_cbc.name" rel=3D"noreferrer" target=3D"=
_blank">CipherAlgorithm.aes_cbc.name</a>,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;auth_algorithm&quot;: <a h=
ref=3D"http://AuthenticationAlgorithm.sha1_hmac.name" rel=3D"noreferrer" ta=
rget=3D"_blank">AuthenticationAlgorithm.sha1_hmac.name</a>,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;virtual_device&quot;: &quo=
t;crypto_openssl&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;name&quot;: &quot;aes-cbc/=
sha2-256-hmac (cipher then auth)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;cipher_algorithm&quot;: <a=
 href=3D"http://CipherAlgorithm.aes_cbc.name" rel=3D"noreferrer" target=3D"=
_blank">CipherAlgorithm.aes_cbc.name</a>,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;auth_algorithm&quot;: <a h=
ref=3D"http://AuthenticationAlgorithm.sha2_256_hmac.name" rel=3D"noreferrer=
" target=3D"_blank">AuthenticationAlgorithm.sha2_256_hmac.name</a>,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;virtual_device&quot;: &quo=
t;crypto_openssl&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;name&quot;: &quot;aes-cbc/=
sha2-256-hmac/digest-16 (cipher then auth)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;cipher_algorithm&quot;: <a=
 href=3D"http://CipherAlgorithm.aes_cbc.name" rel=3D"noreferrer" target=3D"=
_blank">CipherAlgorithm.aes_cbc.name</a>,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;auth_algorithm&quot;: <a h=
ref=3D"http://AuthenticationAlgorithm.sha2_256_hmac.name" rel=3D"noreferrer=
" target=3D"_blank">AuthenticationAlgorithm.sha2_256_hmac.name</a>,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;digest_size&quot;: 16,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 #: aead tests<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;name&quot;: &quot;aead-aes=
-gcm&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;aead_algorithm&quot;: <a h=
ref=3D"http://AeadAlgName.aes_gcm.name" rel=3D"noreferrer" target=3D"_blank=
">AeadAlgName.aes_gcm.name</a>,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 ]<br>
<br>
<br>
=C2=A0@requires_link_topology(LinkTopology.NO_LINK)<br>
@@ -80,60 +106,137 @@ class TestCryptodevThroughput(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0config: Config<br>
<br>
=C2=A0 =C2=A0 =C2=A0def set_up_suite(self) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Set up the test suite.&quot;=
&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.throughput_test_parameters: dict[str, lis=
t[dict[str, int | float | str]]] =3D (<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.config.throughput_test_para=
meters<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Set up the test suite.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ConfigurationError: When a test =
config contains no algorithm to test.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.test_combinations: list[dict[str, Any]] =
=3D self.config.test_combinations<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.delta_tolerance: float =3D self.conf=
ig.delta_tolerance<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.ops: int =3D 10_000_000<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.device_type: DeviceType | None =3D g=
et_device_from_str(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0str(get_ctx().sut_node.cryp=
to_device_type)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.buffer_sizes =3D {}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.buffer_sizes: dict[str, ListWrapper] =3D =
{}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # categorize configured tests<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.cipher_tests: list[dict[str, Any]] =3D []=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.auth_tests: list[dict[str, Any]] =3D []<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.cipher_then_auth_tests: list[dict[str, An=
y]] =3D []<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.aead_tests: list[dict[str, Any]] =3D []<b=
r>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Filter tests by operation types<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for combination in self.test_combinations:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.buffer_sizes[combination[&q=
uot;name&quot;]] =3D ListWrapper(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [int(run[&quot;buf=
f_size&quot;]) for run in combination.get(&quot;test_parameters&quot;, conf=
ig_list)]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is_cipher =3D &quot;cipher_algor=
ithm&quot; in combination<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is_auth =3D &quot;auth_algorithm=
&quot; in combination<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aead =3D &quot;aead_algorithm&qu=
ot; in combination<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if is_cipher and is_auth:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.cipher_then_a=
uth_tests.append(combination)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif is_cipher:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.cipher_tests.=
append(combination)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif is_auth:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.auth_tests.ap=
pend(combination)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif aead:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.aead_tests.ap=
pend(combination)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise Configuratio=
nError(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;Each test instance must contain either &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;&#39;cipher_algorithm&#39;, &#39;auth_algorithm&#39;, or &#39;aead_algori=
thm&#39;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for k, v in self.throughput_test_parameters.it=
ems():<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.buffer_sizes[k] =3D ListWra=
pper([int(run[&quot;buff_size&quot;]) for run in v])<br>
+=C2=A0 =C2=A0 def _print_and_verify(self, all_results: list[list[dict[str,=
 int | float | str]]]) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Print the given results and =
verify all results have passed.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 all_results: a list of results t=
o print and verify.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for results in all_results:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if len(results) &gt; 0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._print_stats(=
test_vals=3Dresults)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for results in all_results:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for result in results:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 resu=
lt[&quot;passed&quot;] =3D=3D &quot;PASS&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Gbps fell below delta tolerance for test {result[&#39;Test Name&#39;]}&q=
uot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
<br>
=C2=A0 =C2=A0 =C2=A0def _print_stats(self, test_vals: list[dict[str, int | =
float | str]]) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Print the stats of the given=
 test values in a clean format.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_vals: the testing values to=
 print<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert len(test_vals) &gt; 0, &quot;test_vals =
must contain at least one element&quot;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0element_len =3D len(&quot;Delta Tolerance=
&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 border_len =3D (element_len + 1) * (len(test_v=
als[0]))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 border_len =3D (element_len + 1) * (len(test_v=
als[0]) - 1)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 test_name =3D test_vals[0][&quot;Test Name&quo=
t;]<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(f&quot;{&#39;Throughput Results&#39;.cen=
ter(border_len)}\n{&#39;=3D&#39; * border_len}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(f&quot;{f&#39;{test_name} Throughput Res=
ults&#39;.center(border_len)}\n{&#39;=3D&#39; * border_len}&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for k, v in test_vals[0].items():<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(f&quot;|{k.title():&lt;{el=
ement_len}}&quot;, end=3D&quot;&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if k !=3D &quot;Test Name&quot;:=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(f&quot;|{k.t=
itle():&lt;{element_len}}&quot;, end=3D&quot;&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print(f&quot;|\n{&#39;=3D&#39; * border_l=
en}&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for test_val in test_vals:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for k, v in test_val.items(=
):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(f&quot;|{v:&=
lt;{element_len}}&quot;, end=3D&quot;&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if k !=3D &quot;Te=
st Name&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prin=
t(f&quot;|{v:&lt;{element_len}}&quot;, end=3D&quot;&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print(f&quot;|\n{&#39;=3D&#=
39; * border_len}&quot;)<br>
<br>
-=C2=A0 =C2=A0 def _verify_throughput(<br>
+=C2=A0 =C2=A0 def _create_summary(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0results: list[CryptodevResults],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 key: str,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 params: list[dict],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 test_name: str,<br>
=C2=A0 =C2=A0 =C2=A0) -&gt; list[dict[str, int | float | str]]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Verify the throughput of the=
 given results against the supplied parameters.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 results: The results of the dpdk=
 crypto perf app ran in throughput mode.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 params: The baselines to compare=
 the given results to.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_name: The test name to pin =
to the result summary.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 A summary of throughput statisti=
cs for a test and whether the test passed.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RuntimeError: When there are no =
baselines for a given result.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0result_list: list[dict[str, int | float |=
 str]] =3D []<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for result in results:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# get the corresponding bas=
eline for the current buffer size<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parameters: dict[str, int | floa=
t | str] =3D list(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parameters: dict[str, int | floa=
t | str] =3D next(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0filter(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0lambda x: x[&quot;buff_size&quot;] =3D=3D result.buffer_size,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self=
.throughput_test_parameters[key],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )[0]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 para=
ms,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errmsg =3D (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;No test par=
ameters found for {test_name} with buffer size {result.buffer_size}&quot;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if parameters =3D=3D {}:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise RuntimeError=
(errmsg)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_result =3D True<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0expected_gbps =3D parameter=
s[&quot;Gbps&quot;]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0measured_delta =3D abs(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0round((getatt=
r(result, &quot;gbps&quot;) - expected_gbps) / expected_gbps, 5)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# result did not meet the g=
iven Gbps parameter, check if within delta.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if getattr(result, &quot;gb=
ps&quot;) &lt; expected_gbps:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.delta=
_tolerance &lt; measured_delta:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0test_result =3D False<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0result_list.append(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quo=
t;Test Name&quot;: test_name,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&quot;Buffer Size&quot;: parameters[&quot;buff_size&quot;],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&quot;Gbps delta&quot;: measured_delta,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&quot;delta tolerance&quot;: self.delta_tolerance,<br>
@@ -145,502 +248,309 @@ def _verify_throughput(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return result_list<br>
<br>
=C2=A0 =C2=A0 =C2=A0@crypto_test<br>
-=C2=A0 =C2=A0 def aes_cbc(self) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;aes_cbc test.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Create a cryptodev instance wi=
th provided device type and buffer sizes.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The resulting Gbps is greater =
than expected_gbps*(1-delta_tolerance).<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;aes_cbc&quot; not in self.throughput_=
test_parameters:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 skip(&quot;test not configured&q=
uot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 app =3D Cryptodev(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ptest=3DTestType.throughput,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devtype=3Dself.device_type,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optype=3DOperationType.cipher_on=
ly,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_algo=3DCipherAlgorithm.ae=
s_cbc,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_op=3DEncryptDecryptSwitch=
.encrypt,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_key_sz=3D16,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_iv_sz=3D16,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 total_ops=3DTOTAL_OPS,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buffer_sz=3Dself.buffer_sizes[&q=
uot;aes_cbc&quot;],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 results =3D self._verify_throughput(app.run_ap=
p(), &quot;aes_cbc&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._print_stats(results)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for result in results:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(result[&quot;passed&quot;=
] =3D=3D &quot;PASS&quot;, &quot;Gbps fell below delta tolerance&quot;)<br>
-<br>
-=C2=A0 =C2=A0 @crypto_test<br>
-=C2=A0 =C2=A0 def aes_cbc_sha1(self) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;aes_cbc_sha1 test.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Create a cryptodev instance wi=
th provided device type and buffer sizes.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The resulting Gbps is greater =
than expected_gbps*(1-delta_tolerance).<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;aes_cbc_sha1&quot; not in self.throug=
hput_test_parameters:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 skip(&quot;test not configured&q=
uot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 app =3D Cryptodev(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ptest=3DTestType.throughput,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devtype=3Dself.device_type,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optype=3DOperationType.cipher_th=
en_auth,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_algo=3DCipherAlgorithm.ae=
s_cbc,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_op=3DEncryptDecryptSwitch=
.encrypt,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_key_sz=3D16,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_iv_sz=3D16,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_algo=3DAuthenticationAlgori=
thm.sha1_hmac,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_op=3DAuthenticationOpMode.g=
enerate,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_key_sz=3D64,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_iv_sz=3D20,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 digest_sz=3D12,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 total_ops=3DTOTAL_OPS,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buffer_sz=3Dself.buffer_sizes[&q=
uot;aes_cbc_sha1&quot;],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 results =3D self._verify_throughput(app.run_ap=
p(), &quot;aes_cbc_sha1&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._print_stats(results)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for result in results:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(result[&quot;passed&quot;=
] =3D=3D &quot;PASS&quot;, &quot;Gbps fell below delta tolerance&quot;)<br>
-<br>
-=C2=A0 =C2=A0 @crypto_test<br>
-=C2=A0 =C2=A0 def aes_cbc_sha2(self) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;aes_cbc_sha2 test.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Create a cryptodev instance wi=
th provided device type and buffer sizes.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The resulting Gbps is greater =
than expected_gbps*(1-delta_tolerance).<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;aes_cbc_sha2&quot; not in self.throug=
hput_test_parameters:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 skip(&quot;test not configured&q=
uot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 app =3D Cryptodev(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ptest=3DTestType.throughput,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devtype=3Dself.device_type,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optype=3DOperationType.cipher_th=
en_auth,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_algo=3DCipherAlgorithm.ae=
s_cbc,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_op=3DEncryptDecryptSwitch=
.encrypt,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_key_sz=3D16,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_iv_sz=3D16,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_algo=3DAuthenticationAlgori=
thm.sha2_256_hmac,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_op=3DAuthenticationOpMode.g=
enerate,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_key_sz=3D64,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 digest_sz=3D32,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 total_ops=3DTOTAL_OPS,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buffer_sz=3Dself.buffer_sizes[&q=
uot;aes_cbc_sha2&quot;],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 results =3D self._verify_throughput(app.run_ap=
p(), &quot;aes_cbc_sha2&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._print_stats(results)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for result in results:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(result[&quot;passed&quot;=
] =3D=3D &quot;PASS&quot;, &quot;Gbps fell below delta tolerance&quot;)<br>
-<br>
-=C2=A0 =C2=A0 @crypto_test<br>
-=C2=A0 =C2=A0 def aes_cbc_sha2_digest_16(self) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;aes_cbc_sha2_digest_16 test.=
<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Create a cryptodev instance wi=
th provided device type and buffer sizes.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The resulting Gbps is greater =
than expected_gbps*(1-delta_tolerance).<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;aes_cbc_sha2_digest_16&quot; not in s=
elf.throughput_test_parameters:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 skip(&quot;test not configured&q=
uot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 app =3D Cryptodev(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ptest=3DTestType.throughput,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devtype=3Dself.device_type,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optype=3DOperationType.cipher_th=
en_auth,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_algo=3DCipherAlgorithm.ae=
s_cbc,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_op=3DEncryptDecryptSwitch=
.encrypt,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_key_sz=3D16,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_iv_sz=3D16,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_algo=3DAuthenticationAlgori=
thm.sha2_256_hmac,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_op=3DAuthenticationOpMode.g=
enerate,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_key_sz=3D64,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 digest_sz=3D16,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 total_ops=3DTOTAL_OPS,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buffer_sz=3Dself.buffer_sizes[&q=
uot;aes_cbc_sha2_digest_16&quot;],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 results =3D self._verify_throughput(app.run_ap=
p(), &quot;aes_cbc_sha2_digest_16&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._print_stats(results)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for result in results:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(result[&quot;passed&quot;=
] =3D=3D &quot;PASS&quot;, &quot;Gbps fell below delta tolerance&quot;)<br>
-<br>
-=C2=A0 =C2=A0 @crypto_test<br>
-=C2=A0 =C2=A0 def aead_aes_gcm(self) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;aead_aes_gcm test.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Create a cryptodev instance wi=
th provided device type and buffer sizes.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The resulting Gbps is greater =
than expected_gbps*(1-delta_tolerance).<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;aead_aes_gcm&quot; not in self.throug=
hput_test_parameters:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 skip(&quot;test not configured&q=
uot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 app =3D Cryptodev(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ptest=3DTestType.throughput,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devtype=3Dself.device_type,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optype=3DOperationType.aead,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aead_algo=3DAeadAlgName.aes_gcm,=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aead_op=3DEncryptDecryptSwitch.e=
ncrypt,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aead_key_sz=3D16,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aead_iv_sz=3D12,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aead_aad_sz=3D16,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 digest_sz=3D16,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 total_ops=3DTOTAL_OPS,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buffer_sz=3Dself.buffer_sizes[&q=
uot;aead_aes_gcm&quot;],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 results =3D self._verify_throughput(app.run_ap=
p(), &quot;aead_aes_gcm&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._print_stats(results)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for result in results:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(result[&quot;passed&quot;=
] =3D=3D &quot;PASS&quot;, &quot;Gbps fell below delta tolerance&quot;)<br>
-<br>
-=C2=A0 =C2=A0 @crypto_test<br>
-=C2=A0 =C2=A0 def aes_docsisbpi(self) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;aes_docsisbpi test.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Create a cryptodev instance wi=
th provided device type and buffer sizes.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The resulting Gbps is greater =
than expected_gbps*(1-delta_tolerance).<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;aes_docsisbpi&quot; not in self.throu=
ghput_test_parameters:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 skip(&quot;test not configured&q=
uot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 app =3D Cryptodev(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ptest=3DTestType.throughput,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devtype=3Dself.device_type,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optype=3DOperationType.cipher_on=
ly,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_algo=3DCipherAlgorithm.ae=
s_docsisbpi,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_op=3DEncryptDecryptSwitch=
.encrypt,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_key_sz=3D32,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_iv_sz=3D16,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 total_ops=3DTOTAL_OPS,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buffer_sz=3Dself.buffer_sizes[&q=
uot;aes_docsisbpi&quot;],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 results =3D self._verify_throughput(app.run_ap=
p(), &quot;aes_docsisbpi&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._print_stats(results)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for result in results:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(result[&quot;passed&quot;=
] =3D=3D &quot;PASS&quot;, &quot;Gbps fell below delta tolerance&quot;)<br>
-<br>
-=C2=A0 =C2=A0 @crypto_test<br>
-=C2=A0 =C2=A0 def sha1_hmac(self) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;sha1_hmac test.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Create a cryptodev instance wi=
th provided device type and buffer sizes.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The resulting Gbps is greater =
than expected_gbps*(1-delta_tolerance).<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;sha1_hmac&quot; not in self.throughpu=
t_test_parameters:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 skip(&quot;test not configured&q=
uot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 app =3D Cryptodev(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ptest=3DTestType.throughput,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devtype=3Dself.device_type,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optype=3DOperationType.auth_only=
,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_algo=3DAuthenticationAlgori=
thm.sha1_hmac,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_op=3DAuthenticationOpMode.g=
enerate,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_key_sz=3D64,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_iv_sz=3D16,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 digest_sz=3D12,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 total_ops=3DTOTAL_OPS,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buffer_sz=3Dself.buffer_sizes[&q=
uot;sha1_hmac&quot;],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 results =3D self._verify_throughput(app.run_ap=
p(), &quot;sha1_hmac&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._print_stats(results)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for result in results:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(result[&quot;passed&quot;=
] =3D=3D &quot;PASS&quot;, &quot;Gbps fell below delta tolerance&quot;)<br>
-<br>
-=C2=A0 =C2=A0 @crypto_test<br>
-=C2=A0 =C2=A0 def snow3g_uea2_snow3g_uia2(self) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;snow3g_uea2_snow3g_uia2 test=
.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Create a cryptodev instance wi=
th provided device type and buffer sizes.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The resulting Gbps is greater =
than expected_gbps*(1-delta_tolerance).<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;snow3g_uea2_snow3g_uia2&quot; not in =
self.throughput_test_parameters:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 skip(&quot;test not configured&q=
uot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 app =3D Cryptodev(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ptest=3DTestType.throughput,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devtype=3Dself.device_type,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optype=3DOperationType.cipher_th=
en_auth,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_algo=3DCipherAlgorithm.sn=
ow3g_uea2,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_op=3DEncryptDecryptSwitch=
.encrypt,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_key_sz=3D16,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_iv_sz=3D16,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_algo=3DAuthenticationAlgori=
thm.snow3g_uia2,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_op=3DAuthenticationOpMode.g=
enerate,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_key_sz=3D16,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_iv_sz=3D16,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 digest_sz=3D4,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 total_ops=3DTOTAL_OPS,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buffer_sz=3Dself.buffer_sizes[&q=
uot;snow3g_uea2_snow3g_uia2&quot;],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 results =3D self._verify_throughput(app.run_ap=
p(), &quot;snow3g_uea2_snow3g_uia2&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._print_stats(results)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for result in results:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(result[&quot;passed&quot;=
] =3D=3D &quot;PASS&quot;, &quot;Gbps fell below delta tolerance&quot;)<br>
-<br>
-=C2=A0 =C2=A0 @crypto_test<br>
-=C2=A0 =C2=A0 def zuc_eea3_zuc_eia3(self) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;zuc_eea3_zuc_eia3 test.<br>
+=C2=A0 =C2=A0 def cipher_only_tests(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Cipher only cryptography dev=
ice tests.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Steps:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Create a cryptodev instance wi=
th provided device type and buffer sizes.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Run dpdk-test-crypto-perf appl=
ication with configured arguments in cipher only mode.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Verify:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The resulting Gbps is greater =
than expected_gbps*(1-delta_tolerance).<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The reported Gbps is within a =
defined tolerance of a given baseline.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;zuc_eea3_zuc_eia3&quot; not in self.t=
hroughput_test_parameters:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 skip(&quot;test not configured&q=
uot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 app =3D Cryptodev(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ptest=3DTestType.throughput,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devtype=3Dself.device_type,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optype=3DOperationType.cipher_th=
en_auth,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_algo=3DCipherAlgorithm.zu=
c_eea3,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_op=3DEncryptDecryptSwitch=
.encrypt,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_key_sz=3D16,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_iv_sz=3D16,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_algo=3DAuthenticationAlgori=
thm.zuc_eia3,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_op=3DAuthenticationOpMode.g=
enerate,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_key_sz=3D16,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_iv_sz=3D16,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 digest_sz=3D4,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 total_ops=3DTOTAL_OPS,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buffer_sz=3Dself.buffer_sizes[&q=
uot;zuc_eea3_zuc_eia3&quot;],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 results =3D self._verify_throughput(app.run_ap=
p(), &quot;zuc_eea3_zuc_eia3&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._print_stats(results)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for result in results:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(result[&quot;passed&quot;=
] =3D=3D &quot;PASS&quot;, &quot;Gbps fell below delta tolerance&quot;)<br>
<br>
-=C2=A0 =C2=A0 @crypto_test<br>
-=C2=A0 =C2=A0 def kasumi_f8_kasumi_f9(self) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;kasumi_f8 kasumi_f9 test.<br=
>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Create a cryptodev instance wi=
th provided device type and buffer sizes.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The resulting Gbps is greater =
than expected_gbps*(1-delta_tolerance).<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;kasumi_f8_kasumi_f9&quot; not in self=
.throughput_test_parameters:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 skip(&quot;test not configured&q=
uot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 app =3D Cryptodev(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ptest=3DTestType.throughput,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devtype=3Dself.device_type,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optype=3DOperationType.cipher_th=
en_auth,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_algo=3DCipherAlgorithm.ka=
sumi_f8,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_op=3DEncryptDecryptSwitch=
.encrypt,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_key_sz=3D16,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_iv_sz=3D8,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_algo=3DAuthenticationAlgori=
thm.kasumi_f9,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_op=3DAuthenticationOpMode.g=
enerate,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_key_sz=3D16,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 digest_sz=3D4,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 burst_sz=3D32,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 total_ops=3DTOTAL_OPS,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buffer_sz=3Dself.buffer_sizes[&q=
uot;kasumi_f8_kasumi_f9&quot;],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 results =3D self._verify_throughput(app.run_ap=
p(), &quot;kasumi_f8_kasumi_f9&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._print_stats(results)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for result in results:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(result[&quot;passed&quot;=
] =3D=3D &quot;PASS&quot;, &quot;Gbps fell below delta tolerance&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 def test(encrypt: EncryptDecryptSwitch) -&gt; =
list[dict[str, int | float | str]]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Run a configur=
ed throughput test with the given encryption.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 encrypt: The ciphe=
r encryption mode to run throughput testing on.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 The generated summ=
ary or an empty list if a test is skipped.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_params =3D CIPHER_ALGORIT=
HM_PARAMS[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CipherAlgorithm[co=
mbination[&quot;cipher_algorithm&quot;]]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is_vdev =3D &quot;virtual_device=
&quot; in combination<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 app =3D Cryptodev(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ptest=3DTestType.t=
hroughput,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devtype=3Dself.dev=
ice_type,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optype=3DOperation=
Type.cipher_only,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_algo=3DCiph=
erAlgorithm[combination[&quot;cipher_algorithm&quot;]],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_op=3Dencryp=
t,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_key_sz=3Dco=
mbination.get(&quot;cipher_key_size&quot;, cipher_params[&quot;key_size&quo=
t;]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_iv_sz=3Dcom=
bination.get(&quot;cipher_iv_size&quot;, cipher_params[&quot;iv_size&quot;]=
),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 digest_sz=3Dcombin=
ation.get(&quot;digest_size&quot;, 0),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 total_ops=3Dcombin=
ation.get(&quot;ops&quot;, self.ops),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buffer_sz=3Dself.b=
uffer_sizes[combination.get(&quot;name&quot;, &quot;custom_test&quot;)],<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if is_vdev:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 app.update_params(=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vdev=
s=3D[VirtualDevice(combination[&quot;virtual_device&quot;])],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devt=
ype=3Dget_device_from_str(combination[&quot;virtual_device&quot;]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
<br>
-=C2=A0 =C2=A0 # BEGIN VDEV TESTS<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._<a href=3D"http://logger.i=
nfo" rel=3D"noreferrer" target=3D"_blank">logger.info</a>(f&quot;Running co=
nfigured test: {test_name} in {encrypt} mode&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return self._creat=
e_summary(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 resu=
lts=3Dapp.run_app(num_vfs=3D0 if is_vdev else 1),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 para=
ms=3Dcombination.get(&quot;test_parameters&quot;, config_list),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test=
_name=3Df&quot;{combination.get(&#39;name&#39;, &#39;unnamed-test&#39;)} - =
{encrypt}&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # A skip on one test will stop t=
he execution of all tests, return empty summary.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 except SkippedTestException as e=
:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.error=
(f&quot;test {test_name} skipped: {str(e)}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return []<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 test_cases_skipped: int =3D 0<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 failed: bool =3D False<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 reason: str =3D &quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Execute all cipher only tests and verify<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for combination in self.cipher_tests:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_name =3D combination.get(&q=
uot;name&quot;, &quot;unnamed_test&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 combination_results =3D [(test(m=
ode)) for mode in EncryptDecryptSwitch]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if all(result =3D=3D [] for resu=
lt in combination_results):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_cases_skipped=
 +=3D 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self=
._print_and_verify(combination_results)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 except TestCaseVer=
ifyError as e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fail=
ed =3D True<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reas=
on =3D f&quot;{reason}\n{str(e)}&quot; if reason else str(e)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if failed:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fail(reason)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if test_cases_skipped =3D=3D len(self.cipher_t=
ests):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 skip(&quot;All configured test c=
ases skipped.&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0@crypto_test<br>
-=C2=A0 =C2=A0 def aesni_mb_vdev(self) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;aesni_mb virtual device test=
.<br>
+=C2=A0 =C2=A0 def auth_only_tests(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Authentication cryptography =
device tests.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Steps:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Create a cryptodev instance wi=
th crypto_aesni_mb and supplied buffer sizes.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Run dpdk-test-crypto-perf appl=
ication with configured parameters in authentication<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 only moode.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Verify:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The resulting Gbps is greater =
than expected_gbps*(1-delta_tolerance).<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The resulting Gbps is within a=
 delta tolerance of a provided baseline.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;aesni_mb_vdev&quot; not in self.throu=
ghput_test_parameters:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 skip(&quot;test not configured&q=
uot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 app =3D Cryptodev(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ptest=3DTestType.throughput,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vdevs=3D[VirtualDevice(&quot;cry=
pto_aesni_mb0&quot;)],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devtype=3DDeviceType.crypto_aesn=
i_mb,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optype=3DOperationType.cipher_th=
en_auth,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_algo=3DCipherAlgorithm.ae=
s_cbc,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_op=3DEncryptDecryptSwitch=
.encrypt,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_key_sz=3D32,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_iv_sz=3D16,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_algo=3DAuthenticationAlgori=
thm.sha1_hmac,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_op=3DAuthenticationOpMode.g=
enerate,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_key_sz=3D16,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_iv_sz=3D16,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 digest_sz=3D4,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 burst_sz=3D32,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 total_ops=3DTOTAL_OPS,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buffer_sz=3Dself.buffer_sizes[&q=
uot;aesni_mb_vdev&quot;],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 results =3D self._verify_throughput(app.run_ap=
p(num_vfs=3D0), &quot;aesni_mb_vdev&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._print_stats(results)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for result in results:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(result[&quot;passed&quot;=
] =3D=3D &quot;PASS&quot;, &quot;Gbps fell below delta tolerance&quot;)<br>
<br>
-=C2=A0 =C2=A0 @crypto_test<br>
-=C2=A0 =C2=A0 def aesni_gcm_vdev(self):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;aesni_gcm virtual device tes=
t.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 def test(op_mode: AuthenticationOpMode) -&gt; =
list[dict[str, int | float | str]]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Run a configur=
ed throughput test with the given authentication mode.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 op_mode: The authe=
ntication op mode to run testing in.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 The generated summ=
ary or an empty list if a test is skipped.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_params =3D AUTHENTICATION_A=
LGORITHM_PARAMS[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AuthenticationAlgo=
rithm[combination[&quot;auth_algorithm&quot;]]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is_vdev: bool =3D &quot;virtual_=
device&quot; in combination<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 app =3D Cryptodev(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ptest=3DTestType.t=
hroughput,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devtype=3Dself.dev=
ice_type,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optype=3DOperation=
Type.auth_only,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_algo=3DAuthen=
ticationAlgorithm[combination[&quot;auth_algorithm&quot;]],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_op=3Dop_mode,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_key_sz=3Dcomb=
ination.get(&quot;auth_key_size&quot;, auth_params[&quot;key_size&quot;]),<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_iv_sz=3Dcombi=
nation.get(&quot;auth_iv_size&quot;, auth_params[&quot;iv_size&quot;]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 total_ops=3Dcombin=
ation.get(&quot;ops&quot;, self.ops),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 digest_sz=3Dcombin=
ation.get(&quot;digest_size&quot;, 0),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buffer_sz=3Dself.b=
uffer_sizes[combination[&quot;name&quot;]],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if is_vdev:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 app.update_params(=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vdev=
s=3D[VirtualDevice(combination[&quot;virtual_device&quot;])],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devt=
ype=3Dget_device_from_str(combination[&quot;virtual_device&quot;]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Create a cryptodev instance wi=
th crypto_aesni_gcm and supplied buffer sizes.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The resulting Gbps is greater =
than expected_gbps*(1-delta_tolerance).<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;aesni_gcm_vdev&quot; not in self.thro=
ughput_test_parameters:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 skip(&quot;test not configured&q=
uot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 app =3D Cryptodev(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ptest=3DTestType.throughput,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vdevs=3D[VirtualDevice(&quot;cry=
pto_aesni_gcm0&quot;)],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devtype=3DDeviceType.crypto_aesn=
i_gcm,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optype=3DOperationType.aead,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aead_algo=3DAeadAlgName.aes_gcm,=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aead_op=3DEncryptDecryptSwitch.e=
ncrypt,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aead_key_sz=3D16,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aead_iv_sz=3D12,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aead_aad_sz=3D16,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 digest_sz=3D16,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 total_ops=3DTOTAL_OPS,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buffer_sz=3Dself.buffer_sizes[&q=
uot;aesni_gcm_vdev&quot;],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 results =3D self._verify_throughput(app.run_ap=
p(num_vfs=3D0), &quot;aesni_gcm_vdev&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._print_stats(results)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for result in results:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(result[&quot;passed&quot;=
] =3D=3D &quot;PASS&quot;, &quot;Gbps fell below delta tolerance&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._<a href=3D"http://logger.i=
nfo" rel=3D"noreferrer" target=3D"_blank">logger.info</a>(f&quot;Running co=
nfigured test: {test_name} in {op_mode} mode&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return self._creat=
e_summary(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 resu=
lts=3Dapp.run_app(num_vfs=3D0 if is_vdev else 1),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 para=
ms=3Dcombination.get(&quot;test_parameters&quot;, config_list),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test=
_name=3Df&quot;{combination.get(&#39;name&#39;, &#39;unnamed-test&#39;)} - =
{op_mode}&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # A skip on one test will stop t=
he execution of all tests, return empty summary.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 except SkippedTestException as e=
:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.error=
(f&quot;failed to run test {test_name}: {str(e)}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return []<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 test_cases_skipped: int =3D 0<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 failed: bool =3D False<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 reason: str =3D &quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Execute all auth only tests and verify<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for combination in self.auth_tests:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_name =3D combination.get(&q=
uot;name&quot;, &quot;unnamed_test&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 combination_results =3D [(test(A=
uthenticationOpMode.generate))]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if all(result =3D=3D [] for resu=
lt in combination_results):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_cases_skipped=
 +=3D 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self=
._print_and_verify(combination_results)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 except TestCaseVer=
ifyError as e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fail=
ed =3D True<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reas=
on =3D f&quot;{reason}\n{str(e)}&quot; if reason else str(e)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if failed:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fail(reason)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if test_cases_skipped =3D=3D len(self.auth_tes=
ts):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 skip(&quot;All configured test c=
ases skipped.&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0@crypto_test<br>
-=C2=A0 =C2=A0 def kasumi_vdev(self) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Kasmumi virtual device test.=
<br>
+=C2=A0 =C2=A0 def aead_test(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Aead cryptography test.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Steps:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Create a cryptodev instance wi=
th crypto_kasumi and supplied buffer sizes.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Run dpdk-test-crypto-perf appl=
ication with configured parameters in aead mode.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Verify:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The resulting Gbps is greater =
than expected_gbps*(1-delta_tolerance).<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The resulting Gbps is within a=
 delta tolerance of a given baseline.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;kasumi_vdev&quot; not in self.through=
put_test_parameters:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 skip(&quot;test not configured&q=
uot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 app =3D Cryptodev(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vdevs=3D[VirtualDevice(&quot;cry=
pto_kasumi0&quot;)],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ptest=3DTestType.throughput,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devtype=3DDeviceType.crypto_kasu=
mi,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optype=3DOperationType.cipher_th=
en_auth,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_algo=3DCipherAlgorithm.ka=
sumi_f8,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_op=3DEncryptDecryptSwitch=
.encrypt,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_key_sz=3D16,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_iv_sz=3D8,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_algo=3DAuthenticationAlgori=
thm.kasumi_f9,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_op=3DAuthenticationOpMode.g=
enerate,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_key_sz=3D16,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 digest_sz=3D4,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 burst_sz=3D32,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 total_ops=3DTOTAL_OPS,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buffer_sz=3Dself.buffer_sizes[&q=
uot;kasumi_vdev&quot;],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 results =3D self._verify_throughput(app.run_ap=
p(num_vfs=3D0), &quot;kasumi_vdev&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._print_stats(results)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for result in results:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(result[&quot;passed&quot;=
] =3D=3D &quot;PASS&quot;, &quot;Gbps fell below delta tolerance&quot;)<br>
<br>
-=C2=A0 =C2=A0 @crypto_test<br>
-=C2=A0 =C2=A0 def snow3g_vdev(self) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;snow3g virtual device test.<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 def test() -&gt; list[dict[str, int | float | =
str]]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Execute the dp=
dk-test-crypto application and verify.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 encrypt: The authe=
ntication operation mode to run the cryptodev application in.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 The generated summ=
ary or an empty list if a test is skipped.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is_vdev: bool =3D &quot;virtual_=
device&quot; in combination<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aead_params =3D AEAD_ALGORITHM_P=
ARAMS[AeadAlgName[combination[&quot;aead_algorithm&quot;]]]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 app =3D Cryptodev(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ptest=3DTestType.t=
hroughput,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devtype=3Dself.dev=
ice_type,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optype=3DOperation=
Type.aead,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aead_algo=3DAeadAl=
gName[combination[&quot;aead_algorithm&quot;]],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aead_op=3Dcombinat=
ion.get(&quot;aead_op&quot;, EncryptDecryptSwitch.encrypt),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aead_key_sz=3Dcomb=
ination.get(&quot;aead_key_size&quot;, aead_params[&quot;key_size&quot;]),<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aead_iv_sz=3Dcombi=
nation.get(&quot;aead_iv_size&quot;, aead_params[&quot;iv_size&quot;]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aead_aad_sz=3Dcomb=
ination.get(&quot;aead_size&quot;, aead_params[&quot;aad_size&quot;]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 digest_sz=3Dcombin=
ation.get(&quot;digest_size&quot;, aead_params[&quot;digest_size&quot;]),<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 total_ops=3Dcombin=
ation.get(&quot;ops&quot;, self.ops),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buffer_sz=3Dself.b=
uffer_sizes[combination[&quot;name&quot;]],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if is_vdev:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 app.update_params(=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vdev=
s=3D[VirtualDevice(combination[&quot;virtual_device&quot;])],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devt=
ype=3Dget_device_from_str(combination[&quot;virtual_device&quot;]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if combination.get(&quot;aead_op=
&quot;, None) =3D=3D EncryptDecryptSwitch.decrypt:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 app.update_params(=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 out_=
of_place=3Dcombination.get(&quot;out_of_place&quot;, True),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Create a cryptodev instance wi=
th crypto_snow3g and supplied buffer sizes.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The resulting Gbps is greater =
than expected_gbps*(1-delta_tolerance).<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;snow3g_vdev&quot; not in self.through=
put_test_parameters:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 skip(&quot;test not configured&q=
uot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 app =3D Cryptodev(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ptest=3DTestType.throughput,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vdevs=3D[VirtualDevice(&quot;cry=
pto_snow3g0&quot;)],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devtype=3DDeviceType.crypto_snow=
3g,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optype=3DOperationType.cipher_th=
en_auth,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_algo=3DCipherAlgorithm.sn=
ow3g_uea2,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_op=3DEncryptDecryptSwitch=
.encrypt,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_key_sz=3D16,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_iv_sz=3D16,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_algo=3DAuthenticationAlgori=
thm.snow3g_uia2,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_op=3DAuthenticationOpMode.g=
enerate,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_key_sz=3D16,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_iv_sz=3D16,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 digest_sz=3D4,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 burst_sz=3D32,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 total_ops=3DTOTAL_OPS,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buffer_sz=3Dself.buffer_sizes[&q=
uot;snow3g_vdev&quot;],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 results =3D self._verify_throughput(app.run_ap=
p(num_vfs=3D0), &quot;snow3g_vdev&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._print_stats(results)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for result in results:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(result[&quot;passed&quot;=
] =3D=3D &quot;PASS&quot;, &quot;Gbps fell below delta tolerance&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._<a href=3D"http://logger.i=
nfo" rel=3D"noreferrer" target=3D"_blank">logger.info</a>(f&quot;Running co=
nfigured test: {test_name}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return self._creat=
e_summary(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 resu=
lts=3Dapp.run_app(num_vfs=3D0 if is_vdev else 1),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 para=
ms=3Dcombination.get(&quot;test_parameters&quot;, config_list),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test=
_name=3Df&quot;{combination.get(&#39;name&#39;, &#39;unnamed-test&#39;)}&qu=
ot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Exceptions will stop the execu=
tion of all tests, return an empty result and continue.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 except SkippedTestException as e=
:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.error=
(f&quot;failed to run test {test_name}: {str(e)}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return []<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 test_cases_skipped: int =3D 0<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 failed: bool =3D False<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 reason: str =3D &quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Execute all aead tests and verify<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for combination in self.aead_tests:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_name =3D combination.get(&q=
uot;name&quot;, &quot;unnamed_test&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 combination_results =3D [test()]=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if all(result =3D=3D [] for resu=
lt in combination_results):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_cases_skipped=
 +=3D 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self=
._print_and_verify(combination_results)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 except TestCaseVer=
ifyError as e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fail=
ed =3D True<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reas=
on =3D f&quot;{reason}\n{str(e)}&quot; if reason else str(e)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if failed:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fail(reason)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if test_cases_skipped =3D=3D len(self.aead_tes=
ts):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 skip(&quot;All configured test c=
ases skipped.&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0@crypto_test<br>
-=C2=A0 =C2=A0 def zuc_vdev(self) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Zuc virtual device test.<br>
+=C2=A0 =C2=A0 def cipher_and_auth_tests(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Cipher and Authentication te=
sts.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Steps:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Create a cryptodev instance wi=
th crypto_zuc and supplied buffer sizes.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Run dpdk-test-crypto-perf appl=
ication in cipher then authentication mode<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Verify:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The resulting Gbps is greater =
than expected_gbps*(1-delta_tolerance).<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The resulting Gbps is within a=
 delta tolerance of a given baseline.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;zuc_vdev&quot; not in self.throughput=
_test_parameters:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 skip(&quot;test not configured&q=
uot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 app =3D Cryptodev(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ptest=3DTestType.throughput,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vdevs=3D[VirtualDevice(&quot;cry=
pto_zuc0&quot;)],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devtype=3DDeviceType.crypto_zuc,=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optype=3DOperationType.cipher_th=
en_auth,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_algo=3DCipherAlgorithm.zu=
c_eea3,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_op=3DEncryptDecryptSwitch=
.encrypt,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_key_sz=3D16,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_iv_sz=3D16,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_algo=3DAuthenticationAlgori=
thm.zuc_eia3,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_op=3DAuthenticationOpMode.g=
enerate,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_key_sz=3D16,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_iv_sz=3D16,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 digest_sz=3D4,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 burst_sz=3D32,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 total_ops=3DTOTAL_OPS,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buffer_sz=3Dself.buffer_sizes[&q=
uot;zuc_vdev&quot;],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 results =3D self._verify_throughput(app.run_ap=
p(num_vfs=3D0), &quot;zuc_vdev&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._print_stats(results)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for result in results:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(result[&quot;passed&quot;=
] =3D=3D &quot;PASS&quot;, &quot;Gbps fell below delta tolerance&quot;)<br>
-<br>
-=C2=A0 =C2=A0 @crypto_test<br>
-=C2=A0 =C2=A0 def open_ssl_vdev(self) -&gt; None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;open_ssl virtual device test=
.<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Create a cryptodev instance wi=
th provided device type and buffer sizes.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The resulting Gbps is greater =
than expected_gbps*(1-delta_tolerance).<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;open_ssl_vdev&quot; not in self.throu=
ghput_test_parameters:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 skip(&quot;test not configured&q=
uot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 app =3D Cryptodev(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ptest=3DTestType.throughput,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vdevs=3D[VirtualDevice(&quot;cry=
pto_openssl0&quot;)],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devtype=3DDeviceType.crypto_open=
ssl,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optype=3DOperationType.aead,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aead_algo=3DAeadAlgName.aes_gcm,=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aead_op=3DEncryptDecryptSwitch.e=
ncrypt,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aead_key_sz=3D16,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aead_iv_sz=3D16,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aead_aad_sz=3D16,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 digest_sz=3D16,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 total_ops=3DTOTAL_OPS,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buffer_sz=3Dself.buffer_sizes[&q=
uot;open_ssl_vdev&quot;],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 results =3D self._verify_throughput(app.run_ap=
p(num_vfs=3D0), &quot;open_ssl_vdev&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._print_stats(results)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for result in results:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result[&quot;passe=
d&quot;] =3D=3D &quot;PASS&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Gbps fell be=
low delta tolerance&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 def test(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 encrypt: EncryptDecryptSwitch, o=
p_mode: AuthenticationOpMode<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ) -&gt; list[dict[str, int | float | str]]:<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Execute the dp=
dk-test-crypto application and verify.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 encrypt: The ciphe=
r encryption mode to run throughput testing in.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 op_mode: The authe=
ntication operation mode to run the cryptodev application in.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 The generated summ=
ary or an empty list if a test is skipped.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is_vdev: bool =3D &quot;virtual_=
device&quot; in combination<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_params =3D CIPHER_ALGORIT=
HM_PARAMS[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CipherAlgorithm[co=
mbination[&quot;cipher_algorithm&quot;]]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_params =3D AUTHENTICATION_A=
LGORITHM_PARAMS[<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AuthenticationAlgo=
rithm[combination[&quot;auth_algorithm&quot;]]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 app =3D Cryptodev(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ptest=3DTestType.t=
hroughput,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devtype=3Dself.dev=
ice_type,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optype=3DOperation=
Type.aead,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_algo=3DCiph=
erAlgorithm[combination[&quot;cipher_algorithm&quot;]],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_op=3Dencryp=
t,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_key_sz=3Dco=
mbination.get(&quot;cipher_key_size&quot;, cipher_params[&quot;key_size&quo=
t;]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_iv_sz=3Dcom=
bination.get(&quot;cipher_iv_size&quot;, cipher_params[&quot;iv_size&quot;]=
),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_algo=3DAuthen=
ticationAlgorithm[combination[&quot;auth_algorithm&quot;]],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_op=3Dop_mode,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_key_sz=3Dcomb=
ination.get(&quot;auth_key_size&quot;, auth_params[&quot;key_size&quot;]),<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_iv_sz=3Dcombi=
nation.get(&quot;auth_iv_size&quot;, auth_params[&quot;iv_size&quot;]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 total_ops=3Dcombin=
ation.get(&quot;ops&quot;, self.ops),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 digest_sz=3Dcombin=
ation.get(&quot;digest_size&quot;, 0),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buffer_sz=3Dself.b=
uffer_sizes[combination[&quot;name&quot;]],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if is_vdev:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 app.update_params(=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vdev=
s=3D[VirtualDevice(combination[&quot;virtual_device&quot;])],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devt=
ype=3Dget_device_from_str(combination[&quot;virtual_device&quot;]),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._<a href=3D"http://logger.i=
nfo" rel=3D"noreferrer" target=3D"_blank">logger.info</a>(f&quot;Running co=
nfigured test: {test_name} in {encrypt} mode&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return self._creat=
e_summary(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 resu=
lts=3Dapp.run_app(num_vfs=3D0 if is_vdev else 1),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 para=
ms=3Dcombination.get(&quot;test_parameters&quot;, config_list),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test=
_name=3Df&quot;{combination.get(&#39;name&#39;, &#39;unnamed-test&#39;)} - =
{encrypt}&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Exceptions will stop the execu=
tion of all tests, return an empty result and continue.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 except SkippedTestException as e=
:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.error=
(f&quot;failed to run test {test_name}: {str(e)}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return []<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 test_cases_skipped: int =3D 0<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 failed: bool =3D False<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 reason: str =3D &quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Execute all cipher_then_auth tests and verif=
y<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for combination in self.cipher_then_auth_tests=
:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_name =3D combination.get(&q=
uot;name&quot;, &quot;unnamed_test&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 combination_results =3D [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test(mode, Authent=
icationOpMode.generate) for mode in EncryptDecryptSwitch<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if all(result =3D=3D [] for resu=
lt in combination_results):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_cases_skipped=
 +=3D 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self=
._print_and_verify(combination_results)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 except TestCaseVer=
ifyError as e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fail=
ed =3D True<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reas=
on =3D f&quot;{reason}\n{str(e)}&quot; if reason else str(e)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if failed:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fail(reason)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if test_cases_skipped =3D=3D len(self.cipher_t=
hen_auth_tests):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 skip(&quot;All configured test c=
ases skipped.&quot;)<br>
-- <br>
2.55.0<br>
<br>
</blockquote></div>

--000000000000109e66065ed29a2a--
