Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015D6CDE00C
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 14:17:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 27A0D40430;
	Thu, 25 Jun 2026 16:17:26 +0200 (CEST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com
 [209.85.208.175])
 by mails.dpdk.org (Postfix) with ESMTP id 1FE65402B0
 for <dev@dpdk.org>; Thu, 25 Jun 2026 16:17:24 +0200 (CEST)
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-39ad400e762so3134081fa.1
 for <dev@dpdk.org>; Thu, 25 Jun 2026 07:17:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782397043; cv=none;
 d=google.com; s=arc-20260327;
 b=mcd8pBdVTXhgPQlM+I0Sl8o22Q+h1jPmJYSAfubqBzqAlATVv876KnoJY0qyXJKvR+
 ico1gLo35t1S/cEGklcw2xWLWzKXXoPeonq5R0KPAm2hisI8PCHpkgw5lDigt4mNCVQY
 h6S8GFB/SieU8nIR9n9jOZ0y/JseknJPeByidwc7u+iKxba8yLzfaFc1cAvqCmV84NpF
 bdp0+T3Auc04Ox4jLcbTYZrE0+H7mX3lSRGJkrkUZYXcAt9+bvQhWdUfRmfB9dI1AVA5
 4e5ofXLzRpCGN1Js8yFyc7Ki8qFWKr1HBpkaJ7N1YOw1J6H6xjz0if4Cr5zt6NFCSUeh
 UB3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=p+6zg5zCiuFlaruEy1JtJLrIx+RqS3IS/8qO04/Kt7o=;
 fh=Er2H/6Jm0BuHSa/CyK20oHtgps9lOGcIPHeWesYW83M=;
 b=AP3rs/AYN6ZahRNtLgDHy+EwF8N9kmM61+M2K6R5P3e4Ak9hXt18e/UhylEljuLPrv
 hRB6uCigyyvzbdV1JgOMa1Z1uiAOnA0KpQEkiEzCi7MXZnkzaiYVW6EQvwjIZI1IVlP7
 qK+pAmBqw0jtby8DFtfnQQc/7tnN5oUJC2BXY3P6X5If18X32fxYViBqysDHalC2vphX
 42K0hEpPHuyLb6JuRLoH3W/BRzMxTpCp+qetTqB9DFbOfgsF6efD1C3vLeJid9MPpJJA
 QSXMuiy/Ah9zwyGKvQQp8Ou670cfGMU2omvs/euXgff998JlcIC0nQyf6/033ke/wR3e
 PHNw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782397043; x=1783001843; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p+6zg5zCiuFlaruEy1JtJLrIx+RqS3IS/8qO04/Kt7o=;
 b=FJfcumavxsJ97dsGaiHOhyQgNe/1HxnBLAVVtawjwCnJ7opJtueQcM7Afj9ijrRWSl
 UgxaLxaWotRbKLUGMXPJdYWLDsIvH/91dokjcQRhnPhjmo6dzLP3p/7V9fu0xZNbwYQY
 HrTb5RbCfUBmSol2xzW8p6a5mHboWFUnzA5qnn+IuDV5QAP8nN3SJ0XApz5oVYQHWlQX
 Vbb9f111mvctUluEs9u7/2uWeur79OL9J2WzZH0xjZ0lKVA54EfVkSZkFhxbicjLWjdJ
 PJF3ojJmgdGKe1aiEg2WpdxCR3c/5Yoicjg1bi+l0zL0McKOmFbmW/X3LNpP6Jb7ON7x
 kzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782397043; x=1783001843;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p+6zg5zCiuFlaruEy1JtJLrIx+RqS3IS/8qO04/Kt7o=;
 b=KJ1puGonHndYdabyN5NblamD45FYQIbVR0XoxutcwEMZ4+TwT3PMqIXnQsBW4CyrGl
 ws5TDFKqP5lZ1chq1YN4Ya2tXhP7QdlZyyAX7pCyeohBCi+3M9TVawXEWJ3FIB6ru1H/
 cvDx2+fNlFbaddtDF6gseh2ysbm5AFPz5oKeDlJztd3O2eSwJGZGXKfTyEX3qsZmYfVF
 fUjjc6FO7wK9ukeXjsHlm+p13L4kFITb0g7XoEPSlwd8ze8mcVhPWkhj8XLUz/htpDHS
 wHj5I8b2YORXH2ByFKxP9OW88xQnoat/Wn6PQkhczpZaaDcrYFNe9tfA4VTXNE1XT6ce
 C2eg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp5HT5z1tysMhxWpQwTLdGGZqCMGMq4OA/3gp2K58G+uV89GrNbbhYu4aO7LiWR+Xn1DQU=@dpdk.org
