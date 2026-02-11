Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA651EB597B
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 08:13:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0124D4042F;
	Wed, 11 Feb 2026 09:13:39 +0100 (CET)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by mails.dpdk.org (Postfix) with ESMTP id 223E94026A
 for <dev@dpdk.org>; Wed, 11 Feb 2026 09:13:37 +0100 (CET)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-8c70daf9c94so481478685a.0
 for <dev@dpdk.org>; Wed, 11 Feb 2026 00:13:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770797616; cv=none;
 d=google.com; s=arc-20240605;
 b=XCvmMIgiCdxS4MKVtFe6KgtDP9c93DlEyu7n4cO3mQhbn7IulsS1LSut3jwD1iczKI
 mg8DGGoR9dVGr13dr2bPcWcWgFbegQzI4kL6M2hKoYDmPRY3buqxmz8uAzgh5uM2nZiX
 PglzKxcQJvQbzasKLrBqyjbrrcPYvssoY420rImo5jh/xSeVWT4f7Ygy1exbMZB6yNlV
 VQhxoy5j6LawJgCNT4pa7GFLXbjiI2gT9wZkWR1Cq+pbtXZH53rkVBhIr45LJh1SM38k
 UUS7mBo8SwV4/YDdarBPy1PijYFKH4jBedkaphwMoor6/Xf1Z1AeCf/SsBZQOBNARJmJ
 Pj/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Su4vmLsYJ6lMALIn5rxnthEg/6JCrHPElaeWo7/VSYM=;
 fh=+njWWfKQP01zebiE6jUtkOVEYVB5zq//9vbXbytvplM=;
 b=M8A2l7m/zGyJCJwvrErSkCllO9f+WflniEf4ZyvDvS92lziaTH4WB6L5EkzMAtuWFg
 5zb3hKcR0WewSqm3g5mQRazlo7BaAN08enpy6UUu9SkDc2xcBTOFPYgpHrHkK2nXyaJ/
 iU7qtb3QSr9eSujUjVaZ+aZXw7CWBEO/oqJjMw4AgDPD6PKEiJ+xHGIdzPgPcTUJ8Uyu
 GIRqHG0IquiuwLhm0dWIxOz3DglnaWnvcX5S2TsjfcqyRXKNWkNBobMkMuyUgKEJQdyw
 ogIoq3ca/BO8eev71nRSNKHB6H1M/5fSwfxISKFl+1594dlUfVzUfs6yxPGoJh70KlRc
 F6RQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770797616; x=1771402416; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Su4vmLsYJ6lMALIn5rxnthEg/6JCrHPElaeWo7/VSYM=;
 b=mBG+dqDVI7fOa163XfWaYbH8Ru9ZLL+SohT79h9SY/Mz+SR5OxaJClRIbAvXrriGgA
 girfFFhjXXUhS88ZgHvKe5m0cF5J5t2aya3G7iwDUw0eJqhdtBGI/iMYfZWewRJOv2Dg
 CIywT1HiiwkVVU+NQLtDeCLzoo3lR1Gjk6brmHazFJfj0vBM8d4zwNzG9RwBwjYFgoZj
 ldUOhETELGES8S7strQuMRVnHKfrEUdXgw34k8ylwlLinCK7vFO4hP73QXRA5bdujNPF
 C+xqpcaEWziEunt4CpgzpEr+XnRV0xHOyX2HSYGnu3Z8p3iX1crfQPKivnKSICg0lkY8
 rZyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770797616; x=1771402416;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Su4vmLsYJ6lMALIn5rxnthEg/6JCrHPElaeWo7/VSYM=;
 b=kVQr5YpOB702F9FmPn4veInxcmd8IFzCIUi+b4j/JAJkNdLs9pVT8Sfcp+I447hYnI
 Katp8T/8luV9awl/qE1pQF/dNl467K5fsBjTJhgkqv+q+b2U7SvoDh3I2IE0ftxR7PHL
 pUywljETlbOzeO8sSYFTIecwJ+nBsCynNZf+Q4cZ3sPCpUpXGBtsQ4pK0qixVXS0w8nM
 6UaLT42Xrh3mGtnSIUISEldr66lKTY6iQfD3fqpwziIktc2ur7bZBECxIAVBRan/nbZg
 /hYb0Z3njnP5rCytMyUTH375eh4yobzld8QV6FBwEjmoSq9geb/utB+zcCoeKlO9jrc3
 HAbw==
