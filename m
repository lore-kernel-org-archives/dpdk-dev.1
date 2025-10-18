Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAC1CCD199
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 17:41:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11DAA42794;
	Fri, 17 Oct 2025 19:41:52 +0200 (CEST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id 7F215400D7
 for <dev@dpdk.org>; Fri, 17 Oct 2025 19:41:50 +0200 (CEST)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-88ed6837e2eso465999185a.1
 for <dev@dpdk.org>; Fri, 17 Oct 2025 10:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760722909;
 x=1761327709; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NDfq8BnzFfNWXk+wiG9hp1azFiSSMy1HcbJq4Qx78TQ=;
 b=xPePo4cTTxstP4gOXuk742csSKC5rNVlg126Gss9/MgPOR8ny+xkQb7e6An/IrjmG5
 u20nIomlMoBNygPgERzYSELIAERvbRWqIoXF4pVZuxjhuwz01FHSS6KwK1Wq1e48/YhK
 4DfIozGfAB3mZ0Adqzwdx2w0W7NtDRZtrpp/LrSO+q91zJIxu2f1aTotsaFOjAY55nh2
 OUcksgd5m0WCmpn8/XrfKroLOKf7r2XA+8wSyDGP1mooyK5CEbGj3v+4Q9Tev3Siqabq
 l1jHPDyWtrds0XKHVq/zEWQDeAsKCpgNKf2Ph1GvHAGDc55JPs4u+pp0HRNgRkrpYZ1e
 jZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760722909; x=1761327709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NDfq8BnzFfNWXk+wiG9hp1azFiSSMy1HcbJq4Qx78TQ=;
 b=sd7HeyG0vJ/95XKVGIOS5K4Qboq+Oz5hiX84LVRyYgq5e7gnfHvvZyTelvMZPkdJ5r
 jswvIUA2SxgAsC1tKD0J062+e0KSaAfZmndT6JsW0AJGryN07/y+UOrFHBvU9brSFGzf
 uGXV9obGUIobfW5jlKGd2YnStTgYSZrrMhlaXPU4trQt29ScUN2VqJPQBtXCTS/t+f2W
 6wFO5QHbEfFpUbGCwQo6thELLQUZDmH1fryti0BCQEuTwtxCnJjjKX02Brlw8b6fpIb/
 8uTofhW38P+LUEYOfwIUgdpltYlM7uFyuaTEfyPWyzW1qLerwtPbZAI6wKQtvRyaJvE2
 jayA==
X-Gm-Message-State: AOJu0YztaNqN17hDRK28p9YFyPtKZt25or4Y1S6oIHH+XFB3nbXcyzYh
 e/u3gsaNmFZTp9xQIQlBpckFcveuxt3HS6y7S5ZCyjbL6VG7R9/un1FJh7k0bPDsclgj1OKLZ3k
 /teIoodw=
X-Gm-Gg: ASbGncv3sS2qVxMIFaRTFuYAc5vq+cAFWNQvwXg0y0NAqQb01wVgrMBPAn68fgcnEl3
 DVLeXQBJijNEchghSTa57ApLRYy1uKAxhLeyfWNBrZFxD0lWLOyooGNZyeanIgIrkF6Q4QuNRZb
 jPZKnxryAKmEq+V8jK45qoi+ESbikXqCzYNBreHb+cKYH7MlW/L+D6OGlm6IpGP2HJqFYw7+WAl
 n0ObMYVEbCMrPevSe+ht3HkmPF6kZhsuCK/m75FIXqi5i1DwZ5sJRHJoDm4n8dFV5fuT10S4gcc
 69bBuHbA+eurynRjHIxjEsert6t1OpuAMhUHUh1B1idWK30PYI9SDysHqpI+8ihNETwiTGQSqlH
 ApBa7ygwOCajmsHsnwKCJlMQrzoWoeCtbVPGPvFLpLnU7Y2R/4tyjACamUhl/4M8Ppr/36q0W4k
 j2adb+zaSvnELeUyAFSKKtE9UwFpQWxWT5MJN2Feg=
X-Google-Smtp-Source: AGHT+IEl9+P0kCqbWhhxnMip0F5OGjBvS7Q6xC71iJ/N8yGxrHQeld2KRpJNeS7R5WCiGJ8ycYk25w==
X-Received: by 2002:a05:6a20:a103:b0:334:8002:7403 with SMTP id
 adf61e73a8af0-334a863810cmr5759262637.43.1760722474126; 
 Fri, 17 Oct 2025 10:34:34 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6a7664a228sm337131a12.4.2025.10.17.10.34.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 10:34:33 -0700 (PDT)
Date: Fri, 17 Oct 2025 18:13:49 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, david.marchand@redhat.com
Subject: Re: [PATCH v10 00/21] Simplify running with high-numbered CPUs
Message-ID: <20251017181349.27f6c394@phoenix.lan>
In-Reply-To: <20251008204244.2288583-1-bruce.richardson@intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20251008204244.2288583-1-bruce.richardson@intel.com>
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

On Wed,  8 Oct 2025 21:42:23 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> The ultimate of this patchset is to make it easier to run on systems
> with large numbers of cores, by simplifying the process of using core
> numbers >RTE_MAX_LCORE. The new EAL arg ``-remap-lcore-ids``, also
> shortened to ``-R``, is added to DPDK to support this.
> 
> However, in order to add this new flag easily, the first dozen or more
> patches rework the argument handling in EAL to simplify things, using
> the argparse library for argument handling.
> 
> When processing cmdline arguments in DPDK, we always do so with very
> little context. So, for example, when processing the "-l" flag, we have
> no idea whether there will be later a --proc-type=secondary flag. We
> have all sorts of post-arg-processing checks in place to try and catch
> these scenarios.
> 
> To improve this situation, this patchset tries to simplify the handling
> of argument processing, by explicitly doing an initial pass to collate
> all arguments into a structure. Thereafter, the actual arg parsing is
> done in a fixed order, meaning that e.g. when processing the
> --main-lcore flag, we have already processed the service core flags. We
> also can far quicker and easier check for conflicting options, since
> they can all be checked for NULL/non-NULL in the arg structure
> immediately after the struct has been populated.
> 
> An additional benefit of this work is that the argument parsing for EAL
> is much more centralised into common options and the options list file.
> This single list with ifdefs makes it clear to the viewer what options
> are common across OS's, vs what are unix-only or linux-only.
> 
> Once the cleanup and rework is done, adding the new options for
> remapping cores becomes a lot simpler, since we can very easily check
> for scenarios like multi-process and handle those appropriately.
> 
> 
> V10:
> * add patch 2 to fix func_reentrancy test bug reported mid-way through
>   the series.
> * added patches 7 & 8 to resolve arg parsing compat issues:
>    - support reordering args to have non-flag parameters at the end so
>      we can e.g. mix autotest names in with EAL args
>    - support having optional params with single-letter args without
>      having to use "=" syntax, i.e. -l4 rather than -l=4
> * fixed issues with the final patch when the autodetected range of cores
>   was >RTE_MAX_LCORE
> 
> V9: rebase to latest main. CI complains cannot apply v8 patches.
> 
> V8:
> * dropped the final two patches from the series, dropping the new -L
>   option in favour of the -R modifier.
> * reordered patch 11 to be with the other argparse patches (now patch 5)
> * added patch 12, which uses macros to initialize the args structure
>   from the arguments header file, avoiding potential issues when we add
>   new args.
> * simplified and consolidated lcore mask and core list parsing to always
>   work off cpusets rather than arrays of uint8
> * enhanced debug printouts to also work better with cpusets and handle
>   core values in those sets >= RTE_MAX_LCORE
> * for completeness, ensure the new -R option works for coremasks, and
>   for cases where no explicit core-list or coremask is specified.
> 
> V7:
> * expand the scope of the patchset beyond just cleanup to add in the
>   extra 3 patches for -L and --lcoreid-base option.
> 
> V6:
> * Rebase to apply cleanly on latest main
> 
> V5:
> * Resubmit of V4, which didn't get sent correctly, or picked up correctly
>   in patchwork.
> 
> V4:
> * Updated patch 5 to auto-generate the arg struct definition from the same
>   list of defines used to construct the argument list.
> 
> V3:
> * Added 3 new initial patches, one for minor build-system addition, and two
>   for functionality in argparse to allow the user-callback help function to
>   be maintained as we move to argparse.
> * Added doc updates in the first EAL patch adding the long options
> * Fixed ASAN issues by adding a patch to properly clean up EAL init - both
>   memory allocations and fixing the run-once flag
> * Put ifdefs around the linux-only or unix-only options in EAL patch 2
> * Updated args to handle numa-mem and numa-limit as equivalent socket-mem
>   and socket-limit
> 
> Bruce Richardson (21):
>   build: add define for the OS environment name
>   test/func_reentrancy: fix args to EAL init call
>   argparse: export function to print help text for object
>   argparse: allow user-override of help printing
>   argparse: add documentation on supported value types
>   argparse: add support for parsing core lists
>   argparse: allow optional flag reordering
>   argparse: support parameters to short options without "="
>   eal: add long options for each short option
>   eal: define the EAL parameters in argparse format
>   eal: gather EAL args before processing
>   eal: ensure proper cleanup on EAL init failure
>   eal: combine parameter validation checks
>   eal: simplify handling of conflicting cmdline options
>   eal: automatically init arg list options
>   eal: add internal fn for converting cpuset to string
>   eal: use common cpuset to string function
>   eal: introduce lcore remapping option for coremasks
>   eal: rework internal coremask parsing to use cpu sets
>   eal: allow lcore ID remapping with core lists
>   eal: allow lcore remapping with autodetected core affinity
> 
>  app/test/test_argparse.c                   |  695 ++++++++++
>  app/test/test_func_reentrancy.c            |    5 +-
>  config/meson.build                         |    1 +
>  doc/guides/contributing/design.rst         |    2 +-
>  doc/guides/linux_gsg/eal_args.include.rst  |   42 +-
>  doc/guides/prog_guide/argparse_lib.rst     |  138 +-
>  doc/guides/rel_notes/release_25_11.rst     |   18 +
>  drivers/event/dlb2/dlb2_priv.h             |    2 +-
>  drivers/event/dlb2/pf/base/dlb2_resource.c |   11 +-
>  lib/argparse/rte_argparse.c                |  181 ++-
>  lib/argparse/rte_argparse.h                |   29 +-
>  lib/eal/common/eal_common_lcore.c          |   13 +-
>  lib/eal/common/eal_common_memory.c         |    3 +-
>  lib/eal/common/eal_common_options.c        | 1439 +++++++++++---------
>  lib/eal/common/eal_common_thread.c         |   43 +-
>  lib/eal/common/eal_option_list.h           |   98 ++
>  lib/eal/common/eal_options.h               |  104 +-
>  lib/eal/common/eal_private.h               |   21 +
>  lib/eal/common/eal_thread.h                |   13 +-
>  lib/eal/freebsd/eal.c                      |  245 +---
>  lib/eal/include/rte_eal.h                  |   20 -
>  lib/eal/linux/eal.c                        |  470 +------
>  lib/eal/linux/eal_memory.c                 |    2 +-
>  lib/eal/meson.build                        |    2 +-
>  lib/eal/windows/eal.c                      |  156 +--
>  lib/meson.build                            |    1 +
>  26 files changed, 2148 insertions(+), 1606 deletions(-)
>  create mode 100644 lib/eal/common/eal_option_list.h
> 
> --
> 2.48.1
> 

There is one other thing about eal_init. The arguments in argv can not be const
right now, since there are cases where args are modified. Could we fix that.
Code like dpdk-dumpcap has to strdup() the args.
