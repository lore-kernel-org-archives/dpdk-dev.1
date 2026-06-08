Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FEFCD6E79
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 19:11:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3F96402AD;
	Mon,  8 Jun 2026 21:11:40 +0200 (CEST)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com
 [209.85.128.176])
 by mails.dpdk.org (Postfix) with ESMTP id EB2504029D
 for <dev@dpdk.org>; Mon,  8 Jun 2026 21:11:39 +0200 (CEST)
Received: by mail-yw1-f176.google.com with SMTP id
 00721157ae682-7efac480dc6so23332207b3.2
 for <dev@dpdk.org>; Mon, 08 Jun 2026 12:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780945899;
 x=1781550699; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cBToileUUCpFJNhKg/aReo28ZWYz3E5ct19eHv4Hqxc=;
 b=Z4FRyafO275Jur7DlbKWBmHJ7gNkLzh6h7VgLWEOnem0Mhi0KVjgXirp+Qh4qaX0SD
 +iyokvKNrvcr619hDosDUwAlXe59d/ZZUBYTRB487/syBW+GNiKhXyN39mQHNRYhjBsF
 8Ya7wiYHXtn3UbsxnGI3DYy/XJwwWkoVQOix6Ab2/ALMyaH0hRPhdyPtOyETOaOADjYU
 hEQquKtp0aSFgH1m9r4Ze8FdzeUJQ5BBa/hTJ0zR5TunnN7FQwPXweCs8fFx/u+Jb6a7
 BBj7EDstlGGy5m3/HJdvmtCiC2mpxejuORNFmKTvDpSAUwtCgGSvij0O37oJ8sR6oi1c
 xE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780945899; x=1781550699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cBToileUUCpFJNhKg/aReo28ZWYz3E5ct19eHv4Hqxc=;
 b=dvZ2gK0aUj5jQsFuHSCCdeuGY1pvTKhwUw7twN7lintbLoRNBD7Tjthk3a48W4E0+P
 m9O6II3wrtB6hbX48A0GWGMN2/eG8WwxPnAuy+rnK+65GHFIUQKAypE37VHQm5grKnMd
 kF7JvAc0WU8G3nvjhUkkPCCPkBY4D4J5YKAo0ZCaiSRjVZKbs6W5oA7JDAd5TqTwIy2g
 G/xMh6Y3ymnyFrH/C9eTr/dRej/xIJqVNU6x0SO7lkXG6nC6Mm9sYhK3pfqQv6KryeJa
 Hi+KuO7+tB19p9J3czC4sNs9NxIob+gEsswtfE+o+t0n4adNJrOXPIfhbi2FgQ1/7qeH
 Sgmg==
X-Gm-Message-State: AOJu0YzZqh/oa8dDgALlFdy8xWJKzvr6rWYtpRERhck2gnrq220ugSJk
 2zdutvf5mKFBOfgYSs6oLSByycRSj7uG3WClxlrtDgyL7S3umfXuIMV0OhE71bJnEUk=
X-Gm-Gg: Acq92OF5cm65ATsoxD0uR4BKfjHL57FNkVSbXf3BzQPt1t+gGisBVke+nqJr8DEJnTt
 16lwdftY813xMepY03WoCi4mhj0L2qq0lvCnY41xhbTkQU41ovPmDpv5h7MESNT4YIVLCPxvCXS
 lbn0XT6RXcchM3HCxZvHfgFuzbXgKCCc1Goolk2riwimgjnCBIgUvPADR0KpZyiCM9w1FjWOmpl
 KprlA/eE6rruQV+AM9LqnLhg/vLuGGUdA8Zor7nPNe9MLTQxZP3u2aVwAMu1x6D77vjziOP8LI/
 Smf04ygC0HKwGcT0GVp/iJQrz4RuqNW22HKUVjZtf4fIbXvKXZyck6pkCji+S3TvrFs3qlLtuwq
 aW9EGsLO4YCbiQ6ms7bsFI8INXpSdGX2MnENbAxJVn/JDNVI7JJ+DTPujS1jH8VISyBXOy6eAPs
 7StsXwuxJd8V03mr7rm7Xok1BQTrkSDz7rmqiyMyeAu+aEblAOrE3SmfKDbxPPfnSThDxxKJ0VJ
 DY=
X-Received: by 2002:a05:690c:6991:b0:7db:ccda:a40c with SMTP id
 00721157ae682-7ed0e6710c9mr161366857b3.18.1780945899031; 
 Mon, 08 Jun 2026 12:11:39 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7ea23a97729sm88606097b3.36.2026.06.08.12.11.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 12:11:38 -0700 (PDT)
