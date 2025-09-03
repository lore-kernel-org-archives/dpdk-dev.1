Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C907ECA1007
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Sep 2025 07:04:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D578B402BC;
	Wed,  3 Sep 2025 09:04:39 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id BCB0B40261
 for <dev@dpdk.org>; Wed,  3 Sep 2025 09:04:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756883078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fc+e9Oo8ozzputAJ5tEl/ZDlKXyYKUckEHQ2uZbnsz8=;
 b=gfqVJJVEhpFVKuV2YYR0FuXt3pFCU4/ZZYGhoDTFKHOsUHxQ1AtOf1GCPhHM92sCoSTi7j
 hG+Vm17pZGkpyYdR7Qi60NNRekk3zne2ywTQyxQYWWFjUBa5qiEY+4pccTfxsAS53SQuMc
 jVKh6L/9v9zQ5PbTuvB1TOQYh2l+FK8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-OR-euLtQMOmykoCqX8PS2g-1; Wed, 03 Sep 2025 03:04:34 -0400
X-MC-Unique: OR-euLtQMOmykoCqX8PS2g-1
X-Mimecast-MFC-AGG-ID: OR-euLtQMOmykoCqX8PS2g_1756883073
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5607b8782e9so1578611e87.2
 for <dev@dpdk.org>; Wed, 03 Sep 2025 00:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756883073; x=1757487873;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fc+e9Oo8ozzputAJ5tEl/ZDlKXyYKUckEHQ2uZbnsz8=;
 b=WjcVDvAIJ1I+mHCUKv/Q97QdN5uhui6Dqm+w8kE4GpBPiz2M1Rs8oBBI6mx7Q6Dbu3
 feuoPi9bb97HXIsJFPQ/zXaO7kx0/AW4cpQdA7W67BlK11yuPLd2l/m7s8W9N98V8JJ6
 dXFn20fOGWDhjMZ4UeeiXHtnd2ulfwSFB6zu9xYmAff9U2Xbmf3dYz021+nx3igVaRQa
 pyv8Z83nua9RHt1QZh97m/AMGOe0nl8ZYU97BQIAxt90V0yvHQf/Ikezh8unibm5oCHo
 XWfM+ePSjr7soanE2FBQ56m/gu7CbOLlZ7+ya30rBQc9XZMCJdM7KOt/H0uI4Vdq/ScF
 84Ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKh8NH+7Vd5JVFdfmPzmo5bpa2ooyHfTbHoLL94jUwCstyVbcGhXhW7sgkbRF5y1lMypw=@dpdk.org
X-Gm-Message-State: AOJu0YzYGfddaoxrVW/v821F3QSl2sqeVBGGEcRSkC4mIrltwroVz8Yf
 J7GMVJIT5JDrnrcgPUG29RShStyV7dhh9WkYcePx08wtgncSqkCCcBGAjxeTEk1+klOvLkR5G8d
 kVQ4jnBBUGVA6UrSEIv464axWvRD742GBfSgjIgMEpSV146o2mPOdC0x0R5mkFpVIHwDP2FEHiu
 HGF+OTsg2mTZtxHTMjPa0=
X-Gm-Gg: ASbGnctnTZG7v/6U//zsgI80IMZ8lTIYEfya1jrFvmj9KGy12XlNKHaZvHknHHoCKGQ
 0D97UH0+qkO6qIOFConhHHDjwP6r539Zf5wQuucnsYRS/b9JbvC7mXXW26lyrwycbGnLD+++aPM
 r+Jy98J9A7MDt94SJ4cO5yP3o=
X-Received: by 2002:a05:6512:104e:b0:55c:c971:2271 with SMTP id
 2adb3069b0e04-55f708baf14mr3372171e87.25.1756883073146; 
 Wed, 03 Sep 2025 00:04:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVEqetDTSYme+vCF+fSWksTLAz5z0c+OQjY2dj41m72XRwtLJUMxlKHj0VJu6WNcYIrl6Nle5vraRReNDHRQ8=
X-Received: by 2002:a05:6512:104e:b0:55c:c971:2271 with SMTP id
 2adb3069b0e04-55f708baf14mr3372167e87.25.1756883072745; Wed, 03 Sep 2025
 00:04:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250828025957.30917-1-fengchengwen@huawei.com>
 <20250903020547.12347-1-fengchengwen@huawei.com>
In-Reply-To: <20250903020547.12347-1-fengchengwen@huawei.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 3 Sep 2025 09:04:20 +0200
X-Gm-Features: Ac12FXwn3FjigiE13Zlw1y0lct-DlHy9-aaXqmgVVNsITVfhd-Kpk1-Poi43Hq4
Message-ID: <CAJFAV8yTwKR3oBJ-N68je_=aUL5Dg4_h_H8zgB3ZvLzrLbQtNQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] add semicolon when export any symbol
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: thomas@monjalon.net, stephen@networkplumber.org, dev@dpdk.org, 
 Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9kRYjtO80s1y4dFkZVlofrpwqqpuCDwybYrDA8G3aeU_1756883073
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

Hello,

On Wed, 3 Sept 2025 at 04:05, Chengwen Feng <fengchengwen@huawei.com> wrote:
>
> Currently, the RTE_EXPORT_INTERNAL_SYMBOL, RTE_EXPORT_SYMBOL and
> RTE_EXPORT_EXPERIMENTAL_SYMBOL are placed at the beginning of APIs,
> but don't end with a semicolon. As a result, some IDEs cannot identify
> the APIs and cannot quickly jump to the definition.
>
> A semicolon is added to the end of above RTE_EXPORT_XXX_SYMBOL in this
> commit.
>
> And also redefine RTE_EXPORT_XXX_SYMBOL:
> #define RTE_EXPORT_XXX_SYMBOL(x, x) extern int dummy_rte_export_symbol
>
> Chengwen Feng (5):
>   lib: add semicolon when export symbol
>   lib: add semicolon when export experimental symbol
>   lib: add semicolon when export internal symbol
>   drivers: add semicolon when export any symbol
>   doc: update ABI versioning guide

I am skeptical about this series.

The current positionning should be seen as an additional info on the
return type, in the definition of the symbol.
Does it mean that this IDE would fail if we add any kind of
macros/attribute involving the symbol name?

Afaics, ctags can be taught to skip those macros and just behaves
correctly by adding in its config file:
-DRTE_EXPORT_EXPERIMENTAL_SYMBOL(a)=
-DRTE_EXPORT_INTERNAL_SYMBOL(a)=
-DRTE_EXPORT_SYMBOL(a)=

I think another option would be to move the call to export macros
after the whole definition of the symbol, though I prefer the current
position for readability.


-- 
David Marchand

