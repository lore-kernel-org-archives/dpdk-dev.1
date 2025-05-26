Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308DEC54FC6
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 03:44:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E469A402A0;
	Mon, 26 May 2025 05:44:50 +0200 (CEST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com
 [209.85.208.172])
 by mails.dpdk.org (Postfix) with ESMTP id 7CA9740299
 for <dev@dpdk.org>; Mon, 26 May 2025 05:44:48 +0200 (CEST)
Received: by mail-lj1-f172.google.com with SMTP id
 38308e7fff4ca-30f30200b51so18655171fa.3
 for <dev@dpdk.org>; Sun, 25 May 2025 20:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748231088; x=1748835888; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Q+O0q+RRu6Lrto64b9sRuRGpAT9RB91KlsRvqLlMak=;
 b=KOvQwuHUBoL2dr+tny+Wffy2p1tlbliCRyTBtDsuoQ1w4vUyUvQp/RaZtQlPyRcQZe
 xECJPNe/JWP3sDPOaJDQL5sAkyYj6Mfk0oDWxKjs57sRkRSaLkLgtXaW3isFqSJCASB/
 jDQ99zqxUYqlLjKxoelT29I94r4oqFIGF6m6plDnFduZd7XResuec//QHrTt7Iv5S7FS
 hJ2yBz+WMe2ANl5FgaGtrXdzKls6c+NmLjuOa8ALoEds/RWJuUEmPJiaFd+BnIJKLKC+
 8eB7bszut01ZsrwaWdQfyxVgXJFumlU433r4wrZGCe9vM2l4lmLwZGttjpIfQOC636T+
 vF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748231088; x=1748835888;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Q+O0q+RRu6Lrto64b9sRuRGpAT9RB91KlsRvqLlMak=;
 b=fBjG84tQbP5Gg+GuTrlbGtugR8GoIVT+XFLDuClARLGWnpXt+CZf26MjgpQmIKHT8M
 Bm6T0kkFfhtmzlgKA6/AEF4f0wEcxIvX5wwEiuja8aIrfYxB7F2mrDDGrTBe2lC2MnAU
 FqOFScAB9kayj2iQDO4A6j342ujxQrJsN/6MK55RiAdiDyOGdD0M1x2nwK7iFFe2Qftn
 cE8hnAIEGIbMc1V9TUaEqArx6Uc0u3HSc7mWqQLH9VqCC8dAaVtFkk5k3ZK1c5zLBEKA
 F4F5nx6Hp0+xJFPyt0aiXvIhV/m5y5kIKiOzgkmiablJfFFbShnSdSf+3oyatL221mqQ
 Q+CA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1U4s9E6TVc1uBd8zHscYIFox6aDChCzFCkZ2jOIJwt3vpSZ6hhd9Qemz6KPc5WRSo0i4=@dpdk.org
X-Gm-Message-State: AOJu0YzBq+dFU9vSEkET/47YNkcLAfaKiteRSJ4CGOOh3f9YpWTP+JdZ
 1DfdSr87dpdEmS/SIG42yxQCG8MnmMsJIHeGJfDN9Inv6w4nNZxcZjJ7+D8dzpvGc2FZb6DMJT9
 CPONXP7er8oOFDDBfEQEL0n1g78zwrvdmflwoOnHjlg==
X-Gm-Gg: ASbGnctru/yP3ZvgtDqPoK4NtJDsHgxhUjBiTINory0JGlJyF8dkJDBE9eA9ja9Lwq4
 Lufvnde0uqT0B1OJoww+mtODU7lin1YfIW7Qzl90hD3jpc6johfr2tbiyRanR6V8TPps09uVZK3
 8bd/lDmPgnjbjan/N4pniy1GbEDqy/pllYDJBwvA==
