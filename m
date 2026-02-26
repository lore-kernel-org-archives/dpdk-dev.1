Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D24FCE08D
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 14:24:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6DCEE4027F;
	Thu, 26 Feb 2026 15:24:46 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 1F9054026F
 for <dev@dpdk.org>; Thu, 26 Feb 2026 15:24:45 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fMDH65sdFzJ46Dy;
 Thu, 26 Feb 2026 22:24:18 +0800 (CST)
Received: from frapema500001.china.huawei.com (unknown [7.182.19.243])
 by mail.maildlp.com (Postfix) with ESMTPS id CA8374056B;
 Thu, 26 Feb 2026 22:24:43 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500001.china.huawei.com (7.182.19.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 26 Feb 2026 15:24:43 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Thu, 26 Feb 2026 15:24:43 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Wathsala Vithanage <wathsala.vithanage@arm.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [RFC] bpf/arm64: add BPF_ABS/BPF_IND packet load support
Thread-Topic: [RFC] bpf/arm64: add BPF_ABS/BPF_IND packet load support
Thread-Index: AQHcpPuTqdAqBhOf5UKsxdcvCXT2OLWU9p0A
Date: Thu, 26 Feb 2026 14:24:43 +0000
Message-ID: <e9264a6e2e934b3089b26d09b18bfd7b@huawei.com>
References: <20260223193522.323100-1-stephen@networkplumber.org>
In-Reply-To: <20260223193522.323100-1-stephen@networkplumber.org>
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

Thank you for looking into this problem.

Some general comments:

* This needs tests verifying that instructions, both hardcoded in the test =
and
  converted from pcap filter, actually load expected numbers from the packe=
t
  (or fail as required by specification).

* Instead of hand-coding corresponding logic in machine code for each
  architecture, should we consider writing it once in eBPF and using only
  minimal architecture-dependent code for insertion?

About AI generation. I feel like I spent much more time reading this stuff =
than
AI spent generating it. It does not feel fair. This needs a lot of work to =
be
of production quality, and it is possible that many of us would do it faste=
r
without AI. Highlighting possible improvements feels very gratifying when p=
art
of a teaching process with an intern, relatively useless for an AI model. S=
ince
each of us has access to this stuff, I'm not sure what the point is in doin=
g it
this way.

Please see my comments inline to understand what I mean.

> diff --git a/lib/bpf/bpf_jit_arm64.c b/lib/bpf/bpf_jit_arm64.c
> index a04ef33a9c..dff101dbba 100644
> --- a/lib/bpf/bpf_jit_arm64.c
> +++ b/lib/bpf/bpf_jit_arm64.c
> @@ -3,11 +3,13 @@
>   */
>=20
>  #include <errno.h>
> +#include <stddef.h>
>  #include <stdbool.h>
>  #include <stdlib.h>
>=20
>  #include <rte_common.h>
>  #include <rte_byteorder.h>
> +#include <rte_mbuf.h>
>=20
>  #include "bpf_impl.h"
>=20
> @@ -43,6 +45,7 @@ struct a64_jit_ctx {
>  	uint32_t program_start;   /* Program index, Just after prologue */
>  	uint32_t program_sz;      /* Program size. Found in first pass */
>  	uint8_t foundcall;        /* Found EBPF_CALL class code in eBPF pgm */
> +	uint8_t foundldmbuf;      /* Found BPF_ABS/BPF_IND in eBPF pgm */
>  };
>=20
>  static int
> @@ -1137,12 +1140,293 @@ check_program_has_call(struct a64_jit_ctx *ctx, =
struct rte_bpf *bpf)
>  		switch (op) {
>  		/* Call imm */
>  		case (BPF_JMP | EBPF_CALL):
> +		/*
> +		 * BPF_ABS/BPF_IND instructions may need to call
> +		 * __rte_pktmbuf_read() in the slow path, so treat
> +		 * them as having a call for register save purposes.
> +		 */
> +		case (BPF_LD | BPF_ABS | BPF_B):
> +		case (BPF_LD | BPF_ABS | BPF_H):
> +		case (BPF_LD | BPF_ABS | BPF_W):
> +		case (BPF_LD | BPF_IND | BPF_B):
> +		case (BPF_LD | BPF_IND | BPF_H):
> +		case (BPF_LD | BPF_IND | BPF_W):
>  			ctx->foundcall =3D 1;
> +			ctx->foundldmbuf =3D 1;

Will set it for calls as well.

>  			return;
>  		}
>  	}
>  }
>=20
> +/*
> + * Emit SUBS (extended register) for comparing with zero-extended halfwo=
rd.
> + * Used to compare: data_len - offset against size.
> + * CMP (imm): SUBS Xd, Xn, #imm

This whole comment confuses more than clarifies:
* I believe CMP is a valid mnemonic in itself, no need to go too nerdy abou=
t this.
* No idea what "zero-extended halfword" means here (maybe someone can help)=
.
* How it is being used belongs to the place of use, not function declaratio=
n.
* There is no Xd in function arguments, so not sure what last line explains=
.

Comment to the next one is only marginally better. IMO before writing a com=
ment
AI should ask itself "what will be unclear here to the reader", not "what
random facts I can add to make it look smarter".

> + */
> +static void
> +emit_cmp_imm(struct a64_jit_ctx *ctx, bool is64, uint8_t rn, uint16_t im=
m12)
> +{
> +	uint32_t insn, imm;
> +	int32_t simm;
> +
> +	imm =3D mask_imm(12, imm12);
> +	simm =3D (int32_t)imm12;
> +	insn =3D RTE_SHIFT_VAL32(is64, 31);
> +	insn |=3D RTE_SHIFT_VAL32(1, 30); /* SUB */
> +	insn |=3D RTE_SHIFT_VAL32(1, 29); /* set flags */
> +	insn |=3D UINT32_C(0x11000000);
> +	insn |=3D A64_ZR; /* Rd =3D ZR for CMP */
> +	insn |=3D RTE_SHIFT_VAL32(rn, 5);
> +	insn |=3D RTE_SHIFT_VAL32(imm, 10);
> +
> +	emit_insn(ctx, insn, check_reg(rn) || check_imm(12, simm));
> +}
> +
> +/*
> + * Emit a load from [rn + unsigned immediate offset].
> + * LDR (unsigned offset): size determined by sz parameter.
> + */
> +static void
> +emit_ldr_uimm(struct a64_jit_ctx *ctx, uint8_t sz, uint8_t rt, uint8_t r=
n,
> +	       uint16_t uimm)
> +{
> +	uint32_t insn, scale, imm;
> +	int32_t simm;
> +
> +	/* Determine scale from BPF size encoding */
> +	if (sz =3D=3D BPF_B)
> +		scale =3D 0;
> +	else if (sz =3D=3D BPF_H)
> +		scale =3D 1;
> +	else if (sz =3D=3D BPF_W)
> +		scale =3D 2;
> +	else /* EBPF_DW */
> +		scale =3D 3;
> +
> +	/* imm12 is the offset divided by the access size */
> +	imm =3D uimm >> scale;

This is error-prone, need to either assert (maybe even static_assert) that =
uimm
is a multiple of scale here, or accept already descaled number and deal wit=
h it
at the place of call.

> +	simm =3D (int32_t)imm;

This whole uimm -> imm -> simm logic is a bit hard to follow. Maybe my pers=
onal
preference, but I'd get rid of at least simm, which is just an exact copy o=
f
imm with different type. It also makes one question if some edge cases with
negative numbers are not overlooked.

> +
> +	insn =3D RTE_SHIFT_VAL32(scale, 30);
> +	insn |=3D UINT32_C(0x39400000); /* LDR (unsigned offset) base */
> +	insn |=3D RTE_SHIFT_VAL32(mask_imm(12, imm), 10);
> +	insn |=3D RTE_SHIFT_VAL32(rn, 5);
> +	insn |=3D rt;
> +
> +	emit_insn(ctx, insn, check_reg(rt) || check_reg(rn) ||
> +		  check_imm(12, simm) || check_ls_sz(sz));
> +}

