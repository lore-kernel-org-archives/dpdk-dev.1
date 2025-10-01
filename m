Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0037CCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 14:23:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1E0E40DCA;
	Wed,  1 Oct 2025 16:23:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 93F40400D5
 for <dev@dpdk.org>; Wed,  1 Oct 2025 16:23:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759328604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IdgvSWhSamg2TWlV22HawEPQ9+0jnGWGEQncuCNcuFM=;
 b=HuJcaDRatTRd9F8JvqLAuZtAKGAMceG92ju3tNoFWh0zGfNPIAPaAav271UzRxnoChD5Pn
 vfiNyS5qbi7KYjuEbvs1OHRU0pQmlBNH9SS9OoVbcb2280W4UWKNg6NngSN8fiyGBi1nsZ
 zQ9p9XEIspI42rSx5STwVV3QE3ysCSk=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327--U-6vzXaMVC1sIlXboV1Fg-1; Wed, 01 Oct 2025 10:23:21 -0400
X-MC-Unique: -U-6vzXaMVC1sIlXboV1Fg-1
X-Mimecast-MFC-AGG-ID: -U-6vzXaMVC1sIlXboV1Fg_1759328600
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-36af4d383feso51923801fa.2
 for <dev@dpdk.org>; Wed, 01 Oct 2025 07:23:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759328600; x=1759933400;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IdgvSWhSamg2TWlV22HawEPQ9+0jnGWGEQncuCNcuFM=;
 b=ItzSkN7I8wwZ15VPZZhZvd8HLEw19Xda2NRiXER+OXP4hQ+Y18ZU2BwVGfFESRsnoo
 21bPkGs4doAo7aRG30texxFv2Y0M+ZqkAhIcQLpLeue4uXvUIcemmmg85DMb0c1L09MH
 ItjUNa87Yyw9UprcdwqRTZ862DY44YDTO0p0DyWrxxZJnReaYiFBaeDauQA20h3HOiqe
 vev/HtKjTDktN+zOYmUOZpC/nUkWqG52/G7ZniZzOmPJWW3t5fPh+ZYlIOOFY6L3rpFn
 Z6cySOpLq+GwQsZDoacdufEdOyyfltqMqwvS0LwS0f9Mz2GSTaEmvkwmHbRM8VNyNGBK
 n7bA==
X-Gm-Message-State: AOJu0YxI69dgHB8vsg61ocx1Kcs7JR6ts/kyttvAG3GPujVdnsDGLRH8
 l5Dj6x7QO0lwbKChbbYnG6wNkP+qPxg3WGwTtUF1ElpS1fP3lR26ngE3GDJkPFQDfBVqUxor95n
 sMzGpFD0YtmXVxlGGSOL0e7gkNf0UJzrsDAQ7wbEo2X/GunYYhvBdeUKh2TDYDUj1CRwqb2yJKS
 FvDZSPQG5jQOtupNT22x4=
X-Gm-Gg: ASbGncspVnM/3iKD4G7SvU7uxAFYF58afn0Tl+jja4rHNhzrxk9N0r5chQirXXUr+9X
 DZlUTzn/c0in0va3UZl5QWt0kaS3DJcSKS70j1DWqF+SLzl0Xm2wTnrrhRwvQMwcIa93wFx0BMa
 NkA8I4gH8Z+hXY1BX/BofYrZkHM+VQ
X-Received: by 2002:a05:651c:548:b0:373:a5ad:639 with SMTP id
 38308e7fff4ca-373a70e3f74mr10151591fa.8.1759328599987; 
 Wed, 01 Oct 2025 07:23:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA4WYsq+D646c/RcZ4wb4/4jctf/fYphdSXVuJyI9CKFuNTRx43OIKBYkH+WM15lRiG4syI0K8JjHkZmfx7E4=
X-Received: by 2002:a05:651c:548:b0:373:a5ad:639 with SMTP id
 38308e7fff4ca-373a70e3f74mr10151411fa.8.1759328599451; Wed, 01 Oct 2025
 07:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <20251001081825.2638077-1-david.marchand@redhat.com>
 <9acb2557-1f42-4880-ba93-020b14e6a0f5@intel.com>
 <CAJFAV8ynhCwV76W+1QVwDrzXFLiRWv+x9FiQkCGq+fw2f0CLJw@mail.gmail.com>
In-Reply-To: <CAJFAV8ynhCwV76W+1QVwDrzXFLiRWv+x9FiQkCGq+fw2f0CLJw@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 1 Oct 2025 16:23:07 +0200
X-Gm-Features: AS18NWBKZQ90r2Y_oegby4tSZ0EyBmdaZLjXM5ej0xwjcj58WLM6x4bPf_YucYk
Message-ID: <CAJFAV8wcEgvqdCiPefmxUSyP=QjfYoWiJ846EZKsDDnwa-b45g@mail.gmail.com>
Subject: Re: [PATCH] ci: configure Coderabbit
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, rjarry@redhat.com, Aaron Conole <aconole@redhat.com>, 
 Michael Santana <maicolgabriel@hotmail.com>,
 Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: soBDz_Xxta8jW73sVIg-XM5BlcfkNvAmPEhMFOm_J10_1759328600
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

On Wed, 1 Oct 2025 at 16:12, David Marchand <david.marchand@redhat.com> wrote:
> On Wed, 1 Oct 2025 at 16:04, Burakov, Anatoly <anatoly.burakov@intel.com> wrote:
> > Can you provide a little more details on what exactly you are proposing?
> >
> > On the back of this patch, I installed CodeRabbit in my IDE (VSCode),
> > and did a review of one of my recent patchsets - it's quite interesting,
> > actually, and the comments provided were basic but meaningful, alas the
> > free version is limited to like 1 review per 30 minutes or something so
> > it's a bit limiting. On top of that, I found the tool a lot more usable
> > than GitHub Copilot reviews, which are attached to GH pull requests
> > rather than Git branches, and they take a lot less time to boot, so I
> > feel like this tool has potential.
> >
> > That said, I'm not sure what this patch is supposed to do - is it to
> > have it set up to review patches automatically?
>
> The ovsrobot creates pull requests in its dpdk github repository, and
> Coderabbit and sourcery are invoked on them.
> Look for a link in patchwork, under the name "ci/github-robot-post".
>
> For example, this exact patch got a branch and pr in ovsrobot/dpdk:
> https://github.com/ovsrobot/dpdk/tree/series_36267
> https://github.com/ovsrobot/dpdk/pull/124

Btw, you'll notice a bit of noise, due to how the PR is created
against ovsrobot/main, and not the exact DPDK main branch at the
moment the patch is submitted on the ml.


-- 
David Marchand

