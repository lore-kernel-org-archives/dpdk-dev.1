Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33E5C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 16:11:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D311A40289;
	Wed,  5 Feb 2025 17:11:36 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 7B17040270
 for <dev@dpdk.org>; Wed,  5 Feb 2025 17:11:35 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 94673203718D; Wed,  5 Feb 2025 08:11:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 94673203718D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738771894;
 bh=0uGFcrUMqs1oF6BCiE7j5yVCp4PmKH+Hy/rH1GDeEXg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SK7xMdf9MTRqAHQesJlz5P1lNoHTedxBwwjea1jQmstujlnwF4i8ATGe9cL1huYPY
 NgH4RiqGIRZD6U4hTxkz/uYInIFfHh3jqU+0uCXO6lJxmSA8zVUXLR6GJMDqpsDUgg
 I55aruQaBXKK+LAhbtid49o/RcmCDhRQ+OBSFYm4=
Date: Wed, 5 Feb 2025 08:11:34 -0800
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 "dev@dpdk.org" <dev@dpdk.org>,
 "david.marchand@redhat.com" <david.marchand@redhat.com>,
 "thomas@monjalon.net" <thomas@monjalon.net>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>
Subject: Re: [PATCH v4 0/7] eliminate dependency on non-portable
 __SIZEOF_LONG__
Message-ID: <20250205161134.GA16706@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1733342995-3722-2-git-send-email-andremue@linux.microsoft.com>
 <1738695271-29948-1-git-send-email-andremue@linux.microsoft.com>
 <Z6MsP35NONKe7wSb@bricha3-mobl1.ger.corp.intel.com>
 <20250205153721.GA9429@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <Z6OIGtUHFJOTkB95@bricha3-mobl1.ger.corp.intel.com>
 <795761cc11bf4084aa353ca77309b916@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <795761cc11bf4084aa353ca77309b916@huawei.com>
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

On Wed, Feb 05, 2025 at 03:50:03PM +0000, Konstantin Ananyev wrote:
> 
> > On Wed, Feb 05, 2025 at 07:37:21AM -0800, Andre Muezerie wrote:
> > > On Wed, Feb 05, 2025 at 09:15:43AM +0000, Bruce Richardson wrote:
> > > > On Tue, Feb 04, 2025 at 10:54:24AM -0800, Andre Muezerie wrote:
> > > > > Macro __SIZEOF_LONG__ is not standardized and MSVC does not define it.
> > > > > Therefore the errors below are seen with MSVC:
> > > > >
> > > > > ../lib/mldev/mldev_utils_scalar.c(465): error C2065:
> > > > >     '__SIZEOF_LONG__': undeclared identifier
> > > > > ../lib/mldev/mldev_utils_scalar.c(478): error C2051:
> > > > >     case expression not constant
> > > > >
> > > > > ../lib/mldev/mldev_utils_scalar_bfloat16.c(33): error C2065:
> > > > >     '__SIZEOF_LONG__': undeclared identifier
> > > > > ../lib/mldev/mldev_utils_scalar_bfloat16.c(49): error C2051:
> > > > >     case expression not constant
> > > > >
> > > > > Turns out that the places where __SIZEOF_LONG__ is currently
> > > > > being used can equally well use sizeof(long) instead.
> > > > >
> > > > > v4:
> > > > >  * rebased on latest main as previous patch was not applying cleanly
> > > > >    anymore.
> > > > >
> > > > > v3:
> > > > >  * added prefix RTE_ to BITS_PER_LONG* and moved them to rte_common.h
> > > > >  * defined PLT_BITS_PER_LONG* in drivers/common/cnxk/roc_platform.h to
> > > > >    avoid warnings from checkpatches.sh like:
> > > > >
> > > > >    Warning in drivers/common/cnxk/roc_bits.h:
> > > > >    Warning in drivers/common/cnxk/roc_ie_ot.h:
> > > > >    Warning in drivers/common/cnxk/roc_ie_ot_tls.h:
> > > > >    Use plt_ symbols instead of rte_ API in cnxk base driver
> > > > >
> > > > >    It can be seen that the same was done in the past for similar
> > > > >    macros like PLT_CACHE_LINE_SIZE
> > > > >
> > > > > v2:
> > > > >  * fixed typo in commit message
> > > > >
> > > > > Andre Muezerie (7):
> > > > >   eal: eliminate dependency on non-portable __SIZEOF_LONG__
> > > > >   drivers/bus: eliminate dependency on non-portable __SIZEOF_LONG__
> > > > >   drivers/common: eliminate dependency on non-portable __SIZEOF_LONG__
> > > > >   drivers/dma: eliminate dependency on non-portable __SIZEOF_LONG__
> > > > >   drivers/net: eliminate dependency on non-portable __SIZEOF_LONG__
> > > > >   drivers/raw: eliminate dependency on non-portable __SIZEOF_LONG__
> > > > >   mldev: eliminate dependency on non-portable __SIZEOF_LONG__
> > > > >
> > > > Just out of interest, is there are reason why the simple solution of just
> > > > putting "#define __SIZEOF_LONG__ (sizeof(long))" in a header file for MSVC
> > > > is not done? Should be a couple of lines in a single patch, rather than a
> > > > 7-patch series, no?
> > > >
> > > > After all, just because something is non-standard, doesn't mean that we
> > > > can't use it if its widely available.
> > > >
> > > > /Bruce
> > >
> > > Yes, that can be done instead. I'll send out a new series with that approach.
> > >
> > Maybe wait in case there is input from others before spending time on a
> > patch? I think the simpler solution is better, but others may feel that
> > removing the macro completely is the better approach.
> 
> +1 to what Bruce suggested.
>  

Thomas also mentioned he would prefer to minimize changes. I'm fine with that too, as
that is good enough to get the code to compile with MSVC.
