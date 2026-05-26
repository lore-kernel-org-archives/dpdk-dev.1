Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452E2CD5BB1
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 19:37:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C493402AC;
	Tue, 26 May 2026 21:37:54 +0200 (CEST)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by mails.dpdk.org (Postfix) with ESMTP id C5BFE4021F
 for <dev@dpdk.org>; Tue, 26 May 2026 21:37:51 +0200 (CEST)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-1370417c01cso2409446c88.1
 for <dev@dpdk.org>; Tue, 26 May 2026 12:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779824271;
 x=1780429071; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mxFOXX8bJ1h1dHcmKoXWHvo5WP1Xc4Ag3s1lVCGK4WY=;
 b=EvH9bX5RZEUmKBf2eTUyY/OveACrPAwNg5cgYKoCWk22g4fswT9KAS0jppy4nZzvXP
 tE3LETFyv+5UV1r/wE1Oan4/YADEXqdEHYDJl8PSbbYyLresHr37WpBWlAsRGJHK8xc8
 ljpWfsBFFrcMxGdwRFpL7Dl7YP/hWFca8YCBySt6EMICgjWHQUoxZ26+0Y0F6DNknE6D
 kzqLxutvwdViGicw1OO8UdevE1v4nVJyuKsThoqE43C2/fhLeiR1l2rfq6fLNobJ7QIt
 v+rQHMn+RZZgwkz22UFVAwqlrJ4xTbWjZSC7g/gl1Eazz+5kyQDoIFUbB3v9rMJH6mLO
 d1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779824271; x=1780429071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mxFOXX8bJ1h1dHcmKoXWHvo5WP1Xc4Ag3s1lVCGK4WY=;
 b=Ygmki1AM8WVyYH8G+06h61MYjeOsWqWVfwQNN9jDBOL2z+Y8o4Kuu4zMVhyQBHox/n
 XXjZMOaQ1gZmzMWzRoAzrIaICrRtHaX40grf5LmKAD8ORwNudq5Or8Ytj3d/Or4AMIwI
 gQ6x4+7UBGLEUoLyN62uUy5DhT3pEyShNNy+nFz/4yY8bm8wUhTZIH+YHyncY20ayyZg
 5IEIooMbIh+m+DjPI8WqT187+cfP/85VIjlvs3/+dGnf0wNlPdaDhx2ZSw9BgkbKZmyV
 Q5SnuMVMTUUK+Ty9QVRvQ6lk7Cd/EIVlfipbuZ+ZB4nj5NMew9Bfm8VjDdppI9vEHZLC
 8xnQ==
X-Gm-Message-State: AOJu0Yz/L5kOfxbB6p2spHtms5PtFCgJeZ8hKfbHTHB8cpsZ5ptmEvwY
 WVtmE9VGVLk4+2hHzhL6wnJK2IlON4LmHOCsiSNN6ENVSd9/uoHdbbYxdmIKggF7Hz8=
X-Gm-Gg: Acq92OEGkSJrld3jzySx65yY5o7q2ybeJYBohRnygVYRzieuhL0tU8MERNE9ZZcY9Gc
 mTw0ZWFTyidQLhIBR0T4REhG+/4rp2mtGimsuwRroDP7k0LGSo/5U40ubgYky83EXjIJgXVKlbz
 82ClCaAmHqPyzZWd5pxVrXmM2Gc3oqIaUhwdOuJpwXh41O+BgxbKic+QPmaArbUJZAbKJHdlpsv
 9vByT7HvTVfBYscg78VlvQrEcLYsW2P/hxJ6XwoPZ1S74RMdanLMyJQbt6nGvxr5zHkIdlumcN6
 SCJt6U9FjPY0tULzFGiUGoNNM2TGm1QQIgz9lHBNS4lCB4QPbxj0TZ5O1CpyjoAVPfEVX/X1Tya
 TVWoYcVgT+aRpDDTywIHxWCwWrtVNSgVMtBoogzDg6Pe/tXFuZdIMRlGMzZ30bBNkWQZTB68Cmm
 PTIzPY6VSy09L27YujDHQs/9Cp/vgOD6muHEUN5UFKxV83PoT2tCyRD1q07AouP+MK
X-Received: by 2002:a05:7022:ec7:b0:12a:6fb7:87e7 with SMTP id
 a92af1059eb24-1365f0a8d6dmr6930667c88.0.1779824270495; 
 Tue, 26 May 2026 12:37:50 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1366aba2b9asm11092493c88.15.2026.05.26.12.37.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 12:37:50 -0700 (PDT)
