Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E447EFEFB73
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 18:31:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E5263402E7;
	Fri, 27 Feb 2026 19:31:36 +0100 (CET)
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by mails.dpdk.org (Postfix) with ESMTP id 10A3C402C6
 for <dev@dpdk.org>; Fri, 27 Feb 2026 19:31:35 +0100 (CET)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-1273349c56bso2894225c88.0
 for <dev@dpdk.org>; Fri, 27 Feb 2026 10:31:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772217094; cv=none;
 d=google.com; s=arc-20240605;
 b=FbjwLVX5l7/V+zkfIN934QmfM8iJnTVGsHfpkhoImKdHYQsJ0Sw4QK4eGDzDjb/Hap
 wcx9hmtwr8UxbuTAEE+KoJlxGQlypT3VSFxI+BmAu0aqBxVGVVlqbfCJSKHajfzTI8T9
 SekphCkUE7er6AlE+iVDKJ99ENSKcWIfUzUZWGmFn8RkbN7icx5SDrDxSXsXYl1G+ZHZ
 i+CqK2l5IKkkQ3RJf7IIkmFGjLTq+YdPQMBQ3JFTH/LuO2r/ZyWwmxjKldqLo8A88RqK
 E6jtbZ7ju4z3ze5QM7Dz8Tf5qcTLfqaepyFxAJALUAnfRiZ7idNRTH7CHKn/Jh3b8EQH
 IpDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6HrqhKBVcrn7baCaTYPsg4ZnWlHY6eZ9xDSqmJREurI=;
 fh=pqWwB8BD0KAv+xDp0sKy8FOWk/upJLwoxO+aMiPwiz0=;
 b=bfPSOJM7F3n5zC1ThofYJCs1r9D1I3HXR3WGTRg68i03iwY5TH1Q0lxb0sYQIz+RmM
 Ap7McQZyS4l+ORXBOLHAPV/ipM5d/uG5McxKOWJy2WcOcxRJl+DpH71tJWUu+f/E4XOm
 j3QF2l+EJEC1OqJW2Nzz2WWMqLYpbSJ5EHlCjDg/Zjj7t6cOafroi0e2BwAKPaJLnXry
 KnLilv7Ls4nmRkfiacGPBdDJm4YrVZ+47jQAx8FXvVvg5PntECbFqjarAEnlFx735LID
 xs6ftBZFAlNtGRmk/2GeQsc3b3ctKoLoYj04J2USwYQ2SZKEy80oLoQo3Ciuybn89608
 o2QA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1772217094; x=1772821894; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6HrqhKBVcrn7baCaTYPsg4ZnWlHY6eZ9xDSqmJREurI=;
 b=jlS9gAzT0aSdd3kbfZK9avTfTFs2QQvdp5yN+rp2P2BARZ5K7LcCyG9SClMvqvr4Pj
 rNs7oBbWvLkXGxMUdGu8cncRU0UITDQbhtA+AUENCeYpnEpHMas0YFGb0kN4ucNzl1wt
 UzJd9+gBItwUgcRodMFLsg4XG4hYZ+EdtXco0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772217094; x=1772821894;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6HrqhKBVcrn7baCaTYPsg4ZnWlHY6eZ9xDSqmJREurI=;
 b=GDd1VGv5s888CLgEkv8EZTd99shYlDbwqCA8zEhfb3m8puYSrX1jCpDA/8uGGlQzZG
 sN0OVbMF21h1GeUlyUHDmz95WsSVndVippu+7HsiZTCJJfLoXlJNgK0YcNClx+RyGNay
 MG6c6ZEkqJukU2xoAKjD4cMnbPKyJc/e+eVyBJGi32O3Rh5+HqC+mX3xXwuqeJmR1gk/
 MgpbFSMT/wpTPRzW2FBb2AeXph01nMUe4Vnb4pZFW9kIP54t0tVOeD1bnXtJ5ZpPq7fC
 XXTdTHcZ4u6z++wFGIWC2SUogfbooXEOxwkIqbNZ2HMfYrBIZSVHq5x3LFWmTvqUQGx/
 6FPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7loczRZCRk2mUT9NQf6Cfbv0B+2pmxa+OBZBWUtkLZZiXl33LRLciyw7WxfZGbjKZ+XA=@dpdk.org
