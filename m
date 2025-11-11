Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C289CCFA18
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 06:25:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A0ECB4026D;
	Tue, 11 Nov 2025 07:25:53 +0100 (CET)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 by mails.dpdk.org (Postfix) with ESMTP id 07DA94026A
 for <dev@dpdk.org>; Tue, 11 Nov 2025 07:25:52 +0100 (CET)
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-4ed72cc09ddso20661491cf.2
 for <dev@dpdk.org>; Mon, 10 Nov 2025 22:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762842351; x=1763447151; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vfPBTTrcA+BDzvcha9SEk2VDxmUU7Vwm7OVPv64fDnk=;
 b=TBRHLNs/DM/siHbmgzHrPtnDcFNbgfuKh1sMtZ6z2NN2cJp+EbgZtwPb8ZFuCAehAs
 Tlh2ptPvWPvLA64eb3g9IQaPQQsQla446y5mje6j+eGWyGzTt8M0kjLcw560VGL7iBJm
 oKil6lGO39bIybIVHbNXYq+lezrx7Ou4fo17h4udcMJvoHrt3TKlJj+XuLMMVsV+3L1w
 ZzmNc76FzK9Wkbu6CFW3J4qhTbANwthROxkLVhk77Ix0VOPUqgSQGcD8H3W0en765Fo7
 CbLzgBchkgT1oAtXHkpF651kEM++TWcZ4CEHgGgp+lyTd9pZ0GYR6986A9cemF7e9gyQ
 wiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762842351; x=1763447151;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vfPBTTrcA+BDzvcha9SEk2VDxmUU7Vwm7OVPv64fDnk=;
 b=LuOluAvyfbWgdr35G+3ENtRlunnE77oCdudp/rj2DtAHDnijVvdcVVS+Ih611nbBZB
 EXJ34CLJ0j1GUfpXhioHKad+ij+Cjb+q5bCJdN2EW5MRky4W7gJdEySTp0jbYTou70/D
 aA4DmFx8YZ13JZDgUbUQtogbVlWlIGlsZMI3h4tMNDxqpuqztFlGuozZNmEZz9Rm2Qei
 uQGapzyD/OBXywYr6Zq1opmgeqtyZGrK8FzsYZS4AvCHIgBHP9LGs8F1HDbvuyb9qIBT
 HOWSQ35XAgGU87OcEqqm/aBqap5QmXOmkZJEEMLKiaGKWvLvkJ+T42REjMPaGzTaodDb
 X4dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbUvhIvSO+qoW6gdkqDrjiS47EDEDkoP1kc2ZXXyTPm15ntDpuCCZ4J9gTtNN1/EBJlxU=@dpdk.org
X-Gm-Message-State: AOJu0YxjJMWHqKVfhZn1HvAka5bdIEBcAbKDDgD7wpXY5CX1PaSZ0AgK
 HWYdBT0hllkgGgD3PPevWH/5AF2fNULdEVxY+UBq4/zv8HcvFl/RApFqAmZ96ccmuvPtKlS7b7d
 QRGrL+WUGCtFIl0aBRRL59/r0hdiYnxM=
X-Gm-Gg: ASbGncv98YPMAfK0HvCbM6XvVlj/IXrbxGqiQWWbsnNyWK1T8cDOhuisSk+AcRUvu9k
 8GSUoB9M6lMkTT816Mo+m2cJr9cFDrM8epMy8ZbXQeGCzUOkDVuaSE+h2NCVobuokDeO54XW4XE
 RLKgwij5vscVkwaK5SArXzOBWBUg89n+gu4PdIqmA674athpRf9UkPSMyG/3IFgNra6Y7bpMQrr
 57dDJbX0s/WnGLEjFsQLJnNQ3BoPJROYpFR6cJ5QNOStmSn6g2Kh2Xme6FHeJYq4EL70/o=
X-Google-Smtp-Source: AGHT+IFSLOt2T6yoqg2fhhSVTqeabvdLWqej7qOkj9ay78RmDsuA9MzGvKs3a3ZvP1uIsv7IPpXn985Vtuw9ilP9dfw=
X-Received: by 2002:a05:622a:1995:b0:4ed:7f5a:c6d8 with SMTP id
 d75a77b69052e-4eda4f7a99cmr151584951cf.41.1762842351052; Mon, 10 Nov 2025
 22:25:51 -0800 (PST)
