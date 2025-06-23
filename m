Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3532C77B7F
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Jun 2025 09:40:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA202402DE;
	Mon, 23 Jun 2025 11:40:37 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 453BC402A1
 for <dev@dpdk.org>; Mon, 23 Jun 2025 11:40:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750671631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KmJPHq9bky6PEiBNTEZKlZeJL1ac7cTfhbpwXUhvvBo=;
 b=RcvEIQuep3pkiwg3RxGLhNXHl2t576HRGyQ8qvOmMHpHlni9KeUhrY174TxjPkeaPDO3K0
 J961Haby5BHughTPfN9xRAJVsK3PLwyk7pWA4N5wmXXnSQWLsEK1JhB0FEyY3/re81Ub/p
 79GGCJcUu0ZI5hGYu5ESMHtXloAO+Zo=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-Pku0Xu7kM3SgII1l9Do2fQ-1; Mon, 23 Jun 2025 05:40:29 -0400
X-MC-Unique: Pku0Xu7kM3SgII1l9Do2fQ-1
X-Mimecast-MFC-AGG-ID: Pku0Xu7kM3SgII1l9Do2fQ_1750671628
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-553cff91724so2149180e87.2
 for <dev@dpdk.org>; Mon, 23 Jun 2025 02:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750671628; x=1751276428;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KmJPHq9bky6PEiBNTEZKlZeJL1ac7cTfhbpwXUhvvBo=;
 b=DrIOJhCWgAYIYNM1Xau0yyxrDXnnJ3O2f8tQlyIeTazJ1QX+nAbsNLzLWxbH8L7C1u
 lxLxUgGPKiWUKJnr0Qv0B1ypArthpqniO7vD2X4F9dCsQtrzbwPRAU97Xv2ZJVvngNZ5
 O79Yv09S4BNv1tIxyDYlmtKOAXNrQsIz+kkgXKzefAp9NRexFhy/uh26BbyuUxAznTxm
 Pm9iUczEJAF2Uy/1Z7/niKuXaZ1K7hMkrgTlSYSBHSa+iQTSymeA3Z5+9LpfxJe42Yx1
 RfPqAI3UaDj4iPm4U1k5+b9MQJieyE1Isvu/+VB25q1p9JKX0q5w+KzJijkZ9RiZyY0y
 pciw==
X-Gm-Message-State: AOJu0Yw+XB635rQM+OT6EOBj958U5Wfkl/wf4PrKosyZIVOTECjDtE7r
 pt3NmBuvWBAt6OH4qnSwr4JkuHTXwxZJ4u+9Ha9CJHhoAxayDE+UTb8Vf+XGpW/KV23B+SJ8H04
 Ijf7P66FA3q/tM1GV9nnkY2jysYD5FM0de49pjBSo8DN8x0arsVViN734psmAPIOxybij/F0WSj
 qMpO749v9z/WxX7VVb2nE=
X-Gm-Gg: ASbGncv9X7IV64mPuvnmq0dd+i3aZyY3bBgj0T9eg85+JDJTcwMJZQVZZtfxvsCXNLC
 xK/Of/NQypX0ws129TULclpJlKBKvYlwHr5+iP29hGFbpjJ0oi8ysCax1A343A4maU5gBQffYvT
 9YLlaRcw==
X-Received: by 2002:a05:6512:23a0:b0:553:543d:d996 with SMTP id
 2adb3069b0e04-553e3bee8bdmr3642450e87.33.1750671628087; 
 Mon, 23 Jun 2025 02:40:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHS2OVCZ19fC+PRgxcYVZudBgaiu3uw9dCKn/V1X60IQWpBF71BbM1eQyQaLDkBThPttQbcVCOnpo6wMrXDoaE=
X-Received: by 2002:a05:6512:23a0:b0:553:543d:d996 with SMTP id
 2adb3069b0e04-553e3bee8bdmr3642437e87.33.1750671627617; Mon, 23 Jun 2025
 02:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250619071037.37325-6-david.marchand@redhat.com>
 <aFUw1gDuJNuJBnIs@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aFUw1gDuJNuJBnIs@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 23 Jun 2025 11:40:15 +0200