X-Gm-Message-State: AOJu0Ywz9lSnfrJSIuKfJ4ANn0QReIxN4Gxa6LZz/SnkS9nucTDBlnRN
 pl3O+/1Zt69Bdmj1Uj3146KmZVzFRj2t/yWAekOOTJWKfWdHtsc6ZEKl3c1dRzbjqU9c4WlRoDe
 ZXEVnq9Zv9zIfkiuekGV41vLTwqxM4Ts=
X-Gm-Gg: AZuq6aLWIH3ntyDPRFQsbXIjNCStD6KJDbez/R8x+Pect8aqUdQJH3R0ZkHFvB36p6W
 UhO/TE9j/AgBVLWTILvQ5gUg2zzIvNvc0SB6RIw2KoABotK18cNUXmJ0w7B3E0rjAzIhaCEYCpU
 kBaj+DAoU4tYA+aGVqYUVI8F/JFlep+qFZ7ZTSy4tDUaz/5LohpSZGL4XFbvUwLCp1gC7xGRaM1
 xAvo77cH1hucSGk8YlQD2eDOsSxV+0HJ8D2wmkkCrJbTA3MTKo1J7kyWOb2LQxs2aMkk6dYFWdM
 xEM=
X-Received: by 2002:a05:622a:10b:b0:502:8fb7:77ff with SMTP id
 d75a77b69052e-5068121cd13mr27342641cf.47.1770797615345; Wed, 11 Feb 2026
 00:13:35 -0800 (PST)
MIME-Version: 1.0
References: <20260128060316.3967610-1-rbhansali@marvell.com>
 <20260128060316.3967610-18-rbhansali@marvell.com>
In-Reply-To: <20260128060316.3967610-18-rbhansali@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Wed, 11 Feb 2026 13:43:25 +0530
X-Gm-Features: AZwV_QjMyNC2xXl6OD3ldSKQhiq7S9-11-MMhQ5J0VCcLaKFkGa7fwSiGQxDNwk
Message-ID: <CALBAE1PV05kW4mgaEZ21PPttd-nwKjPV0k1ypwFd==THF-g-vA@mail.gmail.com>
Subject: Re: [PATCH 18/18] common/cnxk: fix duplicate branch compiler warning
To: Rahul Bhansali <rbhansali@marvell.com>
Cc: dev@dpdk.org, Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, 
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, 
 Archana Muniganti <marchana@marvell.com>, Akhil Goyal <gakhil@marvell.com>, 
 Anoob Joseph <anoobj@marvell.com>, Vidya Sagar Velumuri <vvelumuri@marvell.com>,
 jerinj@marvell.com
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

On Wed, Jan 28, 2026 at 11:44=E2=80=AFAM Rahul Bhansali <rbhansali@marvell.=
com> wrote:
>
> With compiler option '-Wduplicated-branches', getting few
> warnings such as "this condition has identical branches".
>
> Macros are updated to address these warnings.
>
> Bugzilla ID: 1811
> Fixes: 0d9e323bacf0 ("common/cnxk: support for CN20K inline IPsec")
> Fixes: c045d2e5cbbc ("common/cnxk: add CPT configuration")
>
> Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>

Please check AI the comments in
https://patches.dpdk.org/project/dpdk/patch/20260128060316.3967610-18-rbhan=
sali@marvell.com/

