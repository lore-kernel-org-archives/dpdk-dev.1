Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6216083618
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 14:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tZl86c1I
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D548D40DF8;
	Thu,  5 Nov 2026 15:14:41 +0100 (CET)
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com
 [74.125.224.45])
 by mails.dpdk.org (Postfix) with ESMTPS id 299F94060F
 for <dev@dpdk.org>; Thu,  5 Nov 2026 15:14:41 +0100 (CET)
Received: by mail-yx1-f45.google.com with SMTP id
 956f58d0204a3-67a2bd0c297so2254850d50.2
 for <dev@dpdk.org>; Thu, 05 Nov 2026 06:14:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793888080; cv=none;
 d=google.com; s=arc-20260327;
 b=P93UFJpeAAb3cOGPJLYWjbzrLlSGcyhVSQ5InJqR+Rqx7gKc2HsiSg/eZwpLYt16+3
 cNN4ezKhqaKqxp6HXkS68MaWDo0LJN601DipHf6MywDa67zIenTaXnLiNAeTTZpGpSfv
 n0mgSCnroLN8XD3Hhk36FNwZCnLGHLxwusqfiihtsW8SqjR66J9cdksRNyBYHtar7mfF
 fT1lKJg0l7Uys4eZGCLu0RgGE8XdxxoUYXFbBFoFv70qB6eaP17f7P9E9xU5fcy9jUeA
 xfDH9/U+6jCnD9gOy+7nSTlccyzg5Fq8iUCTmC7e+OGlDCGxFCRnmR+z/keQUQ62Texn
 lVgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Kgigrv8a2RGM5nLh6mfBCXqrPnLXiGLhbBTBGMr2cAQ=;
 fh=oBzMBBXUrXJu8DCdXy429mcmyPngsflSehz1sgIePJU=;
 b=bNtX+yJITIeos24udSZ+9q4AsDbEcxEsFS7RE24MyEbRSkiXHyrsk2baei6qRwtx9B
 e1svtAqolbq5MeEE0P+DPsM1vs7TObsZoqO3ndlJ7tuoGappI3lk8D6fjb3A2uSwMDAa
 1ia81Og2m67nLmPQVf1K/gZU/in5N67/a3AmzfY9/mE87VLYGUpRhs47kcu1JiZtlJks
 Jv0br20OgX6GmnATCVNUMReb9KmXlGofXCy8zSy0EUg0v32AjMltGA9eBwtDrP8UaEGP
 /uPKrgJxADP8zsh5/qtHrOld/bvuQxfk81BxcfA5z5BCqY3IRbRSgxdzByf2QIIiJuRS
 RCZQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793888080; x=1794492880; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Kgigrv8a2RGM5nLh6mfBCXqrPnLXiGLhbBTBGMr2cAQ=;
 b=tZl86c1Iozz8iFRL3SUf3vuFDDMuiEUDGvh8GU3kBa1nkdzoudg0G+KoC5Vu/ErbIj
 rYXjRhayO5XcKK8InUBm6Tja6y2+MlrjpkcBArd2oddmtekYB9Ruv0pqFLKghMJVAn/B
 6UlorPNLV7rwA+rz89MpcvAl9+4UKKC8Gr46A4YUOHizlVDL1U1rdGSb6KXyk+lL6iwJ
 CnFRm47CLkiKgrcf7WESh2ER2SLaom5YgB7F6T4HC/JK2Px0XxEif6FsOPuZ9aJVER3f
 DWAoI+K/Ju3twSwRoRDGjjy7oJUS4PICX99FitT8K5+y+WzLsXbHMo4eQufCcksdcXY2
 mHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793888080; x=1794492880;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Kgigrv8a2RGM5nLh6mfBCXqrPnLXiGLhbBTBGMr2cAQ=;
 b=M3YW9d3d4DJbPLqi4RG2HAmOSvatiK6YOcBhdOiJYLSDlRdmamolvGNIbNl7HwW5qE
 ON6wLgREDyXsWxi7sBCplyCARU/yJSmLRbjB4eYOctY0ZUtdCjUT513W02eFkiFj7uNG
 ig0/KF67VY6ay1VDCzW7twbZBCUDUFCKIylzqzSaADaj/r3hzhybgO/mkPJSk1YoI5ZM
 xA/W35TEc4OnYod8ybI2Ly8CyzxvtZt4vm3hjcTeTddqShalFZ8S0BhK0+vWHN9Rb1/C
 +TeCeICDMmdk8QnrYsdMh1MbprEhGzumNWv17D/Dgz9faGnStPZ9JItJWC7I7ZHo/5T5
 1ENA==
X-Gm-Message-State: APuU4Z8KF71XUjJ0A94SXJPFIwcWJdq+15LD2k4URPFpdV/BXTShDuu2
 6uGkqrFFp06XgHcMxGi+RW2l3Q7HujZKhpcKcKwofg2QFqEbQ4VOonZhImSYG52VsbcmY25GnaI
 aLuNVeAe4rI/iHcmG8rBeJt6cDOyE1FE=
