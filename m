Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA983CD4F26
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Jun 2026 10:34:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA84740609;
	Fri, 26 Jun 2026 12:34:34 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 96C5640265
 for <dev@dpdk.org>; Fri, 26 Jun 2026 12:34:33 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gmsTn3x2FzJ46F6;
 Fri, 26 Jun 2026 18:33:49 +0800 (CST)
Received: from frapema100001.china.huawei.com (unknown [7.182.19.23])
 by mail.maildlp.com (Postfix) with ESMTPS id 55D7840584;
 Fri, 26 Jun 2026 18:34:29 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100001.china.huawei.com (7.182.19.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 26 Jun 2026 12:34:29 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Fri, 26 Jun 2026 12:34:29 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Wathsala Vithanage <wathsala.vithanage@arm.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>
Subject: RE: [PATCH v6 7/9] bpf/arm64: add BPF_ABS/BPF_IND packet load support
Thread-Topic: [PATCH v6 7/9] bpf/arm64: add BPF_ABS/BPF_IND packet load support
Thread-Index: AQHdBMikkgmf5HsM5E6jMiCQ8e8wy7ZQpMtA
Date: Fri, 26 Jun 2026 10:34:28 +0000
Message-ID: <7337f1ce55ff4e69bfa65bb4322c9bc4@huawei.com>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
 <20260625173231.216074-1-stephen@networkplumber.org>
 <20260625173231.216074-8-stephen@networkplumber.org>
In-Reply-To: <20260625173231.216074-8-stephen@networkplumber.org>
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
> Sent: Thursday 25 June 2026 18:30
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; Wathsala Vithanage <w=
athsala.vithanage@arm.com>;
> Konstantin Ananyev <konstantin.ananyev@huawei.com>; Marat Khalili <marat.=
khalili@huawei.com>
> Subject: [PATCH v6 7/9] bpf/arm64: add BPF_ABS/BPF_IND packet load suppor=
t
>=20
> The arm64 JIT rejected BPF_LD | BPF_ABS and BPF_LD | BPF_IND with
> "invalid opcode", so cBPF programs converted by rte_bpf_convert() could
> not be JITed. Add these opcodes, mirroring the x86 JIT: a fast path for
> data held in the first mbuf segment, and a __rte_pktmbuf_read() slow
> path for everything else.
>=20
> The forward branches over the call cannot use fixed distances:
> emit_call() materializes the helper address with a variable number of
> mov/movk instructions, so the block sizes are not known up front. Size
> the three blocks (fast path, slow path, common tail) in a dry run, then
> emit for real with the branches resolved from the measured offsets.
>=20
> The effective offset is validated before use: src is a runtime value for
> BPF_IND, so a negative offset is routed to the slow path rather than
> read from the first segment, and the offset is bounded to UINT32_MAX
> before __rte_pktmbuf_read(), whose off argument is uint32_t.
>=20
> Programs using these opcodes use the call register layout, since the
> slow path makes a function call.
>=20
> For example, BPF_LD | BPF_IND | BPF_W (4-byte indirect load, mbuf in
> R6/x19, effective offset kept in x9) emits:
>=20
> 	mov	x9, #imm		// off  =3D imm
> 	add	x9, x9, src		// off +=3D src		(BPF_IND)
> 	cmp	x9, xzr			// reject negative
> 	b.mi	slow			//   effective offset
> 	mov	x10, #data_len_ofs
> 	ldrh	w10, [x19, x10]		// mbuf->data_len
> 	sub	x10, x10, x9		// data_len - off
> 	mov	x11, #sz
> 	cmp	x10, x11
> 	b.lt	slow			// not in first segment
> 	mov	x10, #data_off_ofs
> 	ldrh	w10, [x19, x10]		// mbuf->data_off
> 	mov	x7, #buf_addr_ofs
> 	ldr	x7, [x19, x7]		// mbuf->buf_addr
> 	add	x7, x7, x10
> 	add	x7, x7, x9		// ptr =3D buf_addr + data_off + off
> 	b	load
> slow:
> 	mov	x10, #UINT32_MAX
> 	cmp	x9, x10
> 	b.ls	1f			// off fits uint32_t ...
> 	mov	x7, #0			//   else return 0
> 	b	epilogue
> 1:	mov	x1, x9			// __rte_pktmbuf_read(mbuf, off, sz, buf)
> 	mov	x0, x19
> 	mov	w2, #sz
> 	sub	x3, x25, #stack_ofs
> 	mov	x9, #<helper lo>
> 	movk	x9, #<helper hi>
> 	blr	x9
> 	mov	x7, x0			// ptr =3D return value
> 	cbnz	x7, load		// non-NULL -> common tail
> 	mov	x7, #0			//   else return 0
> 	b	epilogue
> load:
> 	ldr	w7, [x7, xzr]		// *(uint32_t *)ptr	(size varies)
> 	rev32	x7, x7			// ntoh	(size varies; omitted for BPF_B)
>=20
> For BPF_ABS the "add x9, x9, src" is omitted; the final load/byte-swap
> vary with the access size.
>=20
> Bugzilla ID: 1427
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>


Acked-by: Marat Khalili <marat.khalili@huawei.com>


> ---
>  lib/bpf/bpf_jit_arm64.c | 169 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 168 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/bpf/bpf_jit_arm64.c b/lib/bpf/bpf_jit_arm64.c
> index 51906c7f0d..6d531dc83d 100644
> --- a/lib/bpf/bpf_jit_arm64.c
> +++ b/lib/bpf/bpf_jit_arm64.c
> @@ -1133,6 +1133,155 @@ emit_branch(struct a64_jit_ctx *ctx, uint8_t op, =
uint32_t i, int16_t off)
>  	emit_b_cond(ctx, ebpf_to_a64_cond(op), jump_offset_get(ctx, i, off));
>  }
>=20
> +/* LD_ABS/LD_IND code block offsets (in arm64 instructions) */
> +enum {
> +	LDMB_FAST_OFS, /* fast path */
> +	LDMB_SLOW_OFS, /* slow path */
> +	LDMB_FIN_OFS,  /* common tail */
> +	LDMB_OFS_NUM
> +};
> +
> +/*
> + * Helper for emit_ld_mbuf(): fast path.
> + * Compute the packet offset; if it lies inside the first segment leave =
the
> + * data pointer in R0, otherwise branch to the slow path.
> + */
> +static void
> +emit_ldmb_fast_path(struct a64_jit_ctx *ctx, uint8_t src, uint8_t mode,
> +		    uint32_t sz, int32_t imm, const uint32_t ofs[LDMB_OFS_NUM])
> +{
> +	uint8_t r0 =3D ebpf_to_a64_reg(ctx, EBPF_REG_0);
> +	uint8_t r6 =3D ebpf_to_a64_reg(ctx, EBPF_REG_6);
> +	uint8_t tmp1 =3D ebpf_to_a64_reg(ctx, TMP_REG_1);
> +	uint8_t tmp2 =3D ebpf_to_a64_reg(ctx, TMP_REG_2);
> +	uint8_t tmp3 =3D ebpf_to_a64_reg(ctx, TMP_REG_3);
> +
> +	/* off =3D imm (+ src for BPF_IND) */
> +	emit_mov_imm(ctx, 1, tmp1, imm);
> +	if (mode =3D=3D BPF_IND)
> +		emit_add(ctx, 1, tmp1, src);
> +
> +	/*
> +	 * A negative effective offset (src can be < 0 for BPF_IND) would pass
> +	 * the signed check below and read before the segment, so route it to
> +	 * the slow path, which rejects it via the uint32_t bound on off.
> +	 */
> +	emit_cmp(ctx, 1, tmp1, A64_ZR);
> +	emit_b_cond(ctx, A64_MI, (int32_t)(ofs[LDMB_SLOW_OFS] - ctx->idx));
> +
> +	/* if ((int64_t)(mbuf->data_len - off) < sz) goto slow_path */
> +	emit_mov_imm(ctx, 1, tmp2, offsetof(struct rte_mbuf, data_len));
> +	emit_ldr(ctx, BPF_H, tmp2, r6, tmp2);
> +	emit_sub(ctx, 1, tmp2, tmp1);
> +	emit_mov_imm(ctx, 1, tmp3, sz);
> +	emit_cmp(ctx, 1, tmp2, tmp3);
> +	emit_b_cond(ctx, A64_LT, (int32_t)(ofs[LDMB_SLOW_OFS] - ctx->idx));
> +
> +	/* R0 =3D mbuf->buf_addr + mbuf->data_off + off */
> +	emit_mov_imm(ctx, 1, tmp2, offsetof(struct rte_mbuf, data_off));
> +	emit_ldr(ctx, BPF_H, tmp2, r6, tmp2);
> +	emit_mov_imm(ctx, 1, r0, offsetof(struct rte_mbuf, buf_addr));
> +	emit_ldr(ctx, EBPF_DW, r0, r6, r0);
> +	emit_add(ctx, 1, r0, tmp2);
> +	emit_add(ctx, 1, r0, tmp1);
> +
> +	emit_b(ctx, (int32_t)(ofs[LDMB_FIN_OFS] - ctx->idx));
> +}
> +
> +/*
> + * Helper for emit_ld_mbuf(): slow path.
> + * R0 =3D __rte_pktmbuf_read(mbuf, off, sz, buf); return 0 if NULL.
> + * The scratch buffer is the space reserved by __rte_bpf_validate() at t=
he
> + * bottom of the eBPF stack frame, i.e. (frame_pointer - stack_ofs).
> + */
> +static void
> +emit_ldmb_slow_path(struct a64_jit_ctx *ctx, uint32_t sz, uint32_t stack=
_ofs)
> +{
> +	uint8_t r0 =3D ebpf_to_a64_reg(ctx, EBPF_REG_0);
> +	uint8_t r6 =3D ebpf_to_a64_reg(ctx, EBPF_REG_6);
> +	uint8_t fp =3D ebpf_to_a64_reg(ctx, EBPF_FP);
> +	uint8_t tmp1 =3D ebpf_to_a64_reg(ctx, TMP_REG_1);
> +	uint8_t tmp2 =3D ebpf_to_a64_reg(ctx, TMP_REG_2);
> +
> +	/*
> +	 * __rte_pktmbuf_read() takes a uint32_t off, so a 64-bit off that does
> +	 * not fit would be silently truncated.  Return 0 if it is out of range=
;
> +	 * this also catches the negative off routed here by the fast path.
> +	 */
> +	emit_mov_imm(ctx, 1, tmp2, UINT32_MAX);
> +	emit_cmp(ctx, 1, tmp1, tmp2);
> +	emit_b_cond(ctx, A64_LS, 3);		/* off <=3D UINT32_MAX: do the call */
> +	emit_mov_imm(ctx, 1, r0, 0);
> +	emit_b(ctx, (ctx->program_start + ctx->program_sz) - ctx->idx);
> +
> +	/* arguments of __rte_pktmbuf_read(mbuf, off, len, buf) */
> +	emit_mov_64(ctx, A64_R(1), tmp1);		/* off (held in tmp1) */
> +	emit_mov_64(ctx, A64_R(0), r6);			/* mbuf */
> +	emit_mov_imm(ctx, 0, A64_R(2), sz);		/* len */
> +	emit_sub_imm_64(ctx, A64_R(3), fp, stack_ofs);	/* buf */
> +
> +	emit_call(ctx, tmp1, (void *)(uintptr_t)__rte_pktmbuf_read);
> +	emit_return_zero_if_src_zero(ctx, 1, r0);
> +}
> +
> +/*
> + * Helper for emit_ld_mbuf(): common tail.
> + * Load the value pointed to by R0 and convert from network byte order.
> + */
> +static void
> +emit_ldmb_fin(struct a64_jit_ctx *ctx, uint8_t opsz, uint32_t sz)
> +{
> +	uint8_t r0 =3D ebpf_to_a64_reg(ctx, EBPF_REG_0);
> +
> +	emit_ldr(ctx, opsz, r0, r0, A64_ZR);
> +	if (opsz !=3D BPF_B)
> +		emit_be(ctx, r0, sz * 8);
> +}
> +
> +/*
> + * Emit code for BPF_LD | BPF_ABS and BPF_LD | BPF_IND packet loads:
> + *
> + *	off =3D imm (+ src for BPF_IND)
> + *	if (off >=3D 0 && mbuf->data_len - off >=3D sz)	    -- fast path
> + *		ptr =3D mbuf->buf_addr + mbuf->data_off + off;
> + *	else						    -- slow path
> + *		if ((uint64_t)off > UINT32_MAX)
> + *			return 0;
> + *		ptr =3D __rte_pktmbuf_read(mbuf, off, sz, buf);
> + *		if (ptr =3D=3D NULL)
> + *			return 0;
> + *	R0 =3D ntoh(*(size *)ptr);			    -- common tail
> + *
> + * The three blocks are sized in a dry run so the forward branches can b=
e
> + * resolved, then emitted for real (arm64 instructions are fixed width, =
so
> + * the dry run reproduces the real instruction count exactly).
> + */
> +static void
> +emit_ld_mbuf(struct a64_jit_ctx *ctx, uint8_t op, uint8_t src, int32_t i=
mm,
> +	     uint32_t stack_ofs)
> +{
> +	uint8_t mode =3D BPF_MODE(op);
> +	uint8_t opsz =3D BPF_SIZE(op);
> +	uint32_t sz =3D bpf_size(opsz);
> +	uint32_t ofs[LDMB_OFS_NUM];
> +
> +	/* seed offsets so the dry-run branches stay in range */
> +	ofs[LDMB_FAST_OFS] =3D ofs[LDMB_SLOW_OFS] =3D ofs[LDMB_FIN_OFS] =3D ctx=
->idx;
> +
> +	/* dry run to record block offsets */
> +	emit_ldmb_fast_path(ctx, src, mode, sz, imm, ofs);
> +	ofs[LDMB_SLOW_OFS] =3D ctx->idx;
> +	emit_ldmb_slow_path(ctx, sz, stack_ofs);
> +	ofs[LDMB_FIN_OFS] =3D ctx->idx;
> +	emit_ldmb_fin(ctx, opsz, sz);
> +
> +	/* rewind and emit for real with resolved offsets */
> +	ctx->idx =3D ofs[LDMB_FAST_OFS];
> +	emit_ldmb_fast_path(ctx, src, mode, sz, imm, ofs);
> +	emit_ldmb_slow_path(ctx, sz, stack_ofs);
> +	emit_ldmb_fin(ctx, opsz, sz);
> +}
> +
>  static void
>  check_program_has_call(struct a64_jit_ctx *ctx, struct rte_bpf *bpf)
>  {
> @@ -1145,8 +1294,17 @@ check_program_has_call(struct a64_jit_ctx *ctx, st=
ruct rte_bpf *bpf)
>  		op =3D ins->code;
>=20
>  		switch (op) {
> -		/* Call imm */
> +		/*
> +		 * BPF_ABS/BPF_IND can fall through to __rte_pktmbuf_read(),
> +		 * so they need the call-clobbered register layout as well.
> +		 */
>  		case (BPF_JMP | EBPF_CALL):
> +		case (BPF_LD | BPF_ABS | BPF_B):
> +		case (BPF_LD | BPF_ABS | BPF_H):
> +		case (BPF_LD | BPF_ABS | BPF_W):
> +		case (BPF_LD | BPF_IND | BPF_B):
> +		case (BPF_LD | BPF_IND | BPF_H):
> +		case (BPF_LD | BPF_IND | BPF_W):
>  			ctx->foundcall =3D 1;
>  			return;
>  		}
> @@ -1348,6 +1506,15 @@ emit(struct a64_jit_ctx *ctx, struct rte_bpf *bpf)
>  			emit_mov_imm(ctx, 1, dst, u64);
>  			i++;
>  			break;
> +		/* R0 =3D ntoh(*(size *)(mbuf data + (src) + imm)) */
> +		case (BPF_LD | BPF_ABS | BPF_B):
> +		case (BPF_LD | BPF_ABS | BPF_H):
> +		case (BPF_LD | BPF_ABS | BPF_W):
> +		case (BPF_LD | BPF_IND | BPF_B):
> +		case (BPF_LD | BPF_IND | BPF_H):
> +		case (BPF_LD | BPF_IND | BPF_W):
> +			emit_ld_mbuf(ctx, op, src, imm, bpf->stack_sz);
> +			break;
>  		/* *(size *)(dst + off) =3D src */
>  		case (BPF_STX | BPF_MEM | BPF_B):
>  		case (BPF_STX | BPF_MEM | BPF_H):
> --
> 2.53.0

