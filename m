Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCA0CCD195
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 08:45:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1D1840E3E;
	Fri, 17 Oct 2025 10:45:34 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id F0E2C40269
 for <dev@dpdk.org>; Fri, 17 Oct 2025 10:45:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760690732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YZPZCsWJnBUFDPg/DFa8HB3i6HOr5hSzJcw/+l1FCnA=;
 b=hDpmEALeraDGK+kHppTQBzSyLc/bkIfa6f56v1ns4H68/1mwT543es18Q95l7vmxii08b1
 CDrC7Wc3qAR2I5nrNw/T4HdpOw9QUhi+K3GwIWJFUSA1v6weJI7cBAOgc42GXf1Z4Blj7+
 jqc+Frr9ZJx4RVco0tbexSMNr17yoKE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-OgcSYmvSMqivqvWT1T5jLg-1; Fri, 17 Oct 2025 04:45:28 -0400
X-MC-Unique: OgcSYmvSMqivqvWT1T5jLg-1
X-Mimecast-MFC-AGG-ID: OgcSYmvSMqivqvWT1T5jLg_1760690727
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-57986226b53so1536288e87.3
 for <dev@dpdk.org>; Fri, 17 Oct 2025 01:45:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760690727; x=1761295527;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YZPZCsWJnBUFDPg/DFa8HB3i6HOr5hSzJcw/+l1FCnA=;
 b=kVYRO8BvEzQhuc/j/h8eu9Ew4mCTYRSEineaeYNRSfROhBUPbWJMYwPnLelhpizO5+
 ySZDf9xhI6FYh2TNP7jCz0Xbf+/aoKwJI0NN8tTacZA0CTEkQ+GfGnBgYqJI6KjQjI6q
 eNup8TiwXtbffkQpL/2etWMMWUCDzTwsms3v7VnUbdZ74k+5h6S+CZByzUIAHblGHtv8
 tp/Jj5BYxroetUFw3Ei+9dbpTlG2mH9CeQO+XFehvlI+zSsLg9NRPR7NdK5OG9WOwzTQ
 I5PgdzduAS6cqvFK3jxZEfia7jCazkpU4MofQ7bxs0+t18BQ5B7xHAO07Wn6pipodHmW
 DfnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/FsENuPDLA/ga4uVnFl17KCCwxtzIpmdxc+XFvEAWBeV6gm1FSUegaQeZwru1APjQiCM=@dpdk.org
X-Gm-Message-State: AOJu0YxON2FyqzpCVIA/fxV7Jip4YpP+tzUrtJSuzitTZh3dUCqpzCl5
 kxjjYU2Sudj95VI4SrI2v+JKYMuEN441Ha6YIxgR/AMBWS5QKVOJBXuTHYWTm43dcJkB0lcozLH
 tBvqBaezGyNdl/k0OPYYush+L2ZeN+ixj0EGmDAxnfy15dYsG0F2iMEb4EYQTPejEsD55lb+QPz
 mdwNTqXrSLlJuMewbDHIk=
X-Gm-Gg: ASbGnctzyO8EIx77P0u68LpRqoy7vOC+XRzSP6FsvtnaquURjUD7FO/t3M2VO6WKkpy
 NnmFniAfCInbERsJK4o7mQKAij8TsnNDFYBJa9ZdU6sqIadOpiqcYNrZwXq3kmB03xvGTGAsHtG
 lCa5hf56Eqf/GoaVf+bjypumNmDsZiBArHSf7YUQViprnDCDbqHBlBPqj79w==
X-Received: by 2002:a05:6512:3e10:b0:57b:66c1:3a48 with SMTP id
 2adb3069b0e04-591d8552b74mr908651e87.34.1760690727032; 
 Fri, 17 Oct 2025 01:45:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlaSJJYqRGlKN7MCu0NOt1pEst+Y3E08rWAEe47aYo2WV3hT/ajHKCxlr1DdVDjXDK/v0A1VKjlDn6sw6Wr88=
X-Received: by 2002:a05:6512:3e10:b0:57b:66c1:3a48 with SMTP id
 2adb3069b0e04-591d8552b74mr908642e87.34.1760690726596; Fri, 17 Oct 2025
 01:45:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250808112758.454346-1-tduszynski@marvell.com>
 <20251017065825.3242639-1-tduszynski@marvell.com>
In-Reply-To: <20251017065825.3242639-1-tduszynski@marvell.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 17 Oct 2025 10:45:14 +0200
X-Gm-Features: AS18NWBChMX99PVgRw1mFe8qx-g0IuRPvv1DoNCVP60nxXYDycBe2OpvBTRPfHg
Message-ID: <CAJFAV8wGnXv4gO+0pf3e6gw0ahFH7q0JbMfiaGDjY9hBBX=_Pw@mail.gmail.com>
Subject: Re: [PATCH v10 03/10] lib/pmu: quiesce rte_pmu_read deprecation
 warning in chkincs
