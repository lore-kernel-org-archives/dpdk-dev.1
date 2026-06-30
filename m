Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAD4C43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 09:21:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B0A14025E;
	Tue, 30 Jun 2026 11:21:54 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 30F584021E;
 Tue, 30 Jun 2026 11:21:53 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gqHh1046szJ46bN;
 Tue, 30 Jun 2026 17:21:05 +0800 (CST)
Received: from dubpeml500002.china.huawei.com (unknown [7.214.145.83])
 by mail.maildlp.com (Postfix) with ESMTPS id 51FA540577;
 Tue, 30 Jun 2026 17:21:51 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500002.china.huawei.com (7.214.145.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 30 Jun 2026 10:21:50 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Tue, 30 Jun 2026 10:21:50 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Thomas Monjalon <thomas@monjalon.net>
Subject: RE: [PATCH 4/6] ip_frag: drop IPv6 fragments with unexpected headers
Thread-Topic: [PATCH 4/6] ip_frag: drop IPv6 fragments with unexpected headers
Thread-Index: AQHc/dQa81AjnUKxkUKQIuI8cZBDybZW5aUA
Date: Tue, 30 Jun 2026 09:21:50 +0000
Message-ID: <c7a6a466552d488e81f7c9071826cc88@huawei.com>
References: <20260616210656.464062-1-stephen@networkplumber.org>
 <20260616210656.464062-5-stephen@networkplumber.org>
In-Reply-To: <20260616210656.464062-5-stephen@networkplumber.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.81.205.173]
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



> DPDK version of IPv6 reassembly only handles a fragment header placed
> directly after the IPv6 header. With other extension headers in the
> unfragmentable part, ipv6_frag_reassemble() patches the wrong
> next-header field, miscomputes the payload length, and shifts the
> wrong bytes, corrupting the result.
>=20
> Drop the fragment when l3_len covers more than the IPv6 and fragment
> headers. RFC 8200 allows a receiver to discard packets whose extension
> headers are not in the recommended order, and RFC 9099 recommends
> dropping non-conforming fragmented IPv6 packets, so dropping here is
> permitted rather than a deviation.
>=20
> Fixes: 4f1a8f633862 ("ip_frag: add IPv6 reassembly")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/ip_frag/rte_ipv6_reassembly.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/lib/ip_frag/rte_ipv6_reassembly.c b/lib/ip_frag/rte_ipv6_rea=
ssembly.c
> index 0e809a01e5..7c1659002b 100644
> --- a/lib/ip_frag/rte_ipv6_reassembly.c
> +++ b/lib/ip_frag/rte_ipv6_reassembly.c
> @@ -180,6 +180,19 @@ rte_ipv6_frag_reassemble_packet(struct rte_ip_frag_t=
bl
> *tbl,
>  		return NULL;
>  	}
>=20
> +	/*
> +	 * Only a fragment header directly following the IPv6 header is
> +	 * supported. Other extension headers in the unfragmentable part are
> +	 * not handled: ipv6_frag_reassemble() assumes l3_len covers exactly
> +	 * the IPv6 and fragment headers when it patches the next-header field
> +	 * and removes the fragment header. Drop the fragment rather than
> +	 * produce a corrupt datagram.
> +	 */
> +	if (mb->l3_len !=3D sizeof(struct rte_ipv6_hdr) + sizeof(*frag_hdr)) {
> +		IP_FRAG_MBUF2DR(dr, mb);
> +		return NULL;
> +	}
> +

Hmm, not sure this is a right thing.
Yes, we don't support properly ipv6 options that are *before* fragment hrea=
der
(so called Per-Fragment  Headers), but AFAIR we do support ipv6 options
that come *after* fragment header (Extension headers).=20

>  	if (unlikely(trim > 0))
>  		rte_pktmbuf_trim(mb, trim);
>=20
> --
> 2.53.0

