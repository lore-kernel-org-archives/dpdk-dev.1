Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3AEEA794C
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 01:17:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCAF04028E;
	Thu,  5 Feb 2026 02:17:26 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 9059840264
 for <dev@dpdk.org>; Thu,  5 Feb 2026 02:17:25 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4806fbc6bf3so3992655e9.2
 for <dev@dpdk.org>; Wed, 04 Feb 2026 17:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770254245;
 x=1770859045; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lfaIRd831Z1XR3QSCvN2QGIAdlOEDYiuKy5/TZDzid0=;
 b=VoQovDwrPk1BP8tes4t5cUSyQXTaCm90bqsxCjE8Bz+EXiZAFKZwGNW6Qht5yXbRoi
 lFUT6y95mOwwg2bUsJQBxdIRm8BOD9/mHnZEZWZh3y8LDBCuIFmrfVHqjhg/NPeIatGU
 Q1EdscMgWALCrf9uRig5UnD90esf/G0uVkQ1bxOVeWO6Br7gZp3bKh+zmMS0FqUgUASt
 dXmPxuxImcaOj8uY/eObWTnM25tTA78uY+QP46uxd3HikukSNTdCwUNHM5oT1nL5J3Av
 Ygz/6KF2eAYAuugl7Q+PdFORZpG08GSeRgFoYSpnaXs27jfqAH9gy+02LuIkQOCe+a+R
 pNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770254245; x=1770859045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lfaIRd831Z1XR3QSCvN2QGIAdlOEDYiuKy5/TZDzid0=;
 b=tBqLTBHB85xx89rqXesDYyK1dSliPFKY3/JPgMdMWP+ouf9ixYiXdzc5JA05JH0o0t
 BrfDsL4MTnOrC9umcQ47TmeAKVybv9zZNDuTYELhyQ0fZ/dsaiwsppJymU8p8iE7bGqU
 qr0M/l6ZtYLpSfpl32NglzEw0MXro/2YFuKbcAPFz1iv8D0Wj1N27lXGWSd/jCBlFukI
 dDwaOqlw6qBRskeTOhCgbXxYO1oQw6pjuFVg8rMQmqJn3XR3wjg5KQpKCvj82WWY8VbC
 wui8f2UDqhm0MLxb8RXotLQyfPB1GPwK73VZ71srW5vnp3f5oWq8GwxgVHY1pbLHFQkz
 5NXg==
X-Gm-Message-State: AOJu0Yz5A1nqmMtN1bwjIA4RteqUaBu5qX9glYWgrnY79/s/XszmLhvS
 7a0UNUQyeewJXO5awN6qPS1OX0iZeX/G5A0RWgcG925NFyEe2DkCp1DWwbelxYijuv4=
X-Gm-Gg: AZuq6aL5WgzAEW+tyBJSZxDVuFDaNj8/VdSZCFs9k5iULelWASVHRwyqOKgHVS/mYn5
 OyNH1ns/1bUoVxkv/mlGLNeIyRytpZEN2UGpp8ZauGX4akH1CccW6jLFYXv2Kb90pbw18fSc70C
 vCoH4UQbwfTPfmursETVwrZMU+Bfar5zw5zS9MPSnDp2CknbB4zilgFbxiC9BaboxbM6ppSsyeU
 UqoPkCiZPeggerCDnJqVO6jl5aXHstaxldUFerOjzgKr3YfZXzFz56mACo3Wf7/iU7quheRXrKD
 G4DUpOQWwoM3Fcdbc92MWi721WsQLUeuRkCUruT8k1fwc65VAXBrqRPKFzUihjBd1kuibgrqwID
 pEuS72i3yba5k6fH21+nXyfqpdOH3RYBg+7va4CnqsrNJ78iczzBFVzoWD+Uq0DCW12vnDuec3P
 szppOZG+YKnB/jVedD8MLS2YuUlmtuswMiSKsDjDjPIecUHF274Pla
