Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728CFCD8CB9
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 17:12:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C57042686;
	Wed, 10 Jun 2026 19:12:52 +0200 (CEST)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174]) by mails.dpdk.org (Postfix) with ESMTP id 80286402BA
 for <dev@dpdk.org>; Wed, 10 Jun 2026 19:12:50 +0200 (CEST)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-3075ce9c05aso1319931eec.1
 for <dev@dpdk.org>; Wed, 10 Jun 2026 10:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781111569;
 x=1781716369; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yddqbgFgdfZLQimizf+sEPkVKUhSSNXu8BRxNC0RnW8=;
 b=DPN1gS85gCSaWi31QbLonZgpLzXE1IbZDyCpLyTmBRMdBlN5dGewChRMqQ1JXO5Ptz
 ieAsAcpvcIVTrgEF4Df09gtyBH0Cv7B9SpkUvcDCoVjmS6Y3aUZb8AMtuHwoVR4mYpWC
 j7meKOSVN+mlhIKGPvOvs/B7vxSzd/oeJSXdEHMkYiF6ggbfO/g/ND7jOvNWbhU8IW+P
 CgRjZqpuE7Ami0cKaTnpkTbh8cgNVta/ypllNfUktQWzw6PSW/kry59vzx8fq85jKXjv
 6dMtDmxuVAwysUz+swMWLPk/HyZrv9MG4gaQY7F5Q/hlNVbeL1WbSV8IcxfjLRrvwfZO
 WxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781111569; x=1781716369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yddqbgFgdfZLQimizf+sEPkVKUhSSNXu8BRxNC0RnW8=;
 b=iTfzQBwEX/fY1JSDa4phgu7bwE1x1pQ+RYelQB00QjxfangMCF6sT9pNdRbKsDrgtl
 8ozkAemy2xtMOhoF6ACB0j/gJTCH1wgb7NjHGF8lgkvWEzxcjYSUw2mnXrEU2EJhxgI9
 OBmwSDMXmXNvR2U0/759t50tbzhvF1pW5qrgoQNEoDtzg/Be53po5DQSROR+H8ZlwQmi
 IsHa7QO2EZWd4ytMeWWHozH5cwmiSaYQTK5Go4qosbS0amNYB0EitWEx/dwhJB+AgdWx
 J+q9a8EOzLCrMSacQDLngeLz9vttu6VlKXobQCTS0IX/HsjVSoe1UpMswv4Uw1flSo7K
 VsbQ==
X-Gm-Message-State: AOJu0YwKCcUEHYiN+u92UAxTgk3zwdjYs8hnM6O8LfGSHHMvMj+M4kQb
 yK3O/3dLKM3Z6qk7LUP4kV1mMQgveK1fA8aZL6YfcHlCsSwV16iI/n86iLy/r+60+OM=
X-Gm-Gg: Acq92OEeCX/1t1ye3BE6hwYneZmsk0MdQamBVtQWTGIaKXZTWFxsqDAo9UFtXCaIW7X
 h2aO29F3Rx144hUZUMhvvCYcJabspoVdqp0WytOrgj6JFFNSFPv8ZirboFMUlD98Mv8J7y+SZaW
 NGA9ZDGAZ45pqABD/IiPHr5qDDDsmyTuVqrgf4kJiIqk2KvvLxphtmqSb5SR/pC25W+0sYKNdnH
 XZm8yUyHLpLI4NhjtNJVmPKpnAsfrqBbM0yWf/ynwSTq3Y7WfU5tFugX17Ssao15+7bzIggQaZ0
 enO1geWBCzZS8fEdw3hApjxiQCQtKQC3ZZfpRbXlqwvaW4W6xHgTgOVCwi+p52UQce5K49OH+VY
 0UNGOt8oOLZV8U3Vq8Qd0TNx1oqHhYLDWrpU+BSXLddAo87chWPghlMCFQ2hYfrJf7SIELwDmFo
 OBiz5HWau3kMHdQfL2VXDQJ/sPo2sdzaFzNzRAee3wy4ZNhLL3BCTVGPXRKiYDbcPOUMOfxC58C
 BY=
