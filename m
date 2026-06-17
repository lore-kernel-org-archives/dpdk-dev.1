Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD671CD98E2
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 18:03:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC88F40276;
	Wed, 17 Jun 2026 20:03:46 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 3269840268;
 Wed, 17 Jun 2026 20:03:45 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4ggWtZ4F24zJ469c;
 Thu, 18 Jun 2026 02:03:18 +0800 (CST)
Received: from frapema500002.china.huawei.com (unknown [7.182.19.148])
 by mail.maildlp.com (Postfix) with ESMTPS id 0114140575;
 Thu, 18 Jun 2026 02:03:44 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500002.china.huawei.com (7.182.19.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 17 Jun 2026 20:03:43 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Wed, 17 Jun 2026 20:03:43 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Jerin Jacob <jerinj@marvell.com>
Subject: RE: [PATCH 1/4] bpf/arm64: fix zero-return branch in multi-exit
 programs
Thread-Topic: [PATCH 1/4] bpf/arm64: fix zero-return branch in multi-exit
 programs
Thread-Index: AQHc94YUAXjzc3dGR02oQpnDQLIOpLZDDH5g
Date: Wed, 17 Jun 2026 18:03:43 +0000
Message-ID: <dd7f912351034089a1ff0c4563368832@huawei.com>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
 <20260608203322.1116296-2-stephen@networkplumber.org>
In-Reply-To: <20260608203322.1116296-2-stephen@networkplumber.org>
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

> If a JIT'd BPF program has more than one exit,
> the branch to the epilogue can be backwards.
>=20
> The current code assumed it is always forward:
> emit_return_zero_if_src_zero() held the offset in an unsigned uint16_t,
> so a backward (negative) offset wrapped to a large positive value and
> branch off the end of the program, faulting at run time.
>=20
> This was masked until now: the only test with this shape, test_ld_mbuf,
> needs BPF_ABS/BPF_IND which the arm64 JIT did not implement, so it never
> ran under the JIT.  The x86 JIT is unaffected because emit_epilog() keeps=
 a
> single exit (st->exit.off) reached from later exits and the divide-by-zer=
o
> check via a signed absolute jump (emit_abs_jcc), so direction does not
> matter.
>=20
> Use a signed offset; emit_b() already sign-extends imm26 correctly.

This line is unclear to me, but that's not the main issue.

> Fixes: 111e2a747a4f ("bpf/arm: add basic arithmetic operations")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/bpf/bpf_jit_arm64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/bpf/bpf_jit_arm64.c b/lib/bpf/bpf_jit_arm64.c
> index a04ef33a9c..099822e9f1 100644
> --- a/lib/bpf/bpf_jit_arm64.c
> +++ b/lib/bpf/bpf_jit_arm64.c
> @@ -957,7 +957,7 @@ static void
>  emit_return_zero_if_src_zero(struct a64_jit_ctx *ctx, bool is64, uint8_t=
 src)
>  {
>  	uint8_t r0 =3D ebpf_to_a64_reg(ctx, EBPF_REG_0);
> -	uint16_t jump_to_epilogue;
> +	int32_t jump_to_epilogue;
>=20
>  	emit_cbnz(ctx, is64, src, 3);
>  	emit_mov_imm(ctx, is64, r0, 0);
> --
> 2.53.0

In the very next line the offset is calculated as follows though:

    jump_to_epilogue =3D (ctx->program_start + ctx->program_sz) - ctx->idx;

From its appearance, it can never be negative. However, ctx->program_sz is =
set
in emit_epilogue which is issued on every BPF_EXIT, so mid-generation it
contains the location of the last issued epilogue (including possibly previ=
ous
pass), not the program size. With this interpretation the code technically
works, but I'd suggest either renaming program_sz to something like
epilogue_offset, or making sure it is only set to the actual program size (=
sans
prologue and epilogue). In the latter case the jump offset will never be
negative, although the change to int32_t is still helpful in extending the
range of supported programs from 2**16 instructions. Since only 26 signed b=
its
are actually available maybe some check or assert is also warranted.
