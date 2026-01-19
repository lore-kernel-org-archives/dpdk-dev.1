Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B035D29C28
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Jan 2026 13:13:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 661634029A;
	Mon, 19 Jan 2026 14:13:45 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 00BFF40299;
 Mon, 19 Jan 2026 14:13:43 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dvrVj4GswzJ46Dt;
 Mon, 19 Jan 2026 21:13:17 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 79C3140086;
 Mon, 19 Jan 2026 21:13:40 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 19 Jan 2026 14:13:40 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Mon, 19 Jan 2026 14:13:40 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, =?iso-8859-1?Q?Morten_Br=F8rup?=
 <mb@smartsharesystems.com>, Bruce Richardson <bruce.richardson@intel.com>
Subject: RE: [PATCH 6/6] test: fix trace_autotest_with_traces parallel
 execution
Thread-Topic: [PATCH 6/6] test: fix trace_autotest_with_traces parallel
 execution
Thread-Index: AQHciLbjlzF26T4aQUe+95X2I1GmorVZeG5w
Date: Mon, 19 Jan 2026 13:13:40 +0000
Message-ID: <e895dd4222bd487f84d80241028cf951@huawei.com>
References: <20260118201223.323024-1-stephen@networkplumber.org>
 <20260118201223.323024-7-stephen@networkplumber.org>
In-Reply-To: <20260118201223.323024-7-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.16]
Content-Type: text/plain; charset="iso-8859-1"
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

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Sunday 18 January 2026 20:09
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; stable@dpdk.org; Mort=
en Br=F8rup
> <mb@smartsharesystems.com>; Bruce Richardson <bruce.richardson@intel.com>
> Subject: [PATCH 6/6] test: fix trace_autotest_with_traces parallel execut=
ion
>=20
> The trace_autotest_with_traces test was reusing the test_args array
> from trace_autotest, which already contained --file-prefix=3Dtrace_autote=
st.
>=20
> Fix by building trace_args from scratch for the _with_traces test
> variant instead of appending to the existing test_args array.
>=20
> Fixes: 0aeaf75df879 ("test: define unit tests suites based on test types"=
)
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/test/suites/meson.build | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>=20
> diff --git a/app/test/suites/meson.build b/app/test/suites/meson.build
> index 38df1cfec2..e62170bebf 100644
> --- a/app/test/suites/meson.build
> +++ b/app/test/suites/meson.build
> @@ -106,10 +106,18 @@ foreach suite:test_suites
>                  is_parallel : false,
>                  suite : 'fast-tests')
>              if not is_windows and test_name =3D=3D 'trace_autotest'
> -                test_args +=3D ['--trace=3D.*']
> -                test_args +=3D ['--trace-dir=3D@0@'.format(meson.current=
_build_dir())]
> +                # build separate args list to avoid duplicate --file-pre=
fix
> +                trace_args =3D test_no_huge_args
> +                trace_args +=3D ['--trace=3D.*']
> +                trace_args +=3D ['--trace-dir=3D@0@'.format(meson.curren=
t_build_dir())]
> +                if is_linux
> +                    trace_args +=3D ['--file-prefix=3Dtrace_autotest_wit=
h_traces']
> +                endif
> +                if get_option('default_library') =3D=3D 'shared'
> +                    trace_args +=3D ['-d', dpdk_drivers_build_dir]
> +                endif
>                  test(test_name + '_with_traces', dpdk_test,
> -                    args : test_args,
> +                    args : trace_args,
>                      env: ['DPDK_TEST=3D' + test_name],
>                      timeout : timeout_seconds_fast,
>                      is_parallel : false,
> --
> 2.51.0
>=20

Instead of duplicating some code and hardcoding values for trace_autotest,=
=20
which is error-prone, can we make adding file prefix the last thing we do t=
o=20
test_args (perhaps doing it right in the `args : ...` expression) and re-us=
e=20
the previous value and logic like we did it before?
