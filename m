Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3466BC531C9
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Jul 2026 23:30:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57E7F40279;
	Tue, 28 Jul 2026 01:30:13 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id 53CB1400EF
 for <dev@dpdk.org>; Tue, 28 Jul 2026 01:30:12 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2cc891373e0so33924145ad.2
 for <dev@dpdk.org>; Mon, 27 Jul 2026 16:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785195011;
 x=1785799811; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oNPBxOe+3gwjz1R1ofMOPS1i/fvaSS+YMkSlM2NkLjo=;
 b=T/fFmpO42Bend8ACVfKCGnBu1iFaSOxXALmj7yRJOxy/UDYW2dkMynDK77lLR2z8wr
 npvYW8X+slQQibB8hdudBD6cySHcBO8N2ttQGXwMwAz7MofMz3vG2GfH2P1YGtjBwI8R
 1Ra4pH8QST2Zh43tuKsUeAt5jrj+LtJjkEYIdsZ+tCOz2EerCwJ+aI5uQ5cEHngiCImL
 v30BFawJLNlyfOrUtykwilNMRnhfL3hTSyGBMkTzjX6zkEqIy/k5eddTvFwL5AVCL26G
 sDSb4c5vSnIRzdbhhTxfdrtTNBw2Qh188g4ltO8o1oYsExqLEjJDfyYC7fqccO6rqw+Y
 TEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785195011; x=1785799811;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oNPBxOe+3gwjz1R1ofMOPS1i/fvaSS+YMkSlM2NkLjo=;
 b=FoXadUhkCRole8auyu5Jms3vr8de333MKKgZkoFGysAOzEAi4zstpYClUjyHFs5gZ8
 HEUbB1+ljI9eImqEnJTA4N7MW3HPW6VrroyvPz0BUoE5IEECxxQSTbQvozwUQSGY0V6j
 2tUJQo62r1ImdjXeLfAmVFMJYfYTUoNzPwkgYpgduVHzk6b2wEaWBGQhey8KFH0Y597r
 ixr/KnLKg9Fhm8u129bRFYaqs0Qd4FBqS6u8i3yjFuHcOnf4mdgSSDoicRVZT1qNMcpy
 NHf/iL7ro4G3FXIdk/CUIRH/xa2gKozLDD5F0haywqI80FBhQe3aiMzQFOl6c4tzQ4bY
 WS1w==
X-Gm-Message-State: AOJu0YxSpgccvG7VaW3BIUQNHOrb2l41qnH1k+6M68d4qnFNW0FbDvsl
 gTqBvsgqygrZRVPsBDkY2KdI+vBiCeSzl8/PBd+8RORjT2flQ18D2uhxK5OtWBgt9Qs=
X-Gm-Gg: AR+sD1237iXzNkTBNX4DTJ2roZ0uSKmIhLcDkgB7+2wPovQgQwZcNt5qexO5LUJB/sI
 eBNTNOwjkFqdNi/gfbX1q17FRHQP/lAdx3VW6op6MFf9ySr0Io6NL7oPTUUq9Qk0JMEZCTlzGx5
 fe8ZQFK/AW3Fv8U6c6xkayL61ruXTGU99uNoWmAzVqZIZm04SmUEUyoq6VrKpLrS4kOPPSSowwv
 t8g4tNmtGzmHlBhIbOEEe98DuhAJfK4AGz+oCadla7h8JxcdOg8OAtLdvSgnP7P3vTbOQcL7R9e
 rMYMdW2x0ueldp5DT3A4oKf3ulX0i6paNamXOkZaWbTRtzaqE8p7Nrdmu60mtTv55zkd1hK8/VV
 EBxCTzrvyDeLIpk/zDzGlk+Jc99UGOXPdy0y+3gli3PfQ5wCcbfa1hkO5Li5piH2TDzFn1HNIdT
 bohCJUmlnKwI60NQgYn04oiCQmF7jyYLrG7IDlgMXM034=
X-Received: by 2002:a05:6a21:48f:b0:3c3:ad17:edf7 with SMTP id
 adf61e73a8af0-3c8ba600088mr2803637.63.1785195011048; 
 Mon, 27 Jul 2026 16:30:11 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc5c53f3sm33394283eec.30.2026.07.27.16.30.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 16:30:10 -0700 (PDT)
Date: Mon, 27 Jul 2026 16:30:07 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 00/39] Rework EAL configuration
Message-ID: <20260727163007.60e4a2dc@phoenix.local>
In-Reply-To: <20260721094555.2188496-1-bruce.richardson@intel.com>
References: <20260429165845.2136843-1-bruce.richardson@intel.com>
 <20260721094555.2188496-1-bruce.richardson@intel.com>
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

