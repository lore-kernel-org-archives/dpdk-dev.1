Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44359C02194
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 15:50:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 681EA40289;
	Wed,  5 Feb 2025 16:50:06 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id CFA2540270
 for <dev@dpdk.org>; Wed,  5 Feb 2025 16:50:04 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yp4R80nmzz6D8cn;
 Wed,  5 Feb 2025 23:49:08 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
 by mail.maildlp.com (Postfix) with ESMTPS id DE3EF140382;
 Wed,  5 Feb 2025 23:50:03 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500005.china.huawei.com (7.182.85.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Feb 2025 16:50:03 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 5 Feb 2025 16:50:03 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Bruce Richardson <bruce.richardson@intel.com>, Andre Muezerie
 <andremue@linux.microsoft.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "david.marchand@redhat.com"
 <david.marchand@redhat.com>, "thomas@monjalon.net" <thomas@monjalon.net>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>
Subject: RE: [PATCH v4 0/7] eliminate dependency on non-portable
 __SIZEOF_LONG__
Thread-Topic: [PATCH v4 0/7] eliminate dependency on non-portable
 __SIZEOF_LONG__
Thread-Index: AQHbdzZPK7v82IUcZE2oJ3O3FciFSLM4XeCAgABqoICAAALgAIAAEUhw
Date: Wed, 5 Feb 2025 15:50:03 +0000
Message-ID: <795761cc11bf4084aa353ca77309b916@huawei.com>
References: <1733342995-3722-2-git-send-email-andremue@linux.microsoft.com>
 <1738695271-29948-1-git-send-email-andremue@linux.microsoft.com>
 <Z6MsP35NONKe7wSb@bricha3-mobl1.ger.corp.intel.com>
 <20250205153721.GA9429@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <Z6OIGtUHFJOTkB95@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <Z6OIGtUHFJOTkB95@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.73]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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


> On Wed, Feb 05, 2025 at 07:37:21AM -0800, Andre Muezerie wrote:
> > On Wed, Feb 05, 2025 at 09:15:43AM +0000, Bruce Richardson wrote:
> > > On Tue, Feb 04, 2025 at 10:54:24AM -0800, Andre Muezerie wrote:
> > > > Macro __SIZEOF_LONG__ is not standardized and MSVC does not define =
it.
> > > > Therefore the errors below are seen with MSVC:
> > > >
> > > > ../lib/mldev/mldev_utils_scalar.c(465): error C2065:
> > > >     '__SIZEOF_LONG__': undeclared identifier
> > > > ../lib/mldev/mldev_utils_scalar.c(478): error C2051:
> > > >     case expression not constant
> > > >
> > > > ../lib/mldev/mldev_utils_scalar_bfloat16.c(33): error C2065:
> > > >     '__SIZEOF_LONG__': undeclared identifier
> > > > ../lib/mldev/mldev_utils_scalar_bfloat16.c(49): error C2051:
> > > >     case expression not constant
> > > >
> > > > Turns out that the places where __SIZEOF_LONG__ is currently
> > > > being used can equally well use sizeof(long) instead.
> > > >
> > > > v4:
> > > >  * rebased on latest main as previous patch was not applying cleanl=
y
> > > >    anymore.
> > > >
> > > > v3:
> > > >  * added prefix RTE_ to BITS_PER_LONG* and moved them to rte_common=
.h
> > > >  * defined PLT_BITS_PER_LONG* in drivers/common/cnxk/roc_platform.h=
 to
> > > >    avoid warnings from checkpatches.sh like:
> > > >
> > > >    Warning in drivers/common/cnxk/roc_bits.h:
> > > >    Warning in drivers/common/cnxk/roc_ie_ot.h:
> > > >    Warning in drivers/common/cnxk/roc_ie_ot_tls.h:
> > > >    Use plt_ symbols instead of rte_ API in cnxk base driver
> > > >
> > > >    It can be seen that the same was done in the past for similar
> > > >    macros like PLT_CACHE_LINE_SIZE
> > > >
> > > > v2:
> > > >  * fixed typo in commit message
> > > >
> > > > Andre Muezerie (7):
> > > >   eal: eliminate dependency on non-portable __SIZEOF_LONG__
> > > >   drivers/bus: eliminate dependency on non-portable __SIZEOF_LONG__
> > > >   drivers/common: eliminate dependency on non-portable __SIZEOF_LON=
G__
> > > >   drivers/dma: eliminate dependency on non-portable __SIZEOF_LONG__
> > > >   drivers/net: eliminate dependency on non-portable __SIZEOF_LONG__
> > > >   drivers/raw: eliminate dependency on non-portable __SIZEOF_LONG__
> > > >   mldev: eliminate dependency on non-portable __SIZEOF_LONG__
> > > >
> > > Just out of interest, is there are reason why the simple solution of =
just
> > > putting "#define __SIZEOF_LONG__ (sizeof(long))" in a header file for=
 MSVC
> > > is not done? Should be a couple of lines in a single patch, rather th=
an a
> > > 7-patch series, no?
> > >
> > > After all, just because something is non-standard, doesn't mean that =
we
> > > can't use it if its widely available.
> > >
> > > /Bruce
> >
> > Yes, that can be done instead. I'll send out a new series with that app=
roach.
> >
> Maybe wait in case there is input from others before spending time on a
> patch? I think the simpler solution is better, but others may feel that
> removing the macro completely is the better approach.

+1 to what Bruce suggested.
=20

