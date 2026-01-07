Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B9AD0D145
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Jan 2026 17:56:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2AA394028E;
	Wed,  7 Jan 2026 18:56:31 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 159BF4021E
 for <dev@dpdk.org>; Wed,  7 Jan 2026 18:56:29 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 37DAA204A4;
 Wed,  7 Jan 2026 18:56:28 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v3] net: optimize raw checksum computation
Date: Wed, 7 Jan 2026 18:56:23 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65630@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260107170415.80275-1-scott.k.mitch1@gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3] net: optimize raw checksum computation
Thread-Index: Adx/97GtpVeCkEpKTPiV/BfuhGwyJwABBWjw
References: <20260107170415.80275-1-scott.k.mitch1@gmail.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: <scott.k.mitch1@gmail.com>,
	<dev@dpdk.org>
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

> From: scott.k.mitch1@gmail.com [mailto:scott.k.mitch1@gmail.com]
> Sent: Wednesday, 7 January 2026 18.04
>=20
> From: Scott Mitchell <scott.k.mitch1@gmail.com>
>=20
> Optimize __rte_raw_cksum() by processing data in larger unrolled loops
> instead of iterating word-by-word. The new implementation processes
> 64-byte blocks (32 x uint16_t) in the hot path, followed by smaller
> 32/16/8/4/2-byte chunks.

Playing around with Godbolt:
https://godbolt.org/z/oYdP9xxfG

With the original code (built with -msse4.2), the compiler vectorizes =
the loop to process 16-byte chunks (instead of the 2-byte chunks the =
source code indicates).
When built with -mavx512f, it processes 32-byte chunks.

IMHO, the compiled output of the new code is too big; using more than 12 =
kB instructions consumes too much L1 Instruction Cache.
I suppose the compiler both vectorizes and loop unrolls.

>=20
> Uses uint32_t accumulator with explicit casts to prevent signed =
integer
> overflow and leverages unaligned_uint16_t for safe unaligned access on
> all platforms. Adds __rte_no_ubsan_alignment attribute to suppress
> false
> positive alignment warnings from UndefinedBehaviorSanitizer.
>=20
> Performance results from cksum_perf_autotest (TSC cycles/byte):
>   Block size    Before    After    Improvement
>          100  0.40-0.64  0.13-0.14    ~3-4x
>         1500  0.49-0.51  0.10-0.11    ~4-5x
>         9000  0.48-0.51  0.11-0.12    ~4x

On which machine do you achieve these perf numbers?

Can a measurable performance increase be achieved using significantly =
smaller compiled code than this patch?

>=20
> Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
> ---
> Changes in v3:
> - Added __rte_no_ubsan_alignment macro to suppress false-positive =
UBSAN
>   alignment warnings when using unaligned_uint16_t
> - Fixed false-positive GCC maybe-uninitialized warning in rte_ip6.h
> exposed
>   by optimization (can be split to separate patch once verified on CI)
>=20
> Changes in v2:
> - Fixed UndefinedBehaviorSanitizer errors by adding uint32_t casts to
> prevent
>   signed integer overflow in addition chains
> - Restored uint32_t sum accumulator instead of uint64_t
> - Added 64k length to test_cksum_perf.c
>=20


