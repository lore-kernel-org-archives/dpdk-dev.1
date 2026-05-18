Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BC6CD4F3C
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 03:49:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E542402A7;
	Mon, 18 May 2026 05:49:04 +0200 (CEST)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173]) by mails.dpdk.org (Postfix) with ESMTP id E300040264
 for <dev@dpdk.org>; Mon, 18 May 2026 05:49:01 +0200 (CEST)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-2f0d3e07e30so7406290eec.0
 for <dev@dpdk.org>; Sun, 17 May 2026 20:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779076141;
 x=1779680941; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pf9MY2xWuw9I8kkvSR9Mkn/sBzYfIZMyOG64l8fcdQU=;
 b=aH5KiBz8KDCBx//qMlYLlOTRr4bhiNcfaBBW4zmD+lPqCc3a/LEceaqcOckz1A2QRV
 /Z6cK8/vXzqqazY+C57RXAeyuxwuDczgOuat23mDc+i93P4aLxqPgCTM9fd2clPha2Ii
 jy4On68A03ACfRazt2DF4+K3Qe1bvZ4wsPI1YE86JJAn4veOjKdjL4n7q7ERYjjd1hrE
 PHeusPVg7Sp8Y9JY/2KhKz4OrHdfolZ5WsEwOkanVMsTvpngMN8iX6ZEkbq2LLO0PEIL
 BFp/J6q48PkufbjLgLNkLCTrW63VpbAKVZSg+JOKEOSmvW5PWT0ZuN7bI0DWnY1Si1G2
 bfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779076141; x=1779680941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Pf9MY2xWuw9I8kkvSR9Mkn/sBzYfIZMyOG64l8fcdQU=;
 b=fAEOMmXUVrtyZXSAj9LUZDfg8jXtBa17fdpNsyir8qZZilTqdsg8sdUGvjC5wzKhrh
 L5Horn2UJgqGZR4e1QR+dZqNCTJdBOcRfyvKcPvlMS9tiGbeAuMrBM+ui/lRwHG7U1SH
 oUux0BTc2EwyHP5pl3WZWrrxOzXXKXNe9iTGJqVYe5XAqBwxKmlIZ0dTokAcw1+oIzEI
 RCrH26W6ANl1g+FiM2kOx030OAP2rRd793elt5aSookVOGPCe6TkjJnie1fk7OkfjOcZ
 W7BCTdxzRWgeb+qhin3D8Y9nGPjhAgS2asQmizq1Py0ybdW7nVAPWwq5JJJnztz9WeNf
 goUg==
X-Gm-Message-State: AOJu0YyHvxB8Qws5pWx/J8Rd49dM3UAdw4ElTyBbbPfkCzR1XOokVrBq
 LdNUfvGH83r3Fy3MfxwBLKoNFo216DqSiqc1XQevItvhKwl8Rvmd6JbJtCcxt0p2rqo=
X-Gm-Gg: Acq92OGsAtvxZJ1twcUtgx7k6JB4tYhkVSOsh/m5ij9yS2+8NvppvgLZnoSWgkkguPR
 Or1VBEps8MqZPWXLHwW8JPoWqT7Fcrnxbc1wxNqY2odPWcvnHMa74nnEcvilOEEFrb6EO1XQ5WX
 906s3JEQWyuWMzs7uyBwKFgPwFcG6tZO6ECl614IIUFJZ3PmbvhO50sBp+cgCHK+3T4nwFKrE6C
 zwWEzfpO1XW6mutzpo31keL6p6OZKzVBUYbQQuWH+5ptEpTJm/hf0GGVGlsAYsVI2WdlEqEyOtD
 HElKL9LUv7hpSs50AHQoDJRKYWxGio/Wana6Tz9MW6JnIIfdWLxLq+1827TT/J0j4nB64hHSzDE
 Xjl0MOPxWieuSK8M2lg2cxhxtQ/d6NX341xbBmuB7J9gkOOjlaY79PGS7j9YG42Yf3RN1m+i+nU
 n+G7Iun6pcRLtQeARXMtizMmkRrmuvebVLma0=
X-Received: by 2002:a05:7301:3d06:b0:2f9:5c29:ffb6 with SMTP id
 5a478bee46e88-303982be5c8mr5886258eec.13.1779076140719; 
 Sun, 17 May 2026 20:49:00 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30296dcc464sm13790142eec.14.2026.05.17.20.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 20:49:00 -0700 (PDT)
