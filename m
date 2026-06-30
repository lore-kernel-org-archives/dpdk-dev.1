Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABF5C43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 08:08:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 77EE44025E;
	Tue, 30 Jun 2026 10:08:56 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id CB1D44021E;
 Tue, 30 Jun 2026 10:08:54 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gqG3m0Z98zHnH6y;
 Tue, 30 Jun 2026 16:08:04 +0800 (CST)
Received: from dubpeml100001.china.huawei.com (unknown [7.214.144.137])
 by mail.maildlp.com (Postfix) with ESMTPS id D990C40574;
 Tue, 30 Jun 2026 16:08:47 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100001.china.huawei.com (7.214.144.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 30 Jun 2026 09:08:47 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Tue, 30 Jun 2026 09:08:47 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Samyak Jain
 <samyak.jain@amantyatech.com>
Subject: RE: [PATCH 1/6] ip_frag: tolerate duplicate fragments
Thread-Topic: [PATCH 1/6] ip_frag: tolerate duplicate fragments
Thread-Index: AQHc/dQXCJHC/a+41keDiKQUm7EsYLZW0gIA
Date: Tue, 30 Jun 2026 08:08:46 +0000
Message-ID: <de2ff0a594104b9b9cb4575f0ff4f8ed@huawei.com>
References: <20260616210656.464062-1-stephen@networkplumber.org>
 <20260616210656.464062-2-stephen@networkplumber.org>
In-Reply-To: <20260616210656.464062-2-stephen@networkplumber.org>
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



> The reassembly code tracked only a running byte total and reserved slots
> for the first and last fragments, with no check for a fragment
> duplicating data already received. A single duplicate could destroy a
> recoverable datagram:
>  - a duplicate first or last fragment collided with the reserved slot and
>    sent the whole entry down the error path, freeing every collected
>    fragment;
>  - a duplicate intermediate fragment was appended to a new slot, inflatin=
g
>    frag_size past total_size so reassembly never completed.
>=20
> RFC 791 reassembly tolerates duplicates: a fragment covering bytes
> already present carries no new information. Check for an exact duplicate
> (stored fragment with the same offset and length) and drop only that
> mbuf, before frag_size is updated, leaving the entry's accounting
> unchanged.
>=20
> Overlapping fragments with differing bounds are a separate issue
> addressed in the next patch.
>=20
> Fixes: cc8f4d020c0b ("examples/ip_reassembly: initial import")
> Cc: stable@dpdk.org

I am not sure it is a bug and needs to be propagated into the stable releas=
es.
To me it is more like feature improvement.
BTW, as this and next patch does change the behavior and probably overall
performance numbers, - it probably worth to add a line in the release notes=
.
As another thought - it might be squashed with next patch in the series
(ip_frag: discard datagrams with overlapping fragments).
Apart from that:
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

> Reported-by: Samyak Jain <samyak.jain@amantyatech.com>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/ip_frag/ip_frag_internal.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/ip_frag/ip_frag_internal.c b/lib/ip_frag/ip_frag_interna=
l.c
> index 382f42d0e1..9a03ef995a 100644
> --- a/lib/ip_frag/ip_frag_internal.c
> +++ b/lib/ip_frag/ip_frag_internal.c
> @@ -89,7 +89,23 @@ struct rte_mbuf *
>  ip_frag_process(struct ip_frag_pkt *fp, struct rte_ip_frag_death_row *dr=
,
>  	struct rte_mbuf *mb, uint16_t ofs, uint16_t len, uint16_t more_frags)
>  {
> -	uint32_t idx;
> +	uint32_t i, idx;
> +
> +	/*
> +	 * Discard an exact duplicate fragment. If a previously stored fragment
> +	 * already covers the same offset and length, this fragment carries no
> +	 * new data. Reassembly is tolerant of duplicates (RFC 791), so drop
> +	 * only this mbuf and keep the reassembly entry intact rather than
> +	 * treating it as an error. Fragments overlapping an existing one with
> +	 * different bounds are not handled here.
> +	 */
> +	for (i =3D 0; i !=3D fp->last_idx; i++) {
> +		if (fp->frags[i].mb !=3D NULL && fp->frags[i].ofs =3D=3D ofs &&
> +				fp->frags[i].len =3D=3D len) {
> +			IP_FRAG_MBUF2DR(dr, mb);
> +			return NULL;
> +		}
> +	}
>=20
>  	fp->frag_size +=3D len;
>=20
> --
> 2.53.0