Date: Mon, 8 Jun 2026 12:11:34 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wei Hu <weh@linux.microsoft.com>
Cc: dev@dpdk.org, longli@microsoft.com, weh@microsoft.com
Subject: Re: [PATCH v7 1/1] net/mana: add device reset support
Message-ID: <20260608121134.601e4f46@phoenix.local>
In-Reply-To: <20260608120824.287050-2-weh@linux.microsoft.com>
References: <20260608120824.287050-1-weh@linux.microsoft.com>
 <20260608120824.287050-2-weh@linux.microsoft.com>
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

On Mon,  8 Jun 2026 05:08:24 -0700
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
> waits for data path threads to drain using per-queue atomic flags,
> stops queues, tears down IB resources, and frees per-queue MR
> caches. A control thread is then spawned to handle the exit phase:
> it waits for the hardware to recover, unregisters the interrupt
> handler, re-probes the PCI device, reinitializes MR caches, and
> restarts queues.
> 
> Each queue has an atomic burst_state variable where bit 0 is the
> in-burst flag and bits 1+ encode device state. The data path uses
> a single compare-and-swap (0 to 1) to enter a burst, which fails
> immediately if the reset path has set any state bits. The reset
> path sets state bits via atomic fetch-or and polls bit 0 to wait
> for in-flight bursts to drain. This single-variable design avoids
> the need for sequential consistency ordering.
> 
> A per-device mutex serializes the reset path with ethdev
> operations. The mutex uses PTHREAD_PROCESS_SHARED for multi-process
> support and is held across blocking IB verbs calls. A trylock
> helper encapsulates the lock acquisition and device state check
> for all ethdev operation wrappers. Operations that cannot wait
> (configure, queue setup) return -EBUSY during reset, while
> dev_stop and dev_close join the reset thread before acquiring
> the lock to ensure proper sequencing. A CAS-based helper prevents
> double-join of the reset thread.
> 
> Multi-process support is included: secondary processes unmap and
> remap doorbell pages via IPC during the reset enter and exit
> phases. Data path functions in both primary and secondary
> processes check the device state atomically and return early when
> the device is not active.
> 
> The driver emits RTE_ETH_EVENT_ERR_RECOVERING before entering the
> reset path so that upper layers (e.g. netvsc) can switch their
> data path before queues are stopped. The event is emitted outside
> the reset lock to avoid deadlock if the callback calls dev_stop or
> dev_close. On completion, the driver emits RECOVERY_SUCCESS or
> RECOVERY_FAILED. If the enter phase fails internally,
> RECOVERY_FAILED is sent immediately so the application receives a
> terminal event. A PCI device removal event callback distinguishes
> hot-remove from service reset.
> 
> Documentation for the device reset feature is added in the MANA
> NIC guide and the 26.07 release notes.
> 
> Signed-off-by: Wei Hu <weh@microsoft.com>
> ---

This is is a rather complex set of state transitions so admit to relying
on AI as backup for tracking this. It still sees some errors here.

Worth asking the question, "what does mlx5 do?" and "should DPDK
EAL be doing this at the PCI layer instead?"

---

Much better - this addresses the RCU, the macros, the thread-safety-analysis
suppressions, and the callback-under-lock deadlock. The single-variable
burst_state CAS is a clean way to do the drain and the acquire/release
reasoning checks out.

One structural thing remains. The enter phase still runs the heavy teardown
on the EAL interrupt thread under reset_ops_lock: dev_stop, then
mana_mp_req_on_rxtx(RESET_ENTER) which is a blocking rte_mp_request_sync with
a multi-second timeout, then dev_close with its ibv calls. You already moved
the exit phase to a control thread because intr_callback_unregister cannot run
on the interrupt thread; the same argument applies to blocking IPC and verbs
teardown. A slow or absent secondary will stall the interrupt thread for the
MP timeout, and this is the blocking-under-a-sleeping-mutex pattern. Please
have the interrupt handler just set state and drain, then hand the rest of the
teardown to the control thread. That also removes the last lock hand-off
between functions/threads, so each function can own its lock.

Smaller points:
- RECOVERY_SUCCESS/FAILED are emitted from the reset thread. If the callback
  calls dev_stop/dev_close, mana_join_reset_thread() joins the current thread
  (EDEADLK, leaked handle). INTR_RMV is fine since it runs on the dev-event
  thread.
- The burst_state comment says bits 1+ encode device state, but only
  RESET_ENTER<<1 is ever stored - it is effectively a single "blocked" flag.
