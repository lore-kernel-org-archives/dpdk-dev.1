Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F0DCDB46F
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 13:48:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A35A402D5;
	Tue, 23 Jun 2026 15:48:50 +0200 (CEST)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172]) by mails.dpdk.org (Postfix) with ESMTP id BAF59402B5
 for <dev@dpdk.org>; Tue, 23 Jun 2026 15:48:48 +0200 (CEST)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-30bf8b2bd20so10298219eec.0
 for <dev@dpdk.org>; Tue, 23 Jun 2026 06:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782222528;
 x=1782827328; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jFoRKLLNqDFm5vcvcp5eDASho/uf6t5A6LOkFtVDIp8=;
 b=xi52dI7qDY+hqM6+cfQsbrRuhk09id16m3+NZlEgV09L0qEl9XdVf8Wv5Om3mdKTpG
 krkcbuGObgKFOgURR32jY4/hjkZ/lfsL1Fvqo5upkBAbo8jnnBrFMU7cTiW++jELfNxT
 Ta8Txt2Mj6R9tSWSDxOwVD4AnGyg1Wo7KH41dBjQ+/1nNh7NtfodQzLTyXFEfokQVTqx
 WpolTE4WYBegyTOv1prb+qzxmU1aMyBYMmd5DnDAgCjXk1BJ1VT8wGqPgd8n6SrMNP+5
 v+H+Tz4+zPDtSsCVUz6oqdkR8LhG3XXiCgUQJuqKNl2hiaroU2voGr+pV5zSv0rT0/mF
 HGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782222528; x=1782827328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jFoRKLLNqDFm5vcvcp5eDASho/uf6t5A6LOkFtVDIp8=;
 b=DrxH5pasPZzauOG1hOrGxc2GCwq18hB7gpblIaC3WGDmGOs8Zd9Su3mUHDFvRBBWIB
 VjhWhSC5KcLO4BXkmK70zuAhbKWpvgKFuGR2Uwwvc8aEpxUIIgoOV9fCEdbIFN1MIkUH
 A0EZ/amr8lQ/5OmsnV4dyMkQv3k/0ymDSkeqYP3icwvkb5/+dGxmwRwYcZqgVetifa3r
 NGvCbs/5Z08w3WOnHhVqM9QrUyINHuy71wl9AJmP+xFJNHwhRitMOWDxxYKGfc2cR0Tx
 GN2urTFf/KlselvvCduM7K2yG3uiaX0XuyxT7MWnrDZ8bEsYwh1aonA8ZMSj3lE9QkKy
 oZXQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpK+gOw3S1VTaSrD5Tb02wwDhDq8aXh7EyaJxWdKjVMtqf08JzilMsb9XhgTwIkHYvX9RE=@dpdk.org
X-Gm-Message-State: AOJu0YwOoIg+jB81MSUmfg9WQSYtMS40OoyL1mlZcnWrl+H5nx7qOhw+
 SlRYbQgRhYrye2bmC0a68isQN8T7VaC6ChGJIco57dumCi7juoovBAX97pduIqBu/ZQ=
X-Gm-Gg: AfdE7ckDhBNTS9vMomCyI6oEMtMC3Xw7wV/sFa1xCkt87/B+BpeqM2+ut4NGVn1R8/f
 0yL1+gmUtgJefkVqaaFQyr6TMPpK2/ogzQE+IM6PlE0/XunuRNohNZeoUzM7edYvidVckUZUlV+
 wZgJ7L7ThhVa4RAwSjWDwwMANpxOGZoPlPVZhFNdbZTox0ZeBQe4DABOj2GVnKv2xx2nAPppXqD
 0nUw2LAm73py3YfLvyNXB/d4hHvQIISpTehW1DTlkif0qCe1uxymNJvtkXTVz2csgdQeriBe4Xp
 goE7+CmBEVCYfmAkM652u94RTb66gTol5LrzqzaFCgEc/OzPI+Ko/UB+HLx+JTX+0DsmCfrkgZR
 /6dvKZTCJLA+fonHhxlB16h+m9/glxdWzunX2RZuOeQunUYg4UESSCv+lHMAO8NTYnE4rkhPPyA
 cTXKOM03ldqWxITbVZKBWwcqhDp6DAnBAGkWhMuBoMnQFC59xr6rs2AA==
