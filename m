Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA19C021B2
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 16:37:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12E1B40299;
	Tue, 25 Feb 2025 17:37:30 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 753394025E
 for <dev@dpdk.org>; Tue, 25 Feb 2025 17:37:28 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id A71BE203CDED; Tue, 25 Feb 2025 08:37:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A71BE203CDED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740501447;
 bh=3T2+91uuHseV7ed3WQvsW8ZIDBh4eBchOH5g3Gglsdo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=N4kaQeHjbNyPs+vfuDbMPeCdNHfYb9ynP+l56LqYKTmd/CzQGllPcO25Jxz1hrk17
 wtmFxR4mwncRp3GrGaUV8WnRtuzF++XzusxOPzRmrs8fxyz0QiSsfCrJ4GP8W2PFh6
 q9ty9gBm1Z5FpEuG2BcgO2STaPRXvt5M4yFAkzDE=
Date: Tue, 25 Feb 2025 08:37:27 -0800
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>, dev@dpdk.org
Subject: Re: [PATCH 5/6] acl: make compatible with instruction set updates
 for MSVC
Message-ID: <20250225163727.GA16121@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1740430879-17874-1-git-send-email-andremue@linux.microsoft.com>
 <1740430879-17874-6-git-send-email-andremue@linux.microsoft.com>
 <Z72HaaPEhxfIk2QV@bricha3-mobl1.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z72HaaPEhxfIk2QV@bricha3-mobl1.ger.corp.intel.com>
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

On Tue, Feb 25, 2025 at 09:03:37AM +0000, Bruce Richardson wrote:
> On Mon, Feb 24, 2025 at 01:01:18PM -0800, Andre Muezerie wrote:
> > Top level 'cc_avx2_flags' was created and holds the correct flags
> > depending on the compiler used.
> > 
> > File meson.build was updated to handle the correct AVX512 flags
> > depending on compiler used.
> > 
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > ---
> >  lib/acl/meson.build | 16 +++++++++-------
> >  1 file changed, 9 insertions(+), 7 deletions(-)
> > 
> > diff --git a/lib/acl/meson.build b/lib/acl/meson.build
> > index fefe131a48..24e47b6cc1 100644
> > --- a/lib/acl/meson.build
> > +++ b/lib/acl/meson.build
> > @@ -19,7 +19,7 @@ if dpdk_conf.has('RTE_ARCH_X86')
> >      avx2_tmplib = static_library('avx2_tmp',
> >              'acl_run_avx2.c',
> >              dependencies: static_rte_eal,
> > -            c_args: cflags + ['-mavx2'])
> > +            c_args: [cflags, cc_avx2_flags])
> >      objs += avx2_tmplib.extract_objects('acl_run_avx2.c')
> >  
> >      # compile AVX512 version if:
> > @@ -38,6 +38,12 @@ if dpdk_conf.has('RTE_ARCH_X86')
> >          # compiler flags, and then have the .o file from static lib
> >          # linked into main lib.
> >  
> > +        if is_ms_compiler
> > +            acl_avx512_args = cc_avx512_flags
> > +        else
> > +            acl_avx512_args = ['-mavx512f', '-mavx512vl', '-mavx512cd', '-mavx512bw']
> > +        endif
> > +
> 
> in the non-msvc case are these flags not the same as cc_avx512_flags too?
> If so, let's just get rid of the acl_avx512_args variable generally.
> 
> /Bruce

It's not an exact match. I did not look further to see if this was intentional or result
of a typo. TBH I'm not even sure if it would be possible to deduct this from the code.
Also, all the CPUs I have looked at bring all these 5 instruction sets together, but we
know this might not hold true in the future as each one of them has an independent CPUID flag.

    cc_avx512_flags = ['-mavx512f', '-mavx512vl', '-mavx512dq', '-mavx512bw']

My choice was to keep the flags that were used initially, but I can change that if the
maintainers tell me this was a mistake.
