Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804231061B1E
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Mar 2026 20:39:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93101402D8;
	Mon, 30 Mar 2026 22:39:43 +0200 (CEST)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178]) by mails.dpdk.org (Postfix) with ESMTP id D32C9402CE
 for <dev@dpdk.org>; Mon, 30 Mar 2026 22:39:41 +0200 (CEST)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-2c17d152c01so3752597eec.0
 for <dev@dpdk.org>; Mon, 30 Mar 2026 13:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774903181;
 x=1775507981; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S11oDMZzIKXP+0mWwP4PlwX0XK3OEPZqoNY/NZvZTjU=;
 b=qGuoIpGUsXGa0P8lbRiJjsF+esjxaqMCNWwOQsnHda2Z9skPdD2eYGVOj9PEvh3B7x
 qOBny4H2bxLKLcvNrRWpdd+hXYKaBZzv31XmRd/UmjSxvHs+aPGJ7h27SWN4l/LSz+lB
 n0oiU47nxBP9KvOxKJo1yEfPpp8ygxCgUxN4pFjDJjY4erIIBLT24OLTixHNHiP6QPoZ
 yNmJni/n5v8IRr0WfEHFYZ64SKHnJlL/JRZgSzYprpVBaNIyyc7A4QHR/Ys2ILeIDX76
 Tz7wxCX9LuEgF3XFNhekdD9EOniWd1TaMBu/yf+7x8QzXfAE2515RiplE1VJKKi7uV4p
 /KxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774903181; x=1775507981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S11oDMZzIKXP+0mWwP4PlwX0XK3OEPZqoNY/NZvZTjU=;
 b=Ewgy9xsYETlDQHRFh6ItmlLeqYN2ueJdcwjXWeS1XgmzxCM4nuD6/Jy8/W+5LRxwrj
 NI6C3G2av15x6+r6gmk/1VegFkE+yL7/hK1gCnRC9FOHUwD/FlNio+HE0EqzhdG4bwhI
 L2VOuFZMaSQ/2bPrUsxeawd6QLJc4+EQSilIWmOzR2Fc69kB+A1wKNwD9t7Wx+1BU5PX
 mzaOCuvvG/g3XcVug+cqC9LIS2PJksLX5TTCPRVm7Lu1yPCMea5Q0ZtqN24lee/4zLK0
 F28PKJWkyufe9eXA6zWgtBUAk6XNRfiYwkR1MHBRh1iNJ3KYm+OwSmlTrQI+fFKgvaiN
 l1jA==
X-Gm-Message-State: AOJu0Yy5nTA22SrdUB6GzN9ndgYkWgG8nq4ygKcc6WEn6Sq9tgau3pMy
 vf9b17oNolq5Kf21GQcA8RDaiEQQe6p5nGE3YTLvCt0w5b7vQpBNqfdnqqCgQ6Vla25t1SatymG
 mcxy3
X-Gm-Gg: ATEYQzzGTz7KEJHi8T0a5YpA/QHdE8TyDflahTOZrSNO9SYnU3kk5ie3/kKozNr1XNe
 uYjBbZAgY6kdHwPgwKg5H+o/AFefPL4OCC/eHML9lyYtna/WQvSsYvfoP66768NHtR3Pz/O0z1R
 vh78KzGEJLKDgPjg5xXhT+sDqoLSgu5ElGIY2bzFgRNkuOXLvamHaY4WPrz1sQ6FLfdMVEao24U
 2F0AujI6RgMEiaE+voI5qRUis5hg6ew6SqCUaF2u7ee+h0ocYvdSGvwwAIdG/B05aKD3aNubY67
 rgI7YQHUfHisNrBe5P1+RvnfaMWb9bIvlXodxq6qESo7B1oI+eFISOHT0HAziyuL8Wblz+44naT
 HgRULduljTgJ9eWP/38TEaZh/cQ6SXbVxyTjpbOVoT0Smwq4LqGeNe7X/yh1UecNKNN4JEikxOT
 H5BRyx9QXvwGQXlsNg3WKRunMPAi3fd19B1b0=
