Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCBBD2F7D1
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 10:10:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1B244027D;
	Fri,  5 Dec 2025 11:10:37 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 876AF40156
 for <dev@dpdk.org>; Fri,  5 Dec 2025 11:10:36 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dN6Zd0pG3zHnH8X;
 Fri,  5 Dec 2025 18:10:33 +0800 (CST)
Received: from frapema100004.china.huawei.com (unknown [7.182.19.128])
 by mail.maildlp.com (Postfix) with ESMTPS id 84BCD40569;
 Fri,  5 Dec 2025 18:10:34 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100004.china.huawei.com (7.182.19.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 5 Dec 2025 11:10:34 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Fri, 5 Dec 2025 11:10:34 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Bruce Richardson <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH v2 01/10] app/test: make parameters clearer when adding
 fast tests
Thread-Topic: [PATCH v2 01/10] app/test: make parameters clearer when adding
 fast tests
Thread-Index: AQHcZUrSfOIRVxlBWkuXCcnrvxXTIrUS0EFg
Date: Fri, 5 Dec 2025 10:10:34 +0000
Message-ID: <5b0438bc0a494ca5972718b7f9e1ce22@huawei.com>
References: <20251202154948.1757169-1-bruce.richardson@intel.com>
 <20251204182047.3154429-1-bruce.richardson@intel.com>
 <20251204182047.3154429-2-bruce.richardson@intel.com>
In-Reply-To: <20251204182047.3154429-2-bruce.richardson@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.16]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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

Apart from one cosmetic issue in a comment,

Acked-by: Marat Khalili <marat.khalili@huawei.com>

> diff --git a/app/test/suites/meson.build b/app/test/suites/meson.build
> index 712dd65568..65995078b7 100644
> --- a/app/test/suites/meson.build
> +++ b/app/test/suites/meson.build
> @@ -67,9 +67,19 @@ foreach suite:test_suites
>          # special fast-test handling here
>          foreach t: suite_tests
>              params =3D t.split(':')
> +            # check for valid options for asan and nohuge. Note, the ext=
raction script runs tolower()

> diff --git a/buildtools/get-test-suites.py b/buildtools/get-test-suites.p=
y
> index c3a99a862e..73f1d9c9e1 100644
> --- a/buildtools/get-test-suites.py
> +++ b/buildtools/get-test-suites.py
> @@ -18,7 +18,7 @@ def get_fast_test_params(test_name, ln):
>      "Extract the extra fast-test parameters from the line"
>      (_, rest_of_line) =3D ln.split(test_name, 1)
>      (_, nohuge, asan, _func) =3D rest_of_line.split(',', 3)
> -    return f":{nohuge.strip().lower()}:{asan.strip().lower()}"
> +    return f":{nohuge.strip()}:{asan.strip()}"

Is the Note above no longer relevant?

>=20
>  for fname in input_list:
>      with open(fname, "r", encoding=3D"utf-8") as f:
> diff --git a/doc/guides/contributing/unit_test.rst b/doc/guides/contribut=
ing/unit_test.rst
> index c0f0d2988f..0c76921299 100644
> --- a/doc/guides/contributing/unit_test.rst
> +++ b/doc/guides/contributing/unit_test.rst
> @@ -188,9 +188,11 @@ There are two important functions for interacting wi=
th the test harness:
>        The test is automatically added to the Meson test suite `<MESON_SU=
ITE>` by this macro.
>        Examples would be ``REGISTER_DRIVER_TEST``, or ``REGISTER_PERF_TES=
T``.
>        **NOTE:** The ``REGISTER_FAST_TEST`` macro is slightly different,
> -      in that it takes two additional parameters,
> -      specifying whether the test can be run using ``--no-huge``,
> -      and whether the test can be run using Address Sanitization (ASAN)
> +      in that it takes two additional parameters before the function nam=
e:
> +      the hugepage requirement (``NOHUGE_OK`` if the test can run withou=
t hugepages,
> +      or ``NOHUGE_SKIP`` if hugepages are required),
> +      and Address Sanitizer compatibility (``ASAN_OK`` if the test can r=
un with ASan enabled,
> +      or ``ASAN_SKIP`` if it cannot).
>=20
>     ``unit_test_suite_runner(struct unit_test_suite *)``
>        Returns a runner for a full test suite object,
> @@ -318,7 +320,7 @@ of the unit test suite structure, for example:
>         return ret;
>     }
>=20
> -   REGISTER_FAST_TEST(example_autotest, true /*no-huge*/, false /*ASan*/=
, example_tests);
> +   REGISTER_FAST_TEST(example_autotest, NOHUGE_OK, ASAN_OK, example_test=
s);

I support change of this example meaning to what should be the default.
