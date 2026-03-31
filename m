Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D2410F9302
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 22:30:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DF2940275;
	Wed,  1 Apr 2026 00:30:06 +0200 (CEST)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id 99D0C4026F
 for <dev@dpdk.org>; Wed,  1 Apr 2026 00:30:04 +0200 (CEST)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-2b6b0500e06so8407663eec.1
 for <dev@dpdk.org>; Tue, 31 Mar 2026 15:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774996204;
 x=1775601004; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xoj2AjxOcRS/tCbINw6Wec95sQvLODYLG4w92WY/et8=;
 b=LJxM43Cyd5pEBeDXJ7HFxvSib+YQT3GERmYICfnAuaGujvFV5heUPpBV/oTKhO9OLa
 NnUp4TCoMR3/+7XIjeZUOYxCwKnVhdJ1u6ZAL2qARNZkOH/aNefGWmgsiUcELdKK5a6U
 vqhibdzw1ue0Gz+u3QIIzricXpkemsVa0JhyC4QLmdL7/oXHoFp3DWQaGGrlLypw6eu7
 1pLBoiw8Nu/wufPxK30D+SeyBDWhfIcu3nL5Lb9DSfr2cl4xbvmIKmLtYpDVH8ZB9fid
 WhnJm4PnnVGU2TmkBRCGx5bg7/iesMj0eAUaC8XwrnhPObrvJfVX/DriT3XKpoxR7V+g
 CGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774996204; x=1775601004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xoj2AjxOcRS/tCbINw6Wec95sQvLODYLG4w92WY/et8=;
 b=nQuAS8X3eAe6YMElNNw1QEouk7yYZ9+Oc8XF22WQArD1LBbgJFmIWs8uFcAAs1sjaf
 CiDW0Qk5DdgfV2y0RHV3gdpGcs1tkVJM2gs71sRIWIQETGBTr1PO53E6JNPowUZU0M2i
 AZVXU9MN3NvH5PPUAti6akcrt/8FqTZT8ClzhjfbYkVq+XVA6Ew63jFZiue8YMbJLsO7
 paGyaSQDtplgmaGImYikdhoihoM/grShJZ9xPkNdr9DuO5MOEV6NvHj45YqSXdgzFjgW
 KJneyOsLFEVbOxoujlVmr69LFz3EmoeyKjEQ8iRXNXpu0EpSx/edfxdWmdtVDWUNnrJh
 LqJQ==
X-Gm-Message-State: AOJu0Yzku4jpdj4qWlWD3CBnkBs/q+y2wnOXyW5zdXjYxwwqNybBRGjQ
 3KdDYofXIDkTky/uIP0JfVmxY2n5K7oBbjDxodJAJU1QtHmnPDi0jzbuKWXQ5yhBQf1ZnIHZXlZ
 1dgkL
X-Gm-Gg: ATEYQzyU5iBhjNieYWEoOZY9Y0sf8hvq4MkAGNmzQbD7yGWdYgZUMpCKN/o6od7FlUg
 /ZyeBYWZYh9SobX2w9z/g2P6lOJQhLPIeY6Ohy7fvHIQWF1OykUrOQIYPda5o67HhgQpgsy5Ivb
 bS67P3Cjm+OOIqaQsaYARass4zB8d7W1CZGtPxxpUGZ5b7kKq0EJDGEdS1JnZWc+s/UVX7J6eDh
 cqOqdec39ykO2VIcMuR9fWfF1BXw6wJnzwWoGwtfYDWKbxBPBYqbR+EgTfKlS5c8B32U5owTK4J
 /0dTQ/pEBzUz4926wM1cszCKVjY0IAO/U6oPJUqud2/eUjevLAEkYTBpmSWfZCcYUslJFVxe1TI
 UFBKOtKvQ/4RJUApXRcona0ipWfO8zFT1ZCKrWW0rZKWowpt5knVKWBrhaJwZYsKtSLekXllfVm
 JZOZW7ra6J1VszT7tqoarpVeyysHH1SfQJcjJGcxJiqBmY1Q==
