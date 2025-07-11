Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E9EC83F1B
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Jul 2025 14:55:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC7E5406B6;
	Fri, 11 Jul 2025 16:55:50 +0200 (CEST)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by mails.dpdk.org (Postfix) with ESMTP id A90894025D
 for <dev@dpdk.org>; Fri, 11 Jul 2025 16:55:49 +0200 (CEST)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-7d9e2f85b51so226706985a.1
 for <dev@dpdk.org>; Fri, 11 Jul 2025 07:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752245749;
 x=1752850549; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vVWDa5ouYfiVCjlakGVpnTWP1VGCgR1NXexWRCFgdSo=;
 b=r1d7umWCrnNNE8f1iruLgrNHNLDFQ0+hKEEb1covxBTdW+G4EfTZMPZa1Sv0Cv9HqX
 1yaxGbDQGoIqmFCjHxk54Ou9tMc5ep4O49vgOap4af+nEq8QO1m7IWP9/k3onbYSBBlT
 xq2peZHi+yH6OxgPu2B72I9OlGCPXPkn0VYLaDGTB7RXFu2fa5nSVS9afymc3axYEffv
 vz9xO5/VeI5z2o4ZVUoL9aGGO2hXn2MS5laNftOlp2gQND+DjETBYOTnjli6sjz6vbVI
 Fzb2n4UQz2XuywlUq6/rbbhWGXQwZjWbVtqzyRP/42eB+OFsQDrRtlIAt7y2GW98UoO9
 hpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752245749; x=1752850549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vVWDa5ouYfiVCjlakGVpnTWP1VGCgR1NXexWRCFgdSo=;
 b=VMyYCfmhz17fIhnzTqBeFEjO34vDdnwBoGJr171HeiluazMRFz8Bq3kO4iGQ5VMPej
 djXoN9CG+KwX7T0nRM+tIYOfetbLTV7elEvfAuuWkDhRiOjybopMpHclgIbfmf3aS5Mm
 Ph6D9DAzyiPjdnQ4IdbBYKk1RD5DKryhNvOc2sZGQYF2DBoE03K2PlNaxrFBv7J9BiwN
 MB0RArYRxL21AfOHpSM/q4W8AOm0P95FihLg0XfhmmoSy/Gcyn+Lk/ycde0ZymZ5voK3
 19sJwIKIM0obvVpPZiEOSyjuRlIivDKjwzEZkYHgD3u5bMskxnTxV4c1vp5tUulud4Xi
 cN6Q==
X-Gm-Message-State: AOJu0YzbEAjntiiTNX1NN5pilA3lAmXUuFcHyPWEGLZx9ItU6d/aXxh0
 xpIJPI7wtY7duer0LCEeOgXlGUF5NZMI+6hX4R3uahI5+Wo93ASHqrxdqS7W4LxC8YY=
X-Gm-Gg: ASbGncvvn3pBuYtz2JjWLAeFOIks/QjyR16GzatfwNU+9fx2ttFFSVNnmHIf5vC8UwQ
 +X4Lcjb337yzk+C+nlpplkGFf0cq99LCsbhPye8npUPUk9JStnJR6ScCDNL3XvOoROzupGUPJjW
 iJMVLdLKnFf/LnQ1W/j25jtsL5XJTVvqIznlSYmeJLZP8iwSN0HVtpb9Za52sKtdOXErxTc57qp
 O4TUeEkBOIapuCKylmT13s2/tIo39Mp8cL1+haDwDH6v+5T6yzcS1Etq8jLYzCS9kNR274NFosC
 5yk4rK47U/tx7bCQgIIkIBfDuDmHjhchJ+KZjUeXllrbmp/D0tPAZqRfqFyWMCShBmZQ7FuwVYC
 inY/4WD/Ve/GfEEylece2bYr3d7docsmOH11xKG9zb4tnPoSvELc0UT2YM2xxtDyBoPnn2sfOtp
 s=
X-Google-Smtp-Source: AGHT+IEBErzYGEx6AK0fi/T4fQ+Pj0pLOdkkQCq3IjAi97SQ2qJHI4P5xCGtVIZVywlM+T8r9GagKA==
X-Received: by 2002:a05:620a:3911:b0:7d3:ffe6:8397 with SMTP id
 af79cd13be357-7ddebc94befmr602390285a.34.1752245748786; 
 Fri, 11 Jul 2025 07:55:48 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7dcdbb0789asm230204885a.10.2025.07.11.07.55.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 07:55:48 -0700 (PDT)
Date: Fri, 11 Jul 2025 07:55:44 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, Andy
 Moreton <andy.moreton@amd.com>, Pieter Jansen Van Vuuren
 <pieter.jansen-van-vuuren@amd.com>, Viacheslav Galaktionov
 <viacheslav.galaktionov@arknetworks.am>
Subject: Re: [PATCH 0/3] common/sfc_efx/base: fix compiler warnings in X4
 netport API
Message-ID: <20250711075544.2fbbd18d@hermes.local>
In-Reply-To: <20250711144349.9236-1-ivan.malov@arknetworks.am>
References: <20250711144349.9236-1-ivan.malov@arknetworks.am>
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

On Fri, 11 Jul 2025 18:43:46 +0400
Ivan Malov <ivan.malov@arknetworks.am> wrote:

> The 25.07 release has got support for AMD Solarflare X45xx adapters [1].
> This series is a follow-up to [1] to fix compiler warnings in the base
> driver that are seen in Windows driver build, also based on this driver.
> 
> [1] https://patches.dpdk.org/project/dpdk/list/?series=35095
> 
> Ivan Malov (3):
>   common/sfc_efx/base: fix compiler warnings in statistic code
>   common/sfc_efx/base: fix compiler warnings in PHY link setup
>   common/sfc_efx/base: fix compiler warning in PHY link getter
> 
>  drivers/common/sfc_efx/base/efx_np.c       | 7 ++-----
>  drivers/common/sfc_efx/base/medford4_phy.c | 1 -
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 

Have your tried enabling -Wshadow and -Wduplicated-branches and -Wduplicated-cond
Those flags are finding stuff in other places.
