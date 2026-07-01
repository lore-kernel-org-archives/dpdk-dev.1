Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1217C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 16:52:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04B2C402D2;
	Wed,  1 Jul 2026 18:52:45 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 5E18640279;
 Wed,  1 Jul 2026 18:52:43 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gr5dh5bgRzJ46BN;
 Thu,  2 Jul 2026 00:51:52 +0800 (CST)
Received: from dubpeml100001.china.huawei.com (unknown [7.214.144.137])
 by mail.maildlp.com (Postfix) with ESMTPS id 43B8C40569;
 Thu,  2 Jul 2026 00:52:41 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100001.china.huawei.com (7.214.144.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 1 Jul 2026 17:52:40 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Wed, 1 Jul 2026 17:52:40 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v3 4/8] ip_frag: drop IPv6 fragments with per-fragment
 headers
Thread-Topic: [PATCH v3 4/8] ip_frag: drop IPv6 fragments with per-fragment
 headers
Thread-Index: AQHdCXXIUe4xq/t8nkyngVKDdAWsiLZY4QVw
Date: Wed, 1 Jul 2026 16:52:40 +0000
Message-ID: <6583eb01f9ad4c7eb0dae1fca44f4e55@huawei.com>
References: <20260616210656.464062-1-stephen@networkplumber.org>
 <20260701162127.207318-1-stephen@networkplumber.org>
 <20260701162127.207318-5-stephen@networkplumber.org>
In-Reply-To: <20260701162127.207318-5-stephen@networkplumber.org>
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


> IPv6 reassembly assumes the fragment header directly follows the IPv6
> header. ipv6_frag_reassemble() patches the next-header field and removes
> the fragment header at a fixed offset, so a fragment with per-fragment
> extension headers before the fragment header reassembles to a corrupt
> datagram.
>=20
> Drop the fragment when its fragment header does not directly follow the
> IPv6 header. Headers after the fragment header are payload and are
> unaffected.
>=20
> RFC 8200 permits discarding packets with extension headers out of the
> recommended order, and RFC 9099 recommends dropping non-conforming
> fragmented packets.
>=20
> Fixes: 4f1a8f633862 ("ip_frag: add IPv6 reassembly")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/ip_frag/rte_ipv6_reassembly.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>=20
> diff --git a/lib/ip_frag/rte_ipv6_reassembly.c b/lib/ip_frag/rte_ipv6_rea=
ssembly.c
> index 0e809a01e5..b6f623d53b 100644
> --- a/lib/ip_frag/rte_ipv6_reassembly.c
> +++ b/lib/ip_frag/rte_ipv6_reassembly.c
> @@ -180,6 +180,28 @@ rte_ipv6_frag_reassemble_packet(struct rte_ip_frag_t=
bl
> *tbl,
>  		return NULL;
>  	}
>=20
> +	/*
> +	 * Only a fragment header directly following the IPv6 header is
> supported.
> +	 * Per-fragment (unfragmentable) extension headers placed
> +	 * before the fragment header are not handled: ipv6_frag_reassemble()
> +	 * patches the IPv6 header's next-header field and removes the fragment
> +	 * header assuming it sits immediately after the IPv6 header, so such a
> +	 * fragment would be reassembled into a corrupt datagram. Drop it.
> +	 *
> +	 * Extension headers after the fragment header (destination options,
> +	 * AH, ESP, upper-layer) are part of the fragmentable payload and are
> +	 * reassembled as opaque bytes, so they are not affected. The test uses
> +	 * the fragment header's position rather than l3_len so that callers
> +	 * which include later headers in l3_len are not rejected.
> +	 */
> +	if ((uintptr_t)frag_hdr !=3D (uintptr_t)(ip_hdr + 1)) {
> +		IP_FRAG_LOG(DEBUG,
> +			    "%s:%d: drop fragment with header before frag header,
> offset %zu\n",
> +			    __func__, __LINE__, (uintptr_t)frag_hdr -
> (uintptr_t)ip_hdr);
> +		IP_FRAG_MBUF2DR(dr, mb);
> +		return NULL;
> +	}
> +
>  	if (unlikely(trim > 0))
>  		rte_pktmbuf_trim(mb, trim);
>=20
> --

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

> 2.53.0

