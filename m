Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E1AC021BF
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 02:01:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FF46402DC;
	Wed, 26 Feb 2025 03:01:41 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 373C9402B9
 for <dev@dpdk.org>; Wed, 26 Feb 2025 03:01:39 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 7A6F120460A7; Tue, 25 Feb 2025 18:01:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7A6F120460A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740535298;
 bh=bErNcAEdU7Ap/Ka49cTjFrbImndaaMVTgc2j2pQqtVo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bnNiLElX5oKrX1eoa/bdNsd5kTDVt9Yw1e/AHiFkus9LEhHPm1RbLxjxYiljL530t
 hi6t7GstZriC+ZasJrPaSOUenb+U0ciRpHXENMUOU92SfhgluxDrh9erQ0dvKCxtwf
 WuggI5JhKJPBu4TdRZKHGs1gzJ2OOAl62v7zt8XE=
Date: Tue, 25 Feb 2025 18:01:38 -0800
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>, dev@dpdk.org
Subject: Re: [PATCH 3/6] config: allow faster instruction sets to be used
 with MSVC
Message-ID: <20250226020138.GA16574@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1740430879-17874-1-git-send-email-andremue@linux.microsoft.com>
 <1740430879-17874-4-git-send-email-andremue@linux.microsoft.com>
 <Z73Tcj4VmlNYNoLM@bricha3-mobl1.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z73Tcj4VmlNYNoLM@bricha3-mobl1.ger.corp.intel.com>
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

On Tue, Feb 25, 2025 at 02:28:02PM +0000, Bruce Richardson wrote:
> On Mon, Feb 24, 2025 at 01:01:16PM -0800, Andre Muezerie wrote:
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
> > added to meson.build to handle these differences, detecting which
> > instruction sets are supported by the CPU(s), passing the best
> > options to MSVC and setting the correct macros (like __AVX512F__)
> > so that the DPDK code can rely on them like it is done with GCC.
> > 
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > ---
> 
> Hi Andre,
> 
> couple of initial thoughts inline below.
> 
> /Bruce
> 
> >  config/x86/meson.build | 364 ++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 325 insertions(+), 39 deletions(-)
> > 
> 
> There is quite a lot of new code to be added here. Might it be worthwhile
> creating a "config/x86/msvc/" subdirectory with its own meson.build file to
> handle all the complexities of using it. We can have the common material at
> the top of the x86/meson.build file, and then do 
> 
> if is_ms_compiler
>     subdir(msvc)
>     subdir_done()
> endif
> 
> leaving the rest of the file for the gcc/clang/icx code.

I think that makes sense, as there's not much common code there that is common to gcc and msvc.