X-Google-Smtp-Source: AGHT+IGEfSgnRsp2n8Xj3uMuFIsrd3gA0Z4BY7deRPLceZribN/u0QmioUgGvsVcKaKHtlIeMjxOkQpH56B9xUVXA/w=
X-Received: by 2002:a05:651c:2112:b0:30b:b956:53c2 with SMTP id
 38308e7fff4ca-3295b9ba4a4mr20856111fa.11.1748231087582; Sun, 25 May 2025
 20:44:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250508074119.356011-1-zhangfei.gao@linaro.org>
 <CO6PR18MB4484068E26F01A086742F2F4D89EA@CO6PR18MB4484.namprd18.prod.outlook.com>
 <CABQgh9E0Kh115U4YbkVPOCR-65cbFb__V-+pRGFdRGoqLVYMtg@mail.gmail.com>
 <CO6PR18MB448446151350E98857F883FFD899A@CO6PR18MB4484.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB448446151350E98857F883FFD899A@CO6PR18MB4484.namprd18.prod.outlook.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Mon, 26 May 2025 11:44:36 +0800
X-Gm-Features: AX0GCFt5gYtuqlx0O7O90BnGTU0AtL9wWucHiWL5Ills39cg-1JNEZgMl7fa3Eg
Message-ID: <CABQgh9HYQo7FNPggY1-m4-SMga4Sf5G3RV1AU-izZunNJzgqcQ@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH 0/2] uadk: realize async mode
To: Akhil Goyal <gakhil@marvell.com>
Cc: "Marchand, David" <david.marchand@redhat.com>,
 Aaron Conole <aconole@redhat.com>, 
 Fan Zhang <fanzhang.oss@gmail.com>, Ashish Gupta <ashishg@marvell.com>, 
 "dev@dpdk.org" <dev@dpdk.org>, 
 "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>
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

