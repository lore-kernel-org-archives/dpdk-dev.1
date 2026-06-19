Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4D7CD4F26
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 13:12:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57CD0402C3;
	Fri, 19 Jun 2026 15:12:28 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id F2F2E4029D;
 Fri, 19 Jun 2026 15:12:26 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id F22CD201E4;
 Fri, 19 Jun 2026 15:12:25 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH 2/6] ip_frag: discard datagrams with overlapping fragments
Date: Fri, 19 Jun 2026 15:12:21 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6592A@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260616210656.464062-3-stephen@networkplumber.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2/6] ip_frag: discard datagrams with overlapping fragments
Thread-Index: Adz91BzLlb8o4qM6QjSivk0NjQx9zgCGGJmw
References: <20260616210656.464062-1-stephen@networkplumber.org>
 <20260616210656.464062-3-stephen@networkplumber.org>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
	<dev@dpdk.org>
Cc: <stable@dpdk.org>,
	"Konstantin Ananyev" <konstantin.ananyev@huawei.com>
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

> From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> Sent: Tuesday, 16 June 2026 23.06
>=20
> Existing code does not handle overlapping fragments.
>=20
> RFC 8200 (IPv6) requires that on overlap all reassembly is abandoned
> andall received fragments are dropped. RFC 791 (IPv4) originally =
called
> fortrimming and rewriting, but Linux discards for IPv4 as well, since
> overlap has no legitimate use and is a known attack vector.
>=20
> Depends on the duplicate-tolerance change so that an exact duplicate =
is
> dropped on its own rather than discarding the whole datagram.
>=20
> Fixes: cc8f4d020c0b ("examples/ip_reassembly: initial import")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/ip_frag/ip_frag_internal.c | 34 =
++++++++++++++++++++++++++--------
>  1 file changed, 26 insertions(+), 8 deletions(-)
>=20
> diff --git a/lib/ip_frag/ip_frag_internal.c
> b/lib/ip_frag/ip_frag_internal.c
> index 9a03ef995a..2505314a29 100644
> --- a/lib/ip_frag/ip_frag_internal.c
> +++ b/lib/ip_frag/ip_frag_internal.c
> @@ -92,16 +92,34 @@ ip_frag_process(struct ip_frag_pkt *fp, struct
> rte_ip_frag_death_row *dr,
>  	uint32_t i, idx;
>=20
>  	/*
> -	 * Discard an exact duplicate fragment. If a previously stored
> fragment
> -	 * already covers the same offset and length, this fragment
> carries no
> -	 * new data. Reassembly is tolerant of duplicates (RFC 791), so
> drop
> -	 * only this mbuf and keep the reassembly entry intact rather
> than
> -	 * treating it as an error. Fragments overlapping an existing one
> with
> -	 * different bounds are not handled here.
> +	 * Scan the fragments already collected for this datagram before
> +	 * storing the new one. The stored set is kept free of duplicates
> and
> +	 * overlaps, so a single pass is sufficient.
>  	 */
>  	for (i =3D 0; i !=3D fp->last_idx; i++) {
> -		if (fp->frags[i].mb !=3D NULL && fp->frags[i].ofs =3D=3D ofs &&
> -				fp->frags[i].len =3D=3D len) {
> +		if (fp->frags[i].mb =3D=3D NULL)
> +			continue;
> +
> +		/*
> +		 * Exact duplicate: carries no new data. Reassembly
> tolerates
> +		 * duplicates (RFC 791), so drop only this mbuf and keep
> the
> +		 * entry.
> +		 */
> +		if (fp->frags[i].ofs =3D=3D ofs && fp->frags[i].len =3D=3D len) {
> +			IP_FRAG_MBUF2DR(dr, mb);
> +			return NULL;
> +		}
> +
> +		/*
> +		 * Overlap with an existing fragment. Per RFC 8200 section
> 4.5
> +		 * (and RFC 5722) the datagram must be discarded; the same
> is
> +		 * applied to IPv4. Free all collected fragments, drop this
> one,
> +		 * and invalidate the entry.
> +		 */
> +		if (ofs < fp->frags[i].ofs + fp->frags[i].len &&
> +				fp->frags[i].ofs < ofs + len) {

This only catches fragments that are smaller than existing fragments, =
i.e. fit within one of the existing fragments.
It should be:
if ((ofs >=3D fp->frags[i].ofs &&
		ofs < fp->frags[i].ofs + fp->frags[i].len) ||
		(ofs + len >=3D fp->frags[i].ofs &&
		ofs + len < fp->frags[i].ofs + fp->frags[i].len)) {

> +			ip_frag_free(fp, dr);
> +			ip_frag_key_invalidate(&fp->key);
>  			IP_FRAG_MBUF2DR(dr, mb);
>  			return NULL;
>  		}
> --
> 2.53.0

