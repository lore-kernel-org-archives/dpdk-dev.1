Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF13FC43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Jul 2026 08:13:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1036402E0;
	Wed,  1 Jul 2026 10:13:25 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 1A03640278;
 Wed,  1 Jul 2026 10:13:25 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gqt6V2FKMzJ46XJ;
 Wed,  1 Jul 2026 16:12:34 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (unknown [7.214.147.241])
 by mail.maildlp.com (Postfix) with ESMTPS id 32F7E40572;
 Wed,  1 Jul 2026 16:13:22 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500001.china.huawei.com (7.214.147.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 1 Jul 2026 09:13:21 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Wed, 1 Jul 2026 09:13:21 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v2 2/8] ip_frag: discard datagrams with overlapping
 fragments
Thread-Topic: [PATCH v2 2/8] ip_frag: discard datagrams with overlapping
 fragments
Thread-Index: AQHdCKZfAbPKRbTp1E+3K/nP8uTcFLZYUWqw
Date: Wed, 1 Jul 2026 08:13:21 +0000
Message-ID: <0ab67622237b45768b07d27dbdaced40@huawei.com>
References: <20260616210656.464062-1-stephen@networkplumber.org>
 <20260630153723.525167-1-stephen@networkplumber.org>
 <20260630153723.525167-3-stephen@networkplumber.org>
In-Reply-To: <20260630153723.525167-3-stephen@networkplumber.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.45.146.116]
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



> Existing code does not handle overlapping fragments.
>=20
> RFC 8200 (IPv6) requires that on overlap all reassembly is abandoned
> and all received fragments are dropped. RFC 791 (IPv4) originally called
> for trimming and rewriting, but Linux discards for IPv4 as well, since
> overlap has no legitimate use and is a known attack vector.
>=20
> Depends on the duplicate-tolerance change so that an exact duplicate is
> dropped on its own rather than discarding the whole datagram.
>=20
> Fixes: cc8f4d020c0b ("examples/ip_reassembly: initial import")
> Cc: stable@dpdk.org

I think you forgot to remove cc; stable.

>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
> ---
>  lib/ip_frag/ip_frag_internal.c | 38 +++++++++++++++++++++++++++-------
>  1 file changed, 30 insertions(+), 8 deletions(-)
>=20
> diff --git a/lib/ip_frag/ip_frag_internal.c b/lib/ip_frag/ip_frag_interna=
l.c
> index 9a03ef995a..55fc4e9343 100644
> --- a/lib/ip_frag/ip_frag_internal.c
> +++ b/lib/ip_frag/ip_frag_internal.c
> @@ -92,16 +92,38 @@ ip_frag_process(struct ip_frag_pkt *fp, struct
> rte_ip_frag_death_row *dr,
>  	uint32_t i, idx;
>=20
>  	/*
> -	 * Discard an exact duplicate fragment. If a previously stored fragment
> -	 * already covers the same offset and length, this fragment carries no
> -	 * new data. Reassembly is tolerant of duplicates (RFC 791), so drop
> -	 * only this mbuf and keep the reassembly entry intact rather than
> -	 * treating it as an error. Fragments overlapping an existing one with
> -	 * different bounds are not handled here.
> +	 * Scan the fragments already collected for this datagram before
> +	 * storing the new one. The stored set is kept free of duplicates and
> +	 * overlaps, so a single pass is sufficient.
>  	 */
>  	for (i =3D 0; i !=3D fp->last_idx; i++) {
> -		if (fp->frags[i].mb !=3D NULL && fp->frags[i].ofs =3D=3D ofs &&
> -				fp->frags[i].len =3D=3D len) {
> +		if (fp->frags[i].mb =3D=3D NULL)
> +			continue;
> +
> +		/*
> +		 * Exact duplicate: carries no new data. Reassembly tolerates
> +		 * duplicates (RFC 791), so drop only this mbuf and keep the
> +		 * entry.
> +		 */
> +		if (fp->frags[i].ofs =3D=3D ofs && fp->frags[i].len =3D=3D len) {
> +			IP_FRAG_MBUF2DR(dr, mb);
> +			return NULL;
> +		}
> +
> +		/*
> +		 * Overlap with an existing fragment. Per RFC 8200 section 4.5
> +		 * (and RFC 5722) the datagram must be discarded; the same is
> +		 * applied to IPv4. Free all collected fragments, drop this one,
> +		 * and invalidate the entry.
> +		 */
> +		if (ofs < fp->frags[i].ofs + fp->frags[i].len && fp->frags[i].ofs < of=
s +
> len) {
> +			IP_FRAG_LOG(DEBUG,
> +				    "%s:%d overlap ofs: %u len: %u\n"
> +				    "fragment: %p ofs: %u len %u\n\n",
> +				    __func__, __LINE__, ofs, len,
> +				    fp, fp->frags[i].ofs, fp->frags[i].len);
> +			ip_frag_free(fp, dr);
> +			ip_frag_key_invalidate(&fp->key);
>  			IP_FRAG_MBUF2DR(dr, mb);
>  			return NULL;
>  		}
> --
> 2.53.0

