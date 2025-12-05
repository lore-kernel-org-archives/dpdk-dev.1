Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D262D2F7D7
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 10:25:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79EE9402ED;
	Fri,  5 Dec 2025 11:25:30 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 54F0C40156;
 Fri,  5 Dec 2025 11:25:28 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dN6vd4J77zJ46cZ;
 Fri,  5 Dec 2025 18:25:17 +0800 (CST)
Received: from frapema500004.china.huawei.com (unknown [7.182.19.21])
 by mail.maildlp.com (Postfix) with ESMTPS id 47E8F40547;
 Fri,  5 Dec 2025 18:25:27 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500004.china.huawei.com (7.182.19.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 5 Dec 2025 11:25:27 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Fri, 5 Dec 2025 11:25:27 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Bruce Richardson <bruce.richardson@intel.com>
CC: "stable@dpdk.org" <stable@dpdk.org>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v2 02/10] app/test: fix undefined behaviour in red autotest
Thread-Topic: [PATCH v2 02/10] app/test: fix undefined behaviour in red
 autotest
Thread-Index: AQHcZUrXOjZlagkG/0GlZNCGi5l5VbUS2BsQ
Date: Fri, 5 Dec 2025 10:25:26 +0000
Message-ID: <53551dad6ae64dcf9dc2111293481620@huawei.com>
References: <20251202154948.1757169-1-bruce.richardson@intel.com>
 <20251204182047.3154429-1-bruce.richardson@intel.com>
 <20251204182047.3154429-3-bruce.richardson@intel.com>
In-Reply-To: <20251204182047.3154429-3-bruce.richardson@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.16]
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
> From: Bruce Richardson <bruce.richardson@intel.com>
> Sent: Thursday 4 December 2025 18:21
> To: dev@dpdk.org
> Cc: Bruce Richardson <bruce.richardson@intel.com>; stable@dpdk.org
> Subject: [PATCH v2 02/10] app/test: fix undefined behaviour in red autote=
st
>=20
> The shift of a negative number (or very large positive) is undefined
> behaviour which causes errors when run with UBSan. Fix this by making
> the behaviour explicit for the edge case of n being zero in the
> calculation.
>=20
> Fixes: de3cfa2c9823 ("sched: initial import")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  lib/sched/rte_red.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/sched/rte_red.h b/lib/sched/rte_red.h
> index e62abb9295..3b90cc46a9 100644
> --- a/lib/sched/rte_red.h
> +++ b/lib/sched/rte_red.h
> @@ -172,8 +172,15 @@ __rte_red_calc_qempty_factor(uint8_t wq_log2, uint16=
_t m)
>  	f =3D (n >> 6) & 0xf;
>  	n >>=3D 10;
>=20
> -	if (n < RTE_RED_SCALING)
> +	if (n < RTE_RED_SCALING) {
> +		/* When n =3D=3D 0, no rounding or shifting needed.
> +		 * For n > 0, add 2^(n-1) for rounding before right shift.
> +		 * This avoids UB from (1 << -1) when n =3D=3D 0.
> +		 */
> +		if (n =3D=3D 0)
> +			return (uint16_t) rte_red_pow2_frac_inv[f];
>  		return (uint16_t) ((rte_red_pow2_frac_inv[f] + (1 << (n - 1))) >> n);
> +	}
>=20
>  	return 0;
>  }
> --
> 2.51.0

Acked-by: Marat Khalili <marat.khalili@huawei.com>
