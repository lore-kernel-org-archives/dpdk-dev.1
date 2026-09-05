Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D58C624D3
	for <dpdk-dev@archiver.kernel.org>; Sat,  5 Sep 2026 10:00:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FD044278D;
	Sat,  5 Sep 2026 12:00:36 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id ADF0C40687
 for <dev@dpdk.org>; Sat,  5 Sep 2026 12:00:34 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 7542B20F85;
 Sat,  5 Sep 2026 12:00:32 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [RFC 2/3] net/mlx5: drop unnecessary STRICT_ALIGN
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Sat, 5 Sep 2026 12:00:30 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65A35@smartserver.smartshare.dk>
In-Reply-To: <20260904220953.3105930-3-stephen@networkplumber.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC 2/3] net/mlx5: drop unnecessary STRICT_ALIGN
Thread-Index: Ad08uiuk3v7goUlgSz6/jxPet+bczQAXwVuA
References: <20260904220953.3105930-1-stephen@networkplumber.org>
 <20260904220953.3105930-3-stephen@networkplumber.org>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>, <dev@dpdk.org>,
 "Wathsala Vithanage" <wathsala.vithanage@arm.com>,
 "Sun Yuechi" <sunyuechi@iscas.ac.cn>, "Bibo Mao" <maobibo@loongson.cn>
Cc: "Dariusz Sosnowski" <dsosnowski@nvidia.com>,
 "Viacheslav Ovsiienko" <viacheslavo@nvidia.com>,
 "Bing Zhao" <bingz@nvidia.com>, "Ori Kam" <orika@nvidia.com>,
 "Suanming Mou" <suanmingm@nvidia.com>, "Matan Azrad" <matan@nvidia.com>
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

+ARM, RISC-V, LoongArch maintainers

> From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> Sent: Saturday, 5 September 2026 00.09
>=20
> The transmit inline copy splits the 8 byte case into two 32 bit
> moves when RTE_ARCH_STRICT_ALIGN is set. Only armv8 aarch32 ever
> set that flag, and ARMv8 does unaligned access in hardware, so the
> split gains nothing. Use a single 64 bit move.
>=20
> The destination is inline_data, at offset 4 of a 16 byte aligned
> dseg, so the 8 byte store is always misaligned. Write it through
> the unaligned type; a plain uint64_t store there is undefined
> behaviour and is reported by UBSAN.
>=20
> The debug assertion on the inline data offset goes away with the
> strict alignment path since the wider move has no such requirement.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/mlx5/mlx5_tx.h | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>=20
> diff --git a/drivers/net/mlx5/mlx5_tx.h b/drivers/net/mlx5/mlx5_tx.h
> index 682dc07718..69a18f8a49 100644
> --- a/drivers/net/mlx5/mlx5_tx.h
> +++ b/drivers/net/mlx5/mlx5_tx.h
> @@ -1437,19 +1437,9 @@ mlx5_tx_dseg_iptr(struct mlx5_txq_data
> *__rte_restrict txq,
>  	dst =3D (uintptr_t)&dseg->inline_data[0];
>  	src =3D (uintptr_t)buf;
>  	if (len & 0x08) {
> -#ifdef RTE_ARCH_STRICT_ALIGN
> -		MLX5_ASSERT(dst =3D=3D RTE_PTR_ALIGN(dst, sizeof(uint32_t)));
> -		*(uint32_t *)dst =3D *(unaligned_uint32_t *)src;
> -		dst +=3D sizeof(uint32_t);
> -		src +=3D sizeof(uint32_t);
> -		*(uint32_t *)dst =3D *(unaligned_uint32_t *)src;
> -		dst +=3D sizeof(uint32_t);
> -		src +=3D sizeof(uint32_t);
> -#else
> -		*(uint64_t *)dst =3D *(unaligned_uint64_t *)src;
> +		*(unaligned_uint64_t *)dst =3D *(unaligned_uint64_t *)src;
>  		dst +=3D sizeof(uint64_t);
>  		src +=3D sizeof(uint64_t);
> -#endif
>  	}
>  	if (len & 0x04) {
>  		*(uint32_t *)dst =3D *(unaligned_uint32_t *)src;
> --
> 2.53.0

This RFC series is an interesting idea!

I'm in favor of eliminating RTE_ARCH_STRICT_ALIGN and #ifdefs like the =
one in this patch; it makes the code cleaner.

And if we want to provide means for performance optimized code for =
architectures where alignment matter, we could introduce an =
"aligned4_uint64_t" type in addition to the "unaligned_uint64_t" type:

https://godbolt.org/z/Ts4jhcdoW

I'm not aware of the actual performance benefit such a new type would =
provide.

BTW: The names could be shorter, e.g. "uint64u_t" or "uint64a1_t" =
instead of "unaligned_uint64_t" for the unaligned type, and "uint64a4_t" =
for the 4-byte aligned type.

-Morten