X-Received: by 2002:a05:600c:3e0d:b0:46e:59bd:f7d3 with SMTP id
 5b1f17b1804b1-4830e96fb0cmr53131755e9.20.1770254244880; 
 Wed, 04 Feb 2026 17:17:24 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d835f0sm19120875e9.14.2026.02.04.17.17.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 17:17:24 -0800 (PST)
Date: Wed, 4 Feb 2026 17:17:19 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Yehor Malikov <malikovyehor@gmail.com>
Cc: dev@dpdk.org, maxime.coquelin@redhat.com, chenbox@nvidia.com, Yehor
 Malikov <Yehor.Malikov@solidigm.com>
Subject: Re: [PATCH v6] vhost: fix use-after-free in fdset during shutdown
Message-ID: <20260204171719.347924a1@phoenix.local>
In-Reply-To: <20260204230502.24983-1-malikovyehor@gmail.com>
References: <20260204220037.23760-1-malikovyehor@gmail.com>
 <20260204230502.24983-1-malikovyehor@gmail.com>
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

On Thu,  5 Feb 2026 00:05:02 +0100
Yehor Malikov <malikovyehor@gmail.com> wrote:

> From: Yehor Malikov <Yehor.Malikov@solidigm.com>
> 
> The fdset_event_dispatch thread runs in a loop checking the destroy
> flag after each epoll_wait iteration. During process exit,
> rte_eal_cleanup() frees hugepages memory while the fdset thread is
> still running, causing use-after-free when accessing the fdset
> structure.
> 
> Add fdset_deinit() function to stop the dispatch thread by setting
> the destroy flag and waiting for thread completion. Resource cleanup
> (epoll fd, fdsets array, memory) is intentionally skipped since the
> function is only called during process exit when the OS will reclaim
> all resources anyway, avoiding potential deadlocks from mutex
> operations in destructor context.
> 
> Use symmetric RTE_FINI destructors for both vhost-user and VDUSE fdsets
> to ensure proper cleanup before EAL teardown.
> 
> Fixes: e68a6feaa3b3 ("vhost: improve fdset initialization")
> 
> Signed-off-by: Yehor Malikov <Yehor.Malikov@solidigm.com>


I understand why this is important but not sure if it will work as
you expect. I asked AI to help give a better explanation (so don't trust it
to be right).

Good question. Yes, there are potential concerns:

**RTE_FINI ordering is undefined.** There's no guarantee about the order destructors run relative to each other or to EAL cleanup. The commit message says the goal is to stop the fdset thread "before EAL teardown" but `RTE_FINI` doesn't actually guarantee that - it just registers an `__attribute__((destructor))` function.

**Possible scenarios:**

1. **EAL cleanup runs first** - If `rte_eal_cleanup()` frees hugepages before the `RTE_FINI` destructor runs, we're back to the original bug. The destructor would then call `fdset_deinit()` on already-freed memory.

2. **Destructor runs during active vhost operations** - If the application is still doing vhost work when exit starts, the destructor could stop the dispatch thread while callbacks are expected to run. The `busy` flag helps with `fdset_del()` synchronization, but abrupt thread termination during shutdown could leave things inconsistent.

3. **Fork concerns** - After `fork()`, the child has the same destructor registered but the dispatch thread doesn't exist in the child (threads aren't inherited). `rte_thread_join()` on an invalid/non-existent thread ID could behave unexpectedly.

**What would be more robust:**

The proper fix would be to integrate with EAL cleanup directly - register a callback via `rte_eal_cleanup_register()` (if that exists) or have vhost explicitly clean up its fdsets in a documented shutdown sequence before `rte_eal_cleanup()` is called, rather than relying on destructor ordering.

Worth raising with the author: has this been tested with different linking scenarios (static vs dynamic) and confirmed the destructor actually runs before EAL teardown in practice?
