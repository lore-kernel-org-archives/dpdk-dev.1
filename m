Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D43CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 Aug 2025 13:47:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0F75402D9;
	Fri, 15 Aug 2025 15:47:41 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 89F6E4003C
 for <dev@dpdk.org>; Fri, 15 Aug 2025 15:47:40 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c3NfT37n5z6M4w1;
 Fri, 15 Aug 2025 21:45:37 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
 by mail.maildlp.com (Postfix) with ESMTPS id 3C2871402E9;
 Fri, 15 Aug 2025 21:47:38 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500005.china.huawei.com (7.182.85.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 15 Aug 2025 15:47:37 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Fri, 15 Aug 2025 15:47:37 +0200
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: RE: [PATCH v2 2/6] ipsec: replace unnecessary comma operator
Thread-Topic: [PATCH v2 2/6] ipsec: replace unnecessary comma operator
Thread-Index: AQHcDWKAiD7AIRhGv0aCOfJf+vKv6bRju2CQ
Date: Fri, 15 Aug 2025 13:47:37 +0000
Message-ID: <1a3329ad3a164b7dbf838bf11698fa42@huawei.com>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20250814212901.88863-1-stephen@networkplumber.org>
 <20250814212901.88863-3-stephen@networkplumber.org>
In-Reply-To: <20250814212901.88863-3-stephen@networkplumber.org>
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



> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Thursday, August 14, 2025 10:29 PM
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; Konstantin Ananyev <k=
onstantin.ananyev@huawei.com>; Vladimir
> Medvedkin <vladimir.medvedkin@intel.com>
> Subject: [PATCH v2 2/6] ipsec: replace unnecessary comma operator
>=20
> Use of comma as statement separator is discouraged and
> reported as warning by clang with -Wcomma
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/ipsec/misc.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/ipsec/misc.h b/lib/ipsec/misc.h
> index fd4d3f5256..54dc5c2d4d 100644
> --- a/lib/ipsec/misc.h
> +++ b/lib/ipsec/misc.h
> @@ -126,7 +126,8 @@ cpu_crypto_bulk(const struct rte_ipsec_session *ss,
>=20
>  	const uint32_t vnum =3D RTE_DIM(vec);
>=20
> -	j =3D 0, n =3D 0;
> +	j =3D 0;
> +	n =3D 0;
>  	vofs =3D 0;
>  	for (i =3D 0; i !=3D num; i++) {
>=20
> --

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>=20

> 2.47.2

