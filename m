Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0940CCAC5B8
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Oct 2025 11:04:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F11F402DD;
	Mon,  6 Oct 2025 13:04:17 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id D70EF402B1
 for <dev@dpdk.org>; Mon,  6 Oct 2025 13:04:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759748655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pOpJtoMQoEx9s4mbSwKXI5CGFkX1qAz/bzDhhHqjHNE=;
 b=Ct3QBoV7TgiaYyst++bNWItrpUMnRL3Da19Czg6WFKM62VUmodq0ouRl2WTsVDlYgL5h9I
 C+7QN2GwYTUyfI+Ma/rEfKtwKT3KwV8TSQ4EXxu0O5jLgKfS8mGzo8PS1MJ43WJgMM17Ge
 Q8rCdsZJHktcZOfFVYzLx7l2jSRO6sY=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-NcAdzNIfMdC7pkYCjsnjxA-1; Mon, 06 Oct 2025 07:04:13 -0400
X-MC-Unique: NcAdzNIfMdC7pkYCjsnjxA-1
X-Mimecast-MFC-AGG-ID: NcAdzNIfMdC7pkYCjsnjxA_1759748652
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-36c983e4c21so20554721fa.1
 for <dev@dpdk.org>; Mon, 06 Oct 2025 04:04:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759748652; x=1760353452;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pOpJtoMQoEx9s4mbSwKXI5CGFkX1qAz/bzDhhHqjHNE=;
 b=FKvRCN2vLRhtwtC4OXnJIGN4C4mlYK5pPW27SWy0Xo8mAp5S3LIo/3rugk9JUHZOZj
 r92twPEOc5Ybbb/NcbNY1a+NCJMyXSaVBmz9u7oOGdeIrZLHFQCKYCX+YksGmOi4AhIP
 KuBwyIpL9XpXwmgEPJmPWdWfCIGqSmZtPWLIMrc2iE1XHC8v7MlSsiJE0FlZdcN04lRQ
 1uMNTWaiSCnx22prPwccGW54YEPpGLtipapYD9N1xSjBoNaE5buz7+A9ElMn4fln7NB+
 d+jNbFVpxLcae3do4pUQBvE+RehR0yZW2zc3NlUnA0N7S+jYCJuysSMU8gcp5UQsucml
 253A==
X-Gm-Message-State: AOJu0YzUIFOsMbS8L+9bDFm8zfM1+Z70nHjNiskmYVAXlgNnsfsdOblD
 LWtA6molLK5r226W0kdPIbW/9+TnW2IlaS/3x7C5O8quZYZFOG37ruodVSaWWIT4O1tUX+Y6e/v
 Mn8SK9AJC1rmT4vBj5y1BKbhyeRCJV1SE2HDsM8cQSdBtmpB678fueek13MXH1S3VFVyWVK6FhF
 t8lN3w3y8nxeHY49tk2po=
X-Gm-Gg: ASbGncsoY2ZTJQw+pr4cvGqR32+P7COi9ZIhCTGiCUKTHA8fmXm53qrykO7bYeOi34Y
 xUe6xSazCqyJ+w5Y1tGNS185XMoLyvwMWIVuar0I577zf3BjsAwfEogR7h876Tl0tFcYp2YKZHW
 PWEPggmvcfMMYYZ4X5l2r4EIBqBKYZ
X-Received: by 2002:a05:651c:504:b0:336:ceac:f3bf with SMTP id
 38308e7fff4ca-374c36fe0a3mr33587851fa.13.1759748651960; 
 Mon, 06 Oct 2025 04:04:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsXH8xv9dVAaIYCr/GM0MPGay5sm95Vidm0rZu5Ntr0kW5lcXzbMvEDR/zt7K1QfYAuDYoFCSG2q/yDH/VJNU=
X-Received: by 2002:a05:651c:504:b0:336:ceac:f3bf with SMTP id
 38308e7fff4ca-374c36fe0a3mr33587671fa.13.1759748651464; Mon, 06 Oct 2025
 04:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAJFAV8zLgkqEyifkG0t5f22pu+55PUXAKXdQXHHK7n2sxenTzg@mail.gmail.com>
 <CAMw=ZnSVkkdF8_V54xWxDths7HyRcW_6Fu3kuiQ-tg2buScCeA@mail.gmail.com>
In-Reply-To: <CAMw=ZnSVkkdF8_V54xWxDths7HyRcW_6Fu3kuiQ-tg2buScCeA@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 6 Oct 2025 13:04:00 +0200
X-Gm-Features: AS18NWAfQrJ34ibZ2VFuxdLbYk65ooQsKoAlSQi9U0FCFJSFGMqmUH1Ajx9xYms
Message-ID: <CAJFAV8y196yO8OqBi9_EYp+sKHXk41pf5U=M-yym6fP3R_eP6Q@mail.gmail.com>
Subject: Re: Build failure in OBS with openSUSE 15.6
To: Luca Boccassi <luca.boccassi@gmail.com>
Cc: dev <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, 
 Kevin Traynor <ktraynor@redhat.com>, Aaron Conole <aconole@redhat.com>, 
 Patrick Robb <probb@iol.unh.edu>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AbzmaRsbtg3izu13kyBsr6BlG4Tf0A6s3OEoZQzG9CQ_1759748652
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

On Mon, 6 Oct 2025 at 12:27, Luca Boccassi <luca.boccassi@gmail.com> wrote:
> On Mon, 6 Oct 2025 at 08:43, David Marchand <david.marchand@redhat.com> wrote:
> > We have a build failure in the openSUSE 15.6 job in OBS.
> > https://build.opensuse.org/package/live_build_log/home:bluca:dpdk/dpdk/openSUSE_Leap_15.6/x86_64
> >
> > This failure is due to 4a04a346e7f3 ("vhost: simplify use of
> > pragmas"), which followed dd7fdfff9bc1 ("build: remove support for GCC
> > < 8 and clang < 7").
> >
> > The openSUSE 15.6 job still uses
> > [   39s] C compiler for the host machine: cc (gcc 7.5.0 "cc (SUSE Linux) 7.5.0")
> >
> > Is it possible to update to a more recent gcc?
> > Otherwise this test should be dropped.
>
> Hi, that's what Leap 15 ships with, so I've disabled the job since
> it's no longer supported.
> BTW I believe you have an account? Thomas and Kevin are already listed
> as maintainers so they can do these changes too, if you tell me your
> username I can add you as well, it's just a click in the repositories
> tab to enable/disable builds

Thank you.
Ack, let's sync offlist.


-- 
David Marchand

