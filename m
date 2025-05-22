Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6217C54E90
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 May 2025 10:02:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96E55402D1;
	Thu, 22 May 2025 12:02:28 +0200 (CEST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com
 [209.85.167.44]) by mails.dpdk.org (Postfix) with ESMTP id 757BE402CA
 for <dev@dpdk.org>; Thu, 22 May 2025 12:02:26 +0200 (CEST)
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-550e2ac6bc9so8604811e87.1
 for <dev@dpdk.org>; Thu, 22 May 2025 03:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747908146; x=1748512946; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MQHgGtihJsxKXoRNfdkoER8NtiyyswA49bVm/8cfHSA=;
 b=a9L31AuRqyb5xU7b7l66AQb7lKjBK+kToPYuAlM1UvzsWyEd/+aC4TJrijOtYl1Cag
 H+7ibea9OgGiap94FaAmHf+7d4NCKvDyzoaarEJWowPEP3UBTnMFa4a+AG9fEnPdZI02
 SQp1Ar/Xdin03iZev0cFC+TNInp5kr2CtkgMVv5VbVYaV1pkA9Q8GWAhAgNNJAXi5Sbt
 W4Hf6o44HZInsubopQ2UeF3FtZFymN/8tsF0h8PGHyCP2nLqcm/jlSN/F4XobTQFrkHA
 /qOgrdKVYNnxAKOm151rDu4qRXUiVZzxNOrrVbVw5LW8kj0edTgTiBSLRwQk+tsPorIk
 S7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747908146; x=1748512946;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MQHgGtihJsxKXoRNfdkoER8NtiyyswA49bVm/8cfHSA=;
 b=LUz70WfN2HkjVdBRgaxZMWahEgYj8Dbhm7D8QIvz/7LP/233zADSuu16fH4ktFah7U
 bnzjtfyFzbwIPkzPjo+/cTX7vOS0UVbVzkoa5iOoEL3FzQbefGUlZODljosZGNA48+Rr
 AwwYAC0vtUT5mnf2b2nzww6b6wlIyXhelnEYHt89E/ofYAlUDf3wJV0ClOw/9vQBldD3
 +WkPe/mX3aCl4H57ScSkyo47c3ugKyVkQqNQgZyZpf+Y+6eSGszUkwXC4ERklas8sQmD
 edysYBq4UtpUkGM3WsnR5K9PvIP714g9sPAOTYQN4WSUMFROf3qw9IJ0Rfc56J0Fu4ay
 zcDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVy4Lc3ALAKMolQE5cOkoCSXWTjz37IoMtnqmdgXzAPd563qN+ayFEvudlIxRNd8BBLgjw=@dpdk.org
X-Gm-Message-State: AOJu0YzBhnnPZSx0UN/SH1uYIvO4sRa3r4B1L71d3pC4IQv0NntDYBVu
 nM4c0/GRqjQKTaXSqLdpG9AJT+Nu9zI5R5KS7/Dr4d5w0kUiYAYgIdDjN8cu2JP/oyVzTFb2+wX
 lZHeF3s4JNmBmV4Zwk3iTKBRAMjrZeuO5gRBaG5NklA==
X-Gm-Gg: ASbGncteZoPYzAdOH+VGClBmqonBfKB/K1mGJpunv9njAzxZrCNwdDPeEfxktBMWUTb
 W8GphJ6Ka7eTMSr4TNwjU8GGk6oK3vDk/he6ohMEDjsNoQD7D5qXIr0tw0t95umZf7v14K5DIIB
 yKX8UNsPn3l0KlKGs1WzqAVljU/7PzjC0veaUf4d8wEw==
X-Google-Smtp-Source: AGHT+IEjyTu+P198s+czsCqjnuL4/eRqQuUVJ/YkLv3QBckuNVpvPsL/GgE6q0m1cSJHHxzBGxL7jVejeDT3CO/qlr0=
X-Received: by 2002:a05:6512:660e:b0:549:5769:6ae3 with SMTP id
 2adb3069b0e04-550e71935camr8396880e87.6.1747908145654; Thu, 22 May 2025
 03:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250508074119.356011-1-zhangfei.gao@linaro.org>
 <CO6PR18MB4484068E26F01A086742F2F4D89EA@CO6PR18MB4484.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB4484068E26F01A086742F2F4D89EA@CO6PR18MB4484.namprd18.prod.outlook.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Thu, 22 May 2025 18:02:13 +0800
