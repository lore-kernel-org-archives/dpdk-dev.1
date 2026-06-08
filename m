Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88936CD8C8E
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 07:10:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA315402AD;
	Mon,  8 Jun 2026 09:10:56 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 8C36F40265
 for <dev@dpdk.org>; Mon,  8 Jun 2026 09:10:54 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gYjql5VX5zJ46Q7;
 Mon,  8 Jun 2026 15:10:43 +0800 (CST)
Received: from dubpeml100001.china.huawei.com (unknown [7.214.144.137])
 by mail.maildlp.com (Postfix) with ESMTPS id 8421B40575;
 Mon,  8 Jun 2026 15:10:53 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100001.china.huawei.com (7.214.144.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 8 Jun 2026 08:10:52 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Mon, 8 Jun 2026 08:10:52 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH] eal: check for invalid memory parameters
Thread-Topic: [PATCH] eal: check for invalid memory parameters
Thread-Index: AQHc9D0BoibkX0suOEOn2CaEv0q27rY0QrfQ
Date: Mon, 8 Jun 2026 07:10:52 +0000
Message-ID: <0ab8c5ebbe024f1aa29bd4a5fb77f81f@huawei.com>
References: <20260604161224.1090419-1-stephen@networkplumber.org>
In-Reply-To: <20260604161224.1090419-1-stephen@networkplumber.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.173.125]
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



> The code to parse arguments like memory size, channels and rank
> was using atoi() which has no check for garbage after the number.
> Switch to using a helper that uses strtoull().
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/eal/common/eal_common_options.c | 44 +++++++++++++++++++++++++----
>  1 file changed, 39 insertions(+), 5 deletions(-)
>=20
> diff --git a/lib/eal/common/eal_common_options.c
> b/lib/eal/common/eal_common_options.c
> index 1049838d73..49151c0a16 100644
> --- a/lib/eal/common/eal_common_options.c
> +++ b/lib/eal/common/eal_common_options.c
> @@ -2062,6 +2062,29 @@ eal_parse_huge_worker_stack(const char *arg)
>  	return 0;
>  }
>=20
> +static int
> +eal_parse_num(const char *str, unsigned int *val)
> +{
> +	char *endptr;
> +	unsigned long long n;
> +
> +	while (isspace((unsigned char)*str))
> +		str++;
> +
> +	if (*str =3D=3D '-')
> +		return -1;
> +
> +	errno =3D 0;
> +	n =3D strtoull(str, &endptr, 10);
> +
> +	/* Error if string is empty or has trailing characters */
> +	if (*str =3D=3D '\0' || *endptr !=3D '\0' || errno !=3D 0 || n > UINT_M=
AX)
> +		return -1;
> +
> +	*val =3D n;
> +	return 0;
> +}
> +
>  /* Parse the arguments given in the command line of the application */
>  int
>  eal_parse_args(void)
> @@ -2205,23 +2228,34 @@ eal_parse_args(void)
>=20
>  	/* memory options */
>  	if (args.memory_size !=3D NULL) {
> -		int_cfg->memory =3D atoi(args.memory_size);
> +		unsigned int mb;
> +		if (eal_parse_num(args.memory_size, &mb) < 0) {
> +			EAL_LOG(ERR, "invalid memory size parameter");
> +			return -1;
> +		}
> +
> +		int_cfg->memory =3D mb;
>  		int_cfg->memory *=3D 1024ULL;
>  		int_cfg->memory *=3D 1024ULL;
>  	}
>  	if (args.memory_channels !=3D NULL) {
> -		int_cfg->force_nchannel =3D atoi(args.memory_channels);
> -		if (int_cfg->force_nchannel =3D=3D 0) {
> +		unsigned int n;
> +		if (eal_parse_num(args.memory_channels, &n) < 0 ||
> +			n =3D=3D 0 || n > 32) {
>  			EAL_LOG(ERR, "invalid memory channel parameter");
>  			return -1;
>  		}
> +		int_cfg->force_nchannel =3D n;
>  	}
>  	if (args.memory_ranks !=3D NULL) {
> -		int_cfg->force_nrank =3D atoi(args.memory_ranks);
> -		if (int_cfg->force_nrank =3D=3D 0 || int_cfg->force_nrank > 16) {
> +		unsigned int n;
> +
> +		if (eal_parse_num(args.memory_ranks, &n) < 0 ||
> +			n =3D=3D 0 || n > 16) {
>  			EAL_LOG(ERR, "invalid memory rank parameter");
>  			return -1;
>  		}
> +		int_cfg->force_nrank =3D n;

It is probably worth to replace hardcoded constants (16/32) with some macro=
s.
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>=20

>  	}
>  	if (args.no_huge) {
>  		int_cfg->no_hugetlbfs =3D 1;
> --
> 2.53.0

