Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B6DC8303F
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 12:48:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9C24402E8;
	Wed,  2 Jul 2025 14:48:35 +0200 (CEST)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 by mails.dpdk.org (Postfix) with ESMTP id 200A0402A0;
 Wed,  2 Jul 2025 14:48:34 +0200 (CEST)
Received: by mail-qt1-f181.google.com with SMTP id
 d75a77b69052e-4a442a3a2bfso74159011cf.1; 
 Wed, 02 Jul 2025 05:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751460513; x=1752065313; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PL4ZpKQSaAriblrXZRNJaQs4V1KPDGbiOL5YYgXTAGo=;
 b=NxNmkmGc+1fhXf2FeLqQOkxrmIR6roMM9vo93YZmG5Fg4JNJ9rniPxjY8IZG0tk8jp
 nVLuK98EdjtDxDYy7pjLrX65dkSpZxL1/VrnM6XPxILL5rN+H04UuXRL4AYsb54XyjjJ
 n2kMO088Ck1pA6RBKpYqhYZn6/OgnoCfeIjZXFb1z+V1UHBTIPCJAsnw01HToj45UlWV
 Sr+epTkbueQkaKxHZJ4a/vWq1mz/Xfsh24jNpuSLNzETjh1SNF+95Cfr1CojSq55GmRb
 Zqa6bowQDZbmuSXVYCqQO+nAP+uyejhIg9jteCNDK2K+0zgMaaLAFwJphyM5dnFtvE+L
 ZzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751460513; x=1752065313;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PL4ZpKQSaAriblrXZRNJaQs4V1KPDGbiOL5YYgXTAGo=;
 b=XF6NFtz5gQcLYJn7R9+4C7grNiv3tV1DmnuhmRMs07T3y++9LWCdn9CpfMoNPT0GNF
 eroo5oBLGZmE/kdSaOoS/8zRHV/nxYlfz9bWh3Gzfe9OGkVhyJhSyZ5Qw9sGonOMCR0g
 3X9/YeQCBO6aRrJRJFBvBHmMsqz49rn4Sv4GiyA377FfzFEkC5RkweHLvF8wX4kcT+KX
 B85XRJTr9SLSN4m4kiXUxP+56k6AnnZ77hlG2rMryKmuTNIwZnTqDonOaR/SLgQuznAv
 xH07JP0kIkEWp29H8nAwR5EMuHe7qMnIvVSaOTD7r7FCGVg69/AfY2NqYcR3VNzMuTTZ
 RfFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVH5y1ehAsu3cYvMgKkQApj+0XqgMUstMjUnFraTEZb1qVG+axxU354GCZfDQ07U0ireQ6lTZY=@dpdk.org
X-Gm-Message-State: AOJu0YwqsE1KLtBZrfTx2mWVWmyAEhFQMSOOclYbJsH8xUugMC+0Gdf3
 rr9fhsiGbdAunkARpG34yETaZad+18fa9hchFLksrq0OYd5YCJpgbpSsMAMUby52IweN5UY9wbc
 01vLy9FVK2WYkV8PM0UB39a1LurWWmBw=
X-Gm-Gg: ASbGncu356L7kP3CsLWbnRJbtZ4mgHfzC5rqxMhLDb0CyGCorlJW3NiWxjyDUGduH3r
 eJEuvOAKfKEK2i9Qp3Opa4S2itr80OtAIZ/pZkotc8lqEEtNKXTeS0qo9powdqaAdqw3JHJnAb4
 h/mejVRpWkXtMrYM87fM8Z2lPRcM4ltTwLfcYf4+Dcbg==
X-Google-Smtp-Source: AGHT+IFN8EmrZ3T/KglmmnTk3kU5pGKCFMrVr3v9exMEy0yH4XL5LDjUlasLJgECTKUb8h2kCAHUTUymL6Y95jhZdRQ=
X-Received: by 2002:ac8:5ac2:0:b0:477:e2d:2ec7 with SMTP id
 d75a77b69052e-4a9769e197fmr42505971cf.33.1751460513097; Wed, 02 Jul 2025
 05:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250627101853.5632-1-mabdulmajeet@marvell.com>
In-Reply-To: <20250627101853.5632-1-mabdulmajeet@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Wed, 2 Jul 2025 18:18:07 +0530
X-Gm-Features: Ac12FXz6fB7IJln3_dpnrxm8_AupsRMVgLj8JNigrzfAuWqSxwTPCFd6dln2YfI
Message-ID: <CALBAE1OCJrkL9+WX7UnMW+4OwgUj19dMYbHXHVfzDA72BRsAhg@mail.gmail.com>
Subject: Re: [PATCH v0 1/1] net/octeon_ep: fix increase mbox timeout
To: Mohamed Feroz Abdul Majeeth <mabdulmajeet@marvell.com>
Cc: dev@dpdk.org, jerinj@marvell.com, vattunuru@marvell.com, stable@dpdk.org
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

On Fri, Jun 27, 2025 at 3:49=E2=80=AFPM Mohamed Feroz Abdul Majeeth
<mabdulmajeet@marvell.com> wrote:
>
> Extend the mailbox timeout to 2500 ms in the Octeon driver
> to ensure firmware responses are received, preventing premature
> timeouts in mailbox request handling. This improves reliability
> of control network APIs, addressing issues where the previous
> timeout was too short for consistent operation.
>
> Fixes: c836a7ba33ee ("net/octeon_ep: support mailbox between VF and PF")
> Cc: stable@dpdk.org
>
> Signed-off-by: Mohamed Feroz Abdul Majeeth <mabdulmajeet@marvell.com>
> ---
>  .mailmap                            | 1 +
>  drivers/net/octeon_ep/otx_ep_mbox.h | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/.mailmap b/.mailmap
> index 8483d96ec5..753853b396 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -1850,3 +1850,4 @@ Ziye Yang <ziye.yang@intel.com>
>  Zoltan Kiss <zoltan.kiss@schaman.hu> <zoltan.kiss@linaro.org>
>  Zorik Machulsky <zorik@amazon.com>
>  Zyta Szpak <zyta@marvell.com> <zr@semihalf.com> <zyta.szpak@semihalf.com=
>
> +Mohamed Feroz Abdul Majeeth <mabdulmajeet@marvell.com>

I have sorted this in alphabetical order.

Applied to dpdk-next-net-mrvl/for-main. Thanks
