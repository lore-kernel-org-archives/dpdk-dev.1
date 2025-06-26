Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2F0C7115B
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 05:32:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CBDE40B98;
	Thu, 26 Jun 2025 07:32:11 +0200 (CEST)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
 [209.85.160.170])
 by mails.dpdk.org (Postfix) with ESMTP id 8B9274060F
 for <dev@dpdk.org>; Thu, 26 Jun 2025 07:32:09 +0200 (CEST)
Received: by mail-qt1-f170.google.com with SMTP id
 d75a77b69052e-4a585dc5f4aso7909291cf.2
 for <dev@dpdk.org>; Wed, 25 Jun 2025 22:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750915929; x=1751520729; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l3XeEbz/8PJVQr3U7hBSwIzqa++WSwgcX4g32d5aYOU=;
 b=YZwxcsi7oH1NR47WYNcNmiRdsEEzYZZxsv7DQ2IyIw8POj5FyTi2FEkW1HAK5adFgf
 XNwqf96366mmvR06+lXwgjO7y8fh+wDl7wcboLZ71NOAowHZT7WbD7ICtZmEAlBh/1iE
 K1txb81mK0JzNIG9Gp1wm4on6mkz6ntTSK1R9e8JCYK+NPvokyN8wP4BxbIK40rlXjC6
 rNrfht3cZxFFvVb+oGqybxfv+osvlABPzb32RxEJIpfpBeZwsMDgKrkLntwimg3rLp0w
 UZrlwsj9/Yx0aGAEou5EDy/8qBAo5GaQiLSS5KB7AdO1ypzBpUyUTIa7FP1gr/CTbPYL
 Pehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750915929; x=1751520729;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l3XeEbz/8PJVQr3U7hBSwIzqa++WSwgcX4g32d5aYOU=;
 b=r/XY9AZ7bt0FdDRJzoPQbPyiGM+JkMhoRhv+gMINWpjGyHmnv/reoF9cmDEh1Bo44v
 z83kp0Gdvh8/UI2NMUxmXU3e83ikw6PbyGY4fPz3rMey2nBl24XQh68SUc0qmHJOruHa
 aloFXdlMc3adnXnA3adhT6ShVeYMAY5C0wNsDTzaYSgb4B3Er78iLSqqNrAsvN9bh9g6
 aQ/MOBRoR4WKgqge+sVquDldL0rW1Gdy4CypZd8ctdqBZEocQcSOOf7y/kCyVQRTY5mI
 Rksw2bflfiyxInwI0znA+5FH9GzKVTYxmceuNGC4JotQLWIDG4HKyYFj9ixPNF1Nu+1C
 mGsw==
X-Gm-Message-State: AOJu0YxHtj+VOn/8SBepxGsMIuOAcSWpVewD0iZKrAJRHOmQC4xEo/Lt
 NDHgb60WKFvXbK03K0JgvFrMmQfI9/ng62qIU0HMk3qYZ+ON923nrXbQuntgGp31QHqwncDdSPO
 nyJcvtfOmKL85guUMyZ7al4ri1efTbXRLiAoT
X-Gm-Gg: ASbGncuThOIRRrInXr7cgLO4o1dqKMN/zxM/sWpgtNfcLkX6gLBfBDWveDWjqY40n3f
 WKTFwnMox2w1jXl9CvAXxhTZ5kG9AR2Ofd+nFRcxsQ+N5/IWF5+uxWQxVhKl6fKr4K0+D/zV88y
 gyHN+IxwBAkN8oyvnszY4MI4jj2XiQIss2insPTUHCLLZb0hx+CYvn
X-Google-Smtp-Source: AGHT+IFHhb96Mviljs+1Ief/2XhddaqsNlzjJGBVycxn2kOic3kXxMOlqpUDIgQLEbQHEhJZRBZYF8wuaLJ5Ry8FzF4=
X-Received: by 2002:a05:622a:5d3:b0:4a7:a905:d5b1 with SMTP id
 d75a77b69052e-4a7c068c1c8mr94627621cf.15.1750915928687; Wed, 25 Jun 2025
 22:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250620050950.2548925-1-rbhansali@marvell.com>
 <20250623044907.2906896-1-rbhansali@marvell.com>
 <20250623044907.2906896-2-rbhansali@marvell.com>
In-Reply-To: <20250623044907.2906896-2-rbhansali@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Thu, 26 Jun 2025 11:01:42 +0530
X-Gm-Features: Ac12FXz2J-n1grzuYF5fvrWV5dhw5BoA8JIdq5Hga2CXwVBx0d2g3APmOWx541E
Message-ID: <CALBAE1OMRj9s7ONbqvRrN8p5V9-5-yzv9JA4HTbBZzWuOCJ8aQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] common/cnxk: fix null pointer checks
To: Rahul Bhansali <rbhansali@marvell.com>
Cc: dev@dpdk.org, Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, 
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, 
 Vidya Sagar Velumuri <vvelumuri@marvell.com>, Jerin Jacob <jerinj@marvell.com>
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

On Mon, Jun 23, 2025 at 10:19=E2=80=AFAM Rahul Bhansali <rbhansali@marvell.=
com> wrote:
>
> Adds null pointer check before executing CPT instruction.
>
> Fixes: 4d00b8c6a331 ("common/cnxk: allocate dynamic BPIDs")
> Fixes: 4af4e36a93d7 ("common/cnxk: support inline device API without ROC =
NIX")
>
> Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>

Series applied to dpdk-next-net-mrvl/for-main. Thanks.


> ---
> Changes in v2: Updated fixes in commit message.
>
>  drivers/common/cnxk/roc_nix_inl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/common/cnxk/roc_nix_inl.c b/drivers/common/cnxk/roc_=
nix_inl.c
> index bee8e25c7c..c7637ddbdc 100644
> --- a/drivers/common/cnxk/roc_nix_inl.c
> +++ b/drivers/common/cnxk/roc_nix_inl.c
> @@ -1312,7 +1312,7 @@ static int
>  nix_inl_legacy_inb_init(struct roc_nix *roc_nix)
>  {
>         struct nix *nix =3D roc_nix_to_nix_priv(roc_nix);
> -       struct roc_cpt_inline_ipsec_inb_cfg cfg;
> +       struct roc_cpt_inline_ipsec_inb_cfg cfg =3D {0};
>         struct idev_cfg *idev =3D idev_get_cfg();
>         uint16_t bpids[ROC_NIX_MAX_BPID_CNT];
>         struct roc_cpt *roc_cpt;
> @@ -2219,7 +2219,7 @@ roc_nix_inl_sa_sync(struct roc_nix *roc_nix, void *=
sa, bool inb,
>         if (idev)
>                 inl_dev =3D idev->nix_inl_dev;
>
> -       if (!inl_dev && roc_nix =3D=3D NULL)
> +       if ((!inl_dev && roc_nix =3D=3D NULL) || sa =3D=3D NULL)
>                 return -EINVAL;
>
>         if (roc_nix) {
> @@ -2299,7 +2299,7 @@ roc_nix_inl_ctx_write(struct roc_nix *roc_nix, void=
 *sa_dptr, void *sa_cptr,
>         if (idev)
>                 inl_dev =3D idev->nix_inl_dev;
>
> -       if (!inl_dev && roc_nix =3D=3D NULL)
> +       if ((!inl_dev && roc_nix =3D=3D NULL) || sa_dptr =3D=3D NULL || s=
a_cptr =3D=3D NULL)
>                 return -EINVAL;
>
>         if (roc_nix) {
> --
> 2.25.1
>
