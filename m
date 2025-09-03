Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C99FCA1009
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Sep 2025 15:22:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7062540E21;
	Wed,  3 Sep 2025 17:22:50 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6B5C640281
 for <dev@dpdk.org>; Wed,  3 Sep 2025 17:22:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756912969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YhpJo/Ddkq1uOxEXcww/2F98PzPGoA/uvNmJXxqcxEc=;
 b=darPuyCTsSVxupVlrJh1My3tsMtB5OAK5rnZQGMUzmlgV++V1yRX8ptQa2wnsIXNhx5Iw4
 0oXG1e2tQV/V+sZIvN9FTIazLN5gp/W9fWht24oXIL9mYYw/zZHWYkxhGnpPTMjnkaCwBw
 esBt3P4XKD7c+Ms26NBO6cvmwQSzfEs=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-fq3xqaRRPmeZsRBUEyqDtA-1; Wed, 03 Sep 2025 11:22:46 -0400
X-MC-Unique: fq3xqaRRPmeZsRBUEyqDtA-1
X-Mimecast-MFC-AGG-ID: fq3xqaRRPmeZsRBUEyqDtA_1756912966
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-24b2b347073so659405ad.1
 for <dev@dpdk.org>; Wed, 03 Sep 2025 08:22:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756912964; x=1757517764;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YhpJo/Ddkq1uOxEXcww/2F98PzPGoA/uvNmJXxqcxEc=;
 b=T/Xc1dO3qXbAtbzxTo1vofMtTH6pbs5vLmBLOHd5CZAGnCNY8eKG/lAz9qpsaiFwsU
 OrinKsQgI5uwNAp3sc8OfJF6jB1SmSkqYKBjasBh1l7F17ejeaVupWjnhAzuYIkkdCZU
 iL5ucbQ1IpvTu8qoeY9vuqBH7Xk56iBvNbt63gxS0FJ93ZG583HM5DYnBrCkJNRRmBRD
 50RjFkR7ljUozWQMBmECT+tCWwcSRStWh9ysJxfAFYZmZYo+j1vi6p1SpZ4PAmL586Wd
 vq7oXgbn4cUurFTv9EmmdNMCtUBLYlqQudZpRVqmeLDOXNYkN1tSvuoVFBquSh/ehAu+
 paAw==
X-Gm-Message-State: AOJu0Yx6sExh31f4FHltNqwl5wHiiDU+s3IfEhDrwH5NrNkZl5riJ7w8
 UAmhsHL/DZuscpK58FYXCWevYRPZ2k0YQRTvcZwW0J/r17m/MJ6gT+TSFjXzX/jrUddjM4qoIJ0
 frwx9EJvoLbESsMGI1WggPJDm8j/Axapyph0aYDCI8ffvTja+T09m6J9xPrVqGgvpketL2AziZU
 pH8GxG1QYrAuor0OICoWUKmhRt3AA=
X-Gm-Gg: ASbGncvPkrEPBvdHyqipT4x+9NXQfgNQppecK+CF+drLXgAdK7XVGiOXZOCyH+zKL9K
 8gMZVgwhmXseY8f/2CvikHCWp7guj4lWPl7G1YXfKYw9CRFXS3YqmEgASYMymesnHRmA6DmIole
 vbCiOy2sp4Iwm2nH35IkYfjJ4=
X-Received: by 2002:a17:903:2309:b0:248:d0ea:f291 with SMTP id
 d9443c01a7336-2494485d6ecmr225269375ad.3.1756912964314; 
 Wed, 03 Sep 2025 08:22:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGB1PtNBjfEARNvbu+9r3Cq9K30CQ2xnHLbLU/ihjmXM511KKSUV6kGy2cmItZOTXmQWQz55MIWBLegC3ZPm7E=
X-Received: by 2002:a17:903:2309:b0:248:d0ea:f291 with SMTP id
 d9443c01a7336-2494485d6ecmr225269105ad.3.1756912963997; Wed, 03 Sep 2025
 08:22:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250903072826.1727004-1-david.marchand@redhat.com>
 <20250903151327.1964490-1-david.marchand@redhat.com>
In-Reply-To: <20250903151327.1964490-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 3 Sep 2025 17:22:29 +0200
X-Gm-Features: Ac12FXzXz9T-nq3wnOtZ5kuvJBem1h4-Cs0rZ1p0LOgYaChn71Q_e-ARQSPmjHw
Message-ID: <CAJFAV8ys2=kg06YFpPiwj+ys_BdUi0oaCx1PvjDCsPEXSba3aw@mail.gmail.com>
Subject: Re: [RFC v2 0/9] Cleanup VFIO API and import Linux uAPI header
To: dev@dpdk.org
Cc: thomas@monjalon.net, maxime.coquelin@redhat.com, anatoly.burakov@intel.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tQvXwkH-QWa3cEYeL_UMHX6NgiNrwa71qgiCCCjltDw_1756912966
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

On Wed, 3 Sept 2025 at 17:13, David Marchand <david.marchand@redhat.com> wrote:
>
> The VFIO headers have a number of issues:
> - showing to the world a lot of internal considerations,
> - defining macros with the VFIO_ namespace (confusing, and a source of
>   conflicts with the VFIO official uAPI),
> - wrapping around VFIO uAPI in case the kernel headers do not contain the
>   expected API (putting the burden on DPDK developers to find the right
>   way to detect the presence of a VFIO feature),
> - (somehow related to the previous point) supporting old version of the
>   Linux kernel while DPDK now requires a v5.4 Linux kernel at least,
>
> This series proposes to cleanup those headers by hiding as much as
> possible internal macros and structures, then removing the explicit
> inclusion of linux/vfio.h from rte_vfio.h (pushing this inclusion to the
> application which may want to do some funny stuff with VFIO and should
> already include this header on its own) and finally importing the VFIO
> uAPI header from Linux v6.15 for internal consumption by DPDK
> components.

Sorry, please ignore this thread, sending the v2 series got
interrupted by an error from my smtp.
I resent the whole series.


-- 
David Marchand

