Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62189C36014
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Apr 2025 09:22:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7183B402B5;
	Wed,  2 Apr 2025 11:22:14 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2FF8940275
 for <dev@dpdk.org>; Wed,  2 Apr 2025 11:22:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743585732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+bJ89IYCpYHGMrJ2vXb86XD9W2yl0NR4TwvFQcxJHS0=;
 b=Y4EOUV9Dn2k/4YZn/vJuZ9ie5Km9N2trG4Vz/RGlYx0h5ykbB0lBhBkFHGOB0FUfKFnngX
 dwhRpiw5n7ZMgzNYUZBe1nyVViC7ziiv9Bg3AOBNt16zRpPKZBO6/3G6VSdzUq07eTw3oB
 lxoY8fhhQjoy/Iv2hJipqNtxRzSdVug=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-WSGVM-1WOjSS6zh_PckrnQ-1; Wed, 02 Apr 2025 05:22:09 -0400
X-MC-Unique: WSGVM-1WOjSS6zh_PckrnQ-1
X-Mimecast-MFC-AGG-ID: WSGVM-1WOjSS6zh_PckrnQ_1743585728
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-30bff47a93cso33422861fa.1
 for <dev@dpdk.org>; Wed, 02 Apr 2025 02:22:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743585728; x=1744190528;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+bJ89IYCpYHGMrJ2vXb86XD9W2yl0NR4TwvFQcxJHS0=;
 b=eFK66EZ88nsGIH926QcrYRn2De6O+LQhtmdqWJUk2YxBMpsqBHFTY4cscvgHGF3QZk
 zUQVSpdJm4Fv7ntKHhPKdU75YhOhf5Y4zAQA5ifhLOz5d58l85ZRxaMc6y6W1SYxuiOm
 pvrJIemilrkoRSnwppyDCJkN5BXX+59xzZCrKyHt8Y4f45sLi5lanmnaSKeeoS1LHovm
 AIv0wsQNSaS0m1bmII3i14c71qTAscdde0+9iiYok/mnNteTXCX2i+knUBLIYFI+z2IN
 vZeh10gPb2ICS9Fkwm7DVxFSWDNa7EQyeOUDEa7Y2dLS8A4d0c0OIWnY3eInGPq6v4RA
 IqYA==
X-Gm-Message-State: AOJu0Yzb6R7cziDkQmSSD4rxjp+bxpkWp7E/FsXpWUG5fsTcs0+GkJc7
 g1n1U5MyYVJ5LdrL+pORFRWPJYlVqZSngEJP5S+NjVcIysf0z+OMOrYy4UjVYSSlTZ5hHM17jw/
 YCghzZ1GpZ0SnWvbgWOruwGzVDrQWcvF5iAlWIEpLZSb4q+ia/erBSL+c5W1f2vaTzdwBV3TRGY
 FewUYHX+rH4a+FNwE=
X-Gm-Gg: ASbGncvu6jgmc6Y4L282nx6KCxeWY5pp91IyGuIoKcbDryjw+y07sVUb2HUDNxiKEDR
 r6bAlPT/G9Al89zZFU/EC3IFJ+/+vF+afr1JHMq2brPaAo/ar7A5LwRGVoJv1Yp2S4md64GZQxD
 Y=
X-Received: by 2002:a2e:b8c7:0:b0:308:eb58:6591 with SMTP id
 38308e7fff4ca-30de02fa8ffmr54790701fa.25.1743585728015; 
 Wed, 02 Apr 2025 02:22:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtfvvIvhQ/udSI1U7E4J+BT7pyuiEmW1KkYRjv5BsPH9AnXtwvuQbuwpBjPSgtEdNj+8D0S/bXo5PoGS2JStE=
X-Received: by 2002:a2e:b8c7:0:b0:308:eb58:6591 with SMTP id
 38308e7fff4ca-30de02fa8ffmr54790511fa.25.1743585727655; Wed, 02 Apr 2025
 02:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250328105250.3082414-1-david.marchand@redhat.com>
 <20250328105250.3082414-5-david.marchand@redhat.com>
 <6827973.mogB4TqSGs@thomas>
In-Reply-To: <6827973.mogB4TqSGs@thomas>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 2 Apr 2025 11:21:56 +0200
X-Gm-Features: AQ5f1JpRhZ8zQtdNgp_BXobD97HGDI6VSsx835FsXxdvqHCnhhWpRMBTpOThjVU
Message-ID: <CAJFAV8xJ+puwWM5dFgyTnhdXE7oMd3hEXYyWM5sWSzoHHP_4kA@mail.gmail.com>
Subject: Re: [PATCH v6 4/8] build: generate symbol maps
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, bruce.richardson@intel.com, andremue@linux.microsoft.com, 
 Tyler Retzlaff <roretzla@linux.microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8eu9NrrFwyj5PMnt8To6SU0xEhARKetwHd6sSD87yBw_1743585728
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

On Wed, Apr 2, 2025 at 10:06=E2=80=AFAM Thomas Monjalon <thomas@monjalon.ne=
t> wrote:
>
> 28/03/2025 11:52, David Marchand:
> > --- /dev/null
> > +++ b/lib/eal/common/eal_symbol_exports.h
> > @@ -0,0 +1,16 @@
> > +/* SPDX-License-Identifier: BSD-3-Clause
> > + * Copyright (c) 2025 Red Hat, Inc.
> > + */
> > +
> > +#ifndef EAL_SYMBOL_EXPORTS_H
> > +#define EAL_SYMBOL_EXPORTS_H
> > +
> > +/* Internal macros for exporting symbols, used by the build system.
> > + * For RTE_EXPORT_EXPERIMENTAL_SYMBOL, ver indicates the
> > + * version this symbol was introduced in.
> > + */
> > +#define RTE_EXPORT_EXPERIMENTAL_SYMBOL(a, ver)
> > +#define RTE_EXPORT_INTERNAL_SYMBOL(a)
> > +#define RTE_EXPORT_SYMBOL(a)
> > +
> > +#endif /* EAL_SYMBOL_EXPORTS_H */
>
> Another thought, there is no specific reason to have a "s"
> at the end of this filename.
>
> eal_symbol_export.h looks better to me.
> Or simply eal_export.h ?

I don't think there is other notions that will be about "exporting",
so implicit eal_export.h looks ok.


--=20
David Marchand

