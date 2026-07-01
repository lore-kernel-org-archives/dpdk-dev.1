Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0121C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 16:53:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 27DAD402D2;
	Wed,  1 Jul 2026 18:53:17 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id EAA2640279
 for <dev@dpdk.org>; Wed,  1 Jul 2026 18:53:14 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gr5fH73HQzJ4687;
 Thu,  2 Jul 2026 00:52:23 +0800 (CST)
Received: from dubpeml100002.china.huawei.com (unknown [7.214.144.156])
 by mail.maildlp.com (Postfix) with ESMTPS id 742B740572;
 Thu,  2 Jul 2026 00:53:12 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100002.china.huawei.com (7.214.144.156) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 1 Jul 2026 17:53:12 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Wed, 1 Jul 2026 17:53:12 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH v3 7/8] ip_frag: remove use of rte_memcpy
Thread-Topic: [PATCH v3 7/8] ip_frag: remove use of rte_memcpy
Thread-Index: AQHdCXXR4Be79uFZJ0a6qjPxMU+l1bZY4Srw
Date: Wed, 1 Jul 2026 16:53:11 +0000
Message-ID: <03d55a3e42304d6387d215d4860e57fb@huawei.com>
References: <20260616210656.464062-1-stephen@networkplumber.org>
 <20260701162127.207318-1-stephen@networkplumber.org>
 <20260701162127.207318-8-stephen@networkplumber.org>
In-Reply-To: <20260701162127.207318-8-stephen@networkplumber.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.220]
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



> Replace rte_memcpy with assignment or plain memcpy to
> get more static checking.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/ip_frag/rte_ipv6_fragmentation.c | 3 +--
>  lib/ip_frag/rte_ipv6_reassembly.c    | 5 ++---
>  2 files changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/lib/ip_frag/rte_ipv6_fragmentation.c
> b/lib/ip_frag/rte_ipv6_fragmentation.c
> index c81f2402e3..86dd2e65ce 100644
> --- a/lib/ip_frag/rte_ipv6_fragmentation.c
> +++ b/lib/ip_frag/rte_ipv6_fragmentation.c
> @@ -6,7 +6,6 @@
>  #include <errno.h>
>=20
>  #include <eal_export.h>
> -#include <rte_memcpy.h>
>=20
>  #include "ip_frag_common.h"
>=20
> @@ -24,7 +23,7 @@ __fill_ipv6hdr_frag(struct rte_ipv6_hdr *dst,
>  {
>  	struct rte_ipv6_fragment_ext *fh;
>=20
> -	rte_memcpy(dst, src, sizeof(*dst));
> +	*dst =3D *src;
>  	dst->payload_len =3D rte_cpu_to_be_16(len);
>  	dst->proto =3D IPPROTO_FRAGMENT;
>=20
> diff --git a/lib/ip_frag/rte_ipv6_reassembly.c b/lib/ip_frag/rte_ipv6_rea=
ssembly.c
> index 9aa2f2d08b..cae4266f97 100644
> --- a/lib/ip_frag/rte_ipv6_reassembly.c
> +++ b/lib/ip_frag/rte_ipv6_reassembly.c
> @@ -5,7 +5,6 @@
>  #include <stddef.h>
>=20
>  #include <eal_export.h>
> -#include <rte_memcpy.h>
>=20
>  #include "ip_frag_common.h"
>=20
> @@ -145,8 +144,8 @@ rte_ipv6_frag_reassemble_packet(struct rte_ip_frag_tb=
l
> *tbl,
>  	int32_t ip_len;
>  	int32_t trim;
>=20
> -	rte_memcpy(&key.src_dst[0], &ip_hdr->src_addr, 16);
> -	rte_memcpy(&key.src_dst[2], &ip_hdr->dst_addr, 16);
> +	memcpy(&key.src_dst[0], &ip_hdr->src_addr, 16);
> +	memcpy(&key.src_dst[2], &ip_hdr->dst_addr, 16);
>=20
>  	key.id =3D frag_hdr->id;
>  	key.key_len =3D IPV6_KEYLEN;
> --

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

> 2.53.0

