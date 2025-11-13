Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72C0CD6E41
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 12:24:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BEF040B91;
	Thu, 13 Nov 2025 13:24:32 +0100 (CET)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by mails.dpdk.org (Postfix) with ESMTP id B1A8740151
 for <dev@dpdk.org>; Thu, 13 Nov 2025 13:24:30 +0100 (CET)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-4ed946ed3cdso5304781cf.3
 for <dev@dpdk.org>; Thu, 13 Nov 2025 04:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763036670; x=1763641470; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I5oUZJuenkQ6of8/LKI4s0Ku5k9ryjS6BpCb0UY5eFs=;
 b=IvbbjKjmHPZgZDa8d/VlNScYMqJx4kcdF11J/9H4Ztv2h1XNO1VROpBQMi9I7/6ct5
 pdSXDawGR+lNX45memcDHaPEzFWWGBHkO7xrBbeu+S1eTYly4tbeOb/ZjjO0v9/otznz
 Qbr/AU6uoJ5EpHfCgynHcVb/iMi+SEzKWZ3coJ0w4/KyJrpHupGttq/BHoXK54jPrhd8
 64VO64A9MPWmdvoOdW+1Mu8NE3O3+F7o9x4NdV+r7swk6c4G6DuPGrb01FYUEJT5dJG1
 fR1GIC40pr5kCcvtBzYp0JvL67jbdIMsVV3GMh78hTUhIdEbNyPN0DcO6ONeXoZ5MIUK
 s9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763036670; x=1763641470;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I5oUZJuenkQ6of8/LKI4s0Ku5k9ryjS6BpCb0UY5eFs=;
 b=JIKErz+ZgdZIeXF5tkBCC1K2v4PfAORsNOW35JOHAbxUZIYOTiLi3GrQt4mkUj8N2y
 uNyNP5Xn1BFJeyNhEAsahQ1zqVNpKKYzzKYMgeorHHoxgGXHlVgzOD+tWcY0HGCUNbLt
 I4NO28vvesi2epwlswxfo5k5b2dMYs69t5LjJ9Up1/OIs7mCyZbJgwCfn4cpok15UQjX
 QQcTzZg8aVVkqWVR9zFR2tipJx+wvsEcv8/nvsmOOaU/TTjCa9OX86GntQVlpno0PfD1
 TEIysLNfYxYOL66EQbf0f4HXGBJ1SDzxV3b3C+ko290YK61NS2IX/R0tGz7OTg3GVwxA
 vWBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtGtr5Rg14LfQd8JE6f8oxxU2m/2PEScFH6mWBXAOtdVQTKOG6HOb8FIeKDswoOPUSQPE=@dpdk.org
X-Gm-Message-State: AOJu0YxOksnxNs39gOXViYJ9jH7WeAAqYB+WKwvdJGKXWeCmQuCL2bQu
 L6bHpSVcIuNvRb+oyh9CXA53yDWfw1AGRm+N62Phj4s2GdxMZ6SWgdhWgLbcx71w+YpASoWLEnY
 c/EfTCJTcgaUZWo5yw427iAcZyCLmkq8=
X-Gm-Gg: ASbGncuT5+lUJBjvELuqBswQznJZknEt/MsZ5X+YoIRui5/18q9PJlhwnqqSH8RpEQ+
 Ex/Uww1Cl0Sf+bQRfeC8RhnivpFHatEqepzCbouNZ6AVmAcx8+kiomWsuWJgrx4g119C/iv3Hfk
 7HM3ggFMZMn8+rVZ7CvSO39IuPMIpTgqVCuD2508hIUZkc5xPaVjMI1DO/L2+fDjIQZPmOj+ijD
 wnhJIHxQIqA6IOMvJFCogBaUIzyk6rBD4popPvSOQysdU2VEgMOfoM4gmQ=
X-Google-Smtp-Source: AGHT+IFGHj1ZSoLLcEe7Lx0O3FhXdyhhWb/ZwIxpCiiiM44Pkz2K6GAqAEkHqUw2S4mGlfGl7Q8yt2Ers+GYMW+kytI=
X-Received: by 2002:a05:622a:448:b0:4ed:b012:9706 with SMTP id
 d75a77b69052e-4eddbd5dec1mr80241191cf.43.1763036669897; Thu, 13 Nov 2025
 04:24:29 -0800 (PST)
MIME-Version: 1.0
References: <20250901073036.1381560-1-ndabilpuram@marvell.com>
 <20251113043808.1180851-1-ndabilpuram@marvell.com>
 <20251113043808.1180851-23-ndabilpuram@marvell.com>
In-Reply-To: <20251113043808.1180851-23-ndabilpuram@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Thu, 13 Nov 2025 17:54:03 +0530
X-Gm-Features: AWmQ_bk_XTij7d81XQ12UilUDKrhqS3Cka-woiFahTs11AqZ1zTErOPsl7LnJt8
Message-ID: <CALBAE1MLmsecwYOh+6=fk2pJkW0gpjrF99YrXzzc_YgM2M5DGA@mail.gmail.com>
Subject: Re: [PATCH v5 23/23] net/cnxk: check for invalid default pre color
To: Nithin Dabilpuram <ndabilpuram@marvell.com>
Cc: Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, 
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 jerinj@marvell.com, dev@dpdk.org, Aarnav JP <ajp@marvell.com>
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

On Thu, Nov 13, 2025 at 10:46=E2=80=AFAM Nithin Dabilpuram
<ndabilpuram@marvell.com> wrote:
>
> From: Aarnav JP <ajp@marvell.com>
>
> While converting to HW specific icolor, check for invalid
> default pre color.
> Fixes: ac35d4bf4cd6 ("net/cnxk: support ingress meter pre-color")
>
> Signed-off-by: Aarnav JP <ajp@marvell.com>

Series applied to dpdk-next-net-mrvl/for-main. Thanks


> ---
>  drivers/net/cnxk/cnxk_ethdev_mtr.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/cnxk/cnxk_ethdev_mtr.c b/drivers/net/cnxk/cnxk_e=
thdev_mtr.c
> index edeca6dcc3..992e2d446e 100644
> --- a/drivers/net/cnxk/cnxk_ethdev_mtr.c
> +++ b/drivers/net/cnxk/cnxk_ethdev_mtr.c
> @@ -1261,7 +1261,13 @@ nix_mtr_config_map(struct cnxk_meter_node *mtr, st=
ruct roc_nix_bpf_cfg *cfg)
>
>         cfg->alg =3D alg_map[profile->profile.alg];
>         cfg->lmode =3D profile->profile.packet_mode;
> -       cfg->icolor =3D color_map[mtr->params.default_input_color];
> +       int idx =3D mtr->params.default_input_color;
> +
> +       /* Index validation */
> +       if (idx >=3D RTE_COLORS)
> +               cfg->icolor =3D ROC_NIX_BPF_COLOR_GREEN;
> +       else
> +               cfg->icolor =3D color_map[idx];
>
>         switch (RTE_MTR_COLOR_IN_PROTO_OUTER_IP) {
>         case RTE_MTR_COLOR_IN_PROTO_OUTER_IP:
> --
> 2.34.1
>