To: Tomasz Duszynski <tduszynski@marvell.com>
Cc: bruce.richardson@intel.com, dev@dpdk.org, jerinj@marvell.com, 
 mb@smartsharesystems.com, stephen@networkplumber.org, thomas@monjalon.net
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0rPPxDIQgYu7Y-T7oiFdf6USuz0vWHD8gh70xn31lP0_1760690727
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

On Fri, 17 Oct 2025 at 08:58, Tomasz Duszynski <tduszynski@marvell.com> wrote:
>
> > > > > Add a dummy rte_pmu_read() definition for chkincs when
> > > > > ALLOW_EXPERIMENTAL_API is not defined to suppress warnings from
> > > > > use of experimental APIs in tracepoints.
> > > > >
> > > > > Fixes: 960c43184c4d ("pmu: introduce library for reading PMU events")
> > > > >
> > > > > Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>
> > > > > ---
> > > > >  lib/pmu/rte_pmu.h | 4 ++++
> > > > >  1 file changed, 4 insertions(+)
> > > > >
> > > > > diff --git a/lib/pmu/rte_pmu.h b/lib/pmu/rte_pmu.h
> > > > > index 57b634ecd8..84a5d522d1 100644
> > > > > --- a/lib/pmu/rte_pmu.h
> > > > > +++ b/lib/pmu/rte_pmu.h
> > > > > @@ -232,6 +232,10 @@ rte_pmu_read(unsigned int index)
> > > > >
> > > > >         return __rte_pmu_read_userpage(group->mmap_pages[index]);
> > > > >  }
> > > > > +/* quiesce warnings produced by chkincs */
> > > > > +#ifndef ALLOW_EXPERIMENTAL_API
> > > > > +#define rte_pmu_read(pc) ({ RTE_SET_USED(pc); 0; })
> > > > > +#endif
> > > >
> > > > Seems like an awkward solution I would rather that fix chkincs
> > > > or restructure this.
> > > >
> > > > The way you are doing it will cause the checks for use
> > > > of experimental API to not work.
> > >
> > > No matter how I shuffle things around, the experimental API keeps getting called from
> > > non-experimental code, so those warnings will show up.. Fixing chkincs would mean telling it to
> > > skip checks for this library, which is basically what I'm already doing here.
> > >
> > > Dropping experimental tag feels too soon. The library still needs some time to bake.
> > >
> > > So, unless anyone has got other ideas, which is the better trade off here: yanking experimental
> > > tags or tweaking chkincs to ignore the library checks?
> >

What we have been doing in other libraries is to hide calls to
experimental symbols in inline helpers, which is the issue here,
right?
Then add a RTE_VERIFY(false) so that an abort is triggered at runtime
in case an application called this helper.

See a3e126fd58d1 ("bitset: fix build for GCC without experimental
API") for example.


I see the same #define hiding for __rte_pmu_enable_group and
__rte_pmu_read_userpage.
Something like below should be applied on main before looking at this
new series.

$ git diff
diff --git a/lib/pmu/rte_pmu.h b/lib/pmu/rte_pmu.h
index 57b634ecd8..fcf125a908 100644
--- a/lib/pmu/rte_pmu.h
+++ b/lib/pmu/rte_pmu.h
@@ -31,6 +31,7 @@
 #include <rte_branch_prediction.h>
 #include <rte_common.h>
 #include <rte_compat.h>
+#include <rte_debug.h>
 #include <rte_lcore.h>

 #define RTE_PMU_SUPPORTED
@@ -181,12 +182,6 @@ __rte_experimental
 int
 rte_pmu_add_event(const char *name);

-/* quiesce warnings produced by chkincs caused by calling internal
functions directly */
-#ifndef ALLOW_EXPERIMENTAL_API
-#define __rte_pmu_enable_group(group) ({ RTE_SET_USED(group); 0; })
-#define __rte_pmu_read_userpage(pc) ({ RTE_SET_USED(pc); 0; })
-#endif
-
 /**
  * @warning
  * @b EXPERIMENTAL: this API may change without prior notice.
@@ -211,6 +206,7 @@ __rte_experimental
 static __rte_always_inline uint64_t
 rte_pmu_read(unsigned int index)
 {
+#ifdef ALLOW_EXPERIMENTAL_API
        unsigned int lcore_id = rte_lcore_id();
        struct rte_pmu_event_group *group;

@@ -231,6 +227,10 @@ rte_pmu_read(unsigned int index)
        }

        return __rte_pmu_read_userpage(group->mmap_pages[index]);
+#else
+       RTE_SET_USED(index);
+       RTE_VERIFY(false);
+#endif
 }

 #ifdef __cplusplus


-- 
David Marchand

