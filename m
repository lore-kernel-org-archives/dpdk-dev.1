Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57FACD5BB1
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 May 2026 10:49:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE5E6402AC;
	Mon, 25 May 2026 12:49:06 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id EF3B740276
 for <dev@dpdk.org>; Mon, 25 May 2026 12:49:04 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gPCKV3yjjzHnH51;
 Mon, 25 May 2026 18:48:30 +0800 (CST)
Received: from frapema100001.china.huawei.com (unknown [7.182.19.23])
 by mail.maildlp.com (Postfix) with ESMTPS id 1439C40584;
 Mon, 25 May 2026 18:49:04 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100001.china.huawei.com (7.182.19.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 25 May 2026 12:49:03 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Mon, 25 May 2026 12:49:03 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH v3 04/27] bpf: replace atomic op macro with typed helpers
Thread-Topic: [PATCH v3 04/27] bpf: replace atomic op macro with typed helpers
Thread-Index: AQHc6u6T9VysyFc6LUCgnB0sUZnLubYeb7mw
Date: Mon, 25 May 2026 10:49:03 +0000
Message-ID: <ccd0bf4fba71446fb020349c40984c7c@huawei.com>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260523195839.454952-1-stephen@networkplumber.org>
 <20260523195839.454952-5-stephen@networkplumber.org>
In-Reply-To: <20260523195839.454952-5-stephen@networkplumber.org>
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

I absolutely welcome getting rid of macros in this file, but may I request
splitting the rte_atomicNN deprecation and the file refactoring into separa=
te
commits? I am not convinced refactoring was necessary for the deprecation h=
ere,
one-line change to `rte_atomic_fetch_add_explicit((type __rte_atomic *)...)=
` or
like would probably do the job.

If refactor, other examples should also be considered, although we of cours=
e
can do it macro by macro. But in any case we should follow some standard
template to reduce number of ways we do stuff in this file if possible.

Regardless of the process, please see some stylistic comments below.
(Technically, the code looks fine.)


> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Saturday 23 May 2026 20:56
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; Konstantin Ananyev <k=
onstantin.ananyev@huawei.com>;
> Marat Khalili <marat.khalili@huawei.com>
> Subject: [PATCH v3 04/27] bpf: replace atomic op macro with typed helpers
>=20
> The BPF_ST_ATOMIC_REG macro token-pasted the legacy rte_atomicNN_*()
> API names. It also stacked three casts on the destination pointer
> and reached a 'return 0' out of the macro into the caller's control
> flow.
>=20
> Replace it with two small static-inline helpers, bpf_atomic32() and
> bpf_atomic64(), that dispatch on ins->imm internally and use the C11
> atomic intrinsics directly. The destination is cast once, to a
> properly __rte_atomic-qualified pointer. [...]

nit: Not sure number of casts is a relevant metric, but I don't see any
improvement anyway, probably not worth talking about it.

// snip

> @@ -105,6 +83,69 @@
>  	reg[EBPF_REG_0] =3D op(p[0]); \
>  } while (0)
>=20
> +/*
> + * Atomic ops on the BPF target memory.
> + *
> + * BPF atomic instructions encode the destination as base register +
> + * signed offset, with the value to combine taken from src_reg.

nit: This applies to any eBPF instruction. And the part that is unusual abo=
ut
them that they can modify the source register is not mentioned.

> + *
> + * Memory order: seq_cst preserves the previous behavior of
> + * rte_atomicNN_add() / rte_atomicNN_exchange() and matches what the
> + * Linux kernel BPF interpreter does for these opcodes.

Not sure we should refer to the macros we are removing from the code in the
comment, this information belongs to the commit message.

> + *
> + * Returns 0 on unsupported sub-op (validator should have rejected it),
> + * 1 otherwise.

This is an unusual convention, we typically use negative value for errors, =
or
booleans in some cases.

To clarify, the original `return 0` was specifying return value from the
program, not an error code. For historical reasons in rare cases when the V=
M
cannot continue the program returns zero (maybe we should reconsider it).

> + */
> +static inline int
> +bpf_atomic32(const struct rte_bpf *bpf, uint64_t reg[EBPF_REG_NUM],
> +	     const struct ebpf_insn *ins)
> +{
> +	/* need to casts to make bpf memory suitable for C11 atomic */

Typo in "need to casts"? (Also not sure what we warn about here.)

> +	uint32_t __rte_atomic *dst
> +		=3D (uint32_t __rte_atomic *)(uintptr_t)(reg[ins->dst_reg] + ins->off)=
;

nit: Is it `uint32_t __rte_atomic *` or `RTE_ATOMIC(uint32_t) *`? I honestl=
y
don't know why we have both, but the latter seems more popular in the codeb=
ase.

> +	uint32_t val =3D (uint32_t)reg[ins->src_reg];
> +
> +	switch (ins->imm) {
> +	case BPF_ATOMIC_ADD:
> +		rte_atomic_fetch_add_explicit(dst, val, rte_memory_order_seq_cst);
> +		return 1;
> +	case BPF_ATOMIC_XCHG:
> +		reg[ins->src_reg] =3D rte_atomic_exchange_explicit(dst, val,
> +								 rte_memory_order_seq_cst);

nit: This is not a typical style of indentation for this file.

> +		return 1;
> +	default:
> +		RTE_BPF_LOG_LINE(ERR,
> +			"%s(%p): unsupported atomic operation at pc: %#zx;",
> +			__func__, bpf,
> +			(uintptr_t)ins - (uintptr_t)bpf->prm.ins);
> +		return 0;

This was an optional defensive programming. Since other functions like
`bpf_alu_be` do not have any default label we can arguably just remove it h=
ere
and return void (also not accept bpf argument). With the macro it all was a=
t
least transparent to the caller.

> +	}
> +}

// snip the rest
