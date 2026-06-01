Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D32CD6E5D
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 16:58:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B340E4042C;
	Mon,  1 Jun 2026 18:58:08 +0200 (CEST)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174]) by mails.dpdk.org (Postfix) with ESMTP id 5C65C402DB
 for <dev@dpdk.org>; Mon,  1 Jun 2026 18:58:07 +0200 (CEST)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-304e83724bfso4438914eec.0
 for <dev@dpdk.org>; Mon, 01 Jun 2026 09:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780333086;
 x=1780937886; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hDRBOaHQVy0HqveOU0zDj+bXhqVE0ZV+EjVN69UNSFU=;
 b=h+oc7SJHGgXutz0U6gsVb8mzKb4fi5aSqtYMnW85Xkd61aGujHbQnjS+pxnQXR/uaL
 sza1B6LqNNFf6tv51t7MbuQiAxzMJU/aiZyPrua7KQn75WJuagIJcDEj7dg91vxJ87xJ
 BkZWTDE3GTetVFxxBVQutqV+2mChGMXJ8EWyT3TFsy/ojFNLs/nf3f2NRTsey6fPvTj3
 knJTEe0BxSa2xd6+hEPEj3iji+ZW3+gWqjIibG1F+3bFuZwANZjgJA9aN2oNmuaTWbaT
 UcamCNjDkk2VZSJ8tTHaPK7DmGpK4d/yrp/c5UhFXipyKKmll0NlIfoPi0DfDLjwE302
 ew+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780333086; x=1780937886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hDRBOaHQVy0HqveOU0zDj+bXhqVE0ZV+EjVN69UNSFU=;
 b=rqKObTXoSe/2Wz8L4e4G95U75zwns1ExdFkVnVAEvXAM/lZ9RGCXbrmD7oOqZ2Bk1w
 YAaEFcddlP0kYzZzGHBrU3WbwRLukzdxK/fMXC3HLwn4QcMiiW6oCwh6mSNYimsykWHb
 3Iq/ju6I1Oy3DIxRHKQjnHKTGUwjls135OdfsgL2UNaCW2bMLgheZBKBzwk4v4mo6kim
 W3YtDCVsIvdDIqE6gRHd2KIEAtjfrVMnfXkOhJnHQIQvWDMgdOsztU0Gr4C7HLHpJEYs
 I6n7zep4StayxHJGbTjFT/RLV2vcrqniR9jNqFf0pHqudWKo2SpUN488KsiQtX5uFRcM
 r++Q==
X-Gm-Message-State: AOJu0YwpZSQynYaMfkdv+Vz6+VnGvqfVqMspD44bPnspk69CjhkEN3pj
 LI1FwC6Wba+e0qtVNuVyotvDFcH3ZdNVFksLuD1zNgtQthSvcfZfNaj51a6lSNi9+AU=
X-Gm-Gg: Acq92OF0yvvmK4EY5DPlTx8ztzmAuCdYr930zG4ZXxGzGFn2rBkWnjoiYbK8b3ZQkeN
 0MWoPQbZ9pCFniwz5/587/1G2i4YUNv5CGV0IiWgQ4DwnoHd6zi8j5NRY7yqHooUBsGDZDmxZBV
 LlNXIJAbjUucJv0nFEMBbsNaUu3kLTZlxAEMj5Wmuh3e7hqoY/oS9kg0ER+wyDOaoiYqRKxEzR/
 GCDKQ6sEnmD9dCuaUf0m2KSBPZlhCtnHVnVYw4Vkq/ZV3nZ5Cl1IhLy6Ls6TQUGOn5PYqdO/E0T
 8u7KTKOvU9sDI3RXjtu1y3JF8zZhCzKu8f+wAwJw4mN+Oe1Mmpo9d2Ny0wyg0z+anB5q/3nAFG4
 ecFAM9BUcCMeeSeTzoXI2NRBdc12wX5TSo08di8O+0Tw4LoRUyc1xx1JIrhzn7MwM21gmfwkIDm
 zbjHyPpBYTtA6oHsIR6tTkxELwsoajocX5EtZWxxBNuYftI4ps/sBw9R+ayLEGgT5OMbSSKgxJs
 mA=
X-Received: by 2002:a05:7301:290e:b0:2d9:f0b3:1d98 with SMTP id
 5a478bee46e88-304fa4b7157mr5614240eec.7.1780333086098; 
 Mon, 01 Jun 2026 09:58:06 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed5d26d1sm9516386eec.30.2026.06.01.09.58.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 09:58:05 -0700 (PDT)
