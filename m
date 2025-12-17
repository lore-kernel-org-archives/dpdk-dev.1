Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F1FD65526
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Dec 2025 09:50:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 682F8402F1;
	Wed, 17 Dec 2025 10:50:00 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 2282C4026C;
 Wed, 17 Dec 2025 10:49:58 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id DB42A202CC;
 Wed, 17 Dec 2025 10:49:57 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v2 2/5] bpf: fix signed shift overflows in ARM JIT
Date: Wed, 17 Dec 2025 10:49:57 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F655F1@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20251216182036.77869-3-marat.khalili@huawei.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2 2/5] bpf: fix signed shift overflows in ARM JIT
Thread-Index: AdxuuMSEoWNBsNXVRxGEfLSPGv9VrgAfxBdQ
References: <20251110153046.63518-1-marat.khalili@huawei.com>
 <20251216182036.77869-1-marat.khalili@huawei.com>
 <20251216182036.77869-3-marat.khalili@huawei.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Marat Khalili" <marat.khalili@huawei.com>, <stephen@networkplumber.org>,
 <jerinjacobk@gmail.com>, "Wathsala Vithanage" <wathsala.vithanage@arm.com>,
 "Konstantin Ananyev" <konstantin.ananyev@huawei.com>
Cc: <dev@dpdk.org>,
	<stable@dpdk.org>
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

> From: Marat Khalili [mailto:marat.khalili@huawei.com]
> Sent: Tuesday, 16 December 2025 19.21
>=20
> Left shifts of integer literals and bool values overwriting the sign
> bit
> were used multiple times in bpf_jit_arm64.c. E.g.:
>=20
>     insn =3D (!!is64) << 31;
>=20
> where is64 has type bool (double bang is a no-op here).

Yes, multiple online sources [1] confirms that the bool type can only =
hold two values, 0 and 1, and converting any non-zero value to bool =
results in 1.

So, using !!x where x is a bool is literally a no-op, since x - being a =
bool - could already only hold the values 0 and 1.

[1]: E.g.
https://www.gnu.org/software/c-intro-and-ref/manual/html_node/Boolean-Typ=
e.html
https://embedded.fm/blog/2016/5/3/ew-bools

