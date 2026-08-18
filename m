Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59348C5DF74
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 14:07:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B26A402E3;
	Tue, 18 Aug 2026 16:07:27 +0200 (CEST)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTP id EC31740294
 for <dev@dpdk.org>; Tue, 18 Aug 2026 16:07:25 +0200 (CEST)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-84eb992a881so3614784b3a.2
 for <dev@dpdk.org>; Tue, 18 Aug 2026 07:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787062045;
 x=1787666845; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1dt13QbLvBFE5b9nDyg3Vaa3wbYbeXcBl0h2eS5S7xE=;
 b=YwKqeqpHZlsbx7XO29cXdSfBCc7U3K3S93bkZ/1E2fmlgEJ34HNF00w6jrrCHZuzxw
 c6L7kPiO89RXat+CrQ7CXftTXJZ1i3Tz/EKV7LOreOKQa2T/RgwaZR2QbCN9ah9OACtD
 XvaEQQkdB0mtOVSZI7VzzWaIcDIfu5JLs17+cC7XhWhWymwH7CUinayByNtE4DR3RmtY
 vms30JvPcdfMnH1qsjUw1pZnJZKkjnZp7xcmW1NSaXqvgheKTXofDaHPsSz2FFHRJaLD
 DZrBUX5n1Lkx6Tz6f0gKASEz92Wms24fo6u/SkrdAXc5pTWIH4iTesBpi66q6pn/3GkT
 Fwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787062045; x=1787666845;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1dt13QbLvBFE5b9nDyg3Vaa3wbYbeXcBl0h2eS5S7xE=;
 b=Z0P2sjKpngZwtqrAIZxKV1kPZ8KlOYTfZzUuCSoocHNdFurQV+RgvYJ6wdtPN8qR5J
 KJCHZWDwfKAU5yM8h/wK/li0LGa3YNha7gUUbGB0MZv9TYdffBa9FRald8Q3J9GVQOAj
 iclja0C6cAQ5WK9Eyar8VIKwGAQgiTkxlQ85PQNoyHSr2txeBgZZwlwi6k7fENVy3RUY
 oo3dz5nMNGdOT7jXMXnN95DS2sYRIVUK/c8ImRajG0QjpE2bCH9Whdr8pjESzvnbYg3/
 0xfw58AV4ndX+aY1FE4UyB+QjwI7qJrYjCbnQZ0hnL/Qn9+Nb6uce9IknsB6vODHlonZ
 v4iQ==
X-Gm-Message-State: AOJu0YxQO0LduCSUsFF9aQsI05n6rvWq4cy4u0pu0p2DjZwKkliT9A9C
 UIbdOX+TQeYvfTE0up0d9mEddfautYc27QUfRNJGcH2V1OMl5GrKxZKI9bpWSZCyxMQ=
X-Gm-Gg: AR+sD11Qcc2e6BQoE8V48zh3baHHR/V0HiHrne0HuFpFyW32OmQdfr4qrgDB69iQbsP
 j7vMTxJd7qY8OHVob/2T4qH+DpRdwlolbg7ZpIaT2dMlJ3dHWRCIo9/kOZDWsvEYXPbvZB2cPKl
 HMaPh5o5oAL0lH/1Gux/yrtVyI9xodNtssm+Tc7Ss1D4gcLe1c/wA3neFhtN340m6ahs1HucH9q
 oN8Lm8SPFxOoGY3JOvX2i9O4EtPRcmT9G7rBq0vWbbZFaY2RJL7n/b+Av5NfpDMHcZdZpCQyl+e
 dWQAEOrdghUUutrqQ3roypeULy2eUlQwgHOp5uY4nMPrilxK7n0cWWuPDiYZ7eGSVSW+Ex1qvhD
 N7E4qEF8va0YAIBmKvgjno6+yrPuxWaf081ljjN0Ek7yl1dgHOgeTiKhYGIfJMf4dWuA/sevnjc
 yNWA9QpNxpyk3qrWmaF4I3fxkAY2XsVGVp45/PO1MiXs0kx8NYfUcnzNs2yYi0bcn5t+hmZwaV4
 z1g7BCIEE2Bgw56HCUHsaOmvcX26NoOZGgd1UC0