Date: Tue, 26 May 2026 12:37:47 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wei Hu <weh@linux.microsoft.com>
Cc: dev@dpdk.org, longli@microsoft.com, weh@microsoft.com
Subject: Re: [PATCH v3 0/2] net/mana: add device reset support
Message-ID: <20260526123747.46871467@phoenix.local>
In-Reply-To: <20260522065943.126703-1-weh@linux.microsoft.com>
References: <20260522065943.126703-1-weh@linux.microsoft.com>
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

On Thu, 21 May 2026 23:59:41 -0700
Wei Hu <weh@linux.microsoft.com> wrote:

> From: Wei Hu <weh@microsoft.com>
> 
> Add support for handling hardware service reset events in the
> MANA driver. When the MANA kernel driver receives a hardware
> service event, it initiates a device reset and notifies userspace
> via IBV_EVENT_DEVICE_FATAL. The MANA PMD handles this by
> performing an automatic teardown and recovery sequence.
> 
> The driver uses ethdev recovery events (ERR_RECOVERING,
> RECOVERY_SUCCESS, RECOVERY_FAILED) to notify upper layers of
> the reset lifecycle, and a PCI device removal event callback
> to distinguish hot-remove from service reset.
> 
> Changes since v2:
> - Fixed dev_state_qsv memory leak on device removal
> - Fixed reset thread TCB/stack leak: reset_thread_active is now
>   only cleared by the joiner, not the thread itself
> - Fixed second reset crash: removed reset thread join logic from
>   mana_dev_close (inner function) to avoid corrupting dev_state
>   when called from mana_reset_enter
> - Made reset_thread_active RTE_ATOMIC(bool) with explicit ordering
> - Added retry loop for rte_dev_event_callback_unregister on -EAGAIN
> - Initialized condvar/mutex with PTHREAD_PROCESS_SHARED since priv
>   is in hugepage shared memory
> - Added re-check of dev_state after lock acquisition in
>   mana_intr_handler to prevent racing with pci_remove_event_cb
> - Replaced (void *)0 with NULL in mp.c
> - Added lock ownership comment block at mana_reset_enter
> - Documented rte_dev_event_monitor_start() requirement
> - Added mana.rst documentation and release note (patch 2/2)
> 
> Changes since v1:
> - Removed net/netvsc patch from this series
> - Simplified reset exit: mana_reset_exit calls
>   mana_reset_exit_delay directly instead of spawning a thread
> - Added __rte_no_thread_safety_analysis annotations for clang
> - Switched to rte_thread_create_internal_control
> - Fixed declaration-after-statement style issues
> - Removed unnecessary blank lines and stale comments
> 
> Wei Hu (2):
>   net/mana: add device reset support
>   net/mana: add documentation for device reset support
> 
>  doc/guides/nics/mana.rst               |  33 +
>  doc/guides/rel_notes/release_26_07.rst |   8 +
>  drivers/net/mana/mana.c                | 995 ++++++++++++++++++++++---
>  drivers/net/mana/mana.h                |  33 +-
>  drivers/net/mana/meson.build           |   2 +-
>  drivers/net/mana/mp.c                  |  89 ++-
>  drivers/net/mana/mr.c                  |   6 +-
>  drivers/net/mana/rx.c                  |  24 +-
>  drivers/net/mana/tx.c                  |  40 +-
>  9 files changed, 1123 insertions(+), 107 deletions(-)
> 

AI review found a few things...


Thanks for the v3.  Most of the v2 items are addressed: dev_state_qsv
is freed via mana_dev_free_resources, reset_thread_active is now
RTE_ATOMIC(bool), the joiner owns the flag, pthread mutex/cond use
PROCESS_SHARED attrs, intr_handler re-checks state under the lock,
the lock hand-off has a clear comment, and a doc + release note
patch is included.

A few items remain or were introduced by the v2->v3 changes.

Errors

