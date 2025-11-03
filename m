Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9DBCCFA03
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 09:21:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7941240285;
	Mon,  3 Nov 2025 10:21:33 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 03E9E40281
 for <dev@dpdk.org>; Mon,  3 Nov 2025 10:21:31 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d0R0T1M7kzJ46XM;
 Mon,  3 Nov 2025 17:21:13 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (unknown [7.214.147.241])
 by mail.maildlp.com (Postfix) with ESMTPS id D37411401DC;
 Mon,  3 Nov 2025 17:21:30 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500001.china.huawei.com (7.214.147.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 3 Nov 2025 09:21:28 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Mon, 3 Nov 2025 09:21:28 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH v3 5/5] bpf: remove use of VLA
Thread-Topic: [PATCH v3 5/5] bpf: remove use of VLA
Thread-Index: AQHcS1pgkhXsguMQO0+CnqqKfwvu7LTgrYFA
Date: Mon, 3 Nov 2025 09:21:28 +0000
Message-ID: <15ae5f5379844df6abed9a53a0a70195@huawei.com>
References: <20251030173732.246435-1-stephen@networkplumber.org>
 <20251101180659.43883-1-stephen@networkplumber.org>
 <20251101180659.43883-6-stephen@networkplumber.org>
In-Reply-To: <20251101180659.43883-6-stephen@networkplumber.org>
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



> Replace variable length array with two part loop which
> applies filter in bursts up to 32 packets.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/bpf/bpf_pkt.c   | 81 ++++++++++++++++++++++++++-------------------
>  lib/bpf/meson.build |  2 --
>  2 files changed, 47 insertions(+), 36 deletions(-)
>=20
> diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
> index 087ac0f244..15d36739a0 100644
> --- a/lib/bpf/bpf_pkt.c
> +++ b/lib/bpf/bpf_pkt.c
> @@ -157,13 +157,16 @@ bpf_eth_cbh_add(struct bpf_eth_cbh *cbh, uint16_t
> port, uint16_t queue)
>  /*
>   * BPF packet processing routines.
>   */
> +#define BPF_FILTER_BURST	32u
>=20
>  static inline uint32_t
>  apply_filter(struct rte_mbuf *mb[], const uint64_t rc[], uint32_t num,
>  	uint32_t drop)
>  {
>  	uint32_t i, j, k;
> -	struct rte_mbuf *dr[num];
> +	struct rte_mbuf *dr[BPF_FILTER_BURST];
> +
> +	RTE_ASSERT(num <=3D BPF_FILTER_BURST);
>=20
>  	for (i =3D 0, j =3D 0, k =3D 0; i !=3D num; i++) {

After looking at the code more closely - it might not be that straightforwa=
rd
as I thought:  apply_filter() groups 'good' packets consequently, and for
'bad' packets does one of two things:
a) if drop !=3D 0, then it frees them out  (RX filter)
b) if drop =3D=3D 0, then it places them after 'good' packets (TX filter)
While a) is simple to do with fixed length array (we just need read and wri=
te index),
to support b) - we need to do something more awkward, i.e. - walk mb[] in b=
ackwards
order, and/or keep copying bad packets to the end at each iteration.
All that looks quite complicated, so if for now you'll decide to switch bac=
k to alloca()
based approach (first version of the patch) - I'll be ok with that.
Sorry for not spotting that earlier.
Konstantin

