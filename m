Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2179DCD4F5B
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 07:00:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 21841402A2;
	Fri, 22 May 2026 09:00:09 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id EA47C4029F
 for <dev@dpdk.org>; Fri, 22 May 2026 09:00:07 +0200 (CEST)
Received: from alhe-weh-mana-dpdk-s2.corp.microsoft.com (unknown
 [131.107.1.160])
 by linux.microsoft.com (Postfix) with ESMTPSA id 76A2820B7167;
 Thu, 21 May 2026 23:59:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 76A2820B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1779433198;
 bh=citkLQGPrTlVXPyCt26C3+++GbQetKAeBt5br+E0EDQ=;
 h=From:To:Cc:Subject:Date:From;
 b=nwJR0xepXSgTweODcSSM99Xah3aO+fO/VAIVeKKGn4ZJgor1cyqsTtESAYOQGbxwb
 P2+/jxPWrBFG+lX6aLCrchHzqeYkFmxyu29pXz5erTPj2eCz+5XYs4SdVpRWgv4KOz
 FRp8yvwnS0j+HHnhDMliKhB6PNch8NMh5c+8R4qU=
From: Wei Hu <weh@linux.microsoft.com>
To: dev@dpdk.org,
	stephen@networkplumber.org
Cc: longli@microsoft.com,
	weh@microsoft.com
Subject: [PATCH v3 0/2] net/mana: add device reset support
Date: Thu, 21 May 2026 23:59:41 -0700
Message-Id: <20260522065943.126703-1-weh@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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
- Added mana.rst documentation and release note (patch 2/2)

Changes since v1:
- Removed net/netvsc patch from this series
- Simplified reset exit: mana_reset_exit calls
  mana_reset_exit_delay directly instead of spawning a thread
- Added __rte_no_thread_safety_analysis annotations for clang
- Switched to rte_thread_create_internal_control
- Fixed declaration-after-statement style issues
- Removed unnecessary blank lines and stale comments

Wei Hu (2):
  net/mana: add device reset support
  net/mana: add documentation for device reset support

 doc/guides/nics/mana.rst               |  33 +
 doc/guides/rel_notes/release_26_07.rst |   8 +
 drivers/net/mana/mana.c                | 995 ++++++++++++++++++++++---
 drivers/net/mana/mana.h                |  33 +-
 drivers/net/mana/meson.build           |   2 +-
 drivers/net/mana/mp.c                  |  89 ++-
 drivers/net/mana/mr.c                  |   6 +-
 drivers/net/mana/rx.c                  |  24 +-
 drivers/net/mana/tx.c                  |  40 +-
 9 files changed, 1123 insertions(+), 107 deletions(-)

-- 
2.34.1