Date: Mon, 1 Jun 2026 09:58:02 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wei Hu <weh@linux.microsoft.com>
Cc: dev@dpdk.org, longli@microsoft.com, weh@microsoft.com
Subject: Re: [PATCH v5 1/1] net/mana: add device reset support
Message-ID: <20260601095802.36cec727@phoenix.local>
In-Reply-To: <20260529142648.148407-2-weh@linux.microsoft.com>
References: <20260529142648.148407-1-weh@linux.microsoft.com>
 <20260529142648.148407-2-weh@linux.microsoft.com>
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

On Fri, 29 May 2026 07:26:48 -0700
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
> A per-device mutex serializes the reset path with ethdev
> operations. The mutex uses PTHREAD_PROCESS_SHARED for multi-process
> support and is held across blocking IB verbs calls. Operations that
> cannot wait (configure, queue setup) return -EBUSY during reset,
> while dev_stop and dev_close join the reset thread before acquiring
> the lock to ensure proper sequencing. A CAS-based helper prevents
> double-join of the reset thread.
> 
> Multi-process support is included: secondary processes unmap and
> remap doorbell pages via IPC during the reset enter and exit
> phases. Data path functions in both primary and secondary
> processes check the device state atomically and return early when
> the device is not active. RCU quiescent state tracking uses
> per-queue thread IDs in shared hugepage memory, covering both
> primary and secondary process data path threads.
> 
> The driver uses ethdev recovery events to notify upper layers
> (e.g. netvsc) of the reset lifecycle: RTE_ETH_EVENT_ERR_RECOVERING
> on entry, RTE_ETH_EVENT_RECOVERY_SUCCESS or
> RTE_ETH_EVENT_RECOVERY_FAILED on completion. A PCI device removal
> event callback distinguishes hot-remove from service reset.
> 
> Documentation for the device reset feature is added in the MANA
> NIC guide and the 26.07 release notes.
> 
> Signed-off-by: Wei Hu <weh@microsoft.com>
> ---

I went a deeper with AI and tried to figure out a good way
to do what the driver is trying to do without reinventing so much.



This reset logic is considerably more complex than other DPDK drivers,
and most of the complexity looks self-inflicted. A few specific things.

The RCU use is not really RCU. thread_online/offline are called on every
rx/tx burst, and the "thread" token is the queue index, not a thread. So
it is a per-queue in-use flag paid for on the hottest path, plus a new
library dependency, to express "wait until no queue is mid-burst" -- which
the driver already half does by swapping the burst function to
mana_*_burst_removed and checking dev_state. Please drop the rcu use. If
you must drain readers, a per-queue atomic flag is lighter and local; the
fast path already has the dev_state acquire-load it needs.

The data path only needs the atomic, and that part is fine. The lock is
legitimate for serializing the teardown/rebuild against control ops, but
the way it is used is the problem: it is acquired in mana_intr_handler,
released in mana_reset_enter, re-acquired in mana_reset_thread, and
released in mana_reset_exit_delay. That cross-function, cross-thread
handoff is exactly why every function needs __rte_no_thread_safety_analysis.
Acquire and release the lock in the same function and the annotations all
go away. Turning off thread-safety analysis needs strong justification and
this does not have it.

Wrapping the ops in MANA_OPS_*_LOCK macros hides the lock/state protocol.
A single explicit helper at the top of each op is just as terse and stays
analyzable.

Two real bugs:

- Recovery and INTR_RMV events are sent via rte_eth_dev_callback_process
  while reset_ops_lock is held. An app handling INTR_RMV or RECOVERY_FAILED
  by calling dev_stop/dev_close will re-enter the lock (non-recursive) and
  deadlock; on the recovery path the callback runs on the reset thread so
  it also tries to join itself. Emit these events after dropping the lock,
  as ERR_RECOVERING already does.

- thread_online is taken at the top of the burst functions but
  thread_offline is only on some return paths. Any early return that
  misses it leaves a token non-quiescent and rte_rcu_qsbr_check() in
  mana_reset_enter spins forever. This is the kind of breakage the per-burst
  bracketing invites -- another reason to drop it.

Also: reset_ops_lock is held across ibv_close_device and the PCI re-probe
(blocking under a sleeping mutex), and rte_alarm.h is included but no
longer used.

Please look at how hns3 or mlx5 structure reset/recovery. Matching the
common pattern means fixes can be made across drivers at once.
