Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B8DEC01A0
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 08:15:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FF0540268;
	Mon, 23 Mar 2026 09:15:18 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id D79244025F
 for <dev@dpdk.org>; Mon, 23 Mar 2026 09:15:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774253716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L5a1TffpSXk2r6h5s5/OjFnlcNlXxXXYthxW8/SFwV4=;
 b=b8ECDPcs9E6kv3lpkSZBWyrKaPcAmLjmvAY1d33M7KarnoXX/zYsBpWfIltJOBPaeVUJoX
 Nbp8X1rxPMSU98dym0M0TxxeUc9BOU4y+D2dc2TJOC0A/6thKsmT8LM5bCZ64ukvzC3k/C
 qGt8gwzlUQidoZD6XJvpLVPbFwWMC9E=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-BRG6W8R2OhSXqFfrW6-ZYQ-1; Mon, 23 Mar 2026 04:15:14 -0400
X-MC-Unique: BRG6W8R2OhSXqFfrW6-ZYQ-1
X-Mimecast-MFC-AGG-ID: BRG6W8R2OhSXqFfrW6-ZYQ_1774253713
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5a124b5672aso4005362e87.2
 for <dev@dpdk.org>; Mon, 23 Mar 2026 01:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774253713; x=1774858513;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L5a1TffpSXk2r6h5s5/OjFnlcNlXxXXYthxW8/SFwV4=;
 b=YnSSrFZCoyvkmfoN2JvAMWf/79htjiTDSxNkHdA1S90ZZP55QrY+X/DBwXxPLl8run
 e4I/A3AskFGxG3Ikz7LbDzsuc/nxox2JL9RrQmLhC34w9mu5QM6ES9b8GMQIdq/Q2KPX
 kJp5Mty1DSiZzZssD17ywcDgVyb0RsruIJEj/MEMl8/68W88A9aHbpzHDM2gokZtVxzC
 OYTQFLXiy5wnG3dLuxynEz6WyOCLu4mtGVZd6dkuleys5a5GabNf3sZmyKJhVqT6vSc0
 QaaTVeHoFaURTMoUZqEftRtaYjx9nJljsT0PSF1qT1Oh5t1/sU4rQ43jwNinzgprWymN
 8iPA==
X-Gm-Message-State: AOJu0YxtKfxMo/gvTpZG3I6vLOCOT61L39K5dFJEPfvLFRGhxNASBCtr
 dwQxadh0YJk1lg8SHbqmZUGZnIGDirA2E/pZh/8sMKXmoR3LflMVNVpp5Db0HFRXnd/tMl1RXgs
 L6qDgw/Cis2sbSXf8Kz6OinIMQMWhuc7+xK+GUoHgjkb0lGT1Pd4vEob4AMhvQt+DAKqaF26ZL6
 pkJjcxUH54FF4s90jHxlBazOxp6zg=
X-Gm-Gg: ATEYQzytitk3XtX3qhoKqTKjrwsvMyIylmdfMJx/IAo3aE+x16PmZg7E2iaG0Qrq0aV
 3NvL7NCz70Ghj4FrDCvFLJZP730zlj425DRX5U3vC4b6f4lKJAND+uEfLuL+dBSrlrZMJIgPlhH
 LY3TmETb2HSiA3NUPJaOagsDqOpXbN/LFlGOzB5w688lRqI7S44ngXQTa1V/dSy7c0NfiYgSjHi
 P23DmNDDx/SA2wSn/QxxCv27Pfrv1UYV2QkRSKjQBI8gSCS59vhG5S/y5gTbupNpppO/yvzgczN
 59plPylm
X-Received: by 2002:a05:6512:1396:b0:5a1:49a0:af35 with SMTP id
 2adb3069b0e04-5a285af40e0mr3261471e87.10.1774253712811; 
 Mon, 23 Mar 2026 01:15:12 -0700 (PDT)
