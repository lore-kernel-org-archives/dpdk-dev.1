Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C72D3B7E5
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Dec 2025 12:13:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F46640297;
	Sun, 28 Dec 2025 13:13:30 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 5A23440267
 for <dev@dpdk.org>; Sun, 28 Dec 2025 13:13:27 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dfJBt60bNzHnGf1;
 Sun, 28 Dec 2025 20:12:38 +0800 (CST)
Received: from dubpeml100002.china.huawei.com (unknown [7.214.144.156])
 by mail.maildlp.com (Postfix) with ESMTPS id 9CEF440086;
 Sun, 28 Dec 2025 20:13:25 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100002.china.huawei.com (7.214.144.156) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Sun, 28 Dec 2025 12:13:25 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Sun, 28 Dec 2025 12:13:24 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Sun Yuechi <sunyuechi@iscas.ac.cn>, "dev@dpdk.org" <dev@dpdk.org>
CC: Zijian <zijian.oerv@isrc.iscas.ac.cn>,
 =?iso-8859-2?Q?Stanis=B3aw_Kardach?= <stanislaw.kardach@gmail.com>, "Bruce
 Richardson" <bruce.richardson@intel.com>
Subject: RE: [PATCH] acl: add RISC-V vector extension implementation
Thread-Topic: [PATCH] acl: add RISC-V vector extension implementation
Thread-Index: AQHcYjUosWAa0857+k6O9mZ8WEBEqbU3H/TQ
Date: Sun, 28 Dec 2025 12:13:24 +0000
Message-ID: <fb1b6b08a8b54d998f37f098727a8581@huawei.com>
References: <20251130200810.879556-1-sunyuechi@iscas.ac.cn>
In-Reply-To: <20251130200810.879556-1-sunyuechi@iscas.ac.cn>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.148.167]
Content-Type: text/plain; charset="iso-8859-2"
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



> Implement ACL classify function for RISC-V architecture
> using RISC-V Vector Extension instruction set.

I didn't look very hard at risc-v part.
Generic part looks ok to me, just few nits, see below.
Konstantin =20

> Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>
> Signed-off-by: Zijian <zijian.oerv@isrc.iscas.ac.cn>
> ---
>  app/test-acl/main.c              |   4 +
>  app/test/test_acl.c              |   1 +
>  config/riscv/meson.build         |   1 +
>  lib/acl/acl.h                    |   4 +
>  lib/acl/acl_run.h                |   2 +
>  lib/acl/acl_run_rvv.c            |  18 ++
>  lib/acl/acl_run_rvv.h            | 326 +++++++++++++++++++++++++++++++
>  lib/acl/meson.build              |   2 +
>  lib/acl/rte_acl.c                |  34 ++++
>  lib/acl/rte_acl.h                |   1 +
>  lib/eal/riscv/include/rte_vect.h |   2 +-
>  11 files changed, 394 insertions(+), 1 deletion(-)
>  create mode 100644 lib/acl/acl_run_rvv.c
>  create mode 100644 lib/acl/acl_run_rvv.h
>=20
> diff --git a/app/test-acl/main.c b/app/test-acl/main.c
> index debdc44830..41d362209a 100644
> --- a/app/test-acl/main.c
> +++ b/app/test-acl/main.c
> @@ -97,6 +97,10 @@ static const struct acl_alg acl_alg[] =3D {
>  		.name =3D "avx512x32",
>  		.alg =3D RTE_ACL_CLASSIFY_AVX512X32,
>  	},
> +	{
> +		.name =3D "rvv",
> +		.alg =3D RTE_ACL_CLASSIFY_RVV,
> +	},
>  };

