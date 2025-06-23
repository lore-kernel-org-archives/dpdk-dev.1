Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A68C7115B
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Jun 2025 09:33:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D805402DF;
	Mon, 23 Jun 2025 11:33:08 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id C459240041
 for <dev@dpdk.org>; Mon, 23 Jun 2025 11:33:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750671185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K5mC2lWadMcO+NFWfeWZLS91i2dZ/ao9sOXJqAfT7IA=;
 b=GRE1lbhInzhU72zuJet5ct/oaDZ4OwZ2LcsYkP8ELYihS2cmvetSmZ+z1iFAUDfRxCDLrw
 x6licgHE1xUbvv7Nd8QuYYTZptwlUHAkctMwa3646kcW07nFixULlo++dclCFTr+hZbZ1n
 3x4GzQvtbF1FjeUTTJLW37Hk9849A/Y=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-l4rUkVa8PBikJKZKov-Vzw-1; Mon, 23 Jun 2025 05:33:03 -0400
X-MC-Unique: l4rUkVa8PBikJKZKov-Vzw-1
X-Mimecast-MFC-AGG-ID: l4rUkVa8PBikJKZKov-Vzw_1750671178
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-553acdcd5a1so2067045e87.2
 for <dev@dpdk.org>; Mon, 23 Jun 2025 02:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750671177; x=1751275977;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K5mC2lWadMcO+NFWfeWZLS91i2dZ/ao9sOXJqAfT7IA=;
 b=YDuJTCY+/DpyWzO3Ag5f8a7MvzSmGj1HOvmodusRQW5Oey1A5D9i2hgZ0DS72bI8HW
 8KbfxtbAd15WFFhPGnB/Sljqh866+jU8bNVpzuIYzUUppARsgz8K6XWh/ISJUzyOxanY
 PezRy00JGmcAxfM4hGVVuoIxeiBGR9/Db7gBpXMystwKDygVP4Fmyo4ETqA7zzQZjDJt
 uj9jFQxtS1XyKPcn3EZi+QzjwcA7hQ3bmpqpx6o7CqHv0WSKD1yfPlvfph3mvb1oUnS+
 bZ1SSTV8fK7O2YkMrBpK3sD42SvWKfXoaLmwI0kLyZ197ILcYxSHs2dVlEu3FUuMdK27
 KSQg==
X-Gm-Message-State: AOJu0Yy0BoWTAJUaIkSB/8OeFvGwdVo0EoMczOzVkM+/kawJqxK7rvAN
 880AMTnr5EOBJWA/Wy7DEA86tAT2nGlpR7JMtPgC4f2qklw5OJNA2OZ63S4o7UaLg4tTVTu5Ne5
 /NnM4Jo/sxqTcqEM+pShg0YAwZECtAwx0hp7PbBJZazxjmje6Cutl0pyvDIk+nWP+F4dT6sZT43
 0+NCy6AttEQmnKcOGblIk=
X-Gm-Gg: ASbGncvJ2fEKpfHoEpz0xuoNy6sOw4KWUt+gHwkWY9j9nm7Z3KP04hn62YDR7FhXXWe
 pyhemKf4entIRMEw+WfEeImqliHyeHnulTBu6pUM8+/CX9FVftPS4YnbgV+HG4pgsccZFWUdWJo
 YmTu7O3w==
X-Received: by 2002:a05:6512:110f:b0:553:2eff:8d74 with SMTP id
 2adb3069b0e04-553e3c076f6mr3716185e87.42.1750671177566; 
 Mon, 23 Jun 2025 02:32:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6eNVLu3obko6CgPut+CaEDnilL28SejfoGuhv8Bh3URnwoFS4cWRJ04Zp2n0ASllqzF1aoSBH/5oVirL5JIw=
X-Received: by 2002:a05:6512:110f:b0:553:2eff:8d74 with SMTP id
 2adb3069b0e04-553e3c076f6mr3716172e87.42.1750671177130; Mon, 23 Jun 2025
 02:32:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250619071037.37325-7-david.marchand@redhat.com>
 <aFUoJKk95dFnOy0Y@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aFUoJKk95dFnOy0Y@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 23 Jun 2025 11:32:43 +0200
X-Gm-Features: AX0GCFsnxmf7c9ldCPi2hW6123nXdHuik9YwATakJCdPtlY61cw8AF_HvjiW7As
Message-ID: <CAJFAV8zFijpsajyvu=6LJLh2ZSConPO3=rW+8iWC3y+mP005Rw@mail.gmail.com>
Subject: Re: [PATCH 06/10] cmdline: fix highest bit port list parsing
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wwI5QXUT9rx3qQUVZujSrSUnTW7AwrxhV3Ia4pVeyBc_1750671178
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

On Fri, Jun 20, 2025 at 11:22=E2=80=AFAM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Thu, Jun 19, 2025 at 09:10:32AM +0200, David Marchand wrote:
> > pl->map is a uint32_t.
> >
> > Caught by UBSan:
> >
> > ../lib/cmdline/cmdline_parse_portlist.c:27:17: runtime error:
> >       left shift of 1 by 31 places cannot be represented in type 'int'
> > SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
> >       ../lib/cmdline/cmdline_parse_portlist.c:27:17 in
> >
> > Fixes: af75078fece3 ("first public release")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
> >  lib/cmdline/cmdline_parse_portlist.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/cmdline/cmdline_parse_portlist.c b/lib/cmdline/cmdline=
_parse_portlist.c
> > index 0c07cc02b5..3ef427d32a 100644
> > --- a/lib/cmdline/cmdline_parse_portlist.c
> > +++ b/lib/cmdline/cmdline_parse_portlist.c
> > @@ -11,7 +11,9 @@
> >  #include <errno.h>
> >
> >  #include <eal_export.h>
> > +#include <rte_bitops.h>
> >  #include <rte_string_fns.h>
> > +
> >  #include "cmdline_parse.h"
> >  #include "cmdline_parse_portlist.h"
> >
> > @@ -27,7 +29,7 @@ static void
> >  parse_set_list(cmdline_portlist_t *pl, size_t low, size_t high)
> >  {
> >       do {
> > -             pl->map |=3D (1 << low++);
> > +             pl->map |=3D RTE_BIT32(low++);
> >       } while (low <=3D high);
> >  }
> >
> While this is correct, the use of "++" in a call to a macro sets off some
> alarm bells for me!
> Can we put the "++" in the while instead, as "++low"?

It would be safer yes.


--=20
David Marchand

