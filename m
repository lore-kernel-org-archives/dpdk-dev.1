Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDFFF436BF
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Apr 2026 17:04:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B936C40657;
	Fri, 17 Apr 2026 19:04:02 +0200 (CEST)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by mails.dpdk.org (Postfix) with ESMTP id 6F1D2402DD
 for <dev@dpdk.org>; Fri, 17 Apr 2026 19:04:01 +0200 (CEST)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-12c565dd3a7so1403624c88.1
 for <dev@dpdk.org>; Fri, 17 Apr 2026 10:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776445440;
 x=1777050240; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gd85ZO/CNZhbppk12KYDiarMGJ0NR2HDtXUDUpSCZrw=;
 b=cO8w4zZCfHNCu1z8qVxkaNgFiW9EeHxn488RhjBxmDOPy2719xiCT+fpBwvIrUQJFP
 wY+RnT0rp21EtzYiciUjvcfLEnrujbEUMK9Dnhh+poHLcCSyUzpiVO6Cw3kyDpEg4u06
 BSIDCj98XzphNhlLNFCLxGWCuJFFmLM5xxlb+CxmB2LEpuYQIli6ifrNSAkSKflQtWTV
 ftp6U3+F6LvyT525AP0Gh6Fzg4+nXq2VT0bTJpxr0yQy9CrF5OhQ0aof8KEhCtV7ppFC
 AHRGRl94QLdWf4Vxn8ZWfha2JC4x2jq5l+u8mKIEqQWChAHs7GGGaJDDUnH0sIS7mQpY
 6JdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776445440; x=1777050240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Gd85ZO/CNZhbppk12KYDiarMGJ0NR2HDtXUDUpSCZrw=;
 b=DymUUfat0TXM/EwKvn3q5INZnbsDpCoc5I4UOHD1z/WOlfmu/dCH1Z+erBMDJxqyMZ
 UU7cBs605SacVrZtfIS7pZIVWDz8SsEq59YtWQmrJMrJtr5ipYqqwrQ+A7Fmwgj2ZiAL
 oeOvMf6zXj7N+28qGlLv3nOxVZYEkW91qOT8HdR0m7HPJBnDuMXkmxIXqJE2QizRnMBH
 KC1Oud5RSXDXmBohIieqPQ1mJfpchIp9hzkC7ztm2sZVyO6z4hKcL8/DfpeSFeqC3i6G
 yrXmnVcGMsqZOxUG1H/8ufij30Wi2DXuYyFP8sRGPWL1AUG/xxg01EIorCTtxig+xODZ
 Yh4w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8THsep3poXVp5rWsg0bRmoflq5EH3fPJTmE7YC3+MpM+22KC5OgOwzZaNNv4KSAUR5PRE=@dpdk.org
X-Gm-Message-State: AOJu0Yybdi/OSiwCsdKCM6QxnZTO0LhOg7lJa14EVbainfjSVxxFGnEg
 E8z5UMweLGDyirmfGqnkAN5NuTOWcDO0wec3dpN9KjOOJe5o+NN+dxcOBsqQn/t5Jys=
X-Gm-Gg: AeBDiesqizGGPSVV9lX8VMwTin7QH3qf1Ya0q2iDorD5Kr8pH/WePXdFfkEm8GLp0Yd
 iXkblZhW0bTBChUTQ3awyp0CxqJqFiBDmMPS8GWj2akXJOQlG0ErkUnc9pm6bgm0VRX8n4Ygo+k
 sOm+v59bsgVOJD13T4S+tr4PlpCb29Q83rNOurE3Cch6SbI8UX5Plu1MBCGxpGb7twqr0Qiif8C
 lXsuYjTm0odJ2TywSAe4oD/oPRqcyLAkJ7lATE4BpU8t3Rhs07Myg5wZdfRnUhauELagbWqpdn4
 ChRxIObnJoeZPlq9ZLtOHDYHfGHI1oWrUsdOY1/v+knpS8aricuGWiLVwnzxE/cjpuPd64I8bL2
 +YWU8Z/xWtg1giIeO1dx8PHwUD950f7eJRRR1pCtjBOj2Lpjn8sTMLkS2Fkt8OlqfEClOgUYHux
 XVJe4NQC/BD3tTsj9XN49FvuDpLXXDhgXV/ApTQ1br94MzWw==
X-Received: by 2002:a05:693c:2b04:b0:2df:919f:ce59 with SMTP id
 5a478bee46e88-2e47901614bmr2018260eec.19.1776445440235; 
 Fri, 17 Apr 2026 10:04:00 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e53ccce440sm2886276eec.14.2026.04.17.10.03.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 10:04:00 -0700 (PDT)
Date: Fri, 17 Apr 2026 10:03:57 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Cc: Denis Lyulin <lyulin.2003@mail.ru>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>, Sriharsha Basavapatna
 <sriharsha.basavapatna@broadcom.com>, dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH 1/1] net/bnxt: fix string bounds checks and format
 specifiers
Message-ID: <20260417100357.7ef0dd36@phoenix.local>
In-Reply-To: <CA+BST0=Ntw_W_57uZ7DqLLFhxs9fvFsGBOiKGiZvy7GFwwubHA@mail.gmail.com>
References: <20260417045640.2217188-1-lyulin.2003@mail.ru>
 <CA+BST0=Ntw_W_57uZ7DqLLFhxs9fvFsGBOiKGiZvy7GFwwubHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri, 17 Apr 2026 12:43:07 -0400
Kishore Padmanabha <kishore.padmanabha@broadcom.com> wrote:

> > diff --git a/drivers/net/bnxt/bnxt_ethdev.c
> > b/drivers/net/bnxt/bnxt_ethdev.c
> > index b677f9491d..bb02a2579b 100644
> > --- a/drivers/net/bnxt/bnxt_ethdev.c
> > +++ b/drivers/net/bnxt/bnxt_ethdev.c
> > @@ -652,8 +652,9 @@ static int bnxt_init_fc_ctx_mem(struct bnxt *bp)
> >
> >         max_fc = bp->flow_stat->max_fc;
> >
> > -       sprintf(type, "bnxt_rx_fc_in_" PCI_PRI_FMT, pdev->addr.domain,
> > -               pdev->addr.bus, pdev->addr.devid, pdev->addr.function);
> > +       snprintf(type, RTE_MEMZONE_NAMESIZE, "bnxt_rx_fc_in_" PCI_PRI_FMT,
> > +               pdev->addr.domain, pdev->addr.bus,
> > +               pdev->addr.devid, pdev->addr.function);
> >         /* 4 bytes for each counter-id */

Rather than silently truncating, it should return an error.
