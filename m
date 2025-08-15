Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C16CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 Aug 2025 13:48:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EAAE64026C;
	Fri, 15 Aug 2025 15:48:40 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 2D4E64003C
 for <dev@dpdk.org>; Fri, 15 Aug 2025 15:48:40 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c3Nfl333lz6L5gS;
 Fri, 15 Aug 2025 21:45:51 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id B00B31402E9;
 Fri, 15 Aug 2025 21:48:38 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 15 Aug 2025 15:48:38 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Fri, 15 Aug 2025 15:48:38 +0200
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Anatoly Burakov <anatoly.burakov@intel.com>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>
Subject: RE: [PATCH v2 1/6] eal: replace unnecessary comma operator
Thread-Topic: [PATCH v2 1/6] eal: replace unnecessary comma operator
Thread-Index: AQHcDWKTAQYClmqoIEyHzP4SCnf75LRju8Cg
Date: Fri, 15 Aug 2025 13:48:38 +0000
Message-ID: <50155496cda146edaff68adf40dd102b@huawei.com>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20250814212901.88863-1-stephen@networkplumber.org>
 <20250814212901.88863-2-stephen@networkplumber.org>
In-Reply-To: <20250814212901.88863-2-stephen@networkplumber.org>
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



> Use of comma as statement separator is discouraged and
> reported as warning by clang with -Wcomma
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/eal/common/rte_malloc.c | 4 ++--
>  lib/eal/linux/eal_alarm.c   | 6 ++++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/lib/eal/common/rte_malloc.c b/lib/eal/common/rte_malloc.c
> index 3a86c19490..388e5a63b6 100644
> --- a/lib/eal/common/rte_malloc.c
> +++ b/lib/eal/common/rte_malloc.c
> @@ -202,8 +202,8 @@ rte_realloc_socket(void *ptr, size_t size, unsigned i=
nt align, int socket)
>  	}
>=20
>  	user_size =3D size;
> -
> -	size =3D RTE_CACHE_LINE_ROUNDUP(size), align =3D RTE_CACHE_LINE_ROUNDUP=
(align);
> +	size =3D RTE_CACHE_LINE_ROUNDUP(size);
> +	align =3D RTE_CACHE_LINE_ROUNDUP(align);
>=20
>  	/* check requested socket id and alignment matches first, and if ok,
>  	 * see if we can resize block
> diff --git a/lib/eal/linux/eal_alarm.c b/lib/eal/linux/eal_alarm.c
> index eb6a21d4f0..a1433eb867 100644
> --- a/lib/eal/linux/eal_alarm.c
> +++ b/lib/eal/linux/eal_alarm.c
> @@ -125,8 +125,10 @@ eal_alarm_callback(void *arg __rte_unused)
>  		atime.it_value.tv_sec =3D ap->time.tv_sec;
>  		atime.it_value.tv_nsec =3D ap->time.tv_usec * NS_PER_US;
>  		/* perform borrow for subtraction if necessary */
> -		if (now.tv_nsec > (ap->time.tv_usec * NS_PER_US))
> -			atime.it_value.tv_sec--, atime.it_value.tv_nsec +=3D US_PER_S * NS_PE=
R_US;
> +		if (now.tv_nsec > (ap->time.tv_usec * NS_PER_US)) {
> +			atime.it_value.tv_sec--;
> +			atime.it_value.tv_nsec +=3D US_PER_S * NS_PER_US;
> +		}
>=20
>  		atime.it_value.tv_sec -=3D now.tv_sec;
>  		atime.it_value.tv_nsec -=3D now.tv_nsec;
> --

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
=20

> 2.47.2

