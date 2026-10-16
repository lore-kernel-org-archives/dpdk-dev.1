Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2D8CCA46C
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 14:52:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14181402E9;
	Fri, 16 Oct 2026 16:52:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2170340291
 for <dev@dpdk.org>; Fri, 16 Oct 2026 16:52:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792162329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=67qLlK811itnAvFHzS+KsAuXqRpt6uB6ztltBmA4mcM=;
 b=LlHTm+O3MLwCoVPpeqzFDXUZGhCC9Y3LIYk1XtCek/Eyd+p/ozXEN7ekp7VylUZ9s2Z+oY
 NXawaDbwqjPExo5h2QxsBknDUxAJ12jCteNGliM17gP8BNLTfdah0PBEw053O2sEqWek1g
 mw4MaixMspA3dtwIL2iLr6uAV30YTIQ=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-z1U5BHD4PDyDeATjsfABwA-1; Fri, 16 Oct 2026 14:52:05 +0000
X-MC-Unique: z1U5BHD4PDyDeATjsfABwA-1
X-Mimecast-MFC-AGG-ID: z1U5BHD4PDyDeATjsfABwA_1792162324
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-3a99420f912so221301fa.1
 for <dev@dpdk.org>; Fri, 16 Oct 2026 07:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792162324; x=1792767124;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=67qLlK811itnAvFHzS+KsAuXqRpt6uB6ztltBmA4mcM=;
 b=Bw24fFMR4wnAZan9XFDdIMDi72ZtixZItfaXH/o5iV5yd3hafLZJBU3S00SKX6yPGq
 C4xbTkLXG6RcTmKeKmF1liD2gI4rwFt/teL4D1ByzpvOx9c1vHfEc1SnwyqlEsNQSfhB
 9oQbCihwB9FpoTcZ0ukBfz4o3C8vLE7eKYHuCQd0rro9TL0J6xhmFOpG88CXR/MwSy/U
 2ly8JwHv3BekqL+IHUxxf72KYeLs6OWlYw70Xscya6dYVvxmrXs3NcoXFbA4UqmAl6Pk
 nqD2IfwxH+1iGCZGpWXF/epVjZnH+t9/l7lW45/Zqqr72oH/oM/mrl0KIwlumwFJHrXb
 JCqw==
X-Gm-Message-State: AFq9FYKDFHzVvD7crQwRGU2zFd0ykXl/Hhb+waTh4i+p5ZLJrIfBhZDr
 5yfyjCcQDrs5Us7VqTB7tlACnfWrS76CWFYKQvDAp6s+cmZDjNmBnv5SVd0caHPpMT+VVPUcgkC
 y7bv14Na52VChrIKCR2XtUxwFQexXveXjFuDyjPWTlhBS60D675F7q+IvtfLJYPcPkqxnH3FpGB
 Lz29epa3LYf3XV/Alan8U=
X-Gm-Gg: AYBFou14X/HhjVCFl1OxLPBS8zPvSWS70+GjCVbrmODNxbUBbSJIHgW/fF5KAtJMcRm
 YVENEP/CG0qnwLMjKbVJuprkdgjNmto2FtxNunY/a4NaGofE0DOa+lHmfhS4bj9cTesoi5SPuAK
 R3114UhS5RYB+UWCzVq74XX+vvysaGvlTK+wUAbsq03hG2bhjxP+ruqCQexutr49ZT3GT95dgA5
 vbmOK1GF6ewCsA82+KLGxG535lwEuSpPknpGmuH+gwZ/pOU
X-Received: by 2002:a05:651c:19a8:b0:3ab:25af:6cd2 with SMTP id
 38308e7fff4ca-3ab25af6ee4mr1176561fa.9.1792162323982; 
 Fri, 16 Oct 2026 07:52:03 -0700 (PDT)
X-Received: by 2002:a05:651c:19a8:b0:3ab:25af:6cd2 with SMTP id
 38308e7fff4ca-3ab25af6ee4mr1176481fa.9.1792162323378; Fri, 16 Oct 2026
 07:52:03 -0700 (PDT)
MIME-Version: 1.0
References: <20261016105950.273068-1-bruce.richardson@intel.com>
 <CAJFAV8zGPrMZMJU-8rF5GiGqQMBaN8H707h_Y_Hss3u8EHgZ9A@mail.gmail.com>
 <atI4Vo8qoomdEOHo@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <atI4Vo8qoomdEOHo@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 16 Oct 2026 16:51:48 +0200
