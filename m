Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48E0CC6B34
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 11:38:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13A1B402E4;
	Thu, 15 Oct 2026 13:38:37 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 17530402DA
 for <dev@dpdk.org>; Thu, 15 Oct 2026 13:38:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792064315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NMInzKxgxRAj0QHj2AEYLziHw/c00U1828+tGAH5N+A=;
 b=dyKDd6yNe6mX0a0Ul1vs2lOwANxwSfxmEWSXk5W2KI00S2mVt92d30/8P3AJYqoPl6LH3z
 a+wB+vwszJa+u9MnRZwOt8DoKio28OM6FZqbe+5ZBYP1hH91aBoG/im6EkODCKMJQB2EIf
 a4EPy0JBR4C5uNmV0UCNdR/vcDp8n3E=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-ZYFOUbzJMy6oYeYsBciaQw-1; Thu, 15 Oct 2026 11:38:34 +0000
X-MC-Unique: ZYFOUbzJMy6oYeYsBciaQw-1
X-Mimecast-MFC-AGG-ID: ZYFOUbzJMy6oYeYsBciaQw_1792064313
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5be3d12d10fso522294e87.3
 for <dev@dpdk.org>; Thu, 15 Oct 2026 04:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792064313; x=1792669113;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NMInzKxgxRAj0QHj2AEYLziHw/c00U1828+tGAH5N+A=;
 b=xSkQIjSVItcDvPNzQUqKvL0KxCZh3QkyVZ3h+uoCsLUjYnYtfSJ46QIAlIt5XWAr5s
 9UAi4OsAj+7g8viwqH5a63zZDtTtxWPfHVNrd9uPPWqgIje/DOZzvajomPgG67noEeLC
 ScSlJWeGvTH2ayPmMbdoLklKQiOG7TZBq1es6+csiLKreooEk/OWY4e5nEiUFhWpaFAQ
 OQo/q9JJJkyCzJgISp0YeEVH4yWexudmRc6TbtZgQIE1yUJc7FD9lgqcnX5jFRzzpiOg
 tho/IdnBD8vW8qcu9Qn8stELjAZ3CQ0hdd/sOySrZZcyNKf484jeQwwhyzkBPnJ9LaWN
 Q5TA==
X-Gm-Message-State: AFq9FYK1oSiHoWzRiJpG/JuaKwJHjiggVWHcwYuJWPyG2+NcaQLHv/0b
 rNczk12F40A5KSf23TGAvXDpNm09kCU0MP4Za067fvoL5cWcndd7HzgEyAZLZ2WSUefquU2hGgs
 S/Zud6a9GmxWg636MlWycuakj8L8Amo8ng/P5/BrnEm/v2AY3yy5aQz4JcyNYAgG0sAQsrybSkP
 ox2GY3z6xSuShT6tBke/o=
X-Gm-Gg: AYBFou2UkhpZtVwyD+xRmTEn3hC9q2XJ7qnksFA9PPrQpOGcKWNBRoxMQ3y4eO1WF76
 wzQ+9Te2tns+/AqqJtsM/uBtEn9lGntsU1lAfPteFeiEANVUSEOSh+EB0q4bjzeiz4C0I+arAzz
 DhqZj8b8L2inTJ/36lOJZSZLKrTIS8Nbszu8osdX+WPDbRnh/L4TGWLO7wgAHCOKYdiEmS5GKDj
 BjqeRo929Cy842mhPfTRfRO6OCFydR7CuYuIqjEh1oG/BOz
X-Received: by 2002:a05:6512:3d8f:b0:5b8:ed7d:fa2e with SMTP id
 2adb3069b0e04-5bcde6b3723mr6119955e87.19.1792064312735; 
 Thu, 15 Oct 2026 04:38:32 -0700 (PDT)
X-Received: by 2002:a05:6512:3d8f:b0:5b8:ed7d:fa2e with SMTP id
 2adb3069b0e04-5bcde6b3723mr6119943e87.19.1792064312251; Thu, 15 Oct 2026
 04:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <20261014201627.571496-1-thomas@monjalon.net>
 <20261015112916.2622825-1-david.marchand@redhat.com>
 <20261015112916.2622825-3-david.marchand@redhat.com>
 <6c3d1aa6-2f60-4974-8f48-f5317d8fd725@intel.com>
In-Reply-To: <6c3d1aa6-2f60-4974-8f48-f5317d8fd725@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 15 Oct 2026 13:38:20 +0200
X-Gm-Features: AclHuK_fZn32wWWykm2qP_QoPuC_je5MrNldPLfn6okNtGPP5b0Htd0gefphAoo
Message-ID: <CAJFAV8yfC+Kazw5Pgnhy-QiNGkML5gNPx4WKBOUW2Y+0GkR5ZQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] eal: enforce internal API check with Clang 14
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, thomas@monjalon.net, bruce.richardson@intel.com, 
 stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hamTZC7bAJN0njWYsAXgtqXTlxt4YpTRl5lUJjzCzsE_1792064313
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

On Thu, 15 Oct 2026 at 13:32, Burakov, Anatoly
<anatoly.burakov@intel.com> wrote:
>
> On 10/15/2026 1:29 PM, David Marchand wrote:
> > From: Thomas Monjalon <thomas@monjalon.net>
> >
> > The __rte_internal macro is intended to prevent calls
> > to internal API functions unless ALLOW_INTERNAL_API is defined.
> > Unfortunately the check misses some calls to internal API
> > when built with GCC or Clang.
> > Clang can be better to diagnose such cases.
> >
> > Clang 14 and later support the error attribute
> > and therefore select it instead of diagnose_if for __rte_internal.
> > Unlike diagnose_if, the error attribute only rejects
> > internal API calls that remain after optimization.
> > Internal API calls can therefore go easily unnoticed,
> > making internal API checks less strict with recent Clang.
> >
> > Prefer diagnose_if when available to keep strong Clang diagnostics.
> > Retain the error attribute as a fallback for GCC.
> >
> > Fixes: 4ab63cd60ceb ("eal: fix internal ABI tag with clang")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> > ---
>
> Missing my ack
>
> Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

I changed the original patch a bit, and well, I had trouble with all
those nested #ifdef ;-), so I preferred not preserving the ack.
Thanks for checking again.


-- 
David Marchand

