Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B782FC5DF7D
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 18:11:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9021E40289;
	Fri, 21 Aug 2026 20:11:03 +0200 (CEST)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id BE0794027B
 for <dev@dpdk.org>; Fri, 21 Aug 2026 20:11:01 +0200 (CEST)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2cf50c6f235so16276325ad.0
 for <dev@dpdk.org>; Fri, 21 Aug 2026 11:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787335861;
 x=1787940661; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=H++SEAQkeQjCNBQ3mSJ4gVtwAe61t0tO6DCkgX01Gmo=;
 b=TZjAuLIoE9uOscM4HPCM5Zdo12es34q6+e8U3X6OTSR+PfOeaFikiXsXgHLVyuTy6u
 2RhQ45iPK6iAsw3W5Y3qTHwLqnume+bY4wRxMOeetkUsdSYGAFG4TraYsdFfWnykT8Il
 eZp4WEFJLrSE0YQWmCKD0JN1g5BhW6h4Pqd5lnaD7JnMx9QurZxtqy4f/uonUnikwttj
 cj8JP7RhYJ5Izz7uG2Nm+DUa/ct2+NxY0ipbYRd21tJ+Py9ID1kZOfb+zRqs5/+pOV7h
 QxbXhWOe72kwdDVT/P2x7mZKR86ZQ08XgkgjQcG4nd0DJVhtgwakbIMCeibak6c+V/46
 xhiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787335861; x=1787940661;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H++SEAQkeQjCNBQ3mSJ4gVtwAe61t0tO6DCkgX01Gmo=;
 b=SHBjfqCWX895LjqwBnhYgj34OApORGT32j4QpLQ7/eRu9WY7VEvgl1vKABJVveL4uT
 ESn06rchG3ZXJ01HBQyjphyyDbw3R34+c63G3JJUY23FhqJvg7JJ2BJ3y28t9lmfLUbj
 HKCmmiVCb0yq6TfyE+YZYkxnm9wsj193rCxgiIoAMFyiFmuDV/wIx50xEp/5HSqa2KAt
 fKqkh4KvQWGSiaJ7HlDh85sshXUMHcwiGM6sciuj7wsS/I8NHEj/Hw92OCSsj0QIo7O4
 /LNd5gbgiW6Y6q78K+P8ypN4NZd+79xB4WL+SIaFCN213iynnNKR14wcH7gCJ0iVOsbE
 KEjw==
X-Gm-Message-State: AFuF++ktmvjPgK4SfVfN8qwKb0f3jOTUQpo9YwQvtKdaZkNj9xzXtIW+
 8uPT9IWfLWJHCmHBtFuGQLJZc+z6Vq8e38z7yct9qSSK1stn5YnzBxmTOvfMuD/qiKw=
X-Gm-Gg: AR+sD12Za0KSZylX+LW6f4Ooxw8LzWIY8rmTjJlAO2z51prvgbySjLwVcgG8+abDTKG
 rRsyUf05ACviRupXac91ml3ifxc/dqqwlIKDQRy2hiP18wZ1f+Z3VOVgFVV0IEABn36SeuvlFjj
 vAQu5Zj11MmXT1oul8tKyjfgqxlMnKDtX10mOJuIYqXDEGThJ7othd00rG8pSQgXVBT5kh8ulcR
 jh5pSQUrbbodPUgRyyY1/Lo7hQgkBajbNZijdxSkAYxl78C0oEAQ+Su5vRpFFKgCI/YB+lpYCfm
 buKSBetf+mAR6Xl1Jkwp2fST7lgLzBjozfQ92Ij14jQDhgPGii/35//zstX4nslcTraFdHO5Bul
 BH71I2kQPpEkPlTcgg2r7lxcyG+bS5w/Qt/48L9BTHLgiBLdISnfbNmnu7bOCj70kFbBhQMqmZk
 nFPGaU6caf6iqsMG6jgHgfVxFFxUw8fdZlOzK1syxSt3s5iSKL9ASvoIE1HyRLU3BVr0dXBV6qe
 MDfwndKTkHPei2Rr0ei8CW3pvhYsA==
X-Received: by 2002:a17:902:e785:b0:2ca:6eca:492f with SMTP id
 d9443c01a7336-2d64b0e2c7fmr173272305ad.14.1787335860696; 
 Fri, 21 Aug 2026 11:11:00 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d62d58a851sm22342175ad.19.2026.08.21.11.10.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 11:11:00 -0700 (PDT)
