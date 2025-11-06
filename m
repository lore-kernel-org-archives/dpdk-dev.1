Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A377CCFA03
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 07:26:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7DE0140E09;
	Thu,  6 Nov 2025 08:26:24 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 263794013F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 08:26:23 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d2DJ76XzqzJ46Dy;
 Thu,  6 Nov 2025 15:25:59 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (unknown [7.214.147.241])
 by mail.maildlp.com (Postfix) with ESMTPS id 5066714020A;
 Thu,  6 Nov 2025 15:26:22 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500001.china.huawei.com (7.214.147.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 6 Nov 2025 07:26:21 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Thu, 6 Nov 2025 07:26:21 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH v4 5/5] bpf: replace use of VLA
Thread-Topic: [PATCH v4 5/5] bpf: replace use of VLA
Thread-Index: AQHcTaVZsf9FEw79PEySQDZmjBGNz7TlQeuw
Date: Thu, 6 Nov 2025 07:26:21 +0000
Message-ID: <5374131481bb4d7daf5e49a05b5ad681@huawei.com>
References: <20251030173732.246435-1-stephen@networkplumber.org>
 <20251104160843.304044-1-stephen@networkplumber.org>
 <20251104160843.304044-6-stephen@networkplumber.org>
In-Reply-To: <20251104160843.304044-6-stephen@networkplumber.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.151.58]
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



> Variable length arrays are extension not required in C standard
> and not available in Windows.
> Use alloca() instead of variable length array.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/bpf/bpf_pkt.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
> index 087ac0f244..5007f6aef5 100644
> --- a/lib/bpf/bpf_pkt.c
> +++ b/lib/bpf/bpf_pkt.c
> @@ -163,7 +163,7 @@ apply_filter(struct rte_mbuf *mb[], const uint64_t rc=
[],
> uint32_t num,
>  	uint32_t drop)
>  {
>  	uint32_t i, j, k;
> -	struct rte_mbuf *dr[num];
> +	struct rte_mbuf **dr =3D alloca(num * sizeof(struct rte_mbuf *));
>=20
>  	for (i =3D 0, j =3D 0, k =3D 0; i !=3D num; i++) {
>=20
> @@ -192,8 +192,8 @@ pkt_filter_vm(const struct rte_bpf *bpf, struct rte_m=
buf
> *mb[], uint32_t num,
>  	uint32_t drop)
>  {
>  	uint32_t i;
> -	void *dp[num];
> -	uint64_t rc[num];
> +	void **dp =3D alloca(num * sizeof(void *));
> +	uint64_t *rc =3D alloca(num * sizeof(uint64_t));
>=20
>  	for (i =3D 0; i !=3D num; i++)
>  		dp[i] =3D rte_pktmbuf_mtod(mb[i], void *);
> @@ -208,7 +208,7 @@ pkt_filter_jit(const struct rte_bpf_jit *jit, struct =
rte_mbuf
> *mb[],
>  {
>  	uint32_t i, n;
>  	void *dp;
> -	uint64_t rc[num];
> +	uint64_t *rc =3D alloca(num * sizeof(uint64_t));
>=20
>  	n =3D 0;
>  	for (i =3D 0; i !=3D num; i++) {
> @@ -227,7 +227,7 @@ static inline uint32_t
>  pkt_filter_mb_vm(const struct rte_bpf *bpf, struct rte_mbuf *mb[], uint3=
2_t num,
>  	uint32_t drop)
>  {
> -	uint64_t rc[num];
> +	uint64_t *rc =3D alloca(num * sizeof(uint64_t));
>=20
>  	rte_bpf_exec_burst(bpf, (void **)mb, rc, num);
>  	return apply_filter(mb, rc, num, drop);
> @@ -238,7 +238,7 @@ pkt_filter_mb_jit(const struct rte_bpf_jit *jit, stru=
ct
> rte_mbuf *mb[],
>  	uint32_t num, uint32_t drop)
>  {
>  	uint32_t i, n;
> -	uint64_t rc[num];
> +	uint64_t *rc =3D alloca(num * sizeof(uint64_t));
>=20
>  	n =3D 0;
>  	for (i =3D 0; i !=3D num; i++) {
> --

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
=20

> 2.51.0