X-Received: by 2002:a05:7300:6d20:b0:30c:6673:39a6 with SMTP id
 5a478bee46e88-30c667339femr87227eec.14.1782222527202; 
 Tue, 23 Jun 2026 06:48:47 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c5c1056f8sm4416914eec.15.2026.06.23.06.48.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 06:48:47 -0700 (PDT)
Date: Tue, 23 Jun 2026 06:48:44 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Thomas Monjalon <thomas@monjalon.net>, David Marchand
 <david.marchand@redhat.com>, Bruce Richardson <bruce.richardson@intel.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, <dev@dpdk.org>
Subject: Re: [PATCH 0/5] add versioned symbols for recently stabilized APIs
Message-ID: <20260623064844.07f28870@phoenix.local>
In-Reply-To: <20260623113752.1100072-1-dsosnowski@nvidia.com>
References: <20260623113752.1100072-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 23 Jun 2026 13:37:46 +0200
Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:

> Main goal of this patchset is to address https://bugs.dpdk.org/show_bug.cgi?id=1957
> but it also handles other recently stabilized symbols and has some minor fixes:
> 
> - Patch 1 - Fix RTE_VERSION_EXPERIMENTAL_SYMBOL macro on clang.
> - Patch 2 - Allow function versioning inside drivers.
> - Patch 3 - Version the function symbols stabilized in
>   https://git.dpdk.org/dpdk/commit/?id=e8cab133645f5466ef75e511629add43b68a5027
> - Patch 4 - Introduce versioning macros for global variable symbols.
> - Patch 5 - Version the function and variable symbols stabilized in
>   https://git.dpdk.org/dpdk/commit/?id=4ee2f5c1cedf9ee7f39afa667f71b07f4004ba5c
> 
> Issue is still not fully fixed for stabilized global variables:
> rte_flow_dynf_metadata_offs and rte_flow_dynf_metadata_mask.
> Patch 4 and 5 address the bug for these global variables,
> by providing a single storage for both EXPERIMENTAL and
> DPDK_26 variable symbol versions.
> This is achieved through symbol aliasing.
> But this solution is limited only to executables compiled with clang.
> 
> clang and gcc have a different default behavior regarding relocations
> of global variables exposed by shared libraries.
> 
> With clang, R_X86_64_GLOB_DAT relocations are generated for executables:
> 
>    $ readelf -sW build-26.07/lib/librte_ethdev.so | grep rte_flow_dynf_metadata_offs
>        113: 00000000000ea4c0     4 OBJECT  GLOBAL DEFAULT   24 rte_flow_dynf_metadata_offs@@DPDK_26
>        116: 00000000000ea4c0     4 OBJECT  GLOBAL DEFAULT   24 rte_flow_dynf_metadata_offs@EXPERIMENTAL
>        970: 00000000000ea4c0     4 OBJECT  LOCAL  DEFAULT   24 rte_flow_dynf_metadata_offs_impl
>       1212: 00000000000ea4c0     4 OBJECT  LOCAL  DEFAULT   24 rte_flow_dynf_metadata_offs_v26
>       1325: 00000000000ea4c0     4 OBJECT  LOCAL  DEFAULT   24 rte_flow_dynf_metadata_offs_exp
>       1415: 00000000000ea4c0     4 OBJECT  GLOBAL DEFAULT   24 rte_flow_dynf_metadata_offs@@DPDK_26
>       1705: 00000000000ea4c0     4 OBJECT  GLOBAL DEFAULT   24 rte_flow_dynf_metadata_offs@EXPERIMENTAL
> 
>     $ readelf -rW build-26.07/drivers/librte_net_mlx5.so | grep rte_flow_dynf_metadata_offs
>     0000000003ed5f18  0000001600000006 R_X86_64_GLOB_DAT      0000000000000000 rte_flow_dynf_metadata_offs@DPDK_26 + 0
> 
>     $ readelf -rW build-25.11/app/dpdk-testpmd | grep rte_flow_dynf_metadata_offs
> --> 000000000028ef70  0000011300000006 R_X86_64_GLOB_DAT      0000000000000000 rte_flow_dynf_metadata_offs@EXPERIMENTAL + 0  
> 
> With gcc, R_X86_64_COPY relocations are generated:
> 
>     $ readelf -sW build-26.07/lib/librte_ethdev.so | grep rte_flow_dynf_metadata_offs
>        113: 00000000000e74e0     4 OBJECT  GLOBAL DEFAULT   24 rte_flow_dynf_metadata_offs@@DPDK_26
>        116: 00000000000e74e0     4 OBJECT  GLOBAL DEFAULT   24 rte_flow_dynf_metadata_offs@EXPERIMENTAL
>       1471: 00000000000e74e0     4 OBJECT  LOCAL  DEFAULT   24 rte_flow_dynf_metadata_offs_impl
>       2134: 00000000000e74e0     4 OBJECT  LOCAL  DEFAULT   24 rte_flow_dynf_metadata_offs_v26
>       2247: 00000000000e74e0     4 OBJECT  LOCAL  DEFAULT   24 rte_flow_dynf_metadata_offs_exp
>       2337: 00000000000e74e0     4 OBJECT  GLOBAL DEFAULT   24 rte_flow_dynf_metadata_offs@@DPDK_26
>       2627: 00000000000e74e0     4 OBJECT  GLOBAL DEFAULT   24 rte_flow_dynf_metadata_offs@EXPERIMENTAL
> 
>     $ readelf -rW build-26.07/drivers/librte_net_mlx5.so | grep rte_flow_dynf_metadata_offs
>     00000000046dbef0  0000001600000006 R_X86_64_GLOB_DAT      0000000000000000 rte_flow_dynf_metadata_offs@DPDK_26 + 0
> 
>     $ readelf -rW build-25.11/app/dpdk-testpmd | grep rte_flow_dynf_metadata_offs
> --> 000000000029b540  000001d200000005 R_X86_64_COPY          000000000029b540 rte_flow_dynf_metadata_offs@EXPERIMENTAL + 0  
> 
> With copy relocations (testpmd linked through gcc) the following happens:
> 
> - When variable symbol (with EXPERIMENTAL version) gets resolved inside executable,
>   global variable gets copied from read-only data to executable's BSS section.
>   Executable will access this variable through BSS.
> - When variable symbol (with DPDK_26 version) gets resolved inside a library,
>   global variable is accessed indirectly through GOT.
>   It is stored inside BSS section of the shared library.
> 
> So executable and libraries refer to different storage,
> eventually leading to inconsistent runtime behavior.
> Problems only appears when executable and library require
> different versions of global variable symbol.
> If testpmd from 26.07 is used with libraries from 26.07,
> GOT entry for these variables will point to copied variable.
> 
> Without copy relocations (testpmd linked through clang) both
> executable and libraries access the global variable indirectly through GOT.
> Runtime behavior is consistent, regardless of the mix of variable symbol versions.
> 
> The only other solution I could find was to use dlsym() inside libraries
> to dynamically resolve the location rte_flow_dynf_metadata_offs and rte_flow_dynf_metadata_mask,
> but this solution sounds like an overkill.
> Essentially this would require moving to getter/setter functions for these variables
> inside the library.
> 
> I would appreciate any feedback or suggestions if anybody had encountered a similar issue before.
> 
> Dariusz Sosnowski (5):
>   eal: fix macro for versioned experimental symbol
>   drivers: support function versioning
>   net/mlx5: fix stabilized function versions
>   eal: support aliases for versioned variable symbols
>   ethdev: fix promoted flow metadata symbols
> 
>  buildtools/gen-version-map.py        | 11 ++++++++++
>  drivers/meson.build                  |  8 +++++++
>  drivers/net/mlx5/meson.build         |  2 ++
>  drivers/net/mlx5/mlx5_driver_event.c | 22 ++++++++++++++-----
>  drivers/net/mlx5/mlx5_flow.c         | 18 ++++++++++-----
>  lib/eal/common/eal_export.h          | 24 +++++++++++++++++++-
>  lib/ethdev/meson.build               |  2 ++
>  lib/ethdev/rte_flow.c                | 33 ++++++++++++++++++----------
>  8 files changed, 96 insertions(+), 24 deletions(-)
> 
> --
> 2.47.3
> 

The bugfix is good, but not sure the rest is needed right now.
It is getting late to add more stuff for 26.07 and in 26.11 function versioning
will not be needed.
