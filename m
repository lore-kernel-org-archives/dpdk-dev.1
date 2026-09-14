Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C46C88E6A
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 09:05:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3F2B402D2;
	Mon, 14 Sep 2026 11:05:42 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id F2FA6402C4
 for <dev@dpdk.org>; Mon, 14 Sep 2026 11:05:40 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=Mq7LXq6U46GKjSlNdDNemGsHHngSKOSw+IWnLFxvpMs=;
 b=KIShPArkEefo1Yk3LEZTjYbRyFyaGtOUi8igNw0sI6BfkP2WQclnyG4/1NqoYZDLaCW4Lxlfq
 nCcZ4JOzehWin6GckwRxe6qkRxQfbi+kRz32xh7SHyVpAEr6hl+vTn1FVInHuPRVt2TZ6a+N3SM
 NbhIC5A8diAxhMsU90citHE=
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hjzk708PCzJ467W;
 Mon, 14 Sep 2026 17:04:47 +0800 (CST)
Received: from frapema100003.china.huawei.com (unknown [7.182.19.100])
 by mail.maildlp.com (Postfix) with ESMTPS id 016F44057C;
 Mon, 14 Sep 2026 17:05:38 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100003.china.huawei.com (7.182.19.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 11:05:37 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.2562.046;
 Mon, 14 Sep 2026 11:05:37 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: =?iso-8859-1?Q?Mattias_R=F6nnblom?= <mattias.ronnblom@ericsson.com>
Subject: RE: [RFC] eal: allow setting random number generator seed
Thread-Topic: [RFC] eal: allow setting random number generator seed
Thread-Index: AQHdQkEyVIkppiwZfkqatTUq9cRGq7bNyeHA
Date: Mon, 14 Sep 2026 09:05:37 +0000
Message-ID: <5458e4f73262413ba38c2708fbaf6980@huawei.com>
References: <20260911225845.3168061-1-stephen@networkplumber.org>
In-Reply-To: <20260911225845.3168061-1-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.78]
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
> Sent: Friday 11 September 2026 23:59
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; Mattias R=F6nnblom <m=
attias.ronnblom@ericsson.com>
> Subject: [RFC] eal: allow setting random number generator seed
>=20
> Many performance tests use rte_rand() and the random number
> can perturb the results. Add an ability to overide the automatic
> random seed on DPDK startup.
>=20
> This is not a security problem since rte_rand() is documented
> as not being cryptographically secure.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/eal/common/rte_random.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/eal/common/rte_random.c b/lib/eal/common/rte_random.c
> index 576a32a46c..cdad60049b 100644
> --- a/lib/eal/common/rte_random.c
> +++ b/lib/eal/common/rte_random.c
> @@ -247,7 +247,18 @@ eal_rand_init(void)
>=20
>  	RTE_LCORE_VAR_ALLOC(rand_state);
>=20
> -	seed =3D __rte_random_initial_seed();
> +	const char *env =3D getenv("DPDK_RANDOM_SEED");
> +	if (env !=3D NULL && *env !=3D '\0') {
> +		char *end;
> +
> +		errno =3D 0;
> +		seed =3D strtoull(env, &end, 0);
> +		if (errno !=3D 0 || *end !=3D '\0')
> +			rte_exit(EXIT_FAILURE,
> +				 "invalid DPDK_RANDOM_SEED: %s\n", env);
> +	} else {
> +		seed =3D __rte_random_initial_seed();
> +	}
>=20
>  	rte_srand(seed);
>  }
> --
> 2.53.0

Lgtm, although as a minor nit `env` is maybe not the best name here.

Regardless,

Acked-by: Marat Khalili <marat.khalili@huawei.com>
