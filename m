Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436EED29C24
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Jan 2026 13:06:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFF23402BB;
	Mon, 19 Jan 2026 14:06:45 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 87B2E40299;
 Mon, 19 Jan 2026 14:06:44 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dvrLh5TGmzJ468m;
 Mon, 19 Jan 2026 21:06:20 +0800 (CST)
Received: from frapema100003.china.huawei.com (unknown [7.182.19.100])
 by mail.maildlp.com (Postfix) with ESMTPS id 9ED1440570;
 Mon, 19 Jan 2026 21:06:43 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100003.china.huawei.com (7.182.19.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 19 Jan 2026 14:06:43 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Mon, 19 Jan 2026 14:06:43 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Bruce Richardson
 <bruce.richardson@intel.com>, =?iso-8859-1?Q?Morten_Br=F8rup?=
 <mb@smartsharesystems.com>
Subject: RE: [PATCH 5/6] test: add file-prefix for all fast-tests on Linux
Thread-Topic: [PATCH 5/6] test: add file-prefix for all fast-tests on Linux
Thread-Index: AQHciLbfrfdjpHV7VUqlicigSUHx1rVZdQDw
Date: Mon, 19 Jan 2026 13:06:43 +0000
Message-ID: <e79dc3b56f4044a8be45abc0c9e681cb@huawei.com>
References: <20260118201223.323024-1-stephen@networkplumber.org>
 <20260118201223.323024-6-stephen@networkplumber.org>
In-Reply-To: <20260118201223.323024-6-stephen@networkplumber.org>
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
> Cc: Stephen Hemminger <stephen@networkplumber.org>; stable@dpdk.org; Bruc=
e Richardson
> <bruce.richardson@intel.com>; Morten Br=F8rup <mb@smartsharesystems.com>
> Subject: [PATCH 5/6] test: add file-prefix for all fast-tests on Linux
>=20
> When running tests in parallel on systems with many cores, multiple test
> processes collide on the default "rte" file-prefix, causing EAL
> initialization failures:
>=20
>   EAL: Cannot allocate memzone list: Device or resource busy
>   EAL: Cannot init memzone
>=20
> This occurs because all DPDK tests (including --no-huge tests) use
> file-backed arrays for memzone tracking. These files are created at
> /var/run/dpdk/<prefix>/fbarray_memzone and require exclusive locking
> during initialization. When multiple tests run in parallel with the
> same file-prefix, they compete for this lock.
>=20
> The original implementation included --file-prefix for Linux to
> prevent this collision. This was later removed during test
> infrastructure refactoring.
>=20
> Restore the --file-prefix argument for all fast-tests on Linux,
> regardless of whether they use hugepages. Tests that exercise
> file-prefix functionality (like eal_flags_file_prefix_autotest)
> spawn child processes with their own hardcoded prefixes and use
> get_current_prefix() to verify the parent's resources, so they work
> correctly regardless of what prefix the parent process uses.
>=20
> Fixes: 50823f30f0c8 ("test: build using per-file dependencies")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/test/suites/meson.build | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/app/test/suites/meson.build b/app/test/suites/meson.build
> index 1010150eee..38df1cfec2 100644
> --- a/app/test/suites/meson.build
> +++ b/app/test/suites/meson.build
> @@ -85,7 +85,11 @@ foreach suite:test_suites
>              if nohuge
>                  test_args +=3D test_no_huge_args
>              elif not has_hugepage
> -                continue  #skip this tests
> +                continue  # skip this tests
> +            endif
> +            if is_linux
> +                # use unique file-prefix to allow parallel runs
> +                test_args +=3D ['--file-prefix=3D' + test_name.underscor=
ify()]
>              endif
>              if not asan and get_option('b_sanitize').contains('address')
>                  continue  # skip this test
> --
> 2.51.0
>=20

Note that in CI systems running multiple builds for different targets or=20
branches there will still be problems. Also, if you have to resubmit, can y=
ou=20
move new lines below handling of nohuge and asan.

With or without points above addressed,

Acked-by: Marat Khalili <marat.khalili@huawei.com>
