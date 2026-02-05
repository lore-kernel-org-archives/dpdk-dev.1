Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2FEEC1E92
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 10:58:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68B2940684;
	Thu,  5 Feb 2026 11:58:17 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 834ED4026D
 for <dev@dpdk.org>; Thu,  5 Feb 2026 11:58:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770289094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JWCtqscI6y7tscykxy9odeDWJQ5pV7qBAlFUqIUMPZQ=;
 b=EpFuHQrq9EXbX+uogHEPcwODyDw5LC8f2C8CQG9tsTwcMjcb5QawcLOrSBzKvB9+sjR3Hd
 IsOdyvYBVbyBrH8vULtEYEixOm7+xctJZzDU/3jSYoD2sQ6Ks9TOMNTKqgpg7k7crRE3o8
 ODFtaAAwNyDAdoqs3/xt/TpIX/96stY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-RidEBWTsPoWhr2D5Zl-TnA-1; Thu, 05 Feb 2026 05:58:13 -0500
X-MC-Unique: RidEBWTsPoWhr2D5Zl-TnA-1
X-Mimecast-MFC-AGG-ID: RidEBWTsPoWhr2D5Zl-TnA_1770289092
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-385d4c511e4so3801441fa.1
 for <dev@dpdk.org>; Thu, 05 Feb 2026 02:58:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770289092; x=1770893892;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JWCtqscI6y7tscykxy9odeDWJQ5pV7qBAlFUqIUMPZQ=;
 b=KcG99rfEPUCaneFOY7MAuyv4VWs9jzSBvLzTqJtcHNlKjDnB9vZ2QLa00jLN4CtgUz
 /5X924PO2IBc1upl8cmtgr4wpc6W6wL8M3IThXlHxx9YKCAgp+NP9oFmbZpnfk61TLdg
 q3gy0xtylKkV5BDJibs8aCiIh0lwgnrvFITbF8FCk1tTarZgvkPmHi+FvylBeJW3ejK2
 TV7sbmruV+LrSVTcLNz5dnV53zejan76qCK86theWDsmcpx7g3bEVj3MiBSLXSqxScmz
 khnWPWC2nDkQRI3sqSf6HZSv8Mxqsu0EAK8Gub2/OQ+vrPG84kcS8lXA1ZFW0k+/qAFB
 yk5Q==
X-Gm-Message-State: AOJu0YwCQ2CswIQsPM4ZMlORJe8OUCBPCAey7s1vm0s/5aE/c9cnPLLg
 /rVPKCCQMz42vkMkOHtZ/brw6VjAw8ur9rWO8iJNtZ61mdL3ocipkx/QH4S10DhcoeszuzXXDQp
 cTXVVEJwOkFF+LSV6RZAnQNOojrW78RMzjxNCIG5Z+4dcn2AShVfS5EYS1JwJU5pJIwyhnEI9Qa
 YyKSlEj5GQSaArIky2N3RZVEeCxJw=
X-Gm-Gg: AZuq6aKE7F7W/bYpkeeE7wErEA67F2bP0Vvpcpa9cTaF6i0PKMpNEvAR4ZEqbcDQn8+
 yE8oqqPek+cvWmU/V9sM8Fjuf/ULbDB92d2LBW64Cuv63fr6SdUQloAqKrEFrftM5fsC0KAL91f
 fPZq7cpIBSnZX7kusp9oh3/iTHsUwlHdH0eyNLZg7zYCTVGBwCJvZ+NUJQ5GXkGtN10ypkwG3Tl
 4x/Q0yvE/Mcnn0BtHi+2ux4WefsviloHS4c2YvosKf0mwcHEdCgfMB5tw==
X-Received: by 2002:a2e:bc0f:0:b0:37a:2d23:9e78 with SMTP id
 38308e7fff4ca-38691cad37emr25220661fa.11.1770289092053; 
 Thu, 05 Feb 2026 02:58:12 -0800 (PST)
X-Received: by 2002:a2e:bc0f:0:b0:37a:2d23:9e78 with SMTP id
 38308e7fff4ca-38691cad37emr25220551fa.11.1770289091514; Thu, 05 Feb 2026
 02:58:11 -0800 (PST)
MIME-Version: 1.0
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260129014313.939831-1-stephen@networkplumber.org>
In-Reply-To: <20260129014313.939831-1-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 5 Feb 2026 11:57:59 +0100
X-Gm-Features: AZwV_QhvVXSyGjLwPLiN3BztkwUvO7yUsufzMoDsNuF8_hCj5Ow6ZEKJt00RWvw
Message-ID: <CAJFAV8zYj78DroSMO2uW63O08BNz=Z2ZED1zebferki2aGSWvQ@mail.gmail.com>
Subject: Re: [PATCH v14 00/17] lib: improve string overflow safety
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: thfaAnhf1Kr3tKiAThrSrxuRk8tis8tnoMiTm5j7XVY_1770289092
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

Hello,

