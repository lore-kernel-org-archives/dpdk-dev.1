Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7BBFF8875
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 22:04:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C8BC4028C;
	Thu, 30 Apr 2026 00:04:55 +0200 (CEST)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169]) by mails.dpdk.org (Postfix) with ESMTP id BC73940280
 for <dev@dpdk.org>; Thu, 30 Apr 2026 00:04:54 +0200 (CEST)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-2d8ffdc31d0so806968eec.0
 for <dev@dpdk.org>; Wed, 29 Apr 2026 15:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777500294;
 x=1778105094; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t/5sGs0PBhTWpSBDB6X/n8BMon0XsEkYBAA6UZAOA+k=;
 b=wR7oLKllJZAMUCAi6O5GLisMY70mLO8UgV8YL2k2fbxIy87kq3wykN6yUpvvDuUa3f
 WNHFHoptPKY7l7PLxncGkzTwy5XTeaGz8d88PQgaWUvldUfgeTOKAO4wvaP0a9REZ8u5
 KRnMWHMMVQZ+/+m93S5/ryjY0FpSt4kZbEO7h1qr2sf929EYOWG/If3Chs26ar5eMnFt
 eeTDumCpcGHjXW/Aoh1AbB5ofmbG0XmWFXe7tiUCvyocqvSDmGSqTnqQaVdEVkkJCBoP
 ZN73tDVFcQHqck4+DtwVgDcwMDeiFt6+hrsGKdRQrh6sy0yRT5XhkGVZ/aBQGyzhf2Gs
 Z+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777500294; x=1778105094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t/5sGs0PBhTWpSBDB6X/n8BMon0XsEkYBAA6UZAOA+k=;
 b=aj9ehQO0rw46EkGAyoQLv0b1Qax7/kXPuIo2C35d0XR2ESDV7awLqbILSHgTkHfLLz
 vr4xCRPPCy5424/jGetn6X7Y+bqB7T9+tsoL+Sl596btESdLKS5ZK2xLK9Gv8Sde4duH
 F6fRovv858T+UZbGykc3/NSbvIS/8ryforTpcJ3mMIN9gvyvQjOYjErg/x9cw8g08Xv1
 V6pYIQ0Kan8E8rvenriJhNDdyii5hMbjnK1ET1f2XP3U2cI8o+YuVhUTYNDCksBUrD2U
 H5elh8DdENPJY8Lv0NMES0uMlVNgfVNGwsSH8x6FqjjxGQjnkgWXIRYBS5oJtUjQab4G
 +FTw==
X-Gm-Message-State: AOJu0YwolQZ0l2YMQYtvuLgr4BAfdG+T62m32n5Efdkq8YqV+VFPvdpM
 zPEZ4QUExyhqW7BAf5+ubzdBuwzoRAyehlTELOgurxaXQ3LvNUr4XAFVrTfLWA15GlY=
X-Gm-Gg: AeBDietpZQddLGTCwk0o1SrhuWl2wCFAqlg3SSUeWyxOKQt8LRa198twLScQeCw4blK
 R1GJkNoSPLeMQTowPwsNR6txA7QGwIJ0PlsbNs6xcnuv6RuWM4xPAmuIt2qdx8Nu3cXsDmJ6YmL
 vLVJY0bF7t17qHV4ci4DEVxPGxY2J9voY23AylceKryTZjotM48QfyCC3IAZRIYBnZqUiW6M0jn
 EiPCL1DAYMemCOWEq3yFNTpz1Ga44eaZRzv594n88jZVJtnp8EVOprsVoQ8tAlDKtPNRdMtE5Iw
 Fzys85nDFoL04v7LggGnDOxP9ZpIaT3p+IjuBWGlKMoRYP5rHwIrb7h0gFSZ2N//5KJ6QtLkU7o
 xJonpkanYnpSL0eqTZLT4iZVoazsOpDU+CmHZgYLM1UVgbOAOYypwH8fWd3qksktEnTFC179JM1
 oSTpAytgdK3L50VtIDj96JIC7yl1Iig6sfRmq2eg7sverqPQ==
X-Received: by 2002:a05:7300:d4c7:b0:2e6:e504:5435 with SMTP id
 5a478bee46e88-2ed3cabb3a2mr74987eec.12.1777500293142; 
 Wed, 29 Apr 2026 15:04:53 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1bf6d263sm4113851eec.5.2026.04.29.15.04.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:04:52 -0700 (PDT)
Date: Wed, 29 Apr 2026 15:04:49 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, techboard@dpdk.org
Subject: Re: [RFC PATCH 00/44] Allow intitializing EAL without argc/argv
Message-ID: <20260429150449.797b6855@phoenix.local>
In-Reply-To: <20260429165845.2136843-1-bruce.richardson@intel.com>
References: <20260429165845.2136843-1-bruce.richardson@intel.com>
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