X-Received: by 2002:a05:7301:1015:b0:2c5:b23e:48a2 with SMTP id
 5a478bee46e88-2c93098c26amr681090eec.8.1774996203501; 
 Tue, 31 Mar 2026 15:30:03 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c89135747csm2930030eec.12.2026.03.31.15.30.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 15:30:03 -0700 (PDT)
Date: Tue, 31 Mar 2026 15:30:00 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maxime Leroy <maxime@leroys.fr>
Cc: dev@dpdk.org, vladimir.medvedkin@intel.com, rjarry@redhat.com
Subject: Re: [RFC 0/5] fib: shared and resizable tbl8 pool
Message-ID: <20260331153000.18442689@phoenix.local>
In-Reply-To: <20260331214117.142495-1-maxime@leroys.fr>
References: <20260331214117.142495-1-maxime@leroys.fr>
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

On Tue, 31 Mar 2026 23:41:12 +0200
Maxime Leroy <maxime@leroys.fr> wrote:

> This RFC proposes an optional shared tbl8 pool for FIB/FIB6,
> to address the difficulty of sizing num_tbl8 upfront.
> 
> In practice, tbl8 usage depends on prefix distribution and
> evolves over time. In multi-VRF environments, some VRFs are
> elephants (full table, thousands of tbl8 groups) while others
> consume very little (mostly /24 or shorter). Per-FIB sizing
> forces each instance to provision for its worst case, leading
> to significant memory waste.
> 
> A shared pool solves this: all FIBs draw from the same tbl8
> memory, so elephant VRFs use what they need while light VRFs
> cost almost nothing. The sharing granularity is flexible: one pool per
> VRF, per address family, a global pool, or no sharing at all.
> 
> This series adds:
> 
>   - A shared tbl8 pool, replacing per-backend allocation
>     (bitmap in dir24_8, stack in trie) with a common
>     refcounted O(1) stack allocator.
>   - An optional resizable mode (grow via alloc + copy + QSBR
>     synchronize), removing the need to guess peak usage at
>     creation time.
>   - A stats API (rte_fib_tbl8_pool_get_stats()) exposing
>     used/total/max counters.
> 
> All features are opt-in:
> 
>   - Existing per-FIB allocation remains the default.
>   - Shared pool is enabled via the tbl8_pool config field.
>   - Resize is enabled by setting max_tbl8 > 0 with QSBR.
> 
> Shrinking (reducing pool capacity after usage drops) is not
> part of this series. It would always be best-effort since
> there is no compaction: if any tbl8 group near the end of the
> pool is still in use, the pool cannot shrink. The current LIFO
> free-list makes this less likely by immediately reusing freed
> high indices, which prevents a contiguous free tail from
> forming. A different allocation strategy (e.g. a min-heap
> favoring low indices) could improve shrink opportunities, but
> is better addressed separately.
> 
> A working integration in Grout is available:
> https://github.com/DPDK/grout/pull/581 (still a draft)
> 
> Maxime Leroy (5):
>   test/fib6: zero-initialize config struct
>   fib: share tbl8 definitions between fib and fib6
>   fib: add shared tbl8 pool
>   fib: add resizable tbl8 pool
>   fib: add tbl8 pool stats API
> 
>  app/test/test_fib6.c        |  10 +-
>  lib/fib/dir24_8.c           | 234 ++++++++++---------------
>  lib/fib/dir24_8.h           |  17 +-
>  lib/fib/fib_tbl8.h          |  50 ++++++
>  lib/fib/fib_tbl8_pool.c     | 337 ++++++++++++++++++++++++++++++++++++
>  lib/fib/fib_tbl8_pool.h     | 113 ++++++++++++
>  lib/fib/meson.build         |   5 +-
>  lib/fib/rte_fib.h           |   3 +
>  lib/fib/rte_fib6.h          |   3 +
>  lib/fib/rte_fib_tbl8_pool.h | 149 ++++++++++++++++
>  lib/fib/trie.c              | 230 +++++++++---------------
>  lib/fib/trie.h              |  15 +-
>  12 files changed, 844 insertions(+), 322 deletions(-)
>  create mode 100644 lib/fib/fib_tbl8.h
>  create mode 100644 lib/fib/fib_tbl8_pool.c
>  create mode 100644 lib/fib/fib_tbl8_pool.h
>  create mode 100644 lib/fib/rte_fib_tbl8_pool.h
> 