> 
> > diff --git a/config/x86/meson.build b/config/x86/meson.build
> > index 47a5b0c04a..9260969c54 100644
> > --- a/config/x86/meson.build
> > +++ b/config/x86/meson.build
> > @@ -14,7 +14,194 @@ if is_linux or cc.get_id() == 'gcc'
> >      endif
> >  endif
> >  
> > -cc_avx512_flags = ['-mavx512f', '-mavx512vl', '-mavx512dq', '-mavx512bw']
> > +cpuid_code = '''
> > +    #include <stdio.h>
> > +    #include <stdint.h>
> > +    #include <intrin.h>
> > +
> > +    uint32_t f1_ECX = 0;
> > +    uint32_t f1_EDX = 0;
> > +    uint32_t f7_EBX = 0;
> > +    uint32_t f7_ECX = 0;
> > +
> > +    void get_support_flags()
> > +    {
> > +        int ids_max;
> > +        int data[4];
> > +
> > +        /*
> > +         * Calling __cpuid with 0x0 as the function_id argument
> > +         * gets the number of the highest valid function ID.
> > +         */
> > +        __cpuid(data, 0);
> > +        ids_max = data[0];
> > +
> > +        if (1 <= ids_max) {
> > +            __cpuidex(data, 1, 0);
> > +            f1_ECX = data[2];
> > +            f1_EDX = data[3];
> > +
> > +            if (7 <= ids_max) {
> > +                __cpuidex(data, 7, 0);
> > +                f7_EBX = data[1];
> > +                f7_ECX = data[2];
> > +            }
> > +        }
> > +    }
> > +
> > +    int get_instruction_support()
> > +    {
> > +        get_support_flags();
> > +
> > +    #ifdef SSE3
> > +        return (f1_ECX & (1UL << 0)) ? 1 : 0;
> > +    #endif
> > +    #ifdef PCLMUL
> > +        return (f1_ECX & (1UL << 1)) ? 1 : 0;
> > +    #endif
> > +    #ifdef SSSE3
> > +        return (f1_ECX & (1UL << 9)) ? 1 : 0;
> > +    #endif
> > +    #ifdef SSE4_1
> > +        return (f1_ECX & (1UL << 19)) ? 1 : 0;
> > +    #endif
> > +    #ifdef SSE4_2
> > +        return (f1_ECX & (1UL << 20)) ? 1 : 0;
> > +    #endif
> > +    #ifdef AES
> > +        return (f1_ECX & (1UL << 25)) ? 1 : 0;
> > +    #endif
> > +    #ifdef AVX
> > +        return (f1_ECX & (1UL << 28)) ? 1 : 0;
> > +    #endif
> > +    #ifdef RDRND
> > +        return (f1_ECX & (1UL << 30)) ? 1 : 0;
> > +    #endif
> > +    #ifdef SSE
> > +        return (f1_EDX & (1UL << 25)) ? 1 : 0;
> > +    #endif
> > +    #ifdef SSE2
> > +        return (f1_EDX & (1UL << 26)) ? 1 : 0;
> > +    #endif
> > +    #ifdef AVX2
> > +        return (f7_EBX & (1UL << 5)) ? 1 : 0;
> > +    #endif
> > +    #ifdef AVX512F
> > +        return (f7_EBX & (1UL << 16)) ? 1 : 0;
> > +    #endif
> > +    #ifdef AVX512DQ
> > +        return (f7_EBX & (1UL << 17)) ? 1 : 0;
> > +    #endif
> > +    #ifdef RDSEED
> > +        return (f7_EBX & (1UL << 18)) ? 1 : 0;
> > +    #endif
> > +    #ifdef AVX512IFMA
> > +        return (f7_EBX & (1UL << 21)) ? 1 : 0;
> > +    #endif
> > +    #ifdef AVX512CD
> > +        return (f7_EBX & (1UL << 28)) ? 1 : 0;
> > +    #endif
> > +    #ifdef AVX512BW
> > +        return (f7_EBX & (1UL << 30)) ? 1 : 0;
> > +    #endif
> > +    #ifdef AVX512VL
> > +        return (f7_EBX & (1UL << 31)) ? 1 : 0;
> > +    #endif
> > +    #ifdef GFNI
> > +        return (f7_ECX & (1UL << 8)) ? 1 : 0;
> > +    #endif
> > +    #ifdef VPCLMULQDQ
> > +        return (f7_ECX & (1UL << 10)) ? 1 : 0;
> > +    #endif
> > +
> > +        return -1;
> > +    }
> > +
> > +    int main(int argc, char *argv[])
> > +    {
> > +        int res = get_instruction_support();
> > +        if (res == -1) {
> > +            printf("Unknown instruction set");
> > +            return -1;
> > +        }
> > +        printf("%d", res);
> > +
> > +        return 0;
> > +    }
> > +'''
> > +
> > +# The data in table below can be found here:
> > +# https://gcc.gnu.org/onlinedocs/gcc/x86-Options.html
> > +# This table only contains CPUs that have SSE4.2, as this instruction set is required by DPDK.
> > +# That means that in addition to the instruction sets mentioned in the table, all these CPUs
> > +# also have ['SSE', 'SSE2', 'SSE3', 'SSEE3', 'SSE4_1', 'SSE4_2']
> > +cpu_type_to_flags = {
> > +       'x86-64-v2': [],
> > +       'x86-64-v3': ['AVX', 'AVX2'],
> > +       'x86-64-v4': ['AVX', 'AVX2', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD'],
> > +         'nehalem': [],
> > +          'corei7': [],
> > +        'westmere': ['PCLMUL'],
> > +     'sandybridge': ['AVX', 'PCLMUL'],
> > +      'corei7-avx': ['AVX', 'PCLMUL'],
> > +       'ivybridge': ['AVX', 'PCLMUL', 'RDRND'],
> > +      'core-avx-i': ['AVX', 'PCLMUL', 'RDRND'],
> > +         'haswell': ['AVX', 'PCLMUL', 'RDRND', 'AVX2'],
> > +       'core-avx2': ['AVX', 'PCLMUL', 'RDRND', 'AVX2'],
> > +       'broadwell': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED'],
> > +         'skylake': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES'],
> > +  'skylake-avx512': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD'],
> > +     'cascadelake': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD'],
> > +      'cannonlake': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD', 'AVX512IFMA'],
> > +      'cooperlake': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD'],
> > +  'icelake-client': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD', 'AVX512IFMA', 'GFNI'],
> > +  'icelake-server': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD', 'AVX512IFMA', 'GFNI'],
> > +       'tigerlake': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD', 'AVX512IFMA', 'GFNI'],
> > +      'rocketlake': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD', 'AVX512IFMA', 'GFNI'],
> > +       'alderlake': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'GFNI'],
> > +      'raptorlake': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'GFNI'],
> > +      'meteorlake': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'GFNI'],
> > +       'gracemont': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'GFNI'],
> > +       'arrowlake': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'GFNI'],
> > +     'arrowlake-s': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'GFNI'],
> > +       'lunarlake': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'GFNI'],
> > +     'pantherlake': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'GFNI'],
> > +  'sapphirerapids': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD', 'AVX512IFMA', 'GFNI'],
> > +   'emeraldrapids': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD', 'AVX512IFMA', 'GFNI'],
> > +   'graniterapids': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD', 'AVX512IFMA', 'GFNI'],
> > + 'graniterapids-d': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD', 'AVX512IFMA', 'GFNI'],
> > +   'diamondrapids': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD', 'AVX512IFMA', 'GFNI'],
> > +      'silvermont': ['PCLMUL', 'RDRND'],
> > +             'slm': ['PCLMUL', 'RDRND'],
> > +        'goldmont': ['PCLMUL', 'RDRND', 'RDSEED', 'AES'],
> > +   'goldmont-plus': ['PCLMUL', 'RDRND', 'RDSEED', 'AES'],
> > +         'tremont': ['PCLMUL', 'RDRND', 'RDSEED', 'AES', 'GFNI'],
> > +    'sierraforest': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'GFNI'],
> > +      'grandridge': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'GFNI'],
> > +'clearwaterforest': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'GFNI'],
> > +          'bdver1': ['AVX', 'PCLMUL', 'AES'],
> > +          'bdver2': ['AVX', 'PCLMUL', 'AES'],
> > +          'bdver3': ['AVX', 'PCLMUL', 'AES'],
> > +          'bdver4': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'AES'],
> > +          'znver1': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES'],
> > +          'znver2': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES'],
> > +          'znver3': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ'],
> > +          'znver4': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD', 'AVX512IFMA', 'GFNI'],
> > +          'znver5': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES', 'VPCLMULQDQ', 'AVX512F', 'AVX512VL', 'AVX512BW', 'AVX512DQ', 'AVX512CD', 'AVX512IFMA', 'GFNI'],
> > +          'btver2': ['AVX', 'PCLMUL', 'AES'],
> > +        'lujiazui': ['PCLMUL', 'RDRND', 'RDSEED', 'AES'],
> > +        'yongfeng': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES'],
> > +      'shijidadao': ['AVX', 'PCLMUL', 'RDRND', 'AVX2', 'RDSEED', 'AES'],
> > +}
> > +
> 
> I really don't want to have tables like this to maintain in our code if at
> all possible. We used to have something a bit similar in DPDK IIRC, but we
> found it a maintenance nightmare and just switched to using the compiler to
> do all the work. In our existing builds, we just pass the
> cpu_instruction_set parameter straight to the -march flag of the compiler.
> For MSVC support, I believe we should just do the exact same.
> 
> Maintaining lists like this will be a problem as new platforms need to be
> constantly added.