On Wed, 29 Apr 2026 17:57:52 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> The ultimate end goal of this RFC is, as stated in the title, to move
> away from argc/argv as the sole means of configuring EAL on init. This
> set therefore looks to:
> * rework EAL so that we have a generic EAL init function taking a
>   struct-based configuration
> * provide a rough *example* of how that might be used to create a new
>   set of C APIs to be used by apps to initialize EAL without having to
>   create dummy argc/argv pairs. [A side benefit of this is that it
>   makes it a lot easier to initialize EAL from other languages like Rust
>   or Python too, because arrays of C strings are not the most
>   user-friendly for a foreign interface]
> 
> Therefore this set can be considered in 3 parts:
> 
> Part 1: Struct rework.
> 
> Largely for legacy reasons, we have a number of different structs and
> arrays holding eal configuration, without having clear guides as to why
> certain fields are stored where. The first ~30 patches rework the
> existing structs - rte_config, internal_config, lcore_config etc.
> into three defined-purpose structs:
> 
> - eal_platform_info - contains the raw HW info for the system, details
>   of CPUs and hugepage mounts. This is initialized on first use - even
>   before EAL init is called - and is then immutable, since our HW should
>   not change much underneath us. Its early availability means that it
>   can be used to sanity check the contents of the other structs as they
>   are being built up.
> 
> - eal_user_cfg - contains the config settings passed in by the user. For
>   existing rte_eal_init, this is built up in the arg parse stage, and
>   it's contents verified against the platform info, e.g. to check core
>   masks are valid etc. Once argument parsing is completed, is also
>   immutable.
> 
> - runtime_cfg - basically all the runtime settings that need to be there
>   for DPDK to run, or which change over time. Largely combined content
>   of the old rte_config, internal_config and lcore_config structs. This
>   is initialized from the other two structs by eal initialization and
>   can be modified by EAL at any time.
> 
> Part 2: Cleanup and Split EAL init
> 
> With the 3 structs clearly separated by purpose, we can then do some
> cleanup of the code, before - in patches 35 & 36 - splitting EAL into
> two and providing an *internal* struct-based alternative API for
> initializing DPDK. The old rte_eal_init function still exists, just the
> contents of it after the argument parsing are put into a new, static
> eal_runtime_init() function, which take the argparse output (user_cfg
> struct). Patch 36, adds a thin internal-API wrapper around this static,
> which is necessary to take care of things like the run-once flag.  [This
> wrapper should never be the public API, since the struct will change and
> therefore be an ABI break. It's designed to be used by other wrapper
> libs which provide a stable ABI for config]
> 
> Part 3: Prototype of an eal_cfg library
> 
> Once we have the internal C API to init eal using a struct
> rte_eal_user_cfg, we can create new libraries which provide alternate
> ways to build up the user_cfg and initialize DPDK. Patches 37-44 have a
> rough example of such a library.
> 
> - The lib allows a user to create an opaque rte_eal_user_cfg struct,
>   which can then be modified by APIs to get/set various parameters
>   before calling rte_cfg_eal_init().
> - An alternative way to do things (not prototyped), may be to have a
>   library that creates an eal_user_cfg struct based on the contents of
>   an ini file using the configfile library.
> [Both these options could be used in parallel. Note too that both have
> no ABI implications for adding new flags, or making old ones no-ops!]
> 
> Bruce Richardson (44):
>   eal: define new functionally distinct config structs
>   eal: move memory request fields to user config
>   eal: move NUMA request fields to user config
>   eal: move hugepage policy fields to user config
>   eal: move process policy fields to user config
>   eal: move advanced user config options to user cfg struct
>   eal: move hugepage size info to platform info struct
>   telemetry: make cpuset init parameter const
>   eal: move runtime state to appropriate structure
>   eal: record details of all cpus in platform info
>   eal: use platform info for lcore lookups
>   eal: add RTE_CPU_FFS macro
>   eal: store lcore configuration in runtime data
>   eal: cleanup CPU init function
>   eal: move numa node information to platform info struct
>   eal: move lcore role and count to runtime state
>   eal: make lcore role a field in lcore config struct
>   eal: move main lcore setting to runtime config struct
>   eal: move iova mode and process type to runtime cfg
>   eal: move memory config pointer to runtime state struct
>   eal: remove rte_config structure
>   eal: separate runtime state update from arg parsing
>   eal: move devopt_list staging list into user_cfg
>   eal: separate plugin paths from loaded plugin objects
>   eal: simplify internal driver path iteration APIs
>   eal: move trace config into user config struct
>   eal: record service cores in user config struct
>   eal: store user-provided lcore info in user config struct
>   eal: clarify docs on params taking lcore IDs
>   eal: remove internal config reset function
>   eal: move functions setting runtime state
>   eal: initialize platform info on first use
>   eal: remove duplicated scan of sysfs for hugepage details
>   eal: add utilities for working with user config struct
>   eal: split EAL init into two stages
>   eal: provide hooks for init with externally supplied config
>   eal_cfg: add new library to programmatically init DPDK
>   eal_cfg: configure defaults for easier testing and use
>   app/test: enable testing init using EAL config lib
>   eal_cfg: add basic setters and getters
>   eal_cfg: add hugepage memory configuration
>   eal_cfg: support configuring lcores
>   eal_cfg: support device and driver lists
>   eal_cfg: add APIs for configuring remaining init settings
> 
>  app/test/meson.build                      |    1 +
>  app/test/process.h                        |    4 +-
>  app/test/test.c                           |   14 +-
>  app/test/test.h                           |    1 +
>  app/test/test_eal_cfg.c                   | 1323 +++++++++++++++++++++
>  doc/api/doxy-api-index.md                 |    1 +
>  doc/api/doxy-api.conf.in                  |    1 +
>  doc/guides/linux_gsg/eal_args.include.rst |   38 +-
>  doc/guides/prog_guide/eal_cfg_lib.rst     |   23 +
>  doc/guides/prog_guide/index.rst           |    1 +
>  lib/eal/common/eal_common_bus.c           |    4 +-
>  lib/eal/common/eal_common_config.c        |  221 +++-
>  lib/eal/common/eal_common_dynmem.c        |   66 +-
>  lib/eal/common/eal_common_fbarray.c       |   10 +-
>  lib/eal/common/eal_common_launch.c        |   25 +-
>  lib/eal/common/eal_common_lcore.c         |  230 ++--
>  lib/eal/common/eal_common_mcfg.c          |   44 +-
>  lib/eal/common/eal_common_memalloc.c      |    5 +-
>  lib/eal/common/eal_common_memory.c        |  104 +-
>  lib/eal/common/eal_common_memzone.c       |   24 +-
>  lib/eal/common/eal_common_options.c       |  823 +++++--------
>  lib/eal/common/eal_common_proc.c          |   43 +-
>  lib/eal/common/eal_common_tailqs.c        |    6 +-
>  lib/eal/common/eal_common_thread.c        |   81 +-
>  lib/eal/common/eal_common_timer.c         |    2 +-
>  lib/eal/common/eal_common_trace.c         |   30 +-
>  lib/eal/common/eal_common_trace_utils.c   |  104 --
>  lib/eal/common/eal_hugepages.h            |    8 +
>  lib/eal/common/eal_internal_cfg.h         |  376 +++++-
>  lib/eal/common/eal_memcfg.h               |    3 +
>  lib/eal/common/eal_option_list.h          |    6 +-
>  lib/eal/common/eal_options.h              |    7 +-
>  lib/eal/common/eal_private.h              |  108 +-
>  lib/eal/common/eal_trace.h                |   11 -
>  lib/eal/common/malloc_elem.c              |   15 +-
>  lib/eal/common/malloc_heap.c              |   41 +-
>  lib/eal/common/malloc_mp.c                |    2 +-
>  lib/eal/common/rte_malloc.c               |   14 +-
>  lib/eal/common/rte_service.c              |   17 +-
>  lib/eal/freebsd/eal.c                     |  271 +++--
>  lib/eal/freebsd/eal_hugepage_info.c       |   71 +-
>  lib/eal/freebsd/eal_lcore.c               |   16 +-
>  lib/eal/freebsd/eal_memory.c              |   46 +-
>  lib/eal/freebsd/include/rte_os.h          |    2 +
>  lib/eal/include/rte_eal.h                 |   35 +-
>  lib/eal/include/rte_memzone.h             |   10 +-
>  lib/eal/include/rte_tailq.h               |    2 +-
>  lib/eal/linux/eal.c                       |  280 +++--
>  lib/eal/linux/eal_hugepage_info.c         |  219 ++--
>  lib/eal/linux/eal_lcore.c                 |   13 +
>  lib/eal/linux/eal_memalloc.c              |  168 ++-
>  lib/eal/linux/eal_memory.c                |  153 ++-
>  lib/eal/linux/eal_timer_hpet.c            |   21 +-
>  lib/eal/linux/eal_vfio.c                  |   11 +-
>  lib/eal/linux/include/rte_os.h            |   10 +
>  lib/eal/unix/eal_unix_thread.c            |   11 +-
>  lib/eal/windows/eal.c                     |  177 ++-
>  lib/eal/windows/eal_hugepages.c           |   60 +-
>  lib/eal/windows/eal_lcore.c               |    6 +
>  lib/eal/windows/eal_memalloc.c            |   37 +-
>  lib/eal/windows/eal_memory.c              |   14 +-
>  lib/eal/windows/eal_thread.c              |   11 +-
>  lib/eal/windows/eal_windows.h             |    8 -
>  lib/eal/windows/include/rte_os.h          |    1 +
>  lib/eal/windows/include/sched.h           |   10 +
>  lib/eal_cfg/eal_cfg.c                     |  918 ++++++++++++++
>  lib/eal_cfg/meson.build                   |    6 +
>  lib/eal_cfg/rte_eal_cfg.h                 |  903 ++++++++++++++
>  lib/meson.build                           |    1 +
>  lib/telemetry/telemetry.c                 |    4 +-
>  lib/telemetry/telemetry_internal.h        |    2 +-
>  71 files changed, 5450 insertions(+), 1884 deletions(-)
>  create mode 100644 app/test/test_eal_cfg.c
>  create mode 100644 doc/guides/prog_guide/eal_cfg_lib.rst
>  create mode 100644 lib/eal_cfg/eal_cfg.c
>  create mode 100644 lib/eal_cfg/meson.build
>  create mode 100644 lib/eal_cfg/rte_eal_cfg.h
> 
> --
> 2.51.0
> 

