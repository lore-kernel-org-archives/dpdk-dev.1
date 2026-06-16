Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BB1CD98E1
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 12:32:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 643EC40289;
	Tue, 16 Jun 2026 14:32:14 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id C9C564026A
 for <dev@dpdk.org>; Tue, 16 Jun 2026 14:32:12 +0200 (CEST)
Received: from alhe-weh-mana-dpdk-s2.corp.microsoft.com (unknown
 [167.220.2.160])
 by linux.microsoft.com (Postfix) with ESMTPSA id 76BF820B716A;
 Tue, 16 Jun 2026 05:31:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 76BF820B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1781613110;
 bh=9rSeCbjKbQQZIz4DdCJlX8s+MWE/IX5AR1WcYpQppPw=;
 h=From:To:Cc:Subject:Date:From;
 b=VysuW9KaKzvp2LM+wcIb0skuuUVkD+5q+3CeqSg41kUTTCM/gQIX9tqshrH4SG2CB
 gFdoMtdbRH8eIYLH3N/ztp4J8E0+Ey6YMRqQMtOM5da7LPC6ZaOJ4Wcjs5/6kCB4B1
 rSR1KToRRXCYv3YWxPq3gkK5Z05QftjNiN+PHtwE=
From: Wei Hu <weh@linux.microsoft.com>
To: dev@dpdk.org,
	stephen@networkplumber.org
Cc: longli@microsoft.com,
	weh@microsoft.com
Subject: [PATCH v10 0/1] net/mana: add device reset support
Date: Tue, 16 Jun 2026 05:31:57 -0700
Message-Id: <20260616123158.43583-1-weh@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

From: Wei Hu <weh@microsoft.com>

Add support for handling hardware service reset events in the
MANA driver. When the MANA kernel driver receives a hardware
service event, it initiates a device reset and notifies userspace
via IBV_EVENT_DEVICE_FATAL. The MANA PMD handles this by
performing an automatic teardown and recovery sequence.

The driver uses ethdev recovery events (ERR_RECOVERING,
RECOVERY_SUCCESS, RECOVERY_FAILED) to notify upper layers of
the reset lifecycle, and a PCI device removal event callback
to distinguish hot-remove from service reset.

Changes since v9:
- Fixed fd leak in the secondary RESET_EXIT IPC handler: when
  the doorbell page was already mapped, the fd from the message
  was not closed. Moved close(fd) outside the if/else so it runs
  unconditionally whenever an fd is present.

Changes since v8:
- Fixed reset thread resource leak: previously reset_thread_active
  was cleared before emitting recovery callbacks, so no join site
  would reap the thread. Now the flag stays true throughout the
  thread lifetime. mana_join_reset_thread detects the self-join
  case (callback calling dev_stop/dev_close from the reset thread)
  using rte_thread_equal and calls rte_thread_detach instead of
  join, so thread resources are freed on exit. External callers
  continue to join normally.
- Fixed lost condvar signal: added a predicate loop around
  pthread_cond_timedwait that checks dev_state under
  reset_cond_mutex. If mana_pci_remove_event_cb signals before
  the reset thread enters the wait, the wakeup is no longer lost.
  The PCI remove callback sets dev_state to RESET_FAILED under
  the same mutex before signaling.
- Added a lock/unlock barrier on reset_ops_lock in
  mana_pci_remove_event_cb to ensure teardown has completed
  before emitting the INTR_RMV event.
- Fixed mana_reset_exit_delay return type from uint32_t to int
  to match the negative error codes it stores.
- Removed unnecessary else-after-goto in mana_probe_port.

Changes since v7:
- Moved heavy teardown (dev_stop, IPC to secondaries, dev_close,
  MR btree free) from mana_reset_enter (EAL interrupt thread)
  to mana_reset_thread (control thread). The interrupt handler
  now only sets state, drains in-flight bursts, and spawns the
  thread. Teardown runs immediately in the control thread before
  the recovery timer wait, avoiding blocking the interrupt thread
  on multi-second IPC timeouts and ibverbs calls. Each function
  now owns its own lock scope with no lock hand-off between
  threads.
- Simplified burst_state from encoding device state in bits 1+
  to a single blocked flag (bit 1). Only one value was ever
  stored, so the multi-state encoding was misleading. Added
  MANA_BURST_BLOCKED constant.