X-Gm-Features: AclHuK8F_mPeqr_2b_Bpw9m4j-W-X_n4R1KkPK_6n3pZKOm3YlcLovB95Ra7cjc
Message-ID: <CAJFAV8w9E1fmTQ5+xbkUdX2zxJGnj4AfiirLQLkHtE45g=73yw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/12] Add config-time dependency tracking
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8kJXSuv4moV6M7A7Y9gGlF9mUbLUO0CeiB5MO8KCtVs_1792162324
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

On Fri, 16 Oct 2026 at 16:44, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Fri, Oct 16, 2026 at 04:35:51PM +0200, David Marchand wrote:
> > On Fri, 16 Oct 2026 at 13:00, Bruce Richardson
> > <bruce.richardson@intel.com> wrote:
> > >
> > > Add configuration time dependency tracking for libs and drivers in DPDK,
> > > so that when a user requests a driver, all dependent drivers also get
> > > enabled. Similarly with libraries. What is not enabled in this RFC is
> > > support for enabling libraries based on driver requests, or enabling
> > > either libs or drivers based on the enable-apps config option. I've
> > > omitted the former for now, because it would involve moving more logic
> > > out of the lib/meson.build file and drivers/meson.build files into the
> > > top-level one, something I'm a little hesitant to do for now. The
> > > addition of apps only adds value once the cross-type dependency tracking
> > > is enabled, since no app depends on any others.
> > >
> > > The first 5 patches in this series are cleanups and bug fixes. The
> > > following patches then implement the dependency tracking. While I
> > > investigated having meson parse each components meson.build file
> > > initially, without actually building it, this failed to work due to
> > > logic other than variable assignments in many drivers.
> > >
> > > Instead, python scripts are used to manage the dependency list. For
> > > easier debug, and future introspection this dependency management is
> > > split between two scripts - the first generates a dependency table file
> > > which it writes to the build folder, allowing us to analyse this
> > > post-build if so desired. The second script uses this file to actually
> > > compute the necessary per-component dependencies.
> > >
> > > The final patch of the series is a major reduction in the number of
> > > required components for doing DPDK builds. We completely remove the list
> > > of required libraries, and assume that a minimal build should only
> > > require enough libraries to build EAL. However, EAL does assume that we
> > > have a few additional buses, for example, EAL args are present for pci
> > > and vdev. Also, in order for mempools to work, we always need to have
> > > the default mempool ring driver build. That means that our de-facto
> > > minimal build target set is the set of components needed to build
> > > "bus/pci,bus/vdev,mempool/ring" (which would include EAL in the output,
> > > which is why we can remove any hard-coded library lists)
> > >
> > > Bruce Richardson (12):
> > >   build: fix name of base library object
> > >   build: fix ignoring requested driver when class is disabled
> > >   build: prevent overlap of enable and disable lists
> > >   build: add direct support for optional dependencies
> > >   net/bond: rename directory for consistency
> > >   build: add script to generate dependencies list
> > >   build: use recursive addition for enabled libraries option
> > >   build: use recursive addition for enabled drivers option
> > >   build: improve error reporting for unbuildable components
> > >   build: add EAL common directory to global include list
> > >   build: make EAL an explicit dependency
> > >   build: simplify mandatory library lists
> > >
> > >  MAINTAINERS                                   |   2 +-
> > >  app/meson.build                               |  15 +-
> > >  app/proc-info/meson.build                     |   4 +-
> > >  app/test-bbdev/meson.build                    |  18 +-
> > >  app/test-crypto-perf/meson.build              |   4 +-
> > >  app/test-pmd/meson.build                      |  50 ++---
> > >  app/test/meson.build                          |   6 -
> > >  buildtools/get-deps.py                        | 203 ++++++++++++++++++
> > >  buildtools/meson.build                        |   2 +
> > >  buildtools/resolve-deps.py                    |  80 +++++++
> > >  devtools/test-meson-builds.sh                 |   3 +-
> > >  doc/api/doxy-api.conf.in                      |   2 +-
> > >  .../link_bonding_poll_mode_drv_lib.rst        |   2 +-
> > >  doc/guides/testpmd_app_ug/testpmd_funcs.rst   |   2 +-
> > >  drivers/common/mlx5/linux/meson.build         |   1 -
> > >  drivers/meson.build                           |  85 ++++++--
> > >  .../net/{bonding => bond}/bonding_testpmd.c   |   0
> > >  .../eth_bond_8023ad_private.h                 |   0
> > >  .../net/{bonding => bond}/eth_bond_private.h  |   0
> > >  drivers/net/{bonding => bond}/meson.build     |   1 -
> > >  drivers/net/{bonding => bond}/rte_eth_bond.h  |   0
> > >  .../{bonding => bond}/rte_eth_bond_8023ad.c   |   0
> > >  .../{bonding => bond}/rte_eth_bond_8023ad.h   |   0
> > >  .../net/{bonding => bond}/rte_eth_bond_alb.c  |   0
> > >  .../net/{bonding => bond}/rte_eth_bond_alb.h  |   0
> > >  .../net/{bonding => bond}/rte_eth_bond_api.c  |   0
> > >  .../net/{bonding => bond}/rte_eth_bond_args.c |   0
> > >  .../net/{bonding => bond}/rte_eth_bond_flow.c |   0
> > >  .../net/{bonding => bond}/rte_eth_bond_pmd.c  |   0
> > >  drivers/net/intel/ice/meson.build             |   7 +-
> > >  drivers/net/meson.build                       |   2 +-
> > >  lib/acl/meson.build                           |   1 +
> > >  lib/cfgfile/meson.build                       |   1 +
> > >  lib/cryptodev/meson.build                     |   2 +-
> > >  lib/dmadev/meson.build                        |   2 +-
> > >  lib/eal/meson.build                           |   6 +-
> > >  lib/ethdev/meson.build                        |   2 +-
> > >  lib/eventdev/meson.build                      |   1 -
> > >  lib/ipsec/meson.build                         |   2 +-
> > >  lib/jobstats/meson.build                      |   1 +
> > >  lib/log/meson.build                           |   1 -
> > >  lib/mempool/meson.build                       |   2 +-
> > >  lib/meson.build                               |  76 +++----
> > >  lib/meter/meson.build                         |   1 +
> > >  lib/metrics/meson.build                       |   2 +-
> > >  lib/pci/meson.build                           |   1 +
> > >  lib/ptr_compress/meson.build                  |   1 +
> > >  lib/rawdev/meson.build                        |   2 +-
> > >  lib/ring/meson.build                          |   2 +-
> > >  lib/stack/meson.build                         |   1 +
> > >  lib/timer/meson.build                         |   1 +
> > >  meson.build                                   |  21 ++
> > >  52 files changed, 478 insertions(+), 140 deletions(-)
> > >  create mode 100644 buildtools/get-deps.py
> > >  create mode 100644 buildtools/resolve-deps.py
> > >  rename drivers/net/{bonding => bond}/bonding_testpmd.c (100%)
> > >  rename drivers/net/{bonding => bond}/eth_bond_8023ad_private.h (100%)
> > >  rename drivers/net/{bonding => bond}/eth_bond_private.h (100%)
> > >  rename drivers/net/{bonding => bond}/meson.build (95%)
> > >  rename drivers/net/{bonding => bond}/rte_eth_bond.h (100%)
> > >  rename drivers/net/{bonding => bond}/rte_eth_bond_8023ad.c (100%)
> > >  rename drivers/net/{bonding => bond}/rte_eth_bond_8023ad.h (100%)
> > >  rename drivers/net/{bonding => bond}/rte_eth_bond_alb.c (100%)
> > >  rename drivers/net/{bonding => bond}/rte_eth_bond_alb.h (100%)
> > >  rename drivers/net/{bonding => bond}/rte_eth_bond_api.c (100%)
> > >  rename drivers/net/{bonding => bond}/rte_eth_bond_args.c (100%)
> > >  rename drivers/net/{bonding => bond}/rte_eth_bond_flow.c (100%)
> > >  rename drivers/net/{bonding => bond}/rte_eth_bond_pmd.c (100%)
> >
> > Interesting series.
> >
> > I did not review in depth, but it seems promising.
> > The first 4 (and maybe the 5th one) patches can go to 26.11 right now.
> >
> > I noticed a little formatting issue in patch 9 commitlog.
> >
> > One thing bothers me.. but I did not play enough with the options maybe...
> >
> > Could we use new build options (request_libs/apps/drivers or better named) ?
> > This series changes the enable_libs/apps/drivers semantics and will
> > likely result in confused users.
> > (and we would need no support for mixing old and new options)
> >
> Can you clarify how it changes the semantic from a user viewpoint? Unless
> I'm missing something, the only change is automatically fixing a broken
> build for a user who didn't know the dependencies of the driver they want
> enabled.

Well, the fact that everything becomes optional is a change in
behavior, and enable_drivers=net/null not enabling ethdev is a problem
to me.
Or I misunderstood the last patch comments.


-- 
David Marchand

