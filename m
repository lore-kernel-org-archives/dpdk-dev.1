Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3505CD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 16:52:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 076B44026C;
	Wed, 27 May 2026 18:52:41 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 822144014F
 for <dev@dpdk.org>; Wed, 27 May 2026 18:52:39 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gQbHj65chzJ468m;
 Thu, 28 May 2026 00:51:45 +0800 (CST)
Received: from frapema500002.china.huawei.com (unknown [7.182.19.148])
 by mail.maildlp.com (Postfix) with ESMTPS id D641140575;
 Thu, 28 May 2026 00:52:37 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500002.china.huawei.com (7.182.19.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 27 May 2026 18:52:37 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Wed, 27 May 2026 18:52:37 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: RE: [PATCH v4 04/27] bpf: use C11 atomics in BPF_ST_ATOMIC_REG
Thread-Topic: [PATCH v4 04/27] bpf: use C11 atomics in BPF_ST_ATOMIC_REG
Thread-Index: AQHc7WcBT++jaXtkHEagv3n+gRlRqbYiEcAQ
Date: Wed, 27 May 2026 16:52:37 +0000
Message-ID: <2ed45bf740814ff394981c3ed5591d27@huawei.com>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260526232542.620966-1-stephen@networkplumber.org>
 <20260526232542.620966-5-stephen@networkplumber.org>
In-Reply-To: <20260526232542.620966-5-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.16]
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

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Wednesday 27 May 2026 00:24
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; Konstantin Ananyev <k=
onstantin.ananyev@huawei.com>;
> Marat Khalili <marat.khalili@huawei.com>
> Subject: [PATCH v4 04/27] bpf: use C11 atomics in BPF_ST_ATOMIC_REG
>=20
> The BPF_ST_ATOMIC_REG macro generated code with deprecated
> rte_atomicNN_add and rte_atomicNN_exchange.
>=20
> Replace this with the equivalent rte_stdatomic definitions.
> Use memory order seq_cst to preserve the previous behavior of
> rte_atomicNN_add() / rte_atomicNN_exchange() and matches
> the Linux kernel BPF interpreter for these opcodes.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/bpf/bpf_exec.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/lib/bpf/bpf_exec.c b/lib/bpf/bpf_exec.c
> index 18013753b1..ee6ec7516f 100644
> --- a/lib/bpf/bpf_exec.c
> +++ b/lib/bpf/bpf_exec.c
> @@ -10,6 +10,7 @@
>  #include <rte_log.h>
>  #include <rte_debug.h>
>  #include <rte_byteorder.h>
> +#include <rte_stdatomic.h>
>=20
>  #include "bpf_impl.h"
>=20
> @@ -65,16 +66,16 @@
>  		(type)(reg)[(ins)->src_reg])
>=20
>  #define BPF_ST_ATOMIC_REG(reg, ins, tp)	do { \
> +	RTE_ATOMIC(uint##tp##_t) *dst =3D (RTE_ATOMIC(uint##tp##_t) *) \
> +		(uintptr_t)((reg)[(ins)->dst_reg] + (ins)->off); \
>  	switch (ins->imm) { \
>  	case BPF_ATOMIC_ADD: \
> -		rte_atomic##tp##_add((rte_atomic##tp##_t *) \
> -			(uintptr_t)((reg)[(ins)->dst_reg] + (ins)->off), \
> -			(reg)[(ins)->src_reg]); \
> +		rte_atomic_fetch_add_explicit(dst, \
> +			(reg)[(ins)->src_reg], rte_memory_order_seq_cst); \
>  		break; \
>  	case BPF_ATOMIC_XCHG: \
> -		(reg)[(ins)->src_reg] =3D rte_atomic##tp##_exchange((uint##tp##_t *) \
> -			(uintptr_t)((reg)[(ins)->dst_reg] + (ins)->off), \
> -			(reg)[(ins)->src_reg]); \
> +		(reg)[(ins)->src_reg] =3D rte_atomic_exchange_explicit(dst, \
> +			(reg)[(ins)->src_reg], rte_memory_order_seq_cst); \
>  		break; \
>  	default: \
>  		/* this should be caught by validator and never reach here */ \
> --
> 2.53.0

Reviewed-by: Marat Khalili <marat.khalili@huawei.com>

nit: in the last sentence of the commit message `s` is not needed in `match=
es`,
and some word like `behavior` can be added for clarity after `interpreter`.

FWIW whole patchset builds on our amd64 and arm64 machines and passes our s=
ubset of tests.