Date: Sun, 17 May 2026 20:48:58 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wei Hu <weh@linux.microsoft.com>
Cc: dev@dpdk.org, longli@microsoft.com, weh@microsoft.com
Subject: Re: [PATCH v2 1/1] net/mana: add device reset support
Message-ID: <20260517204858.7a8a9200@phoenix.local>
In-Reply-To: <20260509060113.61686-2-weh@linux.microsoft.com>
References: <20260509060113.61686-1-weh@linux.microsoft.com>
 <20260509060113.61686-2-weh@linux.microsoft.com>
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

On Fri,  8 May 2026 23:01:13 -0700
Wei Hu <weh@linux.microsoft.com> wrote:

> From: Wei Hu <weh@microsoft.com>
> 
> Add support for handling hardware reset events in the MANA driver.
> When the MANA kernel driver receives a hardware service event, it
> initiates a device reset and notifies userspace via
> IBV_EVENT_DEVICE_FATAL. The DPDK driver handles this by performing
> an automatic teardown and recovery sequence.
> 
> The reset flow has two phases. In the enter phase, running on the
> EAL interrupt thread, the driver transitions the device state,
> waits for data path threads to reach a quiescent state using RCU,
> stops queues, tears down IB resources, and frees per-queue MR
> caches. A control thread is then spawned to handle the exit phase:
> it waits for the hardware to recover, unregisters the interrupt
> handler, re-probes the PCI device, reinitializes MR caches, and
> restarts queues.
> 
> A per-device spinlock serializes the reset path with ethdev
> operations. Operations that cannot wait (configure, queue setup)
> return -EBUSY during reset, while dev_stop and dev_close join the
> reset thread and use a blocking lock to ensure proper sequencing.
> 
> Multi-process support is included: secondary processes unmap and
> remap doorbell pages via IPC during the reset enter and exit
> phases. Data path functions in both primary and secondary
> processes check the device state atomically and return early when
> the device is not active.
> 
> The driver uses ethdev recovery events to notify upper layers
> (e.g. netvsc) of the reset lifecycle: RTE_ETH_EVENT_ERR_RECOVERING
> on entry, RTE_ETH_EVENT_RECOVERY_SUCCESS or
> RTE_ETH_EVENT_RECOVERY_FAILED on completion. A PCI device removal
> event callback distinguishes hot-remove from service reset.
> 
> Signed-off-by: Wei Hu <weh@microsoft.com>
> ---

Lots of issues found during AI review..

Subject: Re: [PATCH v2 1/1] net/mana: add device reset support

To: Wei Hu <weh@linux.microsoft.com>
Cc: dev@dpdk.org, longli@microsoft.com, weh@microsoft.com
In-Reply-To: <20260509060113.61686-2-weh@linux.microsoft.com>
References: <20260509060113.61686-1-weh@linux.microsoft.com>
 <20260509060113.61686-2-weh@linux.microsoft.com>

On Fri,  8 May 2026 23:01:13 -0700, Wei Hu wrote:
> Add support for handling hardware reset events in the MANA driver.

Several issues need attention before this can be merged.

Errors
------

1. Memory leak: priv->dev_state_qsv is never freed on close.

   In mana_probe_port (non-reset path) the qsbr buffer is allocated:

       priv->dev_state_qsv = rte_zmalloc_socket("mana_rcu", sz, ...);

   It is only freed in the probe-failure goto label.  mana_dev_close
   has no corresponding rte_free, so every successful close leaks
   the allocation.

2. Joinable reset thread is leaked when reset completes on its own.

   Both mana_reset_thread (skip path) and mana_reset_exit_delay
   (normal completion) do:

       priv->reset_thread_active = false;
       rte_spinlock_unlock(&priv->reset_ops_lock);
       return 0;

   The pthread is still joinable at this point.  If mana_dev_close
   runs afterward it sees active==false and skips rte_thread_join,
   leaving the TCB/stack unreaped.  The flag must only be cleared by
   whoever actually joins the thread; otherwise the reset thread
   should be detached (and then dev_close cannot wait for it, which
   is its own problem).  Either way the current pattern is wrong.

3. Spinlock held across blocking operations.

   priv->reset_ops_lock is rte_spinlock_t and is held across:

     - mana_reset_enter:      mana_dev_stop, mana_dev_close,
                              ibv_close_device,
                              mana_mp_req_on_rxtx (5s IPC timeout)
     - mana_reset_exit_delay: ibv_close_device, mana_pci_probe,
                              mana_mp_req_on_rxtx, mana_dev_start

   IPC with a 5-second timeout and device probe under a spinlock is
   not acceptable.  Use a sleeping mutex (pthread_mutex_t initialized
   with PTHREAD_PROCESS_SHARED, since priv is in shared memory), or
   split the lock so the long operations run outside it.

