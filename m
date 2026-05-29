Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17130CD4F54
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 16:42:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26A6640262;
	Fri, 29 May 2026 18:42:45 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 9ED9B400D7
 for <dev@dpdk.org>; Fri, 29 May 2026 18:42:44 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gRpzJ39fPzJ467X;
 Sat, 30 May 2026 00:41:48 +0800 (CST)
Received: from dubpeml500002.china.huawei.com (unknown [7.214.145.83])
 by mail.maildlp.com (Postfix) with ESMTPS id B11F340584;
 Sat, 30 May 2026 00:42:43 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500002.china.huawei.com (7.214.145.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 29 May 2026 17:42:43 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Fri, 29 May 2026 17:42:43 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: RE: [PATCH] app/test: use memcpy in ipsec test
Thread-Topic: [PATCH] app/test: use memcpy in ipsec test
Thread-Index: AQHc74JlHZWIoo7LLEyDxwIDBiAuqrYlNPHw
Date: Fri, 29 May 2026 16:42:43 +0000
Message-ID: <cd2886ccd3134ab0a712e739bad4da5e@huawei.com>
References: <20260529154651.128372-1-stephen@networkplumber.org>
In-Reply-To: <20260529154651.128372-1-stephen@networkplumber.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.168.4]
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



>=20
> This test has tables of data that get copied with rte_memcpy.
> But when compiled without always inline the compiler gets confused
> by the inlining of rte_memcpy and thinks that it is possible for AVX
> code to reference past the input data.
>=20
> Workaround is to use memcpy() which is better for this test anyway
> since regular memcpy has more static checking from compiler and
> analyzers.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/test/test_ipsec.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>=20
> diff --git a/app/test/test_ipsec.c b/app/test/test_ipsec.c
> index 139c1e8dec..b5a430996d 100644
> --- a/app/test/test_ipsec.c
> +++ b/app/test/test_ipsec.c
> @@ -10,7 +10,6 @@
>  #include <rte_hexdump.h>
>  #include <rte_mbuf.h>
>  #include <rte_malloc.h>
> -#include <rte_memcpy.h>
>  #include <rte_cycles.h>
>  #include <rte_bus_vdev.h>
>  #include <rte_ip.h>
> @@ -559,7 +558,7 @@ setup_test_string(struct rte_mempool *mpool, const
> char *string,
>  			return NULL;
>  		}
>  		if (string !=3D NULL)
> -			rte_memcpy(dst, string, t_len);
> +			memcpy(dst, string, t_len);
>  		else
>  			memset(dst, 0, t_len);
>  	}
> @@ -604,22 +603,22 @@ setup_test_string_tunneled(struct rte_mempool
> *mpool, const char *string,
>  	/* copy outer IP and ESP header */
>  	ipv4_outer.total_length =3D rte_cpu_to_be_16(t_len);
>  	ipv4_outer.packet_id =3D rte_cpu_to_be_16(seq);
> -	rte_memcpy(dst, &ipv4_outer, sizeof(ipv4_outer));
> +	memcpy(dst, &ipv4_outer, sizeof(ipv4_outer));
>  	dst +=3D sizeof(ipv4_outer);
>  	m->l3_len =3D sizeof(ipv4_outer);
> -	rte_memcpy(dst, &esph, sizeof(esph));
> +	memcpy(dst, &esph, sizeof(esph));
>  	dst +=3D sizeof(esph);
>=20
>  	if (string !=3D NULL) {
>  		/* copy payload */
> -		rte_memcpy(dst, string, len);
> +		memcpy(dst, string, len);
>  		dst +=3D len;
>  		/* copy pad bytes */
> -		rte_memcpy(dst, esp_pad_bytes, RTE_MIN(padlen,
> +		memcpy(dst, esp_pad_bytes, RTE_MIN(padlen,
>  			sizeof(esp_pad_bytes)));
>  		dst +=3D padlen;
>  		/* copy ESP tail header */
> -		rte_memcpy(dst, &espt, sizeof(espt));
> +		memcpy(dst, &espt, sizeof(espt));
>  	} else
>  		memset(dst, 0, t_len);
>=20
> --

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

> 2.53.0