X-Received: by 2002:a05:6a00:2446:b0:84f:77cc:63cd with SMTP id
 d2e1a72fcca58-84fde13bf81mr33351225b3a.17.1787062044765; 
 Tue, 18 Aug 2026 07:07:24 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851c19fe5d3sm735217b3a.57.2026.08.18.07.07.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 07:07:24 -0700 (PDT)
Date: Tue, 18 Aug 2026 07:07:15 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: sandeep.penigalapati@intel.com
Cc: dev@dpdk.org, Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan
 <mtahhan@redhat.com>, stable@dpdk.org
Subject: Re: [PATCH v3] net/af_xdp: fix shared UMEM refcount corruption
Message-ID: <20260818070715.055cbc61@phoenix.local>
In-Reply-To: <20260817161301.54049-1-sandeep.penigalapati@intel.com>
References: <20260814215107.114582-1-sandeep.penigalapati@intel.com>
 <20260817161301.54049-1-sandeep.penigalapati@intel.com>
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

On Mon, 17 Aug 2026 12:13:01 -0400
sandeep.penigalapati@intel.com wrote:

> From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
> 
> Shared UMEM is meant to be shared by a limited number of sockets,
> governed by the mempool size (max_xsks). When the UMEM was already at
> capacity (refcnt >= max_xsks), xdp_umem_configure() returned the UMEM
> without incrementing its refcount, so the extra socket used it
> unaccounted for.
> 
> This missing reference has two consequences. During queue setup the
> fill-queue reservation is chosen from the refcount, so the sharing
> socket reserves into its own uninitialised fill queue and crashes. At
> close, the under-counted refcount reaches zero while the UMEM is still
> in use, freeing it early and causing a use-after-free.
> 
> Reject sharing once the UMEM is at capacity by returning NULL, so queue
> setup fails cleanly with -ENOMEM. This applies the per-mempool socket
> limit that shared UMEM was always intended to respect.
> 
> Harden the failure path this makes reachable: clear rxq->umem and its
> paired txq->umem when xsk_configure() fails, and skip queues whose UMEM
> is not yet set in get_shared_umem(), so a later scan over the same
> mempool cannot dereference a NULL or dangling UMEM.
> 
> Also document the shared mempool sizing requirement (4096 mbufs per
> socket).
> 
> Note: on stable branches this is a behaviour change. Shared-UMEM setups
> that previously appeared to start, until the fill-queue crash or the
> use-after-free at close, now fail cleanly at Rx queue setup with
> -ENOMEM.
> 
> Fixes: 74b46340e2d4 ("net/af_xdp: support shared UMEM")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
> ---

AI still spots errors on this patch. It can be wrong, but it
does seem to track error paths well.

Review of [PATCH v3] net/af_xdp: fix shared UMEM refcount corruption

The core fix is right: returning NULL once refcnt >= max_xsks removes
both the unaccounted reference and the bogus reserve_before decision
that followed from it.  Fixes: tag resolves to 74b46340e2d4
("net/af_xdp: support shared UMEM"), so Cc: stable is appropriate.

Findings below are against the tree with the patch applied.


Error
-----

1. drivers/net/af_xdp/rte_eth_af_xdp.c, xsk_configure()

   The fq_bufs allocated before socket creation are leaked on the
   error paths this patch is hardening.

   In the shared case reserve_before is false, so the 2048 mbufs
   obtained by rte_pktmbuf_alloc_bulk() are not handed to
   reserve_fill_queue() until after the socket exists:

	ret = rte_pktmbuf_alloc_bulk(rxq->umem->mb_pool, fq_bufs,
				     reserve_size);
	...
	if (reserve_before) { ... }          /* skipped when sharing */
	...
	ret = load_custom_xdp_prog(...);
	if (ret)
		goto out_umem;               /* fq_bufs leaked */
	...
	ret = create_shared_socket(...);
	if (ret)
		goto out_umem;               /* fq_bufs leaked */

	if (!reserve_before)
		ret = reserve_fill_queue(...);

   reserve_fill_queue_zc() frees the array itself when it fails, and
   the reserve_before path therefore cleans up, but out_umem does not.
   Every sharing socket that fails to bind leaks a full burst of
   mbufs back out of the shared mempool, which is the same mempool
   whose size now decides max_xsks.

   Suggest freeing them at out_umem, guarded so the buffers are not
   freed twice:

	out_xsk:
		xsk_socket__delete(rxq->xsk);
	out_umem:
		if (!reserve_before)
			rte_pktmbuf_free_bulk(fq_bufs, reserve_size);

   (or a bool tracking whether reserve_fill_queue() has consumed
   them, if the out_xsk path is folded in later).

   This predates the patch, but it is on the exact failure path the
   commit message says it is hardening, and the new -ENOMEM rejection
   makes it easier to reach.