Lots of AI feedback below.
I would also add that use of atoi() is on the naughty list and any new
code using it is going to get bad marks.


Review of RFC PATCH 0/44: EAL init args series
=================================================

This is a substantial and well-motivated rework. Splitting internal_config
into eal_user_cfg / eal_platform_info / eal_runtime_state is the right shape,
and the new eal_cfg library is a clean way to expose programmatic init.
Below are the issues found across the series, organised by patch.


Patch 02/44 (eal: move memory request fields to user config)
------------------------------------------------------------

Error: eal_parse_args() reads the memory size with atoi() and then promotes
via *= 1024ULL into user_cfg->memory (a size_t). atoi() returns int and has
no error reporting; values that don't fit in int, are negative, or are
non-numeric are silently turned into garbage and then multiplied. This is a
pre-existing pattern, but you are touching the exact line - please switch
to strtoull() with errno check while you are here, mirroring the validation
you already do for nchannel/nrank in this same hunk.

Warning: in the new nrank validation, "nrank > 16 || nrank > UINT8_MAX" -
the second clause is dead because 16 < UINT8_MAX. Drop the > UINT8_MAX
check (the > 16 covers it).

Info: throughout the eal_memory.c hunks you alternate between caching
"const struct eal_user_cfg *user_cfg = eal_get_user_configuration();" and
inlining "eal_get_user_configuration()->memory" repeatedly in the same
function. Pick one style; the inlined repeated calls also add a function
call per access.