X-Gm-Message-State: AOJu0YwDqVtZxgdRei6q1Od/Rei8Uz/K3O3hJu5K95FbchSdsyO5/jvG
 kp5K5ysQJx2gYQ/vHNbMVyXSu+3QP0f5t7HxLRnyojc3FdcP7im8B40PgfZnRuYQ/p1igR23ItJ
 +FwbXiSq9IWitQPi8oODa8v/UCCAxRXo=
X-Gm-Gg: AfdE7cnQuwx2NJoJxDAWHOJDMBoMW5TfGGM59iAP0xs2SuN7LQZGZuKFqI7ROWG2ZZi
 tiuglY3xrinVOn369xd+zujLc7cjcSr7suNVbYkNNQiP7MYkE0nlv+laB5qOamjg1bqX9hw/rQt
 G+qRG6yGgWtjF1PA4uq8WxCdjvu1Az5IzdFPp9O7J3qsEflTjOqc/j7khlLYGiuaisSpSH8ifgr
 ombjmtl3qQTcNNtFSb5uo8MZHdazP8vTvfZC1LSfSQ0sv+Wl2n+YiJHPD5QfpTVMBYABq6Prw6T
 6VQ99EMwOHtD+wNV9tNaVHuAni3c9I0gusUYhAIUVurdougCJp9Gds+vgqS8fs8ZnXA=
X-Received: by 2002:a2e:9c99:0:b0:396:8588:d5a9 with SMTP id
 38308e7fff4ca-39acb63fe66mr6089541fa.11.1782397043011; Thu, 25 Jun 2026
 07:17:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260428181501.72434-1-abailey@iol.unh.edu>
 <20260513152715.133381-1-abailey@iol.unh.edu>
 <20260513152715.133381-2-abailey@iol.unh.edu>
In-Reply-To: <20260513152715.133381-2-abailey@iol.unh.edu>
From: Patrick Robb <patrickrobb1997@gmail.com>
Date: Thu, 25 Jun 2026 10:17:09 -0400
X-Gm-Features: AVVi8CdB5iZ8qZ89E_93AjWuQupHqx04fSSA8jVuOBdmCu243CFSyMqyud_Wzmk
Message-ID: <CAK6DuxtFFp30YOXCe50KUCw_8cHoH0B+A2tHXohy9Qd3AotrpA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] dts: add latency coverage for cryptodev testing
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, lylavoie@iol.unh.edu, 
 ahassick@iol.unh.edu, knimoji@iol.unh.edu
Content-Type: multipart/alternative; boundary="00000000000098f3ae065514a6ac"
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

--00000000000098f3ae065514a6ac
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 11:27=E2=80=AFAM Andrew Bailey <abailey@iol.unh.edu=
> wrote:

> Currently, next DTS only has cryptodev testing coverage for throughput
> metrics. This patch adds a test suite to include latency testing for
> crypto devices.
>
> Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
> ---
>  .../dts/tests.TestSuite_cryptodev_latency.rst |   8 +
>  dts/tests/TestSuite_cryptodev_latency.py      | 695 ++++++++++++++++++
>  2 files changed, 703 insertions(+)
>  create mode 100644 doc/api/dts/tests.TestSuite_cryptodev_latency.rst
>  create mode 100644 dts/tests/TestSuite_cryptodev_latency.py
>
>
> +    @crypto_test
> +    def aesni_gcm_vdev(self) -> None:
> +        """aesni_gcm virtual device latency test.
> +
> +        Steps:
> +            * Create a cryptodev instance with provided device type and
> buffer sizes.
> +        Verify:
> +            * The latency is below or within delta of provided baseline.
> +
> +        Raises:
> +            SkippedTestException: When configuration is not provided.
> +        """
> +        if "aesni_gcm_vdev" not in self.latency_test_parameters:
> +            skip("test not configured")
> +        app =3D Cryptodev(
> +            ptest=3DTestType.latency,
> +            vdevs=3D[VirtualDevice("crypto_aesni_gcm0")],
> +            devtype=3DDeviceType.crypto_aesni_gcm,
> +            optype=3DOperationType.aead,
> +            aead_op=3DEncryptDecryptSwitch.encrypt,
> +            aead_key_sz=3D16,
> +            aead_iv_sz=3D12,
> +            aead_aad_sz=3D16,
> +            digest_sz=3D16,
> +            burst_sz=3D32,
> +            total_ops=3DTOTAL_OPS,
> +            buffer_sz=3Dself.buffer_sizes["aesni_gcm_vdev"],
> +        )
> +        results =3D self._verify_latency(app.run_app(), "aesni_gcm_vdev"=
)
> +        self._print_stats(results)
> +        for result in results:
> +            verify(result["passed"] =3D=3D "PASS", "latency fell more th=
an
> the delta tolerance")
>

Why this one does not have "below baseline" in the string like other verify
assertions in this suite?


> +
> +    @crypto_test
> +    def aesni_mb_cipher_then_auth_vdev(self) -> None:
> +        """aesni_mb vdev cipher and auth latency test.
> +
> +        Steps:
> +            * Create a cryptodev instance with provided device type and
> buffer sizes.
> +        Verify:
> +            * The latency is below or within delta of provided baseline.
> +
> +        Raises:
> +            SkippedTestException: When configuration is not provided.
> +        """
> +        if "aesni_mb_cipher_then_auth_vdev" not in
> self.latency_test_parameters:
> +            skip("test not configured")
> +        app =3D Cryptodev(
> +            ptest=3DTestType.latency,
> +            vdevs=3D[VirtualDevice("crypto_aesni_mb0")],
> +            devtype=3DDeviceType.crypto_aesni_mb,
> +            optype=3DOperationType.cipher_then_auth,
> +            cipher_algo=3DCipherAlgorithm.aes_cbc,
> +            cipher_op=3DEncryptDecryptSwitch.encrypt,
> +            cipher_key_sz=3D16,
> +            auth_algo=3DAuthenticationAlgorithm.sha1_hmac,
> +            auth_op=3DAuthenticationOpMode.generate,
> +            auth_key_sz=3D64,
> +            digest_sz=3D12,
> +            burst_sz=3D32,
> +            total_ops=3DTOTAL_OPS,
> +            buffer_sz=3Dself.buffer_sizes["aesni_mb_cipher_then_auth_vde=
v"],
> +        )
> +        results =3D self._verify_latency(app.run_app(),
> "aesni_mb_cipher_then_auth_vdev")
> +        self._print_stats(results)
> +        for result in results:
> +            verify(
> +                result["passed"] =3D=3D "PASS",
> +                "latency fell more than the delta tolerance below
> baseline",
> +            )
> +
> +    @crypto_test
> +    def aesni_mb_vdev(self) -> None:
> +        """aesni_mb vdev latency test.
> +
> +        Steps:
> +            * Create a cryptodev instance with provided device type and
> buffer sizes.
> +        Verify:
> +            * The latency is below or within delta of provided baseline.
> +
> +        Raises:
> +            SkippedTestException: When configuration is not provided.
> +        """
> +        if "aesni_mb_vdev" not in self.latency_test_parameters:
> +            skip("test not configured")
> +        app =3D Cryptodev(
> +            ptest=3DTestType.latency,
> +            vdevs=3D[VirtualDevice("crypto_aesni_mb0")],
> +            devtype=3DDeviceType.crypto_aesni_mb,
> +            optype=3DOperationType.cipher_only,
> +            cipher_algo=3DCipherAlgorithm.aes_cbc,
> +            cipher_op=3DEncryptDecryptSwitch.encrypt,
> +            cipher_key_sz=3D16,
> +            cipher_iv_sz=3D16,
> +            burst_sz=3D32,
> +            total_ops=3DTOTAL_OPS,
> +            buffer_sz=3Dself.buffer_sizes["aesni_mb_vdev"],
> +        )
> +        results =3D self._verify_latency(app.run_app(), "aesni_mb_vdev")
> +        self._print_stats(results)
> +        for result in results:
> +            verify(result["passed"] =3D=3D "PASS", "Gbps fell below delt=
a
> tolerance")
> +
> +    @crypto_test
> +    def kasumi_vdev(self) -> None:
> +        """Kasumi vdev latency test.
> +
> +        Steps:
> +            * Create a cryptodev instance with provided device type and
> buffer sizes.
> +        Verify:
> +            * The latency is below or within delta of provided baseline.
> +
> +        Raises:
> +            SkippedTestException: When configuration is not provided.
> +        """
> +        if "kasumi_vdev" not in self.latency_test_parameters:
> +            skip("test not configured")
> +        app =3D Cryptodev(
> +            ptest=3DTestType.latency,
> +            vdevs=3D[VirtualDevice("crypto_kasumi0")],
> +            devtype=3DDeviceType.crypto_kasumi,
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
> +            total_ops=3DTOTAL_OPS,
> +            buffer_sz=3Dself.buffer_sizes["kasumi_vdev"],
> +        )
> +        results =3D self._verify_latency(app.run_app(), "kasmui_vdev")
> +        self._print_stats(results)
> +        for result in results:
> +            verify(result["passed"] =3D=3D "PASS", "Gbps fell below delt=
a
> tolerance")
>

Should this be latency instead of Gbps?


> +
> +    @crypto_test
> +    def open_ssl_vdev(self) -> None:
> +        """open_ssl vdev latency test.
> +
> +        Steps:
> +            * Create a cryptodev instance with provided device type and
> buffer sizes.
> +        Verify:
> +            * The latency is below or within delta of provided baseline.
> +
> +        Raises:
> +            SkippedTestException: When configuration is not provided.
> +        """
> +        if "open_ssl_vdev" not in self.latency_test_parameters:
> +            skip("test not configured")
> +        app =3D Cryptodev(
> +            ptest=3DTestType.latency,
> +            vdevs=3D[VirtualDevice("crypto_openssl0")],
> +            devtype=3DDeviceType.crypto_openssl,
> +            optype=3DOperationType.aead,
> +            aead_algo=3DAeadAlgName.aes_gcm,
> +            aead_op=3DEncryptDecryptSwitch.encrypt,
> +            aead_key_sz=3D16,
> +            aead_iv_sz=3D16,
> +            aead_aad_sz=3D16,
> +            digest_sz=3D16,
> +            total_ops=3DTOTAL_OPS,
> +            buffer_sz=3Dself.buffer_sizes["open_ssl_vdev"],
> +        )
> +        results =3D self._verify_latency(app.run_app(), "open_ssl_vdev")
> +        self._print_stats(results)
> +        for result in results:
> +            verify(result["passed"] =3D=3D "PASS", "Gbps fell below delt=
a
> tolerance")
>
Same


> +
> +    @crypto_test
> +    def snow3g_vdev(self) -> None:
> +        """snow3g vdev latency test.
> +
> +        Steps:
> +            * Create a cryptodev instance with provided device type and
> buffer sizes.
> +        Verify:
> +            * The latency is below or within delta of provided baseline.
> +
> +        Raises:
> +            SkippedTestException: When configuration is not provided.
> +        """
> +        if "snow3g_vdev" not in self.latency_test_parameters:
> +            skip("test not configured")
> +        app =3D Cryptodev(
> +            ptest=3DTestType.latency,
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
> +            digest_sz=3D16,
> +            burst_sz=3D32,
> +            total_ops=3DTOTAL_OPS,
> +            buffer_sz=3Dself.buffer_sizes["open_ssl_vdev"],
> +        )
> +        results =3D self._verify_latency(app.run_app(), "open_ssl_vdev")
> +        self._print_stats(results)
> +        for result in results:
> +            verify(result["passed"] =3D=3D "PASS", "Gbps fell below delt=
a
> tolerance")
>
Same


> +
> +    @crypto_test
> +    def zuc_vdev(self) -> None:
> +        """Zuc vdev latency test.
> +
> +        Steps:
> +            * Create a cryptodev instance with provided device type and
> buffer sizes.
> +        Verify:
> +            * The latency is below or within delta of provided baseline.
> +
> +        Raises:
> +            SkippedTestException: When configuration is not provided.
> +        """
> +        if "zuc_vdev" not in self.latency_test_parameters:
> +            skip("test not configured")
> +        app =3D Cryptodev(
> +            ptest=3DTestType.latency,
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
> +            total_ops=3DTOTAL_OPS,
> +            buffer_sz=3Dself.buffer_sizes["zuc_vdev"],
> +        )
> +        results =3D self._verify_latency(app.run_app(), "zuc_vdev")
> +        self._print_stats(results)
> +        for result in results:
> +            verify(result["passed"] =3D=3D "PASS", "Gbps fell below delt=
a
> tolerance")
>

Same

> --
> 2.50.1
>
>
Make sure you also see the ai code review mention of kasumi and snow3g typo
or misassignment
https://mails.dpdk.org/archives/test-report/2026-May/990932.html

The suggestions about safety when reading index 0 of a list are worth
implementing too.

Reviewed-by: Patrick Robb <patrickrobb1997@gmail.com>

--00000000000098f3ae065514a6ac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></d=
iv><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On =
Wed, May 13, 2026 at 11:27=E2=80=AFAM Andrew Bailey &lt;<a href=3D"mailto:a=
bailey@iol.unh.edu" target=3D"_blank">abailey@iol.unh.edu</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">Currently, next DT=
S only has cryptodev testing coverage for throughput<br>
metrics. This patch adds a test suite to include latency testing for<br>
crypto devices.<br>
<br>
Signed-off-by: Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.unh.edu" tar=
get=3D"_blank">abailey@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0.../dts/tests.TestSuite_cryptodev_latency.rst |=C2=A0 =C2=A08 +<br>
=C2=A0dts/tests/TestSuite_cryptodev_latency.py=C2=A0 =C2=A0 =C2=A0 | 695 ++=
++++++++++++++++<br>
=C2=A02 files changed, 703 insertions(+)<br>
=C2=A0create mode 100644 doc/api/dts/tests.TestSuite_cryptodev_latency.rst<=
br>
=C2=A0create mode 100644 dts/tests/TestSuite_cryptodev_latency.py<br>
<br><br>
+=C2=A0 =C2=A0 @crypto_test<br>
+=C2=A0 =C2=A0 def aesni_gcm_vdev(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;aesni_gcm virtual device lat=
ency test.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Create a cryptodev instance wi=
th provided device type and buffer sizes.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The latency is below or within=
 delta of provided baseline.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SkippedTestException: When confi=
guration is not provided.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;aesni_gcm_vdev&quot; not in self.late=
ncy_test_parameters:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 skip(&quot;test not configured&q=
uot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 app =3D Cryptodev(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ptest=3DTestType.latency,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vdevs=3D[VirtualDevice(&quot;cry=
pto_aesni_gcm0&quot;)],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devtype=3DDeviceType.crypto_aesn=
i_gcm,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optype=3DOperationType.aead,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aead_op=3DEncryptDecryptSwitch.e=
ncrypt,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aead_key_sz=3D16,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aead_iv_sz=3D12,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aead_aad_sz=3D16,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 digest_sz=3D16,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 burst_sz=3D32,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 total_ops=3DTOTAL_OPS,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buffer_sz=3Dself.buffer_sizes[&q=
uot;aesni_gcm_vdev&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 results =3D self._verify_latency(app.run_app()=
, &quot;aesni_gcm_vdev&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._print_stats(results)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for result in results:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(result[&quot;passed&quot;=
] =3D=3D &quot;PASS&quot;, &quot;latency fell more than the delta tolerance=
&quot;)<br></blockquote><div><br></div><div>Why this one does not have &quo=
t;below baseline&quot; in the string like other verify assertions in this s=
uite?</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
+<br>
+=C2=A0 =C2=A0 @crypto_test<br>
+=C2=A0 =C2=A0 def aesni_mb_cipher_then_auth_vdev(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;aesni_mb vdev cipher and aut=
h latency test.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Create a cryptodev instance wi=
th provided device type and buffer sizes.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The latency is below or within=
 delta of provided baseline.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SkippedTestException: When confi=
guration is not provided.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;aesni_mb_cipher_then_auth_vdev&quot; =
not in self.latency_test_parameters:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 skip(&quot;test not configured&q=
uot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 app =3D Cryptodev(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ptest=3DTestType.latency,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vdevs=3D[VirtualDevice(&quot;cry=
pto_aesni_mb0&quot;)],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devtype=3DDeviceType.crypto_aesn=
i_mb,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optype=3DOperationType.cipher_th=
en_auth,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_algo=3DCipherAlgorithm.ae=
s_cbc,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_op=3DEncryptDecryptSwitch=
.encrypt,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_key_sz=3D16,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_algo=3DAuthenticationAlgori=
thm.sha1_hmac,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_op=3DAuthenticationOpMode.g=
enerate,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_key_sz=3D64,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 digest_sz=3D12,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 burst_sz=3D32,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 total_ops=3DTOTAL_OPS,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buffer_sz=3Dself.buffer_sizes[&q=
uot;aesni_mb_cipher_then_auth_vdev&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 results =3D self._verify_latency(app.run_app()=
, &quot;aesni_mb_cipher_then_auth_vdev&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._print_stats(results)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for result in results:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result[&quot;passe=
d&quot;] =3D=3D &quot;PASS&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;latency fell=
 more than the delta tolerance below baseline&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 @crypto_test<br>
+=C2=A0 =C2=A0 def aesni_mb_vdev(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;aesni_mb vdev latency test.<=
br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Create a cryptodev instance wi=
th provided device type and buffer sizes.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The latency is below or within=
 delta of provided baseline.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SkippedTestException: When confi=
guration is not provided.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;aesni_mb_vdev&quot; not in self.laten=
cy_test_parameters:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 skip(&quot;test not configured&q=
uot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 app =3D Cryptodev(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ptest=3DTestType.latency,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vdevs=3D[VirtualDevice(&quot;cry=
pto_aesni_mb0&quot;)],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devtype=3DDeviceType.crypto_aesn=
i_mb,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optype=3DOperationType.cipher_on=
ly,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_algo=3DCipherAlgorithm.ae=
s_cbc,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_op=3DEncryptDecryptSwitch=
.encrypt,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_key_sz=3D16,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cipher_iv_sz=3D16,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 burst_sz=3D32,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 total_ops=3DTOTAL_OPS,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buffer_sz=3Dself.buffer_sizes[&q=
uot;aesni_mb_vdev&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 results =3D self._verify_latency(app.run_app()=
, &quot;aesni_mb_vdev&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._print_stats(results)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for result in results:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(result[&quot;passed&quot;=
] =3D=3D &quot;PASS&quot;, &quot;Gbps fell below delta tolerance&quot;)<br>
+<br>
+=C2=A0 =C2=A0 @crypto_test<br>
+=C2=A0 =C2=A0 def kasumi_vdev(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Kasumi vdev latency test.<br=
>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Create a cryptodev instance wi=
th provided device type and buffer sizes.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The latency is below or within=
 delta of provided baseline.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SkippedTestException: When confi=
guration is not provided.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;kasumi_vdev&quot; not in self.latency=
_test_parameters:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 skip(&quot;test not configured&q=
uot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 app =3D Cryptodev(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ptest=3DTestType.latency,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vdevs=3D[VirtualDevice(&quot;cry=
pto_kasumi0&quot;)],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devtype=3DDeviceType.crypto_kasu=
mi,<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 burst_sz=3D32,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 total_ops=3DTOTAL_OPS,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buffer_sz=3Dself.buffer_sizes[&q=
uot;kasumi_vdev&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 results =3D self._verify_latency(app.run_app()=
, &quot;kasmui_vdev&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._print_stats(results)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for result in results:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(result[&quot;passed&quot;=
] =3D=3D &quot;PASS&quot;, &quot;Gbps fell below delta tolerance&quot;)<br>=
</blockquote><div><br></div><div>Should this be latency instead of Gbps?</d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 @crypto_test<br>
+=C2=A0 =C2=A0 def open_ssl_vdev(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;open_ssl vdev latency test.<=
br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Create a cryptodev instance wi=
th provided device type and buffer sizes.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The latency is below or within=
 delta of provided baseline.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SkippedTestException: When confi=
guration is not provided.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;open_ssl_vdev&quot; not in self.laten=
cy_test_parameters:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 skip(&quot;test not configured&q=
uot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 app =3D Cryptodev(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ptest=3DTestType.latency,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vdevs=3D[VirtualDevice(&quot;cry=
pto_openssl0&quot;)],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devtype=3DDeviceType.crypto_open=
ssl,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optype=3DOperationType.aead,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aead_algo=3DAeadAlgName.aes_gcm,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aead_op=3DEncryptDecryptSwitch.e=
ncrypt,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aead_key_sz=3D16,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aead_iv_sz=3D16,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aead_aad_sz=3D16,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 digest_sz=3D16,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 total_ops=3DTOTAL_OPS,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buffer_sz=3Dself.buffer_sizes[&q=
uot;open_ssl_vdev&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 results =3D self._verify_latency(app.run_app()=
, &quot;open_ssl_vdev&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._print_stats(results)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for result in results:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(result[&quot;passed&quot;=
] =3D=3D &quot;PASS&quot;, &quot;Gbps fell below delta tolerance&quot;)<br>=
</blockquote><div>Same</div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 @crypto_test<br>
+=C2=A0 =C2=A0 def snow3g_vdev(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;snow3g vdev latency test.<br=
>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Create a cryptodev instance wi=
th provided device type and buffer sizes.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The latency is below or within=
 delta of provided baseline.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SkippedTestException: When confi=
guration is not provided.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;snow3g_vdev&quot; not in self.latency=
_test_parameters:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 skip(&quot;test not configured&q=
uot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 app =3D Cryptodev(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ptest=3DTestType.latency,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vdevs=3D[VirtualDevice(&quot;cry=
pto_snow3g0&quot;)],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devtype=3DDeviceType.crypto_snow=
3g,<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 digest_sz=3D16,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 burst_sz=3D32,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 total_ops=3DTOTAL_OPS,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buffer_sz=3Dself.buffer_sizes[&q=
uot;open_ssl_vdev&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 results =3D self._verify_latency(app.run_app()=
, &quot;open_ssl_vdev&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._print_stats(results)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for result in results:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(result[&quot;passed&quot;=
] =3D=3D &quot;PASS&quot;, &quot;Gbps fell below delta tolerance&quot;)<br>=
</blockquote><div>Same</div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 @crypto_test<br>
+=C2=A0 =C2=A0 def zuc_vdev(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Zuc vdev latency test.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Create a cryptodev instance wi=
th provided device type and buffer sizes.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The latency is below or within=
 delta of provided baseline.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SkippedTestException: When confi=
guration is not provided.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;zuc_vdev&quot; not in self.latency_te=
st_parameters:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 skip(&quot;test not configured&q=
uot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 app =3D Cryptodev(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ptest=3DTestType.latency,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vdevs=3D[VirtualDevice(&quot;cry=
pto_zuc0&quot;)],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devtype=3DDeviceType.crypto_zuc,=
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 burst_sz=3D32,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 total_ops=3DTOTAL_OPS,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buffer_sz=3Dself.buffer_sizes[&q=
uot;zuc_vdev&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 results =3D self._verify_latency(app.run_app()=
, &quot;zuc_vdev&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._print_stats(results)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for result in results:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(result[&quot;passed&quot;=
] =3D=3D &quot;PASS&quot;, &quot;Gbps fell below delta tolerance&quot;)<br>=
</blockquote><div><br></div><div>Same=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
-- <br>
2.50.1<br>
<br></blockquote><div><br></div><div>Make sure you also see the ai code rev=
iew mention of kasumi and snow3g typo or misassignment=C2=A0<a href=3D"http=
s://mails.dpdk.org/archives/test-report/2026-May/990932.html">https://mails=
.dpdk.org/archives/test-report/2026-May/990932.html</a></div><div><br></div=
><div>The suggestions about safety when reading index 0 of a list are worth=
 implementing too.</div><div><br></div><div>Reviewed-by: Patrick Robb &lt;<=
a href=3D"mailto:patrickrobb1997@gmail.com">patrickrobb1997@gmail.com</a>&g=
t;=C2=A0</div></div></div>
</div>
</div>

--00000000000098f3ae065514a6ac--
