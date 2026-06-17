Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1233CD98E2
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 20:02:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1BE5740276;
	Wed, 17 Jun 2026 22:02:23 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id A868040268
 for <dev@dpdk.org>; Wed, 17 Jun 2026 22:02:22 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4ggZWN21sNzJ4692;
 Thu, 18 Jun 2026 04:01:52 +0800 (CST)
Received: from frapema100004.china.huawei.com (unknown [7.182.19.128])
 by mail.maildlp.com (Postfix) with ESMTPS id CB10140584;
 Thu, 18 Jun 2026 04:02:17 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100004.china.huawei.com (7.182.19.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 17 Jun 2026 22:02:17 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Wed, 17 Jun 2026 22:02:17 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Su Sai <spiderdetective.ss@gmail.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>
Subject: RE: [v4] net/cksum: compute raw cksum for several segments
Thread-Topic: [v4] net/cksum: compute raw cksum for several segments
Thread-Index: AQHc/Y0RKuxCBipgk0u28PYTLKFC4bZDK7Jw
Date: Wed, 17 Jun 2026 20:02:17 +0000
Message-ID: <1f2b21bd87a24610bc09b3b8da8100b5@huawei.com>
References: <20260608100202.0deac83d@phoenix.local>
 <20260616123812.21048-1-spiderdetective.ss@gmail.com>
In-Reply-To: <20260616123812.21048-1-spiderdetective.ss@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.72.97]
Content-Type: text/plain; charset="iso-2022-jp"
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

> -----Original Message-----
> From: Su Sai <spiderdetective.ss@gmail.com>
> Sent: Tuesday 16 June 2026 13:38
> To: stephen@networkplumber.org
> Cc: dev@dpdk.org; spiderdetective.ss@gmail.com
> Subject: [v4] net/cksum: compute raw cksum for several segments
>=20
> The rte_raw_cksum_mbuf function is used to compute
> the raw checksum of a packet.
> If the packet payload stored in multi mbuf, the function
> will goto the hard case. In hard case,
> the variable 'tmp' is a type of uint32_t,
> so rte_bswap16 will drop high 16 bit.
> Meanwhile, the variable 'sum' is a type of uint32_t,
> so 'sum +=3D tmp' will drop the carry when overflow.
> Both drop will make cksum incorrect.
> This commit fixes the above bug.
>=20
> Signed-off-by: Su Sai <spiderdetective.ss@gmail.com>

You can add:

Acked-by: Marat Khalili <marat.khalili@huawei.com>