X-Received: by 2002:a05:7301:6782:b0:2c6:7f49:a86d with SMTP id
 5a478bee46e88-2c67f49bf39mr2806712eec.15.1774903180781; 
 Mon, 30 Mar 2026 13:39:40 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c3c68b249fsm7983273eec.19.2026.03.30.13.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 13:39:40 -0700 (PDT)
Date: Mon, 30 Mar 2026 13:39:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] eal: add worker threads cleanup in rte_eal_cleanup()
Message-ID: <20260330133938.2c0b6b8f@phoenix.local>
In-Reply-To: <20250110064717.1372216-1-g.singh@nxp.com>
References: <20250110064717.1372216-1-g.singh@nxp.com>
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

On Fri, 10 Jan 2025 12:17:17 +0530
Gagandeep Singh <g.singh@nxp.com> wrote:

> This patch introduces a worker thread cleanup function in the EAL library,
> ensuring proper termination of created pthreads and invocation of
> registered pthread destructors.
> This guarantees the correct cleanup of thread-specific resources,
> used by drivers or applications.
> 
> Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
> ---

This seems to have not gotten review it needs. The AI review process found several issues.

Review: [PATCH] eal: add worker threads cleanup in rte_eal_cleanup()

Patch 1/1 - eal: add worker threads cleanup in rte_eal_cleanup()

Error: pthread_join called unconditionally after pthread_cancel failure.
If pthread_cancel() fails (returns non-zero), the thread was not
cancelled. Calling pthread_join() on a still-running worker thread
that is blocked in read() on its pipe will block the cleanup
indefinitely -- the worker is waiting for a command that will never
come, and join will wait for the worker that will never exit.
The join should be skipped when cancel fails, or the cancel failure
should be treated as fatal for that lcore.

  Suggested fix:
    ret = pthread_cancel((pthread_t)lcore_config[lcore_id].thread_id.opaque_id);
    if (ret != 0) {
        EAL_LOG(WARNING, "Pthread cancel fails for lcore %d",
                lcore_id);
        continue;   /* skip join -- thread is still running */
    }
    ret = pthread_join(...);

Error: Cleanup ordering -- worker threads cancelled after eal_bus_cleanup().
The patch inserts eal_worker_thread_cleanup() after eal_bus_cleanup().
Bus cleanup may trigger device close/release callbacks. If a worker
lcore is currently executing a function dispatched via
rte_eal_remote_launch() that touches bus/device resources, cancelling
the thread after those resources are torn down risks use-after-free.
Worker threads should be terminated first, before any subsystem
teardown, to ensure no worker is mid-execution when resources are
freed. Move eal_worker_thread_cleanup() to the beginning of
rte_eal_cleanup(), after the run_once guard but before
rte_service_finalize() / eal_bus_cleanup().

Warning: Uses raw pthread_cancel()/pthread_join() instead of DPDK thread API.
AGENTS.md forbidden tokens list requires rte_thread_join() instead
of pthread_join(). The existing mp_channel_cleanup code uses the
same pattern (pthread_cancel + rte_thread_join), so at minimum
the join should use rte_thread_join() for consistency:

    rte_thread_join(lcore_config[lcore_id].thread_id, NULL);

There is no rte_thread_cancel() wrapper, so pthread_cancel() is
acceptable here (same as rte_mp_channel_cleanup does).

Warning: No pipe fd cleanup after thread cancellation.
Each worker has pipe_main2worker and pipe_worker2main fds created
during rte_eal_init(). After cancelling and joining the worker
threads, these pipe fds are never closed. This leaks 2 pipe fds
(4 file descriptors) per worker lcore. The cleanup function should
close these fds after the join succeeds.

Warning: Comparing opaque_id against zero to detect uninitialized threads.
The check `if (!lcore_config[lcore_id].thread_id.opaque_id)` assumes
that zero means "no thread was created." On Linux, pthread_t is an
unsigned long and a valid thread ID could theoretically be 0 (though
glibc never produces this). A more robust approach is to track which
lcores had threads successfully created, or check the lcore state.
The existing mp_channel code uses a similar opaque_id != 0 guard,
so this is minor -- mentioning for completeness.

Info: The commit message says "pthreads" and "pthread destructors" but
does not explain *which* thread-specific resources motivate this
change. A concrete example (e.g., a specific driver TLS destructor
that leaks without this) would strengthen the justification.

