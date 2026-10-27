Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CA7606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 20:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=c8VrIEJM
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 055D340151;
	Tue, 27 Oct 2026 21:50:20 +0100 (CET)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by mails.dpdk.org (Postfix) with ESMTPS id DC212400D7
 for <dev@dpdk.org>; Tue, 27 Oct 2026 21:50:18 +0100 (CET)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-3ab752f6244so337556a91.2
 for <dev@dpdk.org>; Tue, 27 Oct 2026 13:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793134217;
 x=1793739017; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nMEXtm7jg/0qpYsApDw16jaXfMHTTAY/lfmTLOrFJpw=;
 b=c8VrIEJM2zhapmDDoyqopwp0b0T4LmILAH8H87Z9BvYcOdepz+cDSmLDEgn+sSiCPD
 IEHb5OTsMU9VjxRG6XpUKcCnPyPKu2OhRoj/4XQVW8c4Q7xn4xbyOsBvQTI6XkjwCGZV
 ytfH7nrz5XMd0YJPdZw3wP65wqvBP5XDwPZ1dOyDIcEIFWpZxHHlTDWl0p7mwXmBpGni
 z3bxSWWIcuLmX3nQ4Dzy41J41mBdUpQvJSenyKVHvjHOYQ9b+htUNcERvb76WuHSOnrE
 Ql+kT33rjuFlas4X0/9OTj0grLrHSq/ReZRJY6Tlf2gZ/ge5z8wkaiJ+HRB0NVlvb1yo
 qQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793134217; x=1793739017;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nMEXtm7jg/0qpYsApDw16jaXfMHTTAY/lfmTLOrFJpw=;
 b=lxMkuRRKl3vuuMRqG22lKVjZooUh74p8OOkdNpetSNuf9xae0hVYaQiLGM8AGsCVuO
 XICNP1afIc5W7bk3K0Y1JCJg7djHUa7/bI2S1aRhQG/HQV/o+lQPVjArDD8rNGOZvriX
 AFEZBUuVZXN75G4xB81f/nYJ8xZLGjUuQdachWcCvAQv79Qx0jWvwweDGjp2qDEEE8wv
 nXpOtfA+oOmncpjfZt4TTd0mYyKwKqiXP2xBDxtS8o6nkTLSIf/J9IOi1Akf6Er6L0eN
 qByrIFj7LRD56gXF1UFApVQ/Ia28OxKR22Fcw+SXBhnKUBSJzqQjkCm7aZkmDicfIB1J
 ynrg==
X-Gm-Message-State: AFq9FYLDyEr4h6j2Rg8n2fpfI+Lu6NCn6HY8/Iqk+2eHHE26EYXz0jXB
 EovwM/eAx8ooJpLIBJLXnrPuOmpdbmWXiJccRCOohhvsvGXgDPZ/hoGuK0xAmBZyE00=
X-Gm-Gg: AYBFou3j4268SvxIKKCtvOACsQMc6eNvubRodIf6y+GJpYGq4XgoIB2iM834hNqXjMk
 URigDtt0icMd13pEeHNxZkSX/YeKyq8L8l6lqWgrnFUehV5RTiGlCy/RsIZUCnuQPe5BGobc79j
 yUx5yqVTUpc4hx5QeUQRfMX4F3PbEfKCiUS13lj1qIaRxFOEboSFEVCtM+bY0OshDFKECD9iTSl
 kooHhCvjGI4/vK/fuO17aZBn61CXEZ1Usp6es2q5mvDCB/Krble4qYc1SNx02Zqhr8Xm0bblTBR
 NZ4lrpijU8BUTazQ8Mv6sD5XU3lxmRDw5BPNuvYFUUXLOk44WCJ+uVLQ3CAhhnk/ItsZ7Y28Vjx
 Xa1usqpaaMgL4R/Qttd4TT+cmroFNwzV0bWUL2R0wkEo1S9HsSR0OuweQ9iG6KYvEDvGNIHjx9H
 jXs/Qz4mFxKk6QHJ9bca4rQEshkLMdUbW1Vl8SNPzNYGt0wMiCj5E1Ziixx7OAxuh6DR5oGpkcT
 ISMjCUCPjDbcuPsBfMQGzvqun5eSG9HoUM974xjoRMgCCFKr+y4U0d0di4sTRTqf58w0rOX5CwW
 AGXSq7IMY17tcoY5qHXVWw==
X-Received: by 2002:a17:90b:2805:b0:3ac:9f00:3bc7 with SMTP id
 98e67ed59e1d1-3ae580a02bcmr162484a91.33.1793134217130; 
 Tue, 27 Oct 2026 13:50:17 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae578f1619sm410498a91.16.2026.10.27.13.50.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 13:50:16 -0700 (PDT)