These functions should probably integrate with and follow the style of exis=
ting
ones like emit_cmp_tst/emit_cmp and emit_ls/emit_ldr. Even if deliberately
duplicating some code, it should at least be copied verbatim, not re-invent=
ed.

Both function accept immediate as uint16_t for some reason, truncating it f=
rom
uint32_t or size_t. This truncation does not seem to be checked explicitly.
Should we accept ssize_t instead?

> +
> +/*
> + * Emit code for BPF_LD | BPF_ABS and BPF_LD | BPF_IND packet loads.
> + *
> + * These instructions load data from the packet referenced by the mbuf
> + * pointer implicitly held in EBPF_REG_6. The algorithm mirrors the
> + * inline rte_pktmbuf_read():
> + *
> + *   fast path (single-segment, contiguous):
> + *     off =3D imm               (BPF_ABS)
> + *     off =3D src_reg + imm     (BPF_IND)
> + *     if (off + size <=3D mbuf->data_len)
> + *         R0 =3D *(type *)(mbuf->buf_addr + mbuf->data_off + off)
> + *         R0 =3D bswap(R0)    // network to host byte order
> + *     else goto slow_path
> + *
> + *   slow path (multi-segment or out-of-bounds):
> + *     ptr =3D __rte_pktmbuf_read(mbuf, off, size, tmp_buf_on_stack)
> + *     if (ptr =3D=3D NULL) goto exit
> + *     R0 =3D *(type *)ptr
> + *     R0 =3D bswap(R0)
> + */
> +static void
> +emit_ld_mbuf(struct a64_jit_ctx *ctx, uint8_t op, uint8_t src,
> +	     int32_t imm, uint8_t tmp1, uint8_t tmp2)
> +{
> +	uint8_t r0, r6;
> +	uint8_t mode, opsz;
> +	uint32_t sz;
> +	int32_t exit_off;
> +
> +	r0 =3D ebpf_to_a64_reg(ctx, EBPF_REG_0);
> +	r6 =3D ebpf_to_a64_reg(ctx, EBPF_REG_6);
> +
> +	mode =3D BPF_MODE(op);
> +	opsz =3D BPF_SIZE(op);
> +	sz =3D bpf_size(opsz);
> +
> +	/*
> +	 * Compute the packet offset in tmp1.
> +	 * BPF_ABS: off =3D imm
> +	 * BPF_IND: off =3D src_reg + imm
> +	 */
> +	emit_mov_imm(ctx, 1, tmp1, imm);
> +	if (mode =3D=3D BPF_IND)
> +		emit_add(ctx, 1, tmp1, src);
> +
> +	/*
> +	 * Fast path: check if access is within the first segment.
> +	 * Load mbuf->data_len (uint16_t) into tmp2.
> +	 */
> +	emit_ldr_uimm(ctx, BPF_H, tmp2, r6,
> +		       offsetof(struct rte_mbuf, data_len));
> +	/* Zero-extend tmp2 to 64-bit (data_len is 16-bit) */
> +	emit_bitfield(ctx, 1, tmp2, tmp2, 0, 15, A64_UBFM);

All emit_bitfield calls seem unnecessary to me, but maybe ARM folks will
correct me.

> +
> +	/* tmp2 =3D data_len - off */
> +	emit_sub(ctx, 1, tmp2, tmp1);
> +
> +	/*
> +	 * If data_len - off < sz, the access extends beyond the first
> +	 * segment. Branch to the slow path.
> +	 * CMP tmp2, #sz; B.LT slow_path
> +	 *
> +	 * The slow path is a fixed number of instructions ahead.
> +	 * Fast path remaining instructions (counted below):
> +	 *   emit_ldr_uimm  (buf_addr)    1
> +	 *   emit_ldr_uimm  (data_off)    1
> +	 *   emit_bitfield  (zext)        1
> +	 *   emit_add       (+ data_off)  1
> +	 *   emit_add       (+ off)       1
> +	 *   emit_ldr       (load value)  1
> +	 *   emit_rev / emit_zero_extend  1 or 2 (max 2)
> +	 *   emit_b         (skip slow)   1
> +	 * Total fast path after branch: max 9 instructions
> +	 *
> +	 * We branch forward to the slow path start.
> +	 * Calculate as: the b_cond instruction itself is at current idx,
> +	 * then 9 instructions of fast path follow, so slow path starts
> +	 * at +10 from the b_cond (but b_cond offset is in instructions
> +	 * relative to itself, so +10).

This is pure train of thought of the model.

> +	 *
> +	 * Use B.LT for signed comparison: if data_len < off, tmp2 went
> +	 * negative so this catches both insufficient length and negative
> +	 * offset results.
> +	 */
> +	emit_cmp_imm(ctx, 1, tmp2, sz);
> +	/* Count of fast path instructions to skip: varies by byte-swap */
> +	{
> +		/*
> +		 * For BPF_B: no swap needed, just zero_extend 64 =3D nop
> +		 * For BPF_H: rev16 + zero_extend =3D 2 insns
> +		 * For BPF_W: rev32 =3D 1 insn
> +		 * To simplify, use a fixed forward offset.
> +		 * Fast path body: 6 insns (load ptr computation + ldr) +
> +		 * swap (0 for B, 2 for H, 1 for W) + 1 branch =3D 7..9
> +		 *
> +		 * Use the two-pass approach: first pass calculates offsets,
> +		 * second pass emits. We track the instruction index.

Train of thought continues. It first tried to calculate necessary jump offs=
ets
in its head, but then gave up and switched to dynamic approach.

By the time it reaches the end it realizes it can patch generated code inst=
ead
of doing another pass, so "two-pass approach" is a lie too.

> +		 */
> +		uint32_t fast_start, fast_end, slow_start, slow_end;
> +
> +		fast_start =3D ctx->idx;
> +
> +		/* Placeholder: emit B.LT with a dummy offset (will be fixed) */
> +		emit_b_cond(ctx, A64_LT, 0);
> +
> +		/* =3D=3D=3D Fast path body =3D=3D=3D */
> +
> +		/* Load buf_addr (void *, 8 bytes at offset 0) into r0 */
> +		emit_ldr_uimm(ctx, EBPF_DW, r0, r6,
> +			       offsetof(struct rte_mbuf, buf_addr));
> +
> +		/* Load data_off (uint16_t) into tmp2 */
> +		emit_ldr_uimm(ctx, BPF_H, tmp2, r6,
> +			       offsetof(struct rte_mbuf, data_off));
> +		/* Zero-extend data_off to 64-bit */
> +		emit_bitfield(ctx, 1, tmp2, tmp2, 0, 15, A64_UBFM);
> +
> +		/* r0 =3D buf_addr + data_off */
> +		emit_add(ctx, 1, r0, tmp2);
> +		/* r0 =3D buf_addr + data_off + off */
> +		emit_add(ctx, 1, r0, tmp1);
> +
> +		/* Load the actual value: r0 =3D *(size *)r0 */
> +		emit_mov_imm(ctx, 1, tmp2, 0);
> +		emit_ldr(ctx, opsz, r0, r0, tmp2);

Explicitly zeroing real register to use in each ldr seems unnecessary too.

> +
> +		/* Byte-swap from network order to host order */
> +		if (opsz =3D=3D BPF_H)
> +			emit_rev(ctx, r0, 16);
> +		else if (opsz =3D=3D BPF_W)
> +			emit_rev(ctx, r0, 32);
> +		/* BPF_B: no swap needed */

Should use existing function emit_be.

> +
> +		/* Skip the slow path */
> +		emit_b(ctx, 0); /* placeholder */
> +		fast_end =3D ctx->idx;

Would make more sense to put fast_end one instruction earlier, especially s=
ince
we already have slow_start here.

> +
> +		/* =3D=3D=3D Slow path =3D=3D=3D */
> +		slow_start =3D ctx->idx;
> +
> +		/*
> +		 * Call __rte_pktmbuf_read(mbuf, off, len, buf).
> +		 * ARM64 calling convention: R0-R3 are arguments.
> +		 * R0 =3D mbuf (EBPF_REG_6)
> +		 * R1 =3D off (tmp1)
> +		 * R2 =3D len (sz)
> +		 * R3 =3D buf (stack pointer, we use current SP as temp buf)
> +		 *
> +		 * The caller-save EBPF registers R1-R5 are scratch anyway
> +		 * for BPF_ABS/BPF_IND instructions per the BPF spec.
> +		 */
> +
> +		/* R0 =3D mbuf */
> +		emit_mov_64(ctx, A64_R(0), r6);
> +		/* R1 =3D off (already in tmp1, move to A64_R(1)) */
> +		emit_mov_64(ctx, A64_R(1), tmp1);
> +		/* R2 =3D size */
> +		emit_mov_imm(ctx, 0, A64_R(2), sz);
> +		/* R3 =3D address of temp buffer on the stack (use SP) */
> +		emit_mov_64(ctx, A64_R(3), A64_SP);

I would personally use FP, but not a big deal.

> +
> +		/* Call __rte_pktmbuf_read */
> +		emit_mov_imm(ctx, 1, tmp2, (uint64_t)__rte_pktmbuf_read);
> +		emit_blr(ctx, tmp2);
> +
> +		/* Check return value: if NULL, exit with 0 */
> +		/* R0 has the return value (pointer or NULL) */
> +		emit_cbnz(ctx, 1, A64_R(0), 3);
> +		emit_mov_imm(ctx, 1, r0, 0);
> +		exit_off =3D (ctx->program_start + ctx->program_sz) - ctx->idx;
> +		emit_b(ctx, exit_off);

Should use existing function emit_return_zero_if_src_zero.

> +
> +		/* Load value from returned pointer */
> +		emit_mov_imm(ctx, 1, tmp2, 0);
> +		emit_ldr(ctx, opsz, A64_R(0), A64_R(0), tmp2);
> +
> +		/* Byte-swap from network order to host order */
> +		if (opsz =3D=3D BPF_H)
> +			emit_rev(ctx, A64_R(0), 16);
> +		else if (opsz =3D=3D BPF_W)
> +			emit_rev(ctx, A64_R(0), 32);
> +		/* BPF_B: no swap needed */

Both emit_be's can be moved into common code path (lesser of all problems).

> +
> +		/* Move result to EBPF R0 register */
> +		emit_mov_64(ctx, r0, A64_R(0));
> +
> +		slow_end =3D ctx->idx;
> +
> +		/*
> +		 * Now fix up the forward branches that were emitted with
> +		 * placeholder offsets. We re-emit them with correct offsets.
> +		 *
> +		 * The B.LT at fast_start should jump to slow_start.
> +		 * The B at fast_end-1 should jump to slow_end.
> +		 */
> +		if (ctx->ins !=3D NULL) {
> +			/* Fix B.LT: offset from fast_start to slow_start */
> +			ctx->idx =3D fast_start;
> +			emit_b_cond(ctx, A64_LT,
> +				    (int32_t)(slow_start - fast_start));
> +
> +			/* Fix B: offset from fast_end-1 to slow_end */
> +			ctx->idx =3D fast_end - 1;
> +			emit_b(ctx, (int32_t)(slow_end - (fast_end - 1)));

There is already some infra for patching branch offsets in this file, and n=
ote
that this will be executed twice. Even ignoring all it, this kind of hack w=
ith
temporary changing ctx->idx needs to be encapsulated in a function.

> +		}
> +		ctx->idx =3D slow_end;
> +	}

This function is too long and needs to be splitted, see x86 as example.

> +}
> +
>  /*
>   * Walk through eBPF code and translate them to arm64 one.
>   */
> @@ -1162,6 +1446,13 @@ emit(struct a64_jit_ctx *ctx, struct rte_bpf *bpf)
>  	ctx->idx =3D 0;
>  	/* arm64 SP must be aligned to 16 */
>  	ctx->stack_sz =3D RTE_ALIGN_MUL_CEIL(bpf->stack_sz, 16);
> +	/*
> +	 * BPF_ABS/BPF_IND instructions need a temporary buffer on the
> +	 * stack for __rte_pktmbuf_read(). Reserve at least 16 bytes
> +	 * (aligned) below the BPF stack for this purpose.
> +	 */
> +	if (ctx->foundldmbuf && ctx->stack_sz =3D=3D 0)
> +		ctx->stack_sz =3D 16;

