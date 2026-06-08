Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE9DCD8C9D
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 16:27:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3600D402DD;
	Mon,  8 Jun 2026 18:27:23 +0200 (CEST)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
 [209.85.160.170])
 by mails.dpdk.org (Postfix) with ESMTP id E11D04029D
 for <dev@dpdk.org>; Mon,  8 Jun 2026 18:27:21 +0200 (CEST)
Received: by mail-qt1-f170.google.com with SMTP id
 d75a77b69052e-5176bbb9384so46190731cf.1
 for <dev@dpdk.org>; Mon, 08 Jun 2026 09:27:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780936040; cv=none;
 d=google.com; s=arc-20240605;
 b=PJ2bROu9RG0le4eXkgOSttHtuARt4JqWiMBuQ45uEt8swKORr45zp5PCAWWg2gSfow
 1DarZyUXvTzrSAT2MbaBvSO3jLrbjgzZhCWy0cehaqCcovly96U8FnYV4+rZppnQc8mI
 PzW7hL2ouVFgFZWTFeqHQX7IWQ9AHDFU5O8TktjCzjWaQRp7nR82Mki1bCrGDMRVlVQ6
 CNCKrEOV130d54BTb25t0G0F1SbVI2asLEeUhdLON+tt+av8SqIlMFmbrrghSa+csutE
 +4ua4K7qwq0sTWTbfttn+VNfh4oEpJRtL6Nbpu/Y/SQLpeHcZ8L4kcuybgyxm71oMgo3
 xH+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vnQjeQmNXYSVTp14z/A3IX9628okuFRfsxSxy21UxYk=;
 fh=6IW7+orrxRLeGMWHepYNvHBtu/+mxXppn1WugRTrmJQ=;
 b=Vw48mp3YKMmUiOJ106lWmsE6+Dza/oOToz8If3h2Beh0uW4k/vTtbS7m3YHq01qv1T
 RbtfCXTNhPmKrVw3QVB/FaXCqqr/1x6uiD7XRv5qiDVtp8mqqPk0tNV0Xotz4cjL6Uue
 54LDSHX9oeh63ghkXjMSARN1j6FXPBj9YhaCQdvWgKjsNHtKidsZuOlNDwbLxitKGc9E
 hvtiA/cjIdH5/SsJ2OBYby/merbB/WGIJ7SqWUCpHikWAUnqugdqRsb5DMiZXh4CIX05
 cf3mDii9DvGJN6MxoJsRBi20QUqrDj3mzwvQ2PZJJb6pnWcZL0wsesDWCldlXua5sYJJ
 Mngg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780936040; x=1781540840; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vnQjeQmNXYSVTp14z/A3IX9628okuFRfsxSxy21UxYk=;
 b=Tkcox2QHj7qsr2IQ5KbNi8Gc2wnpgM9oPXV0JcVdlP/X1chjho7PuPn6CteDDWW8Hw
 o1icm5I54dHMWTsy9qd2a5ENRakabhKxcWKLJmw107Q+Uae9h6G2nLDnzcQIHILSLxfF
 HytS01zZz5/efY3kyXYirnn5KLUL9flaqxgB5+QSfff3pJoWZo4NSpJj1yqYyogfYQAp
 RMqEnQ69SJ5J0oiN+OYFfUUc9ulbSqxZjKK4BFPxFb3U51g0gcBYeRGNQbjiPUhF8dXN
 iF4IXo5tfkY8s7MekhH7CQMIQvFKI8u+Ww96S7Z+ah+pKmnAaEPUAS99VmBeqmZa9cXP
 B+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780936040; x=1781540840;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vnQjeQmNXYSVTp14z/A3IX9628okuFRfsxSxy21UxYk=;
 b=Hss9U0+Ne3PcRgKel3WyxWbfFpd73RgHBS8oRMZt1EJnRJAcd5cDo74ZWJ0pckReaQ
 ug8MPWTV3QETIyG3HCDT1HlA6L8qr66UvxLrXWixfPl/0W81vkYbrC0heWUUXyZTYM2J
 ahERlErevz8IsTMwMAnLJprDYYc/6YTrj3hIWKfjWZ+Rnqp49GOOtbBfwlf2xCrMYu8C
 4tGQV65SFt4Hu+1H2shkf3aSeuXDmU6k2wGkaoxFz1+ORvHeJb60gqVYRGJiwekgN/0Z
 aiL+c1+sCUF02jDKIrOq2onqXjrOaMsyDBSKSSPNb5V7LuF1RJ5f6RwXgjJBs5SWkhoA
 WC5Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/chP0a0I70oPTmoHpNjk8HPWVFLx1XGm18r+0dXzY+15zHfjV7K+aXrxSWTE6l3AhS6HY=@dpdk.org
