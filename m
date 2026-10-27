Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B459E606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 21:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=nBCPfU/C
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 609A740151;
	Tue, 27 Oct 2026 22:00:55 +0100 (CET)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTPS id 141D1400D7
 for <dev@dpdk.org>; Tue, 27 Oct 2026 22:00:53 +0100 (CET)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2ea138a3497so1138965ad.2
 for <dev@dpdk.org>; Tue, 27 Oct 2026 14:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793134852;
 x=1793739652; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yayDtzb4kyCAxyOtXb/kMBxOh6mnW205+LmhElPm3WM=;
 b=nBCPfU/C0a43vW71WkMTk4lggenEvlHjMvAsnis6tKmQeRzqQRDl3yV4aJl+CFit1g
 95OWkVTDfoKN7ZRTKmlQVYI3m8C3VSd0OQUaLBRVQc/bQ5A1w7+qI9wPAHrAwKFZ8hO9
 3ac0iqKwB1wGg4MCH/i9S3XMXaMirU+uqBpPhPyFJd81Eqdes4pCR4i3qCCIbltDn3ev
 OWyr/kd4f0CUG6EPYtG6K6P+Q7SgIh8Dgy3LIEGKrPBY/cJOjW0n9Oo7lyB8ZCvGg6dS
 LWbDthUYsTCXTzpuyXGRj/j0cJKmCnmnHOWCxc75NJZkouNPQOmxn2ZxJoA3lABmEoFu
 blrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793134852; x=1793739652;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yayDtzb4kyCAxyOtXb/kMBxOh6mnW205+LmhElPm3WM=;
 b=kG45hzKbCcZvknFTm4D2FYcW5LcbnsEJiIgh/Xo95lH56DEw0bI9+G555rmL5y+LCE
 z7tVR2hAvKS1Z9GNpTsdFtIptPONhmSZuHhyvMmlnwK8eFKGDFP8Ue8+xbnuJ+5elWYd
 kk1+xTeQX5lOD1D/5E7CA1WxUpVqhUbopOEim2lLdlgERUBwNPOAYVbRzJKm/YgxC9Wh
 5muuWZD++F0Ir+jl5gshhwrMTMyTDF2cDf0DJ9I8taUrQvpWyj5tm+UodBCIdsEoY1T/
 MAsyl3PnOSeCWe3wuub7iOyh5KwcIysNzlid6dJng3ro/4qjUqaQNfFgwqZ3K321EpqN
 3Cxg==
X-Gm-Message-State: AFq9FYLsEr7HX25GCYjyYIsIUzygAJK4Sjqx0k4NBfmHdR8g7DKrKCKi
 bq0n7E5EsqKa+Q7NzCEfC9A2a53SBTsbzx3Uc44YGcZjEGLNd+SfMshD+50RaXbYjE0=
X-Gm-Gg: AYBFou2PqDytGfHzvdgoAQGJTxncRb2P+Kzf9wLFmiKN9vB9gRn941O7Ru0JCdce6YV
 2xqyJf+fO7rSUauw7T0osqDRNTiI7isV57/4/Y8DojP86egc3gtDThrKGdYxbYHBRiR36LTW8Be
 XJWIbeKonrlCW8nqbO1+pZ5R9QlvkrGJISet4FwqoUePEUuAiFJCGlW5XLaad1Vx1F7Plj8+Q+4
 WUoyTMrcVU0WBEfK2ggGeLHxCMKtaODFLq/S6qz544q4QpP95OftwfCyMOr/uUPDwnMC4rHOx3k
 MeATPI+Cleicf0SB4lrZTqWwxx+6MulchiKyFGfZKXTLBibXeiBr31VrOe9JxvESYGbcSLurP8t
 dqm4flJmJ7ttmmoU2davewnaFOnoE43vGDefZtWQ/1N9vX1lBc2kZK7zip6uianXCcZM3Gxi7ce
 29/dwemlE2n3WOfOWWN/+dk5M0XqH0PCIG0/e9+zvHxFhe12rpLjgWrp8Gbpimi1pP7iZCPaxiq
 5qkuLSFJjkPmwAzumS1joK7PkbkcEn55i4NUNbfT+NK+8hWX3OxyrHOAF1gh5eGXZ/kZmL351GL
 PWN5hVrD5lqarT2rYTwlMbmiQ39kAyihBq3XoKAibD1/BVwjBkuKTqGsIMhpc+iXQLOdQO0=
