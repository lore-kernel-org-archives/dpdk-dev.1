Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776B5CAC5AE
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 12:50:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B144140664;
	Fri, 26 Sep 2025 14:50:06 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id F3D0B4028F
 for <dev@dpdk.org>; Fri, 26 Sep 2025 14:50:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758891005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H5YofyCbr972ZF8eHwTiNiMZzb0tl7WOhxY03hj8dJY=;
 b=SYUFlJhcJj/20dKuVIV9ksmGz8QIn2iH5Jr30RuDYyHaoz2AC6R4kIwlJKSMIO91gwltKi
 N1O4KBUe1w036RSbjfWqQiai2ahMq92mWvyix+M0TO5iG8Wuh5cTxjpkHtCBKL//mrebTF
 mv415Jtur8pjerorXjMO6w6bwBcE3lA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-gH4Z4mR9OzO0JAjZkPpflQ-1; Fri, 26 Sep 2025 08:50:02 -0400
X-MC-Unique: gH4Z4mR9OzO0JAjZkPpflQ-1
X-Mimecast-MFC-AGG-ID: gH4Z4mR9OzO0JAjZkPpflQ_1758891001
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-36c983e4c21so12081881fa.1
 for <dev@dpdk.org>; Fri, 26 Sep 2025 05:50:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758891000; x=1759495800;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H5YofyCbr972ZF8eHwTiNiMZzb0tl7WOhxY03hj8dJY=;
 b=nxHGNMfsv1M+qU/phDnRS23U91YHBfMm8vidTNP7LYTsyUawycAbha66agxoLOdzEx
 4cxC8bNr5Uazk3gA6mLHZAkniJIcFXNo0k+D9+2uJCVv/DrR2CBtgIhR+PuOA8rABQ63
 9m+kCinCkv1EnqrubalK2V+C4N2HGTaTNndp7Pme4bkPVrBofPKXHSQnU4eyTjWbJU/D
 fmr9ppuBBsV0tSnq5HZBlFKt0Ym6paPSJAu6GNBVIXR0M3KLAemEOOKwnoTmvpFbWk6h
 n/pnCzxBJwpnNiqsMFKOZ/0oYn196NvmEjhBJZ5hkw3H8ZWfGO8ro75oTyeC+rYIX36R
 GVug==
X-Gm-Message-State: AOJu0YzJV4s6BZYioey4y16KHzQA/JOeb8dQ+Gwzh/15DWGjhgkTMR1T
 4qU/7sSzq2j6RjIvPbzesfKu6QUoWwBYSy5fCV7bQy0C3z4oyvQ+O/bPsjEokFfzy6YiPnyYV3V
 gDAKulEDCjDcYk8HuUI4IoDPYw7dnYVYs+YHzjTc4G7IaYwRbL+7098+F2DjrIU2fKBGaMMggfd
 5cdfmZiAyWRi4/qnt7auojWAxzFHj+Xg==
X-Gm-Gg: ASbGnct4kDa0WsoXi5eba6r5fCTiA73UC5hxHKiVq3LS0I+kCWbwjCmF42NK2tQxjbg
 mQTZr5UKGgzZzvPTI0FzjeV5UXDg/Cob3LSJwLd4CcNJhG/ARjC5Qtd+tRSnYirfrEesWF52AHy
 WheewwqKzOAFpteF2mbIszsDA=
X-Received: by 2002:a2e:be1b:0:b0:36a:6c51:18b5 with SMTP id
 38308e7fff4ca-36f7ee63d77mr30079241fa.33.1758891000433; 
 Fri, 26 Sep 2025 05:50:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMwb1a/w0xhIaz/O5Q0Gz8GVEmXostQi95fJR9cLLVt/50D3UKvn3PSfYpeNthh3RwTA0CowOXTs7IktcMagw=
X-Received: by 2002:a2e:be1b:0:b0:36a:6c51:18b5 with SMTP id
 38308e7fff4ca-36f7ee63d77mr30079041fa.33.1758890999984; Fri, 26 Sep 2025
 05:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250925130438.3072610-1-david.marchand@redhat.com>
In-Reply-To: <20250925130438.3072610-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 26 Sep 2025 14:49:47 +0200
X-Gm-Features: AS18NWBbzv1lPx0MG9-nXt2Xv1DZiURXoS9DLS8mUezKRMSEpRi4qNEW3-k_a6M
Message-ID: <CAJFAV8xVEoKfsTJTwZeXbr63vn4BcRKg4XadEaWSaEJEMcmkuw@mail.gmail.com>
Subject: Re: [PATCH] buildtools: prepare symbol check for Windows
To: dev@dpdk.org
Cc: andremue@linux.microsoft.com, Thomas Monjalon <thomas@monjalon.net>, 
 Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gTiVo7sS9rP6P5acvjjJLgcWKmsR9MnaYwkSuSexuXg_1758891001
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

On Thu, 25 Sept 2025 at 15:05, David Marchand <david.marchand@redhat.com> wrote:
>
> The symbol check was implemented so far with shell scripts, relying
> on objdump and other unix tools preventing it from being run on Windows.
>
> There was also an ask from some maintainers to convert this type of
> developer checks to python scripts, to make it easier to extend and
> maintain.
>
> The new implementation still performs the four consistency checks:
> - symbols exported as experimental but missing __rte_experimental flag,
> - symbols flagged as experimental but missing export declaration,
> - symbols exported as internal but missing __rte_internal flag,
> - symbols flagged as internal but missing export declaration,
>
> The initial implementation was done relying on Claude Code
> (asking it to reimplement the existing check after it analysed
> the current build flow).
>
> I then cleaned up the python script, removed dumb comments, fixed coding
> style, fixed MAINTAINERS, fixed some dumb issues (like definition order in
> buildtools/meson.build).

Looks like trusting Claude on the python subtleties was not a good idea.
A v2 will be needed, but this change can wait to have a real user.
I'll mark as changes requested in patchwork.


-- 
David Marchand

