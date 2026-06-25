Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A67BCDE001
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 15:40:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28D1A40A6C;
	Thu, 25 Jun 2026 17:40:44 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id E9B304067D;
 Thu, 25 Jun 2026 17:40:42 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gmNKZ5BJzzJ467Y;
 Thu, 25 Jun 2026 23:40:02 +0800 (CST)
Received: from frapema500002.china.huawei.com (unknown [7.182.19.148])
 by mail.maildlp.com (Postfix) with ESMTPS id 3708240572;
 Thu, 25 Jun 2026 23:40:41 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500002.china.huawei.com (7.182.19.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 25 Jun 2026 17:40:41 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Thu, 25 Jun 2026 17:40:41 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Jerin Jacob <jerinj@marvell.com>
Subject: RE: [PATCH v5 4/9] bpf/arm64: mask shift count per RFC 9669
Thread-Topic: [PATCH v5 4/9] bpf/arm64: mask shift count per RFC 9669
Thread-Index: AQHdBAMSLNElA7oGn0akDH9DCOe4k7ZPadcg
Date: Thu, 25 Jun 2026 15:40:40 +0000
Message-ID: <183afa6fd48f491d9b53bce512ae7615@huawei.com>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
 <20260624175815.673064-1-stephen@networkplumber.org>
 <20260624175815.673064-5-stephen@networkplumber.org>
In-Reply-To: <20260624175815.673064-5-stephen@networkplumber.org>
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
> Sent: Wednesday 24 June 2026 18:55
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; stable@dpdk.org; Wath=
sala Vithanage
> <wathsala.vithanage@arm.com>; Konstantin Ananyev <konstantin.ananyev@huaw=
ei.com>; Marat Khalili
> <marat.khalili@huawei.com>; Jerin Jacob <jerinj@marvell.com>
> Subject: [PATCH v5 4/9] bpf/arm64: mask shift count per RFC 9669
>=20
> The ARM JIT was not masking the shift count as required by RFC 9669
> (0x3f for 64-bit, 0x1f for 32-bit), so large immediate shift counts
> overflowed the UBFM/SBFM encoding and failed the JIT. Mask the
> immediate in emit_lsl/emit_lsr/emit_asr.
>=20
> Fixes: 9f4469d9e83a ("bpf/arm: add logical operations")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: Marat Khalili <marat.khalili@huawei.com>

> ---
>  lib/bpf/bpf_jit_arm64.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/lib/bpf/bpf_jit_arm64.c b/lib/bpf/bpf_jit_arm64.c
> index ba7ae4d680..7582370062 100644
> --- a/lib/bpf/bpf_jit_arm64.c
> +++ b/lib/bpf/bpf_jit_arm64.c
> @@ -545,12 +545,14 @@ emit_bitfield(struct a64_jit_ctx *ctx, bool is64, u=
int8_t rd, uint8_t rn,
>  	emit_insn(ctx, insn, check_reg(rd) || check_reg(rn) ||
>  		  check_immr_imms(is64, immr, imms));
>  }
> +
>  static void
>  emit_lsl(struct a64_jit_ctx *ctx, bool is64, uint8_t rd, uint8_t imm)
>  {
>  	const unsigned int width =3D is64 ? 64 : 32;
>  	uint8_t imms, immr;
>=20
> +	imm &=3D width - 1;
>  	immr =3D (width - imm) & (width - 1);
>  	imms =3D width - 1 - imm;
>=20
> @@ -560,13 +562,19 @@ emit_lsl(struct a64_jit_ctx *ctx, bool is64, uint8_=
t rd, uint8_t imm)
>  static void
>  emit_lsr(struct a64_jit_ctx *ctx, bool is64, uint8_t rd, uint8_t imm)
>  {
> -	emit_bitfield(ctx, is64, rd, rd, imm, is64 ? 63 : 31, A64_UBFM);
> +	const unsigned int width =3D is64 ? 64 : 32;
> +
> +	imm &=3D width - 1;
> +	emit_bitfield(ctx, is64, rd, rd, imm, width - 1, A64_UBFM);
>  }
>=20
>  static void
>  emit_asr(struct a64_jit_ctx *ctx, bool is64, uint8_t rd, uint8_t imm)
>  {
> -	emit_bitfield(ctx, is64, rd, rd, imm, is64 ? 63 : 31, A64_SBFM);
> +	const unsigned int width =3D is64 ? 64 : 32;
> +
> +	imm &=3D width - 1;
> +	emit_bitfield(ctx, is64, rd, rd, imm, width - 1, A64_SBFM);
>  }
>=20
>  #define A64_AND 0
> --
> 2.53.0