Warning
-------

2. drivers/net/af_xdp/rte_eth_af_xdp.c, eth_dev_close()

   The patch makes "mb_pool set, umem NULL" a deliberate marker for a
   queue whose setup failed, and get_shared_umem() correctly skips
   such queues with continue.  eth_dev_close() still treats the same
   state as end-of-list:

	for (i = 0; i < internals->queue_cnt; i++) {
		rxq = &internals->rx_queues[i];
		if (rxq->umem == NULL)
			break;
		xsk_socket__delete(rxq->xsk);
		...
	}

   If a middle queue fails setup and a later queue succeeds (easy with
   per-queue mempools: queue 0 on pool A, queue 1 on pool A rejected
   at capacity, queue 2 on pool B), close stops at queue 1 and leaks
   queue 2's xsk socket and its UMEM reference, so that UMEM is never
   destroyed.

   break should be continue.  Skipping is safe: a failed queue now has
   umem == NULL and its socket was already deleted or never created.

3. Commit message errno does not match the code.

   The message states twice that queue setup "fails cleanly with
   -ENOMEM".  xsk_configure() does return -ENOMEM, but
   eth_rx_queue_setup() discards it:

	if (xsk_configure(internals, rxq, nb_rx_desc)) {
		AF_XDP_LOG_LINE(ERR, "Failed to configure xdp socket");
		ret = -EINVAL;
		goto err;
	}

   The application sees -EINVAL.  Either propagate the return value
   from xsk_configure() or reword the commit message; the behaviour
   note for the stable branches should say what the application will
   actually observe.


Info
----

4. xsk_configure(), early return leaves txq->umem stale.

	rxq->umem = xdp_umem_configure(internals, rxq);
	if (rxq->umem == NULL)
		return -ENOMEM;
	txq->umem = rxq->umem;

   The out_umem path now clears both rxq->umem and txq->umem, but this
   return clears only rxq->umem.  Harmless on a first setup because the
   queue arrays are rte_zmalloc'd, but stale after a re-setup of a
   queue that previously succeeded.  Clearing txq->umem here too would
   make the two exits consistent.

5. The capacity check and the increment are not atomic.

   get_shared_umem() drops internal_list_lock before returning, so the
   load of refcnt and the fetch_add that follows are separate steps.
   Two threads configuring queues on the same mempool can both observe
   refcnt < max_xsks and both increment.  Control-path setup is
   normally single threaded so this is not urgent, but a
   compare-exchange loop would actually enforce the limit the patch is
   adding.

6. Log text when max_xsks is zero.

   max_xsks is only assigned when the creating port has shared_umem
   set, and it is populated_size / 4096, so it is 0 for a pool smaller
   than 4096 mbufs or for a UMEM created by a non-shared port.  In
   those cases the new message reads "already at max 0 sockets", which
   points away from the real cause.  Worth special-casing, e.g. report
   the mempool as too small for shared UMEM when max_xsks == 0.

7. get_shared_umem(), the new check can use the existing alias.

	if (internals->rx_queues[i].umem == NULL)
		continue;

   list_rxq already points at &internals->rx_queues[i] a few lines
   above; list_rxq->umem would be shorter and match the ctx_exists()
   call just above it.


Notes
-----

Documentation change is accurate: max_xsks is populated_size divided
by ETH_AF_XDP_NUM_BUFFERS (4096), so 4096 * N is the correct figure
for N sockets.

Not verified: build.  libxdp/libbpf were not available here, so the
af_xdp PMD was not compiled.