X-Gm-Message-State: AOJu0Yx7P7kCgbQiH3scCqN7lbkZSVbIDmE7qffnxxU3gS2qCmWT900+
 E6/YqDcTcNvjIdqSPlUIwpQyZ2Y2i/GMlVBG3t/aMDQRlGbcPJwi6PV72xLsVJPOoC3wNShQk1J
 3U2RPhd2dbmcUraSe1kqhL+vodvareMQ=
X-Gm-Gg: Acq92OENanPhRQNlekSevCuC3amZR9uNBXFYsAb8jKZcVogyvWACeYWweAcYNFRRWeX
 b3LzO1McxVhE1embaBBnGzTJyEn+PAOgj6AY2qkwZR2t1w9YNDsbwcyhS0b2E4iQDJIAVGAGPBm
 9iDXckNJoTUl6WF6VkOc5elHSuNCOO6oEWFVEzWVurgUH0g63EwhUc7hYvvWzdI6dCDrFza42Dm
 2d/I6szTQ8eyzKzVFYCF3mqMZPPUZUkDQ1vIrEW4R+NvF0taMv35/RALqdTecxNSlE3adhJU+7S
 l73GsWfaPQQ74g==
X-Received: by 2002:ac8:6109:0:b0:517:8a19:a461 with SMTP id
 d75a77b69052e-51795c56d21mr217559111cf.42.1780936040055; Mon, 08 Jun 2026
 09:27:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260601101559.1925302-1-sthotton@marvell.com>
 <20260601101559.1925302-3-sthotton@marvell.com>
In-Reply-To: <20260601101559.1925302-3-sthotton@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Mon, 8 Jun 2026 21:56:54 +0530
X-Gm-Features: AVVi8CcefSCKRoNsdvu58xPYD5jsJuMHQkDOpzyJf4BAZamBgU1cS_XzDqW5FUo
Message-ID: <CALBAE1NB5fKw-=o_iu7CHhR4Hq6T5ekHYABRFDmLar7bT=ms4Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] dma/odm: avoid zero length DMA transfers
To: Shijith Thotton <sthotton@marvell.com>
Cc: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>,
 Vidya Sagar Velumuri <vvelumuri@marvell.com>, dev@dpdk.org
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

On Mon, Jun 1, 2026 at 3:46=E2=80=AFPM Shijith Thotton <sthotton@marvell.co=
m> wrote:
>
> Add validation to reject zero-length DMA operations early
> with -EINVAL, preventing queue disable.
>
> Signed-off-by: Shijith Thotton <sthotton@marvell.com>


Added Fixes to 2/2 patch.

Series applied to dpdk-next-net-mrvl/for-main. Thanks



> ---
>  drivers/dma/odm/odm_dmadev.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/dma/odm/odm_dmadev.c b/drivers/dma/odm/odm_dmadev.c
> index 0211133bd4..7488b960fd 100644
> --- a/drivers/dma/odm/odm_dmadev.c
> +++ b/drivers/dma/odm/odm_dmadev.c
> @@ -110,6 +110,9 @@ odm_dmadev_copy(void *dev_private, uint16_t vchan, rt=
e_iova_t src, rte_iova_t ds
>         vq =3D &odm->vq[vchan];
>         hdr.s.xtype =3D vq->xtype;
>
> +       if (unlikely(!length))
> +               return -EINVAL;
> +
>         h =3D length;
>         h |=3D ((uint64_t)length << 32);
>
> @@ -262,14 +265,20 @@ odm_dmadev_copy_sg(void *dev_private, uint16_t vcha=
n, const struct rte_dma_sge *
>         pending_submit_len =3D vq->pending_submit_len;
>         pending_submit_cnt =3D vq->pending_submit_cnt;
>
> -       if (unlikely(nb_src > 4 || nb_dst > 4))
> +       if (unlikely(!nb_src || nb_src > 4 || !nb_dst || nb_dst > 4))
>                 return -EINVAL;
>
> -       for (i =3D 0; i < nb_src; i++)
> +       for (i =3D 0; i < nb_src; i++) {
> +               if (unlikely(!src[i].length))
> +                       return -EINVAL;
>                 s_sz +=3D src[i].length;
> +       }
>
> -       for (i =3D 0; i < nb_dst; i++)
> +       for (i =3D 0; i < nb_dst; i++) {
> +               if (unlikely(!dst[i].length))
> +                       return -EINVAL;
>                 d_sz +=3D dst[i].length;
> +       }
>
>         if (s_sz !=3D d_sz)
>                 return -EINVAL;
> @@ -342,6 +351,9 @@ odm_dmadev_fill(void *dev_private, uint16_t vchan, ui=
nt64_t pattern, rte_iova_t
>                 .s.nlst =3D 1,
>         };
>
> +       if (unlikely(!length))
> +               return -EINVAL;
> +
>         h =3D (uint64_t)length;
>
>         switch (pattern) {
> --
> 2.25.1
>
