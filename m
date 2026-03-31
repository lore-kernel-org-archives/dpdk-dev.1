Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA931061B21
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 03:46:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0656F40285;
	Tue, 31 Mar 2026 05:46:23 +0200 (CEST)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mails.dpdk.org (Postfix) with ESMTP id D63C74025E
 for <dev@dpdk.org>; Tue, 31 Mar 2026 05:46:21 +0200 (CEST)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-82c68339cf0so3307654b3a.0
 for <dev@dpdk.org>; Mon, 30 Mar 2026 20:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774928781;
 x=1775533581; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7B9GdebMRSx3eyZle6TTSeTn2ZiuoGvnSK20q993L9w=;
 b=i+b9EAlvlT8ojfbnkV40fPNLd104l2VuzWedEw5GxxkCX4Nlr3+1qXjSPNljcJGG1w
 R+REm7oB1WOFdSc/HfMgmpqOnFJToFUfiJpOn9jodvS7JcIPWQdivSHIJGSlNuwe1bL+
 fq6NeopDjavq6RnOqO/0ONherzEFSW4GoLcPzW7V6TEyoczyxSU9Em/ssI3RhLGhuGLC
 OSYR4N207LA0nBYQv8jp45kg6k49u/ly/eNCbPGNjzs8g4zu7tXrey/tW3A80vdAGy1O
 5zop2crUP0eygN95MuxMbeAIMIvgJUE/mAdR5VFd13iTJE0nR36SV718o23mv1iJkzgY
 Jc+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774928781; x=1775533581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7B9GdebMRSx3eyZle6TTSeTn2ZiuoGvnSK20q993L9w=;
 b=dTdapfZ0vJ0u6Z2AXvO3Oi2r3/HvtCEFbVNp6jETs79RX0SqGAx8toRp6tnxiA3NxR
 hyANFj6iO3vw0VbrkvxURoigxZCWhkGK7ekpF9unT7llbg8/pXwnXqp9naLlXP8wqHrT
 drGIVSNOqOXVchYO/6LRskh96l87+duRdnGQjV1HMeOdg4t3VgklLe+5ZE5c/CGIW1BA
 2WiQY35j/jyimZpgPgapqRoqHL6esfOICmqw6i+iCoGEi+aUHgumVx2Gqf07aOuONawP
 WfY1d9ff6kcChauLl2ug2//26RaNRXzs8ESLdxCfvWBHzy7O2WHyY0S1ffgF4REl4Tll
 4ZTg==
X-Gm-Message-State: AOJu0YwIrwpQt5qyznW9vAyuW7Avfq7gKuH+b/G98WbUalal7pUnkUil
 I+wy1QtQ6CbbW4aZU0hHz5rXXgL0r0H5Xk6w6PwnfrJJpcrvL8GCGqHPAAjRkjWhAIQ=
X-Gm-Gg: ATEYQzzb2PR7KZBFayjEIr8xGLPvsgeCjCLQlrBHBy4BXsuVBbkw2FsWpPPLPZUee0W
 p+Rd3OVnjs+g+0bGEFajbbIu2Q2f1NtkMA5rXVkr+IcQCKjbG6rYrfsQBP7KrRW82F8MkL6S1DS
 mVftzPSiCKdgMQPVKTLwz5bDwSHTpY/Nd7KUhfjiOPNPqDzF7c9FNNMtUYcGUd5VehA0rYSmR+V
 BdZ40zMbmGoohndv/vzXKgSRRZJb6fC3st+X3U+tndnJ1hF4pqPjTARDS403DtPI0zg7CBI0KuU
 mnkWlhLZxm1KoFMHr1HUDXrV7KSXppAtJfcSR4BtnHo3M8Cq+FD5U7g49ymcE/FGs+X7Y63WmkL
 2+CEQhVsAb0hT3KN0c9uf/7lVxuLxZbZP/VZQ2PeHV9yRuu2M0SC7FS+nWVPHMgrBXq217Nifvn
 DYspQTsPoamGHTmy+jThoMB1Ztc1LqTn5vp8A=
X-Received: by 2002:a05:6a00:3906:b0:827:32dd:59c5 with SMTP id
 d2e1a72fcca58-82cd6652d45mr1775397b3a.28.1774928780705; 
 Mon, 30 Mar 2026 20:46:20 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82ca8436f19sm8734608b3a.9.2026.03.30.20.46.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 20:46:20 -0700 (PDT)
Date: Mon, 30 Mar 2026 20:46:12 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ankur Dwivedi <adwivedi@marvell.com>
Cc: <dev@dpdk.org>, <thomas@monjalon.net>, <jerinj@marvell.com>
Subject: Re: [PATCH v6 0/2] devtools: add tracepoint check in checkpatch
Message-ID: <20260330204612.710ff20b@phoenix.local>
In-Reply-To: <20231215064355.1429709-1-adwivedi@marvell.com>
References: <20230307120514.2774917-1-adwivedi@marvell.com>
 <20231215064355.1429709-1-adwivedi@marvell.com>
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

On Fri, 15 Dec 2023 12:13:53 +0530
Ankur Dwivedi <adwivedi@marvell.com> wrote:

> This patch series adds a validation in checkpatch tool to check if
> tracepoint is present in any new function added in ethdev, eventdev
> cryptodev and mempool library.
> 
> v6:
>  - The build_map_changes function is moved from check-symbol-change.sh to
>    a new symbol-map-util.sh file. This function can be used in other
>    scripts by including symbol-map-util.sh file.
> 
> v5:
>  - Copied the build_map_changes function from check-symbol-change.sh to
>    check-tracepoint.sh.
>  - Added eventdev, cryptodev and mempool in libdir in check-tracepoint.sh.
>  
> v4:
>  - Rebased on the recent next-net branch.
>  - Refined logic to find function definition.
>  - Updated year in the license in devtools/check-tracepoint.sh.
>  - Removed cryptodev, added ethdev in libdir in
>    devtools/check-tracepoint.sh. 
> 
> v3:
>  - Split the v2 patch into 2 patches.
>  - The file common-func.sh is renamed to build-symbol-map.sh.
>  - Removed check-tracepoint.py file.
>  - Code improvements in check-tracepoint.sh.
> 
> v2:
>  - Add check for parent directory.
> 
> Ankur Dwivedi (2):
>   devtools: move build map changes function
>   devtools: add tracepoint check in checkpatch
> 
>  devtools/check-symbol-change.sh |  76 +---------------
>  devtools/check-tracepoint.sh    | 148 ++++++++++++++++++++++++++++++++
>  devtools/checkpatches.sh        |   9 ++
>  devtools/symbol-map-util.sh     |  78 +++++++++++++++++
>  devtools/trace-skiplist.txt     |   0
>  5 files changed, 237 insertions(+), 74 deletions(-)
>  create mode 100755 devtools/check-tracepoint.sh
>  create mode 100644 devtools/symbol-map-util.sh
>  create mode 100644 devtools/trace-skiplist.txt
> 

This patch seems to have not been updated since build system changes around symbols.
AI spotted this an other issues. If interested change and resubmit.

Review of [PATCH v6 1/2] devtools: move build map changes function
         [PATCH v6 2/2] devtools: add tracepoint check in checkpatch

NOTE: This patch series (v6, Dec 2023) is based on the old
version.map / check-symbol-change.sh infrastructure. Upstream has
since replaced check-symbol-change.sh with check-symbol-change.py
and moved to auto-generated symbol maps via RTE_EXPORT_* macros.
The build_map_changes() shell function parses version.map diffs,
but version.map files are no longer manually edited. This means
the entire detection mechanism will never trigger on current DPDK
patches. The approach needs to be redesigned around RTE_EXPORT_*
annotations rather than version.map changes.

Patch 1/2 - devtools: move build map changes function
------------------------------------------------------
No issues. The function is moved verbatim and the sourcing
mechanism is correct.

Patch 2/2 - devtools: add tracepoint check in checkpatch
---------------------------------------------------------

Error:

1. find_trace_fn silently passes when the function body is absent
   from the patch. If a symbol is added to version.map but the
   function definition is in a different patch or already in the
   tree, the awk script never matches the function name, never
   reaches "exit 1", and falls through with exit status 0. The
   check reports "tracepoint present" when it was never examined.
   The awk should exit with a distinct status (e.g., 2) when the
   function body is not found, and the caller should handle that
   case (skip or warn).

Warning:

2. find_trace_fn does not filter on diff line prefixes. The awk
   matches the function name on any line in the patch -- context
   lines (space prefix), added lines (+), and removed lines (-).
   If a function is being deleted, its body will still match on
   the "-" lines, and the script could incorrectly conclude that
   the tracepoint is present (from the old removed code). The
   match on the function name and the _trace_ search should both
   be restricted to "+" lines to avoid false results.

3. Trap is registered before the function it references is
   defined. The line "trap clean_and_exit_on_sig EXIT" appears
   before clean_and_exit_on_sig() is defined. While POSIX sh
   allows this (the name is resolved when the trap fires, not
   when registered), it is fragile and confusing. Move the trap
   registration after the function definition.

4. Double cleanup on normal exit. The normal code path does
   "rm -f $mapfile" then "exit $exit_code". The exit triggers the
   EXIT trap, which runs clean_and_exit_on_sig() calling rm again
   (harmless) and exit again. This works but is unnecessarily
   convoluted. Either remove the explicit rm/exit at the bottom
   and let the trap handle it, or remove the trap and rely on the
   explicit cleanup.

5. Shell variables not quoted. Multiple instances of unquoted
   variables that could break on paths with spaces:
     selfdir=$(dirname $(readlink -f $0))
     . $selfdir/symbol-map-util.sh
     find_trace_fn $patch $symname
     for sym in $(cat $skiplist); do
   These should use double quotes:
     selfdir=$(dirname "$(readlink -f "$0")")
     . "$selfdir/symbol-map-util.sh"
     find_trace_fn "$patch" "$symname"
   The same quoting issue exists in patch 1/2 as well. Admittedly
   the existing DPDK scripts have similar quoting habits, but new
   code should set a better example.

Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