X-Gm-Message-State: AOJu0Yw9IHczqb62Qeq0GBPEdFs9/eAG0/awX0PT7Ebribc7UWF+w8ZJ
 9x9BUUE2wkAOVBWynQZcSSLsNBXfACTNz1cFQbu/6rIm0EG4Wahq5l8MJEcjA+sA/7UANj7XHdR
 nfWmxaHy0HbkyLaEGotQHWfRqhDyMTksa/OXDTDvxQA==
X-Gm-Gg: ATEYQzyg5tfYJe5fJA6DKRewTYqlbYIwxj6GOlYrgyJJUvMx80oShEUEovdRerki3CR
 He/87JienLZAXEWNWPe2XFqq8tzbs20rVTS3u1bGiMNl2WSfvSt/PNeqcSPocFtHyIzKFZ2T2/1
 KYno/9S8CI7/hNiwqOB/vT39vI4ojF8UV9+UrvtE+ahpexrQX8yDZR5+L1BzfqjrbSpxkO3qsvv
 lKJXTFB99iQyE8AC2B5Efu8eODgtcFpM7mO9PtoQh0gstXDuhrrf3i7gOUgNuzUO7u40K+KLBTt
 VfPfcN/B8LcTEwF2O/ORKzdSYJeN01EHq7XyiPkV9IVAmRGCy+mj9Q==
X-Received: by 2002:a05:7022:698e:b0:119:e569:f615 with SMTP id
 a92af1059eb24-1278fb7e7cbmr1681862c88.14.1772217089171; Fri, 27 Feb 2026
 10:31:29 -0800 (PST)
MIME-Version: 1.0
References: <20260210193448.69423-1-abailey@iol.unh.edu>
 <20260213193539.103858-1-abailey@iol.unh.edu>
 <20260213193539.103858-5-abailey@iol.unh.edu>
In-Reply-To: <20260213193539.103858-5-abailey@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 27 Feb 2026 13:28:37 -0500
X-Gm-Features: AaiRm50R1847N3UXqh73pZa1jZqh8kOsND1iG2mZQCXcrB72KWPphKccDUzzNa0
Message-ID: <CAJvnSUCG39GRuw_==7B_Atd91h21ZOyr-rqtGoYskOsxUdBauQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] dts: add crypto test decorator
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
> Currently, a test case is decorated to signify whether to use Scapy or
> TREX. This change allows test suites that do not use a traffic generator
> to avoid the overhead of initializing either one.
>
> Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
> ---
>  dts/configurations/test_run.example.yaml    |  1 +
>  dts/framework/config/test_run.py            |  3 +++
>  dts/framework/test_run.py                   |  2 +-
>  dts/framework/test_suite.py                 |  6 +++++
>  dts/tests/TestSuite_cryptodev_throughput.py | 30 +++++++++++----------
>  5 files changed, 27 insertions(+), 15 deletions(-)
>
> diff --git a/dts/configurations/test_run.example.yaml b/dts/configuration=
s/test_run.example.yaml
> index c8035fccf0..3eaffc2aa4 100644
> --- a/dts/configurations/test_run.example.yaml
> +++ b/dts/configurations/test_run.example.yaml
> @@ -31,6 +31,7 @@ func_traffic_generator:
>  #   config: "/opt/trex_config/trex_config.yaml" # Additional configurati=
on files. (Leave blank if not required)
>  perf: false # disable performance testing
>  func: true # enable functional testing
> +crypto: false # disable cryptographic testing
>  use_virtual_functions: false # use virtual functions (VFs) instead of ph=
ysical functions
>  skip_smoke_tests: true # optional
>  # by removing the `test_suites` field, this test run will run every test=
 suite available
> diff --git a/dts/framework/config/test_run.py b/dts/framework/config/test=
_run.py
> index 6c292a3675..39f2c7cdf6 100644
> --- a/dts/framework/config/test_run.py
> +++ b/dts/framework/config/test_run.py
> @@ -481,6 +481,8 @@ class TestRunConfiguration(FrozenModel):
>      perf: bool
>      #: Whether to run functional tests.
>      func: bool
> +    #: Whether to run cryptography tests.
> +    crypto: bool

I think this is good for now, but long term we need to discuss if it
makes sense to keep func, perf, and crypto, or if we want something
like ethdev_func, ethdev_perf, crypto? Can you ticket this on Bugzilla
so others can comment?