1. Deadlock in dev_close_lock + EAGAIN loop on PCI-remove callback.

   The v3 fix for the discarded unregister return uses a busy-wait:

       if (dev->device) {
               do {
                       ret = rte_dev_event_callback_unregister(...);
               } while (ret == -EAGAIN);
       }

   mana_intr_uninstall runs from mana_dev_close, which runs from
   mana_dev_close_lock with reset_ops_lock held.  EAL returns
   -EAGAIN while cb_lst->active is 1 (callback dispatching).  The
   callback in question is mana_pci_remove_event_cb, which itself
   blocks on rte_spinlock_lock(&priv->reset_ops_lock).  Result:
   dev_close holds the spinlock, the callback waits for the
   spinlock, the loop waits for the callback to finish -- three-way
   deadlock if a hot-remove event arrives during close.

   Either drop the lock before unregistering and re-take it after,
   or (better) use a sleeping mutex for reset_ops_lock so the
   callback can complete while close is suspended.

2. reset_ops_lock is still rte_spinlock_t held across blocking work.

   Unchanged from v2: the spinlock is held through

     - mana_reset_enter:      rte_rcu_qsbr_check spin,
                              mana_dev_stop,
                              mana_mp_req_on_rxtx (5s IPC timeout),
                              mana_dev_close
     - mana_reset_exit_delay: ibv_close_device, mana_pci_probe,
                              mana_mp_req_on_rxtx, mana_dev_start

   Any other ethdev op that hits dev_ops while reset is in flight
   spins for tens of seconds.  Blocking calls under a spinlock are
   an Error; use a properly-initialised pthread_mutex_t (you
   already have PROCESS_SHARED attrs handy).

Warnings

3. Secondary process: qsbr does not actually quiesce secondary lcores.

   rte_rcu_qsbr_thread_register is only called from
   mana_dev_configure, which the secondary never runs.  The
   secondary's rx_burst/tx_burst still call thread_online/offline
   against the shared qsv, but the secondary tids are unregistered,
   so they are invisible to rte_rcu_qsbr_check in the primary, and
   the secondary MP handler (mana_mp_reset_enter) does not call
   qsbr_check at all -- it just sets db_page = NULL and munmaps.

   The dev_state check at the top of secondary tx_burst is racy:
   the page can be munmapped after the in-loop read of db_page but
   before the doorbell write at the bottom.  The "All secondary
   threads are quiescent" log line in mana_mp_reset_enter is not
   true.

   The secondary needs a real reader-side primitive -- its own
   qsbr with secondary lcore registration, or an rwlock the MP
   handler takes before munmap.

4. Double-join race between dev_close_lock and mana_reset_enter.

   dev_close_lock signals + joins the reset thread *before* taking
   reset_ops_lock.  intr_handler may fire in that window:

     1. dev_close_lock: pthread_cond_signal, rte_thread_join
     2. intr_handler:   take lock, see ACTIVE, call reset_enter
     3. reset_enter:    reset_thread_active still true (step 1
                        hasn't cleared it yet) -> rte_thread_join
                        on a thread that step 1 just joined -> UB

   The pre-lock signal/join was added to avoid deadlock with the
   reset thread holding the lock, which is fine in itself, but the
   reset_thread_active update needs to be inside that critical
   section, or reset_enter has to recheck under the lock.

5. mana_dev_close (non-_lock) does not join the reset thread.

   mana_dev_uninit -> mana_dev_close path doesn't go through
   dev_close_lock, so if pci_remove arrives while the reset thread
   is alive, mana_dev_free_resources can destroy reset_cond_mutex /
   reset_cond before the thread has exited.  In practice the
   pci_remove callback signals RESET_FAILED and the reset thread
   should exit quickly, but the ordering isn't enforced.  Either
   join in mana_dev_uninit, or document the assumption.

Info

6. mana_reset_exit_delay sets priv->ib_ctx = NULL even when
   ibv_close_device fails:

       ret = ibv_close_device(priv->ib_ctx);
       priv->ib_ctx = NULL;
       if (ret) { ... goto out; }

   The handle is leaked if close fails.  Either keep the old
   pointer on failure or accept that close-failure is unrecoverable
   and free it anyway with a comment.

Patch 2/2

7. The events list is a term/description pattern and should be a
   definition list per DPDK RST style:

       ``RTE_ETH_EVENT_ERR_RECOVERING``
          Reset has started.

       ``RTE_ETH_EVENT_RECOVERY_SUCCESS``
          Device has recovered successfully.

       ``RTE_ETH_EVENT_RECOVERY_FAILED``
          Recovery failed.

8. Convention is to fold doc + release note updates into the same
   commit as the feature.  Patches 1/2 and 2/2 can be squashed.
