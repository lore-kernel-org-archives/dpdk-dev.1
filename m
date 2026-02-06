Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400D0EE2092
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 11:21:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 063804029A;
	Fri,  6 Feb 2026 12:21:38 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id C742840293
 for <dev@dpdk.org>; Fri,  6 Feb 2026 12:21:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770376894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K1Je+mdvWIknIPCO+smTtx+whghOghdfQ0dbGw0pB9A=;
 b=jOZferqoCMoIVfWf0JJj3e7QW5wAwYnHOtOzK6U+O2HZZwtYOcgxlvKn6OIpQxBsAEDhiQ
 LWlDCyrQPb0MX+h3LsK3kRbJKiWjwJui6kw7vz5g157tsJry69r0gZ3g4F7jJTBRYV+NLu
 0mS4Dked+ePWP+qGG2L3ojgO4/GdMt4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-xp7UDw9wOaOvN6YJ1KE6fA-1; Fri, 06 Feb 2026 06:21:33 -0500
X-MC-Unique: xp7UDw9wOaOvN6YJ1KE6fA-1
X-Mimecast-MFC-AGG-ID: xp7UDw9wOaOvN6YJ1KE6fA_1770376892
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-59b6fb01675so546704e87.2
 for <dev@dpdk.org>; Fri, 06 Feb 2026 03:21:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770376892; x=1770981692;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K1Je+mdvWIknIPCO+smTtx+whghOghdfQ0dbGw0pB9A=;
 b=MtmKbe1q83lJys95KpFVd2fw99wwQAKqYTzdgbbw0jHKP0lxaNFgQPPjKN49mp7KYd
 SMAEWEJHXDW0xf13zuQb6yWDzm0/H7vAgs7FK7+dk+PrJ29wGrLvAEDotdzGYBKgwDof
 uGiJ1OgGKnoHFp8tZbFMOB7QKzbT+RF/OF1iz6EmPgiV/16wELYr+4XGLlx1KUkzShIj
 3k1++/OTdAI+43O4POAMrbLxsAKqojUuxsTk4yVNeWlassYb8/BZJPf7GHOiNxbHoleO
 CC2vNE0xdvZy4eo6esF0EMCE+c/1g7DVuvvdR2b1zRvHsdUVR3BvgJ+Ne4Nds5/QALiO
 3zig==
X-Gm-Message-State: AOJu0Yy3D8I63sCQBT3LLrt37ns9F1yLk2sYomBz0fGfMarONDHacYG1
 RD1T9K3dnhxgOy8nBPqnntYrqONiPOjIbPSGB009xzKMYZJyS2XlIOApCHdl+noFJijf94HlEiW
 eApyi5ssqbbqr4Q7vUGlxGES8Os9jed3DI8qj4QdJBODUqPOEmVEdCLr0heOlNDjRfm+jtBat1m
 fBsqR4HqfS4Tkeiuqlk55bNzs95yU=
X-Gm-Gg: AZuq6aJ2qulWBnR56iax93zVxmEPimhFDTq8btwSDA9p5B2yMi74o7qWviC35Sk5aoL
 hxUDtd9Y4mRvtfsDTNAfmF8R03cGAe1cblyUr5fWRnS2I4Dog1B27QFO386E222lchjZIzHOZXQ
 yJsDBzg79bJAo/fvjmel53u6hbV11HX+tx3IcxUVA9fSp9k/Q6Jmgs1nFQYW4UB/seYxu2DXkwL
 qMWIyGbxzcn1lg/kkDwXrtGeMuP9aabS1KldHoiLhq1zbcM5dXPcNjglg==
X-Received: by 2002:a05:6512:31c8:b0:59d:e7b1:419e with SMTP id
 2adb3069b0e04-59e45041bfemr856069e87.11.1770376892218; 
 Fri, 06 Feb 2026 03:21:32 -0800 (PST)
X-Received: by 2002:a05:6512:31c8:b0:59d:e7b1:419e with SMTP id
 2adb3069b0e04-59e45041bfemr856056e87.11.1770376891636; Fri, 06 Feb 2026
 03:21:31 -0800 (PST)
MIME-Version: 1.0
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20260121210810.1044276-1-stephen@networkplumber.org>
In-Reply-To: <20260121210810.1044276-1-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 6 Feb 2026 12:21:19 +0100
X-Gm-Features: AZwV_QggsrbnEn9GMmcp873RgDRLq_3_XUyjQTSLwMm4iQHYbCzZIZAgTOFfBYA
Message-ID: <CAJFAV8z=+t2VT+GgR=Wnq241VTj+iLv+LoC+jOUN1vuHOjo39A@mail.gmail.com>
Subject: Re: [PATCH v12 0/8] test: fix format-truncation warnings
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pv4kYUbM12J-9JrZyRtraI2JR4AEOrZQ0TT0R3dBjUo_1770376892
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

On Wed, 21 Jan 2026 at 22:08, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> This patchset addresses the -Wformat-truncation warnings throughout
> the DPDK test suite, allowing the warning to be re-enabled.
>
> The changes include:
>  - Properly sizing buffers using named constants (RTE_MEMZONE_NAMESIZE, NAME_MAX)
>  - Adding a common file_prefix_arg() helper to reduce code duplication
>  - Using standard library functions (getmntent) for mount parsing
>  - Checking snprintf() return values for potential truncation
>  - Converting problematic 2D arrays to pointer arrays
>
> After these fixes, the final patch removes -Wno-format-truncation from
> the test build flags, ensuring these issues are caught in the future.
>
> Several patches are marked for stable backport where they fix real
> potential bugs rather than just theoretical compiler warnings.
>
> v12 - rebase to handle new eal_flags printf's
>
> Stephen Hemminger (8):
>   test: increase size of memzone name
>   test: add new function to get current file-prefix arg
>   test: avoid overflowing huge directory path
>   test: fix format overflow warning in ACL test
>   test: fix impossible format-truncation in cfgfiles
>   test: fix format overflow in cryptodev test
>   test: fix overflow warnings in common code
>   test: re-enable format-truncation warnings
>
>  app/test/meson.build            |   1 -
>  app/test/process.h              |  44 ++++--
>  app/test/test_cfgfile.c         |   8 +-
>  app/test/test_cryptodev.c       |  22 ++-
>  app/test/test_eal_flags.c       | 269 +++++++++++---------------------
>  app/test/test_memzone.c         |   2 +-
>  app/test/test_mp_secondary.c    |  14 +-
>  app/test/test_pdump.c           |  13 +-
>  app/test/test_table_acl.c       |  30 ++--
>  app/test/test_timer_secondary.c |  12 +-
>  10 files changed, 174 insertions(+), 241 deletions(-)

Series applied, thanks.


-- 
David Marchand

