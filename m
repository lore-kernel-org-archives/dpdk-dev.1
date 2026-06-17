Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0191CD98E2
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 19:35:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20CEF402D0;
	Wed, 17 Jun 2026 21:35:08 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 37EDD40276
 for <dev@dpdk.org>; Wed, 17 Jun 2026 21:35:06 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4ggYvz117kzJ467Y;
 Thu, 18 Jun 2026 03:34:39 +0800 (CST)
Received: from frapema500002.china.huawei.com (unknown [7.182.19.148])
 by mail.maildlp.com (Postfix) with ESMTPS id A1A0C40570;
 Thu, 18 Jun 2026 03:35:04 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500002.china.huawei.com (7.182.19.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 17 Jun 2026 21:35:04 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Wed, 17 Jun 2026 21:35:04 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Wathsala Vithanage <wathsala.vithanage@arm.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>
Subject: RE: [PATCH 4/4] bpf/arm64: add BPF_ABS/BPF_IND packet load support
Thread-Topic: [PATCH 4/4] bpf/arm64: add BPF_ABS/BPF_IND packet load support
Thread-Index: AQHc94YUU1XjLCE+P0629UQkL+sFk7ZDHOrg
Date: Wed, 17 Jun 2026 19:35:04 +0000
Message-ID: <5d3ac533de2f4e1fbb43f983a408fb23@huawei.com>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
 <20260608203322.1116296-5-stephen@networkplumber.org>
In-Reply-To: <20260608203322.1116296-5-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.72.97]
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

Thank you for doing this. I suggest comparing against the previous effort b=
y Christophe Fontaine though.

Couple of comments inline, superficially looks correct otherwise.

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
> +	/* if ((int64_t)(mbuf->data_len - off) < sz) goto slow_path */
> +	emit_mov_imm(ctx, 1, tmp2, offsetof(struct rte_mbuf, data_len));
> +	emit_ldr(ctx, BPF_H, tmp2, r6, tmp2);
> +	emit_sub(ctx, 1, tmp2, tmp1);
> +	emit_mov_imm(ctx, 1, tmp3, sz);
> +	emit_cmp(ctx, 1, tmp2, tmp3);
> +	emit_b_cond(ctx, A64_LT, (int32_t)(ofs[LDMB_SLOW_OFS] - ctx->idx));

Are we checking that (int64_t)off >=3D 0 anywhere?

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

// snip

> +/*
> + * Emit code for BPF_LD | BPF_ABS and BPF_LD | BPF_IND packet loads:
> + *
> + *	off =3D imm (+ src for BPF_IND)
> + *	if (mbuf->data_len - off >=3D sz)			    -- fast path
> + *		ptr =3D mbuf->buf_addr + mbuf->data_off + off;
> + *	else						    -- slow path
> + *		ptr =3D __rte_pktmbuf_read(mbuf, off, sz, buf);
> + *		if (ptr =3D=3D NULL)
> + *			return 0;
> + *	R0 =3D ntoh(*(size *)ptr);			    -- common tail

nit: this pseudo-code could probably be made more C-like.

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

nit: we already do two passes for the whole program, could avoid quadruple =
work here

> +
> +	/* rewind and emit for real with resolved offsets */
> +	ctx->idx =3D ofs[LDMB_FAST_OFS];
> +	emit_ldmb_fast_path(ctx, src, mode, sz, imm, ofs);
> +	emit_ldmb_slow_path(ctx, sz, stack_ofs);
> +	emit_ldmb_fin(ctx, opsz, sz);
> +}

// snip the rest