Extra space is already reserved in __rte_bpf_validate. Even then, what is e=
ven
going on here?

>  	tmp1 =3D ebpf_to_a64_reg(ctx, TMP_REG_1);
>  	tmp2 =3D ebpf_to_a64_reg(ctx, TMP_REG_2);
>  	tmp3 =3D ebpf_to_a64_reg(ctx, TMP_REG_3);
> @@ -1338,6 +1629,16 @@ emit(struct a64_jit_ctx *ctx, struct rte_bpf *bpf)
>  			emit_mov_imm(ctx, 1, dst, u64);
>  			i++;
>  			break;
> +		/* R0 =3D ntoh(*(size *)(mbuf->pkt_data + imm)) */
> +		case (BPF_LD | BPF_ABS | BPF_B):
> +		case (BPF_LD | BPF_ABS | BPF_H):
> +		case (BPF_LD | BPF_ABS | BPF_W):
> +		/* R0 =3D ntoh(*(size *)(mbuf->pkt_data + src + imm)) */
> +		case (BPF_LD | BPF_IND | BPF_B):
> +		case (BPF_LD | BPF_IND | BPF_H):
> +		case (BPF_LD | BPF_IND | BPF_W):
> +			emit_ld_mbuf(ctx, op, src, imm, tmp1, tmp2);
> +			break;
>  		/* *(size *)(dst + off) =3D src */
>  		case (BPF_STX | BPF_MEM | BPF_B):
>  		case (BPF_STX | BPF_MEM | BPF_H):
> --
> 2.51.0