X-Received: by 2002:a05:6512:1396:b0:5a1:49a0:af35 with SMTP id
 2adb3069b0e04-5a285af40e0mr3261452e87.10.1774253712231; Mon, 23 Mar 2026
 01:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260310122045.4057836-1-cfontain@redhat.com>
 <20260319114500.9757-1-cfontain@redhat.com>
 <20260319114500.9757-3-cfontain@redhat.com>
In-Reply-To: <20260319114500.9757-3-cfontain@redhat.com>
From: Christophe Fontaine <cfontain@redhat.com>
Date: Mon, 23 Mar 2026 09:15:01 +0100
X-Gm-Features: AQROBzC7bnS4WQ1E_ID53aQ5PiNzbCeJkuwHd-dOinT8xe1mbfjGaoaoQgmIC5w
Message-ID: <CAHVr2N=DR9G8Wixv9sgov9Ks_DZkxbRHovn4ng0uME6GX8RboA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] bpf/arm64: support packet data load instructions
To: dev@dpdk.org
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>, 
 Wathsala Vithanage <wathsala.vithanage@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: k3pqWjV51a68jGDnnR5HRrEu-Bmks0rphZ8LDpfpNxc_1774253713
X-Mimecast-Originator: redhat.com
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

It seems my patch broke the CI on debian/ubuntu, but works on Fedora/Centos=
.
I was able to reproduce that with a container, and hope to provide a
v3 this week.

Sorry for that!
Christophe