On Thu, 29 Jan 2026 at 02:43, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> This series improves defensive programming by adding proper string length
> validation and overflow checking throughout DPDK libraries. The goal is
> to eliminate silent truncation of names and paths, provide meaningful
> error feedback, and enable compiler format overflow warnings.
>
> Motivation
> ----------
> Many DPDK APIs accept name parameters with defined maximum lengths
> (e.g., RTE_LPM_NAMESIZE, RTE_HASH_NAMESIZE). Previously, names exceeding
> these limits were silently truncated via snprintf/strlcpy, potentially
> causing subtle bugs like duplicate names or unexpected behavior. This
> series addresses these issues systematically.
>
> Changes Overview
> ----------------
> The patches fall into several categories:
>
> 1. API input validation (patches 1-2, 6, 12, 16):
>    - Add explicit length checks for name parameters in lpm, hash, efd,
>      tailq, and cfgfile APIs
>    - Return ENAMETOOLONG when names exceed limits
>    - Document new error conditions in API headers
>    - Add corresponding unit tests
>
> 2. Internal buffer overflow detection (patches 3-5, 8-9, 14-15):
>    - Check snprintf/strlcpy return values for truncation
>    - Log warnings when internal string operations truncate
>    - Increase buffer sizes where they were too small
>    - Use dynamic allocation (asprintf) where appropriate
>
> 3. Path handling improvements (patches 7, 10-11, 13):
>    - Use standard C library routines (getmntent) for parsing /proc/mounts
>    - Enforce UNIX_PATH_MAX for socket paths to fail early
>    - Handle arbitrarily long shared library paths
>
> 4. Error message improvements (patches 1-2, 6):
>    - Include rte_strerror() in failure messages
>    - Provide more context when operations fail
>
> 5. Enable compiler warnings (patch 17):
>    - Remove -Wno-format-truncation flag
>    - All preceding patches fix the warnings this would trigger
>
> API Changes
> -----------
> The following APIs now return ENAMETOOLONG for oversized names:
>   - rte_lpm_create()
>   - rte_hash_create()
>   - rte_fbk_hash_create()
>   - rte_efd_create()
>   - rte_eal_tailq_create()
>   - rte_cfgfile_add_section()
>   - rte_cfgfile_add_entry()
>
> These are documented in the release notes and header files.
>
> Testing
> -------
> - Existing unit tests pass
> - New test cases added for hash name length validation
> - Build tested with format overflow warnings enabled
>
>
> v14 - fix build on 32 bit Ubuntu
>     - reword commit messages for clarity
>
> v13 - fix and cleanup get_hugefile code
>       optimize using statfs() and no string handling needed.
>       reword commit messages
>
>
> Stephen Hemminger (17):
>   lpm: reject names that exceed maximum length
>   hash: reject names that exceed maximum length
>   graph: avoid overflowing comment buffer
>   latencystats: add check for string overflow
>   telemetry: check for path overflow
>   efd: handle possible name truncation
>   eal: use C library to parse filesystem table
>   eal: warn if thread name is truncated
>   eal: avoid format overflow when handling addresses
>   eal: limit maximum runtime directory and socket paths
>   eal: check for hugefile path overflow
>   eal: check tailq length
>   eal: handle long shared library path
>   ethdev: avoid possible overflow in xstat names
>   vhost: check for overflow in xstat name
>   cfgfile: add length checks and increase line buffer
>   lib: enable format overflow warnings
>
>  app/test/test_hash.c                   |  21 ++++
>  doc/guides/rel_notes/release_26_03.rst |  13 +++
>  lib/cfgfile/rte_cfgfile.c              |  42 ++++++--
>  lib/cfgfile/rte_cfgfile.h              |   6 +-
>  lib/eal/common/eal_common_config.c     |   6 +-
>  lib/eal/common/eal_common_memory.c     |   3 +-
>  lib/eal/common/eal_common_options.c    |  17 ++-
>  lib/eal/common/eal_common_proc.c       |  85 +++++++++------
>  lib/eal/common/eal_common_tailqs.c     |  13 ++-
>  lib/eal/common/eal_filesystem.h        |  27 ++++-
>  lib/eal/freebsd/eal.c                  |   6 +-
>  lib/eal/linux/eal.c                    |   6 +-
>  lib/eal/linux/eal_hugepage_info.c      | 138 ++++++++++---------------
>  lib/eal/linux/eal_memalloc.c           |  11 +-
>  lib/eal/linux/eal_memory.c             |   9 +-
>  lib/eal/windows/eal.c                  |   6 +-
>  lib/efd/rte_efd.c                      |  18 +++-
>  lib/ethdev/rte_ethdev.c                |  35 +++++--
>  lib/graph/graph_pcap.c                 |   9 +-
>  lib/hash/rte_cuckoo_hash.c             |  41 +++++---
>  lib/hash/rte_fbk_hash.c                |  12 ++-
>  lib/hash/rte_fbk_hash.h                |   1 +
>  lib/latencystats/rte_latencystats.c    |   9 +-
>  lib/lpm/rte_lpm.c                      |  17 ++-
>  lib/lpm/rte_lpm.h                      |   1 +
>  lib/meson.build                        |   4 -
>  lib/telemetry/telemetry_legacy.c       |   7 +-
>  lib/vhost/vhost.c                      |  14 ++-
>  28 files changed, 377 insertions(+), 200 deletions(-)

Series applied, thanks.


-- 
David Marchand