Patch 05/44 (eal: move process policy fields to user config)
------------------------------------------------------------

Info: several "int_cfg->X = true;" assignments where X is still
"volatile unsigned" in internal_config (e.g. legacy_mem,
single_file_segments, match_allocations). Compiles, but mixes bool and
unsigned - convert these fields in this same patch or stay with 1/0 until
they move.


Patch 09/44 (eal: move runtime state to appropriate structure)
--------------------------------------------------------------

Warning: eal_reset_internal_config() loses its "struct internal_config *"
parameter, so existing out-of-tree callers break silently (no compile
error, since the function exists). Worth a release-note line.


Patch 11/44 (eal: use platform info for lcore lookups)
------------------------------------------------------

Error: behavioural regression that is not called out in the commit
message. The old eal_cpuset_socket_id() returned SOCKET_ID_ANY when a
cpuset spanned multiple NUMA nodes; the new thread_update_affinity() for
non-EAL threads, and the new rte_lcore_to_socket_id(), both pick the NUMA
id of the first CPU in the set. After this patch, rte_socket_id() for a
control thread pinned to CPUs on two sockets will silently return one
socket id instead of SOCKET_ID_ANY. Drivers that rely on SOCKET_ID_ANY to
pick a per-call NUMA node will be affected. Either preserve the prior
semantics or call out the change.


Patch 12/44 (eal: add RTE_CPU_FFS macro)
----------------------------------------

Warning: _cpu_ffs() in lib/eal/linux/include/rte_os.h uses a leading
underscore, which is reserved at file scope by C11 7.1.3. Use a different
name (e.g. rte_cpu_ffs_impl).

Warning: cpu_ffs() in lib/eal/windows/include/sched.h has no rte_ or RTE_
prefix and is exposed via a header that is included broadly on Windows
builds. Likely to clash with anything else that defines cpu_ffs. Rename
or static inline with a prefix.


Patch 14/44 (eal: cleanup CPU init function)
--------------------------------------------

Warning: lcore_to_socket_id is calloc()-allocated but only filled for CPUs
where eal_cpu_detected(cpu_id) != 0. Skipped slots remain 0 from calloc,
so the subsequent qsort + dedup loop counts socket 0 even on systems where
no detected CPU is on socket 0. This was also true of the prior stack
array (= {0}), so no regression - but it is worth fixing while the code is
being rewritten: only push detected sockets into the array, then qsort
and dedup only the populated prefix.

Info: the commit message says the function should "not make any changes
to runtime_state but only the platform_info", but it still writes
config->numa_node_count and config->numa_nodes (rte_config). That
ownership move happens in patch 15; consider tightening the commit
message, or merge the two patches.


Patch 15/44 (eal: move numa node information to platform info)
--------------------------------------------------------------

Error: realloc(p, 0) is implementation-defined in C17 and explicitly
undefined in C23. The code:

    uint32_t *tmp = realloc(platform_info->numa_nodes,
            numa_node_count * sizeof(*platform_info->numa_nodes));
    if (tmp != NULL)
        platform_info->numa_nodes = tmp;

If numa_node_count is 0 (a system with cpu_count > 0 but no detected
CPUs - degenerate but reachable on some virtualised setups), some libcs
free the buffer and return NULL, leaving platform_info->numa_nodes
pointing at freed memory - a use-after-free on the next access. Add an
"if (numa_node_count == 0)" early-out, or skip the realloc-shrink
entirely when 0.

Warning: malloc(platform_info->cpu_count * sizeof(...)) with no overflow
check. cpu_count comes from sysconf / sysctl and is bounded in practice,
but a single safer expression - e.g. calloc(cpu_count, sizeof(*numa_nodes))
- is just as cheap.


Patch 18/44 (eal: move main lcore setting to runtime config)
------------------------------------------------------------

Warning: in eal_parse_main_lcore():

    user_cfg->main_lcore = (uint32_t) strtol(arg, &parsing_end, 0);

user_cfg->main_lcore is declared int (added in this patch). The (uint32_t)
cast then store into int is dead in the success path and confusing - looks
like a leftover from when the field was uint32_t. Either drop the cast,
or use strtoul() and remove the sentinel/range games. The downstream
sentinel check "user_cfg->main_lcore != -1" is fragile because nothing in
this function's positive path is prevented from producing -1 (e.g. user
passing 4294967295); the subsequent ">= RTE_MAX_LCORE" check happens to
catch it via unsigned promotion, but the chain is brittle.