X-Gm-Features: AX0GCFvBJzZYDBHASGHE0K2MEQ9caCuaibWmpUKzNkE5OPQb62wk13jaCKebqZQ
Message-ID: <CABQgh9E0Kh115U4YbkVPOCR-65cbFb__V-+pRGFdRGoqLVYMtg@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH 0/2] uadk: realize async mode
To: Akhil Goyal <gakhil@marvell.com>
Cc: Fan Zhang <fanzhang.oss@gmail.com>, Ashish Gupta <ashishg@marvell.com>, 
 "dev@dpdk.org" <dev@dpdk.org>
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

Hi, Akhil

On Wed, 21 May 2025 at 20:39, Akhil Goyal <gakhil@marvell.com> wrote:
>
> > Realize async mode to replace sync mode for better performance
> >
> > Zhangfei Gao (2):
> >   compress/uadk: use async mode to replace sync mode
> >   crypto/uadk: use async mode to replace sync mode
> >
> >  drivers/compress/uadk/uadk_compress_pmd.c     | 107 ++++--
> >  .../compress/uadk/uadk_compress_pmd_private.h |   2 +-
> >  drivers/crypto/uadk/uadk_crypto_pmd.c         | 321 +++++++++++++-----
> >  drivers/crypto/uadk/uadk_crypto_pmd_private.h |   8 +-
> >  4 files changed, 318 insertions(+), 120 deletions(-)
>
> This patchset is not building for me atleast. Please fix compilation.
>
> ninja: Entering directory `./build-gcc-static'
> [2/31] Compiling C object drivers/libtmp_rte_compress_uadk.a.p/compress_u=
adk_uadk_compress_pmd.c.o
> FAILED: drivers/libtmp_rte_compress_uadk.a.p/compress_uadk_uadk_compress_=
pmd.c.o
> ccache gcc -Idrivers/libtmp_rte_compress_uadk.a.p -Idrivers -I../drivers =
-Idrivers/compress/uadk -I../drivers/compress/uadk -Ilib/compressdev -I../l=
ib/compressdev -Ilib/eal/common -I../lib/eal/common -I. -I.. -Iconfig -I../=
config -Ilib/eal/include -I../lib/eal/include -Ilib/eal/linux/include -I../=
lib/eal/linux/include -Ilib/eal/x86/include -I../lib/eal/x86/include -I../k=
ernel/linux -Ilib/eal -I../lib/eal -Ilib/kvargs -I../lib/kvargs -Ilib/log -=
I../lib/log -Ilib/metrics -I../lib/metrics -Ilib/telemetry -I../lib/telemet=
ry -Ilib/mbuf -I../lib/mbuf -Ilib/mempool -I../lib/mempool -Ilib/ring -I../=
lib/ring -Idrivers/bus/vdev -I../drivers/bus/vdev -I/home/gakhil/up/uadk/bu=
ild_x86/include -fdiagnostics-color=3Dalways -D_FILE_OFFSET_BITS=3D64 -Wall=
 -Winvalid-pch -Wextra -Werror -std=3Dc11 -O2 -g -include rte_config.h -Wvl=
a -Wcast-qual -Wdeprecated -Wformat -Wformat-nonliteral -Wformat-security -=
Wmissing-declarations -Wmissing-prototypes -Wnested-externs -Wold-style-def=
inition -Wpointer-arith -Wsign-compare -Wstrict-prototypes -Wundef -Wwrite-=
strings -Wno-packed-not-aligned -Wno-missing-field-initializers -D_GNU_SOUR=
CE -fPIC -march=3Dnative -mrtm -DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_AP=
I -Wno-format-truncation -Wno-address-of-packed-member -DRTE_LOG_DEFAULT_LO=
GTYPE=3Dpmd.compress.uadk -MD -MQ drivers/libtmp_rte_compress_uadk.a.p/comp=
ress_uadk_uadk_compress_pmd.c.o -MF drivers/libtmp_rte_compress_uadk.a.p/co=
mpress_uadk_uadk_compress_pmd.c.o.d -o drivers/libtmp_rte_compress_uadk.a.p=
/compress_uadk_uadk_compress_pmd.c.o -c ../drivers/compress/uadk/uadk_compr=
ess_pmd.c
> ../drivers/compress/uadk/uadk_compress_pmd.c: In function =E2=80=98uadk_c=
ompress_pmd_config=E2=80=99:
> ../drivers/compress/uadk/uadk_compress_pmd.c:35:9: error: variable =E2=80=
=98cparams=E2=80=99 has initializer but incomplete type
>    35 |  struct wd_ctx_params cparams =3D {0};
>       |         ^~~~~~~~~~~~~
> ../drivers/compress/uadk/uadk_compress_pmd.c:35:34: error: excess element=
s in struct initializer [-Werror]
>    35 |  struct wd_ctx_params cparams =3D {0};
>       |                                  ^
> ../drivers/compress/uadk/uadk_compress_pmd.c:35:34: note: (near initializ=
ation for =E2=80=98cparams=E2=80=99)
> ../drivers/compress/uadk/uadk_compress_pmd.c:35:23: error: storage size o=
f =E2=80=98cparams=E2=80=99 isn=E2=80=99t known
>    35 |  struct wd_ctx_params cparams =3D {0};
>       |                       ^~~~~~~
> ../drivers/compress/uadk/uadk_compress_pmd.c:42:42: error: dereferencing =
pointer to incomplete type =E2=80=98struct wd_ctx_nums=E2=80=99
>    42 |  ctx_set_num =3D calloc(WD_DIR_MAX, sizeof(*ctx_set_num));
>       |                                          ^~~~~~~~~~~~
> ../drivers/compress/uadk/uadk_compress_pmd.c:50:16: error: implicit decla=
ration of function =E2=80=98numa_allocate_nodemask=E2=80=99 [-Werror=3Dimpl=
icit-function-declaration]
>    50 |  cparams.bmp =3D numa_allocate_nodemask();
>       |                ^~~~~~~~~~~~~~~~~~~~~~
> ../drivers/compress/uadk/uadk_compress_pmd.c:50:16: error: nested extern =
declaration of =E2=80=98numa_allocate_nodemask=E2=80=99 [-Werror=3Dnested-e=
xterns]
> ../drivers/compress/uadk/uadk_compress_pmd.c:57:2: error: implicit declar=
ation of function =E2=80=98numa_bitmask_setall=E2=80=99 [-Werror=3Dimplicit=
-function-declaration]
>    57 |  numa_bitmask_setall(cparams.bmp);
>       |  ^~~~~~~~~~~~~~~~~~~
> ../drivers/compress/uadk/uadk_compress_pmd.c:57:2: error: nested extern d=
eclaration of =E2=80=98numa_bitmask_setall=E2=80=99 [-Werror=3Dnested-exter=
ns]
> ../drivers/compress/uadk/uadk_compress_pmd.c:60:14: error: invalid use of=
 undefined type =E2=80=98struct wd_ctx_nums=E2=80=99
>    60 |   ctx_set_num[i].async_ctx_num =3D UADK_COMP_DEF_CTXS;
>       |              ^
> ../drivers/compress/uadk/uadk_compress_pmd.c:62:8: error: implicit declar=
ation of function =E2=80=98wd_comp_init2_=E2=80=99; did you mean =E2=80=98w=
d_comp_init=E2=80=99? [-Werror=3Dimplicit-function-declaration]
>    62 |  ret =3D wd_comp_init2_(alg_name, SCHED_POLICY_RR, TASK_HW, &cpar=
ams);
>       |        ^~~~~~~~~~~~~~
>       |        wd_comp_init
> ../drivers/compress/uadk/uadk_compress_pmd.c:62:8: error: nested extern d=
eclaration of =E2=80=98wd_comp_init2_=E2=80=99 [-Werror=3Dnested-externs]
> ../drivers/compress/uadk/uadk_compress_pmd.c:62:50: error: =E2=80=98TASK_=
HW=E2=80=99 undeclared (first use in this function)
>    62 |  ret =3D wd_comp_init2_(alg_name, SCHED_POLICY_RR, TASK_HW, &cpar=
ams);
>       |                                                  ^~~~~~~
> ../drivers/compress/uadk/uadk_compress_pmd.c:62:50: note: each undeclared=
 identifier is reported only once for each function it appears in
> ../drivers/compress/uadk/uadk_compress_pmd.c:63:2: error: implicit declar=
ation of function =E2=80=98numa_free_nodemask=E2=80=99 [-Werror=3Dimplicit-=
function-declaration]
>    63 |  numa_free_nodemask(cparams.bmp);
>       |  ^~~~~~~~~~~~~~~~~~
> ../drivers/compress/uadk/uadk_compress_pmd.c:63:2: error: nested extern d=
eclaration of =E2=80=98numa_free_nodemask=E2=80=99 [-Werror=3Dnested-extern=
s]
> ../drivers/compress/uadk/uadk_compress_pmd.c:35:23: error: unused variabl=
e =E2=80=98cparams=E2=80=99 [-Werror=3Dunused-variable]
>    35 |  struct wd_ctx_params cparams =3D {0};
>       |                       ^~~~~~~
> ../drivers/compress/uadk/uadk_compress_pmd.c: In function =E2=80=98uadk_c=
ompress_pmd_close=E2=80=99:
> ../drivers/compress/uadk/uadk_compress_pmd.c:97:3: error: implicit declar=
ation of function =E2=80=98wd_comp_uninit2=E2=80=99; did you mean =E2=80=98=
wd_comp_uninit=E2=80=99? [-Werror=3Dimplicit-function-declaration]
>    97 |   wd_comp_uninit2();
>       |   ^~~~~~~~~~~~~~~
>       |   wd_comp_uninit
> ../drivers/compress/uadk/uadk_compress_pmd.c:97:3: error: nested extern d=
eclaration of =E2=80=98wd_comp_uninit2=E2=80=99 [-Werror=3Dnested-externs]

I am sorry for the error.

There are two reasons, one is using a newer uadk api, the other is
dependence on numa.
When using the old version uadk, I can reproduce a similar build
error, though not exactly the same.
And it can be solved by using a newer uadk version, at least 2.6, uadk
master branch does not have issues.

a. 2.6 version exports the new api
b. building uadk library itself requires install numa, like yum
install numactl-devel
c. 2.6 header file +#include <numa.h>, which will be included automatically=
.

Will add version dependence in the next version.

diff --git a/drivers/compress/uadk/meson.build
b/drivers/compress/uadk/meson.build
index 34113cd08c..e251af14cf 100644
--- a/drivers/compress/uadk/meson.build
+++ b/drivers/compress/uadk/meson.build
@@ -13,7 +13,7 @@ sources =3D files(
 )

 deps +=3D 'bus_vdev'
-dep =3D dependency('libwd_comp', required: false, method: 'pkg-config')
+dep =3D dependency('libwd_comp', version: '>=3D2.6', required: false,
method: 'pkg-config')
 if not dep.found()
     build =3D false
     reason =3D 'missing dependency, "libwd_comp"'
@@ -21,7 +21,7 @@ else
     ext_deps +=3D dep
 endif

-dep =3D dependency('libwd', required: false, method: 'pkg-config')
+dep =3D dependency('libwd', version: '>=3D2.6', required: false, method:
'pkg-config')
 if not dep.found()
     build =3D false
     reason =3D 'missing dependency, "libwd"'
diff --git a/drivers/crypto/uadk/meson.build b/drivers/crypto/uadk/meson.bu=
ild
index e46abd21e5..52db344c8e 100644
--- a/drivers/crypto/uadk/meson.build
+++ b/drivers/crypto/uadk/meson.build
@@ -13,7 +13,7 @@ sources =3D files(
 )

 deps +=3D 'bus_vdev'
-dep =3D dependency('libwd_crypto', required: false, method: 'pkg-config')
+dep =3D dependency('libwd_crypto', version: '>=3D2.6', required: false,
method: 'pkg-config')
 if not dep.found()
     build =3D false
     reason =3D 'missing dependency, "libwd_crypto"'
@@ -21,7 +21,7 @@ else
     ext_deps +=3D dep
 endif

-dep =3D dependency('libwd', required: false, method: 'pkg-config')
+dep =3D dependency('libwd', version: '>=3D2.6', required: false, method:
'pkg-config')
 if not dep.found()
     build =3D false
     reason =3D 'missing dependency, "libwd"'

Thanks
