Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCD1CA1009
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Sep 2025 09:52:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31CA940B98;
	Wed,  3 Sep 2025 11:52:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6BA2A402CD
 for <dev@dpdk.org>; Wed,  3 Sep 2025 11:52:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756893160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DKc8BWjrpofkQG24zag1VUY1ncDvjrugU4x3G+VWLXE=;
 b=ChfahXVIyE9xhemmgZYJiHXizQcPD9VdtCQ2PVYR3yWN9oofqdHMq5/dsGVuhJdchkWAUz
 O2peToZppqFxPLtlwYH/8F4zMoC/ozb+oml63ywOWy5JZ7Hc+enqcYe9UJk+54sTYegxKF
 Qa6d6sloJw+pKxe6QSlFmwGoA6HRKHk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-5e-wJqAuNGam8dDFeAM1yg-1; Wed, 03 Sep 2025 05:52:38 -0400
X-MC-Unique: 5e-wJqAuNGam8dDFeAM1yg-1
X-Mimecast-MFC-AGG-ID: 5e-wJqAuNGam8dDFeAM1yg_1756893157
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5607b8782e9so1683104e87.2
 for <dev@dpdk.org>; Wed, 03 Sep 2025 02:52:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756893157; x=1757497957;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DKc8BWjrpofkQG24zag1VUY1ncDvjrugU4x3G+VWLXE=;
 b=j2HC/C9sSucf1lrA5TamBbVf83fDXcjcTCpN53KGFRGWFa4nvdMTJyxP/gQRLvdpqo
 SjvB8oEawt0O38eoswQElmVKj04ydpPC+o4sSwlwKYGz15Hjwu9MYf5VD8kNebb8AFd1
 DCk6Q49NOXekJaY565nzn60u+bZwpm4dFNS1SXSzHOYQX73Vxc87y2l7+w7NsjDmh0NV
 m7j77waOSsz4wDTgZEDBV3KHt4ROGNjToCj11rtarcYpHxNds1B17q9+GGMv2zVb0Lcq
 /egFNOc8LmT5IG3Z5yC5PeSL9fW9USufymTl+2HnQzAAuV6CGypjc2nId+TnqzRqDvX1
 rNYg==
X-Gm-Message-State: AOJu0YyImJE3ggGfypqM/FP3cGTkKiWWwbf2F8b3hkgBV1pnooBIsGbm
 h83QlvZfwvanlGGoK/Us0k59y7WoZZLhwlscQldQiOkZXP6KiGrYBDqijl0DN0Ais+C2WlWF4vX
 c+WHaKsZF3Aldt4MUKsQXziEJNdX6Yz9nB2zZ0CZ3OZ3DI488ppBy95h8fPvx0CFUSXUAJr0oNF
 eg4ffVWC77tJGj59B3MmE=
X-Gm-Gg: ASbGnctKQhjifNbsI1/xSq8GeEno9FpMVpdScV5tCA8WuzSarn5axOKDVteEszUyGnH
 GpKrHwrtwRIUqx5aeyDovHLSRex4qP8GZ5aYlgSn1tF6u5aoJEbz3gfFg+ql8FLT3FFrtjABuKb
 f59ipDd0uiG2z7SBnWsyKlR6s=
X-Received: by 2002:a05:6512:3b10:b0:55f:6f4d:e8dc with SMTP id
 2adb3069b0e04-55f7089be90mr4329207e87.4.1756893157182; 
 Wed, 03 Sep 2025 02:52:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECreI9QJBgtLOBHLn8XO+xlH79NxqR9SlnbZC7hEv0HJDXA6xvUrJ867aGVh2ugiRnYz6qwtQIfR4d7OSUoo8=
X-Received: by 2002:a05:6512:3b10:b0:55f:6f4d:e8dc with SMTP id
 2adb3069b0e04-55f7089be90mr4329191e87.4.1756893156703; Wed, 03 Sep 2025
 02:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250903072826.1727004-1-david.marchand@redhat.com>
 <e08e6b4d-737b-4254-b8a6-16613f67eab2@intel.com>
In-Reply-To: <e08e6b4d-737b-4254-b8a6-16613f67eab2@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 3 Sep 2025 11:52:24 +0200
X-Gm-Features: Ac12FXxFu7obUdfqXLF3wlRqZePJw3UIql03_P6gx1HrX2ymZDdei7QSsIodhT0
Message-ID: <CAJFAV8yQ7D-k4ZjiP6jet2RrhNO0Y18iqXpdidB+AXOgTrFdxA@mail.gmail.com>
Subject: Re: [RFC 0/8] Cleanup VFIO API and import Linux uAPI header
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, thomas@monjalon.net, maxime.coquelin@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Zm0P0_v8cTS-XHvmR31d30BXDIvWeFmQKC8lFDvX8G0_1756893157
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

On Wed, 3 Sept 2025 at 11:30, Burakov, Anatoly
<anatoly.burakov@intel.com> wrote:
>
> On 9/3/2025 9:28 AM, David Marchand wrote:
> > The VFIO headers have a number of issues:
> > - showing to the world a lot of internal considerations,
> > - defining macros with the VFIO_ namespace (confusing, and a source of
> >    conflicts with the VFIO official uAPI),
> > - wrapping around VFIO uAPI in case the kernel headers do not contain the
> >    expected API (putting the burden on DPDK developers to find the right
> >    way to detect the presence of a VFIO feature),
> > - (somehow related to the previous point) supporting old version of the
> >    Linux kernel while DPDK now requires a v5.4 Linux kernel at least,
> >
> > This series proposes to cleanup those headers by hiding as much as
> > possible internal macros and structures, then removing the explicit
> > inclusion of linux/vfio.h from rte_vfio.h (pushing this inclusion to the
> > application which may want to do some funny stuff with VFIO and should
> > already include this header on its own) and finally importing the VFIO
> > uAPI header from Linux v6.15 for internal consumption by DPDK
> > components.
> >
> >
>
> I've been working on something like this myself, so it'll be interesting
> to compare notes! I too found that refactoring VFIO is a nightmare due
> to how much stuff is exposed to external headers.

Oh cool.

A v2 is neeed, as this series breaks FreeBSD compilation.
I'll wait for comments before sending.


-- 
David Marchand

