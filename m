Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A12EC282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 18:24:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A95B40653;
	Thu, 13 Mar 2025 19:24:45 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 06E9A402C3
 for <dev@dpdk.org>; Thu, 13 Mar 2025 19:24:43 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 1BA9F203342A; Thu, 13 Mar 2025 11:24:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1BA9F203342A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741890283;
 bh=SYOue4Rb32mgLxYO7sOju0U8I5c1+6j3VORYBP+B+7U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IVZGuOI1z0FrpoxAqZn66Z9Bt4x0/kiug7kj8OqjiGAHpq0x6r3oB98y475ESFkf7
 q4yaO/6DMVT0ZK2LoDNLpC3p/CvlaLHoRDSYXyPJzBcFFyaeDOy6lhgnRGdBUpcWRi
 lZBRgPrZ3ypZk0jgGlbqFlkRzTNRQJlP5ckFqhlg=
Date: Thu, 13 Mar 2025 11:24:43 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, david.marchand@redhat.com
Subject: Re: [PATCH] net/intel: remove unnecessary compiler flag for mingw
Message-ID: <20250313182443.GA20942@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250312155458.1395709-1-bruce.richardson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312155458.1395709-1-bruce.richardson@intel.com>
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

On Wed, Mar 12, 2025 at 03:54:58PM +0000, Bruce Richardson wrote:
> There was an issue with building DPDK using mingw v8.1[1], which
> required using the "-fno-asynchronous-unwind-tables" compiler flag when
> building using the mingw compiler. However, recent versions of the
> compiler no longer seem to need this flag, so remove it.
> 
> [1] https://inbox.dpdk.org/dev/CAJFAV8z3qFhT9Vv5xOpLhi74BYAht2YCfL2ffLrmei4hfSG5jg@mail.gmail.com
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/net/intel/i40e/meson.build     | 4 ----
>  drivers/net/intel/iavf/meson.build     | 4 ----
>  drivers/net/intel/ice/base/meson.build | 4 ----
>  drivers/net/intel/ice/meson.build      | 4 ----
>  drivers/net/intel/ixgbe/meson.build    | 3 ---
>  5 files changed, 19 deletions(-)
> 
> diff --git a/drivers/net/intel/i40e/meson.build b/drivers/net/intel/i40e/meson.build
> index 2973ed1a01..15993393fb 100644
> --- a/drivers/net/intel/i40e/meson.build
> +++ b/drivers/net/intel/i40e/meson.build
> @@ -41,10 +41,6 @@ includes += include_directories('base')
>  if arch_subdir == 'x86'
>      sources += files('i40e_rxtx_vec_sse.c')
>  
> -    if is_windows and cc.get_id() != 'clang'
> -        cflags += ['-fno-asynchronous-unwind-tables']
> -    endif
> -
>      i40e_avx2_lib = static_library('i40e_avx2_lib',
>              'i40e_rxtx_vec_avx2.c',
>              dependencies: [static_rte_ethdev, static_rte_kvargs, static_rte_hash],
> diff --git a/drivers/net/intel/iavf/meson.build b/drivers/net/intel/iavf/meson.build
> index f7eac7c57a..833a63e6c8 100644
> --- a/drivers/net/intel/iavf/meson.build
> +++ b/drivers/net/intel/iavf/meson.build
> @@ -29,10 +29,6 @@ includes += include_directories('base')
>  if arch_subdir == 'x86'
>      sources += files('iavf_rxtx_vec_sse.c')
>  
> -    if is_windows and cc.get_id() != 'clang'
> -        cflags += ['-fno-asynchronous-unwind-tables']
> -    endif
> -
>      iavf_avx2_lib = static_library('iavf_avx2_lib',
>              'iavf_rxtx_vec_avx2.c',
>              dependencies: [static_rte_ethdev],
> diff --git a/drivers/net/intel/ice/base/meson.build b/drivers/net/intel/ice/base/meson.build
> index 59202df661..38d092c370 100644
> --- a/drivers/net/intel/ice/base/meson.build
> +++ b/drivers/net/intel/ice/base/meson.build
> @@ -49,10 +49,6 @@ if (toolchain == 'gcc' and cc.version().version_compare('>=11.0.0'))
>      error_cflags += ['-Wno-array-bounds']
>  endif
>  
> -if is_windows and cc.get_id() == 'gcc'
> -    cflags += ['-fno-asynchronous-unwind-tables']
> -endif
> -
>  c_args = cflags
>  
>  foreach flag: error_cflags
> diff --git a/drivers/net/intel/ice/meson.build b/drivers/net/intel/ice/meson.build
> index cbdf38c1c4..4d8f71cd4a 100644
> --- a/drivers/net/intel/ice/meson.build
> +++ b/drivers/net/intel/ice/meson.build
> @@ -35,10 +35,6 @@ endif
>  if arch_subdir == 'x86'
>      sources += files('ice_rxtx_vec_sse.c')
>  
> -    if is_windows and cc.get_id() != 'clang'
> -        cflags += ['-fno-asynchronous-unwind-tables']
> -    endif
> -
>      ice_avx2_lib = static_library('ice_avx2_lib',
>              'ice_rxtx_vec_avx2.c',
>              dependencies: [static_rte_ethdev, static_rte_hash],
> diff --git a/drivers/net/intel/ixgbe/meson.build b/drivers/net/intel/ixgbe/meson.build
> index 0ae12dd5ff..0bee736a2c 100644
> --- a/drivers/net/intel/ixgbe/meson.build
> +++ b/drivers/net/intel/ixgbe/meson.build
> @@ -27,9 +27,6 @@ deps += ['hash', 'security']
>  if arch_subdir == 'x86'
>      sources += files('ixgbe_rxtx_vec_sse.c')
>      sources += files('ixgbe_recycle_mbufs_vec_common.c')
> -    if is_windows and cc.get_id() != 'clang'
> -        cflags += ['-fno-asynchronous-unwind-tables']
> -    endif
>  elif arch_subdir == 'arm'
>      sources += files('ixgbe_rxtx_vec_neon.c')
>      sources += files('ixgbe_recycle_mbufs_vec_common.c')
> -- 
> 2.43.0

I'm fine with these changes.

Acked-by: Andre Muezerie <andremue@linux.microsoft.com>