>      #: Whether to run the testing with virtual functions instead of phys=
ical functions
>      use_virtual_functions: bool
>      #: Whether to skip smoke tests.
> @@ -522,6 +524,7 @@ def filter_tests(
>                      for tt in t.test_cases
>                      if (tt.test_type is TestCaseType.FUNCTIONAL and self=
.func)
>                      or (tt.test_type is TestCaseType.PERFORMANCE and sel=
f.perf)
> +                    or (tt.test_type is TestCaseType.CRYPTO and self.cry=
pto)
>                  ),
>              )
>              for t in test_suites
> diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
> index 36e6c5a44c..ada628c59e 100644
> --- a/dts/framework/test_run.py
> +++ b/dts/framework/test_run.py
> @@ -349,7 +349,7 @@ def next(self) -> State | None:
>
>          if test_run.config.use_virtual_functions:
>              test_run.ctx.topology.instantiate_vf_ports()
> -        if test_run.ctx.sut_node.cryptodevs:
> +        if test_run.ctx.sut_node.cryptodevs and test_run.config.crypto:
>              test_run.ctx.topology.instantiate_crypto_vf_ports()
>              test_run.ctx.topology.configure_cryptodevs("dpdk")
>
> diff --git a/dts/framework/test_suite.py b/dts/framework/test_suite.py
> index 9c57e343ac..e86096cefe 100644
> --- a/dts/framework/test_suite.py
> +++ b/dts/framework/test_suite.py
> @@ -174,6 +174,8 @@ def filter_test_cases(
>                      perf_test_cases.add(test_case)
>                  case TestCaseType.FUNCTIONAL:
>                      func_test_cases.add(test_case)
> +                case TestCaseType.CRYPTO:
> +                    pass
>
>          if test_case_sublist_copy:
>              raise ConfigurationError(
> @@ -279,6 +281,8 @@ class TestCaseType(Enum):
>      FUNCTIONAL =3D auto()
>      #:
>      PERFORMANCE =3D auto()
> +    #:
> +    CRYPTO =3D auto()
>
>
>  class TestCase(TestProtocol, Protocol[TestSuiteMethodType]):
> @@ -331,6 +335,8 @@ def _decorator(func: TestSuiteMethodType) -> type[Tes=
tCase]:
>  func_test: Callable =3D TestCase.make_decorator(TestCaseType.FUNCTIONAL)
>  #: The decorator for performance test cases.
>  perf_test: Callable =3D TestCase.make_decorator(TestCaseType.PERFORMANCE=
)
> +#: The decorator for cryptography test cases.
> +crypto_test: Callable =3D TestCase.make_decorator(TestCaseType.CRYPTO)
>
>
>  @dataclass
> diff --git a/dts/tests/TestSuite_cryptodev_throughput.py b/dts/tests/Test=
Suite_cryptodev_throughput.py
> index 871e47ae63..387afe8bcd 100644
> --- a/dts/tests/TestSuite_cryptodev_throughput.py
> +++ b/dts/tests/TestSuite_cryptodev_throughput.py
> @@ -32,7 +32,7 @@
>  from api.test import verify
>  from framework.context import get_ctx
>  from framework.exception import SkippedTestException
> -from framework.test_suite import BaseConfig, TestSuite, func_test
> +from framework.test_suite import BaseConfig, TestSuite, crypto_test
>  from framework.testbed_model.virtual_device import VirtualDevice
>
>  config_list: list[dict[str, int | float | str]] =3D [
> @@ -142,7 +142,7 @@ def _verify_throughput(
>              result_list.append(result_dict)
>          return result_list
>
> -    @func_test
> +    @crypto_test
>      def aes_cbc(self) -> None:
>          """aes_cbc test.
>
> @@ -172,6 +172,7 @@ def aes_cbc(self) -> None:
>          for result in results:
>              verify(result["passed"] =3D=3D "PASS", "gbps fell below delt=
a tolerance")
>
> +    @crypto_test
>      def aes_cbc_sha1(self) -> None:
>          """aes_cbc_sha1 test.
>
> @@ -206,6 +207,7 @@ def aes_cbc_sha1(self) -> None:
>          for result in results:
>              verify(result["passed"] =3D=3D "PASS", "gbps fell below delt=
a tolerance")
>
> +    @crypto_test
>      def aes_cbc_sha2(self) -> None:
>          """aes_cbc_sha2 test.
>
> @@ -239,7 +241,7 @@ def aes_cbc_sha2(self) -> None:
>          for result in results:
>              verify(result["passed"] =3D=3D "PASS", "gbps fell below delt=
a tolerance")
>
> -    @func_test
> +    @crypto_test
>      def aes_cbc_sha2_digest_16(self) -> None:
>          """aes_cbc_sha2_digest_16 test.
>
> @@ -273,7 +275,7 @@ def aes_cbc_sha2_digest_16(self) -> None:
>          for result in results:
>              verify(result["passed"] =3D=3D "PASS", "gbps fell below delt=
a tolerance")
>
> -    @func_test
> +    @crypto_test
>      def aead_aes_gcm(self) -> None:
>          """aead_aes_gcm test.
>
> @@ -305,7 +307,7 @@ def aead_aes_gcm(self) -> None:
>          for result in results:
>              verify(result["passed"] =3D=3D "PASS", "gbps fell below delt=
a tolerance")
>
> -    @func_test
> +    @crypto_test
>      def aes_docsisbpi(self) -> None:
>          """aes_docsiscpi test.
>
> @@ -366,7 +368,7 @@ def sha1_hmac(self) -> None:
>          for result in results:
>              verify(result["passed"] =3D=3D "PASS", "gbps fell below delt=
a tolerance")
>
> -    @func_test
> +    @crypto_test
>      def snow3g_uea2_snow3g_uia2(self) -> None:
>          """snow3g_uea2_snow3g_uia2 test.
>
> @@ -401,7 +403,7 @@ def snow3g_uea2_snow3g_uia2(self) -> None:
>          for result in results:
>              verify(result["passed"] =3D=3D "PASS", "gbps fell below delt=
a tolerance")
>
> -    @func_test
> +    @crypto_test
>      def zuc_eea3_zuc_eia3(self) -> None:
>          """zuc_eea3_zuc_eia3 test.
>
> @@ -436,7 +438,7 @@ def zuc_eea3_zuc_eia3(self) -> None:
>          for result in results:
>              verify(result["passed"] =3D=3D "PASS", "gbps fell below delt=
a tolerance")
>
> -    @func_test
> +    @crypto_test
>      def kasumi_f8_kasumi_f9(self) -> None:
>          """kasumi_f8 kasumi_f9 test.
>
> @@ -473,7 +475,7 @@ def kasumi_f8_kasumi_f9(self) -> None:
>
>      # BEGIN VDEV TESTS
>
> -
> +    @crypto_test
>      def aesni_mb_vdev(self) -> None:
>          """aesni_mb virtual device test.
>
> @@ -510,7 +512,7 @@ def aesni_mb_vdev(self) -> None:
>          for result in results:
>              verify(result["passed"] =3D=3D "PASS", "gbps fell below delt=
a tolerance")
>
> -    @func_test
> +    @crypto_test
>      def aesni_gcm_vdev(self):
>          """aesni_gcm virtual device test.
>
> @@ -543,7 +545,7 @@ def aesni_gcm_vdev(self):
>          for result in results:
>              verify(result["passed"] =3D=3D "PASS", "gbps fell below delt=
a tolerance")
>
> -    @func_test
> +    @crypto_test
>      def kasumi_vdev(self) -> None:
>          """Kasmumi virtual device test.
>
> @@ -579,7 +581,7 @@ def kasumi_vdev(self) -> None:
>          for result in results:
>              verify(result["passed"] =3D=3D "PASS", "gbps fell below delt=
a tolerance")
>
> -    @func_test
> +    @crypto_test
>      def snow3g_vdev(self) -> None:
>          """snow3g virtual device test.
>
> @@ -616,7 +618,7 @@ def snow3g_vdev(self) -> None:
>          for result in results:
>              verify(result["passed"] =3D=3D "PASS", "gpbs fell below delt=
a tolerance")
>
> -    @func_test
> +    @crypto_test
>      def zuc_vdev(self) -> None:
>          """Zuc virtual device test.
>
> @@ -653,7 +655,7 @@ def zuc_vdev(self) -> None:
>          for result in results:
>              verify(result["passed"] =3D=3D "PASS", "gpbs fell below delt=
a tolerance")
>
> -    @func_test
> +    @crypto_test
>      def open_ssl_vdev(self) -> None:
>          """open_ssl virtual device test.
>
> --
> 2.50.1
>

Have you tested this by running an execution that includes both
cryptodev tests and ethdev tests (both func and perf)?

Reviewed-by: Patrick Robb <probb@iol.unh.edu>