On Thu, 22 May 2025 at 19:50, Akhil Goyal <gakhil@marvell.com> wrote:
>
> > Hi, Akhil
> >
> > On Wed, 21 May 2025 at 20:39, Akhil Goyal <gakhil@marvell.com> wrote:
> > >
> > > > Realize async mode to replace sync mode for better performance
> > > >
> > > > Zhangfei Gao (2):
> > > >   compress/uadk: use async mode to replace sync mode
> > > >   crypto/uadk: use async mode to replace sync mode
> > > >
> > > >  drivers/compress/uadk/uadk_compress_pmd.c     | 107 ++++--
> > > >  .../compress/uadk/uadk_compress_pmd_private.h |   2 +-
> > > >  drivers/crypto/uadk/uadk_crypto_pmd.c         | 321 +++++++++++++-=
----
> > > >  drivers/crypto/uadk/uadk_crypto_pmd_private.h |   8 +-
> > > >  4 files changed, 318 insertions(+), 120 deletions(-)
> > >
> > > This patchset is not building for me atleast. Please fix compilation.
> > >
> > > ninja: Entering directory `./build-gcc-static'
> > > [2/31] Compiling C object
> > drivers/libtmp_rte_compress_uadk.a.p/compress_uadk_uadk_compress_pmd.c.
> > o
> > > FAILED:
> > drivers/libtmp_rte_compress_uadk.a.p/compress_uadk_uadk_compress_pmd.c.
> > o
> > > ccache gcc -Idrivers/libtmp_rte_compress_uadk.a.p -Idrivers -I../driv=
ers -
> > Idrivers/compress/uadk -I../drivers/compress/uadk -Ilib/compressdev -
> > I../lib/compressdev -Ilib/eal/common -I../lib/eal/common -I. -I.. -Icon=
fig -
> > I../config -Ilib/eal/include -I../lib/eal/include -Ilib/eal/linux/inclu=
de -
> > I../lib/eal/linux/include -Ilib/eal/x86/include -I../lib/eal/x86/includ=
e -
> > I../kernel/linux -Ilib/eal -I../lib/eal -Ilib/kvargs -I../lib/kvargs -I=
lib/log -I../lib/log -
> > Ilib/metrics -I../lib/metrics -Ilib/telemetry -I../lib/telemetry -Ilib/=
mbuf -
> > I../lib/mbuf -Ilib/mempool -I../lib/mempool -Ilib/ring -I../lib/ring -
> > Idrivers/bus/vdev -I../drivers/bus/vdev -
> > I/home/gakhil/up/uadk/build_x86/include -fdiagnostics-color=3Dalways -
> > D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -Wextra -Werror -std=3Dc11 =
-O2 -g -
> > include rte_config.h -Wvla -Wcast-qual -Wdeprecated -Wformat -Wformat-
> > nonliteral -Wformat-security -Wmissing-declarations -Wmissing-prototype=
s -
> > Wnested-externs -Wold-style-definition -Wpointer-arith -Wsign-compare -
> > Wstrict-prototypes -Wundef -Wwrite-strings -Wno-packed-not-aligned -Wno=
-
> > missing-field-initializers -D_GNU_SOURCE -fPIC -march=3Dnative -mrtm -
> > DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-format-truncation
> > -Wno-address-of-packed-member -
> > DRTE_LOG_DEFAULT_LOGTYPE=3Dpmd.compress.uadk -MD -MQ
> > drivers/libtmp_rte_compress_uadk.a.p/compress_uadk_uadk_compress_pmd.c.
> > o -MF
> > drivers/libtmp_rte_compress_uadk.a.p/compress_uadk_uadk_compress_pmd.c.
> > o.d -o
> > drivers/libtmp_rte_compress_uadk.a.p/compress_uadk_uadk_compress_pmd.c.
> > o -c ../drivers/compress/uadk/uadk_compress_pmd.c
> > > ../drivers/compress/uadk/uadk_compress_pmd.c: In function
> > =E2=80=98uadk_compress_pmd_config=E2=80=99:
> > > ../drivers/compress/uadk/uadk_compress_pmd.c:35:9: error: variable
> > =E2=80=98cparams=E2=80=99 has initializer but incomplete type
> > >    35 |  struct wd_ctx_params cparams =3D {0};
> > >       |         ^~~~~~~~~~~~~
> > > ../drivers/compress/uadk/uadk_compress_pmd.c:35:34: error: excess ele=
ments
> > in struct initializer [-Werror]
> > >    35 |  struct wd_ctx_params cparams =3D {0};
> > >       |                                  ^
> > > ../drivers/compress/uadk/uadk_compress_pmd.c:35:34: note: (near
> > initialization for =E2=80=98cparams=E2=80=99)
> > > ../drivers/compress/uadk/uadk_compress_pmd.c:35:23: error: storage si=
ze of
> > =E2=80=98cparams=E2=80=99 isn=E2=80=99t known
> > >    35 |  struct wd_ctx_params cparams =3D {0};
> > >       |                       ^~~~~~~
> > > ../drivers/compress/uadk/uadk_compress_pmd.c:42:42: error: dereferenc=
ing
> > pointer to incomplete type =E2=80=98struct wd_ctx_nums=E2=80=99
> > >    42 |  ctx_set_num =3D calloc(WD_DIR_MAX, sizeof(*ctx_set_num));
> > >       |                                          ^~~~~~~~~~~~
> > > ../drivers/compress/uadk/uadk_compress_pmd.c:50:16: error: implicit
> > declaration of function =E2=80=98numa_allocate_nodemask=E2=80=99 [-Werr=
or=3Dimplicit-function-
> > declaration]
> > >    50 |  cparams.bmp =3D numa_allocate_nodemask();
> > >       |                ^~~~~~~~~~~~~~~~~~~~~~
> > > ../drivers/compress/uadk/uadk_compress_pmd.c:50:16: error: nested ext=
ern
> > declaration of =E2=80=98numa_allocate_nodemask=E2=80=99 [-Werror=3Dnest=
ed-externs]
> > > ../drivers/compress/uadk/uadk_compress_pmd.c:57:2: error: implicit
> > declaration of function =E2=80=98numa_bitmask_setall=E2=80=99 [-Werror=
=3Dimplicit-function-
> > declaration]
> > >    57 |  numa_bitmask_setall(cparams.bmp);
> > >       |  ^~~~~~~~~~~~~~~~~~~
> > > ../drivers/compress/uadk/uadk_compress_pmd.c:57:2: error: nested exte=
rn
> > declaration of =E2=80=98numa_bitmask_setall=E2=80=99 [-Werror=3Dnested-=
externs]
> > > ../drivers/compress/uadk/uadk_compress_pmd.c:60:14: error: invalid us=
e of
> > undefined type =E2=80=98struct wd_ctx_nums=E2=80=99
> > >    60 |   ctx_set_num[i].async_ctx_num =3D UADK_COMP_DEF_CTXS;
> > >       |              ^
> > > ../drivers/compress/uadk/uadk_compress_pmd.c:62:8: error: implicit
> > declaration of function =E2=80=98wd_comp_init2_=E2=80=99; did you mean =
=E2=80=98wd_comp_init=E2=80=99? [-
> > Werror=3Dimplicit-function-declaration]
> > >    62 |  ret =3D wd_comp_init2_(alg_name, SCHED_POLICY_RR, TASK_HW,
> > &cparams);
> > >       |        ^~~~~~~~~~~~~~
> > >       |        wd_comp_init
> > > ../drivers/compress/uadk/uadk_compress_pmd.c:62:8: error: nested exte=
rn
> > declaration of =E2=80=98wd_comp_init2_=E2=80=99 [-Werror=3Dnested-exter=
ns]
> > > ../drivers/compress/uadk/uadk_compress_pmd.c:62:50: error: =E2=80=98T=
ASK_HW=E2=80=99
> > undeclared (first use in this function)
> > >    62 |  ret =3D wd_comp_init2_(alg_name, SCHED_POLICY_RR, TASK_HW,
> > &cparams);
> > >       |                                                  ^~~~~~~
> > > ../drivers/compress/uadk/uadk_compress_pmd.c:62:50: note: each undecl=
ared
> > identifier is reported only once for each function it appears in
> > > ../drivers/compress/uadk/uadk_compress_pmd.c:63:2: error: implicit
> > declaration of function =E2=80=98numa_free_nodemask=E2=80=99 [-Werror=
=3Dimplicit-function-
> > declaration]
> > >    63 |  numa_free_nodemask(cparams.bmp);
> > >       |  ^~~~~~~~~~~~~~~~~~
> > > ../drivers/compress/uadk/uadk_compress_pmd.c:63:2: error: nested exte=
rn
> > declaration of =E2=80=98numa_free_nodemask=E2=80=99 [-Werror=3Dnested-e=
xterns]
> > > ../drivers/compress/uadk/uadk_compress_pmd.c:35:23: error: unused var=
iable
> > =E2=80=98cparams=E2=80=99 [-Werror=3Dunused-variable]
> > >    35 |  struct wd_ctx_params cparams =3D {0};
> > >       |                       ^~~~~~~
> > > ../drivers/compress/uadk/uadk_compress_pmd.c: In function
> > =E2=80=98uadk_compress_pmd_close=E2=80=99:
> > > ../drivers/compress/uadk/uadk_compress_pmd.c:97:3: error: implicit
> > declaration of function =E2=80=98wd_comp_uninit2=E2=80=99; did you mean=
 =E2=80=98wd_comp_uninit=E2=80=99? [-
> > Werror=3Dimplicit-function-declaration]
> > >    97 |   wd_comp_uninit2();
> > >       |   ^~~~~~~~~~~~~~~
> > >       |   wd_comp_uninit
> > > ../drivers/compress/uadk/uadk_compress_pmd.c:97:3: error: nested exte=
rn
> > declaration of =E2=80=98wd_comp_uninit2=E2=80=99 [-Werror=3Dnested-exte=
rns]
> >
> > I am sorry for the error.
> >
> > There are two reasons, one is using a newer uadk api, the other is
> > dependence on numa.
> > When using the old version uadk, I can reproduce a similar build
> > error, though not exactly the same.
> > And it can be solved by using a newer uadk version, at least 2.6, uadk
> > master branch does not have issues.
> >
> > a. 2.6 version exports the new api
> > b. building uadk library itself requires install numa, like yum
> > install numactl-devel
> > c. 2.6 header file +#include <numa.h>, which will be included automatic=
ally.
> >
> > Will add version dependence in the next version.
>
> Yes this is what I also suspected.
>
> But we cannot just change the version dependency without prior deprecatio=
n notice.
> I would suggest sending a deprecation notice in this release and use it i=
n next release.
>
> @David/Aaron, your thoughts?
>
>
Hi, Akhil

The two dpdk drivers are still workable with the latest uadk library.

The uadk library is promoting the new API, which was introduced in the
recent release, so switch to the new interface.

Do you mean add  a deprecation notice in release_25_07.rst: API Changes?
And keep the patches until the 25.11 release,  ie, send the patches
again in Sep?

Thanks