> The operand of
> left shift was promoted to type int, which when 32-bit wide cannot
> represent the result. Similarly literal integers have int type by
> default.  Sanitizer produced the following diagnostic during runtime
> (for various lines):
>=20
>     lib/bpf/bpf_jit_arm64.c:241:18: runtime error: left shift of 1 by
> 31
>     places cannot be represented in type 'int'
>=20
> To fix the issue use RTE_BIT32 and similar macros instead.
>=20
> Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
> ---
>  lib/bpf/bpf_jit_arm64.c | 162 =
++++++++++++++++++++--------------------
>  1 file changed, 81 insertions(+), 81 deletions(-)
>=20
> diff --git a/lib/bpf/bpf_jit_arm64.c b/lib/bpf/bpf_jit_arm64.c
> index 96b8cd2e03..76df1e4ba1 100644
> --- a/lib/bpf/bpf_jit_arm64.c
> +++ b/lib/bpf/bpf_jit_arm64.c
> @@ -28,7 +28,7 @@
>  #define A64_ZR			31
>=20
>  #define check_imm(n, val) (((val) >=3D 0) ? !!((val) >> (n)) : =
!!((~val)
> >> (n)))
> -#define mask_imm(n, val) ((val) & ((1 << (n)) - 1))
> +#define mask_imm(n, val) ((val) & (RTE_BIT32(n) - 1))
>=20
>  struct ebpf_a64_map {
>  	uint32_t off; /* eBPF to arm64 insn offset mapping for jump */
> @@ -238,12 +238,12 @@ emit_add_sub_imm(struct a64_jit_ctx *ctx, bool
> is64, bool sub, uint8_t rd,
>  	uint32_t insn, imm;
>=20
>  	imm =3D mask_imm(12, imm12);
> -	insn =3D (!!is64) << 31;
> -	insn |=3D (!!sub) << 30;
> +	insn =3D RTE_SHIFT_VAL32(is64, 31);
> +	insn |=3D RTE_SHIFT_VAL32(sub, 30);

As mentioned above, !!is64 and !!sub are literally no-ops, so it is safe =
to remove them.

>  	insn |=3D 0x11000000;
>  	insn |=3D rd;
> -	insn |=3D rn << 5;
> -	insn |=3D imm << 10;
> +	insn |=3D RTE_SHIFT_VAL32(rn, 5);
> +	insn |=3D RTE_SHIFT_VAL32(imm, 10);
>=20
>  	emit_insn(ctx, insn,
>  		  check_reg(rd) || check_reg(rn) || check_imm(12, imm12));
> @@ -279,16 +279,16 @@ emit_ls_pair_64(struct a64_jit_ctx *ctx, uint8_t
> rt, uint8_t rt2, uint8_t rn,
>  {
>  	uint32_t insn;
>=20
> -	insn =3D (!!load) << 22;
> -	insn |=3D (!!pre_index) << 24;
> +	insn =3D RTE_SHIFT_VAL32(load, 22);
> +	insn |=3D RTE_SHIFT_VAL32(pre_index, 24);
>  	insn |=3D 0xa8800000;

This constant has the high bit set, consider:
insn |=3D UINT32_C(0xa8800000);

And for consistency, consider also doing it for constants where the high =
bit isn't set.

Throughout the file.

>  	insn |=3D rt;
> -	insn |=3D rn << 5;
> -	insn |=3D rt2 << 10;
> +	insn |=3D RTE_SHIFT_VAL32(rn, 5);
> +	insn |=3D RTE_SHIFT_VAL32(rt2, 10);
>  	if (push)
> -		insn |=3D 0x7e << 15; /* 0x7e means -2 with imm7 */
> +		insn |=3D RTE_SHIFT_VAL32(0x7e, 15); /* 0x7e means -2 with
> imm7 */
>  	else
> -		insn |=3D 0x2 << 15;
> +		insn |=3D RTE_SHIFT_VAL32(0x2, 15);
>=20
>  	emit_insn(ctx, insn, check_reg(rn) || check_reg(rt) ||
> check_reg(rt2));
>=20
> @@ -317,11 +317,11 @@ mov_imm(struct a64_jit_ctx *ctx, bool is64,
> uint8_t rd, uint8_t type,
>  {
>  	uint32_t insn;
>=20
> -	insn =3D (!!is64) << 31;
> -	insn |=3D type << 29;
> -	insn |=3D 0x25 << 23;
> -	insn |=3D (shift/16) << 21;
> -	insn |=3D imm16 << 5;
> +	insn =3D RTE_SHIFT_VAL32(is64, 31);
> +	insn |=3D RTE_SHIFT_VAL32(type, 29);
> +	insn |=3D RTE_SHIFT_VAL32(0x25, 23);
> +	insn |=3D RTE_SHIFT_VAL32(shift/16, 21);
> +	insn |=3D RTE_SHIFT_VAL32(imm16, 5);
>  	insn |=3D rd;
>=20
>  	emit_insn(ctx, insn, check_reg(rd) || check_mov_hw(is64, shift));
> @@ -334,7 +334,7 @@ emit_mov_imm32(struct a64_jit_ctx *ctx, bool is64,
> uint8_t rd, uint32_t val)
>  	uint16_t lower =3D val & 0xffff;
>=20
>  	/* Positive number */
> -	if ((val & 1UL << 31) =3D=3D 0) {
> +	if ((val & RTE_BIT32(31)) =3D=3D 0) {
>  		mov_imm(ctx, is64, rd, A64_MOVZ, lower, 0);
>  		if (upper)
>  			mov_imm(ctx, is64, rd, A64_MOVK, upper, 16);
> @@ -393,21 +393,21 @@ emit_ls(struct a64_jit_ctx *ctx, uint8_t sz,
> uint8_t rt, uint8_t rn, uint8_t rm,
>  {
>  	uint32_t insn;
>=20
> -	insn =3D 0x1c1 << 21;
> +	insn =3D RTE_SHIFT_VAL32(0x1c1, 21);
>  	if (load)
> -		insn |=3D 1 << 22;
> +		insn |=3D RTE_BIT32(22);
>  	if (sz =3D=3D BPF_B)
> -		insn |=3D 0 << 30;
> +		insn |=3D RTE_SHIFT_VAL32(0, 30);
>  	else if (sz =3D=3D BPF_H)
> -		insn |=3D 1 << 30;
> +		insn |=3D RTE_SHIFT_VAL32(1, 30);
>  	else if (sz =3D=3D BPF_W)
> -		insn |=3D 2 << 30;
> +		insn |=3D RTE_SHIFT_VAL32(2, 30);
>  	else if (sz =3D=3D EBPF_DW)
> -		insn |=3D 3 << 30;
> +		insn |=3D RTE_SHIFT_VAL32(3, 30);
>=20
> -	insn |=3D rm << 16;
> -	insn |=3D 0x1a << 10; /* LSL and S =3D 0 */
> -	insn |=3D rn << 5;
> +	insn |=3D RTE_SHIFT_VAL32(rm, 16);
> +	insn |=3D RTE_SHIFT_VAL32(0x1a, 10); /* LSL and S =3D 0 */
> +	insn |=3D RTE_SHIFT_VAL32(rn, 5);
>  	insn |=3D rt;
>=20
>  	emit_insn(ctx, insn, check_reg(rt) || check_reg(rn) ||
> check_reg(rm) ||
> @@ -436,10 +436,10 @@ emit_add_sub(struct a64_jit_ctx *ctx, bool is64,
> uint8_t rd, uint8_t rn,
>  {
>  	uint32_t insn;
>=20
> -	insn =3D (!!is64) << 31;
> -	insn |=3D op << 21; /* shift =3D=3D 0 */
> -	insn |=3D rm << 16;
> -	insn |=3D rn << 5;
> +	insn =3D RTE_SHIFT_VAL32(is64, 31);
> +	insn |=3D RTE_SHIFT_VAL32(op, 21); /* shift =3D=3D 0 */
> +	insn |=3D RTE_SHIFT_VAL32(rm, 16);
> +	insn |=3D RTE_SHIFT_VAL32(rn, 5);
>  	insn |=3D rd;
>=20
>  	emit_insn(ctx, insn, check_reg(rd) || check_reg(rm));
> @@ -468,11 +468,11 @@ emit_mul(struct a64_jit_ctx *ctx, bool is64,
> uint8_t rd, uint8_t rm)
>  {
>  	uint32_t insn;
>=20
> -	insn =3D (!!is64) << 31;
> -	insn |=3D 0xd8 << 21;
> -	insn |=3D rm << 16;
> -	insn |=3D A64_ZR << 10;
> -	insn |=3D rd << 5;
> +	insn =3D RTE_SHIFT_VAL32(is64, 31);
> +	insn |=3D RTE_SHIFT_VAL32(0xd8, 21);
> +	insn |=3D RTE_SHIFT_VAL32(rm, 16);
> +	insn |=3D RTE_SHIFT_VAL32(A64_ZR, 10);
> +	insn |=3D RTE_SHIFT_VAL32(rd, 5);
>  	insn |=3D rd;
>=20
>  	emit_insn(ctx, insn, check_reg(rd) || check_reg(rm));
> @@ -489,11 +489,11 @@ emit_data_process_two_src(struct a64_jit_ctx
> *ctx, bool is64, uint8_t rd,
>  {
>  	uint32_t insn;
>=20
> -	insn =3D (!!is64) << 31;
> -	insn |=3D 0xd6 << 21;
> -	insn |=3D rm << 16;
> -	insn |=3D op << 10;
> -	insn |=3D rn << 5;
> +	insn =3D RTE_SHIFT_VAL32(is64, 31);
> +	insn |=3D RTE_SHIFT_VAL32(0xd6, 21);
> +	insn |=3D RTE_SHIFT_VAL32(rm, 16);
> +	insn |=3D RTE_SHIFT_VAL32(op, 10);
> +	insn |=3D RTE_SHIFT_VAL32(rn, 5);
>  	insn |=3D rd;
>=20
>  	emit_insn(ctx, insn, check_reg(rd) || check_reg(rm));
> @@ -532,14 +532,14 @@ emit_bitfield(struct a64_jit_ctx *ctx, bool =
is64,
> uint8_t rd, uint8_t rn,
>  {
>  	uint32_t insn;
>=20
> -	insn =3D (!!is64) << 31;
> +	insn =3D RTE_SHIFT_VAL32(is64, 31);
>  	if (insn)
> -		insn |=3D 1 << 22; /* Set N bit when is64 is set */
> -	insn |=3D op << 29;
> -	insn |=3D 0x26 << 23;
> -	insn |=3D immr << 16;
> -	insn |=3D imms << 10;
> -	insn |=3D rn << 5;
> +		insn |=3D RTE_BIT32(22); /* Set N bit when is64 is set */
> +	insn |=3D RTE_SHIFT_VAL32(op, 29);
> +	insn |=3D RTE_SHIFT_VAL32(0x26, 23);
> +	insn |=3D RTE_SHIFT_VAL32(immr, 16);
> +	insn |=3D RTE_SHIFT_VAL32(imms, 10);
> +	insn |=3D RTE_SHIFT_VAL32(rn, 5);
>  	insn |=3D rd;
>=20
>  	emit_insn(ctx, insn, check_reg(rd) || check_reg(rn) ||
> @@ -578,11 +578,11 @@ emit_logical(struct a64_jit_ctx *ctx, bool is64,
> uint8_t rd,
>  {
>  	uint32_t insn;
>=20
> -	insn =3D (!!is64) << 31;
> -	insn |=3D op << 29;
> -	insn |=3D 0x50 << 21;
> -	insn |=3D rm << 16;
> -	insn |=3D rd << 5;
> +	insn =3D RTE_SHIFT_VAL32(is64, 31);
> +	insn |=3D RTE_SHIFT_VAL32(op, 29);
> +	insn |=3D RTE_SHIFT_VAL32(0x50, 21);
> +	insn |=3D RTE_SHIFT_VAL32(rm, 16);
> +	insn |=3D RTE_SHIFT_VAL32(rd, 5);
>  	insn |=3D rd;
>=20
>  	emit_insn(ctx, insn, check_reg(rd) || check_reg(rm));
> @@ -612,12 +612,12 @@ emit_msub(struct a64_jit_ctx *ctx, bool is64,
> uint8_t rd, uint8_t rn,
>  {
>  	uint32_t insn;
>=20
> -	insn =3D (!!is64) << 31;
> -	insn |=3D 0xd8 << 21;
> -	insn |=3D rm << 16;
> -	insn |=3D 0x1 << 15;
> -	insn |=3D ra << 10;
> -	insn |=3D rn << 5;
> +	insn =3D RTE_SHIFT_VAL32(is64, 31);
> +	insn |=3D RTE_SHIFT_VAL32(0xd8, 21);
> +	insn |=3D RTE_SHIFT_VAL32(rm, 16);
> +	insn |=3D RTE_SHIFT_VAL32(0x1, 15);
> +	insn |=3D RTE_SHIFT_VAL32(ra, 10);
> +	insn |=3D RTE_SHIFT_VAL32(rn, 5);
>  	insn |=3D rd;
>=20
>  	emit_insn(ctx, insn, check_reg(rd) || check_reg(rn) ||
> check_reg(rm) ||
> @@ -638,7 +638,7 @@ emit_blr(struct a64_jit_ctx *ctx, uint8_t rn)
>  	uint32_t insn;
>=20
>  	insn =3D 0xd63f0000;
> -	insn |=3D rn << 5;
> +	insn |=3D RTE_SHIFT_VAL32(rn, 5);
>=20
>  	emit_insn(ctx, insn, check_reg(rn));
>  }
> @@ -669,22 +669,22 @@ emit_rev(struct a64_jit_ctx *ctx, uint8_t rd,
> int32_t imm)
>  	uint32_t insn;
>=20
>  	insn =3D 0xdac00000;
> -	insn |=3D rd << 5;
> +	insn |=3D RTE_SHIFT_VAL32(rd, 5);
>  	insn |=3D rd;
>=20
>  	switch (imm) {
>  	case 16:
> -		insn |=3D 1 << 10;
> +		insn |=3D RTE_SHIFT_VAL32(1, 10);
>  		emit_insn(ctx, insn, check_reg(rd));
>  		emit_zero_extend(ctx, rd, 16);
>  		break;
>  	case 32:
> -		insn |=3D 2 << 10;
> +		insn |=3D RTE_SHIFT_VAL32(2, 10);
>  		emit_insn(ctx, insn, check_reg(rd));
>  		/* Upper 32 bits already cleared */
>  		break;
>  	case 64:
> -		insn |=3D 3 << 10;
> +		insn |=3D RTE_SHIFT_VAL32(3, 10);
>  		emit_insn(ctx, insn, check_reg(rd));
>  		break;
>  	default:
> @@ -933,9 +933,9 @@ emit_cbnz(struct a64_jit_ctx *ctx, bool is64,
> uint8_t rt, int32_t imm19)
>  	uint32_t insn, imm;
>=20
>  	imm =3D mask_imm(19, imm19);
> -	insn =3D (!!is64) << 31;
> -	insn |=3D 0x35 << 24;
> -	insn |=3D imm << 5;
> +	insn =3D RTE_SHIFT_VAL32(is64, 31);
> +	insn |=3D RTE_SHIFT_VAL32(0x35, 24);
> +	insn |=3D RTE_SHIFT_VAL32(imm, 5);
>  	insn |=3D rt;
>=20
>  	emit_insn(ctx, insn, check_reg(rt) || check_imm(19, imm19));
> @@ -947,7 +947,7 @@ emit_b(struct a64_jit_ctx *ctx, int32_t imm26)
>  	uint32_t insn, imm;
>=20
>  	imm =3D mask_imm(26, imm26);
> -	insn =3D 0x5 << 26;
> +	insn =3D RTE_SHIFT_VAL32(0x5, 26);
>  	insn |=3D imm;
>=20
>  	emit_insn(ctx, insn, check_imm(26, imm26));
> @@ -971,9 +971,9 @@ emit_stadd(struct a64_jit_ctx *ctx, bool is64,
> uint8_t rs, uint8_t rn)
>  	uint32_t insn;
>=20
>  	insn =3D 0xb820001f;
> -	insn |=3D (!!is64) << 30;
> -	insn |=3D rs << 16;
> -	insn |=3D rn << 5;
> +	insn |=3D RTE_SHIFT_VAL32(is64, 30);
> +	insn |=3D RTE_SHIFT_VAL32(rs, 16);
> +	insn |=3D RTE_SHIFT_VAL32(rn, 5);
>=20
>  	emit_insn(ctx, insn, check_reg(rs) || check_reg(rn));
>  }
> @@ -984,8 +984,8 @@ emit_ldxr(struct a64_jit_ctx *ctx, bool is64,
> uint8_t rt, uint8_t rn)
>  	uint32_t insn;
>=20
>  	insn =3D 0x885f7c00;
> -	insn |=3D (!!is64) << 30;
> -	insn |=3D rn << 5;
> +	insn |=3D RTE_SHIFT_VAL32(is64, 30);
> +	insn |=3D RTE_SHIFT_VAL32(rn, 5);
>  	insn |=3D rt;
>=20
>  	emit_insn(ctx, insn, check_reg(rt) || check_reg(rn));
> @@ -998,9 +998,9 @@ emit_stxr(struct a64_jit_ctx *ctx, bool is64,
> uint8_t rs, uint8_t rt,
>  	uint32_t insn;
>=20
>  	insn =3D 0x88007c00;
> -	insn |=3D (!!is64) << 30;
> -	insn |=3D rs << 16;
> -	insn |=3D rn << 5;
> +	insn |=3D RTE_SHIFT_VAL32(is64, 30);
> +	insn |=3D RTE_SHIFT_VAL32(rs, 16);
> +	insn |=3D RTE_SHIFT_VAL32(rn, 5);
>  	insn |=3D rt;
>=20
>  	emit_insn(ctx, insn, check_reg(rs) || check_reg(rt) ||
> check_reg(rn));
> @@ -1051,9 +1051,9 @@ emit_cmp_tst(struct a64_jit_ctx *ctx, bool is64,
> uint8_t rn, uint8_t rm,
>  	uint32_t insn;
>=20
>  	insn =3D opc;
> -	insn |=3D (!!is64) << 31;
> -	insn |=3D rm << 16;
> -	insn |=3D rn << 5;
> +	insn |=3D RTE_SHIFT_VAL32(is64, 31);
> +	insn |=3D RTE_SHIFT_VAL32(rm, 16);
> +	insn |=3D RTE_SHIFT_VAL32(rn, 5);
>=20
>  	emit_insn(ctx, insn, check_reg(rn) || check_reg(rm));
>  }
> @@ -1076,8 +1076,8 @@ emit_b_cond(struct a64_jit_ctx *ctx, uint8_t
> cond, int32_t imm19)
>  	uint32_t insn, imm;
>=20
>  	imm =3D mask_imm(19, imm19);
> -	insn =3D 0x15 << 26;
> -	insn |=3D imm << 5;
> +	insn =3D RTE_SHIFT_VAL32(0x15, 26);
> +	insn |=3D RTE_SHIFT_VAL32(imm, 5);
>  	insn |=3D cond;
>=20
>  	emit_insn(ctx, insn, check_cond(cond) || check_imm(19, imm19));
> @@ -1301,7 +1301,7 @@ emit(struct a64_jit_ctx *ctx, struct rte_bpf
> *bpf)
>  			break;
>  		/* dst =3D imm64 */
>  		case (BPF_LD | BPF_IMM | EBPF_DW):
> -			u64 =3D ((uint64_t)ins[1].imm << 32) | (uint32_t)imm;
> +			u64 =3D RTE_SHIFT_VAL64(ins[1].imm, 32) |
> (uint32_t)imm;
>  			emit_mov_imm(ctx, 1, dst, u64);
>  			i++;
>  			break;
> --
> 2.43.0

With or without suggested changes,
Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

