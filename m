Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6E2C282C5
	for <dpdk-dev@archiver.kernel.org>; Sat,  1 Mar 2025 00:47:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02B514026C;
	Sat,  1 Mar 2025 01:47:59 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id A58654025D
 for <dev@dpdk.org>; Sat,  1 Mar 2025 01:47:56 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id F3DE22038A22; Fri, 28 Feb 2025 16:47:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F3DE22038A22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740790076;
 bh=qhVuNzGorU5B6aScUzBoCR50/8Dlk8yidF4vYZ0yp9c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ogn6fSdE4v1pCAXsLVw9wRj8HSurcvZ+ObeibAfI5jRT9ul1+Dy05mCaIL7npWEWl
 MM9TiHDfa2ZaZV7OQRwwmqp4GDanZNGn8uCRUnpOas25yHkL56wuR8HMEx78U/Cvjn
 0EaHYuy5EFPfFfFouclpgAD62Pux4oGCSEncKKso=
Date: Fri, 28 Feb 2025 16:47:55 -0800
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>, dev@dpdk.org
Subject: Re: [PATCH 1/2] config: allow AVX512 instructions to be used with MSVC
Message-ID: <20250301004755.GB2378@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1740707537-10517-1-git-send-email-andremue@linux.microsoft.com>
 <1740707537-10517-2-git-send-email-andremue@linux.microsoft.com>
 <Z8HIngY9yOjI3tTQ@bricha3-mobl1.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8HIngY9yOjI3tTQ@bricha3-mobl1.ger.corp.intel.com>
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

On Fri, Feb 28, 2025 at 02:30:54PM +0000, Bruce Richardson wrote:
> On Thu, Feb 27, 2025 at 05:52:16PM -0800, Andre Muezerie wrote:
> > Up to now MSVC has being used with the default mode, which uses SSE2
> > instructions for scalar floating-point and vector calculations.
> > https://learn.microsoft.com/en-us/cpp/build/reference/arch-x64?view=msvc-170
> > 
> > This patch allows users to specify the CPU for which the generated
> > code should be optimized for in the same way it's done for GCC: by
> > passing the CPU name.
> > When no explicit CPU name is passed, 'native' is assumed (like it
> > happens with GCC) and the code will be optimized for the same CPU
> > type used to compile the code.
> > 
> > MSVC does not provide this functionality natively, so logic was
> > added to a new meson.build file under config/x86/msvc to handle
> > these differences, detecting which
> > instruction sets are supported by the CPU(s), passing the best
> > options to MSVC and setting the correct macros (like __AVX512F__)
> > so that the DPDK code can rely on them like it is done with GCC.
> > 
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> 
> Thanks for splitting out this change from the earlier one, it allows more
> focused review.
> However, I think within this, we can split things a bit further two, and I
> think this patch could do with being split into separate changes.
> Specifically:
> * one patch for reordering the x86/meson.build file, i.e. just move the
>   code about and put a subdir_done() for MSVC once common part is
>   completed. That patch is a quick review since all you are doing is moving
>   things about.
> * separate patch for adding the new msvc file +  one-line change to add it
>   to the x86/meson.build file.
> * library changes in separate patch - or perhaps two patches so individual
>   maintainers can ack.
> 

I split them as suggested. In that process I found an old bug for which I sent
a patch as well.

> Some other comments inline below too.
> Thanks,
> /Bruce
> 
> > ---
> >  config/x86/meson.build      |  87 +++++------

<snip>

> > -
> > -cpu_instruction_set = get_option('cpu_instruction_set')
> > -if cpu_instruction_set == 'native'
> > -    foreach m:epyc_zen_cores.keys()
> > -        if cc.get_define(m, args: machine_args) != ''
> > -            dpdk_conf.set('RTE_MAX_LCORE', epyc_zen_cores[m])
> > -            break
> > -        endif
> > -    endforeach
> > -else
> > -    foreach m:epyc_zen_cores.keys()
> > -        if m.contains(cpu_instruction_set)
> > -            dpdk_conf.set('RTE_MAX_LCORE', epyc_zen_cores[m])
> > -            break
> > -        endif
> > -    endforeach
> > -endif
> > -
> > -dpdk_conf.set('RTE_MAX_NUMA_NODES', 32)
> 
> For changes to config/x86/meson.build you can add my Ack if it's a separate
> patch.

