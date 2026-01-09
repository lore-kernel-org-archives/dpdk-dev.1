Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3A4D26D8C
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Jan 2026 18:28:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B26454028E;
	Fri,  9 Jan 2026 19:28:10 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 3E327400D5
 for <dev@dpdk.org>; Fri,  9 Jan 2026 19:28:09 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 4ED7420679;
 Fri,  9 Jan 2026 19:28:08 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v11] net: optimize raw checksum computation
Date: Fri, 9 Jan 2026 19:28:05 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6563F@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260108230509.6541-1-scott.k.mitch1@gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v11] net: optimize raw checksum computation
Thread-Index: AdyA80DEgjZxBvQcQ9iZsgK66ZXnQAAoEnNg
References: <20260108230509.6541-1-scott.k.mitch1@gmail.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: <scott.k.mitch1@gmail.com>,
	<dev@dpdk.org>
Cc: <stephen@networkplumber.org>
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

>  static inline uint32_t
>  __rte_raw_cksum(const void *buf, size_t len, uint32_t sum)
>  {
> -	const void *end;
> -
> -	for (end =3D RTE_PTR_ADD(buf, RTE_ALIGN_FLOOR(len,
> sizeof(uint16_t)));
> -	     buf !=3D end; buf =3D RTE_PTR_ADD(buf, sizeof(uint16_t))) {
> -		uint16_t v;
> -
> -		memcpy(&v, buf, sizeof(uint16_t));
> -		sum +=3D v;
> -	}
> +	/* Process uint16 chunks to preserve overflow/carry math.
> GCC/Clang vectorize the loop. */
> +	const unaligned_uint16_t *buf16 =3D (const unaligned_uint16_t
> *)buf;
> +	const unaligned_uint16_t *end =3D buf16 + (len / sizeof(uint16_t));
> +	for (; buf16 !=3D end; buf16++)
> +		sum +=3D *buf16;

Here are some more thoughts about loop unroll...
In another mail [1], you are discussing manual loop unroll for =
rte_ipv4/ipv6_phdr_cksum().
Perhaps the compiler already loop unrolls those.
Check the assembler output for the existing code calling =
__rte_raw_cksum().
If the compiler doesn't loop unroll __rte_raw_cksum() for those two =
functions, maybe you can help it by modifying __rte_raw_cksum(); try =
replacing the end pointer with an int counter, which will be compile =
time constant when called by rte_ipv4/ipv6_phdr_cksum().

[1]: =
https://inbox.dpdk.org/dev/CAFn2buA5NzmzA0+t1_5auigvQTyT7Ne6RMVaPVU=3DsdC=
03nd2Lg@mail.gmail.com/

PS: I do the following when optimizing inline functions: Add non-inline =
functions calling the inline functions, and then use "objdump -S" to =
look at the generated code. E.g.:

uint32_t review__rte_raw_cksum(const void *buf, size_t len, uint32_t =
sum)
{ return __rte_raw_cksum(buf, len, sum); }

uint32_t review__rte_raw_cksum_len20(const void *buf, uint32_t sum)
{ return __rte_raw_cksum(buf, 20, sum); }

uint32_t review__rte_raw_cksum_len8(const void *buf, uint32_t sum)
{ return __rte_raw_cksum(buf, 8, sum); }

>=20
>  	/* if length is odd, keeping it byte order independent */
> -	if (unlikely(len % 2)) {
> +	if (len & 1) {
>  		uint16_t left =3D 0;
> -
>  		memcpy(&left, end, 1);
>  		sum +=3D left;
>  	}
> diff --git a/lib/net/rte_ip4.h b/lib/net/rte_ip4.h
> index 822a660cfb..63852717c9 100644
> --- a/lib/net/rte_ip4.h
> +++ b/lib/net/rte_ip4.h
> @@ -223,21 +223,17 @@ rte_ipv4_phdr_cksum(const struct rte_ipv4_hdr
> *ipv4_hdr, uint64_t ol_flags)
>  		uint8_t  zero;     /* zero. */
>  		uint8_t  proto;    /* L4 protocol type. */
>  		uint16_t len;      /* L4 length. */
> -	} psd_hdr;
> -
> -	uint32_t l3_len;
> -
> -	psd_hdr.src_addr =3D ipv4_hdr->src_addr;
> -	psd_hdr.dst_addr =3D ipv4_hdr->dst_addr;
> -	psd_hdr.zero =3D 0;
> -	psd_hdr.proto =3D ipv4_hdr->next_proto_id;
> -	if (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG)) {
> -		psd_hdr.len =3D 0;
> -	} else {
> -		l3_len =3D rte_be_to_cpu_16(ipv4_hdr->total_length);
> -		psd_hdr.len =3D rte_cpu_to_be_16((uint16_t)(l3_len -
> -			rte_ipv4_hdr_len(ipv4_hdr)));
> -	}
> +	} psd_hdr =3D {
> +		.src_addr =3D ipv4_hdr->src_addr,
> +		.dst_addr =3D ipv4_hdr->dst_addr,
> +		.proto =3D ipv4_hdr->next_proto_id,
> +		.len =3D (ol_flags & (RTE_MBUF_F_TX_TCP_SEG |
> RTE_MBUF_F_TX_UDP_SEG))
> +			? (uint16_t)0
> +			:
> rte_cpu_to_be_16((uint16_t)(rte_be_to_cpu_16(ipv4_hdr->total_length) -
> +					rte_ipv4_hdr_len(ipv4_hdr)))
> +	};
> +	RTE_SUPPRESS_UNINITIALIZED_WARNING(psd_hdr);
> +
>  	return rte_raw_cksum(&psd_hdr, sizeof(psd_hdr));
>  }
>=20
> diff --git a/lib/net/rte_ip6.h b/lib/net/rte_ip6.h
> index d1abf1f5d5..8a7e5e4b8a 100644
> --- a/lib/net/rte_ip6.h
> +++ b/lib/net/rte_ip6.h
> @@ -560,19 +560,18 @@ rte_ipv6_phdr_cksum(const struct rte_ipv6_hdr
> *ipv6_hdr, uint64_t ol_flags)
>  static inline uint16_t
>  rte_ipv6_phdr_cksum(const struct rte_ipv6_hdr *ipv6_hdr, uint64_t
> ol_flags)
>  {
> -	uint32_t sum;
>  	struct {
>  		rte_be32_t len;   /* L4 length. */
>  		rte_be32_t proto; /* L4 protocol - top 3 bytes must be zero
> */
> -	} psd_hdr;
> -
> -	psd_hdr.proto =3D (uint32_t)(ipv6_hdr->proto << 24);
> -	if (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG))
> -		psd_hdr.len =3D 0;
> -	else
> -		psd_hdr.len =3D ipv6_hdr->payload_len;
> +	} psd_hdr =3D {
> +		.len =3D (ol_flags & (RTE_MBUF_F_TX_TCP_SEG |
> RTE_MBUF_F_TX_UDP_SEG))
> +			? (rte_be32_t)0
> +			: ipv6_hdr->payload_len,
> +		.proto =3D (uint32_t)(ipv6_hdr->proto << 24)
> +	};
> +	RTE_SUPPRESS_UNINITIALIZED_WARNING(psd_hdr);
>=20
> -	sum =3D __rte_raw_cksum(&ipv6_hdr->src_addr,
> +	uint32_t sum =3D __rte_raw_cksum(&ipv6_hdr->src_addr,
>  		sizeof(ipv6_hdr->src_addr) + sizeof(ipv6_hdr->dst_addr),
>  		0);
>  	sum =3D __rte_raw_cksum(&psd_hdr, sizeof(psd_hdr), sum);
> --
> 2.39.5 (Apple Git-154)