- Updated mana.rst to reflect that teardown runs on the control
  thread, not the interrupt handler.

Changes since v6:
- Rebased onto latest upstream for-main
- Replaced removed RTE_ETH_DEV_TO_PCI macro with
  RTE_CLASS_TO_BUS_DEVICE (upstream commit 4757b8df04
  removed the old bus-specific ethdev convenience macros)

Changes since v5:
- Replaced RCU QSBR with per-queue atomic burst_state using a
  single-variable CAS design: bit 0 is the in-burst flag, bit 1
  is the blocked flag. The data path uses CAS(0→1) to enter
  burst and fetch_and(~1) to exit. The reset path uses fetch_or
  to set the blocked bit and polls bit 0 to drain in-flight
  bursts. This eliminates the two-variable Dekker pattern and the
  need for sequential consistency (seq_cst) ordering.
- Removed librte_rcu dependency
- Removed __rte_no_thread_safety_analysis annotations (no longer
  needed after mutex conversion)
- Moved ERR_RECOVERING event emission before acquiring
  reset_ops_lock and before mana_reset_enter, so upper layers
  (e.g. netvsc) can switch data path before mana stops queues.
  Emitting outside the lock avoids deadlock if the callback
  calls dev_stop or dev_close.
- Replaced MANA_OPS_*_LOCK macros with mana_reset_trylock()
  helper function and explicit per-operation wrappers
- Removed unused rte_alarm.h and rte_lock_annotations.h includes
- Added RECOVERY_FAILED event when mana_reset_enter fails
  internally, so the application always receives a terminal event
- Added mana_clear_burst_state() helper to clear per-queue
  burst_state on failure paths (reset_failed, dev_stop_lock,
  dev_close_lock) preventing permanent silent packet drop after
  a failed reset

Changes since v4:
- Fixed stale rte_spinlock_unlock call in mana_intr_handler that
  was missed during the spinlock-to-mutex conversion, causing a
  -Wincompatible-pointer-types warning

Changes since v3:
- Converted reset_ops_lock from rte_spinlock_t to pthread_mutex_t
  with PTHREAD_PROCESS_SHARED, since the lock is held across
  blocking IB verbs calls and IPC with 5s timeout
- Removed rte_dev_event_callback_unregister retry loop to avoid
  deadlock when interrupt thread and reset thread contend

Changes since v2:
- Added per-queue burst_state atomic variable with Dekker-like
  synchronization to block data path during reset without RCU
- Replaced rte_alarm with condvar + control thread for reset exit
- Made reset_thread_active atomic with CAS — flag is set by
  creator and only cleared by the joiner, not the thread itself
- Fixed second reset crash: removed reset thread join logic from
  mana_dev_close (inner function) to avoid corrupting dev_state
  when called from mana_reset_enter
- Made reset_thread_active RTE_ATOMIC(bool) with explicit ordering
- Added retry loop for rte_dev_event_callback_unregister on -EAGAIN
- Initialized condvar/mutex with PTHREAD_PROCESS_SHARED since priv
  is in hugepage shared memory
- Added re-check of dev_state after lock acquisition in
  mana_intr_handler to prevent racing with pci_remove_event_cb
- Replaced (void *)0 with NULL in mp.c
- Added lock ownership comment block at mana_reset_enter
- Documented rte_dev_event_monitor_start() requirement
- Added mana.rst documentation and release note

Changes since v1:
- Removed net/netvsc patch from this series
- Simplified reset exit: mana_reset_exit calls
  mana_reset_exit_delay directly instead of spawning a thread
- Added __rte_no_thread_safety_analysis annotations for clang
- Switched to rte_thread_create_internal_control
- Fixed declaration-after-statement style issues
- Removed unnecessary blank lines and stale comments

Wei Hu (1):
  net/mana: add device reset support

 doc/guides/nics/mana.rst               |   40 +
 doc/guides/rel_notes/release_26_07.rst |    8 +
 drivers/net/mana/mana.c                | 1088 ++++++++++++++++++++++--
 drivers/net/mana/mana.h                |   52 +-
 drivers/net/mana/mp.c                  |   92 +-
 drivers/net/mana/mr.c                  |    6 +-
 drivers/net/mana/rx.c                  |   23 +-
 drivers/net/mana/tx.c                  |   44 +-
 8 files changed, 1245 insertions(+), 108 deletions(-)

-- 
2.34.1