4. pthread_mutex_init / pthread_cond_init without PTHREAD_PROCESS_SHARED.

   priv is allocated with rte_zmalloc_socket, so reset_cond_mutex and
   reset_cond live in hugepage memory mapped into every secondary.
   The patch initializes them with NULL attributes:

       pthread_mutex_init(&priv->reset_cond_mutex, NULL);
       pthread_cond_init(&priv->reset_cond, NULL);

   Even if only the primary uses them today, placement in shared
   memory requires the process-shared attribute.  Otherwise behavior
   is undefined and the choice will silently break the day a
   secondary starts touching these fields.

Warnings
--------

5. Secondary data path has no synchronization with the doorbell unmap.

   MANA_MP_REQ_RESET_ENTER causes the secondary MP handler to munmap
   proc_priv->db_page and set it to NULL.  The secondary's rx_burst /
   tx_burst protect themselves only with an atomic state check:

       rte_rcu_qsbr_thread_online(dstate_qsv, tid);
       if (state != MANA_DEV_ACTIVE || !db_page) { ... return 0; }

   But the qsbr only has primary threads registered (registration
   happens in mana_dev_configure, which never runs in secondary), so
   thread_online/offline in secondary do not block the primary's
   qsbr_check.  The MP handler in secondary therefore unmaps db_page
   while a peer secondary lcore can still be inside rx/tx_burst with
   a stale pointer.  Result: SIGSEGV on the next doorbell write.

   The secondary needs its own quiescence mechanism (a per-process
   qsbr or a reader-side rwlock around the data path that the MP
   handler acquires before unmap).

6. Return value of rte_dev_event_callback_unregister is discarded.

   In mana_intr_uninstall:

       if (dev->device)
               rte_dev_event_callback_unregister(dev->device->name,
                                                 mana_pci_remove_event_cb,
                                                 priv);

   The API returns -EAGAIN if the callback is currently executing.
   When that happens the unregister silently fails, the callback
   stays on the list, and any later free of priv produces a
   use-after-free the next time the EAL device-event thread
   dispatches.

7. PCI-remove callback depends on a monitor nobody starts.

   rte_dev_event_callback_register only wires the callback into the
   dispatch table; events are only delivered when something calls
   rte_dev_event_monitor_start().  The patch never calls it.  Whether
   this works in practice depends on the application (testpmd,
   netvsc) calling it first.  At minimum document the requirement;
   better, have the driver start the monitor on first probe and stop
   it on last remove.

8. No documentation or release-note update.

   This is a substantial new feature.  doc/guides/rel_notes/ and
   doc/guides/nics/mana.rst should both be updated to describe the
   reset lifecycle, the RTE_ETH_EVENT_ERR_RECOVERING /
   RECOVERY_SUCCESS / RECOVERY_FAILED behavior, and the dependency
   on rte_dev_event_monitor_start.

9. priv->reset_thread_active is bool, accessed without atomic ops.

   It is read in mana_dev_stop_lock and mana_dev_close_lock before
   the spinlock is acquired (intentionally, to avoid deadlock with
   the reset thread), and written from at least three threads (intr
   handler, reset thread, dev_close).  It should be RTE_ATOMIC(bool)
   with explicit ordering.  This compounds issue #2.

10. mana_intr_handler races with mana_pci_remove_event_cb on dev_state.

    intr_handler does:

        if (state == MANA_DEV_ACTIVE) {
                rte_spinlock_lock(&priv->reset_ops_lock);
                mana_reset_enter(priv);   /* stores RESET_ENTER */

    pci_remove_event_cb stores RESET_FAILED before taking the lock.
    If intr_handler reads ACTIVE, pci_remove fires (sets
    RESET_FAILED) while intr_handler is waiting on the lock,
    intr_handler then acquires it and overwrites RESET_FAILED with
    RESET_ENTER, and the driver attempts a reset on a device that
    has already been physically removed.  The state-set in
    pci_remove_event_cb must occur under the lock, or the
    intr_handler must re-check state after taking the lock.

Info
----

11. (void *)0 is used in mp.c (proc_priv->db_page = (void *)0; and
    if (proc_priv->db_page != 0)).  Use NULL.

12. The hand-off of reset_ops_lock from mana_reset_enter to
    mana_reset_thread to mana_reset_exit_delay (released in the
    latter) is hard to follow.  A short comment block at
    mana_reset_enter listing which functions take the lock and which
    release it would help future maintainers.

13. The widened TOCTOU window in mana_tx_burst (db_page is now read
    at the top of the function rather than just before the doorbell)
    is not itself a bug, but it makes #5 worse.  Once #5 is fixed
    via a proper reader-side primitive, consider keeping the db_page
    read inside the critical section.