Patch 22/44 (eal: separate runtime state update from arg parsing)
-----------------------------------------------------------------

Error: this patch moves the per-NUMA -> total-memory summing out of
eal_apply_runtime_state() and into the body of eal_parse_args():

    /* sum per-NUMA memory requests into user_cfg->memory */
    for (int i = 0; i < RTE_MAX_NUMA_NODES; i++)
        user_cfg->memory += user_cfg->numa_mem[i];

In patch 31, eal_apply_runtime_state() is no longer called from
eal_parse_args() - it is invoked explicitly from rte_eal_init(). After
patch 36, the second init path rte_eal_runtime_init() (used by
rte_eal_init_from_cfg()) calls eal_apply_runtime_state() but never goes
through eal_parse_args(), so the summing loop never runs. A user who
configures numa_mem[] via rte_eal_cfg_set_numa_mem() ends up with
user_cfg->memory == 0 going into eal_dynmem_calc_num_pages_per_socket()
and the linux/eal.c "no-huge fallback to 64MB" check, which is wrong.
Move the summing into eal_apply_runtime_state() (or into a small helper
that both paths call) so the eal_cfg path produces the same
user_cfg->memory as the CLI path.


Patch 32/44 (eal: initialize platform info on first use)
--------------------------------------------------------

Error: resource leak / double-allocation on retry in the lazy initializer:

    if (rte_eal_cpu_init(&eal_platform_info) < 0) { ...; return NULL; }
    if (eal_get_platform_hp_info(&eal_platform_info) < 0) { ...; return NULL; }

Both functions assign to platform_info->cpu_info, numa_nodes, etc. with
calloc/malloc and never free on the failure path. If
eal_get_platform_hp_info() fails, cpu_info and numa_nodes are leaked,
"initialized" is left false, and a subsequent call retries
rte_eal_cpu_init() which overwrites the leaked pointers. Either set
"initialized = true" only once everything succeeds and add explicit
cleanup of the partially-built struct on failure, or refuse to retry
after the first failure.

Warning: eal_get_platform_hp_info() (Linux) writes hps->max_pages[socket]
where socket comes from platform_info->numa_nodes[i] (a discovered NUMA
node id) and max_pages[] is sized RTE_MAX_NUMA_NODES. On systems where
the kernel reports a NUMA node id >= RTE_MAX_NUMA_NODES (sparse NUMA
topologies on large boxes), this is an out-of-bounds write. Bound-check
before indexing.

Warning: eal_get_platform_hp_info() calls rte_str_to_size(...) and stores
the result as the page size without checking for 0 (rte_str_to_size
returns 0 on failure). A malformed "hugepages-XYZ" directory name would
silently install a phantom page-size-0 entry and make later loops divide
by zero or count infinite pages.

Warning: eal_get_platform_info() is renamed to rte_eal_get_platform_info()
and exported as __rte_internal in patch 36, but in patch 32 itself the
function is still called eal_get_platform_info() from many call sites
that get switched again in patch 36. Two renames of the same set of call
sites in adjacent patches makes bisecting noisy - consider squashing patch
36's rename into 32, or doing the rename in its own no-op patch ahead of
both.

Warning: in eal_hugepage_info_read() (Linux), the new tail-counting loop:

    for (unsigned int i = 0; i < MAX_HUGEPAGE_SIZES; i++) {
        if (runtime_state->hugepage_info[i].hugepage_sz == 0)
            break;
        runtime_state->num_hugepage_sizes = i + 1;
    }

assumes the primary process always writes a contiguous prefix of valid
entries followed by zeros. The shared-memory layout is sizeof
hugepage_info[MAX_HUGEPAGE_SIZES] and the primary writes via memcpy after
qsort - so any unused tail entries do come through as zero, but only
because runtime_state is statically zero-initialised on the primary and
qsort sorts the populated prefix. A defensive primary-side memset of
unused tail entries would make this contract explicit instead of implicit.

Info: in the lazy init, the "unlikely(!atomic_load_acquire())" outer check
followed by spinlock_lock then re-check with relaxed is the standard
double-checked init pattern, but the inner re-check should use acquire
for symmetry - a relaxed load inside the lock is OK because the unlock
pairs with the next acquire, but readability suffers.


Patch 33/44 (eal: remove duplicated scan of sysfs for hugepage)
---------------------------------------------------------------

Info: this patch is the natural place to delete get_hugepage_dir() in
eal_hugepage_info.c if it is now only referenced from
eal_get_platform_hp_info(). If it still has another caller, fine - but
worth a grep and a note.


Patch 34/44 (eal: add utilities for working with user config)
-------------------------------------------------------------

Warning: eal_user_cfg_copy() does "*dst = *src;" then "TAILQ_INIT(&dst->...)".
Between those two statements, dst's list head pointers transiently alias
src's list head storage. Any signal handler or concurrent reader (none
today, but the global user_cfg is reachable via eal_get_user_configuration())
would observe a corrupt list. The safer order is: zero / TAILQ_INIT all
the list heads and pointer fields first, then copy the scalars
field-by-field, then deep-copy the lists. This also documents intent
better than relying on the shallow copy followed by surgery.

