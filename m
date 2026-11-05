Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EA36082BFD
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 15:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TIJ+qAdm
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3FCA34060F;
	Thu,  5 Nov 2026 16:47:32 +0100 (CET)
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com
 [74.125.224.47])
 by mails.dpdk.org (Postfix) with ESMTPS id 37A10402DB
 for <dev@dpdk.org>; Thu,  5 Nov 2026 16:47:31 +0100 (CET)
Received: by mail-yx1-f47.google.com with SMTP id
 956f58d0204a3-67c0ffaae1dso282376d50.1
 for <dev@dpdk.org>; Thu, 05 Nov 2026 07:47:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793893650; cv=none;
 d=google.com; s=arc-20260327;
 b=eFo6GaG7y/x6t65ntfPTBL3kkYOn8WfSZ0iinukCjgqCKdI3IQN9xIrDOAMNBnn3WY
 NwRzZJvUx6L1muhlABG/G/WcMnCaxjKfKhyA1q2NXBZ/AK0BJoDDYzA2J/cx+yO70ggl
 USm23eq+hrbpqrOBcTiRCtWczSoez6iBxl2THKD0vw0QdQ10F8TKXz+JDGAV037c+q5E
 pSHTR+GTVqTouajB1X7L20Dk5F19k7/Cl7SQfXw1O2msDQt7rWAZG1Fpz7Ti2a2L4Jac
 Ens2C7tRLTHQEbY8JUtbVdOtaV2BY2ZNiFE9yvnNnGlK1eYo3wI9TnK98zMYtCPYnV/v
 ZX5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5CIXsYvPTWnZJeS2gpTRzeTN6UhssMetaTq3XA5gIao=;
 fh=oBzMBBXUrXJu8DCdXy429mcmyPngsflSehz1sgIePJU=;
 b=lOfoaL7DugCeZKk3V1vpEEgTTLNEu/BiDZv3wr2dNi09dMgwRcbbV3CD8N7pmPbXhL
 J4lL2gYI75C77L/4D0fS+UMSf/45+V88CBqCd3MYXu7q2iy6tzsTD5A56qWVOlD7uZRO
 Zqtt/6hj31dyZIwOaZea8eFJa7ims4YzFm07vQj69ejmUnv3PzQn7//+m/RHO+xnjkwY
 8kpnz73mxG6yzH9+wQduBO95pb9cWox34OvEAQ0ByIKeI2uby+wL4KnZn4Kbl9ezr0QC
 AF+ikXFC/GdwJGrKFP2WXSRX9HYKW+K4EJAzBXVowwhcudVSR4gvgzSIuOzU3rfm5D67
 0LrQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793893650; x=1794498450; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5CIXsYvPTWnZJeS2gpTRzeTN6UhssMetaTq3XA5gIao=;
 b=TIJ+qAdmJ2VfqIlHImGmVu5DVxc7VGw9k/BrphIrLBjYn37ksx5UNXoS/BS9CbOQoq
 pAn/qiX4YqtHJGFINKAFlyCfVThMATxMD5IbCLoKjf7XYDQbCFDfnb5U062+HPD9Tvw9
 sO9txO3J3Gj/aI8bFAjchCeElXbGfN9jFtO01q8a4QYcCJ0A6q2xnVcskw/Jfnye37KC
 0MiQ+svaJdVmRqzwOaXE9+7cHmXARsPBPlry+Qs/GJlH3n7gbBX1RmMaZ4EYV+3W6wcF
 iHRrFWMDqwAOLdZXn1M4t19rdjd5uzh1w89WWT7thr3HRAflhslxoHNnkqcQJXVD/BE+
 rI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793893650; x=1794498450;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5CIXsYvPTWnZJeS2gpTRzeTN6UhssMetaTq3XA5gIao=;
 b=vP3k4pi3nR40AlbrnwmZgYDjS1GUG+LQFTBOuqNWvcg+cKIb4Li20ZAnj1fuVnVgd8
 Vm9BxS2y2IVXofMPglv9Nmjz5+oUMjLs2vHeJdwRCTLQZ5Xlgq/BFbmc/Xkzz3WL4X9a
 SFHdRCxUe0mOUR94Eq+WUq38KnHSkvUCHE6uHcKJQgdv4T/kfZbmnPtpQLadbcEdiAL1
 /lP2fcZlLIcbKSmnUd+Iqi3oWSDMUVNazVKdvhUL4KE8rS9TOjmYQQng9yqORZKET/SD
 ZW8JljKBSgHtsWaiQMuGmGeM9B3sl4CMe9ZpAQQcyYG/pBBYi+u5Jw/fvzxnH+gGuNXI
 wACQ==
