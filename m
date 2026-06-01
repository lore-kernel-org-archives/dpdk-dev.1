Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14365CD6E56
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 10:23:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23F294025F;
	Mon,  1 Jun 2026 12:23:21 +0200 (CEST)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com
 [209.85.128.170])
 by mails.dpdk.org (Postfix) with ESMTP id 142E74025A
 for <dev@dpdk.org>; Mon,  1 Jun 2026 12:23:20 +0200 (CEST)
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-7dc6fbf3e86so46597537b3.3
 for <dev@dpdk.org>; Mon, 01 Jun 2026 03:23:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780309399; x=1780914199;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5vMWfTc9l7yHSM76mkR3Eu7OqPvsrVWdDjROdewFdoo=;
 b=PG9/2DUr5y3vkZmWOc7g8pY8RPlHSzvBCPfMcv/8tFe9mQser8s2oMmCB1S/bWB1ig
 /2Mjq4Fr4ajzqA87Eor7l5iTthkXcT1ocw90AhGRfWXXs94NG2x4lFqFgbn/jd1jb21e
 uuVH29rzeiW70kBbbM/yF1zr9gWfms4uKaTdYNtJIgmVHtV2qUJuj5aa82JCh5K1ZryL
 1KJNtK1EmB9oUy6sk43Bh3mw+AYcgKvuPL+epQPGk4jeh3C7/yHz8Grf9asKpgFn5o0O
 tV3+YJ9C1tcR3dbhmecx3o0UaU8zUKecMrS6RomkVilkVHbLtzOziW/pwHFCKwVkLBUC
 RGMw==
X-Gm-Message-State: AOJu0Yx2ikR2KC/jpUbQ3e+VBuf4vZZ2xqLGzYNRLok1iSX8x5rpg6vs
 yHjkjPSWDmSd6wPU9itWzhv5VZd+vi5GYTPbGCENkcLqoIRY6RsFyhHbjq902KlK
X-Gm-Gg: Acq92OF3AS1Zfpn7rSr8Zh0qiKWLDa91ehOiWfy5UT8rczyHXWSAs3NZ4x2ZX1PxntS
 F7src4X0daCexxYT9z7HSxt0E1LQXYAP/gHSjPSjUFzxcNMiR2MAsnjoeu075QpVfFpCzu2CZLN
 ioIkJHLnXc0QyWcMg15SgmWBVauN2V/DsxM4q6aNwRwNWGl+kEjdUWJDQH0dQm7XLAm/J+SvX0D
 7yWNy29YaAwsJcvcHK4Hmj3++GwZdbjhhHxkv/pbKZTcU1pf36FfWj/pajJ3f3yBHwPlmSYdJdM
 /C9k/VNmo5xu5WPG53tBETuQCX923lXWkC7QfUOfasCwiyGaoYGNTTsyyIOBbIxuR7DVI9yUv+g
 Hz9ue/trcWt2npuvf3Y4rRmLu6uZUlj9cGpoMN8uWyaJ715jjvK6TugyYh36jjgkwqx0alakY8E
 r1VzeSKC0bMb30182UaIlNdPQu4DtND60wgT8/9WRCUiLhtrTjYF2XbDjTHdD6NVRh76o2Eg==
X-Received: by 2002:a05:690c:e3d3:b0:7de:71bd:6811 with SMTP id
 00721157ae682-7e0615fc753mr89363197b3.43.1780309399271; 
 Mon, 01 Jun 2026 03:23:19 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com.
 [209.85.128.181]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-7e17bf00938sm36761997b3.36.2026.06.01.03.23.18
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2026 03:23:18 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id
 00721157ae682-7dc2b658544so31799347b3.2
 for <dev@dpdk.org>; Mon, 01 Jun 2026 03:23:18 -0700 (PDT)
X-Received: by 2002:a05:690c:7006:b0:7b3:b0a6:2c76 with SMTP id
 00721157ae682-7e05cb4194bmr82591157b3.18.1780309398676; Mon, 01 Jun 2026
 03:23:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260531180118.274308-1-stephen@networkplumber.org>
In-Reply-To: <20260531180118.274308-1-stephen@networkplumber.org>
From: Luca Boccassi <bluca@debian.org>
Date: Mon, 1 Jun 2026 11:23:07 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnRB+wv7ZN6c5YkF=LfTB328uYcBmf=xCqjTU8hSjzuVZQ@mail.gmail.com>
X-Gm-Features: AVHnY4KU0klroxoQ8pbM_rDoy_kzFx530RAPJ-AZYkMZ3DVYGmo_baPrwitoGK0
Message-ID: <CAMw=ZnRB+wv7ZN6c5YkF=LfTB328uYcBmf=xCqjTU8hSjzuVZQ@mail.gmail.com>
Subject: Re: [PATCH] test/latency: fix intermittent failure on slow platforms
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, stable@dpdk.org, Reshma Pattan <reshma.pattan@intel.com>, 
 Bruce Richardson <bruce.richardson@intel.com>
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

On Sun, 31 May 2026 at 19:01, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> The forwarding loop was bounded by a fixed interval of 0.5ms
> but on slow or emulated platforms with a low-frequency timebase
> (e.g. RISC-V rdtime) this fails because the loop only ran once.
> The test needs two iterations to get any samples.
>
> Rearrange the forwarding loop so that a minimum number of iterations
> are required. The loop still has an upper bound on packets and time
> interval which is expanded to 10 ms.
>
> If no samples are collected, mark the test as skipped.
> Refactor the forwarding loop test so that cleanup happens on
> failure.
>
> Reported-by: Luca Boccassi <bluca@debian.org>
> Fixes: b34508b9cbcd ("test/latency: update with more checks")
> Cc: stable@dpdk.org
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/test/test_latencystats.c | 75 ++++++++++++++++++++++--------------
>  1 file changed, 46 insertions(+), 29 deletions(-)

Thanks, this has been failing consistently in riscv64 since at least
25.11, hopefully this makes it stable.

Acked-by: Luca Boccassi <luca.boccassi@gmail.com>