Date: Tue, 27 Oct 2026 13:50:12 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Jasper Tran O'Leary" <jtranoleary@google.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 0/9] net/gve: support proactive device reset
Message-ID: <20261027135012.25235518@phoenix.local>
In-Reply-To: <20261027185420.724684-1-jtranoleary@google.com>
References: <20261027185420.724684-1-jtranoleary@google.com>
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
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 27 Oct 2026 18:54:09 +0000
"Jasper Tran O'Leary" <jtranoleary@google.com> wrote:

> This series adds support for proactive device reset
> (RTE_ETH_ERROR_HANDLE_MODE_PROACTIVE) to the GVE driver, replacing the
> existing passive reset implementation. When the device requests a reset,
> the driver now automatically recovers the control plane and recreates RX
> and TX queues without requiring the application to manually reconfigure
> the port.
> 
> To support automatic recovery safely while traffic is running, this
> series:
> - Fixes a pre-existing leak of the flow subsystem on device init
>   failure.
> - Saves RX and TX queue setup parameters and versions queue memzone
>   names by reset generation so queues can be recreated before old queue
>   memory is freed.
> - Defers freeing retired queue memory ("zombie" queues) until after a
>   grace period so concurrent datapath threads can safely drain after
>   packet burst functions are redirected to dummy handlers.
> - Splits device resource setup and teardown into host memory allocation
>   and hardware configuration so host DMA memory can be kept across
>   resets and re-registered with the device.
> - Adds a reset mutex and moves device status polling off the shared DPDK
>   alarm/interrupt thread onto a dedicated control thread.
> - Implements proactive recovery and emits the standard DPDK recovery
>   lifecycle events (RTE_ETH_EVENT_ERR_RECOVERING,
>   RTE_ETH_EVENT_RECOVERY_SUCCESS, and RTE_ETH_EVENT_RECOVERY_FAILED).
> 
> Jasper Tran O'Leary (8):
>   net/gve: free flow subsystem on dev init failure
>   net/gve: snapshot queue configurations
>   net/gve: add deferred queue memory reclamation
>   net/gve: separate device resource alloc and config
>   net/gve: add dedicated mutex for device reset
>   net/gve: add check for device reset to AQ ctrl ops
>   net/gve: implement proactive device reset
>   net/gve: remove unused device reset parameter
> 
> Joshua Washington (1):
>   net/gve: move dev status poller to its own thread
> 
>  doc/guides/nics/gve.rst                |  67 +-
>  doc/guides/rel_notes/release_26_11.rst |   5 +
>  drivers/net/gve/base/gve.h             |   1 +
>  drivers/net/gve/gve_ethdev.c           | 775 ++++++++++++++------
>  drivers/net/gve/gve_ethdev.h           |  87 ++-
>  drivers/net/gve/gve_rx.c               |  36 +-
>  drivers/net/gve/gve_rx_dqo.c           |  36 +-
>  drivers/net/gve/gve_tx.c               |  32 +-
>  drivers/net/gve/gve_tx_dqo.c           |  35 +-
>  9 files changed, 813 insertions(+), 261 deletions(-)
>

Lots of issues in AI review

Subject: Re: [PATCH 0/9] net/gve: proactive device reset

Series applied to main except 7/9, which needs a rebase: the
gve_ethdev.c include context (<rte_cycles.h>) and the reflowed
Device Reset text in gve.rst do not match current main. With the
context fixed up, every commit builds with -Dwerror=true.

The overall approach (snapshot queue config, zombie queues,
generation-suffixed memzones, dedicated poller thread) is reasonable.
The main problems are with the ethdev contracts for rte_eth_dev_reset()
and RTE_ETH_EVENT_RECOVERY_SUCCESS, and with datapath ordering on
weakly ordered CPUs (Axion/Arm instances are a real target for gve).


Errors
------

[PATCH 7/9] net/gve: implement proactive device reset

1. gve_internal_recover_device() calls gve_dev_start() unconditionally.

   - rte_eth_dev_reset() stops the port before calling dev_reset, and
     its documented contract is that the port comes back stopped and
     the application then calls configure/queue_setup/start. With
     this patch the port comes back started, so the application's
     rte_eth_dev_configure() fails with -EBUSY.
   - After 9/9 the poller runs from probe until close, so a
     device-requested reset on a stopped or never-configured port
     sets dev_started = 1 behind the application's back.
   - gve.rst says "Restarts the device (if it was previously
     started)", which the code does not do.

   Record the state on entry and only restart if it was started:

	bool was_started = dev->data->dev_started;
	...
	if (was_started) {
		ret = gve_dev_start(dev);
		...
	}

2. Configuration that RTE_ETH_EVENT_RECOVERY_SUCCESS promises to
   retain is lost. Per rte_ethdev.h, MTU and RSS configuration set
   via rte_eth_dev_rss_* must survive recovery. The recovery path
   frees priv->rss_config and never re-issues set_mtu or
   configure_rss, so the device silently reverts to its defaults.
   Replay dev->data->mtu and the saved RSS key/hash types/RETA
   after gve_configure_device_resources().

