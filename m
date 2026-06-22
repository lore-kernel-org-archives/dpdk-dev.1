Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B54CD98F2
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 16:27:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E9D140611;
	Mon, 22 Jun 2026 18:26:59 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id ADA0440150;
 Mon, 22 Jun 2026 18:26:57 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gkYVW4JXZzHnGcV;
 Tue, 23 Jun 2026 00:26:27 +0800 (CST)
Received: from frapema500002.china.huawei.com (unknown [7.182.19.148])
 by mail.maildlp.com (Postfix) with ESMTPS id 39B6C4058D;
 Tue, 23 Jun 2026 00:26:56 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500002.china.huawei.com (7.182.19.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 22 Jun 2026 18:26:56 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Mon, 22 Jun 2026 18:26:55 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Christophe Fontaine <cfontain@redhat.com>, "stable@dpdk.org"
 <stable@dpdk.org>, Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>, Jerin Jacob
 <jerinj@marvell.com>
Subject: RE: [PATCH v3 3/6] bpf/arm64: fix offset type to allow a negative jump
Thread-Topic: [PATCH v3 3/6] bpf/arm64: fix offset type to allow a negative
 jump
Thread-Index: AQHdAZqZqr36ZKw+zk2bUklf5Dkle7ZKw9rw
Date: Mon, 22 Jun 2026 16:26:55 +0000
Message-ID: <6ba54fbca1fb4b4681174e001508fafa@huawei.com>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
 <20260621162524.82690-1-stephen@networkplumber.org>
 <20260621162524.82690-4-stephen@networkplumber.org>
In-Reply-To: <20260621162524.82690-4-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.78]
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
> Sent: Sunday 21 June 2026 17:24
> To: dev@dpdk.org
> Cc: Christophe Fontaine <cfontain@redhat.com>; stable@dpdk.org; Stephen H=
emminger
> <stephen@networkplumber.org>; Wathsala Vithanage <wathsala.vithanage@arm.=
com>; Konstantin Ananyev
> <konstantin.ananyev@huawei.com>; Marat Khalili <marat.khalili@huawei.com>=
; Jerin Jacob
> <jerinj@marvell.com>
> Subject: [PATCH v3 3/6] bpf/arm64: fix offset type to allow a negative ju=
mp
>=20
> From: Christophe Fontaine <cfontain@redhat.com>
>=20
> The DPDK BPF JIT standalone test test_ld_mbuf1 fails on arm64.
> It does:
> 	r6 =3D r1                    // mbuf
> 	r0 =3D *(u8 *)pkt[0]         // BPF_ABS
> 	if ((r0 & 0xf0) =3D=3D 0x40)
> 		goto parse
> 	r0 =3D 0
> 	exit                       // epilogue E0
> parse:
> 	r0 =3D *(u8 *)pkt[r0 + 3]    // BPF_IND
> 	...
> 	exit
>=20
> emit_return_zero_if_src_zero() returns 0 by branching to a function
> epilogue. The target maybe a previous epilogue so branch
> might be backwards; therefore the offset needs to be negative.
>=20
> The offset was stored in a uint16_t, so a negative value wrapped to a
> large positive number; emit_b() then branched past the end of the
> program and faulted at run time.
>=20
> Fixes: 111e2a747a4f ("bpf/arm: add basic arithmetic operations")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Christophe Fontaine <cfontain@redhat.com>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/bpf/bpf_jit_arm64.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/bpf/bpf_jit_arm64.c b/lib/bpf/bpf_jit_arm64.c
> index a04ef33a9c..67e42015de 100644
> --- a/lib/bpf/bpf_jit_arm64.c
> +++ b/lib/bpf/bpf_jit_arm64.c
> @@ -957,10 +957,12 @@ static void
>  emit_return_zero_if_src_zero(struct a64_jit_ctx *ctx, bool is64, uint8_t=
 src)
>  {
>  	uint8_t r0 =3D ebpf_to_a64_reg(ctx, EBPF_REG_0);
> -	uint16_t jump_to_epilogue;
> +	int32_t jump_to_epilogue;
>=20
>  	emit_cbnz(ctx, is64, src, 3);
>  	emit_mov_imm(ctx, is64, r0, 0);
> +
> +	/* maybe backwards branch to earlier epilogue */
>  	jump_to_epilogue =3D (ctx->program_start + ctx->program_sz) - ctx->idx;
>  	emit_b(ctx, jump_to_epilogue);
>  }
> --
> 2.53.0

I still wish it was not called program_sz here, but the fix is not wrong, s=
o

Acked-by: Marat Khalili <marat.khalili@huawei.com>