X-Received: by 2002:a05:7300:572a:b0:304:aca:35c5 with SMTP id
 5a478bee46e88-3077b22c938mr14972545eec.23.1781111568990; 
 Wed, 10 Jun 2026 10:12:48 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074dcbe995sm33877206eec.13.2026.06.10.10.12.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 10:12:48 -0700 (PDT)
Date: Wed, 10 Jun 2026 09:56:33 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wei Hu <weh@linux.microsoft.com>
Cc: dev@dpdk.org, longli@microsoft.com, weh@microsoft.com
Subject: Re: [PATCH v8 0/1] net/mana: add device reset support
Message-ID: <20260610095633.0bf6c153@phoenix.local>
In-Reply-To: <cover.1781017284.git.weh@linux.microsoft.com>
References: <cover.1781017284.git.weh@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, 10 Jun 2026 00:21:21 -0700
Wei Hu <weh@linux.microsoft.com> wrote:

> From: Wei Hu <weh@microsoft.com>
>=20
> Add support for handling hardware service reset events in the
> MANA driver. When the MANA kernel driver receives a hardware
> service event, it initiates a device reset and notifies userspace
> via IBV_EVENT_DEVICE_FATAL. The MANA PMD handles this by
> performing an automatic teardown and recovery sequence.
>=20
> The driver uses ethdev recovery events (ERR_RECOVERING,
> RECOVERY_SUCCESS, RECOVERY_FAILED) to notify upper layers of
> the reset lifecycle, and a PCI device removal event callback
> to distinguish hot-remove from service reset.
>=20
> Changes since v7:
> - Moved heavy teardown (dev_stop, IPC to secondaries, dev_close,
>   MR btree free) from mana_reset_enter (EAL interrupt thread)
>   to mana_reset_thread (control thread). The interrupt handler
>   now only sets state, drains in-flight bursts, and spawns the
>   thread. Teardown runs immediately in the control thread before
>   the recovery timer wait, avoiding blocking the interrupt thread
>   on multi-second IPC timeouts and ibverbs calls. Each function
>   now owns its own lock scope with no lock hand-off between
>   threads.
> - Fixed self-join deadlock: clear reset_thread_active before
>   emitting RECOVERY_SUCCESS/FAILED callbacks from the reset
>   thread. Without this, if the callback calls dev_stop/dev_close,
>   mana_join_reset_thread attempts to join the current thread.
> - Simplified burst_state from encoding device state in bits 1+
>   to a single blocked flag (bit 1). Only one value was ever
>   stored, so the multi-state encoding was misleading. Added
>   MANA_BURST_BLOCKED constant.
> - Updated mana.rst to reflect that teardown runs on the control
>   thread, not the interrupt handler.
>=20
> Changes since v6:
> - Rebased onto latest upstream for-main
> - Replaced removed RTE_ETH_DEV_TO_PCI macro with
>   RTE_CLASS_TO_BUS_DEVICE (upstream commit 4757b8df04
>   removed the old bus-specific ethdev convenience macros)
>=20
> Changes since v5:
> - Replaced RCU QSBR with per-queue atomic burst_state using a
>   single-variable CAS design: bit 0 is the in-burst flag, bit 1
>   is the blocked flag. The data path uses CAS(0=E2=86=921) to enter
>   burst and fetch_and(~1) to exit. The reset path uses fetch_or
>   to set the blocked bit and polls bit 0 to drain in-flight
>   bursts. This eliminates the two-variable Dekker pattern and the
>   need for sequential consistency (seq_cst) ordering.
> - Removed librte_rcu dependency
> - Removed __rte_no_thread_safety_analysis annotations (no longer
>   needed after mutex conversion)
> - Moved ERR_RECOVERING event emission before acquiring
>   reset_ops_lock and before mana_reset_enter, so upper layers
>   (e.g. netvsc) can switch data path before mana stops queues.
>   Emitting outside the lock avoids deadlock if the callback
>   calls dev_stop or dev_close.
> - Replaced MANA_OPS_*_LOCK macros with mana_reset_trylock()
>   helper function and explicit per-operation wrappers
> - Removed unused rte_alarm.h and rte_lock_annotations.h includes
> - Added RECOVERY_FAILED event when mana_reset_enter fails
>   internally, so the application always receives a terminal event
> - Added mana_clear_burst_state() helper to clear per-queue
>   burst_state on failure paths (reset_failed, dev_stop_lock,
>   dev_close_lock) preventing permanent silent packet drop after
>   a failed reset
>=20
> Changes since v4:
> - Fixed stale rte_spinlock_unlock call in mana_intr_handler that
>   was missed during the spinlock-to-mutex conversion, causing a
>   -Wincompatible-pointer-types warning
>=20
> Changes since v3:
> - Converted reset_ops_lock from rte_spinlock_t to pthread_mutex_t
>   with PTHREAD_PROCESS_SHARED, since the lock is held across
>   blocking IB verbs calls and IPC with 5s timeout
> - Removed rte_dev_event_callback_unregister retry loop to avoid
>   deadlock: the callback itself blocks on reset_ops_lock, so
>   retrying on -EAGAIN while holding the lock is a deadlock
> - Introduced mana_join_reset_thread() helper using CAS on
>   reset_thread_active to prevent double-join undefined behavior
> - Added reset thread join in mana_dev_uninit to prevent thread
>   leak on device removal
> - Fixed ibv handle leak: priv->ib_ctx is now only set to NULL
>   after ibv_close_device succeeds
> - Fixed misleading "All secondary threads are quiescent" log in
>   mana_mp_reset_enter =E2=80=94 changed to "Secondary doorbell pages
>   unmapped" since actual quiescence is enforced by the primary's
>   per-queue atomic flag check before IPC is sent
> - Changed event list in mana.rst to RST definition list style
> - Squashed documentation into the feature patch per convention
>=20
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
> - Added mana.rst documentation and release note
>=20
> Changes since v1:
> - Removed net/netvsc patch from this series
> - Simplified reset exit: mana_reset_exit calls
>   mana_reset_exit_delay directly instead of spawning a thread
> - Added __rte_no_thread_safety_analysis annotations for clang
> - Switched to rte_thread_create_internal_control
> - Fixed declaration-after-statement style issues
> - Removed unnecessary blank lines and stale comments
>=20
> Wei Hu (1):
>   net/mana: add device reset support
>=20
>  doc/guides/nics/mana.rst               |   40 +
>  doc/guides/rel_notes/release_26_07.rst |    8 +
>  drivers/net/mana/mana.c                | 1076 ++++++++++++++++++++++--
>  drivers/net/mana/mana.h                |   52 +-
>  drivers/net/mana/mp.c                  |   89 +-
>  drivers/net/mana/mr.c                  |    6 +-
>  drivers/net/mana/rx.c                  |   23 +-
>  drivers/net/mana/tx.c                  |   44 +-
>  8 files changed, 1230 insertions(+), 108 deletions(-)
>=20