MIME-Version: 1.0
References: <20251110153046.63518-1-marat.khalili@huawei.com>
 <20251110153046.63518-2-marat.khalili@huawei.com>
In-Reply-To: <20251110153046.63518-2-marat.khalili@huawei.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Tue, 11 Nov 2025 11:55:24 +0530
X-Gm-Features: AWmQ_bnfK8Xm06m_fkxke2XBDig0airja_C0jnVrYBXB8hoALcffj3wKsmvTCkg
Message-ID: <CALBAE1O2VtvLV06-4hPCb5qHsRzqDM1iWWOaRcPKu9L-NMu2qg@mail.gmail.com>
Subject: Re: [PATCH 1/3] bpf: fix signed shift overflows in ARM JIT
To: Marat Khalili <marat.khalili@huawei.com>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Nov 10, 2025 at 9:01=E2=80=AFPM Marat Khalili <marat.khalili@huawei=
.com> wrote:
>
> Left shifts of integer literals and bool values overwriting the sign bit
> were used multiple times in bpf_jit_arm64.c. E.g.:
>
>     insn =3D (!!is64) << 31;
>
> where is64 has type bool (double bang is a no-op here). The operand of
> left shift was promoted to type int, which when 32-bit wide cannot
> represent the result. Similarly literal integers have int type by
> default.  Sanitizer produced the following diagnostic during runtime
> (for various lines):
>
>     lib/bpf/bpf_jit_arm64.c:241:18: runtime error: left shift of 1 by 31
>     places cannot be represented in type 'int'

Wonder why none of the tests in app/test/test_bpf.c able to catch
this? The generated ARM opcode looks OK (otherwise tests wont pass).
Could you check what is missing in the app/test/test_bpf.c?

Also SHIFT_VAR32 needs goto common code.


>
> To fix the issue use RTE_BIT32 and similar macros instead.
>
> Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
> ---
>  lib/bpf/bpf_jit_arm64.c | 188 +++++++++++++++++++++++-----------------
>  1 file changed, 107 insertions(+), 81 deletions(-)
>
> diff --git a/lib/bpf/bpf_jit_arm64.c b/lib/bpf/bpf_jit_arm64.c
> index 96b8cd2e03..5f43db0170 100644
> --- a/lib/bpf/bpf_jit_arm64.c
> +++ b/lib/bpf/bpf_jit_arm64.c
> @@ -28,7 +28,33 @@
>  #define A64_ZR                 31
>
>  #define check_imm(n, val) (((val) >=3D 0) ? !!((val) >> (n)) : !!((~val)=
 >> (n)))
