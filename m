Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B72C282D1
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 15:53:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E16EB406B6;
	Thu,  6 Mar 2025 16:53:04 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 33ADB4069F
 for <dev@dpdk.org>; Thu,  6 Mar 2025 16:53:03 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 535BF21104BC; Thu,  6 Mar 2025 07:53:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 535BF21104BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741276382;
 bh=X/RkRdQlas7Ebke7zcJAgdSrJ6m/xb9BqJQJnkFk0xY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OZOG1WwQIBS7LTrOLHstewK5MHDoKBztAzGJVEyQxEOKzwOk8uUAT0xbBP1nYhN8p
 O4zBckc8XlA+vgj3IJBj1Xhz9LUz9w2YRHL75FTd/d2EgeQzlQtCjYKMIV0M9lNM1k
 PXiikGiWV5Nc58KBCn1KmukzmZkDOWjNdd13xPto=
Date: Thu, 6 Mar 2025 07:53:02 -0800
From: Andre Muezerie <andremue@linux.microsoft.com>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 3/5] eal: update versioning macros
Message-ID: <20250306155302.GC28298@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1739224265-4158-1-git-send-email-andremue@linux.microsoft.com>
 <1739929198-28432-1-git-send-email-andremue@linux.microsoft.com>
 <1739929198-28432-4-git-send-email-andremue@linux.microsoft.com>
 <CAJFAV8xtTE9nfCXLNm_4htFDSohs3=feCsNotDRxQU589rfxEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8xtTE9nfCXLNm_4htFDSohs3=feCsNotDRxQU589rfxEA@mail.gmail.com>
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

On Thu, Mar 06, 2025 at 01:59:34PM +0100, David Marchand wrote:
> On Wed, Feb 19, 2025 at 2:40 AM Andre Muezerie
> <andremue@linux.microsoft.com> wrote:
> >
> > When compiling with MSVC the error below shows up due to function
> > versioning:
> >
> > ../lib/net/rte_net_crc.c(418): error C2061: syntax error:
> >     identifier '__attribute__'
> >
> > MSVC allows alias function names to be exported, but the mechanism is
> > different than the one used by gcc. It was considered to enhance the logic
> > in the existing version.map files but that file is also passed to other
> > tools on Linux, making this challenging. A simpler approach is to have an
> > optional version.map file to be used only when Microsoft's linker is to be
> > used. This optional map file is only necessary for libraries that have
> > versioned code.
> >
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > ---
> >  lib/eal/include/rte_function_versioning.h | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/lib/eal/include/rte_function_versioning.h b/lib/eal/include/rte_function_versioning.h
> > index eb6dd2bc17..aa3165a659 100644
> > --- a/lib/eal/include/rte_function_versioning.h
> > +++ b/lib/eal/include/rte_function_versioning.h
> > @@ -82,6 +82,13 @@
> >   */
> >  #define MAP_STATIC_SYMBOL(f, p)
> >
> > +/*
> > + * MAP_STATIC_BASE_SYMBOL
> > + * Has the same purpose as MAP_STATIC_SYMBOL, but takes a base function name
> > + * instead of the whole function prototype. It is used to support MSVC.
> > + */
> > +#define MAP_STATIC_BASE_SYMBOL(b, p)
> > +
> >  #else
> >  /*
> >   * No symbol versioning in use
> > @@ -90,7 +97,19 @@
> >  #define VERSION_SYMBOL_EXPERIMENTAL(b, e)
> >  #define __vsym
> >  #define BIND_DEFAULT_SYMBOL(b, e, n)
> > +
> > +#ifdef RTE_TOOLCHAIN_MSVC
> > +#define MAP_STATIC_SYMBOL(f, p)
> 
> I would prefer we trigger an explicit error when some code calling
> MAP_STATIC_SYMBOL() is built with MSVC.
> 
> 
> > +#define MAP_STATIC_BASE_SYMBOL(b, p) __pragma(comment(linker, "/alternatename:" #b "=" #p))
> > +/*
> > + * version.map file should also be updated with "b=p;", like
> > + *     rte_net_crc_set_alg=rte_net_crc_set_alg_v26;
> > + */
> > +#else
> >  #define MAP_STATIC_SYMBOL(f, p) f __attribute__((alias(RTE_STR(p))))
> > +#define MAP_STATIC_BASE_SYMBOL(b, p)
> > +#endif
> > +
> 
> But in any case, I don't like as we end up with one macro for each linker.
> 
> I have been thinking about this topic, and I sent a RFC series, please
> have a look.
> https://patchwork.dpdk.org/project/dpdk/list/?series=34798
> 
> I hope this type of approach will also make it possible to stop
> converting from GNU linker type version.map commited in DPDK to
> Windows linker format.
> 

I like what you're proposing. This makes DPDK less coupled with the GNU linker and
therefore easier to be supported by other toolsets.

> 
> -- 
> David Marchand
