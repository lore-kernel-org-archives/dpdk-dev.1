Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103CBC282CD
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Mar 2025 20:26:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16D2B40156;
	Mon,  3 Mar 2025 21:26:32 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 020DE40041
 for <dev@dpdk.org>; Mon,  3 Mar 2025 21:26:31 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 37E012110486; Mon,  3 Mar 2025 12:26:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 37E012110486
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741033590;
 bh=ZElCCqjYyKmLWAVEtH03Cz63pBFO4xr0tJPTETBsGvw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ny1NiNdltyUDXRspTbXE8GgJuU4WKtPtUGBNNklPlZsITwHAYVWWccfXoYuMZONsb
 Wgfgv3gpuDFyDMP77vS+XrLBen1ee8kfTHOK8B/zHCUg1SUSL24HKUyY/oElwsPlsF
 pLgYRSasjWItfR8AQlHf+C3f9im5d4KiUk/xTnjE=
Date: Mon, 3 Mar 2025 12:26:30 -0800
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>, dev@dpdk.org
Subject: Re: [PATCH] acl: use common top-level variable for easier maintenance
Message-ID: <20250303202630.GA9439@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1740768356-29954-1-git-send-email-andremue@linux.microsoft.com>
 <Z8XIle-aCNzFN86A@bricha3-mobl1.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8XIle-aCNzFN86A@bricha3-mobl1.ger.corp.intel.com>
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

On Mon, Mar 03, 2025 at 03:19:49PM +0000, Bruce Richardson wrote:
> On Fri, Feb 28, 2025 at 10:45:56AM -0800, Andre Muezerie wrote:
> > Updated meson.build to use common variable cc_avx512_flags.
> > 
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > ---
> >  config/x86/meson.build | 2 +-
> >  lib/acl/meson.build    | 8 ++------
> >  2 files changed, 3 insertions(+), 7 deletions(-)
> > 
> 
> One suggested improvement below.
> 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> > diff --git a/config/x86/meson.build b/config/x86/meson.build
> > index 47a5b0c04a..12befd4d73 100644
> > --- a/config/x86/meson.build
> > +++ b/config/x86/meson.build
> > @@ -14,7 +14,7 @@ if is_linux or cc.get_id() == 'gcc'
> >      endif
> >  endif
> >  
> > -cc_avx512_flags = ['-mavx512f', '-mavx512vl', '-mavx512dq', '-mavx512bw']
> > +cc_avx512_flags = ['-mavx512f', '-mavx512vl', '-mavx512dq', '-mavx512bw', '-mavx512cd']
> >  cc_has_avx512 = false
> >  target_has_avx512 = false
> >  if (binutils_ok and cc.has_multi_arguments(cc_avx512_flags)
> > diff --git a/lib/acl/meson.build b/lib/acl/meson.build
> > index fefe131a48..6ba53fbba4 100644
> > --- a/lib/acl/meson.build
> > +++ b/lib/acl/meson.build
> > @@ -55,15 +55,11 @@ if dpdk_conf.has('RTE_ARCH_X86')
> >              sources += files('acl_run_avx512.c')
> >              cflags += '-DCC_AVX512_SUPPORT'
> >  
> > -        elif cc.has_multi_arguments('-mavx512f', '-mavx512vl',
> > -                    '-mavx512cd', '-mavx512bw')
> > -
> > +        elif cc.has_multi_arguments(cc_avx512_flags)
> 
> existing variable "cc_has_avx512"?

Indeed, that is even better. I sent out an updated patch.

> 
> >              avx512_tmplib = static_library('avx512_tmp',
> >                  'acl_run_avx512.c',
> >                  dependencies: static_rte_eal,
> > -                c_args: cflags +
> > -                    ['-mavx512f', '-mavx512vl',
> > -                     '-mavx512cd', '-mavx512bw'])
> > +                c_args: cflags + cc_avx512_flags)
> >              objs += avx512_tmplib.extract_objects(
> >                      'acl_run_avx512.c')
> >              cflags += '-DCC_AVX512_SUPPORT'
> > -- 
> > 2.48.1.vfs.0.0
> > 
