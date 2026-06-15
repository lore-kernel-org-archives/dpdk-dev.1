Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B19CD98DA
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 18:50:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F88E40BA4;
	Mon, 15 Jun 2026 20:50:34 +0200 (CEST)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171]) by mails.dpdk.org (Postfix) with ESMTP id 4F0CC400D6
 for <dev@dpdk.org>; Mon, 15 Jun 2026 20:50:33 +0200 (CEST)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-30759632453so5271502eec.1
 for <dev@dpdk.org>; Mon, 15 Jun 2026 11:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781549432;
 x=1782154232; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G4DA7mg1zRypQ5Aj6MGjPYMcdnNatlivHH6+4xzuIGQ=;
 b=DznNyxua4KYIFDY3h12/EmcQhQOHEV4ouQMZzQ4pkFcnltbqZDYJQ1FEQE1kQenIgi
 hDS6RrWA1DjdazhBd78MAWXrLdYdDGHaMpwIWiPcW0Npkx/v+o0fJ2evZ21A02q7Fdd/
 cseplVLAkfELgTpuNqSmiSDxVkQMp08JAGnbaevr8AXNlZZFJL9XXXoq3/tR7GidXids
 4s2BROdcu4wt2UPzzfMP/4Djy2wplnnYbsTDdnO9rh/ys5Zely2QzYIttHHxBfHHBX4E
 335XsogUSS6O/9zCHPJ5tfAyPYbuw+6l3EO1BDyUV5aAqZy66X5+tGVXCVrn4aw34REf
 Wksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781549432; x=1782154232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G4DA7mg1zRypQ5Aj6MGjPYMcdnNatlivHH6+4xzuIGQ=;
 b=X20/R75NU42heXtqlXqV4I1v37qVcKFQvq4wJD1ahMqFs+A6QLD7OlglQdXKvDWI8N
 QzG/1+Tt9TXNPFjdxPBzfHT4wxCqWjjSSNmJJ1+S16I1Aj7PHOy44cozWi9HCWAYwTy6
 G9uAoVA0ZFnkBW6tFwguwvm/XWdpemHbsIGByd77OtS5GZWhqOnX4///ONidJ7uTe0FE
 c86EvLrpSxzLomP5UnEpmpcrBRiadj2wGY6QD5CSekCpIQ+AjfMdc/i5a5q2k0Z3ZYt5
 RGwuoLMWQbFg1h1gHp4ny4MAaZx9JmQPXUOmmrN8CfYmFGqlgPm+5XFrKGbIAKwV7UAQ
 pARQ==
X-Gm-Message-State: AOJu0YyzJs78y01F9YzEJEQgjiIm9YxYsmV9y8oTfWVEdA9tOqm8xyw/
 HVfH5xcmwq/qPUpn+aIywVFuQebav3THk7iIPxSrlobPfCDFbWfynNGY8hCdi+Vh30Y=
X-Gm-Gg: Acq92OEfCRpat9224RcIhfMZrjN09KZM9drsiPG73LBHNJnk1NhHTd8TiLmByyfXaLO
 9rvFGURMcXt3md9ueeLeJyCJmQGB1uol60gD0hJZc/fbS+aaKDxvInNZaEdj7uqAQ38Y24KGI5H
 tcIjfDt/YfRwQvLAAr3XMMbf7jplJFdwvFfTR6tUyGuFkFjYcmsiNjgTUC3CKDQTulDzeQ59DVg
 0gdpDUmJ7MJkCE4nBKEaXF9r+HtNftrbN5R2L7HsLlh1T8xptvel7oNSPJk4zrPLwyim2banimN
 GccNtb66wc0OJ3mk9yX5bLvCoo4uXFVBZRR2neQeYalKanvpY17Pi5VmlEctRnOpelSl/4z9TZW
 VOSzaZ0nFne9ldPnOzyR1KhwD5nC/WYh9HcTqKogfCGk20CgbR+fAsrPTpLP+M+5XAUP7xBYdL9
 ew4LJjADq/3SFibK5Q2D3A34c0fg+Tysbg2REkOCn4EoBM4T7vExlCoPLXe6ubC+Kl