> -#define mask_imm(n, val) ((val) & ((1 << (n)) - 1))
> +#define mask_imm(n, val) ((val) & (RTE_BIT32(n) - 1))
> +
> +/**
> + * Get the uint32_t shifted value.
> + *
> + * Works similarly to RTE_SHIFT_VAL32 but accepts non-literal arguments.
> + * Performs identically to RTE_SHIFT_VAL32 with literal arguments.
> + *
> + * @param val
> + *   The value to be shifted, can be non-literal.
> + * @param nr
> + *   The shift number in range of 0 to (32 - width of val).
> + */
> +#define SHIFT_VAR32(val, nr) ((uint32_t)(val) << (nr))
> +
> +/**
> + * Get the uint64_t shifted value.
> + *
> + * Works similarly to RTE_SHIFT_VAL64 but accepts non-literal arguments.
> + * Performs identically to RTE_SHIFT_VAL64 with literal arguments.
> + *
> + * @param val
> + *   The value to be shifted, can be non-literal.
> + * @param nr
> + *   The shift number in range of 0 to (64 - width of val).
> + */
> +#define SHIFT_VAR64(val, nr) ((uint64_t)(val) << (nr))
>
>  struct ebpf_a64_map {
>         uint32_t off; /* eBPF to arm64 insn offset mapping for jump */
> @@ -238,12 +264,12 @@ emit_add_sub_imm(struct a64_jit_ctx *ctx, bool is64=
, bool sub, uint8_t rd,
>         uint32_t insn, imm;
>
>         imm =3D mask_imm(12, imm12);
> -       insn =3D (!!is64) << 31;
> -       insn |=3D (!!sub) << 30;
> +       insn =3D SHIFT_VAR32(is64, 31);
> +       insn |=3D SHIFT_VAR32(sub, 30);
>         insn |=3D 0x11000000;
>         insn |=3D rd;
> -       insn |=3D rn << 5;
> -       insn |=3D imm << 10;
> +       insn |=3D SHIFT_VAR32(rn, 5);
> +       insn |=3D SHIFT_VAR32(imm, 10);
>
>         emit_insn(ctx, insn,
>                   check_reg(rd) || check_reg(rn) || check_imm(12, imm12))=
;
> @@ -279,16 +305,16 @@ emit_ls_pair_64(struct a64_jit_ctx *ctx, uint8_t rt=
, uint8_t rt2, uint8_t rn,
>  {
>         uint32_t insn;
>
> -       insn =3D (!!load) << 22;
> -       insn |=3D (!!pre_index) << 24;
> +       insn =3D SHIFT_VAR32(load, 22);
> +       insn |=3D SHIFT_VAR32(pre_index, 24);
>         insn |=3D 0xa8800000;
>         insn |=3D rt;
> -       insn |=3D rn << 5;
> -       insn |=3D rt2 << 10;
> +       insn |=3D SHIFT_VAR32(rn, 5);
> +       insn |=3D SHIFT_VAR32(rt2, 10);
>         if (push)
> -               insn |=3D 0x7e << 15; /* 0x7e means -2 with imm7 */
> +               insn |=3D SHIFT_VAR32(0x7e, 15); /* 0x7e means -2 with im=
m7 */
>         else
> -               insn |=3D 0x2 << 15;
> +               insn |=3D SHIFT_VAR32(0x2, 15);
>
>         emit_insn(ctx, insn, check_reg(rn) || check_reg(rt) || check_reg(=
rt2));
>
> @@ -317,11 +343,11 @@ mov_imm(struct a64_jit_ctx *ctx, bool is64, uint8_t=
 rd, uint8_t type,
>  {
>         uint32_t insn;
>
> -       insn =3D (!!is64) << 31;
> -       insn |=3D type << 29;
> -       insn |=3D 0x25 << 23;
> -       insn |=3D (shift/16) << 21;
> -       insn |=3D imm16 << 5;
> +       insn =3D SHIFT_VAR32(is64, 31);
> +       insn |=3D SHIFT_VAR32(type, 29);
> +       insn |=3D SHIFT_VAR32(0x25, 23);
> +       insn |=3D SHIFT_VAR32(shift/16, 21);
> +       insn |=3D SHIFT_VAR32(imm16, 5);
>         insn |=3D rd;
>
>         emit_insn(ctx, insn, check_reg(rd) || check_mov_hw(is64, shift));
> @@ -334,7 +360,7 @@ emit_mov_imm32(struct a64_jit_ctx *ctx, bool is64, ui=
nt8_t rd, uint32_t val)
>         uint16_t lower =3D val & 0xffff;
>
>         /* Positive number */
> -       if ((val & 1UL << 31) =3D=3D 0) {
> +       if ((val & RTE_BIT32(31)) =3D=3D 0) {
>                 mov_imm(ctx, is64, rd, A64_MOVZ, lower, 0);
>                 if (upper)
>                         mov_imm(ctx, is64, rd, A64_MOVK, upper, 16);
> @@ -393,21 +419,21 @@ emit_ls(struct a64_jit_ctx *ctx, uint8_t sz, uint8_=
t rt, uint8_t rn, uint8_t rm,
>  {
>         uint32_t insn;
>
> -       insn =3D 0x1c1 << 21;
> +       insn =3D SHIFT_VAR32(0x1c1, 21);
>         if (load)
> -               insn |=3D 1 << 22;
> +               insn |=3D RTE_BIT32(22);
>         if (sz =3D=3D BPF_B)
> -               insn |=3D 0 << 30;
> +               insn |=3D SHIFT_VAR32(0, 30);
>         else if (sz =3D=3D BPF_H)
> -               insn |=3D 1 << 30;
> +               insn |=3D SHIFT_VAR32(1, 30);
>         else if (sz =3D=3D BPF_W)
> -               insn |=3D 2 << 30;
> +               insn |=3D SHIFT_VAR32(2, 30);
>         else if (sz =3D=3D EBPF_DW)
> -               insn |=3D 3 << 30;
> +               insn |=3D SHIFT_VAR32(3, 30);
>
> -       insn |=3D rm << 16;
> -       insn |=3D 0x1a << 10; /* LSL and S =3D 0 */
> -       insn |=3D rn << 5;
> +       insn |=3D SHIFT_VAR32(rm, 16);
> +       insn |=3D SHIFT_VAR32(0x1a, 10); /* LSL and S =3D 0 */
> +       insn |=3D SHIFT_VAR32(rn, 5);
>         insn |=3D rt;
>
>         emit_insn(ctx, insn, check_reg(rt) || check_reg(rn) || check_reg(=
rm) ||
> @@ -436,10 +462,10 @@ emit_add_sub(struct a64_jit_ctx *ctx, bool is64, ui=
nt8_t rd, uint8_t rn,
>  {
>         uint32_t insn;
>
> -       insn =3D (!!is64) << 31;
> -       insn |=3D op << 21; /* shift =3D=3D 0 */
> -       insn |=3D rm << 16;
> -       insn |=3D rn << 5;
> +       insn =3D SHIFT_VAR32(is64, 31);
> +       insn |=3D SHIFT_VAR32(op, 21); /* shift =3D=3D 0 */
> +       insn |=3D SHIFT_VAR32(rm, 16);
> +       insn |=3D SHIFT_VAR32(rn, 5);
>         insn |=3D rd;
>
>         emit_insn(ctx, insn, check_reg(rd) || check_reg(rm));
> @@ -468,11 +494,11 @@ emit_mul(struct a64_jit_ctx *ctx, bool is64, uint8_=
t rd, uint8_t rm)
>  {
>         uint32_t insn;
>
> -       insn =3D (!!is64) << 31;
> -       insn |=3D 0xd8 << 21;
> -       insn |=3D rm << 16;
> -       insn |=3D A64_ZR << 10;
> -       insn |=3D rd << 5;
> +       insn =3D SHIFT_VAR32(is64, 31);
> +       insn |=3D SHIFT_VAR32(0xd8, 21);
> +       insn |=3D SHIFT_VAR32(rm, 16);
> +       insn |=3D SHIFT_VAR32(A64_ZR, 10);
> +       insn |=3D SHIFT_VAR32(rd, 5);
>         insn |=3D rd;
>
>         emit_insn(ctx, insn, check_reg(rd) || check_reg(rm));
> @@ -489,11 +515,11 @@ emit_data_process_two_src(struct a64_jit_ctx *ctx, =
bool is64, uint8_t rd,
>  {
>         uint32_t insn;
>
> -       insn =3D (!!is64) << 31;
> -       insn |=3D 0xd6 << 21;
> -       insn |=3D rm << 16;
> -       insn |=3D op << 10;
> -       insn |=3D rn << 5;
> +       insn =3D SHIFT_VAR32(is64, 31);
> +       insn |=3D SHIFT_VAR32(0xd6, 21);
> +       insn |=3D SHIFT_VAR32(rm, 16);
> +       insn |=3D SHIFT_VAR32(op, 10);
> +       insn |=3D SHIFT_VAR32(rn, 5);
>         insn |=3D rd;
>
>         emit_insn(ctx, insn, check_reg(rd) || check_reg(rm));
> @@ -532,14 +558,14 @@ emit_bitfield(struct a64_jit_ctx *ctx, bool is64, u=
int8_t rd, uint8_t rn,
>  {
>         uint32_t insn;
>
> -       insn =3D (!!is64) << 31;
> +       insn =3D SHIFT_VAR32(is64, 31);
>         if (insn)
> -               insn |=3D 1 << 22; /* Set N bit when is64 is set */
> -       insn |=3D op << 29;
> -       insn |=3D 0x26 << 23;
> -       insn |=3D immr << 16;
> -       insn |=3D imms << 10;
> -       insn |=3D rn << 5;
> +               insn |=3D RTE_BIT32(22); /* Set N bit when is64 is set */
> +       insn |=3D SHIFT_VAR32(op, 29);
> +       insn |=3D SHIFT_VAR32(0x26, 23);
> +       insn |=3D SHIFT_VAR32(immr, 16);
> +       insn |=3D SHIFT_VAR32(imms, 10);
> +       insn |=3D SHIFT_VAR32(rn, 5);
>         insn |=3D rd;
>
>         emit_insn(ctx, insn, check_reg(rd) || check_reg(rn) ||
> @@ -578,11 +604,11 @@ emit_logical(struct a64_jit_ctx *ctx, bool is64, ui=
nt8_t rd,
>  {
>         uint32_t insn;
>
> -       insn =3D (!!is64) << 31;
> -       insn |=3D op << 29;
> -       insn |=3D 0x50 << 21;
> -       insn |=3D rm << 16;
> -       insn |=3D rd << 5;
> +       insn =3D SHIFT_VAR32(is64, 31);
> +       insn |=3D SHIFT_VAR32(op, 29);
> +       insn |=3D SHIFT_VAR32(0x50, 21);
> +       insn |=3D SHIFT_VAR32(rm, 16);
> +       insn |=3D SHIFT_VAR32(rd, 5);
>         insn |=3D rd;
>
>         emit_insn(ctx, insn, check_reg(rd) || check_reg(rm));
> @@ -612,12 +638,12 @@ emit_msub(struct a64_jit_ctx *ctx, bool is64, uint8=
_t rd, uint8_t rn,
>  {
>         uint32_t insn;
>
> -       insn =3D (!!is64) << 31;
> -       insn |=3D 0xd8 << 21;
> -       insn |=3D rm << 16;
> -       insn |=3D 0x1 << 15;
> -       insn |=3D ra << 10;
> -       insn |=3D rn << 5;
> +       insn =3D SHIFT_VAR32(is64, 31);
> +       insn |=3D SHIFT_VAR32(0xd8, 21);
> +       insn |=3D SHIFT_VAR32(rm, 16);
> +       insn |=3D SHIFT_VAR32(0x1, 15);
> +       insn |=3D SHIFT_VAR32(ra, 10);
> +       insn |=3D SHIFT_VAR32(rn, 5);
>         insn |=3D rd;
>
>         emit_insn(ctx, insn, check_reg(rd) || check_reg(rn) || check_reg(=
rm) ||
> @@ -638,7 +664,7 @@ emit_blr(struct a64_jit_ctx *ctx, uint8_t rn)
>         uint32_t insn;
>
>         insn =3D 0xd63f0000;
> -       insn |=3D rn << 5;
> +       insn |=3D SHIFT_VAR32(rn, 5);
>
>         emit_insn(ctx, insn, check_reg(rn));
>  }
> @@ -669,22 +695,22 @@ emit_rev(struct a64_jit_ctx *ctx, uint8_t rd, int32=
_t imm)
>         uint32_t insn;
>
>         insn =3D 0xdac00000;
> -       insn |=3D rd << 5;
> +       insn |=3D SHIFT_VAR32(rd, 5);
>         insn |=3D rd;
>
>         switch (imm) {
>         case 16:
> -               insn |=3D 1 << 10;
> +               insn |=3D SHIFT_VAR32(1, 10);
>                 emit_insn(ctx, insn, check_reg(rd));
>                 emit_zero_extend(ctx, rd, 16);
>                 break;
>         case 32:
> -               insn |=3D 2 << 10;
> +               insn |=3D SHIFT_VAR32(2, 10);
>                 emit_insn(ctx, insn, check_reg(rd));
>                 /* Upper 32 bits already cleared */
>                 break;
>         case 64:
> -               insn |=3D 3 << 10;
> +               insn |=3D SHIFT_VAR32(3, 10);
>                 emit_insn(ctx, insn, check_reg(rd));
>                 break;
>         default:
> @@ -933,9 +959,9 @@ emit_cbnz(struct a64_jit_ctx *ctx, bool is64, uint8_t=
 rt, int32_t imm19)
>         uint32_t insn, imm;
>
>         imm =3D mask_imm(19, imm19);
> -       insn =3D (!!is64) << 31;
> -       insn |=3D 0x35 << 24;
> -       insn |=3D imm << 5;
> +       insn =3D SHIFT_VAR32(is64, 31);
> +       insn |=3D SHIFT_VAR32(0x35, 24);
> +       insn |=3D SHIFT_VAR32(imm, 5);
>         insn |=3D rt;
>
>         emit_insn(ctx, insn, check_reg(rt) || check_imm(19, imm19));
> @@ -947,7 +973,7 @@ emit_b(struct a64_jit_ctx *ctx, int32_t imm26)
>         uint32_t insn, imm;
>
>         imm =3D mask_imm(26, imm26);
> -       insn =3D 0x5 << 26;
> +       insn =3D SHIFT_VAR32(0x5, 26);
>         insn |=3D imm;
>
>         emit_insn(ctx, insn, check_imm(26, imm26));
> @@ -971,9 +997,9 @@ emit_stadd(struct a64_jit_ctx *ctx, bool is64, uint8_=
t rs, uint8_t rn)
>         uint32_t insn;
>
>         insn =3D 0xb820001f;
> -       insn |=3D (!!is64) << 30;
> -       insn |=3D rs << 16;
> -       insn |=3D rn << 5;
> +       insn |=3D SHIFT_VAR32(is64, 30);
> +       insn |=3D SHIFT_VAR32(rs, 16);
> +       insn |=3D SHIFT_VAR32(rn, 5);
>
>         emit_insn(ctx, insn, check_reg(rs) || check_reg(rn));
>  }
> @@ -984,8 +1010,8 @@ emit_ldxr(struct a64_jit_ctx *ctx, bool is64, uint8_=
t rt, uint8_t rn)
>         uint32_t insn;
>
>         insn =3D 0x885f7c00;
> -       insn |=3D (!!is64) << 30;
> -       insn |=3D rn << 5;
> +       insn |=3D SHIFT_VAR32(is64, 30);
> +       insn |=3D SHIFT_VAR32(rn, 5);
>         insn |=3D rt;
>
>         emit_insn(ctx, insn, check_reg(rt) || check_reg(rn));
> @@ -998,9 +1024,9 @@ emit_stxr(struct a64_jit_ctx *ctx, bool is64, uint8_=
t rs, uint8_t rt,
>         uint32_t insn;
>
>         insn =3D 0x88007c00;
> -       insn |=3D (!!is64) << 30;
> -       insn |=3D rs << 16;
> -       insn |=3D rn << 5;
> +       insn |=3D SHIFT_VAR32(is64, 30);
> +       insn |=3D SHIFT_VAR32(rs, 16);
> +       insn |=3D SHIFT_VAR32(rn, 5);
>         insn |=3D rt;
>
>         emit_insn(ctx, insn, check_reg(rs) || check_reg(rt) || check_reg(=
rn));
> @@ -1051,9 +1077,9 @@ emit_cmp_tst(struct a64_jit_ctx *ctx, bool is64, ui=
nt8_t rn, uint8_t rm,
>         uint32_t insn;
>
>         insn =3D opc;
> -       insn |=3D (!!is64) << 31;
> -       insn |=3D rm << 16;
> -       insn |=3D rn << 5;
> +       insn |=3D SHIFT_VAR32(is64, 31);
> +       insn |=3D SHIFT_VAR32(rm, 16);
> +       insn |=3D SHIFT_VAR32(rn, 5);
>
>         emit_insn(ctx, insn, check_reg(rn) || check_reg(rm));
>  }
> @@ -1076,8 +1102,8 @@ emit_b_cond(struct a64_jit_ctx *ctx, uint8_t cond, =
int32_t imm19)
>         uint32_t insn, imm;
>
>         imm =3D mask_imm(19, imm19);
> -       insn =3D 0x15 << 26;
> -       insn |=3D imm << 5;
> +       insn =3D SHIFT_VAR32(0x15, 26);
> +       insn |=3D SHIFT_VAR32(imm, 5);
>         insn |=3D cond;
>
>         emit_insn(ctx, insn, check_cond(cond) || check_imm(19, imm19));
> @@ -1301,7 +1327,7 @@ emit(struct a64_jit_ctx *ctx, struct rte_bpf *bpf)
>                         break;
>                 /* dst =3D imm64 */
>                 case (BPF_LD | BPF_IMM | EBPF_DW):
> -                       u64 =3D ((uint64_t)ins[1].imm << 32) | (uint32_t)=
imm;
> +                       u64 =3D SHIFT_VAR64(ins[1].imm, 32) | (uint32_t)i=
mm;
>                         emit_mov_imm(ctx, 1, dst, u64);
>                         i++;
>                         break;
> --
> 2.43.0
>
