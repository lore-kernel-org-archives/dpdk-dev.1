Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE5FC54FB3
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 May 2025 17:59:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EE514027C;
	Thu, 29 May 2025 19:59:03 +0200 (CEST)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by mails.dpdk.org (Postfix) with ESMTP id CAA9240275
 for <dev@dpdk.org>; Thu, 29 May 2025 19:59:01 +0200 (CEST)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-476f4e9cf92so7933911cf.3
 for <dev@dpdk.org>; Thu, 29 May 2025 10:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748541541; x=1749146341; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4T3lSsbieD/zruUjY+K1e2O2OmZbuSSvjKv9PczHxVI=;
 b=VrL4LXN5Pe0oNEqd5Nm2O7b4V210LxxDxMq0y7Al8mAxVqMnJTkPQ2iBgLCBHVCx+G
 tL5vNbMdnjNQ2lcPHFjLRIJ9NYhwdWrSK/opGh5AQu6VXQ2cX6wlfeEiyPUsF2g8JVsC
 Km+prMzNy6DRhH91LSn87rJZSa6SXfnMIa/RWf//DV/G8M88htXqsivlJILQkaFEBQL7
 hKyPQ0Mhn4G3BuCvcZ/2PLejXAWLdtvo75R61gT60L/3vu/zR00UKCSet+JuySMi4xTW
 QODfAF0BITTilHZYeeSa8KnTlhO+cc1Gd0TKlvT4SF2cL/Uq01lM1LEPKlEo2i8fcBmB
 EdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748541541; x=1749146341;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4T3lSsbieD/zruUjY+K1e2O2OmZbuSSvjKv9PczHxVI=;
 b=hvfNohweLY+mPmvoJCjNxkqkaao2sV938Yb3jdOp829lL5JbeYKK3mUNbeyxfwJo9/
 X6QzYzLkiiFk9Ac8sUAwTGo/QCrEGDONaojhCNSswewc0fJyhijiWwhpMH5qoZPB1jUS
 hHnnMgJOGRA74HjgMvOs34WFtc0Sb+6VOWfSHpG936tCLT5IEtiHbzWqrkV/w/cERhaI
 UcE4BXPiWizFCKd/N2uzVwMhrtA3345Fu5t9fZi+Qwp4d/RVQ1RaS7gEgjSisPf3YLH+
 R+VpKI8a+ofwJIeuQJf5EdTu6i8y+479r6bVnx6YldSg4XsstfXk7fi4HEdMsuLIADNk
 vA1g==
X-Gm-Message-State: AOJu0YxVV1iLS+ZMM/V3k1SrP6qY/AdMpEMbxwU+6UJiO92n84jaachl
 UsFMXNbewGnlMSdRFRB++brL8eaSWvtBXNio7MtxHFneN6uHm89+tqSdjHjJr1K/pKMWQ9Tnthj
 Uk6B3I49yX+076Yfh8lqtjdbcPi9tMWs5QFA1
X-Gm-Gg: ASbGncvkAwpU+8YfXN/O9+oRRceqfduizsJ66aqXrSnwXl1xw2rheFrRt4Vat4YF0kF
 lEjdQjAcEQNCUXBmFIeEfaelZ9HxHqvmHMVfo6iO+0D4z7y4KmDO6Boy4lxZfJch8pUSjYRieqL
 lwC6HaDZ2L0qrNZM0z9dlIXXcFGKUQKOs=
X-Google-Smtp-Source: AGHT+IG6LANmL+TF0qdtAvDNHDR9po2UkeAi7DZ1E0CUZUOrohEY61ZItaqK6dAUOPXHKOqJ06k4ff9sdCRZBmShqrg=
X-Received: by 2002:a05:622a:58ce:b0:4a4:3d27:77a0 with SMTP id
 d75a77b69052e-4a440022050mr12428761cf.2.1748541541143; Thu, 29 May 2025
 10:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250528115122.24052-1-rbhansali@marvell.com>
 <20250528115122.24052-7-rbhansali@marvell.com>
In-Reply-To: <20250528115122.24052-7-rbhansali@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Thu, 29 May 2025 23:28:34 +0530
X-Gm-Features: AX0GCFsdlif6goVpFCsFAlIAW0J9j4tw6fBhMzkVZA2QSZO1FXuplGxZY6oxe4c
Message-ID: <CALBAE1NEH_drPodG0UDFJkXQavR4QcM4vdxqYrZrCama4mk=WQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] doc: updates cnxk doc for new devargs
To: Rahul Bhansali <rbhansali@marvell.com>
Cc: dev@dpdk.org, Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, 
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
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

On Wed, May 28, 2025 at 5:32=E2=80=AFPM Rahul Bhansali <rbhansali@marvell.c=
om> wrote:
>
> Adds details of below nix devargs
> - force_tail_drop
> - disable_xqe_drop
>
> Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>


Squashed this patch to relevant commit and Series Applied to
dpdk-next-net-mrvl/for-main. Thanks



> ---
>  doc/guides/nics/cnxk.rst | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/doc/guides/nics/cnxk.rst b/doc/guides/nics/cnxk.rst
> index 35f95dcc0a..7f4ff7b4fb 100644
> --- a/doc/guides/nics/cnxk.rst
> +++ b/doc/guides/nics/cnxk.rst
> @@ -470,6 +470,29 @@ Runtime Config Options
>     With the above configuration, inline inbound IPsec post-processing
>     should be done by the application.
>
> +- ``Enable force tail drop feature`` (default ``0``)
> +
> +   Force tail drop can be enabled by specifying ``force_tail_drop`` ``de=
vargs``
> +   parameter.
> +   This option is for OCTEON CN10K SoC family.
> +
> +   For example::
> +
> +      -a 0002:02:00.0,force_tail_drop=3D1
> +
> +   With the above configuration, descriptors are internally increased an=
d back
> +   pressures are optimized to avoid CQ full situation due to inflight pa=
ckets.
> +
> +- ``Disable RQ XQE drop`` (default ``0``)
> +
> +   Rx XQE drop can be disabled by specifying ``disable_xqe_drop`` ``deva=
rgs``
> +   parameter.
> +   This option is for OCTEON CN10K SoC family.
> +
> +   For example::
> +
> +      -a 0002:02:00.0,disable_xqe_drop=3D1
> +
>  .. note::
>
>     Above devarg parameters are configurable per device, user needs to pa=
ss the
> --
> 2.25.1
>