Date: Fri, 21 Aug 2026 11:10:52 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: sandeep.penigalapati@intel.com
Cc: dev@dpdk.org, stable@dpdk.org, ciara.loftus@intel.com
Subject: Re: [PATCH v6] net/af_xdp: fix shared UMEM refcount corruption
Message-ID: <20260821111052.0985727f@phoenix.local>
In-Reply-To: <20260821021607.232149-1-sandeep.penigalapati@intel.com>
References: <20260821004435.216833-1-sandeep.penigalapati@intel.com>
 <20260821021607.232149-1-sandeep.penigalapati@intel.com>
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

On Thu, 20 Aug 2026 22:16:07 -0400
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
> Reject sharing once the UMEM is at capacity by returning NULL. The
> error is propagated from xsk_configure(), so Rx queue setup fails
> cleanly with -ENOMEM. This applies the per-mempool socket limit that
> shared UMEM was always intended to respect.
> 
> Harden the failure path this makes reachable:
> - clear rxq->umem and its paired txq->umem when xsk_configure() fails,
>   and skip queues whose UMEM is not yet set in get_shared_umem(), so a
>   later scan over the same mempool cannot dereference a NULL or
>   dangling UMEM;
> - free the fill-queue mbufs that were allocated but not yet handed to
>   the fill queue when a sharing socket fails to bind, so it no longer
>   leaks a burst of mbufs back out of the shared mempool;
> - propagate the map-insert failures in xsk_configure() instead of
>   returning success, so a failed xsks_map update no longer leaves the
>   caller using a deleted socket;
> - continue past, rather than stop at, a failed queue in eth_dev_close()
>   so later successful queues and their UMEM references are still freed;
> - clamp max_xsks to UINT8_MAX so the cap stays within the uint8_t
>   refcount.
> 
> Also correct the UMEM refcount memory ordering: release on the shared
> increment and acquire-release on the final decrement, so the thread that
> drops the last reference observes all prior users' writes before it
> frees the UMEM.
> 
> Document the shared mempool sizing requirement (4096 mbufs per socket).
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

I am ok with it as is but AI still has some Info level comments.
Will take it as is, or you can revise (your choice).

Trimmed away the noise..

Review of [PATCH v6] net/af_xdp: fix shared UMEM refcount corruption


1. The refcount increment does not need release ordering.

	rte_atomic_fetch_add_explicit(&umem->refcnt, 1,
			rte_memory_order_release);

   rte_memory_order_relaxed is the correct weakest choice here.  The
   incrementing thread has no prior writes to publish; the UMEM was
   built by whoever created it, and that publication is already covered
   by the release store of refcnt = 1 at the end of
   xdp_umem_configure().

   The commit message attributes the guarantee to the wrong operation:
   "release on the shared increment ... so the thread that drops the
   last reference observes all prior users' writes" is what the acq_rel
   on the fetch_sub provides, not the increment.  Worth correcting in
   the message even if the ordering is left as is; it is harmless but
   the rationale will outlive the patch in git history.

2. The capacity check and the increment are still not atomic, and
   rxq->umem is mutated outside internal_list_lock.

   get_shared_umem() releases internal_list_lock before returning, so
   the load of refcnt in xdp_umem_configure() and the fetch_add that
   follows are separate steps; two threads configuring queues on the
   same mempool can both observe refcnt < max_xsks and both increment.
   Separately, xsk_configure() and eth_dev_close() write rxq->umem
   without the lock that get_shared_umem() holds when reading it, so a
   concurrent failure could in principle free a UMEM between the NULL
   check and the dereference.

   Both are pre-existing and control-path setup is single threaded in
   practice, so this is a note rather than a request.  A
   compare-exchange loop on refcnt would make the cap the patch adds
   actually enforceable if that ever changes.

3. Mbufs already submitted to the fill queue are still lost at
   out_xsk.

   Once reserve_fill_queue() succeeds, the 2048 mbufs live in rxq->fq.
   A later failure (map insert, busy-poll config) deletes the socket
   and takes out_umem, and nothing drains the fill ring, so those mbufs
   never return to the mempool.  free_fq_bufs is correctly false at
   that point, so this is not a regression from the patch, and
   recovering them would mean unwinding the fill ring.  Noting it as a
   remaining gap rather than something to fix here.

