Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29156CA0ED1
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 Aug 2025 14:00:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60A71400EF;
	Fri, 15 Aug 2025 16:00:29 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 380EA4003C
 for <dev@dpdk.org>; Fri, 15 Aug 2025 16:00:27 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c3NxG1pvdz6M4v6;
 Fri, 15 Aug 2025 21:58:26 +0800 (CST)
Received: from frapeml100008.china.huawei.com (unknown [7.182.85.131])
 by mail.maildlp.com (Postfix) with ESMTPS id 0E3EF1402F4;
 Fri, 15 Aug 2025 22:00:27 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100008.china.huawei.com (7.182.85.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 15 Aug 2025 16:00:26 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Fri, 15 Aug 2025 16:00:26 +0200
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Bruce Richardson <bruce.richardson@intel.com>
Subject: RE: [PATCH v2 6/6] config: enable comma warnings
Thread-Topic: [PATCH v2 6/6] config: enable comma warnings
Thread-Index: AQHcDWKl91jBNKlSkE6yyPdNCaaqZbRjvr0g
Date: Fri, 15 Aug 2025 14:00:26 +0000
Message-ID: <68c8f615ed6b43c3a6b35654b38f901e@huawei.com>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20250814212901.88863-1-stephen@networkplumber.org>
 <20250814212901.88863-7-stephen@networkplumber.org>
In-Reply-To: <20250814212901.88863-7-stephen@networkplumber.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.146.251]
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



> Clang (3.9 or later) has a -Wcomma that emits warnings for questionable
> uses of the comma operator.
>=20
> Don't enable it for drivers since many drivers still use
> comma operator unnecessarily.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  config/meson.build  | 1 +
>  drivers/meson.build | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/config/meson.build b/config/meson.build
> index f31fef216c..d9ff0e31c0 100644
> --- a/config/meson.build
> +++ b/config/meson.build
> @@ -313,6 +313,7 @@ endif
>  global_cflags =3D [
>          # additional warnings in alphabetical order
>          '-Wcast-qual',
> +        '-Wcomma',
>          '-Wdeprecated',
>          '-Wformat',
>          '-Wformat-nonliteral',
> diff --git a/drivers/meson.build b/drivers/meson.build
> index b62880db02..4c08a1dd9d 100644
> --- a/drivers/meson.build
> +++ b/drivers/meson.build
> @@ -59,7 +59,7 @@ default_cflags =3D machine_args
>  default_cflags +=3D ['-DALLOW_EXPERIMENTAL_API']
>  default_cflags +=3D ['-DALLOW_INTERNAL_API']
>=20
> -warning_disable_cflags =3D ['-Wno-format-truncation', '-Wno-address-of-p=
acked-member']
> +warning_disable_cflags =3D ['-Wno-format-truncation', '-Wno-address-of-p=
acked-member', '-Wno-comma']
>  foreach cflag:warning_disable_cflags
>      if cc.has_argument(cflag)
>          default_cflags +=3D cflag
> --

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
=20

> 2.47.2

