Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1D3CCF9F0
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 15:53:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E46E84025E;
	Wed, 29 Oct 2025 16:53:23 +0100 (CET)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mails.dpdk.org (Postfix) with ESMTP id C125440150
 for <dev@dpdk.org>; Wed, 29 Oct 2025 16:53:22 +0100 (CET)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-79af647cef2so61917b3a.3
 for <dev@dpdk.org>; Wed, 29 Oct 2025 08:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761753202;
 x=1762358002; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/+kpD3qhyl2jgE+4g1Jth220B3KnTFfJopSPtZ1ljtc=;
 b=lY6lT3B29CdegrH0yKv5hQX0RJkJCYUjMadF/GcoMuQE7c/DevpM2Lukw7XkuUQMCK
 UcCEBWqWUI7QO9OFj6CLo8jR+5CgJoEWDTgVwj44ZhCs+xx/z3tMe3LKEt45Dosdo0nK
 1gYJPAZH0JhpUmy07AQdYh7zuIdoDqb5xUEu6wkMv2qEH7UBATOlhX+j6G4LaWaRBQ1B
 7lcf5b1lS4cA7ipY1/ORHtwPYFzY4TpLDc3AR8afQ3aHLxpUgsFSjsWLdeWsW/ny4a7a
 Vw8w7QZBHgRCT+ewxPFC85pD7ihED+vmZaFvKcjzVHBs69MXWMXWY1IjBQ395tNGpvrV
 Nx7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761753202; x=1762358002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/+kpD3qhyl2jgE+4g1Jth220B3KnTFfJopSPtZ1ljtc=;
 b=pdD/iwAAmc//q3N29XUeh6wvl3cLQHNDGCg6y4GF7X9rwVK7Fip8DRmLAmRYP4t9yx
 Zc9+vpLp4iY8D1uiPexKcgrCKwkLN/EWXo6TaTJl7DodTgI8antBUzukj1iCMZz40+OH
 AzfmMgfcAg4oMKNJ/OsuoTqj9+uKtpeQG/ea9t39io+EjtI1rh0qE32L6QbLew2rO3r4
 SPsTmrYhuuV0jBWb4n9xVY9YEJ6pG7KcT9fxom/YK1YqtZblaTCX7806rqgwixiuPHBN
 0x5twkzqhPUlguqXvwuK5oSouLAp6hNTXarS1hel9Y5arb1Z13iJn5UO8+z4cS3XVX+7
 oMRQ==
X-Gm-Message-State: AOJu0YwhPZ0WMa/y7vDIm4U2/vVz9zZumiU5+dS3pt+t813tW78lbh2J
 RheG/w5Rqq2QlP7izx30GvQViEbX2HL4y31JgMbuJEBxEIRziaJjyXbu37NlYFzk5JI=
X-Gm-Gg: ASbGncsvafYYPWeuWrHq2w5QEEukPU/302oePy3iqclicLhVVmxya+7S5qp5aUqGcI0
 09Rmxpkd/7NIv2+bsnNSI2vCgYmBq6kA7XK5EoQNy9hx4MVgYCJ7mDuLZ63lQCTK7bht4TUYu+v
 HU6p9DBEVGPs+jcYfyfsgutaw29k0zrcerKUqFtPF1ZPnhTjQhNtO66K31FLp6hfRGQPoNL6XYD
 GNcPiO8R4sy0ZCfNBbqgSbVXhZ9cZ6z2Cjv3pT0QFylnIqKIr0SKP237B6PI3FzzGdvO/TWfW6U
 ZempZLPp1/OxJ4hWdWGbwpcVvEf1DAEphJowsDcyxgAJDYIc8L11CRQ6LB68gxnIVIlOrnAZbAc
 C6+ej/ajcrv0rr6Wi34sLK4Aio2HzGpsy0YgszWozlrLlYFP4uxVGz+4W/hg+9Q/CpTZ+PhJy5O
 GPiOliCelGDZuIjQyT9d45EvphDI6FeWvSRA==
X-Google-Smtp-Source: AGHT+IEqAKAk6/W9r+Pe9PL3j98R4/HLfRcunDJQCL5RQtXFh9Q5XQMzePxSNzw8ZAbPvWqBJbId9g==
X-Received: by 2002:a05:6a21:3384:b0:343:70a2:bca9 with SMTP id
 adf61e73a8af0-34654128d42mr4207842637.53.1761753201705; 
 Wed, 29 Oct 2025 08:53:21 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b71268be14asm14091531a12.4.2025.10.29.08.53.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 08:53:21 -0700 (PDT)
Date: Wed, 29 Oct 2025 08:53:19 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Howard Wang <howard_wang@realsil.com.cn>
Cc: <dev@dpdk.org>, <pro_nic_dpdk@realtek.com>
Subject: Re: [PATCH v2 0/3] net/r8169: support multiq and code refactor
Message-ID: <20251029085319.4e745d41@phoenix>
In-Reply-To: <20251029020838.401035-1-howard_wang@realsil.com.cn>
References: <20251029020838.401035-1-howard_wang@realsil.com.cn>
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

On Wed, 29 Oct 2025 10:08:35 +0800
Howard Wang <howard_wang@realsil.com.cn> wrote:

> Howard Wang (3):
>   net/r8169: support multiq for 8126 and 8127
>   net/r8169: simplify config method check with if
>   net/r8169: fix issues reported by Coverity
> 
>  .mailmap                           |   1 +
>  MAINTAINERS                        |   1 +
>  doc/guides/nics/features/r8169.ini |   3 +
>  doc/guides/nics/r8169.rst          |   2 +
>  drivers/net/r8169/r8169_compat.h   |  10 +
>  drivers/net/r8169/r8169_ethdev.c   | 212 ++++++-
>  drivers/net/r8169/r8169_ethdev.h   | 149 ++++-
>  drivers/net/r8169/r8169_hw.c       | 607 +++++++------------
>  drivers/net/r8169/r8169_hw.h       |   3 +
>  drivers/net/r8169/r8169_phy.c      | 239 +-------
>  drivers/net/r8169/r8169_rxtx.c     | 930 ++++++++++++++++++++---------
>  11 files changed, 1230 insertions(+), 927 deletions(-)
> 

Queued to next-net
