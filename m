Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C30C36002
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Apr 2025 13:42:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C97C402F0;
	Wed,  9 Apr 2025 15:42:13 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 7F2B4402B7
 for <dev@dpdk.org>; Wed,  9 Apr 2025 15:42:11 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id C81522027DE8; Wed,  9 Apr 2025 06:42:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C81522027DE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1744206130;
 bh=e9qqwvScndnXUWDw5hU0V1ae6NjGMziIOhVFT3elPfo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hE1L7MkYDMSAK5TPMVQkAkObo97PfOAQzJFNZbqECLzDalA6peQRz+xpcjc3LaPFz
 lkQ87vuRNEY9ndNXYIPkL3GGzmrWW2ZZmZa/30mR+91lka094MKJvEIlLbZngiqNCs
 rXjYZgXhQWHBe0UB69r3/PAShQ+J8X6SnAD5d3fU=
Date: Wed, 9 Apr 2025 06:42:10 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH v4 1/1] mbuf: enable to be compiled with MSVC
Message-ID: <20250409134210.GA24610@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1739224265-4158-1-git-send-email-andremue@linux.microsoft.com>
 <1744147477-23715-1-git-send-email-andremue@linux.microsoft.com>
 <1744147477-23715-2-git-send-email-andremue@linux.microsoft.com>
 <CAJFAV8xCqwbMEsf83Um-m=Kn1n=SU9k1bpB2jtuhjPFDQiJs3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8xCqwbMEsf83Um-m=Kn1n=SU9k1bpB2jtuhjPFDQiJs3w@mail.gmail.com>
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

On Wed, Apr 09, 2025 at 01:39:36PM +0200, David Marchand wrote:
> On Tue, Apr 8, 2025 at 11:24 PM Andre Muezerie
> <andremue@linux.microsoft.com> wrote:
> > diff --git a/lib/net/meson.build b/lib/net/meson.build
> > index 7a6c419f40..c528fcc9a2 100644
> > --- a/lib/net/meson.build
> > +++ b/lib/net/meson.build
> > @@ -43,7 +43,12 @@ use_function_versioning = true
> >
> >  if dpdk_conf.has('RTE_ARCH_X86_64')
> >      sources += files('net_crc_sse.c')
> > -    cflags += ['-mpclmul', '-maes']
> > +    cflags_options = ['-mpclmul', '-maes']
> > +    foreach option:cflags_options
> > +        if cc.has_argument(option)
> > +            cflags += option
> > +        endif
> > +    endforeach
> 
> What guarantee do we have that MSVC builds with those instructions?
> 

The granularity msvc offers for extended instruction sets is different.
I had sent a patch that allows DPDK code to benefit from those settings,
but it likely needs to be updated after recent changes were merged. I'll
revisit that in the next few days.

For reference, here is what the original patch series looked like:
https://patches.dpdk.org/project/dpdk/list/?series=34803

> >      # only build AVX-512 support if we also have PCLMULQDQ support
> >      if cc.has_argument('-mvpclmulqdq')
> >          sources_avx512 += files('net_crc_avx512.c')
> 
> 
> -- 
> David Marchand