On Tue, 21 Jul 2026 10:45:08 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> This patchset reworks how configuration is stored and managed in EAL.
> The existing "internal_config", "rte_config", "lcore_config" structures,
> which sometimes have arbitrary separation between them (especially the
> first two) are replaced by three new structures with clearly defined
> roles:
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
> Once that is done, we have a clean separation between user provided
> configuration and the rest of EAL, we can split EAL init into two parts,
> the first of which parses cmdline arguments and then calls the second
> which takes the eal_user_cfg struct result of that parse and does the
> actual initialization. The longer-term objective is to have other
> first-stage functions that prepare the user_cfg struct for
> initialization, so that we can move away from argc/argv as the only
> method of configuring DPDK initialization.
> 
> Bruce Richardson (39):
>   telemetry: make cpuset init parameter const
>   argparse: check for range overflow in CPU lists
>   eal: define new functionally distinct config structs
>   eal: move memory request fields to user config
>   eal: move NUMA request fields to user config
>   eal: move hugepage policy fields to user config
>   eal: move process policy fields to user config
>   eal: move hugepage limit fields to new config structs
>   eal: move advanced user config options to user cfg struct
>   eal: move hugepage size info to platform info struct
>   eal: move runtime state to appropriate structure
>   eal: record details of all cpus in platform info
>   eal: use platform info for lcore lookups
>   eal: add macro for lowest set CPU bit in a set
>   eal: store lcore configuration in runtime data
>   eal: move core indices bitset to runtime state
>   eal: cleanup CPU init function
>   eal: move NUMA node information to platform info struct
>   eal: move lcore role and count to runtime state
>   eal: make lcore role a field in lcore config struct
>   eal: move main lcore setting to runtime config struct
>   eal: move IOVA mode and process type to runtime cfg
>   eal: move memory config pointer to runtime state struct
>   eal: remove rte_config structure
>   eal: separate runtime state update from arg parsing
>   eal: move device options staging list into user cfg
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
> 
>  app/test/process.h                        |   4 +-
>  app/test/test_argparse.c                  |  10 +
>  doc/guides/linux_gsg/eal_args.include.rst |  38 +-
>  lib/argparse/rte_argparse.c               |   5 +
>  lib/eal/common/eal_common_bus.c           |   4 +-
>  lib/eal/common/eal_common_config.c        | 264 ++++++-
>  lib/eal/common/eal_common_dev.c           |  10 +-
>  lib/eal/common/eal_common_dynmem.c        |  70 +-
>  lib/eal/common/eal_common_fbarray.c       |  10 +-
>  lib/eal/common/eal_common_launch.c        |  25 +-
>  lib/eal/common/eal_common_lcore.c         | 267 ++++---
>  lib/eal/common/eal_common_mcfg.c          |  44 +-
>  lib/eal/common/eal_common_memalloc.c      |   5 +-
>  lib/eal/common/eal_common_memory.c        | 104 ++-
>  lib/eal/common/eal_common_memzone.c       |  24 +-
>  lib/eal/common/eal_common_options.c       | 899 ++++++++--------------
>  lib/eal/common/eal_common_proc.c          |  43 +-
>  lib/eal/common/eal_common_tailqs.c        |   6 +-
>  lib/eal/common/eal_common_thread.c        |  67 +-
>  lib/eal/common/eal_common_timer.c         |   2 +-
>  lib/eal/common/eal_common_trace.c         |  30 +-
>  lib/eal/common/eal_common_trace_utils.c   | 104 ---
>  lib/eal/common/eal_hugepages.h            |   8 +
>  lib/eal/common/eal_internal_cfg.h         | 386 ++++++++--
>  lib/eal/common/eal_memcfg.h               |   3 +
>  lib/eal/common/eal_option_list.h          |   6 +-
>  lib/eal/common/eal_options.h              |   8 +-
>  lib/eal/common/eal_private.h              | 121 ++-
>  lib/eal/common/eal_trace.h                |  11 -
>  lib/eal/common/malloc_elem.c              |  15 +-
>  lib/eal/common/malloc_heap.c              |  41 +-
>  lib/eal/common/malloc_mp.c                |   2 +-
>  lib/eal/common/rte_malloc.c               |  14 +-
>  lib/eal/common/rte_service.c              |  17 +-
>  lib/eal/freebsd/eal.c                     | 287 ++++---
>  lib/eal/freebsd/eal_hugepage_info.c       |  78 +-
>  lib/eal/freebsd/eal_lcore.c               |  16 +-
>  lib/eal/freebsd/eal_memory.c              |  46 +-
>  lib/eal/freebsd/include/rte_os.h          |   2 +
>  lib/eal/include/rte_eal.h                 |  35 +-
>  lib/eal/include/rte_memzone.h             |  10 +-
>  lib/eal/include/rte_tailq.h               |   2 +-
>  lib/eal/linux/eal.c                       | 296 ++++---
>  lib/eal/linux/eal_hugepage_info.c         | 231 +++---
>  lib/eal/linux/eal_lcore.c                 |  43 ++
>  lib/eal/linux/eal_memalloc.c              | 168 ++--
>  lib/eal/linux/eal_memory.c                | 168 ++--
>  lib/eal/linux/eal_timer_hpet.c            |  21 +-
>  lib/eal/linux/eal_vfio.c                  |  11 +-
>  lib/eal/linux/include/rte_os.h            |  10 +
>  lib/eal/unix/eal_unix_thread.c            |  11 +-
>  lib/eal/windows/eal.c                     | 193 +++--
>  lib/eal/windows/eal_hugepages.c           |  60 +-
>  lib/eal/windows/eal_lcore.c               |   6 +
>  lib/eal/windows/eal_memalloc.c            |  37 +-
>  lib/eal/windows/eal_memory.c              |  14 +-
>  lib/eal/windows/eal_thread.c              |  11 +-
>  lib/eal/windows/eal_windows.h             |   8 -
>  lib/eal/windows/include/rte_os.h          |   1 +
>  lib/eal/windows/include/sched.h           |  10 +
>  lib/telemetry/telemetry.c                 |   4 +-
>  lib/telemetry/telemetry_internal.h        |   2 +-
>  62 files changed, 2499 insertions(+), 1949 deletions(-)
> 
> --
> 2.53.0
> 