It's great that when using gcc users can just pass the CPU type to it and
that it will set all the macros corresponding to that CPU for them. I
would love to be able to rely on MSVC for that as well, unfortunately MSVC
does not provide that level of granularity, that's why I came up with the
idea of having this table.

Initially I was also very concerned about the amount of data to be stored
there, and the work required to maintain it. Then I decided to throw away
all the CPU types that do not have SSE4_2. That reduced the table in half.
Adding the entries manually was still a lot of work and error prone. So,
I decided to write some code that uses gcc to build that table for me.
I'll polish that code and add it to the patch. With that it will be almost
zero effort to maintain that table. All that will be required is running
that code on a setup with the latest gcc, providing a file with the CPU
names. Assuming gcc knows about the latest CPUs a new table will be
generated and can be pasted in the meson.build file.

I assume this does not need to be done too often. In the worst case, if it
happens that DPDK was not updated with the latest CPUs, people can still
pick an earlier CPU with similar characteristics and have similar (if not
same) performance.


> Do we also look to backport them, because if equivalence
> with the linux build is necessary then that will have to be done - as on
> Linux when a new version of GCC comes out, we can then use the new
> instruction set targets on the old releases of DPDK.

That would be nice, and I'm willing to help with that. It makes it a
better user experience if we can minimize the perceived differences
between the toolsets. I'm not sure if it's a requirement though. If
you're concerned that this would add too much overhead, it could be
decided that no such backport should happen.