X-Received: by 2002:a05:7300:1485:b0:304:dddb:112 with SMTP id
 5a478bee46e88-3082026a47cmr9320584eec.34.1781549432005; 
 Mon, 15 Jun 2026 11:50:32 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e48c3dcsm16496639eec.1.2026.06.15.11.50.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 11:50:31 -0700 (PDT)
Date: Mon, 15 Jun 2026 11:50:28 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wei Hu <weh@linux.microsoft.com>
Cc: dev@dpdk.org, longli@microsoft.com, weh@microsoft.com
Subject: Re: [PATCH v9 0/1] net/mana: add device reset support
Message-ID: <20260615115028.5fa705c3@phoenix.local>
In-Reply-To: <20260612081723.27699-1-weh@linux.microsoft.com>
References: <20260612081723.27699-1-weh@linux.microsoft.com>
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

On Fri, 12 Jun 2026 01:17:22 -0700
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
> Changes since v8:
> - Fixed reset thread resource leak: previously reset_thread_active
>   was cleared before emitting recovery callbacks, so no join site
>   would reap the thread. Now the flag stays true throughout the
>   thread lifetime. mana_join_reset_thread detects the self-join
>   case (callback calling dev_stop/dev_close from the reset thread)
>   using rte_thread_equal and calls rte_thread_detach instead of
>   join, so thread resources are freed on exit. External callers
>   continue to join normally.
> - Fixed lost condvar signal: added a predicate loop around
>   pthread_cond_timedwait that checks dev_state under
>   reset_cond_mutex. If mana_pci_remove_event_cb signals before
>   the reset thread enters the wait, the wakeup is no longer lost.
>   The PCI remove callback sets dev_state to RESET_FAILED under
>   the same mutex before signaling.
> - Added a lock/unlock barrier on reset_ops_lock in
>   mana_pci_remove_event_cb to ensure teardown has completed
>   before emitting the INTR_RMV event.
> - Fixed mana_reset_exit_delay return type from uint32_t to int
>   to match the negative error codes it stores.
> - Removed unnecessary else-after-goto in mana_probe_port.
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
>   deadlock when interrupt thread and reset thread contend
>=20
> Changes since v2:
> - Added per-queue burst_state atomic variable with Dekker-like
>   synchronization to block data path during reset without RCU
> - Replaced rte_alarm with condvar + control thread for reset exit
> - Made reset_thread_active atomic with CAS =E2=80=94 flag is set by
>   creator and only cleared by the joiner, not the thread itself
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
>  drivers/net/mana/mana.c                | 1088 ++++++++++++++++++++++--
>  drivers/net/mana/mana.h                |   52 +-
>  drivers/net/mana/mp.c                  |   89 +-
>  drivers/net/mana/mr.c                  |    6 +-
>  drivers/net/mana/rx.c                  |   23 +-
>  drivers/net/mana/tx.c                  |   44 +-
>  8 files changed, 1242 insertions(+), 108 deletions(-)
>=20

Looks good, one bit of AI review.
---
The self-join and the condvar wait both look right now. The reset thread ke=
eps
reset_thread_active true for its whole life and mana_join_reset_thread is t=
he
only place that transitions it, using rte_thread_equal to detach on the
self-call and join otherwise, so the thread is reaped exactly once with no =
leak
and no self-join deadlock. The predicate loop under reset_cond_mutex closes=
 the
lost-wakeup window. Reset logic is in good shape.

One small thing in mp.c: in the RESET_EXIT secondary handler the received f=
d is
only closed on the branch that maps it. If proc_priv->db_page is already
non-NULL the fd from the message is leaked. Close it whenever num_fds >=3D =
1,
outside the if/else.
---
I can merge it as is, or you can send a revision to close that minor leak.