Ran deeper AI review on this and it found a couple small things:

Review of "eal: rework EAL initialization" (39 patches)

Series applies cleanly to main (9231dc7). All 39 commits build individually
with -Dwerror=true, so bisect is safe. Findings verified against the merged
tree rather than the diffs alone.


Patch 02/39 - argparse: check for range overflow in CPU lists

Warning: missing Fixes: and Cc: stable.

This is an out-of-bounds write, not a cleanup - CPU_SET(min, cpuset) with
min >= CPU_SETSIZE writes past the end of rte_cpuset_t. The introducing
commit is in v25.11, so it needs backporting:

  Fixes: d78103fb9488 ("argparse: support core lists")
  Cc: stable@dpdk.org

The fix itself is correct and complete: all three branches assign max before
the new check, min >= 0 is guaranteed by the isdigit() gate, and min <= max
holds in every branch, so the CPU_SET loop is fully bounded.


Patch 33/39 - eal: remove internal config reset function

Error: removing eal_reset_internal_config() drops the lock_descriptor = -1
preset, which can lead to close(0) on stdin. Linux only.

The deleted function did:

    for (i = 0; i < MAX_HUGEPAGE_SIZES; i++) {
        memset(&internal_cfg->hugepage_info[i], 0, ...);
        internal_cfg->hugepage_info[i].lock_descriptor = -1;
    }

That -1 was the invariant eal_hugedirs_unlock() relied on. hugepage_info[]
now lives in eal_runtime_state, which is a static initialised only with
.mem_config, so every lock_descriptor starts at 0 - a valid fd.

This patch compensates by widening the guard:

    if (hugepage_info[i].hugepage_sz == 0 ||
            hugepage_info[i].lock_descriptor < 0)
        continue;

but hugepage_sz == 0 is not a sufficient proxy. In hugepage_info_init()
(lib/eal/linux/eal_hugepage_info.c) hpi->hugepage_sz is assigned *before*
the mountpoint check, and the no-mountpoint path continues without ever
assigning lock_descriptor:

    hpi = &rs->hugepage_info[num_sizes];
    hpi->hugepage_sz = hps->size;          /* set first */

    if (get_hugepage_dir(...) < 0) {
        if (user_cfg->in_memory) {
            calc_num_pages(hpi, hps, 0);
            num_sizes++;                   /* entry accepted */
        }
        continue;                          /* lock_descriptor never set */
    }

    hpi->lock_descriptor = open(hpi->hugedir, O_RDONLY);

Two reachable cases:

  (a) --in-memory with a reserved-but-unmounted size (e.g. 1G reserved,
      only 2M mounted). The entry is accepted with hugepage_sz != 0 and
      lock_descriptor == 0.

  (b) Default mode where the *last* size has no mountpoint. num_sizes is
      not incremented, so slot [num_sizes] keeps a nonzero hugepage_sz with
      lock_descriptor == 0. eal_hugedirs_unlock() iterates to
      MAX_HUGEPAGE_SIZES, not num_hugepage_sizes, so it still visits it.

In both, the guard passes and the code runs flock(0, LOCK_UN) followed by
close(0) on the normal init path (lib/eal/linux/eal.c:831, unconditional
after rte_eal_memory_init()). Confirmed with a standalone harness
reproducing the two functions' control flow.

