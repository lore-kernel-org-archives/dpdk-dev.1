Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD964C02194
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 15:37:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23E42402E9;
	Wed,  5 Feb 2025 16:37:24 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 82E5C402E6
 for <dev@dpdk.org>; Wed,  5 Feb 2025 16:37:22 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id B17842037185; Wed,  5 Feb 2025 07:37:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B17842037185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738769841;
 bh=kX7PlsY2LRhHyjTtlzO2PIKd+A/wWXpS+f/bsuTvRSs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RV+YWqcsUd56R6tFyuWLadXfmwg6VNp3vwcZ5Nv5yp+qHWrXhxwBnr6dAyWYC6UCl
 kQ57Jx2r0j9Qpp2wslBwcGHqv0a0mKbeyls4PCPzp4/CbvC+x1GKfO/km7/NFaUmn/
 n7sFcYmwNi260hqStKDiv30C1UDUxI40mRLtfgZ4=
Date: Wed, 5 Feb 2025 07:37:21 -0800
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 0/7] eliminate dependency on non-portable
 __SIZEOF_LONG__
Message-ID: <20250205153721.GA9429@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1733342995-3722-2-git-send-email-andremue@linux.microsoft.com>
 <1738695271-29948-1-git-send-email-andremue@linux.microsoft.com>
 <Z6MsP35NONKe7wSb@bricha3-mobl1.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6MsP35NONKe7wSb@bricha3-mobl1.ger.corp.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
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

On Wed, Feb 05, 2025 at 09:15:43AM +0000, Bruce Richardson wrote:
> On Tue, Feb 04, 2025 at 10:54:24AM -0800, Andre Muezerie wrote:
> > Macro __SIZEOF_LONG__ is not standardized and MSVC does not define it.
> > Therefore the errors below are seen with MSVC:
> > 
> > ../lib/mldev/mldev_utils_scalar.c(465): error C2065:
> >     '__SIZEOF_LONG__': undeclared identifier
> > ../lib/mldev/mldev_utils_scalar.c(478): error C2051:
> >     case expression not constant
> > 
> > ../lib/mldev/mldev_utils_scalar_bfloat16.c(33): error C2065:
> >     '__SIZEOF_LONG__': undeclared identifier
> > ../lib/mldev/mldev_utils_scalar_bfloat16.c(49): error C2051:
> >     case expression not constant
> > 
> > Turns out that the places where __SIZEOF_LONG__ is currently
> > being used can equally well use sizeof(long) instead.
> > 
> > v4:
> >  * rebased on latest main as previous patch was not applying cleanly
> >    anymore.
> > 
> > v3:
> >  * added prefix RTE_ to BITS_PER_LONG* and moved them to rte_common.h
> >  * defined PLT_BITS_PER_LONG* in drivers/common/cnxk/roc_platform.h to
> >    avoid warnings from checkpatches.sh like:
> > 
> >    Warning in drivers/common/cnxk/roc_bits.h:
> >    Warning in drivers/common/cnxk/roc_ie_ot.h:
> >    Warning in drivers/common/cnxk/roc_ie_ot_tls.h:
> >    Use plt_ symbols instead of rte_ API in cnxk base driver
> > 
> >    It can be seen that the same was done in the past for similar
> >    macros like PLT_CACHE_LINE_SIZE
> > 
> > v2:
> >  * fixed typo in commit message
> > 
> > Andre Muezerie (7):
> >   eal: eliminate dependency on non-portable __SIZEOF_LONG__
> >   drivers/bus: eliminate dependency on non-portable __SIZEOF_LONG__
> >   drivers/common: eliminate dependency on non-portable __SIZEOF_LONG__
> >   drivers/dma: eliminate dependency on non-portable __SIZEOF_LONG__
> >   drivers/net: eliminate dependency on non-portable __SIZEOF_LONG__
> >   drivers/raw: eliminate dependency on non-portable __SIZEOF_LONG__
> >   mldev: eliminate dependency on non-portable __SIZEOF_LONG__
> > 
> Just out of interest, is there are reason why the simple solution of just
> putting "#define __SIZEOF_LONG__ (sizeof(long))" in a header file for MSVC
> is not done? Should be a couple of lines in a single patch, rather than a
> 7-patch series, no?
> 
> After all, just because something is non-standard, doesn't mean that we
> can't use it if its widely available.
> 
> /Bruce

Yes, that can be done instead. I'll send out a new series with that approach.