>=20
> @@ -191,65 +194,75 @@ static inline uint32_t
>  pkt_filter_vm(const struct rte_bpf *bpf, struct rte_mbuf *mb[], uint32_t=
 num,
>  	uint32_t drop)
>  {
> -	uint32_t i;
> -	void *dp[num];
> -	uint64_t rc[num];
> +	uint32_t matched =3D 0;
> +
> +	for (uint32_t i =3D 0; i < num; i +=3D BPF_FILTER_BURST) {
> +		uint32_t burst_sz =3D RTE_MIN(num, BPF_FILTER_BURST);
> +		void *dp[BPF_FILTER_BURST];
> +		uint64_t rc[BPF_FILTER_BURST];
>=20
> -	for (i =3D 0; i !=3D num; i++)
> -		dp[i] =3D rte_pktmbuf_mtod(mb[i], void *);
> +		for (uint32_t j =3D 0; j < burst_sz; j++)
> +			dp[j] =3D rte_pktmbuf_mtod(mb[i + j], void *);
>=20
> -	rte_bpf_exec_burst(bpf, dp, rc, num);
> -	return apply_filter(mb, rc, num, drop);
> +		rte_bpf_exec_burst(bpf, dp, rc, burst_sz);
> +		matched +=3D apply_filter(mb + i, rc, burst_sz, drop);
> +	}
> +	return matched;
>  }
>=20
>  static inline uint32_t
>  pkt_filter_jit(const struct rte_bpf_jit *jit, struct rte_mbuf *mb[],
>  	uint32_t num, uint32_t drop)
>  {
> -	uint32_t i, n;
> -	void *dp;
> -	uint64_t rc[num];
> -
> -	n =3D 0;
> -	for (i =3D 0; i !=3D num; i++) {
> -		dp =3D rte_pktmbuf_mtod(mb[i], void *);
> -		rc[i] =3D jit->func(dp);
> -		n +=3D (rc[i] =3D=3D 0);
> -	}
> +	uint32_t matched =3D 0;
> +
> +	for (uint32_t i =3D 0; i < num; i +=3D BPF_FILTER_BURST) {
> +		uint32_t burst_sz =3D RTE_MIN(num, BPF_FILTER_BURST);
> +		uint64_t rc[BPF_FILTER_BURST];
> +
> +		for (uint32_t j =3D 0; j < burst_sz; j++) {
> +			void *dp =3D rte_pktmbuf_mtod(mb[i + j], void *);
>=20
> -	if (n !=3D 0)
> -		num =3D apply_filter(mb, rc, num, drop);
> +			rc[j] =3D jit->func(dp);
> +		}
>=20
> -	return num;
> +		matched +=3D apply_filter(mb + i, rc, burst_sz, drop);
> +	}
> +	return matched;
>  }
>=20
>  static inline uint32_t
>  pkt_filter_mb_vm(const struct rte_bpf *bpf, struct rte_mbuf *mb[], uint3=
2_t
> num,
>  	uint32_t drop)
>  {
> -	uint64_t rc[num];
> +	uint32_t matched =3D 0;
> +
> +	for (uint32_t i =3D 0; i < num; i +=3D BPF_FILTER_BURST) {
> +		uint32_t burst_sz =3D RTE_MIN(num, BPF_FILTER_BURST);
> +		uint64_t rc[BPF_FILTER_BURST];
>=20
> -	rte_bpf_exec_burst(bpf, (void **)mb, rc, num);
> -	return apply_filter(mb, rc, num, drop);
> +		rte_bpf_exec_burst(bpf, (void **)mb, rc, burst_sz);
> +		matched +=3D apply_filter(mb + i, rc, burst_sz, drop);
> +	}
> +	return matched;
>  }
>=20
>  static inline uint32_t
>  pkt_filter_mb_jit(const struct rte_bpf_jit *jit, struct rte_mbuf *mb[],
>  	uint32_t num, uint32_t drop)
>  {
> -	uint32_t i, n;
> -	uint64_t rc[num];
> +	uint32_t matched =3D 0;
>=20
> -	n =3D 0;
> -	for (i =3D 0; i !=3D num; i++) {
> -		rc[i] =3D jit->func(mb[i]);
> -		n +=3D (rc[i] =3D=3D 0);
> -	}
> +	for (uint32_t i =3D 0; i < num; i +=3D BPF_FILTER_BURST) {
> +		uint32_t burst_sz =3D RTE_MIN(num, BPF_FILTER_BURST);
> +		uint64_t rc[BPF_FILTER_BURST];
>=20
> -	if (n !=3D 0)
> -		num =3D apply_filter(mb, rc, num, drop);
> +		for (uint32_t j =3D 0; j < burst_sz; j++)
> +			rc[j] =3D jit->func(mb[i + j]);
>=20
> -	return num;
> +		matched +=3D apply_filter(mb + i, rc, burst_sz, drop);
> +	}
> +	return matched;
>  }
>=20
>  /*
> diff --git a/lib/bpf/meson.build b/lib/bpf/meson.build
> index 28df7f469a..aa258a9061 100644
> --- a/lib/bpf/meson.build
> +++ b/lib/bpf/meson.build
> @@ -7,8 +7,6 @@ if is_windows
>      subdir_done()
>  endif
>=20
> -cflags +=3D no_wvla_cflag
> -
>  if arch_subdir =3D=3D 'x86' and dpdk_conf.get('RTE_ARCH_32')
>      build =3D false
>      reason =3D 'not supported on 32-bit x86'
> --
> 2.51.0

