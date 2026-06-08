Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2027ACD8C9F
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 12:08:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDB41402AD;
	Mon,  8 Jun 2026 14:08:37 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 141B340265
 for <dev@dpdk.org>; Mon,  8 Jun 2026 14:08:36 +0200 (CEST)
Received: from alhe-weh-mana-dpdk-s2.corp.microsoft.com (unknown
 [167.220.2.160])
 by linux.microsoft.com (Postfix) with ESMTPSA id 4C9E420B7166;
 Mon,  8 Jun 2026 05:08:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4C9E420B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1780920498;
 bh=z25rz7Br5JFR5g/w/ZslRZhjzfkMPf7fu0xgkDiC63g=;
 h=From:To:Cc:Subject:Date:From;
 b=tGC21nDLTZMKNG1CdXCrnKdZODzGTZ9ph6mXiOu98a6BThTTvE4kUf1r3UtG+jw3m
 zuDSVkKuECU8qP7UOYcYDFjL0ghyKzkA5RGNzQ1BYZW0lTQ7W0JegJDr4Fsdrl+Zh9
 5S9yk6GTTjum8NXoLDPxjMsiYnWGz+5MRTlTqIks=
From: Wei Hu <weh@linux.microsoft.com>
To: dev@dpdk.org,
	stephen@networkplumber.org
Cc: longli@microsoft.com,
	weh@microsoft.com
Subject: [PATCH v7 0/1] net/mana: add device reset support
Date: Mon,  8 Jun 2026 05:08:23 -0700
Message-Id: <20260608120824.287050-1-weh@linux.microsoft.com>
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

Changes since v6:
- Rebased onto latest upstream for-main
- Replaced removed RTE_ETH_DEV_TO_PCI macro with
  RTE_CLASS_TO_BUS_DEVICE (upstream commit 4757b8df04
  removed the old bus-specific ethdev convenience macros)

Changes since v5:
- Replaced RCU QSBR with per-queue atomic burst_state using a
  single-variable CAS design: bit 0 is the in-burst flag, bits
  1+ encode device state. The data path uses CAS(0→1) to enter
  burst and fetch_and(~1) to exit. The reset path uses fetch_or
  to set state bits and polls bit 0 to drain in-flight bursts.
  This eliminates the two-variable Dekker pattern and the need
  for sequential consistency (seq_cst) ordering.
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
  deadlock: the callback itself blocks on reset_ops_lock, so
  retrying on -EAGAIN while holding the lock is a deadlock
- Introduced mana_join_reset_thread() helper using CAS on
  reset_thread_active to prevent double-join undefined behavior
- Added reset thread join in mana_dev_uninit to prevent thread
  leak on device removal
- Fixed ibv handle leak: priv->ib_ctx is now only set to NULL
  after ibv_close_device succeeds
- Fixed misleading "All secondary threads are quiescent" log in
  mana_mp_reset_enter — changed to "Secondary doorbell pages
  unmapped" since actual quiescence is enforced by the primary's
  per-queue atomic flag check before IPC is sent
- Changed event list in mana.rst to RST definition list style
- Squashed documentation into the feature patch per convention

Changes since v2:
- Fixed dev_state_qsv memory leak on device removal
- Fixed reset thread TCB/stack leak: reset_thread_active is now
  only cleared by the joiner, not the thread itself
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

 doc/guides/nics/mana.rst               |   39 +
 doc/guides/rel_notes/release_26_07.rst |    8 +
 drivers/net/mana/mana.c                | 1049 ++++++++++++++++++++++--
 drivers/net/mana/mana.h                |   46 +-
 drivers/net/mana/mp.c                  |   89 +-
 drivers/net/mana/mr.c                  |    6 +-
 drivers/net/mana/rx.c                  |   23 +-
 drivers/net/mana/tx.c                  |   44 +-
 8 files changed, 1196 insertions(+), 108 deletions(-)

-- 
2.34.1