Done, and added the ACK.

> 
> > diff --git a/config/x86/msvc/meson.build b/config/x86/msvc/meson.build
> > new file mode 100644
> > index 0000000000..646c9a8515
> > --- /dev/null
> > +++ b/config/x86/msvc/meson.build
> > @@ -0,0 +1,287 @@

<snip>

> > +            'VPCLMULQDQ',
> > +    ]
> > +    foreach f:optional_flags
> > +        result = cc.run(cpuid_code, args: '-D@0@'.format(f),
> > +                        name: 'instruction set @0@'.format(f))
> 
> Is building a new binary for each instruction set the best way to do this?
> Would it not be better to have a single binary that outputs all the
> instruction sets in one go?

Building a new binary every time is probably the simplest approach. It also
makes teh code easy to read and understand. It is fast, and since it will
probably not be run more than once per DPDK release there's not much incentive
to come up with something better.

> 
> > +        has_instr_set = result.returncode() == 0 and result.stdout() == '1'
> > +        if has_instr_set
> > +            cpu_flags += f
> > +        endif
> > +        message('Target has @0@: @1@'.format(f, has_instr_set))
> > -                c_args: cflags +
> > -                    ['-mavx512f', '-mavx512vl',
> > -                     '-mavx512cd', '-mavx512bw'])
> > +                c_args: cflags + cc_avx512_flags)
> >              objs += avx512_tmplib.extract_objects(
> >                      'acl_run_avx512.c')
> >              cflags += '-DCC_AVX512_SUPPORT'
> 
> Ack from me for this change too.

I forgot to add the ACK.

> 
> > diff --git a/lib/member/meson.build b/lib/member/meson.build
> > index f92cbb7f25..8416dc6f8a 100644
> > --- a/lib/member/meson.build
> > +++ b/lib/member/meson.build
> > @@ -33,6 +33,12 @@ if dpdk_conf.has('RTE_ARCH_X86_64') and binutils_ok
> >      # compiler flags, and then have the .o file from static lib
> >      # linked into main lib.
> >  
> > +    if is_ms_compiler
> > +        member_avx512_args = cc_avx512_flags
> > +    else
> > +        member_avx512_args = ['-mavx512f', '-mavx512dq', '-mavx512ifma']
> > +    endif
> > +
> 
> is ifma included as msvc as part of the AVX512 flags? How does this work
> for the windows build?

Option /arch:AVX512 does not set __AVX512IFMA__ so, my educated guess is
that msvc does not automatically generate instructions from that set.

There's also no msvc option specific for AVX512IFMA.

That being said, compiler intrinsics would still work as these do not require
any options to be passed to msvc. This is other difference when compared
to GCC.

Relying on cc_avx512_flags for msvc would still bring the benefit of using
other AVX512 (non-IFMA) instructions.

> 
> >      # check if all required flags already enabled
> >      sketch_avx512_flags = ['__AVX512F__', '__AVX512DQ__', '__AVX512IFMA__']
> >  
> > @@ -46,13 +52,12 @@ if dpdk_conf.has('RTE_ARCH_X86_64') and binutils_ok
> >      if sketch_avx512_on == true
> >          cflags += ['-DCC_AVX512_SUPPORT']
> >          sources += files('rte_member_sketch_avx512.c')
> > -    elif cc.has_multi_arguments('-mavx512f', '-mavx512dq', '-mavx512ifma')
> > +    elif cc.has_multi_arguments(member_avx512_args)
> >          sketch_avx512_tmp = static_library('sketch_avx512_tmp',
> >              'rte_member_sketch_avx512.c',
> >              include_directories: includes,
> >              dependencies: [static_rte_eal, static_rte_hash],
> > -            c_args: cflags +
> > -                ['-mavx512f', '-mavx512dq', '-mavx512ifma'])
> > +            c_args: cflags + member_avx512_args)
> >          objs += sketch_avx512_tmp.extract_objects('rte_member_sketch_avx512.c')
> >          cflags += ['-DCC_AVX512_SUPPORT']
> >      endif
> > -- 
> > 2.48.1.vfs.0.0
> > 
