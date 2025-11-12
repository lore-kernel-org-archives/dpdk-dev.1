Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F360CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 15:37:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F4C440A6B;
	Wed, 12 Nov 2025 16:37:35 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 2DB0F402AF
 for <dev@dpdk.org>; Wed, 12 Nov 2025 16:37:34 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d66w95jWPzHnGh6;
 Wed, 12 Nov 2025 23:37:13 +0800 (CST)
Received: from dubpeml100004.china.huawei.com (unknown [7.214.146.78])
 by mail.maildlp.com (Postfix) with ESMTPS id 1799F1400D9;
 Wed, 12 Nov 2025 23:37:33 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100004.china.huawei.com (7.214.146.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 12 Nov 2025 15:37:32 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Wed, 12 Nov 2025 15:37:32 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Marat Khalili <marat.khalili@huawei.com>
CC: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH 3/3] bpf: make add/subtract one program validate
Thread-Topic: [PATCH 3/3] bpf: make add/subtract one program validate
Thread-Index: AQHcUlcYZj4084yvwE2CFPi0Dbc8t7TvL5hw
Date: Wed, 12 Nov 2025 15:37:32 +0000
Message-ID: <4635dce2472e4e18a36afe454730001c@huawei.com>
References: <20251110153046.63518-1-marat.khalili@huawei.com>
 <20251110153046.63518-4-marat.khalili@huawei.com>
In-Reply-To: <20251110153046.63518-4-marat.khalili@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.81.199.148]
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



> Add tests loading simple BPF programs adding or subtracting one to its
> argument and fix triggered signed integer overflow undefined behaviours:
>=20
>     lib/bpf/bpf_validate.c:324:24: runtime error: signed integer
>     overflow: 1 + 9223372036854775807 cannot be represented in type
>     'long int'
>=20
>     lib/bpf/bpf_validate.c:352:24: runtime error: signed integer
>     overflow: -9223372036854775808 - 1 cannot be represented in type
>     'long int'
>=20
> As a minimal possible fix perform operation on unsigned integers where
> overflow is well-defined, which was probably the original intent.
>=20
> Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
> ---
>  app/test/test_bpf_simple.c | 58 ++++++++++++++++++++++++++++++++++++++
>  lib/bpf/bpf_validate.c     |  8 +++---
>  2 files changed, 62 insertions(+), 4 deletions(-)
>=20
> diff --git a/app/test/test_bpf_simple.c b/app/test/test_bpf_simple.c
> index 576a6ed029..d4c5bbdc6e 100644
> --- a/app/test/test_bpf_simple.c
> +++ b/app/test/test_bpf_simple.c
> @@ -129,3 +129,61 @@ test_simple_minimal_working(void)
>=20
>  REGISTER_FAST_TEST(bpf_simple_minimal_working_autotest, true, true,
>  	test_simple_minimal_working);
> +
> +/*
> + * Try and load valid BPF program adding one to the argument.
> + */
> +static int
> +test_simple_add_one(void)
> +{
> +	static const struct ebpf_insn ins[] =3D {
> +		{
> +			/* Set return value to one. */
> +			.code =3D (EBPF_ALU64 | EBPF_MOV | BPF_K),
> +			.dst_reg =3D EBPF_REG_0,
> +			.imm =3D 1,
> +		},
> +		{
> +			/* Add program argument to the return value. */
> +			.code =3D (EBPF_ALU64 | BPF_ADD | BPF_X),
> +			.src_reg =3D EBPF_REG_1,
> +			.dst_reg =3D EBPF_REG_0,
> +		},
> +		{
> +			.code =3D (BPF_JMP | EBPF_EXIT),
> +		},
> +	};
> +	return simple_bpf_load_test(RTE_DIM(ins), ins, 0);
> +}
> +
> +REGISTER_FAST_TEST(bpf_simple_add_one_autotest, true, true,
> +	test_simple_add_one);
> +
> +/*
> + * Try and load valid BPF program subtracting one from the argument.
> + */
> +static int
> +test_simple_subtract_one(void)
> +{
> +	static const struct ebpf_insn ins[] =3D {
> +		{
> +			/* Subtract one from the program argument. */
> +			.code =3D (EBPF_ALU64 | BPF_SUB | BPF_K),
> +			.dst_reg =3D EBPF_REG_1,
> +			.imm =3D 1,
> +		},
> +		{
> +			/* Set return value to the result. */
> +			.code =3D (EBPF_ALU64 | EBPF_MOV | BPF_X),
> +			.src_reg =3D EBPF_REG_1,
> +			.dst_reg =3D EBPF_REG_0,
> +		},
> +		{
> +			.code =3D (BPF_JMP | EBPF_EXIT),
> +		},
> +	};
> +	return simple_bpf_load_test(RTE_DIM(ins), ins, 0);
> +}
> +
> +REGISTER_FAST_TEST(bpf_simple_subtract_one_autotest, true, true,
> +	test_simple_subtract_one);
> diff --git a/lib/bpf/bpf_validate.c b/lib/bpf/bpf_validate.c
> index 23444b3eaa..47ad6fef0f 100644
> --- a/lib/bpf/bpf_validate.c
> +++ b/lib/bpf/bpf_validate.c
> @@ -243,8 +243,8 @@ eval_add(struct bpf_reg_val *rd, const struct bpf_reg=
_val
> *rs, uint64_t msk)
>=20
>  	rv.u.min =3D (rd->u.min + rs->u.min) & msk;
>  	rv.u.max =3D (rd->u.max + rs->u.max) & msk;
> -	rv.s.min =3D (rd->s.min + rs->s.min) & msk;
> -	rv.s.max =3D (rd->s.max + rs->s.max) & msk;
> +	rv.s.min =3D ((uint64_t)rd->s.min + (uint64_t)rs->s.min) & msk;
> +	rv.s.max =3D ((uint64_t)rd->s.max + (uint64_t)rs->s.max) & msk;
>=20
>  	/*
>  	 * if at least one of the operands is not constant,
> @@ -272,8 +272,8 @@ eval_sub(struct bpf_reg_val *rd, const struct bpf_reg=
_val
> *rs, uint64_t msk)
>=20
>  	rv.u.min =3D (rd->u.min - rs->u.max) & msk;
>  	rv.u.max =3D (rd->u.max - rs->u.min) & msk;
> -	rv.s.min =3D (rd->s.min - rs->s.max) & msk;
> -	rv.s.max =3D (rd->s.max - rs->s.min) & msk;
> +	rv.s.min =3D ((uint64_t)rd->s.min - (uint64_t)rs->s.max) & msk;
> +	rv.s.max =3D ((uint64_t)rd->s.max - (uint64_t)rs->s.min) & msk;
>=20
>  	/*
>  	 * if at least one of the operands is not constant,
> --

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

> 2.43.0


