Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC01C83029
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 16:06:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2DF98402A5;
	Mon, 30 Jun 2025 18:06:47 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id D94DC4025D;
 Mon, 30 Jun 2025 18:06:45 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bW9vK3d3Dz6L5Qm;
 Tue,  1 Jul 2025 00:03:57 +0800 (CST)
Received: from frapeml100004.china.huawei.com (unknown [7.182.85.167])
 by mail.maildlp.com (Postfix) with ESMTPS id 665411400CA;
 Tue,  1 Jul 2025 00:06:45 +0800 (CST)
Received: from frapeml500002.china.huawei.com (7.182.85.205) by
 frapeml100004.china.huawei.com (7.182.85.167) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Jun 2025 18:06:45 +0200
Received: from frapeml500002.china.huawei.com ([7.182.85.205]) by
 frapeml500002.china.huawei.com ([7.182.85.205]) with mapi id 15.01.2507.039;
 Mon, 30 Jun 2025 18:06:45 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Bruce Richardson
 <bruce.richardson@intel.com>, Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Neil Horman <nhorman@tuxdriver.com>
Subject: RE: [PATCH v2 07/10] tailq: fix cast macro for null pointer
Thread-Topic: [PATCH v2 07/10] tailq: fix cast macro for null pointer
Thread-Index: AQHb5EZE0MJnWEaj4Uy329mcDFONS7Qb30zw
Date: Mon, 30 Jun 2025 16:06:44 +0000
Message-ID: <609759a6e0cf4187a34d1a12bf9bcd59@huawei.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250623135242.461965-1-david.marchand@redhat.com>
 <20250623135242.461965-8-david.marchand@redhat.com>
In-Reply-To: <20250623135242.461965-8-david.marchand@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.64]
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
> From: David Marchand <david.marchand@redhat.com>
> Sent: Monday 23 June 2025 14:53
> To: dev@dpdk.org
> Cc: stable@dpdk.org; Bruce Richardson <bruce.richardson@intel.com>; Tyler
> Retzlaff <roretzla@linux.microsoft.com>; Neil Horman
> <nhorman@tuxdriver.com>
> Subject: [PATCH v2 07/10] tailq: fix cast macro for null pointer
>=20
> Doing arithmetics with the NULL pointer is undefined.
>=20
> Caught by UBSan:
>=20
> ../app/test/test_tailq.c:111:9: runtime error:
> 	member access within null pointer of type 'struct rte_tailq_head'
>=20
> Fixes: f6b4f6c9c123 ("tailq: use a single cast macro")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  lib/eal/include/rte_tailq.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/eal/include/rte_tailq.h b/lib/eal/include/rte_tailq.h
> index 89f7ef2134..c23df77d96 100644
> --- a/lib/eal/include/rte_tailq.h
> +++ b/lib/eal/include/rte_tailq.h
> @@ -54,7 +54,7 @@ struct rte_tailq_elem {
>   * Return the first tailq entry cast to the right struct.
>   */
>  #define RTE_TAILQ_CAST(tailq_entry, struct_name) \
> -	(struct struct_name *)&(tailq_entry)->tailq_head
> +	(tailq_entry =3D=3D NULL ? NULL : (struct struct_name *)&(tailq_entry)-
> >tailq_head)
>=20
>  /**
>   * Utility macro to make looking up a tailqueue for a particular struct =
easier.

First tailq_entry is missing parentheses. Also, it is worrying that we now =
use macro argument twice. E.g. RTE_TAILQ_LOOKUP may become twice slower as =
a result.

Could we perhaps simplify the macro to `(struct struct_name *)(tailq_entry)=
`. I tried to find or understand the reasons behind the original constructi=
on, but could not.