X-Received: by 2002:a17:903:1cb:b0:2e9:5714:608e with SMTP id
 d9443c01a7336-2eb00487c87mr4548405ad.49.1793134852114; 
 Tue, 27 Oct 2026 14:00:52 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae6c9ea8asm14478685ad.66.2026.10.27.14.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 14:00:49 -0700 (PDT)
Date: Tue, 27 Oct 2026 14:00:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Pravin Pathak <pravinpathakdev@gmail.com>
Cc: dev@dpdk.org, jerinj@marvell.com, tirthendu.sarkar@intel.com,
 bruce.richardson@intel.com, thomas@monjalon.net, david.marchand@redhat.com,
 pravin.pathak.dev@gmail.com
Subject: Re: [PATCH v1] event/dlb2: race condition during dynamic linking
Message-ID: <20261027140042.2741b628@phoenix.local>
In-Reply-To: <20261021172041.433881-1-pravin.pathak.dev@gmail.com>
References: <20261021172041.433881-1-pravin.pathak.dev@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 21 Oct 2026 13:20:41 -0400
Pravin Pathak <pravinpathakdev@gmail.com> wrote:

> dlb2 handles dynamic linking and linking asynchronously if queues
> being linked/unlinked have traffic. It starts a thread if not already
> started to handle the process. This change avoids the race condition
> in thread creation where sometimes the thread starts immediately,
> descheduling the calling thread and finishes the job and exits, and then
> caller sets worker launched true when the thread is not running.
> 
> Signed-off-by: Pravin Pathak <pravin.pathak.dev@gmail.com>
> ---

Ran a more detailed AI review on this.

Subject: Re: [PATCH] event/dlb2: fix race condition during dynamic linking

The fix is correct and worth having in stable. Some notes on what it
does and does not cover, since two related problems remain in this
code.

What the patch fixes
--------------------

os_schedule_work() set worker_launched = true after
rte_thread_create_internal_control() returned, but the worker thread
(dlb2_complete_queue_map_unmap()) clears that flag as its last act
before exiting. If the new thread ran to completion before the creator
was scheduled again, the creator stamped true over the worker's false.

The flag is then stuck true for the life of the device:

  - os_worker_active() always reports an active worker
  - all three call sites in dlb2_resource.c (2336, 2370, 6037) are
    guarded by if (!os_worker_active(hw)), so no worker is ever
    launched again
  - deferred map/unmap work is stranded, leaving ports in
    DLB2_QUEUE_MAP_IN_PROG / UNMAP_IN_PROG indefinitely

Setting the flag before thread creation closes that window: creation is
a synchronization point, so the worker is guaranteed to observe true and
its own clear is the last write. Resetting to false on the create-failure
path is right.

Remaining issues
----------------

Both of these predate the patch, so they are follow-up material rather
than objections, but they are in the same few lines and should probably
be cleaned up while the context is fresh.

1. Missed wakeup. resource_mutex is only ever taken inside the worker
loop:

  drivers/event/dlb2/pf/dlb2_main.h:46   rte_spinlock_t resource_mutex
  drivers/event/dlb2/pf/base/dlb2_osdep.h:172,178,190  worker only
  drivers/event/dlb2/pf/dlb2_main.c:34   rte_spinlock_init()

No caller holds it across the check-and-schedule pair, so for one
control thread against the worker:

  - worker's final iteration scans, finds nothing pending
  - control thread marks a new unmap in progress
  - control thread reads worker_launched as true, skips
    os_schedule_work()
  - worker sets worker_launched = false and exits

The work is stranded until the next link/unlink happens to launch a new
worker. This needs no MT-unsafe API use to hit: eventdev link/unlink is
not MT-safe by contract, and a single conforming control thread racing
the worker is enough.

The kernel driver this base code was ported from holds resource_mutex
around the check and the schedule; the DPDK port dropped that. Before
this patch the resulting failure was permanent, now it is transient.

2. worker_launched is a plain bool with mixed access. The worker writes
it under the spinlock, callers read and write it with no
synchronization, which is a C11 data race. The practical impact is
small since the worst case is a duplicate worker and two workers
looping under the same mutex are safe, but it should be
RTE_ATOMIC(bool) with release/acquire.