Warning: <malloc.h> is non-portable - glibc and Windows ship it; FreeBSD
does not provide it on the include path used by DPDK builds without
_BSD_SOURCE gymnastics. The existing pattern (see eal_common_lcore_var.c)
is "#ifdef RTE_EXEC_ENV_WINDOWS #include <malloc.h> #endif". Do the same
here, since <stdlib.h> is sufficient for free()/malloc() on POSIX.

Warning: eal_user_cfg_copy() is a static inline in a header that pulls in
<malloc.h>, <sys/queue.h>, rte_devargs.h, rte_trace.h, rte_vect.h,
rte_compat.h, rte_stdatomic.h, eal_thread.h. It is also large (~80 LoC of
deep-copy logic). For a function called once per init path, static inline
in a private header buys nothing and inflates compile times for every
translation unit that includes eal_internal_cfg.h. Move the body to a .c
file.


Patch 35/44 (eal: split EAL init into two stages)
-------------------------------------------------

Info: subject has a stray double space after the colon
("[RFC PATCH 35/44]  eal: ..."). Cosmetic.


Patch 36/44 (eal: provide hooks for init with externally-supplied config)
-------------------------------------------------------------------------

Warning: rte_eal_runtime_init() calls rte_eal_get_platform_info() to "make
sure platform info is available" before the init_has_run CAS. If two
threads call rte_eal_init_from_cfg() concurrently, both will trigger the
platform-info lazy init (which is internally locked, so safe), but only
one will pass the CAS. The other will leave with EALREADY, which is fine
- but you should document that rte_eal_init_from_cfg() is not callable
concurrently.

Warning: the eal_log_init(progname) call happens after the init_has_run
CAS in rte_eal_runtime_init() but before it in rte_eal_init() (where it
is implicit via the existing flow). On the EALREADY path the new function
logs nothing about who is racing, while the existing rte_eal_init() does.
Minor inconsistency.


Patch 37/44 (eal_cfg: add new library to programmatically init)
---------------------------------------------------------------

Warning: lib/eal_cfg/meson.build is silent about its dependency on eal.
Since eal_cfg calls rte_eal_runtime_init, eal_get_user_configuration,
etc., and uses eal_internal_cfg.h, the meson file should list
"deps += ['eal']" explicitly rather than relying on the library order in
lib/meson.build. The current file is just "sources = files(...)" plus an
"includes +=" line, which works only because eal happens to be earlier
in the list.

Warning: rte_eal_init_from_cfg() falls back to a stack-allocated local_cfg
when cfg == NULL. Because EAL_USER_CFG_INITIALIZER uses
&local_cfg.user_cfg.devopt_list etc., the TAILQ heads point into the
stack, which is correct - but eal_user_cfg_copy() then shallow-copies
"*dst = *src", which means dst's list heads briefly contain the address
of the source (stack) struct's first/last pointers before
TAILQ_INIT(&dst->...) overwrites them. That window is fine because the
lists are empty, but if you later add a non-empty default in
EAL_USER_CFG_INITIALIZER this becomes a bug. Worth a short comment in
eal_user_cfg_copy() calling out the dependency on empty default lists.


Patch 39/44 (app/test: enable testing init using EAL config lib)
----------------------------------------------------------------

Warning: the new do_recursive_call() reads RECURSIVE_ENV_VAR via getenv()
early in main(), then again later. Two getenv() calls on the same env var
in the same process are fine functionally, but the second read of
recursive_call was previously a file-scope static - consider passing the
value through instead, since you already changed the function signature.

Warning: the pre-EAL-init dispatch in main():

    if (recursive_call != NULL && strcmp(recursive_call, "test_eal_cfg_init") == 0)
        return test_eal_cfg_init();

bypasses all of the existing test setup (DPDK_TEST_PARAMS, signal
handlers, log redirection). That is intentional, but the test then calls
process_dup() from inside the spawned child to fan out subtests, and
process_dup() re-execs the binary with argv[0] only. That will not
propagate DPDK_TEST_PARAMS etc. Worth a comment that this dispatch path
is deliberately bare.


Patch 40/44 (eal_cfg: add basic setters and getters)
----------------------------------------------------

Error: rte_eal_cfg_set_max_simd_bitwidth() validates
"bitwidth >= RTE_VECT_SIMD_DISABLED && rte_is_power_of_2(bitwidth)" but
does not enforce "bitwidth <= RTE_VECT_SIMD_MAX" (= INT16_MAX + 1 =
32768). A caller passing 16384 or 32768 is accepted, but only 32768 is
actually a recognised value; 16384 is a valid power of two but never
produced by the parser and may not be handled by SIMD-bitwidth consumers.
Either mirror the parser's behaviour (only accept the named enum values
plus DISABLED) or document the accepted range.

Warning: the field type mismatch from patch 18 propagates here.
EAL_CFG_GETTER(int, main_lcore, -1) returns int correctly, and the setter
range-checks [0, RTE_MAX_LCORE) plus the -1 sentinel - but accepts any
other negative value through "val != -1 && (val < 0 || ...)", returning
ERANGE. Good. However the comparison in eal_apply_runtime_state()
(patch 31) is still "if (user_cfg->main_lcore != -1)". If you ever change
the sentinel, you have two places to update.

Warning: EAL_CFG_BOOL macro defines rte_eal_cfg_get_<name>() with
"if (cfg == NULL) return false;" on a single line. Some style checkers
complain; minor.