AI review thread still sees some issues:

This is close. Teardown is off the interrupt thread now, the cross-thread l=
ock
hand-off is gone, and the burst_state encoding reads cleanly. One real prob=
lem
left.

The reset thread leaks on every successful recovery. mana_reset_exit_delay =
and
the reset_failed path in mana_reset_thread clear reset_thread_active from i=
nside
the thread itself, without joining. The thread is created joinable via
rte_thread_create_internal_control, so terminating it unjoined leaks its
resources, and because the flag is now false none of the join sites
(mana_join_reset_thread, the join-previous block in mana_reset_enter,
mana_dev_uninit) will ever reap it. The PCI-remove abort path leaves the fl=
ag
true and is reaped later, which is the inconsistency that exposes this: some
exits expect a join and some do not, and the latter have no reaper.

Simplest fix is to detach the reset thread (rte_thread_detach) and drop the
reset_thread_active / mana_join_reset_thread machinery, using reset_ops_loc=
k and
dev_state for the dev_stop/dev_close sequencing instead. That removes the
self-join hazard too. If you keep the join, don't clear the flag from insid=
e the
thread; have mana_join_reset_thread detect the self case and skip only the =
join.

Minor: the recovery condvar wait in mana_reset_thread is a bare cond_timedw=
ait.
If pci_remove signals before the thread reaches the wait, the wakeup is los=
t and
removal isn't seen until the 15s timer expires. Use a dev_state predicate l=
oop
under reset_cond_mutex.