1)Please fix
Is it candidate for Cc: stable@dpdk.org backport?
        common/cnxk: fix engine capabilities fetch logic
        common/cnxk: fix CPT CQ roll over handling
        common/cnxk: fix duplicate branch compiler warning

2)Add new feature to release notes

3)Some of the changes are fixes: and mark the as fixes


> ---
>  drivers/common/cnxk/hw/rvu.h          |  2 ++
>  drivers/common/cnxk/roc_cpt.c         |  7 +++----
>  drivers/common/cnxk/roc_nix_inl.c     | 25 +++++++++----------------
>  drivers/common/cnxk/roc_nix_inl_dev.c |  6 +-----
>  drivers/common/cnxk/roc_nix_inl_dp.h  |  3 +++
>  drivers/common/cnxk/roc_nix_priv.h    |  4 ++--
>  6 files changed, 20 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/common/cnxk/hw/rvu.h b/drivers/common/cnxk/hw/rvu.h
> index ed2ba996e0..6f02d1e3d2 100644
> --- a/drivers/common/cnxk/hw/rvu.h
> +++ b/drivers/common/cnxk/hw/rvu.h
> @@ -105,6 +105,8 @@
>  #define RVU_VF_MBOX_REGION              (0xc0000ull) /* [CN10K, .) */
>  #define RVU_VF_MSIX_PBAX(a)             (0xf0000ull | (uint64_t)(a) << 3=
)
>
> +#define RVU_BLOCK_ADDRX_DISC(a) RVU_PF_BLOCK_ADDRX_DISC(a)
> +
>  /* CN20k RVU mbox registers */
>  #define RVU_MBOX_AF_AFPFX_TRIGX(a)    (0x9000 | (a) << 3)
>  #define RVU_MBOX_PF_PFAF_TRIGX(a)     RVU_PF_PFAF_MBOXX(a)
> diff --git a/drivers/common/cnxk/roc_cpt.c b/drivers/common/cnxk/roc_cpt.=
c
> index 63419884ac..13eb9d3767 100644
> --- a/drivers/common/cnxk/roc_cpt.c
> +++ b/drivers/common/cnxk/roc_cpt.c
> @@ -677,10 +677,9 @@ cpt_get_blkaddr(struct dev *dev)
>          * attached to. Assume CPT LF's of only one block are attached
>          * to a pffunc.
>          */
> -       if (dev_is_vf(dev))
> -               off =3D RVU_VF_BLOCK_ADDRX_DISC(RVU_BLOCK_ADDR_CPT1);
> -       else
> -               off =3D RVU_PF_BLOCK_ADDRX_DISC(RVU_BLOCK_ADDR_CPT1);
> +
> +       /* PF and VF block address offset is same, hence using common off=
set */
> +       off =3D RVU_BLOCK_ADDRX_DISC(RVU_BLOCK_ADDR_CPT1);
>
>         reg =3D plt_read64(dev->bar2 + off);
>
> diff --git a/drivers/common/cnxk/roc_nix_inl.c b/drivers/common/cnxk/roc_=
nix_inl.c
> index aad2631673..a21c40acf1 100644
> --- a/drivers/common/cnxk/roc_nix_inl.c
> +++ b/drivers/common/cnxk/roc_nix_inl.c
> @@ -19,6 +19,10 @@ PLT_STATIC_ASSERT(ROC_NIX_INL_OT_IPSEC_INB_SA_SZ =3D=
=3D
>  PLT_STATIC_ASSERT(ROC_NIX_INL_OT_IPSEC_INB_SA_SZ =3D=3D 1024);
>  PLT_STATIC_ASSERT(ROC_NIX_INL_OT_IPSEC_OUTB_SA_SZ =3D=3D
>                   1UL << ROC_NIX_INL_OT_IPSEC_OUTB_SA_SZ_LOG2);
> +PLT_STATIC_ASSERT(ROC_NIX_INL_OT_IPSEC_INB_SA_SZ =3D=3D ROC_NIX_INL_OW_I=
PSEC_INB_SA_SZ);
> +PLT_STATIC_ASSERT(ROC_NIX_INL_OT_IPSEC_INB_SA_SZ =3D=3D ROC_NIX_INL_ON_I=
PSEC_INB_SA_SZ);
> +PLT_STATIC_ASSERT(ROC_NIX_INL_OT_IPSEC_OUTB_SA_SZ =3D=3D ROC_NIX_INL_OW_=
IPSEC_OUTB_SA_SZ);
> +PLT_STATIC_ASSERT(ROC_NIX_INL_OT_IPSEC_OUTB_SA_SZ =3D=3D ROC_NIX_INL_ON_=
IPSEC_OUTB_SA_SZ);
>
>  static int
>  nix_inl_meta_aura_destroy(struct roc_nix *roc_nix)
> @@ -427,12 +431,8 @@ nix_inl_inb_ipsec_sa_tbl_setup(struct roc_nix *roc_n=
ix)
>         /* CN9K SA size is different */
>         if (roc_nix->custom_inb_sa)
>                 inb_sa_sz =3D ROC_NIX_INL_INB_CUSTOM_SA_SZ;
> -       else if (roc_model_is_cn9k())
> -               inb_sa_sz =3D ROC_NIX_INL_ON_IPSEC_INB_SA_SZ;
> -       else if (roc_model_is_cn10k())
> -               inb_sa_sz =3D ROC_NIX_INL_OT_IPSEC_INB_SA_SZ;
>         else
> -               inb_sa_sz =3D ROC_NIX_INL_OW_IPSEC_INB_SA_SZ;
> +               inb_sa_sz =3D ROC_NIX_INL_IPSEC_INB_SA_SZ;
>
>         /* Alloc contiguous memory for Inbound SA's */
>         nix->inb_sa_sz[profile_id] =3D inb_sa_sz;
> @@ -1198,10 +1198,9 @@ nix_inl_eng_caps_get(struct nix *nix)
>         inst.rptr =3D (uint64_t)rptr;
>         inst.w4.s.opcode_major =3D ROC_LOADFVC_MAJOR_OP;
>         inst.w4.s.opcode_minor =3D ROC_LOADFVC_MINOR_OP;
> -       if (roc_model_is_cn9k() || roc_model_is_cn10k())
> -               inst.w7.s.egrp =3D ROC_LEGACY_CPT_DFLT_ENG_GRP_SE;
> -       else
> -               inst.w7.s.egrp =3D ROC_CPT_DFLT_ENG_GRP_SE;
> +
> +       /* SE engine group ID is same for all platform */
> +       inst.w7.s.egrp =3D ROC_CPT_DFLT_ENG_GRP_SE;
>
>         /* Use 1 min timeout for the poll */
>         const uint64_t timeout =3D plt_tsc_cycles() + 60 * plt_tsc_hz();
> @@ -1614,13 +1613,7 @@ roc_nix_inl_outb_init(struct roc_nix *roc_nix)
>         if (!roc_nix->ipsec_out_max_sa)
>                 goto skip_sa_alloc;
>
> -       /* CN9K SA size is different */
> -       if (roc_model_is_cn9k())
> -               sa_sz =3D ROC_NIX_INL_ON_IPSEC_OUTB_SA_SZ;
> -       else if (roc_model_is_cn10k())
> -               sa_sz =3D ROC_NIX_INL_OT_IPSEC_OUTB_SA_SZ;
> -       else
> -               sa_sz =3D ROC_NIX_INL_OW_IPSEC_OUTB_SA_SZ;
> +       sa_sz =3D ROC_NIX_INL_IPSEC_OUTB_SA_SZ;
>
>         /* Alloc contiguous memory of outbound SA */
>         sa_base =3D plt_zmalloc(sa_sz * roc_nix->ipsec_out_max_sa,
> diff --git a/drivers/common/cnxk/roc_nix_inl_dev.c b/drivers/common/cnxk/=
roc_nix_inl_dev.c
> index fcbe9314a1..8414b9edc6 100644
> --- a/drivers/common/cnxk/roc_nix_inl_dev.c
> +++ b/drivers/common/cnxk/roc_nix_inl_dev.c
> @@ -837,12 +837,8 @@ nix_inl_nix_setup(struct nix_inl_dev *inl_dev)
>         /* CN9K SA is different */
>         if (inl_dev->custom_inb_sa)
>                 inb_sa_sz =3D ROC_NIX_INL_INB_CUSTOM_SA_SZ;
> -       else if (roc_model_is_cn9k())
> -               inb_sa_sz =3D ROC_NIX_INL_ON_IPSEC_INB_SA_SZ;
> -       else if (roc_model_is_cn10k())
> -               inb_sa_sz =3D ROC_NIX_INL_OT_IPSEC_INB_SA_SZ;
>         else
> -               inb_sa_sz =3D ROC_NIX_INL_OW_IPSEC_INB_SA_SZ;
> +               inb_sa_sz =3D ROC_NIX_INL_OT_IPSEC_INB_SA_SZ;
>
>         /* Alloc contiguous memory for Inbound SA's */
>         inl_dev->inb_sa_sz[profile_id] =3D inb_sa_sz;
> diff --git a/drivers/common/cnxk/roc_nix_inl_dp.h b/drivers/common/cnxk/r=
oc_nix_inl_dp.h
> index eb101db179..6443770871 100644
> --- a/drivers/common/cnxk/roc_nix_inl_dp.h
> +++ b/drivers/common/cnxk/roc_nix_inl_dp.h
> @@ -41,6 +41,9 @@
>         (ROC_NIX_INL_OW_IPSEC_OUTB_HW_SZ + ROC_NIX_INL_OW_IPSEC_OUTB_SW_R=
SVD)
>  #define ROC_NIX_INL_OW_IPSEC_OUTB_SA_SZ_LOG2 9
>
> +#define ROC_NIX_INL_IPSEC_INB_SA_SZ  ROC_NIX_INL_OT_IPSEC_INB_SA_SZ
> +#define ROC_NIX_INL_IPSEC_OUTB_SA_SZ ROC_NIX_INL_OT_IPSEC_OUTB_SA_SZ
> +
>  /* Alignment of SA Base */
>  #define ROC_NIX_INL_SA_BASE_ALIGN BIT_ULL(16)
>
> diff --git a/drivers/common/cnxk/roc_nix_priv.h b/drivers/common/cnxk/roc=
_nix_priv.h
> index 308a62a70e..d4b3c7c1af 100644
> --- a/drivers/common/cnxk/roc_nix_priv.h
> +++ b/drivers/common/cnxk/roc_nix_priv.h
> @@ -23,10 +23,10 @@
>  #define NIX_CQ_SEC_THRESH_LEVEL_REF1   (20 * 256 / 100)
>  #define NIX_CQ_BP_THRESH_LEVEL_REF1    (60 * 256 / 100)
>  #define NIX_CQ_SEC_BP_THRESH_LEVEL_REF1 (50 * 256 / 100)
> -#define NIX_CQ_LBP_THRESH_FRAC_REF1    (80 * 16 / 100)
> +#define NIX_CQ_LBP_THRESH_FRAC_REF1    (80 * 16 / 100.0)
>
>  /* Apply LBP at 75% of actual BP */
> -#define NIX_CQ_LBP_THRESH_FRAC (75 * 16 / 100)
> +#define NIX_CQ_LBP_THRESH_FRAC (75 * 16 / 100.0)
>  #define NIX_CQ_FULL_ERRATA_SKID (1024ull * 256)
>  #define NIX_RQ_AURA_BP_THRESH(percent, limit, shift) ((((limit) * (perce=
nt)) / 100) >> (shift))
>
> --
> 2.34.1
>
