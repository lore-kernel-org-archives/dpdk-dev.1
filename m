Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E78C3ABC9
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 11:40:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7294840E2D;
	Thu, 15 May 2025 13:40:05 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2D62440289
 for <dev@dpdk.org>; Thu, 15 May 2025 13:40:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747309203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eINavSSjk0qDoVPKmv+f+Id1+T+RFOe2HCSk36tju1g=;
 b=Z2+LGPQXsc28IHFyWBgqLC/NuveQwq+gDEZfR4czz9EZ28hgWNvM6PRuKiB+k41Xz1a7dn
 37E70GDhiNty86JSsbcDmR8/54liZubMGgvW2W9j/0JJBhisCfXbXpzOSgxmUtsQHWrZMp
 m+vU+2oTUMmj4gAJrJvi9GYbn+73HZg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-yJ1fwtBwNfKGi2tWqfLScQ-1; Thu, 15 May 2025 07:40:01 -0400
X-MC-Unique: yJ1fwtBwNfKGi2tWqfLScQ-1
X-Mimecast-MFC-AGG-ID: yJ1fwtBwNfKGi2tWqfLScQ_1747309200
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-326bcb1207cso3853181fa.0
 for <dev@dpdk.org>; Thu, 15 May 2025 04:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747309200; x=1747914000;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eINavSSjk0qDoVPKmv+f+Id1+T+RFOe2HCSk36tju1g=;
 b=wvKrqyuiC2gGabeVfYPG+jVvoMMIHI6mGq38My4Cy1OZKO8JIKGQOhQO2F94aG2srW
 f17NU5EIgGzgl0MUrzQqRpB/zgzvYisObp1gz3AYPnVpOFocYymcD/FIhU6fnGYbHrG3
 SCEEqpiTVrXxf6BKw7x2e1pzgvbtvDmrGh4eBNdihn7yOzS/IKa0XBksB8whzATj5s9H
 2+oK9tSMpNHvney/KFqhaCexKhpQh2fTTgmHM7Xo18NEb3apzddE1LJD+GW8brM0FQI6
 W2s95uBcOYCp+mUjWIcE5opN2Md5lgaZmil87S8eZXAncLIIRLqmHq4nVIo7hgEEcAYx
 tjBA==
X-Gm-Message-State: AOJu0YyQC05DZ7cDGOyJdv7eNbo8gK22MCBrv5JrZp+HsHBq1DE3PFrs
 jQ5S5JwqiwseCkQH+oPilpwcEamc6HgipPmTBQcPFi17fIJlbskhSI0awlRRa7uCU4jRDeRnJWh
 ZR4XH2EN7zpk1CkFvJAL1r0kiShUM7BxvJefgkOBvCV3Lbp26LaSPfLB7QhUJZjrTi/l6TbyM6O
 IwsDzwav+IyMfnWYw=
X-Gm-Gg: ASbGncs+JqLqTDRGlUrGRmGZeD+I9Y7ScACdjoF61GIe7/ETEnHslSqgf0BexhoOzFJ
 V4h59g2HAt6aX/BWMyQDbtc5jYeXZE2DEyKu/D/BSRKoZVMJrovSlI5TNFNDxmgEH8rkUTu0=
X-Received: by 2002:a2e:b8c5:0:b0:31e:9d54:62ec with SMTP id
 38308e7fff4ca-327ed20fe41mr30861711fa.31.1747309199673; 
 Thu, 15 May 2025 04:39:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhLduwUFFo/vQ68ZVQw18um25w84dObmYhJFYvxXWFgFHDqyoYFcS3xR3lqRVzVdbvFhhuwNOqXHHRZSzrqpg=
X-Received: by 2002:a2e:b8c5:0:b0:31e:9d54:62ec with SMTP id
 38308e7fff4ca-327ed20fe41mr30861601fa.31.1747309199229; Thu, 15 May 2025
 04:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <20241009152417.4028297-1-bruce.richardson@intel.com>
 <20250513085956.1670288-1-bruce.richardson@intel.com>
 <CAJFAV8xccPZAvQrFX_dqhQ49ZQUEtTO3GoDPKLZpz05pyBL1nw@mail.gmail.com>
 <aCW1qG-VVALr_o0n@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aCW1qG-VVALr_o0n@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 15 May 2025 13:39:47 +0200
X-Gm-Features: AX0GCFstUOHt2Xl6Wz622MnDu6diytRsEnIK57jQip8W91iJsVkKmPmw9CdF0Ak
Message-ID: <CAJFAV8z842+xoRs2P8YCrG9EvFD_S-aC-0oaiV_7Dz41qiVZnQ@mail.gmail.com>
Subject: Re: [PATCH v2] build: automatically report minimum meson version
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>, 
 Patrick Robb <probb@iol.unh.edu>, Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fJDd9eantdpnqBqmbbswL4Xg_RJqnQFkXLNusunH7wA_1747309200
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, May 15, 2025 at 11:37=E2=80=AFAM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Thu, May 15, 2025 at 09:09:22AM +0200, David Marchand wrote:
> > On Tue, May 13, 2025 at 11:00=E2=80=AFAM Bruce Richardson
> > <bruce.richardson@intel.com> wrote:
> > >
> > > Add a script to buildtools to report the minimum meson version given =
in
> > > our meson.build file. Then use this script in two ways:
> > >
> > > 1. in the .ci/linux-setup.sh script, use the auto-determined minimum
> > >    version to set up the CI, rather than hard-coding it.
> > > 2. in meson.build call the script to report the version. This serves =
as
> > >    a sanity check to ensure that any changes to meson.build file do n=
ot
> > >    break the script.
> > >
> > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > > Acked-by: Stephen Hemminger <stephen@networkplumber.org>
> > > Reviewed-by: Patrick Robb <probb@iol.unh.edu>
> > > ---
> > > v2: rebased to latest main
> >
> > This patch is reverting dbcd72f3fba0 ("ci: fix unit tests with Fedora 3=
7").
> >
> > There were some strange errors raised by UNH, though I don't see the
> > same python backtrace.
> > Let's try again:
> > Recheck-request: iol-unit-arm64-testing, iol-unit-amd64-testing
> >
> If we have issues using 0.57, I don't see there being issues with us
> marking the min meson version to 0.57.2 rather than 0.57 alone. I can do
> that in a v3, or else we can abandon this patch, if you prefer.

Retests show the same error, so I think we are hitting the issue fixed
with dbcd72f3fba0.

Bumping the minimal version to 0.57.2 seems fine.
I looked and can't find a distrib that ships meson 0.57.
So either a user relies on the distrib version (with a version >=3D
0.58, from my quick search) or the distrib provided version is too old
and then the user relies on pip.


--=20
David Marchand