X-Gm-Message-State: APuU4Z/HbPdyuyDWgZDsEUrmMdS9EK0PVXGWZN60iInXPl2j9vMljUjR
 /5B3eFRaz1Vmq2d0vKfnmY1C9jFFdGqAe6W3OJFW52BhwVghcgfnid+jp7OPnbZygwYpCMfMutZ
 NqThv1sb+wYtv3wYN3jTr5Mdm+nWj2Kg=
X-Gm-Gg: AYBFou2FslPuihzBYNr2xJp+g5sTcv/aq6JrIe44BW210pI0tOHf5eKUk31ar9I16fZ
 k0cs3WDT4zV+8d0FMgJv4V9SPgHj1qGPM2foezfV3h1kdyMpKxUnYzDioxsrA2QX5SZO+6cO+a6
 kKpa4t3TWFGdk2zKsQpRxDeyZHuRt7/KAzw78O5jO0zmf5jtZIkSLsMa7TYMiUrMQ8TROr88lWW
 IUYgprqVJL6M4aJJCLQ7+KwgRqLjqRsCN+za/TJYkUVZKQfr1DNIRQbYOiHz2M0Jelb+uAXg8MN
 6sNy792d0jlnI2dhmvMj0usLkiixHPKsB7NK6AXcCIVBPRqLPUdvlADvR6KcR+ETYHgG+ZBeZcI
 t+Qomb6dQCmBumg8lEQ5vM+TldVcIPB0U5QNGu955btp0SYRx0l+RZJKul8pnSJDDT3W6grZ4JL
 8Vp3hPUd+pFaE5BiTCuxixlFuc8BYvUs8CPRebVY/yGoYwKeook5qf2IhA1Y2U+N1QPZeNCNr1D
 w==
X-Received: by 2002:a05:690e:43c5:b0:677:d05a:4800 with SMTP id
 956f58d0204a3-67c035f1b96mr978232d50.25.1793893649762; Thu, 05 Nov 2026
 07:47:29 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030091700.1237155-1-nkishor@marvell.com>
 <20261030091700.1237155-2-nkishor@marvell.com>
In-Reply-To: <20261030091700.1237155-2-nkishor@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Thu, 5 Nov 2026 21:17:03 +0530
X-Gm-Features: AclHuK_SHf-uY_gIDPSWhaethi-NshraPbBpQVL3qunlxBu3delZIMd_25d0keA
Message-ID: <CALBAE1PEAAeY0bsa3Sszn4EHioQ45BKf9nmg9uE5p_KbZaEJWQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] common/cnxk: fix DPC double counting for legacy pools
To: Nawal Kishor <nkishor@marvell.com>
Cc: dev@dpdk.org, Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, 
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 jerinj@marvell.com, asekhar@marvell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 3:43=E2=80=AFPM Nawal Kishor <nkishor@marvell.com> =
wrote:
>
> For legacy (non-halo) pools, DPC was enabled on both the pool and the
> aura contexts, so each operation was counted twice.
>
> Enable and disable DPC only on the aura context.
>
> Fixes: 28d65f12ac77 ("common/cnxk: add NPA diagnostic counter")
>
> Signed-off-by: Nawal Kishor <nkishor@marvell.com>

Series applied to dpdk-next-net-mrvl/for-main. Thanks

