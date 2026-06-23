Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B202DCDB470
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 10:11:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8DFA402A2;
	Tue, 23 Jun 2026 12:11:28 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 0DC9C40269;
 Tue, 23 Jun 2026 12:11:27 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gl16b6S8tzJ46Dv;
 Tue, 23 Jun 2026 18:10:47 +0800 (CST)
Received: from frapema100002.china.huawei.com (unknown [7.182.19.63])
 by mail.maildlp.com (Postfix) with ESMTPS id AD2F740572;
 Tue, 23 Jun 2026 18:11:22 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100002.china.huawei.com (7.182.19.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 23 Jun 2026 12:11:22 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Tue, 23 Jun 2026 12:11:22 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: RE: [PATCH v3 1/6] bpf/x86: fix JIT encoding of BPF_JSET with
 immediate
Thread-Topic: [PATCH v3 1/6] bpf/x86: fix JIT encoding of BPF_JSET with
 immediate
Thread-Index: AQHdAZqZbIfnycILz0C32/nH6hBbQLZL6bwA
Date: Tue, 23 Jun 2026 10:11:22 +0000
Message-ID: <c29d854b938c462b9ef028a9dabc8b9a@huawei.com>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
 <20260621162524.82690-1-stephen@networkplumber.org>
 <20260621162524.82690-2-stephen@networkplumber.org>
In-Reply-To: <20260621162524.82690-2-stephen@networkplumber.org>
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

With the condition that the commit message is proofread,

Acked-by: Marat Khalili <marat.khalili@huawei.com>

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Sunday 21 June 2026 17:24
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; stable@dpdk.org; Kons=
tantin Ananyev
> <konstantin.ananyev@huawei.com>; Marat Khalili <marat.khalili@huawei.com>=
; Ferruh Yigit
> <ferruh.yigit@amd.com>
> Subject: [PATCH v3 1/6] bpf/x86: fix JIT encoding of BPF_JSET with immedi=
ate
>=20
> Several place in x86 JIT code, it assumes that for small immediate
> values the instruction size is one byte; but it is not.
>=20
> The immddiate form of the instruction takes a 32 bit value.
> The broken version of emit_tst_imm() emits TEST (0xF7 /0)
> but sized the immediate with imm_size(), which can return 1 byte.
>=20
> A small mask like BPF_JSET | BPF_K #0x1 then produced a
> 4-byte instruction the CPU decodes as 7,
> swallowing the following Jcc and crashing.
>=20
> Always emit a 32-bit immediate for TEST, ROR and SHIFT.

The commit message needs to be LLMed for typos and factual mistakes.

>=20
> Bugzilla ID: 1959
> Fixes: cc752e43e079 ("bpf: add JIT compilation for x86_64 ISA")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/bpf/bpf_jit_x86.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/lib/bpf/bpf_jit_x86.c b/lib/bpf/bpf_jit_x86.c
> index 88b1b5aeab..b14a574703 100644
> --- a/lib/bpf/bpf_jit_x86.c
> +++ b/lib/bpf/bpf_jit_x86.c
> @@ -300,7 +300,7 @@ emit_ror_imm(struct bpf_jit_state *st, uint32_t dreg,=
 uint32_t imm)
>  	emit_rex(st, BPF_ALU, 0, dreg);
>  	emit_bytes(st, &ops, sizeof(ops));
>  	emit_modregrm(st, MOD_DIRECT, mods, dreg);
> -	emit_imm(st, imm, imm_size(imm));
> +	emit_imm(st, imm, sizeof(uint8_t));

The fix appears to be correct, although this function was only ever called =
with
imm =3D=3D 8, so the problem was not reproducible.

>  }
>=20
>  /*
> @@ -441,7 +441,7 @@ emit_shift_imm(struct bpf_jit_state *st, uint32_t op,=
 uint32_t dreg,
>  	uint32_t imm)
>  {
>  	emit_shift(st, op, dreg);
> -	emit_imm(st, imm, imm_size(imm));
> +	emit_imm(st, imm, sizeof(uint8_t));

The fix appears to be correct, I would welcome a test reproducing the probl=
em.

>  }
>=20
>  /*
> @@ -921,7 +921,7 @@ emit_tst_imm(struct bpf_jit_state *st, uint32_t op, u=
int32_t dreg, uint32_t imm)
>  	emit_rex(st, op, 0, dreg);
>  	emit_bytes(st, &ops, sizeof(ops));
>  	emit_modregrm(st, MOD_DIRECT, mods, dreg);
> -	emit_imm(st, imm, imm_size(imm));
> +	emit_imm(st, imm, sizeof(int32_t));

The fix appears to be correct.

>  }
>=20
>  static void
> --
> 2.53.0

