Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA52FC531C7
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 08:55:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B08CC40658;
	Thu, 23 Jul 2026 10:55:03 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id D3C3F4027C
 for <dev@dpdk.org>; Thu, 23 Jul 2026 10:55:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784796902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cliC9DLffvVCdG8cw+ioYvfBdLgP3LgxFxkCN7G5NBs=;
 b=KQznTVIUHmSy2LHfVHOtuPngBrwrZu3VvPYgw6Aisj1jRuzLOXMZ3FTvpyn7xqp0hPFve5
 6Ik7KO6JFnw+fc9KU0tony0YBcc9n8GXJdhsh0Repf3qso95A98WxU2PIns0APaPoo0MJC
 LWcIKtetFtLvtv1GfHt9Ew4S4P+qJ0g=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-Q4kljekxPrWfgdzXyDrxwg-1; Thu, 23 Jul 2026 04:54:59 -0400
X-MC-Unique: Q4kljekxPrWfgdzXyDrxwg-1
X-Mimecast-MFC-AGG-ID: Q4kljekxPrWfgdzXyDrxwg_1784796898
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5aeb8c3f9ceso276523e87.2
 for <dev@dpdk.org>; Thu, 23 Jul 2026 01:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784796898; x=1785401698;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cliC9DLffvVCdG8cw+ioYvfBdLgP3LgxFxkCN7G5NBs=;
 b=A1hkeY2f/aVinY+qCnzAbyYEHCIcEVxpgcIG52O6kp7LMjI+qLkdkIgHPsBIuqUuzk
 fOyNiGKRkQXSj07zbmbn4CDlhmnw4ubiujAgpDx8TJQ52/n/tgDLlKPT5MjYM207m9Xj
 FoJ9goAMcdGJHUsM/3NBVIclVR2ZXP+1VQiMA3Oza6+mm6PxnwDfHjD87LnBLFzYQ3nw
 XmFYMR2DvVZqxvQwbbrcLbUBtPrSXNrCnn0CytID2wwBRBYH11kCuue3rwqcAZtOhlDd
 oBErJpgTU7T1SycuFsKe8KZMq9bLOJlhGCy27wzOQzlC2w+yscl1H7MwA+mYukWAdemk
 Zjsw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqdXyMxSZIjl0cGTmcNiDu4/sCVB0NU3BNOspnVe42OozMYK6fPz4mBqQ/KnfnfHMi78S8=@dpdk.org
X-Gm-Message-State: AOJu0Yyioym1bKoVL3b8HqCDjI52iRoB10ePAXH7ByKvOiZkZFVcya/t
 yjFbHhMc/tyLgIS428XajpR7BrsHC2+8Rt4KXLP28tsdsH3mVarzcUxmAbT1NrSukWls0oSSp+8
 LC9f1RPbeOgoXfFqIA6/MlVpg4kk5zmo6AXHXuCnAUbjWme0iG1tIkWxPNeZlni5R9S6FK7yxC9
 YX6pmv/NlQAkhv4jipiGH2SVVlm/A=
X-Gm-Gg: AR+sD13ZJYEO+HCxQAYa3VQ+HCwg2Le49nlxAIrS/ZhwS2cD4nDQWuoZOxcg8H3OdbZ
 7S2gLTUgyCXj564BJeIQyh7em5HxwgzsWi4vR9vnDRLIrjHMwz2bYp6GjW3HUSDJSKcPyj/mFzF
 HQe42Q7dkXlaIUxgavEwYTLtQ3zh01A2cc9/oasi4QjDhgWSuOKt6q3iRajbvXuPLY038GmwR8x
 OjEYq6BcLBQgQCsmEDGVaka5F7rlDzmJnOklNeE9G7YfIzH
X-Received: by 2002:a05:6512:1287:b0:5b1:56db:b069 with SMTP id
 2adb3069b0e04-5b2b2f74216mr475422e87.54.1784796897893; 
 Thu, 23 Jul 2026 01:54:57 -0700 (PDT)
X-Received: by 2002:a05:6512:1287:b0:5b1:56db:b069 with SMTP id
 2adb3069b0e04-5b2b2f74216mr475409e87.54.1784796897345; Thu, 23 Jul 2026
 01:54:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260713110101.24218-1-dsosnowski@nvidia.com>
 <CAJFAV8yZtx1kL8Jrfnwuyau4d6xrrZof=PrBadMMtM4p6aiGBA@mail.gmail.com>
In-Reply-To: <CAJFAV8yZtx1kL8Jrfnwuyau4d6xrrZof=PrBadMMtM4p6aiGBA@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 23 Jul 2026 10:54:44 +0200
X-Gm-Features: AUfX_myVZX91vhL1j86yGEy_WwkJMmqWVHR17PO3atDtHEKlROFR4KwoaSugKig
Message-ID: <CAJFAV8zPVw5sa_n21cxAyWnqNAzPKm4kvkK-TxCsvdMOoJ3n_A@mail.gmail.com>
Subject: Re: [PATCH 26.11] net/mlx5: remove versioned symbols aliases
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, 
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3AAcDy3xNBIsr6sfvhPH0I8ehgiAYzE33rYkSMm7YrQ_1784796898
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 23 Jul 2026 at 10:32, David Marchand <david.marchand@redhat.com> wrote:
>
> On Mon, 13 Jul 2026 at 13:01, Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:
> >
> > Version symbols added in [1] for functions:
> >
> > - rte_pmd_mlx5_driver_event_cb_register
> > - rte_pmd_mlx5_driver_event_cb_unregister
> > - rte_pmd_mlx5_enable_steering
> > - rte_pmd_mlx5_disable_steering
> >
> > are not needed after ABI version bump.
> > This patch removes versioned symbols.
> >
> > [1]: 556b2a33727a ("net/mlx5: add aliases for some promoted symbols")
> >
> > Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
>
> Acked-by: David Marchand <david.marchand@redhat.com>

Rebased on 26.11.0-rc0 and applied, thanks Dariusz.


-- 
David Marchand