> 
> > +if is_ms_compiler
> > +    cc_avx2_flags = ['/arch:AVX2']
> > +    cc_avx512_flags = ['/arch:AVX512']
> > +else
> > +    cc_avx2_flags = ['-mavx2']
> > +    cc_avx512_flags = ['-mavx512f', '-mavx512vl', '-mavx512dq', '-mavx512bw']
> > +endif
> > +
> >  cc_has_avx512 = false
> >  target_has_avx512 = false
> >  if (binutils_ok and cc.has_multi_arguments(cc_avx512_flags)
> > @@ -30,12 +217,14 @@ if (binutils_ok and cc.has_multi_arguments(cc_avx512_flags)
> >          warning('Broken _mm512_extracti64x4_epi64, disabling AVX512 support')
> >      else
> >          cc_has_avx512 = true
> > -        target_has_avx512 = (
> > -                cc.get_define('__AVX512F__', args: machine_args) != '' and
> > -                cc.get_define('__AVX512BW__', args: machine_args) != '' and
> > -                cc.get_define('__AVX512DQ__', args: machine_args) != '' and
> > -                cc.get_define('__AVX512VL__', args: machine_args) != ''
> > -            )
> > +        if not is_ms_compiler
> > +            target_has_avx512 = (
> > +                    cc.get_define('__AVX512F__', args: machine_args) != '' and
> > +                    cc.get_define('__AVX512BW__', args: machine_args) != '' and
> > +                    cc.get_define('__AVX512DQ__', args: machine_args) != '' and
> > +                    cc.get_define('__AVX512VL__', args: machine_args) != ''
> > +                )
> > +        endif
> >      endif
> >  endif
> >  
> > @@ -47,42 +236,139 @@ if not is_ms_compiler
> >      endif
> >  endif
> >  
> > -# enable restricted transactional memory intrinsics
> > -# https://gcc.gnu.org/onlinedocs/gcc/x86-transactional-memory-intrinsics.html
> > -if cc.get_id() != 'msvc'
> > -    machine_args += '-mrtm'
> > -endif
> > +if is_ms_compiler
> > +    # Determine cpu_flags for a given configuration.
> > +    # SSE instructions up to 4.2 are required for DPDK.
> > +    cpu_flags = ['SSE', 'SSE2', 'SSE3', 'SSEE3', 'SSE4_1', 'SSE4_2']
> > +
> > +    message('cpu_instruction_set: @0@'.format(cpu_instruction_set))
> >  
> > -base_flags = ['SSE', 'SSE2', 'SSE3','SSSE3', 'SSE4_1', 'SSE4_2']
> > -foreach f:base_flags
> > -    compile_time_cpuflags += ['RTE_CPUFLAG_' + f]
> > -endforeach
> > -
> > -optional_flags = [
> > -        'AES',
> > -        'AVX',
> > -        'AVX2',
> > -        'AVX512BW',
> > -        'AVX512CD',
> > -        'AVX512DQ',
> > -        'AVX512F',
> > -        'AVX512VL',
> > -        'PCLMUL',
> > -        'RDRND',
> > -        'RDSEED',
> > -        'VPCLMULQDQ',
> > -]
> > -foreach f:optional_flags
> > -    if cc.get_define('__@0@__'.format(f), args: machine_args) == '1'
> > -        if f == 'PCLMUL' # special case flags with different defines
> > -            f = 'PCLMULQDQ'
> > -        elif f == 'RDRND'
> > -            f = 'RDRAND'
> > +    if cpu_instruction_set == ''
> > +        # Nothing to do as cpu_flags already holds all the required flags.
> > +    elif cpu_instruction_set == 'native'
> > +        # MSVC behaves differently than GCC regarding supported instruction sets.
> > +        # While GCC will create macros like __AVX512F__ when such instruction set is
> > +        # supported by the current CPU, MSVC does not do that. MSVC will create that
> > +        # macro when parameter /arch:AVX512 is passed to the compiler, even when the
> > +        # CPU does not have that instruction set (by design). So there's a need to
> > +        # look at CPUID flags to figure out what is really supported by the CPU, so
> > +        # that the correct /arch value can be passed to the compiler.
> > +        # The macros also need to be explicitly defined, as /arch will not create all
> > +        # macros GCC creates under the same conditions.
> > +        # As an example, /arch:AVX512 creates __AVX512BW__, but does not create __SSE2__.
> > +        # More details available here:
> > +        # https://learn.microsoft.com/en-us/cpp/preprocessor/predefined-macros
> > +
> > +        optional_flags = [
> > +                'PCLMUL',
> > +                'AES',
> > +                'AVX',
> > +                'RDRND',
> > +                'AVX2',
> > +                'AVX512F',
> > +                'AVX512BW',
> > +                'AVX512DQ',
> > +                'AVX512VL',
> > +                'AVX512CD',
> > +                'AVX512IFMA',
> > +                'GFNI',
> > +                'RDSEED',
> > +                'VPCLMULQDQ',
> > +        ]
> > +        foreach f:optional_flags
> > +            result = cc.run(cpuid_code, args: '-D@0@'.format(f),
> > +                            name: 'instruction set @0@'.format(f))
> > +            has_instr_set = result.returncode() == 0 and result.stdout() == '1'
> > +            if has_instr_set
> > +                cpu_flags += f
> > +            endif
> > +            message('Target has @0@: @1@'.format(f, has_instr_set))
> > +        endforeach
> > +    else
> > +        # An explicit cpu_instruction_set was provided. Get cpu_flags
> > +        # from cpu_type_to_flags table.
> > +        if cpu_instruction_set not in cpu_type_to_flags
> > +            error('CPU not known or not supported. Please update the table with known CPUs if needed.')
> >          endif
> > -        compile_time_cpuflags += ['RTE_CPUFLAG_' + f]
> > +        cpu_flags += cpu_type_to_flags[cpu_instruction_set]
> > +    endif
> > +
> > +    # Now that all cpu_flags are known, set compile_time_cpuflags and also
> > +    # machine_args to ensure that the instruction set #defines (like __SSE2__)
> > +    # are always present in the preprocessor.
> > +    message('cpu_flags: @0@'.format(cpu_flags))
> > +
> > +    foreach flag:cpu_flags
> > +        machine_args += '/D__@0@__'.format(flag)
> > +        if flag == 'PCLMUL'
> > +            flag = 'PCLMULQDQ'
> > +        elif flag == 'RDRND'
> > +            flag = 'RDRAND'
> > +        endif
> > +        compile_time_cpuflags += ['RTE_CPUFLAG_' + flag]
> > +    endforeach
> > +
> > +    target_has_avx512 = ('AVX512F'  in cpu_flags and
> > +                         'AVX512BW' in cpu_flags and
> > +                         'AVX512DQ' in cpu_flags and
> > +                         'AVX512VL' in cpu_flags)
> > +
> > +    # Decide which instruction sets should be used by the compiler.
> > +    # With MSVC, intrinsic functions are always enabled. However, for the
> > +    # compiler to use an extended instruction set for automatically
> > +    # generated code "/arch" needs to be passed. So we instruct the compiler
> > +    # to use the largest set that is supported by the CPU. It is implied that
> > +    # smaller sets than the largest selected are included, as described here:
> > +    # https://learn.microsoft.com/en-us/cpp/build/reference/arch-x64?view=msvc-170
> > +    if 'RTE_CPUFLAG_AVX512F' in compile_time_cpuflags
> > +        machine_args += ['/arch:AVX512']
> > +    elif 'RTE_CPUFLAG_AVX2' in compile_time_cpuflags
> > +        machine_args += ['/arch:AVX2']
> > +    elif 'RTE_CPUFLAG_AVX' in compile_time_cpuflags
> > +        machine_args += ['/arch:AVX']
> > +    else
> > +        # SSE4.2 is expected to always be available
> > +        machine_args += ['/arch:SSE4.2']
> >      endif
> > -endforeach
> >  
> 
> Since these appear to be the only /arch flags supported by the compiler for
> code generation, I would suggest that these would be the only instruction
> set flags that we support on MSVC builds, and that we then build up the
> actual CPU flags based on the minimum flags to be expected when each of
> these instruction sets is present.
> 
> Similarly with 'native', rather than supporting all the different CPU types,
> it would be a lot easier to just determine if it's an SSE4 machine, an AVX2
> machine or AVX512, and run with that.
> 
> My thinking is that getting this as a first step should get us a lot of the
> benefits without such a massive maintenance headache.

Providing only /arch option at first sight might look simpler, but I still
like the table approach much better. As I said earlier, maintaining that
table is not much work with that extra devtool.

Some drawbacks from the simpler approach:

1) User experience is not as good as it will differ from other toolsets.
   Users will have to learn about more parameter/values (how/when to use them).
2) DPDK code will not benefit from other instruction sets which might be
   present (__RDSEED__, __RDRND__, etc.) because these are not set by /arch.