> diff --git a/lib/net/rte_cksum.h b/lib/net/rte_cksum.h
> index a8e8927952..d6e313dea5 100644
> --- a/lib/net/rte_cksum.h
> +++ b/lib/net/rte_cksum.h
> @@ -39,24 +39,64 @@ extern "C" {
>   * @return
>   *   sum +=3D Sum of all words in the buffer.
>   */
> +__rte_no_ubsan_alignment
>  static inline uint32_t
>  __rte_raw_cksum(const void *buf, size_t len, uint32_t sum)
>  {
> -	const void *end;
> +	/* Process in 64 byte blocks (32 x uint16_t). */
> +	/* Always process as uint16_t chunks to preserve overflow/carry.
> */
> +	const void *end =3D RTE_PTR_ADD(buf, RTE_ALIGN_FLOOR(len, 64));
> +	while (buf !=3D end) {
> +		const unaligned_uint16_t *p16 =3D (const unaligned_uint16_t
> *)buf;
> +		sum +=3D (uint32_t)p16[0] + p16[1] + p16[2] + p16[3] +
> +			 p16[4] + p16[5] + p16[6] + p16[7] +
> +			 p16[8] + p16[9] + p16[10] + p16[11] +
> +			 p16[12] + p16[13] + p16[14] + p16[15] +
> +			 p16[16] + p16[17] + p16[18] + p16[19] +
> +			 p16[20] + p16[21] + p16[22] + p16[23] +
> +			 p16[24] + p16[25] + p16[26] + p16[27] +
> +			 p16[28] + p16[29] + p16[30] + p16[31];
> +		buf =3D RTE_PTR_ADD(buf, 64);
> +	}
>=20
> -	for (end =3D RTE_PTR_ADD(buf, RTE_ALIGN_FLOOR(len,
> sizeof(uint16_t)));
> -	     buf !=3D end; buf =3D RTE_PTR_ADD(buf, sizeof(uint16_t))) {
> -		uint16_t v;
> +	if (len & 32) {
> +		const unaligned_uint16_t *p16 =3D (const unaligned_uint16_t
> *)buf;
> +		sum +=3D (uint32_t)p16[0] + p16[1] + p16[2] + p16[3] +
> +			 p16[4] + p16[5] + p16[6] + p16[7] +
> +			 p16[8] + p16[9] + p16[10] + p16[11] +
> +			 p16[12] + p16[13] + p16[14] + p16[15];
> +		buf =3D RTE_PTR_ADD(buf, 32);
> +	}
>=20
> -		memcpy(&v, buf, sizeof(uint16_t));
> -		sum +=3D v;
> +	if (len & 16) {
> +		const unaligned_uint16_t *p16 =3D (const unaligned_uint16_t
> *)buf;
> +		sum +=3D (uint32_t)p16[0] + p16[1] + p16[2] + p16[3] +
> +			 p16[4] + p16[5] + p16[6] + p16[7];
> +		buf =3D RTE_PTR_ADD(buf, 16);
>  	}
>=20
> -	/* if length is odd, keeping it byte order independent */
> -	if (unlikely(len % 2)) {
> -		uint16_t left =3D 0;
> +	if (len & 8) {
> +		const unaligned_uint16_t *p16 =3D (const unaligned_uint16_t
> *)buf;
> +		sum +=3D (uint32_t)p16[0] + p16[1] + p16[2] + p16[3];
> +		buf =3D RTE_PTR_ADD(buf, 8);
> +	}
>=20
> -		memcpy(&left, end, 1);
> +	if (len & 4) {
> +		const unaligned_uint16_t *p16 =3D (const unaligned_uint16_t
> *)buf;
> +		sum +=3D (uint32_t)p16[0] + p16[1];
> +		buf =3D RTE_PTR_ADD(buf, 4);
> +	}
> +
> +	if (len & 2) {
> +		const unaligned_uint16_t *p16 =3D (const unaligned_uint16_t
> *)buf;
> +		sum +=3D *p16;
> +		buf =3D RTE_PTR_ADD(buf, 2);
> +	}
> +
> +	/* If length is odd use memcpy for byte order independence */
> +	if (len & 1) {
> +		uint16_t left =3D 0;
> +		memcpy(&left, buf, 1);
>  		sum +=3D left;
>  	}
>=20
> diff --git a/lib/net/rte_ip6.h b/lib/net/rte_ip6.h
> index d1abf1f5d5..af65a39815 100644
> --- a/lib/net/rte_ip6.h
> +++ b/lib/net/rte_ip6.h
> @@ -564,7 +564,7 @@ rte_ipv6_phdr_cksum(const struct rte_ipv6_hdr
> *ipv6_hdr, uint64_t ol_flags)
>  	struct {
>  		rte_be32_t len;   /* L4 length. */
>  		rte_be32_t proto; /* L4 protocol - top 3 bytes must be zero
> */
> -	} psd_hdr;
> +	} psd_hdr =3D {0}; /* Empty initializer avoids false-positive
> maybe-uninitialized warning */
>=20
>  	psd_hdr.proto =3D (uint32_t)(ipv6_hdr->proto << 24);
>  	if (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG))

Maybe ipv6 can be fixed like this instead:
-	if (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG))
-		psd_hdr.len =3D 0;
-	else
-		psd_hdr.len =3D ipv6_hdr->payload_len;
+	psd_hdr.len =3D (ol_flags & (RTE_MBUF_F_TX_TCP_SEG | =
RTE_MBUF_F_TX_UDP_SEG)) ?
+			0 : psd_hdr.len =3D ipv6_hdr->payload_len;

> --
> 2.39.5 (Apple Git-154)

