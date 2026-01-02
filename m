Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8CBFA3748
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Jan 2026 14:55:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 77B8F40267;
	Fri,  2 Jan 2026 15:55:18 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 640D340262
 for <dev@dpdk.org>; Fri,  2 Jan 2026 15:55:17 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4djRY94Xn5zJ467Z;
 Fri,  2 Jan 2026 22:54:21 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 4572B40570;
 Fri,  2 Jan 2026 22:55:17 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 2 Jan 2026 15:55:17 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Fri, 2 Jan 2026 15:55:16 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Bruce Richardson <bruce.richardson@intel.com>
Subject: RE: [PATCH v10 9/9] test: re-enable format-truncation warnings
Thread-Topic: [PATCH v10 9/9] test: re-enable format-truncation warnings
Thread-Index: AQHceQ7D2KYOV6jFwk2ctIxIgGpXJrU+/W2w
Date: Fri, 2 Jan 2026 14:55:16 +0000
Message-ID: <a47781a49344478382fc4d9730023517@huawei.com>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251229220053.21981-1-stephen@networkplumber.org>
 <20251229220053.21981-10-stephen@networkplumber.org>
In-Reply-To: <20251229220053.21981-10-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.70]
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

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Monday 29 December 2025 21:59
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; Bruce Richardson <bru=
ce.richardson@intel.com>
> Subject: [PATCH v10 9/9] test: re-enable format-truncation warnings
>=20
> Tests should be built with warnings.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  app/test/meson.build | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/app/test/meson.build b/app/test/meson.build
> index efec42a6bf..b00260c0e9 100644
> --- a/app/test/meson.build
> +++ b/app/test/meson.build
> @@ -260,7 +260,6 @@ cflags +=3D no_wvla_cflag
>  extra_flags =3D [
>          # Strict-aliasing rules are violated by uint8_t[] to context siz=
e casts.
>          '-fno-strict-aliasing',
> -        '-Wno-format-truncation',
>  ]
>=20
>  foreach arg: extra_flags
> --
> 2.51.0

Acked-by: Marat Khalili <marat.khalili@huawei.com>