Let me know your thoughts.

> 
> > +    message('machine_args: @0@'.format(machine_args))
> > +else
> > +    # enable restricted transactional memory intrinsics
> > +    # https://gcc.gnu.org/onlinedocs/gcc/x86-transactional-memory-intrinsics.html
> > +    machine_args += '-mrtm'
> > +
> > +    base_flags = ['SSE', 'SSE2', 'SSE3','SSSE3', 'SSE4_1', 'SSE4_2']
> > +    foreach f:base_flags
> > +        compile_time_cpuflags += ['RTE_CPUFLAG_' + f]
> > +    endforeach
> > +
> > +    optional_flags = [
> > +            'AES',
> > +            'AVX',
> > +            'AVX2',
> > +            'AVX512BW',
> > +            'AVX512CD',
> > +            'AVX512DQ',
> > +            'AVX512F',
> > +            'AVX512VL',
> > +            'PCLMUL',
> > +            'RDRND',
> > +            'RDSEED',
> > +            'VPCLMULQDQ',
> > +    ]
> > +    foreach f:optional_flags
> > +        if cc.get_define('__@0@__'.format(f), args: machine_args) == '1'
> > +            if f == 'PCLMUL' # special case flags with different defines
> > +                f = 'PCLMULQDQ'
> > +            elif f == 'RDRND'
> > +                f = 'RDRAND'
> > +            endif
> > +            compile_time_cpuflags += ['RTE_CPUFLAG_' + f]
> > +        endif
> > +    endforeach
> > +endif
> > +
> > +message('compile_time_cpuflags: @0@'.format(compile_time_cpuflags))
> >  
> >  dpdk_conf.set('RTE_ARCH_X86', 1)
> >  if dpdk_conf.get('RTE_ARCH_64')
> > -- 
> > 2.48.1.vfs.0.0
> > 