3. Flow rule state is left stale. The device loses its rules on
   reset and gve does not advertise RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP,
   but priv->active_flows and the rule-ID bitmap are kept. A later
   rte_flow_destroy() sends a destroy for a rule the device no longer
   has, and rule IDs stay marked in use. Either re-program the rules
   during recovery and set FLOW_RULE_KEEP, or tear down and re-init
   the flow subsystem as the old dev_reset path did.

4. Datapath ordering. The writer does:

	fp_ops.rx_pkt_burst = dummy;
	fence(release);
	dev->data->rx_queues[i] = NULL;

   rte_eth_rx_burst() loads rxq.data[queue_id] and rx_pkt_burst with
   no ordering between them. On Arm a reader can observe the NULL
   queue pointer together with the old gve_recv_pkts, and dereference
   NULL. A release fence on the writer side alone does not help.

   Do not store NULL into the live queue array during recovery. Build
   the new queue first, then publish it with a single store and hand
   the old one to the zombie list. Any reader then sees either the old
   (still mapped) queue or the new one. That needs an internal setup
   variant that does not call gve_rx_queue_release() on the existing
   slot.

5. Failed recovery leaves the port in a state that crashes later.
   recover_fail frees the admin queue and NULLs all queues but leaves
   dev_started set. A subsequent rte_eth_dev_stop() goes to
   gve_stop_tx_queues(), which issues destroy_tx_queues over the freed
   admin queue, then gve_tx_queue_stop() which passes a NULL txq to
   gve_release_txq_mbufs(). Clear dev_started on failure and make
   stop/close tolerate !gve_get_admin_queue_ok() and NULL queues.


[PATCH 9/9] net/gve: move dev status poller to its own thread

6. Lost update on state_flags. rte_bit_relaxed_set32/clear32 are
   plain read-modify-write on a shared word. The poller thread
   updates DEVICE_RESOURCES_OK, ADMIN_QUEUE_OK and DEVICE_RINGS_OK
   during recovery while gve_dev_close() clears STATUS_POLLER_OK from
   the application thread. If they overlap, the poller can write back
   a stale word with STATUS_POLLER_OK still set; the loop never exits
   and rte_thread_join() in close hangs. The fences around the relaxed
   bit ops do not make the RMW atomic.

   Use a separate flag:

	RTE_ATOMIC(bool) dev_status_poller_run;

	rte_atomic_store_explicit(&priv->dev_status_poller_run, false,
				  rte_memory_order_release);
	...
	while (rte_atomic_load_explicit(&priv->dev_status_poller_run,
					rte_memory_order_acquire))


Warnings
--------

[PATCH 2/9] net/gve: snapshot queue configurations

7. Memzone names grow without bound. rte_eth_dma_zone_reserve()
   builds "eth_p%d_q%d_%s" in a 32-byte buffer. With
   "rx_compl_ring_g%u", a 3-digit port and queue already reach the
   limit at reset_generation >= 100, after which setup fails with
   ENAMETOOLONG and recovery fails. Since gve_add_zombie_*_queue()
   frees any older zombie for the same queue id, only two generations
   are ever live; use (reset_generation & 1) and shorter names
   ("rxc_g%u").

8. rxq_configs/txq_configs (and zombie_rx/tx_queues in 3/9) are
   CPU-only bookkeeping used by the primary. Use calloc()/free()
   instead of rte_zmalloc().

[PATCH 3/9] net/gve: add deferred queue memory reclamation

9. zombie_lock and zombie_next are never used. Drop them.

[PATCH 5/9] net/gve: add dedicated mutex for device reset

10. PTHREAD_MUTEX_RECURSIVE is set on the shared mutexattr, so
    flow_rule_lock and nic_ts_lock silently become recursive too.
    Recursion is only needed because recovery calls gve_dev_start()
    with reset_lock held. Split out an unlocked helper and keep the
    mutex non-recursive:

	static int gve_dev_start_locked(struct rte_eth_dev *dev);

	static int
	gve_dev_start(struct rte_eth_dev *dev)
	{
		...
		pthread_mutex_lock(&priv->reset_lock);
		ret = gve_dev_start_locked(dev);
		pthread_mutex_unlock(&priv->reset_lock);
		return ret;
	}

[PATCH 7/9] net/gve: implement proactive device reset

11. The driver no longer raises RTE_ETH_EVENT_INTR_RESET. Existing
    applications that registered for it will stop receiving it. Say
    so in the release note entry, not just in gve.rst.

12. Commit message says recovery runs in a "dedicated control
    recovery thread"; in this patch it runs from the EAL alarm
    callback. The thread only appears in 9/9. Also "supercedes" ->
    "supersedes".

[PATCH 9/9] net/gve: move dev status poller to its own thread

13. gve_dev_reset() calls gve_stop_dev_status_polling() without
    checking gve_get_dev_status_poller_ok(). If thread creation
    failed at probe, rte_thread_join() is called on an uninitialized
    rte_thread_t. Check the flag as gve_dev_close() does.