> ---
>  drivers/common/cnxk/roc_npa.c | 70 +++++------------------------------
>  1 file changed, 10 insertions(+), 60 deletions(-)
>
> diff --git a/drivers/common/cnxk/roc_npa.c b/drivers/common/cnxk/roc_npa.=
c
> index ebeebf1205..484fe47465 100644
> --- a/drivers/common/cnxk/roc_npa.c
> +++ b/drivers/common/cnxk/roc_npa.c
> @@ -1952,13 +1952,13 @@ roc_npa_pool_dpc_enable(uint64_t aura_handle, uin=
t8_t counter_id, uint32_t flags
>         req->aura_id =3D roc_npa_aura_handle_to_aura(aura_handle);
>         req->op =3D NPA_AQ_INSTOP_WRITE;
>         if (!(flags & ROC_NPA_HALO_F)) {
> -               /* Enable DPC in Pool */
> -               req->ctype =3D NPA_AQ_CTYPE_POOL;
> -               req->pool.op_dpc_ena =3D 1;
> -               req->pool.op_dpc_set =3D counter_id;
> -               req->pool_mask.op_dpc_ena =3D 1;
> -               req->pool_mask.op_dpc_set =3D 0;
> -               req->pool_mask.op_dpc_set =3D ~req->pool_mask.op_dpc_set;
> +               /* Enable DPC in Aura */
> +               req->ctype =3D NPA_AQ_CTYPE_AURA;
> +               req->aura.op_dpc_ena =3D 1;
> +               req->aura.op_dpc_set =3D counter_id;
> +               req->aura_mask.op_dpc_ena =3D 1;
> +               req->aura_mask.op_dpc_set =3D 0;
> +               req->aura_mask.op_dpc_set =3D ~req->aura_mask.op_dpc_set;
>         } else {
>                 /* Enable DPC in Halo */
>                 req->ctype =3D NPA_AQ_CTYPE_HALO;
> @@ -1979,36 +1979,7 @@ roc_npa_pool_dpc_enable(uint64_t aura_handle, uint=
8_t counter_id, uint32_t flags
>         if (rsp->hdr.rc !=3D 0)
>                 goto exit;
>
> -       if (!(flags & ROC_NPA_HALO_F)) {
> -               req =3D mbox_alloc_msg_npa_cn20k_aq_enq(mbox);
> -               if (req =3D=3D NULL)
> -                       goto disable;
> -
> -               /* Enable DPC in Aura */
> -               req->aura_id =3D roc_npa_aura_handle_to_aura(aura_handle)=
;
> -               req->op =3D NPA_AQ_INSTOP_WRITE;
> -               req->ctype =3D NPA_AQ_CTYPE_AURA;
> -               req->aura.op_dpc_ena =3D 1;
> -               req->aura.op_dpc_set =3D counter_id;
> -               req->aura_mask.op_dpc_ena =3D 1;
> -               req->aura_mask.op_dpc_set =3D 0;
> -               req->aura_mask.op_dpc_set =3D ~req->aura_mask.op_dpc_set;
> -
> -               rc =3D mbox_process(mbox);
> -               if (rc < 0)
> -                       goto disable;
> -
> -               off =3D mbox->rx_start +
> -                     PLT_ALIGN(sizeof(struct mbox_hdr), MBOX_MSG_ALIGN);
> -               rsp =3D (struct npa_cn20k_aq_enq_rsp *)((uintptr_t)mdev->=
mbase + off);
> -               if (rsp->hdr.rc !=3D 0)
> -                       goto disable;
> -       }
>         rc =3D 0;
> -       goto exit;
> -
> -disable:
> -       roc_npa_pool_dpc_disable(aura_handle, flags);
>  exit:
>         mbox_put(mbox);
>         return rc;
> @@ -2038,9 +2009,9 @@ roc_npa_pool_dpc_disable(uint64_t aura_handle, uint=
32_t flags)
>         req->aura_id =3D roc_npa_aura_handle_to_aura(aura_handle);
>         req->op =3D NPA_AQ_INSTOP_WRITE;
>         if (!(flags & ROC_NPA_HALO_F)) {
> -               req->ctype =3D NPA_AQ_CTYPE_POOL;
> -               req->pool.op_dpc_ena =3D 0;
> -               req->pool_mask.op_dpc_ena =3D 1;
> +               req->ctype =3D NPA_AQ_CTYPE_AURA;
> +               req->aura.op_dpc_ena =3D 0;
> +               req->aura_mask.op_dpc_ena =3D 1;
>         } else {
>                 req->ctype =3D NPA_AQ_CTYPE_HALO;
>                 req->halo.op_dpc_ena =3D 0;
> @@ -2057,28 +2028,7 @@ roc_npa_pool_dpc_disable(uint64_t aura_handle, uin=
t32_t flags)
>         if (rsp->hdr.rc !=3D 0)
>                 goto exit;
>
> -       if (!(flags & ROC_NPA_HALO_F)) {
> -               req =3D mbox_alloc_msg_npa_cn20k_aq_enq(mbox);
> -               if (req =3D=3D NULL)
> -                       goto exit;
> -
> -               req->aura_id =3D roc_npa_aura_handle_to_aura(aura_handle)=
;
> -               req->op =3D NPA_AQ_INSTOP_WRITE;
> -               req->ctype =3D NPA_AQ_CTYPE_AURA;
> -               req->aura.op_dpc_ena =3D 0;
> -               req->aura_mask.op_dpc_ena =3D 1;
> -               rc =3D mbox_process(mbox);
> -               if (rc < 0)
> -                       goto exit;
> -
> -               off =3D mbox->rx_start + PLT_ALIGN(sizeof(struct mbox_hdr=
), MBOX_MSG_ALIGN);
> -               rsp =3D (struct npa_cn20k_aq_enq_rsp *)((uintptr_t)mdev->=
mbase + off);
> -               if (rsp->hdr.rc !=3D 0)
> -                       goto exit;
> -       }
> -
>         rc =3D 0;
> -
>  exit:
>         mbox_put(mbox);
>         return rc;
> --
> 2.48.1
>