FreeBSD is unaffected (single entry, fd assigned unconditionally, no
unlock loop); Windows sets -1 explicitly in eal_hugepages.c.

Simplest fix is to restore the invariant rather than widen the guard - set
lock_descriptor = -1 for all MAX_HUGEPAGE_SIZES entries when runtime state
is set up, or initialise the entry immediately after hugepage_sz is
assigned in hugepage_info_init(). Bounding the unlock loop by
num_hugepage_sizes would fix (b) but not (a).

The other non-zero defaults from the deleted function are all preserved
correctly: hugepage_file.unlink_existing, no_hpet, and
max_simd_bitwidth.bitwidth are in EAL_USER_CFG_INITIALIZER, and
RTE_IOVA_DC / RTE_INTR_MODE_NONE / RTE_PROC_PRIMARY are all genuinely 0.
lock_descriptor is the only one lost.


Patch 29/39 - eal: move trace config into user config struct

Warning: --trace-dir accumulate semantics changed, plus a leak on repeat.

The old path went through trace_dir_update(), which concatenated onto any
existing value:

    asprintf(&dir, "%s%s", trace->dir != NULL ? trace->dir : "", str);

The new code does a plain asprintf into user_cfg->trace_dir. Passing
--trace-dir more than once now replaces rather than appends, and the
earlier allocation leaks since trace_dir is overwritten without a free.
If the replace behaviour is intended, worth saying so in the commit
message; otherwise free the previous value first.


Patch 39/39 - eal: provide hooks for init with externally supplied config

Error: rte_eal_runtime_init() returns -1 without setting rte_errno on the
platform-info path. Identical in all three platform copies:

    if (rte_eal_get_platform_info() == NULL) {
        rte_eal_init_alert("Platform information is not available.");
        return -1;              /* rte_errno not set */
    }

The other two error paths in the same function set EINVAL and EALREADY,
and the equivalent path in rte_eal_init() sets ENOTSUP. A caller checking
rte_errno gets a stale value. Suggest rte_errno = ENOTSUP to match.

Warning: the stated purpose is not reachable as posted.

The commit message says the hooks let "other libraries init EAL by passing
in that structure pre-configured", but struct eal_user_cfg and both new
prototypes live in lib/eal/common/eal_internal_cfg.h. lib/meson.build:143
only adds eal/common to the include path when RTE_LIB_EAL is not yet set,
i.e. for EAL's own sub-build; afterwards dependent libraries get
deps += ['eal'], which exposes only EAL's public include dirs. No in-tree
library can declare the type or call the function without the explicit
include_directories() hack used by drivers/common/mlx5/linux/meson.build.
Either make the header reachable or note that a follow-up is required.

Warning: both new __rte_internal symbols have no in-tree consumer and no
test, so the deep-copy path in eal_user_cfg_copy() is never exercised by
anything. A test driving rte_eal_runtime_init() with a hand-populated
config would be worth adding alongside.

Info: eal_internal_cfg.h uses #include "rte_compat.h" while every other
public RTE header in the same file uses angle brackets.


Checked and found correct

Recording these so they are not re-reviewed:

- eal_user_cfg_copy() deep copy is sound. device_option uses a flexible
  char arg[], so calloc(1, sizeof(*copy) + arglen) is right;
  eal_plugin_path uses a fixed char name[PATH_MAX], so malloc(sizeof(*p))
  plus memcpy(..., sizeof(name)) is right. Both lists, trace patterns, all
  four heap strings and the per-lcore cpusets are deep-copied, so cleaning
  up both user_cfg_from_args and the global config is not a double free.
  The error path calls eal_user_cfg_cleanup(dst), which is idempotent, so
  the later eal_cleanup_config() in eal_runtime_init()'s err_out is safe.

- EAL_USER_CFG_INITIALIZER(self): the self-referencing
  TAILQ_HEAD_INITIALIZER((self).devopt_list) is legal - the object's scope
  begins after its declarator, and tqh_last correctly points at the final
  object rather than the compound-literal temporary.

- rte_eal_get_platform_info() double-checked locking has correct
  acquire/release pairing under a spinlock.

- rte_eal_cpu_init() error paths all free and NULL both cpu_info and
  numa_nodes, so the caller's fail label cannot double-free. No leak on the
  numa_node_count > RTE_MAX_NUMA_NODES path.

- eal_expand_cpuset_to_map() and the --lcores parser both NULL entries as
  they free, so the later eal_user_cfg_cleanup() is safe.

- Every added malloc/calloc/strdup/asprintf checks its return.
  sprintf(pattern, "%s*", ...) into calloc(1, len + 2) is exactly sized.

- No public ABI change; the only new exports are two
  RTE_EXPORT_INTERNAL_SYMBOLs and no version.map is hand-edited.