Warning: find_absent_numa_node() in the test scans for an unused NUMA id
by walking [0, RTE_MAX_NUMA_NODES) and returning the first id not in
pi->numa_nodes[]. On systems where NUMA ids are sparse (e.g. ids 0, 1,
8, 9), this returns 2, which the platform-info-driven validator may also
reject as "absent" - good for the test. But on a system that genuinely
has ids 0..RTE_MAX_NUMA_NODES-1, the test prints "Skipping ENODEV test"
- which is correct, but worth a printf indicating which platform-detected
ids are present so the skip is debuggable.

Info: the EAL_CFG_GETTER and EAL_CFG_BOOL macros are clever but make
RTE_EXPORT_EXPERIMENTAL_SYMBOL lines noisy and harder to grep for. A
short comment block at the macro definition explaining the
symbol-extraction requirements (no spaces, no statement before the
export) would help future maintainers.


Patch 41/44 (eal_cfg: add hugepage memory configuration)
--------------------------------------------------------

Error: rte_eal_cfg_set_in_memory(cfg, true) sets no_shconf = true and
hugepage_file.unlink_before_mapping = true, but the test
(test_eal_cfg_in_memory) explicitly notes "disabling it must not reverse
those" - and the implementation respects that by only setting those
fields when val == true. Good. However rte_eal_cfg_get_huge_unlink() will
then permanently report RTE_EAL_HUGE_UNLINK_ALWAYS even after the user
calls set_in_memory(cfg, false). The user has no way to undo "in_memory
implied huge_unlink=always" without explicitly calling
set_huge_unlink(EXISTING). This is asymmetric and surprising. Either
document it loudly in the in_memory setter doc comment, or auto-restore
the prior huge_unlink value when in_memory is cleared.

Warning: hugedir_is_hugetlbfs() uses statfs() only on Linux; on
FreeBSD/Windows it returns true permissively. The test
(test_eal_cfg_hugepage_dir) negative case (passing "/") will then fail on
FreeBSD since EAL_CFG won't reject it. Skip the negative test there too,
or implement statfs for FreeBSD.