Brief AI review
Review of [RFC 0/5] fib: shared and resizable tbl8 pool

Good series overall. The motivation for shared tbl8 pools in multi-VRF
environments is clear and the cover letter is well-written. A few
issues below, mostly in the resize path.

Patch 4/5: fib: add resizable tbl8 pool
--------------------------------------------

Error: Uses C11 <stdatomic.h> directly instead of DPDK atomic wrappers.
New DPDK code must use rte_atomic_thread_fence() with rte_memory_order_*
constants, not C11 atomic_thread_fence() with memory_order_*.

  In fib_tbl8_pool.c:
    #include <stdatomic.h>
    ...
    atomic_thread_fence(memory_order_release);

  Should be:
    #include <rte_stdatomic.h>
    ...
    rte_atomic_thread_fence(rte_memory_order_release);

Warning: The plain store to consumer tbl8 pointers during resize
(*c->tbl8_ptr = new_tbl8) and the data-plane readers' plain load of
dp->tbl8 in the lookup functions have no acquire/release annotation.
This works today because the RCU synchronize prevents use-after-free
of the old array, and both old and new arrays contain identical data
during the transition. However, the release fence before
pool->tbl8 = new_tbl8 does not cover the subsequent consumer pointer
stores. Consider using rte_atomic_store_explicit() with release
ordering on the consumer pointer stores, or at minimum adding a
comment explaining why plain stores are safe here.

Warning: rte_fib_tbl8_pool_resize() is declared in the public header
and exported, but it is also called automatically from
fib_tbl8_pool_alloc() as an internal fallback. Having an auto-resize
path that calls rte_rcu_qsbr_synchronize() means a route add can
block for an unbounded time waiting for all reader threads to go
quiescent. This should be documented prominently, or the resize
should be separated from the alloc path so the caller can control
when blocking is acceptable.

Patch 3/5: fib: add shared tbl8 pool
--------------------------------------------

Warning: The rte_fib_tbl8_pool struct and the free_list array are
allocated with rte_zmalloc_socket but are only used on the control
path. Standard calloc/malloc would avoid consuming limited hugepage
memory. The tbl8 data array is correctly allocated with
rte_zmalloc_socket since it is accessed in the data plane.

Warning: install_to_fib() in dir24_8.c has an error path that
calls fib_tbl8_pool_cleanup_and_free() to return tbl8_idx when
tmp_tbl8_idx allocation fails:

    } else if (tmp_tbl8_idx < 0) {
        fib_tbl8_pool_cleanup_and_free(dp->pool, tbl8_idx);
        return -ENOSPC;
    }

This is correct (cleans the initialized tbl8 group before returning
it), but note this is a behavior change from the previous patch in
the series where tbl8_put() was used without cleanup. The change is
an improvement but should be mentioned in the commit message since
it affects error-path semantics.

Patches 3/5, 4/5, 5/5: New public API
--------------------------------------------

Warning: Five new public API functions are added across these patches
(rte_fib_tbl8_pool_create, rte_fib_tbl8_pool_free,
rte_fib_tbl8_pool_rcu_qsbr_add, rte_fib_tbl8_pool_resize,
rte_fib_tbl8_pool_get_stats) but no tests are added. New APIs need
test coverage, at minimum exercising:
- create/free lifecycle
- shared pool between two FIB instances
- resize with RCU configured
- stats accuracy after alloc/free cycles

Warning: No release notes for the new APIs and features. These will
be needed before the series moves past RFC.

Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