You probably need to update examples/l3fwd/l3fwd_acl.c too.
=20
>=20
>  static struct {
> diff --git a/app/test/test_acl.c b/app/test/test_acl.c
> index 43d13b5b0f..bb3e466396 100644
> --- a/app/test/test_acl.c
> +++ b/app/test/test_acl.c
> @@ -353,6 +353,7 @@ test_classify_run(struct rte_acl_ctx *acx, struct ipv=
4_7tuple
> test_data[],
>  		RTE_ACL_CLASSIFY_ALTIVEC,
>  		RTE_ACL_CLASSIFY_AVX512X16,
>  		RTE_ACL_CLASSIFY_AVX512X32,
> +		RTE_ACL_CLASSIFY_RVV,
>  	};
>=20
>  	/* swap all bytes in the data to network order */
> diff --git a/config/riscv/meson.build b/config/riscv/meson.build
> index a06429a1e2..83c41edbd0 100644
> --- a/config/riscv/meson.build
> +++ b/config/riscv/meson.build
> @@ -141,6 +141,7 @@ if (riscv_extension_macros and
>                  int main(void) { size_t vl =3D __riscv_vsetvl_e32m1(1); =
}''', args:
> machine_args))
>              message('Compiling with the V extension')
>              machine_args +=3D ['-DRTE_RISCV_FEATURE_V']
> +            dpdk_flags +=3D [['RTE_RISCV_FEATURE_V', 1],]
>          endif
>      else
>          warning('Detected V extension but cannot use because intrinsics =
are not
> available (present in GCC 14.1.0+ and Clang 18.1.0+)')
> diff --git a/lib/acl/acl.h b/lib/acl/acl.h
> index c8e4e72fab..04a4244313 100644
> --- a/lib/acl/acl.h
> +++ b/lib/acl/acl.h
> @@ -225,6 +225,10 @@ int
>  rte_acl_classify_altivec(const struct rte_acl_ctx *ctx, const uint8_t **=
data,
>  	uint32_t *results, uint32_t num, uint32_t categories);
>=20
> +int
> +rte_acl_classify_rvv(const struct rte_acl_ctx *ctx, const uint8_t **data=
,
> +		      uint32_t *results, uint32_t num, uint32_t categories);
> +
>  #ifdef __cplusplus
>  }
>  #endif /* __cplusplus */
> diff --git a/lib/acl/acl_run.h b/lib/acl/acl_run.h
> index 9fd3e60021..610358b61f 100644
> --- a/lib/acl/acl_run.h
> +++ b/lib/acl/acl_run.h
> @@ -14,6 +14,8 @@
>  #define MAX_SEARCHES_SSE4	4
>  #define MAX_SEARCHES_ALTIVEC4	4
>  #define MAX_SEARCHES_SCALAR	2

Let's keep SCALAR as the last one, as default.
=20
> +#define MAX_SEARCHES_RVV8	8
> +#define MAX_SEARCHES_RVV4	4
>=20
>  #define GET_NEXT_4BYTES(prm, idx)	\
>  	(*((const int32_t *)((prm)[(idx)].data + *(prm)[idx].data_index++)))
> diff --git a/lib/acl/acl_run_rvv.c b/lib/acl/acl_run_rvv.c
> new file mode 100644
> index 0000000000..1b321af43c
> --- /dev/null
> +++ b/lib/acl/acl_run_rvv.c
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright (c) 2025 Institute of Software Chinese Academy of Sciences =
(ISCAS).
> + */
> +
> +#include "acl_run_rvv.h"
> +
> +int
> +rte_acl_classify_rvv(const struct rte_acl_ctx *ctx, const uint8_t **data=
,
> +		      uint32_t *results, uint32_t num, uint32_t categories)
> +{
> +	if (likely(num >=3D 8))

Why not use 'MAX_SEARCHES_RVV?' defined above?

> +		return search_rvv_8(ctx, data, results, num, categories);
> +	else if (num >=3D 4)
> +		return search_rvv_4(ctx, data, results, num, categories);
> +	else
> +		return rte_acl_classify_scalar(ctx, data, results, num,
> +			categories);
> +}
> diff --git a/lib/acl/acl_run_rvv.h b/lib/acl/acl_run_rvv.h
> new file mode 100644
> index 0000000000..1d6fdff045
> --- /dev/null
> +++ b/lib/acl/acl_run_rvv.h
> @@ -0,0 +1,326 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright (c) 2025 Institute of Software Chinese Academy of Sciences =
(ISCAS).
> + */
> +
> +#include "acl_run.h"
> +#include <rte_vect.h>
> +
> +static const uint32_t rvv_range_base[4] =3D {
> +	0xffffff00, 0xffffff04, 0xffffff08, 0xffffff0c
> +};
> +
> +/*
> + * Resolve priority for multiple results (RVV version).
> + * This consists of comparing the priority of the current traversal with=
 the
> + * running set of results for the packet.
> + * For each result, keep a running array of the result (rule number) and
> + * its priority for each category.
> + */
> +static inline void
> +resolve_priority_rvv(uint64_t transition, int n, const struct rte_acl_ct=
x *ctx,
> +	struct parms *parms, const struct rte_acl_match_results *p,
> +	uint32_t categories)
> +{
> +	const size_t vl =3D 4;
> +
> +	for (size_t i =3D 0; i < categories; i +=3D vl) {
> +
> +		/* get results and priorities for completed trie */
> +		vuint32m1_t v_current_results =3D
> +			__riscv_vle32_v_u32m1(&p[transition].results[i], vl);
> +		vint32m1_t v_current_priority =3D
> +			__riscv_vle32_v_i32m1(&p[transition].priority[i], vl);
> +
> +		/* if this is not the first completed trie */
> +		if (parms[n].cmplt->count !=3D ctx->num_tries) {
> +
> +			/* get running best results and their priorities */
> +			vuint32m1_t v_saved_results =3D
> +				__riscv_vle32_v_u32m1(&parms[n].cmplt-
> >results[i], vl);
> +			vint32m1_t v_saved_priority =3D
> +				__riscv_vle32_v_i32m1(&parms[n].cmplt-
> >priority[i], vl);
> +
> +			/* select results that are highest priority */
> +			vbool32_t v_mask =3D __riscv_vmsle_vv_i32m1_b32(
> +				v_saved_priority, v_current_priority, vl);
> +
> +			v_current_results =3D __riscv_vmerge_vvm_u32m1(
> +				v_saved_results, v_current_results, v_mask, vl);
> +			v_current_priority =3D __riscv_vmerge_vvm_i32m1(
> +				v_saved_priority, v_current_priority, v_mask, vl);
> +		}
> +
> +		/* save running best results and their priorities */
> +		__riscv_vse32_v_u32m1(&parms[n].cmplt->results[i],
> +			v_current_results, vl);
> +		__riscv_vse32_v_i32m1(&parms[n].cmplt->priority[i],
> +			v_current_priority, vl);
> +	}
> +}
> +
> +/*
> + * Extract transitions from a vector register and check for any matches
> + */
> +static void
> +acl_process_matches(uint64_t *indices, int slot,
> +	const struct rte_acl_ctx *ctx, struct parms *parms,
> +	struct acl_flow_data *flows)
> +{
> +	/* extract transition from low 64 bits. */
> +	indices[0] =3D acl_match_check(indices[0], slot, ctx,
> +		parms, flows, resolve_priority_rvv);
> +
> +	/* extract transition from high 64 bits. */
> +	indices[1] =3D acl_match_check(indices[1], slot + 1, ctx,
> +		parms, flows, resolve_priority_rvv);
> +}
> +
> +/*
> + * Check for any match in 4 transitions (contained in 2 pairs of indices=
)
> + */
> +static __rte_always_inline void
> +acl_match_check_x4(int slot, const struct rte_acl_ctx *ctx,
> +	struct parms *parms, struct acl_flow_data *flows,
> +	uint64_t *indices1, uint64_t *indices2, uint32_t match_mask)
> +{
> +	uint64_t check;
> +
> +	while (1) {
> +		/* test for match node */
> +		check =3D ((indices1[0] | indices1[1]) |
> +			(indices2[0] | indices2[1])) & match_mask;
> +		if (check =3D=3D 0)
> +			break;
> +
> +		acl_process_matches(indices1, slot, ctx, parms, flows);
> +		acl_process_matches(indices2, slot + 2, ctx, parms, flows);
> +	}
> +}
> +
> +/*
> + * Process 4 transitions (in 1 RVV vector register) in parallel
> + */
> +static __rte_always_inline vuint32m1_t
> +transition_vec(vuint32m1_t v_next_input, const uint64_t *trans,
> +	uint64_t *indices1, uint64_t *indices2, size_t vl,
> +	vuint32m1_t v_range_base)
> +{
> +	vuint32m1_t v_tr_lo, v_tr_hi;
> +	vuint64m2_t v_indices;
> +
> +	v_indices =3D __riscv_vle64_v_u64m2(indices1, vl);
> +	v_tr_lo =3D __riscv_vnsrl_wx_u32m1(v_indices, 0, vl);
> +	v_tr_hi =3D __riscv_vnsrl_wx_u32m1(v_indices, 32, vl);
> +
> +	/* expand input byte to 4 identical bytes per 32-bit element */
> +	vuint32m1_t v_input_expanded =3D __riscv_vmul_vx_u32m1(
> +		__riscv_vand_vx_u32m1(v_next_input, 0xFF, vl),
> +		0x01010101, vl);
> +
> +	/* Calculate the address (array index) for all 4 transitions. */
> +
> +	vint8m1_t v_input_bytes =3D __riscv_vreinterpret_v_i32m1_i8m1(
> +		__riscv_vreinterpret_v_u32m1_i32m1(v_input_expanded));
> +	vint8m1_t v_tr_hi_bytes =3D __riscv_vreinterpret_v_i32m1_i8m1(
> +		__riscv_vreinterpret_v_u32m1_i32m1(v_tr_hi));
> +	vbool8_t v_compare =3D __riscv_vmsgt_vv_i8m1_b8(v_input_bytes,
> +		v_tr_hi_bytes, vl * 4);
> +
> +	vuint32m1_t v_bitmap =3D __riscv_vreinterpret_v_u8m1_u32m1(
> +		__riscv_vmerge_vxm_u8m1(__riscv_vmv_v_x_u8m1(0, vl * 4),
> +			1, v_compare, vl * 4));
> +
> +	/* count set bits in bitmap to get quad offset */
> +	vuint32m1_t v_low16 =3D __riscv_vand_vx_u32m1(v_bitmap, 0xFFFF, vl);
> +	vuint32m1_t v_high16 =3D __riscv_vsrl_vx_u32m1(v_bitmap, 16, vl);
> +	vuint32m1_t v_sum_low =3D __riscv_vadd_vv_u32m1(
> +		__riscv_vand_vx_u32m1(v_low16, 0xFF, vl),
> +		__riscv_vsrl_vx_u32m1(v_low16, 8, vl),
> +		vl);
> +	vuint32m1_t v_sum_high =3D __riscv_vadd_vv_u32m1(
> +		__riscv_vand_vx_u32m1(v_high16, 0xFF, vl),
> +		__riscv_vsrl_vx_u32m1(v_high16, 8, vl),
> +		vl);
> +	vuint32m1_t v_quad_ofs =3D __riscv_vadd_vv_u32m1(v_sum_low,
> +		v_sum_high, vl);
> +
> +	/* calculate DFA range offset */
> +	vuint32m1_t v_input_byte3 =3D __riscv_vsrl_vx_u32m1(v_input_expanded,
> +		24, vl);
> +	vuint8m1_t v_range_index =3D __riscv_vreinterpret_v_u32m1_u8m1(
> +		__riscv_vadd_vv_u32m1(__riscv_vsrl_vx_u32m1(v_input_expanded,
> +			30, vl), v_range_base, vl));
> +	vuint32m1_t v_range_value =3D __riscv_vreinterpret_v_u8m1_u32m1(
> +		__riscv_vrgather_vv_u8m1(__riscv_vreinterpret_v_u32m1_u8m1(
> +			v_tr_hi), v_range_index, vl * 4));
> +
> +	/* select between quad offset (QRANGE/SINGLE) and DFA offset */
> +	vuint32m1_t v_offset =3D __riscv_vmerge_vvm_u32m1(v_quad_ofs,
> +		__riscv_vsub_vv_u32m1(v_input_byte3, v_range_value, vl),
> +		__riscv_vmseq_vx_u32m1_b32(__riscv_vand_vx_u32m1(v_tr_lo,
> +			~RTE_ACL_NODE_INDEX, vl), 0, vl), vl);
> +
> +	/* calculate final transition address */
> +	vuint32m1_t v_addr =3D __riscv_vadd_vv_u32m1(
> +		__riscv_vand_vx_u32m1(v_tr_lo, RTE_ACL_NODE_INDEX, vl),
> +		v_offset, vl);
> +
> +	/* Gather 64 bit transitions and pack back into 2 pairs. */
> +
> +	indices1[0] =3D trans[__riscv_vmv_x_s_u32m1_u32(v_addr)];
> +
> +	indices1[1] =3D trans[__riscv_vmv_x_s_u32m1_u32(
> +		__riscv_vslidedown_vx_u32m1(v_addr, 1, vl))];
> +
> +	indices2[0] =3D trans[__riscv_vmv_x_s_u32m1_u32(
> +		__riscv_vslidedown_vx_u32m1(v_addr, 2, vl))];
> +
> +	indices2[1] =3D trans[__riscv_vmv_x_s_u32m1_u32(
> +		__riscv_vslidedown_vx_u32m1(v_addr, 3, vl))];
> +
> +	return __riscv_vsrl_vx_u32m1(v_next_input, CHAR_BIT, vl);
> +}
> +
> +/*
> + * Execute trie traversal with 8 traversals in parallel
> + */
> +static inline int
> +search_rvv_8(const struct rte_acl_ctx *ctx, const uint8_t **data,
> +	uint32_t *results, uint32_t total_packets, uint32_t categories)
> +{
> +	int n;
> +	const size_t vl =3D 4;
> +	struct acl_flow_data flows;
> +	uint64_t index_array[MAX_SEARCHES_RVV8];
> +	struct completion cmplt[MAX_SEARCHES_RVV8];
> +	struct parms parms[MAX_SEARCHES_RVV8];
> +	vuint32m1_t v_input0, v_input1;
> +	vuint32m1_t v_range_base;
> +
> +	v_range_base =3D __riscv_vle32_v_u32m1(rvv_range_base, vl);
> +
> +	acl_set_flow(&flows, cmplt, RTE_DIM(cmplt), data, results,
> +		total_packets, categories, ctx->trans_table);
> +
> +	for (n =3D 0; n < MAX_SEARCHES_RVV8; n++)
> +		index_array[n] =3D acl_start_next_trie(&flows, parms, n, ctx);
> +
> +	/*
> +	 * index_array[0,1] and index_array[2,3] are processed by v_input0
> +	 * index_array[4,5] and index_array[6,7] are processed by v_input1
> +	 */
> +
> +	/* Check for any matches. */
> +	acl_match_check_x4(0, ctx, parms, &flows,
> +		&index_array[0], &index_array[2], RTE_ACL_NODE_MATCH);
> +	acl_match_check_x4(4, ctx, parms, &flows,
> +		&index_array[4], &index_array[6], RTE_ACL_NODE_MATCH);
> +
> +	while (flows.started > 0) {
> +
> +		/* Gather 4 bytes of input data for each stream. */
> +		uint32_t input_data0[4] =3D {
> +			GET_NEXT_4BYTES(parms, 0),
> +			GET_NEXT_4BYTES(parms, 1),
> +			GET_NEXT_4BYTES(parms, 2),
> +			GET_NEXT_4BYTES(parms, 3)
> +		};
> +		uint32_t input_data1[4] =3D {
> +			GET_NEXT_4BYTES(parms, 4),
> +			GET_NEXT_4BYTES(parms, 5),
> +			GET_NEXT_4BYTES(parms, 6),
> +			GET_NEXT_4BYTES(parms, 7)
> +		};
> +
> +		v_input0 =3D __riscv_vle32_v_u32m1(&input_data0[0], vl);
> +		v_input1 =3D __riscv_vle32_v_u32m1(&input_data1[0], vl);
> +
> +		/* Process the 4 bytes of input on each stream. */
> +
> +		v_input0 =3D transition_vec(v_input0, flows.trans,
> +			&index_array[0], &index_array[2], vl, v_range_base);
> +		v_input1 =3D transition_vec(v_input1, flows.trans,
> +			&index_array[4], &index_array[6], vl, v_range_base);
> +
> +		v_input0 =3D transition_vec(v_input0, flows.trans,
> +			&index_array[0], &index_array[2], vl, v_range_base);
> +		v_input1 =3D transition_vec(v_input1, flows.trans,
> +			&index_array[4], &index_array[6], vl, v_range_base);
> +
> +		v_input0 =3D transition_vec(v_input0, flows.trans,
> +			&index_array[0], &index_array[2], vl, v_range_base);
> +		v_input1 =3D transition_vec(v_input1, flows.trans,
> +			&index_array[4], &index_array[6], vl, v_range_base);
> +
> +		v_input0 =3D transition_vec(v_input0, flows.trans,
> +			&index_array[0], &index_array[2], vl, v_range_base);
> +		v_input1 =3D transition_vec(v_input1, flows.trans,
> +			&index_array[4], &index_array[6], vl, v_range_base);
> +
> +		/* Check for any matches. */
> +		acl_match_check_x4(0, ctx, parms, &flows,
> +			&index_array[0], &index_array[2],
> RTE_ACL_NODE_MATCH);
> +		acl_match_check_x4(4, ctx, parms, &flows,
> +			&index_array[4], &index_array[6],
> RTE_ACL_NODE_MATCH);
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Execute trie traversal with 4 traversals in parallel
> + */
> +static inline int
> +search_rvv_4(const struct rte_acl_ctx *ctx, const uint8_t **data,
> +	uint32_t *results, uint32_t total_packets, uint32_t categories)
> +{
> +	int n;
> +	const size_t vl =3D 4;
> +	struct acl_flow_data flows;
> +	uint64_t index_array[MAX_SEARCHES_RVV4];
> +	struct completion cmplt[MAX_SEARCHES_RVV4];
> +	struct parms parms[MAX_SEARCHES_RVV4];
> +	vuint32m1_t v_input0;
> +	vuint32m1_t v_range_base;
> +
> +	v_range_base =3D __riscv_vle32_v_u32m1(rvv_range_base, vl);
> +
> +	acl_set_flow(&flows, cmplt, RTE_DIM(cmplt), data, results,
> +		total_packets, categories, ctx->trans_table);
> +
> +	for (n =3D 0; n < MAX_SEARCHES_RVV4; n++)
> +		index_array[n] =3D acl_start_next_trie(&flows, parms, n, ctx);
> +
> +	/* Check for any matches. */
> +	acl_match_check_x4(0, ctx, parms, &flows,
> +		&index_array[0], &index_array[2], RTE_ACL_NODE_MATCH);
> +
> +	while (flows.started > 0) {
> +
> +		/* Gather 4 bytes of input data for each stream. */
> +		uint32_t input_data[4] =3D {
> +			GET_NEXT_4BYTES(parms, 0),
> +			GET_NEXT_4BYTES(parms, 1),
> +			GET_NEXT_4BYTES(parms, 2),
> +			GET_NEXT_4BYTES(parms, 3)
> +		};
> +
> +		v_input0 =3D __riscv_vle32_v_u32m1(&input_data[0], vl);
> +
> +		/* Process the 4 bytes of input on each stream. */
> +		v_input0 =3D transition_vec(v_input0, flows.trans,
> +			&index_array[0], &index_array[2], vl, v_range_base);
> +		v_input0 =3D transition_vec(v_input0, flows.trans,
> +			&index_array[0], &index_array[2], vl, v_range_base);
> +		v_input0 =3D transition_vec(v_input0, flows.trans,
> +			&index_array[0], &index_array[2], vl, v_range_base);
> +		v_input0 =3D transition_vec(v_input0, flows.trans,
> +			&index_array[0], &index_array[2], vl, v_range_base);
> +
> +		/* Check for any matches. */
> +		acl_match_check_x4(0, ctx, parms, &flows,
> +			&index_array[0], &index_array[2],
> RTE_ACL_NODE_MATCH);
> +	}
> +
> +	return 0;
> +}
> diff --git a/lib/acl/meson.build b/lib/acl/meson.build
> index 87e9f25f8e..a26c111395 100644
> --- a/lib/acl/meson.build
> +++ b/lib/acl/meson.build
> @@ -25,4 +25,6 @@ elif dpdk_conf.has('RTE_ARCH_ARM')
>      sources +=3D files('acl_run_neon.c')
>  elif dpdk_conf.has('RTE_ARCH_PPC_64')
>      sources +=3D files('acl_run_altivec.c')
> +elif dpdk_conf.has('RTE_ARCH_RISCV') and
> dpdk_conf.has('RTE_RISCV_FEATURE_V')
> +    sources +=3D files('acl_run_rvv.c')
>  endif
> diff --git a/lib/acl/rte_acl.c b/lib/acl/rte_acl.c
> index 8c0ca29618..bba4cf6c8f 100644
> --- a/lib/acl/rte_acl.c
> +++ b/lib/acl/rte_acl.c
> @@ -94,6 +94,18 @@ rte_acl_classify_altivec(__rte_unused const struct rte=
_acl_ctx
> *ctx,
>  }
>  #endif
>=20
> +#ifndef RTE_RISCV_FEATURE_V
> +int
> +rte_acl_classify_rvv(__rte_unused const struct rte_acl_ctx *ctx,
> +	__rte_unused const uint8_t **data,
> +	__rte_unused uint32_t *results,
> +	__rte_unused uint32_t num,
> +	__rte_unused uint32_t categories)
> +{
> +	return -ENOTSUP;
> +}
> +#endif
> +
>  static const rte_acl_classify_t classify_fns[] =3D {
>  	[RTE_ACL_CLASSIFY_DEFAULT] =3D rte_acl_classify_scalar,
>  	[RTE_ACL_CLASSIFY_SCALAR] =3D rte_acl_classify_scalar,
> @@ -103,6 +115,7 @@ static const rte_acl_classify_t classify_fns[] =3D {
>  	[RTE_ACL_CLASSIFY_ALTIVEC] =3D rte_acl_classify_altivec,
>  	[RTE_ACL_CLASSIFY_AVX512X16] =3D rte_acl_classify_avx512x16,
>  	[RTE_ACL_CLASSIFY_AVX512X32] =3D rte_acl_classify_avx512x32,
> +	[RTE_ACL_CLASSIFY_RVV] =3D rte_acl_classify_rvv,
>  };
>=20
>  /*
> @@ -201,6 +214,23 @@ acl_check_alg_x86(enum rte_acl_classify_alg alg)
>=20
>  	return -EINVAL;
>  }
> +/*
> + * Helper function for acl_check_alg.
> + * Check support for x86 specific classify methods.
> + */
> +static int
> +acl_check_alg_rvv(enum rte_acl_classify_alg alg)
> +{
> +	if (alg =3D=3D RTE_ACL_CLASSIFY_RVV) {
> +#ifdef RTE_RISCV_FEATURE_V
> +		if (rte_vect_get_max_simd_bitwidth() >=3D RTE_VECT_SIMD_128)
> +			return 0;
> +#endif
> +		return -ENOTSUP;
> +	}
> +
> +	return -EINVAL;
> +}
>=20
>  /*
>   * Check if input alg is supported by given platform/binary.
> @@ -221,6 +251,8 @@ acl_check_alg(enum rte_acl_classify_alg alg)
>  	case RTE_ACL_CLASSIFY_AVX2:
>  	case RTE_ACL_CLASSIFY_SSE:
>  		return acl_check_alg_x86(alg);
> +	case RTE_ACL_CLASSIFY_RVV:
> +		return acl_check_alg_rvv(alg);
>  	/* scalar method is supported on all platforms */
>  	case RTE_ACL_CLASSIFY_SCALAR:
>  		return 0;
> @@ -249,6 +281,8 @@ acl_get_best_alg(void)
>  		RTE_ACL_CLASSIFY_AVX512X16,
>  		RTE_ACL_CLASSIFY_AVX2,
>  		RTE_ACL_CLASSIFY_SSE,
> +#elif defined(RTE_RISCV_FEATURE_V)
> +		RTE_ACL_CLASSIFY_RVV,
>  #endif
>  		RTE_ACL_CLASSIFY_SCALAR,
>  	};
> diff --git a/lib/acl/rte_acl.h b/lib/acl/rte_acl.h
> index 95354cabb8..99210ff9c7 100644
> --- a/lib/acl/rte_acl.h
> +++ b/lib/acl/rte_acl.h
> @@ -248,6 +248,7 @@ enum rte_acl_classify_alg {
>  	RTE_ACL_CLASSIFY_ALTIVEC =3D 5,    /**< requires ALTIVEC support. */
>  	RTE_ACL_CLASSIFY_AVX512X16 =3D 6,  /**< requires AVX512 support. */
>  	RTE_ACL_CLASSIFY_AVX512X32 =3D 7,  /**< requires AVX512 support. */
> +	RTE_ACL_CLASSIFY_RVV =3D 8,     /**< requires RVV support. */
>  };
>=20
>  /**
> diff --git a/lib/eal/riscv/include/rte_vect.h b/lib/eal/riscv/include/rte=
_vect.h
> index a4357e266a..4d16082449 100644
> --- a/lib/eal/riscv/include/rte_vect.h
> +++ b/lib/eal/riscv/include/rte_vect.h
> @@ -19,7 +19,7 @@
>  extern "C" {
>  #endif
>=20
> -#define RTE_VECT_DEFAULT_SIMD_BITWIDTH RTE_VECT_SIMD_DISABLED
> +#define RTE_VECT_DEFAULT_SIMD_BITWIDTH RTE_VECT_SIMD_128
>=20
>  typedef int32_t		xmm_t __attribute__((vector_size(16)));
>=20
> --
> 2.52.0