X-Gm-Gg: AYBFou3p3cn91wSJ1DJCL+BlS4BT0/1nwJz3YzBweygdsy3ww/Uhtd7VKQ31Bc8h4oA
 XgLP9kxAp64dE2QTvmaYq3VVKiiyjm1DrLpLFUX79pg7MEskLJ8J334kvGqy9B1KfnLg2CqZJUj
 5IxpeKIPRGFxaIbZTXsL2XSK26cdwdyLmX/8x5hY8dKf8yUzTqh4pL0iexj/B9cmSt2catUji57
 n9gxodW/753rQFX6f2KX44/fKmqRWYBoDKL2mmiN4qaaUGLx8zZVO1AfPeM+h7HRrLQrl1IwoBJ
 5HGBA8tE3FklFSlMAtilxZNMS4fGVgA3O65MMm95KPhdmBJEuNVWnY2B+A/zn0uZIaWbOJJsZRy
 Ig77lgEyhbD+/J6EB/pG7NuFkNyyjI73waDk1xlui267j6vO92RI6jtDAl96YGgIBbEg6CCxsni
 3GrsfQi8tu6vSmDvikNpFZ5NrXAUliYzmS1nqIpNH3y7g6xcS3gnhNdTSLXeNyj2Vui6sN7Hk4Q
 w==
X-Received: by 2002:a05:690e:11c3:b0:678:d394:76e5 with SMTP id
 956f58d0204a3-67ba50b2058mr13912267d50.78.1793888079904; Thu, 05 Nov 2026
 06:14:39 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030053753.929279-1-nkishor@marvell.com>
In-Reply-To: <20261030053753.929279-1-nkishor@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Thu, 5 Nov 2026 19:44:13 +0530
X-Gm-Features: AclHuK8cwQEH3b-25IIfm-vdZNwliFpXGxk4Bahfb2v8DoLquKsssqm4hkeNQZw
Message-ID: <CALBAE1ODYMJVZQM3jpRjS2-yv6EovMoKKqV+m3R8v_aL+u=gQA@mail.gmail.com>
Subject: Re: [PATCH] common/cnxk: handle increased count eot width for cn20k
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

On Fri, Oct 30, 2026 at 11:28=E2=80=AFAM Nawal Kishor <nkishor@marvell.com>=
 wrote:
>
> The COUNT_EOT field of NPA_LF_AURA_BATCH_FREE0 is 1 bit wide on CN10K
> and 2 bits wide on CN20K. Extend roc_npa_aura_batch_free() and
> roc_npa_aura_batch_free_burst() to write the 2-bit field.
>
> Bit 33 is reserved on CN10K and is ignored by the hardware, so the same
> value can be used on both models.
>
> Signed-off-by: Nawal Kishor <nkishor@marvell.com>

Applied to dpdk-next-net-mrvl/for-main. Thanks

> ---
>  drivers/common/cnxk/roc_npa.h | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/common/cnxk/roc_npa.h b/drivers/common/cnxk/roc_npa.=
h
> index df68e13ec6..a31f908955 100644
> --- a/drivers/common/cnxk/roc_npa.h
> +++ b/drivers/common/cnxk/roc_npa.h
> @@ -509,14 +509,20 @@ roc_npa_aura_batch_free(uint64_t aura_handle, uint6=
4_t const *buf,
>         /*
>          * NPA_LF_AURA_BATCH_FREE0
>          *
> -        * 63   63 62  33 32       32 31  20 19    0
> +        * 63   63 62  34 33       32 31  20 19    0
>          * -----------------------------------------
>          * | FABS | Rsvd | COUNT_EOT | Rsvd | AURA |
>          * -----------------------------------------
>          */
>         free0 =3D roc_npa_aura_handle_to_aura(aura_handle);
> -       free0 |=3D ((uint64_t)!!fabs << 63);
> -       free0 |=3D ((uint64_t)(num & 0x1) << 32);
> +       free0 |=3D ((uint64_t) !!fabs << 63);
> +
> +       /*
> +        * COUNT_EOT field is 1-bit wide in cn10k and is 2-bit wide in
> +        * cn20k. However we can consider it as 2-bit wide for all cases
> +        * as the upper bit is going to get ignored in cn10k.
> +        */
> +       free0 |=3D ((uint64_t)(num & 0x3) << 32);
>
>         /* tar_addr[4:6] is LMTST size-1 in units of 128b */
>         tar_addr =3D addr | ((num >> 1) << 4);
> @@ -546,14 +552,19 @@ roc_npa_aura_batch_free_burst(uint64_t aura_handle,=
 uint64_t const *buf,
>                NPA_LF_AURA_BATCH_FREE0;
>         tar_addr =3D addr | (0x7 << 4);
>
> -       /* 63   63 62  33 32       32 31  20 19    0
> +       /* 63   63 62  34 33       32 31  20 19    0
>          * -----------------------------------------
>          * | FABS | Rsvd | COUNT_EOT | Rsvd | AURA |
>          * -----------------------------------------
>          */
>         free0 =3D roc_npa_aura_handle_to_aura(aura_handle);
> -       free0 |=3D ((uint64_t)!!fabs << 63);
> -       free0 |=3D (0x1UL << 32);
> +       free0 |=3D ((uint64_t) !!fabs << 63);
> +       /*
> +        * COUNT_EOT field is 1-bit wide in cn10k and is 2-bit wide in
> +        * cn20k. However we can consider it as 2-bit wide for all cases
> +        * as the upper bit is going to get ignored in cn10k.
> +        */
> +       free0 |=3D (0x3UL << 32);
>
>         /* Fill the lmt lines */
>         lmt_data =3D (uint64_t *)lmt_addr;
> --
> 2.48.1
>
