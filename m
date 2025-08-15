Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C945ACA0EE4
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 Aug 2025 14:26:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C71E400EF;
	Fri, 15 Aug 2025 16:26:11 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id CDD0D4003C
 for <dev@dpdk.org>; Fri, 15 Aug 2025 16:26:09 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c3PRT6fPmz6L4t3;
 Fri, 15 Aug 2025 22:21:09 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id 6C0B91402E9;
 Fri, 15 Aug 2025 22:26:08 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 15 Aug 2025 16:26:08 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Fri, 15 Aug 2025 16:26:08 +0200
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH] bpf: remove dependency on vla
Thread-Topic: [PATCH] bpf: remove dependency on vla
Thread-Index: AQHcBJH6COoIUr83ZEGzhTfQM/dEa7Rj1wdA
Date: Fri, 15 Aug 2025 14:26:07 +0000
Message-ID: <7c942773fe30436b888ff37db75880ee@huawei.com>
References: <20250803161617.36653-1-stephen@networkplumber.org>
In-Reply-To: <20250803161617.36653-1-stephen@networkplumber.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.175.247]
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



> The code for ethdev callbacks was using variable length arrays
> which is a feature not supported on MSVC and later C standards.
> Replace with alloca().

I am not a big fun of such mechanical replacement of vla with alloca()
Specially in that particular case, we can have internal function that uses
fixed size array and in public one just call it several times in a loop.
Again, using VLA here is probably a real security breach,
as we put some assumptions on size of input arrays provided by user,
which we probably shouldn't.   =20

> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/bpf/bpf_pkt.c   | 16 +++++++++-------
>  lib/bpf/meson.build |  2 --
>  2 files changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
> index 01f813c56b..6a425d79b6 100644
> --- a/lib/bpf/bpf_pkt.c
> +++ b/lib/bpf/bpf_pkt.c
> @@ -6,6 +6,7 @@
>  #include <string.h>
>  #include <errno.h>
>  #include <stdint.h>
> +#include <alloca.h>
>=20
>  #include <sys/queue.h>
>=20
> @@ -163,10 +164,11 @@ apply_filter(struct rte_mbuf *mb[], const uint64_t =
rc[], uint32_t num,
>  	uint32_t drop)
>  {
>  	uint32_t i, j, k;
> -	struct rte_mbuf *dr[num];
> +	struct rte_mbuf **dr;
>=20
> -	for (i =3D 0, j =3D 0, k =3D 0; i !=3D num; i++) {
> +	dr =3D alloca(sizeof(struct rte_mbuf *) * num);
>=20
> +	for (i =3D 0, j =3D 0, k =3D 0; i !=3D num; i++) {
>  		/* filter matches */
>  		if (rc[i] !=3D 0)
>  			mb[j++] =3D mb[i];
> @@ -193,8 +195,8 @@ pkt_filter_vm(const struct rte_bpf *bpf, struct rte_m=
buf *mb[], uint32_t num,
>  	uint32_t drop)
>  {
>  	uint32_t i;
> -	void *dp[num];
> -	uint64_t rc[num];
> +	void **dp =3D alloca(sizeof(void *) * num);
> +	uint64_t *rc =3D alloca(sizeof(uint64_t) * num);
>=20
>  	for (i =3D 0; i !=3D num; i++)
>  		dp[i] =3D rte_pktmbuf_mtod(mb[i], void *);
> @@ -209,7 +211,7 @@ pkt_filter_jit(const struct rte_bpf_jit *jit, struct =
rte_mbuf *mb[],
>  {
>  	uint32_t i, n;
>  	void *dp;
> -	uint64_t rc[num];
> +	uint64_t *rc =3D alloca(sizeof(uint64_t) * num);
>=20
>  	n =3D 0;
>  	for (i =3D 0; i !=3D num; i++) {
> @@ -228,7 +230,7 @@ static inline uint32_t
>  pkt_filter_mb_vm(const struct rte_bpf *bpf, struct rte_mbuf *mb[], uint3=
2_t num,
>  	uint32_t drop)
>  {
> -	uint64_t rc[num];
> +	uint64_t *rc =3D alloca(sizeof(uint64_t) * num);
>=20
>  	rte_bpf_exec_burst(bpf, (void **)mb, rc, num);
>  	return apply_filter(mb, rc, num, drop);
> @@ -239,7 +241,7 @@ pkt_filter_mb_jit(const struct rte_bpf_jit *jit, stru=
ct rte_mbuf *mb[],
>  	uint32_t num, uint32_t drop)
>  {
>  	uint32_t i, n;
> -	uint64_t rc[num];
> +	uint64_t *rc =3D alloca(sizeof(uint64_t) * num);
>=20
>  	n =3D 0;
>  	for (i =3D 0; i !=3D num; i++) {
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
> 2.47.2