> ---
>  .mailmap              |   1 +
>  app/test/test_cksum.c | 102 ++++++++++++++++++++++++++++++++++++++++++
>  lib/net/rte_cksum.h   |  27 +++++++++--
>  3 files changed, 126 insertions(+), 4 deletions(-)
>=20
> diff --git a/.mailmap b/.mailmap
> index 4001e5fb0e..bcf73cb902 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -1630,6 +1630,7 @@ Sylvia Grundw=1B$BH}=1B(Brmer <sylvia.grundwuermer@=
b-plus.com>
>  Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
>  Sylwia Wnuczko <sylwia.wnuczko@intel.com>
>  Szymon Sliwa <szs@semihalf.com>
> +Su Sai <spiderdetective.ss@gmail.com> <susai.ss@bytedance.com>
>  Szymon T Cudzilo <szymon.t.cudzilo@intel.com>
>  Tadhg Kearney <tadhg.kearney@intel.com>
>  Taekyung Kim <kim.tae.kyung@navercorp.com>
> diff --git a/app/test/test_cksum.c b/app/test/test_cksum.c
> index ea443382a1..5bd9723fbd 100644
> --- a/app/test/test_cksum.c
> +++ b/app/test/test_cksum.c
> @@ -85,6 +85,42 @@ static const char test_cksum_ipv4_opts_udp[] =3D {
>  	0x00, 0x35, 0x00, 0x09, 0x89, 0x6f, 0x78,
>  };
>=20
> +/*
> + * generated in scapy with
> + * Ether()/IP()/TCP(options=3D[NOP,NOP,Timestamps])/os.urandom(113))
> + */
> +static const char test_cksum_ipv4_tcp_multi_segs[] =3D {
> +	0x00, 0x16, 0x3e, 0x0b, 0x6b, 0xd2, 0xee, 0xff,
> +	0xff, 0xff, 0xff, 0xff, 0x08, 0x00, 0x45, 0x00,
> +	0x00, 0xa5, 0x46, 0x10, 0x40, 0x00, 0x40, 0x06,
> +	0x80, 0xb5, 0xc0, 0xa8, 0xf9, 0x1d, 0xc0, 0xa8,
> +	0xf9, 0x1e, 0xdc, 0xa2, 0x14, 0x51, 0xbb, 0x8f,
> +	0xa0, 0x00, 0xe4, 0x7c, 0xe4, 0xb8, 0x80, 0x10,
> +	0x02, 0x00, 0x4b, 0xc1, 0x00, 0x00, 0x01, 0x01,
> +	0x08, 0x0a, 0x90, 0x60, 0xf4, 0xff, 0x03, 0xc5,
> +	0xb4, 0x19, 0x77, 0x34, 0xd4, 0xdc, 0x84, 0x86,
> +	0xff, 0x44, 0x09, 0x63, 0x36, 0x2e, 0x26, 0x9b,
> +	0x90, 0x70, 0xf2, 0xed, 0xc8, 0x5b, 0x87, 0xaa,
> +	0xb4, 0x67, 0x6b, 0x32, 0x3d, 0xc4, 0xbf, 0x15,
> +	0xa9, 0x16, 0x6c, 0x2a, 0x9d, 0xb2, 0xb7, 0x6b,
> +	0x58, 0x44, 0x58, 0x12, 0x4b, 0x8f, 0xe5, 0x12,
> +	0x11, 0x90, 0x94, 0x68, 0x37, 0xad, 0x0a, 0x9b,
> +	0xd6, 0x79, 0xf2, 0xb7, 0x31, 0xcf, 0x44, 0x22,
> +	0xc8, 0x99, 0x3f, 0xe5, 0xe7, 0xac, 0xc7, 0x0b,
> +	0x86, 0xdf, 0xda, 0xed, 0x0a, 0x0f, 0x86, 0xd7,
> +	0x48, 0xe2, 0xf1, 0xc2, 0x43, 0xed, 0x47, 0x3a,
> +	0xea, 0x25, 0x2d, 0xd6, 0x60, 0x38, 0x30, 0x07,
> +	0x28, 0xdd, 0x1f, 0x0c, 0xdd, 0x7b, 0x7c, 0xd9,
> +	0x35, 0x9d, 0x14, 0xaa, 0xc6, 0x35, 0xd1, 0x03,
> +	0x38, 0xb1, 0xf5,
> +};
> +
> +static const uint8_t test_cksum_ipv4_tcp_multi_segs_len[] =3D {
> +	66,  /* the first seg contains all headers, including L2 to L4 */
> +	61,  /* the second seg length is odd, test byte order independent */
> +	52,  /* three segs are sufficient to test the most complex scenarios */
> +};
> +
>  /* test l3/l4 checksum api */
>  static int
>  test_l4_cksum(struct rte_mempool *pktmbuf_pool, const char *pktdata, siz=
e_t len)
> @@ -223,6 +259,66 @@ test_l4_cksum(struct rte_mempool *pktmbuf_pool, cons=
t char *pktdata, size_t len)
>  	return -1;
>  }
>=20
> +/* test l4 checksum api for a packet with multiple mbufs */
> +static int
> +test_l4_cksum_multi_mbufs(struct rte_mempool *pktmbuf_pool, const char *=
pktdata, size_t len,
> +			     const uint8_t *segs, size_t segs_len)
> +{
> +	struct rte_mbuf *m[NB_MBUF] =3D {0};
> +	struct rte_mbuf *m_hdr =3D NULL;
> +	struct rte_net_hdr_lens hdr_lens;
> +	size_t i, off =3D 0;
> +	uint32_t packet_type, l3;
> +	void *l3_hdr;
> +	char *data;
> +
> +	for (i =3D 0; i < segs_len; i++) {
> +		m[i] =3D rte_pktmbuf_alloc(pktmbuf_pool);
> +		if (m[i] =3D=3D NULL)
> +			GOTO_FAIL("Cannot allocate mbuf");
> +
> +		data =3D rte_pktmbuf_append(m[i], segs[i]);
> +		if (data =3D=3D NULL)
> +			GOTO_FAIL("Cannot append data");
> +
> +		memcpy(data, pktdata + off, segs[i]);
> +		off +=3D segs[i];
> +
> +		if (m_hdr) {
> +			if (rte_pktmbuf_chain(m_hdr, m[i]))
> +				GOTO_FAIL("Cannot chain mbuf");
> +		} else {
> +			m_hdr =3D m[i];
> +		}
> +	}
> +
> +	if (off !=3D len)
> +		GOTO_FAIL("Invalid segs");
> +
> +	packet_type =3D rte_net_get_ptype(m_hdr, &hdr_lens, RTE_PTYPE_ALL_MASK)=
;
> +	l3 =3D packet_type & RTE_PTYPE_L3_MASK;
> +
> +	l3_hdr =3D rte_pktmbuf_mtod_offset(m_hdr, void *, hdr_lens.l2_len);
> +	off =3D hdr_lens.l2_len + hdr_lens.l3_len;
> +
> +	if (l3 =3D=3D RTE_PTYPE_L3_IPV4 || l3 =3D=3D RTE_PTYPE_L3_IPV4_EXT) {
> +		if (rte_ipv4_udptcp_cksum_mbuf_verify(m_hdr, l3_hdr, off) !=3D 0)
> +			GOTO_FAIL("Invalid L4 checksum verification for multiple mbufs");
> +	} else if (l3 =3D=3D RTE_PTYPE_L3_IPV6 || l3 =3D=3D RTE_PTYPE_L3_IPV6_E=
XT) {
> +		if (rte_ipv6_udptcp_cksum_mbuf_verify(m_hdr, l3_hdr, off) !=3D 0)
> +			GOTO_FAIL("Invalid L4 checksum verification for multiple mbufs");
> +	}
> +
> +	rte_pktmbuf_free_bulk(m, segs_len);
> +
> +	return 0;
> +
> +fail:
> +	rte_pktmbuf_free_bulk(m, segs_len);
> +
> +	return -1;
> +}
> +
>  static int
>  test_cksum(void)
>  {
> @@ -256,6 +352,12 @@ test_cksum(void)
>  			  sizeof(test_cksum_ipv4_opts_udp)) < 0)
>  		GOTO_FAIL("checksum error on ipv4_opts_udp");
>=20
> +	if (test_l4_cksum_multi_mbufs(pktmbuf_pool, test_cksum_ipv4_tcp_multi_s=
egs,
> +			  sizeof(test_cksum_ipv4_tcp_multi_segs),
> +			  test_cksum_ipv4_tcp_multi_segs_len,
> +			  sizeof(test_cksum_ipv4_tcp_multi_segs_len)) < 0)
> +		GOTO_FAIL("checksum error on multi mbufs check");
> +
>  	rte_mempool_free(pktmbuf_pool);
>=20
>  	return 0;
> diff --git a/lib/net/rte_cksum.h b/lib/net/rte_cksum.h
> index a8e8927952..679ba82eb6 100644
> --- a/lib/net/rte_cksum.h
> +++ b/lib/net/rte_cksum.h
> @@ -80,6 +80,25 @@ __rte_raw_cksum_reduce(uint32_t sum)
>  	return (uint16_t)sum;
>  }
>=20
> +/**
> + * @internal Reduce a sum to the non-complemented checksum.
> + * Helper routine for the rte_raw_cksum_mbuf().
> + *
> + * @param sum
> + *   Value of the sum.
> + * @return
> + *   The non-complemented checksum.
> + */
> +static inline uint16_t
> +__rte_raw_cksum_reduce_u64(uint64_t sum)
> +{
> +	uint32_t tmp;
> +
> +	tmp =3D __rte_raw_cksum_reduce((uint32_t)sum);
> +	tmp +=3D __rte_raw_cksum_reduce((uint32_t)(sum >> 32));
> +	return __rte_raw_cksum_reduce(tmp);
> +}
> +
>  /**
>   * Process the non-complemented checksum of a buffer.
>   *
> @@ -119,8 +138,8 @@ rte_raw_cksum_mbuf(const struct rte_mbuf *m, uint32_t=
 off, uint32_t len,
>  {
>  	const struct rte_mbuf *seg;
>  	const char *buf;
> -	uint32_t sum, tmp;
> -	uint32_t seglen, done;
> +	uint32_t seglen, done, tmp;
> +	uint64_t sum;
>=20
>  	/* easy case: all data in the first segment */
>  	if (off + len <=3D rte_pktmbuf_data_len(m)) {
> @@ -157,7 +176,7 @@ rte_raw_cksum_mbuf(const struct rte_mbuf *m, uint32_t=
 off, uint32_t len,
>  	for (;;) {
>  		tmp =3D __rte_raw_cksum(buf, seglen, 0);
>  		if (done & 1)
> -			tmp =3D rte_bswap16((uint16_t)tmp);
> +			tmp =3D rte_bswap32(tmp);
>  		sum +=3D tmp;
>  		done +=3D seglen;
>  		if (done =3D=3D len)
> @@ -169,7 +188,7 @@ rte_raw_cksum_mbuf(const struct rte_mbuf *m, uint32_t=
 off, uint32_t len,
>  			seglen =3D len - done;
>  	}
>=20
> -	*cksum =3D __rte_raw_cksum_reduce(sum);
> +	*cksum =3D __rte_raw_cksum_reduce_u64(sum);
>  	return 0;
>  }
>=20
> --
> 2.20.1