Warning: rte_eal_cfg_set_hugefile_prefix() rejects '%' to match the
parser, but allows other path-affecting characters like '/'. Worth either
a clear doc note ("the prefix is used as a filename component, not a
path") or a stricter validator.

Warning: rte_eal_cfg_set_huge_unlink(RTE_EAL_HUGE_UNLINK_NEVER) sets
unlink_existing = false and unlink_before_mapping = false. But the
default EAL_USER_CFG_INITIALIZER sets unlink_existing = true. So the only
way to reach NEVER is via the new setter - fine. However, the inverse
mapping in get_huge_unlink() returns EXISTING when both flags are at
their default (existing=true, before_mapping=false), and EXISTING
corresponds to "remove stale at startup, keep new". A user who reads
get_huge_unlink() on a fresh handle gets EXISTING, which matches the CLI
default, but the doc comment for RTE_EAL_HUGE_UNLINK_EXISTING and the
EAL_USER_CFG_INITIALIZER should cross-reference each other so this
contract is obvious.


Patch 42/44 (eal_cfg: support configuring lcores)
-------------------------------------------------

Error: subtest_eal_cfg_init_lcore_affinity picks two random CPUs with
"srand((unsigned int)time(NULL)); idx = rand() % ncpus;". Using
time()-seeded rand() in a unit test makes the test flaky-by-design when
CI runs many tests within the same second, and it produces
non-reproducible failures. Pin to deterministic indices (e.g. first two
detected CPUs).

Warning: rte_eal_cfg_set_lcore() allocates a new rte_cpuset_t only when
the slot is currently NULL, then memcpy's the input - so on replace=true
for an already-populated slot, it correctly reuses the buffer. But on
replace=false returning EEXIST, the function leaves
lcore_cpusets[lcore_id] untouched, which is the right behaviour but worth
an explicit comment because the early-return is doing double duty.

Warning: rte_eal_cfg_set_service_lcore() requires the lcore to already be
configured via set_lcore() and returns ENOENT otherwise. That ordering
requirement is documented in the doc comment, but the test
(test_eal_cfg_service_lcore) doesn't appear to cover the
"set_service_lcore before set_lcore" failure case in this patch - only
via add_lcores_from_affinity paths. Add the negative test.

Warning: subtest_eal_cfg_init_lcore_affinity calls rte_eal_cleanup() at
the end and returns TEST_SUCCESS. But this is running inside a subprocess
spawned by process_dup(). If rte_eal_cleanup() ever exits non-zero or
aborts (e.g. on shared-memory teardown failure), the subprocess returns
non-zero and the parent reports the test as failed. Capture the cleanup
return code and fail explicitly rather than implicitly.

Warning: subtest_eal_cfg_init_lcore_affinity reads pi->cpu_info[i].detected
on a pi that may have only been initialised by the lazy
rte_eal_get_platform_info() triggered inside the test - but the test
calls rte_eal_get_platform_info() before rte_eal_init_from_cfg(). That
works because the platform-info init is now decoupled from EAL init
(patch 32), but it makes the test order-sensitive in a non-obvious way.
A one-line comment explaining that rte_eal_get_platform_info() is
callable pre-init would help future readers.

Info: rte_eal_cfg_is_service_lcore() returns false for NULL cfg - but a
caller cannot distinguish "you passed NULL" from "lcore is not a service
core". Returning false is fine here, but mention it in the doc.


Patch 43/44 (eal_cfg: support device and driver lists)
------------------------------------------------------

Warning: cfg_add_devopt() does TAILQ_INSERT_TAIL on the user-supplied
cfg's list. That list is a struct eal_devopt_list, but its head was
initialised either by EAL_USER_CFG_INITIALIZER (when created via
rte_eal_cfg_create()) or by zero-fill (if the caller embedded one). The
latter case will crash on insert. The function should either require
EAL_USER_CFG_INITIALIZER-initialised handles only (which
rte_eal_cfg_create() guarantees) or assert the head is initialised. A
short comment is enough.

Warning: rte_eal_cfg_add_plugin() accepts any non-empty path string and
silently truncates via strlcpy(p->name, path, sizeof(p->name)) if longer
than PATH_MAX. Either reject >= PATH_MAX, or document the truncation.

Warning: subtest_eal_cfg_init_null_pmd_vdevs is gated on #ifdef
RTE_NET_NULL. The #ifdef is around the entire test body but not the
"return TEST_SUCCESS;", so when RTE_NET_NULL is undefined the subtest
unconditionally returns TEST_SUCCESS without doing anything - and without
printing a "skipping" message. Add a printf("  Skipping: RTE_NET_NULL
not built\n"); for parity with the other skip paths in this file.


Patch 44/44 (eal_cfg: add APIs for configuring remaining init)
--------------------------------------------------------------

Warning: rte_eal_cfg_set_vfio_vf_token() accepts any 16 bytes without
parsing/validation. The parser side (eal_parse_vfio_vf_token) rejects
malformed UUIDs. Programmatic API is more permissive than CLI here, which
is OK by design, but the doc comment should say so explicitly.

Warning: rte_eal_cfg_set_trace_dir() does not check that the directory
exists or is writable - it only rejects NULL/empty. The CLI path also
doesn't (it defers to trace init), so this is consistent. Worth a doc
note that errors are deferred to rte_eal_init_from_cfg().

Warning: rte_eal_cfg_set_trace_bufsz(cfg, 0) is documented as "0 means
use the default" and the test verifies that. But
rte_eal_cfg_get_trace_bufsz(NULL) also returns 0. So a caller who reads
back 0 cannot tell "I have a NULL handle" from "I asked for default".
Same readability point as is_service_lcore above - an explicit
EAL_CFG_GETTER(uint64_t, trace_bufsz, 0) is fine, but document the
ambiguity.


Series-wide notes
-----------------

Several patches change behaviour subtly without saying so in the commit
log (patches 11, 14, 22). DPDK reviewers are picky about behavioural
changes hiding in "refactor" patches; please call them out.

The new EAL_USER_CFG_INITIALIZER macro is a compound literal in
initializer position. With strict pedantic compilers (-Wpedantic) you may
see warnings about C99 compound literals being used in static contexts.
The macro is only ever used in non-static contexts in this series, so
this is fine, but worth a comment so a future user doesn't try to use it
for a file-scope "static struct eal_user_cfg foo = EAL_USER_CFG_INITIALIZER(foo);".

lib/eal_cfg/eal_cfg.c includes <linux/magic.h> directly. Older glibc /
musl may not ship that header for non-Linux containers; consider using
the upstream DPDK pattern of "#define HUGETLBFS_MAGIC 0x958458f6" if
missing.

The series has no MAINTAINERS update for lib/eal_cfg/ and no
release_notes entry. Both will be required before merge.

The new public header lib/eal_cfg/rte_eal_cfg.h uses __rte_experimental
on every function. Good. But the enum rte_eal_huge_unlink is also new,
and enums cannot be marked experimental in DPDK's libabigail config. Add
this enum to devtools/libabigail.abignore if you intend to grow it (e.g.
add RTE_EAL_HUGE_UNLINK_AUTO later).

Several patches add new headers and don't update lib/eal/version.map.
With RTE_EXPORT_* macros that's expected - but I want to confirm the
export-extraction tooling picks up the macro form when used inside an
EAL_CFG_GETTER / EAL_CFG_BOOL macro expansion. The gen-version-map.py
extractor I last looked at parses textually and may not see
"RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eal_cfg_get_no_pci, 26.07)" followed
on the next physical line by "EAL_CFG_BOOL(no_pci)". Worth a
build-and-nm check that all the expected symbols actually appear in the
resulting .so.

Doxygen: the new "/** @name */" ... "/** @} */" groupings in
rte_eal_cfg.h will only render as groups if the file is in
doxy-api.conf.in and the @name blocks are paired with closing @} on
every group. I count one group ("Per-lcore CPU affinity configuration")
with two "/** @} */" closes for one open. Likely a stray @}.

Many of the test files use C99 designated initialisers and mid-block
declarations heavily; that is consistent with current DPDK style, just
noting it for older toolchains.


Net assessment
--------------

The structural split is sound and worth landing; the eal_cfg API design
is reasonable. The blockers I would call out for v2 are the numa_mem
summing gap (patch 22) for the eal_cfg path, the lazy-init failure
cleanup leak (patch 32), the realloc(0) UB (patch 15), and the non-EAL
thread NUMA-id semantics change (patch 11). Most of the rest is
doc/comment/style polish that can ride along in v2.

No Reviewed-by - there are real correctness issues to address first.