On Thu, Mar 19, 2026 at 12:45=E2=80=AFPM Christophe Fontaine
<cfontain@redhat.com> wrote:
>
> arm64 jit compiler didn't support reading from a packet.
> Enable arm64 JIT to generate native code for
> (BPF_ABS | <size> | BPF_LD) and (BPF_IND | <size> | BPF_LD)
> instructions.
>
> Both 'fast path' and 'slow path' are implemented, similar to
> the x86_64 JIT, where we call '__rte_pktmbuf_read' if the
> requested data is not in the first segment.
>
> Added unit test which focuses only on BPF_LD | BPF_ABS/BPF_IND and
> a BPF_LD | BPF_ABS slow path call.
>
> Signed-off-by: Christophe Fontaine <cfontain@redhat.com>
> ---
>  app/test/test_bpf.c     | 121 ++++++++++++++++++++++++++++++++++++++++
>  lib/bpf/bpf_jit_arm64.c |  86 ++++++++++++++++++++++++++++
>  2 files changed, 207 insertions(+)
>
> diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
> index dd24722450..799f9d30ca 100644
> --- a/app/test/test_bpf.c
> +++ b/app/test/test_bpf.c
> @@ -2750,6 +2750,79 @@ static const struct rte_bpf_xsym test_call5_xsym[]=
 =3D {
>         },
>  };
>
> +/* load mbuf (BPF_ABS/BPF_IND) test-cases */
> +static const struct ebpf_insn test_ld_mbuf0_prog[] =3D {
> +       /* BPF_ABS/BPF_IND implicitly expect mbuf ptr in R6 */
> +       {
> +               .code =3D (EBPF_ALU64 | EBPF_MOV | BPF_X),
> +               .dst_reg =3D EBPF_REG_6,
> +               .src_reg =3D EBPF_REG_1,
> +       },
> +       /* load IPv4 version and IHL */
> +       {
> +               .code =3D (BPF_LD | BPF_ABS | BPF_B),
> +               .imm =3D offsetof(struct rte_ipv4_hdr, version_ihl),
> +       },
> +       {
> +               .code =3D (BPF_JMP | EBPF_EXIT),
> +       },
> +};
> +
> +/* load mbuf (BPF_ABS/BPF_IND) test-cases */
> +static const struct ebpf_insn test_ld_slow_mbuf0_prog[] =3D {
> +       /* BPF_ABS/BPF_IND implicitly expect mbuf ptr in R6 */
> +       {
> +               .code =3D (EBPF_ALU64 | EBPF_MOV | BPF_X),
> +               .dst_reg =3D EBPF_REG_6,
> +               .src_reg =3D EBPF_REG_1,
> +       },
> +       /* load from chained mbuf */
> +       {
> +               .code =3D (BPF_LD | BPF_ABS | BPF_B),
> +               /* 201: second mbuf, built by test_ld_mbuf1_prepare */
> +               .imm =3D 201 + 0x42,
> +       },
> +       {
> +               .code =3D (BPF_JMP | EBPF_EXIT),
> +       },
> +};
> +
> +static const struct ebpf_insn test_ld_ind_mbuf0_prog[] =3D {
> +       /* BPF_ABS/BPF_IND implicitly expect mbuf ptr in R6 */
> +       {
> +               .code =3D (EBPF_ALU64 | EBPF_MOV | BPF_X),
> +               .dst_reg =3D EBPF_REG_6,
> +               .src_reg =3D EBPF_REG_1,
> +       },
> +       {
> +               /* Set return value to one. */
> +               .code =3D (EBPF_ALU64 | EBPF_MOV | BPF_K),
> +               .dst_reg =3D EBPF_REG_0,
> +               .imm =3D 0,
> +       },
> +       /* load IPv4 version and IHL */
> +       {
> +               .code =3D (BPF_LD | BPF_IND | BPF_B),
> +               .src_reg =3D EBPF_REG_0,
> +               .imm =3D offsetof(struct rte_ipv4_hdr, version_ihl),
> +       },
> +       {
> +               .code =3D (BPF_JMP | EBPF_EXIT),
> +       },
> +};
> +
> +static int
> +test_ld_mbuf0_check(uint64_t rc, const void *arg)
> +{
> +       return cmp_res(__func__, 0x45, rc, arg, arg, 0);
> +}
> +
> +static int
> +test_ld_slow_mbuf0_check(uint64_t rc, const void *arg)
> +{
> +       return cmp_res(__func__, 0x42, rc, arg, arg, 0);
> +}
> +
>  /* load mbuf (BPF_ABS/BPF_IND) test-cases */
>  static const struct ebpf_insn test_ld_mbuf1_prog[] =3D {
>
> @@ -3417,6 +3490,54 @@ static const struct bpf_test tests[] =3D {
>                 /* for now don't support function calls on 32 bit platfor=
m */
>                 .allow_fail =3D (sizeof(uint64_t) !=3D sizeof(uintptr_t))=
,
>         },
> +       {
> +               .name =3D "test_ld_abs_mbuf0",
> +               .arg_sz =3D sizeof(struct dummy_mbuf),
> +               .prm =3D {
> +                       .ins =3D test_ld_mbuf0_prog,
> +                       .nb_ins =3D RTE_DIM(test_ld_mbuf0_prog),
> +                       .prog_arg =3D {
> +                               .type =3D RTE_BPF_ARG_PTR_MBUF,
> +                               .buf_size =3D sizeof(struct dummy_mbuf),
> +                       },
> +               },
> +               .prepare =3D test_ld_mbuf1_prepare,
> +               .check_result =3D test_ld_mbuf0_check,
> +               /* mbuf as input argument is not supported on 32 bit plat=
form */
> +               .allow_fail =3D (sizeof(uint64_t) !=3D sizeof(uintptr_t))=
,
> +       },
> +       {
> +               .name =3D "test_ld_slow_mbuf0",
> +               .arg_sz =3D sizeof(struct dummy_mbuf),
> +               .prm =3D {
> +                       .ins =3D test_ld_slow_mbuf0_prog,
> +                       .nb_ins =3D RTE_DIM(test_ld_slow_mbuf0_prog),
> +                       .prog_arg =3D {
> +                               .type =3D RTE_BPF_ARG_PTR_MBUF,
> +                               .buf_size =3D sizeof(struct dummy_mbuf),
> +                       },
> +               },
> +               .prepare =3D test_ld_mbuf1_prepare,
> +               .check_result =3D test_ld_slow_mbuf0_check,
> +               /* mbuf as input argument is not supported on 32 bit plat=
form */
> +               .allow_fail =3D (sizeof(uint64_t) !=3D sizeof(uintptr_t))=
,
> +       },
> +       {
> +               .name =3D "test_ld_ind_mbuf0",
> +               .arg_sz =3D sizeof(struct dummy_mbuf),
> +               .prm =3D {
> +                       .ins =3D test_ld_ind_mbuf0_prog,
> +                       .nb_ins =3D RTE_DIM(test_ld_ind_mbuf0_prog),
> +                       .prog_arg =3D {
> +                               .type =3D RTE_BPF_ARG_PTR_MBUF,
> +                               .buf_size =3D sizeof(struct dummy_mbuf),
> +                       },
> +               },
> +               .prepare =3D test_ld_mbuf1_prepare,
> +               .check_result =3D test_ld_mbuf0_check,
> +               /* mbuf as input argument is not supported on 32 bit plat=
form */
> +               .allow_fail =3D (sizeof(uint64_t) !=3D sizeof(uintptr_t))=
,
> +       },
>         {
>                 .name =3D "test_ld_mbuf1",
>                 .arg_sz =3D sizeof(struct dummy_mbuf),
> diff --git a/lib/bpf/bpf_jit_arm64.c b/lib/bpf/bpf_jit_arm64.c
> index 099822e9f1..5b3b80cb86 100644
> --- a/lib/bpf/bpf_jit_arm64.c
> +++ b/lib/bpf/bpf_jit_arm64.c
> @@ -8,6 +8,7 @@
>
>  #include <rte_common.h>
>  #include <rte_byteorder.h>
> +#include <rte_mbuf.h>
>
>  #include "bpf_impl.h"
>
> @@ -1123,6 +1124,75 @@ emit_branch(struct a64_jit_ctx *ctx, uint8_t op, u=
int32_t i, int16_t off)
>         emit_b_cond(ctx, ebpf_to_a64_cond(op), jump_offset_get(ctx, i, of=
f));
>  }
>
> +/*
> + * Emit code for BPF_LD | BPF_ABS/IND: load from packet.
> + * Implements both a fast path, which computes the offset and read direc=
tly
> + * and a slow path, which calls __rte_pktmbuf_read(mbuf, off, len, buf)
> + * when the data is not in the first segment.
> + */
> +static void
> +emit_ld_mbuf(struct a64_jit_ctx *ctx, uint32_t op, uint8_t tmp1, uint8_t=
 tmp2,
> +       uint8_t src, int32_t imm)
> +{
> +       uint8_t r0 =3D ebpf_to_a64_reg(ctx, EBPF_REG_0);
> +       uint8_t r6 =3D ebpf_to_a64_reg(ctx, EBPF_REG_6);
> +       uint32_t mode =3D BPF_MODE(op);
> +       uint32_t opsz =3D BPF_SIZE(op);
> +       uint32_t sz =3D bpf_size(opsz);
> +
> +       /* r0 =3D mbuf (R6) */
> +       emit_mov_64(ctx, A64_R(0), r6);
> +
> +       /* r1 =3D off: for ABS use imm, for IND use src + imm */
> +       if (mode =3D=3D BPF_ABS) {
> +               emit_mov_imm(ctx, 0, A64_R(1), imm);
> +       } else {
> +               emit_mov_imm(ctx, 0, tmp2, imm);
> +               emit_add(ctx, 0, tmp2, src);
> +               emit_mov_64(ctx, A64_R(1), tmp2);
> +       }
> +
> +       /* r2 =3D len, 1/2/4 bytes */
> +       emit_mov_imm32(ctx, 0, A64_R(2), sz);
> +       /* r3 =3D buf (SP) */
> +       emit_mov_64(ctx, A64_R(3), A64_SP);
> +
> +       /* tmp1 =3D mbuf->data_len */
> +       emit_mov_imm(ctx, 1, tmp1, offsetof(struct rte_mbuf, data_len));
> +       emit_ldr(ctx, BPF_W, tmp1, r6, tmp1);
> +
> +       /* tmp2 =3D off + sz */
> +       emit_add_imm_64(ctx, tmp2, A64_R(1), sz);
> +       /* if off+sz > data_len, jump to slow path */
> +       emit_cmp(ctx, 1, tmp2, tmp1);
> +       emit_b_cond(ctx, A64_HI, 8);
> +
> +       /* Fast path, read directly, pointer to the data will be in A64_R=
(0) */
> +       /* A64_R(0) =3D mbuf->buf_addr */
> +       emit_mov_imm(ctx, 1, tmp1, offsetof(struct rte_mbuf, buf_addr));
> +       emit_ldr(ctx, EBPF_DW, A64_R(0), r6, tmp1);
> +       /* tmp2 =3D * mbuf->data_off */
> +       emit_mov_imm(ctx, 1, tmp2, offsetof(struct rte_mbuf, data_off));
> +       emit_ldr(ctx, BPF_H, tmp2, r6, tmp2);
> +
> +       /* A64_R(0) +=3D data_off + off */
> +       emit_add(ctx, 1, A64_R(0), tmp2);
> +       emit_add(ctx, 1, A64_R(0), A64_R(1));
> +
> +       /* End of Fast Path, skip slow path */
> +       emit_b(ctx, 4);
> +
> +       /* slow path, call __rte_pktmbuf_read */
> +       emit_call(ctx, tmp1, __rte_pktmbuf_read);
> +       /* check return value of __rte_pktmbuf_read */
> +       emit_return_zero_if_src_zero(ctx, 1, A64_R(0));
> +
> +       /* A64_R(0) points to the data, load 1/2/4 bytes into r0*/
> +       emit_ldr(ctx, opsz, r0, A64_R(0), A64_ZR);
> +       if (sz !=3D sizeof(uint8_t))
> +               emit_be(ctx, r0, sz * CHAR_BIT);
> +}
> +
>  static void
>  check_program_has_call(struct a64_jit_ctx *ctx, struct rte_bpf *bpf)
>  {
> @@ -1137,6 +1207,13 @@ check_program_has_call(struct a64_jit_ctx *ctx, st=
ruct rte_bpf *bpf)
>                 switch (op) {
>                 /* Call imm */
>                 case (BPF_JMP | EBPF_CALL):
> +               /* BPF_LD | BPF_ABS/IND use __rte_pktmbuf_read */
> +               case (BPF_LD | BPF_ABS | BPF_B):
> +               case (BPF_LD | BPF_ABS | BPF_H):
> +               case (BPF_LD | BPF_ABS | BPF_W):
> +               case (BPF_LD | BPF_IND | BPF_B):
> +               case (BPF_LD | BPF_IND | BPF_H):
> +               case (BPF_LD | BPF_IND | BPF_W):
>                         ctx->foundcall =3D 1;
>                         return;
>                 }
> @@ -1338,6 +1415,15 @@ emit(struct a64_jit_ctx *ctx, struct rte_bpf *bpf)
>                         emit_mov_imm(ctx, 1, dst, u64);
>                         i++;
>                         break;
> +               /* load absolute/indirect from packet */
> +               case (BPF_LD | BPF_ABS | BPF_B):
> +               case (BPF_LD | BPF_ABS | BPF_H):
> +               case (BPF_LD | BPF_ABS | BPF_W):
> +               case (BPF_LD | BPF_IND | BPF_B):
> +               case (BPF_LD | BPF_IND | BPF_H):
> +               case (BPF_LD | BPF_IND | BPF_W):
> +                       emit_ld_mbuf(ctx, op, tmp1, tmp2, src, imm);
> +                       break;
>                 /* *(size *)(dst + off) =3D src */
>                 case (BPF_STX | BPF_MEM | BPF_B):
>                 case (BPF_STX | BPF_MEM | BPF_H):
> --
> 2.53.0
>