X-Gm-Features: AX0GCFu6k5FSplJPjrzUiOIKamBFu2qH8PKEn_VL6D3SDj3MH1sKoBv-10UzDfQ
Message-ID: <CAJFAV8wsxm6RdNwNLa0AefEbhgKFLVhhRjDmnTZc4p9-mf489g@mail.gmail.com>
Subject: Re: [PATCH 05/10] cmdline: fix port list parsing
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XmW3-HeyuV-n4nNSaO1Hfvs5hxETP8UyTHVUrsuydHA_1750671628
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

On Fri, Jun 20, 2025 at 11:59=E2=80=AFAM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Thu, Jun 19, 2025 at 09:10:31AM +0200, David Marchand wrote:
> > Doing arithmetics with the NULL pointer is undefined.
> >
> > Caught by UBSan:
> >
> > ../lib/cmdline/cmdline_parse_portlist.c:40:19: runtime error:
> >       applying non-zero offset 1 to null pointer
> > SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
> >       ../lib/cmdline/cmdline_parse_portlist.c:40:19 in
> >
> > Fixes: af75078fece3 ("first public release")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
> >  lib/cmdline/cmdline_parse_portlist.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/lib/cmdline/cmdline_parse_portlist.c b/lib/cmdline/cmdline=
_parse_portlist.c
> > index ef6ce223b5..0c07cc02b5 100644
> > --- a/lib/cmdline/cmdline_parse_portlist.c
> > +++ b/lib/cmdline/cmdline_parse_portlist.c
> > @@ -4,6 +4,7 @@
> >   * All rights reserved.
> >   */
> >
> > +#include <stdbool.h>
> >  #include <stdio.h>
> >  #include <stdlib.h>
> >  #include <string.h>
> > @@ -37,10 +38,11 @@ parse_ports(cmdline_portlist_t *pl, const char *str=
)
> >       const char *first, *last;
> >       char *end;
> >
> > -     for (first =3D str, last =3D first;
> > -         first !=3D NULL && last !=3D NULL;
> > -         first =3D last + 1) {
>
> Maybe I'm a little slow this morning, but I can't see how this is actuall=
y
> a problem. By my understanding, the check for "first !=3D NULL && last !=
=3D
> NULL" happens before any increment of "first =3D last + 1", meaning we ar=
e
> guaranteed that the last is never null when we increment it.

Well, not sure I follow, but the problem is not at the first
iteration, if this is what you mean.

On the last iteration of the parsing, there is no , left in the string
that is parsed so last =3D strchr(first, ',') makes last =3D=3D NULL.
Then the first variable is set to last + 1 *before* evaluating the end
condition.

I removed this patch of the series, rerun the test and I see:

9/75 DPDK:fast-tests / cmdline_autotest               OK              0.22s
09:20:08 DPDK_TEST=3Dcmdline_autotest MALLOC_PERTURB_=3D169
/home/runner/work/dpdk/dpdk/build/app/dpdk-test --no-huge -m 2048 -d
/home/runner/work/dpdk/dpdk/build/drivers
----------------------------------- output --------------------------------=
---
stdout:
RTE>>cmdline_autotest
Testind parsing ethernet addresses...
Testind parsing port lists...
Testind parsing numbers...
Testing parsing IP addresses...
Testing parsing strings...
Testing circular buffer...
Testing library functions...
Test OK
RTE>>
stderr:
EAL: Detected CPU lcores: 4
EAL: Detected NUMA nodes: 1
EAL: Detected shared linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
EAL: Selected IOVA mode 'VA'
APP: HPET is not enabled, using TSC as default timer
../lib/cmdline/cmdline_parse_portlist.c:44:19: runtime error: applying
non-zero offset 1 to null pointer
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
../lib/cmdline/cmdline_parse_portlist.c:44:19 in
---------------------------------------------------------------------------=
---


--=20
David Marchand

